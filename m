Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D063713D34E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 05:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgAPE4E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 23:56:04 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:33185 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731041AbgAPE4E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 23:56:04 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200116045602epoutp0137dab788060d7d638b369ba8dcbbfefc~qRRHKjUiQ1946819468epoutp01e
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 04:56:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200116045602epoutp0137dab788060d7d638b369ba8dcbbfefc~qRRHKjUiQ1946819468epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579150562;
        bh=iDdGFC80liuLcCitIx5Z1XeLoon4zcp2MZNcH7otOlQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mecyRj9mxWSEr4vrb5CVLVIh8YIrZPGggv1GxvaMvZOA9kIITRrYCha3Ypx1zQ9PB
         tjEi8TQaXgpgPd88Sjup8VDcg4Nu91KQ4q54qqHbfVSNTvgkERV5AnQCL395dXro9u
         gOIWuPdd4XgvfV12xIYO9uwMxgMQCXrZQ0FZ8e2M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200116045601epcas1p3f64891f092781441f6e79e4d94c115b6~qRRGdgfMn1158411584epcas1p3t;
        Thu, 16 Jan 2020 04:56:01 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47ysMy5YrvzMqYkb; Thu, 16 Jan
        2020 04:55:58 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.BE.48498.EDCEF1E5; Thu, 16 Jan 2020 13:55:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200116045558epcas1p2801d3b213c0993a7a56f8317b5bd1074~qRRDopu2J1519915199epcas1p2D;
        Thu, 16 Jan 2020 04:55:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200116045558epsmtrp2ef6bd1725719bdbd850aa01cf448b335~qRRDnuVMx1723617236epsmtrp2X;
        Thu, 16 Jan 2020 04:55:58 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-5e-5e1fecde33c9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.CF.10238.EDCEF1E5; Thu, 16 Jan 2020 13:55:58 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200116045557epsmtip1a2c2d4bb218449a24357a4ab18dfc0bd~qRRDWnUhj2145121451epsmtip1F;
        Thu, 16 Jan 2020 04:55:57 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v4] PM / devfreq: Add debugfs support with devfreq_summary
 file
Date:   Thu, 16 Jan 2020 14:03:13 +0900
Message-Id: <20200116050313.3564-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmge69N/JxBmdealvcn9fKaHF6/zsW
        i4k3rrBYXP/ynNVi9cfHjBZrbh9itPix4RSzxcYF2RZnm96wW6y4+5HV4vKuOWwWn3uPMFos
        bGpht1h75C67xe3GFWwO/B5r5q1h9Ljc18vksePuEkaPnbPusntsWtXJ5nHn2h42j43vdjB5
        /J21n8Wjb8sqRo/Pm+QCuKKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPIS
        c1NtlVx8AnTdMnOA3lBSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW6BUn5haX
        5qXrJefnWhkaGBiZAhUmZGesv9zMXnDGouLpykfsDYw/NLsYOTkkBEwkur5dZ+9i5OIQEtjB
        KLG9bzEbhPOJUWLHk1vsIFVCAt8YJZ70x8N0TFnwngmiaC+jxK3P0xghnC+MEn9edLKCVLEJ
        aEnsf3GDDcQWEbCSOP2/gxmkiFlgP5PEhJ9vmUESwgKBEoeebAdbwSKgKnH14xqwZl4BS4m9
        t1cwQ6yTl1i94QBYs4TAazaJTT//sEMkXCTOfelkg7CFJV4d3wIVl5L4/G4vVLxaYuXJI2wQ
        zR2MElv2X2CFSBhL7F86GegJDqCTNCXW79KHCCtK7Pw9lxHEZhbgk3j3tYcVpERCgFeio00I
        okRZ4vKDu0wQtqTE4naYEzwkNu16yQYJrliJqVOmsU5glJ2FsGABI+MqRrHUguLc9NRiwwIj
        5GjaxAhOm1pmOxgXnfM5xCjAwajEw3vgn1ycEGtiWXFl7iFGCQ5mJRHekzNk44R4UxIrq1KL
        8uOLSnNSiw8xmgJDbyKzlGhyPjCl55XEG5oaGRsbW5gYmpkaGiqJ87osAJojkJ5YkpqdmlqQ
        WgTTx8TBKdXAmPrL04jn4ZnFC069KjqReMDoTYfEeb4/n4xraq6csNtktmRuV3eUP5cVZ+X1
        DtYXjNFT3UJPCDxOX5Fldr9RJYyXJe9GgJuQ/YnLk434OkReTK2advsvZ5ichYvWtVlXdjyr
        exb6ctreJ82nr8+a6tG/uaTj8O3DKu/0ls3wcA+8/5d9XmDbTSWW4oxEQy3mouJEAG8IMmOx
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSnO69N/JxBhOnc1ncn9fKaHF6/zsW
        i4k3rrBYXP/ynNVi9cfHjBZrbh9itPix4RSzxcYF2RZnm96wW6y4+5HV4vKuOWwWn3uPMFos
        bGpht1h75C67xe3GFWwO/B5r5q1h9Ljc18vksePuEkaPnbPusntsWtXJ5nHn2h42j43vdjB5
        /J21n8Wjb8sqRo/Pm+QCuKK4bFJSczLLUov07RK4MtZfbmYvOGNR8XTlI/YGxh+aXYycHBIC
        JhJTFrxn6mLk4hAS2M0oMae9jR0iISkx7eJR5i5GDiBbWOLw4WKImk+MEqtXHmQGqWET0JLY
        /+IGG4gtImAjcXfxNRaQImaB80wS7cunMoIkhAX8JR49PQbWwCKgKnH14xpWEJtXwFJi7+0V
        zBDL5CVWbzjAPIGRZwEjwypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOAw1tLcwXh5
        SfwhRgEORiUe3ow/cnFCrIllxZW5hxglOJiVRHhPzpCNE+JNSaysSi3Kjy8qzUktPsQozcGi
        JM77NO9YpJBAemJJanZqakFqEUyWiYNTqoFx1mRm7gqhcqGmFa4rUjqO7XdTES7OE5vhL1lp
        b/VIIJJLYIpWGYdq54VjU6pvn+d9FPTcc+/yswzpAv8MlYSW3ctcsclay3S32eKWOb5OP86p
        lTFv31vi3221fPbnEM2F67zX397y19WmZuWNSeoP/8YpTYhaHKnlsn2rygabyAmuF64vWP5D
        iaU4I9FQi7moOBEAHesQzF8CAAA=
X-CMS-MailID: 20200116045558epcas1p2801d3b213c0993a7a56f8317b5bd1074
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200116045558epcas1p2801d3b213c0993a7a56f8317b5bd1074
References: <CGME20200116045558epcas1p2801d3b213c0993a7a56f8317b5bd1074@epcas1p2.samsung.com>
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
		  show parent devfreq device name. Otherwise, show 'null'.
- governor	: Devfreq governor.
- polling_ms	: If devfreq device uses the simple_ondemand governor,
		  polling_ms is necessary for the period. (unit: millisecond)
- cur_freq_Hz	: Current Frequency (unit: Hz)
- old_freq_Hz	: Frequency before changing. (unit: Hz)
- new_freq_Hz	: Frequency after changed. (unit: Hz)

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

