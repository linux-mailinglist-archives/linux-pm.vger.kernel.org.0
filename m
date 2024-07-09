Return-Path: <linux-pm+bounces-10809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA6692B059
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 08:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2881C216E5
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 06:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1060513B7AF;
	Tue,  9 Jul 2024 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XX6Ujx2g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5AA620;
	Tue,  9 Jul 2024 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720507219; cv=none; b=U0xTaNt2FaSPcdlKJWDjeGbT9nUIBGWHdjgmn73aTxVW7eAd4cOjUProI0P+ZSUSV9Hm+/PNrymlroqHv/ZBO0zHJKldO54ZUzydzNeL9Cc8A3HejEmYdx5fnV934zcxLIpEVyjwRgeydrHWBzB+gZMIg3VRNWqGNKMV41peUiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720507219; c=relaxed/simple;
	bh=m1+rZcWSHp9hTFpxjmpe4US5OdMzx1+M7STqT2rdjuw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q43L/L0fBYtVcmQq0ZFtS71nXVoa+BiuIcZddHgS1BTt7Y1ncXt7PwqGSJyrUKF0mNlyxJyaCyU0faA46cIeznbytfHtbt6KrwtxA0iM+UNeIkddvqessq3XPjdLkd+aQOPm0yujdi+wJrag8KDtol0EIDK2oUITFxsZ5jtcfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XX6Ujx2g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4690BgpD030239;
	Tue, 9 Jul 2024 06:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kr+MUxbsqRoKLfSL2uykTT
	Mh0PAGRr+eN9/6okrSIfw=; b=XX6Ujx2gWkBcpGRZRuQ79zJnAovObqCz/gVaZj
	C4bTVz4ladTMZa940xzBiJ0BsTVmKCIlz2k0s6Ufp9aZ0wzRLDkXJWxv4or8A0Qs
	zxCCeM/53CfKJXcmQTvKbqx847riHd7Ri5F7Qizf29oNvd5ZP3PXxXUyIwGZwaLE
	gy3TA0CsYp5VWjKkmvzbHiXrbY7L294cYVXl1/ISUP8QtWhzcWVgEUHld6SSSE2N
	Motpc/Cw8zUO1qYWSkZb2swqDf0CU3JxVEzmQodcYGFaRnABlrO6qMrr+BjCMBsw
	zqbsBA6DPNzk2AL58vYGlddDO8CBCZqHslIjAuVI9kyhqrlQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x515pes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 06:40:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4696e7GF022643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 06:40:07 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 8 Jul 2024 23:40:02 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v1 0/3] Add interconnect driver for IPQ5332 SoC
Date: Tue, 9 Jul 2024 12:09:45 +0530
Message-ID: <20240709063949.4127310-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: ZLONHtspI8lxyEV3GCxp6oGO4vqd_m1w
X-Proofpoint-ORIG-GUID: ZLONHtspI8lxyEV3GCxp6oGO4vqd_m1w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=683 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090043

Enable icc-clk based interconnect driver for IPQ5332. This is
similar to IPQ9574's icc-clk based driver.

dt_bindings_check and dtbs_check passed.

Ensured that icc_sync_state is called and relevant clocks are
disabled.

Dependency:
[1] https://lore.kernel.org/linux-arm-msm/20240430064214.2030013-1-quic_varada@quicinc.com/

Varadarajan Narayanan (3):
  dt-bindings: interconnect: Add Qualcomm IPQ5332 support
  clk: qcom: ipq5332: Use icc-clk for enabling NoC related clocks
  arm64: dts: qcom: ipq5332: Add icc provider ability to gcc

 .../bindings/clock/qcom,ipq5332-gcc.yaml      |  2 +
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  2 +
 drivers/clk/qcom/gcc-ipq5332.c                | 36 +++++++++++++--
 .../dt-bindings/interconnect/qcom,ipq5332.h   | 46 +++++++++++++++++++
 4 files changed, 81 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq5332.h

-- 
2.34.1


