Return-Path: <linux-pm+bounces-16083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F96A9A671D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB07281E23
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 11:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257DC1E7C38;
	Mon, 21 Oct 2024 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I9cWrsLA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AE81E7C3F;
	Mon, 21 Oct 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511724; cv=none; b=bQoNItRQUC878X611yZaGCw8SFfUORSeXSJ0sRfWNff6Jc4rCXi9XY45iPZ4WICJfGJa0jjwWSb7MbjlVohcvpOuWgmg9u0mpXYThyTt7j39CFm56QStRzLFQx2/1yn7ialVKep1UhEtIzUl2EBqMqbTebVXRWGCMM+BF0VnLK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511724; c=relaxed/simple;
	bh=0HVrOE86DnZaiYW3MGtsZuEah16TqfMsufQd8UAkbhA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=d8ZlY0g6tSLmFx7gMpjljJGWPmo+z3MZstvru+61OTfIvEj7dfo32U8+kJYdcf0sHgvolxtoI6cZ90a0CYlKxGOOmr9maQBaJif2NpJARMhzkLNJgGzNd06xBzAMDJp8hK5TINDJJwJ6qo9b+mVjgXNrkEeotLz9glvGdxFLrgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I9cWrsLA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L9kSDW003362;
	Mon, 21 Oct 2024 11:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qwYfFDxh23KnAHui/7MZu3
	MbYfVHXWE+hUDAtR5QkdE=; b=I9cWrsLA0J3hQCfwZO6NBoct3Vfr12XL7UsBFz
	lDsHBtTXWWVRJqGM6kZ0qKHBqi2Al0OmM9NGpSyTG4R5YsJln//6cq+DXDbDYjB8
	PwYl8REKNI0DiULRQe/mUdm+PRM2SCuWZKhkPnXXAfqRhzL5hK8D/pYEh4A+zuoN
	7hSC6f/xQXFkIOIZ6U+2biLyy8fBrYU3eGVwjcDzferg9r7p/ZprXFTLiYmw1Tyh
	72SNBiiBo/EoDnQqpEM3fDIiLptLbVIfK/7tdjARf63lC6apifroaLUfydWLrvvJ
	5skhMshr8/72bHkISQ5eoBAamtl6vNqy9T8hjmEd17tIK7HA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6tuvk4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 11:55:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49LBt815010731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 11:55:08 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 21 Oct
 2024 04:55:02 -0700
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Subject: [PATCH v2 0/3] Support for GPU ACD feature on Adreno X1-85
Date: Mon, 21 Oct 2024 17:23:41 +0530
Message-ID: <20241021-gpu-acd-v2-0-9c25a62803bc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMVAFmcC/1WOwW7DIBBEf8XiXCoWAw459T+qHJb1kuwhdgqO1
 SrKvxcnaqXcdmZ2nuamKhfhqvbdTRVepco8NWHfOkUnnI6sZWxaWWOdGazTx8tVI406EIzkR8o
 egmrfl8JZvh+kz0PTJ6nLXH4e4BU2948R/hkraKMHhz0O2bk+7D6+rkIy0TvN5w26NcCAfW0Ae
 46AGH0KL43D/TmkcHOrLM81KmFl3fKzLPsOrcEIOUHK2PYbz+QT5YiZDcU+9DnQrh0Ndv8FYzd
 XFx4BAAA=
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
	<andersson@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729511702; l=2262;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=0HVrOE86DnZaiYW3MGtsZuEah16TqfMsufQd8UAkbhA=;
 b=RKhQ2aT6MAqZPAohK/V0TdLeJ+mX/JCr7l2R8QdQYIFLB8OG2Ae5/xfKgk3j1Y4IVN6fBdGx6
 VeR15bf59vRABNyHUzJj7E3CJTiL3VaFXjX+oPJ7lCxpifJ3JgWePC/
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 07fnzkVr-ea6yaDW3M_mSKamN53JoAH6
X-Proofpoint-GUID: 07fnzkVr-ea6yaDW3M_mSKamN53JoAH6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410210085

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

This series is rebased on top of drm-msm/msm-next.

---
Changes in v2:
- Removed RFC tag for the series
- Improve documentation for the new dt bindings (Krzysztof)
- Add fallback compatible string for opp-table (Krzysztof)
- Link to v1: https://lore.kernel.org/r/20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com

---
Akhil P Oommen (3):
      drm/msm/adreno: Add support for ACD
      dt-bindings: opp: Add v2-qcom-adreno vendor bindings
      arm64: dts: qcom: x1e80100: Add ACD levels for GPU

 .../bindings/opp/opp-v2-qcom-adreno.yaml           | 96 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 11 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 81 ++++++++++++++----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              | 36 ++++++++
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h              | 21 +++++
 6 files changed, 230 insertions(+), 16 deletions(-)
---
base-commit: a20a91fb1bfac5d05ec5bcf9afe0c9363f6c8c93
change-id: 20240724-gpu-acd-6c1dc5dcf516

Best regards,
-- 
Akhil P Oommen <quic_akhilpo@quicinc.com>


