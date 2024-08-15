Return-Path: <linux-pm+bounces-12253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7329529CF
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 09:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10B11C211CC
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 07:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DFE17AE05;
	Thu, 15 Aug 2024 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hsaF2IFw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7017AE03
	for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2024 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706556; cv=none; b=rPyrwU54XUFLlovIRiceEsdTk+Il8a4UJSflmvpf9OUJLpUoyas7QK0oSMns5fRJxOQkvLbSumD5FTKmcl//szfH+4IbMLT69FyPcB+Q39SLmCZtfVvccwb9936hgxafn148+qeFC9cECYSfc/p/ZmKtIXrks9KW7vbtYD96ecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706556; c=relaxed/simple;
	bh=J0JnP5sTSbfqtp9rSEsTZC/IZ9oSMYmaRLemBLu7fF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsiYWUgxfHhAH8aHaBtO4pX6Od7um3+V6nGpXrDIPNsiNKk2LnXInN4ScFdkTSUDjBCwg1qjnIVM/EuJpeDsVIKctNuBFaCTJgW3sD4fZBoUeazcLFaMszGhS/Hqx4dVO6CoYyS0txpjYaR5uitDAk+d+5AMH0K3UU81vWCBJ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hsaF2IFw; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a263f6439eso534669a12.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2024 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723706555; x=1724311355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPQgXt+/K8hdVrtKvDp/K2jbzvYRDCrHGMGcHAQLofc=;
        b=hsaF2IFwbkorPvGQU47jiZOx4jj1zHMvOl5OovEuS0a5vDneqigM0igNKCZRv7kPxS
         U/sd0FonMmLaUMAyOYHdD4JgyM7mOerHyGtsLHc2BKkJhul2bHiAUnDoIkUf9R/eg6T1
         JyZnC72FD3cG1woTR49VJpelWLO2eP5JYSmBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723706555; x=1724311355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPQgXt+/K8hdVrtKvDp/K2jbzvYRDCrHGMGcHAQLofc=;
        b=T0/o+3ObN96iu2ipdQ1b/ZcSsuWZF12rkjOSj6BKtJFjE0YftVxpO4jZp0i4C3DmFs
         jE2rP3xRz3QjZTae72tDLh/bUidxb5jNBYMieXBVRdNGv/iErZWNHAu/rvo/cz5VkyXb
         5LiFWfpRsG2fk0/aoR1LpONb0t7GU0d1buqGh3BUCRWg2hPymJpNcjWnmQp1InCjTceo
         dyjVK3YveA/JWxUYy5y1ZNDdeVRj3j2XGnM5Cf5AVQJuuT+gZWwbqxJnwHLog0eSkKF+
         YwA8+IW6BbopBjklgrtKEAwc7dACgP0R4w93iBbtkw/S4h2xs87wDkWU62M8nCYNII/n
         wp1g==
X-Forwarded-Encrypted: i=1; AJvYcCWHjW2kBgyHscnvX22pdoFRHUC1kbnB60CJBSvu9iZe+EswOL77lhK3rR0iuE0zRy79MRr0pu//67eOZ+2/Bp1WtjpzxTCXHIg=
X-Gm-Message-State: AOJu0Yyt2NE3bCzQ3F02GYVoIcfptYK14PbFy1LTCdjLK86PQQvRJ9i+
	R6C8AiQTDW/iIed2rHF0lfVaLN4ToGITmcCMm6yO2FCHxrkJ6YAo1opn/aS3zg==
X-Google-Smtp-Source: AGHT+IF/aGc6hHkocmjJlKEUqA+vIlBn3QfPHZ/jI+SDNYKCem3sbWEWjaXISqMqkijXU5e/Tig7ew==
X-Received: by 2002:a17:90a:b392:b0:2c9:359c:b0c with SMTP id 98e67ed59e1d1-2d3aab60a01mr5682803a91.28.1723706554713;
        Thu, 15 Aug 2024 00:22:34 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:745d:58f7:b3cd:901f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7dd457sm2930469a91.21.2024.08.15.00.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:22:34 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:22:29 +0800
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
Subject: Re: [PATCH 4/7] thermal: of: Simplify
 thermal_of_for_each_cooling_maps() with scoped for each OF child loop
Message-ID: <20240815072229.GD350960@google.com>
References: <20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org>
 <20240814-b4-cleanup-h-of-node-put-thermal-v1-4-7a1381e1627e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-b4-cleanup-h-of-node-put-thermal-v1-4-7a1381e1627e@linaro.org>

On Wed, Aug 14, 2024 at 10:17:50PM +0200, Krzysztof Kozlowski wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/thermal/thermal_of.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index fb5472d6ffea..d277165746d5 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -375,7 +375,7 @@ static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
>  					    int (*action)(struct device_node *, int, int,
>  							  struct thermal_zone_device *, struct thermal_cooling_device *))
>  {
> -	struct device_node *tz_np, *cm_np, *child;
> +	struct device_node *tz_np, *cm_np;

Looks like the remaining two pointers are also candidates for cleanup?

>  	int ret = 0;
>  
>  	tz_np = thermal_of_zone_get_by_name(tz);
> @@ -388,12 +388,10 @@ static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
>  	if (!cm_np)
>  		goto out;
>  
> -	for_each_child_of_node(cm_np, child) {
> +	for_each_child_of_node_scoped(cm_np, child) {
>  		ret = thermal_of_for_each_cooling_device(tz_np, child, tz, cdev, action);
> -		if (ret) {
> -			of_node_put(child);
> +		if (ret)
>  			break;
> -		}
>  	}
>  
>  	of_node_put(cm_np);
> 
> -- 
> 2.43.0
> 

