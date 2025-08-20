Return-Path: <linux-pm+bounces-32736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BECB2E52E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 20:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 343077AC016
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C37627CB04;
	Wed, 20 Aug 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dTHANHYH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dTHANHYH"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64A2701C2;
	Wed, 20 Aug 2025 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755715944; cv=fail; b=BcSS35DFrNc6KKFEsIoGxO4q/Xar8HtlBYxCaYGqf8AsG12CRiMmY1L8/a5Zf16NqL5UBud8u7UcUzMhqnNLQ3ciJhhm+WRuJ9zIA5bclAu4a44gR9UHNGUrQ0xVFbMDxUygj7wk8RjA/VNVbuIZwhaiVKrz9yOs0TRAJvVaTnE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755715944; c=relaxed/simple;
	bh=PuX8gjioq54TQuKa57BjGed93KFNg8gtyr7fimQ2RT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TqnKoIINf+0g0EUUaBRsYtDY8Lq3vBbmu2ixk1ZhYs1omHuv74IirajmzB/uRRbZ5z4bs4DlT1uxH+YPmYh9550DqSBTYRXFa3M8NK0r7qtmc5UFoCnEy2I7yZvKhR2cD0Rf7nUQE7vphp/envnXrMJ8cD4E6J7Y8cGQMgyHME8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dTHANHYH; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dTHANHYH; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SKGYbpI58XO3JSz1jHEdTrEmtQW7pYD75Zm4lS/J9i9YFiylh/gKi/1Li5ryddpnUTUh1foF0x+ZLM2Kh/EvLw6xL6JeEjmWkgNivBf9fycKcoOp+3PfMzFY+t8cCYmUp4KvUKGrQjBLpP5fw68q00gvvk2rYafYQAOaC8xg+W7RjvT2UWhYazmThULWXmUgB7yFfOGMaYc6tGY0rDqb/HsspGKjFcOhf4Wsf4eI6seJe7Spb0RKgSU1STSgUtkZUDOhot9c1sWSKv/VaPReXA8YDMP8Y5bOUpd0Tbh2ZtMin+19+ybL+8YN08L0LLzO6NIYpizS5mfvEMOnJu+bAg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEFrDBvkkDSA+xsOB2lR8to1dSfCcpVNl4KGOslKDFU=;
 b=JbELVUDzhRQzeL14hS76QxZkjGC8o9JLZviLpyVjmPs79PndBIOs1WPX8sgw/vEoY53R7IOee5rQJmux+580In5klyfHUmzFdhEdquiahUulCNLRkyBDGRPv8UscTEY8dizbbPkZUni74osZXhO+lAfywhnibQ3JuYMdVrUae8s0xDHYJcnnan9Z2T+csVjj0654gbdyk9aRlD7YUSVAGIC2aOryFcWxkHJDvPcEfsdem/T/LRqzJOexS5SEu6yATWEZ72Fsx8EQj1WJeQZ7xCcld1cFO7GXn/GnkiyXanUJ0vDWi8/aHGNpsGu+uAmi/PDWEeqdXSw73HQGdXLDSQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEFrDBvkkDSA+xsOB2lR8to1dSfCcpVNl4KGOslKDFU=;
 b=dTHANHYHZLVO6Wg4BpnduSsPFAeyTraxQ+ATXNHnb/vYCVfwwXGlD6OU9kAmBkKB7okTiaKYbvy4oRp2xWXL/eO3cFQ0TcSjLRCI7ayPz5x4YiE6hGOa9G3CMZpeVAwg9oQY/WjEbhFa1Pr/k8n3juq+bDcWusbp3aryZBfBIMY=
Received: from DU2PR04CA0151.eurprd04.prod.outlook.com (2603:10a6:10:2b0::6)
 by GVXPR08MB7824.eurprd08.prod.outlook.com (2603:10a6:150:1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Wed, 20 Aug
 2025 18:52:13 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:2b0:cafe::29) by DU2PR04CA0151.outlook.office365.com
 (2603:10a6:10:2b0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 18:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Wed, 20 Aug 2025 18:52:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CO/QhbYW95knyu0Gz2UyPcSMC38OGzGNp0H0ux/RJ75Jdh5yXkULe03TBZPRFpOdZvfcqE0rqibThJ4B3/KkGG+Zsit0zY6SzmozOBv3taGBzKBp4Fd2ovoyzBAHC1NC6cItvFTZioF9itdP/cvyvj5O4q2Kk9LQvIXypMiw2a+cuCueyoUgHzm3eRR3GBXGMFh4qCq7j6Ey3CFxSdQJ0GzUnXGTlB2gBIXXruBaKqLIoDZQnR1IfNBzZ33jpV4fNbaaKgXNsmMb5dknLv9C/+OcFO7gZCGFZ22CrZgl9ZLqtfJp/iy3wvC0RQer7VR3O1ROfkvKq5a5y0X0nYeDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEFrDBvkkDSA+xsOB2lR8to1dSfCcpVNl4KGOslKDFU=;
 b=xArftWUD2KT/UXQq8J8XwhgSKpDMg+p9OSssK2KaA37UaW0leKRveCq1QRo5NSWPLI0/PEoc0J0TjdsnTJFEBzFVNYclvZHTa+o8SFFjXp8HU0q2f1+WuuwLMawGRf3/8woOMzcLO1jlOUnldAxzED4GcWJYIQZjLevscLFREbdQAkcaVE02Tj5WCA8AhI20l+IADPz1FcHZ8zgyda4AfbbjkBDTfV6rx5NUc2GtIC1hFji58qR/QLw2TocXXgOpd73h7xErvX950xEX6Gri6B8Kp4D8YwNeku6WR1KSKjsUO6fWCNmUJFgMwblDzfmRVDqMDHe4VH9E6MO9wSdVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEFrDBvkkDSA+xsOB2lR8to1dSfCcpVNl4KGOslKDFU=;
 b=dTHANHYHZLVO6Wg4BpnduSsPFAeyTraxQ+ATXNHnb/vYCVfwwXGlD6OU9kAmBkKB7okTiaKYbvy4oRp2xWXL/eO3cFQ0TcSjLRCI7ayPz5x4YiE6hGOa9G3CMZpeVAwg9oQY/WjEbhFa1Pr/k8n3juq+bDcWusbp3aryZBfBIMY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM9PR08MB6708.eurprd08.prod.outlook.com
 (2603:10a6:20b:30e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 18:51:39 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 18:51:38 +0000
Date: Wed, 20 Aug 2025 19:51:35 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ahmed.genidi@arm.com, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, kvmarm@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 1/5] arm64: make SCTLR2_EL1 accessible
Message-ID: <aKYZNygBTVDurhDu@e129823.arm.com>
References: <20250813120118.3953541-1-yeoreum.yun@arm.com>
 <20250813120118.3953541-2-yeoreum.yun@arm.com>
 <aKXlYhhrNp/8StK2@e133380.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKXlYhhrNp/8StK2@e133380.arm.com>
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
	GV1PR08MB10521:EE_|AM9PR08MB6708:EE_|DB1PEPF000509F8:EE_|GVXPR08MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 98337bc3-961f-4bbc-c3f9-08dde01aac82
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?zKhMuO/dq5QiMtVydp/8KrYx6WHTEtgtOv0Isb4a3MYDymTDVdvz6vP2bdY4?=
 =?us-ascii?Q?56k2Bpd4RIyKAB3FT1h5bW8ukMxnmcQvK2kar4CZB83i1p5k2XHFo6UqnFe9?=
 =?us-ascii?Q?t21sZ4RuyKUXkfa1KxZagFq7K9t4xyi5X5zLER63zztv4Dmtd/f6UpJ/6K/R?=
 =?us-ascii?Q?GsHh1r3m/1PbzSNMPZi6lBI7oP584baTHQxy9BCNyyEfLQnbDTAXVxq5bpYg?=
 =?us-ascii?Q?zFH/XlJV0myz3jqEqKV/5yi1coa/XobbC0fJ34waW61pMVzu++LLKlgUcHpc?=
 =?us-ascii?Q?kRfaDaQHqO6+wNnvxSFLo4fjwkFsF9QjUOPAG+BwaAaxaFfemcbxAfSZz6vv?=
 =?us-ascii?Q?/zhdKshhf3UPr6Yo0AqLEeQZTXrjaJBtKaRpQ04MkN60xxYRsJ4Pmb8quHr6?=
 =?us-ascii?Q?rLFlKRZ7sCunUTf8zMMYQYMsROQ4dufgxVsAIfxUcjLrKjHFWmFqpOQyEoT0?=
 =?us-ascii?Q?khucfcPnKNjrN9ipzNil9Liy1ncWRkynA8kEEvl/Ymr3cj2E/RnNTw03XWfw?=
 =?us-ascii?Q?vKn7EnyT1LyeL2Difit1cOESHqVH8lEEW4sriBWKeMs8Nn8kmoU5KePmFsHf?=
 =?us-ascii?Q?GpipoFfWiPwKe5/kGWn+X2DAMJGkWKpNiXUVetV/PW2EdhsEIDBnz5hauwII?=
 =?us-ascii?Q?7gaBDw0Fk4YpOKre4EOhVUs6Y8Hlpnnjg7S4+xghAz8XiVJdVzeY6S53qDpi?=
 =?us-ascii?Q?9JscMggxsUrb0r2NwDGCYXHGwHbgAN5K7QJ507TtVXQy9H8KuHnzGjMo78Zq?=
 =?us-ascii?Q?VpBui6auLOV5MZDzmDAVpsoFMaiY/kNBhYufgISaT2/i9kzHZLDc+PENJZAK?=
 =?us-ascii?Q?6PFZj91zHG6forZOczMiTapVQGDDGkB0SHE9yCZTG6PoWLMrn9i8ZxYP/AVx?=
 =?us-ascii?Q?hdKwchiDBQ6WWbrxRSioamW+WxDpbXyhK0QQ++PtzaE9uLBQuVOYdSsaJ2lB?=
 =?us-ascii?Q?bE/xyhCk/KNt3qsJhk5BitNJT5Z/CDcBLzdn5Ds2bfrQUiDlxJdk5pQkk/WU?=
 =?us-ascii?Q?oi9DWVtYRlC6CEEAVsb8ytzlzytTIeuyuJUw+vFgA729RGvDJsB1LQ8r+GMT?=
 =?us-ascii?Q?+m6N/4RbWkmKgHk1IyAvmEEVGJINwVD0RhLWyEdRv9eE4gIOdnSGZForXPaN?=
 =?us-ascii?Q?7T+ugvYj8/qX8I77y0b+QTctEFH3CA7lwPb1bYanDXfpFtFz7f/CCBhj6bL1?=
 =?us-ascii?Q?NW+zKXvON5FKOQAIFDMpGYHvfs2BumbphQ5SL9uWl3hG8DL4anTYvCdmKS/I?=
 =?us-ascii?Q?8cmjhgFJIzWs/Tx5F9dsVxSbt80FdIkKAqOS1Lxj6zhQhjFWkZnOFqqVlivQ?=
 =?us-ascii?Q?Lvc4V5+MLjLc/28MPeMg2VKyu0g6IgZ3BjXqQCJ540eD5NicopwZiyzjYnpt?=
 =?us-ascii?Q?DdL8dJNn3AQOfEVbqwyXo8vLspHDhW6x19lZFga095D+4o8kcsSIaEQmJBF7?=
 =?us-ascii?Q?23gO9p/ibXU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6708
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b81381f9-3c23-4fa4-2612-08dde01a9844
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1b0mWq45oWsqISRy7xJQTApGw9aDwQTOXxvp8qCzn1bPyhSGhBbXSkI+W9nk?=
 =?us-ascii?Q?6Phu9RXNRABB4GpkIwk+NOa2FEwmAVeSqp6/0kikRGqpvNbPvTdtNwDEbgoa?=
 =?us-ascii?Q?eSsU4a4or2xLuchfTiXMWDFVLgdkE9339UyaBqQzW692mEPRGdRxRteFybEB?=
 =?us-ascii?Q?aNTSA1TPpz4XB6UFaQ9F+guOB+WAlJKtWzUUzYL7ZK2nu/6Bts8H5H8EOBza?=
 =?us-ascii?Q?WD/Nx6GVQkMohSKZb+TrxhTwnwfJGgoazp9c36MiBs1mZYccnNX+Azsh/t3T?=
 =?us-ascii?Q?y79i0ND0QGbU/tlRbng4GKiC2x+09yTed/w/gtyxbIYCr8DsM/j4mmisqyo8?=
 =?us-ascii?Q?NII9E2gpQeOiHeMp8300h+bKS+8BIGZM6IsNk/Qg3mS7oYQiWoJ/Who0JDcQ?=
 =?us-ascii?Q?I6Xc3+qRSvl4uOMZyzv7wIUCpuIZWox2TSizrp+As8NBJ12oWRN1SUTnCsit?=
 =?us-ascii?Q?/d3KmDehbG+cdSUxsA9bhbA8pdBzjS9nwa7S/KhUUBC3p/Z/A0rQllbVNEcg?=
 =?us-ascii?Q?ZJDS5CFZNePUHn2A4QhODRYGfXs+3AnWNLRCZqcy4sVx2XO83g1rq2YbNcCR?=
 =?us-ascii?Q?exhGVmiHLbLaXdPBwN6nC+dxECPd8sfVPzRR8e6tRAK9EkIOH8WPJk7jXyWX?=
 =?us-ascii?Q?7/GtUB/lOdywrgF0QB8NJ3x/9J9oce2X0ZPviayXLTbWMNFE/tl+kYYSFxCd?=
 =?us-ascii?Q?+2qkwDQAA69R30hJGQqKmXJX8fDUR6h1LFWoNJCacRhgVvzu0bzX+mV9CXkN?=
 =?us-ascii?Q?AjzMKu7UFE/cIVY+SeZB1P242Bfcejh+8VEwD7JI+PJZBW68lfmFqjrLfCBJ?=
 =?us-ascii?Q?I0N0abfZ/jegiltzCprWI3y2mXxblWPNNeuuqawhJlhhHMY18PW6x6eNZVsB?=
 =?us-ascii?Q?QikwrKGcXXCTJ3IsTjZkfnphQ+gxTXoz/6BJe+eyBlOtZkqEYApwOPEFNkY+?=
 =?us-ascii?Q?7pjpl0wdOBvptNn2BiHW7Rry91MnL2VXazMvFYrLze5sgnhgjWFjodkD16TJ?=
 =?us-ascii?Q?DFJh4Afud8zJG++Lu8rzKgA1EjNFr/Xc2zUo98gTLN4aAPV/tjpbF8LnlzRh?=
 =?us-ascii?Q?fqiPpbArCdm+q6cBExtu/WF5IIgbt1oG+KkK4NdNRa75uvxTtXFAM8mqtSWp?=
 =?us-ascii?Q?JFFjMrkOU73uPxAwoE9ci1g56/Xc5XlEynybvG7xmOOSxNZord7O12Sdmrzi?=
 =?us-ascii?Q?CNRSKqPfJV/X6NZvsI8knmZh2l0dkwFwKCUbEvT92UEUGUn+2oYLG912SeJF?=
 =?us-ascii?Q?tD6JOtwMvBG6cDXpbZ+YQwo40PZ3tpHEsq5j3QQiPLD8GBepCy5aRLOXu8e3?=
 =?us-ascii?Q?0DBFgXwh1GNQbXBSCnm8VvK8qVVAA4GQFTZyXgKfGaNWJZl7WiobndPO/FQx?=
 =?us-ascii?Q?/gsW2M0H1UCkiPUHJ4Bwtp0gpv3jdMnSJHpqsfb6hZzgwpZcOKj9LLhkdq7r?=
 =?us-ascii?Q?b1BO6syBazKZVucccV8p05qenztV2AF8RRU5nxOZOjeD+W3ymhx+H9rnCzYT?=
 =?us-ascii?Q?zS6oS+hK8n7gqcseoRHFHiS7X0MkMXmb2ueU?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 18:52:12.3521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98337bc3-961f-4bbc-c3f9-08dde01aac82
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7824

Hi Dave,

> > When the kernel runs at EL1, and yet is booted at EL2,
> > HCRX_EL2.SCTLR2En must be set to avoid trapping SCTLR2_EL1 accesses
> > from EL1 to EL2.
> >
> > Ensure this bit is set at the point of initialising EL2.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > Reviewed-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/include/asm/el2_setup.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> > index 46033027510c..d755b4d46d77 100644
> > --- a/arch/arm64/include/asm/el2_setup.h
> > +++ b/arch/arm64/include/asm/el2_setup.h
> > @@ -57,9 +57,15 @@
> >          /* Enable GCS if supported */
> >  	mrs_s	x1, SYS_ID_AA64PFR1_EL1
> >  	ubfx	x1, x1, #ID_AA64PFR1_EL1_GCS_SHIFT, #4
> > -	cbz	x1, .Lset_hcrx_\@
> > +	cbz	x1, .Lskip_hcrx_GCSEn_\@
> >  	orr	x0, x0, #HCRX_EL2_GCSEn
> >
> > +.Lskip_hcrx_GCSEn_\@:
> > +	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
> > +	ubfx	x1, x1, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> > +	cbz	x1, .Lset_hcrx_\@
> > +	orr	x0, x0, HCRX_EL2_SCTLR2En
>
> Nit: prefix immediate operands with # please -- see usage elsewhere in
> this file.
>
> (This comes from the legacy AArch32 syntax and has never been required
> by AArch64 assemblers, but it has become a tradition in the Linux arch
> code...)
>
> The only execptions to this rule are macros (mov_q, mrs_s etc. --
> frequently they have an underscore in the name; "real" instructions
> never do.)

Grr.. My fat finger.. Sorry to bother you.
I'll fix it and thanks for the great comment :)

>
> > +
> >  .Lset_hcrx_\@:
>
> Maybe rename this label to .Lskip_hcrx_SCTLR2En_\@, so that people
> don't have to keep renaming an existing label whenever they add
> another block here.

Okay. I'll change it.

Thanks!

--
Sincerely,
Yeoreum Yun

