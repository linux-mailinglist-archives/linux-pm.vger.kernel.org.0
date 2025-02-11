Return-Path: <linux-pm+bounces-21772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C5A30309
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 06:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51ED188B676
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 05:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671921E2823;
	Tue, 11 Feb 2025 05:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jLWJFWWj"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADBB2F5E;
	Tue, 11 Feb 2025 05:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739252824; cv=fail; b=Q01YZXQj7HRAJnoeexxl+IIopXLeZWuSo7kMce17cY4M0B3XqqAQ499q7A0tvGqQyqvcP9ATvVYOkl6HcfUFCgfaOtdxEaGx6UoxAHWD233zwiOtPKumhvSEWv9XNrfMekzCylzl6aK99C5NAMclfzFe0mHaDf2FL6AYmeR/Mn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739252824; c=relaxed/simple;
	bh=3mmD2xJ2Orsg6zgxlSYUVoj0XYR0RhjXLORQDsEResw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JmDyiino9XrPgE0uAHtjAZlaozRwBIzI9r99tWO8C4EApozUU89L6nXT0P3Utw5SkHFup5Py1J/9Uc7uervILTHWEEqq3OYnod/FprwOWkQjo4GqUrWihkQy3bBWk/nZRJ4XplT9K8CZ9eAd/got9/BHNhsKWfPMx5NunbALrnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jLWJFWWj; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7JuJaRNw4M64MSZn0qT05P4db9XX1PCcwtRELJIcgyq4EgYMpHwrwhi3TT+9QrdtE+IKHMz6qD1qi6nNwxTQChB6hVFR05xSXGUcusA/M8RMxVLbb5EU+3UK4Co3HVbstpHQYjr8wEsntHCVTfIZ00RxAtSilkVvcLDuI89ezMjOl3xgh90xD6UhlnNBfBJ5tJoN+53dB5uzNsw1ytPhZ/JH0K7rFCyDzKRWK0G7qtyg6M7PgXkdvFsJQYc1nfOlVVBLHn2ia1xpMdjoBYIfRKcHcG3igE7Nui0xYSpFyrf5IcbrjkgyQhLr3TUO14SCV/vvKsHVcjANpgNDdvtwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3GIymWxtV64qUA9VqdH5wIVqD3an7DSwmzfWzZkx9A=;
 b=ZWPquteKc3ndQv/lKmGJ0Ov7vAEW028wqhNqyQdeXsLsTFoEFJCFAWqVvEZxYuO7oxebnNZJ+oikzzCUCAx/hebQBcBL+HlBaBeyL0PZZ8NCLGK7ajA4FWhHv8LXvru/1LtiFwCt4vIFcohbRpftVqnpNK2mJYf89BNmQ3DNXw7r5EQImCLP+QAEDB+5Ylq3NWOghJF6R4SzyrtrzUdlxrjsKjDYcpzPsk1XO7FQoFruoNxmjUeeIva9S+1fCMdTba3YALUnJ4Mv32YqhGuUYiEeJbCM8SSozeuYeWSNPlus5KvXDL78HtYABSqD81np+DKr4vfs/44u16XT8BTUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3GIymWxtV64qUA9VqdH5wIVqD3an7DSwmzfWzZkx9A=;
 b=jLWJFWWjYi6OVSXk98LAGC7RsBQ3lZQtHgtt1PBNvZzn6WG49S7NA6KS97NJR3G8vUwyVpXvBAt+VeZDIxmPqEVxDKDnK8iEvKJ+X1YMh7vXJOr0e7YjZl3yTj+73SwA0Tt15YwEsqfPTQJlqELHX1jeL9Edcf3XgCywGbAthEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 05:47:00 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 05:46:59 +0000
Message-ID: <66346ce9-8b75-4642-a755-22591188784f@amd.com>
Date: Tue, 11 Feb 2025 11:16:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] cpufreq/amd-pstate: Drop `cppc_cap1_cached`
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-6-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250206215659.3350066-6-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::25) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 7237b901-afd5-458e-ba3e-08dd4a5f8087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sy9CSkxtNVlhV2oxaVppdUlRRlNobEJydkc2UExJc011Y0lzaGJsS2pLSFlI?=
 =?utf-8?B?WVhVaWpqcHI3OXBZTUVPYmdtcDA3cVowVWh0dm44bnJBOTR3UXovc0p1YldN?=
 =?utf-8?B?d1V5MkdlNGQwYk1pdm5VUGVJTUxTTDlPQ3p4TGY5TWNXbExqV0lnYTBxY1Bp?=
 =?utf-8?B?WkN0NS9DVGs4T1BadnpzRnlCSmgzd2MrR0g1UEZxc0xyUm5QN3FjeFB2bnY2?=
 =?utf-8?B?QmRSR3d2b2dzbXdsOEdYbzU1bkRqM1ZoM1FtK21KYU5TRkYvM2VVUDhBZmp4?=
 =?utf-8?B?R1VKdHF6aFZFajg4ZUJzaTNpbEZIYTlZandXdks4RVBTNEZ5b3dmL3ZDRldX?=
 =?utf-8?B?aDNkWVJqdWI1eWcwcDgrcEVBQUpHN1UvRnRDVWFRT3ZaTUZqNjhWUGREZ2po?=
 =?utf-8?B?MGsyZGxlRUZmL0JhMzhwbzh1VzhGZXBpdVYxRS9VZUxZVFJ0N3lIb2FURGFH?=
 =?utf-8?B?U24vZG1VcDY2c2FEaVUreGszbGJmZDd0ZERMa1BSTnNXdDRjUk9EQlBVY0Fy?=
 =?utf-8?B?MTFsS0J1NzA4Vkt6dzM1WUwvMTViTDVKb2c1bmdsbkhRdDRNKzdpS25RMXNj?=
 =?utf-8?B?UVlHR3F2d3E2cGRhSDVsMEh6L2tUKytsc0N4K1RZLzlrYTJYL0g1bDJnd3lD?=
 =?utf-8?B?R2pvVXpSUjExMGNFOUZkL3MyT00vRlpBN1dpdVd4NjlCOVMxay9SQlRNS0Yr?=
 =?utf-8?B?K3J3ZUY1Q3AwTDQwMlY5K256WU1HK2I0SUxpKy9rb2gzYTNWb2FPT2ZYWHBT?=
 =?utf-8?B?eDdMWkNDTkpHSDZyeXoySEorNXFJYjVXWDNSa2dRL0tnQjAwMEJZbXRlTVRF?=
 =?utf-8?B?U09Ra3dONk1NVlFrcEZySnY4M2szT21zaFdHN0FCc2ROMTBuNkx0bVd1dnoz?=
 =?utf-8?B?ekhjQVNPaVFpYVNFTGg5U0huWEVlK0FWd2hXQXlMeVZUUzYzTFM5US9CY05l?=
 =?utf-8?B?dGJsbWdld0g2S2lQb2RKZzJyTDJhMjNJSDVkbDVjbnhDVm9IVmI2YzNiS25Z?=
 =?utf-8?B?bEU2a0U5cmtFT25iZzRydlVWZDZSc1RTK0tuVi9FaW9vYnpGNFhFM0l6VW56?=
 =?utf-8?B?K3pUeWZRYWR2V2pqaHlpbFE5eUNhNkRWczlKRHpKVDNxaGtzTjJydElkQ1lI?=
 =?utf-8?B?b3FPWXI2MVErTm40ZXpLbGU1OEl5Qm9yRU1GZ3ZoVVBJcHhsdzg3MVMzYk1L?=
 =?utf-8?B?WkM4dmVFTU9IS0RhY0FiWWowVkRiMnplR0J5dkh0V2xoT3A4NmhZN3orSXFF?=
 =?utf-8?B?ZG9sUDV3aytjOVBnYlVsS2lwaGFkZ0R0aS9pZHhJZHFINXZnM0xJT04zMmpI?=
 =?utf-8?B?NzJiVWhjQUdQS00xMDZpbm4zREMyQ3JYeFduMVdla0h0MmtScm5SVUNlSnBt?=
 =?utf-8?B?R2dZRlhDczI5RlVPcyt3bGtBSncyZk9ydUJ6MkR3UUhnZzZqMi81NDhkVmth?=
 =?utf-8?B?NUs4UDB5U0JheUNUQzZNcVRUdXVYd2RFSmg1R1ZOVnJBUk5RTmgwekdPbXNV?=
 =?utf-8?B?RDI1emc1dW9zT0RYU01qUW11Q0pkcnB4ciswaWU2MU5UUGVqMkVaTXBDL3cw?=
 =?utf-8?B?SHg5RElsNFdVa2RDK1ZUemZkMXdaWFpYb3pJYzUzWE5jZ1hxTDZ5djVLRkpR?=
 =?utf-8?B?UFF3VkNGSUd2Z0dvcDNBVDFiM25EOEtpSm93VUxPWUJxRFNzWlFNQmZiSCtY?=
 =?utf-8?B?OEx4UTJqY0dCL0hoNE9JRC8ycXd1dExUTUFoakMwUnJidlQ1bzVabzFOMzlX?=
 =?utf-8?B?Y3pLYkE4STZoUkgyWXBYck5JNjZFb3FxTG14YlJ4Tk9Jb1JvYzdsZC9JWTAz?=
 =?utf-8?B?cnkzVytpcTMrOVI0WlZMaVQ0ek5qL0szbnBscXBUVWlTVktvc0xzVzJLU1lU?=
 =?utf-8?Q?k3bHjrRlyi2VB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFg5Z2N0RjJtQzFydk51NGp3Nlp1bHJldUt5bkxpWkxCY0RrR0x2QUdTZEl4?=
 =?utf-8?B?WXZQWkYyR2pXbWt1ejl5OUVjOU54bCszOUZmSXc3ODZvb28zZzBzOGQ4b0VQ?=
 =?utf-8?B?R1BPWEc3VjdFYnU1MVJUREw4VDBmQzJGb0JzUmErVG54UnhReTRLdVBPQ2tT?=
 =?utf-8?B?bjJielN2VWhhQVM2ZDhXZ2dYaGxZekNuQW85M3hmMUFTL0hzcXdyT28zVXdy?=
 =?utf-8?B?MDNERFJTMUZZUm5mdjhVUy9UdEk2bmFsNDhSNWlmaVQyZWJMb1Z5Q2U3QTk3?=
 =?utf-8?B?NXVmc3U2NFRjb2VEUDFHRWhoNERkamlqeGZFamRYRmxRcXAvR2o2NVpNZUhh?=
 =?utf-8?B?ZzZYcVZ0ZU05amNMYTI5Y0MvajBBUWpYdHF2Umt0eFluR1RaN09VRjJBdXM4?=
 =?utf-8?B?VHE1RC9TSWt2SUlLYkpDakdVaXpqQU5nbTdTdkZBVG5RWjR4U2pwZGlsbGow?=
 =?utf-8?B?WEdXWUNiT1dEZXZvSzJOSFc4TzR1RlNINjZNdk15TmwrWWVHbnZBbUExUEdB?=
 =?utf-8?B?Z2pud0Vsc2FDWDhmMmR2TXIweEwxUDJudUE0NVhDZE1LazNMS3E5VlJiRk5C?=
 =?utf-8?B?dzFhZEFWNmljUXNIUHB6RU83cDQxeU5UTHlFTlFzM1ExL0pNWlhJUnR3ZVNr?=
 =?utf-8?B?N1VEdld3WjlzcFFjREdxNDM1YzZ0TUd6TkVkMU9CMldkbDRvMG4rb2lEUi9N?=
 =?utf-8?B?UG5DR0Q2aktJOXBmcE1XV0lXSDJEUlB4dTA1VzNsR0gzcEY2aDB3N3l0UHZ0?=
 =?utf-8?B?aUxlaU5PY0h2b0d2WlVCUytPQlpPd3VKd3lnd2t4Nkk2SlBoOE9ScVVIRHUz?=
 =?utf-8?B?VzlxVnQyUUl6Nzhzb3pVcUdTN2RraHpoNDRxbFRxYmxMUmx2WVg1ZVkwVDRJ?=
 =?utf-8?B?ekZlUS8ySC83c3BrSFdqNjZTZEg4dVoveFhEdStZWExuTFdLbWFFWlRJSk5H?=
 =?utf-8?B?QUNNM2cyS3JPZFJ4OHpiZzc5bXA5QXVVbEs2NElVMjJUV2dRMEtoSTJvNGxX?=
 =?utf-8?B?VFdRUVRhUFBGVklQQzFXYmJnZllScTN0cUY2R2tlSWw4WnpURXBrZ0Vma1lS?=
 =?utf-8?B?MkdoWlRYQ25xVHFxWm9tcElERmRyd1Fjd2FnaVU0RS9iWWU1d1ZnbUhGSElZ?=
 =?utf-8?B?TVVUdVFtMC9yZ0xRekdQZDlOOE5ZdFAzN3EyN25ZSE9NUEg4Mlc5RndNdi9Q?=
 =?utf-8?B?L01YK2lDYVdDTWRkc0dOYjRBZXpsREdSU2FIYjZwMEZDcWRwdGFGQktQSkZr?=
 =?utf-8?B?Ylp3aWFBSzJ6SG5qM0p4ZzYwZVBPQlBpcTdZdXNDUTlqL1BLdGJxRHI3c2Zu?=
 =?utf-8?B?dEZTdmpEN2xISk4rOGJLRDE1SHVWS24xeTU5V3ZiWWFza0MxYzZVWDdUWUdi?=
 =?utf-8?B?TmFQczVJVzRMcDh4aGtTYkJQYzRzODJZa215TFF6Q2Zhb0ZyL3lGT0dCWTZD?=
 =?utf-8?B?ZUZMcnJTUnUreDlaYnVXakgzZUh2Qkd6YzdGY3praFNTUXRQQnIvd2k3b3BU?=
 =?utf-8?B?RUI1dlU4VmdwYUJXMyt4QUxzVXMwSHNuYWx4ZzUvVitUNVNaMnBzb01LTUlF?=
 =?utf-8?B?SXhLTWdzUS8zcG9QWGlubkxNd21pVEhqZzgvd3ZxSE9EQ0pIYjNOMnNWRm94?=
 =?utf-8?B?aFNaMEJhOTNudlV3ckdJUnlFbW9BUjJIcUNmeTFmeXBBeDdhS3BXVVJFaXYx?=
 =?utf-8?B?eHdBTm5OSmpyYlVUY1ZsdHpxWllvZXJyUjhOK3crbWxrR3lhQVdkSk5RL2x3?=
 =?utf-8?B?TjFrSWxOaGFDS0Ryc2VnbkxMYit4WGJuZ0krdHB6cWY4OE8yYXlKNFZqL0c3?=
 =?utf-8?B?VEprUC9idE5sV2pGaUF3RFEzbkhWVkhiM3U5Y2w0UlRUcHI2VnNrKzlod3dG?=
 =?utf-8?B?THFYS3hmbVZrUzAzUWlVSk5Xdy92d2RnUTFDTHZvVkZJTlVTZ0h6YUdBWkRi?=
 =?utf-8?B?YXkyUm9KQ1VZQXVFbUdOUkR2ZW1sbDF5cnBJd1llZStIU2RRcTgwRndYR2s1?=
 =?utf-8?B?UDZQOVdSNWt4RUhXdy83akVabFJMMTd4Mm9OS2hkcWtNUkU1MFBrQnB6cGVQ?=
 =?utf-8?B?ZHBZaWdRbkIvUkRQMXZLZnNtSmF5N1M4RnlHMS9CTGhUTDdMNXVSaFlnTjlG?=
 =?utf-8?Q?HVo0lHnQuPtI0UYWcFnLQ/Jt7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7237b901-afd5-458e-ba3e-08dd4a5f8087
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 05:46:59.8514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMzPKVQZ92LgzI5ARXxfOmugGFvkjlth7AvBfr9qfanfs6vEKlMXfTJRLQqjwreaXK6wB6D6cnA4cohk9dOVQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446

On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The `cppc_cap1_cached` variable isn't used at all, there is no
> need to read it at initialization for each CPU.

Looks good to me,

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks,
Dhananjay

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 5 -----
>  drivers/cpufreq/amd-pstate.h | 2 --
>  2 files changed, 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index dd230ed3b9579..71636bd9884c8 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1529,11 +1529,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  		if (ret)
>  			return ret;
>  		WRITE_ONCE(cpudata->cppc_req_cached, value);
> -
> -		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1, &value);
> -		if (ret)
> -			return ret;
> -		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
>  	}
>  	ret = amd_pstate_set_epp(cpudata, cpudata->epp_default);
>  	if (ret)
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 6d776c3e5712a..7501d30db9953 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -71,7 +71,6 @@ struct amd_aperf_mperf {
>   * 		  AMD P-State driver supports preferred core featue.
>   * @epp_cached: Cached CPPC energy-performance preference value
>   * @policy: Cpufreq policy value
> - * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
>   *
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>   * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -101,7 +100,6 @@ struct amd_cpudata {
>  	/* EPP feature related attributes*/
>  	u8	epp_cached;
>  	u32	policy;
> -	u64	cppc_cap1_cached;
>  	bool	suspended;
>  	u8	epp_default;
>  };


