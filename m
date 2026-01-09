Return-Path: <linux-pm+bounces-40563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7D2D0B93F
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 18:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 993223002FEC
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC76336EFF;
	Fri,  9 Jan 2026 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nre3ymdm";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nre3ymdm"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6B364038;
	Fri,  9 Jan 2026 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978811; cv=fail; b=gM5ggeeAQFj3vSIwmX2VgUGGSx+YdsC54plOyikPekpEoIPgDHngbFjO2QzAhrPYPcHze/KWGyj6oSJcv531rr2XsD9wS7ZbS/8kmTlf/lQc2UJ3vU8LRccE356vLeWvKE+7OA1ZuWZMNgd00/DrYrxIQa5/d+o2e/P3+/jbSVk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978811; c=relaxed/simple;
	bh=+e6oQOvE0wyGDboyXcGZ0NQLDq9CGwW3bKDGOGiwSDI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nwH72J8IDXVXGemNtFOmJuqwMzC1GWdwJILVgMbjgmBocyxDJdDFwawSzDDzcanOF01JhLM7Z16CbN9FhXTwRCUkRSd6vy0Rdf7LTpWIxpDR4CXeOjfum0Lhmf/sgIZuhZEI0nF/mA1rHcPfMeBNaYur0EN6eKwQ04TE4HI6wF8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nre3ymdm; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nre3ymdm; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KDZ7R9Cq5XeR/dbiZhjaIGLlOyHDPmkND4ldY1G7tj8WE7TBRuK8GjNGEzv/ZRlWtBp4Bg4d3nM6aqlm3q+KZ36RGLqN6xDoLyNdXDvijpEcH2geYgSOXfcOTiyKazbAmH+Njxv9CNFQEdEH2x2ldMvlMvxDI9JdT3PVAJdgEyMirf9AVf+Okepfz72UnUpujFN7ulAo9S/LuhKtQfOELuphtqwryIgYN4RRrhm2WI6cyB2fS9aQBii4p/y+G6YTcQZ8ZEToaDT5xZwwotiTeVKfwTcAcb2scWGlavnBeCjJu5ioOZvne8trrweA10NmnoKYo4PrYODVTyUHjlFSDQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hM0ttMoGgr5J66IY0UmbJ/iLgvPVS2FsG/AmMZ+1xnY=;
 b=w1MwDfmMeyT9TFehhpEZMJv5z0o60EPbbSCHnQ6Vg4cAkDT+1qGYJYz37wu0ToKR0tLE1d5SoAc6nYltNR329wTY/jxYj+j6ZJijlEPnlFuuGtKN/JGh7mmdBPoO018NwWq1+0F+WH7MSzeqebxCbrpBXRmBma70445IzDs2Cl+Snoaa56+I0tocoK7DFxkuzZfc/RcS9QGwMzVjY4H8fiAxV8eKEOyoMmF5BEZnNBWkEwws6XnvrEATzkjArXjWYGxc8UoDoIEX7j4Lq28QgAil31pEm1qnHyDjhzqcFtjXC16OBb0aWrE/KmNRYEXncmYHBCF3AkxMgZKqGcd98A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM0ttMoGgr5J66IY0UmbJ/iLgvPVS2FsG/AmMZ+1xnY=;
 b=nre3ymdmzEjpYhOaGX0/93H7LPbRc2/a2pbMbR0+LPfj+7vn1RJX2tySP6FmAupjhfSZVITtJCx0ew0iwD6HJmi+BVt4cpqSRAbat13+SjENQLP+lWRUKJ2ibSPbUJ1OULNePLgOkdULJ40PTK+b1vcgcRNIyPu+RIS+WlfcOTI=
Received: from DU2PR04CA0288.eurprd04.prod.outlook.com (2603:10a6:10:28c::23)
 by AM9PR08MB6019.eurprd08.prod.outlook.com (2603:10a6:20b:2da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 17:13:23 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::5d) by DU2PR04CA0288.outlook.office365.com
 (2603:10a6:10:28c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Fri, 9
 Jan 2026 17:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Fri, 9 Jan 2026 17:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4vsiK0QhDe9C3UlLHAra7G01evdWstR+aDavpX2AZuLE52+0H4ssLN5xwSb3+IkShTvL2/cGiX6fEwVv7z00lcQQulM29aT4RHJ6zC31gOX9LD3EbpiJkLCU2uIVokw9r7HMsyg5EiNb2CTNDWq6ozsZcdjulXJ+CExy+g40XjzAnpE2v59XIs4Jrow3RrpV3A0cTaOgncTGNChcwM74vbHQ8TXM3bxo/U8/qDWVs91RiFPFT9Mt/42waYwneB2RkwZHfc03LNgWH4Vo1tGmHwYUl8N8dZhqISOyYvLv4N0wMZyM/CpqeOBSJFDs8K99CBPghDjLKhkSEpmDUbFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hM0ttMoGgr5J66IY0UmbJ/iLgvPVS2FsG/AmMZ+1xnY=;
 b=m9KuNCo46MHy2Mi9PKnT0cEOPztFQL3it43rzxUO020Ivq1aYRU5oLDcvuD0CHgVhn2yNn2U6S7r1zuE3YFK7Pq6Zwpo4+q9ou0VDcFiDHF3ZDQYOgoDQscVa+1NDPkvk7dFKYEqmXT8t/8SsLWLnaqjFAaERvdxrwzdI9v5PSr+dvqs2FHdAxeqFeVpr5FpbxiN8yn/rSamrfIIBdjlEcMXBEA/LWthNkKjLyuVbrJrDkgwLKNKB/b3CvOJcO+GeiAxgZZx+Du9E4o8Nhc0ntYAEvhjnjMMfdgbtuNWOfi3/c/GfFO0Pok4xgeQUAfvO1eN5FSnYRJyxVXlO3IZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM0ttMoGgr5J66IY0UmbJ/iLgvPVS2FsG/AmMZ+1xnY=;
 b=nre3ymdmzEjpYhOaGX0/93H7LPbRc2/a2pbMbR0+LPfj+7vn1RJX2tySP6FmAupjhfSZVITtJCx0ew0iwD6HJmi+BVt4cpqSRAbat13+SjENQLP+lWRUKJ2ibSPbUJ1OULNePLgOkdULJ40PTK+b1vcgcRNIyPu+RIS+WlfcOTI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 17:12:19 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9499.002; Fri, 9 Jan 2026
 17:12:19 +0000
Message-ID: <c24fe564-e650-4f39-88b0-43399398b61f@arm.com>
Date: Fri, 9 Jan 2026 18:12:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] sched: Ignore overutilized by lone task on max-cap
 CPU
To: Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com
Cc: rafael@kernel.org, qyousef@layalina.io, peterz@infradead.org,
 qperret@google.com, sven@svenpeter.dev
References: <20251230093037.427141-1-christian.loehle@arm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20251230093037.427141-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0069.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::7) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS8PR08MB6646:EE_|DB1PEPF00039232:EE_|AM9PR08MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c05e37-d0f8-46af-42ab-08de4fa264c2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?eFBrcklpc2llYk1lTWhRQWFmT3ozTVFFdlAwNzFuTUd6Smc1K0xCa3N0ekxw?=
 =?utf-8?B?Y0w4MXBBMWFhSXdQSGdnTzhpZ3RNWE9JOVJKNXFIQldrWlY2M0k4YVYxZVh2?=
 =?utf-8?B?SWZhRzVlR3h2QWt4NElORUMzckRGbUtkRUNDT0U2OTB6WWcrQ21XRDhqdmFl?=
 =?utf-8?B?YXI0cWllcW1CdktmQW1rUlZSa2s3Z2pBVWZRQlcrNlRuZVJFWHhrWFM5ak9Q?=
 =?utf-8?B?S0ZCUmNlcDRybDJHblNrSTYxQTk5VllYK2NUYWMwa0lIb1lsbEFuanlZb3Mr?=
 =?utf-8?B?RlBJQlBBODNob1RTa1hsdjFRandHek5FRzVWRFdqN0NvYnpoUndRRkRvZWdu?=
 =?utf-8?B?blI4cG0xWXpnVXpqR3JMOGRZaUYzZzg3N1RJN2N1Mmp3K1NNUy9IQUJuUEdp?=
 =?utf-8?B?cU5sU1g4SW5hMW1iVmg4NUlDTXdMa1Y2aGVwKzJxcG55Z3dCUm44V05YbC9h?=
 =?utf-8?B?ckF0WEJKVVk0dFZQVFAvYTJSODdpaGVYYXlEUlFUWFJQNjJocjE4bkd4YnJs?=
 =?utf-8?B?ZUlMak5QWHc0WDZlcmUyMzlSemxzdi80eERYMHo4WFU0UEFOWGRWL2g3UnpJ?=
 =?utf-8?B?M01qTE56Q3VxUFlGbGk5NVdpZ011WlAvWE1uOEl3Z2RQMVZrTnhwVSszS3pz?=
 =?utf-8?B?WnJxSk5vclVuVk9ZUXJnUUZReEZ0KzB6U1JEN1RDRVFEbkFIZkZUNDhYbW9T?=
 =?utf-8?B?SFhacHo4UEZuR3VDbzN0RlQyb0hHb2JhaEQ4cEhkL3hQdXlpN3dkZGpkS3Mz?=
 =?utf-8?B?S04rLzhZMWRRRlJnQ1pjTzJVT1Q3dkt0NGZ3V0RHZng1bUtZM3paaGI0M3FW?=
 =?utf-8?B?RFVxcjNMeXVRbjNLaTlxRjUvQjJJUlhwTm9wSSt6U0dlSkV3QjlCSnNOcTRL?=
 =?utf-8?B?N2ZGUXJzQTM2Ni9BNHpjTWNLL2dYYjNwL0swUVhmOHJyZGw1eG9MY0MzVXRO?=
 =?utf-8?B?aVd0azZKUEdHRUxDTVVpcTQvSVpMeXA4WWl4V29sQ2hRVnJJb3p4WmxWblJS?=
 =?utf-8?B?L0FCSndHNDYydlY3UkpnSWxGbU9SRFdRdVBVRHIxRldHaDFFUE5sTnNzektT?=
 =?utf-8?B?YTRnMDlmRTNjVmJYeUNRak4rdDZzckdaM25YVnJnbHhvb24rTzFFN3ZWNjlu?=
 =?utf-8?B?bDVhUlJ2T09oLzE4STkxU2J6NWVWZ0RXdXBlcmRYQlNKWnFjOGFYK28zNG0r?=
 =?utf-8?B?ZTZWY2sya2k2ZTVrNnhmMkxWTyswOFpjdXVSckpRdmViWEJUdHZQbjJKNTNn?=
 =?utf-8?B?WFNiVVprVllwL0tXSE9LZkVXbFZnSjJpN0EvL29PdHJjMTI3WFBBckpuWlBz?=
 =?utf-8?B?bno5TjA3dXpuOSs1MENGenYrVmc2R1VpaksrWVFzK0lENDlOWHd1SGJ2akg4?=
 =?utf-8?B?dzZpSDZmNFFDalJnUGdWeTJCMjdrMUMrT3hOUVYxOTkwODUzYXlQWXRCWkFm?=
 =?utf-8?B?UUIvQmwrcEhucGl4MEtEZ0pQbTVSVU1XbllsV2lWMFlZaWVhZ2ZjYXJFeXNV?=
 =?utf-8?B?TWtTcTAvV3d3OU5TQ3pUZThWcEVtdkl4OXdXTGJmNGo3N3VGMEpPNm5aMy9o?=
 =?utf-8?B?amNsbTV4YUJzdk9WYTdTYzk0eVZNLyt4aHpYV0JCVjVhSVVkZlUxcGcvOXAz?=
 =?utf-8?B?MUxoUTFNOHhoYlBld0ZXaUNsY0VjMEF5UFdBV1N2YjZnZ2hhVnFyalJRd2NL?=
 =?utf-8?B?UnNKY1NIdDVLaWkwT0pLQnRNQ3RRVWtFQ29ibDBHNEdYOTYzRkpOeUFhSmlW?=
 =?utf-8?B?MUNvTFpHOEI2ZXFLSWNLdXdxdzFNbGp5elZ4NDBGM1hqalZPblppVTJzU21M?=
 =?utf-8?B?Mk5BdlprUDVxYUJYTjRneUx5cGxFQlF6Q3p1SEd3WTN3VWJCM2E3M1ZvKzJo?=
 =?utf-8?B?RGhPUnFNRlB2ZlE5M0Q0WXBCckRXRnVhbGtHb1diMEZmRmo5ZjJCQ1dVbnhq?=
 =?utf-8?B?S0s5RUlhUTl5Zk51c1E1S1BQM0lEU05hMmxGanMwSlF0YldkRnozL1I0MU5P?=
 =?utf-8?B?UDdGeW0xZ25BPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6646
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	391620ce-fde4-4977-5b76-08de4fa23f13
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|14060799003|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEQwMmNRYlRlZFRHN08xRlVVdVBKTzB3WXdPQ1l2Wkl2eUt6NWxZOGtGWUVT?=
 =?utf-8?B?UGJkTy90WkpBendZMjdSZG9vWVJFenVNeElKbWsva2ZWUGRFa0U0c3pPSFNR?=
 =?utf-8?B?TUk2V2t1R3g2VVVPYXYyeWV6bExIRkRpdS9KQk0rSU5JYmlhMlhUd0VEWkpv?=
 =?utf-8?B?SDk5bGR3Uk9OOHFaWFJNQ1NYTTFacjVYdG54ejRydjdqdTBjQWM4RFkxS096?=
 =?utf-8?B?OHdPT0RQYVZEZmtRYjFzaVBuUWR6VG1MRCs0RU5Pd1RJL1FkNlA0OEN3eUJT?=
 =?utf-8?B?bUtad3FPUEVrRnF1VTJqWmp3NEFjTndGaktvWE15blN1ZjFwcldBMFpjN0xh?=
 =?utf-8?B?akgvOHRRQWZzOGJhenlJMFRGTmJOdzk0TVlBN3dvSmhFcENrMTJabGQ3ejVs?=
 =?utf-8?B?TXRqN3J2ZlUxS25TUklYeklTYlFCWmVSQlhYYkdna2hLOTFKTmpJK3JEcVFm?=
 =?utf-8?B?UVN0TmpJN0ptOU9OdDRxY3RwK1Vld0ZTUGtVWEluNFdZcXZ3VEdWdWJ4bnZJ?=
 =?utf-8?B?c05oNEtyNzlCSklidmFlYlRkSEVTNW5ONTdKNzEwYzVBd3U4L05sZjBnNm5W?=
 =?utf-8?B?Zkh1Y1lRWlNFNkNJS091UGkrVnlNN3NjTDBVUDVFcGN6ZmxpRnRRaGltczJh?=
 =?utf-8?B?cFhmby9ZdDB1WHI2ZFhXVWNpa3lIVnBFNFVsTmlSU0ludTd5NHNqUkplRHkr?=
 =?utf-8?B?Y2hidHZGajNvK3JrZ2F1MWRNNEZ5NzRLd3FYNHl4dFkyWmJLNHNmTVVXd3RR?=
 =?utf-8?B?K3p2N3QwekUwbmo3ek9OLzA3SEl6OEVEcXpqaHVIcXZCVnR3cnhoZFdqR2xK?=
 =?utf-8?B?dU1DQ2I1ajl6RGl4Z3F2WEFiQ0JlMVEvdDVLaHlnbzJCSEtFQ00zK3VrRHZx?=
 =?utf-8?B?S1VoOVgwb1FFc2VrR1QydC9YYzJ2TDlhd0F6NjRIanFMeVBmcTJiZlpXTFla?=
 =?utf-8?B?ZDh2NzlTWjMxdDNNQ1dONDNuUFl4MS9mQ2lveUZaZzYxQUM3Smt1SzF3WlVh?=
 =?utf-8?B?WHdDdW00L2ErWDliWWZQZUN0WThtRTZnamxQbGJDSlN3SlFVZHVFY3JCbStz?=
 =?utf-8?B?bkg0cG9hcVR5OWkzUUFKMmJXcUN3THA3K2FBTXVGRjBuTFQwTmdBVThqNHhx?=
 =?utf-8?B?eUVobVVEdjJIYzcwblphcGpHdk1lQjZhYk9RRVZVekRJTEVrVnZiYWs5djh2?=
 =?utf-8?B?enBZcjVoTkpJaUREbnl6TnlEZFNlaVpHQnhKbSs3b3F2TU1hYk5DZ0ZyeWJh?=
 =?utf-8?B?SjlvUnVjT2ltQzh6djdqYVNkR1pGQzd6TTgreTJscCtnZUFhUjhGekIrQnJW?=
 =?utf-8?B?Y2NoeFVwKzlSY2FqUDlCdURlYW1mV1BGM0pOUXVURHA0YlhTSy8wNnhaeG1v?=
 =?utf-8?B?cHRZOExDSU9DRjNNUm5QUkhTdDhjcUV5UDNoYXlrRzdSU09XSXdjZ09kNHZZ?=
 =?utf-8?B?Q1hOcU9MWVh1WjQzdnBxNFplMEpFVkpEM2dPZXlVaHZibmJpUWFSMTdaWFBG?=
 =?utf-8?B?MUtueGFBRjA1SysybjNOZXBnSWFaRmlOYUNlemJzcGIrZjZIalhiZ0NCemN4?=
 =?utf-8?B?TUNabnpqZmFlR1FDYmpKUGpYWno3WW9PTWYxTWwvTGszQUwzejRVeDBjc29x?=
 =?utf-8?B?aklFbGV3MEwyZ2svSFNtOU5ycCtTRXJyZ2h6VEZBSGhxWnRia25jNDdtRXRX?=
 =?utf-8?B?S2hnME9ZZXpEenVaMk1EUzFlaFdGd0NnYlVRTHI1aG5kTGNjeXVCbnFOZlVm?=
 =?utf-8?B?WjRMczlqSUo1alpZLzZwOFhJMWdPL2t4QlZKcVozU2xBdldBaDFaQzVEU0pv?=
 =?utf-8?B?U0tMZWdlbXlXalNTSHNUajRaZUZSUWtvVXlHK09ldjlIS2daeUo1dCtHVkRq?=
 =?utf-8?B?TkoxL1E1S05NRHdWTFF3NzBvNlJhZ1Q0SEIwcWEvcFBWMXJDcGd4Sng2TmhY?=
 =?utf-8?B?MXp5V09KTDNLREdHNFJVSXZSdU9hVXpVVWJ2NkR3R3pyWjJ5ZmJxZThvY2Qv?=
 =?utf-8?B?L29Wc2FNZUFDT2NlaFNDaW5BNlhsZkVNVFY4VDJsU3BIUTBEaFB4N08wUU1h?=
 =?utf-8?B?VXdVSnpOUVdYdGhoUHc0b2ZnTTZudGFyQUJmMEZ6WVVpb01DeGtWSVNSSGQ5?=
 =?utf-8?Q?00jV4IWyWMsXBeYwDNPHlGIYS?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(14060799003)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 17:13:22.5846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c05e37-d0f8-46af-42ab-08de4fa264c2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6019


On 12/30/25 10:30, Christian Loehle wrote:
> I'm trying to deliver on my overdue promise of redefining overutilized state.
> My investigation basically lead to redefinition of overutilized state
> bringing very little hard improvements, while it comes with at least
> some risk of worsening platforms and workload combinations I might've
> overlooked, therefore I only concentrate on one, the least
> controversial, for now.
> When a task is alone on a max-cap CPU there's no reason to let it
> trigger OU because it will only ever be placed on another max-cap CPU,
> as such we skip setting overutilized in such a scenario in a careful
> way, namely still letting it trigger if there's any other task or the
> capacity is (usually temporarily) reduced because of system or thermal
> pressure.
> On platforms common in phones this strategy didn't prove useful, as
> even one such a task would already be the majority of the phones'
> thermal (or even power budget) and therefore such a situation not being
> very stable and continuing to attempt EAS on the other CPUs seemed
> unnecessary.
> OTOH there are more and more systems (e.g. apple silicon,
> radxa orion o6, x86 hybrids) where such a situation could be sustained
> and there are also many more max-cap CPUs, so more possibilites for the
> patch to trigger.
>
> For further information and the OSPM discussion see:
> https://www.youtube.com/watch?v=N0tZ8GhhQzc
>
> Radxa orion o6 (capacities: 1024, 279, 279, 279, 279, 905, 905, 866, 866, 984, 984, 1024):
> Mean of 10 Geekbench6.3 iterations (all values are the mean)
> +------------+--------+---------+-------+--------------+
> | Test       | patch  | score   | OU %  | OU triggers  |
> +------------+--------+---------+-------+--------------+
> | GB6 Single | patch  | 1182.4  | 26.14 | 1942.4       |
> | GB6 Single | base   | 1186.9  | 71.23 |  573.0       |
> +------------+--------+---------+-------+--------------+
> | GB6 Multi  | patch  | 5227.7  | 44.11 |  984.5       |
> | GB6 Multi  | base   | 5395.6  | 53.17 |  773.1       |
> +------------+--------+---------+-------+--------------+
> (OU triggers are overutilized rd 0->1 transitions)

Not really important, but having more/less OU transitions
should not be a criteria right ?
If the goal is to use EAS as much as possible, it would be
better to compare the number of task placement decisions
that go through EAS between the 2 versions.

(I think the numbers are convincing enough,
this is just to discuss).


> GB6 Multi score stdev is 43 for base.
>
> RK3399 ((384, 384, 384, 384)(1024, 1024))
> stress-ng --cpu X --timeout 60s
> Mean of 10 iterations
> +-----------+--------+------+--------------+
> | stress-ng | patch  | OU % | OU triggers  |
> +-----------+--------+------+--------------+
> | 1x        | patch  | 0.01 | 10.5         |
> | 1x        | base   | 99.7 |  4.4         |
> +-----------+--------+------+--------------+
> | 2x        | patch  | 0.01 | 13.8         |
> | 2x        | base   | 99.7 |  5.3         |
> +-----------+--------+------+--------------+
> | 3x        | patch  | 99.8 |  4.1         |
> | 3x        | base   | 99.8 |  4.6         |
> +-----------+--------+------+--------------+
> (System only has 2 1024-capacity CPUs, so for 3x stress-ng
> patch and base are intended to behave the same.)
>
> M1 Pro ((485, 485) (1024, 1024, 1024) (1024, 1024, 1024))
> (backported to the 6.17-based asahi kernel)
> +-----------+--------+-------+--------------+
> | stress-ng | patch  | OU %  | OU triggers  |
> +-----------+--------+-------+--------------+
> | 1x        | patch  |  8.26 |        432.0 |
> | 1x        | base   | 99.14 |          4.2 |
> +-----------+--------+-------+--------------+
> | 2x        | patch  |  8.79 |        470.2 |
> | 2x        | base   | 99.21 |          3.8 |
> +-----------+--------+-------+--------------+
> | 4x        | patch  |  8.99 |        475.2 |
> | 4x        | base   | 99.17 |          4.6 |
> +-----------+--------+-------+--------------+
> | 6x        | patch  |  8.81 |        478.8 |
> | 6x        | base   | 99.14 |          5.0 |
> +-----------+--------+-------+--------------+
> | 7x        | patch  | 99.21 |          4.0 |
> | 7x        | base   | 99.27 |          4.2 |
> +-----------+--------+-------+--------------+
>
> Mean of 20 Geekbench 6.3 iterations
> +------------+--------+---------+-------+--------------+
> | Test       | patch  | score   | OU %  | OU triggers  |
> +------------+--------+---------+-------+--------------+
> | GB6 Single | patch  |  2296.9 |  3.99 |        669.4 |
> | GB6 Single | base   |  2295.8 | 50.06 |         28.4 |
> +------------+--------+---------+-------+--------------+
> | GB6 Multi  | patch  | 10621.8 | 18.77 |        636.4 |
> | GB6 Multi  | base   | 10686.8 | 28.72 |         66.8 |
> +------------+--------+---------+-------+--------------+
>
> Energy numbers are trace-based (lisa.estimate_from_trace()):
> GB6 Single -12.63% energy average (equal score)
> GB6 Multi +1.76% energy average (for equal score runs)

Just to repeat some things that you said in another thread:
-
for the GB6 Multi, it should be expected to have a slightly
lower score as CAS gives better score in general and EAS runs
longer with your patch.
It is however unfortunate to get a slightly higher energy consumption.
-
The focus should be put on GB6 single where the energy saving is
greatly improved

>
> No changes observed with geekbench6 on a Pixel 6 6.12-based with patch backported.
>
> Functional test:
> Using the above described M1 Pro I created an rt-app workload [1]:
> Workload:
> - tskbusy: periodic 100% duty, period 1s, duration 10s (single always-running task)
> - tsk_{a..d}: periodic 5% duty, 16ms period, duration 10s (four small periodic tasks)
> Target system: 8 CPUs (0-7), 2 little (cpu0 & cpu1), 6 big
> Metric: per-task CPU residency (seconds) over the 10s run
> OU metric: time spent in overutilized state / total time; Number of
> OU 0->1 transitions (triggers).
>
> Case A Mainline:
> Small task CPU residency (s), 10s run
> task   cpu0    cpu1    cpu2    cpu3    cpu4    cpu5    cpu6    cpu7    total
> tsk_a  0.124   0.000   0.000   0.000   0.035   1.791   0.492   0.001   2.444
> tsk_b  0.002   0.000   0.500   0.000   0.000   0.001   0.004   0.000   0.507
> tsk_c  0.000   0.000   0.000   0.000   0.001   0.000   1.895   0.630   2.526
> tsk_d  0.000   0.389   0.001   0.000   0.450   0.000   0.000   0.000   0.840
>
> (Little CPUs 0 & 1 rarely get picked for the small tasks due to CAS' task
> placement, which isn't deterministically "always picking big CPUs", but since
> they make up 6/8 of them this is the common case.)
>
> Overutilized:
> - OU time = 10.0s / 11.0s  (ratio 0.909)
> - OU triggers = 7
>
> Case B Patch:
> Small task CPU residency (s), 10s run
> task   cpu0    cpu1    cpu2    cpu3    cpu4    cpu5    cpu6    cpu7    total
> tsk_a  0.055   1.907   0.006   0.012   0.002   0.001   0.000   0.005   1.987
> tsk_b  1.845   0.115   0.014   0.000   0.004   0.002   0.000   0.000   1.981
> tsk_c  0.914   1.069   0.007   0.000   0.004   0.005   0.000   0.000   1.999
> tsk_d  1.000   0.985   0.004   0.005   0.000   0.000   0.000   0.000   1.995
>
> Overutilized:
> - OU time = 0.1s / 11.2s (ratio 0.007)
> - OU triggers = 57
>
> (Little CPUs 0 & 1 get picked by the vast majority of wakeups and aren't migrated
> to the big CPUs.)
>
>
> [1]
> LISA's RTApp workload generation description:
>
> rtapp_profile = {
>      f'tskbusy': RTAPhase(
>          prop_wload=PeriodicWload(
>              duty_cycle_pct=100,
>              period=1,
>              duration=10,
>          )
>      ),
>      f'tsk_a': RTAPhase(
>          prop_wload=PeriodicWload(
>              duty_cycle_pct=5,
>              period=16e-3,
>              duration=10,
>          )
>      ),
>      f'tsk_b': RTAPhase(
>          prop_wload=PeriodicWload(
>              duty_cycle_pct=5,
>              period=16e-3,
>              duration=10,
>          )
>      ),
>      f'tsk_c': RTAPhase(
>          prop_wload=PeriodicWload(
>              duty_cycle_pct=5,
>              period=16e-3,
>              duration=10,
>          )
>      ),
>      f'tsk_d': RTAPhase(
>          prop_wload=PeriodicWload(
>              duty_cycle_pct=5,
>              period=16e-3,
>              duration=10,
>          )
>      )
> }
>
> Christian Loehle (1):
>    sched/fair: Ignore OU for lone task on max-cap CPU
>
>   kernel/sched/fair.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>

