Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85181F829D
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 22:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKKVzb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 16:55:31 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42354 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfKKVzb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Nov 2019 16:55:31 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C020200654;
        Mon, 11 Nov 2019 22:55:28 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DADF2000AC;
        Mon, 11 Nov 2019 22:55:28 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1EEC7205FE;
        Mon, 11 Nov 2019 22:55:28 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH] PM / devfreq: Add usage_stat file to sysfs
Date:   Mon, 11 Nov 2019 23:55:24 +0200
Message-Id: <f70ebc907933717ae5fe2af5bc7f53eed0ef3308.1573508311.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This file shows the currently usage of the device as reported by
get_dev_status.

This is the same information used by the ondemand governor to make
decisions and it is not otherwise easily available.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 Documentation/ABI/testing/sysfs-class-devfreq |  8 +++++
 drivers/devfreq/devfreq.c                     | 34 +++++++++++++++++++
 2 files changed, 42 insertions(+)

The output might be a little too "free-form" for a sysfs file,
suggestions welcome.
* Splitting it into single-field files would make
reads non-atomic.
* There is currently no debugfs for devfreq

The only current alternative seems to be debug statements in the
driver's implementation of get_dev_status.

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index 01196e19afca..680dab768105 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -53,10 +53,18 @@ Description:
 		the number of transitions between states.
 		In order to activate this ABI, the devfreq target device
 		driver should provide the list of available frequencies
 		with its profile.
 
+What:		/sys/class/devfreq/.../usage_stat
+Date:		November 2019
+Contact:	Leonard Crestez <leonard.crestez@nxp.com>
+Description:
+		This file shows the currently usage of the device if
+		measurement is enabled. This is the same information used by
+		ondemand governor to make decisions.
+
 What:		/sys/class/devfreq/.../userspace/set_freq
 Date:		September 2011
 Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
 Description:
 		The /sys/class/devfreq/.../userspace/set_freq shows and
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 78a5af869a0e..20dce6167946 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1559,20 +1559,54 @@ static ssize_t trans_stat_show(struct device *dev,
 					devfreq->total_trans);
 	return len;
 }
 static DEVICE_ATTR_RO(trans_stat);
 
+static ssize_t usage_stat_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct devfreq *devfreq = to_devfreq(dev);
+	struct devfreq_dev_status *stat = &devfreq->last_status;
+	int ret;
+	ssize_t len = 0;
+
+	if (!devfreq->profile->get_dev_status)
+		return sprintf(buf, "Not Supported.\n");
+
+	if (!devfreq->stop_polling) {
+		mutex_lock(&devfreq->lock);
+		ret = devfreq->profile->get_dev_status(dev->parent, stat);
+		mutex_unlock(&devfreq->lock);
+		if (ret) {
+			len += sprintf(buf + len, "Poll error: %d\n", ret);
+			return len;
+		}
+	} else
+		len += sprintf(buf + len, "Polling stopped\n");
+
+	len += sprintf(buf + len, "Busy: %lu\n", stat->busy_time);
+	len += sprintf(buf + len, "Total: %lu\n", stat->total_time);
+	len += sprintf(buf + len, "Current Frequency: %lu\n",
+		       stat->current_frequency);
+	len += sprintf(buf + len, "Usage: %lu%%\n",
+		       stat->busy_time * 100 / stat->total_time);
+
+	return len;
+}
+static DEVICE_ATTR_RO(usage_stat);
+
 static struct attribute *devfreq_attrs[] = {
 	&dev_attr_governor.attr,
 	&dev_attr_available_governors.attr,
 	&dev_attr_cur_freq.attr,
 	&dev_attr_available_frequencies.attr,
 	&dev_attr_target_freq.attr,
 	&dev_attr_polling_interval.attr,
 	&dev_attr_min_freq.attr,
 	&dev_attr_max_freq.attr,
 	&dev_attr_trans_stat.attr,
+	&dev_attr_usage_stat.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(devfreq);
 
 static int __init devfreq_init(void)
-- 
2.17.1

