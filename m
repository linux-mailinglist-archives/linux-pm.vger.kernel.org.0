Return-Path: <linux-pm+bounces-38874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B16C919F5
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 11:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91453A265A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8C830BBB6;
	Fri, 28 Nov 2025 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JvvN7nEo"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CBA309DB4;
	Fri, 28 Nov 2025 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764325749; cv=fail; b=F9A9kT7wF6D8fCOdDHxLhiedT0Aqbz8RgB4DqTUnlRWruD2KZwWQyNoKpffI0YaViKV5F2Y5ZYxoy1h4xdBLdF9B6SaXnlXl18fwS24ICMBFNtP97y+jZ6sM2n7S/ZL7fMN0+srL/4lkGVAb0SvXq2T3I5yl/lF2IvlIUHOIxpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764325749; c=relaxed/simple;
	bh=b1fCYeGJ2IkfcXBY2pJptYr0gJRc1MwYpcPjHa7yt1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uxUXl/uTPlYXbunSJinAqMYmlzfOd3ssKCd2gvNAl1HVowS9fDzjJO6loXHRNSDDaGfGIDGyYHYboEnpZKFWzdL6cWOtVNMhXTiYjG3FRz1NXCa6Ji6BozAPpEQ3fVnGAmxMBVsXCgHMrTEN5jyqPgpL9DhTt9feSwIjo8QjjEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JvvN7nEo; arc=fail smtp.client-ip=40.107.159.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhcsUbnY3ePT8Nu9RaqyE0nPRI7NG2+8+qoiVq/AzRQ8llxiVIjpzNg5vCFyh0rn3Mo4tDi6wYvG6h/fvsTfi/iHyoZEHJUZJiQdQ6tPterG6lQp0K0LAWnmVFbeC2+ALb71zypF8teVPE3kMkOMaROeHsgCnc5xMfqBhR1Vf2WXQOu2FxY3wpsN6Y/2VB3oWJwPPBddumALqCu7cSxnGv+0BVz/nAWTcNswSOoRSehvM+LB6c6m/CDbhRjO2JhJg9wu3FUj4Ul5IDnPeClWwAGrvDJa4DePevHqJ3U6ZKHarTXK9nUmfP282CYV2yC9P3xboW/X4gVdEwnr2HGqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1fCYeGJ2IkfcXBY2pJptYr0gJRc1MwYpcPjHa7yt1k=;
 b=cshNTi3pGxIfbfVAPCg2UcxJvwpQtMVc2/4syESq8CkLf8N2V6S86BWe3XlOHOq5DGSEeJFmgJoN6Ux7QyfgENe95//PsEtQLX7MLiuPVo94SQmE3wy4QX67wNy+GeJV/QppCaVKC93TTjkSpRtYd0aUQd6T1iC2qQMwP+5pqGzFbTu4Ta//J3FpnT97ABVwLtER1CRhljWsBHmlux4Rh0jR7OdfCKHXijatlCZQIFMyKyAG96kgcNMIpCohHTS9arP4XQIJikK9753YC64lKeux5VvUsB3l/n3meOCIDbLaEAWnTdTw/CnrA+oFwJ+FvY7yA0cYSoD/1zv/uxiUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1fCYeGJ2IkfcXBY2pJptYr0gJRc1MwYpcPjHa7yt1k=;
 b=JvvN7nEoqqiCSeVPeo58U5pZXGbnVzxKINtCDEy6PrzM0AyrrMZUu8HN9pWPvEJDOUdzUM5O9GTBmRJnVxvyEJ7BlHW3AoJfWrn5u36fZoLl3hOSNYfzgF8ijXWIh1hYZzBlwwnbTwbOxHF+ffdGkRStccAJqAlQZBFu2kdM4qcoV+2PmVzuBBUeIGO9IQbP8RQvoFL6Ukq1NWh+4W7Q9Wy/9ehKwLPaNrfr/b1Z5ssTRcaqs4MpakO7AWEmMjrJLISclTfL4RlC063y1LrYN/lLh2OXnQxIXZdR1F2nMAvs2KfUyf7HHYiRoZirdGu32iRlNAOCclOrWPQJcT5wQQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9414.eurprd04.prod.outlook.com (2603:10a6:102:2a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 10:29:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 10:29:03 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Ming Qian (OSS)" <ming.qian@oss.nxp.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>
CC: "mchehab@kernel.org" <mchehab@kernel.org>, "hverkuil-cisco@xs4all.nl"
	<hverkuil-cisco@xs4all.nl>, "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
	"benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, Frank Li
	<frank.li@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 1/2] pmdomain: imx8m-blk-ctrl: Remove separate rst and
 clk mask for 8mq vpu
Thread-Topic: [PATCH v2 1/2] pmdomain: imx8m-blk-ctrl: Remove separate rst and
 clk mask for 8mq vpu
Thread-Index: AQHcYBJFeBYdmCLHSUCJD7gga6uyA7UH414Q
Date: Fri, 28 Nov 2025 10:29:02 +0000
Message-ID:
 <PAXPR04MB84591638C65B3C45EE6CB47F88DCA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251128025117.535-1-ming.qian@oss.nxp.com>
In-Reply-To: <20251128025117.535-1-ming.qian@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB9414:EE_
x-ms-office365-filtering-correlation-id: 73111650-7c33-4800-dd84-08de2e68f383
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dyCO2lWZndVKKKaH1cD18uxG4pZu+w1ut7JnqXFjoflbxCpipQ/qlijWfiVt?=
 =?us-ascii?Q?aSuGsc0BVkbtNHmEgwkcbr6Bo2fx/Zw21Ji3g5rLPFp1IBqlGFhW/5IpduKv?=
 =?us-ascii?Q?c62MCbklxJdTxRPgtkd2DRiny9cKXZKMzMog7OmfBDxJ+EOgbeQbqb8NGhgM?=
 =?us-ascii?Q?zT0DE8a+kR0qjm57BdhOFN+ZiWdS33QL7m0caYuDXT3MqN07uzH7CtlNjfjo?=
 =?us-ascii?Q?oNMflQ/YF4h8bVzdB7sHFMIttghWAUXN60cKEUW6wLYdtngD+fb8VErDcxwX?=
 =?us-ascii?Q?AKaqSFoDgoKLE3vM/FE0J2HERT27Sc3Y5ktkXzZd9dsPe0apPrHP8ib380zF?=
 =?us-ascii?Q?E9TLnUv9C1o5YiVU05kVpiind9QQQ/nKd2MJv31EeFAAshkcdUG5wDLHzkPM?=
 =?us-ascii?Q?z3lqXHj/VOctIN8+NDHOLzj0QCRxHr/s6EBCyUVmsffnrld6D5Eyn5HgCTyz?=
 =?us-ascii?Q?qATwj91+d4YWYOrllYPqiFfRdZsjjeRhTRRzPGGrivtwOriHbOj1SJvkJIw5?=
 =?us-ascii?Q?mKw83crL2fAY5f8hwZw+M3/qrIDU0nS8FzKTXLRdNg0yXO7kvaygpairQTZ7?=
 =?us-ascii?Q?gKP7VkpaJ5yQS3cYbPKRB4EcU0iVE+nYrMnuPTwwu+ULC7inBZ1LYdYc9xHs?=
 =?us-ascii?Q?XbxcTwd3PgN0h+uc1iGSK5IYXqAOMhrsCuZVrroFoTpmQ6b9y1TRuun29VHt?=
 =?us-ascii?Q?O3lMzhVQyrAc1otVKI6bwHsXWu3zL252/LWRPKZVXiqU+i+TiDid1PBprw/m?=
 =?us-ascii?Q?+Vpy7alAumULryNHLCzAKagVlV+GKh/FU9lrsxeop9YBQaTXnUAZJ5kWPQaC?=
 =?us-ascii?Q?ZlU7gBe2coXRJi+2R2x7G/m6kDbyks0os4yJtu6EiPjF/Sqp46iicisfAng6?=
 =?us-ascii?Q?vT2NJVCRN72k7mFcnPqc5edRbphvw28WNbfJVe+HJvu21Hw8sQGQkMrLUGhS?=
 =?us-ascii?Q?yC48KJbuVZ1ea/smvvbjO4El//UT/2GqVcWc8ty+OysB0YAUfolPxnik1rDz?=
 =?us-ascii?Q?U1818hAUivZK0/v1cZMSgHbNuMKCG5xVMjeePpQJjePySEK7HfTC3Nj+LvMu?=
 =?us-ascii?Q?7zQPc7mw9EsmhTSHTJg3muBiiDOWkNxy5WKBLnZQdMs6KE4U3sHgKu6lERLT?=
 =?us-ascii?Q?6s7VXagXN9UDKo0483ErDbRVUfJI/yISDw724yy621AGK5QPu7s6b2yhFoaS?=
 =?us-ascii?Q?pxy2lMkGYZX2bwuxB3s4MVcb4uJQjx2/kqoon3ae0TP5FVBhCB49iFTmDyRT?=
 =?us-ascii?Q?qMEM87BlZfPXIe5qgvM2iA00LL1WYQh1FERPWiIKlgbcHhgj09dWTOR212br?=
 =?us-ascii?Q?47CPaqIt1q3HlCqjTa+n3bBEh6LaGd1G7fSbD/b0NSkosDaF/gUZiUDZMXb3?=
 =?us-ascii?Q?RX5QI7cUG5Wsk14L41W6Qf3x1ZmEVAmOTWAQ1LQuRjtuxxzXSV6efHmenCkl?=
 =?us-ascii?Q?u48NVMdGveZrVU3BblqcaTgdm75vVPdMSpcdNbf6h+x3/LVgRTwUJT4T6z7k?=
 =?us-ascii?Q?J7Ab9EmVDP+EXl0RRVsBVWNUsxNHVaOBX7B0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?m8Wd78unVDoTXUCXYui9JvigUTY0ejYwEbLpb4wBf7QgvK0ENIl80ypfOeZ8?=
 =?us-ascii?Q?At4cEzlx8A563lxtm3T6tFoCegir5VzT9EdwcEKWs8n1NIgb3faJnB0UX+pX?=
 =?us-ascii?Q?WZnBVEvwGoM9GC3NFseZrkc/LWysB9XIolUpuSo+fiVd39UsMEXWpwqC4V8v?=
 =?us-ascii?Q?pBMiv2VLoPoWH0I6463tdXJNPEInYpaUCcWIVqV1hL6zOlfn4lFxFqyLCDYW?=
 =?us-ascii?Q?63g1OjbtoW5nODczMGo5WN8tHVvPXRQQexDObYitXQ+3sPyPAxOUB84riQIn?=
 =?us-ascii?Q?tRIzgqck72tp5kulaGL9hEs5l+1YqcUzHHkRnmQQi700nq2/4x0kWh3Vfovc?=
 =?us-ascii?Q?Np+Yy24VSJ4d5H+csUEtUzI/SpkYKAHJen/DZ4FsTkJDPrDqRco4oXMpQa/z?=
 =?us-ascii?Q?D8L/egYOTgVKLL909hXvXoF2XlE4rIGxL5hCadQIBilk3qEOCvCjvRSHb+O+?=
 =?us-ascii?Q?S0NrmMDnAx9bRxGXoRrCI+grcXnfztwwqifYHxLOtGCtp/4lVDNThWLNl+uc?=
 =?us-ascii?Q?KuJUa+CTIpLw/llvoAuVoPOrHUXuBwdD9PGQ0CGqRNSPK1UxKbFgReNu13Z2?=
 =?us-ascii?Q?2+ICKmJv+LH894IGVIiQaus3B17I8XDms1xZOi9QINvXrOfFhlG07IE9JBD3?=
 =?us-ascii?Q?XYTDhe0qWrDd+tlPbTjElbXdqujcwVzpxGBC2Yq1NCGNPUk1hzUIOI45VJU9?=
 =?us-ascii?Q?0goEFgHB0h6lrG6Z9of9efzNDzBkJccgXbhbfd83vPCObGgZ529vhpXRZCUE?=
 =?us-ascii?Q?ThhYheygRvWfN68dAEZ1BNlxZl6QOIInX1EXDgOSOHrwhY0Y1sFlEPE+h4KW?=
 =?us-ascii?Q?GRSBnjy4+2xgooGwhvczlsseA5gDervyVbdzAbaaMqB6najeAl2lRHoUP84d?=
 =?us-ascii?Q?4mGPYH4a3k6vdZGcDa6tn+g2/ew0quc3N1Z0PXI+Vya/gI62nXEEMiOHG6cW?=
 =?us-ascii?Q?ZBOYyOmAa+lPJAPrE8MXzAgNzeVBLFasrgclozQAYX6a29OES83fCazQEAOu?=
 =?us-ascii?Q?Jp4pZgxlwwSXh2sUYU590ZJoC1qrnlNS5ED+p8qypv9+Vd4OMaGeqyFqE+vt?=
 =?us-ascii?Q?oUYXbc7FG0FAQW4bdlovAMmChkfw+jF94Jl83j6SyEpy7vDYRARLXuHj2yKU?=
 =?us-ascii?Q?D6X4/RHNIc1qn4r5S38JG5wz6GsjzfKJAywqvOPdb0cYZcQGc4YLKUZzufh+?=
 =?us-ascii?Q?T2NxqkOAaCZQDaoTT3E6C+0/4rAIR+C/XwJ8vL4y56/4XzrLSpETu2EndlAy?=
 =?us-ascii?Q?sSU/HP2gbMdXt2d+tkiSAujvWkyYdDQgnQ7FHdQgmeHQh3FDGUbquIQ4etN5?=
 =?us-ascii?Q?W3MjQtM7pjkaTxCyhO6EaJv6kk58fT+iZTCsjbTpKH2KEQu9qwI1m6FMZgye?=
 =?us-ascii?Q?t5NxzmzpAaHo0gddZvv8CT2eLbKZhWQFKNBHoJuMm7HhPpKeIXwjMf9MSo3p?=
 =?us-ascii?Q?fhpwpLqzLlxpEtnAIVke6nCznGEss9I0IziLFIyj2hDPr8YUA4c5BCXM+739?=
 =?us-ascii?Q?1bfn/qcuuiqTYo+1xBBrfWsI7dtKFCW6Fd4Kvi6OYPTNilnvPc3Evqgk38aF?=
 =?us-ascii?Q?qfnfwCKjSs+BWz2x11Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73111650-7c33-4800-dd84-08de2e68f383
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 10:29:02.9657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSogYLasmiJicYH1GM5FMXV9Ynqpf9Y6d6buLbfCI6I8jPhUlYlGzhsTSQpMxA0GZmJslsw7mgrZnKZ+7wHkmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9414

> Subject: [PATCH v2 1/2] pmdomain: imx8m-blk-ctrl: Remove separate
> rst and clk mask for 8mq vpu
>=20
> From: Ming Qian <ming.qian@oss.nxp.com>
>=20
> For i.MX8MQ platform, the ADB in the VPUMIX domain has no
> separate reset and clock enable bits, but is ungated and reset together
> with the VPUs.
> So we can't reset G1 or G2 separately, it may led to the system hang.
> Remove rst_mask and clk_mask of imx8mq_vpu_blk_ctl_domain_data.
> Let imx8mq_vpu_power_notifier() do really vpu reset.
>=20
> Fixes: 608d7c325e85 ("soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU
> blk-ctrl")
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

