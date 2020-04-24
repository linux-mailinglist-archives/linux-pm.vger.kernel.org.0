Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0B1B70B7
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 11:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgDXJWM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 05:22:12 -0400
Received: from foss.arm.com ([217.140.110.172]:58060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgDXJWM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Apr 2020 05:22:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEBB81FB;
        Fri, 24 Apr 2020 02:22:11 -0700 (PDT)
Received: from [10.37.12.92] (unknown [10.37.12.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A5703F73D;
        Fri, 24 Apr 2020 02:22:06 -0700 (PDT)
Subject: Re: [PATCH] thermal: power_allocate: add upper and lower limits
To:     Michael Kao <michael.kao@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200424071601.2636-1-michael.kao@mediatek.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <accb83e0-ffbe-b6e3-6bf9-e7cc8b9fe19c@arm.com>
Date:   Fri, 24 Apr 2020 10:22:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200424071601.2636-1-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Michael,

On 4/24/20 8:16 AM, Michael Kao wrote:
> The upper and lower limits of thermal throttle state in the
> device tree do not apply to the power_allocate governor.
> Add the upper and lower limits to the power_allocate governor.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>   drivers/thermal/thermal_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9a321dc548c8..f6feed2265bd 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -598,7 +598,7 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
>   	if (ret)
>   		return ret;
>   
> -	instance->target = state;
> +	instance->target = clamp_val(state, instance->lower, instance->upper);
>   	mutex_lock(&cdev->lock);
>   	cdev->updated = false;
>   	mutex_unlock(&cdev->lock);
> 

Thank you for the patch and having to look at it. I have some concerns
with this approach. Let's analyze it further.

In default the cooling devices in the thermal zone which is used by IPA
do not have this 'lower' and 'upper' limits. They are set to
THERMAL_NO_LIMIT in DT to give full control to IPA over the states.

This the function 'power_actor_set_power' actually translates granted
power to the state that device will run for the next period.
The IPA algorithm has already split the power budget.
Now what happen when the 'lower' value will change the state to a state
which consumes more power than was calculated in the IPA alg... It will
became unstable.

I would rather see a change which uses these 'lower' and 'upper' limits
before the IPA do the calculation of the power budget. But this wasn't
a requirement and we assumed that IPA has full control over the cooling
device (which I described above with this DT THERMAL_NO_LIMIT).

Is there a problem with your platform that it has to provide some
minimal performance, so you tried to introduce this clamping?

Regards,
Lukasz
