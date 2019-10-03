Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA10ACAF51
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2019 21:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbfJCTgg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Oct 2019 15:36:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43526 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbfJCTgg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2019 15:36:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id v27so2328583pgk.10
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2019 12:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZvvRP7gkLP5an2LWz9E1ke0Xw4siIdz4im6LiZr9lFg=;
        b=HiJl3vpesZuqwM+SmijuoPnUumZoAv3sCg/C/WP/jkGClXCnM2cBWZovl6RscYdUa8
         5+jMD7PJzdUhWqSgiRtfvuhfbzAn4ClW7xdLx0aP8J0b6h4Dz4vZ04jDjS9ZkxPoadgT
         T19rufMDohikjY2k/JmG11wzjEX84oHmwq18E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZvvRP7gkLP5an2LWz9E1ke0Xw4siIdz4im6LiZr9lFg=;
        b=bpCY0Gb/yXCQKq3R9TI+qkbT8hEh5i6uD3L9cQBcO1q7kKOerHHLC8o5b0SkphIPUd
         C5jd/YxK6JWf0VZY//iWmoYINXgySJ1E0RfbfqvNm3L7kHWAo6/dFyQAUHHBUGFRbVEd
         Ym62RmWEZcjawtIXEewekqe7WcNviH4e55DErpAgc6djC4fiy4e9Bavl+6UMGhMOLL+i
         X4Wsp0IFgX8PgbQXX2ShsK1hrdGVkoE+UNFpedK373pJSXoiOzPGgS1VH3bLomL661tZ
         y7YFOoM7ap/0kb0FWB04sE+fqpY1M80CDFNGMYYC60yM7jAhjDLeKQnWRT7F5+bFAxL7
         tHwg==
X-Gm-Message-State: APjAAAUg7MJu5jAAdnajaDSMpJ2G4IAopthgIGYJvyq8sOKISW9O/f3z
        yjpWkgY/SaCPHV73fEqS1soFuQ==
X-Google-Smtp-Source: APXvYqwjpD8GhUhY20mwLWg8zPZOimPm45NzgOBknYjkymmY6DFCgmmBy/IPHPcV1VlbUvoQTZKccg==
X-Received: by 2002:a17:90a:2481:: with SMTP id i1mr12562859pje.77.1570131395126;
        Thu, 03 Oct 2019 12:36:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id l189sm3730845pgd.46.2019.10.03.12.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 12:36:34 -0700 (PDT)
Date:   Thu, 3 Oct 2019 12:36:32 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 6/8] PM / devfreq: Introduce get_freq_range helper
Message-ID: <20191003193632.GK87296@google.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
 <c453bb60a74b41a5192e270f286dfc81c1088449.1570044052.git.leonard.crestez@nxp.com>
 <20191003181938.GJ87296@google.com>
 <VI1PR04MB7023F76F9C7BA20CE54058BEEE9F0@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR04MB7023F76F9C7BA20CE54058BEEE9F0@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 03, 2019 at 07:16:03PM +0000, Leonard Crestez wrote:
> On 03.10.2019 21:19, Matthias Kaehlcke wrote:
> > On Wed, Oct 02, 2019 at 10:25:09PM +0300, Leonard Crestez wrote:
> >> Moving handling of min/max freq to a single function and call it from
> >> update_devfreq and for printing min/max freq values in sysfs.
> >>
> >> This changes the behavior of out-of-range min_freq/max_freq: clamping
> >> is now done at evaluation time. This means that if an out-of-range
> >> constraint is imposed by sysfs and it later becomes valid then it will
> >> be enforced.
> >>
> >> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> >> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> >> ---
> >>   drivers/devfreq/devfreq.c | 110 +++++++++++++++++++++-----------------
> >>   1 file changed, 62 insertions(+), 48 deletions(-)
> >>
> >> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >> index 87eff789ce24..2d63692903ff 100644
> >> --- a/drivers/devfreq/devfreq.c
> >> +++ b/drivers/devfreq/devfreq.c
> >>
> >> ...
> >>
> >>   static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
> >>   			     char *buf)
> >>   {
> >>   	struct devfreq *df = to_devfreq(dev);
> >> +	unsigned long min_freq, max_freq;
> >>   
> >> -	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
> >> +	mutex_lock(&df->lock);
> >> +	get_freq_range(df, &min_freq, &max_freq);
> > 
> > With this min/max_freq shown aren't necessarily those set through sysfs,
> > but the aggregated PM QoS values (plus OPP constraints).
> > 
> > I did some testing with a WIP patch that converts devfreq_cooling.c to
> > PM QoS. When reading sysfs min/max values to double check the limits
> > set earlier I found it utterly confusing to see the sysfs min/max values
> > fluctuating due to thermal throttling, and not being able to see the
> > configured values.
> 
> Isn't current devfreq_cooling based on OPP disabling which modifies 
> scaling_max_freq? This is not a behavior change: reading back always 
> showed the "effective maximum" rather than the value explicitly written 
> to max_freq.

I stand corrected, for devfreq indeed this isn't a behavioral change, and
looking at the diff would have told me. I just expected it to do the
reasonable thing and what cpufreq did in the past.

> This behavior is indeed confusing but can be fixed by adding two new 
> files: user_min/max_freq and user_max_freq. These would act like current 
> min/max_freq on write but on read would only show the value explicitly 
> configured by the user.

It seems the reasonable thing to do, though it's not great to alter
userspace visible behavior :( I doubt though that userspace would really
depend on it, since any min/max value read might change inmediately
afterwards. If there's really value in exposing the aggregate limits it
would probably make sense to do this through separate attributes. Let's
see what devfreq maintainers think.

In any case the patch should be fine as is, since it doesn't introduce the
(IMO) odd behavior.
