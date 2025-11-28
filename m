Return-Path: <linux-pm+bounces-38864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30C5C90EC5
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 07:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FBC3A971C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 06:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0762C11F7;
	Fri, 28 Nov 2025 06:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxNZqgh/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86385289367
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764310381; cv=none; b=UyB4ok+O4qZ9d+fzw4HD/SnIyzKTpJFER9LYqowcZAL3UK8ZCoQm/ZYbbicSVGSTWV9ntXtT4feUXGnqnCLKuiHfGfbS9dUSM5pwuOWJXi7vdnZGgenFyTaOWiLldl4Vu3S52LxMOGObmbs4zQloxKMCyBSS0v4Pd+fUu6lA5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764310381; c=relaxed/simple;
	bh=FxoHkb7nyJiTSd6nPa8aGTfEfLKBIDOPPFcjWrCubMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR9o0Ieo6LG/7oqvYHLksTfgwiYxZXukm31RKyta1nJeAKPHUqjJ4DGPiGHn/ppfrrG33pvThHM5wkAoA1giIVKb1ydDUabbdsmdec6Pd/v8ToSnpHtqjbZptHGU3f5z08SwGAQycgkcKAuuURpyVltcSw8md6wipaVO3TTYhn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VxNZqgh/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso1711709b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 22:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764310379; x=1764915179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbV5zoayEdyZYtO178MOH1oaskHxTibOVaCNtKxbEA4=;
        b=VxNZqgh/UPPrvqVKO4kJ59/3ndDb4ZZGy8gq0Ly7nZZNzjHszv8SaZiMTr3Xr3CNHv
         LL/zyYBM7iHuKVSyjYDHPp3LrwR+VmK+FaHMt05aJltdEfqdveRQh1RtFRI62p4iES28
         dPwtSX4REmc8nZXBNPNBS8an67tTr4niuy2oTXmBg0vuRHNFjV3H0ZIJOdsLNnendCLc
         oWDavFLFHMwCKDV290x9h2VJClEDt89nfdA8B8E3Omw5Nfg4PM58r96cAuHnl/zv9GPi
         25MVxpvNXkrXstpC95/2t8B7aOcipllJg925SqAv9SwxMk/0RKLsKJtt01r19yYkmQBC
         em0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764310379; x=1764915179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbV5zoayEdyZYtO178MOH1oaskHxTibOVaCNtKxbEA4=;
        b=tDudbda0Tl2CtvCPn+2YEKa4eZJnCrPTNOBZU1uwrIPGjNWIz2xPBaZUEawWiWjx3y
         90qj/FIfYG0xDOeIqcEQFaYZsvpxOhGZFLloBLb7ojfQg76oRAOedHLBNyQmtEBTDcaH
         1Twzf1RABWufKf16LkoYRGkkQwj0MEuM9OtU0DklIr0HpaWerA9s0q+WZsHrceY8a/gB
         mM711OSyqXJflF6jDub3D690Xz7scITLcAc2RcZ3VHMbOys2j1MW0hU+enJp2lAWS9TF
         nQzUQXrdvLeUwZ3s3JX/H+EHx56fFq/6fGj9JMIC4o8MCl1P1XPC31nBtwdS1mAhFKHX
         Nj4w==
X-Forwarded-Encrypted: i=1; AJvYcCVby8JAiM7XeuE4DBgX7F9/LD2OQ3tA9D7VasyguNlmm29hB1rfooMUeM2jj7KV3blhJR8OUT10UA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCE2VkapZDLVh0827r5QeO14FN9KpwRdd3t/rgBU/j/aQHHAJx
	VwZh0i3qGcNdKCSx3aAQbm9rasyTyiiaZhHkDJWNseAeyzNNeuneONucCUJDHEIWUhM=
X-Gm-Gg: ASbGncvYM3rpNSfIk3NL+oulh6mrpRV4v0bd1QiNGE21TufFAJ/Pw60dTTBcieLUqvy
	XNTq9suEyHM6CmopV3FV1eHDjxAzZ3/ALbrb5UX8QarGgB9DtvJl5rrpWTKrJm0DerrdVo1KkLr
	yx+oqnAPKN788nxGe8GAHEWpvHpXjQbmO85YECP73nY2ZU0x7doMQTbK2ziSgCB5Z+rvdFUlS2q
	Z9MXmz9zaJv7mzjenUQeIM8XPAeydO1Sxv9mtUuIUJi6tyDT61OhgSZsjYNrE7sJu5naEjaLe1+
	XB8z8lOePKOwAerNzzJ052zi6BSyBPEbq525krhEAM7avcGmhUGATeNi1kjj1eCHrG4mpLdcawl
	7pu1DtsYGd2FSJ8oJ6QuC7BzhV2znTp37495NxWy1fo4q/hC/mYJ655PfQI/usioZrmIanWgXBf
	u+NLQa3hCnrVc=
X-Google-Smtp-Source: AGHT+IHjsfdXEFTf0OxB36Ajkhz9vTo0v1dVI1d+Dfpaapyciqck5ZyUFHvdETndhTkwemRanymW8w==
X-Received: by 2002:a05:6a00:12e1:b0:7b9:e4af:719a with SMTP id d2e1a72fcca58-7c58c4a7d77mr27303823b3a.1.1764310378688;
        Thu, 27 Nov 2025 22:12:58 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f177566sm3685274b3a.51.2025.11.27.22.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 22:12:58 -0800 (PST)
Date: Fri, 28 Nov 2025 11:42:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/7] rust: cpufreq: always inline functions using
 build_assert with arguments
Message-ID: <zis5k4oo3kq6dykzm3kav7rlblqvvnk43mrcvlwyxxfgwbpmjt@6r3f5432vr45>
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-3-a9ea9ce7d45d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-io-build-assert-v2-3-a9ea9ce7d45d@nvidia.com>

On 28-11-25, 11:11, Alexandre Courbot wrote:
> `build_assert` relies on the compiler to optimize out its error path.
> Functions using it with its arguments must thus always be inlined,
> otherwise the error path of `build_assert` might not be optimized out,
> triggering a build error.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  rust/kernel/cpufreq.rs | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 1a555fcb120a..df5d9f6f43f3 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1015,6 +1015,8 @@ impl<T: Driver> Registration<T> {
>          ..pin_init::zeroed()
>      };
>  
> +    // Always inline to optimize out error path of `build_assert`.
> +    #[inline(always)]
>      const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
>          let src = name.to_bytes_with_nul();
>          let mut dst = [0; CPUFREQ_NAME_LEN];

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Lemme know if you want me to pick this instead.

-- 
viresh

