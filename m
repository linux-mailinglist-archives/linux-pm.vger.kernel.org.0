Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D14660186
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 14:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjAFNrj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 08:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjAFNri (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 08:47:38 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6E0625CF
        for <linux-pm@vger.kernel.org>; Fri,  6 Jan 2023 05:47:36 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id bp26so1016446ilb.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2023 05:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7myXiQbz2iQLcApwn64cL+RwgcoCUWn5+KFX7+AlAI=;
        b=pHa06kLigOoSKmp9h+1WzbNb1QmqZ2giITkuUj8OHl5yrZ8E+HPCmVFf7UtrvzXmsV
         blQW6WqggiMQhQy0+JLcp43u92img6QCs5zNcOm8EW/ogIourqB4+44Vb3w+dadEsBi2
         VFBrIqlY+LYkyy3r2uCIg3N3J4dLmLwfdoDCPBdgKPjpJvXiEYJnxAfo97UyhtGXvpOE
         Yqx9QLEtN74zffdijgYOigHJtlgva6Bqv+XJR6eb2OBl+OyNLOj1xhcx7ppgYk4rFGH1
         wXaDhqxi6cB8bawtZ9I6yEdTOr6+xfSqjSjGzM1Vo6TFj1Mm/9odu0UItqogZXrB81Dl
         NyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7myXiQbz2iQLcApwn64cL+RwgcoCUWn5+KFX7+AlAI=;
        b=dFcBJ6p5yKRFp37Fo3ceHfAcja44pYg5XjgNBueLoJnnGNfQ0ub7FXZOTMBSNr3BFq
         JFTmlHU8Z5mMBj5OdvGOXT9XAQAztjbcm6v2ZwHN8tFHk0RhrC2qx0G52yE3Aj/RqcAG
         XiivBv30g7VxoZz3EF0Xbk0SPslt/HpI7XuRFrd/S55IdPvOxhIMbscSBfhoWd3N3MYj
         PBJYWDJ93WjIsClq6OWvi/TyK/93gb1y1CdFAjS7rfUu+F3GwzvQK2mLKHbmw17Igg60
         dtv9z6XnqWsfiekxIszIGuIEvCzZ25+sr806Yc5ekkYsAkKOz2GliLCTFpjsBgaBZyWy
         w/DA==
X-Gm-Message-State: AFqh2kreeIpU3aiUyAAj8t8Bct8NRk35hPSD9vIIv/Wwdk0rB5bUud3a
        Cw4bn0/uin5aY61Zgtn/83XvIw==
X-Google-Smtp-Source: AMrXdXvam1vI26bEzJTwkFVpNtWvKbbyoDyu5wlg+BElKDeX66VTOu7kIoPChw9Xxw3fJqeje1WYjw==
X-Received: by 2002:a92:dc8d:0:b0:30c:4c54:87f4 with SMTP id c13-20020a92dc8d000000b0030c4c5487f4mr11786124iln.3.1673012856286;
        Fri, 06 Jan 2023 05:47:36 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id f4-20020a056e0204c400b0030d6f952221sm375488ils.75.2023.01.06.05.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 05:47:35 -0800 (PST)
Message-ID: <8ab4a081-3295-7786-24d8-1ed7999ce588@linaro.org>
Date:   Fri, 6 Jan 2023 07:47:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/9] interconnect: qcom: sm8150: Drop IP0 interconnects
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
 <20230106073313.1720029-5-dmitry.baryshkov@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20230106073313.1720029-5-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/6/23 1:33 AM, Dmitry Baryshkov wrote:
> Similar to the sdx55 and sc7180, let's drop the IP0 interconnects here
> because the IP0 resource is also used in the clk-rpmh.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

For the interconnects that are already (also) represented by
RPMH clocks, I believe the interconnects are never used.  So
I *think* it would be better to remove these first, possibly
even as a bug fix (?).

Similarly, for the three others you're converting to be
represented as clocks, I don't think they're used (yet?),
so you could remove those before redefining as clocks too.

Please explain to me if I'm misunderstanding.

					-Alex

> ---
>   drivers/interconnect/qcom/sm8150.c | 21 ---------------------
>   drivers/interconnect/qcom/sm8150.h |  2 --
>   2 files changed, 23 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
> index 1d04a4bfea80..c5ab29322164 100644
> --- a/drivers/interconnect/qcom/sm8150.c
> +++ b/drivers/interconnect/qcom/sm8150.c
> @@ -56,7 +56,6 @@ DEFINE_QNODE(qnm_pcie, SM8150_MASTER_GEM_NOC_PCIE_SNOC, 1, 16, SM8150_SLAVE_LLCC
>   DEFINE_QNODE(qnm_snoc_gc, SM8150_MASTER_SNOC_GC_MEM_NOC, 1, 8, SM8150_SLAVE_LLCC);
>   DEFINE_QNODE(qnm_snoc_sf, SM8150_MASTER_SNOC_SF_MEM_NOC, 1, 16, SM8150_SLAVE_LLCC);
>   DEFINE_QNODE(qxm_ecc, SM8150_MASTER_ECC, 2, 32, SM8150_SLAVE_LLCC);
> -DEFINE_QNODE(ipa_core_master, SM8150_MASTER_IPA_CORE, 1, 8, SM8150_SLAVE_IPA_CORE);
>   DEFINE_QNODE(llcc_mc, SM8150_MASTER_LLCC, 4, 4, SM8150_SLAVE_EBI_CH0);
>   DEFINE_QNODE(qhm_mnoc_cfg, SM8150_MASTER_CNOC_MNOC_CFG, 1, 4, SM8150_SLAVE_SERVICE_MNOC);
>   DEFINE_QNODE(qxm_camnoc_hf0, SM8150_MASTER_CAMNOC_HF0, 1, 32, SM8150_SLAVE_MNOC_HF_MEM_NOC);
> @@ -139,7 +138,6 @@ DEFINE_QNODE(qns_ecc, SM8150_SLAVE_ECC, 1, 32);
>   DEFINE_QNODE(qns_gem_noc_snoc, SM8150_SLAVE_GEM_NOC_SNOC, 1, 8, SM8150_MASTER_GEM_NOC_SNOC);
>   DEFINE_QNODE(qns_llcc, SM8150_SLAVE_LLCC, 4, 16, SM8150_MASTER_LLCC);
>   DEFINE_QNODE(srvc_gemnoc, SM8150_SLAVE_SERVICE_GEM_NOC, 1, 4);
> -DEFINE_QNODE(ipa_core_slave, SM8150_SLAVE_IPA_CORE, 1, 8);
>   DEFINE_QNODE(ebi, SM8150_SLAVE_EBI_CH0, 4, 4);
>   DEFINE_QNODE(qns2_mem_noc, SM8150_SLAVE_MNOC_SF_MEM_NOC, 1, 32, SM8150_MASTER_MNOC_SF_MEM_NOC);
>   DEFINE_QNODE(qns_mem_noc_hf, SM8150_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SM8150_MASTER_MNOC_HF_MEM_NOC);
> @@ -172,7 +170,6 @@ DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_mem_noc);
>   DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
>   DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
>   DEFINE_QBCM(bcm_co1, "CO1", false, &qnm_npu);
> -DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
>   DEFINE_QBCM(bcm_cn0, "CN0", true, &qhm_spdm, &qnm_snoc, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy_south, &qhs_aop, &qhs_aoss, &qhs_camera_cfg, &qhs_clk_ctl, &qhs_compute_dsp, &qhs_cpr_cx, &qhs_cpr_mmcx, &qhs_cpr_mx, &qhs_crypto0_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_emac_cfg, &qhs_glm, &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_npu_cfg, &qhs_pcie0_cfg, &qhs_pcie1_cfg, &qhs_phy_refgen_north, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qspi, &qhs_qupv3_east, &qhs_qupv3_north, &qhs_qupv3_south, &qhs_sdc2, &qhs_sdc4, &qhs_snoc_cfg, &qhs_spdm, &qhs_spss_cfg, &qhs_ssc_cfg, &qhs_tcsr, &qhs_tlmm_east, &qhs_tlmm_north, &qhs_tlmm_south, &qhs_tlmm_west, &qhs_tsif, &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_usb3_1, &qhs_venus_cfg, &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc, &srvc_cnoc);
>   DEFINE_QBCM(bcm_qup0, "QUP0", false, &qhm_qup0, &qhm_qup1, &qhm_qup2);
>   DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
> @@ -398,22 +395,6 @@ static const struct qcom_icc_desc sm8150_gem_noc = {
>   	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
>   };
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
>   static struct qcom_icc_bcm * const mc_virt_bcms[] = {
>   	&bcm_acv,
>   	&bcm_mc0,
> @@ -517,8 +498,6 @@ static const struct of_device_id qnoc_of_match[] = {
>   	  .data = &sm8150_dc_noc},
>   	{ .compatible = "qcom,sm8150-gem-noc",
>   	  .data = &sm8150_gem_noc},
> -	{ .compatible = "qcom,sm8150-ipa-virt",
> -	  .data = &sm8150_ipa_virt},
>   	{ .compatible = "qcom,sm8150-mc-virt",
>   	  .data = &sm8150_mc_virt},
>   	{ .compatible = "qcom,sm8150-mmss-noc",
> diff --git a/drivers/interconnect/qcom/sm8150.h b/drivers/interconnect/qcom/sm8150.h
> index 97996f64d799..1120b1a9fddc 100644
> --- a/drivers/interconnect/qcom/sm8150.h
> +++ b/drivers/interconnect/qcom/sm8150.h
> @@ -35,7 +35,6 @@
>   #define SM8150_MASTER_GPU_TCU			24
>   #define SM8150_MASTER_GRAPHICS_3D		25
>   #define SM8150_MASTER_IPA			26
> -#define SM8150_MASTER_IPA_CORE			27
>   #define SM8150_MASTER_LLCC			28
>   #define SM8150_MASTER_MDP_PORT0			29
>   #define SM8150_MASTER_MDP_PORT1			30
> @@ -94,7 +93,6 @@
>   #define SM8150_SLAVE_GRAPHICS_3D_CFG		83
>   #define SM8150_SLAVE_IMEM_CFG			84
>   #define SM8150_SLAVE_IPA_CFG			85
> -#define SM8150_SLAVE_IPA_CORE			86
>   #define SM8150_SLAVE_LLCC			87
>   #define SM8150_SLAVE_LLCC_CFG			88
>   #define SM8150_SLAVE_MNOC_HF_MEM_NOC		89

