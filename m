Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB95BBDB0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 23:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502668AbfIWVRb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 17:17:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42566 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388807AbfIWVRb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 17:17:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id z12so8702759pgp.9
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2019 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N95MsdqRLDPCEY+QRHvKun5AuuVKA0dNL8fLiXu/0Cg=;
        b=k6XDQMcMX/FluXi0dXqYSJDSePD6sqDu0z0lFPGsAxoV+Flo0unA5AcgyIZESbDtIR
         Vu/GntkLtVYCogrpj6via3LvixqfwTcoD5+qjVTErs71AFzRx+6PFDTM9NwCta3/2fBK
         8HDsPkcL1OthiS7I9vSuZhFjw1otZrwWqXVlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N95MsdqRLDPCEY+QRHvKun5AuuVKA0dNL8fLiXu/0Cg=;
        b=mmaSougF2f8dkkIq5C/eo2CbSoTeq7Av+e/6xSALXNy4Al3yKhwvS/e8U6bri/Br4c
         EekaQ8sZ4wrCdbKb5RbknGXg6/sR89qCHHT6jGRYjAPd8g16HQ0ix0AuJOClEJC9v5sx
         O+KMz1zyzLWbh7hw3rcekax8DM5S5Jq0j0kIZjX13ZASLlv+v2QcCwBfFoH3MraEiAI5
         8VbYcYTUJcELF/WY6RFrvqzupVr/JIFPu+pZU4kqeegWrlAl7ewKcH52THzstu4Vc2rn
         9RvdVN+B1zm77jL2p5T+aXKbOb6xscdhVzBFXMIBk52WjRpFxt6i42swvcVLp/DJuDHf
         Z3hw==
X-Gm-Message-State: APjAAAWDN5fIWFVmllb944vj6IOMzZzDMeAbCmRvnbjOTeRBvbkIiVpD
        yIUcvfjL9fvfxdDfCKC8KCUnbg==
X-Google-Smtp-Source: APXvYqykV3WYs8XcEDEnNcTSnrTXvYv+tSTY31OUpTMs3HzBY0qckn/U+D2Lh564cYcL+r0N5vkGvg==
X-Received: by 2002:a63:6c81:: with SMTP id h123mr1957566pgc.132.1569273450868;
        Mon, 23 Sep 2019 14:17:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id w69sm15371800pgd.91.2019.09.23.14.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 14:17:30 -0700 (PDT)
Date:   Mon, 23 Sep 2019 14:17:27 -0700
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
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v6 2/6] PM / devfreq: Move more initialization before
 registration
Message-ID: <20190923211727.GF133864@google.com>
References: <cover.1569252537.git.leonard.crestez@nxp.com>
 <0ad496507cd7e6731e46249b1499dfdebe205c16.1569252537.git.leonard.crestez@nxp.com>
 <20190923181057.GY133864@google.com>
 <VI1PR04MB7023C94F93C4E0E6E229F80AEE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <20190923191111.GE133864@google.com>
 <VI1PR04MB7023E58A11DF398FC90F98C7EE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR04MB7023E58A11DF398FC90F98C7EE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 23, 2019 at 07:56:51PM +0000, Leonard Crestez wrote:
> On 23.09.2019 22:11, Matthias Kaehlcke wrote:
> > On Mon, Sep 23, 2019 at 06:56:28PM +0000, Leonard Crestez wrote:
> >> On 23.09.2019 21:11, Matthias Kaehlcke wrote:
> >>> On Mon, Sep 23, 2019 at 06:51:05PM +0300, Leonard Crestez wrote:
> >>>> In general it is a better to initialize an object before making it
> >>>> accessible externally (through device_register).
> >>>>
> >>>> This makes it possible to avoid relying on locking a partially
> >>>> initialized object.
> >>>>
> >>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> >>>> ---
> >>>>    drivers/devfreq/devfreq.c | 43 +++++++++++++++++++++++----------------
> >>>>    1 file changed, 25 insertions(+), 18 deletions(-)
> >>>>
> >>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >>>> index 323d43315d1e..b4d2bfebb140 100644
> >>>> --- a/drivers/devfreq/devfreq.c
> >>>> +++ b/drivers/devfreq/devfreq.c
> >>>> @@ -587,10 +587,12 @@ static void devfreq_dev_release(struct device *dev)
> >>>>    	mutex_unlock(&devfreq_list_lock);
> >>>>    
> >>>>    	if (devfreq->profile->exit)
> >>>>    		devfreq->profile->exit(devfreq->dev.parent);
> >>>>    
> >>>> +	kfree(devfreq->time_in_state);
> >>>> +	kfree(devfreq->trans_table);
> >>>>    	mutex_destroy(&devfreq->lock);
> >>>>    	kfree(devfreq);
> >>>>    }
> >>>>    
> >>>>    /**
> >>>> @@ -670,44 +672,43 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >>>>    	devfreq->max_freq = devfreq->scaling_max_freq;
> >>>>    
> >>>>    	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
> >>>>    	atomic_set(&devfreq->suspend_count, 0);
> >>>>    
> >>>> -	dev_set_name(&devfreq->dev, "devfreq%d",
> >>>> -				atomic_inc_return(&devfreq_no));
> >>>> -	err = device_register(&devfreq->dev);
> >>>> -	if (err) {
> >>>> -		mutex_unlock(&devfreq->lock);
> >>>> -		put_device(&devfreq->dev);
> >>>> -		goto err_out;
> >>>> -	}
> >>>> -
> >>>> -	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
> >>>> +	devfreq->trans_table = kzalloc(
> >>>>    			array3_size(sizeof(unsigned int),
> >>>>    				    devfreq->profile->max_state,
> >>>>    				    devfreq->profile->max_state),
> >>>>    			GFP_KERNEL);
> >>>>    	if (!devfreq->trans_table) {
> >>>>    		mutex_unlock(&devfreq->lock);
> >>>>    		err = -ENOMEM;
> >>>> -		goto err_devfreq;
> >>>> +		goto err_dev;
> >>>>    	}
> >>>>    
> >>>> -	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
> >>>> -			devfreq->profile->max_state,
> >>>> -			sizeof(unsigned long),
> >>>> -			GFP_KERNEL);
> >>>> +	devfreq->time_in_state = kcalloc(devfreq->profile->max_state,
> >>>> +					 sizeof(unsigned long),
> >>>> +					 GFP_KERNEL);
> >>>>    	if (!devfreq->time_in_state) {
> >>>>    		mutex_unlock(&devfreq->lock);
> >>>>    		err = -ENOMEM;
> >>>> -		goto err_devfreq;
> >>>> +		goto err_dev;
> >>>>    	}
> >>>>    
> >>>>    	devfreq->last_stat_updated = jiffies;
> >>>>    
> >>>>    	srcu_init_notifier_head(&devfreq->transition_notifier_list);
> >>>>    
> >>>> +	dev_set_name(&devfreq->dev, "devfreq%d",
> >>>> +				atomic_inc_return(&devfreq_no));
> >>>> +	err = device_register(&devfreq->dev);
> >>>> +	if (err) {
> >>>> +		mutex_unlock(&devfreq->lock);
> >>>> +		put_device(&devfreq->dev);
> >>>> +		goto err_out;
> >>>
> >>> As per my comment on v5 I think the goto needs to go to 'err_dev'. The
> >>> device registration failed, hence devfreq_dev_release() won't be
> >>> called to free allocated memory.
> >>
> >> This code is not modified in the patch, it only shows up as +added
> >> because diff got confused but there is an identical -removed chunk
> >> higher up.
> >>
> >> The device_register documentation mentions the following:
> >>
> >>    * NOTE: _Never_ directly free @dev after calling this function, even
> >>    * if it returned an error! Always use put_device() to give up the
> >>    * reference initialized in this function instead.
> >>
> >> Cleanup path then goes like this (from a hacked error in device_add):
> >>    dump_stack+0xdc/0x144
> >>   
> >>
> >>    devfreq_dev_release+0x38/0xc0
> >>   
> >>
> >>    device_release+0x34/0x90
> >>   
> >>
> >>    kobject_put+0x8c/0x1f0
> >>   
> >>
> >>    put_device+0x24/0x30
> >>   
> >>
> >>    devfreq_add_device+0x540/0x570
> >>   
> >>
> >>    devm_devfreq_add_device+0x60/0xd0
> >>   
> >>
> >>    imx_ddrc_probe+0x35c/0x4c8
> > 
> > Good to know, thanks for the pointer!
> > 
> >> Can I add your "Reviewed-By" for the rest of the series if I fix the nits?
> > 
> > By now you should have it for most patches. For this one:
> > 
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > 
> > There is one doubt I have left on "PM / devfreq: Add PM QoS support" that I
> > posted on v5:
> > 
> > "IIUC you rely on the notifiers being removed by devfreq_dev_release().
> > Does dev_pm_qos_remove_notifier() behave gracefully if the notifier is
> > not initialized/added or do we need to use BLOCKING_NOTIFIER_INIT() or
> > similar?"
> 
> Sorry for missing that.
> > Could you clarify this replying to the thread? Besides that and the
> > nits (which are optional to fix) the patch looks good to me.
> 
> The blocking_notifier_head structs are managed by PM QoS inside 
> dev_pm_qos_constraints_allocate and dev_pm_qos_constraints_destroy. The 
> devfreq subsystem only registers a notifier_block, that's a 
> NULL-terminated singly-linked list for which zero-initialization from 
> kzalloc should be sufficient.

Right, thanks for the clarification!

> But now that I look at this again I should warn and return NOTIFY_DONE 
> from devfreq_qos_notifier_call instead of propagating a negative errno.

Ack
