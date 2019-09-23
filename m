Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A19BBBDA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 20:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfIWSzB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 14:55:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35802 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfIWSzB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 14:55:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id y10so5578958plp.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2019 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g60mybHGCbp+Gc4f97SO8os9p5j28yQXptZ6Fi87KY0=;
        b=d3a30Z/bHgSWI1WKIt7BlIwg88OHdDy44A0d1tyr910PgQuDPwWk5RQTTKHw1EsN3B
         50ziszTY8p0ToA5QBKml8Di9sGsnu+LeMKRRXbX+iMjL1VIcBnFTCV2+HvznkwEuaQXv
         sfxz+WjcgZ1FwLQiJvPQrSBfaln6xeqSbSDdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g60mybHGCbp+Gc4f97SO8os9p5j28yQXptZ6Fi87KY0=;
        b=i47yxf0ofBh30bRO+NNmIQVP247gZyWrRLfMA//vrhd09y4WfgUVkVySi+r+NAZWx6
         C38O3VM3pVdxwwRqkJ/bhe8KBwrbuVD2DPZUQ2aULHMLinc+LZ4gOgXF9AdRMJdUX4dl
         xRFPCHgvY1m3GwNvcR8AwVXIwXPC88U76zKxmsdUl9c8MzCpKTL5ljI+fOxgkuOtjlPs
         BC2fBAaM6g56I01XzYCrx4eArzpNwYDSFcaVAwkZbB5z62n1n9cRLL5sXvU3skpSAGyg
         fcCcPoTN4Q96KftDLI32kKzkelXxrfhTUDQ4yS8E59yt82tAPg8S9iqRPI8+DliN9BK0
         GVpQ==
X-Gm-Message-State: APjAAAXmpPuVek1vxmiVWRQABNMncdSyutwFrvPhLATbiSrUgsnU+t3t
        w/QavP4SOTgkQr3MYnigKnrufg==
X-Google-Smtp-Source: APXvYqyYMtEu3gYdMW1/wzwcXyQstf7KP40H/EEA/Zanwu73FgcAzv1Oh0HwkxBW+ua+V3YLfUOf3w==
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr1275387plk.215.1569264900656;
        Mon, 23 Sep 2019 11:55:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 1sm14804927pff.39.2019.09.23.11.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:54:59 -0700 (PDT)
Date:   Mon, 23 Sep 2019 11:54:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PM / devfreq: Lock devfreq in trans_stat_show
Message-ID: <20190923185457.GD133864@google.com>
References: <714675448e7fbf3c930b0dca6fbe54fa5f87211b.1569256001.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <714675448e7fbf3c930b0dca6fbe54fa5f87211b.1569256001.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 23, 2019 at 07:27:27PM +0300, Leonard Crestez wrote:
> There is no locking in this sysfs show function so stats printing can
> race with a devfreq_update_status called as part of freq switching or
> with initialization.
> 
> Also add an assert in devfreq_update_status to make it clear that lock
> must be held by caller.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> Changes since v1:
> * Split from series: low-priority bugfix not strictly required for PM QoS
> * Only keep lock during update, release before sprintf
> Link to v1: https://patchwork.kernel.org/patch/11149493/
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 4c58fbf7d4e4..00fc23fea5b2 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -206,10 +206,11 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
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
> @@ -1507,16 +1508,22 @@ static ssize_t trans_stat_show(struct device *dev,
>  	struct devfreq *devfreq = to_devfreq(dev);
>  	ssize_t len;
>  	int i, j;
>  	unsigned int max_state = devfreq->profile->max_state;
>  
> -	if (!devfreq->stop_polling &&
> -			devfreq_update_status(devfreq, devfreq->previous_freq))
> -		return 0;
>  	if (max_state == 0)
>  		return sprintf(buf, "Not Supported.\n");
>  
> +	/* lock and update */
> +	mutex_lock(&devfreq->lock);
> +	if (!devfreq->stop_polling &&
> +			devfreq_update_status(devfreq, devfreq->previous_freq)) {
> +		mutex_unlock(&devfreq->lock);
> +		return 0;
> +	}
> +	mutex_unlock(&devfreq->lock);
> +
>  	len = sprintf(buf, "     From  :   To\n");
>  	len += sprintf(buf + len, "           :");
>  	for (i = 0; i < max_state; i++)
>  		len += sprintf(buf + len, "%10lu",
>  				devfreq->profile->freq_table[i]);

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
