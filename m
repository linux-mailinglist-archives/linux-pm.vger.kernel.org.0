Return-Path: <linux-pm+bounces-40087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C869CEBB19
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 10:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66E46300E785
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 09:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DF22DAFB9;
	Wed, 31 Dec 2025 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b="Oy/JxCuU"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533631A9F84;
	Wed, 31 Dec 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767173525; cv=fail; b=jZN5h64y4fAJFfljZfSg1gz3dbuUt47tQV/dVviTNYAv/dRGnMa8Duw4YX7JQ5ZnjAp7d+3A3/SHOf24L9vI80sxkgwTwWjlsm2kodMFwN2MBlOuAqwhWir67evPHTebxhuW6FW+Leh43yQFq1Hn+Lch8wWCgzhpHnBcT0UiSEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767173525; c=relaxed/simple;
	bh=YwtTs7TNBIA8N4GBDJDvRKi/xbARZQUyx/RqwowniE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPPQ2LJZTjpSQ1lCC/CJjPVgI1NBwxQ1wx6jIxH92IwRPIBJJIdKFcw7kiEXhjZ2Re1jTrJI5wXkhx4RqcDyyMVnG/XCVm7Sr0C1QtVN0cpPv6pGkTe6z0TeHenhP1kctXsuJwnSZJ1JzpfKvGmup120zRbEfX/htVYge1mr4Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn; spf=fail smtp.mailfrom=leica-geosystems.com.cn; dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b=Oy/JxCuU; arc=fail smtp.client-ip=52.101.72.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com.cn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EG4hCMtzyQXrYGcKmySIef2FNBMwjKISwdDBemHUBVUbh8Na69JTknJ6e0lvUsODOHQUO00ACfsXt0eNo1OHQTzu+mS0aVUJCI7IUfo0n/wPdXo8vau9Dvipe4Kn69SnNWjw5Jq1Lm5zuGVC8sr6j2cCk+vTgufJgh1Jam0HeAP5V5FF5A1YUEzecXo8xBib4qXdf0bUO30aNstV+ytKPbEYJ39xHNVvoSwnRx/pzRwPtQtANF2LN4PaVOPzxvzAWoNJzsS/GIIsPVPw7m83WvNanndeIsnDB8XOGQBHTVGhhEXuo4XDJKzpKmgdm27UvOnB16rJY8VN250N2tNX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MAJoL4pWgX2HvHJ58UNxrzwPb9VptLkBpEd2/Zy73o=;
 b=oOlmZ29xxkbFrFIRgtWZEdGZ01HL+sGsrCXn72xhiNBxeiJVxmd4Y4eA3aqzVriCeKi9XBKI1VlEHYF+XnA09XPetZiKfcEDXHwXUOc3BuQghCUwoVBPFYQCATQXNr8Dti+aJVL2POzxI6BpXh6K188JuQ3MKWv8cu378Z57TJXt6ku5zjldrxyqW9dvHi80nO4yv+rnnC+AQgL4QEzQmfXaL304Fl6R2+cvshJPifIVqaR7R/xsqeOgzTiqiHgo7/j1DxNBFIn4KpdW55y+sUC1m+/YFgNPdQGoAv6/veU3R0PWpdynoaHEPFI50Ada2oDdX5fpNTgRUwPDybk1zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MAJoL4pWgX2HvHJ58UNxrzwPb9VptLkBpEd2/Zy73o=;
 b=Oy/JxCuUUO/Ic0hcnG2/ApU+eJ8LpvjhosYGWLhUxA3YGM+wbI9jagjpMTWdCNIO9IIxJRq05pNCo9s7NIc0c5HPTY9xkYXA90Lcyo/h2QwIK8j2jUiBmEbJ4d/O6rzweFYV801XYn+L8i47ntPkosRFWDWCMVlbyxLWY1xEuzc=
Received: from DU2PR04CA0268.eurprd04.prod.outlook.com (2603:10a6:10:28e::33)
 by PA6PR06MB10227.eurprd06.prod.outlook.com (2603:10a6:102:522::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Wed, 31 Dec
 2025 09:31:58 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::c5) by DU2PR04CA0268.outlook.office365.com
 (2603:10a6:10:28e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 09:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.99) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 09:31:58 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.61.228.61]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 31 Dec 2025 10:31:57 +0100
From: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To: sre@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bsp-development.geo@leica-geosystems.com,
	LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH 2/2] power: supply: sbs-battery: Add support for polling battery status
Date: Wed, 31 Dec 2025 09:31:52 +0000
Message-ID: <20251231093152.2817579-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251231093152.2817579-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20251231093152.2817579-1-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 31 Dec 2025 09:31:57.0650 (UTC) FILETIME=[4F011320:01DC7A38]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0D:EE_|PA6PR06MB10227:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 23f3282a-0242-44d7-7bfa-08de484f7204
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0VPnG3wqGgnHqty4YcWAUJtWFZ/09DyZbTig7XjD+6yNeXySPRVE/hHEHbh0?=
 =?us-ascii?Q?tyeBzA8z9SNDJT5x7+ficyL4rQ+gUmqEZG3SJFSb9daCi883cRLBbHKDrsZ9?=
 =?us-ascii?Q?tDciMzWjNl2mfF1M1AY2nz3z+xk0auK8/6Pm6n0M7uO5jkJ5nSOhGXxqsYlG?=
 =?us-ascii?Q?p5JUdgnEOtUUvXV5gxMq+XjTRNAt/rv3wDPBHL3l77S7QYQ2TcXdrwfdskKn?=
 =?us-ascii?Q?WcgdzS1Rxi9FP67vt+dS2xEwHX6uAkggm5TYrzhoCnZZVObRYLSTI1T9Z8im?=
 =?us-ascii?Q?gVoAeu25XbxIpujR0Z/yd2UJMiLbt9ya6NjL4ILA/7QSo0Rv86rVLZ951MJM?=
 =?us-ascii?Q?6oyxeFqWfXOEDMKkQw0GIpBAUuA7vxop2d67SX9UxFGFYp/hRUH/kVw6lAYA?=
 =?us-ascii?Q?4tIxmaf+U3g2/fuDig5XOvWlaqEm7oQPaEEjkfyfyLO7MpCehTjVTty7qSXK?=
 =?us-ascii?Q?C6TROrdD1kUSBgsdfkqcaAa0IyGqSWSPsQLT7CXYILGjdLEnJoi3rzj8+Vll?=
 =?us-ascii?Q?FQ45uhqMw+qoKrRC7o/mukPJfU2ArMRo+me4HO/kyX1BgeKwwSE/fH0dkLd2?=
 =?us-ascii?Q?kTiXXiwEncpymyuuIRGQmmrrisWiCcpfs0/JdPukSFzUC9hAI9b0fHT37Ppv?=
 =?us-ascii?Q?tUPqYxMK85Jy/4FsvbOqfqfnfTh5y7HfHlSHaPwApJsan8ua380P6CIAAjcR?=
 =?us-ascii?Q?3sCCRAaKwDyzmFgdENZWVVrqkBPM/cIfly8W80waH1S54YFSbqXdYFZc+pXv?=
 =?us-ascii?Q?1RbDdB3olQMW9O3GTD1MgyJrdG/JhpaXFXpTuTO25Vnezwl3UcLHa+4LGXYg?=
 =?us-ascii?Q?GQtniZRH5Am5qW6S+z+b3Zs3rZz3RcxmnW6zN4adzKXfle6JOonvEKGxmAfe?=
 =?us-ascii?Q?C9ropadZvIzmCOV3nY/V+fne+bRg8YkYbA1xt1PjIJ3qVjKIP/rhspdg5iuO?=
 =?us-ascii?Q?6gHugZEwtgnd3rMmUNZnMKGfpOve4nFKO3l5r+1uP0JIQ8bx7DX+9k6L5NYB?=
 =?us-ascii?Q?eu8itF2y9WYM4Tw0t/a8/fgCmDIIouzvYRsh9tENTAFrIkbv2yaTndKMnYma?=
 =?us-ascii?Q?MQ/mQCe432owtr5PYmyUyx4VLhhw1JjVUzxS43111a6fLOmz2EuMslurdsOT?=
 =?us-ascii?Q?K3ymUtAn1oPYtgYESPOyhG7AtB2xqxTNXnv7bKBW5S2H4kTWC+rpV3MAqQet?=
 =?us-ascii?Q?9ISGWQe7RY0U4nqYlcN9PWV1GuPbpKciS/Nv+ncGPW11P5O/ZM3YSQzd8w9l?=
 =?us-ascii?Q?IX6aliVVxB851sYXHzpmBj8Fr/YfV+rNfyMkEPGmyzBS4WMq6COkpcT/kvq7?=
 =?us-ascii?Q?nBzJdUguTgALhRXLbr/If4pJfVSkh8hJUt4fc5Cja+YdNi03hBk1DR+ilgRV?=
 =?us-ascii?Q?/goUv5n6BweN8+fUOO7NBZzMqFDCMu5/18M2YkBHodJaJjuThQv1k+Va1I45?=
 =?us-ascii?Q?2Q2cLuXLIv20r8ZmU5QoQzpYZ1d+ROUO+gdZtNzWJwpjL79ePhUNR/yiMYXR?=
 =?us-ascii?Q?ziByKM26LlvfK/oxyYVe/GOoV8C0tbiN/uDYEkZY/Nk6RiyfIziPyluZYvP3?=
 =?us-ascii?Q?33M4LXA/jmlU9Xh5Ae4=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 09:31:58.4321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f3282a-0242-44d7-7bfa-08de484f7204
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR06MB10227

Enable periodic polling of SBS battery status on systems where the
battery interrupt line is not connected. Polling is configured via
the poll_interval parameter (ms, default 0/disabled) and automatically
disabled when a working GPIO interrupt is available.

Example usage:
  echo 5000 > /sys/module/sbs_battery/parameters/poll_interval

Tested on i.MX 8M Plus platform with SBS-compliant battery.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/power/supply/sbs-battery.c | 84 +++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 0b9ecfc1f3f7..f4f1189fec3c 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/of.h>
@@ -214,8 +215,10 @@ struct sbs_info {
 	u32				poll_retry_count;
 	struct delayed_work		work;
 	struct mutex			mode_lock;
+	u32				poll_interval;
 	u32				flags;
 	int				technology;
+	struct list_head		list;
 	char				strings[NR_STRING_BUFFERS][I2C_SMBUS_BLOCK_MAX + 1];
 };
 
@@ -242,6 +245,52 @@ static void sbs_invalidate_cached_props(struct sbs_info *chip)
 }
 
 static bool force_load;
+static DEFINE_MUTEX(sbs_list_lock);
+static LIST_HEAD(sbs_battery_devices);
+static unsigned int poll_interval;
+
+static int poll_interval_param_set(const char *val,
+				   const struct kernel_param *kp)
+{
+	struct sbs_info *chip;
+	unsigned int prev_val = *(unsigned int *)kp->arg;
+	int ret;
+
+	ret = param_set_uint(val, kp);
+	if (ret < 0 || prev_val == *(unsigned int *)kp->arg)
+		return ret;
+
+	mutex_lock(&sbs_list_lock);
+	list_for_each_entry(chip, &sbs_battery_devices, list) {
+		if (!chip->gpio_detect) {
+			chip->poll_interval = poll_interval;
+			if (chip->poll_interval)
+				mod_delayed_work(system_wq, &chip->work, 0);
+		}
+	}
+	mutex_unlock(&sbs_list_lock);
+
+	return 0;
+}
+
+static const struct kernel_param_ops param_ops_poll_interval = {
+	.set = poll_interval_param_set,
+	.get = param_get_uint,
+};
+
+static void sbs_list_remove(void *data)
+{
+	struct sbs_info *chip = data;
+
+	mutex_lock(&sbs_list_lock);
+	list_del(&chip->list);
+	mutex_unlock(&sbs_list_lock);
+}
+
+module_param_cb(poll_interval, &param_ops_poll_interval, &poll_interval, 0644);
+MODULE_PARM_DESC(
+	poll_interval,
+	"Polling interval in milliseconds for devices without GPIO interrupt (0=disabled)");
 
 static int sbs_read_word_data(struct i2c_client *client, u8 address);
 static int sbs_write_word_data(struct i2c_client *client, u8 address, u16 value);
@@ -1091,6 +1140,10 @@ static void sbs_delayed_work(struct work_struct *work)
 	/* if the read failed, give up on this work */
 	if (ret < 0) {
 		chip->poll_time = 0;
+		if (chip->poll_interval)
+			schedule_delayed_work(
+				&chip->work,
+				msecs_to_jiffies(chip->poll_interval));
 		return;
 	}
 
@@ -1106,6 +1159,11 @@ static void sbs_delayed_work(struct work_struct *work)
 	if (chip->last_state != ret) {
 		chip->poll_time = 0;
 		power_supply_changed(chip->power_supply);
+	}
+
+	if (chip->poll_interval) {
+		schedule_delayed_work(&chip->work,
+				      msecs_to_jiffies(chip->poll_interval));
 		return;
 	}
 	if (chip->poll_time > 0) {
@@ -1173,6 +1231,8 @@ static int sbs_probe(struct i2c_client *client)
 	}
 	chip->i2c_retry_count = chip->i2c_retry_count + 1;
 
+	chip->poll_interval = poll_interval;
+
 	chip->charger_broadcasts = !device_property_read_bool(&client->dev,
 					"sbs,disable-charger-broadcasts");
 
@@ -1201,12 +1261,18 @@ static int sbs_probe(struct i2c_client *client)
 		goto skip_gpio;
 	}
 
+	if (chip->poll_interval) {
+		dev_dbg(&client->dev,
+			"GPIO-based IRQ configured, polling disabled\n");
+		chip->poll_interval = 0;
+	}
+
 skip_gpio:
 	/*
 	 * Before we register, we might need to make sure we can actually talk
 	 * to the battery.
 	 */
-	if (!(force_load || chip->gpio_detect)) {
+	if (!(force_load || chip->gpio_detect || chip->poll_interval)) {
 		union power_supply_propval val;
 
 		rc = sbs_get_battery_presence_and_health(
@@ -1230,6 +1296,22 @@ static int sbs_probe(struct i2c_client *client)
 	dev_info(&client->dev,
 		"%s: battery gas gauge device registered\n", client->name);
 
+	mutex_lock(&sbs_list_lock);
+	list_add(&chip->list, &sbs_battery_devices);
+	mutex_unlock(&sbs_list_lock);
+
+	rc = devm_add_action(&client->dev, sbs_list_remove, chip);
+	if (rc) {
+		mutex_lock(&sbs_list_lock);
+		list_del(&chip->list);
+		mutex_unlock(&sbs_list_lock);
+		return rc;
+	}
+
+	if (chip->poll_interval > 0)
+		schedule_delayed_work(&chip->work,
+				      msecs_to_jiffies(chip->poll_interval));
+
 	return 0;
 }
 
-- 
2.43.0


