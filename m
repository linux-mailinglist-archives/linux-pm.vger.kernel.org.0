Return-Path: <linux-pm+bounces-31573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1219B15992
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 09:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB203B693B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 07:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717BD2877C6;
	Wed, 30 Jul 2025 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="k0SofNqq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62373287510
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860571; cv=none; b=CGDytAuvISyFDy7z1vacTXdwVAr3c4ifxmCBaA6cnkPZGyIsIqJQkRqXuym9gHq/4bQEwfFAoi+9OIfde5BLd4Ygex6J3lkKZpQ2L0bicTHtFfp45GA4zNhpBaA57LVZwgDYsDLLiKyLzc4ISLEB95mtdkH2VVmEL8uN7Rzn16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860571; c=relaxed/simple;
	bh=FqJ/O1UbZAXmNa+fmKfqPN5k81phRkofhogPxnTCOus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgBWsFT9cpSIl/cxHJJooPnbHPHrK26oOA26FuXj/OiI6OOLSLqbHeF1+uX+PEV1x4VJQj1U0xUcZ9b7IeABtvp+A3boVBC0rMaEISNDIUQFMbUdw7h6eEti8BHWI++g8gKymKECYa3uhH5Psn00OnVsDE8A9FmeVM8aNZT5Fbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=k0SofNqq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae9be1697easo116557666b.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1753860567; x=1754465367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfSyL1J/1nGbrIfH2f1hr6gi59w/PAjg9s3k0fTksYk=;
        b=k0SofNqqbErflSZx+iv4t4+Vhtd4hhhJQ+i2cVmnf6HNf5GviDEDcm4RYOhuIJhYOg
         IfXTH8sam+8850EIO8t7GlBxPdwlH698oVSFn0wpd7DxExAKFMDyZXK6wnoPz8vtlCvf
         X2NaqpFErt3WGSTSLt9cXwA1GzXhIRjkRzyduBnPRc/xPbGpP2dgxcHU3aWREtkDWeLU
         fj8AZTYx3xafg/X4f4rJn1EQspegneJAFISxeUZuSb4i/aNk6z703Qk1FjgSehT4HRNQ
         +Dao4VyJrDEc0WuQ47GOwWA9dkrPBWdpJsjW2Z7fwrW9kVVPA/ACKP0dl4UtZk2z9Ktd
         iXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753860567; x=1754465367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfSyL1J/1nGbrIfH2f1hr6gi59w/PAjg9s3k0fTksYk=;
        b=g/TEbBdMYm5x+UzFxehl5Jh8PurvVBiZklJx2J1zn4JtZyJppcVGgxCtwAqmQG9lWX
         YZCuyLc+e9B9JCfSEEpKbFrqlWnxi8TLVrtkBBScBLPh+ihmgqYCOtr93355RkaRemsl
         OVzXt1fda2Js/GjmmfzKNo2xa+s0Op8w6F5Kqgw7Or7kICuKYRMZY+q3qf608IRr69zr
         KPvZI5z83BMsWmdf9qC5m7/3ZxNBUTC9PJqP9gY+htq8eGozVl9Rpjyo5rpG7qfwimRk
         2H1HBMYl6uq7DwM1vfotissfl2KeRCnqowj6qELyNnQpe2x8fEyJ9ywc5EqMIVJ7FWqr
         ihOg==
X-Forwarded-Encrypted: i=1; AJvYcCX+q1BeWYtwylQNkHoAwhNnu98ahpoVJndAqaisN/r87aTp+JjVGdNiTGJ5ekhyl0SoA2kCz0b3TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjvLN3/A5v0mwWlVFWZHTRnQYMGeww8HFYn+0Ims8e7qfXdc+f
	TR2P9LRxek3Flxuat/Aslxlj9Q0kQrgDcILSYv42CnbJ8oL3K80ZCvwu/gXcQoy1Jxc=
X-Gm-Gg: ASbGncuFp9mPfL984iGl6hraiQLedByLmH0/63j0ftNtERRlWB+5Wnk01Sz4PVcXxSU
	u6iAWphaWN5wBgX5fkMq+kLrW4MYLHXzlOsIHuJ59e/OAlUzM3AMvMTupWupgdybQaTKoBOJxjy
	hHszMlaQcvUCs6V61Z4kPlZPch2h8Wa0DOYuyHZqmXVAtACOaUR2k962/tzKYgSlYgzHJ/xq0LU
	PM8j0bNVwLHpzfeOGK1BgtvfYlVubAN8Hqq3MWYn9D/wFzzx93Cnuq2Afv6qIDNK8vEzE1kAVO4
	8zHQ6I3qFlF7KSlCpw1nsgyrrQeVXNVTISM729jYnxNTv0XIt5mtosVScYRiOC+rdh+R6RHK6uP
	8WEwK66jWRvP3Fz/D/22TDt9dbDmWsb+cT3aGOj4cuXAt0BgDytUCa3V6P0uTtw==
X-Google-Smtp-Source: AGHT+IFArK5yJ0y1FvOGBm8xzNPjYC+xuZmYpGZnVw+SljX1j9nVPSGdupVHpYG06Yu+78RjXTjllg==
X-Received: by 2002:a17:907:9406:b0:ae3:ee3a:56ee with SMTP id a640c23a62f3a-af8fcea9917mr340301266b.3.1753860567359;
        Wed, 30 Jul 2025 00:29:27 -0700 (PDT)
Received: from ?IPV6:2a01:6400:11a:26:d163:a794:aa16:5e2d? ([2a01:6400:11a:26:d163:a794:aa16:5e2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a610e2sm699912466b.68.2025.07.30.00.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 00:29:26 -0700 (PDT)
Message-ID: <fc26c393-5c4b-48a8-a7ac-12558f79b140@sedlak.dev>
Date: Wed, 30 Jul 2025 09:29:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: clk: use the type-state pattern
To: Daniel Almeida <daniel.almeida@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 7/29/25 11:38 PM, Daniel Almeida wrote:
> +    mod private {
> +        pub trait Sealed {}
> +
> +        impl Sealed for super::Unprepared {}
> +        impl Sealed for super::Prepared {}
> +        impl Sealed for super::Enabled {}
> +    }

I just noticed we have plenty of Sealed traits scattered across rust/ 
folder. Do you think we would benefit from unifying it to a single 
location to prevent duplication?

> +
> +    /// A trait representing the different states that a [`Clk`] can be in.
> +    pub trait ClkState: private::Sealed {
> +        /// Whether the clock should be disabled when dropped.
> +        const DISABLE_ON_DROP: bool;
> +
> +        /// Whether the clock should be unprepared when dropped.
> +        const UNPREPARE_ON_DROP: bool;
> +    }
> +
> +    /// A state where the [`Clk`] is not prepared and not enabled.
> +    pub struct Unprepared;
> +
> +    /// A state where the [`Clk`] is prepared but not enabled.
> +    pub struct Prepared;
> +
> +    /// A state where the [`Clk`] is both prepared and enabled.
> +    pub struct Enabled;

I would put a private member into the structs so the user of this API 
cannot construct it themself without using your abstractions.

	pub struct Unprepared(());
	pub struct Prepared(());
	pub struct Enabled(());

> +
> +    impl ClkState for Unprepared {
> +        const DISABLE_ON_DROP: bool = false;
> +        const UNPREPARE_ON_DROP: bool = false;
> +    }
> +
> +    impl ClkState for Prepared {
> +        const DISABLE_ON_DROP: bool = false;
> +        const UNPREPARE_ON_DROP: bool = true;
> +    }
> +
> +    impl ClkState for Enabled {
> +        const DISABLE_ON_DROP: bool = true;
> +        const UNPREPARE_ON_DROP: bool = true;
> +    }
> +
> +    /// An error that can occur when trying to convert a [`Clk`] between states.
> +    pub struct Error<State: ClkState> {

Nit: IMO we mostly use the `where` variant instead of the colon.

	pub struct Error<State>
	where State: ClkState

But does it make sense to put the bounds on the structs? Shouldn't be 
enough but but the bounds on the impl block?

> +        /// The error that occurred.
> +        pub error: kernel::error::Error,
> +
> +        /// The [`Clk`] that caused the error, so that the operation may be
> +        /// retried.
> +        pub clk: Clk<State>,
> +    }
>   

Thanks!
Daniel

