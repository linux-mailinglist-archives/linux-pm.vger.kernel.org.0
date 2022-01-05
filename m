Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC8485907
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jan 2022 20:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243436AbiAETSJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jan 2022 14:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243432AbiAETSI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jan 2022 14:18:08 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C47BC061212
        for <linux-pm@vger.kernel.org>; Wed,  5 Jan 2022 11:18:08 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id kd9so103721qvb.11
        for <linux-pm@vger.kernel.org>; Wed, 05 Jan 2022 11:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E/tuVadHaEH/hEWyzopgKNgW196h/V3yBaBZyt/HHmA=;
        b=yPy+8cSbp4GPUCGG2ErS0B0X/e5qesxGQzmgjQAtvTjt2XByCxkvTUCfAP9TNxPZ3h
         kAT1P9htKdZbh/HnQDI5tkMqxi/yv5iVPomkxRoFQrmaN6NafnMzDYJp7u3FyYcPbclr
         9gV8/IUBAk4ymy17TeQ6oFMjK1mDS5T4YJ6YwULHAzXCJ3JGPTa3J1szffKu3CEdVVex
         JkJp0v1yuyG2olTwobvVAVyqyqKAOdOaqicJFz396/qy1COjZSleOZvJjGC8bZEHyz3a
         /cl0hFqbKkWAjciZvFX4/M/XTU4EKFBHoAikClfMEsuVWju+WM+tUkBTbA/6m4J1s29U
         SsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E/tuVadHaEH/hEWyzopgKNgW196h/V3yBaBZyt/HHmA=;
        b=gmpNAJ8fH1Dw/dnchrIqfmjIejZxrTseQjyDGMVeokoHMvmS8pcNmwpZ0tbhTtrVOt
         w7HC5ZhDEU48ZloBiEi7Lz2ivl0zqxJAPoomu58doLX3wA3ZEl+zLCYjrOe6hSSOo+Ew
         XGxWMUQvEIUT3DB+cjV+xFjNHrDyFDKxc6lNGtJT2+is94sNKs9VYm0CAun920LqbrYJ
         06MQiNO0B1shRuayR3XdQT90/59qMsyFaH/z/ARoOH9p0vTPYjRyZxhKi6oPJEwMSvSb
         QVnlrVS6Q70hqkb0kJyQP0w3IGKTBfkOFq1QrPjjfaZQrKX8hGDmnLS4U4/P3PJFUJ+C
         qkvw==
X-Gm-Message-State: AOAM531rDGNUnA7gX2jk/ylgDSSV4EhBBB2FbPp03J3icmioMh9qzm9B
        HKn2nYONH/eDgezIJKUiFuxG1Q==
X-Google-Smtp-Source: ABdhPJxrog27ptnRZIj8eUsYnuB6by16pgiCiH0a5aEzVRFZUP/gdC/V8dMbVDx0a7l/LOdfQpyetQ==
X-Received: by 2002:ad4:4ee6:: with SMTP id dv6mr51495055qvb.50.1641410287061;
        Wed, 05 Jan 2022 11:18:07 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id 8sm38003388qtz.28.2022.01.05.11.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 11:18:06 -0800 (PST)
Subject: Re: [Patch v2 1/3] thermal: qcom: lmh: Add support for sm8150
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211215163400.33349-1-thara.gopinath@linaro.org>
 <20211215163400.33349-2-thara.gopinath@linaro.org>
 <62f98846-0126-86ee-9bbd-f7abd03a4791@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <f5eae932-8f8a-6c7f-b953-0d4da99a0d17@linaro.org>
Date:   Wed, 5 Jan 2022 14:18:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <62f98846-0126-86ee-9bbd-f7abd03a4791@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/20/21 7:04 AM, Daniel Lezcano wrote:
> On 15/12/2021 17:33, Thara Gopinath wrote:
>> Add compatible to support LMh for sm8150 SoC.
>> sm8150 does not require explicit enabling for various LMh subsystems.
>> Add a variable indicating the same as match data which is set for sdm845.
>> Execute the piece of code enabling various LMh subsystems only if
>> enable algorithm match data is present.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>
>> v1->v2:
>> 	- Added LMH_ENABLE_ALGOS of_device_id match data to indicate
>> 	  whether LMh subsytems need explicit enabling or not.
>>
>>   drivers/thermal/qcom/lmh.c | 62 +++++++++++++++++++++-----------------
>>   1 file changed, 35 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
>> index eafa7526eb8b..80d26d043498 100644
>> --- a/drivers/thermal/qcom/lmh.c
>> +++ b/drivers/thermal/qcom/lmh.c
>> @@ -28,6 +28,8 @@
>>   
>>   #define LMH_REG_DCVS_INTR_CLR		0x8
>>   
>> +#define LMH_ENABLE_ALGOS		((void *)1)
> 
> It will be nicer a probe function here

Hello Daniel,

As we discussed, there are SoCs for which all the algorithms need not be 
enabled. So introducing a separate probe function for each will be 
clumsy. The idea here is to use flags (currently just one to specify 
whether the algorithms need to be enabled or not) to specify which 
algorithms to be enabled.


-- 
Warm Regards
Thara (She/Her/Hers)
> 
>> +
>>   struct lmh_hw_data {
>>   	void __iomem *base;
>>   	struct irq_domain *domain;
>> @@ -87,6 +89,7 @@ static int lmh_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>>   	struct device_node *np = dev->of_node;
>> +	const struct of_device_id *of_id;
>>   	struct device_node *cpu_node;
>>   	struct lmh_hw_data *lmh_data;
>>   	int temp_low, temp_high, temp_arm, cpu_id, ret;
>> @@ -141,32 +144,36 @@ static int lmh_probe(struct platform_device *pdev)
>>   	if (!qcom_scm_lmh_dcvsh_available())
>>   		return -EINVAL;
>>   
>> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
>> -				 LMH_NODE_DCVS, node_id, 0);
>> -	if (ret)
>> -		dev_err(dev, "Error %d enabling current subfunction\n", ret);
>> -
>> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
>> -				 LMH_NODE_DCVS, node_id, 0);
>> -	if (ret)
>> -		dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
>> -
>> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
>> -				 LMH_NODE_DCVS, node_id, 0);
>> -	if (ret)
>> -		dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
>> -
>> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
>> -				 LMH_NODE_DCVS, node_id, 0);
>> -	if (ret) {
>> -		dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
>> -		return ret;
>> -	}
>> -
>> -	ret = qcom_scm_lmh_profile_change(0x1);
>> -	if (ret) {
>> -		dev_err(dev, "Error %d changing profile\n", ret);
>> -		return ret;
>> +	of_id = of_match_device(dev->driver->of_match_table, dev);
>> +
>> +	if (of_id && of_id->data == LMH_ENABLE_ALGOS) {
>> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
>> +					 LMH_NODE_DCVS, node_id, 0);
>> +		if (ret)
>> +			dev_err(dev, "Error %d enabling current subfunction\n", ret);
>> +
>> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
>> +					 LMH_NODE_DCVS, node_id, 0);
>> +		if (ret)
>> +			dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
>> +
>> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
>> +					 LMH_NODE_DCVS, node_id, 0);
>> +		if (ret)
>> +			dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
>> +
>> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
>> +					 LMH_NODE_DCVS, node_id, 0);
>> +		if (ret) {
>> +			dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
>> +			return ret;
>> +		}
>> +
>> +		ret = qcom_scm_lmh_profile_change(0x1);
>> +		if (ret) {
>> +			dev_err(dev, "Error %d changing profile\n", ret);
>> +			return ret;
>> +		}
>>   	}
>>   
>>   	/* Set default thermal trips */
>> @@ -213,7 +220,8 @@ static int lmh_probe(struct platform_device *pdev)
>>   }
>>   
>>   static const struct of_device_id lmh_table[] = {
>> -	{ .compatible = "qcom,sdm845-lmh", },
>> +	{ .compatible = "qcom,sdm845-lmh", .data = LMH_ENABLE_ALGOS},
>> +	{ .compatible = "qcom,sm8150-lmh", },
>>   	{}
>>   };
>>   MODULE_DEVICE_TABLE(of, lmh_table);
>>
> 
> 


