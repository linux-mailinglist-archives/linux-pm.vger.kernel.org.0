Return-Path: <linux-pm+bounces-28868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC2ADC458
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 10:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F67A3BDB74
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 08:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F45291157;
	Tue, 17 Jun 2025 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NuRkwCfV"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012049.outbound.protection.outlook.com [52.101.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44E291166;
	Tue, 17 Jun 2025 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147755; cv=fail; b=qE3L9+aOwP7tSJh6Ot7D9uAbJRE5tqz7STCQMJLR/l/+hpt2W8hsKx+I2xf9QzUQNVOTwFH0YRrCIHvo+8qhf13SZYHwbwsmGOvutj4TMHXL8H2oipoDmPVR7itCbHfQOoPHRrk4avlznD3sAgHNasEFRdox3G8pNdvBMCaGMXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147755; c=relaxed/simple;
	bh=xHoNGmU/XfLKIw32zNRxQQP/ZxZymyOlKViL4Sdw6Nk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ud2ZrnNtErwtsHR0YoOFxTquoYdZgZUL2ORGPPqdRa3IZQS0LWf9ufQVWrATMFFHFfX5DfzTcTsm9ePdmsPOumdrqac8ukUcKUbVQO6/lfzJ2taNWhWJrl774D4ttf7HlPaCljeNaZy1RNey+nbu7ql5mgXg/Dco55QW6adXSl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NuRkwCfV; arc=fail smtp.client-ip=52.101.66.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/4sW4xgl2qO6Xm+qAm8d19pYMFiEhSEWN3vZETaQJC/7MPbuu6V8Wd2Lb+kqq2kKT6RkW2+p3qc9ul/BRt/fHrftvVT7qjox8+rLF3BG4b0+kkqWQoK+u5/+rJ4S3phIqZRkxAPZZSgsE6E0ozvg8VaAumJIZ+fjK8HdJZXMgM8y1g2sOfMWnfKBvR3BM9nn+NASkeHHcx/uEfKemshtR0J/Gp4MlOq+X9A5lvCkBXvhbKJpoLSisvYGBD6AGZ5parSIauWgS7DlyGMzoncFfEpiWGysifdtL+/BCobjg+SIyeW5h2urFGpCEhgMEY8f8WLj7Zc9G0NS4Wk1X4rxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSK5mj89dQXwlW+W5oHpKWxB7hIv9hboTnHU8IskhqA=;
 b=gA/981bvVZ9qftXou6cKeHByvMARQtTfZkeLWXUtdF8/smXsSZ/1Gpp+GtNSXE1ByVTuoAQzHN9SqPglV5ZaG0YhGTgh0HzYG4WQZV/0gAvBI9dhcgSkq+EXmSsGP2EPxnqUP9jwveExUihS4bafRjtHYlErXtGwrBL8pGM+P5EZEpTTIRKhNPVzVI2bnlTttvkYf5It1NoIRe9VVpFb2oqwP/cYCPS01b+6fvGHemgzAzFd01a5axTjHy280i3JKF9oiMllAir1PUGz1RQdvjTKi2oyLNfbCp3Y9lVKPEahttCUVUoR81jgmZKmbZ6+mSvHmZARrGtdAHLEpMAk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSK5mj89dQXwlW+W5oHpKWxB7hIv9hboTnHU8IskhqA=;
 b=NuRkwCfVxMSIceDA6PE7DoqN+Oh2S+VDKS0O+2vv6W5E8ejyjuQJthnWcO+kBxBztwF/j8vDvotWhAhRgW0e6Dvb2ydwpCqWpBHeYt7IfrhsnKHp0rgBcozXkAQMdBkRuRFwV4sTG6sQq1+k1s5F9rFWlTT+oTPS+RpZ2xkfT5Yn3TMrO4xsG8t58MoYF99m2ykjVRuQux7/aBdxsTkNkudJ2KNjNlL/ojl0EtkskH3W9AkwqhQEDqNIs5mVOTISBwfFUaUpfd7BnVs5V7/zHX2qvec5qRO3S/p3jb36+p3aLakl92sIMiTjyBNJtme5iRB8vcHqO5XyfQaJoLOAag==
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB8328.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 08:09:10 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8835.026; Tue, 17 Jun 2025
 08:09:10 +0000
From: Joy Zou <joy.zou@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "edumazet@google.com" <edumazet@google.com>, Peng Fan
	<peng.fan@nxp.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jacky Bai <ping.bai@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Ye Li <ye.li@nxp.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "festevam@gmail.com"
	<festevam@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Frank Li <frank.li@nxp.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"will@kernel.org" <will@kernel.org>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, Aisheng Dong <aisheng.dong@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>
Subject: RE: Re: [PATCH v5 0/9] Add i.MX91 platform support
Thread-Topic: Re: [PATCH v5 0/9] Add i.MX91 platform support
Thread-Index: AQHb318amoI2njSFi0289legb0w7BQ==
Date: Tue, 17 Jun 2025 08:09:10 +0000
Message-ID:
 <AS4PR04MB93863494863F595F74B12129E173A@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20250613100255.2131800-1-joy.zou@nxp.com>
 <175011005057.2433615.9910599057752637741.robh@kernel.org>
In-Reply-To: <175011005057.2433615.9910599057752637741.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|AS8PR04MB8328:EE_
x-ms-office365-filtering-correlation-id: cc859da0-94bd-4097-9c49-08ddad763d5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YNUrASlyyKBNyneCLmo1UGtsi3i9HfbKDbEO8awprK01pWuXeLCP3vHkXHUi?=
 =?us-ascii?Q?1WjY5RQ7yZIo0mV4e52EtlxewfYesaGTszVs8lc9bYk3IzXj2kELN0C2Hr6p?=
 =?us-ascii?Q?nYQ+xiUokHLfSyyIaSaKFx0HlJJZKj1IBjpCzlNShbU5hGSSBYmYhSQe7+/Q?=
 =?us-ascii?Q?QO5g159rqLiHa4kEG8l8UEX/JIJ3oiRabe7qUHnBo/BOyefkIdIaQosuIUYe?=
 =?us-ascii?Q?gqecq/kuc33ZrxbbJGWdY9rhH6yHkhJ+vmt6POCFPJs3TNJB/bS7lrNMH5ZO?=
 =?us-ascii?Q?l1D2SMn80feFb/oj04YL2LVnigiJsg9GKezzUFM1ps0ZTWj9U5f79uCTcSvI?=
 =?us-ascii?Q?Fr1ZEZxm8TS4gNPzRG7UamEpZLoPxQ1zZD8FNKRxwwdc08aKmS4nuDo3WJny?=
 =?us-ascii?Q?D/wn//Syjg58AB4ZRpskIq6Liz46ephMa8mygkb3sW1FmolcO49Zio3XNsIg?=
 =?us-ascii?Q?fqJ+/+UMpISbQPU4n9QWWG30G2u0pWlFKw06FmjbGsrKPo5fuNN/oUL5DQJX?=
 =?us-ascii?Q?CK2zv+Avf7JZ/AqxsHfGWEIITVJA+IbhZ6TQW/8iVCMyH4TlVR7FQaHacmp+?=
 =?us-ascii?Q?q2IwVwnFgk2ikOTwMpzVGAZH5atHFSzFmqddZ8AMSXgnmwoNXZA8vhcoKlWV?=
 =?us-ascii?Q?Pg8+NB3FC1uENDls/heLHk/lZ6uyIKU9LsYSZEyuHOUxCP/W3GWPSFB7QTo7?=
 =?us-ascii?Q?LDuKeFW8kAfL0UG9AhnHKqe2WDhgXyefLJmzvAnTu0arSrRW15YTQ+YqBWeU?=
 =?us-ascii?Q?MXi8wqVX4UVWLM+t3taP2nk5sWNMnmyMMwZXKG+hCJznPUMXbVJDBLq4zLgL?=
 =?us-ascii?Q?7MQP/ew9Xd3rqXfDAnxoZBk1bhCRk4YRk5Ukcxrdntgh3gdnoAM13B6QYZnX?=
 =?us-ascii?Q?o5IeIV/IXQqrV5XxBzcsP4PMXkd1UR+bu36Y61cWg9+57ULpKH124YQ8wcCR?=
 =?us-ascii?Q?+GjATQBHjDSLYQVRms01bYvm96ktfPVRNSGw5azEUKh8jLN51ffRT5EeEVgx?=
 =?us-ascii?Q?IJpjb7AHFz6TshjnBKt2mv2aW6tllkuJV1pMBNqKKoRRGCnExvU6fY3ru2E4?=
 =?us-ascii?Q?6ZaClaCbUL/2WBHO/JxijlGyKJKTmtX7a+UbVrKFOlU2eFcrTmdr2oxNGGT4?=
 =?us-ascii?Q?jCfzrw82ZmC5lAvWZlMETyY1oWSYyLllSbiX+XAmatXdeeUXdH5A/d3oV0zt?=
 =?us-ascii?Q?LgTGcyIllFNAtJVnYE5YzAJ/DVqYhIWddSLsQDmxZtJqLoMbi0xIE6gVkJ0o?=
 =?us-ascii?Q?11SmjtFjKSkWFTQKB+SSz3gPABr+aTa9MIn3RWqtFzTC+Pp40SDy33CCW79V?=
 =?us-ascii?Q?BLXWt411IPMrOEBXUE7hPHAd/S+JWMyvi09Nx57ehhL9wXBeoi7qUYpI8+MO?=
 =?us-ascii?Q?hRu31HuUGDTDJ/2Doooddk9EJZZuXaG5BwzFHAxV848dMGjwtA+RkssXoG4S?=
 =?us-ascii?Q?9pzzCPrTqhoFIzomk4xKRoGyxJQp4yxLinGKcb2GCkeLCo6tcGvhxIQXVu3f?=
 =?us-ascii?Q?TLS/e5NexH24hLM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0lQ8uOV+eaUJX6NbCphYh1b/TqpIc57AtcLjVAj3vmz+uN7//B2Z0fGzJwnp?=
 =?us-ascii?Q?1+bhIW9a8DexP4Mfz8J44kF3ABd0ZRyn8yYZd/KZs8xwbPZ+C5k9TWEGOSAf?=
 =?us-ascii?Q?knlYn0F7RzVdu4GIsYeu69oabTsbIrznSOQ1woPTRC4w+sFtRtPYawRmPexk?=
 =?us-ascii?Q?FyhORP+mxGapDEPpFnBZNFq3HBOrpB27zpgXp6OcoDX8MV58sKHbdtUyJO+b?=
 =?us-ascii?Q?xpUP6oGv3lkcUnaO662KTc4wulUHXylYDXqRAGX2BnjjXHVcvDk3ycFtkQSY?=
 =?us-ascii?Q?HFvUN1JFXeavt96CkkmYTAAJROajZE865bczx+ZaSOp4mHghIdBqkDlzpXCp?=
 =?us-ascii?Q?qagXyIhAMSsuoYffZJI6nyyzQ6TVJT3Uxu6odroytTbxpVF6FTJPDC6WDmjs?=
 =?us-ascii?Q?9vUT0QqBR5DSwjzEtIu0DbVMTmVGxhPm2gGLIt6pnzz+1iwzJQIkIBD70xQx?=
 =?us-ascii?Q?g1EwRWmKMhCxBZvC3XPo8zdJPIUpRA+HY92uy9Lf8wKGqhJysw1kCjHjizQw?=
 =?us-ascii?Q?4wGVeTgkyVu3l9ZvsgCabYlxWKFNIU/5dsAt5IPW0t3JueU0Qy7otiqySfU4?=
 =?us-ascii?Q?bFDj8aMsOqvYtQQ6tggKfMo7cIIQE4KhpukqUIsivC1xSEm9j7pr+zTh9j7K?=
 =?us-ascii?Q?HZsPfdD8Af8nO7FEnAq4KSvTXRbRrCX/V4pspafGRBoEE5L0hgHL0blkWkza?=
 =?us-ascii?Q?SmhJZ+Kia3YhBpdAlPSXzmC5v8GWnzZlm2MswIPjeac1pVf/C9iYAyCj2FKU?=
 =?us-ascii?Q?nRwDcSYVj/3KBNpfgmuW3ahCtIayrvwcf4UkKpYhmhwSLSMHntM+vqmFoUNz?=
 =?us-ascii?Q?Y90Ux6JIiOcualRXW+fK43NB/kTLFsXiyvBjcPymy6X0sZLF/FSgg7ZrFluS?=
 =?us-ascii?Q?BDdg1xJBY2juA3dYVEoj8BdOXHINQuLF+4MJd2AZxrJL5Y+Uj3pEJPWyubcH?=
 =?us-ascii?Q?Mw2dvmSPuweTkDcpo6ggWcP1C8FhXEpSvHcUPwzdntjQ2NuPuCMx9/a3n1Ar?=
 =?us-ascii?Q?WEC2qZRfokeLbxGwZZeEXrjirmdCWCd3e40GfjzTwmFHtTStyQUI4Mh+6L26?=
 =?us-ascii?Q?QENOmKYYwxcfLyCS19pHb4TIFHu3duYebaqRMnMXuSS7Tfik8zrxZizjK0/4?=
 =?us-ascii?Q?x82VaVQpquexIWHGUSsaVQu461QC0jQjm7gVFFCB8eRg4YFX+O7Plm0IV+G1?=
 =?us-ascii?Q?xUHfcAKJObxQ9ixQu6psz7KOW0u5C+HWcdb/Lhk0nJakYVcwXv2reb+1x8Q6?=
 =?us-ascii?Q?on6kitDId+uDqk7+FT72qo5azBfqhLcJ0/iSYLmqMa1rTBksT+/VFaP2Wocw?=
 =?us-ascii?Q?1O6AjCu8o67XPYhdrVABABxI+3fh89KAWD/qbgxNxW0CKvgO393KsdOC+7Sl?=
 =?us-ascii?Q?R5ADJRZTgbK9WdCrmjxV2/lAN/Il/5fdgGK0YpG0G42cHuaTtM2CPj4bVUJ5?=
 =?us-ascii?Q?ilQWHvG+ruuDZYC8tBj0OZWLpgaloR2IGSFs45Atkbt65+safO4pPmc+ISBf?=
 =?us-ascii?Q?jBnPBofQcyUZQBZ5PXC5Jos6sMwQxJI/tnsrerDZiCy/TpQKFm9p90Ar/B1G?=
 =?us-ascii?Q?/X3Y071ct5RzT8R++nQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc859da0-94bd-4097-9c49-08ddad763d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 08:09:10.3509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rlRexoDHS48AvLrMgbBMdHmDf6+nGGrh9nEET6kS4I5+07cRWMf4+0eAoF83OrK0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8328


> -----Original Message-----
>=20
> On Fri, 13 Jun 2025 18:02:46 +0800, Joy Zou wrote:
> > The design of i.MX91 platform is very similar to i.MX93.
> > Extracts the common parts in order to reuse code.
> >
> > The mainly difference between i.MX91 and i.MX93 is as follows:
> > - i.MX91 removed some clocks and modified the names of some clocks.
> > - i.MX91 only has one A core.
> > - i.MX91 has different pinmux.
> > - i.MX91 has updated to new temperature sensor same with i.MX95.
> >
> > Joy Zou (8):
> >   dt-bindings: soc: imx-blk-ctrl: add i.MX91 blk-ctrl compatible
> >   arm64: dts: freescale: rename imx93.dtsi to imx91_93_common.dtsi
> >   arm64: dts: imx93: move i.MX93 specific part from
> imx91_93_common.dtsi
> >     to imx93.dtsi
> >   arm64: dts: imx91: add i.MX91 dtsi support
> >   arm64: dts: freescale: add i.MX91 11x11 EVK basic support
> >   arm64: defconfig: enable i.MX91 pinctrl
> >   pmdomain: imx93-blk-ctrl: mask DSI and PXP PD domain register on
> >     i.MX91
> >   net: stmmac: imx: add i.MX91 support
> >
> > Pengfei Li (1):
> >   dt-bindings: arm: fsl: add i.MX91 11x11 evk board
> >
> >  .../devicetree/bindings/arm/fsl.yaml          |    6 +
> >  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     |   55 +-
> >  arch/arm64/boot/dts/freescale/Makefile        |    1 +
> >  .../boot/dts/freescale/imx91-11x11-evk.dts    |  878 ++++++++++
> >  arch/arm64/boot/dts/freescale/imx91-pinfunc.h |  770 +++++++++
> >  arch/arm64/boot/dts/freescale/imx91.dtsi      |  124 ++
> >  .../boot/dts/freescale/imx91_93_common.dtsi   | 1215 ++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx93.dtsi      | 1412 ++---------------
> >  arch/arm64/configs/defconfig                  |    1 +
> >  .../net/ethernet/stmicro/stmmac/dwmac-imx.c   |    2 +
> >  drivers/pmdomain/imx/imx93-blk-ctrl.c         |   15 +
> >  11 files changed, 3166 insertions(+), 1313 deletions(-)  create mode
> > 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
> >  create mode 100644
> arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
> >
> > --
> > 2.37.1
> >
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
Thanks for your reminder!
Have run DT checks and found this warning. The temperature bindings and dri=
ver patch v6 is reviewing.
So add note to the " [PATCH v5 5/9] arm64: dts: imx91: add i.MX91 dtsi supp=
ort" patch.
Refer to the link: https://patchwork.kernel.org/project/linux-arm-kernel/pa=
tch/20250407-imx91tmu-v6-0-e48c2aa3ae44@nxp.com/
BR
Joy Zou
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings =
are
> fixed by another series. Ultimately, it is up to the platform maintainer =
whether
> these warnings are acceptable or not. No need to reply unless the platfor=
m
> maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then make sur=
e
> dt-schema is up to date:
>=20
>   pip3 install dtschema --upgrade
>=20
>=20
> This patch series was applied (using b4) to base:
>  Base: attempting to guess base-commit...
>  Base: tags/v6.16-rc1-6-g8a22d9e79cf0 (best guess, 6/7 blobs matched)
>=20
> If this is not the correct base, please add 'base-commit' tag (or use b4 =
which
> does this automatically)
>=20
> New warnings running 'make CHECK_DTBS=3Dy for
> arch/arm64/boot/dts/freescale/' for
> 20250613100255.2131800-1-joy.zou@nxp.com:
>=20
> arch/arm64/boot/dts/freescale/imx91-11x11-evk.dtb:
> /soc@0/bus@44000000/thermal-sensor@44482000: failed to match any
> schema with compatible: ['fsl,imx91-tmu']
>=20
>=20
>=20
>=20


