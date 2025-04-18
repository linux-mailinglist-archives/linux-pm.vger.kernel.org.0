Return-Path: <linux-pm+bounces-25713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EC4A93937
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 17:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDB71B6307D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F902207A11;
	Fri, 18 Apr 2025 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kyMXA24j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17EF205AAB;
	Fri, 18 Apr 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989198; cv=none; b=EDLdPt8DW7/2dcmF6OndXvdx7Ezf+nDtbcF9E2y9cnoGZaHinIe9++jZn3ZTtarI/cWkAKAEaCEJz+if9GkhGgiJs7f17HBQ/M8D5TznSXDosqwu/6KMNCPEVmZoy2wd5InfVqmYN/jJId2VR+8Y6GGddH5S8kkgrieRYfdZCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989198; c=relaxed/simple;
	bh=08GRw10jTlMOzcp+PwiGwaiFqNWmxUrwq5MCT49rxEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8Qnp6GEPzPN/XPmSgbxuubH/trH9Y+mvQ6k8WBsoPRYSNH53G0Nf+uRCeMF02tdHruUeSBWyHvh4i66b0xIvvpUMMeiIO/FGgzY+E0Rbur6ve01XmrL6r2+vMv3AZVpGO+rl4Ig6sc8tGzOXfZWVOXaQxhU5CxbsoeldQLr9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kyMXA24j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ICDFxs005848;
	Fri, 18 Apr 2025 15:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9YyddXPZQKx3KWsdMT5VQO6g
	G1OCa60iKGheaAzC9ao=; b=kyMXA24j28JSpK4+4vnAuvY8v5iOXROuW4ZArHfx
	/XwJOYECap2+w7P2m5KC9NvFGsw53f4i9/C0zjzylnFHezABiehT6LdeQl9VGFUa
	JOJdc/wNEPjvtnGfIXRBtbYuuZ3QdZhZZJaE7Cr+B1O/MOKv4XiUTwIH7QhL/dj+
	o83W2ztasKtOr4Q0dfitllFQbHIBNmzZKk79Kdub/jxmTnAUKUb1lVCgBVGJLEEg
	LNMqwTWJRZqJm4yVKKFon6NyOnlvGpd9Y2eAFXuCNxvT1qd8IY5bZimztc4VfvH9
	RZzkb3uM4cLhwSHlXsv3+5z4dVh+JVCIIwMpuwAL+xNJhQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydvjjhrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 15:13:07 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53IFD7Mh026181
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 15:13:07 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Apr 2025 08:13:00 -0700
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
Subject: [PATCH v2 1/9] opp: add new helper API dev_pm_opp_set_level()
Date: Fri, 18 Apr 2025 20:42:27 +0530
Message-ID: <20250418151235.27787-2-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250418151235.27787-1-quic_ptalari@quicinc.com>
References: <20250418151235.27787-1-quic_ptalari@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=ZIrXmW7b c=1 sm=1 tr=0 ts=68026c03 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=m4zHK0A4y4sg-DzA2o0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JlC8CTDmvmRY3xg6zRcHAWQZBpKv23C_
X-Proofpoint-ORIG-GUID: JlC8CTDmvmRY3xg6zRcHAWQZBpKv23C_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180112

From: Nikunj Kela <quic_nkela@quicinc.com>

To configure a device to a specific performance level, consumer drivers
currently need to determine the OPP based on the exact level and then
set it, resulting in code duplication across drivers.

The new helper API, dev_pm_opp_set_level(), addresses this issue by
providing a streamlined method for consumer drivers to find and set the
OPP based on the desired performance level, thereby eliminating
redundancy.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>
Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
---
v1 -> v2
- reorder sequence of tags in commit text
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


