Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC0F2308A1
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 13:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgG1L0k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 07:26:40 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:37048 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728688AbgG1L0a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 07:26:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595935589; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/KUU5B36Sv6J9eP5MQX3JEYblUb0IfRYbjfoybX6178=;
 b=wYExpazeul9ya58wh+OcBfXy8oYrxWFF+HQVHPatVCxPyanOwoSwkW5gdIoDc3tLlQXvsXYD
 Cbwzj6KlAlqeF5BQuP/xgZh6U3e82GZ8QP4HpzO+/LrW40uRgYR+qJeaiLx7aijv/SzRg8oo
 4qAT1WpJPUbzD3jW2cuQPX+uPPM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-east-1.postgun.com with SMTP id
 5f200b651db0b33fd895922d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Jul 2020 11:26:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2D706C433CB; Tue, 28 Jul 2020 11:26:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E3C6C433C6;
        Tue, 28 Jul 2020 11:26:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jul 2020 16:56:26 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: interconnect: Add Qualcomm SM8150 DT
 bindings
In-Reply-To: <20200728023811.5607-3-jonathan@marek.ca>
References: <20200728023811.5607-1-jonathan@marek.ca>
 <20200728023811.5607-3-jonathan@marek.ca>
Message-ID: <ef169d38ae69799c9dccf0246b6b47fa@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-07-28 08:08, Jonathan Marek wrote:
> The Qualcomm SM8150 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      |  11 ++
>  .../dt-bindings/interconnect/qcom,sm8150.h    | 162 ++++++++++++++++++
>  2 files changed, 173 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8150.h
> 
> diff --git
> a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index 6a457f914bb5..e95ccd7b4b5a 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -45,6 +45,17 @@ properties:
>        - qcom,sdm845-mem-noc
>        - qcom,sdm845-mmss-noc
>        - qcom,sdm845-system-noc
> +      - qcom,sm8150-aggre1-noc
> +      - qcom,sm8150-aggre2-noc
> +      - qcom,sm8150-camnoc-noc
> +      - qcom,sm8150-compute-noc
> +      - qcom,sm8150-config-noc
> +      - qcom,sm8150-dc-noc
> +      - qcom,sm8150-gem-noc
> +      - qcom,sm8150-ipa-virt
> +      - qcom,sm8150-mc-virt
> +      - qcom,sm8150-mmss-noc
> +      - qcom,sm8150-system-noc
> 
>    '#interconnect-cells':
>      const: 1
> diff --git a/include/dt-bindings/interconnect/qcom,sm8150.h
> b/include/dt-bindings/interconnect/qcom,sm8150.h
> new file mode 100644
> index 000000000000..a25684680c42
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,sm8150.h
> @@ -0,0 +1,162 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Qualcomm SM8150 interconnect IDs
> + *
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8150_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8150_H
> +
> +#define MASTER_A1NOC_CFG		0
> +#define MASTER_QUP_0			1
> +#define MASTER_EMAC			2
> +#define MASTER_UFS_MEM			3
> +#define MASTER_USB3			4
> +#define MASTER_USB3_1			5
> +#define A1NOC_SNOC_SLV			6
> +#define SLAVE_SERVICE_A1NOC		7
> +
> +#define MASTER_A2NOC_CFG		0
> +#define MASTER_QDSS_BAM			1
> +#define MASTER_QSPI			2
> +#define MASTER_QUP_1			3
> +#define MASTER_QUP_2			4
> +#define MASTER_SENSORS_AHB		5
> +#define MASTER_TSIF			6
> +#define MASTER_CNOC_A2NOC		7
> +#define MASTER_CRYPTO_CORE_0		8
> +#define MASTER_IPA			9
> +#define MASTER_PCIE			10
> +#define MASTER_PCIE_1			11
> +#define MASTER_QDSS_ETR			12
> +#define MASTER_SDCC_2			13
> +#define MASTER_SDCC_4			14
> +#define A2NOC_SNOC_SLV			15
> +#define SLAVE_ANOC_PCIE_GEM_NOC		16
> +#define SLAVE_SERVICE_A2NOC		17
> +
> +#define MASTER_CAMNOC_HF0_UNCOMP	0
> +#define MASTER_CAMNOC_HF1_UNCOMP	1
> +#define MASTER_CAMNOC_SF_UNCOMP		2
> +#define SLAVE_CAMNOC_UNCOMP		3
> +
> +#define MASTER_NPU			0
> +#define SLAVE_CDSP_MEM_NOC		1
> +
> +#define MASTER_SPDM			0
> +#define SNOC_CNOC_MAS			1
> +#define MASTER_QDSS_DAP			2
> +#define SLAVE_A1NOC_CFG			3
> +#define SLAVE_A2NOC_CFG			4
> +#define SLAVE_AHB2PHY_SOUTH		5
> +#define SLAVE_AOP			6
> +#define SLAVE_AOSS			7
> +#define SLAVE_CAMERA_CFG		8
> +#define SLAVE_CLK_CTL			9
> +#define SLAVE_CDSP_CFG			10
> +#define SLAVE_RBCPR_CX_CFG		11
> +#define SLAVE_RBCPR_MMCX_CFG		12
> +#define SLAVE_RBCPR_MX_CFG		13
> +#define SLAVE_CRYPTO_0_CFG		14
> +#define SLAVE_CNOC_DDRSS		15
> +#define SLAVE_DISPLAY_CFG		16
> +#define SLAVE_EMAC_CFG			17
> +#define SLAVE_GLM			18
> +#define SLAVE_GRAPHICS_3D_CFG		19
> +#define SLAVE_IMEM_CFG			20
> +#define SLAVE_IPA_CFG			21
> +#define SLAVE_CNOC_MNOC_CFG		22
> +#define SLAVE_NPU_CFG			23
> +#define SLAVE_PCIE_0_CFG		24
> +#define SLAVE_PCIE_1_CFG		25
> +#define SLAVE_NORTH_PHY_CFG		26
> +#define SLAVE_PIMEM_CFG			27
> +#define SLAVE_PRNG			28
> +#define SLAVE_QDSS_CFG			29
> +#define SLAVE_QSPI			30
> +#define SLAVE_QUP_2			31
> +#define SLAVE_QUP_1			32
> +#define SLAVE_QUP_0			33
> +#define SLAVE_SDCC_2			34
> +#define SLAVE_SDCC_4			35
> +#define SLAVE_SNOC_CFG			36
> +#define SLAVE_SPDM_WRAPPER		37
> +#define SLAVE_SPSS_CFG			38
> +#define SLAVE_SSC_CFG			39
> +#define SLAVE_TCSR			40
> +#define SLAVE_TLMM_EAST			41
> +#define SLAVE_TLMM_NORTH		42
> +#define SLAVE_TLMM_SOUTH		43
> +#define SLAVE_TLMM_WEST			44
> +#define SLAVE_TSIF			45
> +#define SLAVE_UFS_CARD_CFG		46
> +#define SLAVE_UFS_MEM_CFG		47
> +#define SLAVE_USB3			48
> +#define SLAVE_USB3_1			49
> +#define SLAVE_VENUS_CFG			50
> +#define SLAVE_VSENSE_CTRL_CFG		51
> +#define SLAVE_CNOC_A2NOC		52
> +#define SLAVE_SERVICE_CNOC		53
> +
> +#define MASTER_CNOC_DC_NOC		0
> +#define SLAVE_LLCC_CFG			1
> +#define SLAVE_GEM_NOC_CFG		2
> +
> +#define MASTER_AMPSS_M0			0
> +#define MASTER_GPU_TCU			1
> +#define MASTER_SYS_TCU			2
> +#define MASTER_GEM_NOC_CFG		3
> +#define MASTER_COMPUTE_NOC		4
> +#define MASTER_GRAPHICS_3D		5
> +#define MASTER_MNOC_HF_MEM_NOC		6
> +#define MASTER_MNOC_SF_MEM_NOC		7
> +#define MASTER_GEM_NOC_PCIE_SNOC	8
> +#define MASTER_SNOC_GC_MEM_NOC		9
> +#define MASTER_SNOC_SF_MEM_NOC		10
> +#define MASTER_ECC			11
> +#define SLAVE_MSS_PROC_MS_MPU_CFG	12
> +#define SLAVE_ECC			13
> +#define SLAVE_GEM_NOC_SNOC		14
> +#define SLAVE_LLCC			15
> +#define SLAVE_SERVICE_GEM_NOC		16
> +
> +#define MASTER_IPA_CORE			0
> +#define SLAVE_IPA_CORE			1
> +
> +#define MASTER_LLCC			0
> +#define SLAVE_EBI_CH0			1
> +
> +#define MASTER_CNOC_MNOC_CFG		0
> +#define MASTER_CAMNOC_HF0		1
> +#define MASTER_CAMNOC_HF1		2
> +#define MASTER_CAMNOC_SF		3
> +#define MASTER_MDP_PORT0		4
> +#define MASTER_MDP_PORT1		5
> +#define MASTER_ROTATOR			6
> +#define MASTER_VIDEO_P0			7
> +#define MASTER_VIDEO_P1			8
> +#define MASTER_VIDEO_PROC		9
> +#define SLAVE_MNOC_SF_MEM_NOC		10
> +#define SLAVE_MNOC_HF_MEM_NOC		11
> +#define SLAVE_SERVICE_MNOC		12
> +
> +#define MASTER_SNOC_CFG			0
> +#define A1NOC_SNOC_MAS			1
> +#define A2NOC_SNOC_MAS			2
> +#define MASTER_GEM_NOC_SNOC		3
> +#define MASTER_PIMEM			4
> +#define MASTER_GIC			5
> +#define SLAVE_APPSS			6
> +#define SNOC_CNOC_SLV			7
> +#define SLAVE_SNOC_GEM_NOC_GC		8
> +#define SLAVE_SNOC_GEM_NOC_SF		9
> +#define SLAVE_OCIMEM			10
> +#define SLAVE_PIMEM			11
> +#define SLAVE_SERVICE_SNOC		12
> +#define SLAVE_PCIE_0			13
> +#define SLAVE_PCIE_1			14
> +#define SLAVE_QDSS_STM			15
> +#define SLAVE_TCU			16
> +
> +#endif

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
