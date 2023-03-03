Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C2B6A96A0
	for <lists+linux-pm@lfdr.de>; Fri,  3 Mar 2023 12:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjCCLms (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Mar 2023 06:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjCCLmr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2023 06:42:47 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA70D5D759
        for <linux-pm@vger.kernel.org>; Fri,  3 Mar 2023 03:42:43 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bi9so3237466lfb.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Mar 2023 03:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677843762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3cCmKUFN1E+lTtBihbO+zz5iEjuJOShZ6eI1AUU2Ox8=;
        b=QbW5Vgmr4Gmkhu4PG0UG/5KTbhkb43x2qM+G0WtLSh6EDuEEBzb9AnIQyiD+cpBL4X
         btTtACy/NYXB6ZhG+LFbsFVP7JwnJuQgsauL79PCL9YBrJSVET7T1JGcSBFhZLbN0hz7
         vE13lX/g7OJBDIlT+nWJXhYkuq+pp+8TxbLk9hYkJ+NFhr2kcClAZIQ5FaTDUtTvxAab
         0T7+BOA1NmtyZs2fhi2FYpuwKcomu6gZdLOTBDwl7739VdLRb//4IF6Z6yFxnauC3Mrk
         2gS/kHoDH2D1WvXOr9bjtCWWmi3R8m49bshrTMoXGy5POkiXu5+iCjjTiCJoM5UNw+K7
         WUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677843762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cCmKUFN1E+lTtBihbO+zz5iEjuJOShZ6eI1AUU2Ox8=;
        b=qfAau/ZE+OdFiNUxZy4TIjbKP42IePPQUJ+sAtDYEDnAHRryg4H4M49HkRVI44putD
         mi+pnw3INxnWH/TIA9vkaWHifraRf0+PpUzie1Vq4/mYYUI5yOLE19jMaTmk+EiZa37H
         qeSzvjn8Qa4PSXHMbN+PhknZGODY0Z9esrLBPIXCUR9HdfpQ1ePud4HrP2S1UYtb8gTf
         2W0ekj8eTIP0g9ucDGawOWRCfbRIh2BA4xAgtgsFcaDGb21PZPQZzBs06kaOIYeIu5tF
         dpeT6UGQx+kJXwj+XdHPsidivoTl+IQP2W55yGXl+S+JgOiLhDG/XOJinq4cXiSh+fP4
         PJoA==
X-Gm-Message-State: AO0yUKWkltJZIegtSGOmejjblTH5NtvCoNoeVfQ3Jqqs8ac/TqcUYvRo
        0SrNSQiVO5TA5fRRZogv7ghNYQ==
X-Google-Smtp-Source: AK7set/+qOVIwu+yxqJTnWn6xzy8nugk3umDW/3fbM136sNqDB/A2T81pQ0bJh2iHDa0rzvhxUKRVA==
X-Received: by 2002:ac2:4c06:0:b0:4e0:6e01:7d28 with SMTP id t6-20020ac24c06000000b004e06e017d28mr497408lfq.60.1677843762102;
        Fri, 03 Mar 2023 03:42:42 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id b14-20020a056512218e00b004dc4b00a1eesm355173lft.261.2023.03.03.03.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 03:42:41 -0800 (PST)
Message-ID: <0b1fafe6-0814-f1a6-ae19-7bd273751102@linaro.org>
Date:   Fri, 3 Mar 2023 12:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] interconnect: qcom: icc-rpm: Don't call
 __qcom_icc_set twice on the same node
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230303023500.2173137-1-konrad.dybcio@linaro.org>
 <59b28fb4-1367-9872-ed63-90847e380bb6@linaro.org>
 <29513b9e-8561-7f7e-370e-7515116c7ee6@linaro.org>
 <3116a08a-30a8-c9b9-f079-26739c9e6d49@linaro.org>
 <08020872-6316-8f81-ac6a-c6eef408818f@linaro.org>
 <db4f4e53-e8b9-0807-7490-2c6b76194ad5@linaro.org>
 <2cfba291-656f-9a43-fdd5-7601a6fe6ef5@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2cfba291-656f-9a43-fdd5-7601a6fe6ef5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3.03.2023 12:40, Bryan O'Donoghue wrote:
> On 03/03/2023 11:39, Konrad Dybcio wrote:
>>
>>
>> On 3.03.2023 12:36, Bryan O'Donoghue wrote:
>>> On 03/03/2023 11:35, Bryan O'Donoghue wrote:
>>>> On 03/03/2023 11:33, Konrad Dybcio wrote:
>>>>>
>>>>>
>>>>> On 3.03.2023 12:32, Bryan O'Donoghue wrote:
>>>>>> On 03/03/2023 02:35, Konrad Dybcio wrote:
>>>>>>> Currently, when sync_state calls set(n, n) all the paths for setting
>>>>>>> parameters on an icc node are called twice. Avoid that.
>>>>>>>
>>>>>>> Fixes: 751f4d14cdb4 ("interconnect: icc-rpm: Set destination bandwidth as well as source bandwidth")
>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>>> ---
>>>>>>> RFC comes from the fact that I *believe* this should be correct, but I'm
>>>>>>> not entirely sure about it..
>>>>>>>
>>>>>>>
>>>>>>>     drivers/interconnect/qcom/icc-rpm.c | 2 +-
>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>>>>>>> index a6e0de03f46b..d35db1af9b08 100644
>>>>>>> --- a/drivers/interconnect/qcom/icc-rpm.c
>>>>>>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>>>>>>> @@ -387,7 +387,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>>>>>>>         ret = __qcom_icc_set(src, src_qn, sum_bw);
>>>>>>>         if (ret)
>>>>>>>             return ret;
>>>>>>> -    if (dst_qn) {
>>>>>>> +    if (dst_qn && src_qn != dst_qn) {
>>>>>>>             ret = __qcom_icc_set(dst, dst_qn, sum_bw);
>>>>>>>             if (ret)
>>>>>>>                 return ret;
>>>>>>
>>>>>> Is it possible for src_qn == dst_qn ?
>>>>> As the commit message says, sync_state calls set(n, n) in
>>>>> drivers/interconnect/core.c : icc_sync_state(struct device *dev)
>>>>
>>>> So you've _seen_ that happen ?
>>>>
>>>
>>> Assuming you have, then why isn't the fix in sync_state i.e. that's an error for everybody right ?
>> I believe that there's simply no other way of updating every single node
>> on its own with the icc api, without taking any links into play. But I
>> see exynos and i.mx also effectively calling it twice on each node.
>>
>> Konrad
> 
> I mean. I'm fine for you to retain my RB on this qcom specific patch since this seems like a real bug to me but... it seems like a generic bug across arches that should probably be resolved @ the higher level.
> 
> ?
I suppose we could change the set(n, n) in sync_state to be set(n, NULL)
and enforce parameter null-checking on all provider->set functions. Do
I understand this correctly?

Konrad
> 
> ---
> bod
