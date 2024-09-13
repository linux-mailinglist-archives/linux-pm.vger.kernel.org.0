Return-Path: <linux-pm+bounces-14128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAEE977B8F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 10:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB34B21EDC
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 08:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618C1BC9EB;
	Fri, 13 Sep 2024 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="VwOUYc92"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020F1BB6B3;
	Fri, 13 Sep 2024 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217301; cv=fail; b=pDvDLdWzeE0Xr+IPToszMhXZSwehpYvwWwxbptqj0gVnDy27CvxGxKiaTXNG68ouH3JOGsRQHj+oq+DfO4xwqtFeDIPsk1QxTDY5NUI1tdiwaMQninWkUqsKvrNIGxJ8AjNInZlquMHSf5H+bTGzNgr1f03eynTiTxB2kUOuI9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217301; c=relaxed/simple;
	bh=m/ILB8DzZMboxn48dqsd4WnsLVP+wVpzYj5F5I7Cj4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=tbAKST2RuqB4vDW6rJ7Oc5z2SrJKuFouAqPu6lkpuJ5MZ/0HU8VhwnGUn5A6ui2YpMkJibf/xz0Tj/3pcZkJCjplvRWsPHMvgL+GCRwxdtsu3OmSCsSIB5izuAWdRtGVrZQsFejfknOuJczOIFS0Uc/ySNwiZmSbVq1pBrNhSKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=VwOUYc92; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPMd1Z+SVfr4ca2QwxOWYwa84780+0JNa/6RGEt1JZeomXAsfhDv3YshwThgKJ1AdJFB5kmd706TjAvDsQVx6okXnDgAE8hAjAXeaGgiz8Yxtze2KcZPv1ifcUFbVDWaRRs1D7MXdjgtHci2DR/6m/PxCtKD9Ih5fiCoPEbLSjQz53VszcSpI4BcvAr25K49fkTYlGiytw85AAwgOFbZ+Azc/2MpCMEIMH7PMkDJOu/Hck70KqVkFrSkPYugTI4nSQqNcrT9ppuPGz/fGNEkLHCMGnkf1u7zpaopHuV4D+KRO+UIeMcFZWU26iXOvNIuWKHqJKoSvpMVsErLhjEZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrX2Ho5mvjXexsbTMn47/uCAzLbzn4Z7AkV+yNsI30U=;
 b=yBPbWxrpuSC22v0RRYQs4vvbPQ6qQIRR+YUcb1Uzs6p/20QTLXDbZMz/jbz8KtUieyukbO6BfjlS9rTYtPoIxYf8R9vxye8XalCuk14XlccaYgwSRhWn6b+bX7aWX/Hq9IvUSlot291/0wptONY41VDgdyfZb9XhF6zeKe/vFfGO7TnP1ngC2NbDCzORUw1a3HD1EHQbAOAi2BDQg6+q+yz7g4EXe7A69QBsJkm5nADhbCT6XQTbYLZXntC7cj+z19QBpssqR87M8jfuKCC281raoE+/FraaoApN7IdvYhhnp7tplmh6U0vWGKIgpdryLDIOljyvmhl1uczHoiRFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrX2Ho5mvjXexsbTMn47/uCAzLbzn4Z7AkV+yNsI30U=;
 b=VwOUYc92cb9OAbnoJ6Au3e65UKGZTTRcububCGxCP8F9e8csvB7VE5XTcleudyLRjJkuTGhcI+B34mVqqyLHQaVocuJmpueLzgfBPcL90aCx2z7gXWFcMz7f5898runNfm5DRx/Qr5x+Nrjgz9K0pvK+Man96Bh3JaT2YXxqxe8=
Received: from AS9PR06CA0569.eurprd06.prod.outlook.com (2603:10a6:20b:485::33)
 by DB9PR02MB6810.eurprd02.prod.outlook.com (2603:10a6:10:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 08:48:14 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:20b:485:cafe::fd) by AS9PR06CA0569.outlook.office365.com
 (2603:10a6:20b:485::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Fri, 13 Sep 2024 08:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 08:48:13 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 10:48:10 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Sep 2024 10:48:10 +0200
Received: from pc4cv4203v8f.sh.cn.axis.com (pc4cv4203v8f.sh.cn.axis.com [192.168.77.92])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id A34CF10F;
	Fri, 13 Sep 2024 10:48:10 +0200 (CEST)
Received: by pc4cv4203v8f.sh.cn.axis.com (Postfix, from userid 12715)
	id DA5466B1EE; Fri, 13 Sep 2024 16:48:09 +0800 (CST)
From: Jerry Lv <Jerry.Lv@axis.com>
Date: Fri, 13 Sep 2024 16:45:37 +0800
Subject: [PATCH] power: supply: bq27xxx_battery: Do not return ENODEV when
 busy
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240913-foo-fix2-v1-1-a0f499404f3a@axis.com>
X-B4-Tracking: v=1; b=H4sIALD742YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Nj3bT8fN20zAoj3USDFHPLlCQLs0SDJCWg8oKiVKA42Kjo2NpaAM+
 XNKVaAAAA
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, Jerry Lv <Jerry.Lv@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000044:EE_|DB9PR02MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eedb550-c11c-44ba-2bea-08dcd3d0cd49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFRrUVV0ZWhGaTc0SmY5UWtTVEZ4Qm1qMWcyWU9YZnRuemNYUDNyTERtMDJG?=
 =?utf-8?B?R2RlS0g3eFhPMXFzd3lPVVF3RTNaZDNiT3g1RnJCcmpTajR5WTBGZzUxSldO?=
 =?utf-8?B?bW5jeVRiV2xFUTVIQVdQV3VZTy92N0JxYUZBUDV5THV5UnJvdnFVdEJlR1N6?=
 =?utf-8?B?Rm8rWk1IZFRhcTE1MjR2ZXdJVndhUkI4YkJtOGlHRENTVzV5Z3ozNVlZUDhz?=
 =?utf-8?B?bmtvQmtiL0RtRWszUTJ0NXp6NlFHQ01vUEl6QXo3K2J4V2RJWmNRYUo3aHVT?=
 =?utf-8?B?SEloVHY1ek1HRWF1akMvbDBiMmtGTmUzaTBmTW1OeGpkTThDOW1oNnM1Zyt0?=
 =?utf-8?B?T0pwQmphdGNLeGE2N280d2xtaDhtUFJ0ZDhzZGZUZWdycnVSUHlYZVhlVW9I?=
 =?utf-8?B?SlhhSHpnUTZmdFJQUWxXQUdDTmtPRktaRStFekVlb24yTWFpN0tHcG5CaVNJ?=
 =?utf-8?B?aExKeWxOQS9iR2k5azl2bDcwU0N1SDJzR2o4U3BXUlY3M1BZYmJLK0hUZGpz?=
 =?utf-8?B?aG1xS0o1ekYvYjZZTVR3N2p1MW1NWWFVOExwNWFlUGJ2VnNtT05aWFVQRzM4?=
 =?utf-8?B?RkRqUVBla01DZzBiMk5pVjgvWkpWSjBqamtGM0hBWWlibUp5L25wa3NIZ1lt?=
 =?utf-8?B?OFNkc0FVZTBQKzl1dTA4OUxlM0IxRVArdGI3UCtWSmsxTzNhdDVCajd2dllN?=
 =?utf-8?B?Qk43ekpoaFd6NGJSYXBwNWpJWWhRYngxSkhPMDF0MHUwMWhaQ2Nqbk81NEpQ?=
 =?utf-8?B?VG5YbkNLbUdmcTdvUkxwYU84OXVVYm1mMUozd2NZczhaME9Xa01JMGx3dTdS?=
 =?utf-8?B?cGNlbkNHRVVMN0tsbVRjbHREdU1ITTNhd3c0MFZFdG91RkZ0S29EanozRHJF?=
 =?utf-8?B?M3VvMEhWZE1YMlZKK04rU1MrOVpnU3pqVTBDbVhjNzB3dzhjcmxvRFdjRS9r?=
 =?utf-8?B?Y2lIREp6ak91NTVtNVY2ZGpTUE1OZUIyWFVqOFA5ajNOdVZGQmcyQ1h4UWdZ?=
 =?utf-8?B?OStiZHpKMGpiRzBVemt3cVpMQlllcTlySDRNZ0ZhVzJXd2FYdDZ6QXRtNFF6?=
 =?utf-8?B?QWNDbDVtMi9yK0x3TWUwTEZQSUFtUWlTVkxLUVlEKzZUeUVvY2JlMXFlWmpL?=
 =?utf-8?B?Mko2WEh5Zi9manpyOElCU3lMejc4cGVGTzNyNjRpaDlmZzQyNksrWFh0eGg0?=
 =?utf-8?B?YTd1cW9WcjEwRms3bTdMTmdIOEpJVHplSFZCeFZ4M3hlWkFOSlFqMHIxMjVB?=
 =?utf-8?B?WkdTUmlZTnJhMXRCTFJXUGZxK0FqMkd5VWg0Yzg4Y0FUQkhBWEJ0Mk5idVNJ?=
 =?utf-8?B?aFBrNHJjM3JJa3Z2TjdiUG45a3RMSDA1YVRZTzdIcGVYUHM3emswWFZDclZO?=
 =?utf-8?B?YXQ5STUvcVBOOUtXUDFoUDdRZGVvTnNEbWxNVEZKdjdHWmhMUEZFOS9HUkFv?=
 =?utf-8?B?emFORzM0ejNxeFV1eE1UK3YzUzZXTlloam56SUtRNlEva05EWFVKYjRQWER4?=
 =?utf-8?B?eU1HTXpBdjg4MVo5Nk1XcWhGMFlZNENDelcxbXltLzE0SGJlM2JvNXZIL1VP?=
 =?utf-8?B?Z3ovaGJoMTBvbW9PNGJwalVzc3FFMlNrU0QxUklzMjR5MUpLR3cySnY0U3Zl?=
 =?utf-8?B?UXB1eDZsUUxiNDl6TWl4S0ZxUC9UcC9uWk4xTVZLaVUyUGtHc0daYldYQlVL?=
 =?utf-8?B?Mkk3SUlRV2lHQkkzN3B3d1J2MFlUa0xmMm1QcFhzWExYS3dVT0d5bzBxaWk2?=
 =?utf-8?B?VVRqZ3YvbmY5QmthTTUxUnF0WU9mK2pKa2FKaTQ0dWFSVnZ0bmNPRTlDVXZo?=
 =?utf-8?B?VCtkb2p6R3pZTVFQRGREY1RNZnlmQ3ZoeFY1U0NzYUNXbEs4TGhaeUtWdjIv?=
 =?utf-8?B?bE1lM2J2YjhyaVFxS3lMUlJEb2pPTXJpSHdNeUluaFJyNVhlN0k1S1hJTEto?=
 =?utf-8?Q?CsPPBC91/rW/74mYhg3gtjMkc3qshqlz?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 08:48:13.0081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eedb550-c11c-44ba-2bea-08dcd3d0cd49
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6810

Multiple applications may access the device gauge at the same time, so the
gauge may be busy and EBUSY will be returned. The driver will set a flag to
record the EBUSY state, and this flag will be kept until the next periodic
update. When this flag is set, bq27xxx_battery_get_property() will just
return ENODEV until the flag is updated.

Even if the gauge was busy during the last accessing attempt, returning
ENODEV is not ideal, and can cause confusion in the applications layer.

Instead, retry accessing the gauge to update the properties is as expected.
The gauge typically recovers from busy state within a few milliseconds, and
the cached flag will not cause issues while updating the properties.

Signed-off-by: Jerry Lv <Jerry.Lv@axis.com>
---
 drivers/power/supply/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 750fda543308..eefbb5029a3b 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2029,7 +2029,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		bq27xxx_battery_update_unlocked(di);
 	mutex_unlock(&di->lock);
 
-	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
+	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0 && di->cache.flags != -EBUSY)
 		return -ENODEV;
 
 	switch (psp) {

---
base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
change-id: 20240913-foo-fix2-a0d79db86a0b

Best regards,
-- 
Jerry Lv <Jerry.Lv@axis.com>


