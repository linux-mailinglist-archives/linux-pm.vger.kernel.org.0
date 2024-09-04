Return-Path: <linux-pm+bounces-13525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8003996B4A1
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 10:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F269B1F229ED
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFEC1CC144;
	Wed,  4 Sep 2024 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jsz897Z3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A59381AB4;
	Wed,  4 Sep 2024 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438885; cv=none; b=sTP88fGR7eny/iL0lvrIZOSRUQAAAKPj/pDSor2bLoaJ/SyziqFMwWgZTp0DHoahZQMv7PrVibdk2ZJ+ILwh3y4HiI/9lF5XQbZtd84fmhaE2eujawCd7U1f9nNDGYa9fazBbSzWJ6X3uNlxkvhLwvTBe3q13IeQWAWZJlu4lVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438885; c=relaxed/simple;
	bh=TSbTlxmynJaa+3azrWecam5RAA/J2OsZiqLEu2rc0/A=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=IXJnIWWaS7bvk1CIsis/NoVe4vA/yBnRhmfY6WJCscg+0EJ9LWG+sLMTN7PrcM19Q1CozgL3OVeklPSNQ8fwc3QdpEInkrRpRYWvyKn1K++mlsKrFzpNb+34ee7A98hKcrQT8eZsB53DfMJ267aCYXww4aIgEvKC17uCfAy1m9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jsz897Z3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483K82GG008946;
	Wed, 4 Sep 2024 08:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZFB8Kbz1SyQHqfis6mv9oa
	YLaY2wXicDsXVo/UQ/XXA=; b=Jsz897Z3U+4m/hf7K71SMJtBPibh2E//L6EZ2u
	yUEQDyc164kEMMDCFqb+WNXMwiMiFqIdI17P14X4Av1K+//nINN3t2nrSO1Vltnh
	tM9I/etgXSVtqglQ/6evAj7S8sKBFk+XFOm0K3LUXP5xkkfYO9U/KQ4R7pogM7Na
	U4NbcnytewUy2QeqYGMUhpDxLUmIiQOC/GwqXjPNXZ0elHKXLLm/WvSZOe/R7FN8
	4LG5hE5zXt8C4dbEEUb60THRF2oH+GTWLtpsP04spcYFhrOnNVn+XdcdmP9XKTEO
	7GNyFGsM7V/2o4YHuUDDXUgNh8vIsEu0fQf8/0hPSkoIx28Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bud2t4j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 08:34:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4848YAjL001656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 08:34:10 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 01:34:01 -0700
From: Jingyi Wang <quic_jingyw@quicinc.com>
Subject: [PATCH 00/19] Add initial support for QCS8300
Date: Wed, 4 Sep 2024 16:33:41 +0800
Message-ID: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGYb2GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNL3cLkYgtjA4P4zLzMkszEnPiUkuJMXcNEYwuz1CRjQ/MUYyWg1oK
 i1LTMCrCx0bG1tQBX97wSZgAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, "Andy Gross" <agross@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
        Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh
	<quic_gurus@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones
	<lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, Jingyi Wang <quic_jingyw@quicinc.com>,
        Xin Liu
	<quic_liuxin@quicinc.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Tingguo Cheng <quic_tingguoc@quicinc.com>,
        Zhenhua Huang
	<quic_zhenhuah@quicinc.com>,
        Kyle Deng <quic_chunkaid@quicinc.com>,
        "Raviteja
 Laggyshetty" <quic_rlaggysh@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725438840; l=4106;
 i=quic_jingyw@quicinc.com; s=20240829; h=from:subject:message-id;
 bh=TSbTlxmynJaa+3azrWecam5RAA/J2OsZiqLEu2rc0/A=;
 b=pljMssqerWcs/iddcMjH4610nwwVlYPdgrso7lGrkJYZmSy9VyEegf+c9Qbq/0NUtpZoex7v0
 rTLtTVzd7zoAMOuNoVgqH6ER65mNCiB25uwQyN3Wa5u0FPhje08Mamw
X-Developer-Key: i=quic_jingyw@quicinc.com; a=ed25519;
 pk=3tHAHZsIl3cClXtU9HGR1okpPOs9Xyy1M0jzHw6A/qs=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MZ_8Z4fjhEJalyL95xmfS_Ekm-0cBv1H
X-Proofpoint-ORIG-GUID: MZ_8Z4fjhEJalyL95xmfS_Ekm-0cBv1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_05,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040065

Add initial support for QCS8300 SoC and QCS8300 RIDE board.

This revision brings support for:
- CPUs with cpu idle
- interrupt-controller with PDC wakeup support
- gcc
- TLMM
- interconnect
- qup with uart
- smmu
- pmic
- ufs
- ipcc
- sram
- remoteprocs including ADSP,CDSP and GPDSP

Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---
patch series organized as:
- 1-2: remoteproc binding and driver
- 3-5: ufs binding and driver
- 6-7: rpmhpd binding and driver
- 8-15: bindings for other components found on the SoC
- 16-19: changes to support the device tree

dependencies:
tlmm: https://lore.kernel.org/linux-arm-msm/20240819064933.1778204-1-quic_jingyw@quicinc.com/
gcc: https://lore.kernel.org/all/20240820-qcs8300-gcc-v1-0-d81720517a82@quicinc.com/
interconnect: https://lore.kernel.org/linux-arm-msm/20240827151622.305-1-quic_rlaggysh@quicinc.com/

dtb check got following err:
/local/mnt/workspace/jingyi/aim500/linux/arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: interconnect@1680000: Unevaluated properties are not allowed ('reg' was unexpected)
which is cause by "reg" compatible missing in dt binding, will be fixed in interconnect patch series.

---
Jingyi Wang (11):
      dt-bindings: remoteproc: qcom,sa8775p-pas: Document QCS8300 remoteproc
      remoteproc: qcom: pas: Add QCS8300 remoteproc support
      dt-bindings: qcom,pdc: document QCS8300 Power Domain Controller
      dt-bindings: soc: qcom: add qcom,qcs8300-imem compatible
      dt-bindings: mailbox: qcom-ipcc: Document QCS8300 IPCC
      dt-bindings: mfd: qcom,tcsr: Add compatible for QCS8300
      dt-bindings: nvmem: qfprom: Add compatible for QCS8300
      dt-bindings: arm: qcom: document QCS8275/QCS8300 SoC and reference board
      arm64: defconfig: enable clock controller, interconnect and pinctrl for QCS8300
      arm64: dts: qcom: add initial support for QCS8300 DTSI
      arm64: dts: qcom: add base QCS8300 RIDE dts

Kyle Deng (1):
      dt-bindings: soc: qcom,aoss-qmp: Document the QCS8300 AOSS channel

Shazad Hussain (1):
      dt-bindings: power: rpmpd: Add QCS8300 power domains

Tingguo Cheng (1):
      pmdomain: qcom: rpmhpd: Add QCS8300 power domains

Xin Liu (3):
      dt-bindings: phy: Add QMP UFS PHY comptible for QCS8300
      dt-bindings: ufs: qcom: Document the QCS8300 UFS Controller
      phy: qcom-qmp-ufs: Add support for QCS8300

Zhenhua Huang (2):
      dt-bindings: arm-smmu: Add compatible for QCS8300 SoC
      dt-bindings: firmware: qcom,scm: document SCM on QCS8300 SoCs

 Documentation/devicetree/bindings/arm/qcom.yaml    |    8 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    1 +
 .../bindings/interrupt-controller/qcom,pdc.yaml    |    1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |    2 +
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |    1 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |    1 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    1 +
 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    |    2 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |    1 +
 .../bindings/remoteproc/qcom,sa8775p-pas.yaml      |    6 +
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |    1 +
 .../devicetree/bindings/sram/qcom,imem.yaml        |    1 +
 .../devicetree/bindings/ufs/qcom,ufs.yaml          |    2 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts          |  246 ++++
 arch/arm64/boot/dts/qcom/qcs8300.dtsi              | 1282 ++++++++++++++++++++
 arch/arm64/configs/defconfig                       |    3 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            |    3 +
 drivers/pmdomain/qcom/rpmhpd.c                     |   24 +
 drivers/remoteproc/qcom_q6v5_pas.c                 |    3 +
 include/dt-bindings/power/qcom-rpmpd.h             |   19 +
 21 files changed, 1609 insertions(+)
---
base-commit: eb8c5ca373cbb018a84eb4db25c863302c9b6314
change-id: 20240829-qcs8300_initial_dtsi-1a386eb317d3

Best regards,
-- 
Jingyi Wang <quic_jingyw@quicinc.com>


