Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368AD293352
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 04:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390835AbgJTCu5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 22:50:57 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:16853 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390837AbgJTCu4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 22:50:56 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201020025049epoutp03f4d61ecb03f00b0f27ad40999d1e3f40~-k5J8jBR60794407944epoutp03V
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 02:50:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201020025049epoutp03f4d61ecb03f00b0f27ad40999d1e3f40~-k5J8jBR60794407944epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603162249;
        bh=fs2NY4fwed6432mUalOcT1WPOKKFQz6AAKW/PjerA0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZYvVm6HtjhCvhmEtLY9gnVj1sBb2kuiOfHZ5iHBgqXWXwo4eiJfyFeyKgLpZmEwt
         f861q2pryf64DzWzsLd54vfua7Z509FDQ7UBY2fVqEYxK0m88SeEhC/J7xGhccq2lg
         GObAvi3MrIkqyaNY2Vc3jgGgyVSVkzgpdAc79clY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201020025049epcas1p4de70ea2f5c1d30ab569b77f554027a2b~-k5JZCH1Y3015330153epcas1p4L;
        Tue, 20 Oct 2020 02:50:49 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4CFdRB5kdyzMqYkg; Tue, 20 Oct
        2020 02:50:46 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.2D.09543.6805E8F5; Tue, 20 Oct 2020 11:50:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201020025045epcas1p4b26b6f23e2896c2d661b2cfa93505e21~-k5F9cY6u3014930149epcas1p4B;
        Tue, 20 Oct 2020 02:50:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201020025045epsmtrp2311fbd4f56fed8c67b2987fce8996f64~-k5F8mzAj3248932489epsmtrp2G;
        Tue, 20 Oct 2020 02:50:45 +0000 (GMT)
X-AuditID: b6c32a35-347ff70000002547-ae-5f8e50866666
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.36.08745.5805E8F5; Tue, 20 Oct 2020 11:50:45 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201020025045epsmtip112fadd83561eae938c2d3a2ff3cfe178~-k5FsNWCO0042200422epsmtip1-;
        Tue, 20 Oct 2020 02:50:45 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     digetx@gmail.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v4 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
Date:   Tue, 20 Oct 2020 12:04:07 +0900
Message-Id: <20201020030407.21047-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020030407.21047-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmgW5bQF+8wYx72hbLLh1ltNg4Yz2r
        xcQbV1gsrn95zmqx+uNjRos1tw8xWvzYcIrZomXWIhaLBZ9msFqcbXrDbnF51xw2i8+9Rxgt
        Or/MYrNY2NTCbnG7cQWbxc9d81gcBDzWzFvD6LHj7hJGj52z7rJ7bFrVyebR2/yOzWPjux1M
        Hn9n7Wfx6NuyitHj8ya5AM6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
        xNxUWyUXnwBdt8wcoD+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnF
        pXnpesn5uVaGBgZGpkCFCdkZ62edZyz42MVYcfrZTLYGxqP5XYycHBICJhJTVj5j7mLk4hAS
        2MEocX/TZhaQhJDAJ0aJFcfFIRKfGSV6fjexw3S86L0F1bGLUaLl8H8mCOcLUMf/WUwgVWwC
        WhL7X9xg62Lk4BARiJRoPikIUsMssINJYnfzRUaQGmGBaImPDRPAbBYBVYnZDW1gq3kFrCR6
        lpxhhdgmL7F6wwFmEJtTwFriQ+c/sGUSAis5JG7dnMQMUeQicfzKNjYIW1ji1fEtUKdKSXx+
        txcqXi2x8uQRNojmDkaJLfsvQG0wlti/dDITyKXMApoS63fpQ4QVJXb+ngt2HLMAn8S7rz2s
        ICUSArwSHW1CECXKEpcf3GWCsCUlFrd3Qq3ykFj9aSIjJFD6GCWal85hmsAoNwthwwJGxlWM
        YqkFxbnpqcWGBYbIcbaJEZxStUx3ME58+0HvECMTB+MhRgkOZiUR3gmsffFCvCmJlVWpRfnx
        RaU5qcWHGE2BoTeRWUo0OR+Y1PNK4g1NjYyNjS1MDM1MDQ2VxHn/aHfECwmkJ5akZqemFqQW
        wfQxcXBKNTDtS7Y0OiDMXyCQ/rKFyXfhtMC/B1bMzLM1FoyZ89xv9RGusJuJjl+z6u7cXb1F
        atOaQ4o7q84qufJa3j+zVuiKQVnMf6Xpq7gjjk16Xz1j/7RzoewaFzdymXoeOnliicQkOVuh
        dVPyrFS0j4uc1DNYKBrwVl/5yedF31hZeRt3rtkjEKo4JyHHjn+z13uOtJi8R6GpfffkcrTK
        5SMiVgilTn50Ya2zs1bmY9FjD/b7djRx9LXMXPbBV2Nx66UD0Y9SWrbVi272D2Q4ae458VPE
        6l/GOvZdeUcuCs3uU48JXlCRo8Hk98hq+rHDs9pjxK9tuKvP2a80a3WR/CZNw3fbK0+nhm10
        vJLx5NQHq0VKLMUZiYZazEXFiQATDoArMgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWy7bCSnG5rQF+8walbIhbLLh1ltNg4Yz2r
        xcQbV1gsrn95zmqx+uNjRos1tw8xWvzYcIrZomXWIhaLBZ9msFqcbXrDbnF51xw2i8+9Rxgt
        Or/MYrNY2NTCbnG7cQWbxc9d81gcBDzWzFvD6LHj7hJGj52z7rJ7bFrVyebR2/yOzWPjux1M
        Hn9n7Wfx6NuyitHj8ya5AM4oLpuU1JzMstQifbsEroz1s84zFnzsYqw4/WwmWwPj0fwuRk4O
        CQETiRe9t5i7GLk4hAR2MEpcOHSUDSIhKTHt4lGgBAeQLSxx+HAxRM0nRonWKwuZQGrYBLQk
        9r+4AVYvIhAtsfjjR7BBzAInmCRWf9kFViQsECnx7OFtMJtFQFVidkMbC4jNK2Al0bPkDCvE
        MnmJ1RsOMIPYnALWEh86/4HVCwHVzDx6n20CI98CRoZVjJKpBcW56bnFhgVGeanlesWJucWl
        eel6yfm5mxjBoa+ltYNxz6oPeocYmTgYDzFKcDArifBOYO2LF+JNSaysSi3Kjy8qzUktPsQo
        zcGiJM77ddbCOCGB9MSS1OzU1ILUIpgsEwenVAMTe194Z2jV8+6qfjmXJj3dNbfPV2vlP796
        XYnhY82FdRKrrfNm52jMUr5g0s1ZUHf5TNCKlCtvrZTEFv68Zmh9vvRTueqUS/v0nLYLTX12
        bN+LK/YbqoKfv1Pac/EqX010iEpvvxrH3vyassl7BV5emyGgzpi+I+xF63xGBTvRf780NpX/
        17Ir7D0ue9ovatXx/KNScSrW1nVsa+tyZu9wcHqotYT1/a2d2+J2VTo/+8+yXvr9IWXO9xs5
        X7hlnp7C0s90kXn9SbnEro0hkx4bSwjOnfB4eiJ/9Y2WXQq3U16stq0KVYlKvtvVdCd686qI
        jdMOqUcZ79ycb8q6be/exTkqT8r69h++tmFrSnCPEktxRqKhFnNRcSIAq7vT4ewCAAA=
X-CMS-MailID: 20201020025045epcas1p4b26b6f23e2896c2d661b2cfa93505e21
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201020025045epcas1p4b26b6f23e2896c2d661b2cfa93505e21
References: <20201020030407.21047-1-cw00.choi@samsung.com>
        <CGME20201020025045epcas1p4b26b6f23e2896c2d661b2cfa93505e21@epcas1p4.samsung.com>
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
 Documentation/ABI/testing/sysfs-class-devfreq |  54 +++--
 drivers/devfreq/devfreq.c                     | 192 ++++++++++++------
 drivers/devfreq/governor.h                    |  12 ++
 drivers/devfreq/governor_simpleondemand.c     |   2 +
 drivers/devfreq/tegra30-devfreq.c             |   1 +
 5 files changed, 173 insertions(+), 88 deletions(-)

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
index a862acfe987e..99df27368628 100644
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
@@ -1354,55 +1365,71 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	struct devfreq *df = to_devfreq(dev);
 	int ret;
 	char str_governor[DEVFREQ_NAME_LEN + 1];
-	const struct devfreq_governor *governor, *prev_governor;
+	const struct devfreq_governor *new_governor, *prev_governor;
 
 	if (!df->governor)
 		return -EINVAL;
+	prev_governor = df->governor;
 
 	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
 	if (ret != 1)
 		return -EINVAL;
 
 	mutex_lock(&devfreq_list_lock);
-	governor = try_then_request_governor(str_governor);
-	if (IS_ERR(governor)) {
-		ret = PTR_ERR(governor);
+	new_governor = try_then_request_governor(str_governor);
+	if (IS_ERR(new_governor)) {
+		ret = PTR_ERR(new_governor);
 		goto out;
 	}
-	if (df->governor == governor) {
+	if (prev_governor == new_governor) {
 		ret = 0;
 		goto out;
-	} else if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)
-		|| IS_SUPPORTED_FLAG(governor->flags, IMMUTABLE)) {
+	} else if (IS_SUPPORTED_FLAG(prev_governor->flags, IMMUTABLE)
+		|| IS_SUPPORTED_FLAG(new_governor->flags, IMMUTABLE)) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
+	/*
+	 * Stop the previous governor and remove the specific sysfs files
+	 * which depend on previous governor.
+	 */
+	ret = prev_governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
 	if (ret) {
 		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
-			 __func__, df->governor->name, ret);
+			 __func__, prev_governor->name, ret);
 		goto out;
 	}
 
-	prev_governor = df->governor;
-	df->governor = governor;
-	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
-	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
+	remove_sysfs_files(df, prev_governor);
+
+	/*
+	 * Start the new governor and create the specific sysfs files
+	 * which depend on new governor.
+	 */
+	strncpy(df->governor_name, new_governor->name, DEVFREQ_NAME_LEN);
+	ret = new_governor->event_handler(df, DEVFREQ_GOV_START, NULL);
 	if (ret) {
 		dev_warn(dev, "%s: Governor %s not started(%d)\n",
-			 __func__, df->governor->name, ret);
-		df->governor = prev_governor;
+			 __func__, new_governor->name, ret);
 		strncpy(df->governor_name, prev_governor->name,
 			DEVFREQ_NAME_LEN);
-		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
+
+		/* Restore prev_governor when failed to start new governor */
+		ret = prev_governor->event_handler(df, DEVFREQ_GOV_START, NULL);
 		if (ret) {
 			dev_err(dev,
 				"%s: reverting to Governor %s failed (%d)\n",
 				__func__, df->governor_name, ret);
 			df->governor = NULL;
+			goto out;
 		}
+		create_sysfs_files(df, prev_governor);
+		goto out;
 	}
+	create_sysfs_files(df, new_governor);
+	df->governor = new_governor;
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
+	if (IS_SUPPORTED_ATTR(gov->attr, POLLING_INTERVAL))
+		CREATE_SYSFS_FILE(devfreq, polling_interval);
+	if (IS_SUPPORTED_ATTR(gov->attr, TIMER))
+		CREATE_SYSFS_FILE(devfreq, timer);
+}
+
+/* Remove the specific sysfs files which depend on each governor. */
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
@@ -1858,8 +1914,12 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
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
index 7dbb110a869e..6458fbb58d27 100644
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
  * @flags:		Governor's feature flags
  * @get_target_freq:	Returns desired operating frequency for the device.
  *			Basically, get_target_freq will run
@@ -57,6 +68,7 @@ struct devfreq_governor {
 	struct list_head node;
 
 	const char name[DEVFREQ_NAME_LEN];
+	const u64 attr;
 	const u64 flags;
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
index faa1aecf2a31..83daa8aad30f 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -765,6 +765,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor tegra_devfreq_governor = {
 	.name = "tegra_actmon",
+	.attr = DEVFREQ_GOV_ATTR_POLLING_INTERVAL,
 	.flags = DEVFREQ_GOV_FLAG_IMMUTABLE
 		| DEVFREQ_GOV_FLAG_IRQ_DRIVEN,
 	.get_target_freq = tegra_governor_get_target,
-- 
2.17.1

