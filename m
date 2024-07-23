Return-Path: <linux-pm+bounces-11318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72E59398CE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 06:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F2A1F227F9
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 04:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E837113BAFE;
	Tue, 23 Jul 2024 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UBnvhS+z"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667413B5A6;
	Tue, 23 Jul 2024 04:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721707993; cv=fail; b=K71m3xr4fxX+lwmC0zZ0U93/ri7psHtYQwr7+VQKX97BWPN7KBrAyzNCcLXgtYIaSdk1KhR4wx1t/IoNOKJ00LP6on+51xrIgU7hQ7fHzDAFEDu5T5PYFmohbGEWCVFfhQUspO+lsST3qimPimNM000H/rkHmzEqAxSmNVtylLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721707993; c=relaxed/simple;
	bh=n2H4veoKUuTsRM2h1uU0jER3iDQKR6oozHkuK0ROT58=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cJExfYMrQDh15R5WTLMRN7DDg4rtYTSV8Uy+F3WbF0zDv1o5P5zkVD6iIuFPfZSwOJqPSsvarOtg2qef4acRxpACWIzSZILWDyI3bbz+VPx4XBlLvqXOJKkxTjTnp5VgKMGHxLY8FfRrsQJArNfRjzD6aYJoE74J1gdYi3e83Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UBnvhS+z; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDwS4MLJZZIb/5dlBxmUVsjJ/UNS3ZdpxkYtEExgTcn0+9yB61767Dq13dtiByYZepIj5ZChj8itbxBiIjMh30Fgbte1Y48V7bIAhvJqYbdpjaGOBbExDF2ciLWhCsGb0qvNVlN774OlUMQygl4RLHKCqQUFK1P8mSFv2hk0NoIExQdHrH7+NH1o68NMGruEcJ5XH4I1XrnjVbcbJ03Fh7+l9Jr0kd23eoVMKjW8HV3X/56bKAEh+cftPkPQDua2jRmaXXoWh6N1xUblMRARAPr3Iz2NRhVjUG6REnTFoMJdNKRVOJl98gAWEwqsUYd+aw/ZDqMtIcPgFhHycxx4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbntrsCU/seTGc7KDyDXW9mpllYQ6HGEHJhBb5UqIGA=;
 b=I7CVOFRNeNTb3lUCLhc7msqnoomVuzzc+PBgQ7lo3QSoxW29xeFxGWD7IIsyl/E5mh/qMQGpUbObmHvWaCU2MOX9UyUroIkHkcM7SDtak9av0BrBR00B1MG/ZCDO6aif8Mp0SwMZYXbdHIbvfuOBj5lTv7OBl3BN2nKWug2/Zxcs3OB6+E9MYkB+Sd0j2BIUL1+GlQ46uTUmIoI6yBsMJcG6OVXstflaekLhKuRHTe4wrgjUSDSngz6Y+0Oo4UfRW86KEx1dKa06v9vSEQEXMBgsv3+e6iSPSNh1gdj6slgC0eNtdsZjI5YWVs9DDeuz0GdJTiCovhMrGjSOj0o+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbntrsCU/seTGc7KDyDXW9mpllYQ6HGEHJhBb5UqIGA=;
 b=UBnvhS+zYhXc7YPQ3Hq1mJVmP5U8EkyOT8CkiAUJW7g8tJo4102bL7Y4QEsfvCmTNAhaRJDFCMVj/Um6zwjnUEZwahSVY/xBiBEULF0cf0lsrGJPi84d7z/LyzVPxm1GqtdDkCaMc0P8OOG62Me0JJRkt+S5ur9PNo+YoyE/Dl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Tue, 23 Jul
 2024 04:13:07 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 04:13:06 +0000
Message-ID: <121f1f5e-9ba4-4793-b743-e36201bd881f@amd.com>
Date: Tue, 23 Jul 2024 09:42:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] powercap/intel_rapl: Fix the energy-pkg event for AMD
 CPUs
To: "Zhang, Rui" <rui.zhang@intel.com>, "acme@kernel.org" <acme@kernel.org>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
 "irogers@google.com" <irogers@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
Cc: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Larabel, Michael" <michael@michaellarabel.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "ananth.narayan@amd.com" <ananth.narayan@amd.com>
References: <20240719092545.50441-1-Dhananjay.Ugwekar@amd.com>
 <20240719092545.50441-3-Dhananjay.Ugwekar@amd.com>
 <2a81f438306b82620bb4db9065d2cbf3e4c2d56c.camel@intel.com>
 <9c492669-d97b-4040-bdcf-e7f5a5ac7e09@amd.com>
 <77ea13bb319d6408ff262b10ed744c2e80c5fe24.camel@intel.com>
 <32281529-316c-4927-8344-945df1af56d7@amd.com>
 <675268cbee83af84fcb093f69541452b0bc9cb29.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <675268cbee83af84fcb093f69541452b0bc9cb29.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aea7cd4-68a5-4fc9-cac5-08dcaacdc0f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QW9Rdmo5VVdWTm9IbFFnblRoY3BmVk9BZWNtMlMxdlRDL1F4WDFNSVdHUm5k?=
 =?utf-8?B?ZlYrelhESG9PYU9KYTJSUklQdHprUkJZSXR1UVZ6RGE2KzFKYmw5TWZNb1o3?=
 =?utf-8?B?QjlSSHVvSm8rMW5DVU5wYm1IelpXcXQ5UDZmeXlRY3dkSGlTR2x3SVNZZXhi?=
 =?utf-8?B?WGJCWHdKQ0IweldhODRtL0htZks1cVVqcWRmWVdVWU45OU91Y2owaWx3N2RG?=
 =?utf-8?B?dmJtd3paQ3A2Sm5jQklpdjJJUnBsQXpYOW5DcmQ5dnhqQTQxY3M5enVaU3Zx?=
 =?utf-8?B?Q0tIY0tpTndKNUlKVU5saW5MT1hqeDZNSFhRVGNJYTFrdDJEYkI4R1RuejhW?=
 =?utf-8?B?R0NFa2lzQzVkYzJYZFNhWWVQZFJlM0NaL0VJMUtoL0s4c0FkOHlCUmt0QjdK?=
 =?utf-8?B?OE1sSlhEdThoMGkydVZROERlQ2VnRnEwUUozcDZzM3pkL0NBVjRtTWo3Zk13?=
 =?utf-8?B?VHY1NTVoUzFlZHVOa0pWaGViNU5HOFhjVzBUOEpWRmxGdWtGWXFkYWNOSDdM?=
 =?utf-8?B?WkcwV0k4U0JjdUh2cTZuS05HNTlUdi9GdWpjS2pRUWVJaEFLTHloeFZDbkE0?=
 =?utf-8?B?RzQrUllIQVpiK2ZxTy9kUTBKU3BsMVhsR3lvY2ZpOTJCeHREZDRDcmdFemJy?=
 =?utf-8?B?RzVvMnFtVEhOZEg3eUxHSGZVWjdhb3BnQjhVaUwrUTJ2ODlaQ3FoOVNGVGRj?=
 =?utf-8?B?bWQwUGl1VmhIcDl1eHhrU2J5U3lJS3dBWHBpNHhvOEc2ZUQ1d3NhT2RmM1Na?=
 =?utf-8?B?eDNtS0puR2dqekU3bFZ5dEhBTlB0eEdtMzluNzMyRUs4WU5LeVp3OXgwUnUv?=
 =?utf-8?B?UHZnWERBNnhPUmI3SnhtZnd2TlRWRytnWFdFd3NhMk5MY3MreThYUGpkejJi?=
 =?utf-8?B?aHV0SjZLU2s1UkVvSDVuM3MrZ3Bqbm92OXkwQjhSRFFJcVpWV2xwU3YzSXY0?=
 =?utf-8?B?NEQ1aGlaNnN5b2o0cThnQllxaEhCTlYxT2VJZURvTHZSdDUxTFdBeHZKQjdi?=
 =?utf-8?B?a3ozdzl3cmRiUDRqMVV5Z1hGTUw5ZTU3THlXdWRRSWRuaURVZjIvNmxMV2VB?=
 =?utf-8?B?ZlVMUlRaRFRia3lkV1FOanM4VjhjZm5nUzI4RllROGtFWUtTUk4wUzErZDlM?=
 =?utf-8?B?ZUFqTWdsSTlBenA0d1JxQzZyTFFGV3ZMSDA4SkQwbmFUMUhIMEVSUVM1Z3E5?=
 =?utf-8?B?ZFhyUitXcXZpcG83SE54MUJqUnM2K3hVU0lvYTJrdjE2eFlCSVZwREh2bUVF?=
 =?utf-8?B?Q3VUcndIRGxXY1NXc1lvZjRNYlFvckFMLzNESlc4bG9WTy9ROW9LQ1FWemRG?=
 =?utf-8?B?Z1E0NzJRMmdYNjhxWTIrUEkvZVJUY1ppWEdIT1BtOEMrZlBlMnFpcFNoYVhC?=
 =?utf-8?B?WXkyaUJIaGx2M043S2RBM3pKWG56a285Y0dFT0pCRlk5K0NteVRzalRuTTEv?=
 =?utf-8?B?K3JoVXlreDVOOWtoSWNlUnAxVkE2TE9DUzlRbXhTRFBTZXVwTnN6dWtVbTJL?=
 =?utf-8?B?ZDBNaDFrandxQjJsNS9LYkNESGxKUkptUzZJMGk4N3VlYXIvZnYvUSs0cjdL?=
 =?utf-8?B?VGdtYnFvVWJOUlltbWYxNlNnZEVNeFRWQVR4a3M0L1NjM0VEL04wc2lmbU5S?=
 =?utf-8?B?SmFkZ1VwdkhoY1REYU1ETi9UVCt4b1ZUTHkwd0NEWklpSU5mRm5peEpveTNx?=
 =?utf-8?B?WnFhcEovUVFUK0JreU5UWmgyeW5qRzdiVWF2ZVJNYTh1UElpWEhsOE9qUzdE?=
 =?utf-8?B?Z2xmTW9Xa0M3UUY4WVo3dS9xZVJvRkdhaU12QjJNRUlrSzdtSDVXc0J6K29R?=
 =?utf-8?B?Z3hLWTIzbEE0RkFvSm1ydDNLZlBQalBsZXFCbHVveU85dzJqQlhpdStEQ1V4?=
 =?utf-8?Q?Xu7pMj3w1mdR6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elJ6NytjSDRBcXFGa1Q3VHh3bkZNK3NYMkZQZ3RERjRCUGpFM2FKQUJxK1ZW?=
 =?utf-8?B?dGpxZzhWNkhITkdZUTNKWVV6Y1EwU0xVejBBVnZzaE11d1lOR1dtOUhKeVBa?=
 =?utf-8?B?cEgxemlTVnI5TUswWHhLRlpFMWpzTEFLM2h3UmRTaEtZK0JBZk1BR1duWTJv?=
 =?utf-8?B?anZxWEFPWkthL25zNCtBbmtFNG5CODVubU9kL1VnOWFUS3lIbFBONjZYVS9Y?=
 =?utf-8?B?SURaeHRma3JKQWhrSkpjOUNjOWFzM3ZVRjVwQ0R6ZWdLYjJNb1FHbGNscGJx?=
 =?utf-8?B?WkNzOHA2N2NRci9JRWpmWmU5dVVYMm4zYVBiaFhtK2taa01HUk5ueVpYSGNG?=
 =?utf-8?B?SGZQZlhzRFJrZnBaOSszVXYzdXVnVEM2eSsyY1lFMHhlMmNXazBsSjhENVFK?=
 =?utf-8?B?dmdOMjdScXRZOVVtNUU0cHczV3JMZE85dlZRdTNYVmRwa05ncXZBUldZYnE2?=
 =?utf-8?B?MTM2SUtRWFc4ZTZLcGtkVFFIbElyOUI3N0Z1c00rclpVdDl6TzRCL2Z3Y1lT?=
 =?utf-8?B?cm1XNytHcnVNS2svMzZSSTRVQ2RFTXdvYnRnaGNnb1MyTFQ3Wm1ROGhoUUph?=
 =?utf-8?B?SlVuUXB0RDBHUzlnK0JQMTJnUjZ3cng2eER2UzVlTDN5cmtjSmNTMWdPdS9S?=
 =?utf-8?B?aU1sem5CKzBRWDdrNzBoVGlFOHFhQVI2ZkNZVHFTMUxtWXRZWWlUQXNFSjRv?=
 =?utf-8?B?TmpqamI2WDhXS3c3em9GZkptdEwveW1NczAyK3lhZG95eXVoc20zWUkzUEZQ?=
 =?utf-8?B?SjFER1l1MitlcmtvVlo2T1VmMjh3b2RCUkVwQmEvbFdKZlpOQjBRVEhkRG1K?=
 =?utf-8?B?WGUyYllKUllLakJTaXhtVXJ3NjZLWlZGM3NOUUlnMWNuRkFzUmpJVnJJNU5a?=
 =?utf-8?B?cDFYVDZIUEd4LzFIUjdjMzZoR1RkWXpxckUrZW0yeGRaU3JLcFdnQWpnRkQ1?=
 =?utf-8?B?cW1ONUhVa0Z6TGszN0kzdGV2N29ZeS8wUEZvcWRmaTZ1eFVoQ3owKzdtUXI2?=
 =?utf-8?B?K0oya0Q4bzViTGhtQ1Zod21sUzlQZDVUMGRESmQzc3ZQNUZkblMrOXhqQ216?=
 =?utf-8?B?VmFLOFIwMjNWWnZqdy9WSXorYUhCKzNXM1RZSXFxWDdYc1BibTMrS2JWemMy?=
 =?utf-8?B?dW04aWlGWURCQnhsTE9PaWVHMS9yQUNrRFNMaWl2bkZqcE5RWHA0eklPZzU3?=
 =?utf-8?B?YnJ6cVlVbzUyb3RjVFdmK0NEeVNvaHh0U0N4TW43NlU5OGEvR0NobjNpS1Uz?=
 =?utf-8?B?ZnBXalBDeUJGOHBvMHFIQjVvV3J3Y2VhWmJ2N1dvVWJRT3Y4NDhUVkdLME5Y?=
 =?utf-8?B?dGhwT1h4WUpWa1dscER4UVJVMmVIK2tRVnBHYThHSjRYNWZYMVJlRVZhRTFE?=
 =?utf-8?B?byswRHREVmhhWlRPVUNTOFdNdmNLcldHT2FLbHZvaVEzcHNqclFFc0tzSzJP?=
 =?utf-8?B?N201Q0YyWVNIRlNVYVhtaWhLV2hxZks2OERPeTJRbUZNekVqc1JnY2MwZndr?=
 =?utf-8?B?OVJ6cVErMVk4N1IyTjBoRkdicjNrMnRLOS9IakdtVnhwMGJ4WkNYN09PWkR0?=
 =?utf-8?B?Wkg3RWROUU5QUDMwbmdPazEyRWkzWVJrUWswZytmNnh1YXQ4Q2YwNTZ1K08z?=
 =?utf-8?B?Z1lwdGJWWmhLZm9VM0pYTFNTYXNiczYvUTkzTytJVXR4S3I1SFhSeW5CQThY?=
 =?utf-8?B?UXU1WkF5NlZRZXkvVjBwK0lZVUtQbDZuVGJMcjZNTXl0cEtMQUNNWUJabDFF?=
 =?utf-8?B?VnJmaEF2NXRSQmRpa2k5QkFMbWRIb21UUkt2QjkwaUthZWo0WXlnN0RvdC9T?=
 =?utf-8?B?QnNSVmZycG44UDgvLzUrRCtlTGlqRUFSdkpabHRMelNCQXN3Vmlod3c0OWxS?=
 =?utf-8?B?UkcwZlpETUpwS0NlRmpobE4zb2x4SFRHSEN3RTZJakVhaVlLQXdpT21rNFR0?=
 =?utf-8?B?aUppM2kraTlIbW8yRFhQa0xFdTNoMmtNZ1hydDB6Q00wOUhxWFBWcml1YWxw?=
 =?utf-8?B?TEJrK0g2aGQ0c01OUmtKZ0NmbHV3cVE5V01raHFIam5FMzZubXJvbUo5TCt4?=
 =?utf-8?B?NjJyczJoTGNlb3k0VjlqcjFha2wrMW9qSXhqRjRIWjNiWUpIVEVLS1NtdTdw?=
 =?utf-8?Q?lqUauK2+2GxER+96bVkIx31pn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aea7cd4-68a5-4fc9-cac5-08dcaacdc0f1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 04:13:06.5199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: er1ey0jSK73zl1I6HflWKb2C6DgOky9+tUrkoZ/4BZcPBbcTkvD8c9aCyoFjaUfhcW+gpZ1H5WECLf1n9WGzvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979



On 7/22/2024 8:51 PM, Zhang, Rui wrote:
> On Mon, 2024-07-22 at 19:31 +0530, Dhananjay Ugwekar wrote:
>>
>>
>> On 7/22/2024 7:22 PM, Zhang, Rui wrote:
>>> On Mon, 2024-07-22 at 13:54 +0530, Dhananjay Ugwekar wrote:
>>>> Hi Rui,
>>>>
>>>> On 7/21/2024 7:47 PM, Zhang, Rui wrote:
>>>>> On Fri, 2024-07-19 at 09:25 +0000, Dhananjay Ugwekar wrote:
>>>>>> After commit ("x86/cpu/topology: Add support for the AMD
>>>>>> 0x80000026
>>>>>> leaf"),
>>>>>> on AMD processors that support extended CPUID leaf
>>>>>> 0x80000026,
>>>>>> the
>>>>>> topology_logical_die_id() macros, no longer returns package
>>>>>> id,
>>>>>> instead it
>>>>>> returns the CCD (Core Complex Die) id. This leads to the
>>>>>> energy-
>>>>>> pkg
>>>>>> event scope to be modified to CCD instead of package.
>>>>>>
>>>>>> For more historical context, please refer to commit
>>>>>> 32fb480e0a2c
>>>>>> ("powercap/intel_rapl: Support multi-die/package"), which
>>>>>> initially
>>>>>> changed
>>>>>> the RAPL scope from package to die for all systems, as Intel
>>>>>> systems
>>>>>> with Die enumeration have RAPL scope as die, and those
>>>>>> without
>>>>>> die
>>>>>> enumeration are not affected. So, all systems(Intel, AMD,
>>>>>> Hygon),
>>>>>> worked
>>>>>> correctly with topology_logical_die_id() until recently, but
>>>>>> this
>>>>>> changed
>>>>>> after the "0x80000026 leaf" commit mentioned above.
>>>>>>
>>>>>> Replacing topology_logical_die_id() with
>>>>>> topology_physical_package_id()
>>>>>> conditionally only for AMD and Hygon fixes the energy-pkg
>>>>>> event.
>>>>>>
>>>>>> On an AMD 2 socket 8 CCD Zen5 server:
>>>>>>
>>>>>> Before:
>>>>>>
>>>>>> linux$ ls /sys/class/powercap/
>>>>>> intel-rapl      intel-rapl:1:0  intel-rapl:3:0  intel-
>>>>>> rapl:5:0
>>>>>> intel-rapl:7:0  intel-rapl:9:0  intel-rapl:b:0  intel-
>>>>>> rapl:d:0
>>>>>> intel-rapl:f:0  intel-rapl:0    intel-rapl:2    intel-rapl:4
>>>>>> intel-rapl:6    intel-rapl:8    intel-rapl:a    intel-rapl:c
>>>>>> intel-rapl:e    intel-rapl:0:0  intel-rapl:2:0  intel-
>>>>>> rapl:4:0
>>>>>> intel-rapl:6:0  intel-rapl:8:0  intel-rapl:a:0  intel-
>>>>>> rapl:c:0
>>>>>> intel-rapl:e:0  intel-rapl:1    intel-rapl:3    intel-rapl:5
>>>>>> intel-rapl:7    intel-rapl:9    intel-rapl:b    intel-rapl:d
>>>>>> intel-rapl:f
>>>>>>
>>>>>> After:
>>>>>>
>>>>>> linux$ ls /sys/class/powercap/
>>>>>> intel-rapl  intel-rapl:0  intel-rapl:0:0  intel-rapl:1 
>>>>>> intel-
>>>>>> rapl:1:0
>>>>>>
>>>>>> Only one sysfs entry per-event per-package is created after
>>>>>> this
>>>>>> change.
>>>>>>
>>>>>> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the
>>>>>> AMD
>>>>>> 0x80000026 leaf")
>>>>>> Reported-by: Michael Larabel <michael@michaellarabel.com>
>>>>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>>>>
>>>>> For the future Intel multi-die system that I know, it still has
>>>>> package-scope RAPL, but this is done with TPMI RAPL interface.
>>>>>
>>>>> The TPMI RAPL driver invokes these APIs with "id == pkg_id" and
>>>>> "id_is_cpu == false", so no need to make
>>>>> rapl_pmu_is_pkg_scope()
>>>>> returns true for those Intel systems.
>>>>
>>>> This seems like an important point, would you be okay with it, if
>>>> I
>>>> include
>>>> this info in the commit log in v2 along with you rb tag?
>>>
>>> Yes.
>>>
>>> This reminds me that we can rephrase the comment for
>>> rapl_pmu_is_pkg_scope() a bit, something including below points,
>>> 1. AMD/HYGON platforms use per-PKG Package energy counter
>>> 2. For Intel platforms
>>>    2.1 CLX-AP platform has per-DIE Package energy counter
>>>    2.2 other platforms that uses MSR RAPL are single die systems so
>>> the
>>> Package energy counter are per-PKG/per-DIE
>>>    2.3 new platforms that use TPMI RAPL doesn't care about the
>>> scope
>>> because they are not MSR/CPU based.
>>>
>>> what do you think?
>>
>> Agreed, this gives a more clear picture of the all the RAPL scopes.
>>
>> We will need the above comment in the first patch as well, apart from
>> the 2.3 point.
> 
> Sounds good to me.
>>
>> Also, regarding perf/x86/rapl driver(patch 1), will you be sending a
>> patch
>> to conditionally set the rapl scope to die for CLK-AP platform(on top
>> of this fix),
>> or should I fix it in this patch 1 itself?
> 
> patch 1 is a fix patch.
> optimization for CLX-AP should be a separate patch and that is not
> urgent (the new logic is still correct for current existing Intel
> platforms), I will submit it later.

Makes sense

> 
> I think the fix patch is good enough as long as we have below
> information
> 1. CLX-AP is multi-die and its RAPL MSRs are die scope
> 2. other Intel platforms are single die systems so the scope can be
> considered as either pkg-scope or die-scope.
> This info will make the future optimization easier.

Yes, this seems good

Thanks, 
Dhananjay

> 
> thanks,
> rui
> 
>>
>> Thanks,
>> Dhananjay
>>
>>>
>>> thanks,
>>> rui
>>>>
>>>> Thanks for the review.
>>>>
>>>> Regards,
>>>> Dhananjay
>>>>
>>>>>
>>>>> The patch LGTM.
>>>>>
>>>>> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
>>>>>
>>>>> thanks,
>>>>> rui
>>>>>> ---
>>>>>>  drivers/powercap/intel_rapl_common.c | 20 +++++++++++++++++-
>>>>>> --
>>>>>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/powercap/intel_rapl_common.c
>>>>>> b/drivers/powercap/intel_rapl_common.c
>>>>>> index 3cffa6c79538..2f24ca764408 100644
>>>>>> --- a/drivers/powercap/intel_rapl_common.c
>>>>>> +++ b/drivers/powercap/intel_rapl_common.c
>>>>>> @@ -2128,6 +2128,18 @@ void rapl_remove_package(struct
>>>>>> rapl_package
>>>>>> *rp)
>>>>>>  }
>>>>>>  EXPORT_SYMBOL_GPL(rapl_remove_package);
>>>>>>  
>>>>>> +/*
>>>>>> + * Intel systems that enumerate DIE domain have RAPL domains
>>>>>> implemented
>>>>>> + * per-die, however, the same is not true for AMD and Hygon
>>>>>> processors
>>>>>> + * where RAPL domains for PKG energy are in-fact per-PKG.
>>>>>> Since
>>>>>> + * logical_die_id is same as logical_package_id in absence
>>>>>> of
>>>>>> DIE
>>>>>> + * enumeration, use topology_logical_die_id() on Intel
>>>>>> systems
>>>>>> and
>>>>>> + * topology_logical_package_id() on AMD and Hygon systems.
>>>>>> + */
>>>>>> +#define
>>>>>> rapl_pmu_is_pkg_scope()                                \
>>>>>> +       (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||  \
>>>>>> +        boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>>>>>> +
>>>>>>  /* caller to ensure CPU hotplug lock is held */
>>>>>>  struct rapl_package *rapl_find_package_domain_cpuslocked(int
>>>>>> id,
>>>>>> struct rapl_if_priv *priv,
>>>>>>                                                          bool
>>>>>> id_is_cpu)
>>>>>> @@ -2136,7 +2148,8 @@ struct rapl_package
>>>>>> *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_
>>>>>>         int uid;
>>>>>>  
>>>>>>         if (id_is_cpu)
>>>>>> -               uid = topology_logical_die_id(id);
>>>>>> +               uid = rapl_pmu_is_pkg_scope() ?
>>>>>> +                     topology_physical_package_id(id) :
>>>>>> topology_logical_die_id(id);
>>>>>>         else
>>>>>>                 uid = id;
>>>>>>  
>>>>>> @@ -2168,9 +2181,10 @@ struct rapl_package
>>>>>> *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *pr
>>>>>>                 return ERR_PTR(-ENOMEM);
>>>>>>  
>>>>>>         if (id_is_cpu) {
>>>>>> -               rp->id = topology_logical_die_id(id);
>>>>>> +               rp->id = rapl_pmu_is_pkg_scope() ?
>>>>>> +                        topology_physical_package_id(id) :
>>>>>> topology_logical_die_id(id);
>>>>>>                 rp->lead_cpu = id;
>>>>>> -               if (topology_max_dies_per_package() > 1)
>>>>>> +               if (!rapl_pmu_is_pkg_scope() &&
>>>>>> topology_max_dies_per_package() > 1)
>>>>>>                         snprintf(rp->name,
>>>>>> PACKAGE_DOMAIN_NAME_LENGTH, "package-%d-die-%d",
>>>>>>                                 
>>>>>> topology_physical_package_id(id),
>>>>>> topology_die_id(id));
>>>>>>                 else
>>>>>
>>>
>>
> 

