Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F9173E0EF
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 15:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjFZNoz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 09:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjFZNoo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 09:44:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65772E7A
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 06:44:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f8689fbf59so5411075e87.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687787080; x=1690379080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z182+Q4uKJie6Rxr4pwKFm/7JzYn7OU/lRN6E75YsLU=;
        b=eXQV8HOG8X7LkEP0FGaLvSgKFbx5frQztyredVZnH3azpB0e/MWxX/OvIesjczaWTD
         sbyN1HTNgbA98LWHmikLcIJuJ88TSUAAGZns00Lo4oboSKnvQQoFooYapW04pDeIipeB
         xl8pyVivBRsCC1akqSDBp76Ut37ukgIFoDPVWTe8WSQuf6VGvXZNyraZGv5uodCCnahk
         C9Lb/dkyYimWqVtCR3aKir/5u/0FJQkKygo9pXK4/CrE3jLXKfXPsP6oK9UuqfLGzzgJ
         Em2yzd089u1gW8F1VvTEH1xwgUJI7nf4nlFAIAHqzjkvbGoqu8dmpR9y8H7jKRzVcpwI
         aWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687787080; x=1690379080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z182+Q4uKJie6Rxr4pwKFm/7JzYn7OU/lRN6E75YsLU=;
        b=NrXXD60PshsNHJGvsm18o/ZJw7n8uxwxTQB3jTYaCvl+v3Tg0g5j0sTHvHafiFSY2A
         D7b0XNPYNUYWPzO08og4s+BdpQJQcScPfX316Q4k9VKeuIEqDFXXJJWrcTTVPHl/mRg1
         ykbITxmPoGijnqd3uN7nKFRKG5O18+xldyXsfkj9YCy9rp4zKr8DF19LJHT2GQW5fQY2
         R65ctix/QZwBI2xZSDhavbA9bgkmfUJplZJ1yTfUh/OcqiVMANiN4+e0GTtWUWQYMvNZ
         BVh30Nbjgm6+Mqd7kUO4TFon2SdrYIWlCef2uOfPI0B2lWqRfvWTTVKTf6vx3sz2EzJ1
         /KKg==
X-Gm-Message-State: AC+VfDwSZxmZnBsbrdLCKEaMetQM/yvgBFcoWOxpTWxpDlXc8NN4W7W0
        q6VpPV1vFn568Hxh5UkNQBlbgQ==
X-Google-Smtp-Source: ACHHUZ4tMRepmhfl1tjS3N4io66eAdL2IcMharuAdzXvUqx4OEu4BAmMjhy8W1VXaGhJtB56aq84oA==
X-Received: by 2002:a05:6512:33c7:b0:4f8:4b19:9533 with SMTP id d7-20020a05651233c700b004f84b199533mr9837735lfg.19.1687787080554;
        Mon, 26 Jun 2023 06:44:40 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d30-20020ac25ede000000b004f252003071sm1126500lfq.37.2023.06.26.06.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:44:39 -0700 (PDT)
Message-ID: <d9e4fd75-310a-7fe8-879e-651011873199@linaro.org>
Date:   Mon, 26 Jun 2023 16:44:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/26] interconnect: icc-clk: add support for scaling
 using OPP
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <b5ff346b-cbde-68fe-a08a-3b3331439309@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/06/2023 14:28, Konrad Dybcio wrote:
> On 25.06.2023 22:25, Dmitry Baryshkov wrote:
>> Sometimes it might be required to scale the clock using the OPP
>> framework (e.g. to scale regulators following the required clock rate).
>> Extend the interconnec
> 't'
> 
>> -clk framework to handle OPP case in addition to
>> scaling the clock.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
> I think we should check for OPP at the icc-clk registration time,
> instead of passing it as a parameter, e.g.:
> 
> qn.opp = IS_ERR(dev_pm_opp_get_opp_count)
> 
> Not sure if there's a more idiomatic way.

No. icc-clk is not limited to a single clock->icc conversion. So it is 
possible to create several interconnect links, only one of which should 
be the OPP-based one.

> 
> Konrad
>>   drivers/interconnect/icc-clk.c   | 13 +++++++++++--
>>   include/linux/interconnect-clk.h |  1 +
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
>> index 4d43ebff4257..c7962acdcee7 100644
>> --- a/drivers/interconnect/icc-clk.c
>> +++ b/drivers/interconnect/icc-clk.c
>> @@ -7,10 +7,13 @@
>>   #include <linux/device.h>
>>   #include <linux/interconnect-clk.h>
>>   #include <linux/interconnect-provider.h>
>> +#include <linux/pm_opp.h>
>>   
>>   struct icc_clk_node {
>> +	struct device *dev;
>>   	struct clk *clk;
>>   	bool enabled;
>> +	bool opp;
>>   };
>>   
>>   struct icc_clk_provider {
>> @@ -25,12 +28,16 @@ struct icc_clk_provider {
>>   static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
>>   {
>>   	struct icc_clk_node *qn = src->data;
>> +	unsigned long rate = icc_units_to_bps(src->peak_bw);
>>   	int ret;
>>   
>>   	if (!qn || !qn->clk)
>>   		return 0;
>>   
>> -	if (!src->peak_bw) {
>> +	if (qn->opp)
>> +		return dev_pm_opp_set_rate(qn->dev, rate);
>> +
>> +	if (!rate) {
>>   		if (qn->enabled)
>>   			clk_disable_unprepare(qn->clk);
>>   		qn->enabled = false;
>> @@ -45,7 +52,7 @@ static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
>>   		qn->enabled = true;
>>   	}
>>   
>> -	return clk_set_rate(qn->clk, icc_units_to_bps(src->peak_bw));
>> +	return clk_set_rate(qn->clk, rate);
>>   }
>>   
>>   static int icc_clk_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
>> @@ -106,7 +113,9 @@ struct icc_provider *icc_clk_register(struct device *dev,
>>   	icc_provider_init(provider);
>>   
>>   	for (i = 0, j = 0; i < num_clocks; i++) {
>> +		qp->clocks[i].dev = dev;
>>   		qp->clocks[i].clk = data[i].clk;
>> +		qp->clocks[i].opp = data[i].opp;
>>   
>>   		node = icc_node_create(first_id + j);
>>   		if (IS_ERR(node)) {
>> diff --git a/include/linux/interconnect-clk.h b/include/linux/interconnect-clk.h
>> index 0cd80112bea5..c695e5099901 100644
>> --- a/include/linux/interconnect-clk.h
>> +++ b/include/linux/interconnect-clk.h
>> @@ -11,6 +11,7 @@ struct device;
>>   struct icc_clk_data {
>>   	struct clk *clk;
>>   	const char *name;
>> +	bool opp;
>>   };
>>   
>>   struct icc_provider *icc_clk_register(struct device *dev,

-- 
With best wishes
Dmitry

