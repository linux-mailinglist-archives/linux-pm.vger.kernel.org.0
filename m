Return-Path: <linux-pm+bounces-31491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9347AB13D71
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B666E189AB88
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C360E26CE29;
	Mon, 28 Jul 2025 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A78RZ4F2"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0538269CF0;
	Mon, 28 Jul 2025 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713719; cv=fail; b=AWuH+iIO/tEVWDOvY+3mIrtfoxm5idjeUUZKHOucfo0MrF18/kWu4s7+wGNNfvGWJNzeiqhtNu+jjPl0ich/gZU6BYVLGGDLfi8tbRe/trsNgKH+2+y7JWbQsYYe17vspnKbROgwYQLbG/JxjmyagmCuwOoMZ995iK4CkAIFym0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713719; c=relaxed/simple;
	bh=eBO41V0WV7v3r5DH7Ec0/TKRT/lHOzKeJwb0c1/ecl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U7mRDVxAfgVrCgGDTm28BGHHRef8iGsFUOf/7k/hFIGQ67N2e2vezyP7/wksx5jhG7Qy7ooDTcbb4xYGR8fEWMu58zRnbztPNjFpjvM1p9uyOFLe7+75LVtsmUTCy5dwIeeNRI/UUF5CYkPa3ibb5AJkmz1qGpsM+ITL7iyTvgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A78RZ4F2; arc=fail smtp.client-ip=40.107.162.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnlizEgBfCqK8Cr/UlHMEQeTnpojZHthUsNxdKq7kL8I7vmrSZKjuEeQQNWQEdPUF72gHetmrw5+0w5n5R0DYEmolE0/tPCgyOHF4BpsiPjrzaa3VhpZDKQJy+VsUcvAsu6J9q8EwbxfkMmJibtKAlAw8fpmzMNL/N4n6I6ut18yYK5JfwP+UTGi/KrOkPZwCT2c5HsQdq5+VSnnjNMyxb6Itl7KoISEDbCToNspHqsAhBoNFRpinCAK+oytOLeisc7qItgadHFIsybSSnYkutbxX/m/O8I/5u+/iCB5fhPyUisMSW//KZ/D8M9wV9tvzk+1OQof2DNceD0pwq2JbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sOk5ZAEQv9AH+YcCyop6EC4+kUDW2hvyg3KVsOM+pI=;
 b=GwdkSrhV9L4y00Odtd7zfcSwqQc8tWEry/6o0od/TyaMrMBud1ajQ2/Koazf7Sgp+AUOU4w57wJM9pg2xJbUgR7Y1e/aUhvMRujhC5QfHqZk70TmCco52yb2ST6AI39ma/7IY66mG1wYqVBTAuFUvhonU5ORNPRNN/xH9RjyaGgsqezNNcmUjxJGe0o4ZqJJVtGBQqTfcf5rynXI9jT9+VKMa9WhFJ6eQl9NfFsq6UfhjBWe1wnE8LnLMSZJWlV5lS34ohWjgV8HJWcAw0DS4cgzMMejT7fE31GUt2+Y16s+j+pgjARgPAp3gYoILEYbeaHVduCD01TNhbFRGK/8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sOk5ZAEQv9AH+YcCyop6EC4+kUDW2hvyg3KVsOM+pI=;
 b=A78RZ4F2VLCPZdQB9VNFUo9D3q4JTjb3WANfAhE4o5mIA2GT6ukwkzcInJyKDdk4rU60dXrVEqhX4gUre+CaUXT3iGw6FohgQ5Voi5V83lk4U12plq8URBzZkhObdlXDbmDDNuRDwhGjfrsmzt2Y0N0TcUWLCucoXa9QWnaMKn6rH53bHInbSor2XtnanNWWCQzYmgiJKlaWrtKXYlcaYbRVEYwDeq/3DgE67D/LhVLT3j4bol8x+DmDHLPSuDn+S3bq0PjdYehqBwuh2bHuWNGQJaBISqf4Wv0L6Gvmc+D2E/J36r09WA0aAAFqMT+vLVixRKBp0Y/YZB7C7pQk6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 14:41:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:41:54 +0000
Date: Mon, 28 Jul 2025 10:41:42 -0400
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
Subject: Re: [PATCH v7 10/11] pmdomain: imx93-blk-ctrl: mask DSI and PXP PD
 domain register on i.MX91
Message-ID: <aIeMJrZ8VMQCIS+W@lizhi-Precision-Tower-5810>
References: <20250728071438.2332382-1-joy.zou@nxp.com>
 <20250728071438.2332382-11-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728071438.2332382-11-joy.zou@nxp.com>
X-ClientProxiedBy: PH7PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:510:325::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c158e68-0c54-4274-4701-08ddcde4e590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jh2coHLuU8FioFH8m92yIWoktQPYB1XNqUwuKOyldv960c5nJHl4Otmml0Wa?=
 =?us-ascii?Q?sexpml+nMuLtlQFah4b/4jZjh+rdqN4o7uzH4vcUEZaQI6grnc9B4Tui15fz?=
 =?us-ascii?Q?2jfwEInkgsgVXSn4wMOSdTcUUfuylDiP8YrPL1aYK+KZiupqDE6/GrpMeaSs?=
 =?us-ascii?Q?2npdLRxxxUpzc0mr2WRAU/gYVxPSafSJd/Y+AM3LhxSUOYfp8h4RyFsFhD9U?=
 =?us-ascii?Q?yfIZvWfeUzP0TnbGN5F80r9SFcx/URI9XTwB0Hla7HXpRJxmMwRJ2o/VJdlp?=
 =?us-ascii?Q?vBgZdkUq26kDIb3mxA7ecO9mXMcUbwZFCjhcGzQOjYYmw97O3ZcUnmas4kz/?=
 =?us-ascii?Q?euWImQQwMDmEc7Ntpl308Q7L8yrqYYdpmA7Ir260HwbwmNA0Sz2Vu4Uaz+x2?=
 =?us-ascii?Q?yeewsdSoI1R7Xos72Hd54GFvxW7a7w9ov5Xm3EIJmAw+Ds4iA8pIO4X+Ngy5?=
 =?us-ascii?Q?eB98Slrrj50JNZLgpChecx2w/h9LT+/0h+n4sTMREdRnOUm0Z3bjhISGMIza?=
 =?us-ascii?Q?0yZByeQw/DNn/iT/rdcycZre5vcIJT7fruN2oDEBhYFIODJdSkydVmqd9X1H?=
 =?us-ascii?Q?CHHHTBrHVXgkobPF6jeXtj2djn8+lHy9DydNI0SY7i0xuZvIO3hNtaCeqeYm?=
 =?us-ascii?Q?moPjvrlCuYq0yDLJcVBj9Ydxiql4gPRQNV5s6C5HjXnQQXV5olXLit2W85Wi?=
 =?us-ascii?Q?DBYrC5qUdhQ0Dc8Tc2pPjBfg/z9E1NUCybakcA2a1wt39NcaDc/GmbZ/mnN+?=
 =?us-ascii?Q?fR1BIwE1zw6lNKyLgGUqMrKn96q/wMQ84g0O0x2H0eEylL7s3njWEatoVTSw?=
 =?us-ascii?Q?4XB3Y2s89UMUe81yqAnI+nmY7eTg5EQOWDZQqRW7X2+uYuZwH+Gz4CLlYSHk?=
 =?us-ascii?Q?siTJCWZWgD0OfMCT35W+D6lbRYnqRg0yXaAImoBUFyBDYNQQTmYDJTgRJPkk?=
 =?us-ascii?Q?E4QUoKbdcmwDh23122HtN7tvv9AqALLxvEnqdsRUR7e65jUXGoGEAzCB1PI4?=
 =?us-ascii?Q?/App96tSTsQXvBrOXVbAjT0nXxcekZ/f6A8tygE3uW1S8LcMSSAaQrkDuDrX?=
 =?us-ascii?Q?/QJqghSIhQLD7pJIjqgu9CTuc3x9KBmuhyo7olhEjpBO0wB61PZIYcevkgOk?=
 =?us-ascii?Q?ih43NeEO1UdefiK9O3GoP/BWe2WBGYigt/yfBBMrrj+04Qs/8hs5r1M9m7yk?=
 =?us-ascii?Q?par8TLQgPOQut91RzMFivfnvSbfUze+MQRuWRSxrurW/1pRSHsWL/Fa/9se5?=
 =?us-ascii?Q?9RMhCex4q6jdmcx70FLcGgua6FuBKHe/NO/ckbCqXqeI2ibql6syAlU/rCOZ?=
 =?us-ascii?Q?3v3Qy3VK7i0zS9qDb4gSI31Al/65UxvZhQo5o86I0F4vMoGN2QnPBZioTXyg?=
 =?us-ascii?Q?lBspx1rTk7bMy2SQjvFzVEXMyJNeXD9Qv9oAFo+2Gl55b/VGmNS8DeHEs5z2?=
 =?us-ascii?Q?YFolijEk6pG+PrD8UbyCgTEEqaMyd3qq1trBoDCt4Xqe9Dm1QAo28w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M5ZwhT1PGvM2pb3up9WWI0euhEf0qdO4lCU0FiMNpkunbYnsFeuLv2Foh14z?=
 =?us-ascii?Q?79jLUuD+7BGDIcaSflkPMSIOjcfh+kQWHDoKlFVSFo8E9og8ckvGC+c/AjGi?=
 =?us-ascii?Q?SBdy/SKokAZ1AdHZlN2PRU6Q9K+NwspnEwfGUENJp3vh+4uDyIAQawd4qlni?=
 =?us-ascii?Q?x4+Umh6yximiFsDFCJKGooFgZFMesigZ4fMJMGpuhbKzTvq624SOjO5p6gGe?=
 =?us-ascii?Q?6DBx68SyBD3Gs7chwmwuK2VN9VCL8HA3yQFMdWhAN4ZK4zeDVY8qzGJJHP2l?=
 =?us-ascii?Q?QcF4yJWTWjfpa0h3Ufy68KbOFNM8HvvnZT2XzmPnUfgcjJwg9PZbEw4sM0c1?=
 =?us-ascii?Q?i2HGseUMAW4LTln/XAQZ5Y4U6qee0DvaQYKl4PClsMDPKFqAxqrJdIVzlc4U?=
 =?us-ascii?Q?j2SBR2/OW8cnw3l36LjeLpu8TUj74/b9hG0ntTvWziR9ar5CiJp/bYBJumBg?=
 =?us-ascii?Q?++yedVG7HahRxf4OK6n2tKnoJHXeMEBCDHF0Kb7vV3Q9iH2yWnN+IOt+ov2D?=
 =?us-ascii?Q?QRwEKRer5hhhnIqmeYp6HckFovX/JhEIgyxXpAYvAykd52Nfv/2Jtyx4P+6L?=
 =?us-ascii?Q?ujkrA1gUoEbWGiT9jKf48ton+5NNsb/QS60rwAQ9pc4Y+Y/xkybEPhu0PUHH?=
 =?us-ascii?Q?OH2cCIvj4SsZMAVYeuJ/Ke3/FReumY/2nyfvR7+uK0uWdsL10OmYNYgq9Yqn?=
 =?us-ascii?Q?Ki9WkiFtoC0dZoV0+8Y73NbEIEleoZQquwtIIhijoJMdbQ5MthYXrNL+Dc1V?=
 =?us-ascii?Q?yOM6uiM+e1YhadLvlpiBUUzdB5Z8Re1ozRM6XB4uhKgjcPCMsmG4wpxb4Qo/?=
 =?us-ascii?Q?XWWrguSx4sSeNDcFNj30Cz6VuVtUBVMOpr+p/AhUUvsYmrF8AwTzkK25Qm99?=
 =?us-ascii?Q?OPADta4oNoWyGoq8Nj9OUnRJg7Cnfr8LXe/QT0V8e+4NpO2qIKiKz+sB4Viy?=
 =?us-ascii?Q?5N3t+5+z28QrYte0YmpsLwYmEd0zUg65VXl2q1/w0o6wQB0r2mReKjySD1qs?=
 =?us-ascii?Q?mnif5nK1bhGvK6CmaeoVZ0V2/txAr2EhdPymuPPgrb2cQ0yOqjnULXk+7SJM?=
 =?us-ascii?Q?//BcDeXblXzF90epVytKlLLsd2X8gcy6yNQMvr59zuMMhubU2P4d6MV7f6VK?=
 =?us-ascii?Q?/16+nG21cnhzuZvb3uAkuW+qi0sFPP0e//plT8/vndr8BbBc4Kwawvz95DxU?=
 =?us-ascii?Q?vynJ82MJ5ozyeaqWC3uilAwKrh5mE+1jZEkZ73XCy90+mJHOWHrM8viH6FiW?=
 =?us-ascii?Q?k/yVtnhWhuc81a2NJmQ6pxhMjflDtq2mlq2kcGVILwlq6Ec6xEmi5yY8lcjW?=
 =?us-ascii?Q?fo83X/VajffM7qMK7wh0fjD8snIlK8WzRd8HxZDN3KORoOurJfkG4ZBbVcrF?=
 =?us-ascii?Q?aZ+WXVc0tNRvd9B3gW+E2Mp4eWB5QgumU37XgxrC2Aq9KQeF6cGNfIFt05h1?=
 =?us-ascii?Q?qQUshX14NKY/y+eXhqc8Or6VguEQBT6OzTcpB21iu/y99dBsAnnLB6iSaFj1?=
 =?us-ascii?Q?fQrKbZaVJ182dupp13aLEU+E1JbTBLQkH8XIQVRGWBNSAegIQruX4Prf73s1?=
 =?us-ascii?Q?ZIk/iAJfF09Jtl6NFRArGyQ9CnkRUEW/Wi3/X/dB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c158e68-0c54-4274-4701-08ddcde4e590
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 14:41:54.5666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZ3Ua4gh7k2RnclWTDTiAWQhlht5Aigkms8Nau4weHgGwlRtQxTay/lnD4sG/D/2n8oZdOyX6qvoyfHC6kAxAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

On Mon, Jul 28, 2025 at 03:14:37PM +0800, Joy Zou wrote:

subject:  pmdomain: imx93-blk-ctrl: skip DSI and PXP power domain on i.MX91

> The i.MX91 is derived from i.MX93, but there is no DSI and PXP in i.MX91,
> so skip these mask.

The i.MX91 is derived from i.MX93, but there is no DSI and PXP in i.MX91.
Add skip_mask in struct imx93_blk_ctrl_data, then skip DSI and PXP for
i.MX91 SoC.

>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes for v7:
> 1. Optimize i.MX91 num_clks hardcode with ARRAY_SIZE().
>
> Changes for v5:
> 1. The i.MX91 has different PD domain compared to i.MX93,
>    so add new imx91 dev_data.
> ---
>  drivers/pmdomain/imx/imx93-blk-ctrl.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> index 1dcb84593e01..e094fe5a42bf 100644
> --- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> @@ -86,6 +86,7 @@ struct imx93_blk_ctrl_domain {
>
>  struct imx93_blk_ctrl_data {
>  	const struct imx93_blk_ctrl_domain_data *domains;
> +	u32 skip_mask;
>  	int num_domains;
>  	const char * const *clk_names;
>  	int num_clks;
> @@ -250,6 +251,8 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
>  		int j;
>
>  		domain->data = data;
> +		if (bc_data->skip_mask & BIT(i))
> +			continue;
>
>  		for (j = 0; j < data->num_clks; j++)
>  			domain->clks[j].id = data->clk_names[j];
> @@ -422,6 +425,15 @@ static const char * const media_blk_clk_names[] = {
>  	"axi", "apb", "nic"
>  };
>
> +static const struct imx93_blk_ctrl_data imx91_media_blk_ctl_dev_data = {
> +	.domains = imx93_media_blk_ctl_domain_data,
> +	.skip_mask = BIT(IMX93_MEDIABLK_PD_MIPI_DSI) | BIT(IMX93_MEDIABLK_PD_PXP),
> +	.num_domains = ARRAY_SIZE(imx93_media_blk_ctl_domain_data),
> +	.clk_names = media_blk_clk_names,
> +	.num_clks = ARRAY_SIZE(media_blk_clk_names),
> +	.reg_access_table = &imx93_media_blk_ctl_access_table,
> +};
> +
>  static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
>  	.domains = imx93_media_blk_ctl_domain_data,
>  	.num_domains = ARRAY_SIZE(imx93_media_blk_ctl_domain_data),
> @@ -432,6 +444,9 @@ static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
>
>  static const struct of_device_id imx93_blk_ctrl_of_match[] = {
>  	{
> +		.compatible = "fsl,imx91-media-blk-ctrl",
> +		.data = &imx91_media_blk_ctl_dev_data
> +	}, {
>  		.compatible = "fsl,imx93-media-blk-ctrl",
>  		.data = &imx93_media_blk_ctl_dev_data
>  	}, {
> --
> 2.37.1
>

