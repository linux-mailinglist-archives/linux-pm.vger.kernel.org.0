Return-Path: <linux-pm+bounces-22996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71090A460CE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 14:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651D317A964
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 13:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571CF21B9D2;
	Wed, 26 Feb 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jBO6zEaO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2075.outbound.protection.outlook.com [40.92.45.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955D721C19F;
	Wed, 26 Feb 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576267; cv=fail; b=AZfvBpIlQyda6x7lcpKAw1i6cGpisoQEJEMVMCFUhXk+GVyqy3pkHwXERoSYty+wrBRcL6dD69G4fPDAtOttIy7Z59R6YS2DagGqGmjqpnFwqGK4VI3BYZtWv7R1KN/PPTuBu0vvC/+ZwnExcvxR9ugZ3vVdS3Sr4JY0+DeN7BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576267; c=relaxed/simple;
	bh=JLlkyr8YMybIl1airxA+MaXg8S/9gBIYuqY22ik2T7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aq4YidOSPZmqwSSel9k/wDLLH+E61rSzLk/L7CK9UUI63t3Lvb4DwGi5ylagb/jq7+IyA346gt2zQp8cVdWGG1M+uh8CQ51E0a7X462xA0bDvl8ahP2NN0ZGHXV9F7+QulHvAzwbQjZ7SDmq15ys5icY8GSqIEZozI/z9MQ/Z9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jBO6zEaO; arc=fail smtp.client-ip=40.92.45.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCn13S0EZzuFsYB4PDwI1qQ+2K0DrSsPojYsp3YD5Ej2TbCm+rcyTWUw2kZde9jJRSK843U4/8uC8XJ+2gDT/JxUammtEmhqNRmd2sHbHJS4N7v68kOpcaHuREjCRgvuwj+RFWUSo4MHLff4x7qDuziEwlfh4ZPZF/BNmQ27R8DPnGpW/Zs0LYHs3FA3PulqRrD/dBt0kKkxaNpSglRhHFcv8fFAjV0qx5fE78TDXsk5/3vbBFvtgwyYUpoSdkmNT2MsCHH/Uph67RfOWWe6208nXwlBDKz44bO1VHf+fpGB0kIg245sGPmopc9Rv99V3qdn7b+b1jvhJ0RJEPebqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KWQpO3fa52H2819mZJGjf/qv77PH04I1Isg14IjEdA=;
 b=A8qqoIm0wY6vylx4V5f+p62dUp41ONEBUaiN3qZcQW5ZDAQkXvUN1UEiGbOcDNVK3UVzQCPdRsEoBOp5q29tFCkn1SjJVxVf5kqpz0xgCfZ7edEcMVGs5uhzk1M0WfwCLx7OvaSJxVkbBIX0KydrnzyPF3WEq1iu37OOMt6hzp1LQdualYrdQZD3oak8HoXA7GTrFRSyZp8aWBqhavolNqONYhql/EtJr7c/pzVuoNWuDhLpL8HNkb82ZNCJN5oTXyjZGDj/kaIiiPRvDQfmgIAV8vsx7z1pmCp9ZZy1WEJlk0u/Zaqce7+xekkQb6Gwzv/cjNNAuEKCdZoX6CpZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KWQpO3fa52H2819mZJGjf/qv77PH04I1Isg14IjEdA=;
 b=jBO6zEaOn1O+saze6pG+8h69qRzQJ7EbbhSMOE5N6ZoZH02wUrdEXbpKqa9VovO6GUXIy6YU37KM7ygFv+laG/b6u1Di1aYWXeeTiQq29F9+aJqA7Q6jhTh9RrPK7/4oiWzpDZb3yFt8r3V1dhp2XCWWAMwPB43HDl7XDPp3Ww5emb03WkPAl3D0lNpEpYXbG35xRJXiBRsXVUGiK2K/KqN1j4PfwapHLw1MhDq5l2qhAvdoHANBQwHYVhzGEJmDPGYnpzoXu2us9+N1YSlBvaZmu7fCzMcpKc7Od5jwi8stHA0Du2KBvaaZGBUo+AG62+Vqzt936qgaEnsm9LE/Dw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DM8PR19MB5270.namprd19.prod.outlook.com (2603:10b6:8:4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Wed, 26 Feb 2025 13:24:24 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 13:24:23 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	dmitry.baryshkov@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	quic_srichara@quicinc.com
Cc: George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v7 3/5] thermal: qcom: tsens: add support for tsens v1 without RPM
Date: Wed, 26 Feb 2025 17:23:54 +0400
Message-ID:
 <DS7PR19MB88837B6C3B75860BA27BE4459DC22@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226132356.9398-1-george.moussalem@outlook.com>
References: <20250226132356.9398-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0016.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5b::6) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250226132356.9398-5-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DM8PR19MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d989fc-d66f-4b63-db73-08dd5668e1e8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|19110799003|7092599003|15080799006|3412199025|440099028|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9pZ8O3TW1LShCE+Gl0bNtCPRp57zZsf1msAIOxLjHggtgSfbbPVRgoKnPqx2?=
 =?us-ascii?Q?xVstnMQdSwwz2yCykXRO4q2r6s+yfqbAf8xlBwSrkuzeGX9LXacnDbCBsvo9?=
 =?us-ascii?Q?6leDmlKslIy38apit3xP7vonc9uu4rXKNq9m/GDdG8SJMyqDij4RZdoZq76k?=
 =?us-ascii?Q?oyff8ueyFw545GIJ5lNiAdTHW/3NvRJq8yIg50gN0CRd4tQaidLzlZZOlgMi?=
 =?us-ascii?Q?8MaZO5Uz9qX6zRRj26dPAqEhsV8P7pKunT7kk6UC+xpXiCwhfuVPsWYiNEKM?=
 =?us-ascii?Q?li0GI+x7awJhLPIWtXcjN448zhAvryqtTWa5iZdYLwzDtg6f+9BRwx4Oh+09?=
 =?us-ascii?Q?D9ZmeDv313LaiJhqCJhZUPz6Dkw3uhVXggvM5aYzxG9Ny0qi1uKbbdOA+TeA?=
 =?us-ascii?Q?UPpGltGUTCnCHSIIomxDXz4Mm/cgwDsheif93IxuTJsWvjbMnLaMmj8aV0LI?=
 =?us-ascii?Q?kOXHIzDcfYJPjKscBPjMYoPacRsnFFXyESVOEMGNOLAx2cQhj+jYnkRTYbHG?=
 =?us-ascii?Q?A6iDiXKD/VMRPok0+FEvdU7oINviKbb+EfD/rMksNuD/3DG/MO1vu/pp5ujm?=
 =?us-ascii?Q?oqd4l6ooCeuL09oK+B/3+hD9Z8qPWR6TF81dIJlr59IHRL2uGWLbXwshIjex?=
 =?us-ascii?Q?tcevQ21NBLwHygl4sQdzsxVRSdOkN1oceP6ttSZ2CSq88iYVTSRa2N2k2i9a?=
 =?us-ascii?Q?oN7xgUC5MW7N+j7ZM2xZ1P7kx5PTXxPgh/8xX3Qx7b3cABH9vaJ9DF9KHKCK?=
 =?us-ascii?Q?HCMArHwNwa2EqQwIl3Bjvof0bwN0K7xyphssfhsg4bwyFMrlwu2nMdWo67sg?=
 =?us-ascii?Q?1sa5QgUwLk2qZWzgB/HKL29xr2QmZMvKxaSt+tXLCp9k7mK6qmhEopu/kp/B?=
 =?us-ascii?Q?69zV/zGJnyGPBW7Y85mABYk2wjv4NTKGQCvPfXD0WNYsqodQHrLHsG/fj0Jr?=
 =?us-ascii?Q?qMJ2ePk9h+v0Wos2sjSAbWLalhHivwOuUxaRh0lcPsBxMAxVxtbykeyWarDr?=
 =?us-ascii?Q?l0TG4Z0lzSy3WTOp1FAZ3Gndq2DEA8vXv2HM1z+BGJy6TR1alMVCfIcLtSTQ?=
 =?us-ascii?Q?6sv4OzQJH72BWxpnkeENzyzgC2yxYZ0OxYEjTEAIrFTc5eN9QrOTiF0m/Rub?=
 =?us-ascii?Q?gUskGWXpk+WS/lXwQXOY6W8DEh2rQL+bCg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gfds7MVmyi7YVbf0Nt97Z20AkXsXg8IpLDODYp0ehJn1KACpNczi2yeWyNOe?=
 =?us-ascii?Q?U4K/SfITfA84ZE6ll61EdPKO6eQ2e8BianMCm2+ap7elQwJ1/MrNyf1IukJu?=
 =?us-ascii?Q?U22PzjkzeFGJff2E36NxCGhlHOVCAk5L9MFPzUZum9PQAGuJv+BBVnzXVEZO?=
 =?us-ascii?Q?7nQMvmkmP9Mrl3aOgJpGfErVuk/Iqz3gnZYnnlImPdonpTWTG106jBNMyDOa?=
 =?us-ascii?Q?ckKeEW6lE5uovulir+7oFf7vjTEXbwobfSIvf4w43ihSJzsKhnkcvE0CQhxh?=
 =?us-ascii?Q?kD2ZokV2ubDoTfm3SWeOiSdglU/HcTh9hpDDRJngrOF+wVuf0gIKGz5iko4v?=
 =?us-ascii?Q?NL2XHbE43eCznW8yAoXPJXdbt5/l9+o+3kKKHPlG3bSWA1VWvcSNJMwopqhn?=
 =?us-ascii?Q?7Zm8NL1GGOPbi5UprJpXnOcGwVv70cU97LfNKZrUa/tGrywemN8YcA0tEmZG?=
 =?us-ascii?Q?plf8DnV3DOY+qEBuMZLptXAoaXm7eAIJM/aoKA9zKQEdnaAPH7R/0/KDUzjM?=
 =?us-ascii?Q?fb/sxy1Xp6fimKAC4xA4Gq+cpiDdoD1RBpZ6JgBK0SrMK64cW8BcH9hxs1JO?=
 =?us-ascii?Q?MWzV4mXlsaTUL/1TucepPB3mJH3GAGZzIyEIBYIYX00ohIZ6HL4XVtQB+z/s?=
 =?us-ascii?Q?J9f/JbLr6QPXAuwK6z4f6E/hltX8GNx0KI8E2Vav4tU9Zq5/Bclo+N8bwa8i?=
 =?us-ascii?Q?pIhucYzWiIX2QxSDUy89l+MVmHDlPG4Li1134n+zBzJMgJnMCDay7ewU9pmM?=
 =?us-ascii?Q?9jeul1utGE3eVXyogJNlRWDkZlrgTeLLosAg5CeE9SKN6HPU2dJe6730q/t5?=
 =?us-ascii?Q?H2l+NOqttsAyNBiUXa1vHzkGlEnCM9Jl8m1nBxu/5MDCmHIMzbHLh8sKI+y1?=
 =?us-ascii?Q?fSvP7Rog/RF9huqsOkJWWmrEG1iXkEH89P8ljVm9SKYe5Ubtocl+DBJejzzC?=
 =?us-ascii?Q?YPDUC1Pg8ORqZr2TmByf5SUPWQ9jp0cXTHRz7CAttgMpOqfcPs6qar4xEc1G?=
 =?us-ascii?Q?n+LYkR4SBn49N7zx/ut3jJC9Bs0sp61F36OpJb1jYHp5aioQiLa92Qnc4SHC?=
 =?us-ascii?Q?x0ZdckD+uu52hKx9l0lA3eGhsJz0pVtD5rRW8TZT5STb4LwZUSVtt9qUyZct?=
 =?us-ascii?Q?hqFLxhgf/9cumN5NZo2UxUE0xbI8hPJRdDbxUM6Sw1LLxV4q08+ta/bFNLhF?=
 =?us-ascii?Q?JUYZguW9oM5Bqi96l5LTPIE5w4VWBRs5ZokybRx1ml5sf/j2LfHnlczbOkdX?=
 =?us-ascii?Q?IU8duFXB3n4ve54p/cNR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d989fc-d66f-4b63-db73-08dd5668e1e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 13:24:22.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR19MB5270

Adding generic support for SoCs with tsens v1.0 IP with no RPM.
Due to missing RPM, tsens has to be reset and enabled in the driver init.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/thermal/qcom/tsens-v1.c | 48 +++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c    | 16 +++++++----
 drivers/thermal/qcom/tsens.h    |  1 +
 3 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 1a7874676f68..877b27274fd2 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -79,6 +79,17 @@ static struct tsens_features tsens_v1_feat = {
 	.trip_max_temp	= 120000,
 };
 
+static struct tsens_features tsens_v1_no_rpm_feat = {
+	.ver_major	= VER_1_X_NO_RPM,
+	.crit_int	= 0,
+	.combo_int	= 0,
+	.adc		= 1,
+	.srot_split	= 1,
+	.max_sensors	= 11,
+	.trip_min_temp	= -40000,
+	.trip_max_temp	= 120000,
+};
+
 static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* VERSION */
@@ -150,6 +161,43 @@ static int __init init_8956(struct tsens_priv *priv) {
 	return init_common(priv);
 }
 
+static int __init init_tsens_v1_no_rpm(struct tsens_priv *priv)
+{
+	int i, ret;
+	u32 mask = 0;
+
+	ret = init_common(priv);
+	if (ret < 0) {
+		dev_err(priv->dev, "Init common failed %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_field_write(priv->rf[TSENS_SW_RST], 1);
+	if (ret) {
+		dev_err(priv->dev, "Reset failed\n");
+		return ret;
+	}
+
+	for (i = 0; i < priv->num_sensors; i++)
+		mask |= BIT(priv->sensor[i].hw_id);
+
+	ret = regmap_field_update_bits(priv->rf[SENSOR_EN], mask, mask);
+	if (ret) {
+		dev_err(priv->dev, "Sensor Enable failed\n");
+		return ret;
+	}
+
+	ret = regmap_field_write(priv->rf[TSENS_EN], 1);
+	if (ret) {
+		dev_err(priv->dev, "Enable failed\n");
+		return ret;
+	}
+
+	ret = regmap_field_write(priv->rf[TSENS_SW_RST], 0);
+
+	return ret;
+}
+
 static const struct tsens_ops ops_generic_v1 = {
 	.init		= init_common,
 	.calibrate	= calibrate_v1,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 1f5d4de017d9..4a0d35020b00 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -499,7 +499,7 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 	ret = regmap_field_read(priv->rf[LOW_INT_CLEAR_0 + hw_id], &d->low_irq_clear);
 	if (ret)
 		return ret;
-	if (tsens_version(priv) > VER_1_X) {
+	if (tsens_version(priv) > VER_1_X_NO_RPM) {
 		ret = regmap_field_read(priv->rf[UP_INT_MASK_0 + hw_id], &d->up_irq_mask);
 		if (ret)
 			return ret;
@@ -975,10 +975,16 @@ int __init init_common(struct tsens_priv *priv)
 	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
 	if (ret)
 		goto err_put_device;
-	if (!enabled && (tsens_version(priv) != VER_2_X_NO_RPM)) {
-		dev_err(dev, "%s: device not enabled\n", __func__);
-		ret = -ENODEV;
-		goto err_put_device;
+	if (!enabled) {
+		switch (tsens_version(priv)) {
+		case VER_1_X_NO_RPM:
+		case VER_2_X_NO_RPM:
+			break;
+		default:
+			dev_err(dev, "%s: device not enabled\n", __func__);
+			ret = -ENODEV;
+			goto err_put_device;
+		}
 	}
 
 	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 336bc868fd7c..e3cb611426c4 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -34,6 +34,7 @@ enum tsens_ver {
 	VER_0 = 0,
 	VER_0_1,
 	VER_1_X,
+	VER_1_X_NO_RPM,
 	VER_2_X,
 	VER_2_X_NO_RPM,
 };
-- 
2.39.5


