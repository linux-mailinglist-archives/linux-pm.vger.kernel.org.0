Return-Path: <linux-pm+bounces-24274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8E7A688A9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 10:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83985884722
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA1725524E;
	Wed, 19 Mar 2025 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="fWMfIa6c"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE424EF61;
	Wed, 19 Mar 2025 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377323; cv=fail; b=EMebJ0PtSRSRS8tU8hOpSCmJb2VGxNehgWOTkebl6EkSRC7kTnhxTn67Bm1LmOQrk2IJlSOSi82tWZmU2y9pF06gE9+wdGWJzGCv0OrMwFgKw95JsOS+q1PUHCWdyljO/qj150VSIyQk+K5yJEQZG147JAlLdmcbiU2t5qljX4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377323; c=relaxed/simple;
	bh=uY5J503eyEUQCcdAp2EONXc6CJG5biszUwbp15im0qA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YqJl7r3L2p94MQzAI/6CojaCDd/v/NnxuN+JYJLioVGz6iK2eysG8MYDMRXTtPxSslxvVvYP4hlg4GLaCDCoU5xlomaft486bB2KQeqNVsMOU9ibe5DIjoEcB7jfxa8IkoiisM44aqSkixP/ukUFa6YUozqAoQY1549Z4+8OfYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=fWMfIa6c; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMEHsmH3fszw9ZpHwO9eux2X2vbzzyv/SaqvsekZFZmIodR/YZfpmzJLqtD69vAggCHPrXfoKkwHkkF5rTYzz7oBiVBEnCbaiLvASqypBv01gWyxI/STDSrxVVuDRwphhX830jqlM2YUCX0N8pjl3itdAKkYsOkDHrbO+5/EmSlOUJd3wTAtbIXEMVQ7AaG20Vyv0wF6ctrQdGo/pU4vTF91WadAtKCIMhqdnOhfOGedmRYikVVanomT/eJGhO6BB7KH3U6V4RL/A/UM57jgSL6TJVf07REehg+DnW6q4aXLIlYoL/+DG1jzziPiuOWSuO2to5qA7cdEu2W/+s0jUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5zUzb97NnKYgEgINsow+xvzBgT8hAFSvKm+i/vOCdo=;
 b=PObbbo5lr952cecjfiAHrEIh1hldaNdNxGjKJSJLfFSG3oKMb2+LWCCoojnvni0jLJ4Y+HQeoYPgHah4bjjktcKqZx6Cdq/CtcxQDwEve/trbGyJOfc5ZxqstdYNM0nZenIYbCWw2QGfJskdPuVpjZDUoY2yX7uii3JjXtVT5migKjkY6CYLsz1A+HUByxe5hSTieM3CybmhcjtNSZvTKxegrNUhiGfKvRTfBXKyLsuDB3qWJlMApWR73g1hZuVwvSGboa7FVOyf8nVGXfbhjhglwxW4p0Ob+I/mlmEMesG6wKO0QpwRmPxGpOiGOnsU6/Vp7Qq4kwV6Nw57wpQKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5zUzb97NnKYgEgINsow+xvzBgT8hAFSvKm+i/vOCdo=;
 b=fWMfIa6cIexjgvvRK4qrk+RhWicQYnAoHjLeMpvog0cTeZAhgMmryQh8GFl8eSwdMgahzk8lLqQo8dbaD5NCKI7dQj0qcBZob79QlFNzDSib3ORYNfyjDWLR88hT8gq6ygRePVx6fpJmz7PbtkiIw6dC4qEGTBrAheM9g7BtG4s=
Received: from DB7PR02CA0020.eurprd02.prod.outlook.com (2603:10a6:10:52::33)
 by AM9PR02MB6948.eurprd02.prod.outlook.com (2603:10a6:20b:262::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 09:41:56 +0000
Received: from DU2PEPF00028D00.eurprd03.prod.outlook.com
 (2603:10a6:10:52:cafe::dc) by DB7PR02CA0020.outlook.office365.com
 (2603:10a6:10:52::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 09:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D00.mail.protection.outlook.com (10.167.242.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 09:41:56 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 19 Mar
 2025 10:41:54 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 19 Mar 2025 10:41:54 +0100
Received: from pc4cv4203v8f.sh.cn.axis.com (pc4cv4203v8f.sh.cn.axis.com [192.168.77.92])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id AD39E129;
	Wed, 19 Mar 2025 10:41:54 +0100 (CET)
Received: by pc4cv4203v8f.sh.cn.axis.com (Postfix, from userid 12715)
	id 12983D6866; Wed, 19 Mar 2025 17:41:53 +0800 (CST)
From: Jerry Lv <Jerry.Lv@axis.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, <Jerry.Lv@axis.com>
Subject: [PATCH v3] power: supply: bq27xxx: Retrieve again when busy
Date: Wed, 19 Mar 2025 17:41:28 +0800
Message-ID: <20250319-foo-fix-v2-1-ff4cb232ef42@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D00:EE_|AM9PR02MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf10ee9-3039-4ad4-aa60-08dd66ca49cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHIrcmsrZHF5bnF2a2sycnQ5QTZveUR1QVRzbmQyV05DdUs1dDAyTHlGTzlC?=
 =?utf-8?B?S3paUWR1N3J2OSszRG9wYytMaDI5dmMySWJEOEg2MEU0WkN4OHJKVW10NWli?=
 =?utf-8?B?WHFlQ09URXZ2Nis4K0Y4cUsvcVIzcGphQ2NGVitUOVM4Y2xCT2xjZW9nT0tl?=
 =?utf-8?B?NThUVUhTdkVRYTc3TXVKNzN0SmFPT1VTZm0vYkFmc29xdnBmaWxiK1Vsbytm?=
 =?utf-8?B?aHM2eXZwWjJuMjQ3TlUxNmNoMjBRTzBGclk2UEh3MUMrRjJxa1M0SloxOHpL?=
 =?utf-8?B?aTF1NWdXRVFwM2l1N3RxUWtKSEpHbnlsSENOajAzWWVlYWJGa0RlbWg3ck1z?=
 =?utf-8?B?eXBhNFl3QjJ3bzVacHdxRDM1Tkdxa2pMc0YwbHVNaVhkQnFGcllUQVFXbk10?=
 =?utf-8?B?RXFodjM5bllMRm0zbXEyTlVacGdKbXVUSG92WXZZVlN3VTdyUW1hMm9ObHJn?=
 =?utf-8?B?aGFlZ0xndUVFVnoya1NOUGN1R3JvQU4rWWhNVTl6aEJlT09tdm5uckZueDli?=
 =?utf-8?B?cmxDYUo5N2Rnc0RiSkZnOHdoUUxzWEZLWFpJREg4QzNtNGtLUEQ3K2JTUzJt?=
 =?utf-8?B?bEt6Z1orTHdGT1UxYVNxZTFjaC9PcW0wWWlwWnVVQVExeTV1Mmc4SUVjZk9r?=
 =?utf-8?B?NktFTkVOQ1BVbUlNQkZ3QjE2SEM4ZmU3UWMrcFRJNEJ5NWJjR0JJcHVMck9S?=
 =?utf-8?B?cmFsWU5IUEpoN3V0ODEvUW9iNGphMEp1NXI2OFVDMVhVazhLbWkrRXVyandW?=
 =?utf-8?B?SXA0dC9peDNZRTlPQVNjelRydW9nZXBkaVRCbVpxeFlMdCt2SFVicklBNUdB?=
 =?utf-8?B?VUN2a3lFTWdWc1lPUWNmUnhKS2gzN2REQlpTWjlsRDRNd3pCVWI0cjhRY0pI?=
 =?utf-8?B?ZVZKMkNLa1JLVjFNcVVQZGcxTGZrS3lIeHZ0VGZ2bHNHMTlyY1VoSGwxQXBC?=
 =?utf-8?B?dExCMG9xM0dRVHFRcWtnbzdyZmwrakdkdmd4Rmh3QXFKTGdpRFVZdHNZbERE?=
 =?utf-8?B?YlNYM0s2ZFdSTGUvbER2bFVJS3hTRFVPYkxudzBOWHFMTW1kZTRseEN1QWtx?=
 =?utf-8?B?bEhCblI1NFc3UjYzanBKR2kxdHdZbFlzdU1RVUY0Y0xTaFI2MklCekJ5MjEr?=
 =?utf-8?B?bytkYlh4eU10ZjB2VW5iKzF1SjBDWjFVd0lRM1Q4OWYvNU14THNoWDJjS2xY?=
 =?utf-8?B?WFpMOFFMYkwvMks2Uk9tb2MrTURCcmhJUjJWQUhiWUtTWHV5aGd1dEE5ay9l?=
 =?utf-8?B?RFJ1Y1J1K3U0UENuTVJOZHhLZjE5NEJMVG5RVlh6WjhLM21aeWo1akg3ckVE?=
 =?utf-8?B?YkNLd3dxeDErbkdlVis3cjFIcGNzdUg3eG1VTlV6bjFLNVR3RWRKUTFtNUlG?=
 =?utf-8?B?QkRHaWRnTmFVUUNGZnNQNFdmaUlPNXN6Z0laMkNRZFNUU3RIMFA3b25zaFJU?=
 =?utf-8?B?YmNXdmpsKzBJN0ZrQUN3YkY2cUs1aW1OdVJBQmFCZjRQQ3hGR3BjS1h1VUl5?=
 =?utf-8?B?aFVtd3hwS0ZWd3hoNVBDTk4zQnpBOWRqZ0tNeDlaZFd6NjdDSVo1M3dsTWYx?=
 =?utf-8?B?UUhRb0RSWmZvb0lBc0ZsUDZ5NEhNa3Yxb3dRcmNHYm5IY3VmU29BRFl5bDNq?=
 =?utf-8?B?UlU1K3FBWUd6Zit3Y0lyajBmYmcxVVh1ZGtXdHFwemhPbHlqd05FNzMyNGEx?=
 =?utf-8?B?b2dJbE1oM1A0NFQ1RW9jWEYxWWNSdGlCZmVscmw1OEV4aWY3dDlVT0JvYUpi?=
 =?utf-8?B?QmNyT3lHcGI3YzJoaWszRjRZRXJ4NjF2R282QU1UUXpxWXdxNEEzdXA2a2k5?=
 =?utf-8?B?Q3dWeHNiVDIxczJBRWVxSzhNTGFtKzNRTGhoQnRZcE9pTlZtYXREK2RSVGVP?=
 =?utf-8?B?UjhaVXE5NW43dEwzRW42MWo0V1owRlhlanA1K0hwZktKcDcyL2VjY0lIVkxD?=
 =?utf-8?B?U2UrWHliN1lHSUN0NFg0bTVLV0Fpa0pMWlFjQzdFU0JKNXk0U0VmVlhHYTRL?=
 =?utf-8?Q?YJnWOjAGlqztaBl6a141wKw4FW3Mv8=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:41:56.3430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf10ee9-3039-4ad4-aa60-08dd66ca49cc
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6948

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

Signed-off-by: Jerry Lv <Jerry.Lv@axis.com>
---
Changes in v3:
- Move I2C retry logic to bq27xxx_battery_i2c_read()
- Link to v2: https://lore.kernel.org/all/20241029-foo-fix-v1-1-1dbfed72d023@axis.com

Changes in v2:
- Retry up to 3 times when gauge is busy
- return the real error code when fail to access the device
- Link to v1: https://lore.kernel.org/all/20240913-foo-fix2-v1-1-a0f499404f3a@axis.com
---
 drivers/power/supply/bq27xxx_battery.c     |  2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

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
index ba0d22d90429..78cccea4d419 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -6,6 +6,7 @@
  *	Andrew F. Davis <afd@ti.com>
  */
 
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -27,10 +28,15 @@ static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
 static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 				    bool single)
 {
+#define MAX_RETRY 3
+#define I2C_DELAY_MIN 10000
+#define I2C_DELAY_MAX 11000
+
 	struct i2c_client *client = to_i2c_client(di->dev);
 	struct i2c_msg msg[2];
 	u8 data[2];
 	int ret;
+	int retry = 0;
 
 	if (!client->adapter)
 		return -ENODEV;
@@ -47,7 +53,14 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 	else
 		msg[1].len = 2;
 
-	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	do {
+		ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+		if (ret == -EBUSY && retry < MAX_RETRY) {
+			retry++;
+			/* sleep 10 miliseconds when busy */
+			usleep_range(I2C_DELAY_MIN, I2C_DELAY_MAX);
+		}
+	} while (ret == -EBUSY && retry < MAX_RETRY);
 	if (ret < 0)
 		return ret;
 

---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241008-foo-fix-b2244cbe6dce

Best regards,
-- 
Jerry Lv <Jerry.Lv@axis.com>


