Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC34116F67
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 15:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfLIOor (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 09:44:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53794 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfLIOoo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 09:44:44 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191209144442euoutp02e5be9bfe2ef5f10a2c87beb1473ca5da~euyPtEQjX2487524875euoutp02n
        for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2019 14:44:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191209144442euoutp02e5be9bfe2ef5f10a2c87beb1473ca5da~euyPtEQjX2487524875euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575902682;
        bh=Yj16QJuX/DQ6hPG7qS0AfAwbCc+kp0oVo/nwlvCOC70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rB550LHdPgCE4dR0N9u6JEYZAT8NZxLr/XEYcSJG/US6jZlZ9y4I1KH9KLeQIIntm
         nGq3vXZk9Pcvedw2u56X7apmbNDB7G2Poh6luLE/PyhNS+phX8ti4ThjK4gm+I1HfG
         atpK4Q4PG5sx2OjpyP9VSdJ3t1ZfSB6qY6RiZ03M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191209144442eucas1p1555f3b5e71ee5101e7e5f8dff43afda1~euyPTTYkP1801118011eucas1p18;
        Mon,  9 Dec 2019 14:44:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8E.28.60698.ADD5EED5; Mon,  9
        Dec 2019 14:44:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191209144441eucas1p2ccd371e5861e8c0a3948cdc6640ad0d5~euyO8HO4V1767717677eucas1p2e;
        Mon,  9 Dec 2019 14:44:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191209144441eusmtrp2ff0dcd4baf345c5881830dbbd9e014d8~euyO7fit42834828348eusmtrp2j;
        Mon,  9 Dec 2019 14:44:41 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-15-5dee5dda6e32
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DA.C9.07950.9DD5EED5; Mon,  9
        Dec 2019 14:44:41 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191209144441eusmtip2c4378d18a7579f554199001e774c7429~euyOhAYgG1467314673eusmtip2K;
        Mon,  9 Dec 2019 14:44:41 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 2/4] PM / devfreq: add possibility for delayed work
Date:   Mon,  9 Dec 2019 15:44:23 +0100
Message-Id: <20191209144425.13321-3-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209144425.13321-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7q3Yt/FGuy4w2yxccZ6VovrX56z
        Wiz4NIPV4vz5DewWZ5vesFtc3jWHzeJz7xFGi7VH7rJb3G5cwebA6bFpVSebR9+WVYwenzfJ
        BTBHcdmkpOZklqUW6dslcGU8nrWUtWClakXPnedsDYwt8l2MnBwSAiYSe+dPZ+9i5OIQEljB
        KNFxbSojhPOFUWLLks2sEM5nRonF9y4zw7QcvfeHEcQWEljOKHFlgTBcx+HVX1lAEmwC+hIH
        z54Es0UEpCU6F01kAiliFjjGJLHr0F9WkISwgLPEhvV/mUBsFgFVifu7P4JN5RWwkVg/4Thb
        FyMH0DZ5iTlvNUDCnAK2Eq8/TmGGKBGUODnzCdh8ZqCS5q2zmUHmSwj0s0vsm7yAFaLXRaKr
        vRbiaGGJV8e3sEPYMhL/d85ngrDLJZ4u7GOH6G1hlHjQ/pEFImEtcfj4RbA5zAKaEut36UOE
        HSUufJ7LCDGeT+LGW0GIE/gkJm2bzgwR5pXoaBOCqFaVeH6qB2qTtETX/3WsELaHxNFny5km
        MCrOQvLMLCTPzELYu4CReRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgojn97/jXHYz7
        /iQdYhTgYFTi4V3g8C5WiDWxrLgy9xCjBAezkgjvkomvYoV4UxIrq1KL8uOLSnNSiw8xSnOw
        KInzGi96GSskkJ5YkpqdmlqQWgSTZeLglGpgbL75bv6B2WJVvuua3n8u+x3w9qpp/oTXr8Pe
        mf498jXtMWPiVKMF8m8WfQ9PnxR7YvbUdVoxy6OD1u4x4FjL2nCJ45GBxiRmj8pZTitYVhxn
        6zUx+h7+9MfMA2kmjQILXH7eWtT8ZvPTRcI3j0oGpBn5Kss1PZQ8/ko5lF8pbVaOjtP57TvZ
        tiixFGckGmoxFxUnAgAYxsPdMAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4Pd2bse9iDS4u0LXYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLs01v2C0u75rDZvG59wijxdojd9ktbjeuYHPg9Ni0qpPNo2/LKkaPz5vk
        Apij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIe
        z1rKWrBStaLnznO2BsYW+S5GTg4JAROJo/f+MILYQgJLGSW27K2AiEtLNJ5ezQRhC0v8udbF
        1sXIBVTziVGi+UADG0iCTUBf4uDZkywgtghQQ+eiiWANzAJnmCR+tYANEhZwltiw/i9YnEVA
        VeL+7o9gy3gFbCTWTzgONIcDaIG8xJy3GiBhTgFbidcfpzBD3GMj0f7/PwtEuaDEyZlPWCDG
        y0s0b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECI2LbsZ9bdjB2
        vQs+xCjAwajEw7vA4V2sEGtiWXFl7iFGCQ5mJRHeJRNfxQrxpiRWVqUW5ccXleakFh9iNAX6
        YSKzlGhyPjBa80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MJYb
        fuNzzTYtEvVUC9lnFrhp4jTPkmPMB9uMd/3Wab7uFDFno62+0u/Ewpgd196fSFHxC4544iu1
        32DjKXuj658SN1mtKK41845e/YLt7qM9VpdXJH2V2ix69+ibLy2sQh0Ts3S4JhvPefWXZ87V
        Bd3KnKpTHka9mf005PCXf/G3Mi8d+n/i9F4lluKMREMt5qLiRACS268ZngIAAA==
X-CMS-MailID: 20191209144441eucas1p2ccd371e5861e8c0a3948cdc6640ad0d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209144441eucas1p2ccd371e5861e8c0a3948cdc6640ad0d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209144441eucas1p2ccd371e5861e8c0a3948cdc6640ad0d5
References: <20191209144425.13321-1-k.konieczny@samsung.com>
        <CGME20191209144441eucas1p2ccd371e5861e8c0a3948cdc6640ad0d5@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Current devfreq workqueue uses deferred timer. Introduce sysfs
file delayed_timer and use it for change from deferred to
delayed work. The default is to use old deferred one, which
saves power, but can miss increased demand for higher bus
frequency if timer was assigned to idle cpu.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 Documentation/ABI/testing/sysfs-class-devfreq | 10 ++++
 drivers/devfreq/devfreq.c                     | 46 ++++++++++++++++++-
 include/linux/devfreq.h                       |  2 +
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index 9758eb85ade3..07bfd0df6a4a 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -30,6 +30,16 @@ Description:
 		target_freq when get_cur_freq() is not implemented by
 		devfreq driver.
 
+What:		/sys/class/devfreq/.../delayed_timer
+Date:		December 2019
+Contact:	Kamil Konieczny <k.konieczny@samsung.com>
+Description:
+		This ABI shows or clears timer type used by devfreq
+		workqueue. When 0, it uses default deferred timer.
+		When set to 1 devfreq will use delayed timer. Example
+		useage:
+			echo 1 > /sys/class/devfreq/.../delayed_timer
+
 What:		/sys/class/devfreq/.../target_freq
 Date:		September 2012
 Contact:	Rajagopal Venkat <rajagopal.venkat@linaro.org>
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 955949c6fc1f..c277d1770fef 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -445,7 +445,11 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 	if (devfreq->governor->interrupt_driven)
 		return;
 
-	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
+	if (devfreq->delayed_timer)
+		INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
+	else
+		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
+
 	if (devfreq->profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
@@ -698,6 +702,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
+	devfreq->delayed_timer = false;
 
 	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
 		mutex_unlock(&devfreq->lock);
@@ -1288,6 +1293,44 @@ static ssize_t available_governors_show(struct device *d,
 }
 static DEVICE_ATTR_RO(available_governors);
 
+static ssize_t delayed_timer_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	int i;
+
+	i = to_devfreq(dev)->delayed_timer ? 1 : 0;
+	return sprintf(buf, "%d\n", i);
+}
+
+static ssize_t delayed_timer_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct devfreq *df = to_devfreq(dev);
+	bool old_timer;
+	int value, ret;
+
+	if (!df->governor)
+		return -EINVAL;
+
+	ret = kstrtoint(buf, 10, &value);
+	if (ret || (value != 1 && value != 0))
+		return -EINVAL;
+
+	mutex_lock(&df->lock);
+	old_timer = df->delayed_timer;
+	df->delayed_timer = value == 0 ? false : true;
+	mutex_unlock(&df->lock);
+
+	if (old_timer != df->delayed_timer) {
+		devfreq_monitor_stop(df);
+		devfreq_monitor_start(df);
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RW(delayed_timer);
+
 static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -1513,6 +1556,7 @@ static struct attribute *devfreq_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_governor.attr,
 	&dev_attr_available_governors.attr,
+	&dev_attr_delayed_timer.attr,
 	&dev_attr_cur_freq.attr,
 	&dev_attr_available_frequencies.attr,
 	&dev_attr_target_freq.attr,
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index de2fdc56aa5b..761aa0a09db7 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -134,6 +134,7 @@ struct devfreq_stats {
  *		reevaluate operable frequencies. Devfreq users may use
  *		devfreq.nb to the corresponding register notifier call chain.
  * @work:	delayed work for load monitoring.
+ * @delayed_timer:	use delayed or deferred timer for workqueue.
  * @previous_freq:	previously configured frequency value.
  * @data:	Private data of the governor. The devfreq framework does not
  *		touch this.
@@ -166,6 +167,7 @@ struct devfreq {
 	char governor_name[DEVFREQ_NAME_LEN];
 	struct notifier_block nb;
 	struct delayed_work work;
+	bool delayed_timer;
 
 	unsigned long previous_freq;
 	struct devfreq_dev_status last_status;
-- 
2.24.0

