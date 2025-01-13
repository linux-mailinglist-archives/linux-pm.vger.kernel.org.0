Return-Path: <linux-pm+bounces-20340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D170AA0BBFF
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 16:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF068162672
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BC61C5D56;
	Mon, 13 Jan 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vfl9Ej5k"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17A029D19;
	Mon, 13 Jan 2025 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782263; cv=fail; b=ENKKoER6ZOyPrjuXK6h8azD2Ai/sfYLw4JTg9gC+9D7bhdpJVJSyRsqM2Gv3vhI/n7l8QWVFs806KdXe4k7oDsoiK5ng7kJEPJI1IcuF1BcI0Z6dbHcq0qvuIDLxoDJKS0+Z+SBI4JoNRVo11t15t7Rya6TV//QeRpvs7kPPHFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782263; c=relaxed/simple;
	bh=wTgDJ2uyI4CswR/FcSzA10UoTYXD0Mg7DS2eaJhDrKQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=poTMtKL71pxiczjc0LJ+ZueHu5DpC731PxUnAiFYBkngA+wTMh7fXxtIRCziKlliCf1bBG69ucumVQkQhTrNKISWzwP7txKWEF0A9iI58BbBQLYaBig5+eX/R2pDF5CjjLLaIJkEN7iN4PNvcJv2Yg5U19bHuizbDVGaP5kHAYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vfl9Ej5k; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+Ab7Hvx9eGgieZfxX4WGRraTwgeR4o1dCAp7M7OfdmCPBLo2lKr36HZVWJ/9ZLYqSzO/oYZdSJcY4KG0EkNRxAdELYEszOfHlPmnM5Eg/WfvirSh11kYSXoQKlu5gHaSBBUNPHQzYzCkMNjlTujITxZlyzUPvC2Sa8WbaHD7PWZ9hs3xoABx4LsLjz93UutIZkb+wweFAdW42NL31sZ1+Y4W98kldaM3FxMK9F+tX8C8/0CU1ORQAAdoF3/B8mJwzaJkRJhmQoW1bKvsf/r7ybqsNdkj9owQxLjRiSVUqKMWydsF9AsgSvTVs5F08LvcowiVTBwS7/zlP+v0LCi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AraFPssHRmWvVhiNmoeSAg0qmkHvmywAnYEUmNpMdw=;
 b=ielnU+iMSQgJ3JogWybcb7sNwzDaw4uneT+G+cVpUh5I3NXog+cs87qruORTNC+znr9jwkrva3g6W7ic93RRA3Q1VDcfsyZ77Bduf53utw8SIAE5y8z3rvb9H2/8LPjBwfRPNtyhoP6GmFpSMySjteXisltspsssKY2Y/AxvLE1/7DDG53/AGr3HZv36czj0XxmPGDe0IfIhwDpl68krulMU4uacDvpLZcJUUWs2+iMZ5rL609DbKxNXRFLnvhGcz2NPf/O9uSKmJzz4CFFF73Vp3wLkkA9CYoK1GLxlLvPJC2w2IxdvQo5JtwL/jSQ55FcpsO3vuXMEAoL6xSdfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AraFPssHRmWvVhiNmoeSAg0qmkHvmywAnYEUmNpMdw=;
 b=Vfl9Ej5kisg9clWbWXadG/mRCqlVi0n4nIEhcSAGO3zHYLOaTn2OfpuGmwWTqOvm10SOGL5dAEK9MSOEqKNnvtt8NWtS8Z4CgVjhowhSsS8CMRyYmIIAdnj0O/NPs+Vfu9/08fiotSyKYQfBgDxlYqQUBOClMDlw6eVy0b+KpZZg6pXd2t2fMHTpeHhoYJ1efnqKgu4KiHb5c+Y50H9XxicBQrJPnQsTqpq6iHzboRTsSQSf9p8d1//1haDIaQ/isq6Bq/xG6/GvGMCuy+hYYnDmSze4zaII2+Vf5+JtG9MHsZ2sREmQMCXtXznzj77McUOBl6smiSYB44YnSSF0Fg==
Received: from PA4PR04MB9485.eurprd04.prod.outlook.com (2603:10a6:102:27d::18)
 by AM9PR04MB7620.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:30:58 +0000
Received: from PA4PR04MB9485.eurprd04.prod.outlook.com
 ([fe80::81e8:f7bb:dbd0:b0dd]) by PA4PR04MB9485.eurprd04.prod.outlook.com
 ([fe80::81e8:f7bb:dbd0:b0dd%5]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 15:30:58 +0000
From: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state
 as off
Thread-Topic: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize
 state as off
Thread-Index: AQHbZa+EYgINd2mhkUSyLwfM7XAfOLMUuHsAgAAaEzA=
Date: Mon, 13 Jan 2025 15:30:58 +0000
Message-ID:
 <PA4PR04MB94855052830C8F4874237BA6921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
References: <20250110061346.2440772-1-peng.fan@oss.nxp.com>
 <Z4TreQ5bA9qiMTgC@bogus>
 <PAXPR04MB8459F33BCC84CCA8F49F3B60881F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Z4UZ2Au7KSFMibDW@bogus>
In-Reply-To: <Z4UZ2Au7KSFMibDW@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9485:EE_|AM9PR04MB7620:EE_
x-ms-office365-filtering-correlation-id: c0d3404d-2a68-4d92-e032-08dd33e74751
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vuS4GCcJJOvrd887NVeGmu7P7tkmNlvaG449JRJM8HMcsIgjgh6g6sAydIAK?=
 =?us-ascii?Q?2HB96VSJsl0ED9WeuVc+Huj800O5SHUQKaXpV+b055uoUb30uvkXGX1R9HIz?=
 =?us-ascii?Q?Ip1KTu2N6zjMLfifdBdboxi/0ZNqJ6dsMh+E0kmzFbgXuYph4qxezb7htd8H?=
 =?us-ascii?Q?B1umeqm729JUp7ibJPM06mpGhrh2npJaHRHhD9EZ0anTWvkEixO7y7Ef/LCw?=
 =?us-ascii?Q?wkhC45UMiHNrDAVzbNrwphcGP8VRyjfsGLH0GjiG9BOedlOOyl7Yw7uuXQZR?=
 =?us-ascii?Q?L8v1TL1X8K2fSnVJ8r+wYEdmxnVT6kCLgKGLwmBdWTptleNetT4iNaNMH/n+?=
 =?us-ascii?Q?wwf1c1bYiKwPam1ELJKy7h0f6uacSFj7hqH+9jL/jAle8Gm2cCisrjUQeVPw?=
 =?us-ascii?Q?q34iyM1WL2JJPBu3rbUzEpJ6h59B9cA51sFcqrE2ZrC+Z45SpIgh0ooEKEkO?=
 =?us-ascii?Q?gx8i5mXtgB0E3nfmYHrzRN48qi/mg1AlwGGYxiJqqz4NvjKO9O//XCoZPyqV?=
 =?us-ascii?Q?qIq+b50H9MNZjz2+iI/y8XCP9b92Vw3iUD8rfZKe1a3pZb0y/nWjOcqpdfxA?=
 =?us-ascii?Q?eP5FJPhvt0r3uXWkQ66S3+pHA9UL7L6jJPDaF2yNvGKo0peS3WzgvFT1rZb0?=
 =?us-ascii?Q?tCqhkfUivtuHisuslAVGAYpTiXMYIuQQJllSy8rCyVlPjxSn0iV3FnjcA1hu?=
 =?us-ascii?Q?pOpgEWCHHervC6eJPrlWxvf3BfEeD+Ozr81hfgDjxumARD6KWKpCDNC4p8A3?=
 =?us-ascii?Q?3HQ09oUoCXqO7onnCwkIoquKhJNyzTsmpDf5J9YXZqfwGq6JRUtnA0wWEykz?=
 =?us-ascii?Q?GyCGL7R+s++G8TvlSfXnmeg1JWYXY3NGvTKhRNlXp8pL/w4Wg6CYJbvVjaX9?=
 =?us-ascii?Q?Rvm6K0JNLubQhkKfxq4pSMynuabG5IvkACy2Kqqd8KNqTxgD5yXbIrEaO/8t?=
 =?us-ascii?Q?t+xIc6eQERzkL2n3RvB+tcP1g6tnrgYfFv8bGURpmK9yUQeqS8zE1ljY4ZMC?=
 =?us-ascii?Q?4mJJeGbw533KKl2dzpcAlG3gQVhLOCeZGRHaStWicGsHoFnCNlD3dpHEDvUG?=
 =?us-ascii?Q?sfJYXT15hXi7KJUhvBgA5Fi/rDlXeiTs6R8iwDr0S2bJ/RQ0f77W/ToYi2t8?=
 =?us-ascii?Q?idVSKZEkFYDqpmq/WvgZgxwAUqlQk05ufXqkwxNZ5kqVdiykFaQX45hfvSOr?=
 =?us-ascii?Q?jfTZEZ5cetDgtJAn27gRxrxF8CgvvEtW9JpgrGHBjaaPMeyFZas1JLznFW3O?=
 =?us-ascii?Q?1YCIQF1l+Jz0VYVb2dvEqGF/5bjBTwwUVtyTbtKT5BUcDAlwqMxcVEaYLmTO?=
 =?us-ascii?Q?zKeiUy+fZGRoIhnd7i/tmIrysfx0M/+Z6OPJNckMP3AqPVVWqIYGRBQ/gJ1o?=
 =?us-ascii?Q?lpcv8MJvMhzBOo3JeaNNDEJIHeQroLIgdNr2NLgzykux+krgHhx18/nOGawD?=
 =?us-ascii?Q?/muHODJ1e/hMcOdtWuiG4AriRZfrP8Ms?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9485.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uzaZUat7Y96jG0L7ylBQShTX7PflUTbpo4sZJ3wLREkS14mCqDy5btW3H+l2?=
 =?us-ascii?Q?bGM0p9MHpzxwSI+1CJgx13bd3odd7K/PZlRh3fczfce0jrnQik1qvPjcVRB3?=
 =?us-ascii?Q?yW8RW7K/JhuC2IGaDoLCSVn3Pqbp2jmX2mI1JKIgTgjctVXruumqJkFMSi5N?=
 =?us-ascii?Q?ukXGMG0ga1+AMZd/Mwf5/M/yWPo7AwjGeAKiNoGPRxmJ80FDEfThh4jTsP/z?=
 =?us-ascii?Q?eFRbCbc1geA33VEaiQMz7S+PFMk2LjAF8FRNBaVQ7aG1mel9oWYkM+bQnQyh?=
 =?us-ascii?Q?PrU8kh+4CEZuOhgVvjKYNwzEqyx+Z9GceY3FyaSYRgyifjkfomByeYTsCB0V?=
 =?us-ascii?Q?WFIwxBTyhLell3iYZ5cLMIkvWs1MD4DFQ4pcsGfI+/OeRO8yddIcC9qfO6k1?=
 =?us-ascii?Q?UkivdKyqiiKnppKGDbwMhQd5E3X54Y/HLqOuyTojyu4tO1oA5p249/0j1UIY?=
 =?us-ascii?Q?OWwb7I/DqM0P1rOCHUD2U5om5Q9OoHDH5Wg8J85qYf5Wt/NuKfa+rC0R1BwN?=
 =?us-ascii?Q?M51wYo4Vd+FbmCG405vtdqGmJe2F3jRAfkXFyC5T/QexlCFJN/GlAHaikZEa?=
 =?us-ascii?Q?sBWeDt8F8KT91RfgDPSEpsZ4O8rAv4LKi3+zOLKSOSFENhResroNFztY0UO6?=
 =?us-ascii?Q?G4auvEwAyrWbZ4rnefyTDNGML8VZn+IpPtb7W1H7WHvazmzPKsKqwNdCA86V?=
 =?us-ascii?Q?LR+FPrf9/rG/lTpIsrQDIH28EvqpRG0DpKGyAYoLL5BxxL0YuQd+Or5ZsXkU?=
 =?us-ascii?Q?T+jwEOMuZSGGbL9JAHERKYAtiLymWc/8yNBUZMw8k3Zfj97KkzprLelhirS8?=
 =?us-ascii?Q?TpORHOEVyFR3iO/HBg3LLWuH18HRs52g9u/YlfovZiskYpiMo/A6R43ruXmZ?=
 =?us-ascii?Q?wlV7BMd1tQoEQBVH4VO84l6uJH8qwNhBNG2AhiRB+dgiN2Cc0Gi6Fd0x6IXC?=
 =?us-ascii?Q?CAjJV7TttK0Aarq+G4z+LjSYWErmsLqt2i2WyHKRNaQgfzIApGo79fvaEjnK?=
 =?us-ascii?Q?LQ3ud4YMKHxie8FhWcgs1SRjr+B1bfqsNdGoq1fVYuvgaiaIPT4i6ym2xisM?=
 =?us-ascii?Q?92Dbv28TStJ14vze8ykOXq90XVK8ZoOmIbgb1ZSWBYtdu1cIvh7c3cSpQbw2?=
 =?us-ascii?Q?rzIPEB3fo8IQMINHzVdgygFxf8k438TcRG9vlNdre/78k5+Zz8/L4fJqmTFp?=
 =?us-ascii?Q?sW2Ft4acouNhk5NF05e32AkhgkELog8NJN6qXZtHCyyb2E0FDZ8oY/JWRqVS?=
 =?us-ascii?Q?cocjm5Zv76OvhtrxSs8MI0bJYTZOE+Mk5GiZEhtj7Fzuz4A0lxVOB8+GNlVy?=
 =?us-ascii?Q?z1tqOujmJEKqEHXVz8vWwMSXUjEeyBbjBRb0G5H3nwq+vykclZGaWIzKN9Ky?=
 =?us-ascii?Q?HhaOzhH9YY5YxQLLX1VuFPnHXP0wzhRZUzxf33tiXK/Jy3OqEB7yjlP7ciTz?=
 =?us-ascii?Q?VqJ/qPGIjrKankoj1rOB42yaKRuHUfSOO+YAWliFcS1mrFJJrM3ID8cYGjEp?=
 =?us-ascii?Q?pIkv0ft6eSI5jW602TZbf+xnXaDn7ZDjO126Ryq5kB9MSkA89B7L7Lm0rMP2?=
 =?us-ascii?Q?u0R0GyNpsZrnZgVK7kqB8y/BhajqcQ2fwfO+2t3TqkQffaCWtHGuKVjmoYWo?=
 =?us-ascii?Q?pw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9485.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d3404d-2a68-4d92-e032-08dd33e74751
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 15:30:58.3076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mao0/vLxsfzYuykv0V/yzhKTmyiodjKOWglvfqU2BYTBgnQQ1Eq3bpx06Nrn5ioxgC/UKfnS7ymSFHhR/LMUxdlAu6v8ZFVCgaevObIdeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7620

Comments inline.

Regards,
Ranjani Vaidyanathan

-----Original Message-----
From: Sudeep Holla [mailto:sudeep.holla@arm.com]=20
Sent: Monday, January 13, 2025 7:49 AM
To: Peng Fan <peng.fan@nxp.com>
Cc: Peng Fan (OSS) <peng.fan@oss.nxp.com>; cristian.marussi@arm.com; Sudeep=
 Holla <sudeep.holla@arm.com>; ulf.hansson@linaro.org; arm-scmi@vger.kernel=
.org; linux-arm-kernel@lists.infradead.org; linux-pm@vger.kernel.org; linux=
-kernel@vger.kernel.org; Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com=
>
Subject: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state =
as off

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


On Mon, Jan 13, 2025 at 11:37:23AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state=20
> > as off
> >
> > On Fri, Jan 10, 2025 at 02:13:46PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Per ARM SCMI Spec DEN0056E, page 16, "The platform may disable a=20
> > > resource if no agent has requested to use that resource."
> > >
> >
> > True, but ...
> >
> > > Linux Kernel should not rely on a state that it has not requested,=20
> > > so make state as off during initialization.
> > >
> >
> > IIUC, this was done to avoid any transitions if the bootloader like=20
> > U- Boot has turned on the resource and OS can just rely on that stay.
>
> But if it is not U-Boot turned it on?

Not sure if I understand what exactly you mean by that.
[RV] Its possible that some other agent (M33/M7 running OS) in the system t=
urned on the power domain. Resources in the same power domain can shared ac=
ross agents.  That being said, uboot provides mechanism to clean up any pow=
er domains/clocks that it enabled. And our implementation of uboot does dis=
able any power domain it powered up for downloading of images or anything e=
lse (display is a unique case if splash screen is enabled).

> Or U-Boot is in a separate agent?
>

No, it will be same as OS for the SCMI platform/agent as they use/share the=
 same transport. It is hard to distinguish between them.

> > Anyways if the resource is not used by any driver/device in the=20
> > kernel, won't it be turned off anyways ? What am I missing ?
>
> Because the power domain is ON, kernel will not issue SCMI to platform=20
> to request it ON when kernel needs this power domain on.
>

Yes, but the agent(via bootloader) has already requested the SCMI platform,
so it should be fine. No ?
[RV] As mentioned above, it need not be the bootloader. And secondly how to=
 handle this power domain during suspend/resume? It's possible that the age=
nt that turned on the power domain initially will have different wakeup req=
uirements. IMO Linux should completely be responsible for the power domains=
 that the drivers need.=20

> But in case when kernel is doing some jobs that needs the
> power domain ON, SCMI platform might power down the
> power domain because kernel agent not request that.
>

See my comment/question above.

--
Regards,
Sudeep

