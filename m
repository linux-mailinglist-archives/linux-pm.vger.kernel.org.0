Return-Path: <linux-pm+bounces-5127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7978B880562
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 20:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FCE1F235AD
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 19:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063B839FE5;
	Tue, 19 Mar 2024 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="pQdzh/s2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161739FDD;
	Tue, 19 Mar 2024 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876484; cv=fail; b=AJfnYaI0mT/c76LBtxhokqnxF4wQieB1TNld618Ht1inI23emh5rsoxAlgX3BQ8wD7TTwH936ziZWDFtwOTA0uSEzU1F1M15CXveRIudujlyQ1hwHBo0v2j/JwcwHQFBt67ICJL5YOvkBXPpyjHkpKx1G2E6nQlNkDX9TrEluIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876484; c=relaxed/simple;
	bh=0rARlUEgyhdmI4SUc9BF+LLobKxaI9rDvTo5CgGyekU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QpWtkYb9NSM+3SBnU8SyK9K3oZYjmAD3NA2RdraCBjrohoSLJLYMXQMJsDhTNQ1M+k3hIbxGTACegtGJYeNwChyV3un8OaBe1H+fJrEiif7KpNTzDroukibomCauFoAsqOOhe7vt4I3/LVQLiJX/bhb0eoyqJivYSrnKQ2sJWS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=pQdzh/s2; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JD2mM7018098;
	Tue, 19 Mar 2024 12:27:39 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wxka4x99s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 12:27:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2vGCvyOTIuX+ns3G5ozc0MxYI2/6/dadZAQRIgBJNdVZeb1ISmCYkAhnFTYT0Kb9dqk9NTR9Ip6dD4YG4LjCRcNTV9iLMzfMmubtCWS8aQ5kLJUlX+rw7A4sDNbOb/tucwj4QXMt4TUDAzWXfQSia40wvZ3mKHPiJYvDiSzWdMcqdTg0w6Fg1qju5hPrWT4iZObNWlaYdaLLJHfLQ2i/iF6yAyFEUYOD9mIReh2D/6c96hnbpXgCszSaw9zih3Nd5iYW8/1g6PK3kf0se45pNTOuV0EBD+/OSzFAZC4KZKGHZnbA+DSiJUNpDLkqjDCy9Jlyq2axw9B16+8ZV3Ifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLW7O84eIPyFEKUCUKmdAcBwLNkGZPcXs1YsRqOrb1w=;
 b=eWdvASzg0FcF/4JsIoKLYBRZ+TQWlq5vKIIiz+xqalfGV3O+02gdkDHNjGIqNw+tSWmTLKBFYKok7rcNUwMxyGJiyBX4P9rsRimmPHYmjIQd7v9kYEQruqRV+OyGXl64/ke6LFfnJlhcXDLY//6wvuKxhpbiIY0I+XSPG8uT2gwrD7ASMzsukLYRT5wTz4AtRmSEs4RDgV/nWkzNLq2OQZar6FPRdzR341qjYK1+hCHsw9WRPZn1wmO5aPALjOzRmc/Fewb9mNJpbwLyDUjuE9pbjYQwwU44dhv8NMMxwFHIvSBF+xo2EWOSiL4pOszsD3MV+9qtM+Go4DqzYNXViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLW7O84eIPyFEKUCUKmdAcBwLNkGZPcXs1YsRqOrb1w=;
 b=pQdzh/s2/hcxWWz1DVRVWorIvZvwqMDI5BOHva8BFKPK3iNBiO+gCWtY7mev05f2ouImMz7DrWjjn9gEqBMRWXEaRdTmttbQ75zgSh96Xagd86akn2BamMEWCARx6tuTPFvAlM/IGzvfX9ouAQ06QYxAcQ8Pe764NuCY4vRLXl0=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by MW5PR18MB5068.namprd18.prod.outlook.com (2603:10b6:303:1cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 19:27:34 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::fccb:7e75:f1f7:1c56]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::fccb:7e75:f1f7:1c56%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 19:27:34 +0000
Message-ID: <ee010f39-027c-d874-854d-7f11c5cda78e@marvell.com>
Date: Wed, 20 Mar 2024 00:57:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 8/8] arm64: dts: allwinner: h616: enable DVFS for all
 boards
To: Andre Przywara <andre.przywara@arm.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        Brandon Cheo Fusi <fusibrandon13@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Martin Botka <martin.botka1@gmail.com>
References: <MW4PR18MB5084E8C6D673B73FC208190BC62D2@MW4PR18MB5084.namprd18.prod.outlook.com>
 <20240318105153.2c666647@donnerap.manchester.arm.com>
 <8425a1a2-8453-b705-2c14-a846fa05ae21@marvell.com>
 <20240318230333.72c1b6ed@minigeek.lan>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240318230333.72c1b6ed@minigeek.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::18) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|MW5PR18MB5068:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fcf2c0f-cab4-4932-2925-08dc484aa085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/duCa/WQb+kOgEtMALLxc7b2jjcfMXWG3i3/i5RhA+o6LTGBlsKNLg7xXCWnsaaPPLWxhwwqU2Ewcf1/poD8Ard3fr+EhBeynT1rQWP4pBIprkx3sXeNHaTUL0b5f1FzDUmTZ+In26Zof7P/5sslnZAeUz/TSdgTdiuZ6Y856LjsWZsASv8I60minFWzb4/W/fxrvYJ85B/wXKgeTSCmiYYog+tzb7T2tj0C0GwwbPnlxQagS3zcEakfuVxXlnLrYovjvQt2O57wRmftYO9JiDdyrK5TUuIpSiLgKUvRCRdcmUmzoz9jTZL6njgNC7VaSru73DQEsSZb7s1TmWyK9X7EwlmdjFN6rjxr8zDGHiMhioKxnTd7zg2Lr3HTUP6genSOYKzQZUkI9Xt1unz+aa6LtfoAYyHg6NzuQy7CT3JJESCQpIciad2k4U4jeqKNKS/1VyTTmiu2rSoTCwIDiIZ1D2jgj5WWFGlK2YgbHXY0V3Z2/XGiC6XSHMXxPZ1H8fvMduUa5WsKt/kHJUtgS+QiEV00J7l2yIagIObP8T2k+bpRq/WjXIthRa2ryGjBPsNaxs9asxSCMtzmZvn1NgGVOk6c7R8dVp3S3L3Sn0dFmo4MZJNMcTxUxP57leNYUooZdyYMmvhEU9nf0zRMHbKFIOitY2YL8Nj2lPXj8Pw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eHVWK2IxMmM5UE42bUN1R012SkxhRUdJcXZnaENyZ0Y2OFpyK3pjSEZZNE5Y?=
 =?utf-8?B?VmNXaGtKd0thS1VZZ1pnUEFTY3U2M0tTQnBmQ1BQS2JzSDBOZzBRb2JZSW9C?=
 =?utf-8?B?V3FYaTNGMm0xZng2cEdtVWw3dkEzYnlFTUY3SjhKWmZST1VvM3J3bVQ2ajFH?=
 =?utf-8?B?dk41N25MZm5mVkh4Z3hnRlNkMmhiMTQ0VDhsUkhEYXM4TDdMWFhCUk9QcC9B?=
 =?utf-8?B?NVlkL08yV3JiR2NYQ1o2ZW1GUUk2emg2bXpMRkJmMC80STNSZ1J0K2dKZGha?=
 =?utf-8?B?RjFDYks3WmNvN0JVbmVXbEFlS1FvWGorRVNqN0RYMWEyajdlREtTS3F0d0FL?=
 =?utf-8?B?dGdHaitkS3pwOGswQWdJQitKZE80NE5ob3RwbEFmeHorQ0RhRGZTVkxlZ0Iy?=
 =?utf-8?B?L2g2NXJKSzdta2Q3TVZidytaaXErWWRrSm8wRkhhUHY4eS9yTEhDSGdGekth?=
 =?utf-8?B?OFdLczhXTEE5Yi9aL0JmckxIazQ4L09tektRZ1BxOGpqM1dSNmQwMXdBWnA5?=
 =?utf-8?B?dGRKaFZXUVByK2VuY2hQOUNNWFZ6bG9TT1pLRXZyUVlCVnJ6MXdZenZwTzl6?=
 =?utf-8?B?QzdZQ3BJOXdrREZSYmRhNFh1eStLWUJDVEh6TXBYeFE3SldIcm9oeVRtNERs?=
 =?utf-8?B?YzQ0L2dIeWFyV2xqOUNHQ255bnNDRkl0TEw5dzNaeEd5NlVUWkZSMjFuYVRx?=
 =?utf-8?B?Znc0UDJUQ2FKSWYySFgrbGpCKzkwRiswV3NXeTZTalFjL1B3d0VBTU40SXpl?=
 =?utf-8?B?VE1CTHlCTjNZa1FDME5yeHBFcjNhOWpDZnpVQm1iYVNoRnlKRjh1WGJud2dJ?=
 =?utf-8?B?QlNTQkVNc0h0QWQ3d2xsZllMNDRha1JhQjlCemdiOUQxZlE2blVZNkJDQXh0?=
 =?utf-8?B?aDJyNUNCbXFwUGNZeWpmdVNjT012UVhnTTJ0RTl4aEVEWEhzNE9iMmp4amFv?=
 =?utf-8?B?Z3ZySk43RDdtMkZCWDFkZ2dVVk9VUHNwdG1UZ0pRTGlJUVB5SnNyTGlRRGtH?=
 =?utf-8?B?TkVWMHBpMlczOUJZZlY0b2dmQU5kajYyUTRnVnUyRGREQ2Fha1k5OEdYRmN5?=
 =?utf-8?B?Q09iUGlQeVArRnJnMkExSVNPdFV6TmxWNEhtdjlvYlM3aS9pRDVwQ09RWUFa?=
 =?utf-8?B?TnhKRG9TV2I0ZWtUVFpscjcwQWFEZHF0ditqSHZySWY5NWxDbXJ6THlxSkZi?=
 =?utf-8?B?bjVWVTRaaCs1ODFicGRkeTU0ZW4rZFduclpwQk5ub2g3WHZsRjh3N2ZOcHNh?=
 =?utf-8?B?TmlodWwyZ09jck9EdGV1MUdDOXl1L2NpTFRJSCtHNmtGZUxQNUYrWUVtUVd4?=
 =?utf-8?B?N0htKy9ualZlZGtURXlkM1pIMDZnNzh5YStNNEhKRXJLc3hQcGZwbTRrcUtv?=
 =?utf-8?B?ZGRzRjZVV0ExdFBOUGNPTHN5Z1VBblRPdVBUOHVjNDcza0JrSStRUEFRTTdG?=
 =?utf-8?B?WFNBYkRBbEtOUDlIUW1NajhwWjhDRkZBQlpxUUkzb0R4aXdwa0s2d2l2aXhO?=
 =?utf-8?B?WEQ1S2xXbTR1Yy9Lc2pjSFF0MDFhS3BaTzByL3RDSFpocHYzQTF1N2NUaG5W?=
 =?utf-8?B?d1JkMSs5ZVh0MVgyTW9sOE5lWEJNVktyQk85aDZ1eDJHalRXcU5Gbkw3Szcy?=
 =?utf-8?B?VDhReVRHU3h0R01kT1ZvSUJsQmtPM2pMeVh5ZzNaT2doVFVkMWt3LzZjcEFp?=
 =?utf-8?B?czFNZkVaSzRJa2ZsTlM3SkpZRjlTamVNUzEzUFRPaFhoZHgyNGhwTkkxU25S?=
 =?utf-8?B?aEdMWk9PZStTNjlYc0Y1UVpxbE5FRGYyaDFYb09VR2Y2N29hUnYzZkt0SEZU?=
 =?utf-8?B?VEMwV2FzcHdGL2RqdXFXY3Q0NGRreWw3ZkxEVkFsK2wrYmQxSlVTMm5jTVF4?=
 =?utf-8?B?T2JoSnRCbFVkeHMrS0lDMlJUQm9oZEF0QVpCYlBDQzFCSHFIOXUrUVk4Q1ZJ?=
 =?utf-8?B?NmdzQlZsUmRRTU1DZUNnS1FqZ2gxRFhZNVFoejZIa1RCNmxhenRsZDNRdXQz?=
 =?utf-8?B?ZU1PVEJUN3lFSUZmc1BRanBQaXIzRFVtOUdWQ1hyeW1UYWRQV21KSldSZEhC?=
 =?utf-8?B?d2Q2NlVCbHgxOFJpVFRkVW50MlR6YXFJTER3SkViWU5XT0tvNEFNUWg1eGth?=
 =?utf-8?Q?jbVwpYKaeVOkusgVFJ9gz9LKu?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcf2c0f-cab4-4932-2925-08dc484aa085
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 19:27:34.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jcfG0S1IwHcN0/NQZ3l2378jPSfQAV1+8j9Yp+4Q5rSqr4rC4cRGd8v3uCf1hCUhTAuaENF+9nNovqlAr9VZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5068
X-Proofpoint-GUID: YH9vsKygEisA3V7-24LexUUV8TdTA8p9
X-Proofpoint-ORIG-GUID: YH9vsKygEisA3V7-24LexUUV8TdTA8p9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02

Hi,

>> Okay, it would be interesting to see results of some benchmark here.
> 
> But why? This is not a performance optimisation, it's adding a missing
> feature, because the CPU was locked to 1 GHz before, for safety
> reasons, due to missing thermal and DVFS capability. Now it's able to
> run at up to 1.5 GHz, as specified.
I completely understand, it's not intended for performance optimization.

> If you are upset about the bold claim, I can just remove it from the
> commit message, it was just a heads up that we were leaving a lot of
> performance on the table at the moment.
I was merely curious about it, not upset. It could certainly enhance 
aspects such as memory bandwidth, but perhaps not to the extent as 
suggested. Therefore, rephrasing the commit message should suffice.

Thanks
-Amit

