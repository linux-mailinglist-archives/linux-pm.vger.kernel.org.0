Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB78BBEFF
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 01:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391111AbfIWXem (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 19:34:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35982 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfIWXel (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 19:34:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so10231659pfr.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2019 16:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+G+rLbb52zBJRE1VmJ1LVcR80nuQp+i3zNouEcUswdc=;
        b=df4LL5mrvZVwXHwgH+E0fOsXZkcJ99sGcAGKxkIIICMrS7i5Za1cgdqlPDbVDJw4zi
         695p14YH+TBHD0dxdTGXFaTM/JlJgypNzf5PsNL3bRrBw+k7+pKDyn168LFMlQHJfobI
         HfrhDq+0tUQQnZ8d7bD+hvZCzaRZEnbGg6jXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+G+rLbb52zBJRE1VmJ1LVcR80nuQp+i3zNouEcUswdc=;
        b=dtwS7QxVBoJ9agk61PlRGA6Uxk+lbjTTGX7NErc6Ko65swAPomBceIEZhUD8wTJaNT
         wEwq4BM0axoMoaP79RzrrSRnV0aAXgKzA+d8/Ba0EC4dbQy9UedyMwpMhSj1i887hn0p
         p0vYonXGTiZjZPga5lL3CoHHWXgXP6ZSmfwhEw2ro2jMhk9xgQEFyZY0Ze6KYdiWSuqb
         xeTcvKijeWVvRzcvXomWOHNhowbrviyOHg1fVYdB0SypemUqEdHvoZleFc5zSsW5pe8h
         1be44i/LKDwApTfs9PD9qrnQWaAlOeiM5/MhWDX01+7kou1v8ANwugVTsf13z438CpCT
         VXBA==
X-Gm-Message-State: APjAAAXEYwj7CG/Fvzke9r4rEY3rlS5JSML5+nWN9EhMN7uth8Rhkh3Q
        Iimeb01RaD8C3qRqhGF1M71aag==
X-Google-Smtp-Source: APXvYqyJSn6aVOVdD1pVZnNSaY8DCStdL4Q5Ln5mJRy/cBS5iGdwfErV8aaYQJMqIH1Idb2/DbmJ3A==
X-Received: by 2002:a63:4042:: with SMTP id n63mr47731pga.75.1569281681253;
        Mon, 23 Sep 2019 16:34:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r186sm17531424pfr.40.2019.09.23.16.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 16:34:40 -0700 (PDT)
Date:   Mon, 23 Sep 2019 16:34:38 -0700
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
Message-ID: <20190923233438.GH133864@google.com>
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

nit: the comment doesn't add much value, I'd suggest to remove it.

Forgot to comment on this earlier. My Reviewed-by tag still stands, up
to you if you want to re-spin.
