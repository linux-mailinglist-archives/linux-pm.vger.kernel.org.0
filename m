Return-Path: <linux-pm+bounces-38873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E597AC91899
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 10:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8805F3AB0E6
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 09:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E5D3064BD;
	Fri, 28 Nov 2025 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHkOmX2s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D7A305943
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323752; cv=none; b=SXpA2UGgS5VWTeDLpkP3rP48yBLNlRzCzKzO398w7w0hVLt3Yt8MTjpFl5M9sek8idkrDBDWR7gM2T8GzitxN9TMVC8VbdWRFxx86SuPLhF20fdtzE86sqNV5P00rCgVSOnx0eddnG3/zZeNR+/PWQPaiF1RuMQ/CGt0xaCLBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323752; c=relaxed/simple;
	bh=Yh0qa9+7TnDcYJAi5o9Jbm9rjPvdBTg211WI511CX9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkVqa08bwhNmZLnSpoqBUNlQW4mUuIXiv6ThUOHdk0dofZJPo3a/8+E+PoUs5t3WLsDV9Q/Y3gPH4l8W9brY3e2OHUDEgv8W4okOYNqMqpBY7E47r1e6eIaceC7jYj/cmREt9CLTRLs8VFoi+YeOzexarU8SPqp++jEURYWip24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qHkOmX2s; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3437ea05540so1327075a91.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 01:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764323750; x=1764928550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1GQvR/dGLaXXvOzopxgqRz4uco6G3zBSS5BQmIwFNkE=;
        b=qHkOmX2s37bw/Mw/FgyClagkl4/zQ8c1rVor706ZWomblTbvFrWelL0DsbqMmv+BJJ
         V7dbK6dz6ygz92L2JLeqbMKE/YLf4NLyOgLP0cWaU7swe9kL97IlpuCLiCqoWdzsN80S
         LvYw35MkMjOCFEEwnULHgA9GsQXdiNXvXEUoYPitkR7AZoPjWOYOqcHvGlJFsqzkx0Da
         Uq0ybqbfNW1wVeaNCzhIffQqBkBDvg6zqbAd1JuJQIEbw36zb7+kZaFQkY3lnayhiXf1
         e2aDPw/W9h6v4sTxu9/7P4yz9gvvQ0DqwAkRM22Q1w19feHQ83HMOnxBsMrp00hf0pXi
         JBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764323750; x=1764928550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GQvR/dGLaXXvOzopxgqRz4uco6G3zBSS5BQmIwFNkE=;
        b=qVSFe6QMlQojIGS+SQMMRzn8NejyKqj8nbW94tWwdbiBOveHGho8byD0+j9PvFGCzy
         nQDhEe81SIrFbjqy5inm344tje/issCruhe/R4Xn3UsmXsH+Ta1WF9vli5Lyd2fKVlCf
         nZh3afIRC++IDIwX2X/oV8J1uOyP1SpvD/DSqZ+yRZ7VhVGr+ve81+nn8L0YYTTD1eXU
         C1Y8xcgCQoeo55RVrTrbNojEGYCiOT2zY9IbWAzbKXE6Ktm0pNyLAtsxgUP3ritz9zCI
         aiM6wKzkPhyK9F0Gfrx6VcA4mQX8DVwjdIyIwY+RVDc0/WYJ1BToKONZrZ9BvqlqVV6Y
         q2eg==
X-Forwarded-Encrypted: i=1; AJvYcCWncXmVQQkzSj6Ea1Yky0jobcReNR/0vvCindo1/jBk4vkKQ4hBlw5pLiEH/XI0WXSH3I+7MvF5xQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzycRc6pf6QSD36fg19MeJ32sSFdaxOrPsJurdzNAztsMl0X+r1
	lLi69XeuZPqt3BMdxauNK8D6Dy4AlR3ib4E+Dsqb5PVhUqmSVre1SdY26xAT6lbATbM=
X-Gm-Gg: ASbGncsfyQLetIK0llycLHzb/r3MoaAI6P8J1SZuqBWO/JuJY2XGVJnqYp8mPgln/oT
	nAKUjPRRehAS2KD836h+3xjhseiz5++jPC8wMwAq7vSBAxwuNcAkkqo17NBHJfT8ADul1vNQsXg
	qwcnzx2zIxSmEGYP73WQBlEwRkhR5yflP0gzzFSBgWEt2bpvLrZuHecEOsPIhS+S3U6xy8azBqj
	OzvhXhEBSbpDRsQNTrXSIwvQPkftkGBYQjXrJRY0geQqSAJ03IFRZQON8UUTAS7nc7xP+ekzk9d
	L+dblwcGkVwmsJUXA6YMO9O6wP/4D/JbxxQApjQRZMgJ2FotGscNPr6mkO2jEb5suwy689rQA3d
	gKkrSuqzVYiQu3X4QhM9VAM/3pDh54zVyYhwVM7URMWDYPoCB2gpn6HiR+kNvkR7jPA8ZzVxFZx
	GbgV8N5soofCU=
X-Google-Smtp-Source: AGHT+IHVI3H13LgN3uGIrowpvtCCzadADr6HEh7p6FG1497Y5qGScUqwnaT2Tt4XLibuJQzW97Ij8A==
X-Received: by 2002:a17:90b:540b:b0:343:eb40:8e01 with SMTP id 98e67ed59e1d1-34733f4ab79mr29222159a91.27.1764323750109;
        Fri, 28 Nov 2025 01:55:50 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-347600c9180sm4104512a91.13.2025.11.28.01.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 01:55:49 -0800 (PST)
Date: Fri, 28 Nov 2025 15:25:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/7] rust: cpufreq: always inline functions using
 build_assert with arguments
Message-ID: <4govqgwq7yd2dbymkw622usjgiebfzulm2wmsnjje5q2vku3kf@3dap2mxn4wxa>
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-3-a9ea9ce7d45d@nvidia.com>
 <zis5k4oo3kq6dykzm3kav7rlblqvvnk43mrcvlwyxxfgwbpmjt@6r3f5432vr45>
 <aSlsQmiSCC2ZdfLr@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSlsQmiSCC2ZdfLr@google.com>

On 28-11-25, 09:32, Alice Ryhl wrote:
> On Fri, Nov 28, 2025 at 11:42:55AM +0530, Viresh Kumar wrote:
> > On 28-11-25, 11:11, Alexandre Courbot wrote:
> > > `build_assert` relies on the compiler to optimize out its error path.
> > > Functions using it with its arguments must thus always be inlined,
> > > otherwise the error path of `build_assert` might not be optimized out,
> > > triggering a build error.
> > > 
> > > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> > > ---
> > >  rust/kernel/cpufreq.rs | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> > > index 1a555fcb120a..df5d9f6f43f3 100644
> > > --- a/rust/kernel/cpufreq.rs
> > > +++ b/rust/kernel/cpufreq.rs
> > > @@ -1015,6 +1015,8 @@ impl<T: Driver> Registration<T> {
> > >          ..pin_init::zeroed()
> > >      };
> > >  
> > > +    // Always inline to optimize out error path of `build_assert`.
> > > +    #[inline(always)]
> > >      const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
> > >          let src = name.to_bytes_with_nul();
> > >          let mut dst = [0; CPUFREQ_NAME_LEN];
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > Lemme know if you want me to pick this instead.
> 
> There's no reason these can't be picked up independently, so it would be
> fine if you pick up this one.

Applied. Thanks.

-- 
viresh

