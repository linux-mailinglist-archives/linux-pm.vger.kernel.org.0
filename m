Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F32F662788
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 14:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjAINpa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 08:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjAINp2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 08:45:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC91C430
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 05:45:25 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id f34so12989166lfv.10
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 05:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvUSGWczuNBt5YQ3dd4vN2QkkmhTjBPU6ml9QG3vmnM=;
        b=bWxkhgOOEodpI7A0oeixPL+IbQmjKA7ApWnpTyZ6QO3aBsBRGtTh7YZA/yqP8kgs8O
         bbC7/VD8reHaWxNKrxMRGdVDXEHXZ3RDAAdEA4MuudTcW8bIOjR3+MJQdoXfY3qfD58W
         R6AxenwncoUoNeuQ6aWAoazIAwhDkNuD5FXdvBGjqSv5ufhhocWYRIX2hSgQ3Xsja3Cr
         2MxdagThyww1wostA5PdLN6JDBFwsf0HhPikblGOxpsfMAxs5TV5L6njlvZbaA/Cn00K
         7/sEbzHc5w/oUm1XD8Axy1MY9gNceR5ENeMImLcrxMMC0JJ3Pwq+MCNgXRXcrHO3B1tg
         dC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvUSGWczuNBt5YQ3dd4vN2QkkmhTjBPU6ml9QG3vmnM=;
        b=gg+XDoiG9YXkDFXIWUzW1ALH8wFO3iyF/MnvfRJzPlcwoyKTgJ0vjtH9XaPwMne26F
         j4sH404eorUItjkszxjD+R5OIZZrFN9djLL0jX97esgk0IGtaLvYU04GZNVCTZbAmtoA
         EacJSaB0VL9XjHvPDorqaBqivJ7kM2GdjPspu2JzzLvpgUIWR21Iz1uGoNXxS5tWxJLs
         7IWwZaMzbRtaBW8T+d09bfQb2euBI7/tVJAiziGMc4FFUEt6AFBwZwHIQqCoIAo25Fz7
         43r+dyxKcNjHQM0r01xf+6sg1onXdJ0vjmgpNeHkNmiUVjEmFuMn5JQ0ycGUGT/pPBNO
         iF9A==
X-Gm-Message-State: AFqh2kqH9TfBpRbIKozLHkDJoGr5x0cjWtk/Hd42YNGod+WQYxgdo8BQ
        nxiYoz6e+A8c0PA4GSVZxyKuTw==
X-Google-Smtp-Source: AMrXdXvb1ny7ujKQABeTxtkz28fqKpCk9MDfbYSUOoxNjH1mxscD1LiXlAIEtgVN+ycRy60RCjxcww==
X-Received: by 2002:a05:6512:2828:b0:4b5:98ca:548 with SMTP id cf40-20020a056512282800b004b598ca0548mr22207427lfb.39.1673271923715;
        Mon, 09 Jan 2023 05:45:23 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id w17-20020a05651234d100b004cb1e2f8f4dsm1621788lfr.152.2023.01.09.05.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 05:45:23 -0800 (PST)
Message-ID: <0cb6efac-06b3-044a-c0e3-233c821e65ab@linaro.org>
Date:   Mon, 9 Jan 2023 14:45:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 04/12] interconnect: qcom: sm8150: Drop IP0
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
 <20230109002935.244320-5-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109002935.244320-5-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
>  drivers/interconnect/qcom/sm8150.c | 21 ---------------------
>  drivers/interconnect/qcom/sm8150.h |  4 ++--
>  3 files changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index df77d2f6215d..cea54477cfe3 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -1082,6 +1082,7 @@ EXPORT_SYMBOL_GPL(icc_provider_del);
>  static const struct of_device_id __maybe_unused ignore_list[] = {
>  	{ .compatible = "qcom,sc7180-ipa-virt" },
>  	{ .compatible = "qcom,sdx55-ipa-virt" },
> +	{ .compatible = "qcom,sm8150-ipa-virt" },
>  	{}
>  };
>  
> diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
> index 1d04a4bfea80..c5ab29322164 100644
> --- a/drivers/interconnect/qcom/sm8150.c
> +++ b/drivers/interconnect/qcom/sm8150.c
> @@ -56,7 +56,6 @@ DEFINE_QNODE(qnm_pcie, SM8150_MASTER_GEM_NOC_PCIE_SNOC, 1, 16, SM8150_SLAVE_LLCC
>  DEFINE_QNODE(qnm_snoc_gc, SM8150_MASTER_SNOC_GC_MEM_NOC, 1, 8, SM8150_SLAVE_LLCC);
>  DEFINE_QNODE(qnm_snoc_sf, SM8150_MASTER_SNOC_SF_MEM_NOC, 1, 16, SM8150_SLAVE_LLCC);
>  DEFINE_QNODE(qxm_ecc, SM8150_MASTER_ECC, 2, 32, SM8150_SLAVE_LLCC);
> -DEFINE_QNODE(ipa_core_master, SM8150_MASTER_IPA_CORE, 1, 8, SM8150_SLAVE_IPA_CORE);
>  DEFINE_QNODE(llcc_mc, SM8150_MASTER_LLCC, 4, 4, SM8150_SLAVE_EBI_CH0);
>  DEFINE_QNODE(qhm_mnoc_cfg, SM8150_MASTER_CNOC_MNOC_CFG, 1, 4, SM8150_SLAVE_SERVICE_MNOC);
>  DEFINE_QNODE(qxm_camnoc_hf0, SM8150_MASTER_CAMNOC_HF0, 1, 32, SM8150_SLAVE_MNOC_HF_MEM_NOC);
> @@ -139,7 +138,6 @@ DEFINE_QNODE(qns_ecc, SM8150_SLAVE_ECC, 1, 32);
>  DEFINE_QNODE(qns_gem_noc_snoc, SM8150_SLAVE_GEM_NOC_SNOC, 1, 8, SM8150_MASTER_GEM_NOC_SNOC);
>  DEFINE_QNODE(qns_llcc, SM8150_SLAVE_LLCC, 4, 16, SM8150_MASTER_LLCC);
>  DEFINE_QNODE(srvc_gemnoc, SM8150_SLAVE_SERVICE_GEM_NOC, 1, 4);
> -DEFINE_QNODE(ipa_core_slave, SM8150_SLAVE_IPA_CORE, 1, 8);
>  DEFINE_QNODE(ebi, SM8150_SLAVE_EBI_CH0, 4, 4);
>  DEFINE_QNODE(qns2_mem_noc, SM8150_SLAVE_MNOC_SF_MEM_NOC, 1, 32, SM8150_MASTER_MNOC_SF_MEM_NOC);
>  DEFINE_QNODE(qns_mem_noc_hf, SM8150_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SM8150_MASTER_MNOC_HF_MEM_NOC);
> @@ -172,7 +170,6 @@ DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_mem_noc);
>  DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
>  DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
>  DEFINE_QBCM(bcm_co1, "CO1", false, &qnm_npu);
> -DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
>  DEFINE_QBCM(bcm_cn0, "CN0", true, &qhm_spdm, &qnm_snoc, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy_south, &qhs_aop, &qhs_aoss, &qhs_camera_cfg, &qhs_clk_ctl, &qhs_compute_dsp, &qhs_cpr_cx, &qhs_cpr_mmcx, &qhs_cpr_mx, &qhs_crypto0_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_emac_cfg, &qhs_glm, &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_npu_cfg, &qhs_pcie0_cfg, &qhs_pcie1_cfg, &qhs_phy_refgen_north, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qspi, &qhs_qupv3_east, &qhs_qupv3_north, &qhs_qupv3_south, &qhs_sdc2, &qhs_sdc4, &qhs_snoc_cfg, &qhs_spdm, &qhs_spss_cfg, &qhs_ssc_cfg, &qhs_tcsr, &qhs_tlmm_east, &qhs_tlmm_north, &qhs_tlmm_south, &qhs_tlmm_west, &qhs_tsif, &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_usb3_1, &qhs_venus_cfg, &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc, &srvc_cnoc);
>  DEFINE_QBCM(bcm_qup0, "QUP0", false, &qhm_qup0, &qhm_qup1, &qhm_qup2);
>  DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
> @@ -398,22 +395,6 @@ static const struct qcom_icc_desc sm8150_gem_noc = {
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
> -static const struct qcom_icc_desc sm8150_ipa_virt = {
> -	.nodes = ipa_virt_nodes,
> -	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
> -	.bcms = ipa_virt_bcms,
> -	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
> -};
> -
>  static struct qcom_icc_bcm * const mc_virt_bcms[] = {
>  	&bcm_acv,
>  	&bcm_mc0,
> @@ -517,8 +498,6 @@ static const struct of_device_id qnoc_of_match[] = {
>  	  .data = &sm8150_dc_noc},
>  	{ .compatible = "qcom,sm8150-gem-noc",
>  	  .data = &sm8150_gem_noc},
> -	{ .compatible = "qcom,sm8150-ipa-virt",
> -	  .data = &sm8150_ipa_virt},
>  	{ .compatible = "qcom,sm8150-mc-virt",
>  	  .data = &sm8150_mc_virt},
>  	{ .compatible = "qcom,sm8150-mmss-noc",
> diff --git a/drivers/interconnect/qcom/sm8150.h b/drivers/interconnect/qcom/sm8150.h
> index 97996f64d799..023161681fb8 100644
> --- a/drivers/interconnect/qcom/sm8150.h
> +++ b/drivers/interconnect/qcom/sm8150.h
> @@ -35,7 +35,7 @@
>  #define SM8150_MASTER_GPU_TCU			24
>  #define SM8150_MASTER_GRAPHICS_3D		25
>  #define SM8150_MASTER_IPA			26
> -#define SM8150_MASTER_IPA_CORE			27
> +/* 27 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
>  #define SM8150_MASTER_LLCC			28
>  #define SM8150_MASTER_MDP_PORT0			29
>  #define SM8150_MASTER_MDP_PORT1			30
> @@ -94,7 +94,7 @@
>  #define SM8150_SLAVE_GRAPHICS_3D_CFG		83
>  #define SM8150_SLAVE_IMEM_CFG			84
>  #define SM8150_SLAVE_IPA_CFG			85
> -#define SM8150_SLAVE_IPA_CORE			86
> +/* 86 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
>  #define SM8150_SLAVE_LLCC			87
>  #define SM8150_SLAVE_LLCC_CFG			88
>  #define SM8150_SLAVE_MNOC_HF_MEM_NOC		89
