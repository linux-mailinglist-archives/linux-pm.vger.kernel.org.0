Return-Path: <linux-pm+bounces-23056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E41A47B6C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45941170DC5
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9D422B8D0;
	Thu, 27 Feb 2025 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sNdB60er"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2048.outbound.protection.outlook.com [40.92.40.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080E22B8C5;
	Thu, 27 Feb 2025 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654323; cv=fail; b=L79EnTG+t8h2cop2wlGW2iX7I7n4V38nciFznmC/52lPGWxo9eL6gFIYNZHeN1gX2uo/sc3vHR2JuXUnGaZyglJe0qg2iafyG5prJCRiMqPzyJg38BZ5KDLOIfi61tFqD16aWWbzglv6dMI1vYPwUn7UZuS40CsffXbIqNNUOn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654323; c=relaxed/simple;
	bh=ynVt71bqa4fpTGX2MdxlvWNHOQtI1SaFD3CEVtr1W90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HG4aiOUSJD3usFb/tjr3z1QNV/mVEbViycfRlTBqNxK/uoHNTcgpCI8CAW6YxG/o/5g8PixHpszCtnRPLvmlGplu2lUkA8JVuDuY0zj8sOKjYHV6DyYcmIOhYigEcaH/iGJkgpNVNktCrVOdzQQtih+XnzBoBRjG46qQG+mLKPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sNdB60er; arc=fail smtp.client-ip=40.92.40.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5e04r5n+e3wIaZ2sn4vN9VVbGhhRQ9g6vUqu4zbN+cJzqGFWjchJ4BMBYC93GhSlc2JyI7J4tILJS+Drc4rUd+B9lBTa9obCMzp+eaHP14yPbKwvitsxX11zK5WtZaXfFFxywOtu6B0fbHS+tmHwkdH+MEszAiKpToOBHNJj/SNneZAIVrAuOX5+/Vda5wGwLXds6Q754sh8T/eHr/zqd3cHH1WbXtbuWZOU1q/YePyUVeriYI3XntdbnGkic3PVjW3X2PY8Qj3kBCLzJeRjxdX3yqpRO3ZX0sTT1YJft5rk+GCv/JOtKQWfTAcMzP0ROLaaryrfNRvH3DPmAHoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAAUgNFEFDala+W7b7xfFJGdeQWkBlSnoDDVlGE1FfQ=;
 b=Hyw/hGOlkmRV+/uWPwEyrHWwY4MwIFl9jdeOSNzplP+VTih60bX77yUvdgQ/ro+HsOjpT2j9sdGQ/frgAHFMpGgdL35JJrEsqxxwDHnhtItCj8yqt3E3FwCOJLStEBvJfUo0WeX+6KuI4vRHFiNr/KFS8nw19BHn023uyMmqil7+bCKxvwZMxlbS3J3wjHdhKNdNZRMZBzZuxMz6R3/nHhmQ+4dMXufeLFjpT2Z74KMizZW2/m1ugSsGFQst8lOQgCtDpyGKD1dC8uczn4qtQQvQAd9mGCU1gSQZy4Q8YqoBfFzurdjVv21jddMGmdDtF7sXT6gOdraefh1qjoAzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAAUgNFEFDala+W7b7xfFJGdeQWkBlSnoDDVlGE1FfQ=;
 b=sNdB60erkU+ooYcI3WQVrv4proOB3E/gRPK5bo0B0+KesZiw62lU0qwGl8RdrBUMPcAmlmHtKmkw225xpjRB4HQJr4WNhSaFph0oJdf/qMSs3aXC6aeM6eGVW5Y9UAlXDycqi96M8K2aKOeXa0d7mcAFryuvHsY6N55t7gtB684xRd5Rix9tRCO36A1XJ0q0nyXz7ja/ByprmNa8tEZtmLBO2vFsXP8ZZgrFxsC19LotYMq2oePg53A2FrPxpGDMBwlbzImECpjSEHbI1djZccfP0gi62b64aJzw/d10YJKLQsWbb35YtM+UQuJ/UDJB1m8DBXldNuBJZoJUb2kaZw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SN7PR19MB7333.namprd19.prod.outlook.com (2603:10b6:806:348::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 11:05:19 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Thu, 27 Feb 2025
 11:05:19 +0000
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
Subject: [PATCH v8 4/5] thermal: qcom: tsens: Add support for IPQ5018 tsens
Date: Thu, 27 Feb 2025 14:56:42 +0400
Message-ID:
 <DS7PR19MB8883FE68B807D651C1AF41C39DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227110423.8418-1-george.moussalem@outlook.com>
References: <20250227110423.8418-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX1P273CA0006.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::11) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250227110423.8418-6-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SN7PR19MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b904f51-6fac-4305-da92-08dd571e9f3f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|15080799006|461199028|7092599003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IQfhYl3uDYATkC2NvjzYUhHN2ybDHvyFsWCUogxwio1qUtK1jRrK70S64RRN?=
 =?us-ascii?Q?v6YQpn97hfTmwnfhdX0CH5hWYAWsm6XE20FNP4vl6DlHvKt+enVMgUV5U6eJ?=
 =?us-ascii?Q?f+vV2gidEU5CXyO7d0zmLtWNAVKwgrVL41bjRb3gIJXHaYDEiW95l9P+PCdu?=
 =?us-ascii?Q?fPFHtrfEAoX7bzoxdrUUKnO4zl5jIu7BvImVQJjm7GTne8HrsXTLeZ/xF6Oz?=
 =?us-ascii?Q?bqlc6m1A9A7bRiqevCjxqOJ3nOcwr/KnzX1ztyFdoQnRmNDR8vBILeQmTJ6H?=
 =?us-ascii?Q?N0YOEHxaQeNc0+0u4E48XHYBXYsBZwWrLbscVzOGepOOrgCDpD7UFLloeHng?=
 =?us-ascii?Q?FcBo7xNlZCxvRVYg8VYBLhGbMpe6bMRtYz8tYZplsskC9ZHhB/uDgoMeSpdP?=
 =?us-ascii?Q?GyBvlcrFIFm2Zai6GGjlymt1j6DcD3IRkBuUG/xAXlyH4ElVJ98K+vmKfQUt?=
 =?us-ascii?Q?4gStaPyLtmZy8gdKmMsbdtue2K2yqlaFdVMnj5Jzdid12VdBn5hXNDBvEArT?=
 =?us-ascii?Q?dRFKrhOOKVU7VoZsAYzIupkpU6pf3oi1j9zxkrbr0aEtHOzng8OsuE1HRST8?=
 =?us-ascii?Q?a+rLtq1Ip+pOI9vV38jRO7Bln9R2j4eiHkszAUTnxEnQ8dnAp9BA6yi+5NYN?=
 =?us-ascii?Q?dImdXU1Q55pW4V8gvMwP6etz8tvnns+D1rkch2sXResIhnLQ5cVTIciIAmlQ?=
 =?us-ascii?Q?UqkubbMsFeWCVukrz/WbAG4quaP3FuJE+yy/Yav0WIjyFOxNY9G2ZgtP5wAf?=
 =?us-ascii?Q?owiSVIRmYb/4j7hvq0TAJMPnfv4GyAMNwfHibxjEo1aSFRMyHl0CovQdgXH5?=
 =?us-ascii?Q?oPa8dQ2paLvAPUbnGfE73Y5sERixm5mISCamalHB7XlYmJzqdbw8Sdlx2zF4?=
 =?us-ascii?Q?DoZeoGt/iZK8qh+GG4Yld6mmOZcDYGGLN3Bn6Giel2qwXh1WWfWFL1b7jlZy?=
 =?us-ascii?Q?QnMK1v7c5gjfJ0P70uNKGKY887SMlOhlEyUx77oQzhFxmMLyNhU6b7ib9ghB?=
 =?us-ascii?Q?RRXMYu3EEY/GbmrtHyHAUXnm9k2ePdw2X9My3V7SmDkUtefVUVPVidwEn374?=
 =?us-ascii?Q?eTJzGgkKG4hIp2kqW/8WuB1bX4UHJ2dmcAuzEqswromyn0mCusw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZrXyrkgAG7MOU5JX52XSAp+s3mo8Z/MtFv+CfVbei1kmIdTCACOZTpGVpSwC?=
 =?us-ascii?Q?UdCJarA7tAf1x/Aq7j9WxexIiJSQDuIKHYfnCZRqvAUMLzlUFnFeGPwf17KJ?=
 =?us-ascii?Q?oVk68NwN+Jjiy5odPvUEbhn3dN1Qshb03jiSyjZg7l2YiteuBlfKPFPk9KII?=
 =?us-ascii?Q?Nj0Qw4OVLHrINvG0XAOKhXHmjENsz4+4EcSzQnYJTnX4Gg6j5aFgLWA5fosB?=
 =?us-ascii?Q?gNwgcaW63wR1eRUc3WvxNJtMLDQ+sYCYRBRNlyFcCtmkLdPK62fEZEzHWfVJ?=
 =?us-ascii?Q?5Sg9aOXSSN6zyNV0lZML8sFAi9OqwQLCG5tjZkmeMGlCZB5hiCcJkDNTLobs?=
 =?us-ascii?Q?yb+rZpcYcKldVTt8lIbk3LmzEcYrj+bRhPAopMCOAk58EMP0G77Oj5q0OCvM?=
 =?us-ascii?Q?0vvByNnhNvc03bn6XsFb1yYeK2Ip2fgxEJk5+0tKVJ0PLSupBSVkSRx/Kq+N?=
 =?us-ascii?Q?mstpw2Ayx9OuYmprgIJxsCZh9R7mZv2mdO/ep/XZi+S+p6xdGurx8c6GrDjP?=
 =?us-ascii?Q?uMRSxGypUj0VSTEgtU4RpDhdImZ8MvyNkajzIyJUNS0xktV/IDkExoG6qO54?=
 =?us-ascii?Q?wLL+4H0GCtHcEDzYG+ZkIvM7/6mWnhNJP8rssGG/yu+q7VVvpB6mHu8xmFcr?=
 =?us-ascii?Q?46zNgHkXqxXf6M2hu5MqZ9l+m9Rb40qqZZJr++d3hyBCOGcFPV2zawFyby3U?=
 =?us-ascii?Q?r1bfj8EjqG5yC/detC+vg+W/DTFWUxkPAc186T0XpsgSsbf0eJPs3vNT45nu?=
 =?us-ascii?Q?Rbwr+zub7qftSMNXrAuucfE0lF83Z45EhUQ7J9E+uf1UeU6jucCEYeRO+/LL?=
 =?us-ascii?Q?uQo/P0gf9/tly3x93LiO/IOYtJNQt+wDUeOqA1WS3QgXQasb2Gwqlh9XNWML?=
 =?us-ascii?Q?76Piwwt+BThG2OFXOCtPZ0TNvonBt+tuLUDCFBB9n8HQRZ4a7IlV09ysvSEw?=
 =?us-ascii?Q?CHtYt0V5zmTIzgWzt/Qq9iiN2GsD6QVt5gJcPb0K+kjwwCZSVHkbq2f7jkMN?=
 =?us-ascii?Q?+0B0AkLtLRENG75xfsmB5XPiFLocUDWVKiz3AIahRMYC6aWrEbiN2Y3cJYRl?=
 =?us-ascii?Q?1oH4Ul1SjW9EuLOHOYwroiVGRFgJ2l14KdNmb3j7kacMwzanJsRTt8Xlqj8Z?=
 =?us-ascii?Q?P24UwFJUs67v8sYtUR8XM7zEO8yMgzre7y3/D9CooOsfeiGk3JGzBNab/+jm?=
 =?us-ascii?Q?mlZyQ/6qVm8H4Q439jgFlFAViAS6PE0r3uguBzNMQPw2ej2zunQfU8rh5FwB?=
 =?us-ascii?Q?UW2o9Y7n6M2uOVL+Hcyq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b904f51-6fac-4305-da92-08dd571e9f3f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:05:19.3697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7333

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens IP V1.0, 5 sensors of which 4 are in use and 1
interrupt. The IP does not have a RPM, hence use init routine for
tsens v1.0 without RPM which does not early enable.

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
index f860ea86d130..00bb4589c405 100644
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


