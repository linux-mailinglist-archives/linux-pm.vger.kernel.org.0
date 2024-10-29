Return-Path: <linux-pm+bounces-16634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759389B4110
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 04:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993681C218EC
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 03:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80219596F;
	Tue, 29 Oct 2024 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Jw2b1UUP"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2682C1F4261;
	Tue, 29 Oct 2024 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730172917; cv=fail; b=J0qO7JDUMPb40WZSN4SlmxR0XLE0YI6Zw85NjkfeZdloLmiQt8FwnpBzV8SD/GIFFXrpTEMFaSOlc2avXbpoPapxBfk4VfI+6eDTXtHiLxfxqxNCyJRsvb/nTpohzcR+xcyjkseme2H3eCohN/t2LpYtzJ5Kib5OaxvOs83AF2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730172917; c=relaxed/simple;
	bh=KMUskBuq4E8vIkY9DeoVxROmsLhKSGDPMb2PtzVXMuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=fSeS3aH0QqhuZgwZlrpNWaErVyPsDt/FdfT0l8wFpkYruSWhDC/1elhryA7cQKuW3GWXDm4meZNxZ8nbjJ4oqZ5d19WXQIpPbbMWUbOtNOPcb/s4GLjXVb5236fuosaExeMtCJrBV8AMe2GwHJR/VB+rDdX91ejDzy57t7lLKBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Jw2b1UUP; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqsTUUURhQDbbvTB3RJWMw+ZElKlUhQxD+EUGTQmKwxgKaNgrbjyIIypsHCQliiwQnrtDFKUyQQiy/VLcUyCC+KyVv3Px5HJ+5pEWFvj3ttEgj5hUMucRtgc024tGKuImPukQCHy+9kiGc3AJQXyZeJrDqW/HpINlgqYalfRx0N+9wfFIrHeIr/PZEI+TErVLV/kquE5dff57Fp7ShEGK5M5crstkZC0zVLmhwvytEVV8nCNg2mLqDGeliC4tNLesfiV5DLHQdqko/WOuAyga9eqY7qPtNxvwe8qH1z9Fp6EM275rJ7NW9lxCi2CE5+HrCBDek2Gn0t6dQwcfsWjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGv1Apfr+qyKUV+pPax2t9CkYG6mFgmXPF1oX6cVyZ0=;
 b=IeBxRlSxphMWREkrORuzF3PBXmu6PcSmVoOs026Aveg05oJmWo3NOEy3BuSdAZ+xQDamBX4Kq+Y2Z0Y9iALZHvvKJ2sjsl3YL3MIMb8BjMsf6VKELu/e7ms3AlYWKRIUwP72sD6n2OspfMJq8WIdd3dRyXtE82pcNOhpi+fP13wuTPMBb3p7ikRy80yn+MZkl4rM9rpy8i6rcWyVLC1U+GLqaEwTIuhkDM2FFCE8q0cCBAcxvohb5eWZwfbfRvpQz8n8XkxaztS6cz3Z/utqqs2op2RtLLjzHzuqTHCzSxQ6zexjkmXL38mZOU7NAsA0LJK5eolVMxy8HJe3a7hfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGv1Apfr+qyKUV+pPax2t9CkYG6mFgmXPF1oX6cVyZ0=;
 b=Jw2b1UUPNTPkT4+Q4tKHLjPfDr4oLDmHB0mMK00Xhidq4qsvLgjHvZC3VKBo1EsYwmaUmxAUhV0Rdz/EIAlLiCxIQxuPz5hjGTErPDZgGzo5XwkUX48uMyIuHuUSa0frc8J/BW2i/JRpcyBulhXbjJjjtJx15g74eFbMm+Zkpws=
Received: from DU2PR04CA0279.eurprd04.prod.outlook.com (2603:10a6:10:28c::14)
 by DB9PR02MB8394.eurprd02.prod.outlook.com (2603:10a6:10:399::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 03:35:09 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::d9) by DU2PR04CA0279.outlook.office365.com
 (2603:10a6:10:28c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 03:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 03:35:09 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 04:35:07 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 29 Oct 2024 04:35:07 +0100
Received: from pc4cv4203v8f.sh.cn.axis.com (pc4cv4203v8f.sh.cn.axis.com [192.168.77.92])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 6E518154;
	Tue, 29 Oct 2024 04:35:07 +0100 (CET)
Received: by pc4cv4203v8f.sh.cn.axis.com (Postfix, from userid 12715)
	id C5671D6F04; Tue, 29 Oct 2024 11:35:04 +0800 (CST)
From: Jerry Lv <Jerry.Lv@axis.com>
Date: Tue, 29 Oct 2024 11:35:00 +0800
Subject: [PATCH] power: supply: bq27xxx_battery: Retrieve again when busy
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20241029-foo-fix-v1-1-1dbfed72d023@axis.com>
X-B4-Tracking: v=1; b=H4sIAONXIGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwML3bT8fN20zArdJCMjE5PkpFSzlORUJaDqgqJUoDDYpOjY2loA30l
 Df1kAAAA=
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, Jerry Lv <Jerry.Lv@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|DB9PR02MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: f52ae505-d6a8-43ac-285b-08dcf7cab038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2Z4VDJ6eXJQWWNQK24yTGV6ZEI5WEdhNVRLNy9mbW9yZ2dwUUVLc2tlaXRi?=
 =?utf-8?B?dC9FODVkenUwdUtTQmlMemlabEUxVVV5NGV4RThtLzM5L2l1U3VjaStEQlZK?=
 =?utf-8?B?U1NiYTNTNUFCeGZ5VHMyZjBxQXpnaUpyNm5jaXljd1h6d3dUVW5DK3ZiTUxv?=
 =?utf-8?B?dXdXbmRJSHAxSHdVelpEOXZtZHliNEpvazEzbGhHODVObFV0UXhhYlFBbDds?=
 =?utf-8?B?MkE2cmxYc2EwamVzeDQ0eW9WaWhKUm9BYXVpdDV4dG53azdNaXJBc1kyTkFF?=
 =?utf-8?B?WWxZM21PN3dqTm5aNFlhS2hzV1gzWUZ6eHNTaE5iUndJeUhONGJKWjNyQVUz?=
 =?utf-8?B?cHlvWnd5Skc0QnRSRGVLWEo4YzA2NkNQTnVDM3JndjRmTko0RTQ2Q01PNkh1?=
 =?utf-8?B?cjZqaGRxNVZJQ3AvR1lwVDc5U0hTQWtTYThpK0JoUEswZnlOVTl3KzV1VTcv?=
 =?utf-8?B?M0RjTGlXdkRRUDhadEsrTm9QUEhGNnBOL2UvY1BKblNQT20rVHNSaEZqYVRt?=
 =?utf-8?B?UDZ4OUtNZnhLcjVXTmk1U0hsS3Q2UnlzbElLWXAzRUVqQjJlTWQ5NTVzVk5w?=
 =?utf-8?B?emdSQTBsamczaFVES2x1aTRtYzd1a3Y1aUQvL1ZpUDc1NnJmb0JXVWJBSGdu?=
 =?utf-8?B?Qy92V0NUeFh1bG1DVlUvQ2E1b284ZFBYa1ZiQmcvMGNJbVFPRGlYSUFFNzlC?=
 =?utf-8?B?cDVFODdscU8vOVRNbGhHcEZFV1NkaUN4K09BVldKeTIwSG9pemQ2ZnJHdTRY?=
 =?utf-8?B?b2NvRk10K1ZpcVZkVHpyZHF1SjJXN0ZLZUFEWVBKNVUyVmRMdGdBV0UwTDRH?=
 =?utf-8?B?eWpzem1SNTNNakV3L1hHS1k0V3ZrUS9Xb3Job2tIT2FHYThiWE9DQzJ3UTBv?=
 =?utf-8?B?S3kwdFEreEhBdGJUcEN1bUtTR3JrU3h6NVQ5U0VocVpJbVd1K1FROVF3VGFQ?=
 =?utf-8?B?bC9CcjhoZDlUSDd1MnhrN245TkxlbzVEbG1TNnkxTEN5WWtBSFYzVGY0VDh3?=
 =?utf-8?B?Q2NjMklzay92MjZkem1TazRFTDc0Q3U1Mk4rbFpJM0VOdmo0U3hDeEsrSE5r?=
 =?utf-8?B?SW5sOWYzaGNPWGF2Q0tiSUh1NTJmOUlvNUpOanVKV2E2eWRTUkhEZ21GQzZa?=
 =?utf-8?B?SFZibDJGQytublE0WmFSSUtMYXJiUngvbUZ0UEVZdXM5SDdiMzhlM0VVZ1V3?=
 =?utf-8?B?Zm9BYmorVWxnMVBuVzlIeFNxNnhDSG9TQXNXUjdqaG9kM1JRY1JmeTlZUEw3?=
 =?utf-8?B?eEVzaGhzK0xoc2RGeGpVemRZN3VNVEZOODBDb0oybjVQWnZKQnlDUSt0NXZC?=
 =?utf-8?B?TG1rMHdMZFdjdDBPZ2JmaHRUeGtxeXhESGhaMEJQNVNiK2tqaTNTUEI5d0Ru?=
 =?utf-8?B?N3I1RFF0dnhRN2xBakFSM0k5cW9lVGQzOWx6a1BNWmpFVExKNFhFc2RuNUhT?=
 =?utf-8?B?TXE3VTRraVlQL1ZmamxMczlDaGxweWpEVDR6S0w1WUNKTEoxQUIwQkxSUkNl?=
 =?utf-8?B?cDBrRnhPbTVVUkJlSjJFMVU3bHI0bkp6aWpKTjQ3dG53Rm5xdmwreU5wRCtt?=
 =?utf-8?B?eU56aUpzSTdUWDd3aE1JQkdaK1JvQ20xNDVHZEpQSlNSQjRPYUp0T3N3US9k?=
 =?utf-8?B?bkduWlFHV3FYL2RaYitlMEYxSUdXcHRyMlRoWTZnbUh0Nk9keUowa3pwenlL?=
 =?utf-8?B?b2Q0Z2FxRzJ4WTJmcWdyTk5pMHBwK0RGRzE0NVJ4UEFkSzBKYmxFcnhTU3I1?=
 =?utf-8?B?dUdVYWxTeHlGR3lXN2F5Z0hydDd5RkUva2l4YnlwNTMyLy9CUWVDK29SN0Iz?=
 =?utf-8?B?K3V2TmhPcHBPQmRHQ2ZTdmtYMVVHQ3AvYS9DdzFEYzQ2VmQ1WS9jNHk4RmVI?=
 =?utf-8?B?eUNuVkliUUN2QWtFWmdzVjZTWlpLbHU1ZjllR3IyNjdpL1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 03:35:09.1067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f52ae505-d6a8-43ac-285b-08dcf7cab038
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8394

Multiple applications may access the battery gauge at the same time, so
the gauge may be busy and EBUSY will be returned. The driver will set a
flag to record the EBUSY state, and this flag will be kept until the next
periodic update. When this flag is set, bq27xxx_battery_get_property()
will just return ENODEV until the flag is updated.

Even if the gauge was busy during the last accessing attempt, returning
ENODEV is not ideal, and can cause confusion in the applications layer.

Instead, retry accessing the gauge to update the flag is as expected, for
the gauge typically recovers from busy state within a few milliseconds.
If still failed to access the gauge, the real error code would be returned
instead of ENODEV (as suggested by Pali Rohár).

Signed-off-by: Jerry Lv <Jerry.Lv@axis.com>
---
When the battery gauge is busy, retry to access 10 miliseconds later,
retry up to 3 times. When failed to access the gauge, return the real
error code.

Differences related to previous versions:
v2 (as suggested by Pali Rohár):
- retry up to 3 times when gauge is busy.
- return the real error code when fail to access the device.

v1:
- initial version for review.
---
 drivers/power/supply/bq27xxx_battery.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 750fda543308..9c40bbc292c1 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1871,11 +1871,19 @@ static int bq27xxx_battery_current_and_status(
 
 static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 {
+#define MAX_RETRY 3
+	int retry = 0, sleep = 10;
 	union power_supply_propval status = di->last_status;
 	struct bq27xxx_reg_cache cache = {0, };
 	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
 
-	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
+	do {
+		cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
+		if (cache.flags == -EBUSY && retry < MAX_RETRY) {
+			retry++;
+			BQ27XXX_MSLEEP(sleep);		/* sleep 10 miliseconds when busy */
+		}
+	} while (cache.flags == -EBUSY && retry < MAX_RETRY);
 	if ((cache.flags & 0xff) == 0xff)
 		cache.flags = -1; /* read error */
 	if (cache.flags >= 0) {
@@ -2030,7 +2038,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	mutex_unlock(&di->lock);
 
 	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
-		return -ENODEV;
+		return di->cache.flags;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:

---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241008-foo-fix-b2244cbe6dce

Best regards,
-- 
Jerry Lv <Jerry.Lv@axis.com>


