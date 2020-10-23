Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5AA296CAB
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 12:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462039AbgJWKSo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 06:18:44 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:24332 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461955AbgJWKSm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 06:18:42 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201023101837epoutp03bef1ff63939caf6e23137e9a3eb13c81~Al7-e_SUu1054510545epoutp035
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 10:18:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201023101837epoutp03bef1ff63939caf6e23137e9a3eb13c81~Al7-e_SUu1054510545epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603448317;
        bh=gSpjwtDZAIGXpaZRGaF4nnwdZdJaDTvK17CG4sljlkk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cQ1FbNMjJVtMWLGUPqPf2YTLcz2/zsO8oMwDLICju+dRIkQnsWH15CsmL8ZBVzzyW
         2zvYjAoA/l0MQz2ZtRQBR0aZMUH+JrB5n+9GneDTp7OenMFNOb+V0e/q8OH46BcNhF
         sxTFCrUsnOCHDtwD5gVUcugMbOLVFyQlk9CKjrzY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201023101837epcas1p1a896c5da4c2569869d0e41f4ceabac2a~Al7_6xjnl1875118751epcas1p1X;
        Fri, 23 Oct 2020 10:18:37 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CHgDV5ZYkzMqYlt; Fri, 23 Oct
        2020 10:18:34 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.05.10463.7FDA29F5; Fri, 23 Oct 2020 19:18:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201023101830epcas1p446aee869d0211a62f68cdf616b6203ed~Al740pbFC0848508485epcas1p4O;
        Fri, 23 Oct 2020 10:18:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201023101830epsmtrp2fc5e81293a31fcf59c9f55c6438c9f94~Al74z-1ev0982609826epsmtrp2Z;
        Fri, 23 Oct 2020 10:18:30 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-2f-5f92adf747b9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.4A.08745.6FDA29F5; Fri, 23 Oct 2020 19:18:30 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201023101830epsmtip1832b9286515f3d1c2fdbd952634e5bdd~Al74jobAQ2981029810epsmtip1y;
        Fri, 23 Oct 2020 10:18:30 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v2] PM / devfreq: Remove redundant governor_name from struct
 devfreq
Date:   Fri, 23 Oct 2020 19:32:15 +0900
Message-Id: <20201023103215.24647-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7bCmnu73tZPiDSa9ZrGYeOMKi8X1L89Z
        Lc42vWG3uLxrDpvF594jjBa3G1ewObB5bFrVyebRt2UVo8fnTXIBzFHZNhmpiSmpRQqpecn5
        KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAe5UUyhJzSoFCAYnFxUr6djZF
        +aUlqQoZ+cUltkqpBSk5BZYFesWJucWleel6yfm5VoYGBkamQIUJ2RmTll9iLNitV7HyyTmm
        BsZtal2MnBwSAiYS3S13WLsYuTiEBHYwSixZMxvK+cQocfXXEVaQKiGBz4wS104rwnT0nV7B
        DlG0i1Fi6dwTzBBFXxgluo9agdhsAloS+1/cYAOxRQSsJE7/7wCrYRZIkej/fYYFxBYWCJNY
        vXE7WA2LgKrEkwcH2UFsXqD6e9ufskMsk5dYveEAM8gyCYF57BINN9+yQSRcJDaueAdVJCzx
        6vgWKFtK4vO7vVA11RIrTx5hg2juYJTYsv8CK0TCWGL/0slMXYwcQBdpSqzfpQ8RVpTY+Xsu
        I8ShfBLvvvawgpRICPBKdLQJQZQoS1x+cJcJwpaUWNzeyQZR4iHx6nUUJBhiJZYsmMQ6gVF2
        FsL8BYyMqxjFUguKc9NTiw0LTJDjaBMjOCVpWexgnPv2g94hRiYOxkOMEhzMSiK8u9Unxgvx
        piRWVqUW5ccXleakFh9iNAWG10RmKdHkfGBSzCuJNzQ1MjY2tjAxNDM1NFQS5/2j3REvJJCe
        WJKanZpakFoE08fEwSnVwKSwwXbbc/EfTV79ykvEXwiUdmYE9hQ32c4125m/NrKuOtsr8yPz
        M9uOJu/Tx4o1Tu95UiTJY7+n+vzx59uPbZn1qKTb8JBk84I64ScTQ/nPtSrdmCjAKhl1PPbB
        vSLbmrrVr9+aK00JedZS46hktdDqyOulzzLefIvjX1xmqje7NP9Mke0Ka+Mt7+edl+Arsr1X
        uEZ544o7TGY6U7ICG0V++fNc33ky3m/TLJYZdVbzIsNylabltc6MPa+5tp/HOdXUyl/LuNOp
        RT5ljXP4tz129S0cuhPuv99c8Lxppb3TkoC7JwRvtHb2nrDi/hO9Zudhn/zWAJb0RRy/Eo8f
        L2nx1Hq14uv8s12lYQ/slViKMxINtZiLihMBYoQtZNIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHJMWRmVeSWpSXmKPExsWy7bCSnO63tZPiDS48E7WYeOMKi8X1L89Z
        Lc42vWG3uLxrDpvF594jjBa3G1ewObB5bFrVyebRt2UVo8fnTXIBzFFcNimpOZllqUX6dglc
        GZOWX2Is2K1XsfLJOaYGxm1qXYycHBICJhJ9p1ewdzFycQgJ7GCUeLLvEjNEQlJi2sWjQDYH
        kC0scfhwMUTNJ0aJGZ+XsoLUsAloSex/cYMNxBYRsJG4u/gaC0g9s0CGxP/lSiBhYYEQiePH
        5oGVswioSjx5cJAdxOYVsJK4t/0pO8QqeYnVGw4wT2DkWcDIsIpRMrWgODc9t9iwwCgvtVyv
        ODG3uDQvXS85P3cTIzhItLR2MO5Z9UHvECMTB+MhRgkOZiUR3t3qE+OFeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ836dtTBOSCA9sSQ1OzW1ILUIJsvEwSnVwKRm9vb2vivmEeU8t38v4JlxSuH4
        opida5Yfnxlul3c4n/3vEsNNrnfXXlV7uMOfSejVhYDK7HaznmN2GtZMGye/287/iHOD3OY6
        VuWLne8UXxjcso483Om690nynQ2Hf7/oFtqwVX3ZBwdpHvYzFwtk/XyeWZd2SXhwCd4ueNm3
        IUDeZYHhE+Ft096GC1hYTUp7OvN9o0fiTTn20JsL+7WPyq3fqLf+zdfkhT91jS6WmvC2larF
        Tr3UtPyXDC8zyynRbZwhp/8EMaz8dqh63YmoMunZs8WvHXpd2DJ7r7j+TV35zI1JudoR/xh4
        bDkiZfTenH5yS042cQ7jxyU3Lu3fGxoU3sej/P7o0qnLuy4rsRRnJBpqMRcVJwIAub1aD4EC
        AAA=
X-CMS-MailID: 20201023101830epcas1p446aee869d0211a62f68cdf616b6203ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201023101830epcas1p446aee869d0211a62f68cdf616b6203ed
References: <CGME20201023101830epcas1p446aee869d0211a62f68cdf616b6203ed@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq structure instance contains the governor_name and a governor
instance. When need to show the governor name, better to use the name
of devfreq_governor structure. So, governor_name variable in struct devfreq
is a redundant and unneeded variable. Remove the redundant governor_name
of struct devfreq and then use the name of devfreq_governor instance.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes from v1:
- Rebase it on "[PATCH v5 0/2] PM / devfreq: Add governor feature and attribute flag"

 drivers/devfreq/devfreq.c  | 18 +++++++-----------
 drivers/devfreq/governor.h |  2 ++
 include/linux/devfreq.h    |  4 ----
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index f6c55cf498ed..74f71588ace5 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -811,7 +811,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->dev.release = devfreq_dev_release;
 	INIT_LIST_HEAD(&devfreq->node);
 	devfreq->profile = profile;
-	strscpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
 	devfreq->previous_freq = profile->initial_freq;
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
@@ -907,7 +906,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	mutex_lock(&devfreq_list_lock);
 
-	governor = try_then_request_governor(devfreq->governor_name);
+	governor = try_then_request_governor(governor_name);
 	if (IS_ERR(governor)) {
 		dev_err(dev, "%s: Unable to find governor for the device\n",
 			__func__);
@@ -1250,7 +1249,7 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 		int ret = 0;
 		struct device *dev = devfreq->dev.parent;
 
-		if (!strncmp(devfreq->governor_name, governor->name,
+		if (!strncmp(devfreq->governor->name, governor->name,
 			     DEVFREQ_NAME_LEN)) {
 			/* The following should never occur */
 			if (devfreq->governor) {
@@ -1312,7 +1311,7 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
 		int ret;
 		struct device *dev = devfreq->dev.parent;
 
-		if (!strncmp(devfreq->governor_name, governor->name,
+		if (!strncmp(devfreq->governor->name, governor->name,
 			     DEVFREQ_NAME_LEN)) {
 			/* we should have a devfreq governor! */
 			if (!devfreq->governor) {
@@ -1407,7 +1406,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	 */
 	prev_governor = df->governor;
 	df->governor = governor;
-	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
 	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
 	if (ret) {
 		dev_warn(dev, "%s: Governor %s not started(%d)\n",
@@ -1415,13 +1413,11 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 
 		/* Restore previous governor */
 		df->governor = prev_governor;
-		strncpy(df->governor_name, prev_governor->name,
-			DEVFREQ_NAME_LEN);
 		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
 		if (ret) {
 			dev_err(dev,
 				"%s: reverting to Governor %s failed (%d)\n",
-				__func__, df->governor_name, ret);
+				__func__, prev_governor->name, ret);
 			df->governor = NULL;
 			goto out;
 		}
@@ -1457,7 +1453,7 @@ static ssize_t available_governors_show(struct device *d,
 	 */
 	if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
-				  "%s ", df->governor_name);
+				  "%s ", df->governor->name);
 	/*
 	 * The devfreq device shows the registered governor except for
 	 * immutable governors such as passive governor .
@@ -1900,7 +1896,7 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
 
 	list_for_each_entry_reverse(devfreq, &devfreq_list, node) {
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
-		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
+		if (!strncmp(devfreq->governor->name, DEVFREQ_GOV_PASSIVE,
 							DEVFREQ_NAME_LEN)) {
 			struct devfreq_passive_data *data = devfreq->data;
 
@@ -1926,7 +1922,7 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
 			"%-30s %-30s %-15s %-10s %10d %12ld %12ld %12ld\n",
 			dev_name(&devfreq->dev),
 			p_devfreq ? dev_name(&p_devfreq->dev) : "null",
-			devfreq->governor_name,
+			devfreq->governor->name,
 			polling_ms ? timer_name[timer] : "null",
 			polling_ms,
 			cur_freq,
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index df413b851bb2..2a52f97b542d 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -13,6 +13,8 @@
 
 #include <linux/devfreq.h>
 
+#define DEVFREQ_NAME_LEN			16
+
 #define to_devfreq(DEV)	container_of((DEV), struct devfreq, dev)
 
 /* Devfreq events */
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 2f4a74efa6be..82156721f459 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -15,8 +15,6 @@
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
 
-#define DEVFREQ_NAME_LEN 16
-
 /* DEVFREQ governor name */
 #define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
 #define DEVFREQ_GOV_PERFORMANCE		"performance"
@@ -139,7 +137,6 @@ struct devfreq_stats {
  *		using devfreq.
  * @profile:	device-specific devfreq profile
  * @governor:	method how to choose frequency based on the usage.
- * @governor_name:	devfreq governor name for use with this devfreq
  * @nb:		notifier block used to notify devfreq object that it should
  *		reevaluate operable frequencies. Devfreq users may use
  *		devfreq.nb to the corresponding register notifier call chain.
@@ -176,7 +173,6 @@ struct devfreq {
 	struct device dev;
 	struct devfreq_dev_profile *profile;
 	const struct devfreq_governor *governor;
-	char governor_name[DEVFREQ_NAME_LEN];
 	struct notifier_block nb;
 	struct delayed_work work;
 
-- 
2.17.1

