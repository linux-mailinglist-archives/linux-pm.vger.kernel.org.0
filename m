Return-Path: <linux-pm+bounces-22876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65B2A43C6F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 11:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120B77A8A9E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 10:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F80267AE1;
	Tue, 25 Feb 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AYDz843h"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96938267731;
	Tue, 25 Feb 2025 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481034; cv=fail; b=lt5BZrRibwobFgXZ1fzlpERLX+sEl2y+oHu3rgDAJNMng3xl269VQfwpcVCq247kax82MefKF0f1cOsNHsotZIwn1YFXUydZqaAkkkgVjvtUYUGqyHS1igpmD4GJxa76alinhKJf4gDEQPCwMudHJJDObryVowSuffvJ0EZFGqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481034; c=relaxed/simple;
	bh=wj5FRYZAvLv/jeBGYBavdX/KxwT2xle7AxVhQUBawy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SySxJBTE+orNgWos8ZDMsE8FS/oPT60RgbCCvkl+QaQHcnAjaygQlD9TAEHv45v6Guq5g4OPScCyMleXT5JeUPFZWadJ/ZA0wa3SsIfTA5z0BO6fzMAZhRVyitgaLWpA7tRict3CLCyQkhORbOYi8vC1cu2bg0kPKRN8d8aIx1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AYDz843h; arc=fail smtp.client-ip=40.107.104.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ew4AkluRj/stKGya8kEvljJO9/1M4uVCW7pzFQrX1b45j2yaTsF/bNDEvrBSLiK91NnYQNZ4l0KuBNjb5uLe3iRLaHmCg27qKD5gvmBlT265/5WbijDKqHyerK9cE4turEDVF6LLpEky6ZQJhJ2UEFWJ7TB/KxN0H4cBvbBCPeJ+SzZL30OWTsHSxuxu9LYWCIpr1QRhwwbQUM4D1kgPfmkPW+DlZEV9bZRahhOnLYHYwaQ9yc2YkKzKXj1az1C1lBmAe7iiLbYlBbIjaOojCXEqNEiB4B4AABnTlhqewBKMc++ig8Vk2wG7/Fk6VdkPiSIi831kYyod4vVql+Q54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wj5FRYZAvLv/jeBGYBavdX/KxwT2xle7AxVhQUBawy0=;
 b=HPoCuY2mJC5ZtVN4dNAAn4gasRlv77pVOHsckWhvpGNjrH2mEsbbEo91+ar0fmRKDQNJdioBjmTEaF6TFqqNnaDMNsjwCOzzvSfotL6riQArzkrsen7u1M2j1c8disiGk8rJXtk90G9SMLrBz1W7zA308lOLc5Qvy1Jq+8Yh2dNmD8k27FZJa/BVkS7D+PgY5kV+JCcR1LotzFPw0JNKNAOqD6Qn9erNyuobHanKSOSz/1ayE4ar8rt52F5L2/lUl3PVZmsqDrfjOUQJpJrkfOjawWuj8D+MS3LGKXaVR269uZNQfdSrfTDXoYZUXPU0WsXnMEQelz6XJIRYGgDJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wj5FRYZAvLv/jeBGYBavdX/KxwT2xle7AxVhQUBawy0=;
 b=AYDz843hOw+UiuRYolribG4DVOWG+T/yVajBml9msj5qfZSDmpW5f8s2FQ9cBAZbOe+Dq2jLKqNhw8YeMSO1VjRh+YjnJW/FkMmRtRNEDAOwC7eb183DX0AI/SpaZECOpWgr8VKBJ00b/R4rkTlvVEh4f2r9T7nWVVksIt1lqLN9HSxejWwx4slHpU8pEifNrX9Tz1HfqdQ5+NBIPtKRwsfAjiAE1RtDrxfOy50HZ9u+OsMeQMz09igIy3cb/Hq8X7VIWTPHoGRVgyqDyr6Zg3pYMeiVVMB18bvSzfXPBfd/8BDtPmzZhOgHz4hy3rx1IPDEd0QTBf1kiiqE/D3qig==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10452.eurprd04.prod.outlook.com (2603:10a6:150:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 10:57:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Tue, 25 Feb 2025
 10:57:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Ulf
 Hansson <ulf.hansson@linaro.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux@ew.tq-group.com"
	<linux@ew.tq-group.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] clk: imx: clk-fracn-gppll: Add 477.4MHz config for
 video pll
Thread-Topic: [PATCH v2 1/6] clk: imx: clk-fracn-gppll: Add 477.4MHz config
 for video pll
Thread-Index: AQHbhshtJSjeu1Kby0efTT2MOyWQPrNX2kLw
Date: Tue, 25 Feb 2025 10:57:01 +0000
Message-ID:
 <PAXPR04MB8459CF98542431918871E76D88C32@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250224142831.485159-1-alexander.stein@ew.tq-group.com>
 <20250224142831.485159-2-alexander.stein@ew.tq-group.com>
In-Reply-To: <20250224142831.485159-2-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB10452:EE_
x-ms-office365-filtering-correlation-id: 4aa6100b-09bd-4bf7-206a-08dd558b2240
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Nr+e5NuB8jjgFc+pRrDSkBG1xoQDsCDFsk2c/PdPr7umdE9mjekC0EzsW5qa?=
 =?us-ascii?Q?1sqiE/KBKc471kuBj/FGueIq3It2tuKWAkJjGIeaPGLx4uhfRPdQ3BriSQrH?=
 =?us-ascii?Q?S6tkwOWdioSxOfGa1Z+krltCjCHaYPhbgWf5O5NYEW0ByAaGYkhChdw/Ffan?=
 =?us-ascii?Q?uZd3rjabw2hUEerLxawRdLqzUNVfrQ6ES0OQhRy04UlByXp4mVi2gAxJ1WGd?=
 =?us-ascii?Q?bRmBdvXwuy2/WVcVn5F6sMwxLPx9M3ST+VzVqV4U0NAdRHcgdL9+Au5I8to6?=
 =?us-ascii?Q?wp0QWGKK1IS3E6dn+Z46IJFMbvFsyhl5xvn1KbmftZnVYJEnwuurLpREJ1h5?=
 =?us-ascii?Q?YTP1gRK93TuOWl4kKnPGhvJ6kaDgxR0c+Qh3B8hM9NDJXFSrrjabY2ngGAdM?=
 =?us-ascii?Q?3d/oSZh7wAyoSd9AIvaBViXkm6Ls1nBVj2OyGYO3BgjVUhMhRHMSWklarm+e?=
 =?us-ascii?Q?Opmdg9oYUVOih9XsJfLKuSnR14n6PSiVnzx+1LR7uN/+CAUY8sf/BqJGidf5?=
 =?us-ascii?Q?q3FMiUA3zgc75uaOsjXxYHhuqouXVr0ECx1JJcjoA4v8XwHqmyJ6eha3i5aC?=
 =?us-ascii?Q?J9f+SA9b3W6iUwI4ttKuQwMMtrdCz+yFVl6FFKF0tIH/p2nu0I/twGDeOBYW?=
 =?us-ascii?Q?uLlMiU0XY33JTOKgAyx8lfjxR5qOmygEebOLtvgSLzzrwDnp/hT6moMy4FUy?=
 =?us-ascii?Q?MMS21DPU0LLM3TGiQeYRve+H4XclaQttrsYl6CH3rGQttYywtoVCQgp90wD0?=
 =?us-ascii?Q?MAZz/rK3AUN63rU6j2WbZ3SoRNF+JqznOT1YI44mroyJqwMpw9eRgxdY7Zxg?=
 =?us-ascii?Q?PeMABLtRbymqoTj5/V9RIugv1AAuGAl+020POX5/ziZz7yRyOqqBeFL3X2LO?=
 =?us-ascii?Q?IBu3O2NjykUDIg1AbDuC7qyJYJ2zaj10w8ql760l4SOS2VyNxPjg4zadX5Y1?=
 =?us-ascii?Q?hno8ts9WKtPzuDPmhiJXhXSddtRKG50lO7WAAgVE1mXQUESZno+xL2WBsTUv?=
 =?us-ascii?Q?0AiPxSS6V5V8RPZOxRx+qfvbg62vU+kxT9a5vlNRvBSoxo4AEGi5W1FZaTXf?=
 =?us-ascii?Q?cM+1HsKJ4mRO71Ycn9o2NO0F/rMSHvueD2rVc7Qs/oHj9YfOFZfHg1zAnEwP?=
 =?us-ascii?Q?HwF7ZKuBDW9WyS0Gm94IQNyAQN1fvEjmXSU+1HSDuux2E9LJKYvB7jGsPktp?=
 =?us-ascii?Q?e5LXDM+n2yenKBpBaAWNgAVBHf0SpenwT7OD2XrFwfAixwvanveXPT8NxjAY?=
 =?us-ascii?Q?q4thbtj8Vl1YF/fPSrHZ2sjRdGdYf7EA2bksh2hydtg1vALrNRtY/I89rl5q?=
 =?us-ascii?Q?lf4f/3fHMaQkW177BN5NVGI7lACgui7zUAOeIj5heIDGVvRj4WpUFFMFhuYV?=
 =?us-ascii?Q?yovohaMXzbuISlrxuXsaHqKPM7X4UtIQcU/nFlCoxbCq8cGmk3D5G11FYgLm?=
 =?us-ascii?Q?476/KYt+de7YJSE6HLMAiH28C6neAmxQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?alGJTtLMtNfqAN8PAgbfBnxrclZvmA5Ew5JY2Tf8tJDijXT8JVhIHYc7gsgL?=
 =?us-ascii?Q?seZCKgOP8LNO2uabpoUpnp1qEfuQ6dsaHN1Is5IxAlYwlvZUEUxfYzIAJTDy?=
 =?us-ascii?Q?PYUROylaWPclwmD9NT6gOq2FZlki8BV4aMvmlkkJyVrebZ3g9MZCZxEGP4OW?=
 =?us-ascii?Q?gCZSFsSIN576XK1LoIJzHdkPLZ2xyPKBdqsDqOrO3uLczYWT1FL+LhP1eHvT?=
 =?us-ascii?Q?O/SZgdeBmQLsaox8BtAS6EpwExeAhrnDT6QeNaFRl4Y8KFdbJRy2cF3awfOQ?=
 =?us-ascii?Q?7Y5A5OE0OX9C/iKdowUyXIsM3++i/fHzLOBg+k5J0OJvRA2JBDcuMNVm2RKg?=
 =?us-ascii?Q?YF+9qWlyWW97ctiGPDKjmgEc5ZBGfUVo0J/p9h1eAQj4yc5R5Oe3kq9P3cun?=
 =?us-ascii?Q?IGwiQAdH/UEnk8RdMo5T5YtFFJiBONAJh8WsTs3XBLV1ISLps1daAUpjjbRj?=
 =?us-ascii?Q?m4SODq2Y+2Hn+waj5IQDgKf5x6HVQ1C3IlHvgFPxUFIq50KlV/iW1MwJbiVo?=
 =?us-ascii?Q?cFLYyYF0FCEa0ktb9jL1A4Q+C99jt5EnYDkUmXffmtT1C2zuqd/nHj19yAwR?=
 =?us-ascii?Q?jm0t1sSkVZyEQQzwV31GmKCfaK0abS2a4F4qEHbrNrh1V4zntKDcDUoLQs9V?=
 =?us-ascii?Q?WsRlAhjug7hJfccFkywvUzI6GFT25WaKcmlArxtHRkYX/xegTBQUti8hUKNL?=
 =?us-ascii?Q?3RU+/QSvJnBdf01fgakrAT8npxcSsMxGkniqHtp0PQvyMSk/da6bH1AtU2Fr?=
 =?us-ascii?Q?IjoB69KdIMZWiEjYq5jJrtnVMnG3/0O6wBQEG/CSWZ3tcrlnBraq2Zy4ratN?=
 =?us-ascii?Q?K0tFFaTst4bEwTs7S7/G4KsDbVqEafqW7Fi56wtfIgFg4s1RDSy3zDioeIRj?=
 =?us-ascii?Q?XpWGGw4RtCA648gFpabgpt9rekymZI7KUdT+pZ1s947ZJxxH7b2vqBspNJRA?=
 =?us-ascii?Q?MkBb3VCtI925je3ajK2xW/dlrTZX4RHQnxlkW0IaAT/uIhPlV3rGM+IBG9o6?=
 =?us-ascii?Q?+HF0DwimgV+ZHiGRyqc6/IkKnoIKNpFdx8m2BlrDA9E9AAdbPXGgduB3TWJ3?=
 =?us-ascii?Q?FosA7LGwMuzyFe/BAHeS8u0ASqcuNsRfotesUjKSl8ioqkIS9DO6YtC3D1EL?=
 =?us-ascii?Q?vEEFDSb7NX/gFROj+LMzI96vMdS1R/j4wfY4GWuTyxPmilthxUY/0F0gX2kD?=
 =?us-ascii?Q?V7HrqikdmnUpLGvhwTLk4fDwnJvAt+UqUeBhA5vKqepPyA2tYc17YdleUnBt?=
 =?us-ascii?Q?bXJcK6DkwcTwB/Cu6rqt/BsDJ1PUc7jpC+TZOexuW5m58pieM0ik0NhSy+BH?=
 =?us-ascii?Q?5Rf+m9v8qh8uG63UAs72eNLN6kRRXVl13pQmYgF/vx/bRlFS0nalVKTqZJwL?=
 =?us-ascii?Q?KA6O5WreDlO5LEwREDQIFQ14XTM8RYQ62TEYGLrRXryhhq5YYKXEposfwIUp?=
 =?us-ascii?Q?tDX5p4inaKdVRkx3XCe8NtWToGIEyIGPXPoPV5aMJ5P83XRybEL587dfyw4K?=
 =?us-ascii?Q?DATbIKNiE97IrGdyHBkcWIhWP3wnnKdVOLaXRlWxYFbd3JjYcg0fE+05YuoZ?=
 =?us-ascii?Q?vWNVl5SRkh6TaeWthSUqxPGoAa4q6BG2tAsDmIAk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa6100b-09bd-4bf7-206a-08dd558b2240
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 10:57:01.9567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJoLDqSySjFhZuaU7VYC+REyl/hvtrt0dhisxfC4PHYbuCRXszllwgFPO0qLbnLuR7CEGO15XLBmcGb8LlT98g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10452

> Subject: [PATCH v2 1/6] clk: imx: clk-fracn-gppll: Add 477.4MHz config
> for video pll
>=20
> Add the 477.4MHz frequency support that will be used by video
> subsystem on imx93.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

