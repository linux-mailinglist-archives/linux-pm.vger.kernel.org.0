Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E868651BD6
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 08:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiLTHo7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 02:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiLTHo6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 02:44:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C87B11816;
        Mon, 19 Dec 2022 23:44:57 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BK5oBeN009448;
        Tue, 20 Dec 2022 07:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=RnFoNN9xI8IdQxxwTV7SaHzB4aSFcUEtRRJmZ1qPkyQ=;
 b=ODC/jzJaldoci96Zk9PeyCNUf+czGYGNWR16DazdUkRj2HpVALn4P+bJt3sMO8rwg/my
 Di1DpXfg+V/DyPPs2YbZppYSiTafubtPcpMQXxDkhr1Gtj8zOOE+efMfRjnQi4SkX5ew
 M+gOhQ00F8mGtjftQlQfdvFxoARgKQYrraFsXLwyJMs7rGr5hDvfJ9LwdPQWHix2kpfL
 O9Dbw/xBruQyE67Ugbsn2luBbTD7LrQ/2c3gyPZHWesgNODd/Fl9yEPFLAiwFVxVEcWj
 pN2FCU/zgrLv3rXt7sAIFlLoSgsZ+mMow9MUo1s4XvnRgEaYxF1xpbE3GnKGC7v8IAbu dw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mh72gdyu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 07:44:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BK7ihcU030598
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 07:44:43 GMT
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 23:44:38 -0800
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v3 1/5] PM: domains: Allow a genpd consumer to require a synced power off
Date:   Tue, 20 Dec 2022 13:14:13 +0530
Message-ID: <20221220131255.v3.1.I3e6b1f078ad0f1ca9358c573daa7b70ec132cdbe@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671522257-38778-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1671522257-38778-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mojE7_EkcObDIQy1KLEaUb4LS5h-qdQB
X-Proofpoint-ORIG-GUID: mojE7_EkcObDIQy1KLEaUb4LS5h-qdQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=886 adultscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212200064
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Some genpd providers doesn't ensure that it has turned off at hardware.
This is fine until the consumer really requires during some special
scenarios that the power domain collapse at hardware before it is
turned ON again.

An example is the reset sequence of Adreno GPU which requires that the
'gpucc cx gdsc' power domain should move to OFF state in hardware at
least once before turning in ON again to clear the internal state.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

(no changes since v2)

Changes in v2:
- Minor formatting fix

 drivers/base/power/domain.c | 23 +++++++++++++++++++++++
 include/linux/pm_domain.h   |  5 +++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 967bcf9d415e..53524a102321 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -519,6 +519,28 @@ ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_get_next_hrtimer);
 
+/*
+ * dev_pm_genpd_synced_poweroff - Next power off should be synchronous
+ *
+ * @dev: A device that is attached to the genpd.
+ *
+ * Allows a consumer of the genpd to notify the provider that the next power off
+ * should be synchronous.
+ */
+void dev_pm_genpd_synced_poweroff(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return;
+
+	genpd_lock(genpd);
+	genpd->synced_poweroff = true;
+	genpd_unlock(genpd);
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
@@ -562,6 +584,7 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 
 out:
 	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON, NULL);
+	genpd->synced_poweroff = false;
 	return 0;
 err:
 	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF,
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 1cd41bdf73cf..f776fb93eaa0 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -136,6 +136,7 @@ struct generic_pm_domain {
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	unsigned int performance_state;	/* Aggregated max performance state */
 	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
+	bool synced_poweroff;		/* A consumer needs a synced poweroff */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
 	struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
@@ -235,6 +236,7 @@ int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
 void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
 ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
+void dev_pm_genpd_synced_poweroff(struct device *dev);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -300,6 +302,9 @@ static inline ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
 {
 	return KTIME_MAX;
 }
+static inline void dev_pm_genpd_synced_poweroff(struct device *dev)
+{ }
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.7.4

