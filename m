Return-Path: <linux-pm+bounces-22605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E57A3ED0E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 07:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E3F19C3607
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 06:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504771FECC2;
	Fri, 21 Feb 2025 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="g0misKoj"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2036.outbound.protection.outlook.com [40.92.18.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8153E1FC7C7;
	Fri, 21 Feb 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740120785; cv=fail; b=KDTx+pdK6WF6OXtSY05xaGGxwcIX5OUezb2qeANpdUK+jBcrh8gKCKfUTjRMks7nCCPMt4gTjkJqSIr3MqE5b1Z46bCO9zzc2+MGOD2/RalkdexzPC/ghOhbL3yRg+TzFTDW5f4X5T+1Ot/TXNctxL07JeGbuevN8TI5ywzW9b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740120785; c=relaxed/simple;
	bh=ljkUTEGofcYEhHz5i1sEFGxZ+ZXgwzbf+WdzdUgisnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=knNaGubtRlxxZUkEChpRgiX+V37ESubDIVdoI2Vt9Kgj2vBshuZGXIQ6v1TsDKuszqXCL8CgmQg0tHi2izouWA3hSM6DWp7g0/pJStrHjONmNmy6tj4+fIiY5fM0eSXnxwmQYeyjLtT3Jmyr8/lG1NA47H3900W7wSK+UySRIo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=g0misKoj; arc=fail smtp.client-ip=40.92.18.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M43VLlrYfIjjBPX7wvIrMsQwEwotccr28rxn9fQP6OUgRquz/QiKccSH70M4oTwZy8V53PIz8h3AJnDcQHzIMN3Ok9gzO9ie27LHe7FtwGVzXlD9LY+X0ngB6AUtH8AkycTPUpopEF58tvSZ4XZMH3flDKc35bR39euRcP9/4AkTswSa9HKcqt044iIxFPfIGXUF6fLYjecMlHGAyPUr/YUxOvCvevR76ul8MgyUWHfNClYb/8mm20UoKFfwt1iRy4EsHFqWDKcMgcMXA/95hfPFIXIS5U+cJiHUowsr9EZojJfCQqYbzA5eHG+vQ/0fum3EuxmFi42bHr/sD0aTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xQ/TKxoOATCItn2rJPR/AyAzai/8Go3guNTJhdbxBc=;
 b=Hp5CzMXJO6/RFPfA0L87MwS0j5jfpHLHYmyID7C42F/F+3QJlNvTV5Wu0Eksl+gKAWOeMiRXRjQWE9wZSlDKlzjOXg9//t2olXhL1TgPSjhGfyWzi6B74+WFQLf2+H52zGrWerfEX/oBJPDp3dAI+Qvszfiw87hIm7pqc3GVpO66y8tlcp/ma8zw/S45QBy5c12C77eoC9QxG3L+FbFv9tpZZAtAZsIgvEzR+/3+TfBbESntzlHV+wr1e4ZhAN4+NbjFmmxSFI98aHjpWC4lkekfzyrQdK7wkoaUfIf1dz1rd0eUXyijqb+AmxwvTk5cGGAh/iC9+piDgbWlA3TQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xQ/TKxoOATCItn2rJPR/AyAzai/8Go3guNTJhdbxBc=;
 b=g0misKojhIYLndBVAufUYfcHicfWuMeaQUDq0AfGD7csQk3Si62eHXVBWLcgO0Yquo0WJAXC/Hy08oa6DqF6vlnHEp0wJL4wdYbcM42odv7aJLRAWvZOqtfWKXcT4tqlHhI6GE2q2g53OJw9elx6kX1xaQ26GkjoavkP3hH8pZHPZcDBQzr6wQKWUweSWzLQt/U/lzvFeS+KzxvMuugkB0boXwuYZVN5ryMePj3nTAyia1vGOEwWoXGZXv4I4FDByBR3ghUWH2EeWtssKfdVpMhAFTOesGHTPcMNWCaLD4Nttej+JG16AhdyP2yKH5KuyptzpKNM1ktHfzaMCvFrHg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DM6PR19MB4248.namprd19.prod.outlook.com (2603:10b6:5:2b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Fri, 21 Feb
 2025 06:53:02 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 06:53:02 +0000
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
Subject: [PATCH v4 4/5] thermal: qcom: tsens: Add support for IPQ5018 tsens
Date: Fri, 21 Feb 2025 10:52:18 +0400
Message-ID:
 <DS7PR19MB8883A75912761EB89C9A1B409DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221065219.17036-1-george.moussalem@outlook.com>
References: <20250221065219.17036-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX2P273CA0014.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:8::26) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221065219.17036-5-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DM6PR19MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: cdce6631-fa3f-4e3b-eadc-08dd5244623b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|461199028|15080799006|7092599003|3412199025|440099028|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1dXdLh+49chdyaLTbi5EZGOFRTiDdDgeNfgZJOZ1CqSDiXD7qoexQyzd2nLe?=
 =?us-ascii?Q?/p15/7pxaZxeB4AOXSfz1+6YmnoZi+c9JBFdOgMgXb0mx1maq33P/SBuVh4a?=
 =?us-ascii?Q?dC29SYwj04mZ6clH+oNYXpdqOl9RPwfRaphavQQlwWk/IlNVfBStMZHRLqxw?=
 =?us-ascii?Q?F+qZXkbuiaZrOzHPiI0HlXcG/suF6dVw8zAYPhT5dUC8whdh4g7Id7PnhGvz?=
 =?us-ascii?Q?sEN8Kcvlz9JupNfbyhzu8AJyhXgjxuI8pkDHjW7ZbqXesnZ+EOvcrNS1KycQ?=
 =?us-ascii?Q?qaZFhDV4IDGicrq9guaR80Nw8RHPf04KjaMLWPo9gS/fp3Q2YEzn2TevlUGQ?=
 =?us-ascii?Q?mXTj6kJ09ZwgZ9I/0XJOt/RmTuYNbPxbFDEtOI7OwE/ErDaeDSf21WSaXVFY?=
 =?us-ascii?Q?J9C7aSzHmeKou0zs5xdjB1HAYAdIezA2pLOtTIJGVD/7vDsjpJh8SMWsOwnH?=
 =?us-ascii?Q?g623JOhz7kvOTDu+c93IsK7vifrfMBVJKWJSJqbASBdB06tFhRyvco/zcKjg?=
 =?us-ascii?Q?v77z+hJp/JjAae50uob1BSk/FwSgEsqJ+khBh44UeXVeLgBAYg6YBmDFqDG9?=
 =?us-ascii?Q?c6xjHZVfEdIzJlSNDVATwNeAnCq14FPs+JbaWKEKL1PidyQozoe2jqPQ7s/d?=
 =?us-ascii?Q?NWyBk8NWenjmCTTkoGozHnpkDOCix6r8PqLteHn6eqUryDHItaucrnT92JZ7?=
 =?us-ascii?Q?OYmcOW33GYnzP/+ziaCkE2/anTXTII26/XOBxROt0mrDObTHy1pvSlVwPR8Y?=
 =?us-ascii?Q?3p85ys82snDM6CHspagjQD4Szj8Les+Ar/GJ776vytW9Dep/7QzgDfz9wlsO?=
 =?us-ascii?Q?PF58cbQVftYZrQqgxSDrAuz+OW40wAPxO/GIEROhvSz8siJe/kJuDkgfnreV?=
 =?us-ascii?Q?l2wLPmzoDoXA2lzv8lUjECfgy5ESglxZcd1Ey/PZFSoh6QO7vw119TZUOWTN?=
 =?us-ascii?Q?Ht6zEJZvRs2uWb9kLXuFA40LGN5qSYdsWyJma0Mtz2QgZFz1pScYBZxYW+BW?=
 =?us-ascii?Q?7lVhIKROoidDljmGFsleY4JZ+Qpd0zRRJ3m84uGyJFTTSvIhOZxA5dGcJo9d?=
 =?us-ascii?Q?M9QDpQQWRlR2fgn5bHcOJiV9ytnH3nn4e79rmyNNHtQS4dwPG+m8n9KXLAmQ?=
 =?us-ascii?Q?gxX3p7vXVJ74x78z/ENoF6das6NDaOXSLA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ffyso1wJeRvPwGEpxksNTYj+mKfw6It6Hkj7Ob1mN9RK2AEERG0uPVNtNAcz?=
 =?us-ascii?Q?nwZOzcEK/e/ahcjHHQv/fAfyxB9FbsRdrGRE9Hb8v032YBRRJyLOiiWjGwHD?=
 =?us-ascii?Q?DMb3sOI/vXRECcsFi1x10he4jJfUJY5c2TBDJsMYgc5mk2DaVVyBtUtRFa/w?=
 =?us-ascii?Q?wAECP4BjCFCewTCcOgz4hCEs6oB3t6CcYTH0QF63t8iSZisPj2qFAPqyFvZx?=
 =?us-ascii?Q?7xljLGwOCjc4Y6G7YyRrKVBalfpvRAccqpL0TaKu2kVSaIdD+K6cPB5PXRnT?=
 =?us-ascii?Q?S2fIW7rAOH4d8W1o13DJzu8U8+PuMuncAo63cUqLc3Rj1chYoYB1GeE46mlY?=
 =?us-ascii?Q?2ngYMGL3Kr0w1Ko5wFTxXHqdfJGHpZ7kdzFozpyb8phibb1JIT7BsqMqxnw0?=
 =?us-ascii?Q?/QfAAjCg/6e/cCPON52Lzo0Co3Ao0yybfMiCsMGzKOv25tQZh+TvE7azUFHE?=
 =?us-ascii?Q?tUOCIWuvXOef5wSNRdeQaAY6erIMTVrCwvGb/mBpMMFjvYP747zStoOVrPnz?=
 =?us-ascii?Q?rjHWBNy/fvynCuIuh+g6H4kCuHQuyjH4laxmYzLNZldCHLyRjSkP2fgFF6sG?=
 =?us-ascii?Q?ueqtKA5FBBH9ejGWFtgNaZgBME6XbSoE2IXSSpBTHK8AiBVfBUWC+Hva0zsh?=
 =?us-ascii?Q?nI4eV54oJurqSHAnyZBO4bf2HYN7Ytj7Xmu6+GJSEcMn6TZodJM90h+/xVF1?=
 =?us-ascii?Q?6iexZPqOOFugP+k2UuKYYObeSdmyDnoHxq+Tu6DutV7zMp7Qzrc6wuZ2SgiU?=
 =?us-ascii?Q?FcHgynEwln3zSuJP9p/I9FbK2AUJZwinRYNyyaqi1rUXpbAv5y+bjcA8DIkQ?=
 =?us-ascii?Q?fZj3A7MF8HcONkdVhhwFPPtX1HuZgmj/FNG9OF/bEkN0ghH9dp4mPAATzd3c?=
 =?us-ascii?Q?NXS00v/Wc2weTvSqpmyhzOtmaECBJiPaBZxkHXaDJ+jvoIRFXZxL+PqJAquP?=
 =?us-ascii?Q?JP3rp0X/vwvgpqrELxVmLN0dAxoOS9HugVaHHgmw3gepkYFS6aj4DDnwidxO?=
 =?us-ascii?Q?Gs/ro0ogR0WcNBTIQbBE58FoGFYKKkFEqZ+Ux0vGZFYZWa8EiU9+8dvbAMMR?=
 =?us-ascii?Q?tr2gofQ+lT5s6H9dqx58RXU8OdkvrXI8d46JRVdsH4iLbb3/iJW5zQ95ilGJ?=
 =?us-ascii?Q?xoIi2pPXQ4ijdKQ+MIJiQXR5EBUi3iDEt03QQdFkWVXzdV4AlKqMhIZnYAtr?=
 =?us-ascii?Q?jOTRCnCb3i0p1A6uSeoqGlu+F5KVug4OZU9NZDxgf1cT3U4OydVb4pgQ4dWQ?=
 =?us-ascii?Q?ox9utQemCOxcAxakkh21?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdce6631-fa3f-4e3b-eadc-08dd5244623b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 06:53:02.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4248

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens IP V1.0, 4 sensors and 1 interrupt.
The soc does not have a RPM, hence tsens has to be reset and
enabled in the driver init. Adding the driver support for same.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 [v4] Added Dmitry's Reviewed-by tag
      Fixed modpost warning: added __init to init_common

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


