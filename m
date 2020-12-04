Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB852CF4A9
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 20:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgLDTVq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 14:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgLDTVp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 14:21:45 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261B6C061A4F
        for <linux-pm@vger.kernel.org>; Fri,  4 Dec 2020 11:21:05 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id x6so2441409wro.11
        for <linux-pm@vger.kernel.org>; Fri, 04 Dec 2020 11:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3/Vcyqx/bnH5HvtWm7DxX6AP78VpEtIwur5saeHrMps=;
        b=TUOxVnxvXyCzCDNaCP/1OANO8jIe42W+4q7q2qx8Ps0PlTe/24v+H7yFqJCU2gjkly
         yKBoRXY4aK4pkL6YLXvLYYLZaAeWBYVxzIAomHRQlNhtPJUy3ZZJ5gNITiE3mFl9NwZd
         O60zEppYkoS7pItZJvY+EeEo5vXaCLAYAyg17cK+JS0A3Z9K8RkyB596xqkDsnM07ITa
         xG7mJ4bT9E2T5FCFvDFWSCIYeqJARgWN0EKd5adBG4I4BcjmXCSNo7F4Qmsq8MVHxTQ/
         C7MRTVSUrhDCM9wobCamGUfjbA4kp3iqkKsEsXuYBcMBe0BH1tE+YnE9YzUHXZzQVHIP
         HVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3/Vcyqx/bnH5HvtWm7DxX6AP78VpEtIwur5saeHrMps=;
        b=MRz/4vPs83GRIebFWOSD4Ef8ennjzL4n+AGim0K5YuLoJyt8HX/Fuo4aGsgL0okui9
         FE0FttRs6SW0M7DzlV7STBfaH8c+VDF9IKmvaqgjj+588mj5gHQLErWCpspM1R3lqmeH
         EikZA+UtU5rBgCBZKgFMnByquigrqrWYrnGsDCI0RimsXHm0QwxsgSTAybJ/KwdMeVqe
         s8rs+QIjwTaicVtePY99axrd/qDdgSpYJnvCuIe39TWAmuHiwIOhHAejOC1nSuQI5M9j
         Ic9LQXXG1BvalucotvS2+CieYKUa1jtYTBf7Orgk6cM95AcwSZxI/ksxhhmq4nIYKIj0
         vLiA==
X-Gm-Message-State: AOAM531dTh4WgCJ5AsYxA4St7eqlOh4/OdIJW7mtLXJdUb9PTcbGAd27
        4cPRqtLsuDSGYS9Xc0RpTFURyA==
X-Google-Smtp-Source: ABdhPJyjqDCyAdrqcYmrFgOrla80tX9wRIH3BP+ThyMlsUYuZKS+B/nZhU8IPBfUVxOJBZvAm5z4Rg==
X-Received: by 2002:adf:e449:: with SMTP id t9mr6493626wrm.257.1607109663627;
        Fri, 04 Dec 2020 11:21:03 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8165:c1cc:d736:b53f? ([2a01:e34:ed2f:f020:8165:c1cc:d736:b53f])
        by smtp.googlemail.com with ESMTPSA id s8sm4502818wrn.33.2020.12.04.11.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 11:21:02 -0800 (PST)
Subject: Re: [PATCH] drivers: thermal: Add NULL pointer check before using
 cooling device stats
To:     Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1607108991-31948-1-git-send-email-manafm@codeaurora.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <726f7a97-e663-64ff-d2bc-aaa23aaa85ec@linaro.org>
Date:   Fri, 4 Dec 2020 20:21:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1607108991-31948-1-git-send-email-manafm@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/12/2020 20:09, Manaf Meethalavalappu Pallikunhi wrote:
> There is a possible chance that some cooling device stats buffer
> allocation fails due to very high cooling device max state value.
> Later cooling device update or cooling stats sysfs will try to
> access stats data for the same cooling device. It will lead to
> NULL pointer dereference issue.
> 
> Add a NULL pointer check before accessing thermal cooling device
> stats data. It fixes the following bug

Why not create the 'stats' dir if the setup fails ?

> [ 26.812833] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
> [ 27.122960] Call trace:
> [ 27.122963] do_raw_spin_lock+0x18/0xe8
> [ 27.122966] _raw_spin_lock+0x24/0x30
> [ 27.128157] thermal_cooling_device_stats_update+0x24/0x98
> [ 27.128162] cur_state_store+0x88/0xb8
> [ 27.128166] dev_attr_store+0x40/0x58
> [ 27.128169] sysfs_kf_write+0x50/0x68
> [ 27.133358] kernfs_fop_write+0x12c/0x1c8
> [ 27.133362] __vfs_write+0x54/0x160
> [ 27.152297] vfs_write+0xcc/0x188
> [ 27.157132] ksys_write+0x78/0x108
> [ 27.162050] ksys_write+0xf8/0x108
> [ 27.166968] __arm_smccc_hvc+0x158/0x4b0
> [ 27.166973] __arm_smccc_hvc+0x9c/0x4b0
> [ 27.186005] el0_svc+0x8/0xc
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
> ---
>  drivers/thermal/thermal_sysfs.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 473449b..a5e4855 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -827,6 +827,9 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
>  {
>  	struct cooling_dev_stats *stats = cdev->stats;
>  
> +	if (!stats)
> +		return;
> +
>  	spin_lock(&stats->lock);
>  
>  	if (stats->state == new_state)
> @@ -848,6 +851,9 @@ static ssize_t total_trans_show(struct device *dev,
>  	struct cooling_dev_stats *stats = cdev->stats;
>  	int ret;
>  
> +	if (!stats)
> +		return -ENODEV;
> +
>  	spin_lock(&stats->lock);
>  	ret = sprintf(buf, "%u\n", stats->total_trans);
>  	spin_unlock(&stats->lock);
> @@ -864,6 +870,9 @@ time_in_state_ms_show(struct device *dev, struct device_attribute *attr,
>  	ssize_t len = 0;
>  	int i;
>  
> +	if (!stats)
> +		return -ENODEV;
> +
>  	spin_lock(&stats->lock);
>  	update_time_in_state(stats);
>  
> @@ -882,8 +891,12 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
>  {
>  	struct thermal_cooling_device *cdev = to_cooling_device(dev);
>  	struct cooling_dev_stats *stats = cdev->stats;
> -	int i, states = stats->max_states;
> +	int i, states;
> +
> +	if (!stats)
> +		return -ENODEV;
>  
> +	states = stats->max_states;
>  	spin_lock(&stats->lock);
>  
>  	stats->total_trans = 0;
> @@ -907,6 +920,9 @@ static ssize_t trans_table_show(struct device *dev,
>  	ssize_t len = 0;
>  	int i, j;
>  
> +	if (!stats)
> +		return -ENODEV;
> +
>  	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
>  	len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
>  	for (i = 0; i < stats->max_states; i++) {
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
