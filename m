Return-Path: <linux-pm+bounces-29810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D129AED1C5
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 01:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15DC16EFF9
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 23:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A822066F7;
	Sun, 29 Jun 2025 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="BQGpRmzj"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010070.outbound.protection.outlook.com [52.101.228.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACB61B0F05;
	Sun, 29 Jun 2025 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751239104; cv=fail; b=BZHVYdqskHKnhtMQDeeOc/9qYxi/gwa3Iq52FX7Cq2tWcL/+znRIvFFydIdzAHy0c0HEX5hasKo0OyfGi9mbccjjATkW33Fqw3+vE/JHMYVsoa2oDi06rGiKARnP5Bl9+1xAh8YegAa2m2Qrnq7QLkc8N1tMoxmWJUe2g0cegbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751239104; c=relaxed/simple;
	bh=1N9kvTMa9pB2nSGctNPABWAXRGYjh1GHnYqlSycyZn4=;
	h=Message-ID:From:To:Subject:Content-Type:Date:MIME-Version; b=Te2zBQQ/aGrkQhG1RoOXCGsh1Mk3/SP2IKhtWjPeEfWvv1UByUR+GRj3XILTxG/a+0dJsDec+q5pc5y7JbRrbj5qFr7co/3FBXBFGY4qj6vrpdAESeIi5INnOI8XK5pfv9Y+YrvYhOHrJWQuSWa0dwp4Vg923ssrQFXJ0G3xnUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=BQGpRmzj; arc=fail smtp.client-ip=52.101.228.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBb7G9pv2n9oeTPuUGVwcCeyuyjdnJrShWKZst3yTHpRQjgQoTM9wvMXkudgjVWu5kQifq87tryacoREZwXn7t32e+jXAoTKa0ghfQkQYe6KjBeDbf+Cf7cTL/l4ewn8hwBDXsotI3WXz5dGdRfqHjf2R2xMEb5/bBlyYPo2Tk9PcRLzF0fPSjSLI5bLy4rly55hgp0d2qLzFjsycTvpqYj7c5gDaRFvsi7D5eOnfWxvqs35CqNAlIESK6knLLAnmbmi/Qq/hOhNHpvOTSlRQfv+7FQbY2ygo8lYOTJx0FuAH0IWn5+QwiBjgAnmTUEs4O/O2fO9//rpHEcA3HhizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34OVqt0VeGxWYg5omxvkDVlsGJ/zg0L8e8m2h+798s4=;
 b=MFYdAawFENMTpn6hLvCzjFPGer5NbLNIqY3inei9+DXNHO+mofGeHsNUSFO3kbXaXoHKsEYb5yzcE0ELlOcaM6Rk5n/OxjznN/s68U+Am+nkYBoHz3ar/+g0YnWqX3oEKaeokkmSI6ZRFbLqZi5gxuj1Nutff34LPVSwZzzeSmKpWqCWz6LoQ1+P1jntO/ct4FE/3QrMpoEiE6X2RZm8BIT8+6h1cnN2l+XYGlLHYYidbz/guZy7rNFnwcoG2Os1pcRMa/lwMFpIxTZ+f6CMI/Nmsc8UfzgXJ78cZjJlrPL+nSgCvtkkVtulUne6rBhf/5oY/g2kN7m2zNs+lO2htA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34OVqt0VeGxWYg5omxvkDVlsGJ/zg0L8e8m2h+798s4=;
 b=BQGpRmzj0M9wM3WGoLj66mXpJvAdLTaYrC/jdteTbVlEBURBPrnaTUvVznPkgnjrP644eAolAwSQYGA2+Vs3LAX2LlVKQlif8nHXGOaFLI2yJ6wRLkxHP8H1eVX8aD1cowZumsUdzAX4eDPL20NTbaLjUn/18F+a1LaEtDEAhz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB5661.jpnprd01.prod.outlook.com
 (2603:1096:400:b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Sun, 29 Jun
 2025 23:18:18 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8880.021; Sun, 29 Jun 2025
 23:18:18 +0000
Message-ID: <878qlagmrq.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/2] pmdomain: renesas: sort Renesas Kconfig configs
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Sun, 29 Jun 2025 23:18:17 +0000
X-ClientProxiedBy: TYBP286CA0042.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::30) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a73976e-7d82-4db4-29aa-08ddb7633b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KwG3mXfBEmEi4NVT1XFTju78ipWczjV12fI21MaqD9r2QGZUd1jM5BsTwKCz?=
 =?us-ascii?Q?p7RI8LKAzpfUe5crzci/hfL8ElxhPiirNO1/ES4h8blGq67kdRUU85LTqlmX?=
 =?us-ascii?Q?pbdUS3geshW6cXHv56W75ecTiVzxz57IL7TYsa/1txpL0Hpe4LfpuAdebV3H?=
 =?us-ascii?Q?b8EbHpUwmYGVrdsFpFUMlIR44eVT68TUE1T40hVCwNA1/c6hqybmiAWC+EJS?=
 =?us-ascii?Q?JPj6vl0SGn6dl5Rem97QxSDye9eSKzKvkJTo3GCYjHgoGlzUeCL74bq+Vy1M?=
 =?us-ascii?Q?5rTHvzKD7vB4Cb3O2HgVqEbs7vQFKHRLz1DcqTPWHI/1Af7qTuQYodmbmw9N?=
 =?us-ascii?Q?SOXt3xdlnycW/WY/dGtDBLB7ScvuG1bNNXzLoQj+h0UI8AXoOm909U5967Vo?=
 =?us-ascii?Q?zQBq3oGX/Hh+q4Ietk8z0bY+0/RJxTkbw+fNyKlIP5N6x57tYWnKYTHA+zOE?=
 =?us-ascii?Q?oi0MXj9bfdsBwXYSGs/cW15DCk29kkDnMs0Imif1MYs7uxfI9qSd/XkKAK6f?=
 =?us-ascii?Q?gFf7meBez5gDVdPKov+czB5JZoctawpff2UOBG7widoZRS13CCMUl7fuJPeH?=
 =?us-ascii?Q?xuKnOBwtDzTcnqx/RBbDwcXjRVJUn9d7UwQjcv0bc84Gb6iEbtybdIJEomYj?=
 =?us-ascii?Q?qxzBwnDNeddET4YjG4khGjqV/x/61DRCcopx+0i4wfVtIO5takNHxJLfedo5?=
 =?us-ascii?Q?hiMXbh+v3l9QrAlGXFaOdoDW4qJCJmnkxUqs7TP8Luk51Ac2H2KKbewrP3iA?=
 =?us-ascii?Q?eVjE/2qM0FJNJL6ciVFJCxkfyfW+mLbnIKXGxngiiukfGVZSDScpiXr2W25b?=
 =?us-ascii?Q?NLyl2o8Bj28TrXJQuWm8gMIr4/Ek86ABB/jOJdSBRM974/c3iMe99lRrtHMt?=
 =?us-ascii?Q?VtsLMwS1/FzFEthR2pJ0oLwlucJ/MV5aITSfDh72YZEtoXpW9SxY+K6mAezY?=
 =?us-ascii?Q?lmbdQJmh6HJ6vXbYO5gLO+Q7b6CGADROUs+YiUNElQkXhqLHTMPew1cAc5hI?=
 =?us-ascii?Q?gg2kB+Snf+1AItQu0LB7/b2qsxSbe9bZ1WMpF/FWfJY0rYjuFzV9royMzosR?=
 =?us-ascii?Q?rLVXrXvR014VU2ksbzf+RS8pWu5BMJOhG5s4EDs6MjVdc4cFy6AUpzsH8SMd?=
 =?us-ascii?Q?cly5VntQd8WsjF9gNMG7EYPHBELC+gw3RmFnAg13dnUUP4WkQqPBn4VZKVst?=
 =?us-ascii?Q?NE0X/CbCKvbelHrDoFfqoW5trjbhefN02/+l9Lve2b8ooHRwApaVsHLEhH/6?=
 =?us-ascii?Q?2qgoftv8TfN+BIFL4wUCEC+jVICzbF5yDSPw15tVu0W0SbFYWuhJyGB7+kES?=
 =?us-ascii?Q?gvkyFEXCN9Fm+/1z0n7lL3XSx8aqyrFs+5j9ThEofAaN5IopmrnTGeRe2L1j?=
 =?us-ascii?Q?ANI+K1sQInjLzEZuO+ir5JwMdVYLa+hiZmjxO6qEjVQR8Zv2JSc33tLdIX7C?=
 =?us-ascii?Q?mj5cz1uovRyf67Mx6any26kOXx1ZyaEcMsAhFRSpZWQ/wCBguynW0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0nX6TdRh3QhUETivf9MNthcuQxXth7o7aMWbQS1Ia5nsk5TlFbn43PAX0Piz?=
 =?us-ascii?Q?DJG9G0PcRcl/h/6rm0LuohD3tORSrxe+syoXWQcD8rCCg9UB1srr8WEQ8u2x?=
 =?us-ascii?Q?Ha/VI7WuetIS0p6UFobAMBaX0y74GD0HZq1bKSsSSi0ziKhv9JdmANklSjcR?=
 =?us-ascii?Q?KcGwIcM/TwjjNWSZJRsVlCJNaRQWVpYY0YKTmpL7O3vq1dLNJikvwdGjx2f8?=
 =?us-ascii?Q?+vgg7MIcYpvKlGB2pC02OWFylxWQCKMbn4Vc6syHp9HxRV+YNv1OA4Hgence?=
 =?us-ascii?Q?rnncSxqH8MjqSAhZmZ4MXyr7d+Scs8PoLnfQVo6yZ0eje++hULe+oRXGbWYL?=
 =?us-ascii?Q?JE8Ogrp6HQhIGteohripIIrnDUJwLQs9KQ8R36NPaRNY2Uk7MlZKtU4rx/aV?=
 =?us-ascii?Q?WATjjl6rX3lM6I8A3HfDX3CL7eC9KX+0mF2aLKs5ni86d2h2MjH8PkaSCS+q?=
 =?us-ascii?Q?myCIs/7rskDrJPXUQ5i3bCCKKrglpHCwBKVjBU8ncJhfShsJy9LKUF8Ql19u?=
 =?us-ascii?Q?X49sKMX4DPVnXf1vFicfNe+TexEY8BrDTbWk2Ej9Nsn/FOXCnZQUu1Uk++yw?=
 =?us-ascii?Q?oCQZh6hdDGWuBIkJzkWy1pM2ZKhv2sa2xYmdO8oar7H45fumCVZhAbS26dJG?=
 =?us-ascii?Q?XPTa+y/BiG3jB0a9mCSs1HejhyNkNpttUz7FY/BoU0dYoJJSoRRcyX7L2KDz?=
 =?us-ascii?Q?Nq3ByYR5X5QvNUlNQb/NQzDxmZ/3z/JRcKzMTs+qRCAk4R2y32xKTILQq8YR?=
 =?us-ascii?Q?V7zJXtyRDaMiiksw2HJi4M/4w8Ol8oknQSxE0aGmxsldTRSdqXvL6FEGQn8X?=
 =?us-ascii?Q?2KBN1iyZ3y2Q/iNSObowvJT8nxKYKzgwVGw2sXFI5avvJCBZieXXkInYRiEd?=
 =?us-ascii?Q?yjxwFRQIUm/AWlBVBGKlnFgLatpx8OejhVb9F8NRDYOm5uI5oLGKkeMUq+Rx?=
 =?us-ascii?Q?AJ5R/BO45PqGL95NZogdWTIRlHtK/zcKdzotXC0Rzqfnc9uE8U72D0PT2+ff?=
 =?us-ascii?Q?t2afR0JxnaGazHLs4rE3Nf1gAbQ0e9VGHy5A94FyFn6if4IrWO/9UcrxtSwB?=
 =?us-ascii?Q?N4ZxaK0me4pGR+cMXjIqpRQmK+YBtgwKZ5W0RYdLqFUD8RK2e5chPEbHLg07?=
 =?us-ascii?Q?2ZGC5QYoEyY9xqssB997r1B553ANtvfwrZnbl87otjMG1wAcVZdaAiMhD+kv?=
 =?us-ascii?Q?JqScMhTs66h5YsBNK5hOx9TFqaj1Y8dzLV1JNpgN/uqRO394F4LsNRwkKEUY?=
 =?us-ascii?Q?bTURrCMmIpViYoiCo4wfF4a0TQUiR2I3DjwXC37cNh9ykyWxIisDja4ptgee?=
 =?us-ascii?Q?HQwEEepMUIdPy+MPIJ6iVQMp/C7Gyd7mUWvAwn+JS+3+O+mrXff8crB8U0SQ?=
 =?us-ascii?Q?+IGYNHqE63zMWY9pgXaZPjnQg/O/Cee/NuM4VLQ4I+MKSsfTRVGb4603SB1A?=
 =?us-ascii?Q?AGcH8JJLoSpAgA7RaR+EUwLIDIH2TsCEV1pV4DT+T2F9uOEOaXxhHWAI+4uh?=
 =?us-ascii?Q?jbuxQ6AKXsSoaEmxZwUwEqewWQR2rf6meiwbmh71PYMHQ9nNwq3sYhFTTAmZ?=
 =?us-ascii?Q?Tx5RaSgbPWz3hpTsY1SgjV/vGW742NkX77YuD8dHHuC+KituKXIB3omNyUqO?=
 =?us-ascii?Q?5/TVhvyw8khGkWKzWKNv+IY=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a73976e-7d82-4db4-29aa-08ddb7633b3d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 23:18:18.1327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jW+uIN2x7/dl2/YJwDxk1991DRrA0VEPKi8RZar+dZ5pQzPFqBYzdFC6cCu0hT6HZ0uGEVlSLZaO0p8FVXqmsNgAC4IBYxl0IPLGrJ0yYHibfQObyUMaPcNhWVp241cC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5661

Renesas Kconfig is using "SoC serial number" for CONFIG symbol, but is
using "SoC chip name" for menu description. Because of it, it looks
random order when we run "make menuconfig".

commit 6d5aded8d57f ("soc: renesas: Sort driver description title")
sorted Renesas Kconfig is by menu description title order, but it makes
confusable to add new config.

Let's unify "System Controller support for ${CHIP_NUMBER} (${CHIP_NAME}).

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pmdomain/renesas/Kconfig | 122 ++++++++++++++++---------------
 1 file changed, 62 insertions(+), 60 deletions(-)

diff --git a/drivers/pmdomain/renesas/Kconfig b/drivers/pmdomain/renesas/Kconfig
index 70bd6605a97c..6d51dd2ab4e9 100644
--- a/drivers/pmdomain/renesas/Kconfig
+++ b/drivers/pmdomain/renesas/Kconfig
@@ -2,114 +2,116 @@
 if SOC_RENESAS
 menu "Renesas PM Domains"
 
+# SoC Type
 config SYSC_RCAR
 	bool "System Controller support for R-Car" if COMPILE_TEST
 
 config SYSC_RCAR_GEN4
 	bool "System Controller support for R-Car Gen4" if COMPILE_TEST
 
-config SYSC_R8A77995
-	bool "System Controller support for R-Car D3" if COMPILE_TEST
+config SYSC_RMOBILE
+	bool "System Controller support for R-Mobile" if COMPILE_TEST
+
+# SoC
+config SYSC_R8A7742
+	bool "System Controller support for R8A7742 (RZ/G1H)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7794
-	bool "System Controller support for R-Car E2" if COMPILE_TEST
+config SYSC_R8A7743
+	bool "System Controller support for R8A7743 (RZ/G1M)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A77990
-	bool "System Controller support for R-Car E3" if COMPILE_TEST
+config SYSC_R8A7745
+	bool "System Controller support for R8A7745 (RZ/G1E)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7779
-	bool "System Controller support for R-Car H1" if COMPILE_TEST
+config SYSC_R8A77470
+	bool "System Controller support for R8A77470 (RZ/G1C)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7790
-	bool "System Controller support for R-Car H2" if COMPILE_TEST
+config SYSC_R8A774A1
+	bool "System Controller support for R8A774A1 (RZ/G2M)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7795
-	bool "System Controller support for R-Car H3" if COMPILE_TEST
+config SYSC_R8A774B1
+	bool "System Controller support for R8A774B1 (RZ/G2N)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7791
-	bool "System Controller support for R-Car M2-W/N" if COMPILE_TEST
+config SYSC_R8A774C0
+	bool "System Controller support for R8A774C0 (RZ/G2E)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A77965
-	bool "System Controller support for R-Car M3-N" if COMPILE_TEST
+config SYSC_R8A774E1
+	bool "System Controller support for R8A774E1 (RZ/G2H)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A77960
-	bool "System Controller support for R-Car M3-W" if COMPILE_TEST
+config SYSC_R8A7779
+	bool "System Controller support for R8A7779 (R-Car H1)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A77961
-	bool "System Controller support for R-Car M3-W+" if COMPILE_TEST
+config SYSC_R8A7790
+	bool "System Controller support for R8A7790 (R-Car H2)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A779F0
-	bool "System Controller support for R-Car S4-8" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
+config SYSC_R8A7791
+	bool "System Controller support for R8A7791 (R-Car M2-W/N)" if COMPILE_TEST
+	select SYSC_RCAR
 
 config SYSC_R8A7792
-	bool "System Controller support for R-Car V2H" if COMPILE_TEST
+	bool "System Controller support for R8A7792 (R-Car V2H)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A77980
-	bool "System Controller support for R-Car V3H" if COMPILE_TEST
+config SYSC_R8A7794
+	bool "System Controller support for R8A7794 (R-Car E2)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A77970
-	bool "System Controller support for R-Car V3M" if COMPILE_TEST
+config SYSC_R8A7795
+	bool "System Controller support for R8A7795 (R-Car H3)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A779A0
-	bool "System Controller support for R-Car V3U" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
-
-config SYSC_R8A779G0
-	bool "System Controller support for R-Car V4H" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
-
-config SYSC_R8A779H0
-	bool "System Controller support for R-Car V4M" if COMPILE_TEST
-	select SYSC_RCAR_GEN4
-
-config SYSC_RMOBILE
-	bool "System Controller support for R-Mobile" if COMPILE_TEST
-
-config SYSC_R8A77470
-	bool "System Controller support for RZ/G1C" if COMPILE_TEST
+config SYSC_R8A77960
+	bool "System Controller support for R8A77960 (R-Car M3-W)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7745
-	bool "System Controller support for RZ/G1E" if COMPILE_TEST
+config SYSC_R8A77961
+	bool "System Controller support for R8A77961 (R-Car M3-W+)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7742
-	bool "System Controller support for RZ/G1H" if COMPILE_TEST
+config SYSC_R8A77965
+	bool "System Controller support for R8A77965 (R-Car M3-N)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A7743
-	bool "System Controller support for RZ/G1M" if COMPILE_TEST
+config SYSC_R8A77970
+	bool "System Controller support for R8A77970 (R-Car V3M)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A774C0
-	bool "System Controller support for RZ/G2E" if COMPILE_TEST
+config SYSC_R8A77980
+	bool "System Controller support for R8A77980 (R-Car V3H)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A774E1
-	bool "System Controller support for RZ/G2H" if COMPILE_TEST
+config SYSC_R8A77990
+	bool "System Controller support for R8A77990 (R-Car E3)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A774A1
-	bool "System Controller support for RZ/G2M" if COMPILE_TEST
+config SYSC_R8A77995
+	bool "System Controller support for R8A77995 (R-Car D3)" if COMPILE_TEST
 	select SYSC_RCAR
 
-config SYSC_R8A774B1
-	bool "System Controller support for RZ/G2N" if COMPILE_TEST
-	select SYSC_RCAR
+config SYSC_R8A779A0
+	bool "System Controller support for R8A779A0 (R-Car V3U)" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
+
+config SYSC_R8A779F0
+	bool "System Controller support for R8A779F0 (R-Car S4-8)" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
+
+config SYSC_R8A779G0
+	bool "System Controller support for R8A779G0 (R-Car V4H)" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
+
+config SYSC_R8A779H0
+	bool "System Controller support for R8A779H0 (R-Car V4M)" if COMPILE_TEST
+	select SYSC_RCAR_GEN4
 
 endmenu
 endif
-- 
2.43.0


