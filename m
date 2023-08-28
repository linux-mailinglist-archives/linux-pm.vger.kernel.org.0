Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE12D78AE76
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 13:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjH1LHz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 07:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjH1LHc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 07:07:32 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD28ABE
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 04:07:29 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so15130981fa.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 04:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693220848; x=1693825648;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVyKhMPYbxxDZsbVVqtzl9C1WJS8LoUN1G1b49bSUuE=;
        b=vMUHL9JNQitPrPv5IrR2bgyofR78FRg04LBTfCZpwdB4/7vmFBcuZn6Oh4mScvbLUc
         wz/XlKpZAzhp2sNBWPrKBjBlGvFTKk0qhr/iV1d4oB1NoGzkCmUuW8d4H6GAKb9nXclk
         GczzMPFlheUJ2LGyBXc6M4HYo8mZcCqwtjuczwmTN3LBOfgf7Abbv/G2TOMP+ldGB8y9
         xa+6wYF9zmJe7Zitwy9U7HqUgzFiDLtHbJqtX45J9YepvMEsZAzk3L0/XVweG7JtbNXj
         GJGCljyDpQ0+93sxw8zPxoBgBa0kyO2mUF861v7BGbuXwDah2QPFM/fZq3DrjlaLBHx/
         Jz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693220848; x=1693825648;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVyKhMPYbxxDZsbVVqtzl9C1WJS8LoUN1G1b49bSUuE=;
        b=Y7lVhX1CIVXXonLgo27Rmlzl+nmNXSLsHhmLQkXJqo6KobXWDVR9tb3/Tu1+hu92RS
         KvC65vwEjikCiwUgoTZVTRpFd/GfnieppyDf7qLvTPInAUb3VZSemPUvSM76L4klqkn+
         iw90Ye8L5BNXHUMn5Iq7zZanQ9NiJVco4oxCsIbrTvAW30Nm9rqmoSuCjVs4ss/Hf/y5
         WDzt/3gYQONXvxbkWIGka3Hl8jptshp/SmQZ1WmMyPEYbcx4AILMQEMfHkxMQKFkXgUD
         fmI5u7gMzRCu6EXc9yDFiWLPf260/W60de0Bi0GgDbvvHFf3izxQH0BqIEAFj8AwxQ8U
         M2gQ==
X-Gm-Message-State: AOJu0YwFH+YkmcgJ3be62Fnu/A4jki8TNBmNjFojcE+lfdZ6vo4y3szh
        C2tPdCLlI+ddwZboWLZpRc0zbg==
X-Google-Smtp-Source: AGHT+IEFEznKnZlgUVLjUa71julJu1yhPfnHGBZoc4+kBV+F16R5b2USRiEi+lkfz+UnTLhaBOGnuA==
X-Received: by 2002:a2e:b0f4:0:b0:2bc:e827:a4f9 with SMTP id h20-20020a2eb0f4000000b002bce827a4f9mr8336164ljl.30.1693220848031;
        Mon, 28 Aug 2023 04:07:28 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id i4-20020a2e8084000000b002b9e0aeff68sm1697246ljg.95.2023.08.28.04.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 04:07:27 -0700 (PDT)
Message-ID: <73c0e457-ce2d-4fb5-9bc7-50e391c92230@linaro.org>
Date:   Mon, 28 Aug 2023 13:07:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] cpufreq: qcom-nvmem: create L2 cache device
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
 <20230827032803.934819-3-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230827032803.934819-3-dmitry.baryshkov@linaro.org>
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

On 27.08.2023 05:27, Dmitry Baryshkov wrote:
> Scaling the frequencies on some of Qualcomm Krait platforms (e.g.
> APQ8064) also requires scaling of the L2 cache frequency. As the
> l2-cache device node is places under /cpus/ path, it is not created by
> default by the OF code. Create corresponding device here.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 84d7033e5efe..f4c196ba4432 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
> @@ -377,6 +378,7 @@ static int __init qcom_cpufreq_init(void)
>  {
>  	struct device_node *np = of_find_node_by_path("/");
>  	const struct of_device_id *match;
> +	unsigned int cpu;
>  	int ret;
>  
>  	if (!np)
> @@ -387,6 +389,25 @@ static int __init qcom_cpufreq_init(void)
>  	if (!match)
>  		return -ENODEV;
>  
> +	for_each_possible_cpu(cpu) {
> +		struct device *dev = get_cpu_device(cpu);
> +		struct device_node *cache;
> +		struct platform_device *pdev;
Aaaalmost reverse-Christmas-tree :D

> +
> +		cache = of_find_next_cache_node(dev->of_node);
> +		if (!cache)
> +			continue;
> +
> +		if (of_device_is_compatible(cache, "qcom,krait-l2-cache")) {
> +			pdev = of_platform_device_create(cache, NULL, NULL);
> +			if (IS_ERR(pdev))
> +				pr_err("%s: %pe, failed to create L2 cache node\n", __func__, pdev);
The return value should be null-checked instead


> +			/* the error is not fatal */
"This error"?

Konrad
