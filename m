Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 396981321C2
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 09:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAGI6W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 03:58:22 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:47751 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGI6W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 03:58:22 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200107085818epoutp03f2b149b790b70897a8fd3a25766e22f8~njxEY6Ua02237122371epoutp03O
        for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2020 08:58:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200107085818epoutp03f2b149b790b70897a8fd3a25766e22f8~njxEY6Ua02237122371epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578387498;
        bh=FLa4KnUZ5rMfMlLM4VPxHFp24QTpTY3HFoTJ1AO15RE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUNbeCBRYT/mopcqJC2ouD2A2a5XEhPahctky1fl3q7eFn+cXtSi+loxSggLiyZDv
         nhpgEqCMxa27W+9Zloubh07KeOzAadbaQsTIW4rgbYOI7gMlRKSVLn0ReW0qzBA2m6
         CXA/7RqWwE2PxfLhcln9CT5hKcRzorwCJGH30vnY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200107085817epcas1p3e38ddb1e54d731ff285cf691ddf7034c~njxD3XnVz1830918309epcas1p3Z;
        Tue,  7 Jan 2020 08:58:17 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47sR9g3r5GzMqYkq; Tue,  7 Jan
        2020 08:58:15 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.6B.51241.528441E5; Tue,  7 Jan 2020 17:58:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea~njw-ojZJw1742217422epcas1p4R;
        Tue,  7 Jan 2020 08:58:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200107085812epsmtrp274fa39990b38887cf12918ac3c7c06e3~njw-nnD8Z1572115721epsmtrp2x;
        Tue,  7 Jan 2020 08:58:12 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-a4-5e1448258564
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.81.10238.428441E5; Tue,  7 Jan 2020 17:58:12 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200107085812epsmtip2a359407b35a7795572e68c44cd8d4f38~njw-a7LSb2373423734epsmtip24;
        Tue,  7 Jan 2020 08:58:12 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH 2/2] PM / devfreq: Add devfreq_transitions debugfs file
Date:   Tue,  7 Jan 2020 18:05:19 +0900
Message-Id: <20200107090519.3231-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107090519.3231-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvTPtdECrkwJ6RaMwBhcEy1irFyJq1OgYecBgfECljnQCSLd0
        ClH0AXHDRhBjIoKIEJRgQS2kMQWtJbVxQxSDG2pdonFBRRFcqjHYMhh9++65/zn/PeceElfY
        iEgyx2DhzQZORxOhkvOXZynjY9jwjIRG22j0rHoPQB3uPgk69PCuBD0YfCNFjf0vAWp67AHo
        h/0GjpprclFn0QcZavD1S1F3WxWBBkq8ANUW7ZahM16fDD3e2UAsGcc2VTcBtru0BGOdvpOA
        ba30ydgW236CfXL/IsE29zkx9nelW8KWOmyAHWiZkhqanrswm+e0vDmKN2QatTmGrGR6dZpm
        mUY9P4GJZxLRAjrKwOn5ZHp5Smr8ihxdoA06Kp/T5QVCqZwg0MpFC83GPAsflW0ULMk0b9Lq
        TImmOQKnF/IMWXMyjfokJiFhrjog3JSb3XTMgZkerdnqH7ovKQRPF1tBCAmpeXBPhVVmBaGk
        gnICWO6twsTDFwB7z9YA8fANwKpfdeBviqfnnizICsoFYH3dZpEHAfxQnhRkgoqF7rcPiSCH
        U0mwY6gYDxbCKTcGy/wf8eBFGLUS2g4elgZZQsXAVy8uY0GWU4mwt79aKppNhY329mF9SKDQ
        4PtPw2+F1C4ZLLrRKRNFy2Fh6QWJyGGw96pjJB4JB/pchMjb4enrXkJMLgbQ4e4acVBB96nD
        AWcy8LxZ8FybUgxHw9Zfx4c7xqmxsO/rAWlQAik5LN6rECXTYPdzHybyRFi3b/+IFQs7na0j
        kysB8KDVhZWBKZX/HGoAsIHxvEnQZ/ECY1L//2UtYHhPYxOd4MqtFA+gSECPkZdNDstQSLl8
        YZveAyCJ0+Hy2LjwDIVcy20r4M1GjTlPxwseoA6M8hAeGZFpDGy9waJh1HNVKhWax8xXMww9
        QU7+uLNRQWVxFj6X5028+W8eRoZEFoKKAwXRZ98qd44Z1etv8eufqe7MPEJrb7ZrL0Wfth6x
        DKoydfkbFjxQvfOVF25wr73t71IN1cd8bvjeUbu0OMI+6m5rxXo76WisjUu7ZnfZNXXauHWp
        W9J6rsj31u9gjk2K8B7d7drX9v51Rvvzn6sKWPOJGT2z07tKXJ9TpitZVkpLhGyOicXNAvcH
        21n78b0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvK6Kh0icwdbvxhb357UyWpze/47F
        YuKNKywW1788Z7VY/fExo8Wa24cYLX5sOMVssXFBtsXZpjfsFivufmS1uLxrDpvF594jjBYL
        m1rYLdYeuctucbtxBZsDv8eaeWsYPS739TJ57Li7hNFj56y77B6bVnWyedy5tofNY+O7HUwe
        f2ftZ/Ho27KK0ePzJrkArigum5TUnMyy1CJ9uwSujDWztzAV3Aqs+Pn/GksD4z37LkZODgkB
        E4lDN6+ydzFycQgJ7GaU6D6xkg0iISkx7eJR5i5GDiBbWOLw4WKImk+MEo+O72AHqWET0JLY
        /+IGWL2IgI3E3cXXWECKmAXOM0m0L5/KCJIQFnCXWNU/mRXEZhFQlXjy8DATiM0rYCnx6uM8
        Vohl8hKrNxxgBrE5Bawkvrx+D7ZACKhmzdYLjBMY+RYwMqxilEwtKM5Nzy02LDDMSy3XK07M
        LS7NS9dLzs/dxAgOey3NHYyXl8QfYhTgYFTi4bWQEo4TYk0sK67MPcQowcGsJMKrpSMSJ8Sb
        klhZlVqUH19UmpNafIhRmoNFSZz3ad6xSCGB9MSS1OzU1ILUIpgsEwenVANj5Lp/JRv582PO
        MPkuPv/2IoPE2nahjAKHSSFC7PunOfR6PJuq9uaXzqS/Pc0BWx9eff5TxDnjUu+/bWc+Zxoy
        7bc0e+j+x6Bcmc/53vQHbLPCmW2WlXD47lS/lshl8kJt7eG19UHGX1wW1v5KPZxXUn9J7efn
        xymsUu8Uzk6zTAuSSPj6sbpFiaU4I9FQi7moOBEAc0lDtncCAAA=
X-CMS-MailID: 20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea
References: <20200107090519.3231-1-cw00.choi@samsung.com>
        <CGME20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea@epcas1p4.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new devfreq_transitions debugfs file to track the frequency transitions
of all devfreq devices for the simple profiling as following:
- /sys/kernel/debug/devfreq/devfreq_transitions

And the user can decide the storage size (CONFIG_NR_DEVFREQ_TRANSITIONS)
in Kconfig in order to save the transition history.

[Detailed description of each field of 'devfreq_transitions' debugfs file]
- time_ms	: Change time of frequency transition. (unit: millisecond)
- dev_name	: Device name of h/w.
- dev		: Device name made by devfreq core.
- parent_dev	: If devfreq device uses the passive governor,
		  show parent devfreq device name.
- load_%	: If devfreq device uses the simple_ondemand governor,
		  load is used by governor whene deciding the new frequency.
		  (unit: percentage)
- old_freq_hz	: Frequency before changing. (unit: hz)
- new_freq_hz	: Frequency after changed. (unit: hz)

[For example on Exynos5422-based Odroid-XU3 board]
$ cat /sys/kernel/debug/devfreq/devfreq_transitions
time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
[snip]

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/Kconfig            |  13 +++
 drivers/devfreq/devfreq.c          | 126 +++++++++++++++++++++++++++++
 drivers/devfreq/governor.h         |   3 +
 drivers/devfreq/governor_passive.c |   2 +
 include/linux/devfreq.h            |   1 +
 5 files changed, 145 insertions(+)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 0b1df12e0f21..84936eec0ef9 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -74,6 +74,19 @@ config DEVFREQ_GOV_PASSIVE
 	  through sysfs entries. The passive governor recommends that
 	  devfreq device uses the OPP table to get the frequency/voltage.
 
+comment "DEVFREQ Debugging"
+
+config NR_DEVFREQ_TRANSITIONS
+	int "Maximum storage size to save DEVFREQ Transitions (10-1000)"
+	depends on DEBUG_FS
+	range 10 1000
+	default "100"
+	help
+	  Show the frequency transitions of all devfreq devices via
+	  '/sys/kernel/debug/devfreq/devfreq_transitions' for the simple
+	  profiling. It needs to decide the storage size to save transition
+	  history of all devfreq devices.
+
 comment "DEVFREQ Drivers"
 
 config ARM_EXYNOS_BUS_DEVFREQ
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c7f5e4e06420..7abaae06fa65 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -268,6 +268,57 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 }
 EXPORT_SYMBOL(devfreq_update_status);
 
+/**
+ * devfreq_update_transitions() - Update frequency transitions for debugfs file
+ * @devfreq:	the devfreq instance
+ * @old_freq:	the previous frequency before changing the frequency
+ * @new_freq:	the new frequency after frequency is changed
+ */
+struct devfreq_transitions {
+	struct devfreq *devfreq;
+	struct devfreq_freqs freqs;
+	unsigned long load;
+} debugfs_transitions[CONFIG_NR_DEVFREQ_TRANSITIONS];
+
+static spinlock_t devfreq_debugfs_lock;
+static int debugfs_transitions_index;
+
+void devfreq_update_transitions(struct devfreq *devfreq,
+			unsigned long old_freq, unsigned long new_freq,
+			unsigned long busy_time, unsigned long total_time)
+{
+	unsigned long load;
+	int i;
+
+	if (!devfreq_debugfs || !devfreq || (old_freq == new_freq))
+		return;
+
+	spin_lock_nested(&devfreq_debugfs_lock, SINGLE_DEPTH_NESTING);
+
+	i = debugfs_transitions_index;
+
+	/*
+	 * Calculate the load and if load is larger than 100,
+	 * initialize to 100 because the unit of load is percentage.
+	 */
+	load = (total_time == 0 ? 0 : (100 * busy_time) / total_time);
+	if (load > 100)
+		load = 100;
+
+	debugfs_transitions[i].devfreq = devfreq;
+	debugfs_transitions[i].freqs.time = ktime_to_ms(ktime_get());
+	debugfs_transitions[i].freqs.old = old_freq;
+	debugfs_transitions[i].freqs.new = new_freq;
+	debugfs_transitions[i].load = load;
+
+	if (++i == CONFIG_NR_DEVFREQ_TRANSITIONS)
+		i = 0;
+	debugfs_transitions_index = i;
+
+	spin_unlock(&devfreq_debugfs_lock);
+}
+EXPORT_SYMBOL(devfreq_update_transitions);
+
 /**
  * find_devfreq_governor() - Find devfreq governor from name
  * @name:	name of the governor
@@ -401,6 +452,10 @@ static int set_target(struct devfreq *devfreq,
 		return err;
 	}
 
+	devfreq_update_transitions(devfreq, cur_freq, new_freq,
+					devfreq->last_status.busy_time,
+					devfreq->last_status.total_time);
+
 	freqs.new = new_freq;
 	notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
 
@@ -1787,6 +1842,72 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
 
+/**
+ * devfreq_transitions_show() - Show the frequency transitions of the registered
+ *			devfreq devices via 'devfreq_transitions' debugfs file.
+ */
+static int devfreq_transitions_show(struct seq_file *s, void *data)
+{
+	struct devfreq *devfreq = NULL;
+	struct devfreq *p_devfreq = NULL;
+	struct devfreq_freqs *freqs = NULL;
+	unsigned long load;
+	int i = debugfs_transitions_index;
+	int count;
+
+	seq_printf(s, "%-10s %-30s %-10s %-10s %-6s %-12s %-12s\n",
+			"time_ms",
+			"dev_name",
+			"dev",
+			"parent_dev",
+			"load_%",
+			"old_freq_hz",
+			"new_freq_hz");
+	seq_printf(s, "%-10s %-30s %-10s %-10s %-6s %-12s %-12s\n",
+			"----------",
+			"------------------------------",
+			"----------",
+			"----------",
+			"----------",
+			"------------",
+			"------------");
+
+	spin_lock(&devfreq_debugfs_lock);
+	for (count = 0; count < CONFIG_NR_DEVFREQ_TRANSITIONS; count++) {
+		devfreq = debugfs_transitions[i].devfreq;
+		freqs = &debugfs_transitions[i].freqs;
+		load = debugfs_transitions[i].load;
+
+		i = (CONFIG_NR_DEVFREQ_TRANSITIONS == ++i) ? 0 : i;
+		if (!devfreq)
+			continue;
+
+#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
+		if (!strncmp(devfreq->governor_name,
+				DEVFREQ_GOV_PASSIVE, DEVFREQ_NAME_LEN)) {
+			struct devfreq_passive_data *data = devfreq->data;
+
+			if (data)
+				p_devfreq = data->parent;
+		} else {
+			p_devfreq = NULL;
+		}
+#endif
+		seq_printf(s, "%-10lld %-30s %-10s %-10s %-6ld %-12ld %-12ld\n",
+			freqs->time,
+			dev_name(devfreq->dev.parent),
+			dev_name(&devfreq->dev),
+			p_devfreq ? dev_name(&p_devfreq->dev) : "",
+			load,
+			freqs->old,
+			freqs->new);
+	}
+	spin_unlock(&devfreq_debugfs_lock);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(devfreq_transitions);
+
 static int __init devfreq_init(void)
 {
 	devfreq_class = class_create(THIS_MODULE, "devfreq");
@@ -1808,9 +1929,14 @@ static int __init devfreq_init(void)
 		devfreq_debugfs = NULL;
 		pr_warn("%s: couldn't create debugfs dir\n", __FILE__);
 	} else {
+		spin_lock_init(&devfreq_debugfs_lock);
+
 		debugfs_create_file("devfreq_summary", 0444,
 				devfreq_debugfs, NULL,
 				&devfreq_summary_fops);
+		debugfs_create_file("devfreq_transitions", 0444,
+				devfreq_debugfs, NULL,
+				&devfreq_transitions_fops);
 	}
 
 	return 0;
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index dc7533ccc3db..01eecfdaf2d6 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -68,6 +68,9 @@ extern int devfreq_add_governor(struct devfreq_governor *governor);
 extern int devfreq_remove_governor(struct devfreq_governor *governor);
 
 extern int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
+extern void devfreq_update_transitions(struct devfreq *devfreq,
+			unsigned long old_freq, unsigned long new_freq,
+			unsigned long busy_time, unsigned long total_time);
 
 static inline int devfreq_update_stats(struct devfreq *df)
 {
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index be6eeab9c814..05fa654239f5 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -109,6 +109,8 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
 	if (ret < 0)
 		goto out;
 
+	devfreq_update_transitions(devfreq, devfreq->previous_freq, freq, 0, 0);
+
 	if (devfreq->profile->freq_table
 		&& (devfreq_update_status(devfreq, freq)))
 		dev_err(&devfreq->dev,
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 49cdb2378030..933692e5d867 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -196,6 +196,7 @@ struct devfreq {
 };
 
 struct devfreq_freqs {
+	s64 time;
 	unsigned long old;
 	unsigned long new;
 };
-- 
2.17.1

