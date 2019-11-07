Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 804E9F2765
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 06:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfKGFsR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 00:48:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37544 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfKGFsR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 00:48:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id p24so1638697pfn.4
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 21:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zKiQkjJzmURdbTvegUiBy0J26z14a1VNU/DSXN2auW0=;
        b=yFiP5ych+WeuRMUjDfI+xko/RkXdrlfpPXtSZ8TUM3+VV18JQWPVZpeSwkyWrHjxAq
         0w29679gwQVWrTGEQtZssAYUUHadIS+TAFv4NwepljtFANxxGT53ckNx/DpjOzYJVQPP
         iMvJJCsY+vmLQq6WxdeELq/ZJEo7wp1I8ej0iaVQmxFMnRXHWd7QuVKVJbYQrFJYJLa5
         I8Y+7Wja6bIiB9uoGxe+iz2dktgmTFrHmoKblm1XhQEyFXShDpHl4KoQazNJrFY6X43w
         UKNkDWutqGEMPMoTyp2I7Fxvh0XFoxjHpsC9OnjlhpfNkLoYKXT15Qw5qA+kUE9pm3iX
         v9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zKiQkjJzmURdbTvegUiBy0J26z14a1VNU/DSXN2auW0=;
        b=FBTw6BHzin9mKiAIkp+UM/5Zvy2K+eCvBywneaK4E5/L/TsPeTUOt93Kb9R3I3ojbZ
         Tue1dLvVDkw/YK+J5Yvwpuz6pQHADZyA5obDBArJ1VwP2cNs5A0Fv+DVpQHOIADLh3Ka
         qE6RwAKrjYI/tyi0qJpzG3RqpoOiJZq9VpFHNiJ80qYrBt4BdijmrlDvUk9oOFCVBaHo
         TSovhpvfHDpYlNZmfg2v//40lRCZcqyOoMgPdGuYg42nebc2syCvCd4puFp7sgnv2B4d
         UeNJtcKP/P/Kp2hGJKGdorQ78mVlvOELsz/KwFHRrJYdMdDzUtZPzqV7A5ph7tRcOD0j
         08LA==
X-Gm-Message-State: APjAAAWXakAIwYQQ3FMUEdrZ6yCo1QiSByoq/i7PDeIAY6cOfekKs3nG
        NlkMu2yx9vIgmOqdeGtDkeH6NAlpyYM=
X-Google-Smtp-Source: APXvYqy+YsFoEjD7/6qe5eKLPq0DpfygXMsqpKK9uEQ9fwxhPOKgfObRcFtJCH2URrNTPjm9ilgwLw==
X-Received: by 2002:a17:90a:7608:: with SMTP id s8mr2586708pjk.75.1573105696134;
        Wed, 06 Nov 2019 21:48:16 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id f13sm941984pgs.83.2019.11.06.21.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 21:48:14 -0800 (PST)
Date:   Thu, 7 Nov 2019 11:18:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shen Kai <shenkai8@huawei.com>
Cc:     hushiyuan@huawei.com, linfeilong@huawei.com,
        rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net
Subject: Re: [PATCH v3]cpufreq: add NULL check to the store method of cpufreq
Message-ID: <20191107054812.iag3nd6gklngds54@vireshk-i7>
References: <20191107030601.xqe2tpcprkg7epul@vireshk-i7>
 <1573103297-7252-1-git-send-email-shenkai8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573103297-7252-1-git-send-email-shenkai8@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-11-19, 05:08, Shen Kai wrote:
> From: Kai Shen <shenkai8@huawei.com>
> 
> Add NULL check in the store function here to avoid NULL callback invoking.
> Though some interfaces of cpufreq are set as read-only, user can still get 
> write permission using chmod which can lead to a kernel crash.
> 
> The following operations can lead to a kernel crash.
> 
> chmod +w /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> echo 1 >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> 
> This bug was found on linux 4.19
> 
> Signed-off-by: Kai Shen <shenkai8@huawei.com>
> Reported-by: Feilong Lin <linfeilong@huawei.com>
> Reviewed-by: Feilong Lin <linfeilong@huawei.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2->V3
> - use return value -EIO instead.
> - do NULL check in show method too.
> 
>  drivers/cpufreq/cpufreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 48a224a..bc19d6c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -933,6 +933,9 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
>  	struct freq_attr *fattr = to_attr(attr);
>  	ssize_t ret;
>  
> +	if (!fattr->show)
> +		return -EIO;
> +
>  	down_read(&policy->rwsem);
>  	ret = fattr->show(policy, buf);
>  	up_read(&policy->rwsem);
> @@ -947,6 +950,9 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>  	struct freq_attr *fattr = to_attr(attr);
>  	ssize_t ret = -EINVAL;
>  
> +	if (!fattr->store)
> +		return -EIO;
> +
>  	/*
>  	 * cpus_read_trylock() is used here to work around a circular lock
>  	 * dependency problem with respect to the cpufreq_register_driver().

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
