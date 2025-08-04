Return-Path: <linux-pm+bounces-31894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF40B1A2C4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 15:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF5A7A865F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0A25DD07;
	Mon,  4 Aug 2025 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qfQcA0ou";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qfQcA0ou"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38E258CE9;
	Mon,  4 Aug 2025 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312693; cv=fail; b=t2/El4NkIaAH8I+MyGvKJWnCGcFllZswo8gzTqYNh0ejDKaqAJAbn2KY/J7S4yK0s5MfbrumpCjyYsPl2s4gXN5JYOzSzOEW/lOOMuc7alNg3wtruXGA7M8WHgMxbbSFPaVp2+i7CqE9ZRPwPK28mUU/evIGB8Rz3+17oTXnuFQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312693; c=relaxed/simple;
	bh=O30JE0mGRsesLWdEFj188QNrFU8IoL9mo3at6n1jTKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y1gZV68oXhUlNkBIW7Jj9JaRnBotlB/Th0DlLnhbcxpvwa1mSAhjSlIhGnvumw5NgWA05N+2uLVM2/r5x9PAwu4ZFg/SL9G9y1AxFiHcqYcr7IFg4unCuWuDSe4H7K71gepxdw6yo6Ix49dfJvsuiFKn26N9NbFpEK7oDthdI9o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qfQcA0ou; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qfQcA0ou; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bnZggYa+ABQpkskxVV9kpwlDYbstsCNrz1qoZPmdRKJjmARBr22TWjmCJ/1eLVwJS8Qy9Zy2xmcCvoLE0+T9NnylJ6sEZJfzgklPoLD6qaA6cSMfLwnPCLZJL6dvGu0X7z2dDNBSgvpLt4en8yHqtI7AGMJYF5tkBWAgvuTd5lumfxG3VZ5iCRY4s+hE9HJm/vHdIyH0Fv/64pdUeSvyDVHCnnEUzGs7ngEKUR0oJ78mUjkgYg39ZLfjFIruLjC39WJ2+2x7jp0MxJWJtKxEWmSH1DYqUfkn/Gg4BFG31C/fxnpBEzK5oqEptRgHP8hQ5ijrQF91hy6CxXjf1j+lQA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiTKHZVWgsOuZN62fxngNBC8HWq+t4zC8BBcgMSgthQ=;
 b=BSeGuqvbD1+m4hA/vKgSiGbcFJ/xHuP397Uu5+wQqXIVLxZp7gcGO5LJhFgo9L1V7IcdNhszwoiJ7bvd1dM+UJ/5By8LcX9T9qvRdrYP3F1SHSlcGTXq3OwSTSha1pxHcWf/CTbrOS6jozzaD2G5wwsifGT/1ecpPTO8xxJ4tZJrzLLaWl94EsT/buVc+6rLyi4bA34DaBE4r1CRbvV146EmkviMpiaVWJsWWlI00lbE5WYXfcF2BYvEqeyaekYCvCkGWoJhXrQoIUl5Pzk80CKvvq4qhVf7zP6GMFl4cxBdT+gyLS9j8IBkrv7zhouBb0AMPoN68HBlXvHLpneCYA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiTKHZVWgsOuZN62fxngNBC8HWq+t4zC8BBcgMSgthQ=;
 b=qfQcA0ou0O3HnEtRhx+wYz04srzHMMarRDecHmbVPGM+TFwJ7gxgFJmC7osCn0i9pV3GPr5+pPvCVPwe8c9JAOQ1IrmvHIk5hrrvIEjmpxC6Hjr9mmQZCL9xbsO8y+QR7WANyovHhqSJHZ19xFAvIISwEJI9Gsg7WgE4M3no8y8=
Received: from DB8P191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::38)
 by VE1PR08MB5791.eurprd08.prod.outlook.com (2603:10a6:800:1b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 13:04:47 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::87) by DB8P191CA0028.outlook.office365.com
 (2603:10a6:10:130::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 13:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Mon, 4 Aug 2025 13:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymiajtK5kPrDFB8CTrOWmf1fCglPXWsArG+shTlS+duuFWyoe8EQfd2G6WizBOMuWRu6knoLrq5h8KcWEw13PiHIH9WEnK6M6zUYDIoNqsGPNZeQkIYHJLdEGPaJQtHoWZWeZsaSHpkXuiSXg3Hgk7RaDJID7Myc2GyJkb7nDs2Vf0W1k/dbDXLdl6YXIH49ZmugkkXZnIc8mO8GphLKB1ZNrvJ0kKp2U1Q8BQKw1P/mPcIPvyNVpMepR8PxrEX+0H9rPKNm2dJEdzbRBRILAhWvSQZ8T81uVFUq7g4n9uwdSKBj/N6XDZRq1uM2XpXvkM73g5rgyNMfNF6YPMlx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiTKHZVWgsOuZN62fxngNBC8HWq+t4zC8BBcgMSgthQ=;
 b=xrm0eSjlanmwcH1JVfLJg6g+Rp4GssY0E+dRHDEQHWp84h6R6AJLqJWiWNvbae90f+Cv6pqt3izazf0mC5e3rgdPYdVDimVy137Pc7uXLRKtzUJ6HOwDa9y+Ht1U5MaZ4cW1sf1+wbj3PZhm5LEEh5dRCk+FrAYfV1H9ERdLw39O9a0yK0tnW+chDfdCPoQKEjF4e552RXNdjjqKl30sUrkFsOLOJlvoxlid3gVvpKAa59xkfiXtm7R5h9lLIzH+BsdqtBHbMDDvnRw7bVeuHmtOSFyjwdeIHnvAM0umDK7Thvk741P0wV7fhd/hN6Opd/YiE6wdnfv6edyiyPTibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiTKHZVWgsOuZN62fxngNBC8HWq+t4zC8BBcgMSgthQ=;
 b=qfQcA0ou0O3HnEtRhx+wYz04srzHMMarRDecHmbVPGM+TFwJ7gxgFJmC7osCn0i9pV3GPr5+pPvCVPwe8c9JAOQ1IrmvHIk5hrrvIEjmpxC6Hjr9mmQZCL9xbsO8y+QR7WANyovHhqSJHZ19xFAvIISwEJI9Gsg7WgE4M3no8y8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV2PR08MB9880.eurprd08.prod.outlook.com
 (2603:10a6:150:de::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 13:04:08 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 13:04:08 +0000
Date: Mon, 4 Aug 2025 14:04:04 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ry111@xry111.site, Dave.Martin@arm.com, ahmed.genidi@arm.com,
	kevin.brodsky@arm.com, scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 00/11] support SCTLR2_ELx
Message-ID: <aJCvxN8wv62lgX91@e129823.arm.com>
References: <20250804121724.3681531-1-yeoreum.yun@arm.com>
 <86qzxr6z5o.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86qzxr6z5o.wl-maz@kernel.org>
X-ClientProxiedBy: LO4P123CA0593.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::8) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV2PR08MB9880:EE_|DB1PEPF000509E9:EE_|VE1PR08MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e72fb83-709b-40d5-96e0-08ddd3577ce0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?OWo4M2QvblE0Z1I0SDRBSk5NMWQ5WlNyQWJKUjhFTCttR0MxVG4rU1dNdy8v?=
 =?utf-8?B?TlZyMEppQzUzVjNPeTl4aklURUQxSk43c2p0eUQ2YlZYWTJkMTM4T25lL3RD?=
 =?utf-8?B?dllvbHlOL212bkJ5SzBzU1VNOEx0WURZRWgyekV6TUwyVExSNXZsenJVTjZm?=
 =?utf-8?B?VDg5dnpjaG1FMnI3bjV4RzZ5YkdwMGwrNmJDYmtVYkNxcy9XUlZhVGhIYlBJ?=
 =?utf-8?B?cWJ0Znl0SFZFZUFIaitRVk53Q2JtelNkSmZqdmRYR3RmK08vaWgxaGp4c25s?=
 =?utf-8?B?MEw0ejlBVVUyOW55WW5rSjY1M04yaWJDbERCdTBCSWg0UXNmUGRDRTBPdmha?=
 =?utf-8?B?Nit0YldXU0owNW1aYUMxSUhQTmpSOXhISHpMYmdNaktvVlNPcm1tMHdmUTVR?=
 =?utf-8?B?QUZWMXFoMVZhRG1rRXNqZ2NvZHhqaVhFM3V0RDNiMW1rMWRhRFJXN3ZRazRU?=
 =?utf-8?B?T1diLytzdTEwK3hndm90THBBNjhOUHhmWERDb3VYQzRtTE0weFNhWGhDU2hB?=
 =?utf-8?B?anFMbXVtekYwaUxaakN5WU02eEs0VWk5UVBibm9YYkNnbThDRzYvVzM2a1lG?=
 =?utf-8?B?U3VCcFlQZTVVNVJOVm9TMUtVZ2h0akVHdmpPOWwzaGNzOW1IS1NaaUMyTExL?=
 =?utf-8?B?UXE1QkdydmUrRjA3YmhUcmdkT0JUN29CZ0xPWTB1L3BYUXV2MnNubm5zdDFG?=
 =?utf-8?B?OVYydW9IY21jK0tUU2JRcHBqWlFJejlUM0JFcm9BRWltZ3Bjby9LRnNRUndE?=
 =?utf-8?B?ajBFLzE3a1cxM29LUmtIdEJ2LzVvQ3VHem9aTk5IR0V4djMrYnF6RnZBMjVR?=
 =?utf-8?B?Sy8wQ2NQZEFWS2ZVb3VCbVBwWk52TjZ5Z2pRWE16WkRiUkk1WjBibjhBcHFI?=
 =?utf-8?B?ajZuWDM0NTl0aElsN0djblRraTk0QnhtOUhzSWM1UnIwTkJSc3BGTG43RWgy?=
 =?utf-8?B?Q0lPOG1yVDJSYTNTZC9BdEd6aVpNVDMvU2ltejBNbnhMRzVWcGJwRDd3UTBQ?=
 =?utf-8?B?NlRnbmVzUUNlQ1N4QzRYVjc4UVhLVjhwME9zS3FudlZ5UmpzM28xeFVjRHRV?=
 =?utf-8?B?Vk5ZNkdFd2RhQXFybEhicDlHenE3Z2ZZSkxwTnR4Wlg2ZDJmdVBaTlg2MUd4?=
 =?utf-8?B?UGhRU0lGM2tHTVNjMENYdStRQmRmeC8vcm1hUnBmaWJPem5lcXVLLzJvSUNP?=
 =?utf-8?B?K0xnNjZQSjhSVVB1bUJ6ejMvSnpWL3ZqMWllNFVwNUwyQW5Ga3JzbGIyUldT?=
 =?utf-8?B?aEw3dWNVRStBS0piOHJmTTRjOTY3S2VqVis0SU5UYjdJK0ZYeDhLeVpTdnFT?=
 =?utf-8?B?MjlmRjNkTzhrTEJQb01IVzJwNU12MTh5L0lhMEZmNUZFQ2NCZXRTaExObzRz?=
 =?utf-8?B?MElMSkJBTmtFUENia0dNcW1LOVlwWXUrOTIzWW9kWStDL3dzdmovaFBMQVZk?=
 =?utf-8?B?UHFMemlLOUpWUjZLOXpOT0RXWnJmRk1Kb3lCWSs2bW1OZlZmRmlxSWU4WHo0?=
 =?utf-8?B?Y2d2VHpmUDNmRk5kcXhkdVhiMUppTnp5MVZtaGFEZmd4UXBqeUpxSkhLVXhh?=
 =?utf-8?B?OGI1Sm1iNGcwOUF1bmN3TktjTjZuV1V3YlJrWXgvQTBVR0l0aHdua2RPVytQ?=
 =?utf-8?B?NWhNUkY5M2FuWXphTWtOaVF6Q0xYbXNUMW9LSnNmZzNpbFoxNUtUWTVKdXE3?=
 =?utf-8?B?bXlXNUY0Y0lwODI5Y2JXdnMvQUcyMDVIbGVmdzVEY1E4NGZNR0pGc1QrYWxQ?=
 =?utf-8?B?ckRSTEp6M01iMTIzWElqTVVRRkxaTXBwUjNrTy9kU0J6aVNJT2xRWThVR01Y?=
 =?utf-8?B?a3kybWJOcVJQNldBVDJ5UENoNm5xWnhNd2V6dDJFZ3Y2amgzemZYa0lqelRE?=
 =?utf-8?B?b2VPeE9rSHd2d01OYUlsY3Y0clZhbUIzQzJRVlV4NGtwa3c9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9880
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2ff3ddd1-827d-4b2e-7ccf-08ddd35765b3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clRqSUVjbjV1WnE5cFMyRjVZYjh6Q0VVb2l5ZWFhQ3VKcHEzdnB6L0EyZEV2?=
 =?utf-8?B?MmZ5bzZiRlBZM3V6N1FJMUlqUXZVdHJZL1VLemE4dDkyaGtmaE5PMXZKZ2Z6?=
 =?utf-8?B?S0UxcjVNbGFwT1VkUXF6MFFOb3U0cnJ4eVZ0MGkycE9yU054VFByd3NyM2dH?=
 =?utf-8?B?bWpQLytoYWkxaURid2hrQ2ZZSzVqdFpqS0J2TnZKNmZBZUdBQmxVQklpaWpL?=
 =?utf-8?B?Z2JNckZOTnIyWi90aGZ3TWREUDVjbzAxZTBQa2dJdHBEUDFCN1VRbXVkU05U?=
 =?utf-8?B?bzJZM1pRdFk5VEpDV1FqM012WnN4SWlGMXZYNWxCMUNEQkJIOWZPRDE3cDd4?=
 =?utf-8?B?UGZrQ3pSdnhGc2J0S2loL1lOS2QxK25MU2VyK0dhK2NOYXZhandZVytKUVcv?=
 =?utf-8?B?UFBHNHlwaVZHMGM5UWVBbHZCOGJBdEw4RmFGNmtHOXJ6c2hjOSt0OWdIc3pR?=
 =?utf-8?B?R25JQUhmQnlCdEdwSHBQbEtWMXVXSy90NDN0c2dMK0RHb2VhdEpUY1daOEky?=
 =?utf-8?B?NUxaTzZyTlpNcDNkWU1BSEYrRnpzNm1pVkVpYkFrWS94QUxzVDY1RmdoQ0Z0?=
 =?utf-8?B?UDV5WHk0eHdzK25Zc3JaYVkxdkdDbmNGazdZS3hoNHJKaVFCVlFmOWFJNTVa?=
 =?utf-8?B?a0Y3UDUzalhESUxvSVBMRUszNkJlNUFUbjhCMDBJT0Q3UGIyQTM4MUNrZnBT?=
 =?utf-8?B?b2NSOEJoVjNRcWxyR09PcnJtQVFSdk9SM0t4QllCKzdmcHRBVy9telRjalFK?=
 =?utf-8?B?WVlJVzNqSW9GZ1dmc2orRTBlTW80V3VBU2xwZWhRdGl1czkrdWV5d0ZjRTFp?=
 =?utf-8?B?RVZLNnlXTXdGLzd0SmZOTE94QUhQZWNxeC9MaTNWd3VqWVZJbTl5eHczQkFr?=
 =?utf-8?B?NFg3V1NHajNhODQ2blh3NVhDT1JleFA4bUxnSkNvVDdLOTlZMjRNYlZpV2Vl?=
 =?utf-8?B?V0x0aTRraUdEVlJGdHR0dTZPdk9sR0o2WGhkK1pnSXNRWU0zVFBTd3BqaEZH?=
 =?utf-8?B?SFJ1L3VqN2habWNXV0hGTXVhZWVTVVc5OW5NeDJHMDhJYmdvNmJJaEhOYlRM?=
 =?utf-8?B?UHNHeVlSQ1NjWVUvSE9jSHVIRUtQKzlucTNwZjFidEQ4Z2xKYXBWRzF0bVNE?=
 =?utf-8?B?NzlKaHZCT1FlZ1hhQVFnc3ZPL3djUXlscXFTME1mQmI0clVLeFRRc2VGNnB5?=
 =?utf-8?B?MFBjQUhpeXhSVnN6clFjNjlkQjNFeVIxV0VCeXlMTU5UdDFHWUVhd3pUanh5?=
 =?utf-8?B?cWUxaFlKVTdCZUQ3Y3J3eEhJS2ZGODJQSWl1ajJqU2xXTndKdU9DbmxUSjgx?=
 =?utf-8?B?d3FsZzBIR3c3N1B1VGZQNEdhNFdSbFZ3K01rZGhGVGt1cGd6SDZzVDhJQTl5?=
 =?utf-8?B?S1l1TVFnSlNKdUpXMm1kMmxhQjJYcWdYVDhFV1oycmpvUEpBcHRBRnFDS3E4?=
 =?utf-8?B?Z3JSNGRTNnhMSnNRQVF3WENyTW1UNWkzVU1HaEJ1Mkk2N0tGUVB3NjJsTUNi?=
 =?utf-8?B?cERUeGR1OERzUFlOM3FySGJtK1BpbDdocDhJVlRGV0Z2V2kxeU1TYmlUeEdq?=
 =?utf-8?B?K0ZpRnZFKzMrNVNQaE9HYzZ5YVdxTVR6VHJXNlYzZTE3ZWNKb25vSGxtem1q?=
 =?utf-8?B?bk91aHlvVkN2N2NDblNTNDBCTHQ2RWJWeGhONy9pZ2UxYjViZEVvd0pxa3Ux?=
 =?utf-8?B?VmhmNXZCVkRhSHRTcHZDN1FVcytFb3J5REhDMDlEWmhlTjVUU2M0SDFUWTlV?=
 =?utf-8?B?eDdwRWNSeWEzejI4dVRFaW91SncyQzZoODYrTVl4eGVXNklSc3pZamNUSU9V?=
 =?utf-8?B?SllRTDNWWVNHdVNFMlJGWFpaNUFhOVhLaTZtL3FGVGd1MUV0OXh0dHBBbkdF?=
 =?utf-8?B?UFZjOGdNUHRLN2R6ZXJDVU5WdDM4MUhjQWs5QTJFZ2RmNWd3VkViajVsK1hU?=
 =?utf-8?B?cDl1UG1zL3FzTTdmY0M1RzRyazZrY0l4YWJTZmxCV2s2M1lSSHhzcHdwY29m?=
 =?utf-8?B?SC9sKzdoTmhBRy8rUjZzamorOU9uSzFLdllLUXUrUjNHRDFxd2dlUzN1cy91?=
 =?utf-8?Q?NFm9F/?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:04:46.6201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e72fb83-709b-40d5-96e0-08ddd3577ce0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5791

Hi

> Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
> > This series introduces initial support for the SCTLR2_ELx registers in Linux.
> > The feature is optional starting from ARMv8.8/ARMv9.3,
> > and becomes mandatory from ARMv8.9/ARMv9.4.
> >
> > Currently, Linux has no strict need to modify SCTLR2_ELx—
> > at least assuming that firmware initializes
> > these registers to reasonable defaults.
> >
> > However, several upcoming architectural features will require configuring
> > control bits in these registers.
> > Notable examples include FEAT_PAuth_LR and FEAT_CPA2.
> >
> > This series is based on v6.16 and probably KVM-safe but
> > Not tested yet:
> >   - nVHE boot.

Okay.

>
> "Probably" and "Not tested yet" are not exactly what we are looking
> for when looking at a series that adds support for a new architectural
> feature.
>
> Also, a lot of the KVM patches are redundant now that we do have
> FEAT_SCTLR2 support in KVM (see what has been merged for 6.17). You
> probably want to rebase on -rc1 once it is released, which should cut
> the series by half.
>

I didn't know that and I'll rebase on 6.17-rc1.

Thanks.

--
Sincerely,
Yeoreum Yun

