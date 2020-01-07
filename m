Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5630B131D5E
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 02:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgAGBz6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 20:55:58 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:22825 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgAGBz4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 20:55:56 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200107015552epoutp01e390ccf2a8bc33e145a9c9e6052bb744~neAPxJcau1280912809epoutp01Y
        for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2020 01:55:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200107015552epoutp01e390ccf2a8bc33e145a9c9e6052bb744~neAPxJcau1280912809epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578362152;
        bh=AWbv14Ua+YvZim/iw9rHjlqPXDk7GnL21VcUrPOlOQo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=iT26dLaIlVn7FPQaHVqByb16/DT75i0WdsayAHehTRbIz2Q6M8QsfmEU2PVyR1RLL
         kl8M7ThIpbNvzJxHlGp3aWTd9KorYV/8EmDTMObe+r22WbTrE0kLvW5i7xH3Le+kQd
         YIpMzupE1oWU55y2FQyh3J/YXU3TRUpVxEJgX1Ic=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200107015552epcas1p3a029ef490bee4ba7ebb83f309a23eb5e~neAPZlep02175821758epcas1p3Z;
        Tue,  7 Jan 2020 01:55:52 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47sFpF5Zq5zMqYkg; Tue,  7 Jan
        2020 01:55:49 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.BB.51241.525E31E5; Tue,  7 Jan 2020 10:55:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200107015549epcas1p28a8f26855da65790c13d843506a0b15e~neAMarMAb3180431804epcas1p2U;
        Tue,  7 Jan 2020 01:55:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200107015549epsmtrp27f8d4431fd1a82fd3b226b7c5e1d3061~neAMaAC6L1700817008epsmtrp2R;
        Tue,  7 Jan 2020 01:55:49 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-81-5e13e5254cc1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.E1.10238.425E31E5; Tue,  7 Jan 2020 10:55:49 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200107015548epsmtip24e9079ae09c0f5ca4d7ef55e16dd5447~neAMMdjvk1943919439epsmtip2z;
        Tue,  7 Jan 2020 01:55:48 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        natechancellor@gmail.com
Subject: [PATCH v3] PM / devfreq: Add debugfs support with devfreq_summary
 file
Date:   Tue,  7 Jan 2020 11:02:53 +0900
Message-Id: <20200107020253.22378-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7bCmvq7qU+E4g0ub9Swm3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFh/eljiwe+ycdZfdY9OqTjaPvi2rGD0+b5ILYInKtslI
        TUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOkBJoSwxpxQo
        FJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2VoYGBkClSYkJ3RsaCL
        qeCOYcWnAz2sDYxnVboYOTgkBEwkFl4x62Lk5BAS2MEo8elaRhcjF5D9iVHi2Is+JgjnG6PE
        tl3r2EGqQBqmnDjJApHYyyhxYvlfVgjnC6PEje7TbCBVbAJaEvtf3ACzRQSsJE7/72AGsZkF
        6iSO/P7CBGILCwRK/L+7gAXEZhFQlbh18RsTyEm8QPX39tlDLJOXWL3hADPEpT9ZJeYXQJgu
        El9/y0BUCEu8Or4F6jQpic/v9rJB2NUSK08eYQO5TEKgg1Fiy/4LrBAJY4n9SyeDbWIW0JRY
        v0sfIqwosfP3XEaII/kk3n3tYYVYxSvR0SYEUaIscfnBXSYIW1JicXsn1CoPiQeHJrFDwjBW
        4s2s3UwTGGVnISxYwMi4ilEstaA4Nz212LDAFDmCNjGC05OW5Q7GY+d8DjEKcDAq8fBOkBGO
        E2JNLCuuzD3EKMHBrCTC2+gmGCfEm5JYWZValB9fVJqTWnyI0RQYchOZpUST84GpM68k3tDU
        yNjY2MLE0MzU0FBJnJfjx8VYIYH0xJLU7NTUgtQimD4mDk6pBkbdlFUNb9ekG1rtsFz/+Mz+
        UjWdTm4Lt8WTpK6Uys3IOrXJ3YrDPG0Ny+qUxkSZD/PXHMzTteZ+xqeqtmb5my+lZbUfGuQr
        688fsCvcs/sY18wlUY/tzKZtu7uSZb3KzfIo+ZNRjz3rsi3e3DFM+FcyU0fU5oq/8xGJvz5C
        O78oL/vtWKteIqHEUpyRaKjFXFScCABgJq8HZQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42LZdlhJXlf1qXCcwd86i4k3rrBYXP/ynNXi
        bNMbdovLu+awWXzuPcJocbtxBZvFh7clDuweO2fdZffYtKqTzaNvyypGj8+b5AJYorhsUlJz
        MstSi/TtErgyOhZ0MRXcMaz4dKCHtYHxrEoXIyeHhICJxJQTJ1m6GLk4hAR2M0oseraXBSIh
        KTHt4lHmLkYOIFtY4vDhYoiaT4wSfaf/soPUsAloSex/cYMNxBYRsJG4u/gaWC+zQAujxIPJ
        piC2sIC/xImnL8DiLAKqErcufmMCmckrYCVxb589xCp5idUbDjBPYORZwMiwilEytaA4Nz23
        2LDAMC+1XK84Mbe4NC9dLzk/dxMjOGi0NHcwXl4Sf4hRgINRiYfXQko4Tog1say4MvcQowQH
        s5IIb6ObYJwQb0piZVVqUX58UWlOavEhRmkOFiVx3qd5xyKFBNITS1KzU1MLUotgskwcnFIN
        jBnddooctyWrdW8+CTz+8QPD2nCDayYr7DSMZX13PImavO37og/y/o46x1huP8o8f9BOSPVF
        g1edgGA2z33VszM+yM90j3z8/p1ISdnctRUvW/PVDk+WlH8oLnBeu6E26GVK1vN7d5h4bmy6
        fPg8x+ei8pPF5/2nHuf992RGn7e61pv6VU4XdJVYijMSDbWYi4oTAQ6yM4AWAgAA
X-CMS-MailID: 20200107015549epcas1p28a8f26855da65790c13d843506a0b15e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200107015549epcas1p28a8f26855da65790c13d843506a0b15e
References: <CGME20200107015549epcas1p28a8f26855da65790c13d843506a0b15e@epcas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add debugfs interface to provide debugging information of devfreq device.
It contains 'devfreq_summary' entry to show the summary of registered
devfreq devices as following and the additional debugfs file will be added.
- /sys/kernel/debug/devfreq/devfreq_summary

[For example on Exynos5422-based Odroid-XU3 board]
- In order to show the multiple governors on devfreq_summay result,
change the governor of devfreq0 from simple_ondemand to userspace.

$ cat /sys/kernel/debug/devfreq/devfreq_summary
dev_name                       dev        parent_dev governor        polling_ms cur_freq     min_freq     max_freq
------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
10c20000.memory-controller     devfreq0              userspace       0          165000000    165000000    825000000
soc:bus_wcore                  devfreq1              simple_ondemand 50         400000000    84000000     400000000
soc:bus_noc                    devfreq2   devfreq1   passive         0          100000000    67000000     100000000
soc:bus_fsys_apb               devfreq3   devfreq1   passive         0          200000000    100000000    200000000
soc:bus_fsys                   devfreq4   devfreq1   passive         0          200000000    100000000    200000000
soc:bus_fsys2                  devfreq5   devfreq1   passive         0          150000000    75000000     150000000
soc:bus_mfc                    devfreq6   devfreq1   passive         0          333000000    96000000     333000000
soc:bus_gen                    devfreq7   devfreq1   passive         0          267000000    89000000     267000000
soc:bus_peri                   devfreq8   devfreq1   passive         0          67000000     67000000     67000000
soc:bus_g2d                    devfreq9   devfreq1   passive         0          333000000    84000000     333000000
soc:bus_g2d_acp                devfreq10  devfreq1   passive         0          267000000    67000000     267000000
soc:bus_jpeg                   devfreq11  devfreq1   passive         0          300000000    75000000     300000000
soc:bus_jpeg_apb               devfreq12  devfreq1   passive         0          167000000    84000000     167000000
soc:bus_disp1_fimd             devfreq13  devfreq1   passive         0          200000000    120000000    200000000
soc:bus_disp1                  devfreq14  devfreq1   passive         0          300000000    120000000    300000000
soc:bus_gscl_scaler            devfreq15  devfreq1   passive         0          300000000    150000000    300000000
soc:bus_mscl                   devfreq16  devfreq1   passive         0          400000000    84000000     400000000

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes from v2:
- Add polling_ms field to show the polling interval when using simple_ondemand
- Init devfreq_debugfs variable by NULL if failed
- Rename variable name from parent_devfreq to p_devfreq

Changes from v1:
- Handle exception case when DEVFREQ_GOV_PASSIVE is unset.

 drivers/devfreq/devfreq.c | 79 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 254f11b31824..9b60f45415b9 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/kmod.h>
 #include <linux/sched.h>
+#include <linux/debugfs.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -33,6 +34,7 @@
 #define HZ_PER_KHZ	1000
 
 static struct class *devfreq_class;
+static struct dentry *devfreq_debugfs;
 
 /*
  * devfreq core provides delayed work based load monitoring helper
@@ -1717,6 +1719,74 @@ static struct attribute *devfreq_attrs[] = {
 };
 ATTRIBUTE_GROUPS(devfreq);
 
+/**
+ * devfreq_summary_show() - Show the summary of the registered devfreq devices
+ *				via 'devfreq_summary' debugfs file.
+ */
+static int devfreq_summary_show(struct seq_file *s, void *data)
+{
+	struct devfreq *devfreq;
+	struct devfreq *p_devfreq = NULL;
+	unsigned long cur_freq, min_freq, max_freq;
+	unsigned int polling_ms;
+
+	seq_printf(s, "%-30s %-10s %-10s %-15s %-10s %-12s %-12s %-12s\n",
+			"dev_name",
+			"dev",
+			"parent_dev",
+			"governor",
+			"polling_ms",
+			"cur_freq",
+			"min_freq",
+			"max_freq");
+	seq_printf(s, "%-30s %-10s %-10s %-15s %-10s %-12s %-12s %-12s\n",
+			"------------------------------",
+			"----------",
+			"----------",
+			"---------------",
+			"----------",
+			"------------",
+			"------------",
+			"------------");
+
+	mutex_lock(&devfreq_list_lock);
+
+	list_for_each_entry_reverse(devfreq, &devfreq_list, node) {
+#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
+		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
+							DEVFREQ_NAME_LEN)) {
+			struct devfreq_passive_data *data = devfreq->data;
+
+			if (data)
+				p_devfreq = data->parent;
+		} else {
+			p_devfreq = NULL;
+		}
+#endif
+		mutex_lock(&devfreq->lock);
+		cur_freq = devfreq->previous_freq,
+		get_freq_range(devfreq, &min_freq, &max_freq);
+		polling_ms = devfreq->profile->polling_ms,
+		mutex_unlock(&devfreq->lock);
+
+		seq_printf(s,
+			"%-30s %-10s %-10s %-15s %-10d %-12ld %-12ld %-12ld\n",
+			dev_name(devfreq->dev.parent),
+			dev_name(&devfreq->dev),
+			p_devfreq ? dev_name(&p_devfreq->dev) : "",
+			devfreq->governor_name,
+			polling_ms,
+			cur_freq,
+			min_freq,
+			max_freq);
+	}
+
+	mutex_unlock(&devfreq_list_lock);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
+
 static int __init devfreq_init(void)
 {
 	devfreq_class = class_create(THIS_MODULE, "devfreq");
@@ -1733,6 +1803,15 @@ static int __init devfreq_init(void)
 	}
 	devfreq_class->dev_groups = devfreq_groups;
 
+	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
+	if (PTR_ERR(devfreq_debugfs) != -ENODEV && IS_ERR(devfreq_debugfs)) {
+		devfreq_debugfs = NULL;
+		pr_warn("%s: couldn't create debugfs dir\n", __FILE__);
+	} else {
+		debugfs_create_file("devfreq_summary", 0444, devfreq_debugfs,
+				NULL, &devfreq_summary_fops);
+	}
+
 	return 0;
 }
 subsys_initcall(devfreq_init);
-- 
2.17.1

