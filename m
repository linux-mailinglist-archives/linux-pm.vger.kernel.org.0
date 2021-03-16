Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAA833E12F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 23:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhCPWJu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 18:09:50 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:38412 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhCPWJa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 18:09:30 -0400
Received: by mail-io1-f45.google.com with SMTP id k2so38960959ioh.5;
        Tue, 16 Mar 2021 15:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jz8R/aNPIItoq2l02Px8QwlLUmeIpPIwCgu086Ui92o=;
        b=Nxuy+ZPqaOlNHiPoi5BsrnWUjXlNbx6QMJxnqTCNQI21pDAv10CG9khT2XZ54cl9e6
         5F9ybrbo2Namic8kAnXSvK6gYfCAMdVJVEI0x5QKYJBDDXMgysBwYgd8yBnQaaP6Itm7
         dxF5NxYyv5Zczc3ZBRXBgKNDHZ/I8Hp4U1F61MYtHkx/gacORthnPpKqcpnJedX2Vj/t
         42D0s0O1SK8iBFPM8H4L2zjmrZ2I7VojAY0snfh/wOcvgARAL3Dn16WQCti1Uu8AfjHk
         slRmUA3IR0YF2vg7Pp3cnQSELEjo5Ytt6Ij23/S2A3+5SPXNOWkiwFrHzC47mIbCfNbH
         zs1Q==
X-Gm-Message-State: AOAM530bONt7uJaUnXkKmrq7/uGkFb7AuqzZ4pP3R2ihu7VAtLm/4TFS
        RiItTuGfOn6ntR6dsogLeA==
X-Google-Smtp-Source: ABdhPJzC4nUeyJn7e2xHHLNBjeOUbTXLI+V1ajUbCI1o7x7ZExjT2vdV0Nl46WhApXkGnIjmLcHz/Q==
X-Received: by 2002:a02:93e9:: with SMTP id z96mr629658jah.73.1615932569199;
        Tue, 16 Mar 2021 15:09:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f15sm10191672ilj.24.2021.03.16.15.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 15:09:28 -0700 (PDT)
Received: (nullmailer pid 3768469 invoked by uid 1000);
        Tue, 16 Mar 2021 22:09:25 -0000
Date:   Tue, 16 Mar 2021 16:09:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [1/3] dt-bindings: interconnect: Add Qualcomm SC7280 DT bindings
Message-ID: <20210316220925.GA3767772@robh.at.kernel.org>
References: <1615290609-21009-1-git-send-email-okukatla@codeaurora.org>
 <1615290609-21009-2-git-send-email-okukatla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615290609-21009-2-git-send-email-okukatla@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 09, 2021 at 05:20:07PM +0530, Odelu Kukatla wrote:
> The Qualcomm SC7280 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml           |  12 ++
>  include/dt-bindings/interconnect/qcom,sc7280.h     | 163 +++++++++++++++++++++
>  2 files changed, 175 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,sc7280.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index 799e73cdb90..e65da19 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -37,6 +37,18 @@ properties:
>        - qcom,sc7180-npu-noc
>        - qcom,sc7180-qup-virt
>        - qcom,sc7180-system-noc
> +      - qcom,sc7280-aggre1-noc
> +      - qcom,sc7280-aggre2-noc
> +      - qcom,sc7280-clk-virt
> +      - qcom,sc7280-cnoc2
> +      - qcom,sc7280-cnoc3
> +      - qcom,sc7280-dc-noc
> +      - qcom,sc7280-gem-noc
> +      - qcom,sc7280-lpass-ag-noc
> +      - qcom,sc7280-mc-virt
> +      - qcom,sc7280-mmss-noc
> +      - qcom,sc7280-nsp-noc
> +      - qcom,sc7280-system-noc
>        - qcom,sdm845-aggre1-noc
>        - qcom,sdm845-aggre2-noc
>        - qcom,sdm845-config-noc
> diff --git a/include/dt-bindings/interconnect/qcom,sc7280.h b/include/dt-bindings/interconnect/qcom,sc7280.h
> new file mode 100644
> index 0000000..75a243d
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,sc7280.h
> @@ -0,0 +1,163 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Don't care about non-GPL users?

> +/*
> + * Qualcomm SC7280 interconnect IDs
> + *
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SC7280_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_SC7280_H
> +
> +#define MASTER_QSPI_0			0
> +#define MASTER_QUP_0			1
> +#define MASTER_QUP_1			2
> +#define MASTER_A1NOC_CFG			3
> +#define MASTER_PCIE_0			4
> +#define MASTER_PCIE_1			5
> +#define MASTER_SDCC_1			6
> +#define MASTER_SDCC_2			7
> +#define MASTER_SDCC_4			8
> +#define MASTER_UFS_MEM			9
> +#define MASTER_USB3_0			10
> +#define SLAVE_A1NOC_SNOC			11
> +#define SLAVE_ANOC_PCIE_GEM_NOC			12
> +#define SLAVE_SERVICE_A1NOC			13
> +
> +#define MASTER_QDSS_BAM			0
> +#define MASTER_A2NOC_CFG			1
> +#define MASTER_CNOC_A2NOC			2
> +#define MASTER_CRYPTO			3
> +#define MASTER_IPA			4
> +#define MASTER_QDSS_ETR			5
> +#define SLAVE_A2NOC_SNOC			6
> +#define SLAVE_SERVICE_A2NOC			7
> +
> +#define MASTER_QUP_CORE_0			0
> +#define MASTER_QUP_CORE_1		1
> +#define SLAVE_QUP_CORE_0			2
> +#define SLAVE_QUP_CORE_1			3
> +
> +#define MASTER_CNOC3_CNOC2			0
> +#define MASTER_QDSS_DAP			1
> +#define SLAVE_AHB2PHY_SOUTH			2
> +#define SLAVE_AHB2PHY_NORTH			3
> +#define SLAVE_CAMERA_CFG			4
> +#define SLAVE_CLK_CTL			5
> +#define SLAVE_CDSP_CFG			6
> +#define SLAVE_RBCPR_CX_CFG			7
> +#define SLAVE_RBCPR_MX_CFG			8
> +#define SLAVE_CRYPTO_0_CFG			9
> +#define SLAVE_CX_RDPM			10
> +#define SLAVE_DCC_CFG			11
> +#define SLAVE_DISPLAY_CFG			12
> +#define SLAVE_GFX3D_CFG			13
> +#define SLAVE_HWKM			14
> +#define SLAVE_IMEM_CFG			15
> +#define SLAVE_IPA_CFG			16
> +#define SLAVE_IPC_ROUTER_CFG			17
> +#define SLAVE_LPASS			18
> +#define SLAVE_CNOC_MSS			19
> +#define SLAVE_MX_RDPM			20
> +#define SLAVE_PCIE_0_CFG			21
> +#define SLAVE_PCIE_1_CFG			22
> +#define SLAVE_PDM			23
> +#define SLAVE_PIMEM_CFG			24
> +#define SLAVE_PKA_WRAPPER_CFG			25
> +#define SLAVE_PMU_WRAPPER_CFG			26
> +#define SLAVE_QDSS_CFG			27
> +#define SLAVE_QSPI_0			28
> +#define SLAVE_QUP_0			29
> +#define SLAVE_QUP_1			30
> +#define SLAVE_SDCC_1			31
> +#define SLAVE_SDCC_2			32
> +#define SLAVE_SDCC_4			33
> +#define SLAVE_SECURITY			34
> +#define SLAVE_TCSR			35
> +#define SLAVE_TLMM			36
> +#define SLAVE_UFS_MEM_CFG			37
> +#define SLAVE_USB3_0			38
> +#define SLAVE_VENUS_CFG			39
> +#define SLAVE_VSENSE_CTRL_CFG			40
> +#define SLAVE_A1NOC_CFG			41
> +#define SLAVE_A2NOC_CFG			42
> +#define SLAVE_CNOC2_CNOC3			43
> +#define SLAVE_CNOC_MNOC_CFG			44
> +#define SLAVE_SNOC_CFG			45
> +
> +#define MASTER_CNOC2_CNOC3			0
> +#define MASTER_GEM_NOC_CNOC			1
> +#define MASTER_GEM_NOC_PCIE_SNOC			2
> +#define SLAVE_AOSS			3
> +#define SLAVE_APPSS			4
> +#define SLAVE_CNOC3_CNOC2			5
> +#define SLAVE_CNOC_A2NOC			6
> +#define SLAVE_DDRSS_CFG			7
> +#define SLAVE_BOOT_IMEM			8
> +#define SLAVE_IMEM			9
> +#define SLAVE_PIMEM			10
> +#define SLAVE_PCIE_0			11
> +#define SLAVE_PCIE_1			12
> +#define SLAVE_QDSS_STM			13
> +#define SLAVE_TCU			14
> +
> +#define MASTER_CNOC_DC_NOC			0
> +#define SLAVE_LLCC_CFG			1
> +#define SLAVE_GEM_NOC_CFG			2
> +
> +#define MASTER_GPU_TCU			0
> +#define MASTER_SYS_TCU			1
> +#define MASTER_APPSS_PROC			2
> +#define MASTER_COMPUTE_NOC			3
> +#define MASTER_GEM_NOC_CFG			4
> +#define MASTER_GFX3D			5
> +#define MASTER_MNOC_HF_MEM_NOC			6
> +#define MASTER_MNOC_SF_MEM_NOC			7
> +#define MASTER_ANOC_PCIE_GEM_NOC			8
> +#define MASTER_SNOC_GC_MEM_NOC			9
> +#define MASTER_SNOC_SF_MEM_NOC			10
> +#define SLAVE_MSS_PROC_MS_MPU_CFG			11
> +#define SLAVE_MCDMA_MS_MPU_CFG			12
> +#define SLAVE_GEM_NOC_CNOC			13
> +#define SLAVE_LLCC			14
> +#define SLAVE_MEM_NOC_PCIE_SNOC			15
> +#define SLAVE_SERVICE_GEM_NOC_1			16
> +#define SLAVE_SERVICE_GEM_NOC_2			17
> +#define SLAVE_SERVICE_GEM_NOC			18
> +
> +#define MASTER_CNOC_LPASS_AG_NOC			0
> +#define SLAVE_LPASS_CORE_CFG			1
> +#define SLAVE_LPASS_LPI_CFG			2
> +#define SLAVE_LPASS_MPU_CFG			3
> +#define SLAVE_LPASS_TOP_CFG			4
> +#define SLAVE_SERVICES_LPASS_AML_NOC			5
> +#define SLAVE_SERVICE_LPASS_AG_NOC			6
> +
> +#define MASTER_LLCC			0
> +#define SLAVE_EBI1			1
> +
> +#define MASTER_CNOC_MNOC_CFG			0
> +#define MASTER_VIDEO_P0			1
> +#define MASTER_VIDEO_PROC			2
> +#define MASTER_CAMNOC_HF			3
> +#define MASTER_CAMNOC_ICP			4
> +#define MASTER_CAMNOC_SF			5
> +#define MASTER_MDP0			6
> +#define SLAVE_MNOC_HF_MEM_NOC			7
> +#define SLAVE_MNOC_SF_MEM_NOC			8
> +#define SLAVE_SERVICE_MNOC			9
> +
> +#define MASTER_CDSP_NOC_CFG			0
> +#define MASTER_CDSP_PROC			1
> +#define SLAVE_CDSP_MEM_NOC			2
> +#define SLAVE_SERVICE_NSP_NOC			3
> +
> +#define MASTER_A1NOC_SNOC			0
> +#define MASTER_A2NOC_SNOC			1
> +#define MASTER_SNOC_CFG			2
> +#define MASTER_PIMEM			3
> +#define MASTER_GIC			4
> +#define SLAVE_SNOC_GEM_NOC_GC			5
> +#define SLAVE_SNOC_GEM_NOC_SF			6
> +#define SLAVE_SERVICE_SNOC			7
> +
> +#endif
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
