Return-Path: <linux-pm+bounces-23636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0923FA56B93
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 16:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CDD1899A53
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 15:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646A21CC7C;
	Fri,  7 Mar 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="qLA8j9NN"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010001.outbound.protection.outlook.com [52.101.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D4821B9DA;
	Fri,  7 Mar 2025 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360451; cv=fail; b=gN66SEWte4zVzw+QnSAXkOjrwd+44/Y3dz5ZwC9kN33tBZG2TILtq6USOMV4aePt7B3GLCt3iZvvWgSp0of0vgzfpe/rYT4msGDRZbm8blWXS8auOB3+4xYnv3vBD9kvlUtQWwCk1wXfT8lJBvrU8jb57filXQua8OW2SvhNnVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360451; c=relaxed/simple;
	bh=frolaYuOY1WBLbMucRGL4XSMh2RZ7kBveQEhZwiLwBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MyQm37zD3Rdxke7QXFOOoacINHgOGSbHcJCoLri19SxnyeVcUUVjXbjUjjDHO8hz6RDzm6XCqVk8XI4IUfPRH/9AUAAMt8QRzT2119gHESmtJ510LImTHDe9ufdndyC6fWj2DSVXq8NytJdWK0Pq3FIUxq3T9Ro+a7y0oDImmEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=qLA8j9NN; arc=fail smtp.client-ip=52.101.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LftYp7PtgtIWw3OdkvAGhiDzWXhWbpBhiHsFvKzDTa1nuuaXmUFIh5NK9RSNBP5aoUhDFSHFpiB0kfythSRHc7tY5mU494KdqLlR9ESzp/bLqOdy3ZmqXpuq02xzXRTwh+Sy76/TYcD0IwlWqqvvtZSX8e8ywwnyGAAoBMDCEj4pPYtWtizbySH2BIuVwIr/hd7/hX0oOo3dK5Dymo/SAu12lZnuJBCPgxfpRY8emcDy+ne6StjVFi+XvAed61MBpjZ5zh8EIbb2wf3r07q+vy/DIzlegTB8oitHxjkGkPoLRXSWZgMOQoLqkCsW7R5w+LC5+xsQZuQv1j6/AnV4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sB7XnKgplaU4P6P82tu6LVf3urHQQZTgQT+PALmFIdg=;
 b=Vpaiqe/tqZ/GhP2SwPsTnJHo1LxCj8890Ope6ehqSiBJAnnci5Uk44aYQA6449RNti8UzRaAp7Y8oIABLG+MeVPvE9IuaObdI/s0gXwzYVgtzMoXFXFIB8LxigAKxkVB3SHv+nTtk3+bIsskG+rT6V/SJ8X+YQ0RJ+WljZvE/4uPJKkljs0pmPpj7hFtJR4yKU7iFw4U289V1fjP2GRDE9eEXllEdzBQudGcnAoBYW/yprix9m1FjvlaWIDWWAzpiQBs+6awzgYl8ZjsTnAUDOJAlhiJZC0RelAn5vMLUIhrPTPrKtPc2V6VYldUZs3srdYvQqmagGloHTUee5WL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB7XnKgplaU4P6P82tu6LVf3urHQQZTgQT+PALmFIdg=;
 b=qLA8j9NNlEOTj+2wfbNJiqP2rAA3thKWGQ6xStOrG4rXf4E8RKQ/8BMl4gkJrX+kfrFkuWl0xRW6VyVRWDnlDLDrrVuyw/0A+FjVVeea4D1ga6fCuP/WPDDGhpJxMXY45YrNrM0tA3kGWJ6VpOQ20pqEIOg/Srz07ZjzRGiO+u4=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by TY4PR01MB12838.jpnprd01.prod.outlook.com (2603:1096:405:1ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 15:14:05 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%4]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 15:14:05 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Conor Dooley <conor@kernel.org>
CC: "geert+renesas@glider.be" <geert+renesas@glider.be>,
	"magnus.damm@gmail.com" <magnus.damm@gmail.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
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
Thread-Index: AQHbiRKwzjBFhg3PXkG3oKF6ljEYA7NdFKWAgAc7OeA=
Date: Fri, 7 Mar 2025 15:14:05 +0000
Message-ID:
 <OSBPR01MB2775DFC184F78E9FB50F28FFFFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
 <20250227122453.30480-4-john.madieu.xa@bp.renesas.com>
 <20250228-shampoo-uprising-44ae0d3bd68b@spud>
In-Reply-To: <20250228-shampoo-uprising-44ae0d3bd68b@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|TY4PR01MB12838:EE_
x-ms-office365-filtering-correlation-id: 6d98c16e-5943-4e8c-2d4e-08dd5d8ab357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xUbMlMAIGubrEgOZ2KW7G9Z2O1DR+xfZV7kuJWBAR0PvOW2aB0L38E5O5O+b?=
 =?us-ascii?Q?tzuvHAWZd4miupZLzkQ4cGjXiqu44804w0xQl6YsftxKOiX3KJxH6/x2rXG/?=
 =?us-ascii?Q?7ABBRPk2Sj8U9agUBtzsCqUXdYHMVgOf62V3Q9TjrvZaop1/XZCVgS62nOen?=
 =?us-ascii?Q?WAN8AYRv6Ba5dK2r7gOKC5kSUJlLNVuOPPsPyc65ViyFB4KjotYePCiTqm2K?=
 =?us-ascii?Q?jFiAShimvR/mwMvrGGgoJw0sDyJFLRvePvPp8eVKOF9CVjqqKHthBjVRE31W?=
 =?us-ascii?Q?fZXuLq1us9Eokl7k+JoLm8CBF4QJqU8wdOp/2p+Tk2pcuF3TrO72CbTWbvdb?=
 =?us-ascii?Q?UGkSvn28dCvZT0V+/7UE6vPmxMms5G605VRr9j5V6AiNQ3OswrLcFbPAcXVy?=
 =?us-ascii?Q?vFdnkDoWS7AaFoJ+jJttwCefFLvLf2nt/JeiUxSDvOgU7qmv8rtKcHlOs6Ph?=
 =?us-ascii?Q?SNJXvtwe8scB88WRpK6zuCrQM8rXzsE61zxwy0qPqHgFfv039yn06Ya/agtw?=
 =?us-ascii?Q?JtkEEUBA51JK4x8SQA1xk7XHz8NQOp8TNDfyo/SLSm0gtLp6MhMTlydO3PXu?=
 =?us-ascii?Q?HHTuxrE+UMgnVTaLUkRG7TKbGak/hmQ2jK9n98+kDQzFqybhBRiPVbWKfSQ5?=
 =?us-ascii?Q?osbTUFZuVutlb2Az5Z8F798SWjdgtPOnZqXWvH/a4EzJOWrd9fUr/R/DT7Wc?=
 =?us-ascii?Q?obKBupkcPp7ibwhob0Meifk7818bOZp1k7Q0FYJ1dxHecLYwuLpBN/79XwOW?=
 =?us-ascii?Q?qETtg3IQxONlUqQc6DHCnrFxfAt31vXKkff/9LFSTq14PQ/XbuhZepTFB6s6?=
 =?us-ascii?Q?/Cj4cW2rn3ZotrZ8KoQBpQ1+8OoQ+uZoOaTJvuvrCEfnYT35dTEzGDHl/asJ?=
 =?us-ascii?Q?y3hG4Hyj5dvvLGhOhXlKfph+63FPYM1NoJiJ3+y4XsUiwKS9SBLqx3JPHcmk?=
 =?us-ascii?Q?H2sBMahNUMTthnEfw/kfX/ecH3cfUqZFhBjZohjqg2xTQHs+FuBuPWwEJy5A?=
 =?us-ascii?Q?yLCF3CThsavCJmj4yyQN3Vox/52mbLlsTg+G4s3top1b1CbMkkRzRVRpOiry?=
 =?us-ascii?Q?+nDpJGWtwDKqjWkiMFCjcAJuaGbHULHIuUJ5Q5xt8ihjIYgKDdpi1Y4bkrYC?=
 =?us-ascii?Q?d3ySSTEd/q1RnazFDiMMDAhDLjL1fTdMDzP4FF6lt9ZM38MYVYR7YhRAVvXc?=
 =?us-ascii?Q?Hcl+/q/Wo4aq7ij9TCmSu7U75WCKEooJ6p6QGTphXgTAMvgQQqnStiHtpoc8?=
 =?us-ascii?Q?aHaFIuBC7uQt/KS8G4XdDmcfl1EwDthOB0KiLTF2rV/5uerX+XnqSkJLTQoZ?=
 =?us-ascii?Q?lZk40ANGyyVPj9FwXgg/j2PTZQl3DAz3/JA6l+cinrBYV6ljNMvQD5uGPZS1?=
 =?us-ascii?Q?hbinvqeu8c/ESio4fkQ1XnUq0VeOGYQxFnNzgxZsds5jvezP8g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uqMSe2aGcGYlmSA4fXAG5FCKOqUceIM0tnyXZVwnwq83sTz3QY5Gox5DV24k?=
 =?us-ascii?Q?ImhhIoYCLPjw29WWpMbIerWbL70z+KkUvK0GjdNsAxw9zHHVsrlL3xksbqCK?=
 =?us-ascii?Q?Ay/q1P8pPYqj8GPU8dSRJ96iUU0+Gjt6BBdeCigWIOKx1RbtW8xNbBy8WIcg?=
 =?us-ascii?Q?ROXxOLF6uSwXUqJzvv8dhFdMogIsLBY2f0Rivv9HcRBBTuvPD92kBXG4RG7G?=
 =?us-ascii?Q?AQWSvI6KoxGGiRwOABdJclwAEyKTbAeFLV44irBH1w6hO0xYgdPMUuD6fWSQ?=
 =?us-ascii?Q?kjtimrIemOibNpLzP4FwosmzgTx+elL570UoBRYFVa6Ix53JbwLcbarfQU5s?=
 =?us-ascii?Q?nfpkEXha1Iq0GxsSauJgMlWLXUGYkKUAtLplKxpL4udhfKfDJDtw4JydhCUC?=
 =?us-ascii?Q?Yck8Bx+17X33hxuKgY8hhHTJQmdoG0+4KBudmofhv0rGHue4R5w9N87UZcK2?=
 =?us-ascii?Q?HBNnTx3yy1IBFBkA5R8W0P69dvMZBm7M2JK+5Jg0IX74PJ1+tWAQITABrYac?=
 =?us-ascii?Q?TYPtR5jAUjvQixqKSKxmPA7lJG2fSFRTEubpXfT5ZyL+uz/Wvjy5vhm4xZb8?=
 =?us-ascii?Q?S3dgRKB10crXx2pKVoT/lb6lF+GQ8vHYPgME1dTk9BuarxXzyS5I8LyMYrVP?=
 =?us-ascii?Q?2S4qP3geV9rx8w81tFYimL+ig3kjrRpC52gwNL7/OnYfISpq5KCtTriNsdiq?=
 =?us-ascii?Q?KBcG+2y3VnidDsTZThtOhigRLhjbX3HnawiZdiMdsaJnfnj8CHIVJA7tU1wK?=
 =?us-ascii?Q?ggr4DpkbHMRYp16gS7UyGkmEhudyFfPFbdlqWTHuJV+kHnqEct2al0+a0rxd?=
 =?us-ascii?Q?RK627P+xtAJmxN5+hNvWwKuB5Y1ZlJroesIFPMAC8omsS1qahjfl2HhZ7mJp?=
 =?us-ascii?Q?Bl/06aI5UOY31qQ/GCuk6zWUpsRsBwDqXMBHVfa07u2+Rct/+1jW2X+MOvTj?=
 =?us-ascii?Q?wuXaMCru2fVmdY4elTzQE+/ILjhRY8dbwMi+7qX4RJJmWKem/Mrl2xgMJtw2?=
 =?us-ascii?Q?wSzuCbwStzt1muKgxZcnv8Oh5q4n34QCuUmfiyChXyw4S3lYxiMK8GqmXxjR?=
 =?us-ascii?Q?ow4NBiZnPZbLIgH2FEYQf4S+yFAcBG748Pb3OsjkboDYrVJ6AfK2zEy6oyEM?=
 =?us-ascii?Q?0zVRDJ7ZzgGaC5bZMd5xJU9NWYkD17gkop4DQh8vy6nOWjoyKfkk4NYBfTO0?=
 =?us-ascii?Q?UHmsxND92FA2miQCnCaH8To30m+s7Aot/7/AIGYR3RCz/HyHfaZfZdyV977F?=
 =?us-ascii?Q?LE1UUBbBPFnom94CyKf6kNOzDCphvGJO98oNQk3YZSFpyd5wlZ6dEyGt/Uzg?=
 =?us-ascii?Q?ZP58PF2W2NOAcK+4/+KkyXH4ZhBGMXydEB9ESu0qAwtsUOLbcUB/eov9bvJM?=
 =?us-ascii?Q?+zVliGntS86xGFVPKoPLIqbSJ7PJVnmJjBhbGmsdJsPhmE9IJwwdiK9m4zXU?=
 =?us-ascii?Q?aJbDOxkdwB6epZtT6gPgatHawrcD97fwT1GFQKDx/0t89q+p+koBXu9ey5uQ?=
 =?us-ascii?Q?UNuNknXDwQcJruvyZaK/fXKuf3mjXQprPwAm4SwV2t/E96pDBVFvan48oMGC?=
 =?us-ascii?Q?wT3jbwuc2gI0rpAr3Lvk75M4mbY9eRueLck+ycJTd4WZYV1PmyrO5q6ghXGW?=
 =?us-ascii?Q?4g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d98c16e-5943-4e8c-2d4e-08dd5d8ab357
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 15:14:05.2038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmrwHvZz2q3mRftcGkixyeCYc4mYcOkcBXr2HyOXzAtRLHhRDV8ygqqq1LNmJROFL/2ocBzpZRX+1Fun1n9UFHpFCdFf1opPvIhJbUfgU7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12838

Hi Conor,

Thanks for your review!

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Friday, February 28, 2025 8:03 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document
> the TSU unit
>=20
> On Thu, Feb 27, 2025 at 01:24:39PM +0100, John Madieu wrote:
> > The Renesas RZ/G3E SoC includes a Thermal Sensor Unit (TSU) block
> > designed to measure the junction temperature. The device provides
> > real-time temperature measurements for thermal management, utilizing a
> > single dedicated channel (channel 1) for temperature sensing.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
> > v1 -> v2:
> >  * Fix reg property specifier to get rid of yamlint warnings
> >  * Fix IRQ name to reflect TSU expectations
> >
> >  .../thermal/renesas,r9a09g047-tsu.yaml        | 123 ++++++++++++++++++
> >  1 file changed, 123 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> > b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
> > new file mode 100644
> > index 000000000000..e786561ddbe3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.
> > +++ yaml
> > @@ -0,0 +1,123 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +http://devicetree.org/schemas/thermal/renesas,r9a09g047-tsu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/G3E Temperature Sensor Unit (TSU)
> > +
> > +maintainers:
> > +  - John Madieu <john.madieu.xa@bp.renesas.com>
> > +
> > +description:
> > +  The Temperature Sensor Unit (TSU) is an integrated thermal sensor
> > +that
> > +  monitors the chip temperature on the Renesas RZ/G3E SoC. The TSU
> > +provides
> > +  real-time temperature measurements for thermal management.
> > +
> > +properties:
> > +  compatible:
> > +    const: renesas,r9a09g047-tsu
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description: |
> > +      Interrupt specifiers for the TSU:
> > +      - S12TSUADI1: Conversion complete interrupt signal (pulse)
> > +      - S12TSUADCMPI1: Comparison result interrupt signal (level)
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: adi
> > +      - const: adcmpi
> > +
> > +  "#thermal-sensor-cells":
> > +    const: 0
> > +
> > +  renesas,tsu-calibration-sys:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: |
> > +      Phandle to the system controller (sys) that contains the TSU
> > +      calibration values used for temperature calculations.
> > +
> > +  renesas,tsu-operating-mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1]
> > +    description: |
> > +      TSU operating mode:
> > +      0: Mode 0 - Conversion started by software
> > +      1: Mode 1 - Conversion started by ELC trigger
>=20
> Can you make this "software" and "elc" or something please, unless people
> will genuinely find "0" and 1" to be more informative.
> And why doesn't the property have a default?

Sorry for miss-specifying.
ELC is an external event trigger. May be should I specify it like that ?

To make sure I got your point, do you mean specifying a default value in
bindings ?

>=20
> cheers,
> Conor.

Regards,
John

>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - resets
> > +  - power-domains
> > +  - interrupts
> > +  - interrupt-names
> > +  - "#thermal-sensor-cells"
> > +  - renesas,tsu-operating-mode
> > +  - renesas,tsu-calibration-sys
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    tsu: thermal@14002000 {
> > +        compatible =3D "renesas,r9a09g047-tsu";
> > +        reg =3D <0x14002000 0x1000>;
> > +        clocks =3D <&cpg CPG_MOD 0x10a>;
> > +        resets =3D <&cpg 0xf8>;
> > +        power-domains =3D <&cpg>;
> > +        interrupts =3D <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>;
> > +        interrupt-names =3D "adi", "adcmpi";
> > +        #thermal-sensor-cells =3D <0>;
> > +        renesas,tsu-operating-mode =3D <0>;
> > +        renesas,tsu-calibration-sys =3D <&sys>;
> > +    };
> > +
> > +    thermal-zones {
> > +        cpu-thermal {
> > +            polling-delay =3D <1000>;
> > +            polling-delay-passive =3D <250>;
> > +            thermal-sensors =3D <&tsu>;
> > +
> > +            cooling-maps {
> > +                map0 {
> > +                    trip =3D <&target>;
> > +                    cooling-device =3D <&cpu0 0 3>, <&cpu1 0 3>,
> > +                                     <&cpu2 0 3>, <&cpu3 0 3>;
> > +                    contribution =3D <1024>;
> > +                };
> > +            };
> > +
> > +            trips {
> > +                target: trip-point {
> > +                    temperature =3D <95000>;
> > +                    hysteresis =3D <1000>;
> > +                    type =3D "passive";
> > +                };
> > +
> > +                sensor_crit: sensor-crit {
> > +                    temperature =3D <120000>;
> > +                    hysteresis =3D <1000>;
> > +                    type =3D "critical";
> > +                };
> > +            };
> > +        };
> > +    };
> > --
> > 2.25.1
> >

