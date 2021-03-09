Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC305332B9A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 17:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhCIQJp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 11:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhCIQJZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 11:09:25 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF880C06174A;
        Tue,  9 Mar 2021 08:09:25 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so5255898pjh.1;
        Tue, 09 Mar 2021 08:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KaMXn0pMS8J3mRJDLiSjS4fXXVlLK3DYv12RDA96f1Y=;
        b=BjBB+2zmUOvsaNw0J75MSqjzIyy0S0HKp4/lMVvKyCgeZQcuqktpU497AbTnQODZtZ
         dszHS8WQqIWOoO6f3H1SlfcETtbpKZxiCv7Cg6s+Nu+uGCbCJ9VAUV0bwrZ4hbZgmpqr
         5147Mz5iCbrp+drCN83YBwD5ctJWsmSFWs3u5Vqy4gplwrGYPNFaatCamkSeVO+gX/Vz
         1Z2uy0wFxPBzhasDHBGZPaoXa3vkHkK6fEPABXhT8eSrCUL2Oe+Iu7zv2iNGfeQ3/Oq+
         dopTDxgd5o4VBt5V+/EJysTx+3CFqxHiDRAGh1HJvc2HwJQFf1CeS6Tz4iB5EDQA3p7F
         Wpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KaMXn0pMS8J3mRJDLiSjS4fXXVlLK3DYv12RDA96f1Y=;
        b=dl4H8lpCjvMcttrFEIRVZvUuexdsfV3SN2SpDaChNhaQBpRipE4TNwoqp0P1Q6XUl8
         UR7BU0/Uw4T3/bTAqeRrw78eeu133TSNLNucvaZM99LQKmOwdr6xbD++RV5IkTJhEfw+
         4VODF2S5SWfBNisa5uMOMjqRtQRVmcCpL3TuoXt5fVEFS3zptcGqYMUrvmwGd2nKTOLa
         xMHyYCiP95UaYrEjaW4dv+l7ZW0l8OI8RHO1g1Kjhz8FRUw+Ea2zTENChC1mfJuBYnCz
         l+9nXsq9cDtK4j3zaJkRXzh2K4hAyvf+I+OzeFWE1GAPuuQO5NQ2wLjYKN1fya9m74+G
         d5WQ==
X-Gm-Message-State: AOAM530KdWyn4FiyeGHyWtDHpk9+q9Z5vZ/R0JngUBPWyjpAwcDvq+oX
        TQUFd6XS5VIfQIN0xTyUGZk=
X-Google-Smtp-Source: ABdhPJwh1Wt9ebON43/2XTRoDlfivpp2Dw9EAQBxTjT62yc/V58eq9Oc22zqnF21AlOo0oyxw2xjEA==
X-Received: by 2002:a17:902:6944:b029:e6:190d:56cd with SMTP id k4-20020a1709026944b02900e6190d56cdmr12101463plt.53.1615306165363;
        Tue, 09 Mar 2021 08:09:25 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id i20sm13105337pgg.65.2021.03.09.08.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 08:09:24 -0800 (PST)
Subject: Re: [PATCH 09/11] PM / devfreq: governor: optimize simpleondemand
 get_target_freq
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-10-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <4cee7ace-e6b9-fa0c-7cfe-d794ac9deabf@gmail.com>
Date:   Wed, 10 Mar 2021 01:09:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1615294733-22761-10-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
> devfreq_simple_ondemand_data only needs to be initialized once when
> calling devm_devfreq_add_device. It's unnecessary to put the data
> check logic in the hot path (.get_target_freq()) where it will be
> called all the time during polling. Instead, we only check and initialize
> it one time during DEVFREQ_GOV_START.
> 
> This also helps check data validability in advance during DEVFREQ_GOV_START
> rather than checking it later when running .get_target_freq().
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   drivers/devfreq/governor_simpleondemand.c | 50 +++++++++++++++--------
>   1 file changed, 34 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index ea287b57cbf3..341eb7e9dc04 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -15,15 +15,19 @@
>   /* Default constants for DevFreq-Simple-Ondemand (DFSO) */
>   #define DFSO_UPTHRESHOLD	(90)
>   #define DFSO_DOWNDIFFERENCTIAL	(5)
> +
> +static struct devfreq_simple_ondemand_data od_default = {
> +	.upthreshold = DFSO_UPTHRESHOLD,
> +	.downdifferential = DFSO_DOWNDIFFERENCTIAL,
> +};
> +
>   static int devfreq_simple_ondemand_func(struct devfreq *df,
>   					unsigned long *freq)
>   {
>   	int err;
>   	struct devfreq_dev_status *stat;
>   	unsigned long long a, b;
> -	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
> -	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
> -	struct devfreq_simple_ondemand_data *data = df->data;
> +	struct devfreq_simple_ondemand_data *od = df->data;
>   
>   	err = devfreq_update_stats(df);
>   	if (err)
> @@ -31,16 +35,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>   
>   	stat = &df->last_status;
>   
> -	if (data) {
> -		if (data->upthreshold)
> -			dfso_upthreshold = data->upthreshold;
> -		if (data->downdifferential)
> -			dfso_downdifferential = data->downdifferential;
> -	}
> -	if (dfso_upthreshold > 100 ||
> -	    dfso_upthreshold < dfso_downdifferential)
> -		return -EINVAL;
> -
>   	/* Assume MAX if it is going to be divided by zero */
>   	if (stat->total_time == 0) {
>   		*freq = DEVFREQ_MAX_FREQ;
> @@ -55,7 +49,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>   
>   	/* Set MAX if it's busy enough */
>   	if (stat->busy_time * 100 >
> -	    stat->total_time * dfso_upthreshold) {
> +	    stat->total_time * od->upthreshold) {
>   		*freq = DEVFREQ_MAX_FREQ;
>   		return 0;
>   	}
> @@ -68,7 +62,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>   
>   	/* Keep the current frequency */
>   	if (stat->busy_time * 100 >
> -	    stat->total_time * (dfso_upthreshold - dfso_downdifferential)) {
> +	    stat->total_time * (od->upthreshold - od->downdifferential)) {
>   		*freq = stat->current_frequency;
>   		return 0;
>   	}
> @@ -78,17 +72,41 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>   	a *= stat->current_frequency;
>   	b = div_u64(a, stat->total_time);
>   	b *= 100;
> -	b = div_u64(b, (dfso_upthreshold - dfso_downdifferential / 2));
> +	b = div_u64(b, (od->upthreshold - od->downdifferential / 2));
>   	*freq = (unsigned long) b;
>   
>   	return 0;
>   }
>   
> +static int devfreq_simple_ondemand_check_od(struct devfreq *devfreq)
> +{
> +	struct devfreq_simple_ondemand_data *od = devfreq->data;
> +
> +	if (od) {
> +		if (!od->upthreshold)
> +			od->upthreshold = DFSO_UPTHRESHOLD;
> +
> +		if (!od->downdifferential)
> +			od->downdifferential = DFSO_DOWNDIFFERENCTIAL;
> +
> +		if (od->upthreshold > 100 ||
> +		    od->upthreshold < od->downdifferential)
> +			return -EINVAL;
> +	} else {
> +		od = &od_default;
> +	}
> +
> +	return 0;
> +}
> +
>   static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
>   				unsigned int event, void *data)
>   {
>   	switch (event) {
>   	case DEVFREQ_GOV_START:
> +		if (devfreq_simple_ondemand_check_od(devfreq))
> +			return -EINVAL;
> +
>   		return devfreq_monitor_start(devfreq);
>   
>   	case DEVFREQ_GOV_STOP:
> 

I'm editing the upthreshold and downdifferential for exposing them
via sysfs. So that after my work to expose them via sysfs,
send the patches if you think that need to do more about them.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing&id=dc9e557845c17cee173a6adcc3ae14940da03f44

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
