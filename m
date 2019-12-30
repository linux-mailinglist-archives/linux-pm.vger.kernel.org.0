Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A74412D2F6
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 18:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfL3Rv6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 12:51:58 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:37795 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727326AbfL3Rv6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 12:51:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577728317; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4YVzBmGCqF4jW8RzqumGbl/zdJD4TBX5kA44q8jrDP0=;
 b=MHHHa6AhaczxCHp67ylq8FbSB+yKYSR3IioGu/D2z5NA8/C9wGGyX8HPuWKxBgYFNrD1kliY
 YL3vKqpqQw6Qaop3UzECvVDdJmp8mltZIq3wkzhKFVG6ve0inKRqtzmrgQMur1XFFf8OFhql
 rJUolxLmZEA+PNENL4uNrFYqw/w=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0a3939.7f437afa57a0-smtp-out-n01;
 Mon, 30 Dec 2019 17:51:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8DD6BC4479F; Mon, 30 Dec 2019 17:51:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=2.0 tests=ALL_TRUSTED,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6669C43383;
        Mon, 30 Dec 2019 17:51:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Dec 2019 23:21:50 +0530
From:   okukatla@codeaurora.org
To:     Evan Green <evgreen@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>, sboyd@kernel.org,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        Alex Elder <elder@linaro.org>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V1 2/2] interconnect: qcom: Add SC7180 interconnect
 provider driver
In-Reply-To: <CAE=gft7n9m8fOrqgSeH_--jpuz9f9JHCA0+Y7MecfOZkugxkBA@mail.gmail.com>
References: <1574780408-21282-1-git-send-email-okukatla@codeaurora.org>
 <0101016ea83b71b7-4a22a4a7-cab8-4047-a18a-c0327edbe707-000000@us-west-2.amazonses.com>
 <CAE=gft7n9m8fOrqgSeH_--jpuz9f9JHCA0+Y7MecfOZkugxkBA@mail.gmail.com>
Message-ID: <fc2019f78b53e401eb47b3a9e176f818@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-12-07 01:16, Evan Green wrote:
> On Tue, Nov 26, 2019 at 7:01 AM Odelu Kukatla <okukatla@codeaurora.org> 
> wrote:
>> 
>> Add driver for the Qualcomm interconnect buses found in SC7180 based
>> platforms. The topology consists of three NoCs that are controlled by
>> a remote processor that collects the aggregated bandwidth for each
>> master-slave pairs.
>> 
>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
>> ---
>>  drivers/interconnect/qcom/Kconfig  |  10 +
>>  drivers/interconnect/qcom/Makefile |   2 +
>>  drivers/interconnect/qcom/sc7180.c | 843 
>> +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 855 insertions(+)
>>  create mode 100644 drivers/interconnect/qcom/sc7180.c
>> 
> ...
>> diff --git a/drivers/interconnect/qcom/sc7180.c 
>> b/drivers/interconnect/qcom/sc7180.c
>> new file mode 100644
>> index 0000000..e14492e
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/sc7180.c
>> @@ -0,0 +1,843 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>> + *
>> + */
>> +
>> +#include <asm/div64.h>
>> +#include <dt-bindings/interconnect/qcom,sc7180.h>
>> +#include <linux/device.h>
>> +#include <linux/interconnect.h>
>> +#include <linux/interconnect-provider.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/sort.h>
>> +
>> +#include "icc-rpmh.h"
>> +#include "bcm-voter.h"
>> +
>> +DEFINE_QNODE(qhm_a1noc_cfg, MASTER_A1NOC_CFG, 1, 4, 1,
>> +               SLAVE_SERVICE_A1NOC);
>> +DEFINE_QNODE(qhm_qspi, MASTER_QSPI, 1, 4, 1,
>> +               SLAVE_A1NOC_SNOC);
>> +DEFINE_QNODE(qhm_qup_0, MASTER_QUP_0, 1, 4, 1,
>> +               SLAVE_A1NOC_SNOC);
>> +DEFINE_QNODE(xm_sdc2, MASTER_SDCC_2, 1, 8, 1,
>> +               SLAVE_A1NOC_SNOC);
>> +DEFINE_QNODE(xm_emmc, MASTER_EMMC, 1, 8, 1,
>> +               SLAVE_A1NOC_SNOC);
>> +DEFINE_QNODE(xm_ufs_mem, MASTER_UFS_MEM, 1, 8, 1,
>> +               SLAVE_A1NOC_SNOC);
>> +DEFINE_QNODE(qhm_a2noc_cfg, MASTER_A2NOC_CFG, 1, 4, 1,
>> +               SLAVE_SERVICE_A2NOC);
>> +DEFINE_QNODE(qhm_qdss_bam, MASTER_QDSS_BAM, 1, 4, 1,
>> +               SLAVE_A2NOC_SNOC);
>> +DEFINE_QNODE(qhm_qup_1, MASTER_QUP_1, 1, 4, 1,
>> +               SLAVE_A2NOC_SNOC);
>> +DEFINE_QNODE(qxm_crypto, MASTER_CRYPTO, 1, 8, 1,
>> +               SLAVE_A2NOC_SNOC);
>> +DEFINE_QNODE(qxm_ipa, MASTER_IPA, 1, 8, 1,
>> +               SLAVE_A2NOC_SNOC);
>> +DEFINE_QNODE(xm_qdss_etr, MASTER_QDSS_ETR, 1, 8, 1,
>> +               SLAVE_A2NOC_SNOC);
>> +DEFINE_QNODE(qhm_usb3, MASTER_USB3, 1, 8, 1,
>> +               SLAVE_A2NOC_SNOC);
>> +DEFINE_QNODE(qxm_camnoc_hf0_uncomp, MASTER_CAMNOC_HF0_UNCOMP, 1, 32, 
>> 1,
>> +               SLAVE_CAMNOC_UNCOMP);
>> +DEFINE_QNODE(qxm_camnoc_hf1_uncomp, MASTER_CAMNOC_HF1_UNCOMP, 1, 32, 
>> 1,
>> +               SLAVE_CAMNOC_UNCOMP);
>> +DEFINE_QNODE(qxm_camnoc_sf_uncomp, MASTER_CAMNOC_SF_UNCOMP, 1, 32, 1,
>> +               SLAVE_CAMNOC_UNCOMP);
>> +DEFINE_QNODE(qnm_npu, MASTER_NPU, 2, 32, 1,
>> +               SLAVE_CDSP_GEM_NOC);
>> +DEFINE_QNODE(qxm_npu_dsp, MASTER_NPU_PROC, 1, 8, 1,
>> +               SLAVE_CDSP_GEM_NOC);
>> +DEFINE_QNODE(qnm_snoc, MASTER_SNOC_CNOC, 1, 8, 51,
>> +               SLAVE_A1NOC_CFG, SLAVE_A2NOC_CFG,
>> +               SLAVE_AHB2PHY_SOUTH, SLAVE_AHB2PHY_CENTER,
>> +               SLAVE_AOP, SLAVE_AOSS,
>> +               SLAVE_BOOT_ROM, SLAVE_CAMERA_CFG,
>> +               SLAVE_CAMERA_NRT_THROTTLE_CFG, 
>> SLAVE_CAMERA_RT_THROTTLE_CFG,
>> +               SLAVE_CLK_CTL, SLAVE_RBCPR_CX_CFG,
>> +               SLAVE_RBCPR_MX_CFG, SLAVE_CRYPTO_0_CFG,
>> +               SLAVE_DCC_CFG, SLAVE_CNOC_DDRSS,
>> +               SLAVE_DISPLAY_CFG, SLAVE_DISPLAY_RT_THROTTLE_CFG,
>> +               SLAVE_DISPLAY_THROTTLE_CFG, SLAVE_EMMC_CFG,
>> +               SLAVE_GLM, SLAVE_GFX3D_CFG,
>> +               SLAVE_IMEM_CFG, SLAVE_IPA_CFG,
>> +               SLAVE_CNOC_MNOC_CFG, SLAVE_CNOC_MSS,
>> +               SLAVE_NPU_CFG, SLAVE_NPU_DMA_BWMON_CFG,
>> +               SLAVE_NPU_PROC_BWMON_CFG, SLAVE_PDM,
>> +               SLAVE_PIMEM_CFG, SLAVE_PRNG,
>> +               SLAVE_QDSS_CFG, SLAVE_QM_CFG,
>> +               SLAVE_QM_MPU_CFG, SLAVE_QSPI_0,
>> +               SLAVE_QUP_0, SLAVE_QUP_1,
>> +               SLAVE_SDCC_2, SLAVE_SECURITY,
>> +               SLAVE_SNOC_CFG, SLAVE_TCSR,
>> +               SLAVE_TLMM_WEST, SLAVE_TLMM_NORTH,
>> +               SLAVE_TLMM_SOUTH, SLAVE_UFS_MEM_CFG,
>> +               SLAVE_USB3, SLAVE_VENUS_CFG,
>> +               SLAVE_VENUS_THROTTLE_CFG, SLAVE_VSENSE_CTRL_CFG,
>> +               SLAVE_SERVICE_CNOC);
>> +DEFINE_QNODE(xm_qdss_dap, MASTER_QDSS_DAP, 1, 8, 51,
>> +               SLAVE_A1NOC_CFG, SLAVE_A2NOC_CFG,
>> +               SLAVE_AHB2PHY_SOUTH, SLAVE_AHB2PHY_CENTER,
>> +               SLAVE_AOP, SLAVE_AOSS,
>> +               SLAVE_BOOT_ROM, SLAVE_CAMERA_CFG,
>> +               SLAVE_CAMERA_NRT_THROTTLE_CFG, 
>> SLAVE_CAMERA_RT_THROTTLE_CFG,
>> +               SLAVE_CLK_CTL, SLAVE_RBCPR_CX_CFG,
>> +               SLAVE_RBCPR_MX_CFG, SLAVE_CRYPTO_0_CFG,
>> +               SLAVE_DCC_CFG, SLAVE_CNOC_DDRSS,
>> +               SLAVE_DISPLAY_CFG, SLAVE_DISPLAY_RT_THROTTLE_CFG,
>> +               SLAVE_DISPLAY_THROTTLE_CFG, SLAVE_EMMC_CFG,
>> +               SLAVE_GLM, SLAVE_GFX3D_CFG,
>> +               SLAVE_IMEM_CFG, SLAVE_IPA_CFG,
>> +               SLAVE_CNOC_MNOC_CFG, SLAVE_CNOC_MSS,
>> +               SLAVE_NPU_CFG, SLAVE_NPU_DMA_BWMON_CFG,
>> +               SLAVE_NPU_PROC_BWMON_CFG, SLAVE_PDM,
>> +               SLAVE_PIMEM_CFG, SLAVE_PRNG,
>> +               SLAVE_QDSS_CFG, SLAVE_QM_CFG,
>> +               SLAVE_QM_MPU_CFG, SLAVE_QSPI_0,
>> +               SLAVE_QUP_0, SLAVE_QUP_1,
>> +               SLAVE_SDCC_2, SLAVE_SECURITY,
>> +               SLAVE_SNOC_CFG, SLAVE_TCSR,
>> +               SLAVE_TLMM_WEST, SLAVE_TLMM_NORTH,
>> +               SLAVE_TLMM_SOUTH, SLAVE_UFS_MEM_CFG,
>> +               SLAVE_USB3, SLAVE_VENUS_CFG,
>> +               SLAVE_VENUS_THROTTLE_CFG, SLAVE_VSENSE_CTRL_CFG,
>> +               SLAVE_SERVICE_CNOC);
>> +DEFINE_QNODE(qhm_cnoc_dc_noc, MASTER_CNOC_DC_NOC, 1, 4, 2,
>> +               SLAVE_GEM_NOC_CFG, SLAVE_LLCC_CFG);
>> +DEFINE_QNODE(acm_apps0, MASTER_APPSS_PROC, 1, 16, 2,
>> +               SLAVE_GEM_NOC_SNOC, SLAVE_LLCC);
>> +DEFINE_QNODE(acm_sys_tcu, MASTER_SYS_TCU, 1, 8, 2,
>> +               SLAVE_GEM_NOC_SNOC, SLAVE_LLCC);
>> +DEFINE_QNODE(qhm_gemnoc_cfg, MASTER_GEM_NOC_CFG, 1, 4, 2,
>> +               SLAVE_MSS_PROC_MS_MPU_CFG, SLAVE_SERVICE_GEM_NOC);
>> +DEFINE_QNODE(qnm_cmpnoc, MASTER_COMPUTE_NOC, 1, 32, 2,
>> +               SLAVE_GEM_NOC_SNOC, SLAVE_LLCC);
>> +DEFINE_QNODE(qnm_mnoc_hf, MASTER_MNOC_HF_MEM_NOC, 1, 32, 1,
>> +               SLAVE_LLCC);
>> +DEFINE_QNODE(qnm_mnoc_sf, MASTER_MNOC_SF_MEM_NOC, 1, 32, 2,
>> +               SLAVE_GEM_NOC_SNOC, SLAVE_LLCC);
>> +DEFINE_QNODE(qnm_snoc_gc, MASTER_SNOC_GC_MEM_NOC, 1, 8, 1,
>> +               SLAVE_LLCC);
>> +DEFINE_QNODE(qnm_snoc_sf, MASTER_SNOC_SF_MEM_NOC, 1, 16, 1,
>> +               SLAVE_LLCC);
>> +DEFINE_QNODE(qxm_gpu, MASTER_GFX3D, 2, 32, 2,
>> +               SLAVE_GEM_NOC_SNOC, SLAVE_LLCC);
>> +DEFINE_QNODE(ipa_core_master, MASTER_IPA_CORE, 1, 8, 1,
>> +               SLAVE_IPA_CORE);
>> +DEFINE_QNODE(llcc_mc, MASTER_LLCC, 2, 4, 1,
>> +               SLAVE_EBI1);
>> +DEFINE_QNODE(qhm_mnoc_cfg, MASTER_CNOC_MNOC_CFG, 1, 4, 1,
> 
> Why does this one have a name of mnoc_cfg but a define of 
> CNOC_MNOC_CFG?
> 
>> +               SLAVE_SERVICE_MNOC);
>> +DEFINE_QNODE(qxm_camnoc_hf0, MASTER_CAMNOC_HF0, 2, 32, 1,
>> +               SLAVE_MNOC_HF_MEM_NOC);
>> +DEFINE_QNODE(qxm_camnoc_hf1, MASTER_CAMNOC_HF1, 2, 32, 1,
>> +               SLAVE_MNOC_HF_MEM_NOC);
>> +DEFINE_QNODE(qxm_camnoc_sf, MASTER_CAMNOC_SF, 1, 32, 1,
>> +               SLAVE_MNOC_SF_MEM_NOC);
>> +DEFINE_QNODE(qxm_mdp0, MASTER_MDP0, 1, 32, 1,
>> +               SLAVE_MNOC_HF_MEM_NOC);
>> +DEFINE_QNODE(qxm_rot, MASTER_ROTATOR, 1, 16, 1,
>> +               SLAVE_MNOC_SF_MEM_NOC);
>> +DEFINE_QNODE(qxm_venus0, MASTER_VIDEO_P0, 1, 32, 1,
>> +               SLAVE_MNOC_SF_MEM_NOC);
>> +DEFINE_QNODE(qxm_venus_arm9, MASTER_VIDEO_PROC, 1, 8, 1,
>> +               SLAVE_MNOC_SF_MEM_NOC);
>> +DEFINE_QNODE(amm_npu_sys, MASTER_NPU_SYS, 2, 32, 1,
>> +               SLAVE_NPU_COMPUTE_NOC);
>> +DEFINE_QNODE(qhm_npu_cfg, MASTER_NPU_NOC_CFG, 1, 4, 8,
>> +               SLAVE_NPU_CAL_DP0, SLAVE_NPU_CP,
>> +               SLAVE_NPU_INT_DMA_BWMON_CFG, SLAVE_NPU_DPM,
>> +               SLAVE_ISENSE_CFG, SLAVE_NPU_LLM_CFG,
>> +               SLAVE_NPU_TCM, SLAVE_SERVICE_NPU_NOC);
>> +DEFINE_QNODE(qup_core_master_1, MASTER_QUP_CORE_0, 1, 4, 1,
>> +               SLAVE_QUP_CORE_0);
>> +DEFINE_QNODE(qup_core_master_2, MASTER_QUP_CORE_1, 1, 4, 1,
>> +               SLAVE_QUP_CORE_1);
>> +DEFINE_QNODE(qhm_snoc_cfg, MASTER_SNOC_CFG, 1, 4, 1,
>> +               SLAVE_SERVICE_SNOC);
>> +DEFINE_QNODE(qnm_aggre1_noc, MASTER_A1NOC_SNOC, 1, 16, 6,
>> +               SLAVE_APPSS, SLAVE_SNOC_CNOC,
>> +               SLAVE_SNOC_GEM_NOC_SF, SLAVE_IMEM,
>> +               SLAVE_PIMEM, SLAVE_QDSS_STM);
>> +DEFINE_QNODE(qnm_aggre2_noc, MASTER_A2NOC_SNOC, 1, 16, 7,
>> +               SLAVE_APPSS, SLAVE_SNOC_CNOC,
>> +               SLAVE_SNOC_GEM_NOC_SF, SLAVE_IMEM,
>> +               SLAVE_PIMEM, SLAVE_QDSS_STM,
>> +               SLAVE_TCU);
>> +DEFINE_QNODE(qnm_gemnoc, MASTER_GEM_NOC_SNOC, 1, 8, 6,
>> +               SLAVE_APPSS, SLAVE_SNOC_CNOC,
>> +               SLAVE_IMEM, SLAVE_PIMEM,
>> +               SLAVE_QDSS_STM, SLAVE_TCU);
>> +DEFINE_QNODE(qxm_pimem, MASTER_PIMEM, 1, 8, 2,
>> +               SLAVE_SNOC_GEM_NOC_GC, SLAVE_IMEM);
>> +
>> +DEFINE_QNODE(qns_a1noc_snoc, SLAVE_A1NOC_SNOC, 1, 16, 1,
>> +               MASTER_A1NOC_SNOC);
>> +DEFINE_QNODE(srvc_aggre1_noc, SLAVE_SERVICE_A1NOC, 1, 4, 0);
>> +DEFINE_QNODE(qns_a2noc_snoc, SLAVE_A2NOC_SNOC, 1, 16, 1,
>> +               MASTER_A2NOC_SNOC);
>> +DEFINE_QNODE(srvc_aggre2_noc, SLAVE_SERVICE_A2NOC, 1, 4, 0);
>> +DEFINE_QNODE(qns_camnoc_uncomp, SLAVE_CAMNOC_UNCOMP, 1, 32, 0);
>> +DEFINE_QNODE(qns_cdsp_gemnoc, SLAVE_CDSP_GEM_NOC, 1, 32, 1,
>> +               MASTER_COMPUTE_NOC);
>> +DEFINE_QNODE(qhs_a1_noc_cfg, SLAVE_A1NOC_CFG, 1, 4, 1,
>> +               MASTER_A1NOC_CFG);
>> +DEFINE_QNODE(qhs_a2_noc_cfg, SLAVE_A2NOC_CFG, 1, 4, 1,
>> +               MASTER_A2NOC_CFG);
>> +DEFINE_QNODE(qhs_ahb2phy0, SLAVE_AHB2PHY_SOUTH, 1, 4, 0);
>> +DEFINE_QNODE(qhs_ahb2phy2, SLAVE_AHB2PHY_CENTER, 1, 4, 0);
>> +DEFINE_QNODE(qhs_aop, SLAVE_AOP, 1, 4, 0);
>> +DEFINE_QNODE(qhs_aoss, SLAVE_AOSS, 1, 4, 0);
>> +DEFINE_QNODE(qhs_boot_rom, SLAVE_BOOT_ROM, 1, 4, 0);
>> +DEFINE_QNODE(qhs_camera_cfg, SLAVE_CAMERA_CFG, 1, 4, 0);
>> +DEFINE_QNODE(qhs_camera_nrt_throttle_cfg,
>> +               SLAVE_CAMERA_NRT_THROTTLE_CFG, 1, 4, 0);
>> +DEFINE_QNODE(qhs_camera_rt_throttle_cfg,
>> +               SLAVE_CAMERA_RT_THROTTLE_CFG, 1, 4, 0);
>> +DEFINE_QNODE(qhs_clk_ctl, SLAVE_CLK_CTL, 1, 4, 0);
>> +DEFINE_QNODE(qhs_cpr_cx, SLAVE_RBCPR_CX_CFG, 1, 4, 0);
>> +DEFINE_QNODE(qhs_cpr_mx, SLAVE_RBCPR_MX_CFG, 1, 4, 0);
>> +DEFINE_QNODE(qhs_crypto0_cfg, SLAVE_CRYPTO_0_CFG, 1, 4, 0);
>> +DEFINE_QNODE(qhs_dcc_cfg, SLAVE_DCC_CFG, 1, 4, 0);
>> +DEFINE_QNODE(qhs_ddrss_cfg, SLAVE_CNOC_DDRSS, 1, 4, 1,
>> +               MASTER_CNOC_DC_NOC);
>> +DEFINE_QNODE(qhs_display_cfg, SLAVE_DISPLAY_CFG, 1, 4, 0);
>> +DEFINE_QNODE(qhs_display_rt_throttle_cfg,
>> +               SLAVE_DISPLAY_RT_THROTTLE_CFG, 1, 4, 0);
>> +DEFINE_QNODE(qhs_display_throttle_cfg, SLAVE_DISPLAY_THROTTLE_CFG, 1, 
>> 4, 0);
>> +DEFINE_QNODE(qhs_emmc_cfg, SLAVE_EMMC_CFG, 1, 4, 0);
>> +DEFINE_QNODE(qhs_glm, SLAVE_GLM, 1, 4, 0);
>> +DEFINE_QNODE(qhs_gpuss_cfg, SLAVE_GFX3D_CFG, 1, 8, 0);
>> +DEFINE_QNODE(qhs_imem_cfg, SLAVE_IMEM_CFG, 1, 4, 0);
>> +DEFINE_QNODE(qhs_ipa, SLAVE_IPA_CFG, 1, 4, 0);
>> +DEFINE_QNODE(qhs_mnoc_cfg, SLAVE_CNOC_MNOC_CFG, 1, 4, 1,
> 
> Another CNOC_MNOC... I guess it's intentional?
> 
> <snip>
> 
>> +
>> +static int qnoc_probe(struct platform_device *pdev)
>> +{
>> +       const struct qcom_icc_desc *desc;
>> +       struct icc_onecell_data *data;
>> +       struct icc_provider *provider;
>> +       struct qcom_icc_node **qnodes;
>> +       struct qcom_icc_provider *qp;
>> +       struct icc_node *node;
>> +       size_t num_nodes, i;
>> +       int ret;
>> +
>> +       desc = of_device_get_match_data(&pdev->dev);
>> +       if (!desc)
>> +               return -EINVAL;
>> +
>> +       qnodes = desc->nodes;
>> +       num_nodes = desc->num_nodes;
>> +
>> +       qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
>> +       if (!qp)
>> +               return -ENOMEM;
>> +
>> +       data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), 
>> GFP_KERNEL);
>> +       if (!data)
>> +               return -ENOMEM;
>> +
>> +       provider = &qp->provider;
>> +       provider->dev = &pdev->dev;
>> +       provider->set = qcom_icc_set;
>> +       provider->aggregate = qcom_icc_aggregate;
>> +       provider->xlate = of_icc_xlate_onecell;
>> +       INIT_LIST_HEAD(&provider->nodes);
>> +       provider->data = data;
>> +
>> +       qp->dev = &pdev->dev;
>> +       qp->bcms = desc->bcms;
>> +       qp->num_bcms = desc->num_bcms;
>> +
>> +       qp->voter = of_bcm_voter_get(qp->dev, NULL);
>> +       if (IS_ERR(qp->voter))
>> +               return PTR_ERR(qp->voter);
>> +
>> +       ret = icc_provider_add(provider);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "error adding interconnect 
>> provider\n");
>> +               return ret;
>> +       }
>> +
>> +       for (i = 0; i < num_nodes; i++) {
>> +               size_t j;
>> +
>> +               if (!qnodes[i])
>> +                       continue;
>> +
>> +               node = icc_node_create(qnodes[i]->id);
>> +               if (IS_ERR(node)) {
>> +                       ret = PTR_ERR(node);
>> +                       goto err;
>> +               }
>> +
>> +               node->name = qnodes[i]->name;
>> +               node->data = qnodes[i];
>> +               icc_node_add(node, provider);
>> +
>> +               dev_dbg(&pdev->dev, "registered node %pK %s %d\n", 
>> node,
>> +                       qnodes[i]->name, node->id);
>> +
>> +               /* populate links */
>> +               for (j = 0; j < qnodes[i]->num_links; j++)
>> +                       icc_link_create(node, qnodes[i]->links[j]);
>> +
>> +               data->nodes[i] = node;
>> +       }
>> +       data->num_nodes = num_nodes;
>> +
>> +       for (i = 0; i < qp->num_bcms; i++)
>> +               qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
>> +
>> +       platform_set_drvdata(pdev, qp);
>> +
>> +       dev_dbg(&pdev->dev, "Registered SC7180 ICC\n");
>> +
>> +       return ret;
>> +err:
>> +       list_for_each_entry(node, &provider->nodes, node_list) {
> 
> Here's an unsafe list iteration. We should use Georgi's new helper 
> function.
> 
OK, i will fix it. Thank you!
>> +               icc_node_del(node);
>> +               icc_node_destroy(node->id);
>> +       }
>> +
>> +       icc_provider_del(provider);
>> +       return ret;
>> +}
>> +
>> +static int qnoc_remove(struct platform_device *pdev)
>> +{
>> +       struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
>> +       struct icc_provider *provider = &qp->provider;
>> +       struct icc_node *n;
>> +
>> +       list_for_each_entry(n, &provider->nodes, node_list) {
>> +               icc_node_del(n);
>> +               icc_node_destroy(n->id);
>> +       }
> 
> Use Georgi's cleanup helper here, too.
> 
OK, i will fix it. Thank you!
>> +
>> +       return icc_provider_del(provider);
>> +}
>> +static const struct of_device_id qnoc_of_match[] = {
>> +       { .compatible = "qcom,sc7180-aggre1-noc",
>> +         .data = &sc7180_aggre1_noc},
>> +       { .compatible = "qcom,sc7180-aggre2-noc",
>> +         .data = &sc7180_aggre2_noc},
>> +       { .compatible = "qcom,sc7180-camnoc-virt",
>> +         .data = &sc7180_camnoc_virt},
>> +       { .compatible = "qcom,sc7180-compute-noc",
>> +         .data = &sc7180_compute_noc},
>> +       { .compatible = "qcom,sc7180-config-noc",
>> +         .data = &sc7180_config_noc},
>> +       { .compatible = "qcom,sc7180-dc-noc",
>> +         .data = &sc7180_dc_noc},
>> +       { .compatible = "qcom,sc7180-gem-noc",
>> +         .data = &sc7180_gem_noc},
>> +       { .compatible = "qcom,sc7180-ipa-virt",
>> +         .data = &sc7180_ipa_virt},
>> +       { .compatible = "qcom,sc7180-mc-virt",
>> +         .data = &sc7180_mc_virt},
>> +       { .compatible = "qcom,sc7180-mmss-noc",
>> +         .data = &sc7180_mmss_noc},
>> +       { .compatible = "qcom,sc7180-npu-noc",
>> +         .data = &sc7180_npu_noc},
>> +       { .compatible = "qcom,sc7180-qup-virt",
>> +         .data = &sc7180_qup_virt},
>> +       { .compatible = "qcom,sc7180-system-noc",
>> +         .data = &sc7180_system_noc},
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
>> +
>> +static struct platform_driver qnoc_driver = {
>> +       .probe = qnoc_probe,
>> +       .remove = qnoc_remove,
>> +       .driver = {
>> +               .name = "qnoc-sc7180",
>> +               .of_match_table = qnoc_of_match,
>> +       },
>> +};
>> +module_platform_driver(qnoc_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm SC7180 NoC driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
