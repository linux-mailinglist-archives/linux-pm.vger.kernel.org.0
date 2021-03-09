Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365D3332B52
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 16:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhCIP7A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 10:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhCIP6p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 10:58:45 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F70CC06174A;
        Tue,  9 Mar 2021 07:58:45 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso5434742pjb.3;
        Tue, 09 Mar 2021 07:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pCTLgyJmDFeD56n8IUl4QFZTL7P5pMyXAP3fRfLsqCA=;
        b=EMnKZMFI2eLQ0rt0e9KDNFrGAgUHGDjzC0XkQdB60i3fGhH27/FLqoqgJwiM/rAhnr
         eBm2zmS8FTDC8jwt7hkgFnphw7seNAkJFocrNVE5xy96ge3eZL3iN4rqCnKrB1mQ9HPU
         jkwlcY5Ax1itn0BeZ+ybMDllYyAKg2cNsSmzz3jPK1dqASYhBtMvhOAD5ldPDfOnIk3j
         n9ba7U3EnT2Vjse07/AYtWJ03e+Jb0qvoPVSm1J6meKZvf6FyGYZGTm8HmbdRJD3983s
         yl7BPcqQmE9ZTzM7qjox9xpwFjZMO5pSm8729cHeb2LkZ1Ayybvcf90vGAF2Fo08Am3u
         nvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pCTLgyJmDFeD56n8IUl4QFZTL7P5pMyXAP3fRfLsqCA=;
        b=UxVnCz3RRNpwFHY037r06TD9llRnRd+kbhSc2WhlSzU1baPAV04IHJ3n+ZsxQinf6D
         2APlXxA15vwSKQRJQEEKTOrvD0jikQCOh8AOjRawIXF5RrMEThsUhSsptKGyu+qTiHeW
         rME6giMWOmf1xNllIPOlMPGL84iVRa0dv4Y5ROPElusdMLTITYpGK/indxY+VRzmBLMh
         8jS3PkiOKYBNkiduC5PISD2dy7GAe+oTLRcKVQgG+EUWf3/viMNA+/6+jc4uKUqECZGd
         j1F9j/Z19RvLS2+TMsVyP74/gv+8gq27gtx9IEZmSZbUweOIvsM//OoLmqar71mtLQJO
         VqUA==
X-Gm-Message-State: AOAM533niqXrfQ8lJJSOch6iWaAFItt44vDj8uCy0ec7QhjrvZGV5Zyh
        bxBUlWshndZqh6NQBO4PmPw=
X-Google-Smtp-Source: ABdhPJw12w2HrAYuH89g+Rsn9/jFr7o/q1FZOEm66TRiXHODXNYZnQjjpwnrwOdoEre8+kAnujMsoQ==
X-Received: by 2002:a17:90b:e01:: with SMTP id ge1mr5506817pjb.117.1615305524561;
        Tue, 09 Mar 2021 07:58:44 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id q95sm3557419pjq.20.2021.03.09.07.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 07:58:43 -0800 (PST)
Subject: Re: [PATCH 07/11] PM / devfreq: check get_dev_status before start
 monitor
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-8-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <de25cd22-7f17-5902-21d3-881e3128dd31@gmail.com>
Date:   Wed, 10 Mar 2021 00:58:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1615294733-22761-8-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
> The devfreq monitor depends on the device to provide load information
> by .get_dev_status() to calculate the next target freq.
> 
> And this will cause changing governor to simple ondemand fail
> if device can't support.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   drivers/devfreq/devfreq.c                 | 10 +++++++---
>   drivers/devfreq/governor.h                |  2 +-
>   drivers/devfreq/governor_simpleondemand.c |  3 +--
>   3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 7231fe6862a2..d1787b6c7d7c 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -482,10 +482,13 @@ static void devfreq_monitor(struct work_struct *work)
>    * to be called from governor in response to DEVFREQ_GOV_START
>    * event when device is added to devfreq framework.
>    */
> -void devfreq_monitor_start(struct devfreq *devfreq)
> +int devfreq_monitor_start(struct devfreq *devfreq)
>   {
>   	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
> -		return;
> +		return 0;
> +
> +	if (!devfreq->profile->get_dev_status)
> +		return -EINVAL;
>   
>   	switch (devfreq->profile->timer) {
>   	case DEVFREQ_TIMER_DEFERRABLE:
> @@ -495,12 +498,13 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>   		INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>   		break;
>   	default:
> -		return;
> +		return -EINVAL;
>   	}
>   
>   	if (devfreq->profile->polling_ms)
>   		queue_delayed_work(devfreq_wq, &devfreq->work,
>   			msecs_to_jiffies(devfreq->profile->polling_ms));
> +	return 0;
>   }
>   EXPORT_SYMBOL(devfreq_monitor_start);
>   
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index 5cee3f64fe2b..31af6d072a10 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -75,7 +75,7 @@ struct devfreq_governor {
>   				unsigned int event, void *data);
>   };
>   
> -void devfreq_monitor_start(struct devfreq *devfreq);
> +int devfreq_monitor_start(struct devfreq *devfreq);
>   void devfreq_monitor_stop(struct devfreq *devfreq);
>   void devfreq_monitor_suspend(struct devfreq *devfreq);
>   void devfreq_monitor_resume(struct devfreq *devfreq);
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index d57b82a2b570..ea287b57cbf3 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -89,8 +89,7 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
>   {
>   	switch (event) {
>   	case DEVFREQ_GOV_START:
> -		devfreq_monitor_start(devfreq);
> -		break;
> +		return devfreq_monitor_start(devfreq);
>   
>   	case DEVFREQ_GOV_STOP:
>   		devfreq_monitor_stop(devfreq);
> 

Need to handle the all points of devfreq_monitor_start() usage.
please check the tegra30-devfreq.c for this update.

$ grep -rn "devfreq_monitor_start" drivers/
drivers/devfreq/governor_simpleondemand.c:92: 
devfreq_monitor_start(devfreq);
drivers/devfreq/tegra30-devfreq.c:744:		devfreq_monitor_start(devfreq);
......

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
