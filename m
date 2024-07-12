Return-Path: <linux-pm+bounces-11025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA5C92F52E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 07:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34CA1F22216
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 05:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D71D1BDDF;
	Fri, 12 Jul 2024 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LNNtCWma"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D36224FD;
	Fri, 12 Jul 2024 05:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763365; cv=none; b=Bi5ejQFGAw7Rh6GEUuZhXIAjJJ+Nu3gLcu4Hlxx2Aw2w3zQkt2M1xcZIjKsQzTrRPSvcH3kAdTsn5ALgNhDsaMKKMDaoEj5MzXdlO/YxzjmEpQx49+9CYLU4V9D0feJFPrDGv4VCi7c0GimeRMzOM2Rq8RwgbpE+it4n6l89dsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763365; c=relaxed/simple;
	bh=wP3SDvx8OfDrIGVvuNEUoyAcuewxx420nSKrf+kytOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WtIC31qE5C7qANHeS78jPgU5tf0VHXl/Gi0i7+AKuStZwTJIfN7vlZUUUsAqSbBL3cV1IgCIRYFuJBVr/GmXud6ln10mTSMP7zm439pGTWAhRQqTB/SO3w5NpvwIDGN4y52NBNIH7D0Ixx5lno8cW9z6zhWbgsxLYuoEzJTVN0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LNNtCWma; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BHKm6V032360;
	Fri, 12 Jul 2024 05:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=a9wiS4K7OGztqgFCkvlDKejP8Anlwdwfkaa47JEiWAA=; b=LN
	NtCWmaE9iVbj2gWNM/cXbFhwtSsO2URgQ599UTN75cpR7NNzTnlipt4ixrl7MNk+
	halEbeyL8wmYoob2LLzBsfxarBztgfNFkYSTlzBJoVFg/opSBpfM4pWz+KL0tXn3
	fFTHIVmtasfz15arwxOO0zBgKspmdMlavFTpd8rAQhtdVCMLXyJpCXauA8cfacdh
	pviJ+1gdccHEL1d65bSdM//tfGTSK8FPEIOQQmStXMQPaJ7ONnImw5O5fjNgmqaa
	tgEzNvDzeO9d8nWhXLr/WLF2IVur2nfO8PRfCSWb4n3r0J7itJk7mZ4p6cuhjuh2
	Pe10GMztIPVGk+cTvzsQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ac0gjh0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 05:49:13 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 46C5nApI020511;
	Fri, 12 Jul 2024 05:49:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 407g4fvaqa-1;
	Fri, 12 Jul 2024 05:49:10 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46C5n960020505;
	Fri, 12 Jul 2024 05:49:09 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 46C5n9AT020503;
	Fri, 12 Jul 2024 05:49:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id B3A781287; Fri, 12 Jul 2024 11:19:01 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] PM: domains: add device managed version of dev_pm_domain_attach|detach_list()
Date: Fri, 12 Jul 2024 11:18:30 +0530
Message-Id: <1720763312-13018-2-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
References: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wvwl86paHEyAthcndckSETwmFaof1Sqm
X-Proofpoint-GUID: Wvwl86paHEyAthcndckSETwmFaof1Sqm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_03,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120037
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

This patch adds the devres-enabled version of dev_pm_domain_attach|detach_list.
If client drivers use devm_pm_domain_attach_list() to attach the PM domains,
devm_pm_domain_detach_list() will be invoked implicitly during remove phase.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/base/power/common.c | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  4 ++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 327d168..082691e 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -277,6 +277,47 @@ int dev_pm_domain_attach_list(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach_list);
 
 /**
+ * dev_pm_domain_detach_list - devres-enabled version of dev_pm_domain_detach_list.
+ * @list: The list of PM domains to detach.
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
+	ret = devm_add_action_or_reset(dev, devm_pm_domain_detach_list, (void *)list);
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
index 772d328..2f00150 100644
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
-- 
2.7.4


