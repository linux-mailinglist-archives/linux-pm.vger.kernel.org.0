Return-Path: <linux-pm+bounces-23342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6537FA4D2D2
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 06:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5717D16ECB9
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 05:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BF31F3FC6;
	Tue,  4 Mar 2025 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HS/a379f"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486E1E9907;
	Tue,  4 Mar 2025 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741064953; cv=fail; b=OBEs2tzYkE8cSZjG+hadmnMrLo5lVFmOqD9H1po3axd28XOFZtr+rphtFMlbzLy3fDUrDneFTICLCInzgY9tB1zVz0zXvG+1jC5pWkHYoCwwf7k1IgYvwkpuDWihk36KTZ9iy45TrZ/NIPatp1lR2unQVrvj2QLEZgBY0Eg3JcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741064953; c=relaxed/simple;
	bh=pBZK3AObBCIE3P+8CI2+/ql1hMv/lGATfBz8lOlODh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JCd01G6YiSz5ZbT3X8tntybUOxB/FEQwgOig6AbsIkvO/Jek6vGg009VBOjg7tW1/upkdYfZn0sjiGB5VrPhFouCEyJ0RrKiLgiWl5wtCkjfcFFz/6rUTydQCS2UnYXu7q8nz2mPqHVcLjSoNwzyRzF1ang8Qd6q4tPNN8lEprw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HS/a379f; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjmkf7y9YuQcFjn0oioNQ9mb7iQGdut84m/VSVUNL4dkiyd7hjOlcjxV537RnQjQpLt4VbKHmKP3yBvJWZdwlDJpz8qQgrQZ5DYbqQBsHkBW0bruLAE76Qmi1K57t8/k/TNZHQNtXq4c5urwWmBG2fXSUsDFyw3DU7XvqgpHOVZ/AtuXfkXD0fOQyqwGZsfdOvbpx6At5HKr81AzULEFXs0vwXke6cRu0uvYmwR0SVc6YNhHoLkblCptdthHqGkMUgO30quCAzrugxFcbwBlzGvMSpJpSp1RlzR1347Qb1Ena4JDuQfP7BZlOU7pWT8qYXuEaNqX+oZ2VjpQ3H0Yow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdYZMTi86ZcoVH2qqYlfll6KiKBr+FO6QjswLNKwS1g=;
 b=bS5cF/MJ3q/bQUc25ejvDNrGyNtEYnzPVKxdrMlJHqjl7wlpTrkckZZbUyxd59lUykxV2DpsmG3zJdrTwaaa/fQJwyifhURCn+3CVkceTYw4jCcebjwN+3Cec5t34wl/6VDpnrCjgRztwGbktuxbi1lMZHc/VOu/Gyxjwc3lPqNH3XayRWno8mRQvDmIoqFyO5XU7Cvw9UL1OZHaYJyMESZdaSkwuUsdYdlaYNLvU1PqKGNAeXwEp+D6sXO7QYB/v5IecVOHXmLDyOtFdZUSiSLiOThlxuxzHeRgOKOc3R5ePnkUjx7CkpCfFnPSt2+EdEI4dJxazvdAOpSoL4LYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdYZMTi86ZcoVH2qqYlfll6KiKBr+FO6QjswLNKwS1g=;
 b=HS/a379fTsjWonrw59m2OjFAPbFsdypBsVYXI314M9o2ckJUDiLClY3AWexmt7neKzmpqVFDFQECIIMft78uJYrANJffSYMj0NOkSXqbaXVNlFNiMxCHZUVUD67LFzCtt6o+IquZoQ0xqQiWXzJEzL3TkpTKCUrixIwrrbqVB5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 05:09:07 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 05:09:07 +0000
Date: Tue, 4 Mar 2025 10:38:57 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v5 17/19] cpufreq/amd-pstate: Rework CPPC enabling
Message-ID: <Z8aK6Waj5D/jq2kV@BLRRASHENOY1.amd.com>
References: <20250226074934.1667721-1-superm1@kernel.org>
 <20250226074934.1667721-18-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226074934.1667721-18-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: e364ce6e-1d51-4c64-c3b1-08dd5adab075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+SrJ17hp5FRv+hNDreY0NJqPwjnXBQ6hU2OgjfoD6Rgw7ESyNV0gdiNZraks?=
 =?us-ascii?Q?O1VURnOc7Fj9XtoVxs9pTcv34QpfjDl2H0bbJQiQI0BnRCWcZzoy0wlyxotw?=
 =?us-ascii?Q?2Y9DHhwwy18Crj4wpOf8oGXgAkQCaHh7weP/+4PYDmrpMaufpcAzNDrOEPsP?=
 =?us-ascii?Q?gsL6U1EqueYh+7QytRtaLqR2E7EBV4lt1pwJImauZhPmspMxAeCXoVgfPlS4?=
 =?us-ascii?Q?8cNROxcAwffCDIVA3qMoeM8IIlK4Js10DUWIMVdqlLoupGp87YCPbLA/MX2x?=
 =?us-ascii?Q?hLlK2+lX9Tkw0RGfMK7S313RU14fSoz56wCKuq+buzG7TTUPM+KVrO/TqYNp?=
 =?us-ascii?Q?PnxLzDKZFfmjV3Lgm9qq0v/ECaO9UVFTfdpV33U1c//q17fkm+z5/UsKX8ws?=
 =?us-ascii?Q?3EYQ164cUS+XUfNGSEevwUcEjDpFfzPEsMIm0RMc/Q4Fmz/F5JyDvXxLpY9l?=
 =?us-ascii?Q?HI4b4tSkZS1QkYWQyMcC20w4NAs0DQdmDNY4r6gOE04BxyAmQuhkPm+eEtdn?=
 =?us-ascii?Q?+UgaQiTjiCeaDJRqTUtnUQ1GXT6wUmTpKn04IFcgy/tHn6K7du2DQDoEb7FE?=
 =?us-ascii?Q?PDx57FQXUn3GTU6PuaYtGHWOBHMT6iaxyWQEpph4wMDwf+cgRdyxItmh+639?=
 =?us-ascii?Q?U4MfLULAZ0AYAkbPwLnhP2Y4R7f/lLPZCh5Z7SeEi6rNp1yAKr5mgnFu5DAL?=
 =?us-ascii?Q?pBWkH+NkkMJY1Z/KwkjQgVl/plIGGTT5aFBd7034JWuP1Ltfm6UsX8VsKUkB?=
 =?us-ascii?Q?CbtKnqGspsvGnV/L8JgKqCaWXzWxtnrar5u9tAmtW4z4MyWDQ6Kdu34MYfmc?=
 =?us-ascii?Q?AoRgPJMB0fTUIMTVu4VSB1prPfk2JScnME4rsGNRbARd9OkGBoGbnuJfnD2G?=
 =?us-ascii?Q?RemaQ/CdAd9SCkHr6rHUVLP5kiwCUAIf74L0lx1GhQhvjlZ78Cn2fvHhlXrw?=
 =?us-ascii?Q?XIXqoWZqzTLEM7vA9wXjoF97nQXAIPNXcTOj6E5pdjSoK5klaScOd74fzPfU?=
 =?us-ascii?Q?eXWjXTtTIkBrJw0pgZd+I9+5U1mg8yswXaHsafKgAGFXkdE0jo7/Ij7v2f3D?=
 =?us-ascii?Q?GbmA1jYQpxymbMaxrp/TqlCyZBi18DTWnqilg/D7+ER+7OvkT45egiZnh7lr?=
 =?us-ascii?Q?85rmhHzMWjqoc1gW6VAw5BceFbhzPSwXBuQTWioFzqLw8JbzoyIHA9MdxRI0?=
 =?us-ascii?Q?XcT/CtjKYuNo8UeAM9tSSH6gWjVaap25cgchYrCEP/nTi8VHxj6IGtyn9di1?=
 =?us-ascii?Q?CaGuTwk+6whdV8MEzfTOpX37tXR3lJVfvMa5jt+pVupz2fOAyC0/w+DeepOA?=
 =?us-ascii?Q?v2TGzIECVYhuuji4spxUzVH1iiuee46u7jO/en3NOr1r/nPWoVMmvwp4pLPX?=
 =?us-ascii?Q?wklcEBr6HUne8CSsrUPwPx+paDUK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bBRYkWP400lNmr41V4YADoZV2tRKhpZS9IFDiaQGVRy+HWlJyRgwUveMbjv6?=
 =?us-ascii?Q?5rIV3Yq44PdOw3n4JVS49/KkB+Gnz3Ghm3a3z9AGMPqqklwjX5OvxVYgx5A6?=
 =?us-ascii?Q?ZTRRBPLxeFvD5oJzA9ApSTvqz+IP3yB2EpiXrQBIZf7u8bpCV3KtJ87+0Ogj?=
 =?us-ascii?Q?4S6KekFaiQtsi8vxRNmkn3S6hqFaYbJrhkwzCCUXQtj6Cu1wBmOo+OTPaUFb?=
 =?us-ascii?Q?3p9z6hIUlMVM59wv6RTYuvFTMb3GjJQXe9Sl48xVrly9zZ9E23++jM89zl26?=
 =?us-ascii?Q?tSGw/x8HZf3vRi0XowOSX9cto1e8uLGyyhIko8BkJJhhtstnhTKPDWnVYrme?=
 =?us-ascii?Q?pzuUXtI7gUlb+26f7uKp1z3l0pb0gOn6RB8fJdX3/yaAttXLbZL5GJG61Z5Y?=
 =?us-ascii?Q?JvkUuU3LDk95LgcL2Ox8U7mLymIVDGns+/BkXehdImklCnrkmGXno76Y2hMV?=
 =?us-ascii?Q?4kVL/rYODpi10P8AZk0hH2Mrga/DNLZCDYAYoR25hYvnR2cRSp+Qf0iM2jtw?=
 =?us-ascii?Q?sa7WlsR+wxDDePRfFJ8D5wBCqPtRo7EzpJIN/FaM9mYC67fo5rpitbIqJGuH?=
 =?us-ascii?Q?+CTxERfUfkfjH2Ll5r7nqMIAz+Msuhs346X4Z1Neew2m9TPNM2ND0CH18hTW?=
 =?us-ascii?Q?Zjxq7zsTdoGs06PRLZUJISGuWSP7v0ldPs7tnSBM3DX8uS4U0spDgqswbqBw?=
 =?us-ascii?Q?wQz3mTZsJLFr3lMz8saZG3lrkQJxnw6xsH1OFtjK9PjHCdnA2Kwq4+dhiG+i?=
 =?us-ascii?Q?rbfJh2c/IiDhl6W3FhCbYhTqh6roLZ/jkKqUJO0sMH7e5YuepEKOYiD/G4LZ?=
 =?us-ascii?Q?VW2pFHphnbRndaeJf/00+5LGTUwN0cjfgvtB3r4UaxqNR29Jebc78z2fpVb1?=
 =?us-ascii?Q?Bebj/OE/kupPDjHopo6eWWPFYiLgeKVUuUchBuFxOCkkTjsB3s0AXbD9GIPM?=
 =?us-ascii?Q?G+5S6NcVIC4luURHCTXJWzJYDsVUJGGgv78njGjDhbl5g0n4HpqEn2lKryWt?=
 =?us-ascii?Q?2p0qA2Vn+j956MtAmX8NC+vkc9y3i8L9vffP+70dHsMuOgWrlKzNNMM3wYfO?=
 =?us-ascii?Q?xo7C2BMJAnSRh4Q8HXIpniSt3sKkMscEUuVeM2mVyUQTj3ouGCIgGXBO5je3?=
 =?us-ascii?Q?JvEzj5zn6wXk2OJ8to0fBO7Y0iwhGtlYMczPAAWTF4AfrQhmsoqIU2DsqLtQ?=
 =?us-ascii?Q?wb2pfFBpz8QwRkvwkHUZTiKCchqewOiy+6kGRQaC6l0xS9fxpZ+mopqJQiH9?=
 =?us-ascii?Q?Z8CQRvi1YpjuVkLSsS+zJ5m6x2xz9s5GORm77JSjp5tt+Mjuzc0QBIhGC/M0?=
 =?us-ascii?Q?hKR317a8rKG8/dlKaQAd+FKV+w0vdEXrSygXHlBTUNihBXnFnH9kOEXFrou3?=
 =?us-ascii?Q?Amzj/atdbu7Siz1QyarXuI2JqwpNLndeqxIIs1aBt3zIHsrJcmcxNLTBB+1g?=
 =?us-ascii?Q?GIyB6YggAQD2e5E3E2RIE2JGF3qIQ7o8Ig1bjdUVeCVUvMGxoEqBLgUyvmp/?=
 =?us-ascii?Q?pqqonN+AgNW4qidGRVPbVg1/bSu0VoTg56M6E7uSEtGo/QIsZjqfUKQ4Wbks?=
 =?us-ascii?Q?C1hgMFsk5rlSiCrxeaUK3qwGnZI+WzdyQF50hmdC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e364ce6e-1d51-4c64-c3b1-08dd5adab075
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:09:07.0676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTOnaFjFKeJZfi95cWmalRhPZwwxIHPmiCW3peMWPsISmJ4U5YEDTsUbgcAGEndLSI0P0N9XLo3nqVkKhVBRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728

On Wed, Feb 26, 2025 at 01:49:32AM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The CPPC enable register is configured as "write once".  That is
> any future writes don't actually do anything.
> 
> Because of this, all the cleanup paths that currently exist for
> CPPC disable are non-effective.
> 
> Rework CPPC enable to only enable after all the CAP registers have
> been read to avoid enabling CPPC on CPUs with invalid _CPC or
> unpopulated MSRs.
> 
> As the register is write once, remove all cleanup paths as well.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v5:
>  * Drop unnecessary extra code in shmem_cppc_enable()
>  * Remove redundant tracing in store_energy_performance_preference()
>  * Add missing call to amd_pstate_cppc_enable() in passive case
>  * Leave cpudata->suspended alone in amd_pstate_epp_cpu_online()
>  * Drop spurious whitespace

This version looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

> v4:
>  * Remove unnecessary amd_pstate_update_perf() call during online
>  * Remove unnecessary if (ret) ret.
>  * Drop amd_pstate_cpu_resume()
>  * Drop unnecessary derefs
> v3:
>  * Fixup for suspend/resume issue



> ---
>  drivers/cpufreq/amd-pstate.c | 179 +++++++----------------------------
>  1 file changed, 35 insertions(+), 144 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f0d9ee62cb30d..89e6d32223c9b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -85,7 +85,6 @@ static struct cpufreq_driver *current_pstate_driver;
>  static struct cpufreq_driver amd_pstate_driver;
>  static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_UNDEFINED;
> -static bool cppc_enabled;
>  static bool amd_pstate_prefcore = true;
>  static struct quirk_entry *quirks;
>  
> @@ -371,89 +370,21 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  	return ret;
>  }
>  
> -static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
> -					    int pref_index)
> +static inline int msr_cppc_enable(struct cpufreq_policy *policy)
>  {
> -	struct amd_cpudata *cpudata = policy->driver_data;
> -	u8 epp;
> -
> -	if (!pref_index)
> -		epp = cpudata->epp_default;
> -	else
> -		epp = epp_values[pref_index];
> -
> -	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> -		pr_debug("EPP cannot be set under performance policy\n");
> -		return -EBUSY;
> -	}
> -
> -	return amd_pstate_set_epp(policy, epp);
> -}
> -
> -static inline int msr_cppc_enable(bool enable)
> -{
> -	int ret, cpu;
> -	unsigned long logical_proc_id_mask = 0;
> -
> -       /*
> -        * MSR_AMD_CPPC_ENABLE is write-once, once set it cannot be cleared.
> -        */
> -	if (!enable)
> -		return 0;
> -
> -	if (enable == cppc_enabled)
> -		return 0;
> -
> -	for_each_present_cpu(cpu) {
> -		unsigned long logical_id = topology_logical_package_id(cpu);
> -
> -		if (test_bit(logical_id, &logical_proc_id_mask))
> -			continue;
> -
> -		set_bit(logical_id, &logical_proc_id_mask);
> -
> -		ret = wrmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_ENABLE,
> -				enable);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	cppc_enabled = enable;
> -	return 0;
> +	return wrmsrl_safe_on_cpu(policy->cpu, MSR_AMD_CPPC_ENABLE, 1);
>  }
>  
> -static int shmem_cppc_enable(bool enable)
> +static int shmem_cppc_enable(struct cpufreq_policy *policy)
>  {
> -	int cpu, ret = 0;
> -	struct cppc_perf_ctrls perf_ctrls;
> -
> -	if (enable == cppc_enabled)
> -		return 0;
> -
> -	for_each_present_cpu(cpu) {
> -		ret = cppc_set_enable(cpu, enable);
> -		if (ret)
> -			return ret;
> -
> -		/* Enable autonomous mode for EPP */
> -		if (cppc_state == AMD_PSTATE_ACTIVE) {
> -			/* Set desired perf as zero to allow EPP firmware control */
> -			perf_ctrls.desired_perf = 0;
> -			ret = cppc_set_perf(cpu, &perf_ctrls);
> -			if (ret)
> -				return ret;
> -		}
> -	}
> -
> -	cppc_enabled = enable;
> -	return ret;
> +	return cppc_set_enable(policy->cpu, 1);
>  }
>  
>  DEFINE_STATIC_CALL(amd_pstate_cppc_enable, msr_cppc_enable);
>  
> -static inline int amd_pstate_cppc_enable(bool enable)
> +static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
>  {
> -	return static_call(amd_pstate_cppc_enable)(enable);
> +	return static_call(amd_pstate_cppc_enable)(policy);
>  }
>  
>  static int msr_init_perf(struct amd_cpudata *cpudata)
> @@ -1069,6 +1000,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  							      cpudata->nominal_freq,
>  							      perf.highest_perf);
>  
> +	ret = amd_pstate_cppc_enable(policy);
> +	if (ret)
> +		goto free_cpudata1;
> +
>  	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>  
>  	/* It will be updated by governor */
> @@ -1116,28 +1051,6 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  	kfree(cpudata);
>  }
>  
> -static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)
> -{
> -	int ret;
> -
> -	ret = amd_pstate_cppc_enable(true);
> -	if (ret)
> -		pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
> -
> -	return ret;
> -}
> -
> -static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
> -{
> -	int ret;
> -
> -	ret = amd_pstate_cppc_enable(false);
> -	if (ret)
> -		pr_err("failed to disable amd-pstate during suspend, return %d\n", ret);
> -
> -	return ret;
> -}
> -
>  /* Sysfs attributes */
>  
>  /*
> @@ -1229,8 +1142,10 @@ static ssize_t show_energy_performance_available_preferences(
>  static ssize_t store_energy_performance_preference(
>  		struct cpufreq_policy *policy, const char *buf, size_t count)
>  {
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	char str_preference[21];
>  	ssize_t ret;
> +	u8 epp;
>  
>  	ret = sscanf(buf, "%20s", str_preference);
>  	if (ret != 1)
> @@ -1240,7 +1155,17 @@ static ssize_t store_energy_performance_preference(
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	ret = amd_pstate_set_energy_pref_index(policy, ret);
> +	if (!ret)
> +		epp = cpudata->epp_default;
> +	else
> +		epp = epp_values[ret];
> +
> +	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		pr_debug("EPP cannot be set under performance policy\n");
> +		return -EBUSY;
> +	}
> +
> +	ret = amd_pstate_set_epp(policy, epp);
>  
>  	return ret ? ret : count;
>  }
> @@ -1273,7 +1198,6 @@ static ssize_t show_energy_performance_preference(
>  
>  static void amd_pstate_driver_cleanup(void)
>  {
> -	amd_pstate_cppc_enable(false);
>  	cppc_state = AMD_PSTATE_DISABLE;
>  	current_pstate_driver = NULL;
>  }
> @@ -1307,14 +1231,6 @@ static int amd_pstate_register_driver(int mode)
>  
>  	cppc_state = mode;
>  
> -	ret = amd_pstate_cppc_enable(true);
> -	if (ret) {
> -		pr_err("failed to enable cppc during amd-pstate driver registration, return %d\n",
> -		       ret);
> -		amd_pstate_driver_cleanup();
> -		return ret;
> -	}
> -
>  	/* at least one CPU supports CPB */
>  	current_pstate_driver->boost_enabled = cpu_feature_enabled(X86_FEATURE_CPB);
>  
> @@ -1554,11 +1470,15 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
>  							      cpudata->nominal_freq,
>  							      perf.highest_perf);
> +	policy->driver_data = cpudata;
> +
> +	ret = amd_pstate_cppc_enable(policy);
> +	if (ret)
> +		goto free_cpudata1;
>  
>  	/* It will be updated by governor */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
> -	policy->driver_data = cpudata;
>  
>  	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>  
> @@ -1650,31 +1570,11 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
> -{
> -	int ret;
> -
> -	ret = amd_pstate_cppc_enable(true);
> -	if (ret)
> -		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
> -
> -
> -	return amd_pstate_epp_update_limit(policy);
> -}
> -
>  static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  {
> -	struct amd_cpudata *cpudata = policy->driver_data;
> -	int ret;
> -
> -	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
> +	pr_debug("AMD CPU Core %d going online\n", policy->cpu);
>  
> -	ret = amd_pstate_epp_reenable(policy);
> -	if (ret)
> -		return ret;
> -	cpudata->suspended = false;
> -
> -	return 0;
> +	return amd_pstate_cppc_enable(policy);
>  }
>  
>  static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
> @@ -1692,11 +1592,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	int ret;
> -
> -	/* avoid suspending when EPP is not enabled */
> -	if (cppc_state != AMD_PSTATE_ACTIVE)
> -		return 0;
>  
>  	/* invalidate to ensure it's rewritten during resume */
>  	cpudata->cppc_req_cached = 0;
> @@ -1704,11 +1599,6 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>  	/* set this flag to avoid setting core offline*/
>  	cpudata->suspended = true;
>  
> -	/* disable CPPC in lowlevel firmware */
> -	ret = amd_pstate_cppc_enable(false);
> -	if (ret)
> -		pr_err("failed to suspend, return %d\n", ret);
> -
>  	return 0;
>  }
>  
> @@ -1717,8 +1607,12 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	if (cpudata->suspended) {
> +		int ret;
> +
>  		/* enable amd pstate from suspend state*/
> -		amd_pstate_epp_reenable(policy);
> +		ret = amd_pstate_epp_update_limit(policy);
> +		if (ret)
> +			return ret;
>  
>  		cpudata->suspended = false;
>  	}
> @@ -1733,8 +1627,6 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.fast_switch    = amd_pstate_fast_switch,
>  	.init		= amd_pstate_cpu_init,
>  	.exit		= amd_pstate_cpu_exit,
> -	.suspend	= amd_pstate_cpu_suspend,
> -	.resume		= amd_pstate_cpu_resume,
>  	.set_boost	= amd_pstate_set_boost,
>  	.update_limits	= amd_pstate_update_limits,
>  	.name		= "amd-pstate",
> @@ -1901,7 +1793,6 @@ static int __init amd_pstate_init(void)
>  
>  global_attr_free:
>  	cpufreq_unregister_driver(current_pstate_driver);
> -	amd_pstate_cppc_enable(false);
>  	return ret;
>  }
>  device_initcall(amd_pstate_init);
> -- 
> 2.43.0
> 

