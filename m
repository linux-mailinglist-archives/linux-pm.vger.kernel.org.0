Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C917548DDB
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jun 2022 18:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356088AbiFMLtv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jun 2022 07:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356674AbiFMLtZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2022 07:49:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B66F4D250
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 03:53:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f8so4763459plo.9
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1N87jaDz7xgqtRKZ019DqNT4gWSC5vBMC3wZ8eIoED0=;
        b=cng1+RwTADpH1AsFwMkL1lC/l5oylFw7ud76JxPJ+FOEGYwQbX7UTI+rw1XZ5u1uRm
         m4fF+D03MJnp5kZaXpmrsjioE+Wpx3vbMw5DAAT4t7mzUBdfOxPnXTvSmgIc3zZYEGJK
         SkRcZj/NlANQOOF0e0vkalapl9PFbZKcGqDKzjbDCxXF7fHtkJwNXce2ZMxcIlSd1NoA
         Vy0TaE9EGvVaOvddVN15QMJRLpW6Rcw0/QVN1aZvvDGrMJAmGXZ1OweXnLMUe3Sh6sj8
         Lth3xozjAtO+n6QP9O4QGeZCK8v/zDQun2CU/pglp4QamgaRKTP6rKAaZu7jvkcYJe1O
         FBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1N87jaDz7xgqtRKZ019DqNT4gWSC5vBMC3wZ8eIoED0=;
        b=r8ElQeiMh9EsGwZSJnx1sueOFur5wtHdfF1WssDfymQ1qAEo7hwV0SEqIh6rC235Vy
         8mJ92qtxdJHpu4/nbnbM+k2PCDxaxBrTXb1eeQvytAMBPnId6w/VxXv/8w4jU8i122g/
         zbaEZ+HeBJfe+wnCTy9H4NF89mwGMwCEx6V0h+VhZo2GUdlmqJ7qy/OTaFw9qJJmRtef
         JRd5LAdvxld26zTCP7sU3Yy5EGwAzahxuI+1+HVtYHX3qnzpaXDHeuXApXfA/8I9QA8/
         nl29LSQzAZppnnoi+eM7ynikBAZjH7vng52gz/XCCG1QDvV36rUCqWDoR7VThd9ieyXC
         vlIg==
X-Gm-Message-State: AOAM533V6Ou0oHbk2d+D3tAMjQIkd1S3sUeqt6PPn7giUGXljS6DLJsA
        ul1IaBvfdGaFbl9ygtkdYtSWKQ==
X-Google-Smtp-Source: ABdhPJzv7fAvDHLRtPrKRU9YnGV8eNC8Rg2x+oIW99aqPnlO6EYF9j5QNrlXqk9ijEBjA9I1+j5onw==
X-Received: by 2002:a17:90a:fb90:b0:1e3:809:9296 with SMTP id cp16-20020a17090afb9000b001e308099296mr14859426pjb.26.1655117593809;
        Mon, 13 Jun 2022 03:53:13 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id i26-20020aa796fa000000b0050dc76281e5sm5004773pfq.191.2022.06.13.03.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 03:53:13 -0700 (PDT)
Date:   Mon, 13 Jun 2022 16:23:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/3] thermal: cpufreq_cooling: Use a copy of local ops
 for each cooling device
Message-ID: <20220613105311.jdyjubid4jrgofwu@vireshk-i7>
References: <20220610100343.32378-1-lukasz.luba@arm.com>
 <20220613091611.ncd2hziu4nbyip4x@vireshk-i7>
 <5bac6f98-e1ba-3584-6eac-21eeaaa0ed26@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bac6f98-e1ba-3584-6eac-21eeaaa0ed26@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-06-22, 11:37, Lukasz Luba wrote:
> Hi Viresh,
> 
> Thank you for the ACKs in the other patches and suggestion in this one.
> 
> On 6/13/22 10:16, Viresh Kumar wrote:
> > On 10-06-22, 11:03, Lukasz Luba wrote:
> > > It is very unlikely that one CPU cluster would have the EM and some other
> > > won't have it (because EM registration failed or DT lacks needed entry).
> > > Although, we should avoid modifying global variable with callbacks anyway.
> > > Redesign this and add safety for such situation.
> > > 
> > > Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > > ---
> > >   drivers/thermal/cpufreq_cooling.c | 16 +++++++++++++---
> > >   1 file changed, 13 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> > > index b8151d95a806..e33183785fac 100644
> > > --- a/drivers/thermal/cpufreq_cooling.c
> > > +++ b/drivers/thermal/cpufreq_cooling.c
> > > @@ -554,7 +554,12 @@ __cpufreq_cooling_register(struct device_node *np,
> > >   	/* max_level is an index, not a counter */
> > >   	cpufreq_cdev->max_level = i - 1;
> > > -	cooling_ops = &cpufreq_cooling_ops;
> > > +	cooling_ops = kmemdup(&cpufreq_cooling_ops, sizeof(*cooling_ops),
> > > +			      GFP_KERNEL);
> > 
> > I don't like the way we are duplicating the ops here. Instead of this it would
> > be better to add the OPs field in the cooling device structure and fill its
> > fields from here. The ops structure will be allocated with the cooling device
> > itself.
> > 
> 
> I think I know what you mean. Make sense. There are quite a few
> different cooling types of devices which are using the API
> thermal_of_cooling_device_register() with the custom 'ops'. We
> probably don't want to disturb that well working drivers and ecosystem.

I was just suggesting to update "struct cpufreq_cooling_device" :)

This is what I was, wrongly, referring to as cooling device.

I should have written the exact structure name instead, my bad.

-- 
viresh
