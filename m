Return-Path: <linux-pm+bounces-23733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65954A58C98
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 08:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9636316A67A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 07:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DF01C84A9;
	Mon, 10 Mar 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FwDaheLJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D41A841C;
	Mon, 10 Mar 2025 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590937; cv=fail; b=gKKnLRWiDlGSOQNujP1QViGuxPVwSqeV0cZ2IADoq9ntahJHrkX0SCBlD0hN++DuH/nAwsM2PO5wCFy4t0ZevEXG6fRIpe3at5Mhu76fbmZ2HE/NG8k3Pqxl8QVaA3BgqU2YSx5SnRLCPc4Fj5qQItUw8CcrYgj7vVu/2+prHxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590937; c=relaxed/simple;
	bh=FSFZG5CtL7glyrZO39kpo4NEHgEIbzAyFBLmeSo+6jw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=inDfIcAd7LABYQaDHcdaGLadC7NBsNNcyR/KTDAT9Kz2kiRjV8jMyZUWPMYAeDRQlwfClDaxx1rpWi/Bua/St2CFlOCRDjV00ZMwTgbtmkweF8HhdsO+cTpieH3rJqn/YfPQQAaUOcCjnNODQKnH345KVoFHxjZDwe0PqbNnxcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FwDaheLJ; arc=fail smtp.client-ip=40.107.20.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSlBcNEwgeEjUszzY2Aeia7r8D7xDA0kzJ9MGuXd4vDqgLoROf5U1xfhx3uP5GzjwYGSnOiWAPM71ZJBtmxi4W2LOeXWvx4/cfl/f4mDSgpa74Wb25INqlnpyvb6k5wNSq+eSBKLl04uJQ4xd1hIvm1rqvkcTBoEM7Evl62annwizA+qC3uhZgq5kyj2y2fycQZa5miMrtqmSeQUv7Egl7vvE7VuBTJ2IiinbkX03pfs0mzFqK1FzeLdLuFsZjnxXHMdzYDcMe5IohIn2I0tTaRBIotJak7yxdfuNvbq//ja5FvxpPLKKSrjj75eNObftezS6vAUzHamKd5yzTfAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMx7n7xdTAzvgf/DjrakrUzyUWsc05RmQ+HIT2Wr9CQ=;
 b=iO7afFo/aorZm6azxeGNPU2XAQoaJgoGbuajx8CDMwNaY+Z9DZBo5m+zspbCkujuIhlo9h9CnVNPad0T8iLAHXbqGmb5mA8WRUqMOHu0aPYCK+KsvBRoty7L4slaQplzXKjqsgAzP1CKOmx88lZqWQZKjaSN8A4ps3WEL2n4XGZ9gzSfqVWTeg6QNSD3SpOcIgT1i1d6g/zhNJ5/Cv3JNzzm6DeU/Mjfo69pOliCvdwoHp2OdUKVX/vtvZh+dlHtfpXhgf8s5r1t5hkgn69+a6w/0a0KxHDRuKhnDzE+lM4y0UbZMsMs4iYyewWPLBs33rnaIVoBPQbkKw4wuFrsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMx7n7xdTAzvgf/DjrakrUzyUWsc05RmQ+HIT2Wr9CQ=;
 b=FwDaheLJWkXnx9Z6yYH4I6Q+uIZnTkC4RJmrK8MG/y1tpf89hGqn9x2oPxRTWqD3Mbzs4ZqeVJ38wcK3tqmQlX4jSintNDLBSRlCzN0ktAWAvN/sHVHC6EDI2wKZLvi9nkABil3Uu8v/0S9fBesJO9rrzGf+GK3NVv/UpYdwvG9ntvZPRuh5qVW5otE4X/Iu2PMr7dsTHzBlo08yV/P41fq4Dq8j1FRco2H5yr6PiIeArkk80W9nkRaRPiNfEGXgG4BZ3NQMkbXaJT4SvlMTwNIBTdhDDMb6ZwOO1rYqAsTL5WE6WijhMoBaC1Ruq89YiUljbMP2NnH1b7pcfD8Egw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by AM9PR04MB8324.eurprd04.prod.outlook.com (2603:10a6:20b:3e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 07:15:32 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 07:15:32 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	ilia.lin@kernel.org,
	tiny.windzz@gmail.com,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH] cpufreq: Init cpufreq only for present CPUs
Date: Mon, 10 Mar 2025 15:16:40 +0800
Message-Id: <20250310071640.3140435-1-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0190.apcprd06.prod.outlook.com (2603:1096:4:1::22)
 To AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|AM9PR04MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 1239f005-9a0d-4c09-a193-08dd5fa3588a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N/DatF7+MjTUw1DrQNU9SgathohhN5FjfA88vpVLl+DAaqMr7SL7Add1Udue?=
 =?us-ascii?Q?qha5b32X63Jxvc3s5k5U0FGnQb3hQHye/DcNNTcnxW7dFCQeXOCLv0NOI5yr?=
 =?us-ascii?Q?PiGxx1t5uaWk/gZW21x7+XQ1Yd/+7uMNKxeB2yLRPfq1ZTju6bQUf1nfjxhB?=
 =?us-ascii?Q?3fE885lcV8SaP153UKy/r/PfC1lohaoHRICz9uYbUHyEqXfmUurC79yRBAy5?=
 =?us-ascii?Q?YLuFbqSsw+rbrDV/mdCKkLPy8F7gxe9ebjqqWeE7pzFCnC6+nzrPZ/1RnZty?=
 =?us-ascii?Q?1oeooo+zl38MvYvAKeYVv01TL8OpHCSOqfukNdU63/4DQzEcLq7+sS8xetKr?=
 =?us-ascii?Q?x7idCXaUbM5Tie55HTyQs6sOv1XxKEbpZNAOt5BVw/qjl5kqXR7uZr0iVpCM?=
 =?us-ascii?Q?UXF5LmAVdqJ9JBDKgWAdqe0TlKGk6O3Ug+z3YMOol6o0Xd6UJ6y2BYURPVOS?=
 =?us-ascii?Q?/P/1EIf/lWVMjvR3mHyyTX0R2hlx5ZuBeEtpooEgKvSJ8+u6/a2rEuA0iC0G?=
 =?us-ascii?Q?LirmD0M16ItaCWWBCEHsQwkUBwfpdhRe0RNyvELUotCZUURyQYk3zSK/AFox?=
 =?us-ascii?Q?mYEg4nupAICg5X8wD00XIyGvp85xMhbqbXwFKBzbTsO4TqK3ACMPkUwn1wqe?=
 =?us-ascii?Q?irOhCUWylBrWKGU4/eAcsnfIxCX95QLTwD4RWz9skNP01k2CuNJblwc/jsdS?=
 =?us-ascii?Q?e+htiDCuE/oIXdlsajW7dBRY8xZiT7gZ8vpG77hXYjIgP18zMiEwT6az3mJG?=
 =?us-ascii?Q?dK29gXbprfTNG1O8gsSNhdJQY5WEAbz+DrLlYuwE1Gt9sHQHUeo4Xl6FnvO5?=
 =?us-ascii?Q?9HeH79VL5Pp2GX9QwsfYDdAms3rwQkj1l6TnfQDn+qpBEl+QBLA9OrpA3pAB?=
 =?us-ascii?Q?vG07ni+0oC8SUXQsb3gA6oT1/Vzk4MD8f0GbIVQ4wg/4mTSMRLXA/BogN3WS?=
 =?us-ascii?Q?UG4/blLuEQOQ74wYCh5TSPPnCctNDZyaT3L3cXXWxJArAHShbFLvCZMkBFnP?=
 =?us-ascii?Q?LKZ4GrCRY8057VqKktj9aOjWP5vyfSmfyNiO19bx3/AAqRYOUxkU1hLJUmlZ?=
 =?us-ascii?Q?jM09acBZ5sQCRjNH8eOmix4hD8STs/WA4tIqn2D/IWyv9mOWM3YNnwnLtz0s?=
 =?us-ascii?Q?QteFAj95vLtFS6A9PJ9P8OX1jLw9KYUn24+7lGhcpqcahtGiLsvyqcOpjz6B?=
 =?us-ascii?Q?enH6Fyb1wvMer0xLOLIPsYyj67h4Dp6OU9IUtVrMSJSjb7pa4Cp0tuJtGO5j?=
 =?us-ascii?Q?hPRxj+CoSKvarYhxeGq4tjYLh850Gir9Gj/sf8FZkjCdR/mTS6QOJqayeTbg?=
 =?us-ascii?Q?vqUR11EwWFv6sjJ4wWOmL46Fdym5AsJBIzwLPb32YMsoxU5normzVn9CTmij?=
 =?us-ascii?Q?Z4tospwahnDqLdbBW98h8gDFGsgwk6omrqYKlG0hyka+j0Jxy0nQJKM3j5yS?=
 =?us-ascii?Q?P8vZ2iSZFD5KGgph3EU7PIYxVCKHaDMu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CP4ZJ0V5TYJUFjjKzmckFlf475Bw+nWIgeVz6RrBQkc5TFrxO//vLTawSEyk?=
 =?us-ascii?Q?u+VIxuQkOy0qUH8Xu24oUrTeZ3GgGuBLid7Zk54SH5F+lSQjxhdJA9Quu+m5?=
 =?us-ascii?Q?t5HP0XL1MHGxcV/IsN7XO+fHbqvE8gQVlx2FqivKh9UJ7jFUdEsze8X9dODg?=
 =?us-ascii?Q?VRZma7jXVmqRjo/hdpE79ZXaAwN0rkNEPm54jlL1BOfuh+lIgAwkRREEgsat?=
 =?us-ascii?Q?Nsz3PQfnluyb1cmrXJwqkGPPBDnWL0CaFh/VK8UgSbqHmuy+dH0Cv7XX+sUF?=
 =?us-ascii?Q?hFMH2bTFzczygbkM90quPacV15Emcqf20btX/p02KHxUpcqkd5ju2GjnYXEP?=
 =?us-ascii?Q?iR6/gOvaInOvE0C0Dh+VarG0g4RZIXfzaRRhw5C7CgE5EldU3OGsPhSxAKv1?=
 =?us-ascii?Q?tZ2SAyhpD85Za+jKSweBeAuSBzfxYqbvhhwhizUj76SpDOsuMy4oJaBtcnG5?=
 =?us-ascii?Q?qKv3uRGdzVdvC2/Std5isXxULPqFlVnbkjJMyyrx+vpzhLr5IxMXkxtTnaq4?=
 =?us-ascii?Q?X8lK5ur/K1z6H2P7ZBGKB7kBzOQSzLJpoFTLo6czB3sMaE121t4CIwBDygUB?=
 =?us-ascii?Q?4JSzGx2IvbN8bgnBTTUX73+PCbb0Ju4jnVtPUbIvl1SQLK3h7xTzRagQjDYX?=
 =?us-ascii?Q?dq65ZRPmB+EaxcuvwfAemQ8NNb37DjzZJunJvwO7FGbmd4Qwj7J3n46sD5aI?=
 =?us-ascii?Q?T/6PDd9zyLhyNuCzo4ZIHGId96bvtDSE/ZjByGZLN7eWNt9HZVF7JbmwDY+F?=
 =?us-ascii?Q?387rFTRbr7H/amDUKozxtC2yVtvbtTHb6RGRKEzKcQpeHwe/qQxH3aqbOR1C?=
 =?us-ascii?Q?KwCc6xpiTEDlOTHS4LC7LpcAHCVjpy2HlKWj1/JBDzOAFkvvIZ18kNFt7XdK?=
 =?us-ascii?Q?klsws2cDE/LM+x/ZQd9hjzQP7CyFKG/cxMrKDArF0i/YhuFjlyG1dhVMt0tu?=
 =?us-ascii?Q?RBIuxeXiORY3sQKJJJyrAjiTzSJPG3K1CGkICwk32b0RbaB0QVFppfeLpZMF?=
 =?us-ascii?Q?8A2XepcHlf5BCa1qVz80wmB1TmCtKnKuWKuFS8NAEDe49HvFqzwxMxerccVv?=
 =?us-ascii?Q?rDvl5RZ+ZrqB4gLOSXt3kKZ5yvI38wteTeXGA5ceowVnLUd1MRqfPicQg3wo?=
 =?us-ascii?Q?eP2snKkoaqVVPZEkzlvBslpzK2zMN2kcxZGwYZqt/9l3uCiA2xzv1teSov2f?=
 =?us-ascii?Q?/ctBF140sJifr0O66un4pYhcGR9s9tcjvnl6GR5lrOOG2rLrvH5JvnvHSKqJ?=
 =?us-ascii?Q?ln3a0Opa1OaCLc0/CRz2rkpHw8EPEgtNDspTlXK2iUi6v2Ow4F9jUw3JFg/I?=
 =?us-ascii?Q?sh/xPq2aEM5O+G8le9ZlO+X0/MQp8C+P567kOiNT5lstsei62nJhWaeNM0t+?=
 =?us-ascii?Q?GrE3cLBQUaIVyeo99lGjf1QYsFViEvO5Oo1XpRoalqotbRkUpu4sTggZH8P3?=
 =?us-ascii?Q?iKst/SaM+m+wB+nj64wcXqG+hZHlGkPsILR0hRBAoxxPjtFNmqsHRv13CBl0?=
 =?us-ascii?Q?j8S3Drr+HhdI+dxlbgzZO4s/T1WDj+MvV1H6WhcnRl85rKTHVsiy8WZnZp2p?=
 =?us-ascii?Q?44Ji5nejO3/0dJP6xYb98EYpM3vku5PyPikWG4hD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1239f005-9a0d-4c09-a193-08dd5fa3588a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 07:15:32.7995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7VIR0eU3hkKApNkY+ckLgsD1v8QbznnLHTNuiFJnFfDkx3OKg8g1+zWu486DyM+kuGSNNVcyT7fLB3mlvG5JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8324

for_each_possible_cpu() is currently used to initialize cpufreq
in below cpufreq drivers:
  drivers/cpufreq/cpufreq-dt.c
  drivers/cpufreq/mediatek-cpufreq-hw.c
  drivers/cpufreq/mediatek-cpufreq.c
  drivers/cpufreq/qcom-cpufreq-nvmem.c
  drivers/cpufreq/sun50i-cpufreq-nvmem.c

However, in cpu_dev_register_generic(), for_each_present_cpu()
is used to register CPU devices which means the CPU devices are
only registered for present CPUs and not all possible CPUs.

With nosmp or maxcpus=0, only the boot CPU is present, lead
to the cpufreq probe failure or defer probe due to no cpu device
available for not present CPUs.

Change for_each_possible_cpu() to for_each_present_cpu() in the
above cpufreq drivers to ensure it only registers cpufreq for
CPUs that are actually present.

Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/cpufreq/cpufreq-dt.c           | 2 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c  | 2 +-
 drivers/cpufreq/mediatek-cpufreq.c     | 2 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c   | 8 ++++----
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 6 +++---
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 778916f89a51..e80dd982a3e2 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -283,7 +283,7 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	int ret, cpu;
 
 	/* Request resources early so we can return in case of -EPROBE_DEFER */
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		ret = dt_cpufreq_early_init(&pdev->dev, cpu);
 		if (ret)
 			goto err;
diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index aa209f5527dc..74f1b4c796e4 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -303,7 +303,7 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	struct regulator *cpu_reg;
 
 	/* Make sure that all CPU supplies are available before proceeding. */
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
 		if (!cpu_dev)
 			return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 2656b88db378..f3f02c4b6888 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -631,7 +631,7 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, -ENODEV,
 				     "failed to get mtk cpufreq platform data\n");
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		info = mtk_cpu_dvfs_info_lookup(cpu);
 		if (info)
 			continue;
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3a8ed723a23e..54f8117103c8 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -489,7 +489,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 		nvmem_cell_put(speedbin_nvmem);
 	}
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct dev_pm_opp_config config = {
 			.supported_hw = NULL,
 		};
@@ -543,7 +543,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	dev_err(cpu_dev, "Failed to register platform device\n");
 
 free_opp:
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	}
@@ -557,7 +557,7 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	}
@@ -568,7 +568,7 @@ static int qcom_cpufreq_suspend(struct device *dev)
 	struct qcom_cpufreq_drv *drv = dev_get_drvdata(dev);
 	unsigned int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_present_cpu(cpu)
 		qcom_cpufreq_suspend_pd_devs(drv, cpu);
 
 	return 0;
diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 17d6a149f580..47d6840b3489 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -262,7 +262,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	snprintf(name, sizeof(name), "speed%d", speed);
 	config.prop_name = name;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct device *cpu_dev = get_cpu_device(cpu);
 
 		if (!cpu_dev) {
@@ -288,7 +288,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	pr_err("Failed to register platform device\n");
 
 free_opp:
-	for_each_possible_cpu(cpu)
+	for_each_present_cpu(cpu)
 		dev_pm_opp_clear_config(opp_tokens[cpu]);
 	kfree(opp_tokens);
 
@@ -302,7 +302,7 @@ static void sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
-	for_each_possible_cpu(cpu)
+	for_each_present_cpu(cpu)
 		dev_pm_opp_clear_config(opp_tokens[cpu]);
 
 	kfree(opp_tokens);
-- 
2.34.1


