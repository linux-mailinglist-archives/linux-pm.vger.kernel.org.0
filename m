Return-Path: <linux-pm+bounces-41933-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA4dDaKggWkoIAMAu9opvQ
	(envelope-from <linux-pm+bounces-41933-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 08:15:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58519D5A15
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 08:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE9C7300C7F2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 07:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8683921C4;
	Tue,  3 Feb 2026 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nM70/h/i"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0996338F95E;
	Tue,  3 Feb 2026 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770102820; cv=fail; b=QsuLqIvFcaofxbRYXL6ktCT1mIVemkDz8QFD5kFj6+uK/MOQt6B6Sb9BDW4ItjvkzKVtxFQmbXdxIQX3KcdEdPjlbSjHCGDw4P8U2BSxH3Z8GlzPXwPzPSPKdx8vRpSAW45LcbNKVHdAxk2GWx3fd+aPatRHUJ91JKtuj2Z3uXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770102820; c=relaxed/simple;
	bh=0NknBcO+aoae1leyDvMBXWNLCHAJtwf/utzhsaesZ5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rAYT7bABiUzPxDX1XsWtmpvDEz5QwbEPAEjANvRYiK7rKrLtRm/HsiGMWGinIbJmFt1Ympf2wfoWU6jQMWCN0w4VXKZDy2KB7k+xzK+Brw0K/kpgjuEtt+5pgjnkOgeulS78b+QTZMoKKsVMUI/6PvHwWqWGtmOp5b2hk1HYBog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nM70/h/i; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtVC8FnFYbr/MIYG7fj1KH8DhIKL4N54eKBye8o8l9BhJkrF3Gvp2XUqXhwyCGRTYXPoHq6JqNIwjSV88RAzADc5oCzpsbjrLjaEl01CtJpdFnpxWqCF0dIU3Fb/bUuQMV8PAuOsjhFapfNPUP89EXPwU+uxtkz4D83+sMlOM9jNu7eKoT8JWpDPFT+/M88aGKSbB/2ttZVVbB5FBV0XmxTj6fcXqXl12UXHG1C9RV9vgmpiC2k5vL7OXAHmoUcNk2nU0RyPwrF1Z6OiNpkN6TeUKeyw4sG54OgcOT3I1fBjT1Sq5TU57azfYwsVrMzS56gvyfyoJOYT7oyknZPH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFsUK6VHwr0Hxx+ZXnbFkaszxvlcxKRg7LISXB60AFE=;
 b=oHSmAwY7/ByIdDdkl7l6hxkmPtClFbKRfRhQzKN79HRH9IXQV6lziZn82jY/RaE/D3daA1jeeUSI2TDhVJzoiXM+NzzyZIzr5426CJWOXoaSwrcHCpHRybSqsf7xH4WFUwdwr9mjL81bYh776hNKzs5OBBPwoGKkwM5ZSsXRKgKIUPFsvPfJ2TmtFSZyoFOP1AuZ40AMV2QkmWIeZvBa+OF3ZJfpvY/WMpWnatHrl8axkEsrScJgzj1LlAc/1/5fauQ+X5Z0ROkyJUeSLwNz06kI2kZnVjoFiE8Kh2rnEZPjhCj9FDbDWcR9xlfy3xMv6oU/LLmCCF+hbLSPCVC72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFsUK6VHwr0Hxx+ZXnbFkaszxvlcxKRg7LISXB60AFE=;
 b=nM70/h/iOwlIRZEdVJR0nXKb3CZhxIrGgwWsXp1UaNSVM6xKgO0Z8nqPXTnNFmsiZ8/9ubdgrMjEjaWs0f4XUsgEmBtp15mXCPP2VXmLTdIUnhMggyOsgPXwi8g3WW1iiHFSbhSJFnoItgkGO69gJy63eG9NAa+6GKp8wedkHKVTw9iD6hC4jv34RiJCcgD7i9OUGSJFghbwdi85ySrBH2swUAyToXa+hAS5ZIyMR+JndX58H4aXeXZd/3QcO5BMec8PWdfbhLKzS8tKLniWN+LxwUafrLl4EhlzisOF8ob4Po93ijo7wz/mJ+TAFu5UHirdNRaEP8Vg5XNM8KojJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by GV1PR04MB11063.eurprd04.prod.outlook.com (2603:10a6:150:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:13:34 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 07:13:34 +0000
Message-ID: <ca3a8042-1394-4925-9c61-dbfcbf4cf7d9@oss.nxp.com>
Date: Tue, 3 Feb 2026 15:13:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mq: Restore VPU G2 clock to 600MHz for
 4K60fps decoding
To: Nicolas Dufresne <nicolas@ndufresne.ca>, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
 benjamin.gaignard@collabora.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, sebastian.fricke@collabora.com,
 shawnguo@kernel.org, ulf.hansson@linaro.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 l.stach@pengutronix.de, Frank.li@nxp.com, peng.fan@nxp.com,
 eagle.zhou@nxp.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260130084133.2159-1-ming.qian@oss.nxp.com>
 <df8d5d5f28870752e77ec74f34fea7ceb6e97286.camel@ndufresne.ca>
 <0b24716b-438c-4185-8a93-3a3879147c24@oss.nxp.com>
 <169eba79e8e1f906b1a0b59e22a531dfc7e57a1f.camel@ndufresne.ca>
 <5e3431c69da07557edb20a252c4759be8c857f08.camel@ndufresne.ca>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <5e3431c69da07557edb20a252c4759be8c857f08.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|GV1PR04MB11063:EE_
X-MS-Office365-Filtering-Correlation-Id: d7143f7b-d842-4640-b567-08de62f3bd97
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTFHekJ2WnBPVmhOQVY5U2Nkd0kwWk9aZWt6eVB5dmhRT25yVFdzcXFVWDlF?=
 =?utf-8?B?aHhoWWJETDVWRVIvNTdqNUhMallSVW5OejNVSFNqNEtyZzhaS1V0alpmdXRU?=
 =?utf-8?B?cUdhZ2ZHRThNL3dFQnEyS0ZxRmNJOEkwdHlpNGZldWJjeWpDalZhUUkyNjJj?=
 =?utf-8?B?Y0lnUHFIQVNsOWk5ZStqaDFJeWxHcUZ4eGNYYlRSaHNmemZ3TkRucGdFME5z?=
 =?utf-8?B?blRXSkwwVDdVckh2bkt3ZDFraGRkZVVTUk9WNXIrL3UzYzVqVVBxd2hIYzNl?=
 =?utf-8?B?OVJxeGdsWjUzWCtSNUlFQmxrZ1JXdUhNMEJSMTBMcXpHZmlVNWUwSEFnRWxV?=
 =?utf-8?B?Sk1qa1VFcS9LQ1pXZUhseUtjaURkOUNMeEk2UzlLY3N5V2J3SG1LaVl0MDEz?=
 =?utf-8?B?RlZpWDE4ajFHZC84OWVBSURHOHRFc210Zlk0ZEpISk1EdE1jcW1Ldi91dDlk?=
 =?utf-8?B?Q0FYY2RYRWgzd1FsU0dOamRjSGNERjJRcU0yLzZZY2JNWEYxbXkvb051aVdD?=
 =?utf-8?B?Rm1pWVpra3MzQm1DK1dsNGdBK2RCeEluUjZXQUpOaGFzSnZndDBDRS8wcVRC?=
 =?utf-8?B?RXhnUFE4TFJKd3NSRUFOV1ZyOUNLUC81U2VWYW5MdU9CRjdtSEZBVzBNWmVn?=
 =?utf-8?B?ckRqMFVwZjA2UWQyd28ybWxrOGw5OGFTMWl0d1puS3ZVaFdBbXJUclpwOUF4?=
 =?utf-8?B?aWNBRFJJTkEvSXlJeHFwWFJrcUpPSFhqSXF5UFUzRjRCZTZGdEdZamNNWjJ3?=
 =?utf-8?B?QnVMUGxyZUhVNkcxdDFPU2tIcC9oRUdwekRZWmtmRW9MaHBzMGJrdGpidWlP?=
 =?utf-8?B?R2lDZWt4T3p0MzhGczU4dUdsdUZ4TEpmeTloQTFaZEtsMnU0VDNpLzd0eVE5?=
 =?utf-8?B?MUtLdXFqUWtna3ZickxibEJRUE1qbjZQNE5zdkcwK3gwa0Rmd2VYeWhhdzRM?=
 =?utf-8?B?M2xtV3FwYW9NQ09FdTNzaVRGTnB1QmJlOC81amd1cStJbEZFM1N3TVRvTk94?=
 =?utf-8?B?TmZQUEJPK2hFU3pDRzc5UGdXRVdyTCtuUFh3Y25vVGladS9keHhyTEJ2dWtF?=
 =?utf-8?B?ckh6OU96VHA2bHZPSXY2SzFFSnpvaXVvaklQQ0IxdVlsRFVtMFYvRVNRN2FV?=
 =?utf-8?B?L0lVSzE5OXZMUkFJYXE1UWVJc0lIcHVZM0JETkJBdlJBMkRIOElIZGZrVGR3?=
 =?utf-8?B?czdQOFVQamZOL1Q3c2JvM2VudkxlelFpOFppcWp0WXpvWjVqN3FRM3JkOWU2?=
 =?utf-8?B?OUhTSnhQYmtkYVN3b2k3ZnVTVjF5UmV1Vnhob2ZRazUycjZVdXRTYmptWk9Q?=
 =?utf-8?B?WTFGWnI2NmtFYXI2UzJsSU9HNEJ0UitCK0dEY0U1WGhYSFBMZkVHd20zRUx5?=
 =?utf-8?B?eHRRc1lIbUJ1VHBZREM5bm9aUFZKOThBYlRjblJHbkdRM3FGdHQ4S3Znanhy?=
 =?utf-8?B?MDIzSlhiNi9yZU5WYWsvdXgvaFF2Q2E0K2ZxeDBsQzdtVEpLblIxamFrUlhv?=
 =?utf-8?B?SzB2cU00WFRHWGdiQzdlQlcydi9adllqMjJFZ0ltKzVsYXltTXBydTUvM2F2?=
 =?utf-8?B?UWRzY05jUXlWUHFadFh2UkxwakVTaC9CbWFBSkl6VzlCR1Bvc2M4dVk2enlQ?=
 =?utf-8?B?OEhDMHdPSUNNWG9KV2RoQnlYb3dybS9Cek05RlhIeVRsN2thMG5zZmtUOVRP?=
 =?utf-8?B?djgwMkp6SzU3bytobXBYckdzV280WkhzWEd5aEVhVnBNRkNKRkxXU0piWjFE?=
 =?utf-8?B?UGYxYW01NUVUZmJVbVdVM01CWnRIS3M5eDJEVUxCRkJOV1R0Qm5OcVduZlUw?=
 =?utf-8?B?R3ZuNWpDcWd3dlp1eEt2YStWTmRWNEtVNU4zaVVuTzVGbFdhQXRQK21Xa1pJ?=
 =?utf-8?B?U0pJVTljdGRld09ZZFhMa1QwZmltNDh0R3VQQWRKeFAxTThJWnlyMkwrZnl1?=
 =?utf-8?B?MkVMYmVNQ1pWTCtJUTZwcFBtT3RycGNRNDd1eTNFakNvaFhPY0JyY3RLNGdp?=
 =?utf-8?B?em56VS9BS0d0UjJ4em00cDY0anJRMTZoZHIraWdZTDNZbkVnK0ZXbnJGb053?=
 =?utf-8?B?cU1TRFdsVXV6RGdMMVI2ZjFwaEpnTmEwRURCUFFYR3ZjWEhtVjBVSTFWOEZJ?=
 =?utf-8?Q?u2xE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qy9pM2RkSmRtdkhrRlFlNG45cCt6WldIVXdzWTNKQnVxbmlobmcwZUtGOWxr?=
 =?utf-8?B?Q0FCNU1oZGFiN21hOXpsK0VxM0xnVXFJaE1LdWI5UzlhQkpMaWhTekU3YXFO?=
 =?utf-8?B?NWpzeUlTSWtEb3huMXJCTURRMXVFNUZKM3JaS3k3N1hvNmFWdWF4MXEvdXgx?=
 =?utf-8?B?UmNRRGVkNHJsQWFPL0k3V1MrNWdJaFp3ekQxdVZweldqU1JNUXVVanF3MXFi?=
 =?utf-8?B?ek53Qm0yRC8vTkwvZWdyTjB3Q09rVjlrM3B0WGFNVEg3a216ZlMxZUVxVkxR?=
 =?utf-8?B?MEJCYWw3T05DZ092c09yaUI4dC9kM0lKS0JYUitFMHExRkxXUWgvbElIc3BU?=
 =?utf-8?B?T0Zrd0hVb1EzMzZudS9wNnRGbGhzOFVWK0RkM3RVV1dyUzQxM1NMMXRJQ2ZE?=
 =?utf-8?B?Q0hudFBKRHpzdUlobGZLZ01uK3RkM3lqMGxMbmNFak5qdDVwZnF2eDNOaGhk?=
 =?utf-8?B?a3lyT1lzcDR1Y0tmdm9FMFMxNlYzNkJuMzgxSzlsMElyNW03WDZPSkduV24r?=
 =?utf-8?B?bVcxS0o2aUVseCs1b1c5V2dhQ3pLK1UzdzVrZ00wQnA5eWl3R0lsd1h3VXU5?=
 =?utf-8?B?cENrUysvSjh6TUZ4TENQb3lpcFoyRktBK2c2KzVvWlY4NkJ0YkgxVGRvbGNt?=
 =?utf-8?B?QVFoa1NjRE43UStYY2FNOGxCWkNSSVpYTDRLUUZOb2ZVTzJNZTNyS3RqV3F3?=
 =?utf-8?B?SGtxK2xabjd3SnZzY0kwZjdnTE1LNUJaODNDS0x2Tkt2ZzlrYzVNNHpHYkF0?=
 =?utf-8?B?ZmRxaVZLcEwvV2lVS3d3M0ZJbDVrTnNWZUZ1YkwzcW1lbEY2bWJreHhjeDRS?=
 =?utf-8?B?Q2ZQdUZRMHVZOStjUDBFU01tT3J3cVo0cXlSeVUzNGRBdXZpWXBiQWRPTU4z?=
 =?utf-8?B?UFJjUFRTaWI5eDNnaXYvUVFsTG15UERDR0g0Zkc5Q2w4MGlDMFg2dGVRejB3?=
 =?utf-8?B?Mml5QXh0aVhIdDdEUk9xNHJkb3dIQ1FSQnM1aGo4bG43TWErNjBWcnh4Z0J4?=
 =?utf-8?B?WU9wQlFkM1VZNTNLZWNjTGprUVArZHJnUEJKZDJjWVRmeFM1TmNQdGhZdklx?=
 =?utf-8?B?RUNXQ2pXNEdLTDNoTEMxbjVvUndOejlTQ3N6Wm50K2dHZVk5Z3NNaFVUbG45?=
 =?utf-8?B?YThWOG9lenZvYmVMUU81MVljdlNrei9mOGdma1FBWk82bjRUcmtKcW1QckFC?=
 =?utf-8?B?QWNoWnhqL3ZnQmozaGNZQjZCdVN6TFFuS1NGNjA3T3orSHduZlZZZWs0cFF2?=
 =?utf-8?B?SUwxbUQ0VHU1UHd5WEI0LzBtQ2RPT3l3OWlRd2l1SXhWZWxVczg1R3ZVU3Bq?=
 =?utf-8?B?TzBBeVZRTUFOUmUwQjM2aDdyWGtMM3hwRkNrUFFzc2xhUHg4SkxBNzJFNFND?=
 =?utf-8?B?S3F3TTdJWHlqSUkxQWJnNHlJYXJpclcycjJ3ODdxVW9ubHIyazBmUXRWUHdq?=
 =?utf-8?B?cDNNQkhMT3haV2FqTjRCMDByakM1ZGZiOFdHNGNCdEdNNTdIbmcvME9jMDND?=
 =?utf-8?B?dzJxYVN2RnRyY1VjVDhkc0lqdUlISkV0MVJLOHJEdkJEekJlRlpJZjVXczRJ?=
 =?utf-8?B?MU9oY0FHekJwOVpqRDVycnNPQTIxdHg3U3BmYk10VmloWUFGaG1aRyswR2xt?=
 =?utf-8?B?WTI1SmFVSzg2NmlyVE5LU2k1M2VPdEpjbUs0RkkzNnRjdk9qN2JKdDh1TTZS?=
 =?utf-8?B?Y1YyWE95YjRDdDdNb2JWeFhqcnpxOTJibnl5VkF0RDBMbHdPYVlyQzMwK3JG?=
 =?utf-8?B?TlZlc3BaTWxjU0lhUktVZEYrcWdpaHZwY2hLZlp0VXZqTnZzV1hadVpFQlRy?=
 =?utf-8?B?NHRwYk1ObGZ1SEZvNGFIUnFvMzRoaW1sV0Njd2F5MTdLUVU3Y2tFK2xhZzQ5?=
 =?utf-8?B?ZVFyS0ltL1h2cmt1YjN2d2l6Um1rSnIxUmNRYXVJUzNYMGJRMUdSbkFHM0Rm?=
 =?utf-8?B?ZWp4blpRTFg2S1g1YkJxbGU1NHBUZGsvOTN5VUY2d3JtWHFjOEVPSzFmQXFB?=
 =?utf-8?B?ckRGNWZrMC9xdE9sUnQ4L25xRWlEeVV3M1ZlMVNzamxnUkh3WnpFTnd0OVph?=
 =?utf-8?B?SHJqd3g5K2czMlVIaFpJNmpMVHh0S2gwem1rSlkrdzYvWkd2M2FkamUrYTBZ?=
 =?utf-8?B?TzhKNFFHWndSMkt2UENWTEc1a3cySk4zVG1iT1V5eXI2WXpua21FNElmQ0JO?=
 =?utf-8?B?MzAyZ0tDYTllWGFxbmZZblliUldzbERXbWN1cnJnZ01kenZoQTNVRzlDbFEr?=
 =?utf-8?B?b2xPMy8rQzlrNy9UMDBXdkg5T0RTclRHdGVaa0JGVmp0WUJkZnZTRkFMSHhB?=
 =?utf-8?B?LzRnZWM3a3haSStjbHlzcHdkZ1lhaFp0MHNNYThjUkIxRGE4OVdtQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7143f7b-d842-4640-b567-08de62f3bd97
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:13:33.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bp2h54hd/g14/vy8e1VW89IEVq2PmxSFNlVyD6hlqMW/pDKzq1zlHGPg9cLZ3j3HcOXAuVPRvCdGPAdZI47w7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11063
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41933-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[kernel.org,xs4all.nl,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.qian@oss.nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 58519D5A15
X-Rspamd-Action: no action

Hi Nicolas,

On 2/3/2026 3:12 AM, Nicolas Dufresne wrote:
> Hi,
> 
> Le lundi 02 février 2026 à 13:44 -0500, Nicolas Dufresne a écrit :
>>> This doesn't sound like just a VPU issue; it's related to the display or
>>> DDR.
>>> If not displayed, do the fluster test cases yield different results at
>>> 600MHz and 300MHz?
>>
>> Didn't you run these tests before sending ? I can try again, but in my
>> internal
>> notes, I wrote:
>>
>>    > Tested that, and everything becomes unstable
>>
>> That was before I figure-out the IRQ handler didn't handle exception bits that
>> didn't stop the decoder (or dry IRQ, which strangely is common from the G2).
> 
> Ran some fluster tests now. With this patch the results is not consistent
> anymore. Then I ran it with weston being started, and in the middle of the test
> the display turned black. Matches my past observation. We did reproduce this on
> BSP kernel too. When the display goes black, the recent hantro drivers reports:
> 
> [  827.581586] hantro-vpu 38310000.video-codec: frame decode timed out.
> [  827.720201] hantro-vpu 38310000.video-codec: not all macroblocks were
> decoded.
> 
> 
> I have local patches to reduce the cascade of errors, so it likely survived
> longer then last time. I will send these patches soon. The "not all macroblocks
> were decoded." is triggered by a bit in the status register that is not
> documented in NXP TRM. I found that bit in some VC8000D documentation (the
> sucessor of G2). I concluded it was the same meaning after looking at the failed
> buffer visually, it is indeed missing couple of macroblocks near th end. Each
> time we see this error, the DCSS gives up and turn either black, or sometimes
> other color. The second case has been tracked to a DCSS Scaler underrun, the
> first we don't know.
> 
> Fluster command ran (two threads, never completes):
> 
> ./fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -ts JCT-VC-HEVC_V1 -j2 -t90
> 
> Nicolas

My test results for fluster differ from yours.
On my end, the results for JCT-VC-HEVC_V1 are consistent at both 300MHz 
and 600MHz.
And results remained unchanged after multiple tests.

I'm not sure what caused the differences between us.

Below are my test results:

600Mhz, 0.9v
	cat /sys/kernel/debug/regulator/regulator_summary  |grep SW1C
	 SW1C                             0    1      0 unknown   900mV     0mA 
   825mV  1100mV
	cat /sys/kernel/debug/clk/vpu_g2/clk_rate
	600000000

	./fluster.py run -ts JCT-VC-HEVC_V1 -d GStreamer-H.265-V4L2SL-Gst1.0 
-j2 -t 90
	****************************************************************************************************
	Running test suite JCT-VC-HEVC_V1 with decoder 
GStreamer-H.265-V4L2SL-Gst1.0
	Using 2 parallel job(s)
	****************************************************************************************************

	Ran 139/147 tests successfully               in 505.434 secs
	Ran 139/147 tests successfully               in 505.350 secs
	Ran 139/147 tests successfully               in 507.540 secs

600Mhz, 1.0v
	cat /sys/kernel/debug/regulator/regulator_summary  |grep SW1C
	 SW1C                             0    1      0 unknown  1000mV     0mA 
   825mV  1100mV
	cat /sys/kernel/debug/clk/vpu_g2/clk_rate
	600000000

	./fluster.py run -ts JCT-VC-HEVC_V1 -d GStreamer-H.265-V4L2SL-Gst1.0 
-j2 -t 90
	Ran 139/147 tests successfully               in 506.901 secs

300Mhz, 0.9v
	cat /sys/kernel/debug/regulator/regulator_summary  |grep SW1C
	 SW1C                             0    1      0 unknown   900mV     0mA 
   825mV  1100mV
	cat /sys/kernel/debug/clk/vpu_g2/clk_rate
	300000000

	./fluster.py run -ts JCT-VC-HEVC_V1 -d GStreamer-H.265-V4L2SL-Gst1.0 
-j2 -t 90
	Ran 139/147 tests successfully               in 506.063 secs

Downstream v4l2 driver
	cat /sys/kernel/debug/regulator/regulator_summary  |grep SW1C
	 SW1C                             0    2      0 unknown  1000mV     0mA 
   825mV  1100mV
	cat /sys/kernel/debug/clk/vpu_g2/clk_rate
	600000000

	./fluster.py run -ts JCT-VC-HEVC_V1 -d GStreamer-H.265-V4L2-Gst1.0 -j2 
-t 90
	Ran 136/147 tests successfully               in 460.435 secs

Regards,
Ming

