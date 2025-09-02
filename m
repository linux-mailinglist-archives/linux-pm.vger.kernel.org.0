Return-Path: <linux-pm+bounces-33619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE86B3F94C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 10:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81EB4E1132
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 08:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC612E972B;
	Tue,  2 Sep 2025 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dTNMFyrG"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F4A2E8DF0;
	Tue,  2 Sep 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803532; cv=fail; b=n/LIWgNXmqQ2uIW/xi6N9oxJPrebw/wZMDTd4Fi0aWDPlHk7/FUu9NBpYDtWa164fLkbtk9ReyPOfIZoJtE/fVLI9uCP73bbiptmWGyfGi2HqA0xH4ZR3r9Ro2C5mgjr8fUpoBK1Q1VYI4oCRmOmLUqFW3Nm/ffgLtrzHRjEX78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803532; c=relaxed/simple;
	bh=byWtiz3sqJxAZ6YGsQOM/8IE+R+sKi1hwKWWipxjiCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OZvIaKBwJUOdI88/AOvjF6qT+PVSjHT/4JrkCcI9aiiYo7t2DELZeqeLAul9FXY1i2Ws5x9NHtYynasrjXDJZp0Kt9xZ/f3kdvB/S/4vQL9RKIY8fyqy27yF/m5Pq35Tt48ThUN9xiWzKcQVoP5MIcfiffSfkBkobzQn9qwsECs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dTNMFyrG; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xao+fLb2l6WH+LEDM/Mg/e2CCQLfxH/T+thrf0AKv2Dz0KJlEee8eAwz/alVFmIaLCkJcnKQXeytFPQjkzta/BByi5zVMOwAq6gtSHIL8U1745nyStqkQMiM/S68PFr1qBVa667JN+B0mL3Le0qtcSnuae9Fg5LXopc624DeL9KUqUYPHGMOkLD9zvar1aUFVWmyalOg2OMkq4UgxPNjQBVBHvRBrpCRb+m2xMHgFAY+YiqT/uOySNLuBJQ2Nx+vKV5wrikjAujAR3KleWM807yj/kjMUdW87eN7VFYd7zKNHXgdOBtFeuTvLN3UgXbvZlaWL1CQN12Mb3VRIbxneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql6NqRDVOPoMigrSdS161UwhF0iIyxKbARx1MIroOgI=;
 b=FDrAYDkzjRm8SJhlbY5vFiTr6mhBiXjmJnrgw8fBMPVAYySyvzWIdBE9oLsBRvVSAZUS+1jK8hR7kQ3TuJM/6hXvOSm3hi+ez7Xkw1irvuuVa6KchIkCUIIMBGR6dwKmZJjQloEN0uyOeIRfFrAlMY/dD1Ul6TEtHICBEWVDOJvboJ7njmmNMNrR8QQ4dQQKE04NIirL9/97UmmZa+xmJ/EEQiGgSKhTjAAmpXb2VhYAcdDAuBmYw/yKSiJfizXU60LRBgHcGQlurXOW6OJXrzMt5IsFEDIn2goYiC5AdAF1NjZzp1cCL1r1YJHCjGOmZ7qGjMQf60qxd7rY6ZOipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql6NqRDVOPoMigrSdS161UwhF0iIyxKbARx1MIroOgI=;
 b=dTNMFyrGVs5rQ2MxELQkoMz0at6BTDkpE9s9sDj+ib5RpPTMayZ5l4yhiQHnlSuKeoSVGpJZWAdxHPDjBoVVT6XkYNgpNB+9hEiqusv1A6rmr18u7YqJtuz+/E7PfJDlIIZ/d+mgzS7elqfXEqjS1hkL0XTXjmtxh7fJx5CrphzCw+bF+dWvQYf2I9ToJ7CzcT3Y225/A3lbeF+8t1tMiJ2fmmVP1YldQYNVzB2dzJriuGTc74WqSuITSsP2v9QweC9UvOpXA1MOk+JS7Iol4IXYob+TrmU0sLgN3DO9bDWUmUBVxjw/HCgszET7gwd3ngvFlvQaXHGeJK30MvYcgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GVXPR04MB10109.eurprd04.prod.outlook.com (2603:10a6:150:1b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 08:58:46 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 08:58:45 +0000
Date: Tue, 2 Sep 2025 16:53:04 +0800
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
Subject: Re: [PATCH v3 1/4] pmdomain: core: Introduce
 device_set/get_out_band_wakeup()
Message-ID: <xf2dzzyvai7hzyvc3a7ypi2453t72pvygm5uv3jfjmllarlbmo@gk4xjs6rfuiw>
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
 <20250902-pm-v3-1-ffadbb454cdc@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-pm-v3-1-ffadbb454cdc@nxp.com>
X-ClientProxiedBy: AM4PR0302CA0005.eurprd03.prod.outlook.com
 (2603:10a6:205:2::18) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GVXPR04MB10109:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4b62a8-1953-43a5-907b-08dde9feec40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wFRfZZUxaR78xUa2Sn24TLrn4LwRby877jNzMKkwlUF/uLZ3tJAC+bzrneCH?=
 =?us-ascii?Q?FfQ7BcFDwkh2+9bI23okvdjl1X95uKcz6ffxegRg9pyjB00GcJjAUhL2orDI?=
 =?us-ascii?Q?BD6mEE/keA6v6LMjrNMwEZ4nm8qm+LrTJA3Fc/9SP+GPu25un8jFVaVrZN5g?=
 =?us-ascii?Q?duQRPcKcm0o7FkxAbyop4dU7vFMlhCiXhHYitWu1q0e4cxMG8rmQHNJIqHU3?=
 =?us-ascii?Q?TY1MJzg1KMCJh2le1ZWiTo4y/8Oodr5tvCILp6nXLOf6g0Qs9sC4gYzv1da4?=
 =?us-ascii?Q?zEarVelhepZ9H7bhMmFu4ItPQS987hDmWfEFM/SaURo5DkVmrmoKc8hmEATo?=
 =?us-ascii?Q?CE9kF97qIBBDC41pPv/sEUgfVUkuBh2HZAR8PA0qUth2grUAC5VIdU6+vLjT?=
 =?us-ascii?Q?a7GIiE5YycIMohEThBOC6bQuZWcSDTICPtvScMvrt2NtBgGP2573JwN/1Gin?=
 =?us-ascii?Q?O/f7r+aOPsCxecs7wnBnogA5IjIcNFODEHaAVhTjW4dh6RgYxU3t5ofe8i9n?=
 =?us-ascii?Q?0KAGnMZ1zv8VVSNnXhmqlDy3gDwO0gn+I7mUru1Oa4ZSj1E76u98bCIDr23h?=
 =?us-ascii?Q?ADlvbBKYpP1LiuEJAOFmrQyILMuyyiGyf3Reefhu1XRzsewsb5GA8q4TV5L1?=
 =?us-ascii?Q?HlzMPFSsFxFgGMuSGiCDCMB+QkG5IV/XlQBqZubWm8AnlZrEintzKA6Gpegx?=
 =?us-ascii?Q?9CfnZiPpfCSd5zJN2xBW3ZQpEvPbIfmw6o+OLG8AP6mv8GJ1U5i4bJaYHnQx?=
 =?us-ascii?Q?P8JsxFOD+ojY4a8eN2z+PYuXLL8CVcmt57pqs/GBwTL0RE5A6TOEgkyUkJmC?=
 =?us-ascii?Q?Jcs1t7ttxxfUsZpdN9bA4AkDW01qVr2NCcOuj1UAXCBAwE0D3lWn6jfmjrGT?=
 =?us-ascii?Q?xxXs5k6ZMW7q2mmpE6ZAweyw3fpX0TjT47dqSwdtXfdbN50lVhVm2Su764+q?=
 =?us-ascii?Q?B395iBq1TCoivhuV2SAj2tmxqM7CBCnDfHyhMUUsDGICu59r7vzlhf+88Rpg?=
 =?us-ascii?Q?d5xhtrF+jL49Cr3rDpPJgdYpmd1a/rodq4NLTIhexKz7DAVGsDhTAvUp2FDH?=
 =?us-ascii?Q?0JN0RVDEdaCkKGmN7oTEKi5aWk9pvqGvHoMnZYQs2CCDi3+P3RASXniFyMjg?=
 =?us-ascii?Q?rdjvm/7BhEL6Npj77WEkYPoIgA8vHDuvbJTXx9h+5Ec+54CR8rVkav1MIRit?=
 =?us-ascii?Q?Hp9bGdO36KH5VUdx10Sl60oniXLq1wBmAZru3dJGOE24ExQ7bPo4BpPaZUpo?=
 =?us-ascii?Q?3K/8FLTskoNXKKriaWq0/qAfedoriVzpEwwNLptdZzdFOoo8YHS6da4qTcRP?=
 =?us-ascii?Q?EMKvhCB/EwDenf29m7wyxvNl2FpEOfDuT5WtD0sNHfxZXNivFZmMADBrCg79?=
 =?us-ascii?Q?Pr652K5DoSmZBYXfclilO4papsYU+ik/iBjMwR1R+xcO4vOGxhmzp72r4O5o?=
 =?us-ascii?Q?aBDWv7wd/PUPekRIyG04ZeNqn/4Pj4FH22dG3Izxf5TaiQdUC61bFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ObkdcNBMQVNYVyf1wcJE0duQsjykDVYfzyHoYK/RQvQTO8y+CiVmaPqwGTO/?=
 =?us-ascii?Q?HG/leDmPL+GdEDqt5pcpsCy8+4O0UZqdXw6jaMnYpPXh9c4Bh7Po6f8j35K4?=
 =?us-ascii?Q?0jq6Vgj6NA4vqP7pdh8b1kDqD7hyvMokHyYsl7//O41wCJCwoXZIy06IY4Sn?=
 =?us-ascii?Q?mT1wGeJKN31m4Pc+N7M5OEh10qeYVD2lWYdybeQb3+B7P3P5yJRERLxWW7rl?=
 =?us-ascii?Q?BA6PNAQuG3LtE7M87kCaIPUpBXw3uM2kzijRlOCrj7ITaYP8JZPZNL58es7R?=
 =?us-ascii?Q?k7zY4DNJo9sZUx5weKGOlBjxWj8ZlBmYvMFp4cLrBW+IEspVyMj4fzpDfMpT?=
 =?us-ascii?Q?3/drVPaiIznuZLLyia3ssqivO3PYwMYOz8iJcYmMxcHyv5rcJKPhf3/aQxGc?=
 =?us-ascii?Q?jmyPYsuSA6FswJW0RBTHpSOTZaC7+IQIfslzSPM08gZ5hKHIl5frvUaRuYXp?=
 =?us-ascii?Q?J05Z9bYoaOHqcKrPNvs/kO6h8xVIitImvGqGdJGh/ZD+CC0EdSg+Vpr0DpFs?=
 =?us-ascii?Q?YM8uD2oRjBbN2RCnrjIP/8pOwjNZsRxUa9mcVwYaoOAnGVpx+wedRSTKc3G8?=
 =?us-ascii?Q?kOujdhIuOu3d8d1OSMSMpe8JLRUZjATvQEinb7vYo4aFOipzYjrRs0RtACUW?=
 =?us-ascii?Q?rnwQXi+Zr7psydViuLgeq9hx2cKbVgvHGfGGc+FhK9dY4kb3WGaXsX0DgILk?=
 =?us-ascii?Q?pfF1ApECRIzfVh2vXxjXTPS4wCI5XUr6C63R5ptt3+1rvJeAhsvAn99qsGGg?=
 =?us-ascii?Q?GsvmGukFRA3bqSp7mF7FAqhV+81KTb9OkVFOSs0nkptReJ4vVAqnByIp+VpX?=
 =?us-ascii?Q?QTSWpKFP/+HY0uw5+F12yIz6UCXFp4N4o7bf4qkYFZHcYgcQbNI0bFMnubuF?=
 =?us-ascii?Q?pJmcT+s0rISdPJZbJHhIFYjL2fHYMfi/pRMu4+JvclNo8AKdNVPGl7Z6NaiZ?=
 =?us-ascii?Q?S3bvngsCdU3m7vLpOktfyzDUxPC4lLuszstLqCyKzVzePIi/7xf6IjMmQxXD?=
 =?us-ascii?Q?pDUU65Zbd7t8ytH5mEgDUCQ3B7MtE5lezoiJ5gn1/BjBF+qDkj0yGFBssS0l?=
 =?us-ascii?Q?GrDHlAUyEk4GGf9dN8wB38tWNk8w6qT12qaVJ30Cxfr9RL5ndItFJbXM9mdK?=
 =?us-ascii?Q?rLqLoVDOOWdjDtVmC+PBOzI0Dl8ElfiUTWLnIWaR3pJ/6Z/qEQrbIbIOVHTf?=
 =?us-ascii?Q?AsBYLXbn+h4T8NsgAOtlejV0IRJJtp36sX2BHNzPC7g2RIMfQdDaVbh3ULha?=
 =?us-ascii?Q?6uf5q6/3nOysSQYpjXvJfRewXczfZvMxciftVJ+rmUoPrXZ7o7yKTcJS6v0S?=
 =?us-ascii?Q?dpWQ5WEYJZcuX/qDoNk8J2r2JMmWUm3gY1xCA4/9F2r39in2M7bT+PTB903J?=
 =?us-ascii?Q?z5NzsDipiVnaTI91Wxi3QbFG0CVuKZbcFp5Dj7FFiWYfebbglLK+w2OAFWtZ?=
 =?us-ascii?Q?yAR9SlLCXoWmzSuLlpvCUixjBFtZGoAnbieDA6nucUOGNAtu2hk9L6eitRHM?=
 =?us-ascii?Q?bu831PR69iVGKVKshH8i9CE6ZxryJYCxAK9K5QoksrHn/kknqBC6gqa8Q7uI?=
 =?us-ascii?Q?gygmfiZMa4y7OYvsUcnMP15Nj4GqKVkMxQm8N/ui?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4b62a8-1953-43a5-907b-08dde9feec40
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:58:45.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yneubZkG0o4rr0JidRL0Mf95taGpRzAocP11g152h4gFI6WHoGOUbHxMP6yduq9najg9yoZR+Gn4D7dqJPTNrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10109

On Tue, Sep 02, 2025 at 11:33:00AM +0800, Peng Fan wrote:
> For some cases, a device could still wakeup the system even if its power
> domain is in off state, because the device's wakeup hardware logic is
> in an always-on domain.
> 
> To support this case, introduce device_set/get_out_band_wakeup() to
> allow device drivers to control the behaviour in genpd for a device
> that is attached to it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Tested-by: Xu Yang <xu.yang_2@nxp.com>

> ---
>  drivers/pmdomain/core.c   |  6 ++++--
>  include/linux/pm.h        |  1 +
>  include/linux/pm_wakeup.h | 17 +++++++++++++++++
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 0006ab3d078972cc72a6dd22a2144fb31443e3da..8e37758cea88a9ee051ad9fb13bdd3feb4f8745e 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -1549,7 +1549,8 @@ static int genpd_finish_suspend(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
> +	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
> +	    !device_get_out_band_wakeup(dev))
>  		return 0;
>  
>  	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
> @@ -1604,7 +1605,8 @@ static int genpd_finish_resume(struct device *dev,
>  	if (IS_ERR(genpd))
>  		return -EINVAL;
>  
> -	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
> +	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
> +	    !device_get_out_band_wakeup(dev))
>  		return resume_noirq(dev);
>  
>  	genpd_lock(genpd);
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index cc7b2dc28574c24ece2f651352d4d23ecaf15f31..5b28a4f2e87e2aa34acc709e146ce729acace344 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -684,6 +684,7 @@ struct dev_pm_info {
>  	bool			smart_suspend:1;	/* Owned by the PM core */
>  	bool			must_resume:1;		/* Owned by the PM core */
>  	bool			may_skip_resume:1;	/* Set by subsystems */
> +	bool			out_band_wakeup:1;
>  	bool			strict_midlayer:1;
>  #else
>  	bool			should_wakeup:1;
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index c838b4a30f876ef5a66972d16f461cfba9ff2814..c461c7edef6f7927d696b7d18b59a6a1147f53a3 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -94,6 +94,16 @@ static inline void device_set_wakeup_path(struct device *dev)
>  	dev->power.wakeup_path = true;
>  }
>  
> +static inline void device_set_out_band_wakeup(struct device *dev, bool capable)
> +{
> +	dev->power.out_band_wakeup = capable;
> +}
> +
> +static inline bool device_get_out_band_wakeup(struct device *dev)
> +{
> +	return dev->power.out_band_wakeup;
> +}
> +
>  /* drivers/base/power/wakeup.c */
>  extern struct wakeup_source *wakeup_source_register(struct device *dev,
>  						    const char *name);
> @@ -162,6 +172,13 @@ static inline bool device_wakeup_path(struct device *dev)
>  
>  static inline void device_set_wakeup_path(struct device *dev) {}
>  
> +static inline void device_set_out_band_wakeup(struct device *dev, bool capable) {}
> +
> +static inline bool device_get_out_band_wakeup(struct device *dev)
> +{
> +	return false;
> +}
> +
>  static inline void __pm_stay_awake(struct wakeup_source *ws) {}
>  
>  static inline void pm_stay_awake(struct device *dev) {}
> 
> -- 
> 2.37.1
> 

