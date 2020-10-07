Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708462857F7
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 06:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgJGExw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 00:53:52 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:27644 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGExv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 00:53:51 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201007045345epoutp03d4f21d863b119716ee080786155fd3af~7nLx__SjE2996029960epoutp03Y
        for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2020 04:53:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201007045345epoutp03d4f21d863b119716ee080786155fd3af~7nLx__SjE2996029960epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602046425;
        bh=Tknrtmmo23KZdeW9NOVbOK3jQ0tnP8CTz8VDciirNVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HaFC6U49sYD0sX97ChVkc2GAEZPEv9gEuTQpS+fdPv859wpt2Ao9haMOLQBIJeRss
         fZHatXL04XYAJnt3qNZGlzEAuR7Wedr9xWvL8OQKVRFmkisEe8MWIBcNUSjU/48c8F
         nFEiBAC8uVE+FHZbocZwl5hFsWgSaXKOgtGnsqdo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201007045344epcas1p43db206ec32230b6a9b14e52893dbeb74~7nLw29Y3S1244212442epcas1p4T;
        Wed,  7 Oct 2020 04:53:44 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4C5hn23cNVzMqYkj; Wed,  7 Oct
        2020 04:53:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.49.09582.6D94D7F5; Wed,  7 Oct 2020 13:53:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20201007045340epcas1p3b4d0f9187f5330a45d20d9d9b79f1767~7nLtGvelo1699316993epcas1p3c;
        Wed,  7 Oct 2020 04:53:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201007045340epsmtrp14d071d0b376935e8f84c732cb1ce2e1b~7nLtFxSZ61500215002epsmtrp1B;
        Wed,  7 Oct 2020 04:53:40 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-90-5f7d49d6d78b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.99.08745.4D94D7F5; Wed,  7 Oct 2020 13:53:40 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201007045340epsmtip2e53beb7d9227f5e25d97f294e60ce79f~7nLs0zfRE2037420374epsmtip2z;
        Wed,  7 Oct 2020 04:53:40 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     digetx@gmail.com, leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v3 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
Date:   Wed,  7 Oct 2020 14:07:03 +0900
Message-Id: <20201007050703.20759-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201007050703.20759-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmru41z9p4g4bbEhbLLh1ltNg4Yz2r
        xcQbV1gsrn95zmqx+uNjRos1tw8xWvzYcIrZomXWIhaLBZ9msFqcbXrDbrHi7kdWi8u75rBZ
        fO49wmjR+WUWm8XCphZ2i9uNK9gsfu6ax+Ig6LFm3hpGjx13lzB67Jx1l91j06pONo/e5nds
        Hhvf7WDy+DtrP4tH35ZVjB6fN8kFcEZl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
        WpgrKeQl5qbaKrn4BOi6ZeYAPaOkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs
        0CtOzC0uzUvXS87PtTI0MDAyBSpMyM7Yfe0ka8HSmooNNxczNzA+S+5i5OSQEDCRmHD0HWsX
        IxeHkMAORomHbR/YIZxPjBK3prQzQzifGSU+9F5khWl5/G8CG0RiF6PEr9UToPq/MEoc2D+F
        CaSKTUBLYv+LG0BVHBwiApESzScFQWqYBS4yScy9u4IdpEZYIFriwJ3jLCA2i4CqRMOuxWC9
        vAJWEu2/IeISAvISqzccYAaxOQWsJfb/m8QIMkhCYAeHxJdt19ggilwk5u59AmULS7w6voUd
        wpaSeNnfBmVXS6w8eYQNormDUWLL/gtQ/xhL7F86mQnkUmYBTYn1u/QhwooSO3/PZQSxmQX4
        JN597WEFKZEQ4JXoaBOCKFGWuPzgLhOELSmxuL0T6gQPieP7T0HDsQ8YKA/us01glJuFsGEB
        I+MqRrHUguLc9NRiwwJj5DjbxAhOrlrmOxinvf2gd4iRiYPxEKMEB7OSCG+6d028EG9KYmVV
        alF+fFFpTmrxIUZTYOhNZJYSTc4Hpve8knhDUyNjY2MLE0MzU0NDJXHeh7cU4oUE0hNLUrNT
        UwtSi2D6mDg4pRqYiuPcXP4FntjxNF+41vdz7lzngr/7vyQfjv2gJjZFu+3MjRbz7efVakU+
        Pxb8cTRs/e+XpuZRz4Pn5HtK/d7r43ghlvX19pMcPN7P8i0PCxiVRe5+uFOf2Y7zrmDW7pSX
        8zOXpNe9093ya0+A8js+w/k1wi6H5m3+5aZ1plSo/Hdr+5nsNSWqjvW6TB3lbQqXFy3b4CR0
        YfX3iEbbwBzR8oDCXo2j//1OSVnVchYcYqx1LllsuDBu97ci0Y2NkQ2lLyot61c4nFnpWH+V
        j1lx3enXoX5RiSbGjAuV+/p9pkTLH/66dOueR+f3rdM4synSWjPgnOa78rdTV5dNfRgfo5Z1
        J4FvpunriDT7W1+VWIozEg21mIuKEwE1phdlNwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSvO4Vz9p4g2tT5C2WXTrKaLFxxnpW
        i4k3rrBYXP/ynNVi9cfHjBZrbh9itPix4RSzRcusRSwWCz7NYLU42/SG3WLF3Y+sFpd3zWGz
        +Nx7hNGi88ssNouFTS3sFrcbV7BZ/Nw1j8VB0GPNvDWMHjvuLmH02DnrLrvHplWdbB69ze/Y
        PDa+28Hk8XfWfhaPvi2rGD0+b5IL4IzisklJzcksSy3St0vgyth97SRrwdKaig03FzM3MD5L
        7mLk5JAQMJF4/G8CG4gtJLCDUWLvbU+IuKTEtItHmbsYOYBsYYnDh4u7GLmASj4xSlxdeJsd
        pIZNQEti/4sbYL0iAtESiz9+ZAYpYhZ4zCSx/9YVsCJhgUiJ2ZcOghWxCKhKNOxazARi8wpY
        SbT/Ps4CsUxeYvWGA8wgNqeAtcT+f5MYIQ6ykrjWtYt9AiPfAkaGVYySqQXFuem5xYYFRnmp
        5XrFibnFpXnpesn5uZsYwRGgpbWDcc+qD3qHGJk4GA8xSnAwK4nwpnvXxAvxpiRWVqUW5ccX
        leakFh9ilOZgURLn/TprYZyQQHpiSWp2ampBahFMlomDU6qBqWJPC9O5NxdOXbL3fMXIsv+g
        wiz3Ygdtx4bFuqp/ntdV2TByyva7V5lrNj1TnPLt7Qn9mY2yjB5PN7+qFH0jkOuwIaj+y/K1
        r8+mcFRsOPBSIadofUU0a2ITDx/3G7cX2dM2Pu8LnfQuV2tKt/65bVG16tX9z1jV7ULr5lz4
        4m08q/f3x68nengPHj1Sv+nJ9Lux/xtvPJn1MOv3qXlyQc/5Nhmov10bs3r1Vq+PCcmzFhoL
        +D++3HOtZ4ptiNf8vW371jLxNKxct+ZZ8Af5wk3G77oWhbhGGuUlfZbVyP2zQmqTwaZGSb7b
        flz8VpdyQp6W/e17P3GLfetFteJIxpvpU6OWXPrz/czpNQsM/iuxFGckGmoxFxUnAgDBz3wn
        7wIAAA==
X-CMS-MailID: 20201007045340epcas1p3b4d0f9187f5330a45d20d9d9b79f1767
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201007045340epcas1p3b4d0f9187f5330a45d20d9d9b79f1767
References: <20201007050703.20759-1-cw00.choi@samsung.com>
        <CGME20201007045340epcas1p3b4d0f9187f5330a45d20d9d9b79f1767@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DEVFREQ supports the default governors like performance, simple_ondemand and
also allows the devfreq driver to add their own governor like tegra30-devfreq.c
according to their requirement. In result, some sysfs attributes are useful
or not useful. Prior to that the user can access all sysfs attributes
regardless of the available attributes.

So, clarify the access permission of sysfs attributes according to governor.
When adding the devfreq governor, can specify the available attribute
information by using DEVFREQ_GOV_ATTR_* constant variable. The user can
read or write the sysfs attributes in accordance to the specified attributes.

When adding the governor, can add the following attributes
according to the governor feature.

[Definition for speific sysfs attributes]
- DEVFREQ_GOV_ATTR_POLLING_INTERVAL to update polling interval for timer.
  : /sys/class/devfreq/[devfreq dev name]/polling_interval
- DEVFREQ_GOV_ATTR_TIMER to change the type of timer on either deferrable
  or dealyed timer.
  : /sys/class/devfreq/[devfreq dev name]/timer

And all devfreq governors have to support the following common attributes.
The common attributes are added to devfreq class by default.
- governor
- available_governors
- available_frequencies
- cur_freq
- target_freq
- min_freq
- max_freq
- trans_stat

[Table of governor attribute flags for devfreq governors]
------------------------------------------------------------------------------
                      | simple    | perfor | power | user | passive | tegra30
		      | ondemand  | mance  | save  | space|         |
------------------------------------------------------------------------------
governor              | O         | O      | O     | O    | O       | O
available_governors   | O         | O      | O     | O    | O       | O
available_frequencies | O         | O      | O     | O    | O       | O
cur_freq              | O         | O      | O     | O    | O       | O
target_freq           | O         | O      | O     | O    | O       | O
min_freq              | O         | O      | O     | O    | O       | O
max_freq              | O         | O      | O     | O    | O       | O
trans_stat            | O         | O      | O     | O    | O       | O
                      --------------------------------------------------------
polling_interval      | O         | X      | X     | X    | X       | O
timer                 | O         | X      | X     | X    | X       | X
------------------------------------------------------------------------------

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/ABI/testing/sysfs-class-devfreq |  54 +++---
 drivers/devfreq/devfreq.c                     | 154 ++++++++++++------
 drivers/devfreq/governor.h                    |  12 ++
 drivers/devfreq/governor_simpleondemand.c     |   2 +
 drivers/devfreq/tegra30-devfreq.c             |   1 +
 5 files changed, 147 insertions(+), 76 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index deefffb3bbe4..67af3f31e17c 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -37,20 +37,6 @@ Description:
 		The /sys/class/devfreq/.../target_freq shows the next governor
 		predicted target frequency of the corresponding devfreq object.
 
-What:		/sys/class/devfreq/.../polling_interval
-Date:		September 2011
-Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
-Description:
-		The /sys/class/devfreq/.../polling_interval shows and sets
-		the requested polling interval of the corresponding devfreq
-		object. The values are represented in ms. If the value is
-		less than 1 jiffy, it is considered to be 0, which means
-		no polling. This value is meaningless if the governor is
-		not polling; thus. If the governor is not using
-		devfreq-provided central polling
-		(/sys/class/devfreq/.../central_polling is 0), this value
-		may be useless.
-
 What:		/sys/class/devfreq/.../trans_stat
 Date:		October 2012
 Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
@@ -65,14 +51,6 @@ Description:
 		as following:
 			echo 0 > /sys/class/devfreq/.../trans_stat
 
-What:		/sys/class/devfreq/.../userspace/set_freq
-Date:		September 2011
-Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
-Description:
-		The /sys/class/devfreq/.../userspace/set_freq shows and
-		sets the requested frequency for the devfreq object if
-		userspace governor is in effect.
-
 What:		/sys/class/devfreq/.../available_frequencies
 Date:		October 2012
 Contact:	Nishanth Menon <nm@ti.com>
@@ -109,6 +87,35 @@ Description:
 		The max_freq overrides min_freq because max_freq may be
 		used to throttle devices to avoid overheating.
 
+What:		/sys/class/devfreq/.../polling_interval
+Date:		September 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/class/devfreq/.../polling_interval shows and sets
+		the requested polling interval of the corresponding devfreq
+		object. The values are represented in ms. If the value is
+		less than 1 jiffy, it is considered to be 0, which means
+		no polling. This value is meaningless if the governor is
+		not polling; thus. If the governor is not using
+		devfreq-provided central polling
+		(/sys/class/devfreq/.../central_polling is 0), this value
+		may be useless.
+
+		A list of governors that support the node:
+		- simple_ondmenad
+		- tegra_actmon
+
+What:		/sys/class/devfreq/.../userspace/set_freq
+Date:		September 2011
+Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
+Description:
+		The /sys/class/devfreq/.../userspace/set_freq shows and
+		sets the requested frequency for the devfreq object if
+		userspace governor is in effect.
+
+		A list of governors that support the node:
+		- userspace
+
 What:		/sys/class/devfreq/.../timer
 Date:		July 2020
 Contact:	Chanwoo Choi <cw00.choi@samsung.com>
@@ -120,3 +127,6 @@ Description:
 		as following:
 			echo deferrable > /sys/class/devfreq/.../timer
 			echo delayed > /sys/class/devfreq/.../timer
+
+		A list of governors that support the node:
+		- simple_ondemand
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ce793fc9a558..379aaaabf25d 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -32,6 +32,7 @@
 #include <trace/events/devfreq.h>
 
 #define IS_SUPPORTED_FLAG(f, name) ((f & DEVFREQ_GOV_FLAG_##name) ? true : false)
+#define IS_SUPPORTED_ATTR(f, name) ((f & DEVFREQ_GOV_ATTR_##name) ? true : false)
 #define HZ_PER_KHZ	1000
 
 static struct class *devfreq_class;
@@ -538,12 +539,13 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 	unsigned long freq;
 
 	mutex_lock(&devfreq->lock);
-	if (!devfreq->stop_polling)
-		goto out;
 
 	if (IS_SUPPORTED_FLAG(devfreq->governor->flag, IRQ_DRIVEN))
 		goto out_update;
 
+	if (!devfreq->stop_polling)
+		goto out;
+
 	if (!delayed_work_pending(&devfreq->work) &&
 			devfreq->profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
@@ -578,10 +580,10 @@ void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay)
 	mutex_lock(&devfreq->lock);
 	devfreq->profile->polling_ms = new_delay;
 
-	if (devfreq->stop_polling)
+	if (DEVFREQ_GOV_FLAG_IRQ_DRIVEN & devfreq->governor->flag)
 		goto out;
 
-	if (IS_SUPPORTED_FLAG(devfreq->governor->flag, IRQ_DRIVEN))
+	if (devfreq->stop_polling)
 		goto out;
 
 	/* if new delay is zero, stop polling */
@@ -736,6 +738,11 @@ static void devfreq_dev_release(struct device *dev)
 	kfree(devfreq);
 }
 
+static void create_sysfs_files(struct devfreq *devfreq,
+				const struct devfreq_governor *gov);
+static void remove_sysfs_files(struct devfreq *devfreq,
+				const struct devfreq_governor *gov);
+
 /**
  * devfreq_add_device() - Add devfreq feature to the device
  * @dev:	the device to add devfreq feature.
@@ -885,6 +892,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_init;
 	}
 
+	create_sysfs_files(devfreq, governor);
+
 	devfreq->governor = governor;
 	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
 						NULL);
@@ -923,9 +932,12 @@ int devfreq_remove_device(struct devfreq *devfreq)
 	if (!devfreq)
 		return -EINVAL;
 
-	if (devfreq->governor)
+	if (devfreq->governor) {
 		devfreq->governor->event_handler(devfreq,
 						 DEVFREQ_GOV_STOP, NULL);
+		remove_sysfs_files(devfreq, devfreq->governor);
+	}
+
 	device_unregister(&devfreq->dev);
 
 	return 0;
@@ -1361,6 +1373,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 		goto out;
 	}
 
+	remove_sysfs_files(df, df->governor);
+	create_sysfs_files(df, governor);
+
 	prev_governor = df->governor;
 	df->governor = governor;
 	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
@@ -1460,39 +1475,6 @@ static ssize_t target_freq_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(target_freq);
 
-static ssize_t polling_interval_show(struct device *dev,
-				     struct device_attribute *attr, char *buf)
-{
-	struct devfreq *df = to_devfreq(dev);
-
-	if (!df->profile)
-		return -EINVAL;
-
-	return sprintf(buf, "%d\n", df->profile->polling_ms);
-}
-
-static ssize_t polling_interval_store(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf, size_t count)
-{
-	struct devfreq *df = to_devfreq(dev);
-	unsigned int value;
-	int ret;
-
-	if (!df->governor)
-		return -EINVAL;
-
-	ret = sscanf(buf, "%u", &value);
-	if (ret != 1)
-		return -EINVAL;
-
-	df->governor->event_handler(df, DEVFREQ_GOV_UPDATE_INTERVAL, &value);
-	ret = count;
-
-	return ret;
-}
-static DEVICE_ATTR_RW(polling_interval);
-
 static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -1700,6 +1682,53 @@ static ssize_t trans_stat_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(trans_stat);
 
+static struct attribute *devfreq_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_governor.attr,
+	&dev_attr_available_governors.attr,
+	&dev_attr_cur_freq.attr,
+	&dev_attr_available_frequencies.attr,
+	&dev_attr_target_freq.attr,
+	&dev_attr_min_freq.attr,
+	&dev_attr_max_freq.attr,
+	&dev_attr_trans_stat.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(devfreq);
+
+static ssize_t polling_interval_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct devfreq *df = to_devfreq(dev);
+
+	if (!df->profile)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", df->profile->polling_ms);
+}
+
+static ssize_t polling_interval_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct devfreq *df = to_devfreq(dev);
+	unsigned int value;
+	int ret;
+
+	if (!df->governor)
+		return -EINVAL;
+
+	ret = sscanf(buf, "%u", &value);
+	if (ret != 1)
+		return -EINVAL;
+
+	df->governor->event_handler(df, DEVFREQ_GOV_UPDATE_INTERVAL, &value);
+	ret = count;
+
+	return ret;
+}
+static DEVICE_ATTR_RW(polling_interval);
+
 static ssize_t timer_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -1763,21 +1792,34 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(timer);
 
-static struct attribute *devfreq_attrs[] = {
-	&dev_attr_name.attr,
-	&dev_attr_governor.attr,
-	&dev_attr_available_governors.attr,
-	&dev_attr_cur_freq.attr,
-	&dev_attr_available_frequencies.attr,
-	&dev_attr_target_freq.attr,
-	&dev_attr_polling_interval.attr,
-	&dev_attr_min_freq.attr,
-	&dev_attr_max_freq.attr,
-	&dev_attr_trans_stat.attr,
-	&dev_attr_timer.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(devfreq);
+#define CREATE_SYSFS_FILE(df, name)					\
+{									\
+	int ret;							\
+	ret = sysfs_create_file(&df->dev.kobj, &dev_attr_##name.attr);	\
+	if (ret < 0) {							\
+		dev_warn(&df->dev,					\
+			"Unable to create attr(%s)\n", "##name");	\
+	}								\
+}									\
+
+static void create_sysfs_files(struct devfreq *devfreq,
+				const struct devfreq_governor *gov)
+{
+	if (IS_SUPPORTED_ATTR(gov->attr, POLLING_INTERVAL))
+		CREATE_SYSFS_FILE(devfreq, polling_interval);
+	if (IS_SUPPORTED_ATTR(gov->attr, TIMER))
+		CREATE_SYSFS_FILE(devfreq, timer);
+}
+
+static void remove_sysfs_files(struct devfreq *devfreq,
+				const struct devfreq_governor *gov)
+{
+	if (IS_SUPPORTED_ATTR(gov->attr, POLLING_INTERVAL))
+		sysfs_remove_file(&devfreq->dev.kobj,
+				&dev_attr_polling_interval.attr);
+	if (IS_SUPPORTED_ATTR(gov->attr, TIMER))
+		sysfs_remove_file(&devfreq->dev.kobj, &dev_attr_timer.attr);
+}
 
 /**
  * devfreq_summary_show() - Show the summary of the devfreq devices
@@ -1834,8 +1876,12 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
 		mutex_lock(&devfreq->lock);
 		cur_freq = devfreq->previous_freq;
 		get_freq_range(devfreq, &min_freq, &max_freq);
-		polling_ms = devfreq->profile->polling_ms;
 		timer = devfreq->profile->timer;
+
+		if (IS_SUPPORTED_ATTR(devfreq->governor->attr, POLLING_INTERVAL))
+			polling_ms = devfreq->profile->polling_ms;
+		else
+			polling_ms = 0;
 		mutex_unlock(&devfreq->lock);
 
 		seq_printf(s,
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 540e59ef467c..eb6392d397b3 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -35,10 +35,21 @@
 #define DEVFREQ_GOV_FLAG_IMMUTABLE			BIT(0)
 #define DEVFREQ_GOV_FLAG_IRQ_DRIVEN			BIT(1)
 
+/*
+ * Definition of governor attribute flags except for common sysfs attributes
+ * - DEVFREQ_GOV_ATTR_POLLING_INTERVAL
+ *   : Indicate polling_interal sysfs attribute
+ * - DEVFREQ_GOV_ATTR_TIMER
+ *   : Indicate timer sysfs attribute
+ */
+#define DEVFREQ_GOV_ATTR_POLLING_INTERVAL		BIT(0)
+#define DEVFREQ_GOV_ATTR_TIMER				BIT(1)
+
 /**
  * struct devfreq_governor - Devfreq policy governor
  * @node:		list node - contains registered devfreq governors
  * @name:		Governor's name
+ * @attr:		Governor's sysfs attribute flag
  * @flag:		Governor's feature flag
  * @get_target_freq:	Returns desired operating frequency for the device.
  *			Basically, get_target_freq will run
@@ -57,6 +68,7 @@ struct devfreq_governor {
 	struct list_head node;
 
 	const char name[DEVFREQ_NAME_LEN];
+	const u64 attr;
 	const u64 flag;
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 	int (*event_handler)(struct devfreq *devfreq,
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 1b314e1df028..28b7f9d8fb4e 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -117,6 +117,8 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_simple_ondemand = {
 	.name = DEVFREQ_GOV_SIMPLE_ONDEMAND,
+	.attr = DEVFREQ_GOV_ATTR_POLLING_INTERVAL
+		| DEVFREQ_GOV_ATTR_TIMER,
 	.get_target_freq = devfreq_simple_ondemand_func,
 	.event_handler = devfreq_simple_ondemand_handler,
 };
diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 868c72cc0276..150eb70e62db 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -765,6 +765,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor tegra_devfreq_governor = {
 	.name = "tegra_actmon",
+	.attr = DEVFREQ_GOV_ATTR_POLLING_INTERVAL,
 	.flag = DEVFREQ_GOV_FLAG_IMMUTABLE
 		| DEVFREQ_GOV_FLAG_IRQ_DRIVEN,
 	.get_target_freq = tegra_governor_get_target,
-- 
2.17.1

