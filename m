Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9111F72A6F8
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jun 2023 02:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjFJAOv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jun 2023 20:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjFJAOt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2023 20:14:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2D335BE;
        Fri,  9 Jun 2023 17:14:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 157FC6424C;
        Sat, 10 Jun 2023 00:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B54C433EF;
        Sat, 10 Jun 2023 00:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686356087;
        bh=KrcLbB7SmNUxRy8U/TG329U42wcgeQxwfCDRJvUdGZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=haDeLcPr+E8CC4ALAD5S2uv95JaoCGIqMbin6vpwdRsLnceynLBVRZ4LvvyenTn2u
         CugzsmgfBi9UmIdWjfINm0TwQVNQrRgr7xaqNflvBYkVl2SaoLpo5/1ZuD49HB5rPS
         p6VysZs0gT06hXaMDusxt3QSqPBCcZNOmB/hoepYVYvMLqLdmrVUoUdxzcKiE/iMIR
         E9yC/qGeT2C3iz/j/ESjiQd4HOJgEH6KCf69QBOfFEegYj2NDSBSCKV+0Z03HPqZIY
         dE2PcT5nhT7Yd9J6dAeso8YRH9+yJiCneH8pKJO8qxbKrvagHIac9Ah9VDJsd7PRrU
         EaKCaWljvKG3A==
Date:   Fri, 9 Jun 2023 17:18:15 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 3/4] clk: qcom: cbf-msm8996: scale CBF clock according
 to the CPUfreq
Message-ID: <20230610001815.zgo23zlwo3z6e3y6@ripper>
References: <20230512001334.2983048-1-dmitry.baryshkov@linaro.org>
 <20230512001334.2983048-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512001334.2983048-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 12, 2023 at 03:13:33AM +0300, Dmitry Baryshkov wrote:
> Turn CBF into the interconnect provider. Scale CBF frequency (bandwidth)
> according to CPU frequencies.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Georgi,

Dmitry tells me that you picked up the interconnect patches, I don't see
an immutable branch in your tree with them, but this patch has a build
time dependency on them. Could you please pick this through your tree as
well?

Acked-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/Kconfig        |  1 +
>  drivers/clk/qcom/clk-cbf-8996.c | 60 ++++++++++++++++++++++++++++++++-
>  2 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 12be3e2371b3..85869e7a9f16 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -48,6 +48,7 @@ config QCOM_CLK_APCS_MSM8916
>  config QCOM_CLK_APCC_MSM8996
>  	tristate "MSM8996 CPU Clock Controller"
>  	select QCOM_KRYO_L2_ACCESSORS
> +	select INTERCONNECT_CLK if INTERCONNECT
>  	depends on ARM64
>  	help
>  	  Support for the CPU clock controller on msm8996 devices.
> diff --git a/drivers/clk/qcom/clk-cbf-8996.c b/drivers/clk/qcom/clk-cbf-8996.c
> index cfd567636f4e..1e23b734abb3 100644
> --- a/drivers/clk/qcom/clk-cbf-8996.c
> +++ b/drivers/clk/qcom/clk-cbf-8996.c
> @@ -5,11 +5,15 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
> +#include <linux/interconnect-clk.h>
> +#include <linux/interconnect-provider.h>
>  #include <linux/of.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
> +#include <dt-bindings/interconnect/qcom,msm8996-cbf.h>
> +
>  #include "clk-alpha-pll.h"
>  #include "clk-regmap.h"
>  
> @@ -223,6 +227,49 @@ static const struct regmap_config cbf_msm8996_regmap_config = {
>  	.val_format_endian	= REGMAP_ENDIAN_LITTLE,
>  };
>  
> +#ifdef CONFIG_INTERCONNECT
> +
> +/* Random ID that doesn't clash with main qnoc and OSM */
> +#define CBF_MASTER_NODE 2000
> +
> +static int qcom_msm8996_cbf_icc_register(struct platform_device *pdev, struct clk_hw *cbf_hw)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct clk *clk = devm_clk_hw_get_clk(dev, cbf_hw, "cbf");
> +	const struct icc_clk_data data[] = {
> +		{ .clk = clk, .name = "cbf", },
> +	};
> +	struct icc_provider *provider;
> +
> +	provider = icc_clk_register(dev, CBF_MASTER_NODE, ARRAY_SIZE(data), data);
> +	if (IS_ERR(provider))
> +		return PTR_ERR(provider);
> +
> +	platform_set_drvdata(pdev, provider);
> +
> +	return 0;
> +}
> +
> +static int qcom_msm8996_cbf_icc_remove(struct platform_device *pdev)
> +{
> +	struct icc_provider *provider = platform_get_drvdata(pdev);
> +
> +	icc_clk_unregister(provider);
> +
> +	return 0;
> +}
> +#define qcom_msm8996_cbf_icc_sync_state icc_sync_state
> +#else
> +static int qcom_msm8996_cbf_icc_register(struct platform_device *pdev,  struct clk_hw *cbf_hw)
> +{
> +	dev_warn(&pdev->dev, "CONFIG_INTERCONNECT is disabled, CBF clock is fixed\n");
> +
> +	return 0;
> +}
> +#define qcom_msm8996_cbf_icc_remove(pdev) (0)
> +#define qcom_msm8996_cbf_icc_sync_state NULL
> +#endif
> +
>  static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
>  {
>  	void __iomem *base;
> @@ -281,7 +328,16 @@ static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &cbf_mux.clkr.hw);
> +	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &cbf_mux.clkr.hw);
> +	if (ret)
> +		return ret;
> +
> +	return qcom_msm8996_cbf_icc_register(pdev, &cbf_mux.clkr.hw);
> +}
> +
> +static int qcom_msm8996_cbf_remove(struct platform_device *pdev)
> +{
> +	return qcom_msm8996_cbf_icc_remove(pdev);
>  }
>  
>  static const struct of_device_id qcom_msm8996_cbf_match_table[] = {
> @@ -292,9 +348,11 @@ MODULE_DEVICE_TABLE(of, qcom_msm8996_cbf_match_table);
>  
>  static struct platform_driver qcom_msm8996_cbf_driver = {
>  	.probe = qcom_msm8996_cbf_probe,
> +	.remove = qcom_msm8996_cbf_remove,
>  	.driver = {
>  		.name = "qcom-msm8996-cbf",
>  		.of_match_table = qcom_msm8996_cbf_match_table,
> +		.sync_state = qcom_msm8996_cbf_icc_sync_state,
>  	},
>  };
>  
> -- 
> 2.39.2
> 
