Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51372686203
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 09:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBAItE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 03:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjBAItB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 03:49:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99C919F26;
        Wed,  1 Feb 2023 00:48:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFBB8B8214A;
        Wed,  1 Feb 2023 08:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9320BC433EF;
        Wed,  1 Feb 2023 08:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675241325;
        bh=Cir3VKUhzPcJXeAeR+y9xNSuX+UtwK3Zfk0ejS8G3Rw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=amHVFbBlgLMs6+bhWvn0nEpAbzz2x1I8JLsRprU0o/lVMkUWPQ82swf5Eu8/m11kE
         Kj9QApSlE7qUmVkVmbBDy0CH/EY4BehoxryMSDo8fUFnLX2oR5bFJNGa0nBvI2az6w
         RqYm/sHnyoQuWp8YUqd9NgbGZMsJ/G5r+LVVUfNymI32+NR/0gkfjxfC1LoXR5Jba3
         WXTLzORbba/ulur2Zp7rjyNcdQqChkTgm2k+JpvZhSYvedVo8az/vDoP8N7W5Q04gP
         2+KaNjMev+E/ZAJ/6usOohO3vyM+eEGJY6LCxReISvN/7FoK+Y5NVrXh+NtNOjMbpp
         9H964tr6LD8eQ==
Message-ID: <5ecc68a6-2914-1059-460f-752adc1d3d01@kernel.org>
Date:   Wed, 1 Feb 2023 09:48:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] PM / devfreq: qcom: Introduce CCI devfreq driver
Content-Language: en-US
To:     Jun Nie <jun.nie@linaro.org>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc:     bryan.odonoghue@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230201080227.473547-1-jun.nie@linaro.org>
 <20230201080227.473547-2-jun.nie@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230201080227.473547-2-jun.nie@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/02/2023 09:02, Jun Nie wrote:
> Cache Coherent Interconnect (CCI) is used by some Qualcomm SoCs. This
> driver is introduced so that its freqency can be adjusted. And regulator
> associated with opp table can be also adjusted accordingly which is
> shared with cpu cluster.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You need to Cc Qualcomm subarch maintainers.

> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/devfreq/Kconfig    |   9 +++
>  drivers/devfreq/Makefile   |   1 +
>  drivers/devfreq/qcom-cci.c | 162 +++++++++++++++++++++++++++++++++++++

Who is going to maintain this file/driver?

>  3 files changed, 172 insertions(+)
>  create mode 100644 drivers/devfreq/qcom-cci.c
> 

(...)

> +
> +static int qcom_cci_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct qcom_cci *priv;
> +	const char *gov = DEVFREQ_GOV_USERSPACE;
> +	struct device_node *np = dev->of_node;
> +	struct nvmem_cell *speedbin_nvmem;
> +	int ret;
> +	u32 version;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		ret = PTR_ERR(priv->clk);
> +		dev_err(dev, "failed to fetch clk: %d\n", ret);
> +		return ret;

All these are just return dev_err_probe


> +	}
> +	platform_set_drvdata(pdev, priv);
> +
> +	/* Check whether we have profiled speed version per chip */
> +	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
> +	if (IS_ERR(speedbin_nvmem))
> +		return PTR_ERR(speedbin_nvmem);
> +
> +	version = qcom_get_dev_version(speedbin_nvmem);
> +	dev_info(dev, "%s: set opp table version 0x%x\n", __func__, version);

Drop __func__.

> +
> +	nvmem_cell_put(speedbin_nvmem);
> +	ret = dev_pm_opp_set_supported_hw(dev, &version, 1);
> +	if (ret) {
> +		dev_err(dev, "Failed to set supported hardware\n");

return dev_err_probe

> +		return ret;
> +	}
> +
> +	ret = dev_pm_opp_of_add_table(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get OPP table\n");
> +		return ret;

return dev_err_probe


> +	}
> +
> +	priv->profile.target = qcom_cci_target;
> +	priv->profile.exit = qcom_cci_exit;
> +	priv->profile.get_cur_freq = qcom_cci_get_cur_freq;
> +	priv->profile.initial_freq = clk_get_rate(priv->clk);
> +
> +	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
> +						gov, NULL);
> +	if (IS_ERR(priv->devfreq)) {
> +		ret = PTR_ERR(priv->devfreq);
> +		dev_err(dev, "failed to add devfreq device: %d\n", ret);


ret = dev_err_probe


> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	dev_pm_opp_of_remove_table(dev);
> +	return ret;
> +}
> +
> +static const struct of_device_id qcom_cci_of_match[] = {
> +	{ .compatible = "qcom,msm8939-cci"},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, qcom_cci_of_match);
> +
> +static struct platform_driver qcom_cci_platdrv = {
> +	.probe		= qcom_cci_probe,
> +	.driver = {
> +		.name	= "qcom-cci-devfreq",
> +		.of_match_table = qcom_cci_of_match,
> +	},
> +};
> +module_platform_driver(qcom_cci_platdrv);
> +
> +MODULE_DESCRIPTION("QCOM cci frequency scaling driver");
> +MODULE_AUTHOR("Jun Nie <jun.nie@linaro.org>");
> +MODULE_LICENSE("GPL");

Best regards,
Krzysztof

