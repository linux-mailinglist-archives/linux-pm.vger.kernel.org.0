Return-Path: <linux-pm+bounces-42157-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHqtN+ujhGmI3wMAu9opvQ
	(envelope-from <linux-pm+bounces-42157-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 15:06:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FF7F3C27
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 15:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ABC5307ED60
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE613EDADF;
	Thu,  5 Feb 2026 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hdFia7fi";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hdFia7fi"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342933EDADD;
	Thu,  5 Feb 2026 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300017; cv=fail; b=NNH2H4Qu8yHGxd6t5qx6e+L7Uo6oLWEhc8ebzt0nyq4MAzwOvjgJgNj15l7OWxyGtTNPagxIzaOwEUKJuWtKp1IC+Bq6rEdd/t8+1ykd2CaNT8Fr9B5glMix85DOQzpcCvxekduSkqliMors7KOmRzHRZ1CDGxL+fwkmC7MRb4w=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300017; c=relaxed/simple;
	bh=GeNkM0mROyF0bdf5oHR9Z8S+qBXo5nBUzKx/jGjBozg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LMEiirvA+nm2hSKUcd8QVH0uIuY5omTs3EVpIFyxta+qWJsi7s7Eu5YLmSaCGVlUU/n0UgC8JonjXzdX4044qbeOMsWnTXRWS+7PdLyPt5LoIq1j9KBlic4f5gJtLwgsTCfj92ZgxmgMlpkf2ojd53Nfy8GM6SMJaBEbb37jzpI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hdFia7fi; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hdFia7fi; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=b26ia0UB5fZqJYvGzMOcy+IaQdxxt80QRh7BF9cjmKOqTrH9ABv83ugf4cKSLMn8J2AsmBcbbCgiO/4BRodN8v+HRWU+E33Y4+rFobH2yEMKqc1OQb3NL71KS+O8SuDmr5AYPM8jjo6VAIR6ZZf7lDlqTbsNGh+CvvRawBGWbTeYnAl7c7SqSD1smDX/uFJfzeIvZFoNtJjj+PmAi+J/Cyu+ZiHnLQeK9eU1CaXSAeM6/QRmnPaBDR0zH64ZSkSP1cHZHJAnDbw9aHYe642bV1t+LiRK48GwnbJ5OwlfEFWXYw9/JqPcqKV6GMTqfNnb+z9VFglTbqIHVGzVbtiswg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsullWWcH15enBQr0ZC7XOYpFQdudA00wAYIxkQT7gY=;
 b=RPdDtbkYh0+mvxwz8trVBt+P06Z8Vu3JdfTdkpYMLrDhi+6btRqNWQUQAOOI7xNrMBkn8sWW0HWKBqBM9Zro3HGAb5seUXkTpbmeUIxlfnJuTz1QxwWdhz7eD7Nduv6cdjE1jCpkjG1SsXO0Yfe3N2h7YN787WeGqAp5LglPkHCM+eyYjAW3YY1/CDLkAZxTTsz9TaSmBotKarGTFAmlzsJr4CMtQf0hj0kmMVw6tlwaLaYuFrUFmCI7wzsZa7eoCP/C/UTqkaXkj3EwOMZmaGs7BBH6PpKO+h+kitzepF+V5BlRRGSxSY8OlzmKZoplMpiB8Gth3rTRYVBAo13j9A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsullWWcH15enBQr0ZC7XOYpFQdudA00wAYIxkQT7gY=;
 b=hdFia7fiCnzWhexARy0QIm1hkyje8+sIRtBrZ8N0WySG+Lw1I6gpbjPFKt0GyQCyBBuj8Y3gsVG2D+UrLf8iF4Jj0tsRl/Wr3cVXEj5YJ6P2TBVApVXAakMK63XXc0kaHU2EM+ajmseN+jC+fVfODnzrHXx3EX+oDvpkSI3DQg4=
Received: from AM7PR04CA0023.eurprd04.prod.outlook.com (2603:10a6:20b:110::33)
 by DU0PR08MB9394.eurprd08.prod.outlook.com (2603:10a6:10:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 14:00:10 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:20b:110:cafe::9a) by AM7PR04CA0023.outlook.office365.com
 (2603:10a6:20b:110::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 14:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Thu, 5 Feb 2026 14:00:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzbUL9Kf7V5IpdGN/h3Ou2Ym40edMDzo87r5bOAjqZ9/ehMwJ9MOby2gds8rgik2ykfcpeDX7ljoCHb7YZ/2ZBmK3tCIYatAg+xV/1Ijm507MZt/m0wREE4D+bUG9Kzpoffmw7YAMxIle+nbznAHnsFbdZPHdBFU/V1PeUZRFC9ZIbN37cw3GetYM37KAbC+yOVwuSld7vE8AzutIgSMYNYMwYX/ZftFiF5ej6k+0PUU4Of7zYO9e9h/ZA+kjRgVmGvMjOCgYRC6p4mmKI35HRpcosySC0Rk8zpO3hIKLypOtIvTMf6Y9g48mfVpjtjANPsb7WdTJWezwh1F6ihELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsullWWcH15enBQr0ZC7XOYpFQdudA00wAYIxkQT7gY=;
 b=cRle443TVrGBu52fpMNJE/eQ/opUrpTmoy0Zmj//+8hhriDnQ1uEbfNHCSw4QdhBtGOZY2Bax3xpYWb7glQer+13Pbu/AZzFUwU/go7dOuxUi6dgMLEMbUzlr6w/xjsKEbTlRM8JIhOk/MrmzPwxNiybT7vFQ0GezOCtWGsTJNqVN3kM0JRwYdbErNL+bns2exvkM3tcxzafVIU+FyA/f8cVYRl+watYn0jKPDwUSCsZ6tERrj9RHRidBexaPWibc7GWJWrZ21uVcvw/I0ijYeyglUpZ1VydmSIJrfv3Xi3q5wRKidKsLOz+0tOjUX3aIr/AfXDvKyOOSCG79ByXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsullWWcH15enBQr0ZC7XOYpFQdudA00wAYIxkQT7gY=;
 b=hdFia7fiCnzWhexARy0QIm1hkyje8+sIRtBrZ8N0WySG+Lw1I6gpbjPFKt0GyQCyBBuj8Y3gsVG2D+UrLf8iF4Jj0tsRl/Wr3cVXEj5YJ6P2TBVApVXAakMK63XXc0kaHU2EM+ajmseN+jC+fVfODnzrHXx3EX+oDvpkSI3DQg4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DBBPR08MB10386.eurprd08.prod.outlook.com (2603:10a6:10:534::8)
 by PR3PR08MB5737.eurprd08.prod.outlook.com (2603:10a6:102:8d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 13:59:06 +0000
Received: from DBBPR08MB10386.eurprd08.prod.outlook.com
 ([fe80::dbf7:8c18:3fce:e74d]) by DBBPR08MB10386.eurprd08.prod.outlook.com
 ([fe80::dbf7:8c18:3fce:e74d%5]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 13:59:05 +0000
Message-ID: <1a9295be-49ee-4fc5-acfa-ac353c8c56e5@arm.com>
Date: Thu, 5 Feb 2026 14:59:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] cpufreq: Remove per-CPU QoS constraint
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, sumitg@nvidia.com,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260126101826.94030-1-pierre.gondois@arm.com>
 <20260126101826.94030-2-pierre.gondois@arm.com>
 <f1ffeb2e-d235-454e-8425-490ea2d076e9@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <f1ffeb2e-d235-454e-8425-490ea2d076e9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0419.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::10) To DBBPR08MB10386.eurprd08.prod.outlook.com
 (2603:10a6:10:534::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DBBPR08MB10386:EE_|PR3PR08MB5737:EE_|AM2PEPF0001C70F:EE_|DU0PR08MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2ad46a-d3b5-4d97-abcd-08de64bee033
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?V2lvZEVuT2tQRjVMM2owUXVMVXhYRllHVEFsRjVRQzZCUHcwdE56cjVhazJO?=
 =?utf-8?B?Vk1yNEU1ck5teFJ2UTJ6RHJ1RFBkMUxvTnNtMVJrdHZGL09wYytRTG9qa21Z?=
 =?utf-8?B?TjVBN1dsQlI0cTByQ2x2REtnNHR0RjNIbU04QnI2ZEVLdHlYSHZWQmsraGJT?=
 =?utf-8?B?SktacHd4enppZjZpZmxFWUlFUHhzOGEva2JIaENRQTAyTkV0eEh6Q0JmbXdp?=
 =?utf-8?B?YlVaUDhIWDRPNERHQWJmNGJjd21kNWp1Sm56Ym5zNWxiaE05SWlkUmoydTlT?=
 =?utf-8?B?QlVXZnh6Z1hjQmFXcEV2ckxjS2tyZWRyQms1L21XdjF6STVNcThiMS9Fbndn?=
 =?utf-8?B?NzY4VXZlam1YZmZLTnlQb0p4ZWpGU0kzb3hjamJjL2lFc05aYjh6bGljL205?=
 =?utf-8?B?c0FhYWJzblRNd0pBNjMzNTVGdlV4d0RHQjJhVDRUb3FvWW1BNDVkV1MzSDRq?=
 =?utf-8?B?aC9vcmc5M3VWejYxRmZmQWFaM3JYbzZTaTRZd2p0WnB1WTRnakNRU0tyZnll?=
 =?utf-8?B?QTZzTU9YMldINS84cTUxREtzRHZ6bm5vci9KZXpKZnN3bE5sSU10bHFEek0w?=
 =?utf-8?B?VHd4cWZ2ZEFtV3JEeWZveElvZ1BMVVZhZmR3OGVuaEhxc1N3UGhiZHllYkZo?=
 =?utf-8?B?anpHc0V6cVZEdGpRNGxTZS8yNllqRmFJYzcrcngwYURyZTRjL2ZmQkhmQnVw?=
 =?utf-8?B?Ykk5RWJzV0xlM3JSK09taUJxbnRLMGRwMXpEdVlwOFJwY1RkVDd2bzZIZTNk?=
 =?utf-8?B?dHR2YklMN1h0OThRSlpZYXZuUXdsWGhhSGxxMldUVDBDOEs2VUs4bCt4OUdz?=
 =?utf-8?B?bDBtMkFObnBsbm9BNVRneUVNQ0NqNXZKeHl0L3ZWU1NPSEc0VVhiNGFrS09F?=
 =?utf-8?B?azNlQ0h3bW5hWlZDRjJ2Nnp1SHRTZXV5a05DT3UxQyt3VlhseWVuaVJzRXE1?=
 =?utf-8?B?QlBpdUVyTUhreGtsOTUvRG9wRHlXQXFjeTV1akw0aEJXOXh2TjJodTdlU1Iy?=
 =?utf-8?B?ekhLZis2OGdUcGVxanhzSVFweU1YM0tOdWhsR1RLRXVMOGR0SGlWRHVXQS9K?=
 =?utf-8?B?OEFZazhuclVtNUlGbTVSalpuU2hwd1VLb0Yxc0lWZStoT1dPL1Z4WDhNVEtZ?=
 =?utf-8?B?Tm1nb0ZNd1ByVnZSdXRBeWt1NHp0WUJ4bE5xRFV2TmVQalFlU3JEQnF1L2hE?=
 =?utf-8?B?MWV4N0pyeXptbGZsUEVGTmxvYXJHK1h6M040T25hTW94Y0JLalVPYTVLYVhk?=
 =?utf-8?B?WDJWQkUrMHoyTTdlcHhqVjhJRjFzdjRiYlp4M3B2aFl6NFNTQWV6QVk4QTlN?=
 =?utf-8?B?cC9MaG00bWZqbHJ3ekZHeGFDS1NYOFBpbDdVQXdHc2pNRnY4VGY0Z1dqYUd0?=
 =?utf-8?B?WE5PNEcwbU51dkJPaXZCVmVrTEQ5MWQvWHp0RUhZR00vcVJqL25iSmtZNnNr?=
 =?utf-8?B?OG5vLzAzZXU2eWJVRmlnVDMySXp1WlhmZ0pOS2JWY3B1cGNMUGxoWGtCeGJz?=
 =?utf-8?B?K25DTTU0MklXWWI0Qndna3VJZWJrbnZSYzBML0pOajl1Z2JlTVBpYnk4bUk5?=
 =?utf-8?B?bDJRVzgwb3dROU9ibVkyZEZzdlZGbkovUEljTVlqZ1hFZUJkaWVrLysyU1lS?=
 =?utf-8?B?QnVIMzBweVlJcmU1RmhvUWlqNVNLc2NTWWszREpLcEtRQzNxZk5KN1V6eUlW?=
 =?utf-8?B?RThuUEVsb3ZkbEtkRFZEbHk4Zm9nWE9qQkRiM3h1VmxFY3JnWDFmQnl0Vyt2?=
 =?utf-8?B?OEo1YklMaHJIZnFqMlMzelJLaU9YL09IYkZ0NUlIOWozQlVSakpqUmowelJs?=
 =?utf-8?B?LzI1YTlMSG1LcEkxeFh2Tlh1WU9OdlIyeFlTTEgybEJTeGJtVmpDcFBIV1ho?=
 =?utf-8?B?WWdYRlN1TTBOL0c1TDd4Z2JIM0UzTklWY0ZDNWFCVmlmWGd2K1AyeTZuSzY3?=
 =?utf-8?B?bW5Yd2dXclhudnhFaDJ0OFVzSjNXb1I0VjF3VnlXcGljYXlLdngrSGNieG95?=
 =?utf-8?B?ejNBNVJlNXh6eHg0U2lYRVRoRm9rVjZRYnl4NnhUWEZ4WTVOVGFpSVVONzFs?=
 =?utf-8?B?YXZnTFpkYUM2TVVTdFRYbGd4R0NsVElWdTZpUytnNHRNZ01jcWRna1FxclA2?=
 =?utf-8?Q?IgBY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB10386.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5737
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3cba3dc7-9d6b-405f-610c-08de64beb990
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|376014|7416014|82310400026|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cC9kZyt6WkViSXFqUjZaeUlQVHpmbWJ5M09sNTArU21vZ1NkcTVkVzJzUTdu?=
 =?utf-8?B?SVB2SzBBS1Mrem16cGRsYWhtY1ErbmxwaFE2RGtTamdkMFlGUUZmY1Vuajlu?=
 =?utf-8?B?N21oS0gxOWxKdEJLRk1pOFlyV2R2REFBbTlwWmh0ek9qK2htNFZSZ2o3bkRE?=
 =?utf-8?B?c1ZKQjJLVnpkQjJ0SzV6cGh4bFlYQlBSTUltRi9zSWNRdk1uMW5yejlscmVz?=
 =?utf-8?B?RExlMGY1Mnp6Rkd1VlpLSThwL1M1TEduYlNPdzl0VDZGUDUybmE5bXVOWjVM?=
 =?utf-8?B?N1dsVStFR1labGNkeU43RGp2WW1yN3c2aUdtQUhoUUdLejhWTHJFMlZEc1h0?=
 =?utf-8?B?b2RmSlJXblJYVW1SbWJ1Y1JEb2FoMnE5T3dkY2I4QmFWRVlUZWFNVHB3Y2hp?=
 =?utf-8?B?UlNpeTJrUyszd2Q0NmRXcFkzVGVnN3dGNWpYU1BEZHVSZmkzeGdUREYwZkVO?=
 =?utf-8?B?UTdDZnh5QTJxdVlEWWFwRXVWOW1sR3dUM1k1U1V5bDlGdnZPRHhkOVpNU0JN?=
 =?utf-8?B?NUlWUTB2dWtieWg2ZlA3eldMSHkzSFdjdVRwcFp5bWt5Z0luM1BLNkJvUkN6?=
 =?utf-8?B?bjllc3FGNFMrRnIvaURoOElNRU1LZ3ZBckF2TkJFbEYySHRDYWJUb01DR29V?=
 =?utf-8?B?bjdpNlptbWtLdmoveDl2eVkxSWRIYndpdUQzcXlIYTEzekpaVWFCc0U0Snpt?=
 =?utf-8?B?bU9vcHlLeTI5c0lWUyt2am5SVzJLUGtQTjhaRzRMMjhtejNEbGdlK1kyQzVB?=
 =?utf-8?B?dXJTVnhwRDNlREtqYVpSL3ZPazlBNGxwbUFDWUM4c0NQRFhweHBoMlk4MnFS?=
 =?utf-8?B?ZW1nSzdUdkFoZ0wvYTBUTlRqaklhMHpyaG9ZNWVWZzZsdWxvQ2lOek5ha3lw?=
 =?utf-8?B?d2pQcXFhVXJqbVFSYlpPcDRZQ0xMNEV3RWgwQ1J5UVkwcEswYnBTQ1d2WFp6?=
 =?utf-8?B?bUMraXQ3K3R2Yncra28vb2xweVE1M3luakpycGt6V0JGempWWjF4Z3hmcGZh?=
 =?utf-8?B?TVlBejNuM0tETEthTDc5ekxMUFE4RUtxRFpNRlkzRFY1WjVtUFcyRktHRzlF?=
 =?utf-8?B?RTd4QmF5c0xYOTN0dGFpak5zdHNDMnUxWGJsUnZkSHJOUVZ1MDg1eHJ4ODRi?=
 =?utf-8?B?eEt6L1g3UFpSNXJWMTVjTXJWY05OZnA2UThhNGIzY2M4ditBdEtBSWk0WnBQ?=
 =?utf-8?B?S2FNTFBSR09mWWZEOGxERGozcUxpbVBML3NYYmdBZ3R6Skg5aWdUMklSYk5h?=
 =?utf-8?B?czE1M0h4L1lURWUwdkhTdmg1WElnMkRYaVJDQmh2c3hBNVJYSkJTZE4zZG9I?=
 =?utf-8?B?L0xYWDlEd1FydjFwaEYxS2h5bzFoeGs4R2hrek9mN3Rkc3gyR3FoS09Ya0Mw?=
 =?utf-8?B?MkFxbVNkV2FQeVhZRStrbGNHR3RsaTdJN2xnYXFOeWdmWlhpRzZIdExRSko4?=
 =?utf-8?B?SUYwaVpVV1MyNGY5ZDFTTkl5VHo3VUpSYWJsOE92NTN0Q0VuSm5TcXluTXlY?=
 =?utf-8?B?c2xnemd1cFBrS3h4c0lZNzYwSWt2VGZ4MDQ0WmlpaU1wbzMyODFhdGgybG5M?=
 =?utf-8?B?cldUSytIbVROcDNoNmhZVEVzK3lEOVNQb1RNakNBNDFnblFuSjF0L2wvVnB3?=
 =?utf-8?B?N2xUNU10emkyS2RJY2V1ZnVZZ3RWaXdFcXpySGNwUDZra0ZZQWZnL2w0a1pa?=
 =?utf-8?B?QjVmWnZuVlNPQTVTNkdCTTU2c1pNTndHcWcvdnhwRnYyK3k2WnBwV0hDMnZZ?=
 =?utf-8?B?T2RNdFcydUJDOGhxVTBCdldRdU00M1dkNWZvVmM3enBTeUxCSzJualRrNkJD?=
 =?utf-8?B?U3Y0VFJYT3IxUkpTR2VGLzNRSU1BV3pVN3Fxa0p6UFJ5N0VZNjNkM2FkL0xM?=
 =?utf-8?B?dWFwN1RkV3AzZUlqeG53N2NaL3gxTmdZZ2g4ekwxQnZMaHZ0cVRvVjNVYlNo?=
 =?utf-8?B?Q0FLNHByMEFZdytRWlZwTVNUYjJvS3lMc3djdENVVFdJS2piWkcyVVpyb0FH?=
 =?utf-8?B?Tm9WZ2hzZVRLWnA4K3JxNW51UWZQYmFIMmR0R2dDVzdlSjNnbEtRN29qdmVQ?=
 =?utf-8?B?dkF0ZGNIdFBYOVpQbktZZ1JEaVFIQW9nT3JFbVhJTzJpeVpNalpyeG1Daitt?=
 =?utf-8?B?TTRtU0o4M0JJRHFLakxqd2xFMGZhWEhDVnV3K2ZvbGZETVd4YlJHbGc1clRo?=
 =?utf-8?Q?PNlKlFbSPk/QDmw8wR4E7Vukp5NtUBX18MEybZFtlM0/?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(376014)(7416014)(82310400026)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	coN8Dg2m5GF0dS0K29KnjlsMU420STtZt0e9b+G3mj6LMDcRF+6Bl6k21fLjzz/vB2hyG8VOdACVTSqBYkTcIaD32DzDbLnCWQ2u3WcR3uT+6kzHvpS//bmzEDLdKvJgQNuPztaDxaX8j/4guXRNx5ujXNLoHm3pC8ZBvYOO+299YIv2go+yUSD2gybsT0B2JbLdRUMN7ZzMVC45bipWLo+q1OsFNrwRuaALbAa0hp6RJRSavyLy2xwoDTfnSNwBght+Y6fL5JWGv6nD00TPrZhUczSp/MPvB7H7Y1MXJfkKbT9k6fkarldlWRzDjfwE2aEHZBm4xZowkkhAwuWzDP316tKbuhRkfZi5guSnj5T1DMuVbvno0mJ5bNBTXFWWkEMvgH+IjQ5jJtV4RD5sJJnIz/TDS4jjT5iEwsm7byAnFQqTBIwLJ7rKsiyUnHQp
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:00:10.0334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2ad46a-d3b5-4d97-abcd-08de64bee033
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9394
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42157-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:dkim,arm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 58FF7F3C27
X-Rspamd-Action: no action


On 1/31/26 04:28, zhenglifeng (A) wrote:
> On 2026/1/26 18:18, Pierre Gondois wrote:
>> policy->max_freq_req represents the maximum allowed frequency as
>> requested by the policyX/scaling_max_freq sysfs file. This request
>> applies to all CPUs of the policy. It is not possible to request
>> a per-CPU maximum frequency.
>>
>> Thus, the interaction between the policy boost and scaling_max_freq
>> settings should be handled by adding a boost specific QoS constraint.
>> This will be handled in the following patches.
>>
>> This patch reverts of:
>> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
>> a CPU")
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 4472bb1ec83c7..db414c052658b 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1481,10 +1481,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>   
>>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>   				CPUFREQ_CREATE_POLICY, policy);
>> -	} else {
>> -		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>> -		if (ret < 0)
>> -			goto out_destroy_policy;
> I think this shouldn't be the first patch. This can be removed only after
> adding boost_freq_req, otherwise it's letting the problem out again.


Would it be ok to change the order of the patches (i.e. patch 1 and 2) 
instead of melding this change in another patch ?


