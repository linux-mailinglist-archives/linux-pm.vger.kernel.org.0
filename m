Return-Path: <linux-pm+bounces-23588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E6EA55DB8
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227D818960D8
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 02:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DC11465B4;
	Fri,  7 Mar 2025 02:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mLPyGMzX"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581342E406;
	Fri,  7 Mar 2025 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314799; cv=fail; b=fJwU3qh3e8phd8lyYQmQosadBsmS9Szi1f3lp42j3jXh+hsqIma1NArSF4ZGUq/9qA4qojOMDVOZfjb0MNIS/T2IoLBtqGxtnDdtt4xvVw9hVDi/57GCfH9OxX40yuhWCrx0b4wVfNdvtbbQquVfmNXDjlF8oG/NdRrX5GDq6Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314799; c=relaxed/simple;
	bh=UEeVwTRtDFa7ytWsHRqMwtHKxcsN3uvRgj2ZhvLm7PQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EFBaNf9NwWAmqxgN8XQzvXRKlX+4BWNbPY3dA3nTDeSar9H7+snHFDtrYcy0HyoYernUqTIFl1Dh742wzULvjp9lJdQ92/kjdsB82S77GOiQ0alPaeip3iU+5k8wVipGVQzBrwfE5T4UOW1l4NzddV41+AmDkM4SQp8f0R5Ech8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mLPyGMzX; arc=fail smtp.client-ip=40.107.105.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvBJ0TpYGcfLgaPilz0uGmK5bQlrhgbDTNIyZgJAIdsaXCcgDHKSzd3Dvhw3zhSW54NgfEiSfFI3tw1hQoxu49Vp8E5EnZhqlibL3fsvv85UVO2IvxoovQJ7VDOyNxJVz6CPJqam/ja0ljPuJP646gE1CF9505rERefvexS71J6QIaVh7Ue3o7d1qV7ppYX1nFFrkkcsVgdW7lX5XrrBUDJKuhQlASEU1iO4psNRbL9iPMibc1aJLabsfWi7o3dEWN9UXXIBDmb47B786jUmt6XiJQV8StHZuclN+fc260A7TazUUZXCrmf5yUhUJAGr2Una9AgDss1VpQFM9T8qsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xqb11img7g92lGY1mx1LVHStmK2NldRTq+vMCuO53Ig=;
 b=TBuNTYUyxzbqiFhfNpv9w7eHDmROI/I+r0+jZw8HSlHUMYj/JDg+5H0EKK02XoRcdfMxPwbOS3WgSM0pp78Xd+qfjFUkQPrbPiCY8hqueAZJTWYDTcyXRA4KW5LzeUQJlegbHPfhIhVi/2ms0pEt5NnTym91JSjZxebzPgNviv1mgm4yn4GNcLyvTp5BaW9L6Dmg81sipYmAoOmFOiLn2paQUPzFSkzlZglPhxsHYmbQxvP3TSlaLOk8NdrZxnwUJtauB5Mcx7gab9Dfjr4SiyzbhqSZS3dRwvjg71OwMZ3NUZOwf+tRPDKPQcvQQqnIuwfyTigWoICc/wqglkZLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xqb11img7g92lGY1mx1LVHStmK2NldRTq+vMCuO53Ig=;
 b=mLPyGMzXzH4jbUR1Xj6YSJaMuXiLN4dG6+cAZWRkAiPjAKD7U1sjxaJzdpAUNNuodjT9YXrfOO3s4TsX9GYS1H0KuZP4KQllr6aNd7/TeWBHCJ9BSwExAfFrI3cCJbJ4fWtbd0zuryY5ovbnJ10cxtwr7P51bRD5bQ132Rbf6+kqMsu4qyn3tyh3d8VTRFDJlDjFHw2x9mjkXkXc7TAG09hZxvzS+IgzKUB0tK3RPEU7TRUf+fhhZBYogoto36sCk8fdowXtMbLjOxeKlPqInUzwrZd+aFluVF+Bc38MCitfBjSGAQrvTCMiN+QySpP0X6rQktFuPZSmuvkpNjX2NA==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by DU2PR04MB9065.eurprd04.prod.outlook.com (2603:10a6:10:2f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 02:33:13 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%7]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 02:33:13 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "d-gole@ti.com" <d-gole@ti.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"khilman@baylibre.com" <khilman@baylibre.com>, "quic_tingweiz@quicinc.com"
	<quic_tingweiz@quicinc.com>, "quic_yuanjiey@quicinc.com"
	<quic_yuanjiey@quicinc.com>
Subject: RE: [PATCH v3] cpuidle: psci: Init cpuidle only for present CPUs
Thread-Topic: [PATCH v3] cpuidle: psci: Init cpuidle only for present CPUs
Thread-Index: AQHbjl9kwy62452AHkWtGDUjwc/9LLNl7ywAgAAekoCAAOb48A==
Date: Fri, 7 Mar 2025 02:33:13 +0000
Message-ID:
 <AS8PR04MB864268FE54C7EE0E51D2875087D52@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20250306061805.2318154-1-ping.bai@nxp.com>
 <CAPDyKForY4VNZtqietDPt2FQM3p4OsaoE_oJb0PPLUAh98WsHQ@mail.gmail.com>
 <Z8mYP7AGBPeDTvXn@bogus>
In-Reply-To: <Z8mYP7AGBPeDTvXn@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|DU2PR04MB9065:EE_
x-ms-office365-filtering-correlation-id: 070926b8-56ac-4a41-f418-08dd5d2068d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WKfO16BBtMVLQwI8SwlIQKAl21XLvnTXAc7IRo+ZHqywSIGdvhY4qSLxj+Q1?=
 =?us-ascii?Q?1Uf3RgMoCMGjc3q1YS1fLAYRlwKaTwJPiT8Ku89n47M4Y/yTcDDuE5/Tazow?=
 =?us-ascii?Q?yAV3/+iJMzY/Ko3aXix87egMWrfBXGCLG2+zLbOTPD4BzXFWifaNgysR1R39?=
 =?us-ascii?Q?WPBGbuyaTVP6AULm1ZqgwTGYucym54lY7LMLQyTUbZmzr9Zczj/CxHPK60GC?=
 =?us-ascii?Q?ho1oP+vMGqJPz0HYeXjL5Z2OzhcqD+OdKrS7JDQbiQb91kdLW5krrHr4ZA6u?=
 =?us-ascii?Q?ALZtevu8KNUMnBBUxyvbfJV3Rj9D2RYDicyyA1DiEcUQ8gOftr4fjifXQ7ZH?=
 =?us-ascii?Q?6PjgDcW4AErR+XD2GgeX1teYwTZSsHZGdcXxdm16WYbjq7OIunHqfLgPlMJn?=
 =?us-ascii?Q?JKBfP7sThJ3d327nzqb/cRFLkr9W0amd7Z3/7sIkELUYL98AobvMymYdDKhP?=
 =?us-ascii?Q?X+b3XZ70H5mAgSQHcYamd95l3Mli/HqpKCAZyCjVr3sohg7sZOJH4RcltJU+?=
 =?us-ascii?Q?2rthS3uAPsgxEWahNIyqtxSfXNcp90j6IRF4c0q/9u9CJk+C8JwTAVpqu7oE?=
 =?us-ascii?Q?7tJBilYn9/ruoscLAsD+eeOKjcSXkGrMIcMl/J26R2L1dW/DS4YnjJKV4CgL?=
 =?us-ascii?Q?R8W2mO2fsIbinKprgt3BanmeVUSaU15onkr2CBWLISyiAIV2v25WYBrIgktQ?=
 =?us-ascii?Q?QVTdsStjkAc5tV8WqdCxQpQ3SQF58FDUTzcuqPcLhCOKcQS3JKOnr2OV21K6?=
 =?us-ascii?Q?LbCZYwzzhVoLCCrFXlzgqWWQW7QchXCzJVJYCpf3rqT5XfrXTDpjCIAGwa75?=
 =?us-ascii?Q?PHOX0fi2+GgOpBhU7auijMi4X5ymM5EaC7nUr+YnUpBM5QBuLfHbYtacoQfK?=
 =?us-ascii?Q?IyAGP5D9TQ2J3nqcBUMaUktPWQX16DxxXHLGbSa+FKfGRmvDBA3v0ObDYNQY?=
 =?us-ascii?Q?+YkW3FII1mJea8WSnTpe/gfZqFsBq6LoRXJh46ba48CfrgTE34BG+kiPdqJ5?=
 =?us-ascii?Q?ILc8rskUsI/aPqh3Vja5i8kSmDBadptyDd51zBwhmFNAtfx3CMwvakcYD/MY?=
 =?us-ascii?Q?suRauhtzpV+Gqp1J44viKqPrKmtrSgQw4FFm4OBE7L5Jj4Y4OXASqSdIhK89?=
 =?us-ascii?Q?LO1T6Tsar6VjnXgcHEeCtn+HqZdyoVPbniSQulrPKyAU+BHtvmQ1WOsDX3mp?=
 =?us-ascii?Q?gQ8wjgaFLInx6wPplBvd44XsRV08zfgpvhGkeu3BruFZZRSMDexEJdw7Y9b2?=
 =?us-ascii?Q?KLcpcOxqspkX3fxw5pOzHFhgf3RkmdvmTifyM5VmPI52e9Nm6EKfzmxq+e2z?=
 =?us-ascii?Q?JgPGU6/X/TqAC2KBgpavQXAt0PT5rHa1WPASX71DYe1Q3d4u5fWnvutMCOq0?=
 =?us-ascii?Q?WyXPh/xIWL0sXS2zGceZYppJvbqvA8FRTF3Wq02oaeEf9hoy+brSh/4Adv59?=
 =?us-ascii?Q?vzID3JXNc18LMqQzV4UtwXM901Ok0HLN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OSPtL7knWKxAerIKhLtsVbAIkdr+ZmHqIMwato2/TpqpAhIZuLs/csyQJ41G?=
 =?us-ascii?Q?eVUZP/WBQSLfU0GK26Av+qDUKh3Ae4n1hJjdpzkA9SnrwdZc2bELi29nMZYw?=
 =?us-ascii?Q?FK0Gla/BM5Q4ShHp1B5zXZGijISaOSJqMx3MDOOFhSGdHNRZzTk48WdTo826?=
 =?us-ascii?Q?h4BHXYTkpmbPXwWNlXQmvp7V08C78+35IsqaqmMc2OWXZ1jV369mSHtY+88E?=
 =?us-ascii?Q?Qdvetiavr33/SAqDTUDKt1n8YYcsv760GWVLheR/pdmxIP34E2KICos9xH0A?=
 =?us-ascii?Q?OwQbDH/5uWSW9q/1R8eUZMw1sMLn8VjU0fYcnO0efy50htZYLSSHK6DnZWtF?=
 =?us-ascii?Q?Zo+4BqJBpYHss59OnMruZU0Q80dCGWIEpU4ulGGeAYDKJofdYG01jp/fxzcV?=
 =?us-ascii?Q?WD+Nlz9luMpAMys0qSwDm6mBTApw8HOVvLcmvthM1efKK8UZuWd6COs8tob4?=
 =?us-ascii?Q?tpfuw9RmUZrp05qETFk8KZ/KZWL56wyk7PsniZol1eDzU3pS7qPkvwK5X36N?=
 =?us-ascii?Q?ldPzoeY/0yNfgTxcWSSjpWsuZuYLxk30Uhc1/ptLB+dwRbM9KTI1k06P9Oc5?=
 =?us-ascii?Q?QjP+LC5J1s7vgfnhqgVlZXgz/QWPgaePyazhHCI4DZPBiPrKuAD1cuWJQvWp?=
 =?us-ascii?Q?FVywfH3LgfrrIc69b6kW01SSq4w5bNdhApFpQs5bISdxB/RFWfrL2kx6eLCO?=
 =?us-ascii?Q?5Meject+G+Gvzncsh0pQjHwHy90LlI8A1DTCng0xoWg0B6HVOKBjPZoi0pSe?=
 =?us-ascii?Q?tiPcR1qLVbwoldJvIhEvjDc0GojQBC0dkD+pnfgCTU50J6glo8ghVZfFSrDd?=
 =?us-ascii?Q?Ld9k34DFfrX+Ab5bW9VLzym38iCVKeQf5926DgF4ly2L1kr9UY3KF7YDY7nv?=
 =?us-ascii?Q?HY3V5FQmfKz03Rod6AU71Oie6oAhqET4DEgrGmvecmSbwQyEaMBxC9R9XSt1?=
 =?us-ascii?Q?c2LlBLY1EWfMpOd40yYF0PHYp4zwkwYXjtqkKGN46wuPOuJxiLJ4k9MMPWvb?=
 =?us-ascii?Q?wUTzKygouGfP39LWq3JmMA68PU1JMXLIUpZe1nbTb0jhXMd2/XHgUBhSTLWY?=
 =?us-ascii?Q?VUxOPMjw29MDrs6oWpeOcS6nHAEGAcWrQZFg9v+zGwNGGVdA8LZPuJeUCvJU?=
 =?us-ascii?Q?zivMOxasr4L4xiPGYCYtB+JFnjS1LKcYpCQDbZKE+iqh0H4qBpyrbNZCoLZq?=
 =?us-ascii?Q?lWJZIt+wVzbbXhjS7Kto51Aku9pOx+FzybafHm4P5sWvILINGaHx/M8mkGOf?=
 =?us-ascii?Q?JAN9uJSNcpGsKLPxVAIU9ybKr6yqJYfCBT6IS10f9f1p1rgFEeAvL5K5bNud?=
 =?us-ascii?Q?NRgz4m+IUTFB3pVshR5I5UfTh+tyDd1WpgZopgixT2xGqYW7ZrZqMdyS6tNB?=
 =?us-ascii?Q?okLcj0J0c/ig76gmjEsebhgd9X9NTYgU/rXAM2s8IlXHIVvaxnaRvxfCZZ3S?=
 =?us-ascii?Q?uOHUwurZS7lVK8CgZpZYbsLtFwU6/UrlR0j9dugb+uN23f6vPQ6F2UnWSOzR?=
 =?us-ascii?Q?gWqAB4IyIoN9J41mtMBJbWtXjLJDDBu1BuGJqBQh2DaiLMVitFX+Y4WNQcZE?=
 =?us-ascii?Q?K7CUG+jQOpUInI45nuU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 070926b8-56ac-4a41-f418-08dd5d2068d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 02:33:13.5081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/wPhOUOLTJXgDdt+mLx+t7nYLqR6RSMWBCZrd5n9fBT9N1bF+NRqrGRxN7+kp/oUy+UCsoUKKnqNrW4HFk/Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9065

> Subject: Re: [PATCH v3] cpuidle: psci: Init cpuidle only for present CPUs
>=20
> On Thu, Mar 06, 2025 at 11:53:14AM +0100, Ulf Hansson wrote:
> > On Thu, 6 Mar 2025 at 07:17, Jacky Bai <ping.bai@nxp.com> wrote:
> > >
> > > for_each_possible_cpu() is currently used to initialize cpuidle in
> > > the PSCI cpuidle driver.
> > >
> > > However, in cpu_dev_register_generic(), for_each_present_cpu() is
> > > used to register CPU devices which means the CPU devices are only
> > > registered for present CPUs and not all possible CPUs.
> > >
> > > With nosmp or maxcpus=3D0, only the boot CPU is present, leading to
> > > the failure:
> > >
> > >   |  Failed to register cpuidle device for cpu1
> > >
> > > Change for_each_possible_cpu() to for_each_present_cpu() in the PSCI
> > > cpuidle driver to ensure it only registers cpuidle devices for CPUs
> > > that are actually present.
> > >
> > > Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in
> > > GENERIC_CPU_DEVICES")
> > > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Tested-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> > > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> >
> > Is this problem specific to cpuidle-psci?
> >
> > Others are using for_each_possible_cpu() when registering their cpuidle
> drivers.
> >
>=20
> Good point. I assumed as this was very old patch, only this is left witho=
ut
> conversion to using present_cpumask. Looks like there are many other driv=
ers
> that need similar change. May be PSCI is most commonly used ones these
> days and hardly anyone tests with nosmp or maxcpus=3D1 on those platforms=
.
>=20
> But yes, all the users of for_each_possible_cpu() need to move to
> for_each_present_cpu() if they are relying on CPU device being registered=
.
>=20

Yes, there are several other cpuidle drivers should have the similar issue,=
 also
some other driver like cpufreq also need to covert to use present mask.

I will do a further check and fix them all together.

BR
> --
> Regards,
> Sudeep

