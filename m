Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397463A73FB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 04:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhFOCcZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 22:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhFOCcZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 22:32:25 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F97BC061574
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 19:30:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 5so2542892qkc.8
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 19:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O53gEWfH2MVe6PVxXbAaaJkGomJpiUiI0nzOZi1VeT4=;
        b=ari/JPtxcjD1356HIyGGATsHHtSWUL83yblzZ1qQXrzE9aKC4qdmVYBcEAduXsg65w
         iH3R3XRzVzGaaA8JHGP913q/bTcysYsnPfgic4E5JxnEJiP2gEi5KM5SaUsYp4pO3aWC
         UCM6bRQbie3/GERjzCywogJOsYWAjY2PkZheMDuKZ1cftUfXjLtiDqJUv4N0sbb8h/EE
         m/nhCAdnAjMPclKKExB6pKf8uFPsfyEKw/tvDWmBA0mLEy9CkrZsJui/7RaXLYH0h25Q
         YzOSd+UF2+LRHmqa8Vqg3Yx589H2gTNpbeqryUiQtnN/RtsNzdecVPRyy8LUA0bdpFJo
         M/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O53gEWfH2MVe6PVxXbAaaJkGomJpiUiI0nzOZi1VeT4=;
        b=UmGyIByRuuiTRe+Z9x/zD6rO41xLT7PTfGya43H/aspWr6QpMmLj+XWy1M6bJunLht
         oXBj4zhkraWNZyNa8HbLOYaMa/vrLJTbQ1Qc2+3aOj/bLk+7ZRAGGzxyO5zC+LvAStoa
         ZHAK2JUfXLqd8QNn/6vseZeC1OIhl0zRBsXj7UtQhq81ERIrdXf/vozBAX5PbdIf8xxc
         7T3CmKD5Pb4qcP6Vr3mrBFlVMMPB9KRov/Gvbtvd4Rkui7oP1UIKA1jrAHYijGkhEEXn
         FX35njKqU/wsFQ+k/w2ZKqkmT9DaHpB4E1Q0219FOxmhi2C0O25xMLFSXeTKAY22pKM3
         zulw==
X-Gm-Message-State: AOAM530p5qlBWjQHCbPcuzm+Pb7IWw2KQ0Xd6/BkJDe5PR8rXccdryJ1
        eVrXIaYrXhVT8HeHM4cNxnk72Mo5ffzeCA==
X-Google-Smtp-Source: ABdhPJykLVHgEcNXRGmsiw+Gghaj3UFAO/+ACWLcRb5LGGkrwYT07tHo8yVXU4dF7o02rriG13mIbg==
X-Received: by 2002:ac8:41d3:: with SMTP id o19mr19449923qtm.90.1623721081609;
        Mon, 14 Jun 2021 18:38:01 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id y15sm708630qto.90.2021.06.14.18.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 18:38:01 -0700 (PDT)
Subject: Re: [PATCH 2/5] thermal: qcom: Add support for LMh driver
To:     Randy Dunlap <rdunlap@infradead.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210608222926.2707768-1-thara.gopinath@linaro.org>
 <20210608222926.2707768-3-thara.gopinath@linaro.org>
 <531fae77-f037-5e4a-be1e-ce21618fbd9d@infradead.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <7917d02c-034b-6bd9-0f65-f4c5009a313f@linaro.org>
Date:   Mon, 14 Jun 2021 21:37:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <531fae77-f037-5e4a-be1e-ce21618fbd9d@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Randy,

Thanks for the review. I somehow did not see your review earlier. I 
noticed it today morning when Bjorn replied to this patch. Apologies for 
the delay

On 6/8/21 10:25 PM, Randy Dunlap wrote:
> On 6/8/21 3:29 PM, Thara Gopinath wrote:
>> Driver enabling various pieces of Limits Management Hardware(LMh) for cpu
>> cluster0 and cpu cluster1 namely kick starting monitoring of temperature,
>> current, battery current violations, enabling reliability algorithm and
>> setting up various temperature limits.
>>
>> The following has been explained in the cover letter. I am including this
>> here so that this remains in the commit message as well.
>>
>> LMh is a hardware infrastructure on some Qualcomm SoCs that can enforce
>> temperature and current limits as programmed by software for certain IPs
>> like CPU. On many newer SoCs LMh is configured by firmware/TZ and no
>> programming is needed from the kernel side. But on certain SoCs like sdm845
>> the firmware does not do a complete programming of the h/w. On such SoCs
>> kernel software has to explicitly set up the temperature limits and turn on
>> various monitoring and enforcing algorithms on the hardware.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   drivers/thermal/qcom/Kconfig  |  10 ++
>>   drivers/thermal/qcom/Makefile |   1 +
>>   drivers/thermal/qcom/lmh.c    | 244 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 255 insertions(+)
>>   create mode 100644 drivers/thermal/qcom/lmh.c
>>
>> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
>> index 8d5ac2df26dc..c95b95e254d7 100644
>> --- a/drivers/thermal/qcom/Kconfig
>> +++ b/drivers/thermal/qcom/Kconfig
>> @@ -31,3 +31,13 @@ config QCOM_SPMI_TEMP_ALARM
>>   	  trip points. The temperature reported by the thermal sensor reflects the
>>   	  real time die temperature if an ADC is present or an estimate of the
>>   	  temperature based upon the over temperature stage value.
>> +
>> +config QCOM_LMH
>> +	tristate "Qualcomm Limits Management Hardware"
>> +	depends on ARCH_QCOM
>> +	help
>> +	  This enables initialization of Qualcomm limits management
>> +	  hardware(LMh). LMh allows for h/w enforced mitigation for cpus based on
> 
> 	                                hardware-enforced           CPUs
> 
>> +	  input from temperature and current sensors.  On many newer Qualcomm SoCs
>> +	  LMH is configure in the firmware and this feature need not be enabled.
> 
> 	  LMh
> 
>> +	  However, on certain SoCs like sdm845 LMH has to be configured from HLOS.
> 
> 	                                       LMh
> 
> What is HLOS?

High Level Operating System. But I will change it to Linux kernel.
> 
> 
>> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
>> new file mode 100644
>> index 000000000000..8741a36cb674
>> --- /dev/null
>> +++ b/drivers/thermal/qcom/lmh.c
>> @@ -0,0 +1,244 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright (C) 2021, Linaro Limited. All rights reserved.
>> + */
> 
> [snip]
> 
>> +static int lmh_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev;
>> +	struct device_node *np;
>> +	struct lmh_hw_data *lmh_data;
>> +	u32 node_id;
>> +	int ret;
>> +
>> +	dev = &pdev->dev;
>> +	np = dev->of_node;
>> +	if (!np)
>> +		return -EINVAL;
>> +
>> +	lmh_data = devm_kzalloc(dev, sizeof(*lmh_data), GFP_KERNEL);
>> +	if (!lmh_data)
>> +		return -ENOMEM;
>> +
>> +	lmh_data->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(lmh_data->base))
>> +		return PTR_ERR(lmh_data->base);
>> +
>> +	ret = of_property_read_u32(np, "qcom,lmh-cpu-id", &lmh_data->cpu_id);
>> +	if (ret)
>> +		return -ENODEV;
>> +
>> +	/*
>> +	 * Only sdm845 has lmh hardware currently enabled from hlos. If this is needed
>> +	 * for other platforms, revisit this to check if the <cpu-id, node-id> should be part
>> +	 * of a dt match table.
>> +	 */
>> +	if (lmh_data->cpu_id == 0) {
>> +		node_id = LMH_CLUSTER0_NODE_ID;
>> +	} else if (lmh_data->cpu_id == 4) {
>> +		node_id = LMH_CLUSTER1_NODE_ID;
>> +	} else {
>> +		dev_err(dev, "Wrong cpu id associated with lmh node\n");
> 
> 		                    CPU                    LMh

will fix it. Also will fix all the typos you have caught below.

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Payload size is five bytes for now */
>> +	lmh_data->payload_size = 5 * sizeof(u32);
>> +
>> +	platform_set_drvdata(pdev, lmh_data);
>> +
>> +	if (!qcom_scm_lmh_dcvsh_available())
>> +		return -EINVAL;
>> +
>> +	/* Enable Thermal Algorithm */
>> +	update_payload(lmh_data, LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1);
>> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Enable Current Sensing Algorithm */
>> +	update_payload(lmh_data, LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1);
>> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Error %d enabling current subfunction\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Enable Reliability Algorithm */
>> +	update_payload(lmh_data, LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1);
>> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Enable BCL Algorithm */
>> +	update_payload(lmh_data, LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1);
>> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
> 
> What is BCL?

Battery Current Limits

-- 
Warm Regards
Thara
> 
>> +		return ret;
>> +	}
>> +
>> +	ret = qcom_scm_lmh_profile_change(0x1);
>> +	if (ret) {
>> +		dev_err(dev, "Error %d changing profile\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Set default thermal trips */
>> +	update_payload(lmh_data, LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, LMH_TH_ARM_TEMP);
>> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Error setting thermal ARM thershold%d\n", ret);
> 
> 		                                        threshold
> 
>> +		return ret;
>> +	}
>> +
>> +	update_payload(lmh_data, LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, LMH_TH_HI_TEMP);
>> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Error setting thermal HI thershold%d\n", ret);
> 
> 		                                       threshold
> 
>> +		return ret;
>> +	}
>> +	update_payload(lmh_data, LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, LMH_TH_LOW_TEMP);
>> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Error setting thermal ARM thershold%d\n", ret);
> 
> 		                                        threshold
> 
>> +		return ret;
>> +	}
>> +
>> +	lmh_data->irq = platform_get_irq(pdev, 0);
>> +	lmh_data->domain = irq_domain_add_linear(np, 1, &lmh_irq_ops, lmh_data);
>> +	if (!lmh_data->domain) {
>> +		dev_err(dev, "Error adding irq_domain\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
>> +			       IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_SUSPEND,
>> +			       "lmh-irq", lmh_data);
>> +	if (ret) {
>> +		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
>> +		irq_domain_remove(lmh_data->domain);
>> +		return ret;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id lmh_table[] = {
>> +	{ .compatible = "qcom,msm-hw-limits", },
>> +	{},
>> +};
>> +
>> +static struct platform_driver lmh_driver = {
>> +	.probe = lmh_probe,
>> +	.driver = {
>> +		.name = "qcom-lmh",
>> +		.of_match_table = lmh_table,
>> +	},
>> +};
>> +module_platform_driver(lmh_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("QCOM LMH driver");
> 
>                              LMh
> 
> 
> thanks.
> 


