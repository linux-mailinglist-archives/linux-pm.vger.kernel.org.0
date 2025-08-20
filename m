Return-Path: <linux-pm+bounces-32731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0C7B2E40F
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 19:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD051752EC
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 17:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B6223E358;
	Wed, 20 Aug 2025 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O+aMI9En";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O+aMI9En"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013010.outbound.protection.outlook.com [52.101.83.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E820299E;
	Wed, 20 Aug 2025 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.10
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711322; cv=fail; b=qR1RXJDmH4VfrncwQrbGx/vpSWWNWyH1g4oTokrucr82CMdXgWzq9fEQDTICwUc1j4j9lasoUehKc8ao+yyARrkUeUc93KEvroK3V3wnyqnAv2rTGX2/IPpN76kUXwRx4feaGsRyB7lVWkleguM+1crf4RFnlqS4djreXc35b3k=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711322; c=relaxed/simple;
	bh=C5R97hFV4jyDKc1uyJQnQlYIqDZ9sZuLBGOcEh2qtuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sJSXzNUVwuW9y3nm6fyyFNyCKzIxQWtOyWHZBeDeL9nlNFtN9VeaJ3UWk+6uXPtO15Klo5bTrbV1YzwE3pYaeHQS1btsPgvnNUAp/QBYLhnOxRbvOgpFvHT8DmOuy5MrmqF8EcCgw9VDJ3ulah36kw5o8l6Nvw6Wp9gg+tFbeKc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O+aMI9En; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O+aMI9En; arc=fail smtp.client-ip=52.101.83.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=u+DyQVQGrCpbE69Tqy5YLdCpUODvhP2Bp2Z3F6D2A4oC8LXMoX1QGD2dMErtGCoMt3rQM2eW5DjXosv2p99mVApGBldpoUwpt4dpvhPWZMR/RjOZz/Vw4C5ARFHbHtT0OrrP6zWO8URydBmU1lEU0CGgH9p0urVaMxKa+Zgb9Uq34iis6Du0nA4XEU378mOHFztL7D6WP/Jrg8zmCAKuKwe0OXxHRdFXznzYYRE0c87G8e1dsFquN6S73+zpoLR8Y763422CLt8u6cVqFbM0K6kldEIuNQy30lDxEqACEayRqtdudzToWmfQz4BTu24ehs2ZGi2jMPCzacn/c1M1Eg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUyD0s1eQ951P74v33ovVPkbxeX46yrj/XpjODv0aUY=;
 b=qxd4fef1R9Ph56BtdGRLFtuDT58LuAt/wcj4Xp5ykXTJ3Ly9hVtk9wxkxND8hZUz6bX5oRCIJie2OZ9PxwD68PaOmPbJN28I0WavP4xAydRY7gcKWp49zw3PmjjNOX8t09G8gpaOQrNO47cE5+jYVEQnNT1HB1znCgmOvxB760MhjU/iuW5fcd1CV0cef/0U0VmddUwkqwjpjhKa/KH5lgB+Ozg4pVjQMfsluMsze+wdKC1ysqp+ZWaa0uSmMaPSIqfm+bWP12zzB65RZoDAznMl71SQqUcKAxECgCvDcOybKLjmB/PpaNa+Jz539IxS1e7BOtYI7EPBeUNK/NZ5Sw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUyD0s1eQ951P74v33ovVPkbxeX46yrj/XpjODv0aUY=;
 b=O+aMI9EnS+1FotvoW4M1GHbQCzyJcXm1V+/uIksxFwDA9lqkJNqoB7Kazs0auysovA1/V/PbjJN4AJN9itF1rSxF8jl347TIGe5HPlZJjK8tCJQzVPFDS+/OkqR4smdg2klXs9Yp4BVIzpXou7cGpMppbo0hyMHyT+eu0I0x55E=
Received: from AS4P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::9)
 by AS8PR08MB7862.eurprd08.prod.outlook.com (2603:10a6:20b:52a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 17:35:12 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::e7) by AS4P190CA0023.outlook.office365.com
 (2603:10a6:20b:5d0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 17:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Wed, 20 Aug 2025 17:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s73uW2c4xeOUjaEOsKgz7rulB7Z05piYxk7ml+5cI6ZksQhsgblHBl32wRe1p6Gw/xg081LFjgxledlkZ6pFR64ELGmQ9br1XNtNuylkQAPVNlzHPgSR0Y4wEqGXI42J0FdSMhAK1PHwsJfQl1IXCQJ9/696F/8A6fc+sCkairKVot6imdj55hcWoohIhEjITxdEFEHuqIrArYcANTdtboswRc9iavu/1NlHslagdFYPeyR8Bfs3YtfPy/yGM4suUwowZClBToY5aazf69sH9/weZhP/wp5rrFJOryCNXG+Nv5bBBzPbJfzNltZNL8pb26jWWMLKuf7SYRjLjiN98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUyD0s1eQ951P74v33ovVPkbxeX46yrj/XpjODv0aUY=;
 b=vNWKUqnHhSmmUNEUTOm/MuL1N8ETHlupnMgkrvANkFBl9fg1XnJ0wBQusmHz8299g0guQc+Lrb7mnDb5+u7uXhE9QEmC1GXlChpS7IXO0qsB9RKoUopVlOqmAE2bEQULya47BTaOstkct5Q/OA7heroEbsMYtIpcHLFHP/gtcMHWumiW0rQ+0r3fOdvizJQ1CS1JPRC2Had5LwlG9de+5AmxfiCTR2rHY+YGCox6ibub/2UerGOtdsa8Y/aAIaK9n22DX4Fa1KpZ3f6lBMUcZaOvCYrdtpohL19y8gnXHU3Cg9AULW4UGqrr2oqgR87h/OYhx+FDV2HkRmCKS7n9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUyD0s1eQ951P74v33ovVPkbxeX46yrj/XpjODv0aUY=;
 b=O+aMI9EnS+1FotvoW4M1GHbQCzyJcXm1V+/uIksxFwDA9lqkJNqoB7Kazs0auysovA1/V/PbjJN4AJN9itF1rSxF8jl347TIGe5HPlZJjK8tCJQzVPFDS+/OkqR4smdg2klXs9Yp4BVIzpXou7cGpMppbo0hyMHyT+eu0I0x55E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS4PR08MB7407.eurprd08.prod.outlook.com
 (2603:10a6:20b:4e2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Wed, 20 Aug
 2025 17:34:38 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 17:34:38 +0000
Date: Wed, 20 Aug 2025 18:34:35 +0100
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
	linux-pm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 5/5] arm64: make the per-task SCTLR2_EL1
Message-ID: <aKYHK1tYEji3jKWJ@e129823.arm.com>
References: <20250813120118.3953541-1-yeoreum.yun@arm.com>
 <20250813120118.3953541-6-yeoreum.yun@arm.com>
 <aKXlqsnLyTL6lsh5@e133380.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKXlqsnLyTL6lsh5@e133380.arm.com>
X-ClientProxiedBy: LO4P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::19) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS4PR08MB7407:EE_|AMS0EPF000001A5:EE_|AS8PR08MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 46261121-7934-4e4f-77fb-08dde00fe9ed
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?lH/jp6Tn3vrwWfONB7HxnY4AG8Zlr6XWBeTdUDfPvnsdXZhxlbdoc2ZFijsl?=
 =?us-ascii?Q?FWDcChzFhkBFaAGog5iIc/js6EcD3JShgqZW3rkioTEAjTFtvZR/7VfAaDhD?=
 =?us-ascii?Q?5Rijr4Dz3b2q2NYKhDJt2AxgKbxz3UevEdj91FwPSXWF4mvT/Cew/huHbRj1?=
 =?us-ascii?Q?ILXXI7zUYL8BEbAisJP3tBcOCdUESoMCarZXaYf1I2YcwDxVIMcqYJxpVaPj?=
 =?us-ascii?Q?tSkOsufQ1jADelO8DiNtWf7djqq5RWHsAPc45oOduGVUIJ39KRPMzSnNkO3+?=
 =?us-ascii?Q?SyAzQZVNyY2XtiXaBtCu9PPtC9t76N2HSXsdD+fnmO964HUOKDVk7GATJGR1?=
 =?us-ascii?Q?rONsQWM5vgdNT7+ag+Vd2rj2hIiFksVCyHkP7GiVVI7Dxg54d4nLsLfbZGer?=
 =?us-ascii?Q?212u8vBpBLme7LdXHo6vnbTB3N1jBpt1dZEe7eOFl/NPsZbmtEiCFH6hqcw+?=
 =?us-ascii?Q?lXWDh2TlFAP8jS7/3V+wAucORVGc0yODS7T5R7bwKa+TRLJZqvv2tGgen7hc?=
 =?us-ascii?Q?4x1MmCFz6fSqU5LbIi4zUGeAL1901YB4Yv/pLB+oYoYYraW7BP3Y8S9Zgmw7?=
 =?us-ascii?Q?i/mZ/KzVVtV1fDdeLpGIpwRShqu3zLhunRci1/Kf4KFdPCu2dNao2rliF7ql?=
 =?us-ascii?Q?VgaKCp511W2aTtaawpGmDOaYuD8RhRtuGlErTCiHvX9+rOKej8VCDCWbriH7?=
 =?us-ascii?Q?1WIk9ZiIIttcK8Rs8RznkWAaQQBMtJ1/wr5ejbYdd+Adg69rN5GYAvEkvQ9F?=
 =?us-ascii?Q?mcF4knpubFg9L34FrEYvH7dWuRo//g85cWNbxrHNpwi7fQq5vc+whwxOF86p?=
 =?us-ascii?Q?/sv64Hzclgt3AnWb7PHHQ/xDTVX1KH4nNIfb04OFZoiXBktb5GqhncZWBnDY?=
 =?us-ascii?Q?DnexHs5cW4md7ZOx8yqHMRSxjojutNudGDc5eIUPD5EGR29xFs0jlQoJF8rb?=
 =?us-ascii?Q?jhfs/GR+P0wUdUIxoH0qD7rKdkqppvpECKgBGDkNT/DmHP8/L6HF9YQqQ+LA?=
 =?us-ascii?Q?1sw6LmfFuEldRPC5wJk00fIOSb+XVmV9w9dGRrIG1GABCaBGIyy5EPBGPxlk?=
 =?us-ascii?Q?qZgCLDqn57b69yULI9ZdOn1HbtZuWJhjyW4cigjfOnxeds4v/jc9a3xVkEWn?=
 =?us-ascii?Q?wb3KnKIVi4Dv6sZu0oaWTNPfD/407XKlaFz+BoJOonmahNFEF/twvxc06tPM?=
 =?us-ascii?Q?e3SQcPVmcEAOwX8TUoL7848ld1nT73BgqxGO6I/SWcBqvOtpklyU2t30HeUf?=
 =?us-ascii?Q?mKJpaUHH8Uq16EaGrZEiLkKet/Kzi6KaJy5aIqSMK4twGSoa3rKoQB1iqIX0?=
 =?us-ascii?Q?udXs7mDPWMf+ou3xwifunaVrM/l0AjWvK9vOdSFYvz9bCr+f2MoTRSY+zrFD?=
 =?us-ascii?Q?vJpzAW0QZOyjuaSHln/m8HEOUN2d6432iUgGZIjEtOQsZfmbLPTRE1QkUfiP?=
 =?us-ascii?Q?WB6hLJ2trIw=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7407
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	46de1c19-a5dc-43e7-5d20-08dde00fd663
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|35042699022|82310400026|1800799024|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IVR+TAa3wg8QYuA26mtlW4JVM5OxBAwKZ/6HsjGRhcHRwm8f9IN/lvuRovAJ?=
 =?us-ascii?Q?sPvl/cIkwYY1zwYNlVOjwnLAMNpzixcnE7kHOhy2G6iXgAu9P6kgnR8f/xtE?=
 =?us-ascii?Q?jvK9PpCkftG1wesRp71Yg7co3ZjTmggasEGE3PP2QmRekOonA98VqUVWxYaa?=
 =?us-ascii?Q?XyeHRgJ2qAmHnXYbBUU0v4lAnu1gQlLRsG/zdugVVj+mfocGCcsjoPNRnXFG?=
 =?us-ascii?Q?Q44T+S8uRUWquTSLnfqIjilRV2A7/RTYEJTgy1X+BtHwD3At+30+afP400GK?=
 =?us-ascii?Q?Pf/6gz6azQidy/ewv6YG1UOQh/EeZJ7234SCDax6APYrQA7o26DPzO/U56tX?=
 =?us-ascii?Q?Qw0hg++jLo4oIkGZEWu6uOembEBOwMm5eCHGPcvcptWRFH0+ZZxOqYu5fHnr?=
 =?us-ascii?Q?FU1M2Sb51vQQGc4Kxp5xr/EotTA+vynRJdz07YjTAqh/FxQYBcdyjmbeyNFo?=
 =?us-ascii?Q?7wmfhWv/bzbMsxsY8F2YFUCyitfDp4nWav3TET3tcZ0n/Le9VHN/bgYw1ylt?=
 =?us-ascii?Q?AHPYtq8BHnOVmpLt2tri4eOMT5Lpy1+1kpiETyas7OI8HEX2UT1WtHMmnfuH?=
 =?us-ascii?Q?UUYFGrl9OTF32NpjxdnGPgj1a66sEVyXd9LX9g3TesqHegugWYv0Jvs7Riok?=
 =?us-ascii?Q?JcK75xdVnOeAHkYmX/n6WCwG9E6Q5RfrD1ktIB6eNUAmQrn5SSgZNFtHeeXW?=
 =?us-ascii?Q?AjcognNSKoVkYuqRPoR6b8Ycu07JQJrs/3drkrd+QkcVo2WaIpzsYvs1U8pE?=
 =?us-ascii?Q?m0o7PeqMPuKPenDUlD0OdLtwPELRfsoBAvB5WPundYLBjOYaSFNEWypJsjuF?=
 =?us-ascii?Q?BReanAGvN+eQRsU+2WYlCUd3KvFZccjSbTUIeuRHosRQErDv346NBpQi9kp5?=
 =?us-ascii?Q?MvWRf5jh9WYJaD47nzcDVBB7twWmTFvjH58ry1VfllrxuiwFmQeHjhzZ1fO3?=
 =?us-ascii?Q?AOqwfXrIc3MTSyXSdAft5dXBxMiKp+QWRMdjhdVJ3ufn72HMub+MQdClpnne?=
 =?us-ascii?Q?8xqxyvjYgMkFer1IuC9215OBj9WCIVowjGx1gD4/bWbWVdaFhAIn+QL5WU8d?=
 =?us-ascii?Q?Ef0ZpZAcQqjTO8KwmEL6lzBypi/SnM8f1B7RKwrVlDstt7aAGBypSJ38tNob?=
 =?us-ascii?Q?PX8YBs6YzMYn5DUu9Oj6Y+TmT/cylqcacZCCr38cI3N9n+CyXs3MfoPzVt8g?=
 =?us-ascii?Q?noI289H5s4tyPOG1K7DoOiFFlj7EWT+/oBbgcMOQkFB4MTUigirAKfIMf2ON?=
 =?us-ascii?Q?stRVEeiSyF6i30QhmKlm6/iOkhwF6mEUpDsMN6VPQKV6pAdW8C8rpNJu2L1u?=
 =?us-ascii?Q?VBNX6XaEOnSSpDTxHAnlTeZWYaAPQKlIY56QyZqOmbvn6Ac3+AYdBHAvh4qm?=
 =?us-ascii?Q?08XOhLosIu9mCGKOlmsW7siIdc0ag/thKurCMDWMT3ILRD4VauEYx52knLP3?=
 =?us-ascii?Q?0g80u0w5KcgAKCnmgWxFVyYSbkcvYWV+ctLw6Yc7TYNHWP0lLcvCVBcCYTC4?=
 =?us-ascii?Q?GLgtX4kl42wAX/hgMtq+y5lhvIG54sNvH1Il?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(35042699022)(82310400026)(1800799024)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:35:10.9363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46261121-7934-4e4f-77fb-08dde00fe9ed
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7862

Hi Dave,

> On Wed, Aug 13, 2025 at 01:01:18PM +0100, Yeoreum Yun wrote:
> > SCTLR2_EL1 register is optional starting from ARMv8.8/ARMv9.3,
> > and becomes mandatory from ARMv8.9/ARMv9.4
> > and serveral architectural feature are controled by bits in
> > these registers and some of bits could be configurable per task
> > not globally -- i.e) FEAT_CPA2 related field and etc.
> >
> > For future usage of these fields, make the per-task SCTLR2_EL1.
>
> It is worth pointing out the impact of this: for platforms without
> FEAT_SCTLR2 support, there is no functional change and minimal
> performance overhead.

Thanks for your suggestion :)

>
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/include/asm/processor.h | 5 +++++
> >  arch/arm64/kernel/process.c        | 9 +++++++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> > index 61d62bfd5a7b..2c962816de70 100644
> > --- a/arch/arm64/include/asm/processor.h
> > +++ b/arch/arm64/include/asm/processor.h
> > @@ -184,6 +184,7 @@ struct thread_struct {
> >  	u64			mte_ctrl;
> >  #endif
> >  	u64			sctlr_user;
> > +	u64			sctlr2_user;
> >  	u64			svcr;
> >  	u64			tpidr2_el0;
> >  	u64			por_el0;
> > @@ -258,6 +259,9 @@ static inline void task_set_sve_vl_onexec(struct task_struct *task,
> >  	(SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | SCTLR_ELx_ENDA | SCTLR_ELx_ENDB |   \
> >  	 SCTLR_EL1_TCF0_MASK)
> >
> > +#define SCTLR2_USER_MASK	\
> > +	(SCTLR2_EL1_EnPACM0 | SCTLR2_EL1_CPTA0 | SCTLR2_EL1_CPTM0)
> > +
>
> The kernel doesn't know about any of these features, yet.
>
> It's probably better to make this 0 for this patch series, and add bits
> to this mask only when they are needed / used.

I see. Thanks!

>
> >  static inline void arch_thread_struct_whitelist(unsigned long *offset,
> >  						unsigned long *size)
> >  {
> > @@ -370,6 +374,7 @@ struct task_struct;
> >  unsigned long __get_wchan(struct task_struct *p);
> >
> >  void update_sctlr_el1(u64 sctlr);
> > +void update_sctlr2_el1(u64 sctlr2);
>
> Is this function used outside process.c yet?  If not, you can drop this
> declaration and [... below ...]
> >
> >  /* Thread switching */
> >  extern struct task_struct *cpu_switch_to(struct task_struct *prev,
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 96482a1412c6..9191180c4875 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -698,6 +698,11 @@ void update_sctlr_el1(u64 sctlr)
> >  	isb();
> >  }
> >
> > +void update_sctlr2_el1(u64 sctlr2)
>
> [...] make the function static here.

You're right. there's no usage anyware except here.
I'll change this.

Thanks!

>
>
> > +{
> > +	sysreg_clear_set_s(SYS_SCTLR2_EL1, SCTLR2_USER_MASK, sctlr2);
> > +}
> > +
> >  /*
> >   * Thread switching.
> >   */
> > @@ -737,6 +742,10 @@ struct task_struct *__switch_to(struct task_struct *prev,
> >  	if (prev->thread.sctlr_user != next->thread.sctlr_user)
> >  		update_sctlr_el1(next->thread.sctlr_user);
> >
> > +	if (alternative_has_cap_unlikely(ARM64_HAS_SCTLR2) &&
> > +	    prev->thread.sctlr2_user != next->thread.sctlr2_user)
> > +		update_sctlr2_el1(next->thread.sctlr2_user);
> > +
> >  	/* the actual thread switch */
> >  	last = cpu_switch_to(prev, next);
>
> [...]
>
> Otherwise, I guess this looks OK.
>
> Cheers
> ---Dave

--
Sincerely,
Yeoreum Yun

