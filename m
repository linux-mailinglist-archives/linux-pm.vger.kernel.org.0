Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92793A0A05
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 04:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFIC1e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 22:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhFIC1e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 22:27:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8ABC061574;
        Tue,  8 Jun 2021 19:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=NVOiE3q6n5OsUVCkyojOeuEAHuYE4AwOawABwQR+Mqc=; b=lx6V32UvTTqvxs+P5oCSs2xW8s
        tnPptJ9ZrYpGEQkBvFb8fFRB3LBjWYXW5YovxpLIHyv36eVRmmRe8YqCAgrsyoDpnY/0zcAPh5wFJ
        HtpsfoFDz7OE8N88GRvtkVUQ+kVFnz49IXpZbaRI3/132fkrGu+EXzSGQJMC+4xJPW7stFn7xa9N4
        aDZCO7AoQo6zYpbxSvEOh3mFRhsDIMGTiMPC6k9SdaSczATbB9XElUeDXt5JqeVlMl5w6ZmKFck7r
        Atnq0j/h7AUMFOeiT9CoXOX1mqoeginATA/+cgVnM2IV9uQ5DNcC+8aLZZwlm32pqA7oBFJ1VdSx+
        xgk5NFuw==;
Received: from [2601:1c0:6280:3f0::bd57]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqnuV-00BQno-UV; Wed, 09 Jun 2021 02:25:40 +0000
Subject: Re: [PATCH 2/5] thermal: qcom: Add support for LMh driver
To:     Thara Gopinath <thara.gopinath@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210608222926.2707768-1-thara.gopinath@linaro.org>
 <20210608222926.2707768-3-thara.gopinath@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <531fae77-f037-5e4a-be1e-ce21618fbd9d@infradead.org>
Date:   Tue, 8 Jun 2021 19:25:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608222926.2707768-3-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/8/21 3:29 PM, Thara Gopinath wrote:
> Driver enabling various pieces of Limits Management Hardware(LMh) for cpu
> cluster0 and cpu cluster1 namely kick starting monitoring of temperature,
> current, battery current violations, enabling reliability algorithm and
> setting up various temperature limits.
> 
> The following has been explained in the cover letter. I am including this
> here so that this remains in the commit message as well.
> 
> LMh is a hardware infrastructure on some Qualcomm SoCs that can enforce
> temperature and current limits as programmed by software for certain IPs
> like CPU. On many newer SoCs LMh is configured by firmware/TZ and no
> programming is needed from the kernel side. But on certain SoCs like sdm845
> the firmware does not do a complete programming of the h/w. On such SoCs
> kernel software has to explicitly set up the temperature limits and turn on
> various monitoring and enforcing algorithms on the hardware.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/thermal/qcom/Kconfig  |  10 ++
>  drivers/thermal/qcom/Makefile |   1 +
>  drivers/thermal/qcom/lmh.c    | 244 ++++++++++++++++++++++++++++++++++
>  3 files changed, 255 insertions(+)
>  create mode 100644 drivers/thermal/qcom/lmh.c
> 
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index 8d5ac2df26dc..c95b95e254d7 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -31,3 +31,13 @@ config QCOM_SPMI_TEMP_ALARM
>  	  trip points. The temperature reported by the thermal sensor reflects the
>  	  real time die temperature if an ADC is present or an estimate of the
>  	  temperature based upon the over temperature stage value.
> +
> +config QCOM_LMH
> +	tristate "Qualcomm Limits Management Hardware"
> +	depends on ARCH_QCOM
> +	help
> +	  This enables initialization of Qualcomm limits management
> +	  hardware(LMh). LMh allows for h/w enforced mitigation for cpus based on

	                                hardware-enforced           CPUs

> +	  input from temperature and current sensors.  On many newer Qualcomm SoCs
> +	  LMH is configure in the firmware and this feature need not be enabled.

	  LMh

> +	  However, on certain SoCs like sdm845 LMH has to be configured from HLOS.

	                                       LMh

What is HLOS?


> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
> new file mode 100644
> index 000000000000..8741a36cb674
> --- /dev/null
> +++ b/drivers/thermal/qcom/lmh.c
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (C) 2021, Linaro Limited. All rights reserved.
> + */

[snip]

> +static int lmh_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	struct device_node *np;
> +	struct lmh_hw_data *lmh_data;
> +	u32 node_id;
> +	int ret;
> +
> +	dev = &pdev->dev;
> +	np = dev->of_node;
> +	if (!np)
> +		return -EINVAL;
> +
> +	lmh_data = devm_kzalloc(dev, sizeof(*lmh_data), GFP_KERNEL);
> +	if (!lmh_data)
> +		return -ENOMEM;
> +
> +	lmh_data->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(lmh_data->base))
> +		return PTR_ERR(lmh_data->base);
> +
> +	ret = of_property_read_u32(np, "qcom,lmh-cpu-id", &lmh_data->cpu_id);
> +	if (ret)
> +		return -ENODEV;
> +
> +	/*
> +	 * Only sdm845 has lmh hardware currently enabled from hlos. If this is needed
> +	 * for other platforms, revisit this to check if the <cpu-id, node-id> should be part
> +	 * of a dt match table.
> +	 */
> +	if (lmh_data->cpu_id == 0) {
> +		node_id = LMH_CLUSTER0_NODE_ID;
> +	} else if (lmh_data->cpu_id == 4) {
> +		node_id = LMH_CLUSTER1_NODE_ID;
> +	} else {
> +		dev_err(dev, "Wrong cpu id associated with lmh node\n");

		                    CPU                    LMh

> +		return -EINVAL;
> +	}
> +
> +	/* Payload size is five bytes for now */
> +	lmh_data->payload_size = 5 * sizeof(u32);
> +
> +	platform_set_drvdata(pdev, lmh_data);
> +
> +	if (!qcom_scm_lmh_dcvsh_available())
> +		return -EINVAL;
> +
> +	/* Enable Thermal Algorithm */
> +	update_payload(lmh_data, LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1);
> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
> +		return ret;
> +	}
> +
> +	/* Enable Current Sensing Algorithm */
> +	update_payload(lmh_data, LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1);
> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error %d enabling current subfunction\n", ret);
> +		return ret;
> +	}
> +
> +	/* Enable Reliability Algorithm */
> +	update_payload(lmh_data, LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1);
> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
> +		return ret;
> +	}
> +
> +	/* Enable BCL Algorithm */
> +	update_payload(lmh_data, LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1);
> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error %d enabling BCL subfunction\n", ret);

What is BCL?

> +		return ret;
> +	}
> +
> +	ret = qcom_scm_lmh_profile_change(0x1);
> +	if (ret) {
> +		dev_err(dev, "Error %d changing profile\n", ret);
> +		return ret;
> +	}
> +
> +	/* Set default thermal trips */
> +	update_payload(lmh_data, LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, LMH_TH_ARM_TEMP);
> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error setting thermal ARM thershold%d\n", ret);

		                                        threshold

> +		return ret;
> +	}
> +
> +	update_payload(lmh_data, LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, LMH_TH_HI_TEMP);
> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error setting thermal HI thershold%d\n", ret);

		                                       threshold

> +		return ret;
> +	}
> +	update_payload(lmh_data, LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, LMH_TH_LOW_TEMP);
> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error setting thermal ARM thershold%d\n", ret);

		                                        threshold

> +		return ret;
> +	}
> +
> +	lmh_data->irq = platform_get_irq(pdev, 0);
> +	lmh_data->domain = irq_domain_add_linear(np, 1, &lmh_irq_ops, lmh_data);
> +	if (!lmh_data->domain) {
> +		dev_err(dev, "Error adding irq_domain\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
> +			       IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_SUSPEND,
> +			       "lmh-irq", lmh_data);
> +	if (ret) {
> +		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
> +		irq_domain_remove(lmh_data->domain);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static const struct of_device_id lmh_table[] = {
> +	{ .compatible = "qcom,msm-hw-limits", },
> +	{},
> +};
> +
> +static struct platform_driver lmh_driver = {
> +	.probe = lmh_probe,
> +	.driver = {
> +		.name = "qcom-lmh",
> +		.of_match_table = lmh_table,
> +	},
> +};
> +module_platform_driver(lmh_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("QCOM LMH driver");

                            LMh


thanks.
-- 
~Randy

