Return-Path: <linux-pm+bounces-32013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CA6B1C953
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 17:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C132160EED
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF93292B45;
	Wed,  6 Aug 2025 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H6vEQJp0"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011027.outbound.protection.outlook.com [52.101.70.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1772615;
	Wed,  6 Aug 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495454; cv=fail; b=B242d9DfnhANX6+5mXwkI1X2QXfGR6FQu96JXZkFig5COf8AXcPuiBnfFtAJDUbstelerPWU6OrMNI728z8RpFh3gLEQ73C9madPLfmW94g6wpy0STDs6qvTUYQ3SOj7QIacanZcOAl5q1UVJFc8HST1cahNGgqSqOYlRqWDiA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495454; c=relaxed/simple;
	bh=4r1EdSXHG+Zw+hKN1mH1yw3oX4qp7fUNJAVLn427Frg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hezeOfEw0o7u/iqblaPgn8lY2zzbXgYr/n3pPbZur/qGZgPpQ2BPvyyItZhqmn3EspcjI0DL/TWSARBdY+1PzUw512dQt1FVfTjETvKPaZaW46qlxrN8Iipp+YTmZ2+tXJigF+mzYNE7zq/cBSwwxplOD8KkgEMeb2Ck4HcOFQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H6vEQJp0; arc=fail smtp.client-ip=52.101.70.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IW+5dT3LwgFLLuEpzuFGkfIZuLBuTVotakY5zQ4T6PZMOs+b+85v8unl2AGPw28t9mhZpxyPSWTxtiGpS0FNrhvAbSpClbXbMU4ul0wbzQVjFHaAK3twvhFqlhu42BqzACEnoWrhbri04mIJA/UZHpvqPqTZvEPMJjvmtx+D/SvodegF7YRYbw5jG94nuPSHKvMECFjPbSVjYuDFKpsXPYonMwN4Ti7uEAG4adYBRdAkp3UpYrxZaRi0i7J2lQdfQBV9t4f9yu0B+Zxf0q/BXBlM/hysjaOi3gEmiv6eqT6CJWyChg7TeQ4v42xO24V6JnHzBFx+5konCLN+WjMXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oDx8oIarS8trZV+VCVuofz0Wkim2qQdsuC46h9LcCM=;
 b=PB6bUNg/EbuuYLE3bu31O1OKcoCC9RqzEO5RIpc9tbHPm4zhTZaJQetOeOI4TPmfkvr6yGfXlKbqnLe9IsFLl5vLhmQu9hZSIAx107OTqyLkBBZ6PoBIXRMTwqRdqTNGyItZt1aSPt3fRW6lxrAOcB6ccbZ7tY+5bJWw3USYYUB0E1+TaYpaz3bRBnpW0K90Oe3o4N2E3qVd0qsmtMSKBWQuy26zJn5Qj9AldtV2qC5yb3qYgjFNn33hRQEm91VvWcUgiZ0vNx8GlILCtbps5YYnOcm5dk+ouGhFIPft1CNfzkj/7v+HPP18BkmSxZlV3TxgNgPvbchX1PMtSM6+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oDx8oIarS8trZV+VCVuofz0Wkim2qQdsuC46h9LcCM=;
 b=H6vEQJp0fK2WLyJWDs9u/1/bABL3Ug4y/s2I+SyOC4y3M9jRdMQv0i1YkuG//8b5/2rVFp9YsbDRpSZBTO4l+k0YW9uzfoXCJIqJ5/O1J7TTzYJcFxxbYpAt9/DqDZlvXsOHFMZtcekSwNY+1YHAvboD3yv6d+hnqmpAQHh95jNdoPvZBMFTcQp9ULBJph8GXczrSQHhs/tCcpi/6obT8c5ebM8rNgE4gNGSg//rRUPlxUCMBMUVBUxQm0fAQIvJq5uDzb6EuT3sCAD65Sji+wo15MRJDyEDpk393BaatNoKcRZUuB6VE3clQirN/WLaja4P90zKIo4aFw2CJSY7/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7776.eurprd04.prod.outlook.com (2603:10a6:102:c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 15:50:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 15:50:50 +0000
Date: Wed, 6 Aug 2025 11:50:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, peng.fan@nxp.com, richardcochran@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, ulf.hansson@linaro.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, frieder.schrempf@kontron.de,
	primoz.fiser@norik.com, othacehe@gnu.org,
	Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v8 01/11] dt-bindings: arm: fsl: add i.MX91 11x11 evk
 board
Message-ID: <aJN5zggEETZYUPIC@lizhi-Precision-Tower-5810>
References: <20250806114119.1948624-1-joy.zou@nxp.com>
 <20250806114119.1948624-2-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806114119.1948624-2-joy.zou@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a22b56b-cc5a-4e42-8a2d-08ddd5010445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HK8tQbQyMphttEfdIKpzMZNU8UOl6DSGEX+BKUkraQlM/B10kf4OsMCw9lM2?=
 =?us-ascii?Q?qOKkHPYB/DcHBJ8noG52FQx2hV0eGHml58vkU+rdr8OPapuQ06K4MwFYcAUR?=
 =?us-ascii?Q?neT61yWx/5MXUtxrkiYv1hz2U2Z5Be1pXh4tTgXS4osT++yoEh1OH6ZBflZp?=
 =?us-ascii?Q?G6jYXcJ6TyCD+1+vK8Al4NmUvvtKqOsHEwWsrT74ygg5thWPG8iQIOyb8L2h?=
 =?us-ascii?Q?Vt0J89AViRxBFzJe6fp4GiTcKScuDMYMUrdsIiWs0WciQ77c8JCg53Y/ISjC?=
 =?us-ascii?Q?ea/Vvb1tmH+hKO3Bj+lMNeSS+nuv8nsiuNcLANAVwoZLRoUh8oJA5qWQYI7i?=
 =?us-ascii?Q?nZq/cS2PVn6Ct7F4+FPFTddIy0gfqhO9YObmxJ+Dwhcvgo6kx6+YPjWYyZb8?=
 =?us-ascii?Q?+xNBlNf76JA5H+u3rMysMuTAuoE9SXktp8PUDPuCCFX/AT0H7SCi7bSZb2e+?=
 =?us-ascii?Q?OxQ5TLbTxVW9iZS1V6OGbmpW0uaF4uJwClqHtRFMvx99nnUO6DKngVkL45mF?=
 =?us-ascii?Q?4ZYDNG2goPCqGdzgTvMYUkqsqO4kTqQeQXRIsZ8KEMRQa7Cy2wz8/cEkjCI9?=
 =?us-ascii?Q?pSGf91Vg23F/N9zFtOLZIz2BzhFdcpCbrTy4QEyBMhH/FsXcE8ct452J4Vll?=
 =?us-ascii?Q?5J3UVQm6nlTkSXep9RlNmKgEgfN+0YM8Wb272/wsdY6yFai7YKKlQVpY+1xI?=
 =?us-ascii?Q?mbDCYVPmyX4x4I8FSdBnygQBwtZRH6YJDlekve3GgzS4OPF60AaXL7yzwQYa?=
 =?us-ascii?Q?X6ZOOqfs7puyqSmzq81dQDSX45uqS+778Li1kWrOGVpCOUSOk1q73ucI7BFy?=
 =?us-ascii?Q?cxsK+gJh9oBIfHh1SCO6R2FfscC5mDxfZ0Pci3oSy0TuD+uF75Os1tDyk3zi?=
 =?us-ascii?Q?ztL2IiL4be3ZV9/QoZCWS2qdKk+n7GBcOhcwhGi2Szv+BYwY7dJPomT++ZS0?=
 =?us-ascii?Q?GqrB4g2UqiyJfp2/fhkuUpYk1LAcQyzvnZqtd3HVeCMJcgNIhHCg5s1o+e6l?=
 =?us-ascii?Q?6kO4a+BeyunAHEavmg4rdpwJhV8Nvo6jfmvgIKO6auEZAk/qxpQehigomALt?=
 =?us-ascii?Q?uaXCKrALAgGYNZMB/iYE5Yo3rMtJ9kiNZmJie7xGiuyrtNZC5eZLrCNl1V+h?=
 =?us-ascii?Q?jKXjBHHEQqoEfRl4l0BW284+GyRG+maCsocbiGCWo+NHamN5Npj/ZDlPrDPN?=
 =?us-ascii?Q?RVUOit5zCjo8iS2NK9BliSOuby75T+JRxuaT1psZffjt259pz0Zkhlj4l9Ad?=
 =?us-ascii?Q?mnXNkg9GZLxDfr93HDeUeNqGl3Jv2G3uN3qQxt0+XNws4T0Gkb+2pEr8pEBc?=
 =?us-ascii?Q?GChQn7uWeSOJDHhLXkNsTgOYdrYLaJSHolfCRGAWsJSuJQUwb0NmR4Lb9C8b?=
 =?us-ascii?Q?kshHIt/w5AOaj+vMsUDhR95edZyAgxE/2GNAnsieYow38D/iEToA2OlXAn5c?=
 =?us-ascii?Q?6LLPaC4TRvk8SXxkDfQOzXn3yTLQWc7OoanStheH0Zzp+e3ntXw10w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eWYYyzvXy4MeKxKd5SKgqPqcg9P/LQajJl+ZzJnhk2AoAFw64fUdZhdNG86Z?=
 =?us-ascii?Q?qQgwO/nDLqGNMRc+NfILTIJ8l3iGWLd21MeTA7rICa2tl8U2IQkIZOTP2Qlv?=
 =?us-ascii?Q?6KtHyaA++2rH5ATMB2l2lFG0wEcRgR2QVC5h6RVl+/Y2op3tEPN0Ezq4r7D4?=
 =?us-ascii?Q?CsZt3ul59/Mu/a9fPXmwu/jJQLnI+LM5dU2V1WeEpnqX+BcsB3DdSe0vCtQA?=
 =?us-ascii?Q?yRCrG2mWmXBh2kKulyAIEutmQqWfJEri/sUwR5qau+KxqXeyWKubS7brt+PF?=
 =?us-ascii?Q?a5iKZCIPbCKJ9AfvQ9X5DGqajiwaAjtgJ9GU0afHctl/9aW504G96sJJrtr4?=
 =?us-ascii?Q?Iwdyt0TGmsDw3kO3X/H+B4mIKonqEnhY2V/qHiD8AjtKvNdOlTX8NiOVdtPO?=
 =?us-ascii?Q?jBINTOdeSMihjkoq/eQAvQR8agzv68KuxlQpBMa3O6/QXXaOjwTLc5YbbWZd?=
 =?us-ascii?Q?NHO3uMnNJp0vYJ/+XnxlcO4SYUOcAHQrjFhqPS2T/waE8BQeaB2zOZM/dGp4?=
 =?us-ascii?Q?cHPUkm+lF952at4Qri/LoQ6D+7hig+NmY0Ntj/ERJy1dm8Oa3o+f1OImXP4N?=
 =?us-ascii?Q?XkkMyz/OJaOYz95sKl7GloY9/VtK7ZoApF5qD0tjCFq2R1S5Lgj8pIs+uxtb?=
 =?us-ascii?Q?9y9fI0if6C0vUcKnWpQ9yUrcGCtNjjy4IfIkmE1UKKK7dElWXDsP1d72le3M?=
 =?us-ascii?Q?ZGF6+EfaPcZZsXWO5l4NtqjUP7fmgre22amSUc6KV+CPggZfmogP/+Db1jlO?=
 =?us-ascii?Q?1CCN/mD4vaLt1yVYymHo2l71rAdzVJI5eigaYVxmKrJvIgOFT5EhfA7RNp2r?=
 =?us-ascii?Q?uZp/+aZTKfVk0PC/SSFld/veUWARH0aqQ1rBTeeS6Um5Trjj60fd6VD7FjDM?=
 =?us-ascii?Q?+By0JuVdQmE10IW39yR4XpmBR5aPBT4IzywC4K0HjJN/PK2TOUvN6+2Af7Zf?=
 =?us-ascii?Q?GqC9fgFq0crgO0bfM6pB3gdwTsma3HwXR8rS/H1fy0ego8qw5kEklAgzlo1h?=
 =?us-ascii?Q?eNtX/ZndnLykffY7xfe+WYVoRARcZadgtK7JVSNTXgN8YkyeXnLQXVXvee4X?=
 =?us-ascii?Q?to2CcODOrrOqGs89ao5d0KwKqNO0KEr7PuumSNT5LD/igvguKQRtiT11GKnQ?=
 =?us-ascii?Q?F0sjkPq3aNz9lSqpWYG3M2L6IsFev4Jax22duQdifHg89FgCj0nObMWBf9lu?=
 =?us-ascii?Q?LtM+ToPoKc8d+eU+VGqJt4ouRH4jGvR1FvD+bdiLuOu8+6BLXx/8D5/512V4?=
 =?us-ascii?Q?2Gc0Y3PWwXhYab1OSWFIrnhEYa0JMRpUegUKoT6KIxfSZYl0jej7H/o8aWbc?=
 =?us-ascii?Q?p3Yx19Z0A4P0oMJJcQtnz/80GhGVZtfkgD13BJl6DJ7OA0vXj4YL86VarpmW?=
 =?us-ascii?Q?EBdxcbdacQKmzNJXhXhsSJz8FNAf/43lK0efPYR0X1wuDZSKG3bhMHIOB735?=
 =?us-ascii?Q?7ehogdkn8ZbD/7vpCUwvkwk8wotbAbB+txY/EIsZVx4jHMtoVadSgEZhGFqC?=
 =?us-ascii?Q?lBArnEgQJMSys+3TFTZIe4ixzyJ7phJlyOvXCApKDw2r5+dLeHUPg2HE4q8N?=
 =?us-ascii?Q?fSj20CrNPzAs4aIP77PUWHON9vLw1n6YCxriXyvY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a22b56b-cc5a-4e42-8a2d-08ddd5010445
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 15:50:50.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1Aez/rNi1aor4W+uaTYHeqjsMdD25YVr2g0kAMUtnKqfjKh7IKD9rKAwJA9MYwUBvW3J+/TuuUP3g3Ko5Stsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7776

On Wed, Aug 06, 2025 at 07:41:09PM +0800, Joy Zou wrote:
> From: Pengfei Li <pengfei.li_1@nxp.com>
>
> Add the board imx91-11x11-evk in the binding document.
>
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes for v6:
> 1. correct the commit message spell.
>
> Changes for v3:
> 1. add Acked-by tag.
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index d3b5e6923e41..a778666b1d42 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1374,6 +1374,12 @@ properties:
>                - fsl,imx8ulp-evk           # i.MX8ULP EVK Board
>            - const: fsl,imx8ulp
>
> +      - description: i.MX91 based Boards
> +        items:
> +          - enum:
> +              - fsl,imx91-11x11-evk       # i.MX91 11x11 EVK Board
> +          - const: fsl,imx91
> +
>        - description: i.MX93 based Boards
>          items:
>            - enum:
> --
> 2.37.1
>

