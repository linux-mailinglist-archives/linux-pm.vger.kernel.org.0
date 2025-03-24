Return-Path: <linux-pm+bounces-24446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F75A6D849
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 11:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96A087A5AFE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 10:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F01E1A317E;
	Mon, 24 Mar 2025 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JFx96r6w"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42642F507;
	Mon, 24 Mar 2025 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812262; cv=fail; b=OXRk7lW1Mh62I/SWWEROtOIGgIuhvu4XRvzdV4Wxqcfj410bqNmOhYlnNmF2PGTCqBAoHKITdLh37e911NkS95vOXJz9Q1wIKAUHiliLY6y1CNOV1cr3cLx9o3+AWohFqiCTxejX7PaSXteOyVFjGub0/tUZ7tP55y9nZPLCPjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812262; c=relaxed/simple;
	bh=gzIT6T9RUzerywnWsCI266mVp7zwGrQDDyOKpH55SaE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SoXcgc9maUaEP+DKnZCACklxPK1KqnsGoA3pLG4TTOllAwXH1N4wUxU48RP8TbL/HQ3Ts/aMQ+N+/Hy6tsIiZJeACO/xyFI/yOLbdPNPNXwy7DUK3OlHRG+m+vEh9MrkHFMyqCjfZghL7u90fhD/3vMycQnvjCUQJhy1FKCMctY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JFx96r6w; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg3QZPQtAJNB7pWVnbzydUTGpzs3w9q4WURva0lo3TUtoz4Kbfm9oMUtIoWpZFkBt0iXanaFX5FrScuqIv9lh0/8+52YtvGEg3EleYc62MrT5pbnebTjr37ZHxgEkOasMWSmWv5+h3x+novT7nuesfU6VdlJcUEfPSfg9GjRSD+x3LAxSLnH9skrQhuZQtR+kgNxRsgnr/gCBthI2CU/wYVeL7lb+/oZWnhGTAxQjaq0kvOvZJQ20lgxw7Bmq1jm1/3D6x05XtjJUQqsIgE10cwRUlOIF1cf4Iq+BtmtzwtqdbJ8vqGgZM74MnBq2FO5BnjRblPgNmoXu27Bx4V4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZUtoeic7UV5v/2dtmJz7wLYJ8IDcN0MzfB31Vqht/4=;
 b=sKwBw9aHqbFK6eSNBchb0btd9KBqZJb5Gy+ttGx2BIqXDvU2akPGJ1ISl9bOIn/K5RTm+ucaocoxSVMgeuFWy4x4gWE4NMq/YjZ2FqNbcLNmhCXVMLAMcByr4yJXgbbx7BddSTHiMATB/aE6VOjPP5H4VBj3tAfKjz4uSDKX8D38/dp7Hyo9BmL0uhOmrdx3/Tbwjlw4sBPaP0Pos16Qzs1+QprujaQ5tdjyiT9Ok3XrC/jXrAag7lPUPuhYMDmxlAQnkjZZl24LTaT6CTWflc3X4PkzBz6oY/WiqOwzuKz5vNiux/jRCDgnkTJExYiT7of8+r3e7b7Q6b5NDM6nNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZUtoeic7UV5v/2dtmJz7wLYJ8IDcN0MzfB31Vqht/4=;
 b=JFx96r6wiIGNFuMF7tkCABE/bWnAf+UVa4bdnv8R0wVXbiy5NxH05wfBZRip/BaGkxQ+dfYB8zqKJazVoxlX5SWsqmqFNSgGgG3DdmXeu6L9zKzTk6DDUvZdR99Jjx5/kA28x9ELqeN+fYIkFNyvnReL54YsOBlkq/+DlFjzfO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 10:30:58 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 10:30:57 +0000
Message-ID: <08e3b020-ea5a-4ba1-b817-0746a277669f@amd.com>
Date: Mon, 24 Mar 2025 16:00:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] cpufreq/amd-pstate: Add support for platform
 profile class
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250321022858.1538173-1-superm1@kernel.org>
 <20250321022858.1538173-4-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250321022858.1538173-4-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0247.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::14) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5a84db-f836-4d56-74f9-08dd6abef6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVBiWnUzbCtMcmI1Q2E0dGRETFlHVlFKbmF0ZTB6U1VCclE0dUxzT0oweGto?=
 =?utf-8?B?K05teU5jajJ1eGFBUUtSeFlObFJlcFpvalZ0N0ZvQzlqZ3BHUjNYN0R4V1hp?=
 =?utf-8?B?VmhBRUJab2ptTmdwU0hvS2V3S1FRN1Z1dndUQytoNGpXcUE0ZktWMUZQcXl4?=
 =?utf-8?B?WHNSbkdsSVNoWmRvT2YvNkhGREwvV1IwY1hsUjlrT3BHUzJFUDRoaHpTMWZN?=
 =?utf-8?B?aFVjdS9CWlp6Ui9oKytFTWlOYW1oRGQvV0k3eVYzZVowOXpSMFM0VXJXN2F3?=
 =?utf-8?B?c3NJSFBJSVY0anBheXJtYVRXNzZGY3NXdm1ZcGZzY2NLQlkzYThUYmlJN2Ux?=
 =?utf-8?B?Wm1sWDQ3RjQvR0ZvaE9ZN2RudVJrV1VWUUdSOStEenlLS3M0bDdjRTdXOUlB?=
 =?utf-8?B?ek1pblVMVDYyNXFMd1dSUmZuYndVUWZVS05oUjFqVlRQamE5bXJBQTlSNE8w?=
 =?utf-8?B?TGxMclNENmc5T0ZjVlpOVUV3cFBpdnA3dU5rbmRHdFdjWlk4am5jaEVkNXZF?=
 =?utf-8?B?TEhabmhBaWhseUY5NnJxNFhWTGtEbUxUVWdFMEM4S3JpMWl0cVBDdCtnNGdj?=
 =?utf-8?B?MFdDRWtTbW5NVGFOM0x4SnpXb2tMVHB1WlVJSkxzampxam1EVm05c0NYS0hG?=
 =?utf-8?B?WHkvaUNyS29zR2xzaGpkQ0VJZSsrNVJqVm1jWlpHZ2ZwM25GbW4wQncxdFVn?=
 =?utf-8?B?TmhBWDEyQTVST0FZNXprTHUrRmNCR0J6SmNSbXZHSVdRQ2dzYVJ5NTJCN0xW?=
 =?utf-8?B?V1ZLRXJMT09jMUE3b0V6cnhzMTZIZzlNU0s5ZkI2MDRBcms2VjNZWmo2WlRH?=
 =?utf-8?B?NU42WHRxVWhIYStsZXhhMTJsQ1dkWm5NeGkwdUE2MG1TNnFCbmphRDFIT21D?=
 =?utf-8?B?UzdIR0Q2Ym4raExDcDM4RW5aU0c0d2hudW1mSnlmYWVSaWNQWS9uY01rNDhD?=
 =?utf-8?B?bjBJNVVWazZKdlFpc2JJWTFGU0hlQ3JkaWFwQlMzUjQxRllJTk1nMis2aHpJ?=
 =?utf-8?B?N3lBZC9aL2tJdjRaekVPQzBOeVNBSXd5bkFiN2FLVEJqWVlYdURnZCtBRUZr?=
 =?utf-8?B?NU9KUEQwRG83SVVvUVRXSTRSb1NrbXhEbXBqS0YzckxRZVJ2bmJyRVBNWS90?=
 =?utf-8?B?Y2FHamlwellRL1NuMkMzTGZHQmpUcFFhZUl6b2VRZDliaG1xRmVCTmFnREs1?=
 =?utf-8?B?aHVXVDE4bUNlNHpPdDZxU0xwR0p1VmYrMXBqZzBBTlhxbFBCMTdNSDB6WXpx?=
 =?utf-8?B?VTJSS1QrSFFjalhsOUFtMlA1dUdqOXRtYkNucm8wZzg0cUlQQk9JWndVL3ov?=
 =?utf-8?B?bjZlUDlkVVljbmMwZDhpREVoZkxwaUJTKzNmUXZReDZiVHkxR0FJWlZsanQ4?=
 =?utf-8?B?MjlnUnRjQmlyam1TY2FqaEFyUFZvRUJSWk5uVE15a29HV1ZlVnNjSmo5MjBW?=
 =?utf-8?B?R0ZmOTB1dmsyUnUrSmdhb0NWemRDU3kwMXFpcWVpNWg3TU5aSTZIZnNqRDdV?=
 =?utf-8?B?cWcxZU0wK1VRNVk4VWxCNDRpME8vT1NlZFN0alBkMUpyKzFLOWFwQjNDdWFn?=
 =?utf-8?B?bEk0eVY1eVhXd0dFa0tKWFQvODhlZmlGT3pPTTVEdkRHUk80ek1NZGpmZ3Rp?=
 =?utf-8?B?NFR1LzJnSXFYbjJnWmVsQzZUU2dYeHUvTTN2UnNadzJSMHBwaDVWeENjcE8r?=
 =?utf-8?B?N3R2bkc4UGJhSXA1R29WemJhWmxVelRYZytOUjJYTUwwMHpXdlMzL3VJUGw3?=
 =?utf-8?B?TElnVk9VVVRsZDlhTkJ5WXRBRmQwRFMvSzRGMGlQL3R0UFdLR1dLK1NscW5X?=
 =?utf-8?B?T1V1VHUvZ285T1dFTkprRC8wWjNXczhURzZ0MmQzM29hKzhuczRzVGVVK04x?=
 =?utf-8?Q?EVK9Py99v2Jn3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmdjeHF4TXBvaC8wUEtjd0tDT2VjSk9sR1FUQXNvelVvWDBYa080N0VIdlZR?=
 =?utf-8?B?QXg5eGRqdFZ3Wk05YjJiRlJmcy9MVE5IN0x6TVNwangwWkhSWnVDN053cWpx?=
 =?utf-8?B?aFgyVWJMeUJZMlBNaEE2Vzc3YW9qaGtRWXRLeHVCSGVaazROanB5eUhpR3ZL?=
 =?utf-8?B?NFJwZjA2WnpmVzBsaFVDYTVZbjVCdS95WkJFNENLaEI0LzdKUTQ3dHBTekNZ?=
 =?utf-8?B?T0psZ25jeHJUL0Y1NDVKY3UzLzhMV2pDcU9zeU9aUi9Xa1BKQ1lHU0JkRy9L?=
 =?utf-8?B?QktYZXVQRFNPdDlHK0haZjlZZlJZRmEvK25pQkZ2cGNtTFZlZW1TV0tWSWFy?=
 =?utf-8?B?eml0MnRvNWJJV1RmTFl4WjlxT3FOZkZOdmtaTzdiaWhTOXM4UnE4N25EVVZm?=
 =?utf-8?B?WDhoQ1dMVyswUmsrNU9ZWlpJcUwyamU5NW1LUUQyN1ptWnE2cUk1N2lQY2tS?=
 =?utf-8?B?VE9mV05xL29pTCtwNUEvN1ZTak5uYThPSUMvTlJFdkRFOGxVM2RaK01RTDlF?=
 =?utf-8?B?Tk1jdU1nbEZLdXVBM2I0WWI2TGFmTG5LdWpOQ2JzTVMxbTUwYk8rKzE4QVpB?=
 =?utf-8?B?bHVrTVFiZVI4eTZ6OVI1Wk9wVFp6d1V2TmF6UU9EQ3VNTjlDY2tFaG5ONENL?=
 =?utf-8?B?SjJHYzZWV0NiaEFtNXhweHVwbnFNVlBlK3RxdEJIUjYvRWlhQldwbXhtZ3du?=
 =?utf-8?B?YW9DYUpYcDlEajZLdE9udlE1blFabCtpdHJ2M0RJWDJNQVlBQ2xuVTNXelRm?=
 =?utf-8?B?QnRVaTRzbk1KNDJsMkpWR1JIUVA0VjVKUlZjdHpwUTRxUmNhOStMZkFMa2px?=
 =?utf-8?B?bDhPN3JrTEtzUVE5ejhNTktHeFdacTJEVzdrZkpzLzhtVS9Zc0FneFFaM2ZF?=
 =?utf-8?B?TUwyS0dFcTArSDBTWG9yTnJVUnFkdDFEV2JOd1RRN1BCa2FVM0pOTmMrNDlm?=
 =?utf-8?B?d2lPeERjb1JzdnVTNlk1dmNCOFJyeG0yLzJHdGF1ME9kaUdqS2tNNTFWRE9U?=
 =?utf-8?B?RkFDTE9CdnNrSkkwaFZpK0k3QlpoYW00eXBFcGxjSFVHRGJ2QlhHVHRON1J4?=
 =?utf-8?B?QUxsZy9Wa3l5QlhPcld1djRGOGxRRldzRUVTQXBHa3VzNm9Hdncwak4zRlVX?=
 =?utf-8?B?aW9MT0JNTGNWRVFYeVhBbFI2dWswZU9nUUJSL3BHOW43TWlzWTdkVkxCQ2dm?=
 =?utf-8?B?b0Y3VnJuemszNXpsOEVkcDBwcXpWV1pJSDQxMDZ4bEZmdkpib1lPdS9YT1Zk?=
 =?utf-8?B?Smo3TkxzTHVvdGNyT2JuWXZaa2NOcjRwOHFEbzZ6dHpudGU0WVZYTWdtYmN1?=
 =?utf-8?B?QmR3ekhZV25IME1SZ3NETTIzemMrRVdnZ3Q3SnB6bUhNTnpwU2IxTy9RU3Qv?=
 =?utf-8?B?UFFaL2FVSitLb0VMY1pBZTVGYVB2K205ZEhMWnlUTkVlVFdNMk13Nm1GdjB6?=
 =?utf-8?B?RGRsbEZEVWppOUc5T2dCOUJkQ0o5Q2RYQ3REVFQwYnFCNW9vV3RKM2tlZTBi?=
 =?utf-8?B?ZndqcmEvblppeEdNY1poSXFuYjd3aWVIZWRPOHJ5UGlCUVlibWlRbTFtSHNr?=
 =?utf-8?B?ZUo1QzljWWxwbUNCUThiSG5QeDdmVmV6cFEwRlZSVFFrOHJSY2Z5NG5saGh4?=
 =?utf-8?B?UFNvdXJXL3puMUZNaDk5TWhtakJnMzBiaVZXTi9EY2tVMCtxbnVUUkZZMmFn?=
 =?utf-8?B?U09kV01QaXVPQlhuTHd5NWZqRkt1K2U0U09GeUt4VW55ZkNVUUpOVmdsY1JV?=
 =?utf-8?B?RG8xMFdkRzZTTEZUem10UkV0Wm5JVzBGaWxyMWZ3d0dPTm5ZelVkTGtuM3Bv?=
 =?utf-8?B?NHpTODBBN2lEV0RYMng0bStkU1NFVGdzY3pidnhxNDJYdG1QeDNaVllLUGd4?=
 =?utf-8?B?QkJpQlRwNTVpTHZwQ1FWNTBKOHdsbHFKVGxzMWFHeFh6YkJ2WlozOUJsMEhy?=
 =?utf-8?B?NzdYaVV2MDB0MjhCeUpQS1lkcDZPek83M2d0aDU4c3VHSmZ3RWZUdWExZU01?=
 =?utf-8?B?cDB2eUdyYWRYdDl0VkoyOTZwQkM2VThWSlB3NXFya2JDc1RmR1Y3cWxkT2Fi?=
 =?utf-8?B?bHVjSkpkc0MwazhDY1dZbHpETlRHSldwL3ZqUUZVYURuaXNKeWFuMHBGZ2xZ?=
 =?utf-8?Q?AK6FwRCe3QIAGN8PdEB5cIrAa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5a84db-f836-4d56-74f9-08dd6abef6f4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 10:30:57.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOSQrYaFnB01AgKw+2YsizFnbBBbkx5LpZUKD2AdopP+k5FGqTNEFL3Z6bV7AuIdlg7PLExBZp83wksVmMif5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230

On 3/21/2025 7:58 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The platform profile core allows multiple drivers and devices to
> register platform profile support.
> 
> When the legacy platform profile interface is used all drivers will
> adjust the platform profile as well.
> 
> Add support for registering every CPU with the platform profile handler
> when dynamic EPP is enabled.
> 
> The end result will be that changing the platform profile will modify
> EPP accordingly.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst |   4 +-
>  drivers/cpufreq/Kconfig.x86                 |   1 +
>  drivers/cpufreq/amd-pstate.c                | 142 +++++++++++++++++---
>  drivers/cpufreq/amd-pstate.h                |  10 ++
>  4 files changed, 140 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 8424e7119dd7e..36950fb6568c0 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -321,7 +321,9 @@ Whether this behavior is enabled by default with the kernel config option
>  at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.
>  
>  When set to enabled, the driver will select a different energy performance
> -profile when the machine is running on battery or AC power.
> +profile when the machine is running on battery or AC power. The driver will
> +also register with the platform profile handler to receive notifications of
> +user desired power state and react to those.
>  When set to disabled, the driver will not change the energy performance profile
>  based on the power source and will not react to user desired power state.
>  
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 3a8bdc35f488a..8fc8319861bdf 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -40,6 +40,7 @@ config X86_AMD_PSTATE
>  	select ACPI_PROCESSOR
>  	select ACPI_CPPC_LIB if X86_64
>  	select CPU_FREQ_GOV_SCHEDUTIL if SMP
> +	select ACPI_PLATFORM_PROFILE
>  	help
>  	  This driver adds a CPUFreq driver which utilizes a fine grain
>  	  processor performance frequency control range instead of legacy
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8172bd4b5952f..2a62b12148544 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -109,6 +109,7 @@ static struct quirk_entry *quirks;
>   *	2		balance_performance
>   *	3		balance_power
>   *	4		power
> + *	5		custom (for raw EPP values)

Should we move these "custom" changes to the raw EPP patch ?

>   */
>  enum energy_perf_value_index {
>  	EPP_INDEX_DEFAULT = 0,
> @@ -116,6 +117,7 @@ enum energy_perf_value_index {
>  	EPP_INDEX_BALANCE_PERFORMANCE,
>  	EPP_INDEX_BALANCE_POWERSAVE,
>  	EPP_INDEX_POWERSAVE,
> +	EPP_INDEX_CUSTOM,
>  };
>  
>  static const char * const energy_perf_strings[] = {
> @@ -124,6 +126,7 @@ static const char * const energy_perf_strings[] = {
>  	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
>  	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
>  	[EPP_INDEX_POWERSAVE] = "power",
> +	[EPP_INDEX_CUSTOM] = "custom",
>  	NULL
>  };
>  
> @@ -1077,6 +1080,10 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
>  	if (event != PSY_EVENT_PROP_CHANGED)
>  		return NOTIFY_OK;
>  
> +	/* dynamic actions are only applied while platform profile is in balanced */
> +	if (cpudata->current_profile != PLATFORM_PROFILE_BALANCED)
> +		return 0;
> +
>  	epp = amd_pstate_get_balanced_epp(policy);
>  
>  	ret = amd_pstate_set_epp(policy, epp);
> @@ -1085,14 +1092,84 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
>  
>  	return NOTIFY_OK;
>  }
> -static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
> +
> +static int amd_pstate_profile_probe(void *drvdata, unsigned long *choices)
> +{
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_profile_get(struct device *dev,
> +				  enum platform_profile_option *profile)
> +{
> +	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
> +
> +	*profile = cpudata->current_profile;
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_profile_set(struct device *dev,
> +				  enum platform_profile_option profile)
> +{
> +	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);

We should add "if (!policy)" check here?

> +	int ret;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		if (cpudata->policy != CPUFREQ_POLICY_POWERSAVE)
> +			cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
> +		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_POWERSAVE);
> +		if (ret)
> +			return ret;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		if (cpudata->policy != CPUFREQ_POLICY_POWERSAVE)
> +			cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
> +		ret = amd_pstate_set_epp(policy,
> +					 amd_pstate_get_balanced_epp(policy));
> +		if (ret)
> +			return ret;
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_PERFORMANCE);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		pr_err("Unknown Platform Profile %d\n", profile);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	cpudata->current_profile = profile;
> +
> +	return 0;
> +}
> +
[snip]
> @@ -1228,16 +1329,22 @@ static ssize_t store_energy_performance_preference(
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	ret = match_string(energy_perf_strings, -1, str_preference);
> -	if (ret < 0)
> -		return -EINVAL;
> -
> -	if (ret)
> -		epp = epp_values[ret];
> -	else
> -		epp = amd_pstate_get_balanced_epp(policy);
> +	/*
> +	 * if the value matches a number, use that, otherwise see if
> +	 * matches an index in the energy_perf_strings array
> +	 */
> +	ret = kstrtou8(str_preference, 0, &epp);
> +	if (ret) {
> +		ret = match_string(energy_perf_strings, -1, str_preference);
> +		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
> +			return -EINVAL;
> +		if (ret)
> +			epp = epp_values[ret];
> +		else
> +			epp = amd_pstate_get_balanced_epp(policy);
> +	}
>  
> -	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
		       ^^^^^^^ this change wont make any difference right?	

>  		pr_debug("EPP cannot be set under performance policy\n");
>  		return -EBUSY;
>  	}
> @@ -1248,9 +1355,9 @@ static ssize_t store_energy_performance_preference(
>  
>  	return ret ? ret : count;
>  }
> +EXPORT_SYMBOL_GPL(store_energy_performance_preference);
>  
> -static ssize_t show_energy_performance_preference(
> -				struct cpufreq_policy *policy, char *buf)
> +ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	u8 preference, epp;
> @@ -1271,11 +1378,12 @@ static ssize_t show_energy_performance_preference(
>  		preference = EPP_INDEX_POWERSAVE;
>  		break;
>  	default:
> -		return -EINVAL;
> +		return sysfs_emit(buf, "%u\n", epp);
>  	}
>  
>  	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>  }
> +EXPORT_SYMBOL_GPL(show_energy_performance_preference);
>  
>  static void amd_pstate_driver_cleanup(void)
>  {
> @@ -1599,10 +1707,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	    amd_pstate_acpi_pm_profile_undefined()) {
>  		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
>  		cpudata->epp_default_ac = cpudata->epp_default_dc = amd_pstate_get_epp(cpudata);

Why dont we just set the defaults to "AMD_CPPC_EPP_BALANCE_PERFORMANCE" for server systems, so 
that the governor, profile and the EPP values are aligned at initialization. Any historical 
context for using amd_pstate_get_epp() to init the default epp value?, do we want to preserve 
the initial value set by the SMU?

> +		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;
>  	} else {
>  		policy->policy = CPUFREQ_POLICY_POWERSAVE;
>  		cpudata->epp_default_ac = AMD_CPPC_EPP_PERFORMANCE;
>  		cpudata->epp_default_dc = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
> +		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
>  	}
>  
>  	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 6882876f895de..b4c5374762110 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -9,6 +9,7 @@
>  #define _LINUX_AMD_PSTATE_H
>  
>  #include <linux/pm_qos.h>
> +#include <linux/platform_profile.h>
>  
>  /*********************************************************************
>   *                        AMD P-state INTERFACE                       *
> @@ -108,6 +109,11 @@ struct amd_cpudata {
>  	u8	epp_default_dc;
>  	bool	dynamic_epp;
>  	struct notifier_block power_nb;
> +
> +	/* platform profile */
> +	enum platform_profile_option current_profile;
> +	struct device *ppdev;
> +	char *profile_name;
>  };
>  
>  /*
> @@ -123,5 +129,9 @@ enum amd_pstate_mode {
>  };
>  const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
>  int amd_pstate_update_status(const char *buf, size_t size);
> +ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
> +					    const char *buf, size_t count);
> +ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf);
> +void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy);
>  
>  #endif /* _LINUX_AMD_PSTATE_H */


