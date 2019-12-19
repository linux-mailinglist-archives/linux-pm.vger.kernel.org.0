Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7278712626B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 13:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfLSMlV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 07:41:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41341 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfLSMlV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 07:41:21 -0500
Received: by mail-ed1-f65.google.com with SMTP id c26so4728413eds.8
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 04:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NLiipgEST5BEg37TFrXdhty71tDMIsDUb5lR7VrvgPU=;
        b=DMdLTMAsClKKY64ymPKjgXGwxYmow5VbF5ojHoZOVhPkg3KziWUkjubBs6/DKC1RZS
         7z+ZVth6u0bKRfEDwETxds9rXwuh2ZRGh8eYj81FkSU08rW58f2TwaQX9SjYt86ZpHug
         KOSeh+gY5zvEokkNh2phGhuMEjwvRcHNyNjKWoglWBhUNvbnPVG+InyRJfQuciv24YTB
         DA05CraD1H9bxSA4El9nHszkIMTnFvWwumH72pdybQ7vpsSFoUC6YFadEwZtRhqKfcOR
         HW7rtrxc8jDVqQzNOYq+cr2anbpIx6HBgDbRgUB/3h6/hk4ulGmUr36avZbnX268fPtE
         tBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NLiipgEST5BEg37TFrXdhty71tDMIsDUb5lR7VrvgPU=;
        b=jFgt6v071xoP4iuSFaisZ0vu1PPu458QhAl2ySZ8pJHykQH5ILwpAa3v+Bpig1yj4F
         jsdRuG1AH+cWCdr4Zd8i/eWuSRkidwWe1GrDWVREv/iIK9CWUnB0xXeuUWIW8QGhHPdC
         xYWiQ9XJwwJRFwPfq1OWbcknAIKK9GehicJEd4hDwfY9sFTKEW1rzhc5zSL2H3rlr7jr
         eutM0fZOazvFUN/1+ebSzDKpPgfLD5t5LC7kuGr/wHhOm8cg/hy0gyhz6ukC82sa21la
         /qVwz3sZY0O4w1RYxGtQHziEQbgBYsWvA4ejxT6QAeGhHtoZN6mjivsKB9XIhtr6Qd4s
         u4cw==
X-Gm-Message-State: APjAAAU062DNLT+NCvLBLJVMVEy6r+83ac/4D9UmTe0YBsIPFHFGSPSN
        8bJS+7v0xqZm7RSmQ7VeQTEPLw==
X-Google-Smtp-Source: APXvYqwPGS/aS1Q7CIrAbE5cA68n6FrMopk9q0NOvuhtpzZF0/nMyvWoM1TF17KqzRGh7VA0rmbkAg==
X-Received: by 2002:a17:906:1356:: with SMTP id x22mr9304826ejb.55.1576759277597;
        Thu, 19 Dec 2019 04:41:17 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.193])
        by smtp.googlemail.com with ESMTPSA id m24sm379267edr.83.2019.12.19.04.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 04:41:16 -0800 (PST)
Subject: Re: [PATCH V1 2/2] interconnect: qcom: Add SC7180 interconnect
 provider driver
To:     Odelu Kukatla <okukatla@codeaurora.org>, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com, sboyd@kernel.org,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
References: <1574780408-21282-1-git-send-email-okukatla@codeaurora.org>
 <0101016ea83b71b7-4a22a4a7-cab8-4047-a18a-c0327edbe707-000000@us-west-2.amazonses.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <791798fa-a1d9-9a8a-b4e6-0f5b705a3d78@linaro.org>
Date:   Thu, 19 Dec 2019 14:41:13 +0200
MIME-Version: 1.0
In-Reply-To: <0101016ea83b71b7-4a22a4a7-cab8-4047-a18a-c0327edbe707-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Odelu,

On 26.11.19 г. 17:01 ч., Odelu Kukatla wrote:
> Add driver for the Qualcomm interconnect buses found in SC7180 based
> platforms. The topology consists of three NoCs that are controlled by

Just three NoCs, really?

> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>   drivers/interconnect/qcom/Kconfig  |  10 +
>   drivers/interconnect/qcom/Makefile |   2 +
>   drivers/interconnect/qcom/sc7180.c | 843 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 855 insertions(+)
>   create mode 100644 drivers/interconnect/qcom/sc7180.c
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 8ff255d..6f12713 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -14,6 +14,16 @@ config INTERCONNECT_QCOM_QCS404
>   	  This is a driver for the Qualcomm Network-on-Chip on qcs404-based
>   	  platforms.
>   
> +config INTERCONNECT_QCOM_SC7180
> +	tristate "Qualcomm SC7180 interconnect driver"
> +	depends on INTERCONNECT_QCOM
> +	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
> +	select INTERCONNECT_QCOM_RPMH
> +	select INTERCONNECT_QCOM_BCM_VOTER
> +	help
> +	  This is a driver for the Qualcomm Network-on-Chip on sc7180-based
> +	  platforms.
> +
>   config INTERCONNECT_QCOM_SDM845
>   	tristate "Qualcomm SDM845 interconnect driver"
>   	depends on INTERCONNECT_QCOM
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 0f5e88d..793ca42 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -1,12 +1,14 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   qnoc-qcs404-objs			:= qcs404.o
> +qnoc-sc7180-objs			:= sc7180.o
>   qnoc-sdm845-objs			:= sdm845.o
>   icc-smd-rpm-objs			:= smd-rpm.o
>   bcm-voter-objs				:= bcm-voter.o
>   icc-rpmh-obj				:= icc-rpmh.o
>   
>   obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
>   obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += bcm-voter.o
> diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
> new file mode 100644
> index 0000000..e14492e
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sc7180.c
> @@ -0,0 +1,843 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <asm/div64.h>

Is this used?

> +#include <dt-bindings/interconnect/qcom,sc7180.h>
> +#include <linux/device.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/io.h>

unused?

> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/sort.h>

unused?

> +
> +#include "icc-rpmh.h"
> +#include "bcm-voter.h"
> +
> +DEFINE_QNODE(qhm_a1noc_cfg, MASTER_A1NOC_CFG, 1, 4, 1,
> +		SLAVE_SERVICE_A1NOC);

Nit: Doesn't this fit on a single line? If you prefer to keep
it this way, please align to the open parenthesis.

> +DEFINE_QNODE(qhm_qspi, MASTER_QSPI, 1, 4, 1,
> +		SLAVE_A1NOC_SNOC);
> +DEFINE_QNODE(qhm_qup_0, MASTER_QUP_0, 1, 4, 1,
> +		SLAVE_A1NOC_SNOC);
> +DEFINE_QNODE(xm_sdc2, MASTER_SDCC_2, 1, 8, 1,
> +		SLAVE_A1NOC_SNOC);
> +DEFINE_QNODE(xm_emmc, MASTER_EMMC, 1, 8, 1,
> +		SLAVE_A1NOC_SNOC);
> +DEFINE_QNODE(xm_ufs_mem, MASTER_UFS_MEM, 1, 8, 1,
> +		SLAVE_A1NOC_SNOC);
> +DEFINE_QNODE(qhm_a2noc_cfg, MASTER_A2NOC_CFG, 1, 4, 1,
> +		SLAVE_SERVICE_A2NOC);
> +DEFINE_QNODE(qhm_qdss_bam, MASTER_QDSS_BAM, 1, 4, 1,
> +		SLAVE_A2NOC_SNOC);
> +DEFINE_QNODE(qhm_qup_1, MASTER_QUP_1, 1, 4, 1,
> +		SLAVE_A2NOC_SNOC);
> +DEFINE_QNODE(qxm_crypto, MASTER_CRYPTO, 1, 8, 1,
> +		SLAVE_A2NOC_SNOC);
> +DEFINE_QNODE(qxm_ipa, MASTER_IPA, 1, 8, 1,
> +		SLAVE_A2NOC_SNOC);
> +DEFINE_QNODE(xm_qdss_etr, MASTER_QDSS_ETR, 1, 8, 1,
> +		SLAVE_A2NOC_SNOC);
> +DEFINE_QNODE(qhm_usb3, MASTER_USB3, 1, 8, 1,
> +		SLAVE_A2NOC_SNOC);
> +DEFINE_QNODE(qxm_camnoc_hf0_uncomp, MASTER_CAMNOC_HF0_UNCOMP, 1, 32, 1,
> +		SLAVE_CAMNOC_UNCOMP);
> +DEFINE_QNODE(qxm_camnoc_hf1_uncomp, MASTER_CAMNOC_HF1_UNCOMP, 1, 32, 1,
> +		SLAVE_CAMNOC_UNCOMP);
> +DEFINE_QNODE(qxm_camnoc_sf_uncomp, MASTER_CAMNOC_SF_UNCOMP, 1, 32, 1,
> +		SLAVE_CAMNOC_UNCOMP);
> +DEFINE_QNODE(qnm_npu, MASTER_NPU, 2, 32, 1,
> +		SLAVE_CDSP_GEM_NOC);
> +DEFINE_QNODE(qxm_npu_dsp, MASTER_NPU_PROC, 1, 8, 1,
> +		SLAVE_CDSP_GEM_NOC);
> +DEFINE_QNODE(qnm_snoc, MASTER_SNOC_CNOC, 1, 8, 51,
> +		SLAVE_A1NOC_CFG, SLAVE_A2NOC_CFG,
> +		SLAVE_AHB2PHY_SOUTH, SLAVE_AHB2PHY_CENTER,
> +		SLAVE_AOP, SLAVE_AOSS,
> +		SLAVE_BOOT_ROM, SLAVE_CAMERA_CFG,
> +		SLAVE_CAMERA_NRT_THROTTLE_CFG, SLAVE_CAMERA_RT_THROTTLE_CFG,
> +		SLAVE_CLK_CTL, SLAVE_RBCPR_CX_CFG,
> +		SLAVE_RBCPR_MX_CFG, SLAVE_CRYPTO_0_CFG,
> +		SLAVE_DCC_CFG, SLAVE_CNOC_DDRSS,
> +		SLAVE_DISPLAY_CFG, SLAVE_DISPLAY_RT_THROTTLE_CFG,
> +		SLAVE_DISPLAY_THROTTLE_CFG, SLAVE_EMMC_CFG,
> +		SLAVE_GLM, SLAVE_GFX3D_CFG,
> +		SLAVE_IMEM_CFG, SLAVE_IPA_CFG,
> +		SLAVE_CNOC_MNOC_CFG, SLAVE_CNOC_MSS,
> +		SLAVE_NPU_CFG, SLAVE_NPU_DMA_BWMON_CFG,
> +		SLAVE_NPU_PROC_BWMON_CFG, SLAVE_PDM,
> +		SLAVE_PIMEM_CFG, SLAVE_PRNG,
> +		SLAVE_QDSS_CFG, SLAVE_QM_CFG,
> +		SLAVE_QM_MPU_CFG, SLAVE_QSPI_0,
> +		SLAVE_QUP_0, SLAVE_QUP_1,
> +		SLAVE_SDCC_2, SLAVE_SECURITY,
> +		SLAVE_SNOC_CFG, SLAVE_TCSR,
> +		SLAVE_TLMM_WEST, SLAVE_TLMM_NORTH,
> +		SLAVE_TLMM_SOUTH, SLAVE_UFS_MEM_CFG,
> +		SLAVE_USB3, SLAVE_VENUS_CFG,
> +		SLAVE_VENUS_THROTTLE_CFG, SLAVE_VSENSE_CTRL_CFG,
> +		SLAVE_SERVICE_CNOC);
> +DEFINE_QNODE(xm_qdss_dap, MASTER_QDSS_DAP, 1, 8, 51,
> +		SLAVE_A1NOC_CFG, SLAVE_A2NOC_CFG,
> +		SLAVE_AHB2PHY_SOUTH, SLAVE_AHB2PHY_CENTER,
> +		SLAVE_AOP, SLAVE_AOSS,
> +		SLAVE_BOOT_ROM, SLAVE_CAMERA_CFG,
> +		SLAVE_CAMERA_NRT_THROTTLE_CFG, SLAVE_CAMERA_RT_THROTTLE_CFG,
> +		SLAVE_CLK_CTL, SLAVE_RBCPR_CX_CFG,
> +		SLAVE_RBCPR_MX_CFG, SLAVE_CRYPTO_0_CFG,
> +		SLAVE_DCC_CFG, SLAVE_CNOC_DDRSS,
> +		SLAVE_DISPLAY_CFG, SLAVE_DISPLAY_RT_THROTTLE_CFG,
> +		SLAVE_DISPLAY_THROTTLE_CFG, SLAVE_EMMC_CFG,
> +		SLAVE_GLM, SLAVE_GFX3D_CFG,
> +		SLAVE_IMEM_CFG, SLAVE_IPA_CFG,
> +		SLAVE_CNOC_MNOC_CFG, SLAVE_CNOC_MSS,
> +		SLAVE_NPU_CFG, SLAVE_NPU_DMA_BWMON_CFG,
> +		SLAVE_NPU_PROC_BWMON_CFG, SLAVE_PDM,
> +		SLAVE_PIMEM_CFG, SLAVE_PRNG,
> +		SLAVE_QDSS_CFG, SLAVE_QM_CFG,
> +		SLAVE_QM_MPU_CFG, SLAVE_QSPI_0,
> +		SLAVE_QUP_0, SLAVE_QUP_1,
> +		SLAVE_SDCC_2, SLAVE_SECURITY,
> +		SLAVE_SNOC_CFG, SLAVE_TCSR,
> +		SLAVE_TLMM_WEST, SLAVE_TLMM_NORTH,
> +		SLAVE_TLMM_SOUTH, SLAVE_UFS_MEM_CFG,
> +		SLAVE_USB3, SLAVE_VENUS_CFG,
> +		SLAVE_VENUS_THROTTLE_CFG, SLAVE_VSENSE_CTRL_CFG,
> +		SLAVE_SERVICE_CNOC);
> +DEFINE_QNODE(qhm_cnoc_dc_noc, MASTER_CNOC_DC_NOC, 1, 4, 2,
> +		SLAVE_GEM_NOC_CFG, SLAVE_LLCC_CFG);
> +DEFINE_QNODE(acm_apps0, MASTER_APPSS_PROC, 1, 16, 2,
> +		SLAVE_GEM_NOC_SNOC, SLAVE_LLCC);
> +DEFINE_QNODE(acm_sys_tcu, MASTER_SYS_TCU, 1, 8, 2,
> +		SLAVE_GEM_NOC_SNOC, SLAVE_LLCC);
> +DEFINE_QNODE(qhm_gemnoc_cfg, MASTER_GEM_NOC_CFG, 1, 4, 2,
> +		SLAVE_MSS_PROC_MS_MPU_CFG, SLAVE_SERVICE_GEM_NOC);
> +DEFINE_QNODE(qnm_cmpnoc, MASTER_COMPUTE_NOC, 1, 32, 2,
> +		SLAVE_GEM_NOC_SNOC, SLAVE_LLCC);
> +DEFINE_QNODE(qnm_mnoc_hf, MASTER_MNOC_HF_MEM_NOC, 1, 32, 1,
> +		SLAVE_LLCC);
> +DEFINE_QNODE(qnm_mnoc_sf, MASTER_MNOC_SF_MEM_NOC, 1, 32, 2,
> +		SLAVE_GEM_NOC_SNOC, SLAVE_LLCC);
> +DEFINE_QNODE(qnm_snoc_gc, MASTER_SNOC_GC_MEM_NOC, 1, 8, 1,
> +		SLAVE_LLCC);
> +DEFINE_QNODE(qnm_snoc_sf, MASTER_SNOC_SF_MEM_NOC, 1, 16, 1,
> +		SLAVE_LLCC);
> +DEFINE_QNODE(qxm_gpu, MASTER_GFX3D, 2, 32, 2,
> +		SLAVE_GEM_NOC_SNOC, SLAVE_LLCC);
> +DEFINE_QNODE(ipa_core_master, MASTER_IPA_CORE, 1, 8, 1,
> +		SLAVE_IPA_CORE);
> +DEFINE_QNODE(llcc_mc, MASTER_LLCC, 2, 4, 1,
> +		SLAVE_EBI1);
> +DEFINE_QNODE(qhm_mnoc_cfg, MASTER_CNOC_MNOC_CFG, 1, 4, 1,
> +		SLAVE_SERVICE_MNOC);
> +DEFINE_QNODE(qxm_camnoc_hf0, MASTER_CAMNOC_HF0, 2, 32, 1,
> +		SLAVE_MNOC_HF_MEM_NOC);
> +DEFINE_QNODE(qxm_camnoc_hf1, MASTER_CAMNOC_HF1, 2, 32, 1,
> +		SLAVE_MNOC_HF_MEM_NOC);
> +DEFINE_QNODE(qxm_camnoc_sf, MASTER_CAMNOC_SF, 1, 32, 1,
> +		SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qxm_mdp0, MASTER_MDP0, 1, 32, 1,
> +		SLAVE_MNOC_HF_MEM_NOC);
> +DEFINE_QNODE(qxm_rot, MASTER_ROTATOR, 1, 16, 1,
> +		SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qxm_venus0, MASTER_VIDEO_P0, 1, 32, 1,
> +		SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qxm_venus_arm9, MASTER_VIDEO_PROC, 1, 8, 1,
> +		SLAVE_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(amm_npu_sys, MASTER_NPU_SYS, 2, 32, 1,
> +		SLAVE_NPU_COMPUTE_NOC);
> +DEFINE_QNODE(qhm_npu_cfg, MASTER_NPU_NOC_CFG, 1, 4, 8,
> +		SLAVE_NPU_CAL_DP0, SLAVE_NPU_CP,
> +		SLAVE_NPU_INT_DMA_BWMON_CFG, SLAVE_NPU_DPM,
> +		SLAVE_ISENSE_CFG, SLAVE_NPU_LLM_CFG,
> +		SLAVE_NPU_TCM, SLAVE_SERVICE_NPU_NOC);
> +DEFINE_QNODE(qup_core_master_1, MASTER_QUP_CORE_0, 1, 4, 1,
> +		SLAVE_QUP_CORE_0);
> +DEFINE_QNODE(qup_core_master_2, MASTER_QUP_CORE_1, 1, 4, 1,
> +		SLAVE_QUP_CORE_1);
> +DEFINE_QNODE(qhm_snoc_cfg, MASTER_SNOC_CFG, 1, 4, 1,
> +		SLAVE_SERVICE_SNOC);
> +DEFINE_QNODE(qnm_aggre1_noc, MASTER_A1NOC_SNOC, 1, 16, 6,
> +		SLAVE_APPSS, SLAVE_SNOC_CNOC,
> +		SLAVE_SNOC_GEM_NOC_SF, SLAVE_IMEM,
> +		SLAVE_PIMEM, SLAVE_QDSS_STM);
> +DEFINE_QNODE(qnm_aggre2_noc, MASTER_A2NOC_SNOC, 1, 16, 7,
> +		SLAVE_APPSS, SLAVE_SNOC_CNOC,
> +		SLAVE_SNOC_GEM_NOC_SF, SLAVE_IMEM,
> +		SLAVE_PIMEM, SLAVE_QDSS_STM,
> +		SLAVE_TCU);
> +DEFINE_QNODE(qnm_gemnoc, MASTER_GEM_NOC_SNOC, 1, 8, 6,
> +		SLAVE_APPSS, SLAVE_SNOC_CNOC,
> +		SLAVE_IMEM, SLAVE_PIMEM,
> +		SLAVE_QDSS_STM, SLAVE_TCU);
> +DEFINE_QNODE(qxm_pimem, MASTER_PIMEM, 1, 8, 2,
> +		SLAVE_SNOC_GEM_NOC_GC, SLAVE_IMEM);
> +
> +DEFINE_QNODE(qns_a1noc_snoc, SLAVE_A1NOC_SNOC, 1, 16, 1,
> +		MASTER_A1NOC_SNOC);
> +DEFINE_QNODE(srvc_aggre1_noc, SLAVE_SERVICE_A1NOC, 1, 4, 0);
> +DEFINE_QNODE(qns_a2noc_snoc, SLAVE_A2NOC_SNOC, 1, 16, 1,
> +		MASTER_A2NOC_SNOC);
> +DEFINE_QNODE(srvc_aggre2_noc, SLAVE_SERVICE_A2NOC, 1, 4, 0);
> +DEFINE_QNODE(qns_camnoc_uncomp, SLAVE_CAMNOC_UNCOMP, 1, 32, 0);
> +DEFINE_QNODE(qns_cdsp_gemnoc, SLAVE_CDSP_GEM_NOC, 1, 32, 1,
> +		MASTER_COMPUTE_NOC);
> +DEFINE_QNODE(qhs_a1_noc_cfg, SLAVE_A1NOC_CFG, 1, 4, 1,
> +		MASTER_A1NOC_CFG);
> +DEFINE_QNODE(qhs_a2_noc_cfg, SLAVE_A2NOC_CFG, 1, 4, 1,
> +		MASTER_A2NOC_CFG);
> +DEFINE_QNODE(qhs_ahb2phy0, SLAVE_AHB2PHY_SOUTH, 1, 4, 0);
> +DEFINE_QNODE(qhs_ahb2phy2, SLAVE_AHB2PHY_CENTER, 1, 4, 0);
> +DEFINE_QNODE(qhs_aop, SLAVE_AOP, 1, 4, 0);
> +DEFINE_QNODE(qhs_aoss, SLAVE_AOSS, 1, 4, 0);
> +DEFINE_QNODE(qhs_boot_rom, SLAVE_BOOT_ROM, 1, 4, 0);
> +DEFINE_QNODE(qhs_camera_cfg, SLAVE_CAMERA_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_camera_nrt_throttle_cfg,
> +		SLAVE_CAMERA_NRT_THROTTLE_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_camera_rt_throttle_cfg,
> +		SLAVE_CAMERA_RT_THROTTLE_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_clk_ctl, SLAVE_CLK_CTL, 1, 4, 0);
> +DEFINE_QNODE(qhs_cpr_cx, SLAVE_RBCPR_CX_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_cpr_mx, SLAVE_RBCPR_MX_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_crypto0_cfg, SLAVE_CRYPTO_0_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_dcc_cfg, SLAVE_DCC_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_ddrss_cfg, SLAVE_CNOC_DDRSS, 1, 4, 1,
> +		MASTER_CNOC_DC_NOC);
> +DEFINE_QNODE(qhs_display_cfg, SLAVE_DISPLAY_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_display_rt_throttle_cfg,
> +		SLAVE_DISPLAY_RT_THROTTLE_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_display_throttle_cfg, SLAVE_DISPLAY_THROTTLE_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_emmc_cfg, SLAVE_EMMC_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_glm, SLAVE_GLM, 1, 4, 0);
> +DEFINE_QNODE(qhs_gpuss_cfg, SLAVE_GFX3D_CFG, 1, 8, 0);
> +DEFINE_QNODE(qhs_imem_cfg, SLAVE_IMEM_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_ipa, SLAVE_IPA_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_mnoc_cfg, SLAVE_CNOC_MNOC_CFG, 1, 4, 1,
> +		MASTER_CNOC_MNOC_CFG);
> +DEFINE_QNODE(qhs_mss_cfg, SLAVE_CNOC_MSS, 1, 4, 0);
> +DEFINE_QNODE(qhs_npu_cfg, SLAVE_NPU_CFG, 1, 4, 1,
> +		MASTER_NPU_NOC_CFG);
> +DEFINE_QNODE(qhs_npu_dma_throttle_cfg, SLAVE_NPU_DMA_BWMON_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_npu_dsp_throttle_cfg, SLAVE_NPU_PROC_BWMON_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_pdm, SLAVE_PDM, 1, 4, 0);
> +DEFINE_QNODE(qhs_pimem_cfg, SLAVE_PIMEM_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_prng, SLAVE_PRNG, 1, 4, 0);
> +DEFINE_QNODE(qhs_qdss_cfg, SLAVE_QDSS_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_qm_cfg, SLAVE_QM_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_qm_mpu_cfg, SLAVE_QM_MPU_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_qspi, SLAVE_QSPI_0, 1, 4, 0);
> +DEFINE_QNODE(qhs_qup0, SLAVE_QUP_0, 1, 4, 0);
> +DEFINE_QNODE(qhs_qup1, SLAVE_QUP_1, 1, 4, 0);
> +DEFINE_QNODE(qhs_sdc2, SLAVE_SDCC_2, 1, 4, 0);
> +DEFINE_QNODE(qhs_security, SLAVE_SECURITY, 1, 4, 0);
> +DEFINE_QNODE(qhs_snoc_cfg, SLAVE_SNOC_CFG, 1, 4, 1,
> +		MASTER_SNOC_CFG);
> +DEFINE_QNODE(qhs_tcsr, SLAVE_TCSR, 1, 4, 0);
> +DEFINE_QNODE(qhs_tlmm_1, SLAVE_TLMM_WEST, 1, 4, 0);
> +DEFINE_QNODE(qhs_tlmm_2, SLAVE_TLMM_NORTH, 1, 4, 0);
> +DEFINE_QNODE(qhs_tlmm_3, SLAVE_TLMM_SOUTH, 1, 4, 0);
> +DEFINE_QNODE(qhs_ufs_mem_cfg, SLAVE_UFS_MEM_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_usb3, SLAVE_USB3, 1, 4, 0);
> +DEFINE_QNODE(qhs_venus_cfg, SLAVE_VENUS_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_venus_throttle_cfg, SLAVE_VENUS_THROTTLE_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_vsense_ctrl_cfg, SLAVE_VSENSE_CTRL_CFG, 1, 4, 0);
> +DEFINE_QNODE(srvc_cnoc, SLAVE_SERVICE_CNOC, 1, 4, 0);
> +DEFINE_QNODE(qhs_gemnoc, SLAVE_GEM_NOC_CFG, 1, 4, 1,
> +		MASTER_GEM_NOC_CFG);
> +DEFINE_QNODE(qhs_llcc, SLAVE_LLCC_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_mdsp_ms_mpu_cfg, SLAVE_MSS_PROC_MS_MPU_CFG, 1, 4, 0);
> +DEFINE_QNODE(qns_gem_noc_snoc, SLAVE_GEM_NOC_SNOC, 1, 8, 1,
> +		MASTER_GEM_NOC_SNOC);
> +DEFINE_QNODE(qns_llcc, SLAVE_LLCC, 1, 16, 1,
> +		MASTER_LLCC);
> +DEFINE_QNODE(srvc_gemnoc, SLAVE_SERVICE_GEM_NOC, 1, 4, 0);
> +DEFINE_QNODE(ipa_core_slave, SLAVE_IPA_CORE, 1, 8, 0);
> +DEFINE_QNODE(ebi, SLAVE_EBI1, 2, 4, 0);
> +DEFINE_QNODE(qns_mem_noc_hf, SLAVE_MNOC_HF_MEM_NOC, 1, 32, 1,
> +		MASTER_MNOC_HF_MEM_NOC);
> +DEFINE_QNODE(qns_mem_noc_sf, SLAVE_MNOC_SF_MEM_NOC, 1, 32, 1,
> +		MASTER_MNOC_SF_MEM_NOC);
> +DEFINE_QNODE(srvc_mnoc, SLAVE_SERVICE_MNOC, 1, 4, 0);
> +DEFINE_QNODE(qhs_cal_dp0, SLAVE_NPU_CAL_DP0, 1, 4, 0);
> +DEFINE_QNODE(qhs_cp, SLAVE_NPU_CP, 1, 4, 0);
> +DEFINE_QNODE(qhs_dma_bwmon, SLAVE_NPU_INT_DMA_BWMON_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_dpm, SLAVE_NPU_DPM, 1, 4, 0);
> +DEFINE_QNODE(qhs_isense, SLAVE_ISENSE_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_llm, SLAVE_NPU_LLM_CFG, 1, 4, 0);
> +DEFINE_QNODE(qhs_tcm, SLAVE_NPU_TCM, 1, 4, 0);
> +DEFINE_QNODE(qns_npu_sys, SLAVE_NPU_COMPUTE_NOC, 2, 32, 0);
> +DEFINE_QNODE(srvc_noc, SLAVE_SERVICE_NPU_NOC, 1, 4, 0);
> +DEFINE_QNODE(qup_core_slave_1, SLAVE_QUP_CORE_0, 1, 4, 0);
> +DEFINE_QNODE(qup_core_slave_2, SLAVE_QUP_CORE_1, 1, 4, 0);
> +DEFINE_QNODE(qhs_apss, SLAVE_APPSS, 1, 8, 0);
> +DEFINE_QNODE(qns_cnoc, SLAVE_SNOC_CNOC, 1, 8, 1,
> +		MASTER_SNOC_CNOC);
> +DEFINE_QNODE(qns_gemnoc_gc, SLAVE_SNOC_GEM_NOC_GC, 1, 8, 1,
> +		MASTER_SNOC_GC_MEM_NOC);
> +DEFINE_QNODE(qns_gemnoc_sf, SLAVE_SNOC_GEM_NOC_SF, 1, 16, 1,
> +		MASTER_SNOC_SF_MEM_NOC);
> +DEFINE_QNODE(qxs_imem, SLAVE_IMEM, 1, 8, 0);
> +DEFINE_QNODE(qxs_pimem, SLAVE_PIMEM, 1, 8, 0);
> +DEFINE_QNODE(srvc_snoc, SLAVE_SERVICE_SNOC, 1, 4, 0);
> +DEFINE_QNODE(xs_qdss_stm, SLAVE_QDSS_STM, 1, 4, 0);
> +DEFINE_QNODE(xs_sys_tcu_cfg, SLAVE_TCU, 1, 8, 0);
> +
> +DEFINE_QBCM(bcm_acv, "ACV", false, 1,
> +		&ebi);
> +DEFINE_QBCM(bcm_mc0, "MC0", true, 1,
> +		&ebi);
> +DEFINE_QBCM(bcm_sh0, "SH0", true, 1,
> +		&qns_llcc);
> +DEFINE_QBCM(bcm_mm0, "MM0", false, 1,
> +		&qns_mem_noc_hf);
> +DEFINE_QBCM(bcm_ce0, "CE0", false, 1,
> +		&qxm_crypto);
> +DEFINE_QBCM(bcm_ip0, "IP0", false, 1,
> +		&ipa_core_slave);
> +DEFINE_QBCM(bcm_cn0, "CN0", true, 48,
> +		&qnm_snoc, &xm_qdss_dap, &qhs_a1_noc_cfg,
> +		&qhs_a2_noc_cfg, &qhs_ahb2phy0, &qhs_aop,
> +		&qhs_aoss, &qhs_boot_rom, &qhs_camera_cfg,
> +		&qhs_camera_nrt_throttle_cfg,
> +		&qhs_camera_rt_throttle_cfg, &qhs_clk_ctl,
> +		&qhs_cpr_cx, &qhs_cpr_mx, &qhs_crypto0_cfg,
> +		&qhs_dcc_cfg, &qhs_ddrss_cfg, &qhs_display_cfg,
> +		&qhs_display_rt_throttle_cfg,
> +		&qhs_display_throttle_cfg, &qhs_glm,
> +		&qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa,
> +		&qhs_mnoc_cfg, &qhs_mss_cfg, &qhs_npu_cfg,
> +		&qhs_npu_dma_throttle_cfg, &qhs_npu_dsp_throttle_cfg,
> +		&qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qm_cfg,
> +		&qhs_qm_mpu_cfg, &qhs_qup0, &qhs_qup1,
> +		&qhs_security, &qhs_snoc_cfg, &qhs_tcsr,
> +		&qhs_tlmm_1, &qhs_tlmm_2, &qhs_tlmm_3,
> +		&qhs_ufs_mem_cfg, &qhs_usb3, &qhs_venus_cfg,
> +		&qhs_venus_throttle_cfg, &qhs_vsense_ctrl_cfg, &srvc_cnoc);
> +DEFINE_QBCM(bcm_mm1, "MM1", false, 8,
> +		&qxm_camnoc_hf0_uncomp, &qxm_camnoc_hf1_uncomp,
> +		&qxm_camnoc_sf_uncomp, &qhm_mnoc_cfg, &qxm_mdp0,
> +		&qxm_rot, &qxm_venus0, &qxm_venus_arm9);
> +DEFINE_QBCM(bcm_sh2, "SH2", false, 1,
> +		&acm_sys_tcu);
> +DEFINE_QBCM(bcm_mm2, "MM2", false, 1,
> +		&qns_mem_noc_sf);
> +DEFINE_QBCM(bcm_qup0, "QUP0", false, 2,
> +		&qup_core_master_1, &qup_core_master_2);
> +DEFINE_QBCM(bcm_sh3, "SH3", false, 1,
> +		&qnm_cmpnoc);
> +DEFINE_QBCM(bcm_sh4, "SH4", false, 1,
> +		&acm_apps0);
> +DEFINE_QBCM(bcm_sn0, "SN0", true, 1,
> +		&qns_gemnoc_sf);
> +DEFINE_QBCM(bcm_co0, "CO0", false, 1,
> +		&qns_cdsp_gemnoc);
> +DEFINE_QBCM(bcm_sn1, "SN1", false, 1,
> +		&qxs_imem);
> +DEFINE_QBCM(bcm_cn1, "CN1", false, 8,
> +		&qhm_qspi, &xm_sdc2, &xm_emmc,
> +		&qhs_ahb2phy2, &qhs_emmc_cfg,
> +		&qhs_pdm, &qhs_qspi, &qhs_sdc2);
> +DEFINE_QBCM(bcm_sn2, "SN2", false, 2,
> +		&qxm_pimem, &qns_gemnoc_gc);
> +DEFINE_QBCM(bcm_co2, "CO2", false, 1,
> +		&qnm_npu);
> +DEFINE_QBCM(bcm_sn3, "SN3", false, 1,
> +		&qxs_pimem);
> +DEFINE_QBCM(bcm_co3, "CO3", false, 1,
> +		&qxm_npu_dsp);
> +DEFINE_QBCM(bcm_sn4, "SN4", false, 1,
> +		&xs_qdss_stm);
> +DEFINE_QBCM(bcm_sn7, "SN7", false, 1,
> +		&qnm_aggre1_noc);
> +DEFINE_QBCM(bcm_sn9, "SN9", false, 1,
> +		&qnm_aggre2_noc);
> +DEFINE_QBCM(bcm_sn12, "SN12", false, 1,
> +		&qnm_gemnoc);
> +
> +static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
> +	&bcm_cn1,
> +};
> +
> +static struct qcom_icc_node *aggre1_noc_nodes[] = {
> +	[MASTER_A1NOC_CFG] = &qhm_a1noc_cfg,
> +	[MASTER_QSPI] = &qhm_qspi,
> +	[MASTER_QUP_0] = &qhm_qup_0,
> +	[MASTER_SDCC_2] = &xm_sdc2,
> +	[MASTER_EMMC] = &xm_emmc,
> +	[MASTER_UFS_MEM] = &xm_ufs_mem,
> +	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
> +	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
> +};
> +
> +static struct qcom_icc_desc sc7180_aggre1_noc = {
> +	.nodes = aggre1_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
> +	.bcms = aggre1_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
> +	&bcm_ce0,
> +};
> +
> +static struct qcom_icc_node *aggre2_noc_nodes[] = {
> +	[MASTER_A2NOC_CFG] = &qhm_a2noc_cfg,
> +	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
> +	[MASTER_QUP_1] = &qhm_qup_1,
> +	[MASTER_USB3] = &qhm_usb3,
> +	[MASTER_CRYPTO] = &qxm_crypto,
> +	[MASTER_IPA] = &qxm_ipa,
> +	[MASTER_QDSS_ETR] = &xm_qdss_etr,
> +	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
> +	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
> +};
> +
> +static struct qcom_icc_desc sc7180_aggre2_noc = {
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
> +static struct qcom_icc_desc sc7180_camnoc_virt = {
> +	.nodes = camnoc_virt_nodes,
> +	.num_nodes = ARRAY_SIZE(camnoc_virt_nodes),
> +	.bcms = camnoc_virt_bcms,
> +	.num_bcms = ARRAY_SIZE(camnoc_virt_bcms),
> +};
> +
> +static struct qcom_icc_bcm *compute_noc_bcms[] = {
> +	&bcm_co0,
> +	&bcm_co2,
> +	&bcm_co3,
> +};
> +
> +static struct qcom_icc_node *compute_noc_nodes[] = {
> +	[MASTER_NPU] = &qnm_npu,
> +	[MASTER_NPU_PROC] = &qxm_npu_dsp,
> +	[SLAVE_CDSP_GEM_NOC] = &qns_cdsp_gemnoc,
> +};
> +
> +static struct qcom_icc_desc sc7180_compute_noc = {
> +	.nodes = compute_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(compute_noc_nodes),
> +	.bcms = compute_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(compute_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *config_noc_bcms[] = {
> +	&bcm_cn0,
> +	&bcm_cn1,
> +};
> +
> +static struct qcom_icc_node *config_noc_nodes[] = {
> +	[MASTER_SNOC_CNOC] = &qnm_snoc,
> +	[MASTER_QDSS_DAP] = &xm_qdss_dap,
> +	[SLAVE_A1NOC_CFG] = &qhs_a1_noc_cfg,
> +	[SLAVE_A2NOC_CFG] = &qhs_a2_noc_cfg,
> +	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
> +	[SLAVE_AHB2PHY_CENTER] = &qhs_ahb2phy2,
> +	[SLAVE_AOP] = &qhs_aop,
> +	[SLAVE_AOSS] = &qhs_aoss,
> +	[SLAVE_BOOT_ROM] = &qhs_boot_rom,
> +	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
> +	[SLAVE_CAMERA_NRT_THROTTLE_CFG] = &qhs_camera_nrt_throttle_cfg,
> +	[SLAVE_CAMERA_RT_THROTTLE_CFG] = &qhs_camera_rt_throttle_cfg,
> +	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
> +	[SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
> +	[SLAVE_RBCPR_MX_CFG] = &qhs_cpr_mx,
> +	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
> +	[SLAVE_DCC_CFG] = &qhs_dcc_cfg,
> +	[SLAVE_CNOC_DDRSS] = &qhs_ddrss_cfg,
> +	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
> +	[SLAVE_DISPLAY_RT_THROTTLE_CFG] = &qhs_display_rt_throttle_cfg,
> +	[SLAVE_DISPLAY_THROTTLE_CFG] = &qhs_display_throttle_cfg,
> +	[SLAVE_EMMC_CFG] = &qhs_emmc_cfg,
> +	[SLAVE_GLM] = &qhs_glm,
> +	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
> +	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
> +	[SLAVE_IPA_CFG] = &qhs_ipa,
> +	[SLAVE_CNOC_MNOC_CFG] = &qhs_mnoc_cfg,
> +	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
> +	[SLAVE_NPU_CFG] = &qhs_npu_cfg,
> +	[SLAVE_NPU_DMA_BWMON_CFG] = &qhs_npu_dma_throttle_cfg,
> +	[SLAVE_NPU_PROC_BWMON_CFG] = &qhs_npu_dsp_throttle_cfg,
> +	[SLAVE_PDM] = &qhs_pdm,
> +	[SLAVE_PIMEM_CFG] = &qhs_pimem_cfg,
> +	[SLAVE_PRNG] = &qhs_prng,
> +	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
> +	[SLAVE_QM_CFG] = &qhs_qm_cfg,
> +	[SLAVE_QM_MPU_CFG] = &qhs_qm_mpu_cfg,
> +	[SLAVE_QSPI_0] = &qhs_qspi,
> +	[SLAVE_QUP_0] = &qhs_qup0,
> +	[SLAVE_QUP_1] = &qhs_qup1,
> +	[SLAVE_SDCC_2] = &qhs_sdc2,
> +	[SLAVE_SECURITY] = &qhs_security,
> +	[SLAVE_SNOC_CFG] = &qhs_snoc_cfg,
> +	[SLAVE_TCSR] = &qhs_tcsr,
> +	[SLAVE_TLMM_WEST] = &qhs_tlmm_1,
> +	[SLAVE_TLMM_NORTH] = &qhs_tlmm_2,
> +	[SLAVE_TLMM_SOUTH] = &qhs_tlmm_3,
> +	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
> +	[SLAVE_USB3] = &qhs_usb3,
> +	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
> +	[SLAVE_VENUS_THROTTLE_CFG] = &qhs_venus_throttle_cfg,
> +	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
> +	[SLAVE_SERVICE_CNOC] = &srvc_cnoc,
> +};
> +
> +static struct qcom_icc_desc sc7180_config_noc = {
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
> +	[SLAVE_GEM_NOC_CFG] = &qhs_gemnoc,
> +	[SLAVE_LLCC_CFG] = &qhs_llcc,
> +};
> +
> +static struct qcom_icc_desc sc7180_dc_noc = {
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
> +	[MASTER_APPSS_PROC] = &acm_apps0,
> +	[MASTER_SYS_TCU] = &acm_sys_tcu,
> +	[MASTER_GEM_NOC_CFG] = &qhm_gemnoc_cfg,
> +	[MASTER_COMPUTE_NOC] = &qnm_cmpnoc,
> +	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
> +	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
> +	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
> +	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
> +	[MASTER_GFX3D] = &qxm_gpu,
> +	[SLAVE_MSS_PROC_MS_MPU_CFG] = &qhs_mdsp_ms_mpu_cfg,
> +	[SLAVE_GEM_NOC_SNOC] = &qns_gem_noc_snoc,
> +	[SLAVE_LLCC] = &qns_llcc,
> +	[SLAVE_SERVICE_GEM_NOC] = &srvc_gemnoc,
> +};
> +
> +static struct qcom_icc_desc sc7180_gem_noc = {
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
> +static struct qcom_icc_desc sc7180_ipa_virt = {
> +	.nodes = ipa_virt_nodes,
> +	.num_nodes = ARRAY_SIZE(ipa_virt_nodes),
> +	.bcms = ipa_virt_bcms,
> +	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
> +};
> +
> +static struct qcom_icc_bcm *mc_virt_bcms[] = {
> +	&bcm_acv,
> +	&bcm_mc0,
> +};
> +
> +static struct qcom_icc_node *mc_virt_nodes[] = {
> +	[MASTER_LLCC] = &llcc_mc,
> +	[SLAVE_EBI1] = &ebi,
> +};
> +
> +static struct qcom_icc_desc sc7180_mc_virt = {
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
> +};
> +
> +static struct qcom_icc_node *mmss_noc_nodes[] = {
> +	[MASTER_CNOC_MNOC_CFG] = &qhm_mnoc_cfg,
> +	[MASTER_CAMNOC_HF0] = &qxm_camnoc_hf0,
> +	[MASTER_CAMNOC_HF1] = &qxm_camnoc_hf1,
> +	[MASTER_CAMNOC_SF] = &qxm_camnoc_sf,
> +	[MASTER_MDP0] = &qxm_mdp0,
> +	[MASTER_ROTATOR] = &qxm_rot,
> +	[MASTER_VIDEO_P0] = &qxm_venus0,
> +	[MASTER_VIDEO_PROC] = &qxm_venus_arm9,
> +	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
> +	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
> +	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
> +};
> +
> +static struct qcom_icc_desc sc7180_mmss_noc = {
> +	.nodes = mmss_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
> +	.bcms = mmss_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *npu_noc_bcms[] = {

No bcms?

> +};
> +
> +static struct qcom_icc_node *npu_noc_nodes[] = {
> +	[MASTER_NPU_SYS] = &amm_npu_sys,
> +	[MASTER_NPU_NOC_CFG] = &qhm_npu_cfg,
> +	[SLAVE_NPU_CAL_DP0] = &qhs_cal_dp0,
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
> +static struct qcom_icc_desc sc7180_npu_noc = {
> +	.nodes = npu_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(npu_noc_nodes),
> +	.bcms = npu_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(npu_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm *qup_virt_bcms[] = {
> +	&bcm_qup0,
> +};
> +
> +static struct qcom_icc_node *qup_virt_nodes[] = {
> +	[MASTER_QUP_CORE_0] = &qup_core_master_1,
> +	[MASTER_QUP_CORE_1] = &qup_core_master_2,
> +	[SLAVE_QUP_CORE_0] = &qup_core_slave_1,
> +	[SLAVE_QUP_CORE_1] = &qup_core_slave_2,
> +};
> +
> +static struct qcom_icc_desc sc7180_qup_virt = {
> +	.nodes = qup_virt_nodes,
> +	.num_nodes = ARRAY_SIZE(qup_virt_nodes),
> +	.bcms = qup_virt_bcms,
> +	.num_bcms = ARRAY_SIZE(qup_virt_bcms),
> +};
> +
> +static struct qcom_icc_bcm *system_noc_bcms[] = {
> +	&bcm_sn0,
> +	&bcm_sn1,
> +	&bcm_sn2,
> +	&bcm_sn3,
> +	&bcm_sn4,
> +	&bcm_sn7,
> +	&bcm_sn9,
> +	&bcm_sn12,
> +};
> +
> +static struct qcom_icc_node *system_noc_nodes[] = {
> +	[MASTER_SNOC_CFG] = &qhm_snoc_cfg,
> +	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
> +	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
> +	[MASTER_GEM_NOC_SNOC] = &qnm_gemnoc,
> +	[MASTER_PIMEM] = &qxm_pimem,
> +	[SLAVE_APPSS] = &qhs_apss,
> +	[SLAVE_SNOC_CNOC] = &qns_cnoc,
> +	[SLAVE_SNOC_GEM_NOC_GC] = &qns_gemnoc_gc,
> +	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
> +	[SLAVE_IMEM] = &qxs_imem,
> +	[SLAVE_PIMEM] = &qxs_pimem,
> +	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
> +	[SLAVE_QDSS_STM] = &xs_qdss_stm,
> +	[SLAVE_TCU] = &xs_sys_tcu_cfg,
> +};
> +
> +static struct qcom_icc_desc sc7180_system_noc = {
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
> +	desc = of_device_get_match_data(&pdev->dev);
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
> +	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	provider = &qp->provider;
> +	provider->dev = &pdev->dev;
> +	provider->set = qcom_icc_set;
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
> +		dev_dbg(&pdev->dev, "registered node %pK %s %d\n", node,
> +			qnodes[i]->name, node->id);
> +
> +		/* populate links */
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
> +	dev_dbg(&pdev->dev, "Registered SC7180 ICC\n");
> +
> +	return ret;
> +err:
> +	list_for_each_entry(node, &provider->nodes, node_list) {
> +		icc_node_del(node);
> +		icc_node_destroy(node->id);
> +	}

You can use the new icc_nodes_remove() helper here..

> +
> +	icc_provider_del(provider);
> +	return ret;
> +}
> +
> +static int qnoc_remove(struct platform_device *pdev)
> +{
> +	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
> +	struct icc_provider *provider = &qp->provider;
> +	struct icc_node *n;
> +
> +	list_for_each_entry(n, &provider->nodes, node_list) {
> +		icc_node_del(n);
> +		icc_node_destroy(n->id);
> +	}

..and here too.

> +
> +	return icc_provider_del(provider);
> +}
> +static const struct of_device_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,sc7180-aggre1-noc",
> +	  .data = &sc7180_aggre1_noc},
> +	{ .compatible = "qcom,sc7180-aggre2-noc",
> +	  .data = &sc7180_aggre2_noc},
> +	{ .compatible = "qcom,sc7180-camnoc-virt",
> +	  .data = &sc7180_camnoc_virt},
> +	{ .compatible = "qcom,sc7180-compute-noc",
> +	  .data = &sc7180_compute_noc},
> +	{ .compatible = "qcom,sc7180-config-noc",
> +	  .data = &sc7180_config_noc},
> +	{ .compatible = "qcom,sc7180-dc-noc",
> +	  .data = &sc7180_dc_noc},
> +	{ .compatible = "qcom,sc7180-gem-noc",
> +	  .data = &sc7180_gem_noc},
> +	{ .compatible = "qcom,sc7180-ipa-virt",
> +	  .data = &sc7180_ipa_virt},
> +	{ .compatible = "qcom,sc7180-mc-virt",
> +	  .data = &sc7180_mc_virt},
> +	{ .compatible = "qcom,sc7180-mmss-noc",
> +	  .data = &sc7180_mmss_noc},
> +	{ .compatible = "qcom,sc7180-npu-noc",
> +	  .data = &sc7180_npu_noc},
> +	{ .compatible = "qcom,sc7180-qup-virt",
> +	  .data = &sc7180_qup_virt},
> +	{ .compatible = "qcom,sc7180-system-noc",
> +	  .data = &sc7180_system_noc},

Nit: I would put these on a same line and ignore the 80 cols, but
it's up to you.

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
> +
> +static struct platform_driver qnoc_driver = {
> +	.probe = qnoc_probe,
> +	.remove = qnoc_remove,
> +	.driver = {
> +		.name = "qnoc-sc7180",
> +		.of_match_table = qnoc_of_match,
> +	},
> +};
> +module_platform_driver(qnoc_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm SC7180 NoC driver");
> +MODULE_LICENSE("GPL v2");
> 

Thanks,
Georgi
