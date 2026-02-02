Return-Path: <linux-pm+bounces-41875-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAWMI7U8gGmD5AIAu9opvQ
	(envelope-from <linux-pm+bounces-41875-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 06:57:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD1BC866A
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 06:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E00B300AC3C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 05:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004582D7DF6;
	Mon,  2 Feb 2026 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bdzflGGE"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013044.outbound.protection.outlook.com [52.101.83.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B52BEC2C;
	Mon,  2 Feb 2026 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770011824; cv=fail; b=FJZbx32nzqE9sgs9JN3o3HWOTz6nK6L4thtE+q1bXTxbXmJTmVBFAhpvT9EYF3pHijxvYCaNevZKTjsed4+KhtriE7CrQUFCLk1IHqEi4XJgXC2eWTLO1r2+dfExzgHvkdD01V1fJwmX5futXdTHISoGom9RFIYd1kG+2JSdzIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770011824; c=relaxed/simple;
	bh=SAhkZ9GnjNdaiDyoFz4ZAhUeWCoQCsMo089bUzvmWmQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JGHEAjhdTFSQo21Ios/7CvGy+wJAsnYA5WqNjPFRR3GolFBBMKWPMTzx/f2Y1HCsbPdl/Yw0KGyFMkU1YI6fCay1QRVM65E5esdTRKjJ3z5CqZCD9Ev35v4NTrs+0eorb4t2vbXpbzd0UvVwFH6wf7di7KEytYz5bkBM4w9WSJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bdzflGGE; arc=fail smtp.client-ip=52.101.83.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vh1Vye5203jf66SIBZHigmVK2Wk8boKCo8d2S10ZxNrtls5TDdPjTUiOgBcXQJDRPwp1/AJV0UaST4qJoyIJ+w1U9hXOa+iD3wALQG7rxMFC68Olg7p5FH9AWLFOdXAylNsURCLkA9m4NMxv6NLT5ZlHscl2TwifGrayyfNNzV8EJDU04JpIVl3t8qypVL2/kQXLLlH5Y/VUUAetUDfZRFadTES5UkDjIfk3AVY4pE9MWMAEhp+li4nIsXOnB583xjL6HXla3Ifeu5GQ6+aHzNBLucE0XgMpuNU3uwt3yIjAtelzkiyfa8SrG0PssTIdXKjV69/C2nluT6+DqJkJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGu5H1xTWcBG3/zROFwMy4b0JfWFlRSDWm1nw4iOois=;
 b=Y2tFM7du8CqzWLketkV0qwzquxwP9GEASotNJ2kjlI8OzHQG+QO5BshM+SBFcwCFhOnPN8FnLR5WIl7Ek5c/vb2uICE2o5I9VAoMbCVNntkSOeghgYJU9s1+HOoCHzXg3/EKpAAd0z+0XJqCsIstHAprrkdtIdIxpdDIIW6/Mcn3n3809vng2m84U3Aeon86qHAoyAAXlDEDEmmGgWTuKWHZxDLzghMe+DOnvv5tP0ZQBpKXB9BftR9hN4EBa81gFuAOIhRtyyFpy3QRPKuTCgxDKWclGRkQ6CiJFsTsuMwJ5hGRP5pV675qoBzvBUhJXFjFs98QL3UwdUWL+WcYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGu5H1xTWcBG3/zROFwMy4b0JfWFlRSDWm1nw4iOois=;
 b=bdzflGGEB5bbiAkTisGL/Z1X0ziUMItkyeKypfN8R1I4VSX6cIls/doKuEH49H7W5gLcYAgS8D6wu7II+XKJGwN14zWN6t+KrsmbNTRlnUgtfFobccVPfYXBhFqDumyZSVzfTjwd26xeIBGnZjAcJ+0hCD4Eznqx7XsvY5f4zAmfvCMAROuVOqxHyPEbZJWloZM24evnxBBZ8mYEQm3wTRgqXYJTmstwxs+tXljXRSzhSqav1qZ7rn7+axFfkZrFWnZ9uwa0uCMG5BsD8URjDTdlqtGjLsya33M5bcJQIdIn1c2OcETJl+RiVPMa36T2GeEMxJ3VnIO+dHIuGvao4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by DB9PR04MB8378.eurprd04.prod.outlook.com (2603:10a6:10:25f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 05:56:59 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 05:56:58 +0000
Message-ID: <ed33e435-77e5-4f99-b0f5-a531fceedc70@oss.nxp.com>
Date: Mon, 2 Feb 2026 13:56:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mq: Restore VPU G2 clock to 600MHz for
 4K60fps decoding
To: Peng Fan <peng.fan@oss.nxp.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 mchehab@kernel.org, hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 benjamin.gaignard@collabora.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, sebastian.fricke@collabora.com,
 shawnguo@kernel.org, ulf.hansson@linaro.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 l.stach@pengutronix.de, Frank.li@nxp.com, peng.fan@nxp.com,
 eagle.zhou@nxp.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130084133.2159-1-ming.qian@oss.nxp.com>
 <5476502.mvXUDI8C0e@steina-w> <aYAO7fOmCYVmCDa5@shlinux89>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <aYAO7fOmCYVmCDa5@shlinux89>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|DB9PR04MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bbeeb8c-53ce-4988-5e3a-08de621fe05c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|14052099004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTRURDFKK3ZDTytpQjMzVG1oMjR1T2tnUHNYSFhzdHNIbDZ0Z3czOHE5ellE?=
 =?utf-8?B?SEJCM0c3NDFxcUZEc2s2NmVvZ3lObDU3YThrOWMwQTYvQlBhVFBTQUZHMnVY?=
 =?utf-8?B?T1Z6UWxabEkyS3hmck8xTi9CWVd2SzFabnpZZU1pZ0FBQTJ1c0VRRnJuaFR1?=
 =?utf-8?B?OW5DNVVBaW9TeTRpanFhUThvdHhQY0J1UzN6RUNvQitOeEtBc3ovbzZYZWZn?=
 =?utf-8?B?SXZYWGlRQVptWVZ5ejhwSVVmZVM2QXF6R2k2a3NJVXYwODlXVm5VM1c5WHZo?=
 =?utf-8?B?WERjbUZ1ZlBIQzFud3lZQ3h1MlFMa05MenRBUzFtWlNLaUtNZkY4aGVoc2FU?=
 =?utf-8?B?R1FGd3lmUWwzUjVzVGsrbHI0aTh4bzJMeURSTVFGbkRzcGdlRTV4UUVJRUZh?=
 =?utf-8?B?WWNDbFRzY0JyenVaeXFaTTZ6enZORGFnWU85OGFMeDdMTFB1YmVCYnkzMi9i?=
 =?utf-8?B?a204TFVqc2JxWi9BRWJtYzd6MFY2TzRKa3ovYnN0STNMUlZnUERKZ2VsSXlV?=
 =?utf-8?B?bEdaaGFMUFJvRU5XZVUxdE1qMWgveW5kMWFwNVY3SkpuQ0FFLzh1alo0Lzlw?=
 =?utf-8?B?YTgvQVRrK2QwU0hPbDY1cjR5aUN5VjMzbDRkTVlMRmlxZU9rZXMzeEw1b1pq?=
 =?utf-8?B?L1I0b08vNkg5SGtuQjFSQ3pqcnBDZ1dtRjRHVlZIYmRHbnBDR05NaXZuaC9W?=
 =?utf-8?B?akFPUy9GRWdmbitiT3R4T3hjMzFjRUhHQ01sS3VIK01Wa2szWi91WmdLUm05?=
 =?utf-8?B?NURVK2JPUU1FMHhDYlB0VWV4Tll1K0hhZHEvUXY4dDViNWptVFYrZ2kvSjVy?=
 =?utf-8?B?RkF1Y1dvWmZTQWpTVTdEUEE5eTJrZWVsQ3FkbzlRb2FiUDVCd1padENHeFNt?=
 =?utf-8?B?RFpUVDJpcmVYd0VZZFdWN1RpcmJ6UHVrQ28xbTZ1N2xEamtmT0dsblB1RXJz?=
 =?utf-8?B?ZTlnQlpvaUJJaWJzV1dKbHpaK1pPNUpyUitob1ZrRDdUUGt6WmU0cGVEZGh4?=
 =?utf-8?B?L2hPZXBjUlFHaENFd2RjZXpyWGdXV0V0YUliZnkxd2h0cjZOajhzTTdIQ3hK?=
 =?utf-8?B?OXFDK2E3UEtFUkI2cWlGS2Y3RDF2OUQraG9QYk8xUk1ibzFxVGZRZ0lIa3dh?=
 =?utf-8?B?dFNOU0pWOFZZcncwYWxoSXorcDUvZ2wxYm5YVE1WeEV2R0N3V2J2ZldSeUZU?=
 =?utf-8?B?a3NQSEZHdXZRRzkwSzBybTR4dkFHMTVkd1pmSlFqYTlndHV0SW5BZHdYVE9M?=
 =?utf-8?B?MW5LV0VwSjlxNXRIV3poRmluOHk3MDFGaFNLVVArZmZPTnFSTlNvUVRudGNL?=
 =?utf-8?B?aTVZU1BUK1Mra0pwMmlWbVBUaDkxaytsTWFvaXZkSm8vTnpCdkJ0SW5RZU16?=
 =?utf-8?B?YWZJZTJQZ2Q5TngxN3hhYWZRWmhsTDZ6TXluc1czYlFmR00rS1NIOGJaK28z?=
 =?utf-8?B?K2ZadWthTnRFakEyazIyU3dXM0pyZ0Z4ajN5UDB1c1JtK250SDZ2T2NMd1Vu?=
 =?utf-8?B?dXRmaFd4cHUzejlOL1JtWFZRaTI5TE40eUNEcVJ6WjhzNCtKUnc0YjgySE1N?=
 =?utf-8?B?TVcwQmJtT3lBOG83cndqZjFxMzRLaHBYd1lCUjJ0VFRwTDlaQnN5WURNd2RB?=
 =?utf-8?B?eCtQRi9VYXlULzc1WXNZbko4N0tCUCs0MU04TTRIVjMyUzg0RTRiOTNmMkpk?=
 =?utf-8?B?K094WFdiVDNEWWM3eDJYc0l6M2RVZThzcHdmQjB4RnpPYTNFWEc2QjJaN2lT?=
 =?utf-8?B?MnVtT3pXaFpobDRWSTNJbzlVZ3ZUcmJFcytYVXZlc0FhM0hqY2NtN0ZRcXpw?=
 =?utf-8?B?UVNQcW1ZUlZJUEZwR0pRakZ3STAvQS9SSGp6alEwdi9sOGZ0NHVYamhpRGth?=
 =?utf-8?B?bDcvTm5rMTcxd1kyWnBmTk9UZyswUnIwTEVQM1l0dkRiTmVYcndIVE5ZMTZq?=
 =?utf-8?B?TDhJZndKSkREOEdlQlZQOGp1M3o0dWM4NXU4S0ZCbHpjeUgxMzlBV0ZhbE9N?=
 =?utf-8?B?MjhUNHoyZXkwMW82Y3pZQktKZlpRZDExZGxGR0JhWHJDS1F4M0VwZmtlbUlO?=
 =?utf-8?B?WjJaSnF1Rnlub1pTR0ppdVJVMjJ0Mzc5OVkvZjNHTlhBUmUyUFdpNmNSWjE5?=
 =?utf-8?Q?LJUw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(14052099004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHV5TzYyVDdlYmZZSkFvTGxWYVNqZE5rUWdiNXlOTk1DOXE3Z09GUnUzVDJF?=
 =?utf-8?B?WGtPeU85OXVWQmpIaS9QUWU5Sm9XcEhXTllhNjFJYXN4NnVsY2RpTlZjS0E1?=
 =?utf-8?B?eHRld003VTRyejI1Q0xoVVNzU1prUXFPY3RwMXIyR2dwdW9OMDU1bThzWW41?=
 =?utf-8?B?bXJ4OXNKc3M3SEZObWc1NHBBQkZWdnhVYVQ0bWNNclpueW13d3FWUXd4TGov?=
 =?utf-8?B?bG02Z1l1dmxlNm9IRFlESWtwWXVYNGlTQU9MamhqZjQzWG81MXlLbHZIR1pH?=
 =?utf-8?B?a3V1UHFSOG8vNHd1V3Z1cFRPMko5WlIvVTRGR1c0S2RueGwyTHZ1ek1Sb2N5?=
 =?utf-8?B?KzdZVlhhV0hkclp0VWtQZFVhbGJoU2Z2Ti80Zzd5SmtWVHdDaWJ1QVpESW9u?=
 =?utf-8?B?d0xUUnlVV0FWZy9MdzQycTN1ckFRTmJhNFN5SXlyb0hBNmFvM2JSZ2RQYS9n?=
 =?utf-8?B?QzU0RkhPNWQ2WUV0aTQxYmVzQXhkVFNSaHA3dktGMUNKNE9rR21pZm0zTHpW?=
 =?utf-8?B?UDhLNkszeTI5cmg2UGtlbkx2UEtFUVdMVDJyOWNXVEJ4cW5CL0pxanRtYUJn?=
 =?utf-8?B?akErNTFsZmhubWdyUHM4VFhiVFdZcFlJRUVBNHRScTRlTk5jdlZRQnpPMGhT?=
 =?utf-8?B?alloampuOElSNzh4RHpWWlBTRkdJS0FWSE5NMS8xL2hjb3Z3SHdqS1J0Uld4?=
 =?utf-8?B?Q2ZZMjZwVStrTkF4aGlXcWxkaThucGpDVWhwdnQ3WGhCWW5MOE9Ub3Fwc1B6?=
 =?utf-8?B?VGNzc1FDaUxmOS9kUXNBc003Y1pNWG9YMXV2RktmcHdXVk9GQU9VbVpyYWVx?=
 =?utf-8?B?cnljRXpwRTl0aGxJcStDU3h6a0dNZEhUTC9tUFNreWJXUFZlamNBUnVNL2Jy?=
 =?utf-8?B?ekhYQ3NUZk1VUkU2WUgvSDRFcWpEdDNEdHpLWW01dG51UGZ0OUZpbW5OUGs4?=
 =?utf-8?B?aHpub0JzL3NEODRBWjBpcm4wZUllaFE2dm55d1JuZWRXRjF5eXFIQjZVd3lR?=
 =?utf-8?B?aXVRK3BkQzdsSU1PRTRlU3RqUHJyWG9qMGY4am1QQ3Y5QnluOXNhVm05ekpu?=
 =?utf-8?B?c2lpZmRrS21xYzEvTnh6aG8rUmpHYkg5QmFuaWNxUUsyREZ0L3VHZnQ4alZq?=
 =?utf-8?B?UzRFNEpiTURxZlZmTHBSN25OTy9zcGRmTzZXNU5ybXhGbjY2VmtDREZwUjZx?=
 =?utf-8?B?cUZLYXZJUWZ0WU5vajF6dEpQbDM4TmhFMHBTT08vQkwwaDZ5ZnhqYXV4Undo?=
 =?utf-8?B?Ukg3RUxzOTJnS2tQVHFreXFwL0F5UkNXUW9kbWM3OVlocVp3ZDNaZ3NzNDZJ?=
 =?utf-8?B?MXFlWUt2dVV5WXZUVmlVdi8xWkIvUWlrd3NTeUNLSE5IaTgwTVdFaDlaNndr?=
 =?utf-8?B?U21uNTZ3a2tTRWhFTXhmZjBiQm1sOHFIcWVkZTJKbjRjb09QajM3VWE3NEpp?=
 =?utf-8?B?VzdCTkdVTW14UDlpQjdWQ0R3VGRaSFZaRU81aU9jRjdTTzBGMUlCZVRWYzdh?=
 =?utf-8?B?VENydjdaS2xVUjRBbVFqVlN0VG1MZkFUUzloSWtxdWJrclFXNlZ5eHJlbDR6?=
 =?utf-8?B?YmMzOTNQNkNGS0ZTNGFwOFRiSlptUk5sSHZ0QWdPbHgzNGdnaDZCUkxZMit5?=
 =?utf-8?B?Yk03R1dnbDVobW5VeFl6UUdjS1IwcFptSnA0Nlo5Q05QenhndkthVjF5VHpH?=
 =?utf-8?B?dVo4YU9jQUExRFhsTjEvaGVHWTF3RXhmSXNFZnVFQmNOUUYvemlyR0ZhbkJO?=
 =?utf-8?B?V2hlS0RrUElzNU42ZVdoTjl5ZEtQTGVTZW84Nnh1S29Ld2FyNEkzcEdwQXBv?=
 =?utf-8?B?am1IRDlLMEtOMHhPeWZPYTFJMkpwbnRZS1FnZ01JVzlEd2NGSmw3ZGs4Rzkx?=
 =?utf-8?B?MnlXRm9nYStnSGxPMjVwNE40NS9ZSlk1NlQrRmp0MTRMSnQ4WC9oWTNzbHRM?=
 =?utf-8?B?UGZUREFmZldoRUJOZW9JMDh3dXBEazFWRHNRdGdwUXNqeFhWUzh1RUlCazZm?=
 =?utf-8?B?UFBXYjBkZ3JqMHM0bm0zbkRFVnUwdC9ia0Z2Qms0dEpXUWVaR2N3bnNvZzVl?=
 =?utf-8?B?S29keVJzYnJDc0x6Q2xGUXh1TVd0bTY1dTViNHlsRUhxUEdVTUVDT2QwUnkx?=
 =?utf-8?B?WkVxSEFoVGx3OUFaZDBCUmlkUmZqTGduWjlTRnZ1QWhZUkw2WEFncXVyY21a?=
 =?utf-8?B?MXdyN1lteCtVTjJwcVcwWG9lVUhVM2VwTGJzbWVvYndsWnNCTDI2dmxtMG1B?=
 =?utf-8?B?aE1zbXA1Z1A2ZjVsUGx2S1NXUHpkeHUzelJzd2dDZFJKVjFqK2V5bFB0UW50?=
 =?utf-8?B?MHdYT0xhSVFNTHRNZVdRYllmVy9vQUw1Vlc2ZS9IZSs0Wk9CY1pqdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbeeb8c-53ce-4988-5e3a-08de621fe05c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 05:56:58.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/Ac2lAVlhVPzfV/lnIucngnICD3wsxL8idgg/fDA8GJxv9ScDq87MJzWn+k2VyBNs4YyQMzaxT5/D+95pL1hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8378
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41875-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,kernel.org,xs4all.nl,ndufresne.ca,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.qian@oss.nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,0.0.0.6:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CD1BC866A
X-Rspamd-Action: no action

Hi Alexander，

On 2/2/2026 10:41 AM, Peng Fan wrote:
> On Fri, Jan 30, 2026 at 10:09:46AM +0100, Alexander Stein wrote:
>> Am Freitag, 30. Januar 2026, 09:41:31 CET schrieb ming.qian@oss.nxp.com:
>>> From: Ming Qian <ming.qian@oss.nxp.com>
>>>
>>> The VPU G2 clock was reduced from 600MHz to 300MHz in commit
>>> b27bfc5103c7 ("arm64: dts: freescale: Fix VPU G2 clock") to address
>>> pixel errors with high-resolution HEVC postprocessor output.
>>>
>>> However, testing shows the 300MHz clock rate is insufficient for
>>> 4K60fps decoding and the original pixel errors no longer occur at
>>> 600MHz with current drivers.
>>>
>>> Test results with 3840x2160@60fps HEVC stream decoded to NV12
>>> (the same scenario that exhibited pixel errors previously):
>>>
>>> 300MHz performance:
>>> - Severe frame dropping throughout playback
>>> - Only 336 frames rendered in 11:53 (0.471 fps)
>>> - Continuous "A lot of buffers are being dropped" warnings
>>> - Completely unusable for 4K video
>>>
>>> 600MHz performance:
>>> - Smooth playback with only 1 frame dropped at startup
>>> - 37981 frames rendered in 10:34 (59.857 fps)
>>> - Achieves target 60fps performance
>>> - No pixel errors or artifacts observed
>>>
>>> Restore the clock to 600MHz to enable proper 4K60fps decoding
>>> capability while maintaining stability.
>>>
>>> Test pipeline:
>>>    gst-launch-1.0 filesrc location=<4K60_HEVC.mkv> ! \
>>>      video/x-matroska ! aiurdemux ! h265parse ! \
>>>      v4l2slh265dec ! video/x-raw,format=NV12 ! \
>>>      queue ! waylandsink
>>>
>>> Fixes: b27bfc5103c7 ("arm64: dts: freescale: Fix VPU G2 clock")
>>> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
>>> ---
>>>   arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>>> index 607962f807be..731142176625 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>>> @@ -960,7 +960,7 @@ pgc_vpu: power-domain@6 {
>>>   									 <&clk IMX8MQ_SYS1_PLL_800M>,
>>>   									 <&clk IMX8MQ_VPU_PLL>;
>>>   						assigned-clock-rates = <600000000>,
>>> -								       <300000000>,
>>> +								       <600000000>,
>>
>> If I read the Datasheet correctly 600 MHz is only supported by overdrive
>> mode (also depending on the VDD_VPU).
>> Is this frequency really correct?
> 
> G1 and BUS clk were already set as Overdrive frequency.
> 
> This change is to only upgrading G2 from 300M to 600M.
> 
> So if your question is should we downgrade all to Nominal mode, I think
> no. The freq could be override in board dts, or adding a new dts
> as arch/arm64/boot/dts/freescale/imx8mp-nominal.dtsi
> 
> Regards
> Peng
> 
>>
>> Best regards,
>> Alexander
>>

Yes, you are right, 600MHz is the Overdriver frequency.
However, to achieve the 4K 60fps target, we set the VPU to run in
overdrive mode by default, just as Peng said.

Regards,
Ming

>>>   								       <800000000>,
>>>   								       <0>;
>>>   					};
>>>
>>> base-commit: c824345288d11e269ce41b36c105715bc2286050
>>> prerequisite-patch-id: 0000000000000000000000000000000000000000
>>>
>>
>>
>>
>>

