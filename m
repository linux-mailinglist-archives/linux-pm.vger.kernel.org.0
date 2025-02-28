Return-Path: <linux-pm+bounces-23149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AD8A490D1
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 06:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC433B640A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 05:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806271A4F22;
	Fri, 28 Feb 2025 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Gf/dW5Kh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2077.outbound.protection.outlook.com [40.92.41.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8536632;
	Fri, 28 Feb 2025 05:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740719782; cv=fail; b=OWQx8KCxGM5s9GgK2QVvlnCUQnVEHnVWa5RXrAJvNkvaUgvrVU68sPR2dLGkX0TpUcPQ64r1RaXYFHkPwZmTEPmhXQxS5MSItgte5UXZROaULrx72gi7VqZxWU+oJO91kJJ/MiSKmnaSYashS8BsAsXLfMYXrPs/doi6rSts1Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740719782; c=relaxed/simple;
	bh=D3rX+ZRQBLxaUdr29fqdGaWZPjpbyUOgOuKxfyeQnKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fFj8mDvGIG13mwBfBz+4rkPLt7MRdmHO/BbXr7Wsrls2Ol++SJzkXi65+Q7fTbLIkyxAHa6nGlGD2GSBbpwS41J0rcos9k104amSUdwWYAoux4xktAMen3H1eEZW8uKTKc90zDTVJmVtgHQC/Re9XXzN5gzZE5J0KXfFINqD2/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Gf/dW5Kh; arc=fail smtp.client-ip=40.92.41.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJz8YMgINw9/jduu1/t8qAuyy3JnlTjX8eopo9c91W4tKOBFJqj/3nNlV1Goz8e9bsmIqVCewAc7icpt+tp22mgNy/bxLkv4EjlaLk+iayL4WX7ZgBKuOdHMy2tv0JHXR8ysCMU4V+EsrgRbQ5Xvm7MVo1JO1XjnVbAv3x9N2gj+V/Jd5tFlwFK8EyFw/eRlFSDREA4W2Zecls71sOEKWAjrK8uHc39wSzIe7yFoOF9yOlpRpoHhPRu85rV/FQyll+EUkmoUor1XTHdNQvx0NQceiSkiwR1zrEeHj3ZF7k95PR4qv9x3yn547RQIyU52bYSS+EQFmCU0/nm9vlzT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0mxnbeZj7JH84QPPl8D/+PsQz59Qxd6wKqbWycmtZI=;
 b=S4YOQyLofQiPha88GMerTAal70oiJqcWeXcpVG8vuCCfjfAmG9oQVY0N88LIrZRRmmpREKpGslvfUrK0dl9//A7vHIs1U+VsLi4fRqiPIFRXG3mxvnOZWAhx7ZpWLpDIVfUnNnMkAlvMjeA9a3I1nV5r1EFX/jv8KdaiFaAVihQhXQMNpvqW/tw8QsLsQMq+/8ifmPsfGP1RBp24VlEbFCqsp7lRIYbIWne19a81JWMOUsxm7WvOevgwYGOP+rMb4Wb5bJhzSHfrHAUjU+S2K8zdrowe0FlORf6FQBukxMOJ8h3SAZuUaHYh1rrtCSoLCpz0ztKBY0SRXxJLXsJNvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0mxnbeZj7JH84QPPl8D/+PsQz59Qxd6wKqbWycmtZI=;
 b=Gf/dW5KhnKMRisjGepKfEZewP1IUItWqO4iXUK8Y4liUrbQ/K4GbvSYMwBgEn6gYnDsY7HXtXUWuhsYsR7lbTGt9mYiCTYjwjxQb7sYaHpd+0IX+MbCAwYbKwuzw88kW6/9iw6i2MiPJZw2/j+kwImZ6RLzjn2InfqalBYfY49BX1xJJLtZ/ZV1JlTwyZEShkOFT7DM/yf/mAQ3a/vmcn0cQcoopIUSi6re2nDgztCgf9bJcev3FyBa2ZivW+2OcdlByOZfv4KBhvQtIXNTXXJu9O3MGMX7+XlO0b50/mlVyjD50RNsXzrU+c0vPDuRMe0yL2KM/1hsv1sxerYY80g==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV3PR19MB8318.namprd19.prod.outlook.com (2603:10b6:408:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 05:16:18 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 05:16:18 +0000
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
Subject: [PATCH v9 5/6] thermal: qcom: tsens: Add support for IPQ5018 tsens
Date: Fri, 28 Feb 2025 09:11:38 +0400
Message-ID:
 <DS7PR19MB8883BD0E36C08DD1D03CE1CB9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228051521.138214-1-george.moussalem@outlook.com>
References: <20250228051521.138214-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0006.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:26::13) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250228051521.138214-7-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV3PR19MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f947a2-7c11-49ae-e8e1-08dd57b707ff
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599003|8060799006|5072599009|19110799003|15080799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ONc1aB0F6j22UoYhtRwCpX415pm9DQDjH8owlcZfZUNpVJ+E0hWHdtGU+I+6?=
 =?us-ascii?Q?nU1vyjVJY+u3F5SSsoW+aoSr3aItPM0qB0/jvrmq3Cw2Wzx0Ai6/LgdWHSX9?=
 =?us-ascii?Q?UFeeNrH+c6vxpM/ivOrWnAdsBJOMxuYvAK/6oMIyAC1XJ09wAtPKukVs+UYY?=
 =?us-ascii?Q?nPVNism8JCYg+TTS6uf5968xMFYiMBgYcKjmjNiXpb6Nbh1/Q5NLygNMQmZi?=
 =?us-ascii?Q?NVz3CZ6216dWU53CTPZvkDsON6oqAJquBWnvmClvdFk4ZncufuBMnL7RbwD/?=
 =?us-ascii?Q?6769YfC5VE8w2xjVkO43To766Y3LtUf8p5kcVGr6YsqdFfOD39Brdvyr/SU+?=
 =?us-ascii?Q?OLRfVPsfgIwyHDdQu2qPe3xlmXYWzAuy+gN2q7Iu8GqwIc7zR9AMOEcGBR60?=
 =?us-ascii?Q?fpgNOzW0ZKkY2ab/7i7RZJZk6S/DrrlIpbQ9rP3SCm/AEb4zsAFSVNd7wNoz?=
 =?us-ascii?Q?QZ9/1crDPngNrQx8MHGyihAbsXIki2URzKcu7jvwfJGjGSJREnrI/4tZDkH3?=
 =?us-ascii?Q?fxBb5ARGYGl+BRX0nZtoExJEJDEk3eCcgfhnkwOSs9m3NoCRfPh9KppD4hu+?=
 =?us-ascii?Q?Y6MkxL/F9lhfyPSJEYXEN7G6dpeChsXBIFlpIIjOs/DmwLzMPqA4oiv72sRO?=
 =?us-ascii?Q?YX6UGxNPgXN7EXP4Iqv6BvPyfV1JE2gyLdfmD2wy3bFRBe7TsC2mA5bQsbOH?=
 =?us-ascii?Q?W2UyD4SIy59nSDrZ84El+FQ6zKbiLXKPiHd80ouOAIJMSY8I8OZkGpa49BKW?=
 =?us-ascii?Q?DIxFLzKmFDE390rtBG1etgVp4stortXugOg2vyAaUaRPLeWCSSZLrzeAOK/g?=
 =?us-ascii?Q?stW+5EiKI7faePm3bljq4VfFuIChj9r6Uz9eONqRrHpbY4SCoIHrFAxW95/Z?=
 =?us-ascii?Q?ciBECxsqrxi2ROvFGzp2xMryx15VaJ7xCKotdOHGxClHBO06xDygqq/Ovw8v?=
 =?us-ascii?Q?lD7GeXkZNZsW05byfLU84EIrKyKi1sS3yJj76Rgcr6yH6rw8ZmjpoPjUdcjj?=
 =?us-ascii?Q?jyNPsUcN9U3KFZBjU8mubZvj8VxbIFUZRUmTxToKdd/4QJNzglsWWSxcD9vZ?=
 =?us-ascii?Q?bdqA7OS47jSkaGaXhQIR5wTBHgdbG/6+yHWw/Q+AYjl+wtX0K9Q=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mbqoyqBAvNTtk8hnhE8HIcr8/URAHDzcdF8NLQhdlyDXUMcRuncnCUxvoDBd?=
 =?us-ascii?Q?+SrsYOqGPB7wRwtX2TwOCSN92/ju338Kj9Uct0MPNQhuPPFEBKRoFhZsGdJr?=
 =?us-ascii?Q?p4FEDoEt7tbbYNeKT9ThiaecU9iMaISKsWxhKILgwLfeRX3Mhb9TJfp5/lpk?=
 =?us-ascii?Q?jsTTncR5/3QK1kbPNNYm6S8T+uf5Y4P6aBnH4pjaKTxA8XOhvmxiWgT7G/Bp?=
 =?us-ascii?Q?JcZKUkCeNi/IQne1BgxxlQOEqKZZOy1SHdCPDBVQ2gGvCLA9ITuBXzDKKWcX?=
 =?us-ascii?Q?G+PhAuJ7qkv6jIz5ttvXNY6Qbp7Y7dzW44zH82+EGTXuvg466XC+HC96D7qV?=
 =?us-ascii?Q?wlxCSm2SnaFYqMXTTgwVEKJ9nmPimmmrBtiDbEWVAPP4aCRPPHPWtyLSxDEu?=
 =?us-ascii?Q?Qfc5bY7h9+r7fA2gmY9CBer3NmlTrggCejAGdhn5fhrDwf5n1mhmU1rxh2EY?=
 =?us-ascii?Q?BVMgw5ZzIw2DtQc5ftj4m8Odfhe7DDmr5Pdkf2cWvs2gQ9T00v/vLVi8kU8E?=
 =?us-ascii?Q?aHsslWYC7VrjvPC1B6Bt5Mb5ZDhRSj4qRZDxUt77GbuhSnozLyw/vcFIcwGg?=
 =?us-ascii?Q?/ddsqr/yjztAa0cqTpKoNCRkQXo8Y3q03N/V8eNDG9KL6idcRNjBprb9CEKu?=
 =?us-ascii?Q?oKHhx3Af3+2fWDp4dWFOvF0f3cOoXdWu9SY18r2BqgS1h6kVIJcC1yCypJLf?=
 =?us-ascii?Q?NEioBMcdur05HWe/8eMI7dCTdZ7lNym1FEQhukg1T/XIUURNq2ZSF37/Dn6j?=
 =?us-ascii?Q?Yjrl91NP2s3nK8GMfqTDW0VZwxyVj44wQs+cPoi+JGtb9o/SQyRlbty7zStE?=
 =?us-ascii?Q?DoDq31AXRg+Cb+Xb6NOFg5tESznrG5iL+7kClO872nE7kOYH7DI1oe3ptmXV?=
 =?us-ascii?Q?KlJBbeLUqbabDlntrvtN0eBqLz9lk/+I2EEVZHpsNOYiLSdeyZ6JPua2iXbk?=
 =?us-ascii?Q?bkrsEs1NKUvPXklm7iHQaUtk6rqrCvxe3fhOkCbZ0EicyYVuLPnb8cshNqSb?=
 =?us-ascii?Q?48nQxXKN2tGJ/+quOxgClkVoVQCXXLB1dBxv43cXwdB+yh2v6HH/wBWeXhc0?=
 =?us-ascii?Q?UDa2ldO1maANk9NSYs2//XJJ0knU/Nm/Uff36VTht3vbbdvHI1z3CVLEU1EV?=
 =?us-ascii?Q?v897A8esYhuiXlf0LjibCGtD+cInwlju/V/bB+13wXorMO/XI5d4UzynsQW+?=
 =?us-ascii?Q?IiUTpGCT3Zhlfqc5xY2WRD2tLeRtB4QN23DzeiFDfL2XMXRV7NpEIYRIW7W7?=
 =?us-ascii?Q?CHxmIIrsxFnUXM4ULbQE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f947a2-7c11-49ae-e8e1-08dd57b707ff
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:16:18.5293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8318

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens IP V1.0, 5 sensors of which 4 are in use and 1
interrupt. The IP does not have a RPM, hence use init routine for
tsens v1.0 without RPM which does not early enable.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/thermal/qcom/tsens-v1.c | 14 ++++++++++++++
 drivers/thermal/qcom/tsens.c    |  3 +++
 drivers/thermal/qcom/tsens.h    |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 877b27274fd2..27360e70d62a 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -242,3 +242,17 @@ struct tsens_plat_data data_8976 = {
 	.feat		= &tsens_v1_feat,
 	.fields		= tsens_v1_regfields,
 };
+
+const struct tsens_ops ops_ipq5018 = {
+	.init		= init_tsens_v1_no_rpm,
+	.calibrate	= tsens_calibrate_common,
+	.get_temp	= get_temp_tsens_valid,
+};
+
+const struct tsens_plat_data data_ipq5018 = {
+	.num_sensors	= 5,
+	.ops		= &ops_ipq5018,
+	.hw_ids		= (unsigned int []){0, 1, 2, 3, 4},
+	.feat		= &tsens_v1_no_rpm_feat,
+	.fields		= tsens_v1_regfields,
+};
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 2cda92f3d125..a2422ebee816 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1108,6 +1108,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq5018-tsens",
+		.data = &data_ipq5018,
+	}, {
 		.compatible = "qcom,ipq5332-tsens",
 		.data = &data_ipq5332,
 	}, {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index e3cb611426c4..2a7afa4c899b 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -652,6 +652,9 @@ extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8
 /* TSENS v1 targets */
 extern struct tsens_plat_data data_tsens_v1, data_8937, data_8976, data_8956;
 
+/* TSENS v1 with no RPM targets */
+extern const struct tsens_plat_data data_ipq5018;
+
 /* TSENS v2 targets */
 extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
 extern const struct tsens_plat_data data_ipq5332, data_ipq5424;
-- 
2.48.1


