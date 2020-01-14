Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B87B13B25B
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 19:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgANSvF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 13:51:05 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39478 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgANSvF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 13:51:05 -0500
Received: by mail-pj1-f67.google.com with SMTP id e11so4728713pjt.4
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 10:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8RHb25MFJpPZhJdjI8xQKql5/uxFuwEOzuS1j12SrJk=;
        b=Ow6Bjq+PMUgyYD4Z7oS58hmebH/2FCuoQLR5BmldOvhqhhrktMYHsU7MqISY/Qc4mR
         ksHt82V82HrQHDybguDhh42mdUaf5i9sfnxS+IGXGYaPLFU4CxrQ68v65EapYscHtN2L
         T4xvsI4/pL2FSbDcYfrS9dURi2fnRLTNNwjbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8RHb25MFJpPZhJdjI8xQKql5/uxFuwEOzuS1j12SrJk=;
        b=rrZo/NYt0r2GnP7NLUnUHLa2klHxa08uhgIPmy6BSbX4oOXf0dFM/nR9a/AkTzxByi
         Fwq+0VWjsLXqyyFC2G7I513rnbXefGnczTv4j3DjQCBz2EI7bddzuL183C1JQKs4OsJ+
         HGFzUJJZdXQ+GQHn9JedgggfJE4XDQ4Arza3OX0l08ljc5gs2/cYEd15fQw4kPFZjnMA
         RYT2tg7fjIoZknvAvPlaQlIR55glfqwVjSHt1XfLmCZv7Tx2o1LKGjFEHBpOMD6kol4Q
         oeuAWeyiXPUkip3x7OYPs3xfmYbBfaps4x74KlVfEHJqyai0hR8d1jDSIdy0yCVl+zP2
         6FDg==
X-Gm-Message-State: APjAAAW6WnjsNDsP8uneDLkhwRY1oBh7iRrqSeG1e+cSC7MC2M07/3gK
        tz/4gKR3FZF4OoiscAHc2dZp4A==
X-Google-Smtp-Source: APXvYqwyGpqR1K6wjcjKgJO0oKzp9z8mLoiE+SZlVD3ctdnXJ8HANMRK5I9mc5T6ayqXehxYp1DYKw==
X-Received: by 2002:a17:90a:7781:: with SMTP id v1mr15038696pjk.108.1579027864707;
        Tue, 14 Jan 2020 10:51:04 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id b185sm19678208pfa.102.2020.01.14.10.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 10:51:04 -0800 (PST)
Date:   Tue, 14 Jan 2020 10:51:02 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: devfreq_cooling: Use PM QoS to set
 frequency limits
Message-ID: <20200114185102.GJ89495@google.com>
References: <CGME20200110174931epcas1p49c79567945e125829188174293d99850@epcas1p4.samsung.com>
 <20200110094913.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
 <bae154ef-cbe6-de24-26c7-a7d4338bd55e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bae154ef-cbe6-de24-26c7-a7d4338bd55e@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 13, 2020 at 04:25:17PM +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 1/11/20 2:49 AM, Matthias Kaehlcke wrote:
> > Now that devfreq supports limiting the frequency range of a device
> > through PM QoS make use of it instead of disabling OPPs that should
> > not be used.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> >  drivers/thermal/devfreq_cooling.c | 66 ++++++++++---------------------
> >  1 file changed, 20 insertions(+), 46 deletions(-)
> > 
> > diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> > index ef59256887ff..3a63603afcf2 100644
> > --- a/drivers/thermal/devfreq_cooling.c
> > +++ b/drivers/thermal/devfreq_cooling.c
> > @@ -24,11 +24,13 @@
> >  #include <linux/idr.h>
> >  #include <linux/slab.h>
> >  #include <linux/pm_opp.h>
> > +#include <linux/pm_qos.h>
> >  #include <linux/thermal.h>
> >  
> >  #include <trace/events/thermal.h>
> >  
> > -#define SCALE_ERROR_MITIGATION 100
> > +#define HZ_PER_KHZ		1000
> > +#define SCALE_ERROR_MITIGATION	100
> >  
> >  static DEFINE_IDA(devfreq_ida);
> >  
> > @@ -65,49 +67,9 @@ struct devfreq_cooling_device {
> >  	struct devfreq_cooling_power *power_ops;
> >  	u32 res_util;
> >  	int capped_state;
> > +	struct dev_pm_qos_request req_max_freq;
> 
> Need to add the description of 'req_max_freq'.

will add the description

> >  };
> >  
> > -/**
> > - * partition_enable_opps() - disable all opps above a given state
> > - * @dfc:	Pointer to devfreq we are operating on
> > - * @cdev_state:	cooling device state we're setting
> > - *
> > - * Go through the OPPs of the device, enabling all OPPs until
> > - * @cdev_state and disabling those frequencies above it.
> > - */
> > -static int partition_enable_opps(struct devfreq_cooling_device *dfc,
> > -				 unsigned long cdev_state)
> > -{
> > -	int i;
> > -	struct device *dev = dfc->devfreq->dev.parent;
> > -
> > -	for (i = 0; i < dfc->freq_table_size; i++) {
> > -		struct dev_pm_opp *opp;
> > -		int ret = 0;
> > -		unsigned int freq = dfc->freq_table[i];
> > -		bool want_enable = i >= cdev_state ? true : false;
> > -
> > -		opp = dev_pm_opp_find_freq_exact(dev, freq, !want_enable);
> > -
> > -		if (PTR_ERR(opp) == -ERANGE)
> > -			continue;
> > -		else if (IS_ERR(opp))
> > -			return PTR_ERR(opp);
> > -
> > -		dev_pm_opp_put(opp);
> > -
> > -		if (want_enable)
> > -			ret = dev_pm_opp_enable(dev, freq);
> > -		else
> > -			ret = dev_pm_opp_disable(dev, freq);
> > -
> > -		if (ret)
> > -			return ret;
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> >  static int devfreq_cooling_get_max_state(struct thermal_cooling_device *cdev,
> >  					 unsigned long *state)
> >  {
> > @@ -134,7 +96,7 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
> >  	struct devfreq_cooling_device *dfc = cdev->devdata;
> >  	struct devfreq *df = dfc->devfreq;
> >  	struct device *dev = df->dev.parent;
> > -	int ret;
> > +	unsigned long freq;
> >  
> >  	if (state == dfc->cooling_state)
> >  		return 0;
> > @@ -144,9 +106,10 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
> >  	if (state >= dfc->freq_table_size)
> >  		return -EINVAL;
> >  
> > -	ret = partition_enable_opps(dfc, state);
> > -	if (ret)
> > -		return ret;
> > +	freq = dfc->freq_table[state];
> > +
> > +	dev_pm_qos_update_request(&dfc->req_max_freq,
> > +				  DIV_ROUND_UP(freq, HZ_PER_KHZ));
> >  
> >  	dfc->cooling_state = state;
> >  
> > @@ -529,6 +492,12 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
> >  	if (err)
> >  		goto free_dfc;
> >  
> > +	err = dev_pm_qos_add_request(df->dev.parent, &dfc->req_max_freq,
> > +				     DEV_PM_QOS_MAX_FREQUENCY,
> > +				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> > +	if (err < 0)
> > +		goto remove_qos_req;
> 
> Jump 'free_table' instead of 'remove_qos_req'.

ack

> > +
> >  	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
> >  	if (err < 0)
> >  		goto free_tables;
> 
> Jump remove_qos_req.

ack

> > @@ -552,6 +521,10 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
> >  
> >  release_ida:
> >  	ida_simple_remove(&devfreq_ida, dfc->id);
> > +
> > +remove_qos_req:
> > +	dev_pm_qos_remove_request(&dfc->req_max_freq);
> > +
> >  free_tables:
> >  	kfree(dfc->power_table);
> >  	kfree(dfc->freq_table);
> > @@ -600,6 +573,7 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
> >  
> >  	thermal_cooling_device_unregister(dfc->cdev);
> >  	ida_simple_remove(&devfreq_ida, dfc->id);
> > +	dev_pm_qos_remove_request(&dfc->req_max_freq);
> >  	kfree(dfc->power_table);
> >  	kfree(dfc->freq_table);
