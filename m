Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA20501D4C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Apr 2022 23:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346459AbiDNVVX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Apr 2022 17:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245378AbiDNVVW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2022 17:21:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B97E6169
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 14:18:56 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r18so7628480ljp.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 14:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ufxYIOwf0J693O+/j0nztdscn7O3zFr17OcsXCTFd2A=;
        b=Zk6oHfUomwUd26LNJQK4KaU2ifbDnt/zijM3TxgAahrDWK010devX3SknCi4s/XrEH
         oy4r8mL84+4zTzAU8VSaWWH5qeRz42KVA783zXnCpTQOlFiG7JkiWfboSGbgaD/PbFuZ
         Iqv2z1Fwk5hdYim/ya0Pv56zidniWDo88+0xuGJThORubgRolgqNlJtvZxGgYY1N/6wC
         OjV7LoJiYUq5ZlAOO2jgRUu26sEDg4IWZNskZkc/sUyWFx7N9SSMGLTkfX5ZuSd5Wool
         pMjJh3Ky2x1xckyyh/zLmbO7BajES4LvZxc5GNrGI2BeQJcRpCYLctVdR+BicaFjigOw
         u95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ufxYIOwf0J693O+/j0nztdscn7O3zFr17OcsXCTFd2A=;
        b=qj/GjCieP+a25vK78yg09DDlpU/dGsQ6GiSeRaUiGgceFCZx4z9z9/RWWs/m3cwX0F
         iySBWEfqs3+3/BEURqIG+Tgez4kDbKJyfw+Z5kox6KPIgSN9mUUWYe53nGf3lAk4lMVO
         0Dn3CuPkAbdDXvtWXL8OhlsVZlOzSfawEM8CAwsOeSGG3ztGtpscEzlYKgDwf6RixSTg
         EFqP//SctpZiiG9PctsJes1CPJdAz5QiAx6j8+/BXXoc3dOhoGDJvN100vgKW1YCB5cA
         SA9iZYzB9GQ+K8b/0P+i9HG0okidoN4+wbTBP5F3Ll0CHPOZmsTZUN198W2AIvz+7YK+
         UbFg==
X-Gm-Message-State: AOAM531tcEBeyoLZHY8Qkzl+qHD2oxhEvyscEy65kLCAPGvJbFxUuQ1U
        bmT57jOj4IduthjM9liyQE0Wcg==
X-Google-Smtp-Source: ABdhPJyIPE/Lbzs1ZBnIcuuv9dXN0SCDY55qJ+MFI/XPq9gB4WFlhElfu5uB1F9JSt//Cy5lkYATKw==
X-Received: by 2002:a05:651c:893:b0:249:4023:3818 with SMTP id d19-20020a05651c089300b0024940233818mr2748589ljq.44.1649971134550;
        Thu, 14 Apr 2022 14:18:54 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s6-20020ac25fa6000000b0044313e88020sm111871lfe.202.2022.04.14.14.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 14:18:54 -0700 (PDT)
Message-ID: <d9afa206-7f57-81bb-8c69-5928dccd41b5@linaro.org>
Date:   Fri, 15 Apr 2022 00:18:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 3/5] input: misc: pm8941-pwrkey: add support for PON
 GEN3 base addresses
Content-Language: en-GB
To:     Anjelique Melendez <quic_amelende@quicinc.com>,
        dmitry.torokhov@gmail.com, corbet@lwn.net, sre@kernel.org,
        robh+dt@kernel.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, collinsd@codeaurora.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        skakit@codeaurora.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20220411200506.22891-1-quic_amelende@quicinc.com>
 <20220411200506.22891-4-quic_amelende@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220411200506.22891-4-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/04/2022 23:05, Anjelique Melendez wrote:
> Currently, PON address is read from the "reg" property. For PON GEN3,
> which starts with PMK8350, the "reg" property will have both the PON
> HLOS and PON PBS addesses defined. Add support so that all PON
> generations can be configured.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/input/misc/pm8941-pwrkey.c | 31 +++++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
> index e0240db12d4f..43106e4cfd23 100644
> --- a/drivers/input/misc/pm8941-pwrkey.c
> +++ b/drivers/input/misc/pm8941-pwrkey.c
> @@ -12,6 +12,7 @@
>   #include <linux/log2.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/of_address.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/reboot.h>
> @@ -44,6 +45,7 @@ struct pm8941_data {
>   	unsigned int	status_bit;
>   	bool		supports_ps_hold_poff_config;
>   	bool		supports_debounce_config;
> +	bool		has_pon_pbs;
>   	const char	*name;
>   	const char	*phys;
>   };
> @@ -52,6 +54,7 @@ struct pm8941_pwrkey {
>   	struct device *dev;
>   	int irq;
>   	u32 baseaddr;
> +	u32 pon_pbs_baseaddr;
>   	struct regmap *regmap;
>   	struct input_dev *input;
>   
> @@ -167,6 +170,8 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>   	struct pm8941_pwrkey *pwrkey;
>   	bool pull_up;
>   	struct device *parent;
> +	struct device_node *regmap_node;
> +	const __be32 *addr;
>   	u32 req_delay;
>   	int error;
>   
> @@ -188,8 +193,10 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>   	pwrkey->data = of_device_get_match_data(&pdev->dev);
>   
>   	parent = pdev->dev.parent;
> +	regmap_node = pdev->dev.of_node;
>   	pwrkey->regmap = dev_get_regmap(parent, NULL);
>   	if (!pwrkey->regmap) {
> +		regmap_node = parent->of_node;
>   		/*
>   		 * We failed to get regmap for parent. Let's see if we are
>   		 * a child of pon node and read regmap and reg from its
> @@ -200,15 +207,21 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>   			dev_err(&pdev->dev, "failed to locate regmap\n");
>   			return -ENODEV;
>   		}
> +	}
>   
> -		error = of_property_read_u32(parent->of_node,
> -					     "reg", &pwrkey->baseaddr);
> -	} else {
> -		error = of_property_read_u32(pdev->dev.of_node, "reg",
> -					     &pwrkey->baseaddr);
> +	addr = of_get_address(regmap_node, 0, NULL, NULL);
> +	if (!addr) {
> +		dev_err(&pdev->dev, "reg property missing\n");
> +		return -EINVAL;
> +	}
> +	pwrkey->baseaddr = be32_to_cpup(addr);
> +
> +	if (pwrkey->data->has_pon_pbs) {
> +		/* PON_PBS base address is optional */
> +		addr = of_get_address(regmap_node, 1, NULL, NULL);
> +		if (addr)
> +			pwrkey->pon_pbs_baseaddr = be32_to_cpup(addr);
>   	}
> -	if (error)
> -		return error;
>   
>   	pwrkey->irq = platform_get_irq(pdev, 0);
>   	if (pwrkey->irq < 0)
> @@ -316,6 +329,7 @@ static const struct pm8941_data pwrkey_data = {
>   	.phys = "pm8941_pwrkey/input0",
>   	.supports_ps_hold_poff_config = true,
>   	.supports_debounce_config = true,
> +	.has_pon_pbs = false,
>   };
>   
>   static const struct pm8941_data resin_data = {
> @@ -325,6 +339,7 @@ static const struct pm8941_data resin_data = {
>   	.phys = "pm8941_resin/input0",
>   	.supports_ps_hold_poff_config = true,
>   	.supports_debounce_config = true,
> +	.has_pon_pbs = false,

No need to declare that a field is false. Just skip this completely.

>   };
>   
>   static const struct pm8941_data pon_gen3_pwrkey_data = {
> @@ -333,6 +348,7 @@ static const struct pm8941_data pon_gen3_pwrkey_data = {
>   	.phys = "pmic_pwrkey/input0",
>   	.supports_ps_hold_poff_config = false,
>   	.supports_debounce_config = false,
> +	.has_pon_pbs = true,
>   };
>   
>   static const struct pm8941_data pon_gen3_resin_data = {
> @@ -341,6 +357,7 @@ static const struct pm8941_data pon_gen3_resin_data = {
>   	.phys = "pmic_resin/input0",
>   	.supports_ps_hold_poff_config = false,
>   	.supports_debounce_config = false,
> +	.has_pon_pbs = true,
>   };
>   
>   static const struct of_device_id pm8941_pwr_key_id_table[] = {


-- 
With best wishes
Dmitry
