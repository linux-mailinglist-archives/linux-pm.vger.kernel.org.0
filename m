Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF0B22C7F4
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgGXO3b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 10:29:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36008 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGXO3b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 10:29:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595600968; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=5w4XDBnt3ROSfTUTp+KukX9jVoNEDUlavGDjQerCht8=;
 b=Bma7uiUZAIePEc0omn2mbJASgAGUaKRpM3FBESNkrgCdUZAuj7ASLQ3L/m5eqx/meYQrAWQN
 i2UwBrj/tSeYgfRjClbTfK1RTVKdct3z5/Jd51T0lT/+nrnwFbZDoFlpax4y8+Fi0LYn/f6W
 a7vVhWH5smZBKWs/S3kF7lWXSdM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5f1af0487186ea1ee12d4e01 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Jul 2020 14:29:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F8E5C43391; Fri, 24 Jul 2020 14:29:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B7D9C433C6;
        Fri, 24 Jul 2020 14:29:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Jul 2020 19:59:24 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 4/7] interconnect: qcom: Add SM8150 interconnect
 provider driver
In-Reply-To: <20200713154121.22094-5-jonathan@marek.ca>
References: <20200713154121.22094-1-jonathan@marek.ca>
 <20200713154121.22094-5-jonathan@marek.ca>
Message-ID: <c4d8477277a05618b80faab50be0047f@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Jonathan,
Thanks for the patch!

On 2020-07-13 21:11, Jonathan Marek wrote:
> Add driver for the Qualcomm interconnect buses found in SM8150 based
> platforms. The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Based on SC7180 driver and generated from downstream dts.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/interconnect/qcom/Kconfig  |  10 +
>  drivers/interconnect/qcom/Makefile |   2 +
>  drivers/interconnect/qcom/sm8150.c | 639 +++++++++++++++++++++++++++++
>  drivers/interconnect/qcom/sm8150.h | 153 +++++++
>  4 files changed, 804 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/sm8150.c
>  create mode 100644 drivers/interconnect/qcom/sm8150.h
> 
> diff --git a/drivers/interconnect/qcom/Kconfig
> b/drivers/interconnect/qcom/Kconfig
> index a88f2f07bc27..25486de5a38d 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -65,5 +65,15 @@ config INTERCONNECT_QCOM_SDM845
>  	  This is a driver for the Qualcomm Network-on-Chip on sdm845-based
>  	  platforms.
> 
> +config INTERCONNECT_QCOM_SM8150
> +	tristate "Qualcomm SM8150 interconnect driver"
> +	depends on INTERCONNECT_QCOM
> +	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
> +	select INTERCONNECT_QCOM_RPMH
> +	select INTERCONNECT_QCOM_BCM_VOTER
> +	help
> +	  This is a driver for the Qualcomm Network-on-Chip on sm8150-based
> +	  platforms.
> +
>  config INTERCONNECT_QCOM_SMD_RPM
>  	tristate
> diff --git a/drivers/interconnect/qcom/Makefile
> b/drivers/interconnect/qcom/Makefile
> index 3a047fe6e45a..1702ece67dc5 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -8,6 +8,7 @@ qnoc-qcs404-objs			:= qcs404.o
>  icc-rpmh-obj				:= icc-rpmh.o
>  qnoc-sc7180-objs			:= sc7180.o
>  qnoc-sdm845-objs			:= sdm845.o
> +qnoc-sm8150-objs			:= sm8150.o
>  icc-smd-rpm-objs			:= smd-rpm.o
> 
>  obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
> @@ -18,4 +19,5 @@ obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += 
> qnoc-qcs404.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
> diff --git a/drivers/interconnect/qcom/sm8150.c
> b/drivers/interconnect/qcom/sm8150.c
> new file mode 100644
> index 000000000000..2b82fa8dd275
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sm8150.c
> @@ -0,0 +1,639 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <dt-bindings/interconnect/qcom,sm8150.h>
> +
> +#include "bcm-voter.h"
> +#include "icc-rpmh.h"
> +#include "sm8150.h"
> +
> +DEFINE_QNODE(qhm_a1noc_cfg, SM8150_MASTER_A1NOC_CFG, 1, 4,
> SM8150_SLAVE_SERVICE_A1NOC);
> +DEFINE_QNODE(qhm_qup0, SM8150_MASTER_QUP_0, 1, 4, 
> SM8150_A1NOC_SNOC_SLV);
> +DEFINE_QNODE(xm_emac, SM8150_MASTER_EMAC, 1, 8, 
> SM8150_A1NOC_SNOC_SLV);
> +DEFINE_QNODE(xm_ufs_mem, SM8150_MASTER_UFS_MEM, 1, 8, 
> SM8150_A1NOC_SNOC_SLV);
> +DEFINE_QNODE(xm_usb3_0, SM8150_MASTER_USB3, 1, 8, 
> SM8150_A1NOC_SNOC_SLV);
> +DEFINE_QNODE(xm_usb3_1, SM8150_MASTER_USB3_1, 1, 8, 
> SM8150_A1NOC_SNOC_SLV);
> +DEFINE_QNODE(qhm_a2noc_cfg, SM8150_MASTER_A2NOC_CFG, 1, 4,
> SM8150_SLAVE_SERVICE_A2NOC);
> +DEFINE_QNODE(qhm_qdss_bam, SM8150_MASTER_QDSS_BAM, 1, 4,
> SM8150_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(qhm_qspi, SM8150_MASTER_QSPI, 1, 4, 
> SM8150_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(qhm_qup1, SM8150_MASTER_QUP_1, 1, 4, 
> SM8150_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(qhm_qup2, SM8150_MASTER_QUP_2, 1, 4, 
> SM8150_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(qhm_sensorss_ahb, SM8150_MASTER_SENSORS_AHB, 1, 4,
> SM8150_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(qhm_tsif, SM8150_MASTER_TSIF, 1, 4, 
> SM8150_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(qnm_cnoc, SM8150_MASTER_CNOC_A2NOC, 1, 8, 
> SM8150_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(qxm_crypto, SM8150_MASTER_CRYPTO_CORE_0, 1, 8,
> SM8150_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(qxm_ipa, SM8150_MASTER_IPA, 1, 8, SM8150_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(xm_pcie3_0, SM8150_MASTER_PCIE, 1, 8,
> SM8150_SLAVE_ANOC_PCIE_GEM_NOC);
> +DEFINE_QNODE(xm_pcie3_1, SM8150_MASTER_PCIE_1, 1, 8,
> SM8150_SLAVE_ANOC_PCIE_GEM_NOC);
> +DEFINE_QNODE(xm_qdss_etr, SM8150_MASTER_QDSS_ETR, 1, 8, 
> SM8150_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(xm_sdc2, SM8150_MASTER_SDCC_2, 1, 8, 
> SM8150_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(xm_sdc4, SM8150_MASTER_SDCC_4, 1, 8, 
> SM8150_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(qxm_camnoc_hf0_uncomp, SM8150_MASTER_CAMNOC_HF0_UNCOMP,
> 1, 32, SM8150_SLAVE_CAMNOC_UNCOMP);
> +DEFINE_QNODE(qxm_camnoc_hf1_uncomp, SM8150_MASTER_CAMNOC_HF1_UNCOMP,
> 1, 32, SM8150_SLAVE_CAMNOC_UNCOMP);
> +DEFINE_QNODE(qxm_camnoc_sf_uncomp, SM8150_MASTER_CAMNOC_SF_UNCOMP, 1,
> 32, SM8150_SLAVE_CAMNOC_UNCOMP);
> +DEFINE_QNODE(qnm_npu, SM8150_MASTER_NPU, 1, 32, 
> SM8150_SLAVE_CDSP_MEM_NOC);
> +DEFINE_QNODE(qhm_spdm, SM8150_MASTER_SPDM, 1, 4, 
> SM8150_SLAVE_CNOC_A2NOC);
> +DEFINE_QNODE(qnm_snoc, SM8150_SNOC_CNOC_MAS, 1, 8,
> SM8150_SLAVE_TLMM_SOUTH, SM8150_SLAVE_CDSP_CFG, SM8150_SLAVE_SPSS_CFG,
> SM8150_SLAVE_CAMERA_CFG, SM8150_SLAVE_SDCC_4, SM8150_SLAVE_SDCC_2,
> SM8150_SLAVE_CNOC_MNOC_CFG, SM8150_SLAVE_EMAC_CFG,
> SM8150_SLAVE_UFS_MEM_CFG, SM8150_SLAVE_TLMM_EAST,
> SM8150_SLAVE_SSC_CFG, SM8150_SLAVE_SNOC_CFG,
> SM8150_SLAVE_NORTH_PHY_CFG, SM8150_SLAVE_QUP_0, SM8150_SLAVE_GLM,
> SM8150_SLAVE_PCIE_1_CFG, SM8150_SLAVE_A2NOC_CFG,
> SM8150_SLAVE_QDSS_CFG, SM8150_SLAVE_DISPLAY_CFG, SM8150_SLAVE_TCSR,
> SM8150_SLAVE_CNOC_DDRSS, SM8150_SLAVE_RBCPR_MMCX_CFG,
> SM8150_SLAVE_NPU_CFG, SM8150_SLAVE_PCIE_0_CFG,
> SM8150_SLAVE_GRAPHICS_3D_CFG, SM8150_SLAVE_VENUS_CFG,
> SM8150_SLAVE_TSIF, SM8150_SLAVE_IPA_CFG, SM8150_SLAVE_CLK_CTL,
> SM8150_SLAVE_AOP, SM8150_SLAVE_QUP_1, SM8150_SLAVE_AHB2PHY_SOUTH,
> SM8150_SLAVE_USB3_1, SM8150_SLAVE_SERVICE_CNOC,
> SM8150_SLAVE_UFS_CARD_CFG, SM8150_SLAVE_QUP_2,
> SM8150_SLAVE_RBCPR_CX_CFG, SM8150_SLAVE_TLMM_WEST,
> SM8150_SLAVE_A1NOC_CFG, SM8150_SLAVE_AOSS, SM8150_SLAVE_PRNG,
> SM8150_SLAVE_VSENSE_CTRL_CFG, SM8150_SLAVE_QSPI, SM8150_SLAVE_USB3,
> SM8150_SLAVE_SPDM_WRAPPER, SM8150_SLAVE_CRYPTO_0_CFG,
> SM8150_SLAVE_PIMEM_CFG, SM8150_SLAVE_TLMM_NORTH,
> SM8150_SLAVE_RBCPR_MX_CFG, SM8150_SLAVE_IMEM_CFG);
> +DEFINE_QNODE(xm_qdss_dap, SM8150_MASTER_QDSS_DAP, 1, 8,
> SM8150_SLAVE_TLMM_SOUTH, SM8150_SLAVE_CDSP_CFG, SM8150_SLAVE_SPSS_CFG,
> SM8150_SLAVE_CAMERA_CFG, SM8150_SLAVE_SDCC_4, SM8150_SLAVE_SDCC_2,
> SM8150_SLAVE_CNOC_MNOC_CFG, SM8150_SLAVE_EMAC_CFG,
> SM8150_SLAVE_UFS_MEM_CFG, SM8150_SLAVE_TLMM_EAST,
> SM8150_SLAVE_SSC_CFG, SM8150_SLAVE_SNOC_CFG,
> SM8150_SLAVE_NORTH_PHY_CFG, SM8150_SLAVE_QUP_0, SM8150_SLAVE_GLM,
> SM8150_SLAVE_PCIE_1_CFG, SM8150_SLAVE_A2NOC_CFG,
> SM8150_SLAVE_QDSS_CFG, SM8150_SLAVE_DISPLAY_CFG, SM8150_SLAVE_TCSR,
> SM8150_SLAVE_CNOC_DDRSS, SM8150_SLAVE_CNOC_A2NOC,
> SM8150_SLAVE_RBCPR_MMCX_CFG, SM8150_SLAVE_NPU_CFG,
> SM8150_SLAVE_PCIE_0_CFG, SM8150_SLAVE_GRAPHICS_3D_CFG,
> SM8150_SLAVE_VENUS_CFG, SM8150_SLAVE_TSIF, SM8150_SLAVE_IPA_CFG,
> SM8150_SLAVE_CLK_CTL, SM8150_SLAVE_AOP, SM8150_SLAVE_QUP_1,
> SM8150_SLAVE_AHB2PHY_SOUTH, SM8150_SLAVE_USB3_1,
> SM8150_SLAVE_SERVICE_CNOC, SM8150_SLAVE_UFS_CARD_CFG,
> SM8150_SLAVE_QUP_2, SM8150_SLAVE_RBCPR_CX_CFG, SM8150_SLAVE_TLMM_WEST,
> SM8150_SLAVE_A1NOC_CFG, SM8150_SLAVE_AOSS, SM8150_SLAVE_PRNG,
> SM8150_SLAVE_VSENSE_CTRL_CFG, SM8150_SLAVE_QSPI, SM8150_SLAVE_USB3,
> SM8150_SLAVE_SPDM_WRAPPER, SM8150_SLAVE_CRYPTO_0_CFG,
> SM8150_SLAVE_PIMEM_CFG, SM8150_SLAVE_TLMM_NORTH,
> SM8150_SLAVE_RBCPR_MX_CFG, SM8150_SLAVE_IMEM_CFG);
> +DEFINE_QNODE(qhm_cnoc_dc_noc, SM8150_MASTER_CNOC_DC_NOC, 1, 4,
> SM8150_SLAVE_GEM_NOC_CFG, SM8150_SLAVE_LLCC_CFG);
> +DEFINE_QNODE(acm_apps, SM8150_MASTER_AMPSS_M0, 2, 32,
> SM8150_SLAVE_ECC, SM8150_SLAVE_LLCC, SM8150_SLAVE_GEM_NOC_SNOC);
> +DEFINE_QNODE(acm_gpu_tcu, SM8150_MASTER_GPU_TCU, 1, 8,
> SM8150_SLAVE_LLCC, SM8150_SLAVE_GEM_NOC_SNOC);
> +DEFINE_QNODE(acm_sys_tcu, SM8150_MASTER_SYS_TCU, 1, 8,
> SM8150_SLAVE_LLCC, SM8150_SLAVE_GEM_NOC_SNOC);
> +DEFINE_QNODE(qhm_gemnoc_cfg, SM8150_MASTER_GEM_NOC_CFG, 1, 4,
> SM8150_SLAVE_SERVICE_GEM_NOC, SM8150_SLAVE_MSS_PROC_MS_MPU_CFG);
> +DEFINE_QNODE(qnm_cmpnoc, SM8150_MASTER_COMPUTE_NOC, 2, 32,
> SM8150_SLAVE_ECC, SM8150_SLAVE_LLCC, SM8150_SLAVE_GEM_NOC_SNOC);
> +DEFINE_QNODE(qnm_gpu, SM8150_MASTER_GRAPHICS_3D, 2, 32,
> SM8150_SLAVE_LLCC, SM8150_SLAVE_GEM_NOC_SNOC);
> +DEFINE_QNODE(qnm_mnoc_hf, SM8150_MASTER_MNOC_HF_MEM_NOC, 2, 32,
> SM8150_SLAVE_LLCC);
> +DEFINE_QNODE(qnm_mnoc_sf, SM8150_MASTER_MNOC_SF_MEM_NOC, 1, 32,
> SM8150_SLAVE_LLCC, SM8150_SLAVE_GEM_NOC_SNOC);
> +DEFINE_QNODE(qnm_pcie, SM8150_MASTER_GEM_NOC_PCIE_SNOC, 1, 16,
> SM8150_SLAVE_LLCC, SM8150_SLAVE_GEM_NOC_SNOC);
> +DEFINE_QNODE(qnm_snoc_gc, SM8150_MASTER_SNOC_GC_MEM_NOC, 1, 8,
> SM8150_SLAVE_LLCC);
> +DEFINE_QNODE(qnm_snoc_sf, SM8150_MASTER_SNOC_SF_MEM_NOC, 1, 16,
> SM8150_SLAVE_LLCC);
> +DEFINE_QNODE(qxm_ecc, SM8150_MASTER_ECC, 2, 32, SM8150_SLAVE_LLCC);
> +DEFINE_QNODE(ipa_core_master, SM8150_MASTER_IPA_CORE, 1, 8,
> SM8150_SLAVE_IPA_CORE);
> +DEFINE_QNODE(llcc_mc, SM8150_MASTER_LLCC, 4, 4, SM8150_SLAVE_EBI_CH0);
> +DEFINE_QNODE(qhm_mnoc_cfg, SM8150_MASTER_CNOC_MNOC_CFG, 1, 4,
> SM8150_SLAVE_SERVICE_MNOC);
> +DEFINE_QNODE(qxm_camnoc_hf0, SM8150_MASTER_CAMNOC_HF0, 1, 32,
> SM8150_SLAVE_MNOC_HF_MEM_NOC);
> +DEFINE_QNODE(qxm_camnoc_hf1, SM8150_MASTER_CAMNOC_HF1, 1, 32,
> SM8150_SLAVE_MNOC_HF_MEM_NOC);
> +DEFINE_QNODE(qxm_camnoc_sf, SM8150_MASTER_CAMNOC_SF, 1, 32,
> SM8150_SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qxm_mdp0, SM8150_MASTER_MDP_PORT0, 1, 32,
> SM8150_SLAVE_MNOC_HF_MEM_NOC);
> +DEFINE_QNODE(qxm_mdp1, SM8150_MASTER_MDP_PORT1, 1, 32,
> SM8150_SLAVE_MNOC_HF_MEM_NOC);
> +DEFINE_QNODE(qxm_rot, SM8150_MASTER_ROTATOR, 1, 32,
> SM8150_SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qxm_venus0, SM8150_MASTER_VIDEO_P0, 1, 32,
> SM8150_SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qxm_venus1, SM8150_MASTER_VIDEO_P1, 1, 32,
> SM8150_SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qxm_venus_arm9, SM8150_MASTER_VIDEO_PROC, 1, 8,
> SM8150_SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qhm_snoc_cfg, SM8150_MASTER_SNOC_CFG, 1, 4,
> SM8150_SLAVE_SERVICE_SNOC);
> +DEFINE_QNODE(qnm_aggre1_noc, SM8150_A1NOC_SNOC_MAS, 1, 16,
> SM8150_SLAVE_SNOC_GEM_NOC_SF, SM8150_SLAVE_PIMEM, SM8150_SLAVE_OCIMEM,
> SM8150_SLAVE_APPSS, SM8150_SNOC_CNOC_SLV, SM8150_SLAVE_QDSS_STM);
> +DEFINE_QNODE(qnm_aggre2_noc, SM8150_A2NOC_SNOC_MAS, 1, 16,
> SM8150_SLAVE_SNOC_GEM_NOC_SF, SM8150_SLAVE_PIMEM, SM8150_SLAVE_OCIMEM,
> SM8150_SLAVE_APPSS, SM8150_SNOC_CNOC_SLV, SM8150_SLAVE_PCIE_0,
> SM8150_SLAVE_PCIE_1, SM8150_SLAVE_TCU, SM8150_SLAVE_QDSS_STM);
> +DEFINE_QNODE(qnm_gemnoc, SM8150_MASTER_GEM_NOC_SNOC, 1, 8,
> SM8150_SLAVE_PIMEM, SM8150_SLAVE_OCIMEM, SM8150_SLAVE_APPSS,
> SM8150_SNOC_CNOC_SLV, SM8150_SLAVE_TCU, SM8150_SLAVE_QDSS_STM);
> +DEFINE_QNODE(qxm_pimem, SM8150_MASTER_PIMEM, 1, 8,
> SM8150_SLAVE_SNOC_GEM_NOC_GC, SM8150_SLAVE_OCIMEM);
> +DEFINE_QNODE(xm_gic, SM8150_MASTER_GIC, 1, 8,
> SM8150_SLAVE_SNOC_GEM_NOC_GC, SM8150_SLAVE_OCIMEM);
> +DEFINE_QNODE(alc, SM8150_MASTER_ALC, 1, 1);

You can safely remove the ^^ icc node
and the bcm_alc since it will not be
voted from kernel. We seem to do the
same for the SC7180 icc provider as
well.

> +DEFINE_QNODE(qns_a1noc_snoc, SM8150_A1NOC_SNOC_SLV, 1, 16,
> SM8150_A1NOC_SNOC_MAS);
> +DEFINE_QNODE(srvc_aggre1_noc, SM8150_SLAVE_SERVICE_A1NOC, 1, 4);
> +DEFINE_QNODE(qns_a2noc_snoc, SM8150_A2NOC_SNOC_SLV, 1, 16,
> SM8150_A2NOC_SNOC_MAS);
> +DEFINE_QNODE(qns_pcie_mem_noc, SM8150_SLAVE_ANOC_PCIE_GEM_NOC, 1, 16,
> SM8150_MASTER_GEM_NOC_PCIE_SNOC);
> +DEFINE_QNODE(srvc_aggre2_noc, SM8150_SLAVE_SERVICE_A2NOC, 1, 4);
> +DEFINE_QNODE(qns_camnoc_uncomp, SM8150_SLAVE_CAMNOC_UNCOMP, 1, 32);
> +DEFINE_QNODE(qns_cdsp_mem_noc, SM8150_SLAVE_CDSP_MEM_NOC, 2, 32,
> SM8150_MASTER_COMPUTE_NOC);
> +DEFINE_QNODE(qhs_a1_noc_cfg, SM8150_SLAVE_A1NOC_CFG, 1, 4,
> SM8150_MASTER_A1NOC_CFG);
> +DEFINE_QNODE(qhs_a2_noc_cfg, SM8150_SLAVE_A2NOC_CFG, 1, 4,
> SM8150_MASTER_A2NOC_CFG);
> +DEFINE_QNODE(qhs_ahb2phy_south, SM8150_SLAVE_AHB2PHY_SOUTH, 1, 4);
> +DEFINE_QNODE(qhs_aop, SM8150_SLAVE_AOP, 1, 4);
> +DEFINE_QNODE(qhs_aoss, SM8150_SLAVE_AOSS, 1, 4);
> +DEFINE_QNODE(qhs_camera_cfg, SM8150_SLAVE_CAMERA_CFG, 1, 4);
> +DEFINE_QNODE(qhs_clk_ctl, SM8150_SLAVE_CLK_CTL, 1, 4);
> +DEFINE_QNODE(qhs_compute_dsp, SM8150_SLAVE_CDSP_CFG, 1, 4);
> +DEFINE_QNODE(qhs_cpr_cx, SM8150_SLAVE_RBCPR_CX_CFG, 1, 4);
> +DEFINE_QNODE(qhs_cpr_mmcx, SM8150_SLAVE_RBCPR_MMCX_CFG, 1, 4);
> +DEFINE_QNODE(qhs_cpr_mx, SM8150_SLAVE_RBCPR_MX_CFG, 1, 4);
> +DEFINE_QNODE(qhs_crypto0_cfg, SM8150_SLAVE_CRYPTO_0_CFG, 1, 4);
> +DEFINE_QNODE(qhs_ddrss_cfg, SM8150_SLAVE_CNOC_DDRSS, 1, 4,
> SM8150_MASTER_CNOC_DC_NOC);
> +DEFINE_QNODE(qhs_display_cfg, SM8150_SLAVE_DISPLAY_CFG, 1, 4);
> +DEFINE_QNODE(qhs_emac_cfg, SM8150_SLAVE_EMAC_CFG, 1, 4);
> +DEFINE_QNODE(qhs_glm, SM8150_SLAVE_GLM, 1, 4);
> +DEFINE_QNODE(qhs_gpuss_cfg, SM8150_SLAVE_GRAPHICS_3D_CFG, 1, 8);
> +DEFINE_QNODE(qhs_imem_cfg, SM8150_SLAVE_IMEM_CFG, 1, 4);
> +DEFINE_QNODE(qhs_ipa, SM8150_SLAVE_IPA_CFG, 1, 4);
> +DEFINE_QNODE(qhs_mnoc_cfg, SM8150_SLAVE_CNOC_MNOC_CFG, 1, 4,
> SM8150_MASTER_CNOC_MNOC_CFG);
> +DEFINE_QNODE(qhs_npu_cfg, SM8150_SLAVE_NPU_CFG, 1, 4);
> +DEFINE_QNODE(qhs_pcie0_cfg, SM8150_SLAVE_PCIE_0_CFG, 1, 4);
> +DEFINE_QNODE(qhs_pcie1_cfg, SM8150_SLAVE_PCIE_1_CFG, 1, 4);
> +DEFINE_QNODE(qhs_phy_refgen_north, SM8150_SLAVE_NORTH_PHY_CFG, 1, 4);
> +DEFINE_QNODE(qhs_pimem_cfg, SM8150_SLAVE_PIMEM_CFG, 1, 4);
> +DEFINE_QNODE(qhs_prng, SM8150_SLAVE_PRNG, 1, 4);
> +DEFINE_QNODE(qhs_qdss_cfg, SM8150_SLAVE_QDSS_CFG, 1, 4);
> +DEFINE_QNODE(qhs_qspi, SM8150_SLAVE_QSPI, 1, 4);
> +DEFINE_QNODE(qhs_qupv3_east, SM8150_SLAVE_QUP_2, 1, 4);
> +DEFINE_QNODE(qhs_qupv3_north, SM8150_SLAVE_QUP_1, 1, 4);
> +DEFINE_QNODE(qhs_qupv3_south, SM8150_SLAVE_QUP_0, 1, 4);
> +DEFINE_QNODE(qhs_sdc2, SM8150_SLAVE_SDCC_2, 1, 4);
> +DEFINE_QNODE(qhs_sdc4, SM8150_SLAVE_SDCC_4, 1, 4);
> +DEFINE_QNODE(qhs_snoc_cfg, SM8150_SLAVE_SNOC_CFG, 1, 4,
> SM8150_MASTER_SNOC_CFG);
> +DEFINE_QNODE(qhs_spdm, SM8150_SLAVE_SPDM_WRAPPER, 1, 4);
> +DEFINE_QNODE(qhs_spss_cfg, SM8150_SLAVE_SPSS_CFG, 1, 4);
> +DEFINE_QNODE(qhs_ssc_cfg, SM8150_SLAVE_SSC_CFG, 1, 4);
> +DEFINE_QNODE(qhs_tcsr, SM8150_SLAVE_TCSR, 1, 4);
> +DEFINE_QNODE(qhs_tlmm_east, SM8150_SLAVE_TLMM_EAST, 1, 4);
> +DEFINE_QNODE(qhs_tlmm_north, SM8150_SLAVE_TLMM_NORTH, 1, 4);
> +DEFINE_QNODE(qhs_tlmm_south, SM8150_SLAVE_TLMM_SOUTH, 1, 4);
> +DEFINE_QNODE(qhs_tlmm_west, SM8150_SLAVE_TLMM_WEST, 1, 4);
> +DEFINE_QNODE(qhs_tsif, SM8150_SLAVE_TSIF, 1, 4);
> +DEFINE_QNODE(qhs_ufs_card_cfg, SM8150_SLAVE_UFS_CARD_CFG, 1, 4);
> +DEFINE_QNODE(qhs_ufs_mem_cfg, SM8150_SLAVE_UFS_MEM_CFG, 1, 4);
> +DEFINE_QNODE(qhs_usb3_0, SM8150_SLAVE_USB3, 1, 4);
> +DEFINE_QNODE(qhs_usb3_1, SM8150_SLAVE_USB3_1, 1, 4);
> +DEFINE_QNODE(qhs_venus_cfg, SM8150_SLAVE_VENUS_CFG, 1, 4);
> +DEFINE_QNODE(qhs_vsense_ctrl_cfg, SM8150_SLAVE_VSENSE_CTRL_CFG, 1, 4);
> +DEFINE_QNODE(qns_cnoc_a2noc, SM8150_SLAVE_CNOC_A2NOC, 1, 8,
> SM8150_MASTER_CNOC_A2NOC);
> +DEFINE_QNODE(srvc_cnoc, SM8150_SLAVE_SERVICE_CNOC, 1, 4);
> +DEFINE_QNODE(qhs_llcc, SM8150_SLAVE_LLCC_CFG, 1, 4);
> +DEFINE_QNODE(qhs_memnoc, SM8150_SLAVE_GEM_NOC_CFG, 1, 4,
> SM8150_MASTER_GEM_NOC_CFG);
> +DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg, SM8150_SLAVE_MSS_PROC_MS_MPU_CFG, 1, 
> 4);
> +DEFINE_QNODE(qns_ecc, SM8150_SLAVE_ECC, 1, 32);
> +DEFINE_QNODE(qns_gem_noc_snoc, SM8150_SLAVE_GEM_NOC_SNOC, 1, 8,
> SM8150_MASTER_GEM_NOC_SNOC);
> +DEFINE_QNODE(qns_llcc, SM8150_SLAVE_LLCC, 4, 16, SM8150_MASTER_LLCC);
> +DEFINE_QNODE(srvc_gemnoc, SM8150_SLAVE_SERVICE_GEM_NOC, 1, 4);
> +DEFINE_QNODE(ipa_core_slave, SM8150_SLAVE_IPA_CORE, 1, 8);
> +DEFINE_QNODE(ebi, SM8150_SLAVE_EBI_CH0, 4, 4);
> +DEFINE_QNODE(qns2_mem_noc, SM8150_SLAVE_MNOC_SF_MEM_NOC, 1, 32,
> SM8150_MASTER_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qns_mem_noc_hf, SM8150_SLAVE_MNOC_HF_MEM_NOC, 2, 32,
> SM8150_MASTER_MNOC_HF_MEM_NOC);
> +DEFINE_QNODE(srvc_mnoc, SM8150_SLAVE_SERVICE_MNOC, 1, 4);
> +DEFINE_QNODE(qhs_apss, SM8150_SLAVE_APPSS, 1, 8);
> +DEFINE_QNODE(qns_cnoc, SM8150_SNOC_CNOC_SLV, 1, 8, 
> SM8150_SNOC_CNOC_MAS);
> +DEFINE_QNODE(qns_gemnoc_gc, SM8150_SLAVE_SNOC_GEM_NOC_GC, 1, 8,
> SM8150_MASTER_SNOC_GC_MEM_NOC);
> +DEFINE_QNODE(qns_gemnoc_sf, SM8150_SLAVE_SNOC_GEM_NOC_SF, 1, 16,
> SM8150_MASTER_SNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qxs_imem, SM8150_SLAVE_OCIMEM, 1, 8);
> +DEFINE_QNODE(qxs_pimem, SM8150_SLAVE_PIMEM, 1, 8);
> +DEFINE_QNODE(srvc_snoc, SM8150_SLAVE_SERVICE_SNOC, 1, 4);
> +DEFINE_QNODE(xs_pcie_0, SM8150_SLAVE_PCIE_0, 1, 8);
> +DEFINE_QNODE(xs_pcie_1, SM8150_SLAVE_PCIE_1, 1, 8);
> +DEFINE_QNODE(xs_qdss_stm, SM8150_SLAVE_QDSS_STM, 1, 4);
> +DEFINE_QNODE(xs_sys_tcu_cfg, SM8150_SLAVE_TCU, 1, 8);
> +

You can keepalive enabled for SH0,
MC0, MM0, SN0 and CN0.

> +DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
> +DEFINE_QBCM(bcm_alc, "ALC", false, &alc);
> +DEFINE_QBCM(bcm_mc0, "MC0", false, &ebi);
> +DEFINE_QBCM(bcm_sh0, "SH0", false, &qns_llcc);
> +DEFINE_QBCM(bcm_mm0, "MM0", false, &qns_mem_noc_hf);
> +DEFINE_QBCM(bcm_mm1, "MM1", false, &qxm_camnoc_hf0_uncomp,
> &qxm_camnoc_hf1_uncomp, &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf0,
> &qxm_camnoc_hf1, &qxm_mdp0, &qxm_mdp1);
> +DEFINE_QBCM(bcm_sh2, "SH2", false, &qns_gem_noc_snoc);
> +DEFINE_QBCM(bcm_mm2, "MM2", false, &qxm_camnoc_sf, &qns2_mem_noc);
> +DEFINE_QBCM(bcm_sh3, "SH3", false, &acm_gpu_tcu, &acm_sys_tcu);
> +DEFINE_QBCM(bcm_mm3, "MM3", false, &qxm_rot, &qxm_venus0,
> &qxm_venus1, &qxm_venus_arm9);
> +DEFINE_QBCM(bcm_sh4, "SH4", false, &qnm_cmpnoc);
> +DEFINE_QBCM(bcm_sh5, "SH5", false, &acm_apps);
> +DEFINE_QBCM(bcm_sn0, "SN0", false, &qns_gemnoc_sf);
> +DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_mem_noc);
> +DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
> +DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
> +DEFINE_QBCM(bcm_co1, "CO1", false, &qnm_npu);
> +DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
> +DEFINE_QBCM(bcm_cn0, "CN0", false, &qhm_spdm, &qnm_snoc,
> &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy_south, &qhs_aop,
> &qhs_aoss, &qhs_camera_cfg, &qhs_clk_ctl, &qhs_compute_dsp,
> &qhs_cpr_cx, &qhs_cpr_mmcx, &qhs_cpr_mx, &qhs_crypto0_cfg,
> &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_emac_cfg, &qhs_glm,
> &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_npu_cfg,
> &qhs_pcie0_cfg, &qhs_pcie1_cfg, &qhs_phy_refgen_north, &qhs_pimem_cfg,
> &qhs_prng, &qhs_qdss_cfg, &qhs_qspi, &qhs_qupv3_east,
> &qhs_qupv3_north, &qhs_qupv3_south, &qhs_sdc2, &qhs_sdc4,
> &qhs_snoc_cfg, &qhs_spdm, &qhs_spss_cfg, &qhs_ssc_cfg, &qhs_tcsr,
> &qhs_tlmm_east, &qhs_tlmm_north, &qhs_tlmm_south, &qhs_tlmm_west,
> &qhs_tsif, &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg, &qhs_usb3_0,
> &qhs_usb3_1, &qhs_venus_cfg, &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc,
> &srvc_cnoc);
> +DEFINE_QBCM(bcm_qup0, "QUP0", false, &qhm_qup0, &qhm_qup1, &qhm_qup2);
> +DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
> +DEFINE_QBCM(bcm_sn3, "SN3", false, &srvc_aggre1_noc,
> &srvc_aggre2_noc, &qns_cnoc);
> +DEFINE_QBCM(bcm_sn4, "SN4", false, &qxs_pimem);
> +DEFINE_QBCM(bcm_sn5, "SN5", false, &xs_qdss_stm);
> +DEFINE_QBCM(bcm_sn8, "SN8", false, &xs_pcie_0, &xs_pcie_1);
> +DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_aggre1_noc);
> +DEFINE_QBCM(bcm_sn11, "SN11", false, &qnm_aggre2_noc);
> +DEFINE_QBCM(bcm_sn12, "SN12", false, &qxm_pimem, &xm_gic);
> +DEFINE_QBCM(bcm_sn14, "SN14", false, &qns_pcie_mem_noc);
> +DEFINE_QBCM(bcm_sn15, "SN15", false, &qnm_gemnoc);
> +
> +static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
> +	&bcm_qup0,
> +	&bcm_sn3,
> +};
> +
> +static struct qcom_icc_node *aggre1_noc_nodes[] = {
> +	[MASTER_A1NOC_CFG] = &qhm_a1noc_cfg,
> +	[MASTER_QUP_0] = &qhm_qup0,
> +	[MASTER_EMAC] = &xm_emac,
> +	[MASTER_UFS_MEM] = &xm_ufs_mem,
> +	[MASTER_USB3] = &xm_usb3_0,
> +	[MASTER_USB3_1] = &xm_usb3_1,
> +	[A1NOC_SNOC_SLV] = &qns_a1noc_snoc,
> +	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
> +};
> +
> +static struct qcom_icc_desc sm8150_aggre1_noc = {
> +	.nodes = aggre1_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
> +	.bcms = aggre1_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
> +	&bcm_ce0,
> +	&bcm_qup0,
> +	&bcm_sn14,
> +	&bcm_sn3,
> +};
> +
> +static struct qcom_icc_node *aggre2_noc_nodes[] = {
> +	[MASTER_A2NOC_CFG] = &qhm_a2noc_cfg,
> +	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
> +	[MASTER_QSPI] = &qhm_qspi,
> +	[MASTER_QUP_1] = &qhm_qup1,
> +	[MASTER_QUP_2] = &qhm_qup2,
> +	[MASTER_SENSORS_AHB] = &qhm_sensorss_ahb,
> +	[MASTER_TSIF] = &qhm_tsif,
> +	[MASTER_CNOC_A2NOC] = &qnm_cnoc,
> +	[MASTER_CRYPTO_CORE_0] = &qxm_crypto,
> +	[MASTER_IPA] = &qxm_ipa,
> +	[MASTER_PCIE] = &xm_pcie3_0,
> +	[MASTER_PCIE_1] = &xm_pcie3_1,
> +	[MASTER_QDSS_ETR] = &xm_qdss_etr,
> +	[MASTER_SDCC_2] = &xm_sdc2,
> +	[MASTER_SDCC_4] = &xm_sdc4,
> +	[A2NOC_SNOC_SLV] = &qns_a2noc_snoc,
> +	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
> +	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
> +};
> +
> +static struct qcom_icc_desc sm8150_aggre2_noc = {
> +	.nodes = aggre2_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
> +	.bcms = aggre2_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *camnoc_virt_bcms[] = {
> +	&bcm_mm1,
> +};
> +
> +static struct qcom_icc_node *camnoc_virt_nodes[] = {
> +	[MASTER_CAMNOC_HF0_UNCOMP] = &qxm_camnoc_hf0_uncomp,
> +	[MASTER_CAMNOC_HF1_UNCOMP] = &qxm_camnoc_hf1_uncomp,
> +	[MASTER_CAMNOC_SF_UNCOMP] = &qxm_camnoc_sf_uncomp,
> +	[SLAVE_CAMNOC_UNCOMP] = &qns_camnoc_uncomp,
> +};
> +
> +static struct qcom_icc_desc sm8150_camnoc_virt = {
> +	.nodes = camnoc_virt_nodes,
> +	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
> +	.bcms = camnoc_virt_bcms,
> +	.num_bcms = ARRAY_SIZE(camnoc_virt_bcms),
> +};
> +
> +static struct qcom_icc_bcm *compute_noc_bcms[] = {
> +	&bcm_co0,
> +	&bcm_co1,
> +};
> +
> +static struct qcom_icc_node *compute_noc_nodes[] = {
> +	[MASTER_NPU] = &qnm_npu,
> +	[SLAVE_CDSP_MEM_NOC] = &qns_cdsp_mem_noc,
> +};
> +
> +static struct qcom_icc_desc sm8150_compute_noc = {
> +	.nodes = compute_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
> +	.bcms = compute_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(compute_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *config_noc_bcms[] = {
> +	&bcm_cn0,
> +};
> +
> +static struct qcom_icc_node *config_noc_nodes[] = {
> +	[MASTER_SPDM] = &qhm_spdm,
> +	[SNOC_CNOC_MAS] = &qnm_snoc,
> +	[MASTER_QDSS_DAP] = &xm_qdss_dap,
> +	[SLAVE_A1NOC_CFG] = &qhs_a1_noc_cfg,
> +	[SLAVE_A2NOC_CFG] = &qhs_a2_noc_cfg,
> +	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy_south,
> +	[SLAVE_AOP] = &qhs_aop,
> +	[SLAVE_AOSS] = &qhs_aoss,
> +	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
> +	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
> +	[SLAVE_CDSP_CFG] = &qhs_compute_dsp,
> +	[SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
> +	[SLAVE_RBCPR_MMCX_CFG] = &qhs_cpr_mmcx,
> +	[SLAVE_RBCPR_MX_CFG] = &qhs_cpr_mx,
> +	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
> +	[SLAVE_CNOC_DDRSS] = &qhs_ddrss_cfg,
> +	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
> +	[SLAVE_EMAC_CFG] = &qhs_emac_cfg,
> +	[SLAVE_GLM] = &qhs_glm,
> +	[SLAVE_GRAPHICS_3D_CFG] = &qhs_gpuss_cfg,
> +	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
> +	[SLAVE_IPA_CFG] = &qhs_ipa,
> +	[SLAVE_CNOC_MNOC_CFG] = &qhs_mnoc_cfg,
> +	[SLAVE_NPU_CFG] = &qhs_npu_cfg,
> +	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
> +	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
> +	[SLAVE_NORTH_PHY_CFG] = &qhs_phy_refgen_north,
> +	[SLAVE_PIMEM_CFG] = &qhs_pimem_cfg,
> +	[SLAVE_PRNG] = &qhs_prng,
> +	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
> +	[SLAVE_QSPI] = &qhs_qspi,
> +	[SLAVE_QUP_2] = &qhs_qupv3_east,
> +	[SLAVE_QUP_1] = &qhs_qupv3_north,
> +	[SLAVE_QUP_0] = &qhs_qupv3_south,
> +	[SLAVE_SDCC_2] = &qhs_sdc2,
> +	[SLAVE_SDCC_4] = &qhs_sdc4,
> +	[SLAVE_SNOC_CFG] = &qhs_snoc_cfg,
> +	[SLAVE_SPDM_WRAPPER] = &qhs_spdm,
> +	[SLAVE_SPSS_CFG] = &qhs_spss_cfg,
> +	[SLAVE_SSC_CFG] = &qhs_ssc_cfg,
> +	[SLAVE_TCSR] = &qhs_tcsr,
> +	[SLAVE_TLMM_EAST] = &qhs_tlmm_east,
> +	[SLAVE_TLMM_NORTH] = &qhs_tlmm_north,
> +	[SLAVE_TLMM_SOUTH] = &qhs_tlmm_south,
> +	[SLAVE_TLMM_WEST] = &qhs_tlmm_west,
> +	[SLAVE_TSIF] = &qhs_tsif,
> +	[SLAVE_UFS_CARD_CFG] = &qhs_ufs_card_cfg,
> +	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
> +	[SLAVE_USB3] = &qhs_usb3_0,
> +	[SLAVE_USB3_1] = &qhs_usb3_1,
> +	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
> +	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
> +	[SLAVE_CNOC_A2NOC] = &qns_cnoc_a2noc,
> +	[SLAVE_SERVICE_CNOC] = &srvc_cnoc,
> +};
> +
> +static struct qcom_icc_desc sm8150_config_noc = {
> +	.nodes = config_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(config_noc_nodes),
> +	.bcms = config_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(config_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *dc_noc_bcms[] = {
> +};
> +
> +static struct qcom_icc_node *dc_noc_nodes[] = {
> +	[MASTER_CNOC_DC_NOC] = &qhm_cnoc_dc_noc,
> +	[SLAVE_LLCC_CFG] = &qhs_llcc,
> +	[SLAVE_GEM_NOC_CFG] = &qhs_memnoc,
> +};
> +
> +static struct qcom_icc_desc sm8150_dc_noc = {
> +	.nodes = dc_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
> +	.bcms = dc_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *gem_noc_bcms[] = {
> +	&bcm_sh0,
> +	&bcm_sh2,
> +	&bcm_sh3,
> +	&bcm_sh4,
> +	&bcm_sh5,
> +};
> +
> +static struct qcom_icc_node *gem_noc_nodes[] = {
> +	[MASTER_AMPSS_M0] = &acm_apps,
> +	[MASTER_GPU_TCU] = &acm_gpu_tcu,
> +	[MASTER_SYS_TCU] = &acm_sys_tcu,
> +	[MASTER_GEM_NOC_CFG] = &qhm_gemnoc_cfg,
> +	[MASTER_COMPUTE_NOC] = &qnm_cmpnoc,
> +	[MASTER_GRAPHICS_3D] = &qnm_gpu,
> +	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
> +	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
> +	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_pcie,
> +	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
> +	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
> +	[MASTER_ECC] = &qxm_ecc,
> +	[SLAVE_MSS_PROC_MS_MPU_CFG] = &qhs_mdsp_ms_mpu_cfg,
> +	[SLAVE_ECC] = &qns_ecc,
> +	[SLAVE_GEM_NOC_SNOC] = &qns_gem_noc_snoc,
> +	[SLAVE_LLCC] = &qns_llcc,
> +	[SLAVE_SERVICE_GEM_NOC] = &srvc_gemnoc,
> +};
> +
> +static struct qcom_icc_desc sm8150_gem_noc = {
> +	.nodes = gem_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
> +	.bcms = gem_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *ipa_virt_bcms[] = {
> +	&bcm_ip0,
> +};
> +
> +static struct qcom_icc_node *ipa_virt_nodes[] = {
> +	[MASTER_IPA_CORE] = &ipa_core_master,
> +	[SLAVE_IPA_CORE] = &ipa_core_slave,
> +};
> +
> +static struct qcom_icc_desc sm8150_ipa_virt = {
> +	.nodes = ipa_virt_nodes,
> +	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
> +	.bcms = ipa_virt_bcms,
> +	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
> +};
> +
> +static struct qcom_icc_bcm *mc_virt_bcms[] = {
> +	&bcm_acv,
> +	&bcm_alc,
> +	&bcm_mc0,
> +};
> +
> +static struct qcom_icc_node *mc_virt_nodes[] = {
> +	[MASTER_LLCC] = &llcc_mc,
> +	[MASTER_ALC] = &alc,
> +	[SLAVE_EBI_CH0] = &ebi,
> +};
> +
> +static struct qcom_icc_desc sm8150_mc_virt = {
> +	.nodes = mc_virt_nodes,
> +	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
> +	.bcms = mc_virt_bcms,
> +	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
> +};
> +
> +static struct qcom_icc_bcm *mmss_noc_bcms[] = {
> +	&bcm_mm0,
> +	&bcm_mm1,
> +	&bcm_mm2,
> +	&bcm_mm3,
> +};
> +
> +static struct qcom_icc_node *mmss_noc_nodes[] = {
> +	[MASTER_CNOC_MNOC_CFG] = &qhm_mnoc_cfg,
> +	[MASTER_CAMNOC_HF0] = &qxm_camnoc_hf0,
> +	[MASTER_CAMNOC_HF1] = &qxm_camnoc_hf1,
> +	[MASTER_CAMNOC_SF] = &qxm_camnoc_sf,
> +	[MASTER_MDP_PORT0] = &qxm_mdp0,
> +	[MASTER_MDP_PORT1] = &qxm_mdp1,
> +	[MASTER_ROTATOR] = &qxm_rot,
> +	[MASTER_VIDEO_P0] = &qxm_venus0,
> +	[MASTER_VIDEO_P1] = &qxm_venus1,
> +	[MASTER_VIDEO_PROC] = &qxm_venus_arm9,
> +	[SLAVE_MNOC_SF_MEM_NOC] = &qns2_mem_noc,
> +	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
> +	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
> +};
> +
> +static struct qcom_icc_desc sm8150_mmss_noc = {
> +	.nodes = mmss_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
> +	.bcms = mmss_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *system_noc_bcms[] = {
> +	&bcm_sn0,
> +	&bcm_sn1,
> +	&bcm_sn11,
> +	&bcm_sn12,
> +	&bcm_sn15,
> +	&bcm_sn2,
> +	&bcm_sn3,
> +	&bcm_sn4,
> +	&bcm_sn5,
> +	&bcm_sn8,
> +	&bcm_sn9,
> +};
> +
> +static struct qcom_icc_node *system_noc_nodes[] = {
> +	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
> +	[A1NOC_SNOC_MAS] = &qnm_aggre1_noc,
> +	[A2NOC_SNOC_MAS] = &qnm_aggre2_noc,
> +	[MASTER_GEM_NOC_SNOC] = &qnm_gemnoc,
> +	[MASTER_PIMEM] = &qxm_pimem,
> +	[MASTER_GIC] = &xm_gic,
> +	[SLAVE_APPSS] = &qhs_apss,
> +	[SNOC_CNOC_SLV] = &qns_cnoc,
> +	[SLAVE_SNOC_GEM_NOC_GC] = &qns_gemnoc_gc,
> +	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
> +	[SLAVE_OCIMEM] = &qxs_imem,
> +	[SLAVE_PIMEM] = &qxs_pimem,
> +	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
> +	[SLAVE_PCIE_0] = &xs_pcie_0,
> +	[SLAVE_PCIE_1] = &xs_pcie_1,
> +	[SLAVE_QDSS_STM] = &xs_qdss_stm,
> +	[SLAVE_TCU] = &xs_sys_tcu_cfg,
> +};
> +
> +static struct qcom_icc_desc sm8150_system_noc = {
> +	.nodes = system_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(system_noc_nodes),
> +	.bcms = system_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(system_noc_bcms),
> +};
> +
> +static int qnoc_probe(struct platform_device *pdev)
> +{
> +	const struct qcom_icc_desc *desc;
> +	struct icc_onecell_data *data;
> +	struct icc_provider *provider;
> +	struct qcom_icc_node **qnodes;
> +	struct qcom_icc_provider *qp;
> +	struct icc_node *node;
> +	size_t num_nodes, i;
> +	int ret;
> +
> +	desc = device_get_match_data(&pdev->dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	qnodes = desc->nodes;
> +	num_nodes = desc->num_nodes;
> +
> +	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
> +	if (!qp)
> +		return -ENOMEM;
> +
> +	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), 
> GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	provider = &qp->provider;
> +	provider->dev = &pdev->dev;
> +	provider->set = qcom_icc_set;
> +	provider->pre_aggregate = qcom_icc_pre_aggregate;
> +	provider->aggregate = qcom_icc_aggregate;
> +	provider->xlate = of_icc_xlate_onecell;
> +	INIT_LIST_HEAD(&provider->nodes);
> +	provider->data = data;
> +
> +	qp->dev = &pdev->dev;
> +	qp->bcms = desc->bcms;
> +	qp->num_bcms = desc->num_bcms;
> +
> +	qp->voter = of_bcm_voter_get(qp->dev, NULL);
> +	if (IS_ERR(qp->voter))
> +		return PTR_ERR(qp->voter);
> +
> +	ret = icc_provider_add(provider);
> +	if (ret) {
> +		dev_err(&pdev->dev, "error adding interconnect provider\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < num_nodes; i++) {
> +		size_t j;
> +
> +		if (!qnodes[i])
> +			continue;
> +
> +		node = icc_node_create(qnodes[i]->id);
> +		if (IS_ERR(node)) {
> +			ret = PTR_ERR(node);
> +			goto err;
> +		}
> +
> +		node->name = qnodes[i]->name;
> +		node->data = qnodes[i];
> +		icc_node_add(node, provider);
> +
> +		for (j = 0; j < qnodes[i]->num_links; j++)
> +			icc_link_create(node, qnodes[i]->links[j]);
> +
> +		data->nodes[i] = node;
> +	}
> +	data->num_nodes = num_nodes;
> +
> +	for (i = 0; i < qp->num_bcms; i++)
> +		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
> +
> +	platform_set_drvdata(pdev, qp);
> +
> +	return 0;
> +err:
> +	icc_nodes_remove(provider);
> +	icc_provider_del(provider);
> +	return ret;
> +}
> +
> +static int qnoc_remove(struct platform_device *pdev)
> +{
> +	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
> +
> +	icc_nodes_remove(&qp->provider);
> +	return icc_provider_del(&qp->provider);
> +}
> +
> +static const struct of_device_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,sm8150-aggre1-noc",
> +	  .data = &sm8150_aggre1_noc},
> +	{ .compatible = "qcom,sm8150-aggre2-noc",
> +	  .data = &sm8150_aggre2_noc},
> +	{ .compatible = "qcom,sm8150-camnoc-virt",
> +	  .data = &sm8150_camnoc_virt},
> +	{ .compatible = "qcom,sm8150-compute-noc",
> +	  .data = &sm8150_compute_noc},
> +	{ .compatible = "qcom,sm8150-config-noc",
> +	  .data = &sm8150_config_noc},
> +	{ .compatible = "qcom,sm8150-dc-noc",
> +	  .data = &sm8150_dc_noc},
> +	{ .compatible = "qcom,sm8150-gem-noc",
> +	  .data = &sm8150_gem_noc},
> +	{ .compatible = "qcom,sm8150-ipa-virt",
> +	  .data = &sm8150_ipa_virt},
> +	{ .compatible = "qcom,sm8150-mc-virt",
> +	  .data = &sm8150_mc_virt},
> +	{ .compatible = "qcom,sm8150-mmss-noc",
> +	  .data = &sm8150_mmss_noc},
> +	{ .compatible = "qcom,sm8150-system-noc",
> +	  .data = &sm8150_system_noc},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
> +
> +static struct platform_driver qnoc_driver = {
> +	.probe = qnoc_probe,
> +	.remove = qnoc_remove,
> +	.driver = {
> +		.name = "qnoc-sm8150",
> +		.of_match_table = qnoc_of_match,
> +	},
> +};
> +module_platform_driver(qnoc_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm SM8150 NoC driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/interconnect/qcom/sm8150.h
> b/drivers/interconnect/qcom/sm8150.h
> new file mode 100644
> index 000000000000..3a42b4b6ad12
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sm8150.h
> @@ -0,0 +1,153 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Qualcomm #define SM8250 interconnect IDs
> + *
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_QCOM_SM8150_H
> +#define __DRIVERS_INTERCONNECT_QCOM_SM8150_H
> +
> +#define SM8150_A1NOC_SNOC_MAS			0
> +#define SM8150_A1NOC_SNOC_SLV			1
> +#define SM8150_A2NOC_SNOC_MAS			2
> +#define SM8150_A2NOC_SNOC_SLV			3
> +#define SM8150_MASTER_A1NOC_CFG			4
> +#define SM8150_MASTER_A2NOC_CFG			5
> +#define SM8150_MASTER_ALC			6
> +#define SM8150_MASTER_AMPSS_M0			7
> +#define SM8150_MASTER_CAMNOC_HF0		8
> +#define SM8150_MASTER_CAMNOC_HF0_UNCOMP		9
> +#define SM8150_MASTER_CAMNOC_HF1		10
> +#define SM8150_MASTER_CAMNOC_HF1_UNCOMP		11
> +#define SM8150_MASTER_CAMNOC_SF			12
> +#define SM8150_MASTER_CAMNOC_SF_UNCOMP		13
> +#define SM8150_MASTER_CNOC_A2NOC		14
> +#define SM8150_MASTER_CNOC_DC_NOC		15
> +#define SM8150_MASTER_CNOC_MNOC_CFG		16
> +#define SM8150_MASTER_COMPUTE_NOC		17
> +#define SM8150_MASTER_CRYPTO_CORE_0		18
> +#define SM8150_MASTER_ECC			19
> +#define SM8150_MASTER_EMAC			20
> +#define SM8150_MASTER_GEM_NOC_CFG		21
> +#define SM8150_MASTER_GEM_NOC_PCIE_SNOC		22
> +#define SM8150_MASTER_GEM_NOC_SNOC		23
> +#define SM8150_MASTER_GIC			24
> +#define SM8150_MASTER_GPU_TCU			25
> +#define SM8150_MASTER_GRAPHICS_3D		26
> +#define SM8150_MASTER_IPA			27
> +#define SM8150_MASTER_IPA_CORE			28
> +#define SM8150_MASTER_LLCC			29
> +#define SM8150_MASTER_MDP_PORT0			30
> +#define SM8150_MASTER_MDP_PORT1			31
> +#define SM8150_MASTER_MNOC_HF_MEM_NOC		32
> +#define SM8150_MASTER_MNOC_SF_MEM_NOC		33
> +#define SM8150_MASTER_NPU			34
> +#define SM8150_MASTER_PCIE			35
> +#define SM8150_MASTER_PCIE_1			36
> +#define SM8150_MASTER_PIMEM			37
> +#define SM8150_MASTER_QDSS_BAM			38
> +#define SM8150_MASTER_QDSS_DAP			39
> +#define SM8150_MASTER_QDSS_ETR			40
> +#define SM8150_MASTER_QSPI			41
> +#define SM8150_MASTER_QUP_0			42
> +#define SM8150_MASTER_QUP_1			43
> +#define SM8150_MASTER_QUP_2			44
> +#define SM8150_MASTER_ROTATOR			45
> +#define SM8150_MASTER_SDCC_2			46
> +#define SM8150_MASTER_SDCC_4			47
> +#define SM8150_MASTER_SENSORS_AHB		48
> +#define SM8150_MASTER_SNOC_CFG			49
> +#define SM8150_MASTER_SNOC_GC_MEM_NOC		50
> +#define SM8150_MASTER_SNOC_SF_MEM_NOC		51
> +#define SM8150_MASTER_SPDM			52
> +#define SM8150_MASTER_SYS_TCU			53
> +#define SM8150_MASTER_TSIF			54
> +#define SM8150_MASTER_UFS_MEM			55
> +#define SM8150_MASTER_USB3			56
> +#define SM8150_MASTER_USB3_1			57
> +#define SM8150_MASTER_VIDEO_P0			58
> +#define SM8150_MASTER_VIDEO_P1			59
> +#define SM8150_MASTER_VIDEO_PROC		60
> +#define SM8150_SLAVE_A1NOC_CFG			61
> +#define SM8150_SLAVE_A2NOC_CFG			62
> +#define SM8150_SLAVE_AHB2PHY_SOUTH		63
> +#define SM8150_SLAVE_ANOC_PCIE_GEM_NOC		64
> +#define SM8150_SLAVE_AOP			65
> +#define SM8150_SLAVE_AOSS			66
> +#define SM8150_SLAVE_APPSS			67
> +#define SM8150_SLAVE_CAMERA_CFG			68
> +#define SM8150_SLAVE_CAMNOC_UNCOMP		69
> +#define SM8150_SLAVE_CDSP_CFG			70
> +#define SM8150_SLAVE_CDSP_MEM_NOC		71
> +#define SM8150_SLAVE_CLK_CTL			72
> +#define SM8150_SLAVE_CNOC_A2NOC			73
> +#define SM8150_SLAVE_CNOC_DDRSS			74
> +#define SM8150_SLAVE_CNOC_MNOC_CFG		75
> +#define SM8150_SLAVE_CRYPTO_0_CFG		76
> +#define SM8150_SLAVE_DISPLAY_CFG		77
> +#define SM8150_SLAVE_EBI_CH0			78
> +#define SM8150_SLAVE_ECC			79
> +#define SM8150_SLAVE_EMAC_CFG			80
> +#define SM8150_SLAVE_GEM_NOC_CFG		81
> +#define SM8150_SLAVE_GEM_NOC_SNOC		82
> +#define SM8150_SLAVE_GLM			83
> +#define SM8150_SLAVE_GRAPHICS_3D_CFG		84
> +#define SM8150_SLAVE_IMEM_CFG			85
> +#define SM8150_SLAVE_IPA_CFG			86
> +#define SM8150_SLAVE_IPA_CORE			87
> +#define SM8150_SLAVE_LLCC			88
> +#define SM8150_SLAVE_LLCC_CFG			89
> +#define SM8150_SLAVE_MNOC_HF_MEM_NOC		90
> +#define SM8150_SLAVE_MNOC_SF_MEM_NOC		91
> +#define SM8150_SLAVE_MSS_PROC_MS_MPU_CFG	92
> +#define SM8150_SLAVE_NORTH_PHY_CFG		93
> +#define SM8150_SLAVE_NPU_CFG			94
> +#define SM8150_SLAVE_OCIMEM			95
> +#define SM8150_SLAVE_PCIE_0			96
> +#define SM8150_SLAVE_PCIE_0_CFG			97
> +#define SM8150_SLAVE_PCIE_1			98
> +#define SM8150_SLAVE_PCIE_1_CFG			99
> +#define SM8150_SLAVE_PIMEM			100
> +#define SM8150_SLAVE_PIMEM_CFG			101
> +#define SM8150_SLAVE_PRNG			102
> +#define SM8150_SLAVE_QDSS_CFG			103
> +#define SM8150_SLAVE_QDSS_STM			104
> +#define SM8150_SLAVE_QSPI			105
> +#define SM8150_SLAVE_QUP_0			106
> +#define SM8150_SLAVE_QUP_1			107
> +#define SM8150_SLAVE_QUP_2			108
> +#define SM8150_SLAVE_RBCPR_CX_CFG		109
> +#define SM8150_SLAVE_RBCPR_MMCX_CFG		110
> +#define SM8150_SLAVE_RBCPR_MX_CFG		111
> +#define SM8150_SLAVE_SDCC_2			112
> +#define SM8150_SLAVE_SDCC_4			113
> +#define SM8150_SLAVE_SERVICE_A1NOC		114
> +#define SM8150_SLAVE_SERVICE_A2NOC		115
> +#define SM8150_SLAVE_SERVICE_CNOC		116
> +#define SM8150_SLAVE_SERVICE_GEM_NOC		117
> +#define SM8150_SLAVE_SERVICE_MNOC		118
> +#define SM8150_SLAVE_SERVICE_SNOC		119
> +#define SM8150_SLAVE_SNOC_CFG			120
> +#define SM8150_SLAVE_SNOC_GEM_NOC_GC		121
> +#define SM8150_SLAVE_SNOC_GEM_NOC_SF		122
> +#define SM8150_SLAVE_SPDM_WRAPPER		123
> +#define SM8150_SLAVE_SPSS_CFG			124
> +#define SM8150_SLAVE_SSC_CFG			125
> +#define SM8150_SLAVE_TCSR			126
> +#define SM8150_SLAVE_TCU			127
> +#define SM8150_SLAVE_TLMM_EAST			128
> +#define SM8150_SLAVE_TLMM_NORTH			129
> +#define SM8150_SLAVE_TLMM_SOUTH			130
> +#define SM8150_SLAVE_TLMM_WEST			131
> +#define SM8150_SLAVE_TSIF			132
> +#define SM8150_SLAVE_UFS_CARD_CFG		133
> +#define SM8150_SLAVE_UFS_MEM_CFG		134
> +#define SM8150_SLAVE_USB3			135
> +#define SM8150_SLAVE_USB3_1			136
> +#define SM8150_SLAVE_VENUS_CFG			137
> +#define SM8150_SLAVE_VSENSE_CTRL_CFG		138
> +#define SM8150_SNOC_CNOC_MAS			139
> +#define SM8150_SNOC_CNOC_SLV			140
> +
> +#endif

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
