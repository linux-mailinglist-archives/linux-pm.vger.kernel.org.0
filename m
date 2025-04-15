Return-Path: <linux-pm+bounces-25427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CCCA8929B
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 05:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA8B7A90E6
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 03:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A77C217F24;
	Tue, 15 Apr 2025 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="r6V1zvGy"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571A2DFA2D;
	Tue, 15 Apr 2025 03:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744688464; cv=fail; b=aPBA90zPk8t2e3w0MUpWXYyt5oMq01EgSIXmtZBavi8Vjg/UnYpd0m5qK/FghYMuAehBOy0rE59ptcEH5IZaS1kBkFrpw9sVFYwBzmr1OzV36cGlkcUgK5ZPmtxRWJjtCo7uWLY6K/b0FMHSIp8tvev6oKQBhledHP2MCLS8gnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744688464; c=relaxed/simple;
	bh=4uJogHapYuAK8/0hvb1Wb6Sj6En818ZTuIo/pDjCC58=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hz9Cyg1+N6nlQ+0kObRAVs6tbEy619ZV4Zso5RuJwdvT8FEnO7Ziz7ywpB6wXZfnUN1L1ocsPcjWTvRJsJKEURNXcbAvEoSRoOBsIWU+oyYzEggSrldcElGXwVYI3oxiaD47WvSivIHoERWo8TM9RePmNDIbgaVNIldcrLsaiKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=r6V1zvGy; arc=fail smtp.client-ip=52.101.72.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfhY9BmbQertGj8GxSOk2H9yp72mbJBHJbThy030k7OPvX/IkYrnTg/Lf+HrpzlsR5XdrQt+xTVqwILKCQyCVI+U3kMZj8aqMnTFyDA7yBamL364McVmGVSRTwxWVO61WzYP9uybsyT8m15VPj0Z3wzNiKv9Q/W3VGmBfQutTx+2EQ5XRz8qYiSW4Q4bIjEi/KPhSGsxlexphYiPedWgN6xveHuaZDDjFMfw19dwO1s9dheTb44MlnwfpojTdeAQka1LQZiBRJJM+E0sWI/BN3QyhKnxZJ3LvJJ/YjlaadOlhWq+1nS0+pTmAzp6eHeyG3SyQTd14Uz1vdSV9RD8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzRveKKo9lwUcdEL9dECP7gh0izKDOCuKCvlm8AZlJw=;
 b=i3QdhbG2dFC2jOUfPB4f6AnW/JRt3uzfwy5WW/WZYzPprV2xy2AXMDAWfVapYYLqcWMo+lXS+wbVHKRqR1AZrj9JMIKREa+SF8fB4W1I0CA7i7X3Y+xTxTIKCb1wtO3yUEy8O0DR9QkoG/hYlZfK4Nh0cEsTeHpKOEgHK+8V97MMzxdftTQ24j+pYM4LP7tQJAOOzBnx6QF1YDwxWitoN5GeRyqC3j1TKHEnchzpGNVrT0NBGOtj3/9FK2MWwitaJ58OFOg5YcxSplIItYicCLWOoCGNCiGLQAt6XIis1kL9gM1SWw3Z8dnrIgtXlto38fF7iDyvAMW7ih8p6o2WfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzRveKKo9lwUcdEL9dECP7gh0izKDOCuKCvlm8AZlJw=;
 b=r6V1zvGy64qDT9tP2rdrxVb7AjyYHxVFCG8Tnw7Ax4mWObOvU78GVeaZ9J3ERiLATFAuGquUGAoaYqFxJDLVq4K58N2GRlPXOxTnxTcE2HJMpadxYvnvQuy7KtNQYVUVOOiNEOiIWnlO36ZIybA1SjgcAmSFbv1zDMigfPfPQVI=
Received: from PAZP264CA0235.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:238::16)
 by AM7PR02MB6420.eurprd02.prod.outlook.com (2603:10a6:20b:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 03:40:57 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:102:238:cafe::9c) by PAZP264CA0235.outlook.office365.com
 (2603:10a6:102:238::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 03:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 03:40:57 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 15 Apr
 2025 05:40:56 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 15 Apr
 2025 05:40:56 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 15 Apr 2025 05:40:56 +0200
Received: from pc4cv4203v8f.sh.cn.axis.com (pc4cv4203v8f.sh.cn.axis.com [192.168.77.92])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id EA49A155;
	Tue, 15 Apr 2025 05:40:55 +0200 (CEST)
Received: by pc4cv4203v8f.sh.cn.axis.com (Postfix, from userid 12715)
	id 19424D3923; Tue, 15 Apr 2025 11:40:55 +0800 (CST)
From: Jerry Lv <Jerry.Lv@axis.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Sebastian Reichel
	<sre@kernel.org>
CC: <kernel@axis.com>, Jerry Lv <Jerry.Lv@axis.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] power: supply: bq27xxx: Retrieve again when busy
Date: Tue, 15 Apr 2025 11:40:47 +0800
Message-ID: <20250415-foo-fix-v2-1-5b45a395e4cc@axis.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.1
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DB:EE_|AM7PR02MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: decd927a-051c-40ad-20bf-08dd7bcf5515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Unp4djljRGZjckVIdDlVVjdXQ2VSOGYwd3FTOHJ3c1FXMWcwMnZTNzFiMSs2?=
 =?utf-8?B?c0RnY1pYb0ppVGRweEplRERYMFlGT0hsTDJUOE5nS3cyT2NYcEdmYVQrVmVT?=
 =?utf-8?B?WFVYaWxxV0luOVpxaHMvOEdGR2hDQVBMMWg3V2l0WmV2c1JvVU9abGdySEd1?=
 =?utf-8?B?eVR5ZXlaalpiRnMvSHJRTklzMU9QdDZVZ203Qk1ya2l3S1hMNjJJQ2VoK3Nj?=
 =?utf-8?B?VUpJSmFlVFRMUGtwUUw5cHdlQys4Ym9mcDVTVHl5SG96K3cxbmNhQlJpWmUx?=
 =?utf-8?B?UWY5L0d6RWdNeFFkcU9wOEtENW1UbGVpN25CY1FJaENNRnFhajhCNmF3TEc4?=
 =?utf-8?B?eE52MEZZMDVMSUZSa0FMbFdSdElPNTB3aHh1UE9ZY2lFVWVyeHV5TnExRUY3?=
 =?utf-8?B?Sm1aU3N0QzhXL3pPRHBIY3NOVUhPSW95QUk1MXNZQndhdDJlVk4wWkgwYjZu?=
 =?utf-8?B?NTBXVTVJWjU5ZVRDRFVFNmlnUWxtUzJJenVRSVVBV0hDTHl0cUhnTWhKMGor?=
 =?utf-8?B?dStCcVg5UGw1RUROV2IyTkRZVWxuZU5EVjJSMGhodDY0OUZjOEJ1MVd3WEps?=
 =?utf-8?B?OFdaU1d1QzJGOGROR1NTYzc1OXJONW5XTnVIdW1TVnh1cjFRMmpzYWlKQXFC?=
 =?utf-8?B?YlFrM1hTdXhNV1Z0SUhvTW9tTWtvcVB6QTZQWjlLUXdQR1BoRkxTZktLZkRF?=
 =?utf-8?B?TGl5dmViK21vblhhQlVubXh5SDc5OVlBclZDWEJFU3IwKzBBK3Jzc3owMXJV?=
 =?utf-8?B?VDdVTGVUMm1DVmV1MzJhSEpicDNYS04rTmZoQ3dnTDdYbkVaWGxhSWdQSFdn?=
 =?utf-8?B?QldjSGlFZlVYYjhNVjRKeHhVTTdZZnJpZzB0a1JaZDl2bWFPQSsvMnlNYWN4?=
 =?utf-8?B?UW5hS1R5bGUzWEtqVU5ER1VydWg4U2lGY0V3WVJiQWRQOHdWWFVsRURKYm1L?=
 =?utf-8?B?bkpaQU9mdmFlOHd0dkxlZHZWZHExQW45NDJIMHZ1T3ZaZHdqSWNua1I4SVl3?=
 =?utf-8?B?SkthZURJSlord1hqdDRHQmxkMmRhQlVnYWtVbENNelhzK0RoNlhjN1FWYmM5?=
 =?utf-8?B?WWduN01ObE5ITUdFNEFFTmF1Q2RnZWtkVG9sZ0ZPVFhRUHJjRWw5Y2t2L2VS?=
 =?utf-8?B?bFdKbmFXVHNYNy80Y2o2RFRwc1o1M0dHTkpubWx5bHN4NkdqQXZhWXZjQnRF?=
 =?utf-8?B?bzE5bGhmbGNsSEJXZFJYRlJCcVJmSktFQmdSOHl4c2l1bFFWMi9EY3NveEt4?=
 =?utf-8?B?eFRBOFZ0Z2ZmTnZsQmZkVEtKWEdnOUY4MU5sSnBYeENhRDRqbTVpeDc1TGtG?=
 =?utf-8?B?RzVGTDd2c1NyVHhYcStiQnE0MkZ2b2NySEd5RTc4NDkxWkR0cDZGM294V2M0?=
 =?utf-8?B?bEpXY3ltREt6V3N3QmYvR2xETjg2VGtRK1YvT3JUcWtMcFNaMUlpQ1UrajI4?=
 =?utf-8?B?Tk1sdDdTZjJJVTFxWXZvMmdhS1ZKVjRyeE5LbHdSTVY0M2c5aWJxLzlnVXVM?=
 =?utf-8?B?RWdvOXRZQ1hhdm9wemFuSVBPK0lKOGVSNEN4VVlQQU9tbGFrcjE3ODNscmpl?=
 =?utf-8?B?MklVSWJDQlZYa0hScmdXenIrc3FBMGxtdkU4dEtyY0JWRGpKU09ZUWtPSkhQ?=
 =?utf-8?B?bXRoNGY3cEVycHNGSXRnT2grZVBGY0Y1V0Y5c2dHdFNmMHIzSG1hTU1GSXJE?=
 =?utf-8?B?VkJmWlB2TWtiRTIwSk1pZ2loa2tZTUZ1Vkd6ZWM3UGcwN01STkNXVzdMUVBw?=
 =?utf-8?B?R2N3YW81aWRxZGNFWmE0WHZKOHI0MVZXcThGczRoVk9aTTB0UVZXMHdJY0ZF?=
 =?utf-8?B?TktvSXJMOGZhSDllSFpxWEpxdGU0aXFyaXBTdytvZ29GdGV2c0Rxd0NwaFlt?=
 =?utf-8?B?cHc5ZzhpblVUSUVzQVpKUFdDbU94UHJJRm1SNHZQY3B3b1VVYkdlZlVXT2pV?=
 =?utf-8?B?YkZoY2t5UVlGakgyemZObWR3YUUxRGRydFp6TTMzaHJhMUVYWkNYMVRMUWdl?=
 =?utf-8?B?NFZKcm1yS20vd2pUbTVKdkV4UW1GUFptMDY5NDR5bU41cUNZZXFiYlNRRmdR?=
 =?utf-8?B?MkhvU3gyV2cwcWROR2luTTFnckxsWU1YRXBpdz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 03:40:57.1902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: decd927a-051c-40ad-20bf-08dd7bcf5515
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6420

Multiple applications may access the battery gauge at the same time, so
the gauge may be busy and EBUSY will be returned. The driver will set a
flag to record the EBUSY state, and this flag will be kept until the next
periodic update. When this flag is set, bq27xxx_battery_get_property()
will just return ENODEV until the flag is updated.

Even if the gauge was busy during the last accessing attempt, returning
ENODEV is not ideal, and can cause confusion in the applications layer.

Instead, retry accessing the I2C to update the flag is as expected, for
the gauge typically recovers from busy state within a few milliseconds.
If still failed to access the gauge, the real error code would be returned
instead of ENODEV (as suggested by Pali Rohár).

Reviewed-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Jerry Lv <Jerry.Lv@axis.com>
---
Changes in v4:
- Optimize the I2C retry logic
- Add Reviewed-by tag
- Link to v3: https://lore.kernel.org/all/20250319-foo-fix-v2-1-ff4cb232ef42@axis.com

Changes in v3:
- Move I2C retry logic to bq27xxx_battery_i2c_read()
- Link to v2: https://lore.kernel.org/all/20241029-foo-fix-v1-1-1dbfed72d023@axis.com

Changes in v2:
- Retry up to 3 times when gauge is busy
- return the real error code when fail to access the device
- Link to v1: https://lore.kernel.org/all/20240913-foo-fix2-v1-1-a0f499404f3a@axis.com
---
 drivers/power/supply/bq27xxx_battery.c     |  2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 750fda543308..99631ab46e8e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2030,7 +2030,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	mutex_unlock(&di->lock);
 
 	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
-		return -ENODEV;
+		return di->cache.flags;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index ba0d22d90429..868e95f0887e 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -6,6 +6,7 @@
  *	Andrew F. Davis <afd@ti.com>
  */
 
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -31,6 +32,7 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	struct i2c_msg msg[2];
 	u8 data[2];
 	int ret;
+	int retry = 0;
 
 	if (!client->adapter)
 		return -ENODEV;
@@ -47,7 +49,16 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	else
 		msg[1].len = 2;
 
-	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	do {
+		ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+		if (ret == -EBUSY && ++retry < 3) {
+			/* sleep 10 milliseconds when busy */
+			usleep_range(10000, 11000);
+			continue;
+		}
+		break;
+	} while (1);
+
 	if (ret < 0)
 		return ret;
 

---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241008-foo-fix-b2244cbe6dce

Best regards,
-- 
Jerry Lv <Jerry.Lv@axis.com>


