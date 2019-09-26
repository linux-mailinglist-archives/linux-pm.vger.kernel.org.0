Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 332D3BF660
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 18:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfIZQEu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Sep 2019 12:04:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33957 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfIZQEu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2019 12:04:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so2120821pfa.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2019 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AmlgghEnTm4dlVlgTgUfs9dm9WGzckYupWFhC473QLY=;
        b=NUd98sVKEBebrSrEUX6zXgBO6NqeAisKf1qd3pvsND7SbWcWaOHSxsDSNnPdHaHjH+
         jz/D1wTcPti3AgAEbzATrC5izl5qOQn7oaaHF8GhMxV3DQoYiiQHlWbQsTKcfxw8PLOE
         q4E6k903iudy6saT/z1afr2/JGIjFxeHmQyWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AmlgghEnTm4dlVlgTgUfs9dm9WGzckYupWFhC473QLY=;
        b=b4+7e+wjj57hL+PRgZclSO8pYLTj7IGMMucTCeBG7WuE1QtezoS6HbT2vKP6V3chk7
         STj+47UR6M47yE7dRVDFCXGapYTVPwucyBgZK1X5ZGrKr2yOScjq11A67vXQNz3wpkzt
         b0uOJdDjq+ujoVdR0ggckFHxlTIaFtLBNA7qdKUPOYRo077apwHPygUoeD/ZH8mZs0rN
         5OX2hvaFFnpoXNsm/xXkU2BO9oVAO3ilT0aUTSQ4BeWcJnVD4a+kRtMEhEgruAZQfMOS
         sJ56ycdul1L+s4zhh0W5EKZXJV6I8N1CB6GuXWp5+lY2+RjBnJA6zMY2+l2O1vsPVAZj
         8vAg==
X-Gm-Message-State: APjAAAXFetwWYxrt8/9tCZhoo6LS1pIeBsoP/CcO3VAgP+vyFdLmgAIY
        xlmcJgeEdvLhHpCy/SQn8dU3jQ==
X-Google-Smtp-Source: APXvYqyAZNrFd8SjZlx9W6Dxxyobn/6DZ89tVcEKUx4YfR45nbD0lm89VWtDJBDZOdx/OrTPy3kcCA==
X-Received: by 2002:a62:8647:: with SMTP id x68mr4630322pfd.44.1569513889264;
        Thu, 26 Sep 2019 09:04:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id q13sm2938026pjq.0.2019.09.26.09.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 09:04:48 -0700 (PDT)
Date:   Thu, 26 Sep 2019 09:04:45 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
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
Subject: Re: [PATCH v8 6/6] PM / devfreq: Use PM QoS for sysfs min/max_freq
Message-ID: <20190926160445.GO133864@google.com>
References: <cover.1569319738.git.leonard.crestez@nxp.com>
 <CGME20190924101141epcas4p37956967e2f06b8a857cb53ff12ca791b@epcas4p3.samsung.com>
 <3eb8a1d1e7d738f7599d54348d6b474196581693.1569319738.git.leonard.crestez@nxp.com>
 <c521989f-51b6-84eb-b4f1-c4469494345e@samsung.com>
 <20190925164513.GM133864@google.com>
 <81b136fc-0613-08f8-cb26-6243e7be621b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81b136fc-0613-08f8-cb26-6243e7be621b@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 26, 2019 at 10:25:41AM +0900, Chanwoo Choi wrote:
> On 19. 9. 26. 오전 1:45, Matthias Kaehlcke wrote:
> > On Wed, Sep 25, 2019 at 11:41:07AM +0900, Chanwoo Choi wrote:
> >> On 19. 9. 24. 오후 7:11, Leonard Crestez wrote:
> >>> Switch the handling of min_freq and max_freq from sysfs to use the
> >>> dev_pm_qos_request interface.
> >>>
> >>> Since PM QoS handles frequencies as kHz this change reduces the
> >>> precision of min_freq and max_freq. This shouldn't introduce problems
> >>> because frequencies which are not an integer number of kHz are likely
> >>> not an integer number of Hz either.
> >>>
> >>> Try to ensure compatibility by rounding min values down and rounding
> >>> max values up.
> >>>
> >>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> >>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> >>> ---
> >>>  drivers/devfreq/devfreq.c | 46 ++++++++++++++++++++++++---------------
> >>>  include/linux/devfreq.h   |  9 ++++----
> >>>  2 files changed, 33 insertions(+), 22 deletions(-)
> >>>
> >>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >>> index 784f3e40536a..8bb7efd821ab 100644
> >>> --- a/drivers/devfreq/devfreq.c
> >>> +++ b/drivers/devfreq/devfreq.c
> >>> @@ -137,14 +137,10 @@ static void get_freq_range(struct devfreq *devfreq,
> >>>  	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
> >>>  					     DEV_PM_QOS_MIN_FREQUENCY);
> >>>  	*min_freq = max(*min_freq, HZ_PER_KHZ * qos_min_freq);
> >>>  	*max_freq = min(*max_freq, HZ_PER_KHZ * qos_max_freq);
> >>>  
> >>> -	/* constraints from sysfs */
> >>> -	*min_freq = max(*min_freq, devfreq->min_freq);
> >>> -	*max_freq = min(*max_freq, devfreq->max_freq);
> >>> -
> >>>  	/* constraints from OPP interface */
> >>>  	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
> >>>  	/* scaling_max_freq can be zero on error */
> >>>  	if (devfreq->scaling_max_freq)
> >>>  		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
> >>> @@ -679,10 +675,12 @@ static void devfreq_dev_release(struct device *dev)
> >>>  			DEV_PM_QOS_MIN_FREQUENCY);
> >>>  
> >>>  	if (devfreq->profile->exit)
> >>>  		devfreq->profile->exit(devfreq->dev.parent);
> >>>  
> >>> +	dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
> >>> +	dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
> >>
> >> Please check the return value if error happen, just print the err with dev_err()
> >> without stopping the release steps.
> > 
> > I wonder if dev_warn() would be more appropriate, since the current operation
> > is not aborted.
> > 
> >>>  	kfree(devfreq->time_in_state);
> >>>  	kfree(devfreq->trans_table);
> >>>  	mutex_destroy(&devfreq->lock);
> >>>  	kfree(devfreq);
> >>>  }
> >>> @@ -747,18 +745,25 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >>>  	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> >>>  	if (!devfreq->scaling_min_freq) {
> >>>  		err = -EINVAL;
> >>>  		goto err_dev;
> >>>  	}
> >>> -	devfreq->min_freq = devfreq->scaling_min_freq;
> >>>  
> >>>  	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> >>>  	if (!devfreq->scaling_max_freq) {
> >>>  		err = -EINVAL;
> >>>  		goto err_dev;
> >>>  	}
> >>> -	devfreq->max_freq = devfreq->scaling_max_freq;
> >>> +
> >>> +	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
> >>> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
> >>> +	if (err < 0)
> >>> +		goto err_dev;
> >>> +	err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
> >>> +				     DEV_PM_QOS_MAX_FREQUENCY, S32_MAX);
> >>> +	if (err < 0)
> >>> +		goto err_dev;
> >>>  
> >>>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
> >>>  	atomic_set(&devfreq->suspend_count, 0);
> >>>  
> >>>  	devfreq->trans_table = kzalloc(
> >>> @@ -843,10 +848,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >>>  err_dev:
> >>>  	/*
> >>>  	 * Cleanup path for errors that happen before registration.
> >>>  	 * Otherwise we rely on devfreq_dev_release.
> >>>  	 */
> >>> +	if (dev_pm_qos_request_active(&devfreq->user_max_freq_req))
> >>> +		dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
> >>
> >> Please check the return value if error happen, just print the err with dev_err()
> >> without stopping the release steps.
> >>
> >> 	dev_err(... "failed to remove request of DEV_PM_QOS_MAX_FREQUENCY\n");
> > 
> > dev_warn() for the same reason as above?
> 
> Actually, I think that is not critical error but need to print the error
> So, I think that dev_err() is enough. If this thing is critical,
> better to use dev_warn.

We agree that this is not critical, but not when to use dev_err()
and dev_warn(). You seem to imply that dev_warn() is more severe
than dev_err(), however it's the other way around:

#define KERN_ERR        KERN_SOH "3"    /* error conditions */
#define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
#define KERN_NOTICE     KERN_SOH "5"    /* normal but significant condition */

I think in this case you can go either way, it's certainly an error,
but the driver continues with the normal execution path.

> > 
> > I think the message would be better with a slight change:
> > 
> > "failed to remove DEV_PM_QOS_MAX_FREQUENCY request\n"
> 
> OK.
> 
> > 
> >>
> >>> +	if (dev_pm_qos_request_active(&devfreq->user_min_freq_req))
> >>> +		dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
> >> 	
> >> 	dev_err(... "failed to remove request of DEV_PM_QOS_MIN_FREQUENCY\n");
> > 
> > ditto
> > 
> >>>  	kfree(devfreq->time_in_state);
> >>>  	kfree(devfreq->trans_table);
> >>>  	kfree(devfreq);
> >>>  err_out:
> >>>  	return ERR_PTR(err);
> >>> @@ -1407,14 +1416,15 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
> >>>  
> >>>  	ret = sscanf(buf, "%lu", &value);
> >>>  	if (ret != 1)
> >>>  		return -EINVAL;
> >>>  
> >>> -	mutex_lock(&df->lock);
> >>> -	df->min_freq = value;
> >>> -	update_devfreq(df);
> >>> -	mutex_unlock(&df->lock);
> >>> +	/* round down to kHz for PM QoS */
> >>
> >> I prefer more detailed description as following:
> >>
> >> 	/*
> >> 	 * Round down to KHz to decide the proper minimum frequency
> > 
> > it should be kHz, with a lower-case 'k', as in the original comment.
> 
> Good.
> 
> > 
> >> 	 * which is closed to user request.
> >>  	 */
> > 
> > The comment you suggest doesn't provide any information about why the
> > conversion to kHz is done, in this sense the original comment that
> > mentions PM QoS provides more value.
> > 
> > With whatever we end up, I suggest to use 'convert' instead of
> > 'round down'.
> 
> I agree to use 'convert' instead of 'round down'
> if some expression indicates the correct meaning.
> 
> > 
> >>> +	ret = dev_pm_qos_update_request(&df->user_min_freq_req,
> >>> +					value / HZ_PER_KHZ);
> >>> +	if (ret < 0)
> >>> +		return ret;
> >>>  
> >>>  	return count;
> >>>  }
> >>>  
> >>>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
> >>> @@ -1439,19 +1449,19 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
> >>>  
> >>>  	ret = sscanf(buf, "%lu", &value);
> >>>  	if (ret != 1)
> >>>  		return -EINVAL;
> >>>  
> >>> -	mutex_lock(&df->lock);
> >>> -
> >>> -	/* Interpret zero as "don't care" */
> >>> -	if (!value)
> >>> -		value = ULONG_MAX;
> >>> +	/* round up to kHz for PM QoS and interpret zero as "don't care" */
> >>
> >> I think that "don't care" comment style is not good.
> >>
> >> I referred to the Documentation/ABI/testing/sysfs-class-devfreq file.
> >> I prefer more detailed description as following:
> >> 	/*
> >> 	 * Round up to KHz to decide the proper maximum frequency
> > 
> > kHz
> > 
> >> 	 * which is closed to user request. If value is zero,
> >> 	 * the user does not care.
> > 
> > "the user does not care" is still very casual you didn't like initially.
> > How about "A value of zero is interpreted as 'no limit'."?
> > 
> > As for the min freq, I think PM QoS should be mentioned to make clear why
> > the conversion to kHz is needed.
> 
> Agree. I expect that Leonard will mention that.
> 
> > 
> >>  	 */
> >>
> >>
> >>> +	if (value)
> >>> +		value = DIV_ROUND_UP(value, HZ_PER_KHZ);
> >>> +	else
> >>> +		value = S32_MAX;
> >>>  
> >>> -	df->max_freq = value;
> >>> -	update_devfreq(df);
> >>> -	mutex_unlock(&df->lock);
> >>> +	ret = dev_pm_qos_update_request(&df->user_max_freq_req, value);
> >>> +	if (ret < 0)
> >>> +		return ret;
> >>>  
> >>>  	return count;
> >>>  }
> >>>  static DEVICE_ATTR_RW(min_freq);
> >>>  
> >>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> >>> index dac0dffeabb4..7849fe4c666d 100644
> >>> --- a/include/linux/devfreq.h
> >>> +++ b/include/linux/devfreq.h
> >>> @@ -11,10 +11,11 @@
> >>>  #define __LINUX_DEVFREQ_H__
> >>>  
> >>>  #include <linux/device.h>
> >>>  #include <linux/notifier.h>
> >>>  #include <linux/pm_opp.h>
> >>> +#include <linux/pm_qos.h>
> >>>  
> >>>  #define DEVFREQ_NAME_LEN 16
> >>>  
> >>>  /* DEVFREQ governor name */
> >>>  #define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
> >>> @@ -121,12 +122,12 @@ struct devfreq_dev_profile {
> >>>   *		devfreq.nb to the corresponding register notifier call chain.
> >>>   * @work:	delayed work for load monitoring.
> >>>   * @previous_freq:	previously configured frequency value.
> >>>   * @data:	Private data of the governor. The devfreq framework does not
> >>>   *		touch this.
> >>> - * @min_freq:	Limit minimum frequency requested by user (0: none)
> >>> - * @max_freq:	Limit maximum frequency requested by user (0: none)
> >>> + * @user_min_freq_req:	PM QoS min frequency request from user (via sysfs)
> >>
> >> min -> minimum and then remove parenthesis as following:
> >> 	PM QoS minimum frequency request by user via sysfs
> >>
> >>> + * @user_max_freq_req:	PM QoS max frequency request from user (via sysfs)
> >>
> >> ditto. max -> maximum
> >> 	PM QoS maximum frequency request by user via sysfs
> >>
> >>>   * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
> >>>   * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
> >>>   * @stop_polling:	 devfreq polling status of a device.
> >>>   * @suspend_freq:	 frequency of a device set during suspend phase.
> >>>   * @resume_freq:	 frequency of a device set in resume phase.
> >>> @@ -161,12 +162,12 @@ struct devfreq {
> >>>  	unsigned long previous_freq;
> >>>  	struct devfreq_dev_status last_status;
> >>>  
> >>>  	void *data; /* private data for governors */
> >>>  
> >>> -	unsigned long min_freq;
> >>> -	unsigned long max_freq;
> >>> +	struct dev_pm_qos_request user_min_freq_req;
> >>> +	struct dev_pm_qos_request user_max_freq_req;
> >>>  	unsigned long scaling_min_freq;
> >>>  	unsigned long scaling_max_freq;
> >>>  	bool stop_polling;
> >>>  
> >>>  	unsigned long suspend_freq;
> >>>
> >>
> >>
> >> -- 
> >> Best Regards,
> >> Chanwoo Choi
> >> Samsung Electronics
> > 
> > 
> 
> 
> -- 
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
