Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75175316546
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 12:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhBJLdR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 06:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhBJLay (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2021 06:30:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90CEC061786
        for <linux-pm@vger.kernel.org>; Wed, 10 Feb 2021 03:30:13 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b3so2077898wrj.5
        for <linux-pm@vger.kernel.org>; Wed, 10 Feb 2021 03:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=52fuyB6fE6XKFVoJ4pzqnXRHR5pUvso5LUHiK27vD/c=;
        b=kU/CV9CsPhLXPK0VxdQZHkRFodPIOaTlkV3fPj6d+AmyFTm0SmDqZKhXT0rscoqdDh
         OrB89zuT2w3RqJF8+V9We54Sa5eF6RV1EE7fsyiwAImUneoVJhXx86+9fmySumGouBo0
         Iy76oLeak7c192ZK3Z4e/LkdaaddL7Io48bzQgEl32vvqpSDQIbtRLHUbbuMnkXoynrb
         DclvL9PC0SuOupoWnokxxe6/LyUP4ykYg8bcHf9XmYjZyy/W8Jlw5lVPTEKj6Lk5FVkf
         y9NzHNH/jcsT6FrH2rH5eMRObW8qKsDQqhKbMwHjS8bCGKj/5ngIWiAZ0eKn7WkwCxcT
         4oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=52fuyB6fE6XKFVoJ4pzqnXRHR5pUvso5LUHiK27vD/c=;
        b=PNwLIGGXXUmHSgQWE6gdKY2/RkSPJM5BHVxe4mZ7Pbz7/WS+0n42Dikr1SbHOUXNoA
         eXp5R4e1qsNCMAN0T+IUdPfZ+bA0kr8WVp03sB93mS7XId4eLV5VlcamtTs49MHxMbqy
         ZPNSivsi7KAvtnT78cIPCh4Hsbsi7zXKGYvgsG8zWLe20/2xKhWQ4DWaRx2afTa730ps
         Fm0/qxlo6PaghCc9xuVzRr8E26gj7HNnk3L37ZiJchsUPyzc7cIHNz4Mh4Rz0gI3KYmJ
         rTGH5sQVbWg2dLXLvEfvmEAtsCocTtJoDQomKzSr51MJOk17YyQRFuyeQVAHc7KdwwMo
         Nk5Q==
X-Gm-Message-State: AOAM533besq9BNtkKezGJG8rSV4CbDOV+s96KnkuZuyR6o3O4mU+c8Yx
        3xL3ZMb1rTkhWb1M1VuLO/M0MA==
X-Google-Smtp-Source: ABdhPJzkZ5jclPQN+5W41U99erUajbxg45zQqbJAy0fi0TXDsjvUHTFNBiJyIcbIbiF0RcJMs79ZQg==
X-Received: by 2002:a5d:524a:: with SMTP id k10mr3137305wrc.394.1612956612481;
        Wed, 10 Feb 2021 03:30:12 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r12sm2515241wrp.13.2021.02.10.03.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 03:30:11 -0800 (PST)
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210210104724.340991-1-vkoul@kernel.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM8350 DT
 bindings
Message-ID: <30719cbd-6702-4b1e-2117-e5b8f11fd68d@linaro.org>
Date:   Wed, 10 Feb 2021 13:30:10 +0200
MIME-Version: 1.0
In-Reply-To: <20210210104724.340991-1-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Vinod,

On 2/10/21 12:47, Vinod Koul wrote:
> The Qualcomm SM8350 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   .../bindings/interconnect/qcom,rpmh.yaml      |  10 ++
>   .../dt-bindings/interconnect/qcom,sm8350.h    | 169 ++++++++++++++++++
>   2 files changed, 179 insertions(+)
>   create mode 100644 include/dt-bindings/interconnect/qcom,sm8350.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index 30c2a092d2d3..e47f2aa0c61b 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -67,6 +67,16 @@ properties:
>         - qcom,sm8250-mmss-noc
>         - qcom,sm8250-npu-noc
>         - qcom,sm8250-system-noc
> +      - qcom,sm8350-aggre1-noc
> +      - qcom,sm8350-aggre2-noc
> +      - qcom,sm8350-config-noc
> +      - qcom,sm8350-dc-noc
> +      - qcom,sm8350-gem-noc
> +      - qcom,sm8350-lpass-ag-noc
> +      - qcom,sm8350-mc-virt
> +      - qcom,sm8350-mmss-noc
> +      - qcom,sm8350-compute-noc
> +      - qcom,sm8350-system-noc
>   
>     '#interconnect-cells':
>       const: 1
> diff --git a/include/dt-bindings/interconnect/qcom,sm8350.h b/include/dt-bindings/interconnect/qcom,sm8350.h
> new file mode 100644
> index 000000000000..8633c58b3b80
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,sm8350.h
> @@ -0,0 +1,169 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Qualcomm SM8350 interconnect IDs
> + *
> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021, Linaro Limited
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8350_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8350_H
> +
> +#define SM8350_MASTER_GPU_TCU				0
> +#define SM8350_MASTER_SYS_TCU				1
> +#define SM8350_MASTER_APPSS_PROC			2
> +#define SM8350_MASTER_LLCC				3
> +#define SM8350_MASTER_CNOC_LPASS_AG_NOC			4
> +#define SM8350_MASTER_CDSP_NOC_CFG			5
> +#define SM8350_MASTER_QDSS_BAM				6
> +#define SM8350_MASTER_QSPI_0				7
> +#define SM8350_MASTER_QUP_0				8
> +#define SM8350_MASTER_QUP_1				9
> +#define SM8350_MASTER_QUP_2				10
> +#define SM8350_MASTER_A1NOC_CFG				11
> +#define SM8350_MASTER_A2NOC_CFG				12
> +#define SM8350_MASTER_A1NOC_SNOC			13
> +#define SM8350_MASTER_A2NOC_SNOC			14
> +#define SM8350_MASTER_CAMNOC_HF				15
> +#define SM8350_MASTER_CAMNOC_ICP			16
> +#define SM8350_MASTER_CAMNOC_SF				17
> +#define SM8350_MASTER_COMPUTE_NOC			18
> +#define SM8350_MASTER_CNOC_DC_NOC			19
> +#define SM8350_MASTER_GEM_NOC_CFG			20
> +#define SM8350_MASTER_GEM_NOC_CNOC			21
> +#define SM8350_MASTER_GEM_NOC_PCIE_SNOC			22
> +#define SM8350_MASTER_GFX3D				23
> +#define SM8350_MASTER_CNOC_MNOC_CFG			24
> +#define SM8350_MASTER_MNOC_HF_MEM_NOC			25
> +#define SM8350_MASTER_MNOC_SF_MEM_NOC			26
> +#define SM8350_MASTER_ANOC_PCIE_GEM_NOC			27
> +#define SM8350_MASTER_SNOC_CFG				28
> +#define SM8350_MASTER_SNOC_GC_MEM_NOC			29
> +#define SM8350_MASTER_SNOC_SF_MEM_NOC			30
> +#define SM8350_MASTER_VIDEO_P0				31
> +#define SM8350_MASTER_VIDEO_P1				32
> +#define SM8350_MASTER_VIDEO_PROC			33
> +#define SM8350_MASTER_QUP_CORE_0			34
> +#define SM8350_MASTER_QUP_CORE_1			35
> +#define SM8350_MASTER_QUP_CORE_2			36
> +#define SM8350_MASTER_CRYPTO				37
> +#define SM8350_MASTER_IPA				38
> +#define SM8350_MASTER_MDP0				39
> +#define SM8350_MASTER_MDP1				40
> +#define SM8350_MASTER_CDSP_PROC				41
> +#define SM8350_MASTER_PIMEM				42
> +#define SM8350_MASTER_ROTATOR				43
> +#define SM8350_MASTER_GIC				44
> +#define SM8350_MASTER_PCIE_0				45
> +#define SM8350_MASTER_PCIE_1				46
> +#define SM8350_MASTER_QDSS_DAP				47
> +#define SM8350_MASTER_QDSS_ETR				48
> +#define SM8350_MASTER_SDCC_2				49
> +#define SM8350_MASTER_SDCC_4				50
> +#define SM8350_MASTER_UFS_CARD				51
> +#define SM8350_MASTER_UFS_MEM				52
> +#define SM8350_MASTER_USB3_0				53
> +#define SM8350_MASTER_USB3_1				54
> +#define SM8350_SLAVE_EBI1				512
> +#define SM8350_SLAVE_AHB2PHY_SOUTH			513
> +#define SM8350_SLAVE_AHB2PHY_NORTH			514
> +#define SM8350_SLAVE_AOSS				515
> +#define SM8350_SLAVE_APPSS				516
> +#define SM8350_SLAVE_CAMERA_CFG				517
> +#define SM8350_SLAVE_CLK_CTL				518
> +#define SM8350_SLAVE_CDSP_CFG				519
> +#define SM8350_SLAVE_RBCPR_CX_CFG			520
> +#define SM8350_SLAVE_RBCPR_MMCX_CFG			521
> +#define SM8350_SLAVE_RBCPR_MX_CFG			522
> +#define SM8350_SLAVE_CRYPTO_0_CFG			523
> +#define SM8350_SLAVE_CX_RDPM				524
> +#define SM8350_SLAVE_DCC_CFG				525
> +#define SM8350_SLAVE_DISPLAY_CFG			526
> +#define SM8350_SLAVE_GFX3D_CFG				527
> +#define SM8350_SLAVE_HWKM				528
> +#define SM8350_SLAVE_IMEM_CFG				529
> +#define SM8350_SLAVE_IPA_CFG				530
> +#define SM8350_SLAVE_IPC_ROUTER_CFG			531
> +#define SM8350_SLAVE_LLCC_CFG				532
> +#define SM8350_SLAVE_LPASS				533
> +#define SM8350_SLAVE_LPASS_CORE_CFG			534
> +#define SM8350_SLAVE_LPASS_LPI_CFG			535
> +#define SM8350_SLAVE_LPASS_MPU_CFG			536
> +#define SM8350_SLAVE_LPASS_TOP_CFG			537
> +#define SM8350_SLAVE_MSS_PROC_MS_MPU_CFG		538
> +#define SM8350_SLAVE_MCDMA_MS_MPU_CFG			539
> +#define SM8350_SLAVE_CNOC_MSS				540
> +#define SM8350_SLAVE_MX_RDPM				541
> +#define SM8350_SLAVE_PCIE_0_CFG				542
> +#define SM8350_SLAVE_PCIE_1_CFG				543
> +#define SM8350_SLAVE_PDM				544
> +#define SM8350_SLAVE_PIMEM_CFG				545
> +#define SM8350_SLAVE_PKA_WRAPPER_CFG			546
> +#define SM8350_SLAVE_PMU_WRAPPER_CFG			547
> +#define SM8350_SLAVE_QDSS_CFG				548
> +#define SM8350_SLAVE_QSPI_0				549
> +#define SM8350_SLAVE_QUP_0				550
> +#define SM8350_SLAVE_QUP_1				551
> +#define SM8350_SLAVE_QUP_2				552
> +#define SM8350_SLAVE_SDCC_2				553
> +#define SM8350_SLAVE_SDCC_4				554
> +#define SM8350_SLAVE_SECURITY				555
> +#define SM8350_SLAVE_SPSS_CFG				556
> +#define SM8350_SLAVE_TCSR				557
> +#define SM8350_SLAVE_TLMM				558
> +#define SM8350_SLAVE_UFS_CARD_CFG			559
> +#define SM8350_SLAVE_UFS_MEM_CFG			560
> +#define SM8350_SLAVE_USB3_0				561
> +#define SM8350_SLAVE_USB3_1				562
> +#define SM8350_SLAVE_VENUS_CFG				563
> +#define SM8350_SLAVE_VSENSE_CTRL_CFG			564
> +#define SM8350_SLAVE_A1NOC_CFG				565
> +#define SM8350_SLAVE_A1NOC_SNOC				566
> +#define SM8350_SLAVE_A2NOC_CFG				567
> +#define SM8350_SLAVE_A2NOC_SNOC				568
> +#define SM8350_SLAVE_DDRSS_CFG				569
> +#define SM8350_SLAVE_GEM_NOC_CNOC			570
> +#define SM8350_SLAVE_GEM_NOC_CFG			571
> +#define SM8350_SLAVE_SNOC_GEM_NOC_GC			572
> +#define SM8350_SLAVE_SNOC_GEM_NOC_SF			573
> +#define SM8350_SLAVE_LLCC				574
> +#define SM8350_SLAVE_MNOC_HF_MEM_NOC			575
> +#define SM8350_SLAVE_MNOC_SF_MEM_NOC			576
> +#define SM8350_SLAVE_CNOC_MNOC_CFG			577
> +#define SM8350_SLAVE_CDSP_MEM_NOC			578
> +#define SM8350_SLAVE_MEM_NOC_PCIE_SNOC			579
> +#define SM8350_SLAVE_ANOC_PCIE_GEM_NOC			580
> +#define SM8350_SLAVE_SNOC_CFG				581
> +#define SM8350_SLAVE_QUP_CORE_0				582
> +#define SM8350_SLAVE_QUP_CORE_1				583
> +#define SM8350_SLAVE_QUP_CORE_2				584
> +#define SM8350_SLAVE_BOOT_IMEM				585
> +#define SM8350_SLAVE_IMEM				586
> +#define SM8350_SLAVE_PIMEM				587
> +#define SM8350_SLAVE_SERVICE_NSP_NOC			588
> +#define SM8350_SLAVE_SERVICE_A1NOC			589
> +#define SM8350_SLAVE_SERVICE_A2NOC			590
> +#define SM8350_SLAVE_SERVICE_CNOC			591
> +#define SM8350_SLAVE_SERVICE_GEM_NOC_1			592
> +#define SM8350_SLAVE_SERVICE_MNOC			593
> +#define SM8350_SLAVE_SERVICES_LPASS_AML_NOC		594
> +#define SM8350_SLAVE_SERVICE_LPASS_AG_NOC		595
> +#define SM8350_SLAVE_SERVICE_GEM_NOC_2			596
> +#define SM8350_SLAVE_SERVICE_SNOC			597
> +#define SM8350_SLAVE_SERVICE_GEM_NOC			598
> +#define SM8350_SLAVE_PCIE_0				599
> +#define SM8350_SLAVE_PCIE_1				600
> +#define SM8350_SLAVE_QDSS_STM				601
> +#define SM8350_SLAVE_TCU				602
> +#define SM8350_MASTER_LLCC_DISP				1000
> +#define SM8350_MASTER_MNOC_HF_MEM_NOC_DISP		1001
> +#define SM8350_MASTER_MNOC_SF_MEM_NOC_DISP		1002
> +#define SM8350_MASTER_MDP0_DISP				1003
> +#define SM8350_MASTER_MDP1_DISP				1004
> +#define SM8350_MASTER_ROTATOR_DISP			1005
> +#define SM8350_SLAVE_EBI1_DISP				1512
> +#define SM8350_SLAVE_LLCC_DISP				1513
> +#define SM8350_SLAVE_MNOC_HF_MEM_NOC_DISP		1514
> +#define SM8350_SLAVE_MNOC_SF_MEM_NOC_DISP		1515

Why are you using these big numbers? They are used as array indexes
and we will be wasting a lot of memory for unnecessary large arrays.

Thanks,
Georgi
