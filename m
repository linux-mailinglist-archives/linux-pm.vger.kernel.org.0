Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B032338B8E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 12:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhCLLex (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 06:34:53 -0500
Received: from foss.arm.com ([217.140.110.172]:52346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhCLLek (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Mar 2021 06:34:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35680ED1;
        Fri, 12 Mar 2021 03:34:40 -0800 (PST)
Received: from [10.57.17.106] (unknown [10.57.17.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 553FC3F793;
        Fri, 12 Mar 2021 03:34:38 -0800 (PST)
Subject: Re: [PATCH 3/3] thermal/drivers/cpuidle_cooling: Use device name
 instead of auto-numbering
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, amitk@kernel.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210310114600.27178-1-daniel.lezcano@linaro.org>
 <20210310114600.27178-3-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <71131ec0-a35e-168d-9dcc-19f279758a7f@arm.com>
Date:   Fri, 12 Mar 2021 11:34:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210310114600.27178-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/10/21 11:46 AM, Daniel Lezcano wrote:
> Currently the naming of a cooling device is just a cooling technique
> followed by a number. When there are multiple cooling devices using
> the same technique, it is impossible to clearly identify the related
> device as this one is just a number.
> 
> For instance:
> 
>   thermal-idle-0
>   thermal-idle-1
>   thermal-idle-2
>   thermal-idle-3
>   etc ...
> 
> The 'thermal' prefix is redundant with the subsystem namespace. This
> patch removes the 'thermal prefix and changes the number by the device

missing ' after 'thermal

> name. So the naming above becomes:
> 
>   idle-cpu0
>   idle-cpu1
>   idle-cpu2
>   idle-cpu3
>   etc ...
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/cpuidle_cooling.c | 26 ++++++++++----------------
>   1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
> index 7ecab4b16b29..8bc0a9b46358 100644
> --- a/drivers/thermal/cpuidle_cooling.c
> +++ b/drivers/thermal/cpuidle_cooling.c
> @@ -9,6 +9,7 @@
>   
>   #include <linux/cpu_cooling.h>
>   #include <linux/cpuidle.h>
> +#include <linux/device.h>
>   #include <linux/err.h>
>   #include <linux/idle_inject.h>
>   #include <linux/idr.h>

idr.h not needed any more


other than that LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

