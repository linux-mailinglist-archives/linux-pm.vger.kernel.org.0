Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77A29B6EF3
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 23:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbfIRVlP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 17:41:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34567 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387521AbfIRVlP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 17:41:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so616957pgc.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pIZyn+G+bA7XtEVOcWB74dsFb9Insi2abCRrDc2HQeE=;
        b=XTmEYrvsMQthzUKL3yBYx8caiWqf/wT7Mr0lti3P3Za6WgWm/KTDYD7Zu4T/3PSV6c
         6Pj2pf3uecVmf0b1+RV6odqfUtL0q9gYfJISIKf/RTlROVHtyef4GgYwh4ySp10lwyrF
         4RgLTcieZkkdZIUrlF98yG0jD43EUE/+n2i80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pIZyn+G+bA7XtEVOcWB74dsFb9Insi2abCRrDc2HQeE=;
        b=S/X9lhqL1hk4tHX69ajdZNhE9sjVjC5xdMK7i8oL6MPt2eE7ewyT5mAVpnzimKdap8
         UzeMmX92Zqv8Ac9EJU9KJzNSFLtTR5rRNbUCFzReCxCxiYM5EhsnhHJ675w/RCK0abA+
         8C681ntix0TT0QobY7DZKgi7/5AT2iHq11IE3yKikIbkx169HbH7kiBoYYMbiQx3GNxA
         jHTDqsUoqxe10/p6xpzTOgS/AsXbk82xKh4l6kb9E1vRGGCjUmUmZrKHQD57iHC4v4Di
         mPy3eccs0QBiXIUDJySdIbNJ1n8RY3Mm0316hpifXNR+kNycxSh4iak6uMYOqr8l9kZo
         s6rA==
X-Gm-Message-State: APjAAAVRjLoloCEqV+CPWLk1aTCgE2fiH2nSuz+1lPXiiLcIg2brYBY+
        FLAD2ZHl60Tty8kATqTCYucXvQ==
X-Google-Smtp-Source: APXvYqw5kQ6N+iHQn1rHpL/B5Vq2EZxlSiSCFgV/INYo3Ec4YEO5FWuja1lQ6g05sCXgKtq/2YOszQ==
X-Received: by 2002:a63:b954:: with SMTP id v20mr5995525pgo.140.1568842874736;
        Wed, 18 Sep 2019 14:41:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id k95sm3616293pje.10.2019.09.18.14.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 14:41:14 -0700 (PDT)
Date:   Wed, 18 Sep 2019 14:41:11 -0700
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
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/8] PM / devfreq: Don't fail devfreq_dev_release if not
 in list
Message-ID: <20190918214111.GO133864@google.com>
References: <cover.1568764439.git.leonard.crestez@nxp.com>
 <60f8aa909fe209632734b6c637dffbc7554f996c.1568764439.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60f8aa909fe209632734b6c637dffbc7554f996c.1568764439.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 18, 2019 at 03:18:21AM +0300, Leonard Crestez wrote:
> Right now devfreq_dev_release will print a warning and abort the rest of
> the cleanup if the devfreq instance is not part of the global
> devfreq_list. But this is a valid scenario, for example it can happen if
> the governor can't be found or on any other init error that happens
> after device_register.
> 
> Initialize devfreq->node to an empty list head in devfreq_add_device so
> that list_del becomes a safe noop inside devfreq_dev_release and we can
> continue the rest of the cleanup.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 665575228c4f..a715f27f35fd 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -582,15 +582,10 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  static void devfreq_dev_release(struct device *dev)
>  {
>  	struct devfreq *devfreq = to_devfreq(dev);
>  
>  	mutex_lock(&devfreq_list_lock);
> -	if (IS_ERR(find_device_devfreq(devfreq->dev.parent))) {
> -		mutex_unlock(&devfreq_list_lock);
> -		dev_warn(&devfreq->dev, "releasing devfreq which doesn't exist\n");
> -		return;
> -	}
>  	list_del(&devfreq->node);
>  	mutex_unlock(&devfreq_list_lock);
>  
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
> @@ -641,10 +636,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	mutex_init(&devfreq->lock);
>  	mutex_lock(&devfreq->lock);
>  	devfreq->dev.parent = dev;
>  	devfreq->dev.class = devfreq_class;
>  	devfreq->dev.release = devfreq_dev_release;
> +	INIT_LIST_HEAD(&devfreq->node);
>  	devfreq->profile = profile;
>  	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>  	devfreq->previous_freq = profile->initial_freq;
>  	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
