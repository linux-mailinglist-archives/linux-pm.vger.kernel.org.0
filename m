Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD840183811
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 18:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgCLR5G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 13:57:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39123 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCLR5G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 13:57:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id j20so2954505pll.6
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GKEz68ESpXPJAa072THG40UuPGrAcIH+DPdEMO7j2rE=;
        b=ZPvq+Kj12dIhn0kdh7yG+ylXCTV/0P8J0zTihIgJE2H/xy+CMR+0eWx3Ce13it3VgZ
         QgTZ2hMd4TPYl007AOOdZjTg+6pnnH6amVEmgywPGBzfUpe6u2lawlkUYp6yf7XfggSF
         4UkUXH2YGQDphdFeGekiNLk23qfeaVBgDvhzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GKEz68ESpXPJAa072THG40UuPGrAcIH+DPdEMO7j2rE=;
        b=bUM9nIOgMDz8R+Oga3Q2c54brr1EEHsnWRLLlqVJ1VECXWFZeOiEDCZfBQMxPr0tQd
         qmMg7+zm57do3d1UejQiJZQMmysJzfZnjkHOwadyty3E96oQfGSD/616QB7VtM8mb8Vs
         Xm6xoE+hIABk+kltarrcN88dnLaAUD13Ci3DYVDoKeqFAAJiSiWxliDoQ55mik7W6Vq/
         TNaB9w1qpcu2esC9B2OJeVhuD4nr5OblAXadJrha9huKtye+nCNBbOo7jEyoqLpfsxWv
         uJZO4GWZh7q7mHYmbn4FnAsHXNr4GtUbYe29BAzBZfrcL9k+6F6z5wQLYrMNoGex/1jT
         LvIA==
X-Gm-Message-State: ANhLgQ2MCGNZB6IBs4Y+cR+3w+vEROsa5XKvc4fFDN05LdFV89jWbGNq
        MdZ9zKZB+Ge6vFRF28zjLl/2kw==
X-Google-Smtp-Source: ADFU+vtCt0C9TUxn16fx/bv9wbFqznFCKGIPg1zghwQKKRPO9+0wp4OyWbK3t71joEE3ZMDtDc94Eg==
X-Received: by 2002:a17:90a:7345:: with SMTP id j5mr5209763pjs.69.1584035824155;
        Thu, 12 Mar 2020 10:57:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id y143sm6420522pfb.22.2020.03.12.10.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 10:57:02 -0700 (PDT)
Date:   Thu, 12 Mar 2020 10:57:01 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2] thermal: devfreq_cooling: Use PM QoS to set frequency
 limits
Message-ID: <20200312175701.GE144492@google.com>
References: <CGME20200116231233epcas1p363ab7e3ad2966d0ae7bac11e33aa6b83@epcas1p3.samsung.com>
 <20200116151219.v2.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
 <d73e67eb-4f2d-dc4b-c718-929a964d3640@samsung.com>
 <20200312003519.GD144492@google.com>
 <f09ad5b3-c997-187a-d637-cc7cdcb282f9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f09ad5b3-c997-187a-d637-cc7cdcb282f9@arm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

thanks for the review!

I'll rebase and send v3. Hopefully it doesn't cause too much extra
work for your changes.

Thanks

Matthias

On Thu, Mar 12, 2020 at 11:39:56AM +0000, Lukasz Luba wrote:
> Hi Matthias,
> 
> I just saw this email below the patch. I wasn't aware that you
> are working on this. I will have to update my changes...
> 
> It looks good to me.
> Unfortunately, it does not apply on top of Amit's commit
> 1b5cb9570670a6277cc0 thermal: devfreq_cooling: Appease the kernel-doc deity
> 
> Could you check this?
> 
> Other then that
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Regards,
> Lukasz
> 
> On 3/12/20 12:35 AM, Matthias Kaehlcke wrote:
> > Is any further action needed from my side or can this land?
> > 
> > Thanks
> > 
> > Matthias
> > 
> > On Fri, Jan 17, 2020 at 02:22:02PM +0900, Chanwoo Choi wrote:
> > > On 1/17/20 8:12 AM, Matthias Kaehlcke wrote:
> > > > Now that devfreq supports limiting the frequency range of a device
> > > > through PM QoS make use of it instead of disabling OPPs that should
> > > > not be used.
> > > > 
> > > > The switch from disabling OPPs to PM QoS introduces a subtle behavioral
> > > > change in case of conflicting requests (min > max): PM QoS gives
> > > > precedence to the MIN_FREQUENCY request, while higher OPPs disabled
> > > > with dev_pm_opp_disable() would override MIN_FREQUENCY.
> > > > 
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > ---
> > > > 
> > > > Changes in v2:
> > > > - added documentation for 'req_max_freq'
> > > > - fixed jumps in of_devfreq_cooling_register_power() unwind
> > > > - added comment about behavioral change to the commit message
> > > > 
> > > >   drivers/thermal/devfreq_cooling.c | 70 ++++++++++---------------------
> > > >   1 file changed, 23 insertions(+), 47 deletions(-)
> > > > 
> > > > diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> > > > index ef59256887ff63..cbbaf5bc425d1a 100644
> > > > --- a/drivers/thermal/devfreq_cooling.c
> > > > +++ b/drivers/thermal/devfreq_cooling.c
> > > > @@ -24,11 +24,13 @@
> > > >   #include <linux/idr.h>
> > > >   #include <linux/slab.h>
> > > >   #include <linux/pm_opp.h>
> > > > +#include <linux/pm_qos.h>
> > > >   #include <linux/thermal.h>
> > > >   #include <trace/events/thermal.h>
> > > > -#define SCALE_ERROR_MITIGATION 100
> > > > +#define HZ_PER_KHZ		1000
> > > > +#define SCALE_ERROR_MITIGATION	100
> > > >   static DEFINE_IDA(devfreq_ida);
> > > > @@ -53,6 +55,8 @@ static DEFINE_IDA(devfreq_ida);
> > > >    *		'utilization' (which is	'busy_time / 'total_time').
> > > >    *		The 'res_util' range is from 100 to (power_table[state] * 100)
> > > >    *		for the corresponding 'state'.
> > > > + * @req_max_freq:	PM QoS request for limiting the maximum frequency
> > > > + *			of the devfreq device.
> > > >    */
> > > >   struct devfreq_cooling_device {
> > > >   	int id;
> > > > @@ -65,49 +69,9 @@ struct devfreq_cooling_device {
> > > >   	struct devfreq_cooling_power *power_ops;
> > > >   	u32 res_util;
> > > >   	int capped_state;
> > > > +	struct dev_pm_qos_request req_max_freq;
> > > >   };
> > > > -/**
> > > > - * partition_enable_opps() - disable all opps above a given state
> > > > - * @dfc:	Pointer to devfreq we are operating on
> > > > - * @cdev_state:	cooling device state we're setting
> > > > - *
> > > > - * Go through the OPPs of the device, enabling all OPPs until
> > > > - * @cdev_state and disabling those frequencies above it.
> > > > - */
> > > > -static int partition_enable_opps(struct devfreq_cooling_device *dfc,
> > > > -				 unsigned long cdev_state)
> > > > -{
> > > > -	int i;
> > > > -	struct device *dev = dfc->devfreq->dev.parent;
> > > > -
> > > > -	for (i = 0; i < dfc->freq_table_size; i++) {
> > > > -		struct dev_pm_opp *opp;
> > > > -		int ret = 0;
> > > > -		unsigned int freq = dfc->freq_table[i];
> > > > -		bool want_enable = i >= cdev_state ? true : false;
> > > > -
> > > > -		opp = dev_pm_opp_find_freq_exact(dev, freq, !want_enable);
> > > > -
> > > > -		if (PTR_ERR(opp) == -ERANGE)
> > > > -			continue;
> > > > -		else if (IS_ERR(opp))
> > > > -			return PTR_ERR(opp);
> > > > -
> > > > -		dev_pm_opp_put(opp);
> > > > -
> > > > -		if (want_enable)
> > > > -			ret = dev_pm_opp_enable(dev, freq);
> > > > -		else
> > > > -			ret = dev_pm_opp_disable(dev, freq);
> > > > -
> > > > -		if (ret)
> > > > -			return ret;
> > > > -	}
> > > > -
> > > > -	return 0;
> > > > -}
> > > > -
> > > >   static int devfreq_cooling_get_max_state(struct thermal_cooling_device *cdev,
> > > >   					 unsigned long *state)
> > > >   {
> > > > @@ -134,7 +98,7 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
> > > >   	struct devfreq_cooling_device *dfc = cdev->devdata;
> > > >   	struct devfreq *df = dfc->devfreq;
> > > >   	struct device *dev = df->dev.parent;
> > > > -	int ret;
> > > > +	unsigned long freq;
> > > >   	if (state == dfc->cooling_state)
> > > >   		return 0;
> > > > @@ -144,9 +108,10 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
> > > >   	if (state >= dfc->freq_table_size)
> > > >   		return -EINVAL;
> > > > -	ret = partition_enable_opps(dfc, state);
> > > > -	if (ret)
> > > > -		return ret;
> > > > +	freq = dfc->freq_table[state];
> > > > +
> > > > +	dev_pm_qos_update_request(&dfc->req_max_freq,
> > > > +				  DIV_ROUND_UP(freq, HZ_PER_KHZ));
> > > >   	dfc->cooling_state = state;
> > > > @@ -529,9 +494,15 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
> > > >   	if (err)
> > > >   		goto free_dfc;
> > > > -	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
> > > > +	err = dev_pm_qos_add_request(df->dev.parent, &dfc->req_max_freq,
> > > > +				     DEV_PM_QOS_MAX_FREQUENCY,
> > > > +				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> > > >   	if (err < 0)
> > > >   		goto free_tables;
> > > > +
> > > > +	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
> > > > +	if (err < 0)
> > > > +		goto remove_qos_req;
> > > >   	dfc->id = err;
> > > >   	snprintf(dev_name, sizeof(dev_name), "thermal-devfreq-%d", dfc->id);
> > > > @@ -552,6 +523,10 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
> > > >   release_ida:
> > > >   	ida_simple_remove(&devfreq_ida, dfc->id);
> > > > +
> > > > +remove_qos_req:
> > > > +	dev_pm_qos_remove_request(&dfc->req_max_freq);
> > > > +
> > > >   free_tables:
> > > >   	kfree(dfc->power_table);
> > > >   	kfree(dfc->freq_table);
> > > > @@ -600,6 +575,7 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
> > > >   	thermal_cooling_device_unregister(dfc->cdev);
> > > >   	ida_simple_remove(&devfreq_ida, dfc->id);
> > > > +	dev_pm_qos_remove_request(&dfc->req_max_freq);
> > > >   	kfree(dfc->power_table);
> > > >   	kfree(dfc->freq_table);
> > > > 
> > > 
> > > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> > > 
> > > -- 
> > > Best Regards,
> > > Chanwoo Choi
> > > Samsung Electronics
