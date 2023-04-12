Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F016E0005
	for <lists+linux-pm@lfdr.de>; Wed, 12 Apr 2023 22:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDLUlU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Apr 2023 16:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDLUlT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2023 16:41:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CF44EC5
        for <linux-pm@vger.kernel.org>; Wed, 12 Apr 2023 13:41:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y4so13086066ljq.9
        for <linux-pm@vger.kernel.org>; Wed, 12 Apr 2023 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681332076; x=1683924076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qlLoupxyOcbuZO1f+pTlXDNuIDRKQGPW1F/qouBF8z8=;
        b=ewmAYjyP9GCb8dcY0pY/L7s2ETYui0zcjujMCJVK5EmP2/B20ECQ+YB/XLQ/ttRmCk
         gfZwZb0Lht1LEx2+n3eGt3vOod8swCR0sGPHCYlQ3X3hAirjveH5ZvysrKO2XQS9n8qG
         +VXZWLzo+3mA7ftCaVOW5w5BF51/ZZ05pAqFRpJIFuHsRL1OfYrRodpH6vHNEN/1/YNo
         pAofdCzPJaOn4SxLopFffXMAGwQ6km9/YCz4sge9tUtHtfmyjH0FLDQ7u4m5sTA9WXWr
         wZClh3kEbQ3iH8ODuagOK2MMjpey1sIAUGddkOT/s9HURIfxACkOG703suU2pfQZop2n
         g2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681332076; x=1683924076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qlLoupxyOcbuZO1f+pTlXDNuIDRKQGPW1F/qouBF8z8=;
        b=OC2MCRDIpR1RstnObEaWyz+08R3FCVJpJPQns7OYZAgl77am9+imA856liqcJe9shb
         lUqeA8Avh00EArNLO/hdCQjm63SyFlRtZF1KJUBgVkqHMTBdeAcTmX6wm4sQbd8Adc5E
         vuuungNC4NDGvOmhAjwV+5JKh4WYsmePdRM2e2aI2s2fv+QqyWhjKTakwgs4Mw4JKsCo
         OmJ97MN70iLcCf5cI2Iro2JbsouM8/eVQldYbxXgYN010zbcYWKIWlI75e/cnLcn+V6/
         VQPhtVZ1y6W6edrcUCdXiQNJBicos6XnXpdmHAXuGs1biHlWgGLsKBPqEjWYeRkR2Eqx
         vM6w==
X-Gm-Message-State: AAQBX9fuS0f6/pdZBD4nw3VaUKE+uLd5lFkxMaJi2P6MJ/JkQWlOBoRA
        R7WjVbvpPf9uEyZNqejwimAQFg==
X-Google-Smtp-Source: AKy350b6lNRcBYDdrNH+7OvXajk7bbZMKS+WlFCqcfJS/3UIVNaizilzXlj35ezuCgvq8fHqTYplmw==
X-Received: by 2002:a2e:9602:0:b0:2a6:1e50:ba42 with SMTP id v2-20020a2e9602000000b002a61e50ba42mr5612018ljh.48.1681332075959;
        Wed, 12 Apr 2023 13:41:15 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id x28-20020a05651c105c00b0029ab1f2b196sm3417678ljm.24.2023.04.12.13.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 13:41:15 -0700 (PDT)
Message-ID: <6aba6924-18c4-fb2d-68ce-65fae07018ab@linaro.org>
Date:   Wed, 12 Apr 2023 22:41:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 3/4] clk: qcom: cbf-msm8996: scale CBF clock according
 to the CPUfreq
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230410200014.432418-1-dmitry.baryshkov@linaro.org>
 <20230410200014.432418-4-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230410200014.432418-4-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10.04.2023 22:00, Dmitry Baryshkov wrote:
> Turn CBF into the interconnect provider. Scale CBF frequency (bandwidth)
> according to CPU frequencies.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig        |  1 +
>  drivers/clk/qcom/clk-cbf-8996.c | 59 ++++++++++++++++++++++++++++++++-
>  2 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 449bc8314d21..475f4997d79f 100644
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
> index cfd567636f4e..1bb2cd956d68 100644
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
> @@ -223,6 +227,48 @@ static const struct regmap_config cbf_msm8996_regmap_config = {
>  	.val_format_endian	= REGMAP_ENDIAN_LITTLE,
>  };
>  
> +#ifdef CONFIG_INTERCONNECT
> +
> +/* Random ID that doesn't clash with main qnoc and OSM */
> +#define CBF_MASTER_NODE 2000
Man, this clearly should have been equal 8996 :P

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
> +#else
> +static int qcom_msm8996_cbf_icc_register(struct platform_device *pdev,  struct clk_hw *cbf_hw)
> +{
> +	dev_warn(&pdev->dev, "interconnects support is disabled, CBF clock is fixed\n");
s/interconnects/interconnect

or

s/interconnects support/CONFIG_INTERCONNECT

> +
> +	return 0;
> +}
> +#define qcom_msm8996_cbf_icc_remove(pdev) (0)
> +#define qcom_msm8996_cbf_icc_sync_state(dev) (0)
> +#endif
> +
>  static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
>  {
>  	void __iomem *base;
> @@ -281,7 +327,16 @@ static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
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
> @@ -292,9 +347,11 @@ MODULE_DEVICE_TABLE(of, qcom_msm8996_cbf_match_table);
>  
>  static struct platform_driver qcom_msm8996_cbf_driver = {
>  	.probe = qcom_msm8996_cbf_probe,
> +	.remove = qcom_msm8996_cbf_remove,
.remove_new?

With that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  	.driver = {
>  		.name = "qcom-msm8996-cbf",
>  		.of_match_table = qcom_msm8996_cbf_match_table,
> +		.sync_state = icc_sync_state,
>  	},
>  };
>  
