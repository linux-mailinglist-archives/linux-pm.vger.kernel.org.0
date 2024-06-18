Return-Path: <linux-pm+bounces-9514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C370E90DE75
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 23:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4CD282A8E
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 21:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B091741F0;
	Tue, 18 Jun 2024 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lx0kPKIF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD1E13AA44;
	Tue, 18 Jun 2024 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746394; cv=fail; b=jaUOIGUn7tVdwoCn/8pceNdV9/DMRAeKBzail/il/ihQ4WlIIp1uZcPXF0gDCsnoEySN4ygYguFq9EsVr01quz8Hvb7rWl4VSHbQTM1nMC4i1/v6MEELf2cUI3dZ3kvsTTspxDZpQiLaIP4wx1tZtqZu4ElMNpp0l9ouzJ/aik0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746394; c=relaxed/simple;
	bh=emPvSzuLMmIJt/+ev4zYeboUIcJ7PLtHTOKM2KSOG/s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ULjM6ibMv6XbU7Of9McVA5LZWNofwjbbLpd+g9tiAGL9gV5gE4fzg0zQkfAhxkjKUYc1iaZIqSqXgtWlCGC7nH6tmpPN31Jz5G7QfO44R0+hHeJ7KRxGG6ra17zxYqcQZYFc2XX/IaJbHiHu43f0oxJuVHY7dO87HGB5Z1NTcO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lx0kPKIF; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5We5zQU3FfBAcXFGM6jYkHNOswdrcPAOoOXi+LbaCZIjJCrV+FdIsL9e+jm9VurQ/bzOtsIySSRbTZfch0nu6CANZqXa+WaPdys0BQEitPodUEXbzm5f+LVq3Te3ysGwKRBb3j0aJdOaZTbhkxQ1BfCrl4CwRq/A4FZY2fI6m68UhATIjE/prUx/IJJ0uLV3Ulka7ulnnr21yurw5l880u8AnApoY+9W5HzRalOSeOgMSZhRld/R108thrYz7gansb/EVn4HvON8Ah2lK8S6cc3rpWkwbe5mY8JCMCqrWDmQB0Tdj/mG6zSLoA2iWXC8WABdnZ42y++hifzBWA+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvAOr9e5RKUOQ64n/mwh6Vln4ZMKdp0a/aMRYGwyeWg=;
 b=Rd9NLMSFl7CR+RT//JwlyifOVXXqqyjcdXxftfVgrYYJN6qLwXq2RNUY1AV/SZ3/vwgPbPufKTU2LCZiR1GCb4BEM9rf5KJTDmJIkQiurOlFlwOyaGafjh8MjkfTUJIdnNMyQdja05ZHc7iI+x5lW/QHqCpA9MPot4cF+lShVNwegRGs+t3lj53fbPCCRUqx38xIHPqzXX6+bPIogviK6EDSHwozzrwOiI3zaLFQWlcIqVdTy3cqao+E84xYV9cmWofRakrCmzjXbvxFPMOV1RWRS4/A0L2oe1DF/wrlp1WmHCza22Z7yLk03xfoXdWRDzCufZFod8jrd6NQfUURPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvAOr9e5RKUOQ64n/mwh6Vln4ZMKdp0a/aMRYGwyeWg=;
 b=Lx0kPKIFAi+K2ozs2TuVGMtuLcPfkm/2JIcLb2wxsGR/WEySwuHMBCvtFhyQv9dEWIQkPDUxPpxqKcufJpEQ3c2YnBBQ50mGCJNuucSy3dGcfr/qEp1gKsA0cEJWMbcYrBrDDlIoWiFtnnduDPB8tVqreUXRJL76j1104DTl2EE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Tue, 18 Jun
 2024 21:33:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 21:33:10 +0000
Message-ID: <9ad335f7-bfda-42f2-8ba2-830684c01c0d@amd.com>
Date: Tue, 18 Jun 2024 16:33:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PATCH 1/9] x86/cpu/topology: Add x86_cpu_type to struct
 cpuinfo_topology
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: daniel.sneddon@linux.intel.com, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Perry Yuan <Perry.Yuan@amd.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-1-b88998c01e76@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240617-add-cpu-type-v1-1-b88998c01e76@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0131.namprd11.prod.outlook.com
 (2603:10b6:806:131::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: e50867b4-c0c5-4db7-9a6a-08dc8fde3fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVZxaTNvYjRVcTM1MEdUTnpoQnZTQ3NkcVRkcU9xZHlSM3VFYWErSnFod1JY?=
 =?utf-8?B?djNmaDRXdjNJOUJ5TzRSOHkzRHFkL09aSzZjZVRGQ0RtWk9MMmRXQmlVWEkx?=
 =?utf-8?B?OHJkQ01jK1BmR2FjeG9XSHhCcTRFZis5UmN1U1o3WUc0Ykc1TkUyb2gyekRv?=
 =?utf-8?B?UlJ0TmJzUThuVnZMR3FvRE0rZ2xFMEVBNTV2ZlJXbEszT3pkVkhCckluQ0ZR?=
 =?utf-8?B?dGRhMGFvMHZ6RXZJT1E0bnFWc2VMS0lRTy9uZHJTbjhIQWF4MEJHNGczZEFz?=
 =?utf-8?B?OFVFNTZaV2dxcmpuM0xFT0Y5eGtMY1pSb1RDOVpGQ2d4Ukl3VEs3WUFmWXYr?=
 =?utf-8?B?SzhBOTRmblRET2NJcmVWUEJDdm1BdXltZFpsVmFKeVpreGZlOEthSXlSd2Nn?=
 =?utf-8?B?YjhQM2hqZEtVNHI0UkRJc1Q2c0YwOGJ5SVl5M1A1L3l3RU5CVjh4TXJGdUZx?=
 =?utf-8?B?bDFLLzhBbTA2aTZyb3JOV3N1UDBWN2FYU3dQNHRJL2c0enRkMTBWNStSRS9M?=
 =?utf-8?B?Q0tEVkdwU055UU4zeWZQN1l1UFNpWGhZTGM5UkoxYlFJVWE0QUNQaUpCUXNs?=
 =?utf-8?B?MHBmRnhuTENiTjVva2ljVXhKSW5pNnlpV21hT0RPYnU5S2lyaCs2S2NIOGZU?=
 =?utf-8?B?S3Y4eTdzM0xWMUp0V3FKbVJJQWNudlkwZC9KV3JVSFR5ajVMWlE3RHQxYjlM?=
 =?utf-8?B?VkdXb3pXTmZlS2hDUXhqT1owT3JWQkxpWXY0ZmNoWTEycXozR0k4ZjkzbDZT?=
 =?utf-8?B?RnBMM0JWWFdkaDVhM0hnaE1sVlFES1RqK1VVQUJGd1hZcmlrblRWc3BiOHp6?=
 =?utf-8?B?M1RtYWovcnZQQ21oYjNIdnMza0xYSFBXWlFudmVWUWRITmNGclp1aWJGeXlj?=
 =?utf-8?B?RGZYVk5vSHRXRHpNK0tMTkFkeUpWaFBwTDdsR3JsSVp6SXJWY2dnSUcvNEhi?=
 =?utf-8?B?MWx6MVZ2bWozQ05IZUcvY1BrZUliU2VRQkRxOVAzR0xsKzFzYnFLOTJRemZT?=
 =?utf-8?B?aThGU1RqclJuRlh5V240WUZiS05oWFZXQmlFT0dUeXc4VDNMWnVzSk5UdlBr?=
 =?utf-8?B?L3M1QnNPT1ZiV1VqZ1VxbmtHVHRXVVBUcjBNbnNsM2FiQkpqWndMakQxTGMy?=
 =?utf-8?B?T0xCLzNId1lwT2p2cUlWUXdzYUM3VkZaQ2xCNS9xbFFiWGxZTW52UmpuYWYw?=
 =?utf-8?B?VjJPVkJ2cmlVdng4aUJvT0JPdWREN09uYTV1bi9nSzBQblVLNVVJVi9TN0lk?=
 =?utf-8?B?SHlia3lmVTJ5VU1DZDFFQmpmcWkySGJkNEc0SUliNisveFFLWTlNTkMwaE0z?=
 =?utf-8?B?dmlJZHlPdmhrbHRnWWJ2K094c0lNMGF0Qk5LenlYOG5nUDZzVDRmcDhQeG1k?=
 =?utf-8?B?RjgvejF3WXBjam1hV1h1YzFSRTRPU1pkbmhRVVVISjQxVFdsMEdDZUVXUGtV?=
 =?utf-8?B?QkZqZHNURnd4Uy9hVkR2Mm9PQmxZR2M0eW5HM0JvaUNXUlVBTGRVU01LdVBZ?=
 =?utf-8?B?VXVoV1c4L2RXVUp0VmpQaEVyU08wV2VBemd1Z3hRcW1OcHZ4ZStpdjBuR2NK?=
 =?utf-8?B?Wmt2MEo2Tm0wVVRyZW5OM1FLdVdialpTYzJaNGtvZnlWaGp1V3lkdHEwR09K?=
 =?utf-8?B?YnJFaXVFYzd3bjhycjNvNGhBYmV2K05oSFdGNCtoY1RXSWZobHNQcFZ1cy9h?=
 =?utf-8?Q?eZWsglAVaxRlWXyvC9Cv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFdGNWhYYmJzczRHZlBCM3p0ZHFIaUEvZjFodmh6S3Y2NGxYRDRtT0tzajk1?=
 =?utf-8?B?eXJrNE1aV21CV1cxRGcwWDlxUHdhcVQyUjZvS0p0UmlYL0p1K2J4ZllYdCtG?=
 =?utf-8?B?N1VUWEQwYnNXRjlVSFE2YnJWQ2cyS3V3b3JkN1hFRC9JWGhzZjYrN0ZCdWt0?=
 =?utf-8?B?aDh6WHBjRytiakd4dXdiZnZUZUFyK0F0UFN6R1F6R2lBWk1VWHFoNnJxK2dL?=
 =?utf-8?B?S1ZZRWJNZlZ4bzNVdTZCWDR3UGdkVzg3c2N6L1Q2cmZuMFhiTkhLcVNGbzJU?=
 =?utf-8?B?VUh6M3J5QjZwNGtNYkJiYUhBT3MvcEhBWS9UYk83cEVlUkVJZXp6TCtrU0dL?=
 =?utf-8?B?L0VVL3JmTXNJRnAvdVFLdTMzVkFXQ2luWVovdFhZaXg4RkJnNGtmM21nN21T?=
 =?utf-8?B?ekV0RGs3TkpKV0NhZytFUmxuRjhaTzBFQjEvZFV2aXlGdWlQOHJEWFdRR1pa?=
 =?utf-8?B?ckt1dDdFTGVUUjJUdUpNNEVVRVNMV2xTQ2lJTDNQWWttbTJZS0VIVDVwSVZk?=
 =?utf-8?B?RndEQlZDNlIvT0FZWkE4ZTh4anVIWEdnY2dtcHJ4K3BWQ3JIYTdFNmtyRWhh?=
 =?utf-8?B?ZWR1STljSnRudlQ4N3FRWkIxaVFqZlZSS3lzUGRZN29lQlNJRHVSMzhucmFJ?=
 =?utf-8?B?NGYvWExvUWdDN0EyUzdvaVdNNW9NU3NKQ3RKK2lVSG0xZTJlKytCclZ6ZzR4?=
 =?utf-8?B?WHNyQm1pUE5McWNaZmI4NFNXNmFLRzZoM0ZEWjdLaTdFcFBqWGxVeVlQODk0?=
 =?utf-8?B?M2FUdm41dTRCWlZmMU1XVlRhaDJzSDBHREVPc2wvYy82S3NxdVVwUVR1Zzdj?=
 =?utf-8?B?Sjc0eEFGZjNqazF1WHFSVFBoZUp5RUsxVEpJOWhsWk9vd1hQOFRVcy9DS0xi?=
 =?utf-8?B?SFNkWngrYXR2cGdrRnFNQlVmSEcrLzhIU0c0d2hLQWtOR1dzZVVyWE0vWVVL?=
 =?utf-8?B?OS96dGRhU1NSZGg2eTduTWJtaC80c0FYSGJzL1ZDQVptUkxzWHhWb1NSR2N6?=
 =?utf-8?B?Q0Mzd0FFOEw1c201ck5vUW9lVnU5QnBoVEttZEFUVDVNOE5FcncwV3QzWGxj?=
 =?utf-8?B?T3pWeURWYmgvRXAzNUNKakZ3K3p0aXpPUWNrNVY2eWRFZllaeDhSdEd4dllV?=
 =?utf-8?B?bFgvZ1drMFpaMVlxcm5Wa1NDQnJ1ME4ybDFwY0ltRDl0NXBmbHVEUlg2WHlT?=
 =?utf-8?B?a095SGU3YVo3QUxzOVVScnFtRnJ2Ymt2K1lJNFE3bmtQMmlPc3ZCbmw5V2V1?=
 =?utf-8?B?ZUZXcjBYc3RzUFF3TUVUZDA1aG15R0dyeEYxNC9YdzV0L3BZSHVBN0t3aHk4?=
 =?utf-8?B?bFM3cEk0UURtTVFBTWNXZklqL2NYbzRremVMZTZLRWVUcWdTQ0VqTkdpSjhs?=
 =?utf-8?B?OUErd285QXIrYWtOZmJDbmhSbStRYklLUndvbW55TzVSZmM3OUlvME5pM09V?=
 =?utf-8?B?Z0lFUlYwR1VrdmJDVDlIZUhiSGRQQ3FpY1ZDT0JSemszVitpNVViVEVwZk8r?=
 =?utf-8?B?LzZZRlZKajVKWjJwUUVYTk9RQXYxZ3FPSFE5T3lrb3I5OXZBeW85cENJb1Zj?=
 =?utf-8?B?RE9MOXdKNDJYWnJKaGhhY29aWTVtYWJYL05ZeVc1TGJKTlJVeGQzdmF5T1Rm?=
 =?utf-8?B?T3EzclQ3OTlQZjhPc204YW5aTkJNdjZoWnlUenRsY3BER2puWFhZUFE3aExy?=
 =?utf-8?B?bDV4dllBOEtJdmVkbngvOXRXeUl0dGdJSXREcXJ6bzJsb3IzM1l3bFA0WGUw?=
 =?utf-8?B?ZkM5YUJXQkNFYjBQQitzTWl0WWJnem40dG5ZV0NVMkpMU3JPNU5TanczbEds?=
 =?utf-8?B?MyticzFEbVZrRndSdlRMTEdiR2hJTHo4WDJ3MC9UNUsrbkdzRFN4SHMvU2kz?=
 =?utf-8?B?cWszTHhXdklxWDZqR3c4L1lQdTl6UHBXa2JtTDBmVWVteExYaVRzTVU3TjJt?=
 =?utf-8?B?STh6VFhOWXZscVhQSmEvRTdJOVpKMFh1RUw0eU8zQjgyUml0d0dGcjZBd25t?=
 =?utf-8?B?UlFucitNRTV0VlZzT1d3bGxNZDNKOFFsMjZDRzUvQ0ViM0hzQ1BPOExaU0Ev?=
 =?utf-8?B?ZlVzQ3ViUXVWMi9EcTJZOEgxRGJGcEo5NTNrNk5qLzl1ZXhCcjFnUjJvcTBC?=
 =?utf-8?Q?MxPrWa7AnAY6J7tibtrb1ifVH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50867b4-c0c5-4db7-9a6a-08dc8fde3fdb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:33:09.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gORm7GT2CpzGdMTiGvfZRf9MSyvnGOVgseMX12ITWLZEV1q27FL1xz3kbTsThbW5rp8hmE6qAIisIE/e9j+VPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

On 6/17/2024 04:11, Pawan Gupta wrote:
> Sometimes it is required to identify the type of a core for taking specific
> actions e.g. intel_pstate driver uses the core type to determine CPU
> scaling. Also, some CPU vulnerabilities only affect a specific CPU type
> e.g. RFDS only affects Intel Atom. For hybrid systems that have variants
> P+E, P-only(Core) and E-only(Atom), it gets challenging to identify which
> variant is vulnerable to a specific vulnerability, as these variants share
> the same family, model and stepping.
> 
> Such processors do have CPUID fields that uniquely identify them. Like,
> P+E, P-only and E-only enumerates CPUID.1A.CORE_TYPE, while P+E
> additionally enumerates CPUID.7.HYBRID. Linux does not currently use this
> field.
> 
> Add a new field cpu_type to struct cpuinfo_topology which can be used to
> match a CPU based on its type.
> 
> The cpu_type is populated in the below debugfs file:
> 
>    # cat /sys/kernel/debug/x86/topo/cpus/N
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>   arch/x86/include/asm/processor.h      | 3 +++
>   arch/x86/include/asm/topology.h       | 9 +++++++++
>   arch/x86/kernel/cpu/debugfs.c         | 1 +
>   arch/x86/kernel/cpu/topology_common.c | 9 +++++++++
>   4 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index cb4f6c513c48..f310a7fb4e00 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -95,6 +95,9 @@ struct cpuinfo_topology {
>   	// Core ID relative to the package
>   	u32			core_id;
>   
> +	// CPU-type e.g. performance, efficiency etc.
> +	u8			cpu_type;
> +
>   	// Logical ID mappings
>   	u32			logical_pkg_id;
>   	u32			logical_die_id;
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index abe3a8f22cbd..b28ad9422afb 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -41,6 +41,14 @@
>   /* Mappings between logical cpu number and node number */
>   DECLARE_EARLY_PER_CPU(int, x86_cpu_to_node_map);
>   
> +#define X86_CPU_TYPE_INTEL_SHIFT	24
> +
> +enum x86_topo_cpu_type {
> +	X86_CPU_TYPE_UNKNOWN		= 0,
> +	X86_CPU_TYPE_INTEL_ATOM		= 0x20,
> +	X86_CPU_TYPE_INTEL_CORE		= 0x40,
> +};
> +

There is another patch series [1] in flight right now that is trying to 
get CPU types for AMD hetero designs as well.

I think the way you're doing it is a bit better though.

What do you think about having a common enum rather with words that are 
marketing strings?  We could have a monotonically increasing enum then 
too instead of a random bit mask.

Something like:

enum x86_topo_cpu_type {
	X86_CPU_TYPE_UNKNOWN		= 0,
	X86_CPU_TYPE_PERFORMANCE	= 1,
	X86_CPU_TYPE_EFFICIENCY		= 2,
};

Then as additional core types are added for any vendor those can be 
added here with a description of what they are.

The logic for topo_set_cpu_type() below can map out any bit mask and 
shift from a lookup path into this standard enum then.

If you do it this way we can lump the AMD hetero look up stuff into 
topo_set_cpu_type() as another case.

[1] 
https://lore.kernel.org/linux-pm/cover.1718606975.git.perry.yuan@amd.com/T/#mc65457f33331bba0d7d4fef1907d2fef14fc3fd8

>   #ifdef CONFIG_DEBUG_PER_CPU_MAPS
>   /*
>    * override generic percpu implementation of cpu_to_node
> @@ -139,6 +147,7 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
>   #define topology_logical_die_id(cpu)		(cpu_data(cpu).topo.logical_die_id)
>   #define topology_die_id(cpu)			(cpu_data(cpu).topo.die_id)
>   #define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
> +#define topology_cpu_type(cpu)			(cpu_data(cpu).topo.cpu_type)
>   #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
>   
>   #define topology_amd_node_id(cpu)		(cpu_data(cpu).topo.amd_node_id)
> diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
> index 3baf3e435834..b1c9bafe6c39 100644
> --- a/arch/x86/kernel/cpu/debugfs.c
> +++ b/arch/x86/kernel/cpu/debugfs.c
> @@ -22,6 +22,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
>   	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
>   	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
>   	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
> +	seq_printf(m, "cpu_type:            %x\n", c->topo.cpu_type);
>   	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
>   	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
>   	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
> diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
> index 9a6069e7133c..be82c8769bb2 100644
> --- a/arch/x86/kernel/cpu/topology_common.c
> +++ b/arch/x86/kernel/cpu/topology_common.c
> @@ -140,6 +140,14 @@ static void parse_topology(struct topo_scan *tscan, bool early)
>   	}
>   }
>   
> +static void topo_set_cpu_type(struct cpuinfo_x86 *c)
> +{
> +	c->topo.cpu_type = X86_CPU_TYPE_UNKNOWN;
> +
> +	if (c->x86_vendor == X86_VENDOR_INTEL && cpuid_eax(0) >= 0x1a)
> +		c->topo.cpu_type = cpuid_eax(0x1a) >> X86_CPU_TYPE_INTEL_SHIFT;
> +}
> +
>   static void topo_set_ids(struct topo_scan *tscan, bool early)
>   {
>   	struct cpuinfo_x86 *c = tscan->c;
> @@ -190,6 +198,7 @@ void cpu_parse_topology(struct cpuinfo_x86 *c)
>   	}
>   
>   	topo_set_ids(&tscan, false);
> +	topo_set_cpu_type(c);
>   }
>   
>   void __init cpu_init_topology(struct cpuinfo_x86 *c)
> 


