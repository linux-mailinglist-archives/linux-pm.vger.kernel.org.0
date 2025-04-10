Return-Path: <linux-pm+bounces-25159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F77A84B4A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 19:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F193C188D65A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCDE28FFD5;
	Thu, 10 Apr 2025 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="agImKf+0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7688728FFCE;
	Thu, 10 Apr 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306851; cv=none; b=MSu66Y9yaiEhl0VVztkvBQfxgEJZgIpO5P6SQZqpPHidXnEfy2UNy36HZzKBNDhCisYxqxyetohfHYvQsd7jUrbRVRrNChztk6qxRUbIMBIBPSdepGNCMx0QW1fob4h2NI9aM6RxVDkXJbzwDZrSXgZgZBSBfDOiHihs1LvVNC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306851; c=relaxed/simple;
	bh=DEHTKCScotguMFizlx8oWVGqxgVxSpvJXdToV6556Ck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpwKr+++bCktyyuUkjaiUL3bHsM91gVAWP8ZT0451ikBpvpFIugDOcF1g2e2tzFWMqM7Ji9CQdZjf2gbyOg3P4k7sfaywWs4YoqehOPQ8FO3kuVS91ngjOkobH93apFyq4D4BH+hQkmn9WD2Mv2TVN8TqqVfOQdsmyESGsqOpdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=agImKf+0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AGIbRX013881;
	Thu, 10 Apr 2025 17:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yTkT7z6nnr9eYow8MppnAvZ2
	GcPR/sTEYPq/qtkH7RE=; b=agImKf+0NLX4lAfh54UYIQcVHe2VULku6E222wKU
	fws2FExDuo+wvAPZBRyG86GEiq063WhyK2Sr5k5ECCXnUBvXEYOM/OsgaFq9msK4
	e0kYJEyuOYdWl3OKdyo5fDdjHQceDZSuq7nANAKhW2fkQWQ7on+n6iYudeoph+5k
	BNQ/eB2ROsEprsqkUyYtW3Hp7TqFP2xXjZMLUcddZdmhTJlX0mOPkBTqY+ikBs5v
	a6FOM0UsJefpd52EoSOZHaJ4/srGwW1t6SshPBWW1P+NX83oZrMkaHrd9RYLs7Yc
	IJYWqOTxlYKd5cKfVxSuErNy0vx6V9U9B6Hf81DAid6O8A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbefwwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 17:40:45 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53AHeiYM010344
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 17:40:44 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Apr 2025 10:40:37 -0700
From: Praveen Talari <quic_ptalari@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd
	<sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Praveen Talari
	<quic_ptalari@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <psodagud@quicinc.com>, <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>,
        Nikunj Kela
	<quic_nkela@quicinc.com>
Subject: [PATCH v1 1/9] opp: add new helper API dev_pm_opp_set_level()
Date: Thu, 10 Apr 2025 23:10:02 +0530
Message-ID: <20250410174010.31588-2-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250410174010.31588-1-quic_ptalari@quicinc.com>
References: <20250410174010.31588-1-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J97y74t0Yo913xGJERyN2HHWKUm__JQP
X-Authority-Analysis: v=2.4 cv=T7OMT+KQ c=1 sm=1 tr=0 ts=67f8029d cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=m4zHK0A4y4sg-DzA2o0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: J97y74t0Yo913xGJERyN2HHWKUm__JQP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100127

From: Nikunj Kela <quic_nkela@quicinc.com>

To configure a device to a specific performance level, consumer drivers
currently need to determine the OPP based on the exact level and then
set it, resulting in code duplication across drivers.

The new helper API, dev_pm_opp_set_level(), addresses this issue by
providing a streamlined method for consumer drivers to find and set the
OPP based on the desired performance level, thereby eliminating
redundancy.

Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>
Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 drivers/opp/core.c     | 22 ++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 73e9a3b2f29b..a9bca9502f71 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -3151,3 +3151,25 @@ void dev_pm_opp_remove_table(struct device *dev)
 	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
+
+/*
+ * dev_pm_opp_set_level() - Configure device for a level
+ * @dev: device for which we do this operation
+ * @level: level to set to
+ *
+ * Return: 0 on success, a negative error number otherwise.
+ */
+int dev_pm_opp_set_level(struct device *dev, unsigned int level)
+{
+	struct dev_pm_opp *opp = dev_pm_opp_find_level_exact(dev, level);
+	int ret;
+
+	if (IS_ERR(opp))
+		return -EINVAL;
+
+	ret = dev_pm_opp_set_opp(dev, opp);
+	dev_pm_opp_put(opp);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_level);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index c247317aae38..c17271947f83 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -196,6 +196,7 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 void dev_pm_opp_remove_table(struct device *dev);
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_sync_regulators(struct device *dev);
+int dev_pm_opp_set_level(struct device *dev, unsigned int level);
 #else
 static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 {
@@ -454,6 +455,11 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
 	return -EOPNOTSUPP;
 }
 
+static inline int dev_pm_opp_set_level(struct device *dev, unsigned int level)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
-- 
2.17.1


