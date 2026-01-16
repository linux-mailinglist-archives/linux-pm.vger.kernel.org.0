Return-Path: <linux-pm+bounces-40966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BAED2B92A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 05:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0152F30456AC
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 04:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A8E34C12B;
	Fri, 16 Jan 2026 04:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imDnVesm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1220346E4C
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 04:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768538717; cv=none; b=crHmarrk64GAys7Dewzgo43hVHFYXZMHAfWESESMUiMK8CuJJ9xmh5KgZqJtXcO/rE7TWlx6sC/+n9kr/zaT+6gqmA2eKhrzwSA5svNIeL0pfcj8qn9MqWTgKk+Sn3wprktfmt78JeRu1rvf+j3SxWsu1kI6AfL2flaVGyOB8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768538717; c=relaxed/simple;
	bh=qvLwpSrQnWFaQHhcymHGiKAckW7z2fLD6nZgVN0pk/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5YgmiMsPEt1ztFYkZKeJpPsEK78aOWE7xjTVUHm+TLPt5ztrsEhZ0rYphkVUtUxYS+DdfLUuuDdVu0OD/fnXew4e5o2ddTvbOQqLEtRLSmSKdxQCi8Xebu0BV8WIf2PcS6DNwVQw3eYsl9OMaseqaY98BV/FxJgfPlce4e2Krk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=imDnVesm; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0a95200e8so10816415ad.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768538699; x=1769143499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0USPLt2B+noNFBNiV821NXHHZvHrFhQTCs+tPkiE6I=;
        b=imDnVesmN3Z+QNWRa+Fqyd55ShLvMEqfBXVfUwyFcbD+uqy5NBKai+Ima3FDgdUU3f
         IiIt+moS0HZWie1EkbyK20MyP3Ql4fz5ug1CS1g6xvOpHDprkuv0ZZo5m6lDuG8/BIqh
         +X6LnUONWEjFp5KYxU6lre31xEXzFwNnxppPC/dKSgeE9cDy6kHe9jXMhrIZD9l8BLpX
         v6r8iGIApkYGAlR0+B0BzqTdp+X4oWTVMlqPTnAgfBqLMINiTG8jMRLcGMo97WY0islr
         uVJvDMtFvoLhk36vlqL2bb1nJV8MjZWPN3m7BuZ2XAi/u8fPN7pENpkyBvSZ1Orivl32
         qTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768538699; x=1769143499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0USPLt2B+noNFBNiV821NXHHZvHrFhQTCs+tPkiE6I=;
        b=TWLJ2DegPuydMcZevlqE+GdYvGUOTetrrbpV2Nvwp/5Q4nyabU3aRkZPDjm452c7XE
         zKDhXB0+PJ2eTSJZ9ds0/Tyt8A3NoXCDUnKpILhtKM27GgW7bre+tiEm1bV9ahCoWNN9
         ZeOmfgM1q09M78fj55ByAAtB5g90KWFL9C5ZTdZEsxHwNQAHARaJPxkyMcDjHb6VTtpU
         bSTftfJ1tc8X5gKGLZFNvOvTDxOyPaadOT0N0tU9fLHXRZwmqGLj2ogx9FXIkr7hYvoS
         8eR6A6q6s5irPx6y++9GBka9HK9aqOY2fff+Y9GYlKA+M2B/b3QAezs5Y/SwLp+hJ2Au
         XvhA==
X-Forwarded-Encrypted: i=1; AJvYcCUkHZlDrP10IFOIzPbVdi2dv1s5zJUzFZOv32YFE3ccMgEZwa4JIm5d7UA7RPZmhq6edpY7hUcDoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8SVyHiDvdBoTAjktTStTGJDqtHrBJf0v8glOFgVcas2qRikDM
	b3fkwig8fwhd4PEWb02Z1s+gDuDWTE01O5vrhOG1GYOGoXObFG3EcfK7s336PST93wQ=
X-Gm-Gg: AY/fxX6tAMf4ki4cOTGH/kKR7y+aTSrDU+u052kgnlU1zwnJ8qNrw8Q7q1y09cDVRZa
	Kc/pl3qN01ob9ULajOFKZ8ZDNzF1OvSqE5M0utGpOu7RSaDfxk/R6lZzS4W7d0405kQULCXwWiQ
	rMjb9osk/Lnpd+30yPe56Qk0pyexvOHeRuUm1FRM98WVon+IWkcuY9FCyjLYAgTbUMghtig6D+B
	pQp+hAKhjrqKWAyoMsSHbU/2YN/I+4PYvrNwhNWlCBfEs8Je7wN7RcBDUtE7tgZ88O8twbFXl2z
	/Qfz4q9HIBOSMxBR7I42dE54nAwz9Ksdxkj5MEEEU/khpqTDkSMxkPJ9cQRw+He7lWBJgJly7cf
	RNl/H2/SKtqQ2g4yGTGQGTnAAUXC/aeqbKwMtCqn8kGNP3m0S43Fo0YlBcx80CW5aKFtWS1sK1T
	ozBdGZJXJ1/4s=
X-Received: by 2002:a17:903:13d0:b0:2a0:a92c:2cb6 with SMTP id d9443c01a7336-2a7175a63b4mr20341575ad.36.1768538698802;
        Thu, 15 Jan 2026 20:44:58 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fb372sm7887045ad.72.2026.01.15.20.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 20:44:58 -0800 (PST)
Date: Fri, 16 Jan 2026 10:14:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Perry Yuan <perry.yuan@amd.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Pass the policy to
 cpufreq_driver->adjust_perf()
Message-ID: <rs4z34vntq4inwbl6nhzwsmefcgud33a4jpec44ff5ylrxtnur@rczzlmhgejky>
References: <20260114085113.21378-1-kprateek.nayak@amd.com>
 <20260114085113.21378-3-kprateek.nayak@amd.com>
 <bqvpt465nowq3jipfsciaoafjpjhu42l63vi6p67qscwx5oil4@t2tkh2u5giuy>
 <6eabf604-9168-47fb-8fd8-b2f0d985db6a@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eabf604-9168-47fb-8fd8-b2f0d985db6a@amd.com>

On 16-01-26, 10:08, K Prateek Nayak wrote:
> Guilty of not having CONFIG_RUST enabled! I've arrived at the
> following after tasking a look at cpufreq.rs (specifically the
> fast_switch_callback implementation):
> 
>   (Only build tested currently)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index f968fbd22890..bea109f8ff78 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1255,18 +1255,17 @@ impl<T: Driver> Registration<T> {
>      /// # Safety
>      ///
>      /// - This function may only be called from the cpufreq C infrastructure.
> +    /// - The pointer arguments must be valid pointers.
>      unsafe extern "C" fn adjust_perf_callback(
> -        cpu: c_uint,
> +        ptr: *mut bindings::cpufreq_policy,
>          min_perf: c_ulong,
>          target_perf: c_ulong,
>          capacity: c_ulong,
>      ) {
> -        // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
> -        let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
> -
> -        if let Ok(mut policy) = PolicyCpu::from_cpu(cpu_id) {
> -            T::adjust_perf(&mut policy, min_perf, target_perf, capacity);
> -        }
> +        // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
> +        // lifetime of `policy`.
> +        let policy = unsafe { Policy::from_raw_mut(ptr) };
> +        T::adjust_perf(policy, min_perf, target_perf, capacity);
>      }
>  
>      /// Driver's `get_intermediate` callback.
> ---
> 
> Let me know what you think. If you think this is alright, I'll fold it
> into this same patch in the next version to preserve bisectiblity with
> CONFIG_RUST (or should I keep it separate?).
> 
> Since this is my first time dealing with the rust bindings, comments are
> highly appreciated.

Yeah looks fine. Just make sure it builds fine.

-- 
viresh

