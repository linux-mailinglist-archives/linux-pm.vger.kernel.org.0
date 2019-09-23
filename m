Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E95BBE14
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 23:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503161AbfIWVmL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 17:42:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42613 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389663AbfIWVmL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 17:42:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so7086750pls.9
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2019 14:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LN2jcukuPHy9o4Jb1zZq4UGAS0V2HgpSfI+T3t4oJ94=;
        b=Ps6OG8v5rRsTroOwDDLZ4nW8gYvFsQQGX4I82xbw3H2OZQIfJNPNUW9kRrR4dvQzzj
         Y9CW4mV1mP9FL5g4ZkahEmOdq6uuUoHnIwQkOL3FDp9REe3837X6bLaZZVSTN0vuK/F1
         DrA7GS2LGLQaBYQdhBMYzZG0r9mTckUwbSJ30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LN2jcukuPHy9o4Jb1zZq4UGAS0V2HgpSfI+T3t4oJ94=;
        b=i1NCNrL2oA1lP66Qn+uJYXqU2A7k1keTKtWdu+w5mI1qvNSeUN6OEbV0Hwj++XX73M
         xjShDq0SEbDvpbj8+qB8GrUo0k2sH84NAX+Qs4Axgx+Wd44EnLO6igivOrb25NF1kdY/
         yKl26XXsPQDFmeVYJaeGEFeLQuRX7+PtUWvMwOneyXEYuMi2p4fEQk6u8IJOnC/VipFD
         dhKwe8lJCBwPM1I50da2HgJYIIGaJBxokL7JIQ3vkrlZkoGCr1Ps5NT3fSLJ4lYSJJj+
         JN6XMddSck6cHzsL3z3M7ID95Z3IClROYd4UBK66eyjoVljuxs1oyu4M2V7KgBYWv1pV
         +DSw==
X-Gm-Message-State: APjAAAWeCQ+b8skjRcAIGj7s1en87a30vBXg+mJnhZfaSWWwGH/jcs4k
        YcMPKC4gjPMtR+/Vkis4+O32Fw==
X-Google-Smtp-Source: APXvYqwUgQI62mHf0qjDK4hdTJErmArRYu2PmE5qeBv5kbgiK8V+DnhYLpDqt6ga3PV3FxYn+pWvdw==
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr1879668plo.223.1569274930403;
        Mon, 23 Sep 2019 14:42:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id k31sm18848493pjb.14.2019.09.23.14.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 14:42:09 -0700 (PDT)
Date:   Mon, 23 Sep 2019 14:42:07 -0700
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
        Martin Kepplinger <martink@posteo.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 5/6] PM / devfreq: Add PM QoS support
Message-ID: <20190923214207.GG133864@google.com>
References: <cover.1569272883.git.leonard.crestez@nxp.com>
 <e9868310f9543b4f4a6c7bbe5d4d015da9a0e71d.1569272883.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9868310f9543b4f4a6c7bbe5d4d015da9a0e71d.1569272883.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 24, 2019 at 12:10:33AM +0300, Leonard Crestez wrote:
> Register notifiers with the PM QoS framework in order to respond to
> requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
> 
> No notifiers are added by this patch but PM QoS constraints can be
> imposed externally (for example from other devices).
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 76 +++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  5 +++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 7f152a582e78..9887408f23bb 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -22,17 +22,20 @@
>  #include <linux/platform_device.h>
>  #include <linux/list.h>
>  #include <linux/printk.h>
>  #include <linux/hrtimer.h>
>  #include <linux/of.h>
> +#include <linux/pm_qos.h>
>  #include "governor.h"
>  
>  #define HZ_PER_KHZ 1000
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
> @@ -123,10 +126,16 @@ static void devfreq_get_freq_range(struct devfreq *devfreq,
>  	} else {
>  		*min_freq = freq_table[devfreq->profile->max_state - 1];
>  		*max_freq = freq_table[0];
>  	}
>  
> +	/* constraints from PM QoS */
> +	*min_freq = max(*min_freq, HZ_PER_KHZ * (unsigned long)dev_pm_qos_read_value(
> +				devfreq->dev.parent, DEV_PM_QOS_MIN_FREQUENCY));
> +	*max_freq = min(*max_freq, HZ_PER_KHZ * (unsigned long)dev_pm_qos_read_value(
> +				devfreq->dev.parent, DEV_PM_QOS_MAX_FREQUENCY));
> +
>  	/* constraints from sysfs */
>  	*min_freq = max(*min_freq, devfreq->min_freq);
>  	*max_freq = min(*max_freq, devfreq->max_freq);
>  
>  	/* constraints from OPP interface */
> @@ -605,10 +614,53 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  	mutex_unlock(&devfreq->lock);
>  
>  	return ret;
>  }
>  
> +/**
> + * devfreq_qos_notifier_call() - Common handler for QoS constraints.
> + * @devfreq:    the devfreq instance.
> + */
> +static int devfreq_qos_notifier_call(struct devfreq *devfreq)
> +{
> +	int err;
> +
> +	mutex_lock(&devfreq->lock);
> +	err = update_devfreq(devfreq);
> +	mutex_unlock(&devfreq->lock);
> +	if (err)
> +		dev_err(&devfreq->dev, "dvfs for QoS constraints"
> +				" failed with (%d) error\n", err);

nit: DVFS. devfreq_monitor() also uses the lower-case acronym though, so
you can claim this is consistent :)

I'd prefer to spare you another trivial re-spin, but unfortunately
breaking the log message into multiple lines is a coding style
violation:

Documentation/process/coding-style.rst
  2) Breaking long lines and strings

  However, never break user-visible strings such as printk messages,
  because that breaks the ability to grep for them.


With that fixed:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
