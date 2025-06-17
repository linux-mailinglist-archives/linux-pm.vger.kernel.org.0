Return-Path: <linux-pm+bounces-28915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C21FADD50A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 18:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D24194814F
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B302F2376;
	Tue, 17 Jun 2025 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fRgRsP+9";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fRgRsP+9"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7521E573F
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176021; cv=fail; b=DPcSzSzzbyVIddxIR7mocdNwy06pM7IQPK6RdOaqWkBtb44fBxCQfJgAzAIgJmAfdO+RZiMTuBCdIDISCQ9vbaLZ96+ZpScge6WG4lC7d0sROqEIchmUGcHYKYRnjzFhMW8OzPZIhx8BnJXK8AuigJFJrGXcOp/ZbVQqf4mXcTU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176021; c=relaxed/simple;
	bh=DDNGi5NvKGO7ajEjFBFiQtJndsrH2qyDLo9XwtVlG5I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ar6MGxspXRHfb0FOoUm24Tq6/vn2b1haqMcSXiu+iNrcCFv0W0vOGGgObiljKNnhB/edBJr+HIkU2VVsVdOw6r/XlFTG2tbETF8iTcFnt2WV1clcY9d0amgK56lUUrZ4baR79Zg216/osN5pM24YtdRzmfk+o/fPuaG8HA+a3Lw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fRgRsP+9; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fRgRsP+9; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UrwrcD17sv7a5PzNteUOiGGmvtqFPHtxcXws0uaLwFDnH4Iqq39qW3DrYorBoXN95mkGjJW4D+5En8Y4L4qBueV+o1YxQrybEyPNOHU4GHxPAHx98uPZ8FhTtsxaqPi/POu5z9mVVmeldsilGtwYpdzYEY3OgKZD8YaiawBxDJi+Tk8Tc/aikS100piWRil83frhrhh7DJyFApxQBFqffYWV0HDVLjUFbo3QF0SxVaEL6YSfHkQbHHgNXfpbBW1rEFSke1mNZeCgnMAj52TlmW95EY4CTqXKiBjoI+fTdBzRFV64IZHjFC7jrL+Udex8o4i2+Ff4+pgYP4ltgWm+0g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDNGi5NvKGO7ajEjFBFiQtJndsrH2qyDLo9XwtVlG5I=;
 b=RAIwYD+vuqhlWM30v0T48zRU1C6Fpl/8LgAi7TAj/jFkEHhdy+WS2BTpvCV7ET+P3PBq1pOLqUrar/NBBlVOMS5dHisQRIjtmsRKb0MNctOrA+KjEdM1mLai4eVl2iy4VqBwBD34+HKhwyPtyHzIXamU1SjFUtr7qNUn/gbsPcKHwFitEmkS+1IQTXXDaqBQg0P3Cq2Ko7ofP76WU+8t50O7WY71OnhFVcTLmzcL50B6klhMCfUX7ApbixL78xeSQM6iAMdu93kV2qMG71QkW44hv0Xq4cjWjAoWhcHNXwiMoNT/Leq29m8dEy701H6HeZIlHT9RCc+cxX8zUf1cHg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=phytium.com.cn smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDNGi5NvKGO7ajEjFBFiQtJndsrH2qyDLo9XwtVlG5I=;
 b=fRgRsP+94nb2pnXSMaLFosnvqmL+4+7Crhq568GVVH9N4n/vYWkHLU9z/fY8x0PvF8RV6mGiiW/EP9ejspVOMUPs8LBjg9SV1jdRgpw3lVWtFMcpL7OxDRrHk4Q39S8hmrMlKgM2t7uO6ywLA/+m3+PHh4KSq3MlpwULYhvn4Z8=
Received: from AS4PR09CA0026.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::9)
 by GV2PR08MB9328.eurprd08.prod.outlook.com (2603:10a6:150:d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Tue, 17 Jun
 2025 16:00:13 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::62) by AS4PR09CA0026.outlook.office365.com
 (2603:10a6:20b:5d4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.30 via Frontend Transport; Tue,
 17 Jun 2025 16:00:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 17 Jun 2025 16:00:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvLfCvfAvv+aiK4BswalBb/+Glk8W6DOMF5xiUEJ/WzYwUF75qLmt26xAromZy26VES15VBf8LXMc2PwjZFOTUAnD+JSTKj9DGwW0cgFhbi7lEmr5mrUtL+UH4mqVPDztoBn6XU2zrjLhghrI1NhHGndBgz+2GNTsel4wckfkyBO0RfjceNLnTrUyN/cNog6A5Tuf51LV9Z56PEUTR8pVVeDZUn9aRoIC95IB6CVtIYjswJFfQtHhFooJ3BMalERfp2tun6hMUipYg3E8QtvUO2O8Ouiav5Qx7qR6CREWBZbNmRvU4CMi9A44m0iCu2xMunlpjacNuyvkzlQesS7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDNGi5NvKGO7ajEjFBFiQtJndsrH2qyDLo9XwtVlG5I=;
 b=x1dAA3HX97rLKCi1gHkLm2JMSNe/h9yqsoRAl61MvJ9di/fzG/TuOHoB1HktUfdMT1exj6YIRxe4qiBYU4DPzxY7vBUIDRKXSChRJVdJPoD20hb2bFYmH8UF5j5GgmgUzc4OtPFoj4foECTb3kqBuVVFws7eDVICAIh6NjTMshNd7iyLxav2dqg+wVSP/n26HQCh9zhIjl67+2Pl28pqKWscdcR5h7ZunOhi56FHfx3YUxydtLN8voVrXKOTB0dCQC4r+akiihZD48UqKrD2oXMBs33LXh5Kr5cxmIPj2krcjrUfuxZu2PZCfJK+L2yipgvZ0YpcZlYx4G7vE3dRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDNGi5NvKGO7ajEjFBFiQtJndsrH2qyDLo9XwtVlG5I=;
 b=fRgRsP+94nb2pnXSMaLFosnvqmL+4+7Crhq568GVVH9N4n/vYWkHLU9z/fY8x0PvF8RV6mGiiW/EP9ejspVOMUPs8LBjg9SV1jdRgpw3lVWtFMcpL7OxDRrHk4Q39S8hmrMlKgM2t7uO6ywLA/+m3+PHh4KSq3MlpwULYhvn4Z8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS2PR08MB10126.eurprd08.prod.outlook.com (2603:10a6:20b:645::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 15:59:38 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 15:59:38 +0000
Message-ID: <97e8bc72-e44b-487a-91ba-206732094955@arm.com>
Date: Tue, 17 Jun 2025 17:59:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Subject: [cpuidle] Limitation: cannot model asymmetric C-state
 latencies on big.LITTLE SoCs
To: =?UTF-8?B?6buE5bCR5rOi?= <huangshaobo2075@phytium.com.cn>,
 linux-pm@vger.kernel.org, Sudeep Holla <Sudeep.Holla@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, deepthi@linux.vnet.ibm.com,
 khilman@kernel.org, Christian Loehle <christian.loehle@arm.com>
References: <5d7534c.5492.1977796c43a.Coremail.huangshaobo2075@phytium.com.cn>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <5d7534c.5492.1977796c43a.Coremail.huangshaobo2075@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO6P123CA0046.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::8) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS2PR08MB10126:EE_|AMS1EPF00000043:EE_|GV2PR08MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fece2a3-0ccc-454f-8eb7-08ddadb80a37
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?YVZhcDVUVVNtaXY1dzJXbTJCK0JQS1gxaU4zVUFYZ2tsSGcycDVhR0F5ZTVH?=
 =?utf-8?B?c3U2ZTRJY1BmcUlLMytFbEhyRWx6WjZudHJiQnIvNnNOTVU1bFNOdmR3eEo4?=
 =?utf-8?B?dnkzOGIxazhWcUdWNUNabDNSUm1xYytxbW5ia2ZpTWRDcXVab3UxaHlSVm5F?=
 =?utf-8?B?ekh4alRBM21TMUhYTVd5Z0FFSGdMZ1pKeXlUMWpGTUNiQVdaQk5CQ2tSa0to?=
 =?utf-8?B?c2thMld0OG1HMEpDanpKNUJNVkdmTlpmbkNtTzVZOHRuQ3M4SlhQMzV1MEND?=
 =?utf-8?B?S2VQelczakdTdFBhV3YvdThpQVBLdU9qVnkwZWZ6a2FVYUFKbUZpTDhzbUFG?=
 =?utf-8?B?cjFlTFdoamlGd0Rta1lYYmxNaUZ0MnhZaytsRU5YbFNROWdGeUdORy9idmpj?=
 =?utf-8?B?WGpTTUE2VTBPQmhqZ0tmWHhzUE9RVUZ1WUQ0d0JIdmV0VzdHTkFpcWtpQlgr?=
 =?utf-8?B?WU12UERoNEh3Y2VKRjY5OXN0dEIvQ29XeHlaZUdzZG1OWkkvQjhPb0sxRThL?=
 =?utf-8?B?Z1cvbGk0aS9rSnVsbmxoU1VwaWFGRWxkTE43QnNaMkpRS2RHUGhQaEJuaHFz?=
 =?utf-8?B?OStpc045R2syYnlUQmUyQzVaMnprUGJ0dG4zd3lDYmR2alBuaWhyQXc1MVZw?=
 =?utf-8?B?VVpUMi9MekRjR3JjdS9QUUdRbUh4UnNIdHdGYmd4WWpMdWsrWWhuRW1aQVd0?=
 =?utf-8?B?MU1ZV08yaVVFWU5USHJRMlFKUEFJT0FGbmdPL04zZ1RFOFhQazE1NzJ5M1B5?=
 =?utf-8?B?dDA2ZnRmclJFdGtsbENLKzVwbGlGYmJ2bS9sdVBiS2c4Y1g3cXhadUlNMlB0?=
 =?utf-8?B?bUlHK3pkeFRHMnEzb0MwcXRnRjZCbDV6UjJjcUI1Z05CSk5oRDQvUllnK2Zu?=
 =?utf-8?B?RzdEMjMxU3VoYzZFTXlsQUxjem4rd2M4YlNqTjUvaE1oMXdONFpQWEJGai9E?=
 =?utf-8?B?YVVjN2ZIdmF5K1pUaG9zazV6c3QyUDlsa2tGNlZMSjhndmVmWGNmNk5Vb2tH?=
 =?utf-8?B?dFBsYzYvelA1Ui9YRVIxaGxXRDJwVThMZjVKdTBZc1U2WnFkajZpQ1NPa3ZH?=
 =?utf-8?B?ZHNWWGRrQ2tUZDh6TSs2RFNUWmRNK3BtaXpJZVd1L3hTaEZ1bTJla3VISCsv?=
 =?utf-8?B?Mlp0SFgwZmdpYUNTeDZwNnYyeHB5ZmZjMUxYWWdQb0hvMzhYR21oYVllRmxh?=
 =?utf-8?B?bnh2aCt1OHpoZ0YzWnE1UzR0a013NkhIaW9QSzJSa2dIaGh3NDRzS29iWGJQ?=
 =?utf-8?B?VExYK0pEK04wTnhSZVpmcmNXVEgwMUlHZGFsVHVFam1DS1pIT0RHN1BpMklz?=
 =?utf-8?B?RUh4YXFXSCs2U1hzbDZwcG5VL1hXS0ZkVlg5K0hBczhSUjlqSkt3UjBLaUlM?=
 =?utf-8?B?UC9TOC9qeWowZS9SNGh6UVB0WXhnZHJjRkJkU0IxYUdwMHNydWR2cWFsQ29J?=
 =?utf-8?B?SjQ2em0yZ09DUUtySjQrV1B5Qmk4SUFCaVpnYk43dDVMMjNWV0Evb29BTnBT?=
 =?utf-8?B?TWgyc0VHNHd6ZGpLMG5zZmZaL1VFeVplNnBKNTZUR2h1Qk1iZGkraHcrUUVi?=
 =?utf-8?B?dTc3ZDZlU2NYVXBVREppNjMwVnVMd1hjVUJxQmUzbE9YWkJWUzlRMVhwWFl2?=
 =?utf-8?B?MXo0cWFFVHhyR01FclNvQTdFQm12NnBSNTdtVmw5dEkveUdZK0lSNHExbUM4?=
 =?utf-8?B?N3NhdVlPOHlOM1ladzNnSnBuTFdweEZkeGlpeHVqd2c4Y1dGMlk1WTB0Yng3?=
 =?utf-8?B?djY0NjdTSVYrMjA4VXpIL3I0WG4yc285bWQ3S0N4dGpBRnE0djVBZW45Z1Vn?=
 =?utf-8?Q?gj2W0CaeY1eQMJaasViglC3hrOXHd+SWf+CKQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10126
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3834fe36-3aa1-484b-8c9f-08ddadb7f63a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|35042699022|1800799024|82310400026|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDlyRHFIeU94NWxtU21ZVnFYZWJ4Z3dXK0lqTUd4T245cUZsSUVaSk5NeG8r?=
 =?utf-8?B?UjlEa0xLc1h2V2doY0lVS2JiNzRwajF2WWFXV0JLZXRrZzVpY3BlalJHdFNj?=
 =?utf-8?B?WTJDUjJYZXN3eVVlTUp4bm1MNXA3TGlzYWRzTWJTdXNlRWI0ZThXZTBJM056?=
 =?utf-8?B?WkR5anhDOG5zWGlJVVk3UnhsMFB0QTdmK3RObDltY3NIMmRjTFhsbVFDNTZs?=
 =?utf-8?B?T0F2R2hYUEQzYTJ2ZkNBMUZqQ0txRVdsSzNoZnlqT29pZGF4TjRGa2E3QnVQ?=
 =?utf-8?B?cFcvVU5vN29yUWJwajNmMzFjaE5FOWxYV1ZheExvbUdhTGR6blhQMS9XYmRI?=
 =?utf-8?B?Yyt2K2J2akUyWHBNZHFXdlIvdTJUdWlxd0RtaFdSUkNsWGJKRUJ5TkxZUHR2?=
 =?utf-8?B?RnROVEU0NmZ5RXRJcndJR1VVSDBpVFkrcFByQk9CVk1OTENGNU1vN0N2T1p6?=
 =?utf-8?B?RlBmTWc1cEh6RnRwa2l3UnZMSXFFd1JtSjU3MmlqN09EdjBjaXc0NzJURGVJ?=
 =?utf-8?B?dVVTQjZnNmpjdzRJY0RwUEplNFo2TjRHL3BUUDJmVWNNUGRWRExoT0lQRUNl?=
 =?utf-8?B?aXJSZFhRY3NnNEdkZXZzTW4vbVRWRytOREFNMmlwb1hLOXNsc0RkZWFQU2Nm?=
 =?utf-8?B?a3lOYklkQ09DSWgwa0VXZFkyUTBDS1g4SHExZm9lZXRadHk5RUNBL09Ga1I3?=
 =?utf-8?B?TE1MVkxLdE90S281ckQzb1Y0MU9zZlJzK1JTcithU25SUWtPK0NSWWk4d24y?=
 =?utf-8?B?OTZFbzA0YXRQalRZMjJ2Y0VrOXFJemxWTm81dVJyeW9ZU2RuRlR2bUtQSkI1?=
 =?utf-8?B?b3ZTUTY4VTJjdDRjN2FVTkxSSTlyYU9VTkQzRW1NOU1xSXU3TWUzUm5PamxJ?=
 =?utf-8?B?NUhtMG1LeHlaZk5sdkZGeUhTdDR1emo1TzJFRHdWanlxU2JyNllweENwQjlS?=
 =?utf-8?B?b2tIYVltQXRVRjVkaHp3STU0TmJia0R0eVNVcHBCTE5YWkc0amhzSUhpZTlS?=
 =?utf-8?B?MG51bmkrNVN2c0FQcXFBUDlWN2ZnQkhCNkp5UTJHTVdyUkQ2cXhUVUhFUUpy?=
 =?utf-8?B?OFBzOGYwd281ZlJvN3ZGYVVWSE0zZHVFZWxBMndZSDM1M1lVd05mWklxOFEy?=
 =?utf-8?B?YUJtUldqc1dMbGhDVkR5NGF0d0NoOTgvYXZVeGRIU3hISmY1UXdKZEwxcklj?=
 =?utf-8?B?cU1Zc0hsN2hBK0E1VTlhVFhHMlZHTk41UXFtRTRobE11U2JoSGJKdGE4RjVx?=
 =?utf-8?B?QngvTDQ1bmtkLzFiNU4wWS9kWXlOWU85aitibThHWFl4M0c1SWJpeHJMOTFQ?=
 =?utf-8?B?Y2RweTBrWDhmS2xpSFIrQVlEZTMrOTRKM2pjbEpPbGczWE5YNTJRR1dKT2U4?=
 =?utf-8?B?SmsrdS9IOXQ3UkZPaVNWcWdQcDZnaGtmcDBJUkJjb0FrYlFiUUxNR0NXb0Jm?=
 =?utf-8?B?Y0hPZU9uM2xTbDVVSXdCcTZDaEEvaEdUU3E0S2IyQ0daczlVTS9pZVUrK0NF?=
 =?utf-8?B?UXptbmZyVzlhKzFnRlhEVmFUamFxQXhrcE5VN3B5dXJOd013YlJ6dG5TV2sw?=
 =?utf-8?B?UlJlNlIvN3pGZTFNT2xvdnF5cEZPY05VVVNIeFR4YkF2eXpKTWxVYkpOVlRB?=
 =?utf-8?B?WUtzUTIxZHZzRGkxa2o2anNNTlJrWlI4SjhuK25yMmlGbURWUTl2MGcvMTV3?=
 =?utf-8?B?OVdoMVNCRjBYT09wUWxWcEoxcVlsWHd3V1JYbSt0MVVoRWpBOURqTSt4TnhO?=
 =?utf-8?B?NFFqbVJPcGZQOG15TVpZOEo4K2Z5UXBBdTFVZW55ODMxK3E5V1AxZkY2MExE?=
 =?utf-8?B?ZGYwQy96dFdENEZqb3c2ZGJBZHllU2RkTjN5QzE4NEU3QXVKMHcrb0lzZktw?=
 =?utf-8?B?Z1VWbjlZU25HRHdYdUJsdDIrOHBjYzVtNDJmaHNDZnJJTUtlaUdDWFl6NzB1?=
 =?utf-8?B?TjRuWmpwOVZkdDRLajF1M2pvV3BjTTcxc1doQVFpMUtZVWc0N2hoSU42UU5T?=
 =?utf-8?B?TWZwb09wZlVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(35042699022)(1800799024)(82310400026)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 16:00:11.2629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fece2a3-0ccc-454f-8eb7-08ddadb80a37
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9328

Hello Shaobo,

On 6/16/25 09:14, =E9=BB=84=E5=B0=91=E6=B3=A2 wrote:
> From: huangshaobo2075@phytium.com.cn
> To: linux-pm@vger.kernel.org
> Cc: rafael@kernel.org, lenb@kernel.org, deepthi@linux.vnet.ibm.com, khilm=
an@kernel.org
> Subject: [cpuidle] Limitation: cannot model asymmetric C-state latencies =
on big.LITTLE SoCs
>
> Hi,
>
> I'm working on an ARM64 platform with a big.LITTLE CPU topology. While pa=
rsing the ACPI tables,
> I noticed that the C-state latency and residency values differ between th=
e big and LITTLE cores,
> as expected.
>
> However, I found that the current cpuidle framework only allows a single =
global `cpuidle_driver`,
> and all CPUs share the same `cpuidle_driver->states[]` array. As a result=
, only the first core to
> initialize (usually a LITTLE core) sets up the C-states, and the same val=
ues are applied to all cores,
> including the big ones. This leads to incorrect idle behavior on asymmetr=
ic platforms.
>
> I believe this behavior was introduced by commit 46bcfad7a819
> ("cpuidle: Single/Global registration of idle states").
>
> I understand this design was introduced in 2011 to simplify cpuidle and r=
educe memory usage:
> https://lkml.org/lkml/2011/4/25/83
>
> However, on today's heterogeneous SoCs, this global model no longer suffi=
ces. For proper modeling,
> we need support for per-cluster or per-core cpuidle drivers, or at least =
some mechanism to allow
> different idle state parameters per CPU.
>
> Has there been any discussion or work toward lifting this limitation?
>
> Thanks,
>
> Shaobo Huang
>
>
> =E4=BF=A1=E6=81=AF=E5=AE=89=E5=85=A8=E5=A3=B0=E6=98=8E=EF=BC=9A=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8C=85=E5=90=AB=E4=BF=A1=E6=81=AF=E5=BD=92=E5=8F=91=E4=
=BB=B6=E4=BA=BA=E6=89=80=E5=9C=A8=E7=BB=84=E7=BB=87=E6=89=80=E6=9C=89,=E5=
=8F=91=E4=BB=B6=E4=BA=BA=E6=89=80=E5=9C=A8=E7=BB=84=E7=BB=87=E5=AF=B9=E8=AF=
=A5=E9=82=AE=E4=BB=B6=E6=8B=A5=E6=9C=89=E6=89=80=E6=9C=89=E6=9D=83=E5=88=A9=
=E3=80=82=E8=AF=B7=E6=8E=A5=E6=94=B6=E8=80=85=E6=B3=A8=E6=84=8F=E4=BF=9D=E5=
=AF=86,=E6=9C=AA=E7=BB=8F=E5=8F=91=E4=BB=B6=E4=BA=BA=E4=B9=A6=E9=9D=A2=E8=
=AE=B8=E5=8F=AF,=E4=B8=8D=E5=BE=97=E5=90=91=E4=BB=BB=E4=BD=95=E7=AC=AC=E4=
=B8=89=E6=96=B9=E7=BB=84=E7=BB=87=E5=92=8C=E4=B8=AA=E4=BA=BA=E9=80=8F=E9=9C=
=B2=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=89=80=E5=90=AB=E4=BF=A1=E6=81=AF=E3=80=82
> Information Security Notice: The information contained in this mail is so=
lely property of the sender's organization.This mail communication is confi=
dential.Recipients named above are obligated to maintain secrecy and are no=
t permitted to disclose the contents of this communication to others.

Just to confirm that I can reproduce this.

Sudeep will be back in a few days, in case he has more background or
another view on the topic,
but I agree asymmetric _LPI states should ideally be visible to the kernel.

I am having a look at the code aswell. In case you have an
implementation, I can provide additional testing.

Regards,

Pierre

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

