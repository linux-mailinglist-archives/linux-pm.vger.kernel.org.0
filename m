Return-Path: <linux-pm+bounces-8178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D664D8D051C
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 17:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D286428EB67
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F60161339;
	Mon, 27 May 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="codSMHcN"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE115F3F7;
	Mon, 27 May 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716820640; cv=fail; b=MtN3/vOZIcFfaZwIEj1YDfCU9Zgzot6IWfOvCuvdzVlgx3kkeTSZ7Kp44PUyKV1x7+z/r9dKxr9mN4EIRMejuGWFyAWWis9A2BISY6yRBFUFv6coL5OLr+Vbegp83gtnmiuSbOxK0KVqPApM6jGS4qqwVxDL8rWOBjIl1z1qIac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716820640; c=relaxed/simple;
	bh=vyCPEkPErIKNFSaGqKiTLfQ8qltCCBW6t63Ps9kZRm4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u9W69SO/ruKEf10RgCgtU5BzNaoG8v1nApiSc798Fb4IHAwik6ESFwcPof+hv7AlSAXQwFxOql73mJ6+4aBYq+L8eOMSFnRhY8LEhG6w1w7PK1HigbW9tADfFQ4lTza2Ln8SOpnG0IAUgUV40cPtNsH4D7IiDqBpLjJX2PXFOnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=codSMHcN; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hI8/Gf1bperQIghve2ZMzDkSYrIG5nGo2lWoBqZ29lveKNJIYLK/DgLHWe7PEcnOBIl9Hw4mrEB4O8CokTTbgA3WKVE3SPHCQqlQyVCuKuybsUFsGqmrgCp/de/bDttCTj+duKNUEMYZFhouEQahuW4zBVz9yDocClX1Ps+eWWxIegLdAFEJYzzFt2ZsE7BT1b/Y7VcrJRWBQDqBFk8z28asjqcHU7upKZFWXY0N1fmHAY9QQX3kWVii7XCGfxDr3ztu1+GQ51+sgn83Jf2FeqLC2UvUSZuruisZqQ9HeQgzjsdOpkUO+D8qUQvB0/Ak3DngM+Pc5AMLwcf3j0HTTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciePcUi+AyTYC8YL1EmlhNcBix4pxic7LTFSC5px5T0=;
 b=QpzP7RZmf67JCSiKz6GRpQ8aFiNHIy3aR8I4qEqz7tCREI4lRf0cAXPV9RAeRiy7I3Wd9humr8xqPkREqrbFbNBcpLe/kFwYbUn7JTy0JKviCwyo77b5xALCUgZiXg2qdFe9kh88ZpQ/hfqHkHnb+EqDdyBDtfmBA3D2i2I6Cg+HXTAO6/BABKrRhkgtAATbPTqB5P6whvsl3Xdajb+Zz/NM7wpSk1taRoo8y/1nuYwK60f+hx1CIDB3UZibcQtvYA3T7C2zuaGg0qN/PjGgK3Vv2WeadO+C6gSmNSCmM1V5JnDyKIEVlHs8fEkjHa+7TTDDYEl+9NT5IZbLE9Uzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciePcUi+AyTYC8YL1EmlhNcBix4pxic7LTFSC5px5T0=;
 b=codSMHcN/PwNRrwEHhJ0gNv9dTUCf37l0fwTIfEvp53vyzSd7hVDe6jMwRkbvDYclLNhOGJndJcMAPtnf9udoWz2nuyzrSglUfu7Z4VBCprA1iokcXfk/KRU7G42i9/8J2jiS9SBHR1pa6GC8EbRmNoJKH3nRbB68wcytRi1qVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 14:37:15 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 14:37:15 +0000
Message-ID: <f59f4cc3-6327-2f1e-dc32-03eeaffe1f54@amd.com>
Date: Mon, 27 May 2024 22:36:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/2] x86/cpufeatures: Add AMD FAST CPPC feature flag
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 sandipan.das@amd.com, kai.huang@intel.com, ray.huang@amd.com,
 rafael@kernel.org, Perry.Yuan@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, mario.limonciello@amd.com
References: <691ec6cf79788e6db919965f787505434b072fac.1716444920.git.Xiaojian.Du@amd.com>
 <5c14a151-25c9-41f5-af65-d2a8ffe548fa@intel.com>
From: Xiaojian Du <xiaojidu@amd.com>
In-Reply-To: <5c14a151-25c9-41f5-af65-d2a8ffe548fa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0088.apcprd02.prod.outlook.com
 (2603:1096:4:90::28) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5136:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a76e08-ec50-4011-82bb-08dc7e5a8074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak1rMzB2MlZwOURzRHZHN2JtczhaZWlGbEg3QklBUkRXdmdkTVR4UWM2Tk1I?=
 =?utf-8?B?clpFdEVqSm1BTU1jTUQ5WTB1VVhSSXZMSGpDV004eXF3UVFuOEh0LzZYb3p3?=
 =?utf-8?B?QjBDT0o3ZjNoWUt3YVQwUTU3enBLWitZcC9zYy9jdjZsa3h2amQrU2dFWjBk?=
 =?utf-8?B?WkdGSTdtYmw0U2RQZDRZOFgrbTNMcVpFbG9GV05jWDE2M2Z2akFOMW9QVTRn?=
 =?utf-8?B?WGxuMi81WUNRSUV0WFdXNnludGVsVnZaMVRSYmZKajkvZDFLQ3ZBSWxZUTVD?=
 =?utf-8?B?MFNIdTZQM3NtSzBycDN2TG54eXd2SjJsMTlTWVRTSGlUeG1CMFFYQkY5NlU4?=
 =?utf-8?B?N2ZBSndOdmpqcHBZQ1g1NWJDdmtnRXBIeTlPaWtCUGpnTUo3WDRkeUxRdFcr?=
 =?utf-8?B?VUp0a0h2T2lqbDNqcEwyak1yYkRTVnd0STFFYzhLSXFiYS8vM0FQQThWWmFW?=
 =?utf-8?B?ZTVUL1lMWlpyNWJ1MVpaOWtKdGVYdXRKYmNlcnRlQnRiTDNhdTMyekU2N1N2?=
 =?utf-8?B?TU9ETjVia1h4SzJ1VmQ4OVhHR1VXRy9IdkRIWTF5a0hsZlV2MFpmSzY2Q1FE?=
 =?utf-8?B?TFh3N2dCTklVTFhHMlBUWnp6Z21OcjBhWm96OGdUU0xNRkdXSnV2Wmc0Yk14?=
 =?utf-8?B?dWR3YUpFWVlNNUwwWGJ1dXFublEwMkoveDNYb2FxVndNVmc3Z2l0WnhGYUcv?=
 =?utf-8?B?WVVRQ2dSN1RRMTJpWFp5Ulp3S25wSVVFV0VPdU5HQmRqT0twYUZvMEZUUVFM?=
 =?utf-8?B?OWlYVCs3aCtJY3VRZTYzOE5MTVU4dGtPSGtqNWdicXZtNzNoSDVpa0l0bTk3?=
 =?utf-8?B?UUR6Mzl6Zm5LRDlSeHNvcHUxRld1TFRYUVpTUmMxWjZtcWpRdEx4ZUlHeHdz?=
 =?utf-8?B?RTBEc0lzK1F5VXRuZERYN2hnMWtTVnllVEZJMjUyc2RLbGZDV0ZqenFDeVN3?=
 =?utf-8?B?NlVUaDR0VjBCdGlXOVZ6STdhekxMQVdJTlI2dTlMSk9FRHQzUjhsZEliMHRE?=
 =?utf-8?B?Y1JMUERWcGN1a2o0aEU1L2JFNEVVMVlRRGRzZ2xTNEE4SU52SDV1djVvVzFD?=
 =?utf-8?B?b0FjMHRMd1oxa2lxVjVCdHprR0wvNWFjUVhtMEZDTUJSQXR1bFhFaHRta0tR?=
 =?utf-8?B?SDBnejE2RC9NOFZ0VzZ5S082elhlcGNpVk1ibmEzbmZHeTZYV2ZlR0VhWEI0?=
 =?utf-8?B?YllXbENEc0R0NFFXQ2RHOUtJb3g5QzdIWit4QmN3ZHNHMnhIUWI4djNjVDIy?=
 =?utf-8?B?Mm5vemxOYXRicVBZSUFIdTZBOHo0cVc1a3hlRnZxTWZPQlhBQ0VNdi9KaFdr?=
 =?utf-8?B?bHlxK09yZWdtbU1sQ1RDcHBZSWpFYzJENHBwU1M4bnR0TWF4Y2YrZlhGR2Zn?=
 =?utf-8?B?K1E0YXBwVFFLaytYOTZqL1NscXVIVmViL1R3L3ZqV1VFbkUxR20xYUsyMGsw?=
 =?utf-8?B?UFo1Qk5yRTN3V1RObXhtbVlaY0tOUnU0QjVxcGptUGhlazU5aFdBY05KTzEw?=
 =?utf-8?B?bnRxNFk2VE4vTjdNNUdySnJ4OWVwcENOMmxPVG9LSzFycENwajg4RitDYXYr?=
 =?utf-8?B?Yk5IcnkyQmE1SUFXVzA5R1V2ZXpTeUNPOXNnZCtJK1kyUEpEWk1JK3UvbTFM?=
 =?utf-8?B?Yk5VUXZudjJic29sTUx6T3daaEJhcEdRckJ3SlE3QU1zVXEweDIwOGhpRjVo?=
 =?utf-8?B?eHY2M1JYYTVORW5xMjNHTFVnclYrRHAzZ25IZklWN2xpVkdXbG16dFlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0hMMjEwd0RSTG5UdnF6VEIrbFhtelhuQmM0dlQzM0RaMndLenJQUzJPMUxF?=
 =?utf-8?B?a01ZVGZ6a00rMXZjbVJHc0VKckNHdExwZFhqeWJyVzd2TGlRMm44RzJCS2s0?=
 =?utf-8?B?Um13YnZEbVZjQ1MrTnE5NjhLWkFTNUxkNGtEUFRRckEvRDJ0TUwvd3FaSXZY?=
 =?utf-8?B?SDhsRkhUMUx3TGUzc0lxakdDSUc5ai84Nlg5SUFyZHFML0ZSSTI5eVdzaTVE?=
 =?utf-8?B?eHlKczlNU2tZRGhUUDJxRC8wSzE1U1VLWHAwdDIwRytnVk9DWjdHWDRaakJI?=
 =?utf-8?B?ejZ1TnkzYXk4RjdvVE5IaDhoTTRUcHlhV00rMldzczgxamk4aVhsVWNRZWhD?=
 =?utf-8?B?Sm5PbVJpL1hmMVY2cXFOeE9kZWdqL1Z5d0hja1lRMXR3dmdIdnI3YXBUamwv?=
 =?utf-8?B?eWVEakdxaUNOUSt5TmVDWFRiVWYxZVkzdjBJMENhbGI1YVBTQitvSW9rNXJw?=
 =?utf-8?B?T3R4RjdwQTFyTmo1anFIVjVCMDZyNVpJQ0ROSzhIOWlQVUJBekhZMXBRTEwz?=
 =?utf-8?B?bDBlTEtkd25JV1BVZlRrL1FjTmdlMUpwc3BkNnZ5RVZ4WWpXNTVxc0llbGxL?=
 =?utf-8?B?Ykd4Ny9XYVoyeklPRWlraWh3bUNKb1VPbTFyVDRReFEzVVJYY0F1Y0ZlMWZD?=
 =?utf-8?B?aG1MdUhxUzFXWGdWMnBIZFY4M3Q4RDdqeUNRU0g2NmFjbHRRam1pRFJDdEZM?=
 =?utf-8?B?WlhTemltcWhNbTk1UFdpWVBTalJUN0V0enU2MG9oME1aNWRyL1pIQWJ2WVZL?=
 =?utf-8?B?Mmk0VE83Z1B5STRJRmw5UFhWV2p6QWt0dmVKaEpjcHRuQ0psTkM3Vy9ld2JT?=
 =?utf-8?B?eVpHSlNuWmJUZ2NyZENweUpJMExYQ1BOQk02Nmh5Nk9LZGNleDY4VFlvajBo?=
 =?utf-8?B?R3Q0VFN6T1pMQkpScEhGYmE1T0daUzN2Tmhvb2JVMEQ3bmRxblpNSjVWcUto?=
 =?utf-8?B?bWxCb3dsbVRzTHlZMjhTYklDRHJxWGl2R2k5Wkc3TDl5L2RHR1dhK2JHL2Yx?=
 =?utf-8?B?VU5WZHNhZnprQ0RMcHo4S0o2WW1SbU5LYnNWRDBFL0Z5R0Y5YnQvYTFSSk82?=
 =?utf-8?B?bi9mRHVLbGFTZmJrcXFBdVIvQ3QxVEhXTDhRcHVWV2Y3RTJJUVRUdTZoWlF5?=
 =?utf-8?B?NGJEdUM0ekNoSVkyM3dmbnJaUFB1V1JJOEoyeU0vZlZnUmRySWZrbld3Q1ly?=
 =?utf-8?B?QVJ4UjR6cGVFbU1xZTJUOXRDUWlzNldSOVJsMDg2V0luYzRWRHhUVmFvaHdh?=
 =?utf-8?B?TmxZWFRaTE16VURYMHNWRWt1QkpVa0FiRnkwb0Y4S2J5SFd6YmtXMlBPdWRB?=
 =?utf-8?B?a2Z4UVFvNTY1WVpPcXVBMjQycmN5R2xQS3hHTCtmNjNYUFVYZXRRMDdJU05y?=
 =?utf-8?B?YTFta2c3azdqM0FWQkw2cVpjTzFNcWxUSGNBeW1yM3VmSEZkeEg1cE5tVXBF?=
 =?utf-8?B?Rld1ckdCR1FONE5FQmZZYW9BdzFEYVMveXVLWG5ZS3pNaktYR2p6SnFVdDcx?=
 =?utf-8?B?SG5uV0JhSHFQYTFJQ0t2OGhQdTc4a1l6N0dkYmlkNWVBOGxSMXp4Ti85MUNs?=
 =?utf-8?B?ejg5Q24xdWNWSGNlV25YS0IyeURMRy84VzV5VVV0alFtRy9ZMysrZFFIVm5o?=
 =?utf-8?B?bnI4b1l5L1V2eDF6cUxmd2JnTXdrWHBqZkJIcmZjbHV5d1NNTysvMHNZeGNU?=
 =?utf-8?B?VjhscVkrYnNXK2ZDeVBPakw2M3ZMbU1DT3RNa3UzU1R1R2Y1VXN5YzZGSkxq?=
 =?utf-8?B?M3hhOXBlL2FqVjBPMVR6bllmQldLSEtZMlFCV1ZOYTRiVHk5cEJqZGhRbVI5?=
 =?utf-8?B?alhWY25IR2cxOUxINml5OFF4MkVteVgxdTYrZWZVK3VQUTVtRGphWXFPc2VR?=
 =?utf-8?B?ekRpd296bUZFakdGWFhES0lqRWNzT0xuTkxGeGhOWnBSQ1o1VSsvTnhJWmpY?=
 =?utf-8?B?cEJIL3d3RzhGTVh5bHM5bzhJTGN4RkUxQ3ZJaGJjeHVRb1dCNWRoSkV3NGV0?=
 =?utf-8?B?Uis2S1F0TFBWeUVudnhNVURoT0lpMDZkWkdrTUlVa1VIVnZ0aElQbGlLQi8z?=
 =?utf-8?B?Mlc5VG5VRlpBb0JNRkRmOUQvWm8xUnBmQXRCOHNSVXBKdmcxdmVDSFREUnlZ?=
 =?utf-8?Q?tBGvzjoGPL+S4pzMY26BWnW56?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a76e08-ec50-4011-82bb-08dc7e5a8074
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 14:37:15.0722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kt16DdTstXh/MXC5t9LBo0I7jwagHyvZGzWfr25QlwJbmZVfGz5iK5xcN3jGjQ4l448dPcpjr5GuI0chRJJyTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434

Thanks Dave.

Because "CPPC" has existed in the "cpufeatures.h", thinking it will add 
duplicated line so I don't expand it.
Making this new flag hidden is to avoid causing user confusion about two 
"CPPC" flags.
This new feature flag is added to choose code branch, if not, it has to 
choose a ugly way and use CPU model ID.

Thanks,
Xiaojian


On 2024/5/24 0:31, Dave Hansen wrote:
> On 5/22/24 23:16, Xiaojian Du wrote:
>>   #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
>>   #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
>>   #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
>> +#define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* "" AMD Fast CPPC */
> It'd be nice to expand the CPPC acronym at least _once_.
>
> Also, this is used _once_ at boot and not exposed in /proc/cpuinfo.  Is
> it even worth defining an X86_FEATURE_ for it?

