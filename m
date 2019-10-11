Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC70D479A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 20:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfJKS3L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 14:29:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35399 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbfJKS3L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2019 14:29:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so6584119pfw.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2019 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O5o9Mqr/OVet2gVtrM7VOhNOSa7DEH704LnRNkVU6nE=;
        b=h/cAEAJIJooyWocHgl1PJ2HCJ2xWmJqjl4Yy+lENN0kaTpygwmM6fAkXo9ZkNJFHXl
         WO18mghMidJCCyeelOrzgsZ5ofWXt/t83vZn8t5tq7pCVQcn5ib6ZQ7c5pomT0rMdoWy
         KuICDhGFSKLrQvKAIMvH3XONwlCL6svgIe5Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O5o9Mqr/OVet2gVtrM7VOhNOSa7DEH704LnRNkVU6nE=;
        b=bvrJBG4uoqZewQF/EK47is9x52tWEv180vUQn1NioeP+LeB0WkgqXCA/TE4kR3Zccv
         ukO5AyQe7n5NvD+aSFUe8ciYtIg/iZUzhdwDPMylOn2EtF47aMCeE9dXRlmMM7AUXBtu
         wEQ1YjnY6Asmf+w9zkIoPdo5CfvLEDBYf5Ey5//LrtMIis9lHIBCjeor1mblm3csvrn0
         lZRw/7zKaX6JqTRu1+UPnKItsk07OkgAa7eB7pyZ+cm/BxrGblZlB1T0KosoFdJgzS5k
         Ux/G10unyJQ4jOue4fbDbC2CRZx/aUrAvkqzZY3LF300aUcDzseGDKKa9firuTRkyJJy
         34ag==
X-Gm-Message-State: APjAAAVQaKwhplo7kdkkINpEDN9x/lqWYnFUhLzu17tjjkuztCfx36Fx
        BqBttykcHuNc7sjZdCK1qxIxJg==
X-Google-Smtp-Source: APXvYqwk/t3m0uPwdqj+hc3584RGzLLVJTHZ26WbVC2pBTiJOqUqvSRJZAlb+E/la920VhqnV19zIA==
X-Received: by 2002:a62:2643:: with SMTP id m64mr5762842pfm.232.1570818550460;
        Fri, 11 Oct 2019 11:29:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id q204sm12835066pfc.11.2019.10.11.11.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 11:29:09 -0700 (PDT)
Date:   Fri, 11 Oct 2019 11:29:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 6/8] PM / devfreq: Introduce get_freq_range helper
Message-ID: <20191011182907.GN87296@google.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
 <c453bb60a74b41a5192e270f286dfc81c1088449.1570044052.git.leonard.crestez@nxp.com>
 <20191003181938.GJ87296@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191003181938.GJ87296@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 03, 2019 at 11:19:38AM -0700, Matthias Kaehlcke wrote:
> On Wed, Oct 02, 2019 at 10:25:09PM +0300, Leonard Crestez wrote:
> > Moving handling of min/max freq to a single function and call it from
> > update_devfreq and for printing min/max freq values in sysfs.
> > 
> > This changes the behavior of out-of-range min_freq/max_freq: clamping
> > is now done at evaluation time. This means that if an out-of-range
> > constraint is imposed by sysfs and it later becomes valid then it will
> > be enforced.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/devfreq/devfreq.c | 110 +++++++++++++++++++++-----------------
> >  1 file changed, 62 insertions(+), 48 deletions(-)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 87eff789ce24..2d63692903ff 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> >
> > ...
> >
> >  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
> >  			     char *buf)
> >  {
> >  	struct devfreq *df = to_devfreq(dev);
> > +	unsigned long min_freq, max_freq;
> >  
> > -	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
> > +	mutex_lock(&df->lock);
> > +	get_freq_range(df, &min_freq, &max_freq);
> 
> With this min/max_freq shown aren't necessarily those set through sysfs,
> but the aggregated PM QoS values (plus OPP constraints).
> 
> I did some testing with a WIP patch that converts devfreq_cooling.c to
> PM QoS. When reading sysfs min/max values to double check the limits
> set earlier I found it utterly confusing to see the sysfs min/max values
> fluctuating due to thermal throttling, and not being able to see the
> configured values.
> 
> Looks like cpufreq does the same, but I'm not convinced this is a good
> idea. I think we want to display the values set by userspace, as done
> before managing the limits through PM QoS. Viresh, was this change of
> userspace visible behavior done intentionally for cpufreq?

ping

Viresh / devfreq maintainers:

Do we really want to expose through sysfs the potentially constantly
changing aggregate min/max values, instead of those set by userspace?
At least for cpufreq that's a divergence from previous behavior, and
from a userspace perspective it seems odd that you can't reliably read
back the limit set by userspace.
