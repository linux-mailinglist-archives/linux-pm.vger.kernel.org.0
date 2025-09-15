Return-Path: <linux-pm+bounces-34626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 698BCB57181
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D7457A80D6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 07:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F592D5C7A;
	Mon, 15 Sep 2025 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AYiyBdLb"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409D52D5410;
	Mon, 15 Sep 2025 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921399; cv=fail; b=GqiJG/DLxQ6tu5H4vckHhq6dhH6aCBBudcYDohZKgJjOMhnpt3UVnlyMRLq0j9dmvhUVlUvbgtkT+bsClJs3lJsGYXJ9PWEjAjHJtrQstMJOiymb5Wuef0cH1NyvFMZ44OjxMjVm/Jx9uxDKg3uxvXfBObZ6vdLqX37UAicofoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921399; c=relaxed/simple;
	bh=dvBeHqr4imYeE0Qb9PJySzp5MjgAEJh/Z0RVA/KVZk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WduRbzpUUSqpiR4lGphSzxk3YS2eWPBjXl49SMlYUhStLSZmYwvI5KGohub9yHS6KQB8vuYLFxv2VXwCAkGXUVGjjcY70yj1wMbsW92rf8websvMUoZuKMWpVAON+KTlvb5UhEwHPawD/YDjKmiiPisBT/FUcYlViWx7uXsZaq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AYiyBdLb; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTL7o5SKLpoOyF8rpZlqFsNNqjriGc5MCGPM6iNhM7bwwMpF7ervCvxu01iSzGnwcz7qY8d+/Vu/S3/AtrdmADz4d+ID1gRKL8PhJyBjbWK9kLVhJiEe0xMg8mZlrWw2fjXUfDtE+bUwFLTceaiaMlP3mB/t1FGpD1wfqE0o9t0JHBYpxqtB1Y8K9999fGFZ2Ftt43NMjbJ/joa1+cRhW91oesRfWaLzKj4QULp9E8UHDbehZ+VYd18SUIpe+EJxYXoACapSp5UW3ubUAzENnYW1vGmnV6Q6hmGFja9imhjxhg1XC/3rYZzzBOTMuA2nXjIo+R9SjnoW7SJH3zG26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J7rcDjlzsxUSKr7FbiXE4MaBEIPfByuaexWnWUofWc=;
 b=XRpMm7mXp9cA0JipAAznctqbs7mFE3OjItMt36N0NDS2TwTkZCL8IucF9dQjyb2zDWEOMxKn4Smn+aWV0j+pvJbuYSmeinekS/y70v54SfaUZTe1eVDQyXk386JidZqY+eThkBV/95fR/zSWYZsrAVaHNdiF+NxdSxNb3l7NdHidr57jP6jlC2mBtEIUik3s/ZNLvzoQpV39KoB4ukoj9EEx4hfAsQWLr9h8MVsmSkIg8roRjBaiasR+Pbik+6E/1ruaMbCtSOivzb8BnzB+KoAUjVmSV/6mm9NpasgmrMzZWfu71ZPSsuIUFC3DsWrF0W+THJGa9xMKjLeASvimAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J7rcDjlzsxUSKr7FbiXE4MaBEIPfByuaexWnWUofWc=;
 b=AYiyBdLbkh5nDnYSw7CJe1WOaKdeeveSvb+4CyVzb3uJPHMbbHQFsjv9OsxGhNVJTzPc0IexLeCYHdQSLRI3q28KED7ESysysX+Gb74rZI9Ghv8P4kcS3z4yfcM8GJ7I6cbp09CzSZFltay+k21F45Z4IGx+l+2eOtePStBgLM9YaURONLfNJuGCARSOGOea5GAZLcF7aqBukPJwfIvPS0VMZ4qMOwcXVhk6U+4VdFN+IIAvCIdfHDDaUfMzCP/fYtTkdygDWG1gnIjBQcTRsJFRdLFNL1+Kao8rrasgFX4Lilhw+N4Pk+Im0/lxqCuUqEf9h91sjpFNXdGgNqlWVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6866.eurprd04.prod.outlook.com (2603:10a6:208:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 07:29:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 07:29:51 +0000
Date: Mon, 15 Sep 2025 16:41:24 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Duje Mihanovi?? <duje@dujemihanovic.xyz>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>,
	phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/4] clk: mmp: pxa1908: Instantiate power driver
 through auxiliary bus
Message-ID: <20250915084124.GG8224@nxa18884-linux.ap.freescale.net>
References: <20250829-pxa1908-genpd-v3-0-2aacaaaca271@dujemihanovic.xyz>
 <20250829-pxa1908-genpd-v3-3-2aacaaaca271@dujemihanovic.xyz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-pxa1908-genpd-v3-3-2aacaaaca271@dujemihanovic.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: e536be50-7a54-4dc2-7e6f-08ddf429a885
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/G9lUR8fdahaRG1/Qqw6k1If6k8P/RQ3wZBq12frs9QlbrT6svYc1O50H197?=
 =?us-ascii?Q?ySgjGeD677ySskKWX3jLdzz7WxlITyj4TjtwFPaBSQzOZ3hHAeQ5lpjcah+i?=
 =?us-ascii?Q?mHjboZ6viVtst1RO9tOXG39G8FgYHjkWi4wXjMM9f9ZBQbu9mmeozv0A1eCh?=
 =?us-ascii?Q?knJlA2wVESf2irrZy2Tjil2UfGCPsFyRMTpPX7nFqU6Lh/HEYGWX5j1sYf39?=
 =?us-ascii?Q?DpwX6byp7hqDnl7YCKljDA4LcZSC0HVue7d3fuRpdiuLgfsaQGp1iEstOvsg?=
 =?us-ascii?Q?l12jkV3U1XgVae005WWFhJPNay5/SuC8xxVduTG+NxhbC4Mo/mxHK280TSBw?=
 =?us-ascii?Q?337hv1xNdIc//Y6XPrjX6/cwBPaP536DbVkztNFXlc8JQzWePXEzkcUecvSy?=
 =?us-ascii?Q?CtzlEvWey8MT2fETCqB5YafgFUmLbzbJR+OO72QlIzxeFHnHPhyN85PXPYTN?=
 =?us-ascii?Q?w2ZoEzlttwK7MYRzUyYJEqUtfovoGDktv/JtS0nPl1kOIV/Jp0lNnX553+Zn?=
 =?us-ascii?Q?PbP80U5Fq25a+YU91jZv2RAkENVhG3SGotoOnFCn6+4/MOP5lX/ZpD/8cFhW?=
 =?us-ascii?Q?IRBhILjKhaTdx/eyj1K9NK31w5otJwgtbEyfjuqzAhAPVS9WKPkSVlbhkHVU?=
 =?us-ascii?Q?f0vFEXUtxT0yZlpL8Zb28Kj0fJ+qmiAle9e+IyizdTepBzTH87WFc7HZ4GUi?=
 =?us-ascii?Q?w0uifWOaAKj8J8SMqUr+8v1SCQd2nczueI3oDXFyPaUPNY4oQ73I27viqIMF?=
 =?us-ascii?Q?O5NIdi45bUib2gdIPq57n35vDZAfP8WiqtjTzPieFUo8muZ4mVcx2norrPQ2?=
 =?us-ascii?Q?nQqAAGk3fiVuGRRSbPM+NIVkZb6g15PONJEt7gOqaf1/a4IE7HeO/V2TRKnz?=
 =?us-ascii?Q?c/swFERXWmAQqSTeRPJdG0jmB1uyKaY8zsnN4P9/gPTG6FpG/BhL1STLrLQ1?=
 =?us-ascii?Q?EkVsZlThAB06Dr1ixdKveHAGAr1iFihYgRvA9DhPZBrCgynEH/c6OPDEsvcS?=
 =?us-ascii?Q?yGp1hxRjsY+4LQMVpDoXSaTS7KmSrlK50Iu6iTwlPvqrOQoo+Xt+97qdYDDU?=
 =?us-ascii?Q?W5qZVohzbes9C4uvIIatB989S2uk9+75urik7eX1Tvam/7jFoibex7jDQxKz?=
 =?us-ascii?Q?UPY25d9j5t3EW8movoJmuGwRemYFppn9UnjElQKUaT35zToE9sEp7nsLqNQJ?=
 =?us-ascii?Q?cLdegIW/Z4O3D3jPDs5IlP7BbclkeuY1dVnm2eCVAAVbZEPrpi2Rm2OGzdvh?=
 =?us-ascii?Q?+lGfRRgpM9fsVB+xvoe2M5AyO8akj1lcE1P8bPHU4UcUEiXKtVc5SjFcqn/W?=
 =?us-ascii?Q?z7GSjFE1TJ6pi6z+o/u+EEV/l2m6tTFhJhCuvvturYO+BHZYj+TLaGvr794T?=
 =?us-ascii?Q?DKwOyIr5E7yeuHY4DIFLJMZskQ9Me8WQBqXi16u9ij36hnVfMEn+Kj8kpn+q?=
 =?us-ascii?Q?oc3f4RE9jx9R4kVM+N3KTDZe657usr5o2T/LGYsznen7ZNxGR2zYog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s0goErHCqQ50vpbCe4SoLOj5ABc7cFeF+W7B5KA22huKzRJhibNEDpF6uiDZ?=
 =?us-ascii?Q?KGgAZYqCVixeJUB9YcF87vftE1AC/f9F1QQPvejJk4CrVa/eLJpkm2rCzl3o?=
 =?us-ascii?Q?aXTqH50kgN1stmQs+sQ7Kln606L5YwI4WcmaK/pm98r3F5+nm0T7V6VPL9KO?=
 =?us-ascii?Q?lD6RRJgdoGIOXxcqcSndNC4xLMWMD3cemghD7VWgwiQ7rvBu2Rmm1emJVhY0?=
 =?us-ascii?Q?bcip6tS1whdsmr8KHo6jdd5HMjcXyIEA8qz8kCgI/tGMty2yMF3poy8GxTci?=
 =?us-ascii?Q?wjCFHu8t0j+x7v2W5Q8W89MImEeQvdkhf7GZI+phMZOp278GZbvXrD9LTOHH?=
 =?us-ascii?Q?nIoYNLd0R8vOE02296TRNuzC4P63IiLXLMkMBWGV4wYV7c6fI8xBhQU07NQc?=
 =?us-ascii?Q?bl9e6I8xjCE8c6t/BO3dkbC1Bb1BIVsBpgz7jOylchlVCVQFHg18IX39kbrl?=
 =?us-ascii?Q?w6g1dFnNIxl8V24k+AGHhjtOaSkTLYJjx4UUKsb5zVgnVHLH1z0LHv27Qwy0?=
 =?us-ascii?Q?70vBvV+11I+s/pgWGPzWu20QLBd0WDzcn2YsAC3+OYxVIC8fecGQbtnhq0d4?=
 =?us-ascii?Q?vCbm9QFg0+Yxovl2kEBf78xIiyZmVKQS2OnSaoD77AhCGbOiJj9vAxXavAVn?=
 =?us-ascii?Q?3n12vek/zbrcAFGwHRrKw1uu8uj+0qLRO8sth584PB+UYcphEUYzLIrUZVFC?=
 =?us-ascii?Q?z8wuuXfE2ib4HEtb6QvqxKU1zZc863J1x9DUydXkaEvnlXAo0HWXqxePOm0d?=
 =?us-ascii?Q?Oxd079tYzWTL4Q7SZMz7slL+dzXuMYt32L0v3UB3iduA4SGfpui/rFhDHvjQ?=
 =?us-ascii?Q?et8JN7h8G1iSSKyrKd1gxvOwnqA3DvwJUGuLYFtpW3XVJ+nH91cQuIowS8Pn?=
 =?us-ascii?Q?aCSJ6qy271H0zP29gC/suxr9PKwI7PA0tKKZPmF5qTB+YddrVDQAAink2EHp?=
 =?us-ascii?Q?973vjWCZ6f54ZnciuJuu6IYnujkuc69i+41EYs+gR1OR4f5SyIAHuWPa+U7H?=
 =?us-ascii?Q?uyXe8+izd5SieG0CGv+gPdM7br1gQHqjqDRG3yHogU1gHAu/m8DsxSkZYw5+?=
 =?us-ascii?Q?GSo7KU2jv3xGJ3SEmNRdBjd3z3eiL7xuoWrihz3gfA2UseuEf+YR7ncpSb0T?=
 =?us-ascii?Q?jXka3vzNdtG706GFHu+ExgxpfihjB9tnKV/U4RkP2J671IASHe8nrXybLFbz?=
 =?us-ascii?Q?ktNxpkvTbh5f8pCjgDDl1DRxpAsbO0XI0s9iiwXJUZb9zluS3R+3ql3WxGSE?=
 =?us-ascii?Q?v4gcrkg4VqIPATDBFg6gyf7RPgWi0PlxSo6S957frM92RmPRsGy2c1ybMt4p?=
 =?us-ascii?Q?3XITmJqKuxXpNks5bM0CUFH/zko+g9GXPDjmpafDXElRe+bPixuNJl7aiyUA?=
 =?us-ascii?Q?GNr0zxyC7hu7O7SwJM+/LIxTpX/8isjUwNxRzTNinVp8aUDlHP8bcDccSb0B?=
 =?us-ascii?Q?F1qgHCpokzNoMJtxkkfAfihQ4N4XzbZ2CbjxPby7jpCr0DJOgygM88it4g0Y?=
 =?us-ascii?Q?ZCogPEy1exMyfYKTvE5Uqf7J8ntVAu7w/UwVqWrFjh32ghEZBeS+8i81eCLz?=
 =?us-ascii?Q?1JlgkGWJCL6Dv5ghACEu435RMAUHXDu/nWElQpqw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e536be50-7a54-4dc2-7e6f-08ddf429a885
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 07:29:51.6629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opwFpw9Rj9VBCpkwaJ60ILlqEK7Zbil7jlkmt+n9lyUhXmX15YYbmvIRW+1rD9jmFsDTcd5BSVs10Sxm87gD2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6866

On Fri, Aug 29, 2025 at 06:21:06PM +0200, Duje Mihanovi?? wrote:
>The power domain driver shares the APMU clock controller's registers.
>Instantiate the power domain driver through the APMU clock driver using
>the auxiliary bus.
>
>Also create a separate Kconfig entry for the PXA1908 clock driver to
>allow (de)selecting the driver at will and selecting
>CONFIG_AUXILIARY_BUS.
>
>Signed-off-by: Duje Mihanovi?? <duje@dujemihanovic.xyz>
>---
>v3:
>- Move driver back to pmdomain subsystem, use auxiliary bus to
>  instantiate the driver
>
>v2:
>- Move to clk subsystem, instantiate the driver from the APMU clock
>  driver
>- Drop clock handling
>- Squash MAINTAINERS patch
>---
> MAINTAINERS                        |  2 ++
> drivers/clk/Kconfig                |  1 +
> drivers/clk/mmp/Kconfig            | 10 ++++++++++
> drivers/clk/mmp/Makefile           |  5 ++++-
> drivers/clk/mmp/clk-pxa1908-apmu.c | 20 ++++++++++++++++++++
> 5 files changed, 37 insertions(+), 1 deletion(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 34e5e218e83e0ed9882b111f5251601dd6549d4e..88c0df09d7b354f95864f5a48daea3be14a90dc4 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -2869,7 +2869,9 @@ ARM/Marvell PXA1908 SOC support
> M:	Duje Mihanovi?? <duje@dujemihanovic.xyz>
> L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:	Maintained
>+F:	Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
> F:	arch/arm64/boot/dts/marvell/mmp/
>+F:	drivers/clk/mmp/Kconfig
> F:	drivers/clk/mmp/clk-pxa1908*.c
> F:	drivers/pmdomain/marvell/
> F:	include/dt-bindings/clock/marvell,pxa1908.h
>diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>index 4d56475f94fc1e28823fe6aee626a96847d4e6d5..68a9641fc649a23013b2d8a9e9f5ecb31d623abb 100644
>--- a/drivers/clk/Kconfig
>+++ b/drivers/clk/Kconfig
>@@ -511,6 +511,7 @@ source "drivers/clk/imx/Kconfig"
> source "drivers/clk/ingenic/Kconfig"
> source "drivers/clk/keystone/Kconfig"
> source "drivers/clk/mediatek/Kconfig"
>+source "drivers/clk/mmp/Kconfig"
> source "drivers/clk/meson/Kconfig"
> source "drivers/clk/mstar/Kconfig"
> source "drivers/clk/microchip/Kconfig"
>diff --git a/drivers/clk/mmp/Kconfig b/drivers/clk/mmp/Kconfig
>new file mode 100644
>index 0000000000000000000000000000000000000000..b0d2fea3cda5de1284916ab75d3af0412edcf57f
>--- /dev/null
>+++ b/drivers/clk/mmp/Kconfig
>@@ -0,0 +1,10 @@
>+# SPDX-License-Identifier: GPL-2.0-only
>+
>+config COMMON_CLK_PXA1908
>+	bool "Clock driver for Marvell PXA1908"

tristate for module built.

Regards
Peng

