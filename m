Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C815E12CFB3
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 12:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfL3LrJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 06:47:09 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:19678 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727386AbfL3LrJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 06:47:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577706427; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=dGHIBy4/XdNceCKSzyT4MigXenSFJoLKxToQvsEoJqU=;
 b=N7AY6fNYVL0cH4t8khPLOKRgfFnNgbBfHMagmnUYyH5CNaL41AwN92OZEq97C8YzUT+tFYaQ
 ixzB0d/402n05a4zyv1hrVBiFWBrX+ri8K/3+SorXnZ80+vTcWOZ9egvGcd51LKZfKmPfaR2
 Bh55GNVKCm390GChI31/NTPLhzE=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e09e3b7.7f6e52900500-smtp-out-n01;
 Mon, 30 Dec 2019 11:47:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3C4B8C43383; Mon, 30 Dec 2019 11:47:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 90D2DC43383;
        Mon, 30 Dec 2019 11:47:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Dec 2019 17:17:01 +0530
From:   okukatla@codeaurora.org
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     georgi.djakov@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com, sboyd@kernel.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V1 1/2] dt-bindings: interconnect: Add Qualcomm SC7180 DT
 bindings
In-Reply-To: <0101016eac183058-afcce911-d283-4748-b3ff-8455e076a313-000000@us-west-2.amazonses.com>
References: <1574780408-21282-1-git-send-email-okukatla@codeaurora.org>
 <0101016ea83b44e2-546fc9ff-6056-482b-a42d-231b9d908640-000000@us-west-2.amazonses.com>
 <0101016eac183058-afcce911-d283-4748-b3ff-8455e076a313-000000@us-west-2.amazonses.com>
Message-ID: <61e527c57ea22e197c0fcf06bb6bce57@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-11-27 14:31, Sibi Sankar wrote:
> Hey Odelu,
> 
> On 2019-11-26 20:31, Odelu Kukatla wrote:
>> The Qualcomm SC7180 platform has several bus fabrics that could be
>> controlled and tuned dynamically according to the bandwidth demand.
>> 
>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
>> ---
>>  .../bindings/interconnect/qcom,bcm-voter.yaml      |   1 +
>>  .../bindings/interconnect/qcom,sc7180.yaml         | 155 
>> +++++++++++++++++++++
>>  include/dt-bindings/interconnect/qcom,sc7180.h     | 149 
>> ++++++++++++++++++++
>>  3 files changed, 305 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
>>  create mode 100644 include/dt-bindings/interconnect/qcom,sc7180.h
>> 
>> diff --git
>> a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> index 74f0715..55c9f34 100644
>> --- 
>> a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> +++ 
>> b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> @@ -19,6 +19,7 @@ description: |
>>  properties:
>>    compatible:
>>      enum:
>> +      - qcom,sc7180-bcm-voter
>>        - qcom,sdm845-bcm-voter
>> 
>>  required:
>> diff --git
>> a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
>> b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
>> new file mode 100644
>> index 0000000..487da5e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
>> @@ -0,0 +1,155 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interconnect/qcom,sc7180.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title:  Qualcomm SC7180 Network-On-Chip Interconnect
>> +
> 
> seems to be same as the SDM845
> icc description can't we just
> re-use/add it to that?
> 
No, NoC topology is different b/w SDM845 and SC7180. we need to have 
separate file for SC7180.
>> +maintainers:
>> +  - David Dai <daidavid1@codeaurora.org>
>> +
>> +description: |
>> +   SC7180 interconnect providers support system bandwidth 
>> requirements through
>> +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The 
>> provider is
>> +   able to communicate with the BCM through the Resource State
>> Coordinator (RSC)
>> +   associated with each execution environment. Provider nodes must 
>> point to at
>> +   least one RPMh device child node pertaining to their RSC and each 
>> provider
>> +   can map to multiple RPMh resources.
>> +
>> +properties:
>> +  reg:
>> +    maxItems: 1
>> +
>> +  compatible:
>> +    enum:
>> +      - qcom,sc7180-aggre1-noc
>> +      - qcom,sc7180-aggre2-noc
>> +      - qcom,sc7180-camnoc-virt
>> +      - qcom,sc7180-compute-noc
>> +      - qcom,sc7180-config-noc
>> +      - qcom,sc7180-dc-noc
>> +      - qcom,sc7180-gem-noc
>> +      - qcom,sc7180-ipa-virt
>> +      - qcom,sc7180-mc-virt
>> +      - qcom,sc7180-mmss-noc
>> +      - qcom,sc7180-npu-noc
>> +      - qcom,sc7180-qup-virt
>> +      - qcom,sc7180-system-noc
>> +
>> +  '#interconnect-cells':
>> +    const: 1
>> +
>> +  qcom,bcm-voters:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      List of phandles to qcom,bcm-voter nodes that are required by
>> +      this interconnect to send RPMh commands.
>> +
>> +  qcom,bcm-voter-names:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    description: |
>> +      Names for each of the qcom,bcm-voters specified.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#interconnect-cells'
>> +  - qcom,bcm-voters
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +      #include <dt-bindings/interconnect/qcom,sc7180.h>
>> +
>> +      config_noc: interconnect@1500000 {
>> +            compatible = "qcom,sc7180-config-noc";
>> +            reg = <0 0x01500000 0 0x28000>;
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      system_noc: interconnect@1620000 {
>> +            compatible = "qcom,sc7180-system-noc";
>> +            reg = <0 0x01620000 0 0x17080>;
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      mc_virt: interconnect@1630000 {
>> +            compatible = "qcom,sc7180-mc-virt";
>> +            reg = <0 0x01630000 0 0x4000>;
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      qup_virt: interconnect@1650000 {
>> +            compatible = "qcom,sc7180-qup-virt";
>> +            reg = <0 0x01650000 0 0x4000>;
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      aggre1_noc: interconnect@16e0000 {
>> +            compatible = "qcom,sc7180-aggre1-noc";
>> +            reg = <0 0x016e0000 0 0x15080>;
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      aggre2_noc: interconnect@1700000 {
>> +            compatible = "qcom,sc7180-aggre2-noc";
>> +            reg = <0 0x01700000 0 0x1f880>;
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      compute_noc: interconnect@170e000 {
>> +            compatible = "qcom,sc7180-compute-noc";
>> +            reg = <0 0x0170e000 0 0x11880>;
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      mmss_noc: interconnect@1740000 {
>> +            compatible = "qcom,sc7180-mmss-noc";
>> +            reg = <0 0x01740000 0 0x1c100>;
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      ipa_virt: interconnect@1e00000 {
>> +            compatible = "qcom,sc7180-ipa-virt";
>> +            reg = <0 0x01e00000 0 0x4000>;
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      dc_noc: interconnect@9160000 {
>> +            compatible = "qcom,sc7180-dc-noc";
>> +            reg = <0 0x09160000 0 0x03200>;
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      gem_noc: interconnect@9680000 {
>> +            compatible = "qcom,sc7180-gem-noc";
>> +            reg = <0 0x09680000 0 0x3e200>;
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      npu_noc: interconnect@9990000 {
>> +            compatible = "qcom,sc7180-npu-noc";
>> +            reg = <0 0x09990000 0 0x1600>;
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      camnoc_virt: interconnect@ac00000 {
>> +            compatible = "qcom,sc7180-camnoc-virt";
>> +            reg = <0 0x0ac00000 0 0x4000>;
>> +            #interconnect-cells = <1>;
>> +            qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> diff --git a/include/dt-bindings/interconnect/qcom,sc7180.h
>> b/include/dt-bindings/interconnect/qcom,sc7180.h
>> new file mode 100644
>> index 0000000..b762bc3
>> --- /dev/null
>> +++ b/include/dt-bindings/interconnect/qcom,sc7180.h
>> @@ -0,0 +1,149 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Qualcomm SC7180 interconnect IDs
>> + *
>> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SC7180_H
>> +#define __DT_BINDINGS_INTERCONNECT_QCOM_SC7180_H
> 
> Please use local ids instead, the
> following way of defining nodes will
> lead to unnecessarily large array
> sizes.
> 
I will fix it. Thank you!
>> +
>> +#define MASTER_APPSS_PROC			0
>> +#define MASTER_SYS_TCU				1
>> +#define MASTER_NPU_SYS				2
>> +#define MASTER_IPA_CORE				3
>> +#define MASTER_LLCC				4
>> +#define MASTER_A1NOC_CFG			5
>> +#define MASTER_A2NOC_CFG			6
>> +#define MASTER_CNOC_DC_NOC			7
>> +#define MASTER_GEM_NOC_CFG			8
>> +#define MASTER_CNOC_MNOC_CFG			9
>> +#define MASTER_NPU_NOC_CFG			10
>> +#define MASTER_QDSS_BAM				11
>> +#define MASTER_QSPI				12
>> +#define MASTER_QUP_0				13
>> +#define MASTER_QUP_1				14
>> +#define MASTER_SNOC_CFG				15
>> +#define MASTER_A1NOC_SNOC			16
>> +#define MASTER_A2NOC_SNOC			17
>> +#define MASTER_COMPUTE_NOC			18
>> +#define MASTER_GEM_NOC_SNOC			19
>> +#define MASTER_MNOC_HF_MEM_NOC			20
>> +#define MASTER_MNOC_SF_MEM_NOC			21
>> +#define MASTER_NPU				22
>> +#define MASTER_SNOC_CNOC			23
>> +#define MASTER_SNOC_GC_MEM_NOC			24
>> +#define MASTER_SNOC_SF_MEM_NOC			25
>> +#define MASTER_QUP_CORE_0			26
>> +#define MASTER_QUP_CORE_1			27
>> +#define MASTER_CAMNOC_HF0			28
>> +#define MASTER_CAMNOC_HF1			29
>> +#define MASTER_CAMNOC_HF0_UNCOMP		30
>> +#define MASTER_CAMNOC_HF1_UNCOMP		31
>> +#define MASTER_CAMNOC_SF			32
>> +#define MASTER_CAMNOC_SF_UNCOMP			33
>> +#define MASTER_CRYPTO				34
>> +#define MASTER_GFX3D				35
>> +#define MASTER_IPA				36
>> +#define MASTER_MDP0				37
>> +#define MASTER_NPU_PROC				38
>> +#define MASTER_PIMEM				39
>> +#define MASTER_ROTATOR				40
>> +#define MASTER_VIDEO_P0				41
>> +#define MASTER_VIDEO_PROC			42
>> +#define MASTER_QDSS_DAP				43
>> +#define MASTER_QDSS_ETR				44
>> +#define MASTER_SDCC_2				45
>> +#define MASTER_UFS_MEM				46
>> +#define MASTER_USB3				47
>> +#define MASTER_EMMC				48
>> +#define SLAVE_EBI1				512
> 
> Shouldn't the node ids be just
> sequential?
> 
I will address  it.
>> +#define SLAVE_IPA_CORE				513
>> +#define SLAVE_A1NOC_CFG				514
>> +#define SLAVE_A2NOC_CFG				515
>> +#define SLAVE_AHB2PHY_SOUTH			516
>> +#define SLAVE_AHB2PHY_CENTER			517
>> +#define SLAVE_AOP				518
>> +#define SLAVE_AOSS				519
>> +#define SLAVE_APPSS				520
>> +#define SLAVE_BOOT_ROM				521
>> +#define SLAVE_NPU_CAL_DP0			522
>> +#define SLAVE_CAMERA_CFG			523
>> +#define SLAVE_CAMERA_NRT_THROTTLE_CFG		524
>> +#define SLAVE_CAMERA_RT_THROTTLE_CFG		525
>> +#define SLAVE_CLK_CTL				526
>> +#define SLAVE_NPU_CP				527
>> +#define SLAVE_RBCPR_CX_CFG			528
>> +#define SLAVE_RBCPR_MX_CFG			529
>> +#define SLAVE_CRYPTO_0_CFG			530
>> +#define SLAVE_DCC_CFG				531
>> +#define SLAVE_CNOC_DDRSS			532
>> +#define SLAVE_DISPLAY_CFG			533
>> +#define SLAVE_DISPLAY_RT_THROTTLE_CFG		534
>> +#define SLAVE_DISPLAY_THROTTLE_CFG		535
>> +#define SLAVE_NPU_INT_DMA_BWMON_CFG		536
>> +#define SLAVE_NPU_DPM				537
>> +#define SLAVE_EMMC_CFG				538
>> +#define SLAVE_GEM_NOC_CFG			539
>> +#define SLAVE_GLM				540
>> +#define SLAVE_GFX3D_CFG				541
>> +#define SLAVE_IMEM_CFG				542
>> +#define SLAVE_IPA_CFG				543
>> +#define SLAVE_ISENSE_CFG			544
>> +#define SLAVE_LLCC_CFG				545
>> +#define SLAVE_NPU_LLM_CFG			546
>> +#define SLAVE_MSS_PROC_MS_MPU_CFG		547
>> +#define SLAVE_CNOC_MNOC_CFG			548
>> +#define SLAVE_CNOC_MSS				549
>> +#define SLAVE_NPU_CFG				550
>> +#define SLAVE_NPU_DMA_BWMON_CFG			551
>> +#define SLAVE_NPU_PROC_BWMON_CFG		552
>> +#define SLAVE_PDM				553
>> +#define SLAVE_PIMEM_CFG				554
>> +#define SLAVE_PRNG				555
>> +#define SLAVE_QDSS_CFG				556
>> +#define SLAVE_QM_CFG				557
>> +#define SLAVE_QM_MPU_CFG			558
>> +#define SLAVE_QSPI_0				559
>> +#define SLAVE_QUP_0				560
>> +#define SLAVE_QUP_1				561
>> +#define SLAVE_SDCC_2				562
>> +#define SLAVE_SECURITY				563
>> +#define SLAVE_SNOC_CFG				564
>> +#define SLAVE_NPU_TCM				565
>> +#define SLAVE_TCSR				566
>> +#define SLAVE_TLMM_WEST				567
>> +#define SLAVE_TLMM_NORTH			568
>> +#define SLAVE_TLMM_SOUTH			569
>> +#define SLAVE_UFS_MEM_CFG			570
>> +#define SLAVE_USB3				571
>> +#define SLAVE_VENUS_CFG				572
>> +#define SLAVE_VENUS_THROTTLE_CFG		573
>> +#define SLAVE_VSENSE_CTRL_CFG			574
>> +#define SLAVE_A1NOC_SNOC			575
>> +#define SLAVE_A2NOC_SNOC			576
>> +#define SLAVE_CAMNOC_UNCOMP			577
>> +#define SLAVE_CDSP_GEM_NOC			578
>> +#define SLAVE_SNOC_CNOC				579
>> +#define SLAVE_GEM_NOC_SNOC			580
>> +#define SLAVE_SNOC_GEM_NOC_GC			581
>> +#define SLAVE_SNOC_GEM_NOC_SF			582
>> +#define SLAVE_LLCC				583
>> +#define SLAVE_MNOC_HF_MEM_NOC			584
>> +#define SLAVE_MNOC_SF_MEM_NOC			585
>> +#define SLAVE_NPU_COMPUTE_NOC			586
>> +#define SLAVE_QUP_CORE_0			587
>> +#define SLAVE_QUP_CORE_1			588
>> +#define SLAVE_IMEM				589
>> +#define SLAVE_PIMEM				590
>> +#define SLAVE_SERVICE_A1NOC			591
>> +#define SLAVE_SERVICE_A2NOC			592
>> +#define SLAVE_SERVICE_CNOC			593
>> +#define SLAVE_SERVICE_GEM_NOC			594
>> +#define SLAVE_SERVICE_MNOC			595
>> +#define SLAVE_SERVICE_NPU_NOC			596
>> +#define SLAVE_SERVICE_SNOC			597
>> +#define SLAVE_QDSS_STM				598
>> +#define SLAVE_TCU				599
>> +
>> +#endif
