Return-Path: <linux-pm+bounces-26807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B092AAE095
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 15:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6B83BA974
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 13:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B670A2820D2;
	Wed,  7 May 2025 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KZRpPvxS"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE94E221262;
	Wed,  7 May 2025 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624104; cv=fail; b=BmaUCO7VtWoyvhIpGr1p0wg5vYRR1ViPxnBY5QJj5oFI0S3L+tb1mzVaV4eAkWRHvD1Plsp5lgLUlj0Jz42jrTkA0Jxk6mA2P0+fS4ptaSz1fsBHZPRoaGhuWrrbCuSpcvXfdbZ6PDL0GNz/P/ZLPq9ETnZfOAULz4T9JoEwYFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624104; c=relaxed/simple;
	bh=MIYsk1m5XNbvCuEIemgsWxoHsyMCjUQ/NXbVjE+lKK4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kBUBmf0Yfdy2QxOSBHsLVLcvJuFfdaRO8krdthn8gXnHWmVaGNmKl25RMWhetKRLpwzNW1Bxrz3V1aUMYPs9Fp3D5uL5SBsdyvDgBW5eqhw6wrWZfp1HAkEYIoPqQxljb9Ch91aA9kqWBs+cElnF5tdXoQk7vccZw7LLh66VcwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KZRpPvxS; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlV8gBW8bMsMXn8E/7NSB/+bo4HdIGnWnm0d9wvROn7uZE8b1O97loPvJW+Ub3a+m0kK2FkgMo0YJGjRpn7PSDdCqqjWn7KSzgagwLFYTuwuXRczC0dqwX/89Q2Vc/U0nXWWDsqDHhn50UvDiqN+v1/sqe7jlA34Z1IS6zEMEd8hY521g0bhYUaNFuhH0mJgO75/QrCMbPOHiEjPSUBtjWPH0D5wbNCKSnee0aQs/FIhUrXzvPfmeg9wLmOk8BXlvIs4H9L5iWoBMTLOeaykDRtAchkM7qECAsHo6+ZDxI/vUF+ZK2A8SZgSkFOCK8cnxL3i8FQu9DmWNoXYky5oow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MC0n7J/4mra2QwAINfrrErbiMkStXXyCLA1L0mRh0pc=;
 b=QGKPT4soPGcDK9wLEwcsPLvDXUCXAHpImHDfyAblKtxN5mVmSbU8lVwX35LXCU+16wp0g+iaOIZL/tDhg4XRMivOMK14RmaOXg/CPuqky5Em4O9mDZOy4LdEONWF/v361qMPKxsIKs1NbuTtARFENm6E0gaomXQwcHwyjOEzi5vyeiyhP1NhEq5BtGimySMciXqcdHaFbwilttrjotEuqSOCoNFe3ReZtOAj8Sbm3uaXL+I44kSZ5yQb7cGPnN3QjGKcc+dKJcj3kiyDHOYerFox5UkMyaEEa1nI8q/YcDDdEkLFQavQXqFV/W8UQCfLi/Dn+dLoY/9FTn9JWUnZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MC0n7J/4mra2QwAINfrrErbiMkStXXyCLA1L0mRh0pc=;
 b=KZRpPvxSwgHOleiDH7mAdvFcVURryiLNipuu4/IyHwY5TvSd0Dpb5IafB/XkUXJZJbPHCGWzKBN/JdDwfbVNQSaRSiVL3iCSbjShVE/QRud/Hvyy5FUBq+RsCT7qifOM0/B9HoWR9ar0Hra9HHTLa+p48e/BNIx1g55fim5Llaf+2DjSry28Sya7ceWh9lqoDGnBdN1KuOYaEOk7UGrmEU57FYHgvYKO48C9osdAQsCNZm7WQvQ5NCxo3EImELnSAlKqQfin30tD+PLWLQXKUGAr6wWzoDQaZc1Pxs9ryPbUpdKWYyWklZLqAKaP1UIgoG9Tk4ICsKzxNhsbaJvt7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 13:21:38 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 13:21:38 +0000
Message-ID: <7c970b02-7b58-4d15-b5f6-18bbfd883ccd@nvidia.com>
Date: Wed, 7 May 2025 14:21:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the
 parent
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson
 <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Saravana Kannan <saravanak@google.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <10629535.nUPlyArG6x@rjwysocki.net>
 <22630663.EfDdHjke4D@rjwysocki.net>
 <c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com>
 <CAJZ5v0jWTtaQEcx0p+onU3eujgAJpF_V57wzZCuYv2NVnEb7VQ@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0jWTtaQEcx0p+onU3eujgAJpF_V57wzZCuYv2NVnEb7VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0152.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::13) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: fd90e9ce-f00d-4db4-cc74-08dd8d6a18e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnFNcUxVb0ptdVhOK2lQZUZUUWtsOFVlR0V6THlQUExMaFJaVlFGYlhIVkZv?=
 =?utf-8?B?Wm1nS1B0MVp2VGZCbUU2dzBUZlBIQ0tMMmpOUlduRFp4Zll0dkNncElmYVpV?=
 =?utf-8?B?WFR5NDNWZkFEY3pmcmxWTktuZFF5Wk13czNETEtEUkV0bndkQk50RnFKaHY4?=
 =?utf-8?B?cGdyb09sTEtGVEtDcnpPc05jeUg5RnJ3NWtmUjhmRExodVJYUm4xVFlQcDlr?=
 =?utf-8?B?Wm5McWN6VVIwUUxEWHp4N1ZJMFp4dmpESktNNWxNc0FEQVJJS2RUUUd1d2I5?=
 =?utf-8?B?MkNMZWRYdFIrNjgrZ2p1SkplekRnSGZwSHdtZHlXZ1ZxZy91S3NMay9OWi9E?=
 =?utf-8?B?b0JsZU5KK1I2UjZzU21SZ3U4Q0M1NEJUVUFrVWJ4RERQM1IvdWFzd0Uza01X?=
 =?utf-8?B?UTdzeWFPNzBoUmVKdnRKMXpPZk5qcnJ3b1dQVmo3ZVloU0dDRStCTzYwZ1Ro?=
 =?utf-8?B?d2h5VkNmb0NwTXphaUgzcjYveTZ1S2YxRkZUaldMTmQyWml2bmNybHJTc2Jx?=
 =?utf-8?B?MmxzZmNNcWU4NmZzenVxQkdnMWV2c2NldGlkNytTNTZNRmYrNldYRW1Yd3R4?=
 =?utf-8?B?WllNdnJiV2tOTHk4ZHF0Mm1hTDR3YW40RktWZDI1SWt5aUpOL0NSaGt2RXZH?=
 =?utf-8?B?YnE1M080SmxadlVKVGFZQ0IxZWE2aFgrZmsrbW9YMml1SGtOcG1kbnhSU3o1?=
 =?utf-8?B?RXdXbDVPV0pGTTN1TW5iQW8rdllNamdSckpzaG9BNjVmUnQ5dmJ5SHVyQ2ZK?=
 =?utf-8?B?akNNalF0NFp0eFd6Rm5qa08vMVBWMVhlWGtmWU91cmR2WU1QRUFWS2IzbGhk?=
 =?utf-8?B?RWIxbWZKZFJvOFpRQzhRSFNrMXIvZEJCTTNiR1VVZ3FzMjlzbkJ6cm1aakZr?=
 =?utf-8?B?SzVzNllqL2NrWW1nbmFQWnNQMEsxR0wxbnFRN0NPSWdJbGRFMWcwOG42ZWMr?=
 =?utf-8?B?UzJjdDBWZysra00vdGxUalo0eklUYVdtV0F6TlVPN2s0MzFvUEg2UXZWNGJy?=
 =?utf-8?B?U1BQYzlCbWgwcDkzQXlweDJUako3dGZTQk55bXNhL1lvSm9PUmF1bjNjZGQv?=
 =?utf-8?B?dDNvZzhQZXpmLzEyeUZWOUI2UXc0bG1jY2JhK2FxYm4yRW12enJFWGp3Z045?=
 =?utf-8?B?VkV6dUJuNmZ2VHlybWtXN0ZDMG1hQU4yNXFabUR3eDVGVzJGa3NqQlI2QnYy?=
 =?utf-8?B?S01NUXR4d2ZRdzY2NUZTTldBelcxSHRuNDhIUHRjMm5PMlZZVjFMdTdkTk94?=
 =?utf-8?B?T1FnWWN5cU1OcjBaaU1WTXhFZ3pIeHNFYytBWXBaWWhZQ1JDWWdmQ1ZNbFdj?=
 =?utf-8?B?bU5VaWhLZmUrL0hIOEVTN1JxVXFsTVh6MHAxd3B0WDFvcDN3cFpiWFhsaURk?=
 =?utf-8?B?bnZUY25GK3oreXRpaG1weDRmamNNdnpQUk40TUZEMjFCMDQvSDlhbHA5NElh?=
 =?utf-8?B?R2lUOHd4OWgyem01Ym84UWVma21IOTcwWld3cHR3d0VqaGhZVFhQWXJqSnEz?=
 =?utf-8?B?bHMxZVdaM2VYanM2WkNqMVY5bWxPNGFseVpNUkR0cjlsK040TDVQdFYxUlZQ?=
 =?utf-8?B?OHFFUkxqM0dZMEJVL1ZYdFIxNzNFZW91eHpBM0MxMTE1SGpkNnpteFlBK1Jl?=
 =?utf-8?B?d01RbExOVitoTFdlQk1PNkY4bXFTSmJ5cXM1dG9Iem5oNVdZSzcyRStBS2hp?=
 =?utf-8?B?M0dobHk2R3hyNEZ5dlRXNm5JNkJrK0pMQ05iQ2VGS1k5dGM0N3NoTlcwVXhp?=
 =?utf-8?B?akFWZmx3NzNGMTQraVpvaUJpSk1YQXZxUkMybzliZC95alRMVUt6KzRtWW0v?=
 =?utf-8?B?TGk0NXg5K2ZQOEM4aExzdHF4WlVtcU1Od2VlZksrdzBkRHBVWE1EbWYwaUN6?=
 =?utf-8?B?dWdFQ0JxU2QrR0g4cVpWdkdWNTBlTDRsdCtMWEZMMTZGaVo2RDN1aUptck5O?=
 =?utf-8?Q?Jkz6hntk2ZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk9IMkowUjBPRjdqUjFDV2JxQzgydEZSV1pBVExLbUZiR0hxK3BVN0tFT3hm?=
 =?utf-8?B?UitIMms3NWxuSjRJNHZzVmNzZWdFWmhsd0hqSDdSUlRVeEs5S0VDcUJCOHIv?=
 =?utf-8?B?M2l1UDRkN09zak1rZGM2VkRXK3dpcG1FTVRvWTlTN2c2WUQ1RU8ydlR6UVlu?=
 =?utf-8?B?dk43MjdSODlUT1hmNU1PRFUwVzNsd3VIV0pXUDVCMjFBNXRQZ0xSQkVFcm05?=
 =?utf-8?B?UXhVRUlURE9EOFpLdEVqRXlQOGE2cUlReE9wWkhCeGFIZ3hhZE94L1I0NEdM?=
 =?utf-8?B?cTZyYjU2MGpmcHl1MkhhalQ3VnA2ZVVsWnVjVzVuMjhpWUZ5cnFaeTNtODBl?=
 =?utf-8?B?OFIrbHNEdUIwNlZCcUZEaE9DUW82MXJnZERHcGFyNGVtcEFEblJvVlZRcHVY?=
 =?utf-8?B?czQrYWwyZlFHNjI1VEVGOXk4UlJPckRSRzVtRHEwUTFDbUdWdFdCQTZLL1l6?=
 =?utf-8?B?MDRHQUgzN3l3cmhxbXNDLy8yNlF3VW1udFY3VGxycDVyVHlCTHJxbzN1VWZC?=
 =?utf-8?B?WGNNeDNMTWVoM25yazdZYTRsQnNMTkpIQ0JnVlVNUXdFKzhGWi9BMjc1NEl0?=
 =?utf-8?B?b1pxZXhWOUtTUDIzaUxZaFo5dGo4b2tuVVdhRDdkS1ZTM1FvWU11MEVFN2V0?=
 =?utf-8?B?b01wU1hrZXBPM3NDWXBuK0lReTRkWnNzOGhKOW9SYUM1QUtEcXoxRzJ0aklK?=
 =?utf-8?B?ckJ5dlk1T1V2WDVBeDV0VS90Zi9ya0dVaTBwdllQTTdyYkcwcHNhdXV0OHVH?=
 =?utf-8?B?SEdKREsybndPazE1RHFTUVFvdlhoRzk0Ykh3RmgvZVNSUDFxNkxsVU1YWk12?=
 =?utf-8?B?UEgwWm9LTnR1VzFZMFlCRFVWMGNjR3dCTG9FSHowMkF5WWYxUEFWZ1J4VFh5?=
 =?utf-8?B?NmwyMExOZE1mT09XTkh4czlmaHJHT1NnYXRVYUVyR2pldVdTdUVsTTJVQ1RU?=
 =?utf-8?B?dk9NMGZtSjNXbHJKYVREUURZTWp6Tjg4RGlYZjQ5TENxcXJKVjdXckorMDdZ?=
 =?utf-8?B?NTY2SDB5Mm1QdVg0eW5iajFnWnIrZXM3Njc3Z2hDK0dlcDYzdU9RMlMrd0Ri?=
 =?utf-8?B?T0VPcERQSU15UE13ZDNpeUt3K1FGWmRaVElkbDdHK0F4QXFSVnE4U1VOT3JZ?=
 =?utf-8?B?aFZxa3lZUEFuUlZYRG9hNUcrdUtzeGQ3MDFPRW4rc3JLMXl1R3lPUHB0V0h4?=
 =?utf-8?B?OHYxL0ZacVgvYmxQYkhzZU15V28wWld1aUZ5VlRvaHZVUVJUSVFWOUNHU2ta?=
 =?utf-8?B?MlI1d056RDk5OXpUSlBVSVlqUER4czBkOTNuYldWYmhmS1UwY1NlWFdIV2N4?=
 =?utf-8?B?UVlTNFY2MUNpMys3NG01NjNkZmVmUUxhZHppR0Fab2w3UnhZN2xsY0JteTg5?=
 =?utf-8?B?OGhkMnhpSGdUUnpQVU9kOU9iQW1GMkNoREZncDBKVlVzRnRIT2VxaEJobmR6?=
 =?utf-8?B?M2RqU1hGbXFPNUZyTzVGeGx3VVpqVFArTnhWWGNqd3prTlJ0NHB3T1QzRTdQ?=
 =?utf-8?B?d2RWdEJzUExic2cxa3BHdThLTWVRZmgzU2g5ajdyT0NQd2JVYlo2WVNYS1Zq?=
 =?utf-8?B?cDJnNWl2bnNMc3Y2eU5CVmE1NDVGdmZoNGV3TzFDZldoanpqVWJVMW4zZG5H?=
 =?utf-8?B?c2w2K3h6OGl6VDVXVDF2REhZME93amNSdVVnMTdqdEVpNzBBWUZGM3gwZEJD?=
 =?utf-8?B?SUthTnpRL0VuOGg1aGJldW91bWpaRXdEZEluN3VQa1BpaGdJRUlUSFJucW1o?=
 =?utf-8?B?VXdlZkt0T25CKzZLMEJkcndyTVNiR3JuWU5jVVlKTmdCSGp6eDBOV2JaUTJX?=
 =?utf-8?B?VDhnQWlieVhxd1RudlcySWFkRDEzNWNONUo3Qm45dTYxcnRYWDVYSmJlWktx?=
 =?utf-8?B?UUkwRTN4T2hMU25GeWxvcllrNitXK05FVTFwaEdoTVFkRGVvdVRvQUN6ZkJt?=
 =?utf-8?B?eXUyeUJTK3F6dDcwUi9RS0l1bzlZQXJ0QzhoRG1aTlZTNjgwaGRCNGgwWUJz?=
 =?utf-8?B?TnlrRmZPbVM2RUY5REl5V1Zua24rU1FQNElPUFg4T0FPZzhMYjZaY1dPRlo3?=
 =?utf-8?B?UkRYdGk4ejNWOTNsbTJhN3VuT0FLVS85NUlDWnc5eTBodC8rc2s4UndSZGdJ?=
 =?utf-8?B?TDkxdCt5QlhFTG9FcS9CYUpXdkZ3YmpPSnNmaXg5RFZnVEVpSzlGTkE0UEI5?=
 =?utf-8?Q?m784cu6LfXt221VCPAW/H1STfpT+Kf57GuFZDJ9z+7aB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd90e9ce-f00d-4db4-cc74-08dd8d6a18e5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 13:21:38.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFN8naJOMUOfA2bEl/hBIYALCkd1C2+SDegVmwdMGI4qfNQ39vIo8yRQ2t0x8jGW3GM+gcjQlI3yQgphxDtCLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888

Hi Rafael,

On 02/05/2025 21:33, Rafael J. Wysocki wrote:

...

>> I have noticed a suspend regression with -next on a couple of our Tegra
>> boards. Bisect was pointing to the following merge commit ...
>>
>> # first bad commit: [218a7bbf861f83398ac9767620e91983e36eac05] Merge
>> branch 'pm-sleep' into linux-next
>>
>> On top of next-20250429 I found that by reverting the following changes
>> that suspend is working again ...
>>
>> Revert "PM: sleep: Resume children after resuming the parent"
>> Revert "PM: sleep: Suspend async parents after suspending children"
>> Revert "PM: sleep: Make suspend of devices more asynchronous"
> 
> I see.
> 
> Do all three commits need to be reverted to make things work again?
> The first one only touches the resume path, so it would be surprising
> if it caused a suspend regression to occur.

I had to revert the other 2 patches for the kernel to build. I tried to 
only revery this patch, and fix the build issue by defining the missing 
function and mutex, but that did not seem to work. The build worked, but 
suspend still failed. I am not sure if that is conclusive though.

> 
> The most likely commit to cause this issue to happen is the second one
> because it effectively changes the suspend ordering for "async"
> devices.
> 
>> I have been looking into this a bit more to see what device is failing
>> and by adding a bit of debug I found that entry to suspend was failing
>> on the Tegra194 Jetson AGX Xavier (tegra194-p2972-0000.dts) platform
>> when one of the I2C controllers (i2c@c240000) was being suspended.
>>
>> I found that if I disable only this I2C controller in device-tree
>> suspend worked again on top of -next. This I2C controller has 3 devices
>> on the platform; two ina3221 devices and one Cypress Type-C controller.
>> I then found that removing only the two ina3221 devices (in
>> tegra194-p2888.dtsi) also allows suspend to work.
>>
>> At this point, I am still unclear why this is now failing.  If you have
>> any thoughts or things I can try please let me know.
> 
> So are the devices in question "async"?  To check this, please see the
> "async" attribute in the "power" subdirectory of the sysfs device
> directory for each of them.

I checked for both the I2C controller and ina3221 and don't see any 
'async' files ...

$ ls /sys/class/i2c-dev/i2c-2/device/2-0040/power/
autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
control               runtime_status
$ ls /sys/class/i2c-dev/i2c-2/device/2-0041/power/
autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
control               runtime_status
$ ls /sys/class/i2c-dev/i2c-2/power/
autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
control               runtime_status

> If they are "async", you can write "disable" to this attribute to turn
> them into "sync" devices.  I'd do this and see what happens.
> 
> Overall, it looks like some dependencies aren't properly represented
> by device links on this platform.


Yes that would appear to be the case, but at the moment, I don't see 
what it is. The ina3221 devices appear to suspend fine AFAICT, but hangs 
when suspending I2C controller. Exactly where is still a mystery.

Jon

-- 
nvpublic


