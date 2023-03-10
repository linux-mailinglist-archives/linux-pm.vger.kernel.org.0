Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B906B44E0
	for <lists+linux-pm@lfdr.de>; Fri, 10 Mar 2023 15:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjCJO32 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Mar 2023 09:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjCJO3F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 09:29:05 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB9011D0B2
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 06:27:17 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id a32so5457822ljr.9
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 06:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678458435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JsV0Gbi3hH0/L9MS5rWIc0K18letEMd3yLRh1mvfzak=;
        b=XN3WHynKo4hUaUzsfYWIYY30MDe805y50G8WB/PFSjPwfwtg31R7Vii2GjEvvGiYTd
         dbSTqyx0Jc+jGgHbh+SpH4mVyJZMQTWK5BpjTItw5OHmGmazPPKtkZN77T8klOVHgwlj
         BGSKvyt5l+ztHiIrIUXn04dOy/sFOz+DwawLsVZ/dW2kakKwlBP1pP5jRh9m0WF089Iu
         gkVhBfwk4HpQilpn0GoA5nv3CJqraBEhyy1gXzgE5199L6Kiq8gHq76ZkPgdc4Va5tz3
         hlDYc7MsDp7k2Ruhxkh6wAHtCtflqwrUbiMI8UqQtYno9beia9I/TPQiDuVG8esDzmkI
         b6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678458435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsV0Gbi3hH0/L9MS5rWIc0K18letEMd3yLRh1mvfzak=;
        b=U2+R1VJi4MeKoTOtXQzSD0wKsLagjYgkckCGLt4x34DuvrTCQqJZpsNjHI2bC0i7mv
         2DS+ul59oVmDvhy1vTQTXy9fAAqWu2CE9aNuFblQGORHMEDxlLLLJ9VEN3hR8fCh5NXM
         4qcPZY85cRVusOMAbb1s2lOrgcQ7l8zTgtq6RRkMWaRCgScdU5xeHRI+KwnF1pjlHJjY
         ItBmS4AZXRc4cpqSE6WdR8hfqt1bP58i0hFjuJJt2sA3kFjLoptVQBSkgRIb6k0ZF+J2
         MjiKzqRIVSpSnKfDa9L6kHIyDRMTlTMLOPeAyaDPZqEcUrCIpSFCi8Qcx1hW2XIUeSiS
         2FoA==
X-Gm-Message-State: AO0yUKXLzJ4x9/ZPbSL5CLD7jLBn9BbX4BvtG+19nmMtV/N7hwTIPw/j
        3vu/7kULjUuSzkBQMhR96vX4UQ==
X-Google-Smtp-Source: AK7set9lxH6/PbMSlHI3/Xj1zSeTgyrFqDwLAkdtZ9Wm/3ENkW4eYm3dUmfPKJZl9u0iGTt993gxtg==
X-Received: by 2002:a2e:9b4f:0:b0:293:2e81:45d3 with SMTP id o15-20020a2e9b4f000000b002932e8145d3mr7817308ljj.5.1678458435734;
        Fri, 10 Mar 2023 06:27:15 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w2-20020a2e9982000000b0029347612e94sm22367lji.123.2023.03.10.06.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 06:27:15 -0800 (PST)
Message-ID: <5be0f6e1-8c96-2a24-e1aa-8b9975988e2a@linaro.org>
Date:   Fri, 10 Mar 2023 15:27:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 9/9] interconnect: qcom: msm8996: Promote to
 core_initcall
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-9-815606092fff@linaro.org>
 <937279a0-2e62-7061-3752-dfb94ee6d1f6@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <937279a0-2e62-7061-3752-dfb94ee6d1f6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10.03.2023 15:23, Bryan O'Donoghue wrote:
> On 08/03/2023 21:40, Konrad Dybcio wrote:
>> The interconnect driver is (or soon will be) vital to many other
>> devices, as it's not a given that the bootloader will set up enough
>> bandwidth for us or that the values we come into are reasonable.
>>
>> Promote the driver to core_initcall to ensure the consumers (i.e.
>> most "meaningful" parts of the SoC) can probe without deferrals.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/msm8996.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
>> index 347fe59ec293..1eb51ed18b0b 100644
>> --- a/drivers/interconnect/qcom/msm8996.c
>> +++ b/drivers/interconnect/qcom/msm8996.c
>> @@ -2109,7 +2109,17 @@ static struct platform_driver qnoc_driver = {
>>           .sync_state = icc_sync_state,
>>       }
>>   };
>> -module_platform_driver(qnoc_driver);
>> +static int __init qnoc_driver_init(void)
>> +{
>> +    return platform_driver_register(&qnoc_driver);
>> +}
>> +core_initcall(qnoc_driver_init);
>> +
>> +static void __exit qnoc_driver_exit(void)
>> +{
>> +    platform_driver_unregister(&qnoc_driver);
>> +}
>> +module_exit(qnoc_driver_exit);
>>     MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
>>   MODULE_DESCRIPTION("Qualcomm MSM8996 NoC driver");
>>
> 
> Its probably the right-thing-to-do to have interconnects probe earlier but, then, why restrict that to 8996 only ?
To be honest with you, this one caught my attention and it was the
one I tested things on.. But yeah, they should all be probing ASAP.

Konrad
> 
> ---
> bod
