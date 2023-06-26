Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEBD73E5AC
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 18:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjFZQrU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjFZQrP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 12:47:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED001B1
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 09:47:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso1938249e87.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687798032; x=1690390032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJHRCqbPQl3JXucRV3xxhvcZkkYuFqIldcmWxCebc90=;
        b=MoJKCGuIm1R9wp/YsJ8kR6VDcvEsqk91+YIBYg6vwBD56U6MmXtWdprFSqSmAXQqB9
         FX/FvU/DFBxvl8//Ar+p934THx2BPt/grS+J5ZZbINCSWweJfRhR1Hq6LinfcY2alkFs
         rLRJLEtyVmV1RE2lNYbc4tU0qBjLEriPle4vuDC8TZSHqcskQEM1kyh/10h5AYjci3uy
         1DP2yxZiuBNJyDaaOt2eIn81pGX6uFCcOrhXK29MVIvOSYesCQ0LUP+royE6VRoUKZJi
         jYEfe/LogE8LAoJmKEWfdj/jX6FGvwzI2+kvM4cmJn2tJgZnGKVz4OK+Qe+jTPwMeyQc
         dxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687798032; x=1690390032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJHRCqbPQl3JXucRV3xxhvcZkkYuFqIldcmWxCebc90=;
        b=RrBT/wrPwbwE9SWVFdTqOGznNOIrVl3utG4EB+KB84cfJo4Xbh2vYvIocrRbLVQob/
         obDlYg+bi9Mw+cg4cJpgMjdmWp8whYWfF/bHRsgtwXienG78fQ/J0XtsX0k5zGf/sLRh
         4wbWor621fJL6VGnHBSdowwaU3PXfmUd25tFVuIX5jNIeqdPcHMDZCBDzJ1DDABNV8dw
         IcQ1EjjezC+LuLEW8xC78QWzJzrp2LA11i96Zmf1VskZAIw8zo5sXLQ7KafxbNch+fBt
         z/Tk60wqG7v0c6nw2Kr8xaMZwedbyv3hXuNMLAMx3b8aA/UWi19cwqAIFqBSMi6/Ax4K
         +d7Q==
X-Gm-Message-State: AC+VfDzYi1TnJhrImW+xubcFE8P8By/sGlpEfHMEZ/BUbucm0YQuwGn2
        sWemGJKlCjZhyzU9BhiT9BgO7A==
X-Google-Smtp-Source: ACHHUZ57sFI0hqUuY6mKNExqPzLRhumqKwnyqMeR14dftScyrbGTcK3poygc/sfyxNkxDOhzLApa/A==
X-Received: by 2002:a05:6512:3d16:b0:4f8:7325:bcd4 with SMTP id d22-20020a0565123d1600b004f87325bcd4mr3493071lfv.0.1687798032700;
        Mon, 26 Jun 2023 09:47:12 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id t24-20020ac243b8000000b004f625831d85sm1177503lfl.126.2023.06.26.09.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 09:47:12 -0700 (PDT)
Message-ID: <4eaecc96-2d54-f6f2-8034-0c83ea1d1504@linaro.org>
Date:   Mon, 26 Jun 2023 18:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 06/26] interconnect: icc-clk: add support for scaling
 using OPP
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-7-dmitry.baryshkov@linaro.org>
 <b5ff346b-cbde-68fe-a08a-3b3331439309@linaro.org>
 <d9e4fd75-310a-7fe8-879e-651011873199@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <d9e4fd75-310a-7fe8-879e-651011873199@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26.06.2023 15:44, Dmitry Baryshkov wrote:
> On 26/06/2023 14:28, Konrad Dybcio wrote:
>> On 25.06.2023 22:25, Dmitry Baryshkov wrote:
>>> Sometimes it might be required to scale the clock using the OPP
>>> framework (e.g. to scale regulators following the required clock rate).
>>> Extend the interconnec
>> 't'
>>
>>> -clk framework to handle OPP case in addition to
>>> scaling the clock.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>> I think we should check for OPP at the icc-clk registration time,
>> instead of passing it as a parameter, e.g.:
>>
>> qn.opp = IS_ERR(dev_pm_opp_get_opp_count)
>>
>> Not sure if there's a more idiomatic way.
> 
> No. icc-clk is not limited to a single clock->icc conversion. So it is possible to create several interconnect links, only one of which should be the OPP-based one.
Ugh. Right.

Konrad
> 
>>
>> Konrad
>>>   drivers/interconnect/icc-clk.c   | 13 +++++++++++--
>>>   include/linux/interconnect-clk.h |  1 +
>>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
>>> index 4d43ebff4257..c7962acdcee7 100644
>>> --- a/drivers/interconnect/icc-clk.c
>>> +++ b/drivers/interconnect/icc-clk.c
>>> @@ -7,10 +7,13 @@
>>>   #include <linux/device.h>
>>>   #include <linux/interconnect-clk.h>
>>>   #include <linux/interconnect-provider.h>
>>> +#include <linux/pm_opp.h>
>>>     struct icc_clk_node {
>>> +    struct device *dev;
>>>       struct clk *clk;
>>>       bool enabled;
>>> +    bool opp;
>>>   };
>>>     struct icc_clk_provider {
>>> @@ -25,12 +28,16 @@ struct icc_clk_provider {
>>>   static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
>>>   {
>>>       struct icc_clk_node *qn = src->data;
>>> +    unsigned long rate = icc_units_to_bps(src->peak_bw);
>>>       int ret;
>>>         if (!qn || !qn->clk)
>>>           return 0;
>>>   -    if (!src->peak_bw) {
>>> +    if (qn->opp)
>>> +        return dev_pm_opp_set_rate(qn->dev, rate);
>>> +
>>> +    if (!rate) {
>>>           if (qn->enabled)
>>>               clk_disable_unprepare(qn->clk);
>>>           qn->enabled = false;
>>> @@ -45,7 +52,7 @@ static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
>>>           qn->enabled = true;
>>>       }
>>>   -    return clk_set_rate(qn->clk, icc_units_to_bps(src->peak_bw));
>>> +    return clk_set_rate(qn->clk, rate);
>>>   }
>>>     static int icc_clk_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
>>> @@ -106,7 +113,9 @@ struct icc_provider *icc_clk_register(struct device *dev,
>>>       icc_provider_init(provider);
>>>         for (i = 0, j = 0; i < num_clocks; i++) {
>>> +        qp->clocks[i].dev = dev;
>>>           qp->clocks[i].clk = data[i].clk;
>>> +        qp->clocks[i].opp = data[i].opp;
>>>             node = icc_node_create(first_id + j);
>>>           if (IS_ERR(node)) {
>>> diff --git a/include/linux/interconnect-clk.h b/include/linux/interconnect-clk.h
>>> index 0cd80112bea5..c695e5099901 100644
>>> --- a/include/linux/interconnect-clk.h
>>> +++ b/include/linux/interconnect-clk.h
>>> @@ -11,6 +11,7 @@ struct device;
>>>   struct icc_clk_data {
>>>       struct clk *clk;
>>>       const char *name;
>>> +    bool opp;
>>>   };
>>>     struct icc_provider *icc_clk_register(struct device *dev,
> 
