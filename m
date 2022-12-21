Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E4E6535F7
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 19:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiLUSP1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Dec 2022 13:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiLUSPU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Dec 2022 13:15:20 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D960E2632
        for <linux-pm@vger.kernel.org>; Wed, 21 Dec 2022 10:15:17 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 131-20020a1c0289000000b003d35acb0f9fso2180211wmc.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Dec 2022 10:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBS1G+Ita4G929ENYss4FupQVr8PNYuu/yNZFI3eijc=;
        b=hdDGTEJQqlMjXUX0NXVjJ+Uk4nnSMYBt9yC8aKmfLGb1X3D0NSV4gvgpg9vc9DCTW+
         dyKln5/Nfa0siaIQz78UqC2xdnZjqCYU1lYS9/aOsDSGC3fzQ616SR6pq26iBgUKYXav
         Hwny5tphwtbHshfXnjWQD1GMAplWg7zR3y0km5bgu5zQp+sHVlEA0SPpn80iC2Ch7pop
         KgzsnaxNFCuKZZtO8FgULgLUycLerz6ULBDqaa9HfkruchjbdicuY13bu5hl/qKMuXeY
         n3AU4YQ0x+LMpSfgNQSVcDM1ciDIjoSKewuCG4EFlyqWyngWCUDSxpWbtqLILpnkabCy
         XO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBS1G+Ita4G929ENYss4FupQVr8PNYuu/yNZFI3eijc=;
        b=A6mlJlJXXE+mKl817DnBJwhXK7iFXeQ2WMwkgoeJYAuin59v/wOloD4EWT4X/JfrS8
         Jrs86G5I03hkFMbERan0WvQ/7nBcBjnVrlteYU1owKfF8zPUULFLKXR6cFZe0mLA42zK
         H71yXbSTF8BX4UiHqqjQHFyTo7cZ1nOE9pTcBhZZagDHyX7bHydZ1jUCNlmX5FTi7QkJ
         4Covki1AfZCkMB1ZUv4F1KRkrN93RNadD0C7EHWwplZGgVzU0G4ehfBAvsXlENq/PVzJ
         zD+9Rg+CwHlqiH/2Gs0vLH0w9BZ+dtas3FHMQEiYQUzx6aBUeGrPZpXIvlR5hRG2K99U
         54bA==
X-Gm-Message-State: AFqh2kpmby58d/ITRMMCJkmmw+j2oPU6YHS2xFkOjG9o3bUIngSu5C9B
        +aSOX8ifuDbv6lKFmyjBL8boWg==
X-Google-Smtp-Source: AMrXdXvi+NL+FPbFGJS5YThwele+DtKAiYutWQPqtLwihoLRpWeam3z85IyCCwqjvMvqsAd5j6ZK/A==
X-Received: by 2002:a05:600c:a51:b0:3d3:513c:240b with SMTP id c17-20020a05600c0a5100b003d3513c240bmr2329408wmq.7.1671646516410;
        Wed, 21 Dec 2022 10:15:16 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m16-20020a05600c3b1000b003c5571c27a1sm4706163wms.32.2022.12.21.10.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 10:15:15 -0800 (PST)
Message-ID: <7157562c-e0f0-b68f-5351-9f332153eb17@linaro.org>
Date:   Wed, 21 Dec 2022 19:15:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 07/20] thermal/drivers/tsens: limit num_sensors to 9
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
 <20221221020520.1326964-8-dmitry.baryshkov@linaro.org>
 <ed4aafb9-c33e-6f24-1e9c-7c7efa0e58ae@linaro.org>
 <fa89bec4-0f44-74a5-4905-c1e03ad52749@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <fa89bec4-0f44-74a5-4905-c1e03ad52749@linaro.org>
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

On 21/12/2022 19:05, Dmitry Baryshkov wrote:
> On 21/12/2022 17:45, Daniel Lezcano wrote:
>> On 21/12/2022 03:05, Dmitry Baryshkov wrote:
>>> According to the vendor kernels (msm-3.10, 3.14 and 3.18), msm8939
>>> supports only 9 sensors. Remove the rogue sensor's hw_id.
>>>
>>> Fixes: 332bc8ebab2c ("thermal: qcom: tsens-v0_1: Add support for 
>>> MSM8939")
>>> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>   drivers/thermal/qcom/tsens-v0_1.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/qcom/tsens-v0_1.c 
>>> b/drivers/thermal/qcom/tsens-v0_1.c
>>> index 0bc4e5cec184..57ac23f9d9b7 100644
>>> --- a/drivers/thermal/qcom/tsens-v0_1.c
>>> +++ b/drivers/thermal/qcom/tsens-v0_1.c
>>> @@ -605,9 +605,9 @@ static const struct tsens_ops ops_8939 = {
>>>   };
>>>   struct tsens_plat_data data_8939 = {
>>> -    .num_sensors    = 10,
>>> +    .num_sensors    = 9,
>>>       .ops        = &ops_8939,
>>> -    .hw_ids        = (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9, 
>>> 10 },
>>> +    .hw_ids        = (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9 },
>>
>> Does not patch 4 says we can drop those hw_ids ?
> 
> No. In patch 4 we drop contiguous IDs. For the msm8939 sensor 4 is 
> omitted from hw_ids, so we can not drop the array.

Ah, yes, indeed.

  .num_sensor = ARRAY_SIZE(data_8939.hw_ids); should work

If the hw_ids are ordered, you may consider a bitmask instead of an array

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

