Return-Path: <linux-pm+bounces-12403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B212C9563AB
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 08:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534061F21A55
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 06:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6F615624B;
	Mon, 19 Aug 2024 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eUIF6DeE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78511553A2;
	Mon, 19 Aug 2024 06:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724048630; cv=none; b=u01Iwsk8zsnzMhxrHABbbESWZNqxHVqxCTTJ0ZD/6J+Gu2MTWYYuHfCyoL2njjTQ6g6z/v3VuojCEHP7+BLo1GUlXe1MRAl8Q9sYHeNkbssSwRmC55/NUqdst7hpOFsl85ajmLHUpKSMvOnzOgusfvePHl0yHKtmTXMvbSaaz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724048630; c=relaxed/simple;
	bh=rvszpW+Sf5LW32ZXFqlqOpVbGHXRtpVKxyeLAx0kWtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VA7U0bKo1I/3mynfHtO5XugCG94h2sSwSOL1H+KaCOtko9IYf8VqcizIgbUeKcl5oYaC4FyqtP+J5EJqBol9Bc6oMhZZ26RRwkrZIi1W87sS/+cANDQ7Z3U8c9sc+qt1yUbsfF+xETjDuqHjTdPQEMb30832Y+piR44LT9IdmmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eUIF6DeE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47IN9HnU007309;
	Mon, 19 Aug 2024 06:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=1l9b++YdC0mEemD2uLoiP+yLdVmlqYlZRA2cLYFT56I=; b=eU
	IF6DeELyRFUjXlsw0epypndnr+jicoOXHC4d66FEgpMAKp/m23CRanPWSJwOtuob
	i7C3NkiQbOSzMfghCd51gtGHSr0F9RA1TdO+APP3+CQMcfyL0f4wABAcnZiczBPn
	xaETFr2LojZFHGRvs5m4KuGt8/+uQydbIwPk5teUBKQDGYcaru7oKFgIysXOlzHg
	lzjwN5pDKAzDshgsmRrLUkLDh6NMlquwC9Tc+Moro/u5dpzM576z9EJuoK+R95v3
	BJIRGDN0vk/hDIuq3zs+5KcHASKNnz1lTMYqjrOF7iDI8FzhNPPTlAYnVNPKr3/N
	ut9EHXFfFLNYGfZ2HavQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412kxuk6mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 06:23:40 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47J6NGII009395;
	Mon, 19 Aug 2024 06:23:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 412mxkapta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 19 Aug 2024 06:23:36 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47J6LPVY007986;
	Mon, 19 Aug 2024 06:23:36 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 47J6NZ56009845;
	Mon, 19 Aug 2024 06:23:36 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 3D9CA359D; Mon, 19 Aug 2024 11:53:35 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v3 1/2] PM: domains: add device managed version of dev_pm_domain_attach|detach_list()
Date: Mon, 19 Aug 2024 11:52:45 +0530
Message-Id: <1724048566-5035-2-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1724048566-5035-1-git-send-email-quic_dikshita@quicinc.com>
References: <1724048566-5035-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qs6gYakMIYeY2gEyvbJOzLg6hcuNJZOp
X-Proofpoint-ORIG-GUID: Qs6gYakMIYeY2gEyvbJOzLg6hcuNJZOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_02,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190045
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Add the devres-enabled version of dev_pm_domain_attach|detach_list.
If client drivers use devm_pm_domain_attach_list() to attach the PM domains,
devm_pm_domain_detach_list() will be invoked implicitly during remove phase.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/base/power/common.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 11 +++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 327d168..c8431de 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -277,6 +277,51 @@ int dev_pm_domain_attach_list(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach_list);
 
 /**
+ * devm_pm_domain_detach_list - devres-enabled version of dev_pm_domain_detach_list.
+ * @_list: The list of PM domains to detach.
+ *
+ * This function reverse the actions from devm_pm_domain_attach_list().
+ * it will be invoked during the remove phase from drivers implicitly if driver
+ * uses devm_pm_domain_attach_list() to attach the PM domains.
+ */
+static void devm_pm_domain_detach_list(void *_list)
+{
+	struct dev_pm_domain_list *list = _list;
+
+	dev_pm_domain_detach_list(list);
+}
+
+/**
+ * devm_pm_domain_attach_list - devres-enabled version of dev_pm_domain_attach_list
+ * @dev: The device used to lookup the PM domains for.
+ * @data: The data used for attaching to the PM domains.
+ * @list: An out-parameter with an allocated list of attached PM domains.
+ *
+ * NOTE: this will also handle calling devm_pm_domain_detach_list() for
+ * you during remove phase.
+ *
+ * Returns the number of attached PM domains or a negative error code in case of
+ * a failure.
+ */
+int devm_pm_domain_attach_list(struct device *dev,
+			       const struct dev_pm_domain_attach_data *data,
+			       struct dev_pm_domain_list **list)
+{
+	int ret, num_pds;
+
+	num_pds = dev_pm_domain_attach_list(dev, data, list);
+	if (!num_pds)
+		return 0;
+
+	ret = devm_add_action_or_reset(dev, devm_pm_domain_detach_list, *list);
+	if (ret)
+		return ret;
+
+	return num_pds;
+}
+EXPORT_SYMBOL_GPL(devm_pm_domain_attach_list);
+
+/**
  * dev_pm_domain_detach - Detach a device from its PM domain.
  * @dev: Device to detach.
  * @power_off: Used to indicate whether we should power off the device.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 772d328..b01e127 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -450,6 +450,9 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
 int dev_pm_domain_attach_list(struct device *dev,
 			      const struct dev_pm_domain_attach_data *data,
 			      struct dev_pm_domain_list **list);
+int devm_pm_domain_attach_list(struct device *dev,
+			       const struct dev_pm_domain_attach_data *data,
+			       struct dev_pm_domain_list **list);
 void dev_pm_domain_detach(struct device *dev, bool power_off);
 void dev_pm_domain_detach_list(struct dev_pm_domain_list *list);
 int dev_pm_domain_start(struct device *dev);
@@ -476,6 +479,14 @@ static inline int dev_pm_domain_attach_list(struct device *dev,
 {
 	return 0;
 }
+
+static inline int devm_pm_domain_attach_list(struct device *dev,
+					     const struct dev_pm_domain_attach_data *data,
+					     struct dev_pm_domain_list **list)
+{
+	return 0;
+}
+
 static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
 static inline void dev_pm_domain_detach_list(struct dev_pm_domain_list *list) {}
 static inline int dev_pm_domain_start(struct device *dev)
-- 
2.7.4


