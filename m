Return-Path: <linux-pm+bounces-23614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD7FA56489
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 11:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CAE1896CE0
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719DC20DD52;
	Fri,  7 Mar 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NCPBBNB9"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CB120CCCA;
	Fri,  7 Mar 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341741; cv=fail; b=N6EETr+/HR3dG486pMBq1fbISejO5idkA7jeOwPX6NMSveDI4Wr6bL9dABcaABk0HCbfEeHMcO0kE2RNi1x3rxHVyh01ujIE6yOCtqgLMTMkKgO1yLYMMeoK+xLAo6qrk/YlabntooiJJXfa0axxJiJZxWCks/VTPLXVEFta05o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341741; c=relaxed/simple;
	bh=drzpgbg6vq2vR0eH3br2chdGAExhYiRIghSJQKH2d00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V+YWgEFV+RPOXe7tIsgSeAccVp3FE7Rd53XFln3dS+JP5BaXiISNGFIQxFx4q46AF1DUIztXxzI4cnPqoi9cq37qERCwxRjpT78RvVIdEttAK7Id0fy0tCQLGoLTah3CMs8J/o1C4KlJRKN5WdgE8by6Ej1FeJKpnDE0v+wKka4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NCPBBNB9; arc=fail smtp.client-ip=40.107.20.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMk37CQnAFH0CVwd2Zmu5p1lArt8unGsrgKL8n4obY4F7kLQjt4c5CvWwOwqvg5RZnM+VkHM1oiulGQQMmWoWivnT8DNJYxwxp35C/84K4hoVDsy1O/eTFBzLB4uLtfuzuZVU/36whTlRcNiopRmsWxMniyErfAjIVPS2YH6CgIgRrIuyNQgEcwX/uZaOJ3BoU/cEQC5A4WI635WtHpn0RbRBnOJFeb8POK7HN6WY+lg/db7EhphEW/TSFN2SsZVJxAl+4YS7BNGyX7kBkiRyR52xv0LOV6mQLtVNXNpA1ziG8HW3JeP3W7DLnaZs9QUOU8L26MnVmecEmUdoaKPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLNeC3cCrLgVG95IZnNEOhI7zuA5YiCMnWZMJ3rpIFI=;
 b=Bi3iMhgZ3R7jDis4YRkWRzeSPlCdcne4JnACZbirRedV+Ec41JTlCCk1cu6EgSFuyL+V/nm478lAl6l5a/PlAFeOYPjOdlh3KLJxof2Mp6Z9h5/dbuM5XIqipn08vDor7PEkrbYpQAiegDOJQt8r3ZxfiCBPvcfo72L2PbBFE19+ABO4ejnQUccOhbtJ5UJvemBeKxSUFoT8luRYayAVTQY+kMcOrhPFoV6NVNzIakG41o1fWx1FkzP8XooZRjmvwWuPpR0iJyZfThv8DSPg05AlPD8fM4sonSS7F7UufiJtEbQLOvbogGWGV6dT7m4JfuNqiyx9AC94xztCDv1A1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLNeC3cCrLgVG95IZnNEOhI7zuA5YiCMnWZMJ3rpIFI=;
 b=NCPBBNB9kC6IesR8ANO+rGVKWFz03UPNJw4XqGFdQPkJjUUDX056ARgt8W+K1DhjNUbyrxBVg/PZmiwwF7LWDvSs/DE2oRoWVWEBYsx+zso9aqOHob12AhkrQx42FZW0q2+Rg25D6DteaYeJlbXEK8FOTK0nvz6EfQBCxuqc0OJnjEhKl23rcE2Hl+QfSUaTfRmnK1+a4xuuoKYb3OBTPY0X+kyZ2mb5RLw4iV7iyxitU+jJbz4hOBTUvlXN1ZzAJr4ufyqM4Ek6+kksOI83Z3tTNL/kgXssjMj1DagUtwsPFxSuc125ECRDSOCgvfKvItBfuuF9hP7JMyDwZg8VvQ==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by VI2PR04MB10167.eurprd04.prod.outlook.com (2603:10a6:800:22c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 10:02:14 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%7]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 10:02:14 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "james.morse@arm.com"
	<james.morse@arm.com>, "d-gole@ti.com" <d-gole@ti.com>, "anup@brainfault.org"
	<anup@brainfault.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "khilman@baylibre.com" <khilman@baylibre.com>,
	"quic_tingweiz@quicinc.com" <quic_tingweiz@quicinc.com>,
	"quic_yuanjiey@quicinc.com" <quic_yuanjiey@quicinc.com>
Subject: RE: [PATCH v4] cpuidle: Init cpuidle only for present CPUs
Thread-Topic: [PATCH v4] cpuidle: Init cpuidle only for present CPUs
Thread-Index: AQHbjzc48QAeOzv5L02tuSUugwb8UbNnbkUAgAAAI3A=
Date: Fri, 7 Mar 2025 10:02:14 +0000
Message-ID:
 <AS8PR04MB86425B7CEE7443F822A2DBCA87D52@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20250307080303.2660506-1-ping.bai@nxp.com>
 <Z8rBYuDiIyo8y6HT@bogus>
In-Reply-To: <Z8rBYuDiIyo8y6HT@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|VI2PR04MB10167:EE_
x-ms-office365-filtering-correlation-id: fba5d259-c3fc-47db-6146-08dd5d5f22a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9wfYWpjh/p0Kqk2GXNSj0o7d7tSy0OjXvXvDDd/6kpgM43Vu/Gdm/eKi3W+7?=
 =?us-ascii?Q?5ZLg8nYnNAJk31sSqZMM8bKuPFqYsIqqgFsnCFJOqBtP+SHxJqE2m51rZiiG?=
 =?us-ascii?Q?EWyYWAhMJ+1cM6c+Rl69NEoPbOhaR4WnqAWP94gmIXFyob5uZvQ23gC9CIas?=
 =?us-ascii?Q?0VuPdHFLNNrL6/X4cZzuo+4/H3ar3pfCR+tTQdzxtdNE+JkU2OhgkCFc21a9?=
 =?us-ascii?Q?+PhrBG14+fae08ijF0V1jNthDRxyWPn3cz3EmlnGjNHjXKwrXrcQ5BEhjJeP?=
 =?us-ascii?Q?M4+khQ14YpEYiCqUA1w0HcEMzHjzpbFSQ/V2eG4b9QJ+1PhHnnbZ7UreeWhR?=
 =?us-ascii?Q?9hsoaERG970Eaas8O+qCxDbv7ukhsOVsJQWJaPihaK/J5I+92nMvxQSdL1RR?=
 =?us-ascii?Q?ywSlQ4wsVBDHASTuC1UOKLLLV+s2RbGZPzx9zuk2uhxYfweRyQNFNqAxxn+V?=
 =?us-ascii?Q?TS69elHaHOz+HRkqp/OwnIFYICgdrD0lT/ZQQQn7DQmaLDyEZmIGx1vJYbmf?=
 =?us-ascii?Q?4c5xNAvDhgnWiLRLg3igZHwTC/YLM3raEN1XXTDjv4SSh7LYBj1Tcdi9DiIO?=
 =?us-ascii?Q?q4BzTcLZNwGvjb5iy/0zgiVblFAmnIa9LwVff4BmUboLqsLzCNgVWlf3cddW?=
 =?us-ascii?Q?e/+D0IO3fd524BbAVa0mVWqL9ssteeTiWJw2C4iJJzbcEQxj6SRcV169TyXe?=
 =?us-ascii?Q?7H3z4GbcqeIQvpFcgrTtwavF6E6gf7J89+u01CyRq91tjdHjLWgLZZmC+axe?=
 =?us-ascii?Q?rkoZPdAfzcYnSmKWL61Z5uy2S/sNsDpLHVIig+ZTLonfAvQyM6qeTUMoFhN7?=
 =?us-ascii?Q?3GG/SAW0ybQpqKYwCPxS9d7ZKZAQMy1ArHuP3bWLZvsusWa4PAPL0WxODHjm?=
 =?us-ascii?Q?kgviXeE+BBn5Pn0YhLcMiq082AOsy5/bE3IwD6UDRGNi0bpf64wg9i9XQ2kZ?=
 =?us-ascii?Q?5JVGZlVaL4rsk2JjyC4+MCcU+6bWQVwjpife+ZLHeItG+E4+3WH+7fbonjhL?=
 =?us-ascii?Q?srkU37qlvNGxiINvg9RWMrIE3Pai9fFhgMYidsMJojaAfEDjKC5QpAAk4x6z?=
 =?us-ascii?Q?KX065kNpWZnJCX/ywe+ZCmGq//d+bYvL4FUqHXRdoQgyPzEZ92nUOgpz+WhQ?=
 =?us-ascii?Q?y7z2SqkauOnOmnGEL/wPSHjYvnRPvuOmD4/cBtBbLzfxe3ne/L2ZAOm4GkL5?=
 =?us-ascii?Q?kLfVfPZjrL0OkOIv3SvFKKZl3SDt6gl8sgpi4h5uvdnt0kufiq4/OhEOxzZo?=
 =?us-ascii?Q?Gtvk8QU3n2CJZ0zThgiOhKvZ+7VtE7d7xSi5uN40mLZgB4OvpkDGcThs4tuv?=
 =?us-ascii?Q?+oMKEKBOTsD4DwcQJEhCNLUc8wO7vT3Ere5g/Nkd6d+Qu6ONQPJbA9h7RgeT?=
 =?us-ascii?Q?7HRQAHYTwox4TlcqpyWjHyj1YgGPYI4sIF7McYAyFZa9nE6zGUaAL11imdVD?=
 =?us-ascii?Q?ju7L1sm9qRd6oJbOcaQOgTQsyHZBF2Rn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h4EObjfEEsLnsNzqLX1aZZ3EIxcVhUy0SovR96JG3dgo05/MfEESg+sPJF0x?=
 =?us-ascii?Q?b6C9EBERzPJlT2rrsUrOGV7CoFB2g8lWYl7hn4mvJtrWjjqZAduiXjmNye95?=
 =?us-ascii?Q?VwwX1JkyyoPN7hqIV1DgoLxOY40pNsZ9Wbq7ya6jdE0t1lVqRY1XJhfVjJ3g?=
 =?us-ascii?Q?BEgiJugKAaE+IGeSNkYVPfRpXZZk7n+d2o9gqjFeKFW8Ukhhaj87vlaIYFk+?=
 =?us-ascii?Q?7eCD0gUg8IDSl2tCBSLxXXzLbAGG83JB57GTjvvtVnD3mjBjYXpsmnGWjqbu?=
 =?us-ascii?Q?YTWD55n22trQSdGLYHmXKbwc7uMMfL5HSnfoWLeU6Y7LWXpxdEiC1XpFFvba?=
 =?us-ascii?Q?QZwHB5QZHATMGztrjbUMuT04ZRP6v8s0vruGwH1rd55Ccn0rVIgWfgYgpCOG?=
 =?us-ascii?Q?u2Zd9SsaVzIdC3KpiytlvgGY2dJWxshd607ah4DVWyUaeeUoX+s2mlkZP753?=
 =?us-ascii?Q?edDyrxw7/4a/VGuApyl2jwDHduVooRsskzQtVs8JpHuVQ0WY4nGEozTX1tCX?=
 =?us-ascii?Q?/vHtCpe0CadMw+Bm0KmVhLMniY+7+rNRHb0BR7ebC1cFnlW6le3512jNeaWK?=
 =?us-ascii?Q?9pf5bOUW5Yl0+ZjSnOJUejKUBX3K67qeFaW90RZl6g8PztjU8gdgO4VHEDXs?=
 =?us-ascii?Q?hVhuqUTtbuzG67i0vkEqdJyzOlXkxn1tzZBn9mlKpIEjEzhC11vGrg4p6AAj?=
 =?us-ascii?Q?2P2nR7XLD5eiWuAfYnpwV1volDXVUfDY8oUx05WPZrVB6AzfyGUmb2h2V0Mp?=
 =?us-ascii?Q?llITV0fhxzVrU53M/H1N7eXPv5sFQvL+igbvehJJk133Zw3VPAWX8xUG+/JU?=
 =?us-ascii?Q?36dIuoxeLmcNNRtj4cgzT8VAuvMrKXXNBtUEcwDbs+BE4CqPcYpcUiKHqfY6?=
 =?us-ascii?Q?8EVvvOgt5np1D0d8rVwJyXWApmUfnHCPcREfpjOz5phBPOQHEVMFC6RZWqNn?=
 =?us-ascii?Q?zDNBl2Ft9XB8U8dEIdh7syCL5wYNsDskHIl6hmL9aIgr7xRDxx0KhDA4GvD6?=
 =?us-ascii?Q?tQQZzQvbrDhndnHGxLxDE8goarKS6hyFHAZGTdhB7ZsQI0DIShy5/rn0ORag?=
 =?us-ascii?Q?fY3IbQ6+b2p2uvA8UmKDSM+JGK3MKtjY8YpmUu4SRY5dRDKvT04TGR3VR7LN?=
 =?us-ascii?Q?0q708+EauQjo8RhsqhRPCyjqq16XMfIZqKmV9tWPq9sAayHAqPLm1Kap9cOZ?=
 =?us-ascii?Q?+gD5Zw2bVUEea6AJZGo6FLLK151Yvlf7uYIJSY8j4nApOTrumLv1NoK+73fb?=
 =?us-ascii?Q?kcPhBKtWZ85kEbuxQzWR2szV1MamuLSdyd7Zg2du8pFzDEWtiJMyCnRX14vf?=
 =?us-ascii?Q?qf41qbIzWPWzw8zeSfLCE3KLBVNkGe62tR48pc+GAWFBRA5ocx/C1Melkevu?=
 =?us-ascii?Q?RIx8FFGSxW9FrRzQzKR+NEfIyDi+ycvxhd9Hi9RU8B/LCiYc50Ximqhom87P?=
 =?us-ascii?Q?IB76EI723FI6BmTb9K9DGU6U2LcSSAmGNy2/T7LE7MxAUkwME7WW2dtKkwUQ?=
 =?us-ascii?Q?rOHUHKZipY2hvhuymgWmUPENlonJ9tba7O9YCQMVT6QrppGrWnulXnpOi5iC?=
 =?us-ascii?Q?QWYhMIC5/vvmsSISHFE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba5d259-c3fc-47db-6146-08dd5d5f22a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 10:02:14.1072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zo+KCOXlR6zekveSUN4b/LOHTWVyPWVHhk6IPWn/sWeGBhj8QzbNgoMDW35DYowJEQKuJOD6GT1sa+EMcYYjAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10167

Hi Sudeep,

> Subject: Re: [PATCH v4] cpuidle: Init cpuidle only for present CPUs
>=20
> On Fri, Mar 07, 2025 at 04:03:03PM +0800, Jacky Bai wrote:
> > for_each_possible_cpu() is currently used to initialize cpuidle in
> > below cpuidle drivers:
> >   drivers/cpuidle/cpuidle-arm.c
> >   drivers/cpuidle/cpuidle-big_little.c
> >   drivers/cpuidle/cpuidle-psci.c
> >   drivers/cpuidle/cpuidle-riscv-sbi.c
> >
> > However, in cpu_dev_register_generic(), for_each_present_cpu() is used
> > to register CPU devices which means the CPU devices are only
> > registered for present CPUs and not all possible CPUs.
> >
> > With nosmp or maxcpus=3D0, only the boot CPU is present, lead to the
> > failure:
> >
> >   |  Failed to register cpuidle device for cpu1
> >
> > Then rollback to cancel all CPUs' cpuidle registration.
> >
> > Change for_each_possible_cpu() to for_each_present_cpu() in the above
> > cpuidle drivers to ensure it only registers cpuidle devices for CPUs
> > that are actually present.
> >
> > Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in
> > GENERIC_CPU_DEVICES")
> > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Tested-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > ---
> >  - v4 changes:
> >   - add changes for other cpuidle driver that has the similar issue
> >     as cpuidle-pcsi driver.
> >
> >  - v3 changes:
> >   - improve the changelog as suggested by Sudeep
> > ---
> >  drivers/cpuidle/cpuidle-arm.c        | 8 ++++----
> >  drivers/cpuidle/cpuidle-big_little.c | 2 +-
> >  drivers/cpuidle/cpuidle-psci.c       | 4 ++--
> >  drivers/cpuidle/cpuidle-riscv-sbi.c  | 4 ++--
>=20
>=20
> Why have you spared drivers/cpuidle/cpuidle-qcom-spm.c ? IIUC the issue
> exists there as well.
>=20

For qcom-spm driver, it has below code logic to handle no cpu device case, =
and
no rollback to cancel the whole cpuidle registration. So I just leave it as=
 it is.
Do we need to update it?

for_each_possible_cpu(cpu) {
        ret =3D spm_cpuidle_register(&pdev->dev, cpu);
        if (ret && ret !=3D -ENODEV) {
                dev_err(&pdev->dev,
                        "Cannot register for CPU%d: %d\n", cpu, ret);
        }
}

BR
Jacky Bai
> --
> Regards,
> Sudeep

