Return-Path: <linux-pm+bounces-17805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DD49D3734
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 10:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A721B23FF2
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 09:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B91188717;
	Wed, 20 Nov 2024 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JGzbOkB/"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2056.outbound.protection.outlook.com [40.107.103.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417FE170A3D;
	Wed, 20 Nov 2024 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095692; cv=fail; b=mIGQ8Ssp+1eW/szJ3/gtVOw3p/101WtDDpSHKhP6TY4xARkQt2ayu1aOM4OioKKF+ELhlPjOEnCPAPiRBLnbUjSP7L78QfxpdVovQJqKKS2CAruDaXMi8jrhZN2JfcTAGyzb8wKTPO1BOh9uS4YoafS7qq/Z7i4NEbEHHmrP8+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095692; c=relaxed/simple;
	bh=U+7tDjJnQWD/C1dzF9SoiyF5etykNDVi8TLeTYH6w1s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V+496CWfJ1Njpk8uZoqT+hNGShnMLIeUGgx+3QgOfJeVBji2dRtOCiHbTtcIn3+g4sxeKZk2S/pELJ6DZTaQ7QSG6veEkX/NY4EfcheYTgDos/pS/uD6c1pc/SLqqaKd6IxAlGINMxuilkFbBrteI0sfb47ax0Fxslaps4WJ9l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JGzbOkB/; arc=fail smtp.client-ip=40.107.103.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT+STgBI2RdCGDgZYaxs0SXajGX39yqAmHYGFJ8XdF+ojmjd7bGTuMrfYJOpzwbAlKG0qfmnBAcadjcwLMB5odHhWSbpcYaSDRboUTq5mpiU+fWjgmpStOxjBZj5n4JR+/Hik4jhewFqZHlagtnnlLFN8WHNa/y2vAu9I10YnUa1ZmA7Vnobu3gL9AmMAR61f6KGBHSgTkG7G+VZ1SLAvIKhK/rlgwXZIOO64Cadf69sZfDlOETDSHvwyKR40/spMm5ymFfY4JSaZRt626j1fkqBzvL0NvU092caJsxYiZ9LuJMM+9n64iSOD5ojC2PMC93Fmcmme5VE177ItBEe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2LK0tMhB6+/cnSkPzCXRoCL5dgxpm7k3a5OYNeE/UM=;
 b=h+dpiMfS+AAPfo5xA5iGU3oxRItTXDPPA5i5wRNP0Y9Olb5IZUJhhTP7tVsRt74TlqQQOZWdn7666qh2EbefxAzmOd2LswwE2wervRPWX2gZ7wUr3GCipWZQFwXI6X/qW0hzhWlxH1kb8S30XSBTxBsT5u8iqNQI/TBf2T8oHEVJAyG+A2GLoECvMZVLd7cJb8Ke3CHABk5YgqBJrWW+5iKKhuvVBf7koL2nCZnsqkeIqtLKyfmsRD3GQ650JBiuEydy6w7nzGd3sPaHaPX6vhho7Veu9VoYC5ArOsci/1FaKaWrXXaLOnXoYsnCiHwablMPu/Yh/7Pl3mgCAIYNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2LK0tMhB6+/cnSkPzCXRoCL5dgxpm7k3a5OYNeE/UM=;
 b=JGzbOkB/I+iHRlmzPnAw1IEp2rWaHJ9OQidvO72svdJIwbY75/+MuHjZth8EWcFzPjYOEOHENFgA5pF+ryD+kYcDNAwPCXbv64AVYvuZQYBCbAgzOeloKauYdeNDCsTvyV0hS+hQ7WmEYJoD8S5Omig0eW6La3UMmUWrZAYaCuC0DJ1gkVkex07R4z2zNz7UUkkJs8YGAldsEMl4NpNbRjwILl3dVKt7p+FRJ+PRXRv7bsuQm0QEyRwqKa+cufU5Qks63CiIlhrPgFGF1/BINPxlonfdFsX+4RnNX2sty6Mhfmnln1Ad3lMOMfvYwQHx879hvlNn6s+OKgeihUBA/Q==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by AM9PR04MB7697.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 09:41:27 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%6]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 09:41:27 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Dhruva Gole <d-gole@ti.com>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"khilman@baylibre.com" <khilman@baylibre.com>
Subject: RE: [PATCH] cpuidle: psci: Init cpuidle only for present CPUs
Thread-Topic: [PATCH] cpuidle: psci: Init cpuidle only for present CPUs
Thread-Index: AQHbOxqwCt/lUxHvT0C9yctjTWG0GLK/54kAgAAAq7A=
Date: Wed, 20 Nov 2024 09:41:27 +0000
Message-ID:
 <AS8PR04MB864270D86D36F0AEDFD5922A87212@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20241120070608.1314850-1-ping.bai@nxp.com>
 <20241120093044.5yeyel4263fc27k7@lcpd911>
In-Reply-To: <20241120093044.5yeyel4263fc27k7@lcpd911>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|AM9PR04MB7697:EE_
x-ms-office365-filtering-correlation-id: 37aa0b6a-62fd-423e-a1b7-08dd0947814c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dSTA72eOPwshSU9mvNgMyGQnEuJ0pbj8UrcoSaP4vUBWASwVQecBXkmOq91H?=
 =?us-ascii?Q?p6T/xwY6kXirtVLo85kLNxeNQTDiRQLMQwvNCv2wi/I2oF3dYNqNKZG7mkBh?=
 =?us-ascii?Q?gKdvC2ZKaDv3lPlF8Qq1AW/hK36H2mg8rZ/+SRIHDntfV8GFXgziKkx0tWeJ?=
 =?us-ascii?Q?TaoXgn6GMFov0g+kPEAoV1xVOlm2UIHqRua1Tt+ZWc8mEJ5Hrla8VYlI+qsz?=
 =?us-ascii?Q?jJv2JLaU3CXLtJ8fEA+HGXpTFCmP3Kmx8rJmVCu7qDdrjOMq+wrj7JNoGuVl?=
 =?us-ascii?Q?B0yKZUcC02j7U+GCO58JozEwFn5330HsqUMulpTpoCWBijVdDI5ZfuKpIMh4?=
 =?us-ascii?Q?hoPq8lpITAxxPS4tYg5bKSfhKYq4pqpAVwiqHC2Zff/sa6vNjqsbSDa2Bbei?=
 =?us-ascii?Q?ux5yP1oj06noJpSJPQImlzHc2pmti+a4WDldfsk5nqoe5+AtpPnoGcFI54+6?=
 =?us-ascii?Q?qw1tEnPMtWNbG/QURa1YuPNKbgRC4zTYmwkBARFJEBjCbUs6FxjfPq5syQhU?=
 =?us-ascii?Q?icaDfUtmtfO5bOFWXOAWqLiTErceSVWliCZGWPDqJl9SYy/2g1cP6WSzZAVg?=
 =?us-ascii?Q?F3YOsfvNHeKaaDhZrb7YpmHcFt8b7uXJgM/b/Tck/yht7QX3h5m4kay3yup1?=
 =?us-ascii?Q?KDbqHO/vWiUzGOMerSeVTYrdPBD0fJvKsA1q4yaZAkpw5fggH8w+Ixd3cwbK?=
 =?us-ascii?Q?CtkUwXjHCAodYSN7+UrDU94NOETG5aA40hIilnGXuM+5jht6z53Gp1R94gPj?=
 =?us-ascii?Q?kgxnoO0o8X9UpIdCEMBJ4iUbfTLUkL3tNNi1S44QPwr4BcedZYvqrK1iDIoN?=
 =?us-ascii?Q?AUOBcd+y/MiDbcyaAgCZzDVNFh5Q1Ophm382+zhsPtMeV2Yf+zn4Azm5/4fk?=
 =?us-ascii?Q?h8GSDuJhtrl0MhkwmFNgg6qIN5dH1XhrvlUZG0gspkVvKKuW/vtfH9vmx13q?=
 =?us-ascii?Q?g3/QRA9QT8D2xZYbw9gHyaYTq4ephU3hMrWW4NPWl7GOLpnfAz6E2NkQPGvW?=
 =?us-ascii?Q?7QR3DHnkkJBe14hvYJ/xXXjP+n5GQhMBGAXdqnZZQqF69pju8MCHO2aWHZQ4?=
 =?us-ascii?Q?thVpVFwhZOiU+c0rre7YYZ+Rl4cRY1r1ka/O/Xb3MWtytfPNuihrHhhHMqhH?=
 =?us-ascii?Q?xgrawjABGH3dDpkL+hjXaElriNcZMQ04+2W9xirhjWzZ0v01SFvYJhzpFJVT?=
 =?us-ascii?Q?BHBgyKRTxkUIRWu3YVJsJMA+lTMmpnoxoBmBSlZK3IiRNMQIWPXWYUnzhOq7?=
 =?us-ascii?Q?Mj7N5w3Z47+sDO5Dg3Wob8wsAvwyahpZfg0Pd8l1EhzFthYkggGyiVv62X1L?=
 =?us-ascii?Q?VmI0NLQSRYpsX7MvD0cxy42prhuMLuzK5sBf31KCd/CrR1e9tFGuKRkZMLFP?=
 =?us-ascii?Q?N5/0f3I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qWzUkefD9DHKVeyCnT0SrdKBRQ2FYJKz5+cgWYRQdMTAS9M4MiF89b7k0mxq?=
 =?us-ascii?Q?3e3B4DCM32oNW9TOTeJVnN3f0bpkNRqLlQBgLmJKMl0OfTX/I4wKullDhR5e?=
 =?us-ascii?Q?qozyUfhsKlXLeuJVXCGLWqmkftyAA7Gbyc9NxWJgoTkKtZq3CTjQ3DLMVwGR?=
 =?us-ascii?Q?eb4xcu4fWxLvN05/b7zQwJXJFKf1gnwK652UkoRC0qA0jiTsMkqUXm1ah0+J?=
 =?us-ascii?Q?6YK6Rh6+Crtp0W0MK1POkuWozolV640vkU1f8/Fo0fyqqnQ417O8tJGs0mgr?=
 =?us-ascii?Q?YL5xhU5yCgfwcgUPaNyqOjzeEK9bTGEyRnqHSjtuPScLGGlOFMfBOtvxaFRe?=
 =?us-ascii?Q?jPtTr/i6R3QXELhE8SkcDXnDKSM0FiNPMP9GsmcVlbNR0qz5T0qHuhxXHqfa?=
 =?us-ascii?Q?FaExgiIChFsHsbDZ8v8HOQk6hU529uYfapYU99ZRNvnkO5jBM3sfuZaQat7m?=
 =?us-ascii?Q?7Cf98QvAhAZESVAazzgbprZ7apBFVRFpCwho4aXcThAcuyycbQvzznFXnNeM?=
 =?us-ascii?Q?o5bW2AcAqgm25p2WRmLAPpBWopQNAUJ5TCv9Rf0vVysi6YU6SKUHQSPfm/kE?=
 =?us-ascii?Q?dfrDquyP0NkrXglqpMUGWfCH29NKnTTBxzTEOQVw7ao6d/VXwLg1ijJBPHHx?=
 =?us-ascii?Q?QLt74sC1uOizlCsnWUE/nBYEjjv0lkkwYca5OmIbAv2YBSYPcJNuT8EmxDj3?=
 =?us-ascii?Q?SdxVcZTP2nI0fOZA+rzHRkVPNCKfwc5cPxTrirbJXOtIjIDI0pBBsRvNeaI3?=
 =?us-ascii?Q?P09BIlWrT/40O0sI1gx5JxSVlRCQ5ZydcpLwGKLCbQ2WxUtstcS+QesmEcGf?=
 =?us-ascii?Q?6lcjkpxbRT001vHPsIcWPK25jKEAWXVIwYc3PWpgqmym4aRPgGkvtdcA2jj0?=
 =?us-ascii?Q?j4cSbHUAtVqoaIuePNchJLyR4knybhz8KknTTWtPWkn+V2F2A1LG48RjbRpZ?=
 =?us-ascii?Q?hex+m4dzWl/UpbTv6UhJJ07RzgKDEwAKeXjQIaYiqgm7AK6bzhuZEo2HU5tT?=
 =?us-ascii?Q?J7sdRMs4SBvCMsioENw8sdcHcaDAMKVbNsYIn7hJYSHG4FIKf4VJGt4XjjEr?=
 =?us-ascii?Q?xW9EucufbrQvyBDtsKrcuUB1z+XiuXhEWasdA98Lxwsvnd8HPpBhXEX+rq3m?=
 =?us-ascii?Q?nJppFwEkzCBWsmfPxQS2pV0IvW3D/ENk7tnD8jFzCgiw8+DwHnBzIXRpdGQ2?=
 =?us-ascii?Q?Vi8HyBACCw/2DLlS+Fk4vOFlKpCZmBWpY7hng3cMLtzYNYF153/wPXOWA4PX?=
 =?us-ascii?Q?iQvlIiMmiVUbk8dt7+jJoGb4kRtVlPa08USbxOAFjgELv+ccrXu1ragpZYu1?=
 =?us-ascii?Q?4plVAnBxiJd+GjRj5/GGZfDgdwyGVJgSbnnjJNFyXsuZoaTGMkQ3JBbkyJL2?=
 =?us-ascii?Q?dodoUVfKZdUcwe4tRBqq1dI6B0Un7012cc/GTVK/Oh1+jKzB+L5mQBF6jwis?=
 =?us-ascii?Q?HRL7wQuRcLjAOwRc4QX6UjpPTaTv7S4vWOw8b3nUK/x34uKf4EIrvMSTGYbG?=
 =?us-ascii?Q?mvI6+M6LfZRyyddr0+wtTvnXbDuGov1phhMdZc6rgLpwPQfQtphdEl3oUSi7?=
 =?us-ascii?Q?us0wHaWem3vT1zr7Mm8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aa0b6a-62fd-423e-a1b7-08dd0947814c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 09:41:27.2728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 952ETFGtiBejAVSki/0Az5q3HVzG8ep/kNF5fRJ8CT1/+aMSSpqyncvY47qYeH+2mKdffPOQ+eWP1STops8k/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7697

>=20
> Hi,
>=20
> On Nov 20, 2024 at 15:06:08 +0800, Jacky Bai wrote:
> > With 'nosmp' or 'maxcpus=3D0' boot command line paremeters,
>=20
> s/paremeters/parameters
>=20
> checkpatch should've caught this for you.
>=20

Thx, it is my bad, the checkpatch error fix was missed.
Will fix it in v2.

> > the 'cpu_present_mask' may not be the same as 'cpu_possible_mask'
> >
> > In current psci cpuidle driver init, for_each_possible_cpu() is used
> > to init the cpudile for each possible CPU. but in
>=20
> s/cpudile/cpuidle
>=20
> > drivers/base/cpu.c ->cpu_dev_register_generic(),
> > for_each_present_cpu() is used to register cpu device for present
> > CPUs.
> >
> > When boot system with 'nosmp' or 'maxcpus=3D0', the cpuidle driver init
> > failed due to no valid CPU device sysfs node for non-boot CPUs.
> >
> > [ 0.182993] Failed to register cpuidle device for cpu1
>=20
> Please can we get a "Fixes:" Tag?
>=20

OK, will add it in v2.

BR

> >
> > Use for_each_present_cpu() to register cpuidle only for present CPUs.
> >
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > ---
> >  drivers/cpuidle/cpuidle-psci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci.c
> > b/drivers/cpuidle/cpuidle-psci.c index 2562dc001fc1..00117e9b33e8
> > 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -410,7 +410,7 @@ static int psci_cpuidle_probe(struct
> platform_device *pdev)
> >       struct cpuidle_driver *drv;
> >       struct cpuidle_device *dev;
> >
> > -     for_each_possible_cpu(cpu) {
> > +     for_each_present_cpu(cpu) {
>=20
> With above concerns addressed,
>=20
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>=20
> >               ret =3D psci_idle_init_cpu(&pdev->dev, cpu);
> >               if (ret)
> >                       goto out_fail;
> > --
> > 2.34.1
> >
> >
>=20
> --
> Best regards,
> Dhruva Gole
> Texas Instruments Incorporated

