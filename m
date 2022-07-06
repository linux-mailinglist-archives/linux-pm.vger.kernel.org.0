Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2F95687C9
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 14:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiGFMHi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 08:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiGFMHh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 08:07:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D91229812
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 05:07:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a5so7072319wrx.12
        for <linux-pm@vger.kernel.org>; Wed, 06 Jul 2022 05:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B0kLxzZFv1hjl2nfhxxmYfuW3/1xWKZfd4iRfJyADCA=;
        b=W4IpqFitVi7E1RKJJKjdCax2gbQUOSIMcqHImgpXMYXAxoug6Gf4whNjyLVu+PKC+3
         obCDaRjukdn6IY0Th84IIXc+vshNdThJf1Ku0BDZwofL15LqCUTtvoJhc11wkSxhhtZG
         V+6ShElpcYoVMzipYpKj4nA2DEtiIH44vzwO/pA8g3QKh/d2SkDqY3IjRa/aKh7Lu3PQ
         tdRmQCl7HSMRgJ3aEhUfxtrgk1VZaFkQLg1mEp2KN3H412u8Dl7ydaJQDOVY8DO0ceIn
         Xp37cUOUP42djBwMv2zcjHoJz/NgpADCnCp5mmA/YVcLCp+IdqoU8dragn4CzaLrmXb5
         O5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B0kLxzZFv1hjl2nfhxxmYfuW3/1xWKZfd4iRfJyADCA=;
        b=5IlD43Tdlo29EXO9nnsRJVyZz7Ed9xRwDufUdzFNKLyw/fgdV0CDuWPvHn2tb96pbr
         zhjhDQ8ZyOyYpxQOHg+5ELd73cMvZqNGpflsha0pnyoRJs/CtPXlYGumwWxcb/uHlHEM
         MctBtUaOQlwplq81aSWt74q/s6KCiwVbPWxq5v01xqonkM5ko3v2oR89V0zugUxZQLcA
         c5O4P5RffNt+EQ88LZyTR5k+WznYsHu6oJULR3tz9+YcxJOXWCsfBD4NEqlkeSm+oPG+
         rYratpyST/XmbwdE/Fduui8KxAiZ7pD+n77mbWiX5TXec3PW8hawokdxmXSaCiWPzFaW
         2eTA==
X-Gm-Message-State: AJIora9pXUTaPKnitVv0ksjlWoofshDbH5nmvcCRouw/L5jxN4eMqR5x
        BIsJ9Az2zy7+SN+9wmL1zddDWw==
X-Google-Smtp-Source: AGRyM1swvtQyKZX/OMeE3u9Y360rVt9bNVOwb7jRaTSA9O8jTAiIlYIpfhsAwKqK1MXxRmd06BiYxA==
X-Received: by 2002:a05:6000:1849:b0:21b:95c7:bbca with SMTP id c9-20020a056000184900b0021b95c7bbcamr35997989wri.93.1657109254705;
        Wed, 06 Jul 2022 05:07:34 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id i1-20020adffc01000000b0021b5861eaf7sm36216018wrr.3.2022.07.06.05.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 05:07:34 -0700 (PDT)
Message-ID: <92c86903-354f-0114-a796-64571667a923@linaro.org>
Date:   Wed, 6 Jul 2022 14:07:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] thermal/core: Use clamp() helper in the stepwise
 governor
Content-Language: en-US
To:     rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20220629151012.3115773-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220629151012.3115773-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/06/2022 17:10, Daniel Lezcano wrote:
> The code is actually clampling the next cooling device state using the
> lowest and highest states of the thermal instance.
> 
> That code can be replaced by the clamp() macro which does exactly the
> same. It results in a simpler routine to read.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

I'll apply this series if nobody has comments


>   drivers/thermal/gov_step_wise.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
> index 12acb12aac50..6efbfaf014da 100644
> --- a/drivers/thermal/gov_step_wise.c
> +++ b/drivers/thermal/gov_step_wise.c
> @@ -11,6 +11,7 @@
>    */
>   
>   #include <linux/thermal.h>
> +#include <linux/minmax.h>
>   #include <trace/events/thermal.h>
>   
>   #include "thermal_core.h"
> @@ -52,10 +53,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
>   
>   	if (!instance->initialized) {
>   		if (throttle) {
> -			next_target = (cur_state + 1) >= instance->upper ?
> -					instance->upper :
> -					((cur_state + 1) < instance->lower ?
> -					instance->lower : (cur_state + 1));
> +			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
>   		} else {
>   			next_target = THERMAL_NO_TARGET;
>   		}
> @@ -66,10 +64,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
>   	switch (trend) {
>   	case THERMAL_TREND_RAISING:
>   		if (throttle) {
> -			next_target = cur_state < instance->upper ?
> -				    (cur_state + 1) : instance->upper;
> -			if (next_target < instance->lower)
> -				next_target = instance->lower;
> +			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
>   		}
>   		break;
>   	case THERMAL_TREND_RAISE_FULL:
> @@ -82,9 +77,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
>   				next_target = THERMAL_NO_TARGET;
>   		} else {
>   			if (!throttle) {
> -				next_target = cur_state - 1;
> -				if (next_target > instance->upper)
> -					next_target = instance->upper;
> +				next_target = clamp((cur_state - 1), instance->lower, instance->upper);
>   			}
>   		}
>   		break;


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
