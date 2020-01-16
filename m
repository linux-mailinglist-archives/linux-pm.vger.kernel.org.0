Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7D13D861
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 11:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgAPKv5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 05:51:57 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:29146 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgAPKv4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 05:51:56 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200116105153epoutp048d35a733904e41b84cc346ab393f600b~qWH0g0e4w2326623266epoutp04V
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 10:51:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200116105153epoutp048d35a733904e41b84cc346ab393f600b~qWH0g0e4w2326623266epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579171913;
        bh=4jKTl3Bzex8DaDEnew1fmoVTKniRsUIiYm3eFCAaVOM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=DksVy+ZjRgN+i2CBFVAaA2i5FdyZX9pueWo8budZMZyIxwZ/dYgJoEscSP18y/gAB
         i7PO1ZELyQT5BAbKm5Ixxo/iq8x8e69OkOvgZzdokV1eBRVBiCEFZeTbYWoMzoDZkr
         bjjzoIwLdlyprjAShO2N34XdqlHxbLrp3ud/GDSk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200116105152epcas1p1171d922c23aaf1b6d4d53cc3e51039cb~qWHzLGokf3008630086epcas1p1Y;
        Thu, 16 Jan 2020 10:51:52 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47z1GZ1N3MzMqYkb; Thu, 16 Jan
        2020 10:51:50 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.F4.51241.640402E5; Thu, 16 Jan 2020 19:51:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200116105149epcas1p36fa4867bae7d1a6f4827a8ddb4e75b35~qWHwmJCk00128201282epcas1p3Q;
        Thu, 16 Jan 2020 10:51:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200116105149epsmtrp12fe68f693f0dd5f94522c369d1a64881~qWHwlS21s0649306493epsmtrp18;
        Thu, 16 Jan 2020 10:51:49 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-48-5e2040469c43
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.1B.10238.540402E5; Thu, 16 Jan 2020 19:51:49 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200116105149epsmtip2dc55599c7a95d9585427015afcbc4274~qWHwVwmnW0054300543epsmtip2J;
        Thu, 16 Jan 2020 10:51:49 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v5] PM / devfreq: Add debugfs support with devfreq_summary
 file
Date:   Thu, 16 Jan 2020 19:59:09 +0900
Message-Id: <20200116105909.29281-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0gTcRznd7fdTml1TKtfg2xdSCSoO+fqZ2RIjThKyogIolyHHtvYk90W
        vYjK8oWWZkSphT0xW/lgmWk1MbMsisoe1ho9xQpdWBqVvbbdov77fD+P7/f7e5C4ooZQkiab
        i3faOAtNxEpar81RJy/JUuWqWw+Q6MXRPQDd9gUlqLL/oQQ9GR2UorMjbwDy+LsA+tp0C0fN
        dWZ0Z9eQDNUHRqSor72WQJ/LuwE6tmu3DJ3rDsiQf2c9kTWJ9Rz1ALZvbznGtgVOAvZSdUDG
        tjSUEOzzx5cJtjnYhrE/q30Sdq+3AbCfWxJyYteaFxh5Lp93qnhbnj3fZDNk0stW6RfrtXPV
        TDKTgebRKhtn5TNpXXZO8hKTJXQMWrWRs7hDVA4nCHTqwgVOu9vFq4x2wZVJ8458iyPDkSJw
        VsFtM6Tk2a3zGbU6TRsybjAbB/sOYo5htOnm2wfYDrA/qRTEkJBKh/sKPVgpiCUVVBuAvh9D
        uFh8AnD06cVo8QXAnhe1xN9IbWehVBSuALj/+EdZWFBQowA21jBhTFBJ0PeuPxKIp+bD27+L
        I51wyofBim/DoYIk46iVcHgkJeyRUInwwrNz0jAtD/nP97rFWTPg2abOSBRSgwT0vBqSiYIO
        Pn15M7pQHPxwwxvllfD9vsIo3grP9HYTYrgYQK/vnlQUNNB3qgoLD8OpObCxPVWkZ8JL40dA
        GOPURBgcK4vsAyk5LC5UiJZZsO9lABPxNHiiqCS6Agtrxq8TYbuCWg8/ja+oANOr//WvA6AB
        TOEdgtXAC4xD+/8btYDIx0zKaAM9d7O7AEUCeoLc+CMhVyHlNgqbrV0AkjgdL+89ND1XIc/n
        Nm/hnXa9023hhS6gDd1dJa6cnGcPfXObS89o0zQaDUpn5moZhp4q19WF+lAGzsWbed7BO//m
        MDJGuQNkl+mC7GxLRg9R2XCxYGhSzGLlloRpZYb7z98WrS6IKeowdnQ4K2bUvB4ds46/yjqc
        9euqv+SNN/60We836c4MVLVfSEd1yZOX3hrMHkh0bFu1SFPQv7J1e2f993mNLQN3ymze4P3U
        NcvLJ8RDkKJ8UGp4pDa5/eu8cWlV9jHTVFoiGDkmCXcK3B8AtNABrgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvK6rg0KcwdRZchb357UyWpze/47F
        YuKNKywW1788Z7VY/fExo8Wa24cYLX5sOMVssXFBtsXZpjfsFivufmS1uLxrDpvF594jjBYL
        m1rYLdYeuctucbtxBZsDv8eaeWsYPS739TJ57Li7hNFj56y77B6bVnWyedy5tofNY+O7HUwe
        f2ftZ/Ho27KK0ePzJrkArigum5TUnMyy1CJ9uwSujOeXpzEVvLWoOPHkElMD4yStLkZODgkB
        E4k5B9pYuxi5OIQEdjNKvNy+ihkiISkx7eJRIJsDyBaWOHy4GKLmE6PEtLe7mUBq2AS0JPa/
        uMEGYosI2EjcXXyNBaSIWeA8k0T78qmMIAlhAX+JzytXgw1lEVCV2HprLSvIUF4BK4l1J0sh
        dslLrN5wgHkCI88CRoZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBQayluYPx8pL4
        Q4wCHIxKPLwZf+TihFgTy4orcw8xSnAwK4nwnpwhGyfEm5JYWZValB9fVJqTWnyIUZqDRUmc
        92nesUghgfTEktTs1NSC1CKYLBMHp1QDIyffgRXz17nGRM/8oHDkhesKjjNN97W/FsXwT3vR
        8rZHziw8NPPrawfFmhjemCmmXvUex1eudumb6cBbeeGNuJ+yzNEQE87/Cwpeeq+fP+XDKq/o
        83kVHGH8nFkd7yLmnDm4sOPjjKPcmr87fJKDugqyJL6JsvVGyUktvV4YZ7JG5NKHxrTVSizF
        GYmGWsxFxYkAFM95D14CAAA=
X-CMS-MailID: 20200116105149epcas1p36fa4867bae7d1a6f4827a8ddb4e75b35
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200116105149epcas1p36fa4867bae7d1a6f4827a8ddb4e75b35
References: <CGME20200116105149epcas1p36fa4867bae7d1a6f4827a8ddb4e75b35@epcas1p3.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add debugfs interface to provide debugging information of devfreq device.
It contains 'devfreq_summary' entry to show the summary of registered
devfreq devices as following and the additional debugfs file will be added.
- /sys/kernel/debug/devfreq/devfreq_summary

[Detailed description of each field of 'devfreq_summary' debugfs file]
- dev_name	: Device name of h/w
- dev		: Device name made by devfreq core
- parent_dev	: If devfreq device uses the passive governor,
		  show parent devfreq device name. Otherwise, show 'null'.
- governor	: Devfreq governor name
- polling_ms	: If devfreq device uses the simple_ondemand governor,
		  polling_ms is necessary for the period. (unit: millisecond)
- cur_freq_Hz	: Current frequency (unit: Hz)
- min_freq_Hz	: Minimum frequency (unit: Hz)
- max_freq_Hz	: Maximum frequency (unit: Hz)

[For example on Exynos5422-based Odroid-XU3 board]
$ cat /sys/kernel/debug/devfreq/devfreq_summary
dev_name                       dev        parent_dev governor        polling_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz
------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
10c20000.memory-controller     devfreq0   null       simple_ondemand          0    165000000    165000000    825000000
soc:bus_wcore                  devfreq1   null       simple_ondemand         50    532000000     88700000    532000000
soc:bus_noc                    devfreq2   devfreq1   passive                  0    111000000     66600000    111000000
soc:bus_fsys_apb               devfreq3   devfreq1   passive                  0    222000000    111000000    222000000
soc:bus_fsys                   devfreq4   devfreq1   passive                  0    200000000     75000000    200000000
soc:bus_fsys2                  devfreq5   devfreq1   passive                  0    200000000     75000000    200000000
soc:bus_mfc                    devfreq6   devfreq1   passive                  0    333000000     83250000    333000000
soc:bus_gen                    devfreq7   devfreq1   passive                  0    266000000     88700000    266000000
soc:bus_peri                   devfreq8   devfreq1   passive                  0     66600000     66600000     66600000
soc:bus_g2d                    devfreq9   devfreq1   passive                  0    333000000     83250000    333000000
soc:bus_g2d_acp                devfreq10  devfreq1   passive                  0    266000000     66500000    266000000
soc:bus_jpeg                   devfreq11  devfreq1   passive                  0    300000000     75000000    300000000
soc:bus_jpeg_apb               devfreq12  devfreq1   passive                  0    166500000     83250000    166500000
soc:bus_disp1_fimd             devfreq13  devfreq1   passive                  0    200000000    120000000    200000000
soc:bus_disp1                  devfreq14  devfreq1   passive                  0    300000000    120000000    300000000
soc:bus_gscl_scaler            devfreq15  devfreq1   passive                  0    300000000    150000000    300000000
soc:bus_mscl                   devfreq16  devfreq1   passive                  0    666000000     84000000    666000000

[lkp: Reported the build error]
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes from v4:
- Fix wrong patch description
Changes from v3:
- Remove the unneeded checking of return value when calling debugfs_create_dir
- Add missing IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE) condition
Changes from v2:
- Show 'null' at 'parent_dev' field when governor of devfreq device
  is not passive
Changes from v1:
- Drop the patch about 'devfreq_transitions' debugfs file
- Modify from 'hz' to 'Hz'
- Edit the indentation of 'devfreq_summary' when show summary
- Exchange sequence between PTR_ERR and IS_ERR when debugfs_create_dir

 drivers/devfreq/devfreq.c | 82 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 89260b17598f..cceee8bc3c2f 100644
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
@@ -1643,6 +1645,81 @@ static struct attribute *devfreq_attrs[] = {
 };
 ATTRIBUTE_GROUPS(devfreq);
 
+/**
+ * devfreq_summary_show() - Show the summary of the devfreq devices
+ * @s:		seq_file instance to show the summary of devfreq devices
+ * @data:	not used
+ *
+ * Show the summary of the devfreq devices via 'devfreq_summary' debugfs file.
+ * It helps that user can know the detailed information of the devfreq devices.
+ *
+ * Return 0 always because it shows the information without any data change.
+ */
+static int devfreq_summary_show(struct seq_file *s, void *data)
+{
+	struct devfreq *devfreq;
+	struct devfreq *p_devfreq = NULL;
+	unsigned long cur_freq, min_freq, max_freq;
+	unsigned int polling_ms;
+
+	seq_printf(s, "%-30s %-10s %-10s %-15s %10s %12s %12s %12s\n",
+			"dev_name",
+			"dev",
+			"parent_dev",
+			"governor",
+			"polling_ms",
+			"cur_freq_Hz",
+			"min_freq_Hz",
+			"max_freq_Hz");
+	seq_printf(s, "%30s %10s %10s %15s %10s %12s %12s %12s\n",
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
+
+		mutex_lock(&devfreq->lock);
+		cur_freq = devfreq->previous_freq,
+		get_freq_range(devfreq, &min_freq, &max_freq);
+		polling_ms = devfreq->profile->polling_ms,
+		mutex_unlock(&devfreq->lock);
+
+		seq_printf(s,
+			"%-30s %-10s %-10s %-15s %10d %12ld %12ld %12ld\n",
+			dev_name(devfreq->dev.parent),
+			dev_name(&devfreq->dev),
+			p_devfreq ? dev_name(&p_devfreq->dev) : "null",
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
@@ -1659,6 +1736,11 @@ static int __init devfreq_init(void)
 	}
 	devfreq_class->dev_groups = devfreq_groups;
 
+	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
+	debugfs_create_file("devfreq_summary", 0444,
+				devfreq_debugfs, NULL,
+				&devfreq_summary_fops);
+
 	return 0;
 }
 subsys_initcall(devfreq_init);
-- 
2.17.1

