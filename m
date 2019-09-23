Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13596BBC0F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 21:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbfIWTLQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 15:11:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39199 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733262AbfIWTLP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 15:11:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so5429630plp.6
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2019 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0vOcjEDzn9cUMJbiIHyNLx5k494Rzn8kxsOq8BmSW5w=;
        b=ih7XoQay/sQAFk+o1MFyOBRr7ErO9WjWCT3O9wwBmDsouG7VBjjbELYwgVpblyuwcB
         clu27mk5wTL5Xnhmw0ibcl/ct2br9/Ab+FaDYzGp+YC6dNtk35u/uGDiT6OCSn0Oj9bH
         eEp4GlKTS8f2gnbLgbPCUwRHbLz66sY+KjVs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0vOcjEDzn9cUMJbiIHyNLx5k494Rzn8kxsOq8BmSW5w=;
        b=IHbtnc/ddtv5osmIdsXQPjU3oc3qOyS2TkRaJzwDoUyRRZuAoixA1zt0N5y4b1utjL
         GddDymjCDIouQfOF4y9Ial+6u1O/mKTo4GXcgHAqrEB/g3YT4xcvF4KUG0eGdbGF9Jc1
         IDwePv2jro57b+UlrU3WyfPvLK+H+qwiR7bvRpX899VCWoua3R2KsDiKYJxArirU4Xv7
         N4aha0ZazS2SlW8/T6QUhklExTCiZgVuBcLfDUChxuppQUasCVCMCNWfx5CFgmrTiF1J
         PjKPW/tp5S7BHvA/Q4Zco/jlUeNBfZKeLPOwmaQg0sxJYN9reF3hQDWvAcxlF99MPl2s
         S0fw==
X-Gm-Message-State: APjAAAXQt7Us3ooLvE6aK0QYQ18nYeJQiM2JwrPmvtidJ/8tyo5uOdEi
        o96HeX2t7DjeMy+0rp1dyGRVfQ==
X-Google-Smtp-Source: APXvYqxSftqIm52bSa85DwFlcfJgctwn0cyraxKGm8Ki6rsdrE88uyP9fshRinMsH2EaA2YWvLyhYQ==
X-Received: by 2002:a17:902:9346:: with SMTP id g6mr1398924plp.0.1569265873814;
        Mon, 23 Sep 2019 12:11:13 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id w6sm20191999pfj.17.2019.09.23.12.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 12:11:13 -0700 (PDT)
Date:   Mon, 23 Sep 2019 12:11:11 -0700
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
Message-ID: <20190923191111.GE133864@google.com>
References: <cover.1569252537.git.leonard.crestez@nxp.com>
 <0ad496507cd7e6731e46249b1499dfdebe205c16.1569252537.git.leonard.crestez@nxp.com>
 <20190923181057.GY133864@google.com>
 <VI1PR04MB7023C94F93C4E0E6E229F80AEE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR04MB7023C94F93C4E0E6E229F80AEE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 23, 2019 at 06:56:28PM +0000, Leonard Crestez wrote:
> On 23.09.2019 21:11, Matthias Kaehlcke wrote:
> > On Mon, Sep 23, 2019 at 06:51:05PM +0300, Leonard Crestez wrote:
> >> In general it is a better to initialize an object before making it
> >> accessible externally (through device_register).
> >>
> >> This makes it possible to avoid relying on locking a partially
> >> initialized object.
> >>
> >> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> >> ---
> >>   drivers/devfreq/devfreq.c | 43 +++++++++++++++++++++++----------------
> >>   1 file changed, 25 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >> index 323d43315d1e..b4d2bfebb140 100644
> >> --- a/drivers/devfreq/devfreq.c
> >> +++ b/drivers/devfreq/devfreq.c
> >> @@ -587,10 +587,12 @@ static void devfreq_dev_release(struct device *dev)
> >>   	mutex_unlock(&devfreq_list_lock);
> >>   
> >>   	if (devfreq->profile->exit)
> >>   		devfreq->profile->exit(devfreq->dev.parent);
> >>   
> >> +	kfree(devfreq->time_in_state);
> >> +	kfree(devfreq->trans_table);
> >>   	mutex_destroy(&devfreq->lock);
> >>   	kfree(devfreq);
> >>   }
> >>   
> >>   /**
> >> @@ -670,44 +672,43 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >>   	devfreq->max_freq = devfreq->scaling_max_freq;
> >>   
> >>   	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
> >>   	atomic_set(&devfreq->suspend_count, 0);
> >>   
> >> -	dev_set_name(&devfreq->dev, "devfreq%d",
> >> -				atomic_inc_return(&devfreq_no));
> >> -	err = device_register(&devfreq->dev);
> >> -	if (err) {
> >> -		mutex_unlock(&devfreq->lock);
> >> -		put_device(&devfreq->dev);
> >> -		goto err_out;
> >> -	}
> >> -
> >> -	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
> >> +	devfreq->trans_table = kzalloc(
> >>   			array3_size(sizeof(unsigned int),
> >>   				    devfreq->profile->max_state,
> >>   				    devfreq->profile->max_state),
> >>   			GFP_KERNEL);
> >>   	if (!devfreq->trans_table) {
> >>   		mutex_unlock(&devfreq->lock);
> >>   		err = -ENOMEM;
> >> -		goto err_devfreq;
> >> +		goto err_dev;
> >>   	}
> >>   
> >> -	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
> >> -			devfreq->profile->max_state,
> >> -			sizeof(unsigned long),
> >> -			GFP_KERNEL);
> >> +	devfreq->time_in_state = kcalloc(devfreq->profile->max_state,
> >> +					 sizeof(unsigned long),
> >> +					 GFP_KERNEL);
> >>   	if (!devfreq->time_in_state) {
> >>   		mutex_unlock(&devfreq->lock);
> >>   		err = -ENOMEM;
> >> -		goto err_devfreq;
> >> +		goto err_dev;
> >>   	}
> >>   
> >>   	devfreq->last_stat_updated = jiffies;
> >>   
> >>   	srcu_init_notifier_head(&devfreq->transition_notifier_list);
> >>   
> >> +	dev_set_name(&devfreq->dev, "devfreq%d",
> >> +				atomic_inc_return(&devfreq_no));
> >> +	err = device_register(&devfreq->dev);
> >> +	if (err) {
> >> +		mutex_unlock(&devfreq->lock);
> >> +		put_device(&devfreq->dev);
> >> +		goto err_out;
> > 
> > As per my comment on v5 I think the goto needs to go to 'err_dev'. The
> > device registration failed, hence devfreq_dev_release() won't be
> > called to free allocated memory.
> 
> This code is not modified in the patch, it only shows up as +added 
> because diff got confused but there is an identical -removed chunk 
> higher up.
> 
> The device_register documentation mentions the following:
> 
>   * NOTE: _Never_ directly free @dev after calling this function, even
>   * if it returned an error! Always use put_device() to give up the
>   * reference initialized in this function instead.
> 
> Cleanup path then goes like this (from a hacked error in device_add):
>   dump_stack+0xdc/0x144 
>  
> 
>   devfreq_dev_release+0x38/0xc0 
>  
> 
>   device_release+0x34/0x90 
>  
> 
>   kobject_put+0x8c/0x1f0 
>  
> 
>   put_device+0x24/0x30 
>  
> 
>   devfreq_add_device+0x540/0x570 
>  
> 
>   devm_devfreq_add_device+0x60/0xd0 
>  
> 
>   imx_ddrc_probe+0x35c/0x4c8

Good to know, thanks for the pointer!

> Can I add your "Reviewed-By" for the rest of the series if I fix the nits?

By now you should have it for most patches. For this one:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

There is one doubt I have left on "PM / devfreq: Add PM QoS support" that I
posted on v5:

"IIUC you rely on the notifiers being removed by devfreq_dev_release().
Does dev_pm_qos_remove_notifier() behave gracefully if the notifier is
not initialized/added or do we need to use BLOCKING_NOTIFIER_INIT() or
similar?"

Could you clarify this replying to the thread? Besides that and the
nits (which are optional to fix) the patch looks good to me.



