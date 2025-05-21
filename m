Return-Path: <linux-pm+bounces-27442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0EEABEA3A
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 05:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4AF1BA6AD6
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 03:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61C122D7B1;
	Wed, 21 May 2025 03:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nbuy5KAw"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2046.outbound.protection.outlook.com [40.107.247.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62174C74;
	Wed, 21 May 2025 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747797160; cv=fail; b=geRlgJCpnoJEVC67dpP5/0Ew/Tz7mTXU+sPb4kBe2zC9aMRnFH7v0pQYjJZdYTVYuzeAMoR0ndRbVH8fJd455VuoN86WWqdCESrAs7STl8TSNQ1bsxlVC76DN9mJdo0jgcDUpCPgMxBIsv2H/1KE6RwPJ94VSV0EyAkMvEpxP4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747797160; c=relaxed/simple;
	bh=5sIAcO2VlagMRzSpcMWpDKzltjBm6agroIzBpGDU1Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YxV1Agpf+TBGB1bsWTagNvv8tAad8rJhr8Iu76DdEQJbR1NjShOlc/rEz3PfSC35x4/t8qCx3ku0c98u0yWhFt8YKpr8CZbq4yyHaKokIHk67OIcxv97xP0JgniSCqvDfMI22KR4Irx/equzfuZMomUzROV7ymBYjneXrFwQ54g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nbuy5KAw; arc=fail smtp.client-ip=40.107.247.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdaIibmrlvvlrALUCaeynWcdZRuHmxtH7bvpf/k7Rt227+gQbuulpG8xsyes6vF8p1DOYT4hs7z9B8OAYlDDaVOGktKJKxbPzf015bgJbDAb37c3n7AmioqF6u5fFUh1a2c/XiI+UkiD5wdZf84fYCPmbBW5FfINIqjJbe6K2Lw0v5QqdRuApxEnGY4oaLa1EsUPt9MxtaVt9hYaN8ErX3n7M8oXpMq36wMpKSsXy6VtuhbzVjPlLULBE7xz4C+mwueLrHy001XY5mk6yHYNbte2QJema56PkkQYtBSbJRg2hx3xZd/H6uNwB6uICa4Ttr0ewScu829SuxziAo6qAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sIAcO2VlagMRzSpcMWpDKzltjBm6agroIzBpGDU1Bw=;
 b=xvjW+LyDDI/54QUXruX5CHAroN6Sfo5WoOrprDV6SlWFI3RgS6UXF4h140lED6n3BAH6pI08AOSddf27N8argW4UH2+We/EL88292UAirFH+WkDavPpxZZgLfa0DYfxiE6EfCMV0tbcuDiPBqWSL2p31W0ouHvQOogsXUSbFi5QuVwoprY/PxqSz9pIYYPNAWLDvOorcjn5T1tTyyzDy9xhxmqX8eIKfKMdT3bf4rcYMrn5/O4lqOjtar7Q5og43T9NBPKylV+bG/2KeXXbjmpmr1wohSFx4A8+grwgG8dx9AjCD8YOUef/eoULlcWYwzTFr7XXJqNjUsr3YY9faMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sIAcO2VlagMRzSpcMWpDKzltjBm6agroIzBpGDU1Bw=;
 b=nbuy5KAw5kRf9IiHyHZiOhMhl02HcdDSuCFu3U6RCZpTC0g2Ev+SoogXQBLgHY/EckUJAhJguZQK7Hk9n/jJjAcHqbqOOOV4P76qOr0OVoZITuNkOigjdSnIUAEQRQoS88jkLbfrFnsTzeafzbvP3nJYOD4cj6A/tGLurHnXW5GD6veamV3LhvrxaYs/md1dzurwmfKP3NbwAq7JfD4aYEUCtKPzwyWLjGNVOd7qTgWXd9d9Z0LdfSQOc2MS1OtVMltKiTC49gt7NmlfnhKeLxZWEXOpokCwk7coPbaySSwb7E4pSf7P99Mjwi+2inmijW5tfHP9m0uI2dqWBTxQVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9957.eurprd04.prod.outlook.com (2603:10a6:102:385::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 03:12:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 03:12:35 +0000
Date: Wed, 21 May 2025 12:22:11 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 0/3] remoteproc: imx_rproc: allow attaching to running
 core kicked by the bootloader
Message-ID: <20250521042211.GC28017@nxa18884-linux>
References: <20250519171514.61974-1-hiagofranco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519171514.61974-1-hiagofranco@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9957:EE_
X-MS-Office365-Filtering-Correlation-Id: babc76d1-ea0d-486d-6b4b-08dd981555a3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jFrvnqs9jb3TpV0feCkV6xquz3h5WWy6XQHH4dpPEarBs52kT2V5iYd5vOtB?=
 =?us-ascii?Q?hbCj5Q8HJ8drZVo1NezezsOEvRrOB6LcZn2mwiaZSsSYb/0GnyrIWHwPoRPz?=
 =?us-ascii?Q?f5jWkV309rn+HYi5W+vZgaigFTAF7sq7ao39fAUezny1hT8Wwoy4LEZrMICw?=
 =?us-ascii?Q?WzJZLerWJJuf+BbWshuZSkTuZf+PS4U96mkWR5TmPJsKB4CDh7JmmbdVVLI5?=
 =?us-ascii?Q?x/GXObEICocVVqoJS0rw+KP8Jqg1NGGIsfCNjcl2Zwc/jO8F9wLeskT53cx9?=
 =?us-ascii?Q?Bc6FikcCZl2lUwnnxZIaUI4I+qW8n+bC7NqtX+lAC/I2gn577vc3K8pAouK5?=
 =?us-ascii?Q?1ERLVp7WKYtDmUvdbskWyp0yoDM7lPlGWMlWBM9phdM28l0V3MrQ7OsUIcLQ?=
 =?us-ascii?Q?pscEYV/qMU7aXi+KIxPB/ZNUo8/DRELaGO3iFw23IQTGHhwkw9BzCfvbS78g?=
 =?us-ascii?Q?/M97dF687AFzlb175vkftdgUQnsiF9d2Wna1wpbDdC396cJWISALX/49Nl7s?=
 =?us-ascii?Q?WWeusrUK+pkxUf/fmEOkNg6HVp3ZPnEisoacIiXQ9B/ZiNOzN/9CsA+/Uc5B?=
 =?us-ascii?Q?fJPl2IoHdWFWvWb4QOnqqkMv4aPeGytDCdJwZp9GlUQP+DlZ8bHJDr8eSx8l?=
 =?us-ascii?Q?1dpR/59xGoPpqmdlw4aQ0RJXhiCoWeXJEVKP394As3L3piYJrDLdyWuFAFmJ?=
 =?us-ascii?Q?3AvYpiCz2iDdFkjW3CnUtvSXOSTzOI8pEAhp5ko8b9VxC33mGYYld86mp3NT?=
 =?us-ascii?Q?0Q20rU0e2pwnZnd9y7NmBYBXjtIZm0YVGWviyZJutYO40KW2LK0kP69qvkb8?=
 =?us-ascii?Q?Y2ECfko2Qu+V9wfdngKA+mU+qpXfMKvwkwBBzrWIu1G+9lCyQl1Tj/eDUHly?=
 =?us-ascii?Q?oRJkHKoOkKPRUZe7dhbIZdIxVlsKia1NWba3KBIgJoe+0F4T/wiaaRUPk0x2?=
 =?us-ascii?Q?BCeFXMF5bHywXgSZHLSMFFCT7MfTA7QfcYGeJ/u0QI+8zG2Kc7fpm27kdEBp?=
 =?us-ascii?Q?FS2zbnKOtg4rA/a8sp8idp2i9HA+CafGFzP4xD2OXhJ09GGdtwiDFiqL1fdB?=
 =?us-ascii?Q?IpBiesVghJVuScmo2tIkGJauZNoK9S10X9hC3eQ6O22PqvIL+wta+pGtZtrZ?=
 =?us-ascii?Q?lRctaM/xOucp5l/15+Ycxm+oKlsMW0r9t9HniFfDvuonqjWGizOT14bUMjkI?=
 =?us-ascii?Q?vu7p+8MHA7/PIpaX4TAmKB18JKm0jmLM3ThnoK3MfyRRK1XS5cnEifkyiAWo?=
 =?us-ascii?Q?gi4iOgofiw9GrKtYLcXUc/54bHP8ViNlAU4MtAyTv6+61YLFPVDttq5H34Ve?=
 =?us-ascii?Q?SxSZWpMDrY8Z187V0M14Kbs22cUYOwA45e5pNquM7jlKsv+vdp7KI5hgm+W6?=
 =?us-ascii?Q?DQol5naUaQ4pTGR8QFJH3vioiM7AmSINHAz5CEfbTCuPMIARWGmYuW9DcjKF?=
 =?us-ascii?Q?x1c3bcY1e86Wi0OZ6tEfEs0RmGnvkETpcY+IEE8JPFF1ZWCEZrx/rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oDhEg2h5//5vmhRqZpwHMdrsyfxDCywTLVNRxEcKk9IWf0gRmnL9etv4M1JC?=
 =?us-ascii?Q?kpSPHtEn2/bA2qIBZV5QCXqXsEz2V1t26pF9d1mQ9I81Ey7Gh6lnilHnCWM7?=
 =?us-ascii?Q?XcpezijF6gTzPGY6EKh6yMI9r3buYrcE/N1O12Cshh653FBlNGa4M9mRe8AO?=
 =?us-ascii?Q?nUqIJc72afR/nYyrQGRT/eNJ6PzrKpbAnb9+gGCp7ocCKXzhd5hBD8nHHAkY?=
 =?us-ascii?Q?v6nXLeWjKvO6r+YuhXout80dG/i4KI+JdbjpFCt1XsIyi2MqdYkUv5k+ZQ39?=
 =?us-ascii?Q?bbtjvD39fwkI0wPP/TqUPZRdqgordMVmWpe6tMgcEY8E6hgVaGYvZwJZsKdu?=
 =?us-ascii?Q?Dy45/NiXqG87Nv5hT+Lh0PGZEdl7sijuQ15prE/tdJI9ibJ8riKvWXLqo+2o?=
 =?us-ascii?Q?G8z5/SqwnBeLwwpeJ1AYsjwOv4iX3dl+GRXKGKUoRAW5rs6MSInhj5p0D3rA?=
 =?us-ascii?Q?y0jJEqt1dlhmaxEpYZeegFIRlnbeXZ8nOoABHo0e2i/A/YvpiZrgN0BWs+aH?=
 =?us-ascii?Q?c2Wd0HGptnJRdn6P0lNjyZD9Fnkz+0Kg950LkppY4FcsK1GAPE/vTzOBUIw5?=
 =?us-ascii?Q?zjgfseuKzPFM0WTVhfjwMi64U61MLAD6lId/+I4ui6PRp0L3UxW4gOkE8/DW?=
 =?us-ascii?Q?ylLAxXEIwcC+f6ytePqbYEqPgzhkgsoolyjmbNkRmAs1DRzFPWukukSLvM5p?=
 =?us-ascii?Q?nk1MzsBuqyOojr2KGpBXOsPdW0jC71dqcj+78MqQl9lYes4S2p2WC7U49Enw?=
 =?us-ascii?Q?aa5xkMWkcXVUhL/JKCr+/CFOL58ByM7RBC+8YRV78pjVXdae0COYj0hhrFZh?=
 =?us-ascii?Q?5Url7kOu9Ae3nixK9vpTOz+LqlZqL3LJOcZejwIER+XVavMsTe2w0nBlsf+v?=
 =?us-ascii?Q?jvKPtsKrAYjekkZMxyitg1MoX+LMR1jVhHy9nAlvaVGoc9pPO59xa0gxDgL0?=
 =?us-ascii?Q?TMQUloZdlU0+IEeV3xmo2YtcHilJYMlZOtv6C05ImipaE/4HzICWVTyVMg/4?=
 =?us-ascii?Q?cWk2Y7dIJJCUaq948D7SyvpdjltWclMLOFpoy44M1YWzIlhxiPvokwXdhwNJ?=
 =?us-ascii?Q?GXa0b5J6wViP6hpLWD/Ji8EwvfQx9Tw+hn5NZlbwTfQJMo2C6alv5oY6eOqC?=
 =?us-ascii?Q?1L5vdjAM32YnHCqbd9VewDFhfRWE8VlToM+oHxHn/X+BLLSwLzL87zgR1s05?=
 =?us-ascii?Q?1PCvBvP0qfGg1fDhrN/uzLI5Gyn4giX44mcSQ9QiTiGH8lxKom2IDgiAuBuO?=
 =?us-ascii?Q?OqZhXmBxC0SA1gBYV8rQdcLFlK8q5wQ/sHypwA2K4ONKOSMDXlZPT36oAkIY?=
 =?us-ascii?Q?uPZnTROMVB2KB06yzfYkVLgnMiIsk83f0PQnEFfyKEU/TuXcx+xQIDBjwRG0?=
 =?us-ascii?Q?21fgx0AeaMEWnLX9zNxo4tcZE058RyA4Gb4cgpNsS/6Dn/Oje4oaU1RkTO2M?=
 =?us-ascii?Q?L+IFaE3gOuiveY+Qu2Mh7DSr5TMdymuxVOkGyMyXn7Ogp/izjZpNl65k2WTk?=
 =?us-ascii?Q?MmXSiVZEhWMric6HWokKlAjBCGwRpua4U+bCzSwT/BbYva+fF6dHhFtHE3qD?=
 =?us-ascii?Q?vWfgiIS+fWxsEMrQpS1TtC7R7uD16wSZzy2TjLAg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babc76d1-ea0d-486d-6b4b-08dd981555a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 03:12:35.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+O/r0jcxmhLn8sIUhOG0ikCePaPPPct4aQU1IUNQtZtK8s9HKXQC1oztLyKMFGYY5vbbv9ERAy6qxLfMTnTSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9957

On Mon, May 19, 2025 at 02:15:11PM -0300, Hiago De Franco wrote:
>From: Hiago De Franco <hiago.franco@toradex.com>

Let's wait for V2 discussion a bit, then I will give a look if we reach
an agreement on using firmware power API here.

Thanks,
Peng

