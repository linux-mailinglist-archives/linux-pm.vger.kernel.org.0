Return-Path: <linux-pm+bounces-31767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0829B184AE
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 17:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D38161B94
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 15:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E58B269AFB;
	Fri,  1 Aug 2025 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ExGH9vVV"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FFB18DB1C
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061037; cv=fail; b=FDqj7mxXR1sVaEHnWI5NjRT4VGBBQiraNoN6/10HjiR2o15IIHgC8gKW8xWSjDAf/jjVm5DKO2txgAlIhknpRMR/gPhax9EYJ55tEpIyMjMSI6tvMu7ajBpV9teDI4cjlrpRph529gzoz0MjHmm6z4hWUr1umkJKfTxu/QaMhpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061037; c=relaxed/simple;
	bh=htQTmuV0K9j4K7lHwV8BYgKFqFrHarCrVZoe2XQ9noo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JTDqCvLGENGgsHMptpmZ402u6I8gMnmS3Vj/1Kw3hQ5fsNkAuDxEnejIWhTPpP9VoGwIvOCGMzXzhMSiH/IonRGjFIRnvBZ8r8JeMqDeuN32qBqtHEcruy55rkgbIf5VB8nxCI46+h+a7qAL/sVj3XSXNPXphIQfwNHQohK0v0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ExGH9vVV; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjiwJIpdUKhEvrEqw3fRdHkeQNFRTFkjE8BjD8EVUzp+yFsekXQv+7x5myoMcT4/HUnxhDIg//uBRQRdRTYUjtMvYH3H21s3bfaI9Q1gQ/k0hoCMMhTRisgjFOKr/THsRf/O6stl+IDDuyA5SjVDhDt4RydiTLM4oR9TgksDrJuE1oL7mamIo0iTGKW4wSWbS++EBlMPuIe6wb6wgbfVXo7bnLEwUUR8oJ8OijBBKUU4nP0Jv/NHZ6yK4G9BLYC9O5ioMmdAnl/gH6yTg5pnEiJl6muDs6BLPfedcHNQ9YTZkqPWxwIRCgI5J4QjA3KaH3Elra8+FNUDnTJCSHPNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kEYbN1ZYsUeM4DWL45SyVK0aAWul3lje1xqpga8QDc=;
 b=rN0dSsUi2yYHkfKiG4N9m4WKdo1bv55N1LVqjNXCUcdR8Atw12jhAYl+ga/MJMiDW+7kTP0/0a/yzR9uJwuhTqTNrbbFhd2B21YSVehFBaTb9c+nOGu7YiwC3UuEz05+vYwRVrwTWopNxEZZk6Z73BuyECRZ8vlExtQZoYYO/shLitv0EkhPOn3Nzl12yhQxEMm85J04XhDYKhlD6+CFuYQLgb6cJttETfw4iHiYEoxSiyvCwgFsy9lebxzsZU4O+3ZFXcUpCc4Vwigm1zGPdzey+dJYfnCSTAATQGeTY1xWA/euec96IO8KybUa48zXEUT7kA3dryJzCH5iWySquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kEYbN1ZYsUeM4DWL45SyVK0aAWul3lje1xqpga8QDc=;
 b=ExGH9vVV9Tq86dI/yvq+6Tz6cilRJhhxs01kK5icJqqI5IvGkvD8mcYAkepKoPb4oPaqbLpZNKcfjSoxx9VoljUB030koSBCx9vKh/KOsEVPWY5po++gE8yKQol4d91HoJzbCEYJvYDTqd8EFb/X0o3yIf+62N8+tt3F2fkzeSUjYbBKHg4G1BulhNZgJVMe/flOQXmpDlYiNCaE7Mctr8iheEqoagkLlcJMNbGw5fa8iEsOgzXZZuefMslX05lh2mZCkJgFBb6nJZtwDMDCEw33NBsfdZSaxTedRIvDEiVPDypqeeoJ5PH9Rcycbn0Om2UapsRk28rpFtiD2GDrMQ==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by GV1PR04MB10774.eurprd04.prod.outlook.com (2603:10a6:150:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 15:10:30 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 15:10:30 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "krzk@kernel.org" <krzk@kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
Subject: RE: [PATCH v2 3/4] thermal: qoriq: workaround the tmu temp jump on
 imx93
Thread-Topic: [PATCH v2 3/4] thermal: qoriq: workaround the tmu temp jump on
 imx93
Thread-Index: AQHcAruJ+AtIm1IjGk2fa0w8DXTeJ7RN1sOAgAAMGIA=
Date: Fri, 1 Aug 2025 15:10:29 +0000
Message-ID:
 <AS8PR04MB86428A54DA5B45CF3D8829628726A@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20250801081119.1999298-1-ping.bai@nxp.com>
 <20250801081119.1999298-3-ping.bai@nxp.com>
 <aIzK93Gs/+sXHBZU@lizhi-Precision-Tower-5810>
In-Reply-To: <aIzK93Gs/+sXHBZU@lizhi-Precision-Tower-5810>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|GV1PR04MB10774:EE_
x-ms-office365-filtering-correlation-id: 05c26129-b960-41ac-86a5-08ddd10d8dd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|19092799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?f65g4bPdSRCTeGXzizerPVTsUs9YwGC4ivX9xuSx5sCWuXqAhP/Dui3eAmV8?=
 =?us-ascii?Q?nUD1LPToIEk4PYDD4pOA0goEsPtKQotKG1OJZcAxX0U9we+il9t8trtRFgHm?=
 =?us-ascii?Q?PU/IzFPCO/PPZbQzkSBefYSpnGeYyz1ccrXyi40YRWJOVOYQ6ocKmcNC0CKs?=
 =?us-ascii?Q?MipZQmUoZDIbAuwCrqz33/+ucEqF8nRb0Sh7LxSrTPY1iuH+9gLGHYo5iEjh?=
 =?us-ascii?Q?tzbO8YzT4MUc0Pw3NUzh0V9FEo/PKEDYyVdbkbcMD9ruIZm2V/SqHwSxtevh?=
 =?us-ascii?Q?0UtBVf3GywunJ7dD6bo+9n8NJ0+oLOkVx3bK2DGNmASlEW4GSM8w8cCMWvr4?=
 =?us-ascii?Q?mbQ7qod+HyZstePwPn7dE719ZeV5vDGG/GDKPZ4dWlw9baNq47L6eu+GQwcy?=
 =?us-ascii?Q?kUc2YxctuYl1M0ynXzo560j+xeuVDiSa2Iv4OF+ayx/zWject7jM8MsR08kS?=
 =?us-ascii?Q?Tg4bZn3+Z9nzvRxVtXVkJ0w7r4eE8KEea7fZ8ncobA5A5to6r1QcYlDpUMFu?=
 =?us-ascii?Q?RfvYZAuagK9NLAYnvqD0HtdR6lBzGurmW8Z+lcMQJ+jIYyWKLeEOY0Rxlhih?=
 =?us-ascii?Q?9nCdj3c8VfPOS1wXGl0T0duuZq9ahe8kO8f2lmquQFcBkTebg6LcO43qvFhO?=
 =?us-ascii?Q?xIZw9MtPVYwvsLdn+0LwO8C9JKao0VgsrxO1fylY8W86hRmUW1dUzdS0tm7T?=
 =?us-ascii?Q?G10d0GsXTHeWq4QMHSvQmnyu9BR9pDlHLUF7nyt8Jx1nEZsvM6dx7JBiFecv?=
 =?us-ascii?Q?+MvWueHLwGXCcJnZT1gBg0vpzAaZcp6EwbOAMjnXZuxZncEzPHtDw/JosqhY?=
 =?us-ascii?Q?4yApsmjlO62JOBYZQlqfcj4rjHyOfL81WO+iBmZ24vSfbIz97GrXCToUwrge?=
 =?us-ascii?Q?j1IUHKBKDioIgp0ZaNuJP2NQOJVkEUOkNk/m7HVRKisykgatOK9kKQiq8Nl0?=
 =?us-ascii?Q?4Ur4qojDhwDJcffvVtJUvE4y+7CsW3Vpas3bD9aijWdgbnO9mrwGwg9lzpQA?=
 =?us-ascii?Q?SjxinGYWX72qlNAa+7Yz9CKoN46nugJ2xf/sbpl8Nk3v7rscB9UzitJsUpXf?=
 =?us-ascii?Q?ZJntqnHb46XVOlR4K19hCV73H6k7GXP9N3PBYimZZHQ+kxpLPf47IAgvu7c4?=
 =?us-ascii?Q?/tcUqDibfAsnzyI2KYK+qjhbbCWmPoKjuoYfYLQrjghjsABcV2dSXRiW5hTz?=
 =?us-ascii?Q?JrjdgQfhrlxhoRGlq0s7/ZJDzVWGGsBw/RSq+f2KPNxKz97lNW6CJFUczkhH?=
 =?us-ascii?Q?SSraDKe3UGoeM3GnYXmcj6UrGTSNNMKxLPVmHSyaTDjIfa/rg0Gdzm/DObQK?=
 =?us-ascii?Q?19K3oMi+VWbI+FSDHHBnhJtZtVgyxoVMQ3qaWJoyeVOBhbIlPoTTLuFLAOcu?=
 =?us-ascii?Q?sHqVUxPKAxqOpjzdV6fpQGTtXjdUfW9ThWr4203B8M2Zrk0+yaWVznqLvUxb?=
 =?us-ascii?Q?5iZ36gg6h9f824br0atBZG6lLsSzFoIhb2nRn5AlnGwR0voQtSccvw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?suxHBe1nKIQlEEDJRocNIMJyfLNtz1c7ZObbm+lM1tAkP1/cC+RarpvHh+PG?=
 =?us-ascii?Q?ADQAarspJjRAD6FsvsWHlYq7I1d5z5aLtuMN0hl1wJSPhA+SDJPgtYzOA8AZ?=
 =?us-ascii?Q?AJaUSwSZrxwdUwQ98Qvf0yV1aMK27hzZ3+gDJeUume8zix3qiJvbL/c1lrKK?=
 =?us-ascii?Q?O+aVRqriMTRUg91ViBr5mlV4rZ+nR+mdLjhi6l2hZZysvI7ECYpxfGiszvoi?=
 =?us-ascii?Q?b/vOUyoUD0DxLU7c7uuoeghdYIGBRS4wWpTIBiMF5GPzyhL8j/GfrTLPAT0W?=
 =?us-ascii?Q?GhcyINq2x9aXaR0Q796gpAd71Cgwmv4yxakm2cYhpU2vxEBSp+SoMWZJlBJM?=
 =?us-ascii?Q?LuOvEBjcrCfb7qZxOzmrsKtRHFOaF+3T4+2G9Yg7ck+c0MQKFi48vHsW81JT?=
 =?us-ascii?Q?YZgkl+GfW9y6REAYOAyewUqp8kK3UubPgqWHIlKL1jG00UYGS3S+tfrDavEc?=
 =?us-ascii?Q?qBADq3GLqw9FWR+/JrKuBvGOWU0ztCg11RSO7xo0XSawXz3cdvueibHdgO9u?=
 =?us-ascii?Q?37pd0Xq4ERSO9HN9c0HPFPURCWz00t9aNUYJQMG6rvy/YN5Q+pZN2E7EMZkv?=
 =?us-ascii?Q?iQdIWq5wU0TWB++IH1mlLYCkmaMNQnyym0CzeoxC2GKmIwaed/fY2Zdy0hmj?=
 =?us-ascii?Q?1IEy+wfcgrfvVpcSSVUGdwhU0kTGG5+FDlgBtkWjQUbc+00Ay+MtmZn5uf6U?=
 =?us-ascii?Q?zajqEwpQy78adbxDmjw/pcxfaN82HKXiHygWrwdN8vl5GPN1ZqE9HMmaaJTi?=
 =?us-ascii?Q?LPX5AVd5F2ZouMizxquqmA3Jr20xQ2K6xalrUNbqSADZnRy5e72WdBE0/Vcp?=
 =?us-ascii?Q?gZVPCBM6HYfysNv3ZnfQDaP0sbtJpwxmtTwvoruYNF7gpCBagZO7t2ay6fXY?=
 =?us-ascii?Q?7FMvAZPtzArZLa5Wg9JBlsimrcj7uzA/hmSbGpRn1aDfvTc8l12lvgOpIu43?=
 =?us-ascii?Q?BvSK/TltY1tl0Knhe/3sNK+UQ/h4TrxeAFrsj7j9DvihiP6T1GcO61s/KJVv?=
 =?us-ascii?Q?MCgclME4YxrCRvbeev1Y0snTALM/p0UtxgOMfia1WLUhCL1X0gN/8vZLQHMs?=
 =?us-ascii?Q?IlyARyc/zkwxjsz//vJOn84vr5EtHAQ8pmYmOJvnxoGjDfMuUKvaKgsvfpv6?=
 =?us-ascii?Q?vp98R09M8KUU3jKy/rmtZx0L7ZUB1hWUaNAwarwgGDSUrNi+pItySqfuE9eB?=
 =?us-ascii?Q?HJkbQahcqCqXkXHeXCyb+lyzBpIYzixXQcRKSxAFvRvdvcyPSyuvqcsJIIZ4?=
 =?us-ascii?Q?c5bFlZV9QjHEBVYIZL+YXJ3F+Ezr1/Ey/adDopx2VzEDpev2OjsWNO12suR6?=
 =?us-ascii?Q?bqauiu/7Ez+/aD84flIuHRox6JPx5niVuusah+NEMRoqYlQropxH4BT+PjwM?=
 =?us-ascii?Q?B+njyxMN7gHjQ48Gw/viHj6Pcro+4fQa/LiSp7fPNF+Rhpf9TW1sUaz2iAzL?=
 =?us-ascii?Q?ZoeJuAsVC49fDM+8zEhbUoZQ5Do8pw3Tz+9bPVHWfRZkNPiQ8MYf/xD4wr+m?=
 =?us-ascii?Q?StA6OSQpnzSQ5IUH0iaMh0U58dXmW+Ao+Y6h0fyObM4O5AEw1p/A9IDIB3uX?=
 =?us-ascii?Q?Jn/h6FiJBCXKeE1LQMo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c26129-b960-41ac-86a5-08ddd10d8dd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 15:10:30.0158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igzCUrh+cV4heaXBhf29B6uSk8GUTL0pV+D63fPn+x1S0RTOIuv7+PR5K3kQvrXUeyD+eMAAISDDWZ7wng6AQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10774

> Subject: Re: [PATCH v2 3/4] thermal: qoriq: workaround the tmu temp jump
> on imx93
>=20
> On Fri, Aug 01, 2025 at 04:11:18PM +0800, Jacky Bai wrote:
> > On i.MX93, the temp read from tmu may jump wrongly(ERR052243), and
> > invalid temp will be read out. To workaround such issue, we need to
> > use the raising/falling edge threshold to filter out the wrong temp.
> > When reading the temp, need to check the TIDR register to make sure no
> jump happens.
> >
> > Please refer to NXP errata ERR052243 for more details.
>=20
> Add download link here.
>=20

Thx, will add the url here.

> >
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > ---
> >  drivers/thermal/qoriq_thermal.c | 31
> +++++++++++++++++++++++++++++--
> >  1 file changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c
> > b/drivers/thermal/qoriq_thermal.c index fd4d162fc188..664cd5f7d8af
> > 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -46,6 +46,13 @@
> >  #define REGS_TIER	0x020	/* Interrupt Enable Register */
> >  #define TIER_DISABLE	0x0
> >
> > +#define REGS_TIDR	0x24
> > +#define TMRTRCTR	0x70
> > +#define TMRTRCTR_EN	BIT(31)
> > +#define TMRTRCTR_TEMP(x)	((x) & 0xFF)
>=20
> use GET_FIELD()

OK, will refine it will FILED_PREP macro.

BR
>=20
> > +#define TMFTRCTR	0x74
> > +#define TMFTRCTR_EN	BIT(31)
> > +#define TMFTRCTR_TEMP(x)	((x) & 0xFF)
> >
> >  #define REGS_TTCFGR	0x080	/* Temperature Configuration Register
> */
> >  #define REGS_TSCFGR	0x084	/* Sensor Configuration Register */
> > @@ -93,7 +100,7 @@ static int tmu_get_temp(struct thermal_zone_device
> > *tz, int *temp)  {
> >  	struct qoriq_sensor *qsensor =3D thermal_zone_device_priv(tz);
> >  	struct qoriq_tmu_data *qdata =3D qoriq_sensor_to_data(qsensor);
> > -	u32 val;
> > +	u32 val, tidr;
> >  	/*
> >  	 * REGS_TRITSR(id) has the following layout:
> >  	 *
> > @@ -118,6 +125,15 @@ static int tmu_get_temp(struct
> thermal_zone_device *tz, int *temp)
> >  	if (!(val & TMR_ME))
> >  		return -EAGAIN;
> >
> > +	/* ERR052243: If there raising or falling edge happens, try later */
> > +	if (qdata->ver =3D=3D TMU_VER93) {
> > +		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
> > +		if (tidr & GENMASK(25, 24)) {
> > +			regmap_write(qdata->regmap, REGS_TIDR, GENMASK(25, 24));
> > +			return -EAGAIN;
> > +		}
> > +	}
> > +
> >  	if (regmap_read_poll_timeout(qdata->regmap,
> >  				     REGS_TRITSR(qsensor->id),
> >  				     val,
> > @@ -126,6 +142,15 @@ static int tmu_get_temp(struct
> thermal_zone_device *tz, int *temp)
> >  				     10 * USEC_PER_MSEC))
> >  		return -ENODATA;
> >
> > +	/*ERR052243: If there raising or falling edge happens, try later */
> > +	if (qdata->ver =3D=3D TMU_VER93) {
> > +		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
> > +		if (tidr & GENMASK(25, 24)) {
> > +			regmap_write(qdata->regmap, REGS_TIDR, GENMASK(25, 24));
> > +			return -EAGAIN;
> > +		}
> > +	}
> > +
> >  	if (qdata->ver =3D=3D TMU_VER1) {
> >  		*temp =3D (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
> >  	} else {
> > @@ -232,12 +257,14 @@ static void qoriq_tmu_init_device(struct
> qoriq_tmu_data *data)
> >  	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
> >
> >  	/* Set update_interval */
> > -
> >  	if (data->ver =3D=3D TMU_VER1) {
> >  		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
> >  	} else if (data->ver =3D=3D TMU_VER93) {
> >  		regmap_write(data->regmap, REGS_V2_TMTMIR,
> TMTMIR_DEFAULT);
> >  		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V21);
> > +		/* ERR052243: Set the raising & falling edge monitor */
> > +		regmap_write(data->regmap, TMRTRCTR, TMRTRCTR_EN |
> TMRTRCTR_TEMP(0x7));
> > +		regmap_write(data->regmap, TMFTRCTR, TMFTRCTR_EN |
> > +TMFTRCTR_TEMP(0x7));
> >  	} else {
> >  		regmap_write(data->regmap, REGS_V2_TMTMIR,
> TMTMIR_DEFAULT);
> >  		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
> > --
> > 2.34.1
> >

