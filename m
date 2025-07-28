Return-Path: <linux-pm+bounces-31492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1596B13D81
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A8F47AC196
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583762701CA;
	Mon, 28 Jul 2025 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BAw2LqNA"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5D26FA5A;
	Mon, 28 Jul 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713766; cv=fail; b=b3J5Vg3/agMeqfF0eVCg/T+pSP1kMxytq1kfolFbs+ppdrxC1p9n10b0PMz/wQJnIEYKvpvj3SJKikiFZtVe5P+5XegJha+pw5+oPAXzu/MTaPbcHDA7ntbaFaMkPY7lzZAvFBm/+mjGZAHnKmfR5ma8h5J4MjA04POKLSq1Lzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713766; c=relaxed/simple;
	bh=RslF2CgIk4voSx4YPpJT4YEJs3pbDA8FGbxrxv8HF2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EMgg0IvWLjwP/Ji8MNI4fR/QINiUip8L3chUbOpb5UP+WTsQJgOF2mDvfRmJPa8rN6st46dpeETLD9+ueyUi2xdOCjj0ERwjKuKeLY0WcSUFG1oFcQUgroXtK7TPs+Ed8RrUnjh9V0U8pdEkuvXgh47FEmAf3lM+dsdTnxGtPcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BAw2LqNA; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3CfJJ1jnz47yMwEDUgKg71NGuualYoc+0ienwpti9hrwlSF/opxC8O+1mV6ILH6XfRdFCqAqM56xnn/jT+27n0KsMZsIGiDCHw5UFs30eBPBzhMfdOqkVqMeO2EUF+uXW2+bPmWgpKPczRc9S9BHjYab3lxTWCBRVKsTYT65TB35Z/pr+TaIeRQ8df2Nwa6+70324HL7M/Sl1wZyIu0e8X6aT6Gi8YmrRR/3yf4Y1j3j72Q49x5etSmlWVAsvFNqsWLlEglNATAcR5Y9nH8SvDvM6EPgQ1fGrHIyUHf/O5u93+/3j3UkLhcPjrue/VgyS1pD1tqC4AekJ+iUAyMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CnAtwcWfxxdD13rvvaRfXZRU8G3IjUqXhAGAOjnksE=;
 b=CVBl+C9cKNIwad50YT8/oTcV7U8m7QHx5ONGQ7H8rlA+YqDELD8asezaKFR3zLRL7eH1vsdoEhvRQZw4pKZfv84cC105hjoOFTU0MwDKdulQjKyH+HAjTBJAp4WNohtid/LpC3fv7YVcG/MBQSGx4Xiq6K9S65EoV4s/y1RAkVGIrM2r7jqS+NdvbM2gsbzNHIyyah7WQ/P/EtZy87rja0y2ZvbW4i9+oUQQ+2ks1oYokwbJ13eC8t5ot/bBUOGIMMN4bWsBpqFwKojrwFW6HSMX+eoMQ+2OyXkQr73EMNa+31BJvhX30nts+0rh8bosw+kuaMLScQs1E5pQELiwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CnAtwcWfxxdD13rvvaRfXZRU8G3IjUqXhAGAOjnksE=;
 b=BAw2LqNA6mpdnSC9evb6mFy/16zcrvVLapugx9Y9GMK1Kcs1n3tgWdSfB3QeZSrph0dvEtEfn3YHRQ7Pq98DZzsrUbreC9Yyl3cYvCUT5hTH8PHhl2TCjY5pW/hh5KqpzCVfXs6LwRcBBFyIBg/Jjs6qOFF6aMzBtBjxLTNnoLQI4hPhrf5UVznyhT+Vockw0TxK1avOic++CFk1QPMZKx4E4CDKC+qhdwYnUtPZkf+aiRPK6hvoVGtp3r3cx+LwG+JtB35Bm+b9B69DS/IE3BDAbDnKuP0QSkxiV0sA6WNcQ1LsEJe1ALrhB4i8QgW/2IBUFaxasth9W5MWAdd+Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 14:42:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:42:41 +0000
Date: Mon, 28 Jul 2025 10:42:28 -0400
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
Subject: Re: [PATCH v7 11/11] net: stmmac: imx: add i.MX91 support
Message-ID: <aIeMVLIHu+w9ZY3o@lizhi-Precision-Tower-5810>
References: <20250728071438.2332382-1-joy.zou@nxp.com>
 <20250728071438.2332382-12-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728071438.2332382-12-joy.zou@nxp.com>
X-ClientProxiedBy: BY5PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 12258e15-ecb8-48c4-2f6c-08ddcde50152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OOH0K7KpMZhnHtHf3BCNq/8oxsfV6e8FxRGKwXlX4ck7Sy9hYHOq7gg++YYR?=
 =?us-ascii?Q?cB1Qy06X5zdU9PUrUoVw5Ua0zZgAJSjckk6ThnmdpUGLjCbV4H/WTPxvlu8y?=
 =?us-ascii?Q?Mk+kTKEgDbX/JlN4UNxn6a+hKomwXlA/GiO8HR5g0Q5/Ikbk//3TkDL/CNXt?=
 =?us-ascii?Q?pOB3m5gm17pJ/3XPZRgcrPrV0DlOwrDWj4IDcUffl5lmRlgmCCeRbgkc4HvJ?=
 =?us-ascii?Q?c6vdWjTbXatb88iD6UAZ1JYFSrAs0voiUY/4PA4Q8jwfmyX40to57k5S7Ai7?=
 =?us-ascii?Q?SmB7jQRJBzDZSu4FOsLveTsTwsk46e0lPJ+tbT193uifebq/GTzWTZfQsZqI?=
 =?us-ascii?Q?Y1D4vYxM5KVLM7QmMcf0RwrXte/v8EEdhK1H73ZpC0j4TQdiUURsrz5bcFH6?=
 =?us-ascii?Q?i6q3yj9BuVXh1L1gM3gwqOfmRA5hePJMOZu+wAei9oyQsoyDA5/2Hipk4yA8?=
 =?us-ascii?Q?tt6Db4ReSQwHShR2cRbvBv3cKGoZLxjEwIOZXGMRB971LfIdr5Fl71jVBdJN?=
 =?us-ascii?Q?SkhBMCIL24oRzZovQXq7BYGHW+kMFDu5gHUm6FuJdjOrqAi+o4o5LdWlBe9J?=
 =?us-ascii?Q?3IA3npBQD7mJb5GEKHF3l5rionaNAKFf8vH0Eusngmk3LvL4pluadA93LNdE?=
 =?us-ascii?Q?eoZK1K3aqKpMowSKI30BJ/9lmxCQ5+ZlO4SBWI7Ylt78qJZQv/x+a/hiOhnW?=
 =?us-ascii?Q?XVBjVVRG2Kua7ayctkbtuO/5jFxRAvUpR7Lw3svOeEndxBZ80/VoIt2hr3Ie?=
 =?us-ascii?Q?aV7H0gBoZv1BOtJiuxIUZoNbVj8xDWlY7gs/kYS0RoLRiEYikw61eTBjYTpR?=
 =?us-ascii?Q?zYocTXQyt0llfzoAUrJk9T2s+r//lzmmVN3Jk9E67+4X5eq7EDsfZmo8+cBT?=
 =?us-ascii?Q?cS1mIWZSrppBMkbJm15yYIUoSWabGW081seBbsHRyyDxsWpdBMVlmAs5j5tF?=
 =?us-ascii?Q?NChIwxvGIULC5Y62wml7Ks0FMuPBjvuiAPuThqgn120wbi2GJTQG9YgrrXc2?=
 =?us-ascii?Q?r+f49o7s2NeyNLqlr5rlhvUg25XBITTT30elO64v/nCC9vduGRw/NSNlNDA8?=
 =?us-ascii?Q?/q806VXVSXIe4rhcbVapI0bGgBtm2gP8AS2eYgsRbDXgMOL95gG4m/dufBX7?=
 =?us-ascii?Q?/sXIgSuIpBdszYDpDJFeitn5x0DOWC/tDa1FO34XKSVUb0hUuJT0MtJ7U9IO?=
 =?us-ascii?Q?2Ghe5s/yWs7Zc9N7+EPungmxXAadgOjP79POoAL65ALR3Q9esEK7Kz3qLCfe?=
 =?us-ascii?Q?46H6hHoaTrtqqOQRXzwYXd69IBrSeXIzdfFwt0ROGICLZ1Ey8JuHhQwFq/Wg?=
 =?us-ascii?Q?gRaJkHqDhumfpT55WZMgswALlICxPtVJ6RoJtNYrQBzY5ar6MFy6+cmeb5bK?=
 =?us-ascii?Q?CYMkIAGuc7F53I/VEAioGd47cgwmCfSZoUUXroCLCBkUtsC6+lmshUC4el/K?=
 =?us-ascii?Q?5veZYN+R7VP/Os7dUFirTSjGI1I4QqfOrw626nvIMEJxhx9YCK3Nvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?427XJH8NF8rmiayZutrO8fUFVzP6ZGt6u6Br5xsMp9s+jTa7XKhiHh4u/nNm?=
 =?us-ascii?Q?5xKBtwYuyTRVyCBc0Es7qpX6Gk6t59bzAuoTjpAlkp3wJ/ZDi+t6cYjQkhc2?=
 =?us-ascii?Q?I42/GrUZ8jqH3Y6DtYPWEspkvOmuz4qm7ek7xwxZWBJhTceHqba2af6G9ZLh?=
 =?us-ascii?Q?Lx9gLpoo/0bHqMtIT3/juQok+K5pc+tmEvBH+H4Ghgd22Q3B3qiM6eCYJvSw?=
 =?us-ascii?Q?yN43MuGfwoIdYmNpJbYy6behTETNKmtUH60/LvVL3Jk4iZpcVvqhYkTYTOiX?=
 =?us-ascii?Q?L6ouK81r4XbIAhTELKtoGOUmP3VVLlkP1393zwBNUqfumuFoCDtzhpHIdgNP?=
 =?us-ascii?Q?KokrR2eZEYzBStNgpAeCFoGC0s9QscJce2dhD25QlxjGBOTrwQSXQIzT/h7P?=
 =?us-ascii?Q?cqCJjOkIOfq6Vukih/ix5UmUY/m4ocwU1kYChRtPR8DIoif/4UfE5GHWt6eE?=
 =?us-ascii?Q?c4Z2aftnqI9c1sUHMALIKjWb0GLtVqLLB0VylRELgqW5xZJ2nr18H4fDJQ3U?=
 =?us-ascii?Q?xrjXE08Jg4ddyJjSmOvgJ2fwkpW7rOgDfpCRzwus7m5pms1cx39CrkFHpfCk?=
 =?us-ascii?Q?bDu0oF21BGg6TujoumeWpjKyhF1VsIXjDrM4LsP183ZfGvCNFvMBE++E/KBP?=
 =?us-ascii?Q?lQ6jQED6C3J/yDM7mMkiytJjTAZ1ShF+vNTOZUCue+47IhE1fhhNpOtUuIOr?=
 =?us-ascii?Q?rlAkYMSM7Sm7gxkJ1SNSAbA0+PP1RQjVqDdisGBGZESPFsKpXfIWTqTq5qRd?=
 =?us-ascii?Q?ZR4lRTaLnZVT25QXIcGOS/JYs9tKHAp6KMrZbZy4iJ9M88cRQU2BTTexmbgz?=
 =?us-ascii?Q?2nwskbvZaG0GOGcZHkhckCIfEY/EIkP8MGOyyvh4PpUmfLQD3+dwEL5Wz/Y9?=
 =?us-ascii?Q?fDEJzYq9AoQFBiIxExjsXDXTL7L+qX93+quKfLGh5EslzPi2/rdhGwqB505a?=
 =?us-ascii?Q?P+/upyyjSIkPIT+AjxVsr4iHNzzqfXnazYB1ExO6e0KTS4XosIaqm903nKbb?=
 =?us-ascii?Q?Lsh+N4Wj9bVg9N1alCKfF6zbH6J/+C4YbZCbXo5+8OTNSx/RICbcnCeMiuvP?=
 =?us-ascii?Q?6I2BgrES3DbMse1apG0jjHCb4cxxOBrGxxgQqqmI+c5CG4EgJKR7RaWrIaCc?=
 =?us-ascii?Q?0d5LV3pkEzV8WUdnm7ydn9AwIl56uaGh/SNURxUFY/4LTtVNssjPJGE99yV7?=
 =?us-ascii?Q?dFN41LuTSkgq8lDbp6FzvJkSL1nr6MEB0mlCxPJbqqSs+CNpnC0X32l6H/T2?=
 =?us-ascii?Q?Koac8iGLEG0KCkZTHJ1qpvPcwI/Z+fdfHmISZvLfvFVfcilXvPbY4aPrWqAT?=
 =?us-ascii?Q?4qNHpdkZ5f+mLVTWvf65mkufJDQ/IbKecHNDASb21ewRxaESt/xBPq7mJ11B?=
 =?us-ascii?Q?IduiNMaf7oMRYOKtqfsm55dB6VBpL9uK+4JFc3I91qIc4ESnskR8/e7cW9tx?=
 =?us-ascii?Q?VUI+2lv4vx08zFMEzmVI98ZdSIUKaZa3q0t/H5Kxf2aeum49qSKkgkCod8TF?=
 =?us-ascii?Q?SKGpe29q6A7BmKUSiX3URjxzsPZgvFxsUKGV9ETW8Yatrw4rNEdj6HGZ2vxn?=
 =?us-ascii?Q?TYwjj9hHhCcWj1PRxPpUKJRuN+DmlZbfDT0NxN/U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12258e15-ecb8-48c4-2f6c-08ddcde50152
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 14:42:41.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruuH18oMygO/byesgoRP2zlsgO7qwrub4CtjfVviHPz7ULQvqUxbIxocLonx7pb4TcuqpWgyLLvrxthF+3H7Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

On Mon, Jul 28, 2025 at 03:14:38PM +0800, Joy Zou wrote:
> Add i.MX91 specific settings for EQoS.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes for v5:
> 1. add imx91 support.
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> index 889e2bb6f7f5..54243bacebfd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
> @@ -301,6 +301,7 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
>  	dwmac->clk_mem = NULL;
>
>  	if (of_machine_is_compatible("fsl,imx8dxl") ||
> +	    of_machine_is_compatible("fsl,imx91") ||
>  	    of_machine_is_compatible("fsl,imx93")) {
>  		dwmac->clk_mem = devm_clk_get(dev, "mem");
>  		if (IS_ERR(dwmac->clk_mem)) {
> @@ -310,6 +311,7 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
>  	}
>
>  	if (of_machine_is_compatible("fsl,imx8mp") ||
> +	    of_machine_is_compatible("fsl,imx91") ||
>  	    of_machine_is_compatible("fsl,imx93")) {
>  		/* Binding doc describes the propety:
>  		 * is required by i.MX8MP, i.MX93.
> --
> 2.37.1
>

