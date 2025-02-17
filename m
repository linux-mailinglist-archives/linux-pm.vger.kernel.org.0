Return-Path: <linux-pm+bounces-22188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8717BA37D48
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 09:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966A53AA609
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 08:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3411A01D4;
	Mon, 17 Feb 2025 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNZkOhAS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897D3D68;
	Mon, 17 Feb 2025 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781563; cv=none; b=ZX4W2q9SzdavRSZ26QrPbFuA5NZGFR2IJ6AR6fJhVUgPB1taQJmaK/IpgTb33OPl61rMNRWCWQGx+ZNjJ2W/fcA49MCgZ7esiivwZ6jMdbOOyHU0+2lQUSlDPLeu1QGfHUdjXgX7IT6ZKntidODHFGbRLnUv8mRUSTtuH4BDBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781563; c=relaxed/simple;
	bh=jnADFf+DfWasW7sL/FPcQ0PBXeyTihLPtIP6d/6MBw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlvLZiK0h7C5RmfkPsjAUmK9Ug0vH07BJsYjooGAZHgKA4bYHZHDH7GYXLoeykdhPWjQLpQ5/FJzHawee0mE4tJZlVoniLLqnZzQPhPvDSscqnhJ9YPmxa9eVVTnZ5jGkC3Z0zx3o8TtOwnsf79STaJlYgSI+z02sERNkbMHTOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNZkOhAS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216513f8104so8563435ad.2;
        Mon, 17 Feb 2025 00:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739781561; x=1740386361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIdVlYaLOXysVzejupmNmZ6FqJU5Yc9Lq/yMH7ou10U=;
        b=MNZkOhASORJjwra10K6y5ECOyg18mrojDXDBIdVhcyIVHr2wm7WP/Vfjp6n9OMrBzA
         OHf89RqNvSdfWHAuacLptOzGOgLLO8ZnlYzTrfLbgk3x6EbG0U9xCNKHsosWtWvOhf+i
         MBW1czAcKmUhwYYlpd8JMlIWXVjY1435o7EYTx1KVxVQncO6Cu+TQu6rilUUnkonIpuQ
         0hQmxhRe2xz8hImjTe/rLVaGINSpY99laTNx/Zb/+0eMKtRGlgbA8fxRA0F1eXgEIrJs
         mK4I9Sgjcv74x8G8kgd5WjJU/BvXORf1S5gjPPIMdicmw7+FyhAWA/tvgHHAwOeqaOj/
         ajuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739781561; x=1740386361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIdVlYaLOXysVzejupmNmZ6FqJU5Yc9Lq/yMH7ou10U=;
        b=enSOqDYRjPHyUpX6OpdDT1X8KcjARJWe5y+YqihCyjO3QoOV5rRd6EdORSCnjFbDk/
         xnIT56SKJAasYSZVMJkRCLT/cgi6sDWWckS8nOJ127S4f+gss8GqclBQZS8QQ6pfSkb4
         3QEUd1tdD2TJZysYMiulLtjD6wNjuCXKWEZqg35xZ/OpF5MLW0S4u27rEbODoMwy7xiC
         Rk00gM9KEdRvwxXRIYHRW0sk8kitaGga4XEhMXWpWln6OiTMpAuBHefhqW6CHeWRvYty
         25UDkrEzCc5OUxkn0q2ggXUx0fi8B4+dQSGOlhX1tmv+iVcpRXm/FqR+Xz99qF7uyhkR
         lQrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2bF069S1KjxWxDeJdwTum7/islVdEMZafBQO84AU3w87CCX1Zw44dcXfC0Q3yAiJ/XiQbWEP06Ap9FErF20=@vger.kernel.org, AJvYcCV3HKV82CsCkhk+M8010JnCxB7vpThQUo8EzDsCEo5xK7wvK4PKKtGmCOjEqHw28ruWj6VO11oeXmiJuZQF@vger.kernel.org, AJvYcCW/Nt2Tur+tGeWvXe/fs1wAGAOPmUwamvo4kU1N6NXbrolAIllFaxCBFlMBW5H8cGHms4LfnsekwRs=@vger.kernel.org, AJvYcCWMJ6VS6kgcafPADJrlcHhM19R7SkoasHsKuAx/YRqUL8eunhSBYyJs8F12CqBgdnFZbRUyUuiiskM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0YLTspfmlSvn2n/2zhGwTqhJa8VjiPIPAa7+2hZ0vC6IELHFs
	BkDDqxJJzurdHlV3Xds1BNtGXIJxLkHR7YgdjCwHApUoOxpbiM5zeqp+5uMLzbXVnnKl4ILN1Wd
	vCoRFynjJvxbGQGR3iIEHW9WrXpM=
X-Gm-Gg: ASbGncsasXvCn1+gQzRN9ggE9BA4CR52EJIwaHuAHbpcq4+36OFfJV8YIxyc+jZPzwe
	FbqltWF2WdAqwFnFPx61VdyTrlHgo8uu8HJatHpszT1naosN0IPHezcGkv+VzVek0DqBoAiwx
X-Google-Smtp-Source: AGHT+IEyu7M9RkjZAh3ROnAqq3aFmiYYfwU7DcTXVUkIPKb4czs40cyO74OUwz2v+DLSe464hxodd5QVVxJxVjN28Hg=
X-Received: by 2002:a05:6a21:78a4:b0:1cf:52f5:f5 with SMTP id
 adf61e73a8af0-1ee8caac771mr5733395637.2.1739781560743; Mon, 17 Feb 2025
 00:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738832118.git.viresh.kumar@linaro.org> <Z6Sgwbgfp-9SCr8Y@pollux>
 <20250207071538.xjxauatta2jsedz4@vireshk-i7> <CANiq72k4N_bD3_QxFKveyjGsSeXJX7y6fKU4EVt0hBOcq9q7tA@mail.gmail.com>
 <20250210080601.afrxidoywz4ukqdt@vireshk-i7>
In-Reply-To: <20250210080601.afrxidoywz4ukqdt@vireshk-i7>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Feb 2025 09:39:08 +0100
X-Gm-Features: AWEUYZnzYhEk6RX87YQPWmYdwjcCT6ouJI5u9C1bLKmCrT02Rtc8xj_Nc2lkiHg
Message-ID: <CANiq72kuebpOa4aPxmTXNMA0eo-SLL+Ht9u1SGHymXBF5_92eA@mail.gmail.com>
Subject: Re: [PATCH V8 00/14] Rust bindings for cpufreq and OPP core + sample driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@redhat.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Michael Turquette <mturquette@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Trevor Gross <tmgross@umich.edu>, 
	Viresh Kumar <vireshk@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, 
	Anisse Astier <anisse@astier.eu>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 9:06=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> error[E0133]: use of mutable static is unsafe and requires unsafe block
>    --> /mnt/ssd/all/work/repos/kernel/linux/rust/kernel/cpufreq.rs:632:26
>     |
> 632 |             addr_of_mut!(bindings::cpufreq_freq_attr_scaling_availa=
ble_freqs) as *mut _;
>     |                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^ use of mutable static

Ah, I see now -- yeah, this is due to:

    https://blog.rust-lang.org/2024/10/17/Rust-1.82.0.html#safely-addressin=
g-unsafe-statics

You could do (probably with a comment):

        pub fn new(name: &'static CStr, data: T::Data, flags: u16,
boost: bool) -> Result<Self> {
    +        #![allow(unused_unsafe)]
    +
            let mut drv =3D KBox::new(

Yeah, a bit annoying... :(

> I don't remember seeing a CLIPPY warning ever about removing the
> unsafe here, as reported in your case.

Please use a newer version to see them, e.g. the latest stable 1.84.1.

In general, please test patches with the minimum version and the
latest stable. The latest will give you more lints in general, and the
minimum will make sure it builds for older versions.

> It would require clippy::undocumented-unsafe-blocks to be disabled, in
> this case.

Hmm... why? We need the `allow` above because we need to keep the
`unsafe` for older Rust. But you can provide a comment nevertheless,
even if "dummy", so you should not need to disable anything else.

With your branch + the `allow` above + running `rustfmt`, it is Clippy
clean for me. Please see the diff below as an example (I also cleaned
the other Clippy warning -- and sorry for the wrapping).

Cheers,
Miguel

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index d2e7913e170b..e7c62770fc3b 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -602,6 +602,8 @@ unsafe impl<T: Driver> Send for Registration<T> {}
 impl<T: Driver> Registration<T> {
     /// Registers a cpufreq driver with the rest of the kernel.
     pub fn new(name: &'static CStr, data: T::Data, flags: u16, boost:
bool) -> Result<Self> {
+        #![allow(unused_unsafe)]
+
         let mut drv =3D KBox::new(
             UnsafeCell::new(bindings::cpufreq_driver::default()),
             GFP_KERNEL,
@@ -626,19 +628,15 @@ pub fn new(name: &'static CStr, data: T::Data,
flags: u16, boost: bool) -> Resul
         let mut attr =3D KBox::new([ptr::null_mut(); 3], GFP_KERNEL)?;
         let mut next =3D 0;

-        // SAFETY: The C code returns a valid pointer here, which is
again passed to the C code in
-        // an array.
-        attr[next] =3D unsafe {
-            addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_fre=
qs)
as *mut _
-        };
+        attr[next] =3D
+            // SAFETY: ...
+            unsafe {
addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_freqs) as
*mut _ };
         next +=3D 1;

         if boost {
-            // SAFETY: The C code returns a valid pointer here, which
is again passed to the C code
-            // in an array.
-            attr[next] =3D unsafe {
-
addr_of_mut!(bindings::cpufreq_freq_attr_scaling_boost_freqs) as *mut
_
-            };
+            attr[next] =3D
+                // SAFETY: ...
+                unsafe {
addr_of_mut!(bindings::cpufreq_freq_attr_scaling_boost_freqs) as *mut
_ };
             next +=3D 1;
         }
         attr[next] =3D ptr::null_mut();
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index b83bd97a4f37..aaf650f46ccb 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -781,7 +781,6 @@ fn drop(&mut self) {
 /// represents a pointer that owns a reference count on the OPP.
 ///
 /// A reference to the `OPP`, `&OPP` isn't refcounted by the Rust code.
-
 #[repr(transparent)]
 pub struct OPP(Opaque<bindings::dev_pm_opp>);

