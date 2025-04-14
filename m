Return-Path: <linux-pm+bounces-25343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52465A877C1
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 08:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B963AE694
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 06:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2571319DF5B;
	Mon, 14 Apr 2025 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SdOUyh/J"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F8E191F95;
	Mon, 14 Apr 2025 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610995; cv=fail; b=GQcX9vcAi+Euqq+JzZGGVUScTpAOfQfvhmPN7c/AocF7zWi2i6rxoi7Ha9D6f0jx7k9C7SgDvbl/q8Rq4llayr5DAMEIpfo56aYTmzb+7A83VKorW/iTZtA814nXIds7GKfVqx/E2+vUs/ULOaXBOSjarmogHWZhW7/K+GzlL6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610995; c=relaxed/simple;
	bh=YdhsN156COUWlk9uFSm1pMbi6H3bQi1TYhehQMeANCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ohCMGJWg1sjg0nCioCS90Dc6419OPansr6wu/cpgP2hILzD8huhN6hcvWVifyTJdIo7GJmKLvVfHRWawxlpt+iV8ANNnpjNHmpwPKdk0ZQ3atAGDeehzXDOsdstBUbtUihn/6KVg8ynCdfGzIgJad+5XgtqwrqciMqraWuHAJBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SdOUyh/J; arc=fail smtp.client-ip=40.107.104.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XymWrqTHsEGaPNg+TRN8iUgwR0bjFntFTL9u8rq23DpV9blLKIEXgrg2jfk2FDlme8KXPtMINn3uw3afnL05iMQ9Zx6x5dYP8QsuWj/PwnhCdzzI8ApNW53WCvaZgTBl9acrIQOgVN5oa18lqKCotWVV+rRpcZE/B/v6UexpYRGn7JdmotIlnxSTf+0oP5JMU8Hc75yOD4O88uYx8G5qPN8yiS0iQRp39GNXinYf91jkmmHXDyTYE+ODMWAGflS/kBwe8buSyYFaLAkxgchepF/tmp8LdYqsEwmCXgoL1XGvZy+CdXV0BhYzcAQfXv3q6eUr6bAP0hJtROvrMomj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVAg16JVCAiG9MQW0qpPpwc3/MP7bc75m1yF5eeUErA=;
 b=cZT1slbWvsqiAgJ+qVY/1T+7UBEtPud6KeDUxTZVj8/sdnJ1K3HUNhCPfkSSNb7z7YylRoV7ukNJyp8XP4dx+B2Y1kypy0Xcvo8D4NLPz8mlKDO+8KVe4oY30Ie/86gy1dfQ6ke08wI3ff1kjBW/a5089zdjBkiBiGfvaSgB6XYGqOajiI0+lRxSyV7ubuquVuA2u8GQzXrnXnqTVVbAY0dM7TXxxZbEr3E19nTjZ/MxM/LF7W2KFvfnr3wMgTCfOE1/4j/P0HqfP4redMECQxIi4RBQtCQMH/Sz4hxZr6ZMY44sAOZ4Tfcyt86VVX19krmuMFtk/8xp2OipA1iHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVAg16JVCAiG9MQW0qpPpwc3/MP7bc75m1yF5eeUErA=;
 b=SdOUyh/JHtr7W7hVpk6tLXHFTuZB1r7kyZvvQfhP0P6+Wad2Jc7eBvFrV0hrWvjxdw2K3efvb2owzIII/tqL59V4olDloccHUSJUuYR7zUvrJDFvVrAQM9M0yZOG6t6Y/XHv78rFijRilUxNlWkCKIwWgtaEvg+0fDlO3ephT1YqHuOa31DNoGefLteFi1bqDCqAf3svVfheWiI17gde7xCTpqW7Ev58SoTJWiZCCxpUZbNYxvA7wXJerD30aS/mM7RJTsiVgLKfK/1Tjp50oqCCHPWWKMtd0+ys63HdqnXHIprsz1yTCipMFw7szGIKXXhJSxj0Bg+spmElc65sAg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7221.eurprd04.prod.outlook.com (2603:10a6:10:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 06:09:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 06:09:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Hiago De Franco <hiagofranco@gmail.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, Hiago De Franco <hiago.franco@toradex.com>
Subject: RE: [REGRESSION] Kernel reboots unexpectdely on i.MX8X when Cortex-M4
 is running and it was started by U-Boot bootaux
Thread-Topic: [REGRESSION] Kernel reboots unexpectdely on i.MX8X when
 Cortex-M4 is running and it was started by U-Boot bootaux
Thread-Index: AQHbpWxIyVwHrK1A2UqE7zPASmzQ0LOedbwAgAAHyXCAADO/AIAECmYA
Date: Mon, 14 Apr 2025 06:09:49 +0000
Message-ID:
 <PAXPR04MB8459ED33238AA790252E730988B32@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250404141713.ac2ntcsjsf7epdfa@hiago-nb>
 <20250411125024.i2pib4hyeq4g6ffw@hiago-nb>
 <PAXPR04MB8459ED6CE869173D4051257088B62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250411162328.y2kchvdb4v4xi2lj@hiago-nb>
In-Reply-To: <20250411162328.y2kchvdb4v4xi2lj@hiago-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBAPR04MB7221:EE_
x-ms-office365-filtering-correlation-id: 5f00f20e-aedf-421d-1612-08dd7b1af6b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GS08y8v7Bj0UdXM+YFZgacSaOkA5sDgnlGJqMejUa8p8q8g5Bu88WgfGafZ1?=
 =?us-ascii?Q?ZL6bVtyG5X3MQsar34vxEALXIOCZNmAgDMVRPmxlKYSDYdeN2QTWHapsWf16?=
 =?us-ascii?Q?R8CWEFKjV/QnQ0H7QT4+FpeKvbLjsA5TMWP/7eOWp3rp/XYixwUqOxX3RwZZ?=
 =?us-ascii?Q?TjtFOuZYOZsPT1rlFdc2bFZl6W02DhhTKu+R3/YNn6MSFxRkcfMqpfSNHjZ2?=
 =?us-ascii?Q?28AilgMDfl27LJFOyRP6dBJElJV9lWdp0SV1UstzCrklv7WVbxsrSVrD2p0S?=
 =?us-ascii?Q?8MOIZ5M0e03gw13NewoZoQS4/B0GY3zGFS0DpMxJwIkamb2Ip56eqcJpjlaB?=
 =?us-ascii?Q?AXVttCJyTl6lXxdm0kuHIWlFJKrFJjBUtkvLuBWs3SisK/wEtlqAHQeQj6ZW?=
 =?us-ascii?Q?v5Gq7AtQH+KH2QI2R5ZDXPYnW5ZNZxA+QfV1WlTP3WR/UJIv4QSYqLllKfkj?=
 =?us-ascii?Q?nJo9oE/rbn4obqcmsF3DAC0yBwP4xqPnGQpE+FPqiNhdDx76gxSzau76jk28?=
 =?us-ascii?Q?82pArh+qi6bkXElHUOZLTBgBGaBuHIzzJr9t5GUlu9UYUuFV3gS+ASrPTZla?=
 =?us-ascii?Q?muYpJQEQulDT1FUOaszMt0UshDEKt+IDFxjTFr9IpeOHuEL31uV5MWw3DEJf?=
 =?us-ascii?Q?qBLt1stkEyoOXaV4eJrDT8gRZRqbi7TSiU9SmcMzCzldicwEQ/zgU9YdgqCI?=
 =?us-ascii?Q?lcL1Xl2uQP43yZoE3uTQZV71kzv/1gPj1unSOwXomQN3N/H8fyGL62kyo5cM?=
 =?us-ascii?Q?lHcA0G8dNNRk948yjAb0apKR5q4BBMuVjtHvfTJsG2a9fhbco63Yh2479Ton?=
 =?us-ascii?Q?pEoXGr6rpGJxQXE9EoTSF96XA6R/jtniDCA8ipu/5U78lPjP1DPwzymbqNpv?=
 =?us-ascii?Q?zgiDjNZdy1M7iFAN2YVYyJ8w0evCUVBi92FetWiWczSVgr8k0F5iQBW3LWnx?=
 =?us-ascii?Q?jv5uMYs2pPX6n/HAG/nNOP7pGAcOxLOpgRc+YGQSA/YP3TjoeBENhzpyOkaw?=
 =?us-ascii?Q?3dUwROFtHzw810cyG1JkllrqlPt91kgUneJ4S0UoaqZL5FUF56H/twXS3uar?=
 =?us-ascii?Q?SMUh58PraJGyWnN4CqNgcGIP+SLVEeUSwEPEmQU1Wxelzsa2aTC6i81u3Hxv?=
 =?us-ascii?Q?N6kZMmJWX+gV/tG2qZ8F1mN8rcI85fG0b5cfL8f85tSt74oIahicAC1o+C/3?=
 =?us-ascii?Q?ExIJ+2nC7pQq0YqJTgZ2uT0Y0dwJ9UKO7zjmMm10Vhpjggn1U64ZdWctKsio?=
 =?us-ascii?Q?C/OqnU9py5DFecIUWJwbl48TYO9ECEvGSYeAYRsz5wDFjiipPRnK1dAKcYdM?=
 =?us-ascii?Q?z6kZ7MgGTC3cz/WPLn7zqLxtKpKAqCQUH/CUuNQHS7DUOJuQi8668e6jvp9m?=
 =?us-ascii?Q?x8i/qa6Q4zdxFckfogezEk0Df6iteyrYD+23c2exkzjXfCYi3IzMd7esA200?=
 =?us-ascii?Q?bsw+JgiGO4OQd/71X6BJ5SYOZs8vfbH6yhKmUePPfLoFzZ6cHxq7zw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f/CQh87NgFmyD4RNKR5C5yawiDxo9uNGpbkRlEcESP66JGZk0/bQNsrUDy0x?=
 =?us-ascii?Q?lvURllKdvMBdJBxFa39zjA1prJ1WlbGGK4HmXuZYLEvlRxnMlOuXAL71pR4Q?=
 =?us-ascii?Q?trNDYfpERXgoKqPJ56ae+nlf39/rsPOenJLUJD0iGQk3i9nijeYmNN/IU3tk?=
 =?us-ascii?Q?nx4OOguA5BVkLSMgmCe6ctUClK58m5LabfMP/rjccEkg6/D1CcfoYHOw2EUP?=
 =?us-ascii?Q?0546JWZ/OnX9O9DzQ9HXv9nQacwiWkI6Q8Pw5mK3rO4YSVcs1UJJMnoZnZUe?=
 =?us-ascii?Q?TSYrNC9zioFdiGWAaVKEIHe4YytVlHOUQ9J+nVwygoOgiehKE/oax3uwv61p?=
 =?us-ascii?Q?XP/rPMkWgwEGRVipNwb4v+UGyYnybtypghuQ5KowS80YIY0fye+cpWATDB5H?=
 =?us-ascii?Q?olqMUahJHoBGN53hqZQ8QC5/YejENqTlMIlJB7iuLSQ6yNo1s08F7w0mfESo?=
 =?us-ascii?Q?szFV2wBzUn6AgdkZHPqDNpC6woRotf0AdtUIH5Nl1adXKBH+D3pHfErVuUEB?=
 =?us-ascii?Q?0zrvsDTtowwCLM6Wrunr9Z+ck+/tqV7XBsUYg31cZt2GbEI+BnnAsFzwu31d?=
 =?us-ascii?Q?2HeeIVVWquWfRuMMYiZy4ZaVdIoSpSl3LR0LUMbAZfqRoqDIBDaM5pEZ2ZrI?=
 =?us-ascii?Q?b2hyr7n3V6KFAAPwU4+S9NFel0BXxudKYzwwMdw7MzKjxmUVLhxiLGkBQe8m?=
 =?us-ascii?Q?sgI9dugMIg5ojmZg5vsCbsxtx924HF+TEoHDKAYmpz4mu2XO4Krtvyv0vK5+?=
 =?us-ascii?Q?C/7Fog9Kbj2tZNQGBHtr9BhT9HOlJLk7EudIcwtNsFBJ5gY6G61xm2GsAUhG?=
 =?us-ascii?Q?ovO5CS9a1gD2ZNHP8IFQoi2CELqliX58ZljFqDhrnCnAAOv1E9B/xdkzy8s+?=
 =?us-ascii?Q?tH8dafQLz/k+Etq/IkNe4PpWMAxQWwd0zuEgpyet72FpfxGK687C96veoEXS?=
 =?us-ascii?Q?OmgV7+AmBFMsk4lrEVSiNjpvLg4zDc533/0/wp0/tS2qvFH/4rFAQs0Ggvuf?=
 =?us-ascii?Q?n3SagwI7srAwFaY6ebn2gaseX4NAOizVANpJfYpdFEXisc7OuHcetVL6fV2L?=
 =?us-ascii?Q?cJNnUZP2j1uf2wfbhMaxPwamdKoweorwDJJHDdA3ziYShnvRT4ww+LzqihSd?=
 =?us-ascii?Q?gh5CZWFRiojU6Y75+E9Fs5vX78knhOkZY96fjW0bWTEgk3txTaG5lHDuup8i?=
 =?us-ascii?Q?qPR4o4ErRycV7apfNRCfnvk3wXQgBdqVIXsd23K0Z3X3Pw9R6KnU+nkIJWhE?=
 =?us-ascii?Q?ouHLIanIHsJ4mlA1pbRjy3NrIErROsQhGdJLl44LjTV18RSGqlEiSeKkDm80?=
 =?us-ascii?Q?54uo/3NZVPl3NbQ6AUTVpxgLFQgT7fRGzhsMDXT6HhiyxBJNyOdL4m/GJOpQ?=
 =?us-ascii?Q?CjcldavTgd/qLT2IawW9pyevSZxIKov91DmqUTOgQMUINXwV3pFkDG3yD2EN?=
 =?us-ascii?Q?XnjX1/Rao3wD6SMeOuiKtcxNA1uUB1adq0fvO0adngp7fVHiThzHUVliVoEU?=
 =?us-ascii?Q?K8NctyEe30U5cmrC9B04hmHpaDLOFD7t1/OLmCoc4hAk9Dz9NsrrxDMDjFaU?=
 =?us-ascii?Q?sawUbO2t86e9VRQPUaY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f00f20e-aedf-421d-1612-08dd7b1af6b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 06:09:49.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3teFmPanowaMfJr698OjANhcCST/M/nnH0OyO5KbIfZEUrbxf3c7BBqerVQQ2GAXtQRXjaSy2+qklszAiTmztA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7221

> Subject: Re: [REGRESSION] Kernel reboots unexpectdely on i.MX8X
> when Cortex-M4 is running and it was started by U-Boot bootaux
>=20
> Hi Peng,
>=20
> On Fri, Apr 11, 2025 at 01:23:32PM +0000, Peng Fan wrote:
> > Hi,
> >
> > Sorry for late.
> > > Subject: Re: [REGRESSION] Kernel reboots unexpectdely on i.MX8X
> when
> > > Cortex-M4 is running and it was started by U-Boot bootaux
> > >
> > > On Fri, Apr 04, 2025 at 11:17:13AM -0300, Hiago De Franco wrote:
> > > > #regzbot introduced: 4f6c983261
> > > >
> > > > Hi Peng and all,
> > > >
> > > > Commit 4f6c9832613b ("genpd: imx: scu-pd: initialize is_off
> > > according
> > > > to HW state") introduced a regression where the Kernel reboots
> > > > unexpectedly (without any warnings, crashes or errors) when the
> > > > Cortex-M4 was loaded and running by U-Boot, using the bootaux
> > > command:
> > > >
> > > > # load mmc 0:2 ${loadaddr} /home/root/hello_world.bin #
> bootaux
> > > > ${loadaddr} 0 # boot
> > > >
> > > > This is a simple hello world binary that prints a message into the
> > > > M40.UART0 pin (demo from NXP MCUXpresso).
> >
> > Which release is this image from?
>=20
> This is MCUXpresso SDK 2.9.0.
>=20
> >
> > > >
> > > > Before this commit, everything worked as expected, Linux boots
> > > > fine and the HMP core keeps running and printing messages to
> the UART.
> > > > After the commit, the kernel reboots at the beggining of the boot
> > > > process. The only relevant message is printed by U-Boot after
> reset:
> > > >
> > > > "Reset cause: SCFW fault reset"
> > > >
> > > > This commit was bisectabled, the same device tree, u-boot
> version,
> > > and
> > > > SCFW versions were used. Reverting this commit fixes the issues.
> > > >
> > > > For testing purposes, I created the following patch which also
> > > > fixes the
> > > > issue:
> > > >
> > > > diff --git a/drivers/pmdomain/imx/scu-pd.c
> > > > b/drivers/pmdomain/imx/scu-pd.c index
> > > 38f3cdd21042..0477b3fb4991
> > > > 100644
> > > > --- a/drivers/pmdomain/imx/scu-pd.c
> > > > +++ b/drivers/pmdomain/imx/scu-pd.c
> > > > @@ -539,6 +539,9 @@ imx_scu_add_pm_domain(struct device
> > > *dev, int idx,
> > > >                 return NULL;
> > > >         }
> > > >
> > > > +       if (strstr("cm40", sc_pd->name) !=3D NULL)
> > > > +               is_off =3D true;
> > > > +
> > > >         ret =3D pm_genpd_init(&sc_pd->pd, NULL, is_off);
> > > >         if (ret) {
> > > >                 dev_warn(dev, "failed to init pd %s rsrc id %d",
> > > >
> > > >
> > > > Test Environment:
> > > > - Hardware: Colibri iMX8DX 1GB with Colbiri Evaluation Board.
> > > > - U-Boot Version: 2024.04
> > > > - U-Boot Build info:
> > > > 	SCFW 83624b99, SECO-FW c9de51c0, IMX-MKIMAGE
> > > 4622115c, ATF 7c64d4e
> > > >
> > > > The issue is not present on: v6.5
> > > >
> > > > The real root cause is still unclear to me. Anybody has any ideas?
> > > > I am happy to share more details if needed.
> >
> > Have you tried pd_ignore_unused?
> >
> > I think it is linux power down M4 which M4 is running, then SCFW
> > reports error. So please give a try pd_ignore_unused.
>=20
> For debugging purposes, I tried it and it works, kernel boots fine with
> M4 running and pd_ignore_unused parameter.
>=20
> >
> > If this is the case, may I know do you have m4 nodes in dts and with
> > power domain included?
>=20
> This is the device tree overlay I am testing:
>=20
> /dts-v1/;
> /plugin/;
>=20
> #include <dt-bindings/clock/imx8mm-clock.h>
> #include <dt-bindings/firmware/imx/rsrc.h>
>=20
> / {
> 	compatible =3D "toradex,colibri-imx8x";
> };
>=20
> &{/} {
> 	imx8x-cm4 {
> 		compatible =3D "fsl,imx8qxp-cm4";
> 		mbox-names =3D "tx", "rx", "rxdb";
> 		mboxes =3D <&lsio_mu5 0 1
> 			  &lsio_mu5 1 1
> 			  &lsio_mu5 3 1>;
> 		memory-region =3D <&vdevbuffer>, <&vdev0vring0>,
> <&vdev0vring1>,
> 				<&vdev1vring0>, <&vdev1vring1>,
> <&rsc_table>;
> 		power-domains =3D <&pd IMX_SC_R_M4_0_PID0>,
> 				<&pd IMX_SC_R_M4_0_MU_1A>;
> 		fsl,entry-address =3D <0x34fe0000>;
> 		fsl,resource-id =3D <IMX_SC_R_M4_0_PID0>;
> 	};
>=20
> 	reserved-memory {
> 		#address-cells =3D <2>;
> 		#size-cells =3D <2>;
> 		ranges;
>=20
> 		vdev0vring0: memory@90000000 {
> 			reg =3D <0 0x90000000 0 0x8000>;
> 			no-map;
> 		};
>=20
> 		vdev0vring1: memory@90008000 {
> 			reg =3D <0 0x90008000 0 0x8000>;
> 			no-map;
> 		};
>=20
> 		vdev1vring0: memory@90010000 {
> 			reg =3D <0 0x90010000 0 0x8000>;
> 			no-map;
> 		};
>=20
> 		vdev1vring1: memory@90018000 {
> 			reg =3D <0 0x90018000 0 0x8000>;
> 			no-map;
> 		};
>=20
> 		rsc_table: memory@900ff000 {
> 			reg =3D <0 0x900ff000 0 0x1000>;
> 			no-map;
> 		};
>=20
> 		vdevbuffer: memory@90400000 {
> 			compatible =3D "shared-dma-pool";
> 			reg =3D <0 0x90400000 0 0x100000>;
> 			no-map;
> 		};
> 	};
> };
>=20
> &lsio_mu5 {
> 	status =3D "okay";
> };
>=20
> This was basically copied from
> arch/arm64/boot/dts/freescale/imx8qxp-mek.dts. Do you see anything
> wrong? Should I also add the "clocks" property to imx8x-cm4 node?

In your case, m4 is in same scu partition as a53, so m4
power domain is manageable(owned) by Linux.

However to m4 earlyboot(kicked by bootloader),
if you not wanna linux to handle m4, use scu_rm
to create a separate partition in u-boot.
If you wanna linux to handle m4, but not wanna linux
to shutdown the pd in kernel boot, imx_rproc.c
needs to be built in, and need to add a clock entry
or use clock optional api in imx_rproc.c .

Current imx_rproc.c needs a clock entry to probe pass.

I think in your case, this driver not probe pass, so the
M4 pd still get powered off.


Regards,
Peng.

>=20
> >
> > Anyway, I will give a try on i.MX8QM EVK.
>=20
> Great, thanks.
>=20
> >
> > >
> > > Hello everyone, as this introduced a regression, should I send a
> > > revert for 4f6c983261?
> >
> > Please wait a while, I think we need find root cause.
> >
> > Thanks,
> > Peng.
> >
> > Or any ideas that might help fix this issue?
> > >
> > > >
> > > > Cheers,
> > > > Hiago.
> > >
> > > Cheers,
> > > Hiago.
>=20
> Cheers,
> Hiago.

