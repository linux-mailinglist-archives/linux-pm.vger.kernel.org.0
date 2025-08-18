Return-Path: <linux-pm+bounces-32561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C471B2AD64
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 17:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740C15664DC
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB822321F3A;
	Mon, 18 Aug 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O2FRcBKb"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84982257427;
	Mon, 18 Aug 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532288; cv=fail; b=uM8E9RoImUJJvEjyYppMLxAB6AzK4kUqiJPDAez8b5RVRt9SCeKZr2soCdXHIbErio2LIlPsOXBr/qvrK9QOhPTYZNrFl60fHfLl41XV3ecwbKj1M3IEqwjdlmSvYDqtpGfgWvWdECrvoh5aUetkfPUhmg1ncd1CelffJwSQmP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532288; c=relaxed/simple;
	bh=lJ1FVvntRZjqj9+9j1diZHk3M0HDbPkHT/nBbf8WnmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hPRvfPsnwBqSLluzjAZliJwf8kyel+wmNZPHcbdxQa6dNIcryfoXSLvfyXz0XpyUBXaRUTJT55l2Z/Z66V2pcclm/1ytkj7VnouplDC44c/o0x9Nv2UNlwjxZ8AzlgA9YRywoEEMBUpXN4dM7EHfc7jCWDBnmzLzVkRIAkkoiZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O2FRcBKb; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jo+EO7PHZHj+CMuc0BOewwDqTGNox8JNGIAsfeif6LQcPVQTnrsXts2qaWTpaGJzCOdIdundCSQDrzVSLOY6tqhWw7xP1NTzcPAWe9MZAlldk4sIyTIPBL1NhqH8/NkNuX3s0KAa4n8a5V7NuucBgMeV+BfTEJAtjAqiOgnRlmWd3tcH0apkP7Zu5X/DW3kln2GgaQ6J/yH168n5IHdB4/PlAoi7TZzE4xt9q9SjStXUrLhXDphzCL8RCY+e4UZ4/wGlim5Iv7f4wFOvP9e98fIrFqGBfYtrACQEpEn67Sg93gxZyJkkAso5EN7C7MQFO6dwmSJstT5ARWhAQtHR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzMEh6hMCGY7yWwkVqFPpQH+WZlA/DUzdT7VUbnNGSE=;
 b=k9MPK6K/Qhly7yC8r9Tpq+QSjzYUUmLL1yZ/tX3N4uCpaXeoDu6i0bHHiu4ms3uVKlRXPnFI5oZaZebJdLRWbdBOPwGRZEG+zGR4PbkaIaBZb4rUd9HibICaGFx3mXwBciFBwCIhKKQ80rpdDXAMXKebjp30v+N78lChyaammyl5w9EnA4txlC2AeJMx8k7KsU42wgB73LCHk920d3AYDgp6e/LtZbDRn9+69H/EVhvFKGd8V2d49Y04UaseQ/Nhli4hH9hRf4IO5YnWbYbMAf09/OIW3tpkmUyQkOkMVklSX4Q9SyE6y0uuYI0plIeAzgSnvMwX1RRn42oC8l6AOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzMEh6hMCGY7yWwkVqFPpQH+WZlA/DUzdT7VUbnNGSE=;
 b=O2FRcBKblCjS/uvXvhEp/tdzFk1fcLEFT8j85ezwquUgKEd0UGD3nx+fZ0StiVwPEPBTq1coiJZ6pLu0PpuCyYDmfER2CTbeFL/EDdaRbuB/NcPDtoqSSaMnyGG1H4feAJmbIXostiZTAbdafYBswO5gOb14uQ0KBJz9N3RVix66SeO1rI0yEVdbQEK7Vbe6nZgf29OxYe1lwyh5tK4kD7T8HTt6MIMsXHoCOANZ6ffjutvWfFFpIDOwlgaMf1zz1Q6e3a2ycOl5ADOmb7Sibhi7+YrqBWEPoxLQcRgN5Fs60mj2Cj9byeGeA9gEdgl+2NZwDbDMVw/Fj3KeA+P8QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10078.eurprd04.prod.outlook.com (2603:10a6:150:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 15:51:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 15:51:20 +0000
Date: Mon, 18 Aug 2025 11:51:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jacky Bai <ping.bai@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] thermal: qoriq: workaround unexpected temperature
 readings from tmu
Message-ID: <aKNL7/uLHW3Xsrnc@lizhi-Precision-Tower-5810>
References: <20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com>
 <20250818-imx93_tmu-v3-3-35f79a86c072@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-imx93_tmu-v3-3-35f79a86c072@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:332::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10078:EE_
X-MS-Office365-Filtering-Correlation-Id: 48df0785-43ed-40a3-c009-08ddde6f1373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BYbTeogRRNGfbiC/boNYH4syzoZrLp+4OoyJgJD2Abh6B9ipgvi3nnnlfTKW?=
 =?us-ascii?Q?ZM4pf1KV60ZfH419jlTM8LhxFyDMqNPDwy++2Be1UoDVezRESdp5IqwWCLN9?=
 =?us-ascii?Q?ivepv1eeQV5DmGlXbSDeBYqUheh2DWazZEcz2deuxUy+e0efzpJ260NgAx6I?=
 =?us-ascii?Q?P8ZM7LjSoeeMVLZt2MMBP0+PQmR30NZ8YHwfTqo198lrGqmaUnjmwF3d4pPN?=
 =?us-ascii?Q?WxdKy7V5JuR3AnJD17kugqz6ot+B6JDqjvVCvbkvxCtZ38Rk+2UtA6E9C9wQ?=
 =?us-ascii?Q?Kz2yNuj0iG8QHE46BugIiq7PYSnbi25X2aJHOmEo9FGHdEnbK29IdUERCA5W?=
 =?us-ascii?Q?h5/ExBO9Q02fYihbN1+Woma5JDt2KBL/3QMP7sk46zZ5gljVNCk4IOwhpiO/?=
 =?us-ascii?Q?L0JXDCrXpnBlBH1aNCbtpDaS6pGLQDlLTiqj6lbKFqao4tPpitGJ/KZE8uda?=
 =?us-ascii?Q?6QQewR6pLUhjIaRk2dXyKVBxSGe6kJLWfCY11z/DYNIbsK/BeIkPE1Wy+Rjj?=
 =?us-ascii?Q?Lic+QJOwvXrGBrne7cL71wLtpNV/KxzqyfjRGatqx1fUTleLa6sG7zFGIqhT?=
 =?us-ascii?Q?Kd1D+Gr0RmXdx+mAdLQHU6xKchK/PMZrey4pm8j+IqX2t9y59x/E7zbjl90F?=
 =?us-ascii?Q?ezJtq7zSaIGwwCd20jurarhnJBAMXruc0sR7IwPfbs4IoU8aacBkymb+FWRo?=
 =?us-ascii?Q?RgkHEbnIdj4eXP/hjTm5CXRxJjj9T44qHLyv964Jr/V+HEg7xInTwMp8spWH?=
 =?us-ascii?Q?Xgtvu7+hyOYK/8qiDKUiG22KfiTs8P/fM0dpLdDPSxyp/aAFZBuyx5Ai/fMb?=
 =?us-ascii?Q?5ThtWD8ZCzdVizgxKcS7uKwcdYmWymQCgbfxJ8Gw8rDgBi5HkFQjoJYmKsqK?=
 =?us-ascii?Q?05wf42zHuRIfFgxz0yZ45spf9Nx89HDuZpm8CjFHu6rN/2QM+4nZ5gpUikfm?=
 =?us-ascii?Q?skfbxiYJbjKejn+1hWBTSxYdb62a5c9y88QuyHs+6mZ9HDw8D13Ta/HqLgC1?=
 =?us-ascii?Q?1AUJ8WAz9EJtV0726UOOFRBHiVxLUOw+HEt4WQtU6wJVkjMJj0vTklQ8mIl1?=
 =?us-ascii?Q?uWOlTz6MeUljHB4fESX2BVnwDHifpiWOHU4zMWSl52ijzOV9Z2tQ0D3gYjLi?=
 =?us-ascii?Q?IJYhnoeRz6U1fC58OZ9EztBAKoFmXpFmcDq8awpiqqEm7NnDsVJdVSwsigeS?=
 =?us-ascii?Q?TpKfwljV1eB45eA+pjzL495KhGvzmDkvSZR37RSbJrp2pubSD8XuKivE4NgX?=
 =?us-ascii?Q?Ome60QJ+vIRWOePljVEvFVJ4NNYimyFgBsr4SizX48ZQHepMGjUJnnQahwvi?=
 =?us-ascii?Q?DAWfg4PUJluJGUSwzsDMs8voYuyBPkDFzf7mn00ZcXG/FIKLzJKIbZUa/mj5?=
 =?us-ascii?Q?kexLC5Nh8HzvLtrN43ye5I9HbBfsWcITPaVFY/neoL4V2W3Fsvb6SrH/taHZ?=
 =?us-ascii?Q?tmRN2c5joof0MDAMQCaJyhMuCZsH6WsLKPJPpuWFL7atDj6RTD/pLlp3C3Sr?=
 =?us-ascii?Q?DBDk1gjhqIIofoI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RVOXl89K8mAo4x2TMmfckCAyD+FPf8J7OspSmYF8kt446U2eiVW4mDjyXS1R?=
 =?us-ascii?Q?0FBB9WvN4aSgzwUmsq/nxm2EmbfIhzsc5BEqaTAkViRLJgPJimvNQ8XgxUUD?=
 =?us-ascii?Q?rFYzMy/TilwI3M7mnnThGeDpb3HmlSvBYy2EJbRhA1Lsn+YkK8r9TRjA2kUw?=
 =?us-ascii?Q?X0BDjebfSnnh/S3kZi9kufL7yaJh8rHqW4tvDymUx+AfaTD8n+yFvgEy6Urs?=
 =?us-ascii?Q?osjf+H75VCe7VqNS4zjk9nFuT9BR+J5xsbgDwBd1HhkNuNdISvCBsprGwDsY?=
 =?us-ascii?Q?PgOdmXKTu+QYQQAh0ejk/Kp50lADGmZyWcAz1jzvOdhkvh+YXcfAY0CltBQe?=
 =?us-ascii?Q?Mh3bxbPzAe53tGFyqsxckFAgkG2HEXwfdiI4+p9winlgJr7/S8eS3TSe92XP?=
 =?us-ascii?Q?q8kiIG+48PEcPtTw3HDtDJjxBvWehBJfr77FU5si3zp3kPRdjEwnm6jJzT91?=
 =?us-ascii?Q?vhIIkfEkNv7I16ttaD6kkHiGO+lpdmlrSjWE2WkA/X6DMHjpsGgOSPLoxuI5?=
 =?us-ascii?Q?0Lgmn8vWzN+QirNxriPuXkodjVmFgm3mrriTImtkfwHxesQK7Jk/RWqZuPop?=
 =?us-ascii?Q?nXNG9XO2TOlfDNpiUibKPSoxE+V1qHbmdQ3eJd9xV9BfALcw72JACT0sr9mG?=
 =?us-ascii?Q?jpys7AN9rc5owfaNusLxt1Sbel24gyKzSmXzWLN3lQET7demkH20iQaHzHKJ?=
 =?us-ascii?Q?xpi38JY3cIiY2fFsTmiVfXn2DxwZ3EJBmaB6AF9fTbAttL9XDWYsCZg8b9q1?=
 =?us-ascii?Q?umK6ng8Hc6/hF/27KTtvZ78tr4RYephsjQ1wM6TPj+pRlylLPcQZwGVbB2wm?=
 =?us-ascii?Q?4UKzEtaKmvgRfJXeeGClq6VNPbGYpf1AbK/efp8X9na68LmQwBr0HVByDS6B?=
 =?us-ascii?Q?xE/fPs7TkCFg93dAwyf38T1OSs0wlKbRyamnVXZ1Mrs2Kg4ySc+BaoWexpmD?=
 =?us-ascii?Q?9G5/W8+2TuieWRLCKxFhtqBzQeWa+FioxzWMiy4QE/DFDyGFBfQ0sc94chkx?=
 =?us-ascii?Q?sQZgEtLZgYrmFGOiZ0J17UFu9eKFeFeQduIE/aypVdIRQGNG+A5pyhff/SFI?=
 =?us-ascii?Q?sR5n0GBMKLXA1wvu2row5ftcEiIs0Mo13c0UhKgeDMIL6keoGN1ZOwhL3Fcx?=
 =?us-ascii?Q?np70I3gH+rsAI2UCGCtknMHa/UlIbZdMSuO76Eulpc0tpuLGzIcQTUHtyAxA?=
 =?us-ascii?Q?f6Yjk6NmCYF69K29+DpeGqBcqOBoIVgVoDcX+6VqKhL4emh6J5wzEZDxyj4I?=
 =?us-ascii?Q?csfdbbwIkJoWbImREESVIMk0JYETAAbHcFgeJ9eC3/1jk6470Otsdebp7iod?=
 =?us-ascii?Q?4S5Hzj9zrU0cJnIBJZfZf+95KvP5v7q/lMcO9th0jfvtyl9jcNDj3pz54J4N?=
 =?us-ascii?Q?J7azmjZGvxz3tbtTKzo7hxtplQNdFWn/sCslJwmeSNJf9Sf+rz3RBW5YNnv4?=
 =?us-ascii?Q?wW7DFeBT50alopl94c0etqLlp6wO3Y/CXRbjqMFcnA8r95qWSYFmQTxqyXHi?=
 =?us-ascii?Q?YGpHyjyXB/tbEsfx4I1NA3kBrE8KSAulLUIuEJq9cgNyEiTL1jszUO/K/68G?=
 =?us-ascii?Q?4FiCEjXbvt7ClSJVBZGjREI/zJ8oz0NkOZLUYnuE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48df0785-43ed-40a3-c009-08ddde6f1373
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:51:20.7847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAAS/GUEFXVcV/hT5dR3M3zXLQcvVYYE+ZVyGK85qX/hWODUExpAHphOiMvXSJOswB2i/4Hm68xzORFegcEUzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10078

On Mon, Aug 18, 2025 at 05:33:13PM +0800, Jacky Bai wrote:
> Invalid temperature measurements may be observed across the temperature
> range specified in the device data sheet. The invalid temperature can be
> read from any remote site and from any capture or report registers. The
> invalid change in temperature can be positive or negative and the resulting
> temperature can be outside the calibrated range, in which case the TSR[ORL]
> or TSR[ORH] bit will be set.
>
> Workaround:
> Use the raising/falling edge threshold to filter out the invalid temp.
> Check the TIDR register to make sure no jump happens When reading the temp.
>
> i.MX93 ERR052243:
> (https://www.nxp.com/webapp/Download?colCode=IMX93_2P87F&appType=license)
>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---
>  - v3 changes:
>   - refine the code with FIELD_PREP macro
>   - add errata doc url link and refine the commit log
>
>  - v2 changes:
>   - no
> ---
>  drivers/thermal/qoriq_thermal.c | 42 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index b2e634547271dcf512c714907baa162921d2d527..134a63abb482d44b5cc78e672e6312fbdce5ba31 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -30,6 +30,9 @@
>  #define TMU_VER1		0x1
>  #define TMU_VER2		0x2
>
> +/* errata ID info define */
> +#define TMU_ERR052243	BIT(0)
> +
>  #define REGS_TMR	0x000	/* Mode Register */
>  #define TMR_DISABLE	0x0
>  #define TMR_ME		0x80000000
> @@ -45,6 +48,13 @@
>  #define REGS_TIER	0x020	/* Interrupt Enable Register */
>  #define TIER_DISABLE	0x0
>
> +#define REGS_TIDR	0x24
> +#define TMRTRCTR	0x70
> +#define TMRTRCTR_EN	BIT(31)
> +#define TMRTRCTR_TEMP_MASK	GENMASK(7, 0)
> +#define TMFTRCTR	0x74
> +#define TMFTRCTR_EN	BIT(31)
> +#define TMFTRCTR_TEMP_MASK	GENMASK(7, 0)
>
>  #define REGS_TTCFGR	0x080	/* Temperature Configuration Register */
>  #define REGS_TSCFGR	0x084	/* Sensor Configuration Register */
> @@ -69,6 +79,7 @@
>  #define REGS_V2_TEUMR(n)	(0xf00 + 4 * (n))
>
>  #define GET_TEUMR0(drvdata)	(drvdata && drvdata->teumr0 ? drvdata->teumr0 : TEUMR0_V2)
> +#define CHECK_ERRATA_FLAG(drvdata, flag) (drvdata ? drvdata->tmu_errata & (flag) : 0)
>
>  /*
>   * Thermal zone data
> @@ -79,6 +90,7 @@ struct qoriq_sensor {
>
>  struct tmu_drvdata {
>  	u32 teumr0;
> +	u32 tmu_errata;
>  };
>
>  struct qoriq_tmu_data {
> @@ -99,7 +111,7 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
>  	struct qoriq_sensor *qsensor = thermal_zone_device_priv(tz);
>  	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
> -	u32 val;
> +	u32 val, tidr;
>  	/*
>  	 * REGS_TRITSR(id) has the following layout:
>  	 *
> @@ -124,6 +136,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  	if (!(val & TMR_ME))
>  		return -EAGAIN;
>
> +	/* ERR052243: If a raising or falling edge happens, try later */
> +	if (CHECK_ERRATA_FLAG(qdata->drvdata, TMU_ERR052243)) {
> +		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
> +		if (tidr & GENMASK(25, 24)) {
> +			regmap_write(qdata->regmap, REGS_TIDR, GENMASK(25, 24));
> +			return -EAGAIN;
> +		}
> +	}
> +
>  	if (regmap_read_poll_timeout(qdata->regmap,
>  				     REGS_TRITSR(qsensor->id),
>  				     val,
> @@ -132,6 +153,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  				     10 * USEC_PER_MSEC))
>  		return -ENODATA;
>
> +	/*ERR052243: If a raising or falling edge happens, try later */
> +	if (CHECK_ERRATA_FLAG(qdata->drvdata, TMU_ERR052243)) {
> +		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
> +		if (tidr & GENMASK(25, 24)) {

you use GENMASK(25, 24) twice, define it as macro.

> +			regmap_write(qdata->regmap, REGS_TIDR, GENMASK(25, 24));
> +			return -EAGAIN;
> +		}
> +	}
> +
>  	if (qdata->ver == TMU_VER1) {
>  		*temp = (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
>  	} else {
> @@ -238,7 +268,6 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>  	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
>
>  	/* Set update_interval */
> -

uncessary change.

>  	if (data->ver == TMU_VER1) {
>  		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
>  	} else {
> @@ -246,6 +275,14 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>  		regmap_write(data->regmap, REGS_V2_TEUMR(0), GET_TEUMR0(data->drvdata));
>  	}
>
> +	/* ERR052243: Set the raising & falling edge monitor */
> +	if (CHECK_ERRATA_FLAG(data->drvdata, TMU_ERR052243)) {
> +		regmap_write(data->regmap, TMRTRCTR, TMRTRCTR_EN |
> +			     FIELD_PREP(TMRTRCTR_TEMP_MASK, 0x7));
> +		regmap_write(data->regmap, TMFTRCTR, TMFTRCTR_EN |
> +			     FIELD_PREP(TMFTRCTR_TEMP_MASK, 0x7));

the same here for 0x7

Frank
> +
> +	}
>  	/* Disable monitoring */
>  	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
>  }
> @@ -389,6 +426,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
>
>  static const struct tmu_drvdata imx93_data = {
>  	.teumr0 = TEUMR0_V21,
> +	.tmu_errata = TMU_ERR052243,
>  };
>
>  static const struct of_device_id qoriq_tmu_match[] = {
>
> --
> 2.34.1
>

