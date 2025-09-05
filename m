Return-Path: <linux-pm+bounces-33933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5204CB451D7
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 10:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0291C8142B
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 08:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BD1304BC8;
	Fri,  5 Sep 2025 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cyz/49VI"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807DF2FD1A4;
	Fri,  5 Sep 2025 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061752; cv=fail; b=CqkMJ45Dg8OBhIflD2xD2C6lMgriNyLt3ZY/5HyF/Ie24WLSJopvgWSq9IpCHI3W3azwYpLMoPPGk07Ofe52m69nnVW1qA72eU2zhqvEa+sB3fR894iiBObInM2R4Ltki1rqbkGz4avEIb1tRWpXXrkVDoIMysE5knxZ/laFCL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061752; c=relaxed/simple;
	bh=Dyt5y0suYIyDUsq0NUH1npcXpRh6PGIDLdvT7/GWuuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OM7IvJxJe7udqUeNsVXt8/ISFqemrZol8sO6/08EmvXNrduxHOMCoOo5YnL6kfgusJyzQrkXGvI7QE+60hBofiFkU/QoEs9CjhbJaB41lZJ9/GXh7DZKG2a/QXG0pw2TiBZ0ns150lAkXYjE4SD1D1PBKrdSQk4wM+aQ/PLaPIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cyz/49VI; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7U51RTXgilCjb3hF5w2Fcon4tlF0JOrT15hRwY26wcIUXMNxA1+8INQunEuYsRVdEAUZZwX1Vp0gx18hZDThfKvnOOitZggjg47OCtXLmqDkYJijda73PjodI7ye4osChFF5BNAi7ntjjvhoG35GZ6perlW1X3gXRofkVRlPnmRLJRN3caT1TZtvv2xtWDZIw4pGAOVQgUJGjRfqIuckZ1mW1z1QLY+jpkf4Yupgvji4SdtS44aBCkmXqh/g99caZHsIl6ZkktGAhFcYbcOWTR/9tvPyfoHaU146jgXB+Hd5LV7CkxqA51E2SmNzAmndy+9y3t6G9d+aCGWAG9RQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/oELYW9JzWQN/gA2KF8BfscCEjLAMT1CHowL87kgmI=;
 b=Nd8gFsezz7MEgu4pYqcMLCvtg10LXYGMcYFYhThVPwk+mZc9mrcLgTVRFJykP42vhlDE9+WC75rdzSvqRPqfEKYxozGvjOmcfYmIv19afaNLyTmJXoKNuoXJ2YfNQAd0ksXPU1BoOZd8x9b2fuWSWS+fVCw5ZIyDYAPpQEToHQ0E3V7P3Ir15u+iCml7u3uRFUfTmxjTno2SFd2U7Ob+f5JKtyuC46zILlaAmv/2l0gSL74oCK7sVp90N97gRaguI+O/Jng2XyztAFpyMl1n7SrExs1QvcBnailLZyQ3mDdTFd6EylXx08nBJQ95LLimPUSqpexKMgb0GzbwnctFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/oELYW9JzWQN/gA2KF8BfscCEjLAMT1CHowL87kgmI=;
 b=cyz/49VIVwD1SAtKNIsyK2vbeR32F7vGSo5t4kLz3WifX+tr+HBswJ1vnzHKzWSHT2+sgHMlqi4tyhvwj9At+ZVs4Nbz/VlM7GB+YUO8xWWdbgwIUOXWwqG0ObpI1X5CcGwETS8V5z3faHNJMnYOkVXZICkAUuljj2xoFtfhdvk=
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 08:42:26 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::ef) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Fri,
 5 Sep 2025 08:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 08:42:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 03:42:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 5 Sep
 2025 01:42:17 -0700
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 03:42:17 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Anish Kadamathikuttiyil Karthikeyan Pillai
	<anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Salih Erim <salih.erim@amd.com>, Zhang Rui
	<rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: [PATCH 6/6] thermal: versal-thermal: Support thermal management in AI Engine
Date: Fri, 5 Sep 2025 10:41:49 +0200
Message-ID: <3636099d5d0b31ebf232a5b2e741f0ff7e7e1631.1757061697.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757061697.git.michal.simek@amd.com>
References: <cover.1757061697.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7486; i=michal.simek@amd.com; h=from:subject:message-id; bh=5K+W4GHGtS5R3x94A8Z6tkUi1JHOqC0CMj/luPxKWkY=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTsWuSvlZPrfm5qad91Jfb6V+X5by4fuKQ3qT+nydLR6 8WiS1ckOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiO5Yy/A+wdTxyWdNU9m64 Ucyvh9Ob+1SiJp62/HtafeG6pnkMS9oZ/sovTnq+KdW79MfssJI7Iukbe3jtIvdsSVO2LkraLmJ tyQkA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea29b1e-19e5-4e9f-0b22-08ddec582418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9QuBfwF1+4iTdQfOFz9XwXTfsIshgKYlugllaH88JrHJtFLX0XOuqOzCNlxX?=
 =?us-ascii?Q?s8TFWAeSC2RNJ7D5+B8s3hZ0K+mDFrQcOFMmFtAjLTgwR1YYVJx3wZfaQQ58?=
 =?us-ascii?Q?gTLgqFdFMrC3E+sHpv1A1nDngpOZ94iHPXZ1SFbmFI+lekJYf03S9C6Cj7Tv?=
 =?us-ascii?Q?zoOPC7oKz8lxJPCzgqhXvx4IRWKkV5SH1YJsuV59Tfhpm9h0gOaH2Dy2ihTr?=
 =?us-ascii?Q?MiwzbwvHCWABNbU82YtZFaCXF0WkGRXQDC5Lq2HGk5hvPnYitQHX3+ShU4I+?=
 =?us-ascii?Q?jce2+9aSKDQSNwQqcXpQw3UG/twRe07kvhgi7KfuTncykKY3zJPOb/vS4roA?=
 =?us-ascii?Q?1XBZ0JsQXXhH8wRpL5Vwrika2UJe8ljTp6Kb69+1/eDEZhd+SqcUdrprVfkZ?=
 =?us-ascii?Q?gjnUPI0jgFNhHHJyKpOVKSqki33ub8eNB+sU+hcNiL9DY7IrG5DcHLbw4aRB?=
 =?us-ascii?Q?mdmVktqjlVoW+o4gJBAj/5yTF0ZfVWmsHtpPt2eDdcYDbecZGXPKpwOpnXNA?=
 =?us-ascii?Q?3NUj5obFBKM+5puINg0HGxtc33nttjrMmg68kja3wWkdeu2xzNi6zW4ukc2U?=
 =?us-ascii?Q?U5Gct4OHkBfzKOloR/UFJkwf0zLrak03b4USf+tjbpa8PejD05lsPfAkv/wh?=
 =?us-ascii?Q?MGpVPa/qFiFJvLd8HyMJdZqWeL3MeaT7apNVCgQiG4VVtMDXqXGWVUseh3Y0?=
 =?us-ascii?Q?MGiwtPrKFDhtyxhPxXgNtC72o6tBesn40HT63ZD8ziRpQfu3KTUjamzSCeuk?=
 =?us-ascii?Q?wdF5ippUk8RaA+NQAZFsLiZsq+ANrJPVPkrzcORgMMtFHJUxfSpFbkNXQizU?=
 =?us-ascii?Q?zyxUslv+WIuCgCGXwC8StQRMygzIa4TcpHw9c9byaoVmDGON5UJ8SCHE+dJU?=
 =?us-ascii?Q?+jpG6ujhHoeY1QnDKwY+usGCrgn0mWFLEGsUws/eltwXw0J03aoWMB5HFjrY?=
 =?us-ascii?Q?UwLeoHWUe7loH3Id5JXXPwxr7DJbwfYio316kWwYmtAM6mt3aH1zZqczaf9J?=
 =?us-ascii?Q?2aZFhWjC9q3jT93LNoVeORK/SDFWCeNSKwY8ptA26kVyBKUCF6KXW2V+DkYB?=
 =?us-ascii?Q?ZmcpO7XaQ5bEgYlur+5hXvU0MDSVaoGML3ZYSHD2WJ8w087x6WHKvGPy9LeP?=
 =?us-ascii?Q?fK89V/xZomKpCsT2FEX4wbBOvo9wkPTrT9wTLq/3zHwRrcgzAISFrTLspJSK?=
 =?us-ascii?Q?2tYitqMZ/lOIJ+y1+M84ptndL5+Pq2PS0cigOqt8YNIhO7pWKlTiW7To5BQN?=
 =?us-ascii?Q?qEPNBB3S5kVROqvIWC7PR1llANICcSAO1e9vnEsvDQlbIZnVhDNpMDBznpX1?=
 =?us-ascii?Q?0B20WeievSjsF43BPmxIfvCcIOcKA7MQ1NT3ODvM6j6iII/oi0gwey+SBAhh?=
 =?us-ascii?Q?MargxClmY8iwOrYve8JxvgxOEibK3JxmkkeP0buPF4HSeByCYh9XpbSRzwWe?=
 =?us-ascii?Q?sVf9FDFXWNu7ikGc+DrI+oLPJMznhy5V5az59g2y8SlTYFBVxIjgMfTJcYVb?=
 =?us-ascii?Q?tAUYjIzd1XcS+LIqv2cbnQ2IU7NuR8+E6LZy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 08:42:26.1963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea29b1e-19e5-4e9f-0b22-08ddec582418
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341

From: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>

For AI Engine thermal monitoring, through the thermal framework,
a new temperature zone is added. The temperature of versal sysmon
satellites near to AI Engine is read from the mapped IIO channels.
The maximum value of temperature from versal sysmon satellites
near AI Engine will be reported.

In versal thermal driver iio channel names are read from versal
sysmon temp child node. The reason is we cannot specify the
iio-channel-names in versal thermal sensor node, as it can change from
board to board and versal_thermal node which is not related
to any hardware.

Passing NULL is not be supported by devm_ API for getting IIO
channel names. So we moved from this approach to iio_channel_get approach.

Signed-off-by: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/thermal/versal_thermal.c | 146 +++++++++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/versal_thermal.c b/drivers/thermal/versal_thermal.c
index 51c8586af5a4..e2e201c5c955 100644
--- a/drivers/thermal/versal_thermal.c
+++ b/drivers/thermal/versal_thermal.c
@@ -13,11 +13,17 @@
 
 #define SYSMON_TEMP_CH_NAME "sysmon-temp-channel"
 #define SYSMON_FRACTIONAL_DENOM		128
+#define SYSMON_STATIC_IIO_CH_COUNT	1
+#define SYSMON_AIE_TEMP_CH		200
+#define TEMP_MAX			160
 
 struct versal_thermal_info {
 	struct device *dev;
 	struct thermal_zone_device *tzd;
+	struct thermal_zone_device *tzd_aie;
 	struct iio_channel *channel;
+	struct iio_channel **channel_aie;
+	u32 num_aie_channels;
 };
 
 static int temperature_sensor_get_temp(struct thermal_zone_device *tz, int *temp)
@@ -39,31 +45,158 @@ static int temperature_sensor_get_temp(struct thermal_zone_device *tz, int *temp
 	return 0;
 }
 
+static int temperature_sensor_get_temp_aie(struct thermal_zone_device *tz,
+					   int *temp)
+{
+	struct versal_thermal_info *vti = thermal_zone_device_priv(tz);
+	int ret, val;
+	int max_temp = INT_MIN;
+	u32 aie_ch_index;
+
+	for (aie_ch_index = 0; aie_ch_index < vti->num_aie_channels;
+		 aie_ch_index++) {
+		ret = iio_read_channel_processed(vti->channel_aie[aie_ch_index], &val);
+		if (ret == IIO_VAL_FRACTIONAL) {
+			/* Convert raw value to temperature in millidegrees Celsius */
+			*temp = val * 1000;
+			*temp /= SYSMON_FRACTIONAL_DENOM;
+		} else if (ret == IIO_VAL_INT) {
+			*temp = val;
+		} else {
+			dev_err(vti->dev, "iio_read_channel_processed failed aie ch%d, ret = %d\n",
+				aie_ch_index, ret);
+			return ret;
+		}
+		if (*temp > max_temp)
+			max_temp = *temp;
+	}
+	*temp = max_temp;
+	return 0;
+}
+
 static const struct thermal_zone_device_ops thermal_zone_ops = {
 	.get_temp = temperature_sensor_get_temp,
 };
 
+static const struct thermal_zone_device_ops thermal_zone_ops_aie = {
+	.get_temp = temperature_sensor_get_temp_aie,
+};
+
+static void versal_thermal_iio_chan_release(struct versal_thermal_info *vti)
+{
+	int aie_ch_index;
+
+	if (!IS_ERR_OR_NULL(vti->channel))
+		iio_channel_release(vti->channel);
+	for (aie_ch_index = 0; aie_ch_index < vti->num_aie_channels; aie_ch_index++)
+		if (!IS_ERR_OR_NULL(vti->channel_aie[aie_ch_index]))
+			iio_channel_release(vti->channel_aie[aie_ch_index]);
+}
+
 static int versal_thermal_probe(struct platform_device *pdev)
 {
 	struct versal_thermal_info *vti;
+	struct device_node *sysmon_node;
+	struct device_node *child_node = NULL;
+	int aie_ch_index = 0;
+	int ret = 0;
+	u32 num_aie_channels = 0;
+	const char **aie_temp_chan_names;
+	const char *aie_temp_chan_name;
 
 	vti = devm_kzalloc(&pdev->dev, sizeof(struct versal_thermal_info), GFP_KERNEL);
 	if (!vti)
 		return -ENOMEM;
 
-	vti->channel = devm_iio_channel_get(&pdev->dev, SYSMON_TEMP_CH_NAME);
-	if (IS_ERR(vti->channel))
-		return dev_err_probe(&pdev->dev, PTR_ERR(vti->channel),
-				     "IIO channel not found\n");
-
 	vti->dev = &pdev->dev;
 
+	vti->channel = iio_channel_get(NULL, SYSMON_TEMP_CH_NAME);
+	if (IS_ERR(vti->channel)) {
+		vti->num_aie_channels = 0;
+		versal_thermal_iio_chan_release(vti);
+		return dev_err_probe(&pdev->dev, PTR_ERR(vti->channel),
+							"IIO channel %s not found\n",
+							SYSMON_TEMP_CH_NAME);
+	}
+
 	vti->tzd = devm_thermal_of_zone_register(&pdev->dev, 0, vti, &thermal_zone_ops);
 	if (IS_ERR(vti->tzd))
 		return dev_err_probe(&pdev->dev, PTR_ERR(vti->tzd),
 				     "Thermal zone sensor register failed\n");
 
-	return devm_thermal_add_hwmon_sysfs(&pdev->dev, vti->tzd);
+	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, vti->tzd);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to add hwmon sysfs for sysmon temp\n");
+
+	sysmon_node = of_find_node_by_name(NULL, "sysmon");
+	if (sysmon_node) {
+		ret = of_property_read_u32(sysmon_node, "xlnx,numaiechannels",
+					   &num_aie_channels);
+		if (ret < 0)
+			num_aie_channels = 0;
+	}
+
+	if (num_aie_channels > 0) {
+		aie_temp_chan_names = devm_kcalloc(&pdev->dev, num_aie_channels,
+						   sizeof(*aie_temp_chan_names),
+						   GFP_KERNEL);
+		if (!aie_temp_chan_names)
+			return -ENOMEM;
+
+		for_each_child_of_node(sysmon_node, child_node) {
+			if (of_property_present(child_node, "xlnx,aie-temp")) {
+				ret = of_property_read_string(child_node, "xlnx,name",
+							      &aie_temp_chan_name);
+				if (ret < 0) {
+					of_node_put(child_node);
+					return ret;
+				}
+				aie_temp_chan_names[aie_ch_index] = aie_temp_chan_name;
+				aie_ch_index++;
+			}
+		}
+
+		/* Allocate memory for the dynamic aie temperature channels */
+		vti->channel_aie = devm_kcalloc(&pdev->dev, num_aie_channels,
+						sizeof(*vti->channel_aie), GFP_KERNEL);
+		if (!vti->channel_aie)
+			return -ENOMEM;
+
+		for (aie_ch_index = 0; aie_ch_index < num_aie_channels; aie_ch_index++) {
+			vti->channel_aie[aie_ch_index] =
+			    iio_channel_get(NULL, aie_temp_chan_names[aie_ch_index]);
+			if (IS_ERR(vti->channel_aie[aie_ch_index])) {
+				vti->num_aie_channels = aie_ch_index + 1;
+				versal_thermal_iio_chan_release(vti);
+				return dev_err_probe(&pdev->dev,
+						     PTR_ERR(vti->channel_aie[aie_ch_index]),
+						     "IIO AIE TEMP channel %s not found\n",
+						     aie_temp_chan_names[aie_ch_index]);
+			}
+		}
+
+		vti->tzd_aie = devm_thermal_of_zone_register(&pdev->dev, 1, vti,
+							     &thermal_zone_ops_aie);
+		if (IS_ERR(vti->tzd_aie))
+			return dev_err_probe(&pdev->dev, PTR_ERR(vti->tzd_aie),
+					      "Failed to register thermal zone aie temp\n");
+
+		ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, vti->tzd_aie);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to add hwmon sysfs for aie temp\n");
+	}
+	vti->num_aie_channels = num_aie_channels;
+	platform_set_drvdata(pdev, vti);
+	return 0;
+}
+
+static void versal_thermal_remove(struct platform_device *pdev)
+{
+	struct versal_thermal_info *vti = platform_get_drvdata(pdev);
+
+	versal_thermal_iio_chan_release(vti);
 }
 
 static const struct of_device_id versal_thermal_of_match[] = {
@@ -78,6 +211,7 @@ static struct platform_driver versal_thermal_driver = {
 		.of_match_table = versal_thermal_of_match,
 	},
 	.probe = versal_thermal_probe,
+	.remove = versal_thermal_remove,
 };
 
 module_platform_driver(versal_thermal_driver);
-- 
2.43.0


