Return-Path: <linux-pm+bounces-42043-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCj1OaMIg2lLgwMAu9opvQ
	(envelope-from <linux-pm+bounces-42043-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 09:51:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F451E3567
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 09:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38C9430252AD
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 08:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5F8399030;
	Wed,  4 Feb 2026 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GPtYRxfQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013059.outbound.protection.outlook.com [52.101.72.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBF352F98;
	Wed,  4 Feb 2026 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770194923; cv=fail; b=QUZOBCXEj9EP5zCg0WIYkHJNhjfs1i08SEnYxk0xuxdG+rFxoCelhhqwX2puqZNZ5bcU3bnV4lBOSgoTIZLM9xZYZulRryLdhvXXmpNdJ0fCWoU5M1g5xU092+Ncnfdh4100CIqSTvOjBp7s+r9k6UxaRmyg2+OntVlk862dhKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770194923; c=relaxed/simple;
	bh=TOvCbTWt6am+7RVV7kPYhpHG7Msvs7Cq8BhjWO8AMMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ma6VjnGpeHx69aTUrdRWNNiZwRZEayLJFLJJBeKbrE+7FHV9xHOLS3L8BOfOLTHyYI7dcsUiJKUKk0Ws6LqLTZ+gdGqgXLj4x5sRYYop7z4x2I/varjJz2W55tM/7sekX8cfwQ0YqqKi3uEEpxo5CXugOliDURXbuV7vkXHjSnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GPtYRxfQ; arc=fail smtp.client-ip=52.101.72.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C95dMMoQuFdofMdn4NHy3T5Z7c14qHzhHWxEuU+76wYuFknFKSrW2WU3EfRH0oALsdZlwjXgjXuejfSaEaRwM3G4v8w6KL+Cb7FrbwDHYYIfztlvmGz3P1xxDiBhsFL0UfJlc4QJ6b3YyESP0AeOknU1FDOD0rCWxl4CF58hpsN4YR5UMoErlUn7fFz/s2teSmjaeBTrQ0188DqfECDItgi4eSUfdZgLSUmTZSzAN/3AkyCKYfo/DhPXHsa8R5ala1aeGf3Q8SXMSTr4xSu5lTqI4cjfBFreu68en9qPE+kFAvquOYkp0mgX1nCwaTmh9J/onrjny7QQJk9qlUfCWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HxJibqe8D4Gx4xTBQ7Wpzv8ikZXbXdDdChs6ZU9e/U=;
 b=JJhWJVwI/y5s8/X/0JnJvSXnpUOZDe3spYJcHQOJiU9BUKzv8hmU3sJ2dWAoY3/dARf9l+XkugYO+RGO56sBn4pMCB7yspOn8gT0Z79OsWp0kyoCosMtEz07aQs1YfgECo9weZw2oE91Gkfz8QQyJovOUotQAJkjFXPWc7zUCiomNzh5bgw0n6ZJA25EiIvNRlwym4JVceuovKpOb2GmbfNW9c7N1oHz6H4rzrdArZ96eUAIjcXqMYMAy0P7jwVa0mNlTBjHenDD7bXLFPvFxC62fKymcKwGtOwKpQg1iZMDswrK0I9cN+r1+WchERVDrV72Zs9eBr+qlw697YJNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HxJibqe8D4Gx4xTBQ7Wpzv8ikZXbXdDdChs6ZU9e/U=;
 b=GPtYRxfQoE4D8uLPZE5UsxMyeayPBiDxm/KTiLK6QaQ/gfziPJsKmE4IOhD4mlbooNNKJfTRRBr2dLnHdyZZ+kaXz+JaTFJQiGWdWO3z5CYAaUHx7a0RHeQ7ba7rQOugqOVILznPy/Wn583xuxcGg8n+hZpO9dHPPgFVE9E/IZfC2rpC8JBi2BEnuTl1THn9AH89CIeppCjUrN49ocaQwAQDgESIJpL+llo57LK6Tuepivn+g+zP2ji8GDYrBL59lqEZBQWqTf8Bz15+sAfXupLQWjzEHP3O7PjaF7NZSGEfLAJgXDUGkyatREyEUo7VTQ0aTza82Fk7Ye8SSAxP5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by OSMPR04MB11296.eurprd04.prod.outlook.com (2603:10a6:e10:93::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:48:39 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::52de:f9c9:8c2e:7dd5]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::52de:f9c9:8c2e:7dd5%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:48:39 +0000
Date: Wed, 4 Feb 2026 16:41:05 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, peng.fan@nxp.com, jun.li@nxp.com, rafael.j.wysocki@intel.com, 
	a.fatoum@pengutronix.de, ping.bai@nxp.com, shawnguo@kernel.org, l.stach@pengutronix.de, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pmdomain: imx8mp-blk-ctrl: set awake path for
 power_dev if attached device needs wakeup
Message-ID: <lh3cb2r3qvv2ar76ai33fjiuseqyiwoks2zjrmowknvut4qfcg@2db76miyk4wn>
References: <20260202074730.738760-1-xu.yang_2@nxp.com>
 <CAPDyKFpqfo1R8Qkq284L9DTURjZnvm_n8W3a6KQTomg7A-M_Ug@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpqfo1R8Qkq284L9DTURjZnvm_n8W3a6KQTomg7A-M_Ug@mail.gmail.com>
X-ClientProxiedBy: MA5PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::15) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|OSMPR04MB11296:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbd65d1-51c7-4a4c-b357-08de63ca2f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PiayPJI/dzLVuuQG4qJFZT2kCYDjBnnTsv6r6tFoR+ieoYvioZC2tuSntx/v?=
 =?us-ascii?Q?rVEstHtIVnxjUajzTE6vSiRP7zcn3SGrmBBvTm5myETbdd0T2cLxxY+MY7DX?=
 =?us-ascii?Q?47Qql80Yy+akIQmrda2vhcNNmCoDXxQPhnVYGLPqA5NOELYPtKKp1BgHpkpL?=
 =?us-ascii?Q?wRrbBQKV4BQTd/GoDcbgpgp6jlCvV/uBrOwIdG6ZovLx6K3hC1wx3zJFxBU3?=
 =?us-ascii?Q?pSd10OHAQdyrsZt92J6Ga/4FmKjOePJoei8pthUAgtqI8amUinAadsuoZY8u?=
 =?us-ascii?Q?Vrl2zXbwjtJbreuQ7+Inex5YH9mdjuaWlo+eWveJbbKdMAtZrZ/nkRe6Snek?=
 =?us-ascii?Q?fRFzqM8CzTFdboSVlgM73dbAQXtsK2pufV0GTg1d0Nx4RKkB2RNlrASmwFqJ?=
 =?us-ascii?Q?LiSWS2Jaa+RDyGHMvcjowVVAuAXzHan/WA+ChuPDrFaTRzcqOA+vuGw15Mrf?=
 =?us-ascii?Q?mh8jEeukHOMDW6FTLlK/iJ4uIvzO5vksSvHkBWNyUqicc1Dz+/hdIcDn37yI?=
 =?us-ascii?Q?FvQqBSMXLo4f0qtgLs4A/qnlS4y6yACrW76H9PVt4ztb5mLPVRbAnTkmQpjE?=
 =?us-ascii?Q?K6dOpERe7ffiI/lTjYP+ODI6f4TSqlP6W4q0yGWSj01ReGGvHbp1Apuzxaxs?=
 =?us-ascii?Q?gdX5bkalMZZHDdrkrYiQzwC2T4joAA4YAe1l3ZBMdG55/vU/lv7WZhP1qg0Z?=
 =?us-ascii?Q?ExzrTPn2o3EbGa+LklH5iqd58q6tsYMHm3HfgcfzbbOoK8WVQoUK7YSSTlNT?=
 =?us-ascii?Q?DslZueL4pBcGl9MsKOiojEktYkCb3uWCSEzO32JDcNhy8vZNIi99VZegkPF6?=
 =?us-ascii?Q?9KdcdI3IP31TdKXAWLTZJ/WWwHKnpMSdv5nHHeZI+lJOiZe6G3DF2FoWnKeK?=
 =?us-ascii?Q?uh/38V/GUsq7woaBRkPkamEgem+KnyymUU0dAlSO/mhr55x7Su3K7sX9mgwg?=
 =?us-ascii?Q?jaSd4XpAEN8WkNzyhJ75clZ56XalGfJut4DNk7m92gsUF8+Q+5BfHNjVXWZN?=
 =?us-ascii?Q?C8yN4wkn80gklgKyCWPp311i9clTPzXfxByfpkIwQu52+fw3m7Bw8Fr35ci/?=
 =?us-ascii?Q?RVtrzAxrMcRMHNzbiZJAaWnicitXl1FiyYlZ19f81SwYx7sHtCKdSq3zFxyD?=
 =?us-ascii?Q?gHioZdMEBNwt4pz0fWFLA5BZIVCGPppiWKG2MmH12fjfBjP7uMuCVgcrcqjM?=
 =?us-ascii?Q?csXHoYoHK0WZccqJFkE2CcZ8t/d8jyzkzm4JgUBU1lXTTctFWlQS6TNYItRb?=
 =?us-ascii?Q?YWgr6guNhnMo5JQZzCAxzQMVhBpNEZFDuvxiEsDbyIv7NbxJCdSIOPIWdpxm?=
 =?us-ascii?Q?Asw5+IgyLqbLubll7m5CkfZIqh+2wqOYE9dukf27OPONGSW1QL/UNdi5yK6Z?=
 =?us-ascii?Q?KyNksfNz3XQ2h+hPiXROoctftL98td+1ffDHsCVQ/v8XgbYlITWcNesESDxk?=
 =?us-ascii?Q?abgX7aSnQ/QKECGzOjZVvKXV3LywJDu96ntmpLsPg8uhVyyO5kMpeJ1ap+qx?=
 =?us-ascii?Q?5ehfnbxf9OgALlKvVku6/GBdkG4BpXpzxNRbFpKeJL4Afmecuu+UBEK1Bv+j?=
 =?us-ascii?Q?md/biPrdFDrmFVwMrRQNW5klp7Pa8pN5JKV4jBPRkdceeEZOQMocDgcdoE6t?=
 =?us-ascii?Q?s2TUIZo6J6+3QgDnABXWLSA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0HaFrN0nq6qlik4ylVDPqidzNDKzQJB5vJajH6/nBdw44PEiKAewZvq+VLmO?=
 =?us-ascii?Q?8/fnFvki2XMg+o0UYzAGvNcsidaTZkbnAutbUQGTGpqYEa6LSGHXRDOySH5v?=
 =?us-ascii?Q?lFred+iR9pULSIOFKIWEQuDSlYJZvIjMpYT6iMT+s7r4nV2EreznElHZwzmH?=
 =?us-ascii?Q?tLF4GtMOfnC7iBtSDKEJnAsR4S3Z63nIqu+wT0lnZSLI76m1kv0i94GB4W6h?=
 =?us-ascii?Q?n2uUSxFigU/PQjlwTi37SfqKAIRnbhSTLIwJjL5TryI/x7aN0EkriXmYYh74?=
 =?us-ascii?Q?PzlVDYe1vEIsf5LWb0ExQoLZRuWvRECfdAWQzsWlXJBTHEFJ+D/b1yh6xFq7?=
 =?us-ascii?Q?aTYjctc8vI+VmKl9OuA4AsPiOE34eB0YVRUTcWJWDOGEq2WNC8HZMng0cEJH?=
 =?us-ascii?Q?b6DEWl7SC1mZSXpBnKIPL8lS3HntzFvCRpcjORENnkYkv3IbBWwy8ib30wbn?=
 =?us-ascii?Q?77FLJrV7vmaMxw7ONOoJLvCqSSBB3rvEnRWCSsvTIzLN9hZLhDjIhmmFwtoh?=
 =?us-ascii?Q?j3ANJE33RU2RsIg/ua7Iq6B6HJ/CtH/ak2tBXaiqYfcBym2NHoQPbLb593C3?=
 =?us-ascii?Q?jsmPYTnXUm0fByhkBIjPEs3g2ydnHAQNVLoXRArHbnQdWaYhpLZA2C+TrCMH?=
 =?us-ascii?Q?4D76bP9SnL/uyWs+eqworStSsiErk7t7DdMY6YEy4x3ViuQdjRm4sQJtdnIi?=
 =?us-ascii?Q?AfFeoqm7PzWQY14t1pT2KdaaYKGZY3NbuJz94YzvKUF78nQDdEiHJDGHctxt?=
 =?us-ascii?Q?DI5KJ5EosS/X0Q2Eyit4bOeFZmhdbOLjCevi9ewT/zzcepT7rMyJNaDLJczW?=
 =?us-ascii?Q?c+UfljQaDlPyKcdcp/g5un82xhjfiiC/ABSl9aIE2rQZ3ePYDQa6YtGifO8J?=
 =?us-ascii?Q?FY7esFCjJPsIl0UahuYVFj9NPE+jma0KXH/fRZAOIOI8To8jQYrBAe0SScDj?=
 =?us-ascii?Q?Cakpfrt+M2gu3tdLB8JD7zZ4WE7uJvw1p0y/5KZCfSsgKvfxEhFGMJ52lC3d?=
 =?us-ascii?Q?JPAqwhPCJ46NXdE0uJf3ejeRNBerjevrr7aHWVBFBWcxH/3RfX7e5x9Z9Hp4?=
 =?us-ascii?Q?YH28cybncTtPU5BL3yISCAAcnvCsInqcx3QUAJmme2YXY1wHxHT6MCf9Ob8p?=
 =?us-ascii?Q?D7hCgy06mOiM321oVQQAm/PHSqmLWz7Th46P2rIlDKvNlkwrSTKyvFhRekg2?=
 =?us-ascii?Q?amdLpvTH5h3tHeVVj8KKkFCQdfWmT/Rv1vjOSJRmXaEo+N1D7PUkgaAe8MPj?=
 =?us-ascii?Q?UoWpwMevUrHwZJVrYuJJH1YOtERoZ7722gUBjPTlqRZ9dqLyLrjMyAuPdetU?=
 =?us-ascii?Q?yXN9R88Gqp8pzO8sbumcxOpmJzIYinHr9x/Bz99wcVm1MlGiRkRHs9Pu61AG?=
 =?us-ascii?Q?nDdRQVjkZLx3BIqXqdUImO4mWeQgcAnvXAGMSyAqRS9zYchpmcn7Ojn2TZtO?=
 =?us-ascii?Q?JRkXJfZR3+B8bx7GALp5G5DluTWs9eJcMR6Z2iLFHhchQvXWhWwwVmFvD1VS?=
 =?us-ascii?Q?iMkTA1xxMcDUtkDdE6J/ot4tPaq+XU5zi2trTRZsraoreWKYCRB82kgM0eLV?=
 =?us-ascii?Q?Z5AMEO4qs4ElrgZ87h8LOT6kMAP3XKpfKmcGL6zlbm+31cgM9BzVImji5JL6?=
 =?us-ascii?Q?Vwo6AGgCR2rrn9oWBLs+BuG21Iimp67jEr+jc0o0oy7jq4yX3zxpM2NEtXpj?=
 =?us-ascii?Q?S6UfV8+knwcxO6OFJQkgebwwbKpW3i60zKfa+C0UJcS09wDgMkpXMUSBg9zR?=
 =?us-ascii?Q?2Au41OvY3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbd65d1-51c7-4a4c-b357-08de63ca2f43
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 08:48:39.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSwXr1RZoPXbhyx0vTISZCvnYGnASEBXp7sa3vnbEN3DfWU29ulIsOj+S0uR0MFtRfve7kfGo5AKeT7Jvap2pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSMPR04MB11296
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42043-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,gmail.com,intel.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xu.yang_2@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F451E3567
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 12:06:28PM +0100, Ulf Hansson wrote:
> On Mon, 2 Feb 2026 at 08:46, Xu Yang <xu.yang_2@nxp.com> wrote:
> > +
> > +               list_for_each_entry(pdd, &domain->genpd.dev_list, list_node) {
> > +                       if (device_awake_path(pdd->dev)) {
> > +                               device_set_awake_path(domain->power_dev);
> > +                               break;
> > +                       }
> > +               }
> 
> This is really messy in my opinion. Ideally the above should not be
> used by a genpd provider as it's internal data structures are managed
> by genpd itself.
> 
> If I understand correctly, this problem boils down to the fact that we
> should have tried harder to model child/parent domains, rather than
> using runtime PM to manage the parent domains. I understand there are
> problems with that, due to specific power on/off sequences we have for
> imx power-domains, but I wonder if those could be managed better by
> using genpd on/off notifiers?

Indeed. I have tried using subdomain will resolve the wakeup issue because
the parent domain will manage the child domain. But I shouldn't use
subdomain and runtime PM way together to avoid any unexpected behaviors
according to my understanding.

> 
> Anyway, that said. Rather than walking through the list of devices as
> above, I suggest that you use the ->power_off() callback for the
> corresponding genpd(s) to dev in combination with a genpd power on/off
> notifier for the corresponding genpd that the power_dev is attached
> to.
> 
> More precisely, if the "child domain(s)" that corresponds to "dev" has
> not been powered-off (because device_awake_path() is set for some
> device) during system suspend, the power-off notifier should return
> NOTIFY_BAD to prevent the "parent domain" that corresponds to
> power_dev from being powered-off.
> 
> Would that work, you think?

Thank you for the suggestion. It works for me.

With this way the rejected count is increasing. Does this have any impact?
The count is just used for statistics, right?

# cat /sys/kernel/debug/pm_genpd/usb-otg2/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             1203           0          1          0          0

Thanks,
Xu Yang

