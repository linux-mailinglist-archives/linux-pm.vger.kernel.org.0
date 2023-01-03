Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE165BA25
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 05:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbjACE5u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Jan 2023 23:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjACE5s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2023 23:57:48 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7D5B7EA
        for <linux-pm@vger.kernel.org>; Mon,  2 Jan 2023 20:57:47 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j17so34689603lfr.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Jan 2023 20:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMLK9393vsk45KoAAuQX7xoCHqdhg1Mb1LXZfDbbblo=;
        b=fA/eTJo0OdeTBAQCzHnEQWLk8K5MK+rM0nSsQVxxIhRMQRMKRnYyvPmi5BijFhZLMt
         7WHjRDRtmv7i1HRB3RYJpUjwHQg9leb/3fDfI/yiHqkS5r8zinKYdgOvWFO79vqS4qz3
         AysauDzdq3rGBlzvx+WcR+vyFW4nV2HtwF5ZbtglX+QxqhmoTlKZl9AwmzvlY2lAX4fj
         +/ylykCpVwzpUl8875NV38yOQZaZWnnJw6IVqNhz50/eVQQ08hidTrFL3znONWIqJOGV
         qvTbxF+vHo2wt1IOsoZJJrblCwj1Rmuj2jd0nfAkmto7F8rirI9E9T0OIhQ+ob4Yu92y
         yw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMLK9393vsk45KoAAuQX7xoCHqdhg1Mb1LXZfDbbblo=;
        b=HIlGIDdomJc7vValbF8JaVwD6md7z2Wq+SHyg106uFxBDths46Pd/C/fcktS5J6MHy
         M8kvXiBwZQvtb4Twj8+MfU+QS2fVvavGG076Pq59hkR2eNDDH9cBIwgd+WuWiY9ROM5Z
         a+WeJpfaUtklV1mPBO8m82VuYybqryIFPgnvXJlNcKKpfn6C33fPR5wlNRIUolUJaSmZ
         qve8wjmUUso5sIjPSPvOFwTOhfFI3J75z16Z+bQs7n0LvocVAzDdk27YZNrzgNTZ6OQJ
         gvuFbqT7sSuE+4FkG1h27LmNxOnp+dTgCAr2E25w45PTBFEUdHyiRGztPZVAJWO0ISQ/
         Nvmw==
X-Gm-Message-State: AFqh2kqXmqTHMIWfoTH7nJ8PRs+1AIlfc5QkQg8OJbnvgSDHGd0LVqxs
        ilyeFQizh4CC20jiMBZUk8m6qw==
X-Google-Smtp-Source: AMrXdXsL85tdAisf1j3SvFD/c9oTbrZZ+YN1oUn99uDGhGY39XhQzCpiOS5q8lSn3DcY/QTwhyZ/rg==
X-Received: by 2002:a05:6512:131d:b0:4cb:c3:9363 with SMTP id x29-20020a056512131d00b004cb00c39363mr9950107lfu.11.1672721866767;
        Mon, 02 Jan 2023 20:57:46 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x2-20020a0565123f8200b004b590b0c084sm4644874lfa.3.2023.01.02.20.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 20:57:46 -0800 (PST)
Message-ID: <7c20ec09-a8a4-b7cb-2763-2bf187b762a9@linaro.org>
Date:   Tue, 3 Jan 2023 06:57:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] interconnect: qcom: osm-l3: drop unuserd header inclusion
Content-Language: en-GB
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230103031159.1060075-1-dmitry.baryshkov@linaro.org>
 <20230103033353.u3gzssofbmxlmn7o@builder.lan>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230103033353.u3gzssofbmxlmn7o@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/01/2023 05:33, Bjorn Andersson wrote:
> On Tue, Jan 03, 2023 at 05:11:59AM +0200, Dmitry Baryshkov wrote:
>> The commit 4529992c9474 ("interconnect: qcom: osm-l3: Use
>> platform-independent node ids") made osm-l3 driver use
>> platform-independent IDs, removing the need to include platform headers.
>>
>> Fixes: 4529992c9474 ("interconnect: qcom: osm-l3: Use platform-independent node ids")
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/interconnect/qcom/osm-l3.c | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
>> index 5fa171087425..0c907765783e 100644
>> --- a/drivers/interconnect/qcom/osm-l3.c
>> +++ b/drivers/interconnect/qcom/osm-l3.c
>> @@ -14,13 +14,6 @@
>>   
>>   #include <dt-bindings/interconnect/qcom,osm-l3.h>
>>   
>> -#include "sc7180.h"
>> -#include "sc7280.h"
>> -#include "sc8180x.h"
>> -#include "sdm845.h"
>> -#include "sm8150.h"
>> -#include "sm8250.h"
>> -
> 
> Thanks for cleaning this up Dmitry. The <platform>_MASTER_OSM_L3_APPS
> and <platform>_SLAVE_OSM_L3 in these header files could also be removed,
> if you would like.

Nice suggestion, thank you. I've send a separate patch.

> 
> Either way, you have my:
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> Regards,
> Bjorn
> 
>>   #define LUT_MAX_ENTRIES			40U
>>   #define LUT_SRC				GENMASK(31, 30)
>>   #define LUT_L_VAL			GENMASK(7, 0)
>> -- 
>> 2.39.0
>>

-- 
With best wishes
Dmitry

