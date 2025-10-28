Return-Path: <linux-pm+bounces-36937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F13F4C12A89
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 03:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0B974E2194
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 02:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D773923AB87;
	Tue, 28 Oct 2025 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YXgpwASQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADFA23B61E;
	Tue, 28 Oct 2025 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761618304; cv=none; b=mwVFUauG8xWJyLqw2Ysmm5+cKCrQFFEO5GTICxdzDXUidrGR5Bqffv27nPfylIa04D5TnIQ8JOs76WhYHE0d1Mi3x8r6QQCfd/LCGWde11ZZcuh7Nr+vYqeOHSPzOwPZsX5LVGdKhxNZJaZYvs7T5h70GkMPy5WlNgfXyHYHS2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761618304; c=relaxed/simple;
	bh=i/iC6NpSa6RW/XISeDF++uvKRG8mL4QnD9/Ps/uxQM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZxJX+9e1VWZMUvLz7RuImDNKaqHbrfPiU9tfwhN1kt+pXo2NDxEQQnLnFtedG6nuiWJQ/lHXpIRs07uEibU1j8yrbmcZ36WyQMjr5aHR14SeZGUlqy/a6YXG4Yy3VzwK5aLVClUUalC5I+MCTHLSpqP85LPmBgjootwtOVRB7fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YXgpwASQ; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GwaSV6XOD+MN9KbtVRXhfiPV+jTc/qKM+v7o/qSpsJY=;
	b=YXgpwASQajR4lf1swu41D/o/JDGs+A8QPAS/jVQn0J+ouRqt+Dq166H0IS55x8iOt/9Z0t7g8
	T+r3s5bo3+qgvptEcxNaeBZCfQBpCUIW/TaD1WL/2WTlcIsUspA9DGd0lBnPmsu/pbAIKvrcTn4
	3FCNmYR57Krwc3NbGdQICQE=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cwZ1n01mhz1T4HL;
	Tue, 28 Oct 2025 10:23:57 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 12364180080;
	Tue, 28 Oct 2025 10:24:59 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 10:24:58 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
	<cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhangpengjie2@huawei.com>
Subject: [PATCH v2] PM / devfreq: use _visible attribute to replace create/remove_sysfs_files()
Date: Tue, 28 Oct 2025 10:24:58 +0800
Message-ID: <20251028022458.2824872-1-zhangpengjie2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr200004.china.huawei.com (7.202.195.241)

Previously, non-generic attributes (polling_interval, timer) used separate
create/delete logic, leading to race conditions during concurrent access in
creation/deletion. Multi-threaded operations also caused inconsistencies
between governor capabilities and attribute states.

1.Use is_visible + sysfs_update_group() to unify management of these
attributes, eliminating creation/deletion races.
2.Add locks and validation to these attributes, ensuring consistency
between current governor capabilities and attribute operations in
multi-threaded environments.

Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
Changes in v2:
- Fix one problem reported by the kernel test robot.
- Redirect all error paths in timer_store() to out to ensure locks are not
 left unReleased.

 drivers/devfreq/devfreq.c | 140 +++++++++++++++++++++++++-------------
 1 file changed, 94 insertions(+), 46 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2e8d01d47f69..32640e376124 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -38,6 +38,7 @@
 
 static struct class *devfreq_class;
 static struct dentry *devfreq_debugfs;
+static const struct attribute_group gov_attr_group;
 
 /*
  * devfreq core provides delayed work based load monitoring helper
@@ -785,11 +786,6 @@ static void devfreq_dev_release(struct device *dev)
 	kfree(devfreq);
 }
 
-static void create_sysfs_files(struct devfreq *devfreq,
-				const struct devfreq_governor *gov);
-static void remove_sysfs_files(struct devfreq *devfreq,
-				const struct devfreq_governor *gov);
-
 /**
  * devfreq_add_device() - Add devfreq feature to the device
  * @dev:	the device to add devfreq feature.
@@ -956,7 +952,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 			 __func__);
 		goto err_init;
 	}
-	create_sysfs_files(devfreq, devfreq->governor);
+
+	err = sysfs_update_group(&devfreq->dev.kobj, &gov_attr_group);
+	if (err)
+		goto err_init;
 
 	list_add(&devfreq->node, &devfreq_list);
 
@@ -998,9 +997,7 @@ int devfreq_remove_device(struct devfreq *devfreq)
 	if (devfreq->governor) {
 		devfreq->governor->event_handler(devfreq,
 						 DEVFREQ_GOV_STOP, NULL);
-		remove_sysfs_files(devfreq, devfreq->governor);
 	}
-
 	device_unregister(&devfreq->dev);
 
 	return 0;
@@ -1460,7 +1457,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 			 __func__, df->governor->name, ret);
 		goto out;
 	}
-	remove_sysfs_files(df, df->governor);
 
 	/*
 	 * Start the new governor and create the specific sysfs files
@@ -1489,7 +1485,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	 * Create the sysfs files for the new governor. But if failed to start
 	 * the new governor, restore the sysfs files of previous governor.
 	 */
-	create_sysfs_files(df, df->governor);
+	ret = sysfs_update_group(&df->dev.kobj, &gov_attr_group);
 
 out:
 	mutex_unlock(&devfreq_list_lock);
@@ -1805,19 +1801,26 @@ static struct attribute *devfreq_attrs[] = {
 	&dev_attr_min_freq.attr,
 	&dev_attr_max_freq.attr,
 	&dev_attr_trans_stat.attr,
-	NULL,
+	NULL
 };
-ATTRIBUTE_GROUPS(devfreq);
 
 static ssize_t polling_interval_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
 	struct devfreq *df = to_devfreq(dev);
+	int ret;
 
-	if (!df->profile)
+	mutex_lock(&devfreq_list_lock);
+	if (!df->profile || !df->governor ||
+	    !IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL)) {
+		mutex_unlock(&devfreq_list_lock);
 		return -EINVAL;
+	}
 
-	return sprintf(buf, "%d\n", df->profile->polling_ms);
+	ret = sprintf(buf, "%d\n", df->profile->polling_ms);
+	mutex_unlock(&devfreq_list_lock);
+
+	return ret;
 }
 
 static ssize_t polling_interval_store(struct device *dev,
@@ -1828,15 +1831,22 @@ static ssize_t polling_interval_store(struct device *dev,
 	unsigned int value;
 	int ret;
 
-	if (!df->governor)
+	mutex_lock(&devfreq_list_lock);
+	if (!df->governor ||
+	    !IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL)) {
+		mutex_unlock(&devfreq_list_lock);
 		return -EINVAL;
+	}
 
 	ret = sscanf(buf, "%u", &value);
-	if (ret != 1)
+	if (ret != 1) {
+		mutex_unlock(&devfreq_list_lock);
 		return -EINVAL;
+	}
 
 	df->governor->event_handler(df, DEVFREQ_GOV_UPDATE_INTERVAL, &value);
 	ret = count;
+	mutex_unlock(&devfreq_list_lock);
 
 	return ret;
 }
@@ -1846,11 +1856,19 @@ static ssize_t timer_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	struct devfreq *df = to_devfreq(dev);
+	int ret;
 
-	if (!df->profile)
+	mutex_lock(&devfreq_list_lock);
+	if (!df->profile || !df->governor ||
+	    !IS_SUPPORTED_ATTR(df->governor->attrs, TIMER)) {
+		mutex_unlock(&devfreq_list_lock);
 		return -EINVAL;
+	}
+
+	ret = sprintf(buf, "%s\n", timer_name[df->profile->timer]);
+	mutex_unlock(&devfreq_list_lock);
 
-	return sprintf(buf, "%s\n", timer_name[df->profile->timer]);
+	return ret;
 }
 
 static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
@@ -1861,12 +1879,18 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
 	int timer = -1;
 	int ret = 0, i;
 
-	if (!df->governor || !df->profile)
-		return -EINVAL;
+	mutex_lock(&devfreq_list_lock);
+	if (!df->governor || !df->profile ||
+	    !IS_SUPPORTED_ATTR(df->governor->attrs, TIMER)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = sscanf(buf, "%16s", str_timer);
-	if (ret != 1)
-		return -EINVAL;
+	if (ret != 1) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	for (i = 0; i < DEVFREQ_TIMER_NUM; i++) {
 		if (!strncmp(timer_name[i], str_timer, DEVFREQ_NAME_LEN)) {
@@ -1901,40 +1925,64 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
 		dev_warn(dev, "%s: Governor %s not started(%d)\n",
 			 __func__, df->governor->name, ret);
 out:
+	mutex_unlock(&devfreq_list_lock);
 	return ret ? ret : count;
 }
 static DEVICE_ATTR_RW(timer);
 
-#define CREATE_SYSFS_FILE(df, name)					\
-{									\
-	int ret;							\
-	ret = sysfs_create_file(&df->dev.kobj, &dev_attr_##name.attr);	\
-	if (ret < 0) {							\
-		dev_warn(&df->dev,					\
-			"Unable to create attr(%s)\n", "##name");	\
-	}								\
-}									\
+static struct attribute *governor_attrs[] = {
+	&dev_attr_polling_interval.attr,
+	&dev_attr_timer.attr,
+	NULL
+};
 
-/* Create the specific sysfs files which depend on each governor. */
-static void create_sysfs_files(struct devfreq *devfreq,
-				const struct devfreq_governor *gov)
+static umode_t gov_attr_visible(struct kobject *kobj,
+				struct attribute *attr, int n)
 {
-	if (IS_SUPPORTED_ATTR(gov->attrs, POLLING_INTERVAL))
-		CREATE_SYSFS_FILE(devfreq, polling_interval);
-	if (IS_SUPPORTED_ATTR(gov->attrs, TIMER))
-		CREATE_SYSFS_FILE(devfreq, timer);
+	struct device *dev = kobj_to_dev(kobj);
+	struct devfreq *df = to_devfreq(dev);
+
+	if (!df->governor || !df->governor->attrs)
+		return 0;
+
+	if (IS_SUPPORTED_ATTR(df->governor->attrs, POLLING_INTERVAL))
+		return attr->mode;
+	if (IS_SUPPORTED_ATTR(df->governor->attrs, TIMER))
+		return attr->mode;
+
+	return 0;
 }
 
-/* Remove the specific sysfs files which depend on each governor. */
-static void remove_sysfs_files(struct devfreq *devfreq,
-				const struct devfreq_governor *gov)
+static bool gov_group_visible(struct kobject *kobj)
 {
-	if (IS_SUPPORTED_ATTR(gov->attrs, POLLING_INTERVAL))
-		sysfs_remove_file(&devfreq->dev.kobj,
-				&dev_attr_polling_interval.attr);
-	if (IS_SUPPORTED_ATTR(gov->attrs, TIMER))
-		sysfs_remove_file(&devfreq->dev.kobj, &dev_attr_timer.attr);
+	struct device *dev = kobj_to_dev(kobj);
+	struct devfreq *df;
+
+	if (!dev)
+		return false;
+
+	df = to_devfreq(dev);
+	if (!df)
+		return false;
+
+	return true;
 }
+DEFINE_SYSFS_GROUP_VISIBLE(gov);
+
+static const struct attribute_group devfreq_group = {
+	.attrs = devfreq_attrs,
+};
+
+static const struct attribute_group gov_attr_group = {
+	.attrs = governor_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(gov),
+};
+
+static const struct attribute_group *devfreq_groups[] = {
+	&devfreq_group,
+	&gov_attr_group,
+	NULL
+};
 
 /**
  * devfreq_summary_show() - Show the summary of the devfreq devices
-- 
2.33.0


