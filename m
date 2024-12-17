Return-Path: <linux-pm+bounces-19357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227649F4015
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 02:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABA918865AF
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 01:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7CB29D0D;
	Tue, 17 Dec 2024 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G0pj4Kzz"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0878D1E505;
	Tue, 17 Dec 2024 01:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734399555; cv=fail; b=MNMt0P02SJAoi//jhDpHrPN5ZoDNZT8CrKwKsGLfyTqlVnSH9y1FjbrPbVg2gqMw8J8sBvMN0ay1iXO/3fCignvWveqDrWSXUxxUOd5NfUnib2/JXEnp0DVYf29cbA/WQa9McyOqElMr5/yP1Rys29Lyq6VOvUAj1hvU5Bui78I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734399555; c=relaxed/simple;
	bh=PGWFyfTx5fx7S6jVRUGuZM2cuG/bok39jmoTd10L7qI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AfKk76iZ9ybk/vkkKJPsxPwlpQR2ohvKkkMyqRJtg23Vb5PMPTOuhx8eDt8oziY7BecX+wNZkOzcP248VS21DPiu5oFqmuKt47EieGLQWcvP5P0Ve5NwfC2pAUbxKADZGMMD/uYJTteUGUrWm66UYV2NzmyStbMMPZXU4msvKwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G0pj4Kzz; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gw+lLSkdq0D0CmO85uxkRUiErjrPirneOBfc/AQc6RGA7EQcn1Iviygn0OWFVFsMm2y8flKqtfbZvXVoUfidQaip2aDOoy0YRf2yMK5Urb+dJ5xUukg2EF3qAdPn0s1FwZ97/2+KiVgrgwL+XOPljAtR99vDwr2DW8jM5Tb+Ub1PsI/w6zgcakrPmWVQgB7i0eETgr2tTJizsUEs7GHIymJY4pw+RF/wHMGa6HgToMY1oB3rs9CXdbqM7wKED5yqmhg5EY3UyQ293IYkEg0JFrWcE9unuVap0Pwb7wJMMOpSaUYAoRzgnh81jApcb9fmtJdmDnZvfqlYdv6mTqAtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDMF6371x8AX12sUJjPEz7eDDFdsX8Bj8aB4Fbtx0yA=;
 b=kgg+I/Z0Jy1RptqfaI8hRYY+asOM0scdyoKJUiW7zlkLbAqqgmkcqEQZg3AKK1gliTXnsHGruJl3uWoSfWIUpFo6QOjbM7HOgIiGP19X8QCKIPsZHDvofkkyVcT6199g/Di2Ix7mfULQHPLVxRRpvqQL6E+VK24u6zO+x9uNLfDKoZnujr9xl9aPMpOQl55BsJz7Ppp0VFPO/1l2uSw5iEv3lPAq4MzBoSX79fWjvxtAfpcoU6fmmMeok0v4dVSHgmwu5w9RJvmpFbd2JhcM136WeY0dlUGOgoRKWzkdRbrE2SEprYjQ5ehfxcIxXbuGFdj8QHzPyEKXLZABbgKuog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDMF6371x8AX12sUJjPEz7eDDFdsX8Bj8aB4Fbtx0yA=;
 b=G0pj4KzzgAs+xCoPI2equ8Rm80DOeOeTV50hDu11aL+tZe5OKqzJ5Ugx0h/Z7HP6VumcCLtKWmEa6EvuynGcWNtrKnMEX2XhN7TAGuS3v4fHCJmkR9MNXvJ0e75j+RbWH2T6iA+DLgi8RrRI/0eCxIqpYvb318/81SHE/bHeJ4vito3OjPHGNmOE8G2YfZUnOlrWPAJUiCvXbj24rCYT+5hs8dFaR5NCazD0fn/sra12Hvgd2z33nar95zJifSsKoHonaPL6HygAKfnyalIG5bkqPnPR18AFRoXhaj4pnbkYkq6C30Y1X9YSZJlS5qMjo+dCn8d+V7MyIkmaYs1vsA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6920.eurprd04.prod.outlook.com (2603:10a6:20b:101::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 01:39:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 01:39:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Marek Vasut
	<marex@denx.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>
Subject: RE: imx8m-blk-ctrl: WARNING, no release() function
Thread-Topic: imx8m-blk-ctrl: WARNING, no release() function
Thread-Index: AQHbTJ+Pcb8lP/0wpU2G6lPG/rxzNrLpr4/g
Date: Tue, 17 Dec 2024 01:39:09 +0000
Message-ID:
 <PAXPR04MB8459AB53B142CB43782757D988042@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241212141003.GA44219@francesco-nb>
In-Reply-To: <20241212141003.GA44219@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM7PR04MB6920:EE_
x-ms-office365-filtering-correlation-id: 17cd83f2-0fd0-4ba1-c1cf-08dd1e3b9a64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YjcsqIUTbToNpfUa7Dx54j88gP7VIjRnJKErlO2abbxIiVd3TsaZ0l9yN6RZ?=
 =?us-ascii?Q?4/rIjDGH1wOf2KhHA3FJbCsIjL6XPhoRuVnCT5+AZtsjPf5RNvvFusuVhg+5?=
 =?us-ascii?Q?nArGTDzBenvAH/S/WAnSycZyQ+8svAmQ7cflgcRF0ZAK1xovCaEO1w+8KDMF?=
 =?us-ascii?Q?38C7CsEcMRx/tuLYs2QWNCoeZ9lkqdgIFXsy0Mi0V0GVA3On+41udlzeVks7?=
 =?us-ascii?Q?PwGVVEc7BXBg9ddK61VDju7ojUKlv2Id5BVJfnthgXckNj/yo+nzBJtqZZHe?=
 =?us-ascii?Q?LwCPugbs3zfANTldWJS8n09y4DorA06fsSbDkNpoSf58qbIhR60+GBY3bRgG?=
 =?us-ascii?Q?n778svDO5JsKETXSebJgaesRySQcIzMMe2NGsS1BD3HZlSaB4Tu6Yub77AMA?=
 =?us-ascii?Q?LBEtjFPsgZE53GP4iePow8cYCWNubv29KCnaXlU3ii2jIluER5GJNcSPGF0c?=
 =?us-ascii?Q?dChRic1N2wMvj5J1tXgq64Tl7ribhzovFV+2e1Zy6kWB8zUJmGmH6TTCoYCg?=
 =?us-ascii?Q?UQSq3Po1uSBnv4kNo8MQTHJBjkbXg7ZU0RCbDEgYwvij9W0UKnHASSLukQEC?=
 =?us-ascii?Q?HLBn55wFxIdFfUdu9QI7Z7mlzbWzgKjMuvgWx1sdtwPP4sI1FU3F/+fBaDcU?=
 =?us-ascii?Q?X5z8a/bpn7qx7ySj6NJYk+oD72I9eJwqA6SbIYTShN03FEudwIKtWoLo/b41?=
 =?us-ascii?Q?PaXczXamI8pdM+a4CtEX7HvtgT8zSjfrFwHuf7G+N7y2ZcbMIcbOPnY+E9VH?=
 =?us-ascii?Q?jPiy+UiJJ20GnsjcoPfQYY3Nc3QjEgp3p+Bq8FpvRi16QkDFQW1/7T13XErQ?=
 =?us-ascii?Q?oZ61+CoFWBHbwQ56f7I5F8716V+TDGaSdwY5/n8VG3AST1tioLtwenMSbwix?=
 =?us-ascii?Q?BpfWBx3iUrTy3Pe1mOhO8C6iyOwLy85f0Gy/obz9+N1Alac85mrHr3i/c6Pw?=
 =?us-ascii?Q?FGDyuPVLwtG34B2OdajYQKvxPXwRk+WSgzi6TswwTe3YpsIHYrO2Moofj91s?=
 =?us-ascii?Q?Nj0mywIEys+UdbYsWZY5rjCO8aNSoS4uXjmWVH4t7eIgyq2fsGqHwCS4YUW5?=
 =?us-ascii?Q?BKXeWKdPo5rDy7Q17oxj2KC5TsdjFwMflxyHw+48ABnTfEIlbtnCG1rPHmDX?=
 =?us-ascii?Q?EjEXOCi2krhWpdOGHS8n4RRjOkMtsYpgtajeiU5FTfeBaP+RnWH8ePtYvOzT?=
 =?us-ascii?Q?THHA6Bl2L/D+qv0l88xh4d6inodwO19wdS7AtWn7K8sSfWuzYv9EIsA/SBmt?=
 =?us-ascii?Q?dZO+RysZzuxShfga1Tbu5oIJhgYmlpXnvdPoL3Q3LwvmoB/CdaHRrewLtBNT?=
 =?us-ascii?Q?ID4dssxtVjSpcQFUIsW2Imp97uRmde15+LYgYnh7lYyJO7EJoeHX0exwomgH?=
 =?us-ascii?Q?qb9+RZEtly8zkmciYYf72Tb4GeHoIcxFhPvIZe92Qe5jv25Cgo3g3ZUNpYx9?=
 =?us-ascii?Q?/b+KDxVLKLnGsdswYtWWSVoY0pIl8vkx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NYU31drTDnMR5rRfcxO22cqzoIlFtcqaZmBI8w72b9zyJwKG8kOPRqN77GSp?=
 =?us-ascii?Q?eX0RH/AP1s1vgGBC1WRt7WSF66JLnxi9iY9+yZ7PnOSrydx+lGgQI/gFqgGq?=
 =?us-ascii?Q?OF/H8a69izGMJ/Y9Di3o5CUnu4GR4kSWIzirw4dQmD/fmD8FzcMeW2wDid0E?=
 =?us-ascii?Q?Zu6PAEz6LVlqjzg0p4+6kY17zE5Pj6LJLmK2gJ8JnPW6qCirCYKNBCzu0V8D?=
 =?us-ascii?Q?uABxbsM3lzDRuepYyVzxxu6kvavSxbBHwrVV+VIh0wG55QTk70VoAcuDDIzq?=
 =?us-ascii?Q?EFBphAPQG1geEf3w0vlw54VZIaP7XIfotyiSCjO9KYb8DCj0OL0XkO2vCYWY?=
 =?us-ascii?Q?fFXYx2UJF8klPkteJjs3qwQ1q2S2tgGJ0lZ1yfygGWRjnzIGnZy0ysyFXvbJ?=
 =?us-ascii?Q?2YteHMybwnR9n14lg05OF5WgmA/YwnNnQFo26bPLlNYhNGTMd8JZKupVeb6g?=
 =?us-ascii?Q?IGvemBOsZY1aS10YdmXv+15DO6ruv6QYARhjAPNCACzxq8gi+HGWF0/5y5tr?=
 =?us-ascii?Q?O4NB5ijy3gAUDaOTGq5svJpCqD4R1DEazSG4cuL9bKBC1UChkYXnWK80FUd1?=
 =?us-ascii?Q?Hz6LaVcSuBm8uz8KBXzfjwvs0jLUFevAM8u6pnAMcXrLqB6xDnt/aara//gA?=
 =?us-ascii?Q?I3vFa3QEQAcn+BP5x5/u0inVhEuUWhTabvH+NKHoWPHDSePrT3fm44y6PAo7?=
 =?us-ascii?Q?3TTlH/4AuuMJ4HCC805StkLFmCt26UcdC0vIWa9WHSwvXVmkR1QnuKXHvhce?=
 =?us-ascii?Q?MdNUo4wMd02OiTPnhloox8Me4bDtkNzBDw8Rj20+jUn9H4A06bEemxFaE/oZ?=
 =?us-ascii?Q?YOjeAOwJLrFzSuldye2ihXl3ci5XacPCcWMs2fZ7I/4KoKIeKW8L4t2aT7vj?=
 =?us-ascii?Q?kWwo4bAUMIFejwFokIV2L7FE5KvsGQ+c9NE+gFbOXpZR/nwaKrf9r/RAWt2L?=
 =?us-ascii?Q?sSMTvlNzaOE32vKMsSrrBksPSNZeTa61yxRmLwuillZyl090l2IwweLcUyA1?=
 =?us-ascii?Q?eipQ8hFXDxOJopwkHkglGCFFtYRD7BJqMkb5IHVc0J9+tX3wSqM9pz6q2jw+?=
 =?us-ascii?Q?dgbqvVOUcROBu/sP488NJ1V/S573j+Ughh4Dh/BmQ6xjsDT1etSPoNO9baV5?=
 =?us-ascii?Q?1XxI5bUdRuOx57D9ezMBRjDHm/Q9HQhSM/d0MqOVyNTYD5g19HvR6HIgqlxE?=
 =?us-ascii?Q?osbdV93/EQ2pjII2dLjQwduG72u4hMkjs6rXLUdfUMHXcwLalD656ImrjaLA?=
 =?us-ascii?Q?v1yo7X3E4KxWW1SwuYC4xcjF3hbwL4KPRvJGu6huVUZGhkteHfsLGUNis+0B?=
 =?us-ascii?Q?2Hxgl09NeJH0PxARtrMEZAvCypAkX4xiR8VyVtd/A81bR4btYubV9ve1ghyu?=
 =?us-ascii?Q?A8VbtWLrlCS39dIN74omWwygd5yFzyVBdsIc7wwrif1bpooh4lM5v68ZTFKt?=
 =?us-ascii?Q?kFsy33dCD13xLpn9nZ9G+WE2GTxbZa+LMn0LlvstOgHqUQzrNWZJjcmexVum?=
 =?us-ascii?Q?fYMh/GfzYCVW3SCuXfMIDZsc16bjmZmESPZai3pyRNvc/E8YLOHj+gUf46gG?=
 =?us-ascii?Q?C/aj6p5XA3nwe4sPsIU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cd83f2-0fd0-4ba1-c1cf-08dd1e3b9a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 01:39:09.8359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zjxww0K35B61NjHHTEfRHce2fYOgZ1zl0ZTIBXO40Txohu9HRyx+hm6N9lgnwCjIs9QZgGwGoI3Y1w4xCvMbTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6920

> Subject: imx8m-blk-ctrl: WARNING, no release() function

Please try this patch.
https://lore.kernel.org/all/20241206112731.98244-1-peng.fan@oss.nxp.com/

Thanks,
Peng.

>=20
> Hello,
> on v6.13-rc2 (PREEMPT_RT, if it matters), I have the following warning
>=20
> [    4.615793] ------------[ cut here ]------------
> [    4.615814] Device 'mediablk-mipi-csi2-1' does not have a release()
> function, it is broken and must be fixed. See Documentation/core-
> api/kobject.rst.
> [    4.618977] WARNING: CPU: 1 PID: 11 at /drivers/base/core.c:2569
> device_release+0x80/0x94
> [    4.638974] Modules linked in: ecdh_generic ecc etnaviv(+) rfkill
> libaes samsung_dsim gpu_sched imx_sdma(+) governor_userspace
> imx_bus dwc3_imx8mp spi_nxp_fspi lontium_lt8912b ina2xx
> snd_soc_wm8904 ti_ads1015 industrialio_triggered_buffer kfifo_buf
> lm75 snvs_pwrkey pwm_imx27 nvmem_snvs_lpgpr imx8mm_thermal
> caam flexcan error can_dev spi_imx usb_conn_gpio display_connector
> roles gpio_keys fuse ipv6 autofs4
> [    4.639073] CPU: 1 UID: 0 PID: 11 Comm: kworker/u16:0 Not tainted
> 6.13.0-rc2-0.0.0-devel-00040-ga1625b19385c #1
> [    4.639082] Hardware name: Toradex Verdin iMX8M Plus WB on
> Dahlia Board (DT)
> [    4.639087] Workqueue: events_unbound
> deferred_probe_work_func
> [    4.639099] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> [    4.639107] pc : device_release+0x80/0x94
> [    4.639116] lr : device_release+0x80/0x94
> [    4.639122] sp : ffff80008142b910
> [    4.639125] x29: ffff80008142b910 x28: 00000000fffffdfb x27:
> ffff000005c92180
> [    4.639137] x26: ffff000000018028 x25: ffff000000046dc0 x24:
> ffff800080c43710
> [    4.639147] x23: 0000000100000001 x22: 0000000000000000 x21:
> ffff800080e43750
> [    4.639158] x20: 0000000000000000 x19: ffff000007cb06d8 x18:
> 0000000000000006
> [    4.639168] x17: 0000000000000001 x16: 0000000000000000 x15:
> 0000000000000002
> [    4.639179] x14: 0000000000001400 x13: ffff0000000a9110 x12:
> 0000000000225510
> [    4.639190] x11: 0000000000000000 x10: 00000000000009c0 x9 :
> ffff80008142b790
> [    4.639200] x8 : ffff00000013bba0 x7 : 000000000000002d x6 :
> 000000000113158e
> [    4.639210] x5 : 00000001134e0800 x4 : 0000000000000002 x3 :
> ffff000003b04c50
> [    4.639221] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> ffff00000013b180
> [    4.639231] Call trace:
> [    4.639235]  device_release+0x80/0x94 (P)
> [    4.639245]  device_release+0x80/0x94 (L)
> [    4.639253]  kobject_put+0xb0/0x214
> [    4.639264]  put_device+0x14/0x24
> [    4.639272]  genpd_remove+0x114/0x248
> [    4.639281]  pm_genpd_remove+0x30/0x58
> [    4.639288]  imx8m_blk_ctrl_probe+0x36c/0x540
> [    4.639299]  platform_probe+0x68/0xdc
> [    4.639308]  really_probe+0xc0/0x39c
> [    4.639315]  __driver_probe_device+0x7c/0x14c
> [    4.639322]  driver_probe_device+0x3c/0x120
> [    4.639329]  __device_attach_driver+0xbc/0x160
> [    4.639336]  bus_for_each_drv+0x88/0xe8
> [    4.639346]  __device_attach+0xa0/0x1b4
> [    4.639353]  device_initial_probe+0x14/0x20
> [    4.639360]  bus_probe_device+0xb0/0xbc
> [    4.639366]  deferred_probe_work_func+0xa0/0xf0
> [    4.639373]  process_one_work+0x148/0x284
> [    4.639383]  worker_thread+0x2d0/0x3e4
> [    4.639391]  kthread+0x110/0x114
> [    4.639399]  ret_from_fork+0x10/0x20
> [    4.639409] ---[ end trace 0000000000000000 ]---
>=20
> and more for other devices, from the same driver.
>=20
> Just reporting for the moment, in case someone has some ideas or
> wants to have a look.
>=20
> Francesco


