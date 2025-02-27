Return-Path: <linux-pm+bounces-23055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B682A47B4F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28CC77A4ECA
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA0122B8A9;
	Thu, 27 Feb 2025 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PYG8ESjn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2068.outbound.protection.outlook.com [40.92.41.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A034A21CFE8;
	Thu, 27 Feb 2025 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654318; cv=fail; b=aKefYPcs9OYo86JlWiKmTxBjO00ZStPImOKYgZBGpzW5Kf0WsywNtKTIo0J1SPYREWntCYuxEFumdUljhAnkVhXJpUKaRT/d4a3yge+BTa5O84JEydpBXAaNk9cOTvnQIHbKDHnWxeC9UZqm8ayVJL6iL4bLz45NnG2/4o4FzIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654318; c=relaxed/simple;
	bh=ApSVB1XH85jFW6RWahY0OhroFUXSSPVsE72zhSo2f34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bCfE4cyYRwmKXzFRZYsC4pe1l8QsgGwJ+Dke4BbZpDLIJzd7RiIRBC3+pjF0+2Z5Xd0sd/lljKtbUK16xSqeyrRPZz8A59L+nrqsY21VjB6YNEesu32EkJtCMmiDXsoJAkZj07jlB04BhCi26wlbSJI6qCXc8XHRvEEa0R1+W98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PYG8ESjn; arc=fail smtp.client-ip=40.92.41.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmzUTbguqt94OzfuvQBA0euABbhtdtYA+W1eaCpWELEppVROQWl3NZVyKM6f3kZsper/W8xjQrlEpNFVwnBnYYyUjfFUQeuPHQsT56FX99lS0C8DGce3Vn7crFMVsCqf/Fy6QakDGmq/UQazqmgre1KS8vpqz6dZjAtoeO2MYkLJ5vJVXcQNzmK/6rYkAiMJVKhvbJlDxcoUf/Z1PokPZvLGGRlziz1iE+wfApKaRq9iT0ShJl9dLZcn7MBdTgMxBmDJDUzXsXD5ET0cj/FoqEtjXQlqsg+p6BlkTpj9JB9ww4Lb7gkJnB6eoRdsmQft7AzRNQ5Sogjq745H5kQ9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMIec1KYE5b4XE4aEnEe1QQq6ZFjK3XdogDrQqEGnEg=;
 b=Y2S9yUQ5lIWIPfBA7Rbj12VDhC9SkvPabjaFUJ+qHSz5NAEDd8F1IJEnsa/JBC46zY6fsn1ckptUFIKmJfFFchGy6PmL8JDleIosNnPTjoON67lREeuH1wsZhriNkiRgGKU13v/VtANuAij0VRyqIx6DcpI37XyppOLT1pvtfluxsaUy4KAsGPHGx8ONkm3ZpIvFcsVmDW9WdJFfuobFtd2fmN+C8L2eTCH2koxianbQN5OD31oPUapz7M4Kx3m7irzw8vXYeoL2UrS/hCIDgi2S+WhU+YoJDhUbGUUtxPyrP41ZXW7Z9nFR4/B82jB0bxPkLisRPqJYoPbufBxo6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMIec1KYE5b4XE4aEnEe1QQq6ZFjK3XdogDrQqEGnEg=;
 b=PYG8ESjndUPlETAHGRQbtXDmsn7SbKDT8gehbg+gEI1s0TsnwPoVkv89N9ZSViAbllfXwaCe1EGYArQvIT3oYGCNsmXWHChwkXgo5U6NDiCpuOODegM6M+34TqBozRWGWNyKR+I3nJVgUFY264yGUMCj2nptgqrBA8sv5HFP5tOCgwJegIi057HYycUo4rmvjE0w0DA4Lhx9AFQsavs1SwTmJOXXnUhMmNtI0XSx5iFcmMxk7xeTgT9DXYIPw3owIJejGM9IcIMedrA0ENQp/OBNXirDyTLGooziJUK7pq5gQsRAjsY/ld4NRkJy3JShM8JFkrimj0+Hr6kuPN1qAA==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SN7PR19MB7333.namprd19.prod.outlook.com (2603:10b6:806:348::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 11:05:12 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Thu, 27 Feb 2025
 11:05:12 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	dmitry.baryshkov@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	quic_srichara@quicinc.com
Cc: George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v8 3/5] thermal: qcom: tsens: add support for tsens v1 without RPM
Date: Thu, 27 Feb 2025 14:56:41 +0400
Message-ID:
 <DS7PR19MB888322C58FC555299256E8D99DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227110423.8418-1-george.moussalem@outlook.com>
References: <20250227110423.8418-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0056.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::18) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250227110423.8418-5-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SN7PR19MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbd651e-2fc5-4962-0ff5-08dd571e9b3c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|15080799006|461199028|7092599003|3412199025|440099028|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?haqttWZVBla/g1cPL/YB/MDD8xwFXr+24MW+BGh/O2f2h4swxa2bW2Y0zrsW?=
 =?us-ascii?Q?HbQyGPgwN6BJTLWjfDIVA+wkPU92wFgn5wasHF/btkRzjXGwzaEXfqZBPrt5?=
 =?us-ascii?Q?noGLNqupjWS6gTVrlx4707bQEAc1mo2AtqVXMzJWB5zS6PyY8g0rtDy+V4/e?=
 =?us-ascii?Q?QPbh0vdZQ9+7pY0jMSwSBjw/PDgrvxMn8UUCNed8TLLE+8K75J2Uoi8rj2Xv?=
 =?us-ascii?Q?M2EhMvXR/K/6FT6d/bU3OEGs5zDM3xZ2VTPMsGljmERBOyLxqH1zVw3yrZG8?=
 =?us-ascii?Q?mgBDx2YrWPa0Ln3ysycqr5/s+ZcwIUq1QU8saL+lPxHPPaHXwDLqq6i5twb8?=
 =?us-ascii?Q?FCtPti/LOdbLz+2U7wKpq3rRoTP0PEFhUnBkNOs3vKduGkhVLeG0Z/tmC16A?=
 =?us-ascii?Q?oEbSXWCIMIMPnM3VfsfIoD179LsNHIwaGv1xodvUFslXeEZXWGcnMuOU/rFl?=
 =?us-ascii?Q?pPyFgyZsyvuiR6txH0n7Ohej1MCjmw/azuWU+nkRQpEvlW+0Oy9QADQx+GGO?=
 =?us-ascii?Q?qFHkPtyNSatNztjbBxlphYbLJ8cVw9bzHKBMzZCJIdXK2umKslFHhwcQeWDH?=
 =?us-ascii?Q?cRXjAXvHYwmQCRz4eM/MUL2erpX+rTC7lKKaJ8L+mYQ+voLl21LZ+lP0+cDA?=
 =?us-ascii?Q?Dp07MD6LmrMXY69OuiWJ17Sz775WMp/F4hw2vLXnux6xtuTGuvAUWeddu7UN?=
 =?us-ascii?Q?pvRb89ERjlti5DRhgvEki5jpzT38V9RDdv5qoBXgKjSP+2bPsE6hbJdOstoE?=
 =?us-ascii?Q?unD6fVC90y94s/vAwQ+1qb/jR2Iyv1unWMK7n87SXJ8/SK5objbU3PLbB/7X?=
 =?us-ascii?Q?ML7QeQj1FBnj9Usp5n+SWh3UoCuqAWPVnx0zUsNI33LoVra3DxS/mHH2NPPA?=
 =?us-ascii?Q?YyhjHmPdGLpTfvxGMbJ08p/TX9LMGVMLM2+qaUhKxSFeU7yYFzqzI3GGH0z5?=
 =?us-ascii?Q?3w7ez+zTHaOihKMY2pXNpY4EiAR6cf/6bC91mIyCyyolUz5I7xHiQaAPTyQs?=
 =?us-ascii?Q?+DhDWznDpRalDwO91f6KC83LuN/B4F862KLOggAM/uPDkiqM6UsX2ZerMXfm?=
 =?us-ascii?Q?ESDL7B1f1qN1A9d/apY5PQ01DpphfYhsMW+s6F9Z1u8s8LV5FWftepYf7pig?=
 =?us-ascii?Q?WOcq+VeUo42s?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qMfvgqexra4zh4UNowXOoR8gljASgzjHrIkM4++DLmlNjdjiYjKDzl0uxT7+?=
 =?us-ascii?Q?eNWeOBvVWIR4j9uBvkDFht+JS0lNQ5W1A/FWKK0zLqvOCjEhrRSKDlwKabDV?=
 =?us-ascii?Q?EsR7k6Vx1nalDupVLHfSLyj3/jGJTYVoRdQ1GfipJkJeiCyyV/jNt+8/BX7S?=
 =?us-ascii?Q?Wf7y/mSfPs8QjKl5dpd1St8hs1BAbn5V3vozbgNt/FsFogZxBLoxBgmKJfmU?=
 =?us-ascii?Q?ZwfbKHK38p/4MKU++dC06smbkketiSfcUzu5Dj8Dzwtbjq8mfWbaii/m2C4T?=
 =?us-ascii?Q?3ptXkbrO6juKyb812HKw9b9kIl84WSdlWVzaxHbOrkCgk5Tt7fXEndtag3V8?=
 =?us-ascii?Q?ntwL6fuxP9WT8+/B1vUaXLsWDEBdlJYUP70bzrhLAdlwXA6IkmlbbBt3tZ6/?=
 =?us-ascii?Q?pulnv92q+aPrevElXA25YPruNV8we5jne0TInKU1t9gaWDfwnXTlV4KexZku?=
 =?us-ascii?Q?2TTKBNan3ImeA0ayhVxm1R28eqmYL+gsfhPtO4V1KNk3SdfUp+s5x1aMoist?=
 =?us-ascii?Q?jteoXm9riwo63jj1KEuE57KtOvJ6ylTszCBysBM4ZNC+6CxCRxiTCeISudCG?=
 =?us-ascii?Q?fX7WTVPAa4wstIJ4yxF/H/f8lN+fgWwFIMW+2xvM6jG5CA8j/T2s/Thi4dqP?=
 =?us-ascii?Q?nvboLw1ZrCEiTgV7n5H/7qX3kMc+y8BErg8U/f83HNXUL7Zw5HHjZt2eWhuA?=
 =?us-ascii?Q?Hc6qDfE2hY+m6ihE6vvMEkyo2pTQmR2BT/baYq/Up5OTtX5HNwUvafPmc956?=
 =?us-ascii?Q?u6BNURp1qgifiX3mog00l4RjEhM0gpFZDeCqedaZS+N95S1HISHTCInblsUa?=
 =?us-ascii?Q?Jlg+gYNQDV2qxUdUk7nGA0ws/fEsjmB9ZYcXzYC3pgxEJxvtmUw4EjiXegTM?=
 =?us-ascii?Q?viHto20o5DCcP/KyAGz7OAuma8HjoyFlzu/3gRKZ6K27axe5bCspL8fieR7b?=
 =?us-ascii?Q?O13WNU55DijirQ6nRGmcG/ukaVkY+quEIGTWf1OgVVmd22Jg1rAcHtb6OmRz?=
 =?us-ascii?Q?FfIysTsVfoPGd4HmfV6U1UNF7o1I1WMkAYhR3uJLdx5WQJfT4laPiE8CdI0c?=
 =?us-ascii?Q?KkbATht2w5J8h+DE5JaEjs08XILeE5jDgaOMM1YOJyvKWtv6s83BtmhSTPlT?=
 =?us-ascii?Q?ju3+wRHfH5+ZBGLYn07l2DBqtk/oJ2+GTCCe0uecMpV+2Zv/WHnYO9mo1LS4?=
 =?us-ascii?Q?NJ7F1TCEdtKlnDzB9wxsxv35kk2GVU/vi23b+9x0Q8OM8XOBCO10TGM6du85?=
 =?us-ascii?Q?ka/UnzSXmpxPRdmzXouz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbd651e-2fc5-4962-0ff5-08dd571e9b3c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:05:12.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7333

Adding generic support for SoCs with tsens v1.0 IP with no RPM.
Due to lack of RPM, tsens has to be reset and enabled in the driver
init.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/thermal/qcom/tsens-v1.c | 48 +++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c    | 24 ++++++++++-------
 drivers/thermal/qcom/tsens.h    |  1 +
 3 files changed, 64 insertions(+), 9 deletions(-)

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
index 1f5d4de017d9..f860ea86d130 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -447,7 +447,7 @@ static void tsens_set_interrupt(struct tsens_priv *priv, u32 hw_id,
 	dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
 		irq_type ? ((irq_type == 1) ? "UP" : "CRITICAL") : "LOW",
 		enable ? "en" : "dis");
-	if (tsens_version(priv) > VER_1_X)
+	if (tsens_version(priv) > VER_1_X_NO_RPM)
 		tsens_set_interrupt_v2(priv, hw_id, irq_type, enable);
 	else
 		tsens_set_interrupt_v1(priv, hw_id, irq_type, enable);
@@ -499,7 +499,7 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 	ret = regmap_field_read(priv->rf[LOW_INT_CLEAR_0 + hw_id], &d->low_irq_clear);
 	if (ret)
 		return ret;
-	if (tsens_version(priv) > VER_1_X) {
+	if (tsens_version(priv) > VER_1_X_NO_RPM) {
 		ret = regmap_field_read(priv->rf[UP_INT_MASK_0 + hw_id], &d->up_irq_mask);
 		if (ret)
 			return ret;
@@ -543,7 +543,7 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 
 static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
 {
-	if (ver > VER_1_X)
+	if (ver > VER_1_X_NO_RPM)
 		return mask & (1 << hw_id);
 
 	/* v1, v0.1 don't have a irq mask register */
@@ -733,7 +733,7 @@ static int tsens_set_trips(struct thermal_zone_device *tz, int low, int high)
 static int tsens_enable_irq(struct tsens_priv *priv)
 {
 	int ret;
-	int val = tsens_version(priv) > VER_1_X ? 7 : 1;
+	int val = tsens_version(priv) > VER_1_X_NO_RPM ? 7 : 1;
 
 	ret = regmap_field_write(priv->rf[INT_EN], val);
 	if (ret < 0)
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
@@ -1040,7 +1046,7 @@ int __init init_common(struct tsens_priv *priv)
 		}
 	}
 
-	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
+	if (tsens_version(priv) > VER_1_X_NO_RPM &&  ver_minor > 2) {
 		/* Watchdog is present only on v2.3+ */
 		priv->feat->has_watchdog = 1;
 		for (i = WDOG_BARK_STATUS; i <= CC_MON_MASK; i++) {
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
2.48.1


