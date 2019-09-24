Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7B5BD26E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 21:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437013AbfIXTL2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 15:11:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40085 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437011AbfIXTL2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 15:11:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so1912579pfb.7
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2019 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DR2VitmOL1QcaChutYPiTVC0w58w/UkjdupN/fmWcR4=;
        b=HJNRMaM2N+FZ/gIAOAKQam1gJGnSw9J/vcA+UJZH5iJdYFXdgiTGlvxjT3t3euachh
         juH6Eh+uazNTGHOM2DFeSbwCTgUq74sizZEQi73PaIEj+kTHzmllAUtJ63ABesG2dPRH
         VLG8lM1cJe59PxURS6nBrK6nB9UCwlc7wXYLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DR2VitmOL1QcaChutYPiTVC0w58w/UkjdupN/fmWcR4=;
        b=fibTnnJBdwphsVRZQbAkHrEP0NIkWG5deLeMr0FDAj3H2Pc0aF2Y/Vew3N0qIyXeai
         gisFi4FRrpf8exfacRKcKi9xdXM122epmtCymLsoo8WroX1cJNmFbAmJtYYKdkcp2d9m
         OapSvqP/ZZDxm7YixMVFiElja+nHFlHqKr0G9ch3Y8/8HoTV6Yl/UpUA91TBdjh33VRz
         140apq8Xjrv3TD5pQvxBjZKYGw4QkxQgKaQtFlzYu7cJc3TS/IKGtUAMmeMSa5FPBk46
         t2oGddEnB+ZStyHqB0s8wqyDOfi3wMdrmM59s+wEvKRnQZqxFkaxU7sO1u+FOnzLX/FP
         F2OA==
X-Gm-Message-State: APjAAAXLx7w8APcIya+ai2/45l26tiNHvq4ZhaH+fuwZ5ns5w0mRSFpY
        AxEmZQUha6eJ6pWNkNopLEbd0Q==
X-Google-Smtp-Source: APXvYqymt/aK7Y4we0b/lvxFn9Qe8uVGQPu8bA3GOe2Lv0/RUV+DaR0eX9nkbfIlmO29Kxnj+WlZog==
X-Received: by 2002:aa7:8b17:: with SMTP id f23mr5180364pfd.143.1569352287524;
        Tue, 24 Sep 2019 12:11:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 26sm704115pjg.21.2019.09.24.12.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 12:11:26 -0700 (PDT)
Date:   Tue, 24 Sep 2019 12:11:24 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 5/6] PM / devfreq: Add PM QoS support
Message-ID: <20190924191124.GJ133864@google.com>
References: <cover.1569319738.git.leonard.crestez@nxp.com>
 <58fdd2c226a4e76a3d9427baab7dd5c23af842ab.1569319738.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58fdd2c226a4e76a3d9427baab7dd5c23af842ab.1569319738.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 24, 2019 at 01:11:29PM +0300, Leonard Crestez wrote:
> Register notifiers with the PM QoS framework in order to respond to
> requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
> 
> No notifiers are added by this patch but PM QoS constraints can be
> imposed externally (for example from other devices).
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 75 +++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  5 +++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index eee403e70c84..784f3e40536a 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -22,15 +22,18 @@
>  #include <linux/platform_device.h>
>  #include <linux/list.h>
>  #include <linux/printk.h>
>  #include <linux/hrtimer.h>
>  #include <linux/of.h>
> +#include <linux/pm_qos.h>
>  #include "governor.h"
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/devfreq.h>
>  
> +#define HZ_PER_KHZ	1000
> +
>  static struct class *devfreq_class;
>  
>  /*
>   * devfreq core provides delayed work based load monitoring helper
>   * functions. Governors can use these or can implement their own
> @@ -109,10 +112,11 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>  static void get_freq_range(struct devfreq *devfreq,
>  			   unsigned long *min_freq,
>  			   unsigned long *max_freq)
>  {
>  	unsigned long *freq_table = devfreq->profile->freq_table;
> +	unsigned long qos_min_freq, qos_max_freq;
>  
>  	lockdep_assert_held(&devfreq->lock);
>  
>  	/*
>  	 * Init min/max frequency from freq table.
> @@ -125,10 +129,18 @@ static void get_freq_range(struct devfreq *devfreq,
>  	} else {
>  		*min_freq = freq_table[devfreq->profile->max_state - 1];
>  		*max_freq = freq_table[0];
>  	}
>  
> +	/* constraints from PM QoS */
> +	qos_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
> +					     DEV_PM_QOS_MIN_FREQUENCY);
> +	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
> +					     DEV_PM_QOS_MIN_FREQUENCY);

This needs to be DEV_PM_QOS_MAX_FREQUENCY. I missed this in the earlier
reviews, but stumbled across it when testing.

!Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
