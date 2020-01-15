Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B994F13C377
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 14:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgAONqC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 08:46:02 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34534 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgAONqC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 08:46:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id z22so18652739ljg.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 05:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eHGlUjkvC7kMqrOBh/9e8bshdo/yfCGU18peWI5/6W8=;
        b=DhE24ldNaSjlYUh6/Tr6dy8fonM6ZvYmanBVxbRl6ZOzDAD++3XTCF77Z9ebtm73Uk
         phWNLk7inmoF9PEx+K/ZUZjSUv4ZuHDwawi1JFURi105dmiJzelVFaD1iSJD44HQ1reQ
         SmU0NSieBqHR2xwrdLVYtZ77bfAwSve2UUU5I6vJAHsY2GOX4ygSGFXJIqu2NT0Dtx5E
         0NkzRhXjlSU6OQzmUcy8g2f+QDKBD+8NmHrlz0YelcuTfpvMDmfvqU/54fUE4+nd2hiS
         Gsq7MsvGu+VPEp877Y1VWQIoqJtBHehUOirQvkJXprsL/jwJFj6ajwt6kEojh1c3/qAC
         vt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eHGlUjkvC7kMqrOBh/9e8bshdo/yfCGU18peWI5/6W8=;
        b=BrAnKb5dA/1/cQ5bdDbs+IB+L9ntXbucrJkZhQaBudFVfXzXSlhWOfUkU35bJssoFK
         ZIYPmuwuOUUtITswkic205mJA/ziBna5kcPQRKeCj55ILDkx3X6odD/X6hlzMQtH227D
         HMvJYWaFw6dikS4B5ZKVXXvStU1J0GGZqQcb32x5UdTYkK7T6Jr/PyaYacveocoRY2in
         FHkoIQqgEOdYWT/jBpV7rdrNmVQmdAoSctnqyy/ksc7ty2uQH5rHPtfp86pGx6JyoA4Y
         JZ45D7Izq1DbkKOIMfcknXed+sltRif4iRyZdSnLeisBl/x5oJ+bgTLxh9W7uGVQqfpx
         RCUw==
X-Gm-Message-State: APjAAAVSJGIsGdqYSMdZ0yluNKVBDh4+1E3feXtegBdj7K1c8FbUHRP4
        DquB7KsGRnP9IYkdo/GiFROU/w==
X-Google-Smtp-Source: APXvYqyHwnEyO03kLXm2NiclUmJVSUghxTLPNWiIF13hX8TTySX5M0oHRoFxdUDOU+eIuyNboq5mCQ==
X-Received: by 2002:a2e:9a01:: with SMTP id o1mr1826470lji.247.1579095960869;
        Wed, 15 Jan 2020 05:46:00 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
        by smtp.gmail.com with ESMTPSA id 192sm8945471lfh.28.2020.01.15.05.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 05:46:00 -0800 (PST)
Date:   Wed, 15 Jan 2020 14:45:59 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: rcar_thermal: Remove temperature bound
Message-ID: <20200115134559.GA945270@oden.dyn.berto.se>
References: <20200114222945.3128250-1-niklas.soderlund+renesas@ragnatech.se>
 <20200114222945.3128250-2-niklas.soderlund+renesas@ragnatech.se>
 <a98baf8f-e2ef-d77d-ff3c-f5838e268dd7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a98baf8f-e2ef-d77d-ff3c-f5838e268dd7@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Thanks for your feedback.

On 2020-01-15 14:24:30 +0100, Daniel Lezcano wrote:
> On 14/01/2020 23:29, Niklas Söderlund wrote:
> > The hardware manual states that the operation of the sensor is not
> > guaranteed outside the range of -40°C to 125°C, not that the readings
> > are invalid. Remove the bound check and try to deliver temperature
> > readings even if we are outside the guaranteed operation range.
> 
> And what if the sensor is returning crap in this out-of-range operation?

I'm not sure what is worse, reporting an untrue (but still outside the 
guaranteed operation range) extreme temperature or failing with -EIO.  
The view of the hardware guys is that it's better to report what the 
sensor indicates then to return -EIO.

> 
> 
> 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > ---
> >  drivers/thermal/rcar_thermal.c | 7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> > index d0873de718da9218..2ae60b27a0183db1 100644
> > --- a/drivers/thermal/rcar_thermal.c
> > +++ b/drivers/thermal/rcar_thermal.c
> > @@ -275,13 +275,6 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
> >  		tmp = MCELSIUS((priv->ctemp * 5) - 60);
> >  	mutex_unlock(&priv->lock);
> >  
> > -	if ((tmp < MCELSIUS(-45)) || (tmp > MCELSIUS(125))) {
> > -		struct device *dev = rcar_priv_to_dev(priv);
> > -
> > -		dev_err(dev, "it couldn't measure temperature correctly\n");
> > -		return -EIO;
> > -	}
> > -
> >  	*temp = tmp;
> >  
> >  	return 0;
> > 
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 

-- 
Regards,
Niklas Söderlund
