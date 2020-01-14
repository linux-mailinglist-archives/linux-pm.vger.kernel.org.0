Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CA013B2B8
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 20:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgANTHq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 14:07:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46313 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgANTHp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 14:07:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id n9so7009218pff.13
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 11:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aLELjPYcaLo58QAAHC+0RioxZHEHGruSV5XSCPDClP4=;
        b=DOjVACsA2rRiS1aDwEMcceeN2dNSvb9rjohA9MxOUbTcAVYrKBgIYw+en0ypMeJgnT
         CBeuzWi6XwUAA8SCJ0srksS+ZIfko3Cg4FD3RAyIta3Ei/gX3GbOiHX89gtoRLGTsh75
         SQdMdYm2M09apsaZDDNHhsq4sRgp4Y61i9rIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aLELjPYcaLo58QAAHC+0RioxZHEHGruSV5XSCPDClP4=;
        b=bMOCUdWxO7wC8dojbQbvlVXEib/v/FvmraCEYPCRzV86olKVLhX0Dxx1BIMfDCWO6p
         0fngT65wpp6C/vZLK5pCDXw7ZFBC6HIibtS7rdX6J2IIN3GGfMNu+Ukk4LpIPww9BFUY
         LVu2enInzq2eH+9lE7eM56jLK0cLMd5wSZF9+ftpuslLlG07Pn6vG1itTJfTb9fPY2bC
         BE0GAf6PmnYiRImzu1ixES8TtvNEeUeLODsYUDo9SeTPtOiRFfStqwrrM0ospOWFXC5Y
         cZAybt3FZeXMsAFqThdbRSC6D0KpfupC2Njzkk9+WYRaBI07kD6+LdJEFv1/1hGIXGRc
         2k5Q==
X-Gm-Message-State: APjAAAVGqMY8aZSkhETecQZfBr2YZRE1q973PvYHo3uHjTiNilZ/gl7d
        g8fwLzfUNMXrPd5/fZ/+BpktDw==
X-Google-Smtp-Source: APXvYqwUca6Vt0SP3mVbw2bEHts0IsE5hoEobysKSj0tyGVbqh08fZ+JkcgA+iecdazZI1U5J1w5Ag==
X-Received: by 2002:a63:dc41:: with SMTP id f1mr29452244pgj.119.1579028864875;
        Tue, 14 Jan 2020 11:07:44 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id s21sm18963322pfe.20.2020.01.14.11.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 11:07:44 -0800 (PST)
Date:   Tue, 14 Jan 2020 11:07:43 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] thermal: devfreq_cooling: Use PM QoS to set
 frequency limits
Message-ID: <20200114190743.GK89495@google.com>
References: <20200110094913.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
 <VI1PR04MB70233705094CCA4BA7545CF0EE340@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR04MB70233705094CCA4BA7545CF0EE340@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 14, 2020 at 04:08:38PM +0000, Leonard Crestez wrote:
> On 10.01.2020 19:49, Matthias Kaehlcke wrote:
> > Now that devfreq supports limiting the frequency range of a device
> > through PM QoS make use of it instead of disabling OPPs that should
> > not be used.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> 
> It is not obvious but this changes behavior when min max requests 
> conflict (min > max): with PM QoS a MIN_FREQUENCY request takes 
> precedence but if higher OPPs are disabled then this will override 
> MIN_FREQUENCY.

Thanks for pointing this out.

> There are very few users of this functionality so I don't think there 
> are any systems that depend on this behaving one way or the other but 
> perhaps it should be mentioned in commit message?

Sounds good, I'll add a note.

> As far as I can tell the only user of devfreq_cooling in upstream is 
> drivers/gpu/drm/panfrost?

Indeed, apparently GPUs are the primary devfreq device used for cooling,
and unfortunately most GPU drivers are not in upstream.

> >   drivers/thermal/devfreq_cooling.c | 66 ++++++++++---------------------
> >   1 file changed, 20 insertions(+), 46 deletions(-)
> > 
> > diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> > index ef59256887ff..3a63603afcf2 100644
> > --- a/drivers/thermal/devfreq_cooling.c
> > +++ b/drivers/thermal/devfreq_cooling.c
> > @@ -24,11 +24,13 @@
> >   #include <linux/idr.h>
> >   #include <linux/slab.h>
> >   #include <linux/pm_opp.h>
> > +#include <linux/pm_qos.h>
> >   #include <linux/thermal.h>
> >   
> >   #include <trace/events/thermal.h>
> >   
> > -#define SCALE_ERROR_MITIGATION 100
> > +#define HZ_PER_KHZ		1000
> > +#define SCALE_ERROR_MITIGATION	100
> >   
> >   static DEFINE_IDA(devfreq_ida);
> >   
> > @@ -65,49 +67,9 @@ struct devfreq_cooling_device {
> >   	struct devfreq_cooling_power *power_ops;
> >   	u32 res_util;
> >   	int capped_state;
> > +	struct dev_pm_qos_request req_max_freq;
> >   };
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
> >   static int devfreq_cooling_get_max_state(struct thermal_cooling_device *cdev,
> >   					 unsigned long *state)
> >   {
> > @@ -134,7 +96,7 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
> >   	struct devfreq_cooling_device *dfc = cdev->devdata;
> >   	struct devfreq *df = dfc->devfreq;
> >   	struct device *dev = df->dev.parent;
> > -	int ret;
> > +	unsigned long freq;
> >   
> >   	if (state == dfc->cooling_state)
> >   		return 0;
> > @@ -144,9 +106,10 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
> >   	if (state >= dfc->freq_table_size)
> >   		return -EINVAL;
> >   
> > -	ret = partition_enable_opps(dfc, state);
> > -	if (ret)
> > -		return ret;
> > +	freq = dfc->freq_table[state];
> > +
> > +	dev_pm_qos_update_request(&dfc->req_max_freq,
> > +				  DIV_ROUND_UP(freq, HZ_PER_KHZ));
> >   
> >   	dfc->cooling_state = state;
> >   
> > @@ -529,6 +492,12 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
> >   	if (err)
> >   		goto free_dfc;
> >   
> > +	err = dev_pm_qos_add_request(df->dev.parent, &dfc->req_max_freq,
> > +				     DEV_PM_QOS_MAX_FREQUENCY,
> > +				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> > +	if (err < 0)
> > +		goto remove_qos_req;
> > +
> >   	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
> >   	if (err < 0)
> >   		goto free_tables;
> > @@ -552,6 +521,10 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
> >   
> >   release_ida:
> >   	ida_simple_remove(&devfreq_ida, dfc->id);
> > +
> > +remove_qos_req:
> > +	dev_pm_qos_remove_request(&dfc->req_max_freq); > +
> 
> A quirk of the dev_pm_qos API is that dev_pm_qos_remove_request prints a 
> WARN splat if !dev_pm_qos_request_active and this can true on 
> dev_pm_qos_add_request error.
> 
> I dealt with this by checking dev_pm_qos_request_active explicitly but 
> perhaps dev_pm_qos API could be changed? In general "free/release" 
> functions shouldn't complain if there's nothing to do.

I think we should be good here if we jump to 'free_tables' if
_add_request() fails, as requested by Chanwoo. Then _remove_request() is
only called when _add_request() was successful.

> >   free_tables:
> >   	kfree(dfc->power_table);
> >   	kfree(dfc->freq_table);
> > @@ -600,6 +573,7 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
> >   
> >   	thermal_cooling_device_unregister(dfc->cdev);
> >   	ida_simple_remove(&devfreq_ida, dfc->id);
> > +	dev_pm_qos_remove_request(&dfc->req_max_freq);
> >   	kfree(dfc->power_table);
> >   	kfree(dfc->freq_table);
