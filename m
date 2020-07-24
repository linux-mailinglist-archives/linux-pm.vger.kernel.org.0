Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D4822C7FC
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 16:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgGXO3w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 10:29:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36008 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgGXO3v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 10:29:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595600987; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Ek1zD4rkFGcoBp55PgsWg3PX6z7ELEv63TjP52CHY38=;
 b=RmBhHYizJJyAyWeWuiIPUeBPCcpsqaOs4GqQOU5tkCmb3GmBii4C7e/bPRzZSKigl7w/e0Cn
 B2hnPaBBAviMTazmoPZ3En4BG/odVCzlgDgxz9uG+U8WnNz3YhIOwvmWQ4FVUbPc2jW3xlKl
 eo5yShqmgcXpUE5EXd5njbReACQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f1af05736e6de324e17504f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Jul 2020 14:29:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11695C433CA; Fri, 24 Jul 2020 14:29:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6FCB2C433C6;
        Fri, 24 Jul 2020 14:29:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Jul 2020 19:59:40 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 5/7] interconnect: qcom: Add SM8250 interconnect
 provider driver
In-Reply-To: <20200713154121.22094-6-jonathan@marek.ca>
References: <20200713154121.22094-1-jonathan@marek.ca>
 <20200713154121.22094-6-jonathan@marek.ca>
Message-ID: <1e79c73f22c8891dc9f868babd940fca@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Jonathan,
Thanks for the patch!

On 2020-07-13 21:11, Jonathan Marek wrote:
> Add driver for the Qualcomm interconnect buses found in SM8250 based
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
>  drivers/interconnect/qcom/sm8250.c | 655 +++++++++++++++++++++++++++++
>  drivers/interconnect/qcom/sm8250.h | 163 +++++++
>  4 files changed, 830 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/sm8250.c
>  create mode 100644 drivers/interconnect/qcom/sm8250.h
> 
> diff --git a/drivers/interconnect/qcom/Kconfig
> b/drivers/interconnect/qcom/Kconfig
> index 25486de5a38d..a8f93ba265f8 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -75,5 +75,15 @@ config INTERCONNECT_QCOM_SM8150
>  	  This is a driver for the Qualcomm Network-on-Chip on sm8150-based
>  	  platforms.
> 
> +config INTERCONNECT_QCOM_SM8250
> +	tristate "Qualcomm SM8250 interconnect driver"
> +	depends on INTERCONNECT_QCOM
> +	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
> +	select INTERCONNECT_QCOM_RPMH
> +	select INTERCONNECT_QCOM_BCM_VOTER
> +	help
> +	  This is a driver for the Qualcomm Network-on-Chip on sm8250-based
> +	  platforms.
> +
>  config INTERCONNECT_QCOM_SMD_RPM
>  	tristate
> diff --git a/drivers/interconnect/qcom/Makefile
> b/drivers/interconnect/qcom/Makefile
> index 1702ece67dc5..cf628f7990cd 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -9,6 +9,7 @@ icc-rpmh-obj				:= icc-rpmh.o
>  qnoc-sc7180-objs			:= sc7180.o
>  qnoc-sdm845-objs			:= sdm845.o
>  qnoc-sm8150-objs			:= sm8150.o
> +qnoc-sm8250-objs			:= sm8250.o
>  icc-smd-rpm-objs			:= smd-rpm.o
> 
>  obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
> @@ -20,4 +21,5 @@ obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
> diff --git a/drivers/interconnect/qcom/sm8250.c
> b/drivers/interconnect/qcom/sm8250.c
> new file mode 100644
> index 000000000000..8e63c19e01c0
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sm8250.c
> @@ -0,0 +1,655 @@
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
> +#include <dt-bindings/interconnect/qcom,sm8250.h>
> +
> +#include "bcm-voter.h"
> +#include "icc-rpmh.h"
> +#include "sm8250.h"
> +
> +DEFINE_QNODE(qhm_a1noc_cfg, SM8250_MASTER_A1NOC_CFG, 1, 4,
> SM8250_SLAVE_SERVICE_A1NOC);
> +DEFINE_QNODE(qhm_qspi, SM8250_MASTER_QSPI_0, 1, 4, 
> SM8250_A1NOC_SNOC_SLV);
> +DEFINE_QNODE(qhm_qup1, SM8250_MASTER_QUP_1, 1, 4, 
> SM8250_A1NOC_SNOC_SLV);
> +DEFINE_QNODE(qhm_qup2, SM8250_MASTER_QUP_2, 1, 4, 
> SM8250_A1NOC_SNOC_SLV);
> +DEFINE_QNODE(qhm_tsif, SM8250_MASTER_TSIF, 1, 4, 
> SM8250_A1NOC_SNOC_SLV);
> +DEFINE_QNODE(xm_pcie3_modem, SM8250_MASTER_PCIE_2, 1, 8,
> SM8250_SLAVE_ANOC_PCIE_GEM_NOC_1);
> +DEFINE_QNODE(xm_sdc4, SM8250_MASTER_SDCC_4, 1, 8, 
> SM8250_A1NOC_SNOC_SLV);
> +DEFINE_QNODE(xm_ufs_mem, SM8250_MASTER_UFS_MEM, 1, 8, 
> SM8250_A1NOC_SNOC_SLV);
> +DEFINE_QNODE(xm_usb3_0, SM8250_MASTER_USB3, 1, 8, 
> SM8250_A1NOC_SNOC_SLV);
> +DEFINE_QNODE(xm_usb3_1, SM8250_MASTER_USB3_1, 1, 8, 
> SM8250_A1NOC_SNOC_SLV);
> +DEFINE_QNODE(qhm_a2noc_cfg, SM8250_MASTER_A2NOC_CFG, 1, 4,
> SM8250_SLAVE_SERVICE_A2NOC);
> +DEFINE_QNODE(qhm_qdss_bam, SM8250_MASTER_QDSS_BAM, 1, 4,
> SM8250_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(qhm_qup0, SM8250_MASTER_QUP_0, 1, 4, 
> SM8250_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(qnm_cnoc, SM8250_MASTER_CNOC_A2NOC, 1, 8, 
> SM8250_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(qxm_crypto, SM8250_MASTER_CRYPTO_CORE_0, 1, 8,
> SM8250_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(qxm_ipa, SM8250_MASTER_IPA, 1, 8, SM8250_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(xm_pcie3_0, SM8250_MASTER_PCIE, 1, 8,
> SM8250_SLAVE_ANOC_PCIE_GEM_NOC);
> +DEFINE_QNODE(xm_pcie3_1, SM8250_MASTER_PCIE_1, 1, 8,
> SM8250_SLAVE_ANOC_PCIE_GEM_NOC);
> +DEFINE_QNODE(xm_qdss_etr, SM8250_MASTER_QDSS_ETR, 1, 8, 
> SM8250_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(xm_sdc2, SM8250_MASTER_SDCC_2, 1, 8, 
> SM8250_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(xm_ufs_card, SM8250_MASTER_UFS_CARD, 1, 8, 
> SM8250_A2NOC_SNOC_SLV);
> +DEFINE_QNODE(qnm_npu, SM8250_MASTER_NPU, 2, 32, 
> SM8250_SLAVE_CDSP_MEM_NOC);
> +DEFINE_QNODE(qnm_snoc, SM8250_SNOC_CNOC_MAS, 1, 8,
> SM8250_SLAVE_CDSP_CFG, SM8250_SLAVE_CAMERA_CFG,
> SM8250_SLAVE_TLMM_SOUTH, SM8250_SLAVE_TLMM_NORTH, SM8250_SLAVE_SDCC_4,
> SM8250_SLAVE_TLMM_WEST, SM8250_SLAVE_SDCC_2,
> SM8250_SLAVE_CNOC_MNOC_CFG, SM8250_SLAVE_UFS_MEM_CFG,
> SM8250_SLAVE_SNOC_CFG, SM8250_SLAVE_PDM, SM8250_SLAVE_CX_RDPM,
> SM8250_SLAVE_PCIE_1_CFG, SM8250_SLAVE_A2NOC_CFG,
> SM8250_SLAVE_QDSS_CFG, SM8250_SLAVE_DISPLAY_CFG,
> SM8250_SLAVE_PCIE_2_CFG, SM8250_SLAVE_TCSR, SM8250_SLAVE_DCC_CFG,
> SM8250_SLAVE_CNOC_DDRSS, SM8250_SLAVE_IPC_ROUTER_CFG,
> SM8250_SLAVE_PCIE_0_CFG, SM8250_SLAVE_RBCPR_MMCX_CFG,
> SM8250_SLAVE_NPU_CFG, SM8250_SLAVE_AHB2PHY_SOUTH,
> SM8250_SLAVE_AHB2PHY_NORTH, SM8250_SLAVE_GRAPHICS_3D_CFG,
> SM8250_SLAVE_VENUS_CFG, SM8250_SLAVE_TSIF, SM8250_SLAVE_IPA_CFG,
> SM8250_SLAVE_IMEM_CFG, SM8250_SLAVE_USB3, SM8250_SLAVE_SERVICE_CNOC,
> SM8250_SLAVE_UFS_CARD_CFG, SM8250_SLAVE_USB3_1, SM8250_SLAVE_LPASS,
> SM8250_SLAVE_RBCPR_CX_CFG, SM8250_SLAVE_A1NOC_CFG, SM8250_SLAVE_AOSS,
> SM8250_SLAVE_PRNG, SM8250_SLAVE_VSENSE_CTRL_CFG, SM8250_SLAVE_QSPI_0,
> SM8250_SLAVE_CRYPTO_0_CFG, SM8250_SLAVE_PIMEM_CFG,
> SM8250_SLAVE_RBCPR_MX_CFG, SM8250_SLAVE_QUP_0, SM8250_SLAVE_QUP_1,
> SM8250_SLAVE_QUP_2, SM8250_SLAVE_CLK_CTL);
> +DEFINE_QNODE(xm_qdss_dap, SM8250_MASTER_QDSS_DAP, 1, 8,
> SM8250_SLAVE_CDSP_CFG, SM8250_SLAVE_CAMERA_CFG,
> SM8250_SLAVE_TLMM_SOUTH, SM8250_SLAVE_TLMM_NORTH, SM8250_SLAVE_SDCC_4,
> SM8250_SLAVE_TLMM_WEST, SM8250_SLAVE_SDCC_2,
> SM8250_SLAVE_CNOC_MNOC_CFG, SM8250_SLAVE_UFS_MEM_CFG,
> SM8250_SLAVE_SNOC_CFG, SM8250_SLAVE_PDM, SM8250_SLAVE_CX_RDPM,
> SM8250_SLAVE_PCIE_1_CFG, SM8250_SLAVE_A2NOC_CFG,
> SM8250_SLAVE_QDSS_CFG, SM8250_SLAVE_DISPLAY_CFG,
> SM8250_SLAVE_PCIE_2_CFG, SM8250_SLAVE_TCSR, SM8250_SLAVE_DCC_CFG,
> SM8250_SLAVE_CNOC_DDRSS, SM8250_SLAVE_IPC_ROUTER_CFG,
> SM8250_SLAVE_CNOC_A2NOC, SM8250_SLAVE_PCIE_0_CFG,
> SM8250_SLAVE_RBCPR_MMCX_CFG, SM8250_SLAVE_NPU_CFG,
> SM8250_SLAVE_AHB2PHY_SOUTH, SM8250_SLAVE_AHB2PHY_NORTH,
> SM8250_SLAVE_GRAPHICS_3D_CFG, SM8250_SLAVE_VENUS_CFG,
> SM8250_SLAVE_TSIF, SM8250_SLAVE_IPA_CFG, SM8250_SLAVE_IMEM_CFG,
> SM8250_SLAVE_USB3, SM8250_SLAVE_SERVICE_CNOC,
> SM8250_SLAVE_UFS_CARD_CFG, SM8250_SLAVE_USB3_1, SM8250_SLAVE_LPASS,
> SM8250_SLAVE_RBCPR_CX_CFG, SM8250_SLAVE_A1NOC_CFG, SM8250_SLAVE_AOSS,
> SM8250_SLAVE_PRNG, SM8250_SLAVE_VSENSE_CTRL_CFG, SM8250_SLAVE_QSPI_0,
> SM8250_SLAVE_CRYPTO_0_CFG, SM8250_SLAVE_PIMEM_CFG,
> SM8250_SLAVE_RBCPR_MX_CFG, SM8250_SLAVE_QUP_0, SM8250_SLAVE_QUP_1,
> SM8250_SLAVE_QUP_2, SM8250_SLAVE_CLK_CTL);
> +DEFINE_QNODE(qhm_cnoc_dc_noc, SM8250_MASTER_CNOC_DC_NOC, 1, 4,
> SM8250_SLAVE_GEM_NOC_CFG, SM8250_SLAVE_LLCC_CFG);
> +DEFINE_QNODE(alm_gpu_tcu, SM8250_MASTER_GPU_TCU, 1, 8,
> SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
> +DEFINE_QNODE(alm_sys_tcu, SM8250_MASTER_SYS_TCU, 1, 8,
> SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
> +DEFINE_QNODE(chm_apps, SM8250_MASTER_AMPSS_M0, 2, 32,
> SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC,
> SM8250_SLAVE_MEM_NOC_PCIE_SNOC);
> +DEFINE_QNODE(qhm_gemnoc_cfg, SM8250_MASTER_GEM_NOC_CFG, 1, 4,
> SM8250_SLAVE_SERVICE_GEM_NOC_2, SM8250_SLAVE_SERVICE_GEM_NOC_1,
> SM8250_SLAVE_SERVICE_GEM_NOC);
> +DEFINE_QNODE(qnm_cmpnoc, SM8250_MASTER_COMPUTE_NOC, 2, 32,
> SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
> +DEFINE_QNODE(qnm_gpu, SM8250_MASTER_GRAPHICS_3D, 2, 32,
> SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
> +DEFINE_QNODE(qnm_mnoc_hf, SM8250_MASTER_MNOC_HF_MEM_NOC, 2, 32,
> SM8250_SLAVE_LLCC);
> +DEFINE_QNODE(qnm_mnoc_sf, SM8250_MASTER_MNOC_SF_MEM_NOC, 2, 32,
> SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
> +DEFINE_QNODE(qnm_pcie, SM8250_MASTER_ANOC_PCIE_GEM_NOC, 1, 16,
> SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
> +DEFINE_QNODE(qnm_snoc_gc, SM8250_MASTER_SNOC_GC_MEM_NOC, 1, 8,
> SM8250_SLAVE_LLCC);
> +DEFINE_QNODE(qnm_snoc_sf, SM8250_MASTER_SNOC_SF_MEM_NOC, 1, 16,
> SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC,
> SM8250_SLAVE_MEM_NOC_PCIE_SNOC);
> +DEFINE_QNODE(ipa_core_master, SM8250_MASTER_IPA_CORE, 1, 8,
> SM8250_SLAVE_IPA_CORE);
> +DEFINE_QNODE(llcc_mc, SM8250_MASTER_LLCC, 4, 4, SM8250_SLAVE_EBI_CH0);
> +DEFINE_QNODE(qhm_mnoc_cfg, SM8250_MASTER_CNOC_MNOC_CFG, 1, 4,
> SM8250_SLAVE_SERVICE_MNOC);
> +DEFINE_QNODE(qnm_camnoc_hf, SM8250_MASTER_CAMNOC_HF, 2, 32,
> SM8250_SLAVE_MNOC_HF_MEM_NOC);
> +DEFINE_QNODE(qnm_camnoc_icp, SM8250_MASTER_CAMNOC_ICP, 1, 8,
> SM8250_SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qnm_camnoc_sf, SM8250_MASTER_CAMNOC_SF, 2, 32,
> SM8250_SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qnm_video0, SM8250_MASTER_VIDEO_P0, 1, 32,
> SM8250_SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qnm_video1, SM8250_MASTER_VIDEO_P1, 1, 32,
> SM8250_SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qnm_video_cvp, SM8250_MASTER_VIDEO_PROC, 1, 32,
> SM8250_SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qxm_mdp0, SM8250_MASTER_MDP_PORT0, 1, 32,
> SM8250_SLAVE_MNOC_HF_MEM_NOC);
> +DEFINE_QNODE(qxm_mdp1, SM8250_MASTER_MDP_PORT1, 1, 32,
> SM8250_SLAVE_MNOC_HF_MEM_NOC);
> +DEFINE_QNODE(qxm_rot, SM8250_MASTER_ROTATOR, 1, 32,
> SM8250_SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(amm_npu_sys, SM8250_MASTER_NPU_SYS, 4, 32,
> SM8250_SLAVE_NPU_COMPUTE_NOC);
> +DEFINE_QNODE(amm_npu_sys_cdp_w, SM8250_MASTER_NPU_CDP, 2, 16,
> SM8250_SLAVE_NPU_COMPUTE_NOC);
> +DEFINE_QNODE(qhm_cfg, SM8250_MASTER_NPU_NOC_CFG, 1, 4,
> SM8250_SLAVE_SERVICE_NPU_NOC, SM8250_SLAVE_ISENSE_CFG,
> SM8250_SLAVE_NPU_LLM_CFG, SM8250_SLAVE_NPU_INT_DMA_BWMON_CFG,
> SM8250_SLAVE_NPU_CP, SM8250_SLAVE_NPU_TCM, SM8250_SLAVE_NPU_CAL_DP0,
> SM8250_SLAVE_NPU_CAL_DP1, SM8250_SLAVE_NPU_DPM);
> +DEFINE_QNODE(qhm_snoc_cfg, SM8250_MASTER_SNOC_CFG, 1, 4,
> SM8250_SLAVE_SERVICE_SNOC);
> +DEFINE_QNODE(qnm_aggre1_noc, SM8250_A1NOC_SNOC_MAS, 1, 16,
> SM8250_SLAVE_SNOC_GEM_NOC_SF);
> +DEFINE_QNODE(qnm_aggre2_noc, SM8250_A2NOC_SNOC_MAS, 1, 16,
> SM8250_SLAVE_SNOC_GEM_NOC_SF);
> +DEFINE_QNODE(qnm_gemnoc, SM8250_MASTER_GEM_NOC_SNOC, 1, 16,
> SM8250_SLAVE_PIMEM, SM8250_SLAVE_OCIMEM, SM8250_SLAVE_APPSS,
> SM8250_SNOC_CNOC_SLV, SM8250_SLAVE_TCU, SM8250_SLAVE_QDSS_STM);
> +DEFINE_QNODE(qnm_gemnoc_pcie, SM8250_MASTER_GEM_NOC_PCIE_SNOC, 1, 8,
> SM8250_SLAVE_PCIE_2, SM8250_SLAVE_PCIE_0, SM8250_SLAVE_PCIE_1);
> +DEFINE_QNODE(qxm_pimem, SM8250_MASTER_PIMEM, 1, 8,
> SM8250_SLAVE_SNOC_GEM_NOC_GC);
> +DEFINE_QNODE(xm_gic, SM8250_MASTER_GIC, 1, 8, 
> SM8250_SLAVE_SNOC_GEM_NOC_GC);
> +DEFINE_QNODE(alc, SM8250_MASTER_ALC, 1, 1);

You can safely remove the ^^ icc node
and the bcm_alc since it will not be
voted from kernel. We seem to do the
same for the SC7180 icc provider as
well.

> +DEFINE_QNODE(qns_a1noc_snoc, SM8250_A1NOC_SNOC_SLV, 1, 16,
> SM8250_A1NOC_SNOC_MAS);
> +DEFINE_QNODE(qns_pcie_modem_mem_noc,
> SM8250_SLAVE_ANOC_PCIE_GEM_NOC_1, 1, 16,
> SM8250_MASTER_ANOC_PCIE_GEM_NOC);
> +DEFINE_QNODE(srvc_aggre1_noc, SM8250_SLAVE_SERVICE_A1NOC, 1, 4);
> +DEFINE_QNODE(qns_a2noc_snoc, SM8250_A2NOC_SNOC_SLV, 1, 16,
> SM8250_A2NOC_SNOC_MAS);
> +DEFINE_QNODE(qns_pcie_mem_noc, SM8250_SLAVE_ANOC_PCIE_GEM_NOC, 1, 16,
> SM8250_MASTER_ANOC_PCIE_GEM_NOC);
> +DEFINE_QNODE(srvc_aggre2_noc, SM8250_SLAVE_SERVICE_A2NOC, 1, 4);
> +DEFINE_QNODE(qns_cdsp_mem_noc, SM8250_SLAVE_CDSP_MEM_NOC, 2, 32,
> SM8250_MASTER_COMPUTE_NOC);
> +DEFINE_QNODE(qhs_a1_noc_cfg, SM8250_SLAVE_A1NOC_CFG, 1, 4,
> SM8250_MASTER_A1NOC_CFG);
> +DEFINE_QNODE(qhs_a2_noc_cfg, SM8250_SLAVE_A2NOC_CFG, 1, 4,
> SM8250_MASTER_A2NOC_CFG);
> +DEFINE_QNODE(qhs_ahb2phy0, SM8250_SLAVE_AHB2PHY_SOUTH, 1, 4);
> +DEFINE_QNODE(qhs_ahb2phy1, SM8250_SLAVE_AHB2PHY_NORTH, 1, 4);
> +DEFINE_QNODE(qhs_aoss, SM8250_SLAVE_AOSS, 1, 4);
> +DEFINE_QNODE(qhs_camera_cfg, SM8250_SLAVE_CAMERA_CFG, 1, 4);
> +DEFINE_QNODE(qhs_clk_ctl, SM8250_SLAVE_CLK_CTL, 1, 4);
> +DEFINE_QNODE(qhs_compute_dsp, SM8250_SLAVE_CDSP_CFG, 1, 4);
> +DEFINE_QNODE(qhs_cpr_cx, SM8250_SLAVE_RBCPR_CX_CFG, 1, 4);
> +DEFINE_QNODE(qhs_cpr_mmcx, SM8250_SLAVE_RBCPR_MMCX_CFG, 1, 4);
> +DEFINE_QNODE(qhs_cpr_mx, SM8250_SLAVE_RBCPR_MX_CFG, 1, 4);
> +DEFINE_QNODE(qhs_crypto0_cfg, SM8250_SLAVE_CRYPTO_0_CFG, 1, 4);
> +DEFINE_QNODE(qhs_cx_rdpm, SM8250_SLAVE_CX_RDPM, 1, 4);
> +DEFINE_QNODE(qhs_dcc_cfg, SM8250_SLAVE_DCC_CFG, 1, 4);
> +DEFINE_QNODE(qhs_ddrss_cfg, SM8250_SLAVE_CNOC_DDRSS, 1, 4,
> SM8250_MASTER_CNOC_DC_NOC);
> +DEFINE_QNODE(qhs_display_cfg, SM8250_SLAVE_DISPLAY_CFG, 1, 4);
> +DEFINE_QNODE(qhs_gpuss_cfg, SM8250_SLAVE_GRAPHICS_3D_CFG, 1, 8);
> +DEFINE_QNODE(qhs_imem_cfg, SM8250_SLAVE_IMEM_CFG, 1, 4);
> +DEFINE_QNODE(qhs_ipa, SM8250_SLAVE_IPA_CFG, 1, 4);
> +DEFINE_QNODE(qhs_ipc_router, SM8250_SLAVE_IPC_ROUTER_CFG, 1, 4);
> +DEFINE_QNODE(qhs_lpass_cfg, SM8250_SLAVE_LPASS, 1, 4);
> +DEFINE_QNODE(qhs_mnoc_cfg, SM8250_SLAVE_CNOC_MNOC_CFG, 1, 4,
> SM8250_MASTER_CNOC_MNOC_CFG);
> +DEFINE_QNODE(qhs_npu_cfg, SM8250_SLAVE_NPU_CFG, 1, 4,
> SM8250_MASTER_NPU_NOC_CFG);
> +DEFINE_QNODE(qhs_pcie0_cfg, SM8250_SLAVE_PCIE_0_CFG, 1, 4);
> +DEFINE_QNODE(qhs_pcie1_cfg, SM8250_SLAVE_PCIE_1_CFG, 1, 4);
> +DEFINE_QNODE(qhs_pcie_modem_cfg, SM8250_SLAVE_PCIE_2_CFG, 1, 4);
> +DEFINE_QNODE(qhs_pdm, SM8250_SLAVE_PDM, 1, 4);
> +DEFINE_QNODE(qhs_pimem_cfg, SM8250_SLAVE_PIMEM_CFG, 1, 4);
> +DEFINE_QNODE(qhs_prng, SM8250_SLAVE_PRNG, 1, 4);
> +DEFINE_QNODE(qhs_qdss_cfg, SM8250_SLAVE_QDSS_CFG, 1, 4);
> +DEFINE_QNODE(qhs_qspi, SM8250_SLAVE_QSPI_0, 1, 4);
> +DEFINE_QNODE(qhs_qup0, SM8250_SLAVE_QUP_0, 1, 4);
> +DEFINE_QNODE(qhs_qup1, SM8250_SLAVE_QUP_1, 1, 4);
> +DEFINE_QNODE(qhs_qup2, SM8250_SLAVE_QUP_2, 1, 4);
> +DEFINE_QNODE(qhs_sdc2, SM8250_SLAVE_SDCC_2, 1, 4);
> +DEFINE_QNODE(qhs_sdc4, SM8250_SLAVE_SDCC_4, 1, 4);
> +DEFINE_QNODE(qhs_snoc_cfg, SM8250_SLAVE_SNOC_CFG, 1, 4,
> SM8250_MASTER_SNOC_CFG);
> +DEFINE_QNODE(qhs_tcsr, SM8250_SLAVE_TCSR, 1, 4);
> +DEFINE_QNODE(qhs_tlmm0, SM8250_SLAVE_TLMM_NORTH, 1, 4);
> +DEFINE_QNODE(qhs_tlmm1, SM8250_SLAVE_TLMM_SOUTH, 1, 4);
> +DEFINE_QNODE(qhs_tlmm2, SM8250_SLAVE_TLMM_WEST, 1, 4);
> +DEFINE_QNODE(qhs_tsif, SM8250_SLAVE_TSIF, 1, 4);
> +DEFINE_QNODE(qhs_ufs_card_cfg, SM8250_SLAVE_UFS_CARD_CFG, 1, 4);
> +DEFINE_QNODE(qhs_ufs_mem_cfg, SM8250_SLAVE_UFS_MEM_CFG, 1, 4);
> +DEFINE_QNODE(qhs_usb3_0, SM8250_SLAVE_USB3, 1, 4);
> +DEFINE_QNODE(qhs_usb3_1, SM8250_SLAVE_USB3_1, 1, 4);
> +DEFINE_QNODE(qhs_venus_cfg, SM8250_SLAVE_VENUS_CFG, 1, 4);
> +DEFINE_QNODE(qhs_vsense_ctrl_cfg, SM8250_SLAVE_VSENSE_CTRL_CFG, 1, 4);
> +DEFINE_QNODE(qns_cnoc_a2noc, SM8250_SLAVE_CNOC_A2NOC, 1, 8,
> SM8250_MASTER_CNOC_A2NOC);
> +DEFINE_QNODE(srvc_cnoc, SM8250_SLAVE_SERVICE_CNOC, 1, 4);
> +DEFINE_QNODE(qhs_llcc, SM8250_SLAVE_LLCC_CFG, 1, 4);
> +DEFINE_QNODE(qhs_memnoc, SM8250_SLAVE_GEM_NOC_CFG, 1, 4,
> SM8250_MASTER_GEM_NOC_CFG);
> +DEFINE_QNODE(qns_gem_noc_snoc, SM8250_SLAVE_GEM_NOC_SNOC, 1, 16,
> SM8250_MASTER_GEM_NOC_SNOC);
> +DEFINE_QNODE(qns_llcc, SM8250_SLAVE_LLCC, 4, 16, SM8250_MASTER_LLCC);
> +DEFINE_QNODE(qns_sys_pcie, SM8250_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8,
> SM8250_MASTER_GEM_NOC_PCIE_SNOC);
> +DEFINE_QNODE(srvc_even_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC_1, 1, 4);
> +DEFINE_QNODE(srvc_odd_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC_2, 1, 4);
> +DEFINE_QNODE(srvc_sys_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC, 1, 4);
> +DEFINE_QNODE(ipa_core_slave, SM8250_SLAVE_IPA_CORE, 1, 8);
> +DEFINE_QNODE(ebi, SM8250_SLAVE_EBI_CH0, 4, 4);
> +DEFINE_QNODE(qns_mem_noc_hf, SM8250_SLAVE_MNOC_HF_MEM_NOC, 2, 32,
> SM8250_MASTER_MNOC_HF_MEM_NOC);
> +DEFINE_QNODE(qns_mem_noc_sf, SM8250_SLAVE_MNOC_SF_MEM_NOC, 2, 32,
> SM8250_MASTER_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(srvc_mnoc, SM8250_SLAVE_SERVICE_MNOC, 1, 4);
> +DEFINE_QNODE(qhs_cal_dp0, SM8250_SLAVE_NPU_CAL_DP0, 1, 4);
> +DEFINE_QNODE(qhs_cal_dp1, SM8250_SLAVE_NPU_CAL_DP1, 1, 4);
> +DEFINE_QNODE(qhs_cp, SM8250_SLAVE_NPU_CP, 1, 4);
> +DEFINE_QNODE(qhs_dma_bwmon, SM8250_SLAVE_NPU_INT_DMA_BWMON_CFG, 1, 4);
> +DEFINE_QNODE(qhs_dpm, SM8250_SLAVE_NPU_DPM, 1, 4);
> +DEFINE_QNODE(qhs_isense, SM8250_SLAVE_ISENSE_CFG, 1, 4);
> +DEFINE_QNODE(qhs_llm, SM8250_SLAVE_NPU_LLM_CFG, 1, 4);
> +DEFINE_QNODE(qhs_tcm, SM8250_SLAVE_NPU_TCM, 1, 4);
> +DEFINE_QNODE(qns_npu_sys, SM8250_SLAVE_NPU_COMPUTE_NOC, 2, 32);
> +DEFINE_QNODE(srvc_noc, SM8250_SLAVE_SERVICE_NPU_NOC, 1, 4);
> +DEFINE_QNODE(qhs_apss, SM8250_SLAVE_APPSS, 1, 8);
> +DEFINE_QNODE(qns_cnoc, SM8250_SNOC_CNOC_SLV, 1, 8, 
> SM8250_SNOC_CNOC_MAS);
> +DEFINE_QNODE(qns_gemnoc_gc, SM8250_SLAVE_SNOC_GEM_NOC_GC, 1, 8,
> SM8250_MASTER_SNOC_GC_MEM_NOC);
> +DEFINE_QNODE(qns_gemnoc_sf, SM8250_SLAVE_SNOC_GEM_NOC_SF, 1, 16,
> SM8250_MASTER_SNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qxs_imem, SM8250_SLAVE_OCIMEM, 1, 8);
> +DEFINE_QNODE(qxs_pimem, SM8250_SLAVE_PIMEM, 1, 8);
> +DEFINE_QNODE(srvc_snoc, SM8250_SLAVE_SERVICE_SNOC, 1, 4);
> +DEFINE_QNODE(xs_pcie_0, SM8250_SLAVE_PCIE_0, 1, 8);
> +DEFINE_QNODE(xs_pcie_1, SM8250_SLAVE_PCIE_1, 1, 8);
> +DEFINE_QNODE(xs_pcie_modem, SM8250_SLAVE_PCIE_2, 1, 8);
> +DEFINE_QNODE(xs_qdss_stm, SM8250_SLAVE_QDSS_STM, 1, 4);
> +DEFINE_QNODE(xs_sys_tcu_cfg, SM8250_SLAVE_TCU, 1, 8);
> +

You can keepalive enabled for SH0,
MC0, MM0, SN0 and CN0.

> +DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
> +DEFINE_QBCM(bcm_alc, "ALC", false, &alc);
> +DEFINE_QBCM(bcm_mc0, "MC0", false, &ebi);
> +DEFINE_QBCM(bcm_sh0, "SH0", false, &qns_llcc);
> +DEFINE_QBCM(bcm_mm0, "MM0", false, &qns_mem_noc_hf);
> +DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
> +DEFINE_QBCM(bcm_ip0, "IP0", false, &ipa_core_slave);
> +DEFINE_QBCM(bcm_mm1, "MM1", false, &qnm_camnoc_hf, &qxm_mdp0, 
> &qxm_mdp1);
> +DEFINE_QBCM(bcm_sh2, "SH2", false, &alm_gpu_tcu, &alm_sys_tcu);
> +DEFINE_QBCM(bcm_mm2, "MM2", false, &qns_mem_noc_sf);
> +DEFINE_QBCM(bcm_qup0, "QUP0", false, &qhm_qup1, &qhm_qup2, &qhm_qup0);
> +DEFINE_QBCM(bcm_sh3, "SH3", false, &qnm_cmpnoc);
> +DEFINE_QBCM(bcm_mm3, "MM3", false, &qnm_camnoc_icp, &qnm_camnoc_sf,
> &qnm_video0, &qnm_video1, &qnm_video_cvp);
> +DEFINE_QBCM(bcm_sh4, "SH4", false, &chm_apps);
> +DEFINE_QBCM(bcm_sn0, "SN0", false, &qns_gemnoc_sf);
> +DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_mem_noc);
> +DEFINE_QBCM(bcm_cn0, "CN0", false, &qnm_snoc, &xm_qdss_dap,
> &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy0, &qhs_ahb2phy1,
> &qhs_aoss, &qhs_camera_cfg, &qhs_clk_ctl, &qhs_compute_dsp,
> &qhs_cpr_cx, &qhs_cpr_mmcx, &qhs_cpr_mx, &qhs_crypto0_cfg,
> &qhs_cx_rdpm, &qhs_dcc_cfg, &qhs_ddrss_cfg, &qhs_display_cfg,
> &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_ipc_router,
> &qhs_lpass_cfg, &qhs_mnoc_cfg, &qhs_npu_cfg, &qhs_pcie0_cfg,
> &qhs_pcie1_cfg, &qhs_pcie_modem_cfg, &qhs_pdm, &qhs_pimem_cfg,
> &qhs_prng, &qhs_qdss_cfg, &qhs_qspi, &qhs_qup0, &qhs_qup1, &qhs_qup2,
> &qhs_sdc2, &qhs_sdc4, &qhs_snoc_cfg, &qhs_tcsr, &qhs_tlmm0,
> &qhs_tlmm1, &qhs_tlmm2, &qhs_tsif, &qhs_ufs_card_cfg,
> &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_usb3_1, &qhs_venus_cfg,
> &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc, &srvc_cnoc);
> +DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
> +DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
> +DEFINE_QBCM(bcm_co2, "CO2", false, &qnm_npu);
> +DEFINE_QBCM(bcm_sn3, "SN3", false, &qxs_pimem);
> +DEFINE_QBCM(bcm_sn4, "SN4", false, &xs_qdss_stm);
> +DEFINE_QBCM(bcm_sn5, "SN5", false, &xs_pcie_modem);
> +DEFINE_QBCM(bcm_sn6, "SN6", false, &xs_pcie_0, &xs_pcie_1);
> +DEFINE_QBCM(bcm_sn7, "SN7", false, &qnm_aggre1_noc);
> +DEFINE_QBCM(bcm_sn8, "SN8", false, &qnm_aggre2_noc);
> +DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_gemnoc_pcie);
> +DEFINE_QBCM(bcm_sn11, "SN11", false, &qnm_gemnoc);
> +DEFINE_QBCM(bcm_sn12, "SN12", false, &qns_pcie_modem_mem_noc,
> &qns_pcie_mem_noc);
> +
> +static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
> +	&bcm_qup0,
> +	&bcm_sn12,
> +};
> +
> +static struct qcom_icc_node *aggre1_noc_nodes[] = {
> +	[MASTER_A1NOC_CFG] = &qhm_a1noc_cfg,
> +	[MASTER_QSPI_0] = &qhm_qspi,
> +	[MASTER_QUP_1] = &qhm_qup1,
> +	[MASTER_QUP_2] = &qhm_qup2,
> +	[MASTER_TSIF] = &qhm_tsif,
> +	[MASTER_PCIE_2] = &xm_pcie3_modem,
> +	[MASTER_SDCC_4] = &xm_sdc4,
> +	[MASTER_UFS_MEM] = &xm_ufs_mem,
> +	[MASTER_USB3] = &xm_usb3_0,
> +	[MASTER_USB3_1] = &xm_usb3_1,
> +	[A1NOC_SNOC_SLV] = &qns_a1noc_snoc,
> +	[SLAVE_ANOC_PCIE_GEM_NOC_1] = &qns_pcie_modem_mem_noc,
> +	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
> +};
> +
> +static struct qcom_icc_desc sm8250_aggre1_noc = {
> +	.nodes = aggre1_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
> +	.bcms = aggre1_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
> +	&bcm_ce0,
> +	&bcm_qup0,
> +	&bcm_sn12,
> +};
> +
> +static struct qcom_icc_node *aggre2_noc_nodes[] = {
> +	[MASTER_A2NOC_CFG] = &qhm_a2noc_cfg,
> +	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
> +	[MASTER_QUP_0] = &qhm_qup0,
> +	[MASTER_CNOC_A2NOC] = &qnm_cnoc,
> +	[MASTER_CRYPTO_CORE_0] = &qxm_crypto,
> +	[MASTER_IPA] = &qxm_ipa,
> +	[MASTER_PCIE] = &xm_pcie3_0,
> +	[MASTER_PCIE_1] = &xm_pcie3_1,
> +	[MASTER_QDSS_ETR] = &xm_qdss_etr,
> +	[MASTER_SDCC_2] = &xm_sdc2,
> +	[MASTER_UFS_CARD] = &xm_ufs_card,
> +	[A2NOC_SNOC_SLV] = &qns_a2noc_snoc,
> +	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
> +	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
> +};
> +
> +static struct qcom_icc_desc sm8250_aggre2_noc = {
> +	.nodes = aggre2_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
> +	.bcms = aggre2_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *compute_noc_bcms[] = {
> +	&bcm_co0,
> +	&bcm_co2,
> +};
> +
> +static struct qcom_icc_node *compute_noc_nodes[] = {
> +	[MASTER_NPU] = &qnm_npu,
> +	[SLAVE_CDSP_MEM_NOC] = &qns_cdsp_mem_noc,
> +};
> +
> +static struct qcom_icc_desc sm8250_compute_noc = {
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
> +	[SNOC_CNOC_MAS] = &qnm_snoc,
> +	[MASTER_QDSS_DAP] = &xm_qdss_dap,
> +	[SLAVE_A1NOC_CFG] = &qhs_a1_noc_cfg,
> +	[SLAVE_A2NOC_CFG] = &qhs_a2_noc_cfg,
> +	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
> +	[SLAVE_AHB2PHY_NORTH] = &qhs_ahb2phy1,
> +	[SLAVE_AOSS] = &qhs_aoss,
> +	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
> +	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
> +	[SLAVE_CDSP_CFG] = &qhs_compute_dsp,
> +	[SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
> +	[SLAVE_RBCPR_MMCX_CFG] = &qhs_cpr_mmcx,
> +	[SLAVE_RBCPR_MX_CFG] = &qhs_cpr_mx,
> +	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
> +	[SLAVE_CX_RDPM] = &qhs_cx_rdpm,
> +	[SLAVE_DCC_CFG] = &qhs_dcc_cfg,
> +	[SLAVE_CNOC_DDRSS] = &qhs_ddrss_cfg,
> +	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
> +	[SLAVE_GRAPHICS_3D_CFG] = &qhs_gpuss_cfg,
> +	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
> +	[SLAVE_IPA_CFG] = &qhs_ipa,
> +	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
> +	[SLAVE_LPASS] = &qhs_lpass_cfg,
> +	[SLAVE_CNOC_MNOC_CFG] = &qhs_mnoc_cfg,
> +	[SLAVE_NPU_CFG] = &qhs_npu_cfg,
> +	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
> +	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
> +	[SLAVE_PCIE_2_CFG] = &qhs_pcie_modem_cfg,
> +	[SLAVE_PDM] = &qhs_pdm,
> +	[SLAVE_PIMEM_CFG] = &qhs_pimem_cfg,
> +	[SLAVE_PRNG] = &qhs_prng,
> +	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
> +	[SLAVE_QSPI_0] = &qhs_qspi,
> +	[SLAVE_QUP_0] = &qhs_qup0,
> +	[SLAVE_QUP_1] = &qhs_qup1,
> +	[SLAVE_QUP_2] = &qhs_qup2,
> +	[SLAVE_SDCC_2] = &qhs_sdc2,
> +	[SLAVE_SDCC_4] = &qhs_sdc4,
> +	[SLAVE_SNOC_CFG] = &qhs_snoc_cfg,
> +	[SLAVE_TCSR] = &qhs_tcsr,
> +	[SLAVE_TLMM_NORTH] = &qhs_tlmm0,
> +	[SLAVE_TLMM_SOUTH] = &qhs_tlmm1,
> +	[SLAVE_TLMM_WEST] = &qhs_tlmm2,
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
> +static struct qcom_icc_desc sm8250_config_noc = {
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
> +static struct qcom_icc_desc sm8250_dc_noc = {
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
> +};
> +
> +static struct qcom_icc_node *gem_noc_nodes[] = {
> +	[MASTER_GPU_TCU] = &alm_gpu_tcu,
> +	[MASTER_SYS_TCU] = &alm_sys_tcu,
> +	[MASTER_AMPSS_M0] = &chm_apps,
> +	[MASTER_GEM_NOC_CFG] = &qhm_gemnoc_cfg,
> +	[MASTER_COMPUTE_NOC] = &qnm_cmpnoc,
> +	[MASTER_GRAPHICS_3D] = &qnm_gpu,
> +	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
> +	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
> +	[MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
> +	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
> +	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
> +	[SLAVE_GEM_NOC_SNOC] = &qns_gem_noc_snoc,
> +	[SLAVE_LLCC] = &qns_llcc,
> +	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_sys_pcie,
> +	[SLAVE_SERVICE_GEM_NOC_1] = &srvc_even_gemnoc,
> +	[SLAVE_SERVICE_GEM_NOC_2] = &srvc_odd_gemnoc,
> +	[SLAVE_SERVICE_GEM_NOC] = &srvc_sys_gemnoc,
> +};
> +
> +static struct qcom_icc_desc sm8250_gem_noc = {
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
> +static struct qcom_icc_desc sm8250_ipa_virt = {
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
> +static struct qcom_icc_desc sm8250_mc_virt = {
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
> +	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
> +	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
> +	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
> +	[MASTER_VIDEO_P0] = &qnm_video0,
> +	[MASTER_VIDEO_P1] = &qnm_video1,
> +	[MASTER_VIDEO_PROC] = &qnm_video_cvp,
> +	[MASTER_MDP_PORT0] = &qxm_mdp0,
> +	[MASTER_MDP_PORT1] = &qxm_mdp1,
> +	[MASTER_ROTATOR] = &qxm_rot,
> +	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
> +	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
> +	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
> +};
> +
> +static struct qcom_icc_desc sm8250_mmss_noc = {
> +	.nodes = mmss_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
> +	.bcms = mmss_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *npu_noc_bcms[] = {
> +};
> +
> +static struct qcom_icc_node *npu_noc_nodes[] = {
> +	[MASTER_NPU_SYS] = &amm_npu_sys,
> +	[MASTER_NPU_CDP] = &amm_npu_sys_cdp_w,
> +	[MASTER_NPU_NOC_CFG] = &qhm_cfg,
> +	[SLAVE_NPU_CAL_DP0] = &qhs_cal_dp0,
> +	[SLAVE_NPU_CAL_DP1] = &qhs_cal_dp1,
> +	[SLAVE_NPU_CP] = &qhs_cp,
> +	[SLAVE_NPU_INT_DMA_BWMON_CFG] = &qhs_dma_bwmon,
> +	[SLAVE_NPU_DPM] = &qhs_dpm,
> +	[SLAVE_ISENSE_CFG] = &qhs_isense,
> +	[SLAVE_NPU_LLM_CFG] = &qhs_llm,
> +	[SLAVE_NPU_TCM] = &qhs_tcm,
> +	[SLAVE_NPU_COMPUTE_NOC] = &qns_npu_sys,
> +	[SLAVE_SERVICE_NPU_NOC] = &srvc_noc,
> +};
> +
> +static struct qcom_icc_desc sm8250_npu_noc = {
> +	.nodes = npu_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(npu_noc_nodes),
> +	.bcms = npu_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(npu_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *system_noc_bcms[] = {
> +	&bcm_sn0,
> +	&bcm_sn1,
> +	&bcm_sn11,
> +	&bcm_sn2,
> +	&bcm_sn3,
> +	&bcm_sn4,
> +	&bcm_sn5,
> +	&bcm_sn6,
> +	&bcm_sn7,
> +	&bcm_sn8,
> +	&bcm_sn9,
> +};
> +
> +static struct qcom_icc_node *system_noc_nodes[] = {
> +	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
> +	[A1NOC_SNOC_MAS] = &qnm_aggre1_noc,
> +	[A2NOC_SNOC_MAS] = &qnm_aggre2_noc,
> +	[MASTER_GEM_NOC_SNOC] = &qnm_gemnoc,
> +	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
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
> +	[SLAVE_PCIE_2] = &xs_pcie_modem,
> +	[SLAVE_QDSS_STM] = &xs_qdss_stm,
> +	[SLAVE_TCU] = &xs_sys_tcu_cfg,
> +};
> +
> +static struct qcom_icc_desc sm8250_system_noc = {
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
> +	{ .compatible = "qcom,sm8250-aggre1-noc",
> +	  .data = &sm8250_aggre1_noc},
> +	{ .compatible = "qcom,sm8250-aggre2-noc",
> +	  .data = &sm8250_aggre2_noc},
> +	{ .compatible = "qcom,sm8250-compute-noc",
> +	  .data = &sm8250_compute_noc},
> +	{ .compatible = "qcom,sm8250-config-noc",
> +	  .data = &sm8250_config_noc},
> +	{ .compatible = "qcom,sm8250-dc-noc",
> +	  .data = &sm8250_dc_noc},
> +	{ .compatible = "qcom,sm8250-gem-noc",
> +	  .data = &sm8250_gem_noc},
> +	{ .compatible = "qcom,sm8250-ipa-virt",
> +	  .data = &sm8250_ipa_virt},
> +	{ .compatible = "qcom,sm8250-mc-virt",
> +	  .data = &sm8250_mc_virt},
> +	{ .compatible = "qcom,sm8250-mmss-noc",
> +	  .data = &sm8250_mmss_noc},
> +	{ .compatible = "qcom,sm8250-npu-noc",
> +	  .data = &sm8250_npu_noc},
> +	{ .compatible = "qcom,sm8250-system-noc",
> +	  .data = &sm8250_system_noc},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
> +
> +static struct platform_driver qnoc_driver = {
> +	.probe = qnoc_probe,
> +	.remove = qnoc_remove,
> +	.driver = {
> +		.name = "qnoc-sm8250",
> +		.of_match_table = qnoc_of_match,
> +	},
> +};
> +module_platform_driver(qnoc_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm SM8250 NoC driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/interconnect/qcom/sm8250.h
> b/drivers/interconnect/qcom/sm8250.h
> new file mode 100644
> index 000000000000..af4b0b47146f
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sm8250.h
> @@ -0,0 +1,163 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Qualcomm #define SM8250 interconnect IDs
> + *
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_QCOM_SM8250_H
> +#define __DRIVERS_INTERCONNECT_QCOM_SM8250_H
> +
> +#define SM8250_A1NOC_SNOC_MAS			0
> +#define SM8250_A1NOC_SNOC_SLV			1
> +#define SM8250_A2NOC_SNOC_MAS			2
> +#define SM8250_A2NOC_SNOC_SLV			3
> +#define SM8250_MASTER_A1NOC_CFG			4
> +#define SM8250_MASTER_A2NOC_CFG			5
> +#define SM8250_MASTER_ALC			6
> +#define SM8250_MASTER_AMPSS_M0			7
> +#define SM8250_MASTER_ANOC_PCIE_GEM_NOC		8
> +#define SM8250_MASTER_CAMNOC_HF			9
> +#define SM8250_MASTER_CAMNOC_ICP		10
> +#define SM8250_MASTER_CAMNOC_SF			11
> +#define SM8250_MASTER_CNOC_A2NOC		12
> +#define SM8250_MASTER_CNOC_DC_NOC		13
> +#define SM8250_MASTER_CNOC_MNOC_CFG		14
> +#define SM8250_MASTER_COMPUTE_NOC		15
> +#define SM8250_MASTER_CRYPTO_CORE_0		16
> +#define SM8250_MASTER_GEM_NOC_CFG		17
> +#define SM8250_MASTER_GEM_NOC_PCIE_SNOC		18
> +#define SM8250_MASTER_GEM_NOC_SNOC		19
> +#define SM8250_MASTER_GIC			20
> +#define SM8250_MASTER_GPU_TCU			21
> +#define SM8250_MASTER_GRAPHICS_3D		22
> +#define SM8250_MASTER_IPA			23
> +#define SM8250_MASTER_IPA_CORE			24
> +#define SM8250_MASTER_LLCC			25
> +#define SM8250_MASTER_MDP_PORT0			26
> +#define SM8250_MASTER_MDP_PORT1			27
> +#define SM8250_MASTER_MNOC_HF_MEM_NOC		28
> +#define SM8250_MASTER_MNOC_SF_MEM_NOC		29
> +#define SM8250_MASTER_NPU			30
> +#define SM8250_MASTER_NPU_CDP			31
> +#define SM8250_MASTER_NPU_NOC_CFG		32
> +#define SM8250_MASTER_NPU_SYS			33
> +#define SM8250_MASTER_PCIE			34
> +#define SM8250_MASTER_PCIE_1			35
> +#define SM8250_MASTER_PCIE_2			36
> +#define SM8250_MASTER_PIMEM			37
> +#define SM8250_MASTER_QDSS_BAM			38
> +#define SM8250_MASTER_QDSS_DAP			39
> +#define SM8250_MASTER_QDSS_ETR			40
> +#define SM8250_MASTER_QSPI_0			41
> +#define SM8250_MASTER_QUP_0			42
> +#define SM8250_MASTER_QUP_1			43
> +#define SM8250_MASTER_QUP_2			44
> +#define SM8250_MASTER_ROTATOR			45
> +#define SM8250_MASTER_SDCC_2			46
> +#define SM8250_MASTER_SDCC_4			47
> +#define SM8250_MASTER_SNOC_CFG			48
> +#define SM8250_MASTER_SNOC_GC_MEM_NOC		49
> +#define SM8250_MASTER_SNOC_SF_MEM_NOC		50
> +#define SM8250_MASTER_SYS_TCU			51
> +#define SM8250_MASTER_TSIF			52
> +#define SM8250_MASTER_UFS_CARD			53
> +#define SM8250_MASTER_UFS_MEM			54
> +#define SM8250_MASTER_USB3			55
> +#define SM8250_MASTER_USB3_1			56
> +#define SM8250_MASTER_VIDEO_P0			57
> +#define SM8250_MASTER_VIDEO_P1			58
> +#define SM8250_MASTER_VIDEO_PROC		59
> +#define SM8250_SLAVE_A1NOC_CFG			60
> +#define SM8250_SLAVE_A2NOC_CFG			61
> +#define SM8250_SLAVE_AHB2PHY_NORTH		62
> +#define SM8250_SLAVE_AHB2PHY_SOUTH		63
> +#define SM8250_SLAVE_ANOC_PCIE_GEM_NOC		64
> +#define SM8250_SLAVE_ANOC_PCIE_GEM_NOC_1	65
> +#define SM8250_SLAVE_AOSS			66
> +#define SM8250_SLAVE_APPSS			67
> +#define SM8250_SLAVE_CAMERA_CFG			68
> +#define SM8250_SLAVE_CDSP_CFG			69
> +#define SM8250_SLAVE_CDSP_MEM_NOC		70
> +#define SM8250_SLAVE_CLK_CTL			71
> +#define SM8250_SLAVE_CNOC_A2NOC			72
> +#define SM8250_SLAVE_CNOC_DDRSS			73
> +#define SM8250_SLAVE_CNOC_MNOC_CFG		74
> +#define SM8250_SLAVE_CRYPTO_0_CFG		75
> +#define SM8250_SLAVE_CX_RDPM			76
> +#define SM8250_SLAVE_DCC_CFG			77
> +#define SM8250_SLAVE_DISPLAY_CFG		78
> +#define SM8250_SLAVE_EBI_CH0			79
> +#define SM8250_SLAVE_GEM_NOC_CFG		80
> +#define SM8250_SLAVE_GEM_NOC_SNOC		81
> +#define SM8250_SLAVE_GRAPHICS_3D_CFG		82
> +#define SM8250_SLAVE_IMEM_CFG			83
> +#define SM8250_SLAVE_IPA_CFG			84
> +#define SM8250_SLAVE_IPA_CORE			85
> +#define SM8250_SLAVE_IPC_ROUTER_CFG		86
> +#define SM8250_SLAVE_ISENSE_CFG			87
> +#define SM8250_SLAVE_LLCC			88
> +#define SM8250_SLAVE_LLCC_CFG			89
> +#define SM8250_SLAVE_LPASS			90
> +#define SM8250_SLAVE_MEM_NOC_PCIE_SNOC		91
> +#define SM8250_SLAVE_MNOC_HF_MEM_NOC		92
> +#define SM8250_SLAVE_MNOC_SF_MEM_NOC		93
> +#define SM8250_SLAVE_NPU_CAL_DP0		94
> +#define SM8250_SLAVE_NPU_CAL_DP1		95
> +#define SM8250_SLAVE_NPU_CFG			96
> +#define SM8250_SLAVE_NPU_COMPUTE_NOC		97
> +#define SM8250_SLAVE_NPU_CP			98
> +#define SM8250_SLAVE_NPU_DPM			99
> +#define SM8250_SLAVE_NPU_INT_DMA_BWMON_CFG	100
> +#define SM8250_SLAVE_NPU_LLM_CFG		101
> +#define SM8250_SLAVE_NPU_TCM			102
> +#define SM8250_SLAVE_OCIMEM			103
> +#define SM8250_SLAVE_PCIE_0			104
> +#define SM8250_SLAVE_PCIE_0_CFG			105
> +#define SM8250_SLAVE_PCIE_1			106
> +#define SM8250_SLAVE_PCIE_1_CFG			107
> +#define SM8250_SLAVE_PCIE_2			108
> +#define SM8250_SLAVE_PCIE_2_CFG			109
> +#define SM8250_SLAVE_PDM			110
> +#define SM8250_SLAVE_PIMEM			111
> +#define SM8250_SLAVE_PIMEM_CFG			112
> +#define SM8250_SLAVE_PRNG			113
> +#define SM8250_SLAVE_QDSS_CFG			114
> +#define SM8250_SLAVE_QDSS_STM			115
> +#define SM8250_SLAVE_QSPI_0			116
> +#define SM8250_SLAVE_QUP_0			117
> +#define SM8250_SLAVE_QUP_1			118
> +#define SM8250_SLAVE_QUP_2			119
> +#define SM8250_SLAVE_RBCPR_CX_CFG		120
> +#define SM8250_SLAVE_RBCPR_MMCX_CFG		121
> +#define SM8250_SLAVE_RBCPR_MX_CFG		122
> +#define SM8250_SLAVE_SDCC_2			123
> +#define SM8250_SLAVE_SDCC_4			124
> +#define SM8250_SLAVE_SERVICE_A1NOC		125
> +#define SM8250_SLAVE_SERVICE_A2NOC		126
> +#define SM8250_SLAVE_SERVICE_CNOC		127
> +#define SM8250_SLAVE_SERVICE_GEM_NOC		128
> +#define SM8250_SLAVE_SERVICE_GEM_NOC_1		129
> +#define SM8250_SLAVE_SERVICE_GEM_NOC_2		130
> +#define SM8250_SLAVE_SERVICE_MNOC		131
> +#define SM8250_SLAVE_SERVICE_NPU_NOC		132
> +#define SM8250_SLAVE_SERVICE_SNOC		133
> +#define SM8250_SLAVE_SNOC_CFG			134
> +#define SM8250_SLAVE_SNOC_GEM_NOC_GC		135
> +#define SM8250_SLAVE_SNOC_GEM_NOC_SF		136
> +#define SM8250_SLAVE_TCSR			137
> +#define SM8250_SLAVE_TCU			138
> +#define SM8250_SLAVE_TLMM_NORTH			139
> +#define SM8250_SLAVE_TLMM_SOUTH			140
> +#define SM8250_SLAVE_TLMM_WEST			141
> +#define SM8250_SLAVE_TSIF			142
> +#define SM8250_SLAVE_UFS_CARD_CFG		143
> +#define SM8250_SLAVE_UFS_MEM_CFG		144
> +#define SM8250_SLAVE_USB3			145
> +#define SM8250_SLAVE_USB3_1			146
> +#define SM8250_SLAVE_VENUS_CFG			147
> +#define SM8250_SLAVE_VSENSE_CTRL_CFG		148
> +#define SM8250_SNOC_CNOC_MAS			149
> +#define SM8250_SNOC_CNOC_SLV			150
> +
> +#endif

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
