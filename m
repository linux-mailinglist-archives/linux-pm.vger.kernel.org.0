Return-Path: <linux-pm+bounces-9884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2702F91463A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 11:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8C71F211AA
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 09:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70EB1304AA;
	Mon, 24 Jun 2024 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IoL1TrH4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE024962B;
	Mon, 24 Jun 2024 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220975; cv=none; b=QYKlxXGSzN/wC+iQ3xLOFN1se6F4Y/B8i3OVp/Wm3hPDneoDyCzIZrFPDX8w5GsL5wpRC/EPAkVPTneH3/jCCxnlVnr2ikuZvh2+mfw047OpZPNld2H0Cav3iqyQ8U3vhnDiP9I/elrLYHgE8LlG4g6wGmAHVqQoEbqevPl3cqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220975; c=relaxed/simple;
	bh=pb4dJYrX+EYdLrFBrcuHPdxLJ2u1So+g002Ovutj+K8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BtBvZsGaDORABST1IwnQ98T9zVDZGOrJJ6TdQJAnFuBGagQAHLIIDJioDpRX2aNof3B3NfLN1fuvKOIOsfxDoGR1A7VIa9HMiYxgFT9PJbrKvjE0CAlcLhcD1JkY/a59KKfJofMmswxcBVfEA+4F5frmf3u5m1z/sDEMDpWBAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IoL1TrH4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8Yw8S023765;
	Mon, 24 Jun 2024 09:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SveVDdHXQrYh36L1Fs+xWc
	IgpyTuBhMg+dmlDbSz+eI=; b=IoL1TrH4CtR6kU9DDlHfqQ6Qeh6BIvOWmYxiej
	0MnrZkyQVXKoZvsPIke2RVrhBkqMG7WOIP4KRveinNwRDpkvSCgM1TCLb4jFLACI
	jslie8LwtBMx/rfs1i/yCbV/LVdRabVogH6krjewnnd8IHBqZyOUrWj6RpLx0/ue
	DZUMlLhqcWGsMawVyDZ9aDnFFO+OelJtpcd0gmLUfuLPqhFqgsiqeLnBjnRn7EqM
	grJSdsqMLRmzAP+kgLOoUfg8GOFMXqB2QA1I9w6zk/gkczvYVC7fFmNl/g0/ysyC
	0clU719LHCo/paakzjYA0ZARHx1azDrCrio5FkmIl3+6Pf2A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqshk55j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:22:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O9Mmpm028042
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:22:48 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Jun 2024 02:22:43 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <conor+dt@kernel.org>,
        <abel.vesa@linaro.org>
Subject: [PATCH V3 0/4] arm64: dts: qcom: x1e80100: Enable bwmon support
Date: Mon, 24 Jun 2024 14:52:10 +0530
Message-ID: <20240624092214.146935-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zkuZ6O4SJTWci8y5kBBIBFt6ZaMRZ76Z
X-Proofpoint-GUID: zkuZ6O4SJTWci8y5kBBIBFt6ZaMRZ76Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=972 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406240075

This patch series enables bwmon support on X1E80100 SoCs.

V3:
* Pickup Rb's and Tb's from the list.
* Drop OPP table from the required property list. [Konrad/Krzysztof]
* Update commit message describing the race condition. [Bjorn]
* Update comment in the bwmon driver. [Dmitry]
* Add a comment describing which cluster each bwmon instance belongs to. [Konrad]

V2:
* Allow for opp-tables to be optional on X1E cpu-bwmon instances. [Konrad]
* Drop Rb from Krzysztof due to more bindings changes.
* Use explicit request/free irq and add comments regarding the race
  introduced when adding the IRQF_SHARED flag. [Krzysztof/Dmitry]
* Use consistent numbering of the opps across instances. [Shiv]
* Use ICC_TAG_ACTIVE_ONLY instead of magic numbers. [Konrad]
* Drop fastrpc enablement patch. [Bjorn]

tag: next-20240621
base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7

Sibi Sankar (4):
  dt-bindings: interconnect: qcom,msm8998-bwmon: Remove opp-table from
    the required list
  dt-bindings: interconnect: qcom,msm8998-bwmon: Add X1E80100 BWMON
    instances
  soc: qcom: icc-bwmon: Allow for interrupts to be shared across
    instances
  arm64: dts: qcom: x1e80100: Add BWMONs

 .../interconnect/qcom,msm8998-bwmon.yaml      |   3 +-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 123 ++++++++++++++++++
 drivers/soc/qcom/icc-bwmon.c                  |  12 +-
 3 files changed, 134 insertions(+), 4 deletions(-)

-- 
2.34.1


