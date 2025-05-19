Return-Path: <linux-pm+bounces-27322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10646ABB701
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 10:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F2E165BB4
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 08:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F410F269D0A;
	Mon, 19 May 2025 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OI5+jU52"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892224676D
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642736; cv=none; b=MrOLsonSxujBhlkTiR8PYmjx4kqQ97wrSURk9Hkix+V5trOLayG81RT7Zv2S+dJOuwQFeWH8TXXX01tGp51EWHy60TYi6iLR7vEc0Pyqsh7cnL1bN0pujg6BdZz5c7FSlJpSodBakB2rAuHFdNxXvjobl0Ru0WCE021648LOJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642736; c=relaxed/simple;
	bh=Wn681Xv/yqYOMFas1Vd76gEewSHlCuTtlwxSjiwuLNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvfENRS66XJuA4HZG6Nmde4fURuGkbCXfz0lWB6ogeut+4kIPEFsDbxZlaV/zY5mmlwohinJkN5t5nmfss93Wg5vLUPL/UlVtYeIPjjFxtguw+XySPt37F6UiKbCsmYSf8BL2eeV8h+aVruMOt7YtKxOX9jChEuAg+DAvTKHMKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OI5+jU52; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b1a1930a922so2749474a12.3
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 01:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747642733; x=1748247533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L/jRk1lKTYKxjfzB0d/5fmN7ISMp4AsTVyPahE4uA88=;
        b=OI5+jU52G9/bHw4sAe702FX6t4MYpHkFlJWM5A56vu64csTOqaCcNd6Ry/CXGJANzr
         Sbxf+PtY7M3MHhDuU0N25zTSggPEXVwv/ByRAyRW/ebQV0t7mOvQrgeasGLdGmnzcies
         vxogiii8JCZTLZTHt3MvReDEWnDCML5UUU6COTaEhYLbjQUPPORFFBzcr7/wjztUMqi/
         mZ8DqOYTtLxjoTazrTzP2gCeiW4bAtOv8lDyUK9DEWBSk0ix27Ml3FoHXhp95ACA7uEa
         PTyY2sespdCUTqLPpDUXu8X58QkdzfeHP0dVdmi/KuLUwCgOjAy/+51SsNfWKffT+IeU
         AZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747642733; x=1748247533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/jRk1lKTYKxjfzB0d/5fmN7ISMp4AsTVyPahE4uA88=;
        b=oalXHYTbVaCTZ6Jis3yYn83kLKs9yzknqni46VIKBt7P9FJxR2lEL+jx8UWy+RwwsJ
         1aI/ygNz807wyGNIl41g6xgQmjj4F5zUCawG69kkgeWhS6UJy1U0TK4kX0/69gDEPh7x
         MCR2P1BntIzJ8b+4knJNncFmMhWtpl2n2DrbiqNN2zUIqE+Ay/CoVPrXPgu1prLUop3r
         q3wN7rAVaYQg6qV30LJLL8Ip5Uhh6df1nyk79H0mUpoL7Vz+wegSlDXE9nTpRhqqP/z6
         jrJBiYvvD/JpHLDVLrNypHp95fwXohPQ/6lxGU/aY40EFQFQYaiLO3ZtzraR+b+JTRJO
         X61w==
X-Forwarded-Encrypted: i=1; AJvYcCWUm3DCs3DyHkvTD+0cyTwTyJ/Ap1rNrJss1mygQIxF6ay5OThazPhltywmRq8+IZnuGMT8V91EaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUL28LZS2j+dIUOki4L5Phutp8zmq2Tw3gGMsJrhWHH3wVgFOs
	xO0n8C7v2ObTvdfG2cAYGRfkOQg2Mel+6eIK5SxwLxVSyWJLXz0DapyVo8fstC944ao=
X-Gm-Gg: ASbGncu4TYH38q8CmxwB9Lv0+emkj/BsMXG+LJeVfcFqD2iFibJzBdWZjvImbIuuxgO
	h6TC+iQo3+B4tznjHLpHP30bB7ZkiFUwR0crcfjnXbWpEOivMPyCJY+ZKwwylp7c9RAOLTm6zHV
	0Jxk+QCzGZ9qTtrSCqjZVfFzJz01RCJnPUSwxAMK5kjfVJT9jNFg49nhljkqnDortYE6OYAXm9f
	MU4ALAL3P1kWMlBLwWC7Q1LUURYTVNNi9zuJJISxCINoEBRMs7lHpyD4HK2MfokrARfXdN6NZfZ
	WgtE/EcZHIthQli5T1ZKSJSgE7ySeYcD8w3ZxtZmcR+VnR4PEYqz
X-Google-Smtp-Source: AGHT+IFABa+b5/H3kNq1B5GdqG8U1MHI7NF5+thziNBuElvttoR7p0nq2thgnZn01iOd4ND/LFuwhA==
X-Received: by 2002:a17:903:2ec8:b0:224:1943:c65 with SMTP id d9443c01a7336-231d44e64e6mr171158295ad.14.1747642733567;
        Mon, 19 May 2025 01:18:53 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97dadsm54603105ad.141.2025.05.19.01.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 01:18:52 -0700 (PDT)
Date: Mon, 19 May 2025 13:48:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, pierre.gondois@arm.com, sumitg@nvidia.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxarm@huawei.com, mario.limonciello@amd.com,
	yumpusamongus@gmail.com, srinivas.pandruvada@linux.intel.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, cenxinghai@h-partners.com,
	yubowen8@huawei.com, hepeng68@huawei.com
Subject: Re: [PATCH] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
Message-ID: <20250519081850.7ycbcw56jzpiwkth@vireshk-i7>
References: <20250507031941.2812701-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507031941.2812701-1-zhenglifeng1@huawei.com>

On 07-05-25, 11:19, Lifeng Zheng wrote:
> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
> driver.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>

Sumit, can you provide your tag if it looks fine to you ?

> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 206079d3bd5b..37065e1b8ebc 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -268,6 +268,60 @@ Description:	Discover CPUs in the same CPU frequency coordination domain
>  		This file is only present if the acpi-cpufreq or the cppc-cpufreq
>  		drivers are in use.
>  
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/auto_select

Is the path correct? Should this be cpufreq/policyN/auto_select ?

> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index b3d74f9adcf0..3c3d00cec298 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -808,10 +808,119 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>  
>  	return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
>  }
> +
> +static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
> +{
> +	bool val;
> +	int ret;
> +
> +	ret = cppc_get_auto_sel(policy->cpu, &val);
> +
> +	/* show "<unsupported>" when this register is not supported by cpc */

s/cpc/cppc/ ?

-- 
viresh

