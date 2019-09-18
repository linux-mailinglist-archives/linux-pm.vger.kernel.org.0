Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43566B6ECC
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 23:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfIRV2k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 17:28:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45360 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfIRV2k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 17:28:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so794692pfb.12
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qri0Ci/6Io8ZQOLMb0J47wZgXPltrE6CU1oNGGjo+T0=;
        b=eGsXUA3CvqG2Zq9JKWiq7uoo9O11pHqGntNkFluEcWAQBvRlcbMCRzH8MxCK45GMKp
         PvRHpeV2CuiKkFM4+sMcgjt5Si+3EZ63CXob2oc5ZVwAwGhG9TTu3P0CEgy94oVVWGnk
         9QiACfShv4bTyvw25pB5wy+MRoSmRb/EoElLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qri0Ci/6Io8ZQOLMb0J47wZgXPltrE6CU1oNGGjo+T0=;
        b=ehykShch/cBu6740T6+MYlg03u7kXJx5BsvfZjW9JIkiPoIiu2pr7R+5iU+i36uwJm
         Z4EIsUuaetxnfOHzq/fjVyVum/s+wyzwrLSYRSMOeg0Aas6/48pnhAa5hEaqoIh9cIUT
         XC9ZlkrO6VFlL9PFin8VlSjocCfC2j0Y12OKK8qNYN8P5gkQ4837qegM5B9K1VvhTSQp
         g7Db3t16I3WBuJSZGz2mrjMAuIMptxvZw886pb9oL/nfFQjWkYDmRRx9YIbUO8yLehML
         57eioEtXtBo/PCOHbnWKvOPjdS9ibnwnFEBu2d9z+GxrWA3Rwvv/qNxYTfc45sBO38y2
         0yiQ==
X-Gm-Message-State: APjAAAWv0m/hW2wOI7+Aom6KwrLotUQSlGzD985o+DHfFerarygfwgrj
        TJ6ul/bN/ho7t3LLlqF34aOFyw==
X-Google-Smtp-Source: APXvYqxXszwL+YGBJM/WR5hKmwW33kPCL9KeOCmjchKAHr+Jl6LDW1DO8yKZ1OMmIfhE253Vr2/jCw==
X-Received: by 2002:a62:2b46:: with SMTP id r67mr6748861pfr.140.1568842119375;
        Wed, 18 Sep 2019 14:28:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e127sm10649749pfe.37.2019.09.18.14.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 14:28:38 -0700 (PDT)
Date:   Wed, 18 Sep 2019 14:28:36 -0700
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
Subject: Re: [PATCH 1/8] PM / devfreq: Lock devfreq in trans_stat_show
Message-ID: <20190918212836.GN133864@google.com>
References: <cover.1568764439.git.leonard.crestez@nxp.com>
 <7d8f4d5c608d45ba19cdd52068fe6ffe30de67c1.1568764439.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d8f4d5c608d45ba19cdd52068fe6ffe30de67c1.1568764439.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

this series doesn't indicate the version, from the change history in
the cover letter I suppose it is v5.

On Wed, Sep 18, 2019 at 03:18:20AM +0300, Leonard Crestez wrote:
> There is no locking in this sysfs show function so stats printing can
> race with a devfreq_update_status called as part of freq switching or
> with initialization.
> 
> Also add an assert in devfreq_update_status to make it clear that lock
> must be held by caller.

This and some other patches look like generic improvements and not
directly related to the series "PM / devfreq: Add dev_pm_qos
support". If there are no dependencies I think it is usually better to
send the improvements separately, it keeps the series more focussed
and might reduce version churn. Just my POV though ;-)

> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2494ee16f502..665575228c4f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -159,10 +159,11 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  {
>  	int lev, prev_lev, ret = 0;
>  	unsigned long cur_time;
>  
>  	cur_time = jiffies;
> +	lockdep_assert_held(&devfreq->lock);
>  
>  	/* Immediately exit if previous_freq is not initialized yet. */
>  	if (!devfreq->previous_freq)
>  		goto out;
>  
> @@ -1415,15 +1416,20 @@ static ssize_t trans_stat_show(struct device *dev,
>  	struct devfreq *devfreq = to_devfreq(dev);
>  	ssize_t len;
>  	int i, j;
>  	unsigned int max_state = devfreq->profile->max_state;
>  
> +	mutex_lock(&devfreq->lock);
>  	if (!devfreq->stop_polling &&
> -			devfreq_update_status(devfreq, devfreq->previous_freq))
> -		return 0;
> -	if (max_state == 0)
> -		return sprintf(buf, "Not Supported.\n");
> +			devfreq_update_status(devfreq, devfreq->previous_freq)) {
> +		len = 0;

you could assign 'len' in the declaration instead, but it's just
another option, it'ss fine as is.

> +		goto out;
> +	}
> +	if (max_state == 0) {
> +		len = sprintf(buf, "Not Supported.\n");
> +		goto out;
> +	}

This leaves the general structure of the code as is, which is great,
but since you are already touching this part you can consider to
improve it: 'max_state' is constant after device creation, hence the
check could be done at the beginning, which IMO would be clearer, it
could also save an unnecessary devfreq_update_status() call and it
wouldn't be necessary to hold the lock (one goto less).

>  	len = sprintf(buf, "     From  :   To\n");
>  	len += sprintf(buf + len, "           :");
>  	for (i = 0; i < max_state; i++)
>  		len += sprintf(buf + len, "%10lu",
> @@ -1447,10 +1453,13 @@ static ssize_t trans_stat_show(struct device *dev,
>  			jiffies_to_msecs(devfreq->time_in_state[i]));
>  	}
>  
>  	len += sprintf(buf + len, "Total transition : %u\n",
>  					devfreq->total_trans);
> +
> +out:
> +	mutex_unlock(&devfreq->lock);
>  	return len;
>  }
>  static DEVICE_ATTR_RO(trans_stat);
>  
>  static struct attribute *devfreq_attrs[] = {

My only comments are possible improvements, but the change also looks
good as is, so:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
