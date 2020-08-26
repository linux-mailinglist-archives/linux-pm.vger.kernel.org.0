Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C98125256A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 04:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgHZCN0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 22:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgHZCNZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 22:13:25 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E581C061574;
        Tue, 25 Aug 2020 19:13:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h2so161221plr.0;
        Tue, 25 Aug 2020 19:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ya98ef+/yWr62GPjK6TeHgnvBk1gqF36gDLfJaPgUqI=;
        b=jEspkbfWJ/4f9AqvNGkGAQcsMzoRdYhaH80VvRphgvfdIbE/QNtlCZlTWpgrJNoSdw
         Ah+yvzZwOjlfzGCdtLhcQ2Wt2kWoGiezM+8NJFSSxNSH3gGs51sajTPKqt60cf7cMAAq
         SgtVirUTYmZgBAtl7cEWwOnqaA/3aXQRPamkSnJhH6y9RT43LdcF9QE1k004w8Ap2ylS
         ZmQPiPOAM16iwV89hiIQSoKXi/RGYPaK1x7Q/ywB2tKH9zz+uWa0HU7p4ZyQ5DCJ2gDx
         sSZVAyLs4NK87SmwvSGC/DGBD1ZBonbSMb3Gw8WMlf07/kGvkQ+js4KydsmsTymLQM/W
         KlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ya98ef+/yWr62GPjK6TeHgnvBk1gqF36gDLfJaPgUqI=;
        b=BlSvy9d/C44oc9g/coeQs132Pe+ZK7MbOaHuBHbGR+rOPRGmadxflGlEkCXZV9erLr
         jL2Gxx8l9SVzTBjWrAzRknllxDAAXuke33bXyEn7MRiOF2JSKjMoStc/OQWzrH9jG2JP
         8L5nnE+76ZkV0Lmjt9GaaTSveQIJOqegwzeDohMlH38J8aZfDYquX3KgcKCCdxFyTnOz
         DT6gaQeCRz/FQMg7uX0giIX1x04bzgBWC13Fs4AjTh1BAiQZodhz/J58B4miRYcHvGDy
         zoIWcSU1Q+66rLLz/q7lB22l1OetrljoKfVaoUKejEuiG7jqaXCtqcyXxuLdijyKFF9r
         VVnQ==
X-Gm-Message-State: AOAM5329rg8t+11CxWF98V8oVBfT+h0uSH3kuGTfKPa8sew60HKt8B+h
        A0MZt9cpqNdso0xF7UnxJl4=
X-Google-Smtp-Source: ABdhPJxrZEpGnKI21fTrcPfhI0GDg36KQnJqOnvWy6MnQhufEYwtSUb4XhoYIpbmAS4C6xuVJHrwnw==
X-Received: by 2002:a17:90a:1a42:: with SMTP id 2mr3819867pjl.16.1598407998965;
        Tue, 25 Aug 2020 19:13:18 -0700 (PDT)
Received: from localhost ([124.156.176.71])
        by smtp.gmail.com with ESMTPSA id v1sm341780pjh.16.2020.08.25.19.13.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 19:13:18 -0700 (PDT)
Date:   Wed, 26 Aug 2020 10:13:19 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] thermal: sysfs: fall back to vzalloc for cooling
 device's statistics
Message-ID: <20200826101319.00003048.zbestahu@gmail.com>
In-Reply-To: <40b69f97-46e5-d62e-0d2f-604dfd4dafa1@linaro.org>
References: <20200818063005.13828-1-zbestahu@gmail.com>
        <40b69f97-46e5-d62e-0d2f-604dfd4dafa1@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 24 Aug 2020 12:40:35 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On 18/08/2020 08:30, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > We observed warning about kzalloc() when register thermal cooling device
> > in backlight_device_register(). backlight display can be a cooling device
> > since reducing screen brightness will can help reduce temperature.
> > 
> > However, ->get_max_state of backlight will assign max brightness of 1024
> > to states. The memory size can be getting 1MB+ due to states * states.  
> 
> What are the benefits of a 1024 states cooling device ? Is the
> difference noticeable with a such small step ?

Okay, this issue is happened under MSM/Android platform. QCOM spmi wled driver
will define the max brightness. We needs to fix the issue to get thermal statistics.

Thx.

> 
> 
> > That is so large to trigger kmalloc() warning.
> > 
> > So, let's remove it and try vzalloc() if kzalloc() fails.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  drivers/thermal/thermal_sysfs.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> > index aa99edb..9bae0b6 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> >  #include <linux/slab.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/mm.h>
> >  #include <linux/string.h>
> >  #include <linux/jiffies.h>
> >  
> > @@ -919,7 +921,9 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
> >  	var += sizeof(*stats->time_in_state) * states;
> >  	var += sizeof(*stats->trans_table) * states * states;
> >  
> > -	stats = kzalloc(var, GFP_KERNEL);
> > +	stats = kzalloc(var, GFP_KERNEL | __GFP_NOWARN);
> > +	if (!stats)
> > +		stats = vzalloc(var);
> >  	if (!stats)
> >  		return;
> >  
> > @@ -938,7 +942,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
> >  
> >  static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
> >  {
> > -	kfree(cdev->stats);
> > +	kvfree(cdev->stats);
> >  	cdev->stats = NULL;
> >  }
> >  
> >   
> 
> 

