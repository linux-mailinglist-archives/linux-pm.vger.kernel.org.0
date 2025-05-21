Return-Path: <linux-pm+bounces-27447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631C5ABF207
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 12:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46EB1BC0B55
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 10:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9280B25A2AE;
	Wed, 21 May 2025 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWmo0PFb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD3C23BCF7
	for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824516; cv=none; b=rCg7hw+YS5RdTH+BRvWyfC6x8TtuOpR2nAvY3EiYunkIG9gm8UbxJvSMeyXv3iXLGlhAa5Q2/A6Go03D0ESMeGp5C4bIt0QceeqhJP8hclEvykCMhSdhh2gJkwYSVV29JeMbg58i46z+7gaWcQg/vz8BzNn+prJusX2zMTBdzHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824516; c=relaxed/simple;
	bh=zPVzcQ0wTxrrLosGxnFrsJYeTgPP4pLFOuxsLK0tQi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=an5WrECsrUYLMXUYzyF0+MJh8ad0yNDhpgL8gDV8t1+YTajUm0tyZlFbwyMa+GYMMhgYWEuCMInrL7pyfRftZzQK4rJng+GQwHpXh7gDUDGl17JcHJS10t+Cg+Sqj7IQKH8D0hl53Uo7HpemocMnGvBtV6S1HyhUgGgyOA0bzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TWmo0PFb; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b200047a6a5so6625667a12.0
        for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 03:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747824514; x=1748429314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCVWhmhVUwvSreyj85yNDnhSC1O4ImPSH+cKpWIfIvs=;
        b=TWmo0PFbGW/+u+YBHCF0aIFcD79Rxb6H/XY7PWwXeUbdec5sxkaJvoyXvyXr+lT+Vt
         xmOc4laQaTr/iPFU2fdf56pr/sHvDM0Xk2Oxr89sswftvo/viMQDgyGL5MirLcsSKrRI
         0zAEIdHpxD1gNVWwvWFUXrECi6P+tkwI4qBay4zmlEg08chOHHuNYXqykR6iVpE9zXn9
         2v3A0+bgfjm+PjYXOT2g7A7IhJwDIUJCoWKrlkIhbjdaQcIuKVWEKZLUNlKsDlEvBuvl
         b1IJ8bLihi6PqIpAkb5+Li4l99bv+kizHXQkPRuTbIz34SKps6Hg7c0V3oTdmltl+NdA
         gSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747824514; x=1748429314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCVWhmhVUwvSreyj85yNDnhSC1O4ImPSH+cKpWIfIvs=;
        b=bRQIWXHAKjDzBvCp9lvIH2HySbvpYqlwNjVf0RPXBHsPrPHXwlgOqPlUMWeyHUALTk
         ykYdVnyMM5X9/sMBOSnYMbC8ogXGYhGPvhu/0wtrkec3koFRhuWE4IWHmW6DWoDTxs9d
         Cob0jn9Na234xcouPwRayM2XCwSuaCdRID2CY1bP0HpYvGTg5ZEnrG7xBpyi4DHJb09S
         4yTJuh100N7vdjqXSXxTQInkHIDI92mX4uBZ8xm7+Zet4ZvpTQOgqlLzMpxatxSfF+ze
         lgZ/YrlBRELvyPFIJbYUe7XK4k4FJt3qOkBYGHgK7/LwFE/LYORoPdaWs5RBnBjCxzGx
         zncA==
X-Forwarded-Encrypted: i=1; AJvYcCXA8rMlzN5OgUXxa1FQdi3kb4SKecKWn2HJy7L9Hgr+lYb/PE8fC20aLSmmP3t/M0TJlU1u0iipiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YybxGxGKad7mlSXGHZHkSLloZyQHwoeesOz2x/s/7RjJ3ANAHY8
	+4v2GWpu8jzjXVxsBZIZQM9/KX/NxoaD8GJLPphrhGe/FK3uyJUPLDkvH1FPeSstVsM=
X-Gm-Gg: ASbGnctL3GVXX+OnMkLOM6oDfZUsrFshdNdGzjKYow3fzkaDkkJyFbtRbcT4gwUefo1
	1NECfMUBWNscvIKiWDdaNdLl+7iWJvHo7h7voB5JSlbRKhqOxJ24SMpXpKHnpHVS5GvboTFvv2q
	zyPWBxW+b9tMA8qK7hUUH0giO0GznFRys/njexSm/Dp759g2TzGG5lUtsOn7oaISBCsOIeM3ZkU
	Yt3FNaptc6uThyCAsBvqicJ9blqbAAZQxX/n2Z64UOYQxBOlHsm8L2XcFB0GVCZALdF5oZ972hf
	5BvMmAV7Yo7hbRoMG8lN9bWdxP63Kaeoy1VOawPSLdgO2C3BnYnw
X-Google-Smtp-Source: AGHT+IGdd5dXeRvluDlCSAr/KcDBCCa0Jpvf2y620qpFkldBXh7b0d+mATtYjpGqsll1Ytp7og51QA==
X-Received: by 2002:a17:903:2ec3:b0:215:a2f4:d4ab with SMTP id d9443c01a7336-231d4b05c54mr265369065ad.7.1747824514174;
        Wed, 21 May 2025 03:48:34 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac94a0sm90907755ad.2.2025.05.21.03.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 03:48:33 -0700 (PDT)
Date: Wed, 21 May 2025 16:18:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: rafael@kernel.org, Sumit Gupta <sumitg@nvidia.com>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linuxarm@huawei.com, mario.limonciello@amd.com,
	yumpusamongus@gmail.com, srinivas.pandruvada@linux.intel.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, cenxinghai@h-partners.com,
	yubowen8@huawei.com, hepeng68@huawei.com,
	linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
Message-ID: <20250521104831.6a3qfhzrwf2mcnyu@vireshk-i7>
References: <20250507031941.2812701-1-zhenglifeng1@huawei.com>
 <98c87824-2c77-4ae3-b466-badd8e8187ad@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98c87824-2c77-4ae3-b466-badd8e8187ad@nvidia.com>

On 21-05-25, 16:13, Sumit Gupta wrote:
> 
> 
> On 07/05/25 08:49, Lifeng Zheng wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
> > driver.
> > 
> > Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> 
> Looks good to me.
> 
> Reviewed-by: Sumit Gupta <sumitg@nvidia.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Rafael, since I have already sent the pull request, can you please
take it directly ? Thanks.

-- 
viresh

