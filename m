Return-Path: <linux-pm+bounces-37344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1E0C2FB4B
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 08:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB410189489F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C030BB9D;
	Tue,  4 Nov 2025 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k8ARP0Jg"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F730C354;
	Tue,  4 Nov 2025 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242282; cv=fail; b=XJNjkIhT0y9D+fWLU8+IWt3XgGCrahjOLrvxB0cgtFVex+ZpaoxIfIumJbfSFvc4rVCqGeueOHUNc0miCX9XSWlPXiCw4q/3RG3j+pAOebfu3DNY+o7M97drUu+5Ll2jt4v1+o4YoJm5QaiPD6tEcMOjwXW02Q/IQ9tGsa0JikI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242282; c=relaxed/simple;
	bh=5HEGpyD1dhOYIjRFXlGwvVrHQzX9vMpoRPvRZaFLhVw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ikuq6DNqSm0X/1owAmJO1wKbI+A9C8BS4vcklSTq1UEz7WE2uVy+1bNtcXAtA1qZ6DYKXwVqffVlhG4kmkN+iD0U/tSFHLupwMKIMwkseaJKYv04n+cKSzEE28kQ8V7fRIImmlELR0tvJ2ThssKjaHoHd3OILPigpPasRrhE+lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k8ARP0Jg; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlWwlRInjRKHs0vb9KL7rez7kr2tFpexdX6XWyDVT1HVVlWcaD7TNmXwMgQBQ1GhvOByKmmLQfQZbSoBSMSLL6BJD7cjviyv8R5g/H7Us3J8jd2u62t9W/j7iP8x5y3ggh2CiEK8hhcyPsfl10h/6dvCkUmcj4Q5n74bKUkSk/zArpwKlHmiXqiQmPwEZEWLCd7LEYvVGvIkTNyrmKl8TX+YoPk9wsrucM0cLiYXBtX1nJLAjbpcWs6aTuKZt7iuJF6tGZ5BJIc4snZeIgV7EEEI65pXyWyAmPKSGrTdpafKR9a05zzfgaKqGM5RvAsKFW98THlZP5+IDdsEPy9XnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVEtYUzD9V+oyjLm49VR5mGp7wu5yscW1ZiSYP7jJM8=;
 b=Z28Gl3aqKCmAKgjX7PK/NssymtEiKLK74tz4lSq5WfWYcYck2OFKVRY3lygCmPHOxdbjdTn5aWnuPXdrik74qYx9sWujRxe8hNXIhnapKz7PudoaQ/YtqbDw92IAlugoOx6/bqFk/fHd+kgd/TrMs41Ap9TZdaj/cYxqyieaqLLMAjV6AS0SIMLYUG7OBKWhxabCQ/DxiSz0CLUIgHTMPTC+cHESU9y1GBA/7l7MHPVg0ZCFBaWCXJPRTmKyeq0Dtj0S3MCA8Thsm0p3I9fFm+K84Yabxqmnzi+0SqKHLfBlGYm0dWkKII0H9cvXtTCgJdRuTRZ0iqxnSVvEbsvqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVEtYUzD9V+oyjLm49VR5mGp7wu5yscW1ZiSYP7jJM8=;
 b=k8ARP0Jg4vHdlGkCWx/80reaeoDrOqdkpWH9zN4ICOYUy9u08+/oIo5455tCAqO08vKYJE4VJ/zWXIKouQ1suPYWlnO3zwKJuiLkAR44Yf+AKYjiArI4a9yqxQzFMFwmUliVA2kHfkcoIcVrWFe1erwP9kuvLG2vdr8slAAZDGeCXZHx7GYT94kj8iqL3lc6zeoOeJumZX4KT1LuubGE0P6LRgenwaYXYNlwSsN8/w7XoMPZqUbiDikYR3KqPYDuhSSe0P0rwOiIRl5aQlPorDBaXFRd7V2CBEXz871qEB5jaZUdEJYwm64AxEVu7XdVBKiQFYMr/AI0a75shnNB0w==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS1PR04MB9501.eurprd04.prod.outlook.com (2603:10a6:20b:4d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 07:44:36 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 07:44:35 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "esben@geanix.com" <esben@geanix.com>, "john.ogness@linutronix.de"
	<john.ogness@linutronix.de>, "pmladek@suse.com" <pmladek@suse.com>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, "ryotkkr98@gmail.com" <ryotkkr98@gmail.com>,
	"kkartik@nvidia.com" <kkartik@nvidia.com>, "fj6611ie@aa.jp.fujitsu.com"
	<fj6611ie@aa.jp.fujitsu.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial
	<linux-serial@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux 6.18-rc4)
Thread-Topic: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux
 6.18-rc4)
Thread-Index: AdxNWDvvSHwf8ruwQWK/6o5sXxny8w==
Date: Tue, 4 Nov 2025 07:44:35 +0000
Message-ID:
 <DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|AS1PR04MB9501:EE_
x-ms-office365-filtering-correlation-id: 55cbf8e8-7d6b-4e00-832d-08de1b760052
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jKZ3GMfsoYGClV4fLtzfWRVs8xJwPZUkduJ1uxDoFUOXko3NhPjbMPAOLBvq?=
 =?us-ascii?Q?vi4Go9PRLAIaeFTuQZezg1cV6IkGEseQdaT16YiIJ2bUmktULFFjZJQ6yttp?=
 =?us-ascii?Q?H1uptRuN4+jWZvcZA1e2ouCVk9v+Ry3EwB72GBKD4RpVC9IT6ScpXlqeNXY8?=
 =?us-ascii?Q?jO1clURyn8IWlq5dl8a2HyORssITZHmERmTM9gV2DTNT5ZBbcz4UmjPzQdEo?=
 =?us-ascii?Q?kkzl/9lQu+WDJyWzNklXLFD//u8gzKfWO/mWdreHWsc/SMbqj9hVSIJjr5l6?=
 =?us-ascii?Q?rcsCdzKkoUXNy7BJoHLGHV/BnurzBwnOXqhEdbBZmvuU0p/tHRIbQOiJ099d?=
 =?us-ascii?Q?ud9Q5ul0JihguYJFyXiBXtlorStpzHEYXQICLfMRCybviuCyf+LDmyhZL/Ab?=
 =?us-ascii?Q?QTOKa2b34Kz0Uj2ig8cCTGBBmQRFDSrG2aVqzLCMfSclmLwthYgT6qNJnIE+?=
 =?us-ascii?Q?d1EiyK35Eecx8b4NswrGlISvS966Zvo0ZaNP5X1801b381rHH9sJq/uI+MZA?=
 =?us-ascii?Q?U8VuBuSw0H3gjnPpL7NaAFEuyGZFpsW4CbypzB537PC7BNfyd4SJs7j1LfDG?=
 =?us-ascii?Q?1hruHKVmA0SOYyUHK34gWWq7lvbQ6Hh1FFiyE5jkfL9Uy0cL7zP3p23id9Tc?=
 =?us-ascii?Q?P9C0JNjA3EKb6+Rn0ygrVg0dvNInIiMZuuwzaF57ju6lvItRSgGWgKAyK1BA?=
 =?us-ascii?Q?J8+H9zctuXuZ5cVmG4FTrKChzwZ3/CN8YxyQsXpn6lVkp8jAx9FTNjjd19z0?=
 =?us-ascii?Q?RShQG0TYYJqmJ/EWR2rX9mjg4qOj4AEcTpTUuD4gN8GR26fksUjhRj384Fm0?=
 =?us-ascii?Q?RbycA83jD+2c0zbsrSEbVCj2CV3pGHTjizEE6s0kbq7iouH1iPV7pXfPivA8?=
 =?us-ascii?Q?OwJRZJvxwWvzWsLrsbq7OE8kW6OtO5Dv7C+KXwNbXh8Uxwr8a1KGmQNdVKw4?=
 =?us-ascii?Q?uA/zmPcQc17ot8+IRymCoIZWcLn3O9otykY7OZCGHtyml/S5BbDNyLbsbqYY?=
 =?us-ascii?Q?MvmWrLHtd1lmTd7dG6hbkR/rLodAW4iVPcSY0K5V+32ii9GX02asjXuTpwcM?=
 =?us-ascii?Q?Lh3gaXUXCNvRV8BbpUMAaRpG3qI9KxnJh5eh6/c5cze//U96ZJMdzbWBzi5g?=
 =?us-ascii?Q?/7MOIjhu8BGs/hR1fSAJcd7SyfYx7MoHKbSU907vD2/EM8NIzGYMEunyOuQe?=
 =?us-ascii?Q?1XeMpilgz4RwXeCUCb9BojaoOlhJxqccdSqTGmvbVm/vimz39QvsiIpi26lq?=
 =?us-ascii?Q?YJNLwatHJjjXLHwBksjcFba0BBgAa0+vQEv/lmTHObnBpkZVteI0TT/JBNOs?=
 =?us-ascii?Q?QHpXy9V0kk8YoBhGShNsMDGFYpDXS7cyFLYD1xfpsKi/dwKmPRxaTkpe/S33?=
 =?us-ascii?Q?e5RSGuXGKmmug/FbftQHR4WOaNSf9mb+FaYEu8EQCD1sRVzOAbQN6PJyKRGL?=
 =?us-ascii?Q?8D7u6DE9aj2hMTiFLsd7gCGJVa0c4GMRrA1pv00Um7Pa1RCy/BXYOKXHPOQ7?=
 =?us-ascii?Q?H/xAlW+EYpGjuNo4qCPOseIk7HyILWkcBJI9Yj89hpFINN2+4RL6GL6pJw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Kco/O8G6DICWsDa7jsZh02dJ9k/uX6lg1ELfIrh+Mvr8qt8WNu0IR+BoEb2q?=
 =?us-ascii?Q?lMm+9K+AdXRri/s+X9k18W4bWIbhGGd34cgDYj3/qfz3wUi73Cu4NfPkjJIN?=
 =?us-ascii?Q?k847Yukefvo8NKfOFf/o3NiKDpyrVzyMe5Kr+uD72NSSerNTELQStnm949wK?=
 =?us-ascii?Q?ZczoLK8YgpDg19T7CanL6IAGL9fUPFgHJeqPdks4aghJMjqX+ON9C5ENXTNi?=
 =?us-ascii?Q?a0KIzfHArUGweABcIOv7HE1I+zoFrBXOzJaVS/less+nAvph2ly2y7rkg8rb?=
 =?us-ascii?Q?GztKDXPx1fK22BHulldeYh3TiVmWMsf55fApIjyaJ5mA3U9N23KXgnO2G+9h?=
 =?us-ascii?Q?A6OSWgWD/d34DiBggdTWeEpz52AT5arHgJvOFKbSVxTZs2ZqGs8Uyu0Wzp6H?=
 =?us-ascii?Q?Y8RN0aZUeRF9WweGrU+D/3FLI5ZXx9Af/MTFcWeE2pi86CCUobW9ZA098Uf6?=
 =?us-ascii?Q?tUdZYIXW9C4vBJNssGnQp8gi3b95/4AQxZ7/ztO9fpSrMf2U/Rl2ADX2SJux?=
 =?us-ascii?Q?gAskAQMMv7iE6NI+KGFTjosmxFZrJri+s28PMgM8ZrkDmTl2Ssbb9O2rxl7D?=
 =?us-ascii?Q?vc9chjxVyczC9dERnm01odf/CG+H55SrzD+6ffzdnQYAF+VbrTS896EIdGJt?=
 =?us-ascii?Q?Gdj3CTxqtMAXgziuvaet6q2e7OHRa62zDdhQYcNEd/xpwURgribNHzatvfUv?=
 =?us-ascii?Q?2C9o1iVUnHZdEQb91wRFQXk0/+AFzrzPaV8aC11ai2zjCqauvZvUifQyVn9A?=
 =?us-ascii?Q?/iRPEtUbgsJC8yjrCH9oYu8hpJGBfpA0C7kITxWZR+So2UCwkg1ddB5ZC+6V?=
 =?us-ascii?Q?Mq+BGwd+bdHHb9YekPlqYIHK/Nda7YnPrXS1hJALxpCfd1R0Lp+i3MQbGpvm?=
 =?us-ascii?Q?6biMNrRLgUWMWg5dWLwrlKkd78daKpoG9x6nfdrioqX+hfxlxf6Ai9w8vCWe?=
 =?us-ascii?Q?PoVtpRJvk3zu7JHGZ/ZBb3y3Ik0kKqIGT3/7/uytOa9YLYbu5M15If7AFPld?=
 =?us-ascii?Q?w9+K9f4FKN1Upkao6rhoL4UgH/IQ5SN/2VLkMVZ8cKvBRenGQtJvpwnC11So?=
 =?us-ascii?Q?e/MHv8CGtwCLVcHSt+/FFcg9n1nwmG0u5nBiH2BXqV2psTmESNMjxsdvSEe4?=
 =?us-ascii?Q?hacKnryPlXmzfCWOrw73BCg+Uv/MlUTkHTui1WJ5nBciaeSc2iaWP9tQRPri?=
 =?us-ascii?Q?9Tl2wY903dGYydKu0JpKbAtMV988kwjZyy7NcDZjVsRsU1YaF9lsMVR25GJk?=
 =?us-ascii?Q?Oo5mCE7hZ+lYNN6cBFOBCRV5z8J/Lo33ne5KKZ1zfrxWuqnPPG3SSpd2xNa2?=
 =?us-ascii?Q?2A8I+yiQAo/Y7a5+uGvCp1KEyjQXGTglu03DWlUvz8z1fD0P3flCdSgoQA2y?=
 =?us-ascii?Q?HeRWQlch9rceO1eqYxRUHnM5ExVmZIfeBXEcCkzZQcGzTsetTHtRozp9YdEH?=
 =?us-ascii?Q?xpLayI6XtKlTYKoFaC3c1pVCiOxdApTyhp209S9CpqonkAhes4RV+0MNyD5V?=
 =?us-ascii?Q?o8E+sE+fKjAUnl8jIDxWEWXtoOyM3pyEKvI0qQqMMsKjL8Ten1h1bxT/2MgZ?=
 =?us-ascii?Q?/TWdm5mbU0GlV5KQXA0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cbf8e8-7d6b-4e00-832d-08de1b760052
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 07:44:35.8253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o677VxHL3zQS3a8vd123l0lNwgKqjAoEnEFlhQzVCwowo2oRWKyBEQtTxR2GfUUqjZpiDVFhF6NBm3tzOrAehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9501

Hi all,

Since the latest i.MX UART switch to nbcon console with commit 70acca67bdd3=
 ("serial: imx: Switch to nbcon console"), I'm encountering a suspend issue=
 on an i.MX8MP EVK board while testing with Linux 6.18-rc4.
The system fails to suspend when both nbcon is enabled and `pm_debug_messag=
es` is turned on. When `pm_debug_messages` is disabled, suspend works norma=
lly. Additionally, if I revert the patch that adds nbcon support for the i.=
MX UART, suspend also works fine even with `pm_debug_messages` enabled.

The error message during suspend is:
    echo: write error: Operation not supported

This seems to indicate that nbcon's interaction with the suspend flow-espec=
ially when debug messages are printed-might be preventing certain threads o=
r devices from freezing properly.
Let me know if more logs or testing details would help. I'd be happy to ass=
ist in debugging or validating any proposed fixes.

Suppose this is not i.MX UART specific issue, currently the following 3 UAR=
T drivers also support nbcon console.
Hi Toshiyuki / Kartik / Ryo, if it's convenient, can you please help check =
if this issue also exists on your UARTs? Thanks!

drivers/tty/serial/sifive.c:907:        .flags          =3D CON_PRINTBUFFER=
 | CON_NBCON,
drivers/tty/serial/tegra-utc.c:512:     tup->console.flags              =3D=
 CON_PRINTBUFFER | CON_NBCON;
drivers/tty/serial/amba-pl011.c:2616:   .flags          =3D CON_PRINTBUFFER=
 | CON_ANYTIME | CON_NBCON,

The reproduce steps are quite simple:
root@imx8mpevk:~# echo 1 > /sys/power/pm_debug_messages
root@imx8mpevk:~# cat /sys/power/pm_debug_messages
1
root@imx8mpevk:~# echo mem > /sys/power/state
[   46.434401] PM: suspend entry (deep)
[   46.439474] Filesystems sync: 0.005 seconds
[   46.444008] Freezing user space processes
[   46.451855] Freezing user space processes completed (elapsed 0.007 secon=
ds)
[   46.451876] OOM killer disabled.
[   46.451884] Freezing remaining freezable tasks
[   46.453106] Freezing remaining freezable tasks completed (elapsed 0.001 =
seconds)
[   46.498122] PM: suspend devices took 0.048 seconds
[   46.505390] Disabling non-boot CPUs ...
[   46.511169] psci: CPU3 killed (polled 0 ms)
[   46.517174] psci: CPU2 killed (polled 0 ms)
[   46.523472] psci: CPU1 killed (polled 0 ms)
[   46.528669] Enabling non-boot CPUs ...
[   46.532891] Detected VIPT I-cache on CPU1
[   46.532920] GICv3: CPU1: found redistributor 1 region 0:0x00000000388a00=
00
[   46.532947] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[   46.551156] CPU1 is up
[   46.553907] Detected VIPT I-cache on CPU2
[   46.553934] GICv3: CPU2: found redistributor 2 region 0:0x00000000388c00=
00
[   46.553959] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[   46.554629] CPU2 is up
[   46.554999] Detected VIPT I-cache on CPU3
[   46.555022] GICv3: CPU3: found redistributor 3 region 0:0x00000000388e00=
00
[   46.555044] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[   46.555748] CPU3 is up
[   46.602411] imx-dwmac 30bf0000.ethernet eth1: No Safety Features support=
 found
[   46.604199] imx-dwmac 30bf0000.ethernet eth1: IEEE 1588-2008 Advanced Ti=
mestamp supported
[   46.606020] imx-dwmac 30bf0000.ethernet eth1: configuring for phy/rgmii-=
id link mode
[   46.713935] caam 30900000.crypto: registering rng-caam
[   46.714857] xhci-hcd xhci-hcd.1.auto: xHC error in resume, USBSTS 0x401,=
 Reinit
[   46.714867] usb usb1: root hub lost power or was reset
[   46.714871] usb usb2: root hub lost power or was reset
[   46.818976] PM: resume devices took 0.260 seconds
-sh: echo: write error: Operation not supported
[   46.819307] OOM killer enabled.
[   46.819311] Restarting tasks: Starting
[   46.820385] Restarting tasks: Done
[   46.820450] random: crng reseeded on system resumption
[   46.820553] PM: suspend exit
root@imx8mpevk:~#

Best Regards
Sherry


