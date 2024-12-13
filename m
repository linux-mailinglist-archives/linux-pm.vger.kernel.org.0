Return-Path: <linux-pm+bounces-19184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41BA9F0A3D
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 11:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A9F188CCDA
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 10:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990D41C3BF7;
	Fri, 13 Dec 2024 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MZZz5WS5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F9D1C3BFA;
	Fri, 13 Dec 2024 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087511; cv=none; b=tqukZI9t2lkXtW6w6WUZYL4l2hyK4jaTY1n9RIRM/RoK43Y7GGMs246ZWe/v7UWZm7TDgdPXb58c/2YZvepLmlBt2sa89tCUqHigW2W+L82gu4NVtoFu/S7xlWM1MtLFdw6SThNqglHZCevyBmz/yMvLpwCjO6bGZloBR+fpvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087511; c=relaxed/simple;
	bh=HWh7XQAfjpleYvEbQWBToxRpz6B4DGMiGKyWAHMvkEk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OIw7fvKqDmeeDYtn1PZSyJBxbU33aHVskac+SoC4/LmirGz9xFU8H57sZphwbGjxu5CNLs8WOeijHYUqMcKjLXe+kuP9c6RAgsa8qSbroZECtuRCrv1u5AvJ91uM9228YNf4xk3zEEPDQbCbS2HKlr5CGkPagU8rJdqqAhfLJHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MZZz5WS5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDAgW8n028137;
	Fri, 13 Dec 2024 10:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EL2zgQNi2brQ93p+642ETV
	oKYDg+LvyikR/EipbfhE0=; b=MZZz5WS5a0VFq3prGTxE7L61sJlK1m2kncINHX
	JxCnf6MTQartfEJ2KsiSQpUYTr0e6nGQmc7IjKz6Ds8J5ou/UtP3rgZ8+q+f9Kod
	j54WUDhmSw1X65F8CiZ51isqPWpq9ZDNOGUA2PhZSCmbpTZdR+dvQ7Z2Ly4Q0DMD
	zDW8pXCRjSB6DnIpRzEPxP1hwGGOw6iTXDQArmIQDVeAhlGgeStUAD9lJwYiRrPh
	yM7MMRVgCsvHeNflehllEdd1RG3DtnUWUyq146wtOV8BG2sDUNkpt9GM3t6IhWuh
	OzuD2ls1xFoLdu1F3yNkmE0sNJ1eBHlKLYMKsqmY5y2w4Qzg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fxw4ucfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 10:58:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDAwPIj010024
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 10:58:25 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Dec 2024 02:58:21 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <djakov@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v1 1/2] dt-bindings: interconnect: Add Qualcomm IPQ5424 support
Date: Fri, 13 Dec 2024 16:28:07 +0530
Message-ID: <20241213105808.674620-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -q-sjxQTV_aq8yZyJU_ImvVNcJLx_kpD
X-Proofpoint-GUID: -q-sjxQTV_aq8yZyJU_ImvVNcJLx_kpD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130075

Add master/slave ids for Qualcomm IPQ5424 Network-On-Chip
interfaces. This will be used by the gcc-ipq5424 driver
for providing interconnect services using the icc-clk framework.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 .../dt-bindings/interconnect/qcom,ipq5424.h   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq5424.h

diff --git a/include/dt-bindings/interconnect/qcom,ipq5424.h b/include/dt-bindings/interconnect/qcom,ipq5424.h
new file mode 100644
index 000000000000..a770356112ee
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,ipq5424.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef INTERCONNECT_QCOM_IPQ5424_H
+#define INTERCONNECT_QCOM_IPQ5424_H
+
+#define MASTER_ANOC_PCIE0		0
+#define SLAVE_ANOC_PCIE0		1
+#define MASTER_CNOC_PCIE0		2
+#define SLAVE_CNOC_PCIE0		3
+#define MASTER_ANOC_PCIE1		4
+#define SLAVE_ANOC_PCIE1		5
+#define MASTER_CNOC_PCIE1		6
+#define SLAVE_CNOC_PCIE1		7
+#define MASTER_ANOC_PCIE2		8
+#define SLAVE_ANOC_PCIE2		9
+#define MASTER_CNOC_PCIE2		10
+#define SLAVE_CNOC_PCIE2		11
+#define MASTER_ANOC_PCIE3		12
+#define SLAVE_ANOC_PCIE3		13
+#define MASTER_CNOC_PCIE3		14
+#define SLAVE_CNOC_PCIE3		15
+#define MASTER_CNOC_USB			16
+#define SLAVE_CNOC_USB			17
+
+#endif /* INTERCONNECT_QCOM_IPQ5424_H */

base-commit: 3e42dc9229c5950e84b1ed705f94ed75ed208228
-- 
2.34.1


