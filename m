Return-Path: <linux-pm+bounces-34897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7ADB81126
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 18:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454421C24FC2
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B435086347;
	Wed, 17 Sep 2025 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MWOPrisc";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MWOPrisc"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E02FB610;
	Wed, 17 Sep 2025 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127511; cv=fail; b=rJiLNtOzhyo/Qt+opIJHutlEoNNce4sleYf2s6ibXS49csc7ydugSH51NlmC/GSLdRkuXFdmYPdHB733egr3qLKKu7rHItM3I8Z3rrXa/k7sCbCso23adwmySVWH6S5wC/K/LLcaxW0rglPwTiQP2SIJsI040p/8MzOBBDM8iIM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127511; c=relaxed/simple;
	bh=ZwVFeH4cGB0QFDnbq+MyACf/m+TBLjzy00eC9Fo5Cp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nOH7C687cu9ubM7BhxUPF3aQfEm+5wtjomhSZfOS6mFeyg1XNVBI0+sUqxE9K7J8E1tKQdA0ubGUOOtKYDjrCekQ+vj7J7mcvu+7kVynR3/kBZMTo0VJcut8WT2dDnWkge6uVSVH+i5WRGV7l/GRY7rb4dDLZVmqVDWQcpGSDc0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MWOPrisc; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MWOPrisc; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NKQD7pvOKcEBwg/80NWP8pR5BVoGqm75iD5THdVu258uHqQjnAVclO1gqYOE0LMaROTLO84cjKJo7R0U3sg14D5glJrTxmcpI3CqiaQED4xCttf8SSWMvfzOwaMEw8piK1IE+fdFJi0jHEX/M6VBAlmPEHVtGcwDy75NQyVZfGl9T9zFwnkxrI54oNi2AQGbBuM2xt52vUAg24hL7Oz/ey4D/WjC0L7hMj8KA34xbKYwJDzRYpjrvcUYxrev588uw5XqmRPF8VcxNaUQGLa11F9J9Ny3eN5S5thZMOsIfioEntg0o/IxvSxfwJjXrWOGAG3Q5QqoTnIU6auDOc5/4g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+gVH5ELJ4AyGzMxPlzRRSSO8TFYSPQ6w2iDJoWxqwk=;
 b=Q/0ymkQ3AiLxw9OHWlaAK+/Dv6bQMSx0vOVRq06Hz9fVjfU66GwOhaR3pPBdv++L9KXp4IhOXntN/TfBRYDHEMAcXe+TUCQ0Uo5uHZ55gkqmj4BB9od6G6qCD105OmHEdxVvjFS7WIM3DPoP/s9d9h6tJ6FeN4ZcNNoXS0dd/9YMhSC/C8SAJ6RdyEzVMPxaSmho8D8rWMIwAH9dIhQQnJlMmi+3DvuuK2VCx4NoISVx/xMTbkhMUTT9LlTtROJOJa30f7U9pRVTer+XVncjU8DbmPJe6gQq6bFnjBk8aan+J4GhrchDi+OAYrVVAgcif6VYdPZL59JIJu8IzXbRWw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+gVH5ELJ4AyGzMxPlzRRSSO8TFYSPQ6w2iDJoWxqwk=;
 b=MWOPriscpC7fU8Lr4lYxvR1wpwm3ZE6AwCuPYGgpsmzifNNhk6PjNZjQVPqm8x7jvScUNtZe2aN9C5J6OLKZ/ywTSS/JYyOVpZHVKhdGaldh3JvFEfLhE7+1UhIGYMaLtwlIQWQlwOReXcOOvi40bz2vPeH2BWYuF6qpWvTVXRQ=
Received: from DUZPR01CA0199.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::28) by DB9PR08MB7819.eurprd08.prod.outlook.com
 (2603:10a6:10:39b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 16:45:05 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::3f) by DUZPR01CA0199.outlook.office365.com
 (2603:10a6:10:4b6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 16:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Wed, 17 Sep 2025 16:45:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nr/LBGo7+IrxgHzJamXuBjbnzAgzLLAHGjn9eyvuIm8Uzk5t0F1ClDGRdS0C+Rg2BLO20peGo9UZfoipkgGHU2li+HDF7HgRPZJ1pQYWHA2cDLlxMGEQkWaZpJ041GzniXI5cWJCA8KiPbL5u4JEkelTD15mcRFSHyR2f0ByUCfcNFk9G1Bp/hfwmFYEQAiqIl4CVmBvS0HeBvHBp29OBU10EzZCC97Pl9VT7UgK77OZa6nrcbbwk/qetKfx3pUM9etV2yU9oKNa0bcSCNi41VfNLvocfpMq3Gt4kO3l2QQoRuUTx2CvpWbUKCLnkNevEdF6tySr1Tto9rzEuMwLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+gVH5ELJ4AyGzMxPlzRRSSO8TFYSPQ6w2iDJoWxqwk=;
 b=SHRF5Jt7xl3b8liBwN5d+i2vVDwiF6Jt8XZx6Yv7ldznKhpkQnjU5HrZvjbVukNMKWCN2U7RlOPOz7dw1Tui/TffezNcp76hoxEPriqMslMrmsByozBgsJ5aH0X8TgQvuPrrtYFQhHnqPMKVsEZwgK+Muk5Pe5Kc6n44G7ccpQyUi8+rOOmThVg+Huz9j2hy1QBXrqNV06XJ1EA0mpIeuEmQ0sFzyzK/+8yVuy3KK1yQ3fVXxM7Fzkjtn+OUsEWxKmSv8p5TsRoIh5XgEV4+n+NZW6oCsk5o51IsqxIilJIs/BV0ZlwasjWWMlK66YjlJ/s4uu0VI6bpTPh7mQPoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+gVH5ELJ4AyGzMxPlzRRSSO8TFYSPQ6w2iDJoWxqwk=;
 b=MWOPriscpC7fU8Lr4lYxvR1wpwm3ZE6AwCuPYGgpsmzifNNhk6PjNZjQVPqm8x7jvScUNtZe2aN9C5J6OLKZ/ywTSS/JYyOVpZHVKhdGaldh3JvFEfLhE7+1UhIGYMaLtwlIQWQlwOReXcOOvi40bz2vPeH2BWYuF6qpWvTVXRQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU0PR08MB9226.eurprd08.prod.outlook.com
 (2603:10a6:10:419::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 16:44:32 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 16:44:32 +0000
Date: Wed, 17 Sep 2025 17:44:28 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, broonie@kernel.org, oliver.upton@linux.dev,
	anshuman.khandual@arm.com, robh@kernel.org, james.morse@arm.com,
	mark.rutland@arm.com, joey.gouly@arm.com, Dave.Martin@arm.com,
	ahmed.genidi@arm.com, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	maz@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v5 0/6] initialize SCTRL2_ELx
Message-ID: <aMrlbGs0MKlWKUFr@e129823.arm.com>
References: <20250917145618.1232329-1-yeoreum.yun@arm.com>
 <aMrTkLhLOhas8Viy@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMrTkLhLOhas8Viy@willie-the-truck>
X-ClientProxiedBy: LO4P123CA0697.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::12) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU0PR08MB9226:EE_|DB5PEPF00014B91:EE_|DB9PR08MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 3722f37b-12a0-4750-7069-08ddf6098e22
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?WLJnsNwagF4t8P7w2wmjL/KL1qoiFFMz52tXOlTwqQeq0P0JKeTN/BXLAOJM?=
 =?us-ascii?Q?RvbUwSU8RENuzL45pcg82Zt1qxplv2FJw/tigHVNAtfbIZpsGgr15HAx9pzI?=
 =?us-ascii?Q?H+ikPUsIsvvCioNxIkBma3h1h5+NESd4EM1ZYsToFoEW/Pvc/VLcO+hzbxLe?=
 =?us-ascii?Q?50UDrMrIpQFnM2sSVeTk0YYNDumMpwo2HpcT9JzWlyWuyEPQRaxJg8/fxztC?=
 =?us-ascii?Q?m3RTwQjpfHD3vMOkD974xmS6yawN7br+cfAMSVeSmUKHlUWPCJpiwk2LH8UJ?=
 =?us-ascii?Q?2PQ4gD9i5oFyNn1Z8kCzoJI4abXsfTaUtftBjRSJmVdxSiXM8uAzuJNEsu63?=
 =?us-ascii?Q?ddDbMj354qO9RAtGsrY+HISYTbgBYIfPmNWjnzjcI0dLjpNDaoV71aWZSBqn?=
 =?us-ascii?Q?guAIosLtgU6JW6WSM6/xDyVpXdk4Q9TvPGs/QUO+QIIwc4mQ9KX9jdLcZWzV?=
 =?us-ascii?Q?yxEbbBq4sxhQlv2LQYatIvs+UuteQB3LkPjgSVw5dmeKa/+cZmWhlRsRPxJK?=
 =?us-ascii?Q?JaMdF3mSUAfoRap3d5SKXJZbjyEaG1RIEYJc2hIXA74FET3f1PwL3lQ0xxrM?=
 =?us-ascii?Q?0H0jZbNfWcVKLhS2373n532HYgQ3UtHaDfDYpqckABwSqh7h3w6iz+F4BYj3?=
 =?us-ascii?Q?p0IYDcR8qfncIcNhnUNIgXS8fuO9T5e+xD2Djl91dwYAgoKeYJjDJMyiJGfr?=
 =?us-ascii?Q?zXPwykNzclCygCbL52+wzNcw8VmsfFc012D8acW1R6NTsZJnmYYos6WXQcEf?=
 =?us-ascii?Q?kIy385P3afzJGMxM3QHjK/HLJQ/1bi9gbG87O+GtZleaitekb4ql4NofaMb3?=
 =?us-ascii?Q?kE2NNHlElNvSlHWlYPSK6jjSOKnaHV1Ol+fS9ze2BcKyxfO2PCPEzKzgqCBZ?=
 =?us-ascii?Q?+rIpGuRBxOkYYFHqR1KwEfPcJTa7SXtGBuX8wHkAoXIDlJ9AYjw6YFK5PpNW?=
 =?us-ascii?Q?dAD5Sbasr3XpBlaf7X8fYEL2tXKdHagDdU5HKgVIOhQkX5tCinHC5ulIVpBl?=
 =?us-ascii?Q?UYPm3y1yov9IUqFF6FDv4BYpVVkjAfUPWgjdB+fnqAiFlwEyHbWRPT0w1/aW?=
 =?us-ascii?Q?E439ISQocWd81c+oZglBw5bC3EFOmVhodqJVOiul4EMXKkKYFhp2D/VoWBkB?=
 =?us-ascii?Q?a0hsnG9w7L2eyQY2Iif/47g0YqrPNmtDkcnvlLtJcJ1NDStiFAVt8w2UHqBx?=
 =?us-ascii?Q?ZB7o4Q4Y2Gwm/1ojRfhsvLnwNzP4xoLOj+SUvoqrOoDiVXo9qB6D9Zab3+75?=
 =?us-ascii?Q?wP7HfPKiUJeEjlCQkTT2hHealhuLX6p3MLDGRJ9HSxVHqTVwXna9IDI+LkLB?=
 =?us-ascii?Q?uihdYF5VLZqHcdlwsEzTtVpho+hDClDsTeBmpxSa20kSLbKP3Pryz2xO2tOJ?=
 =?us-ascii?Q?tVX6t+c=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9226
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0cdc5200-5264-4766-197f-08ddf6097a16
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Ft9WXSM0uIHPbystZfNOPhc7N0r5AHRGW9NEi1XiMoNeAXruA2Rw61cD2/P?=
 =?us-ascii?Q?kYNYL5FYgwB0guIk3Wt77yNGtvoLqQj4PHBx/umZMJVbC2AY+LER+IIt3Szb?=
 =?us-ascii?Q?HRQ9ZSLSaFQHFiOGSpKlz1JfnQ7laislQ+qE2PuAcJ9BcOaGphLX4ChYMf2L?=
 =?us-ascii?Q?2OzOfIMWsDuningxNzezrEykG+3AhtUhROpYIzD3tCJyPWzIgr0HRIRqmkxA?=
 =?us-ascii?Q?BWYVjgkp/ElD2h6dc5tycHLvMc1BHDEKj3uNm8CEcvBNIGBUyvqGWdCFlih+?=
 =?us-ascii?Q?R8B7ATLfE8uMabs6LnBd6pesckFY7OcALydeDaOGgs8WKMvRjK5PnWsd0TMB?=
 =?us-ascii?Q?BmlILv9TG9tR6Uuco8mZWpCN17FSdY6LDKED6eYtNPwjbJSQW0ulJt+WpRCk?=
 =?us-ascii?Q?86jYidawz42wvDZnBv5Jl3l02RoFQKVYB+jj5FzVoXQV0PkWOk9eytN0nbs1?=
 =?us-ascii?Q?iU/ygK1UePXYP1GJ3EQJYKTs4Tssj5GtI9nZrRSU/Tn5rFWC4AhvUvDQ1af2?=
 =?us-ascii?Q?RaBC/1LHiwuoKvqdeg6dl06L8QtDE+VUlsisIIoHImXYSOdOeX2UmUOUIzAy?=
 =?us-ascii?Q?j4s3xKcES4J91YVemga7lSVDQ2CCGpWX3lniITV/kGJe5trqFWrVY3CYXHwv?=
 =?us-ascii?Q?JSvwLKI69nXw0bOzeoPZlmioNa8cfQqJeUpNyAiL1razGU1DuXo40pSyy6H6?=
 =?us-ascii?Q?AN26Ur7eu1f4R5KrjpeuMZqVkVg/HAiuosN7IYulpRoCebkOTbWGA43ndZll?=
 =?us-ascii?Q?7OOiKQEYBW6wzNWOJeUhybx/NRyOh5hjW34Ntq1BjVbh2U5N+HQ5d/vT+eGh?=
 =?us-ascii?Q?0UuOjYa5ZJhMg9yHeYh1ZXXa/hjAJq8THN3qK189GriV77DI0zd16Z5IboKn?=
 =?us-ascii?Q?+dgTh/iRgVhydXn4PdSMQXezdeE5LXrIqW9j+qu2tlCNdy3ef8v2iP7iD2zZ?=
 =?us-ascii?Q?9Itngmg/td9G1A99WR8wZJLfqRuNY+xXI3+y/3Dl1U1gMxBDU47UWuSclylF?=
 =?us-ascii?Q?roorPizT83WaJuKjVaqTpxJEnmRthyTs6kJ0hcbe1tJkgItsF6Ro2RkFSgdR?=
 =?us-ascii?Q?ukZkf47xigtUhIaXjdcmqzmWH8CxUvMU9jbLoGtvITT7LUTSe9AM42NPHnlQ?=
 =?us-ascii?Q?Z/s955tCIo3tAC9McRJH1Lr1VOmP7uIMFETzkuE0rpQIT1Wl68jREWvoEhiQ?=
 =?us-ascii?Q?BRg3B45Sncklj0K3i02JgBiYa1mXixS4mRJVWTpbKOdZ+SA0NZiheOVfSIj+?=
 =?us-ascii?Q?4qgSH+9klIV4bjUGqnTRhuvAvWuZfG6xcaGzSwgECza8clkBwl3UfgOJD1K1?=
 =?us-ascii?Q?Svnx/FK3Xbcg2YCp7gRx9D192EYrx6w3Xp9T6OWjWh1fX6DV1/h45vlW0tr0?=
 =?us-ascii?Q?+lmRloRXK6JKEC4CI7PuVKSTYZ0NKY2wiQjJEaxU5ErVBRhsPZN93qjHwRdQ?=
 =?us-ascii?Q?+mp2j3yRll7rc5DtSxrwCIjnMA1edBG5KZQb1e6s+9Ts7QKEpOtV+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:45:05.5215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3722f37b-12a0-4750-7069-08ddf6098e22
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7819

Hi,
> On Wed, Sep 17, 2025 at 03:56:12PM +0100, Yeoreum Yun wrote:
> > This series introduces initial support for the SCTLR2_ELx registers in Linux.
> > The feature is optional starting from ARMv8.8/ARMv9.3,
> > and becomes mandatory from ARMv8.9/ARMv9.4.
> >
> > Currently, Linux has no strict need to modify SCTLR2_ELx--
> > at least assuming that firmware initializes
> > these registers to reasonable defaults.
> >
> > However, several upcoming architectural features will require configuring
> > control bits in these registers.
> > Notable examples include FEAT_PAuth_LR and FEAT_CPA2.
> >
> > Patch History
> > ==============
> > from v4 to v5:
> >   - using .ifc in set_sctlr2_elx
> >   - change (re)initialise position after SCTLR_ELx
> >   - add docs for SCTRL2_ELx
> >   - rebase to v6.17-rc6
> >   - https://lore.kernel.org/all/20250821172408.2101870-1-yeoreum.yun@arm.com/
>
> Sorry, this is a really pedantic nit, but please can you fix the typo in
> the subject if/when you next post this?
>
> More importantly, as Dave says, I don't see the point in merging this
> until we have a use for the register. At that point, your patches can
> hopefully be a prefix of the series that uses it.

Okay. Thanks.

--
Sincerely,
Yeoreum Yun

