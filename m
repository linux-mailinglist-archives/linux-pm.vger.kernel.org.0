Return-Path: <linux-pm+bounces-9350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFAC90B7A8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 19:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02EAE1F24469
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 17:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFFE16CD39;
	Mon, 17 Jun 2024 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ekY7PxHB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4C16CD09;
	Mon, 17 Jun 2024 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644732; cv=none; b=dj7IxuBFLzehUENxmKDo+Pu6lL6QBvFaLtIWWsRySuOAXHrQ0LBeJMFljRUyE/2w/iEQhLddepeyicTeHVWq6iKkU9bjREeYnU0ldvvBdFfxkzNBTOILQiVGoxufOOuqr8t53IBx8St/a0yMmssN6q0GU0D41EVbQKxP1W2ZmEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644732; c=relaxed/simple;
	bh=2y9hBWV6rEs7wq0wpQXBhqg0neYDJCWkuRpyIK1s8/Y=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=SAqln1nI5/7Qy8QNfotBuPZ3jakhg/yt2C6pIIJ0fkqRwQh1pRcVTNB6SlQ+CDPmPc2FsvIEmAH9ctl4KuWisFu8Fh3eNP7KCpL5lTMWxQn5P1bDhvLa+bWqyxCnOuVDcKokUjP7NabtuCMK1xNeEEoHxOwSYjw3OxklkDcTjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ekY7PxHB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HAbg2J013205;
	Mon, 17 Jun 2024 17:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vtuxO88tnAEVRJbOzp44PX
	bXQVX+FDnlpBNp649R4ug=; b=ekY7PxHB/hYXev2ypnj4AfRWqRGoIjLKUrP+Zh
	FdeUq8Cg1cWyS09KbsCekb5Nav2oMdgqTHjqKKYOQjc3DNWPtORAEUWMh0kl+/KG
	fRdrDXsS2/sifv2i0xJ/qMLxRvvU1awIb1e6DpjM9y6oqo0eNVtto4YWLIbDXP4Z
	DvXtGium+aDuuqIdXbpAUWYbZq9LKsJR+IQCLdY01q7y1yFxgNlBwJRm6Jn8kF7y
	emjB2FPdSzZJ9oA+fbNCDS9tyk0Soh5Y2cFLwOLY8C17jtcL9mIVcbx3FaUEkdgM
	ANr91Ji4tYaC45KvcNjRh7vPTnjFPZK1QzjQCUGhCEcQzccQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ysv5xjt38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 17:18:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HHIUIK026008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 17:18:30 GMT
Received: from hu-eberman-lv.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Jun 2024 10:18:29 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v5 0/4] Implement vendor resets for PSCI SYSTEM_RESET2
Date: Mon, 17 Jun 2024 10:18:06 -0700
Message-ID: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM5vcGYC/5XQQU7DMBAF0KtUWWM0Y4+dhBX3QAg59oR6kbjYI
 aKqcnecAqqqskiX34v3//hUZU6Bc/W0O1WJ55BDHEvQD7vK7e34ziL4kisJUiGgETYN4pBdEPm
 YJx7eEmeepJh59DGJxF2MUxbOKetJGwc1VMU6JO7D17nn5bXkfchTTMdz7Yzr62+DpI0NMwoQY
 LCrawctEjx/fAYXRvfo4rBW/ngK7vG8894opaX1+K+HWN+1TzkyKFErllfe+gez/LubgHDz3XL
 daVsLWltDTX/rqourUW91VXHReE9968B2dOvSxTWIW10qbtv0Za2tyXJz7S7L8g1iJqfFhAIAA
 A==
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
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: --jaKV-18tmOYn5WvgyKDkF5rf7-6gSS
X-Proofpoint-ORIG-GUID: --jaKV-18tmOYn5WvgyKDkF5rf7-6gSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=826
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406170134

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
Changes in v5:
- Drop the nested "items" in prep for future dtschema tools
- Link to v4: https://lore.kernel.org/r/20240611-arm-psci-system_reset2-vendor-reboots-v4-0-98f55aa74ae8@quicinc.com

Changes in v4:
- Change mode- properties from uint32-matrix to uint32-array
- Restructure the reset-types node so only the restriction is in the
  if/then schemas and not the entire definition
- Link to v3: https://lore.kernel.org/r/20240515-arm-psci-system_reset2-vendor-reboots-v3-0-16dd4f9c0ab4@quicinc.com

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

 Documentation/devicetree/bindings/arm/psci.yaml    | 43 ++++++++++
 .../bindings/power/reset/nvmem-reboot-mode.yaml    |  4 +
 .../devicetree/bindings/power/reset/qcom,pon.yaml  |  7 ++
 .../bindings/power/reset/reboot-mode.yaml          |  4 +-
 .../bindings/power/reset/syscon-reboot-mode.yaml   |  4 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts           |  7 ++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  2 +-
 drivers/firmware/psci/psci.c                       | 92 ++++++++++++++++++++++
 8 files changed, 160 insertions(+), 3 deletions(-)
---
base-commit: e92bee9f861b466c676f0200be3e46af7bc4ac6b
change-id: 20231016-arm-psci-system_reset2-vendor-reboots-cc3ad456c070

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>


