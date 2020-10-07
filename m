Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5961D2857FA
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 06:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgJGEx4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 00:53:56 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:54212 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgJGExy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 00:53:54 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201007045350epoutp0268bfa3e691a7ebcd0ee8711131486198~7nL2rEpcT2805428054epoutp02l
        for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2020 04:53:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201007045350epoutp0268bfa3e691a7ebcd0ee8711131486198~7nL2rEpcT2805428054epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602046430;
        bh=pxlhRaqmvfTwjiGcpFoVPymdhEzQEi9+s+qyM1Oj768=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A/S4WQgx0R18r9OHZ30h1XqGyaFjEa+UUwniqpOZeUAo+NVYzKqxzfEJwxsptMn4R
         dDW7CAIIeTcgdjIO1XVmJww9/3OAw2cj5m02hU4GZkeowYg/Id2CWRNYbRf6hv9L7i
         uQciu82urrMQJHLAUdqnltsjDCshK4Shcyub+/50=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201007045349epcas1p2a6d200893f0f1d42b3b02e61703183b3~7nL1AEpLj2664026640epcas1p2F;
        Wed,  7 Oct 2020 04:53:49 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4C5hn64vlvzMqYmH; Wed,  7 Oct
        2020 04:53:46 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.66.10463.6D94D7F5; Wed,  7 Oct 2020 13:53:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201007045340epcas1p4e63955385b1841f44e7a07e2d5d962c4~7nLtB1O0O1244212442epcas1p4K;
        Wed,  7 Oct 2020 04:53:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201007045340epsmtrp19a4fbd8f645d0c331e07ac5e15c54ed5~7nLtA3p5c1492114921epsmtrp11;
        Wed,  7 Oct 2020 04:53:40 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-0f-5f7d49d62913
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.E7.08604.4D94D7F5; Wed,  7 Oct 2020 13:53:40 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201007045340epsmtip2aaf9f296f80f062e7a73e8672180e380~7nLsryXkL2035820358epsmtip2q;
        Wed,  7 Oct 2020 04:53:40 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     digetx@gmail.com, leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v3 1/2] PM / devfreq: Add governor feature flag
Date:   Wed,  7 Oct 2020 14:07:02 +0900
Message-Id: <20201007050703.20759-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201007050703.20759-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmvu41z9p4g7b9shbLLh1ltNg4Yz2r
        xcQbV1gsrn95zmqx+uNjRos1tw8xWvzYcIrZomXWIhaLBZ9msFqcbXrDbrHi7kdWi8u75rBZ
        fO49wmjR+WUWm8XCphZ2i9uNK9gsfu6ax+Ig6LFm3hpGjx13lzB67Jx1l91j06pONo/e5nds
        Hhvf7WDy+DtrP4tH35ZVjB6fN8kFcEZl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
        WpgrKeQl5qbaKrn4BOi6ZeYAPaOkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs
        0CtOzC0uzUvXS87PtTI0MDAyBSpMyM6Y/281e8FUq4rWA4+ZGxi/6HcxcnJICJhInH/YxdTF
        yMUhJLCDUaLlbgczhPMJyGk5xw7hfGOU+LzgLRNMy+O5T1kgEnsZJTZuO8EK4XxhlJhwZx8z
        SBWbgJbE/hc32LoYOThEBCIlmk8KgtQwC1xkkph7dwU7SI2wgL3Ep9b3YFNZBFQluqcdYQWx
        eQWsJHb9vsQOsU1eYvWGA2AzOQWsJfb/m8QIEd/CIfFjTwCE7SJx4VQHVFxY4tXxLVC9UhIv
        +9ug7GqJlSePsIEcISHQwSixZf8FVoiEscT+pZOZQA5lFtCUWL8LGjCKEjt/zwWbySzAJ/Hu
        aw8rSImEAK9ER5sQRImyxOUHd6GBIimxuL2TDcL2kDj2fB80GPsYJZZM72GdwCg3C2HDAkbG
        VYxiqQXFuempxYYFJshRtokRnFq1LHYwzn37Qe8QIxMH4yFGCQ5mJRHedO+aeCHelMTKqtSi
        /Pii0pzU4kOMpsDAm8gsJZqcD0zueSXxhqZGxsbGFiaGZqaGhkrivA9vKcQLCaQnlqRmp6YW
        pBbB9DFxcEo1MHFuWBxT4lFjEJWZlB/z6YAQw5zOKXuF5KOD4w9MfVnVf0vE8k7GghanZz3V
        l18euZ49/VXEpEWPnxQLfn+yQe34o4TcbZocHZezLq+vLrC3uDhROoPLQnqJQumyrUZBK71W
        Rf3Yduqiyj9ju4UhdW0i+5eah8xh+udcytR9b87S48Yb9uu2s7uu3qtprfpwXe4aAftO58rA
        lt8u1tfrO3Y8SWXbphn3ehYHK+ex+9om53aaTmuSU9pVsfnyhvIe3Xn31hzPO7kw0vRpDWvr
        0nmGkm8652+8cWfKs29HC3p4qhuWKGgrevw8EbyNf+OUOjG9Dt8t/nb7d69rq3+SOFfvteyD
        JUeZl3sXP9PbI6TEUpyRaKjFXFScCABwSzVsNgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSvO4Vz9p4gwlbxCyWXTrKaLFxxnpW
        i4k3rrBYXP/ynNVi9cfHjBZrbh9itPix4RSzRcusRSwWCz7NYLU42/SG3WLF3Y+sFpd3zWGz
        +Nx7hNGi88ssNouFTS3sFrcbV7BZ/Nw1j8VB0GPNvDWMHjvuLmH02DnrLrvHplWdbB69ze/Y
        PDa+28Hk8XfWfhaPvi2rGD0+b5IL4IzisklJzcksSy3St0vgypj/bzV7wVSritYDj5kbGL/o
        dzFyckgImEg8nvuUpYuRi0NIYDejxO9JB9khEpIS0y4eZe5i5ACyhSUOHy6GqPnEKLH/XC8z
        SA2bgJbE/hc32EBsEYFoicUfPzKDFDELPGaS2H/rCtggYQF7iU+t75lAbBYBVYnuaUdYQWxe
        ASuJXb8vQS2Tl1i94QDYUE4Ba4n9/yYxgthCQDXXunaxT2DkW8DIsIpRMrWgODc9t9iwwDAv
        tVyvODG3uDQvXS85P3cTIzgGtDR3MG5f9UHvECMTB+MhRgkOZiUR3nTvmngh3pTEyqrUovz4
        otKc1OJDjNIcLErivDcKF8YJCaQnlqRmp6YWpBbBZJk4OKUamMru6FzJ7SzxbBH+1zLP/16s
        lLjwtyubhe9f+fX8GKfIyZZt799wNrImHFYr/+X2k433oOlO+fZDjhe5FgloLoxPmGD2uzVw
        A2vVNEV1ljCzK0ubmyaxCn2eL/F5PUvENUahdTPd3+9J/n35kHNO3YVdTkkTpbP/LCvv//75
        mFuIQtjbdLYA6dfqryX15EJEz5/ewNTn8zJE+npAY9+SoteNXycZHObbdFrtEmOZltXta3vn
        q4swq25hzqm7tPrs2dAawYp+J6ZOFeuG6Xw1r6ZqrcnhdNyQo8Xw+9uNWRlzvb8oMsYczLwj
        tqdpRVz5BbEqtpKj1zlrz14pVf0irn42yWHDXLG7nKzG3kaCSizFGYmGWsxFxYkABSUIVPAC
        AAA=
X-CMS-MailID: 20201007045340epcas1p4e63955385b1841f44e7a07e2d5d962c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201007045340epcas1p4e63955385b1841f44e7a07e2d5d962c4
References: <20201007050703.20759-1-cw00.choi@samsung.com>
        <CGME20201007045340epcas1p4e63955385b1841f44e7a07e2d5d962c4@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq governor is able to have the specific flag as follows
in order to implement the specific feature. For example, devfreq allows
user to change the governors on runtime via sysfs interface.
But, if devfreq device uses 'passive' governor, don't allow user to change
the governor. For this case, define the DEVFREQ_GOV_FLAT_IMMUTABLE
and set it to flag of passive governor.

[Definition for governor flag]
- DEVFREQ_GOV_FLAG_IMMUTABLE
  : If immutable flag is set, governor is never changeable to other governors.
- DEVFREQ_GOV_FLAG_IRQ_DRIVEN
  : Devfreq core won't schedule polling work for this governor if value is set.

[Table of governor flag for devfreq governors]
------------------------------------------------------------------------------
                      | simple    | perfor | power | user | passive | tegra30
		      | ondemand  | mance  | save  | space|         |
------------------------------------------------------------------------------
immutable             | X         | X      | X     | X    | O       | O
interrupt_driven      | X(polling)| X      | X     | X    | X       | O (irq)
------------------------------------------------------------------------------

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c          | 18 ++++++++++--------
 drivers/devfreq/governor.h         | 18 ++++++++++++------
 drivers/devfreq/governor_passive.c |  2 +-
 drivers/devfreq/tegra30-devfreq.c  |  4 ++--
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 861c100f9fac..ce793fc9a558 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -31,6 +31,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/devfreq.h>
 
+#define IS_SUPPORTED_FLAG(f, name) ((f & DEVFREQ_GOV_FLAG_##name) ? true : false)
 #define HZ_PER_KHZ	1000
 
 static struct class *devfreq_class;
@@ -456,7 +457,7 @@ static void devfreq_monitor(struct work_struct *work)
  */
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
-	if (devfreq->governor->interrupt_driven)
+	if (IS_SUPPORTED_FLAG(devfreq->governor->flag, IRQ_DRIVEN))
 		return;
 
 	switch (devfreq->profile->timer) {
@@ -486,7 +487,7 @@ EXPORT_SYMBOL(devfreq_monitor_start);
  */
 void devfreq_monitor_stop(struct devfreq *devfreq)
 {
-	if (devfreq->governor->interrupt_driven)
+	if (IS_SUPPORTED_FLAG(devfreq->governor->flag, IRQ_DRIVEN))
 		return;
 
 	cancel_delayed_work_sync(&devfreq->work);
@@ -517,7 +518,7 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
 	devfreq->stop_polling = true;
 	mutex_unlock(&devfreq->lock);
 
-	if (devfreq->governor->interrupt_driven)
+	if (IS_SUPPORTED_FLAG(devfreq->governor->flag, IRQ_DRIVEN))
 		return;
 
 	cancel_delayed_work_sync(&devfreq->work);
@@ -540,7 +541,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 	if (!devfreq->stop_polling)
 		goto out;
 
-	if (devfreq->governor->interrupt_driven)
+	if (IS_SUPPORTED_FLAG(devfreq->governor->flag, IRQ_DRIVEN))
 		goto out_update;
 
 	if (!delayed_work_pending(&devfreq->work) &&
@@ -580,7 +581,7 @@ void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay)
 	if (devfreq->stop_polling)
 		goto out;
 
-	if (devfreq->governor->interrupt_driven)
+	if (IS_SUPPORTED_FLAG(devfreq->governor->flag, IRQ_DRIVEN))
 		goto out;
 
 	/* if new delay is zero, stop polling */
@@ -1347,7 +1348,8 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (df->governor == governor) {
 		ret = 0;
 		goto out;
-	} else if (df->governor->immutable || governor->immutable) {
+	} else if (IS_SUPPORTED_FLAG(df->governor->flag, IMMUTABLE)
+		|| IS_SUPPORTED_FLAG(governor->flag, IMMUTABLE)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1402,7 +1404,7 @@ static ssize_t available_governors_show(struct device *d,
 	 * The devfreq with immutable governor (e.g., passive) shows
 	 * only own governor.
 	 */
-	if (df->governor->immutable) {
+	if (IS_SUPPORTED_FLAG(df->governor->flag, IMMUTABLE)) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
 				  "%s ", df->governor_name);
 	/*
@@ -1413,7 +1415,7 @@ static ssize_t available_governors_show(struct device *d,
 		struct devfreq_governor *governor;
 
 		list_for_each_entry(governor, &devfreq_governor_list, node) {
-			if (governor->immutable)
+			if (IS_SUPPORTED_FLAG(governor->flag, IMMUTABLE))
 				continue;
 			count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
 					   "%s ", governor->name);
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index ae4d0cc18359..540e59ef467c 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -25,14 +25,21 @@
 #define DEVFREQ_MIN_FREQ			0
 #define DEVFREQ_MAX_FREQ			ULONG_MAX
 
+/*
+ * Definition of the governor feature flags
+ * - DEVFREQ_GOV_FLAG_IMMUTABLE
+ *   : This governor is never changeable to other governors.
+ * - DEVFREQ_GOV_FLAG_IRQ_DRIVEN
+ *   : The devfreq won't schedule the work for this governor.
+ */
+#define DEVFREQ_GOV_FLAG_IMMUTABLE			BIT(0)
+#define DEVFREQ_GOV_FLAG_IRQ_DRIVEN			BIT(1)
+
 /**
  * struct devfreq_governor - Devfreq policy governor
  * @node:		list node - contains registered devfreq governors
  * @name:		Governor's name
- * @immutable:		Immutable flag for governor. If the value is 1,
- *			this governor is never changeable to other governor.
- * @interrupt_driven:	Devfreq core won't schedule polling work for this
- *			governor if value is set to 1.
+ * @flag:		Governor's feature flag
  * @get_target_freq:	Returns desired operating frequency for the device.
  *			Basically, get_target_freq will run
  *			devfreq_dev_profile.get_dev_status() to get the
@@ -50,8 +57,7 @@ struct devfreq_governor {
 	struct list_head node;
 
 	const char name[DEVFREQ_NAME_LEN];
-	const unsigned int immutable;
-	const unsigned int interrupt_driven;
+	const u64 flag;
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 	int (*event_handler)(struct devfreq *devfreq,
 				unsigned int event, void *data);
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index be6eeab9c814..432a4cc683f7 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -180,7 +180,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_passive = {
 	.name = DEVFREQ_GOV_PASSIVE,
-	.immutable = 1,
+	.flag = DEVFREQ_GOV_FLAG_IMMUTABLE,
 	.get_target_freq = devfreq_passive_get_target_freq,
 	.event_handler = devfreq_passive_event_handler,
 };
diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index f5e74c2ede85..868c72cc0276 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -765,10 +765,10 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor tegra_devfreq_governor = {
 	.name = "tegra_actmon",
+	.flag = DEVFREQ_GOV_FLAG_IMMUTABLE
+		| DEVFREQ_GOV_FLAG_IRQ_DRIVEN,
 	.get_target_freq = tegra_governor_get_target,
 	.event_handler = tegra_governor_event_handler,
-	.immutable = true,
-	.interrupt_driven = true,
 };
 
 static int tegra_devfreq_probe(struct platform_device *pdev)
-- 
2.17.1

