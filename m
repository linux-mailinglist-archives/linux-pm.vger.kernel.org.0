Return-Path: <linux-pm+bounces-28512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4BEAD61C0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 23:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87C03A3875
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 21:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DED524468A;
	Wed, 11 Jun 2025 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UfJiQ/QV"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011051.outbound.protection.outlook.com [40.107.130.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6700424339D;
	Wed, 11 Jun 2025 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678291; cv=fail; b=U5oE9zxRjBg1kvsF6WXHDA29KYsY3sWRVS9YSLB3miMJsNzS9SQV4rIX2hI/vo/s9E3CbAJ9BeSs3OZ23VuzoB3D05JrJpALDfeKnlGJIL3IgnWwneQav3sAcsczrqR8hfmbPlVO20Wrssjb0vy1tL4QoMytw4f9FdU41qvFSQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678291; c=relaxed/simple;
	bh=vzK18v9p3xM74IYvZGmwWT3sNiXIujleZBlRQUMVkRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iAfnwuNThAf8+AODVInqZbD+Zh1iZqHGjhVQYHu0A1Yk5WsrbBe2S4UnWADZzFfJf24b+yywOOxsIfQsJRbRp+PmPnXjpdSls1odOcs50lJjqFTrhB3IjZSEgwRmFQV0fTvC7iQEgc4wzSvZdjk6+SfjYo53ebAQwZ2I7x4SEwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UfJiQ/QV; arc=fail smtp.client-ip=40.107.130.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTsB5GL6IEwi4Za6B5EiC2TL7vPR+xET0QjThGE49H1vcC2mdCt4yLbfwaP3AeaLPpvGpZUua8aFL502shOL/NhihNapMBIZqCc40YS9/G4AH1P/VYIt1MijioVV0hV3ODz2MmlpslVnwiTqf9co7nbD/rWqUsK+2dLTLPcXQgBjsTDP+bCGXxKzqVjZ+mKctLXunK1oXCnSKqWMuU5X+8DS77hcEnrxr+KMIk4ENEbnEcubJ7FL/xLxkj8lns7yxIRxgb8Ho89tNxsz+3JP4C5ENnwMBx03q18tJazdN3m/MHb/4VR5Ct/utjOkpeGPVQ8gK92kaz5ofzKFcBVytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEySemoBgamZ8vmVnVFH04Y+dbAzBmfKSKh2gZKqp7U=;
 b=otDKfdbPhPOK45lG9fmBmqEQPdWtKym8BdAgqSGbBGzROmmi9HBNMxkmFCwvCpYKQLh/qRHBQ0lu30Ra2N1iPTKIpd3SpHuHgjzHhDmxKBCx4CQ1rxCC/zozJWhOAOWqyQ8Tm7IrLrupo7MlqbzwzzUkql8AwhsFPMXpIlUq9V+ReAgIu+fTapjnH5K7BmLIrsd0LRKqEaRFQjXVTPwgYdZyQlNV86MfoMEribJXMZSN+LT1lxDeP9UbWxnI3jFhDWfQB+oy+kxslW3gT/PftX1kDnV5x3eic1I4ZJ6SOss11HxopYAD+NB+hp3sn7H4Dg7BC3vKL7ny4LZn2rBHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEySemoBgamZ8vmVnVFH04Y+dbAzBmfKSKh2gZKqp7U=;
 b=UfJiQ/QV5HDI4H2DcrgNHbYKS9ZqTH6wagPRKLuIZBX/xU4OW9CRmfUXym2fF8ays64yRYGwXsZLXhUuKi8UnPFIHlannxJwgVRbLDfac2x1Tn8+6Z/+i3FPb6D20Gyu7vVC9F8PEV6iX7vIJ2XNRht+mGk2Esu2QoL+qmwpzirHS0AbECnTay2gB8o/o30CrNX8UJXRHKJUSdASXDulSvUcFUpkWpmCBlMcOp9oh9G3kOF7AJYZL9ZyaYzUpXSs6tOnhxvItvmlEj68dsW6FVMRHdHIXrppC8MtBkReIbcQHxkMvE8qpGum21c7w6kwvzwVfSMoYg2Aj6cTQg6gPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 21:44:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 21:44:45 +0000
Date: Wed, 11 Jun 2025 17:44:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: samuel.kayode@savoirfairelinux.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
	Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>,
	Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v6 5/6] power: supply: pf1550: add battery charger
 supporty
Message-ID: <aEn4w15FwM4Z3Xwe@lizhi-Precision-Tower-5810>
References: <20250611-pf1550-v6-0-34f2ddfe045e@savoirfairelinux.com>
 <20250611-pf1550-v6-5-34f2ddfe045e@savoirfairelinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-pf1550-v6-5-34f2ddfe045e@savoirfairelinux.com>
X-ClientProxiedBy: BY5PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: f494b46f-60b1-45bc-65c1-08dda9312e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xvaqqOakk18v+M5d+157PZtDOHo0upZ/G/QwllJqypW5hC/b4SuS6OeRFXaY?=
 =?us-ascii?Q?tq1WysbcUj/8dvTt7AFTmyUFCdn5EhE2EIP8/h7HqEBdi8LxeX1mq9ZML2WW?=
 =?us-ascii?Q?aIt8L/oerZw5NBwm6ljiOUKD1rI0C212l9ULb5912QaTkxLB4/h61fpC/FI7?=
 =?us-ascii?Q?fM4CZDTFuCFJUiPTk/Jxh9ucRSH4kaqT8dUIGqyPgTxLCwNTX/JdY09599L8?=
 =?us-ascii?Q?uD5Od3H4/BYuAmqL4wxzgrqiMSvzsnnRbjF3qPlXy69KWKVmfHETkyVtyGK6?=
 =?us-ascii?Q?X1li6p6uLPGf3HcSrK0nP8j1mXQXC5qXkOyJQDF3H/BgG7/gz67YFwh6RbRM?=
 =?us-ascii?Q?a4oKe3jKSbw6cwP87vmXsX7oA7ibx6yRM/3oobSt/0kNhplIDzGIXmXvtXj9?=
 =?us-ascii?Q?ar5f8qLFt8HQ/pP/pd1VPYLU6tZ9VdTs77K3GVGvy5mvaLNPmZPqFDH5dWym?=
 =?us-ascii?Q?dPbxAYaY2WY6eJQj1TF/VZdRnXUtm39DFHEWGNcL2AGSKqCngB3qYPyM0JzK?=
 =?us-ascii?Q?+bjGiBL9ZE5fg1GOHoCclLnBYjK4mQfsdXK9q7h9izjxqtEVfrrJ9kXXxniS?=
 =?us-ascii?Q?whF+dY/+SEFFOVeVTCRA3f3Hl1fNIXMnWt2SZTGQ1+LO3JxmqZYUIOWNeseo?=
 =?us-ascii?Q?GxxHngtUh5iDu6Ro9eoKG6pznnh8f7SHgonVtTDElgYpK1rjlPvX8K4frawu?=
 =?us-ascii?Q?lyE/+Hq18W4WXePlmewAxSyenDj4s+YYSkIQeiJ9Z6xtevYquEqjvd8s2fPO?=
 =?us-ascii?Q?J1o1GWg9KCDaAf9V3jalYq254sbsYWqZiAFWLF1LrV80Z1egr3HXfOrkjz+4?=
 =?us-ascii?Q?+MTufa8m/qVRuKU8ttXxnAxfc8JtGPsfj73ndSpMd5g7e2xIKSX/l4QHuq+w?=
 =?us-ascii?Q?dVmlIpIoFOFmYWLoYLSF45HqMQOC50mYdmz0wn4VywIZMFOronB2ngWkXmUS?=
 =?us-ascii?Q?0sNTG2uo354AVUTKa469qBBv6+Ia4A59FADaeRqx+0NLhaZShpSC5YrrT+Q1?=
 =?us-ascii?Q?vb/cQCHhNHHJWmxE5Tj7g/oQqstVvyh8mcFeu/r97p9scl11pJl6mt2VzEG2?=
 =?us-ascii?Q?9V0cjwQ2wy+mQogubFeYRMD7TC5JnqkBKSDjh2x/nXdfjgj6EyzFsfLXIQI1?=
 =?us-ascii?Q?cELacuWgPDdg6JC0yZ40qFAFfjAiEJHG/G5ybDDTba3V6F4+ITQ0H1wGqhhm?=
 =?us-ascii?Q?G3E9fCekTHk1K9hiljmMKxF9n8mYn+qFmy25zIP6QhlhOfkSoFRW46Wb+NVe?=
 =?us-ascii?Q?tIQQWl97RwHMU+LCbtm4SHfh5TV0cQ6fFOCXMDTLXMdHa19OQlhr7zLe0WI4?=
 =?us-ascii?Q?ihQpPSkL9HXSQ8geyag+sfPFmxaxTjyrJPgtJJP/ZMUja7B0vOBv6kOvKZyT?=
 =?us-ascii?Q?GRiUan2XE6T+N7nNDHmoDodXhSIF6JReKavT4cIVpRR5mY5+H1Xk37KPI9EM?=
 =?us-ascii?Q?RhFrqAUO9f2+vxskm0mZyIEXKQ61o7SlK53QVfP77vaEW7nz9N/hIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nhUhbWz8ExVs1Ly/xU1LikbXNHqWZERvAtVVu0KFKlrHslFgIPm8H1ElBP+R?=
 =?us-ascii?Q?2kBk9AuUBKxrCtIKibXm5gb3DUob5YH/Gkjp4/BZA27cHZxm04KLJTznCFtt?=
 =?us-ascii?Q?U37ATUaSandLJl4QeRWh1kbWwq1zSHY8zgf6iR3XeG/395XP5oD8hv/mH7Sq?=
 =?us-ascii?Q?gMDD7FYQVFYqVt7HhRspQbALGBBzUDInV0VG/iNlFgP0zHK5buBvXr/enfCh?=
 =?us-ascii?Q?6E72tmGEnouWF8+t73psWwAxBi7BU54jrXoX5dTkL1lhwbyNAl7ihq6+pn4X?=
 =?us-ascii?Q?Ngh9mvhU1kmbyqzxqTCpxXb5HDGj8aCgyiLP6BU9ln3VHNz81ajqN6qHPjyj?=
 =?us-ascii?Q?D4m2/FCzl/k2JTeuWGIPhvmXoL9Jh6ef3xDLwBNAGEubZkxHjQcb7ybbTsfe?=
 =?us-ascii?Q?PN+Mksb8aL5xsCK91R5cpROC7v95vGDjmsIvRhMvLVJqnNwGD+DtpYlvx/jQ?=
 =?us-ascii?Q?hFA6t9MzZoV4b64JEBAIYW0RUUOjlK7MLPXKckUJtURI4cNo2WpXCx0rr4QJ?=
 =?us-ascii?Q?YIgPPPEdivmnLsX+RmtmfTyYTC2Pj5r+UR6et0RhI0M1HmcnfsMyiyDdLByr?=
 =?us-ascii?Q?OeW4NoJzw8hNUg3zGLQPES/B+QeaDrvLH8kqDKkL0nuMIIEmvuQgAfqQ+ufS?=
 =?us-ascii?Q?fvJQB6MLdXzV5CEKSsg10gRmzuE5qR61m2kcYa8faaAouv1usDjprYIWTVs4?=
 =?us-ascii?Q?qHoA2o4n0Xu0k3StdX7107b7tZVF5MMa8wjRSMe+TlLgG2euFp4WfGm5qHPD?=
 =?us-ascii?Q?OcXdHcC/TxqgiFpQ6kYpg4I6UBnnc6Gsn/vPYSSnjKM8T95kKGDsUz6eqqzo?=
 =?us-ascii?Q?HI3SKtU86A8bvPCby+PbaP+aMmaJun3NkcSD+YEMQmB7YrIxvaUYqRGVAHsj?=
 =?us-ascii?Q?V5ICvqKwa1SqDJpi3a227bdF7bqwt3jKBp2UXHoyqvglkDT6JqCg8N0DMJTm?=
 =?us-ascii?Q?PqaI3aOBAQll3T2gyVTadCwSk1ajY1oOvUk0LMCUe+W6A/eIvgsXHCFhsmuY?=
 =?us-ascii?Q?KlusHGP62MrT7smQl05HkoQv3I8MiUbm2TtHwyLr2Ug2rP6WpAYtRB7NUEDr?=
 =?us-ascii?Q?E2eV2LT+jf50FMoay0xSEzh0d6w8N3pxLNIRQ9vkxhE0n7k5Ta2bw2BYbHus?=
 =?us-ascii?Q?cXQuxq9ekruGxLvILUxepGGc4UhJZjLEWbvkeK282fT5zh7DyUEUFkQ+OyBc?=
 =?us-ascii?Q?5mTFJYjOP97n5DTcqxE/DGrUipt42iC7bF1MtvjScA6j/Q4un30HaUqB85+p?=
 =?us-ascii?Q?8BsxRM1d5ooGjpLJsSmAX6DBWvaTe/WrQ/91GuZD5POCgpSP74H8btuJIIGB?=
 =?us-ascii?Q?5vfwuu8GkNUdN5Orc9TTkgaVCiinfs6xQDVJ5VrnkUCcZY2/gVuyTPXu+yw5?=
 =?us-ascii?Q?6FWWZMqYbbig+Zs4zJh0m4jm9kETpMNsL+RgvOJn06s5GjtFrn1iqYWxkty3?=
 =?us-ascii?Q?A9SFBKDbk3wWW9pcDfhc/nrtx7TxF88bAN3bbNW2HJPfjRsZHp+xrYd5RJc1?=
 =?us-ascii?Q?lAX2G+wodt7jKRVFxuDxyhFtptoXBRJnWaPYkX5aulJWhIl1aGuxlwL8K4yl?=
 =?us-ascii?Q?yjNT52aIria4K2MzZIvxFE3DFd3qMRiBGMVw1KCo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f494b46f-60b1-45bc-65c1-08dda9312e0e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 21:44:45.0388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSzugvpL9RpLgDVUS+xxufAvsNCDoufS3UY+I49Savz00yDFjtrosxldxrMSkoUcJpZyEWQ47RHRePLFOXRbyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886

On Wed, Jun 11, 2025 at 04:03:02PM -0400, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
>
> Add support for the battery charger for pf1550 PMIC.
>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---
> v6:
> - Drop lock entirely
> - Reverse christmas tree order for variables defined in probe as
>   suggested by Frank
> - return pf1550_reg_init
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
>  drivers/power/supply/pf1550-charger.c | 633 ++++++++++++++++++++++++++++++++++
>  3 files changed, 645 insertions(+)
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
> index 0000000000000000000000000000000000000000..3b4cdf4cab9659005f86ffb32e8457c7cb3065f9
> --- /dev/null
> +++ b/drivers/power/supply/pf1550-charger.c
> @@ -0,0 +1,633 @@
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

nit: these const string just use once, needn't such varible.

> +
> +struct pf1550_charger {
> +	struct device *dev;
> +	const struct pf1550_dev *pf1550;
> +	struct power_supply *charger;
> +	struct power_supply_desc psy_desc;
> +	struct delayed_work vbus_sense_work;
> +	struct delayed_work chg_sense_work;
> +	struct delayed_work bat_sense_work;
> +
> +	u32 constant_volt;
> +	u32 min_system_volt;
> +	u32 thermal_regulation_temp;
> +};
> +
> +static int pf1550_get_charger_state(struct regmap *regmap, int *val)
> +{
> +	int ret;
> +	unsigned int data;

nit: use reverise christmas order, check other function.

> +
> +	ret = regmap_read(regmap, PF1550_CHARG_REG_CHG_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data &= PF1550_CHG_SNS_MASK;
> +
> +	switch (data) {
> +	case PF1550_CHG_PRECHARGE:
> +	case PF1550_CHG_CONSTANT_CURRENT:
> +		*val = POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case PF1550_CHG_CONSTANT_VOL:
> +		*val = POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case PF1550_CHG_EOC:
> +		*val = POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case PF1550_CHG_DONE:
> +		*val = POWER_SUPPLY_STATUS_FULL;
> +		break;
> +	case PF1550_CHG_TIMER_FAULT:
> +	case PF1550_CHG_SUSPEND:
> +		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	case PF1550_CHG_OFF_INV:
> +	case PF1550_CHG_OFF_TEMP:
> +	case PF1550_CHG_LINEAR_ONLY:
> +		*val = POWER_SUPPLY_STATUS_DISCHARGING;
> +		break;
> +	default:
> +		*val = POWER_SUPPLY_STATUS_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pf1550_get_charge_type(struct regmap *regmap, int *val)
> +{
> +	int ret;
> +	unsigned int data;
> +
> +	ret = regmap_read(regmap, PF1550_CHARG_REG_CHG_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data &= PF1550_CHG_SNS_MASK;
> +
> +	switch (data) {
> +	case PF1550_CHG_SNS_MASK:
> +		*val = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +		break;
> +	case PF1550_CHG_CONSTANT_CURRENT:
> +	case PF1550_CHG_CONSTANT_VOL:
> +	case PF1550_CHG_EOC:
> +		*val = POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		break;
> +	case PF1550_CHG_DONE:
> +	case PF1550_CHG_TIMER_FAULT:
> +	case PF1550_CHG_SUSPEND:
> +	case PF1550_CHG_OFF_INV:
> +	case PF1550_CHG_BAT_OVER:
> +	case PF1550_CHG_OFF_TEMP:
> +	case PF1550_CHG_LINEAR_ONLY:
> +		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
> +		break;
> +	default:
> +		*val = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Supported health statuses:
> + *  - POWER_SUPPLY_HEALTH_DEAD
> + *  - POWER_SUPPLY_HEALTH_GOOD
> + *  - POWER_SUPPLY_HEALTH_OVERVOLTAGE
> + *  - POWER_SUPPLY_HEALTH_UNKNOWN
> + */
> +static int pf1550_get_battery_health(struct regmap *regmap, int *val)
> +{
> +	int ret;
> +	unsigned int data;
> +
> +	ret = regmap_read(regmap, PF1550_CHARG_REG_BATT_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data &= PF1550_BAT_SNS_MASK;
> +
> +	switch (data) {
> +	case PF1550_BAT_NO_DETECT:
> +		*val = POWER_SUPPLY_HEALTH_DEAD;
> +		break;
> +	case PF1550_BAT_NO_VBUS:
> +	case PF1550_BAT_LOW_THAN_PRECHARG:
> +	case PF1550_BAT_CHARG_FAIL:
> +	case PF1550_BAT_HIGH_THAN_PRECHARG:
> +		*val = POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case PF1550_BAT_OVER_VOL:
> +		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		break;
> +	default:
> +		*val = POWER_SUPPLY_HEALTH_UNKNOWN;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pf1550_get_present(struct regmap *regmap, int *val)
> +{
> +	unsigned int data;
> +	int ret;
> +
> +	ret = regmap_read(regmap, PF1550_CHARG_REG_BATT_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data &= PF1550_BAT_SNS_MASK;
> +	*val = (data == PF1550_BAT_NO_DETECT) ? 0 : 1;
> +
> +	return 0;
> +}
> +
> +static int pf1550_get_online(struct regmap *regmap, int *val)
> +{
> +	unsigned int data;
> +	int ret;
> +
> +	ret = regmap_read(regmap, PF1550_CHARG_REG_VBUS_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = (data & PF1550_VBUS_VALID) ? 1 : 0;
> +
> +	return 0;
> +}
> +
> +static void pf1550_chg_bat_work(struct work_struct *work)
> +{
> +	struct pf1550_charger *chg = container_of(to_delayed_work(work),
> +						  struct pf1550_charger,
> +						  bat_sense_work);
> +	unsigned int data;
> +
> +	if (!chg->charger)
> +		return;
> +
> +	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_BATT_SNS, &data)) {
> +		dev_err(chg->dev, "Read BATT_SNS error.\n");
> +		return;
> +	}
> +
> +	switch (data & PF1550_BAT_SNS_MASK) {
> +	case PF1550_BAT_NO_VBUS:
> +		dev_dbg(chg->dev, "No valid VBUS input.\n");
> +		break;
> +	case PF1550_BAT_LOW_THAN_PRECHARG:
> +		dev_dbg(chg->dev, "VBAT < VPRECHG.LB.\n");
> +		break;
> +	case PF1550_BAT_CHARG_FAIL:
> +		dev_dbg(chg->dev, "Battery charging failed.\n");
> +		break;
> +	case PF1550_BAT_HIGH_THAN_PRECHARG:
> +		dev_dbg(chg->dev, "VBAT > VPRECHG.LB.\n");
> +		break;
> +	case PF1550_BAT_OVER_VOL:
> +		dev_dbg(chg->dev, "VBAT > VBATOV.\n");
> +		break;
> +	case PF1550_BAT_NO_DETECT:
> +		dev_dbg(chg->dev, "Battery not detected.\n");
> +		break;
> +	default:
> +		dev_err(chg->dev, "Unknown value read:%x\n",
> +			data & PF1550_CHG_SNS_MASK);
> +	}
> +}
> +
> +static void pf1550_chg_chg_work(struct work_struct *work)
> +{
> +	struct pf1550_charger *chg = container_of(to_delayed_work(work),
> +						  struct pf1550_charger,
> +						  chg_sense_work);
> +	unsigned int data;
> +
> +	if (!chg->charger)
> +		return;
> +
> +	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_SNS, &data)) {
> +		dev_err(chg->dev, "Read CHG_SNS error.\n");
> +		return;
> +	}
> +
> +	switch (data & PF1550_CHG_SNS_MASK) {
> +	case PF1550_CHG_PRECHARGE:
> +		dev_dbg(chg->dev, "In pre-charger mode.\n");
> +		break;
> +	case PF1550_CHG_CONSTANT_CURRENT:
> +		dev_dbg(chg->dev, "In fast-charge constant current mode.\n");
> +		break;
> +	case PF1550_CHG_CONSTANT_VOL:
> +		dev_dbg(chg->dev, "In fast-charge constant voltage mode.\n");
> +		break;
> +	case PF1550_CHG_EOC:
> +		dev_dbg(chg->dev, "In EOC mode.\n");
> +		break;
> +	case PF1550_CHG_DONE:
> +		dev_dbg(chg->dev, "In DONE mode.\n");
> +		break;
> +	case PF1550_CHG_TIMER_FAULT:
> +		dev_info(chg->dev, "In timer fault mode.\n");
> +		break;
> +	case PF1550_CHG_SUSPEND:
> +		dev_info(chg->dev, "In thermistor suspend mode.\n");
> +		break;
> +	case PF1550_CHG_OFF_INV:
> +		dev_info(chg->dev, "Input invalid, charger off.\n");
> +		break;
> +	case PF1550_CHG_BAT_OVER:
> +		dev_info(chg->dev, "Battery over-voltage.\n");
> +		break;
> +	case PF1550_CHG_OFF_TEMP:
> +		dev_info(chg->dev, "Temp high, charger off.\n");
> +		break;
> +	case PF1550_CHG_LINEAR_ONLY:
> +		dev_dbg(chg->dev, "In Linear mode, not charging.\n");
> +		break;
> +	default:
> +		dev_err(chg->dev, "Unknown value read:%x\n",
> +			data & PF1550_CHG_SNS_MASK);
> +	}
> +}
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

generally save irq number to pf1550_charger at probe, needn't call
platform_get_irq to get from dts again.

Frank

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
> +static enum power_supply_property pf1550_charger_props[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +static int pf1550_charger_get_property(struct power_supply *psy,
> +				       enum power_supply_property psp,
> +				       union power_supply_propval *val)
> +{
> +	struct pf1550_charger *chg = power_supply_get_drvdata(psy);
> +	struct regmap *regmap = chg->pf1550->regmap;
> +	int ret = 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret = pf1550_get_charger_state(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		ret = pf1550_get_charge_type(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		ret = pf1550_get_battery_health(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		ret = pf1550_get_present(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret = pf1550_get_online(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval = pf1550_charger_model;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval = pf1550_charger_manufacturer;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int pf1550_set_constant_volt(struct pf1550_charger *chg,
> +				    unsigned int uvolt)
> +{
> +	unsigned int data;
> +
> +	if (uvolt >= 3500000 && uvolt <= 4440000)
> +		data = 8 + (uvolt - 3500000) / 20000;
> +	else
> +		return dev_err_probe(chg->dev, -EINVAL,
> +				     "Wrong value for constant voltage\n");
> +
> +	dev_dbg(chg->dev, "Charging constant voltage: %u (0x%x)\n", uvolt,
> +		data);
> +
> +	return regmap_update_bits(chg->pf1550->regmap,
> +				  PF1550_CHARG_REG_BATT_REG,
> +				  PF1550_CHARG_REG_BATT_REG_CHGCV_MASK, data);
> +}
> +
> +static int pf1550_set_min_system_volt(struct pf1550_charger *chg,
> +				      unsigned int uvolt)
> +{
> +	unsigned int data;
> +
> +	switch (uvolt) {
> +	case 3500000:
> +		data = 0x0;
> +		break;
> +	case 3700000:
> +		data = 0x1;
> +		break;
> +	case 4300000:
> +		data = 0x2;
> +		break;
> +	default:
> +		return dev_err_probe(chg->dev, -EINVAL,
> +				     "Wrong value for minimum system voltage\n");
> +	}
> +
> +	data <<= PF1550_CHARG_REG_BATT_REG_VMINSYS_SHIFT;
> +
> +	dev_dbg(chg->dev, "Minimum system regulation voltage: %u (0x%x)\n",
> +		uvolt, data);
> +
> +	return regmap_update_bits(chg->pf1550->regmap,
> +				  PF1550_CHARG_REG_BATT_REG,
> +				  PF1550_CHARG_REG_BATT_REG_VMINSYS_MASK, data);
> +}
> +
> +static int pf1550_set_thermal_regulation_temp(struct pf1550_charger *chg,
> +					      unsigned int cells)
> +{
> +	unsigned int data;
> +
> +	switch (cells) {
> +	case 60:
> +		data = 0x0;
> +		break;
> +	case 75:
> +		data = 0x1;
> +		break;
> +	case 90:
> +		data = 0x2;
> +		break;
> +	case 105:
> +		data = 0x3;
> +		break;
> +	default:
> +		return dev_err_probe(chg->dev, -EINVAL,
> +				     "Wrong value for thermal temperature\n");
> +	}
> +
> +	data <<= PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT;
> +
> +	dev_dbg(chg->dev, "Thermal regulation loop temperature: %u (0x%x)\n",
> +		cells, data);
> +
> +	return regmap_update_bits(chg->pf1550->regmap,
> +				  PF1550_CHARG_REG_THM_REG_CNFG,
> +				  PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK,
> +				  data);
> +}
> +
> +/*
> + * Sets charger registers to proper and safe default values.
> + */
> +static int pf1550_reg_init(struct pf1550_charger *chg)
> +{
> +	struct device *dev = chg->dev;
> +	int ret;
> +	unsigned int data;
> +
> +	/* Unmask charger interrupt, mask DPMI and reserved bit */
> +	ret =  regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_INT_MASK,
> +			    PF1550_CHG_INT_MASK);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Error unmask charger interrupt\n");
> +
> +	ret = regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS,
> +			  &data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Read charg vbus_sns error\n");
> +
> +	if (data & PF1550_VBUS_VALID)
> +		chg->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
> +
> +	ret = pf1550_set_constant_volt(chg, chg->constant_volt);
> +	if (ret)
> +		return ret;
> +
> +	ret = pf1550_set_min_system_volt(chg, chg->min_system_volt);
> +	if (ret)
> +		return ret;
> +
> +	ret = pf1550_set_thermal_regulation_temp(chg,
> +						 chg->thermal_regulation_temp);
> +	if (ret)
> +		return ret;
> +
> +	/* Turn on charger */
> +	ret = regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_OPER,
> +			   PF1550_CHG_TURNON);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error turn on charger\n");
> +
> +	return 0;
> +}
> +
> +static void pf1550_dt_parse_dev_info(struct pf1550_charger *chg)
> +{
> +	struct device *dev = chg->dev;
> +	struct power_supply_battery_info *info;
> +
> +	if (device_property_read_u32(dev->parent, "nxp,min-system-microvolt",
> +				     &chg->min_system_volt))
> +		chg->min_system_volt = PF1550_DEFAULT_MIN_SYSTEM_VOLT;
> +
> +	if (device_property_read_u32(dev->parent,
> +				     "nxp,thermal-regulation-celsius",
> +				     &chg->thermal_regulation_temp))
> +		chg->thermal_regulation_temp = PF1550_DEFAULT_THERMAL_TEMP;
> +
> +	if (power_supply_get_battery_info(chg->charger, &info))
> +		chg->constant_volt = PF1550_DEFAULT_CONSTANT_VOLT;
> +	else
> +		chg->constant_volt = info->constant_charge_voltage_max_uv;
> +}
> +
> +static int pf1550_charger_probe(struct platform_device *pdev)
> +{
> +	const struct pf1550_dev *pf1550 = dev_get_drvdata(pdev->dev.parent);
> +	struct power_supply_config psy_cfg = {};
> +	struct pf1550_charger *chg;
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
> +	return pf1550_reg_init(chg);
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
>

