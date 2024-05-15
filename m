Return-Path: <linux-pm+bounces-7880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B838D8C6EF1
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 01:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4311C2128C
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 23:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F95F52F8C;
	Wed, 15 May 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dVfpxxJ/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2A3C460;
	Wed, 15 May 2024 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715814630; cv=none; b=aNNGH7yKog6a1ajiiTSXMwB8ejkx8+2LZYvG5iyzDDfgnfQ+8163MvrrHNtha1SMm+7EFuMWr4qDMe0ZJip2TiAU36mBlVkjmmLXaSSd4y46SnkOHU/DbLG6/EZlqo8TAhKy8pFePW8vJ0bUy7gRDbZ/jSmnM8LFDtgs7W+N96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715814630; c=relaxed/simple;
	bh=YtOPMj/lxUkM2avcAHH5YxbmNPlDNwYZUGXHBrTyip8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=R5ySwloIOvBXHGEm9r/R2aRA4ijU1VPSdeXXc1DnfdWnKLNnFZqoDfXh9y3Liwt4Jn9J11jpMXKvMnrSpvLI3Fs9/RYsifFZWqJopyni3Lk4WTTOdoh/JBnel+WbOYinIPQw7REB2QVAt2ifZm3taHICkMvc7TIRJhuNpk1vVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dVfpxxJ/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FMIejX023142;
	Wed, 15 May 2024 23:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=zwxpOKX8sB506V
	Y50mheN5Ojaj4Hdm6oApG827r3OUY=; b=dVfpxxJ/D713JnaeXfnDsDeBYhP4aR
	npqPZxkG+djehRbXMLJ6UnRVXd26E0GS5/aPKWbw7AJd4R1MKG0hfiNFV2K/ReA3
	EdmhxJA/OYSBhwifJ02QwZbcG5LDTYpb4VXyUwVEkyEdVJmXSZ8wtUuYPNgBQ76A
	Z+uopdzXm+ip13CZuRW2Qsr/ICYPi0VmYlOOJA26VnfcZ3zZn6p5NyhcX/hb2lHC
	TmMW4H39wrBQCp7YvibUVZ6BkYDynhiDAaCywi9DqSs8Rj3iUCMaBceNTczAfXFI
	WoUdA0K9FknxtSMREtv5dziFbqwBRkUo2kiYJQ6flg4JyYfqtch6liIg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y3j28puwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 23:10:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44FNA5ha017979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 23:10:05 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 May 2024 16:10:05 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v3 0/4] Implement vendor resets for PSCI SYSTEM_RESET2
Date: Wed, 15 May 2024 16:09:43 -0700
Message-ID: <20240515-arm-psci-system_reset2-vendor-reboots-v3-0-16dd4f9c0ab4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALdARWYC/5WQy24CMQxFfwVlXVd2XlNY9T9QVQXHlCxmQpMhK
 kLz752h7QKpC1heL8651xdVpSSparO6qCIt1ZSHOZinleJDGD4EUpyz0qgNIXkIpYdj5QT1XEf
 p34tUGTU0GWIuUGSX81iB2YRonWfsUM2sY5F9+rp6tm9zPqQ65nK+ahst11+DtncaGgECetp1H
 eOaLL5+nhKngZ8594vyh2fwEV7kGL0xTodI//KIuof6GbaeNDkj+oa3/KDpv90WLd29Wy89wzq
 gc8Hbl/0td5qmb/4wlRnUAQAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: R_qEtypiC21jyvLjrl_XrrgVtEpzLaYT
X-Proofpoint-GUID: R_qEtypiC21jyvLjrl_XrrgVtEpzLaYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_14,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150164

The PSCI SYSTEM_RESET2 call allows vendor firmware to define additional
reset types which could be mapped to the reboot argument.

Setting up reboot on Qualcomm devices can be inconsistent from chipset
to chipset. Generally, there is a PMIC register that gets written to
decide the reboot type. There is also sometimes a cookie that can be
written to indicate that the bootloader should behave differently than a
regular boot. These knobs evolve over product generations and require 
more drivers. Qualcomm firmwares are beginning to expose vendor
SYSTEM_RESET2 types to simplify driver requirements from Linux.

Add support in PSCI to statically wire reboot mode commands from
userspace to a vendor reset and cookie value using the device tree. The
DT bindings are similar to reboot mode framework except that 2
integers are accepted (the type and cookie). Also, reboot mode framework
is intended to program the cookies, but not actually reboot the host.
PSCI SYSTEM_RESET2 does both. I've not added support for reading ACPI
tables since I don't have any device which provides them + firmware that
supports vendor SYSTEM_RESET2 types.

Previous discussions around SYSTEM_RESET2:
- https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
- https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
Changes in v3:
- Limit outer number of items to 1 for mode-* properties
- Move the reboot-mode for psci under a subnode "reset-types"
- Fix the DT node in qcm6490-idp so it doesn't overwrite the one from
  sc7820.dtsi
- Link to v2: https://lore.kernel.org/r/20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com

Changes in v2:
- Fixes to schema as suggested by Rob and Krzysztof
- Add qcm6490 idp as first Qualcomm device to support
- Link to v1: https://lore.kernel.org/r/20231117-arm-psci-system_reset2-vendor-reboots-v1-0-03c4612153e2@quicinc.com

Changes in v1:
- Reference reboot-mode bindings as suggeted by Rob.
- Link to RFC: https://lore.kernel.org/r/20231030-arm-psci-system_reset2-vendor-reboots-v1-0-dcdd63352ad1@quicinc.com

---
Elliot Berman (4):
      dt-bindings: power: reset: Convert mode-.* properties to array
      dt-bindings: arm: Document reboot mode magic
      firmware: psci: Read and use vendor reset types
      arm64: dts: qcom: Add PSCI SYSTEM_RESET2 types for qcm6490-idp

 Documentation/devicetree/bindings/arm/psci.yaml    | 43 +++++++++-
 .../bindings/power/reset/nvmem-reboot-mode.yaml    |  4 +
 .../devicetree/bindings/power/reset/qcom,pon.yaml  |  4 +
 .../bindings/power/reset/reboot-mode.yaml          | 14 +++-
 .../bindings/power/reset/syscon-reboot-mode.yaml   |  4 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts           |  7 ++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  2 +-
 drivers/firmware/psci/psci.c                       | 92 ++++++++++++++++++++++
 8 files changed, 165 insertions(+), 5 deletions(-)
---
base-commit: b5d2afe8745bf3eef5a59a13313798d24f2af983
change-id: 20231016-arm-psci-system_reset2-vendor-reboots-cc3ad456c070

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>


