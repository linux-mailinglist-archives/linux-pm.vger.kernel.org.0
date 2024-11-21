Return-Path: <linux-pm+bounces-17859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD149D4D0B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 13:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2FA284073
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F124E1D79B1;
	Thu, 21 Nov 2024 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mPPMLfg8"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A121D3585;
	Thu, 21 Nov 2024 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192856; cv=fail; b=GVdJuzle2L1AzmgS3JqIKuQZEl6NQJUKkAiWC6pZCqwL2Do0+oYV3l++aq8oTwEzZnlHEFTO5rzukxFPwols3/2HW1rZun/bGYyJMCh6zaFey+xpu/MmsAFL8OB9ZdtHXX+s0Wb2wI11FK97OGkLSeT4gEbQUwUZnD+EDmeGlKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192856; c=relaxed/simple;
	bh=sQWIN3xcAClY4+pSz9yBW4tkZfrDf6P3wtc0vBWz1yo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CkTzlv+JSwzw0l63xm9+/rLq3ulwA0tgScGRDMDk4Hmh1shDcYI/7zd3QBeMGqNjaXBCqJkx0eK1ol5XgJ/SbTCG8xzqu5ynjg/Ab/OjJ23mMcEi+xX2hMr5cBwHlyPfy1yDUOOhgm3oKIkVk2D0qdjyh93jNXdoEk01WmEbcIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mPPMLfg8; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atqtYeLufJTQ+YTQNZ4iqD3tY44kzAo/5wEL0BUcwSmyCk14dheLCwkjupmOc3JKfOh312BTUQRaxTnTP/4pC7j8ESiIlbSFdNr8Es5V3Xhbj2OG6MKxNIeKB7UJFOgqN56iCgovVO1K5epX5LqwOYhcplruIs4KqPJx7QNXlWSwVRpQjnvqDOEo0gmA08d8CBlPsyXSLXJhFCaIHLxraQJNiCer8nyMoYjk7Xq+cX/hjOLyW2DzMJvei26ezvi7Ni0sNDY/RENpFNNy06KPEZ/6Dz8zbwSc5lPVVRfk28jZE+imal9xGA4LA/9Pm3GZdyI45kYUyfGRUDtxHpN4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8c1IbnTPO32S1hiOHx9Dcmr1h9CBr8+l3Y1/gMClSM=;
 b=wv/NmcisgCMx0i7bhOSVHyCDR0TBWv/7gicqes8y2u8XbFpE74nyWKrErbXjj8jreUxMn0OcluxeNFmKbxEAxEytDUsNquwe84ZhzNKDCAHTGCkxAPIv6JBVfWmupRq8QjHcJjbfUb2jt3tiSpBCqrfGzjoGawQtp6OPZzXXEbACBoVXZAb86DjubJ0sIdD0jMga03TAGOVjvkBU7g6cUHhe0rHdFytwOHbUcik7DHn2MXoPxGVnbgnD17sORKxpbFWKd+jV7/5BTZ0yxYQiWSybt1NSqoMfeC1ttBcNBJgZX9+SVdUxR051zoPygxKIhr57Jp10P/PHM5MFJJGrnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8c1IbnTPO32S1hiOHx9Dcmr1h9CBr8+l3Y1/gMClSM=;
 b=mPPMLfg8/wSL8ylyuqVhPvVAcc7FqMNXe/HGyJP2vlQpBKYgUaOKpsCkUocYksY4S3VRf+wzyg75tEGcu9SBHJkBTiPxhRM1hU0LLqK+Pg1rP38etjpHtuQkGImA395mX2TLbJ9RbJ5nuZxxMUWYZn5wdRKarbgf2mI6Thr5qYvYPdtsMGPShmqo11N6CyFb8UPw/6Z1hXR9sRRrsRIRVwkGrzFlWHuFzkJHgO9fjP97D1zknRCRoYxTYM3EKSEnUJC7Nn4C4lfwxXe/FJVSjcRVFY2Eycj3Nkkv1KNsd1l8Npukia1HbexN42zbY1VtYpXK0IFjdKjI3sUIj0pezg==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GVXPR04MB11044.eurprd04.prod.outlook.com (2603:10a6:150:215::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16; Thu, 21 Nov
 2024 12:40:48 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 12:40:48 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Thomas Renninger <trenn@suse.com>, Shuah Khan
	<shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur
	<jkacur@redhat.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] pm: cpupower: Makefile: Allow overriding
 cross-compiling env params
Thread-Topic: [PATCH v2 2/2] pm: cpupower: Makefile: Allow overriding
 cross-compiling env params
Thread-Index: AQHbCotjTSksRUq1mEyXqNdymTcGi7LBikwAgACE5UA=
Date: Thu, 21 Nov 2024 12:40:48 +0000
Message-ID:
 <DB9PR04MB846134093D2302B6D67E7E6288222@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
 <20240919-pm-v2-2-0f25686556b5@nxp.com>
 <48c0adb5-4ae8-48bc-8e83-3d1c413f6861@broadcom.com>
In-Reply-To: <48c0adb5-4ae8-48bc-8e83-3d1c413f6861@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|GVXPR04MB11044:EE_
x-ms-office365-filtering-correlation-id: 9675299a-343d-4896-28b6-08dd0a29ba1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EanWFUbUay4Bn7tTttnJWn/zS4lD/0NSP/1mCHXibvXEturAjapck+rlriPi?=
 =?us-ascii?Q?MF4datLirggH88JrHvUJ/9FmjMPfwUWC68Jb/mslbEDBEPVCqwVZelwuCQyJ?=
 =?us-ascii?Q?OH5A/3xMeVXuyQwYulm8RjjRMv/C1kHJqaxV1u8cl4Q6NjbS6IpwsXHCUdoU?=
 =?us-ascii?Q?INSqFvypOQA3bZ+u8TP3RTPAyux9Cfk9UB5a5Q5DuWLUkbFanYZbWcegHCMC?=
 =?us-ascii?Q?fH5f83EPGmHWejfpzpXDYg28BVmJJomomJYUe4WJ7lUkPPMGSNBwnkeK+Tm5?=
 =?us-ascii?Q?JUOYk2GSp6vbKTLutuiqA+h1THBvSjE1dv4JLJL0z8Iam+JIOoR6VaJUrSC/?=
 =?us-ascii?Q?3S4fCHd32eynOZnWTRKvFcQbOlUgelrlODfYgAhCONU9oqAbLU61tHbyjmCY?=
 =?us-ascii?Q?VCyDe2QcDl4ISSluGAtqnCJBKXszmNzgXoJlpwH5a53N2/y5jFTX1UsBnkFz?=
 =?us-ascii?Q?VDyOsoDEqKGVcQLm529637oy/j8DnYD3bKouX5nJjMK2zUIvxmsBAHt8BO6R?=
 =?us-ascii?Q?CuzYhZaGcnJr/FSQTNKE/WDGtKYKbksaMYUKXgkpHy2Y3B0fF5Ddx2g96two?=
 =?us-ascii?Q?H0EOu35oY12cG2OCfm5Z2sObLVxv+A9IE58qOqqyS65UPS90azlWZCjRSUUJ?=
 =?us-ascii?Q?+YwvPoBkntnEg2K7w0E7jetRsDrocWTAPByBO/y00XK54h4BMIfqyzZ9gX+G?=
 =?us-ascii?Q?TVOWQNDaV1yJSA6g7Kk7vV2pz8cBFOYfP4FjvqcDWEgRWiNOjnSeeejEJlAH?=
 =?us-ascii?Q?/5i/GKzSkrIvuVytPafY9/T8kVf9WRf2Mkl7p01h8L+oirMutwIs+2xfiNbj?=
 =?us-ascii?Q?ba5q1iKsFBnuDEJ3yjxoiBbM1t07xbPiQmukV/UDqGQArYt+vsy1zeegeafd?=
 =?us-ascii?Q?utOX/jY85fpEu5fN4//0qZAn8GTlmGBY2WSojGK0MNVvaOjkjQU6YwlOx3Fv?=
 =?us-ascii?Q?6iEfEspTdiTXMpKYD3cL37xMIZfKtaoxoNoNM2yimm6Q3H6H80YcyDlN5U/z?=
 =?us-ascii?Q?4lhnrpaOxTHfdWBPBHz2y5Za93wZfZONhh34rlsTlvuNUnOfuj0bnobmgZrp?=
 =?us-ascii?Q?3gvs8g+5GwRZO/L+8BXrulU/yGT3qo96iBY+b07zLP3rVberNGUbXE+S0pjM?=
 =?us-ascii?Q?s0LSk5N6tddkVPWCAM52j15trLsxrJXbFUGTa3s+mVdOqS97eVEI/Wj2GC/R?=
 =?us-ascii?Q?QAgFMe5ZCDJCI/4PNM6PZJ7CQmpPh9HpmwF9Fz0dGDiAT8tnCx0Xya3FKsm9?=
 =?us-ascii?Q?zt/I6C0/QpRD0A6gRm/fQw/BK9Iwj+6blupsaiJsPfoABrymOe9HqN8M1AzE?=
 =?us-ascii?Q?RRSxTiSoX9iTP49JHjEYFQdN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EtyqTSPQcEh2XOuN+zKpJ3ZlcJ11tXr1W+aVHdkeXqY9Xmg+GcdXgW0tUoav?=
 =?us-ascii?Q?34IjKwPNuHbqWYJOreBl3d+O85zIb8goM5fuWNkZgXenGMbXny5r+f2Ft//7?=
 =?us-ascii?Q?V2ZjSCTEb/B53LI9V6aJnUArUSeDI+TCIoHrmxKS3yH7rAgRdakHofxsQ4d8?=
 =?us-ascii?Q?Y/p2GTWpkAkJxN+0m6/PKnE4xKOIXDpjiFBHKcoXAp4oZsTUAgZvhttChhCD?=
 =?us-ascii?Q?TomNUfUtRPd73/7yajxbTthiFbRzzBREKTebJjjTdfKZDdijH9eoHa+AHOmD?=
 =?us-ascii?Q?Uhz5te7lkWAxRcI/2QZs+JTeJd6iFWXnA8JW30bSB5mQPm+oiVlcuhYQ8ZVe?=
 =?us-ascii?Q?i4oRERuQP2AEzbeHVy6vGdMAnLJnFOVTgk/88Wp9SjJg+JKi/bvw8rJG/nd5?=
 =?us-ascii?Q?BLiSq3viSiOoicoR5gsHZaDdWlB2C9b734MEvh2CvxAPdeTSET0/q9OsdqsZ?=
 =?us-ascii?Q?pOTP8FFrX+bXRsdVObkNrCGXeTI5/BRmWHpc7t8wPSKMMUEcD2kpFEOoyM6n?=
 =?us-ascii?Q?TsdGdPjDrUHhmNbzTWIVTsl1CfOaRB8HTfKaRZ/LS+UqszlFjfVftwWDEUE8?=
 =?us-ascii?Q?bIPdDBmyUTMP+7PBr6ENtsvN6pyuXVF0GA9vOB1txejqftVnIWE1zv2MRWly?=
 =?us-ascii?Q?MuEI0ACvT82+zsVgcskkaTSC/fYT5EOtz7cuNzsudBL0wGETlR+w9Ef2n+cO?=
 =?us-ascii?Q?mVbIz0bnJd3JfS2P3rBVU5sVRDz2NOFc3iaQOuoxZ7DbNBvaHMozuUUNYUub?=
 =?us-ascii?Q?ePWYS1B0c+s0C7LqeLRlBez7E5nSgleXAtac8Gnk7M2B5mRX0EBUVRqoHstV?=
 =?us-ascii?Q?zx1h5WgeuRURJyrj2K4A1lr8nUHfCbrCfGLYtrLQuZaBmR24JQmQAUCfTguD?=
 =?us-ascii?Q?9au1/qdxTG+YTgIkRSHZm7wXLi/O+JUGRz+I4ZUwbOMHe0+1wBNRERwT+cQw?=
 =?us-ascii?Q?4qUOTK8oTRgc8SLZ5U760G5AExqyI8leo384EOiOjbxeJEYRZSUJntH0/sBb?=
 =?us-ascii?Q?k7aL3OafejvPkHa6NblkjBb6WO7Nozqyo95+6JMi7ANRE7sSElL73T/R7GIA?=
 =?us-ascii?Q?cmdtcRuXTgVa1zHmVnr4epJ563oHDSAELtRfUwLLo32So+cY2/ejsUj5p9OI?=
 =?us-ascii?Q?s1k5YzX/7aiEwsI8+LEQ6hPSrxvyNDThTz6UPT5XQYhrfj8R7wwRcEbdKOBm?=
 =?us-ascii?Q?nhOL8K96GoKVeWO8PyBMe/SbVoKnW1LO7W/gtZkqE7wkE8IY+TWNYEuYHC/Q?=
 =?us-ascii?Q?zChgUw0nn+/XgbPCpXpDBHs20ZFSmjAvq/AM0f+H/8R8DTSOui6pYKSKe7sP?=
 =?us-ascii?Q?5VZdZ/Fzill+JKz399L/pDU2lC3v6vqyrHlrp3uLbG2IaREoPqxVkFaRKTsp?=
 =?us-ascii?Q?F4Upcr7En7Eaz3vhYsCrRUfoQ030L8mPC/hEMGu4tszDcHQkNy0M317/4QvY?=
 =?us-ascii?Q?wpPrJH7JBLi5NPMlKGYy2lIVmAS6j3PpAbYmo9LWnWi8I3GDa3cbHC6RhOHY?=
 =?us-ascii?Q?MAVNGFcLWaJHAZhlCvTiI86K8OgQ42qpXbMenkV79HaMzUDxsePzN/WL0uwv?=
 =?us-ascii?Q?rB2HwEZI9f8avSaexeE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9675299a-343d-4896-28b6-08dd0a29ba1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 12:40:48.8580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b0ru8+g9lC4RCiembD2pqQrOig3qFoMTH6hTf9PjdVECGtTc7Ds5W88ao9FqJcnqd58cll1kL3YEZ2yz2fR/fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11044

> Subject: Re: [PATCH v2 2/2] pm: cpupower: Makefile: Allow overriding
> cross-compiling env params
>=20
> Hi Peng,
>=20
> On 9/19/2024 5:08 AM, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Allow overriding the cross-comple env parameters to make it easier
> for
> > Yocto users. Then cross-compiler toolchains to build cpupower with
> > only two steps:
> > - source (toolchain path)/environment-setup-armv8a-poky-linux
> > - make
>=20
> This patch breaks the way that buildroot builds cpupower:
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> git.buildroot.net%2Fbuildroot%2Ftree%2Fpackage%2Flinux-
> tools%2Flinux-tool-
> cpupower.mk.in&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C246da9
> 2d8b6243d138c808dd09e6d644%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C638677609234547728%7CUnknown%7CTWFpb
> GZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJX
> aW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
> a=3DnL1YUl%2F07Vd8F0GpW7uRqdpZT74avOku1ox9N3%2FFkUg%3D&r
> eserved=3D0
>=20
> and after enabling verbose it becomes clear as to why, see below:
>=20
>  >>> linux-tools  Configuring
>  >>> linux-tools  Building
> GIT_DIR=3D.
> PATH=3D"/local/users/fainelli/buildroot-
> upstream/output/arm/host/bin:/local/users/fainelli/buildroot-
> upstream/output/arm/host/sbin:/projects/firepath/tools/bin:/home/ff
> 944844/bin:/home/ff944844/.local/bin:/opt/stblinux/bin:/usr/local/sb
> in:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/ga
> mes:/snap/bin:/opt/toolchains/metaware-vctools-0.4.1/bin/"
> /usr/bin/make -j97
> CROSS=3D/local/users/fainelli/buildroot-
> upstream/output/arm/host/bin/arm-linux-
> CPUFREQ_BENCH=3Dfalse NLS=3Dfalse LDFLAGS=3D"-L.
> -L/local/users/fainelli/buildroot-upstream/output/arm/target/usr/lib"
> DEBUG=3Dfalse V=3D1 -C
> /local/users/fainelli/buildroot-upstream/output/arm/build/linux-
> custom/tools
> cpupower
> mkdir -p power/cpupower && /usr/bin/make  subdir=3Dpower/cpupower
> --no-print-directory -C power/cpupower cc -DVERSION=3D\"6.12.0\" -
> DPACKAGE=3D\"cpupower\"
> -DPACKAGE_BUGREPORT=3D\"linux-pm@vger.kernel.org\" -
> D_GNU_SOURCE -pipe -Wall -Wchar-subscripts -Wpointer-arith -Wsign-
> compare -Wno-pointer-sign -Wdeclaration-after-statement -Wshadow -
> Os -fomit-frame-pointer -fPIC -o lib/cpufreq.o -c lib/cpufreq.c

You are building on an ARM host? Or you are cross compiling
with cc is actually arm gcc?

>=20
> Here we use cc, aka host compiler, rather than $(CROSS)gcc as we
> should, so we are no longer cross compiling at all.

I not understand. CROSS was set, but using cc to compile for host?

>=20
> The issue is the use of the lazy set if absent for *all* of CC, LD, AR, S=
TRIP,
> RANLIB, rather than just for CROSS. The following fixes it for me:
>=20
> diff --git a/tools/power/cpupower/Makefile
> b/tools/power/cpupower/Makefile index
> 175004ce44b2..96bb1e5f3970 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -87,11 +87,11 @@ INSTALL_SCRIPT =3D ${INSTALL} -m 644
>   # to something more interesting, like "arm-linux-".  If you want
>   # to compile vs uClibc, that can be done here as well.
>   CROSS ?=3D #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
> -CC ?=3D $(CROSS)gcc
> -LD ?=3D $(CROSS)gcc
> -AR ?=3D $(CROSS)ar
> -STRIP ?=3D $(CROSS)strip
> -RANLIB ?=3D $(CROSS)ranlib
> +CC =3D $(CROSS)gcc
> +LD =3D $(CROSS)gcc
> +AR =3D $(CROSS)ar
> +STRIP =3D $(CROSS)strip
> +RANLIB =3D $(CROSS)ranlib

The ? is just allow to override CC/LD/AR.., so in your env,
CC is set, but should not be used for cpupower compling?

Thanks,
Peng.

>   HOSTCC =3D gcc
>   MKDIR =3D mkdir
>=20
> --
> Florian


