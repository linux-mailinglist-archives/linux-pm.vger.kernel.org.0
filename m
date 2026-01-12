Return-Path: <linux-pm+bounces-40666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4539ED139E6
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66951306B57D
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 15:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A0629D27D;
	Mon, 12 Jan 2026 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="X+kryk9Z";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="X+kryk9Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9618B2B9B9;
	Mon, 12 Jan 2026 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230209; cv=fail; b=GXsJLVgW7W3xmypSXrgLJkMgTGzTdFUAQENJaCdqIRkflOo9TJxJObokpesORVq51DpBAl9bCoQQ0gh3xDyHEtfq9Adq01UFMhquejrJbI34e2MGPXaHBoZx/NNcr7AwegIGbpdP9dw9NLFdA8ZKTxi1imetix4Gx9OLAP5rQaA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230209; c=relaxed/simple;
	bh=nZK/cxIzWzo6mQG+R3nYO/c7bj0WXl59D/vFm3lyM0Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hbPvTzPI7qS6CvMpdA+qoGl/jyCv5D4yraCd5K2r4z5jxD9WCxHnGGf5eUxOLAMC0/gN/qAGSjb3Us4pLHCqSXt44nLiH9YbrPoI61Q+D0ZoOn9WPgxcOpbKumkROGQpyaknj30n4HDnVKbupMX8JE7duu6+QsEPUh+AiEI2Mqc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=X+kryk9Z; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=X+kryk9Z; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=udybFWdjHnBBau7wePSC1H95CJOE75V61dglIy67c2urju77VQc9jPm8Ki1RupfBHWxBVsCCN2Aqe5hXTtOn/jIMzCLG/P0S0qD5zORmtWTXROPfVJNaLyjwbxC1WM/eol+MdQCv/954YP5EcfeSGZCQ4ARzzTtAp4xC7OlZtDXG3kPBsDh3zpOm9Xm0RNclGkG9T6HpVv6In9NLwhgurUncpL3PGiuvTESit4ht4/Rv+IS7c4RPrP5FlNU6+VgPEXeQpXxnNQic/TUkFUtQ7TBc9lj+jd15kZ33QsY177F8+03xqXLrZwOq2zX5LAtGQ9bHVlobjtbNx0zbD2lfRQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyxxnVHGyVUyGEeAl4pLcZWDC1v3XpxHNqWWr7IglOI=;
 b=Mhm3tldk2JT1US89+YYRMO5IHcvpI0nSss4rbafSTkh1MEtdtfrdeu5V9piXgtnY2ZYkxo1bSfJf9mOGrWyjYTtaMit2oT5a55mvC6XmobLS+7lO9egEyXWeg5TIP8rSvNnKnL4nOyejgaDAcTNs1sdl3aH58svac5kt0lYwK2GbOKNR0xoqlWgxccuf/GFMfgtyFvYEpE5rU7oDvMkjGesuqGM7P6rJMJ9/aRGshtSUC73yinDg61j2/Chzgn737uRsq2u/hWj18/O/AE/Nj+aBmVv3sSsc3Dt38QSIVgg1X0FhJrl8EpBsClPCcO16niR3sR+HIbk2sBugl6Cd8w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyxxnVHGyVUyGEeAl4pLcZWDC1v3XpxHNqWWr7IglOI=;
 b=X+kryk9ZsqKxecPHxd/TFoPy5oVHSc5BWWdcrugTOIldYH7avSGMEFuYpyB4LM8aVP+/9OIueXZ3ADh4FphXfSI4NhCPSojlKLsInMjiwBFYFmmNDjzHYQ43m4RVOwAeYtYzuJBQEfR6rt5sAQbJHVc2YomUpMZyF8JWci6/M6c=
Received: from DUZPR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::14) by PAVPR08MB9651.eurprd08.prod.outlook.com
 (2603:10a6:102:31b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 15:03:20 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::ec) by DUZPR01CA0036.outlook.office365.com
 (2603:10a6:10:468::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 15:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Mon, 12 Jan 2026 15:03:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcQfXwDB0Nyzki1IgkX0PJWyhiu/Nfi6Trjuq5E3KI36AwLdNebV91dbX5WwllF1ilXVogycZcHrlw94TYnXAT41VoJ++1uI+EXS/mBrmGCUemwYEUibfGpSSLQu8+8Mez65LX4lfqHQVujHwViFcboYI1bpixmw2OqyXFRDzsTz5qskDI7uBwWbG7bGW3Liy6jA2Bdo2IDkj+EowO5TrYq6dme9IIYT6C/ctvn492BpIZq3KEQOoLBI/m4iQmZNbrqvZgRJEq1atibixJh1GkcGOEaFPjfnmpXgXb8rfdfK8P+hz5cqxp6bc57xDri23wcVznxt8urpmTxC/jt9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyxxnVHGyVUyGEeAl4pLcZWDC1v3XpxHNqWWr7IglOI=;
 b=XmbZpSyURVJUB5LxTTzMsgymoU/1cY1tJyiwinJGgDn8gtAXn0AKFnATo3xr1zNfeRY0/O7/NtPT3X8ydQHdAGVRXsqlY0qJiNk0XCDPSAB/4Gkzv/n5vfLqWH9xEaECJzEMwnaCbSLvBIWgTv2gObicercc9p2vDVp9LgBtxfuR0S7kK+wzWAECuCndtEhcBhsZDXP6pKu1roYVsKvrSL/sKuerwjeXbPNxKEW24cnbMN780csOYHbjTqaOOLWbDGeItOCPHb48zRojYo8jxTonLjPtTzrylNEdAZsVp55uUbfc35ozymeztWm5x79w7iaj4VMBdW5kUtH67RRuRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyxxnVHGyVUyGEeAl4pLcZWDC1v3XpxHNqWWr7IglOI=;
 b=X+kryk9ZsqKxecPHxd/TFoPy5oVHSc5BWWdcrugTOIldYH7avSGMEFuYpyB4LM8aVP+/9OIueXZ3ADh4FphXfSI4NhCPSojlKLsInMjiwBFYFmmNDjzHYQ43m4RVOwAeYtYzuJBQEfR6rt5sAQbJHVc2YomUpMZyF8JWci6/M6c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AM8PR08MB6498.eurprd08.prod.outlook.com (2603:10a6:20b:364::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 15:02:17 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 15:02:17 +0000
Message-ID: <36630a40-b6e6-4bf6-8fa1-1a004e0d2798@arm.com>
Date: Mon, 12 Jan 2026 16:02:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cpufreq: Update set_boost callbacks to rely on
 boost_freq_req
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, Christian Loehle
 <christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 Jie Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
 <20251208105933.1369125-4-pierre.gondois@arm.com>
 <14ad55ce-413f-46e0-9ce0-f35fc421056c@huawei.com>
 <73da1186-5edd-4465-bd49-e18d9064a501@arm.com>
 <ea9111b5-cd85-4526-a959-54d8037d6ffb@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <ea9111b5-cd85-4526-a959-54d8037d6ffb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0025.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AM8PR08MB6498:EE_|DB1PEPF000509F1:EE_|PAVPR08MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f30b9ad-6bf1-453a-85cc-08de51ebb941
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Sm1adUQ4c09qSlAyNDZYUXQrRXFJdGpHYjZ3akNjNEFFTysxU3RFY3poMXJI?=
 =?utf-8?B?RHlmU2x2YmNyVk1WTWRlZXJVczFpcU9GR0hvQ3lmMDFDSzVKVlVtSTNNSUFy?=
 =?utf-8?B?OUx3a0IwUUhUR0x6dE9zYjN0OS8vWTBodGZDclQ2akJTRW52azBOKzdnNFUv?=
 =?utf-8?B?M3RpMi92TWt2dEIyMjQwaG91NUlIYTJTMnZUK3ZRbzRjNkQxRHI0RUxBWnht?=
 =?utf-8?B?RjFJU3drbDgyVy9lNFhHYWRKemcvaEVYc1RUUy9HcGxpam9PS2k5MWlsM2p5?=
 =?utf-8?B?MmhqMFR1UGZVVTRXb0h2WURLWFI4ZnB3Y3BIVFJvZGNnblpCMUdVanRlM3ls?=
 =?utf-8?B?c0VLUFM5YVR4eDBFZlZ3U09ndG8yYXd6UXdGdjdmMkpScjE4N2grd0QyZW40?=
 =?utf-8?B?bjRWTTgyTHhtZWFPek1NUUlvNlB6MDB4d3BXdHcvTHBYWVRJcllmZ0tzZndz?=
 =?utf-8?B?eVNUV0kzazhMZ2dMNHYyMUdjd2JNMkpvVDdXOUlxWEdTd2h5VjJCWDkwUGJB?=
 =?utf-8?B?bGU0NklWcUhDZ1A2M0NwVE1nZmZUc2ZvYXNJMW0ycEJzSHVEb2ZrVE80NGxK?=
 =?utf-8?B?N1JRV3M0VXhzSGd5Unh2VENDYkhnSCtlc2U0VXFKUlV6UUIrWVlDWnYvSDUv?=
 =?utf-8?B?UXRBMWErL2ZEUWd4cFowQVY0ZFgrZ01KSVpoclNaMzIvcS85RXFFSHNxSmJi?=
 =?utf-8?B?dUtQbnoxZnJPTTNwN2gzMFdST2hXemhkT2xETVF6UTRzcGpLVFpFY0loUmV2?=
 =?utf-8?B?QmZCZlNlcWxDMThLdEIyWGpqNTg5Vmh4dmxCRnNIcFU2SktqOFdneE40bDln?=
 =?utf-8?B?ckZKL1JHMmJkQ29uT2tadU1IMzQySnNJK2xyVXZackRBeFhvSXFjeWZwM3FY?=
 =?utf-8?B?azBpMVIyNjdQVmdCVkpNb0JzM2k2aXFuelJVRjE2T3NnOGtSeitEV2VWS1NB?=
 =?utf-8?B?YW1UaHFPcFhFR2hYWTdxSlJ4bDBMQjVnRTVzaDRidERna1dRcnI1bHZXUEgz?=
 =?utf-8?B?V2tYN1RsZ3kxZFk2VnVGcjFVWmZ1Q1hqaE8vV0Z0eGVmc0VvMzV2NHFRR255?=
 =?utf-8?B?SllMOFF4Y0NPSlJYb0c1THlxc3ZkVjZyQTljbkFDT1JlcTdjelZ6VFd4ek5Y?=
 =?utf-8?B?aUlERi9CZ3BoNk1nV1lldTJVOTNVRmZUUXNGcXY1THArTThWUnNmS2lkUUVx?=
 =?utf-8?B?MW40UUtqcXlNNzBKZEFSZDdsRzFaRGptb0JPMlFtS0VvSUhYQkI5aFhON0c0?=
 =?utf-8?B?Mk92d0lLRm5rWDVUY1FKMUxHenkvbGo1TWVPTTAyMzJ2UklnMHVBTjNtY0ZL?=
 =?utf-8?B?V0V5dy9KUDZTVmZ6VjZSN1hKbnM2a0sxMUdpTDRSOHNWOHNZZEJLVHVyOUQ1?=
 =?utf-8?B?RzVuZDhXcWtJWUNldFNLa0R6UkpoQjdhR3IxaGFRNllCVzVZbHhmdEdueld3?=
 =?utf-8?B?UXV2N2RxaVo0SVN3UzRHdTRaS2FUU1ZEaEYwUFB0cnhPVEROZUdYVjlIK2Vv?=
 =?utf-8?B?aVQxV3gxbkhCcjlWMjNOU3A5SmlnVlRPSkowTGtRSytuWWVqNEVWSFRCTDFz?=
 =?utf-8?B?eEpEQW5maXJpempROWkwVE5iR2o3aGJIOUlvWVZxTWlBYW4zdTI0b1hFUUVl?=
 =?utf-8?B?dkU1dXRBZDdIdTR3NHkyR09Qekl6c1dkY0pKSHpyRmdoRHpMNC92NWRpUWRp?=
 =?utf-8?B?M01kWG0rZzlNU2xJaXJtazdUZGFPUjI4UUROQXlKeUpxRGxIWVVFVkNrblRo?=
 =?utf-8?B?QWJRaUoyZkNzWTBTYm5mRWpSL1FNd29vZkJ5K1dub2xHdUE1OFMxaG0yVGtl?=
 =?utf-8?B?NzBoMnhWdGtvbFE2Mk0vOTYxdzRKd1ZLTFpjalFQdksrUlBRR1FRa1M0aERG?=
 =?utf-8?B?MCtjSjZuQkp5RnVTaTZXMk1hMEVLWXFlTkszcHI5MVhjNEw3NURtZjVIa0lI?=
 =?utf-8?Q?LDYitvkuq1620twHRFp1Ab6QbcDz0uSY?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6498
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ad562eea-cc66-4d8b-d6d3-08de51eb93ce
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|35042699022|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmtFbHd3SHBwVDBKMnlieWxqQjJHS1hMVkZaNjVUTm5Xdm12N2FpcG1Dc3lT?=
 =?utf-8?B?ZUhyZFdZVG42dHZNMFRCMW1RcWZCcmFQaDlsRWU5emJnbkZzRTdJcUxiMzkx?=
 =?utf-8?B?bFM2cVU0Nm9UazJWYURVakdLbHEzdmJmdERxemFWSVRNeFBmc0pSaVR3ZXJj?=
 =?utf-8?B?NGcwQVVyZnBlcnlCQ1VSSWtvR2dFelFYMmlua2xSaXJMdm1pUDRha1FsRTlu?=
 =?utf-8?B?ZnZlZVcwYTZXbERqVjZRZUFua3cwaGRrRCsrVXV3UFlKeFJBMzdQbXdvMUl2?=
 =?utf-8?B?alFrd3N1ck9DMFhWbjcwUVFZVlhOdEpLVWh1SmZxRDBRU1grcFB6YnpnTkoy?=
 =?utf-8?B?MmRPMWRKWkRyL2lVbytTcHNyMy96SzhQRHRBUmtJVXF2ejF3NGRyYTRaWm0v?=
 =?utf-8?B?ZDh6d3NlWnUwdFZDVnpIWTBHM0xRaVZwQXQ3bHA0VjNTbVppNGxzY3B5L0No?=
 =?utf-8?B?YVdTOWxsYWVDV0h1MUdKVDcyejZwTkVTMmRuT3FjWi9tNXgySEQ2UC83c01Z?=
 =?utf-8?B?NXFuTStRcXNaQVdyM1FKQzNZZFJYRTRSQmVuQ3hzTFNmRFVIMWtPT1l4MU8x?=
 =?utf-8?B?dnJvcG1nTzBXRUpSMVo4bDREVmhidlVtSUtQUWtTRnJwVUhhR21CREYrYmZV?=
 =?utf-8?B?cE5LSDZVai9wSExnRmNXcmMxM2x2ajhrczREN0pkOGFIbmpONkcyZ2F0b01R?=
 =?utf-8?B?eWpvTCtVeVkvTHpjeENCeURoSWFLWjJROXJOejd2L3JLd1FNdllGU0FwaHB0?=
 =?utf-8?B?OEs3V2cyeG1oRERvSW5hZlJTMUNGN3JlSEtIU0MyK3p6YTExcndVYjZQWmFR?=
 =?utf-8?B?bUJBL2FMOEZXUWsvSVBQTHVGcklzdGR1WHhZMWo5amJ0Q1ZaWFlhYUNadkFh?=
 =?utf-8?B?TVB2THBJTHpIbitTMWQ5T3FWdDU2OUZVSVcxSmEwb2ZhRjJHY1hoeUJCaGhZ?=
 =?utf-8?B?MFJlaTFBdFRGTFIrcUhTVDFzQUE5RGc1dloxY3hKTkpsZUJYMjk4cUU3blBJ?=
 =?utf-8?B?M0lxUDc2dFQrN0tRaG1FQWxNSEtkR1JCYVdDUjVsMExoVDBLNithaHdtT0NY?=
 =?utf-8?B?dGRiWTMxOXpjOVkyeVorTmVSQWlCOEtQaXpxWm55clFnRjVjZEpQQ0c0N09K?=
 =?utf-8?B?dW9qdTQrL0FTSXRDbjhqd2RjOFRBcURZWVdDN1lxQ085cjZJRkRsSlFJYStJ?=
 =?utf-8?B?c2MzY1AwSXJ5T0NJQWxRVkYySkpLSGUwdmRmSm5Ka01rUm5kOU9yMUFXT2ZB?=
 =?utf-8?B?bHZobmlzMXlCN25wS0dIeDVieCtYS0tvMmYwVForTU5aeWh6c1hFNzFuSy9Q?=
 =?utf-8?B?Vm9UcTd2TGNuYkkraWt1bzN2Rkh6amlPamUzblRhcFhDZ2pkM01xcXY3L2pH?=
 =?utf-8?B?dWdoNlZ5YzdrdTlmT2Z2bGZucTB1NUdxeWcvNEFHNTJ1R2lSZFZibDFXL3lY?=
 =?utf-8?B?UDRORFZEOVdWeGl2VUF0c3pqdm5sQUYyYnVyaEtlRDl6RTBGZ0lHZ2QwS0RM?=
 =?utf-8?B?Vi9LanNXNXNoRlNPYnl1VUtvUGpWcTZSbUw5clBLNFpFTEY0T3dVYkY3WTRx?=
 =?utf-8?B?cFhkc29TZUIwb1owMnpjMlJJT2JDRmhCYWhGSTJtMmVkVWlKWEtOQTA3STRz?=
 =?utf-8?B?M0dTZU1HUWZJUUhrOVR0UHBZWWFIWDJqUDdHNWZqYVNCeGNnb2xNRlJUMitn?=
 =?utf-8?B?L1krRVFJRWlDQnlJWE56QmJBZUh6MGFoR2VNcmxkclpEQ3FJeW5TNkpQcWx5?=
 =?utf-8?B?bjN1aUZJUjdqRjY3bHhvRkNhTG8remRtWGs4SWRLV0VHWGp6eUp4aE1KMHMy?=
 =?utf-8?B?ZUMzcllBYVRFZGQ2Qm9rOVkxTkEwWGZUL1RqZWdPZEdvZDVXVzFIc0YweXA1?=
 =?utf-8?B?YmNjZlp1ZUlRYjJoRGM0ak5KUTh3UHBuL21CMzVxSTVIcGZrM2hKS0F3UDZt?=
 =?utf-8?B?a1dpQjVzWlgvY0FWRWNoaWliNFllUlNRY3cwMW91RnNudTdMSUdVSG9yemV5?=
 =?utf-8?B?SWdVMmkyZXhKRXlPd204QUduU0VHQzM4aWRKTENrKytFemZPSC85YnRrT0pF?=
 =?utf-8?B?Szltb3VIRGVqOVc3UG4xeDd6K3VYdWpsWXNlVVF3bWw0U0hGNEowMm9jZitx?=
 =?utf-8?Q?4+Fs=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(35042699022)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 15:03:19.9300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f30b9ad-6bf1-453a-85cc-08de51ebb941
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9651

Hello Lifeng,

On 12/23/25 09:15, zhenglifeng (A) wrote:
> On 2025/12/18 0:22, Pierre Gondois wrote:
>> cpufreq_frequency_table_cpuinfo() can effectively update
>> policy->cpuinfo.max_freq, but directly setting policy->max should be wrong
>> as it bypasses the other QoS constraints on the maximal frequency.
>>
>> Updates to policy->max should go through the following call chain
>> to be sure all constraints/notifiers are respected/called.
>> freq_qos_update_request()
>> \-freq_qos_apply()
>>    \-pm_qos_update_target()
>>      \-blocking_notifier_call_chain()
>>        \-cpufreq_notifier_max()
>>          \-handle_update()
>>            \-refresh_frequency_limits()
>>              \-cpufreq_set_policy()
>>
>> FYIU, we should have:
>> - max_freq_req: the maximal frequency constraint as set by the user.
>>    It is updated whenever the user write to scaling_max_freq.
>> - boost_freq_req: the maximal frequency constraint as set by the
>>    driver. It is updated whenever boost is enabled/disabled.
>> - policy->cpuinfo.max_freq: the maximal frequency reachable by the driver.
>>    This value is used in cpufreq at various places to check frequencies
>>    are within valid boundaries.
>> - policy->max: the maximal frequency cpufreq can use. It is a resultant
>>    of all the QoS constraints received (from the user, boost, thermal).
>>    It should be updated whenever one of the QoS constraint is updated.
>>    It should never be set directly to avoid bypassing the QoS constraints.
>>
>> Whenever a cpufreq driver is initialized, policy->max is set, but the
>> value is overridden whenever the user writes to scaling_max_freq.
>> Thus we might think it should be replaced with a max_freq_req constraint.
>>
>> However if boost is enabled, the maximal frequency will be limited by
>> max_freq_req. So at init, cpufreq drivers should set boost_freq_req
>> instead (to policy->cpuinfo.max_freql).
>> That way, if boost is enabled, the maximal frequency available is the
>> boost frequency.
>>
>> ------
>>
>> Summary:
>> -
>> policy->max should never be set directly. It should only be set through
>> cpufreq_set_policy(). cpufreq_set_policy() might be called indirectly
>> after updating a QoS constraint using freq_qos_update_request().
>>
>> -
>> boost_freq_req should be set for all cpufreq drivers, with a default value
>> of policy->cpuinfo.max_freq. This represents the maximal frequency available
>> with/without boost.
>> Note: the name "boost_freq_req" might not be well chosen.
>>
>> -
>> Any update to policy->cpuinfo.max_freq should be followed by a call to
>> freq_qos_update_request(policy->boost_freq_req).
>> This will allow to update "policy->max" with the new boost frequency.
>>
> Hi Pierre,
>
> I now think we might not need to add a new QoS constraints. Calling
> refresh_frequency_limits() instead of freq_qos_update_request() when
> setting boost might solve your problem, since cpuinfo.max_freq is already
> used to limit policy->max in cpufreq_set_policy().
>
> What do you think?

In:
cpufreq_set_policy()
\-cpufreq_driver->verify(&new_data)
   \-cpufreq_verify_within_cpu_limits()

the requested min/max values are clamped wrt the cpuinfo.[min|max]_freq.
However this clamping happens after the QoS constraints have been
aggregated. This means that if a CPU has:
- min = 100.000 kHz
- max = 1.000.000 kHz
- boost = 1.200.000 kHz

With boost enabled, the user requests:
- scaling_min: 1.100.000
- scaling_max: 1.200.000

If boost is disabled, we will have:
policy->min == policy->max == 1.000.000
without notifying anybody.

Ideally I assume it would be better to prevent the user from disabling
boost without first asking to update the scaling_[min|max] frequencies,
or at least detecting this case and have a warning message.

It would be possible to detect this case in cpufreq_set_policy(),
but I m not sure it would be easy to act on it easily.

Please let me know if you prefer not adding the new qos constraint,
I ll try harder not to have it if yes.


