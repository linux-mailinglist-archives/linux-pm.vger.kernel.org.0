Return-Path: <linux-pm+bounces-14512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A097D33A
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 11:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D466E1C20A5C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67230273FE;
	Fri, 20 Sep 2024 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UzOxjXdN"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8209B21345;
	Fri, 20 Sep 2024 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822914; cv=fail; b=qamVCiBoFbVhGbp6W760gHceesDylsZjqjscVp23aAizIW1uOA8aVPB88L/QgV1nx/IuRfzgqOLnghC2eCK98OqpWME/79TAqsS5We6PQMf59majqIXdSCrMXzWPVDiYophFk3eyVZ1mWRYTpI6+TdVRWX+TC25rPozuqTpi00Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822914; c=relaxed/simple;
	bh=P+yBM6jkkIwpiqNWVG1h0nTV3wn9CJUKju9LR+mI3Y8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fsISuGyFtlhHGnqzAwWn/ZRhez4rDV1XctIpfo1KbOCK4jCltp0YoHeTFB64qGgOGGgmhP++ExscmkJayU9WOdyEQUn7WQb+Up8SFoE0lk8vFnhIrSdgbnU2YxmVjB74L9ytN5EOauTHbEwjf/D1Lyvcm/+3XwhatkP4ZdgIPcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UzOxjXdN; arc=fail smtp.client-ip=52.101.66.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWD0JkRwQdmNRNuf9m4L9MbGro3pX1dpg7e5JM/MN89e1wmuLjLJTbu3oeX6ktEMr37VrSCmAWDkpKtsc7f5C8Xoj2GVmB+GDrBsRYuKQzWXaVzqEucuKewXLNXLW9TeG5I/ZNWmVc4gwBYRZcpNxvqnbDZ7K9juJsBXiFGBZbqAjwQ6ExdEs/NIABoZqsQ/IPCQKso9h7TzXU5eNu2UgLUrUYHFI9dN42NcsCTeQqx+ii2ZU0f9bylP6CSgTDLMeQpH5sIN2xYN5kC3mzubQZir4WdI8Mg3nTF6rHfQrGaEBi028olpKgJZ3KG5HyRunS2BfL5jzq6q9PA+BtOV/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDeT/vqj8urVcIbPCF2LliVWYeTe3tad4xi83ia62fs=;
 b=lYibu/QLX3UALmnappnjXScX5D+PNZbz+GyojR8njRXkwtsmGhMqQiPozJ6LK8+dQmqay/kK5RiEeBh2DXqja2XprB6k0U4ojFYXfeKYIZ7p3xl6/HlTQVUKLwspmR2ApUnbVJLKQrmeCtu/gKy4SHH2fTfLw2qmK9Q70fQsa6aweV13buaEwLbKMqKVl2nduDnnrI0u5te3FpUYshJINViEKw1JvOWtSnviNX8w/DcDX1WsZAE2Z/5KgX9jKIimbD4JgF9CCOUOb4C+TwfPhjlqShhftC6/1Jj6IUtwe8AoGe+BOP3dRf7ptJX1v4MWzLF1Z4AXJLifPhe/AtiIHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDeT/vqj8urVcIbPCF2LliVWYeTe3tad4xi83ia62fs=;
 b=UzOxjXdNL4GqobqAR/tE7ZUye0k6MKC8arwU5//leNrUqllTTGs50yw8RqsDuj6/tyFcxw2OGza2VNQH4EfxEe0QoYfSrMv/vd1S29MiY4TdUE0U+aYIaIzQV/OsVu1bP2mT/EtgVL0ZvHjl4UvAuAmjlCrGCcL1h6GdPa6d73vn3lW3tHYEE7J3JIpJsm5MUzls2o8E9tnVL5X/h1IT+kzzDznu/j/wCbBoTtLhE9KXNf78eI0015tURkb++lljfDD76A73siWs8ltnWok2NTOVMiXRA86mZ2W56ivPF+wpF5nwaRaR1IJoF/lEkJtxWn0cHVF2kIx2gfSA5UvtTA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9751.eurprd04.prod.outlook.com (2603:10a6:10:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 09:01:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 09:01:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, "John B. Wyatt IV" <jwyatt@redhat.com>, "Peng
 Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, John
 Kacur <jkacur@redhat.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
 cross-compiling envs
Thread-Topic: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
 cross-compiling envs
Thread-Index: AQHbCotf4uMyP70W+022nGBUmwhal7JfT6uAgAEQhSCAAAHVQA==
Date: Fri, 20 Sep 2024 09:01:49 +0000
Message-ID:
 <PAXPR04MB84591B0819F847D79548CFB0886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
 <ZuxTjy7I-pZBcXa0@rhfedora>
 <PAXPR04MB845910C56EA61D3215DA5452886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB845910C56EA61D3215DA5452886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB9751:EE_
x-ms-office365-filtering-correlation-id: 7dbdad55-d119-4dd8-71bf-08dcd952dc9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7FNby74+EOVZIVLiNop6cGh3l5xkbNLfr1kb+arVYEhyYZf/HpYrRz0iSAbo?=
 =?us-ascii?Q?e7MvafUJ4M2U9UqFRL9U7dreHeeI1s4aetDZqmIEzgUhOnWGuSYz/4Lc6J2y?=
 =?us-ascii?Q?hJKgZ0aMkft0o01rJuGpGh72iV/wOtLa/FNHyftG/CrGGorx0k8rekkJ0e4V?=
 =?us-ascii?Q?005lIAbofHbg4dkq8UDr4PFcm7q4HxFOB6dIqzawEXLIzZI81A5HIjxDpa76?=
 =?us-ascii?Q?+5EBOWLZnIncD4i8h1o1rh8N8XPk6oOuONp/hIz6RS0xOULQHFQ3y8EBHGie?=
 =?us-ascii?Q?arPbCK5ndH1PKGbw3GMfLSbo5GSPOroxUQ/p4wNSemA2fmLU9rjkyEKF62Sj?=
 =?us-ascii?Q?HcQV3khF7iLhREyxcSUt9qqGFKkzxlm1os3G5mupY/AiiG29Ec4w18eJdwKs?=
 =?us-ascii?Q?UL6+HouFbpqgsy0FoA+xzRXQXaRwNhELQEqtxi0p2NxirZhwpJ4Cz7NpNP7s?=
 =?us-ascii?Q?AbST7TV6MBX1L6rrEj+d0xN6wBV6C7FipmBcjvn3cBRXJpWHvvPS0mveKEL0?=
 =?us-ascii?Q?10hQHVnnF3DcI3IMidE0uxF5goOBJRehLUFs4KFlnJLw7tWmjFQmsWaVX8/q?=
 =?us-ascii?Q?f9/Sob26KiQa/XOon+G5uuTDcWFvfztzzJbbNB1wT25RRUHf0ZIlz7rdBfjT?=
 =?us-ascii?Q?85iaJ3EFe/74+3DyX6SK9iMuSHe7LOIsmtccgPrt6MtjI7HX/+kXrvMvXoRv?=
 =?us-ascii?Q?tje6DCGMiVqkUjV50RcPuz5bcD+HtsCn4paWgXk4PblPPVHq3FtJmlmmUIOU?=
 =?us-ascii?Q?PFNMm3EEy0bd5lxdMm2q5QzLIgu3D+wDEUUWYfLaXk39F1UWna+wGgDPKj5R?=
 =?us-ascii?Q?C7z7srneg6SC2BZJNjbbYzFqQUyc6G5/MPQ5+Q8xQpxHHFjtkCdCkh/gMdTr?=
 =?us-ascii?Q?nft566CoKTXIDrz8B+ktApZt6/CTUZWDbaPckFcbJdWV8cUNOGcfnnwQfGgU?=
 =?us-ascii?Q?RVlUePcWa7BlPmeAwCwGofzf1BTA+WoHpa8tg7aY952cTsl0zJIq5+/DT4b8?=
 =?us-ascii?Q?R19+nHFAqN+5NWlQnY9J9Xj4Duonfn8Hy16ZVuDfyViIm3HOn4Dw1o0q9uu9?=
 =?us-ascii?Q?vC1hI1qeLw6lspdBDkwY7vsl3MN+AmlKCOm52dU3j0QmPyI2z51i8gqr2hAB?=
 =?us-ascii?Q?QUFBnwiMLTAI2P5Q/mQFK0T0CIaiT0cRkrWORh/zvdo/wVJvLeY/TQsgNoVK?=
 =?us-ascii?Q?3H1i0KY5OLMO33yYk5U0JI6jM16gQ76jwn0SzZ7pNWSBPAhTgTypvnlJaTOl?=
 =?us-ascii?Q?wVjGUe76FJdvD8EbdtQngE6hrhziNrraPOeE0U0XIg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4T5zoUhoT5PUsIN0fEV9r4syeysiEbUJrMcK7WYQqTZtFbYp6vFHOcGXu72a?=
 =?us-ascii?Q?L833ySE+UscvqJ3WZ7UyDo9cyJN0PU33xJou0SXwwKBs01L4/2hsHLdDCy0Q?=
 =?us-ascii?Q?iUEAo6w1wu9exKwMagDl9zvOObFmNY7FwI/C4l1YLPU+FzwA+srfJKY7ORwM?=
 =?us-ascii?Q?hrRIK0fOl2/WEOZN86/SgRH52P73sBIe9FRnnrCb8UbSCLsq7N00ZI9q5DYJ?=
 =?us-ascii?Q?wI3vT3UhozpVsSFbxZJU3zkhXkeOXox2k8BSbLMnIBonmfMA4Z2Bl5SiE+Br?=
 =?us-ascii?Q?Nx04cDqNdivTDFeDlHlT2tvEEULEhwEEH76LzId+QKhn/shMUaugOldSxyMN?=
 =?us-ascii?Q?+5vVgEGif6EsetlzZ+AWmCwisYD4lOLh+tk+McC6aKKtVOXEjphzcBFFgtmu?=
 =?us-ascii?Q?cTVmvXMh8PBfS+XLNSUFAKR5TVMvrihcEIMZ30VGuuyYUUgJz4cMWLbxPO4Q?=
 =?us-ascii?Q?+AjJX3E/XulYXpVhnWJuDOz/roZNT1rWEeuvCqzDNBjtDnoHIXBUtvGU8NY1?=
 =?us-ascii?Q?heRivSdlM1vxZDWmehofXpdMqMjccK7WAwkpsX334ASUnQhLbDqgpoF7ldln?=
 =?us-ascii?Q?hCNElqHUpxgIxynRDRmX1UzJHEYcCW3VgGqBth/BxtTf0/cOjr4pDv0GrAJf?=
 =?us-ascii?Q?BStmbF2Dicu+z9yTwHfyf8qmqubVLEwubmi0v0FuLi4v9U7HSAX82Zu2KRLJ?=
 =?us-ascii?Q?BO9/t4FNXUsZEYUr/DEpx4RAImzZkEHeqw7rtvTQJU1XRgirrd1cafnVcCpc?=
 =?us-ascii?Q?+yDhzg9Wpmjcd9lYbFeTHZnxlp/tnqxMd9vBwMsrbnvpgr3lLmhTLpbdnyEl?=
 =?us-ascii?Q?C/5Pnp0/VgEvHKOuUPvEVAj2mmLNCGfhadmzPqLUqG7+qq9ymXiRazIb5ice?=
 =?us-ascii?Q?eD//l8Z2w8KeseWBxM+QT1vu8wYI48BMCIkSMlqRYrtC7P1sRNnfU0Ye9kAt?=
 =?us-ascii?Q?Vl1pIII5zEU/tQue1AUSCLfyXkR45vWIswTZiUEfMBB6boI5rbHAbxNBBJMv?=
 =?us-ascii?Q?IPZy+qGZogitT7nIvEkDBtMMdRrU3HtlrauYakQjJQXGhcT91M+XGn6FMQNo?=
 =?us-ascii?Q?tzfiCOmQvEtHKpYgEepVoISxMGCOpvaoSr2pQmEHaM04uE/onAWq5sh2A+1z?=
 =?us-ascii?Q?eOrupUyi0kmPv3XJmb8ASk7OEnrZZox5vmA6UT2TiFJ1zrkHRJJQVwwpq/WN?=
 =?us-ascii?Q?H4E6JmHl7y0VifA2nUsdB8dxygG3Vy1c46KRCrKRv5x/D3HXE2d7EM+MUf7m?=
 =?us-ascii?Q?WZyUIAdfdNn6x2Z53lvdLjBs3SpmyTP0CvYujz8BMSSKYgx2JwBOQK7ZKct1?=
 =?us-ascii?Q?jK0azxkB6TSAWvBDzG1KZaVZWNfZLaW34H3bFlDGe84cyGXOkvMBXf+8Pk9a?=
 =?us-ascii?Q?ZNzHcIExZQOef1bHxy5LQLgpXD0SWQtu6dXHF/XQrTaqKMmRyAfO+IagByEs?=
 =?us-ascii?Q?aWCp/vnXEOG8dJg1G5qY4OLoo3c3qmSdUJ9huaRalOk3sHSpnaV6PxjyGykC?=
 =?us-ascii?Q?kQrwq5q37qdViW+qp2OP+YoiKYMAwt8K4ivZZYxVdPvIJgs09p4C+YJM2EUD?=
 =?us-ascii?Q?ENYEVu9v07UwdpdRTeE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbdad55-d119-4dd8-71bf-08dcd952dc9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 09:01:49.1232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VIpkH+s4DD0yhzlOk9DpSN6+E0Qj94DyMb4NT0TI3RFx5sCL9Sizxv3qI61squoX279WWLx2lEMhwTWnSRKohg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9751

> Subject: RE: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
> cross-compiling envs
>=20
> Hi John,
>=20
> > Subject: Re: [PATCH v2 0/2] tools: power: cpupower: Allow
> overriding
> > cross-compiling envs
> >
> > Hi Peng,
> >
> > A few comments:
> >
> > > V2:
> > >  subject update, commit log update in patch 1, 2  Use strerror in
> > > patch 1  without patch 2, need update Makefile with 'CROSS =3D
> [cross
> > > toolchain path]/aarch64-poky-linux-'
> >
> > Version information is applied per commit patch. Not in the cover
> > letter.
> >

Just get this from the page:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-=
canonical-patch-format
When sending a next version, add a patch changelog to the cover
Letter or to individual patches explaining difference against
previous submission

So it is fine to put changelog in cover-letter?

Thanks,
Peng.

>=20
> Sure, I will follow in v3.
>=20
> > >  without patch 2, need update Makefile with 'CROSS =3D  [cross
> > toolchain
> > > path]/aarch64-poky-linux-'
> >
> > I am not sure what this is saying exactly. Please clarify.
> >
>=20
> Shuah asked to put that in changelog,
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> lore.kernel.org%2Fall%2F0f8df90f-007a-483e-83ce-
> df8ff0e99791%40linuxfoundation.org%2F&data=3D05%7C02%7Cpeng.fa
> n%40nxp.com%7C246bfa4c006340cb2f3108dcd95293ec%7C686ea1d
> 3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638624195921233948%
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DKj9
> PVl7PaBNAMZQ0bHL7F2ZIAhcziUEkEE3vdIrYmtU%3D&reserved=3D0
>=20
> I could put in patch 1/2 change log in V3.
>=20
> > > Subject: Re: [PATCH v2 0/2] tools: power: cpupower: Allow
> > overriding
> >
> > Not sure you need 'tools: power: cpupower:' in the cover letter.
>=20
> Will use "tools: power:" in v3.
> >
> > > pm: cpupower: bench: print config file path when open
> > > cpufreq-bench.conf fails
> >
> > I do not think you need bench either.
>=20
> Will drop "bench" in v3.
>=20
>=20
> Thanks,
> Peng.
>=20
> >
> > --
> > Sincerely,
> > John Wyatt
> > Software Engineer, Core Kernel
> > Red Hat
>=20


