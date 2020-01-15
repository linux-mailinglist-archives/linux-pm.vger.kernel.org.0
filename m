Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02A2F13CCB8
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 20:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgAOTAq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 14:00:46 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37177 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgAOTAq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 14:00:46 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so13552874lfc.4
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 11:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kkSb5XFjVAdxecaVMhl5npWQb18A0fEroSSW8nmnqso=;
        b=1Po/Nr5guIuj6JQYoyc/KkE2nefZ1byRnzhIL0cZAsK3RGvI3fJkEkY/bGk0cTkAd0
         kDWjA6dRSCzLUtSg//R1d2EBfjBhdbpy5H1KiaHH1kh8p3Za2iyUn4CGU9Nju9vPFfC5
         WeFvK9LySoUYs9HGaIQxIQGPcXYWRxFXbUUzo6hTSHUfZzdR/0/FGYs2H14kVKEa/5Zb
         y3zne2qaISLAtJbrG4ZY4akS/967WJ/+TdjfJQau7TTugw1S2gsGvLSUGgwazUk24DgN
         7qUWFg9CIRCNw3+tn5upPxxwCMTDxLKaptys5FaGYqqeg3VLsSVcLBPtpql+Es9depwN
         wwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kkSb5XFjVAdxecaVMhl5npWQb18A0fEroSSW8nmnqso=;
        b=SES6k9J92gloBobl/a9jduJvQhoqqe3QXXA6AJJM0btzqaD+2afdKjy66+Sl0TqmzL
         JfWl1IBgqpt8ZMz9y+Mnko4pPWeavo5LQQMZ87pQ9KO6X4SdZ191yAfb9DfEvj2q2qXs
         PJ1ggY7Vqq+609FxVTspgKcsU9L+F+rl/UNA9bMGJwXR2v2EQxH4TjC+b+DlJd17nVyQ
         ZF4emWpob2sH62PBsPF3tTfVsb5czYaEOFjTNO+k4dwFwn8eK6Jrd1MtdsqX94a2QNjp
         1bSDrYKzlUxk6+ND/hQCCzRuU466inZA82m6OHhzY1E7rWxFU4/GaEuLjTSnFs7nCkLx
         k2Tw==
X-Gm-Message-State: APjAAAX8WYE+uAO6DTEWRN2pwuF5HSOXQlLpWPtvbjD/8ZWu+EG7Wq2H
        x/ScuGKdkLQYInNuD5c0L6ZxKw==
X-Google-Smtp-Source: APXvYqwbotwNaG3js+/LSjbpf1LJM+qnAsB5qH1RGXygA8dGWsziSSyAsUNJzuGJL5tdkzmeUhMdXw==
X-Received: by 2002:ac2:50da:: with SMTP id h26mr235067lfm.80.1579114843968;
        Wed, 15 Jan 2020 11:00:43 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
        by smtp.gmail.com with ESMTPSA id y29sm9522204ljd.88.2020.01.15.11.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 11:00:43 -0800 (PST)
Date:   Wed, 15 Jan 2020 20:00:42 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: rcar_thermal: Remove temperature bound
Message-ID: <20200115190042.GB979534@oden.dyn.berto.se>
References: <20200114222945.3128250-1-niklas.soderlund+renesas@ragnatech.se>
 <20200114222945.3128250-2-niklas.soderlund+renesas@ragnatech.se>
 <a98baf8f-e2ef-d77d-ff3c-f5838e268dd7@linaro.org>
 <20200115134559.GA945270@oden.dyn.berto.se>
 <d7c7bb44-897d-a3a3-c203-d87ffb7de9be@linaro.org>
 <20200115183940.GA979534@oden.dyn.berto.se>
 <710eeff0-e8f4-5f03-836a-6a2e87e415e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <710eeff0-e8f4-5f03-836a-6a2e87e415e8@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-01-15 19:52:25 +0100, Daniel Lezcano wrote:
> On 15/01/2020 19:39, Niklas Söderlund wrote:
> > Hi Daniel,
> > 
> > On 2020-01-15 19:15:11 +0100, Daniel Lezcano wrote:
> >> On 15/01/2020 14:45, Niklas Söderlund wrote:
> >>> Hi Daniel,
> >>>
> >>> Thanks for your feedback.
> >>>
> >>> On 2020-01-15 14:24:30 +0100, Daniel Lezcano wrote:
> >>>> On 14/01/2020 23:29, Niklas Söderlund wrote:
> >>>>> The hardware manual states that the operation of the sensor is not
> >>>>> guaranteed outside the range of -40°C to 125°C, not that the readings
> >>>>> are invalid. Remove the bound check and try to deliver temperature
> >>>>> readings even if we are outside the guaranteed operation range.
> >>>>
> >>>> And what if the sensor is returning crap in this out-of-range operation?
> >>>
> >>> I'm not sure what is worse, reporting an untrue (but still outside the 
> >>> guaranteed operation range) extreme temperature or failing with -EIO.  
> >>> The view of the hardware guys is that it's better to report what the 
> >>> sensor indicates then to return -EIO.
> >>
> >> I don't get the point.
> >>
> >> What happens if we read the sensor while it is above or below the limits?
> > 
> > The manual describes the read outs as being +/- 2°C from the true 
> > temperature for the guaranteed operating range. Outside this range the 
> > difference between the true temperature and the read out temperature 
> > might be larger than 2°C.
> 
> Ok, I see the point now. I guess in any case the SoC won't be working
> very well outside of these operating range also.
> 
> It would be interesting to add in the core code a warning when reaching
> the sensor's operating range. Please replace the code deletion in your
> patches by a comment keeping the range values for reference if we add a
> sensor boundaries property later.

Thanks, will do and post a v2.

> 
> Thanks
>   -- Daniel
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
