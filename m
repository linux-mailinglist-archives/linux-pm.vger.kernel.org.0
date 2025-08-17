Return-Path: <linux-pm+bounces-32475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E361CB29249
	for <lists+linux-pm@lfdr.de>; Sun, 17 Aug 2025 10:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAF3204FD9
	for <lists+linux-pm@lfdr.de>; Sun, 17 Aug 2025 08:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE2321B91D;
	Sun, 17 Aug 2025 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NunN7ScZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012053.outbound.protection.outlook.com [52.101.126.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130071E3DF2;
	Sun, 17 Aug 2025 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755419810; cv=fail; b=oiLz17RKiUeiE+zKOKfejpAxH4pWPLvQtkWJMRZrlgqARJw7xy7tNAjkSv2lhbqe+7XLLE0i6vkrpKC3NPVvi1u2C7L9yGl3hWqerqzbuoEQdcYhth1SVxn+PFuEmTBdYXiCGr+Gc/N3TmqGQkP1CZ1hegNvUPBBySaJcZiNyjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755419810; c=relaxed/simple;
	bh=onhf4mPejMm2IoPscA2LI0HEu9MJH3F9/WnnAR4GUPs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c5m8C+RfW6nxE6PlzMjHY9MXSu3OCVByFBxhFEy5DtOn7EbensWo2P1KgFTSoxhCtfaaKScah7G2ahuKb1fyVEWW1TkPKUyGuUGRIhdlZlSDautoIPk0MRerzYn7XHy2jWNoxVBnl+2n/7gWlcoHYvIdGsjnZ0Y9L+EoX/jWBVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NunN7ScZ; arc=fail smtp.client-ip=52.101.126.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjPgkwJcUWXopOrbF8QzA0/HWGA2C062JlkLhrOx7gWbEnbWxM/Y7uqTqmFmkxpy4Y8azEo1D/utvatif4vXy5za5hpRy/H4s96gECcrvrv93Ru+pAVgPDLG5IvswTiYLS0ndx6qRnhbjOvOC9I4cF1/IGSoiGqKcWB8cRiXyXKncxN+DGSAqSekLSoPEUOESBnkEGfgyQGfNbPaajP8asCnDAfh9mk/VaTykc8YSkLO49hIBw4VNtPFWFg+yZ9/bFVledvIpNA02QyiQnTR4CTR88zdTg/d1loia0llmXLGJqj2wozPBhU9ZL7D1oRmMscyl5qOvkIEh6636KkM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emk82Tqwygbgu+q8wPDGWnU3YPopNtEFRjiG44104NM=;
 b=LbZmw2kf/ARuOVcVNIFtADJHQkHXj+bVdNWjZfNMZ4yJbblrtN2wCKIc6MCn1GNNGnTXNmC3dEXqtMc1Xel5Prx9JZVvJ+ng5nLAFqS6gywCwARa7ftihjCYx6sohCDbb+50SLKAczqq3uZ9TyCZ7N9se3791dJ8VWrMctZPnndEP+HvxADVPHeVF5/93lh8tEVfH4t//8Ytw3bfyiu57feFoSor8XbrSzn1wCREJAawi7Ucu/Kl8V95wIW3PcEV/I1OafCaJ+cqX3DEEj3fmnv2LABmhVg2equYMmAm8xoJWWf5+hAszQ5aO1AzRnlSVfSd2ATZpQ4nakR44EGcww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emk82Tqwygbgu+q8wPDGWnU3YPopNtEFRjiG44104NM=;
 b=NunN7ScZEj4w1/NBmetojOwSn3ye8Xy37IxBCF5IzDbqEXzwSw3r/EPtlgEqY4DW7xJga/c9UJ5eFZFlSOjkP0UGUgg0rhfC0nuge1LLd0lwM5ik5TcXdH5sgduqyIl4BdTlb6PyCkk/2YB08HuTtuo5r7/0BLhE76v9iYW4PREAkYvJWGn/qIfeQ7YsU8M8LzCA56S7eaGTRduy7ilkiSeyHTOmRsNc+OZvcg77OwwaWQMlp3PKczyNoiAHlLmHEu4bazuWECdSgf/A5RUnmsPBJ8yPDaTWW1ex5hgXauhEuPh12p+v6SijZ2x2Yz6x90XLRC+Nkhb9BWAA2looAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB5180.apcprd06.prod.outlook.com (2603:1096:400:1f9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.23; Sun, 17 Aug 2025 08:36:46 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.021; Sun, 17 Aug 2025
 08:36:45 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] PM: hibernate: Use vmalloc_array() and vcalloc() to improve code
Date: Sun, 17 Aug 2025 16:36:36 +0800
Message-Id: <20250817083636.53872-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ba6833-eca3-4df4-29fa-08dddd693333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OzpLbUpfDFJcYikO5iJwISYCYdFscr0apsb3fDZowCz8YLvVmNt36dlZeXfD?=
 =?us-ascii?Q?7sH2QbJndM74mq4AezI+ON0scaJXqw/oPqtLzot6lIJYwFaWOAiQB0Ug/0RT?=
 =?us-ascii?Q?Y63zOuTaLeqG8nB+M5laIzNo8x+JEYpKuvKlK8qjXtSs0FEFtTeiGqkJQyPB?=
 =?us-ascii?Q?wdsVBLKQmpgJvoLi4ifq9MT4XqsPMg+glJtaKwOvPAeyoHaDAPEl6U7/DyRH?=
 =?us-ascii?Q?ZIvbBIxzMa0X2fHqMrtRqe7ROG6YLr2oTYc6koMXRllQ5NIjhtORrbnaVBDx?=
 =?us-ascii?Q?xMIZp7p8Mye+tyH2g3ZihIMUbZeHYqCXKpCmfUEJ4y3/BqS9LbQLI7iaQwFj?=
 =?us-ascii?Q?T+wUCuNnaeEAM1b1Ra3CEq5+o47I2vNSLneZVjJt+rWKI/7fop054b/sABgm?=
 =?us-ascii?Q?IaFpvycAzM5IM/DoQIGlbvDvprwbK2k14tCLR0GbSkju5oZp3MSfCgia1p1l?=
 =?us-ascii?Q?s4cmGvr44775cWlllb8HX1cRAJVK6ZmmAxxbox51Ez5Q3HDfqRBg/evAsdjM?=
 =?us-ascii?Q?iKwrlr4DeM1mLEka0lk77r05USZlGJ5+D5ibxQ48yqu91ZDHzwh+aTAOi0PM?=
 =?us-ascii?Q?Wz/AKk8gc4OnzqllIGKq2yREYZ79bVZSDlJS+oYYR7sRszjpc895qTNz+dwi?=
 =?us-ascii?Q?BsxHzepNZOHhKuSwk1/OFb76U002KBuhrbbPMvLtYS480AYH/YM8f2Gc52WX?=
 =?us-ascii?Q?H8Gwe0Jp1DkVgaBNgiH5G0gWeoMTS0pFGRtMuYKjYdP8NkIF7elmhmSSuprp?=
 =?us-ascii?Q?V5RcB3GpMcP/NCFFxE753q9kZA5obeq04ME9WBRjCWseeTcgWn0Hk4rdCfKM?=
 =?us-ascii?Q?zOiDfoI8qaOIZ9UGcizpw8V2jg2wKupPLqxVB1S7oMUr8k3BPZTfksnh83Zz?=
 =?us-ascii?Q?vE+Um5qGlNWmshTn+2Ihq0LolbzbmH8EG8X3+cTp1FwFTfgORYGUpRTWzaB9?=
 =?us-ascii?Q?iyT3B6msy27xyhx/oqlEsGGV3K1HF/cxG0er5MYaAtWfgRvVFcZnk5gB5ZXQ?=
 =?us-ascii?Q?ZeSLhsm5NYDO3G6X1WR8OEdRQO3z2XbEfFRW6ToiN0ngN9qhlkvj73l6kfj3?=
 =?us-ascii?Q?VdAcPgmvSvadIkC88nHVqdNv5fjIGr18LMRnYhNHG8mbHD1qIj6h27+a2zT/?=
 =?us-ascii?Q?sUDPxa4nqUm8TbvthXV7KNROCkZ9Ec8s+JyTZUlfJJJEH/y5uGFpezhu5q2d?=
 =?us-ascii?Q?jyizuod8cJ3tPdbVVOSOWjQe6gL2XXg66b2enUymoMDSOgPugXlLQHNci4lh?=
 =?us-ascii?Q?/d8ig+slPtsT13QtpO3sElAfGdZzbZqlnONU1eOw58zXLZy4FrUT5Tyt3s4y?=
 =?us-ascii?Q?yMGJ9MfExFxsA4fuZViW7MiS36ljwPH8FT4XmAy1v/+MF3NTRZpAWpoBwacn?=
 =?us-ascii?Q?kqx90PaWtoOUfSuEZvHSYBhjDrWgMA3tLVFUNOtMTtpP9DIOf4Uzt7tQfxSJ?=
 =?us-ascii?Q?8Dm8NM0BYjE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pPxWMSX3RBI3CbJTHFkFt+eSKrA+E3maghkY4pN+KNXyo0jwJX62ZUDKYLL0?=
 =?us-ascii?Q?aXanNbphAFlD5ZkY7ei+zd0Yfj258YxlIMEG2ajuXpvIXfa5zmLsw++ShyP5?=
 =?us-ascii?Q?p77nx36raJqt9y+tasoMPvVQLIuq1bi0FxAjUSa+5/Kl3i9FhO+2dk92ytZj?=
 =?us-ascii?Q?TxWZfAcP79Rck8pQ/QSjKrDs+mEmcPifK00P0SJrT4ao8grkHpbybzEdfM5G?=
 =?us-ascii?Q?MbSqmPd42fZO0Fw9aoPCjhxCLK26HzdcX2473OcoJnOht1v2ZkNhoLkqp3zn?=
 =?us-ascii?Q?m3xVarh6Foy3pridLnqcu9fl9yRd4LlmlcdPcyOIQlQWaa9AIWODBj7r0Djl?=
 =?us-ascii?Q?F9bHWpo02x0PILUhGKDJpWj/W9YzvC5XgpPBvWDmxU5mAjZ7lYp8CYLX2TrX?=
 =?us-ascii?Q?XBD+FobvobEGUIWZdAo23qR+APzHrbHBKKe85q0E7MSg4CC4dbRKPvwQDhk2?=
 =?us-ascii?Q?AoGuOCo/p2blq24tJ7F0R9G1/WjOGP9G1+ciMTjYHoXLbzXZyz5UjH3cqZsF?=
 =?us-ascii?Q?avJ5i8WQSBV0kUlNULa/pTEve+jOyUsqOPxOBtEp5UZyByxT+KH7Tx2He4ye?=
 =?us-ascii?Q?ien4Dwr9qxKajliZLwST32MJZu8LtwXDYKiTJxJqrBWViHiZler5TOP9XXV1?=
 =?us-ascii?Q?/p8B1S4ZscJTgBuJw1tJNebaxzgtLYfs5EeDFSp89L4iu4anlKm1yCM6VKd/?=
 =?us-ascii?Q?0e2Cyt111+3LvBXiUW/CNyesZpPgt2u/dmWJMTeOB9uozFG3c0DUstew47mi?=
 =?us-ascii?Q?OrBYMqm481F/8Jefq7UCiul4j2bI09mZ1e9JZgWMV8o+ERKSM/GyTJRfNDp1?=
 =?us-ascii?Q?kHRfZVjde58zPAsLPRw0ZFD4Xp5qjxDy3xaegTVezlAx2ffCCJmx55LAGpjU?=
 =?us-ascii?Q?SJxR6KJI1r5qdZbisRCTYSRsowQGslr8u1MquI1rk3XWCZCcON46QESnV1UW?=
 =?us-ascii?Q?tea2kSxzYmT9HtZVse7mxJFnLfLUJcxf+tqNwIJ9i4OvapjnLF2QRbBdUc/r?=
 =?us-ascii?Q?UVWxzigzy1xua+TakGUsXh4/HkeGl/SwCSCK51VjVhboQ2AZv13fCxLO5rz8?=
 =?us-ascii?Q?J4cgSlQ6xGElizXDGAzS3mdgYaTPD6OGS9voCetOuXz2LJD7Mxy+9byydyXJ?=
 =?us-ascii?Q?wAw2AxhqGk5IWHAxZE6xUZ4xj6iItCg8DvwROq1F2nZu4WFzmtyQxTpTbdze?=
 =?us-ascii?Q?Kp93bAk3oum1S2MCWAWbDMw4YJ/Wc0LDHhFWujoPe4AqmaQTfBgXqlNvSE2J?=
 =?us-ascii?Q?27Xc/k1QMnvDMeUjuQROEX5A4FqmMQTnwUcdLMoYVnQtYlBI2/5pQlYxwjO1?=
 =?us-ascii?Q?Lu3TizuoXtQQt3/CBF3/FxC/6RDbYfW5Xn7/tBAx0LU8TMWODHq0TrIn3zHZ?=
 =?us-ascii?Q?/EnXwcqHz131itgXQzBc7X0kasE/HMWio3Bjkdpn6MfPFIbf1myD9bUBfWk0?=
 =?us-ascii?Q?kvvhHNdOgHKKLmNgL0hlO6esP1Jsp1XXYN2fqcG1wuUt8daJpM+yeb8cDCLr?=
 =?us-ascii?Q?prNKAijjlftao/9O68Jhs0doFLHBuqk57ikpZYzTs9xW2kW46hwN2GzraBuE?=
 =?us-ascii?Q?q9IYPJ7RlE0yAp4UvehowEZ/sPieLR6QLF59ksqT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ba6833-eca3-4df4-29fa-08dddd693333
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 08:36:45.9210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrOJ1MBtr+TqaPVqPgP6x4Up3JhMuzq+xEZ4hQz9yH/6mjCEuNDUgmPWX0MaUkh4yndJD1XLwnWuqQLIvYmaGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5180

Remove array_size() calls and replace vmalloc() and vzalloc() with
vmalloc_array() and vcalloc() respectively to simplify the code in
save_compressed_image() and load_compressed_image().  vmalloc_array()
is also optimized better, resulting in less instructions being used,
and vmalloc_array() handling overflow is more concise [1].

[1]: https://lore.kernel.org/lkml/abc66ec5-85a4-47e1-9759-2f60ab111971@vivo.com/

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 kernel/power/swap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index ad13c461b657..0beff7eeaaba 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -712,7 +712,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
 		goto out_clean;
 	}
 
-	data = vzalloc(array_size(nr_threads, sizeof(*data)));
+	data = vcalloc(nr_threads, sizeof(*data));
 	if (!data) {
 		pr_err("Failed to allocate %s data\n", hib_comp_algo);
 		ret = -ENOMEM;
@@ -1225,14 +1225,14 @@ static int load_compressed_image(struct swap_map_handle *handle,
 	nr_threads = num_online_cpus() - 1;
 	nr_threads = clamp_val(nr_threads, 1, CMP_THREADS);
 
-	page = vmalloc(array_size(CMP_MAX_RD_PAGES, sizeof(*page)));
+	page = vmalloc_array(CMP_MAX_RD_PAGES, sizeof(*page));
 	if (!page) {
 		pr_err("Failed to allocate %s page\n", hib_comp_algo);
 		ret = -ENOMEM;
 		goto out_clean;
 	}
 
-	data = vzalloc(array_size(nr_threads, sizeof(*data)));
+	data = vcalloc(nr_threads, sizeof(*data));
 	if (!data) {
 		pr_err("Failed to allocate %s data\n", hib_comp_algo);
 		ret = -ENOMEM;
-- 
2.34.1


