Return-Path: <linux-pm+bounces-33596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48695B3F2B7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 05:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1267D7A4915
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 03:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74372E0B5F;
	Tue,  2 Sep 2025 03:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WbPxUMQ2"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D52DFF18;
	Tue,  2 Sep 2025 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784007; cv=fail; b=chMhsVNvxNpMps34KGKYQY3my6k32xbnbRSg8LJyUatDcUR7uYAtP2Sdz1eRTu4PJsOZH3YQHp/OlvjKNIgqvNyHfZViTJ+SZRbQOoRUtOOaa7+I0673mGKpb0DaJ/rX33nvFp3aZDeovTa/001IsqKV2pioFBPnEqcCGq3a3hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784007; c=relaxed/simple;
	bh=8F7IZwXpDH5sLxod/40wvvSn6FqullUWy2O/ZKYg26g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uxKjdL8NpVzqBtmSK5mDGgELv1XjcsJ3qfEI5MV8HQ6Y2+vPtb9dNJfTablCbX19Sgnoz49HQB58yxDQ+Qt/pbmim88ewcHJwv32M+/yOE4CWqOLhIWqFgq0bHsfKbgMXbdVaVwbSp4kQ6DVWuCYpi1ntRamD8OJ8TLiY7zzlB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WbPxUMQ2; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVZJSzXexkbZSc04Q0sAYJd+NHtcTH48HrHaaT6UJ5XPtWCnHbqwrEcoSt3U13aRI93B4Of2JWnNLRUVa/fTbDpOvwtplFkm2bQbnhz32wwvqpsENFHvxPmEed6asoWhL0giSLQ2kF4vQnx72ZhpmyycQufFR1Oefzuz8DH0/IXFmdUoauxzTaORooAy0JQAzXfsN44zOpQ6wSRqufHbHq1MI15iGN0iK8cpQB2qsu/Tmi89WDFH/xXbDbm0CEyZc0Jf8GxYVOQq2UJiSNC71CeVx7158bsqXcZ9lnA3VOD7uSQS9U5tRBl3pxG8bXOgoNaS3TsG0+nmj8Ffxbi3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWP0YpljYBTFc2kbQJxT21z1anaFg57ICxbBOEkW7gg=;
 b=NL1aEQd0s6o/CN0A1k937pS73FkSOgkGXt2cjqRaeIvTYwMI5c015vxFBfQfGgKXv65+gkMnWLbr0WJEy4qfQ/rW/Z6GSc0OHavAxYP9gFjaALm/tPTGroENBlgtpc0Cc3MjUkkLEhbfirqeLyu0wDNMQGeXV9fCAyflNyGI+jY4PH5OFTwxRgxYRx7vDLG/D/tebVU1i4cfENYVNeSNzCEkmW383PGO1ZEG0qw6NcTTA+IPbPto3I9YDIv0mMXYecOi68Eh0C1zt+2TvhxoDeOd7EGpx1bRQ9keTE/5h4TiNmXNhvddTOTd1OE3cXJnCy9re7EoAkFjve7tuFQs4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWP0YpljYBTFc2kbQJxT21z1anaFg57ICxbBOEkW7gg=;
 b=WbPxUMQ2OqSC2fbuwvpKZ84INE1GqGL6PNh2OWNuRpk4EYGpgrt99nslvc6WTKIQa+mSx1jfotNaL57cAR1xtt2hA7znwwvlZzI5427Dc1SqHHx5UWb+WQ3K8W+T4ERVG+lQpVccxe5T51+b0pyt6RYLYs2StJN9ons7ra8mDSMIFQKLjOuJqkkBFEq7AUdJktrS0x21gdIj0zaAucJjKqiAyTH2Nj/Gg7IJ8CVYgVdW20RMNt335rHWIE20zTVR8bUNoiNjPc1DdBWQXhehxAbDabEGfyIQcNb6hT5d9GWpwkIOHGmMUnm5FffLMoO9zYgOQcLJtDMm1MEXphQ35A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9583.eurprd04.prod.outlook.com (2603:10a6:20b:472::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 03:33:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 03:33:24 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 02 Sep 2025 11:33:00 +0800
Subject: [PATCH v3 1/4] pmdomain: core: Introduce
 device_set/get_out_band_wakeup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-pm-v3-1-ffadbb454cdc@nxp.com>
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
In-Reply-To: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Peter Chen <peter.chen@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, Xu Yang <xu.yang_2@nxp.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756783991; l=3205;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=8F7IZwXpDH5sLxod/40wvvSn6FqullUWy2O/ZKYg26g=;
 b=zJu6avW8xuHx3FM4Jut2Bd7ESKSbFdJE48XzTcTb8gWs6vD0aIb0PARNV5tZX9QOVF8n2rUIQ
 ADNzUgcuk2SA8c/uzgYktwYkLmzHv4dPM4HUOoTQ+RXazqIpWAHRwOJ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c516717-ab25-4106-1390-08dde9d178e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWtsUXNHY3RJUmdCYVpZcWNiNm05ekpieUJoSDdPUXFwNjZ2OVJjczhkdHpj?=
 =?utf-8?B?RGg2M1RPMlhzSlAwZy8vTEs4UlhqZDFJazhsdnl0UWRYZDYxc3hSdjFYZWkw?=
 =?utf-8?B?SitRRldDQWVTeU55NzYzTmd0eko3VGF3ck4yc2RQdjJPazRCemJpZzFtQk10?=
 =?utf-8?B?RWJ0T0xXMTVXM1U4QnU2VGhoOHJRQ1VzT1pIcnV2YWRQQVI4UURlZ2tnNFI5?=
 =?utf-8?B?bFhUSVNJeXp6Rng5RjFPVUE3cTJta3BIQzV2ZWY5Vm4zR2pCanRoY1dhRWoy?=
 =?utf-8?B?OHE0TUZma0FuUG83WW8xWFV0YVZobmhwRHRSdHpsd0xwMWxEZ2R4ZEZObzYx?=
 =?utf-8?B?MXhYUDc1MzFqVEdtcHhPcEVENklBY3V4b3hPLzBsT2h6OGR1K1crMzZvWlNI?=
 =?utf-8?B?ZzZ5SjFGVDRES3AySTRPS3RnWDIvcS8xOG5NeUJodnVZZFRIWjFIQzhCRWl3?=
 =?utf-8?B?OGg5RmtTVlExZkRCSkUzdnM4SStkR3VEL1NkdTlqbUdkdmFlQ1pkWmlOclBZ?=
 =?utf-8?B?dEYwTTdJeGVGc0tqNFhVQlFyM05RMTNBbTZMWVB1R2xkSGIzMStuamg3eXJZ?=
 =?utf-8?B?MFVrQUdUa3ZzT290RkJ4ZHNXRWRKNjhQNXZlalZlMi9rbEJyTDBRWXI3Wk55?=
 =?utf-8?B?U0NDaGczS0RKUU8wNUpwMUxJQytGVHNWWHUxc0lkRFBoNC8wQ0p6U1AxVUJ2?=
 =?utf-8?B?YlJka21QcDRHdjdlNXE3NjlEMTFic2lzcGpDOVkramg3S3ZGMWo2cUdTQ0tp?=
 =?utf-8?B?L3FsTlEvVTNVV25aWjlTQWtkQnQrcWgvMUF2bXVPaEVoS3FLcGF0TjRySjNK?=
 =?utf-8?B?VEZkdFNoSmJKbTMxcnNDbk9jRW9sTE1PbGlBZEU3WkR1bWhFbEFKdHhkTDNM?=
 =?utf-8?B?dk5rT0E2andPeWZuYmFnNno4ZThFWXYvVEx0L0JvYkJWYnFnVHdPYWZUVUlz?=
 =?utf-8?B?d3djOTE0VkhXb0hzQi96QS9KOWZVVjFMY012S2dCbWlqN1k5UncxWUtkVTdB?=
 =?utf-8?B?MkRlKzZxWEFkeUYvYlgrU1JxejNwSnVjN3hVdHdHWFVCc2h2MWlPZjFWaWJo?=
 =?utf-8?B?dEw5RWRUcnZBb09HNnNDNi9rYUpMajdEZFNqS2RHN1BjSXJlYnJqWDJ4cjBx?=
 =?utf-8?B?MU1FSFJXTmp4ZzNSdXBvcGdHU3h3dzB2a1FiNXNPOGFJL1h0a0x4bHZlRUQy?=
 =?utf-8?B?dmQvaEdSVXNIQ3ovSGF3ZjljY2JhWmFNVk9RZ3k3eUthVGhZMlNYQVo5OXZ5?=
 =?utf-8?B?dE5Nc256VjN2V0wySzJxcEpGRm04Vlo1WkF5d1VqNm55SEEwNUd0RGd3eVEx?=
 =?utf-8?B?cGVnMm05Uk9TemNMZGJtQXc4dXdhN3JETWM3SHUvTWZla3ErVHg0UExSbWpE?=
 =?utf-8?B?OUxxU0E5WmVleGdoakRDVHJvRlh5TVN5MmJ0dU51emVCbmI5RHQvZWQwbS8w?=
 =?utf-8?B?THdoVk1EMU4wN3U5Y1lzUFpYbytWMUZXY0RTTHh0L0QyZGdEMHFUT01NZ0Rp?=
 =?utf-8?B?eU42T0FsR2tSYTdDV2VRbUoxbjNtam9CamdhNFFTZWJoYVdVa205amxVSVVy?=
 =?utf-8?B?RkcrSjErcnBkTWdFV0o4Niszc3FWYktYaFdJQmpJTTdCNGNFRmcwbFM2dXkr?=
 =?utf-8?B?NzhteGdEVk9EZmJDbzNFcndaSDBtc0xFRDFzdWhWWWpFaXNMM3JDcmhtWWh2?=
 =?utf-8?B?TFdEdFpIQ2k1Rlg2a0hwaGIrd0FPcnpXSzIxZzBNUlNVeE5zdkF3YzVsanIy?=
 =?utf-8?B?ajdqM1NmZk5MRUE1aHFyRExUTUJrR0lKTXFEbjdKcE82NjJDS1dxK3JaOFg0?=
 =?utf-8?B?aUZldlZhazVTUmd0UUNxY1liMFV1S29DWm1kVWUzMGIwOUozdlhIR3lHVWUr?=
 =?utf-8?B?VC96cE9XelFocWRPUEgzbXIrSzhkVzRuc0d6WXpXN2FyRzVjRDFzcnl0N3Ns?=
 =?utf-8?B?NVFTcGdhTTFWNmVNbUhLNFQ4dUYzemVKTHB3RzVlS1hIbzJZUG0rUGxCaS9R?=
 =?utf-8?Q?UMfxIUGqUuouF0x7lqkPsuJScoHi2M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjFlaGQ0QlE4NVkzTWJzQ3hiNFgyQlIxVEl2Vk1sNUh2bnVZSEw1OWRGdFA4?=
 =?utf-8?B?eDhubjVQdzNTSmpmU2tNTXZPRGhna01ZNTAzSFFINzV6V1gyR1g4NWJ2cUlh?=
 =?utf-8?B?YnNiSTJSbGxGRFlMMWd2VEt0elZ3S201b1Zmcm1QcUFnSldUdDJmSnNxYUVM?=
 =?utf-8?B?ckVZeUF0Y3JHVTZFSjJOV0lyNHhBczNEY0hPSXQwcE11WndKQmwwQmtQSnE1?=
 =?utf-8?B?d2xveGNxWmRPVlk1b0NNRitSMCtUL1dnREFXaWFLWU1zNmdIWUUvOE5WWk1R?=
 =?utf-8?B?TmpySmhmeE14Mk93bTNXYUpoOE5PamRheUtmWTFFMjViQ0FoVGpWZ2VmT0RG?=
 =?utf-8?B?UHBMWDZqQllhY2ZaM0lGUERrZmRaRkVVaVBnR2N2QUZOR1g4RzYvaXQ5Y2Zl?=
 =?utf-8?B?cUNrc2xqNlBtTkRpMkVBQnVVNDE2NHc0MmhBbi9PWG9kV2ZYd0RmVk1pLzRw?=
 =?utf-8?B?b0tFd2F6K093UUpTQk5TZXB1d1R4QXEwQ0R2V25wbzl6SWNncTRRV29lWDh4?=
 =?utf-8?B?V21Ca3ExZHdoeSt6WlppejdFazJ3cE9DZXFhRzJVaDRUVDNGbzNxbm04ODdW?=
 =?utf-8?B?citPMGdDVEVkUWo3ZlBVVTZBamJmMVRQRjJ6UDdMbkJWR2RuV1lEMzYzUzJR?=
 =?utf-8?B?SEdPTXhldUgzNkNEK1p6MDVXVWRwU3lKcmc4UE5sT2lncVVRQldic3FDSSsx?=
 =?utf-8?B?dmRyWVk4U1lqRjZEbGpwZGhFa2RQNG1UdzFDelBGQUdiVUJ4WVJLTk9uTncr?=
 =?utf-8?B?Y1J1N3F5d3gxcklNTVplWHo4bStaNG9oUTJ2bi83RFErQlNVRlNobmRtMVJM?=
 =?utf-8?B?blNWekgvM2RqV2ZFRlIrV1JqN0s3Mk94MXZpeitKdkVZR2VGc3dWVjZXWmlC?=
 =?utf-8?B?akdXdW9ZOUcrY2pIdm1XdjNQYjNQVE4ybnJIN3k4YjZwT2tXOUowZ01xRlNu?=
 =?utf-8?B?VjRVVHBQSVcwemNsWmdFVHRERk1odmJXQVppeC90anhuYlhsQkF0K3BMU243?=
 =?utf-8?B?ZDIxVWxFWVpvR2c2dktCNWlQRWUwOFc0dk5GeEVQaEsrWXBsc3Q2NHNldlpu?=
 =?utf-8?B?elgxa0trYVg3bFBQRDVBQng4b21zakU1OE1HT1B2UnkyeEd4M3dPU0p4MHB0?=
 =?utf-8?B?OXgyOHdHTWJJT05XZTlJOHVLb2hoUlhPcjJmdXRpSXc5aWorM2F0SEx5NGdy?=
 =?utf-8?B?QSsydXFwT2Zic2JvKzVRY0t2Vkdzb2U1UGwyYW1kajZUUXZ3czFndEFMNmY1?=
 =?utf-8?B?RnptOHNCd21zZmVoMVlDNU41NEtsNW9RSDZCSjFyUGR6OW5VTS90VVlReXVG?=
 =?utf-8?B?RUpwL0RScWIxS25GYm1pbGp0a05tcm0wTS8xNXdsUXI3Zk5IMEkyNTA5TmIy?=
 =?utf-8?B?bjFtZ1VXcXJxQXIzMG01T2x1d01aclU3aWRBUEhRZ1JVNTZDbVVmZ3lWTzdO?=
 =?utf-8?B?SGRUOHZteUhEY2xPbGt2dktYaW9DUmlsWmlKa1pmeVVCeFdhY3NwU0VJQjBn?=
 =?utf-8?B?N1RIbjQ0MW5ha2ZhdDRObGoxWXA4S0VBR1RQM3RKMWJLaS9rdDh6QmFQMm9H?=
 =?utf-8?B?bG9SajRvY1NaK0YzbzYzblRlbVFzR0ZpYzFVckVoekNTWDBiTXZYZ0Z1UzhQ?=
 =?utf-8?B?TnZwOEh0LzVaWEl6SzdUdVZkWDFaaXdSVTdQY2lhblJLY3VrTklWQk92UXZk?=
 =?utf-8?B?ejNlaEFPdlNKL2lDSGlSeFJnWFg5cy9rUWQ4NkhlcWpNVjJHdlBTZEhSWnNW?=
 =?utf-8?B?WEIwNjFZazl4dHVGaEZMdnhYVkpnM2NKRVFGMS9ENm1LSlRqRkRTNjRieXZ6?=
 =?utf-8?B?WVNncjIyVEJFOE5LQlNZbWdKVjBGTXk0Mko3K0hPQk1tUUoxRWJEUjRJamZX?=
 =?utf-8?B?NEFMbW1BQUhiSHJXbVdBNzlxZThaVEEyeUFVd0RObS9jditoTUI4aWxOQ2da?=
 =?utf-8?B?SnpWYTUyUkQzODNxVFlUaU14NENLRVlMUVdBZ0N3UlNhZUxMNmFRRktvS1hS?=
 =?utf-8?B?eElkZUlvOGl4NU1YMjdCMzBJbnBRdHB3VjFPWFk3UVpVa3hDMVJobEc3YUc0?=
 =?utf-8?B?Ym5pQitabXBacmhiU29jQWh6WW8zSXhvSzQ2dlkzRTFFS1BKZjB4Wm9Dd0lx?=
 =?utf-8?Q?AYAtHx6t5mTQbeZpkTBvJYlGP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c516717-ab25-4106-1390-08dde9d178e0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:33:24.3699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CD276BhVnYAP3bM2bbPfezqyhfDgeu/lMFhA4gx0uN//E82upWTlc2DtZEcKRaUxrI1EeXKzKI4IvX5Kzg+kWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9583

For some cases, a device could still wakeup the system even if its power
domain is in off state, because the device's wakeup hardware logic is
in an always-on domain.

To support this case, introduce device_set/get_out_band_wakeup() to
allow device drivers to control the behaviour in genpd for a device
that is attached to it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/core.c   |  6 ++++--
 include/linux/pm.h        |  1 +
 include/linux/pm_wakeup.h | 17 +++++++++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 0006ab3d078972cc72a6dd22a2144fb31443e3da..8e37758cea88a9ee051ad9fb13bdd3feb4f8745e 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1549,7 +1549,8 @@ static int genpd_finish_suspend(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
+	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
+	    !device_get_out_band_wakeup(dev))
 		return 0;
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
@@ -1604,7 +1605,8 @@ static int genpd_finish_resume(struct device *dev,
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
+	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
+	    !device_get_out_band_wakeup(dev))
 		return resume_noirq(dev);
 
 	genpd_lock(genpd);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index cc7b2dc28574c24ece2f651352d4d23ecaf15f31..5b28a4f2e87e2aa34acc709e146ce729acace344 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -684,6 +684,7 @@ struct dev_pm_info {
 	bool			smart_suspend:1;	/* Owned by the PM core */
 	bool			must_resume:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */
+	bool			out_band_wakeup:1;
 	bool			strict_midlayer:1;
 #else
 	bool			should_wakeup:1;
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index c838b4a30f876ef5a66972d16f461cfba9ff2814..c461c7edef6f7927d696b7d18b59a6a1147f53a3 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -94,6 +94,16 @@ static inline void device_set_wakeup_path(struct device *dev)
 	dev->power.wakeup_path = true;
 }
 
+static inline void device_set_out_band_wakeup(struct device *dev, bool capable)
+{
+	dev->power.out_band_wakeup = capable;
+}
+
+static inline bool device_get_out_band_wakeup(struct device *dev)
+{
+	return dev->power.out_band_wakeup;
+}
+
 /* drivers/base/power/wakeup.c */
 extern struct wakeup_source *wakeup_source_register(struct device *dev,
 						    const char *name);
@@ -162,6 +172,13 @@ static inline bool device_wakeup_path(struct device *dev)
 
 static inline void device_set_wakeup_path(struct device *dev) {}
 
+static inline void device_set_out_band_wakeup(struct device *dev, bool capable) {}
+
+static inline bool device_get_out_band_wakeup(struct device *dev)
+{
+	return false;
+}
+
 static inline void __pm_stay_awake(struct wakeup_source *ws) {}
 
 static inline void pm_stay_awake(struct device *dev) {}

-- 
2.37.1


