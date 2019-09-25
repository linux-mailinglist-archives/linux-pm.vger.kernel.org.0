Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA4DBBE1ED
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbfIYQGj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 12:06:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42698 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfIYQGi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 12:06:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so3750894pff.9
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZXwlHN+cbr1PURwp9A0vpaRIOg03ivAjHxGINgVn0Gw=;
        b=SiRQPUJIE0GADZO+hV9Bwof5oKB8U1lMy64PJCbZr5yPQveyOG5r6rR6UEk953Mbtt
         oq9GcJeKKJmAGlIySbKw6YlL1H2kFI7KIQb2o4odPH6uwVUChh7FJ02AFCt7b9yoyxnV
         /uAyjy8e4pnXWcxqNPV7kFxuFTbhvvEaG+Mf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZXwlHN+cbr1PURwp9A0vpaRIOg03ivAjHxGINgVn0Gw=;
        b=igVxYXiKHGvnBouOu7tBIIxlgYMDC3T7OgOPKfCKdYvAJnt5dSz7aBY8g1T5kEzrr4
         3fZoYk9WngGr1kJtEWL8ra8MEg2sVsDR09hgOYyVy6DHJQ8XQDKhIkTNCS/BPNLqlZnN
         F+Y700fYcOtswb5keGaSdiPPMSiYLxipeAHIjUc3DkDg0huUOrGzwr/jUsExNhhhJp0m
         TnAswVwDlZkySAVG+bIVvYs46LzizRm7NxcF5uXROBR8ngx6ojANYEQH4P5WCCSg9qz1
         rkzV+MOIIRkFQXSJkbwGKQIy51vLrsmHWev10RzR76YnV2UY2r9F6Y6L4r39DnHW6b+t
         BNog==
X-Gm-Message-State: APjAAAVHBZPGpI8U/AMzLluwkGbp3ALokCVl+bP7zUjb2Ssd67PD/58X
        /42kFMx52J957pp06KtqAVdtHg==
X-Google-Smtp-Source: APXvYqw8Xiv9X5Bo7oc6DrQrfiLeOBQkugcAwIgjj8Ixri04Io9byW4UI6sTgsawA1Nyq3twYxjDeQ==
X-Received: by 2002:a17:90a:fa0d:: with SMTP id cm13mr7537616pjb.70.1569427596246;
        Wed, 25 Sep 2019 09:06:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id c128sm6485628pfc.166.2019.09.25.09.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 09:06:35 -0700 (PDT)
Date:   Wed, 25 Sep 2019 09:06:31 -0700
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
Subject: Re: [PATCH v8 5/6] PM / devfreq: Add PM QoS support
Message-ID: <20190925160631.GL133864@google.com>
References: <cover.1569319738.git.leonard.crestez@nxp.com>
 <CGME20190924101145epcas4p37f7d25b8743c25520b33fa392cd80d45@epcas4p3.samsung.com>
 <58fdd2c226a4e76a3d9427baab7dd5c23af842ab.1569319738.git.leonard.crestez@nxp.com>
 <40885624-8f11-4eea-d5bf-d6bb50fa44dd@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40885624-8f11-4eea-d5bf-d6bb50fa44dd@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 25, 2019 at 11:15:36AM +0900, Chanwoo Choi wrote:
> On 19. 9. 24. 오후 7:11, Leonard Crestez wrote:
> > Register notifiers with the PM QoS framework in order to respond to
> > requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
> > 
> > No notifiers are added by this patch but PM QoS constraints can be
> > imposed externally (for example from other devices).
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/devfreq/devfreq.c | 75 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/devfreq.h   |  5 +++
> >  2 files changed, 80 insertions(+)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index eee403e70c84..784f3e40536a 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -22,15 +22,18 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/list.h>
> >  #include <linux/printk.h>
> >  #include <linux/hrtimer.h>
> >  #include <linux/of.h>
> > +#include <linux/pm_qos.h>
> >  #include "governor.h"
> >  
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/devfreq.h>
> >  
> > +#define HZ_PER_KHZ	1000
> > +
> >  static struct class *devfreq_class;
> >  
> >  /*
> >   * devfreq core provides delayed work based load monitoring helper
> >   * functions. Governors can use these or can implement their own
> > @@ -109,10 +112,11 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
> >  static void get_freq_range(struct devfreq *devfreq,
> >  			   unsigned long *min_freq,
> >  			   unsigned long *max_freq)
> >  {
> >  	unsigned long *freq_table = devfreq->profile->freq_table;
> > +	unsigned long qos_min_freq, qos_max_freq;
> >  
> >  	lockdep_assert_held(&devfreq->lock);
> >  
> >  	/*
> >  	 * Init min/max frequency from freq table.
> > @@ -125,10 +129,18 @@ static void get_freq_range(struct devfreq *devfreq,
> >  	} else {
> >  		*min_freq = freq_table[devfreq->profile->max_state - 1];
> >  		*max_freq = freq_table[0];
> >  	}
> >  
> > +	/* constraints from PM QoS */
> 
> As I commented on patch4,
> 'constraints' -> 'Constraint' because first verb have to be used
> as the sigular verbs.

'constraints' is not a verb in this case, but the plural of the noun
constraint

> I prefer to use following comments: 
> 
> 	/* Constraint minimum/maximum frequency from PM QoS constraints */

I'm not convinced that this is really an improvement. First there is the
repeated use of 'Constraint ... constraints'. An improvement could be to use
'Limit' instead of 'Constraint'. Anyway from the code it is pretty obvious
that the min/max frequencies are limited. Are you suggesting to also say
further below "Limit minimum/maximum frequency from sysfs constraints"
and the same for the OPP ones?

If you really want a verb the comments could be something like "Apply
<interface> constraints" or "Apply constraints from <interface>".

IMO the current comments provide enough information, unnecessarily verbose
comments can rather get in the way of code readability.

> > +	qos_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
> > +					     DEV_PM_QOS_MIN_FREQUENCY);
> > +	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
> > +					     DEV_PM_QOS_MIN_FREQUENCY);
> > +	*min_freq = max(*min_freq, HZ_PER_KHZ * qos_min_freq);
> > +	*max_freq = min(*max_freq, HZ_PER_KHZ * qos_max_freq);
> > +
> >  	/* constraints from sysfs */
> >  	*min_freq = max(*min_freq, devfreq->min_freq);
> >  	*max_freq = min(*max_freq, devfreq->max_freq);
> >  
> >  	/* constraints from OPP interface */
> > @@ -606,10 +618,49 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
> >  	mutex_unlock(&devfreq->lock);
> >  
> >  	return ret;
> >  }
> >  
> > +/**
> > + * qos_notifier_call() - Common handler for QoS constraints.
> > + * @devfreq:    the devfreq instance.
> > + */
> > +static int qos_notifier_call(struct devfreq *devfreq)
> > +{
> > +	int err;
> > +
> > +	mutex_lock(&devfreq->lock);
> > +	err = update_devfreq(devfreq);
> > +	mutex_unlock(&devfreq->lock);
> > +	if (err)
> > +		dev_err(devfreq->dev.parent,
> > +				"failed to update frequency for PM QoS constraints (%d)\n",
> 
> Is it not over 80 char?

It is and Leonard split it up initially, however I asked him to not
break it up because:

  2) Breaking long lines and strings

  However, *never* break user-visible strings such as printk messages,
  because that breaks the ability to grep for them.

  Documentation/process/coding-style.rst

Line length could be reduced a bit by adjusting indentation though.

> 
> > +				err);
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +/**
> > + * qos_min_notifier_call() - Callback for QoS min_freq changes.
> > + * @nb:		Should be devfreq->nb_min
> > + */
> > +static int qos_min_notifier_call(struct notifier_block *nb,
> > +					 unsigned long val, void *ptr)
> > +{
> > +	return qos_notifier_call(container_of(nb, struct devfreq, nb_min));
> > +}
> > +
> > +/**
> > + * qos_max_notifier_call() - Callback for QoS max_freq changes.
> > + * @nb:		Should be devfreq->nb_max
> > + */
> > +static int qos_max_notifier_call(struct notifier_block *nb,
> > +					 unsigned long val, void *ptr)
> > +{
> > +	return qos_notifier_call(container_of(nb, struct devfreq, nb_max));
> > +}
> > +
> >  /**
> >   * devfreq_dev_release() - Callback for struct device to release the device.
> >   * @dev:	the devfreq device
> >   *
> >   * Remove devfreq from the list and release its resources.
> > @@ -620,10 +671,15 @@ static void devfreq_dev_release(struct device *dev)
> >  
> >  	mutex_lock(&devfreq_list_lock);
> >  	list_del(&devfreq->node);
> >  	mutex_unlock(&devfreq_list_lock);
> >  
> > +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
> > +			DEV_PM_QOS_MAX_FREQUENCY);
> > +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
> > +			DEV_PM_QOS_MIN_FREQUENCY);
> > +
> 
> Just print error with dev_err() without stopping the release step.
> 
> I prefer to handle the return value if kernel API provides
> the error code.
> 
> >  	if (devfreq->profile->exit)
> >  		devfreq->profile->exit(devfreq->dev.parent);
> >  
> >  	kfree(devfreq->time_in_state);
> >  	kfree(devfreq->trans_table);
> > @@ -733,10 +789,28 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >  	if (err) {
> >  		put_device(&devfreq->dev);
> >  		goto err_out;
> >  	}
> >  
> > +	/*
> > +	 * Register notifiers for updates to min/max_freq after device is
> > +	 * initialized (and we can handle notifications) but before the
> > +	 * governor is started (which should do an initial enforcement of
> > +	 * constraints).
> > +	 */
> 
> My previous comment is not enough why I prefer to remove it. Sorry.
> Actually, until now, the devfreq_add_device() don't have the detailed
> comments because the line code is not too long. But, at the present time,
> devfreq_add_device() is too long. It means that the detailed comment
> are necessary. 
> 
> So, I'll add the detailed comment for each step of devfreq_add_device()
> on separate patch to keep the same style. I'll send the patch to you
> for the review.
> 
> > +	devfreq->nb_min.notifier_call = qos_min_notifier_call;
> > +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
> > +				      DEV_PM_QOS_MIN_FREQUENCY);
> > +	if (err)
> > +		goto err_devfreq;
> > +
> > +	devfreq->nb_max.notifier_call = qos_max_notifier_call;
> > +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
> > +				      DEV_PM_QOS_MAX_FREQUENCY);
> > +	if (err)
> > +		goto err_devfreq;
> > +
> >  	mutex_lock(&devfreq_list_lock);
> >  
> >  	governor = try_then_request_governor(devfreq->governor_name);
> >  	if (IS_ERR(governor)) {
> >  		dev_err(dev, "%s: Unable to find governor for the device\n",
> > @@ -760,10 +834,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >  
> >  	return devfreq;
> >  
> >  err_init:
> >  	mutex_unlock(&devfreq_list_lock);
> > +err_devfreq:
> >  	devfreq_remove_device(devfreq);
> >  	return ERR_PTR(err);
> >  
> >  err_dev:
> >  	/*
> > diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> > index c3cbc15fdf08..dac0dffeabb4 100644
> > --- a/include/linux/devfreq.h
> > +++ b/include/linux/devfreq.h
> > @@ -134,10 +134,12 @@ struct devfreq_dev_profile {
> >   * @total_trans:	Number of devfreq transitions
> >   * @trans_table:	Statistics of devfreq transitions
> >   * @time_in_state:	Statistics of devfreq states
> >   * @last_stat_updated:	The last time stat updated
> >   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
> > + * @nb_min:		Notifier block for DEV_PM_QOS_MIN_FREQUENCY
> > + * @nb_max:		Notifier block for DEV_PM_QOS_MAX_FREQUENCY
> >   *
> >   * This structure stores the devfreq information for a give device.
> >   *
> >   * Note that when a governor accesses entries in struct devfreq in its
> >   * functions except for the context of callbacks defined in struct
> > @@ -176,10 +178,13 @@ struct devfreq {
> >  	unsigned int *trans_table;
> >  	unsigned long *time_in_state;
> >  	unsigned long last_stat_updated;
> >  
> >  	struct srcu_notifier_head transition_notifier_list;
> > +
> > +	struct notifier_block nb_min;
> > +	struct notifier_block nb_max;
> >  };
> >  
> >  struct devfreq_freqs {
> >  	unsigned long old;
> >  	unsigned long new;
> > 
> 
> 
> -- 
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
