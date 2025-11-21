Return-Path: <linux-pm+bounces-38382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B62EC7ACB8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 17:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 911F13655D5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B421352F90;
	Fri, 21 Nov 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fHSCGmI6"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64FA34F27E;
	Fri, 21 Nov 2025 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741479; cv=fail; b=UMjDD01SWkdCZf4acHywHkz7Ig8LY9dqeOz5BEdPODqHeKdMtl8nQ/nXL0gs3b42QEjRMzeIxDWqmzqjkRQYsU6MDX3SOwBrXpBwAY5EoOrWlM/vAc/Y8nyU3ZTdVPj80npxmTfu+OYpzS6YB6e9NIiJqWKM1tVbykDMBxAIZVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741479; c=relaxed/simple;
	bh=sOBwt+5YSJV893VJgjTkpAh3g9J2iuOyfZM362zPRSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V2wSnHIHDDrFhUmO2R9AhsW8qJ9yJtPkvoG57CtyqjieKuoWyHL53i4FH09nojBnJc7vo7jsA1uG/lyK7Dc4oFXXQjqtnc2FY84eJvc0Sqg5zYd2T3E2d28pXwN3Ub7O6aBdDRy44jt0CUN7OVpKzo1/012eiojuL/CeaMWEAgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fHSCGmI6; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3GDNNW5IgdWEpWP7lWxAqa/BZs5+xmRo00eF3/7vvBoJijkNUIYZdq2RDqN8pB/AmBBhuk5Q0D76FZyjY6JVfHKr/0+NMz4E/CEMm/P3mnOE+xAJfFKdjxuZ3jp/nFHu604UmCUs+KowAf9HAkFUqXoqJpMm7CV6PrfE4hHCvZOMnJkkyjdTNc8tPyM/71BmO0GJDDnDOagkDl6pApUtXWIkmsYuIH5WmOcdErZnNskR6OvZDydUjWX8QmmPmcl7Aa3aQ49MnIjo8FYurlk4Ylc9ozjNLZfP1K9ek/s3E8M2EvOIlaCaF0P5Em9n3g1fwck/fK17SkFJ2vMCyvnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTLAHW2AjwCKh0ATApwRwsluCAFEB25J5vycy33kThA=;
 b=ae1WZsz/xHsr4id2IZTZaNU7nwDQmmFGNdSz3sL0NQFFvQwAKlb2ykuHDCiVIlzOIg9y1nyDNuzdIjIoN4dVTOSMH6huHs4I3j+1XvVloNDwlfgDuPMcJWttaGXY+ATnhKxWoz61qcXI7yHzHhJ61NGPSA0y7HT33bYqYHYFbVPkYdk+ko/nkZ8LeqjlEBazpVkGZIC1965of0ik/ZMcR3a8/aWR00fzEJfqR2UJ8LPBGEUOE84roa6fb+DrP1ci75qZiSZzz405CzSpQ3AHDE/0n0gH/XxVP7VZxRD8fCBN96+7W1SxnR/1WxVNBKIkfj8mYT3qRNJMn4NFahlzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTLAHW2AjwCKh0ATApwRwsluCAFEB25J5vycy33kThA=;
 b=fHSCGmI6SlPdlOk+MF1RqF3IrryuD1lLF8rqew+67potFoBpIX8M8dQz1SNVCCNHs1YWSMwWVaRqIf+runGp4CgrWMp05Gz8FrAbfbgJCsTfwrEh8+V2LYSzFt7yrn7XkcLUlM8gCpc/iSrFFvSivTFaajBoc+uItm18JgqiDK1sa3BfimX0xyZxtN40dje5RB0mHDzAgONE+0QymEK/5tl7ssLb4zUCspPHUlu9uKmILtxllY0DsEUSKFumJPUNOVmOVuD87sJrMiSiwGCH4vSjz5SPpBwGk34aO6zD0rD22t3HJUtanOriCZHiDy0WZn4beulvfnhwQf3Bg6hVGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PA1PR04MB11506.eurprd04.prod.outlook.com (2603:10a6:102:4df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 16:11:14 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 16:11:14 +0000
Date: Fri, 21 Nov 2025 11:11:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: ming.qian@oss.nxp.com
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com, p.zabel@pengutronix.de,
	sebastian.fricke@collabora.com, shawnguo@kernel.org,
	ulf.hansson@linaro.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	l.stach@pengutronix.de, peng.fan@nxp.com, eagle.zhou@nxp.com,
	imx@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] pmdomain: imx8m-blk-ctrl: Remove separate rst and
 clk mask for 8mq vpu
Message-ID: <aSCPGdnTVmd48f+i@lizhi-Precision-Tower-5810>
References: <20251121081911.1682-1-ming.qian@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121081911.1682-1-ming.qian@oss.nxp.com>
X-ClientProxiedBy: SJ0PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::15) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PA1PR04MB11506:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c05956-c50f-4fac-0637-08de29189833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o3h97VbEJe6lTdZo+VnFpHkTctTuukDHHIdAG8cAUbCvPS5TWOYDanIq21HG?=
 =?us-ascii?Q?qUKQNJFfmMKmG3AEAMa6ys2TZhphTSLl88o7OhBTvcURjiihn6RzBL5Y7OLi?=
 =?us-ascii?Q?9Rq+qSGDvvGq7sq7HpU4Syw02ORSZS4tAsR0e05xSEPE8bG2cQSU2T526bTV?=
 =?us-ascii?Q?fFUl+Ehn9/quAYLKX8XzA/G2mme41v8IsSn1M92gZnUeiN2QFsGi9MBOBS1X?=
 =?us-ascii?Q?REUP1t73U0Mo3G81DnkfRJtiPM03p7lbNUXYlry5H8QFe3XyZEGabl9w2M3D?=
 =?us-ascii?Q?B8Ir9gCT59ey/oos/SyiZJ0LjpTytD6eINFC3xFZyeO1YlCsz4j/3g6Mu5AB?=
 =?us-ascii?Q?YmizOSl2DXBFXift30bIvQD1VMZW7kF1xPpVx0FUWgoGCxuVRwq615jvUkE9?=
 =?us-ascii?Q?8CrW4jnKSqH9QHTECnSi+Jl0Vl3s6ifLyS9N7lYiZ8gRZC9YGhmNS+YvpEYq?=
 =?us-ascii?Q?bjSN0ckJlKnThTAtO+fYrbGI6TvMr0AkfE5wl15Hsc14BGGRi7GjG47734kL?=
 =?us-ascii?Q?+zeCheNLIn7GA2UOwRLdSMhjkPRLTXrVSoCaFpIEeueO8XchHrt/iVLvAi6p?=
 =?us-ascii?Q?DuI18ZJ/l1oELxBgLPYxUr4wiODbJUJNEbOtMfdqF0WyN9Dj/e/ZzZFQzEGo?=
 =?us-ascii?Q?FBdbunBUZcQHwjgFnlxgSJqW6koBg4jIW0cUgVw8cvEDnt8OaiPp9ka9i8fm?=
 =?us-ascii?Q?IfOTkCWxq/VzLtu5zdRPrOoaHsGoCivC3czGNsz1OrjzT8nOPQVlG+2npWVC?=
 =?us-ascii?Q?DNOe9jOG5Rs85vBcUNBCDNjjsQvyJZd9geHthmYT0hosNkPyZ/j7bIwKlMII?=
 =?us-ascii?Q?OBW+OHd5dLJ8RlQX/6h38sCXqEg3rMbesssKkJlrFqr/199+mhJABKY3EzHP?=
 =?us-ascii?Q?I2wV4PVrToR3cZXjFv+CUzVi9GLNxF3z6W8Y53U3SOAdmv4ec9YM++C0ObCo?=
 =?us-ascii?Q?euqvoI8AqCxr888jnThec4JrZddWcu2nt8PjdQFbArcAimDBlCWbM7OiSulJ?=
 =?us-ascii?Q?pmbjES50dffie9bJhEC1m3Ri/Z4z16/WltoI6iRxRc6qUCaC+tF13WTcUj7h?=
 =?us-ascii?Q?xsGNj7PKmbm5mEap++/HLTn1IrH4xbuqP+5o1SVD4jLfceDZ48/fBzs2bgJT?=
 =?us-ascii?Q?3Foc94pOpW4Bx6IZUvAormeBsJCFidmoXsdcabQMhQV4EmXFpr0dA6EC+AJR?=
 =?us-ascii?Q?yaMac9pYr/8iDyCyeZt40W6+CO0Nqynq/+TqlKDesJIia3M2cZXTqOpZThZd?=
 =?us-ascii?Q?cJ5Zqz2uS3oGAWETVsNVuAk53HEdlfTm4nVnow+s/vOyfyaOI+vwOPCxGTSS?=
 =?us-ascii?Q?4MZLUaXzDLCpHPHPet9AWndktXkjzjt7UDFHJr5+MyYXbq1lBXl6SP+P8jaF?=
 =?us-ascii?Q?Le7aQA2PYg17iPjM/ViF5Y68+PWyXVZqGE4ajirEiYMepQwnuGXgVtE9loIG?=
 =?us-ascii?Q?ux++R8XlAz60i2cl0uBv4GKxYfMJ1vNgxGK5/9AQ8Z9gu3/Qu4wWCvggquAk?=
 =?us-ascii?Q?m7oPt2Fb1il+CD5JsBuxnTYaF2cJ7tpksLlI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vfPrvR/SRiLIOjK1ixOsxT4NZw0PHfEUUD6K3tWt0bdJWix9XALn3Jmn7b+5?=
 =?us-ascii?Q?O9iPupvTN+vYoRsEw9gEuiMyYp3iaIL/nVhExOi4QDs/ZCwDXC3+jReWbw3a?=
 =?us-ascii?Q?xkJr0HV/zlUIR40UgcbMTgX/ZEn7i2x1PL48An30D5O1VzWOsC8X+epHcFwZ?=
 =?us-ascii?Q?DRQJNEBW8dVDpHy4TWtbV5kdngFeUAWUxmwOp12smrgFtKLca2aOCiiVfNyX?=
 =?us-ascii?Q?/DxRdJhJkNJgZQLa7IY7/+c7c5loKgmM5vMSStP1GP/l8LtzHDX1mh8FH4Uh?=
 =?us-ascii?Q?Uril9PEko/M6g8Vm3Oq73j1akVb/Pyq+Uga9GcNSX98jczK7HukgdodnpLby?=
 =?us-ascii?Q?sTSVNrUJqZkCTFV62GSb1kPen3ekjWQHNgRGU/380aiTtM4tV36qpfaD4nVs?=
 =?us-ascii?Q?RHFQmz94ZEWQQVjbikRrTKton+vfYmVruq6+PUJAz79YkhT5N0AtjB4cnwPq?=
 =?us-ascii?Q?BBlI+M2uOTOeyYn5eE5s80NrvX5iur1XXX2RNXe9AlX9K8Yow9pA8aZQLTin?=
 =?us-ascii?Q?odAeMBjAz5sOyz5/UK54M4hHieqTdDvT8q9wLZbSFD0EC5qX3m9jArRW8FAl?=
 =?us-ascii?Q?sEoCAxFxhqxJbH5A8TOy7u0YRkbv+AYqfpOllZpRdn4O4woiEW4mKdvYfBVJ?=
 =?us-ascii?Q?cDTo22LlbywZ1yLaBOCtMacEBlSMqgu2CC+cv9UYIsNftlTQmInnuMHzzyRq?=
 =?us-ascii?Q?vvsUUQqU0Jqh8eGe2SiVPztJyRz1ZkFg/KgpRDwRqszEVP7of/ylGzGIN2VX?=
 =?us-ascii?Q?GSUNs0AWMMGzc+MLfzQT8k6MsAocJ9aIeJmNZeybjkrKqSh6dqvJZ2DsxLCg?=
 =?us-ascii?Q?9m3zwpV8f0xTy+morS3ue0P8vwnfQXL2qS20VEREgfOIeMNxQgrZaYpEglBu?=
 =?us-ascii?Q?yPps4ks45E4fhAeqK4UMYQIzgu/6lhC8eHMthqaDs0cGjOVYkjfj6wwnH75l?=
 =?us-ascii?Q?PQcKHMoKINHzyrGzlQLiIiCEMn3AhhtRzfjvc71NulBFxF6czt3LqpuRuxpx?=
 =?us-ascii?Q?mtcpBm7I+T+dno3YXr8kYXvrv1On9yV2FAhnV0VnPumXLNnXrLgW2enfO0dR?=
 =?us-ascii?Q?YR9yR5EMMhF5/mGLxevte2Ci1QHIUVmGy37WEK0n7PIckOUL6GKBwEwndl7w?=
 =?us-ascii?Q?VUBWnB/CXM0Na0WzevyA9+fc+gbHep7zgZXN3Up0tfVSd7HSJfKeOa5kXr3i?=
 =?us-ascii?Q?WklU+MhgsrpHxcCrv7N6BxedH69uUNK9gZJjKhvlwUDFil80tn+N07cdrvND?=
 =?us-ascii?Q?EsHBRq3f9zmAKFZjJfG/V6uQUpaWOGx4j0ZD+tfRB8pLu/8s8RCQtt+c+1/n?=
 =?us-ascii?Q?SouxENM5+Hto9pM3Cj2sc567OWS4LLhs7xfhskLO6dcFdHY6cllZ/WTbDjCe?=
 =?us-ascii?Q?t1jjQzrklT3L/ZLhOQgxA2GMh6EPz4mIHLXvdLUtTnTNUM9DFXPv9DslxGF1?=
 =?us-ascii?Q?+hKFqe/D4PdoD1okfMTdXqMXUA4tNo9Lnvrd/drhG57yZ9zlFFJkWylzaedT?=
 =?us-ascii?Q?Ne+/sp7JGQNRLhG3Nilxih2cBAcZpFJwIaStwAiWjceEPEkMbzxPHvqQRoCc?=
 =?us-ascii?Q?Mzi5HvrSp5h7qJk6D4Jk+NM6UOjtsKeaEcf7iLvC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c05956-c50f-4fac-0637-08de29189833
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 16:11:14.5080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMw4eA3/b4zSOdbKO6MOc7TUdOv6t1aC65THfn+PKWJ7VtCxoCxcZIJUfb5Bijm/f7CLQ9yTkUyrB+6xwXn8rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11506

On Fri, Nov 21, 2025 at 04:19:08PM +0800, ming.qian@oss.nxp.com wrote:
> From: Ming Qian <ming.qian@oss.nxp.com>
>
> The ADB in the VPUMIX domain has no separate reset and clock
> enable bits, but is ungated and reset together with the VPUs.
> So we can't reset G1 or G2 separately, it may led to the system hang.
> Remove rst_mask and clk_mask of imx8mq_vpu_blk_ctl_domain_data.
> Let imx8mq_vpu_power_notifier() do really vpu reset.
>
> Fixes: 608d7c325e85 ("soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl")
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index 5c83e5599f1e..1f07ff041295 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -852,16 +852,12 @@ static const struct imx8m_blk_ctrl_domain_data imx8mq_vpu_blk_ctl_domain_data[]
>  		.clk_names = (const char *[]){ "g1", },
>  		.num_clks = 1,
>  		.gpc_name = "g1",
> -		.rst_mask = BIT(1),
> -		.clk_mask = BIT(1),

Does this bit not exist or just put VPU's reset bit here previously?

Frank
>  	},
>  	[IMX8MQ_VPUBLK_PD_G2] = {
>  		.name = "vpublk-g2",
>  		.clk_names = (const char *[]){ "g2", },
>  		.num_clks = 1,
>  		.gpc_name = "g2",
> -		.rst_mask = BIT(0),
> -		.clk_mask = BIT(0),
>  	},
>  };
>
> --
> 2.34.1
>

