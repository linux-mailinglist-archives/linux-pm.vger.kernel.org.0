Return-Path: <linux-pm+bounces-17279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C25D9C31FD
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 13:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DF01C209DD
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 12:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00464156968;
	Sun, 10 Nov 2024 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jsnyut2u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5514E2E6;
	Sun, 10 Nov 2024 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731242329; cv=none; b=BwsQa+snzCS24dMn6YuqMleya1ccjN6AOjELYde1GDCZ71vqhvHYo98uwZR2jH/X2SI/WuYnFTeJ3UXylyFuPP78eTc1eY/syDjynMO9I/vfhCVz04mjE92MDOwNE7w3fHVJSLggyJKKlKm6ZyqPop5rMz3mHAhiAhE1+7zgnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731242329; c=relaxed/simple;
	bh=t8XHwoH4uZ8mfv3sMKgGo1tdw9LkN68hMlMaEG1J+n0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZL4/n30C78tfWvvSc5FGUUrHmVRJBDk/8DL7PvPsE45FuT96SoO6Piad//Ma1kpmoBefFTIIIxyO5PugqF/9yCwWtJLmm+899H4ZssvjEWaYkO8vpa5QfdlMTXl6SroOX9dP378b2riO81+0JuxtgDRvEn1ySprkGPyUEkA/LVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jsnyut2u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAAUBcm008532;
	Sun, 10 Nov 2024 12:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uujoZOzg0qNR/EnIEOfGf4
	2REXmWTxhXgkhNpQj2Xbw=; b=Jsnyut2uL2Umc5czlOY0X+g7wsGjlVWd3MRN1s
	Fv+UNml9etO3DWXdBYMu5wr/trbpQwIAxv9JVU5w06GZ0b2neknjxZQ+5fC5aJ+2
	8gNsGQiFibi8nwsUsZX+0lExs5kR+ghLnaqbExkUgeeE6p06M0i1OfOZ3rBdvvM9
	EUROEplID+sTRDKuYdcudGjRT/oI8czAh6kdqT4ZVe86wxfwATz9vumZpr8GJlSU
	JNChtLEwIfw7PQ6ywvApNQMfeRcmdpOkZvuvHgQe5r7pcKx+51kx0PVe6JyRpHR1
	BtEy32+MHnpaktqMDm3qqInp+ukW0clBKCPqQxV4w2Hpk6/w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42syy22299-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 12:38:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AACchLp016390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 12:38:44 GMT
Received: from 7b2794c915f4.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 10 Nov 2024 04:38:40 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 0/3] Add EPSS L3 provider support on SA8775P SoC
Date: Sun, 10 Nov 2024 12:38:22 +0000
Message-ID: <20241110123825.28783-1-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
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
X-Proofpoint-GUID: P7t5nwLJVM2V_13b6zn_F5aCxBOIxi1a
X-Proofpoint-ORIG-GUID: P7t5nwLJVM2V_13b6zn_F5aCxBOIxi1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411100112

Add Epoch Subsystem (EPSS) L3 provider support on SA8775P SoCs.

Changes since v2:
 - Updated the commit text to reflect the reason for code change.
 - Added SoC-specific and generic compatible to driver match table.

Changes since v1:
 - Removed the usage of static IDs and implemented dynamic ID assignment
   for icc nodes using IDA.
 - Removed separate compatibles for cl0 and cl1. Both cl0 and cl1
   devices use the same compatible.
 - Added new generic compatible for epss-l3-perf.

Raviteja Laggyshetty (3):
  dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
  arm64: dts: qcom: sa8775p: add EPSS l3 interconnect provider
  interconnect: qcom: Add EPSS L3 support on SA8775P

 .../bindings/interconnect/qcom,osm-l3.yaml    |  4 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 19 ++++
 drivers/interconnect/qcom/osm-l3.c            | 87 ++++++++++++++-----
 3 files changed, 88 insertions(+), 22 deletions(-)

-- 
2.39.2


