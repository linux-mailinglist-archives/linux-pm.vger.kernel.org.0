Return-Path: <linux-pm+bounces-18801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A97B9E8FF1
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE39D161717
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BC0216E37;
	Mon,  9 Dec 2024 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fT34fcG4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B75216E34;
	Mon,  9 Dec 2024 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739388; cv=fail; b=EAHHARP5am+M2PKld8Sp6qExtLE/aCAx1hEAVsD8rzyaO9vQ0vJ3muC8ktI6ime01E9RKbKgRRicusDBaYjP5mfbWKQL9ltGORTBybua1fVi7pxcFCsrYKJueJz70DDq5Q82H5n1w4+giadC3oLznsE2h3Jw3wrPvADm3DmdzQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739388; c=relaxed/simple;
	bh=79YKH1Xl3CgKVm4AxLVGEl7QuUXD7o+o1bJIoPfaE6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fytn5WqhQ0PCSLU1ai2CpuRLRbVH7mp5ONYkxHuAj/bHHYXBLHqViWZ2ZZJGOiV5mm6gPyte8rPkOD2ppEnbnQESLTANeZ2bV/TIjTTdKxIUsIzAfOhu5vRMg0rNR5R+yx0LqYX/HwBJGp9TxAHrjL0kCbyQ2OOwioM3E2Tmd5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fT34fcG4; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtZzpl5WxDtQ6dRGEHorAnfxoDykWBwOeKrMZVpRkVNYAdMX9SN5BV2mqOWl2rfPIoJa23wuUzH7cH8mbVviATC6vFvOi958lkNGyNV4Ja9xyInsO39SBUt9nSoPNvRPToMuNtLKoVKagT9tHxm1NmABiRIJFPtUYZsz9Fb4y37NocPlJ6uj+Sf1dhdirdjlfsiVzBWwBwgZh/tO8gQAwemFgXFuYDdRSWboFsd6f9EeMozzEadOnj42WCvnkhWvMqGN697MVB5mUnvxlolP3t4SLe9ldHErOiSc+NM98h7GoPLxug6ZX0EYsqA3BUhMFtPupuBj8sAYePpBbIH28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FKIiAqoVXFSVnsCC0PQ4WkG+zw6zE8/lrIeGSYupqc=;
 b=r6ffiak+C3T7T58mJcWWLmht7Ivo19KqyGHabjkD6NbbqccXrAIidTaCg0vNSZprarl3NkP3atwePBUKkFEaBu3pcqRhLCPMrxKxgJBRs7j0ZqNN6CYHymvqOobS0jrzLGWdY/wOqHxcBI6UuNdtpm8q2K+5G+t1F1ACAqWzG56naytbi1T1e/kkEVlU2tLFsfWPgSeJbtqQVhHuONumfpDx4sdWW3wd2jqDKgu04gBfJW5NT2h703aumtjjkNQPsgyVJw2wn+1XOvk/SsPwj/Rc9bXv/WI2lnk3/InvYK4bU+wY50rPa3FbeOfkK8o+BsetgDdwTtYzVdacsahwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FKIiAqoVXFSVnsCC0PQ4WkG+zw6zE8/lrIeGSYupqc=;
 b=fT34fcG48al3J37Y5JD13TMoE8xLffAMYWNeMiXg0aBy1UaNMrrdQX7XDEhyVY3eWGT194FCbAGj2Zx9H2oSvJigoGlAmBK0zX1FCoqyUNTRGT1Z9NegInFGuDuoQVc5X5PnnpJ/QpFZg3tGfnLl/AUSZbUzEf0w7hJsr520lwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 10:16:22 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Mon, 9 Dec 2024
 10:16:22 +0000
Date: Mon, 9 Dec 2024 15:46:12 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, peterz@infradead.org,
	dave.hansen@linux.intel.com, tglx@linutronix.de,
	len.brown@intel.com, artem.bityutskiy@linux.intel.com
Subject: Re: [PATCH v6 0/4] SRF: Fix offline CPU preventing pc6 entry
Message-ID: <Z1bDbLZkfrxlie3M@BLRRASHENOY1.amd.com>
References: <20241127161518.432616-1-patryk.wlazlyn@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127161518.432616-1-patryk.wlazlyn@linux.intel.com>
X-ClientProxiedBy: PN2PR01CA0234.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::6) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: dde83e18-ffa0-4910-f9f1-08dd183a87a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5u58qFv9933PxovrqfAxVHm6NWEw0ASnrW7qF+3U4/tuhW23BvbAvPnPWFz8?=
 =?us-ascii?Q?shKB8d62ef1JQyPkBZjCB6ZdL8Yhv8xaIBbPIjHN4Ucc6FXba52Hz048ZzJo?=
 =?us-ascii?Q?NTUckJF7z6mRSdenrULrFuirnmIPePZr2KsvsBSMNaYmlsGEmmKA5ocwSt16?=
 =?us-ascii?Q?Dd3zSCRl/CF1gnjukDr5T/ACb7WWAObFoM/MgOYkEAfOpNnj80SqhlWhU+Jl?=
 =?us-ascii?Q?hXuJihKsbXavvqooVVylbCBXQx3cqLfGJyrbLCbWWHFE4HRYpRHXil4iC6Dm?=
 =?us-ascii?Q?si51SkvH6pGgAo+YHBR0Zr1mauCh0fX3QMG4vnRf7QLuFfL1pun6WmO9YhRU?=
 =?us-ascii?Q?eyK1z4vDsmbWRdOsTn8/z+C0xAhgaSOEJOODomdPRlFfIiZKNwqR/0rtPd44?=
 =?us-ascii?Q?F5BfmH1tFInP2cu4XBweswOW3fDnX99fd30T/aEhbfS8FGBjXr3uS/UmiIiJ?=
 =?us-ascii?Q?RV14NPbmR2cDbeE8aT/qWWqtRy+0xTBUghGC1ptaMiFGrzQDyyaFuEo6Hgao?=
 =?us-ascii?Q?OQ/vHdNGGqBvg4ImLPBUgPzxPipPSfiUR70cZwnz6bIBKO1az0q5KBIf5U/t?=
 =?us-ascii?Q?ThjP5o5fYydpL1982fS4f+o3dYAAbvVPG6JAH+efkBQk7meeZPE0JIgB+QIJ?=
 =?us-ascii?Q?iXrO2gUWMkucGXjOoe5TOsIVzAHw65ydr8qoZ8cHgamxM6XXDHn/3/X0mOLP?=
 =?us-ascii?Q?kRRmJ1x5mh2m8dMGRD/TEOTJyJ1UKs+yTM4xl/8EjPtPpVb2WRQK0hLdqXgt?=
 =?us-ascii?Q?ojvoAVbhOE17kKUPq901foiar8UXPcWtkSXybJafxLfOe8458ebhn4BVERuq?=
 =?us-ascii?Q?CyXuS9kQfj7hh4JedD4ggJVnyKBv4gi3P4kirMUjd2Spp4us0KNbJP43eOgL?=
 =?us-ascii?Q?2/rSQrFddA0CAb2qg1g142nCuh2ptb+t0wI3EnkNdjLWng8kwoqipbhs+p2m?=
 =?us-ascii?Q?kdJivJa5Ec2pJYadfUDevDajQy2INU/DhB5yj1qRM+oq6YEbfjkHeCIcRm7T?=
 =?us-ascii?Q?2+5o+SBgL2qIWOUjeP/O7uNlbjhm2KRLUZEI+NeTdnNtOxBxTk0vgXas36zi?=
 =?us-ascii?Q?lhT6foL1g2FPc6xu1DhYGtsRqGSSEUPXVTdDHEUVE4AV1pMQqs3KQRoV14i4?=
 =?us-ascii?Q?S5kZ4crJJvIlXLFC3ppeScTMy7mZG77kYEgpeAYk2xWy22FHsIF8RdFgaBqJ?=
 =?us-ascii?Q?C0+28z1M2eHpoYi3vrBpqydD4q8WnrspCNjEFPhA6VLLHy+T3xMfUARD+fkm?=
 =?us-ascii?Q?2YcHYDuanjQVJTgCDIldY5jxIkqilf0b8BDXwxLQuksbkcgsShMR9uhB6QQo?=
 =?us-ascii?Q?YYy2Yb/HwnHhNMC0L9dMBsHSLHtEompmCtRtFSxxCjW9sA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P3uaR/Q7voDBwycwT/MnGWhk5C61Jn7g3q4/8RH8canXwmTbFZxrPjfTFI7x?=
 =?us-ascii?Q?GyRYjST/g4IbllkZTteGB0N8jc+x2NwCpHf3yl6OAuVaa6yvD1ttZiCIPJ3c?=
 =?us-ascii?Q?1/4xqZ7X6dyuOHXpJk2JfXcRu/4dtaTvAsjSaxux1okr6t9bZdGP2OSC4m3u?=
 =?us-ascii?Q?H5CO6Wvvpj2MbjBsDO+obpKOScmg0Pe9NLR6dNhnw+Te4F2Km7lMJJxjrcXB?=
 =?us-ascii?Q?QwKk/1lzz23jMlcPBtUmchIlLwyvjYdQYzpVK4KRiVgMQKnOr+IIapJCQ4BO?=
 =?us-ascii?Q?rl/uIjwSkuTUZPG5Ilbuapl87DemC1STxMY2qs7V3KJ/Ku6E9aVRFVlOx+H+?=
 =?us-ascii?Q?U3d2f0e4YcKl/xLIg6xuJnGLok/nOjGKXKg4broOaYEbgNgsnNspxn+XTYGl?=
 =?us-ascii?Q?cpf7sLbzV8CqbxXC2NqA9Lax0LJAl78UGTdBlGe4n4gTc+zgfdf92IpyaBN+?=
 =?us-ascii?Q?XHjfo/n5Nt+dPGSPp+cutkvYdSp8Im7LhAtxoZtRpj91BnwGwMfcSsI5QyYT?=
 =?us-ascii?Q?wmfeiVbEDG0FznqtxjhSMKiZPX0U+a8olIXwAVAgPdZbu3eOVuww5yAX7KXc?=
 =?us-ascii?Q?a0eubYggiqc76JrdiBFDoJsFu3vHSi0DpV9rgMLYlbeWgTK4BgpqtrjIhDDg?=
 =?us-ascii?Q?2S5FoAMzdYWr0o99lzJSVlkMLB0Ko7UpyOGA7VnwqtnGHgC3VW9GUFaRhFlb?=
 =?us-ascii?Q?whcIm5pWSRnGJCtouWHhpA1h6bWgbOOSmg+iW92uJdgGvYIDNpIBhnzOBeyH?=
 =?us-ascii?Q?6u0OW2i64TaOrG4Ln0I6FP5RDtbqgqreBPD85ytxUpBCD6PxLHdArLfpHSkN?=
 =?us-ascii?Q?OpOcKq30nWpcjpCFdMaZ2Xw4x9uqqGbdILAjX1LVLL7cwM53ora/GoxJc7ZM?=
 =?us-ascii?Q?xCDY4R8dw9oORY0jl07ilHmeXqelvVPPryCz7Mk5Bwf3GXewaEEEJOJw62MS?=
 =?us-ascii?Q?80zAYToz4nSJYaSh+kW7zDM+ldJ8iTt8t+0ISm4bmWKGCdUgkufBzWbEuS5d?=
 =?us-ascii?Q?bYFIYMw+NMEilZexK44fPS4yZCoKyA3LWyx8i6CGiK2Dyr/g2SfrpXowQnPS?=
 =?us-ascii?Q?cjP/aSJj2UZpfnJfm9VLvsEao9EYQjrABFz7gg/2fTqAhtTItFo0Fmt9pHmg?=
 =?us-ascii?Q?LMAwoM2DcTDDJxS6/FqTV7mJvKfv816NnstX8FAITn/mbUK2RL667+tRkm5z?=
 =?us-ascii?Q?g4xFNNUPhTZQbMNxoDgTMH49HYrx1Gt3gGPOjT3bikMHsYI19olqkN0hmT22?=
 =?us-ascii?Q?hy2+N3SFu9NIalUcnFC1yI9fYpCcM8d7LRmYeGo9TjivvXlzFReHSwcpNM3M?=
 =?us-ascii?Q?+Z9w4dt+ZTIlKdoZnsMQjcYYBkODdyoktcMjEaWPOMUIxWcifvhm+w6Mdbgz?=
 =?us-ascii?Q?6p/Gvi5d/v7FYox9WS6snYrHBZ5CXdHiGHXXhj1mrYZIjjICmcDN8JxvylFO?=
 =?us-ascii?Q?f+yYaGwbA7d3q7xcPEr7C8UdslE4CbC38e/TSxQGlpCzncuJGyWGZHDg5idp?=
 =?us-ascii?Q?KkULpBFih+qm/Cwspwneql+MJMnM2fa3Y/waNKiXrHXaZTusbvCgjn3bG3tK?=
 =?us-ascii?Q?tNjTjb9p3a3xDsW5sENsmYAthI9H7U2ebSE71EaX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde83e18-ffa0-4910-f9f1-08dd183a87a1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:16:22.0735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/SOfMjSjQBqZ30wML78PlfTtUPsVN4zaOj7P7aMKjdT60M0JOKCwuZRkvoWQvVvAQkSS0uZI0luhYZM+swfoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179

On Wed, Nov 27, 2024 at 05:15:14PM +0100, Patryk Wlazlyn wrote:
> Changes since v5:
>  * Split 1/3 from v5 into two commits, as suggestem by Gautham.
>    1/4 splits wait_play_dead into mwait_play_dead_with_hint.
>    2/4 and 3/4 uses the new mwait_play_dead_with_hint
>    4/4 removes mwait_play_dead and calls cpuidle_play_dead right away
> 
>  * Reword 1-3/4 changelog slightly.
> 
>  * Move changelog from v5 1/3 into v6 4/4

FWIW,

I have tested the series on AMD platforms and there are no issues.

Tested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> 
> Patryk Wlazlyn (4):
>   x86/smp: Allow calling mwait_play_dead with an arbitrary hint
>   ACPI: processor_idle: Add FFH state handling
>   intel_idle: Provide the default enter_dead() handler
>   x86/smp native_play_dead: Prefer cpuidle_play_dead() over
>     mwait_play_dead()
> 
>  arch/x86/include/asm/smp.h    |  4 ++-
>  arch/x86/kernel/acpi/cstate.c |  9 +++++++
>  arch/x86/kernel/smpboot.c     | 50 ++++-------------------------------
>  drivers/acpi/processor_idle.c |  2 ++
>  drivers/idle/intel_idle.c     | 18 +++++++++++--
>  include/acpi/processor.h      |  5 ++++
>  6 files changed, 40 insertions(+), 48 deletions(-)
> 
> -- 
> 2.47.1
> 

--
Thanks and Regards
gautham.

