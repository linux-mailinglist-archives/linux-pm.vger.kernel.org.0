Return-Path: <linux-pm+bounces-23727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A17A58B8F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 06:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B6E188CE0E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 05:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340F61C54A2;
	Mon, 10 Mar 2025 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="voRibqHb"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380B1BD4E4;
	Mon, 10 Mar 2025 05:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741583349; cv=fail; b=o5XF4/ltk4HfRMBNI9kIpNsza43P4s8f0gUY98PiRZFjqFaNl/+jpY/VAw8rII2SlUZImiTYSTOU+5VLhDlLlGGhoIiT7BmtCz7jlhfAR0hVsRVQRdgGONENB6FRvJxkSnwxsWt22G/2h6n2BuXrihHPwVqCeyOi0xMMCfPfLWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741583349; c=relaxed/simple;
	bh=GhDItKdCXXUZ2gZtV817ERRk0wqumez6sWDxVKu02O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SWzu/5h5Yo2IY91rRn/66uh4O3CmXRKLy3oWmeZ+Y8mGyiWpuFFscmxGSOZOPWFIvJiekc8JpOozjQvJ+8pLPGPT3XCbp6EfcIRJ3ZIKl9oK3zQl3I2Ooef2hkFjwcbroBW0PmZN0b0EN6Jw9hRJE7vVhJDIvp6viOGQx1BKXiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=voRibqHb reason="signature verification failed"; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yuju2+/mzCFdTu4fYIOTqKcbi57g6Zy7Lxvy7ReDlFga38NXVc+MJIR7C0Krz2v+gFZ1CjDUoTV6uO0GT/oJW06XcBceaqrBcj5mG/R71+NoEuSLIC+D9kXZ9YeGtE5AbKbKQ7s9NO8CHQL85KKNSglKs/eBaxswejGyCbQ64F+f0Hk0M6RDzE0mhL2LziMQT49UbAZ1Q+pP1+WUo+cC2+tuJ7FVGb23UJlSOS38RIyf2brTiOGgIwPVWVWo8W7NhyVCXvI7KZXxMj7MUN4N5hRWlr94VWEL3Rqihbm1mvTn04fmzLdObnJ4cAV1ZxRrcFpgw9t1IAOg7pwvJSrRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sjFhHucqz7ZJ1R9p6zZMLRVcbYCEqdguEuoPqCJYys=;
 b=RlEQZCYVRQyifQY7EGYwy+G+cm+ZfV7j+buREyf7c/2IdZ2mLXedIAV3HJ/CtLb4XsGnDJpXGrYS+nronF7P8W97jn3IBgNqDFSvVPh21EY+PJWvryEI0siStboiy0CAMNb0VCtEfRAWkpkgeVXeH893iEAtOytZM5cXKfLcCrDZH9SI8oOhmCa9yaCWSI9JU9Q0s78i0G1elA8qleI4jWmOFG5xWHuT33M4xf/zcoJlB0lAdnImMcDlPjwUQvlQcfVszN1HkPzW2Hk+HPZgEhyOzkFiXnwOKKBDpYNUSjHgRXfG37z+OpZTd8e1GOjg/LnaFcA1vRT5AO3o29IXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sjFhHucqz7ZJ1R9p6zZMLRVcbYCEqdguEuoPqCJYys=;
 b=voRibqHbi74vfSsCt/u8R+JXkEGPsSl12Pkzj4buRBMDND2r9vBPbud4xDX+vzTSkVTZpPPYN1UV0Y2iJ7cpjVxir2PP02GRQNerJXNJHEBdoVRtxkzx02BQOQCHJpHf22ctDCNJ2Qy7sDER5OcWWAKHd371OsrvYCmPE15qLug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.26; Mon, 10 Mar 2025 05:09:05 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 05:09:05 +0000
Date: Mon, 10 Mar 2025 10:39:04 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] cpufreq/amd-pstate: Add support for platform
 profile class
Message-ID: <Z85z8MN8ncr2ye4r@BLRRASHENOY1.amd.com>
References: <20250304152327.1561017-1-superm1@kernel.org>
 <20250304152327.1561017-4-superm1@kernel.org>
 <Z8sdREywSKVb4xx7@BLRRASHENOY1.amd.com>
 <969ca809-c630-46e3-9bc2-6cf340bc66e3@kernel.org>
 <f3849033-e883-4296-abb7-eb04e8c2a03c@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3849033-e883-4296-abb7-eb04e8c2a03c@amd.com>
X-ClientProxiedBy: SG2PR06CA0182.apcprd06.prod.outlook.com (2603:1096:4:1::14)
 To DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 0062785a-d383-453a-aa26-08dd5f91ade3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?f8FlT68qN7PlyypGsEn6okaci3m0LmpBRO4f68dsCC8icSgDIo/yD0DZMD?=
 =?iso-8859-1?Q?e2///+vPd0Kf7Mjg2UhzCVRN3LYy8VkTUsBELxoAWuZOIluwX5/dexi59X?=
 =?iso-8859-1?Q?VZ6T5riugss2QGCCjNnPg4rE2B0UEkt4b9I19feeGvgALM3Yf9gkRjonuG?=
 =?iso-8859-1?Q?mVCxGJlS+g04XyeXwnNh2YQ29M+kg4JG315UNZPvyEz0UE5dWbRHVWwhFh?=
 =?iso-8859-1?Q?LZK7gM6h5dw8WfkN3o8DmZlrXdqYfgnfZ6ovYpcILc3uHPxmIQ/RcaTogc?=
 =?iso-8859-1?Q?O8Nalpxabyz8L1gcQ6/GALOO6QIjBFiv3U6IQQYxGXqvWJOAOssNo4oMGr?=
 =?iso-8859-1?Q?2g6ptDkFC2OjuYImRvlrVjCYVkMBCxdDeyQMpM0/2Q3BD8LJ6aEzoqlcsz?=
 =?iso-8859-1?Q?gW5XJihcRo4JLYfGYOQKHM4t/WSUPlLo3w8UKzYRzG3wfo658/a2cwWQzB?=
 =?iso-8859-1?Q?XlHlG7UCQlfDY7ZX9ZJaTtdtEO8wCG4LuIq7nKq8R3v6/nC++ccBX+cA9E?=
 =?iso-8859-1?Q?qTdRuEGrO5c/HNqix3jigxJxpaP/nBJjch75rsn8RV3EbDe1QI87nsVOHe?=
 =?iso-8859-1?Q?NKjDmNIPT0YX5E0LYPYP5mehD0hcPpmDlHkbIHluA8lfjjqDWBat/LSR+K?=
 =?iso-8859-1?Q?h3bZxSIldYGHOSVpfMRNMcgRLjl5Ff5IBRpSsNL+E17/2kwRmEOQ8nr12u?=
 =?iso-8859-1?Q?LWCfsfcD9gXZdJK/LzLC3GAQBkIIekRYb9YI4cWwB3DnjDZ+sDsMYvPz/o?=
 =?iso-8859-1?Q?clWFGqgCwQqwQJplma/46FB+yga4g1qXDcEq2NXP6v3+XHY2bYDK1B4PfJ?=
 =?iso-8859-1?Q?ATkW6honq9quAajcgg0VosKO593O0zf6EQl8XrdAL7pET61uQYt2v5yimz?=
 =?iso-8859-1?Q?yLCse6mftyfYR+Cm/mxaXDydqH/YK0QBZ0/AA3St7ZKM12cUST4bTurbqY?=
 =?iso-8859-1?Q?4ZclbcJOMlWCnUfV3rUliqtnUwHcpcqaDhfxFH9Xs4DwQefDFOfHYhii6k?=
 =?iso-8859-1?Q?3pL5kFi7930+ga3coZf3X7b+joqSXzd6p1hzQKG4TqKrbFyMMz/4A2Dant?=
 =?iso-8859-1?Q?g5ijU37b7EhFxJXZQRXwwBhaz/SxXgNpr3/d5YIgfN5D4u+ml+3ic9GX6g?=
 =?iso-8859-1?Q?UBBnOzxnAc1QJME4rUKvuMRjdrbfvKIMFc/pNCxrqiw5t4q7JVGuQhq2xA?=
 =?iso-8859-1?Q?NlmcOHV5BwMU4zapkMChsGiX0Dv4Sw4Y/feZ0FLYDL6wxL9cYr997VzqwJ?=
 =?iso-8859-1?Q?M35MgoHvCpubAIXxuGgByNRTxoOF2VvU7WWIApkdyaTEQ8GEU/Y/yZx+41?=
 =?iso-8859-1?Q?aqt8xFt3OZuUWn2pzFQ/2SJ2G7Cd4fNIJy5Y6pv3AWRoJiB0QTV5LJgOWo?=
 =?iso-8859-1?Q?SSzoISRrUESNahN5J5437YouUNFCavWjts2RGZjLLCuIh57/9m49Gd/2vy?=
 =?iso-8859-1?Q?iFqzFbozu42CtyCb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?E72+yJdIqOYf7gL9gM1aov1DdfXbSSdnNFTANHEU3x78cIAkJPhLJjQf4f?=
 =?iso-8859-1?Q?S0YE3Iu3fzUTPLiOZOjwFgyerveF7gwM2ectUAoFpGi2Z05SuI1UUcCpI0?=
 =?iso-8859-1?Q?C2Xz6FvECYmBww00E3S4iS2gK8UdGwNNLCru68HdTp48qQHAj/Td4+hTUv?=
 =?iso-8859-1?Q?YKZdzEWA1SFh2pilmfcZw+0/09ljIBFJB1AgygMyAuX8a2Z448kCF1pH/S?=
 =?iso-8859-1?Q?cQFuhe0yAikNGL18wbn3COMlDCoO5blE3bb+Db+/uKbi9uOvlf8q0I/dfy?=
 =?iso-8859-1?Q?EJStqvrsPcnKdFEDy4A71ZjOLnqnpNHI6lCWyGWtDMB41vpmLTJKhVeFql?=
 =?iso-8859-1?Q?mTfGD9Bh2w28s0NFIaQQTzYyFE2xVxgBDKW0l77aJDAwjOOoWu+ys5cAyT?=
 =?iso-8859-1?Q?KlEGs8wgbLvsjDGjncbfWYHJvneY9njvNVM9mW/qso4G+R6YDmfwtMD/ql?=
 =?iso-8859-1?Q?e7yQ5SqfePVoZzZ4QZQiTvIIjDHNHQyTWKD55lTE3HO1q/4fpwFp8G2K9/?=
 =?iso-8859-1?Q?FQAb86ElTDXMdfUV5DLUt1g3zryhZ3gXCTWCsH1PnJu8K/oHMvsezc+JIi?=
 =?iso-8859-1?Q?N23UcvZKCW/5GD/dVK80wrcgxDWzUwK1lR6W7zG68tKyJ0G4lcLsMXODql?=
 =?iso-8859-1?Q?0eMTonOi03i3PsP8BDlSKq/xeJP5en1S13pH+3wVjSt4C4CWpDMwjjMPz/?=
 =?iso-8859-1?Q?dRUeg3Ve52sNS/UtKHgR4dh8eEC40VGo+XqOL5+4Cs1qicIkrqUN73cJra?=
 =?iso-8859-1?Q?6gWSd8QSNuy1OoWAGUZwTbCjX9q2yYFEO1aidJoOQOW9rR4oJW5evoOvoi?=
 =?iso-8859-1?Q?K9O2pRE7NRykicfJsf+T0M6FRzUL45Aky6r0EuqtKd0fKS68b0X1pM4dqu?=
 =?iso-8859-1?Q?gonQL2omLWfgzRC/OqrMAYotSoNSQ4AhUypFFmf31devXYGgxadnRQiRdt?=
 =?iso-8859-1?Q?KT9jvmkwSIzG/R7tK8XaHD1SZyySjcaCXY+DJaljt90oeEeK7kayjDAp9q?=
 =?iso-8859-1?Q?2xES9UfolT5fL7LXEP53BYZA/t36gii02X5z1fnLytPfSSEHZy4aL8NRlq?=
 =?iso-8859-1?Q?lYFueZs2hvteMloi6mW7WulueRj43PfkXTuz8NdtdET57SWAf21aZF2hDE?=
 =?iso-8859-1?Q?PdFAW4FxpaeN4XNt7mphJdBSef4FFBL13JYWdAM8adnNbnlE6iRD4Wvdzz?=
 =?iso-8859-1?Q?3v/nszM56yN53jrRtUdHUll1FgrDDpbm5w4p1rs2IRtuHaB9KZoXVqn2kO?=
 =?iso-8859-1?Q?ryRvGfRVpkptbQl8OOVKEfEFYu6dRGmtCbuQVqwh5BbIfgGZAw7Z8Tby/K?=
 =?iso-8859-1?Q?4DY51Li8mibwoqFxBsk/D7W4S5njE00RwQbs76xhUc6/0wGskE/PxkLnpA?=
 =?iso-8859-1?Q?tPlVaq99yMXKcAHFcpsfmgRYj5nN1wtVstgvFJQSkUmRQ7cJf4qQG7l+Ab?=
 =?iso-8859-1?Q?cd3OICX9icY1RoJXhrs72B91950xd9B8vAEZvVg9G13ZsRvAYhnPpxzaQH?=
 =?iso-8859-1?Q?Q7pu+Iqqv3/L/S0qgqg88xc43FILDL2cYJAKzv28GyIAlcZchYj5KZcSyR?=
 =?iso-8859-1?Q?ZCezCd536ueOlEv3xhL017gz/Ud93sOQnkXqdC/dnWNMYvDgS3F7rvSvYw?=
 =?iso-8859-1?Q?0YRWx37fcU1NGwlGZpysvw31067Qtjjjdv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0062785a-d383-453a-aa26-08dd5f91ade3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 05:09:05.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEEiGqWLQheESUQpR16zxsLNuSLK7yid+TJ9x7QFw75DbFhQNIrFGsLeHZEclEpBIk8pd3sOpnaKXM7PDL+0SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995

[...snip...]

On Fri, Mar 07, 2025 at 10:30:25PM -0600, Mario Limonciello wrote:
> On 3/7/2025 10:55, Mario Limonciello wrote:
> > On 3/7/2025 10:22, Gautham R. Shenoy wrote:
> > > > +static int amd_pstate_profile_set(struct device *dev,
> > > > +                  enum platform_profile_option profile)
> > > > +{
> > > > +    struct amd_cpudata *cpudata = dev_get_drvdata(dev);
> > > > +    struct cpufreq_policy *policy __free(put_cpufreq_policy) =
> > > > cpufreq_cpu_get(cpudata->cpu);
> > > > +    int ret;
> > > > +
> > > > +    switch (profile) {
> > > > +    case PLATFORM_PROFILE_LOW_POWER:
> > > > +        if (cpudata->policy != CPUFREQ_POLICY_POWERSAVE)
> > > > +            cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
> > > 
> > > So prior to the patch, cpudata->policy is supposed to mirror
> > > policy->policy.  With this patch, this assumption is no longer
> > > true. So it is possible for the user to again override the choice of
> > > EPP set via platform profile by changing the cpufreq governor ?
> > > 
> > > Is this the expected behaviour?
> > > 
> > > The bigger concern is, if the governor was previously "performance"
> > > and then the platform profile requested "low power", "cat
> > > /sys/devices/system/cpu/cpuX/cpufreq/scaling_governor" would still
> > > show "performance", which is inconsistent with the behaviour.
> > > 
> > > 
> > 
> > This ties back to the previous patches for dynamic EPP.  My expectation
> > was that when dynamic EPP is enabled that users can't manually set the
> > EPP anymore (it will return -EBUSY) and likewise turning on dynamic EPP
> > should keep the governor as powersave.
> > 
> > I'll double check all those are properly enforced; but that's at least
> > the intent.
> 
> FWIW - I double checked and confirmed that this is working as intended.
> * I couldn't change from powersave to performance when dynamic_epp was
> enabled (-EBUSY)
> * I couldn't change energy_performance_preference when dynamic_epp was
> enabled (-EBUSY)

Thanks for double checking this. 


> 
> > 
> > IMO this "should" all work because turning on Dynamic EPP sysfs file
> > forces the driver to go through a state transition that it will tear
> > everything down and back up.  The policy will come back up in
> > "powersave" even if it was previously in "performance" when the dynamic
> > EPP sysfs file was turned on.
> > 
> > Longer term; I also envision the scheduler influencing EPP values when
> > dynamic_epp is turned on.  The "platform profile" would be an "input" to
> > that decision making process (maybe giving a weighting?), not the only
> > lever.

Yes, the scheduler influencing the EPP values is something that I have
been wanting to explore as well. My idea was to use the nature of the
task + the load on the rq to determine the EPP value.

> > 
> > I haven't given any serious look at how to do this with the scheduler, I
> > wanted to lay the foundation first being dynamic EPP and raw EPP.
> >
> > So even if dynamic_epp isn't interesting "right now" for server because
> > the focus is around behavior for AC/DC, don't write it off just yet.
>

Fair enough.


-- 
Thanks and Regards
gautham.


