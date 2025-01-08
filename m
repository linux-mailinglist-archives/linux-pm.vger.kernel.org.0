Return-Path: <linux-pm+bounces-20071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D432A0528F
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 06:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A38188796C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 05:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492AD1A23A6;
	Wed,  8 Jan 2025 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="INRR4TZw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85261A08A3
	for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2025 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736313616; cv=none; b=epe8I19tySgUdjudmG7JuGHElM1unwZVndN8BvHfvATttWywwDmrYT8IkTcD4wEOJ/loNeHFrNJDEoWcDVq9wiXxmMxQql/dyOH37qJLeFQLsqMNGiP5Mr7p1P+zvm3V/d255wn6SpqfaakJsJLRIHoDV2wnKRKH6jTRlM087RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736313616; c=relaxed/simple;
	bh=MX24MjbCoItqrQFmF1f2gtQanUEyTbfjYrntn8+urY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJkHz2YnHNWHEKkdSfUyma6F0FyxndsFjh0jcsrTg+zrSJl4RMc8pUqd9wch+ATKy6i1TZhqdPbpKBsFTUz7H88cqwG3Q8hUAOMeQbVNdI4Z42S4W+EAHWQxguYUpr3LDY69fc+ghYy04K+vdwC/tVXwPZZLYFsYBLh9CJnDjHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=INRR4TZw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21619108a6bso225769635ad.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 21:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736313611; x=1736918411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY0IuYfAI8sm4RayzU4rIp2zLi3BvvvLxHHyaxWr6Rc=;
        b=INRR4TZwC3uvFb6oBOr8eqM3TXn/8XhwRMkptG+2F2jZcC0XegYzCYnIUry0Ck0K0x
         pfeW4rrNNuj6iKZYwjVcmRFpgENKvKTFF/wAD3D4OUP+jFEgiSygG+F95H2Gxbujt8+L
         5oYauh+nbr+1zUxG8nh18FiTqb7VHMYMAk+5RpSr50z2rWEMOOPFpJJ2iAoj56KUlB0c
         L0U3GB0M9r2vnoq+J9O3k5wZuhzPIh1OM4SLlRWTpTigyV4G0hvRJkwqGfGuINVvyGtV
         RTHHh26JmFRFO338vyXYewPE9HQf2qGg6elD2PtuRJjy/AwuXA98RJCco9PVlMRxNDGp
         yA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736313611; x=1736918411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY0IuYfAI8sm4RayzU4rIp2zLi3BvvvLxHHyaxWr6Rc=;
        b=eMPbJvZZvAjy5AgdRcaUd+joyadJlT+RtRzO6URKYSt/1uafH0WZB6ClMTzgGb3Si3
         04Wy0xhWfP+tWMxUyHt7GQXiwagxdn6qzYzlgDZZfaoeXvDJkf4b6/+Q6WWQiZjcODEV
         9NbcJty8uvUifF3ak7gWBEadCK8mRTDyfDrLDhFDVMyI60u3HyVGRQr14mMxRdXgNeUm
         tRaTjjRBMfgvfz5k7XSFUs++aECkGLygGVIb5Kt+MIemGT8nI3wzPfAZ49X6XgG4F95X
         JYGyGhkpHS+XXjX9udg7sZw/GBc0gQCpokzFPlEEV5//t+lLK4LdwZzbTbUordUmXdUw
         Ak0A==
X-Forwarded-Encrypted: i=1; AJvYcCXaA/MmuMajjfYR98Yut2Y67uN/MSNqQMlHIzC+6pB61gHRefLDU0KT/0YCSNR38QqM90tczT5eLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZOMytzqJJfuAL0bbteVTH1gnDGn6toH949l1kBlOGE/FyOdRx
	Wisac9wTqAavrC977Dfu4qFCnzsnYecsjbczXZK4mlWEu/vrhB3mQ1DbptnR5Sw=
X-Gm-Gg: ASbGncus50x6vdkkz/5Nt5YMAlzWRLhz2T7nzYIlJcK58l/1fEkaPMmE+7mbyLrYoKp
	HFnkjuobcON9WTm2Bq06aCGcpieMWaC0YQWC9gA2i0ylGRzrek9/B13IbT7SibGZtRZj/xuLJdY
	C77rjfnLNhlkKV1vdZtd0zPOvDFD8loSgQ45GMMfEQ8SgJgkfyPrLA8G/jpht9rdHacJg8lVeD0
	wuZTStPD2R+jADdl0aytqQY0ZO4gHSPJ/jSjAfUfh0PMQELiferJjxhcu4=
X-Google-Smtp-Source: AGHT+IGTcFz0XedM3xo5tGeGspXIdp7OIR7mhKZqjPRmh+zb3DQX0/hAU4xCNw4BDqGU5kvaDqpI9g==
X-Received: by 2002:a05:6a00:2e1b:b0:729:1b8f:9645 with SMTP id d2e1a72fcca58-72d21feb6damr2309339b3a.24.1736313610984;
        Tue, 07 Jan 2025 21:20:10 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dd1a8sm35560445b3a.106.2025.01.07.21.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 21:20:10 -0800 (PST)
Date: Wed, 8 Jan 2025 10:50:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Trevor Gross <tmgross@umich.edu>,
	Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 00/15] Rust bindings for cpufreq and OPP core + sample
 driver
Message-ID: <20250108052008.izm5ffzgrc45ms4x@vireshk-i7>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <Z30UZwgN2nGtiTsK@pollux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z30UZwgN2nGtiTsK@pollux>

On 07-01-25, 12:47, Danilo Krummrich wrote:
> On Tue, Jan 07, 2025 at 04:51:33PM +0530, Viresh Kumar wrote:
> > I would like to get some of this (if not all) merged now into the rust/dev
> 
> You mean rust-dev or staging/dev?

Right.

-- 
viresh

