Return-Path: <linux-pm+bounces-14511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45F997D32C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 10:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93176284126
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 08:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE187137932;
	Fri, 20 Sep 2024 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SMvDSbNK"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013066.outbound.protection.outlook.com [52.101.67.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3C7FBA2;
	Fri, 20 Sep 2024 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822686; cv=fail; b=to7+o2/NczNhUHkio1APATrZn9bYznfEQRGKu7UszyuRn38ATC2hf4McdjUtJCKLK7h+iNMbeMCgwoIsULKrK3LSc63vJyP7tpvizIRdr+xR/ctOXOyJov6bbRygj6MhB0IFH/eHLWjX2UlZfE62ekCZIOt+Q0RWTym4TMRzTC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822686; c=relaxed/simple;
	bh=w3UEXERWQGpsX3nc/3iJYUOWbn847jDDHC2Uv9kCsPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bL45ZdClNxzY1s5M8WUn8jinnxaLSRxfnqMZmJoVrrtvB4gzvSMs+Q5+6vkhQxV7hrqO2mHs7wNfY6j+eakeShSCxTs9v+WDsrt9FXMBIZwabAog/EHo1OU3nfnm6lsiwNBDM9I/hXsTLAI1+EenXLFE8fLovEMG5MIraDU+zsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SMvDSbNK; arc=fail smtp.client-ip=52.101.67.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEc0/pDkeBqCorn62lr048RsLn/MBgi2iNV3zsqLT2J2g/SZcI/ldO6UbEYrRbvID+Qk0y3B8PM1IFoanaRX4KhbgKTBidszwdYIMnP/q23PWIKPVwrOeMBMRNTdIo1HqQjv/lEovWTEFJG1Ugv0cyc5a61Q8lHxCu1lpAU7jEdoweEYXqT3vdoTEPDfBFBy6RYDpfUU9tPssdrh31KGoAp9KLydcAXPVOeO1RzNLkvZPMoyL3E7OAu5CzWhXMxBvmD6Kg4ZcFqDPySlSc/3YEImstRq3rMJxhtAJExzc6mZ01+eFolCtbkXOKOF3GCZaaUSxBBQIB2pbeqdMSBgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZxjs8WIZytmrTLnL0fDLSqiEwF+r0cH3jphtQ3ilD4=;
 b=zOkgkX2TqSgZD1ohLr6nXfuToMoxHqwZ1g/QoC4rXDGyki33uWgmsGVmTX0R7a2WzmFzsKhIz7Rnxi1VXtWiwxUPTUm52ib422walhK3UVsY7Ny0MZvThyp2gK8brXUCxBb66wjB4yTUBA+al03PZhrG5cn5ZAgHGAZaNhswa3C3K/s1/+7wr3dtO321K/tsWdGSWpiLOFCFQs6QJOGEO74nh1rTIRObaggfrcO/+WgBK/zmD/z1fuYNZSIZS5ceDuRK1Q6Ot9/GuX/Z2xmDQ+YzkgQ3O6Kw42J0FGK322PXjYwClRKRLBXt7iCJAa4RX/Orm+c2/BgUzvSAczrr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZxjs8WIZytmrTLnL0fDLSqiEwF+r0cH3jphtQ3ilD4=;
 b=SMvDSbNK21CAO9a6gjp9v8v/iHUm85pRxPJmkdG6lp/1t9WBAgcTC1frGTjawq8/Q5lNpDQtkgaK9wF6KBOsBwESv4zKKFUTW3C+6jz3sOqZVhzCGrgAairThB94ZGVx89/zPiL2o8z2Y7zXCIlGG3v7TN3xMlJRlc6u7hf/4LJwzPLPdBTkyZBdk0sriXpzMFGq9iPntOmMaWyfGDyij4GJ+Yb1+SQ+3Xmu7qgW7JvBcRDZXgf7lbq7DN9DkMJcQuLBIUKkvAa05YwmiwTvLDwi0N6KngfjLs5fzaoF5ECpQWr8zERksxW9hLn4u3SxCbIvefYxm0PpJzFsGrmLNg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7074.eurprd04.prod.outlook.com (2603:10a6:208:196::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.19; Fri, 20 Sep
 2024 08:58:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 08:58:00 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, John
 Kacur <jkacur@redhat.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
 cross-compiling envs
Thread-Topic: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
 cross-compiling envs
Thread-Index: AQHbCotf4uMyP70W+022nGBUmwhal7JfT6uAgAEQhSA=
Date: Fri, 20 Sep 2024 08:58:00 +0000
Message-ID:
 <PAXPR04MB845910C56EA61D3215DA5452886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
 <ZuxTjy7I-pZBcXa0@rhfedora>
In-Reply-To: <ZuxTjy7I-pZBcXa0@rhfedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM0PR04MB7074:EE_
x-ms-office365-filtering-correlation-id: 43ed0c75-f2af-480f-656f-08dcd9525491
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eJMtBmKdllrauwGvtK29RnMN81gQ87F27pOV0c7Q848PsOV8Wpe2KHnQ1i16?=
 =?us-ascii?Q?xLrHeW4h6tNC4HWio+CUVeCdNn72Spd6TjVxRYvN52N01mRmQwU2V4z1rc1H?=
 =?us-ascii?Q?4LHYWcm1cHQUcxRKs67x4G2HirxW7zXSBERN1HI+APLlipE5acGHxomwJsw6?=
 =?us-ascii?Q?71k4NTuMDlL0qsrrsIGjqAkNf07XKdXuK+3hMnUjXUS4vKbJ0544FF1+0IDB?=
 =?us-ascii?Q?h4K82/0ib9nKMnCFRN+fCVwtytjvCvaNVzNUEPzULZrOjs9iGOMDp1ZYSy4B?=
 =?us-ascii?Q?T5bIibar0zdqsLWr8bH2cQ14PUgGMRRp6Frc6umfcMtDysbWXskGQa7A9DBa?=
 =?us-ascii?Q?eU4uPsqJ3VkcpuY5u7OjqX1k4NE4XZxQ149XjVkCiOcg8PQpk3KO7sZoZcY1?=
 =?us-ascii?Q?ltmNQy9+IznvBCvwx3bc4Vl4YkMhhYbSOWFvV38gqkJrKM9K7MwtlYTQwi28?=
 =?us-ascii?Q?1VubPnRItjwAsHGChK47kbY9g0/bTq6RRPP0awx3Ljesg1iaA1B+jPEvJJe7?=
 =?us-ascii?Q?N43jfTVk2W1VgPygPntoMTnh4NIRNZgvhnYs7Ga+uuNtPitw0TVFq6VD1dOO?=
 =?us-ascii?Q?kuz6IxQdvelibn5PF/7RTUe9XMlIQsTxJw6GaADi9F17oMq60DXxV97EaofG?=
 =?us-ascii?Q?moOlzUX3B11SoaJaidjmf7rRnxAOVlqKG5spMbfcg1UIw9DUMkxcLr0H180A?=
 =?us-ascii?Q?hfbRULKU0GNNe0pGnFknfbXLSPGNZ/phzLsZ0wkQZ43uAg94ze6ef5kYi2As?=
 =?us-ascii?Q?ezfQKgImAHJ4MsNsIE6L6cwrs8bFEJgJ0rUH2N+8VDAti8A6oBipiNv52VBT?=
 =?us-ascii?Q?pcsl9mA/qAbNfxsizf4x94k6/2yAQtHPxrzlI6VzrdHph0XQ8E1vi0W8sH0P?=
 =?us-ascii?Q?XxjZrXOA/ufSc8r1jZFbAuza3LFqIFxTJfMvZ2ITwQy1oRTx0VSYm0U4fMM9?=
 =?us-ascii?Q?u7FiNZ5i3uzyLvavatIkt/CwMWknhS7LasLQ4Z309AnnwEzIIhKbwD1QiHLr?=
 =?us-ascii?Q?jepKoI0QTtISrvxcldf6Pn2gyijXy1u6HvQ2uRPpZd1uuktQ6D3BksyzOCeY?=
 =?us-ascii?Q?vD0Azl5DFat6mTAOWbmWLg/2MCVIgpkV3/QVvqp1GGf2BRWfbw2//g5c3vjI?=
 =?us-ascii?Q?VVKwjaNKZkE4dWC9sJ4RzRXuPQf2rUdMWimqrHm1OK4AFbvgPwE7yjQOaaCH?=
 =?us-ascii?Q?3lZf/WOEsiK2crgz0L7V4AkGqMGXexFSLUw9MGwSGZ8gSO4y6ugYWyHQKM/e?=
 =?us-ascii?Q?hprlEZxlH3T+9qDLbELEY1MKLMHRy3bhzapQvCNmJpE1IL/3DoOxtW4DqqWy?=
 =?us-ascii?Q?hPZOMEqDPMyI0pcTuXxtY67SaDYqgnBwM/qQy/ZCFYsm8mLVz6xfmE0BvH/f?=
 =?us-ascii?Q?7cTpiWXBHzQSyvjNRyH+dT4g4Cg2wWzmYm47egOXYMmUWV5BoA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KrqrrhlMc5drT0ijhIi0zwJ3mFWs9Faw2DJOCk17BcOV00IR2Tm4JaQVhSjB?=
 =?us-ascii?Q?sNEYzZPxVX5J77MdR94Vcr6NF0yMAOdT/sajc8Ujy8mzOkEdUNrbdYFlJw+Q?=
 =?us-ascii?Q?YhTFSMA+5Pk89p92JuRKfOhTBzqnbdQKJ1upFfmZcgEG1XgZy8obYgAVRej+?=
 =?us-ascii?Q?TH6y6IH4Cp/u1u9Z5k/Ps5kKd3GyBAx+iynsavr5995kbjnT+jDxMm9Gs6gL?=
 =?us-ascii?Q?G+wm8unK4EO4bRhU3QuuM0bqNvndIzdgIWMLWnP83w+xjDSwLSSxnF/5fr5e?=
 =?us-ascii?Q?a3FYti02ku9KQg21DcvT48Ir0yf+h76Ek2pyY1eKXvS4Z77MQMB7TN/C/I3O?=
 =?us-ascii?Q?vASwskFQ/87T3je/bg8lgahnPPYI5vEb2y7oBCsZOu83HKA1rDfGPjt8WTsH?=
 =?us-ascii?Q?I6ofNaWEqOHN/oxF/44CjGAhZM4dntShpA1u6++EI2NKDRjsofAWw5Fqx1D8?=
 =?us-ascii?Q?7uPv0eK5fQTeFs2WmVOIEEx6b9Xp6uXsZG4mBrrxf8tcaEPyYJp2rUuk7Zw3?=
 =?us-ascii?Q?eBQ2ILGBjKR8zLEoA2CAXIJ+QaueCXq2TOtHmTplitmiVMOH6v9QyTmiLNEj?=
 =?us-ascii?Q?nTCQvpoPvOXCTj3wfpeVKY4YJAMvJzSpq+jzrvTot1ibjhLzC7Ot2Tia13aM?=
 =?us-ascii?Q?/y13MKlG4mn2vf5M2ix4DNWpQ2FJ2fWrFaNWTp+rH/Es8qpsnrLBI69qIO8b?=
 =?us-ascii?Q?DR8bNez4odKixL1iJKFr3EnoU8KI8b60GoVX37q6ZjAVw7kETm+l4WI6Gb0A?=
 =?us-ascii?Q?dNcnV/nUrA3p3DTv+2VbIvybNUbQah5z/LbgpAdMSe9dJ9b4YRXdBpzk71Mg?=
 =?us-ascii?Q?MMyl3h5zJ7OwWQyTLTonF+zN9rX9TeSQJptKjDcKjU3rXPvOJIxaBe3zfCoQ?=
 =?us-ascii?Q?iMOxkpRovbu/pMs6zMtAt1pwvnSpYnaU6WcjSWpt1KZK6GN3gnj+Puq8rCJc?=
 =?us-ascii?Q?bwNwuni12l+JLRetQwg4MTZTbqr/679cXNCumXyjEAbC3JjqkLJR32Gdzy4b?=
 =?us-ascii?Q?0Mhse18gqfQSMEt+hdJ/48+6VL1CBYiFmacWEWeQXjzcTJ7G8Msxu+9qqdar?=
 =?us-ascii?Q?KG1/AfXzzyZNJ+SHi49HF2s5hJBReuzrPGt2ON3xh6SiPAPPoTiv37++9qN8?=
 =?us-ascii?Q?kINeQ3SucoUXmEhuYpvOH9jAnzf97s/4tpn0MWvQbS2o5mlc4uomMvzGav3i?=
 =?us-ascii?Q?K5aRczJV14Yr1ZsHWH2jWu1kpjujLmptXWNoL3QGxZ9n4nvr9dC0KrfffGDJ?=
 =?us-ascii?Q?FcjmUH79EQD6QQ6BrG6yVS5PqJsjWrqG/D2Y0lmdMAFj8SMa4GklK+lInX0B?=
 =?us-ascii?Q?H4xdr2ndYiyQhpPM1LcKQEcrzjjCHM0BZ2SuaI9zUmDzNnyTd58Y8qvlobmR?=
 =?us-ascii?Q?j7kjdeRPS+9jam26TFgFl7dwVlbnb++MpO3zdlmCuT6jmVBFKkjow8IOpX0t?=
 =?us-ascii?Q?67PYlLul/Y41SRjcXXtaUmzBO7TEuUpcw3q018R5OPv0tVHe+DNGuAoGgyqQ?=
 =?us-ascii?Q?dAoKULIHMvnovuB/1YRhusknOIajjE5OFiKzzuNiQVsmBWwkEq0YzJBRY6i/?=
 =?us-ascii?Q?9SiW+VAZrFtgP2BgLDM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ed0c75-f2af-480f-656f-08dcd9525491
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 08:58:00.8600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gA9G7j9jz1XJyJSfJ0ngnONmO7cvAulcWWtQa5iRpPKl8BdvW7KjjNghPMqvumbwNJ2pBoH61X5qdhzX94PTHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7074

Hi John,

> Subject: Re: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
> cross-compiling envs
>=20
> Hi Peng,
>=20
> A few comments:
>=20
> > V2:
> >  subject update, commit log update in patch 1, 2  Use strerror in
> > patch 1  without patch 2, need update Makefile with 'CROSS =3D  [cross
> > toolchain path]/aarch64-poky-linux-'
>=20
> Version information is applied per commit patch. Not in the cover
> letter.
>=20
> Example:
>=20
> https://lore.kernel.org/linux-pm/20240905021916.15938-2-jwyatt@redhat.com=
/
> Reference:
>=20
>=20
> You will need to submit a V3 version of this.
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#th=
e-canonical-patch-format

Sure, I will follow in v3.

> >  without patch 2, need update Makefile with 'CROSS =3D  [cross
> toolchain
> > path]/aarch64-poky-linux-'
>=20
> I am not sure what this is saying exactly. Please clarify.
>=20

Shuah asked to put that in changelog,

https://lore.kernel.org/all/0f8df90f-007a-483e-83ce-df8ff0e99791@linuxfound=
ation.org/

I could put in patch 1/2 change log in V3.

> > Subject: Re: [PATCH v2 0/2] tools: power: cpupower: Allow
> overriding
>=20
> Not sure you need 'tools: power: cpupower:' in the cover letter.

Will use "tools: power:" in v3.
>=20
> > pm: cpupower: bench: print config file path when open
> > cpufreq-bench.conf fails
>=20
> I do not think you need bench either.

Will drop "bench" in v3.


Thanks,
Peng.

>=20
> --
> Sincerely,
> John Wyatt
> Software Engineer, Core Kernel
> Red Hat


