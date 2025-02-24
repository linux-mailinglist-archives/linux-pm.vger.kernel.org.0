Return-Path: <linux-pm+bounces-22758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEB7A4148A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 05:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6E73B46A5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 04:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3961A7253;
	Mon, 24 Feb 2025 04:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ErYNnP4D"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ACF2F3B;
	Mon, 24 Feb 2025 04:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740372720; cv=fail; b=mEij7JsjfbthbqgMpBE3K0O/TQL+fJQOzQOhUnZcsIlyAq4Ov2Wl0ij2j8sodrYZPCc7P1CMCnqedQFz/GATSfUTrjlbEG16nqzvJ2w7gnKZuoSplWON2H3ehXzYOcNQivJZigX+8ZOg6+x7KC3e2C4Krv8n2eVAyWt/7MC7BPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740372720; c=relaxed/simple;
	bh=FRSJ7neSrtJMRba0WFqKHujj8wtIKYMAXENrscEeREc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rp+0XoaN7VqxAJRUtF7Sk8q9rUQnOMhjqarN7S0kE+Wo+oV1polYs5mESfQNIhI0Al3Ds22bgHDfLkr4uVCTYldYnhvxy61VNebXTTIiHhW4i1ka2WuvILCV4yRGrc/c6pXOOaF2pjt/IKtRK5jzEMuw8Uyxzmi8fMXTF4ILnQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ErYNnP4D; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfylMy3C7sIa6PLHeUNna5sNPJQlBYs4JiRG0eemvppw5HG2KjrqYka5EUgjk7G0/nragY7bRCpTzHWNkkWrqwJawSYsU7J2g0B4y8kJhwBlq7GoclKJIutizQOeYFPygB4FZ24+s7ZOE3IOA9CsmxqXOyXPINaHTfhL6K7T18eok+nbRSYffOx2Sec6M981OQ35XSa1dcTiIvbSNPnscvOtT8ZFDLyV1gLPvryxWMUnoiHqr9VdEftwYs0ZvjY1yOVHWIevaOB+dIe/REdwkBaAqNuiiiATILNH1aqgauJuhFKuVDn5msxX9ttRM8VpN2qDbl1k29oUa5SwLNQsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYEL5mTnb6kVOqKzJGYLNUGWfI3oIyIKwV7mU+KqBLU=;
 b=Qvj3q6S+kCPxdwKjCTo+UFAE6x5CHUiqs4jTZjQMs+3bpyRMYlA4RXLuml4wVDJnBm6GHR7/9nkwjhVpj/ggRUHif8DxrdVXm1PP+4ALMd7ZAgPnRSTTvzTxOlhOuGEatwR/mRD2vkHw9eFVO4lMITOa+Lzr6u2bgo/+fxXH9U2FfCn3IfWcPaxn5Nbb4qeVUPWnlZCZU2/wsVHpxPXe+CPZ9MjLp0nD/iKOXTPBeTXSb77x3GlOH/EaCnBgoJvxZKkz4Bj3e/lhr1LXO7nmNCGzFb1Kpyp49IUBYpGweWIE/gss2jVC9hSeTouvOzGrYMg2Hbj1a9O2BnFcXGbk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYEL5mTnb6kVOqKzJGYLNUGWfI3oIyIKwV7mU+KqBLU=;
 b=ErYNnP4DCfgSbrhyKpSEC5HUvJ/GeCHanYFBBJcRSShZwWNPdisvsR7BcL+3a0VrDcuQvR5Ek2ZiGNjZ/545/PMKdJVv0aqbyGUBxEutPccBNq6b3GOw7NynoP8zWWMPfdBG6nFne1w4XB+HpwZ0LgJZHDrXRn/Gd4+/fQ0B9/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Mon, 24 Feb
 2025 04:51:53 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 04:51:53 +0000
Message-ID: <2fed54f7-8e6a-4e33-ac4b-7a2a9c1387e6@amd.com>
Date: Mon, 24 Feb 2025 10:21:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/19] cpufreq/amd-pstate: Drop min and max cached
 frequencies
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250219210302.442954-1-superm1@kernel.org>
 <20250219210302.442954-4-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250219210302.442954-4-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4c) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 1208ec8d-3872-4d48-6a1b-08dd548ef4de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXo5SjRNcVpZbHNhUWNNUFVoMVRHVDRmalRyVXJLakdrRlZGMm1sZzFOUVJD?=
 =?utf-8?B?TzhPeFEwTzhseXRaVnFqSGQ4UTVseXUwTEZydVdJTi9QSnJhOWtHdzhjLzNF?=
 =?utf-8?B?QWJnUC9qb0pKbUFNTkFYOU9UeHQ3eHBpbzZraS83YmtrVWFvWkZYV1FVVTZZ?=
 =?utf-8?B?SXRCbVZjU29NYldVdmtGV09Md3k5WHFGaFpuaUgxTVFUdEtlQzRiK21IMmY1?=
 =?utf-8?B?TFN0eENrbVlyeW45NWxLcG5FRUFoSXlUWlAySHRmTVVhM0RwZS9MdzRId2Ew?=
 =?utf-8?B?TVFMMXQyY2d1RTlaOFJPRUcyK0M5VGxKMmNVak9vTFcweXplWThRdVVsTTR6?=
 =?utf-8?B?N1ROOVdYd0lWdCt3NHJzWDh6c2lxWEhUaDgwdm1NT0doOVRKRW40a2FCZy8x?=
 =?utf-8?B?SzhhU3pmVWIycXBUTmFtSGhoTUdac21BakNHVTFMeXk5eXVJVG9NVHh6MHJV?=
 =?utf-8?B?YmNMR3d5NFYyRkpDZndsMk03aXVDclZVdnRuRVlyYTB1MU1OdUtGc2VWVVVq?=
 =?utf-8?B?MkpwWnpOTkVtUkViMjRWeXhGTzV3dDZRdW1FS2JOVEF3ZXNIanQxK0ZCdzM4?=
 =?utf-8?B?dHZlM3UzazlxQThzSlBMUWpMb0k2c01GMlJLb3hESDVFZ1RLeWk4eGpWTjB5?=
 =?utf-8?B?N3hOdEhrMkM1YlQ5dlk4cDRFVjB2aURJdmJPUzVVUk4zSjFLcG9vVjJPQlI5?=
 =?utf-8?B?di9nOUhZeUI0UHJpc2VsbXh0RnhiOER2d3pMNkxGck83ZTg0aXJNY1AvZmt3?=
 =?utf-8?B?b1FKaFA3NVdrVEMzVCtqQ3pEckpPMWtHRmNnOHdNUkU0Y3pkVEVWRzBPMUxa?=
 =?utf-8?B?Y3JoNStrNzZlNzhoaWt2VDZUZWdRaC9WSVFiRG85VlhsejJVRUdMcUpudE51?=
 =?utf-8?B?eHJpMUkvOFJHOTBvaEpZS2E3ZkgraWhwSWlDeWdPSXlHM0JQbWNmakUxaFB5?=
 =?utf-8?B?c2x5NkV0WUltclVCRndmMUtBQ2ZaWlZPeHE0ekFpcGV2blA2aTRXSk1WSDdZ?=
 =?utf-8?B?dGZBRy9lUWVwL0RpSlQ3VDFGUTJ5Qzh1bFRNYmlyYWlscVVQTEhJc0RHRE5y?=
 =?utf-8?B?czZsVjdqdFRXQmFvdXVMMWFKdzZqUlRZVlhUVld1cFIwQi9hU21QOGFKNWpr?=
 =?utf-8?B?RXNXVEpvVWswR3hDcmU5blNZSjZPbHBNL0U5SUc3czdrc3BkM0RQTzlmN1NV?=
 =?utf-8?B?YS9FOTNXWUlQaWZyNTFNalpRak5XcVJQNnFzc2hxaWZSdjMxdjhRUXVDWVUx?=
 =?utf-8?B?SmdJT1VJSm1KMUlWc1ByMnVkUUdXUUYxaGNHOEZBTUd5Q0VYUEF0aXBBSzZr?=
 =?utf-8?B?OGVwaTNtOEgyUXpxeUtuWnNrTUQyRitaeXR5UmkxazJBRk9wUVh0bDdFeUVt?=
 =?utf-8?B?ZGs1c0JVOUFzSGJkQS9rVUlBRmVlVkdJV052eng5YU0zRTNKWnBpWXROb0o5?=
 =?utf-8?B?UHN2NmUzNk5zQ051d1VhN292QjltTDgzVzNUUkhPakhmd1FvU0UzYk5Ccnpk?=
 =?utf-8?B?WHdjbzRiZVpMaEI3WjdpQk01T0VRS2JyZXNiVlppa2c3ci9UOTBVMDU3S1U4?=
 =?utf-8?B?NEpJa2hIM1ppN0lob1dhVUxXaFEyQ2laQXJUZFM3aU0wOGFVRFN6SVM1TUpi?=
 =?utf-8?B?MGYrdTdocUFsTngzN1hwZS8vQlg5ZzFBU3NSdVFqSWZpdktRZXN2MXlEU3Ry?=
 =?utf-8?B?eWk5cHppN3VsWDV0bkVlWGI0Qk9ucmVTVUtMWWQ4THJqQVJjVStZU2dqb0NF?=
 =?utf-8?B?eG5zSGhsL2xYRGc3ODZiQ0dROEJidmZMQTJwRHpRdHFZOHZjdWs3aGJtRjha?=
 =?utf-8?B?N2Z3SlZxMlFLejNlY2pyZy9oV3J4VDBRSXF3bTBDV3NVVE5rZUNMekJDbmFW?=
 =?utf-8?Q?iiSqIIzuTJ7G4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2NGSlVDNkRWamNIRFJHQVE1QVpOUW1GaGdBeDkvNFgzT3p4NlJpZ0dMVkdC?=
 =?utf-8?B?Z3lUdXBLVmVReER0SmFUcmMxZGZES2w2WjFBRm16WHZPWm9iSlBockVCdXcw?=
 =?utf-8?B?WEVUSVlSZkNtT0grbkJCS1NzQ3B1QjgxajRNMTJtdHlpZWZ1SXNXR3V6MDV0?=
 =?utf-8?B?a1ZUaU9ETnNFaFFLTmpzZko2czN3cUNGS3BINEROM3JtQ3kwdy91SVNGS0Zi?=
 =?utf-8?B?dGtaMFFSeGdtSFc2Zm5rZlJlOFdkQ0ZoMmJIMFJHT0dEb2NvbGpDQTlxenYw?=
 =?utf-8?B?TUttcHV1VUJUa2ZyS3AxWG80RmN6NmYxRXRoUG5LWFFzVm50OVBlVSs1alVL?=
 =?utf-8?B?YjhyUWRsTXgwWThyK29vWFlmN3k5eEpkNnVhZEdIRUFBUDdGMTkzQVFtNWlH?=
 =?utf-8?B?T2RQdTdDa2p5VThtSkl5ak95ZWpzUEg1S1NDakt6K3dqZjVtelVPNzZzUGFV?=
 =?utf-8?B?NUU1TTBBLzdleXFqY1lxUnZmcmJVODZYemgySmZCeHkrMWVRMVBseXBubXJP?=
 =?utf-8?B?eHRNRFUwOEJGU0hGQUY5Y2JFOURiMGJHNkxwT3R1ZTFuYzJyTmdib2pKaWhW?=
 =?utf-8?B?VG92TWg2MkJZSGRrQmYwR1VrL3V6cmVRUnN6c1lzZGhVczJVazFFalRhaW81?=
 =?utf-8?B?TU1KWiszb0MyNG1EWjMrbkp4RStMWDAzeXhlOUIvaExMbklBdUpPUkxhOXZQ?=
 =?utf-8?B?aHdtTk8yZGJ2YjhUZXZBV3NWS09JVE95WlQrMVlPbWNNWjBwaGZ1dVd0M2RT?=
 =?utf-8?B?S3FTbm9SaHVib2VKeU94ZnQrWTF3MU1ZK1pnSkhaTTY4T1lobnRXd3BFLzg2?=
 =?utf-8?B?dFV3NkFNWittWHk3aVloQ1NvTnhYTDdzS3U4OW51TmJyWHZ1K2V3RnNtL3ph?=
 =?utf-8?B?eWJNazQ3aHdXeU1VdWV4N3RJdDJNcHcyUWwzbkt6MXZ2OVFUQlY4ZTdvTkJL?=
 =?utf-8?B?ZTNxYTM1ai94enN0MElZck5kL1NYVERPVG12ZWd4UnNFMmpqU0E5NE5UQWNi?=
 =?utf-8?B?QnRiVGtRbGEycW1XaWllcXpkaTZ6WCtEVkpOMGNWeERjWWNHS3lBZzlJNVhL?=
 =?utf-8?B?TGdEQ2RLdCtoUC9Mc1pnVHdyem9mMXQ0Q21Ga3BpNkdjcU8veVJRUkJGcEt3?=
 =?utf-8?B?M2tSOTFvSVp0QjR5cXJqUUY3T0xTYmp4emZQM3BXSytxY05ueDhpMW1sdk5K?=
 =?utf-8?B?ZFFRQ2tIeFFmYURVOS9YeXpENlFqMnl6RUlBWUU1dlAwY3FuUFFlYk55WWVi?=
 =?utf-8?B?SFFxWGdOVjFITUJpQ0FFbU9sZDgrT1pwd2phSTFwYjU0U016OXR6dlJUMXVM?=
 =?utf-8?B?dkNmeVE2UDF2RTRDUHdPcDVRWnNkdFFvaFlLTmJOTzQrci8xTnlkTVhhTVZi?=
 =?utf-8?B?R2xVNFRqNTgzYWtaU3BVTDE0UGtmREh0ZUpxVWtQeVlEdVZJMjBXUlhIQ0Fw?=
 =?utf-8?B?Q1MyUzRiY2dGblBvSHR5VmtUZDd4d3JWZm56bjRNVk9HNUhLUk5FVjRzaXpi?=
 =?utf-8?B?VEJtYUE2aytpMXpKOFZ0Q1NQdnYwczNwZVh3SEpYKzNlbHVkd2dzMlE1Qjdr?=
 =?utf-8?B?TGFuUU04bXNHZWdyMzArT2VkWXlSYWVoWjBaSE5hZitHeThJbG9VRllhcXRq?=
 =?utf-8?B?Sk5FTkRsSnNPTFVGajhqVERJc2s5MDhIV1ZHYW1PdDl6MjFOS2Y2NXgyUlBo?=
 =?utf-8?B?SWtXbVZTU3FnVFllcElCbmpmbTdSRnVna2p3eE5Yd2hHR0JrcEluc3d4S0Zi?=
 =?utf-8?B?MlVLVy9HdTdyTFo2ZUVuOWw2aHViNkxNMnpKMElhSWg5YjRSM0Erdmg0Y3p0?=
 =?utf-8?B?WVpXZEFHRlhPQksyWC9MbnExK3g3L0FBNlhoMHVtbVIxbGlTekdaK08wRFlR?=
 =?utf-8?B?NGJIRXF0QmhmaUpMcG9BdWc2WUc4V3BnckpFZEZDaEs1QXFlQmU2OUZFRGl2?=
 =?utf-8?B?bGVxWlBhWEpJWDc0OWFNZG42N0czeU1UOXpyVHozc0NiNU5uRFp3ZjNmMnds?=
 =?utf-8?B?akliMnQ3TTB5WWpQT3ZTcWliMXA1OWxYbWczWENrRGFWSWRLZGZ0eGtPTGxS?=
 =?utf-8?B?MHcvb0xNUHpER042cHpEblF0Skg4Mi8wSVNFY0NwRExoZ01aWG5kbzFvMDk1?=
 =?utf-8?Q?dxNZOBFhsU1WgvTwOF2RNPaby?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1208ec8d-3872-4d48-6a1b-08dd548ef4de
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 04:51:52.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5aW5QtakEMULEcEJ9TPuJ7OnCUkhu0K12Mh8hPyGLMWaKHCSOUIGA45UjHOmMtC1S4J10yDT8eEGypW4esZ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805

On 2/20/2025 2:32 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Use the perf_to_freq helpers to calculate this on the fly.
> As the members are no longer cached add an extra check into
> amd_pstate_update_min_max_limit().

Actually, we are adding the check in "amd_pstate_epp_update_limit" 
and we are adding it to avoid unnecessary calls to 
"amd_pstate_update_min_max_limit" if the cached limits are up to date.

Apart from that the patch looks good to me,

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks,
Dhananjay

> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4:
>  * Avoid some unnecessary changes to amd_pstate_init_freq()
>  * Add tag
> v3:
>  * Fix calc error for min_freq
> v2:
>  * Keep cached limits
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 14 +++++------
>  drivers/cpufreq/amd-pstate.c    | 43 +++++++++------------------------
>  drivers/cpufreq/amd-pstate.h    |  9 ++-----
>  3 files changed, 20 insertions(+), 46 deletions(-)
> 
[Snip]> @@ -1550,7 +1528,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	u8 epp;
>  
> -	amd_pstate_update_min_max_limit(policy);
> +	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
> +		amd_pstate_update_min_max_limit(policy);
>  
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>  		epp = 0;
[Snip]

