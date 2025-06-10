Return-Path: <linux-pm+bounces-28419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F008EAD447D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 23:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F19177425
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 21:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3926326980E;
	Tue, 10 Jun 2025 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qq3DVsee"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011014.outbound.protection.outlook.com [40.107.130.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2423ABAD;
	Tue, 10 Jun 2025 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589906; cv=fail; b=T94tXxd5syK1vvHwsL7r9rPzEaDXryAcX5gU6W8erN/9iNAeIFa2k0Hmmfilirk82dR5rAvYW9kiQQ6PO8jWbdlgTOcvlZ/SP+zsKIThPkjOxXI3pxjB3zoiJC0YgTaUMC0iuHI19OabuUn7fQqjVraxUIphkn5mmRGYk7dAUkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589906; c=relaxed/simple;
	bh=TJ14TzweCu85pHhTyR2d5AykvRpX7oDv2mKeW8YHvLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dauuBQ26WG2w1kzVyylS4EiIbRSPoBUo7sjQN2pU3RSxQqTLZGr3DRURknt2fgaPqlB+OtWQmt+Z4Y0W2XK+ICmoHncQnm3afxOLpNCICrp8iNb/GlhCumqsjP7l5u7HCGsnFapG06tADCatfGhMKiLzNhxkLI/ZrOmyPuCmeUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qq3DVsee; arc=fail smtp.client-ip=40.107.130.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6OO9KSWn2k5zgqaOPdilXKXMpS+R3gM+m3+vFdWJxrrRGIhXIehFiyVutPccsl5vhvZPONSHSnE0QUlMD8gF9DGqHuUmPhQYwdeHknXSWhzHgwRjgHTQRKdZ4ZW7y+SpZkccn7fjNASZOCNkt3zZGDKPh/9azBabf/z4wuIyl2cSUhVFttRS0k8sxD04i/09Ix64WBk0lVL6+pUsBsgKXBySmf5zytYfHfEsqkCGx89ObD+kYq5/xKe+6miOk9XMLPNLSWVtZT0sj8NhvKaihXSbdlyRRghqQ/wrW2pV1Dcec1eB6qZY7JbAWivzTPQCdGo8/56M9Wa/Z5AMpbgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENa/w6/rQgxETjUh12B53GAqs1lK3mc3SFkeMf8feRg=;
 b=ft5WJje5B6CP+KZ97EU86PkC6kGRHsgKol/RY0qqVS/KbXdoonqfodqQ3rzEm/uv11PCi4dAod10rKLm8HXgjn8GloK4Mgta3zpIGz/Olad/OOlKEMVzWJDaeelpViz050mSt7Mo8DjfrCRWy5LyEkO5xHn0mIhXvzySDaugQtT+AulQLOYjciU0sz9CjXxIt92u+T4dKrWy+7A+uXnhel7L6rmPQp7ZTVDKyQitaLbdgg6RKFXPJQSCYOZnZOZhLcXc1PkMJsOm2AEEdsW+XcrUD/iYmOzpzRrhmOg6Hl0wIzAHWMfb2SHxDp9i8S06k+gkwkWTgxsW4Oa/otDpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENa/w6/rQgxETjUh12B53GAqs1lK3mc3SFkeMf8feRg=;
 b=Qq3DVseeVFr5+b3NN5CY6hfgebfYleEnfj1te/Sn++C2elb81gJJJN8PACmXmunzfxQQa5iZnuDzMMcYGJm1qu9zkIg2KWpeLreQEAf4wg9g2LVWsrWQwsTAHS5ogM8JFF80U5IaVO2EaQXLYa3BYx2HuEzGR9FyyDTAkYzuf4gaI5ld3amOBxC3hsYs162l+P50eZMyuqNv1fVbD7n2zYQWRLnJqqM8jHzK5EzRXPpA7VkCrlVSvou97GKr4R80juaqapBJtMzeBqL+DwgDjZqi+6c/8AO+v3RFvbFzA3eIMz4Xmd+wBqnauJ49GZ6jO75YcPxdgv6scc1hVvB2RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6769.eurprd04.prod.outlook.com (2603:10a6:208:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 21:11:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 21:11:39 +0000
Date: Tue, 10 Jun 2025 17:11:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v5 5/6] power: supply: pf1550: add battery charger support
Message-ID: <aEifg/+mIuVVm6El@lizhi-Precision-Tower-5810>
References: <20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com>
 <20250610-pf1550-v5-5-ed0d9e3aaac7@savoirfairelinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-pf1550-v5-5-ed0d9e3aaac7@savoirfairelinux.com>
X-ClientProxiedBy: PH7PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:510:23d::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: fda2d84e-e105-468d-100a-08dda86363fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bZ79RJXGP4kkVKigVqsZa5KMQpcICa1sZHKOsHvtOfT5exesSylO7+dmriL3?=
 =?us-ascii?Q?zGZiXD2s7yR6+j1LYz9P2ZNHT0nXgwvzG92KBkchDES2PUipeo8qsBU0oi/D?=
 =?us-ascii?Q?KUABErS7cN0Xz2mQssyxu3vDZDz4tmKLNSBEhkisKfIK9FHprqdHpgH7HrwU?=
 =?us-ascii?Q?2T/9qom5PgCAXBR789+6ljz7mBlj5fUuV9ot/E6FXmiWTrqaqKd2J3Ji2UJQ?=
 =?us-ascii?Q?7xLKcDBA2FQd+z82ggXmlZ1ZwPZm3vFuIivx3RSygHZwp+65bjp8GJg/Hfbh?=
 =?us-ascii?Q?r1hSZhg5lYwvGN2fzDaWYUqxLn19Pd4WmrHNiXTSJa/zlIm3pMArNoWNzFaI?=
 =?us-ascii?Q?fjLh5DvaiPiBuifwTW0Vhk/J+O4C1FIMIq0bHHpqO6QO0YMgUB5FdlssWP5g?=
 =?us-ascii?Q?5y0arKNaZgMRdf2yYY2wTDSfu3tgURmR16ouOCu7481w3740FQ/cJFhtsQ/3?=
 =?us-ascii?Q?2/1XJY39JrQptWM51bEqjB1m3z4YA6SuFicKVCyuDiS/wYIWJfR6z4M1HZjC?=
 =?us-ascii?Q?25SEdmRe0lDsIGcdaLQEzDB0nVwIp8lOzcDcK2hi5OTZenCo2VJ2bwR8ccGv?=
 =?us-ascii?Q?HbfFdt25ry2W4/Pws+sicH/u0ylPy3wAazT30jcBdymQkYMXBdD8XHmwmDNP?=
 =?us-ascii?Q?uuKfYN+uBDd6gvyGWjRjjC2LuCqOm8rzgcO0ffkFziWsWcnb3TvOl3Wdo7gD?=
 =?us-ascii?Q?XZVwl+khVtpJbNrq3p/lEQ6RJEchRt6qnfglXfoBKH1RiR6DPzcNYEndSh90?=
 =?us-ascii?Q?8tVoT7ZJH4nIHHeBhDH961zmGFk7V+oum9lUeztxW44vNzbijXXWWg005znU?=
 =?us-ascii?Q?H9sELaqIj7+euThwT2Ojx0RWDU/jeCrd9ChunmGx0vcvW6Y9/tmTFE8WJYho?=
 =?us-ascii?Q?werfG1s853KxpKBQdjpMfB/EI04OC0ZpNp7Rb1PQ/RE0ULo8U1olyE855olC?=
 =?us-ascii?Q?BocZRXcT5vqpsnGIX3ClHJwE3iZubaYVEh27ApSdollyaOUhAYfGKbddPy9B?=
 =?us-ascii?Q?fG2UziquRs48i2iZG/dpQNEosOda3fIEYJKKIEttihHRn1Qq3DvGXLKM9Sat?=
 =?us-ascii?Q?jop+vM3ZyFJ4I46smfWRjVtcogwqVfTUMpMrZy1pq/peHEl6BTdqQZeLW28i?=
 =?us-ascii?Q?9AqIbopA4JNS1rXfbGDTnUanuwFq4cywLe8dhDxf3DsydGRQeSSiMayczr4S?=
 =?us-ascii?Q?I0cazo2zia4tT8rk7GelmxumRh0avJbVv/zcMwBFoN4zHq0atdMgTxN2BIJ2?=
 =?us-ascii?Q?NZJWSFFCVS3Nrxo1i8Vw0d6C50FlsMO7iyZbgLR2sriuBHqq7Laq31TT4uxB?=
 =?us-ascii?Q?O8pBtC8ASeXpfexW96Ecoe+P5riZrnNgZcdJ6Geyesv5zn4/p8+K6VhfPvQw?=
 =?us-ascii?Q?O5amLjI/hIX83q7i9rSePjOX64V0cXW4yjeafBgWd7pcnXQrI0rhBjZoI/o2?=
 =?us-ascii?Q?/Kgbe8CZPfuG4ujYHJNZhR8FQir8NyBi9F+EslU892jxJPFmnOiMEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4b8vmRl8b407L6+UU+zE2Ub3Yuwl9sFdzMiciYcdD8/buZJyn+u9SgY4MCsQ?=
 =?us-ascii?Q?qDYy6AN5Ff7TAz9X3r2kZrO+MqbyLczZWUT9M8fU/Qw3X3ep7aY1wsmsYUbK?=
 =?us-ascii?Q?cRNK7sEUWI5BvIbnGHsVdY51QHRIZezuM9doea/Kp5YTjiQriQ6X5ZRqtj9C?=
 =?us-ascii?Q?/3Ld+FKoNioYSjAj+mPaN7Xg4b3PIelitMjPVYVm326miCdfBNRpIT480mb1?=
 =?us-ascii?Q?zX9mGINPm11VgA9vgkhJoLaJ2x5dgJawXPg3bF4+EwO1Xw0OCOwhDe5JfSFG?=
 =?us-ascii?Q?9O132DogzlO/Syyuv7uzWAKnnwY4MAsFFE9fle0SfzpZ27nRQD3mpWuDxbJZ?=
 =?us-ascii?Q?ImtQJZDWRxAXSV11oi4SjZiX9a8r0wSnNuSbXZ1YkGATNAl3fHIohYZ/D2Cj?=
 =?us-ascii?Q?RXVxZ2fChr+Byrv3UFVvuHpsUdpcL1zkhHaNux3vqRuxMFCn6AeBSsmq00Lm?=
 =?us-ascii?Q?v8PFVF5pbqbyzF3hYDq9d2rDPUHk220hmVv+1e88SJrYj/4KzirsTKJfVPV9?=
 =?us-ascii?Q?j4xM4NWSFsVj3h7hI39TzT28pvdaEuAZQG9R/9HZn+g1Z0OyGCIOW7KfpuhU?=
 =?us-ascii?Q?e9wqOQFFQPuP0aNhnnbH6+DQgNGaE8THZ4+iYL9Cu1z/nxKkXEtkBaUvwVWI?=
 =?us-ascii?Q?p385neutLvz67RNAPos5QiCFXFalH5Q+O4yWPtSEXSwDd837cX1ZxwwCK26f?=
 =?us-ascii?Q?BxCiTgpIWstAD/FAOZBy4dkdJOphZOiIpdhwuAIhc63rBFv191uJwkEaznZD?=
 =?us-ascii?Q?Qqfo8B1iSJ0AYWTv9Ida6VFOSk8ufw/ftiZthSRnB1Szn7etcXgteUMohh9a?=
 =?us-ascii?Q?hyxksXBiyPtKmLc+Cfug9Lm6DAXaEufZwuGQcGDDalb+eqRfiMmXpQHnK+IX?=
 =?us-ascii?Q?wgo7U8coj3pyfPK6XWJ4iFPOiweadeooB6nzCyPiVdZaO9yBQMdmzgbek8u4?=
 =?us-ascii?Q?pTVPmdoNMmHlqO5pbOXaa5hvRK+VxstXYV1bo8RFUsonEhNLmpNEBsuXWQYg?=
 =?us-ascii?Q?colOuLUWLrFJIOIrSXc5uj1Byv2rX5tpIM5YsqeeglBL5RjDMtr1u22AZFH9?=
 =?us-ascii?Q?6lE9emg8ybUln/Y0/cNIGP0+yQjZaYDYVsCbjJKMpHwe8EZgK3q9DFV8IsiC?=
 =?us-ascii?Q?wAzfxr7K0/X07kRN8Ksr+w69rS9xFaXJYG9SAIH5un63ZQ6a3VrNTs4Y1cTs?=
 =?us-ascii?Q?fJpqOl7q4S4i/M8IZ9+theLIK6jaUPezw2iUajdr88IDmFOcH9LQObYg4Ia4?=
 =?us-ascii?Q?XOcNczGDylWUGIfF8YrpKc77otcT6xwq6B/bO1dA0yOa7bCUIDAQeMgss+Vp?=
 =?us-ascii?Q?TEcGWCnuol9EYpKcb+ym0Vc5Eo+H7oNpTQYsDI61F20kpZ8BNHHWOIGNZcAl?=
 =?us-ascii?Q?Fga4c2MIenSY22l7WncJf/e6csP0T+NC/7qcu49SAAPIcqG7PBsuIhCc7oqj?=
 =?us-ascii?Q?SRR1JB+Slmf/eKTEnUM2xMjx/Z9PeMcoB6w8hN4Ha6/ByftQ4xsm02DbSyrL?=
 =?us-ascii?Q?8P1w1PsWoCN6nM9shXhkwfRoulnT0PkYDE839U1+7c4NMPxOKKpVvtWFPGXn?=
 =?us-ascii?Q?zKohZ/z+5b33RFGUDHRyJdwet/co+EPEAv/7EMRF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda2d84e-e105-468d-100a-08dda86363fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 21:11:39.1713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaheCM4SyRr8w9xmN/Gkj6cp0NbWsb4GLwu5R25PQu0qCeYp98r20eaYLZWp7g7RRzyun9J7OoCpuhxFPZr11A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6769

On Tue, Jun 10, 2025 at 03:47:33PM -0400, Samuel Kayode wrote:
> Add support for the battery charger for pf1550 PMIC.
>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---
> v5:
> - Drop lock for battery and charger delayed_work
> - More conservative locking in vbus delayed_work
> - Apply lock when setting power supply type during register initialization
> v4:
> - Finish handling of some interrupts in threaded irq handler
> - Use platform_get_irq
> v3:
> - Use struct power_supply_get_battery_info to get constant charge
>   voltage if specified
> - Use virqs mapped in MFD driver
> v2:
> - Address feedback from Enric Balletbo Serra
> ---
>  drivers/power/supply/Kconfig          |  11 +
>  drivers/power/supply/Makefile         |   1 +
>  drivers/power/supply/pf1550-charger.c | 645 ++++++++++++++++++++++++++++++++++
>  3 files changed, 657 insertions(+)
>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 79ddb006e2dad6bf96b71ed570a37c006b5f9433..6d0c872edac1f45da314632e671af1aeda4c87b8 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -471,6 +471,17 @@ config CHARGER_88PM860X
>  	help
>  	  Say Y here to enable charger for Marvell 88PM860x chip.
>
> +config CHARGER_PF1550
> +	tristate "NXP PF1550 battery charger driver"
> +	depends on MFD_PF1550
> +	help
> +	  Say Y to enable support for the NXP PF1550 battery charger.
> +	  The device is a single cell Li-Ion/Li-Polymer battery charger for
> +	  portable application.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called pf1550-charger.
> +
>  config BATTERY_RX51
>  	tristate "Nokia RX-51 (N900) battery driver"
>  	depends on TWL4030_MADC
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 4f5f8e3507f80da02812f0d08c2d81ddff0a272f..7f68380099c59dab71b73120150612a23e16a745 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_CHARGER_RT9467)	+= rt9467-charger.o
>  obj-$(CONFIG_CHARGER_RT9471)	+= rt9471.o
>  obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
>  obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
> +obj-$(CONFIG_CHARGER_PF1550)	+= pf1550-charger.o
>  obj-$(CONFIG_BATTERY_RX51)	+= rx51_battery.o
>  obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_fg.o ab8500_btemp.o ab8500_chargalg.o
>  obj-$(CONFIG_CHARGER_CPCAP)	+= cpcap-charger.o
> diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply/pf1550-charger.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..04da5bd115657980c8eac462a9c33a42f6b94be7
> --- /dev/null
> +++ b/drivers/power/supply/pf1550-charger.c
> @@ -0,0 +1,645 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// pf1550_charger.c - charger driver for the PF1550
> +//
> +// Copyright (C) 2016 Freescale Semiconductor, Inc.
> +// Robin Gong <yibin.gong@freescale.com>
> +//
> +// Portions Copyright (c) 2025 Savoir-faire Linux Inc.
> +// Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> +//
> +
> +#include <linux/interrupt.h>
> +#include <linux/mfd/pf1550.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +
> +#define PF1550_CHARGER_NAME		"pf1550-charger"
> +#define PF1550_DEFAULT_CONSTANT_VOLT	4200000
> +#define PF1550_DEFAULT_MIN_SYSTEM_VOLT	3500000
> +#define PF1550_DEFAULT_THERMAL_TEMP	75
> +#define PF1550_CHARGER_IRQ_NR		5
> +
> +static const char *pf1550_charger_model		= "PF1550";
> +static const char *pf1550_charger_manufacturer	= "NXP";
> +
> +struct pf1550_charger {
> +	struct device *dev;
> +	const struct pf1550_dev *pf1550;
> +	struct power_supply *charger;
> +	struct power_supply_desc psy_desc;
> +	struct delayed_work vbus_sense_work;
> +	struct delayed_work chg_sense_work;
> +	struct delayed_work bat_sense_work;
> +	struct mutex mutex;
> +
> +	u32 constant_volt;
> +	u32 min_system_volt;
> +	u32 thermal_regulation_temp;
> +};
> +
...
> +
> +static void pf1550_chg_vbus_work(struct work_struct *work)
> +{
> +	struct pf1550_charger *chg = container_of(to_delayed_work(work),
> +						  struct pf1550_charger,
> +						  vbus_sense_work);
> +	unsigned int data;
> +	bool psy_changed = false;
> +
> +	if (!chg->charger)
> +		return;
> +
> +	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS, &data)) {
> +		dev_err(chg->dev, "Read VBUS_SNS error.\n");
> +		return;
> +	}
> +
> +	mutex_lock(&chg->mutex);
> +
> +	if (data & PF1550_VBUS_UVLO) {
> +		chg->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
> +		psy_changed = true;
> +		dev_dbg(chg->dev, "VBUS detached.\n");
> +	}
> +	if (data & PF1550_VBUS_IN2SYS)
> +		dev_dbg(chg->dev, "VBUS_IN2SYS_SNS.\n");
> +	if (data & PF1550_VBUS_OVLO)
> +		dev_dbg(chg->dev, "VBUS_OVLO_SNS.\n");
> +	if (data & PF1550_VBUS_VALID) {
> +		chg->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
> +		psy_changed = true;
> +		dev_dbg(chg->dev, "VBUS attached.\n");
> +	}
> +
> +	mutex_unlock(&chg->mutex);

not sure why need lock here, you just update chg->psy_desc.type?

> +
> +	if (psy_changed)
> +		power_supply_changed(chg->charger);
> +}
> +
> +static irqreturn_t pf1550_charger_irq_handler(int irq, void *data)
> +{
> +	struct pf1550_charger *chg = data;
> +	struct device *dev = chg->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int i, irq_type = -1;
> +
> +	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++)
> +		if (irq == platform_get_irq(pdev, i))
> +			irq_type = i;
> +
> +	switch (irq_type) {
> +	case PF1550_CHARG_IRQ_BAT2SOCI:
> +		dev_info(dev, "BAT to SYS Overcurrent interrupt.\n");
> +		break;
> +	case PF1550_CHARG_IRQ_BATI:
> +		schedule_delayed_work(&chg->bat_sense_work,
> +				      msecs_to_jiffies(10));
> +		break;
> +	case PF1550_CHARG_IRQ_CHGI:
> +		schedule_delayed_work(&chg->chg_sense_work,
> +				      msecs_to_jiffies(10));
> +		break;
> +	case PF1550_CHARG_IRQ_VBUSI:
> +		schedule_delayed_work(&chg->vbus_sense_work,
> +				      msecs_to_jiffies(10));
> +		break;
> +	case PF1550_CHARG_IRQ_THMI:
> +		dev_info(dev, "Thermal interrupt.\n");
> +		break;
> +	default:
> +		dev_err(dev, "unknown interrupt occurred.\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
...
> +
> +static int pf1550_charger_probe(struct platform_device *pdev)
> +{
> +	struct pf1550_charger *chg;
> +	struct power_supply_config psy_cfg = {};
> +	const struct pf1550_dev *pf1550 = dev_get_drvdata(pdev->dev.parent);

maintain reverise christmas tree order look little big better.

> +	int i, irq, ret;
> +
> +	chg = devm_kzalloc(&pdev->dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return -ENOMEM;
> +
> +	chg->dev = &pdev->dev;
> +	chg->pf1550 = pf1550;
> +
> +	if (!chg->pf1550->regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "failed to get regmap\n");
> +
> +	platform_set_drvdata(pdev, chg);
> +
> +	mutex_init(&chg->mutex);
> +
> +	INIT_DELAYED_WORK(&chg->vbus_sense_work, pf1550_chg_vbus_work);
> +	INIT_DELAYED_WORK(&chg->chg_sense_work, pf1550_chg_chg_work);
> +	INIT_DELAYED_WORK(&chg->bat_sense_work, pf1550_chg_bat_work);
> +
> +	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0)
> +			return irq;
> +
> +		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						pf1550_charger_irq_handler,
> +						IRQF_NO_SUSPEND,
> +						"pf1550-charger", chg);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "failed irq request\n");
> +	}
> +
> +	psy_cfg.drv_data = chg;
> +
> +	chg->psy_desc.name = PF1550_CHARGER_NAME;
> +	chg->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
> +	chg->psy_desc.get_property = pf1550_charger_get_property;
> +	chg->psy_desc.properties = pf1550_charger_props;
> +	chg->psy_desc.num_properties = ARRAY_SIZE(pf1550_charger_props);
> +
> +	chg->charger = devm_power_supply_register(&pdev->dev, &chg->psy_desc,
> +						  &psy_cfg);
> +	if (IS_ERR(chg->charger))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
> +				     "failed: power supply register\n");
> +
> +	pf1550_dt_parse_dev_info(chg);
> +
> +	ret = pf1550_reg_init(chg);
> +
> +	return ret;

return pf1550_reg_init(chg);

Frank
> +}
> +
> +static void pf1550_charger_remove(struct platform_device *pdev)
> +{
> +	struct pf1550_charger *chg = platform_get_drvdata(pdev);
> +
> +	cancel_delayed_work_sync(&chg->bat_sense_work);
> +	cancel_delayed_work_sync(&chg->chg_sense_work);
> +	cancel_delayed_work_sync(&chg->vbus_sense_work);
> +}
> +
> +static const struct platform_device_id pf1550_charger_id[] = {
> +	{ "pf1550-charger", 0 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, pf1550_charger_id);
> +
> +static struct platform_driver pf1550_charger_driver = {
> +	.driver = {
> +		.name	= "pf1550-charger",
> +	},
> +	.probe		= pf1550_charger_probe,
> +	.remove		= pf1550_charger_remove,
> +	.id_table	= pf1550_charger_id,
> +};
> +module_platform_driver(pf1550_charger_driver);
> +
> +MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
> +MODULE_DESCRIPTION("PF1550 charger driver");
> +MODULE_LICENSE("GPL");
>
> --
> 2.49.0
>

