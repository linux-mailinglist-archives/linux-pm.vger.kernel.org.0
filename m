Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F79745AE6
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jul 2023 13:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjGCLVa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jul 2023 07:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjGCLVa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2023 07:21:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD0EE6
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 04:21:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so6675061e87.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Jul 2023 04:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688383285; x=1690975285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHh2OKB9/bYmAPh7Rs8RmaVfgXZOB5llGpcZfp5iwQc=;
        b=qhQhkFUoyeNj2aiRPapXgBpxOJL56bfQL7pNHuUuR4j1uyLQDHTUtcWI+lzsknhGpK
         CKLxDXfFehYTnhvbev6gaX8JQ65moaPhhbN6uutVMPjC8L2hvc66dS36PBBu8KTuOFal
         PjqfNpA24zozwXgKFwA0HZaATFPXQAz6IJKx5q4yCGs6+3sJvQi/zuskKRLA8+S0hmAw
         Aki4mcZAHFaenYLWllNzSB7rGX4FV4fIvAIeqxDFhdA1XBHDYbX3fdymzpoWr4+VLU5q
         z1xpuEHn5uKpSBvpF8O4ytN0F+0lJYpYd9wi4wvMmoulGkVY0sU6RFfL0Ph2Oe2/dX9c
         MiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688383285; x=1690975285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHh2OKB9/bYmAPh7Rs8RmaVfgXZOB5llGpcZfp5iwQc=;
        b=TwlYcp9TAlT8sbUoFiR8qZ2OXON5yWYf9U4J8S/wNm+Ms6zvJO749KbjIz/oFX181Y
         pdNgXFgBsG4L+49VQhH13f4JGwLl3ll3EWnqrHE8TaDGUt2JNHJOPDo7WI4QncFNQO+r
         zdetSWo6V5jXqzmx+SmgR+lj3iPEX+RSkfe9HQQbFCJzQIuV6o6cn4PAVbZf66HLQb8D
         KD/gcT28UY/Z7mVdKMqsfNVKS5CAYT2mBh2SrnZNcQrJ3xK5iMKGTmFVQCfjAGXk5AF2
         pP7iAocBLP1M7NTwD2D4gi3AjKA5YYWss1LznkNj5Jv4ZbpwRPKy5RE5P1ErgkXPidQS
         QjMA==
X-Gm-Message-State: ABy/qLaK9gZGm/kr9XUojFniWaa8JsSHlpgSbsSP3KBDn6eq2Gbz8q6m
        XtkW/g5arbFG4wkNIWpoeEZfHQ==
X-Google-Smtp-Source: APBJJlHCMCVI+091yp/4JUnz20G1Pumr2n+qkg34pUvK6YEapCzJ643yUrbjU0x7/sAsr6Hc23P4wA==
X-Received: by 2002:a05:6512:1141:b0:4f8:4216:e91f with SMTP id m1-20020a056512114100b004f84216e91fmr6476219lfg.63.1688383285365;
        Mon, 03 Jul 2023 04:21:25 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id c18-20020ac244b2000000b004fba770f45fsm1832305lfm.112.2023.07.03.04.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 04:21:24 -0700 (PDT)
Message-ID: <e6eacaa5-c505-b4ab-2854-b1feec563128@linaro.org>
Date:   Mon, 3 Jul 2023 13:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 08/28] soc: qcom: spm: add support for voltage
 regulator
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
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
 <20230702174246.121656-9-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230702174246.121656-9-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 2.07.2023 19:42, Dmitry Baryshkov wrote:
> The SPM / SAW2 device also provides a voltage regulator functionality
> with optional AVS (Adaptive Voltage Scaling) support. The exact register
> sequence and voltage ranges differs from device to device.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Looks like you didn't update this patch from v2

Konrad
>  drivers/soc/qcom/spm.c | 205 ++++++++++++++++++++++++++++++++++++++++-
>  include/soc/qcom/spm.h |   9 ++
>  2 files changed, 212 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> index a6cbeb40831b..3c16a7e1710c 100644
> --- a/drivers/soc/qcom/spm.c
> +++ b/drivers/soc/qcom/spm.c
> @@ -9,19 +9,31 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/linear_range.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> +#include <linux/bitfield.h>
>  #include <linux/err.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/smp.h>
>  #include <soc/qcom/spm.h>
>  
> +#define FIELD_SET(current, mask, val)	\
> +	(((current) & ~(mask)) | FIELD_PREP((mask), (val)))
> +
>  #define SPM_CTL_INDEX		0x7f
>  #define SPM_CTL_INDEX_SHIFT	4
>  #define SPM_CTL_EN		BIT(0)
>  
> +#define SPM_1_1_AVS_CTL_AVS_ENABLED BIT(27)
> +#define SPM_AVS_CTL_MIN_VLVL	(0x3f << 10)
> +#define SPM_AVS_CTL_MAX_VLVL	(0x3f << 17)
> +
>  enum spm_reg {
>  	SPM_REG_CFG,
>  	SPM_REG_SPM_CTL,
> @@ -31,10 +43,12 @@ enum spm_reg {
>  	SPM_REG_PMIC_DATA_1,
>  	SPM_REG_VCTL,
>  	SPM_REG_SEQ_ENTRY,
> -	SPM_REG_SPM_STS,
> +	SPM_REG_STS0,
> +	SPM_REG_STS1,
>  	SPM_REG_PMIC_STS,
>  	SPM_REG_AVS_CTL,
>  	SPM_REG_AVS_LIMIT,
> +	SPM_REG_RST,
>  	SPM_REG_NR,
>  };
>  
> @@ -171,6 +185,10 @@ static const struct spm_reg_data spm_reg_8226_cpu  = {
>  
>  static const u16 spm_reg_offset_v1_1[SPM_REG_NR] = {
>  	[SPM_REG_CFG]		= 0x08,
> +	[SPM_REG_STS0]		= 0x0c,
> +	[SPM_REG_STS1]		= 0x10,
> +	[SPM_REG_VCTL]		= 0x14,
> +	[SPM_REG_AVS_CTL]	= 0x18,
>  	[SPM_REG_SPM_CTL]	= 0x20,
>  	[SPM_REG_PMIC_DLY]	= 0x24,
>  	[SPM_REG_PMIC_DATA_0]	= 0x28,
> @@ -178,7 +196,12 @@ static const u16 spm_reg_offset_v1_1[SPM_REG_NR] = {
>  	[SPM_REG_SEQ_ENTRY]	= 0x80,
>  };
>  
> +static void smp_set_vdd_v1_1(void *data);
> +
>  /* SPM register data for 8064 */
> +static struct linear_range spm_v1_1_regulator_range =
> +	REGULATOR_LINEAR_RANGE(700000, 0, 56, 12500);
> +
>  static const struct spm_reg_data spm_reg_8064_cpu = {
>  	.reg_offset = spm_reg_offset_v1_1,
>  	.spm_cfg = 0x1F,
> @@ -189,6 +212,10 @@ static const struct spm_reg_data spm_reg_8064_cpu = {
>  		0x10, 0x54, 0x30, 0x0C, 0x24, 0x30, 0x0F },
>  	.start_index[PM_SLEEP_MODE_STBY] = 0,
>  	.start_index[PM_SLEEP_MODE_SPC] = 2,
> +	.set_vdd = smp_set_vdd_v1_1,
> +	.range = &spm_v1_1_regulator_range,
> +	.init_uV = 1300000,
> +	.ramp_delay = 1250,
>  };
>  
>  static inline void spm_register_write(struct spm_driver_data *drv,
> @@ -240,6 +267,179 @@ void spm_set_low_power_mode(struct spm_driver_data *drv,
>  	spm_register_write_sync(drv, SPM_REG_SPM_CTL, ctl_val);
>  }
>  
> +static int spm_set_voltage_sel(struct regulator_dev *rdev, unsigned int selector)
> +{
> +	struct spm_driver_data *drv = rdev_get_drvdata(rdev);
> +
> +	drv->volt_sel = selector;
> +
> +	/* Always do the SAW register writes on the corresponding CPU */
> +	return smp_call_function_single(drv->reg_cpu, drv->reg_data->set_vdd, drv, true);
> +}
> +
> +static int spm_get_voltage_sel(struct regulator_dev *rdev)
> +{
> +	struct spm_driver_data *drv = rdev_get_drvdata(rdev);
> +
> +	return drv->volt_sel;
> +}
> +
> +static const struct regulator_ops spm_reg_ops = {
> +	.set_voltage_sel	= spm_set_voltage_sel,
> +	.get_voltage_sel	= spm_get_voltage_sel,
> +	.list_voltage		= regulator_list_voltage_linear_range,
> +	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
> +};
> +
> +static void smp_set_vdd_v1_1(void *data)
> +{
> +	struct spm_driver_data *drv = data;
> +	unsigned int vlevel = drv->volt_sel;
> +	unsigned int vctl, data0, data1, avs_ctl, sts;
> +	bool avs_enabled;
> +
> +	vlevel |= 0x80; /* band */
> +
> +	avs_ctl = spm_register_read(drv, SPM_REG_AVS_CTL);
> +	vctl = spm_register_read(drv, SPM_REG_VCTL);
> +	data0 = spm_register_read(drv, SPM_REG_PMIC_DATA_0);
> +	data1 = spm_register_read(drv, SPM_REG_PMIC_DATA_1);
> +
> +	avs_enabled = avs_ctl & SPM_1_1_AVS_CTL_AVS_ENABLED;
> +
> +	/* If AVS is enabled, switch it off during the voltage change */
> +	if (avs_enabled) {
> +		avs_ctl &= ~SPM_1_1_AVS_CTL_AVS_ENABLED;
> +		spm_register_write(drv, SPM_REG_AVS_CTL, avs_ctl);
> +	}
> +
> +	/* Kick the state machine back to idle */
> +	spm_register_write(drv, SPM_REG_RST, 1);
> +
> +	vctl = FIELD_SET(vctl, 0xff, vlevel);
> +	data0 = FIELD_SET(data0, 0xff, vlevel);
> +	data1 = FIELD_SET(data1, 0x3f, vlevel);
> +	data1 = FIELD_SET(data1, 0x3f << 16, vlevel);
> +
> +	spm_register_write(drv, SPM_REG_VCTL, vctl);
> +	spm_register_write(drv, SPM_REG_PMIC_DATA_0, data0);
> +	spm_register_write(drv, SPM_REG_PMIC_DATA_1, data1);
> +
> +	if (read_poll_timeout_atomic(spm_register_read,
> +				      sts, sts == vlevel,
> +				      1, 200, false,
> +				      drv, SPM_REG_STS1)) {
> +		dev_err_ratelimited(drv->dev, "timeout setting the voltage (%x %x)!\n", sts, vlevel);
> +		goto enable_avs;
> +	}
> +
> +	if (avs_enabled) {
> +		unsigned int max_avs = vlevel & 0x3f;
> +		unsigned int min_avs = max(max_avs, 4U) - 4;
> +		avs_ctl = FIELD_SET(avs_ctl, SPM_AVS_CTL_MIN_VLVL, min_avs);
> +		avs_ctl = FIELD_SET(avs_ctl, SPM_AVS_CTL_MAX_VLVL, max_avs);
> +		spm_register_write(drv, SPM_REG_AVS_CTL, avs_ctl);
> +	}
> +
> +enable_avs:
> +	if (avs_enabled) {
> +		avs_ctl |= SPM_1_1_AVS_CTL_AVS_ENABLED;
> +		spm_register_write(drv, SPM_REG_AVS_CTL, avs_ctl);
> +	}
> +}
> +
> +static int spm_get_cpu(struct device *dev)
> +{
> +	int cpu;
> +	bool found;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct device_node *cpu_node, *saw_node;
> +
> +		cpu_node = of_cpu_device_node_get(cpu);
> +		if (!cpu_node)
> +			continue;
> +
> +		saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
> +		found = (saw_node == dev->of_node);
> +		of_node_put(saw_node);
> +		of_node_put(cpu_node);
> +
> +		if (found)
> +			return cpu;
> +	}
> +
> +	/* L2 SPM is not bound to any CPU, tie it to CPU0 */
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_REGULATOR
> +static int spm_register_regulator(struct device *dev, struct spm_driver_data *drv)
> +{
> +	struct regulator_config config = {
> +		.dev = dev,
> +		.driver_data = drv,
> +	};
> +	struct regulator_desc *rdesc;
> +	struct regulator_dev *rdev;
> +	int ret;
> +	bool found;
> +
> +	if (!drv->reg_data->set_vdd)
> +		return 0;
> +
> +	rdesc = devm_kzalloc(dev, sizeof(*rdesc), GFP_KERNEL);
> +	if (!rdesc)
> +		return -ENOMEM;
> +
> +	rdesc->name = "spm";
> +	rdesc->of_match = of_match_ptr("regulator");
> +	rdesc->type = REGULATOR_VOLTAGE;
> +	rdesc->owner = THIS_MODULE;
> +	rdesc->ops = &spm_reg_ops;
> +
> +	rdesc->linear_ranges = drv->reg_data->range;
> +	rdesc->n_linear_ranges = 1;
> +	rdesc->n_voltages = rdesc->linear_ranges[rdesc->n_linear_ranges - 1].max_sel + 1;
> +	rdesc->ramp_delay = drv->reg_data->ramp_delay;
> +
> +	drv->reg_cpu = spm_get_cpu(dev);
> +	dev_dbg(dev, "SAW2 bound to CPU %d\n", drv->reg_cpu);
> +
> +	/*
> +	 * Program initial voltage, otherwise registration will also try
> +	 * setting the voltage, which might result in undervolting the CPU.
> +	 */
> +	drv->volt_sel = DIV_ROUND_UP(drv->reg_data->init_uV - rdesc->min_uV,
> +				     rdesc->uV_step);
> +	ret = linear_range_get_selector_high(drv->reg_data->range,
> +					     drv->reg_data->init_uV,
> +					     &drv->volt_sel,
> +					     &found);
> +	if (ret) {
> +		dev_err(dev, "Initial uV value out of bounds\n");
> +		return ret;
> +	}
> +
> +	/* Always do the SAW register writes on the corresponding CPU */
> +	smp_call_function_single(drv->reg_cpu, drv->reg_data->set_vdd, drv, true);
> +
> +	rdev = devm_regulator_register(dev, rdesc, &config);
> +	if (IS_ERR(rdev)) {
> +		dev_err(dev, "failed to register regulator\n");
> +		return PTR_ERR(rdev);
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int spm_register_regulator(struct device *dev, struct spm_driver_data *drv)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static const struct of_device_id spm_match_table[] = {
>  	{ .compatible = "qcom,sdm660-gold-saw2-v4.1-l2",
>  	  .data = &spm_reg_660_gold_l2 },
> @@ -292,6 +492,7 @@ static int spm_dev_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  
>  	drv->reg_data = match_id->data;
> +	drv->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, drv);
>  
>  	/* Write the SPM sequences first.. */
> @@ -319,7 +520,7 @@ static int spm_dev_probe(struct platform_device *pdev)
>  	if (drv->reg_data->reg_offset[SPM_REG_SPM_CTL])
>  		spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
>  
> -	return 0;
> +	return spm_register_regulator(&pdev->dev, drv);
>  }
>  
>  static struct platform_driver spm_driver = {
> diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
> index 4951f9d8b0bd..9859ebe42003 100644
> --- a/include/soc/qcom/spm.h
> +++ b/include/soc/qcom/spm.h
> @@ -30,11 +30,20 @@ struct spm_reg_data {
>  	u32 avs_limit;
>  	u8 seq[MAX_SEQ_DATA];
>  	u8 start_index[PM_SLEEP_MODE_NR];
> +
> +	smp_call_func_t set_vdd;
> +	/* for now we support only a single range */
> +	struct linear_range *range;
> +	unsigned int ramp_delay;
> +	unsigned int init_uV;
>  };
>  
>  struct spm_driver_data {
>  	void __iomem *reg_base;
>  	const struct spm_reg_data *reg_data;
> +	struct device *dev;
> +	unsigned int volt_sel;
> +	int reg_cpu;
>  };
>  
>  void spm_set_low_power_mode(struct spm_driver_data *drv,
