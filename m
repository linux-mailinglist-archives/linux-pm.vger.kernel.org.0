Return-Path: <linux-pm+bounces-21652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F02A3A2E602
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 09:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D853A8545
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 08:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E861B87E4;
	Mon, 10 Feb 2025 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2/20IKR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64EE1AF0AF
	for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739174767; cv=none; b=YFxxjw56uhdDdqzogL1HfVn5R0oocCB8KVJN1IzIa3TT1zXzvenBXGZbkc6Rzv0TZZGdij0q7bhLFghGsjjtsq0KQrEL/ohbZ2b7V/tIlxL5yep3c9Dp2ffbPmLZMKRYPQu/burUatn8Htso5rsZyRU700ShMLDtKwLsOXVgeN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739174767; c=relaxed/simple;
	bh=5WB/xN4I0+Le1mu5gDHsjLNT2znP0CA6bOhx+6FlUhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Irc/XKx3wfoKMAUZCxipc3GAFLu4LgXEOaZU/PRno7zau/sAdQfrHMpbYbvfVKAotq9UNHQzJmqOliYUWQ+uH+TmoQpPxEyDCho/zoeEf+2RLm1orhcDlkLe0XlFOX/PNuxreaa5BV+Bj6FkOu7LOl9FoB+aWoSUnhyiSMw5sM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R2/20IKR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f49bd087cso49806515ad.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 00:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739174764; x=1739779564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQjHhBqGj5IZ+lWQctqtiLtMtAyUEzvqFMG/1MA1FoQ=;
        b=R2/20IKR8LpM6+FYQCBJN/vco5x2msQAZRbUEXjagUkLShkEex6acjhasgHRoRN+QS
         LgWLwUrCMuWqt+JbOXc1LPSDAIyMihJRtMb5PBiPoxJXnmYw/uack01en3SfFn0ZivmH
         1Ih0tXIBOBy8ERi/SaArqEu23XdSiQmAtmF7/aDnkyF/1w5fjRLyD8zYQak3lFLqPJCY
         pWqOZoeZAvKIOqidY98gLzAiIS6JQJK8A0OnDCpa95iOFeLlUtltQvY51F/OgOErnxrp
         82tjniAeFPR7pxc1GRxJq1FF0uTwFocMEjwpjvQpyaYzPhgBWCLwHzG7aSOvDSMpTOeD
         GdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739174764; x=1739779564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQjHhBqGj5IZ+lWQctqtiLtMtAyUEzvqFMG/1MA1FoQ=;
        b=YQzGhEZuF3pmJQE9m6jxKcLnixlVs0fItxsKcaPWGOFxezC2I6YxS+w7wJE1gGeZ01
         dbUXjbk9GPEykDeuzATwCDH4ALskPbz4tnd1SL/52AjDjZ/p/3j1nU6g1EX78BnX6QEB
         iURsKvNkPr16lpJoZh3fV+MqEi/ydtNWzjXryNUXqkbvPKkPT5iqGwpmdRvID94jjhQJ
         G+Kte8kmgTxHMuAmpP8zXC47TnV9q1c+ukCX9mlgkj3jZt5AdHcysziXmbHkgf1b8ybI
         sw8wPOYjmI7/gQss6KT4emWiMPnB+TJrZMyqLDoJ0j9eHJIC6EgOdfZDUD96Ep5o64VO
         kuPw==
X-Forwarded-Encrypted: i=1; AJvYcCUnMrJfT4IPw3Su5XtoVl1O+AH1BiQlLvvUdj+P+q5xxb0AP1yHJrx0B01MYGMVU5TjjOoiZ1ZUkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyukWWuwqEYixjg6v0OW1/R5SKKzDlvubuy5oHySz85lHR116V
	oojVcprUabEK3X/VvAFXmvt/6SEW+0yx8Iv1CuMDoJMh52qYJJ3CS20JQ12/4AM=
X-Gm-Gg: ASbGncu1vEEkDTan7jLVXSfrqpy2sz9ts7prLM3UF5+caGmb9uK+J4RaFEIjTiKDLYj
	bWNnJqIOC3uwbJJnYcCXURKI3owCfzyIlqAIRuq9SKkBNJCMec3VHGve74gw+cyJbkCWNoaMTKS
	7yatB6v67Q8ckqfEDG4uTD2NEp2UnIdW7bpBo/3ro3ZsDXZeeckuGjfN/tcDzj9/iiV9gIKDOFo
	kXiOeaHjnioKhcQyab0XA5lU9T6oPBcK+h/Oe1aFNjlvamL+Z7w2F3Jov8OdaZuG7Atn8PyUNWd
	u0jBp7FnseeXWrVh8w==
X-Google-Smtp-Source: AGHT+IFq5wp0CMK0YMZ+JeRZQs6mquvHCQKLzwwMogSPHJ1odDnDs2wNVqpJPZZfSlztYEGJOAUAeg==
X-Received: by 2002:a17:902:e848:b0:215:83e1:99ff with SMTP id d9443c01a7336-21f4e6d255fmr173960985ad.27.1739174764103;
        Mon, 10 Feb 2025 00:06:04 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d58fsm72231715ad.122.2025.02.10.00.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 00:06:03 -0800 (PST)
Date: Mon, 10 Feb 2025 13:36:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Miguel Ojeda <ojeda@kernel.org>, Nishanth Menon <nm@ti.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Trevor Gross <tmgross@umich.edu>, Viresh Kumar <vireshk@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Anisse Astier <anisse@astier.eu>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 00/14] Rust bindings for cpufreq and OPP core + sample
 driver
Message-ID: <20250210080601.afrxidoywz4ukqdt@vireshk-i7>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <Z6Sgwbgfp-9SCr8Y@pollux>
 <20250207071538.xjxauatta2jsedz4@vireshk-i7>
 <CANiq72k4N_bD3_QxFKveyjGsSeXJX7y6fKU4EVt0hBOcq9q7tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72k4N_bD3_QxFKveyjGsSeXJX7y6fKU4EVt0hBOcq9q7tA@mail.gmail.com>

Hi Miguel,

On 07-02-25, 12:07, Miguel Ojeda wrote:
> The warning is there even if you don't run `rustfmt`, and it does not
> look like a bug to me -- what Clippy is complaining about is that you
> don't actually need the `unsafe` block to begin with:
> 
>     error: unnecessary `unsafe` block
>     --> rust/kernel/cpufreq.rs:631:22
>         |
>     631 |         attr[next] = unsafe {
>         |                      ^^^^^^ unnecessary `unsafe` block
>         |
>         = note: `-D unused-unsafe` implied by `-D warnings`
>         = help: to override `-D warnings` add `#[allow(unused_unsafe)]`
> 
> since those operations are safe. Or am I missing something?

One thing you are missing is the right branch to test. I mentioned the
wrong tree in cover-letter (though I don't remember getting above
errors earlier too, not sure why you are getting them) :(

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git rust/cpufreq-dt

This patchset was generated correctly though.

I don't get anything with CLIPPY with this branch, with rustfmtcheck I
get:

         // SAFETY: The C code returns a valid pointer here, which is again passed to the C code in
         // an array.
-        attr[next] = unsafe {
-            addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_freqs) as *mut _
-        };
+        attr[next] =
+            unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_freqs) as *mut _ };
         next += 1;


If I make the above changes I get following with CLIPPY:

$ make CLIPPY=1 ARCH=arm64 O=../barm64t/ -j8 CROSS_COMPILE=aarch64-linux-gnu- CONFIG_DEBUG_SECTION_MISMATCH=y

warning: unsafe block missing a safety comment
   --> /mnt/ssd/all/work/repos/kernel/linux/rust/kernel/cpufreq.rs:632:13
    |
632 |             unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_freqs) as *mut _ };
    |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    |
    = help: consider adding a safety comment on the preceding line
    = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#undocumented_unsafe_blocks
    = note: requested on the command line with `-W clippy::undocumented-unsafe-blocks`

warning: unsafe block missing a safety comment
   --> /mnt/ssd/all/work/repos/kernel/linux/rust/kernel/cpufreq.rs:639:17
    |
639 |                 unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_boost_freqs) as *mut _ };
    |                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    |
    = help: consider adding a safety comment on the preceding line
    = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#undocumented_unsafe_blocks

warning: 2 warnings emitted


This I thought was a bug (I may have seen this with other Rust
projects too, from what I can remember).

If I drop the unsafe here I get:

error[E0133]: use of mutable static is unsafe and requires unsafe block
   --> /mnt/ssd/all/work/repos/kernel/linux/rust/kernel/cpufreq.rs:632:26
    |
632 |             addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_freqs) as *mut _;
    |                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ use of mutable static
    |
    = note: mutable statics can be mutated by multiple threads: aliasing violations or data races will cause undefined behavior

I don't remember seeing a CLIPPY warning ever about removing the
unsafe here, as reported in your case.

> In any case, passing `rustfmtcheck` is a requirement. So in the worst
> case, if you do find such a bug in e.g. Clippy, you may always
> `expect` or `allow` the lint or disable `rustfmt` in that region of
> code. But that should be really rare, and in such a case it should be
> reported upstream.

It would require clippy::undocumented-unsafe-blocks to be disabled, in
this case.

> I also found other build issues in the branch you mention in your
> cover letter, so please double-check everything looks good before
> adding it to linux-next. Please also make it Clippy-clean.

Sorry about that, maybe there were other issues with the earlier
branch. Can you please try again from the tree I mentioned above ?

-- 
viresh

