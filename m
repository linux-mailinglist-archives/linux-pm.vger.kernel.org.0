Return-Path: <linux-pm+bounces-12255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B99159529F7
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 09:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75702282DD8
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 07:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2B11993B2;
	Thu, 15 Aug 2024 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WH1s4APv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE817B514
	for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723707068; cv=none; b=jv5tFHU3TOe5Fthy7jJTs+h27gTVFb3WKAt9qhdtuZH1AoC8rZDfURrsvWqphDOt9Y/Y/xf5ngkdKmj9xbamfGAGQvGqKggx8g9n8GJTZMbA1GvvXaQerACTCimIh5/rlW0d0fm3n7GdsQLiv1kuugJpfiroKiCOoTA78caDIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723707068; c=relaxed/simple;
	bh=4PE6mZrr8H7PR8eBnAu+UMXSqK7YbiUSYrQYtoLYBqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow/9g+iqdKNM9Pz3l3nt/i3fy6sUxX7IikVz7S6qZpgTk24tbQRWX7p8j5p2B8UqbaTtgMR03iun8vKGpfsRTi1rKXhaIGc8kGCFusCIn2Z/17dhaxizwd3j9Z4EAA0fctcWLavgvJjKiIzj6emjVVhyMR65B74PC1kDMWpwL4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WH1s4APv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-710bdddb95cso427755b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2024 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723707066; x=1724311866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/0W+4K7PrRjUu9VD4koOfW7NXqyGwydvnf3SEGRUt4=;
        b=WH1s4APveZR5KVVNv/1TAYXGHvxlyaZfFMrIEMtbsEMDA/0j3FSbxs4yAYbrBli1/n
         JInNHnFR+7+LxbNk+739zg6YmNd+dxtPLFvNek6LP/1VCaqXbVX+uENW0moUw9WXyrP5
         +AmG2U6N0CU8D0rZG6N8dh+57sqBSYpCBgVCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723707066; x=1724311866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/0W+4K7PrRjUu9VD4koOfW7NXqyGwydvnf3SEGRUt4=;
        b=cyK3+eb5Et8DzorEzscdf6oRiFOqeVeriWgaAcxSApKwCyn30uaHtufCKpqBKdo0bd
         KlLkejJaKugxRhMX0BubpQ2mpe2DGbRbg+mcFgqDaHWPueCHIejTyw26iX7eC6K8jlX5
         69YmANzMScI4g3P95cYacmwtlLjtQ5yqq0lvmAluynBBoCa7UN9pHnHPsO+ogAdFzyfT
         BY6cjHTwuUpO56iv5hzcEG2XFXP7KkUqCl1SiGcw3AbOsQavCGMbAPgQddGAsuqK9fZ1
         p29KSXJbN8yJbtKxqCL88jTyhs11jvx15VcD3XMbeSClZo9SVqG/17paOFycuOSN/4Ks
         shaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8G3jPi7u+EiQtlBoonenvIDfhgG8A5g5OnaFn15tdhwgkHgxwvuW7yo0ttjEVjN33M6s90WJ1DNKKSmHOOxTAgioWjVrUqpQ=
X-Gm-Message-State: AOJu0YwZyvTjh41x7hk3uiUkdlYJxcOx28jKUkp1+ej6qd1JDzYsJse0
	kTpl7sjRkD7w5Xj5QioHNGcC374yYxpv5V/hfZuyyHTNUVbZurkOB7xYUN4/dA==
X-Google-Smtp-Source: AGHT+IGej8YvuGdBMRMsXjNlbIbtoIi0LLSQzAkjZWVd/ikaWZkP42kYpFajA9fEuF1NPTDRfj3RWQ==
X-Received: by 2002:a05:6a20:d706:b0:1c6:fc7d:5546 with SMTP id adf61e73a8af0-1c8eaf59d37mr7069297637.37.1723707065853;
        Thu, 15 Aug 2024 00:31:05 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:745d:58f7:b3cd:901f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af188a4sm559611b3a.164.2024.08.15.00.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:31:05 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:31:00 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 6/7] thermal: tegra: Simplify with scoped for each OF
 child loop
Message-ID: <20240815073100.GF350960@google.com>
References: <20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org>
 <20240814-b4-cleanup-h-of-node-put-thermal-v1-6-7a1381e1627e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-b4-cleanup-h-of-node-put-thermal-v1-6-7a1381e1627e@linaro.org>

On Wed, Aug 14, 2024 at 10:17:52PM +0200, Krzysztof Kozlowski wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/thermal/tegra/soctherm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index a023c948afbd..ff4eedb553fb 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -1651,7 +1651,7 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct tegra_soctherm *ts = dev_get_drvdata(dev);
> -	struct device_node *np_stc, *np_stcc;
> +	struct device_node *np_stc;
>  	const char *name;
>  	int i;
>  
> @@ -1668,7 +1668,7 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
>  		return;
>  	}
>  
> -	for_each_child_of_node(np_stc, np_stcc) {
> +	for_each_child_of_node_scoped(np_stc, np_stcc) {
>  		struct soctherm_throt_cfg *stc;
>  		struct thermal_cooling_device *tcd;
>  		int err;
> @@ -1683,7 +1683,6 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
>  
>  		if (stc->init) {
>  			dev_err(dev, "throttle-cfg: %s: redefined!\n", name);
> -			of_node_put(np_stcc);
>  			break;
>  		}
>  
> 
> -- 
> 2.43.0
> 

