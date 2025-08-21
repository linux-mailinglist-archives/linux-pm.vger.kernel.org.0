Return-Path: <linux-pm+bounces-32814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1459EB2FD89
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 16:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DC3685BC9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5192E716A;
	Thu, 21 Aug 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SdUbom33"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FD32E4240;
	Thu, 21 Aug 2025 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787768; cv=fail; b=DwdXK9bXA3NHO6l7yLIOFvJNDM3pzMyfZ2ngmWZE92PId4mzbQJp1/XHRocBtnmQc9Csk/8sNPBM6K4XwpjJ7XhcKOpjCet1vAhqgDy9vfDSHqvHtTGInQNHHW2BH2YcweF1m0AGREjis0Mv6gvcTbUdFCQrcN7aEei/ufVd+FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787768; c=relaxed/simple;
	bh=slQNtPD03Cjn+Gy49cU3o2wmxVuxucej3FvoLV49D4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D03bh3JRAfRqe5CK0/qH0lQHO+RQXsL8khg0GVBqCsGxXGl60cj9RsTQ+6A+N+uLWb+iF77Hc9feH/y6Pc1lK7shcf3wAhumnTkKfjmtPjGmvIWrJWsBEyFVgbm0pC1fVG+YabCv88NM8oXApX0DEE3tcCo1Dr4IBNY32uGu1IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SdUbom33; arc=fail smtp.client-ip=52.101.84.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2f/eD0O1avId0IQYhWeRlJ+/1jZBUqvTMqVrrxZWwDAmbEXylaT/luX6swLwmXNsqJ7eqKa3bd4pJdnryKVTQS4s04BX3U32sX8d6Qyss0b46XvVURpXM8CKH/zbvSGyorhRrMZ0oM0ZI/pAm14mdsQqPFKttEgg5hiM0n0dvD8QU8SyGP0jhg2xvcBBbkfrv1bUis04ApIOTusaVlBpSa8oo6LOdW3J3QsvWqkq1bpFTOJQxGWfjDRDnthppUAczmavIGGslt8GEnZOtHi/h4ekV5mQeJmsfhrDynNAXtqhDNuiE+pZu1QYpO4/cgqyhtmICYKD8tiLIKO7zk+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4g4LpYYI1oiKIWdPxU8DXIhVwrTAgl7zPiy314nXfY=;
 b=SKchytKDUdSQTXB6hsWmn1Fifobe0EH8JjaCSIM8ici6QNA1h1Mi1sfe+g9H0qnTGRzD9aHtZEe0BEYWuyKyITv2+wCkxlTfGhyQsF/AFRyeRm2ECDhiBflaaBi7gE6of+vD6XnmW7Bnwj2am4y8BmyeTkcp3F7Z8jc8Jm5IjDm79iQLc6rCidEsBIawiugTSNZtMfX6bTe9NCaqRgEeeaAeeYYQvyTkfr4Id8GWcbNvgUPmnQpL/WPbWskCA8bKHjq7xqFwjRZVHQEN5GgAM0HtVE7jmF9/nIuyPlHESop/PD2QcfgJcBu86fhEJeXzdusYRNty9wu0I/fjCUP7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4g4LpYYI1oiKIWdPxU8DXIhVwrTAgl7zPiy314nXfY=;
 b=SdUbom33XuvzgYGEdzO0FyrkdKZcHy9xRAA7zpgNlR83hs3c0CUlbm0qedFpEZoyAD9Sn/AMMSqzRXnQGwglybc2oGaXfhEUVm9+wsruvr9njPo7VFLlBx5HgAsnOQdecFebyW8AEucrIm4t7OAp/jTf2snjeYr6qqd7l/xVMXsl2x9zp57QZi523kZDX2WMJwTcF2Qc40TlfJ73QBSN85Jq63OyLltnojKFy4V9n+wfgAZEZTXEnXRKOUYLt8QmXjN5+m2QmVPmHDpFUIrye52YZJPryWSNeqZveuo/THxF1uTPfvN4p7HnM/gGNk84hLT1BxeFLi01D2p0HEIr5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM9PR04MB8148.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 14:49:23 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 14:49:23 +0000
Date: Thu, 21 Aug 2025 10:49:13 -0400
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
Subject: Re: [PATCH v4 3/4] thermal: qoriq: workaround unexpected temperature
 readings from tmu
Message-ID: <aKcx6Vp1+X24O0tG@lizhi-Precision-Tower-5810>
References: <20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com>
 <20250821-imx93_tmu-v4-3-6cf5688bf016@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-imx93_tmu-v4-3-6cf5688bf016@nxp.com>
X-ClientProxiedBy: PH7P221CA0043.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::31) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM9PR04MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfeb138-ea3e-402b-afa3-08dde0c1eac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8FrrRrMF2RBDpQWB8CFaOzKvWQlE3wUTpwZjHfb2G6SnM5FxDpcbL+kL3EQr?=
 =?us-ascii?Q?C2ff9d7WOQbr8C27+BLFHVSNB/F3fkseZetd4PiMLoSBW48GX1xOQP07WE4/?=
 =?us-ascii?Q?YPD9DddKHWjxbE4Er23JS5Llle5W+tOydQcp/Y0y4gAT0y/KzX6g37OVWJLD?=
 =?us-ascii?Q?a6I4foDUpyoCQ75ULVvnDjk5EhtxI6kN9GRLQW82wVvtjWr+PW945A/vLklV?=
 =?us-ascii?Q?D8/zDWDDCz26ljc4I+2eVHsdY5C1XBvBcazefmBekJnAahRO8J3gEaylGcM2?=
 =?us-ascii?Q?mqZwb9gdOc94S/kMBcmDKkBXTrczt5UxyCMNvT1tnsKi/N7DErrNAqtmwpLZ?=
 =?us-ascii?Q?gzwSojlwYJKYGiMQhkB9A5joRvt3ZXq+EU5h6OWugGP/BbrK4CuXMsc/pj5J?=
 =?us-ascii?Q?dzWQVJcFqdCekuq5FSBqjB7YivWvquRCeW0sKw9rihEJT3PADIk8g+zNQr+s?=
 =?us-ascii?Q?klStG9nwGx2HEqaU1+PeFHnfJVTvncGrfTNtOGW+tdS0++ldsiJlg4QJseAA?=
 =?us-ascii?Q?acg+nKAuUyHDunrzDE97Cb4DMamIgPSoO5BZzLYJuZv9vWqvjbnw8eUVId26?=
 =?us-ascii?Q?pOiSV83aYBcgzfhjx4DKJZNrgz2MIQsQjXvwlm1+Ke7PXXkQChuFfwYA4MTd?=
 =?us-ascii?Q?NOmHX6uXk9exY50+DtPoNZDDsWd6NB3FFXK6dVXsEC1plo9pgpkGV8ahwTZK?=
 =?us-ascii?Q?brg1FG3vA9e6JB/PMcecs6Oqry4ssi2J0EmfTUsyX2tTJsG40B5kXDGXPEDQ?=
 =?us-ascii?Q?jb09DPttiNHwhaKF0aYbkhAiOPKTvIvQMhr0mNtpq66NTZ3rHLxvsSOTDQeL?=
 =?us-ascii?Q?juz3OmewmV3QHR2qLjx8UHRByDLglg9/B1n0OU8poi1+dCK0vVXRVFboW/md?=
 =?us-ascii?Q?Ngav1cbUkgrMikttnD6ldHnTkdiztkQcswiui1Ch3eyzlaT31r1VSwKO+GWr?=
 =?us-ascii?Q?XhW43MQkqRS1GPzlO/ufXTJI/psEYJjsyfV+J20jJduF6sC3wnOI6yuAWYAG?=
 =?us-ascii?Q?CaXM+WKsC0LnM288oxwZbatO7B0ZguaKKUPIN2ipZhzjZhgwIBI1mD0Yt392?=
 =?us-ascii?Q?TtLebICFzUrwZ49wr2p7/hK8nc0gskaWhkMMKe9oTBBTAt5stcqez/1p98a7?=
 =?us-ascii?Q?tInkS2H4SXPYygj9vq2/hgQJBHEuDo7lGZuI93ghvRUeDnLWOvAOxRPeRJxd?=
 =?us-ascii?Q?QuRDdQkxkTzuaq0OHKMWwKQY4zQTvxnxDS3hySEFvM5VIxQyfH6LXfJmi2Ud?=
 =?us-ascii?Q?5OgUxU1h1yW4G8T7f82A2oAyYS8wDW7jEUmALLaUEpNvB/134mS0zjacb8vE?=
 =?us-ascii?Q?6Cv1Tz/bi1SspEDq+9Lg6d7e+E2NTm2fLa8uKZctAT0ka0fUCXVWwkCS6xy9?=
 =?us-ascii?Q?1zHepqeBpm9vmrPMfjUHNc9V8WO7outQpzyvZaoNCoOHT8IqvD2uFWYUHmLI?=
 =?us-ascii?Q?2mo31POGagFSAtSjMVeRtktR5Wx7iKg68DWPE2EbUBh1YJwJqu0GAa1+MlTG?=
 =?us-ascii?Q?nDsHmLyAEV8Ocuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?upGhjKDe6y/s0db2pIS7uOL2MMrPyw1ZIZ7vtZKNTNGqKAoNIKC0Zib9XsSg?=
 =?us-ascii?Q?hRoVjltLJ98nUBfJW4GK2KZtosnkBa9Z/T3fBEh/iilbIBD5KqGRDUJ4kXog?=
 =?us-ascii?Q?UaNDGyLkGRubIVxGcYu6pDsiGF9qJL+S+DpOZpz6LKtK5F9JOEWslkhRJ7aV?=
 =?us-ascii?Q?6EaQ/D1GZpoDJOhb+D8M+xwaXOAAzQNhhwqKW3gRWjKrlfFJphY5LlGQAneg?=
 =?us-ascii?Q?vd6mr6PoVx7K7f1F6mHw3o6JyREEOQjlqHPfrsobfKrT3P64nuszr1wAOg1k?=
 =?us-ascii?Q?MsyBJqyMAjkKF+1BzY4/APKmzPf2xFM2XH1a/7wH19uReD2cBJN9tehSko3s?=
 =?us-ascii?Q?2s+h5iuI7NQK6SuTyO8uhUnnffIhY5VI9q/TGUYYQHEuS6mN0d74usX4HARS?=
 =?us-ascii?Q?E1YI3d8fv2cM00O5yG+xUSRf4c3/UkQsVR7U0UBgdmn0izivZ63Zd8l1reAz?=
 =?us-ascii?Q?9Sk+gGWdAdhrG0qF0orF+rRevyVc6vwhWaLZ3JWZY9d5cW5ei1oA07/CbvSq?=
 =?us-ascii?Q?U836OC65EUzjwxkhoGEDT9EUlmcUnNEGZTkz0zGI6uXOBAFCIIQVpHdV0XtC?=
 =?us-ascii?Q?RVAYClikCW8Fbdapces92A9j3fYRbI0F6mX25ixOiYupfamrCT3NVAPnfrPX?=
 =?us-ascii?Q?IXAu1yoVAxACPEqMs5CpDK19LYdoZIncGL+x/AsB6iWeQh88G6PEiTF9/NaI?=
 =?us-ascii?Q?Z143EhMYBwXT72QdiWUnLKL3G07XRSBX6K1Ik+FELlHj+y/uouWoLNXHdzBy?=
 =?us-ascii?Q?JgYKhXsLWMngieG7ypexB3sOHePZTfEcT6h5n1lHbgP+l4KSdHZBuOotb4mo?=
 =?us-ascii?Q?11HqxDXdXR2b1bmSUu0NhoF/5nvNBTMKWiF0fI4v6L6YKANSraEAQJa6l2Ks?=
 =?us-ascii?Q?MhmBdz02ZuZBBJzeOuVZQTRt/xYPNPegb5nSwGXMnyhkVMUviprO9i9hcdln?=
 =?us-ascii?Q?DS6Ugkrf6UMqkGIL/1lQd0WvU3PwOTiVMvMs5eWkB2h+QN3SPn6lgUIPzZGW?=
 =?us-ascii?Q?RTIQzG9e/oGTKq0wXxIsq8YEma7Sks4k/V15KxlZWXNbctJbe1aIcLC7nXM1?=
 =?us-ascii?Q?8arVm0NtInmxvb26GqFTBmGIBgGU646k+aLdXOmn5OxNPWi1YVBnhjEwbAYY?=
 =?us-ascii?Q?OV2rc0sdHccrUBAxM/XNfPebKDh5NG6Nve1J6tjLEuTaNeg5tz56mp0Q5ios?=
 =?us-ascii?Q?VjZlzCTIdcWQqfmq4Iu6SklgXhrTblMrAcY+YFrvaA6DATyZo6FEwQy7HR8F?=
 =?us-ascii?Q?v0QTo7nUGYxIjoQnf5u1zbuocbAhznU/XM5FuvSo4UHkZCB+S172zM2DDWGM?=
 =?us-ascii?Q?86q5WoRgpoTKaYGJQoRc53OqM4OZHbEcnxQyHAqwz1o+G1/alc4iroroYxi+?=
 =?us-ascii?Q?NniJZA/3l7R7y49zkJ8y6s3Ci4HNsTCEiACgB/H8RDR+1NMgBYC7cR1adSjv?=
 =?us-ascii?Q?h24SM78vfQgqHJFpag3/W3WERJGZCckrda7wdSxcGOwhJlHKrGjlT6ZbwYut?=
 =?us-ascii?Q?+QrJ2M5CzCUWl9We5LK57wkUnhZOsfh0EZdKMPDXOXMkathBZUR7OtXqvZpZ?=
 =?us-ascii?Q?QCUZYdGXDWOQL+pAWPpvXoCTI3zgCuybME/C2XYy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfeb138-ea3e-402b-afa3-08dde0c1eac8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:49:23.1090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D240w5xzqS2Znf8o4j/ETk1/1WFQfkIYp7vrMEwLEL+qhcX3gfXC5O2YdNzj4Mjy+73RVi1ByfB8E87p2EY8mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8148

On Thu, Aug 21, 2025 at 02:23:51PM +0800, Jacky Bai wrote:
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  - v4 changes:
>   - include bitfield.h to fix compilation errors for RISC-V
>   - use macro define for temp rate related setting
>
>  - v3 changes:
>   - refine the code with FIELD_PREP macro
>   - add errata doc url link and refine the commit log
>
>  - v2 changes:
>   - no
> ---
>  drivers/thermal/qoriq_thermal.c | 44 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index b2e634547271dcf512c714907baa162921d2d527..0a505e9e66a839155675a3d78a67de95a670602a 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -3,6 +3,7 @@
>  // Copyright 2016 Freescale Semiconductor, Inc.
>  // Copyright 2025 NXP
>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> @@ -30,6 +31,9 @@
>  #define TMU_VER1		0x1
>  #define TMU_VER2		0x2
>
> +/* errata ID info define */
> +#define TMU_ERR052243	BIT(0)
> +
>  #define REGS_TMR	0x000	/* Mode Register */
>  #define TMR_DISABLE	0x0
>  #define TMR_ME		0x80000000
> @@ -45,6 +49,15 @@
>  #define REGS_TIER	0x020	/* Interrupt Enable Register */
>  #define TIER_DISABLE	0x0
>
> +#define REGS_TIDR	0x24
> +#define TEMP_RATE_IRQ_MASK	GENMASK(25, 24)
> +#define TMRTRCTR	0x70
> +#define TMRTRCTR_EN	BIT(31)
> +#define TMRTRCTR_TEMP_MASK	GENMASK(7, 0)
> +#define TMFTRCTR	0x74
> +#define TMFTRCTR_EN	BIT(31)
> +#define TMFTRCTR_TEMP_MASK	GENMASK(7, 0)
> +#define TEMP_RATE_THR_LVL	0x7
>
>  #define REGS_TTCFGR	0x080	/* Temperature Configuration Register */
>  #define REGS_TSCFGR	0x084	/* Sensor Configuration Register */
> @@ -69,6 +82,7 @@
>  #define REGS_V2_TEUMR(n)	(0xf00 + 4 * (n))
>
>  #define GET_TEUMR0(drvdata)	(drvdata && drvdata->teumr0 ? drvdata->teumr0 : TEUMR0_V2)
> +#define CHECK_ERRATA_FLAG(drvdata, flag) (drvdata ? drvdata->tmu_errata & (flag) : 0)
>
>  /*
>   * Thermal zone data
> @@ -79,6 +93,7 @@ struct qoriq_sensor {
>
>  struct tmu_drvdata {
>  	u32 teumr0;
> +	u32 tmu_errata;
>  };
>
>  struct qoriq_tmu_data {
> @@ -99,7 +114,7 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
>  	struct qoriq_sensor *qsensor = thermal_zone_device_priv(tz);
>  	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
> -	u32 val;
> +	u32 val, tidr;
>  	/*
>  	 * REGS_TRITSR(id) has the following layout:
>  	 *
> @@ -124,6 +139,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  	if (!(val & TMR_ME))
>  		return -EAGAIN;
>
> +	/* ERR052243: If a raising or falling edge happens, try later */
> +	if (CHECK_ERRATA_FLAG(qdata->drvdata, TMU_ERR052243)) {
> +		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
> +		if (tidr & TEMP_RATE_IRQ_MASK) {
> +			regmap_write(qdata->regmap, REGS_TIDR, TEMP_RATE_IRQ_MASK);
> +			return -EAGAIN;
> +		}
> +	}
> +
>  	if (regmap_read_poll_timeout(qdata->regmap,
>  				     REGS_TRITSR(qsensor->id),
>  				     val,
> @@ -132,6 +156,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  				     10 * USEC_PER_MSEC))
>  		return -ENODATA;
>
> +	/*ERR052243: If a raising or falling edge happens, try later */
> +	if (CHECK_ERRATA_FLAG(qdata->drvdata, TMU_ERR052243)) {
> +		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
> +		if (tidr & TEMP_RATE_IRQ_MASK) {
> +			regmap_write(qdata->regmap, REGS_TIDR, TEMP_RATE_IRQ_MASK);
> +			return -EAGAIN;
> +		}
> +	}
> +
>  	if (qdata->ver == TMU_VER1) {
>  		*temp = (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
>  	} else {
> @@ -246,6 +279,14 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>  		regmap_write(data->regmap, REGS_V2_TEUMR(0), GET_TEUMR0(data->drvdata));
>  	}
>
> +	/* ERR052243: Set the raising & falling edge monitor */
> +	if (CHECK_ERRATA_FLAG(data->drvdata, TMU_ERR052243)) {
> +		regmap_write(data->regmap, TMRTRCTR, TMRTRCTR_EN |
> +			     FIELD_PREP(TMRTRCTR_TEMP_MASK, TEMP_RATE_THR_LVL));
> +		regmap_write(data->regmap, TMFTRCTR, TMFTRCTR_EN |
> +			     FIELD_PREP(TMFTRCTR_TEMP_MASK, TEMP_RATE_THR_LVL));
> +
> +	}
>  	/* Disable monitoring */
>  	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
>  }
> @@ -389,6 +430,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
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

