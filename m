Return-Path: <linux-pm+bounces-33631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72934B3FE85
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 13:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 366147B36E6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2483090EB;
	Tue,  2 Sep 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="K08+nasl"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013006.outbound.protection.outlook.com [52.101.127.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662013081CB;
	Tue,  2 Sep 2025 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813566; cv=fail; b=u65+egrUTxBCt6dmAMyZiFXAmAgijo4u0KckZ1h2DX5zB6ZXC6RZy5M7a35oLq9mcHKtF5xYsT2QdGPtl+d2yTR0fskKDzFL3pajy7HJirtkeeYRXHA3K/ibfh2vQXXVwPz28MvXcdSlsqGpTaFl027qKq0io2eEiZ4IEnhy5tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813566; c=relaxed/simple;
	bh=6STOJBe4b33B1ClKzgZE1p+1tCsoB7Dytsbbkznl3W8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bSuIybq85Ovvn9zOC12Qq7V+J8fBrxhs3Db3mfF6nIC/V7TeINhoQifvKnKFF3eezldHXT1mK5hDF220RuzmhNSnuvz3hkmQFOBrAvuZrxD0PRN9eRkMggGgXt9G3FlNKOdAFepaphrQM+gHToJktQaOAW6vZaMAmBOis7KVr7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=K08+nasl; arc=fail smtp.client-ip=52.101.127.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gacz/elzdT0rYSIeur81tCVKTrpEliIYVrVkQun0PT6aSuhlygEN68Ml3/R975LrA8pv29Cxk+k7T9GTP/oGbQVOdliXTFdwgnIehsEcxLIQmXSru9gEEtqOCugEsj/+K20sKXFboodHbMD2nZK9BJaXwP0ZRwSqIXte1SXv0rrGbWyiEPfCEBE3grK4lnEMgSvw7MRXpe0gjcV92z/5EGVemsL+6XcvtWsTA+61tB+j6HlDeP8Gvgz8GLfEf8bC3KIDhiTvsroths5LYDQ8Q8zEs2WYt8UXuwAFPOydeDm1ZFTdvxuTFW+loKZGv0kn88HQRVDyQYs4RTjWcZxbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H1zRhILJ9FY9Pewfx3jKWDDJo0sMbEOkaPph8kvz7A=;
 b=xFMDTXCI5hVD31Fb1PG3HSfAWxF6LpN7EyClRhJ3D1WeC48XupS+F8VcQGi4c74Nyc1fAdq9t44KjskdnZtslN1NqOfo5JvKUVGhzZE0IlQ0yhFyCkmNV4RXAlqbpJqI99bs+Harc0pHXO31uxRMvoNXvw/S3vR16JQPU7G++08oqhspltz1NhX8OlhJQgNAm64sN3G+8PjbWg9kAkAg6OhKswtzHpF7Y9sfjSUTzP8ue8nPQRpdrWo54KZrbwhuZwrrV/z/gsmtgOYxXe66yuqJ6QEHQpmBIgfNboBH3XEpZ5oFIgotQZqm8N2WpEH6NXoQ1hLPEaLfp1mQRz67bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H1zRhILJ9FY9Pewfx3jKWDDJo0sMbEOkaPph8kvz7A=;
 b=K08+naslpxXUk0ysE5PWYBCh11T3kIMGqlAm7nqpVIiy6j7N1omQsZvUsR+OB5psU+srEWS8k1goUqZJM3cFOjcnYlIVwT/H5eZqVMHevHZl+WzN4103oP9DLDd2ZCD2jhkQD8gL3/qbkettqKMq9xt7nz3VH1L82UDYCcIpN60dzQcSLSEbAvEY0P74RLcRurOzbfEkHVKNvP+FUqw4qjOmyPa4/Ne4akUnaa4TNoALOKD4eN8QU82o26JnP5Vb2lmSqPOEIa/Y/yQ65dp6TlS4IIUUAj+2TOXkvc+zdBFKgdVh4omrTrB3FvAlU0N4g+5RWd9Q7W3NOapXDMn17Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEZPR06MB6256.apcprd06.prod.outlook.com (2603:1096:101:f2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 11:45:57 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 11:45:57 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v3 1/3] cpufreq: Use int type to store negative error codes
Date: Tue,  2 Sep 2025 19:45:42 +0800
Message-Id: <20250902114545.651661-2-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902114545.651661-1-rongqianfeng@vivo.com>
References: <20250902114545.651661-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEZPR06MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b34c68-b63a-4481-6e78-08ddea1647fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JJrb9Qr4bEtmBVrPYv4/8QxLbgB0ZQDc4zvC2WBYR3apgfBJgk4bWfP+pGRh?=
 =?us-ascii?Q?Zs42HgCbP9iP3DL0PBZ6StXPAK9Ss43bGGpyaiAjYNVFrbpBH0SveflDzl2g?=
 =?us-ascii?Q?KcdezN27SerNV5VSAwzpTAVu/Mhx0tZlBp5YfDu8rtL7Mmi5bC6t4iqajwEB?=
 =?us-ascii?Q?8liWr2ooJNXordrj6L7e8hVAgcflkv8dUmVM8ABFUkpdO6XEw7M7aI0dzyun?=
 =?us-ascii?Q?QK+NKgYzDsG8Ek5/Hj1i3WSgd/LQ5PRZiHqKypSilf2DJvjpt6f2xwccHITi?=
 =?us-ascii?Q?9E/yfMMyP42liXcSG9w9eapnLiGLguBms12YYFLUTl2lN8eVyMISPWOAsDxL?=
 =?us-ascii?Q?PqDETI85Cxa07gt7gVa1bXhcY6ZjJ1yEI7H9FSBib8r52/bgKLP+GEbmLKqX?=
 =?us-ascii?Q?IMj7bNfw5FgsQlhER9EbYc63QBOq2EKS9QcuJeShqQFc/yk/5mEB1rwjqy/a?=
 =?us-ascii?Q?N5iD1qXsehh2csX5vYteffKUQy5LJqoI8rPrHFkZUeE9IQqAQgF9/ppXFQ/M?=
 =?us-ascii?Q?fYSRvU4jy/NOFDYlkiE4gkRcmhKltcgq5WQi5wrpXnjJHOZECDPa0uyXu0Bh?=
 =?us-ascii?Q?cQFTGfSLR1gupBdoDcoynkUATMbj0VcSwYxQxJ9rxalPFi8ArQXkVtgOK/dX?=
 =?us-ascii?Q?9UUqPhHeiOtm8lrtrNgissPEaRvX3B7wKCMh/34z5iV15ZzqkLc/j1U+bTx8?=
 =?us-ascii?Q?C64slVnpDk4RjgvTNWYKKuBaJNoOhWhDzra0Yq1JnvRgLDiFrupuhzsbfVRU?=
 =?us-ascii?Q?1qj/3AcuhTo4mMhD1y8TWO9B6R1Y+vPaajv2VGVRYYBvavQ2Mvj25AE7tnmq?=
 =?us-ascii?Q?YtLeG/yOUuIaXNREPAvE7O8JTxMNLNo/eli0aMFuZietLveCKdcRNyX/WLm/?=
 =?us-ascii?Q?AENEMbZjgvvhsN990WipexoFnEKp4XNLDPx7ggjaQYy+LqIpWNiO5FPpuO6J?=
 =?us-ascii?Q?j3Pg/VmJLdMH0jfkwcXZpr5JMMwBid1+yNN0BkOqNZZsuCpB3uRmh/1uADVl?=
 =?us-ascii?Q?Oi+7niK4H1PHfuR0S/5Pz4103jeeomahVpNTSSQeLxaLjD1jcpF7NOhXBBXQ?=
 =?us-ascii?Q?Fr+6ot7jWgTdHM5mzUySAVFb+U5qouaAIGFXr6NVl6IQJRWie7mywRGdCE1z?=
 =?us-ascii?Q?2N3Xvv2Wm31XZMSeaH1xa1YFOOrRu3yPbBaXKJoYeTnMk6TaawF3agfSf8rW?=
 =?us-ascii?Q?hsrlU/O0wULqWgvcHrPwOFtKPysYeJRitmsgyv1AKJJfM0oQJY1PbSM6t8ns?=
 =?us-ascii?Q?ZVkFNR8y95CwP2A7VJH3IKIEa60lDN+zZx0q2rIUI4Lqvgx05xqyNkfQcHRB?=
 =?us-ascii?Q?OIGZoVH8Jb1OJsF65+bK53V64Arj++UXBbEg/O8zzkWNujb3j9RceizGLwuv?=
 =?us-ascii?Q?P3Wpknb+NCuBxNzoTS1og+IPCB15Y5bGnZ9HJQgaeU1eLzf2cDeSVvTMNkll?=
 =?us-ascii?Q?gGYvwLeUEU2S1kC5YshhUhWlLsUQybXxONQO3+z5cImieTdJzny48Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xYegOKWEAdD2rgnC2uwRVhsFqHXLUyx9j/LwSeGmcEDYvyaLYCdb2xmTzq5r?=
 =?us-ascii?Q?bZ/WzJnsLfzc3ABm3kpWpUm1iRIaNn7smvP0hiqjXqay2Zsu1keTQx7zx8T9?=
 =?us-ascii?Q?ZxVeP7pGQEazv9gF+JFe1zG5vmTWbGZA80DHBeT6y6W6MDYm/iWKKFtyGuu3?=
 =?us-ascii?Q?TViaTOIegK459xRKbLubb9YoeSg0E5r8V9VLntByJUya3Yo4STZ0P3gSdw4U?=
 =?us-ascii?Q?XugiPZIYykh7nbvSgaY9RU9YW4nuNGoVgMUfX2wvgaep5opP1bns3sKRjZjI?=
 =?us-ascii?Q?oHrpBEqnka/+Jm1Dmdl+tnMXPlnvQ30/QWfvJqnIKtN31BofK87x51cGmSr7?=
 =?us-ascii?Q?rTMWJtb7lSjF8G1H5WYJDUFQ7WkQjDQrh/eGMlb4RGfmJqMGa1AsJNYE2n/a?=
 =?us-ascii?Q?AzC17D9pm6/UJUtExnxMEbr4deT3Yx+9XK1rbMGVKVt5zdMIYLSFbmY4TsOg?=
 =?us-ascii?Q?iyVeuz4N2YOnWfuKqMX5QJL9Fkd9wU51K1eDo+5kgF/gla5ToV91IJjh+jx0?=
 =?us-ascii?Q?25eQdpARX9H1qKFWSqW8Eve0vMvUKo2q9aC1oGhH1ZxeyO116UdLtAFQYWds?=
 =?us-ascii?Q?f8+UdZpdyUij+eXLE6y9Z05jQ2zzRF4tcqtTQ1I4+wlTA9zBAFLWsbkxSkOL?=
 =?us-ascii?Q?696fRjWGBv/tATz6RpdaYqQCHc+3wse8sKEqc/smlWdRd1US/JQw333278md?=
 =?us-ascii?Q?tJEP3VROfBLEsXEsv53qTlGXf8uT9H82wlU82qK/O43KBhnLtHWd4BkXUxa+?=
 =?us-ascii?Q?UMVxAt0cElpQuP+9zZqDDwhWyNFu93eXJxZZDAz09zXGDM5A6RTaOEJ1gCvF?=
 =?us-ascii?Q?xHXbsOuYCNF6+xjwT97FTXDzx/MrOoYCZcrf+2ZtVMakbWW12QaszqldhOaC?=
 =?us-ascii?Q?4U1cNe+RkzJc3FbSIcOuKnNAfBQdbaWF0biBJgNlYOeue37t7w7dedANv7S1?=
 =?us-ascii?Q?tTQ3LE5dnPUc/QDd98CEK9O5hJAQaR2CK8tMBkhZwj6Sgd0iq4ddbfaT0OpX?=
 =?us-ascii?Q?1bNeZyMxZFaXuUc2LSBpiGttVXPDdiUu7C/RgaXyKF7J/2oESGg0BmQqUiib?=
 =?us-ascii?Q?CAlHqOnkx803KPlKiEE5c/Sc7qj1xcmu/3MVz3zoBPWu7WMUIHVPQXiNSmSa?=
 =?us-ascii?Q?KfUO74TEXoNCgkM0RjeNORwNft8mpMMraOrAZsIQCaQKc+7lebrSRHxWDeiW?=
 =?us-ascii?Q?pAdLc6pY5meJHX7kaftUbWvteTw68NIFleA2KN5dGy4EULUrwmNyOzWB0pS0?=
 =?us-ascii?Q?b1m4OQA2EHbV8cMyouzvreaYdzIQ0RNt9TxttXzmzUYu3AgCppUyAWiEfX2C?=
 =?us-ascii?Q?XwlAIrRy2uKOeLKa2busnMOGaQxTa4C4bIelITrhuNUnwddFAg3TGCjAbTsd?=
 =?us-ascii?Q?bFRJ3nC34HEZbV16WHNew7UupAJvNxAhOyRCIFCU1C8jzEVbClASS8WevkWB?=
 =?us-ascii?Q?PLFFAydu5ih1MsdbUAWiDHOQhaBMV5afE3zf772hYe4yX3OQBf0Iw1cwR8U/?=
 =?us-ascii?Q?jEbBzSlo3OKPCz41FT9JHwiLvBzaBOR7nAndc6RDIOUgAsxSBxfEedcbbv2G?=
 =?us-ascii?Q?+fcaTd8uR08/tFGy6i7j5Lv1oMO4YcCoSTrw8jkE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b34c68-b63a-4481-6e78-08ddea1647fa
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:45:57.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLjgiyWcYzp/8jWuAXgR5XPLKR2EGBj099d3sxBh3l4DutVouWA958qlFrcozoUFaHE3q0ghBQWDqND4MO+ahQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6256

Change the 'ret' variable in store_scaling_setspeed() from unsigned int to
int, as it needs to store either negative error codes or zero returned
by kstrtouint().

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a615c98d80ca..f47096683abb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -914,7 +914,7 @@ static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
 					const char *buf, size_t count)
 {
 	unsigned int freq = 0;
-	unsigned int ret;
+	int ret;
 
 	if (!policy->governor || !policy->governor->store_setspeed)
 		return -EINVAL;
-- 
2.34.1


