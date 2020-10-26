Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05785298596
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 03:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421469AbgJZChH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 22:37:07 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:58752 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421452AbgJZChE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 22:37:04 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201026023658epoutp0342c3c45002c2933abceec36c9fdb429f~BakxusV5R0433804338epoutp03T
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 02:36:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201026023658epoutp0342c3c45002c2933abceec36c9fdb429f~BakxusV5R0433804338epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603679818;
        bh=A0B1IPBdUkIpmYQd4wY9aNy1Q/pVbIRp9CPjHPOy1OA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvp9bkQCmzFCMc4Ym8ohN1Vz8aWgrt15mSGb/s3s+OK6NO/v4+2TxvdmbphYPD7Fd
         a7TD5xKPu2q2A2Zk7LzENTAgqrVUszKnYE+l/PvsmkiZnEVqq9aSa+IYYMCdl0w1IV
         ubqmjj0xpjjgxCcK4HkX25lLpSGAMoshFyR/E43k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201026023657epcas1p24ae20da0b5f22ba465af8a0cce5071f2~BakwmOLPw2789227892epcas1p2i;
        Mon, 26 Oct 2020 02:36:57 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CKJrR3Sf1zMqYkj; Mon, 26 Oct
        2020 02:36:55 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.2B.09543.746369F5; Mon, 26 Oct 2020 11:36:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201026023655epcas1p1abc7a1281b15a8b56399f3a694afceb4~BakuNYLtT1931919319epcas1p1P;
        Mon, 26 Oct 2020 02:36:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201026023655epsmtrp1af85adf514beb8aeb3cfab4c5b8a613e~BakuMirSX2098820988epsmtrp1R;
        Mon, 26 Oct 2020 02:36:55 +0000 (GMT)
X-AuditID: b6c32a35-347ff70000002547-74-5f963647be3e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.A3.08745.646369F5; Mon, 26 Oct 2020 11:36:54 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201026023654epsmtip2f2cfe7abf43b02380f4e9a8632fe8c0f~Bakt2i79b0577405774epsmtip2J;
        Mon, 26 Oct 2020 02:36:54 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     digetx@gmail.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v6 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
Date:   Mon, 26 Oct 2020 11:50:38 +0900
Message-Id: <20201026025038.1480-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026025038.1480-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmga672bR4g+ZrEhbLLh1ltNg4Yz2r
        xcQbV1gsrn95zmqx+uNjRos1tw8xWvzYcIrZomXWIhaLBZ9msFqcbXrDbnF51xw2i8+9Rxgt
        Or/MYrNY2NTCbnG7cQWbxc9d81gcBDzWzFvD6LHj7hJGj52z7rJ7bFrVyebR2/yOzWPjux1M
        Hn9n7Wfx6NuyitHj8ya5AM6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
        xNxUWyUXnwBdt8wcoD+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnF
        pXnpesn5uVaGBgZGpkCFCdkZv188Zi143sBYsb/1BHMDY096FyMnh4SAicSfOzuZuhi5OIQE
        djBKNO1sYIZwPjFKtF1eC+V8ZpSYcuoDM0zL7m8XWCASuxglpl+azAbhfGGU+LnlBRtIFZuA
        lsT+FzeAbA4OEYFIieaTgiA1zAI7mCR2N19kBKkRFoiWOP1zMZjNIqAqsfnZeXYQm1fAUmLO
        iiMsENvkJVZvOAC2mVPASmL/hx9gJ0kIrOWQuHZ9J1SRi8TbbaeZIGxhiVfHt7BD2FISL/vb
        oOxqiZUnj7BBNHcwSmzZf4EVImEssX/pZCaQS5kFNCXW79KHCCtK7Pw9F+w4ZgE+iXdfe1hB
        SiQEeCU62oQgSpQlLj+4C7VWUmJxeycbhO0hMXP5HmgI9TJKNF/azziBUW4WwoYFjIyrGMVS
        C4pz01OLDQsMkSNtEyM4qWqZ7mCc+PaD3iFGJg7GQ4wSHMxKIrxzZKbGC/GmJFZWpRblxxeV
        5qQWH2I0BYbeRGYp0eR8YFrPK4k3NDUyNja2MDE0MzU0VBLn/aPdES8kkJ5YkpqdmlqQWgTT
        x8TBKdXAFLy1Tv/DQpekhxsNWrbc6S1RLUrN2t4WxVWslN9n93DXG5aVN+4c0ZJgn/FANWmy
        +q02PgZ5+wsXXBT2ry/f/EHIIcfg5omAz1z3e5dG6ineKr3FpLL+TcHZs61l5c3f97zqfm0T
        8/17vo0ce9g1W8cj57WSvMKfP98rH788bp3zyqJ78bvCubJ7C49kl68umL9bLfHC2ir2VNn7
        0y0Tk2yMk5x1vTX2hJzbEXRg+jaXGKHZLY7nbssy/HvXF5g62fzMo7BloiuUzj+I9qnkYKo5
        u+iQyDft7/yClqvXJ8WcPx1rciFxb4/7+Z+3/39TXpAc+nniDrO+07af6oymN2exr3/x02xj
        48ri/srNSizFGYmGWsxFxYkAnbe8CDMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSvK6b2bR4g72HzCyWXTrKaLFxxnpW
        i4k3rrBYXP/ynNVi9cfHjBZrbh9itPix4RSzRcusRSwWCz7NYLU42/SG3eLyrjlsFp97jzBa
        dH6ZxWaxsKmF3eJ24wo2i5+75rE4CHismbeG0WPH3SWMHjtn3WX32LSqk82jt/kdm8fGdzuY
        PP7O2s/i0bdlFaPH501yAZxRXDYpqTmZZalF+nYJXBm/XzxmLXjewFixv/UEcwNjT3oXIyeH
        hICJxO5vF1i6GLk4hAR2MEpcmHqNCSIhKTHt4lHmLkYOIFtY4vDhYoiaT4wSe35NYwGpYRPQ
        ktj/4gYbiC0iEC2x+ONHZpAiZoETTBKrv+xiAmkWFoiUOP+ZC6SGRUBVYvOz8+wgNq+ApcSc
        FUdYIHbJS6zecIAZxOYUsJLY/+EHmC0EVDOhcRnzBEa+BYwMqxglUwuKc9Nziw0LjPJSy/WK
        E3OLS/PS9ZLzczcxggNfS2sH455VH/QOMTJxMB5ilOBgVhLhnSMzNV6INyWxsiq1KD++qDQn
        tfgQozQHi5I479dZC+OEBNITS1KzU1MLUotgskwcnFINTHo5x7Z+SFVe5+5qc6I/rc3jv6Cl
        Z5uJX/4Zy4BuO85VtWp/mZRzGH5MvHpt78cwlaNRF9fu3qYz8WfOa+eTT4JF3RMuHTSRsa68
        KrRC9WHrG+6Hvy1kvZ4qJK1lKV7J/UA3Xdr5wpp77z1PbQmYdGTvlJ17so3uF1gwNNVwNMxn
        jLWdv1Kzo0zx0weDT//9ktT+3jv1cWVQy8XcSf6NBZK6bzM9vzyLmXYrOXLqjUhLnfLvCsHz
        w88+DDJhnRn8c0dA8W51bru+4kcM6m8CTs3YfT7e13P+DO1jJUEWQdxRXzLapZa0L2L+/DfB
        m2+xwF7Bs17J9x7rX89ssvW/Z7xL5znHH403d087+HFyK7EUZyQaajEXFScCAADg1x3rAgAA
X-CMS-MailID: 20201026023655epcas1p1abc7a1281b15a8b56399f3a694afceb4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201026023655epcas1p1abc7a1281b15a8b56399f3a694afceb4
References: <20201026025038.1480-1-cw00.choi@samsung.com>
        <CGME20201026023655epcas1p1abc7a1281b15a8b56399f3a694afceb4@epcas1p1.samsung.com>
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

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/ABI/testing/sysfs-class-devfreq |  54 +++---
 drivers/devfreq/devfreq.c                     | 162 ++++++++++++------
 drivers/devfreq/governor.h                    |  12 ++
 drivers/devfreq/governor_simpleondemand.c     |   2 +
 drivers/devfreq/tegra30-devfreq.c             |   1 +
 5 files changed, 159 insertions(+), 72 deletions(-)

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
index a862acfe987e..02cfc6552913 100644
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
@@ -917,6 +923,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 			__func__);
 		goto err_init;
 	}
+	create_sysfs_files(devfreq, devfreq->governor);
 
 	list_add(&devfreq->node, &devfreq_list);
 
@@ -947,9 +954,12 @@ int devfreq_remove_device(struct devfreq *devfreq)
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
@@ -1378,13 +1388,22 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
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
+	 * which depend on the new governor.
+	 */
 	prev_governor = df->governor;
 	df->governor = governor;
 	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
@@ -1392,6 +1411,8 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (ret) {
 		dev_warn(dev, "%s: Governor %s not started(%d)\n",
 			 __func__, df->governor->name, ret);
+
+		/* Restore previous governor */
 		df->governor = prev_governor;
 		strncpy(df->governor_name, prev_governor->name,
 			DEVFREQ_NAME_LEN);
@@ -1401,8 +1422,16 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 				"%s: reverting to Governor %s failed (%d)\n",
 				__func__, df->governor_name, ret);
 			df->governor = NULL;
+			goto out;
 		}
 	}
+
+	/*
+	 * Create the sysfs files for the new governor. But if failed to start
+	 * the new governor, restore the sysfs files of previous governor.
+	 */
+	create_sysfs_files(df, df->governor);
+
 out:
 	mutex_unlock(&devfreq_list_lock);
 
@@ -1484,39 +1513,6 @@ static ssize_t target_freq_show(struct device *dev,
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
@@ -1724,6 +1720,53 @@ static ssize_t trans_stat_store(struct device *dev,
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
@@ -1787,21 +1830,36 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
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
@@ -1858,8 +1916,12 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
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

