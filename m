Return-Path: <linux-pm+bounces-39494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F11C0CBC2F5
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 02:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52A1E3007C48
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 01:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D641ACDFD;
	Mon, 15 Dec 2025 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KIbgtD9+"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D03618C2C;
	Mon, 15 Dec 2025 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765762513; cv=fail; b=T3EeZ6YjAU0ZRiNAlFE2+xWQx1rHJ7ugQvPXvE8PXwQW73/YdZa+uBOmYcYdgASKYkgIQkpbmsJCMSkG4KG78USLHKfwFKkBKkjZH+yuwXfP3HwqPN4LqmyxwuJjDz0RGioPFmqYBHmnhDN3uq0ZDttM1TaaQezhy3PhIG8X1d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765762513; c=relaxed/simple;
	bh=jDnZGcyzoJE2Htz4wVnW4sT7+7+IGCqXaX1jAJ/Nzfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQLncBBCv4qZ2nHllIvtOnzIpZdUIYx6NrBGRYrxClhRL7nHCdosYv9AeYRl5YB0oE6Z1vQrtUoWY5jZSt8MzmejGEtSAOAyJp6y3rfdBHDFz2wyV433BicBO3dICUL+qJNJ1Hij/MS4gRtv6IQWOyHRn8SIjoxYnLh3y4G1hAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KIbgtD9+ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCvBNtDWKUBJx3rpdFC9iKLAA9r7p0dJruEH4oge9xub7UYdXTDEsqg0w55/HkOj/VrmEm4E4JlxEekO3uukhfsGV6P36qT8/gb4Zk31YoZttyr9OIP/NumKYzEyZLvZI9kopUk7m1Zuyk4baBR8F4AOuKAJGbGGo67WAv4WQAHq0KI8M4z/c4SQG0CyixdKtCMvB1Xnua/NXg/2jCmiByDmJdpgYjeir/0aKWBCmpfQC8CY3CooL7SLBJrkOBlLFakJjzx0GamWjO4v9KIzUxwL9kWHlVntcv55k00HD7A4ZaC0w8SICL2QAZf10WK/+eFw7EzXaH2UiGdi4mrqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LX+WDGc+wpxottILdIbB9Td0KX+jeYljb3auWe4oZ3c=;
 b=AA/h3w2f5FY1AlqsSdczNADvIop9FgdC9/ctbzEfuAuqFl7gLbSM5rPRF2T/demGeK1JPr1WEB+hvh0tizlXSIeVPreuxU/WW1tR1d3WvrCPBj7zLai/rZshYG37vlFkbtdZz6cJYxgQYwu3O1Yrt5QOQjRdTEE7Qs0vDzNVeJRB2V738lEOoprXqUcm0VZ0iNLOFnA9XQAt1JSkB4/Sjf6QUI5Mh23osY2P8IeFTnZluKaIfT9AEHgfo2V3rArkYjcG4ptyjCV8dagofPSJt/rGP6By5jWiPdnZGvzxFXio5FDGD/D3djBljPtOpaWWo8Y+OG5beLQoPwO6PvfXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX+WDGc+wpxottILdIbB9Td0KX+jeYljb3auWe4oZ3c=;
 b=KIbgtD9+sn0DMuLQZKfZyvImCAK3jwYhHHBByZyaGyQcvj9/iRuHPmA4WlgAYfQCQ7jlEMTt2rdFNQ4tHL+05WhCMBX/vpoSWoDnPxgPUXG6Cfphk2IQlCtSKhrfv4i/hwbdViX1+R3ojlX/YH5JZ3HUsJG+dd10xAzAcj+zdj6KhbwVCAi/XSVqIWq9S4OrOKxj9S77Rxa09smNmH2xbYzAK1GI6LZVr4FtzVStV/2x6cZNR5sO+bXNtz4PNDfxKJ3hm3AS0YoK3J0oAk8rChPPDpRsOuLBdLur/RqB/7KPkt1HNuZK0zf5rHS4DiU15ittKkxQJJ2yJ0iVlcR9ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB11016.eurprd04.prod.outlook.com (2603:10a6:150:206::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 01:35:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 01:35:07 +0000
Date: Mon, 15 Dec 2025 09:36:19 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/3] thermal/drivers/imx91: Check status before reading
 data
Message-ID: <aT9mE63WtVqCxIPC@shlinux89>
References: <20251212-imx91-thermal-v1-0-c208545b44cb@nxp.com>
 <20251212-imx91-thermal-v1-1-c208545b44cb@nxp.com>
 <aTxQHLh0OD89oc/g@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTxQHLh0OD89oc/g@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SG2PR01CA0164.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB11016:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6f5fe2-526c-46a9-ac42-08de3b7a2d86
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?HLHecfef+ip78EdRYfaP53mbAUn36wyKKakxu/5dcCqGo1poOq5z40NJsE?=
 =?iso-8859-1?Q?GvCrQgXNp1jxyEy5CL1KYKu34Xj7vqgWQDdEyzzqD45GP7/GfhhVZFmdjg?=
 =?iso-8859-1?Q?ER+FcuZqOV8TYAPxzAlmjg+zWigsHo7EJ8IwFogUW7HFK6gsQ+U7WA7jX4?=
 =?iso-8859-1?Q?vEC1bn1RJWGqgaLdtQ5VydX5Opt7NBrXTvwbJ3ghyfn4OZX6H7Wu+K6G10?=
 =?iso-8859-1?Q?u2vfq+uGbChZlvs6IPwElHYNAVpB1U9XcygAW7W7og9EMwR3B94DMIAdpA?=
 =?iso-8859-1?Q?F9mFVC4aNDjLGNEYYQ24aUcG+jWd7ocJzb7dNX8PCAyK0VxdDwxwRZWc9Z?=
 =?iso-8859-1?Q?5lRMcxSvL58ZZo9RRqeFuAt07vzq6YZlZNEuiJok/1wadVLH3bMe2TLEXn?=
 =?iso-8859-1?Q?HVYQDsW7NLIumg+WxGlh0F57mXLNw04DEtGcRvYSwResoTOa4p7ab6GRNL?=
 =?iso-8859-1?Q?ngb+jiCGa3I7qKsirvANlF9gCw6bnBr5GggYMpmpVEOkKy2WAdNhXDQcw5?=
 =?iso-8859-1?Q?6PDZyv/3kSmzZMWXxFSbkvF69Qy7VgVMIl7lGEJPW4ggG/bHk+6XScKJ6F?=
 =?iso-8859-1?Q?KwKArksrC2qo6cLQLZlhsIjLKb4JR37Df9gJoNBGsQ/cp2yqrkIwiGFdev?=
 =?iso-8859-1?Q?28lkqdsUOlGjosCCTJg/eh6VXCTk8kj8BiVIvuBXTuNLg9sOGuN77K87nn?=
 =?iso-8859-1?Q?UDTgql3cbIqm5QMVKSvb/kstYCqr91bS8dHEj+abPkYTnN1j63saHzDNiT?=
 =?iso-8859-1?Q?EGYpu3dmVPW+VJ8DvJmi21oLXpJo9NVkkJ138J7rzPStQC88jUTVkoU5wW?=
 =?iso-8859-1?Q?X4KYOgOgiwqMsbbO3dFQCkKyqcX6RpPmfal332m1OM8qqf4mijsWjY/NdQ?=
 =?iso-8859-1?Q?DLZ8hng8HoZWF27EW85kATtffPxIqwkAXRM8pfN2wRFaa9kMx+31YyQ/aU?=
 =?iso-8859-1?Q?U2sbPwAHBSVYeLoCqgKRsAs6mDLlH9nhXkWajyvRqrixPLtUVA+e0k5XC2?=
 =?iso-8859-1?Q?PVcOBnXVT5u0hEySh2HJ0FyJVyAyLxJL6Qj5h08sZCBfVTY/NHKz8kh1cp?=
 =?iso-8859-1?Q?pKwFNdsL9PMCwZMSyrEK1or08RMDVt/oy62p0BFX/OaCP8X1BOKuCaHRUh?=
 =?iso-8859-1?Q?aoXm1tnxB0zFn1AxThzkoDXzcXwRyxPkgaNSI7uvjt2lClsAOxkgX8NDqd?=
 =?iso-8859-1?Q?QoC32pcx8Ho3kBkiq27rDIwgLEPnSqjT4d1mcwhaQCUdkqj7Qu7SkQCH3O?=
 =?iso-8859-1?Q?wzDfCi3zmhOXMrpgTpMZZ1bkZ8SX3OS8S3dnoSOcYw3hu+3tO17o2I8wbH?=
 =?iso-8859-1?Q?zbotWRovC4jHgwdKhNJtB05JQKpckKILU+3mwHYc9gqoWmZDK7A/4ilH47?=
 =?iso-8859-1?Q?oKIFX4edD6q/SwiP1+xRuIaARRptVAMKKiHERRhhLhsVtb+MRwmj0+8p8o?=
 =?iso-8859-1?Q?BVOR5jeUcpMfVYc5VFpxKoZ1oeS/2LaFm95+kfq32gswg+xm3QlYcntSYX?=
 =?iso-8859-1?Q?uPYMVB2KtKYYr8WxM9wqM/URcgxcaQSNN9dKVWPE4alF4hYh0Xfe41wjyh?=
 =?iso-8859-1?Q?Qj7/oEItKvKINoUh/ADe8HHYiI2K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?fKGSGH/V7/n5peTRPyXvp3FqTmyga79VK/NP780clI5MQle+0wNdQTH51N?=
 =?iso-8859-1?Q?MzW7XRFISCAmZuaf8LcPxhAnVwUXYJfNzvTS1pW3ZH/tbz90BAYgIXaSpu?=
 =?iso-8859-1?Q?gC7BpMAF2iyMtmHW+YM5vt37yWDMUFlbaYuOfYivBUAmiPkQoat6flHl+s?=
 =?iso-8859-1?Q?EhZRAeOQgg45j9KZh+KeSq3ILdZj5BS5ntPXOjt2/FGZgyvmahe+i/OdnS?=
 =?iso-8859-1?Q?9RNQJTLWm29l652C8DFHduo7xbynbsXFB9d/OBI8G7Gvf3AuR5R6yYoVR+?=
 =?iso-8859-1?Q?0I2ntDA5A9hr3V+EtBaWfrdmXySd3gRw6aAy8Dq8rWC7xkORTlHHqq5I99?=
 =?iso-8859-1?Q?hhvGMwec985+6GtImC6lcEeWiBTlI9GiJUXEU0tB6UK+48ShcFl4XVtlW+?=
 =?iso-8859-1?Q?/J1KSX96sH53CSoDxBsSYSe0PQv2y/Hz3CAz29C6qwf+SaPuIeLfS84KTs?=
 =?iso-8859-1?Q?71fee/iBdgWbuDiQ65EPYpBqdM183/au/+zs9D8Wl960i9ovGrvZOKnDj5?=
 =?iso-8859-1?Q?iQyvMUulNiI8YdI6lFghpgpQbHNFptQD74Qmh+p8+79N67thLVjH/+4zZE?=
 =?iso-8859-1?Q?Q6MMslVE3ZIb2XQb0YcNbNb6tKsBcUFFRY81VjWfSRe3TXrn7RumEv8Lej?=
 =?iso-8859-1?Q?Y5b7U5xPpabhomKbgZKUaZUhdUjQA3Wf13FQDUA/NMucTGfGqHNtUnC8Yf?=
 =?iso-8859-1?Q?ByQn2HHIX98P1Xow2RN5NLjkLEIiv3PRGAOXW3p39QfX41POZ2YF0fjx9+?=
 =?iso-8859-1?Q?jcMYJ+FJFRtJvMEo9CZ8IsdcbFsAsTFYF1jW5XmNy8KwmL1BUj6CrcL2yk?=
 =?iso-8859-1?Q?mPWJSDieNzRTHAmFDdk29nXYZKUYUaRM8/0QgKdy/R5MBxcOLJI9KqxEKy?=
 =?iso-8859-1?Q?5wwSvIbQG3GKcU/R1GEKfhzHrhB3Nphqmx8lazsWOhdrScED8nu8NICsb4?=
 =?iso-8859-1?Q?JJNVcNaEST6JfEKglfc5Gx3yxXZkQrv7DgC/IXxbidbsdVzZlFqylh213g?=
 =?iso-8859-1?Q?uS7GK751z2/AXKpsFotZc1iXz+jyiQVSvnFl1wMuLzeB+pAX7XeJ5fveeN?=
 =?iso-8859-1?Q?V5VTnxRUMP8aiSns189c6pRkajeojQ6j4Nbuoa3ZhhNXRySaGf7dM7Pjq9?=
 =?iso-8859-1?Q?ud28Ki4z/K7MWS7Tn/SnxgViVJLLBpw75fNoXihR1exBY5ecFBulhA/EJc?=
 =?iso-8859-1?Q?bL+RB6bMHfJcpET+8VxKLS0Gezoslh2Gds5DTgwVGvgE1y993vXwVrF82Q?=
 =?iso-8859-1?Q?S2Me4gNJtMQJY7G/77ZJvnfuNhvaPQwE5mpPXdfFuiQsBkgCSv9dwCg7bM?=
 =?iso-8859-1?Q?AskmBxuc83I3IjmpYI9ZSaUHkIllXK8GbdZG/1mDtyZHDNgryFAi9EWgfN?=
 =?iso-8859-1?Q?5KcRhHcTEs2FdYlZ6fyYv88ZdUSd3X9MUGbGnz/o3kJRYAqcAeezyiSW7o?=
 =?iso-8859-1?Q?bNDBlE92gBtOjo6GV37N5WqYymxVbbR7yIJ8NxhnLnmHY0fVkYzgh4ybtt?=
 =?iso-8859-1?Q?Msebbsy9WVdaeAQRThtO9HiWeNkwSVJc7OT7noVY+TUikc7CsK3MxwIQp9?=
 =?iso-8859-1?Q?Yc5S2yzAsWfiI9v/emTs19L606j8M+zjzbwruya1IUstan7s6UYW8tjLyi?=
 =?iso-8859-1?Q?bRQv0wS/zTDUTKbd8XJGeJ+AaNLIbQtlCt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6f5fe2-526c-46a9-ac42-08de3b7a2d86
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 01:35:07.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: We3SDG9Xh/+vCCILC40ldvN0eu+klZQwkwYRHRJOp/ml+C10W/u5f+aTSjfh3DGIERYsle6mdLquld4qNkXHNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11016

On Fri, Dec 12, 2025 at 12:25:48PM -0500, Frank Li wrote:
>On Fri, Dec 12, 2025 at 03:51:14PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Per periodic mode from reference mannual:
>> Write 1b to CTRL1[START]. Wait until STATm[DRDYn] becomes 1.
>> Read DATAn[DATA_VAL]. It clears the corresponding STATm[DRDYn].
>> DATAn[DATA_VAL] and STATm[DRDYn_IF] keep refreshing at a periodic interval
>> of time, corresponding to PERIOD_CTRL[MEAS_FREQ].
>
>It should get last time sample value without check DRDYn_IF bit. it should
>only be a PERIOD_CTRL[MEAS_FREQ] delay.
>
>worst case get value at previous's PERIOD_CTRL[MEAS_FREQ] sample.
>
>PERIOD_CTRL[MEAS_FREQ] is quite short compare to call get_temp frequency.
>
>Do you get invalidate data?

No, this is just to align what we tested in LTS tree.
It should be fine to use last value, so drop this patch.

Thanks,
Peng

>
>>
>> Need to check STAT[DRDY] before reading the DATA register.
>>
>> And check the returned temperature to make sure it fits into the supported
>> range (-40°C to +125°C).
>
>https://lore.kernel.org/imx/aAIkAF_AHta8_vuS@mai.linaro.org/
>
>Do you answer Daniel Lezcano's question
>  ""When the measured temperature can be out of limits ?"  at v6 resend
>patch.
>
>Frank
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  drivers/thermal/imx91_thermal.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
>> index 9b20be03d6dec18553967548d0ca31d1c1fb387c..77e8e6a921c6af308b830c36721293c007256ca6 100644
>> --- a/drivers/thermal/imx91_thermal.c
>> +++ b/drivers/thermal/imx91_thermal.c
>> @@ -108,10 +108,20 @@ static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>>  {
>>  	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
>>  	s16 data;
>> +	int ret;
>> +	u32 val;
>> +
>> +	ret = readl_relaxed_poll_timeout(tmu->base + IMX91_TMU_STAT0, val,
>> +					 val & IMX91_TMU_STAT0_DRDY0_IF_MASK, 1000,
>> +					 40000);
>> +	if (ret)
>> +		return -EAGAIN;
>>
>>  	/* DATA0 is 16bit signed number */
>>  	data = readw_relaxed(tmu->base + IMX91_TMU_DATA0);
>>  	*temp = imx91_tmu_to_mcelsius(data);
>> +	if (*temp < IMX91_TMU_TEMP_LOW_LIMIT || *temp > IMX91_TMU_TEMP_HIGH_LIMIT)
>> +		return -EAGAIN;
>>
>>  	return 0;
>>  }
>>
>> --
>> 2.37.1
>>

