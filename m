Return-Path: <linux-pm+bounces-18140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D449DA1DB
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 06:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DB5167FBA
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 05:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7BD143C69;
	Wed, 27 Nov 2024 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CQQciWF4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780A13D89D;
	Wed, 27 Nov 2024 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732686903; cv=fail; b=L0u0IdDXAxVb5fMTgfBtAdQgy3vrzFnAEeZ6z1Wz5bqjrkiUPlEFgud5UuSq0PfLgRn+vHyczYGae2QP/Cn1jC8FugQ3xZguClKPiTooEUc0pwNBa4l/qP2k5hOpdtSUSuHlWNsl5mm5aCmeCKjSwfbe+nrab9lKL1sMx+Ojyg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732686903; c=relaxed/simple;
	bh=DYeNUbOBSFJ0vf27Rx9xDE9PY/kh+bGeaGdojGAuIZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ks7LQrkTHxqL3RORs9gCNfGRrVRJ9zB8NoQJkN1eqsctmK+bPGCpHc8WeNrue9Z0hCkkpwDFpp3K222X7NSRXRAKagVocQBn3JKx4LgkXBG0zLLejio9P099MkUACB/JtWOj2CCfldXnoTSLrOYGGabml22VIurGPRcna83gTpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CQQciWF4; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hy73kf/8HF8ip69Q2fEh9cc+xncn6RFzbstU4YCw9HomGPcFX7c4SV8EJ6sFEJXPPI6hjUy3HjVCqx8Q+YGePFSbDSH3ssis4+HwUWIkBjwmOpHOoPS0Ynqyj3A5Xg3RpzmZ515ld3hh2klKFwV/UHu5U3joEXPgLWePktNhNibm/wcwIs8XgiwMIgN/JsvP9lexJlVheNCYYrfhqd0Di26BQ4blVSCgIUlmgiU6N8nuI8QXkYcWbcpeuh/05yNjoiBNkMSgdflRKfEZbK5hbqe1g3jzkfJsGiHN5X3AxJxtx5WIbETyR+AERaMhqQbjJwuo+pLRX3g5Eet25EdWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8MuhMzHxew+K/nbT8Tzz+kK6qvyQjNRK0L8zn8V1/E=;
 b=E96ZfkZXbSxJtnJkLwYPux+16LOQTzL5oXwJtZxLXZfQXib+n11mA/PxTB76EVgHF2T4QPIcKphNpPwIsjAW8vT/Z+Vcy26csJl4GTIqqLTy4OtcKF8Bqw6NSgJL+zjxzgCe/0WaqTsYn+8U7sJpdr6I5MWYojpnTtCgQbI9sEj8dlpEg5vbuO3XaPxPmR0VvM+GIYxmpU0ZToGTUtm/fTUNnyItM2CYq7z0LtLfPAYvuQaZPMMsPxl1SxAF0EvizrIFaKAp+4wIR+WK342sHzi87FzwElGu2yY+a4uw4VsMpbzoe5Wu4azOzjmOLxthCTokc8fviiOHKvyIREPrxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8MuhMzHxew+K/nbT8Tzz+kK6qvyQjNRK0L8zn8V1/E=;
 b=CQQciWF4gG3g+UNWiXT1mQTA22NbWo1OMPbdN2335p5UIhHLh/skceNk2Ra3eDOg5bRkre7Z/A96CdIwVi1Aa7AyFInta/cTgB4hd8BPG9f3MByqUO98UCVT7iUkTb0KKTVUk8BOM0fdywjGo1R9Ns9GEKNNmGejTZTISR6fgY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 05:54:57 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 05:54:57 +0000
Date: Wed, 27 Nov 2024 11:24:44 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, peterz@infradead.org,
	dave.hansen@linux.intel.com, tglx@linutronix.de,
	len.brown@intel.com, artem.bityutskiy@linux.intel.com
Subject: Re: [PATCH v5 1/3] x86/smp: Allow calling mwait_play_dead with an
 arbitrary hint
Message-ID: <Z0a0JNRPuRYaVrcI@BLRRASHENOY1.amd.com>
References: <20241126201539.477448-1-patryk.wlazlyn@linux.intel.com>
 <20241126201539.477448-2-patryk.wlazlyn@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126201539.477448-2-patryk.wlazlyn@linux.intel.com>
X-ClientProxiedBy: PN3PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::8) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: a28a0ea7-eaa9-4e2f-2165-08dd0ea805fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lqbIYZcBMmXLCBl3hKOGrBCZi2clnI9bJegwF7c2iKyfPOAiAALD6nslcp0i?=
 =?us-ascii?Q?MxsP78cB+rXmTkx+o+8uRqYPEqJBrikFQtVFrJYUkcZ3nacQa1fetbMGDwye?=
 =?us-ascii?Q?Awcjdc6IlzEHmVDU+5BwMiZPxvOGhco4yWSxbZvIGnnpEGGU1AwGQe8wygW4?=
 =?us-ascii?Q?eOIf8kYD1FQRK3AzsN2ELMANtw3tMdg2NonbSjBFzFZodyXXS/IYvigOMQpK?=
 =?us-ascii?Q?dRDy8b1AlP75mrLMHDi77Nq9zAf1eywG5yVu93V0JxIbSgXrWtxVawaQR4Ha?=
 =?us-ascii?Q?T6k/5mgO9fTPlWWgvdACSud7+H7Pc9P20PLAQNNteqKXOvM/lQ9PRnVT2/TS?=
 =?us-ascii?Q?zK7PKmmGKJHYLm1kT6Jcab7aABIQx7J4//PNhltN+Lekdq2isjWMGaWXVaEK?=
 =?us-ascii?Q?LYTo4o91wH97Il7lfG33eaImc6y49g3ICB/sTz8MTXxcBrjsXdNl3X6PpswC?=
 =?us-ascii?Q?rGuOK92t9zN5P06gxs0PK+kDWuaC7eXbp5Yszl6l2yPmzsGgHmDZOJsAWwid?=
 =?us-ascii?Q?sMpgN4Cz8dNGbOMzEnTmgjLkBY861NZ0rblMqiavGhZs/K+shJbM4S+Q0P3E?=
 =?us-ascii?Q?ddVYZOHKnzyEgoXErlfanlwtIA6ZgYnDfwX6T1u5uuPNJBXe9GOFUDMzN2s8?=
 =?us-ascii?Q?/aBADMWhHtaEwLOa8nwovPPZ9cLiTetdoD8ad6e70hD46/sB5gw8//rJySeu?=
 =?us-ascii?Q?+qV+R6O9zhcqyc3h4TvCW/nU212dxgN7TOhVHeKFozweK2PipsmnkNFcZ6ws?=
 =?us-ascii?Q?MZe6P2fvh+kZJCk+U5S98DNxaA9JgqScQIr3B6dZkdQcC3LJ4KD/6y7zPhzg?=
 =?us-ascii?Q?lRzW9p0x7tcfYzuOQJ0KtB6eoT4Kuchb7ogBqJ17DoCMLAI2W3x/aRkSz4oT?=
 =?us-ascii?Q?1FgWxvdkw9x7FG2tG6Fne7tyC1rJgFepdSdnic4VNA4iGXCl6lCSTVg4z8u2?=
 =?us-ascii?Q?A+BFQ+7f/ollZV1UHnqbZHMOXtaFktV1DuTPaJp6f0bcGBivNwFZPYzl1QVQ?=
 =?us-ascii?Q?QANmUqqPtess+A2/+X3Cn6aK1slWvZIauEnnuS6iENgEuEaanW1ivEy45baw?=
 =?us-ascii?Q?tNdOYUKTxr2DozHYzHJ8gowjV6+HQ1vFQUvNNOdTDru4viDPrhj5CvgvgHkN?=
 =?us-ascii?Q?poU6hB1kwXIBWHj34l+pMVYqh4b1fFiIWeYyINPi6E8NVLmvu3NQ5Cj0h1QF?=
 =?us-ascii?Q?uU2IPI1SxKyGBsrgLAQu39YzQXE6ZA1VfwFT3PO0rFlERCtU/IhGgozAnfaI?=
 =?us-ascii?Q?TtwYFNpBkRHf577oYfGHvsxWIqim9V7VY8SBYR2uJHz0RObE/DIuXvUSteMz?=
 =?us-ascii?Q?nKqRLNMo0grasYo+aN7Mxfjh0zOCQkfswIMP/KWQnJx3Sg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pmnTDAeX7fR2vKoLJRgwQx8+yUUzVwdNx+WaaJcndxJwRthG1b7MXOt1GyGx?=
 =?us-ascii?Q?FWK7RRVlslGu4WJcITSnXtvDFOVgBTK7oxjS8CB60Nz06hAQQobP2LylsI/a?=
 =?us-ascii?Q?iDcIb+eFcJhk+ia3wVCOc5y2NdZpk6j22h27DCxBrM35fCOIt+NhCDIjyWP0?=
 =?us-ascii?Q?7KVBfT1NSH9OG32GKgkgtfxCP3a7M0rGqsvbxqVek2BMywk61vn1Coksp+7m?=
 =?us-ascii?Q?z9nfg6ybIwCPmDHjdH7U3L0MIqjwLOFmalD501XS+6lXKg1Ud8EEPq0SPBAG?=
 =?us-ascii?Q?52VmFsEATsJi0PQBMXj0aH5+LQ7BpjM10Zh9Vx4VEwZlCANEEXBxf1UpDa/I?=
 =?us-ascii?Q?t3WdTarRuw7VGavgSAoOnmV8pTouVaSkybTRHnfKu99LDQw6VB2eqJuqCErT?=
 =?us-ascii?Q?O81u3jf+p7FByrDaELO9rwaWta7tZWSh+pfh/dLdNcD8Cyy6hNNxJ03s0Aso?=
 =?us-ascii?Q?kjTMB19Q4SPYC7GLAAS1muH7zbuTECtWs61xVX2ErrpwTgT1i/02KVKgQWjc?=
 =?us-ascii?Q?PIqp7DFTpsBUIl9MQ1P6wmeCFiFHd24N9nmi6W7qsv9NBoIdShEMshxvSIQi?=
 =?us-ascii?Q?PE2Oxv6HHrtn7/vpjqo2lMokjdB54OOPZgllXuVAsMPCTxOy3PqSoomh2Ftl?=
 =?us-ascii?Q?orK3ipQwRYm80mbz0cCno62KNZRz/Q3SWBHIJAwxcSnTQzxrOr+TZUSnIZ5s?=
 =?us-ascii?Q?IlCH7ICt8uomjqmejaRc0rwdoOyvAwvwOaSGSgMlR2aPC1HeP2KSPQBUx0Xi?=
 =?us-ascii?Q?AeIr2iO/Bui9sdEAU7rtKsxr831MeEuT8F1P5GECxUkw/XFTkdMQa5l0KMXj?=
 =?us-ascii?Q?AgWsbzaRfl5FyLOQRJf8HioSHHkUCCPf+EabnG5iNzvJxUVuFKSSq65aryiv?=
 =?us-ascii?Q?qrtVBfAo3xA1AFxDztix+XYII+TU4N2quW4F5Is0zrZl3bjEvnycA2VmABwz?=
 =?us-ascii?Q?zkOtUC8LTwsQK81/XAfxNXwxmY4E6FX8Y4KkxYlyuUYWicKrYoiXxQWXQC9z?=
 =?us-ascii?Q?yW+j6aAVcZxCRmMT2candkKeRK91tgJ2PFaU6adWlmyBbrEHRck2/b0BMxIB?=
 =?us-ascii?Q?pGx33N+c71qOq91PtBf4z1xd35lHJxVoiVgz0QBfbUzIH666mJhYiL4Hlhkh?=
 =?us-ascii?Q?uLDrDsPivf+qKs/r/ihkmQ9q0sFCffNRkjx417lirzGhJE7HhBb1UzmqJ8Vk?=
 =?us-ascii?Q?ASYxrNk0TRuvs5942I2ctMg0ObdASMnBzXe8oS++AN5EWgsOoRe/erF7eBKA?=
 =?us-ascii?Q?5AYZr5fOBmCJspTclbrnIdP4E9SMl3guZFsYzbL+6ZTxx66TFrHNvty4CQ5K?=
 =?us-ascii?Q?kqqGGaNfiB+CkTmmNYE9ylLyMlzrSA4UxLUKZG6YVzk0j96YQENCgpHlSreB?=
 =?us-ascii?Q?ZA6TO1+e24xqr6jN/3b4mrcEbRzBswUhhxzLX75tDtnyTWYQRyCOBzfArjNd?=
 =?us-ascii?Q?lSTuhI1P9zbw7K0srtgUCrJ1kxivDOTets+E0Lvis+CM7nmHo+gfmc3Dqu1l?=
 =?us-ascii?Q?TtP1EDKlwq/HkeU6nRjN6mlItLWSSV4x/QqWQ04BlGzok9TT+rY6Hjv+ymC0?=
 =?us-ascii?Q?pnHXUX77LAWJ3kihdC9JgkgXpvhQemAeKlsOg4+T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28a0ea7-eaa9-4e2f-2165-08dd0ea805fd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 05:54:57.7372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cKLFO8cY3qQql/7aEYZ4CWSyC/f2/A/yUFcbisU/uLjk5/Y2AS+b/VG+0KVOGE74lY3B30yCfCYWRsS0pdmjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724

Hello Patryk,

On Tue, Nov 26, 2024 at 09:15:37PM +0100, Patryk Wlazlyn wrote:
> The MWAIT instruction needs different hints on different CPUs to reach
> specific idle states. The current hint calculation* in mwait_play_dead()
> code works in practice on current Intel hardware, but it fails on a
> recent one, Intel's Sierra Forest and possibly some future ones.  Those
> newer CPUs' power efficiency suffers when the CPU is put offline.
> 
> * The current algorithm for looking up the mwait hint for the deepest
> cstate, in mwait_play_dead() code works by inspecting CPUID leaf 0x5 and
> calculates the mwait hint based on the number of reported substates.
> This approach depends on the hints associated with them to be continuous
> in the range [0, NUM_SUBSTATES-1]. This continuity is not documented and
> is not met on the recent Intel platforms.
> 
> For example, Intel's Sierra Forest report two cstates with two substates
> each in cpuid leaf 0x5:
> 
>   Name*   target cstate    target subcstate (mwait hint)
>   ===========================================================
>   C1      0x00             0x00
>   C1E     0x00             0x01
> 
>   --      0x10             ----
> 
>   C6S     0x20             0x22
>   C6P     0x20             0x23
> 
>   --      0x30             ----
> 
>   /* No more (sub)states all the way down to the end. */
>   ===========================================================
> 
>    * Names of the cstates are not included in the CPUID leaf 0x5, they are
>      taken from the product specific documentation.
> 
> Notice that hints 0x20 and 0x21 are skipped entirely for the target
> cstate 0x20 (C6), being a cause of the problem for the current cpuid
> leaf 0x5 algorithm.
> 
> Allow cpuidle code to call mwait play dead loop with a known hint for
> the deepest idle state on a given platform, skipping the cpuid based
> calculation.

Apologies for what may appear as bikeshedding, after this patch, the
cpuidle code still won't call any mwait based play dead loop since the
support for enter_dead for FFh based idle states in acpi_idle and
intel_idle only gets added in Patches 2 and 3.

Does it make sense to split this Patch 1 into 2 patches : 1/4 and 4/4

1/4 just introduces the mwait_play_dead_with_hint() helper which will
be used by patches 2 and 3.

4/4 get rids of the of logic to find the deepest state from
mwait_play_dead() and modifies native_play_dead() to call
cpuidle_play_dead() followed by hlt_play_dead() thus removing any
reference to mwait_play_dead(). Optionally you can even rename
mwait_play_dead_with_hints() to mwait_play_dead().

That way the changelog that you have for this patch can be used in 4/4
since with the addition of play_dead support for FFh states in both
acpi_idle and intel_idle via patches 2 and 3, the logic to find the
deepest ffh state in mwait_play_dead() is no longer required.

Thoughts ?

--
Thanks and Regards
gautham.

> 
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> ---
>  arch/x86/include/asm/smp.h |  3 +++
>  arch/x86/kernel/smpboot.c  | 46 +++++---------------------------------
>  2 files changed, 8 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index ca073f40698f..633b4a4aec6b 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
>  int wbinvd_on_all_cpus(void);
>  
>  void smp_kick_mwait_play_dead(void);
> +void mwait_play_dead(unsigned long hint);
>  
>  void native_smp_send_reschedule(int cpu);
>  void native_send_call_func_ipi(const struct cpumask *mask);
> @@ -164,6 +165,8 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
>  {
>  	return (struct cpumask *)cpumask_of(0);
>  }
> +
> +static inline void mwait_play_dead(unsigned long eax_hint) { }
>  #endif /* CONFIG_SMP */
>  
>  #ifdef CONFIG_DEBUG_NMI_SELFTEST
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index b5a8f0891135..5dc143e1d6af 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1276,45 +1276,9 @@ void play_dead_common(void)
>   * We need to flush the caches before going to sleep, lest we have
>   * dirty data in our caches when we come back up.
>   */
> -static inline void mwait_play_dead(void)
> +void __noreturn mwait_play_dead(unsigned long eax_hint)
>  {
>  	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
> -	unsigned int eax, ebx, ecx, edx;
> -	unsigned int highest_cstate = 0;
> -	unsigned int highest_subcstate = 0;
> -	int i;
> -
> -	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> -	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> -		return;
> -	if (!this_cpu_has(X86_FEATURE_MWAIT))
> -		return;
> -	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
> -		return;
> -	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
> -		return;
> -
> -	eax = CPUID_MWAIT_LEAF;
> -	ecx = 0;
> -	native_cpuid(&eax, &ebx, &ecx, &edx);
> -
> -	/*
> -	 * eax will be 0 if EDX enumeration is not valid.
> -	 * Initialized below to cstate, sub_cstate value when EDX is valid.
> -	 */
> -	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED)) {
> -		eax = 0;
> -	} else {
> -		edx >>= MWAIT_SUBSTATE_SIZE;
> -		for (i = 0; i < 7 && edx; i++, edx >>= MWAIT_SUBSTATE_SIZE) {
> -			if (edx & MWAIT_SUBSTATE_MASK) {
> -				highest_cstate = i;
> -				highest_subcstate = edx & MWAIT_SUBSTATE_MASK;
> -			}
> -		}
> -		eax = (highest_cstate << MWAIT_SUBSTATE_SIZE) |
> -			(highest_subcstate - 1);
> -	}
>  
>  	/* Set up state for the kexec() hack below */
>  	md->status = CPUDEAD_MWAIT_WAIT;
> @@ -1335,7 +1299,7 @@ static inline void mwait_play_dead(void)
>  		mb();
>  		__monitor(md, 0, 0);
>  		mb();
> -		__mwait(eax, 0);
> +		__mwait(eax_hint, 0);
>  
>  		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
>  			/*
> @@ -1407,9 +1371,9 @@ void native_play_dead(void)
>  	play_dead_common();
>  	tboot_shutdown(TB_SHUTDOWN_WFS);
>  
> -	mwait_play_dead();
> -	if (cpuidle_play_dead())
> -		hlt_play_dead();
> +	/* Below returns only on error. */
> +	cpuidle_play_dead();
> +	hlt_play_dead();
>  }
>  
>  #else /* ... !CONFIG_HOTPLUG_CPU */
> -- 
> 2.47.1
> 

