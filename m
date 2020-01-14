Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF92139F22
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 02:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgANBif (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 20:38:35 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:26748 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgANBif (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 20:38:35 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200114013832epoutp03653ed8510f1f374a7d006fe0b27b1046~pnSGvcjLx2132921329epoutp03d
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 01:38:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200114013832epoutp03653ed8510f1f374a7d006fe0b27b1046~pnSGvcjLx2132921329epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578965912;
        bh=40Qjhl7/bsoh8/b6nDZKJ+jsxa9vRFaj9EK5qOjIRvo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tSrwaGeiX0sNnOqXLSxfLMMNM+JdlTzRqDnwlaKzo24fAEKDs88/fyZ5j7Rg103wh
         bd0EIYnWga5/1Fpy4PSLcfV+TpEc8ykk+yBDmkIIBez826jrIdEHxrBEkRFSIxBNxC
         OzbWAr4D3552IDIOVYL0pWJnV4UdMcX9bD+fBIJk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200114013830epcas1p279109c8356f6566edf9a49aefa666c37~pnSFNI-cK2249322493epcas1p21;
        Tue, 14 Jan 2020 01:38:30 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47xY4z36lCzMqYkV; Tue, 14 Jan
        2020 01:38:27 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.8D.48498.39B1D1E5; Tue, 14 Jan 2020 10:38:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200114013826epcas1p23a4c6c39f043dd09d33d48541288c1bd~pnSBOVAVL2242722427epcas1p22;
        Tue, 14 Jan 2020 01:38:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200114013826epsmtrp2517f26a56fb027e7c55504a0e50fee24~pnSBNg8VZ2948129481epsmtrp2I;
        Tue, 14 Jan 2020 01:38:26 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-77-5e1d1b933ecd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.5C.10238.29B1D1E5; Tue, 14 Jan 2020 10:38:26 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200114013826epsmtip193d10ddf60136164f16cf07570ffdc71~pnSA7_XCv0374303743epsmtip1R;
        Tue, 14 Jan 2020 01:38:26 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v3] PM / devfreq: Add debugfs support with devfreq_summary
 file
Date:   Tue, 14 Jan 2020 10:45:40 +0900
Message-Id: <20200114014540.31490-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURT1ddrpiFbHCvqoijjGGEjADrX4IGDcouPygZEfjVIndNIS2mnT
        aY3LD+4tCkIMiaIliEsUa0BEQZBUK8YggmJdEKxo/MCNGkQFNC6lU6N/591zTs69910CU7px
        FZHH2zkbz5ooPEp67XZCctLRGbNy1MPDMaivYj9A7d6gFJV2P5aiZ1/6Zeji4BuAPL0+gEZq
        72HocmU+6tjzUY7OBwZlyN90EkdDRa0AndqzT44utQbkqHf3eXzJZMZT4QGMv7hIwjQGzgDm
        enlAztRVu3DmxdMbOHM52ChhfpZ7pUxxfTVghurisqI25WcYOVbP2eI5Pteiz+MNmdTaDbrl
        Om2qmk6i09AiKp5nzVwmtWJdVtLKPFNoDCp+G2tyhEpZrCBQCxZn2CwOOxdvtAj2TIqz6k3W
        NGuywJoFB29IzrWY02m1OkUbEm7NNzofUFYX2l6+f0RaABoSCsF4ApIL4YETHqwQRBFKshHA
        nw0/pGOEkvwM4IuWJJH4BqD/xC/sr6Og+aVEJFoArKo5Fnl8AbD7XE9YhZOJ0Pu2Gx/D0WQ6
        bP/tDGdgpFcCS0YHwqKp5Hr4O1AZzpOS82Dp42AYK0KGftdJXIybDS/W3gybIdmPQ1dXQ4RY
        AfcePiQX8VT4/m59BKvgULAlotkFL7S14qLZCWC996FMJDTQe/ZoqG8i1FICrGlaIJbnwOs/
        3GAMY+QkGPx6WDYmgaQCOg8oRclc6H8VkIg4Fp4+6IpEMbC2/wku7m4LLCt5j5WAWeX/AioB
        qAbTOKtgNnACbU35/5fqQPg0E1MbQVXnOh8gCUBNVBTwM3OUMnabsMPsA5DAqGhFXacqR6nQ
        szt2cjaLzuYwcYIPaEPbK8VUMbmW0KHzdh2tTdFoNGghnaqlaWq6ghjp2qIkDaydy+c4K2f7
        65MQ41UFYH3X8wy3ButpTz9S8WHg2wD+9krb/M1ETcenMmsHHl22mvm+5GFtjLPwnW9KZzPu
        jlXbWzKPB7InEK/HOWw9fXcsTYWjRVebo7KXeoZb7x/zv1u75nNx9ap9fcaAZ1nMWTerbzbE
        tjUo4pan+z/d2rho/tODaWmPos3quLiq3TqekgpGlk7EbAL7Bxfjy7mwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnO4kadk4g30fhSzuz2tltDi9/x2L
        xcQbV1gsrn95zmqx+uNjRos1tw8xWvzYcIrZYuOCbIuzTW/YLVbc/chqcXnXHDaLz71HGC0W
        NrWwW6w9cpfd4nbjCjYHfo8189Ywelzu62Xy2HF3CaPHzll32T02repk87hzbQ+bx8Z3O5g8
        /s7az+LRt2UVo8fnTXIBXFFcNimpOZllqUX6dglcGR3nlQo6LSpmtf5gaWDcrtnFyMkhIWAi
        0bD7HlMXIxeHkMBuRolrp1+xQiQkJaZdPMrcxcgBZAtLHD5cDFHziVHi+9ZTTCA1bAJaEvtf
        3GADsUUEbCTuLr7GAlLELHCeSaJ9+VRGkISwgL/EiacvWEBsFgFViYlX3oHZvAJWEs8757BB
        LJOXWL3hAPMERp4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCg1hLcwfj5SXx
        hxgFOBiVeHgb8mTihFgTy4orcw8xSnAwK4nwbjonFSfEm5JYWZValB9fVJqTWnyIUZqDRUmc
        92nesUghgfTEktTs1NSC1CKYLBMHp1QDY7ftyvat3yfXGMxs4zcxXyF8cUKK7X2DX0Z7ND8d
        kA5cEuEhPvfBzfTmBLvrwYU1X587m78u+FdreyFP48SSgpy8YzLmgn+jJ+t87qj7mdaTKz9N
        LnTBhztXepwWck59JDht/+qfe+IdOvtMY/TC9q5brRZuofGBrfQ1f+Gu/RNvRm361Kw8U4ml
        OCPRUIu5qDgRAIQrCYFeAgAA
X-CMS-MailID: 20200114013826epcas1p23a4c6c39f043dd09d33d48541288c1bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200114013826epcas1p23a4c6c39f043dd09d33d48541288c1bd
References: <CGME20200114013826epcas1p23a4c6c39f043dd09d33d48541288c1bd@epcas1p2.samsung.com>
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
Changes from v2:
- Show 'null' at 'parent_dev' field when governor of devfreq device
  is not passive
Changes from v1:
- Drop the patch about 'devfreq_transitions' debugfs file
- Modify from 'hz' to 'Hz'
- Edit the indentation of 'devfreq_summary' when show summary
- Exchange sequence between PTR_ERR and IS_ERR when debugfs_create_dir

 drivers/devfreq/devfreq.c | 84 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 89260b17598f..c5ef2d194b1b 100644
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
@@ -1643,6 +1645,79 @@ static struct attribute *devfreq_attrs[] = {
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
+		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
+							DEVFREQ_NAME_LEN)) {
+			struct devfreq_passive_data *data = devfreq->data;
+
+			if (data)
+				p_devfreq = data->parent;
+		} else {
+			p_devfreq = NULL;
+		}
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
@@ -1659,6 +1734,15 @@ static int __init devfreq_init(void)
 	}
 	devfreq_class->dev_groups = devfreq_groups;
 
+	devfreq_debugfs = debugfs_create_dir("devfreq", NULL);
+	if (IS_ERR(devfreq_debugfs) && PTR_ERR(devfreq_debugfs) != -ENODEV) {
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

