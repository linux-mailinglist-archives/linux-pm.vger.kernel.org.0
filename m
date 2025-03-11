Return-Path: <linux-pm+bounces-23835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6191A5BEDF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 12:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C1E7A1A3E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 11:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0A6253F05;
	Tue, 11 Mar 2025 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="DeyHM3sl"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011034.outbound.protection.outlook.com [40.107.74.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91FE1EBA09;
	Tue, 11 Mar 2025 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692312; cv=fail; b=Zqfr4hM3QFj/M8MLU3ePr2j2OXsQ951/oGqx7deqi8CpPwPhTkSyUb05X5SCViWMhO1GUHzUPF8C3wvgT6R/AmibL6ZPRteCa9XoIuUoC43RJqS31Myht9xswTJhaY8H1FgGUaLJgrhPpyUA2zV1yjt8v5/oGjGz0M3GQb/80+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692312; c=relaxed/simple;
	bh=xn9KogLyXi36H1TH1PWHWT0Kk7pbY4lqtJ1CGcBFxGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iFv7bLRk1/PCt9yI/HfAlEPPV6Rc5qsL/1zrIFVJ2SUkBXwWl10rl1yOw0fZAJDBcZTEfn+GlPxuT4NawyGF4KvUk/Kx0Cnk+kQ+/yEHK5XdXv1KzXWTvi/PAlR+1o1keFaCwVDVrXsEb6iegBAsIAusK07zjx9RlVJfhAWBspk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=DeyHM3sl; arc=fail smtp.client-ip=40.107.74.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUpleuBZyWExn57F8Mu/pBjP+NHnGw1+Ae1dLwc/r8xJY6bKFCRUuvSOnaXmjlj02B4TB2SjnMTzSGHYtYkZS6jY+r6a6eZM9rafiLmqXoaWLXzxBT6AVyCtVJmppFn/V0rzh658lu4lK2lzCB1S0G/o5/8PjBnxYeX8aJlrotzg1JA2Vs56d5mZhxzpn90mc1DJk3gk1TsXuEnBWabDm8KdbidGUcyKa3UXE0CzS6E5N5VuXADVZGb4d9+uxnmJcBe9DkP/bi2/QS7BMSGhCjGUO0EFGsWdcpAqCBYqGm4Ul+n9Hh5vVmI5IOBy1OSfO1lENx5wmqEbHX39hzURzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xn9KogLyXi36H1TH1PWHWT0Kk7pbY4lqtJ1CGcBFxGE=;
 b=gEas2adDCVR639HpNpmT6L+RUpK24kx3sbu3NIF+9auBMgfCfXbIy6hTwX/O5uIzhUr1kvaI/SA6/MXoCDQqXxMgcRyjhvMxH1QEyf9wEZQN/GxGSAiY1LmuZl8RyHvQUG4esSVNZzzZa6t0rZdPQcBw8DEjyIVoZWcp4sdTJOruXRVO7PbuvhC4VebZs9QYK+bCLbTm6wZkLQCt9zG0vdRqiPC6hkKqdfRUuELbjve8qsJhRv0NieZ7tKGvPCEkWvtcCSSC4sWKGMDyjmuFoXlYWQUBtvI/WfsOF5cEBm0DWzf7TCdGSVctkLI22b73ADaf79YbNhsGgYNlKAJabw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xn9KogLyXi36H1TH1PWHWT0Kk7pbY4lqtJ1CGcBFxGE=;
 b=DeyHM3slB/04Je/855HvZGT81qXcfE/QqOiiLTqcS16A+6WTpizx2C7mnEe3KGsMrnC+XizqJ9S6f49qwfHD4GjPcAT3yGWTA2glVBQKYmpihNN0/MUvbCldb+mecJ/m+d41/5ObBKKCBSyR8uspelVvb/v1CkNzYNxknMaT9xU=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by TYRPR01MB15836.jpnprd01.prod.outlook.com (2603:1096:405:2d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Tue, 11 Mar
 2025 11:25:05 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%4]) with mapi id 15.20.8511.025; Tue, 11 Mar 2025
 11:25:00 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Conor Dooley <conor@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Thread-Topic: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Thread-Index:
 AQHbiRKwzjBFhg3PXkG3oKF6ljEYA7NdFKWAgAc7OeCAA4ptgIAAAsFwgAAF0QCAAsfM0IAB8mQAgAE6AmA=
Date: Tue, 11 Mar 2025 11:24:59 +0000
Message-ID:
 <OSBPR01MB2775B3826A9FE602AC08172BFFD12@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
 <20250227122453.30480-4-john.madieu.xa@bp.renesas.com>
 <20250228-shampoo-uprising-44ae0d3bd68b@spud>
 <OSBPR01MB2775DFC184F78E9FB50F28FFFFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <20250307-everyone-ragweed-e05a10a9646b@spud>
 <OSBPR01MB277531D7C872C9EB0B287069FFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <20250307-barbell-pretzel-368d6a4d1336@spud>
 <OSBPR01MB2775D121B55A0C543F251BAEFFD72@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <20250310-blurry-scam-bee8233878bc@spud>
In-Reply-To: <20250310-blurry-scam-bee8233878bc@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|TYRPR01MB15836:EE_
x-ms-office365-filtering-correlation-id: cbd93496-8fc9-467c-04a9-08dd608f5c3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZB0Hh5pYfK8LszmHBLBgjnglT2889138GSZ4C+NRSBmOudKXlzjk4d2TSzWd?=
 =?us-ascii?Q?hf0eQ030VjVV924hHz222t1x409ciICCq9WkpjRcHQ7w4aX9oqrlVCR7MF37?=
 =?us-ascii?Q?QsT1dsevXigA6PhLL85BdvT+ofxloe29SpKyK7h6DmrzI7aSybU8SzeDTC/w?=
 =?us-ascii?Q?zdWLhKYirSCods+SsSJ6H0G2HYB+jug08H1FOsFz2Its7/bSb4Y8Gq5TSkE8?=
 =?us-ascii?Q?J+Flv4a1m6iK4WuG2vXz4DTS282oHk4qb0Dz8TmubQQiE0sxjxAVNV56o6aC?=
 =?us-ascii?Q?WBRPwuU3wc8ZOqNw/gpIE2KbPiTzLQMb0ODzT79drqzTodV/4zPNd+vMghW+?=
 =?us-ascii?Q?7fa6ziMMg77CPY34Irmg8G+8vO3+LROS8z7grDRpa1RtfSTyyf8rToPT2QMl?=
 =?us-ascii?Q?O6g6VZ3rRXjgxeyq7J/J2taJXflgFPhvMrMwczs1ifKrmw6kx17xutbNeQVe?=
 =?us-ascii?Q?j0Nd/xnHmbRo/q935Kaq+4LG/yGSeHA7T8Yk/bBPMVTfhvCi+HIPVjQL6mcv?=
 =?us-ascii?Q?MI0jpQbrND5C7BtIH1Iax0cZ6u13FGEjtfFbU7+sVb3JPG8+Ck5JVUjTZkN9?=
 =?us-ascii?Q?ZSanuX96I7yAcI/hVusDgmGkOaP9U+0otwO+Y4zP6H131wcBjAq0GIFw5zK3?=
 =?us-ascii?Q?cUSfUKfFrx5fE5RUgO/2onnTBSfEMewgsq+riQJKqR41BHnxgA5HzymFlqCT?=
 =?us-ascii?Q?vP40uUhkl6i5WRJOrh5aTtvHFFNPh7Dstos/Up3lbDfpb6LDoRvKvYyOO26M?=
 =?us-ascii?Q?NWdaERjB598ax4sfbG6KRmlMbxxvsubK0JOhhPQRgvqPWt9M3N1GFQcCE7VB?=
 =?us-ascii?Q?pIDlHUsdnHlkeDyuqxUDj0jtCyExwnRCBcpnCnvbNW1YSpA/3aWbZUvequFx?=
 =?us-ascii?Q?BgUD6HoZEKZOB6NyjIgwblng7qvvaI/+FgDauLJ0e+DW9INCYLdoOMIbligp?=
 =?us-ascii?Q?/dxiG1+HviOp0b6X+nM2kA3mQpmdgAP42qflPApsSDlepZe8hJG4wf6VZank?=
 =?us-ascii?Q?ukCLDf6ZuxRwUNCCetjMxD8TiqGCtaCkmGeoj9iqyjPBwvNRuS+QO5zgb6tM?=
 =?us-ascii?Q?/LQ6LmqoDnVzbf0WKUu27nqwjEdYqKB/w3JQUpWUbEuT5WebUnusQZWg8wuu?=
 =?us-ascii?Q?8LBN3LMWt7lPm7pB890GUy0HYXzMy4xFv7Qa0kG/duxZRvjJt9vRfMAoOIaL?=
 =?us-ascii?Q?X+sk0iQRtx5PTVR/yrQ6UkoRXFg6V8bHPAzEUAfDU5FZpL0x+JzZb2AX4wpO?=
 =?us-ascii?Q?+JjLtj3aRTXOxyTEj0cQ2l5DWO+F/auJEcNrMkhMQe+9t75DYUJUNU2qCLip?=
 =?us-ascii?Q?1nNft0MdxYW22Cl7tSAQUnRdDfTKqc2C9+MpQVf0p4MA6en5aQ8/tOugGtXw?=
 =?us-ascii?Q?W50PDv4Ov/Simg0cU/B/YmkR/t2h/UOF4ttrtTmGnIFJdk76Y2FlertxZUEx?=
 =?us-ascii?Q?wkh+VomggCs6Nu9QK/XKDxDssQjAquaO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RHlOevyDrrYYcTWiOE1LuquANFeEA1TRTwmi5qrvbqyEIQP5HGuLvqRLyx/Q?=
 =?us-ascii?Q?3UuO0O6Kl0S5rtd7XUfO0Vl/KPm4chsgkJnDHlJW+GKH72ptshiBUSZ6QHP4?=
 =?us-ascii?Q?L1w4p54HDEA58+RyryAuAeFexKhAITXLfK3itZRLl5F1aASdxopXairLU1D2?=
 =?us-ascii?Q?3+7VmJo13VzJzVq9Mh9GPTYD5Q84xvNdwu8Bx26B4XYzy5iVucwQqJLSjqm/?=
 =?us-ascii?Q?FTcxtzLp8oKlg/Em9VwEMcEq+GUDfA/hWrPlapTDPVmNqFDZzCVooQFV+Onx?=
 =?us-ascii?Q?Hh3gKxMsbqUJH743fRoY3yd69vFuxZ3SrrVi7xT7YSR/ivwwg9SNe73UdAVj?=
 =?us-ascii?Q?qX6mClvv1V178v0CuRVdodkgHKwCC6xyMwPdSVnjnhxmPgpBQa4soYWIdguk?=
 =?us-ascii?Q?t5TH3Vco2Kj6d+o3I/1DFzGbE91Kaol3LmL9Y2qeHryRD4meW4rP1EXR7sb2?=
 =?us-ascii?Q?7rSQnWV+DW5g/TGe641GyD6Czb1JnZgTqN6CD9/3eG3qaKterK3MGSEjmSfJ?=
 =?us-ascii?Q?4vY0SjtG6R3ATIWeswRpClNdgxyMoJCLfKeI/hv6AlI0SYq5nLvoAiU5TBPP?=
 =?us-ascii?Q?QSB6yyWqffRf+T4KRFwyW3793YV2q5mUnGU/6RU8il0rMxijuJb6+ETxsmQw?=
 =?us-ascii?Q?Y1L7NwQMKEjMqjlGkYwLEWue+1DpCQZ2AwopX5KzpaK60B1K50LYZeA0DOM0?=
 =?us-ascii?Q?AAekQVSmL0lf7dviB3B+/st51Z8kyCVXiiPc++qhrW4JKbiCHD+w9PFqbnBW?=
 =?us-ascii?Q?h82LGlHu7K0QQnBTi18zg2BtYU2Uwcruktnb+g2CCVxXW+53GeRTcf7NgFse?=
 =?us-ascii?Q?DmoEzx+6ZsUF2vqltQF65SBwCT2eqMc3HOn2Ps5Lso1GDIviWhMJo+vbGUww?=
 =?us-ascii?Q?gtrn8UyM5b1W+OoscIgCWNaLCqwrDvQqJNyrlEfkbIupLHhsEhUlK4qBO49P?=
 =?us-ascii?Q?obMHzSzLruqyO4LLzi6VKNe1FWiyYsrIQIxCDZoX1XfEZGTaYVUefeNDsYHb?=
 =?us-ascii?Q?tT5Y4kzdrs+1lmVn9solIN6VHETznCop4gXN2jEE+h6zn0mhabRKgerRI5Is?=
 =?us-ascii?Q?9Tg+KgK+dQIfXnv5xIsRs7Wn0ocyG8t2Jf4Y6oTp039n5q2rqOTDAs1u/Y+k?=
 =?us-ascii?Q?EtkKk/Dvl0RHzYYyYi/dlayfJNLPKCx1CBEYn8QzuStmQgtWr7PnjKoLKopk?=
 =?us-ascii?Q?dEfB4vmgHYgrFHQqk9J50pnwk172ar2GH4iPIotThw4yt8AwX+tSDJeSNp/g?=
 =?us-ascii?Q?7RakqZ/2VOMCCeE4zHRFb4nCQhrPbHOE68fEvGB1YeT/30nGgpUzGolDTGAI?=
 =?us-ascii?Q?//DmL3y8ST4E1o1BOqovLDMSEFQFRns13uCK/959O1vC7TSrx/HmVFWZl3ko?=
 =?us-ascii?Q?x+e7J77L04+CdnwNzCmiJEJ2b3kGAtiRO3etR8OfJ2IqHgQ8vOilpa5aLrAJ?=
 =?us-ascii?Q?BbAdR9R1rWDwAhW7yXLeK2hiAocBEsB/bMO4Wj+NxggEm4dv718ECRjqUeUG?=
 =?us-ascii?Q?pWbfrNkqA5quEzSJy8RBVcAQQ3QwckUKQNxeM6UqXdL7AlibZ/J0geE15roV?=
 =?us-ascii?Q?WDBUF4ip0LJDKqB4d3BfvMNYczARiRK+Te3b55MXgOKO5xH9qqEaIPlUNVr/?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd93496-8fc9-467c-04a9-08dd608f5c3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 11:25:00.0508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/7dPqVZLy8d2CUfVPEhOMX3UhAJJjBJoiAFqtrGl/DnwNtogx9ydYTBqjxPD4zfr4SV1VDa9Q/8dyyWT0t+qmx5NVeqABKbBX4d1cOkjlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15836

Hi Conor,

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Monday, March 10, 2025 5:15 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document
> the TSU unit
>=20
> On Sun, Mar 09, 2025 at 10:39:27AM +0000, John Madieu wrote:
> > Hi Conor,
> > > > Changes are not possible at runtime. Some customers may want
> > > > software, while other may want the external trigger, and this is
> > > > immutable configuration.
> > >
> > > What makes it immutable? Set by some wiring on the board? I couldn't
> > > find the user in your driver patches to better understand how you
> > > were using it.
> >
> > I haven't prototyped ELC trigger yet. Since the hardware manual
> > describes about ELC trigger, I have documented it in bindings. If you
> > think, it is not needed at this stage, then I can drop it now and
> > revisit later.
>=20
> Ideally a binding is complete, even if the driver isn't. To me "immutable=
"
> would mean something like "the trigger type is determined by hardware or
> firmware configuration", but if it is determined by register writes (e.g.
> wired up for elc trigger, but you can opt for software trigger in the
> driver) then it should be a userspace control.

It is complete, and I confirm, this can be changed by register writes.
Apart from defining default to 0, should I implement userspace change
support now ?

Or should I keep it as it is, just setting default to 0 (thus making
the property optional), and add support for userspace change when I add
ELC support.

My other question is, in case I must add userspace change support now, woul=
d
sysfs be Ok ? If yes, is there any path recommendations ?


Regards,
John

