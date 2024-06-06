Return-Path: <linux-pm+bounces-8734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A4D8FF398
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 19:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0AD1C265A8
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 17:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5150B1990AB;
	Thu,  6 Jun 2024 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dhda/dQ/"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2018.outbound.protection.outlook.com [40.92.75.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037A198E90;
	Thu,  6 Jun 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694489; cv=fail; b=aVP45UwSWMYaZ7haJXJAwgDX8HQSBzbENPRewp67gyifKRuTg4zFXlcB/1+xp61Tk344JRR4vrCe9a+ybr+RVYHT3DI43EIaBGkNRdLP6ZDZrgIiO2ChPVdUc4nHWo5plxYGT8ByfePbYP0eau4Mk2yb19M+xVEj8TZzKyiBMvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694489; c=relaxed/simple;
	bh=VZGERjzbL60MzoqjfiAJ3AEI6UBzN3vih0OviVL0Uok=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VocbVHQETxc7ckTd83qbqjGEAep8HdptW3kYGKjJ6PenTPOP+S72+pWiYWId2L7DrguTYzQmoDrc+zls//uaeYRFvSstKS2gs8NIE7FDjkafdTRe7BOyq5VEZmQezwOqLCKtEyN+daqLKq/0/jPl50P0jQeoDkUpwrhlMPTqzYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dhda/dQ/; arc=fail smtp.client-ip=40.92.75.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMZG4pEjETNEUZyL2/yneHirfUyrCpcIo1Xcpy7QYwmXTDpRURwKS90iuhrPeV6+Bj5E/0QYwYWOq8+PBEKcqXJoziopdW50LCywYzCn7yPDx+A1pBSmFTxrZMwUkVZ4Ci/unwroNKSwEH+iU6nOWL4nNIkYvUZYXRQVO3kUykafrYa3YmJf4hpNknPC/LNlf9uZaHPPZQAPMapkvuYAWthuEXseRZeGeXRiomZ0bJoA/EzxagdaDD69xnTal5ojWgRi4HEMPKK56+Iv44TWntgio0ltV6rpkkfh0gDp2hLBQVCvvqTtXbUfGvAZ95vbde8UHgEuOllbmrvEYYOdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyO4tSKZqFwRg1zNY4P33R6TDcVqkS4+rIZOFFxcFxg=;
 b=alMqjxqRzJqu/8YM6gYfoYxjfWeHcUpQtfONv8Qjq4ayYzpPnOUezhc+/kAdl5NCzuB2aJJ8VkOytLFFSV13gv8eXqHwX6mh0UUUnjjZqJrRmTXiStnK0El7KMD2EoQych5LHkRUtFkAshnu7hs0QfHlGYfqum0ptrdGbAx5Wq2X0RG5r0BCYbOSre8vCMSqvGo3P3Jq3U4qPWOAT78AXFQ7u8zZ8VZLRBywf0XOlFW1vNcXALNUnZsRBmVzS1Aa9IuK2zoemA80wWbUBOiM5P6Ntu3jgGYRdBHiOR4tFXsNNGXrCWlcu5rn9+GQ5407Nd4gMgCRWxK3Zx/aJUOvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyO4tSKZqFwRg1zNY4P33R6TDcVqkS4+rIZOFFxcFxg=;
 b=dhda/dQ/OJfHrsF2fNef1zqC+N6BEaXgveuFKN+B6xkMeVwm7QqtPqeh3BGLD4spdwfCG+dHhjn/JXY0psvDiU62U4h77xuFsR/6RITk9C9OcDTlb04G7255oQJmRX90uF/wbODY9IFhPRscB1i43ZbHgdF3g5NxONHvoQEc/M27vPwlXL9T1/CQfsCEX+C4OGXySqdeEf1c8A4P6OW2uFDsu5/gw2+4F//0ZOiZgngF0UZi4wKqIOlXc7zorTq+JGTKTDOBJ8dgJUXvnt0mLMlYAPCfV9a2BVv72VByOd9AjM6etUEuap1gIySrqRvONoI+Yh7J3UyWyb0XAgcMXw==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by PA6PR02MB10849.eurprd02.prod.outlook.com (2603:10a6:102:3d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 17:21:24 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 17:21:24 +0000
From: Erick Archer <erick.archer@outlook.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
	Erick Archer <erick.archer@outlook.com>,
	Lukas Wunner <lukas@wunner.de>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] thermal: int3400: Use sizeof(*pointer) instead of sizeof(type)
Date: Thu,  6 Jun 2024 19:21:06 +0200
Message-ID:
 <AS8PR02MB723748EF627AEB253C437FD48BFA2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [FmGoVqeLnBqQlYolfgiRZAtXZrDID43L]
X-ClientProxiedBy: MA2P292CA0026.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::12)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240606172106.7052-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|PA6PR02MB10849:EE_
X-MS-Office365-Filtering-Correlation-Id: bbecf4f0-7755-427e-50a8-08dc864d1609
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	sOB3l3i+W7XmA+NMywdXKshUulJxelHUAy6scUqOScGIj/E+5ZkhBH8B4pmHl/BXzJBwY8TGhnkW9GHpOCK3I4qK3x5ixgaw0dzlNAc7qKgUe5b7f9flXo2ZryhD54OPoIK7jazG6m8zqvmftb/jaw1jBlCIfymKJBL4wf4k5YFZKVQApXRfSdVi9QX8kGc25U1zPNTXSZ9H+Eesn/fOQ65NwyxWsjQjqLkyYIW8rsRKoxpzNL71iYfKbn/SsT+Z5OaJcMJ5a8rjTPukmd3gloE0ueTV+CF2bZdmVEuJqG2dh/qV533Mqd88PYMf9IJ5+EuW1f3qQUN3pv/jvxrcWqUE52V3QyxVP6CKHVfjIXNupyfEgOlMDUyCnwKMiIMIHbygNMIbJWFqkNiZRu3WMrulE9z7cSVPBhNutG/NVxrG690DbbSPGBaHSwNgrho2ZN9O8WxnQiRgW2HIN1cB/ZAu7u9R2H1Dm5UXdk/zNYyiKcvgX2GUfHfj/sPu2+Vs198Vj7LbuITllqt4d/k7ezck4KFmCmm4oCjFLlvH2ZS0l+a7itIsLaC9bU/qrn0/fg2xt8sBkllFS6m3+rW/Zaam7dXY5pINzElZSrOvL+EpuDynkSE1ZDIOe9DdXyGx
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YN2fIkrhV/0qcT/sOqFlI5NxBXYcFbwJr6hDrHxmQHMjfkVRSvO/zjVJp+Nk?=
 =?us-ascii?Q?czOe2rMsS88T8XTmfLI2I/qXHETZo5tzfOVn2DgBsLYr5AmmZYJlvYu87VvF?=
 =?us-ascii?Q?vFRDQrVPhY3NI114nEXXOaegkizgrxvR/fA5e/89e7IjysI6Sjmn18h9bOpL?=
 =?us-ascii?Q?LBgTCNHxrV2OWwZj1gK9uu+f1VlBySqvEsXK8ix04XGVtQs8BIeV4yo1/fhZ?=
 =?us-ascii?Q?5fz7un6G5RoGbz26IEOTL/eldVXiFkJ2b2GsE1ZcNwuWuPYYq2lipocLnWPK?=
 =?us-ascii?Q?SNJp1YVxQ6R9YvnCTTW9HFRm/iznqCBdVw8/e7j9ukVaUD29iBnbEQJIaSDG?=
 =?us-ascii?Q?lmyEHbQxE+pK4kDSZuoIB/B9GeEpivsy215ga7qowSjIG3CxfxUdsjxSFkDL?=
 =?us-ascii?Q?uVGx32jq48jE6Uq5XT63Ah698ZgBsIGqkzpbaJyKtjcNhMAH1krWGVMEo2aA?=
 =?us-ascii?Q?3zewXR16wB4GhayPAYf1ass99SO101ZS0Dy4HbUyFqRUnxWuCWgjGJQzE1pi?=
 =?us-ascii?Q?JYdhDom1dn8VAX1oOayZpWFOcOyBWyK28s/byf3cHaaYzfjnlGbhEAkmrnOt?=
 =?us-ascii?Q?ZB3+eaix4+RW47E47WHCVTWjHmyyESjHaXO9pvdXtfCGpbzDfklA9ymekVCf?=
 =?us-ascii?Q?4AGMl4dbQNNbRao7SvdKId0EnWi8mRJRVt8ZyeDZET9HLgfJObXfqddYRJRJ?=
 =?us-ascii?Q?11LJkKbb0fW3fn4Zt14hS9XLXsXc4Ih08FYHgYc2lv3egpW4KyGtNMQ13rdY?=
 =?us-ascii?Q?qzpTuiEogu3NA4KpzvitbZMSsWB1++xr+Znz2K/vS4BF29agL3Dx2kEEvNMz?=
 =?us-ascii?Q?oTG3xM1hgowMCMFwn9h0KfRFWg05BJFH080gtQwqV1j3c/xmYfR10c4dkIuo?=
 =?us-ascii?Q?oPfAugferRX8vRYpSOOw8zo1yLdEi5SCBeCyINXDoiQwhmjtxUX5XdA2+Im5?=
 =?us-ascii?Q?7/yQx1Yr2GTKrM22oS9nnCBXzFGE4/GLo3HroDS+RXn9UOWos5oQLb/xw+7F?=
 =?us-ascii?Q?tL+JF9gy15VcKcjFnkmLLvcewhBhBLTA39EM6uhid8p8BhqKLraN6JfjsOYu?=
 =?us-ascii?Q?CbDgtI2fUPyqN8KyEw+sa39MvMf21W9H1CZLmZHi9thH/IjENE5e8Tips20L?=
 =?us-ascii?Q?iG9sNWP+xdTfPTs6fCd1NLmVkUCo9OnHm70uVaojsNwmde/UhhBM3TRlqdpP?=
 =?us-ascii?Q?HW3s2bgs/0Tj3CWXWrWy76QpvUpFCuU1Fr/NxCyruKz6UZRBKH+gpLg4rote?=
 =?us-ascii?Q?wAlkJCrBm0df8KFQMuvf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbecf4f0-7755-427e-50a8-08dc864d1609
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 17:21:24.2706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10849

It is preferred to use sizeof(*pointer) instead of sizeof(type)
due to the type of the variable can change and one needs not
change the former (unlike the latter). This patch has no effect
on runtime behavior.

Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index fa96972266e4..b0c0f0ffdcb0 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -571,7 +571,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (!adev)
 		return -ENODEV;
 
-	priv = kzalloc(sizeof(struct int3400_thermal_priv), GFP_KERNEL);
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-- 
2.25.1


