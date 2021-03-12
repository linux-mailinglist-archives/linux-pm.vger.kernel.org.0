Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A68A338AD0
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 11:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhCLK6g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 05:58:36 -0500
Received: from foss.arm.com ([217.140.110.172]:51610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233939AbhCLK6W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Mar 2021 05:58:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D072DED1;
        Fri, 12 Mar 2021 02:58:21 -0800 (PST)
Received: from [10.57.17.106] (unknown [10.57.17.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F00BE3F793;
        Fri, 12 Mar 2021 02:58:19 -0800 (PST)
Subject: Re: [PATCH 1/3] thermal/drivers/cpufreq_cooling: Use device name
 instead of auto-numbering
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, amitk@kernel.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210310114600.27178-1-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <452c1619-fcda-d006-721a-d471389aa90a@arm.com>
Date:   Fri, 12 Mar 2021 10:58:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210310114600.27178-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Only minor comments.

On 3/10/21 11:45 AM, Daniel Lezcano wrote:
> Currently the naming of a cooling device is just a cooling technique
> followed by a number. When there are multiple cooling devices using
> the same technique, it is impossible to clearly identify the related
> device as this one is just a number.
> 
> For instance:
> 
>   thermal-cpufreq-0
>   thermal-cpufreq-1
>   etc ...
> 
> The 'thermal' prefix is redundant with the subsystem namespace. This
> patch removes the 'thermal prefix and changes the number by the device

missing ', after 'thermal

> name. So the naming above becomes:
> 
>   cpufreq-cpu0
>   cpufreq-cpu4
>   etc ...
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/cpufreq_cooling.c | 28 +++++++---------------------
>   1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index 10af3341e5ea..cf0332bbdcd3 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -13,6 +13,7 @@
>   #include <linux/cpu.h>
>   #include <linux/cpufreq.h>
>   #include <linux/cpu_cooling.h>
> +#include <linux/device.h>
>   #include <linux/energy_model.h>
>   #include <linux/err.h>
>   #include <linux/export.h>

You can now also remove the header:
#include <linux/idr.h>


other than that, LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
