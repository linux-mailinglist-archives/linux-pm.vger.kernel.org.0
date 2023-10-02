Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B4D7B5ABA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Oct 2023 21:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbjJBS7c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Oct 2023 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJBS7b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2023 14:59:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A03ED7
        for <linux-pm@vger.kernel.org>; Mon,  2 Oct 2023 11:59:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50306b2920dso72445e87.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Oct 2023 11:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696273166; x=1696877966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrszV3+CYmj+tM+SxyXe+ws7+sNss2kpTTuRI9TMO44=;
        b=l3THzC0+4/nrU4EP2J4xY6OB+QgWZUNuga2KKWD9KABHiC58aXpg/Y2h4r/PRmlHpR
         rh0RvFmZ9bFeVIxDGjkcESx5RJUPSjZLNp/luWJ7RPmJKLq+Aih+upuwgykrhedsMIZj
         QwRIQoea8sPvlVEuhrzwSsCwwJicPjf53k6EnS7haeC04EK6UNqLaeX9W04NNBUFtXHC
         mKnTKvwqu6qQPOkH0sbjyM3CfE0JF9o+s5d2PsWl4G+U3/qUO9QxIvpImw6n0HmCHqQ4
         ziq1Jf4xh0Og6mg5knVrIzxd4bezPPWC+zl01K3fSJNxjVvHJ1rq2uX+hak4t7zLua2B
         vUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273166; x=1696877966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrszV3+CYmj+tM+SxyXe+ws7+sNss2kpTTuRI9TMO44=;
        b=YuUPeZSK8xBLsAxxyJDVUVAXcnopm8xTXfLoSQa4rjOnnCXx0ocKIrp68AzsP4PTwb
         IYhU7GWxc+nVckErMd26rWxWQDOyAK9ZUHUpIKVgXyzYqc2YujnuYrFlxWFYGyVbsnZW
         2AERc1jdaE4ZMqi0gGriNOUodXRyesoRmCqcz9Tt3RRU4vDsoIEUg+puyZReXwqIT4Mx
         NBTAih9W5Kb8suNuyCTMwERXqlgKQfpRs/MVPKOAj/Og2vWiwoEzRCnJeO/WI0jW3+Gp
         W0a29B4ScX8fdnk74aZH/uXBqi1QhLQwDzrqGwCTwCikVd//X1Cquo5BMjLrO5O00icz
         Zgsg==
X-Gm-Message-State: AOJu0YyiCLC/PLfSyUa9plUSWOOyIzi4IoO+mGW514/HcKB+RrXNPbMl
        /tepz3mGTGMSuxm7f4cjGhAkPw==
X-Google-Smtp-Source: AGHT+IHnqtPBC6A3QMAunGAelevOOZeI9rfO1gpamLiLaCS5CYls3Ko+5rNhEhIuK2FGN5DT8MUPWw==
X-Received: by 2002:ac2:520e:0:b0:503:cca:e535 with SMTP id a14-20020ac2520e000000b005030ccae535mr375866lfl.12.1696273165667;
        Mon, 02 Oct 2023 11:59:25 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id j26-20020a19f51a000000b0050420eff124sm2081352lfb.152.2023.10.02.11.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 11:59:25 -0700 (PDT)
Message-ID: <3276666c-8331-490f-be79-c626bd275287@linaro.org>
Date:   Mon, 2 Oct 2023 21:59:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] cpufreq: qcom-nvmem: provide separate
 configuration data for apq8064
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
References: <20230827032803.934819-1-dmitry.baryshkov@linaro.org>
 <20230827032803.934819-6-dmitry.baryshkov@linaro.org>
 <8a7af8ce-3ff4-4520-b4e2-dd39570ca796@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <8a7af8ce-3ff4-4520-b4e2-dd39570ca796@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/08/2023 14:04, Konrad Dybcio wrote:
> On 27.08.2023 05:28, Dmitry Baryshkov wrote:
>> APQ8064 can scale core voltage according to the frequency needs. Rather
>> than reusing the A/B format multiplexer, use a simple fuse parsing
>> function and configure required regulator.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/cpufreq/qcom-cpufreq-nvmem.c | 49 ++++++++++++++++++++++++++--
>>   1 file changed, 47 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>> index 81c080b854fe..35e2610c9526 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>> @@ -26,6 +26,7 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_domain.h>
>>   #include <linux/pm_opp.h>
>> +#include <linux/regulator/consumer.h>
>>   #include <linux/slab.h>
>>   #include <linux/soc/qcom/smem.h>
>>   
>> @@ -39,6 +40,7 @@ struct qcom_cpufreq_match_data {
>>   			   char **pvs_name,
>>   			   struct qcom_cpufreq_drv *drv);
>>   	const char **genpd_names;
>> +	const char * const *regulator_names;
>>   };
>>   
>>   struct qcom_cpufreq_drv {
>> @@ -203,6 +205,34 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>>   	return ret;
>>   }
>>   
>> +static int qcom_cpufreq_apq8064_name_version(struct device *cpu_dev,
>> +					     struct nvmem_cell *speedbin_nvmem,
>> +					     char **pvs_name,
>> +					     struct qcom_cpufreq_drv *drv)
>> +{
>> +	int speed = 0, pvs = 0;
>> +	u8 *speedbin;
>> +	size_t len;
>> +	int ret = 0;
> Unused, just return 0
> 
>> +
>> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
>> +	if (IS_ERR(speedbin))
>> +		return PTR_ERR(speedbin);
>> +
>> +	if (len != 4)
>> +		return -EINVAL;
>> +
>> +	get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
>> +
>> +	snprintf(*pvs_name, sizeof("speedXX-pvsXX"), "speed%d-pvs%d",
>> +		 speed, pvs);
> speed and pvs are both one hex digit long at best (see masking in
> get_krait_bin_format_a)

One hex translates to two decimal digits (0xf = 15).

> 
> Konrad

-- 
With best wishes
Dmitry

