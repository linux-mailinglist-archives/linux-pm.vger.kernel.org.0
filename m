Return-Path: <linux-pm+bounces-28170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EA1ACF898
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 22:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1303AF9E7
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 20:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B8320468D;
	Thu,  5 Jun 2025 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L83jCFko"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0417548;
	Thu,  5 Jun 2025 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749154341; cv=none; b=kdnJwBtE2uDPX2jh1hvqgGfsPd0OslvLoNK/uZEoPm+/gKd2mIIji07oc0TOnfnFo36B5yg1gsC8pNndf7u2cs3Lt1wR3eZAppHnqRvTLwwu6UAS5dGg1TlFhZmOt7VnLIv9h4hIY9bqb+bgGTHOLO/4aEEy5hv2nvTUddccYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749154341; c=relaxed/simple;
	bh=QB6a6QnZCJvmdCt4kElU/V09bx7MQ+aZo5RGGO0uw5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmeVmoDTCXb5pSR7JWaVYuEmzdGjsTia3aZ8HsQotkOGuIKxsudVyuGIuRtxHcL5iyAzezmfEX9h+Yd9ADwaN5NDat1+kpGIWhadFEgSmBpw3VtDmNEP1zxf76TJdxRHTIyvDu9sv7lOm988ktVBcXdZ9KMl8rB4ZOGDXxRbNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L83jCFko; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a43e277198so11097171cf.1;
        Thu, 05 Jun 2025 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749154335; x=1749759135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJx0420e5t7bqEmHlvjgSHZCEQopSee7LNPR+zkXs+0=;
        b=L83jCFkoYJ+IpEWt1YPfsW4d9nhUmb6HYiovy36Jb8G7/QneBgIoo96kvV6N3cZHBL
         o0fSNcoi3NTssjDRALLVXa0YZh88FpXqbcxn0u+qyhzz0saAcec7Wq5ZvZ9oKstezvcG
         /8wZ0WagHOqZxQTsLE9VILEe0fl7BsdeWbb/HiMARKFGYe69ttZnrI9yNO7ubi+KDZOh
         YpElDzJZ7pcEzeDtOQh7n7Dxh85OL6SM7wWW95Gc1Ow2hrHRxM84dYUuNikQ0ktR6bM1
         6RFVwMSqPUV1sN57RNQ6HsYjUExi0CReUcw6Pzs4hPHtVjgjtXX/Azol1cktfSHWZTAk
         Q7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749154335; x=1749759135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJx0420e5t7bqEmHlvjgSHZCEQopSee7LNPR+zkXs+0=;
        b=eWFBphgwQKyKTRHH07UJuolAIBpCseY9o6Ts4qMu/GRcLAPWZETvq2fbshJGbEAxtg
         KvjZg6Rq97ZhA6l0YL/dVwjdG8JOPze12OQjNSFmUA/gTJITvGQDoqYxQx4iYjE+isTR
         jJDJhlNSRYJl4xfbEaR+j9jq+Ki9pFvHbFU6wAWuTKQ2M6ODJ8MARlXuHaU3+LazPuJ5
         x8yqAFUrqLRJmfYzlpQOlcFWWxhMwUPtqYQ5kn5RVSk2PKDyAp7RvTVyeCIqev9C36fY
         RLl/7zUGd46AO1dg9HeMeHcNKgkEyQpFAN0Ua7dffAVlp86bWpaXl6FlLpZWhAFwxndJ
         M4Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUA0j+SNjZsghoiXrNgTKN4dKrXXgTXElbr/HUiFHCKeiiykJBfRSULGhN2f7rXLAlqAoHK/Hi7gqlLDRr+@vger.kernel.org, AJvYcCUc/GGSSfUADNa6mhZnVuWW2CAGVCt/ZhEflaRul3+wZj+iEwF9nEUEGZFTrUuwviW9jMF24yMqvEnf0lXt4qE=@vger.kernel.org, AJvYcCVs4K7V+dQvvGnvKPWTOsRFFbadIFYk5txBrB96EAlk0qHal9abwy2ASCiFXW8mj6RX9S+sJnJRm0M=@vger.kernel.org, AJvYcCWxVLRXvKRy5/Y47HaYjP7qTq3zG1BJn7u6oeu9pDIR50fSe0uJUm+lbzXoeqFcorwTvPhCBMCUxJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzU22RSL8fMYXCb231OTnEMAe4XJ6+jpiXPifkMj9ujJpiGXfC
	aUZtV4k//fwA6IQqYk/V8FHwB00Ah3hY38WPX6UJIu5IbUZZEKX4RHq7
X-Gm-Gg: ASbGnct1D7XJdQA9yLDfaBDlI5Mdqz4gHR/+YT6/CHFel97ZtQQgKhENRe7rFDemXuM
	ynsAQrmZ1NOp/pPq8W1aWkBZlL9pVF+ngPoBu4xx2KAz26UtIIINNlW0zxtrHujHCqrFCyr3umh
	6W+x80+PW39N0TOq6Gr5pR9MRgUfo3iwt+dFhIeGZcW3C1UP8FfelDwrrRh4i2mJQ1A+EJ9Oi0P
	0qLwGoyx6bCx3Bfs0pexFLCtWW3BkUfBWq8XKZiB0eXMjbAVbALbhWeynzLw6Ew8nPvGAwqBTTU
	JEU88O1Bj054oGW6zzL3uKFTzV68U5QLgdeW9uR1YoqzhAzP7BJNwxlEf7qdeTQTYKWMae78HyT
	VcA6yhPThvREpZ50pNkN9Q+YnST0SyDrNdhE8VHWaF5aF07Tz99wVXUsMC8+rNGY=
X-Google-Smtp-Source: AGHT+IFULRUPzojdAaDpJFce5F/nNf251w/kMWFq6JSJs64ILjSjzEyM96+UXUR1hLnTgTg/n3Hrmw==
X-Received: by 2002:a05:622a:1f92:b0:4a1:630b:e12b with SMTP id d75a77b69052e-4a5b997134dmr16457021cf.0.1749154335444;
        Thu, 05 Jun 2025 13:12:15 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a611150018sm661281cf.8.2025.06.05.13.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 13:12:14 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id BCB961200068;
	Thu,  5 Jun 2025 16:12:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Jun 2025 16:12:13 -0400
X-ME-Sender: <xms:HfpBaHek2lw76evY09i3114OHnWBm9i7e-N8O3cSxkMH80HHN8e1qw>
    <xme:HfpBaNMMhRCPkkzA0u_lEJ2KwhR3VI5mdas70RqftcZNp_Ykuj9DvHN57hhpXECyb
    Yr0z6tsQuDxt2zw8w>
X-ME-Received: <xmr:HfpBaAhgEFY3SGfyVwtZj7339fAXTAtXyNI6TcRVtWoAL7fOXnC7VeZxYnrV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeefiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghs
    hhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhn
    ihhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrkhhrsehrvgguhhgrthdrtghomh
    dprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggvnhhnoh
    drlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepsghjohhrnhefpghghhes
    phhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:HfpBaI9_gxe5GPy-ctI7fs4NiLvFIggIaOO1prxOcVMUV_LznvvxgQ>
    <xmx:HfpBaDuOr_05watrBth21FJwCWYgogve-nGg5qK5atkXWcKd33euQw>
    <xmx:HfpBaHEt04awxE2CVByaIMY37pfxj8PRUlxrWRZ7yZ7jVRkprDMMOg>
    <xmx:HfpBaKNwh3dPmy5vrsh6fn34OFHrpWIZvI2Ba26_Q_zI4iGVAMjcQw>
    <xmx:HfpBaEM00swxWy-lnZ7sU36wnF4owWgCBK0R65ceuJe7-bss_u6JVe7M>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 16:12:12 -0400 (EDT)
Date: Thu, 5 Jun 2025 13:12:11 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,	Benno Lossin <benno.lossin@proton.me>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Miguel Ojeda <ojeda@kernel.org>, Nishanth Menon <nm@ti.com>,
	Peter Zijlstra <peterz@infradead.org>,	Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,	Trevor Gross <tmgross@umich.edu>,
 Viresh Kumar <vireshk@kernel.org>,	Yury Norov <yury.norov@gmail.com>,
 linux-pm@vger.kernel.org,	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Andrew Ballance <andrewjballance@gmail.com>,
	Anisse Astier <anisse@astier.eu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V12 00/15] Rust abstractions for clk, cpumask, cpufreq,
 OPP
Message-ID: <aEH6GzCTgXZSneHt@tardis.local>
References: <HVTDJypFNQFfSQJmmYDSPU4o-irFnjmDN22RW3S0z5Kwe_hVk9kquZWElv-C2k6d5kOIiewhj_Xo2kAoTHbHgg==@protonmail.internalid>
 <cover.1747634382.git.viresh.kumar@linaro.org>
 <87qzzy3ric.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzzy3ric.fsf@kernel.org>

On Thu, Jun 05, 2025 at 09:41:47PM +0200, Andreas Hindborg wrote:
> Hi Viresh,
> 
> "Viresh Kumar" <viresh.kumar@linaro.org> writes:
> 
> > Hello,
> >
> > I have queued this up for v6.16-rc1, will merge it via the PM tree soon.
> > Thanks.
> >
> > This series introduces initial Rust abstractions for a few subsystems: clk,
> > cpumask, cpufreq and Operating Performance Points (OPP).
> >
> > The abstractions cover most of the interfaces exposed by cpufreq and OPP
> > subsystems. It also includes minimal abstractions for the clk and cpumask
> > frameworks, which are required by the cpufreq / OPP abstractions.
> >
> > Additionally, a sample `rcpufreq-dt` driver is included. This is a
> > duplicate of the existing `cpufreq-dt` driver, which is a
> > platform-agnostic, device-tree based cpufreq driver commonly used on ARM
> > platforms.
> >
> > The implementation has been tested using QEMU, ensuring that frequency
> > transitions, various configurations, and driver binding/unbinding work as
> > expected. However, performance measurements have not been conducted yet.
> >
> > For those interested in testing these patches, they can be found at:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git rust/cpufreq-dt
> >
> > Based on 6.15-rc1 + rust/devres dependencies + PM/cpufreq dependencies.
> 
> I was testing an unrelated patch and found this kunit failure in
> mainline today:
> 
> [19:45:34] # rust_doctest_kernel_cpumask_rs_0.location: rust/kernel/cpumask.rs:180
> [19:45:34] # rust_doctest_kernel_cpumask_rs_0: ASSERTION FAILED at rust/kernel/cpumask.rs:190
> 

I assume you run it in a VM? How many vcpus are you using? I've checked
the code, cpumask_{set,test}() can set or set bits out of nr_cpu_ids
without triggering warning if CONFIG_DEBUG_PER_CPU_MAPS=n, but
cpumask_weight() only examine nr_cpu_ids bits. So if you run with
nr_cpu_ids < 4, the test case may fail.

Regards,
Boqun

> This is for arm64 defconfig. The test seems to passes on x86_64.
> 
> 
> Best regards,
> Andreas Hindborg
> 
> 

