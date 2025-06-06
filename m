Return-Path: <linux-pm+bounces-28175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3E9ACFBE9
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 06:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0ED77A34CC
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 04:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E86619F12A;
	Fri,  6 Jun 2025 04:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPvErT3v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3BA3234
	for <linux-pm@vger.kernel.org>; Fri,  6 Jun 2025 04:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749183550; cv=none; b=H73JBYc5GZVivNDZ0gtIIBDqFXIBk3dATuvE0bU5QwwQpzD1XH5R2L7LvG/Pw/Z4Uja3tuT4O9UDvYviItP6NQkICdFOgqsrcmT9EyJT7xJgKxRw9kGn9Rb+JZLOStvLV+zam/Dos3GmOXsfKWAV6OhErrJBHlkOZx6HvNWgfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749183550; c=relaxed/simple;
	bh=o4abm83KhcX/5c/veDlyP/zoZnmewDi2a5Q046z8zEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGAkkPLtXt4JgzRP/7TbyFvXUezGj1x5dw7MYyX0jrAO1ZTmcV80EX9LB2qPZrBjm0FNffHghWKqDg3gFiYiTOsfbubG2LVGVDhrZWXtwoE9zGvixhihl3Yszcu3qrtICL2e8C9S81fkTkDAww5DGyiXOecbfYb4UeiESzDfc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yPvErT3v; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c33677183so15495585ad.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Jun 2025 21:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749183548; x=1749788348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xUTI80lWcRXNjZ88XXY8GFQIEPWXmof1Egz2/hSjiZw=;
        b=yPvErT3vW02iG73N1mkQvfpATCr37g2hAIizKFYP7/NXIO6T0SrW6tsc1ne/A/aEfa
         PI09n5HgojI6D0TmAh0A4r29ZIIgX9TuJNbEaDLi3iZ48DESaLqDKd3qFy4Y0N3/z435
         IhEQ6V3oFm97jK/nkkCCnoN5JTegNU3qE0WQoy8JR6EjrUrjWfJQz7ofZj0iA7jlMcTc
         RMn0Fq4QdX6266zgCO4zItNqSQyQ+ZJVVprlfH6IiKliNtje5kRxvvS2L/a7oS+URFuv
         xX4Xy6MMPfmWSR95x/Nu5MTjFMivccYZKzb3642NTYZBKf25y1pslKpwfl1rdU+iThOh
         9+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749183548; x=1749788348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUTI80lWcRXNjZ88XXY8GFQIEPWXmof1Egz2/hSjiZw=;
        b=TI+ZpN+ejEMqA47IYpq2GIh9e4YmKRIQRksuUUXxIDCtquQIiWx0Tx8aJ2kpdbK5hy
         x+WrlBLcobEvOo7Sejz69/JqorO6oJFrFOpdXwadeuCzw4GWNPN7V2dQ//PQEwKEA3I8
         NAIgXwtaHwbzef6Bt5M2GbZZAJ4Y/kq7UOS5SMC8Okj8wkBw7TXDgOOHPmOiwjIzF33t
         gOahyHLwkj8Wdr7LG0LMBqb4wWGoNyH2RsPJkU6zFhOyN6MldTHn2pIzgyEXXIZrx6zt
         N9HHhu1xNqkzSLErG7MWqeBu8OVHTPck5r8hcTEpx+fA7EVISGjVBMH7SI7w7bC16pxG
         wzMg==
X-Forwarded-Encrypted: i=1; AJvYcCUP/VEc285Mb95ref5IzKfhdHTabaT/srVCeLM7D0XQsUOaQS711JvDkKJrb3BYuaYVtryogMXF+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww4GaYLgHT6IXbYBmPb5+bHqA7RkXhlGugT8D8AbXJOzSQPqtJ
	DX1Bo22OLyzWPg3m2oX467sLTFAdCUYfytiWVR4rgX2N5OQAD8CASDZdY6HpxPQDhZA=
X-Gm-Gg: ASbGncuCHljn/lILYK71ncsTKXsOZSiZOmyIIzZUmDPCuLMavAKAdBlLaRzeDWXUX8h
	HnRGGvaTn6ssCIo99QDTwipyejFQnhh/3Tg8lvCnz5VjB2URlBuzDlY1T7f1qnbrZVT2X92Zpbm
	85G7mTxfRxsh8PhJ+d9hKc5gd6gRB1SWlGPln42c4y4h+zHLh4qNB3m5mD+fuRlUzwPWMoYcRXI
	D1cjTfjfWkMG5H17Ah1PL0wGOtsixt91wjbNAgIDZb3EhbBZ7g+6sBcrEExpqSIobJj/l4Bq6w8
	dsWdN+AoVeOI3yXuBFm7mHEEAiZkoPCBxB6PMfOxelTJmuiOffAw
X-Google-Smtp-Source: AGHT+IGzgVo+9iJ8+pGbStrfqIojnnqwOZeq5s8p51j8fnc0ghBhaDbG4KoHtQPh1UGLy5Ce/aq75A==
X-Received: by 2002:a17:902:da8c:b0:235:2e0:aa9 with SMTP id d9443c01a7336-23601d24441mr27452635ad.14.1749183548029;
        Thu, 05 Jun 2025 21:19:08 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603a6723esm3349595ad.252.2025.06.05.21.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 21:19:07 -0700 (PDT)
Date: Fri, 6 Jun 2025 09:49:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
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
	Yury Norov <yury.norov@gmail.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
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
Message-ID: <20250606041905.zgjb2vxpwbpjhlzs@vireshk-i7>
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

On 05-06-25, 21:41, Andreas Hindborg wrote:
> I was testing an unrelated patch and found this kunit failure in
> mainline today:
> 
> [19:45:34] # rust_doctest_kernel_cpumask_rs_0.location: rust/kernel/cpumask.rs:180
> [19:45:34] # rust_doctest_kernel_cpumask_rs_0: ASSERTION FAILED at rust/kernel/cpumask.rs:190
> 
> This is for arm64 defconfig. The test seems to passes on x86_64.

Posted a fix:

https://lore.kernel.org/all/8b5fc7889a7aacbd9f1f7412c99f02c736bde190.1749183428.git.viresh.kumar@linaro.org/

-- 
viresh

