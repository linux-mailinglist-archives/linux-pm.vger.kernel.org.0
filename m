Return-Path: <linux-pm+bounces-26531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F45AA6907
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 05:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D5D3B102B
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 03:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B7619E992;
	Fri,  2 May 2025 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dBXkq7w/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8B11714B4;
	Fri,  2 May 2025 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746155461; cv=none; b=WUQFeG/Op+9TPcbkd3MJqaf1RYyEaa8orQMY78gpOsysA3HuqkUc8IBRXLRee5ilAfuaqon+DK4F6r7V/2F3/aU91miSfhc4Z8zwSiBZsGL1inVvCLljuCCqtxd77Dv4zPPWzWUDOnz+Ugg3jpJkg2tYbHLMG3PiZiDS6WMe12E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746155461; c=relaxed/simple;
	bh=C6f9plqmx2xZPcMDoY3i7qsadrCwTMrmIBg9jC2gX+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJHnp3iDGaSSgwOtCOYlizVry6KMpR+k2U5p9ULyeAyaTnLRVDOHQ/wEIMWGoV9Y6rKS42sfiG2CGHtnX1DeImoW7LQTXPtrvlJe1QN5WIlPzsV9TCBqYlkHHaqCXIhw60caKffU1S6COixzBNv2jRhUlTVFrq3lu6fB91F23a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dBXkq7w/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421NF96015244;
	Fri, 2 May 2025 03:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LYZoaruD1XMQ3uhxY0EqjunB
	Af8GXpasYSgKTtNzQJo=; b=dBXkq7w/Eg9A3yRYOcP/PBvBMG6ZSzSczMNxS3C9
	Iqf2Z7XjYtf44xSJG9Zdk24xpZLcqL2w7QvrGN3r/uAWObbs18wqRej3Rl/tVAdj
	ayJ9mMMMabpHCPG3/qCQu2llxqEb9KIvmw4tP1F9eiSHCn/MFeLAG5ldaEm1lF40
	HGTRiPKzVW5MtiT95kFhK99EA3AT5jzzbGUfKARrP3SFzzmueZKh8VabMpAUB4c5
	BIIyiotGdRoLNAotKjl8XeArwAabJHFhY4/XF/3oiTX+7qU3Ply0u0z0Rlu2/xxF
	TijcIQDDKnTbH/v/SFAfa2hdgAEIdoGEgxCZ5W1BQ0DxtQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6uay123-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 03:10:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5423AqeX011656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 03:10:52 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 1 May 2025 20:10:45 -0700
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
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>
Subject: [PATCH v3 1/9] opp: add new helper API dev_pm_opp_set_level()
Date: Fri, 2 May 2025 08:40:10 +0530
Message-ID: <20250502031018.1292-2-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250502031018.1292-1-quic_ptalari@quicinc.com>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
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
X-Proofpoint-GUID: S187y4mWfQrfqtE9FPRzZKeizgHACilE
X-Authority-Analysis: v=2.4 cv=KtlN2XWN c=1 sm=1 tr=0 ts=681437bd cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=RqhrKAo0oSNuShJv3MAA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: S187y4mWfQrfqtE9FPRzZKeizgHACilE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAyMSBTYWx0ZWRfX+DL/0TtGi6Vt jbI47N5UVA4rneUF2CNBf9x+V6n5pd+ULtwIInXxiAwF7RVkUhOznH0TtD3c5L1BJ1DQTqReQNj +PMW03HGcNc/QAVP1vt0xGWpJWCM3hsTv5fCyLXDzBLLUMCjmi1NCg5IMMsnHhSDy5AqWfLauA9
 84UqrrisdAy+R0vAnm9k1gyvPimnMLialf8qfAxljZXhEqgX6dsc+qRLrUUK6u1TILaPJZlqIbt Fe7bbjropnjCo3CKm/qPni1GhMYV8ZwPnxcOeiQqGH4ebxlVqJh1iePUiudwD2yu0R9c6u81nbc CVR293iVnMrzbGv440c1KunaKpYWd3vRGL+LH1ifNUJ2O2xLDaEcQD8fcA2AchdSHd+9UV9EVMV
 0AhiRGCz6C67/5yUu7gtKi53yNtXvmqnbLOjokDp9gXIRrv3o3fVrPdwtbTq3VKPOUQows5E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020021

To configure a device to a specific performance level, consumer drivers
currently need to determine the OPP based on the exact level and then
set it, resulting in code duplication across drivers.

The new helper API, dev_pm_opp_set_level(), addresses this issue by
providing a streamlined method for consumer drivers to find and set the
OPP based on the desired performance level, thereby eliminating
redundancy.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>

v2 -> v3
- moved function defination to pm_opp.h from core.c with inline
- updated return value with IS_ERR(opp)

v1 -> v2
- reorder sequence of tags in commit text
---
 include/linux/pm_opp.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index e7b5c602c92f..31ed8a7b554e 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -197,6 +197,28 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 void dev_pm_opp_remove_table(struct device *dev);
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_sync_regulators(struct device *dev);
+
+/*
+ * dev_pm_opp_set_level() - Configure device for a level
+ * @dev: device for which we do this operation
+ * @level: level to set to
+ *
+ * Return: 0 on success, a non-zero value if there is an error otherwise.
+ */
+static inline int dev_pm_opp_set_level(struct device *dev, unsigned int level)
+{
+	struct dev_pm_opp *opp = dev_pm_opp_find_level_exact(dev, level);
+	int ret;
+
+	if (IS_ERR(opp))
+		return IS_ERR(opp);
+
+	ret = dev_pm_opp_set_opp(dev, opp);
+	dev_pm_opp_put(opp);
+
+	return ret;
+}
+
 #else
 static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 {
@@ -461,6 +483,11 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
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


