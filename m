Return-Path: <linux-pm+bounces-13899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D867E971E75
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 17:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882BE282C4B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 15:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12A15588B;
	Mon,  9 Sep 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fOwCh9n7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FB4D8DA
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897127; cv=fail; b=NnAM5LT3LK1fBccMZ22mHnqzQRF1ojcuHaCFjqoDwGuzqlk0tYU2w7Z40MKYNP7bTBe4Z09uFH/FVjuktQsFGNBsnxrDE8cDgLnjYjq3iRjEr5lFIHtwAlVLJPAQrq/jKowbZY5FoBZhfPzEgkUBH3OJEGny9rVLiqvRU99/1uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897127; c=relaxed/simple;
	bh=xd+JpyPoIQKSoEMte5nAtODIf4uvYoqkOexBjeN1Ync=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=t11Wn0YBzmr1KgVF4Ne75Zt6NBYAcbopI/e6hH2KX7yP+eBjFel0Rdd6BKr6aZZoTBtv1HW7Cyreu6QwI1wIpS5BDCqeRqXc9/OHEBrD5zcERXOOpGalQRrWClMUi3UQ6bzdWb2rbefIjS20G1g8dou/7Bu3rvegDp6ChtOGy/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fOwCh9n7; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8BSfD0eo9pfM95XY+8htw/OXCE9VjPQPZTezjfAifMmr98xIRu/NF6m4Wg5iIN4+0O/ZqeaX2GHDJ7nuAtCW7ziK2Bpgbft7QMvzzDLjim1MAuyuehb7FCElQuD9E+bPM9b5dyF1T4Ig2hlK1ofQ2YfmpKbpYqyeHwcq4D7Q28PZS/jmeNTkNL621bENcW4vEI0HCI2Yzd4oXUrpApnucYCucMpOtP9xuBYi056EO9UGcMh0C6rTUQs3u0ZcAq+hp8U/zxx1tENdDUnNJqJpWqG6q1/1MZrJ5TbkE0DPOqh/kullruXfEryhgEb1BBqDX/rJ3X1+BVFWetCRga4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDpguGre7d/zdzxD+Xhi526+KreS5JJc1R/8ICCVaMo=;
 b=ZiIofzPfORkMqHVR/TJ1Ohm6WoVDWE6cieEot3mKBUo68TSeXXMPyKJZvWY8pdbh7NjjJaIf7dBz41vTO+6F7dCwKfq9oavDVtUW5fX+9MmR3h8J8CztH1pEmjyVgrf0bSypl0IKHf/7YDor2Kt9MVo3hEl6lXkCWplq0LOTXiZTn9n8IjqVvJyDOG3I1HgoJpwACTJHMSbK8dYdBZulI2ee9P8gPyPJQeSUQmN5SV3jIH6vUjrmj49bmIn35o75wVJ2ACrYnvE9D7BjiVToQlUvACdMBqwZVQH9tMDG4hZ6xh8R4HKMxOZUDy/qskWxQMH0lY5VIJV58SKI/lMZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDpguGre7d/zdzxD+Xhi526+KreS5JJc1R/8ICCVaMo=;
 b=fOwCh9n72/jsSuRjh21GOWMHxRymtWHJ9kDoje123/3vOSCwoIRpivJhql5dxrSMarhaFnRGq7fhb6E5lRzNxf3XWA+tnVSELs9jeHqfKzQZewQiIi/B6bDUMO+3DGqc0u4or8AX6w6fuk2EG+Wz56ZG5XrZAJh6qaEeaOCerLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 15:52:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 15:52:01 +0000
Message-ID: <da6db097-d4a7-425f-8e61-084a2fe15770@amd.com>
Date: Mon, 9 Sep 2024 10:51:57 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Second round of amd-pstate 6.12 content
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0019.namprd15.prod.outlook.com
 (2603:10b6:408:c0::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 965699ea-851c-44d4-5422-08dcd0e757e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0lXeGdKS1VETFpGSWpvVFBaQndjODlEeXJDdHhVM1R0RjF6NFV1aHU3S0xS?=
 =?utf-8?B?RzZtMHNaUzQ5VHVzVDN1UzJmU2MreVN2dUl2NEFQM01kMXdPcGNSS1VGK3lT?=
 =?utf-8?B?cGNMcG9RTUdqeXdwSnRVaUYwZU5CK0JveVpVay84RkpCYlVpRTA5c3dsUXBD?=
 =?utf-8?B?cldNZExKeWpDSEgzNFZweGlzNTVpaXk4YW5vSmFwcWZtRmNkSi8xTEppTXN3?=
 =?utf-8?B?M2l6RndLcjl5d1hYTGFUemRNQUQyckxhaFVnWVh5TUhBYzdKWXExSHhhSml4?=
 =?utf-8?B?UzJRenk5NnVVTXdqSmg4aTExMG13RURha2ZqaFdpR3pTUGZTNVV5WXJDQXFT?=
 =?utf-8?B?OW02eWpyVUZYRFhFR1N6V2tBUGV6MVhDRzgvdytnMmJlMWFNMzB1TVprbzJy?=
 =?utf-8?B?QVVMQUNOUmcvQ0pYZHBIa0F4eUg5ZEF4VHJFSTdnT0s5NGZQY2NKcnpTTUV0?=
 =?utf-8?B?QzlLNlA1aGVvYW1LWURWcko0a09mQ0l5WkRQZXZjZEdHQ2NNM2RHSEZQY2cx?=
 =?utf-8?B?aHBVeUJyM2Z3WE1JdEFKdVdFejJIM1k2ait0Z0NIUE9oRGhYcGJ3WmJUb3BT?=
 =?utf-8?B?RVlXV1R6eDIwY3dCMGFscm5QSkFyckVmSjdxM2hEaEhIUW9qUU9KVnhjTVJn?=
 =?utf-8?B?NCt1Q0MwMzlQOEU1ME15Ny9lRjZWQ3FWOUVFZXBqcDRVdUd5UlQ1ZU9kMm53?=
 =?utf-8?B?WXFRSUs0SzZZNW1pWjJYelZjUkM4MlhibDlyN2lpN0FMZlhqK3FHVE1hQU91?=
 =?utf-8?B?Tk1sT1pUR085d1R3KzJhV3J5VVVQS2VWYXp3c3RMbTFmVkVOZ0xtYk1lTXl2?=
 =?utf-8?B?V2RMb0VxQzVVZFV3Kzk2cEViTDFJN2s2TVRIVTZ0L3llRDY4a3MvUzVkSXNa?=
 =?utf-8?B?NStQM3lrUGNtRENjOE9YblhuZVltV3N5bEM1WWs0TEk0QTRydWRIZmtDdWpm?=
 =?utf-8?B?UnBtOWdraTRNcXh0Ty81cGVmV0tObHRXKzArYWV0RWpuSWN2dklqem1qZ0t5?=
 =?utf-8?B?NitiY3NvZHFZdU1CTDIrZTdzYVZEZWl0OWludmtwUysxOEJQUU9NUlJpMUto?=
 =?utf-8?B?Q1M5T1BRUGk0QjZFYWIyQzVqWTNsMzlhby9UdWNDTmdZek4rQThITFVVMUcv?=
 =?utf-8?B?aWdOWXpVdmxERDhHdVo3dG9scWN0T2JCVTVzUFFSd3V5dHgyYzRUNkEweDFP?=
 =?utf-8?B?NHNsbEoxV1NvZTdKaVorQU9veFpHVEZheVI1Y0lJOWJ4SXM0a0NlOXZTTUJI?=
 =?utf-8?B?UlFUTEx3WFhqYWRpbnJPNk81UzJTVmFicDdsbzdneVVYV2YvNlBleWVDQ2hF?=
 =?utf-8?B?OGlxU1J3UGpzVFNSZmx0K0RpQTllMm44cVVMekFOM1kyblgyN1ViZE4yZjlx?=
 =?utf-8?B?MnNEa0oyK2c4UTNnZTBKMXRLZ08rNlNSZnkzWXNDYVluVVNMamFZUXl3RzBX?=
 =?utf-8?B?SUlZa2FMMksxZFhTYTJWYnhRRm9maG0vZTBGUmZ1MjJ6Y3JpNmdvYTRlWW5P?=
 =?utf-8?B?TjBKemlIOEd4c3k5bFZSUFFNZjE4TUJteUh4djEwaVoxVzZIVDhhbmJLSng1?=
 =?utf-8?B?ci9ETGpWVU1zSWp6WjVoMnlCaklDMWxJRHdlWDhxSFB2TDFpS1hQc014NlQr?=
 =?utf-8?B?bElPd1ZUWC8rT1J2TlNlYjBPZG5SbWZYdkl5ZGswZU81SEhOYUx5eUxUbVkr?=
 =?utf-8?B?YUVlWVFlSTFmY214UVJlaE9Zc1Q2ZXhxVllWK3lQb0llYUZDZnJOOEp4VlZ0?=
 =?utf-8?B?cGJtTkIwdUJLQkFydmdyMEtIcitucVN1aDcvV2U0Tk1ZQTZ1K1FscHBxTTMx?=
 =?utf-8?B?dm1Xb0sxMkM3Y1BtUk95dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTJyMTU1eGV3RmlYVFF5aHhhQ21yYm0wYlliam9wdkV4THA4RHRTSkc2OFBC?=
 =?utf-8?B?TnBqMEVmYzdkK0pucnRucVowVm1UV1VQcWtsQ0VHd1IxUkNqRzIxd3RKWDhs?=
 =?utf-8?B?aHZ1dzlRcGxkN0t1dC9GOEFtaDZpNitpRi9oODIzanpRL3dkZWFYTW5BNTJF?=
 =?utf-8?B?M2tuQmZld3FoWndzQWMzK3VMb0RYV1JBZ2poNFpPdHJXM3RSWHR3eTZ1NjVv?=
 =?utf-8?B?d0hreVk2amxzVkZQSml5b0NnYk9IRzAwdytuR1hNK3hwaGs5WFpnQ3l4dDEr?=
 =?utf-8?B?NVUySHRjckxldWZLUFF0MmdYZ0pKMXRoWUJCN3czVDVNWWJYcjVaRDNFd0wy?=
 =?utf-8?B?U0hMaDhTUDdoQlFEWWFmQ3hlNTVqZzJSS0tpSU83T2ZON0lHakFpVUZGWXhC?=
 =?utf-8?B?SFdEa3BqbExTcjdtc3laWHBGYTkrQ0JyY0pVY0N0TFNzWXpVbWRCRHg0NExE?=
 =?utf-8?B?RXRscmdFeTJPM1l5dUpYSXNxM3phOVpKRSs3Q1dtZnMxWHJWdFM1QXRrMCtu?=
 =?utf-8?B?U0c5VTFxdzVQcXZLZ3JJYkpuZ3g0Y2t2dVFHNGtlVFA5bjJGaFBjZmhmdzVT?=
 =?utf-8?B?RUFLTE5JZmYycFZqTHVyNUVuckY4cmlJWG1QQXdNN0VNRDZEMWJCR3hQZmZH?=
 =?utf-8?B?RC9YVDJpbytBQkx1cXlxUyt3ZXhwbTJKd2FhNC92OHpvRnRDUVNjSXZuekF4?=
 =?utf-8?B?aThFV0tVYUxSWXBObWRkTy9oc3lpVVROOE5MbytZTTR6TlNtTStnZG1aTGcx?=
 =?utf-8?B?c0p5NXdNdFhNSldnVnU3eTZBSWVGVk0wN0NhV0JCTXpwRUZmVlQyakRJbnVL?=
 =?utf-8?B?MUhNbXNhajlMQmt2MytnRU12aUNUU3I3aDUzb1c0dXRJcDNtaXp1NmdjZzVu?=
 =?utf-8?B?VWdjUXZyejZRdHladDJ5bmJIY0FzUXpJOUNUc0FoeUl2OXJCcWtBY2lNM0k3?=
 =?utf-8?B?TWJuR3BabUdZWDlvYUh4amtyenNTdmFFVHdYaGJmUi9PbWRDREtzK250V3pQ?=
 =?utf-8?B?TTdzc3AxbGIweUdSQUgyZ0EyV2YzQkNveVlSTzdzR25idzh0SGVmRzdzSHZI?=
 =?utf-8?B?eXozWWhkZnl1M3lxczBnUjgwWWorc21GWGxvbTFJU0Z2bnBDVFlpZGxtWGZr?=
 =?utf-8?B?UTZEdFFDQng1ZVFWbnZHRzdsa2E4bmRndkQ1Wlg0bmZBUjV0ZVdWZWtXckkv?=
 =?utf-8?B?K2Fpd3RRNXBJb3R2cDFmUTBHL0xoYWZIejVwNVBRVUh3VnQ0YklVMWI0TVVY?=
 =?utf-8?B?N1I2cHNzeUx6ekpaZUJPT1crcGpMMDJQWjJkQTNvVnRSKy8yQmFnZkZzMzly?=
 =?utf-8?B?UVFUZzF1TDJsWk5HSDB6ZlhERXUzdFRxQnRuc1JKSEVMMTdqUXJjdWRjRktm?=
 =?utf-8?B?VW5pQThsOFdiQlRtd3hFMUxLdHZxcGtjZnZLWk5sdVFzTTIrOElKSGNlQXFR?=
 =?utf-8?B?R3BnZlJxUVZQNUhjSDNUZ1Z2NEdmZ2x4NGxicU5QVkVEaC9RZTUzaElsa2hE?=
 =?utf-8?B?UEs2ZzkvcTNRV2hlSThISUNST3o2QmE3ZTlLaldRaEp4UlJvT2V6M2Rqa1Ju?=
 =?utf-8?B?OW5lSXNYZ1lwUHBSY2JjZVFCd0NES2FZS2UvYkNzR2FCT2JLUDYvV280Q2dV?=
 =?utf-8?B?K3VoZy81RVl2UmpzSS8vSk94b0lIZS96T2NOd0JDWC92dmF6UWZKRDdsS1JQ?=
 =?utf-8?B?NHFZTnd3VUtlZUZHVjhqTm1wUi95WmxZL2ZLUGRXZ0FkbVNDdUsxZnhxOTR1?=
 =?utf-8?B?emw4WitCU0pFM1g3QzRNZDFzNWh5Z2hXc2thZXkzUnUxV1hpVk5Cb212K0ky?=
 =?utf-8?B?Vk1tRWFadTBKcjROSitweU53eEVCb1J3Y212ZWZKa3ByL1k4OStwWTBlYU14?=
 =?utf-8?B?OVNtMXpZUUp1b2VmN0k5bDhuc3h0eGpWTllnRXl1dmw5OEpaNEx5M0hwTWRL?=
 =?utf-8?B?UnJmci82bWZvRzQ1cUhtNzVoN25qOTZCa2w1cTdnMFlLVjcxOGxDcW5XRm0x?=
 =?utf-8?B?QXV5V3lidmRlRnBaUzZ0NGllSW9vajZac2lzVUgzakRaV2x5Z29vU2tEMkFZ?=
 =?utf-8?B?WXRMV3VaZ3RlVEpCWEJxYWtZd2hsZGVWTkZpbkdSS3pKM1UxM0Z2dXF1Wk1Q?=
 =?utf-8?Q?Z+DnHXaYegDKvp/R3mhli4vgK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965699ea-851c-44d4-5422-08dcd0e757e1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 15:52:01.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98u4pvutxnPrEJAlngWk3qq68f7eLusuUjxKDh/8aLfthOOtPKsq5IcHrU89d/44IavBBfV56nw4Lnwr4MMoUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574

Hi,

The following changes since commit 8cc214312cf8a0c3702edd1aa52e507262adccb9:

   Merge branch 'pm-opp' into linux-next (2024-09-06 20:53:58 +0200)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.12-2024-09-09

for you to fetch changes up to e121c01c0422fc56033d0dfa1bf3f0366115d2d5:

   cpufreq/amd-pstate-ut: Add test case for mode switches (2024-09-09 
10:26:26 -0500)

----------------------------------------------------------------
second round of amd-pstate changes for 6.12:

* Move the calculation of the AMD boost numerator outside of
   amd-pstate, correcting acpi-cpufreq on systems with preferred cores
* Harden preferred core detection to avoid potential false positives
* Add extra unit test coverage for mode state machine

----------------------------------------------------------------
Mario Limonciello (13):
       x86/amd: Move amd_get_highest_perf() from amd.c to cppc.c
       ACPI: CPPC: Adjust return code for inline functions in 
!CONFIG_ACPI_CPPC_LIB
       x86/amd: Rename amd_get_highest_perf() to 
amd_get_boost_ratio_numerator()
       ACPI: CPPC: Drop check for non zero perf ratio
       ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn
       x86/amd: Move amd_get_highest_perf() out of amd-pstate
       x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()
       cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into 
amd_get_boost_ratio_numerator()
       cpufreq: amd-pstate: Optimize amd_pstate_update_limits()
       cpufreq: amd-pstate: Add documentation for `amd_pstate_hw_prefcore`
       amd-pstate: Add missing documentation for 
`amd_pstate_prefcore_ranking`
       cpufreq/amd-pstate: Export symbols for changing modes
       cpufreq/amd-pstate-ut: Add test case for mode switches

  Documentation/admin-guide/pm/amd-pstate.rst |  15 ++++++++++++++-
  arch/x86/include/asm/processor.h            |   3 ---
  arch/x86/kernel/acpi/cppc.c                 | 172 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
  arch/x86/kernel/cpu/amd.c                   |  16 ----------------
  drivers/cpufreq/acpi-cpufreq.c              |  12 +++++++++---
  drivers/cpufreq/amd-pstate-ut.c             |  41 
++++++++++++++++++++++++++++++++++++++++-
  drivers/cpufreq/amd-pstate.c                | 151 
+++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------------------------------------------------
  drivers/cpufreq/amd-pstate.h                |  14 ++++++++++++++
  include/acpi/cppc_acpi.h                    |  41 
++++++++++++++++++++++++++++-------------
  9 files changed, 305 insertions(+), 160 deletions(-)

