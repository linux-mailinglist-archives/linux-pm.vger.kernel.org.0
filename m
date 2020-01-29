Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D3414C952
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 12:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgA2LMd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 06:12:33 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:13522 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgA2LMb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 06:12:31 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200129111229epoutp0407edaa6ee9de0c07ff51f7379dfc5763~uVygc5K0q0390303903epoutp04E
        for <linux-pm@vger.kernel.org>; Wed, 29 Jan 2020 11:12:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200129111229epoutp0407edaa6ee9de0c07ff51f7379dfc5763~uVygc5K0q0390303903epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580296349;
        bh=FOqPzoYfYORigK00AWcJ1jApU66hHrUT+pBzUwH0zsU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lOf/zYPRZxHwDdM/P6yOQfMuHW2jD5jueBp9E6ecr/YElQhJj9106rdlRqNKVXt9X
         o0/BmJDmUiIycjETwDMPrQxSXCJhbJhJ1Vr1PfiKs7Nr9OV0SLXlfgduzDB1TxMJG7
         3GO70zVL2FtH98Vep/frcG2bX59AEy2/XNK7JgUc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200129111228epcas1p4e319dd77fdbbacbb6dc1aebc5bcd5b28~uVyftArZn0294002940epcas1p4F;
        Wed, 29 Jan 2020 11:12:28 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48716K6cXfzMqYkZ; Wed, 29 Jan
        2020 11:12:25 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.E2.48019.998613E5; Wed, 29 Jan 2020 20:12:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200129111225epcas1p3f9b495ee2565858d19bce43fb6e86ac1~uVydC1-Kk1412914129epcas1p3e;
        Wed, 29 Jan 2020 11:12:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200129111225epsmtrp2e290f00fc9ba497d1aceecac6518ad4c~uVydCO_7s1038910389epsmtrp2R;
        Wed, 29 Jan 2020 11:12:25 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-70-5e316899051b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.EF.10238.998613E5; Wed, 29 Jan 2020 20:12:25 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200129111225epsmtip1555f61b8d808bab8f96c8e7a59543126~uVyc4SdkN2784527845epsmtip1P;
        Wed, 29 Jan 2020 11:12:25 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH 1/2] PM / devfreq: Remove unneeded extern keyword
Date:   Wed, 29 Jan 2020 20:20:01 +0900
Message-Id: <20200129112002.6998-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7bCmge7MDMM4g6+TzSwm3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsDmwem1Z1snn0bVnF6PF5k1wAc1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsb6C0EFC+0rjvacYGtg
        bDDpYuTkkBAwkdhw8jlLFyMXh5DADkaJN/sfs0M4nxglFrXfZINwvjFKPNp9k7mLkQOs5e9c
        foj4XkaJU43TWSGcL4wSV198YwKZyyagJbH/xQ02EFtEwEri9P8OZhCbWSBFov/3GRaQQcIC
        jhJdS8RAwiwCqhJ/f58HK+EVsJR4OuE/I8R58hKrNxxgBpkvIfCWVWLau41QCReJxh2TWSBs
        YYlXx7ewQ9hSEp/f7WWDsKslVp48wgbR3MEosWX/BVaIhLHE/qWTmUCOYBbQlFi/Sx8irCix
        8/dcRog7+STefe1hhXiYV6KjTQiiRFni8oO7TBC2pMTi9k6oVR4Svz5OBztBSCBWYuukLywT
        GGVnISxYwMi4ilEstaA4Nz212LDABDmONjGCU5KWxQ7GPed8DjEKcDAq8fDOUDGIE2JNLCuu
        zD3EKMHBrCTCK+pqGCfEm5JYWZValB9fVJqTWnyI0RQYehOZpUST84HpMq8k3tDUyNjY2MLE
        0MzU0FBJnPdhpGackEB6YklqdmpqQWoRTB8TB6dUA2N7dZL4g/AXC8yyfjIdTJuUkjtbs2iL
        TCdH3fRctz+nA9bO1d7z2C5Eqd1YzMZ2u6nkfBv12iqxr39n6Z5dmNykrs3q934eMCX+6P3v
        utiDb4r27n9Wv8RjpVv4jBQ2HtiiWCB+c2Xw70zNRRNWCR/dvmdBZU1GUnDIzuVL9lrHSXbe
        nb7ggBJLcUaioRZzUXEiAKVlPndfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBJMWRmVeSWpSXmKPExsWy7bCSnO7MDMM4g+uHhC0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsDmwem1Z1snn0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJX
        xvoLQQUL7SuO9pxga2BsMOli5OCQEDCR+DuXv4uRi0NIYDejxIdj3UxdjJxAcUmJaRePMkPU
        CEscPlwMUfOJUeLn2S+MIDVsAloS+1/cYAOxRQRsJO4uvsYCUs8skCHxf7kSiCks4CjRtUQM
        pIJFQFXi7+/zzCA2r4ClxNMJ/xkhNslLrN5wgHkCI88CRoZVjJKpBcW56bnFhgWGeanlesWJ
        ucWleel6yfm5mxjB4aGluYPx8pL4Q4wCHIxKPLwzVAzihFgTy4orcw8xSnAwK4nwiroaxgnx
        piRWVqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAGPTrtf2/3fGW
        ruVJkyK/twTPVlOq4Y4vm3mRSXbjszPrVmlFb/752dLoUHjWKzfT1iMn/Sr55ujdyl19QMZW
        K/Ath/9dmcPLv4lHfz76/Hxxy/3VfOeit+RGeIdufv5yV83NnNSbhoVTSpO92N9Fbfw5U3/V
        /cneOdKPvAuCTOMmrLLZy7DioxJLcUaioRZzUXEiACPwOVULAgAA
X-CMS-MailID: 20200129111225epcas1p3f9b495ee2565858d19bce43fb6e86ac1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200129111225epcas1p3f9b495ee2565858d19bce43fb6e86ac1
References: <CGME20200129111225epcas1p3f9b495ee2565858d19bce43fb6e86ac1@epcas1p3.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove unneeded extern keyword from devfreq-related header file
and adjust the indentation of function parameter to keep the
consistency in header file

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor.h |  17 +++----
 include/linux/devfreq.h    | 100 ++++++++++++++++++-------------------
 2 files changed, 57 insertions(+), 60 deletions(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index dc7533ccc3db..5ba3e051b1d0 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -57,17 +57,16 @@ struct devfreq_governor {
 				unsigned int event, void *data);
 };
 
-extern void devfreq_monitor_start(struct devfreq *devfreq);
-extern void devfreq_monitor_stop(struct devfreq *devfreq);
-extern void devfreq_monitor_suspend(struct devfreq *devfreq);
-extern void devfreq_monitor_resume(struct devfreq *devfreq);
-extern void devfreq_interval_update(struct devfreq *devfreq,
-					unsigned int *delay);
+void devfreq_monitor_start(struct devfreq *devfreq);
+void devfreq_monitor_stop(struct devfreq *devfreq);
+void devfreq_monitor_suspend(struct devfreq *devfreq);
+void devfreq_monitor_resume(struct devfreq *devfreq);
+void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay);
 
-extern int devfreq_add_governor(struct devfreq_governor *governor);
-extern int devfreq_remove_governor(struct devfreq_governor *governor);
+int devfreq_add_governor(struct devfreq_governor *governor);
+int devfreq_remove_governor(struct devfreq_governor *governor);
 
-extern int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
+int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
 
 static inline int devfreq_update_stats(struct devfreq *df)
 {
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index c6f82d4bec9f..82630fafacde 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -201,24 +201,23 @@ struct devfreq_freqs {
 };
 
 #if defined(CONFIG_PM_DEVFREQ)
-extern struct devfreq *devfreq_add_device(struct device *dev,
-				  struct devfreq_dev_profile *profile,
-				  const char *governor_name,
-				  void *data);
-extern int devfreq_remove_device(struct devfreq *devfreq);
-extern struct devfreq *devm_devfreq_add_device(struct device *dev,
-				  struct devfreq_dev_profile *profile,
-				  const char *governor_name,
-				  void *data);
-extern void devm_devfreq_remove_device(struct device *dev,
-				  struct devfreq *devfreq);
+struct devfreq *devfreq_add_device(struct device *dev,
+				struct devfreq_dev_profile *profile,
+				const char *governor_name,
+				void *data);
+int devfreq_remove_device(struct devfreq *devfreq);
+struct devfreq *devm_devfreq_add_device(struct device *dev,
+				struct devfreq_dev_profile *profile,
+				const char *governor_name,
+				void *data);
+void devm_devfreq_remove_device(struct device *dev, struct devfreq *devfreq);
 
 /* Supposed to be called by PM callbacks */
-extern int devfreq_suspend_device(struct devfreq *devfreq);
-extern int devfreq_resume_device(struct devfreq *devfreq);
+int devfreq_suspend_device(struct devfreq *devfreq);
+int devfreq_resume_device(struct devfreq *devfreq);
 
-extern void devfreq_suspend(void);
-extern void devfreq_resume(void);
+void devfreq_suspend(void);
+void devfreq_resume(void);
 
 /**
  * update_devfreq() - Reevaluate the device and configure frequency
@@ -226,35 +225,34 @@ extern void devfreq_resume(void);
  *
  * Note: devfreq->lock must be held
  */
-extern int update_devfreq(struct devfreq *devfreq);
+int update_devfreq(struct devfreq *devfreq);
 
 /* Helper functions for devfreq user device driver with OPP. */
-extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
-					   unsigned long *freq, u32 flags);
-extern int devfreq_register_opp_notifier(struct device *dev,
-					 struct devfreq *devfreq);
-extern int devfreq_unregister_opp_notifier(struct device *dev,
-					   struct devfreq *devfreq);
-extern int devm_devfreq_register_opp_notifier(struct device *dev,
-					      struct devfreq *devfreq);
-extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
-						struct devfreq *devfreq);
-extern int devfreq_register_notifier(struct devfreq *devfreq,
-					struct notifier_block *nb,
-					unsigned int list);
-extern int devfreq_unregister_notifier(struct devfreq *devfreq,
-					struct notifier_block *nb,
-					unsigned int list);
-extern int devm_devfreq_register_notifier(struct device *dev,
+struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
+				unsigned long *freq, u32 flags);
+int devfreq_register_opp_notifier(struct device *dev,
+				struct devfreq *devfreq);
+int devfreq_unregister_opp_notifier(struct device *dev,
+				struct devfreq *devfreq);
+int devm_devfreq_register_opp_notifier(struct device *dev,
+				struct devfreq *devfreq);
+void devm_devfreq_unregister_opp_notifier(struct device *dev,
+				struct devfreq *devfreq);
+int devfreq_register_notifier(struct devfreq *devfreq,
+				struct notifier_block *nb,
+				unsigned int list);
+int devfreq_unregister_notifier(struct devfreq *devfreq,
+				struct notifier_block *nb,
+				unsigned int list);
+int devm_devfreq_register_notifier(struct device *dev,
 				struct devfreq *devfreq,
 				struct notifier_block *nb,
 				unsigned int list);
-extern void devm_devfreq_unregister_notifier(struct device *dev,
+void devm_devfreq_unregister_notifier(struct device *dev,
 				struct devfreq *devfreq,
 				struct notifier_block *nb,
 				unsigned int list);
-extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
-						int index);
+struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index);
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
@@ -311,9 +309,9 @@ struct devfreq_passive_data {
 
 #else /* !CONFIG_PM_DEVFREQ */
 static inline struct devfreq *devfreq_add_device(struct device *dev,
-					  struct devfreq_dev_profile *profile,
-					  const char *governor_name,
-					  void *data)
+					struct devfreq_dev_profile *profile,
+					const char *governor_name,
+					void *data)
 {
 	return ERR_PTR(-ENOSYS);
 }
@@ -350,31 +348,31 @@ static inline void devfreq_suspend(void) {}
 static inline void devfreq_resume(void) {}
 
 static inline struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
-					   unsigned long *freq, u32 flags)
+					unsigned long *freq, u32 flags)
 {
 	return ERR_PTR(-EINVAL);
 }
 
 static inline int devfreq_register_opp_notifier(struct device *dev,
-					 struct devfreq *devfreq)
+					struct devfreq *devfreq)
 {
 	return -EINVAL;
 }
 
 static inline int devfreq_unregister_opp_notifier(struct device *dev,
-					   struct devfreq *devfreq)
+					struct devfreq *devfreq)
 {
 	return -EINVAL;
 }
 
 static inline int devm_devfreq_register_opp_notifier(struct device *dev,
-						     struct devfreq *devfreq)
+					struct devfreq *devfreq)
 {
 	return -EINVAL;
 }
 
 static inline void devm_devfreq_unregister_opp_notifier(struct device *dev,
-							struct devfreq *devfreq)
+					struct devfreq *devfreq)
 {
 }
 
@@ -393,22 +391,22 @@ static inline int devfreq_unregister_notifier(struct devfreq *devfreq,
 }
 
 static inline int devm_devfreq_register_notifier(struct device *dev,
-				struct devfreq *devfreq,
-				struct notifier_block *nb,
-				unsigned int list)
+					struct devfreq *devfreq,
+					struct notifier_block *nb,
+					unsigned int list)
 {
 	return 0;
 }
 
 static inline void devm_devfreq_unregister_notifier(struct device *dev,
-				struct devfreq *devfreq,
-				struct notifier_block *nb,
-				unsigned int list)
+					struct devfreq *devfreq,
+					struct notifier_block *nb,
+					unsigned int list)
 {
 }
 
 static inline struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
-							int index)
+					int index)
 {
 	return ERR_PTR(-ENODEV);
 }
-- 
2.17.1

