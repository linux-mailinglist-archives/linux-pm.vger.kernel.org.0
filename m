Return-Path: <linux-pm+bounces-8662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED748FD59E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 20:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B8F1C23D27
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 18:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE9BF9CD;
	Wed,  5 Jun 2024 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cl6cyqJR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59879F0;
	Wed,  5 Jun 2024 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611507; cv=none; b=IkXkP7svfrhesnW6puCNVlvlfBA7bLPLbD1n0YaRlKrflks8wh3KhayNTkcSLVUpR7IX4QSIiB2kLOrvy/s/+/LiWFq0VG8VUX8MpE6GTWt8PYRjZGMHRSK4n01n/gOaieOTwpkpeSzXVsy4vz8NFjiihCA0evxQWpzr1whQRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611507; c=relaxed/simple;
	bh=8sTJIVQ52+X8F++jmSiEhrEDb4f6AaeHfQHDVk5yDVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=MTO9e2YquS380Bhg+j3aOZp5rsEedu+8EBPNmfp6X96hVeooWzz6OIM7XA8VlXTm+5Xb+XGVDduS07iHSJ+aQ6ApDz1XUBCARYHyn9NWAsCPFBkg+Ymp52gwdzeqFFyQKly7oJ8ZE1eHDNP/rqXDP191/jrNxq9JKef1JZe/Bh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cl6cyqJR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455B1Pqf024220;
	Wed, 5 Jun 2024 18:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EeAIyYy7hus9zRleyPaibC
	zwpRLBWIZ4rIY8qiJkg18=; b=Cl6cyqJRetsMZb2UWYwXUFIdiLOG7dVF9ZTlNY
	Tsrp1y6daBJ6KeVttPW8PoHojVojBLzIjvihDaYzNkc+ikrYb7vdhwlk0gWZnmm6
	IkXQKiMuOcXoJpJKDt1vkkUIj+EOZ3dF2L0MAh2r9Z8nk0RVOPTku/VtXRAJgI1m
	g86kR972KjKXRfrwV/X8gX6vgRJznwYI+nqyVazn/rluQHCiW/4vWkFxo6wN88E/
	zN0gqGZC3LVtRxgePR/oLgyUc2sAxCmkjil8u1RcaIpHU52FtIhw8XliKrK3POpK
	akkRwc2qNoc1LWs2hKGUFabX2pVNwCbQfBfjxrsEqCc9GuZg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjabgtkyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 18:18:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 455IIJFL006684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 18:18:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Jun 2024
 11:18:19 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 5 Jun 2024 11:18:18 -0700
Subject: [PATCH] PM/devfreq: governor: add missing MODULE_DESCRIPTION()
 macros
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240605-md-drivers-devfreq-v1-1-d01ae91b907e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOmrYGYC/x3MwQrCMAyA4VcZORtoSyfMVxEP6Zq5gKuazDIYe
 3erx+/w/zsYq7DBpdtBuYrJszT4UwfjTOXOKLkZggvRnV2PS8asUlkNM9dJ+Y0xJD+k0A+RPLT
 wpTzJ9p9eb82JjDEplXH+rR5SPhsuZCsrHMcXe1dECIMAAAA=
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park
	<kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KcYaJ_w0HbtbxK4_OpQHrGGMyWwV-842
X-Proofpoint-ORIG-GUID: KcYaJ_w0HbtbxK4_OpQHrGGMyWwV-842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 mlxlogscore=924 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406050138

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_simpleondemand.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_performance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_powersave.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_userspace.o

Add all missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/devfreq/governor_performance.c    | 1 +
 drivers/devfreq/governor_powersave.c      | 1 +
 drivers/devfreq/governor_simpleondemand.c | 1 +
 drivers/devfreq/governor_userspace.c      | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
index 5dbc1e56ec08..2e4e981446fa 100644
--- a/drivers/devfreq/governor_performance.c
+++ b/drivers/devfreq/governor_performance.c
@@ -58,4 +58,5 @@ static void __exit devfreq_performance_exit(void)
 	return;
 }
 module_exit(devfreq_performance_exit);
+MODULE_DESCRIPTION("DEVFREQ Performance governor");
 MODULE_LICENSE("GPL");
diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
index 4746af2435b0..f059e8814804 100644
--- a/drivers/devfreq/governor_powersave.c
+++ b/drivers/devfreq/governor_powersave.c
@@ -58,4 +58,5 @@ static void __exit devfreq_powersave_exit(void)
 	return;
 }
 module_exit(devfreq_powersave_exit);
+MODULE_DESCRIPTION("DEVFREQ Powersave governor");
 MODULE_LICENSE("GPL");
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index d57b82a2b570..c23435736367 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -140,4 +140,5 @@ static void __exit devfreq_simple_ondemand_exit(void)
 	return;
 }
 module_exit(devfreq_simple_ondemand_exit);
+MODULE_DESCRIPTION("DEVFREQ Simple On-demand governor");
 MODULE_LICENSE("GPL");
diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index d69672ccacc4..d1aa6806b683 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -153,4 +153,5 @@ static void __exit devfreq_userspace_exit(void)
 	return;
 }
 module_exit(devfreq_userspace_exit);
+MODULE_DESCRIPTION("DEVFREQ Userspace governor");
 MODULE_LICENSE("GPL");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240605-md-drivers-devfreq-42b19b2594a1


