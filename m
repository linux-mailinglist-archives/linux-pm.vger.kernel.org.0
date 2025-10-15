Return-Path: <linux-pm+bounces-36163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B79BDD800
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 10:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43C974FD455
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 08:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F22231690E;
	Wed, 15 Oct 2025 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DRFAuAcy"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E3B3168FC;
	Wed, 15 Oct 2025 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518016; cv=fail; b=YBXWKunQAf1PWAg4N8ZkamX8hOUtNoRxukvFbOMzGAAqm+/SqQT0NwE7IwsWi2JBa2YYFsNq0xy5mTeXmDAq7IONqPCP5/wHtZTbxGKrLiel+uiTE6tR5IWmWtOQIjSfNAaqz6FBVG+QGemAUkGy2RGDbRboCwF5RBJojGObtDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518016; c=relaxed/simple;
	bh=U1g5R2ziXVjRMjGPTmtDQfGE17cgHyLtXniqGzolXNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HtjdfD4TCKnaFyvkNfsxpv4J3zCNotmtc5tnYeRWxQAf/suLDIg9fFpEd/JbS1c2uW29GE3aqF9AMtmmyVqGB36/h+7J0t67OpQCWnqAAoJv0RBTrFSQn1zkPb8PF+zLD6OiezAkOiLzOA+CyIe9UNpLfPCJmKehQL+XkDKJId0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DRFAuAcy; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMDgxi5aSxQAlHMzwrBlRZCuFZEeEWMFbHojOhtxCDlW3r0kUIcLDIL76JA43dehKBuDtR7rBYJWJ7Xt09HkaPXrsH/MKweSMD1IX5RM7R4UMeK4Tph6WGm6ki48AEI9Frw0KVNBUkDDgcwwK9T7ssQzD8AzcVMg8ytrIsVfUo1KtplZUCXplsWzz06F2ddLi5Q6FyncSNxX03P05MU1YKxSA1ukii0ULTTbgtv5v2EUt8BfZyg+PmapSdK0MzFQowdr7JtkSVbuzW8GXm2DVobB59eZ+thCUntujXPGPANt5b8LFYr8mC2vVAvA5Wa9We4M35xRN41KR95ed+WqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+pXenZ7t8WhV2YtxvZ04gtSg9SSAWSa8sEkuqRJbdY=;
 b=fEruJKP5VCR9rIGQEYyyrf6l+xirqvtCxxVMqYS1MjJdclxKYvmiHWbuAaO8jVKcS/2KffjnLWRFM9Fb2m54DbyMKzEIvdyX38xzdu9AYhC9ogiXT4WUGNY0MH6XfcIlGIkWWFAdAs13aTsdBWQ55INU+CJXVmvqpICAojp2LZyf1ynH6ZsK9F6XVymFqVlOIq3TrpcQLzWDpUKp4SSb6HEeTgkCxdkCq25t3VS3owxG0P/x5jKPgN0K2VML8cucuOZWgNY42hvXen1jCwGcJkU27h+AbX2wLnomYswU6qFWVkDo3rgpz2VK3LWAC4wJwny4sGl1Aug6UBRH8Oty4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+pXenZ7t8WhV2YtxvZ04gtSg9SSAWSa8sEkuqRJbdY=;
 b=DRFAuAcy0JI/K1jaxaNcqhWa0n5Z1UOOklWLJ7DJgLw9B/obFUg4tdoqX54jSsWHJywMd6OVehp8EgkW+32P9/BDKNIqPvSjIqdylZUFU4QuqSzqXwG/ETPmPI+/03F5gTJiz7w0yHAhTs3Vj4uLnReVbvn1W50r37UHCZdNe9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 08:46:51 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 08:46:51 +0000
Date: Wed, 15 Oct 2025 14:16:41 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] cpufreq/amd-pstate: Use sysfs_match_string() for
 epp
Message-ID: <aO9fcenyZ5SgReMK@BLRRASHENOY1.amd.com>
References: <20251009161756.2728199-1-superm1@kernel.org>
 <20251009161756.2728199-2-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009161756.2728199-2-superm1@kernel.org>
X-ClientProxiedBy: PN4PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::11) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d590668-c953-4763-d1d4-08de0bc7622d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bOFhMwMTQJZVLUc0uVD4uJfJ0UeugWiJB7oCrNSst4kbrczJwuQ0dAspxGPS?=
 =?us-ascii?Q?M9QONadKyRKZNj5digJ9+4IthIGNWZVrWPC1++xU7r8LpWM9xm+iibiG4jt9?=
 =?us-ascii?Q?SadH41UkabIiOLpsorheWkFw225TB9oFdxsqzrWa97FfoTSAgUrMMd6MWMlW?=
 =?us-ascii?Q?iCfdkfP3xtL7kHOJcozmEwAY/YEYhR3NJ/j9Z4RdB75MIJyODA3rQQ5Xdmof?=
 =?us-ascii?Q?qSH4kfk7zq+suAj8dO9d0KnRdOzHdnhb2wd0EE7Y+9F8Jvq6twoVyRa09/6G?=
 =?us-ascii?Q?nkIIFDf7CkyaZR4h7f1twGhBHGGNeGtysx/PNz8G0+ecrj2LKi30noOzY7s4?=
 =?us-ascii?Q?4D6l9NhltmKUxb8Qp+uuRPPcicTysoGlmFIhrojca333lDQTLKCjqULvSQm0?=
 =?us-ascii?Q?BRtDeiAeITXQkV03iZdmORZOnbj72Yvb5SGBkHJf4FwepK+XGtGmefzbs3hE?=
 =?us-ascii?Q?9z0icvxQpVLac2FSc06HCSCyKk9/my7II1jLySZFQFPBOqR0RwYEOTr4nf6w?=
 =?us-ascii?Q?h/o97CeCsy8t2Dlyj7N9LPdF/z/AChPEcKNNTNNKmOza+QBtNWlDlXgczp6a?=
 =?us-ascii?Q?5d7/bBLBY/FFk3deAIJPONQjIZMdNr4htbPsJATUV5zvmEjovR5cwaRwyiGo?=
 =?us-ascii?Q?ZLM1WylTYkdl504zzmKyo/+dhFEUWUTbslmbK9HLTj4YIY16d8loA0upSMq0?=
 =?us-ascii?Q?JlKkzLvqBLTHm6L7hlZ0jJXJ3LbjVd5VhBKVe54LL3Fhp6wBbz7j7KmKcE6d?=
 =?us-ascii?Q?4/pO+BgyRArtX1mjBbkOa3C13+y4B/YW8p0VpymKTlq2BfEg1hO4iwMd1eLh?=
 =?us-ascii?Q?OEKFm6lg4VUtiHol6DFtVQQzVKTiN1QjHbfoAlMchygn61n4il6sH3noVPlW?=
 =?us-ascii?Q?Eoh45+yjwvaGpe8ecKpzvYPUGRYkBRILrRxyiYjJC44ezclC8m2eOdoUdeah?=
 =?us-ascii?Q?RiEeOK7r+CExFmodVPf+RBRk8mp5NV0d9HFeIQNiJuLLn0w6i8T/aQsKCkHh?=
 =?us-ascii?Q?iShAEhY5UNL6ZP25CeQXh32p4FovDne6YRk2fYeSjv9q3dtqBNOXK46hCtUZ?=
 =?us-ascii?Q?KlFCzUcNARti94EfTGc1NtadqTO3oP7rLYQ7mlaty5kb0lckwJlEsECyzqpU?=
 =?us-ascii?Q?JeJaIbUeNHnhJsW6N5xLo6hg/8oV+tDwnm1dNfkEMS/iRiOkkiC74GH34m3e?=
 =?us-ascii?Q?hd1HX+Ff0F2IehXZ6cL7Pp3sek76tuvmQBtEiqnkZCYYQiyiqLX3F61yAwR5?=
 =?us-ascii?Q?bYzFewe2RYYYq0no3iCapW3B7X0OcOOxykIvy/94uM9oUwgcjM+biosf+qHc?=
 =?us-ascii?Q?JQlNtCbzk8iBe2w0QG8EXjRsht6UojwF6xx5wyeC4SgkX7H1dhNGUSeewHiX?=
 =?us-ascii?Q?QLnm7U8H6itwxqMGh8nkkeLJn0+bNgVmA+cnYAWidmublK7ZEDbU2Nsr8q5m?=
 =?us-ascii?Q?O7xz+qFPDfxemdDHtODHGk3WOo6FrGbP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jx0blDD78LjPl8oNIn1Ufn6dgcOnuFNOndNLDZPmNZdSsoA461A+PDe5ZGIk?=
 =?us-ascii?Q?ajuH6OZtTd8/evmbgqhpsF6iyHPFk6VWXTUj34w71H5acuhpMwI/zkNa4I5z?=
 =?us-ascii?Q?T+dg7Bl/Rdns4Sk8hgaWZSRq38DWrb8rLehYVqJ0Z6Paq5TuvvAgaK1c5IJn?=
 =?us-ascii?Q?RbcD9K0KGst09Q9vpt1g5/ywmBaILMmSQq0iDrHVxGwaeaFwbHEmLdetqSxa?=
 =?us-ascii?Q?IxP0R5g9yGIngkskY+qQtWq3GAhlpZrzAZzDQlKpPBZOubEXTWmCSYhhrUPK?=
 =?us-ascii?Q?j6tCO0MqCJx4nkvHFjqcJRfhP397iETJEBJXpz0zKiF5FwfVQWyvM8misjQN?=
 =?us-ascii?Q?SxpA0LD8vzYwoVc69GnVHRvQJfY1Hz+xXg9z6I7sftwR8qbDYga5drl1XRaj?=
 =?us-ascii?Q?aMKw5VY5gbmRo5eCFkiDtJ/Lt/t008UxWwO3Jivm9+m3JhcghqJlUTUKzZII?=
 =?us-ascii?Q?9aFS4UjTu6/YGAw65lbJtJCzLK01217g1wEqq0aDf2Sf/7kUXJx77Go+AqYk?=
 =?us-ascii?Q?Pd1CWUxevjt0O+b3Pq1kiHtmNYSJPWpBm+9YtpMOBG0TzSGjkXe7McqCULla?=
 =?us-ascii?Q?NwUoeFudvJyI2aFlYDEaQ19Y6BVGOBv42BSlHa14OLkfUxd2seXRafpn2Tyi?=
 =?us-ascii?Q?BXv3JYejrogl/BV+g5kwkBAt9qZrtgnoW8VXmbLQo+L+s+on3ZHqRcVt1HF2?=
 =?us-ascii?Q?3qeRxpSgCikJbZUpEigyZWPqGWJT7mH5e9upPYbf8UYX+0I++pYGJe8c+lLg?=
 =?us-ascii?Q?/wX4H6PthIuo5bT3LV14hbL2G895O5Ldz5EMk+ePdsTMFDWv2sTWbBFr6CK3?=
 =?us-ascii?Q?oy/swO7HZWjIDFeXHaF2wp8kdo9jgDJMkeaBmKvdpex1nR9byj2Vye95kYAt?=
 =?us-ascii?Q?DQ6xmwTjNyFFuHsEZAn2CZzxWv5Rqc830QQbrMb7Ko1d0HzYx8lenzWUVxCy?=
 =?us-ascii?Q?UgaETp2if5voj7QhLO282JuIF2hcfe+DsEix4SurXs9obpHWIznJV0yfPK08?=
 =?us-ascii?Q?ioTgoIOv3fh0l6LMy2a0rPrQuXdv4AtYeOBgI/AljtXD7JREn2yS3aNGwbdW?=
 =?us-ascii?Q?3bQP7QglUAB6+g7GJLRF9lPXT0uGIxzvwxOhgbvFiIeASEeKa91+LrqPLR7x?=
 =?us-ascii?Q?mwU2orRWmeBVh2IkViz/OUhxq1Ygdu9kNU0wMOGOzBnv/DOYOsU2nJZ6Bunk?=
 =?us-ascii?Q?zBFuquHGoVosPldjFQ4FYXPJG24y1eIYzferuGXab4gwzzN25g1cMTrB0ado?=
 =?us-ascii?Q?zuequuFu8kGK+WGSOuEZ5A8O43AO9hmyqNhz2fHjpT6dij/vK/Dj3lOqIsTT?=
 =?us-ascii?Q?cv+IwpZjwePfA0WkIkogCfLvxY5gnE7Dt8hs2a5IGGdN2IMT7+YHNbFQEXKk?=
 =?us-ascii?Q?AxXPhulq5E1Q5IhJzs6OaZsfNYLjLNpVjmCarEOAS+wzuef49EIrdyAlKfMk?=
 =?us-ascii?Q?Moqb3KD1aJdzDOmPE1trunn3/jZwbxY9VRmdhhE6Y6p2W/O1U1QUMpP//JHJ?=
 =?us-ascii?Q?NyksnAMycOJGbh/HNobriqWOYKaqzNGnvC9yG6GNfG2Ue1amUAbA/h0WVdIx?=
 =?us-ascii?Q?DMrJ1CifAl5kWp3FkpeZGhtC/W6LbOK0rb5wfCWB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d590668-c953-4763-d1d4-08de0bc7622d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 08:46:51.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0LT5XBU0t9gYMuCMSjF9ynr7pmlMSGfcpt03KeDb1V3UXXCcncAtb+Kr41i+EJKwKntRBqguK9WfQxG57oTSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

On Thu, Oct 09, 2025 at 11:17:51AM -0500, Mario Limonciello (AMD) wrote:
> Rather than scanning the buffer and manually matching the string
> use the sysfs macros.
> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

The patch looks good to me.
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
> v2:
>  * Drop NULL from energy_perf_strings too (Gautham)
> ---
>  drivers/cpufreq/amd-pstate.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b44f0f7a5ba1c..0bc5013448873 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -118,7 +118,6 @@ static const char * const energy_perf_strings[] = {
>  	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
>  	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
>  	[EPP_INDEX_POWERSAVE] = "power",
> -	NULL
>  };
>  
>  static unsigned int epp_values[] = {
> @@ -1137,16 +1136,15 @@ static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy,
>  static ssize_t show_energy_performance_available_preferences(
>  				struct cpufreq_policy *policy, char *buf)
>  {
> -	int i = 0;
> -	int offset = 0;
> +	int offset = 0, i;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>  		return sysfs_emit_at(buf, offset, "%s\n",
>  				energy_perf_strings[EPP_INDEX_PERFORMANCE]);
>  
> -	while (energy_perf_strings[i] != NULL)
> -		offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i++]);
> +	for (i = 0; i < ARRAY_SIZE(energy_perf_strings); i++)
> +		offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i]);
>  
>  	offset += sysfs_emit_at(buf, offset, "\n");
>  
> @@ -1157,15 +1155,10 @@ static ssize_t store_energy_performance_preference(
>  		struct cpufreq_policy *policy, const char *buf, size_t count)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	char str_preference[21];
>  	ssize_t ret;
>  	u8 epp;
>  
> -	ret = sscanf(buf, "%20s", str_preference);
> -	if (ret != 1)
> -		return -EINVAL;
> -
> -	ret = match_string(energy_perf_strings, -1, str_preference);
> +	ret = sysfs_match_string(energy_perf_strings, buf);
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -- 
> 2.43.0
> 

-- 
Thanks and Regards
gautham.

