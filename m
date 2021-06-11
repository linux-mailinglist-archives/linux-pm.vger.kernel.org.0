Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B053A4450
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 16:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhFKOsm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 10:48:42 -0400
Received: from foss.arm.com ([217.140.110.172]:60260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231555AbhFKOsl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Jun 2021 10:48:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFD621FB;
        Fri, 11 Jun 2021 07:46:43 -0700 (PDT)
Received: from [10.57.4.16] (unknown [10.57.4.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43B1C3F73D;
        Fri, 11 Jun 2021 07:46:42 -0700 (PDT)
Subject: Re: [PATCH v2] thermal: devfreq_cooling: Fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1623223350-128104-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <bce89c6a-487d-e7b6-86ac-4e946924ec71@arm.com>
Date:   Fri, 11 Jun 2021 15:46:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1623223350-128104-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/9/21 8:22 AM, Yang Li wrote:
> Fix function name in devfreq_cooling.c comment to remove a
> warning found by kernel-doc.
> 
> drivers/thermal/devfreq_cooling.c:479: warning: expecting prototype for
> devfreq_cooling_em_register_power(). Prototype was for
> devfreq_cooling_em_register() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Everything was said regarding these Reviewed-by tags
and you got them in this thread, so should be OK
Thank you Nathan and Nick for explaining this and sorting
out.

Small hint for next time, the Signed-off-by should be at the bottom of
that list.


> ---
> 
> Change in v2:
> --replaced s/clang(make W=1 LLVM=1)/kernel-doc/ in commit.
> https://lore.kernel.org/patchwork/patch/1442639/
> 
>   drivers/thermal/devfreq_cooling.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 3a788ac..5a86cff 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -458,7 +458,7 @@ struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df)
>   EXPORT_SYMBOL_GPL(devfreq_cooling_register);
>   
>   /**
> - * devfreq_cooling_em_register_power() - Register devfreq cooling device with
> + * devfreq_cooling_em_register() - Register devfreq cooling device with
>    *		power information and automatically register Energy Model (EM)
>    * @df:		Pointer to devfreq device.
>    * @dfc_power:	Pointer to devfreq_cooling_power.
> 

Apart from that, the change itself is OK. I forgot about this comment
function name in some iteration... my apologies for that.

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz Luba
