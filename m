Return-Path: <linux-pm+bounces-23148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C58A490CE
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 06:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1C7189144C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 05:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313CD1BD032;
	Fri, 28 Feb 2025 05:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pJY8ax2b"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2103.outbound.protection.outlook.com [40.92.20.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D671ADC75;
	Fri, 28 Feb 2025 05:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740719776; cv=fail; b=ovQcdW7snY3eivYkmO866IXSEXqE7KD2PEevdyW3Tucg6wtrk3XlTCFYmsTV1vU12ty84TmXkRhmTzA/8SsP07iHlrsiGE6cK7jWYj/hA3ZwPp0P6bECjVKcpVMLD0vC6Hor4+eyzpTFo+fsPz5V76kpwWpQ39ryylTAVudD3zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740719776; c=relaxed/simple;
	bh=m2RVNoD4xcmIv5aWbCFj73tjTMkPkqe9QMHZXwb3H38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLfjn7MSpLZUrRs3jfyI/0TmjOYovShhn+mtfdUqDXTMEkwk27WuLvRT/tKcdlVrR9tQOyLLKtD7WuvNEg5coGG0R1WFNRbCqxALOdsOfURp9F9BAy4wP0Mfu2NKcTXN+W3umyZmIYe+s+QxFh5XtOM16jydgekRUZYQS7DFBjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pJY8ax2b; arc=fail smtp.client-ip=40.92.20.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIBrTmFqfYYJO/Va8WosaI1DOJLcyascYZNrHe8ulnx4SiNTgLEcnXHhAZ8rfrsrOy1D7XeldW2OFvfm7xB6oDt/e9+y7Z35z8vNXAIseAiLZ2t0HtBmJS+4bWxYiNamggckSsTSQW5VukU1CncaBg669ELJ4U0EX1l3Pxo8KvzQdbVZjoGbfaA7o7sxw9V/89oQ6t3p3gpRAw/cHQYI7e9fkWwRnjOTZwpYh4AN9Y7/SJkXrJrDbxYzHxELdVkHkZvyWFZrNd7KPxNgqKITyhBBqwtM7R1HIiSUqxlZrYdg0g0Ia/CQmq/jY3RGsZQaUcsyxpzkQyK07HpXcCBbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcU3ip+Bumw1UqfdnUV4oCExHo73u0hdEMYEyWgtQcM=;
 b=fucwAA2GHg9vePZvOCetHMGQ/mLB1xLeE5olA/z0CvQozK2V/ryJXFAd79gzrtglUTwUbjJk4ahcg5rj1yXYaA8VFBXBdT/osg8iCnEIfGYs8pnjZUjrWfIT1YR/y3s4/RulHKKx7/C6g+V8MHXP8gfGohQvEDHkz6hnpPLRF61lmaP78hYaRcofDs+RmgKjQBiByLGrNevmUeGMPASM69ejrrAli87yTAq3K+KQpBkIle+IHE1XbucVrXHXcQzzHsDFRJ6Rx92fwQcraz9OOwhOyFc3M1DTXVl4gn/UcdSOJiMdb995eddISWqMrjcK7OooiY5fi7PwOisrT+o45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcU3ip+Bumw1UqfdnUV4oCExHo73u0hdEMYEyWgtQcM=;
 b=pJY8ax2bg/sX6V+b5Cl6fZG0fQuqeFWGBsWt4s4M2a49ig/5HB/Cbm+qtTaSVLSXZg3sCP2FU/PsMxpMWO/tksRWGwfmp35dn1hv5o0i8UM9wzU43vFJapy/bECO+YOAfAiRSxo9yyGgvqxkrbHfCw1zGf0mDg878c9aXXqdIFGkBSJuNretEJlOKkoPTKI/7rhx2q4j1IPs4cnm/4IyVUq8Wji5RnKZDPfHL7PZrdkKDuXQUPfod1uDT5wclmwLIWuKb262WoB2Z+5oXuNj7u29ICntmoFmxxsYd0RoLqX1yCkivvbpmHQnH4hBIE4y31jdacaBR9Czpa0ddNQ7cw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV3PR19MB8318.namprd19.prod.outlook.com (2603:10b6:408:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 05:16:12 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 05:16:12 +0000
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
Subject: [PATCH v9 4/6] thermal: qcom: tsens: add support for tsens v1 without RPM
Date: Fri, 28 Feb 2025 09:11:37 +0400
Message-ID:
 <DS7PR19MB8883C5D7974C7735E23923769DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228051521.138214-1-george.moussalem@outlook.com>
References: <20250228051521.138214-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX2P273CA0007.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:8::19) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250228051521.138214-6-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV3PR19MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8be65b-24c5-4189-63e6-08dd57b70407
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599003|8060799006|5072599009|19110799003|15080799006|41001999003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?emobDJ5y1Ud/e06AhuE4GaPQ/EfWhSuze7/E2RoYYAB50asZ1flMM1S8s1C5?=
 =?us-ascii?Q?jtc5XdzHQCzoWv7ZT83tdIWewj96mGzF0XcMDrH4YvP/uuaEVgM95R0qlxh9?=
 =?us-ascii?Q?qqmLV7EPHbVXqN9umglsa53RK4jf79Wc+eG2zMxmynnahjGCLaRFUNimQutZ?=
 =?us-ascii?Q?dGPwyidKrSIyZjwO4JqGLRb9RC5u78NxrUwPprJNIPt3BLMS+dOcjSuJ8rc+?=
 =?us-ascii?Q?7vNo6nUWiFfXw6kZcCuCPteeLqbvY4FfgcYSr2v5idMgU7IGJf4rbMTJ0BK9?=
 =?us-ascii?Q?KFhcy8e5xx3pkaKTICAS6jnrMWqxXSjdMC3srR31Z2g/bs4GcFexbtbWdoSu?=
 =?us-ascii?Q?0Kgm9wvSXXgo2kQmk8bJkHXTfPb1MRfEnA4nzTqrchCwP91jxAFr7sBIYYWt?=
 =?us-ascii?Q?dwzbv2bXwoPqvCSaQ44NVprvC/dadIGdOJT48DQ386IFKqpXGVvaYRE+gim+?=
 =?us-ascii?Q?cs90+OwPiuLy2lH+xnDnLc1wark/36XMUDmmrLnK0BD+LVzPCFBHk86QHhYI?=
 =?us-ascii?Q?m2BXy2XHeias6Njc9437mw3yE6zhAHLottU5pGgd+M7fzl/VRJbGCm1n3mgG?=
 =?us-ascii?Q?Hbp8kITxAUhwIoKelpeWADcsMG0VlphdVcWe4iLRIL1CZQjvYjtLrsVx7G+l?=
 =?us-ascii?Q?bCaBB1Ym4SEYGaivL1ZouAHEesaMZRRmaMinoCTJJtdE/IoogbFPzxuUVnyZ?=
 =?us-ascii?Q?iRbYizXvzPEx0xdqw7NUBXccU5WajPAfRgZ9se/gNE7f9c2ndEIqREN5Z3ll?=
 =?us-ascii?Q?PXBDafr/QAHsMP7adp9piqUohRPbvG699R2lkXb/WF43c9JBizwKGZn19tlP?=
 =?us-ascii?Q?YC3gJwXVo3dq5Jbpbmx+2JwIRvFJhad+Yf/K/6uyA86H/zLx/Y1OHopbYZYO?=
 =?us-ascii?Q?ezBuinvLd6nSe88+Y/ngmlVene2Tre5kw6NaTKlF6A2RFswibiX67cOey3h/?=
 =?us-ascii?Q?T6KaWSZzqaRjPCuztMZk53qIuVrO6leNyhXbzmp1SbRuzIvlIRXDF7azzJpv?=
 =?us-ascii?Q?3lcuKJlvGpli26bETxiWXNtEj16CZ5IvHAxTfrJmI4LdXLcACFdaAVZPoL+n?=
 =?us-ascii?Q?So5Vm48PESnwZfo2jB6wm7tDlqOsLuwckB8qjyP7el1JgwaUlsS/RQlnmcM2?=
 =?us-ascii?Q?DzGwxRDz3J/CeG8Mi4Cp9eP/sNjWdB/AQg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I/ZHzle4OkIyM03G+iTLt3Q/NAMLYL6/xQjBi6OS+V/jjsdMI60kWEyZZ43y?=
 =?us-ascii?Q?jGXsEt+Q+CkiH0jt86zMQYe3MtF1sehKgkdxaDrw9WFyUxV73YkJucFyyKq5?=
 =?us-ascii?Q?WrRNXBzzIdR/m449rQiZb+RnKeIXKRNvtb+YjfLmihao+OCi4p0F9K2TyJf4?=
 =?us-ascii?Q?s31VdxYRjkIvfDdZWNhzJTN+HXYZwpWyP8t9CqfiRAF5o7PuwUVFD5gRV+mh?=
 =?us-ascii?Q?0wy2Tsajz0BCp7VAjhUoKSvXGAxmKEIGjN8S+YbT2lGLhQ+bO2rzrxmm7PZW?=
 =?us-ascii?Q?+DKZ2hoCV4efxhhHk/HSX860c+iE/GcV5oyRhTi4O7NRHz58rzmK4/Ji1ERZ?=
 =?us-ascii?Q?6xCW1ng9x/T8w3VVbE0LqhhoKuDd46AmeEUZ8xpt/ShO+gLgE7Bpos1CVHyL?=
 =?us-ascii?Q?HbILtIWvEaZiay54fKEwiBwRZQseDswmP3ohCD2p3exbyqskE026ClXINiwm?=
 =?us-ascii?Q?i/GnVhY96Wig4NP577oQccQcGa5WWcdabxDwJ+uYlvbGkggPBOFauOmmsk0j?=
 =?us-ascii?Q?lqc2Wou37Ady/e9nSzW9IE5ecccVFrkZSiAg+4SNx1I6IXSYhYI6twdpwIcr?=
 =?us-ascii?Q?IwwVhKi5BRqZC2yRydTM8Iz+Z5ZR+dWGMMx242WLfpYX+ZamTD4mwdxBkSVP?=
 =?us-ascii?Q?ohjulXi5SNmOtEP1Ju/zTQdp0e6nzDe+BZ1wSNvgIyqbkFZlbEJffiq8VAxL?=
 =?us-ascii?Q?ksY/5wQ/07uesJWDtVKmg038X4zx1Ts8Y0PYM5NrARSxGe/cYHBWvp3J5wzL?=
 =?us-ascii?Q?Jt/fk3boaAvZZlo2N9iHoKtJyPqvdIKwCPMbX5pOvnhltIC96W43ARqSVB/L?=
 =?us-ascii?Q?M/JWJ9cXhjLVrS8s3wi4khpwsknO/Sv1baVTlnciGgMH9Q/fNIaaSVUuC/bS?=
 =?us-ascii?Q?gpNlRSb5eNQCCFCZIxOn3OETInuT2DHTmQoxygBv5IP8ThgeI1gbOHb/uYX2?=
 =?us-ascii?Q?79TEOKmieMRFmdr47HKpEwrzzsOZWCeFhqH3KBW2A5uR45A6nsrOJu7bZ67j?=
 =?us-ascii?Q?ma6F3lYijMvPJhKkZ9FDuIt6Dj6T5UNAn5//mc2arjF6IIr7j8RGpSNjQ1Gp?=
 =?us-ascii?Q?TZ4pYRzim2Ttb6mamvCn2tS+XXOiJwp7Vdn672bzaisB/SGaHlgFbqYbul2y?=
 =?us-ascii?Q?0GD5gzFIJhd3nrCYTsKx9d4zKzTW9LaCmZTM3BdYtP166TmHAkmapR5wys/L?=
 =?us-ascii?Q?xI/vklcskXutArydqmeFl02JWGQKpBu/cOLx/lGVbXcQJUCY/tjnfkjzP+Ra?=
 =?us-ascii?Q?MfRDqu4ubHbF0hsfFOVK?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8be65b-24c5-4189-63e6-08dd57b70407
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:16:12.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8318

Adding generic support for SoCs with tsens v1.0 IP with no RPM.
Due to lack of RPM, tsens has to be reset and enabled in the driver
init. SoCs can have support for more sensors than those which will
actually be enabled. As such, init will only enable those explicitly
added to the hw_ids array.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/thermal/qcom/tsens-v1.c | 48 +++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c    | 14 +++++++---
 drivers/thermal/qcom/tsens.h    |  1 +
 3 files changed, 59 insertions(+), 4 deletions(-)

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
index 43b388bcc7d6..2cda92f3d125 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
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
2.48.1


