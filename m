Return-Path: <linux-pm+bounces-39294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEBECACDAD
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 11:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D907330446A4
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B5030FC24;
	Mon,  8 Dec 2025 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="E4+x8wV0";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="E4+x8wV0"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011052.outbound.protection.outlook.com [40.107.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7B25EFBC;
	Mon,  8 Dec 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.52
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189559; cv=fail; b=erNFLoXTWTBUOWAEvwG5Wmxj2106bk9TTMeu1PxWEJ+Y7hFtB/J9I8Qu9Dg3Yf2lFS3ottkwG4Tr9BULcYQHCGMazWBTAwQVIXvkgphofZllbtiBpa+xMtxjrMZeKuc2NVoE4QxftrEx18QAMUB/jONWaBhm1lMIwBGiNwfFGnI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189559; c=relaxed/simple;
	bh=sOsp8RkDImCC78AUk1YAOh9R/SjUBbOFbeo6GOgQMg0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LVBbKiU1AzRKjJcPfTHcwZz2EklaVps+94SVVwyI9NiXWPc5IAJ7uCDvzD+3DpYW+M8+3Gj6unoL7uPAdVOd9tryQVEBWaNhbf2I/D2EFeAeOIy/aXZcrBrq/hhc+WGhBsmfQnKs7PNnZZwar0jqFQj+yBLDtRDZcg6Qurj5ZCg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=E4+x8wV0; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=E4+x8wV0; arc=fail smtp.client-ip=40.107.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=e10IxingzXwMV5UKf6Hy5ECUdruXjQXkQpVAp+rddei09XTweUwExMUh6xGQ7QBy7in1J7KMlgvWficO0fRyJQfYGs+rwq/h2iAqO1ANHQuYI93XbCqh3Ux1Aw3/XYkzcp+WJ43GuOeDIzhl69F22auAz7rojit+9sT7YhDlyNPf+OQVqAxKEAzRDt4twRPoLLT4qBN3aJH1fVwysp47WNKLQXy1vSAJeL/c5X65hoDCDifhSBB9ulmu6s/lsG60S1+8tbwTiGpHQvxohW/OjlYxnDqF3UEdwRXVWubgvu7E2+g44ts71GAGqBtBsJxWw4z2phWtNA7KESqNohXshA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ce5JvkKoweqyoMBZV0PE3mnt8hfdu6W/n8tLTo2+Y8=;
 b=h1c2OFOUEgodTBRkmVsXuSmVN+NoARhgiBhTXZGKnOB5aGFPhtB2U2Dm+yTVz7rspIQHgHuvuY1IKIomT9i2DzZ8n9ifTPHHq2hwwiqYRShA1F32IGj99lgs8O6beWliir/tJ1RUCaPyTFV4FCcsDG77Vk81vFNcpz4S+F77d60PAr6SN2ButzRucYizyC9B85aaOwOuRy0wf9PF3rtId48y1Ln0LDwb7PmxFsUbp9cqvV6f8cBjhTaSrCZSUIGrnowWqrTZwm/pxZrjrLlxbZBBqWimqv9rXZunNUQ0w2I342DipTVZh1pm/hQBmkf5JhBCkO0VqGHpZfxj4a/ArA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ce5JvkKoweqyoMBZV0PE3mnt8hfdu6W/n8tLTo2+Y8=;
 b=E4+x8wV0jCb2I9YPyzmdgWYmys1cV/Sq0wwS4fIFYnlnPF9cEnWcJjEz4ux/7lD0PSRpMmjVl4KNNpBdy4eIS6JqQ0Sm+61YKT64CzWQpfu5rIhIi59djJHPQ8m1h0CFnqT/WCwHhIjxIWwByYi9NHU8WF8gX5s5R0NuVU/OcYc=
Received: from AS4P195CA0017.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::8)
 by AS2PR08MB9570.eurprd08.prod.outlook.com (2603:10a6:20b:60a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 10:25:50 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::34) by AS4P195CA0017.outlook.office365.com
 (2603:10a6:20b:5d6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 10:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 8 Dec 2025 10:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gc8Idc+vViqEcD06/W3NnYzS36bdR/F16YmWp2wcKFyjWJTVwCm53FsAUx0NH1xRan36NfWe505QRphpHRVbnMpPEtAeMKL5k15USbiLSfqk4rnH+74sR0hU0B+Z4az3/YgTOhXoQlkPeOl3cKQsBHvxcECB6BNzw3JRXK2JCiK0JTYW6XrCt7gW4Z+W106a36pWdlZ8lKHhO/TIwuWP1DJa/DfhE6DCknRjB5M9yXJQqY4Xfy2eVTtVPGIjvTANAgkNo2Qb3fWE1dhtNL6UUwkkjPWzDj/rlbb6mHx/UIQSODhZ3qfQAdJ1gHm5dOzjSHkKD3mLMT8r9JyUdnaydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ce5JvkKoweqyoMBZV0PE3mnt8hfdu6W/n8tLTo2+Y8=;
 b=OQiNYoI9UKPtWcd6LqHX3lZtxvPwpCskj8FWoL4JkkYYfuivXz2sRYkrKQ1XEoN7Naqiluhtwl4vrKCNe4mfk0Nz/2aVjYA7phtRnovq/Y0mkuTIvPFsFTNkUCV5xm8GgFcc/5C80Uj8tdaFCvrSNsrq/0MW19qCvU2w1ImTNunqbHiOoQc4w8A4YQzuD5rfJGxT1SBgZFbL8BZls7H8q1c0KfcY2EAIuHE7DRU2yU/riS8vobUuoEX5aVbNDOcD6Uc5YEX+I5j+Y9SuDoliNki19D653nDtNzt6KzpVjrHS853wzE3Dywg+YRDhYm5NcNXoTWNi+bfWTMh+RENHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ce5JvkKoweqyoMBZV0PE3mnt8hfdu6W/n8tLTo2+Y8=;
 b=E4+x8wV0jCb2I9YPyzmdgWYmys1cV/Sq0wwS4fIFYnlnPF9cEnWcJjEz4ux/7lD0PSRpMmjVl4KNNpBdy4eIS6JqQ0Sm+61YKT64CzWQpfu5rIhIi59djJHPQ8m1h0CFnqT/WCwHhIjxIWwByYi9NHU8WF8gX5s5R0NuVU/OcYc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by VI0PR08MB11688.eurprd08.prod.outlook.com (2603:10a6:800:325::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 10:24:47 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 10:24:47 +0000
Message-ID: <ffc0cabc-0183-4650-a13e-a7ff08168532@arm.com>
Date: Mon, 8 Dec 2025 11:24:45 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v1 1/4] Revert "cpufreq: Fix re-boost issue after
 hotplugging a CPU"
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, Christian Loehle
 <christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 Jie Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
References: <20251204101344.192678-1-pierre.gondois@arm.com>
 <20251204101344.192678-2-pierre.gondois@arm.com>
 <6bb8f60f-bbeb-42c7-ac18-e996db6379bd@huawei.com>
Content-Language: en-US
In-Reply-To: <6bb8f60f-bbeb-42c7-ac18-e996db6379bd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0155.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9::19) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|VI0PR08MB11688:EE_|AMS0EPF000001A6:EE_|AS2PR08MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: 5083b904-9d74-4d04-f85c-08de364428ce
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Nm5rY2tuNU1sVnRGWHBCVWk1eis2M1VvVHcxckVacVFmSTgyVEdsdUtIZkow?=
 =?utf-8?B?bFR3NjFLZnJ1WlNRSVhmeE14VWYxN2c3YVJkVmNhZFF6TkZLMmhtanFrUGov?=
 =?utf-8?B?cHQyRmh1MmtZeEJDYkc2UHZPSGNqT0xpWXEwMmtUK3JsaGlLYmZkcnlQUkRx?=
 =?utf-8?B?U1RITUoxbEFKYWhJOWNJOUllZ1UvQ1k0cml6Qk4yV1BZR01uOXVaS2Ribkk0?=
 =?utf-8?B?VytqeklRYzJudUlMSlRlNmRaZ0xoQTJaSXMyRHBxeE83RW5GSXhHcWEwN3NG?=
 =?utf-8?B?NmE1VzNFMFM3aDQ5WXg0bnJsNGlmU3QxZThjZW9JN1FPdUVVWkNtcEZKdTly?=
 =?utf-8?B?anphNVJnYlMzSnlLWS9tc1ZJbkZVdHhZalhqK3NIb3NUeXZDZFlmWVZDU1FG?=
 =?utf-8?B?YWtWS1pYajFqaDlTN2ViNkY0V1N3MkJ2bmYyNlJEelFqVXVMdGFzUUNRa1o3?=
 =?utf-8?B?SU8zdFhia0l5bHJHYXFGNlVxc1l1RXpwQ2phN3V4bld0eERvWVJEb3FObzY3?=
 =?utf-8?B?a2NhaUo0RzBTVU0rYWJ2VHYzS2FmQXkrRnBiL2hoUzhnSFNkSkhhK0RNMmZs?=
 =?utf-8?B?M2JTNW1LeHRGR0xPVGZmVlV1WTVWYno0OUFHbU5DcGlXRng4TzJQUEJsWEJH?=
 =?utf-8?B?aTgxSHFudzZ1bnpJR3FSa0V4M0VPS1hYemRwK1hiU2l5SjROOE5xd2pYdG9i?=
 =?utf-8?B?Q1EzMjBmZ0FHblNvUXpXRXcxOXdMY0ZjUFNRU0lCTFNYTEEwbG5ZK1hJZStq?=
 =?utf-8?B?b3paMmlRWTQyOUlEcmFjeW8xamVqL3E0enJZUGFzWGVKdTcrdms4LzZSNVUy?=
 =?utf-8?B?YVZNMldVK3VmVU54VUZLLzEwWnplWk80VWtqN0p3aTY4U1A2bXF2MmlsTjJn?=
 =?utf-8?B?Vng4NXJWUm55RzZiQ3Y2NGZpRU9ZbkJUc1EwNkNqaXlsUGpET21QSno3YjBY?=
 =?utf-8?B?bFIySG9KRlEzdnZpeTJRdUtDVzJCWTA5NGZUSG1ZRkx1ei92R0NNby9kRXVi?=
 =?utf-8?B?MEZwMzhKNEpRRjEwWlBYYU5wUDZQZFo1WW5HZHk4NzhzdlV3dm9QVUdDeGw3?=
 =?utf-8?B?SWRoOWpNZSsvSmgxL0ZIVGJUak5tY1cxeTR5Z28yNGIyNFFZazg3UUJUYWtY?=
 =?utf-8?B?amc4U2FSVWFGSnowbC95UG4wanp2YjJBOUgvSGZCcFovVkR3S2VJOXNheHJN?=
 =?utf-8?B?YW1ROWIrTE5Ydkxzc1k0enRUbzNtakdZenZPc2p5c1FOQVJod2k3bUo2dnVG?=
 =?utf-8?B?S2NXNUxKV3dHNUFvaktKbFl6Y0NDaGluaGNBTWxXMEFNZ1Z1eDBXWW0wTjVJ?=
 =?utf-8?B?dkJ0QmVlemhtUTcydkNWaDVWdWJwRWRwbXI2UWRYWVdhaGJmRWd3UitOaU5y?=
 =?utf-8?B?aXUzV3dYSDZyREJGMHM4d1Z0TUk4d3hZSFdSM3lJUHRCdm1ycWZ3a2Ryd1hM?=
 =?utf-8?B?LzEwUHcxQldxQ3dMeXFrVEc3QWgwYXI1ZzlyUDc0Q3JVcEF0aG9NTVNEUlNl?=
 =?utf-8?B?QTNiQ0tPMURTRzc5RndsbW9QQXdGTG5iYWxPSVlGcmtTWUVkM3QxclN1eDJq?=
 =?utf-8?B?QlZTZklBZXJKVEFTUnFJQlB2OUYvZHcyM2k5TXhzM3FhRU9pa1lVV0ZNVjZs?=
 =?utf-8?B?MlMwc3hxM0dUbDQrWDVGaFl0S3BjcVJYQWxERjZZSDBxR2U4RUttSWF2b1Nx?=
 =?utf-8?B?TGJRZlBRQVltRTd4dUVBUDJWNDVjYmpwemQzZWVaQVVtM2U2Vjh3MWpObzV2?=
 =?utf-8?B?RE9UQlNNaDFkTDI1SVV5NzN6aG1XUitxRW9ZZXhvc3MvRml2a1FySjZjUVZV?=
 =?utf-8?B?ZEZUVUFFTHQ4bmVveTY4R2Exbk85c25OdHUrVis5V1loQ085QkkzMUJZd1Rt?=
 =?utf-8?B?ODk4QVE0SVJ0UWZQdGlMSHd3ZjhlUHBBYmxjdjNIajh1N3dKOXZRbllxcmNM?=
 =?utf-8?Q?6t5zsi1FPffrW1Oinvl0qm+y2sX+qIGv?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11688
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5b42005f-db13-4e07-7c4d-08de36440337
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|1800799024|35042699022|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGM0NFQrdm8yWWlxK3A5Q1QyL2lZZ3FWWlhXUWpwdmNuaGt5eDNmejhMU2F0?=
 =?utf-8?B?K3BLajg0bitlTDVWWEE5Sm82VUowRy9CUlVHQkxUWDlSRFZNQ09tMGNwNWo0?=
 =?utf-8?B?TUZDV1EwMXNUZ0sxd2ZwUlBqRVR3cmU4THVNeTRsTGp6TUpSSHFqc3FQS092?=
 =?utf-8?B?WkthVStrd01tM2xaVXhpT1J0U2MxdncxUEllNTIweStrb1dNY2dVSXBuc2ps?=
 =?utf-8?B?VmNhWlY5NGZlWDh5SXJCY05iWHg5ZFNPK1B1dkY0TFZpK3o2NnB4bk9xSVJC?=
 =?utf-8?B?THdXakRjK3o1bnVTbDhXbWMyemsreGlOUTBlZnF6ZzZ0QXFGbEZIbEJyRWVs?=
 =?utf-8?B?dk9KTEY5dGx4ZmpPejR2Vy94UWFhWjU1WXk2U2JveEtTVUIzK3VDWGlWT25E?=
 =?utf-8?B?bCs2cDBYenhsRlBYenBOWmppb25INlU5UnluTDRkazYyUjNzdzRCRXFXa2cw?=
 =?utf-8?B?ZUVNSC9oRDRxYndzQ3FyK3VvMUpzbjdjaDNKWlpseXZtYXpBQUl6WjN3VytY?=
 =?utf-8?B?eDlHLzVyQTJPZWtvYW1ha2ZsSkVNTG1sRnZkeUNqd012OWR2a2pTM2k5blZH?=
 =?utf-8?B?RGlmazBhY2x4TFo2cjdXK3FUZ01mdTZObGZiWGtZU0tNOHZRdVlueTViMXpv?=
 =?utf-8?B?YzFtRnBnb0NERkZWbThBc0tENUFERDFLRTBVaGdpZFZzR3NMWEh1S1IydGlv?=
 =?utf-8?B?VEFpNVJhL1h3OG9lZ2V4OHgrLy9idzFxVjRWL2lIeUZON0pTUzVtNGpYamtH?=
 =?utf-8?B?YTR3aDhMRWIvTlBSanZmV21DanFWT2IyaFU5VkI3QW0wb2xZRmlLT2RlRTIz?=
 =?utf-8?B?YW5BS0dpd0FVNDFNTnIvZHp0bzd2dys0cDBsSEk4UHhDY1diaHg4VUdOZTkx?=
 =?utf-8?B?ZUNMK0dsUjRwc3RuUnNRNkxPdXlzcEpMMkhncS80d3h1dXhjazdLUFpPR2Jv?=
 =?utf-8?B?MWV4eHV6dGcvVFROeGVEeUlVY1o3SVZlaGUwUDlKT3BCRU02UHNNWW85ZVFN?=
 =?utf-8?B?SDl5QW9XY1Z3SEFFNDFMaENDSlVPcVdnTTVVdW0vMlV5dHIxbk1CODVNckUx?=
 =?utf-8?B?RXpUU3FoY1llYVZkQUhMNDJXOVd0bnNFcjN0cE1JeHh3bndNOFJRUElvQnFE?=
 =?utf-8?B?RzI2S0wxTUFxZXMxN3VOUHg4Rm0rZXRhR3VNRURsd3FxL0c4RGRCNjk4UHRB?=
 =?utf-8?B?WGpYMVBWSTZrQmJtZURwUFQyWHhaSDRGK3NObzl3d1FCZFZYT0xBTVU2Zi8y?=
 =?utf-8?B?Uk90SkJlWDJOemJMT0R2VUNQMzJqSVhRUzlJKzZoK1ZUTTJzNDFWSUpGYytU?=
 =?utf-8?B?RldOVHRtVG9CT3hsbkJwTkUzWExvZHdtWmIwWlN2dmtGMnd6RU5EaytWZTZY?=
 =?utf-8?B?Q050THR5bk1DRDR2aGk5WkU5dzd6djNpcktSWklGU1RtV2MrZmRGOUVXZW9m?=
 =?utf-8?B?TmFxdG80UXNJNkQyNk84RWNLVmkxWEZ4T3FOa2p6YWs5QmRuY0Y5ZXVZMC9u?=
 =?utf-8?B?OFZYZmJIdHRyVXk2S1NlaWpiVnlqMDdBMXVWUlYrNmViSEt6aFovMFAzcWg0?=
 =?utf-8?B?bUsvUHZLanp5Wm5aRjc3aVpUZmVYek5lMUgvUmNaOC9mWndFVExCQU5kSHg2?=
 =?utf-8?B?WkFRdW52UzNLcThpRW8vVmZ2YkpZaldhZis1aHF2cm1TelpFdDY3RnVWQStq?=
 =?utf-8?B?Z3ZJTXFyanp1NnF2TlpmR3o1SGdQMFNXSTltcEJuUFI2RWdKenZHS3JSTllu?=
 =?utf-8?B?OEg5YUJWRDhvUWpRWXhrYUlOYms4bDFjWjFqS1FQVkFIL2lwZExnV2FveERj?=
 =?utf-8?B?Rjk3RVM0eVdkcXQzM2NobGVhcmdLbTB6akVscnl1ZVpmeklpTUJ1Mmt4eHcw?=
 =?utf-8?B?U3U4aVpSODFYVWlsUldhVDdqRnVBRFp5OE1JOE80KzhmUENBYVMyaEczZkpG?=
 =?utf-8?B?Wmw2bndXbHpmeU5XejB3dmUrYzlLN25sYkZjelJRYjlxS2ZkM0VGeVJUa29D?=
 =?utf-8?B?VzV2Q0I1RkdCR2FxcHNYaEJrTVdVT0hKalNyckVBRkVFMmQ5RjJ1Q2dWTkJx?=
 =?utf-8?B?VEcwOXdPNnpHWHlJZWlSR3N5cWxheVlOa0xNOHZTN3lpQ3poL0QraFl5TjY0?=
 =?utf-8?Q?PbYY=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(1800799024)(35042699022)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 10:25:50.2636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5083b904-9d74-4d04-f85c-08de364428ce
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9570

Hello Lifeng,

On 12/4/25 13:09, zhenglifeng (A) wrote:
> On 2025/12/4 18:13, Pierre Gondois wrote:
>> policy->max_freq_req represents the maximum allowed frequency as
>> requested by the policyX/scaling_max_freq sysfs file. This request
>> applies to all CPUs of the policy. It is not possible to request
>> a per-CPU maximum frequency.
>>
>> Thus, the interaction between the policy boost and scaling_max_freq
>> settings should be handled by adding a boost specific QoS constraint.
>> This will be handled in the following patches.
>>
>> This reverts commit 1608f0230510489d74a2e24e47054233b7e4678a.
>>
>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 852e024facc3c..11b29c7dbea9e 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1478,10 +1478,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>   
>>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>   				CPUFREQ_CREATE_POLICY, policy);
>> -	} else {
>> -		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>> -		if (ret < 0)
>> -			goto out_destroy_policy;
>>   	}
>>   
>>   	if (cpufreq_driver->get && has_target()) {
> I don't think this commit should be reverted individually. These changes
> can be included in patch 4, as they are doing the same thing if I
> understand it correctly.

Ok I can do that, unless some else prefers it that way,

Thanks for the review,
Pierre


