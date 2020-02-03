Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFA0150033
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2020 02:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgBCBJy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Feb 2020 20:09:54 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:24045 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgBCBJx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Feb 2020 20:09:53 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200203010950epoutp02992b40231972e9b1e5d0bb8308b51fd0~vvywEU1OC0073600736epoutp02e
        for <linux-pm@vger.kernel.org>; Mon,  3 Feb 2020 01:09:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200203010950epoutp02992b40231972e9b1e5d0bb8308b51fd0~vvywEU1OC0073600736epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580692190;
        bh=RQmoYEoCJrDBF3NGfioncJhLMZZJauhsFwOd7mIxRXM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bCXDsABTnWEFcAxUQsQJq/7EV70umTAyUXu588p9iVCMNFr9sCyXvQxQ3jgN3XvDM
         XtQGVGWoXnJ8wBTToHB1xOZeyKeP+X256aVFFZPSB7vwXUPzlbiKJDxi5bifvI3gCp
         23N9ngNgRbU/mIrnQvmYkHza2ENWFANHGbdjF+5A=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200203010949epcas1p1f651a0db3b1df904e13505c51da40343~vvyvheIRl1965619656epcas1p1G;
        Mon,  3 Feb 2020 01:09:49 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 489qVf66j2zMqYkX; Mon,  3 Feb
        2020 01:09:46 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.61.48498.AD2773E5; Mon,  3 Feb 2020 10:09:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200203010946epcas1p16010f3f1e5b079927bd81b8e70c0a015~vvys0R2Y-0039600396epcas1p1v;
        Mon,  3 Feb 2020 01:09:46 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200203010946epsmtrp1d46994cbbe3a0a22910605e48f1727c7~vvyszPEC41442914429epsmtrp1L;
        Mon,  3 Feb 2020 01:09:46 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-4e-5e3772da08a2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.AE.06569.AD2773E5; Mon,  3 Feb 2020 10:09:46 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200203010946epsmtip2332d592caf87478db944e064894428e9~vvysoH5j72257522575epsmtip2O;
        Mon,  3 Feb 2020 01:09:46 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        lukasz.luba@arm.com
Subject: [PATCHv2 1/2] PM / devfreq: Remove unneeded extern keyword
Date:   Mon,  3 Feb 2020 10:17:32 +0900
Message-Id: <20200203011733.7639-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7bCmnu6tIvM4g0d/9S0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XCphZ2i9uNK9gc2D3WzFvD6LFpVSebR9+WVYwenzfJBbBEZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2gpFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNArTswtLs1L10vOz7UyNDAwMgUqTMjO+LP4
        LHtBs0PF0cbDzA2MF0y6GDk5JARMJHp27GDvYuTiEBLYwSjxeMlJFpCEkMAnRoneOwUQiW+M
        Es0Tr7DCdEzv2sQMUbSXUeLgOTWIoi+MEi0LO5lAEmwCWhL7X9xgA7FFBKwkTv/vAGtgFqiU
        +HLuKNggYQFnib6DnWA1LAKqEk3fDoPFeQUsJY7ffskIsUxeYvWGA8wgCyQE/rJKPJq0CSrh
        IvHjUh8ThC0s8er4FnYIW0riZX8blF0tsfLkETaI5g5GiS37L0C9YCyxf+lkoGYOoIs0Jdbv
        0ocIK0rs/D2XEeJQPol3X3tYQUokBHglOtqEIEqUJS4/uAu1VlJicTvI/SAlHhIthyMhYRIr
        MaHzAeMERtlZCPMXMDKuYhRLLSjOTU8tNiwwQo6jTYzgNKVltoNx0TmfQ4wCHIxKPLwzHprF
        CbEmlhVX5h5ilOBgVhLhrbMyjRPiTUmsrEotyo8vKs1JLT7EaAoMvInMUqLJ+cAUmlcSb2hq
        ZGxsbGFiaGZqaKgkzvswUjNOSCA9sSQ1OzW1ILUIpo+Jg1OqgVFYUVG2NFPGJ0Tp15KLbCfe
        deztyP/4f/4dzcOH2WPqrBssl0y8bHpI77+imvLs+gD9wrP9C+rb1vmbTXstGzKn+enOm7oK
        s/WKfRWEla/pfnkn9pjpoJLDIx9l7nn3dkkGqoe3NOjNlHtszelpaCIZprhSQPJhVjpfn/q5
        M2sfLTttuPV8ihJLcUaioRZzUXEiANHsN5lpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjluLIzCtJLcpLzFFi42LZdlhJXvdWkXmcwfLtMhYTb1xhsbj+5Tmr
        xdmmN+wWl3fNYbP43HuE0WJhUwu7xe3GFWwO7B5r5q1h9Ni0qpPNo2/LKkaPz5vkAliiuGxS
        UnMyy1KL9O0SuDL+LD7LXtDsUHG08TBzA+MFky5GTg4JAROJ6V2bmLsYuTiEBHYzSrSvvs4O
        kZCUmHbxKFCCA8gWljh8uBii5hOjxP6+ecwgNWwCWhL7X9xgA7FFBGwk7i6+xgJiMwvUS7Sd
        2Q82R1jAWaLvYCdYDYuAqkTTt8OsIDavgKXE8dsvGSF2yUus3nCAeQIjzwJGhlWMkqkFxbnp
        ucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMGho6W1g/HEifhDjAIcjEo8vDMemsUJsSaWFVfmHmKU
        4GBWEuGtszKNE+JNSaysSi3Kjy8qzUktPsQozcGiJM4rn38sUkggPbEkNTs1tSC1CCbLxMEp
        1cBoLfkgdrJMRsztrVcYefR8CyyKz1ZM3MK0JVNHasJmXh6JgEcL6y3nWsvsLAv/P9G7X3D+
        t6h/a2T3v3+YZcuspyIoJ8XfOMFE+zj/iydeN+yL3vWq6Z90+MxY45vaHlW+YZ70jfMVZuHG
        GmVTps5rWqdtd1TfouNpVePKyitWUjcniCfvnq/EUpyRaKjFXFScCAC3ZZyxGQIAAA==
X-CMS-MailID: 20200203010946epcas1p16010f3f1e5b079927bd81b8e70c0a015
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200203010946epcas1p16010f3f1e5b079927bd81b8e70c0a015
References: <CGME20200203010946epcas1p16010f3f1e5b079927bd81b8e70c0a015@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove unneeded extern keyword from devfreq-related header file
and adjust the indentation of function parameter to keep the
consistency in header file

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes from v1:
- Add reviewed tag of Lukasz

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

