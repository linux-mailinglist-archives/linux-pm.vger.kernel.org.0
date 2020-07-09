Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88DC2197FF
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 07:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgGIFds (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 01:33:48 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:21827 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgGIFdq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 01:33:46 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200709053343epoutp049b53fcffa629e862131350d2a9658c7a~f-q_z4wSW1176711767epoutp04x
        for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2020 05:33:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200709053343epoutp049b53fcffa629e862131350d2a9658c7a~f-q_z4wSW1176711767epoutp04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594272823;
        bh=jVppEfmh9bYYsHLPFi/M8mOz2+V2BZCTAqg58JtkmqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuNw6Z9GfA7RyVzoSo5K1htSDGLmmpRAmviLMfQVfncmbSTITUUROUizEw2cayGmo
         sTxQe963wH/xeRs418Jw/+kpDwoRFCNs6L6M7I7M+elfiC7muXCBPeJ/dpMmW7tm5o
         nKFjulGcFy5sRrfW0dAfE/vErzFxoJrI4N6U2qDA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200709053343epcas1p244cff0f7f767c50ca160c774c8707e94~f-q_U5-n-0912409124epcas1p2-;
        Thu,  9 Jul 2020 05:33:43 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4B2Pwh2K7VzMqYm6; Thu,  9 Jul
        2020 05:33:40 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.89.28578.43CA60F5; Thu,  9 Jul 2020 14:33:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200709053339epcas1p10278823f18b4650351f4e6f680d3d4a0~f-q7T7zlE2532625326epcas1p1p;
        Thu,  9 Jul 2020 05:33:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200709053339epsmtrp2278859c062e52c0ca61415a0acfb1948~f-q7S_ht70402704027epsmtrp2R;
        Thu,  9 Jul 2020 05:33:39 +0000 (GMT)
X-AuditID: b6c32a39-e6f5da8000006fa2-bd-5f06ac342e3b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.F6.08303.33CA60F5; Thu,  9 Jul 2020 14:33:39 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200709053339epsmtip1f622ba8ae3db66941e034d765a2420a1~f-q7DFtbv1067810678epsmtip1h;
        Thu,  9 Jul 2020 05:33:39 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     lukasz.luba@arm.com, k.konieczny@samsung.com, krzk@kernel.org,
        kgene@kernel.org
Cc:     s.nawrocki@samsung.com, willy.mh.wolff.ml@gmail.com,
        b.zolnierkie@samsung.com, cw00.choi@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] PM / devfreq: Add support delayed timer for polling
 mode
Date:   Thu,  9 Jul 2020 14:45:03 +0900
Message-Id: <20200709054504.656-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709054504.656-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTT9dkDVu8QcMcfouNM9azWky8cYXF
        4vqX56wWCz7NYLXof/ya2eL8+Q3sFmeb3rBbbHp8jdXi8q45bBafe48wWsw4v4/JYmFTC7vF
        7cYVbBaH37SzWnw78YjRgd9jzbw1jB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi8q2yUhN
        TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6WUmhLDGnFCgU
        kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnfHkTQ9z
        wQbzis/NP9gaGHfrdjFyckgImEh8XTmTuYuRi0NIYAejRNvxh+wgCSGBT4wSHbMVIBKfGSUe
        XzzIBNOx5WgbI0TRLkaJB+9NIIq+MEr8ufkRrJtNQEti/4sbbCC2iECoxOx7U8FWMAvsYpL4
        Mg1kHyeHsECQxI6Df8CmsgioSuyevBlsKq+AhUTjtSlsENvkJVZvOABWzylgKbHlxjRWkEES
        AhM5JKatvMoIUeQi0dv9BOo8YYlXx7ewQ9hSEp/f7YUaVC2x8uQRNojmDkaJLfsvsEIkjCX2
        L50M1MwBdJ6mxPpd+hBhRYmdv+eCzWcW4JN497WHFaREQoBXoqNNCKJEWeLyg7tQayUlFrd3
        Qq3ykLi59ycLJFR6GCVeLm9jnsAoNwthwwJGxlWMYqkFxbnpqcWGBabIUbaJEZwmtSx3ME5/
        +0HvECMTB+MhRgkOZiURXgNF1ngh3pTEyqrUovz4otKc1OJDjKbA0JvILCWanA9M1Hkl8Yam
        RsbGxhYmhmamhoZK4ryfFrDFCwmkJ5akZqemFqQWwfQxcXBKNTDNNKg+t2rynq4bTx7tfDRF
        KIJ7EwvvxdWtyy4pfBf6UaxzZ46Crk7ypppNVo8f7EhKdROPOXD1bfOmjd1xygf/qki4nBf6
        mracZ9+TVp5Se6HShUZqKSb3ev2WAwOL60Gywd3oE6WM1WsDRcwS+P339on3tFYZx+v+5pjk
        5Ls46DmDssCOX2qGG475WPDLeqk/dSlYL/iIoWZ27OUpuq8X9rjPzpm3Yy7LCXWX1/87bmlI
        Tcyrn/JXfU10U0fvhtW/dPctV3hpcl3rTIrzRaU3H9ibHLKrzkokSE3kX7WP34db2e3OwczT
        7hpHX4SftY0OT07+dqGu8q+B7SKWSeJNpdeihZdF6T40kDz5WomlOCPRUIu5qDgRAKmIjZAc
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSnK7xGrZ4g61bjSw2zljPajHxxhUW
        i+tfnrNaLPg0g9Wi//FrZovz5zewW5xtesNusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewW
        txtXsFkcftPOavHtxCNGB36PNfPWMHrsnHWX3WPTqk42j81L6j36tqxi9Pi8SS6ALYrLJiU1
        J7MstUjfLoEr48mbHuaCDeYVn5t/sDUw7tbtYuTkkBAwkdhytI2xi5GLQ0hgB6PEw1eT2SES
        khLTLh5l7mLkALKFJQ4fLgYJCwl8YpTo6vABsdkEtCT2v7jBBmKLCERKnG84ygYyh1ngGJPE
        8rftLCAJYYEAiS97f4AVsQioSuyevJkRxOYVsJBovDaFDWKXvMTqDQeYQWxOAUuJLTemsUIs
        s5BYP20x6wRGvgWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKDWUtrB+OeVR/0
        DjEycTAeYpTgYFYS4TVQZI0X4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvt11sI4IYH0xJLU7NTU
        gtQimCwTB6dUA9Ok/0YHF67anKcUpPlfuST8L1vEi2kmR6cfiVkas5xTRcH2PVunb+R0d5cQ
        95j4V68r7k2resNTfyH60vt1zAZ1XxifpXy+xzXzQ/lqOcYDkyx7MxI++5+L3zDN4Yr+JtuL
        vg8lUx71/9SY7nPz38uf+WfUpV9V1wZve/u4mpGLyypJp6cwp+X72oNuU8O+GUyJDVTn9jx1
        65xMfkT2wYdpW5vcVqwvkvOJPcs9ebdvnaby1KesX+Oq/m9p9b/X5Ky0dNpSg69yU66XNP3r
        aizr+KV5cscvvl1rrZR3yJ5eJJKdztr4bWH3Qk1t8SfOJw3usQm9irs6W0N7y5OVzq78nGrr
        WLxMHA/cnbtt6iclluKMREMt5qLiRABPWQZr1QIAAA==
X-CMS-MailID: 20200709053339epcas1p10278823f18b4650351f4e6f680d3d4a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200709053339epcas1p10278823f18b4650351f4e6f680d3d4a0
References: <20200709054504.656-1-cw00.choi@samsung.com>
        <CGME20200709053339epcas1p10278823f18b4650351f4e6f680d3d4a0@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Until now, the devfreq driver using polling mode like simple_ondemand
governor have used only deferrable timer for reducing the redundant
power consumption. It reduces the CPU wake-up from idle due to polling mode
which check the status of Non-CPU device.

But, it has a problem for Non-CPU device like DMC device with DMA operation.
Some Non-CPU device need to do monitor continuously regardless of CPU state
in order to decide the proper next status of Non-CPU device.

So, add support the delayed timer for polling mode to support
the repetitive monitoring. The devfreq driver and user can select
the kind of timer on either deferrable and delayed timer.

For example, change the timer type of DMC device
based on Exynos5422-based Odroid-XU3 as following:

- If want to use deferrable timer as following:
echo deferrable > /sys/class/devfreq/10c20000.memory-controller/timer

- If want to use delayed timer as following:
echo delayed > /sys/class/devfreq/10c20000.memory-controller/timer

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/ABI/testing/sysfs-class-devfreq | 12 +++
 drivers/devfreq/devfreq.c                     | 86 ++++++++++++++++++-
 include/linux/devfreq.h                       |  9 ++
 3 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index 9758eb85ade3..deefffb3bbe4 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -108,3 +108,15 @@ Description:
 		frequency requested by governors and min_freq.
 		The max_freq overrides min_freq because max_freq may be
 		used to throttle devices to avoid overheating.
+
+What:		/sys/class/devfreq/.../timer
+Date:		July 2020
+Contact:	Chanwoo Choi <cw00.choi@samsung.com>
+Description:
+		This ABI shows and stores the kind of work timer by users.
+		This work timer is used by devfreq workqueue in order to
+		monitor the device status such as utilization. The user
+		can change the work timer on runtime according to their demand
+		as following:
+			echo deferrable > /sys/class/devfreq/.../timer
+			echo delayed > /sys/class/devfreq/.../timer
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 52b9c3e141f3..10f1543df84b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -49,6 +49,11 @@ static LIST_HEAD(devfreq_governor_list);
 static LIST_HEAD(devfreq_list);
 static DEFINE_MUTEX(devfreq_list_lock);
 
+static const char timer_name[][DEVFREQ_NAME_LEN] = {
+	[DEVFREQ_TIMER_DEFERRABLE] = { "deferrable" },
+	[DEVFREQ_TIMER_DELAYED] = { "delayed" },
+};
+
 /**
  * find_device_devfreq() - find devfreq struct using device pointer
  * @dev:	device pointer used to lookup device devfreq.
@@ -454,7 +459,17 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 	if (devfreq->governor->interrupt_driven)
 		return;
 
-	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
+	switch (devfreq->profile->timer) {
+	case DEVFREQ_TIMER_DEFERRABLE:
+		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
+		break;
+	case DEVFREQ_TIMER_DELAYED:
+		INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
+		break;
+	default:
+		return;
+	}
+
 	if (devfreq->profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
@@ -771,6 +786,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
 
+	if (devfreq->profile->timer < 0
+		|| devfreq->profile->timer >= DEVFREQ_TIMER_NUM) {
+		goto err_out;
+	}
+
 	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
 		mutex_unlock(&devfreq->lock);
 		err = set_freq_table(devfreq);
@@ -1625,6 +1645,69 @@ static ssize_t trans_stat_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(trans_stat);
 
+static ssize_t timer_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct devfreq *df = to_devfreq(dev);
+
+	if (!df->governor)
+		return -EINVAL;
+
+	return sprintf(buf, "%s\n", timer_name[df->profile->timer]);
+}
+
+static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct devfreq *df = to_devfreq(dev);
+	char str_timer[DEVFREQ_NAME_LEN + 1];
+	int timer = -1;
+	int ret = 0, i;
+
+	if (!df->governor)
+		return -EINVAL;
+
+	ret = sscanf(buf, "%16s", str_timer);
+	if (ret != 1)
+		return -EINVAL;
+
+	for (i = 0; i < DEVFREQ_TIMER_NUM; i++) {
+		if (!strncmp(timer_name[i], str_timer, DEVFREQ_NAME_LEN)) {
+			timer = i;
+			break;
+		}
+	}
+
+	if (timer < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (df->profile->timer == timer) {
+		ret = 0;
+		goto out;
+	}
+
+	mutex_lock(&df->lock);
+	df->profile->timer = timer;
+	mutex_unlock(&df->lock);
+
+	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
+	if (ret) {
+		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
+			 __func__, df->governor->name, ret);
+		goto out;
+	}
+
+	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
+	if (ret)
+		dev_warn(dev, "%s: Governor %s not started(%d)\n",
+			 __func__, df->governor->name, ret);
+out:
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_RW(timer);
+
 static struct attribute *devfreq_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_governor.attr,
@@ -1636,6 +1719,7 @@ static struct attribute *devfreq_attrs[] = {
 	&dev_attr_min_freq.attr,
 	&dev_attr_max_freq.attr,
 	&dev_attr_trans_stat.attr,
+	&dev_attr_timer.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(devfreq);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 57e871a559a9..12782fbb4c25 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -31,6 +31,13 @@
 #define	DEVFREQ_PRECHANGE		(0)
 #define DEVFREQ_POSTCHANGE		(1)
 
+/* DEVFREQ work timers */
+enum devfreq_timer {
+	DEVFREQ_TIMER_DEFERRABLE = 0,
+	DEVFREQ_TIMER_DELAYED,
+	DEVFREQ_TIMER_NUM,
+};
+
 struct devfreq;
 struct devfreq_governor;
 
@@ -70,6 +77,7 @@ struct devfreq_dev_status {
  * @initial_freq:	The operating frequency when devfreq_add_device() is
  *			called.
  * @polling_ms:		The polling interval in ms. 0 disables polling.
+ * @timer:		Timer type is either deferrable or delayed timer.
  * @target:		The device should set its operating frequency at
  *			freq or lowest-upper-than-freq value. If freq is
  *			higher than any operable frequency, set maximum.
@@ -96,6 +104,7 @@ struct devfreq_dev_status {
 struct devfreq_dev_profile {
 	unsigned long initial_freq;
 	unsigned int polling_ms;
+	enum devfreq_timer timer;
 
 	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
 	int (*get_dev_status)(struct device *dev,
-- 
2.17.1

