Return-Path: <linux-pm+bounces-32248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09B0B2435F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 09:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384345A355A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 07:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8022E612F;
	Wed, 13 Aug 2025 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WiyphPdO"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012038.outbound.protection.outlook.com [52.101.126.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049D2E36F8;
	Wed, 13 Aug 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071686; cv=fail; b=CLfgbq0HGbhWFaTnitIenqgfDoBtZf9Sc5zk8uOMnlIadhfIFm3J0KGUPD3y6DFUxb9LkzUyAGLfDQe2Dc6pYRXMJsexwSof3PJEq5Vv2Q4mxlvgRwoADjnFhN2HUgLMZbYx7Qp62LDYUqFgGd03zp9ukMzzuoiSSHOUD51DqCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071686; c=relaxed/simple;
	bh=osH6N26hLZWQFyRqzNjrdquFjBj3/d5br1t3yhlfV1s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=i4DSovC9ROD4++lvHTX4Rgl5eaHAMvXol30ZV9rBIyvjXcOhWU50VsYVdPnnig8UWs3+7bddx26gFFZHrnPW0iKh5k+tSYZV4pQUDYGBpceDQWeLjWXp/FvMKyA6So3MtfCmrX/kyx0xnb3TUMgb+dViTEpM1fqcqTU7kTTeKtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WiyphPdO; arc=fail smtp.client-ip=52.101.126.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6I1t6Hcf1iM67Y0ii5PVt89y4l6gzDdhXZJhxSuVAEl1UmfbzpyyXelOUlcdhauSgcXREVuVj/XNovnvaaMBztIR4BmTdCo8KI/5jU37JqjUFZfpZW8H5kzoKvUli6jTSxzM+CbbIFRmOrADmIeisprTPS803KP7zvYFpwiyBRaapZ6Rqe1D+zreWhbCY+4h3CY8U1I1hBfinl0rjr1h9aiws3bah/AjTagFd4KDv+D56ZjbbPCCSApg5E4/CGKX6JHNiqnQJGh+RdeKvRZclzFBRNLIglQevMaRdU4ua5bpTydTqexZYG7/AWWn9nHudKlb2Nh7q7JM1Im0Lllkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9qhmMqgfD00vmqjfyI4uC63WgKEAt7y5NNwUAFACYg=;
 b=fWUk+YUrQijlLf/wBOiGBkdj7IXn/GaciBt32587rKVluX/R6cu7uODOpVKlqGZGF8EELJMtVEU25xhPEY1uqU9qanYzAzpAQtmYaKMeVFpJsEqGuM16Fm9V4647hi60M1X1j3Y/60aMceZvfJ08rt442BDEFs8+rpOxT1umFxWK1pYmUjqsZxwNv00UG9MWqpPaydv5cuYLJvvVQARj4ZD/B5Pt03ksLyAooHIgwmltZ/vYLFkI9VpbS45L1S+XhNlS/dLHmZAU08I8IYMKbzlG0qx4x6+QAGELtAMv2RJmf2HLjOEetM9+Nazp7b3yuTi8D9vKUL0GMb/hgwUzNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9qhmMqgfD00vmqjfyI4uC63WgKEAt7y5NNwUAFACYg=;
 b=WiyphPdO8pUKwYVbT8yIW2tHVp6wYQNXPbAwKgzlGzFvrXe+eTTsvV30NHyolO+aMBBrXHUsd6eLYgLFMFBYp4oHo7DgoO6HgqzJzb910s1TggIDwvEBpaIQTcn0CuXPJjyOUke2SVDN+4Dk9PRtFIrjzjPxSYoD2guqcXi5QqF2wGcdapkITMBAj75uJ8aZYR2OoARTb+MHxqKGFXLL502Un/aacM4dvhrdvbI7CQXY89/xFqu/99L6ShFH3VpQZB3Vkc+YNU5jX1/Efz4eRTzUski7QiNWKkGJ1y/NYxszOeaJ0c4OcARPBtRUxCtMXiZ71G1LuSkwjSST3CuGJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB6914.apcprd06.prod.outlook.com (2603:1096:405:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 07:54:42 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 07:54:41 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] powercap: use us_to_ktime() where appropriate
Date: Wed, 13 Aug 2025 15:54:33 +0800
Message-Id: <20250813075433.464786-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 55489c79-e147-4b44-8eb6-08ddda3ea917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OBhu6NamcIyaBnPm5DxEgz2++CvbIV6GNKd/xX0Hmw/2Zu8/oRQDHKh/21vg?=
 =?us-ascii?Q?qc2IJ9YfiRNXid5LfAmTe2GBM4PLWrnG6rvo+cOwvemqTJJ1kTI1Bh5g3UxG?=
 =?us-ascii?Q?Y2GgMyfAJfpLpphgOURhxxaEkLIsAMeC4DPDBmSmIT3myw4E1MuZijombenb?=
 =?us-ascii?Q?hK0/5NaN5pbRvILOkVYfjzivoCrAJXHskO0TIqoaOyHKRsku0PFt63CQ1cKx?=
 =?us-ascii?Q?Q09TvIO80lK4rZoINPQs8oNFwtaS/52iDoSbE/Qwg1zUJCgrwNagNN023BHR?=
 =?us-ascii?Q?VabCF5kVcSBau7qKIuDkSNYSThR8MfWsprjhhvB8OqvlhkRElGo7/QdXyB2x?=
 =?us-ascii?Q?1+4/YDYgzMEPwlB0/SHNHnSjib4Fxp1oZf6HBaiiS5rJ6RyvQMaiTePCv4g5?=
 =?us-ascii?Q?xCwryhlAPL6oIFJnGAAinUK9tILOePDF4WUQ7wvxzA9O+YBGm6roEZxHr3SH?=
 =?us-ascii?Q?/mxdxc+ZXFTnjqx7oUO7BvHKZUiSvM0MCtR7yQ8BKfNRWrCOUtzmpg75wTiN?=
 =?us-ascii?Q?YvCSsi3Faif/SxQWPEAZ6hSZDL+sz0K53TYwaS8yjs05wrJK+2UJ8KI9RVj0?=
 =?us-ascii?Q?9bVBZtAGIGUMvfZoMEt7/Tz8oApCBRDC+DZNk4+SHkozyf5WKgluDtp4Rlhv?=
 =?us-ascii?Q?yQJXNWKbwNhr7jKV+O44w+z9HeqkiHkzoknMhj0Qs7X8gsDybHxDYl3yns/U?=
 =?us-ascii?Q?0a9qeS/2R8wMf3Ku+9l1SVeujgQohBGojMEvVBejKnEtKl4V6xbxfEmPCFi+?=
 =?us-ascii?Q?pMl4tkJ0PkMZz7d8vSh837H/NM4JZBAsrtOcqmXozcqC1L3nxIl36sGx/ZkG?=
 =?us-ascii?Q?CVb13hYvJOFF9I81A/QwQeNryU15fPOYW8VmDFjplniigHiv9Eg01b+KvsxA?=
 =?us-ascii?Q?qZKq5WPzzlI1GnDDVrOzcCMfI8S9dy7oXeRrumC0w7iwd3Gu7oAHZJ2ifT1x?=
 =?us-ascii?Q?I+21wkCkxub2lmrD0ANu3xuBUHzavvp2jGnhSPgFVfcVHOMGiTDAb0msVFgW?=
 =?us-ascii?Q?9ZCEBEeKABRoaTHzlW6PS9s5TVfT26RaMpCHfk01DqNbMmOivho3swqelXOw?=
 =?us-ascii?Q?2nKIiR0T8Iuu8pjCB/W0GzAok6KwvQwH7TVp/BEb9ixr+w2nGko/TVSE3INc?=
 =?us-ascii?Q?yILoruCd58oc/D1TxrXOno4MTTLis8CbJYKValgSjPwjPZZQ/cldqVgYFtKQ?=
 =?us-ascii?Q?Oe3tW4JesDCqPduPli0/OveRxidCnN7+h5YDeleHCW8O8ZBzMqGXRnA9gKB+?=
 =?us-ascii?Q?Tr4+VX4gxrDlfykvQ35it0dTf53LD6Oya8A06pe3ZZJhhanqRngfHIRpasz6?=
 =?us-ascii?Q?+/hqpGmdttXEB1XGMK0OIAihrOUFZTCBe/glLr89OYmAC6S69Z/kjAzUSzWZ?=
 =?us-ascii?Q?Fw2Z5i4/Rk5JtyXvjwigZNTzRwZR/rVtxVGJaWSJZ6epZ/yM5Z66sQTnhGCN?=
 =?us-ascii?Q?XwW6mY5xSz37APRDLHv7t0qjjClzRu4XLmDdEMlPh6dONEIojcGF3WDnfjuS?=
 =?us-ascii?Q?RieHwgTfUMq+XOw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cd7szayQR4znETqflQpLmNKEgrTXM5Bq/h6D2kPO+1oDAPxBDdcjRSHjS8c5?=
 =?us-ascii?Q?GDPYI3byL+HhZlAJTyOWoBItYAeD7mLLE4aLexYurgo0aB+rJ+xsb6rWpLP5?=
 =?us-ascii?Q?UySsC/YOiNJA4cN09D8gN8/BbmXMzbyMXb0VJ5w2ED93RHJnxFYIhS4LwCrd?=
 =?us-ascii?Q?3+la8X7NbVZeLVbc5qngIXUH6gWh7R/R13CN5fQW/ryiM8hpsreLSrs5p53t?=
 =?us-ascii?Q?xBzeAbFQb9+th71et4Xrvu/PJ/bvjQnQzyHGz3wS2Prnd67kP2fmZwArAtZL?=
 =?us-ascii?Q?T94iaucxAWnoZamfKAzcmZmmULY7Lz/MA/k4TeEjqVOjiAWd0bnAuG8orrGt?=
 =?us-ascii?Q?kLKpJ2PJr27SZ1xeXZa+HQcnTlst4FYEz/ohaTj4UetBRhnx9a2dGrDnwZLl?=
 =?us-ascii?Q?JQ/UyJc2rowMhqhTs/n7Gs0SSc6PT8I8v77MQQkDXcI9KI5BYyRij60QKeLl?=
 =?us-ascii?Q?jYAYUdhZcddmJbtPV5hqY1TXIwdoQUhpDmHxornQioF5X2HRfey4+Ezot9II?=
 =?us-ascii?Q?mHXQ+Kfr17hjMU1CFatauyQzF7P612ra1u5t/Lk4ulAgSf8rrghplmeW5hss?=
 =?us-ascii?Q?OOzNoJdLgZSwTruetXI8R95kmkCNp0gwGGx/xMn3l7gR3/1rJn4RUNEJPLl4?=
 =?us-ascii?Q?UnZ8wlf1OxhaDr59ggYvnPOGwQBjMm6BSUqjip2HRjespke//OwWRo0wR4Fl?=
 =?us-ascii?Q?QNikh3dnKFB5HRFzGwbultAGqIZXHqm5d9oINcG9DsFHB9r/+YpuikcIDaQQ?=
 =?us-ascii?Q?0FyJPozkBPAWvVtgVBN+pv2QR4TY32PkYNBmqeKchlWkA0yygHFHiqqnPtYs?=
 =?us-ascii?Q?Gm0RGAUT0cy9dpLZqVFz5LTD6pFubNlf1ElAvAqYnw1a8qCNy/ih7CRtr3yO?=
 =?us-ascii?Q?ldFFD2L8mWSkPJA81lxQ5M2xpsYbq9Wm4RvBqxHE+dAAXOtsraN8HDp6fXJ/?=
 =?us-ascii?Q?DOPuO34EuPuT4fBmwyARSU1hvG5U5lkkRMSD2hq6+t4J740XckaiHbsl4NNQ?=
 =?us-ascii?Q?k8pVkT2eoNxAQugpYezloqveLOgj/Na2sq2ivZLdv5QAhn9H4WBxku/Bi9eh?=
 =?us-ascii?Q?Q6w8YDCStktiZ4MRcX9F4N85TSdqOKfk/kPAQwf8Otsn9DxNodq6R9dtJnUL?=
 =?us-ascii?Q?l53fUFcRAYHLl/RBzIp2q5V8lAu6BOE3z0G68n4FUGztEAPEjOhxRaTe19hy?=
 =?us-ascii?Q?V03fmoc3G9K+VmfmtTdes+xLgNX/5Wf1t4byvwFYtVYbZcHIcUu8fk+zVBiy?=
 =?us-ascii?Q?2vk7VUVBCi1InUENKOyN/I7Wdp5MVgKO4g1vCvZhbe8b5aVE5oeYs+Z2D2SU?=
 =?us-ascii?Q?jZJZHFXQzfDj6OsT2Sk+DOG2n9wnFraCTU/li966Hosxq+yt4yZDcSi/KfdB?=
 =?us-ascii?Q?0OVNvtEjH0kCTeTmAxd4axpGg7zdV04hEVMtaH0Bq1dPnbhG6PN5C7KvhWSz?=
 =?us-ascii?Q?gl2s62xN164d1mE7mYhg9mIVRiELGpFb/Z68lQfahTfiimof7JWfuIFLbL7b?=
 =?us-ascii?Q?jPv90AEPC5I5/4xgrlPbe5e4mIyYO/h5XuJEIcWR1P1wFPrFOXuErnd/F6EL?=
 =?us-ascii?Q?Ib7iha5IaRbDQ6PmVxYjG0wPiQ9rXocOJOf+T5zP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55489c79-e147-4b44-8eb6-08ddda3ea917
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 07:54:41.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8hdjd/oupB5mlyUai7oXo+45d9wEk9/1uF9wnr+kiObQ0o3ko5bZBrFQyu5ALCz8CNfmOAfBrr0SMWitzOM1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6914

The duration_us, idle_duration_us, and run_duration_us are more suitable
for using the us_to_ktime() function. This can make the code more concise
and enhance readability.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/powercap/idle_inject.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 5ad7cc438068..a25eb2018acd 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -133,7 +133,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	duration_us = READ_ONCE(ii_dev->run_duration_us);
 	duration_us += READ_ONCE(ii_dev->idle_duration_us);
 
-	hrtimer_forward_now(timer, ns_to_ktime(duration_us * NSEC_PER_USEC));
+	hrtimer_forward_now(timer, us_to_ktime(duration_us));
 
 	return HRTIMER_RESTART;
 }
@@ -232,8 +232,7 @@ int idle_inject_start(struct idle_inject_device *ii_dev)
 	idle_inject_wakeup(ii_dev);
 
 	hrtimer_start(&ii_dev->timer,
-		      ns_to_ktime((idle_duration_us + run_duration_us) *
-				  NSEC_PER_USEC),
+		      us_to_ktime(idle_duration_us + run_duration_us),
 		      HRTIMER_MODE_REL);
 
 	return 0;
-- 
2.34.1


