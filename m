Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5CB660663
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 19:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjAFSdn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 13:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjAFSdm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 13:33:42 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11F37681E
        for <linux-pm@vger.kernel.org>; Fri,  6 Jan 2023 10:33:39 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b3so3176621lfv.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2023 10:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrCVYWNpL5Wnb1p4Qbo4TV8of4XvTw24DGvAqDgmAt4=;
        b=wHsGjhqFYaNvFCFES3o26xH6GOcgIKRtcs3sIhmjCgHTmSkMpEx6lu0TmuoHtSL6+K
         9iaYlmN2jIMGJUuxSpE9RmtLjtmIK0ntzEXFCZtDIebFrZpICH6VbSUzODBM0d1TMesl
         3whfqrfHEUvvKYxcQNCXWMBW0g0rmnsA1hAAjRSlAFi6Z8vFqh+lGWsoHYhfP5jnUd/1
         0BxqVkp5ebTO4T9t+PZfJdds6X3TijLosRhdQDrqkzGTbfe3iRJ3Pe6/WPXzk2NmwvnF
         KOG5ogOzUyOEoSLtuoVLqPPoJ9qPbP3fiHolvaaj/p7acd/ms8bgE2U6F82tj0UkUSB8
         4eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrCVYWNpL5Wnb1p4Qbo4TV8of4XvTw24DGvAqDgmAt4=;
        b=vckqcqOWmZUdj6j9C8Y5IwtbemgTEj6vWOzXZoYAn+tTR+FW2Hc0jDOfgcDQVaynpK
         T6nkmrogm/TkEkmx5qqF2mPJI4UFfPjWAp7PkNmmXOisuwxWNI4ksq8FfopBT/sxd+2q
         RuOD83xW2MjRg/3NSyyN3Vn5sKQpPVAGkwGBak1BKbAZEPuwLkbQ4pI8rcKuAu8IoTL9
         IMQiW2aAoPKl0AZ9l2kGSrnI//gXtQmpHnmsQz/BmmNMWdz1dSHSrfKB7IV4t8QBrU5t
         YwIYGsFbz6x2yBiJ/MdbCL65mIpgVzRlDdvPM6IxbR5UyaHjcqaGE0Pua3+8ckMqeIAg
         hlkQ==
X-Gm-Message-State: AFqh2koOOFYlwlb8TrLO5gqrZ0lBOv8iDEKSIMBNcXwHNyYWH/H2beKX
        jx/4DXGb19N8yl1p1Mx74KIhSA==
X-Google-Smtp-Source: AMrXdXtYYOvcWvdLnE52R/PdG2gcdhQoTn0D+na2q7BvwZQLX3ks5xdQQ91OSsx3RsVSfct/7fNLNA==
X-Received: by 2002:a05:6512:1104:b0:4af:5088:959c with SMTP id l4-20020a056512110400b004af5088959cmr17307664lfg.2.1673030018285;
        Fri, 06 Jan 2023 10:33:38 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id n14-20020ac2490e000000b004b55cebdbd7sm234780lfi.120.2023.01.06.10.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 10:33:37 -0800 (PST)
Message-ID: <d87ca8de-f763-48a4-d7f5-54bfc5192f97@linaro.org>
Date:   Fri, 6 Jan 2023 20:33:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/9] clk: qcom: rpmh: define IPA clocks where required
Content-Language: en-GB
To:     Alex Elder <elder@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
 <20230106073313.1720029-2-dmitry.baryshkov@linaro.org>
 <927673c9-ce50-d03a-83f5-45d5416838d1@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <927673c9-ce50-d03a-83f5-45d5416838d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/01/2023 15:39, Alex Elder wrote:
> On 1/6/23 1:33 AM, Dmitry Baryshkov wrote:
>> Follow the example of sc7180 and sdx55 and implement IP0 resource as
>> clocks rather than interconnects.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> So this is simply adding these clocks?  Were they not
> defined/implemented as interconnects before?  (It
> isn't clear from your message above, and I just want
> to be sure there's no duplication.)

Well, that's the point of the patchset: to turn them from ICC to clock. 
I can change the order of the patches in the patchset, if you think it 
will make it more obvious.

> 
>                      -Alex
> 
>> ---
>>   drivers/clk/qcom/clk-rpmh.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>> index 586a810c682c..5f914cf36b10 100644
>> --- a/drivers/clk/qcom/clk-rpmh.c
>> +++ b/drivers/clk/qcom/clk-rpmh.c
>> @@ -445,6 +445,7 @@ static struct clk_hw *sm8150_rpmh_clocks[] = {
>>       [RPMH_RF_CLK2_A]    = &clk_rpmh_rf_clk2_a_ao.hw,
>>       [RPMH_RF_CLK3]        = &clk_rpmh_rf_clk3_a.hw,
>>       [RPMH_RF_CLK3_A]    = &clk_rpmh_rf_clk3_a_ao.hw,
>> +    [RPMH_IPA_CLK]        = &clk_rpmh_ipa.hw,
>>   };
>>   static const struct clk_rpmh_desc clk_rpmh_sm8150 = {
>> @@ -484,6 +485,7 @@ static struct clk_hw *sc8180x_rpmh_clocks[] = {
>>       [RPMH_RF_CLK2_A]    = &clk_rpmh_rf_clk2_d_ao.hw,
>>       [RPMH_RF_CLK3]        = &clk_rpmh_rf_clk3_d.hw,
>>       [RPMH_RF_CLK3_A]    = &clk_rpmh_rf_clk3_d_ao.hw,
>> +    [RPMH_IPA_CLK]        = &clk_rpmh_ipa.hw,
>>   };
>>   static const struct clk_rpmh_desc clk_rpmh_sc8180x = {
>> @@ -504,6 +506,7 @@ static struct clk_hw *sm8250_rpmh_clocks[] = {
>>       [RPMH_RF_CLK1_A]    = &clk_rpmh_rf_clk1_a_ao.hw,
>>       [RPMH_RF_CLK3]        = &clk_rpmh_rf_clk3_a.hw,
>>       [RPMH_RF_CLK3_A]    = &clk_rpmh_rf_clk3_a_ao.hw,
>> +    [RPMH_IPA_CLK]        = &clk_rpmh_ipa.hw,
>>   };
>>   static const struct clk_rpmh_desc clk_rpmh_sm8250 = {
>> @@ -546,6 +549,7 @@ static struct clk_hw *sc8280xp_rpmh_clocks[] = {
>>       [RPMH_IPA_CLK]          = &clk_rpmh_ipa.hw,
>>       [RPMH_PKA_CLK]          = &clk_rpmh_pka.hw,
>>       [RPMH_HWKM_CLK]         = &clk_rpmh_hwkm.hw,
>> +    [RPMH_IPA_CLK]        = &clk_rpmh_ipa.hw,
>>   };
>>   static const struct clk_rpmh_desc clk_rpmh_sc8280xp = {
> 

-- 
With best wishes
Dmitry

