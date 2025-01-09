Return-Path: <linux-pm+bounces-20130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 604A1A06D34
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 05:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1821E1883CD9
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 04:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3421B213E82;
	Thu,  9 Jan 2025 04:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9IuM6qR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994AC2080C9
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 04:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736397683; cv=none; b=pnJtc5fdIsOedokhprIYcg0AMKGwEaHAlBNuCZT9PQ0F8wlOtjlC99BgDN0NpdSlRk/MwL7Q7Q3OSmXkksjzfapnb57I4pUHuB5m5Nel+fUg3w1s6oREBMStBg7b+ZN2iZU4S0XF1dFtg9RdZtAZJ25JG9Vz581ievpKwQYwt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736397683; c=relaxed/simple;
	bh=/Rx0kO+7HHbNEJuz8HN4MJgSaQfoddGrDifWc+pMkZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKZIL6DZ2VYP74Wmhnln7EmhDSEmGtKytiNcZjYavLVyTQfksoUKJaQ4OIahXCySxsZfWcM5Qf4hzSZA0IR+OizgCGRxoDqYU/BilxtOKCDE7uNa1nos9/hlbhBH44hYikwShjRvbNQJ5A7Kn3HUv1Qw1WZx/aFL1RdrANnHTSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E9IuM6qR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216728b1836so6751775ad.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 20:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736397681; x=1737002481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+c3hHahLgLIKv6ApkF3a+1E3rNrUyMG5vSbCOT6lIk=;
        b=E9IuM6qRhEpENzdfqpKT5L/oARJN/3Dd19tgpq2e9EhFDrsDkNJOFrP4DOazYTS2EG
         R8/GXkmb+VKCQeG8jWITkV6jRRitp+9N6CtlOpWOR0ItkRpcT3CiCrTGagEwrISC862o
         WG2OM+5/84EDdrfHunzQOWIys+qsE//AX7oFqCPMbgwvTdZ7hrgdV+I9Ah+7/jM34R8q
         aeGGN8fc/5oyKZJi+jKNATosrSA422BTmjw/GSsHxnIlCBTJS8AhPje75kearOHVtwet
         eyIXIZgghfaS7FRfL3K5TkUKb+8wamwWci6RKqVAcKicgtDTQtKO9gg8WsQBrpKN1XGm
         POHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736397681; x=1737002481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+c3hHahLgLIKv6ApkF3a+1E3rNrUyMG5vSbCOT6lIk=;
        b=tZm6uiGZdSzSZw5IGj0Y/xlOxePyJBxW21ZsBRU0/0gfJwmW0qHk9bsQDHzCLJMgpa
         oXTcbodMoIcerIkhlkypormAiKsCZYn7/iyMZb/0W6BoG4PjqCGKMvMkPZL0WYWs/+oU
         cdXHlqqGtj2hjCNtZBNAiKT4eT4hW7NbYp615c95xe6ivOgcE56JSWjRtpZLEs83TDvP
         DKoHU4g1MutBVz/x00UnjK09DGnanW5I+0iUTXG4IXgvysCGuus9h4CI6k9ak/v5eN6e
         X5Y2ti/4slnvhJXvJBP+t1A/CMy3MPDmlXh1IAYFbW87DyIWu4QF5BVUDtKsI54FpNbj
         kG8g==
X-Forwarded-Encrypted: i=1; AJvYcCU86XsYzSKeDhMjrH4J3xX+0Ct8yoZRqbeDZRZBqJV7s1dsa7Snvd3CIIMYz3HviiVD6g0odfZGMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWk3YQlisQ2sddCV/imGqufkkaeIvvlSzqxQ5ILvIyP9YVUaFs
	fOfXPmPehksdlM8sPXVwWf8diBHu1V2P1L3tHhGA3La/4x6st6aSEn+iHoNVCSE=
X-Gm-Gg: ASbGncuIU1xYmZB7j8/Y5WPzWG2qTzFB7149CpRW/cslznTNc62hsFT7vD0yIxZjft+
	v7T0gdH2ZBuNBJrNbQsSaaWu+4suHK1XU3J117H3dLF1KVPLJweMs9UveBfnf2gqckZASBXRHOa
	HkYHBBFGRTktqQUtguj+Zp7HFq2Fr8MQJYprJEqrOozar/Zd1N9YyaO63rA/wQ+1bK67sz2UkvV
	RIrQqo001UVj1GnsDrjXnRUJhrFsLZsoylNLEi9OLUUiSS1AQh3jvY8OIM=
X-Google-Smtp-Source: AGHT+IEByTbi+ZfgdtinMM/71amE6izTac57ioZTlWWNLqV4D8ZJA57oCRe8JW93t/AikssAzYHE5w==
X-Received: by 2002:a05:6a20:c705:b0:1e2:2e4:689a with SMTP id adf61e73a8af0-1e88d0f2ecfmr9181952637.41.1736397680848;
        Wed, 08 Jan 2025 20:41:20 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31d5047fd3sm308901a12.64.2025.01.08.20.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 20:41:20 -0800 (PST)
Date: Thu, 9 Jan 2025 10:11:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
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
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 02/15] cpufreq: Add cpufreq_table_len()
Message-ID: <20250109044117.s5s4dlmssamwicew@vireshk-i7>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <867ba9728179ba21ff8f8aca97d416b72ccd63d9.1736248242.git.viresh.kumar@linaro.org>
 <2025010727-banner-monday-1941@gregkh>
 <20250108111253.tg6ixurijf2dvptx@vireshk-i7>
 <2025010855-cargo-quickness-a08f@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010855-cargo-quickness-a08f@gregkh>

On 08-01-25, 12:50, Greg KH wrote:
> Odd, why can't Rust also know where CPUFREQ_TABLE_END is?  Why do you
> have to do extra work here?  That feels wrong.

Well, it can, sure.

The freq table the Rust code receives is part of the C code:
bindings::cpufreq_frequency_table. Since it is a C managed pointer, I thought it
is better to do the parsing in C code itself. In case the implementation of the
struct changes in future (unlikely though), we would only need to fix the C code
and not Rust, which looks to be the right expectation.

-- 
viresh

