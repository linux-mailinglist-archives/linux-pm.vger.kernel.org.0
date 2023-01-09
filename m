Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204BB66278B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 14:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjAINqC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 08:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjAINqB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 08:46:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530FD1C431
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 05:45:59 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g13so13024416lfv.7
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 05:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TeWMMLOf57kSw+Ir27S1+qWYo6FZWOWuVul+waNZSL8=;
        b=OmBWdUWRVj8ZcbqctZIi96BAaKecum2+dCS3uXnnMPCF2+IiEJ+bVUZ9u2cmjyGDwJ
         +y+EyeQirDql/qyJYN7VK0VQklTGmAuFtp/pjakPQWXA5PpahQigXCE++U3ztmP4H6X+
         O+qCTkvGuOnlz7esOox5VGFUjNvSUGo0rzx4R5Bc0ucABMCDjFFnLMNbF5NljlAR2m00
         gFmsK5JsoAN9xntbN4tbGr6mqk7fj7MrkjUkuD5sLiRFdkNfp7y62xLGXkd0Q9L1cufn
         JfDMHeO5DIYXiK/YpxIkZqPCRMKRNh/AqFxSaRfySw5blaKv0fNOkJxy1vl0F75wNV8M
         8hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeWMMLOf57kSw+Ir27S1+qWYo6FZWOWuVul+waNZSL8=;
        b=ke8pwofrftBUsinwZcqZLOAhFdpHM5/9GTPtAL4TkZ+e3JzsFP9k/Qi0OhKvVqK0ad
         LBFwu0CfsPJWiA0X3fXpkl8qVafeaO168L/qmxlhw/T9I0VcuEXFgKlIpLkcpB8IW8oK
         VHR0b2280NLOTyMjvcFVkVi+fvTMVDtYLoKv3GDXgQZsNNtVs4/UTpwKpbFHXopAVlkb
         FD0N5BU9NbYF5vCXV7B9hci1lO8LlZaCBDl54aUU7X4iFm7vyvyBxXIOY38dSBZfoFyk
         Tpo3SNhpZsncmiVtclpCww+yHH8GlVIT2aclk2LZuTdgedDteCvZVrBK+6y0R+NkbsZn
         Yu/A==
X-Gm-Message-State: AFqh2kpQvXRTgAHqUyS+gcZa7+sVwFDcNufkJwW2Jop+cKDG77+e2uKk
        6SWP7I8EJ4dlAxkCXXcR+XcFIA==
X-Google-Smtp-Source: AMrXdXvYNLO1vtxn2kC3AfhfcbND8oiwGHovXO1gMLqCsPexkvEnNR3SkTUxS+AMSnlzjsCGdj6Eqw==
X-Received: by 2002:a05:6512:39c6:b0:4cc:725d:9d3d with SMTP id k6-20020a05651239c600b004cc725d9d3dmr3180298lfu.54.1673271957714;
        Mon, 09 Jan 2023 05:45:57 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id t13-20020a195f0d000000b004b5774726dcsm1622147lfb.236.2023.01.09.05.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 05:45:57 -0800 (PST)
Message-ID: <e43b47fe-69e9-2a7b-0d3a-3423da75bdf3@linaro.org>
Date:   Mon, 9 Jan 2023 14:45:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 05/12] interconnect: qcom: sm8250: Drop IP0
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
 <20230109002935.244320-6-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109002935.244320-6-dmitry.baryshkov@linaro.org>
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
>  drivers/interconnect/core.c        |  1 +
>  drivers/interconnect/qcom/sm8250.c | 21 ---------------------
>  drivers/interconnect/qcom/sm8250.h |  4 ++--
>  3 files changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index cea54477cfe3..5b5fd436f23f 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -1083,6 +1083,7 @@ static const struct of_device_id __maybe_unused ignore_list[] = {
>  	{ .compatible = "qcom,sc7180-ipa-virt" },
>  	{ .compatible = "qcom,sdx55-ipa-virt" },
>  	{ .compatible = "qcom,sm8150-ipa-virt" },
> +	{ .compatible = "qcom,sm8250-ipa-virt" },
>  	{}
>  };
>  
> diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
> index 5cdb058fa095..e3bb008cb219 100644
> --- a/drivers/interconnect/qcom/sm8250.c
> +++ b/drivers/interconnect/qcom/sm8250.c
> @@ -51,7 +51,6 @@ DEFINE_QNODE(qnm_mnoc_sf, SM8250_MASTER_MNOC_SF_MEM_NOC, 2, 32, SM8250_SLAVE_LLC
>  DEFINE_QNODE(qnm_pcie, SM8250_MASTER_ANOC_PCIE_GEM_NOC, 1, 16, SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
>  DEFINE_QNODE(qnm_snoc_gc, SM8250_MASTER_SNOC_GC_MEM_NOC, 1, 8, SM8250_SLAVE_LLCC);
>  DEFINE_QNODE(qnm_snoc_sf, SM8250_MASTER_SNOC_SF_MEM_NOC, 1, 16, SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC, SM8250_SLAVE_MEM_NOC_PCIE_SNOC);
> -DEFINE_QNODE(ipa_core_master, SM8250_MASTER_IPA_CORE, 1, 8, SM8250_SLAVE_IPA_CORE);
>  DEFINE_QNODE(llcc_mc, SM8250_MASTER_LLCC, 4, 4, SM8250_SLAVE_EBI_CH0);
>  DEFINE_QNODE(qhm_mnoc_cfg, SM8250_MASTER_CNOC_MNOC_CFG, 1, 4, SM8250_SLAVE_SERVICE_MNOC);
>  DEFINE_QNODE(qnm_camnoc_hf, SM8250_MASTER_CAMNOC_HF, 2, 32, SM8250_SLAVE_MNOC_HF_MEM_NOC);
> @@ -138,7 +137,6 @@ DEFINE_QNODE(qns_sys_pcie, SM8250_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8, SM8250_MASTER_G
>  DEFINE_QNODE(srvc_even_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC_1, 1, 4);
>  DEFINE_QNODE(srvc_odd_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC_2, 1, 4);
>  DEFINE_QNODE(srvc_sys_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC, 1, 4);
> -DEFINE_QNODE(ipa_core_slave, SM8250_SLAVE_IPA_CORE, 1, 8);
>  DEFINE_QNODE(ebi, SM8250_SLAVE_EBI_CH0, 4, 4);
>  DEFINE_QNODE(qns_mem_noc_hf, SM8250_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SM8250_MASTER_MNOC_HF_MEM_NOC);
>  DEFINE_QNODE(qns_mem_noc_sf, SM8250_SLAVE_MNOC_SF_MEM_NOC, 2, 32, SM8250_MASTER_MNOC_SF_MEM_NOC);
> @@ -171,7 +169,6 @@ DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
>  DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
>  DEFINE_QBCM(bcm_mm0, "MM0", true, &qns_mem_noc_hf);
>  DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
> -DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
>  DEFINE_QBCM(bcm_mm1, "MM1", false, &qnm_camnoc_hf, &qxm_mdp0, &qxm_mdp1);
>  DEFINE_QBCM(bcm_sh2, "SH2", false, &alm_gpu_tcu, &alm_sys_tcu);
>  DEFINE_QBCM(bcm_mm2, "MM2", false, &qns_mem_noc_sf);
> @@ -386,22 +383,6 @@ static const struct qcom_icc_desc sm8250_gem_noc = {
>  	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
>  };
>  
> -static struct qcom_icc_bcm * const ipa_virt_bcms[] = {
> -	&bcm_ip0,
> -};
> -
> -static struct qcom_icc_node * const ipa_virt_nodes[] = {
> -	[MASTER_IPA_CORE] = &ipa_core_master,
> -	[SLAVE_IPA_CORE] = &ipa_core_slave,
> -};
> -
> -static const struct qcom_icc_desc sm8250_ipa_virt = {
> -	.nodes = ipa_virt_nodes,
> -	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
> -	.bcms = ipa_virt_bcms,
> -	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
> -};
> -
>  static struct qcom_icc_bcm * const mc_virt_bcms[] = {
>  	&bcm_acv,
>  	&bcm_mc0,
> @@ -531,8 +512,6 @@ static const struct of_device_id qnoc_of_match[] = {
>  	  .data = &sm8250_dc_noc},
>  	{ .compatible = "qcom,sm8250-gem-noc",
>  	  .data = &sm8250_gem_noc},
> -	{ .compatible = "qcom,sm8250-ipa-virt",
> -	  .data = &sm8250_ipa_virt},
>  	{ .compatible = "qcom,sm8250-mc-virt",
>  	  .data = &sm8250_mc_virt},
>  	{ .compatible = "qcom,sm8250-mmss-noc",
> diff --git a/drivers/interconnect/qcom/sm8250.h b/drivers/interconnect/qcom/sm8250.h
> index b31fb431a20f..e3fc56bc7ca0 100644
> --- a/drivers/interconnect/qcom/sm8250.h
> +++ b/drivers/interconnect/qcom/sm8250.h
> @@ -31,7 +31,7 @@
>  #define SM8250_MASTER_GPU_TCU			20
>  #define SM8250_MASTER_GRAPHICS_3D		21
>  #define SM8250_MASTER_IPA			22
> -#define SM8250_MASTER_IPA_CORE			23
> +/* 23 was used by MASTER_IPA_CORE, now represented as RPMh clock */
>  #define SM8250_MASTER_LLCC			24
>  #define SM8250_MASTER_MDP_PORT0			25
>  #define SM8250_MASTER_MDP_PORT1			26
> @@ -92,7 +92,7 @@
>  #define SM8250_SLAVE_GRAPHICS_3D_CFG		81
>  #define SM8250_SLAVE_IMEM_CFG			82
>  #define SM8250_SLAVE_IPA_CFG			83
> -#define SM8250_SLAVE_IPA_CORE			84
> +/* 84 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
>  #define SM8250_SLAVE_IPC_ROUTER_CFG		85
>  #define SM8250_SLAVE_ISENSE_CFG			86
>  #define SM8250_SLAVE_LLCC			87
