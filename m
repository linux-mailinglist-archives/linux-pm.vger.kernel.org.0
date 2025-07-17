Return-Path: <linux-pm+bounces-30988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445C9B08873
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 10:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E464A882D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF4E287260;
	Thu, 17 Jul 2025 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="jESP7bQs"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012015.outbound.protection.outlook.com [40.107.75.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ECD283144;
	Thu, 17 Jul 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742292; cv=fail; b=N4lmhOMwYR0oZmFbyDGWCMj3hSqPW9Qy4ATo0wsAoPJU1RPlrzyKiTDTRTVUvUYxp7UQwCz+i660hf/O4TKn8HZV25FqBAriWecFluFQpI/AiTt6+9fK4DSXEDLMoiW1LbFqCdXFVlZ8ZiD2Lq+hXo/mpZRU23CekS6yHs3MMGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742292; c=relaxed/simple;
	bh=Q80yjPENJDSu0wQrVzrz7eWJ+TUClRSOx5fyzzTvjVI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IjIBAktHmxZYtCfmzVIYLhNz6i9RgDKfNM76PlUnI/kFkGF/EiNatHz3pjfjeH1f2RRvu1epK0mNwgzIxsrLIlbRMceMohs8H3cFYA5jhjKKlxskhStAmVPSy2JLX8inFxPdwTgfsUPSmuzLz8Z9ZLGaCoXj6fAq1yBu0fh7WeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=jESP7bQs; arc=fail smtp.client-ip=40.107.75.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqhL4XaF1cxgLPILIduxyUYH7U9R8CmHQUA45kJWKGLJ2tKQxPT5rWd+saZoPdkVBpSHdp8GGQXXOx3+X8IphOfRuM+rj2W5WU0Hhp96bxNeC5J0HdeFmo0cCdl3QrY1m7rAF/OeyrEqjLbYKOIh+bHAcNpIibW/Kc7bSDfwao4ybh/6Hysd4ObUCHESbNbGbixdQ5T4mc9SYo4mdpcYgzUJmNvxKCQX5a8jvVAeTjs7GmTubONfRfVy6D/SXms0/Wzs/giYwmSE8WhnIa5JMvaZK5HUa9xkWf1CKiX2/5Sg8TB/cycKXp1p5yOx+TB3U9hI31FHxODHkSlHajA7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/EYPMJBbRKibVHgMFGj/MvddSj6/+vO+CFjkWsVz5Q=;
 b=GM35AJKPE7ENK8lXILE1AQSfguasnhHHITwnU1n34WCkKBh18ewRYZeZd2sjh4Y3lFGyMrGKdaHmnhcRFwHPyp/Y7BAtC1bEcWWAcqxYDz9PaEPUzqeG8XQjvJs7NtMowGhMZxWMWnMCbh/4eslyFxDVW3EVNwZBrwCNL4kAvPlE8bc1E8YcGMpFgBbaO47s9X528CHEeuz5J3WRYBH02ZpnkIIab3eNejJXwcx26tTjEbONcBNDCCJmdyJfNEUvShgRggUVpgw/mLOcC+pqL98y5q8yn7QlHmqjgf2sqyrD1KP7uLuOjzg3iIv/v8fKEuZeh9n459NAN65CFwCFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/EYPMJBbRKibVHgMFGj/MvddSj6/+vO+CFjkWsVz5Q=;
 b=jESP7bQsN3vsJbzs9xVPLg60FCDIB9v8Kh99kTZW+MVDvesDqMoJ6z2Zh4kJo8KOoSY/xQsM7PpM0tDhwymVYAB2pTis0vGlrsc/VALhlbm6nHbyemF36glvEl5oYtEqSodNkgBZXhInP2NroCdzMBh0ausAkwwlVPqCwiCjg9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYSPR02MB8134.apcprd02.prod.outlook.com (2603:1096:405:51::12)
 by SEYPR02MB6964.apcprd02.prod.outlook.com (2603:1096:101:1a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 08:51:24 +0000
Received: from TYSPR02MB8134.apcprd02.prod.outlook.com
 ([fe80::647f:4e16:9cc4:1c09]) by TYSPR02MB8134.apcprd02.prod.outlook.com
 ([fe80::647f:4e16:9cc4:1c09%3]) with mapi id 15.20.8901.028; Thu, 17 Jul 2025
 08:51:24 +0000
From: Gaowei Pu <pugaowei@oppo.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gaowei Pu <pugaowei@oppo.com>
Subject: [PATCH v2] cpufreq: queue policy->update work to a dedicated thread
Date: Thu, 17 Jul 2025 16:51:10 +0800
Message-Id: <20250717085110.1468-1-pugaowei@oppo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To TYSPR02MB8134.apcprd02.prod.outlook.com
 (2603:1096:405:51::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR02MB8134:EE_|SEYPR02MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a73704b-7af7-4e2e-7c17-08ddc50f1baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jv48+UFd82roNE4MbjAfPCs30GWUaf2DkTzOKkQjRtjTaqTfr1UD0DEjnMjj?=
 =?us-ascii?Q?5AkwcS3J5D0vGhSgTng9RwIFZhDItTpVDQSLaTDF5ax0H9eVfDpM7IL59tch?=
 =?us-ascii?Q?E0JuJn0NtUa/3SE4nrdSDFNOAS5sPNDJafwWJYL8D/hBc5e8FBHpECvMRcvL?=
 =?us-ascii?Q?HXV3DtA0+OSt3uTem06Kh5dCDU3k+Z5grocZzKiW9Kuv72D9yh2iqBaUP7lo?=
 =?us-ascii?Q?l7zBxwcwcAS7uoZThhrbFTMQDhvLx7D14GvZ40Cr4HYW3McVnQmGBoC4zfG9?=
 =?us-ascii?Q?+OfWhBqXHyZ+ZLqtUg95LUrFO8WyIbsn2a2dcWzSvLbSl58ssduwNBjjzKU2?=
 =?us-ascii?Q?avAQjjMHnZPC7mxgCosfJtkHurod2B97jt2LXs7qkWyrl/zbGtps2Ra3D9po?=
 =?us-ascii?Q?sdiO53xTzlg5BUCzxoulBkYRMFdQrwIYgD52ToU8F863qZmgF+U9bcqMo2Vv?=
 =?us-ascii?Q?sE1florP+wavGGMh0J7DF0v4UV4wxpHyJJN1130Vi3IFRzZCAKN3aZplYlOw?=
 =?us-ascii?Q?YWp7wXKzH/G2NeDhX7bVlrLU9Ha4Mt9AKqIJhiJRvbb/tQdjUaGKx6H39luO?=
 =?us-ascii?Q?4cvMjj8AqNB2DA3Q8JEoswcazrSKAfF7v6FfoLxhJduavDrdlxe40em0F1zk?=
 =?us-ascii?Q?IE+3mRhOl28o+6xBtDLcwxYWRi0OzMHeDcKKVd5jOiO+HLux5XGjVMY21Vh3?=
 =?us-ascii?Q?tQWF5EVOOYGAIHev4xNxkOklW6TbUVW2sEnu6gy2WzY7wQpQkvQ45ypC/1Vw?=
 =?us-ascii?Q?GPCpYUCxy8UG6qYOtzao+WZalSxRKcTvykQp0+hJkHbev+hwYQCBRlsfete7?=
 =?us-ascii?Q?5Fkbye7QPMdRGMESasS5n713oU95Ws5VsMiwZsHbjXQrb3IvB0DKOm+zW/X+?=
 =?us-ascii?Q?2Xue08GsvGiG0M+YR1y4QRk2GN/4U2TGBAtYCKoOgFBOilDOlLS7z9qzgBFZ?=
 =?us-ascii?Q?cvmoGgSNq8EYaeJxvrMbl+t86p6/jcRAtRHtSHPdz+4c05GZ302S3WmZcojM?=
 =?us-ascii?Q?uusLNWQknYdqsG+Xwt4EX+oHnqRdWK+9EdDORcWJbm/RSk6T5zi7hxpFfqCf?=
 =?us-ascii?Q?IdCyHo18oC1A5YuPoaAENoqBCikl1jxWtCUqibkgD9aTL1yIGT4w7c4GjXAi?=
 =?us-ascii?Q?WuXy0X2B2PIwriO3zFWDR69LGSl830Hcyatu0WSoL3p1TylGUVgL/TEBx7AC?=
 =?us-ascii?Q?TVhZxO7TozZ2KEMSvXAiCeYsgATCenSWc72UYj3l5OR/dMz9eLKqsvHo7nMY?=
 =?us-ascii?Q?Z15Q9Duv1UnVSE/U+ktsr4j83ZR7EIhBSlV+4yck3rIAxRK+XF2g84HY8c5Y?=
 =?us-ascii?Q?2ON0EzGQ1GA4thItpSwNSa25mVk6SxwJbKOEu5wHOb1L+cjPheGmhDeKi+8R?=
 =?us-ascii?Q?fxXz1AODrPi5isJEtBiNmpUBMs0FTx4T6UYIWbXlxmAEmy0qhxfQhqxTZPep?=
 =?us-ascii?Q?xcsXIKFyZighrGCQcp93ehqeeXpzI4ejffPpE32MKnVW81tMKrT/sby1w4OS?=
 =?us-ascii?Q?+W2MNAbp1s11Yig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR02MB8134.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iaM49lQUBcBQUy1L9wXf1VzOoiUyDKZ3/sNX9dK3hw8upKbj1R2NXlX8euhn?=
 =?us-ascii?Q?kJLTdmAkQzvTA71tLhg7F7/1nez2iM8mQ+FaM7ZKsjIxN1m5ek5dJrMViSF4?=
 =?us-ascii?Q?WzdFDUz457k6TgyRgnF4RxII5muLEWqlOx2z4Xc49t3FcTjnRNKmhfubGUgC?=
 =?us-ascii?Q?ZEBXkjprGJw7XjNp1HH2v4vIz8XdXKZbXpibX692cu7YkNBJmQTvMHCVtD7Z?=
 =?us-ascii?Q?Stt11OTWmneY/3T7P500udzO2gtgY7Nqfi2J6u4OKVYtImLkEU36QCdP+1GP?=
 =?us-ascii?Q?tFKPp1hcfmJaqOJ9pAtVQe6odBvjUpMW4EY7Ia+1RPQXgUD/zkNnHP9ecmb+?=
 =?us-ascii?Q?roEuyAikomup8aYcP9JYPRw984uqiC4/Xyp3wM3NQN/D5gctf1+rigT4IHGP?=
 =?us-ascii?Q?iy8OlbIe3muV4y3+wpDlRDvan/Y6hV2X1Hzliusxcr2IA433P9cicQH+SCDX?=
 =?us-ascii?Q?o8i/e3mvwzj1W0kfDf5hC//4zzwS5hCDDWpz4yWPDfeLQCnI+QqISQzHfjsr?=
 =?us-ascii?Q?zbj1JuX/oVLCKUoateyON29wP6BAfRQQu/i4VpNrGk7N/jaKsrfjSGMfkmgB?=
 =?us-ascii?Q?ffD+hV3v8i7i/UmvlvGbVU5kABUywP7Li/Q+OodADA4li8V9Zx/oVBVmbCEN?=
 =?us-ascii?Q?kzvJ0rPtghWJj/F14rP+D/5gVbLkOxfLjRl1lCticjIuH59HoeVy/SG+Uyas?=
 =?us-ascii?Q?sZLwiHavqdj+HENbHJqZW3DCnqQjQM+jSHP92/xVjhbt4PhTF0FL7eaEAQNZ?=
 =?us-ascii?Q?Yip+IirEbjcuDLwU2BUWn+bE7gkA6wEXutrLw/O6/ffcEwK4y6B5CQu7np9H?=
 =?us-ascii?Q?JArJbAhBsAd8OOea+ZrjfYQKHYBBdtvPOjYTYu1H/5CZsz3aE3Kg6P1mAOFt?=
 =?us-ascii?Q?6//u8NHXWgszaZwQHUsMqCsdd1k0lXuNaYuOa1+DF3q/RgQiwDu+pUOGDohk?=
 =?us-ascii?Q?he8iYOOT7HoHrWLcSyATiIsSh0idvDeEd8sFcuy1td9/u8FtluNFmrDBeb+o?=
 =?us-ascii?Q?lhKn1Xeutx3Qb7U59gKwLALO2ZQJVHL7Wr25Hrvf1m83ZUpA8s6Rw+Ople8x?=
 =?us-ascii?Q?2clBKvZ2oZEHQcTE2JdbPkmWIVe/NgAg5A0FNP8bSVDKgM2KyrZZaAYnMm89?=
 =?us-ascii?Q?2AjYycB+Kjj7q8CCD1xVHKPXVgrKN3VI4EFQLdvFbI3CCrdq8tteYmlYrDKT?=
 =?us-ascii?Q?pIr/ZA5JbSuFTfx7AsVFFB/d8GmUs3DdgPxpPMNg6jx4vkIm7aVx9NV+9yWF?=
 =?us-ascii?Q?N/kDj2cJlQiRrtqk/CUFdzompfyw+rNJGY16Fz33J5/zadvUoRiNUtlolGn3?=
 =?us-ascii?Q?DQTwzc9hOYMFrK6E4vpTPq+1dInqgnYPGxI4ueEbYiOPItrb15eBMp7L6LbO?=
 =?us-ascii?Q?HlloXwpCnVW0GKxSf8UJSq6q6Z4JiRrANwhw584CEyHdStDcDqLVbGFb11HD?=
 =?us-ascii?Q?d9od+ufK7FOEBOOWTayvE5+OeBZIXG5e+XANe7f8pv0K7qnanQs9TkjxMZtQ?=
 =?us-ascii?Q?S6F5j2/JzWQ6ZRbMLVZ6YlYM4XWuG2wb71XfSObQBUmq4FbQaRqiJprVYHOa?=
 =?us-ascii?Q?qJta1rK8IIJCeaXiHP4wUaz/q/6k/oBtWh6t53RO?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a73704b-7af7-4e2e-7c17-08ddc50f1baa
X-MS-Exchange-CrossTenant-AuthSource: TYSPR02MB8134.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 08:51:23.9814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfJ8YBz14glI+GLdOnaCIj5S7Dn+KXdL1HK7KdoTdS7haLNRvSrucDpQYEK9mWRODZ7e9snhW/y5CfQgkDk/Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6964

We should ensure the low schedule latency of cpu frequency limits work
to meet performance and power demands. so queue the policy->update work
to a dedicated thread.

Remove the rt setting of the thread in patch v1 at Tim and
Rafael J's request. However, it's will not meet everyone's request
when we add a dedicated highpri workqueue to do the policy update work.
Therefore, we keep the thread and will add a vendor hook in andorid aosp
branch lately so we can customize the thread conveniently.

Changes in v2:
- Remove the rt setting of the thread and rephrase commit msg.
- Link to v1: https://lore.kernel.org/lkml/20240717063321.629-1-pugaowei@oppo.com/

Signed-off-by: Gaowei Pu <pugaowei@oppo.com>
---
 drivers/cpufreq/cpufreq.c | 23 +++++++++++++++++------
 include/linux/cpufreq.h   |  4 +++-
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d7426e1d8bdd..3980f6789a17 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1196,7 +1196,7 @@ void refresh_frequency_limits(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL(refresh_frequency_limits);
 
-static void handle_update(struct work_struct *work)
+static void handle_update(struct kthread_work *work)
 {
 	struct cpufreq_policy *policy =
 		container_of(work, struct cpufreq_policy, update);
@@ -1213,7 +1213,7 @@ static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
 {
 	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
 
-	schedule_work(&policy->update);
+	kthread_queue_work(policy->worker, &policy->update);
 	return 0;
 }
 
@@ -1222,7 +1222,7 @@ static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
 {
 	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
 
-	schedule_work(&policy->update);
+	kthread_queue_work(policy->worker, &policy->update);
 	return 0;
 }
 
@@ -1305,14 +1305,23 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_min_qos_notifier;
 	}
 
+	policy->worker = kthread_create_worker_on_cpu(cpu, 0, "policy_worker%d", cpu);
+	if (IS_ERR(policy->worker)) {
+		dev_err(dev, "Failed to create policy_worker%d\n", cpu);
+		goto err_max_qos_notifier;
+	}
+
 	INIT_LIST_HEAD(&policy->policy_list);
 	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
 	init_waitqueue_head(&policy->transition_wait);
-	INIT_WORK(&policy->update, handle_update);
+	kthread_init_work(&policy->update, handle_update);
 
 	return policy;
 
+err_max_qos_notifier:
+	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MAX,
+				 &policy->nb_max);
 err_min_qos_notifier:
 	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
 				 &policy->nb_min);
@@ -1356,7 +1365,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 				 &policy->nb_min);
 
 	/* Cancel any pending policy->update work before freeing the policy. */
-	cancel_work_sync(&policy->update);
+	kthread_cancel_work_sync(&policy->update);
+	if (policy->worker)
+		kthread_destroy_worker(policy->worker);
 
 	if (policy->max_freq_req) {
 		/*
@@ -1827,7 +1838,7 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
 
 		cpufreq_out_of_sync(policy, new_freq);
 		if (update)
-			schedule_work(&policy->update);
+			kthread_queue_work(policy->worker, &policy->update);
 	}
 
 	return new_freq;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 95f3807c8c55..728fa00a9647 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -20,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/sysfs.h>
 #include <linux/minmax.h>
+#include <linux/kthread.h>
 
 /*********************************************************************
  *                        CPUFREQ INTERFACE                          *
@@ -77,8 +78,9 @@ struct cpufreq_policy {
 	void			*governor_data;
 	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
 
-	struct work_struct	update; /* if update_policy() needs to be
+	struct kthread_work	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
+	struct kthread_worker *worker;
 
 	struct freq_constraints	constraints;
 	struct freq_qos_request	*min_freq_req;
-- 
2.17.1


