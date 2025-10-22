Return-Path: <linux-pm+bounces-36623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AD3BFA15D
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 07:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D4C84EC057
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 05:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA672ECD2D;
	Wed, 22 Oct 2025 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZ0mgvFY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8752EC540
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111638; cv=none; b=bdrDPoh80Is7EcUvmKt36hH971RwiNbvFSjdOgUMpXPh9PXfmawVylTW3G62YJgmvmznsHIow7FjZIVBpivGIt2rgUKcHmJAJs3+YOUneNTsWoX7XrOvdzzCL3cLF7IlunCIpprbfJkZG1EFR+8P9zO20lwqu5INuR4BapFJdBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111638; c=relaxed/simple;
	bh=pJrhTqkYqYrDrHV69BMLI7l5fWeIbisLorjstsXX25A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJIw9zfiFZTEJUkTjjo5C3tfw1gYZhpSyt/iq+/XUP/GiIOyCWedfjN50+bb1rjEBsqC96mhbX5VGQXE8Sb5zCrCF1dz6Ju1nsOnuOjNgfsZRJKhxQT/b7JO5VCBbzHERz3dCYXZ2MTkJhUvRyblJA+yy5Nk0yF9loBO0FU6o8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jZ0mgvFY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-290dc630a07so34759305ad.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 22:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761111637; x=1761716437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3iuqqBL1ouz7GRlykwDwM8a9PRkBS4+Fo5+nLag3W1Q=;
        b=jZ0mgvFYrrBhUHTOr5Ax2Wy+e9v7GqNRGdZRazJrfu61DvsxLyAKslmBg6tytGg+PR
         mTuvME0odwzbzdOhCRRHM+E5WeBTIJbzxHtSTXW5tpUQosv3og78D1gyn7tIS4m4AeFT
         t8GkvMmzNtp2WzL/L0B6FovdhVhDnze4L3op66i7cnrrcyqdaEYnSrOvYrYczxZHpfk8
         OEOwRAJqPtlG37eRSG02rnZJCxCddvbXul8DVicoGJNuUabtgsJ5jkbVNQYQTTOSVbc/
         g5+AHDg+7cpTeLjqh9aRJ52elfbU8FShhaZiOHUO2ocw8tCvBgDxfj16teo8RfBAI9IG
         9IcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111637; x=1761716437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iuqqBL1ouz7GRlykwDwM8a9PRkBS4+Fo5+nLag3W1Q=;
        b=eGejCjBeUDTRW79Q2AVhRcIqB9llqyB7dWFrwMe/Kx3k6VRgyZhgaeqzGIbNFzgMz1
         9+o4LWxMijcW01Zkrpqe0Gi3tWErXAxbckE79FXi0roCV+oF0I7lp1PuGNGGfQBeudv6
         i8zS7nhLYpVjPP4cltt5IQmGq2Ax5qbAkcAEvf2ofQHXI9GENfrZtidlXvhP+T3V8kf0
         yB2hlymraocSTRDlrYbJfJOBCAj1+t2scMeJ/3qg1gB4ou38t2mcy06QDmOiJefeej4S
         +nupOdnaTt8rYJhk40EwVw/RTiZofo5Jw6UJMvZo2Tdc0CMRGC5aTca+vQFesKpLeQw1
         dULA==
X-Forwarded-Encrypted: i=1; AJvYcCVrS7jOrR6rW04fLFO80Lh7AIcUEmhz+ThGaGUk8UScQg7WzMXHqz+GyCazhEwyMrbupNq7RWe5jg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Q/x/1B6BuFnje9Mrvzyy0MnG8ywH0H1V8yY7HhgIkUtZp24G
	LaYYln1QXqs3SchSdlkr1lng0ttD8oReWSiT/veA+Toc433xXPo7VQ+sGH2Fog7OADE=
X-Gm-Gg: ASbGnctcGJ/BVjUrn1sD8x+Ghn7/snMEVPSw600PYlxPe5gy/BS0HSekZaj4kfSLlu1
	1JdH7D8aOP+cEuNsYJ/rh3U3sPydRHh7PNlfh0GQiKfdBBQo9ngUbOzKlmfBVZac7NeIcylyZB5
	KexMh4wBLcH/ZzSWb+p+Cgz/VtZxJMibbB40wiQcyjKPx6MQ1kGEGhzQ3JYbfN1Md4KgUXHHpdX
	bChT7iVTYtTGkfH+h6UHLDqBAz6zWzGgnRC81v0YtgjxymrFqV/nQAOqx7zNGGdKHNsd7K9rjwP
	koWzWWot1h1zOrJk8lw4dvOev8rmPn5alraBlTNiQz4udHUm6pFl3iQX6R6QJpFZXCMLSrshgLF
	GbboJd194mnGcaJi2cMw3Fwb7yW8Wkp0CUhknGEXGJZH0+pV+g6NawENHTJFEVpQiLokafU0tLg
	T0Y3kRYgcr/YJY
X-Google-Smtp-Source: AGHT+IH3mz2S4uhTIWWRZrBsBMjC/WQ2iNPLucaIEk7+PMDLVPZ9t3rD8MK8J58F865tjsvy8UEZXQ==
X-Received: by 2002:a17:903:8c7:b0:26b:3aab:f6bf with SMTP id d9443c01a7336-290cc2f83fcmr265736415ad.42.1761111636533;
        Tue, 21 Oct 2025 22:40:36 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5971sm126981835ad.56.2025.10.21.22.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 22:40:35 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:10:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: opp: simplify callers of `to_c_str_array`
Message-ID: <ms55ue7qqbvoyfhptzu2a5cuthusihtobremhuqfm7lyu7b62o@qasunalgkptl>
References: <20251020-opp-simpler-code-v1-1-04f7f447712f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-opp-simpler-code-v1-1-04f7f447712f@kernel.org>

Hi Tamir,

On 20-10-25, 09:07, Tamir Duberstein wrote:
> Use `Option` combinators to make this a bit less noisy.
> 
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
>  rust/kernel/opp.rs | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index 9d6c58178a6f..b84786f45522 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -443,23 +443,14 @@ pub fn set_supported_hw(mut self, hw: KVec<u32>) -> Result<Self> {
>      ///
>      /// The returned [`ConfigToken`] will remove the configuration when dropped.
>      pub fn set(self, dev: &Device) -> Result<ConfigToken> {
> -        let (_clk_list, clk_names) = match &self.clk_names {
> -            Some(x) => {
> -                let list = to_c_str_array(x)?;
> -                let ptr = list.as_ptr();
> -                (Some(list), ptr)
> -            }
> -            None => (None, ptr::null()),
> -        };
> -
> -        let (_regulator_list, regulator_names) = match &self.regulator_names {
> -            Some(x) => {
> -                let list = to_c_str_array(x)?;
> -                let ptr = list.as_ptr();
> -                (Some(list), ptr)
> -            }
> -            None => (None, ptr::null()),
> -        };
> +        let clk_names = self.clk_names.as_deref().map(to_c_str_array).transpose()?;
> +        let clk_names = clk_names.map_or(ptr::null(), |c| c.as_ptr());
> +        let regulator_names = self
> +            .regulator_names
> +            .as_deref()
> +            .map(to_c_str_array)
> +            .transpose()?;
> +        let regulator_names = regulator_names.map_or(ptr::null(), |c| c.as_ptr());

I had to keep _clk_list and _regulator_list earlier to make sure the list isn't
freed while its pointer is still used (sent to dev_pm_opp_set_config()). Won't
this change cause an issue here ?

-- 
viresh

