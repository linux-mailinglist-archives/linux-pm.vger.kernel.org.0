Return-Path: <linux-pm+bounces-17800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45729D33FA
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 08:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94535284E40
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888DC165F1D;
	Wed, 20 Nov 2024 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VNgaIs8X"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C26F15E5D4;
	Wed, 20 Nov 2024 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732086380; cv=fail; b=MB7I7VMesG9gFQVABASQMufIDxjV7NmFjQIkwmhC0SkpdZEEhyXzB7xwxeCx7v9tB07w8VKEhCqNWgsCanq5MLAGB+H6y7uZyu02kiKqaGaCpIQpnRhpH6U3DaQ0rrQWCd6SchYj6I0aMeyjyzjlpzmeKf9vO8ePthdOHFDIQI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732086380; c=relaxed/simple;
	bh=pan6r1JwaAQf4nfXqtYE0SENTiT+GnPfmzIJUNh+myY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D75Yr56CiFTm0oLNfNs8fjo1pWaJM2aNJVLX8awSvh45hO+oG9ds+AuVjj/DTkAbskvcmSleHb2LkULJpCajyoitYu5sGChh1hjdB7uDK6HF+WnGnty7243auZI5LGfBWqR45qx9+QKkXOxs0iWrkJMOKJWLhEsx0Hqbly2nH3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VNgaIs8X; arc=fail smtp.client-ip=40.107.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHcV2BF4jTx01VHJ/7xe4D7lPnD/2Qwah2C+s5EyP2hEIaPjpAYQfpjipIj0+cYpdNvQd6uYUTfD/hdErOeKvTuced8RiqoQvbAlamN4fJOb2R/VLqDec8faSl7G8fiFn2FJ2DcmoUi9mPfp6049N1YixfehaNzFlQgWvAFTYB+JE7Bu9Hr/CYLKJ8JOsan7hZo1xNLOeKCUM/P9e629GmlRVSKN9pttQvnBeay7DwCMDvBRGnH/hVrbcvRJXbu1wF8f61Cpc14cxhBCYiIpusZ6S5Xw6d/XtOVSiihJ57YrkVP3Xp2YH3f0TVb2cm3B3/y5orIDxNs4qYFYvdBjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mL6P6MihgG/Eyk3Jv8B9O2tfojXyCe1PZG/SLjVIpQg=;
 b=qRHxVTCnxocHsFk1HT1aHgW84Ah7vIzRPLirvjwDjJ8JIr5o9x9Pz6VpmNetJtMWNV3vL4C5wJBW/XqW71FVKI8o1HUGR5UVfK2FUzvIKZWz/G9EvfPaW2+FFW7tXG2qddjtzFO9VvfO9oaaHwVqxb+s9O2C2zMGbk25vLcJLVyNRWRmALK9oshY0+On0lvVzyKSSp+goVV3XSR/6tvmsxoKVkwXKSHB1CdmQTdxp9AGB4dA8tdM1oCbLHqIam8dmYC6+H4/CGSLslEE43nzBrbhEoiMyK44L8NEjn4IbeFSDQYwbViIQSZxyMptQGq1okR/69Y03IDqI2XCl3dIhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL6P6MihgG/Eyk3Jv8B9O2tfojXyCe1PZG/SLjVIpQg=;
 b=VNgaIs8XbwbKwmwtm35r8fJ57wWFCecBSmCxQ7N1j5QWjghgN+vgGdWnKJ6B0hA+MT9Lbwm/0g918pDe+0Fxs/r97CKXyCnLkk2wmf2NPHAWNgnfZ9kO/qWl4D/MH695eO5a7OzcWWbIbzRtiCAhReG+tSJlDyZ+KLqLp9RI0DhZBnkr0agqmAsPWEV4FKdOKHdpEYRUjHWUUda/iFBXEyCt8ucNhBZS+c973kETxVfR3bBuAFBo6U8yYLNNsZpXxZGSJZSnU2t6Hso8q1DMDYktg0aRFcNsnMVaV+0SJ9jNJ1a/TMCKOlLx2NpiLOMLlAwgP5awq0DwkpgSHpD6Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by PAWPR04MB9933.eurprd04.prod.outlook.com (2603:10a6:102:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 07:06:16 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%6]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 07:06:16 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: lpieralisi@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	james.morse@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] cpuidle: psci: Init cpuidle only for present CPUs
Date: Wed, 20 Nov 2024 15:06:08 +0800
Message-Id: <20241120070608.1314850-1-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|PAWPR04MB9933:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c21a0b-b253-40fc-f35e-08dd0931d319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V62D+s0VpTXFGcbBqTkEK9lt538DlJ5wpmpOV130c6+ed+xKbUw+x4f3g36+?=
 =?us-ascii?Q?o6xgGtbfn0keMPgaGb/IjfAEH4nHMmyDEnkC+2RVVf2Go8sV3YkORMrqfwk2?=
 =?us-ascii?Q?GsaRR3RdeCoz9ySjlwNS8NlBNdNi4B9momN7Y34sRdThH+81jLDzgPE20KC1?=
 =?us-ascii?Q?1a0FixXmUHr06GsD3nisy77nZ8HkR8X+R2p3OrKzB4FHvAhaHQdd/QkxKJ6v?=
 =?us-ascii?Q?TZxHlIDNLjXC/pF/GIaMnJqkTnI0PV3LCThVTGP/9b/x6Opa+CcNPp4gCDIg?=
 =?us-ascii?Q?bppHaIwOl5bAWKAzHxVLwELJckp8s+TCS9OcT7wk3oB8k2CoiIU0WUM/Y4z7?=
 =?us-ascii?Q?mgyJc30UJL/12YyfmugYbIF0cjiMFAzfHgJcA9Ecj6DBU9weAGKYylg/ewse?=
 =?us-ascii?Q?x3ReINcMve7IaG9N+eHEpFzPMsr348hq92Mr2co6zUbaP4FjYt5UFmRaHwiQ?=
 =?us-ascii?Q?HuaKr4UD7G8sG4TyH2+keW8sC+L/v4zHfRJBLT7qVRT8H3AZj33UrOOx/Qjo?=
 =?us-ascii?Q?kd8UqPsbP4hctKoTtZdvL76tM0XtxJU2Du/sltAaz4GdYv4FEIB5OA1rSNwx?=
 =?us-ascii?Q?L/yZmP14AtD9CGILJ+VQVLEmF7w1jwZ/R/ZxgkYj9qPVnw7jWMaQHbUFgMIL?=
 =?us-ascii?Q?S8J6DQ5VqyVsKXl154X6JWInAURYg4wQcOk2xGj8IPEk3ah+NP0u3DKTEsSQ?=
 =?us-ascii?Q?aZl+P/BCNJ82/V7q1+JUwpbVQRUyI/k4SzjQTJd1ZOzDCe/Y6akqx4ea2tYf?=
 =?us-ascii?Q?H72AtIdWuT8V9MhCBU3wlq+V8xeV4+4KliWGMnKD32vcql4SU+etr3AqtnYy?=
 =?us-ascii?Q?sZDhGvxi7F6md/whnUcQNyL+UqRscgO557SDU1NvPO+JT0JCiHmctzqdvDMe?=
 =?us-ascii?Q?ySPnPCYEpzdRRg3m0CPbH/P/beQn/uvwWg/K+5WqKVXQO0f3wvBY1cZK9tQN?=
 =?us-ascii?Q?Lt+V+46ujEB+B+y4ZSmn/7f3eovSgGjRoE91qihB7D9ymtcAccn5bfoBJ/Qy?=
 =?us-ascii?Q?OpKXVx/3YoPxYV6eXqkuKIrDSfLwQlKMn/1/Fk5Sd+WCmisqdyJ7DKZcvGC6?=
 =?us-ascii?Q?BgX++2aO5mzlCq97bK8AHObp6PnNckWpdfGi9DVtP/SC5xjxA0rDze8Ptv0P?=
 =?us-ascii?Q?DAQ+7F/h0V2PiofkrZbDRwGBDkvUHlsun4Gw4jcaxZW3SJp+ckb7+VbvKkIC?=
 =?us-ascii?Q?quR+LkQZubQLsSXZHB5RM5JUaMiaOqvnTgSb8kjIlWkL+snCVqDpxSLDDgo/?=
 =?us-ascii?Q?ZwnZGswLZBwEivL66n0Vnjx0AqtCx8YOWQLDazoC3O80miyjtsHFb7MRMBMy?=
 =?us-ascii?Q?711t8Sa9S6etMakzcl2i77yJA/eNg/Bt15i8DZMIZ1ZWr0RM9ITd04Bm5UhC?=
 =?us-ascii?Q?SLJcoyQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tq1tYPW0V9TYWPL75l6uj+J8jOpR7t2gtfbvsUbkv2f3Ne4RAGgpzf3F2Sqh?=
 =?us-ascii?Q?va806eSsos5fr1xVlhuo9jcFk1/eTJiymJenSIKOVKRVqtw2og9s0t/LBMcB?=
 =?us-ascii?Q?A70Q6sfngVFHa2McFSs1FHDa7K9GvI5Ml3v+bfax6JGwGSrOqBxor0D5PeVq?=
 =?us-ascii?Q?mmkCFp2HPokWa0HWXzq3WBrY6h295GU8phDdHlCmnbOJfT6Kiy8kQmfp4vkj?=
 =?us-ascii?Q?7LeGeKEs6vmIsc+TpmRkEz0ljgjpX9JQDwYldtTe2DDHBP47xymaVPl8q85W?=
 =?us-ascii?Q?J/jgELxawP96JhwPuTjGgbZ5Zw+ES2WyF0aVtLsS/wu7GNN33hpSXKZDETD7?=
 =?us-ascii?Q?T6OePyodOOPisn1A68+Qp4IBgyhfyvWOcSClu8pj+lFRvInSi55EnZAVQyzH?=
 =?us-ascii?Q?09p742CPnl0xuYObVi1SDryj2mBLU4w/95rD7cZ1t0oN73Uhfv+NldHSoR0z?=
 =?us-ascii?Q?ZnnDUhmDWfpED6Wx7mYZHhNC7iRLj/VGxLbaj4t1MyZfbeTsweR/k9YqSdr9?=
 =?us-ascii?Q?vsCYNUClq3eyDHN0s/7oTnpu0ZDqAAqEJEe3W5Oyxw6hoKuF2t54BvZp8XZ6?=
 =?us-ascii?Q?z6NcK3/tsDv6EjCUGIcLWGUAJYGoCuBn4z5ZgROqpSXQJgq9jJQk9pB2GsuB?=
 =?us-ascii?Q?stwtTQH2cci0mn9zOo22Nl+aIw977ftxab6hZ+kYG0UgOOuvzSC4nYEuGywm?=
 =?us-ascii?Q?QvvZzfrAhV+UEEjhded6kK3u6KUO7rMJovokbkRBidja7h88kZ88+7cfjsRw?=
 =?us-ascii?Q?Eds96CmXaqbuXBvDvOudSeGh1aNPRlA8kLAgn+ke4HzYtbbvX6jywAVGSH1H?=
 =?us-ascii?Q?pqMyGtAqbwW0mROAm3YvMaTNJM0kJw8chQRMi6ySrkVdGsV4sUC6eTsnZgGj?=
 =?us-ascii?Q?4AblqER8FFavGYKosLjxjp7izQRKxFo08u5YjK7qLojuTs/fZE57heOgYaiA?=
 =?us-ascii?Q?NONBjtcUabmBzdS0tjh64RzmNH9+43NRZ2r20+OjoKvRy2jZ2MBoY+k7bzBR?=
 =?us-ascii?Q?jqebXQRU4ORI2M2eQze9OCOoYQ0mv7H06Yv3pY8ec+UJxfTqCkIrg1Kz1Nzl?=
 =?us-ascii?Q?RyT5yvLvIeaUvHD2FKlh4FUSYcK8hSEPUlvuVzbp6oaNyesfDAZ5C76GSURI?=
 =?us-ascii?Q?cXkaD/1N93G8COvKUrc41+egn8Hd0wpmyEIhhCrFkr4tYiQiiP9vXSMfsL2x?=
 =?us-ascii?Q?yAJrj6924PEeA5XMKHyYgd2KnE8xB/4FO7bx27KUA4gxFEZCFzrywnJ9+YFJ?=
 =?us-ascii?Q?B1Z8Elgy/JTu68qgLPBR63nrmcioLjIsvcHWBXlHEeOKcdrQ072/yrZtn4gY?=
 =?us-ascii?Q?9aVv9Qvm/IwPh77jCkSRUKLiPAK7x1bIcmkjFBtCj/lkfn2zPVDkjfSBtEqI?=
 =?us-ascii?Q?8QuOOPIb9k0a1qtX4p0lzz0bFF2UmzOi8+VXXmzmnBZ14a735Qb0SJGtY9gR?=
 =?us-ascii?Q?78GP1adPZlYNTmFCC+a/21jayQDNfpH6YN1zz3q5QiG6R/lLw/fKfTHu3ffa?=
 =?us-ascii?Q?1G3LqHITI1vl9lI2MZMTXZdkveRWqJVigr4YmiuaseOLFi1NudX7ejsVw+Ny?=
 =?us-ascii?Q?Uc8oULVJTX6xo7d/Zyx/M9ncyHSICqsuBxfPmypY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c21a0b-b253-40fc-f35e-08dd0931d319
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 07:06:15.9367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Fz2rfiyxFsBj9+Qej4aKDxRJFdC2W+PklnVEIwt4YJLvUDEAg+0slHZVl1X8UnVcAxcxrpDxXYbAKSjr9w/eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9933

With 'nosmp' or 'maxcpus=0' boot command line paremeters,
the 'cpu_present_mask' may not be the same as 'cpu_possible_mask'

In current psci cpuidle driver init, for_each_possible_cpu()
is used to init the cpudile for each possible CPU. but in
drivers/base/cpu.c ->cpu_dev_register_generic(),
for_each_present_cpu() is used to register cpu device for
present CPUs.

When boot system with 'nosmp' or 'maxcpus=0', the cpuidle driver
init failed due to no valid CPU device sysfs node for non-boot CPUs.

[ 0.182993] Failed to register cpuidle device for cpu1

Use for_each_present_cpu() to register cpuidle only for present
CPUs.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/cpuidle/cpuidle-psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 2562dc001fc1..00117e9b33e8 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -410,7 +410,7 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
 	struct cpuidle_driver *drv;
 	struct cpuidle_device *dev;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		ret = psci_idle_init_cpu(&pdev->dev, cpu);
 		if (ret)
 			goto out_fail;
-- 
2.34.1


