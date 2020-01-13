Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAC2138A7E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 05:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbgAME4Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 23:56:16 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:38402 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387525AbgAME4Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 23:56:16 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200113045613epoutp0272d9383a629b3e3196091eeae5aaf4d0~pWVaxK4Fi1523715237epoutp02a
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2020 04:56:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200113045613epoutp0272d9383a629b3e3196091eeae5aaf4d0~pWVaxK4Fi1523715237epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578891373;
        bh=pxZIRVpnO9rN9HNWuzJ/hSvTrJnW0S+n8j9Jh+yER2Y=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KpXIvRuQ5dQmSZ4E0DZXB8vXNKzhwcPV/1YHoRpIeeiDEwe1RvRCz5pjXdmfN1pB3
         8mGJdOuVzotZmyFvpbbAXYlZ4tPw0vqSrAFYEaAxSIVZy/WyP577vYl1OfANsNW0pe
         Vnjfo3bs0UQBLbv3+JVv7T/O+oqjpZHGGNRJAxdU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200113045612epcas1p27862547ab25e0f115c6d0b4b91395991~pWVaTQX0w0403604036epcas1p2p;
        Mon, 13 Jan 2020 04:56:12 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47x1WZ1wKZzMqYkp; Mon, 13 Jan
        2020 04:56:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.7B.52419.A68FB1E5; Mon, 13 Jan 2020 13:56:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200113045609epcas1p1188f24c37f8ba230a0e3856aeb0e4d8e~pWVXKTjtK0801808018epcas1p1j;
        Mon, 13 Jan 2020 04:56:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200113045609epsmtrp127e0a3040dc538249d4f38cb66dbb083~pWVXJeGYm0546405464epsmtrp1z;
        Mon, 13 Jan 2020 04:56:09 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-48-5e1bf86aebf1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.EF.06569.968FB1E5; Mon, 13 Jan 2020 13:56:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200113045609epsmtip203cc4e245377ab8881ee7eec780dc30c~pWVW38A_b2910829108epsmtip2v;
        Mon, 13 Jan 2020 04:56:09 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v2] PM / devfreq: Add debugfs support with devfreq_summary
 file
Date:   Mon, 13 Jan 2020 14:03:24 +0900
Message-Id: <20200113050324.26232-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BMURzHnb27916x3Nk8jjXINWbU6HFbW8eOjDwvMpPBHwytO9vVpn3Z
        uyX8gUZJlGJGWiTv1WPUWioymzaDmsLkNbI04/3KICbTkLvdDP99f7/f93N+v/M7h8RUx3A1
        mWpx8HYLZ6LxIPllX2hk+Mbe8UlR1z0j0PPSbIBavd1yVPT4vhw96nmjQBVfXgBU2dkEUG91
        C4ZqytJQW9ZHArn8XxSo48pRHH3LbwboRNYuAlU1+wnUudOFzxnJVpZWArajIF/G1vlPA7be
        6SdYd/kenH36sAFna7rrZOwvp1fOFnjKAfvNPTExaE3aLCPPJfP2EN5isCanWlLi6KUr9PP0
        2pgoJpyZiWLpEAtn5uPo+QmJ4QtTTeI16JAMzpQuphI5QaAjZ8+yW9MdfIjRKjjiaN6WbLLN
        tEUInFlIt6REGKxmHRMVFa0VjevTjL72vZhtV2zmg8IyYgfwTcsDQ0lIzYDn+14pAlpF1QF4
        qWBTHggS9VcAW/OyCSn4AWD/1xvYX8L1uwaXCtdEV1e+Qgp6RLz0BxFw4VQY9L59jAf0KEoH
        W/tzsYAJo7wyWPjz08BRwdRy+LvxpQiQpJyaCn+VrQyklaL/lb8El7pNghXVjQMspD7g8HhH
        rUIqzIfV7meDIwXD9zc9hKTV8N3+nEG9DZ6/3YxLcC6AHu/dQVgDvWcOygKNMSoUXrgSKaUn
        w/q+YyCgMWoE7P6+TxGwQEoJc3NUkmUK7OjyyyQ9Dp7avWdwThaW3LkFpD2ugw3OKqwQTHD+
        a1AGQDkYw9sEcwovMDbN/6/kBgNfMyy2DlS3JzQBigT0cGXj1vFJKgWXIWwxNwFIYvQopbtd
        naRSJnNbtvJ2q96ebuKFJqAVl1eEqUcbrOJHtzj0jDZao9GgGUyMlmHosUqy9946FZXCOfg0
        nrfx9r+cjByq3gEiEqgqg/5w/QHcpHuGJ6pPXjXP1U1PGFKi2rs5/qROtyqjIX575rLTkzLP
        EZZa1Ye+BRG+xWuvZZ59/tK4+/N2m6G2GH0aNtkbfeRcsGJ1TNyS92dvdbqGf3w95NClnvhF
        D9o35XyOcd7ozy6+2OKZuvZe8JQsyhXta37SJnvTVbThHS0XjBwThtkF7g+mdusgsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvG7mD+k4g/7vfBb357UyWpze/47F
        YuKNKywW1788Z7VY/fExo8Wa24cYLX5sOMVssXFBtsXZpjfsFivufmS1uLxrDpvF594jjBYL
        m1rYLdYeuctucbtxBZsDv8eaeWsYPS739TJ57Li7hNFj56y77B6bVnWyedy5tofNY+O7HUwe
        f2ftZ/Ho27KK0ePzJrkArigum5TUnMyy1CJ9uwSujMPnupkLWswrrk5YwN7AeFiji5GTQ0LA
        RGLFv41sXYxcHEICuxklZly/zwaRkJSYdvEocxcjB5AtLHH4cDFEzSdGiVW/FzKB1LAJaEns
        f3EDrF5EwEbi7uJrLCBFzALnmSTal09lBEkIC/hLbNr5ghVkEIuAqsTfBSEgYV4BK4mnd2dC
        7ZKXWL3hAPMERp4FjAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCg1hLawfjiRPx
        hxgFOBiVeHgPVEnHCbEmlhVX5h5ilOBgVhLh3XROKk6INyWxsiq1KD++qDQntfgQozQHi5I4
        r3z+sUghgfTEktTs1NSC1CKYLBMHp1QD40oTK7n3U7nLZQN3bLqwT2bF8ZazO54U6V+Z815L
        nb/jtv8DyQenOF92T/fLXaGUUjmxeWOpe9mZnwGXy04cz992/NTsKYtFC6c+DIhKXaDs+upe
        6EnxRfseLog7nx8mUDBlyzTbe8U7X85/y2k8yzHgSnTqdlsnrvsulx6u0Xa7ElVwoy5R95gS
        S3FGoqEWc1FxIgBrXftZXgIAAA==
X-CMS-MailID: 20200113045609epcas1p1188f24c37f8ba230a0e3856aeb0e4d8e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200113045609epcas1p1188f24c37f8ba230a0e3856aeb0e4d8e
References: <CGME20200113045609epcas1p1188f24c37f8ba230a0e3856aeb0e4d8e@epcas1p1.samsung.com>
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
- cur_freq_Hz	: Current Frequency (unit: Hz)
- old_freq_Hz	: Frequency before changing. (unit: Hz)
- new_freq_Hz	: Frequency after changed. (unit: Hz)

[For example on Exynos5422-based Odroid-XU3 board]
$ cat /sys/kernel/debug/devfreq/devfreq_summary
dev_name                       dev        parent_dev governor        polling_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz
------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
10c20000.memory-controller     devfreq0              simple_ondemand          0    165000000    165000000    825000000
soc:bus_wcore                  devfreq1              simple_ondemand         50    532000000     88700000    532000000
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
Changes from v1:
- Drop the patch about 'devfreq_transitions' debugfs file
- Modify from 'hz' to 'Hz'
- Edit the indentation of 'devfreq_summary' when show summary
- Exchange sequence between PTR_ERR and IS_ERR when debugfs_create_dir

 drivers/devfreq/devfreq.c | 84 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 89260b17598f..c2ebed42704b 100644
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

