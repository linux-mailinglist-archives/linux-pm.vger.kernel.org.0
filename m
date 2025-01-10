Return-Path: <linux-pm+bounces-20190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E867A08B5E
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 10:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2293161810
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 09:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB0F20B1E8;
	Fri, 10 Jan 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="j4V8SYHd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E420B1E4
	for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500693; cv=none; b=imy3B5OBifhgI1TUHPcVS12yQ2V0sv/wBdEMZbv/oNd+4W3yQebGM50d+9LD4Uzj6eSeyqSF33AvpLCLoSCAn+7SNmptjR5pZ2ArRhSSZqnU7PSQ5UmJHHGzYe/6WlvxeOtv42RgD92eYgWXzYS2V01NQ3GKV0TYQ7dPrWJ3O98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500693; c=relaxed/simple;
	bh=hNBZxj+ad9sHLm9gjWHtUvBF9UX/L8mW6UuvNNyLd5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMpmGI1Cynzy3Kn6Ybz5Z3gtMb58kxqdIOneQONbPwu6WbxgvBif44n3Ia3afzDAS44aMD1ueNaBGQNljP7vKbCltglKunfZUGcGa7ZvcxC6O7PHDjtTwnqYX6Ui8+FVrq7WbrFTnTCYXLH+jPxANTeFnyYhEKw2euq0FHlf7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=j4V8SYHd; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so3238365a91.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 01:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1736500691; x=1737105491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=py3EM8lNbnLNrhq2yNBY3NFtPh/A/mkth7ZekvKlJJw=;
        b=j4V8SYHdPp97upXRy/Pn2zf/zlRKwCJX5OPB4WBS8NyOad4Uv0bWzmDDlhYT5uPzys
         WOeviq09UugEtifkCs0tJ+SsAGf4n0BCH4hUp8NWpz11jHcyETSpDWBvjd150tyBd5+q
         xiWyP7ejO1A1ZMSfPyhGbsMLBC+tH770t/5Xu4a5FJ5dr39eEcvS91XO/KqS4OfN1sBk
         jtbOHW4uyxL7N0V3iA0/x2jldtchLQewSpcrsatlvjFwvAOe20HyY54ypiceRBgC1C87
         BLTPmduQIzQnH7dxFzpzUIUavXmF9b7WK2kFrBzA7i+O2YGWP/dRG21skPe/RJWF7gSC
         xJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736500691; x=1737105491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=py3EM8lNbnLNrhq2yNBY3NFtPh/A/mkth7ZekvKlJJw=;
        b=S9xpm6cpctWGL0tkj3170FlDvay5gVxAEdXtRy/5yDJoiRMxIcgPLjZoMGfwP4m/L7
         1uIUYFhENiluNZo1KUETy/Yz7LOhHFQsFOf8JBZ0dfQPXWgALNfnE9l0tORJF33o29l9
         nkpYnbTpwTPTW3DKcDgqDrtuo46vVD8ZeFbO33B9BBW4uOnwOc+VJ1xfeTQBe4U+HVx5
         ftaY7WLrYGCbeEdaRunrLbze4yqUDqnPu2hkKFSkGrE7tyjIHkpvtDgGBfGwtXUBB0rM
         EkPiMYXu+/m74Jrf06yqmbDJ3qcrMsbbAnqfg7a/T0hdcHUDvZtoMJhWfMD30SWz917G
         lMOA==
X-Forwarded-Encrypted: i=1; AJvYcCW9T8gECMdW6U1hjrLU5c1PjfvgMxph7XInheSksdHv3wc348lXDkxSGr+N6PRrDCa4M2/2204NvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKZv4fdTJhmQe9nQ1ZlVAVCTq9YBNh0BYXzDklXvMRL01nJ2MQ
	J8C83WWetj+fh81qaJ4s2lPaHjkhMPhdCY72cp06Poz9DhKgXjdl6ztfvGDNcWQ=
X-Gm-Gg: ASbGnctC61hCSW/ZGfFhCCunXNzr0b5Mo30SPxQYqIb1ouvqRXiEO/7kgxkfLMjjE82
	wgaJeW/cuMChod2nQXjSooEQxkcH8i95fal8BumuvPYb0kgmJhO7I5xRc58EQotD69p+Y5VDmk9
	ll6+ZVftUnuRZUt+n/J4CecalssY5F3AoQEQjlvMytzukP6cem14mySmvAWF8qd0Bht9Jtjg5Ml
	oxIC4v1/XBkhAGHXiT2FlNgDYhwrNMh7hpSCvcg5UI9bPlfnk49mkVVV3Oz/ykj
X-Google-Smtp-Source: AGHT+IHtZxzlARbcjSnKtAptD/fYrETaeyk6lZ4ak/9c+R0h45SFgp58K8OMrXoW049gIOQyZ3PYQg==
X-Received: by 2002:a17:90b:274b:b0:2ee:b4d4:69 with SMTP id 98e67ed59e1d1-2f5490eed37mr14549632a91.35.1736500691463;
        Fri, 10 Jan 2025 01:18:11 -0800 (PST)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f259fb5sm10154435ad.239.2025.01.10.01.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:18:10 -0800 (PST)
Date: Fri, 10 Jan 2025 14:48:03 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Pierre Gondois <pierre.gondois@arm.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Move endif to the end of Kconfig file
Message-ID: <Z4Dly1L9UXzpeMrc@sunil-laptop>
References: <84ac7a8fa72a8fe20487bb0a350a758bce060965.1736488384.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ac7a8fa72a8fe20487bb0a350a758bce060965.1736488384.git.viresh.kumar@linaro.org>

On Fri, Jan 10, 2025 at 11:23:10AM +0530, Viresh Kumar wrote:
> It is possible to enable few cpufreq drivers, without the framework
> being enabled. This happened due to a bug while moving the entries
> earlier. Fix it.
> 
> Fixes: 7ee1378736f0 ("cpufreq: Move CPPC configs to common Kconfig and add RISC-V")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index ea9afdc119fb..d64b07ec48e5 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -325,8 +325,6 @@ config QORIQ_CPUFREQ
>  	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
>  	  which are capable of changing the CPU's frequency dynamically.
>  
> -endif
> -
>  config ACPI_CPPC_CPUFREQ
>  	tristate "CPUFreq driver based on the ACPI CPPC spec"
>  	depends on ACPI_PROCESSOR
> @@ -355,4 +353,6 @@ config ACPI_CPPC_CPUFREQ_FIE
>  
>  	  If in doubt, say N.
>  
> +endif
> +
>  endmenu
Thanks! Viresh for fixing this.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>


