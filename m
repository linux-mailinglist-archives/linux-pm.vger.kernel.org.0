Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B18731587
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jun 2023 12:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbjFOKgr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Jun 2023 06:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343788AbjFOKgl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jun 2023 06:36:41 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97321273D
        for <linux-pm@vger.kernel.org>; Thu, 15 Jun 2023 03:36:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f7ff69824dso4521735e9.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Jun 2023 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686825384; x=1689417384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ux4Hsm2UPQN14ARkeHSB5jZFhCQ3XR9Z6sjWz4tu5SI=;
        b=qSS0C2VCP7JSfeTktk7Z13Uh1UnlPOAQtMtAPsud5JrQOxLNqUiG/SRSYkcWKLJeMJ
         y3SyYnDZGwTFvUhCcasfXxxq8xoRmHI62MiaWUsFZIWhi892fkgarfzwVQ/gOluaeNH6
         F7/+TFuiVUddAuBmS3N7VOcrXLSM0ofYMRaIwlmjbZfZcLCcFQu3RbrpOGfz/JWliV9C
         e68GBTDUAmNrCBVV8Sofr3kpyupebnmNi33nzXxpZcgrcm4rUa21raBJ9GVuB03sqBvP
         pY1H6ZiDIEGBYKLPsDQwObineOXW6LG9wojjHXWUo1m7t6+fzlPBY5z+6md/oFX/eXcQ
         aPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686825384; x=1689417384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ux4Hsm2UPQN14ARkeHSB5jZFhCQ3XR9Z6sjWz4tu5SI=;
        b=BXckcRhbW8Zoh4Udt5QKW9ijHbxIm2gmk8QnORdXZCVjOcK1bf5J94egeldq/gC96O
         OrOdRSvQQEVWy/T19KgYYxXCDxl+ROeN7douQiFi96lLVBu+9dl8YzcrdbglibFtiGCq
         JOUaYB/xbpVZY/BoT8HYQCTWchZbAcY15Dcbgaxhzt++CoNWnV8wPos0bLHRBYTYuupI
         1eMW369fv96iNnPYY03Crr+J+9Q4j2/97nkAXWQ+RVmq/Sf2eiYbaxg3fYBp5PaW/xni
         Z8v3CraujsZIFS2GqsL/xdV0FcYXJa9sm1SGFe8REIMw4BrqyqUZk51zN2qiiskxCfeG
         FbGw==
X-Gm-Message-State: AC+VfDzZ8QwY0LKWOsY4gEdNpWpOoBmZkMdIzGZcZdf/ouakhkm8kLpe
        PTsHutZa96+HenHnehGqS9XSFw==
X-Google-Smtp-Source: ACHHUZ4doGhWT3ThWtXZmRp/fcTy3w15vEMEeftdCD05IwemkGg/FfzUbKyaBUlEnSlDg7km3GlYkw==
X-Received: by 2002:a05:6000:4ea:b0:30f:c420:1743 with SMTP id cr10-20020a05600004ea00b0030fc4201743mr3477555wrb.26.1686825383899;
        Thu, 15 Jun 2023 03:36:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:331d:4ff0:1778:3425? ([2a05:6e02:1041:c10:331d:4ff0:1778:3425])
        by smtp.googlemail.com with ESMTPSA id m9-20020a056000008900b0030ae499da59sm20634460wrx.111.2023.06.15.03.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 03:36:23 -0700 (PDT)
Message-ID: <528cc9e4-f386-b941-f5c5-d3672042731c@linaro.org>
Date:   Thu, 15 Jun 2023 12:36:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
Content-Language: en-US
To:     Peng Fan <peng.fan@oss.nxp.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Peng Fan <peng.fan@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alice Guo <alice.guo@nxp.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <507b5daa-73e7-8d21-4f73-c56f88c6bf77@linaro.org>
 <2e57d14a-214e-c3e0-e011-e804ce8c9b39@oss.nxp.com>
 <4844567.31r3eYUQgx@pliszka>
 <3518a2e7-806d-ad46-a439-ff4a57ed8158@oss.nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3518a2e7-806d-ad46-a439-ff4a57ed8158@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/06/2023 06:04, Peng Fan wrote:
> 
> 
> On 6/15/2023 10:53 AM, Sebastian Krzyszkowiak wrote:
>> Caution: This is an external email. Please take care when clicking 
>> links or opening attachments. When in doubt, report the message using 
>> the 'Report this email' button
>>
>>
>> On czwartek, 15 czerwca 2023 04:29:01 CEST Peng Fan wrote:
>>> On 6/8/2023 3:10 AM, Daniel Lezcano wrote:
>>>>
>>>> [...]
>>>>
>>>> Ok, I misunderstood. I thought that was for failing registered thermal
>>>> zone.
>>>>
>>>> Would enabling the site in ops->change_mode do the trick ?
>>>
>>> No. ops->change_mode not able to do the trick.
>>>
>>> devm_thermal_of_zone_register->thermal_zone_device_enable
>>> ->thermal_zone_device_set_mode->__thermal_zone_device_update.part.0
>>> ->__thermal_zone_get_temp
>>>
>>> The thermal_zone_device_set_mode will call change_mode, if return
>>> fail here, the thermal zone will fail to be registered.
>>>
>>> Thanks,
>>> Peng.
>>
>> I think the idea is not to return a failure in ops->change_mode, but 
>> to move
>> enabling the site in REGS_TMR/REGS_V2_TMSR register from
>> qoriq_tmu_register_tmu_zone to ops->change_mode. 
> 
> But qoriq_tmu_register_tmu_zone will finally call ops->change_mode.
> 
> And it is per zone, so we not able to enable TMR_ME here.
> 
> This way the site will be
>> enabled only for actually existing thermal zones, since those not 
>> described in
>> the device tree won't reach thermal_zone_device_enable.
> 
> No. The TMR_ME is the gate for all sites.

Is it possible to call:

regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF | sites);
regmap_write(qdata->regmap, REGS_V2_TMSR, sites);

in change_mode:

And after the loop:

regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF_V2);

?


> 
> Thanks,
> Peng.
>>
>> S.
>>
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

