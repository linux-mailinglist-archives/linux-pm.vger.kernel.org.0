Return-Path: <linux-pm+bounces-31895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57440B1A2DC
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 15:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D9E188C476
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0144226E14C;
	Mon,  4 Aug 2025 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S18CPVxx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S18CPVxx"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB91236430;
	Mon,  4 Aug 2025 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312743; cv=fail; b=uwzyy/LhmQsXCaUmHKzzVjO5FyUIRemLZkAFUns9JgZ+zM0ZdvT5LVaWE29zX+Q0T/kEcH27kza4dqN4ORE4buTlhG1gx6GKasPQe4By67fbfMms05S7f1fi11vMZdihKp5Nxr/ZR+fI50FqGo7QwsvZ3kBM4/002Dlhu3XE8KA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312743; c=relaxed/simple;
	bh=T0FpS3fUJaIkF8VHvsGs3P90oTYu/652pnczEUwnCsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AnckdLt0Ygq8O9fwwLzBUchnqWTkshwxdiLpanzf3VNVZnsProtuKM47MA6uY9HSuQIXVt06+/Q1NwEGI81dX4GeKGvfEtyys/TrGKoj4rHuZQM+nMqYQ+6H8He33APuD/iby5INc6MgQ0h3o6zxP9wV+mE719Quy7cBg0UpzVc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S18CPVxx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S18CPVxx; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Y5ujIOZUg2/0LZRLr3rwCyaABKaXsQSWtiG1O9teeKAby8V0v5UzJGBgFGcecr4O0opkbEAk8ECZYYQBB28puc4b70ngxjWciBlXLIOGtyGEmAHvE/rdH7nnmkkbr4cz3eBjFLB0/WBHYNYCObNZEnVSMHclShZIiHhivak50T9GTQ4cDjDQrfgOG81GfDqDrfXWsUpDcLWOZKYxIEA3JGdrJoZ81Zc94i3Mvdq71s2v6vIv9W0gD5MRGURCDbR/Hy6IMovXbESQ64j1/O4967FwJql3+GgZNWZ1Nl9ZaavHCWaZyZfoGQ7LK4umXTDLFRVcgxU2+E8jx5tKuUvKmg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t+/XuuZcGvrlYgS3Uauu3AJYpjMDcGHnSh9UuFLCuA=;
 b=w5ou6fp0faKy4GTH1APgwcVb5g18y9hpdqVEtc8pAySyyiNviQhsoxGEVGRWZS/duvP/cPoL8Wm34I0CJIzNLpJ72ULEm13TSxxNiwBBe1MVWaAOWO2di7fruDnBD8vIh37JIG+6XGP0PEoillt0OCQMLiYPQE/5LoFM9Ngxr0bISAJ1X4m52LuxYwKefBwtab3Nyf9OWTU4VsqggwkZZB/sh8hdxykpwAzvsFohjwzKjc2460FsAKau13li/WvhkvHRNrKwW4+kJiV9rjrV5rC0c+ZVpiOc8/a7ozngWe/bSHedK3Wo+bPwlD0+Mgik1n+ycF11uR1WbI3BI7MSHA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t+/XuuZcGvrlYgS3Uauu3AJYpjMDcGHnSh9UuFLCuA=;
 b=S18CPVxxacwtb8ZMkvlRPaNPI1VRCOtahErI3M6li1Jc1oQTD103y0Uinu6iEz6M7iBBUeSMgUtPny0ME9M3HDL6rko15hcVLCSKDQz4Y5gfUSct3whsbXHKJhP+1SLj6mH0MAn+3+aRHy0YegFzzk7H6vF0Nc4Q3K/N8fcAdKU=
Received: from CWLP265CA0425.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d7::17)
 by PA4PR08MB7435.eurprd08.prod.outlook.com (2603:10a6:102:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 13:05:38 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:400:1d7:cafe::48) by CWLP265CA0425.outlook.office365.com
 (2603:10a6:400:1d7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 13:05:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Mon, 4 Aug 2025 13:05:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnsO9RjPSML2s2iiGuB1fGGL9oY1umy2sc5Fu7hL2Fc5ywq9ouPeQ9nUq/z4XfDw9ERZXrxSyocn12oIjeR7h+JWdjkVFspM40sJ4eK1hS9zAs1A0lOMdn9Qmgbr3iNI4ihw7sAqBD4ybduq0sQs56maFr8EGCaF8U+M1/NV5p/5P5BhWtjaWCbzuaCwec/xBQEL821CHIcW/N5Jt3dbIhjyhREIMdJ13HIgzgFzaIsJAPA28rVKEChzC9t3zOGxOCoQRlwQ+HImbSM5RGWqtNgtWlSysFcnltAx3vJO1EEIKXZeY8PspnKw+ddAAwCHQ4topqJ0o1le3/xh+hMQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t+/XuuZcGvrlYgS3Uauu3AJYpjMDcGHnSh9UuFLCuA=;
 b=gWBzCzfOA9z/svb3frs2myeoLSDCo7890YEpSB76e9fhZYsBgDOqTrausbL/W7sYjikOtiG7YGA7+IA/EYinwNmXi1Ptin7MOyTDYskHPiq5k7DBps/bOG2C7O6nOU+QUbKIXoErd490+/g0sj5MUfay/3KZcwCJg7Pq/SMg6PjtE1+5A7BNX8oUSDgClIENjBiB4cmdantDXL/+6K77F3q2H8pQwmLTIS/uNA4wKeXOVdfWDtkKPw6O6NhX+y9DoE9SSc/aseaJD8AiTv7LdlVGatzpaSsSsjWo3fbuM18CJQlFPno6I3hHmGRgvT0x/P8h/LfV18LR9TfqzJGmNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t+/XuuZcGvrlYgS3Uauu3AJYpjMDcGHnSh9UuFLCuA=;
 b=S18CPVxxacwtb8ZMkvlRPaNPI1VRCOtahErI3M6li1Jc1oQTD103y0Uinu6iEz6M7iBBUeSMgUtPny0ME9M3HDL6rko15hcVLCSKDQz4Y5gfUSct3whsbXHKJhP+1SLj6mH0MAn+3+aRHy0YegFzzk7H6vF0Nc4Q3K/N8fcAdKU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV2PR08MB9880.eurprd08.prod.outlook.com
 (2603:10a6:150:de::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 13:05:04 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 13:05:04 +0000
Date: Mon, 4 Aug 2025 14:05:01 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ry111@xry111.site, Dave.Martin@arm.com, ahmed.genidi@arm.com,
	kevin.brodsky@arm.com, scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 01/11] arm64/sysreg: add system registers SCTLR2_EL2
Message-ID: <aJCv/VEG9XMKz7ir@e129823.arm.com>
References: <20250804121724.3681531-1-yeoreum.yun@arm.com>
 <20250804121724.3681531-2-yeoreum.yun@arm.com>
 <8451ed4b-7881-44b5-84a8-51cdfefff464@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8451ed4b-7881-44b5-84a8-51cdfefff464@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0138.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::17) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV2PR08MB9880:EE_|AMS0EPF000001AC:EE_|PA4PR08MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 783c3357-3be8-4be4-ad33-08ddd3579acc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?jMCVw8y4BXUPODGnBs1+QXdlDLrBk1wUsppDmCpd7495bf0R85+oxnpDqt1e?=
 =?us-ascii?Q?bCiAYunn0MGJI8Y0mcqcgcBUbeQ+eTLqnT/9ggDMHZvV5jhl1H052Pd8Zoza?=
 =?us-ascii?Q?CHUn/cpwKvqr5hTkUMTnw4TEfo7YQg2S77C1DS+e3Yy6546o+27H6FDA/gcE?=
 =?us-ascii?Q?u3JwQ1m0Q4+dVVtULY4CAPlg02kkJDvCU1o6H4krxxGn24EdffY5DTRgtb2P?=
 =?us-ascii?Q?u3jJFNaZfM0BQs/7ZX5bmiMrB21jCXV1RtHHU4VZS6U/rr0O/kGKyqta3deI?=
 =?us-ascii?Q?rKxII+67vAo3snF8FF43pg7ZrkFNUrLEG3Qeq1emkk6LRlG0mXd5Up9VVLpa?=
 =?us-ascii?Q?2oSKHCMWNXL77L7Z8TrHwFbmdxvEitjKXPg106QP5bu7Ow651mCE+w6567p0?=
 =?us-ascii?Q?9pm89jop3W5BTpXvX1A2rYRxwGCDOSBCsqqZ6BChFV3axnlGIE7+03a9m1lB?=
 =?us-ascii?Q?FhBK/qlNaWBZaklu8SbuUkXZ8/Qnv41BQq7gy0sk0RCu+oK7lpKmOaySCD8Z?=
 =?us-ascii?Q?rhAQopI5jQHP/O3nY+0XG8LAujwVD0qQtg9DxVah70LTze90HT9FwDSpQaZ8?=
 =?us-ascii?Q?/zaKyifFJIbOd0ktFArnUT7ZqyJWi46/pMcpqczi0tIeQtSemQdZgB/cWe6i?=
 =?us-ascii?Q?aMw4qkVnr105KlQmx+UGvOAWZ2JPpFQ079eW8hyMa2Tl2tX5ve87iIjwtWIH?=
 =?us-ascii?Q?MVoHQYw0u67gSOPXY/UwsPaLGhFQt6M7F0oAtfpylY/a2vUEgI5CzWPoVL1h?=
 =?us-ascii?Q?CJH3JP4mYhClZEfI2fgMMviPMOyuHV52gVQWwkBFAAAlBkmga7TauXgNDB4j?=
 =?us-ascii?Q?f7gJj4FqlFwUOzl8wVkpBOYLNpGwvWvt7ogfJkHmLSuy6mexVybP8nEW20xP?=
 =?us-ascii?Q?fEnGdS68bci2zlxVyrTszHI8560AbEMmLftxtD+WAYqAUh4ROff9jJOaQAno?=
 =?us-ascii?Q?i61fib95evDuYlPuiwvdcdiIarwehy7dreoJAQLtDQfM88pynecbB2uZUi38?=
 =?us-ascii?Q?5keCwR5NFSRzv5EsP5iFbhS3bhGBAId0A7phZ7vQz053GQSkb+lT4ibHCyAf?=
 =?us-ascii?Q?58gaY17XEsvg4HPUvX9unjBpBDm8MO6rUKV2DsAK85WFT7uihlHbXmbe3j8B?=
 =?us-ascii?Q?LpPU8RqyeG9RZcyUjK0FqkDEJAKOoZ4u8j/pAmcFaqY2aLI86CMCKV0j1Vp0?=
 =?us-ascii?Q?CO00sCFfra+w5wpHNzzuSv+qLltQhdDX9fxKnexCIOLsVoLprXZoZXG0pSx+?=
 =?us-ascii?Q?Jcdsk9LUPCfjVe22nRdJvr/6vK7JtgyackSNNMzQxNg4udhQ31DCd44neTmh?=
 =?us-ascii?Q?yPrZrr3F484P30TUXCS/uynMNqgM+jm3N5PBMh8HfGyqWo/VNVvtFdYUHt27?=
 =?us-ascii?Q?gouVRK3W0+v3v+surUo1OCebD+1spMzuPC112OCdNDGVSMx+nSx1Q9Pn1aOQ?=
 =?us-ascii?Q?mMYTnjnAp0o=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9880
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d3c13272-a13a-4779-bcbd-08ddd3578770
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|35042699022|376014|7416014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vZdYnD1vIbeoJqskSagZVS/2XpLw7mJ6tcXDpDdeQ44zOSCr1QrppOv2Nc8w?=
 =?us-ascii?Q?EG3Yb7+5Di9aSMuRkp24Q2CGgNd8ZP+jtRxJfLjK036fyhsg+dg1Vfx2q7ga?=
 =?us-ascii?Q?OY6nCRJ93goklKT2JO49aaIN2qEbu9K3Jm1Xrl/dRzlqF9atIuoUUv8IMLfn?=
 =?us-ascii?Q?x0eIM9bSME8l2A0Agkef4CE2jkJdlVE6VUO8O9iO0GtAOP5S80e4YI797Nsg?=
 =?us-ascii?Q?vw0FCSOW3FugYvMy5/vhMASUJG79FKvQvXPwodgIoK19Qa8v6O3nuDoR0hTb?=
 =?us-ascii?Q?/9to+BLqejBSgz8fjy1sM10AKgB8BpRMarB/q6myZxPyg+lk115TC3uqhbw4?=
 =?us-ascii?Q?GlISRSWN2K4qjPEK5Mz1zGMM8fAqW/WqBoSuZm5McHL8pBsqgblIzkxD1rQE?=
 =?us-ascii?Q?kXoi/5Rcq3xP4nCth95cEQHsmh9K7JS1UDmdW2JkQxQu814VVU6X8jLk1x8m?=
 =?us-ascii?Q?5Wzet8CB+wuPlDWWuPNO8WdkrlYhb2ZpZ8RqhC0JJqCm1Tel/H7B23/BqK/2?=
 =?us-ascii?Q?h1moFpjqsR3QshXS3Clysc08XMSXaHSrS9kKlX9YOfB+Ozi8rYu845KPiK22?=
 =?us-ascii?Q?d1VNWf2Wry1KhFY5zj7qpBkbEIVOR0AlfiCIRZhQocm9Vjpfm859bEX7rKNA?=
 =?us-ascii?Q?RnIz55RZWbRa76hwa8e9aQm2FJtQgpjAW5UCSRiXr3yjwUE688Pb/AP1LneC?=
 =?us-ascii?Q?CSobzxhjw8bwggFsnchjfe/6s0IR//TijsQLg6kI8OTIu+Xg0GMcr/iLnLiP?=
 =?us-ascii?Q?eryQaaJeeM5m1MA8v2RhYjA9M2To+i7yRE+fieFeim+DDBgm/Fmf/FEK+O3M?=
 =?us-ascii?Q?BTWlquUfEg7B5FdamDivjYomnLNRbglvdM3L4U9hBPVuP3tZyTBgGa376U6a?=
 =?us-ascii?Q?po8qjDolK89OVDuLlKkU6Y0yRU6bn/tjUhNXWW6DUyspWmnIZqsIthUIZHPl?=
 =?us-ascii?Q?BYCiuTPkkRF1ljMYzq3nwofnxjcMM70WIuppTjAjLHDkdJUlDYrV35hgzmZX?=
 =?us-ascii?Q?zLatsbQy8qsxdqhfsHB+0c790fRp+Sp8rtBdRTn9vASJZwQfF6tzEXWPavge?=
 =?us-ascii?Q?GX9F9K4bJuGo8AjmhfzSufPq/lhsbXjtlAaErBbBw6QkqOw8czTc4cXA7LMR?=
 =?us-ascii?Q?Zr1Z+tnweHm1KmYQoYjPs63WC+sofWscUNB+CALnMTm6IN/g8yY3Ppv0fKvL?=
 =?us-ascii?Q?OJj3aSKqf9O3BrRA6v7UzDB82bKDTDm/A+KC/zrqziahLxNTNNy9QkHm9v4m?=
 =?us-ascii?Q?JqEn0ZMWC1r2r4wimbTauJzFR8DbS+apG3x03Q7ILxiu2B7O4tF2ZTkHjiry?=
 =?us-ascii?Q?mkE2ejw452z4dgh0CEowTudbBmonPFEdY2ZtPK2oAxc87+XfwZ5Rrw2sNWAd?=
 =?us-ascii?Q?RMKvg5BFejd6VPEsrVCz7V9n2hffn0z8/2h6p6TRD0Bdxcr8Za+q8+dsqAFG?=
 =?us-ascii?Q?MgS/7fAjLsWrHFmJzQ9j8Ti8eukTFRiHsJyeObn8rhhtCAs4XFjeZHgPVD6s?=
 =?us-ascii?Q?mGebxV+uu65mkWHgvAm8bU24gd+HMvplI2na?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(35042699022)(376014)(7416014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:05:36.8353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 783c3357-3be8-4be4-ad33-08ddd3579acc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7435

Hi Mark,

> On Mon, Aug 04, 2025 at 01:17:14PM +0100, Yeoreum Yun wrote:
> > Add definitions of SCTLR2_EL2.
>
> When adding registers it's useful to quote the revision of the spec
> you're referencing, this helps people doing updates in future (eg,
> DDI0601 2025-06).  The update looks good:
>
> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks. I'll add this.

--
Sincerely,
Yeoreum Yun

