Return-Path: <linux-pm+bounces-21369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE928A284C7
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 08:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F7AE7A1BE4
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 07:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFB2228C84;
	Wed,  5 Feb 2025 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dO+s0RYT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC29321773E
	for <linux-pm@vger.kernel.org>; Wed,  5 Feb 2025 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738738870; cv=none; b=gb6v6VMUT6e7G6Ql0rl8KePEeKDANdFcdnv9HJIwiRwMZ489tSk6gqTHwU1GK6HxzvA6t2wYQkOaMmoOhMoRLdENc+azGNpB2O8jeKLa34k14aK2WZxW7QSOXs4or9a4IJ+p8ChET73iPMOjWQrIgemd6AualFZCDLgi7sgnSVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738738870; c=relaxed/simple;
	bh=aD/NIW5FUnM9KNWUYbfUMGjaLngniGnrcJF+wI6pOuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhUS6eF5cOWXAZwyKxb0R9baDjnUB9Pke3TCzfqhBAZAV95X4dIEmxicIZW7IIsq9WEqkeC1HbrBH463Su0gl6uWV5Jro9+pdJOBbK9+YyTXLswqENw0zTiT4w5FGp7JkQJT+CccIwH0GXZTgiYVr1jRcOgcS7yEzexc52rraLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dO+s0RYT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f9cd8ecbceso2282373a91.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2025 23:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738738867; x=1739343667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6N/xvMPywVw8Ta/fzMCKBPH/2e9AxLxEOg5T5Sofx6w=;
        b=dO+s0RYTJNP9wUMtR0QLLgc1OOesLMB2lodX4zejPIG+1W0oaKf6PxlmH2Y7Z4aNkk
         dCtQN+rhskNJ5H3XavcjRGrKbTAlHfah7vTjJvR/GY6tJIokskLNNgvdK4ZTiMiIYbej
         SR6D4VX7vxhV4XRuuaTlOVqhjMgv5M7cVj09l0Xzwyd/9L4E7mQ+ZkTZ2fvBN0QkmyfY
         KTWbasf1vWJjul3l5GNekOc6VwsiSLKN91bD0GB25DdhC9My+Hem5V5gtasIJXY/LE/4
         Q1bmeqAf/aPKbLlkwr0uqcs9oDHKjE+TUfgqrqeUy8Xk6R8zJw412rp/GCv+U3Sua2bq
         kMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738738867; x=1739343667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6N/xvMPywVw8Ta/fzMCKBPH/2e9AxLxEOg5T5Sofx6w=;
        b=dvv7YvBxExsHDqRi9C2N6B4IdDNxSqp+A0iJMYImJRThj5fL8UeTykfSpIoXPgbQkK
         SUQKAbmyzDa6DeKSo8Vazyl/StAY3lIHOtaoTPznU8SnHNFrq/Dyi+kNIJ18Fp/8eMRe
         CKWICgVl/U2/Tx4i7NXgT+ZZWKgvRRaaPi23++XwP0gbK50vUDOhNdo6MyaHaNHgkiwR
         +bzg/RhjbmqIPMIUXkdnUuYkhiaIObO1LfIMQufSJ0MuSWGYFthyl2uAYj9p1RzKODjr
         m8bcLWlVsH4GmiV7oKc4I/7UY1aCz0aUAeF3lvyh2exmfbiedTZZxI5e+kHGxEHd/ZGJ
         /sDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUStdgJP356CSokSak2QZddM5oQYjXrENzbe7YOEa4fDZ6tCWF1uoiUDtEoFgrKoVgGe09enNQM9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAdLG6lP14zCRqMAjv0cZv/OkI0G1EQmByNuJTeqYnkBi0jTF
	mj0IaHuTDzGkkVOYSIAM9HN2L4W94jlIv2nH7x5OqmYdY4W0dHH6yxonvmwKY8s=
X-Gm-Gg: ASbGncsNpDc2JnrAn/0y/wD8dDA1Js+mp4b85HzFvX1Dloc3lnfcD39bMiotDcId+LU
	ISCpz/WzABseHq9600s5sbalCXU5cX2nDM9cZJCvBAeJEOS6wPfoFfTh+jHbpBPZ/c0Bbss5vI3
	0vawTBp28LL0hij/M0sV7x0TDkkBcbvzsXC05fuMvghZ9+q2IB5PQhSGtrl0BI08ng5HmyJAk43
	VFqz30JARq2xXtzXqyjVrPoSP8B7w9QWPV9n232zkEwvQjQ/vlzpyoGK5dvhUcqwh/o6p4XRkcJ
	Qg+myPczZkeeDuPKMQ==
X-Google-Smtp-Source: AGHT+IEu7fqxtK7w5SoEhI6cbco/xUvu7X3eM4no2kX0m2LQwZj0KIS55DISe84WBXdk8tWZ91sBcg==
X-Received: by 2002:a17:90b:38c3:b0:2ea:3d2e:a0d7 with SMTP id 98e67ed59e1d1-2f9e0792de0mr2925113a91.15.1738738866797;
        Tue, 04 Feb 2025 23:01:06 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1e4253bsm762453a91.49.2025.02.04.23.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 23:01:06 -0800 (PST)
Date: Wed, 5 Feb 2025 12:31:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, ptsm@linux.microsoft.com,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 2/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <20250205070104.6k4n3zcyuki366am@vireshk-i7>
References: <20250131162439.3843071-1-beata.michalska@arm.com>
 <20250131162439.3843071-3-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131162439.3843071-3-beata.michalska@arm.com>

On 31-01-25, 16:24, Beata Michalska wrote:
> Currently the CPUFreq core exposes two sysfs attributes that can be used
> to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
> and scaling_cur_freq. Both provide slightly different view on the
> subject and they do come with their own drawbacks.
> 
> cpuinfo_cur_freq provides higher precision though at a cost of being
> rather expensive. Moreover, the information retrieved via this attribute
> is somewhat short lived as frequency can change at any point of time
> making it difficult to reason from.
> 
> scaling_cur_freq, on the other hand, tends to be less accurate but then
> the actual level of precision (and source of information) varies between
> architectures making it a bit ambiguous.
> 
> The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
> distinct interface, exposing an average frequency of a given CPU(s), as
> reported by the hardware, over a time frame spanning no more than a few
> milliseconds. As it requires appropriate hardware support, this
> interface is optional.
> 
> Note that under the hood, the new attribute relies on the information
> provided by arch_freq_get_on_cpu, which, up to this point, has been
> feeding data for scaling_cur_freq attribute, being the source of
> ambiguity when it comes to interpretation. This has been amended by
> restoring the intended behavior for scaling_cur_freq, with a new
> dedicated config option to maintain status quo for those, who may need
> it.
> 
> CC: Jonathan Corbet <corbet@lwn.net>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: H. Peter Anvin <hpa@zytor.com>
> CC: Phil Auld <pauld@redhat.com>
> CC: x86@kernel.org
> CC: linux-doc@vger.kernel.org
> 
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
> Reviewed-by: Sumit Gupta <sumitg@nvidia.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

