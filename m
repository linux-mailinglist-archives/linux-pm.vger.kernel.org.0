Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2882A1321C4
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 09:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgAGI63 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 03:58:29 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:47729 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgAGI6U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 03:58:20 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200107085816epoutp039af1d7976eb2e16e895f0e05e5aec2db~njxC_e4yC2237722377epoutp03D
        for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2020 08:58:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200107085816epoutp039af1d7976eb2e16e895f0e05e5aec2db~njxC_e4yC2237722377epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578387496;
        bh=k9VIX2Tvv1UVySMUsRa2IWtltfDMnfFeAPgI6gGcGHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHf9CCkvoxllcNPGHrHVpAHfLMc44ycvfd7ogkCLVfUGbhH+wScQ+VYGSnOkJp08Y
         w8RBeBRjtAc3CYmWPenVoi0pXrCMxI4KOikutqG6C5rvV5vzNbdKlAWGXVr/2muTY5
         K1mcbcHVDhhSgksxQg88C+AWwpnn92GeKXimvJOU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200107085815epcas1p4ed89ae42fd35a5941bcd16ed882cbbff~njxCb0u3v1742217422epcas1p4b;
        Tue,  7 Jan 2020 08:58:15 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47sR9d2RqMzMqYkn; Tue,  7 Jan
        2020 08:58:13 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.F6.57028.528441E5; Tue,  7 Jan 2020 17:58:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200107085812epcas1p12121f8ef6492ed78053dea4977216788~njw-jzdDJ1960019600epcas1p1a;
        Tue,  7 Jan 2020 08:58:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200107085812epsmtrp2d23f986dfb3de9d995c4981fcb622cbb~njw-hNMsy1554315543epsmtrp25;
        Tue,  7 Jan 2020 08:58:12 +0000 (GMT)
X-AuditID: b6c32a35-974d39c00001dec4-14-5e14482551db
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.81.10238.428441E5; Tue,  7 Jan 2020 17:58:12 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200107085812epsmtip2edf435cc31e434fe580e701db94c97c3~njw-T6jXc2461724617epsmtip2k;
        Tue,  7 Jan 2020 08:58:12 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH 1/2] PM / devfreq: Add debugfs support with devfreq_summary
 file
Date:   Tue,  7 Jan 2020 18:05:18 +0900
Message-Id: <20200107090519.3231-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107090519.3231-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmnq6qh0icwYFvQhb357UyWpze/47F
        YuKNKywW1788Z7VY/fExo8Wa24cYLX5sOMVssXFBtsXZpjfsFivufmS1uLxrDpvF594jjBYL
        m1rYLdYeuctucbtxBZsDv8eaeWsYPS739TJ57Li7hNFj56y77B6bVnWyedy5tofNY+O7HUwe
        f2ftZ/Ho27KK0ePzJrkArqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
        3FRbJRefAF23zBygN5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BZYFesWJucWl
        eel6yfm5VoYGBkamQIUJ2Rknmx6wFXSaVJxZuJ6pgbFJrYuRk0NCwETi2MWlrF2MXBxCAjsY
        JRad3scCkhAS+MQosaktGCLxjVFiXv8BFpiOhzvmM0IU7WWUuD6jFqLoC6PEyQ/r2UESbAJa
        Evtf3GADsUUErCRO/+9gBiliFtjPJDHh51tmkISwQJDEyskLwSaxCKhKbHn/BizOK2ApMWnx
        Oqht8hKrNxwAi3MCDfry+j07yCAJgf9sEpf+7oIqcpFoPPwdyhaWeHV8CzuELSXx+d1eNgi7
        WmLlySNsEM0djBJb9l9ghUgYS+xfOpmpi5ED6DxNifW79CHCihI7f88FO45ZgE/i3dceVpAS
        CQFeiY42IYgSZYnLD+4yQdiSEovbO6FWeUjMfHeUFRJCvYwSPc+CJzDKzUJYsICRcRWjWGpB
        cW56arFhgSFyjG1iBCdTLdMdjFPO+RxiFOBgVOLhnSAjHCfEmlhWXJl7iFGCg1lJhFdLRyRO
        iDclsbIqtSg/vqg0J7X4EKMpMCQnMkuJJucDE31eSbyhqZGxsbGFiaGZqaGhkjgvx4+LsUIC
        6YklqdmpqQWpRTB9TBycUg2Mob26KwtNDy8K+vvxGZdbzDIOkeX/41lOBe6SmKLjEbfKuNvt
        ZuWei5KNj5P/7ti87Y0ml4hVzRKFvUsefFDetnClk3r7SkkL9nsb1Mp/ad8rWBeVfuIQy2/1
        MDu3PSfZV598bHPFf35Mn/fFerHgnthTr2syxV7a2Kz7WMFrMlFSyfOHRv5nJZbijERDLeai
        4kQA29Yo07wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvK6Kh0icwdl+HYv781oZLU7vf8di
        MfHGFRaL61+es1qs/viY0WLN7UOMFj82nGK22Lgg2+Js0xt2ixV3P7JaXN41h83ic+8RRouF
        TS3sFmuP3GW3uN24gs2B32PNvDWMHpf7epk8dtxdwuixc9Zddo9NqzrZPO5c28PmsfHdDiaP
        v7P2s3j0bVnF6PF5k1wAVxSXTUpqTmZZapG+XQJXxsmmB2wFnSYVZxauZ2pgbFLrYuTkkBAw
        kXi4Yz5jFyMXh5DAbkaJ8+9vsEEkJCWmXTzK3MXIAWQLSxw+XAxR84lR4tyRXSwgNWwCWhL7
        X0DUiwjYSNxdfI0FpIhZ4DyTRPvyqYwgCWGBAImD/88zgdgsAqoSW96/YQaxeQUsJSYtXscC
        sUxeYvWGA2BxTgEriS+v37OD2EJANWu2XmCcwMi3gJFhFaNkakFxbnpusWGBYV5quV5xYm5x
        aV66XnJ+7iZGcNhrae5gvLwk/hCjAAejEg+vhZRwnBBrYllxZe4hRgkOZiURXi0dkTgh3pTE
        yqrUovz4otKc1OJDjNIcLErivE/zjkUKCaQnlqRmp6YWpBbBZJk4OKUaGJkrzly/fKJCRUlz
        csjKnML3LmZ1MkUr2CzOKbRPPj9x0eZfWoYOE/Z+PfnPcrHL1SmMnsenOCjJczBPmRx07Wuv
        PDvre7GO9FvZG/iaH6/gSo3U19ua9jW77vAM0Q5febNn4Vd5s1+J1tmdrvXT/rWjRzls5lrb
        iYubl+/+W+zwu+v+599JxUosxRmJhlrMRcWJAGBQqV13AgAA
X-CMS-MailID: 20200107085812epcas1p12121f8ef6492ed78053dea4977216788
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200107085812epcas1p12121f8ef6492ed78053dea4977216788
References: <20200107090519.3231-1-cw00.choi@samsung.com>
        <CGME20200107085812epcas1p12121f8ef6492ed78053dea4977216788@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add debugfs interface to provide debugging information of devfreq device.
It contains 'devfreq_summary' entry to show the summary of registered
devfreq devices as following and the additional debugfs file will be added.
- /sys/kernel/debug/devfreq/devfreq_summary

[Detailed description of each field of 'devfreq_summary' debugfs file]
- dev_name	: Device name of h/w.
- dev		: Device name made by devfreq core.
- parent_dev	: If devfreq device uses the passive governor,
		  show parent devfreq device name.
- governor	: Devfreq governor.
- polling_ms	: If devfreq device uses the simple_ondemand governor,
		  polling_ms is necessary for the period. (unit: millisecond)
- cur_freq_hz	: Current Frequency (unit: hz)
- old_freq_hz	: Frequency before changing. (unit: hz)
- new_freq_hz	: Frequency after changed. (unit: hz)

[For example on Exynos5422-based Odroid-XU3 board]
- In order to show the multiple governors on devfreq_summay result,
change the governor of devfreq0 from simple_ondemand to userspace.

$ cat /sys/kernel/debug/devfreq/devfreq_summary
dev_name                       dev        parent_dev governor        polling_ms cur_freq_hz  min_freq_hz  max_freq_hz
------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
10c20000.memory-controller     devfreq0              userspace       0          206000000    165000000    825000000
soc:bus_wcore                  devfreq1              simple_ondemand 50         532000000    88700000     532000000
soc:bus_noc                    devfreq2   devfreq1   passive         0          111000000    66600000     111000000
soc:bus_fsys_apb               devfreq3   devfreq1   passive         0          222000000    111000000    222000000
soc:bus_fsys                   devfreq4   devfreq1   passive         0          200000000    75000000     200000000
soc:bus_fsys2                  devfreq5   devfreq1   passive         0          200000000    75000000     200000000
soc:bus_mfc                    devfreq6   devfreq1   passive         0          333000000    83250000     333000000
soc:bus_gen                    devfreq7   devfreq1   passive         0          266000000    88700000     266000000
soc:bus_peri                   devfreq8   devfreq1   passive         0          66600000     66600000     66600000
soc:bus_g2d                    devfreq9   devfreq1   passive         0          0            83250000     333000000
soc:bus_g2d_acp                devfreq10  devfreq1   passive         0          0            66500000     266000000
soc:bus_jpeg                   devfreq11  devfreq1   passive         0          0            75000000     300000000
soc:bus_jpeg_apb               devfreq12  devfreq1   passive         0          0            83250000     166500000
soc:bus_disp1_fimd             devfreq13  devfreq1   passive         0          0            120000000    200000000
soc:bus_disp1                  devfreq14  devfreq1   passive         0          0            120000000    300000000
soc:bus_gscl_scaler            devfreq15  devfreq1   passive         0          0            150000000    300000000
soc:bus_mscl                   devfreq16  devfreq1   passive         0          0            84000000     666000000

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 80 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 254f11b31824..c7f5e4e06420 100644
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
+			"cur_freq_hz",
+			"min_freq_hz",
+			"max_freq_hz");
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
@@ -1733,6 +1803,16 @@ static int __init devfreq_init(void)
 	}
 	devfreq_class->dev_groups = devfreq_groups;
 
+	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
+	if (PTR_ERR(devfreq_debugfs) != -ENODEV && IS_ERR(devfreq_debugfs)) {
+		devfreq_debugfs = NULL;
+		pr_warn("%s: couldn't create debugfs dir\n", __FILE__);
+	} else {
+		debugfs_create_file("devfreq_summary", 0444,
+				devfreq_debugfs, NULL,
+				&devfreq_summary_fops);
+	}
+
 	return 0;
 }
 subsys_initcall(devfreq_init);
-- 
2.17.1

