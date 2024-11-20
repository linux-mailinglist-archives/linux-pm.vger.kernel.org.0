Return-Path: <linux-pm+bounces-17806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C91D39D3880
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 11:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A544B21EF1
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CECB19CCFC;
	Wed, 20 Nov 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NnfF3YC5"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B6819C542;
	Wed, 20 Nov 2024 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099086; cv=fail; b=SZNaAOu8MTcnX/0yCAzO26nakXD/9NtEvnME8883NE3Ll3skVcKCvGipFi6cCSNHEPW9i78qwb25WWGFcQoSIIhJ1DVEGCcOkllQ576wM+c1WE09BcEAwXpzf63m1YH6gcE4CTWUUR4eMQGtTC+MgxMZ0RMP10TXeDjcZmGZK0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099086; c=relaxed/simple;
	bh=Xa/Ok9AROLOGPKWFoPQchr9F8fo4z6iTx6JIvufR2gc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oY2pad7zgiaHt8MYwf/HXLKcA+GL4mI3Sza9PZdWtvZh62St3mD4LyHyGTonvltuCIMPAxugTzuYdeGLlgtKPHeLMK34hEugauCF0eDU3DBx7V7vBubgYvfl+H/vuLzQ1CWorW17J84Uu4MTPCLRPlmJR9XFkI5xNmDLWTvTP3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NnfF3YC5; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFTzR14zS/9JlHz8mx3UDUN2x1lWjLXzZ4uV/Ptt/6rTYQZHEV+/KlQzy50zApnMTpwBD2tPcW+mEdT2CdaVrtvNcJV8Z0DHlHSRXXrB1A0hRb/8uD0R44godwRYdAt3G72a5a5W6g/uYU9UgVdUNhW2HC3cyG3+80P7l0WaVgRPcuQROttrlRQiKDQQe6R0sBxXSAxCO22M2X3LXgld77mkaxcfnFuFrD0k8YgNM/B0eMlnnasJKgaHufjeh6ZYAxzVtmDxn4HSG8OS6fAYXWlHBzzNQf8xdFIKuIF+5pGZmFwYPBxEFDMhecLerXrDGbuEDp2I0BQObHt4dS/U7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXsFevkNMNX6BhJbVRjzF5PlyoCddsLPpl0DppZ5DHw=;
 b=pK0zM8A8xERYuPwkDTEz8tbiTmXRhwcSkR/yEgRJ0PMUWk/GDYNQuECxTpwklS8BUomAX+V5XoSa+3DPhUPDIsjRqidH+foFukMMsvHOq6OkuAsYc8s+Y2rryKP5XXRGciD7aK9qeOGLj+lE6ecFkYwEadwh0KPoPwNunHqjx+LaEnCpLKbEDaZcqSz5g1Vt4dTn8AFhl5o+F6Rs7lXDZ16YM4FQHfhibS3dDU7BNy4YK/ElGekK5Szlx/UN7of263sYNtybsOSVrHukTdxpy8IEF1+THfHj0MkyKUAXkcySjeZUGIN6WUNbz0mn8yi10NknGL1ePldP94a1dHF/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXsFevkNMNX6BhJbVRjzF5PlyoCddsLPpl0DppZ5DHw=;
 b=NnfF3YC5xF8x+qy2rr1NxPnFr0zZEQVqrAcHwtKm/JPWztPLCcKT4cyh2swycgBOCu1MZCjAZvO41qJvlJeKxdbFCPIAzlR+WztdrhrnKV/pIExU5KCkjSHczK8JFrHQCevHSv6o59lwRxXbIlnaWdztG8tRW/8mgTzJAREU3YVAlCQQnSFc2ZjC5FVgpcqpRLHunCxbPzjGoKdjERGgc8KmHKgSa2sRgGQPWSfTLHM4kAfGtYNsCt9I6TxfNwYaCw2NkEClXV2lXLsf/eT7klEkwNTHoR6w/Km+Z3NH48eEDBU/bMI8+g57T9QI+MjtWfPhsUpiXZtiuGjrh8+rgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by DU2PR04MB8742.eurprd04.prod.outlook.com (2603:10a6:10:2e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 10:38:01 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%6]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 10:38:01 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: lpieralisi@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	james.morse@arm.com,
	d-gole@ti.com
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	khilman@baylibre.com
Subject: [PATCH v2] cpuidle: psci: Init cpuidle only for present CPUs
Date: Wed, 20 Nov 2024 18:37:49 +0800
Message-Id: <20241120103749.1450017-1-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To AS8PR04MB8642.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|DU2PR04MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 765bfb85-6bdb-409d-5299-08dd094f6832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ZLA+DfbVGMJsFjDvk5H/7++wHSW0TB0sRWt0c7WUVjD7jEDJ+sWi8G7lPE+?=
 =?us-ascii?Q?pbrZHaZECz3nM/5vs1PVR3qAJm8WqQ6RTzOjzUjjmZfbYAv0N8Wynv9gWPi2?=
 =?us-ascii?Q?xeEoUgxXNJWapzovTVr2W1ZGdU0YbPkikfEjEHNIPIIM6NpLqkYJG2/eX4TN?=
 =?us-ascii?Q?TWM464UVEXu8B6VH/BV+mg0jDHw37wNLyIhG/u4fPipFz/dwngBtFTq+h6Iq?=
 =?us-ascii?Q?efLrA9Xd/vDu1tlVb8CoJ/OlGa4rzyySBP1y0B+PdjknXyGBtEraqYSR+Vdp?=
 =?us-ascii?Q?SeoZYch4f/l7VKrBzjKSqAOtsprgpI1w0hEhA9NbiTaSTdUe9g363zB4QZG9?=
 =?us-ascii?Q?yLjuVU1d880LnAwtz+JluTgeKQQtkTDG7TAPK9I608YAZx2nLDzR7ACYix4W?=
 =?us-ascii?Q?Y40k1uTLOzK8lAmoVwaAaxHTnZQP7N46T/pMtMxyKM8yfbVVjdv8qdtoi0rM?=
 =?us-ascii?Q?L8F5B0nJ1QoAFA8IBXwVZzHi2lKHkgwvM2b4LeJgCFrwMbSQDIkfHqcdvFYz?=
 =?us-ascii?Q?tT9LuGZ9qq0p5L+HjSLGdGq76Ff77Xd+qkCZPQ8VQ760ok6pEFF9v1kDpVvg?=
 =?us-ascii?Q?0+y5xx+Cgps+toppUOADytjdC4aVG5rIN/yQeRT9WTeprVMWZ54cNpGrgdus?=
 =?us-ascii?Q?ARSP2Bys+80UiFcAYBJH3EGz0Dtf6hm/2L9ng4qM0H/tZsU5Brs6KpxMJwKU?=
 =?us-ascii?Q?dkZlhRE9mK1fFeEnOA3ruZD1+dBBIeho9xnbNyoY7QypVoRGYJYMa2Fmi2N3?=
 =?us-ascii?Q?DPlJlWZonq6cnXn14y00oPIzfNKJHs5E5HbPFbbQcA2exc3aiAm+HBF0o9ro?=
 =?us-ascii?Q?34aZ8m0WxQww7dFhd1t8Upa3pGOOXwtHdn3mxQkeVKFhN51ZaZ2yvP0J6nWE?=
 =?us-ascii?Q?s50keQ05EBGiFlqOl6BgWspuX8UJziLjIVMNDcGIzD1DHI6Uwyacv0JV55qK?=
 =?us-ascii?Q?bFzcFklX/kQn5LqD5S2g/Hj7jWaiiy4gHPdk+28PsXozpmH6+rFsP+edyx3h?=
 =?us-ascii?Q?3+ZBNCawWT9h+7+w8lv1/jOXUftDVN68M2SeNA3oEUFHN5xtOh4oyQ58eqY7?=
 =?us-ascii?Q?vqMaoHNuXHAbb7oWZmQNCefXD2v7eu0eEXHUVG7414IZpaMVzK4dygkcAN5d?=
 =?us-ascii?Q?gsJgODT2bZEFHX5Iymf1w3rpmnhE6LKjOtseF1rnbXdQqf2Nv3R5BZmgHH3y?=
 =?us-ascii?Q?p7uVvoQORsbgS13WbYKFuDN2f1Qt+GKGCkQIbS23AJogwcL5RBhEV9IQqmTD?=
 =?us-ascii?Q?0PjgixZi70ZuZLW2iKMdL6i0l1ZsJDQ/0hebzBkIpkfBUiVtfDqIetgkukDR?=
 =?us-ascii?Q?vjGIVkaAJqDWQUi4zJT8z9Fi0mYPQb37FqcfFDrgiVVTaz0Iml4hLvnqIapz?=
 =?us-ascii?Q?B8JB3+0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EqitKUE2eWYAirc4xyv5PeFpYnAE1X+9TTUBR8k4Chuf2VhzJMiLYmD6dBzH?=
 =?us-ascii?Q?Z4Ndpwf5NWL6hzJjgjLSZ9s8LU3B/sb60Bt6sUVKBwmF/596AToxPvAKXC3X?=
 =?us-ascii?Q?H6YbsPfY54YvkUQGdnDAVTqYpA66yRdwZ/z36RE0XKIlERM4Hg50wv/Bgn/o?=
 =?us-ascii?Q?wwQLIaK5KhDydPTaD39O8tSjsFN6pf2EdMZUZdyCZnyVHpwe5v1lEGKfG//m?=
 =?us-ascii?Q?75oh9BahKtsMW9SNqigV1OCRvcxKFy1hokIiB9U7LlsB81Xu+t6+aJcvzNrt?=
 =?us-ascii?Q?u9MGdQ5aSapVtLwEQo3vCl30kj1plUsPf3FE3j9d/SgiJSVu2bncAL6FhIo5?=
 =?us-ascii?Q?RFNfSUeeVYS3TUHoT1YdDOGr0ezhjHBfBaTjJgkH9k49QKzVPk0/2chJiu9E?=
 =?us-ascii?Q?AH80Fj0ub+lEmz5MK6aFYJVkyJ+S1WFfzhbqyEgQRlqymsitVvcC2YfaCZw8?=
 =?us-ascii?Q?qHDV4/APNl8yEiW0+y9gIweB1kAFXTYj5kRgxZWj+3wFnpWjJ8stcJZCinmI?=
 =?us-ascii?Q?kVxN/6fA8lWG0XeGBP0XW4Engbep30dW5fbvIpQFiK+BjY9SA+ejI9LbXCqL?=
 =?us-ascii?Q?7PZAaAAautsWJBMnlDCjH0Kh/pLslCEwIGwAWSQfPEGUIacHfqH6rdXceavS?=
 =?us-ascii?Q?pgs+uimSjKbf0SRY2eFYNceqjr3rupfHWGOTns2KRMuUGRMppnzRmr+g0bcL?=
 =?us-ascii?Q?2p0px9xMRtKdGgAgcXfo68p6oiIuXULAVuLd4WqJBteUqNvyFB4Y7BcG+4HG?=
 =?us-ascii?Q?EeJqUxt9+Pd381A+U3ppHo77yT/c2PYoMzH378AOxMG8CGNjXqqCkI/d/WO3?=
 =?us-ascii?Q?17Ppjqr6W0cVQhYNRtR0cTQzahTXi3F31nFCLADXzM0T811a8OWPACQ458SX?=
 =?us-ascii?Q?YADAoE2DsjaBD8D/cbv5ORKeuIKbFB11ZKPQOUGQpemUnzfsPJtssO/UjG2V?=
 =?us-ascii?Q?TAIxFCAauyoNS1yPFECxgJZ+QeUeI+1PaYsr4WvdvjNJPVqKhyUgl8fRcuO/?=
 =?us-ascii?Q?go3ya19okHtFS+i9BYrhHLieiHIEMrdFxHx5Sy0wr+szG/T09OVGX+715No0?=
 =?us-ascii?Q?NzmKZdV8+kUdugKBqWdk9DRqL66wNgG1W105IDlRmSlS9EidqWu68n904B8p?=
 =?us-ascii?Q?wTmb1OeKxKWckt07JWNNIb+ULtXFzmOEBiptHVPqiC24ptFijaISPFqeLJmc?=
 =?us-ascii?Q?S0c2cRA+jmlerpSF07kpQ58obTRf5sJS4sxUim/lOMLjQx+Pqpwrh/XEQwdz?=
 =?us-ascii?Q?baFvxx6yxi6DkuoUQZaT5AHKq7idCAqIdiJ4i60vzO4FSKPraeSEZX69OJSY?=
 =?us-ascii?Q?3XTaWeQBVBIJDkSlZfZa+FYoS5/I1vnpK7CmNvlbgTNN+Kf42BJgiiKykebM?=
 =?us-ascii?Q?/fIlAkdd2bEmpvPrKkt1vQeeJ5MVElWWhqQhAszYlAib7KyHr/SUJMRz2uIE?=
 =?us-ascii?Q?lQY3RDSt0DI5N8iN+5JPgUx0LkUsp61JtwPS/Kd1MXQ8Lc0WR713DuH1Yvm3?=
 =?us-ascii?Q?4Vt4aXCqqD5vhULYvboIiL1O3yBUBkCDnVVjbFa40rBVnjpkW1UNaIKjzAMv?=
 =?us-ascii?Q?W02EiIuNHv0Zuk79pgzfxzqQhSU1ogLR5n0HWLHH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765bfb85-6bdb-409d-5299-08dd094f6832
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:38:01.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMXQDgPnI1wOCPoPUgOc4BXURnEwBB7yUHAn1706U0cJeEHBzoZk0cM1tMuCKe8yvJ1Ze9netu5XIOqN6f6EbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8742

With 'nosmp' or 'maxcpus=0' boot command line parameters,
the 'cpu_present_mask' may not be the same as 'cpu_possible_mask'.

In current psci cpuidle driver init, for_each_possible_cpu()
is used to init the cpuidle for each possible CPU. but in
drivers/base/cpu.c ->cpu_dev_register_generic(),
for_each_present_cpu() is used to register cpu device for
present CPUs.

When boot system with 'nosmp' or 'maxcpus=0', the cpuidle driver
init failed due to no valid CPU device sysfs node for non-boot CPUs.

[ 0.182993] Failed to register cpuidle device for cpu1

Use for_each_present_cpu() to register cpuidle only for present
CPUs.

Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
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


