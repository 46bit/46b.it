---
title: An introduction to Comms
layout: post
excerpt: >
  <p class="intro"><em>This post introduces my experimental Rust library, <a href="https://github.com/46bit/comms"><code>comms</code></a>. Comms makes it much easier to build asynchronous servers with Futures and Tokio by implementing common operations in reliable, convenient code. There is a lot left to do but the functionality presented here is working and most is well tested.</em></p>
  <p class="intro">When building network servers you're working with packets across a network. These are inherently very complex, so we use the TCP or UDP protocols. These are inherently complex, so Tokio implements <code>Encoder</code> and <code>Decoder</code> traits to process bytes into something higher-level.</p>
  <div class="language-rust highlighter-rouge"><pre class="highlight"><code><span class="c">// Send a hello message and then wait indefinitely for a message.</span>

  <span class="n">client</span><span class="nf">.transmit</span><span class="p">(</span><span class="nn">Msg</span><span class="p">::</span><span class="n">Hello</span><span class="p">)</span>
    <span class="nf">.and_then</span><span class="p">(|</span><span class="n">client</span><span class="p">|</span> <span class="n">client</span><span class="nf">.receive</span><span class="p">())</span>
    <span class="nf">.and_then</span><span class="p">(|(</span><span class="n">client</span><span class="p">,</span> <span class="n">msg</span><span class="p">)|</span> <span class="p">{</span>
      <span class="nd">println!</span><span class="p">(</span><span class="s">"Received {:?}"</span><span class="p">,</span> <span class="n">msg</span><span class="p">);</span>
    <span class="p">});</span></code></pre></div>
---

<p class="intro"><em>This post introduces my experimental Rust library, <a href="https://github.com/46bit/comms"><code>comms</code></a>. Comms makes it much easier to build asynchronous servers with Futures and Tokio by implementing common operations in reliable, convenient code. There is a lot left to do but the functionality presented here is working and most is well tested.</em></p>

<p class="intro">When building network servers you're working with packets across a network. These are inherently very complex, so we use the TCP or UDP protocols. These are inherently complex, so Tokio implements <code>Encoder</code> and <code>Decoder</code> traits to process bytes into something higher-level.</p>

## Working with a single connection

`comms::Client` is rather simple conceptually. It stores a connection to a client (generally a `Framed`-wrapped `TcpStream`) along with an identifier for the connection.

<!-- ``` rust
// Sometimes we use an unidentified `Client`. Here we set the ID to an empty tuple `()`.
Client::new((), socket)
``` -->

``` rust
// Send a hello message and then wait indefinitely for a message.
client.transmit(Msg::Hello)
  .and_then(|client| client.receive())
  .and_then(|(client, msg)| {
    println!("Received {:?}", msg);
  });

// If using a raw Framed socket, this is very similar.
conn.send(Msg::Hello)
  .and_then(|conn| conn.into_future())
  .and_then(|(conn, msg)| {
    println!("Received {:?}", msg);
  });
```

Receiving here blocks forever, or at least until the underlying connection drops. In general you want to use a timeout:

``` rust
// Send a hello message and wait 5 seconds for a message to appear.
// Disconnect the client if no message is received.
let timer = tokio_timer::Timer::default();
let timeout_duration = Duration::from_secs(5);
client.receive().with_hard_timeout(timer, duration)
  .and_then(|(client, msg)| {
    println!("Received {:?}", msg);
  });

// The code for doing this with raw `tokio_timer` would be much nastier.
```

Sometimes we don't want to disconnect the client if no message is received. We just want to wait a little while to see if a message is received.

``` rust
// Send a hello message and wait 5 seconds for a message to appear.
// Keep the client connected if no message is received.
let timer = tokio_timer::Timer::default();
let timeout_duration = Duration::from_secs(5);
client.receive().with_soft_timeout(timer, duration)
  .and_then(|(client, maybe_msg)| {
    if let Some(msg) = maybe_msg {
      println!("Received {:?}", msg);
    } else {
      println!("Timed out without receiving a message.")
    }
  });

// As I understand it, this is yet to even be possible without a custom implementation of Future.
```

## Working with many connections

Where my library shines is in working with many client connections. It's very common that we want to communicate with lots of clients at once.

``` rust
let mut room = Room::default();
room.insert(client0);
room.insert(client1);
room.transmit(Msg::Hello)
  .and_then();
```
