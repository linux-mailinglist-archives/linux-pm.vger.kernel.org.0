Return-Path: <linux-pm+bounces-26920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E019BAB116D
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94FF3AD804
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69BB28ECE9;
	Fri,  9 May 2025 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CVC6ANTj"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D7A228C99;
	Fri,  9 May 2025 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788654; cv=fail; b=rhjf1XKZpuzfht1XiDzha27z0c50/7HyptaQtaTXWsuJli4jVorB6g+2XbW1ngor/shqA46tGgntHmMWwP5CMu5A5PkoMvwFinUiu63qm4JCIbgR7/q2L4nbTxxOzXUl1MrnZUforrSrgYAjY1lw6BtvmVQv3eVg95T9Q4GW58M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788654; c=relaxed/simple;
	bh=/7ZtilYnMm82F/PZMNcDcxm0skF8pHU3JNJIFuzWHjc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ofgsVJZsYvWdMHgyMifyDfKHeegGRCI+CV26YGymLafU+bRtM6ERZxXWOtkQCmLTZF8E8JDdOmP493g09EB9CxEUqU1jwXC2P/Q7+f3YjHuHjkZCTQfmiwoxok5t4kFVzlakXuGA8oOI6ECvs9VoTrFLuyNuJo0Yiydt04g1Kds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CVC6ANTj; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIo0d08LZqCEPjucBQqPdzC+WmXwbITUmkw49VhJThIBmVHxEXLv79KIBzeVt+zsgyBD4Z8uCWnnTJtkuTfd6w1jlGAc98HktPLwUdsvW9uBgpvDzLUev8rq7s2rSDxjdEg94M+mVPjJOkm06QraPcavAswx3WP/QoC+/eaVHwi870+lNfjjfSIiG4guc1FK4Mum40LtHIgUBifKGRNlQe8O6ZLXlVZNKZvOn5Ea/KEi0dPVJoxUhprA7iYYGETQ5SA7PGgb7gIJfGUw9vnEMfmRz2rpvLkh6M2mPO9z7SYw9aeIYVGn+UL9uI9g26He3eGnEDCdC0owmuDG0K+Bzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hO0xdNL/xoWJDfzHqMUvDgZc4Fa5B938nMK+WWCLa8=;
 b=GpPwWIn0rC7B4tzHqEUKNLmj8apl2fm3OEZgVnBLuCSk24eTzcJELJtKjFRmbZ9dz+Wbg4ZzYZ8aMyGeFcbwqAQz5Peonlr+EwAkgOJ710TAmnF6dugEyIjvBZwCD6uzniMV5qErVZbfQHvhTboKfjfBhG7k8InhQPwOVjbUajhNwTWjhT1sGn8R8U7Pz/mgu9sZlRH+rxSGss7BhugbyuclGEPw6mTo9C5KwCl+RJyDNaJk7/m7qd1Cg4HX8VHdbEGLVRDgTEbz17JoRkz9UPDGGv7fDhkbeMP8SDI7ow0bEPsNzKTToNBlnZ9yQnzNj9hwA4CAwGTMtB/L48xHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hO0xdNL/xoWJDfzHqMUvDgZc4Fa5B938nMK+WWCLa8=;
 b=CVC6ANTjGbbK57Q7+lu133J/uw+fM84a5EtDHYok8+sqzU+B+aDgI16qWjbw+GqwU/LIRNtxZ6Wla3Rkt3NeAUkd3rVIk1FPiQNYQ/0Syvytho8hl7yarS9xxboY0Rk6ecZVQFD8p62hYc60rVnMn6svzfq84LTa9/UtaWZkHuy4Sst6/E9TwLgC6QhKPCMMfGkh8AvWUv0fxidL/afPjH3pKsq/Al0ijKrxW5854GuhtG6fVpmJenSKn4D61kEmuVNk3VnjK5hnGcoBl/Yd6Ih0TiW3DztzvuCNiFKkQlDLflli7PHRiUXL10SZuYAYFwNP2/oBljVB5KBcjHs0MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 11:04:09 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 11:04:09 +0000
Message-ID: <040b0d8b-e862-48dd-9b77-9266a5194f99@nvidia.com>
Date: Fri, 9 May 2025 12:04:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cpufreq: tegra124: Remove use of disable_cpufreq
To: webgeek1234@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-1-d142bcbd0234@gmail.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20250508-tegra124-cpufreq-v4-1-d142bcbd0234@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0142.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::16) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 1092d255-9707-465c-951b-08dd8ee938f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzhicWpLTVJTemxjTTZORHR2UERkRk5qY3lPUXBkOExHSk5yL01MQ0hvT0pN?=
 =?utf-8?B?SStsVk5Mak9BOUJRNUZKYmpFaVdYU0tGc1RzRWtVeHc5SlNoK3c5d01VZkgy?=
 =?utf-8?B?bGM0Sy80Snl2NXcrdVlXQnY0S2pvUS8yR1ZFaFgwRHRWNXd5REl3SE84Vngz?=
 =?utf-8?B?c2NKVDlGT3p5VlEvQjZnMURZV3FZNW92K3g4R1NGbmpaSjM3M28zTFlnUnc0?=
 =?utf-8?B?dENkMmtVVWM5bFZnNFB0N3RtU3hLdFFhaURmMEsyb3d5UmFXWHlNVTY1Z0Mz?=
 =?utf-8?B?L1NVTTgzVVNnQUxJMnhZRkREc2xBUStBWmN5RW9JN01UK3UxWWxMc29sV2ly?=
 =?utf-8?B?MTFrS0lmajM0ZnFpN2R6T080aWtIcThncVhHQVJDeHJVUVE4MFlGNnVyVWlt?=
 =?utf-8?B?QnFEenpYWTU2bUROWHFSY2k4UVlSLy9xejZIYVI1Z2gyT0sySExHelk5czc5?=
 =?utf-8?B?Ym5MMEpKRldZZVZ6bmxjN3cxVWt0eTRaT2VNRm1GL0FYcUQ5Rjlnb2VRSXd3?=
 =?utf-8?B?QkJhd2NXYVp5aDhwSC9LNHpEQUZtMjZieVQ4NzRnS2dZL09HVlBTMXZUTEZu?=
 =?utf-8?B?Z0ZER1hiNVNTNGdTbnRlSUY3UTRUSVZDQmlPWnpjeGs2S3lOUXh1WmtRVlps?=
 =?utf-8?B?MXljZ1B1MjhaVnFkUEdoNVBQRHBzdHZ4WDduellaZUhUMmxFTkVtbVdIWDNQ?=
 =?utf-8?B?NXAvTytYeWRjWXRYS2FMcFI3b0M1VzEySENSZmNZZkJzOUlUU1ZzZWlOaXph?=
 =?utf-8?B?MWZwb1o1TFRzem42NUNkRUdVeFdhcW9KNkVhQ3hzNktCcG8wRnBEZWFiSi9s?=
 =?utf-8?B?bzF3OEROUERFL0I1eS9MQTMvWlo4ZEoyL3dVdHYyc3NmK1M4M3JvVUF0OFly?=
 =?utf-8?B?YjFFaFE3UFpId2t3U1FZUlV3OFFlMVdLcForWFJrc0o4b3FjQ1p6Q1UySXBj?=
 =?utf-8?B?M2duenVpZ0ljVzNoVjdLNk9tRUJVa25sYVltWnp4R1h2cmtDUHhiaUdFMnE2?=
 =?utf-8?B?dHRXRWh1Y1ZjbjVQMStkT1JFcUl1eUMxTFhwaHcxaTkrcEVkN2tNNldNZWh2?=
 =?utf-8?B?MTZUQUFmTDFtNXE3T3RJMXE2TXdpc29XZWlpRG14TmhRTFg1RTNsTzgzTTRz?=
 =?utf-8?B?Nm9EZ016MGlFd2lTbDFYTlFSVlNxT2R2NFh0Rng0VGU1bFZ5bDlzcS9yek9m?=
 =?utf-8?B?aC95dUhoV3d6d1FTZVFweUd6bE8vVDd0d1BYTVo5cUhJSTR3a1hiZVpMclBh?=
 =?utf-8?B?eXVUYms5OFh6Zzd2Y0R2ZVU4UHBGc2JURkk3UDM3bGVNRjZpSUc3dkZNbi94?=
 =?utf-8?B?S1BjOWpHZ0VCczBna3NYeHNiaWZMcDRESkFGNDk2WVgrTXI3STRXMWdxcjJX?=
 =?utf-8?B?NUoxc3dLRHNCN0xMZXpOR1RGeHlQY0FaZytpK1FPYmpJRnNoN1VQNG40MHFG?=
 =?utf-8?B?ZmNKZzVicFhoOGhhUC9zYU5vaUJZM3dCRzZEdTRkcGNZWFp3ZXdvQWYzVGZj?=
 =?utf-8?B?eTd4WklpVmsrZkxubk9VRWdwTFJYOEIxTjlydUxCZ0VzWDZQd0VqNWpHOHRz?=
 =?utf-8?B?N0ppU1lHTWQzK2lBZTV1U2JDeG9hclptUVFxb0pmazJhNTAwblN2VE1ySHRM?=
 =?utf-8?B?endpYlVoSTQzczZaWUNCR2NGSDNhaEpGbHFuUmltcTBJcHdKZU5XRVlSdjVw?=
 =?utf-8?B?ckJud3ZoeWZaM0wwNDFPS3BlV3BqT2UvV1FZL1FWS1RoaHMrNlhQNlMraVpS?=
 =?utf-8?B?NnBLc3VqaElSL09CQ1RIUitheE01N21Cc0krTHZmU3Rod0RhK0pNS0hJM3pZ?=
 =?utf-8?B?RDQvYmllaXlJaUlVMi9pL1g5bUlNR1RKTmZTY2tUNlFWUGFWM1ZJbC9aeCtM?=
 =?utf-8?B?WlI5TVZCZjM3Mk1SU1djV2trMHJ6Mzg3b3krZFZLVStuVzhTQy9GY2cwU3Bk?=
 =?utf-8?Q?RJYXCMlu/V0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUUrNXZhYW5BTEhYaUxsK1ZqYUJDcGdPc2lEYUZOTEVpRFlLL0o4WU5CeW5U?=
 =?utf-8?B?UFlWbmZLZ3dleEhpOEJ3elJvWXNpM3hCMjNrWGNvSUwrVUs1YlljdEhaSWRI?=
 =?utf-8?B?WVh5eEZzVVBZU01Yc1MySXk2RENTOGxqOHpzT1doUDVQZzdLUUpHNkhkcnBY?=
 =?utf-8?B?L09UMGZ1UmdBUlREbFlLa3BoZXNqaFczbitibjh2WmNLV0VlN2lRTlY5cnY2?=
 =?utf-8?B?cWN3N1gyZ0RxTzVpN1dBN05RM1pucU1rVTNFZldxVW5mdmtIMjFRdkJWVHVh?=
 =?utf-8?B?VDhGY3RnTXNib0xpSDFtd1hxWUxVNFZVRis0M25FMmROTzVOS05SdE5TNXlz?=
 =?utf-8?B?Y1pncm1kaXRLOTBHeVNqSlpxWG4zbFdQT29MMkxvN2xOanFxb1BVbW1rQ01i?=
 =?utf-8?B?YTE0OUpxLzN1YjViQUdGeTA5eW1BdUFZVzc1OVNYalc3WFUwMCttTXpMRkkv?=
 =?utf-8?B?UFRJY0RjOEV3SWYxb1pGeWdpazVQODhaUVFxSjR5ajEyWU5FdE9HYnVkOFBU?=
 =?utf-8?B?YnJiSkRWRU5zeXdueEE5MmRGeFJNS0lDblBZMUp6QzBJWjBqYTRJTUNlTVBj?=
 =?utf-8?B?aEJOaHB2dzYwcmN3MmhkclY1N2ZVdnlNcWg1dkJZbGYwZ1Nqb1kwMnl1RE4z?=
 =?utf-8?B?TlJ3T2d0WjNVQnY3K3d3MFpJU3kxUTlyd2NZTDVSTlp0SmNnRW11TjRtMTVQ?=
 =?utf-8?B?VnhIZFJESzRtSGxYUW4rM1F2djgyOGdwK3VYRE1XUlN2QnJTdDFMQWRTVjB5?=
 =?utf-8?B?VW0yNEVpRTFGRy8rWkpxdFdQS2EvTDZPRm9kNDhFVDVOY3VISHF1THdqNHJp?=
 =?utf-8?B?ZG5sOEFEY3g5N3o2SGpsVnNmdllNandMRXRISWRBRmVpZ1M4WkhSVmxEaUhQ?=
 =?utf-8?B?Z2YvbGlGcW1qNENtbWVjRUE4QXFVbnMwUnFXWVppaFovdEpxUkFlZnQxRGpM?=
 =?utf-8?B?SmwwNGVkT3hsZENLb2U1TWFjSUhHZVpVY1VzbkVhM2tHSEtjd01HeGIvVjYy?=
 =?utf-8?B?N2VxZVlySXVNQ0VQY243OU53aDhmZ1FzMnAzcGducW1lVi9LWTI2cWhLTXVT?=
 =?utf-8?B?N1hSc1FRVHJGWGVnSlNQNXVMWVJRK1ZXWExTd3h5SVNkUzVjM2hUdHF3ZnNZ?=
 =?utf-8?B?eVh2emRCT0FYN0RHRHRYZ0taa3lZeGd2ZGZpNkV1N0liTUxaK0VYd05nSHZk?=
 =?utf-8?B?SENPR0NQNkNOd3RoZXhiRjdHcDhpeTBTdlVSMDFLTlRpUElCL2N5RTJnSEpN?=
 =?utf-8?B?K1VvQ2RBTnRGZUlqMjFvVEpoVEx6UllqczY0LzlEUTl1bGFhajcxWkhzY3Nx?=
 =?utf-8?B?SDBPUkRublJ2ZU01MDRWcnM2bjhvS2w5UDNTcngvc0hhRXJXc0dBMkpDaktm?=
 =?utf-8?B?d3EwWjR2UEpsemlGclpZSEg1Q3Z1a0N1RmxTaWpsbUFhMDZMaTc4N2VkOGwy?=
 =?utf-8?B?Y1hmdU5CajJPT0I0UTVhQXYrR1dndmNrRHdmckduVEU1MEsxSVpEUmpmb21G?=
 =?utf-8?B?bm5MNmtyZEZBMzNZNUhlZWtoeUhpd3dBTURFSklxOTZvM25BNVQwQ3hSd1pH?=
 =?utf-8?B?cldWVCtGTExKQ09ZWVl6eHdRSXUvUTczTmtiYlkxMFFveTdoN0x2Q0FZQ3dK?=
 =?utf-8?B?Mk1MY3BWRzEyNVM0YllrZzJRME5qTVBIelV1VUpxcEFvM2xOSTQ5bitUa3l3?=
 =?utf-8?B?NGZkclNxVWIxaFJjSEdkeStXWldIaXpEc01VdjlITHFueTlQNFFHWUNTTlM0?=
 =?utf-8?B?OHBpMFRCMjl2bXk0VDVFWm9kNzdDSUdyZHI2YXl5Q0lYYnNXUXdaRUZSajNw?=
 =?utf-8?B?VGVsNUx0MExqQnFlWXprNDJ0R2xLV1dVMVZzT1dJSTN4aWQ2N2hUQlZrUGF6?=
 =?utf-8?B?aHBGZ3NSNmF2S09EM2xheUFTbE5VY3FjWURPTDRxNXBucDM0eUVxaGg5NytF?=
 =?utf-8?B?VnRLeGQ4VmF0aGpvaTRQeHU4T2IrcUwyck1BZDNiMnVyQ2tkNWZQN3lmWnN1?=
 =?utf-8?B?cGx5Zm9ibTk1SVpBRDJOTFlYZXlBV2syM2gzaTIxcGZneWM5LzBOekxULzZz?=
 =?utf-8?B?R2ZmY2JDNndrNU1xbUt6eHU5cmw3djFxamJDcW1kOXVaZTdJSjdTTW5VVFo3?=
 =?utf-8?B?cFNxZ1FremkybUtRNzlmcUFYRUVlazh5TWp5SDRVaTJxU2g4dU5waXVCdCtx?=
 =?utf-8?Q?zyz2T1XWPqY3gQmWupBpMlnTX2KPCmFUuaaasjexhRGX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1092d255-9707-465c-951b-08dd8ee938f9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 11:04:09.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuryGozCqAxwlTvDf300dU3AkFT+4FQjt/UZI5oH63FBRshGLvRnKX3yACO+wV8DhdMnDxQgNjs5uHOC86nhBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304



On 09/05/2025 01:04, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Instead, unregister the cpufreq device for this fatal fail case.

This is not a complete sentence. Seems to be a continuation of the 
subject which is not clear to the reader (at least not to me). No 
mention of why or what this is fixing, if anything?

> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/cpufreq/tegra124-cpufreq.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> index 514146d98bca2d8aa59980a14dff3487cd8045f6..bc0691e8971f9454def37f489e4a3e244100b9f4 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -168,7 +168,10 @@ static int __maybe_unused tegra124_cpufreq_resume(struct device *dev)
>   disable_dfll:
>   	clk_disable_unprepare(priv->dfll_clk);
>   disable_cpufreq:
> -	disable_cpufreq();
> +	if (!IS_ERR(priv->cpufreq_dt_pdev)) {
> +		platform_device_unregister(priv->cpufreq_dt_pdev);
> +		priv->cpufreq_dt_pdev = ERR_PTR(-ENODEV);
> +	}

So you are proposing to unregister the device in resume? That seems odd. 
I see there is no remove for this driver, but I really don't see the 
value in this.

Jon

-- 
nvpublic


