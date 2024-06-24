Return-Path: <linux-pm+bounces-9852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 342EE91419E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 07:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EAD51C22AC4
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 05:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B92156CF;
	Mon, 24 Jun 2024 05:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f91aen9r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC8111187;
	Mon, 24 Jun 2024 05:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719205416; cv=none; b=fw9y3Q4OFHAWjJWUGx/urAPT1R6OF5zq6zNdY3MAhQIfLfqHkUHEQlAzyzgXFz9T254jNsIh+Omr3o3JbpcjyxnzTe0ESOQ4uII270VVNLX/4M7li0g2+UiRKnBCEGzZHgTYu5ZergQ4i7d4T47cNgMMYXbZfya0BmJRQgFLCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719205416; c=relaxed/simple;
	bh=CcC4Zuz/drcO8nWpmJRJKrsKuh7xi6r8YElcifeiaDs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YymAJ63XjvTfcdqvmqR2BE19eQXv7W6eQ6IHfoI3FZyQNuzOYseX9tyLdjBAf+2xmmomORTp6KeVyf/ply2yD4pqDd74iQSdweXnP+u1isNIqWDB5zFY6JXRQTByHOVGE1v7ntrjofzoV2NV4g2lLqwbDq+PY0LzlruL5/yMsig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f91aen9r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NMhakO027950;
	Mon, 24 Jun 2024 05:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=P0HbXYdemLq06rk6Ds6aLV
	ie97k5l+YMqAL/6d90F94=; b=f91aen9rtexmRpXxlFQYx+Iw3AY+B3Nu1UZLqV
	RFaQsAj76veKejBNKBzgaD18/DYx6HiO9kV+RZG+yitJ2QXxkK7FKRe2qKGm2WDm
	BcyJElYC9MABA9E9vZ/cMKfc2DveS1kUdeDnDXfLUXb836/istWM+V/6koDXqSCp
	R9eJ1LAgbE6thePIO2uqXvXOauk/RupLUbIt4gLfQwuZ2jv0sJCm8XtnUX+6ISoO
	nb6qtjoG3dIm9Xv+3YQfExSIKi8Q+dUFlxVehIpc4jZTP0/7G4rnk67n/RKxXck7
	XCxjAjslgSxnyeohEt7dI4ltEhPKmlywgjPFPmfmT4o1kdlA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqceaprw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 05:03:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O53OxL019489
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 05:03:24 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Jun 2024 22:03:17 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <abel.vesa@linaro.org>, <otto.pflueger@abscue.de>,
        <quic_rohiagar@quicinc.com>, <quic_varada@quicinc.com>,
        <luca@z3ntu.xyz>, <quic_ipkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v2 0/7] Enable CPR for IPQ9574
Date: Mon, 24 Jun 2024 10:32:47 +0530
Message-ID: <20240624050254.2942959-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pP0kyQlm5ieUY3B2qZpBzAeJ90cB0D7E
X-Proofpoint-ORIG-GUID: pP0kyQlm5ieUY3B2qZpBzAeJ90cB0D7E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240038

This series tries to enable CPR on IPQ9574, that implements
CPRv4. Since [1] is older, faced few minor issues. Those are
addressed in [2].

dt_binding_check and dtbs_check passed.

Depends:
	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
	[2] https://github.com/quic-varada/cpr/commits/konrad/

v2: Fix Signed-off-by order in 2 patches
    Update constraints in qcom,cpr3.yaml
    Add rbcpr_clk_src registration
    Add Reviewed-by to one of the patches
    Not adding Acked-by as the file has changed

Varadarajan Narayanan (7):
  dt-bindings: power: rpmpd: Add IPQ9574 power domains
  dt-bindings: soc: qcom: cpr3: Add bindings for IPQ9574
  pmdomain: qcom: rpmpd: Add IPQ9574 power domains
  dt-bindings: clock: Add CPR clock defines for IPQ9574
  clk: qcom: gcc-ipq9574: Add CPR clock definition
  soc: qcom: cpr3: Add IPQ9574 definitions
  dts: arm64: qcom: ipq9574: Enable CPR

 .../devicetree/bindings/power/qcom,rpmpd.yaml |   1 +
 .../bindings/soc/qcom/qcom,cpr3.yaml          |  35 +++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 269 ++++++++++++++++--
 drivers/clk/qcom/gcc-ipq9574.c                |  39 +++
 drivers/pmdomain/qcom/cpr3.c                  | 137 +++++++++
 drivers/pmdomain/qcom/rpmpd.c                 |  19 ++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   2 +
 include/dt-bindings/power/qcom-rpmpd.h        |   3 +
 8 files changed, 488 insertions(+), 17 deletions(-)

-- 
2.34.1


