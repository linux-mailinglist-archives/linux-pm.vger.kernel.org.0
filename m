Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF07330D75E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 11:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhBCKWl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 05:22:41 -0500
Received: from foss.arm.com ([217.140.110.172]:37324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233405AbhBCKWl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Feb 2021 05:22:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEE7BD6E;
        Wed,  3 Feb 2021 02:21:49 -0800 (PST)
Received: from [10.57.13.36] (unknown [10.57.13.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A47C3F719;
        Wed,  3 Feb 2021 02:21:47 -0800 (PST)
Subject: Re: [RFC][PATCH 1/3] PM /devfreq: add user frequency limits into
 devfreq struct
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, amitk@kernel.org, rui.zhang@intel.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
References: <20210126104001.20361-1-lukasz.luba@arm.com>
 <CGME20210126104217epcas1p349c717ccf0ea4f964153040b48c72352@epcas1p3.samsung.com>
 <20210126104001.20361-2-lukasz.luba@arm.com>
 <ea409e2f-f3ca-437f-d787-7ba793a2c226@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <5bd13e13-202f-d059-da29-f82806c33a38@arm.com>
Date:   Wed, 3 Feb 2021 10:21:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ea409e2f-f3ca-437f-d787-7ba793a2c226@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

Thank you for looking at this.

On 2/3/21 10:11 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> When accessing the max_freq and min_freq at devfreq-cooling.c,
> even if can access 'user_max_freq' and 'lock' by using the 'devfreq' instance,
> I think that the direct access of variables (lock/user_max_freq/user_min_freq)
> of struct devfreq are not good.
> 
> Instead, how about using the 'DEVFREQ_TRANSITION_NOTIFIER'
> notification with following changes of 'struct devfreq_freq'?

I like the idea with devfreq notification. I will have to go through the
code to check that possibility.

> Also, need to add codes into devfreq_set_target() for initializing
> 'new_max_freq' and 'new_min_freq' before sending the DEVFREQ_POSTCHANGE
> notification.
> 
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 147a229056d2..d5726592d362 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -207,6 +207,8 @@ struct devfreq {
>   struct devfreq_freqs {
>          unsigned long old;
>          unsigned long new;
> +       unsigned long new_max_freq;
> +       unsigned long new_min_freq;
>   };
> 
> 
> And I think that new 'user_min_freq'/'user_max_freq' are not necessary.
> You can get the current max_freq/min_freq by using the following steps:
> 
> 	get_freq_range(devfreq, &min_freq, &max_freq);
> 	dev_pm_opp_find_freq_floor(pdev, &min_freq);
> 	dev_pm_opp_find_freq_floor(pdev, &max_freq);
> 
> So that you can get the 'max_freq/min_freq' and then
> initialize the 'freqs.new_max_freq and freqs.new_min_freq'
> with them as following:
> 
> in devfreq_set_target()
> 	get_freq_range(devfreq, &min_freq, &max_freq);
> 	dev_pm_opp_find_freq_floor(pdev, &min_freq);
> 	dev_pm_opp_find_freq_floor(pdev, &max_freq);
> 	freqs.new_max_freq = min_freq;
> 	freqs.new_max_freq = max_freq;
> 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);

I will plumb it in and check that option. My concern is that function
get_freq_range() would give me the max_freq value from PM QoS, which
might be my thermal limit - lower that user_max_freq. Then I still
need

I've been playing with PM QoS notifications because I thought it would
be possible to be notified in thermal for all new set values - even from
devfreq sysfs user max_freq write, which has value higher that the
current limit set by thermal governor. Unfortunately PM QoS doesn't
send that information by design. PM QoS also by desing won't allow
me to check first two limits in the plist - which would be thermal
and user sysfs max_freq.

I will experiment with this notifications and share the results.
That you for your comments.

Regards,
Lukasz
