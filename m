Return-Path: <linux-pm+bounces-38426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C5EC7ECC6
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 03:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F49E4E137F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 02:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B537E258ECA;
	Mon, 24 Nov 2025 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uNTmk0Dx"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E601EF09B;
	Mon, 24 Nov 2025 02:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763949988; cv=fail; b=GWTpuUMk/CDLjt8Y2+v/5LF2q/n2/CgiaITcEM10Llkf9S4967ZDbItXjM9pwHuGsZT49L9kjxMAlMtOQIg1/k8i2WQeJl7+atwusnUtZN8T6P5jPl9rnzhQIGtavweKHgSs13kM6JhDOSu7+WnXn1Og+yey9l0RI90xxq+fT7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763949988; c=relaxed/simple;
	bh=FVJSsrJnauTtsPPdGuVqgnwK6nuirb/ibvjVLEXHZPU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eCsbVgytDI+5hv17POpUrKmvKzhHGKURwOrc84D3HQ7FQ3CvkD/FVfkZHeN1m72ksW7xUaxRn/UyE4Z0T+81trepYtMVrk3t+Jq9AN39l/sO9dC/wdSWrdjKOyte5/VCQ6TbNbHM4St0YyjGSZAUGwnXMeb9rdxlijxO2jUTHpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uNTmk0Dx; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+qG/I6g3APufm1PE03e99RfdQo/XumQNE9EKX4HpkWLAVxfYLSJzSiJAuAZhaTXC24mB7EeA00PRdYUWTQwzW0PE6Qyenf3miMCItkux3J+Ms+TcTsdbO95KqNCWX551cgKb7/1i7Y+e9byRkHSVPOxEWOqv40vivMy2NMav6uV/3HwFrt5ULT8G/rZy3zDXEm4qA9t7EtaocuDcLgLR74nr5iDD81whIZLOmbvW+6Z947gl85G3VC3tooKMMLBO1nnKxRXC3v+u/LcoVHBE131SPmGFjNudnSj71/sevAHA7ryc8PazoiTDgLlmHTlkgP0KNAdwny8cphBvpcvlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViCnwKMrJKJKwJvAg4ISqklmHdeVEqEU+ZPP32P04jg=;
 b=C+AwZYk/mdMLmzNY/1ymnlwXk66LylyqjSOO2jRLgMJexqTx2fIZ4KeDLoHfUtHkNoCkEaGgugjdYupeS4gaGALfYdvR5txpB7t2Dg1nyqIOgTv77IMvgUPw0lSS5QNL7i54N6b4lZnNuVY5ZQ05xiMfjudmkc6h1pK70NGAViyJiXl0I5dNeEpnHdS24+Bntp0ScDpAPySDHi0YyBFwzPrRB5Jc7tMeD1G0pG+vwkMDQlyXz7n1u1xzQSZOBzSwnNGoy4MSjQIWHqYOdQ6b0mxTP6BPbaeVX9Q2I2aHNnCKk34QYFYWqKNPs4lv2YowsQ/OgHTW4n8CH7ulTHqnIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViCnwKMrJKJKwJvAg4ISqklmHdeVEqEU+ZPP32P04jg=;
 b=uNTmk0Dx2i11D2OlKbCMipq1oMhlYwaa0Dw6B40zKSY9ervyrm9yzk2jeZzUfyfV+RNCOIqjdp6E2KffxE4vSE1G18k60YF9AGJ4MuuFOf6J7ZsRiau2ucxHXVXZ7lcPLQSCaiRfPQVZWNKwpQtJ+dI/Dh4v0OsB5UHa6sdQUOScZ7DF7noHQUoPXa3jF1AQ6VUoppKmwZDWBv2wf37m0PPTqgrrvqAxLUIYK4FVXeGs01F0QegRA+jEhhEg0ZHMfEm0oSqQBVDse5W8LlfRUrlG9AYgLypBxuaCKrH0JeBZN2Dguqj0oP0/tgHDHwhF7bOjel2q9djd0kcr3NoA8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by VI0PR04MB10806.eurprd04.prod.outlook.com (2603:10a6:800:262::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 02:06:22 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 02:06:22 +0000
Message-ID: <14b97759-472a-4574-ac3a-028b2b86c478@oss.nxp.com>
Date: Mon, 24 Nov 2025 10:06:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pmdomain: imx8m-blk-ctrl: Remove separate rst and clk
 mask for 8mq vpu
To: Nicolas Dufresne <nicolas@ndufresne.ca>, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
 benjamin.gaignard@collabora.com, p.zabel@pengutronix.de,
 sebastian.fricke@collabora.com, shawnguo@kernel.org, ulf.hansson@linaro.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, peng.fan@nxp.com,
 eagle.zhou@nxp.com, imx@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20251121081911.1682-1-ming.qian@oss.nxp.com>
 <11354064b251d01f8a0f8974c451c91d515be1a4.camel@ndufresne.ca>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <11354064b251d01f8a0f8974c451c91d515be1a4.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|VI0PR04MB10806:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0d7821-11fe-4c87-f23e-08de2afe10a7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkNHYjFwMHlVUWpxbGtiRFhjdnNyN1U1TWh3U2sxL2ZXSXFOVWIrUkRxTVRF?=
 =?utf-8?B?Z3l0Q2NlbTRWcnVTTmM3dEQyUkRjSlBwTVMvRDkyWjZlNU0yWEk1V1Y5cTlr?=
 =?utf-8?B?TWR2ZnBNR2ZwU3BVa0ptSUIwM0w2N21MaU5KRThqUEZqWTNCUkE4cTByWmlF?=
 =?utf-8?B?QU1KOUQ0SGVhRmthUlNEa0kvVWRDS1FIeHhMVEh6b0tPT1pMOWlSQ3Z3TnFE?=
 =?utf-8?B?TUEyZHVDVjJOWnFEMnVmNGZuM3pmalMwd2NhTm9CckIwb1IrTkM4NmZsbmZR?=
 =?utf-8?B?UE50YUlkODd2Vi9qSnNJcFpjemw5dUU2aHNBUW96TmE4ZEs3OFdZZzNnK3ZB?=
 =?utf-8?B?QVNtZDRYODNIZ1hNc0E1eWk5d2V3UnBvcDZIbkhFTUN4c01BREpwdklPQklV?=
 =?utf-8?B?ejFjbGVjbXBKYVc1MElkckVBdlpvK3lHVllKY1FHQWIrK1V6OGdoVld0YkNs?=
 =?utf-8?B?MGxncVRyc3FLN3lJKzUwODN5WHR4YmZTSUhaSVFuU1VCT3FHVGxBMVdUOXY5?=
 =?utf-8?B?clZ3TzAyd2FUUjIwNkYwOTN6YjV5dXhpNHo5RmlLRXNpWTY2WW5md0VmOVhl?=
 =?utf-8?B?Ni9jOVhBK0tsTEVncjA2blR0WGFwdHBOS2hWalc0V1pSYVFmT2M4T1RZMXBW?=
 =?utf-8?B?a3d0Y2lXdDJGdlI3c3FyQ3dJTkNZUW5GUHNlQmdXemdlcmVzRmFKY1VpNDk4?=
 =?utf-8?B?QnU5WDJ1VklVRG96azRkUlZvUGRoR1RibTRKdDJ3SFI1Q1ByTEZzTE9qeWFP?=
 =?utf-8?B?VERmRE53MDRad2I0OVVnakpENklGc1JtTVRrTTZuYTljWXNKRlpDd3h3V3FN?=
 =?utf-8?B?K3RwWE5SengrcHBDN25WZFpqUks3YjdlRHY5aVozNEFySmNzOTZxNGlCZHp5?=
 =?utf-8?B?RHU1eTV2VGxZZ2Y4OHRCdDZ3UFhFRVdaMWpsNE96UlNPQVRMUzZ6L2daYUR5?=
 =?utf-8?B?eUJ5dVpycUZjdFB2cTRCdTZ6Tmh0QkZpcU0vRmFMYklCd1Y5aVhrdGJVVkU4?=
 =?utf-8?B?cWhCcTd4RzUwV2t6RHF6cHFvSVpqZnhqeEZPUDl4ZzdFL1A1NHYwWjM3NWx6?=
 =?utf-8?B?S2xyeFhDdzBVSVhmbnpPRmw2a2FhVlZUcklVZ09QNFBxQk9heHFoN3NBamFM?=
 =?utf-8?B?em53MW0xZHg2T3NMVlpJaElSWXhPeDdSME1BMmdYWlFKc2hveGFYcUNDbVly?=
 =?utf-8?B?UmZOL2NLM3ZyL2NLRW9rWGhPNERTQ3ptc1ZRRlFkTkswR3RCV1htd2I0QTZs?=
 =?utf-8?B?QVlJOG9yV0pLWGxDOFNIYkdsaXFFZVBwS251d3laWWE5U2hUaGJUOWN6cGZy?=
 =?utf-8?B?OEE5UG94SSthelh2eXc3UTFmeTAraVNpZEp1cHRkckJWQ3lVaUlwM3A2NUND?=
 =?utf-8?B?OU1ESFpqSW01OFhDeWxQWG9OVmVhLy9ybFNSM1FyZy91QTFqSkk2UHVDaDJt?=
 =?utf-8?B?aFNkTlppNDUwbTZGZmNRcEZNZ0pMTjhXcERZYjJmQ1JTWTN2ZzBuT21JUHRk?=
 =?utf-8?B?QUtSL0I2YWVSR1pZcUxHS2FkN2xTZEZqR1RTMTd5UHZ2OGkxWWtRY2tBRGZq?=
 =?utf-8?B?NUlPUlRUc3M0Yngza0oxMW96UjJlZUZURkRXUVhTMFgrUUwycVg4UWx3RkpW?=
 =?utf-8?B?SElvNllmcGMyaVVRV3RYc01KaUptYUtrcFRGN28wRFpuYnc3aG1IS2dYdXcw?=
 =?utf-8?B?NlJwOU1DMmt3OFhQNjlkQnhxWjhTYkxGNS9wL3BESS9wUXMzc3NHdW1uNDc2?=
 =?utf-8?B?L3lJZkZTQmE0elFOcnI1Mm0vRlpjZ2Y0N2ZDN2RTZTVEd1BWSmpSNlNnWllF?=
 =?utf-8?B?RFBxQUl5ZGxIeGZSdU8wa1ZkYVlCbDZWTjJiQitkZlNjb2dpMFpnOHdMcnVi?=
 =?utf-8?B?MmVCWEJ5VDZmS0wvbi93T0VSdWJ5WVhFSnRSOStDSG4wQlcySlcwSVA3cFNJ?=
 =?utf-8?Q?aCOCbbCAeJXHkKrfWIN8e3cMQdf5w3rN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkdMbXdVNkpqUk5kNmgzVkhCQlhRYVZFSGRmV1BzNDVLVTZ2Q0ZMM2ZrSGRU?=
 =?utf-8?B?MlloL2E2QU5uY1h3K1hvY0t5bDhoRHNiVkQ0NXFZTXYwQ1d3NjVqVE00RzU4?=
 =?utf-8?B?ZkcyRmd4bVRhMjNUR3NEc1NEc1NOMm5helVWbEhNRTNQVVZCL3VwWUtKQU9J?=
 =?utf-8?B?dzY5a1Bhd3p6aUgzQkpKeVBtd2FiZmNNQ3FYRTVJamxHVTNFOHJXbDQvTlZH?=
 =?utf-8?B?Uitjd1JPRm4xU0ExdG95d0NNQ3FLR1FjRFNhaHdxNVozMEpoR0grQ0k0QkMw?=
 =?utf-8?B?bjNiMW42clM4Y1QzbmNpaWhlQnM0RW8ydWJ3K0J3OWc5dmo5QWtYN0RHbzRs?=
 =?utf-8?B?MjVvZWdjU21ZMnVCUHBvU1JjMnpWZnpSa3Q3Q09QS1ZzQTZhK0JqbUZqdGZB?=
 =?utf-8?B?SkhrSFFGNGJYMWVBbmFUNjVmbEVDVWY0Vm40ZHJyNTdvb3BGSk00NGhNZytx?=
 =?utf-8?B?bnJkS1NGRlo5dTNIc2VLQ0hiNytYVCtPdVExYmtXZXU5NnZINnFLMkg2MjQ5?=
 =?utf-8?B?KzFGZm9oSkdLZGVqRFNZczJtMzJDMDk5QmFCSGdoU0toOXpxdFl4NWJOSm9v?=
 =?utf-8?B?TldCOFRiaDNjV3MrNmdMV2dZUUVITWEwU0FDbU54a0FxdDNhaE5sR2FOUk5n?=
 =?utf-8?B?R2NvQVNOTDBpaTJRK25vOG9yRElwZ2gwTTQzQjVyZ29PZ2U4ZTJ2bG94dHlm?=
 =?utf-8?B?U3JITStBU284ZVNEVi9SVzN2OTRKeXQ2ZGVtMTJ1Y215RXVId3pHSkpQdjRy?=
 =?utf-8?B?RCtHYW9XYXVnYTFFUjU3N0I0NWRLM1lUa0VlNUw0cWozeHVhZE5VY2x5cEhD?=
 =?utf-8?B?VWptUERrRE9YVU4vd015a0x4bGRNQVhvNnk1U0JUd0RoZU9jN2o2NDNhZnR6?=
 =?utf-8?B?TUZFVTFNMGFMZ0RNeTdvajFyaDllb3FzdDhyMloyZ2N3OGozYmpVUEdobVo1?=
 =?utf-8?B?SEQ0VUFDRUppQWMwd3lKYW5heXdPejZubEc4TjJrVTdoeHV6bEg5Q0NDaXVO?=
 =?utf-8?B?ck5rRGFQemNpSXVOeG1YU1M3cmFTWWRSNXFOYnd0T2V3RzN5cEtncmMwZS93?=
 =?utf-8?B?ZWVhcmVlM0J5T0YxSitacWtLM0hPOXNTUG5NYWZpMkxpTnlsTmgrTzYwa3Z1?=
 =?utf-8?B?MDJEaHdXbCtGV0xGOEVNVVRheUt6SERZU3BRbG1mL2tYL3FCdkRpL1ZmekQr?=
 =?utf-8?B?bFVXNXp6YVdmaC8za1lDVHJRY0VmNHNoRjB2Z2VRL2F6dUxwTjNuc0h6Ri9C?=
 =?utf-8?B?UVVvN0JoTXFUcUZxeGtYWnpSR3RSckZ2Z29KKzloUkhvRU5oS1lGbVhTK3JT?=
 =?utf-8?B?OUg2UWprWWRuWU4rSHhpQVJEaHhUWGg1WisxUFNpbmtkbWQyNHF1eC9FTnEz?=
 =?utf-8?B?M0g5RWZwTC9JOWhkR0U1MExuKzRJcVJtMGdNcytRY1FBYkZQS3JOREdueHhZ?=
 =?utf-8?B?bWlMWXc4c2xtTDg4bGt6WUlLR1k1a2FaRFgxbHd4aVFSTHlra2wzdHBXeFR2?=
 =?utf-8?B?aVlvbEY3bm4xWXphZkEzQzN2d2pGZFhNSVlBTnBqRXR6RU9TOWVHMUk2NDBh?=
 =?utf-8?B?ZVRhZGNpYWtiSzFVTnUyNm9VSU9PZE9HWmdpUVpzYVFQZDZ6UVdkVXQ5RER1?=
 =?utf-8?B?blNzdVhYT2xRUkJHMUNkTDZHSWhoYWVaQURFcDNjZmorYXU4NXZlZTR4Risv?=
 =?utf-8?B?QzRNbHJwZUt6Sm5qTDA5UG8vWVU4dlhNcnFQUlhnMEhiRVNUN2xJbzY2ZHlE?=
 =?utf-8?B?WXJ4YTZzUVJUTzhrMmRWZkN6aVZJYWR4VC9oZno1OHdMZW9QU2FHejd4UDZo?=
 =?utf-8?B?bS9sNEd6NXY4YkVUQWZnSkFXcUhpSXVQakNPNEZiWUhHSitPS1c5aGJWL3Zl?=
 =?utf-8?B?TVdtcGp1WTZFdEZVZmtlZEdPcFBSYlNtMjlPV0V1TkcrdStSNTNiQnhhQ0RM?=
 =?utf-8?B?T0JpdlRON3c5N2xvaFA4bjdYaGgrdmxaRFNNSzNNMHdmQ0dlWXV0a3B3Vnh2?=
 =?utf-8?B?STdqTFM3aXo5OWhiZHkrY0FFRWRmT1dWSVJybWU2QWNWaUdFeG9IVk51a3Q2?=
 =?utf-8?B?NU56bWxqUWl6Q0RmUm1odStPMmNjVVczTzQzNXNQS1lxTW55cGk4T3ZQNVdk?=
 =?utf-8?Q?HDKHAtgg6HbExJB1u0/BNzZmk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0d7821-11fe-4c87-f23e-08de2afe10a7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 02:06:22.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5yBH9ufjfU9WObMAi/HolzNGhd90MyZ6lzQ4DKVVb23BS3Ho4D5de5/vHbr4tUCg+rwUz++JAW0Dm3TOCkdew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10806

Hi Nicolas,

On 11/22/2025 2:07 AM, Nicolas Dufresne wrote:
> Hi Ming,
> 
> thanks a lot for working on this.
> 
> Le vendredi 21 novembre 2025 à 16:19 +0800, ming.qian@oss.nxp.com a écrit :
>> From: Ming Qian <ming.qian@oss.nxp.com>
>>
>> The ADB in the VPUMIX domain has no separate reset and clock
>> enable bits, but is ungated and reset together with the VPUs.
>> So we can't reset G1 or G2 separately, it may led to the system hang.
>> Remove rst_mask and clk_mask of imx8mq_vpu_blk_ctl_domain_data.
>> Let imx8mq_vpu_power_notifier() do really vpu reset.
>>
>> Fixes: 608d7c325e85 ("soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl")
>> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
>> ---
>>   drivers/pmdomain/imx/imx8m-blk-ctrl.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> index 5c83e5599f1e..1f07ff041295 100644
>> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> @@ -852,16 +852,12 @@ static const struct imx8m_blk_ctrl_domain_data imx8mq_vpu_blk_ctl_domain_data[]
>>   		.clk_names = (const char *[]){ "g1", },
>>   		.num_clks = 1,
>>   		.gpc_name = "g1",
>> -		.rst_mask = BIT(1),
>> -		.clk_mask = BIT(1),
>>   	},
>>   	[IMX8MQ_VPUBLK_PD_G2] = {
>>   		.name = "vpublk-g2",
>>   		.clk_names = (const char *[]){ "g2", },
>>   		.num_clks = 1,
>>   		.gpc_name = "g2",
>> -		.rst_mask = BIT(0),
>> -		.clk_mask = BIT(0),
>>   	},
> 
> That was also our impression, but we could not get information about this HW.
> One question here, how do we ensure that we don't reset twice on power on ?
> 
> Nicolas

The imx8mq_vpu_power_notifier() that is the power notifier callback of
imx8mq_vpu_blk_ctl_dev_data will do the real reset of G1 and G2.
	/*
	 * The ADB in the VPUMIX domain has no separate reset and clock
	 * enable bits, but is ungated and reset together with the VPUs. The
	 * reset and clock enable inputs to the ADB is a logical OR of the
	 * VPU bits. In order to set the G2 fuse bits, the G2 clock must
	 * also be enabled.
	 */
	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(0) | BIT(1));
	regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(0) | BIT(1));

Thie notifier callback is set to bus power dev of vpu-blk-ctrl.

If we remove the reset mask from the G1/G2 blk-ctrl domain, then the VPU
is only set when the bus power domain power on.

I think the bus power domain can ensure that reset will not be executed
twice.

Regards,
Ming


> 
>>   };
>>   

