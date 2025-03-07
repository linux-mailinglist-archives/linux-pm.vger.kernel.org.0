Return-Path: <linux-pm+bounces-23619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A327A5652E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 11:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30F017761A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F7320DD7E;
	Fri,  7 Mar 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bgep5j5s"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2045.outbound.protection.outlook.com [40.107.247.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF716DED0;
	Fri,  7 Mar 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343200; cv=fail; b=Hq0QeuRToo0P+nvGh3v4BHOUItddOR9IT/xfYCZs/sju465+GxZJ4Er+lX/aQI1MiyKN58S0XWG758MFKCLtAjhnWIhV0sT9Iubl/inXFgh2zSovwh6ITDBR1cC08ytPKY4sQbAiFCAWtCzV7TgYJZou4cMdS0oyHbLlW6mydLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343200; c=relaxed/simple;
	bh=Lt7gkMd9P9O8/HRVOlpxhwc9WsMH2Bg3k0cTMGuCSCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IU7Miy24T1QKP7BF3N6+ZejqNRNSkdvBmqL2dpDk5mL4z6zrdpfaR2mAuSiVSD3Yby3tAoNiEjWZrA0ogaeqmGCfDL9nYnGJrknO2OiUb7J2t2nrTvYuOD9Ib2KEpt99fMjdfgMTpigXI23fGleyDbvrMY/z3FHdwyXLSrAj97w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bgep5j5s; arc=fail smtp.client-ip=40.107.247.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UC4IZZvc/c3YhL+In4cLbt/ht3jG1hQfu+qT3PMsX8qq1PYEmvvlVAPZGANT569QQhhbk6RRLtUpuGRMOuzXqX3n5YrEpwMfaQnQsuoUMdlWDwyNz+4D3Ydy1Qodxqb9SeHfpc/BBgwEIbiC8zyaZ4LhYqoQdWY0xBO3WsO+X//fkJ6tjsTZuwkmxFzAEWqRE8r24KE0yntulNOm4TWtt/gRdpxp09zQlHc2u6HLqrF8hqzLop7pQOzwI+BKoFUbbvR6Oq4GbMeOAOZnyVe9yDaP7EjNQtb6vcoEWccaiI3CRD6tk8flfN3VbpSUgt9cfhoRHjmFRyc+hQ4Uba+5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATbghwDu4RjAA6qnLJOCsx05w8vGlGH5K0cFwE7LYpQ=;
 b=wt7lzsk0gvb5r1XU6K/FR5fAx7fO0C8fpB+fKrGKe1GMMplVXC+oLEP3vFHjMYJrAbbCq+vxPWHfAvdEhmqaBvOCcqK44ec0dh+LPg38JgSNec5yGMHBWQVYFQq79w2HAejw/vkDw4CZTE92HCCSWe73MVCwLbfnGKi86dy2W4ZtClPsKFuoHZsa9R1NxYdnDn7u6MFppVwVX77ymyqb7zihlu595gZa4Kd7cJhIm41RiH3H+lVp2Y9iq48KhiApE1tDlB5NLs51nvYNozWb501zJQDV33aV3BqN23118MPSwOQCHR5kiexV+MmClJoS+NV6aIT8esPJMfD1SV7anw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATbghwDu4RjAA6qnLJOCsx05w8vGlGH5K0cFwE7LYpQ=;
 b=bgep5j5sVBX3Pd3odGWQeWLPUTN6ZoMcVs7xM9pecbr30bU/thkl1SWdVMc5SCgiiHEGcsPMYC+ZymFm6lWVpIbksdgRXenlrFTj9/zrNL+sM014AuV4SRQ6EIFEwN3sCv31c40apfjtMSX0agtGfFlPXY+y+A4pE4vxj1jHMLGMEDwWi18doNeBnUrr0XtXODxeu+BcWeun+idxYdqi3vUMy8oWFSGiNv+iSqaWY99l8LkX6PsdX3mKlkHyTL7k2Sii+T0E+VGt6qTMdrGyL0m4VB6QWJmJuPJNEvsZ97qYSmU7zC4a2QqlVcyNdMIDRkDqcucJbzX8ffhPDGcoEw==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by GV1PR04MB9214.eurprd04.prod.outlook.com (2603:10a6:150:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 10:26:33 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%7]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 10:26:33 +0000
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
Thread-Index:
 AQHbjzc48QAeOzv5L02tuSUugwb8UbNnbkUAgAAAI3CAAAOqAIAAACvAgAAEB4CAAAE4UA==
Date: Fri, 7 Mar 2025 10:26:33 +0000
Message-ID:
 <AS8PR04MB8642352392C6C54A1E60E5F387D52@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20250307080303.2660506-1-ping.bai@nxp.com>
 <Z8rBYuDiIyo8y6HT@bogus>
 <AS8PR04MB86425B7CEE7443F822A2DBCA87D52@AS8PR04MB8642.eurprd04.prod.outlook.com>
 <Z8rEkgYoThJAJdPV@bogus>
 <AS8PR04MB86425524495B3FEF19F32E6B87D52@AS8PR04MB8642.eurprd04.prod.outlook.com>
 <Z8rIF3fQr958cf8g@bogus>
In-Reply-To: <Z8rIF3fQr958cf8g@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|GV1PR04MB9214:EE_
x-ms-office365-filtering-correlation-id: bd013e2c-b612-4f0f-6109-08dd5d628874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y0T0fadZq6gDW6YPNPNlv5oiugwsQ7wC8haMBptfMV9QGSvI4HZAwd5zM0w0?=
 =?us-ascii?Q?4aQvnp6+7yWevbUSKzl7YiJ58OildJWTRVB/Z+x0pnkvJh0rWY90ubAyQBBx?=
 =?us-ascii?Q?No69xCrgD6dMOeHnQnapuAkclz1jLjW3kNwjdq9687Gu9XosuPc8FFzlcTtF?=
 =?us-ascii?Q?Fpe1f0LsQaNaPeVTD9mYZd1shfWofA9FSxKbeZk63KWKAsb9IjmFx/gDhS3B?=
 =?us-ascii?Q?5w0OJUYjjWqNIioGn+CaspVX5pBsy3q/vFhts7QtG7lc1KDSmbbXqJ/WpqUt?=
 =?us-ascii?Q?GcsIJaorAYRD5TSx/8sYhSGZ4GEUhPakhMDsZPyWfeZofsAvceyz5pRqrZSe?=
 =?us-ascii?Q?eOTRnLaXm28C5DRYvU/+jD+OZBlfqZvsbAt1DrvaMJmai+jp9r+bC43trPvw?=
 =?us-ascii?Q?1GB2at9LVZj+v/qljqXdo/VLDpczbgpqNjnLjTk13X/iWwJ0lX0QN6Tv1pEs?=
 =?us-ascii?Q?+cfIeyQzpnelopVxPEUgQiw1rT7kb2G0PW/KHGZzAUwfcQGnmyn3svwwsEAK?=
 =?us-ascii?Q?bZvcGMAh3pn+CLHDS6xszMRmHXG9NYwMepvksHFDW3A1Whi2JaVIcTOLJUmG?=
 =?us-ascii?Q?S0bft+VPp/aOg+AIugNzYFCLltpRKRvQPtfpcR/Gv3nxZReV5VGkPPJ/y+dQ?=
 =?us-ascii?Q?WzVuqLf1qnPJc3kp/EjBs9GSgphMyFuagbnWnPHbSg6uYV9U0QCc0zJSb2Ps?=
 =?us-ascii?Q?wJsX1raBWQsSxZ/WZVyPZaZ2pqO4F2OjGO0rCUqkaN/nzLqP4tWyzVW3zr+f?=
 =?us-ascii?Q?o9l0j8TzUwB0B6Z3+N07oVEP4qoUcYCEUgBk9OZxcJ/qv2K1SqsBxHtPolj3?=
 =?us-ascii?Q?LUfBBsHydXVXxyQ7oMTZLDT13z+juUl1+aW0zFNuqhryaw1zcTacxwijgXNH?=
 =?us-ascii?Q?PiaPUHpgIJNXd1tVUwjSpp/XDNNf21G1odZkw0wphzzkAkde9utEvwpWsV8G?=
 =?us-ascii?Q?WYtbkHZTRx4kqQw7PbClvCGUbx+u9SvnNPQvLMxOuzhrtluAocD5jEQvcBjF?=
 =?us-ascii?Q?KhciwC7A8O/d90rLqdKxG1MjVfdY3zKmLtwOTClZdyHrqheRInpxTT8Sidux?=
 =?us-ascii?Q?qtsiqpIhsDswJTW1Z/gKBJCmKqnpphtAqBIVeqfyzr0cGoD/gTR38CIk2myC?=
 =?us-ascii?Q?rALtJ625bfz7fejQf/fC9h7o0N0IHprKg7AQr4r9z7+uOH0IKZ9akoqTavul?=
 =?us-ascii?Q?vST5obFq+m8FnbbsAo7QRwKX7dvRozoEJIeVvxw1AKy0aS5S2UoLoH2fCv2l?=
 =?us-ascii?Q?oMAFrzCoESeijzpEQQM6wiOf44T2NGVAa2qdTznE5fczPSvilLCkqu4/kkDX?=
 =?us-ascii?Q?SINSckpLplXi7N9OZmD9ZaoNlDGbNxjPEDlZAu7pEVxdhp9M/d05Gw6F8LTN?=
 =?us-ascii?Q?i6qBo1WJQSHZrWF/RKqSpTwc09YtUVojRyFKKHuLUZWF4oDmTi5tfP8dxSEA?=
 =?us-ascii?Q?OP3/KRFghEMmMWVBJwGvXSAKPsMGgUAe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1jbuBu9T9r2MqExnY8Cu9m6KS7C5mqEs0Qc5Ub/rBDuT0edviwU2H5uX0ZwI?=
 =?us-ascii?Q?8SeCis+rEB6Ob54MgvrWQKAb0dDoaQDTWENntLgrdN+yh/uThE9oxq7VxTS2?=
 =?us-ascii?Q?YQvDyuP8nt3HLcBSZWEc5hKS/27vDEUuCxQ0u1fxrP2YbMqRgId6x44nJVmI?=
 =?us-ascii?Q?M4rFvrqZmlnt2S8iEpeuVO97KlzSc5rzbzKVLAfIcScdqygNFVgD1FTe+iN7?=
 =?us-ascii?Q?sSY6VgutwM+XCQs3CnKlg2JQ2Sw51Gs7wD5ekn8ixjb/uZrkiCb12khSE529?=
 =?us-ascii?Q?Sb6DrxtDsUjwszoYi+K/dqAKrLqIPf9cH8fMHHGUQQDdYF4MYvXS3fylb5zT?=
 =?us-ascii?Q?lBuZYcWMhVQ0tnvPbcf0Ze9T2osmX5BQFEtmcLWPSEqj8zLmCTsvmV81z+np?=
 =?us-ascii?Q?94Vzt7a/80i7Lj357zaNkGFNE8DBlB0vEcdMUIRNAoedM02yP9dI3o10/iAH?=
 =?us-ascii?Q?uQK4dmmOFn7o05XQTycEOiIGfigul0Q30aoQKRlVS9lTvarNCFpK6wtIiLMt?=
 =?us-ascii?Q?qBiW78VI+tkTmMLVnI+sNzHGuCPjiPKMStopIzB7sAfVSDnqjH4OA4sqeBwx?=
 =?us-ascii?Q?8CzvLAEmffrYQlSKVCuosUtWzfun2jmGiPK0fCCoHRZ4cp/nZksCIHBY0Pcc?=
 =?us-ascii?Q?Ygc/9BwSDLB/ceFTGMmcrhUCZRRxPn4nNrzjIO1EDLdB0jP4C24Cytg/OdL6?=
 =?us-ascii?Q?m+eWURD8Hi98+VtMMOHtuhs+OjJ5AQCtBb8sRLlJ7vLj5xaR6qHO/UNxxwZR?=
 =?us-ascii?Q?SGGn5U3aqoemvohd5IS+uizeT6uElGr9Z0zkRnHnbNrbTgatXoxbh6cxeiB8?=
 =?us-ascii?Q?6LOt9uoBa8fW75yg8iMMD8Jx0RlD0pKSwtpkq9N/d6xV+FgIndUw9DZHxtBX?=
 =?us-ascii?Q?ZkCMpQuHhtqlLcihozKVOWcYDDvpJaaRkhbtlfcK3UgGWlBBEnY1DYRyrMyX?=
 =?us-ascii?Q?06tdcaqGP8GQSjnQ+G628X1g9+J5jmY4vN1lJUmg63ye0JcgQEe4bQ6cX4pE?=
 =?us-ascii?Q?JyjHtTm9E0s7keupJ5dcIABVgSvVUtIyyBkbsVl3Y2oNibl4QtlY97PdbQSt?=
 =?us-ascii?Q?PYTaBPlp9XgCyBO0HzTBnj/14MWRNGQW1TbSduCn3LWdbMu5/34+O/nwIH7K?=
 =?us-ascii?Q?MWBT+63dIgzKE+0td9gZvq/LUv6HFSfUGmHl0tyzKYnujBTtOSeHpAE7dL3T?=
 =?us-ascii?Q?jlWOo54803d3RZHBRzK0lr0puL2i/8tpBdxNnNiQAzWN72QC/WpRPXkEo7q4?=
 =?us-ascii?Q?RqVJSyNurzSZo2klxlbOC7KiBPiSAvMSWFbUF5UFC6JiipY0qoxKrYO/+UmN?=
 =?us-ascii?Q?ereMGt7dPL8dDSBpaj2g3ZRfzVZ9y+gx/z6vZOdQIGf38/oAz8BiKTYOtNGv?=
 =?us-ascii?Q?BnywK2YSBduve9M5pej/+mY1BxdPXW9MEu0uDXNDHsI/zMISpsfHNsCoI6GK?=
 =?us-ascii?Q?SsrtUIBL+PfnKfpVeoe0uAD3RMIdDbib3tTdHy7T+S95cd979P9GN/+e/Zo3?=
 =?us-ascii?Q?JZCHXlyTxXmb80MKm+p5PRF681sfZlYCOQ2Zedi+Py9bv7qGi7VQC7JMbO6t?=
 =?us-ascii?Q?Jov1RFxoLpfTv9qjgDU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd013e2c-b612-4f0f-6109-08dd5d628874
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 10:26:33.3806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRkWMz38iIYZLinsDs3NKt5LiVFtvP3k30griLxTMWiGk0IOSU5YkmNVjPjB0V3X4MEEX+vw9f5UiEeJKi7W+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9214

> Subject: Re: [PATCH v4] cpuidle: Init cpuidle only for present CPUs
>=20
> On Fri, Mar 07, 2025 at 10:10:50AM +0000, Jacky Bai wrote:
> > > Subject: Re: [PATCH v4] cpuidle: Init cpuidle only for present CPUs
> > >
> > > On Fri, Mar 07, 2025 at 10:02:14AM +0000, Jacky Bai wrote:
> > > > Hi Sudeep,
> > > >
> > > > > Subject: Re: [PATCH v4] cpuidle: Init cpuidle only for present
> > > > > CPUs
> > > > >
> > > > > On Fri, Mar 07, 2025 at 04:03:03PM +0800, Jacky Bai wrote:
> > > > > > for_each_possible_cpu() is currently used to initialize
> > > > > > cpuidle in below cpuidle drivers:
> > > > > >   drivers/cpuidle/cpuidle-arm.c
> > > > > >   drivers/cpuidle/cpuidle-big_little.c
> > > > > >   drivers/cpuidle/cpuidle-psci.c
> > > > > >   drivers/cpuidle/cpuidle-riscv-sbi.c
> > > > > >
> > > > > > However, in cpu_dev_register_generic(), for_each_present_cpu()
> > > > > > is used to register CPU devices which means the CPU devices
> > > > > > are only registered for present CPUs and not all possible CPUs.
> > > > > >
> > > > > > With nosmp or maxcpus=3D0, only the boot CPU is present, lead t=
o
> > > > > > the
> > > > > > failure:
> > > > > >
> > > > > >   |  Failed to register cpuidle device for cpu1
> > > > > >
> > > > > > Then rollback to cancel all CPUs' cpuidle registration.
> > > > > >
> > > > > > Change for_each_possible_cpu() to for_each_present_cpu() in
> > > > > > the above cpuidle drivers to ensure it only registers cpuidle
> > > > > > devices for CPUs that are actually present.
> > > > > >
> > > > > > Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in
> > > > > > GENERIC_CPU_DEVICES")
> > > > > > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> > > > > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > > > Tested-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> > > > > > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > > > > > ---
> > > > > >  - v4 changes:
> > > > > >   - add changes for other cpuidle driver that has the similar i=
ssue
> > > > > >     as cpuidle-pcsi driver.
> > > > > >
> > > > > >  - v3 changes:
> > > > > >   - improve the changelog as suggested by Sudeep
> > > > > > ---
> > > > > >  drivers/cpuidle/cpuidle-arm.c        | 8 ++++----
> > > > > >  drivers/cpuidle/cpuidle-big_little.c | 2 +-
> > > > > >  drivers/cpuidle/cpuidle-psci.c       | 4 ++--
> > > > > >  drivers/cpuidle/cpuidle-riscv-sbi.c  | 4 ++--
> > > > >
> > > > >
> > > > > Why have you spared drivers/cpuidle/cpuidle-qcom-spm.c ? IIUC
> > > > > the issue exists there as well.
> > > > >
> > > >
> > > > For qcom-spm driver, it has below code logic to handle no cpu
> > > > device case, and no rollback to cancel the whole cpuidle
> > > > registration. So I just leave
> > > it as it is.
> > > > Do we need to update it?
> > > >
> > > > for_each_possible_cpu(cpu) {
> > > >         ret =3D spm_cpuidle_register(&pdev->dev, cpu);
> > >
> > > Did you look into this function ?
> >
> > Yes, at the very beginning of this function it will check if the cpu
> > device is available, if not, directly return -ENODEV, something I
> misunderstood?
> >
>=20
> So why do you think spm_cpuidle_register() does anything different than
> psci_idle_init_cpu(). They do exactly same check and yet you apply the
> change for psci_idle_init_cpu() but not for spm_cpuidle_register().
> What am I missing ?
>=20

Thank you, I got your point now. let me update it in next version. :)

BR

> --
> Regards,
> Sudeep

