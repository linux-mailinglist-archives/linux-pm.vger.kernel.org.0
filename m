Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C33B8143
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 21:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391048AbfISTRE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 15:17:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43069 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfISTRE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 15:17:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id u72so2411771pgb.10
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 12:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3dlQ6O4U4Y6iTe68DKUl7bDSDWocpATfaoQJw9GaTwA=;
        b=BEAvPSDMRYZ7psL5CsA0bF0/tyiZdL5Pj4Blz60FpJHTg9+O6iIVTQAikrSRVEtX50
         jS+ZLqYWO7Qik2WlNNIa2T98BHbLrXnHn9ZZbAJZLxQlr2pVEQ/FMHv+QuOeQ+g4oBDZ
         9aTq09z4U3DkpRkdfiJcMWFXho8VFmc6AFMn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3dlQ6O4U4Y6iTe68DKUl7bDSDWocpATfaoQJw9GaTwA=;
        b=XQXcypU+WXv3elVrOMKpt/Ejp9X4z5CkzfcZxPJY07P/DGOr7QebcQFsuXEurKILhs
         YuFGgR/B0orWts357aCtUlC3J/K/nnxubC1NX30pYmttMTEndligZSbaUzIxPhWYafdn
         caEntKkxWNQi1P81NKs2dyneDB+GaLbVVUDroL+PA+HH1Rfv+s+Jq46EH4RAHSIBw4Je
         tYL887pXqHPjevNs7h4GFJzdTY2H/mwYk5+U63si5OfPYL7cYumSmx2E5BK5p+9gRqRv
         aynd8161NpNpp5pefgbnqIaUTJiFNCSuHPiSHmm902sHKANCQoQOlsHbKwPpX9uo8e4Z
         NeiA==
X-Gm-Message-State: APjAAAXQ8Q3Cp8fXIicXBi6YOGjTZfS3eJskFKepJY3Thg2QjCaatLoo
        fL7359TlF6JmSVOXJTp6KjZpPg==
X-Google-Smtp-Source: APXvYqyw0vY+LzMWyvC/PtDI3LAIIJ38He/wxtDobfuFTls9VDxuKUu1wJ2FE63lnnsle4oR6+aIIg==
X-Received: by 2002:a65:4002:: with SMTP id f2mr10770258pgp.447.1568920621694;
        Thu, 19 Sep 2019 12:17:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a17sm11919735pfc.26.2019.09.19.12.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 12:17:00 -0700 (PDT)
Date:   Thu, 19 Sep 2019 12:16:59 -0700
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
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/8] PM / devfreq: Move more initialization before
 registration
Message-ID: <20190919191659.GV133864@google.com>
References: <cover.1568764439.git.leonard.crestez@nxp.com>
 <59bd0d871fad520eb417ca46943fa7f86ef9186a.1568764439.git.leonard.crestez@nxp.com>
 <20190918232904.GP133864@google.com>
 <VI1PR04MB702350FA21534747D540C04FEE890@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR04MB702350FA21534747D540C04FEE890@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 19, 2019 at 06:52:07PM +0000, Leonard Crestez wrote:
> On 19.09.2019 02:29, Matthias Kaehlcke wrote:
> > Hi Leonard,
> > 
> > On Wed, Sep 18, 2019 at 03:18:22AM +0300, Leonard Crestez wrote:
> >> In general it is a better to initialize an object before making it
> >> accessible externally (through device_register).
> >>
> >> This make it possible to avoid relying on locking a partially
> >> initialized object.
> >>
> >> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> >> ---
> >>   drivers/devfreq/devfreq.c | 38 ++++++++++++++++++++------------------
> >>   1 file changed, 20 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >> index a715f27f35fd..57a217fc92de 100644
> >> --- a/drivers/devfreq/devfreq.c
> >> +++ b/drivers/devfreq/devfreq.c
> >> @@ -589,10 +589,12 @@ static void devfreq_dev_release(struct device *dev)
> >>   
> >>   	if (devfreq->profile->exit)
> >>   		devfreq->profile->exit(devfreq->dev.parent);
> >>   
> >>   	mutex_destroy(&devfreq->lock);
> >> +	kfree(devfreq->time_in_state);
> >> +	kfree(devfreq->trans_table);
> >>   	kfree(devfreq);
> >>   }
> >>   
> >>   /**
> >>    * devfreq_add_device() - Add devfreq feature to the device
> >> @@ -671,44 +673,43 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
> >    		goto err_dev;
> > 
> >> +	}
> >> +
> >>   	mutex_unlock(&devfreq->lock);
> >>   
> >>   	mutex_lock(&devfreq_list_lock);
> >>   
> >>   	governor = try_then_request_governor(devfreq->governor_name);
> >> @@ -734,14 +735,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >>   
> >>   	return devfreq;
> >>   
> >>   err_init:
> >>   	mutex_unlock(&devfreq_list_lock);
> >> -err_devfreq:
> >>   	devfreq_remove_device(devfreq);
> >> -	devfreq = NULL;
> >> +	return ERR_PTR(err);
> > 
> > The two return paths in the unwind part are unorthodox, but I
> > see why they are needed. Maybe add an empty line between the two paths
> > to make it a bit more evident that they are separate.
> 
> Old code did "devfreq = NULL" just so that the later kfree did nothing. 
> There were already two unwind paths, it's just that the second one was 
> less obvious. I will add a comment.
> 
> >>   err_dev:
> > 
> > This code path should include
> > 
> > 	mutex_destroy(&devfreq->lock);
> > 
> > That was already missing in the original code though.
> 
> Yes, that would be a separate patch.
> 
> > Actually with the later device registration the mutex could be
> > initialized later and doesn't need to be held. This would
> > obsolete the mutex_unlock() calls in the error paths
> Next patch already removes mutex_lock before device_register (that's the 
> purpose of the cleanup). If you're suggesting to move mutex_init around 
> it's not clear what would be gained?

As per my earlier reply to self: I didn't look at the next patch
before writing this, it's all good, nothing to do here :)
