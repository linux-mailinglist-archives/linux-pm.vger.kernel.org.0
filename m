Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304BD285DA8
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 12:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgJGKza (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 06:55:30 -0400
Received: from foss.arm.com ([217.140.110.172]:41842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgJGKza (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Oct 2020 06:55:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B9A411B3;
        Wed,  7 Oct 2020 03:55:29 -0700 (PDT)
Received: from [10.57.52.96] (unknown [10.57.52.96])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0795F3F71F;
        Wed,  7 Oct 2020 03:55:19 -0700 (PDT)
Subject: Re: [PATCH] [v2] thermal: core: add upper and lower limits to
 power_actor_set_power
To:     Michael Kao <michael.kao@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201007024332.30322-1-michael.kao@mediatek.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <9ecedd8a-fbc3-895c-d79c-f05af5c90ae5@arm.com>
Date:   Wed, 7 Oct 2020 11:55:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201007024332.30322-1-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 10/7/20 3:43 AM, Michael Kao wrote:
> The upper and lower limits of thermal throttle state in the
> DT do not apply to the Intelligent Power Allocation (IPA) governor.
> Add the clamping for cooling device upper and lower limits in the
> power_actor_set_power() used by IPA.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>   drivers/thermal/thermal_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 72bf159bcecc..a260e4a575f3 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -674,7 +674,7 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
>   	if (ret)
>   		return ret;
>   
> -	instance->target = state;
> +	instance->target = clamp_val(state, instance->lower, instance->upper);
>   	mutex_lock(&cdev->lock);
>   	cdev->updated = false;
>   	mutex_unlock(&cdev->lock);
> 

Please check the patch with scripts/checkpatch.pl before sending.
It's again base64 encoded, I was able to apply it on my end with
--ignore-whitespace, but still some odd char is there.

If Daniel is OK to fix it when applying to the thermal branch, then:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

I would send a few patches on top of this one, to fully support the
upper and lower limits in IPA.

Regards,
Lukasz
