Return-Path: <linux-pm+bounces-15555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6191499AD81
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 22:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C072887ED
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 20:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9111CF7A0;
	Fri, 11 Oct 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sm9BkrDO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4092F19AA72;
	Fri, 11 Oct 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728678628; cv=none; b=RpHS2WKMgSPZmuRipMFg99XPSjJpWS4CfeFiA9ezX/0Vz+/3VCkFoezSNIgncE+wNG6Q+7XVo8AoJ024JWzlL90BTIZJ5qPNKc842meXGZdoWsXpz+75l8hIVTLkkjOy6911xEeJfUuCpdDwxiwIFeHXtAIJOaA9ZlwvlGbrplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728678628; c=relaxed/simple;
	bh=lqTW1EIajGpu2JkzQF54VaQMNG3JfXVMaoOUMNDT0co=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=l/+lhfbzxtG644aRZELI9A86enHd6XUSxMfu/DYwe01V69bZXh8hmUCZCvN04HRzo09jItA3v7NMTlm6IuZ/YLqHMDevMnteUwuK/ETzTTsOfooeMS0wfVAnqJLIOUFYYH8F4TgmZDVlc/f8zn+dUGrM2b8O/zov9WLCXktozMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sm9BkrDO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BAw75v006577;
	Fri, 11 Oct 2024 20:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nsNU9A/fN1NQ6rHXF+XynD
	tkqhsEAGj067QIk562RqE=; b=Sm9BkrDO1WCURJyYLrvQxWKns+X02wcTzjWhCD
	aooaDiE2RFxKTtrrfc3wy+4UIVx++G9NkXw4i/s85f7m2d6RMkAwBisF3kSJ8Bsg
	9Bg+X2hQ9tyyQngElzAcoVqIi9pH8CkGPc4+LvuB2b1IY7C7euAIj9OS9H9ReHBt
	G2Du160xYEDsQ1uLIb88hIm62Rf8LYyXFIQnPicZcnB/FCny5dX+lxgFsbFVJS41
	ImOW71kiHCVU8v4irxpcp2T8oq9fMaGLNJigdSP+2ZkFo2Amie4KjbKCZB0+/yek
	+e8G1AXutsPWCxoySsyA6e1huMethmlLqBwOLL8CP0btqNxg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426t7stuvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 20:30:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49BKUCTl024322
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 20:30:12 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 11 Oct
 2024 13:30:06 -0700
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Subject: [PATCH RFC 0/3] Support for GPU ACD feature on Adreno X1-85
Date: Sat, 12 Oct 2024 01:59:27 +0530
Message-ID: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKeKCWcC/z2OTY7CMAyFr1J5TVDSpillhYQ0B5gtYuG6DnhBC
 0mpZoS4O1ZB7N6P9T0/IHMSzrAtHpB4lizjoMatCqAzDic20quH0pbeNqU3p+vdIPUmkOup7in
 WLoBeXxNH+VtIB/j92cNRw7PkaUz/C312S/UBhS9odsaaxmOFTfS+Cpvd7S4kA61pvMDx+WYn1
 jTL9BnoMLPR/iLTtsDSYuti57qI+pKtmeqOYouRLbVVqGKgjQqFPV9+poV48QAAAA==
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
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728678606; l=2083;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=lqTW1EIajGpu2JkzQF54VaQMNG3JfXVMaoOUMNDT0co=;
 b=DiinyLHnhSwliDcSHTQXn4g+yUMd5uz4xc6Lm0HFtaYYWOC0uXQvrbUrAhhwAGqfOPuuL19UE
 1fbwCIXGvGXAC4S3HiXr2yo6Lh2oxYly+3zycMino6bZIMA7yXXOyXW
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wOlbdTAU9tJ8VsoRG-VDnYO7I0s-BaLO
X-Proofpoint-ORIG-GUID: wOlbdTAU9tJ8VsoRG-VDnYO7I0s-BaLO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 clxscore=1011 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110143

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
I would like to have more feedback on this, hence the RFC tag for this
series.

ACD support is dynamically detected based on the presence of
"qcom,opp-acd-level" property in GPU's opp table. Also, qmp node should be
present under GMU node in devicetree for communication with AOSS.

The devicetree patch in this series adds the acd-level data for X1-85
GPU present in Snapdragon X1 Elite chipset.

This series is rebased on top of drm-msm/msm-next.

---
Akhil P Oommen (3):
      drm/msm/adreno: Add support for ACD
      dt-bindings: opp: Add v2-qcom-adreno vendor bindings
      arm64: dts: qcom: x1e80100: Add ACD levels for GPU

 .../bindings/opp/opp-v2-qcom-adreno.yaml           | 84 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 11 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 81 +++++++++++++++++----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              | 36 ++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h              | 21 ++++++
 6 files changed, 218 insertions(+), 16 deletions(-)
---
base-commit: a20a91fb1bfac5d05ec5bcf9afe0c9363f6c8c93
change-id: 20240724-gpu-acd-6c1dc5dcf516

Best regards,
-- 
Akhil P Oommen <quic_akhilpo@quicinc.com>


