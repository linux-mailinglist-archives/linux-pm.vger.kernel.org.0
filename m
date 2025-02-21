Return-Path: <linux-pm+bounces-22663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB7AA3FAEB
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE66442EA1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E41022259E;
	Fri, 21 Feb 2025 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UeF2YDYJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2080.outbound.protection.outlook.com [40.92.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F61EBA14;
	Fri, 21 Feb 2025 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154296; cv=fail; b=Ot5eAYEHTpM0yjpPc29Idksw9pUuCPkSGJPoAlr85qHG0YTc0lCD+mXNY0DYiOjhXKATptE3xxpTP+K5zIp3b25I6fYfVzXdX91NEiEd0kUh3GK3WdEcCAAfvtT9dCIF7Gp8JEKZLHGaJsqAlQCwREdSwcw7RZOgqCq+ob8oW+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154296; c=relaxed/simple;
	bh=3pqyTAyzFnYXzQ3nyqXa6feH5puzVjl9f85POgAPD5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cxffz68q4Z1qEJDjk7J5BlVP75CypHe7ppL28xh1twQVNjJ/GVAGjWSOZQLmxPMi/oKiRJnvNv6tjyYuZUr1GNvVbUDpezzfVNI41gpN3sU8KcW3apiepr0XNszglOpcFKH4IIwT5F5AWARyBDAvFdFayGTdEnAv6mKPTnS+CQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UeF2YDYJ; arc=fail smtp.client-ip=40.92.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKcqMP5VRBlXjkChtuDBgKtGApFuz6nyZmZ+SaIe4d3yW+E+6K1Kt1rEf96XK2kSqBpcBMXcYXSssOv/qINiiZ4lMwKJrv1vh5W6x/0FpI/uZSQoY+Ylj/0864lCka0El8FWaeIIdxWNC/jw/68IgGhlgaNu8yJQw+xu9XYsbfsUk1ciFgNbgSL1D5C4DPczJV5+uIBFbzO5zsveUuc0YYh6nLH4Y3SUsScN+qYH6vWmmyU7HIjHSNyWJ+PoS+L6sL0v1u0plXx1Wr1gLmMBLc8fhrIm6CqvxT0YMdA2KmfiMcFrBaI4kZw58FBM8jeuLrC40NMpZcW6gHG5kE3rvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2PGGSVPApqLt6qMDM5ecZzYyvWjHazSYqPCpJrUkLI=;
 b=JHgibi+c21DugP3z5tDYqHtP5sfxRQW2IqA+YGlAG5WXfBcaosrX2HNm990VzKSvtG1eDdsqJy1Bp3ifsvClKfTe4K0tK9vgeH5dm163foTVTI6jb7k6ohzq4amDM393GPZugMX3HhoDXsZK4+MBlDPUgUD52Jk50oH9jgNstc7WWPXWuZcPToOtKpRIJU3HETFlHN/cPClvMj0pEXw1WHETuEVO6ubYAHRIIH2Z3R0NYU6GA5ZKXfvS38UumbS0V+o9eqBbGLNpm3FLuXB4MEG/MgvxlTxtPkp0gYDDXB/2Evzxa5XoWZKWvNJkydzQb6B/oadnON1UiTJdWe3i2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2PGGSVPApqLt6qMDM5ecZzYyvWjHazSYqPCpJrUkLI=;
 b=UeF2YDYJv+qZANNdZAp3abbjVeEpBwWsa1ZINnzOxhA4ddYYQyC5es4A6DzMaa6uPtM5lRY41y87HJA/E2NKPV60YVwl+ZGrsa6fZJvO+buoXMN05EMylLFJNMiUp+AaM0d2kLAX/dFoFQXM2TSW7mf4/KHYXAKyykt4NNQu/v02HAQXUMaaw3+qnWfFWgDzlM+fPIH2KC2nd7RIT5ZHMG5vPeuh/ln48+0mwTPS6bYQ5MwGN2s56GEcOkU7ZAejfd2GRXoLT+RqFRAhFQvzJlwmh2AwfPxCBKUJmXm9X9E2TSgs7gKsLkqUrB9XT8l1MdIb/wqI75g8D7ONFti9Xw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CH3PR19MB8108.namprd19.prod.outlook.com (2603:10b6:610:174::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 16:11:31 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:11:31 +0000
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
Subject: [PATCH v5 4/5] thermal: qcom: tsens: Add support for IPQ5018 tsens
Date: Fri, 21 Feb 2025 20:11:00 +0400
Message-ID:
 <DS7PR19MB88833A24ADB76AD175E40C319DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221161101.17204-1-george.moussalem@outlook.com>
References: <20250221161101.17204-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX1P273CA0006.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::11) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221161101.17204-5-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CH3PR19MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f5855f-ddb9-4a01-1b91-08dd52926716
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|8060799006|15080799006|7092599003|461199028|3412199025|440099028|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cwqXKnTvnGfdv9q92MwybLA1A3Wg0vQvHdT7dOtXpx4f57PmkL0nJdRkRDNj?=
 =?us-ascii?Q?OYj9gueeDe/sNjOFectIxoOK6NNOaax56m4DdzkxSyFKNAFVTCuvwvhcPhwr?=
 =?us-ascii?Q?Rtni3jzW61ToeIbkHEsMi85lHL0kNGke6tnbPlgOeP4Gm9dyfdqEOf/PC4vt?=
 =?us-ascii?Q?QRFjbW26gR2WUS37mg828W8qvKQNcWBwSQJLWcEEu7purWqTSNB0QFzsGe+C?=
 =?us-ascii?Q?7mWWHx7YAF1/N9D6joRY3TrZUxh6z2GS5aA7enG9PhXuQojgnoGuGlvaW9fO?=
 =?us-ascii?Q?9a/4Scl5DDFq09yyeFv+vag+Fx4e4OSQttLq0zBXMZfROYamT6qVyXpMxFC5?=
 =?us-ascii?Q?COhcunJB+2+wJ4iwsBASSrugIB/KGHbSVbPJHLcg1wiTry1K0BJrROdQ3m/8?=
 =?us-ascii?Q?31TEFhdoUgyQKsmdno22yEknJFaBYd1zNS/MafeNwog8ALkvpu4Elt+MXL/U?=
 =?us-ascii?Q?tKtbpK02OUm52N4NqlIC2vfNleAmLhQzarIFvz10wlS8rH4pBqnpVzJTnCsJ?=
 =?us-ascii?Q?tnvLWHE9zAmgmcxEzU7KXG9sGh613apbX2XcjPoa7rBqRgQdgZcxHLM4Xb7w?=
 =?us-ascii?Q?jX9l709yin3hPRWIjZHy+/9dzOr2GP2tofuhnVbA1GfI9SuPe0EqD4iRgXBx?=
 =?us-ascii?Q?Y6QOhK+XNy6N3psPPomroEgr/3WAMSxkzN6KR7gTFJRiF1TqB5kUt7Huj02a?=
 =?us-ascii?Q?kbsdwtv101sd1A4lT5qeVszm/BFgcytWpKMTHJQ1Lj4XleP2CyflgB0XOcL1?=
 =?us-ascii?Q?UV7IU/3aIea1L02B5bkauEzVAiVNvT+0BFrR8EbdeQamrgQkIPGZ/EJUP9Cn?=
 =?us-ascii?Q?0emE2CvfFcerrNDDjalXk2gJbJtoy7ugbKWUA2xv3znca/cOsEWhqypOrAhb?=
 =?us-ascii?Q?fJeE6qJosy54CN+ziI2bzL4O68RMcICrzYObG/HwkFdYU6e8x9SvNeKqBQi2?=
 =?us-ascii?Q?aaVmc7NkPn7Y0K1Ls+aCoCf4p45PCgkB+hmH1UVJwkw0BOysCNjZ8ymugQeV?=
 =?us-ascii?Q?CNEYiuFqps1dPsiZh9qPUUu5EFAXAHIt7R1zJ/LgCteRrDPIj8TyW4v2uerC?=
 =?us-ascii?Q?HQHXePMpEtUEkR+NHQsKdUVbE96yBWpboYRhSiySYu6tgWL9B3sx2+1SQQGy?=
 =?us-ascii?Q?txUiYvtPGhEe9HtYmxaZ/kNDEv4sEWC3rw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E/vEtCWBIU5YTOrKV5y/UAgeHvY7bJuC3KAS0vpuYP2214r/DKJCk3RjXG7+?=
 =?us-ascii?Q?XsrKPADdnY0+m3rlQAOb/YYy0d616hNXjM7ABf/md2RtgYYxQu/NTchkwkqU?=
 =?us-ascii?Q?0777a7aVQyMv4Qu443qBTo6JL5/XUPsNd6dOKni9xvWZ69RlW42Q5uU6ufaI?=
 =?us-ascii?Q?QEgLwG+r0RYGFCryYrkJQDlknqIQZQXux4BmdDmEl7Zu7VNw6fFsZUx1G4t9?=
 =?us-ascii?Q?qZMkT3xgk/ke8WAJ3zDnrmOwqsKz9bmuBTWaglsZCsvRI8hD6HQV5gRkRMgQ?=
 =?us-ascii?Q?jON0jbsV6ifAfX1gynrE6PYAFfTILd4kCKiEjy/2AUx7bzCQ4n2U8rDPqBap?=
 =?us-ascii?Q?8nioCpsv/0OBZ/8jOVs6kubNmn6Ch7RazUROAdyQlBP9fXRhaK/ihu0sdmu5?=
 =?us-ascii?Q?cTz/vklpi7Oyr+CvE/7V/88Wr15cvheW6WipBG7X1B7h5Ik6oZKrA7ny5aLy?=
 =?us-ascii?Q?uvUPlpqRNBpD1HJpDl/wiTKgwiCKAviqET3voumvB+ggaSNr30ZOM7D1kxy+?=
 =?us-ascii?Q?UK7ypHoz0Gqe5q0DbWBbfQi/Rz1yZmnmGUNpt0PCb7GtPDM/28htYKSgDXxG?=
 =?us-ascii?Q?z7eTYDESUcNlca7US1bAGrIjCW1qq9T+EGyj+rwoBZNami21hN5q1WHLz5IF?=
 =?us-ascii?Q?kCPpw3D/zZc0dvP5eIt2YADoUWr654FArXrAlkUG4EOyEEv0jKr4P/yL/6pm?=
 =?us-ascii?Q?SLGmbeFqNaGp2esz5eYccyUmzJq30fU9r6UGSVrzYOw40LBQljgLeurTVksj?=
 =?us-ascii?Q?JuCwsM7zHeJ3JRouj0x/8UqtPRDOEa+cBjCa4xnYwSJEdqry1+GbP9q76C/B?=
 =?us-ascii?Q?bT7mQoeoEGvR+07hBNSG1Oj551iCbn4H0FnfFV07cAMLVG5dMyD5xUL4GU/m?=
 =?us-ascii?Q?RpQJkF31enPaD2Q3oKtpcC3KSfElmaBGhatAFvlu5QQq6fztn2MNpupXjNhn?=
 =?us-ascii?Q?4S4Z1ZYHuh081ZqARoj+7hbesWMZAGlkDyi3D35ZYqOA1yID/CfKjZD7gowh?=
 =?us-ascii?Q?WP1qvcLnXM+1He77q7Um5kJeYIw3Dze08rKaFI5qI3JIrMym7EDs9YvZAs1N?=
 =?us-ascii?Q?2+4vv7oHllsOoDrQ0Lz8G/XHmQ2Z60mpw4byDBwopwBCPgbJXYkG+YSsWE7j?=
 =?us-ascii?Q?oRJelGpiu5/q+ecsN/83puyDUozU+kBlcmtT7DrVxLYLTIg6gZDgD2/Sx03B?=
 =?us-ascii?Q?rlvs0s0zAV+KfK2nJ1J9/tmvLx0lWyWeyodjDHh5kgzkEt/vgj2/oaK0K0rJ?=
 =?us-ascii?Q?dbJbUXAFda10lPocVLUY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f5855f-ddb9-4a01-1b91-08dd52926716
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:11:31.0328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8108

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


