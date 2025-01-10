Return-Path: <linux-pm+bounces-20181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A586A08822
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 07:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F097A4D8E
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 06:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09ED207656;
	Fri, 10 Jan 2025 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R13QlVHT"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF12066DC;
	Fri, 10 Jan 2025 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736489676; cv=fail; b=nz4aW8N8hv9bnvM5AzC7LK+yf5BElChxdU/UYlTmHj3+fKp4pzBytM12uhfd1Imxfxjz+Aqh24v2vIcqdmyi1Tn2Cmap3vk/lhHuKsa9sbb1XZJqAfwMTVIR3U33KlpcXDnnuCrAy94yvTLQLiJaXRZQcv4nmI2yt1I73wbnjhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736489676; c=relaxed/simple;
	bh=6shVoBDVeD9ZnLvXK7rhgYAPZgXmzXDKIJO3h904m4k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=U853csP4kjjuMw4jLqIfFNBCcmSucuP2g18HxC4g/+w3iyXGR28UQE0CSLHUvGyt+ovID2v/MJRgOdE0Q5RKbKh8BAUFQa7MMC8cLnx4epa4wpmcPRmq/M4uoivf5u03Dv6FueTIzy6T0HA7GXnPXAdqQN01si0n6s3FvA4M0S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R13QlVHT; arc=fail smtp.client-ip=40.107.20.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFRWyhsRonCtH3OSivF1vvEeFPxqD7Bun9YS6Pm38u6eSVhrJvjXQV2YaD2UVwdW6VywxewxzpMyz5bh/sZslsTQ619q77Cso4Rz5a3A4UffshMjYQb/w/bSjR51tYBMsUKKwPFngTbM1a90HCmUDKnKH+NXJChm52OqlaKloI4QCORt1FhSfhASgo53DCtJnZgfLp2r4qtmXGv5yX4SlvC5azEriYpGLr4KDo2oQK9a1w4Xitum6vrUzlTS9MilRbvzbXSICPhVUcqBy7c7NwRkMxMHfP4RP7Z2b5fZlVZxG/938gqV6zgIfon9vXs3/8DVKnpg7SA+c9vofNh7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThDvgPq0FEdxjSpR+02Tml2q3xDzdCZ1XCABp8S60og=;
 b=tlOTq97ka3GD6lVD6epvcG4otttoQKgphCxFwiCYeUJfNTqM2cKf8ztKWYBomhtRXD8X6vo7JWY8XVcq/R0Sk2eXz6UQdlDHUGoSIUcjosoY2iVvrEzQxyDiHwhPcDJ2qrwLUvMdd1Oy8Q/0+j5ULhyeu/wbg+9MxVxOPyj6lVhf++P0XMGs0RZfXybfObBoBS5cognut2o+LZ4NRzPqmMn0LDqEC10VTjiu1f9uctN51dmM+woZkbLP7CXwK27JhGLx78ORlZubaGFlhMEizdbk5zEj0OvFpmFISPOwo1wH0VijQN/cWsk7ZjQwUXjANoW4DqrlFgoet2XGGCs7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThDvgPq0FEdxjSpR+02Tml2q3xDzdCZ1XCABp8S60og=;
 b=R13QlVHT6KEp9RC+Pmf1S1g3f/UlA5QG8JFc36WWJdlId6UmcJGpPdCo8NH8bU9mjGLTVdqBbvD2fsIW6KKRAa/DvsXGjNFUKfYwrYzhn6DyDiqkB/o1sGeGxTQf6FT4aD/+vXSi+oAmCE6r8yIRAzTCuvLTDB72gcgUnnVWMDZ7NNmZ5cQDuKfA+S++NTGjNMdxIurd23RW/x3VWfa5WuSHRzaCIeXDUmKwQcsCFPBHgQRlq5GJ5c77Ru+HF+/U/GtV9+ho8ijKFLzczxOzeBZ3VH8ZJ2adpX90giOjbtNm7NJh/UQPF8u3mqVQc9Fk0Pvaf3WIezDtK/ANSlV6nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8384.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 06:14:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 06:14:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	ulf.hansson@linaro.org
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ranjani.vaidyanathan@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state as off
Date: Fri, 10 Jan 2025 14:13:46 +0800
Message-Id: <20250110061346.2440772-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c93e1d-0c27-48f7-d020-08dd313e0afa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KHfQxbIUKfZdQ8k/V8V5HjFoRTYyxx32ldgW9uRX2GfproD1vktR8YHMl2hh?=
 =?us-ascii?Q?qYkv1cO3/FoUDCK0tEgvVe/3pTWZSM2pMI2KAZMXcAt9EDRYs8DHJXjpYsK8?=
 =?us-ascii?Q?WDnkUwI79osu+5JG9Pm1u/jrG+JAQZGXei9MLamo7FBol9FrqkmxUbjTyKPR?=
 =?us-ascii?Q?1+TL7zO8eXCJkrEzTHlJ2tizbURtr6fn2i5vT92BvuMnBi0aomnLqbTI1v0/?=
 =?us-ascii?Q?Ql3fyvjPsBbLYfxlhV3yXIMLstumk3V5Ge6jUaeYhE8R0/pFzuGzPKiWachR?=
 =?us-ascii?Q?6P0UlgzxiZABaVsHcLGZLuYqGKBNflUB8HCxtxtEvwUv0SKKTYg4h/7rS+qa?=
 =?us-ascii?Q?ENZ1kecRf5YIZYIoIrZYvUN+7zNyoU4INBua8juld+N9jORE486wa+MMVtAY?=
 =?us-ascii?Q?9nNva/wN8nETC6PCgBJr4XbrBEedBEtRcqTTXIN6GybdbaTY6pOE6RIQZ1Oo?=
 =?us-ascii?Q?7hz/MloZDFT+IZRWSL22JpsN7RsBrR7XGPSL0fIpOacnQjaNGqF6uRV0w6VD?=
 =?us-ascii?Q?APEwN9r9YhUoWtW+OhsMgJYyfX1cQIu+2mS36xndLdZI9BjCEq7LI1D4kK0I?=
 =?us-ascii?Q?nd5hztVCYfe7uPWaoO+TkDgcVCE3gHXdUAFiQnqZdS7UW25lhtUWErxtQ7dc?=
 =?us-ascii?Q?M9jKNYQUwdzMvIAVz3EY27CLbAVx74NsEyGPa6F0KJw32Z5XBgjNHMqUYt53?=
 =?us-ascii?Q?RF+q10ayMblsSqjkANGTMJ4rv9j/nAeR/0JS9oc+f5WOa9CC5jOUbac3xHar?=
 =?us-ascii?Q?bh1eYIPy/QYfX8RXFo6s7fgwmJE8z2ED7xGeZue0YU+QzFpjdw0SkcxZ6iDu?=
 =?us-ascii?Q?j+Snv+qZl9eAM8f6FhlbbZGm0H7KSEIJWPxXAMONOLfwNFy03IbkecG3vD9M?=
 =?us-ascii?Q?vgDlSyz5ea3iJaHLZzFzjfbKAnu/BbXovBWUQu3PngP8L1Padof/J48g7bNk?=
 =?us-ascii?Q?87nK1j2ACFTyW1o+LIs3GEtNwNt9McJnp8328ucKsPAUlbXbMKdA8vr5pbPQ?=
 =?us-ascii?Q?3wCkhTIhJ1nytuOtXlCrKuASIDOsO5Ro2Lr4/2AqczuDtvmOYNgikqAM/O4m?=
 =?us-ascii?Q?ECavlKG5jJskmdtVm1U/GLmQQzM0JHA+26N41LNCBa3MX81xAlv2WJ7lHF7I?=
 =?us-ascii?Q?jXLkAiQ7MWZdmBfBcPd6zPnmhSPaZzqnr1VP63ah+UO3sc0y5IgLBLWd59T2?=
 =?us-ascii?Q?99YSUW/Mf7og/XGxsQ1VWO1QbTubNYqBQKlo+NNoZIYIwVA0rnlJoQy4hk72?=
 =?us-ascii?Q?tL2g97gpoWMcBDatjUBB6GrsIsmEgGJUbSXX6LuRYQa/hJkd3GEivNZiHE8r?=
 =?us-ascii?Q?IBhALOitEOArv7NNWWpHLjbmsLSZraustnVDotH0vu7J71DrA+D1YRQczOR8?=
 =?us-ascii?Q?vy++Cuk0UlFufm91vguiyCT7f4BGmD98q6JEa1Dv5EbU7yb24h+j2+Lw9i33?=
 =?us-ascii?Q?Gpo+4rk55diCNv5ix8YgSRgRcZQSnYic?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FB0JzuprTAlPRwY4UuY2rWp5ohGDWvBLFoAkgl475paxBStIsKfJ1kEOJ4Ha?=
 =?us-ascii?Q?mhlSBBA5Fqo/AkyWL8GtGZqoGqiwI/f7X90BnQiQPpALQBa0MdK9BEVBxvGx?=
 =?us-ascii?Q?FK98MA9gfnUpXHjcCVJvhM8bgEc9eQ1m93vuWHIG3j9BtuyTbVcysfZUJx0Z?=
 =?us-ascii?Q?q0UJE2FCK9oahTBFfuaI/aMGTZTAhUW0qE8nKLuQ+VfjRGYP+/TsTTCpVti4?=
 =?us-ascii?Q?N79LWJrWcfUz0XtRUP4bYomyBDkM+0RsEyxwA8SUOyFaYLFbfk+IhFHbx2Nh?=
 =?us-ascii?Q?RXPscPerBkVOenr0xLF6ZMZCQAVXl8T+D/sQlj/U6se5I4+IUves3vTKgosE?=
 =?us-ascii?Q?l1F5NgIvRyp3EiIQkMCh7sctzObEy2rsRp7V7vooTNk+meMwa5DjU8GLRUgP?=
 =?us-ascii?Q?7DCLp4lGbGE+xOWQLA/ix2awNyDft+X83LQjXKBmT74Q3imM2R/RxMQOkz6F?=
 =?us-ascii?Q?w2OYVd36R6Pfd3pot+1gfz+9o2d2ezkoRFy4tWPim9kAzOT0hfYIzyiAFvwv?=
 =?us-ascii?Q?I3jRkSTgUEUTZTHdaXBNPpxgZ1cCys/MY0dmIc7eEFL5X11c8Vjw0KzHAZR1?=
 =?us-ascii?Q?3xo1uqLHzkcVXECKQooo/FUH2Xb5L4EWxk63ceMZyEw9QEpvPEdo/KjXAtdG?=
 =?us-ascii?Q?Kg0pAmn4J8pQfjW1ryyRL0K2PnXiuisfmyCLB3rxgaVciSS95mpN7b7ijQ3H?=
 =?us-ascii?Q?Ywcp1TbmDem/Cnets4cazuzro07rVKeVo8hHUWEbkmgFXUkaA+kBxIoB1UMW?=
 =?us-ascii?Q?RPKmCxP3TSEEhavhG9LI9k+VtrDtbFC5+zQh7E50TaBZCQ+7Lwol4XpneFjS?=
 =?us-ascii?Q?sVlB//fd4Gk8Qsbhf8L1mnEchTH1HI8okXSRSf14O+2ON1T2AwahEo77QCOn?=
 =?us-ascii?Q?0XOl3LY756c9CkQcg1tNxrMLYmp2Us4zhl9NCh1cjwzpxJTA2u0zZYzSzj5N?=
 =?us-ascii?Q?Ow5LUfYe+btit7N3ScAettn2kJD1ajtZKKQnuVHbxuPu+Pur+kId0jMT3vh7?=
 =?us-ascii?Q?CxIXwddRbwq0ohy7VJm3yuqW9y5SKM5FzoFdivY3LG0IcLHA3A2E3HveSGs5?=
 =?us-ascii?Q?pmE2O8TvQaW5hFF1GLWSdh1eMvgPvgpxzPEsDl0kznXTtNaVorJKcF0Tab30?=
 =?us-ascii?Q?nn19uvhTrWZejpoqSDpAuRGz7VYhWNBtrMc9egzPowqYMDa85D5ys1QE2KdL?=
 =?us-ascii?Q?mSmEV1FvJ5x6Al078KZU7OEwhARZQnNCqI1YlxLTMhzM4u22A32X6tA3EHTs?=
 =?us-ascii?Q?pP6Gn6A/+fufVkWVkfm+JeEF1RB9dyo0rO7PZed2CxWT0UcanKybDeGMAiDc?=
 =?us-ascii?Q?99R4rrjPdQMTgfjQhO8C0TWHF6qFflmvE/fECmJQz8IgVoep8q/kYOUxDwDi?=
 =?us-ascii?Q?yMmCsMMVJC0IvsCnjKN2wehF+8skxcPsWDJuyHzuXgjyi8jjIFYyLKPIh3Wq?=
 =?us-ascii?Q?BhxQy3e3fbVGgYlZLVxKhR/xYWvTjaJtiVy7Is8HagUEE79TrA+t3Jsuz5Tl?=
 =?us-ascii?Q?yzpavQJYvyq9nzJst/HHStwYbBWFHAbdyqSQrWTlIBlLs/555kbQzN7DPh1T?=
 =?us-ascii?Q?RaaUYftkwq/QghgLhPPFaEwE99YK3TaQ50ao+cnu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c93e1d-0c27-48f7-d020-08dd313e0afa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:14:30.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtdeX9d5EKG4M4aNLXkr8HzjuB3WnY5ij0a+hgFmWfgocTjpJT0JcZ6y8vFlMeYIInpMDdRLr4LW7YiNQ4P9Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8384

From: Peng Fan <peng.fan@nxp.com>

Per ARM SCMI Spec DEN0056E, page 16, "The platform may disable a resource
if no agent has requested to use that resource."

Linux Kernel should not rely on a state that it has not requested, so
make state as off during initialization.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/arm/scmi_pm_domain.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
index a7784a8bb5db..eadfc032867f 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -89,13 +89,6 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 		return -ENOMEM;
 
 	for (i = 0; i < num_domains; i++, scmi_pd++) {
-		u32 state;
-
-		if (power_ops->state_get(ph, i, &state)) {
-			dev_warn(dev, "failed to get state for domain %d\n", i);
-			continue;
-		}
-
 		scmi_pd->domain = i;
 		scmi_pd->ph = ph;
 		scmi_pd->name = power_ops->name_get(ph, i);
@@ -104,8 +97,7 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 		scmi_pd->genpd.power_on = scmi_pd_power_on;
 		scmi_pd->genpd.flags = GENPD_FLAG_ACTIVE_WAKEUP;
 
-		pm_genpd_init(&scmi_pd->genpd, NULL,
-			      state == SCMI_POWER_STATE_GENERIC_OFF);
+		pm_genpd_init(&scmi_pd->genpd, NULL, true);
 
 		domains[i] = &scmi_pd->genpd;
 	}
-- 
2.37.1


