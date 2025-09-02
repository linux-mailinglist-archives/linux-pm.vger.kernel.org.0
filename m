Return-Path: <linux-pm+bounces-33622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F325B3F97D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 11:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CA54E1634
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 09:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C052EAB72;
	Tue,  2 Sep 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HCd5ujJT"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2AA2EA74B;
	Tue,  2 Sep 2025 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803709; cv=fail; b=IhLfSVPhITOoc7a0OmyhUxWsDuWBBCY0ULeR3Ok7kdkyVeovtKGL9XvCcIK8qy12XP6G4QvgzIC5MdB9eejxEWSXdRxByuPvpJkFtuJzWxeNKZgCP2FNb1kftEy4VAOFMLHp070xZlSIXd1UcVZT6HEJcGqd0Fjtn5D8+d0+WdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803709; c=relaxed/simple;
	bh=tA2OTNxQC84kz6ZhE6txJBGwSWyBBX2X97po+y+i3xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HXESdxC+AavhBrioIS/K9pFmdCksTkhODu9jlR6fghaMZ6hzEM0JsXymhk9NkoLh+tG9EdE/3xM6dMtW876sq9beoNDqgsP30zcmDNBPAItQDrdYBSZUmeDZzAJ30Vv7s8+TxHj0nDX3RN3DZwVlOytm2dSTH/9gsrh+hoyg/+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HCd5ujJT; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esE5mwJ/Qx9OSV15ZYcks6eSB5AE2AgJlWn7sI5TEdMYjxDFtxb6yjOiSPrqJfjvZ/4T+iKSDt7Dau1ib/Q+//mMuFUk6EcDgsw2nBxV0JMLMCgbsYYaeWBdaO6I5J3NJWciVqJ8lUl3ZQmyROeK5WSFXHkEpGa0OMMeteN9d+lhg6D4+wqMeTCiTslY4KfKqvuV9S1s40yp1/E7wTg/Tz4IEpedV51Wxdsqpg0Pm5ckQ1yUe5qNW0ElSf1+Y24Y3HKEUgjVjm1qiAG8/q9gYIdQBjykXPzdFEqmU0Z2HiY8Wjcoz/HZxET/t+ENy9sH4AKKccnZ5pzmAFv0ZfTARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ui5LW5doAsFaUyzT/u64dxOmnoT/cDI84RbAvyET8E=;
 b=njhnmp/2Kmqyhdge9rbcXJkSvHDVbuXFX3MJfM03QHUdlcyqM9pT7/hi1o0UgTzzGxsRzCiFkInASh6n9koktws/DTeR1gsEnZnDEpd/6RshTYc6Nw2BrN9d/5oqGpstJpwDU/MPv1OZJNQQl50aRryK+HBsXIj/ps2+x1BDkn1Sk03d+weD0/OZSnbT66oUBhEm55lyNGtZLdHQosQDYWZNB0MrF+Oy/Hq4NovlUc0GS8mDsBmohiw3IoWTo3YAluks53htTwk+XuensnyibNH54CfIsijzX7Hoozu2jCyQ6Zmvem/8DogDJ+nTf9EDgeeEMt7f62a9KRk1IyMbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ui5LW5doAsFaUyzT/u64dxOmnoT/cDI84RbAvyET8E=;
 b=HCd5ujJTHjBn6becWgZSm1WysRc2/viFl2SiLd0ATq8BCCXQ2Ln/wI368oI9rwagJWJoxiw6zSQyngRsx8uEMu2HHSbGL/aPvMthw/SYy5PXfscVsfR0A9g4NbBRiEDKLnYvORZJkXRk+8DsdMqdOe5VctGVrxv8T0FMbqXoqvqAIa86riV5wVpfDPSkLpE4i/Ap6+t1XJRh0jasJCn2GJ+GiZ1q/SZvOzskzbFYegWoZ/mriIsxkBMbvkCW6jdQcps91g+m9UefyYdpMVjv+ua2nibiuHWDh8Rg1wzrUNgGDE8xRRh8aFHGFYCGbrLXWffDLVk9XLVi50Fh4K6teQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI2PR04MB10739.eurprd04.prod.outlook.com (2603:10a6:800:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 09:01:43 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 09:01:43 +0000
Date: Tue, 2 Sep 2025 16:56:02 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Chen <peter.chen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	imx@lists.linux.dev, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] usb: dwc3: imx8mp: Set out of band wakeup for
 i.MX95
Message-ID: <6xbv46nwyi3ozlp6bfd3pyhtje5qobezvt4qjhlkzqqgdvxhhl@phktny6qzozx>
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
 <20250902-pm-v3-4-ffadbb454cdc@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-pm-v3-4-ffadbb454cdc@nxp.com>
X-ClientProxiedBy: AM0PR05CA0082.eurprd05.prod.outlook.com
 (2603:10a6:208:136::22) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI2PR04MB10739:EE_
X-MS-Office365-Filtering-Correlation-Id: 22345c33-da61-4c53-1212-08dde9ff56a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|366016|1800799024|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BzSHBmu4KqJa8iMG8bk8snI55s5q/3eHMeB26OHmfqDsQrKG694lihbAPX+2?=
 =?us-ascii?Q?UPp3KqUDV44TS1HV2TQElJfpHyqviPr3QaSnuNQDrE8QSS0S41AazZSNqq0w?=
 =?us-ascii?Q?HTBZWyWUymk09tXKzLDQ2A7HVXkfEvnotMUGtI7a3xiGTotJ8/ZM2wc28IL0?=
 =?us-ascii?Q?rgOdL/p1TvgctZ0izDzFkzd/iREIhIc9txiHY1d1F0YnD5xXlPewfgu5SVX3?=
 =?us-ascii?Q?qsZCK7XHWUrYeN1Jk24vI66/H+0b7r4DiogfN+gur9FLVDELQ3WICxsYMmtv?=
 =?us-ascii?Q?TitgDqIIkusXTie83oBcgQHgarv6bOenfE0xPV/uKVbkS3ESGHEWYKyZzFHI?=
 =?us-ascii?Q?OBWs3BRwoVwdLFa7SIUQsx/+gDNzmHhfdtB7kyK8DpoYyjETdNS4pk8Kqb00?=
 =?us-ascii?Q?rRAvOFajN2DbSIdGxHMId1MhGZS7fdcbPqwUYaq3sKqcI+OnW/IVrrOkym6q?=
 =?us-ascii?Q?knWvpaSh7LbqeeUR7GIO2HU7TG6rAjH3VDDfWH995jNEI+qbK9mkeYMMNjLM?=
 =?us-ascii?Q?VBNly42Wj59yy273tO8Xwx4Y/wHGhl9qlnuhf6WyjlieGLJbpzbWzMWP11tm?=
 =?us-ascii?Q?WBY4qyygTmoBoUmDYgUaNhsa07OqhUIp4oFfv8nCU8FeuoqEKVpoSqAlsIbR?=
 =?us-ascii?Q?ksKzEVpMY2zXLaThLMM5OQ/qiXAwN0k87JBP/ypGm0YVvUVALP1t58Q+eEEY?=
 =?us-ascii?Q?4IfheQUCsXHMqWF5N8bZdTweKNocP1VUdc0NQ3NzI32X0M9dgWN5NahB4Qr+?=
 =?us-ascii?Q?IQpNBluoYK8iUh/GJKOW5NY47PJde928sXijqZbylYd6afeUXLDX0V4cCHDp?=
 =?us-ascii?Q?LKikn403UPfmxoOd12EHUDCKq/pstpt/J2F7Kz2YRE6WwkTTWj0Zov4Px6l0?=
 =?us-ascii?Q?RnYWnLw/3Yp2XkykEkNHlC9Sjycd4m2M7iBy+bk+PSCdlM4bvxh4JqQGhmm5?=
 =?us-ascii?Q?BaeFGERI/qHvyxYlUCmXoGp3B1glpvVt2PlOXvVkWPJLQOiT9eI5RLve+Llv?=
 =?us-ascii?Q?80ob5acmd7o7w4MglCLcBXSLJ2S/cLxs/jYn1dgm0SxAPVvOv+Cz49UjjlIA?=
 =?us-ascii?Q?JEEiFwTMum9DisJSrdgyYlviQs5+L/4FX8m7kUZ8U+L4Bn2IfcnRvishfEq0?=
 =?us-ascii?Q?V6E3IZVovovq2c2iRH1ONzKUx1d9CZ/uryW335kSyQZ2xERywy9OPHgIJwiT?=
 =?us-ascii?Q?9IBt/M8+Oi33+i7GCYe909sOmLMOYnAigI6TBr1gKvEtKheZ04MP2jIHmkfu?=
 =?us-ascii?Q?RzCg6UqkpJnbDJjLDOoSZrRg/uUsiIdoofwdx+2V7h4IW7TCd79lxKk9YbgY?=
 =?us-ascii?Q?5sbjNbxHxb0g0SfDUa8S6DZBYYpVj43dgHjmSaP51z+aeutGsgumx193f9bA?=
 =?us-ascii?Q?YbHXG+9E+YrbLNv3vctTRBv7b4jzWH5ulBZfMHTI6nDWSq2d1sBHSS6vm30h?=
 =?us-ascii?Q?9TF/jznxzuryYq0yniKJcmnwCORtF2O3ghFHJORlegKHqwZOP3ebFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(366016)(1800799024)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KT19s4J4l788hJbk9dICbZ9r4jMbsbojBjv7Dw5GoPFzXo3UuphfXWikhcGP?=
 =?us-ascii?Q?bgL9ym9N8I3IAhdYkzwOTuin/VGGJwQ84RPSD2o5J63jORvVe99LZVjNmDRv?=
 =?us-ascii?Q?5Y6GtdXRqIUz0YfII5o5rvBAPaIyXXgDG4I1xcsRzFmdw6gxe325pW6nT48m?=
 =?us-ascii?Q?B8RQpt7ok5QMGVYE+tNEEb7WHgQT7/TogIjl14CsH+sLFq4XQZJeKPCYWDZH?=
 =?us-ascii?Q?vFIgm8qBA1k0waGjDly2AjAgZydZcU+MLVoGumRdyVpCcm25knR6vNrruJIh?=
 =?us-ascii?Q?WY3E71KemiWzNMP7jAwr3fIARbdfYqy+DdadwAYelPdwgTON73lmfrZf1q5V?=
 =?us-ascii?Q?2WDdtwwyn4F748iF63IbFp+aRktOGteIMygjvO7SHdZG3mabLh7OnBGE3If9?=
 =?us-ascii?Q?8mZ2tlcXwr3K8um4q+DcVoexoxeK5rRH/tQzNK2mIiM7Jf2q3fLpmaR5kVGv?=
 =?us-ascii?Q?U5RVe1LYSkdZS/RYfCpyjfBS9u9Cv8ttBvkObqjjqXGrgCT4jl8yISQu9LYr?=
 =?us-ascii?Q?SKyxtlIbLv1pErkgzWbY0vZ1to0ydfYMIC3HEhVTv4zxvH8viZck7BSWYQhF?=
 =?us-ascii?Q?pMQyskh0BR69M4oqHWBEPqNZczGfvtxS37Kt32wNuABR5dD2vRrR9smXsrXi?=
 =?us-ascii?Q?dtPicIqi0BRD4MwpNtEyougJLCb3/DDz/l/r62CZdRMPniy/7ggy9DTiahmK?=
 =?us-ascii?Q?xVh2Rf3VITup1zXxfjmD6sioqmpthYE2oZMMVltPzLo6LswEzEqa2S0AuCdA?=
 =?us-ascii?Q?cHLjbG+jUHimb7WgNToDsVj50YL3eZ9yldKoo4kOmtUnfCd7Vj136M9uWMCM?=
 =?us-ascii?Q?4/YguIeotvEJiA6itjZGXMkLbi1IJUCK3C1s07fk1akZi7DuOgiKdY7tqsQI?=
 =?us-ascii?Q?G24IBposuinGI8L0Eb5/liRMXHkrtx3IbVY8sVmNGDZO8PGUfyQwU/NjJqrM?=
 =?us-ascii?Q?LOmfwrgqgX6ESaUQrMGX/qA3LLqZVQeyTmQteabWDzWQPp/2Koui2Q1QRt/f?=
 =?us-ascii?Q?JYT8xjHBz8/9CwHd3y7C7Yfw7KK8wzXeBlZU/4E1/Vjlo0dxx5B0KNWut1g4?=
 =?us-ascii?Q?pKCRjuLVaBJinOL1VCcRtQvSOAGSfYKGlEbdgDUdG0f7tRQjdMtALZBYdhMo?=
 =?us-ascii?Q?HOYQigMIDcOKWpxmvOdd/fo0HkX4XV1Q1fZ03q94ozsFtdp1pBa/53TwCER5?=
 =?us-ascii?Q?mNLcaMbbn9gX2PkniR9kN0laaEi43iqN5qlIliUI/F7KDUwAAk+kdk9mJi25?=
 =?us-ascii?Q?AKWkF61nMFcdQRZLzz7jALoW6kgd0HpmzKkQ32uRE+METi13kEqlhFHzXUtZ?=
 =?us-ascii?Q?Tmy8f/pljmO9RC8ZN1Q6pdxgecur7jnTbmIA6wMK5Z5CnbNpzfmbdOcqEm21?=
 =?us-ascii?Q?rSSEd9miC/IqMyKxQDViX0fsS6nhLTP2Y0KlgAXFU+N93tRCN1QcWAUv+jVK?=
 =?us-ascii?Q?NrIbc4mHyHYlv6Th9EV3etUiC9Wo4r28HY3unSI1zrIsvPXLIXBhFgNOoXj3?=
 =?us-ascii?Q?6Dfe7Wu3W2nQVC9TwdDeZBKqwnXUPryUkpjQHwEAdA2/7t+GOLoWU2BUG5EV?=
 =?us-ascii?Q?5U+vQdUQ/xjPsGKU3R2zvdXvolUm5PDK4NskiSyQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22345c33-da61-4c53-1212-08dde9ff56a1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 09:01:43.7654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqx6+3UNHlXXRJ2Cr4L0I+v9ApyJkUmV28vq3vEvO9aWgD4Blu/P4yCgohrSJ6MdUADMlarp0r+D55c61TOVHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10739

On Tue, Sep 02, 2025 at 11:33:03AM +0800, Peng Fan wrote:
> i.MX95 DWC3 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
> power domain(Digital logic) is off. There is still always on logic
> have the wakeup capability which is out band wakeup capbility.
> 
> So use device_set_out_band_wakeup for i.MX95 to make sure DWC3 could
> wakeup system even if HSIOMIX power domain is in off state.
> 
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Tested-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Xu Yang <xu.yang_2@nxp.com>

> ---
>  drivers/usb/dwc3/dwc3-imx8mp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
> index bce6af82f54c24423c1e1fcc46913c8456b6f035..fde158d1f6e3d89d261ed3689a17d703878c7e37 100644
> --- a/drivers/usb/dwc3/dwc3-imx8mp.c
> +++ b/drivers/usb/dwc3/dwc3-imx8mp.c
> @@ -248,6 +248,10 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
>  	}
>  
>  	device_set_wakeup_capable(dev, true);
> +
> +	if (device_is_compatible(dev, "fsl,imx95-dwc3"))
> +		device_set_out_band_wakeup(dev, true);
> +
>  	pm_runtime_put(dev);
>  
>  	return 0;
> 
> -- 
> 2.37.1
> 

