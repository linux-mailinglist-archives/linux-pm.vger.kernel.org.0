Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CB9296C88
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 12:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461849AbgJWKMz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 06:12:55 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:54473 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461948AbgJWKMy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 06:12:54 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201023101250epoutp0462ba6ebbd81c4989eb18fa5a1f0f2dc2~Al28SP7wS2695326953epoutp04O
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 10:12:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201023101250epoutp0462ba6ebbd81c4989eb18fa5a1f0f2dc2~Al28SP7wS2695326953epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603447970;
        bh=6gXrFAPQsjO5xq6j5mn2SaU5gNy4LLhcIjmZy2Fgfvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XfB5vA2w5cYOiWhF/GE3VY3gFN89JjjyRSiK3Cd2lwk4M7O8ZTXjGNSdxaP6TqbXU
         HH//yEosj/cNXgDVaVwlnMNxRemRxUP5RMDsfDssn2rHu8t8kRdtufBI8DXwEroRND
         LpORWhfj5+YSfKqYWXGMkgn5455TB7BexfqrJWqI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201023101250epcas1p2e2e208e5764ee1a2e4926bb77fc34389~Al27y4HPi1811318113epcas1p2s;
        Fri, 23 Oct 2020 10:12:50 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CHg5q33yZzMqYlh; Fri, 23 Oct
        2020 10:12:47 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.B1.09577.F9CA29F5; Fri, 23 Oct 2020 19:12:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201023101247epcas1p14b14dc1be24842daac1dc7bd229d4570~Al249SKB61547715477epcas1p1t;
        Fri, 23 Oct 2020 10:12:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201023101247epsmtrp227052476d5f86bf27247a5200bcfb85d~Al248RZVs0815808158epsmtrp2J;
        Fri, 23 Oct 2020 10:12:47 +0000 (GMT)
X-AuditID: b6c32a39-bfdff70000002569-86-5f92ac9ff7c3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.F9.08745.E9CA29F5; Fri, 23 Oct 2020 19:12:46 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201023101246epsmtip2684d7471894e929f7ddc85f646e1750e~Al24nHIbc2824028240epsmtip23;
        Fri, 23 Oct 2020 10:12:46 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     digetx@gmail.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v5 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
Date:   Fri, 23 Oct 2020 19:26:32 +0900
Message-Id: <20201023102632.740-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023102632.740-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmnu78NZPiDW4vFLFYdukoo8XGGetZ
        LSbeuMJicf3Lc1aL1R8fM1qsuX2I0eLHhlPMFi2zFrFYLPg0g9XibNMbdovLu+awWXzuPcJo
        0fllFpvFwqYWdovbjSvYLH7umsfiIOCxZt4aRo8dd5cweuycdZfdY9OqTjaP3uZ3bB4b3+1g
        8vg7az+LR9+WVYwenzfJBXBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynk
        Jeam2iq5+AToumXmAP2hpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNArTswt
        Ls1L10vOz7UyNDAwMgUqTMjOuHjoAFPBmfqKDzd/szYwTkjrYuTkkBAwkdhxYx1bFyMXh5DA
        DkaJ3w9OMEM4nxgl/r5cBuV8ZpTYe+s4C0zLr2PtLBCJXYwSncs/sEM4XxgltvybyA5SxSag
        JbH/xQ2gwRwcIgKREs0nBUFqmAV2MEnsbr7ICBIXFoiWmL00GKScRUBV4sTi5UwgYV4BC4mT
        Z40gdslLrN5wgBnE5hSwlHhzZBLYXgmBtRwSey9tZYYocpHYuriREcIWlnh1fAs7hC0l8fnd
        XjYIu1pi5ckjbBDNHUB37r/ACpEwlti/dDLYYmYBTYn1u/QhwooSO3/PBZvJLMAn8e5rDytI
        iYQAr0RHmxBEibLE5Qd3mSBsSYnF7Z1sECUeErsmxYCEhQR6GCUO/SyewCg3C2H+AkbGVYxi
        qQXFuempxYYFpsjxtYkRnEq1LHcwTn/7Qe8QIxMH4yFGCQ5mJRHe3eoT44V4UxIrq1KL8uOL
        SnNSiw8xmgKDbiKzlGhyPjCZ55XEG5oaGRsbW5gYmpkaGiqJ8/7R7ogXEkhPLEnNTk0tSC2C
        6WPi4JRqYOILK72w9/FJvp7KUK4Fl0+rHpsbsXb2TKGJYv7eU0rmWt3OZ1X98ah9qa+BKeui
        Zr7IY96Sn8/aKdsrzTbKWtbZwxgnLZ8n814rbXNG0NyNsdzfc/eZnJ+7/JfB+bnBfyo6GLY/
        faxS9ODGP9Xw2LuGEes5AmVuNaxKC9tYbhFizcWTL7OpdO2dhKn7z8y0tmz7ldc44ZvFXE7t
        CRP+GfXm9andaU+TkV/ydsLnrwG8ZZe7/krZ//ytJ+lkzysdpJLUc0pAjse0T9rJ6VTFkzWT
        A6c7l61OVdDLKjQ8/sfEqtW737pl6YbXDHwh9y2PiIfpTX7aKV23y+lqtdmXbdZHl2x2Dq99
        KL2TSz1fiaU4I9FQi7moOBEATd5M0y4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSvO68NZPiDSbfMbNYdukoo8XGGetZ
        LSbeuMJicf3Lc1aL1R8fM1qsuX2I0eLHhlPMFi2zFrFYLPg0g9XibNMbdovLu+awWXzuPcJo
        0fllFpvFwqYWdovbjSvYLH7umsfiIOCxZt4aRo8dd5cweuycdZfdY9OqTjaP3uZ3bB4b3+1g
        8vg7az+LR9+WVYwenzfJBXBGcdmkpOZklqUW6dslcGVcPHSAqeBMfcWHm79ZGxgnpHUxcnJI
        CJhI/DrWztLFyMUhJLCDUaJh5lomiISkxLSLR5m7GDmAbGGJw4eLIWo+MUoc7jvKDlLDJqAl
        sf/FDTYQW0QgWmLxx4/MIEXMAieYJFZ/2QU2SFggUmLSu8WsIDaLgKrEicXLmUCG8gpYSJw8
        awSxS15i9YYDzCA2p4ClxJsjk1hAbCGgkvu92xknMPItYGRYxSiZWlCcm55bbFhglJdarlec
        mFtcmpeul5yfu4kRHPZaWjsY96z6oHeIkYmD8RCjBAezkgjvbvWJ8UK8KYmVValF+fFFpTmp
        xYcYpTlYlMR5v85aGCckkJ5YkpqdmlqQWgSTZeLglGpgsgkIv2ypt9Xuu4f1L9FtN04rSFzY
        tHWd5hPl3Eu22xtveRf+YZnCsdCbWyriAu+Rtb+Z8y4cy5C2ufzEIkfkavStE3uzGtKmMak3
        MUgeann75azPGv+pddM5cgs+8IvKGXX9kplrOD2ENdX1/8GFF6/xr/Y+om7v856xKX/17/T1
        rGJ1swtEH8x6dff138h9xyYYrDLZm7bCUjdQ3kEjIfvkIYbVvYZLAmekLfAPsprFtyRl/XJv
        08l3i41meEyVt4gSnfCV+7hRdX6z791DaaV73d+m5R/quzS1Smta/p3ruydrb/1umrlO6km0
        4Guul75LPvoKLbepyJQMdetJ2v3+ynK/2D1aeq9e5ta+UGIpzkg01GIuKk4EAMhD8e3qAgAA
X-CMS-MailID: 20201023101247epcas1p14b14dc1be24842daac1dc7bd229d4570
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201023101247epcas1p14b14dc1be24842daac1dc7bd229d4570
References: <20201023102632.740-1-cw00.choi@samsung.com>
        <CGME20201023101247epcas1p14b14dc1be24842daac1dc7bd229d4570@epcas1p1.samsung.com>
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
 drivers/devfreq/devfreq.c                     | 160 ++++++++++++------
 drivers/devfreq/governor.h                    |  12 ++
 drivers/devfreq/governor_simpleondemand.c     |   2 +
 drivers/devfreq/tegra30-devfreq.c             |   1 +
 5 files changed, 157 insertions(+), 72 deletions(-)

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
index a862acfe987e..f6c55cf498ed 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -32,6 +32,7 @@
 #include <trace/events/devfreq.h>
 
 #define IS_SUPPORTED_FLAG(f, name) ((f & DEVFREQ_GOV_FLAG_##name) ? true : false)
+#define IS_SUPPORTED_ATTR(f, name) ((f & DEVFREQ_GOV_ATTR_##name) ? true : false)
 #define HZ_PER_KHZ	1000
 
 static struct class *devfreq_class;
@@ -760,6 +761,11 @@ static void devfreq_dev_release(struct device *dev)
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
@@ -909,6 +915,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_init;
 	}
 
+	create_sysfs_files(devfreq, governor);
+
 	devfreq->governor = governor;
 	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
 						NULL);
@@ -947,9 +955,12 @@ int devfreq_remove_device(struct devfreq *devfreq)
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
@@ -1378,13 +1389,22 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 		goto out;
 	}
 
+	/*
+	 * Stop the current governor and remove the specific sysfs files
+	 * which depend on current governor.
+	 */
 	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
 	if (ret) {
 		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
 			 __func__, df->governor->name, ret);
 		goto out;
 	}
+	remove_sysfs_files(df, df->governor);
 
+	/*
+	 * Start the new governor and create the specific sysfs files
+	 * which depend on new governor.
+	 */
 	prev_governor = df->governor;
 	df->governor = governor;
 	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
@@ -1392,6 +1412,8 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (ret) {
 		dev_warn(dev, "%s: Governor %s not started(%d)\n",
 			 __func__, df->governor->name, ret);
+
+		/* Restore previous governor */
 		df->governor = prev_governor;
 		strncpy(df->governor_name, prev_governor->name,
 			DEVFREQ_NAME_LEN);
@@ -1401,8 +1423,13 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 				"%s: reverting to Governor %s failed (%d)\n",
 				__func__, df->governor_name, ret);
 			df->governor = NULL;
+			goto out;
 		}
+		create_sysfs_files(df, df->governor);
+		goto out;
 	}
+	create_sysfs_files(df, df->governor);
+
 out:
 	mutex_unlock(&devfreq_list_lock);
 
@@ -1484,39 +1511,6 @@ static ssize_t target_freq_show(struct device *dev,
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
@@ -1724,6 +1718,53 @@ static ssize_t trans_stat_store(struct device *dev,
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
@@ -1787,21 +1828,36 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
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
+/* Create the specific sysfs files which depend on each governor. */
+static void create_sysfs_files(struct devfreq *devfreq,
+				const struct devfreq_governor *gov)
+{
+	if (IS_SUPPORTED_ATTR(gov->attrs, POLLING_INTERVAL))
+		CREATE_SYSFS_FILE(devfreq, polling_interval);
+	if (IS_SUPPORTED_ATTR(gov->attrs, TIMER))
+		CREATE_SYSFS_FILE(devfreq, timer);
+}
+
+/* Remove the specific sysfs files which depend on each governor. */
+static void remove_sysfs_files(struct devfreq *devfreq,
+				const struct devfreq_governor *gov)
+{
+	if (IS_SUPPORTED_ATTR(gov->attrs, POLLING_INTERVAL))
+		sysfs_remove_file(&devfreq->dev.kobj,
+				&dev_attr_polling_interval.attr);
+	if (IS_SUPPORTED_ATTR(gov->attrs, TIMER))
+		sysfs_remove_file(&devfreq->dev.kobj, &dev_attr_timer.attr);
+}
 
 /**
  * devfreq_summary_show() - Show the summary of the devfreq devices
@@ -1858,8 +1914,12 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
 		mutex_lock(&devfreq->lock);
 		cur_freq = devfreq->previous_freq;
 		get_freq_range(devfreq, &min_freq, &max_freq);
-		polling_ms = devfreq->profile->polling_ms;
 		timer = devfreq->profile->timer;
+
+		if (IS_SUPPORTED_ATTR(devfreq->governor->attrs, POLLING_INTERVAL))
+			polling_ms = devfreq->profile->polling_ms;
+		else
+			polling_ms = 0;
 		mutex_unlock(&devfreq->lock);
 
 		seq_printf(s,
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 7dbb110a869e..df413b851bb2 100644
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
+ * @attrs:		Governor's sysfs attribute flags
  * @flags:		Governor's feature flags
  * @get_target_freq:	Returns desired operating frequency for the device.
  *			Basically, get_target_freq will run
@@ -57,6 +68,7 @@ struct devfreq_governor {
 	struct list_head node;
 
 	const char name[DEVFREQ_NAME_LEN];
+	const u64 attrs;
 	const u64 flags;
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 	int (*event_handler)(struct devfreq *devfreq,
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 1b314e1df028..d57b82a2b570 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -117,6 +117,8 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_simple_ondemand = {
 	.name = DEVFREQ_GOV_SIMPLE_ONDEMAND,
+	.attrs = DEVFREQ_GOV_ATTR_POLLING_INTERVAL
+		| DEVFREQ_GOV_ATTR_TIMER,
 	.get_target_freq = devfreq_simple_ondemand_func,
 	.event_handler = devfreq_simple_ondemand_handler,
 };
diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index faa1aecf2a31..8f5b60bef336 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -765,6 +765,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor tegra_devfreq_governor = {
 	.name = "tegra_actmon",
+	.attrs = DEVFREQ_GOV_ATTR_POLLING_INTERVAL,
 	.flags = DEVFREQ_GOV_FLAG_IMMUTABLE
 		| DEVFREQ_GOV_FLAG_IRQ_DRIVEN,
 	.get_target_freq = tegra_governor_get_target,
-- 
2.17.1

