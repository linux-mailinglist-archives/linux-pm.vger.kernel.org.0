Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E47261057
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 12:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgIHK5G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 06:57:06 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:27393 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbgIHK4o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 06:56:44 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200908105641epoutp046d390d98f93777687daf8bfdbfb89ea8~yybX2XU_P2606526065epoutp04F
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 10:56:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200908105641epoutp046d390d98f93777687daf8bfdbfb89ea8~yybX2XU_P2606526065epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599562601;
        bh=3/h1YDWT+UWJPk7OaSWuXk2IGkUwoSByybC/0XHT/QY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=AeCD6m0ixd7qwniH9ZlN1fzeHgY5KuefS4cWEZ4t8R/B0znb8WLM3RfC6zHgip0aS
         PuyvPUnnp0LnqIEFAQQ3U5UI4jM4DW7VnKtmCWG6ScQ9rklzrStoWzQs20HNJ2QBOo
         0IM2Ewsv0jEZohnSOEeVICk5JISTKmAQy/Kxbbuc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200908105639epcas1p382906c54403b6bd067828554f72077da~yybWirfBK0798407984epcas1p3O;
        Tue,  8 Sep 2020 10:56:39 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Bm2C914dRzMqYkh; Tue,  8 Sep
        2020 10:56:37 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.56.19033.463675F5; Tue,  8 Sep 2020 19:56:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200908105636epcas1p20ca5e07616e942c3b2a47fc5716c14ed~yybTaKJHK1369413694epcas1p24;
        Tue,  8 Sep 2020 10:56:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200908105636epsmtrp2dd7ac7fecf6b62f7c8ee35efa1358afe~yybTYZi0D1605716057epsmtrp2D;
        Tue,  8 Sep 2020 10:56:36 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-ad-5f576364bcaf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.2D.08382.463675F5; Tue,  8 Sep 2020 19:56:36 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200908105636epsmtip133af2e0b174532f445c758111ce861e4~yybTONK-33025030250epsmtip1S;
        Tue,  8 Sep 2020 10:56:36 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, lukasz.luba@arm.com,
        b.zolnierkie@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM / devfreq: Add timer type to devfreq_summary debugfs
Date:   Tue,  8 Sep 2020 20:08:53 +0900
Message-Id: <20200908110853.19277-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7bCmrm5qcni8wftDzBYbZ6xntbj+5Tmr
        xdmmN+wWl3fNYbP43HuE0WJhUwu7xe3GFWwO7B5r5q1h9OjbsorR4/MmuQDmqGybjNTElNQi
        hdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKDlSgpliTmlQKGAxOJi
        JX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjJcfVrAXPFKr
        6N14mb2BsVGyi5GTQ0LAROJc21O2LkYuDiGBHYwSH6YfYIZwPjFKLD43iQnC+cYocf33SmaY
        limzrkAl9jJKnPwG43xhlPix7CMjSBWbgJbE/hc32EBsEYF6iSndX8FsZgEridcfu9lBbGEB
        D4lPc6aB2SwCqhKzXvaxgti8QDVPt+5nhNgmL7F6A8RNEgLL2CVa1x2EOsNF4vnKQ6wQtrDE
        q+Nb2CFsKYnP7/ayQdjVEitPHmGDaO5glNiy/wJUg7HE/qWTgc7mALpIU2L9Ln2IsKLEzt9z
        GSEO5ZN497WHFaREQoBXoqNNCKJEWeLyg7tMELakxOL2TqhVHhLNj46wgJQLCcRKrLujOoFR
        dhbC/AWMjKsYxVILinPTU4sNC4yQY2kTIzhBaZntYJz09oPeIUYmDsZDjBIczEoivF2HQuOF
        eFMSK6tSi/Lji0pzUosPMZoCw2sis5Rocj4wReaVxBuaGhkbG1uYGJqZGhoqifM+vKUQLySQ
        nliSmp2aWpBaBNPHxMEp1cC0tK94kti1D8vry/ZN/j35Rsl76TdRJfwH3E8zHRDQLCs47VYq
        7PtnRb2AZUY8K9fp6ut/eyKK60onb1MX7JDd+aRtHU+O2KMDedMqencImJQUyF84c59/FatV
        Y7znOlnR/JOM03g2qJaU7m49kLz15aID/iUiYV4hXQUrfx7XO2WqtFw8tLf4o/p6T+uEo5Oq
        KnZdrDyVyaf1vn7hdpF7ttWT7ugsWNucdPhrx+JYZpFNU+xnfTXLeX3hbkeR6jSX+V856563
        JGtfMf4ZlKRXHrlpmsDXzylfX91ZKeZ4IUXuQF7S/sW5M+ylulLkpxbN7Gg//uV1n2mt+45w
        6ZZJK9L6vRxezQlxnX9PW1GJpTgj0VCLuag4EQACROv+2QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKJMWRmVeSWpSXmKPExsWy7bCSnG5Kcni8wZlbXBYbZ6xntbj+5Tmr
        xdmmN+wWl3fNYbP43HuE0WJhUwu7xe3GFWwO7B5r5q1h9OjbsorR4/MmuQDmKC6blNSczLLU
        In27BK6Mlx9WsBc8Uqvo3XiZvYGxUbKLkZNDQsBEYsqsK0xdjFwcQgK7GSU277vLBpGQlJh2
        8ShzFyMHkC0scfhwMUTNJ0aJZ2t3MIPUsAloSex/cYMNJCEi0MooMf/cAbBmZgEbiQdznrCA
        2MICHhKf5kxjB7FZBFQlZr3sYwWxeQWsJJ5u3c8IsUxeYvWGA8wTGHkWMDKsYpRMLSjOTc8t
        NiwwzEst1ytOzC0uzUvXS87P3cQIDhktzR2M21d90DvEyMTBeIhRgoNZSYS361BovBBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXHeG4UL44QE0hNLUrNTUwtSi2CyTBycUg1MhaoTFy7+v7RMvyi/
        fcLbu9Ws8dmTnyRV2F0uTIn4xS55a8LrGY3rK3Q/6utr38lODyyQ25G9w8Ipp/RJZFt/Y+/5
        gq+d6dJKk9eIWXx8+m6tNXNf58e47u/Oc168D/0U1fVb/2bZKekV53L21XXFJJ/Yvjr1g94N
        d4vITRf1ns1zf8HxSn6StnL10xt1NabiF2+6/Ts9LefQO4cErcAP3i788UvaiozLHDvykrKN
        LG9mTrfPmpv41NU2LnrH2q95bf+SFqeyf+D3Xb5RzbaD71mpadqdgDWf9uw8nh/Tcn3Sue0s
        ++NMzsxyDrsuP6dk54v4lzYHrrx+axuqtP1hxuYp32Vee86WEL4wMWCOEktxRqKhFnNRcSIA
        8i14JIgCAAA=
X-CMS-MailID: 20200908105636epcas1p20ca5e07616e942c3b2a47fc5716c14ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200908105636epcas1p20ca5e07616e942c3b2a47fc5716c14ed
References: <CGME20200908105636epcas1p20ca5e07616e942c3b2a47fc5716c14ed@epcas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The commit 4dc3bab8687f ("PM / devfreq: Add support delayed timer for
polling mode") supports the delayed timer but this commit missed
the adding the timer type to devfreq_summary debugfs node.
Add the timer type to devfreq_summary debugfs.

Fixes: 4dc3bab8687f ("PM / devfreq: Add support delayed timer for polling mode")
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Example after adding 'timer' information to debugfs_summary debugfs node
on Odroid-XU3 board as following:
root@localhost:~# cat /sys/kernel/debug/devfreq/devfreq_summary
dev                            parent_dev                     governor        timer      polling_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz
------------------------------ ------------------------------ --------------- ---------- ---------- ------------ ------------ ------------
10c20000.memory-controller     null                           simple_ondemand delayed           100    825000000    165000000    825000000
11800000.gpu                   null                           simple_ondemand deferrable         50    420000000    177000000    600000000
soc:bus_wcore                  null                           simple_ondemand deferrable         50    532000000     88700000    532000000
soc:bus_noc                    soc:bus_wcore                  passive         null                0    111000000     66600000    111000000
soc:bus_fsys_apb               soc:bus_wcore                  passive         null                0    222000000    111000000    222000000
soc:bus_fsys2                  soc:bus_wcore                  passive         null                0    200000000     75000000    200000000
soc:bus_mfc                    soc:bus_wcore                  passive         null                0    333000000     83250000    333000000
soc:bus_gen                    soc:bus_wcore                  passive         null                0    266000000     88700000    266000000
soc:bus_peri                   soc:bus_wcore                  passive         null                0     66600000     66600000     66600000
soc:bus_g2d                    soc:bus_wcore                  passive         null                0    333000000     83250000    333000000
soc:bus_g2d_acp                soc:bus_wcore                  passive         null                0    266000000     66500000    266000000
soc:bus_jpeg                   soc:bus_wcore                  passive         null                0    300000000     75000000    300000000
soc:bus_jpeg_apb               soc:bus_wcore                  passive         null                0    166500000     83250000    166500000
soc:bus_disp1_fimd             soc:bus_wcore                  passive         null                0    200000000    120000000    200000000
soc:bus_disp1                  soc:bus_wcore                  passive         null                0    300000000    120000000    300000000
soc:bus_gscl_scaler            soc:bus_wcore                  passive         null                0    300000000    150000000    300000000
soc:bus_mscl                   soc:bus_wcore                  passive         null                0    666000000     84000000    666000000
 

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b9b27fb3291e..d4424b5d8306 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1790,20 +1790,23 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
 	struct devfreq *p_devfreq = NULL;
 	unsigned long cur_freq, min_freq, max_freq;
 	unsigned int polling_ms;
+	unsigned int timer;
 
-	seq_printf(s, "%-30s %-30s %-15s %10s %12s %12s %12s\n",
+	seq_printf(s, "%-30s %-30s %-15s %-10s %10s %12s %12s %12s\n",
 			"dev",
 			"parent_dev",
 			"governor",
+			"timer",
 			"polling_ms",
 			"cur_freq_Hz",
 			"min_freq_Hz",
 			"max_freq_Hz");
-	seq_printf(s, "%30s %30s %15s %10s %12s %12s %12s\n",
+	seq_printf(s, "%30s %30s %15s %10s %10s %12s %12s %12s\n",
 			"------------------------------",
 			"------------------------------",
 			"---------------",
 			"----------",
+			"----------",
 			"------------",
 			"------------",
 			"------------");
@@ -1827,13 +1830,15 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
 		cur_freq = devfreq->previous_freq;
 		get_freq_range(devfreq, &min_freq, &max_freq);
 		polling_ms = devfreq->profile->polling_ms;
+		timer = devfreq->profile->timer;
 		mutex_unlock(&devfreq->lock);
 
 		seq_printf(s,
-			"%-30s %-30s %-15s %10d %12ld %12ld %12ld\n",
+			"%-30s %-30s %-15s %-10s %10d %12ld %12ld %12ld\n",
 			dev_name(&devfreq->dev),
 			p_devfreq ? dev_name(&p_devfreq->dev) : "null",
 			devfreq->governor_name,
+			polling_ms ? timer_name[timer] : "null",
 			polling_ms,
 			cur_freq,
 			min_freq,
-- 
2.17.1

