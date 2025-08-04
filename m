Return-Path: <linux-pm+bounces-31916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B66B1A572
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 17:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332173A2690
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5BC214818;
	Mon,  4 Aug 2025 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SHicY9eG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SHicY9eG"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530E137C2A;
	Mon,  4 Aug 2025 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319911; cv=fail; b=mHOOTCRCvFA/iD9BMPAxu7JIOelzeyGs4OraB1byob+U83qBxHF+Pz6g0XrPOz7Oxr9Kjo0qBsvIBkic8rZ+TvhKBk8Uop2o2Pr5O43y4JzdJieH4xWbjPrn3IA+Otp5RB4LdKMZNlB2wxJWxarwwVV768BJvwA42ZiZOUks5kQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319911; c=relaxed/simple;
	bh=40/9PnpERQHHUjBiKguh2AbDR3zs+yum+urw0lzc+I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c9xOxSg30EVjG5T+mD7+0ByY3HjPvJGLT2yL6lcQj+90RWMxzoBeOgxBt2X4Jed9NOYR2dTqujD2f2d30/0LjfY9wkRQi7HpZPoMB1cFH5aHrrTz1iDE+DyYmreeUBIcU2o+2k9OK7jjcig9gnqsyaMb2sNu3CK9LiToxiTFaWo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SHicY9eG; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SHicY9eG; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=F+WilQL9R9mTBm8wIiCSfWHPnCYKPmEP03jjFkJ5sAsuZfJQnNvhU9aJ3FxZSvmuWxa6SWs96GSm+xdktVJvo0k8D1QwfmUnCjab6iSn7H8swBiXdjw9e3EYfREDPNerRp5liWGz0qkmauZ2jXPA5F7rDghLSlp0AWuVqZtXFGeX8AKkkOtWD2Ur4aIqqtklsskimaR2uKTSH6EDmRAUSnpz48mf2+6XpbGs8L642sjhygGNAdqqZ/PuqOhmpWoow7vi4lOUa2SuvgliuVPzIksUgSaWWI4H28BnqCwvEUceeJh9kOuU9wdN7TNIuE7snIzlUKS2qWeeqWwc7co4rA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0tTGKAS/E8ofpb5WcCjGZ8pOSobw+Dvjf1Mj9Z7A58=;
 b=A2sPI7NA243V3ArnUngTDA5+vmKAKtAK/84Q4JuDi2I0Jpp82cRUZK3V9Cb9sk2brSgxjGfHCPJQNQGj8DJJftsX/9xIQTYTKtOp0TddgEk3ciUCMyrR5OyDW6uFsapDG3PCf2hgBX+gj0PcrhP2E4ivNSGBY7PMLrew/u+Luz0AC4JcqS3PMCgPwOMBH8slHZPeDYqKh6l8RmeHEhIf6jMt9Z4Yfy5wquSG9H9ButNkMrze09OrIYUcRh+1W6cQC5REEbuFcW7zZoDLo9FgUdfU3I7+tpsf2gh3gewF7zJWYc5OPIEEyeKPHx7CMOdxjwww5TSq1EagRJBTqO5WhA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0tTGKAS/E8ofpb5WcCjGZ8pOSobw+Dvjf1Mj9Z7A58=;
 b=SHicY9eG4cHJomJlFN4Xx2DFneJ9wyqUcBgPZkGmeXdB+wGgdXziraAoJ78N4ngyjdOibhTMH2ctRNwxtQ41mZ72zNpoA1PEfA11IhdEzmqKeLrOunuY+byFbnj69BHvBy31p3q7Lt/Yg1iPAPkK9U+GrRqalTEbeuvFOeuXNG0=
Received: from DU2PR04CA0213.eurprd04.prod.outlook.com (2603:10a6:10:2b1::8)
 by AS8PR08MB9314.eurprd08.prod.outlook.com (2603:10a6:20b:5a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 15:03:41 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::9f) by DU2PR04CA0213.outlook.office365.com
 (2603:10a6:10:2b1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 15:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Mon, 4 Aug 2025 15:03:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM+z93E2JKzbO989JJz417QK9oB/BPhuhn+4DWOuU/7VqdCbZ/tU6OfJAgkDLkvcKZ+58w+cXHyVMCxaVCupv3qs5tZVMnGlOuIgBnUM3fOaGOdMskV5dkrrUpEuuZCRAk87Oov/lr1Pl73DdoB/18Ng0w1GR1pOhFUBQnPY80f0SLFyj/i38lJqU2j4nSdIZ1sYkrALZbL/i8bELP8JQNMmJ6W7Zmr9yMPoxn+Au+bCAt1XKsV6JOiah24pWRh+5F+xmjEwkxVaYGDDMSzJI1Hlv3nO33adhToO1Cd50DxhuqeDJZZ0PA/+Ss00duMtaAGB2G6BeMPOLKhFdZY6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0tTGKAS/E8ofpb5WcCjGZ8pOSobw+Dvjf1Mj9Z7A58=;
 b=woo7PdGZx2yskqo8XUhlnSeO9RGXHxB96FxHdFGDUiOZlKzbTsIYrSqRLRCcDJD/x8Vbq5ssxzQnS8HygdEAqjULsUMBQtf/0MW/XC4+Snq6k/ZOC4OhvCOPvsP7cw3kYIROh7KizBfUwX6hJoOMuXW98fzoaFI+c/kRFQ+nJoVhfAdHWH1efllHLxwSpnk7mOEqvOIz/YHEgn2AfjCJLiH//WPoOnbQl+ZHlPf5Tdstf2QatnjbcXspQY/9m07khAGVBwIv4Eu4Hlo5c6OBp7Zma/cg3BTrVX4tvaNXT9umisRhNjIqQzUMvGI+3D9X2BHQyg0ZoslsbN0V4bzfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0tTGKAS/E8ofpb5WcCjGZ8pOSobw+Dvjf1Mj9Z7A58=;
 b=SHicY9eG4cHJomJlFN4Xx2DFneJ9wyqUcBgPZkGmeXdB+wGgdXziraAoJ78N4ngyjdOibhTMH2ctRNwxtQ41mZ72zNpoA1PEfA11IhdEzmqKeLrOunuY+byFbnj69BHvBy31p3q7Lt/Yg1iPAPkK9U+GrRqalTEbeuvFOeuXNG0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DBBPR08MB6220.eurprd08.prod.outlook.com
 (2603:10a6:10:205::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 15:03:07 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:03:07 +0000
Date: Mon, 4 Aug 2025 16:03:03 +0100
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
Subject: Re: [PATCH 10/11] KVM: arm64: nv: support SCTLR2_ELx on nv
Message-ID: <aJDLp+2Tuv7SMxK7@e129823.arm.com>
References: <20250804121724.3681531-1-yeoreum.yun@arm.com>
 <20250804121724.3681531-11-yeoreum.yun@arm.com>
 <86pldb6xkl.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86pldb6xkl.wl-maz@kernel.org>
X-ClientProxiedBy: LO4P123CA0557.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::13) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DBBPR08MB6220:EE_|DB1PEPF00039233:EE_|AS8PR08MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdc12ba-669e-4a47-c591-08ddd36818e3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?pHVTFO2kUubWU5YYEfdgJiN71OXOiQ+V4Dq/sKv9d2G0uexboBebdjteBIgQ?=
 =?us-ascii?Q?G0PGiwGtkvqRfRZkvK6+lqdxQ/ih6Om6BTWDD1+YtD1HSfLGVeaFpRHjkGh1?=
 =?us-ascii?Q?gQm25ojDax368nyYWCY8dp/DfHWbGKVGuR2xxMg0iIiOZJJmVyOYaVZVAgzG?=
 =?us-ascii?Q?gkBmNe+EXAtQEZaXa6Tt0wxX5DgaWMUZuPNTfnNA6M2bdJtPwUtFEaW+FueH?=
 =?us-ascii?Q?YHWuBXNxMPRB21B9zu1ZBZu4/SeYMdp0DZyobdSE8gMjcZ/WCRBnyJi9L3pe?=
 =?us-ascii?Q?SQNXCm1y7KhiNuuyrc6KZfgt+q4OLAMh6NYs0cwCq2YauUjPyAoEita+jveN?=
 =?us-ascii?Q?o412PrFvcMF0PnbYm030T6C43dKNbmi1DUtQeQfdaIyMzAl1+xLglMYxaiV5?=
 =?us-ascii?Q?QizzmGdZG4NM7/9/BQwMFGl5qdJqZSQF4+MctdjeH9Jc8L+P3wEHi3tPAyuy?=
 =?us-ascii?Q?iif526/WN8UmJPDBXpdMVtjzCMXPHn5NwuxsMbBqLoHN3A2FcLe+36/r7xP2?=
 =?us-ascii?Q?woLHt48/vGBjHOQ/qZyTKHQFlbs0TSsO5ggvIf2GIrj7+XtZN0eRu0LvemxT?=
 =?us-ascii?Q?Pw+4A3wdgJDARChGXfI9Y3mYe87J1PCYmHvCjmF7SSshJDPi15Kn0yGXsz6t?=
 =?us-ascii?Q?H9EtKZmdVL9wUD7KD3cI6RTA8ffMP5BblOGrKf1O4bZtO0YItgAz8/Y1zj1/?=
 =?us-ascii?Q?fyj8XJVgzZkOtCJWHTUvBfUD+LZ3BzPyIEwzHyATfR2idXCpGbSOZYwgYNO1?=
 =?us-ascii?Q?5KnqaMzKwHgFPhUdt/9J6tTswnJ9GC71EyhnuWn9a9OOTzeO3+rM0s4uHuGJ?=
 =?us-ascii?Q?AdC4OSDq2RFjH2GRrU0uwMSnMNJc9lliBMmmHovR92CvuoLCUqD1f9mEwYpY?=
 =?us-ascii?Q?GqQ7AlYfcBhT2Rkq85oITVNv0uIvr1pg3aqzOoK2XbUnqsqgXv7P3OmG4xPg?=
 =?us-ascii?Q?1J0sJC8nkOD5CQnkd+CoB4hU9s8eprZNxI0jswT87QpzV3bnVmNHUe5i2Ptw?=
 =?us-ascii?Q?Ttf8aW/RIcpVbHu+DDmBlsELTAD/wJYFBtd7jJla8tZG+uwLSyAnsQBPZdfn?=
 =?us-ascii?Q?4pbMBl/Y7u9087QgyFU3mBo045ItlaXzLy7deJTYeIkbrKjH1/2ZgtA5H0hT?=
 =?us-ascii?Q?U8/IOCQZ9EfLT4MZc2+DryG122KIGH0+gknM7aiPoUtMkA1V/SRXMw2qDe+C?=
 =?us-ascii?Q?UBFSB07YSdTRWrna+eHm38w9yRT5jnunvHSpHy6eLOfL0Me+FdBFMVvgZBVg?=
 =?us-ascii?Q?gXqe6xUmo0TRY3SYUlv4VTy9nkhKxOaMEKvbBCULy/ddvusgijtfeXWbffxn?=
 =?us-ascii?Q?f30CdAZuS1Cj+mNA6IWh2q074CN+ejl2udFkKLs+m88IQFp0aQ4dnp3oxroT?=
 =?us-ascii?Q?/RNztxXgyQAbFaZYA4fklDd3Ek+zEaxX/jlB0c2dHHfec7tprQQfOL4PdI3l?=
 =?us-ascii?Q?dHE0JKgNn+s=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6220
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	091177b6-e9f2-47c0-3096-08ddd36804ef
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|35042699022|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQolujlGxB8O7t6nx4Ntv9NOUdiMa3PJBKqe/J5f23sHw1RPUuSKtj2vwMrK?=
 =?us-ascii?Q?OC181l2HtoTnC9EJScTM6gV19Q79bhh2XJkUcAWxalpYOFQ1i1sA4T+KmnPN?=
 =?us-ascii?Q?mm1qwvsQFC9VI3q8brDuG7eW5ssJ3nNz6+GBunaOJX0ePpYu6LnRo1Aj3htu?=
 =?us-ascii?Q?Nr3kkLQMYUNTFFPVc4EpeufBmow9YmY7hK/CcW3R0SkTmqdMiL2YYz1rzTqI?=
 =?us-ascii?Q?kU109GIl5gCi7ZHhJjHV0ybXAgO74Orcgm7+3iUCyzthyNy4nPZldEcQw+FA?=
 =?us-ascii?Q?8riCwKBRce6tjwgCe2OvKUykwtXhhD1rEhJ9Z1rhqezqWZe7U1N6pLX36V7f?=
 =?us-ascii?Q?jvGpeKmggVEt2i5RnN0PxV6w4gb0tyY6JPBEPtCsWEEUI6udyH3/6jIXaJy6?=
 =?us-ascii?Q?Oz+OeDRP3cS+cDUNA9CaFrRM5lMCxJjhbaoDHP9dq+s+Im0ZcX8KtyLslaA3?=
 =?us-ascii?Q?8584M5PgiUkTKfgM92SH8mYGUJFP3EUHnBcXeWVP4S4O5pZt/F8oLkqYkdHY?=
 =?us-ascii?Q?2Or1p9rSXW0znjtBiDxkXSF6Wp50ntdIZbnOpoFpI8+g4pfanXKCiQhnP4He?=
 =?us-ascii?Q?Yjv6TXcOqz0jo2Z3za79l/WufAM8FQoUkiVWm6skldb/U6aGJzjhucPZa6C9?=
 =?us-ascii?Q?f/kAOy2pZS2s1FABM8v1FTuN+b4tlF1+9tElEaxIBl85NNvqH1V7CLY5r8qS?=
 =?us-ascii?Q?xsx9MGxbcnylw2av7MgF8Iwmn8jVePyKrbtDZp4V7dPAuVPHHBptgWI0UetP?=
 =?us-ascii?Q?FLzFzRkQa3m8b1i/TXa20HsgnlZyxRIFUrzZC/ex17pFpQp+HDh9aiw4yfBU?=
 =?us-ascii?Q?NkR/c/VL86AuLno8HLikcDbmEObhR4vhCNoo2ig1F74aONP0UGzS+HzefyfD?=
 =?us-ascii?Q?RbjGU+pvh7U8zL0vdUyK68gfmrRa+04uK2v9uSrFRga433M3WJKswGclS7Ns?=
 =?us-ascii?Q?guLAe/biyCoU7Yc4ZQOyWLhhojfvf1MJHRzPr4ilev6YVBuJVU0sar8PhjId?=
 =?us-ascii?Q?dqs44j+2B2ty0DzoFKiC8mY8bVK+3QHNzevv6J96fCa3m6GVYCOyhkcmuvfQ?=
 =?us-ascii?Q?MCNK5mLThTMD79q+Z7Oed47Gmdh1ct9D9tb9oj+ZykrXWWh4cRS/FtkrflOr?=
 =?us-ascii?Q?yKueHa7uFkB/LS9fyxcUTbI2ftEXkMB0lXGW8njt/o4RQoTPyS9ALJhcG4MV?=
 =?us-ascii?Q?uvMvEPz6qxLcDfkljqrx39AT0C/l1dBrGddbNUepUHr+VemjbWOumTMi9NQl?=
 =?us-ascii?Q?WILubona1MJCOfSHUAPro9o0xMsecRKeBwU+iX5uqibt5P/KiVXnaMhI+WjH?=
 =?us-ascii?Q?qBujLl5dEY6REeFiWAdpGKz+IxCu9CRm7jzVmUeEgVGwBtnmaiZEXxIHaXER?=
 =?us-ascii?Q?aEB2MDHXLvWx/D9GP5f/K/hYSi2pEF82or3hwvvmX6f9lEgdv2n4n91JikG+?=
 =?us-ascii?Q?ZKaacQ+K/68IUNxgSAezfBoqfLUoKpcUNY0pbvBEgTTSMeUkLo5xuuOwOYnE?=
 =?us-ascii?Q?2uf4xv2K46Maj8Mnv2esZl518G4SC5Qk7PTf?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(35042699022)(82310400026)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:03:40.3105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdc12ba-669e-4a47-c591-08ddd36818e3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9314

Hi Marc,

> [...]
>
> > diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> > index dc1d26559bfa..a4d3b2d2fd80 100644
> > --- a/arch/arm64/kvm/nested.c
> > +++ b/arch/arm64/kvm/nested.c
> > @@ -1704,6 +1704,19 @@ int kvm_init_nv_sysregs(struct kvm_vcpu *vcpu)
> >  			 TCR2_EL2_AMEC1 | TCR2_EL2_DisCH0 | TCR2_EL2_DisCH1);
> >  	set_sysreg_masks(kvm, TCR2_EL2, res0, res1);
> >
> > +	/*
> > +	 * SCTLR2_EL2 - until explicit support for each feature, set all as RES0.
> > +	 */
> > +	res0 = SCTLR2_EL2_RES0 | SCTLR2_EL2_EMEC;
> > +	res0 |= SCTLR2_EL2_EASE;
> > +	res0 |= SCTLR2_EL2_NMEA;
> > +	res0 |= (SCTLR2_EL2_EnADERR | SCTLR2_EL2_EnANERR);
> > +	res0 |= SCTLR2_EL2_EnIDCP128;
> > +	res0 |= (SCTLR2_EL2_CPTA | SCTLR2_EL2_CPTA0 |
> > +		 SCTLR2_EL2_CPTM | SCTLR2_EL2_CPTM0);
> > +	res1 = SCTLR2_EL2_RES1;
> > +	set_sysreg_masks(kvm, SCTLR2_EL2, res0, res1);
>
> This patch is obsolete, but I'd like to point out that this is not the
> way we describe these things. Each bit of the register needs to be
> tracked against the feature it is part of, and not blindly added to
> the RES0 set. See
>
> https://lore.kernel.org/all/20250708172532.1699409-15-oliver.upton@linux.dev/
>
> for the equivalent change.
>
> You should *NEVER* describe a functional bit as RESx without
> considering whether the feature is exposed to the guest, irrespective
> of what the kernel supports.

Thanks to let me know.
I'll keep in mind :)

--
Sincerely,
Yeoreum Yun

