Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD34F12F293
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2020 02:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgACBHJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 20:07:09 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:21498 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgACBHI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 20:07:08 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200103010703epoutp0336a24f686bfde02b0e4232cc114aa04a~mOwe93zBT1140211402epoutp03T
        for <linux-pm@vger.kernel.org>; Fri,  3 Jan 2020 01:07:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200103010703epoutp0336a24f686bfde02b0e4232cc114aa04a~mOwe93zBT1140211402epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578013623;
        bh=lMeH+CW26VVFbE1BoutX382wcZ4Z8J4ivY4VbIZlPwU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=gfUP6gE+9Ay212PCGfOXbQ97kQueDSXdO3456gzeoF5s73dhApM+SiQSBSpuemWMN
         URT6dAlm2hgnzkbO0ON0Qh1/fC9UZldsoyxWh46d8X0eIoCz6a+GV0tf27zOX2esCQ
         ki62hE1bypvN6hCkK4e86K5J1BLb0BVyqJXKA0Xo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200103010703epcas1p39abc2b4afb7ad3479cfc437e122876cb~mOwemgwSo1554615546epcas1p3v;
        Fri,  3 Jan 2020 01:07:03 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47pmvl4J9VzMqYlx; Fri,  3 Jan
        2020 01:06:59 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.07.48019.3B39E0E5; Fri,  3 Jan 2020 10:06:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200103010658epcas1p44ecdbebc9ac9dda57e5d42ee39c25d8e~mOwZ_W8Wn0902109021epcas1p4r;
        Fri,  3 Jan 2020 01:06:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200103010658epsmtrp1b46f4793b9c28705422969dd92aaff14~mOwZ9sMI40764907649epsmtrp1G;
        Fri,  3 Jan 2020 01:06:58 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-a0-5e0e93b382b3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.EA.10238.2B39E0E5; Fri,  3 Jan 2020 10:06:58 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200103010658epsmtip26d1432afb3f09b83b826b7b9bd6a8241~mOwZw2EQX1898018980epsmtip20;
        Fri,  3 Jan 2020 01:06:58 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        natechancellor@gmail.com
Subject: [PATCH v2] PM / devfreq: Add debugfs support with devfreq_summary
 file
Date:   Fri,  3 Jan 2020 10:13:56 +0900
Message-Id: <20200103011356.17283-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7bCmge7myXxxBnsa5C0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFh/eljiwe+ycdZfdY9OqTjaPvi2rGD0+b5ILYInKtslI
        TUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOkBJoSwxpxQo
        FJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2VoYGBkClSYkJ1xatc8
        1oLpOhXHd61nbWCcptjFyMkhIWAi8fD7HuYuRi4OIYEdjBLtU85BOZ8YJebNaWKFcL4xSryc
        +5QVpmXipq9sEIm9jBLvNzxggXC+MEosPLWEGaSKTUBLYv+LG2wgtoiAlcTp/x1gcWaBOokj
        v78wgdjCAoES/w48YQexWQRUJabtWQJm8wLV903dxQaxTV5i9YYDYDdJCPxllZi1eQU7RMJF
        4sSEAywQtrDEq+NboOJSEi/726DsaomVJ4+wQTR3MEps2X8B6gdjif1LJwNdwQF0kabE+l36
        EGFFiZ2/5zJCHMon8e5rDytIiYQAr0RHmxBEibLE5Qd3mSBsSYnF7Z1Qd3pI9E6aC7ZWSCBW
        4uuZy0wTGGVnISxYwMi4ilEstaA4Nz212LDABDmaNjGCU5WWxQ7GPed8DjEKcDAq8fBOuMYb
        J8SaWFZcmXuIUYKDWUmEtzwQKMSbklhZlVqUH19UmpNafIjRFBh6E5mlRJPzgWk0ryTe0NTI
        2NjYwsTQzNTQUEmcl+PHxVghgfTEktTs1NSC1CKYPiYOTqkGxkkNLFOVLpTGNe8Q+n7JedZC
        /k2tTRf+/67/9qddfRnzzlaWtGy+SPaCyj0sU+TsHiZ4G3pX3NHSXdR2akfDB3GBD+XeHLsf
        r5a8+vQy8+JAZ/3CV6+L3izYInWg4fr9X5MyF8vprs24sEUvjDvnifWqyE8O5599ONxmv2s+
        v9SNxu/Z8QI1U5VYijMSDbWYi4oTAWPS5sBrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphluLIzCtJLcpLzFFi42LZdlhJXnfTZL44g6kTpS0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFh/eljiwe+ycdZfdY9OqTjaPvi2rGD0+b5ILYInisklJ
        zcksSy3St0vgyji1ax5rwXSdiuO71rM2ME5T7GLk5JAQMJGYuOkrG4gtJLCbUeLMnySIuKTE
        tItHmbsYOYBsYYnDh4u7GLmASj4xSmxpegRWzyagJbH/xQ0wW0TARuLu4mssIDazQAujxIPJ
        piC2sIC/xKadL1hBbBYBVYlpe5awg9i8AlYSfVN3sUHskpdYveEA8wRGngWMDKsYJVMLinPT
        c4sNCwzzUsv1ihNzi0vz0vWS83M3MYLDRktzB+PlJfGHGAU4GJV4eCdc440TYk0sK67MPcQo
        wcGsJMJbHggU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvs071ikkEB6YklqdmpqQWoRTJaJg1Oq
        gVHwxc7ZqbGpn83unJ5Tb/S8tY9XqfNrx907v5oWH1qv9kp/bZHI4y06r2rddzxMjnsbMGuh
        AIOrdfFELW+5s5e8Dn9TVyicYsItnPn44hrPjbvb3u/p265685DUttDzVc/q1lQcFO24r7J3
        Q0a4jpuWmXi6wfTamU+NTz/cd/f9ioJDojc+ysopsRRnJBpqMRcVJwIAerbqNRcCAAA=
X-CMS-MailID: 20200103010658epcas1p44ecdbebc9ac9dda57e5d42ee39c25d8e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200103010658epcas1p44ecdbebc9ac9dda57e5d42ee39c25d8e
References: <CGME20200103010658epcas1p44ecdbebc9ac9dda57e5d42ee39c25d8e@epcas1p4.samsung.com>
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
dev name                       dev        parent dev governor        cur_freq     min_freq     max_freq
------------------------------ ---------- ---------- --------------- ------------ ------------ ------------
10c20000.memory-controller     devfreq0              userspace       165000000    165000000    825000000
soc:bus_wcore                  devfreq1              simple_ondemand 400000000    84000000     400000000
soc:bus_noc                    devfreq2   devfreq1   passive         100000000    67000000     100000000
soc:bus_fsys_apb               devfreq3   devfreq1   passive         200000000    100000000    200000000
soc:bus_fsys                   devfreq4   devfreq1   passive         200000000    100000000    200000000
soc:bus_fsys2                  devfreq5   devfreq1   passive         150000000    75000000     150000000
soc:bus_mfc                    devfreq6   devfreq1   passive         333000000    96000000     333000000
soc:bus_gen                    devfreq7   devfreq1   passive         267000000    89000000     267000000
soc:bus_peri                   devfreq8   devfreq1   passive         67000000     67000000     67000000
soc:bus_g2d                    devfreq9   devfreq1   passive         333000000    84000000     333000000
soc:bus_g2d_acp                devfreq10  devfreq1   passive         267000000    67000000     267000000
soc:bus_jpeg                   devfreq11  devfreq1   passive         300000000    75000000     300000000
soc:bus_jpeg_apb               devfreq12  devfreq1   passive         167000000    84000000     167000000
soc:bus_disp1_fimd             devfreq13  devfreq1   passive         200000000    120000000    200000000
soc:bus_disp1                  devfreq14  devfreq1   passive         300000000    120000000    300000000
soc:bus_gscl_scaler            devfreq15  devfreq1   passive         300000000    150000000    300000000
soc:bus_mscl                   devfreq16  devfreq1   passive         400000000    84000000     400000000

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes from v1:
- Handle exception case when DEVFREQ_GOV_PASSIVE is unset.

 drivers/devfreq/devfreq.c | 68 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index acd21345a070..44feade5977d 100644
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
@@ -1670,6 +1672,64 @@ static struct attribute *devfreq_attrs[] = {
 };
 ATTRIBUTE_GROUPS(devfreq);
 
+static int devfreq_summary_show(struct seq_file *s, void *data)
+{
+	struct devfreq *devfreq;
+	struct devfreq *parent_devfreq = NULL;
+	unsigned long cur_freq, min_freq, max_freq;
+
+	seq_printf(s, "%-30s %-10s %-10s %-15s %-12s %-12s %-12s\n",
+			"dev name",
+			"dev",
+			"parent dev",
+			"governor",
+			"cur_freq",
+			"min_freq",
+			"max_freq");
+	seq_printf(s, "%-30s %-10s %-10s %-15s %-12s %-12s %-12s\n",
+			"------------------------------",
+			"----------",
+			"----------",
+			"---------------",
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
+				parent_devfreq = data->parent;
+		} else {
+			parent_devfreq = NULL;
+		}
+#endif
+		mutex_lock(&devfreq->lock);
+		cur_freq = devfreq->previous_freq,
+		get_freq_range(devfreq, &min_freq, &max_freq);
+		mutex_unlock(&devfreq->lock);
+
+		seq_printf(s, "%-30s %-10s %-10s %-15s %-12ld %-12ld %-12ld\n",
+			dev_name(devfreq->dev.parent),
+			dev_name(&devfreq->dev),
+			parent_devfreq ? dev_name(&parent_devfreq->dev) : "",
+			devfreq->governor_name,
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
@@ -1686,6 +1746,14 @@ static int __init devfreq_init(void)
 	}
 	devfreq_class->dev_groups = devfreq_groups;
 
+	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
+	if (PTR_ERR(devfreq_debugfs) != -ENODEV && IS_ERR(devfreq_debugfs)) {
+		pr_warn("%s: couldn't create debugfs dir\n", __FILE__);
+	} else {
+		debugfs_create_file("devfreq_summary", 0444, devfreq_debugfs,
+					NULL, &devfreq_summary_fops);
+	}
+
 	return 0;
 }
 subsys_initcall(devfreq_init);
-- 
2.17.1

