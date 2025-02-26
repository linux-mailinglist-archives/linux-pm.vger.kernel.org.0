Return-Path: <linux-pm+bounces-22997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A1AA460DC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 14:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 898037AB8DE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 13:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6975722171A;
	Wed, 26 Feb 2025 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MMi+Jk+s"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2081.outbound.protection.outlook.com [40.92.46.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF11552FD;
	Wed, 26 Feb 2025 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576272; cv=fail; b=A4GTTt8aTIFTSVxOsludQrPCHx+hjGbjrQLF1gyicYgNmjjMmFChOSA9TwcVL8jsCUpsTx/hLaUlKLIXPyocffGRHjmzQguoOmEuPJ1jUCPboIXaBPCr5wnx+RjpNbgpjR5rTJGqs1OEptIiUM3fJUepErfLB/QW1crfFQo0Egk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576272; c=relaxed/simple;
	bh=9vveHA/Tn5WRAoH1fWB65WjMyu5xrsupMtR5ig8snMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d1B2RvRftPI4GUh5Q8qY5Ae7+5M9U2RYVY761tKS3+sCCmqm4pn4kmXlzwCxwZXZnLThNsbIlDSOBLwa9z1qxIHJXIm4u2s/edl96ftffxIG7nEKwR+kXxxgsX7EC2h953zu9cWu/4KBt04Tb3OyYM5aQg8owUmc4fr0tvSkxGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MMi+Jk+s; arc=fail smtp.client-ip=40.92.46.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V03Uy+WO0LVijIRPzv+hCszDjsGjxMZtaT+anuEhA5wcaQkBO3ZcY2TKR6dRlr0o1y3/oxa5/Jl7MT+azc833HE6GRKE0t5Y5WbcSEJ9Om3J7NWmvhIJCSD6bnp9hGmtYcjU63+xPdsHqq8dfYtyKeOygvYqYZXpdOyXTXOa9dGRfxA227+NeM+M2Z8+P6q/FxznLjd4GUg5519u23fxdUn8usSzo+F4XVHno/YpxwAImQ3QQLzG5ZuTCSGnPifG7sXiQv06J7UibAgQ/kdJJa3x+IfjofBlvxcuBfN8LI+sLKvX1P00LcmEw2Blqj+RQ28+mHqXxmDIIUl8Af5ZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvgcWIwUSMLfaR979jqEmbzlRYVGkQQxA3BeYPy8JDs=;
 b=pgvUUa1V/COw8GGagX5m9e8ZFJDEhesepABIGTqANvzVTtEeMGkQ3cjiZKXMvh7FnwF8fkOhKrTmo/pTH6sBOq4Gg3/5gRTvamFgMXiRdhk33QmecDXisb5b1woGK17ms5lhZmkCdfEoP+UDRy5PREYZKWqUyNBab1JyEUCHRKrd37OnoMXYTf6SfwFkwzGYz+VPE1Y5vzarQAjJMbjRhx3WO2GHrJJ1IUcTM+DqcQRb8mahHID6Hz3hmTTFj0vQlRrlPou4wOAZCHLd9pdfsKglYo52jPzVZXRMPkl0npJNeNvwjUx7CQSe7T6uQZ6JFHJ7D4+Zxoug6jrV2rXDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvgcWIwUSMLfaR979jqEmbzlRYVGkQQxA3BeYPy8JDs=;
 b=MMi+Jk+sLB5WHglRcnsGiMeT+AWIz1Ie/FNix3aY0AVXD8XituXY981bs0oAlPMG4Z/33es2nDrNVjPyeNc/GFIjnCNj3YgvPv0lPv0xsvQTQbuNx1PFdLnxrKQU4pgyRYodR3f2iKqa7HK4tqHtPpQeAdHhycmol9eBvdUl9JBCu9GfTx9qPQqgKISSCDZAEOgVX9rXu7sKBqC+qzpPrMoKLovjqWKoVdW6/fnFlQl67AlzPNudlY1IVTjJXRL5O/oHm9sKx/0lGmtPAeNpTRmNHzZE1qLbrwuI7g+ZABVOEcsY9wdVZa/D9vL4Lour0Qom0fPj61mGI9YMUMnkUA==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DM8PR19MB5270.namprd19.prod.outlook.com (2603:10b6:8:4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Wed, 26 Feb 2025 13:24:28 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 13:24:28 +0000
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
Subject: [PATCH v7 4/5] thermal: qcom: tsens: Add support for IPQ5018 tsens
Date: Wed, 26 Feb 2025 17:23:55 +0400
Message-ID:
 <DS7PR19MB8883A5A715F3FE834B6AD7269DC22@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226132356.9398-1-george.moussalem@outlook.com>
References: <20250226132356.9398-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0026.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5b::15) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250226132356.9398-6-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DM8PR19MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a35169-3835-46f2-235b-08dd5668e53d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|19110799003|7092599003|15080799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0dh3sf6CqhL0bftm3nokkW0XLCSJZtPU3vMjSqvTNWmqmHW3Fw+KjzMSle9R?=
 =?us-ascii?Q?f2845Arc8pGDTd//zhyCUaR5XYOagPxzmuUUYT1zBD8kE1nUrzTyYa6sl1do?=
 =?us-ascii?Q?BiydYoAty7FPB1nIox2c82U51/rBBGivMnLBFV56/MGPd53DjfEA9FzRhJHw?=
 =?us-ascii?Q?oWQyyK7MX9M6svGoQOebd5KWFY+SJdw+2vwYWYUFcInA9ublpZRi5uJhIfHQ?=
 =?us-ascii?Q?cK1g72pWpP+6QmwBEc/Q3fAujuXzWb2OSJ5dGsJqaLOKLhsKZT1JRZdyKr4x?=
 =?us-ascii?Q?/0u7yX2nOIDIiJIavEe84uyrzS85oVxOzGjXlmj/TPuosm9U3zORl7GiGt/q?=
 =?us-ascii?Q?BWHZtBlFT2V3W/glpO3RI5XRMp31bSsBzJCk37GiXYVACf8cTxuOA/eEd+Br?=
 =?us-ascii?Q?rmnZXKbfABV80HTtub1LAlS6RCqunNOD3x9Cz+qxD1WOu5uiKItxxsvudeee?=
 =?us-ascii?Q?bbbYeY4UxFG7ARtEt5s7nm38tbKTFopQtqNztgHZGcRoVuAElUJeTKFoc9AU?=
 =?us-ascii?Q?Bs7k7Zi7MU4Gxue4/bQcdKqy2+i4hd9FZXx8Jd0n5PCLdgezeqN/ZvEbp0ib?=
 =?us-ascii?Q?7U9WGCeKcrxBWJ6jHjsAd20eGUqjzTsc52Mh2TKfW80rn0dT/29OVj9F8qW/?=
 =?us-ascii?Q?nENcWdZeLgljsetiVnE118PA3GCwzA+IBKXUae5V5nNn/5m8k0ozMe3ytE7X?=
 =?us-ascii?Q?dAvviKyWUgwwApXKktA9E2PRGOibjaT7Gdg3HRsSEqltGZ78HvruTVgdiVqR?=
 =?us-ascii?Q?vaaYImIT2aTFAYitHX+c99hjx3SUKpdN8kIWWatLzTe1e3Da4HyLVXsjHnWh?=
 =?us-ascii?Q?hHWr5N74fSIzsLvdIYbsdzusNbDQ+5Vd22g68CmECBOjiiQZafqThU+xVAKn?=
 =?us-ascii?Q?vnFY09VHLeuMwdJMahggwleJ8+kcrp2UJyXrPyAaBWupbAlG8OZAeJMLWWxs?=
 =?us-ascii?Q?6cKwRnpst4GiznQLvQQOpOaFe3vPrwyhvM4dLt+IXxh4PHvitL6Lit9LRzuM?=
 =?us-ascii?Q?XRNwWqA8uapXlJMnFjQkN5Jano2bUuVtzUa4AGgnbtYqLorxkx5+RIrz1oXP?=
 =?us-ascii?Q?BEIUta12Le+UsIIc89KzejNQr9H7hUmxjLgpX3ypbKeK1I7QwIo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZsVkEwIJlJqrouTdqqUbrf1DiQ4ehXlt3eBnF8tKfVvRz3MPnS4p+sYedKym?=
 =?us-ascii?Q?v76PjB/Zq8jaSC4s7EMvc2Kb7ITkHcRCRXYSjk+J8o+Ft5A8ocgH6oGT9yIF?=
 =?us-ascii?Q?P/ZOksrv4xuIpVA/KU64qn0WOAdCGlxJJaJnHILMqpUwLOOT8vsFxSKnAkhR?=
 =?us-ascii?Q?jXgq8r1kWg5n60H7rYzTI9gLqaNckxSoLMtBnXdAzTnXlxQSNOVxjPFDss7/?=
 =?us-ascii?Q?615v+E/F5KxTbzcmI0FBAqBhZP6g8TQCLMj5W/GUdLSHcemtUms/pR+LolRa?=
 =?us-ascii?Q?wQk6Qh0j+zRvIX2M0OMWDdng2drNGJCvA2kpeB8WDnnXKCqp+hnqpGmhTmh+?=
 =?us-ascii?Q?Vhw4OBWQKepynQE7URFyqfb6nOziCz34dMR9a26pvCPY1m0PLVsv7JTZxEsQ?=
 =?us-ascii?Q?2EG6IMOrHrFTprKz2jBRaQTMRayzD2kW9sI2oC/TTX32pPJVhETtEV2K0VoS?=
 =?us-ascii?Q?eTCyhpCPMHkwIYBfQh9DABbuRIMyL5Iuc/N78WVFjpfWSzwBYygTpXilbtOZ?=
 =?us-ascii?Q?AuZ13U2FaFjd901CO+vgT4ZEKjmncGtc/LZl4z7GHXwszITP4tSngT5os53x?=
 =?us-ascii?Q?FLLTF6z3ac8p+NSG0xmiJg1xyhjLcmN60sACTWHZDbM6kx/7j4A4vfGMS3S0?=
 =?us-ascii?Q?N/vPEPLug6RpKWc872oJGw2iCR0oEpuLl4SpFMzAXCAAXnMO+U2WK7vrrYSV?=
 =?us-ascii?Q?T86xUladvOzItXJpUMTQ61ViZ3NHjatdlPRNYNiZJnypV5k8CMWVVThlsBdR?=
 =?us-ascii?Q?Sq8QSKHPzeRdpyOUfCNeQYpBvPcE7coXMQEkdwBPKxrXNbQsbIECzjVRTZS4?=
 =?us-ascii?Q?JiyZAuGPrPqTNlx9dj2RRjGyS/ifzidTgGUwJWLmbptGm8ddXp8qNmhLQpd1?=
 =?us-ascii?Q?ytC8VOGm9SXMQASY7EH+osEgYxlbbn5PMwi3L5r9ZUGQrU52kOmu10M6RKya?=
 =?us-ascii?Q?o7w0yEbLJNs8CgBzfInd2+q+bdW/xc+R0oxNP5nd5ZoZKJwxALkC26IoS6nD?=
 =?us-ascii?Q?EnFf0rXAvz/GdIyffAf+1dnfXXmfBWEab3y9MAwz7jMxV41uckJAlR13gU8D?=
 =?us-ascii?Q?i2LFSNAwK6Y2ekpF/OIik0Rtp3q9LvrOg116ucV2CHPKnRz7N4S1YvXPxGpf?=
 =?us-ascii?Q?GfrEEbbABoaaCgBE6lvavDEIrKWbkfhRQ/nOComR1VR6sbiLrBFJjn+xJHmQ?=
 =?us-ascii?Q?3QKHM1hnKnkh+Ji5FDATB7VJ3SKTfllV82pwezoVuwOiNZtRmyVE6WmoX81s?=
 =?us-ascii?Q?6gddmhB3Uu3E+XTSMDo6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a35169-3835-46f2-235b-08dd5668e53d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 13:24:28.3638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR19MB5270

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens IP V1.0, 5 sensors of which 4 are in use and
1 interrupt. The soc does not have a RPM, hence use init routine for
tsens v1.0 without RPM and which does not early enable.

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
index 4a0d35020b00..d45b053bf953 100644
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
2.39.5


