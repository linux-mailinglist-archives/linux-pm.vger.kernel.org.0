Return-Path: <linux-pm+bounces-25527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FEBA8B34B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 10:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B286A44388B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDE722FE0E;
	Wed, 16 Apr 2025 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LHM0PrTf"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2071.outbound.protection.outlook.com [40.107.103.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A118DB37;
	Wed, 16 Apr 2025 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791572; cv=fail; b=GLn61FDs5vfj2q5BQ6J+XqBHwEdamySRqgi2DEZ1urk/g8si9zNqt12B0Kf8rHghThNXLz3jc6+EIVvrBbkrpFIcDGUrbqusSepCEvV81mhy2BpdQ/S8IWfQ4PA+LWKfwK9M1JfgQokyNG1/TIlPsVz68aT33M8mcJ5U9o8rDF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791572; c=relaxed/simple;
	bh=9erCfnd6HZB4QeJavUGDRbtAN/iDCwuUFLrxevXFDRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=htRaICY7aPj9YGWpMBdWa5bkOST3svF2nA3/sNWIZ8ZZog3MRM0qyJ4PwM4yUqQnZ53S6Pa5zfWe5K6gib+ZbO66vOeRBirKLnHQbZv40RCPK2ncSa0+UrPxM4gCacb6R7BUJN8w/lMOQRnQlRMyR6rujSzMVog3DWqMYc+Yhqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LHM0PrTf; arc=fail smtp.client-ip=40.107.103.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+JsByUceYntM2xn3VK0eBsqXY/bbOzhTU0sjbZeoaxU4q4Bn04/PUSfYMIVPXQ7ZRZuouIPvgwqrFPbnjmAZfkrwjQ64K2ES5O2Kdf7XrjXICt6NZ8uQYmHnogjCO3EWxME/kdeJABYcqESf976mYY88B69bvapS83Q25Q43Wc7iVtzvY3zQ99f586d8MXb6dzTkEYYBmhx/bkMGz/Fdi0arSw1i2KpbHc52lkTu5EkiZZYaEIyeGE1U/tR/vliM6GSlXlMXDfyCTAc/zu94ZeK1fisI/HN7Y6X3jnmRQ0gognTfCAkVwj03LV6fpS/qKhxkN7fSNMlFoBkx9I5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4wyiMrZcROB7DAg9OwPU2vxcLAM3p2uN6N6nfifsfE=;
 b=uIRA0Yssvwk19DJzYax9Y1xA1I7FIJZNcGnWrk0xVHfS9GdDfcMHZiHMTM4yXvvYkDSbnR9ZvUb+kOmiCBFWQ3NBT00c9cLuS7LvwNg1Hxqdv3n2qlpdSCOOiiFSdxcp+MKibZoJ6EJ9VDMFM7rlWnGwdw0dwiW8FROjdHXV2c9Y0cES8hBJsz0YwrPmEwiiEmqhy209It61BolYBBJfk2yyFfEoOCIKdbJq0rHHatngfeLv1dnoKcOhJdxgbLvduGjT/3HLe7LMDuFKzq8qKNXvAKHb6UUEWOC3iNsSfFnYt/0iQ+iKeQ7OS44ZSnlJ7QCauMk+5sd+KW+zhmnofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4wyiMrZcROB7DAg9OwPU2vxcLAM3p2uN6N6nfifsfE=;
 b=LHM0PrTfGsNUD9055Fhgqxf04k6QSMr1RMKs9+e7byHRE2/z3gcb78Qz6V6VkPnlioW/5d5fCofWtRM4NYzEJg5GTZWziHT4w1xwV6R/F96mm+abHrOUXv+XOcEjzP/RAEduIIHD4YUB4gxRSvsPcpVDWtX4X70G8SrqUpxIdl8sa8ARRkFv6CULDSPZMS8VuculIUk++G9qLli0sRxSH8p3ByQQFuhV+K90HiJu7Bb7rXw4H4gawlo+S4gsY7oXyy2yErCFKtzkbSC1EGY4qhgotSaXhqWLB0O6366xh8BFkx39hEUtrDyTzmU1Nos7UhAUsNSLZkDmvMIaJNJ+vw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10283.eurprd04.prod.outlook.com (2603:10a6:102:463::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 08:19:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 08:19:27 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Hiago De Franco <hiagofranco@gmail.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, Hiago De Franco <hiago.franco@toradex.com>
Subject: RE: [REGRESSION] Kernel reboots unexpectdely on i.MX8X when Cortex-M4
 is running and it was started by U-Boot bootaux
Thread-Topic: [REGRESSION] Kernel reboots unexpectdely on i.MX8X when
 Cortex-M4 is running and it was started by U-Boot bootaux
Thread-Index:
 AQHbpWxIyVwHrK1A2UqE7zPASmzQ0LOedbwAgAAHyXCAADO/AIAECmYAgAEXKACAABeSoIABNmSAgADjngA=
Date: Wed, 16 Apr 2025 08:19:27 +0000
Message-ID:
 <PAXPR04MB84596E1E47CDE57ADCE9B40F88BD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250404141713.ac2ntcsjsf7epdfa@hiago-nb>
 <20250411125024.i2pib4hyeq4g6ffw@hiago-nb>
 <PAXPR04MB8459ED6CE869173D4051257088B62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250411162328.y2kchvdb4v4xi2lj@hiago-nb>
 <PAXPR04MB8459ED33238AA790252E730988B32@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250414224452.gk4ccniqtumfbjth@hiago-nb>
 <PAXPR04MB84591C4D560C0D3D64F927FC88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250415184009.2fvtn7tbe6uzwiyg@hiago-nb>
In-Reply-To: <20250415184009.2fvtn7tbe6uzwiyg@hiago-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB10283:EE_
x-ms-office365-filtering-correlation-id: 36583b25-3238-47ca-b754-08dd7cbf67ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KRCtyAHwLw8CFhqoPLzSyZqnxapG2+IOsbrF8uUM1ZXiv+54HnZpXM84y1/g?=
 =?us-ascii?Q?h4AcLGIbBhNIUHV6fEH2UDUjcHOBG59kIB+bnH4AArIR253rIdZyXyqoFuAm?=
 =?us-ascii?Q?0k2kiIPt7KyZYCzO7QbmTeuA9xdDUw4tM+jAtn9lW+9U7Hy4Rt9ez65ye4W2?=
 =?us-ascii?Q?Wracjdg99ciq2lkjlNFRhJeKKF4KnnOyFLjF2P3QtRurW/qogF5WMBrce159?=
 =?us-ascii?Q?M80qRqyDLpeZxGDH50aqeR8HLqngBa2zZEYwwscL+1wZRnTqAqRwNiFCXNVw?=
 =?us-ascii?Q?Qjjkgbr3fcZ2NNzYolng0nWqmvq5IKoMD7CLEbaH4UhkgaMfOTtUSalVJDHJ?=
 =?us-ascii?Q?MvMfho0DFSyI4YwYPINTLSO516H70GUqOlFayA2B1HitoYvO2IINYWc1w9cR?=
 =?us-ascii?Q?k5jA/+4XCWylxTvC1c3UxcKtrECz8MEF6JY5fczTuHEwI9+O4TuSPbvtL5Mt?=
 =?us-ascii?Q?IbRntA7PTEwtU7/ux7WNPLo/NKef4NcoFRopApLngHiCx4NFd9IZqWzJX3Xo?=
 =?us-ascii?Q?+LuvASEF2O2t5/U307FqKNnBstPz0ahhI27GBqoN6YMn/7Iy3/F8fK3IQyBQ?=
 =?us-ascii?Q?9j0dJ8kGsjElpsx9/H22p2IWH2V4GnvXyuqQDHmi334fLra3bSSWeSQSo888?=
 =?us-ascii?Q?66fFcFwN6IbMhmsX8NrWwHiPGyKydrcWcMHkUuDP6uL6FS5/S2M/HBgxNfE6?=
 =?us-ascii?Q?yRdXEhjvDy5DexgCnL8ypBMEfqWDn6r30ZSaabzkJNUww1Un0NPghnoaRmQM?=
 =?us-ascii?Q?0SgJmpfYkcotpNSbnUedbMJcx96BB3EEVjJOIhvy/WGopscbTN7qbQBV69/i?=
 =?us-ascii?Q?ISPuqZqmTFZ/tHplPs5YFacBCl/Zvf6vQ4LGemlM8xg0+/s48MR8tVdwXk0W?=
 =?us-ascii?Q?qiQ0ipsa29OzOuEmv4cWfO48dPEUO2jJBkimEuiZKbF4FiFNNOlmlUoipMKW?=
 =?us-ascii?Q?ro1G7wId0AL8pug6QW1dHcSq1roUspvQWAKU+Iw+hoRORnf98io43MMQramr?=
 =?us-ascii?Q?lvqknIhdeW7FnsDaXNebDf4f2GvaL8kp+ycEOC5JDYlgNrItNJ6Qvh257a7q?=
 =?us-ascii?Q?UxMiLiw/IpP99Wag04FIQj4tsXK6ahOzr8NdyQpaaoyTEFTzFVIvr0uSurgm?=
 =?us-ascii?Q?zHsRpXUfCkldD4sk6h/4It7lQBGDa/vaLxX901NhkszzbYifUWLp7kI7hrmp?=
 =?us-ascii?Q?FA3jCWIQUkwrbBEoc1n+YMdR6xpHTfOOqUwvRJ20i3aR0gi+Y2F5OhAlDsLT?=
 =?us-ascii?Q?YwWHItRuuhNhPZRpXFXNOAliDmsMKt7i2q11wrQcx2aeF/n2Xl3fHJHPMu1X?=
 =?us-ascii?Q?f/Ht0HnipHFU2tIjdn+bGvXpbZGeeXMror7klyWXT1r50EJlipc4iIeO/w9n?=
 =?us-ascii?Q?ntBnCKD7FuVe6OmRr1LIWpNYpAPPH0SDPxxL/g9+qOAPq62+jZBqHKp1S0Nr?=
 =?us-ascii?Q?zjNZzJHlRKA+WwBa2pfj6/amTL4z+BKdmqDL4PhAPoKF0opjM6RAqg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C9xhlkcuWTlda7CdcnsCKf/dwGNC791mrKxd6ih1fzP/wkcWrA1eSwHaDZRv?=
 =?us-ascii?Q?obrrI5nePHjWGAiS5ZEEuOu9WIwcLZMbpTfSbUusuMqQBRa4UV0y9S3G9Rls?=
 =?us-ascii?Q?UOlP/GjtnR8bM0DLjDD0YzeTmtrI33svdYRp49fNaviEIyvFkx08wtpgHsEP?=
 =?us-ascii?Q?OUCPQBsRmB+Tu7wwSjH3K6ZOG9/TTAWWqy+bKl7eLOWR5T7USEgdwzi+WTOa?=
 =?us-ascii?Q?ypRo2QdtoHtVJ/i49Yul+0Bnblv020U3H3aBikVBwavBhkdCmEMJdk8t/sEF?=
 =?us-ascii?Q?hHqscQi56oaaHf0Fn0YRrT4anrk5ywgqzFXNVGYtkzKK7iOIrSZHnvyaepvu?=
 =?us-ascii?Q?g5m4M7QSFB2dECa9QRTaNGB5+X4TStyC7VZw8Tp3ZENZgm2xPJERR9CzTr6d?=
 =?us-ascii?Q?EuI0FBWCttb/UfniohtfhYEO4/5aXKZwgYw4mg20myLm+F7VjlGBKz3LGfz1?=
 =?us-ascii?Q?TpLvblQuhQHaCy0/8dV7ZPWaN6KopDVSXvjJscVmpmEBL3SSD3d7KyQXc/0g?=
 =?us-ascii?Q?qxKvlvmv+9ejr0glAVHEWfTJeinC7dZGR+MSN8YDXo/vrmjZIJVyvi6JaZSW?=
 =?us-ascii?Q?tl8agY2UrDWP8fH46v/4RheG598GTxvxPadnYVAX/gdviR9VoIH9SjiBdZqH?=
 =?us-ascii?Q?J6a3jxauJapAzzhPiagr9J3WZkKk3HeFpjTosdVOsZOLAqYfZoXdbG6y0h5D?=
 =?us-ascii?Q?AutFt5wGgRyUGtaPB/UP8LIVxr89m8PEttI/WTc4X5IQi0+8HDlQcDspx/ET?=
 =?us-ascii?Q?97MR3j+JRuwOwZYsJ9ix7bvv93zF2/LEELVPzbQLeOiOQ3tqL69CDewE02Zs?=
 =?us-ascii?Q?67bp3SZMCgN9zCSVq2/btkwGPoqdw220+vEo5zOVXf236T33XYIOfhC/ExFl?=
 =?us-ascii?Q?WZhdI0X3ziojuMh4wOzRlH1FMt7RD8xN9XafTpX09RcUePYBcsBXZwnM1Mdw?=
 =?us-ascii?Q?2mLD8aatvVl0ye7TZaNZ7gxXebarTzIDLv3DcjZrnOI55V4gzkmSHHOg9g/i?=
 =?us-ascii?Q?xqKeIyxdoy6I1TqIX8O4ebYeRk3s35DZ7osPk8RKaeLIE41xZhyEuW/s86jJ?=
 =?us-ascii?Q?zu5o8c5pRlJCJiw38x+DeWzfz4sSUpZWn+jdszu/L3Bhm8Yzg242flcUjtdR?=
 =?us-ascii?Q?Kaqo91GvY2HNNOgaFfQsaOqanzrPRmBpyl9y5DJobHDh6zcVeSMGvc829Vhe?=
 =?us-ascii?Q?Od9NW4HXpko6XLXWv1rCckFW9xFAJ470quvrwhLhtf4/MaqGXgojqgoDqMQS?=
 =?us-ascii?Q?bv7xFFvTqJSaW/wvPdB8ACQe+si/RlAg/ZwIXyrPTr/P7bAjHJDuUWE4a9V/?=
 =?us-ascii?Q?16cFjzMSQy8Ih176gosnONDNTNTc9SVANubFjXoh+34KugxuE2Fmg4MWuXMw?=
 =?us-ascii?Q?rjqL7f96hVM7A2wfzd9ewpD1ELn4CQNQ7wFFj7t/1SAJNXjfeDjVxXMWo3Cc?=
 =?us-ascii?Q?k7euUGVF+oyRjIAIqsUh/ZFq7JdBIVOrieShRPThSuvDpxctjDpymgulfXdN?=
 =?us-ascii?Q?yKp5KwFfAyLMxlRFM9VTArYkoexrce9NV2NAX5CUk/CBWWvw/upB12eGy4Zs?=
 =?us-ascii?Q?v6pynf3wp9VE2VOJpD0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 36583b25-3238-47ca-b754-08dd7cbf67ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 08:19:27.6199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzBckfl13JqhJFcURYe+Lna57oYiBA9nGLvQyw9aN2F0eDro+Rygx7QX6NSYNah/kfHOEcGIt+QF5maZyNrlWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10283

> Subject: Re: [REGRESSION] Kernel reboots unexpectdely on i.MX8X
> when Cortex-M4 is running and it was started by U-Boot bootaux
>=20
> On Tue, Apr 15, 2025 at 12:11:33AM +0000, Peng Fan wrote:
> > > Subject: Re: [REGRESSION] Kernel reboots unexpectdely on i.MX8X
> when
> > > Cortex-M4 is running and it was started by U-Boot bootaux
> > >
> > > Hi Peng,
> > >
> > > On Mon, Apr 14, 2025 at 06:09:49AM +0000, Peng Fan wrote:
> > > >
> > > > In your case, m4 is in same scu partition as a53, so m4 power
> > > > domain is manageable(owned) by Linux.
> > > >
> > > > However to m4 earlyboot(kicked by bootloader), if you not
> wanna
> > > linux
> > > > to handle m4, use scu_rm to create a separate partition in u-boot.
> > > > If you wanna linux to handle m4, but not wanna linux to
> shutdown
> > > the
> > > > pd in kernel boot, imx_rproc.c needs to be built in, and need to
> > > > add a clock entry or use clock optional api in imx_rproc.c .
> > > >
> > > > Current imx_rproc.c needs a clock entry to probe pass.
> > > >
> > > > I think in your case, this driver not probe pass, so the
> > > > M4 pd still get powered off.
> > >
> > > This was correct, indeed. I was not able to find exactly where the
> > > cortex-m4 clock is defined, so I added a clk_dummy to the imx8x-
> cm4
> > > remoteproc node and now it works, the code continues to run and I
> > > can control the m4 with Linux. Thanks!
> > >
> > > One thing that I noticed is I cannot make the RPMsg work with this
> > > devicetree node, even tought I assigned the correct memory-
> regions
> > > (vdev0buffer, vdev0ring0...). Also tested with the rpmsg-lite from
> > > the linux-imx. Is this supposed to work with RPMsg as well?
> >
> > To make rpmsg work, you need a m4 demo that could publish
> resource
> > table, such as i.MX tty echo or pingpong demo.
> >
> > There is downstream rpmsg driver under drivers/rpmsg/imx_*.c that
> > could be used to talk with m4.
> >
> > helloworld demo does not have any virtio devices, so no rpmsg.
>=20
> Got it, I was able to make it work with the downstream pingpong
> driver and the MCUXpresso demo. I can launch the firmware using the
> remoteproc and exchange data between the two cores.
>=20
> There is something I noticed, when I start the pingpong demo with U-
> Boot, it does not work. I run the pingpong modprobe on Linux but the
> name service is never annouced. It only works if I start with the
> remoteproc on Linux, not U-Boot. Is this because of Linux not being
> able to control the M4?

No. In you case, you could start using remoteproc, that means
Linux could control M4.

>=20
> If I start the binary using U-Boot, the "state" always report as "offline=
"
> by the remoteproc driver.

In drivers/remoteproc/imx_rproc.c,  imx_rproc_detect_mode
case IMX_RPROC_SCU_API is used for detect mode of M4 for i.MX8Q/X
platform. Please give a look where it returns.

For U-Boot start m4, linux should remote state: "attached"

Regards,
Peng.

>=20
> >
> > Regards,
> > Peng.
> >
> > >
> > > >
> > > >
> > > > Regards,
> > > > Peng.
> > > >
> > >
> > > Hiago
>=20
> Thanks,
> Hiago.

