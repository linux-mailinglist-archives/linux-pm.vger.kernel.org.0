Return-Path: <linux-pm+bounces-25534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF09A8B693
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 12:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F861901CA4
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 10:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BBD2459D7;
	Wed, 16 Apr 2025 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTJ+KGHR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA15238C10
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798651; cv=none; b=b9Q+1ex60jIAPvXZ+dUnDwhe8ETRir8kkD22O04uj840yvaOYqpPIyy/XlEvHDs96RVAoUmii/rQ8EWyRIqfuDHeoyeTkBXkYjUQHulXYx65an6vZbJhUUkklDVzwsTuAXD9tDeDxf7VzYgg8a/6RoiAP4JlnnGeoRFp48dYiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798651; c=relaxed/simple;
	bh=XmWerUv6DAZOzlCQim89TVXi8/uwr6MnEEJG0S01SjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjWju0wkuVf24FfkVSpOARuhU2NXRANliNFWU12oOhT56k3/DDgbzfDgw4gLX8vyU9UtVsspJkoD1qa7sfvPYApwwmJaL2aySHR6X5eYLsFEfK207LUBUN5ZA7LRcsEcUrTMZp7lfFgHLofGE1nqwCetVPvlzLo2utncunMwEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vTJ+KGHR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-227cf12df27so4746715ad.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 03:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744798649; x=1745403449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/ANKiJhFvihbg1XVir8LGKcyLP9qIkWBCOvxZUsgt0=;
        b=vTJ+KGHRkCySfO0ivP/SlYnPokydPCGY/eut3rWHB3qhHZQsBQ3Zr/85IqxjG0fCLA
         JQykRWn/X20NH2Va3JBg1PxemICdXYREKOchjPPa7EWNoZ34zWI/sweftkzUkcTH4vc/
         jJu58OopEC5eBgvl6nx869lR6VjhFmY/7RLBD9p4rNXInkpoFffpq0FTydSNq28HrEQz
         pWja/9ABDBIj8bPrvAs/HDJOTtZhG25YbZD5MOqu+kEWGC5n5pCH8Dni+MzSIyVFXSys
         iz85jnKKJDDYHpUHlumOwxK/GaKNtAbTF7HrcB5EcaXim7VowZiGlUVN/bEm52nRZ4WN
         zYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744798649; x=1745403449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/ANKiJhFvihbg1XVir8LGKcyLP9qIkWBCOvxZUsgt0=;
        b=Oz4WhQrmbAYNHql56QEOfHf6/WhL2ZNgy2Z7feyj1aQSCRmY4arDGPj+H6bNrzHiiQ
         wFV8hjhBb8UZAfmKGFlaNfNGO80bfe/ZW3tRe/eWWorZr7kHVB7JeBPTDyDTOTnobgte
         xXemzoFWly+8TgINvl1wEBLX3PNKcvBQozpwiBz0xbMpqG29sIMTm2ePbn46AonDPwzs
         RAvv82NriNEqIMBd7+f4pgf623aVbj6UgoSMbli059sMhFvU5XTy5UGw8ao5Lzfgzv7t
         YJVQJqfJQnsJua7XjqFeMgg91mMDcsa8QUk5sZ8Ii8TdsPETw/SdxXG+/t1hFa2Cjcft
         gjKg==
X-Forwarded-Encrypted: i=1; AJvYcCVR0D72BQ4/0oemnSrRQ/d7Ef/fStKUm7ZMqGV1UT3xBuA/qbBjI+NFopww42zp0+o96++dYIuj2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2TRnUX3xrnPZW6RTwq5rnmkGw3P2eTHrFG1+iDyopyMvpRsDv
	UCVC+o+3g8kHEtz4dZHLZiLubeXf/LSja0sYDkaJVdtGjns1KveBhEtpOWcpJMI=
X-Gm-Gg: ASbGnctDAmwuV5js8QVcrqeSqoN1B+FRjK0bts0Ltijs6jSnSexLQRvOCB2ZzaXlbPd
	b1j9uxlyJ0yHsljmZR6m9hGDooqOUf6iEFQ9bRgscRVMsiqEWYom86NiQl8VrBcZXP16F4fo1YQ
	5FRMHppuWdNJKUGpeV3bZas1zaIhMDdUz0SDPz3dGl49as6NVSMCmJE0jElPnBz/xVcb1usATk8
	/4lqjep0qOnHzYQzEwgwsyO0snpJVK1q9UIeAW1ZEKtbOeglePAtZrcj6WUh5MzJaAd3hG0okmO
	Qp/rtXscZy5JVSfZgBnaapMu20yt5vUWKgJcsf/qvQ==
X-Google-Smtp-Source: AGHT+IEP5v+tXDBmTd5U0jC7DaGa/ExzfUSWGNIY5nfSg4zcC01NVkg6iyoz+YcRUATQclmDewMobQ==
X-Received: by 2002:a17:903:2448:b0:215:a2f4:d4ab with SMTP id d9443c01a7336-22c35d25e43mr16092715ad.7.1744798648728;
        Wed, 16 Apr 2025 03:17:28 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fc4b96sm10195445ad.174.2025.04.16.03.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:17:28 -0700 (PDT)
Date: Wed, 16 Apr 2025 15:47:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 13/15] rust: cpufreq: Extend abstractions for driver
 registration
Message-ID: <20250416101726.g5jm6wnbbsmuskxl@vireshk-i7>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
 <8d04ef19d7a16610dbf0dfb5c9a611c6e1e3e318.1744783509.git.viresh.kumar@linaro.org>
 <Z_9ysHFmvZvaoe8H@pollux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_9ysHFmvZvaoe8H@pollux>

On 16-04-25, 11:04, Danilo Krummrich wrote:
> You need to justify why drv is a valid pointer to be passed to
> cpufreq_register_driver(), i.e. something like
> 
> 	// SAFETY:
> 	// - `drv` comes from Self::VTABLE and hence is a valid pointer to a `struct cpufreq_driver`,
> 	// - `cpufreq_register_driver()` never attempts to modify the data `drv` points to

The cpufreq core can try to change the data pointed by `drv`. For now
it updates the `cpufreq_driver->boost_enabled` flag.

-- 
viresh

