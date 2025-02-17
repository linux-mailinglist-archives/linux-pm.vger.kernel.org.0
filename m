Return-Path: <linux-pm+bounces-22211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667BAA3851D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 14:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B323A907D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 13:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1B2215F6B;
	Mon, 17 Feb 2025 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P9j4qO1z"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9356A29D05;
	Mon, 17 Feb 2025 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800118; cv=fail; b=NmgLPuGZ/zbzaoUXWiroCqu8y9O4ZjW6w/Ecl3OGr3HovmhNy7lxDiqbNBWc1N7JQVwnknKbnqFEBYG8UpU9d4uVT7zcE5bqNqk6P7z7TlRbAutNI/eumpQEPECt9gvDXAdrmVdwtAQfzt1aNZdAQCozD1WaM8pS2kbbKS7hOZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800118; c=relaxed/simple;
	bh=HQu0KD293FK2MNeR2QjukpIsdQlSFcID2R7EjgHfDs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X5jhRdXsQSp8SAnQr9IVzKMzGxwYJbK/T3KjfIWOiZwi8fXl5x74SoPz75KqsS1elN3tc/bh4CW2e2ygxqQRnmBG3E9GpYhVjhhu2+g/MLHkrxDYLBa5eBu232LRzApu9XlgEpR3Mp484A6qs4gVUu2aF54AM5hS6aLKKwsTUmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P9j4qO1z; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZB+iBag0/xbNEN6P4AvSvvxHmzL489mvZ3izlRVfTABxe2iN7+9mKBbcpvWGqxTsE+A3TYry/zTKRVTVy7utL4WGyqt+ju2yQNXRzCgavVONn06Wp6qr3q0mR6b5+Tkucrmo9QyKBpAJaU9XXhd/NvOucHlFuaKogCFVhR2hvzCbJsTooGQzgzyau/y4pDS0RGFQzhrYcTM5eBQnA4ur9Z93e7/qFLrUrRuwlAmewwugIuwtK8d+aCBacaYC+wv7kUB6Ardiw8XbwV0c9b8WiItPphNMoMIEm0f3wfgW6rdU0XCj6WL+F/YPRFxIsduAWPfdvTwQBOh89RWCEE4/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OVgT9BnHdFB+wjMkf5jT9gbotHWHEocPn3AWKqFgKg=;
 b=gLZNGgS0z3pAnvIOWQCAj2vgL9CwaV2+v4MnVjHI6QmOSnqmEHURJv2F2VoMmkfutlttsZnCRt9DPnyHETiVmpKCSFdHqB0FrPLCdrvozipDnZqknEciTRoR9Vbb+vKIhk2A/CUfh0IZqEwVbUTMIDyuAlk3+yLCBkyn673vQBNFiLWwoLzxuamY1VUfQgZAX7ryFPd0830yNF4ZUMEjhfwJqxmvD8QhIoT1IlvEN1qPi9YrhCKPz1yOZLfjrvh/ltkyE5T+lppmtRizLId1iEIIOtbNHIDz9HJWk9Ca0pVeN6J+2+/i3WOJu7j5PPCYPP8lWAsBjFyQ3JW+mnzi9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OVgT9BnHdFB+wjMkf5jT9gbotHWHEocPn3AWKqFgKg=;
 b=P9j4qO1zWU4G4YIcfOhqL0ptmYT7YeDt9VfiTHif2f+ZBH1fkDYfLvQqrYIJnw9FCcPQNrtdniKYvy7r16OPgZ2XSFesqeoqDe1v4NfpC+4w7kuJhVo3F762cc8C0A71TzFTQPmt2whnvoJqIPj761n5SDkYYltGncwmTH9Olhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Mon, 17 Feb 2025 13:48:34 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:48:33 +0000
Date: Mon, 17 Feb 2025 19:18:25 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 11/17] cpufreq/amd-pstate: Replace all AMD_CPPC_*
 macros with masks
Message-ID: <Z7M+Kd4Ul0k5r3O4@BLRRASHENOY1.amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-12-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-12-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::23) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: b95365c2-337b-4f7e-caa8-08dd4f59c511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D1JH/LhOa8oqUsqyZ1XDwSazOfd4W0ckXajUndRag20ezdS6tFc/UGKpqZYL?=
 =?us-ascii?Q?9kYT6hM96Nw7IeLLMMzrL6PA1N7/3MJqH3OL58oSOWCBB97+sE7mQXzYoezW?=
 =?us-ascii?Q?OlPQ5b7Jvkw5ShR0GiKAkkvtoDPLAXFjCxLY0fu1DkGW9FI0MD1yfiGYXcvc?=
 =?us-ascii?Q?i26JazH6B/1j1GPVqRCgdtCzgcu4akBFGh7jK5mjFSzMFYHqpM5e64P4Hhu+?=
 =?us-ascii?Q?aiYze4jbazMhH+gByObxap0ZLb5WQi20L4+qTr7rUf9I2Me95YeTR9Ir2uSr?=
 =?us-ascii?Q?1QYGGoLOqu8Uv11LOgZjRmb4useAo8Slv73nccchEiecGB7bAjeaZTW0P/wc?=
 =?us-ascii?Q?1cakFfMGcrl1MiUjkEAoK6Bv4VesU4Zgp2Mf+lyrcCW1WHxec1hPtU1etGM7?=
 =?us-ascii?Q?PI89aWq+gg0ZkAs99jerht4aHVhvrIIytNi80VD3nW9QBR/5xzzOY7lmg+Sz?=
 =?us-ascii?Q?B7XCaSvEiWJ7VPOO8UdRcmV1b+1Sb8OwXqt6zOs900B+TOyeuXuN8fax3P7/?=
 =?us-ascii?Q?Ho9YFdmKf9XOFy64esnZjK3SHS2nejMhXsakv4vDSWnZQ0t3lJHscIzlq/Jd?=
 =?us-ascii?Q?aEbgQtFuzcfbiuI5MNfQYI2YW0LQT7YNXvwtz08ujQeMXFWQCJGKTrprw6Kz?=
 =?us-ascii?Q?ATdS1oZ3gA+BKl1u+4CYcg417uPbJQBKzy8mlQtMF+TzZbME9Lzh0hTrsXdz?=
 =?us-ascii?Q?D3fdGdmOjmK2LxWb+oV8UeJsznQzI6lOkArAokskAEY01hiMEQGKgmjqhu1f?=
 =?us-ascii?Q?pZQ5uVSeNdr4cCt43U7FPi5cdnLEHttApnSxyICD6xZifgvRZLEOQR6Hjd+/?=
 =?us-ascii?Q?3dOw+qY5pDy77bJkLrEC23E/tvM/YgZq3hNTrkMowzhdRD8Z4kOofQjsOVp6?=
 =?us-ascii?Q?nEJJ2bMOtQUwHz9ju9AdpbW8TZWUX58r7u3WZzjJnGX4Mq6qK4pD0LhfdznL?=
 =?us-ascii?Q?6Jg+wlfNvQPLthCBuuR0waB4UJHXFUifBFJf9KpwU4j1dftQLTJXI78SdbVy?=
 =?us-ascii?Q?pTpDk7gJApsvRRsXFfhQSBoYNdkD41ct6PxV0e3rddMC+TUXwnp+oPcYZQr2?=
 =?us-ascii?Q?RHB6aJ31ovtnX3ipo06jPYMeQONBtA0GVJsiULY60AtE35eXro3xLSnXN5Rz?=
 =?us-ascii?Q?J0XaFg33VQ6p1jxfVcE46OCFbG4SUmv1gb8pb4uwrWIeFzeHpHO4eO3Pmwq5?=
 =?us-ascii?Q?o5KvNRcWjwwmvcEMTVHESjaOdugyjNxF9R9LsFGtA8g6dXADzQkOmq2fofAd?=
 =?us-ascii?Q?n36JdBAyuUdfCQ1J2s8a0mMxiJ6PAqXFPfS3sgoaKSH2tUJXrjNYzVBz+kAd?=
 =?us-ascii?Q?2P9CzKfJRNqUsNFIEegvXPbYhjbKQLeMji0mElj7ipwGb8PtNwso/88GC3X2?=
 =?us-ascii?Q?x1yXcYls0TxnhvXJ9T8lVem9LaV7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?upkrUBKnDNtqEytn9Vzratkgo6Kif/B5uWICWntA602A3dghs+dH4Q4rXVLj?=
 =?us-ascii?Q?RSpp0IOzkt/ZsuCpg7Ih0BRSPfz2hsIoVLTa7tgaYP20+cUQwux1qAUrsonX?=
 =?us-ascii?Q?RJ/yEeYnvT8T0yyTii+udNNHab1LdIz9lqMhfdiczC2RNVVJaB8gtfm0ChgP?=
 =?us-ascii?Q?uaer7G5yhpTGOcpnZTokCxzUNCLBFIXXvhEvZcF1lUvrD5q2+oF9iQzvv16v?=
 =?us-ascii?Q?ftXg/tA7B23pa9UOYLe9l72vFoKX1TmsvkJHcJEvgc+4pk8jGJpCscvzXNiC?=
 =?us-ascii?Q?w8pESGUeUgPgCEkpKBb9T1e6U+BDn6V2YeqEpcLRZYpsGM1ixaTYgV2bwpMq?=
 =?us-ascii?Q?SKI6oYSEW8x9LKx/9cKa1Q+PtoPMDbbidC/WJEXXWqRDgIvyrs6SuISWaWcu?=
 =?us-ascii?Q?04jBgvKhArd1RBxnzKBfAzDkP89gaSBbf4TrCrCpp/qWw0SllLHo8csiBH8O?=
 =?us-ascii?Q?ukTww8p6zKplUMd+IBYopl2QvZksqqto8+7oBf3RoQnkbHtAT5fReVt17Jmm?=
 =?us-ascii?Q?RH7E7ORNL796Bp2NXqZhzxQrJalf55jqB5rzMAjvrlaK7yEjeJwxnRbJy28x?=
 =?us-ascii?Q?Q87tzQqqIYUhXVlxdFMQVDfVn1v5C3WOUrDBbD27js9TVuPC433bRtnB0LzR?=
 =?us-ascii?Q?fB72dsdvFPxqc4DDtRbDiGkKPSRGuMKCdGumGovWyIWLNRcIngEIUoPlNvPR?=
 =?us-ascii?Q?OT/eXBwPh+gDxKUmFU9g0WfHlIylA9/PEuF6cx3ECXPopBSi6jJSZPD3ot1L?=
 =?us-ascii?Q?DQ7JErhky/y/OeOfFzhdoVW+b2HW/jhcY/3RYuEQNotkzCyDrcBiq/n/X8Kk?=
 =?us-ascii?Q?1o8QPNnMB0RXzvjlChJNlGGCGPRQRzfA0u6xKvLc4+AJU4L0GF5P3Mgvyt23?=
 =?us-ascii?Q?LCb6oaNpnJx6IjVqL5loGHYbIOQeQpEOEu24ZUyVY6AEq/wEJ8dnddpdNReL?=
 =?us-ascii?Q?MPUa9hQTupfjT3+viccnyh1JWPznkxndeZGdWq9UpzUbShDjBfcyIiGQxlck?=
 =?us-ascii?Q?dQq7t/Z2trstrXPd3ldF5AR5TOqtZQfh/1M8fVNfm8eKdAMAkGocgmMRLW+V?=
 =?us-ascii?Q?6rn5r9B/7bWKFQEVYu2VmfpAkMXLSwpUVsnVnhmXaY1WLGkwtEnZ8u9dvvtO?=
 =?us-ascii?Q?WFdfnZFgAXCy/t4zF3VHINZZFULC4CZ1luwDeIW1b0KNVfmJnAbSh0S3nKTf?=
 =?us-ascii?Q?9ei0VDB1XYKe31rY+D/osrw9hEFwCYf5Nrix2Zqzxv5JFPa1Ec4tN3kvk+RR?=
 =?us-ascii?Q?zYFogQltJgtm3puH35PJjIV3J1jrmDMoPJsi1j5Znbsm41hSAFRikQ6M5rwQ?=
 =?us-ascii?Q?lY5mr8MBFR7OelXg0cTZOsIUKfmWgdSz3t3iHcxU0ZZQ6vqp2S3DjWbqSJd9?=
 =?us-ascii?Q?fqLVCNzIwKFxCQ/LDNRxBeXFa2YhM1L+igtnuUgv4Pui11LMI70P2aEHDtis?=
 =?us-ascii?Q?Ma0FwuZ6HcoIWYVgeY6dVZ3Ppdn+SAECWM4Y+hyrumRxwkp4QXdYSW8PC0Kh?=
 =?us-ascii?Q?+ApNuWfljDPzpf0Upq4/lWk5tYZ7j5yvQzCtN5uWWDWxX+DCi/KBHHusQaxU?=
 =?us-ascii?Q?14A6Khv+0yfIE1CIDqXZZjYD7lQdPlMPcyLhBP/e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95365c2-337b-4f7e-caa8-08dd4f59c511
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:48:33.7059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZ3P6CN/7uPcXP3wFqGdVEXrpC3lHWTOcl+Y+nzEy1u/1fCbJIyNk2arlJ3AEQ07/c99sLlqX9/PxR2qjBzMew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598

On Fri, Feb 14, 2025 at 06:52:38PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Bitfield masks are easier to follow and less error prone.


LGTM.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>




> 
> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Add a comment in msr-index.h
>  * Pick up tag
> ---
>  arch/x86/include/asm/msr-index.h | 20 +++++++++++---------
>  arch/x86/kernel/acpi/cppc.c      |  2 +-
>  drivers/cpufreq/amd-pstate-ut.c  |  8 ++++----
>  drivers/cpufreq/amd-pstate.c     | 16 ++++++----------
>  4 files changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 3eadc4d5de837..4bb87884998a0 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -700,15 +700,17 @@
>  #define MSR_AMD_CPPC_REQ		0xc00102b3
>  #define MSR_AMD_CPPC_STATUS		0xc00102b4
>  
> -#define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
> -#define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> -#define AMD_CPPC_NOMINAL_PERF(x)	(((x) >> 16) & 0xff)
> -#define AMD_CPPC_HIGHEST_PERF(x)	(((x) >> 24) & 0xff)
> -
> -#define AMD_CPPC_MAX_PERF(x)		(((x) & 0xff) << 0)
> -#define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
> -#define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
> -#define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> +/* Masks for use with MSR_AMD_CPPC_CAP1 */
> +#define AMD_CPPC_LOWEST_PERF_MASK	GENMASK(7, 0)
> +#define AMD_CPPC_LOWNONLIN_PERF_MASK	GENMASK(15, 8)
> +#define AMD_CPPC_NOMINAL_PERF_MASK	GENMASK(23, 16)
> +#define AMD_CPPC_HIGHEST_PERF_MASK	GENMASK(31, 24)
> +
> +/* Masks for use with MSR_AMD_CPPC_REQ */
> +#define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
> +#define AMD_CPPC_MIN_PERF_MASK		GENMASK(15, 8)
> +#define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
> +#define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
>  
>  /* AMD Performance Counter Global Status and Control MSRs */
>  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index f96053c305c61..77bfb846490c0 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -151,7 +151,7 @@ int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>  		if (ret)
>  			goto out;
>  
> -		val = AMD_CPPC_HIGHEST_PERF(val);
> +		val = FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, val);
>  	} else {
>  		ret = cppc_get_highest_perf(cpu, &val);
>  		if (ret)
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 9db20ac357042..067e9e325102e 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -142,10 +142,10 @@ static int amd_pstate_ut_check_perf(u32 index)
>  				return ret;
>  			}
>  
> -			highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> -			nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
> -			lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
> -			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
> +			highest_perf = FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1);
> +			nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
> +			lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
> +			lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
>  		}
>  
>  		cur_perf = READ_ONCE(cpudata->perf);
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e5983e5c77ba2..0a7e69fd32dbf 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -89,11 +89,6 @@ static bool cppc_enabled;
>  static bool amd_pstate_prefcore = true;
>  static struct quirk_entry *quirks;
>  
> -#define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
> -#define AMD_CPPC_MIN_PERF_MASK		GENMASK(15, 8)
> -#define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
> -#define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
> -
>  /*
>   * AMD Energy Preference Performance (EPP)
>   * The EPP is used in the CCLK DPM controller to drive
> @@ -439,12 +434,13 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>  
>  	perf.highest_perf = numerator;
>  	perf.max_limit_perf = numerator;
> -	perf.min_limit_perf = AMD_CPPC_LOWEST_PERF(cap1);
> -	perf.nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
> -	perf.lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
> -	perf.lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
> +	perf.min_limit_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
> +	perf.nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
> +	perf.lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
> +	perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
>  	WRITE_ONCE(cpudata->perf, perf);
> -	WRITE_ONCE(cpudata->prefcore_ranking, AMD_CPPC_HIGHEST_PERF(cap1));
> +	WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
> +
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 

-- 
Thanks and Regards
gautham.

