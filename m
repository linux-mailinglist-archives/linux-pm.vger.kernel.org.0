Return-Path: <linux-pm+bounces-27395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55C2ABCF2F
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 08:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614AA165B19
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 06:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AF725C81C;
	Tue, 20 May 2025 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxvDIST9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C11C8613
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747722244; cv=none; b=EzSOIhfWifj7MfDQbLCioQeN4tiGTXeyz7DbVMq604oEe6RXOGvaeeK661TMcXmEnxiCEupFo+wpz3yS9PPs/ImXZT7hX9kcAnwb/NqzdJ3nTgOVHanQ+jlqg1eL1Wh9fCCE/x5qaT6Ujma+Oi7go++HExVZx0CjqSlUyjbPeqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747722244; c=relaxed/simple;
	bh=OErLSkE/m1BgaO00NjK5OW2PuAYt7QDHMHCcdsySpeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7PrsLhi25R0Mkmq3gWuhTMVhHeem1p9N23JD1AyJZSGMibTjWC62UR3UqySGebNw6Pqye+DkQvxf54BQhm6Hxwb0ABy+W1bGkJLhLRVIXIq/zTx25CF2hYnrmSEvvcVUEL7WIE7ZjHzSncFI5/gagQV/iaecUOSY71b/uTZTQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xxvDIST9; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30e87549254so5322654a91.2
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 23:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747722243; x=1748327043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOOxKXVW+mfOfzJmAX4sL2q7PTCJ7BSmtyABQv/dOSg=;
        b=xxvDIST98ZmUGClwtCZ1V8zaW6UkaSftWh70vM+tKUL5mKWJNVXfO+hWqXglXNR2pZ
         uy5c8IyRLbUyJdN7vuDdOOisyG6NCChfVX/38mQ4jje8kDpbx3zNB3eEa+26GF6uaoqO
         nkpcmhJ6I6HZePUwE1m1vpHRgyC5iu+G5hn440eWjwa4URvNlt0CkpqthPxQVA53oMEw
         liLGTmFMdGqi9ESszqHbFfdVZ4fWU89FF/ZSC25c3BflElXOw6BTJYR/F5hDEp2hnZqv
         nshJ5t6BwkN4DXHf49j788sSJbZDjKQAW5xyjU5Izh3ZpRI/1WjGvwxhAfw6Tdpwiyan
         hpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747722243; x=1748327043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOOxKXVW+mfOfzJmAX4sL2q7PTCJ7BSmtyABQv/dOSg=;
        b=NyHpG3ch3vaJprxvwI8G5zfnxFQS4ScAdZ6w4ZaRdYPnRd9BJHW7BVAsBKqdW/J004
         byZI8E++VIJsMq+DArsYmlgy3eAd3PCXrghiNaAcehYDg+C0MRSBDYuByLaEMkiXNU2c
         MyK5Rqs531dQR6utqUzneAuWjIxX4aaLDA9gB+goqNl67ovlnK2M5cNA4vL9c13VKTgI
         uRB9g8XGu2gjcLfDDFLuYledsM9HXy6mlSGskSCF1H0mm2SQr8HWPUdYf/9+xAdOpot5
         ++Lr+CXD/tWCptrheXrpFFOHW1BemMMz2VNJWKAtZ8Lu6Fr82oq/b9bqIdB/pnBgM3s0
         CWHw==
X-Gm-Message-State: AOJu0Yw+O0qKYZjxySjt8PEQ2iefU8H0uam1f9f6XJJFYj7wNzBe7eSu
	FU0KXcW9uFuW0BthV+9vSFqsGV/Qn5k/6fQV6185Kwmq4XR7+785tH+Z4oG7nGMljPI=
X-Gm-Gg: ASbGncu0pReyeSLCDuQ995EZGrtPsA1Z7+hTZd0tIqj7hYX9XwobIAQ3stAC6xkKdMc
	OMg7jNumOm7x/GJ07GuZTpdTaGFpQgnN0cGNZALs1bNRvgVreCOE74Szex+1pTMUxyBN7n+MQW6
	YCPLfliO7Mh2aYzOYHY49GABmeB0xKabTxjB51Mu+pX48rFnF1BJxCYXO7dzBmMkwt24yBle270
	UMo5CrXYXLZgk3Com/92RqiaUpJhyv2m5RKl8Xicy6PI6pJex7TSLbjiODf7GN+aI9fvV+DqAoY
	i9WYQP3mCWNP5huvCLFISoANW6rnUESAWXQxar9rUk4SE1r7+wAZ
X-Google-Smtp-Source: AGHT+IHX+LQFIfZztGFcwBpfpATN8GuvitXJDkA2u+hyNtGRg1r5lgWVjoOyMg8lPkAa6aTJv5nQeA==
X-Received: by 2002:a17:90b:394d:b0:2ee:d024:e4fc with SMTP id 98e67ed59e1d1-30e7d5bb433mr28527339a91.33.1747722242148;
        Mon, 19 May 2025 23:24:02 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36515776sm934684a91.48.2025.05.19.23.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 23:24:01 -0700 (PDT)
Date: Tue, 20 May 2025 11:53:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Miguel Ojeda <ojeda@kernel.org>, Nishanth Menon <nm@ti.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Trevor Gross <tmgross@umich.edu>, Viresh Kumar <vireshk@kernel.org>,
	Yury Norov <yury.norov@gmail.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Andrew Ballance <andrewjballance@gmail.com>,
	Anisse Astier <anisse@astier.eu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V12 00/15] Rust abstractions for clk, cpumask, cpufreq,
 OPP
Message-ID: <20250520062359.paojvjytle4yznpz@vireshk-i7>
References: <cover.1747634382.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747634382.git.viresh.kumar@linaro.org>

On 19-05-25, 12:37, Viresh Kumar wrote:
> I have queued this up for v6.16-rc1, will merge it via the PM tree soon.
> Thanks.

Sent for inclusion in the PM tree for 6.16. Thanks everyone for
reviewing the work.

https://lore.kernel.org/all/20250520061944.pl3mqw2clo2roe3s@vireshk-i7/

-- 
viresh

