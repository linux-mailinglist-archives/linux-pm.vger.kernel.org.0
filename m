Return-Path: <linux-pm+bounces-12702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D6695AD1D
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 08:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C849F283117
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 06:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7728676048;
	Thu, 22 Aug 2024 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3F9ng9KV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC472AF0D;
	Thu, 22 Aug 2024 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724306414; cv=fail; b=IHpQ0CSO/fFgDlo+c+xyxAcXzjywFMEHonfkcYh8SIcvZecLa+hbMeJlrhd6kz+sMvQ3v+hM15Tzs8jpmSwBbBMVuLDboWY5PFyqQzx66WATn9cPBkom29oO60bUEUWePqnr67qQ14WqH9PDxOoWLDaO0OWJdgcVRJiOWvx57DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724306414; c=relaxed/simple;
	bh=oqTZj6maqKn5xjv10wgyCFiQUYN2O5FxFOqW1lkhZEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bwP9C7gO/pLtVOPXE6FbhfZ9I9Ph7xqqHk9zEE99hI8d/pEk5nhYEU3kHzgBDjn2jpenCdZLZ6BfjeQdjr4Yj1jIRYOT+QNvk351VfsNzP4o73OWjPEpqNS3sskhH4Dm+EpYEpzbFOiu7bl9YEr6fnF5zwgo/39hl4pDyTKrohI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3F9ng9KV; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1nW5VwC4aOH1OGmwRLQHtl2hjtL8xrUrAxyV+awmL2N4Xd0YjA7X5ISq5TVBK6OOn4UNats2kssP4GzbiWRZ0okxmGnydQ6nTpoVeTSBpu0ECj3W+wCuyGnP5qVLpzB9mcx1lDW9axy5EPtMLncfiPsYTmHMeCX1fqz3SH3/ReNigVy9DKalqcAbgcVSn/Oo5vDTxrPjgqikawb97F2jaYDTbF/0jX7g1DDEVYlk2sBONyEYHdsNrGzHVHumkVnj1T62mAlD/C8BIMETQ6AKmcmYBS0FiRttpWjV6EBziCJ5nnuRzfKmBpvKYbWllc33aP+naNHjV+8ySxp50jcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeG+qAheeN9+xzHy5uuVSraasXs8ETkL6s6jKteTQV4=;
 b=s+rvsw1wX1fSW2CBIXQSfVpkK6aI5rkv77jSaehlMqnWu36ux2OIAHPXPfR183du0NVactT4S41HOsurvByb0cp5sQWYJXQfDnDQsoU7exoVHWBh5F60Do4BZhLQV2FQJ0NS5pJdeE95yVJ8UlndIfpBhfKcLgJM8xIJovCL2EnahNKj/UkpTd0vXQVN9R5sTRTpYa/Mm2+6UOd52+EGK2aL35J+WqHmVLxjUA8Gu02AqHZD6jSlCLwY8jx7eNlLDwQhAHsUzQ7jPfYWQsfBewLcI9mHz+RBoYXg0GjDItg7Bwg6uMGIoiEP69tYZ/LNWLaD0NlPljmBMiP2Rlz2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeG+qAheeN9+xzHy5uuVSraasXs8ETkL6s6jKteTQV4=;
 b=3F9ng9KVhUvRNaJ9zHjFRC+IcwGoMhkqQSpIz17Jz1OOv+RHI1yuUzkkip72k8YFNK6oChiYH/o7A16Kl38leZ01cpXctRpmoJe18/7BHq3J3NPdkQZiAnOabZO5xrnVxuf73TL1WY0rUAMgkun2i0j2aunoDk4r8Jqay35MgnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 06:00:09 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 06:00:09 +0000
Date: Thu, 22 Aug 2024 11:29:57 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: David Wang <00107082@163.com>
Cc: "Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Huang, Ray" <Ray.Huang@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Yuan, Perry" <Perry.Yuan@amd.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUkVTRU5U?= =?utf-8?Q?=5D_cpufreq?=
 =?utf-8?Q?=3A?= amd-pstate: add quirk for Ryzen 3000 series processor
Message-ID: <ZsbT3WIkz5kTpfXx@BLRRASHENOY1.amd.com>
References: <20240809060905.777146-1-perry.yuan@amd.com>
 <37587d44.95af.191373f195c.Coremail.00107082@163.com>
 <b9899fcf-2774-b270-900a-72c7e1f10dfa@amd.com>
 <DM4PR12MB5136B5BA5DEE9BE7A27F44B9F18F2@DM4PR12MB5136.namprd12.prod.outlook.com>
 <38b23ce.4a8c.191789c4356.Coremail.00107082@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b23ce.4a8c.191789c4356.Coremail.00107082@163.com>
X-ClientProxiedBy: PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::10) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4aa1d9-8f4f-40f5-4fa3-08dcc26fadde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jtjW0YBt2OEqtgSANWYipEcGrUxPDRexYM873K4accgY5YKo1NJaFaVZGnxB?=
 =?us-ascii?Q?X+w8FnlJIEIwnwcnBRVmqFo4xBlRn0eH5qfTbbp/0KYl07sQKVue0wSd0Zx3?=
 =?us-ascii?Q?gj5hS3DOziJgq4lhnrRK/PINHaBLEWTg4jFdsK394gB4W3h28yy5RMXghZS9?=
 =?us-ascii?Q?x/QyO8PI5+LwJ0QM9THriA8ljgjDkW3nii/v/iS4E0B0arpGwW8jm4PrBVeO?=
 =?us-ascii?Q?A5byh2MsSUWF9Qk3AuAAsZhA7YJXL0iNjiWr0VdJV5dEQpBZcAQpxm9U9iBW?=
 =?us-ascii?Q?O/3JJ6HPT11tCub+oCThQ42VTdN2DQu7vdwwfWvVpC826TT31vRJ42BcqnB0?=
 =?us-ascii?Q?WRwJXWtG3NV4AVO9R5G53jmYOvjiWNM7kTA8zRE4f2B+8KlfgHoJ9N4VPd7q?=
 =?us-ascii?Q?ipGirrvrNth3mq/TG6wRYDw/oGHEUt93jzTwzX1oX2Uy0DOv9f1WDFbhNafV?=
 =?us-ascii?Q?EHkGF6qKO6iLKHlISN5HsCK9No+7nuo0GQ9fKsUt3e283mXKG/c3oxki88ua?=
 =?us-ascii?Q?AmYuN3rzFERjRyJ+hkWSi50eyYI+TrVdtjBNUWsjiNLrIb8jCUM7GpTAFLBW?=
 =?us-ascii?Q?GEZFn07NS9sOxXoNvRezFZTkbbEmvwnmELh4jgwN1mdoHjQcQuocu2QtcR6e?=
 =?us-ascii?Q?q7QOTVVR0kJvxWzh6mkR/XWjH0oF9VuKXH7+wVSqMl0VU1eZiNosdgdre/zX?=
 =?us-ascii?Q?aVdF50YDmQI+mpYOg50rQ3CQpIvvOYs7JbFIoWOXL3mJqq/PIDG3W8bsEBJz?=
 =?us-ascii?Q?M+dm+cDsNGS9cYVtTp1zhCF2apr0PSXANwwxJRP/3eC/VAJ+uwKBkurrNu6G?=
 =?us-ascii?Q?vP9527NNQFaBVAexWsN7mWQh1ZrKBxk3KHHB4YO05VPYfFJJGineADFFRHgo?=
 =?us-ascii?Q?QfN0TrXA4ijdTIaPLkrPvcQcHaMgp75ENei8YvGFeXoXODZueZlXjpAIUyiI?=
 =?us-ascii?Q?odppAanm3gryuvAHJykyQK6v+4ZZ5DuILmlIKqu4OUtgKzTR3Yx7YEuXegNj?=
 =?us-ascii?Q?PzN3h3BYrJ7n6zcltYo9SgYqUDi0urzcSllmnHKfsr/lhDrTwuZs3Sj/Oft3?=
 =?us-ascii?Q?SWGsKvNJzl1KwzvYiCcVJt5yNLU2ztlTaGPEtTJyLzYMbxVmqiOTcf2K5BHN?=
 =?us-ascii?Q?KYXrvcSFDuC6NwKrDu7vHtUwLVOaRhoEyY/WZsVJzxh4HyS89t/h+Q7kr0iH?=
 =?us-ascii?Q?9r1pr7amigf/QOif3X/Ctek5uEbcGRHVqFqlw9FGFCVAggFETmsh7kFgmcZu?=
 =?us-ascii?Q?pJb9qwe55QddoCQZgsD1V3XueqGymYXKrRS1XiIbQW/PekU3Czv+lGm2awx9?=
 =?us-ascii?Q?KvzVFwe0u5558JpGVszcqhlrNbpWLPHOOZpv9HdbRHVzPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W0q5dGgv18LnmNZwONYG9nb/sZUkVNY34Er9TQnNBw4S9jKXdp7VjfOHFQ74?=
 =?us-ascii?Q?CWjzDDkLs89ob2nuqsrWVYPzGSmVJA9E7/IJ1ohGgfStNgzHGKPST5DJxyNh?=
 =?us-ascii?Q?Ow5NOlJ8rh+N4gXEEP0aemL2C/k2RWhYyqjZ5+ChhcO8Nc3kzRycV9ejAT5t?=
 =?us-ascii?Q?sQ4hUlxFv9tmfi8y6572WTDE1RYM/vVW7WR728doBxjWy4dY9AWVzezFTeTi?=
 =?us-ascii?Q?0uUWJE1UL4RD0J3/gq9ILJidVR6fkdQBu0Y7bxxaUOcj7MhBv6R33bRYv9aU?=
 =?us-ascii?Q?yh8MKmxKfn+iWR6YNYiDHoD0BqNXXJucvUGAxxjkcN7RcKKOKMGKAdW49sky?=
 =?us-ascii?Q?vGNzfXXrb/NHtz4cPxcV/n685UCMG61u8Oq1wmuA12Ba5P7TkkNPoWiSLa4v?=
 =?us-ascii?Q?HPyZRUMdlbmL+/k4m5LXx1kK68kXh+DKSvBrElGol9GDoX+DONr7dit0wsce?=
 =?us-ascii?Q?Ut3wrm/cItNyeGV6pkhASuyxvbW0/D2MNq6xiubg8Lsq5uAMTGzlxoG5y1J7?=
 =?us-ascii?Q?Jyfk5ttsjPyJWNJmvXptRy3+th8nMYzQLruvGBYiPIBO4wxcH4hRTf83NfIH?=
 =?us-ascii?Q?WYXZK6khzTcN7H8xPCDIMcSedJfdlFuhbhpdR5k6jX3DOqDmYJ2qOIRv0Aou?=
 =?us-ascii?Q?RO51OI2iotGaxEG/hyXgLd+IAo6X9WbCswdXYE5zvxTFpVkFD9qXxsC2SU0s?=
 =?us-ascii?Q?LNU3XBupQHU9riCm1QaHIPj97tJSgDg1zzz+NmYvo4dikpKE495nvNfXLAmn?=
 =?us-ascii?Q?4jsRcE5ixOwj1BEu2jh8ZjByx6vggLnEbkvWzt1QxFqR7IFyPvAONEjHl20b?=
 =?us-ascii?Q?IMk2UmKo+jzM9hqb6KRNnSkrgNV17C2+6i5P+LWeMA5KZ1Cg8lt3PS3X2UGG?=
 =?us-ascii?Q?zzOkxhUcKIUs7bjlsUbn4aJN6vawvhIcA7RYFypa+U37O8DNcBkKkbBO1dm1?=
 =?us-ascii?Q?eQUw/uFKN/dbNiE/mvR5Mrk0NRBEg1JBSPoDML+SV/HqmcPQ0RbesR2b60nM?=
 =?us-ascii?Q?Z1nEll8RWa05XttjFHqdYbcUQuzDrqCbhmJfoNczrUjYTjg2SyCRsU8hEHFm?=
 =?us-ascii?Q?1XuKtTOdEtlnXRdzy0HJijsBwy0D+aCiT9J/sLiYxmKCu0I45dZ3t3H2QdWC?=
 =?us-ascii?Q?IJ5mvMDFJ+8OCcdN//czshgHXQU0E0XJti9iAE9a2dOMSkj6hLRQdA2MgGJk?=
 =?us-ascii?Q?ZFLUr/4mqyWk8+uhmP4s7Mx4KuWtjJiVhznDKqO+BnVOFAcIBO84AiIQs/8J?=
 =?us-ascii?Q?vRRT/mzApPsooWMQ4K6UOYRSyraygO6iJfU17R4ERcRD9dFHPq4h6+g0of6U?=
 =?us-ascii?Q?/6ioCD+HdejmqMlhuwXARvYmXFab78tw/b5dq7BQDHXN0o3/X32HGHzUgnAZ?=
 =?us-ascii?Q?Vtmckt1qWqN5Qr5AKnQYXr9FHuSnfa02dJsPfxCY/MuM3gVjWY8kN3gSz979?=
 =?us-ascii?Q?fkvcqW1QaOZQ8hEPpug8Yqc2i7Bp1Pbk9hUeqGH3cUTeOxdxpQ/4bdIVf7gn?=
 =?us-ascii?Q?+Vqig7Q6722VIJPXcF/pGyMps/EtXZ90SSp+ZixB2Wi/i6OVj/d/C3+kl1zu?=
 =?us-ascii?Q?fQNTiJniNHsj1Tg6KNSItX0r5KCrSLidIAPOQEAI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4aa1d9-8f4f-40f5-4fa3-08dcc26fadde
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 06:00:09.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nInfAEtLWMhgXYkar6Tek34lTWCRWzbeCArZz7MBPd7tknklj/t7ColG039X3sJIG9FTMI5muKK99zt2xbWLCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820

Hello David,

On Thu, Aug 22, 2024 at 01:43:12PM +0800, David Wang wrote:
> Hi, 
> >
> Thanks for the information.   (I did change my BIOS's CPPC config from "auto" to "enable", but error message still.)
> But according to   another mail from gautham.shenoy@amd.com,  my understanding is that my CPU(AMD Ryzen 3 3100 4-Core Processor) does not have this CPPC feature,  would upgrade my BIOS really help?
> ```

To clarify,

There are two ways in which the OS can communicate its CPPC
requirements with the platform firmware.

1. Via the following CPPC MSRs

#define MSR_AMD_CPPC_CAP1		0xc00102b0
#define MSR_AMD_CPPC_ENABLE		0xc00102b1
#define MSR_AMD_CPPC_CAP2		0xc00102b2
#define MSR_AMD_CPPC_REQ		0xc00102b3
#define MSR_AMD_CPPC_STATUS		0xc00102b4

2. Via the shared memory mechanism.


The presence of the CPPC MSRs is indicated via X86_FEATURE_CPPC (CPUID
0x80000008.EBX[27]). If available, the amd-pstate driver prefers that
over the shared-memory mechanism.

So the the following warning are intended only for platforms that are
known to have the MSR support, not for the platforms which don't have
the MSR support.

"The CPPC feature is supported but currently disabled by the BIOS.
Please enable it if your BIOS has the CPPC option"

Your platform has CPPC feature (evident from the fact that amd-pstate
worked for you with the BIOS quirk patch), and the amd-pstate driver can
work just as well using the shared-memory mechanism (2 above) as long
as your BIOS supports CPPC v3 (which advertises the nominal frequency
in addition to the nominal perf).

The current version of the BIOS that you are running doesn't seem to
support CPPC v3, which is why the amd-pstate driver won't work
out-of-box. This is why Xiaojian recommended upgrading the BIOS to the
latest version.


> 
> Anyway, I will give BIOS upgrading  a try.

Please do!

> 
> >If this issue is fixed in BIOS, no need to modify the upstream kernel code, right?
> 
> I think , even when upgrading BIOS would not help, the quirk just for my system is not worth be in kernel :)......
>

Fair point. However, in case you prefer to use amd-pstate, know that
this is one way of enabling it, if the BIOS upgrade doesn't help.

> 
> Thanks
> David

--
Thanks and Regards
gautham.

