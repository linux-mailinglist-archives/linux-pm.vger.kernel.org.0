Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAE13140E94
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 17:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgAQQFG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 11:05:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42022 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgAQQFF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 11:05:05 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so18736195lfl.9
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 08:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RgG7N9ZDMVD+fLC6iASQWNL3LMTCs6ZQqbIhjiOECRA=;
        b=rOlhIgQU5VzTpmz938HjLGKW4Gv8Yiq/prXMN/cZ0AAFc0zi28esxj494H532vsfDO
         95FXPaAOE4PO5EKpfRc6dppOhv3mlNk6SMbFftnGti58dhkc8jcp84YZXnRDdGZAldhN
         5YyUe8sh+kZRJZ+hMz7+GCeMeTYl/b94UyhEZ58tGbULxcP0noUgfEkd5MCBEcOuwmmQ
         qJNV+ck1exbN4W+y9COCP+QdI4gfk0poxtOw1hedD85b4rHu77Haa23XOppjpyRwILcb
         C2pJeoK3gEKnzhxJP6Aa4fRco5+tfU1/Ve0DAy1LpCuQk/LPegysf+LQY8a5i2v9fDCa
         5d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RgG7N9ZDMVD+fLC6iASQWNL3LMTCs6ZQqbIhjiOECRA=;
        b=MOVHQWa+N1YD6zqeV42MW2eTNKF8NRBHjRU9PcD5A7hP0iWKaffNdENGglyUGYeQYC
         KRzap9Js1+9BldNhoR0TofLaliBXH6AkcUpMMQyp26ZSD4yXzg8HzIcSi1qM2aejW6mk
         kCQMdYCL4aTs2kRCfdH/nlqUSzyRcIjYKMSXqR11YQHzFG266GGzVXx0SsL0j321Ada1
         c4m5FK1obY/OJsLKibFjS3SLQrYbF8cdRdsUeLqs7t29tDx6HsfVAimEm4d5Q4tZRD14
         PXzo7KNEAhy1oH5SogRTf3PPMvpC3skS4vv+5qjOPDvtJs/l41zHGPDAXFLIpv593hef
         1u8Q==
X-Gm-Message-State: APjAAAWfmcsq3yR9HcnStMD97MnzbXHUxu4Y41jCb/P9V7w8ySQgGAVr
        6cmnVL405JPl1gWsjowH1/jlbsJu+8w=
X-Google-Smtp-Source: APXvYqwh9KSPm/AWVQ1swp+Vr/DgqtRMSjh5Mgoxy23bK1BbvZDvS1QC0cFj306/JP7LABgC5KOSQA==
X-Received: by 2002:ac2:5f59:: with SMTP id 25mr5717577lfz.193.1579277103319;
        Fri, 17 Jan 2020 08:05:03 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
        by smtp.gmail.com with ESMTPSA id b1sm14613299ljp.72.2020.01.17.08.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:05:02 -0800 (PST)
Date:   Fri, 17 Jan 2020 17:05:02 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] thermal: rcar_thermal: Remove temperature bound
Message-ID: <20200117160502.GC1074550@oden.dyn.berto.se>
References: <20200117152242.3804288-1-niklas.soderlund+renesas@ragnatech.se>
 <20200117152242.3804288-2-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117152242.3804288-2-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-01-17 16:22:41 +0100, Niklas Söderlund wrote:
> The hardware manual states that the operation of the sensor is not
> guaranteed outside the range of -45°C to 125°C, not that the readings
> are invalid. Remove the bound check and try to deliver temperature
> readings even if we are outside the guaranteed operation range.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
> * Changes since v2
> - Preserver the guaranteed operating range in a comment.
> ---
>  drivers/thermal/rcar_thermal.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index d0873de718da9218..f9c1fa10e6a2b3fd 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -275,12 +275,7 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
>  		tmp = MCELSIUS((priv->ctemp * 5) - 60);
>  	mutex_unlock(&priv->lock);
>  
> -	if ((tmp < MCELSIUS(-45)) || (tmp > MCELSIUS(125))) {
> -		struct device *dev = rcar_priv_to_dev(priv);
> -
> -		dev_err(dev, "it couldn't measure temperature correctly\n");
> -		return -EIO;
> -	}
> +	/* Guaranteed operating ragne is -45C to 125C. */

s/ragne/range/

A bit embarrassing, sometime my hands can't keep up... Will send v3.

>  
>  	*temp = tmp;
>  
> -- 
> 2.24.1
> 

-- 
Regards,
Niklas Söderlund
