Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D54171737E
	for <lists+linux-pm@lfdr.de>; Wed, 31 May 2023 04:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjEaCIV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 22:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjEaCIU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 22:08:20 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7DF118
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 19:08:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4db9987f8so538051e87.1
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 19:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685498897; x=1688090897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5iTXqtzGDHFLNxZV32WsXRFXjr4KXN2U3ND/5EGM83Y=;
        b=ypyCJC7GH8jeiNf4pyOhwKDsCMEo2q4WeURt84BgHrRahFsXwBJQNCEs4rWvGFQSv0
         3lqEb4LSMiftwHKT8sBbpXi4H+ThILu6CLd2eI0EzGOrX8UbVaA3T58RmIifJoF3B1lU
         RCBmz4+w8Y8nZxNiDnlQn2c1Msuq1KmO6JeBTLEXRsQ0wIITjD37Rj9mgRhI9cznsNXY
         jJJSuYWhLyCaZfBGKFimBQ84ObU/8p7dEN4X47d7or56NAhHd+3xlapJznuVsj2j99YK
         BJ/55j3u/ZMWvl4p2Lr/S6PhRQ7zQXIw+RASgAIswtcaG06/CaWEKqUJtI1SAxlvAgB0
         19Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685498897; x=1688090897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iTXqtzGDHFLNxZV32WsXRFXjr4KXN2U3ND/5EGM83Y=;
        b=b7SV1LEG6Rv/J1JrN0G0GBOxTP+zVOzfb1CWQNB6tf4d3XNN3P3sspVYHJz8lLkYX8
         JCUY9EMksJoCKoa+2WFSOE/X2oP9RXYO0R5HrlfIfNBFR6W2BLTwZUDkxs3sJSff0BUi
         AedgozZb31uUPnv/GONC0jsp9SUgMPOcEoa+qMkCLhO7x6KfpC/XxMcwUiXEGZDPRFwH
         WsGrIGzmL2Cd6z9OmJidB4PNBH2KVBdQ9MRqC9HTPdsowsF07hfiOR8UPnzBavhYYin0
         L1DVijqHM/YjumFIPeUkZDMlBfgz0bUupmWPNI9DdAX2c5gnCEUZvEVRpRiJnrwajbsx
         srPg==
X-Gm-Message-State: AC+VfDwngbhgNdV0I5DpYSoCIzBe2NdPEdO2v+VSXOXI7OitWdmjgKrC
        OLn/LWQqNRgqWtDhaItxI9qA4g==
X-Google-Smtp-Source: ACHHUZ7sSzuf0HhfEAr84cuSEr/jxLNJn7QGG4Q3HMrJbRvWhZwjkWFpG5x/xrM6bnd2xCXA0IsWig==
X-Received: by 2002:a05:6512:12c3:b0:4eb:4258:bf62 with SMTP id p3-20020a05651212c300b004eb4258bf62mr4666945lfg.8.1685498896738;
        Tue, 30 May 2023 19:08:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q10-20020ac25a0a000000b004f0199e8770sm522667lfn.65.2023.05.30.19.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 19:08:16 -0700 (PDT)
Message-ID: <e162134f-1c5d-d815-08af-b8633f709db9@linaro.org>
Date:   Wed, 31 May 2023 05:08:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v2 1/2] cpufreq: qcom-nvmem: add support for
 IPQ8074
Content-Language: en-GB
To:     Robert Marko <robimarko@gmail.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ilia.lin@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ansuelsmth@gmail.com
References: <20230530165807.642084-1-robimarko@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230530165807.642084-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/05/2023 19:58, Robert Marko wrote:
> IPQ8074 comes in 2 families:
> * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
> * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
> 
> So, in order to be able to share one OPP table lets add support for IPQ8074
> family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
> 
> IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
> will get created by NVMEM CPUFreq driver.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v2:
> * Print an error if SMEM ID is not part of the IPQ8074 family
> and restrict the speed to Acorn variant (1.4GHz)

My comments to the patch2 apply here too. Would it be possible to add 
separate dtsi files targeting each of these families?

If not, please change IPQ8074_foo_VERSIONS macros to the enum instead of 
BIT(n).

> ---
>   drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>   drivers/cpufreq/qcom-cpufreq-nvmem.c | 43 ++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index ea86c9f3ed7a..78f6ff933f93 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -170,6 +170,7 @@ static const struct of_device_id blocklist[] __initconst = {
>   	{ .compatible = "ti,am62a7", },
>   
>   	{ .compatible = "qcom,ipq8064", },
> +	{ .compatible = "qcom,ipq8074", },
>   	{ .compatible = "qcom,apq8064", },
>   	{ .compatible = "qcom,msm8974", },
>   	{ .compatible = "qcom,msm8960", },
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index a88b6fe5db50..ce444b5962f2 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -31,6 +31,9 @@
>   
>   #include <dt-bindings/arm/qcom,ids.h>
>   
> +#define IPQ8074_HAWKEYE_VERSION		BIT(0)
> +#define IPQ8074_ACORN_VERSION		BIT(1)
> +
>   struct qcom_cpufreq_drv;
>   
>   struct qcom_cpufreq_match_data {
> @@ -204,6 +207,41 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>   	return ret;
>   }
>   
> +static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
> +					     struct nvmem_cell *speedbin_nvmem,
> +					     char **pvs_name,
> +					     struct qcom_cpufreq_drv *drv)
> +{
> +	u32 msm_id;
> +	int ret;
> +	*pvs_name = NULL;
> +
> +	ret = qcom_smem_get_soc_id(&msm_id);
> +	if (ret)
> +		return ret;
> +
> +	switch (msm_id) {
> +	case QCOM_ID_IPQ8070A:
> +	case QCOM_ID_IPQ8071A:
> +		drv->versions = IPQ8074_ACORN_VERSION;
> +		break;
> +	case QCOM_ID_IPQ8072A:
> +	case QCOM_ID_IPQ8074A:
> +	case QCOM_ID_IPQ8076A:
> +	case QCOM_ID_IPQ8078A:
> +		drv->versions = IPQ8074_HAWKEYE_VERSION;
> +		break;
> +	default:
> +		dev_err(cpu_dev,
> +			"SoC ID %u is not part of IPQ8074 family, limiting to 1.4GHz!\n",
> +			msm_id);
> +		drv->versions = IPQ8074_ACORN_VERSION;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct qcom_cpufreq_match_data match_data_kryo = {
>   	.get_version = qcom_cpufreq_kryo_name_version,
>   };
> @@ -218,6 +256,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
>   	.genpd_names = qcs404_genpd_names,
>   };
>   
> +static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
> +	.get_version = qcom_cpufreq_ipq8074_name_version,
> +};
> +
>   static int qcom_cpufreq_probe(struct platform_device *pdev)
>   {
>   	struct qcom_cpufreq_drv *drv;
> @@ -363,6 +405,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>   	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
>   	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
>   	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
> +	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
>   	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
>   	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
>   	{ .compatible = "qcom,msm8960", .data = &match_data_krait },

-- 
With best wishes
Dmitry

