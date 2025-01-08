Return-Path: <linux-pm+bounces-20114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60C5A06650
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 21:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007D43A7219
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45E0202C5D;
	Wed,  8 Jan 2025 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ketGsGW/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C9E1F9F4B;
	Wed,  8 Jan 2025 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368844; cv=none; b=SkzyuOJruvkIfjJ18ZGMfgUgBVEZlRt8MtH0FwdtmXib77ortwr9qH2IuOMKCnZO4FwLdPhvX+Q0dGkvkOuHT0vIKkUbXGqKECwq91fDfTIa7vLr64FMphwW5/uepB+oBrpZglE72RSvfTyPJfrJX/pwDGq9L99rlP3wsAx7NxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368844; c=relaxed/simple;
	bh=mP3e4YZddAGvahjk2HZAAOT5Oq0VSXTNEvcaAQbl2gU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Z8bvqg0NvG8X4621YfKvJ5AkHL6USNPKmMD7pkJ0WpHDYJ1y0sYyxTptUrQDmBS6zL1hp5ntVlEZFDiNhsaQ3gMCygNc3fDiLlX9WsV+CBDwPDeMHGrJMhaJMIUUgrceidsLRnxymjyGvVnZ/o3E2p6A2XXY2WL2IqU2vHzR6ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ketGsGW/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508GceHs002463;
	Wed, 8 Jan 2025 20:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MmmVej/51Kjt6A9bkZeUhE
	Uoj/xUWewiMnEyfTP8uHU=; b=ketGsGW/7g7BNx+C9fQF9thQ6l8uQn0HeyLyhH
	DaJDWazvpsnYJ/B5Vh7GcXMc+BJDy9XnB46iko7KDlM7cH9xlaPOWG0nmxG9p6Ry
	pH6iISd7minOH560ohjDS+arH8nFsIGsca9wUh3qJH5+7QLUMGStZAjNowi1WkF8
	WOrN9EZLszbb28WGGrPTUZ6dWJ+aUfCiuYFXGSzJLlNNnR5PfaE9vQ3acRkHD962
	09S6IV08ClSBn1VheJF1GF+t4Qhd4FRzOM9mEB+XEHmLxSXcZwrg/OULMM1le0jm
	XKG+X5qkEXMeg/A2ap6QSsS1j8O4jzBfT568Lq+G0V/RXw5A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441w2j8jde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 20:40:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 508KeRPd020787
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Jan 2025 20:40:27 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 Jan 2025
 12:40:21 -0800
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Subject: [PATCH v4 0/7] Support for GPU ACD feature on Adreno X1-85
Date: Thu, 9 Jan 2025 02:09:56 +0530
Message-ID: <20250109-gpu-acd-v4-0-08a5efaf4a23@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJzifmcC/2WQwW7CMAyGX6XKeUGxk6aU095j2sF1XciBFpISb
 UK8+1LQYNWOv+3vs+yrShKDJLWrripKDilMYwnurVJ8oHEvOvQlKzToTINO708XTdxrz9Bz3fN
 Qg1dl+hRlCF9308dnyYeQ5il+38UZluqvwz8dGbTRjSNLzeCc9dv38yVwGHnD03GRLgQYwDUBU
 ksLRG3d+RWx7M343AUG4UViIVvGmjxuje34P2lfJNo/pC2k7aix3htpmdbk7XF8lFJNYX58QHW
 URJf+Mcy7KvsNWB3ZlenbDxphfpxzAQAA
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon
	<nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736368821; l=3340;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=mP3e4YZddAGvahjk2HZAAOT5Oq0VSXTNEvcaAQbl2gU=;
 b=z2iX7nYDuxdiuqdLRXdB70QhHyJvtPGOgchmS96OVXtTZRSrOVQ45cUgZU78qZUu/ir+jh67w
 HjPx8ibGw7qCs/l0tEWDXDdIsiVILnxDc1Ls43h09+maI+Nw+kHJfKX
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qm6GXnLTgCEs5lfsie021mzlXrIK4uBf
X-Proofpoint-ORIG-GUID: Qm6GXnLTgCEs5lfsie021mzlXrIK4uBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080168

This series adds support for ACD feature for Adreno GPU which helps to
lower the power consumption on GX rail and also sometimes is a requirement
to enable higher GPU frequencies. At high level, following are the
sequences required for ACD feature:
	1. Identify the ACD level data for each regulator corner
	2. Send a message to AOSS to switch voltage plan
	3. Send a table with ACD level information to GMU during every
	gpu wake up

For (1), it is better to keep ACD level data in devicetree because this
value depends on the process node, voltage margins etc which are
chipset specific. For instance, same GPU HW IP on a different chipset
would have a different set of values. So, a new schema which extends
opp-v2 is created to add a new property called "qcom,opp-acd-level".

ACD support is dynamically detected based on the presence of
"qcom,opp-acd-level" property in GPU's opp table. Also, qmp node should be
present under GMU node in devicetree for communication with AOSS.

The devicetree patch in this series adds the acd-level data for X1-85
GPU present in Snapdragon X1 Elite chipset.

The last two devicetree patches are for Bjorn and all the rest for
Rob Clark.

---
Changes in v4:
- Send correct acd data via hfi (Neil)
- Fix dt-bindings error
- Fix IB vote for the 1.1Ghz OPP
- New patch#2 to fix the HFI timeout error seen when ACD is enabled
- Link to v3: https://lore.kernel.org/r/20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com

Changes in v3:
- Rebased on top of v6.13-rc4 since X1E doesn't boot properly with msm-next
- Update patternProperties regex (Krzysztof)
- Update MAINTAINERS file include the new opp-v2-qcom-adreno.yaml
- Update the new dt properties' description
- Do not move qmp_get() to acd probe (Konrad)
- New patches: patch#2, #3 and #6
- Link to v2: https://lore.kernel.org/r/20241021-gpu-acd-v2-0-9c25a62803bc@quicinc.com

Changes in v2:
- Removed RFC tag for the series
- Improve documentation for the new dt bindings (Krzysztof)
- Add fallback compatible string for opp-table (Krzysztof)
- Link to v1: https://lore.kernel.org/r/20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com

---
Akhil P Oommen (7):
      drm/msm/adreno: Add support for ACD
      drm/msm/a6xx: Increase HFI response timeout
      drm/msm: a6x: Rework qmp_get() error handling
      drm/msm/adreno: Add module param to disable ACD
      dt-bindings: opp: Add v2-qcom-adreno vendor bindings
      arm64: dts: qcom: x1e80100: Add ACD levels for GPU
      arm64: dts: qcom: x1e80100: Add OPPs up to Turbo L3 for GPU

 .../bindings/opp/opp-v2-qcom-adreno.yaml           | 97 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 27 +++++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 96 ++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              | 38 ++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h              | 21 +++++
 drivers/gpu/drm/msm/adreno/adreno_device.c         |  4 +
 8 files changed, 270 insertions(+), 15 deletions(-)
---
base-commit: dbfac60febfa806abb2d384cb6441e77335d2799
change-id: 20240724-gpu-acd-6c1dc5dcf516

Best regards,
-- 
Akhil P Oommen <quic_akhilpo@quicinc.com>


