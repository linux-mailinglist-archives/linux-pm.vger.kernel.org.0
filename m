Return-Path: <linux-pm+bounces-11982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A79194B573
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 05:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF131C21A1B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 03:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE914317B;
	Thu,  8 Aug 2024 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhiwFq10"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E472CCC2
	for <linux-pm@vger.kernel.org>; Thu,  8 Aug 2024 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087800; cv=none; b=QMGJk2jEwLp5M9CHE7AXcUbzbubUPsMkT3dw6nLgC9YAaldCT3SMEKuRUyuIl0ZIPsPUTIuRYJ2hsShPG0VFQBvlkS9r/BKmb/AxaoSBP9i/cY/SgqFD+z7A4lNjBv1iXiRFI4mSgxVNZ0WCpK3WWQoQjmZ4Io8RMS05C+gAD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087800; c=relaxed/simple;
	bh=NNTuC94XhuZhDhrQS3QsAXSIBagRUogg9FNt4uigfZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmNnp4h6u3ExqJdGFdHhaw/oWq7K/fc+NOuKfflv9VlHbho1ZRpj9JxiopZr9i8r/vPFj0bCYNen4C/n1CwAd0FmnBWQN2LBG3jiUFxrmbJKNDyRQ8wvPpTow3rmqJBLtP5bhG3Q3TqLYWVj0CG7m3r3nzYU2d2hE0SUv3hrtCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LhiwFq10; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c661e75ff6so339848eaf.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2024 20:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723087798; x=1723692598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01aWtP1xPWHBVXs5lQjLNJmhvUCclZ42tYEJQkcTgC8=;
        b=LhiwFq10F+aD1sdLKd8aTx4ODEy+oJkKHRhnYqtG0MMlPLaABIlDbSt7ztHOoiJLXt
         P8zK8JSo4xSSHSKIZ5v7WRCKXr28Y1OMmxVTrJMsGX4Fb87V7naTD+S2EGbHbvxAjjkR
         B62Af5UrSQD7Bg1BOFqT0gYVUreDN+WzG5Fj/y6jOWhnTEhJvW6qLg6c0f79yVbIUvB8
         oZig5YIrBcDFiNAXiYB/Cm508MEadmvBzxHemLwco5eZ2KL4NYQJge15OyyF7vlANRlx
         Pfj1njtRZZ+v8FRQQhtuNU1VpwAa8Vb0XS22cIFd43GmJbnlI3Z109UIFGanIsAk1xi9
         0yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723087798; x=1723692598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01aWtP1xPWHBVXs5lQjLNJmhvUCclZ42tYEJQkcTgC8=;
        b=i0lw+1FxlG3onzudtHgFldSVgQDrxzMODzDBYrWltmzRrJcD6bBxR042fHcpLomD9p
         TWtXlZ5S489WYAol0kJczAg97V+HbMu3xfw4DVhBJHIFfBB1Qsp8SfAuXSj/m7EwmyyF
         xItZo857Lyi8+lVKaprlk2AJ8zzVI4nnnGd4596jwlDnG8wRF7nMextigojDSDGtDDv7
         nwKI5ZUuA43q8xU/+8YcmIly+6hv2IX03NzWq+UrVdySR5kCHg74YWur626VTf5q/0Ac
         Ltk2z1RVNKLiB/4a7OI8uNZEh0MsjElnEFpTglfvE181ZpFflMGjXSqi5Gzk3tMH4vV/
         HgOw==
X-Forwarded-Encrypted: i=1; AJvYcCXAk60bJA0AKzcn+Xr+4U0fhcD3W7UGcl+/+Oz97xagBd/otmUgimCf/k67m8k5rOSx4yCZDR+ojw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7LE1ErAscSC8mjEYWafFDGgEQxv/0A1JSms85UTYjHUhidapo
	NoFRdcD0HsO+Jy2KAboQwVg0r0xh8ogqStr8/Eho29z+dMgeCVlqslZV8vHG05c=
X-Google-Smtp-Source: AGHT+IEpSWEleoN6z68EahBVUey4dWAXs0UACNyEwvkfecwreve69icdPVyIekFeZZlLj8kCtH2Cbg==
X-Received: by 2002:a05:6358:61c9:b0:1ac:ef39:fd6 with SMTP id e5c5f4694b2df-1b15cfee7a7mr96947355d.28.1723087798113;
        Wed, 07 Aug 2024 20:29:58 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff590608casm113256985ad.159.2024.08.07.20.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 20:29:57 -0700 (PDT)
Date: Thu, 8 Aug 2024 08:59:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Kevin Hilman <khilman@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] cpufreq: Enable COMPILE_TEST on Arm drivers
Message-ID: <20240808032953.uzyn4ou5bxm2uood@vireshk-i7>
References: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>

On 06-08-24, 07:58, Rob Herring (Arm) wrote:
> This series enables building CPUFreq Arm based drivers on multiple 
> architectures when COMPILE_TEST is enabled.
> 
> The drivers for x86 and powerpc appear to be dependent on the 
> respective arch code, so those can't be similarly enabled for 
> COMPILE_TEST.
> 
> I've built this on arm32, arm64, powerpc, and x86 allmodconfig. It's 
> been built by 0-day and I fixed a couple of issues from that. I imagine 
> a few more might crop up when this is added to linux-next.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Rob Herring (Arm) (6):
>       cpufreq: qcom: Add explicit io.h include for readl/writel_relaxed
>       cpufreq: omap: Drop asm includes
>       cpufreq: armada-8k: Avoid excessive stack usage
>       opp: ti: Drop unnecessary of_match_ptr()
>       cpufreq: Enable COMPILE_TEST on Arm drivers
>       cpufreq: Drop CONFIG_ARM and CONFIG_ARM64 dependency on Arm drivers

Applied. Thanks.

-- 
viresh

