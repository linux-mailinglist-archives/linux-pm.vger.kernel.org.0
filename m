Return-Path: <linux-pm+bounces-8546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37B08FA698
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 01:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2362873D9
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 23:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC26013D27C;
	Mon,  3 Jun 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MrbGUOIA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E513D25F;
	Mon,  3 Jun 2024 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717458185; cv=none; b=REhVzomy+BdBWEyO2TTXIWWzbaKIhvy+4xBngvDRKMfaR8QWxZ91O29YbHzuldLiaKN2o1DD2kddgX3Bi2ghNDQdO1upr5AqzJffPXFdj1NrGwyT6npC4DJv+OLayQ0jq+b2NkeM20hO0Je5OinJD8zp1IzUu0gtAFWILlXw9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717458185; c=relaxed/simple;
	bh=53fQuKYZZtXT7cR92uUaUEjQHBqiDVfL8vWkByJoNzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Odvvrl9a60GUabpZ8/yo0G3EKT6JPJAPAYghO0nZzjk//xgPl1lAEZwCf/swMbmaTvSh/vqsron1sqKP1CrOIavj1O2Pl+N7VAES166tE4LwHDEEvlbsPof90/5UXruiy0/b7h4XJTFlbhp3DU9WioyYF/df+6Oga1/I/QuUVWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MrbGUOIA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453L4V1k031125;
	Mon, 3 Jun 2024 23:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=71tCYSv6wOqxXZ/r6UR9yB
	38tyMXZmPGp5fIJM2z7ko=; b=MrbGUOIAKxfO+Or3eL29yvKJmbu3HjprBTM+pL
	EK+G+1bspcGg1D8/+ILVfJts6VZM18xB2PoepCixPq4Ts0mqeJIHYFfXFeTz2guo
	oMMbNilFQfFBD0MM15s1pYbOc3URwU5K14Hf9mQL/FW6d5JlBZPIMD2H1Noqgbsb
	lOc2A1LscafafhNV3q1hr7nBsQYFzed9BvuxtL9li9UT3TaWSRZEc0AX/1YQWY06
	HaXnHx6bODcayKHENfPA6mJu3/qru6wfMlpFuQDQbe23R7T0yNpm38OPZjo0la/b
	OnMj+Vy95p3AxFgiBHBhcRhi0B6d9uP5Xq3z55L4q0mECvcQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6v5dwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 23:42:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453NgnEp024045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 23:42:49 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 16:42:49 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 3 Jun 2024 16:42:48 -0700
Subject: [PATCH] interconnect: imx: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-md-interconnect-imx-v1-1-348a9205506c@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPhUXmYC/x3MwQrCMAyA4VcZORuoaxH0VcRDm2ZbwGbSTimMv
 bvR43f4/x0aV+EGt2GHyh9psqrhfBqAlqgzo2QzjG4M7uI8loyiG1daVZk2lNIxeCZKPlx9ymD
 lq/Ik/X+9P8wpNsZUo9Lyez1F3x1LbLaB4/gCepcqqIQAAAA=
To: Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team
	<kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
CC: <linux-pm@vger.kernel.org>, <imx@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gaTp2YX5HM4QLrN-CWxhi2IhdJr0qC6K
X-Proofpoint-ORIG-GUID: gaTp2YX5HM4QLrN-CWxhi2IhdJr0qC6K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406030192

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mm-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mq-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mn-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mp-interconnect.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/interconnect/imx/imx.c    | 1 +
 drivers/interconnect/imx/imx8mm.c | 1 +
 drivers/interconnect/imx/imx8mn.c | 1 +
 drivers/interconnect/imx/imx8mp.c | 1 +
 drivers/interconnect/imx/imx8mq.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 979ed610f704..9511f80cf041 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -334,4 +334,5 @@ void imx_icc_unregister(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(imx_icc_unregister);
 
+MODULE_DESCRIPTION("Interconnect framework driver for i.MX SoC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/imx/imx8mm.c b/drivers/interconnect/imx/imx8mm.c
index 8c40f4182263..a36aaaf106ae 100644
--- a/drivers/interconnect/imx/imx8mm.c
+++ b/drivers/interconnect/imx/imx8mm.c
@@ -96,5 +96,6 @@ static struct platform_driver imx8mm_icc_driver = {
 
 module_platform_driver(imx8mm_icc_driver);
 MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
+MODULE_DESCRIPTION("Interconnect framework driver for i.MX8MM SoC");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:imx8mm-interconnect");
diff --git a/drivers/interconnect/imx/imx8mn.c b/drivers/interconnect/imx/imx8mn.c
index fa3d4f97dfa4..2a97c74e875b 100644
--- a/drivers/interconnect/imx/imx8mn.c
+++ b/drivers/interconnect/imx/imx8mn.c
@@ -86,4 +86,5 @@ static struct platform_driver imx8mn_icc_driver = {
 module_platform_driver(imx8mn_icc_driver);
 MODULE_ALIAS("platform:imx8mn-interconnect");
 MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
+MODULE_DESCRIPTION("Interconnect framework driver for i.MX8MN SoC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/imx/imx8mp.c b/drivers/interconnect/imx/imx8mp.c
index d218bb47757a..86d4c1517b26 100644
--- a/drivers/interconnect/imx/imx8mp.c
+++ b/drivers/interconnect/imx/imx8mp.c
@@ -249,5 +249,6 @@ static struct platform_driver imx8mp_icc_driver = {
 
 module_platform_driver(imx8mp_icc_driver);
 MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("Interconnect framework driver for i.MX8MP SoC");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:imx8mp-interconnect");
diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
index 8bbd672b346e..f817d24aeefb 100644
--- a/drivers/interconnect/imx/imx8mq.c
+++ b/drivers/interconnect/imx/imx8mq.c
@@ -97,4 +97,5 @@ static struct platform_driver imx8mq_icc_driver = {
 module_platform_driver(imx8mq_icc_driver);
 MODULE_ALIAS("platform:imx8mq-interconnect");
 MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
+MODULE_DESCRIPTION("Interconnect framework driver for i.MX8MQ SoC");
 MODULE_LICENSE("GPL v2");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240603-md-interconnect-imx-43eccb3493bd


