Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC082F2575
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 03:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbfKGCcb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 21:32:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45084 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731985AbfKGCcb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 21:32:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id y24so365113plr.12
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 18:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nl2Mea8Rokw8Wx2e2e71KCUjhDzjpq7/mhTjcPwYpZM=;
        b=ySrw0JScvImGl+1fG79/mBYyTpLAWgH0FCRpC4cXOitEqMwKWn9Ocot0CfmZ5oudtf
         /AWBrcZcK5ILO4jN9SKSiT18ts8Jch/vFg3gNqymuuO8sJ/YLAG9HYsBNS4Agg2FAkNo
         +YUKOpsOZfAX81EIjyKB651+N7FYoQ/BdN7cmqA2x40tuvdzinFZa1/C889qWN4V6lr3
         YfItVvv1n5STPl6MPyZ5fX+Q0YqmOjNPHkdh+bgi4MtY5l6hjP24cZ9taqW6sFtxd1iv
         7ncrheIY2O+4nx+W0SCpK1v/d7HlVX7cUPO11k6y4DJHYfFwcezxpKfwViwiKj/g6T0Z
         0ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nl2Mea8Rokw8Wx2e2e71KCUjhDzjpq7/mhTjcPwYpZM=;
        b=mes0aWo3x1r7Gz1jPyWPvutHi9Q5ucyukwEgIvzb8WBdk8+9YzrKGOM4shCrFFUX6V
         GqGGBk6zVYkA/8lrtHFvB+dIuEkNYE2pKDbrCSkQfNL3HAommGlpJux+MkSFxmlV7NVY
         G45pQHJZvuEUFxhIqgKEwHEO7vYf5WY+YoWoX0iTf3/NZKLR1LY0Eh996S8tDqx8nM4R
         v/S2tXsmgnvx6oRiSrSUkDNKeJerjCJ0lPBLKlkPAHfS7FTVyK9He544VF4qFcoTbNKO
         3QkBTjrtfEkYQC1BYS9ueQFcb8N/BaQ0LKBvQ9yTR6qm2RNvZBKaf3vHemgRRIJHvZ8l
         53qg==
X-Gm-Message-State: APjAAAWopSWf3TcTbOqUB6plK2KlE4eEhI8hRHhsDbGD/6mqYaooI8Zk
        0BBXAZa5yPHYSFBsaKSAS9byAg==
X-Google-Smtp-Source: APXvYqwTgmaTTcdRBiQwOKGDGaJN9xcsfQYjQeDPX5BYidERIXOGFWDWM4PBdkBNvS7ZPkzbWu3B5Q==
X-Received: by 2002:a17:902:8647:: with SMTP id y7mr1026883plt.285.1573093950705;
        Wed, 06 Nov 2019 18:32:30 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id 26sm272671pjg.21.2019.11.06.18.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:32:30 -0800 (PST)
Date:   Thu, 7 Nov 2019 08:02:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shen Kai <shenkai8@huawei.com>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, hushiyuan@huawei.com,
        linfeilong@huawei.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH]cpufreq: add NULL check to the store method of cpufreq
Message-ID: <20191107023223.p2ihcfpm3zy6iwoc@vireshk-i7>
References: <CAJZ5v0h5t2Hv60Y77HaM6DgTS3-m2moNu3DOX4zp8S4YgpS_ag@mail.gmail.com>
 <1573091585-8628-1-git-send-email-shenkai8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573091585-8628-1-git-send-email-shenkai8@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-11-19, 01:53, Shen Kai wrote:
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
>  drivers/cpufreq/cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index bffc11b..4ccaa96 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -947,6 +947,9 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>  	struct freq_attr *fattr = to_attr(attr);
>  	ssize_t ret = -EINVAL;
>  
> +	if (!fattr->store)
> +		return ret;

The return error shouldn't be -EINVAL here, maybe ENOPERM or ENOENT ?

> +
>  	/*
>  	 * cpus_read_trylock() is used here to work around a circular lock
>  	 * dependency problem with respect to the cpufreq_register_driver().
> -- 
> 2.6.4.windows.1
> 

-- 
viresh
