Return-Path: <linux-pm+bounces-39211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6D4CA50C4
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 20:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 461513010947
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC6834846E;
	Thu,  4 Dec 2025 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BHKiZuy1"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A0348447;
	Thu,  4 Dec 2025 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869686; cv=fail; b=oT9Tkcpv65c4RL88yeteQksQkofVk5+f7yq61oaN2SaF9ov8nftrCPjD8M0SPP6poQJY1qs0dgUdrykjtrIldNaPOORXKGDPeB/M6jE5BkydyXfubeUoPV3RItU+3L+hG0WYA9zne6Buhh2Bsb2Ll9LNlNQec2FUqH9mU4MIL7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869686; c=relaxed/simple;
	bh=+vOhrWVfekr0xDDHbMt+LybVNCQB0D26JJY4K/Zjg98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JxjVwbRT7xnCjBJp6DSBfGCusxvqLEK2FkeHNRUJCAMsUK4Cy/t0mMQ+lQa/BQYcn2iL3Y2Tyda34xxo3lSmNXHYoHwoLy4/p4oNojz42qZd4SD2Xx44fWHjKS9cNuYhsdMkwX1x+yLXzSTl0FtGE5IdUqa4Q5OlfcMICN66bGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BHKiZuy1; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZcfp5a1e6KY/ZGbnPesdW/JbJYa/ePAgi3dkq+/2EsK45cVcS2WuCwATQoJyje3wP+IB8rFUrs1mH5fCj0OxaayWnFCRzYUkfJWZP1TCmv/S5cvpgBoD0PbhfZA7p7zG1KBIwoTqyUvrhobRXn/g/MYryZcHDoJBcqyo7C35r7j0Y4O1So9Mx/M1/2WbmxNUIKjEXuix/sPxdAxRqi85C9DsKpC/UKJcP168mUtJdUlMNr5a3p0k3xeacj7O5+6xmIihb1vEcWxEbVBPlCVH0nZ1MzN84Rp8iVu78H+8UbinsgYklqjZURB5JWvqyiFwBvhL7TJgIp680Gqn7k7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BV0Yb1u3N48vDaJZeNoUIT4D6+T4UKSLwnwgfm84j8o=;
 b=sf3aWHpjOZtPEqd+uMtZSbSEIGHLsizPpCkaemIM0KsgHY20womSZen+mu9WnAHQ3zy1Zji4FpC7vswDLNqdvpsWratyhQi4M5O3VkB7tb32S7UOi4FV/vJUrJkZ3QXWb/mGcgMQyQSuKZTX5699k6tdUdCZUF8+9Vnrgtd13bUF3bDF1OA7rzB1+D6MtekHoNfpm8mMj0YRxPk/I3hab1He+8K3qMWe97GRR5Ie0yp/ou/KcM2zmkSzUTSliDv1x5YXKM0B6f1MCoo9/mq80gUcqt3PYWl21FNtKlqBzowb+cIPJqSKhEaUc3ZE1J72CCVcrA1wc92aym90ggZOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BV0Yb1u3N48vDaJZeNoUIT4D6+T4UKSLwnwgfm84j8o=;
 b=BHKiZuy1XGSOY1CuVR8lErhUpKnoePkW/p1ZVPylqm4dZuCvjBJ35SG+62BNJLCJ7zW3w622dOHalVLgGyJu2sxwv/oYZbF1c9upcCa4dgTxEJ9D5cHH6fp4aE2ZEPmspLIZyhwNnqAx6d4JSsngYm5+yu/rKVhkXKF5kWS+c9hUA/ffJKM4C8Qqle9Uf4Q6oR1YNdAxR8k+HOTemvntpM2pZn9Qo4UbmYI1O5qu91vgqw2fwCsa7StFJehU9QzARzzjvMFL0IQzgpUkz799wl0jSNTn13p3CEGUiWqBc3QtC9CT1bg3gRli1QA/GychLLv7J95FcoZYe1yzWKYGyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 17:34:39 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 17:34:39 +0000
Date: Thu, 4 Dec 2025 12:34:31 -0500
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
Subject: Re: [PATCH v3 3/3] media: verisilicon: Avoid G2 bus error while
 decoding H.264 and HEVC
Message-ID: <aTHGJzVKa7PbEifJ@lizhi-Precision-Tower-5810>
References: <20251204090813.595-1-ming.qian@oss.nxp.com>
 <20251204090813.595-3-ming.qian@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204090813.595-3-ming.qian@oss.nxp.com>
X-ClientProxiedBy: SA0PR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:806:d0::25) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|GVXPR04MB10384:EE_
X-MS-Office365-Filtering-Correlation-Id: a139c99b-9ff2-4e7e-1016-08de335b6681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rL7q+dQQbo3zi+eiN1tpZg86snv+8OpRbTU04zrl5kGsPPwEXxQ32kR49No7?=
 =?us-ascii?Q?o7wxEGg9FGaykLRzfwIz68jiYahnDRjPLPHmUsaTXLVvfEgt4I8QBFCbDWlk?=
 =?us-ascii?Q?CXlIXvJPqF/gLmVbL5nMHpg72tMv1emJP8uYroskp16HE2DmR2kVGnpr54AD?=
 =?us-ascii?Q?6aWv8qudAuKzUPrdY+bBb+h+Q6uT+qiYxcIsfXAqJxQAqEk79W+oObLE1wGD?=
 =?us-ascii?Q?mBQN7Z1AvQX3ixr+ifvjA76slCQkt760bFzauO2j3zljjau//iaAmNRjR11+?=
 =?us-ascii?Q?FIZVQniAYynsaTltS5KgYankOQgWO2ku3XCxjQYhYQJbkRp/YQOpgrms/zFQ?=
 =?us-ascii?Q?E+sSq9bPwVvgGMAibem71Rk2YxfiU+IkH0RVtwKJIdthtdi+dNzTjRnlMKMl?=
 =?us-ascii?Q?DOCAbIHu/IAbPKkP6rNbmuCNEJDeVHCTGdDNZ0BGXJqWV2rKr7T7fNnAp3QI?=
 =?us-ascii?Q?b6pRRd9p7UcKHPOrpprbWKFWR44oFwHidAEAWOdQjO7T10U9BIyrPy5d4kbJ?=
 =?us-ascii?Q?dJeJmMGYLgja5XwbyX7+liwkS2Pzb5n//m5jQNcVM4BeLeypyWA/tEVMtsCu?=
 =?us-ascii?Q?UI9NK9dt6izdeArEKv5a4GYBk0TEw3UZlTm8hpwW888Y2lIbDIqKyNA7VVj3?=
 =?us-ascii?Q?6TX2HaHIWmfAus659lr++jmHe7L/NjIsaBzrI6Lxg7M1B0BanLhQE2nPZwcy?=
 =?us-ascii?Q?GIkVzVtRH4hwLx43KwlZW6cilFhBHSkJK/9z5qKgnFjA7SO1o+aUdiOXh4Ey?=
 =?us-ascii?Q?40CJ9IvIOEYzaxH7Dsi64lAFDZJ/ybtjMjXrVm6vDbP0nPLe6QmVOxHMiIZu?=
 =?us-ascii?Q?jFHIyH9PwTCBrHz9IskNCsmt2X75NIfjJRcTBL8cXWPNjv5ZLWvyxoe7UQ7o?=
 =?us-ascii?Q?9DorPvDkHMvfBJ1+9tFDHwyNX4MmovM+5S8DL1e9falI7yjuHLdQ0w8X5bHV?=
 =?us-ascii?Q?8xU954ZYATeyN2cGyCLii+MgAtFiumo2WNiFOvID7Yf18Iy/eMzbH1zsB7cO?=
 =?us-ascii?Q?NjXChHihaoPn9Y8JSpLAJIThBm2gJdbu1+zAZlkIbv9ukf3kFVv+xTNxfWE0?=
 =?us-ascii?Q?JV0NrhdHfzRdU3MwF9VNZWojuTJeOQHx1DJevAKOaQqbqMVQTI1fgy2aIblc?=
 =?us-ascii?Q?FPyLC0rmVH6G85x7hNtUKXHbc4CcZMNrtts7Ff7tDDhnVNOPvC3f0rTWfG4v?=
 =?us-ascii?Q?lEL3FtASjYXL7B02zHdy7xEujAhjqQsZZrFbVLEJyZwZyvoCtVZNRmqmYoy4?=
 =?us-ascii?Q?vDvjSZeJLdw0vRm8FDq1Z+y5fAkRW+BGIZm5+yIrA+mJlcbJVkWzSU9azNIN?=
 =?us-ascii?Q?CyIRkAhhTyAqeM3r+s1iUUF4nMOtxUTr4F73bFs0tB0OkU+9p/C71z9049rr?=
 =?us-ascii?Q?v9PRlsKnkJGoKIEfYnycYSjTAQ+sd5dMCpbLNnD7st/kCFSvkjQxX6qlkIW9?=
 =?us-ascii?Q?OHXw15lDQVNLAH0Z10YXtGRWQ8RVW1ltZGcK7zighEKkHoNrxs23Lro6boxC?=
 =?us-ascii?Q?cv2jNDOHOM9/akGLJ/rlOckMtCm8R6hkcx7t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wk47N4OnQlalxpfRH1s//KGaDGVj9+IXGSO2IeH0NqWb3CwnBOlSFMQc4VdJ?=
 =?us-ascii?Q?he1SKiWi5C5D90KU1oj6a7LMwMmSQ4zBVm+j8l1vo5M3snO3NQk6X/QYANZM?=
 =?us-ascii?Q?Mo1olC0TqNIYrzaIAqskdOtsULEQtAWoX52UAN5OF7DyRaUoOKJRtpKQd30e?=
 =?us-ascii?Q?xuLK2oQODabphEqn5JAxPgmFA3b6BCQIVpR3C74TxL8unm72AbRhbr+PZrxT?=
 =?us-ascii?Q?YG8q7gzUFY5gIPas+9iWoIQ/V4aou+tH8ap/sfyEc0fo8Ro8LDd8tFzHBU02?=
 =?us-ascii?Q?UVm8GQ16tfI480xaOIvT0SUdsBWxEaOqNFjEipxPgLNzIyi+yALWChtQS7VZ?=
 =?us-ascii?Q?OAqODyyt7nlxp0Ipj7zzG8sO46Cyux+68ns2IvZk38IcFfK5jAY0d703nLii?=
 =?us-ascii?Q?/EwyqE6IFYx141BjD91BjwdTevvlnNxeA5MIEEpHIlva5MPxCX4lCR8vZKYy?=
 =?us-ascii?Q?7dR2F8qe3SW0ftaZHsXowUpUgUH4vjCnq/IaQ4V2BsrW4sDZPtTIfI84F/hC?=
 =?us-ascii?Q?hDwGallk3gdw4XGWLP3S0w9IXb1aP+ifX/hBhJPX6ypumFXm0euk9hOabI8l?=
 =?us-ascii?Q?vBdHpd36h8AvQEqce0R1V7ftCdkkbvyjSDZkdgL2Yy16sAKChtVw8oNIhbwP?=
 =?us-ascii?Q?OZvtaLgXcG/KNw+/IKgPuXb5xKKp83tCxAOpfz3aUIG3gSd/l7HfYKe9tW1z?=
 =?us-ascii?Q?09S6W+Q+f3fveigiM9ukqosAvl7OTKYZ4qDYtGjRaBJmHVxzBCUiO0xevSoq?=
 =?us-ascii?Q?8PEPnIaRSjLLpk4oftnAwVaWxJwTW0ON0jMOSY0zIaP/ZkO6k0LqWehJizaQ?=
 =?us-ascii?Q?AGCvHBuD3DzX53ycNeUfsSgJEA73AXdDL3IP1r+V70CBEaHOc9RE9yI9loze?=
 =?us-ascii?Q?qahVRUesq4dvSAfhQK23m2YlyY6JBUSwshmujRWUDCVWI6Xmnidv4j4E9U4q?=
 =?us-ascii?Q?hX5qgXhprZxF2vhmLWYZj3gBkpBASjgbsxohgtZ3hDSRT8Ym4BwhzzV5wG7e?=
 =?us-ascii?Q?NB0KJXVNUwtKLc7Xy0YCmlnM89nBOY/XrLMtZpB04xsl553Yvdy18Z3taHGZ?=
 =?us-ascii?Q?mZ51CmdH4iCScdj/ULrzYUUfoV5QsBxBJSYavqjJp62DQF9+ecFPXaFZ0OiM?=
 =?us-ascii?Q?toRBVnB4NDuC79Fqyk4uRPNbFbe/4Wh+dl2LpBhuPNFj/JiNU8Xm6tQTi6X1?=
 =?us-ascii?Q?+1jpVGQ0v9jytgyBIQfuz0LZIeMkONuNLl6IPyBvqHbZ+6sl0F/IMrEuu4Cu?=
 =?us-ascii?Q?v4280exDriPLsm4V3LBEPu/EdB3lf5yVdxBaYCKUSmkq7/dH9M91SciSND6D?=
 =?us-ascii?Q?1QhBNHxSF93XXMXiSa1W57Mno3aP8QSCspwAu+8Ag2l2anjaOx3ppHAWX+kf?=
 =?us-ascii?Q?8Qs1Zsu3wy33MwH9XrngbcOMR4Buqm2L+VZovNwuA1LlhCUYsDz0LXqSwapm?=
 =?us-ascii?Q?wpzAViwDaMvTjQXL27RuF8PDTrGTkDxvZC4ubVc1Jmk0yIUK5MGyEmYKKp5T?=
 =?us-ascii?Q?oZgwHBmIqCmyGj4MuA8146x6EJSadVPYV3rxNq+Nksp6XMAbdBtxWvDt2zVr?=
 =?us-ascii?Q?cFVVx4VVGqaDPjJDI8w0BlzynAg3BKHDBtzdPNQU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a139c99b-9ff2-4e7e-1016-08de335b6681
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:34:39.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saUXRzqz1ZRmg5Kn3NHBAIK2z1i0JQuAVultJe4EfgXa+HHwI3BcLIoiqAhZkGyjvhwJZIfnaG1OrbSIvnUpxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10384

On Thu, Dec 04, 2025 at 05:08:11PM +0800, ming.qian@oss.nxp.com wrote:
> From: Ming Qian <ming.qian@oss.nxp.com>
>
> For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
> g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
> error and produce corrupted pictures, even potentially lead to system hang.
>
> [  110.527986] hantro-vpu 38310000.video-codec: frame decode timed out.
> [  110.583517] hantro-vpu 38310000.video-codec: bus error detected.
>
> Therefore, it is necessary to ensure that g1 and g2 operate alternately.
> This allows for successful multi-instance decoding of H.264 and HEVC.
>
> To achieve this, we can have g1 and g2 share the same v4l2_m2m_dev, and
> then the v4l2_m2m_dev can handle the scheduling.

To achieve this, g1 and g2 share the same v4l2_m2m_dev, ...

>
> Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
> Co-developed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> ---
> v3
> - Apply Nicolas's approach that use an array list to define the shared
>   devices
>
> v2
> - Abandon the waiting approach.
> - Switch to a shared v4l2_m2m_dev solution.
>
>  drivers/media/platform/verisilicon/hantro.h   |  2 +
>  .../media/platform/verisilicon/hantro_drv.c   | 42 +++++++++++++++++--
>  .../media/platform/verisilicon/imx8m_vpu_hw.c |  8 ++++
>  3 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
> index e0fdc4535b2d..0353de154a1e 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -77,6 +77,7 @@ struct hantro_irq {
>   * @double_buffer:		core needs double buffering
>   * @legacy_regs:		core uses legacy register set
>   * @late_postproc:		postproc must be set up at the end of the job
> + * @shared_devices:		an array of device ids that cannot run concurrently
>   */
>  struct hantro_variant {
>  	unsigned int enc_offset;
> @@ -101,6 +102,7 @@ struct hantro_variant {
>  	unsigned int double_buffer : 1;
>  	unsigned int legacy_regs : 1;
>  	unsigned int late_postproc : 1;
> +	const struct of_device_id *shared_devices;
>  };
>
>  /**
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index 60b95b5d8565..70160eaf3d15 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -13,6 +13,7 @@
>  #include <linux/clk.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> @@ -1035,6 +1036,41 @@ static int hantro_disable_multicore(struct hantro_dev *vpu)
>  	return 0;
>  }
>
> +static struct v4l2_m2m_dev *hantro_get_v4l2_m2m_dev(struct hantro_dev *vpu)
> +{
> +	struct device_node *node;
> +	struct hantro_dev *shared_vpu;
> +
> +	if (!vpu->variant || !vpu->variant->shared_devices)
> +		goto init_new_m2m_dev;

I found only use shared_devices here, how to  ensure that g1 and g2 operate
alternately by using shared_devices?

Frank

> +
> +	for_each_matching_node(node, vpu->variant->shared_devices) {
> +		struct platform_device *pdev;
> +		struct v4l2_m2m_dev *m2m_dev;
> +
> +		pdev = of_find_device_by_node(node);
> +		of_node_put(node);
> +
> +		if (!pdev)
> +			continue;
> +
> +		shared_vpu = platform_get_drvdata(pdev);
> +		if (IS_ERR_OR_NULL(shared_vpu) || shared_vpu == vpu) {
> +			platform_device_put(pdev);
> +			continue;
> +		}
> +
> +		v4l2_m2m_get(shared_vpu->m2m_dev);
> +		m2m_dev = shared_vpu->m2m_dev;
> +		platform_device_put(pdev);
> +
> +		return m2m_dev;
> +	}
> +
> +init_new_m2m_dev:
> +	return v4l2_m2m_init(&vpu_m2m_ops);
> +}
> +
>  static int hantro_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *match;
> @@ -1186,7 +1222,7 @@ static int hantro_probe(struct platform_device *pdev)
>  	}
>  	platform_set_drvdata(pdev, vpu);
>
> -	vpu->m2m_dev = v4l2_m2m_init(&vpu_m2m_ops);
> +	vpu->m2m_dev = hantro_get_v4l2_m2m_dev(vpu);
>  	if (IS_ERR(vpu->m2m_dev)) {
>  		v4l2_err(&vpu->v4l2_dev, "Failed to init mem2mem device\n");
>  		ret = PTR_ERR(vpu->m2m_dev);
> @@ -1225,7 +1261,7 @@ static int hantro_probe(struct platform_device *pdev)
>  	hantro_remove_enc_func(vpu);
>  err_m2m_rel:
>  	media_device_cleanup(&vpu->mdev);
> -	v4l2_m2m_release(vpu->m2m_dev);
> +	v4l2_m2m_put(vpu->m2m_dev);
>  err_v4l2_unreg:
>  	v4l2_device_unregister(&vpu->v4l2_dev);
>  err_clk_unprepare:
> @@ -1248,7 +1284,7 @@ static void hantro_remove(struct platform_device *pdev)
>  	hantro_remove_dec_func(vpu);
>  	hantro_remove_enc_func(vpu);
>  	media_device_cleanup(&vpu->mdev);
> -	v4l2_m2m_release(vpu->m2m_dev);
> +	v4l2_m2m_put(vpu->m2m_dev);
>  	v4l2_device_unregister(&vpu->v4l2_dev);
>  	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
>  	reset_control_assert(vpu->resets);
> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> index 5be0e2e76882..6f8e43b7f157 100644
> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> @@ -343,6 +343,12 @@ const struct hantro_variant imx8mq_vpu_variant = {
>  	.num_regs = ARRAY_SIZE(imx8mq_reg_names)
>  };
>
> +static const struct of_device_id imx8mq_vpu_shared_resources[] __initconst = {
> +	{ .compatible = "nxp,imx8mq-vpu-g1", },
> +	{ .compatible = "nxp,imx8mq-vpu-g2", },
> +	{ /* sentinel */ }
> +};
> +
>  const struct hantro_variant imx8mq_vpu_g1_variant = {
>  	.dec_fmts = imx8m_vpu_dec_fmts,
>  	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_dec_fmts),
> @@ -356,6 +362,7 @@ const struct hantro_variant imx8mq_vpu_g1_variant = {
>  	.num_irqs = ARRAY_SIZE(imx8mq_irqs),
>  	.clk_names = imx8mq_g1_clk_names,
>  	.num_clocks = ARRAY_SIZE(imx8mq_g1_clk_names),
> +	.shared_devices = imx8mq_vpu_shared_resources,
>  };
>
>  const struct hantro_variant imx8mq_vpu_g2_variant = {
> @@ -371,6 +378,7 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
>  	.num_irqs = ARRAY_SIZE(imx8mq_g2_irqs),
>  	.clk_names = imx8mq_g2_clk_names,
>  	.num_clocks = ARRAY_SIZE(imx8mq_g2_clk_names),
> +	.shared_devices = imx8mq_vpu_shared_resources,
>  };
>
>  const struct hantro_variant imx8mm_vpu_g1_variant = {
> --
> 2.52.0
>

