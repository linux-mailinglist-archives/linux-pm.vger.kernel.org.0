Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C37466279D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 14:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjAINrM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 08:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbjAINqr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 08:46:47 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3289A1C439
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 05:46:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bp15so13002906lfb.13
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 05:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dzpj24jf9RpxQI+H6xrFSNuIAG8zDeKNesu/MCzMfw=;
        b=xmIFSOgvwxaDKhy/YRLTuYHZJjqDxUm9lLVy2xHGKt279HjsQlsko0bEOhRKeKkSe8
         94tMNE2V/3/EG11YMMYw12PWzyefvGLLpUrquT6nJZC/b0vJrrps04dLDML5VIz8DYEk
         FS4PG8UT3oR3cRRc5G+uhz/cy42PHXDwQuw2JoXGOo0yEyaMtMdrer+x67BLnwR5yOmk
         dPAW/AyqFrylvBxwLwZ/uEZOuvFRjSygf7ccNG5e7cA5wIerKVHvxpYmIqCqG+AE0sd2
         wJuPnlwlizAUOptwd1NBk8hKmDoVPXBE1k7M/2Xsvw4PmcSMJZT7O7q6dOQRyJnDesxD
         DS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dzpj24jf9RpxQI+H6xrFSNuIAG8zDeKNesu/MCzMfw=;
        b=CoEHzo2SGpRnEZT7u08IvwLjqLSGyBOCQ/n+HRkDCU7cu0sDEqb8ajeDladPoZa2Wh
         3dor18jHxqbSI1OGa6HAX0hZFn9RqvqwDiN61WsrmUmlifUSaiqv1QcSuyOEA4+f8GKR
         7RSdkxERtHPoRYvGNwG/2ecjTjSiKgpYv/DIxNjuToEkFplFaNXb6NBNNEPt8D2byppO
         h6z1mTb2cmdTd1OR6GLuyXuc7t3+y55bTuOjn36t5x5ti+HGxbjCko5EjFfpLKnMChEc
         y7adZMsGdi0ZhjfJdRbZVFcW8A2XYNUVrOcYxqlRa0DeiNBivhc3DdrO29efkO2CdYKi
         yAXQ==
X-Gm-Message-State: AFqh2krAVnBeSxp/mQuJmiaYXPbGAbhdVWNidn3Fi/cdV0nU+rASwekw
        BCNYtDWT8U+fLlvkXUnKGpwNPw==
X-Google-Smtp-Source: AMrXdXu6zIH4kW1H+zgM63Od3vPsNJ62ovOvF89bNmcEmjTfsX4upG6Ss2WSbs0mSHnhSxwQbIz25Q==
X-Received: by 2002:a05:6512:3e10:b0:4b5:c489:8cf8 with SMTP id i16-20020a0565123e1000b004b5c4898cf8mr20337420lfv.61.1673272003480;
        Mon, 09 Jan 2023 05:46:43 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id z3-20020a0565120c0300b004cb03999979sm1631168lfu.40.2023.01.09.05.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 05:46:43 -0800 (PST)
Message-ID: <672320ab-f899-01dd-0f39-3edaf3a04e79@linaro.org>
Date:   Mon, 9 Jan 2023 14:46:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 06/12] interconnect: qcom: sc8180x: Drop IP0
 interconnects
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>, Alex Elder <elder@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
 <20230109002935.244320-7-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109002935.244320-7-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9.01.2023 01:29, Dmitry Baryshkov wrote:
> Similar to the sdx55 and sc7180, let's drop the MASTER_IPA_CORE and
> SLAVE_IPA_CORE interconnects for this platofm.
platform

 There are no actual users
> of this intercoonect.
interconnect

 The IP0 resource will be handled by clk-rpmh
> driver.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/interconnect/core.c         |  1 +
>  drivers/interconnect/qcom/sc8180x.c | 38 -----------------------------
>  drivers/interconnect/qcom/sc8180x.h |  4 +--
>  3 files changed, 3 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 5b5fd436f23f..0f392f59b135 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -1081,6 +1081,7 @@ EXPORT_SYMBOL_GPL(icc_provider_del);
>  
>  static const struct of_device_id __maybe_unused ignore_list[] = {
>  	{ .compatible = "qcom,sc7180-ipa-virt" },
> +	{ .compatible = "qcom,sc8180x-ipa-virt" },
>  	{ .compatible = "qcom,sdx55-ipa-virt" },
>  	{ .compatible = "qcom,sm8150-ipa-virt" },
>  	{ .compatible = "qcom,sm8250-ipa-virt" },
> diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
> index 0f515bf10bd7..c76e3a6a98cd 100644
> --- a/drivers/interconnect/qcom/sc8180x.c
> +++ b/drivers/interconnect/qcom/sc8180x.c
> @@ -469,15 +469,6 @@ static struct qcom_icc_node mas_qxm_ecc = {
>  	.links = { SC8180X_SLAVE_LLCC }
>  };
>  
> -static struct qcom_icc_node mas_ipa_core_master = {
> -	.name = "mas_ipa_core_master",
> -	.id = SC8180X_MASTER_IPA_CORE,
> -	.channels = 1,
> -	.buswidth = 8,
> -	.num_links = 1,
> -	.links = { SC8180X_SLAVE_IPA_CORE }
> -};
> -
>  static struct qcom_icc_node mas_llcc_mc = {
>  	.name = "mas_llcc_mc",
>  	.id = SC8180X_MASTER_LLCC,
> @@ -1201,13 +1192,6 @@ static struct qcom_icc_node slv_srvc_gemnoc1 = {
>  	.buswidth = 4
>  };
>  
> -static struct qcom_icc_node slv_ipa_core_slave = {
> -	.name = "slv_ipa_core_slave",
> -	.id = SC8180X_SLAVE_IPA_CORE,
> -	.channels = 1,
> -	.buswidth = 8
> -};
> -
>  static struct qcom_icc_node slv_ebi = {
>  	.name = "slv_ebi",
>  	.id = SC8180X_SLAVE_EBI_CH0,
> @@ -1524,11 +1508,6 @@ static struct qcom_icc_bcm bcm_co2 = {
>  	.nodes = { &mas_qnm_npu }
>  };
>  
> -static struct qcom_icc_bcm bcm_ip0 = {
> -	.name = "IP0",
> -	.nodes = { &slv_ipa_core_slave }
> -};
> -
>  static struct qcom_icc_bcm bcm_sn3 = {
>  	.name = "SN3",
>  	.keepalive = true,
> @@ -1604,10 +1583,6 @@ static struct qcom_icc_bcm * const gem_noc_bcms[] = {
>  	&bcm_sh3,
>  };
>  
> -static struct qcom_icc_bcm * const ipa_virt_bcms[] = {
> -	&bcm_ip0,
> -};
> -
>  static struct qcom_icc_bcm * const mc_virt_bcms[] = {
>  	&bcm_mc0,
>  	&bcm_acv,
> @@ -1766,11 +1741,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
>  	[SLAVE_SERVICE_GEM_NOC_1] = &slv_srvc_gemnoc1,
>  };
>  
> -static struct qcom_icc_node * const ipa_virt_nodes[] = {
> -	[MASTER_IPA_CORE] = &mas_ipa_core_master,
> -	[SLAVE_IPA_CORE] = &slv_ipa_core_slave,
> -};
> -
>  static struct qcom_icc_node * const mc_virt_nodes[] = {
>  	[MASTER_LLCC] = &mas_llcc_mc,
>  	[SLAVE_EBI_CH0] = &slv_ebi,
> @@ -1857,13 +1827,6 @@ static const struct qcom_icc_desc sc8180x_gem_noc  = {
>  	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
>  };
>  
> -static const struct qcom_icc_desc sc8180x_ipa_virt  = {
> -	.nodes = ipa_virt_nodes,
> -	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
> -	.bcms = ipa_virt_bcms,
> -	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
> -};
> -
>  static const struct qcom_icc_desc sc8180x_mc_virt  = {
>  	.nodes = mc_virt_nodes,
>  	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
> @@ -1913,7 +1876,6 @@ static const struct of_device_id qnoc_of_match[] = {
>  	{ .compatible = "qcom,sc8180x-config-noc", .data = &sc8180x_config_noc },
>  	{ .compatible = "qcom,sc8180x-dc-noc", .data = &sc8180x_dc_noc },
>  	{ .compatible = "qcom,sc8180x-gem-noc", .data = &sc8180x_gem_noc },
> -	{ .compatible = "qcom,sc8180x-ipa-virt", .data = &sc8180x_ipa_virt },
>  	{ .compatible = "qcom,sc8180x-mc-virt", .data = &sc8180x_mc_virt },
>  	{ .compatible = "qcom,sc8180x-mmss-noc", .data = &sc8180x_mmss_noc },
>  	{ .compatible = "qcom,sc8180x-qup-virt", .data = &sc8180x_qup_virt },
> diff --git a/drivers/interconnect/qcom/sc8180x.h b/drivers/interconnect/qcom/sc8180x.h
> index 2eafd35543c7..c138dcd350f1 100644
> --- a/drivers/interconnect/qcom/sc8180x.h
> +++ b/drivers/interconnect/qcom/sc8180x.h
> @@ -51,7 +51,7 @@
>  #define SC8180X_MASTER_SNOC_GC_MEM_NOC		41
>  #define SC8180X_MASTER_SNOC_SF_MEM_NOC		42
>  #define SC8180X_MASTER_ECC			43
> -#define SC8180X_MASTER_IPA_CORE			44
> +/* 44 was used by MASTER_IPA_CORE, now represented as RPMh clock */
>  #define SC8180X_MASTER_LLCC			45
>  #define SC8180X_MASTER_CNOC_MNOC_CFG		46
>  #define SC8180X_MASTER_CAMNOC_HF0		47
> @@ -146,7 +146,7 @@
>  #define SC8180X_SLAVE_LLCC			136
>  #define SC8180X_SLAVE_SERVICE_GEM_NOC		137
>  #define SC8180X_SLAVE_SERVICE_GEM_NOC_1		138
> -#define SC8180X_SLAVE_IPA_CORE			139
> +/* 139 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
>  #define SC8180X_SLAVE_EBI_CH0			140
>  #define SC8180X_SLAVE_MNOC_SF_MEM_NOC		141
>  #define SC8180X_SLAVE_MNOC_HF_MEM_NOC		142
