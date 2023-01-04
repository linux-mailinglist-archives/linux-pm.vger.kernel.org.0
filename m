Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C56F65CB17
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jan 2023 01:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbjADAsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Jan 2023 19:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbjADAsh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2023 19:48:37 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4F4164A3
        for <linux-pm@vger.kernel.org>; Tue,  3 Jan 2023 16:48:35 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so48266689lfv.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2023 16:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BKu/VauqBCYgezBQrQES+QSt580NOfOFvIsxFY1xklM=;
        b=aNnURh34uv0pBnVClleJ/1Ml04l/3rLsPGa6vlFNRtHhR5qe3umW4RNR/f/wVl+cTn
         8gPmT5Wlmr7vOXw+N8hCC3vNEheaogyh1+IhDRFH5md10IxTXygVG6NP42cL6970K/+N
         wUwxzk+QMw+eJb3iWIO9xfRqmpnyLEDZDDv7hk84tMbHDwHhblTJFOKp2TXFi5Nm5nwP
         fm42XeQpE71XI9srQlTc3iICpg0Ww1irI6Fz9z8I84G/ZQPXe4wGlVuR57sUYns/OyhX
         mOp3oKhDV4RaBkXcUeEx9seQEvct81nID68hXTYNKEgozM//yr6JVnoKYvZ4BdWog00o
         CQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKu/VauqBCYgezBQrQES+QSt580NOfOFvIsxFY1xklM=;
        b=p0CIQ1P1rxFnqclyw3m5WNMmaisMWUemCe61fdfgZhwKbcWL6EY4EaCVLen/o4h3lb
         bGfl7/ykcYW2KyQyZLNX+OlrB2LMVbNAIMjTNs9deLS3W1odscEqC4DHGpy6O5mw6xkR
         WkecGJma+NSfc09HRefpdZ2G4argqWQC7Rkz3rXs4hZ2ucWp643vJLsEGqIAUVXjRiTu
         SpjAKsQ9aV81i+j5CjnLoP6xcS0vOkwh3FYB1aK/1/fYknIKnqVjahD4C4oZjrya2Rqr
         fa4pc6A2UiMhMDM2uGA4BTi8bivkOUZlxslHuFeMLvghXSx23jYZQyZkUD31eeln14z4
         O24g==
X-Gm-Message-State: AFqh2kqCII5ujoXwPqHnenw+FNmzllS/N/jSiKWuSlS3j9NyaK1G9DGY
        uTGSJwnSt/rV5g2Dwu71F/2gjQ==
X-Google-Smtp-Source: AMrXdXtFwlBTAINRE3QlKZUsoy3/Un3r6y8+Qs/P30nEzQxFBlXIG3z+/Y+dx7xRT1oEEDcxiLDtBw==
X-Received: by 2002:a19:645b:0:b0:4a4:68b8:f4e7 with SMTP id b27-20020a19645b000000b004a468b8f4e7mr11338362lfj.45.1672793313687;
        Tue, 03 Jan 2023 16:48:33 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id l18-20020ac24312000000b00485caa0f5dfsm5015288lfh.44.2023.01.03.16.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 16:48:33 -0800 (PST)
Message-ID: <00e2ba61-c64d-0ef9-c802-f96c72109712@linaro.org>
Date:   Wed, 4 Jan 2023 01:48:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/4] interconnect: qcom: rpm: Set QoS parameters
 regardless of RPM bw setting
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>
References: <20230103173059.265856-1-konrad.dybcio@linaro.org>
 <20230103173059.265856-2-konrad.dybcio@linaro.org>
 <0e2bdaec-b7ba-0474-8b80-8901fcc87a0f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <0e2bdaec-b7ba-0474-8b80-8901fcc87a0f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4.01.2023 00:43, Bryan O'Donoghue wrote:
> On 03/01/2023 17:30, Konrad Dybcio wrote:
>> QoS parameters and RPM bandwidth requests are wholly separate. Setting one
>> should only depend on the description of the interconnect node and not
>> whether the other is present. If we vote through RPM, QoS parameters
>> should be set so that the bus controller can make better decisions.
> 
> Is that true ?
> 
>> If we don't vote through RPM, QoS parameters should be set regardless,
>> as we're requesting additional bandwidth by setting the interconnect
>> clock rates.
>>
>> The Fixes tag references the commit in which this logic was added, it
>> has since been shuffled around to a different file, but it's the one
>> where it originates from.
>>
>> Fixes: f80a1d414328 ("interconnect: qcom: Add SDM660 interconnect provider driver")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/icc-rpm.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index 06e0fee547ab..a190a0a839c8 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> @@ -252,8 +252,10 @@ static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
>>           ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
>>           if (ret)
>>               return ret;
>> -    } else if (qn->qos.qos_mode != -1) {
>> -        /* set bandwidth directly from the AP */
>> +    }
>> +
>> +    if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID) {
>> +        /* Set QoS params from the AP */
>>           ret = qcom_icc_qos_set(n, sum_bw);
>>           if (ret)
>>               return ret;
> 
> Taking the example of
> 
> static struct qcom_icc_node bimc_snoc_slv = {
>         .name = "bimc_snoc_slv",
>         .id = MSM8939_BIMC_SNOC_SLV,
>         .buswidth = 16,
>         .mas_rpm_id = -1,
>         .slv_rpm_id = 2,
>         .num_links = ARRAY_SIZE(bimc_snoc_slv_links),
>         .links = bimc_snoc_slv_links,
> };
> 
> #define NOC_QOS_MODE_INVALID -1
> ap_owned == false
> qos_mode == NOC_QOS_MODE_FIXED
> 
> 
> if (!qn->qos.ap_owned) {
>     /* bod: this will run */
>     /* send bandwidth request message to the RPM processor */
>     ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
>     if (ret)
>         return ret;
> } else if (qn->qos.qos_mode != -1) {
>     /* bod: this will not run */
>     /* set bandwidth directly from the AP */
>     ret = qcom_icc_qos_set(n, sum_bw);
>     if (ret)
>         return ret;
> }
> 
> and your proposed change
> 
> if (!qn->qos.ap_owned) {
>     /* bod: this will run */
>     /* send bandwidth request message to the RPM processor */
>     ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
>     if (ret)
>         return ret;
> }
> 
> if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID) {
>     /* bod: this will run */
Also, this will not run with the next patch, perhaps i should
have ordered them differently (or perhaps the issue it solves
should have never been introduced :P).

Konrad
>     /* set bandwidth directly from the AP */
>     ret = qcom_icc_qos_set(n, sum_bw);
>     if (ret)
>         return ret;
> }
> 
> however if we look downstream we have the concept of ap_owned
> 
> https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.BR.1.2.9-00810-8x09.0/drivers/platform/msm/msm_bus/msm_bus_fabric_adhoc.c#L194
> 
> https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.BR.1.2.9-00810-8x09.0/drivers/platform/msm/msm_bus/msm_bus_fabric_adhoc.c#L208
> 
> In simple terms
> if (node_info->ap_owned) {
>     ret = fabdev->noc_ops.set_bw(node_info,
>                                     } else {
>     ret = send_rpm_msg(node_device);
> }
> 
> I agree your code does what it says on the tin but, whats the overall justification to depart from the downstream logic ?
> 
> ---
> bod
