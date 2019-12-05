Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57180114637
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 18:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbfLERsu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 12:48:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41303 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730142AbfLERst (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 12:48:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id bd4so1538449plb.8
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 09:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I5d912MYAJV7WOySMZ2inDSLRZhcHr5jXA7MY3FsoXI=;
        b=X38JZEgX7yfJlOpqTqHrPssrpwQQEh60or9o8EzRxMIWmQHCiLCJ/zhQC/8L0EpNTV
         ICORf+RLfQiZPwWN/rPPp5/hRe8w4ASX5HAk1fiDUHIjKSwXkRvgOPD6N9EllVXDRXnX
         w7MRzx/XyYwKIDE5gzOLSHapHXI8zW4PP0btM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I5d912MYAJV7WOySMZ2inDSLRZhcHr5jXA7MY3FsoXI=;
        b=uB+AH3E4Frvefxsck60mn+jZHtHvQpBKk9ubNZ1kpm1uS1U7sMQOYWlIR0ECCnbEeP
         T1TeBlgvvQo8Bu3+aTLq5y+XMKQcfzSgOZ/7xp7eCCFZy9Yx5gabWF7ljgQd0OrnmIFB
         0/dRrO2bi8albOfzyV+N5F+iA2ri8gKpPhRXeSXHgQlOqqk0M+BpcBEflk44bhPShDQm
         KjhSGL6yYmZ8XTU/PhZvJtqO0X4JbaWy6jkhIvHL0sZwbrMgqWCs062yzo55rptu0E5L
         x6vq7MalxMEHG4umCmjgV8aAbojcroRnBPtwB8g8gjjSI2XarWDW4NXnlt+Jal9mPU9s
         aTuw==
X-Gm-Message-State: APjAAAWqcRpojP0/PiWBG+w/AsJzWPmNUMvAAmFThVW8JDqi4te/zkqE
        uQdJegdiboSJNuAjcBBJLUWBHQ==
X-Google-Smtp-Source: APXvYqxfMUKZGT6P0TUfMuyW8oAlxX+Wy1kXyKhkiDjIudTd/T2t0aiQ+3RAHYm9wAj/+7FicLF9Iw==
X-Received: by 2002:a17:902:8201:: with SMTP id x1mr10263704pln.193.1575568127950;
        Thu, 05 Dec 2019 09:48:47 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id a13sm2259865pfc.40.2019.12.05.09.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:48:47 -0800 (PST)
Date:   Thu, 5 Dec 2019 09:48:46 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] PM / devfreq: Add PM QoS support
Message-ID: <20191205174846.GM228856@google.com>
References: <cover.1575540224.git.leonard.crestez@nxp.com>
 <eaef2de34fed598a1b6ffecc9010e281c6f36318.1575540224.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eaef2de34fed598a1b6ffecc9010e281c6f36318.1575540224.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 05, 2019 at 12:05:06PM +0200, Leonard Crestez wrote:
> Register notifiers with the PM QoS framework in order to respond to
> requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
> 
> No notifiers are added by this patch but PM QoS constraints can be
> imposed externally (for example from other devices).
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 77 +++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  5 +++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bdeb4189c978..e8b943fc4259 100644
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
> +	s32 qos_min_freq, qos_max_freq;
>  
>  	lockdep_assert_held(&devfreq->lock);
>  
>  	/*
>  	 * Initialize minimum/maximum frequency from freq table.
> @@ -125,10 +129,20 @@ static void get_freq_range(struct devfreq *devfreq,
>  	} else {
>  		*min_freq = freq_table[devfreq->profile->max_state - 1];
>  		*max_freq = freq_table[0];
>  	}
>  
> +	/* Apply constraints from PM QoS */
> +	qos_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
> +					     DEV_PM_QOS_MIN_FREQUENCY);
> +	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
> +					     DEV_PM_QOS_MAX_FREQUENCY);
> +	*min_freq = max(*min_freq, (unsigned long)HZ_PER_KHZ * qos_min_freq);
> +	if (qos_max_freq != PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE)

The condition shouldn't be needed anymore now that
PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE is S32_MAX and not -1.

> +		*max_freq = min(*max_freq,
> +				(unsigned long)HZ_PER_KHZ * qos_max_freq);
> +

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
