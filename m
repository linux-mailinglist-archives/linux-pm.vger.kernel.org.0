Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052901E253C
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 17:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgEZPRW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 11:17:22 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21204 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727921AbgEZPRV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 11:17:21 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QFADsH025032;
        Tue, 26 May 2020 17:16:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=0feWfYVxQYrSEupQlVoVOosyiC2LKcVNCDVytVsfcsI=;
 b=LLSViMJaH5iEPzyFmqnA1qbVFgaWgM4Y3b9yMDMw/GXrlXntN+N9M4VKThB2pCLgl7p6
 JhS05k4oPuEIaDdvY3oMQMgscQ0vN7bXCi2QbevhZ5hFGzFHwSWTL8jaYcRF0YB+sQoJ
 RN5RCgWXO1svJvjbxKPSUm9cq1Dk8kUAA7chqe2hMmveVEepseGQUVHL/xdlb55jSZ8v
 xaSD1My5NGrH5hDl/oLSuuxZ2JgkkPu0aUG+jFfSTfAhXyblL2TZO/YoikWVc1T7TDwN
 e0+CXXN3lf95LTmjJ35jI+vwmXCGnYhwvbCbuleUWDl2LwdS2VyrayUpt2VIq7gbZtfR wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316sa20en7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 17:16:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B8DE2100034;
        Tue, 26 May 2020 17:16:26 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9E58C2C1D9F;
        Tue, 26 May 2020 17:16:26 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 May 2020 17:16:25
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <hugues.fruchet@st.com>, <mchehab@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <pavel@ucw.cz>, <len.brown@intel.com>,
        <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [RFC 1/3] PM: QoS: Introduce cpufreq minimum load QoS
Date:   Tue, 26 May 2020 17:16:17 +0200
Message-ID: <20200526151619.8779-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200526151619.8779-1-benjamin.gaignard@st.com>
References: <20200526151619.8779-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce cpufreq minimum load QoS, based on the "raw" low-level
PM QoS, to represent the minimum expected cpu load by various devices.

The cpufreq_minload_qos_limit() helper is defined to retrieve the
aggregated constraints.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 include/linux/pm_qos.h |  12 +++
 kernel/power/qos.c     | 213 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 225 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 4a69d4af3ff8..e2cc099322e3 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -316,4 +316,16 @@ int freq_qos_remove_notifier(struct freq_constraints *qos,
 			     enum freq_qos_req_type type,
 			     struct notifier_block *notifier);
 
+/* Definitions related to the cpufreq minimum load QoS. */
+
+#define CPUFREQ_GOV_QOS_MIN_LOAD_DEFAULT_VALUE	0
+#define CPUFREQ_GOV_QOS_MIN_LOAD_MAX_VALUE	10
+
+s32 cpufreq_minload_qos_limit(void);
+bool cpufreq_minload_qos_request_active(struct pm_qos_request *req);
+void cpufreq_minload_qos_add_request(struct pm_qos_request *req, s32 value);
+void cpufreq_minload_qos_update_request(struct pm_qos_request *req,
+					s32 new_value);
+void cpufreq_minload_qos_remove_request(struct pm_qos_request *req);
+
 #endif
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index db0bed2cae26..df2fdd962f35 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -671,3 +671,216 @@ int freq_qos_remove_notifier(struct freq_constraints *qos,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(freq_qos_remove_notifier);
+
+/* Definitions related to the cpufreq minimum load QoS. */
+
+static struct pm_qos_constraints cpufreq_minload_constraints = {
+	.list = PLIST_HEAD_INIT(cpufreq_minload_constraints.list),
+	.target_value = CPUFREQ_GOV_QOS_MIN_LOAD_DEFAULT_VALUE,
+	.default_value = CPUFREQ_GOV_QOS_MIN_LOAD_DEFAULT_VALUE,
+	.no_constraint_value = CPUFREQ_GOV_QOS_MIN_LOAD_DEFAULT_VALUE,
+	.type = PM_QOS_MAX,
+};
+
+/**
+ * cpufreq_minload_qos_limit - Return current system-wide cpufreq
+ * minimum load QoS limit.
+ */
+s32 cpufreq_minload_qos_limit(void)
+{
+	return pm_qos_read_value(&cpufreq_minload_constraints);
+}
+EXPORT_SYMBOL_GPL(cpufreq_minload_qos_limit);
+
+/**
+ * cpufreq_minload_qos_request_active - Check the given PM QoS request.
+ * @req: PM QoS request to check.
+ *
+ * Return: 'true' if @req has been added to the cpufreq minimum load
+ * QoS list, 'false' otherwise.
+ */
+bool cpufreq_minload_qos_request_active(struct pm_qos_request *req)
+{
+	return req->qos == &cpufreq_minload_constraints;
+}
+EXPORT_SYMBOL_GPL(cpufreq_minload_qos_request_active);
+
+/**
+ * cpufreq_minload_qos_add_request - Add new cpufreq minimum load QoS request.
+ * @req: Pointer to a preallocated handle.
+ * @value: Requested constraint value.
+ *
+ * Use @value to initialize the request handle pointed to by @req, insert it as
+ * a new entry to the cpufreq minimum load QoS list and recompute the effective
+ * QoS constraint for that list.
+ *
+ * Callers need to save the handle for later use in updates and removal of the
+ * QoS request represented by it.
+ */
+void cpufreq_minload_qos_add_request(struct pm_qos_request *req, s32 value)
+{
+	if (!req)
+		return;
+
+	if (cpufreq_minload_qos_request_active(req)) {
+		WARN(1, KERN_ERR "%s called for already added request\n", __func__);
+		return;
+	}
+
+	trace_pm_qos_add_request(value);
+
+	req->qos = &cpufreq_minload_constraints;
+	pm_qos_update_target(req->qos, &req->node, PM_QOS_ADD_REQ, value);
+}
+EXPORT_SYMBOL_GPL(cpufreq_minload_qos_add_request);
+
+/**
+ * cpufreq_minload_qos_update_request - Modify existing cpufreq minimum load
+ * QoS request.
+ * @req : QoS request to update.
+ * @new_value: New requested constraint value.
+ *
+ * Use @new_value to update the QoS request represented by @req in the cpufreq
+ * minimum load QoS list along with updating the effective constraint value for
+ * that list.
+ */
+void cpufreq_minload_qos_update_request(struct pm_qos_request *req,
+					s32 new_value)
+{
+	if (!req)
+		return;
+
+	if (!cpufreq_minload_qos_request_active(req)) {
+		WARN(1, KERN_ERR "%s called for unknown object\n", __func__);
+		return;
+	}
+
+	trace_pm_qos_update_request(new_value);
+
+	if (new_value == req->node.prio)
+		return;
+
+	pm_qos_update_target(req->qos, &req->node, PM_QOS_UPDATE_REQ, new_value);
+}
+EXPORT_SYMBOL_GPL(cpufreq_minload_qos_update_request);
+
+/**
+ * cpufreq_minload_qos_remove_request - Remove existing cpufreq minimum load QoS
+ * request.
+ * @req: QoS request to remove.
+ *
+ * Remove the cpufreq minimum load QoS request represented by @req from the
+ * cpufreq minimum load QoS list along with updating the effective constraint
+ * value for that list.
+ */
+void cpufreq_minload_qos_remove_request(struct pm_qos_request *req)
+{
+	if (!req)
+		return;
+
+	if (!cpufreq_minload_qos_request_active(req)) {
+		WARN(1, KERN_ERR "%s called for unknown object\n", __func__);
+		return;
+	}
+
+	trace_pm_qos_remove_request(PM_QOS_DEFAULT_VALUE);
+
+	pm_qos_update_target(req->qos, &req->node,
+			     PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
+	memset(req, 0, sizeof(*req));
+}
+EXPORT_SYMBOL_GPL(cpufreq_minload_qos_remove_request);
+
+/* User space interface to the cpufreq minimum load QoS via misc device. */
+
+static int cpufreq_minload_qos_open(struct inode *inode, struct file *filp)
+{
+	struct pm_qos_request *req;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	cpufreq_minload_qos_add_request(req, PM_QOS_DEFAULT_VALUE);
+	filp->private_data = req;
+
+	return 0;
+}
+
+static int cpufreq_minload_qos_release(struct inode *inode, struct file *filp)
+{
+	struct pm_qos_request *req = filp->private_data;
+
+	filp->private_data = NULL;
+
+	cpufreq_minload_qos_remove_request(req);
+	kfree(req);
+
+	return 0;
+}
+
+static ssize_t cpufreq_minload_qos_read(struct file *filp, char __user *buf,
+					size_t count, loff_t *f_pos)
+{
+	struct pm_qos_request *req = filp->private_data;
+	unsigned long flags;
+	s32 value;
+
+	if (!req || !cpufreq_minload_qos_request_active(req))
+		return -EINVAL;
+
+	spin_lock_irqsave(&pm_qos_lock, flags);
+	value = pm_qos_get_value(&cpufreq_minload_constraints);
+	spin_unlock_irqrestore(&pm_qos_lock, flags);
+
+	return simple_read_from_buffer(buf, count, f_pos, &value, sizeof(s32));
+}
+
+static ssize_t cpufreq_minload_qos_write(struct file *filp,
+					 const char __user *buf,
+					 size_t count, loff_t *f_pos)
+{
+	s32 value;
+
+	if (count == sizeof(s32)) {
+		if (copy_from_user(&value, buf, sizeof(s32)))
+			return -EFAULT;
+	} else {
+		int ret;
+
+		ret = kstrtos32_from_user(buf, count, 16, &value);
+		if (ret)
+			return ret;
+	}
+
+	cpufreq_minload_qos_update_request(filp->private_data, value);
+
+	return count;
+}
+
+static const struct file_operations cpufreq_minload_qos_fops = {
+	.write = cpufreq_minload_qos_write,
+	.read = cpufreq_minload_qos_read,
+	.open = cpufreq_minload_qos_open,
+	.release = cpufreq_minload_qos_release,
+	.llseek = noop_llseek,
+};
+
+static struct miscdevice cpufreq_minload_qos_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "cpufreq_minimum_load",
+	.fops = &cpufreq_minload_qos_fops,
+};
+
+static int __init cpufreq_minload_qos_init(void)
+{
+	int ret;
+
+	ret = misc_register(&cpufreq_minload_qos_miscdev);
+	if (ret < 0)
+		pr_err("%s: %s setup failed\n", __func__,
+		       cpufreq_minload_qos_miscdev.name);
+
+	return ret;
+}
+late_initcall(cpufreq_minload_qos_init);
-- 
2.15.0

