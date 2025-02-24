Return-Path: <linux-pm+bounces-22771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6FFA41534
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 07:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E727A59E5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985C41C84AF;
	Mon, 24 Feb 2025 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I34hTkZ/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2056.outbound.protection.outlook.com [40.92.19.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30771C6FE5;
	Mon, 24 Feb 2025 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377588; cv=fail; b=iff5zK9LoeSh3l/ibDjpvahBLeQOnxyk/NJ2DbeGghYAa3ohROyEDB+uTbmu3xSVFejPU+RBMfk9ohvvThEEaphE/KUDTDHThYcvLY5w92MXSCKxtmKHSz26uM8h2cJjdQTWxaDQIulkPcYc6MqqzwRy6xsMytf0xaTZpG1hUW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377588; c=relaxed/simple;
	bh=3pqyTAyzFnYXzQ3nyqXa6feH5puzVjl9f85POgAPD5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kepgU6r2H4W08MSyYQR61qhlFuxvn39nMST6dRzOx9rbckpatahiDJbhmbFMQN30w+t1Q/0x7heTm/pEUrt+Xa6o3iE9eSSJwH4wQzUxVPzV2FjIfRU9wE1u0QQKkKM7HuQhHh4nYcVswqDYoM4TlV2YaRnXWlD7lfCj/ToD/lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=I34hTkZ/; arc=fail smtp.client-ip=40.92.19.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQaU4udswIOt2qVRd0dp8Q5ax6xCwxNEaYDDK/k/Y5I2O/m3YDFPsbUCJAR/qBTS+9kxC127mAoaf6gdLwSdi1sKPPbVqDopfo15eLur9HMoBRhIg89sYb0kYrOyMJBKvcUTNbk6ZXQrBXF7sV9vx9i8nCtI2//b6FEDwmWdLGIFOma2Ui7dk5Zb+edmyUngQbGTbEaxgCio1V/yXYt/n6rqxV41VXbppdmBA1nRYq7LTl8ekyPrsLPYwK4rQsPvQzdUCxqnOytfJvHjV3q9b7eGvgnHwyZSoXym02mQL2dMcTAbQns1fQ/Vf31vljOjSnP39yuMdBN5ZGAVnoO1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2PGGSVPApqLt6qMDM5ecZzYyvWjHazSYqPCpJrUkLI=;
 b=UsdMCe9HLeGFF1E+YmyivlIWuQVh5ZqF3H6Gm8PJU0beFzvjmqOxJeyCw/1TkRRd5xsfKwcv/l0PSkqZL7vxeeSzd2JjtvHwNyoIuTv3/D+chFuTOAZct1mxq6wVfV5VEgsb2ZqZoYYg9F3QLwPOwQktkN/HmIKwoIC8DILEWMB6WasVRLPL6W63JDLsO0864k6Li4Ffq+Z48EVTx6VkvE/w9tiTIVhynDlVqHeD/SpBN7KB4I1rn5ZPiOkWgaWnM+t18yHDUfvCDcS9eF9oUIBIBDqXkXuIoFsvrwErv7gYfva+d/Xf3aLdRUD6DwuEZ/IRNPxPc9A7vYdpO6jxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2PGGSVPApqLt6qMDM5ecZzYyvWjHazSYqPCpJrUkLI=;
 b=I34hTkZ/pzfmqjYJaytbpxFV9m1ufjPAzAgjhKAiYJNeNNRrAiSQ/mMQ+O6DdqWp9ocnmp8DN/vpY+sUHGYBj1kRQhBpPOo8bACRKuqU0z0VTM8dENQfs4zx3wn1lxw48zsAMIipGQrOrSqrf8rcRbqs8FECXph+QieXJSmcWVky+rifnBv8creFUKkyeoNJZvier2SvrLbrjRcg6zkyeXJDRt49nTuvRtbw+OMqSGpl/2WZOFmn995Gzs50Bk3K6K/17bv7s9iuLw5/B6mXRY152HZcmPhW8qNWIdwcbDfVZL8jhmO2mf87m7b42DMyN2a1c0tpJdPxIPRpYQ7XpA==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CY8PR19MB7179.namprd19.prod.outlook.com (2603:10b6:930:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 06:13:04 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 06:13:04 +0000
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
Subject: [PATCH v6 4/5] thermal: qcom: tsens: Add support for IPQ5018 tsens
Date: Mon, 24 Feb 2025 10:12:23 +0400
Message-ID:
 <DS7PR19MB8883EA39BBB1B3E5A0988DD29DC02@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224061224.3342-1-george.moussalem@outlook.com>
References: <20250224061224.3342-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DXXP273CA0014.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:2::26) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250224061224.3342-5-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CY8PR19MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f9f313-f970-4dce-2451-08dd549a4c35
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|7092599003|15080799006|8060799006|440099028|3412199025|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n4sHlzqA9N5nc5OWTsGdDE4fUDatWZ2mfJrzHAbYpYr/obmNrWR7yXKPKTos?=
 =?us-ascii?Q?im+YyKSJEtE96bxnqNFcTIXdcqCi8Q96ECHfZT/g+S5yMzrFYTwdNbnThDJv?=
 =?us-ascii?Q?c3FK6d8h974lY817KfSf9/hOKCNYiJ8ookjVbExmodX+n0JYsVQ10xWFJZFj?=
 =?us-ascii?Q?P1WvVm+NxKfeyH5uR/h6VKMuKjiScXG40wJLqF+KUHaB+JTsyUH9j1om555J?=
 =?us-ascii?Q?ypVLQC1VWPhpUAx1ET4ISR/5HFA4QkhpdzmPg+zVCYlYZeakkKaJYFCnzUC2?=
 =?us-ascii?Q?MZ49cvO2THDXs8HX2hD8YW8zn9O8lqpZfNUhvFVniX/EJQ5kBZ3UEj4qE6Tk?=
 =?us-ascii?Q?XsamSpxZrBHPPUWK9l7a5OJITXcaIt6880G82xCmYVmXR+r5B3G1OGgYCdPw?=
 =?us-ascii?Q?2TkSHWEHS8ss8mm6C6r1H7mPyldbS4+2XK4cEbGFVok9VPZx/lDULT01zc12?=
 =?us-ascii?Q?eTy9QJ9qXVTq5dAg45bxYuD/LasoTbpoKK4VcANajCgdImMDhKxkmDvqNybj?=
 =?us-ascii?Q?qr2qgn7YZFlyUz/89JYDQsAeDMFW3tpl/CuhRICLNOZ6zeSwbTrhA3aMtZBP?=
 =?us-ascii?Q?gnAb7mLIoZPZYMGXO1+hCQM34trofUC4cKHpdNqbsIHjnStyfGQpMWfm0jSA?=
 =?us-ascii?Q?yQwFTjiUSWtdaDLm+bovs3H79/rZwImcpIPSKAutiTuYEeWi/yNeCtoBP6mr?=
 =?us-ascii?Q?0q2iAveKhIbd+XT7y0Q0iOHuss5SHt/KBfceyt4oRumI1uDzmlEwpBepbRNW?=
 =?us-ascii?Q?1DsVrauBqPsVadrlcAExUQ0QNCsgeRXL+eZ5OIUubcgdISR9GO4v8K7aGOfz?=
 =?us-ascii?Q?T7SobmnN2fHEGqjl9+KZqrzL+5R1ITPil380gr2nupVknSuut1xm57YF7spB?=
 =?us-ascii?Q?KE4k82vsYj89iHziRzrzpdyI6pc+CApVvoS/dqJIpyQWHIFFHm4TDmm8EbDV?=
 =?us-ascii?Q?ahTmjX3NqP9TAOnU7q3R8EX6UmNg5b/GrA1Qse6PuptB+xn+d0N9FOuxlZuq?=
 =?us-ascii?Q?oETCeYfkG/wir/xIFR0pJwHIEAFap3NhPnoUAM+v7yczbJD7QM6HQpSGTDKB?=
 =?us-ascii?Q?otEE8G46PY4b5p4wXcm0WD0HhxVZUroQWQfxqLGvuPOoSVdAKYWv2il4hmtk?=
 =?us-ascii?Q?URAgYDplHEFscxHVEqB5LXzaHUJWsEaI4A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UehK0TFXgyAgzqiff73EYaPkclR13268157EKmUpt5ruo8IrxO0/2Vbdrowx?=
 =?us-ascii?Q?j/0l02PELhu+BpQUcCoFUvWZ2EwpQlO3MHll+oFDv+p85WYKDZPwK0vaPXfG?=
 =?us-ascii?Q?ehB8UpfJNkWNIu/WCyor8J9ym5qrdvKPcCOKrgx5tVGIGvA7bYU9Moy2ZND1?=
 =?us-ascii?Q?7Wos94qtwmoQxteFMSDufmdRjcyR5Wto33QcCooxUifJpe8lJhBvJ7uGxZQX?=
 =?us-ascii?Q?G9osJV6wVcWqK5Na7KSXXUEmGdejBMsMis73GfZb3bd3D4EEfdROi4l3+EYi?=
 =?us-ascii?Q?ZgeTkx8aBqssIEQTPSXF2yz0SWWwWj37ESJlHu7ARyMKdhbpi6/JOBKcmP3H?=
 =?us-ascii?Q?mbSGY2BgxxoBYMEjm3iybo5uzuUl6VpDFSU7FG8ttDvmeRiGb0hFTZvPziGD?=
 =?us-ascii?Q?h7Py2aGMnQ93mlCy46ZoKS9a9DZ0SPKNG8uRrtUCa8M31XzLlDKo50nMKYW6?=
 =?us-ascii?Q?vlkUNfCBONOzy+E0YgqGg4JjHCIr/mpRX3MaaCLod/NbnQslltSPD7fADBxU?=
 =?us-ascii?Q?ftBVXdOlwDYZ6TAbvGBAfv9+epXs4nTp6Pdjd18/mcQv/c7IMGlyEpSI/sj7?=
 =?us-ascii?Q?9XRrpKyUnlnPM1ij27CmLo3+7VbUh1sCEaxeYCVpbwgvcLLFcI7/QFNcnzqv?=
 =?us-ascii?Q?LSwXbVCOKSDAtNiAyitxNYDpd/Mr9Ujl+Obqsi+4GLmkTbscJHRfgfaum38h?=
 =?us-ascii?Q?M/mScOh8EsHPIuRujlxIBG1JtTxdPk4B0sTx9UY0F5boIJ3sfQCIsXC6Pvda?=
 =?us-ascii?Q?sKOTGoIFZf2kn6+LFPYOyWRZ5i4jv1vkjLsqNNy46Ow0ji5m4GQLkeiAxQRI?=
 =?us-ascii?Q?+XejOy8YhF/DByC6cmvZRXQEke5rckGfxrg9wpobxNQ06wx14ffs/WW3/Qrp?=
 =?us-ascii?Q?6kDNfSWPy3iOIoWB/7Yl8FtSBv+7C9EGZyAI8mYEQyzRkxLjUgjoX2IFeSNA?=
 =?us-ascii?Q?NK1OoFtkaJx+kRXGfJaK4OivMLjcvSw9mphxpuMp2h7wsKojsQ+MGkFUOfXO?=
 =?us-ascii?Q?t918GdQhH6uINFUxl1qUOWB3L7ORW9eAOwcokpK8g6W19M7bA6hMe8LrlpQp?=
 =?us-ascii?Q?R8tkIlr8Nx2evQtgzSw7c3NcDxutjK0XcGauLJ2D0uqsqAujVUzqqExLRGlL?=
 =?us-ascii?Q?XQx1SWqBzaODse8X+vQL5wzMXBr2DL/spdllJ4j1ABvg72/hkkR+xwfaewsx?=
 =?us-ascii?Q?6M9gy4DsH1OSUiiqDX7ASrg5EP7DoB74MMguoyJB1W3XoeET/M9RUleKG8Y5?=
 =?us-ascii?Q?da5OPZkBJHVL6mD3ufHP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f9f313-f970-4dce-2451-08dd549a4c35
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:13:04.1867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7179

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens IP V1.0, 5 sensors of which 4 are in use and
1 interrupt. The soc does not have a RPM, hence tsens has to be
reset and enabled in the driver init. Adding the driver support for same.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/thermal/qcom/tsens-v1.c | 60 +++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c    |  3 ++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 1a7874676f68..1f955acbc2cf 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -79,6 +79,18 @@ static struct tsens_features tsens_v1_feat = {
 	.trip_max_temp	= 120000,
 };
 
+static struct tsens_features tsens_v1_ipq5018_feat = {
+	.ver_major	= VER_1_X,
+	.crit_int	= 0,
+	.combo_int	= 0,
+	.adc		= 1,
+	.srot_split	= 1,
+	.max_sensors	= 11,
+	.trip_min_temp	= -40000,
+	.trip_max_temp	= 120000,
+	.ignore_enable	= 1,
+};
+
 static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* VERSION */
@@ -150,6 +162,41 @@ static int __init init_8956(struct tsens_priv *priv) {
 	return init_common(priv);
 }
 
+static int __init init_ipq5018(struct tsens_priv *priv)
+{
+	int ret;
+	u32 mask;
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
+	mask = GENMASK(priv->num_sensors, 0);
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
@@ -194,3 +241,16 @@ struct tsens_plat_data data_8976 = {
 	.feat		= &tsens_v1_feat,
 	.fields		= tsens_v1_regfields,
 };
+
+const struct tsens_ops ops_ipq5018 = {
+	.init		= init_ipq5018,
+	.calibrate	= tsens_calibrate_common,
+	.get_temp	= get_temp_tsens_valid,
+};
+
+struct tsens_plat_data data_ipq5018 = {
+	.num_sensors	= 5,
+	.ops		= &ops_ipq5018,
+	.feat		= &tsens_v1_ipq5018_feat,
+	.fields		= tsens_v1_regfields,
+};
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index a25ca17adf1a..5ccaa297d16d 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1102,6 +1102,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq5018-tsens",
+		.data = &data_ipq5018,
+	}, {
 		.compatible = "qcom,ipq8064-tsens",
 		.data = &data_8960,
 	}, {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 90bf11fba563..f5c87facb552 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -650,7 +650,7 @@ extern struct tsens_plat_data data_8960;
 extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
-extern struct tsens_plat_data data_tsens_v1, data_8937, data_8976, data_8956;
+extern struct tsens_plat_data data_tsens_v1, data_8937, data_8976, data_8956, data_ipq5018;
 
 /* TSENS v2 targets */
 extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
-- 
2.39.5


