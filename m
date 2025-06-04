Return-Path: <linux-pm+bounces-28086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1E7ACD668
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 05:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C57E7A237F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 03:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A02315442A;
	Wed,  4 Jun 2025 03:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OfMoNyMi"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC91DA21;
	Wed,  4 Jun 2025 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749007198; cv=fail; b=EbuhkeGQh2mj5ejjlPgaCWJGi7VqGYNUxogt+f+jgKBEUZ/u4aqN5q1wb1s+BF1WkMI1Kk15K8w5zEvVavRTrN6iCp/0hf15VC4xcSnLYHV4AoY7fyPtJtpIvxpwtTT7iShYPCM9D4OclBBOvbzFI+Tku2sckKP/RXxNkk0U650=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749007198; c=relaxed/simple;
	bh=WbfMLoEa+JH9EeVxg6O7Zcl1ptVd0+sEy/tlCLd1iCU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vc1t9x6al6M5mSVgbo9cChJqbHmKOizkJKnmpNvF8Cx/KiTOi+a1ekQCewgs18khhmT5oBfNgpmJcLk+6rXjImzAt4RbI5lgSFU47TDG+z5fgOvjtN+NaDWqibZEgaWbL5ASOyRSngzWzwOY9TtWrR+4Ki0WF0tmC4xmGFeWBxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OfMoNyMi; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efZ83OucKsW17V4DsougpAkAxm1wud2ZNfuCR7RUTHPq6vWehBqw5hsYybYK96SZM0yLdIQBZMPSThkP9ABLUep5dr2NLWpzbAb0Q/KGbbdQ2WIsM+AZ+kLO8qgpg4eDX1RvsZZf130YjH2xcgrUxdaK5dDrIb8NnQ6UadM8cUt8X6oIqDYyLsTGD+L6njYSvVF4P7LOJUIL37CdflhHWP+86qaGOVJnzl8Y3fW3dGTVXI/Qx2LVB+QCsbOuisQCUxR+ZOtigKllHQWxdSt+3ts5c+2qnHLlFAZv8MQQurU6RwqFDyuTRIrjanAFde02MONF6bvD/7YonrhIKBlMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql9iWjnVGDohSwlk9rcqjImOKxbZtilwXuShfpV3aQg=;
 b=sQ6QnAi9VHxiF4mYED5v9ItxG3Sw1cSSBxpOuiZqd7w8yNjETZaFAjNtG18C9OiGc4oB1vd5t+otQ4827YGQ8o6O7ETY2HfKIAvhkoAe4lE/BWYVIhcF0eRaXKyXPLlp0+hVqdf0U702GzXcZpNq9JHoFU6YLus4ndfz5tRr751XEktv5xr2lrlsgmLmKi1CJfgXwPsHBtDPMrmNKQqAlcegy0IjwP7r0scIFXrmgxMGbQ+n/8epc8xGTDDbQb0bSDOPicKFDFDR999k+mwhGdQrqQzo1NxNUcuhe2rOXMF/hkPO3ZyorCKpd5r0KEFSP12j5CQIuxKrNlOCv1nPwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql9iWjnVGDohSwlk9rcqjImOKxbZtilwXuShfpV3aQg=;
 b=OfMoNyMiUWIguLFvlecwLOpADIrw8ZcUnK8MyzRHxE2PhfOk95YX0vJLl+7uKd5pVDhq3FxFB0Ii1lSmYyCsOLwWgaLzps83y3eHovLpTHdfwbTKmzeMq1FpVDueRL5AJQn0z3IePJNLzVTmPxGJD64A4Fj5SUhEWXPeqsy2n0iXrsYvfqFUv89sqlMDxC0SslWn5EJdPCovx7IuA6/QDV4k4xkNq2NmTyISFRsVTPDUZSPCCDusKa4WFzNBb0vP9V6JVwi5Qd/VdaXakq4z426ZpjAmKSxwuopkCRj5GecvgvaxO7RyFjZDqf70yFtZHMAf3aFZe2vd4IfFAgml9g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10767.eurprd04.prod.outlook.com (2603:10a6:10:580::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 03:19:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 03:19:52 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Hiago De Franco <hiagofranco@gmail.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>, Hiago De Franco
	<hiago.franco@toradex.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>, "Iuliana Prodan (OSS)"
	<iuliana.prodan@oss.nxp.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH v4 3/3] remoteproc: imx_rproc: detect and attach to
 pre-booted remote cores
Thread-Topic: [PATCH v4 3/3] remoteproc: imx_rproc: detect and attach to
 pre-booted remote cores
Thread-Index: AQHb08EqHErDcF6d5U2TRnVBdQP9NrPyV0Zg
Date: Wed, 4 Jun 2025 03:19:52 +0000
Message-ID:
 <PAXPR04MB84594F9ABDF0728D9A71FAFE886CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250602131906.25751-1-hiagofranco@gmail.com>
 <20250602131906.25751-4-hiagofranco@gmail.com>
In-Reply-To: <20250602131906.25751-4-hiagofranco@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU4PR04MB10767:EE_
x-ms-office365-filtering-correlation-id: e485fa79-8c43-40f2-0327-08dda316abee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AcJlTR6l8VCcTS/n1LD9MwF/hWJyAUl2Fkfjj/2a+C4/Gs2aVUbS6XMktqlq?=
 =?us-ascii?Q?a8WPGeXcozT8vaYKhjmvM3HPAXPoIi2O/sMGQVfojgzyUkvGfI4vnMNM0B+e?=
 =?us-ascii?Q?ggEu7A8avAlRIyFDjNWilnvT6oeCitORxR6vJ1HR+ZGUqUGSZqNjvd9Z7Hsr?=
 =?us-ascii?Q?4rbe5bNUJiad0L+o3vOgXwT9NzDbmBqZkuj94uxiCyUUxiJfLn5wDprMKPcZ?=
 =?us-ascii?Q?Ug4FsRYeTHPVMKzbOo1hZfKMY9nffBLyfRVsL6V0GcQdTrDIThPK9cisaM1J?=
 =?us-ascii?Q?qH0oKvibT72JcEhJjgGnldLKkDwhTwXEODoQR9liJ6CT/mAl8Zg+EGcudH5v?=
 =?us-ascii?Q?iUQmGbDokWSMUIuvS1t9Yaab0XYrD1BsoOayl6ZHDWH3hD/Bw1oQP+4V7txG?=
 =?us-ascii?Q?Lr0qme0J3GspPmJETajGfMZMjs/OciD5Tc6NQ7sXlND6/5o6ZWZmRsZ2y9/1?=
 =?us-ascii?Q?ZqaYDRmdv66VKVNaL41IE3Pf00iTfRLGWKdUwvHzEcyQzpBe61yG+Y55NErb?=
 =?us-ascii?Q?eb7ubUTzPKAj0SLYlvJca3S04SUSy1cMTLynsNRBVkrfHG2luRgRSEYM/do+?=
 =?us-ascii?Q?q6F/u0TlDjhu03THy/bf67bo4p9Sz5MmtV9HB777x6j5mWSH+1YG8RLTR1wO?=
 =?us-ascii?Q?eDthY00ou1p6uK11F2e4cMCol/9AvMVnCMliywc34Wnm+YMy5KSnq0RXF0Tf?=
 =?us-ascii?Q?vzOeMUeWaL0x3ccLhk7ENBj3O+nXKc+qX7gsRi3M6nrHeFMgWd4gzkJpkGvn?=
 =?us-ascii?Q?0WFet8zgCrijZxyhJRt5c0m8CjkNmgZ5Y6aLgPL4ZNv00alDsdfNI7eQmj6t?=
 =?us-ascii?Q?LYBc3ekf4zTl/IDhA1XMFHmNDLicamfIcuWzzlIXh1c8P7zikPAbCFRB8rDs?=
 =?us-ascii?Q?J8iKNvo7DpTAUQ97qmrp3V0rrJSXEoeB3D4A/82bXLQsAjcuYJdkMdSSZrO1?=
 =?us-ascii?Q?0b9453jI+vC7lD5PacY/iVPAp1DI3SQoDBl/LpUxz0xKmcDiKhJKyv4sax2b?=
 =?us-ascii?Q?UDqBMGalSb5xkSa/gfcZtwG9zqWJFVtBXfLdM2lLLUBD3aAunIqNEKgcbOlA?=
 =?us-ascii?Q?aizkanUBI3sp2yTavvf/hVA5vwLfmsHo73M43s+FsO9FaR2H2fy8B9mRGT/W?=
 =?us-ascii?Q?ryk4Yi0uaAiLRVWIGDfd/QdRQhcVJRTEtMDpwwQw/9AY95BiLEjqeSuR4MZx?=
 =?us-ascii?Q?5dnvOnW3s638XEsq1raYjo7GksM9KgPSLZkpNkkBJ/k1jCkHSt7iwgoMGGsX?=
 =?us-ascii?Q?zBOkY3awgqHtlgAn5RXRyg+W6llMcuTLjbj6B2q4TfMxR1o0wwrJmYMC7TWr?=
 =?us-ascii?Q?t1V4mMJ8OFP1OwFPBD661FLPgYTH2Y7Vy3FdP7MVcnZJKr2pgS+X3MBhFfeU?=
 =?us-ascii?Q?zPLBSuXA+SaGgp9r3Z35dRVMiNsINzcyTqOn9pD5bkoll/TMG7KY+HCpmD6c?=
 =?us-ascii?Q?ItsqmLR4ikjK7mOlF+iAHe0X5sKtUFpRn+t19kLDDacQ3iEzb4SS3vsTN7Ix?=
 =?us-ascii?Q?nAqNXc0CP0wBPcE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lser6MUE9ateQ386c5AeOjaBXUOcImb7yUOzmP8f3hwo95/4SFO+D59zURZJ?=
 =?us-ascii?Q?yvIv0A6m1IJpeST3LwCNTtdXrucVRoNczH6uU7vGBmasq+co9wLUzD7xG7wx?=
 =?us-ascii?Q?tmhDCEnEOmjYd37sm5CPpen6X/lAE0z2mviR5rpXgkZ2QPxktJEB7O7Ymo/J?=
 =?us-ascii?Q?Jl/FcGe1MO2p9PvoGp1NkZ87nnuw3NYvMGD0LgXz1/aKo0gS6w7MmVgZ72c9?=
 =?us-ascii?Q?hsHqCyxyZ1Jn4/88M8kXZc0hnFuuhRWSWpDo1j8MaRcBl8Wj1cYYJbPRBaUG?=
 =?us-ascii?Q?ljAE9vC1hj9xlbNLqTsBU6F8rOgGiqv9D6h7irwpZCFTNqQeI8guJYHIFtXi?=
 =?us-ascii?Q?9G0rKshnk3hRhqTZyz+Y4TFDiacHjlxhzJhu+VqxfePWirsy3AwTkLzTY1CU?=
 =?us-ascii?Q?JcVowVchcm84HG5BEm7QE4AGzi6JBOxg8uSw1xarIj096gJMqKGfMOlmSmdV?=
 =?us-ascii?Q?Beax4kNqN0r69HMc2Z9o0xpLZjYjt/uYj9uRLji+DikeCVWtggKOdSq7JkJl?=
 =?us-ascii?Q?Z7lUBiuYOgRwsqXY70R6jhlQfFMJ/Yy47+CqkfNAvbKsHkn336Lm9ahhGRyg?=
 =?us-ascii?Q?DhxdUB1A8dUdWtaFQIEzGIy2tcd0nPCjdDcxrqKr7qZQ3mzc/xF5GjgaHA4d?=
 =?us-ascii?Q?VrLWPjazsh0pjm1vIpqVqwKxy3tGYu5LuD5SvP8lfgUVy4ZysHcZD76Em8Tr?=
 =?us-ascii?Q?DBklZ88shrTmVgtVnGxDKikz5TA+0UyyiJPhq6B8eHfsRfz5EtN0734QDBoJ?=
 =?us-ascii?Q?nPOLekGiEZt6T+x5F03HeK41t4njjwUFZwSme7foa1iA2U7Ci//1djMxfhBI?=
 =?us-ascii?Q?tl4GB7woHnZXTBWZzi1KbdIm+pWdphuYIE6hoYTWi/ZNSa/Ec8+5qrPVOAtC?=
 =?us-ascii?Q?tvj5F+l2nQljmcqOKuEU3zHcIPATE/ApdL5yuju3Ub4/9rIUdZoFLuXI1wcl?=
 =?us-ascii?Q?MPVCjImiU40mPIZH25dcBXB/FwAZxpTWyWGJBPwsYX70854bWLW0sMdRkyCj?=
 =?us-ascii?Q?f/UQP/yUChL1OsPJYSKlL6tdrjJpnVEXVnoJlAx2x+mQlVzbg3EKnsEtRff1?=
 =?us-ascii?Q?RSvK3Nupn2vVXXHqwyMwpyYzHP7Mv4y+4ZnlrCxXQQI7ulWKw79+py+mzsXY?=
 =?us-ascii?Q?rlaF3YsNVRf9s6+L2efQE9KQFbzggMNNHsn8UkFQ3bGt+lPte/g986+Tynx3?=
 =?us-ascii?Q?pltZNrsDDW+mdN9Sa7tITZuJVFxa2k+vIET6yHh/f9hv43HSxIW/sVPzA9o/?=
 =?us-ascii?Q?foev32AYn0aeXqZ2ikcs0Hs1+R/RH6fPPUOqK9aoYULt6D6dooiKr1Qh1/RD?=
 =?us-ascii?Q?jCekm/boY7vEMYA5Dujq7kOEUXAWQJdvhGuGoOj5kWK8lG5uDBthQ6dB+Pzr?=
 =?us-ascii?Q?MbeRjfp88RGkWlLfNW/qejndLHkVZyJCG73FYJyeLo0z+QhCrsWuh8bYBihP?=
 =?us-ascii?Q?9oIHoU7P+qwqq85hfTIKbmdmWoUyfCp1QFUiq7DqRWXG/mSElhL189N1MtME?=
 =?us-ascii?Q?bdwEn3wt1H8gR9WGVA+Xbwa7gPELvIZfKvE4up7B97cwtklshhGNC5lsrCqm?=
 =?us-ascii?Q?cZbUVHI2bFO8bFL1nQM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e485fa79-8c43-40f2-0327-08dda316abee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 03:19:52.5547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Cd0ySiUCBWQN9prb2TyPuELex78BJywSYOljXfTmAun73Rr1Qifv7y+txpaiBW471scoz48MYDInddB8gw/LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10767

> Subject: [PATCH v4 3/3] remoteproc: imx_rproc: detect and attach to
> pre-booted remote cores
>=20
> From: Hiago De Franco <hiago.franco@toradex.com>
>=20
> When the remote core is started before Linux boots (e.g., by the
> bootloader), the driver currently is not able to attach because it only
> checks for cores running in different partitions. If the core was kicked
> by the bootloader, it is in the same partition as Linux and it is already
> up and running.
>=20
> This adds power mode verification through dev_pm_genpd_is_on(),
> enabling the driver to detect when the remote core is already running
> and properly attach to it if all the power domain devices are on.
>=20
> To accomplish this, we need to avoid passing any attach_data or flags
> to dev_pm_domain_attach_list(), letting the platform device become a
> consumer of the power domain provider. With that the current power
> state of the genpds will not change, allowing the detection of the
> remote core power state.
>=20
> We enable and sync the device runtime PM during probe to make sure
> the power domains are correctly managed when the core is controlled
> by the kernel.
>=20
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> ---
> v4: Changed to use the new dev_pm_genpd_is_on() function instead,
> as suggested by Ulf. This will now get the power status of the two
> remote cores power domains to decided if imx_rpoc needs to attach or
> not. In order to do that, pm_runtime_enable() and
> pm_runtime_get_sync() were introduced and pd_data was removed.
> v3: Unchanged.
> v2: Dropped unecessary include. Removed the imx_rproc_is_on
> function, as suggested.
> v1:
> ---
>  drivers/remoteproc/imx_rproc.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/remoteproc/imx_rproc.c
> b/drivers/remoteproc/imx_rproc.c index
> 627e57a88db2..6f9680142704 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reboot.h>
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
> @@ -890,10 +891,8 @@ static int imx_rproc_partition_notify(struct
> notifier_block *nb,  static int imx_rproc_attach_pd(struct imx_rproc
> *priv)  {
>  	struct device *dev =3D priv->dev;
> -	int ret;
> -	struct dev_pm_domain_attach_data pd_data =3D {
> -		.pd_flags =3D PD_FLAG_DEV_LINK_ON,
> -	};
> +	int ret, i;
> +	bool detached =3D true;
>=20
>  	/*
>  	 * If there is only one power-domain entry, the platform driver
> framework @@ -902,7 +901,22 @@ static int
> imx_rproc_attach_pd(struct imx_rproc *priv)
>  	if (dev->pm_domain)
>  		return 0;
>=20
> -	ret =3D dev_pm_domain_attach_list(dev, &pd_data, &priv-
> >pd_list);
> +	ret =3D dev_pm_domain_attach_list(dev, NULL, &priv->pd_list);
> +	/*
> +	 * If all the power domain devices are already turned on, the
> remote
> +	 * core is already up when the kernel booted (e.g. kicked by
> the
> +	 * bootloader). In this case attach to it.
> +	 */
> +	for (i =3D 0; i < ret; i++) {
> +		if (!dev_pm_genpd_is_on(priv->pd_list->pd_devs[i])) {
> +			detached =3D false;
> +			break;
> +		}
> +	}
> +
> +	if (detached)
> +		priv->rproc->state =3D RPROC_DETACHED;
> +
>  	return ret < 0 ? ret : 0;
>  }
>=20
> @@ -1146,6 +1160,11 @@ static int imx_rproc_probe(struct
> platform_device *pdev)
>  		}
>  	}
>=20
> +	if (dcfg->method =3D=3D IMX_RPROC_SCU_API) {
> +		pm_runtime_enable(dev);
> +		pm_runtime_get_sync(dev);

Need put and disable in imx_rproc_remove.

BTW: Has this patchset tested with M4 in a separate partition,
saying M4 image packed in flash.bin?

Regards,
Peng
> +	}
> +
>  	ret =3D rproc_add(rproc);
>  	if (ret) {
>  		dev_err(dev, "rproc_add failed\n");
> --
> 2.39.5
>=20


