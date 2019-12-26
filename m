Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A913412AA73
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2019 07:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725263AbfLZGBN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Dec 2019 01:01:13 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:17771 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfLZGBN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Dec 2019 01:01:13 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191226060110epoutp02c7104fa1006f30eec9cb68f3d1b6fdaf~j1m-ZxdvC1034410344epoutp02J
        for <linux-pm@vger.kernel.org>; Thu, 26 Dec 2019 06:01:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191226060110epoutp02c7104fa1006f30eec9cb68f3d1b6fdaf~j1m-ZxdvC1034410344epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577340070;
        bh=dHFvzogDJz1bLpDXKt9tZ9jlT21InoGtwFH7mUeuB4A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TbPuFWffRX4PTFB3mOu0PDRtxiNm1kKUV19QushjuBhcXVCcY92lY/v9unh6XT8RN
         gK7PTpqkWd/4zKERvNRvtsgX59765In0wByJisHiOpkZEEo/95ddZmxEqvJaso+OC1
         /oko4/NGTq0VwL5TLeoiPTz51QWn6/zvZoUdf5HI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191226060110epcas1p128da2b8c2e75b9216e3e879be5050e37~j1m-EaS1y3228432284epcas1p1a;
        Thu, 26 Dec 2019 06:01:10 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47jzpn1ytbzMqYkx; Thu, 26 Dec
        2019 06:01:05 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.BD.57028.E9C440E5; Thu, 26 Dec 2019 15:01:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191226060101epcas1p11a225c00bb7ab2f6b7895b4cb00b9871~j1m3RhlGt2350123501epcas1p1b;
        Thu, 26 Dec 2019 06:01:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191226060101epsmtrp29cbc59650a2f32b477118a47814aa326~j1m3QhJuG1959119591epsmtrp23;
        Thu, 26 Dec 2019 06:01:01 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-a6-5e044c9e6c31
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.89.06569.D9C440E5; Thu, 26 Dec 2019 15:01:01 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191226060101epsmtip1899b6c3efa575f8c81496045646b0ed4~j1m3GCQ2t3047630476epsmtip1x;
        Thu, 26 Dec 2019 06:01:01 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH] PM / devfreq: Add debugfs support with devfreq_summary file
Date:   Thu, 26 Dec 2019 15:07:49 +0900
Message-Id: <20191226060749.13881-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7bCmru5CH5Y4g/Or+C0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsDmwem1Z1snn0bVnF6PF5k1wAc1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsbE/siC11oVc09cZGtg
        nKLQxcjJISFgInF5w0XWLkYuDiGBHYwS+ydsYoNwPjFKLPx0nRHC+cYocWr1LlaYlnU7lzBD
        JPYySlyfsxuq5QujxP0vt9hBqtgEtCT2v7jBBmKLCFhJnP7fwQxiMwukSPT/PsMCYgsL+Ejc
        OnWEEcRmEVCVWH58ElgvL1D9t02tbBDb5CVWbzjADGE/ZZX4OcMIwnaR2LByCwuELSzx6vgW
        dghbSuLzu71QvdUSK08eATtOQqCDUWLL/gtQLxhL7F86mamLkQPoIE2J9bv0IcKKEjt/z2WE
        uJNP4t3XHlaQEgkBXomONiGIEmWJyw/uMkHYkhKL2zuhVnlIPP66HCwuJBAr8eLoHtYJjLKz
        EBYsYGRcxSiWWlCcm55abFhgiBxJmxjBSUnLdAfjlHM+hxgFOBiVeHg3pDHHCbEmlhVX5h5i
        lOBgVhLhXV3EGCfEm5JYWZValB9fVJqTWnyI0RQYeBOZpUST84EJM68k3tDUyNjY2MLE0MzU
        0FBJnJfjx8VYIYH0xJLU7NTUgtQimD4mDk6pBsZTMjYrDu6v2rzF83P09nvGUxyC/U6/WcNm
        JWBy6c3lH6vq6hmv7Cp2P1+83+tRnU7Nnhml5j+4uWbMOhvhU5fzuzmKf1XA0Q8LtM226714
        ZD8/9H/r4a+dCX8vnUnOmrkj5kTf8bvrAwT2bzz1+MPvI1IV7/rWXFQ2/J1ZcyvCk4/9w97T
        wgxBSizFGYmGWsxFxYkAKXnQHmADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBJMWRmVeSWpSXmKPExsWy7bCSnO5cH5Y4g5VfVS0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsDmwem1Z1snn0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJX
        xsT+yILXWhVzT1xka2CcotDFyMkhIWAisW7nEmYQW0hgN6PExsn1EHFJiWkXjwLFOYBsYYnD
        h4shSj4xSsx47Q5iswloSex/cYMNxBYRsJG4u/gaC0g5s0CGxP/lSiBhYQEfiVunjjCC2CwC
        qhLLj09iB7F5Bawkvm1qZYPYJC+xesMB5gmMPAsYGVYxSqYWFOem5xYbFhjlpZbrFSfmFpfm
        pesl5+duYgSHh5bWDsYTJ+IPMQpwMCrx8G5IY44TYk0sK67MPcQowcGsJMK7uogxTog3JbGy
        KrUoP76oNCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVAOjorBwX/aMM11ZDhlL
        fEqaNRuXOZ9wM37f/Gh7bobSw8olu+eeiK5MbN+Rzp522yN9/zfZEluFbX99Uuere2/62hPP
        FRjtWqrGVyzp+qHrZfMN25MLm5t8TzXXTL3LVhcVtDejmC2zu7Ft9jL/eN79wWx965lviafZ
        RErdn8GrFr9HYlbMWiWW4oxEQy3mouJEAGAKtvELAgAA
X-CMS-MailID: 20191226060101epcas1p11a225c00bb7ab2f6b7895b4cb00b9871
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191226060101epcas1p11a225c00bb7ab2f6b7895b4cb00b9871
References: <CGME20191226060101epcas1p11a225c00bb7ab2f6b7895b4cb00b9871@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add debugfs interface to provide debugging information of devfreq device.
It contains 'devfreq_summary' entry to show the summary of registered
devfreq devices as following: And the additional debugfs file will be added.
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

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 65 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index acd21345a070..d7177cc0a914 100644
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
@@ -1670,6 +1672,62 @@ static struct attribute *devfreq_attrs[] = {
 };
 ATTRIBUTE_GROUPS(devfreq);
 
+static int devfreq_summary_show(struct seq_file *s, void *data)
+{
+	struct devfreq *devfreq;
+	struct devfreq *parent_devfreq;
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
+			parent_devfreq = data->parent;
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
@@ -1686,6 +1744,13 @@ static int __init devfreq_init(void)
 	}
 	devfreq_class->dev_groups = devfreq_groups;
 
+	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
+	if (PTR_ERR(devfreq_debugfs) != -ENODEV && IS_ERR(devfreq_debugfs))
+		pr_warn("%s: couldn't create debugfs dir\n", __FILE__);
+
+	debugfs_create_file("devfreq_summary", 0444, devfreq_debugfs, NULL,
+			&devfreq_summary_fops);
+
 	return 0;
 }
 subsys_initcall(devfreq_init);
-- 
2.17.1

