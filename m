Return-Path: <linux-pm+bounces-13647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD17396CCC5
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 04:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CA11F26BD0
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 02:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20227E792;
	Thu,  5 Sep 2024 02:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JY1yAQvd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960D1FB4;
	Thu,  5 Sep 2024 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725504353; cv=none; b=SyDD6e9xpTTPRIGae9sz0pkT8UJUohSRZyPTsoA4z1In7nyAszDTcDPvZmuzfO2IgLfu5oQVuySCM/rE8nSKiIdvsUwD7hhRce3iF8/PiPkHQBcTy9aMxffQm2liSc36B+ULd6ZkpX42EEmkielyj9VO6ibJps/x9bmyeeXcysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725504353; c=relaxed/simple;
	bh=aKEtYUXQLqikNODrnijo1YTsFV3NZJNU2cYaaRrxQa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R2ciw/8pCFeI313Duwq7mvbKHwn1726p5yf/Qi+cfGIcFDpScIjWGucm3jANcOpiy01evDWLk+Pticnb1g5b09Px5/36NFA3GFBODzZA/4UITFNchCHrzeCJZ/WocvBrYXeKIV/6Y6ObVZI+xESgp9ArDJ3iSGGQQE0qACoA+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JY1yAQvd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484L48tt024309;
	Thu, 5 Sep 2024 02:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rQrbhMR/CE4iptIhLzZS/lBVwTvylcrdfrjZy3BjVu8=; b=JY1yAQvd1DXTsjX9
	YOvxz3ox5cnAoC/yoU2qrz6UK4scoKmAr3wTR4xu1S0vipsmKM2/r+V0LQhYkB19
	k0i3fdNITyEF4l16F8VYGLuzhRXbCThau8oxuTs4KJzh0HvU/KrKvnlsiHmZuaMU
	2LPmr7IT+n+oVoXCA4ZtJGLlT/ocDxv5Kg/QQWNLBY3sPu1qsfzIS547TkE63Ujh
	EF/UoSczWCXQ9KOKGc94t7sFiCFBO0DqgIeX9dSrpEBGSd8wzzHkJtxcbV3j2ZhY
	PAi14DBQlm8w3z3ZAOklqFGhvaNon2UZD4ie8oazz6x4lzA/FwTwkwEcLmeV08G8
	EbSgZg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41btrxvhf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 02:45:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4852jUkZ026124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 02:45:30 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 19:45:27 -0700
Message-ID: <8c97b94a-b688-4843-9b90-bbd78d1b8db9@quicinc.com>
Date: Thu, 5 Sep 2024 10:45:25 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] Add initial support for QCS8300
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Xin Liu <quic_liuxin@quicinc.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
 <172545686260.2410635.12324465724634886770.robh@kernel.org>
Content-Language: en-US
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <172545686260.2410635.12324465724634886770.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9Dpttvwml2x3qpHlenMKTHv35F2d-uqX
X-Proofpoint-ORIG-GUID: 9Dpttvwml2x3qpHlenMKTHv35F2d-uqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_02,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409050019

Hi Rob,

On 9/4/2024 9:36 PM, Rob Herring (Arm) wrote:
> 
> On Wed, 04 Sep 2024 16:33:41 +0800, Jingyi Wang wrote:
>> Add initial support for QCS8300 SoC and QCS8300 RIDE board.
>>
>> This revision brings support for:
>> - CPUs with cpu idle
>> - interrupt-controller with PDC wakeup support
>> - gcc
>> - TLMM
>> - interconnect
>> - qup with uart
>> - smmu
>> - pmic
>> - ufs
>> - ipcc
>> - sram
>> - remoteprocs including ADSP,CDSP and GPDSP
>>
>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>> ---
>> patch series organized as:
>> - 1-2: remoteproc binding and driver
>> - 3-5: ufs binding and driver
>> - 6-7: rpmhpd binding and driver
>> - 8-15: bindings for other components found on the SoC
>> - 16-19: changes to support the device tree
>>
>> dependencies:
>> tlmm: https://lore.kernel.org/linux-arm-msm/20240819064933.1778204-1-quic_jingyw@quicinc.com/
>> gcc: https://lore.kernel.org/all/20240820-qcs8300-gcc-v1-0-d81720517a82@quicinc.com/
>> interconnect: https://lore.kernel.org/linux-arm-msm/20240827151622.305-1-quic_rlaggysh@quicinc.com/
>>
>> dtb check got following err:
>> /local/mnt/workspace/jingyi/aim500/linux/arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: interconnect@1680000: Unevaluated properties are not allowed ('reg' was unexpected)
>> which is cause by "reg" compatible missing in dt binding, will be fixed in interconnect patch series.
>>
>> ---
>> Jingyi Wang (11):
>>       dt-bindings: remoteproc: qcom,sa8775p-pas: Document QCS8300 remoteproc
>>       remoteproc: qcom: pas: Add QCS8300 remoteproc support
>>       dt-bindings: qcom,pdc: document QCS8300 Power Domain Controller
>>       dt-bindings: soc: qcom: add qcom,qcs8300-imem compatible
>>       dt-bindings: mailbox: qcom-ipcc: Document QCS8300 IPCC
>>       dt-bindings: mfd: qcom,tcsr: Add compatible for QCS8300
>>       dt-bindings: nvmem: qfprom: Add compatible for QCS8300
>>       dt-bindings: arm: qcom: document QCS8275/QCS8300 SoC and reference board
>>       arm64: defconfig: enable clock controller, interconnect and pinctrl for QCS8300
>>       arm64: dts: qcom: add initial support for QCS8300 DTSI
>>       arm64: dts: qcom: add base QCS8300 RIDE dts
>>
>> Kyle Deng (1):
>>       dt-bindings: soc: qcom,aoss-qmp: Document the QCS8300 AOSS channel
>>
>> Shazad Hussain (1):
>>       dt-bindings: power: rpmpd: Add QCS8300 power domains
>>
>> Tingguo Cheng (1):
>>       pmdomain: qcom: rpmhpd: Add QCS8300 power domains
>>
>> Xin Liu (3):
>>       dt-bindings: phy: Add QMP UFS PHY comptible for QCS8300
>>       dt-bindings: ufs: qcom: Document the QCS8300 UFS Controller
>>       phy: qcom-qmp-ufs: Add support for QCS8300
>>
>> Zhenhua Huang (2):
>>       dt-bindings: arm-smmu: Add compatible for QCS8300 SoC
>>       dt-bindings: firmware: qcom,scm: document SCM on QCS8300 SoCs
>>
>>  Documentation/devicetree/bindings/arm/qcom.yaml    |    8 +
>>  .../devicetree/bindings/firmware/qcom,scm.yaml     |    1 +
>>  .../bindings/interrupt-controller/qcom,pdc.yaml    |    1 +
>>  .../devicetree/bindings/iommu/arm,smmu.yaml        |    2 +
>>  .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |    1 +
>>  .../devicetree/bindings/mfd/qcom,tcsr.yaml         |    1 +
>>  .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    1 +
>>  .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |    2 +
>>  .../devicetree/bindings/power/qcom,rpmpd.yaml      |    1 +
>>  .../bindings/remoteproc/qcom,sa8775p-pas.yaml      |    6 +
>>  .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |    1 +
>>  .../devicetree/bindings/sram/qcom,imem.yaml        |    1 +
>>  .../devicetree/bindings/ufs/qcom,ufs.yaml          |    2 +
>>  arch/arm64/boot/dts/qcom/Makefile                  |    1 +
>>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts          |  246 ++++
>>  arch/arm64/boot/dts/qcom/qcs8300.dtsi              | 1282 ++++++++++++++++++++
>>  arch/arm64/configs/defconfig                       |    3 +
>>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            |    3 +
>>  drivers/pmdomain/qcom/rpmhpd.c                     |   24 +
>>  drivers/remoteproc/qcom_q6v5_pas.c                 |    3 +
>>  include/dt-bindings/power/qcom-rpmpd.h             |   19 +
>>  21 files changed, 1609 insertions(+)
>> ---
>> base-commit: eb8c5ca373cbb018a84eb4db25c863302c9b6314
>> change-id: 20240829-qcs8300_initial_dtsi-1a386eb317d3
>>
>> Best regards,
>> --
>> Jingyi Wang <quic_jingyw@quicinc.com>
>>
>>
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y qcom/qcs8300-ride.dtb' for 20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com:
> 
> In file included from arch/arm64/boot/dts/qcom/qcs8300-ride.dts:11:
> arch/arm64/boot/dts/qcom/qcs8300.dtsi:6:10: fatal error: dt-bindings/clock/qcom,qcs8300-gcc.h: No such file or directory
>     6 | #include <dt-bindings/clock/qcom,qcs8300-gcc.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.lib:434: arch/arm64/boot/dts/qcom/qcs8300-ride.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:490: arch/arm64/boot/dts/qcom] Error 2
> make[2]: Target 'arch/arm64/boot/dts/qcom/qcs8300-ride.dtb' not remade because of errors.
> make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1390: qcom/qcs8300-ride.dtb] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
> make: Target 'qcom/qcs8300-ride.dtb' not remade because of errors.
> 
> 
> 
> 
> 
As mentioned in the cover letter, the dtsi is depend on the gcc patch series:
https://lore.kernel.org/all/20240820-qcs8300-gcc-v1-0-d81720517a82@quicinc.com/
which includes the qcom,qcs8300-gcc.h file.

Thanks,
Jingyi

