Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4132133F3
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 08:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGCGPQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 02:15:16 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:38604 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgGCGPP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 02:15:15 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200703061512epoutp026498bcdfd400e9f9cf720c19056c382c~eKXe6j2ap1768817688epoutp02Z
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 06:15:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200703061512epoutp026498bcdfd400e9f9cf720c19056c382c~eKXe6j2ap1768817688epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593756912;
        bh=6zA3saJZWDxbZePR05fc3Kke1vvfPtAVvqN5x5TNzN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YtxkmN2XIQso3giXlpJlo89PD4ujtnM54BLFbFwrR92/FCuhOJwJdOcXyfwRccHGQ
         OtnHv9kaJVacIdMYuoNJy5ImFASgc0AJJNc7eDlP6rTJMhoMCEqtS6Rd//0zKx4Z5/
         Ksd1WCuth9TU7EU4UdQv8tTu9Gx5Lz3qthYUxkMs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200703061511epcas1p4da0e0bc9366aa9839d715f6a8497e804~eKXemFNHI1204612046epcas1p4G;
        Fri,  3 Jul 2020 06:15:11 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49yl7K4Y9GzMqYmC; Fri,  3 Jul
        2020 06:15:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.BB.18978.DECCEFE5; Fri,  3 Jul 2020 15:15:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200703061509epcas1p10446471df6497b4b2d7066280daa7f87~eKXb3FuJg3028930289epcas1p1u;
        Fri,  3 Jul 2020 06:15:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200703061509epsmtrp12dc0f6d46fabbd39763b26e51209f762~eKXb2PCF32420424204epsmtrp1K;
        Fri,  3 Jul 2020 06:15:09 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-4e-5efecced60fd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.2E.08382.CECCEFE5; Fri,  3 Jul 2020 15:15:08 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200703061508epsmtip1385e0ab38395cb7c30da1819bd506c03~eKXbntD1S1517515175epsmtip1L;
        Fri,  3 Jul 2020 06:15:08 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     lukasz.luba@arm.com, k.konieczny@samsung.com, krzk@kernel.org,
        kgene@kernel.org
Cc:     s.nawrocki@samsung.com, willy.mh.wolff.ml@gmail.com,
        b.zolnierkie@samsung.com, cw00.choi@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 1/2] PM / devfreq: Add support delayed timer for polling
 mode
Date:   Fri,  3 Jul 2020 15:26:21 +0900
Message-Id: <20200703062622.11773-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200703062622.11773-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTV/ftmX9xBt9PKlpsnLGe1WLijSss
        Fte/PGe1WPBpBqtF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFgubWtgt
        bjeuYLM4/Kad1eLbiUeMDvwea+atYfTYOesuu8emVZ1sHpuX1Hv0bVnF6PF5k1wAW1S2TUZq
        YkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QyUoKZYk5pUCh
        gMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7Ix3j+4w
        Fdwzqzg0bRVzA+N3nS5GTg4JAROJB9PXsXUxcnEICexglFg1/S8rhPOJUeLsp4csEM43RokT
        u36zwLQsmNIN1bKXUaJ99gdmCOcLUNWHPYwgVWwCWhL7X9xgA7FFBEIlZt+bClbELLCLSeLL
        tJnMIAlhgWCJzwcaWUFsFgFViZ3rt4A18ApYSbw/+4YRYp28xOoNB8DqOQWsJe703GODiPdy
        SNxZnA9hu0g8+rwS6jxhiVfHt7BD2FISL/vboOxqiZUnj4CdLSHQwSixZf8FVoiEscT+pZOZ
        uhg5gK7TlFi/Sx8irCix8/dcsBuYBfgk3n3tYQUpkRDglehoE4IoUZa4/OAuE4QtKbG4vRPq
        NA+Jv9fuQMOxj1Fi58TXrBMY5WYhbFjAyLiKUSy1oDg3PbXYsMAQOc42MYITpZbpDsaJbz/o
        HWJk4mA8xCjBwawkwpug+i9OiDclsbIqtSg/vqg0J7X4EKMpMPAmMkuJJucDU3VeSbyhqZGx
        sbGFiaGZqaGhkjivuMyFOCGB9MSS1OzU1ILUIpg+Jg5OqQYmw0nlRg8i1EXPvVfXXi50//jr
        GR56PT490UG/XZvVH1uI8cXP6epx3bDi5WpB/rNMITelvk1bMllGKVRtYxivVHVmJce5WJc3
        Frtb1S7lBGnGr1paeir1Twr/7pRPYn97NY3Plvu2HXy2cEr8Kw/WkhWlX88sze4+XLx8l1Ti
        0bT/NmHLjWTOVFp871frnbHCRUAm/aJ2kCDTzCc5fMbL3bR9Pibk13+rFj/+p/Pd0671tfzd
        E23kN8/JjZW++fUXn2nahzuspY+Yyt1k573WmqW3xNXAK3p3YuoDuUe3wjoWM7yaPV1k1Z+F
        Dtonlzm9/VP9RVBqEZ/Zws8Kms9WPCk+E3VJTuZJZuEiuyAlluKMREMt5qLiRAAdRoi6HQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSnO6bM//iDKb+t7bYOGM9q8XEG1dY
        LK5/ec5qseDTDFaL/sevmS3On9/AbnG26Q27xabH11gtLu+aw2bxufcIo8WM8/uYLBY2tbBb
        3G5cwWZx+E07q8W3E48YHfg91sxbw+ixc9Zddo9NqzrZPDYvqffo27KK0ePzJrkAtigum5TU
        nMyy1CJ9uwSujHeP7jAV3DOrODRtFXMD43edLkZODgkBE4kFU7rZuhi5OIQEdjNKnNh6nh0i
        ISkx7eJR5i5GDiBbWOLw4WKImk+MEr86N7KB1LAJaEnsf3EDzBYRiJQ433AUbBCzwDEmieVv
        21lAEsICgRLb579kBLFZBFQldq7fAtbAK2Al8f7sG0aIZfISqzccYAaxOQWsJe703AOrEQKq
        edN5nXECI98CRoZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjB4ayluYNx+6oPeocY
        mTgYDzFKcDArifAmqP6LE+JNSaysSi3Kjy8qzUktPsQozcGiJM57o3BhnJBAemJJanZqakFq
        EUyWiYNTqoFJpJetPXS68e1cWZ7PtxUs1S7yym7/evPSQq3IEyt/PlLN3egdcizrVr2EPt9t
        jQ8238V2eLEXezh3e2zgr9/QkqB35GdaYcmBsFD5dwa+x04VmE6Ryl656mzs5d5Sz/82zBue
        BNx/3CRTlFEYtZdbYXG+yhNNB48opvtBrJLLXmcx26z11K99ZtHQ+85SvHme0XK+Q9dfRL1l
        2tvVyeiQYFpQenHVw69H7+/N2qVwz+7o9NQ/u1++uJR6wiRvItMjhf4Hz3cHaCtHhZZNa6py
        f/3/I+eMQ7+0tjS3npr5Tfd5v0ah2k0H5dnZp9YLz9vUUFK/6XXIzF+Zkvk5m+vPvX88xdDp
        g0nLWYOPx2qVWIozEg21mIuKEwECbdZg1gIAAA==
X-CMS-MailID: 20200703061509epcas1p10446471df6497b4b2d7066280daa7f87
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200703061509epcas1p10446471df6497b4b2d7066280daa7f87
References: <20200703062622.11773-1-cw00.choi@samsung.com>
        <CGME20200703061509epcas1p10446471df6497b4b2d7066280daa7f87@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Until now, the devfreq driver using polling mode like simple_ondemand
governor have used only deferrable timer for reduing the redundant
power consumption. It reduces the CPU wake-up from idle due to polling mode
which check the status of Non-CPU device.

But, it has a problem for Non-CPU device like DMC device with DMA operation.
Some Non-CPU device need to do monitor continously regardless of CPU state
in order to decide the proper next status of Non-CPU device.

So, add support the dealyed timer for polling mode to support
the periodical monitoring. The devfreq driver and user can select
the kind of timer on either deferrable and delayed timer.

For example, change the timer type of DMC device
based on Exynos5422-based Odroid-XU3 as following:

- If want to use deferrable timer as following:
echo deferrable > /sys/class/devfreq/10c20000.memory-controller/timer

- If want to use delayed timer as following:
echo delayed > /sys/class/devfreq/10c20000.memory-controller/timer

Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/ABI/testing/sysfs-class-devfreq | 12 +++
 drivers/devfreq/devfreq.c                     | 83 ++++++++++++++++++-
 include/linux/devfreq.h                       |  9 ++
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index 9758eb85ade3..b10aa3aa230d 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -65,6 +65,18 @@ Description:
 		as following:
 			echo 0 > /sys/class/devfreq/.../trans_stat
 
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
+
 What:		/sys/class/devfreq/.../userspace/set_freq
 Date:		September 2011
 Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 52b9c3e141f3..2a4aa8742520 100644
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
@@ -1625,6 +1645,66 @@ static ssize_t trans_stat_store(struct device *dev,
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
@@ -1636,6 +1716,7 @@ static struct attribute *devfreq_attrs[] = {
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

