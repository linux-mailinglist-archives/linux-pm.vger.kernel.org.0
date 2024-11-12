Return-Path: <linux-pm+bounces-17358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D699C4AA2
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 01:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAB92825FE
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 00:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CE91E048A;
	Tue, 12 Nov 2024 00:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OeWSpkgO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6F1CEEB3;
	Tue, 12 Nov 2024 00:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371118; cv=none; b=d25Xuz6gEJEqJeGRXHyF2TbPH4mKZirR7y/bpgVjuL8rEfw2F4adSa0wG1nKYEIdMiTCKxbTYjqOLyiB8vJ9ls4/SDG3FFfFiW+KQNfOiefz+h/tmOvDXLcVfXAHdx6FcMl1+ldlMcspSOMSMxaCLyl2gAxgPsdHbhkqMUf7h7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371118; c=relaxed/simple;
	bh=fEChIaYJ1wFgeIJbYys10gE6LVwn82w3pvhsVHltYaw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e8gA26PycfjImrEOdNEH26J3DaIhX56OLOMEDZRb1q7Uwd4YUwmIh/EQlWwo40eqkPNq101ENzzIXkZF/9DqepKADFd4qeNn/F5/4W8nci7w96nfCKa/PEH7jmn87+Kd4k3YYVXrDBZ4uJgEICNUp6DKjJfUgGLocV9q0xe2iZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OeWSpkgO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABCeLQR007990;
	Tue, 12 Nov 2024 00:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TFF3HdEtMPsgT1I3j7c3e+
	jovgSPjR4JUXJg28PnpUU=; b=OeWSpkgO8kX8ShIM9dFgQVqfiC2mcv8vmSSDch
	dBDbfQqDLX/m02vtt98rLrSO7y7bTUKB7u4RqRovHy8BA+XTZgbLX+8L4x+62QiP
	tQVNysetgjLoXgnwswxjkN65KTfOVroEqKiIc0r6hpmh5gtdj+oKH2hDRDACPCsJ
	XE/mytywF/AYh6oJip8SpG86lD/UsjyB+HloKHNk+3ZZU3w9tbD/2XLoA6fe/3uz
	3EXwa+4fPkVg5hkNA2DPmft+6ZdDh1IBjLNxS4e2RWpS2aBrDpvSpKD5AN7PFrut
	EYa/MC2BarMmbf7XBG5lnr6bDsqwni0alqIKoYBgMO6ZB+gw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t0wjwfk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 00:25:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AC0P9UG028141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 00:25:09 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 11 Nov 2024 16:25:08 -0800
From: Melody Olvera <quic_molvera@quicinc.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Tingguo Cheng
	<quic_tingguoc@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>, Luca Weiss
	<luca@lucaweiss.eu>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>
Subject: [PATCH v2 0/2] pmdomain: qcom: Introduce power domains for SM8750
Date: Mon, 11 Nov 2024 16:24:42 -0800
Message-ID: <20241112002444.2802092-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 72nK39HQSS6qAvYpUeJc6PpwgsNSxDL0
X-Proofpoint-ORIG-GUID: 72nK39HQSS6qAvYpUeJc6PpwgsNSxDL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=783 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411120001

Add power domains needed for the SM8750 SoC.

The Qualcomm Technologies, Inc. SM8750 SoC is the latest in the line of
consumer mobile device SoCs. See more at:
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/images/company/news-media/media-center/press-kits/snapdragon-summit-2024/day-1/documents/Snapdragon8EliteProductBrief.pdf

Changes in V2:
- squashed bindings into one patch

Jishnu Prakash (1):
  pmdomain: qcom: rpmhpd: Add rpmhpd support for SM8750

Taniya Das (1):
  dt-bindings: power: qcom,rpmpd: document the SM8750 RPMh Power Domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                | 26 +++++++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h        |  2 ++
 3 files changed, 29 insertions(+)


base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
-- 
2.46.1


