Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658545006F5
	for <lists+linux-pm@lfdr.de>; Thu, 14 Apr 2022 09:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbiDNHhe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Apr 2022 03:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbiDNHhe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2022 03:37:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA521C901
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 00:35:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k22so5713038wrd.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 00:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DNIbEELKcSpMpiph6ypcATO4awYaZfOYo0bLVgeuDKw=;
        b=Dil8VNzay0OnSQ7BZIP3dNRDAru2vo9yoS3Fsff6fLejYTGsaOCULL5xeE6xj4A+V6
         ZEIjxFizbFv7uykfVVMeLSIJ1lUHkwQYQlRk5UGis0pCJGekPR2iFotDJxOuYzWRbwc3
         JTrSf+b2nUTsKz4HpLzwe0P3fT5AApD2wFCtGbaYbKisov5S2xzmhGgLZLyL8ZfFISG9
         i798Yqf2AqnKn35+cuI2SVWsMbUEh6miE2Z+bdLdYswtfhN7IHU0wDS8YWuOhxYPrPMa
         6LMbFQD7o8AD+fKRMMNNpkmuMSQjm9utvl1JmJCA8ctCp92hLxVoE04DDLE/aMWigonS
         iE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DNIbEELKcSpMpiph6ypcATO4awYaZfOYo0bLVgeuDKw=;
        b=1j+Bo/liPhWHKs4M65OgO2ZFLFLl3AB2VIMKQMDCRJv2NB18PDM9KnEhTidGIaOkP0
         XCLAUMxQZJulZ2WWTAsMTeAcjheezg010QuLorXBJLpu8PgzT+plocsfg3vfn+hzxTiP
         ndiy4BB2ntMvzO9HDkWg6zau3nY6mn6jz/uQ9nEeKSwObNlMJCwiTAq8jMvLrRPcjMuz
         5c7drx4bADdXf/OGXug6TeKPny5FawwGEC5frZdn17aDLHNwkQ5I2SpbfldE5FUecyp7
         lukDguiciTECOeISuLLQC36CHQ57aUUlkHDDlUhripi4//BDnAMOWk6uEdpyABB5L9hC
         GbfQ==
X-Gm-Message-State: AOAM5335NuQsNeztvCGdIs9RxOBljzb4x1wtgY4fFyIcaRe/C5uduvmJ
        b0pBByaaQHfD/Pfa5Q4X4DEzZA==
X-Google-Smtp-Source: ABdhPJxfK/Yb5uAPmt1SHXxzzFdfxJCKVXL3/TLTDVww2H3OPiZyLLIZEj/GDbC6Y2MVTH6piH2DAA==
X-Received: by 2002:a05:6000:178c:b0:204:670:5b20 with SMTP id e12-20020a056000178c00b0020406705b20mr1065886wrg.637.1649921708584;
        Thu, 14 Apr 2022 00:35:08 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00207afc4bd39sm1475063wrb.18.2022.04.14.00.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 00:35:08 -0700 (PDT)
Message-ID: <82d08ff0-41bf-d249-1216-0da3f0cdc5b9@linaro.org>
Date:   Thu, 14 Apr 2022 09:35:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] thermal/drivers/thermal_helpers: Adjust output format
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220408110920.3809225-1-alexander.stein@ew.tq-group.com>
 <20220408110920.3809225-2-alexander.stein@ew.tq-group.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220408110920.3809225-2-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/04/2022 13:09, Alexander Stein wrote:
> Outputs like this where -1 is printed as unsigned is somewhat misleading
>   thermal thermal_zone1: Trip3[type=0,temp=48000]:trend=4,throttle=1
>   thermal cooling_device3: cur_state=1
>   thermal cooling_device3: old_target=-1, target=2
>   thermal cooling_device3: zone1->target=1
>   thermal cooling_device3: zone1->target=2
>   thermal cooling_device3: zone1->target=18446744073709551615
>   thermal cooling_device3: set to state 2
> 
> With THERMAL_NO_TARGET assigning -1 as unsigned it make sense to print
> the target as signed integer, even if the type is actually unsigned.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> An alternative would be to change thermal_instance::target from unsigned
> long to long, but this would entail a lot of API & driver changes as well
> which looks less intriguing.
> 
>   drivers/thermal/thermal_helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index 3edd047e144f..0d0da6670267 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -199,7 +199,7 @@ void __thermal_cdev_update(struct thermal_cooling_device *cdev)
>   
>   	/* Make sure cdev enters the deepest cooling state */
>   	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
> -		dev_dbg(&cdev->device, "zone%d->target=%lu\n",
> +		dev_dbg(&cdev->device, "zone%d->target=%ld\n",
>   			instance->tz->id, instance->target);
>   		if (instance->target == THERMAL_NO_TARGET)
>   			continue;

Actually you pointed out something fuzzy in the target values.

The unsigned long type for the target and THERMAL_NO_TARGET are not 
compatible.

It would be much simpler to have THERMAL_NO_TARGET = 0 which 
semantically makes more sense than a negative value.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
