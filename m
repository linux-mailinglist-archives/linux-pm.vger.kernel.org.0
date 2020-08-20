Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE4024AF66
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 08:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgHTGpU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 02:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgHTGpU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 02:45:20 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C79C061757
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 23:45:19 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x24so375440lfe.11
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 23:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZCw+J3eNKvckpSGIv9R1A41dRAL10YAzemWWZZj2TxM=;
        b=gn4feuvIJRGcm17jNvIi+Cs0oQkhPwFrCcF1fwZXkZsTBCf1COMIIzY9I3aoT1OO+D
         j8Ro8j93yknlukw/XCHHy/tpUxs5i6s2i6XuFepcDMxFfEtIRmr39aXwsi0MOaCxZQAH
         aJ5Z46auWf3uLNrTsxfSDedLWaRyb8P55xL8CRuBDRZlS09EawojZC3YNm3FkHCt0CPJ
         b8BqVrItpwW6qNYBqd84jEDIYSh20ou4l8zb47H5Mg2UUYH/yAHAeLSfkPVk5SJxbdWR
         nMNxEPunJJ0bWJ74vQqG66BdOjWdefZxFb9kV1Gb3ph+dGDg1xQcWjQLIpJjUzGNmTb1
         8AJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZCw+J3eNKvckpSGIv9R1A41dRAL10YAzemWWZZj2TxM=;
        b=Q0XNNKm39M2jPGG9lHSQKyshebtVFs+UAOBJR3DE1WNWdYx8FIvzKvjD7md2BJsTDa
         6bHPVchLRAjZ23rtZxa9XNr7OlUg2BhVk0wQDj79nadG1hM68F788M/cXw3zFT5PDiQc
         8IcVR9h4sT4q/PQTEaLRqU3nvcItWiIzrHkMYH5rUdA7i6VmCdbdgPRFaPypDsYnuP47
         56VUlwkF2aH5jHNniWmyFhGj/4PqEMvH0u7fun/TIWIAbx9OLClFAFaMNGI4ZhYXKcT1
         8sGsyZ8xjTqOUYGr0sCtYoiG5+PcENP55r/YauBGm+66A/GXhjUfBRNNjb0tF1pX/k5N
         vSHg==
X-Gm-Message-State: AOAM530lyHxYylGMdY4pKf7eOBfHJN5PqY424SSR08tziHYPAoYcCy4W
        y0ENq3bgtm99HXh3K1hlwmBAUQ==
X-Google-Smtp-Source: ABdhPJynGUW99aFPoSyRjPgckV+XoFAgcLbRS9hMSatRFjRqiz5jjL87Dz4FdSu2A+dvMdSEDdFfCQ==
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr872579lfz.157.1597905918034;
        Wed, 19 Aug 2020 23:45:18 -0700 (PDT)
Received: from localhost (host-78-79-224-122.mobileonline.telia.com. [78.79.224.122])
        by smtp.gmail.com with ESMTPSA id h26sm283755lfj.20.2020.08.19.23.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 23:45:16 -0700 (PDT)
Date:   Thu, 20 Aug 2020 08:45:14 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: rcar_thermal: Add missing braces to conditional
 statement
Message-ID: <20200820064514.GA33898@wyvern>
References: <20200819092716.3191-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200819092716.3191-1-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2020-08-19 11:27:16 +0200, Geert Uytterhoeven wrote:
> According to Documentation/process/coding-style.rst, if one branch of a
> conditional statement needs braces, both branches should use braces.
> 
> Fixes: bbcf90c0646ac797 ("thermal: Explicitly enable non-changing thermal zone devices")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/rcar_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 787710bb88fee890..5c2a13bf249ccb87 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -546,11 +546,11 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  		if (ret < 0)
>  			goto error_unregister;
>  
> -		if (chip->use_of_thermal)
> +		if (chip->use_of_thermal) {
>  			priv->zone = devm_thermal_zone_of_sensor_register(
>  						dev, i, priv,
>  						&rcar_thermal_zone_of_ops);
> -		else {
> +		} else {
>  			priv->zone = thermal_zone_device_register(
>  						"rcar_thermal",
>  						1, 0, priv,
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
