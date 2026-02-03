Return-Path: <linux-pm+bounces-41947-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QECqAvvAgWm7JAMAu9opvQ
	(envelope-from <linux-pm+bounces-41947-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 10:33:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71626D6CF5
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 10:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5045D304EA72
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 09:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4565A30F92E;
	Tue,  3 Feb 2026 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aRS/lCZo"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010017.outbound.protection.outlook.com [52.101.84.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44E212548;
	Tue,  3 Feb 2026 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111221; cv=fail; b=qM0Z3BkxyHDIwyT1uJYzu9N+rd283TL+bcW6QFkPSJkVdZ61Z+dMTO28BIKcYCOSMSRqdyCDDkVVG8U4HzfkhiuDuUxfQ64JyVnUti4EUXFdc2GZP5aGx6AgZAePe2bKVgZ2SwPqH8mGfSUkqpzSG236t+ZibR6VsilLPmAepoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111221; c=relaxed/simple;
	bh=Yk6xHtnaSOtmVOZKxd0l4obIiRVPCuNHpn6GiKnowf8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Eh1mLQT+aJhdu07E3JKapDQMGbp3pLJgCZSuZMrAmGY1sUcy8gl/nyM8/TvU+aO5z+7kwx2GqQRUfL+cRSgsvrUHU5zWQoY8Nlb30U8bGhVUpbc2Jpr9iwaSLb2ax4QMnRZrH0wT9H6pmwRLAjJH/MQcBRUfdRyRUCIuNBe3DCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aRS/lCZo; arc=fail smtp.client-ip=52.101.84.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHpVi9yXAauigsGx9CqRUC70uA2Y+Q6Bx3BIX+/XvJRZuz8wNZ1gzEibTiTIJMi28UEsc4tvpLoFa1meSBrut0jJ/Y2wCoQZ+P5Dvkpg9mPbJD8F/unuyR4gP6scK6FcWM66ESwSJIqwoHL5f32ueNCnXiB9PodQbCTY30sV/YjdXKlCzsC/hzA9z7W002H7jP+sAMC4pHAZG/UdlWMsDvjp/AG8Z6e7mksib4um+wVjhCL7FDrTog5YKsvdff5ktSp0YphBNxPrEowm+FSmMqXdTouDBGCzDs1JplEH9KseTR/KihKZxBmWIpvTYo88rXzpuw/MU3yzXIq0Ljn/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHXTDepcNvb/UKG8YIUdLguzAPMbdpe/48tNOU2zslI=;
 b=DhGQNBiTh2Mjzgo/TKFZz00iE7iAlwIol/iVociIWQEnf8kdoCuG9JmaGf/3uM/SWk4d50VNhrNL74xk1VgMZ5GUVOtTduleM1b7xRM3lFG4MOHhM7N+i+NMoHfynjp5kEMD/N+1JPNX5CQZ5A2eZtRUVkNRXDbXaMahDH3OfHhjsUI5oEt/xIsRAcX2qYf0pirOuIZVkq5fDBcCtipa66cwBqn1omoQKybQosa3davHOKUP/sbxtI1TDaU1lO6rj2h7EE3PwmxWI2GSJCBymJUqvQTvJd9PfETfeNCjNl8PNB10sNHbwpjKqKZijrLDj/2z0TNr/H4snVq0Ew2oHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHXTDepcNvb/UKG8YIUdLguzAPMbdpe/48tNOU2zslI=;
 b=aRS/lCZoG5z1dewQpnIkfnmRViVJAyZpdOek0WuyPPOWfktyPEyCMKdy5LkGcsCFo2GJ3amE5ZpWOFloULofaVpzfEnM/ZO9ufC8VZPYVJuwJWpEM5Yabw1mu7TkMHosma/As0FprkJCduLnuAQt1DRqPUzFDwNdAewjmi2798gLLzxpBEpmpzfQrHZXeZWYnPnIX8wO0FO+EHeziogAl6amDC+3RwoCYmnamEXw5rmvrDB8+14jSx0SRsdjO2v2eiKbo5WE6xXoRMS6n4WCGcyMxrBvuFi2fQ25dY3HzE5qdzDf4hYPF/y/5K6fAVZhSEnag/RyNg2Chg8qJ5WbdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by VI0PR04MB12187.eurprd04.prod.outlook.com (2603:10a6:800:335::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 09:33:35 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 09:33:35 +0000
Message-ID: <ac798f2a-b47e-4d8b-b09e-7377951f6df7@oss.nxp.com>
Date: Tue, 3 Feb 2026 17:33:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mq: Restore VPU G2 clock to 600MHz for
 4K60fps decoding
To: Lucas Stach <l.stach@pengutronix.de>,
 Nicolas Dufresne <nicolas@ndufresne.ca>, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
 benjamin.gaignard@collabora.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, sebastian.fricke@collabora.com,
 shawnguo@kernel.org, ulf.hansson@linaro.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 Frank.li@nxp.com, peng.fan@nxp.com, eagle.zhou@nxp.com,
 devicetree@vger.kernel.org, imx@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260130084133.2159-1-ming.qian@oss.nxp.com>
 <df8d5d5f28870752e77ec74f34fea7ceb6e97286.camel@ndufresne.ca>
 <0b24716b-438c-4185-8a93-3a3879147c24@oss.nxp.com>
 <169eba79e8e1f906b1a0b59e22a531dfc7e57a1f.camel@ndufresne.ca>
 <5e3431c69da07557edb20a252c4759be8c857f08.camel@ndufresne.ca>
 <ca3a8042-1394-4925-9c61-dbfcbf4cf7d9@oss.nxp.com>
 <20602b86caa7166a5ac8eb75d38be07c7d7bb264.camel@pengutronix.de>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <20602b86caa7166a5ac8eb75d38be07c7d7bb264.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|VI0PR04MB12187:EE_
X-MS-Office365-Filtering-Correlation-Id: bd07324d-faa7-434f-84ff-08de63074d48
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTd3eGVYTGQwQUVra3VDdUp2Y2lIbUFJR1JiU1RXbytEcjIwOFNySEl0ckxZ?=
 =?utf-8?B?ZEptOEtOazNWdXJ2OGFBRm9rUWVocjVqU1RiRTYvQjdMZHJ5NW9BSFhhTGg5?=
 =?utf-8?B?a0Z4ajFVQ2trMGtvOWpWWWYwL2xkd0xiRVdpbnA3K0JDQXk1d1JQd25NNElY?=
 =?utf-8?B?YjZia0ZEREpHckJHR1VoUUdhL2ZVclhjaUExekV4MWpjRzJpQzJaVm10b2ha?=
 =?utf-8?B?d0Q0Vk5BSk9QUzMvUkRPSFRFNTdISnhHdWZZWEd2VXNUSFcxdjNmZDdMci9j?=
 =?utf-8?B?UjhHUW8yc0JpcEFSYmU1MXJWcGo2d0NpVTZOZHdjZGhzLzU1ZlhGaWlBdFNa?=
 =?utf-8?B?Y0NBelFTcUpXaWNZNE5uRlR6SUFHNXYyaFFvTDBPOU52S1JzZnhYMW12WnFn?=
 =?utf-8?B?dm00VFNCYTFqbjBmQU05cXRrcE56a1lRZnc5R0hMRWJoUWkvQzE0c3djSVhI?=
 =?utf-8?B?N1JoT3hCY0NCVzcxSHkyRmhZQWVLMXllNEF3ZkNWUXAxKzBPWEluUERPUzdK?=
 =?utf-8?B?b00rS0VBUzlCbU9mNXRKM2xaRTdOS2FtakRSbUhBS3JHN3UwS0NCd01UdjA3?=
 =?utf-8?B?cDRrV1dXVjhONkloSG1tUXg1S2dic3lja2QrZHRNOVZqVlRMWUQyQnZrMUEx?=
 =?utf-8?B?VmFYeElDM21VcTdRQS9MT0xZS3Z5QVFGZUhpY0dwcWlOU2ZWaDkxMWsyWlBo?=
 =?utf-8?B?czRacHNnTXg0dkdUYXZKOVgrd01ZRmxGbG1rNWdNRFVuRlhXZUFROWNTZS9j?=
 =?utf-8?B?bHk2WlErODczays4QWM4SmpkRXpWZUhjaWhwTTkwUVhxYU5Ya3BGNERlWjJn?=
 =?utf-8?B?V2lDZ1RSNjlYTTZIOW1JeFVvUXhsUXJWY2hrcE16NkU5SzB3c1hxdnlhMC9y?=
 =?utf-8?B?cXlPbVJpdHNFY0ZrMnZqc1hFOVJBU0ltR1dJb1hEckFrSkZxK2s1U0MyeWRk?=
 =?utf-8?B?cXIvTGhYdkpZWm1Zai8rU3VvVkpQL0o4QlErcWhVMFRxbnRBbGRESExGWkkv?=
 =?utf-8?B?eUY1dEptMDZxUTNUUExCRC9WL2JpaDlaWVNmWVFidXZuaGhEUnR2SURrOVFL?=
 =?utf-8?B?cFdBTGVSM2JoaU1rMW5OU0JOMk9sVStoQmVRaVlOY1IrSmNNUWZzUTVaVnZG?=
 =?utf-8?B?Q0RnSjk2MFVQV3VFOHBFMEVFUW9RbmtINXZHTXFnLzUycFlYeG81bDMyT2xG?=
 =?utf-8?B?Uk9KL2UvdlF3cVBKSHAvd0loNHFYOVozZWUwQjN6WVQrTlRkTXNnc3JKUG9j?=
 =?utf-8?B?cEVzcjVZQTh4VDVoU1FTQzJYZFYyZU5RaHNBZFJuZXppVHhCT2k0SlMzL3Ur?=
 =?utf-8?B?dGRRc0Y2OGRvM2ZGcnpBUVRYTExVZ1B1cnlHSkpCRUtWUFk4STlKRWlUTEdt?=
 =?utf-8?B?NkhKc1RUdUpjYTMyMG1rV0dkNjR0TzdyNXFyVE9LdmdSb05WNGo5RjR6Y1ky?=
 =?utf-8?B?MnJkZ2lTQTRDNUU2dENzak9xWk1VblE0NUp2dC9tcTRqVy9ianVzUnFjVTNT?=
 =?utf-8?B?c2xLU3Z0S3hDK0c4U2pROGlTNVVEcCtrOXczblNTY0k5TjRQSDJJdkFCbEFJ?=
 =?utf-8?B?cDc0R1FZSitNZmtYdERGQ0VUSTVPZ01YVE9OY2d0aHBFczV6QlJpbXYrL0s5?=
 =?utf-8?B?Rmw0cDZWSUJtUTA2d3Z4QXRVeUxOZExrUUM3V1VtQVpTSkNaQnlmNUhiSWdz?=
 =?utf-8?B?Yis1L3ZpLzUyYnZCSlM0Mm4zR3p2ek1nWUl5WHJONEhVODlyd1djU2hHWkR4?=
 =?utf-8?B?MTdGZU9mS29ZdGQybDZ0MkJmVjF0WDBpM2Y3TTh0ZzhlUUJTQWluSDRWV0d4?=
 =?utf-8?B?Q0hEWTlFOFM1Mys4MHhYK3Z1RFowZERjK0FvYklKand2T3JuR2ViS0U3S2Zq?=
 =?utf-8?B?MVRSdEJhLzYzS09aVjg5RUtkbnM2amRMVkNKK2MwZnRyWXpyY2pqaXNDT0ZT?=
 =?utf-8?B?RXYwWCt4eUt0YktBblo3eUQrZGlYRmZnRHhBL0ZGeVRBNEx1RTU1NjhpZEJG?=
 =?utf-8?B?Y3kxQUtoeStpTnZ1N1hlN2tlbjY0aUFiR3cyaFZkLzV2bzgzVnB6TW9RTTRp?=
 =?utf-8?B?bHE4M1BuOGQrcHEvN0hyNFYyRTFKTGkxeGk0UWF4RmNoY1FsdVpHTTdueFBP?=
 =?utf-8?Q?Y5Y8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzEwWXpEaTN3M1g5MHdXQXlYVm9nVm90NDFSR0JraW42SHdFNkdiVk92UlRz?=
 =?utf-8?B?SjRaMjJwYTF1MllZU3dodzV1UmF6WGNqRU9SWmRCMEo0TUtjUGRuWDcwcEhU?=
 =?utf-8?B?cllaWjdlQkpYV2MxRHRXdG1yMndEOUVkVFhNU2lndDMvVzZ1L3JhZlZ4djhm?=
 =?utf-8?B?QVJidWZvbFp3VExtaTZ6TVl1czZZOU5vOEt4NE1kWjFTRzZKd2gyQno2Z1Vv?=
 =?utf-8?B?UnZjVDhNWUlUcjdYNXptUXArckhsd0FZRitLRzQxbU9zclNqWTNCWjFZRXd5?=
 =?utf-8?B?V0dmUllOaVJweUtDeTdPbUxmbFZub3BKTUhtV05Ia2NlcURMLzBDcTZPYURI?=
 =?utf-8?B?VXRwbEJqTEFvd1laUDZGNUZuWk1SUnlzemJ0alJaTGJtVy9ZZFhiUjhjYUxC?=
 =?utf-8?B?T0xBdWprcm1xSXBQdlJDZnovYzAzMW1iYmlUMER4K29CWkUybzlMRGFHajY1?=
 =?utf-8?B?WWIwZnVHc0VSS2ltTmx2RW1hSjZpWWNSUjhiNHhqb3E1WXVmWWxMZVY3V0lt?=
 =?utf-8?B?RmdaRjJIZjFtQVR6MnhLWk5FTHBMNHllOUxUNG96S0RKVnVyZkJSWHpqSDVG?=
 =?utf-8?B?c0RIblpEMG9NN0xKaFlRMUlRQkt6Tk5rQnNPRHFmdjYxb3NNQURPNmx2ZW1r?=
 =?utf-8?B?TGdnc2ZidUtjRDJaSWxTVGx6UUdveE9rUDRhNDhYd1R0UVhCR2NaRFZ6Mzdh?=
 =?utf-8?B?enNoSzI0WmE0aFMwWlBVdHZkS1ppSFJuU0pPVE1CVUxIak1udUxNeXRJYkVB?=
 =?utf-8?B?ZjBoYllEN2RUMnZqVlQvZmtZcnl6VXcwNzNaZTBacGI0VUxvcWVyUVpCd2dR?=
 =?utf-8?B?VnlPVFM3eGpDVVpUNlE2MDJRUEN1cXNxcUl3SW16WXFMaHFQUWFHWE9VOXkw?=
 =?utf-8?B?ZDNmZ01qbGh0bzhhL0Z4VldhL2xPNWErTDVkMUY4Umw3Z1Z2U2ljWE9WUEli?=
 =?utf-8?B?eHBqWmtNbDlKamVKcWZhNWM4REFTL0QrQ1R0OFVnS2QxNVBPOFByRml3Z1Bv?=
 =?utf-8?B?QzVCRkVQa0ZETlN5L0ttbzRJTVd5eEVPZjE2TG9YdWoyOWFBVW1nOHJQUWlm?=
 =?utf-8?B?bERDWDlkZGtXRzJzQmZodTRZOGZVYVZ5TGZJenF2ZFRDQ00wWXlTVXJzd2N0?=
 =?utf-8?B?RkVDRFl6MmdoZUZYV0RSNVlTc1pOUHBDZHhtcVRCeGdhQjRxSE56U0tta1ls?=
 =?utf-8?B?dHNJZEhRUk9EbmhvaUhIMEllTG9wTHJvTVNNSENnVllUOEUzT043MzJQZHdo?=
 =?utf-8?B?ZW94TDE3My9raW85NVpsTW1sNE03bi94ODFsQVQ4eHdyNXk3UEJ6aTZpdkhm?=
 =?utf-8?B?QkZjSjJSUlZGNWRSVEpjWTJMVXYyUTN4ekxhTU5CaXhveDZZTmdMcXVzNjIy?=
 =?utf-8?B?dEYwZlpJbTlKRUtMaWF1b2ZrMFk3QitVMTI4ZGkvbmxQVVVOK255cm4yQjRl?=
 =?utf-8?B?ejJMMW9qeXY0ZHNNTXovMWFQRldibnJ1RGVGWnB2OHNxcmp5VStZTHF1eTlT?=
 =?utf-8?B?Ujl6WDd6Mmt5dlI3VEhqQ2RkZW1xMGNQV05mYWxWQmM0L0NaKzR0aVdqQjNu?=
 =?utf-8?B?T3RZaGxWM1JseEhUOXJqRk1mSm0xQnFvK2dSS2s4TklOV0p3UUJwR2hJdXVV?=
 =?utf-8?B?c3FmbzBRcEd0Skp4MzI0TU02UmxxMkRGcE50b3dpM0FpeDZoVUJDVzZqa2RJ?=
 =?utf-8?B?V3pMTkFidEYzRGZoNHkwVDJSWnFudzlMOTdkUXp6V1lrVFZJcGlpUjZndkJw?=
 =?utf-8?B?S0R0ZTUvemJCb2JOVnNtNVp0VSsxQUViSkZIaDQzcUxSblVzK2lGbE1mV3B1?=
 =?utf-8?B?OVRCTUdaWnFjQ1Q2U2k4dHRVQWpJd0RBclVtV21mVHBSWDdjZWZOSlB5eGtM?=
 =?utf-8?B?Q0RIZTlEM0RTd2E4U3dLSzJmT2VEUnRTbUR6Tng3TWlySVJLMkpSd1JpVmhs?=
 =?utf-8?B?VmZUdEFEUFpla1Z3MXhuQkhuSndWWjVVSW50cFJ6S3VyZ1hSMFk5NEdtUEs0?=
 =?utf-8?B?ZmgxSWh4MTRVYkFaS1pHNDZ2UTArNlVQLzZHY2FCUHI3eGczS05iYWM4TmVN?=
 =?utf-8?B?M1N6N3dTUDZIV3VUSXV0amZ2b01yVE14TlgyQUVQVGZqQ3p3WURud3VFbXdC?=
 =?utf-8?B?UFZCTStwOWZDc0ZMdWlYN0UzNVFrKzd4SndNY1l3bitKU0kzZmtmUHFBTDNB?=
 =?utf-8?B?SW4wa3FmMTRvS3dPamt4RDFOS1BaY1BsZm9ZeDdLRS9pYi9mekk5YzlUekky?=
 =?utf-8?B?K2xDRUJXcjZzaFQyZ0wrTTlIZmJIcEJ1RC9kcllXSm5xbDBqWVE3R081WVhy?=
 =?utf-8?B?SnRrUEVpMkZwd0xLQzJvZDRFbWdDYkxodUdCU3VHcDMwMFhXeEt1UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd07324d-faa7-434f-84ff-08de63074d48
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 09:33:35.0371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kne8F5CTSEhzuQyf5FbiNqYoYBS1YSu3MNkodEIml+i45bT5t8IVeVr/HpkBD3biPkLHYNocalggFqS037GvbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12187
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
	TAGGED_FROM(0.00)[bounces-41947-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 71626D6CF5
X-Rspamd-Action: no action

Hi Lucas,

On 2/3/2026 5:04 PM, Lucas Stach wrote:
> Hi,
> 
> Am Dienstag, dem 03.02.2026 um 15:13 +0800 schrieb Ming Qian(OSS):
>> Hi Nicolas,
>>
>> On 2/3/2026 3:12 AM, Nicolas Dufresne wrote:
>>> Hi,
>>>
>>> Le lundi 02 février 2026 à 13:44 -0500, Nicolas Dufresne a écrit :
>>>>> This doesn't sound like just a VPU issue; it's related to the display or
>>>>> DDR.
>>>>> If not displayed, do the fluster test cases yield different results at
>>>>> 600MHz and 300MHz?
>>>>
>>>> Didn't you run these tests before sending ? I can try again, but in my
>>>> internal
>>>> notes, I wrote:
>>>>
>>>>     > Tested that, and everything becomes unstable
>>>>
>>>> That was before I figure-out the IRQ handler didn't handle exception bits that
>>>> didn't stop the decoder (or dry IRQ, which strangely is common from the G2).
>>>
>>> Ran some fluster tests now. With this patch the results is not consistent
>>> anymore. Then I ran it with weston being started, and in the middle of the test
>>> the display turned black. Matches my past observation. We did reproduce this on
>>> BSP kernel too. When the display goes black, the recent hantro drivers reports:
>>>
>>> [  827.581586] hantro-vpu 38310000.video-codec: frame decode timed out.
>>> [  827.720201] hantro-vpu 38310000.video-codec: not all macroblocks were
>>> decoded.
>>>
>>>
>>> I have local patches to reduce the cascade of errors, so it likely survived
>>> longer then last time. I will send these patches soon. The "not all macroblocks
>>> were decoded." is triggered by a bit in the status register that is not
>>> documented in NXP TRM. I found that bit in some VC8000D documentation (the
>>> sucessor of G2). I concluded it was the same meaning after looking at the failed
>>> buffer visually, it is indeed missing couple of macroblocks near th end. Each
>>> time we see this error, the DCSS gives up and turn either black, or sometimes
>>> other color. The second case has been tracked to a DCSS Scaler underrun, the
>>> first we don't know.
>>>
>>> Fluster command ran (two threads, never completes):
>>>
>>> ./fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -ts JCT-VC-HEVC_V1 -j2 -t90
>>>
>>> Nicolas
>>
>> My test results for fluster differ from yours.
>> On my end, the results for JCT-VC-HEVC_V1 are consistent at both 300MHz
>> and 600MHz.
>> And results remained unchanged after multiple tests.
>>
>> I'm not sure what caused the differences between us.
>>
>> Below are my test results:
>>
>> 600Mhz, 0.9v
>> 	cat /sys/kernel/debug/regulator/regulator_summary  |grep SW1C
>> 	 SW1C                             0    1      0 unknown   900mV     0mA
>>     825mV  1100mV
>> 	cat /sys/kernel/debug/clk/vpu_g2/clk_rate
>> 	600000000
> 
> You are driving the SoC out of spec. The datasheet clearly states that
> you need a 1000mV typical voltage for 600MHz VPU clock.
> 
> If you drive the SoC outside of those ratings it squarely depends on
> the individual SoC if it will tolerate the too low voltage without
> errors. Some SoCs land on the better side of PVT curve and will run at
> the higher speed without issues, but some will not and will exhibit
> random issues outside of the datasheet provided specs.
> 
> There isn't much to discuss here. The upstream DT for the i.MX8MQ runs
> all the clocks at a rate to meet the nominal drive voltage specs. If
> some peripheral clock does violate this, this is a bug not a feature to
> replicate in new patches.
> 
> Regards,
> Lucas

I agree with you, it's meaningless that test vpu with overdriver clock
frequency and nominal drive voltage.
We should focus on the overdrive mode at a frequency of 600 MHz and a
voltage of 1.0 V.

It is my mistake that not to adjust the voltage in this patch.

Regards,
Ming

