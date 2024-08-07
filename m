Return-Path: <linux-pm+bounces-11960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 838CA94A17D
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 09:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA2AB28F89
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 07:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344261C7B7F;
	Wed,  7 Aug 2024 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i1nd4JYJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA61C68B3;
	Wed,  7 Aug 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014972; cv=none; b=XBIb/u2tCozOAS5dhnaHgapujvZceWqs71IgVpRYhXSutZmeFifrag9sAnfNh60WAxW8XtDmxQCudme9/31FW4X3xVTGaomG/IM7Qt1/1gFg9M6UASTS+oYU3JaDDCp5kfrIXj+Sy1EkSHMTO7faQ86lpC5TTiQ231FWaTZv32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014972; c=relaxed/simple;
	bh=15k3HmHmLPgI2yByAEIr7MQwywViEGIDH55Yz2zjd3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kwmx1h/0eZyXTq8sadgNqlC9EOpsfzdfFQQ7e8IS0Dumhz9cCnWDM8EavBtx30nqTpRNzPYjasksC7RXB8c/kdVYxyUYQb16jjG3zjnfsbXCyhL4F5q/sbTBLiyWwRu+o5bpN3mtgm6qJmYR6XxnyHjrWCWgEz35C8DBwGlAptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i1nd4JYJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476H6RaT021639;
	Wed, 7 Aug 2024 07:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=DSyXwd2naIXu3SgcRpn/8pKImxKVNxZ+nhM5LOxM2kk=; b=i1
	nd4JYJCyQza8ox1NiBNSZURKi1T+k8+8LYBJHBObGL/x00GPpteCTkhEOpuyCRDe
	MO339GjbUcnX5bi49FnI6BeSEAmal8E0CTpDS4dGKNyMdz8ZOJZQowjrLgTipAWS
	SPOWzGBHd5ZNpwJHUCRF/KaofonW6/8hoCYQVFfABB0PxxsmmNub0Zzz2pwvgZpS
	G4M8etxD9Q7UrYvm02GQqElv2NOrLzguDlkf3HQUirHbpGrYRSEToF5IQGJaC400
	McmWwiXv8oo/cyRqfFbqJ7P2I3nVwwFCFSlnmg4qpJGZGsR1HVYfV914ru1pvnub
	bSRMmHlgm1o9cnptgSZg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sbgs1t3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 07:16:02 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 4777CtgP025886;
	Wed, 7 Aug 2024 07:15:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 40sdmkv9a0-1;
	Wed, 07 Aug 2024 07:15:59 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4777FsC7030008;
	Wed, 7 Aug 2024 07:15:58 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4777FwPA030031;
	Wed, 07 Aug 2024 07:15:58 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 933A925A4; Wed,  7 Aug 2024 12:45:57 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
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
Subject: [PATCH v2 1/2] PM: domains: add device managed version of dev_pm_domain_attach|detach_list()
Date: Wed,  7 Aug 2024 12:45:46 +0530
Message-Id: <1723014947-15571-2-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1723014947-15571-1-git-send-email-quic_dikshita@quicinc.com>
References: <1723014947-15571-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SvqE7TwCh30k_S_U_aaI9ZKay4gGvAqv
X-Proofpoint-GUID: SvqE7TwCh30k_S_U_aaI9ZKay4gGvAqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_04,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070048
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Add the devres-enabled version of dev_pm_domain_attach|detach_list.
If client drivers use devm_pm_domain_attach_list() to attach the
PM domains, devm_pm_domain_detach_list() will be invoked implicitly
during remove phase.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/base/power/common.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 13 +++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 327d168..729d6c2 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -277,6 +277,50 @@ int dev_pm_domain_attach_list(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach_list);
 
 /**
+ * devm_pm_domain_detach_list - devres-enabled version of dev_pm_domain_detach_list.
+ * @_list: The list of PM domains to detach.
+ *
+ * This function reverse the actions from devm_pm_domain_attach_list().
+ * it will be invoked during the remove phase from drivers implicitly if driver
+ * uses devm_pm_domain_attach_list() to attach the PM domains.
+ */
+void devm_pm_domain_detach_list(void *_list)
+{
+	struct dev_pm_domain_list *list = _list;
+
+	dev_pm_domain_detach_list(list);
+}
+EXPORT_SYMBOL_GPL(devm_pm_domain_detach_list);
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
+	int ret, num_pds = 0;
+
+	num_pds = dev_pm_domain_attach_list(dev, data, list);
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
index 772d328..efd517017 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -450,8 +450,12 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
 int dev_pm_domain_attach_list(struct device *dev,
 			      const struct dev_pm_domain_attach_data *data,
 			      struct dev_pm_domain_list **list);
+int devm_pm_domain_attach_list(struct device *dev,
+			       const struct dev_pm_domain_attach_data *data,
+			       struct dev_pm_domain_list **list);
 void dev_pm_domain_detach(struct device *dev, bool power_off);
 void dev_pm_domain_detach_list(struct dev_pm_domain_list *list);
+void devm_pm_domain_detach_list(void *list);
 int dev_pm_domain_start(struct device *dev);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
 int dev_pm_domain_set_performance_state(struct device *dev, unsigned int state);
@@ -476,8 +480,17 @@ static inline int dev_pm_domain_attach_list(struct device *dev,
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
+static inline void devm_pm_domain_detach_list(void *list) {}
 static inline int dev_pm_domain_start(struct device *dev)
 {
 	return 0;
-- 
2.7.4


