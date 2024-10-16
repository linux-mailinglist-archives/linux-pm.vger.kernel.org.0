Return-Path: <linux-pm+bounces-15780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85229A0D7C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 16:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D221F22870
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85F620E003;
	Wed, 16 Oct 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="49eAI1A0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54A20C492;
	Wed, 16 Oct 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090671; cv=fail; b=EcZ1JzPNii4pbVapgLXMJ3Ag+2jiN3rNXa1Pcjg57MOrnovARkk3kM7mDm5XkS9VyUPOJ08i/8svxklUzXq2c9dEkb7OT5FfrGrAVRPKmNTI7nmgNRjsTjxob2wDINUjI+Fr2aDUkGGbe4uYkyo722h069MXpdR1ZN/YEesPi7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090671; c=relaxed/simple;
	bh=rMNEsyZ7+Z7/6kM0KucCwWQj/SHKQXAodxfsx62JUMc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uOnlCwy6ypywBDiBkqHPQ5/w1SgISbtN062GZOZ+TRPr8SiFRHDvcBAuX98BErn25tV0aLVDXF8JuewBFQQyGUf4AKJvqoOJMlnkaRWP39wb7eV9TEo0tlJqIuQJ6gPa+wGppX+lG+Ro3j3hGI36u1eur7I+zuBbAX95xVLRZiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=49eAI1A0; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuaVgbGBLomQsFsOQrm3DcYBBEOvMi1kEFAIVIWx0DmhSRaovXxRXwv1Se1WmolYhggcUoxWzl6W6IZXKRBRSQ24LbFtLMscJftQXwrzJIuuYCguRnFtZtFq1cWDg+fRFmcWetKTCM0Xk7ftUj+2cfEGrTn1LANJWHyQgq6VX/9XZbiFDCDCSAgAJGDU1yVWqJjjw1A+RrQA1Nhpa8L6BjEh/jUDtps/+N3B3JAD+N7K3MVQ/0mEPtbulynZ+VEzBPFsksUBp1vCYt8OGI4QYB8KhtaRP2FxCQvgZt6jj4o1dnib7Rw4o1dXSaWB+ejbcMXPS6Psb2BIWdKtxk7cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwhD+fmZh25+ShUmEH+zCd/04Qj8oMtqOEHWCRT/w/M=;
 b=f62yWM5PXBJw+kQ3oBrk9kXh/dxkJn/78gkIjT557h0OisR3btP7kow37gh3U1u7uiR0ec3TjXsUPBRfJnlu6s3Uw+OCx3klGuXFccclJzoQp5b/nrJyrKcwEWEqLVeSo1C/r6iwFPqiBISgkVLURdhUxaqOPLbi5T45VxtHA5M+grtv+I0rBgS0BhE6RwEC/ac7ervDLSn8RDDYpFQorLER/VOtFBWUliM4uaj0MvIzTTP4PzsEsy6AQrpDwmEcG1XISRUWvvgQKLxPIMDb/8GUJaCf4RI6az055BKjRgMhWEHbsT4ADX/jcx1X/1tnL7LP6LilGWd1sOI5cLSnnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwhD+fmZh25+ShUmEH+zCd/04Qj8oMtqOEHWCRT/w/M=;
 b=49eAI1A0dLD3Czw/4eQmeGm6HN+adI7KwF73YJJ3Tl00ejzQAY2/uZT+krsN0jb/C6d8MqKfhmjr3StVgL1slKP1m/k4qD5nYQtgHfVaYujL6BUXjOGoHePM5Fv+MlI6woEh0pYYywdWcIsOmJdOIL57dXKSl4YxNfpNbp6h9yA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.30; Wed, 16 Oct
 2024 14:57:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 14:57:43 +0000
Message-ID: <7d1e8f79-9a07-405e-919d-ea2198b1a931@amd.com>
Date: Wed, 16 Oct 2024 09:57:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpufreq/amd-pstate: Remove the redundant verify()
 function
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, gautham.shenoy@amd.com,
 perry.yuan@amd.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241016144639.135610-1-Dhananjay.Ugwekar@amd.com>
 <20241016144639.135610-2-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241016144639.135610-2-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0132.namprd11.prod.outlook.com
 (2603:10b6:806:131::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0270de-c0da-41ec-1a5c-08dcedf2e356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c25seTI2bkVBYmZWb2lzcUc4eVRuVGZVRE1CK28zcGEwZmRCYkNuaEVvUHJF?=
 =?utf-8?B?Z0x2Zzh6NEYxaGt0Q015V2FSRU12WVd5bnlDNkpMcnh0UkdQWWRZSkpYSUVJ?=
 =?utf-8?B?alBEL1EwaHJkN3VLODhhcHNrU1lGU1BvRDBsbVZhbkZ6QU1rZk5KM0ZZY2ht?=
 =?utf-8?B?VHVSaXkyRjhrd0R6WkNrVFBVUkZLN3NldG9PYjNVYldTTkdTeEkvUmozRnpJ?=
 =?utf-8?B?b1AvRlpTMDBVcExxcVN4K1kzb1pxc2RNOGlWT0U1RmswQjBXUE9rMVlCc1ov?=
 =?utf-8?B?MWp5a2lWekdTeTlFRHRnM2NINHFGQTdJNGtlRExwZHYvWUxVaG80Y05mNTRR?=
 =?utf-8?B?UWE3VTBlYUE1b0hycm96QzFOOENlUlZoeC93OThaQzFlcGFaZHAvWkh0d1lB?=
 =?utf-8?B?bEcrNElxTERYdlh4QVI2anByRDBLZ1FnU2FGc1IvRnFBL0hKMXNiZUt3NnBR?=
 =?utf-8?B?ODlCS0dPVVh5Z0szNlovR2NRb1FWVElBOHo0QklrSzVrUUljbStPUEh1Wm5X?=
 =?utf-8?B?RFVCT2xtOXJMd2Jaelp5Z1lwNCtOTW5yRWJmeHcyUmMwd2JEZXBWR2FVVHU2?=
 =?utf-8?B?YVo5TGhJSlFQWnBMY1U4YW9QcGlxOGN0MWo0Z3MyY0dQTkhjNmNhL0Y4Vjg2?=
 =?utf-8?B?MkxqTkJ1bllzSUt5MWFIb2ZyY0FmQ3E0QUJDMlB3allSU0VqZDJFYytJTlJJ?=
 =?utf-8?B?VUE4N0ZaKytkazQ3MjZ1alJWZjBuNGt0VXRyeERNSXkvZE4rdmNCNTh4VHdE?=
 =?utf-8?B?ZlRzcFNFZzFPUythVzdkQWQrN2JzVTlKb2ZoZjdHbTBvM3lyclNpVGVqdzVU?=
 =?utf-8?B?OGE2aUtLKzdGcXpCOWJXSUI2V2RkSisxQXFTcmF0RDBpNGtzYXJSUTN4MkhK?=
 =?utf-8?B?VktoRUJqR1VXVGVEa0FjdmFYV3lXM3pwdlcrc1VEMC9aMU9IcmI1OC9paEV2?=
 =?utf-8?B?YzBrRUFUU1lZK0lkQ1ZOZFFRNkYvcmtNTnV2NGlGbFlPVFdIbEtCQkhFWVFV?=
 =?utf-8?B?WXplSmZadVkwczFtajB2SjkrbWYvOVVRaFdUNUdVdkN5QS9GUUxHVjdvMTV6?=
 =?utf-8?B?dXB2ZFNQdkl0eFdKUWpRcFg4SGY1T2o2ZHdrdHZmOHhkUW5KZHByQStMdTR3?=
 =?utf-8?B?OXQrci9xRDAwZWk4T1NsbWc2VDYwN1JBejVEbHVMU0tuWnR2ZmhLWG85VTRs?=
 =?utf-8?B?SEhTV2lJTllZUE9sY1BVbHRRc29iaGJGcFRQNkxMT21hbVNFY3ZHVjJoTWFE?=
 =?utf-8?B?Vk42OW5ROEl5Nm04U0VzVENabVVMSGF0L3VDbWEyeWs2YzVOTGZQazhJblhJ?=
 =?utf-8?B?YUx3SlkxUE1LbElZamNWb1diMlRDY2NnWmRTSUJkTkMrQW1rTnVHWmloVnVB?=
 =?utf-8?B?QTd3ZDR5aXk1dUlSWks1bmRlWmZqOFU4SHNkaDlRYnNFc3h1dDJRdEJxK2hP?=
 =?utf-8?B?eDA3MUwwV3M2S1E3MlNBbUpseTFPTTlaWGRjbHI0dEMzUkpweEdjak1wOTlu?=
 =?utf-8?B?cjBFSU82YUwyQ3p1OXhvQVhSUE9xT3piOW5WamgvOHV2bFpxbHRGaWdKcno1?=
 =?utf-8?B?NFdkYm5zVHVsa1IxNE0xbGEvWW9DTXNHbkM5Si8xTHRKRUEwdXJ5MkRnV1Mw?=
 =?utf-8?B?aTFJVSt1QUEzVE1NRGVESmhFSGZyMDhocFRzUzBELy9JUzBER1ZwTjlWUGVx?=
 =?utf-8?B?ZGkzUFFiOVNScDRjNldUeDltazBVNTE3RW5KMFh0bFkvWVVkdGJzdU5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R04rZi9lVmJwRGxhZDY5OVlqdTRKUDg0MGlSdysxKzBuSVFhbVZDa1dDVk5y?=
 =?utf-8?B?U0xjWXRlTG9keFZOR0tnVHdWK2x3M0h2K09WZVVHTlN1M0VUdEsrN2R4dlB6?=
 =?utf-8?B?a0h3SExyeGc0WDF6ZlR1OVhnRmthbVVzYjdBZzZjUy80WGFwMmtpeEltYy9l?=
 =?utf-8?B?djlUWWplbjRqNVQ4SDM4bGk2d255Nkh5WnJWWm9jSE95WjlEaGc2UFU2VXRh?=
 =?utf-8?B?cjdBK0RsVjZoNktnVDBjeXJtY1VIaW10ZGVrZlVvOU5nS285V29vR1lhSER3?=
 =?utf-8?B?M3dicXBRWGt4VitYbmNtYm1jRWwrY0hkWlFYb04zeERmN0xiSG5KUnhNT2VC?=
 =?utf-8?B?Snk0UnlJRTJnUWNKQ3pvajF5VDhEMFY0UHJjV3dONlV0NmY0TG9RdlNTMHda?=
 =?utf-8?B?MW1lOW5sOGJrL3pIZHc4dzdpWmNQeVIzM2JIL1pmYTFyOGNpeGR0WkM1NnN5?=
 =?utf-8?B?U2Y4YjdsUFdPUWtVcWRBdU1FZjdoKzdPY2lITEVnRXVXekg0dU9qNEZ6Wng1?=
 =?utf-8?B?QmNrUDYyajVIc3IyRjFQaTZTeE1OSDJRYVgzYlFRMmZ6MmZ6bkU1ZjBWQ3lj?=
 =?utf-8?B?Tm1iS1JZOWEyMGpwa0JaeEJNc21DTWpPRmRtaUpGRi9RbWdqd1crRE16YWhN?=
 =?utf-8?B?MW4yQUdwcDduUk52TWFrYXRCRlRFcTdtUzFHeFd0SW1QMnZIYTh0dXJIR1Ra?=
 =?utf-8?B?UHl0ZFROVW8yaW92ZmFPYm4rdFlqbVVaa2dEYmpVa1lTMGFHTE1INE9TSSt5?=
 =?utf-8?B?Uk1ZRm9Cc041NHBGZWpKT3pSUDA2T3ZJOGI3YUF1TjFTa1BIaWxVc2R0eGtB?=
 =?utf-8?B?dXlVaFE1enJRdGg2c25BYit1YU55VHlSMDNIYitRMjVFKzIwMi91bTQ5VTRI?=
 =?utf-8?B?NnFIRlpwam1UdHZ6allRV1pjNXV1WXMyUFFoRm01ZWgrT0NrS2I1MGswcmNU?=
 =?utf-8?B?THRGbEluaUxYazR6ZENMaENoQVl5YzhJYkdPTG9TVHljYVRGQ1NGRUl2K2li?=
 =?utf-8?B?eTVoS0tVbzYwYnpGOTBaL1B2ekdOL3ZYdmZVaUR6M2hFNnVjMlBKRE0xZDV3?=
 =?utf-8?B?TGdhSWtlMERyYzlUM0xqT2VnS0haWHZBaSsyanZJYWxXbkZ4aUgzbUlrK0lN?=
 =?utf-8?B?dWJ0cUhXNzIzd2JGWHlzUWs2bmEveGN2UWZvTkFmTXJodFJYTVdsRmdONzh0?=
 =?utf-8?B?N2N3bjhKbmFDaVg4QjJhYTdQSzhGRWI3RVAvU2EzVWZ5T1QrSkhaVUV2WnpT?=
 =?utf-8?B?d3JZa3NObkpib2E3SUsrTkt0Qkk1SmtCV3cwanphYXJPVjBHMXFaczIwSVFs?=
 =?utf-8?B?TkZiWC9qTFBKK1FaZkhJYTFvd2VCTG94UkhULzRZSmFHRTB1RXZNZ0lHMENF?=
 =?utf-8?B?ZEJoejZ2OTVJSmgxVHpmcHJWVldSNENlMG8yM05jK3Y4Z3J6VmI0VXZuc3J0?=
 =?utf-8?B?Uk1seENuTDBpenpneitZeVo1V2Y3SXc1dHJBZ1pMVXNJNzRrRS9FK1BoWEw3?=
 =?utf-8?B?QTEvd1liakNaUEdPeUVFamx1alMwMEFtTlpJNHQ0a0dQTlhvVEVYUUR3dVlw?=
 =?utf-8?B?aXI1Z1ZlbmRzZStPeTFBOGU1QnhMVkNBSmpENUpDcCtZa0IvYXZHeUhOSlV6?=
 =?utf-8?B?d2M3M2JUYmNvalZlWEZqYldXZG1UQytWZEF0YWx6dmpaVWNZMDVOWWtEY1Bp?=
 =?utf-8?B?U2p4UW1ScHNjU1gwMDhSSm1wZGxSYU9jQUI5Q2tVWXRCb2lEKzF0VmM5aVJs?=
 =?utf-8?B?Nm1MYWY1Z0FpU2xsaTdUaEwxWTNyb1BVRFBLT0d2ZHZCSmZmZ0wxb05XRnBY?=
 =?utf-8?B?UDlQNEhGOUJLZmdVRXljb0lIY2FORU84aGpTRzlhQWRkTnVFS0lhNGc3a2Yv?=
 =?utf-8?B?eEJydytHR1FoTzJiRFcxQkpsaDFORERvSGVDOElOeEZENkROZTFEN1J0SS9H?=
 =?utf-8?B?c3N4dGNnZFUrM0ZhbGtMOTkyMy9wUmdoZUJsSC9hVEFxMUlnb0o5Ykw4R3Z0?=
 =?utf-8?B?SUZqUGFieWlYSEdXL214ZHVaU1dKYXpXZzJwOVBKZkxVbU9jczFyY3Iyb2xN?=
 =?utf-8?B?c3Z3d3dtZ1N4d2hEZ3ZBQ295THNDTnl0anY3aUtXVGhzSHFpbEx6dzdKa1No?=
 =?utf-8?Q?ipZ7hcb2wO/w/BTVLYttLw1RP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0270de-c0da-41ec-1a5c-08dcedf2e356
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:57:43.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wy+YafdbGu6iI2e6URBkDNplSPUYfjZILGs6Ns7ePALk7iX9g4STU4upIuG7mbyHzADi2Wqg1fENGxZabMHzsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332

On 10/16/2024 09:46, Dhananjay Ugwekar wrote:
> Merge the two verify() callback functions and rename the
> cpufreq_policy_data argument for better readability.
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b7a17a3ef122..fa16d72d6058 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -527,10 +527,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>   	cpufreq_cpu_put(policy);
>   }
>   
> -static int amd_pstate_verify(struct cpufreq_policy_data *policy)
> +static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>   {
> -	cpufreq_verify_within_cpu_limits(policy);
> -
> +	cpufreq_verify_within_cpu_limits(policy_data);
> +	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
>   	return 0;
>   }
>   
> @@ -1661,13 +1661,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>   	return 0;
>   }
>   
> -static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
> -{
> -	cpufreq_verify_within_cpu_limits(policy);
> -	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy->min);
> -	return 0;
> -}
> -
>   static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> @@ -1723,7 +1716,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>   
>   static struct cpufreq_driver amd_pstate_epp_driver = {
>   	.flags		= CPUFREQ_CONST_LOOPS,
> -	.verify		= amd_pstate_epp_verify_policy,
> +	.verify		= amd_pstate_verify,
>   	.setpolicy	= amd_pstate_epp_set_policy,
>   	.init		= amd_pstate_epp_cpu_init,
>   	.exit		= amd_pstate_epp_cpu_exit,


