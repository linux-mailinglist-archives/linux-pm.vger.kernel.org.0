Return-Path: <linux-pm+bounces-28434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92972AD494E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 05:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F98A17A7E3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 03:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F2F1E835B;
	Wed, 11 Jun 2025 03:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RBcboMMu"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013018.outbound.protection.outlook.com [40.107.159.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F74188587;
	Wed, 11 Jun 2025 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612436; cv=fail; b=YM6+VRXsZ1x+27Ohp24hPHhJ6Y12S0EgAF5V6ymQw54dbDVtteueoDnDGTrSltsxY/JfbSb580UAkyLUiliGY/9akVV4/hkRk3M3q/4xVq+uH97WvDI57jjW4Ix69zKsJBwKZTAXFd0eKdTcwMawOb3JKjXPp/oMRX6g83lIqQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612436; c=relaxed/simple;
	bh=N3R7dYoMrAgZltxEzuM9CP0mIe7IXELv51tY57rOigg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gVQq27Gy4/I9Rox0FIRINXJk1IKHRRLfPaB2+fBhauEOyH0m+SeVFhy4Bx3QHJbo4oF27jBiuserwTHO4gP0lud387ya+C0uPDqpt0Nqnj40a4QUqed2ApbItwTzXlqA3QbDNVavjsP/mImCPg610cHxZD+OgE25YeIrLCpEuVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RBcboMMu; arc=fail smtp.client-ip=40.107.159.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p95/CNt+4BDC6R90Arq3rvnhbA3GGmfagyu80fN2j/H1/Vr7XGLiVtjVzoQ3qHCH22SLW6XkS5krC+P3Pr0eX7ChB2VU7apGHp0pma6oGt547pASSsMY0ysyIwIjjglxhoj5s2iudRYhyEu3WUopvqsreT05aRKL+pKa247NA+eeZg3V53+0QQ4IbAUtiYnJMRhORPeO9KOMp2KGiw08BYc2MVih6dLwsFFqg5uBlz4kpn4eHy5myw9FaRU/nGg98j0EC6gGrttooFu74TCOn2NuZs1n9fUd1SKjoTZwOEFfVLnCFI/R4IAj412AdKGueXnRo/PCNozjnpHdWFlazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leL4EC+830mx8WYBWzDpr0Oe8lEbaEIjakn1BcxJ1HA=;
 b=ePM+1YqYz6MGJKJAlVSN7noallyV9uW+ZrL28jpCLEoAvdqW6zQkko1qA6UwY+vpYZ0oGXwCO85fu2qN/tdeqU1H7OCF9z1Cp+2FBWXR8vPKLmvFkfmF5+MWWMahf51e+KM+hfL8z1ALS4U8phy6oIa9P0siI4kPlyyY8hP4dMbn3THim3pv/fpC4JrE5XX9UCWUWB0GZpVtwKXNRt4xZzt7CYFB+9bC1HgMrqwcZozu5KM4TO+9t6CwUn2wJ1e9DHbmUzDNpPuLB1PWL6SaORQC2B5gFQwYQesXZeDqej10GFk470JQuch019lzhRQLowEdYGzpI7Z9uQFpvyt58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leL4EC+830mx8WYBWzDpr0Oe8lEbaEIjakn1BcxJ1HA=;
 b=RBcboMMuABTRH0EJFwcFBO3rhE7XTAritto6Edj1d0Ckm7Q6K0mxttz0L6XUL6RLSLGpbEWLhnTpnKtuOBuIZAGgBVVCKJpsFl8VlXRG3DEDeuFaAIjZoL8cIyOCnEd8Boc4Eowo+k341UkywkE5pCL1fYbuSoNgYRPTq1AVk7SGBEovqHxMtezQPtN7jhcr4XVjdfpgS7WxV6J/nGZlh2UtL6RxmUCwiTZ3l8D1UK7JpySAc/iCoBlVmo/IUDI08LiKdSLNNHtmVlKS38LeI6m3CuIACvdytza8yW6XCYLHFH8OF1NuSSaTn3nxuUZPa620CU/h27FfVGMA7n568Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7671.eurprd04.prod.outlook.com (2603:10a6:20b:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 03:27:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 03:27:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Hiago De Franco <hiagofranco@gmail.com>
CC: Mathieu Poirier <mathieu.poirier@linaro.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-remoteproc@vger.kernel.org"
	<linux-remoteproc@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, Hiago
 De Franco <hiago.franco@toradex.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>, "Iuliana Prodan (OSS)"
	<iuliana.prodan@oss.nxp.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH v4 3/3] remoteproc: imx_rproc: detect and attach to
 pre-booted remote cores
Thread-Topic: [PATCH v4 3/3] remoteproc: imx_rproc: detect and attach to
 pre-booted remote cores
Thread-Index: AQHb08EqHErDcF6d5U2TRnVBdQP9NrPyV0ZggAjJ0YCAAjiAAA==
Date: Wed, 11 Jun 2025 03:27:09 +0000
Message-ID:
 <PAXPR04MB8459F651D1D0AC8C51F292A48875A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250602131906.25751-1-hiagofranco@gmail.com>
 <20250602131906.25751-4-hiagofranco@gmail.com>
 <PAXPR04MB84594F9ABDF0728D9A71FAFE886CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250609173115.qecc2noswkcgr3hm@hiago-nb>
In-Reply-To: <20250609173115.qecc2noswkcgr3hm@hiago-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7671:EE_
x-ms-office365-filtering-correlation-id: 2b2a8400-12d3-4981-c690-08dda897d941
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?M0y3Cc1ksVpmoXjdFJSs7RlV5Nlswda2Z0zCXZ7nCNR9Y4m4qbrOt5nllaGL?=
 =?us-ascii?Q?tw8wWuYQwZEqPIe8UARg4g7n8eqCqUff7NojI0mR8dZD05ldgl3vw9BSbo7/?=
 =?us-ascii?Q?iSIj3hUNlpTHouv/m3VNaD0CGITirJL3M7mxdjt575ArBYJImyz396EeJ76y?=
 =?us-ascii?Q?L1QPpyZXJ1h5iX3TXFju7XtyB79GKUHZSrSPpc7vK88ZTJTJlz+77ZIcySV4?=
 =?us-ascii?Q?cmOieV/zSJjP5CiKBCaa9zkAEkCpO3ZXXcwvjw1Hs79LG0BEjeU1WAl856Jl?=
 =?us-ascii?Q?CdHOfWBTbC28jERmms8G5lnvRb03ZDU4DLAYmQWUKCCvHFpKec0vNeCWmYg7?=
 =?us-ascii?Q?DimFlBWjIy2K8WUyXCgth1T3V3rdh4hGi6+Cgb78hlWATcWBGlB0sRpY+Pul?=
 =?us-ascii?Q?JrB4dmgJuhm4R6nclJZlWW9XuOKnD4rzZDBvX7f395TzVZ3fhb+6HcN76nMD?=
 =?us-ascii?Q?PyCt5Hm/ZIrjc3XwyNPlI5UjV/XYIxgy04sfZIXFmjy4c75EgpNCLwijIApz?=
 =?us-ascii?Q?V3tM9XhE9/hfHOfZf+/MbLJ8XJBqVr+kX5Zz2May3EwEVcaJBknLbvmQaIGl?=
 =?us-ascii?Q?TaF2jjTbw4wVT6H7dpzAM3XQ5rS6UvbxWMu6R9n/bkPbomBhR7mSV9oTWh90?=
 =?us-ascii?Q?iVu7HG23H5vgNfr4tdb1Bka3r1eWp0AHdAbwAsBQ4xLTXfah3aVZSv5UYS6E?=
 =?us-ascii?Q?yx7O4DyU1XhnugAShAD/MlfO0C/biHj69dx8G1RLgYsyQziK5tjqc7f+Zj+X?=
 =?us-ascii?Q?Zf3z+JtVKASapkCP93Gg0R+Y9StxxIlfuIJJYFSCjJBt9x9/AHfBpNiqb8T5?=
 =?us-ascii?Q?0nS+/D7BV5WHvUhX+RIUiFrpIn9l1YMrmL61rGV5gEyfLmqwp0muX0sstUVQ?=
 =?us-ascii?Q?tCDXV+QLIKbbKvzHP/GggwUqWM4WFxsX8gsSkt/rR5oiu95gKBvvpAQe3yrQ?=
 =?us-ascii?Q?oW9IKqVmEonGLOR/1VbuQHPryn2ge1xNWaZ9nos/HgPlNB+0PUE9wtoqaZMJ?=
 =?us-ascii?Q?goga6zrHVsjZ33Ho+BJKkL+D+OMBWwEfUiQus63N9VF5fIeVHmNy9Fei0F5D?=
 =?us-ascii?Q?aJGPQeXL51mKFjjptNTyk9d03ykDnG00CxGBZZ0ZR8dXBephP20jeTXhZHYT?=
 =?us-ascii?Q?Vwn5vfTNXw1g1CrhXpffHzLV9xVUn88OScEegiqa7el9M9+f1U1euhqzuvKK?=
 =?us-ascii?Q?BawnCmsD15LCo8JjozWlPh8YuD8/PDb7YXc6EEhLMSXgkO7NoKgAqqLtzapY?=
 =?us-ascii?Q?t2UcjLkH5EnK6pYvNMw87tFk9WlulO5r/NTtwh7YaUqB/mnl3q0RT4/ZK5AH?=
 =?us-ascii?Q?KSU1/SwIur2LsYB7cKp9mdrk1xMDljHbTSdiNCsKQGp+9jjHaDilqbB67I08?=
 =?us-ascii?Q?gmXVL1s5YFyvfjtnbZNC38nyKj7ZeMbzvNxGqGJ4aN7ye4bhGVk5GXmWI8bR?=
 =?us-ascii?Q?qbsnXJHVY/LGT2pFSV3fAJnCoBLowKVlhF5rpaKIgP6nNS7IDgGnvUAy3d9X?=
 =?us-ascii?Q?d1GD3hlZIs/3rJM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zUWnKYIcqWR28ZkUmavdbEuz8po9fTKCxqiJMkgZt888aQV8t8qdFxj6XQ9p?=
 =?us-ascii?Q?cNKMKUaURlF0jHfkDDY05oWnUjDpHwVJRMZM3Darp+pFqoMvsJI44puq62Wb?=
 =?us-ascii?Q?D7zErYVvh5LPHHtVeReTNxvkCcDUoT7ZfAt38pKFu0Y+ATseZY1Mw6pC5y2W?=
 =?us-ascii?Q?iZdFvDz9bklATcN3GiyYi8mGFgxE0Ewoe6HvNwIlqD/O8dtBgx88XEjPFep8?=
 =?us-ascii?Q?5U3HsNwIUikU8eka80osz2p5fKCsN3XCmsjI0NLyeoMbyDyBFBeVMhX0pF6u?=
 =?us-ascii?Q?YsVMivkapyIVnmvywtLB6uTBdlNge/1BFTXb67CpDkw96FviXazxPuRyhnAG?=
 =?us-ascii?Q?sqXuj9lJjxopizRmJqjcdMVbNqiQRRJnSA8ekLEg3WZYP2E3JrX3W5bji7sG?=
 =?us-ascii?Q?YCV5e/gLlDEFDRk6KkApKAe46JgyE2psPAc/fjrBuSwyYQDxl5orlvrbwZAN?=
 =?us-ascii?Q?NOUUV9+LqhVVYAghazpxP8TGctTfPNQFscAAvU8vjf+wzEIJKbx17GyxCf5x?=
 =?us-ascii?Q?qgsW/wnP6CAQkAOZeOSykMCt4rjqS3rkMGfU1SD+7lKgcdrbwteCE318CMsp?=
 =?us-ascii?Q?T8jnFGtrmchfVnEawKhjCVMRHecliem4mSG8tIeCpeCEvjO3HNeebJx0Pgw4?=
 =?us-ascii?Q?7s1ISs0n5dC+edNDjLUIcmnPdfpdoo55S/lyzpobDpgTwvuFNJ7BDKzDcR2C?=
 =?us-ascii?Q?swCF5vbrMaTiRwJtlV+IEJ2j7RWXET9jQS+C3mWvB7bnImJ2LvrMPUBS9kke?=
 =?us-ascii?Q?zcvcqcOPMoaOV+vyAFlHWRqifldqMEjBkTaXZKSRYooJS3ibCaedEtcRYppq?=
 =?us-ascii?Q?l/rr7PfClpt66xFXZOtT8XdtLpgke6Cv8JEwBTlr88YNKkSfPUMHuagljfiG?=
 =?us-ascii?Q?Bpn4ypFcylsj+krYjQOZkoEzuWKfCffwzgkcMJgM/LQrU+TxUweaHMH4g67l?=
 =?us-ascii?Q?9c+DkEcSLC44kOs/2DVPaqJCh7ocWlaRhAi+8JUgYAxrD6ZUlH25jyr2yYsc?=
 =?us-ascii?Q?A9pTEfdSxuogXBlJrGZe2tAp98WtzwoANs8KFWZVsKKpPwHWi2dgmucJqbeg?=
 =?us-ascii?Q?j4oMFuSM8G6Svcw0I+h2cvLDGEw9UZcShuvcBBGpoQbkFolMe45Jg+4TM3d8?=
 =?us-ascii?Q?fHoUYEYeg7YFXE6YFdmDxurQurqnmKhxvWcO3q8RMs4lvn0VrfDiQ2giF0rc?=
 =?us-ascii?Q?FnJxexMSZuzONZNy+dN0WVvb32Sxz4nnHmfCUQJma2FX6UikadDhOtlmCSxJ?=
 =?us-ascii?Q?BWaLAIQ62kr0UC9yxn5+d/amC+e1ibGNwJ12zEa19INnD6tlXSJf81S1K4V5?=
 =?us-ascii?Q?YU9mcyYP3pUEcC9YTeLI5IdZYBgMYvXCaWoPoNDyuV6Vx1jtD2uJGVoRCaly?=
 =?us-ascii?Q?jYkS4PDGJf4T+lot+JnLKMNRa3u0Y5xgLvGfquyY6baZO72GUEbg+9oMh+hZ?=
 =?us-ascii?Q?UtrlEhD23uYrQxaxsIgXRTD6J765AGNHDTomMLfz8bUXW+eetWuYc6h+Hb52?=
 =?us-ascii?Q?5CgNjFpwer7+lhp1UQ9fzNoLhKtLBaiIBuroqzuwvC7bs3keTSKvaBadfaNV?=
 =?us-ascii?Q?BCEHEIyRU6v328xFYv0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2a8400-12d3-4981-c690-08dda897d941
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 03:27:09.4745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXcgytB7ExDNfm/gaX2xZhRayJqTEk3ei3GCHBeBZ6+rCskzJFQZp9fs7RDaS3OBEzMC1eZClsVLGTqiVpCZYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7671

> Subject: Re: [PATCH v4 3/3] remoteproc: imx_rproc: detect and attach
> to pre-booted remote cores
>=20
> On Wed, Jun 04, 2025 at 03:19:52AM +0000, Peng Fan wrote:
> > > Subject: [PATCH v4 3/3] remoteproc: imx_rproc: detect and attach
> to
> > > pre-booted remote cores
> > >
> > > From: Hiago De Franco <hiago.franco@toradex.com>
> > >
> > > When the remote core is started before Linux boots (e.g., by the
> > > bootloader), the driver currently is not able to attach because it
> > > only checks for cores running in different partitions. If the core
> > > was kicked by the bootloader, it is in the same partition as Linux
> > > and it is already up and running.
> > >
> > > This adds power mode verification through dev_pm_genpd_is_on(),
> > > enabling the driver to detect when the remote core is already
> > > running and properly attach to it if all the power domain devices
> are on.
> > >
> > > To accomplish this, we need to avoid passing any attach_data or
> > > flags to dev_pm_domain_attach_list(), letting the platform device
> > > become a consumer of the power domain provider. With that the
> > > current power state of the genpds will not change, allowing the
> > > detection of the remote core power state.
> > >
> > > We enable and sync the device runtime PM during probe to make
> sure
> > > the power domains are correctly managed when the core is
> controlled
> > > by the kernel.
> > >
> > > Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > > ---
> > > v4: Changed to use the new dev_pm_genpd_is_on() function
> instead, as
> > > suggested by Ulf. This will now get the power status of the two
> > > remote cores power domains to decided if imx_rpoc needs to
> attach or
> > > not. In order to do that, pm_runtime_enable() and
> > > pm_runtime_get_sync() were introduced and pd_data was removed.
> > > v3: Unchanged.
> > > v2: Dropped unecessary include. Removed the imx_rproc_is_on
> > > function, as suggested.
> > > v1:
> > > ---
> > >  drivers/remoteproc/imx_rproc.c | 29 ++++++++++++++++++++++++--
> ---
> > >  1 file changed, 24 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > b/drivers/remoteproc/imx_rproc.c index
> > > 627e57a88db2..6f9680142704 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/of_reserved_mem.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_domain.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/reboot.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/remoteproc.h>
> > > @@ -890,10 +891,8 @@ static int
> imx_rproc_partition_notify(struct
> > > notifier_block *nb,  static int imx_rproc_attach_pd(struct imx_rproc
> > > *priv)  {
> > >  	struct device *dev =3D priv->dev;
> > > -	int ret;
> > > -	struct dev_pm_domain_attach_data pd_data =3D {
> > > -		.pd_flags =3D PD_FLAG_DEV_LINK_ON,
> > > -	};
> > > +	int ret, i;
> > > +	bool detached =3D true;
> > >
> > >  	/*
> > >  	 * If there is only one power-domain entry, the platform driver
> > > framework @@ -902,7 +901,22 @@ static int
> imx_rproc_attach_pd(struct
> > > imx_rproc *priv)
> > >  	if (dev->pm_domain)
> > >  		return 0;
> > >
> > > -	ret =3D dev_pm_domain_attach_list(dev, &pd_data, &priv-
> > > >pd_list);
> > > +	ret =3D dev_pm_domain_attach_list(dev, NULL, &priv->pd_list);
> > > +	/*
> > > +	 * If all the power domain devices are already turned on, the
> > > remote
> > > +	 * core is already up when the kernel booted (e.g. kicked by
> > > the
> > > +	 * bootloader). In this case attach to it.
> > > +	 */
> > > +	for (i =3D 0; i < ret; i++) {
> > > +		if (!dev_pm_genpd_is_on(priv->pd_list->pd_devs[i])) {
> > > +			detached =3D false;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	if (detached)
> > > +		priv->rproc->state =3D RPROC_DETACHED;
> > > +
> > >  	return ret < 0 ? ret : 0;
> > >  }
> > >
> > > @@ -1146,6 +1160,11 @@ static int imx_rproc_probe(struct
> > > platform_device *pdev)
> > >  		}
> > >  	}
> > >
> > > +	if (dcfg->method =3D=3D IMX_RPROC_SCU_API) {
> > > +		pm_runtime_enable(dev);
> > > +		pm_runtime_get_sync(dev);
> >
> > Need put and disable in imx_rproc_remove.
> >
> > BTW: Has this patchset tested with M4 in a separate partition, saying
> > M4 image packed in flash.bin?
>=20
> Sorry for the delay.
>=20
> I tested it now and there must be something missing on my U-Boot:
>=20
> Disable imx8x-cm4 rsrc 278 not owned
> Disable imx8x-cm4 rsrc 297 not owned
>=20
> It removes my nodes from the DT before starting the kernel, so I cannot
> attach. Do you know what should I do in this case?

In separate partition case, UBoot will check the permission
by checking the rsrc-id, saying power domain id.

You may need to remove the power-domains property
from M4 node.

Regards,
Peng

>=20
> But apart from that, at least the imx-rproc does not crash or anything.
>=20
> >
> > Regards,
> > Peng
> > > +	}
> > > +
> > >  	ret =3D rproc_add(rproc);
> > >  	if (ret) {
> > >  		dev_err(dev, "rproc_add failed\n");
> > > --
> > > 2.39.5
> > >
> >
>=20
> Best Regards,
> Hiago.

