Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151EB78AE68
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 13:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjH1LEz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 07:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjH1LEf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 07:04:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D14BE
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 04:04:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500b0f06136so2608920e87.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 04:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693220671; x=1693825471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmMR63i69wE8/b9RkFpou+l6zEGQJ7lmmfXhEmNqTjY=;
        b=i9CNeWehusZdR30wSYSORX/eK/HNKfb/HYIPLSK37pTt2uWHh87K6PKD/R0FfJoQkV
         5Un6NGPJKEOKRc2UCLvKYRPGfNe+74QzlaV9lEmeaUKU5EMhRsIkZ4ok0bXqbrPrK9zn
         lbEmrULA4Gjq3Ri3a1V8N2Nmls1VBsV9T0zES0WUrmV6hACv/SuAZmvfQQd2r5MbkR7j
         6r4+8361TNhDpETZKcsEYk5ndIGXaCHLrq33V+vYUoayGRzLRM+bd/F+89LLoODHl4DF
         VY1iQl5+omyk0VQ9ALKOxg6B2v73qOzTvsSKk9PWuOb2bvUzZjYlc1UXOh0B1PBOzWOm
         OpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693220671; x=1693825471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmMR63i69wE8/b9RkFpou+l6zEGQJ7lmmfXhEmNqTjY=;
        b=hnljyEbWbEyUuSBm2kSUiVsV7/HNCR1T6CetjnvVQH01vID7PrZr5jNVOXyizU4NrQ
         ntQKH9fTIcgt0tP6Xe06BsdLbpvv/jpI0AjibyaKPczLFqHN//nRCnlEE7+MXAbH5VRF
         vFXuHiMA5oXjL8aTnA1z4MfMjF5N0b7BhVqbgwXRZba8mdZNrNx642lFR50JVlxkRzrt
         tECHkVzUKLuulQk240u86wvTZBguD22H9wHkNL7sr5cifb5JrcmRsG7ZYk5tmU2Jx2xe
         OYiJPrSrJvMC0M+lrlra1FPAX+abYXPuXCn9wXaAkxABVcRQTPWxPPwKDwILRPQ8gR3r
         MyMw==
X-Gm-Message-State: AOJu0YzUq7fxUR7hSWeIHUxRaxdxKBSTRmSuUskKaUDNYoX8b75hc8ET
        x//uVJzx029T6UyPO6ofLVx4Og==
X-Google-Smtp-Source: AGHT+IEW8at6c7DdFsHCNACWwN5LiMnAyoT6lrVD62kzT/hOk/P6D9CD0W37S2TbtsNAF+33pUiE+Q==
X-Received: by 2002:a05:6512:313b:b0:500:81fa:46f1 with SMTP id p27-20020a056512313b00b0050081fa46f1mr13487265lfd.67.1693220670922;
        Mon, 28 Aug 2023 04:04:30 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id d17-20020ac244d1000000b0050096cc3ba1sm1531586lfm.255.2023.08.28.04.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 04:04:30 -0700 (PDT)
Message-ID: <8a7af8ce-3ff4-4520-b4e2-dd39570ca796@linaro.org>
Date:   Mon, 28 Aug 2023 13:04:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] cpufreq: qcom-nvmem: provide separate
 configuration data for apq8064
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
References: <20230827032803.934819-1-dmitry.baryshkov@linaro.org>
 <20230827032803.934819-6-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230827032803.934819-6-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27.08.2023 05:28, Dmitry Baryshkov wrote:
> APQ8064 can scale core voltage according to the frequency needs. Rather
> than reusing the A/B format multiplexer, use a simple fuse parsing
> function and configure required regulator.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 49 ++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 81c080b854fe..35e2610c9526 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -26,6 +26,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/smem.h>
>  
> @@ -39,6 +40,7 @@ struct qcom_cpufreq_match_data {
>  			   char **pvs_name,
>  			   struct qcom_cpufreq_drv *drv);
>  	const char **genpd_names;
> +	const char * const *regulator_names;
>  };
>  
>  struct qcom_cpufreq_drv {
> @@ -203,6 +205,34 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>  	return ret;
>  }
>  
> +static int qcom_cpufreq_apq8064_name_version(struct device *cpu_dev,
> +					     struct nvmem_cell *speedbin_nvmem,
> +					     char **pvs_name,
> +					     struct qcom_cpufreq_drv *drv)
> +{
> +	int speed = 0, pvs = 0;
> +	u8 *speedbin;
> +	size_t len;
> +	int ret = 0;
Unused, just return 0

> +
> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);
> +
> +	if (len != 4)
> +		return -EINVAL;
> +
> +	get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
> +
> +	snprintf(*pvs_name, sizeof("speedXX-pvsXX"), "speed%d-pvs%d",
> +		 speed, pvs);
speed and pvs are both one hex digit long at best (see masking in
get_krait_bin_format_a)

Konrad
