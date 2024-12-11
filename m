Return-Path: <linux-pm+bounces-19038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA089ED1CC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 17:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC86282017
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 16:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36571DDC09;
	Wed, 11 Dec 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WxKvpKh/"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F81DD873;
	Wed, 11 Dec 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934669; cv=fail; b=YAFeE3oM37sxT/p8p2DPnwFmly7qXpFVFXIx0q+oscwrWv5XKotv1jvllR2vTw9TDrTjRU48C2gIb4/e49Y5rPx7i6Hklaf6RX979cExCkgpSdPFgyn9VoaFcDSbHly5lLLBCRav/GbjavnGx/YyXmu5BJJNrYzFQiDPedR+iS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934669; c=relaxed/simple;
	bh=bZ+hul3rQoHOadlIzOVNVcWoIMnq51Amd98q6Mn1NkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eQkFcp1XK+a4lLGLHUf52mCNQW3v8ijA9R0qp8R5OCa9ARSz92hXnyxs1bQVqtIgqcKcLTG08hYnx4dLgRfJkazpfoXLfcvIryp/M+vlmh1yiWUfDfRDNsgeGSJkgRd/lhqyXdW96DGd45LAR+57UsePUqpJBpxYGgO000F6yCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WxKvpKh/; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSZNtQcQjKpz2v9KHtBepvlPS8sZpl3C3zQzQt7wSzJ5BkL9/qsfkYxY8biLIocL5A+26FEmLccaxeg0Ont3xgw3NQ4XLdLC3hlECEOpSl7sa2Yefx6VhxCHyvfWENL0ioG/KsLEDs2ZqMF+2Sjv8eAh7lNYFPl1WKkvXYZo95SCrUPIwF/U+KVFB7sqIhrD4ArXCRcFW8SXD/i6BRoWC7sRcbOkapyZXTF86UMEpHHJLPZXkVEDXM08H0DAt2M3sPx2TE3t1s3dyRvO9DQIOhWmai3g8dlq4F+izvwTuTTHzK5ygP8usD4Ncc2RFWggt0qnwtsY/idnPKDqQQ8YGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxmADD+yKW1cOoY0VwXyuOixlSY7koRbQd46xYkvfuY=;
 b=JAM/YNS4vY25QdNBCekfomPBvQlZ98T8z3DCc6B95uiTKKCLQNYXMcmWxb0IVKguUkGaWhAX0zYWDC1pvAR5QRl27nYC7WVkSavWYn9Jb5B1Eas5xbTBrLKvz5q7sxzB3KFxz4DwyX7sWBGBNAuFOGGP0z1UhW8u77GDa8OKSjYNlPsAkYvdYhGpwQpD6zjzi+p661QbubZ+wFA1wq0OtC0erxiSGpPi7RMRi5ZSSf1jJg94G+wIpDjdutzr1ajjBJqTfvm0vV4eJA19fOgHr28o+aZ5jW0NF2SLNUP8sK6YmAR+kMkOH8Ug2bVv7AA7m/1FUHrbJroMAgh9Mn3hfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxmADD+yKW1cOoY0VwXyuOixlSY7koRbQd46xYkvfuY=;
 b=WxKvpKh/uyhgJrpM2lNWBDpmgwsVAcWe260XytQhXmXYABlN2HBS9qttBQzB+KRcA2pYvVWLgQSFF9PO18pu4dYXXpXj5slJ31tdxztfNL3SR3qNEyftxHwT7YDvmfOlWwb9XGx/0wr3f85V85/ykxwsWUkry6qyrJeaxBLcZrIEV9AO2gaa9Z3qoeNX0GbtCXGyo0HSsiFQ14p/c9yMkJEGh+Be/9B4S/8eZo9eaiEQwifWobPqvzw/bP/jxBS05PrgcEkQNhLIZh7tGEXpfjszt0Rx/XfErRCxRI3wQJXJPtkwjFcGT7T3a4eQK/6Q4G/BTTSa7KTA7x99z/EhRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by GV1PR04MB10966.eurprd04.prod.outlook.com (2603:10a6:150:204::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:31:02 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::50c6:148a:7fad:8e87]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::50c6:148a:7fad:8e87%7]) with mapi id 15.20.8207.017; Wed, 11 Dec 2024
 16:31:02 +0000
Date: Wed, 11 Dec 2024 11:30:51 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengfei Li <pengfei.li_1@nxp.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Message-ID: <Z1m+O1UV4HD+7Rr2@lizhi-Precision-Tower-5810>
References: <20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com>
 <20241210-imx91tmu-v2-2-5032aad4d88e@nxp.com>
 <20241211154622.f2jwwrqansk6il3o@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211154622.f2jwwrqansk6il3o@pengutronix.de>
X-ClientProxiedBy: BYAPR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:a03:114::18) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|GV1PR04MB10966:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe038e0-b958-4839-7f92-08dd1a0133f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/BO31UwE2GNUkHc3RKq1VZPZjxCiuYM6kDSsDWEwUiEtN9ZNnCKXUue24iXp?=
 =?us-ascii?Q?4plQyP93CqE04Nr+co0zY75skgmZwQUtrc4T7g8qFk9H59odWHeRleTQDG77?=
 =?us-ascii?Q?wzAsY6/5DQNDjU+DN0nOe93sf3t4IGyohUMOka2cf77b4nCXk92clfx8l7MC?=
 =?us-ascii?Q?nx+Elntp4dgzzLYg0/ZF2n/RrzL0gM/8MVjV/8HlOgFLyQjYe8STkiHD/8+m?=
 =?us-ascii?Q?ttBlSktyMtPgaEjFBlevElnbxzGXF1N7Pr6h02VKfP10riqa3ReJhsnGGM38?=
 =?us-ascii?Q?iIm6HxwlJf09rO4vEwTCUukjAoLhbkRwIJSaFsR2Ms5dTu4ezoT7y3V5/VV7?=
 =?us-ascii?Q?cI3LJfy5RdLnubHDa8naDnmKdGBgYVpuXKwfv3d8YP72iXQZhPS7s3QL1MlF?=
 =?us-ascii?Q?q21WfGavXFs7MngNHuza7EJdQtCDhj8KmvX6oIwPtxlximhmzw8mdiBw4ZdF?=
 =?us-ascii?Q?6giNxlow1hucMM+8VeXnJ4vZuNZ4Q9Ig7OjLNHR+S7t00saRqMtSJT8KDiBG?=
 =?us-ascii?Q?09e4P5C1//uBFnB3G9LNo8D3UgzfWImgxA7WsAr5c27hX12OK8hpFPQG6bTz?=
 =?us-ascii?Q?wrnMNcmOpjqql4KD2KWwsOoF1hVyZ3hJao7YzBDJorMJYdqGSEDHQRjwSdyM?=
 =?us-ascii?Q?DVE4NrfTWndJUKoghPCdJC7U/0Gk+7pHrE560GxUfrf2oSJur/sHXbx6MCeT?=
 =?us-ascii?Q?1Mro+i9aR0EZ/FXh6Is82MOsIz9ENok+unicidQxYU0/NujkROs/M9Wqada3?=
 =?us-ascii?Q?WogSFuWlZG6pxER8M/gRiMhlpfxtEUt/AYzNUXwgQ02qOYh+P51K7DaUsmYq?=
 =?us-ascii?Q?3p3yuDXMhSPGjdIoHPX/VKiynVBc6z82nk2uE1kBnx/hemGFhtDs49hAr8zx?=
 =?us-ascii?Q?iHTvPkn1aGaeuE8rjx1KwbC2Wd9d5Qh+Vs/n6vItbjUsKYVg1TOkRct56gQW?=
 =?us-ascii?Q?95rGa+AQjuCqAIdJdKD2wc7YFN9Z4wFy1vxdmEKNQKmc4NdFtnMFWTxRxChf?=
 =?us-ascii?Q?sHgKfn/vB87R0iczTSr7gOKObFRmNb6231d+wQfWeBsbPklQTX4O5qJIxW78?=
 =?us-ascii?Q?NClLeD0kRLRFw29diQHNrZPbrMovuwWAcMUvhPrCBgbM1XuZa7uB18Jb+Ryn?=
 =?us-ascii?Q?kbEGa+gpY0F92ZbIi8Bi0swrp6wv1lG0Lzr5DJxJjeYn+LlSyj7L+o6sF5u1?=
 =?us-ascii?Q?8slc/1nNK7oaMgz7nNTavHBQr54cjYmvQc9+XI5oPlY9li7wqCy5t62eOV3/?=
 =?us-ascii?Q?dg4rSye55gEaNsVyQJTaOBXSWL12A7dOTwVckbP9mhfkWKGdByoB5hCCkCDY?=
 =?us-ascii?Q?HYSQRRfNmdK3ZMuO+QMzyQSkvOyGATS5mDFEoDmVxZyAA0hgWr4OSNYzhwhH?=
 =?us-ascii?Q?QKVFKfqp65vp/ZdCt6IRPTq6fmeijYmlcvMYbIdaBbacvnTTiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RWQngxQh/1TFDkALf62GrHux6cgXCRnjjJzkFCKnFThPiQUj5g73fl1AAT0U?=
 =?us-ascii?Q?btHBLvNgpSS44r/8nFtc4sjtkw+LU15gdN6xVsxRcA6Gl3s0NvqQT7w9n24J?=
 =?us-ascii?Q?yePU/MkJDH2gHFXB7ttEfPKckArCOwM3UffB4VqVm8IviZ/xJDQiirNdVqN1?=
 =?us-ascii?Q?F4hoVKyQ5HpuOuuzFXpyLWTxECKp+QYQv6xgM4KIP7oQPA2vI5FpoTkoJquH?=
 =?us-ascii?Q?Us3n/+4bnZ6nFG5xK68B2M4AigfuISQ0vjDa+QyiV0E0dquDJEuVW7tKOuXu?=
 =?us-ascii?Q?b3spwb5j70QOjo8n40xRhSU/A1JuLvEbuH2UQZA2pkxn+n3sAQyYqBNvb7dL?=
 =?us-ascii?Q?+gbF2BYlE7YmraednM+a9OMwlqNvLTLMIcszRwUe+TvIDXtV+v4IDkMype2M?=
 =?us-ascii?Q?BeGljQNUaFT8cJ0e1ml6MRYNZ4Zl4LxI/yzBqK22qjnjDl1Cmht+FojIrNB3?=
 =?us-ascii?Q?HdQGdnGThhibMeUCPO5XYCcPimod8hlknA/Fc1flMTdXLsJ3riClgbFyqsuG?=
 =?us-ascii?Q?fycq5xOXoN/blwjEd7SrCPOE7Un/s8bx2LWQpNb+YbKm80pmS3yOb3QBk6k+?=
 =?us-ascii?Q?kTXUpDPQLzzJzLJF2OqutB1LDnCUI/cBdbwA8lDpLFeFRI7XCPmAol9dwUKD?=
 =?us-ascii?Q?B2zVpIZHLTlImjKZUJUBeSDIDZarNX2tp/TijWE2V4+LIzErsa749d5cq7wO?=
 =?us-ascii?Q?B9WizvXNPmt4mcT/BUHcigLBIm4FDxAk+vZQFniJ/MRnstmwZ7ps/vp4BveD?=
 =?us-ascii?Q?wcohqqcs+yXezfs8Ws0TPOJxAr1CSkVOjaFgbJ98ynAHaV6NxC5ThZpbtJv+?=
 =?us-ascii?Q?3q5mYabxE2cu4xawf24tAW0EqxH8Jvv5eZbs36VMFooyu9vB3NnFDLr3tKDj?=
 =?us-ascii?Q?qDMAMQq42H2YyUquJydjyNpyCNFnixACblDbrAQQAUhbC4qapFthqoINWcdd?=
 =?us-ascii?Q?qL2Rti2Q6DQMnCH0USBN0tH2ppN7Ey/aQ5NcUdJYmHAW6+l/EHdUL3ftM1r0?=
 =?us-ascii?Q?Ue0xR5iNXb78GB/ChOZnI8UFtayRixXLUxN2y2RiloxW9mqNvpVntfZfmKjU?=
 =?us-ascii?Q?WBHPZ4ISxWDxz5AmKdHwMXo52uw025U+8hrdWd5fYmnGWMg5Y5ja/iJTaH/6?=
 =?us-ascii?Q?glj0TDf6rITgDG5szttjW8zxljHHKKyKwGVjmfkBunx7QdcM1L6tT3/KIGyF?=
 =?us-ascii?Q?jnSBRDLOX0lbINmJQrZpQecJKKZ48rRSN5pFIW2A79PQYEOwNtmhlIa+cpMT?=
 =?us-ascii?Q?G+G3oEhjIoxUMtis6emS2l4qOcb16FI2VOwNU6WOfxXqPGFTXsUcZrI50r4Q?=
 =?us-ascii?Q?c3N8pH4U8vRmu9fRiYOmsyO9gQiU4XqlTqwXovS4B8PwwCEkzpiPXO44uifa?=
 =?us-ascii?Q?K8b5/GmXhsbURtaP7zc3Snw8toglSNer7UyxZuc2oE0WCJb9M0qaQVBZxA81?=
 =?us-ascii?Q?y40Cdw3JsmI0e/EWUKDJOkTZo/qtUFaDTvIM6QSrBoXNmSkaQGVL35RHJzzK?=
 =?us-ascii?Q?6oWn9RIWk0zhVHYUhS/f+tnXmedpzJfV2OxEBLdVV7uykTFRGZBmTdaFm+ej?=
 =?us-ascii?Q?5V/0tRuwok+LZlob2YR/lOBjVGNCRzd6veSiiTrA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe038e0-b958-4839-7f92-08dd1a0133f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:31:02.7170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rd58toneTBEDJ3RzMcsVbkIHrfo3i49lWRFCmpJktKRBcHPI27Dq6/KQ0piGHrUZUI3h9AHk1lAQ6zVrpXHQaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10966

On Wed, Dec 11, 2024 at 04:46:22PM +0100, Marco Felsch wrote:
> On 24-12-10, Frank Li wrote:
> > From: Pengfei Li <pengfei.li_1@nxp.com>
> >
> > Introduce support for the i.MX91 thermal monitoring unit, which features a
> > single sensor for the CPU. The register layout differs from other chips,
> > necessitating the creation of a dedicated file for this.
> >
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v1 to v2
> > - use low case for hexvalue
> > - combine struct imx91_tmu and tmu_sensor
> > - simplify imx91_tmu_start() and imx91_tmu_enable()
> > - use s16 for imx91_tmu_get_temp(), which may negative value
> > - use reverse christmas tree style
> > - use run time pm
> > - use oneshot to sample temp
> > - register thermal zone after hardware init
> > ---
> >  drivers/thermal/Kconfig         |  10 ++
> >  drivers/thermal/Makefile        |   1 +
> >  drivers/thermal/imx91_thermal.c | 265 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 276 insertions(+)
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index d3f9686e26e71..da403ed86aeb1 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -296,6 +296,16 @@ config IMX8MM_THERMAL
> >  	  cpufreq is used as the cooling device to throttle CPUs when the passive
> >  	  trip is crossed.
> >
> > +config IMX91_THERMAL
> > +	tristate "Temperature sensor driver for NXP i.MX91 SoC"
> > +	depends on ARCH_MXC || COMPILE_TEST
> > +	depends on OF
> > +	help
> > +	  Support for Temperature sensor found on NXP i.MX91 SoC.
> > +	  It supports one critical trip point and one passive trip point. The
> > +	  cpufreq is used as the cooling device to throttle CPUs when the passive
> > +	  trip is crossed.
> > +
> >  config K3_THERMAL
> >  	tristate "Texas Instruments K3 thermal support"
> >  	depends on ARCH_K3 || COMPILE_TEST
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 9abf43a74f2bb..08da241e6a598 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -50,6 +50,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
> >  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
> >  obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
> >  obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
> > +obj-$(CONFIG_IMX91_THERMAL)	+= imx91_thermal.o
> >  obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
> >  obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
> >  obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
> > diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
> > new file mode 100644
> > index 0000000000000..ebb59eda92951
> > --- /dev/null
> > +++ b/drivers/thermal/imx91_thermal.c
> > @@ -0,0 +1,265 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2024 NXP.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/thermal.h>
> > +
> > +#define CTRL0			0x0
>
> Unused
>
> > +
> > +#define STAT0			0x10
> > +#define STAT0_DRDY0_IF_MASK	BIT(16)
> > +
> > +#define DATA0			0x20
> > +
> > +#define THR_CTRL01		0x30
> > +#define THR_CTRL23		0x40
>
> Both are unused too
>
> > +#define CTRL1			0x200
>
> Unused
>
> > +#define CTRL1_SET		0x204
> > +#define CTRL1_CLR		0x208
> > +#define CTRL1_EN		BIT(31)
> > +#define CTRL1_START		BIT(30)
> > +#define CTRL1_STOP		BIT(29)
> > +#define CTRL1_RES_MASK		GENMASK(19, 18)
> > +#define CTRL1_MEAS_MODE_MASK	GENMASK(25, 24)
> > +#define   CTRL1_MEAS_MODE_SINGLE	0
> > +#define   CTRL1_MEAS_MODE_CONTINUES	1
> > +#define   CTRL1_MEAS_MODE_PERIODIC	2
> > +
> > +#define REF_DIV			0x280
> > +#define DIV_EN			BIT(31)
> > +#define DIV_MASK		GENMASK(23, 16)
> > +
> > +#define PUD_ST_CTRL		0x2B0
> > +#define PUDL_MASK		GENMASK(23, 16)
> > +
> > +#define TRIM1			0x2E0
> > +#define TRIM2			0x2F0
> 					^
> 				still upper-case
>
> > +#define TMU_TEMP_LOW_LIMIT	-40000
> > +#define TMU_TEMP_HIGH_LIMIT	125000
> > +
> > +#define DEFAULT_TRIM1_CONFIG 0xb561bc2d
> > +#define DEFAULT_TRIM2_CONFIG 0x65d4
> > +
> > +struct imx91_tmu {
> > +	void __iomem *base;
> > +	struct clk *clk;
> > +	struct device *dev;
> > +	struct thermal_zone_device *tzd;
> > +};
> > +
> > +static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
> > +{
> > +	u32 val = start ? CTRL1_START : CTRL1_STOP;
> > +
> > +	writel_relaxed(val, tmu->base + CTRL1_SET);
> > +}
> > +
> > +static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
> > +{
> > +	u32 reg = enable ? CTRL1_SET : CTRL1_CLR;
> > +
> > +	writel_relaxed(CTRL1_EN, tmu->base + reg);
> > +}
> > +
> > +static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
> > +{
> > +	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
> > +	s16 data;
> > +	int ret;
> > +	u32 val;
> > +
> > +	ret = pm_runtime_resume_and_get(tmu->dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = readl_relaxed_poll_timeout(tmu->base + STAT0, val,
> > +					 val & STAT0_DRDY0_IF_MASK, 1000,
> > +					 40000);
> > +	if (ret)
> > +		return -EAGAIN;
> 		 ^
> Missing pm_runtime_put(). Instead goto out;
>
> > +
> > +	/* DATA0 is 16bit signed number */
> > +	data = readw_relaxed(tmu->base + DATA0);
> > +	*temp = data * 1000 / 64;
> > +	if (*temp < TMU_TEMP_LOW_LIMIT || *temp > TMU_TEMP_HIGH_LIMIT)
> > +		return -EAGAIN;
> 			^
> 		ret = -EAGAIN;
> 		goto out;
>
> out:
> > +
> > +	pm_runtime_put(tmu->dev);
> > +
> > +	return 0;
>
> 	return ret;
> > +}
> > +
> > +static struct thermal_zone_device_ops tmu_tz_ops = {
> > +	.get_temp = imx91_tmu_get_temp,
> > +};
> > +
> > +static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
> > +{
> > +	struct device *dev = tmu->dev;
> > +	u32 trim1, trim2;
> > +	int ret;
> > +
> > +	ret = nvmem_cell_read_u32(dev, "trim1", &trim1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nvmem_cell_read_u32(dev, "trim2", &trim2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (trim1 == 0 || trim2 == 0)
> > +		return -EINVAL;
> > +
> > +	writel_relaxed(trim1, tmu->base + TRIM1);
> > +	writel_relaxed(trim2, tmu->base + TRIM2);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx91_tmu_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
>
> Since you already have the dev pointer, you can make use of it...
>
> > +	struct imx91_tmu *tmu;
> > +	unsigned long rate;
> > +	u32 div;
> > +	int ret;
> > +
> > +	tmu = devm_kzalloc(&pdev->dev, sizeof(struct imx91_tmu), GFP_KERNEL);
> 				^
> 				here
> > +	if (!tmu)
> > +		return -ENOMEM;
> > +
> > +	tmu->dev = &pdev->dev;
>
> 	and here
>
> > +
> > +	tmu->base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(tmu->base))
> > +		return PTR_ERR(tmu->base);
> 			^
> 		dev_err_probe();
>
> > +
> > +	tmu->clk = devm_clk_get_enabled(dev, NULL);
> > +	if (IS_ERR(tmu->clk))
> > +		return dev_err_probe(dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
> > +
> > +	platform_set_drvdata(pdev, tmu);
> > +
> > +	/* disable the monitor during initialization */
> > +	imx91_tmu_enable(tmu, false);
> > +	imx91_tmu_start(tmu, false);
>
> No need to disable it here since both bits (ENABLE and START) are 0
> after a reset.

Maybe uboot enable it. We can't depend on reset value without really set
hardware reset bit.

>
> > +	ret = imx91_init_from_nvmem_cells(tmu);
> > +	if (ret) {
> > +		writel_relaxed(DEFAULT_TRIM1_CONFIG, tmu->base + TRIM1);
> > +		writel_relaxed(DEFAULT_TRIM2_CONFIG, tmu->base + TRIM2);
> 			^
> Can you please anwer if _relaxed API is sufficient? I don't know why you
> making use of the _relaxed API here anyway. We have only a few MMIO
> accesses here, so why can't we use the writel() instead? This applies to
> the whole driver.

There are not big difference writel_relaxed() or writel() for this driver.
Just original owner pick one.

>
> > +	}
> > +
> > +	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
> > +	rate = clk_get_rate(tmu->clk);
> > +	div = (rate / 4000000) - 1;
> > +	if (div > FIELD_GET(DIV_MASK, DIV_MASK))
> 			^
> This misuse the FIELD_GET() API. Instead please add a define e.g. DIV_MAX.

I don't think so, It avoid define another macro DIV_MAX, which may miss
defined, the related marco should come from one source.

For example:

DIV_MASK is GENMASK(23, 16),  DIV_MAX is 256. But if hardware upgrade,
DIV_MASK to GENMASK(24, 16), DIV_MAX is quite easy to forget update it and
hard to find such mis-match when div value < 256.

>
> > +		return -EINVAL;
> 			^
> 		dev_err_probe()
> > +
> > +	/* Set divider value and enable divider */
> > +	writel_relaxed(DIV_EN | FIELD_PREP(DIV_MASK, div), tmu->base + REF_DIV);
> > +
> > +	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
> > +	writel_relaxed(FIELD_PREP(PUDL_MASK, 100U), tmu->base + PUD_ST_CTRL);
> 		^
> You dont need to repeat the default value, so this line can be dropped.
>
> > +
> > +	/*
> > +	 * Set resolution mode
> > +	 * 00b - Conversion time = 0.59325 ms
> > +	 * 01b - Conversion time = 1.10525 ms
> > +	 * 10b - Conversion time = 2.12925 ms
> > +	 * 11b - Conversion time = 4.17725 ms
> > +	 */
> > +	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x3), tmu->base + CTRL1_CLR);
> > +	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x1), tmu->base + CTRL1_SET);
>
> Same here, you repeat the module default after reset, so please drop it.
>
> > +	writel_relaxed(CTRL1_MEAS_MODE_MASK, tmu->base + CTRL1_CLR);
> > +	writel_relaxed(FIELD_PREP(CTRL1_MEAS_MODE_MASK, CTRL1_MEAS_MODE_SINGLE),
> > +		       tmu->base + CTRL1_SET);
> > +
> > +	clk_disable_unprepare(tmu->clk);
>
> Drop this, and
>
> > +	pm_runtime_set_suspended(dev);
>
> replace this with: pm_runtime_set_active();

No big difference, if set_active, we need add Enable TMU here. I can
change to set_active.

Frank

>
> > +	pm_runtime_enable(dev);
> 		^
> devm_pm_runtime_enable()
>
> > +	tmu->tzd = devm_thermal_of_zone_register(dev, 0, tmu, &tmu_tz_ops);
> > +	if (IS_ERR(tmu->tzd))
> > +		return dev_err_probe(dev, PTR_ERR(tmu->tzd),
> > +				     "failed to register thermal zone sensor\n");
>
>
> pm_runtime_put()
>
>
> > +
> > +	return 0;
> > +}
> > +
> > +static void imx91_tmu_remove(struct platform_device *pdev)
> > +{
> > +	struct imx91_tmu *tmu = platform_get_drvdata(pdev);
> > +
> > +	/* disable tmu */
> > +	imx91_tmu_start(tmu, false);
>
> No need to clear the START bit since we are running in
> single-shot-measurements now.
>
> > +	imx91_tmu_enable(tmu, false);
> > +}
> > +
> > +static int imx91_tmu_runtime_suspend(struct device *dev)
> > +{
> > +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> > +
> > +	/* disable tmu */
> > +	imx91_tmu_start(tmu, false);
>
> Can be dropped.
>
> > +	imx91_tmu_enable(tmu, false);
> > +
> > +	clk_disable_unprepare(tmu->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx91_tmu_runtime_resume(struct device *dev)
> > +{
> > +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(tmu->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	imx91_tmu_enable(tmu, true);
> > +	imx91_tmu_start(tmu, true);
>
> Drop imx91_tmu_start() from the resume since this isn't related to the
> runtime-pm. Instead the function needs to be called within
> imx91_tmu_get_temp().
>
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops imx91_tmu_pm_ops = {
> > +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> > +	RUNTIME_PM_OPS(imx91_tmu_runtime_suspend, imx91_tmu_runtime_resume, NULL)
> > +};
>
> DEFINE_RUNTIME_DEV_PM_OPS()
>
> > +
> > +static const struct of_device_id imx91_tmu_table[] = {
> > +	{ .compatible = "fsl,imx91-tmu", },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, imx91_tmu_table);
> > +
> > +static struct platform_driver imx91_tmu = {
> > +	.driver = {
> > +		.name	= "i.MX91_thermal",
> 				^
> Please don't use such names, instead use imx91_thermal.
>
> Regards,
>   Marco
>
> > +		.pm	= pm_ptr(&imx91_tmu_pm_ops),
> > +		.of_match_table = imx91_tmu_table,
> > +	},
> > +	.probe = imx91_tmu_probe,
> > +	.remove = imx91_tmu_remove,
> > +};
> > +module_platform_driver(imx91_tmu);
> > +
> > +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> > +MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
> > +MODULE_LICENSE("GPL");
> >
> > --
> > 2.34.1
> >
> >

