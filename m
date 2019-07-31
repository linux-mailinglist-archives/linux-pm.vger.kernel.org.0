Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 705DF7CC30
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 20:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfGaSoF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 14:44:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47025 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfGaSoF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 14:44:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so66776483ljg.13
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S8iymda7xPMQ4926S35iyef8N5nHE8NRBoOVEkW+KiU=;
        b=MOyunKS4ipxqo9LGPAcFwtqEOm8UGWkGuO7rQLbHcexMrHl3rDvDcdiO4C/Jo5RKI9
         J4nc/lBbKWNLaF+MFCp8pJkWbpFpwXpaEDPUs6xCyXwZXrK3wQWniYdrY/NSf/UAIc1f
         WJSkyj+AFRo5ypChNb3XX+Z8/xrdfdVsppMWYKlwrTj4xdMOfLTMNvsD2d8OGKiS27ny
         jzhap1hRgLGYCamoJYJO9sJOtpJUOFij5jc9V5FtuEmYOwwfVdBmEVjZXIJm94pWEJsq
         4xrheUp7DpybEuiXIh+NOJuyQ5KOK4NlU2zTmGmT3n6FzDJTiDO2LlI7kUsxMYERq126
         mb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S8iymda7xPMQ4926S35iyef8N5nHE8NRBoOVEkW+KiU=;
        b=WXaWhtjfB6EiNJDSIEly/rihY5zS1fTY+Jth4AtrT/vrZxoXzMVD+BFnqMkXLvUtw2
         W/kSLHWA15rSEcnxiZe8oay5wAm9qWB9R537VRsdWOIUhCWmP4rfBjpJ+/CQxOBJMXXc
         XEZ6fPjd4gzU6id1sFtqviH6cKWb46hDgNz3CpolsD+BovpjA5LlT2nzLkAy1X7Gh/nb
         BgRXj1WRuJvBEPmsr63pHmeqQjYHRIR6rNrY6fUC6FdLm/kps+g4bJD+VCOoGlZQocV+
         3U9atuwDMj5yPVpqtNFaIZAMQdPuu0IG/mvuB2qjqQ8s+z7NeON0S4nr58n/f34S3Xjq
         taVA==
X-Gm-Message-State: APjAAAWLxotJMyMfLFoIptX5d6cT/UosauvMGeAzkWclYLIkGKTQMLN7
        HwbyeR7Gq+jcu5ELT80e4AU=
X-Google-Smtp-Source: APXvYqzk/7IbaRdwdAyiPhPaBK+fYqXkLLaHXkk14KwsgUDgjDgxSu4c1Upcw5nTh1Zua41AOjxpdg==
X-Received: by 2002:a2e:994:: with SMTP id 142mr64164643ljj.130.1564598643913;
        Wed, 31 Jul 2019 11:44:03 -0700 (PDT)
Received: from localhost (customer-145-14-112-32.stosn.net. [145.14.112.32])
        by smtp.gmail.com with ESMTPSA id f1sm14065815ljf.53.2019.07.31.11.44.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 11:44:03 -0700 (PDT)
Date:   Wed, 31 Jul 2019 20:44:02 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Use
 devm_add_action_or_reset() helper
Message-ID: <20190731184402.GL3186@bigcity.dyn.berto.se>
References: <20190731125053.14750-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190731125053.14750-1-geert+renesas@glider.be>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2019-07-31 14:50:53 +0200, Geert Uytterhoeven wrote:
> Use the devm_add_action_or_reset() helper instead of open-coding the
> same operations.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index a56463308694e937..2db7e7f8baf939fd 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -443,11 +443,10 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  		if (ret)
>  			goto error_unregister;
>  
> -		ret = devm_add_action(dev, rcar_gen3_hwmon_action, zone);
> -		if (ret) {
> -			rcar_gen3_hwmon_action(zone);
> +		ret = devm_add_action_or_reset(dev, rcar_gen3_hwmon_action,
> +					       zone);
> +		if (ret)
>  			goto error_unregister;
> -		}
>  
>  		ret = of_thermal_get_ntrips(tsc->zone);
>  		if (ret < 0)
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
