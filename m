Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BDC67B0F0
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 12:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbjAYLQo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 06:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbjAYLQN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 06:16:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853AB58297
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 03:15:59 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so979414wmb.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 03:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mB64iuBa8pKznC6MUcQfOEwFniluU0ciUXbkSKaGwA=;
        b=QYyLw1kTeP5So/QCN7Ua5W5M/XYvoAVts5afkWdLSEsJeS2p4s7GS3DzhX8hjPtJ/G
         J77k2oSJ1pQLAJimQGKBbeK3CSsgRZKgOwrktkNsl7+RVNuDkHD4fF6IMXdslzwwo3qb
         XyPCigtWQtyF7V+CP91YP348VKF+cesLAwqnQVIlyFnKeXrTKQksi2nz3lreZ6suF+Lq
         1owtQiUR6Iy9fUWMIwqQo+aG7BEseV6NeIp/TLKSjuanWDhSVNAsIiROZpxPvXwa/Jus
         bz5520A1Kg2nanjqeHmOIvx/dt5/CbESmzRKiU1drHrSipDsRoSMPEuEBmATh7dqjKd8
         yLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mB64iuBa8pKznC6MUcQfOEwFniluU0ciUXbkSKaGwA=;
        b=lvJLCiXQrqPgGAFhTuv3EdvEo7Fn2G+RJWTrr+fHkL1P7eObJdcajzrIMTDcjWG2OT
         LOV7oFxVVTM8SfJqgsTnjzbI7QAc2tnee7DU25XpO8E1C5hqQJmRaZVqrKCpSRPLLZ6e
         MVX+4LOVQWia6mJS5XBwXQI80Ak92735xxOaM0EUXav8oRt0Fb24VrBVUemhbaCCboCz
         Lgz9wrQT8neWZj7L/3WGtRO7tIIEUSd7B3q6rq9Oq6pPMIMmYVJFJzZu5NAPUDPcnzZ1
         7KrcmI/6CnG+ERNH0qY7cLDRAV2S8J3KC0GSdqiZBal/NAJZkALEx/wViGvPOEUlBHX7
         V3qQ==
X-Gm-Message-State: AFqh2koXWBRwMbXFfYz58JfaLc3trbyB29P2CwpQCG01YZ0o98Dis2SG
        53hLPabxFq6IZLKJiCX5sRh9rA==
X-Google-Smtp-Source: AMrXdXvFrzG/q8e4eRt/EbNavYLKHtg2DXIzG87RROwBG5FJ19KMFtyhSRwXX6q7SnswJ1I/PY+XcQ==
X-Received: by 2002:a05:600c:1695:b0:3da:f502:83b5 with SMTP id k21-20020a05600c169500b003daf50283b5mr31575274wmn.2.1674645357913;
        Wed, 25 Jan 2023 03:15:57 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id h20-20020a05600c351400b003dc1300eab0sm1710936wmq.33.2023.01.25.03.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:15:57 -0800 (PST)
Message-ID: <3e2c6c44-f562-28ff-26cc-933f386e9719@linaro.org>
Date:   Wed, 25 Jan 2023 12:15:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/3] Misc thermal cleanup and fixes
Content-Language: en-US
To:     rui.zhang@intel.com, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230123152756.4031574-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230123152756.4031574-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael,

will you take this series on your branch ?


On 23/01/2023 16:27, Daniel Lezcano wrote:
> This series is based on linux-pm/thermal
> 
> It unregisters the netlink generic family for thermal in case the thermal
> framework fails to initialize, removes a unneeded ida_destroy() call and moves
> the thermal trip code in a separate file.
> 
> A couple of changes have been removed from the previous version:
> 
>   - Ordering the trip points. Some consolidation is needed in the set_trip_temp
>     ops before ordering the trip points, so this change is postpone
> 
>   - Remove the mutex destroy call. Even if the call is not needed, the
>     justification of the change is not accurate. So it is postponed also.
> 
>   V2:
>     - Removed ordering the trip points change
>     - Removed mutex destroy change
>     - Added "No functional change intented" as requested by Rui
>     - Added the function declaration for_each_thermal_trip
> 
> Daniel Lezcano (3):
>    thermal/core: Fix unregistering netlink at thermal init time
>    thermal/core: Remove unneeded ida_destroy()
>    thermal/core: Move the thermal trip code to a dedicated file
> 
>   drivers/thermal/Makefile          |   4 +-
>   drivers/thermal/thermal_core.c    |  93 +--------------
>   drivers/thermal/thermal_core.h    |   4 +
>   drivers/thermal/thermal_helpers.c |  62 ----------
>   drivers/thermal/thermal_netlink.c |   5 +
>   drivers/thermal/thermal_netlink.h |   3 +
>   drivers/thermal/thermal_trip.c    | 182 ++++++++++++++++++++++++++++++
>   7 files changed, 199 insertions(+), 154 deletions(-)
>   create mode 100644 drivers/thermal/thermal_trip.c
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

