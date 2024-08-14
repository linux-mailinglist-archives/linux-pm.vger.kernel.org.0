Return-Path: <linux-pm+bounces-12196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F1D9517B7
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 11:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2791F24FAA
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0474A1448FD;
	Wed, 14 Aug 2024 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XEPVMy7R"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9A1448ED;
	Wed, 14 Aug 2024 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627758; cv=fail; b=kolwgrSfBYrDL8UUXQD9EaVdNB0jFXDRCZC8100hepG8YOBwpSpY5YuFel0RkaBvwWLJVvNM7lB3J+zGUdrLd04BscMMJj9mtpCXHthuvha9+kMjiKfKp5Zz2t2UPGOlt2woLtSy0UMQ2I8OrkOtSce5AtvGXEp1mqlcQY/aYsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627758; c=relaxed/simple;
	bh=+28YPYJI/swd/bKX9aGttITOKkn1FTH0q1bxSNkCtJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bbxHoRf6WUoD5DXN1HEX1zT/44iNq1thxw0rNdyM2RPDTWajEaxOCKAbx/PFKJ/9QnOkt5INXOLdvLXDvW7t1sECHryDckfNbkbbpmchREvm0pXwX8vUJmLFySMyAEv64aYfpyCCRUrXB8m8G/Z32QJ6rJ6q2soFmMUDtY0uQcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XEPVMy7R; arc=fail smtp.client-ip=40.107.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpeCKEYlnC82v9NIxwUtODSlS6FZxdVq+PXV4QtR59xv06+QrN4nO/xnY0Ekuu73Yj/a7etgbhPhXKyKujxjaqZIrGRp0dl/ppAFqz//gZ9P/amygcyAH3pB03xVlXdyh0TCGu3i1YOtyHCHl46dxLSmu2WQqHnTcmDhoO/ut/XpCuGPBCzCz37V/1qyxpTFGHqCs7CKts7FmIei5Vx8UX9M2T2dQP3XWMrNiCYFemWBusv+HNnXr/bY9X3uhS7eqP9tU3yIEVPW7Hl24ugEtMQQGnWn0UE/7vd0n5iw/ChkHpMjBmko3lHVFk9Omha4PfUGwWxUfgx6v0n9e7xNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYx4HJvAyqI3LrhZV6B7zuRrF2wMJpWt4sMWBqqy3aU=;
 b=nwbFAV/UVqjFHsQKQYLBPPEizgFJa4bm77i5axxCfWYlyd7A03cJnQWCMFqx2l0zeQsChUJ7ibTqfpVkSRuL0stG4xXTo90KFJ5G2I6gIoFWuTBnWsUrAAw6bd87QakuWmtp2saNlS/euBlavyCG/mj+R2atJlpW8bI9aOF6G+8BzIJLWToanKkkQji/J7PHFnwk4IAcc7UEIdGEypzZDXSOGypgHdd4NjYjfR4fnObGjzU014NPMgnPAkWkcNPbfApgc1XTpKMJ87aMurB/p3MtDI77pISHKobVz/1z4unDiksJFQNc8T4wIy2FT6ZGeOTmgwM77KyZQR66vOtkKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYx4HJvAyqI3LrhZV6B7zuRrF2wMJpWt4sMWBqqy3aU=;
 b=XEPVMy7R9zx0cUBAxsIemrZQLUgDodIZculTpUTs7Xcook1iTR7hsDVO5ejJolRY6PZ+RfXmEFKshDdW/EBVuL6VNJxjGhglaIhrqE4+U6olQZpQwDBW3x5q5Y3My552mXLZWMPWyfJKTG/EEH6J0pNl6Ze7Bi8HAo4qa2ualwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Wed, 14 Aug
 2024 09:29:15 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a%5]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 09:29:14 +0000
Message-ID: <9ca4054e-a130-b65b-d2f3-3ef84c997dfd@amd.com>
Date: Wed, 14 Aug 2024 17:29:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] cpufreq/amd-pstate: Remove warning for
 X86_FEATURE_CPPC on Zen1 and Zen2
Content-Language: en-US
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
 <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, David Wang <00107082@163.com>
References: <20240813095115.2078-3-gautham.shenoy@amd.com>
 <20240813095459.2122-1-gautham.shenoy@amd.com>
From: Xiaojian Du <xiaojidu@amd.com>
In-Reply-To: <20240813095459.2122-1-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5136:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 99829204-0c40-4888-e0bf-08dcbc439001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkowVWExcXpGc0puQmM2Vkg2ZXNqNGhtZ3lJb0NYa1VzVW0xOFNWcmNoNTNK?=
 =?utf-8?B?MWxMd2poN1JLcCtacEc3dUpRUVZxQWQ5eGZNd1ZCdnFyWnV3cVZEOTBSZW1Z?=
 =?utf-8?B?c3hySVArdVV5KzRXeXVjd1JwcjVxa3lUVWwvMVZoUUxCa2VUUG50a255V05a?=
 =?utf-8?B?bDVoTlZLZ05WRnpFSWlram9NU2VxOEpkVTlyQk5YcEJ6YUNzVExzL3A5T3Vl?=
 =?utf-8?B?NE5mdGlSeEpxUFo0NCtWTC9CVDdCNkhrTVJUbGgyVWJPS3EwcXlEb3VlL1k1?=
 =?utf-8?B?YnVlVXNnNGhxVzI1RkhiNU5hWk00V29KRlJlUUZTNUtZT1Uyc3VYNzN2RjV5?=
 =?utf-8?B?TGdEN2cya1dycGRoM3ovbCtUcUk3cXlaQ3dJSjhOSEZKTWhjQmxrTUFMOTYr?=
 =?utf-8?B?NklJVGJoanVuelB6UW5Nc2VmOTdTMG1jU2JQR3pJQnExbjNUNXB3TE95NDdZ?=
 =?utf-8?B?enJaeUxOVEdJU0oyb2c2REU0QmlwOUp1cDBNVUNmS1QyUjlKUDA3dGZ3L3BL?=
 =?utf-8?B?OEJmRnNtT2lod2xBTGFVWjU5T0xwYzJkMmVqRGJldDdYL3lkRUkzUWFBMEMv?=
 =?utf-8?B?OS9UNk1aTWRvRnBJSkFwNUxnbVVlMTQ0YjcvakMxR1FMcWMyc3AyM1dyM3lK?=
 =?utf-8?B?MzV1NEF2eFBDVkQ0VUdFRE4xOEl1M0E2NnNKcHQvSEgwdHIva1lLWG1JMEpY?=
 =?utf-8?B?eTlwRk15SEF0U1ZKUkxrK1RzamRFREM2ZFg4ZzdSdkluNjRNUFBZR1ZWSWdq?=
 =?utf-8?B?U1Y5TjREMDVRM3A5Y3NXb0p3Tk1LK1JUcHFRdXc3Mm50Q00wUUpXYzkvUEpX?=
 =?utf-8?B?TXRPNkR6ZzZhM1VmWmhoOWUzZ0NQOGE1N0N2L0FYYnI5MVFMQ2hMZ0daSGpS?=
 =?utf-8?B?WEVuYVRuc3g2T2pZV3NiUmhmbkxid3NJVlo0R3A0dHo2YVJKRnpYZGtDMHUv?=
 =?utf-8?B?dlREMGcrT3cvWmNlVjVReDQ3TnRsVVVDZWx4KytUc05sdVJjSTdqOFpETDdq?=
 =?utf-8?B?cktPSHRwSjI4dUozYkxObSszNWJQQndCbEVDVGV3RkdLMldkU3hhdE1zN2NI?=
 =?utf-8?B?QWdVa2R5Qnl4dDZEcVpLY1IrWGFjWmZTcDVlOTlKZDRnaWNhMnZxVTVkTGY5?=
 =?utf-8?B?U3VaQUk2dUtSbHVTMjU5S2phMXRuaU1LKzR5ajJOWDl3em14TUhLNEU2Ti9J?=
 =?utf-8?B?ZFg0QURBNkQ3OEtHVUdGMHdRaWxCSGppVWdQZFhWQzgzckhPN1ZhSWRiUC9D?=
 =?utf-8?B?M2hqRkhhQzU1ZGhoQmpjYjh3cjRvNTNQMkN5cVUrNnMvd1JLMXVKWmMxYmVB?=
 =?utf-8?B?MUxGVmw0SklYRnkxWURLNUZEVFAySExWMDlHK1dPWWJnSHhmeXgxc3BkTENB?=
 =?utf-8?B?MCtzQUY1SXhoMlVveDB0Q2FOeVo4OFIyYXpWOTJYVEVwT0F3ajRod00vOTFa?=
 =?utf-8?B?eFZiR2JJY05ocTBSRTNacGw3L0tiNjE3Uyt0amk2cDBVZ0pUUzd1NTNYalZl?=
 =?utf-8?B?YWFzQ1g0b3RYejVydFRkVEFCZVl1aFZMNGlPTllyNzdJdndxM29lbkx1eTN3?=
 =?utf-8?B?Z0IrN2pJMzh3U3I2YllJVDNORStuSnhQUXFxWldrdlRxRE9jd0NZbzBKMkZl?=
 =?utf-8?B?ZXgwelliT0NnZjhSaiswQlBPWEphdHoyczBzZFQ5a0RLSXR5L3JDSVliMkRR?=
 =?utf-8?B?RDV5bGtJWEZwU1dPTVBGRUxGYk9EaEVuaC9OZXA2dUxXWng1T0V5bE9JQ0NO?=
 =?utf-8?B?Vndjd2ZSL1QwVDd5K1FjNlhWcVpvYk9LQXpmancvYzVreDV2cG1qZzZEWStT?=
 =?utf-8?B?ZkhkZjZTdTltTThFUnpKQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGpEWVVOckRqM2JjQ2owZ0M1aGhHQVN3cmxQckRNekc4dk5Ya3FKcmcwS2Ey?=
 =?utf-8?B?Rk56QWE3NlVKb1lkRldXTm5FMVZzeTRIVi8rYWQwOHZhQml0MFBHaFRJeWcz?=
 =?utf-8?B?VHBHTjdqNGV6WUhjM0wySFVFLzhpcVNjYlNLMmhjdDBEZjJJUG1xcUluM1VJ?=
 =?utf-8?B?ZFJHbVdZVVNvVk1xOC9IU1ArYWxGdzExR0g1cHU1djc3Y3h6aWs5Njc3MmVN?=
 =?utf-8?B?Z1R6NU1xTEc1R1hraGFTOHlFMnY3V1YwWEpiZWFuY2g0cVhWN2pZaGlqYkZN?=
 =?utf-8?B?L3lVMStLMzkvQWFSNE9YR0RaQ1hobHBWbXZDRWp6bm1LOG9obGJGU1d5a2I2?=
 =?utf-8?B?bG9jWHlkWjhqUU9qT2swSlYzT0Z1SnhOa25WY3VqOHpOWkNsSGRIWUVuTm5B?=
 =?utf-8?B?LzVjcXp2eC9GSkNPalJCK3pUWDgvRlFMTDR5eG1RU2E4b3pkeGtNV2tCdTFH?=
 =?utf-8?B?ZUk0SW1yMEt6SGwzQ1dFR0Z6WEVlNE9Bb1hhb3R6ajhTNmpOZVhHNXAwQ3Fh?=
 =?utf-8?B?SHpIeS9yQkdZQ1ZMcFMzN1lJNFljRGFaVHc2V0JBMlZSNDdKUkh4L2I2MEFM?=
 =?utf-8?B?RHJJYVdaSzJBaVU1b3M0cFBqVHlFRCtYSmJNTkEzbXZxQzlta0Z0U3VjSy9H?=
 =?utf-8?B?QVlxSmZJVTRMdk5CK29rMEw4clB1Vkc5aytxZnpBWWZndlFzSW9PVTNNVUlO?=
 =?utf-8?B?eGhlNEpmMlRIQmdZNlgrUnkyeGpWNVgvSDNoK1dlMEZnYVFlRnE0ckJreTBY?=
 =?utf-8?B?MmJQbjFHTlg0VG9zTjdEdnZkNjNLZ2hzbEg5ZENRRmdCM2FCYmllWnY1NlM1?=
 =?utf-8?B?WUVnYnJjZVNqR3RLU21PNlpTd1N3azd4OHJMbE5RcDYrNDZVWjBNUGVBeTNx?=
 =?utf-8?B?R0ZSeTRiWGRvbHNzelhBa01IdEJQTGp6QVU5QmluU0gxaFJYTlRqcU4vaHRi?=
 =?utf-8?B?NEg1WWp1aGZmK3J4V2ZVVW4wV1Bsbm1NRWVLNnZXV0lSUG5rVVZkbDFNdFgr?=
 =?utf-8?B?eUg3cnNiOGhHZFl5cDExQlZFQkkwYlNTVmtNbHhnOGdDNHl0YzJVeEpvMkNh?=
 =?utf-8?B?NElIQlhRNVZJZW5UOEhJNm1yR3pxVEphcDVwcGlHODQ3MlRUOGFvSlFVNGFM?=
 =?utf-8?B?RVFWVzBwcGI4NlQ2UlBOdTNrdGdQUnRZc0MxZ0E2VkpzQVU0ZnN6aEZYMWVP?=
 =?utf-8?B?aUdtVmxlbUllSU81RXVoUjJHY1lScTlPZFBwK0hTZjIzSExVTG5wMUowY1py?=
 =?utf-8?B?Kzd1QzRVNngvYU05Vk40amExeWtXSGc1ekdkOWhaZmVZdDNNUjF2RjVlbW1j?=
 =?utf-8?B?VlhpVDVGV3NJSGFuU0E2U2xIcktiaDZLM0xENVhreVBiWWMrR0xRMXAwdGFy?=
 =?utf-8?B?N2FqeUJ4TWxHQVNTcjdBK0xtaDdPNFpMOXprQVZ0S001d0VxU1Z6U0RKeWxq?=
 =?utf-8?B?ZitiYllCdElYdDlNcjFDZ3lYRFV4clVZZ1VMZlYraXdUaGFLakkxVm12cCtm?=
 =?utf-8?B?WVJZRnExU2ZNQk91YXRGbmtRWm1Xa09kL0tCTi9rNmswMHNiRnhYQUFyd0dB?=
 =?utf-8?B?UmlDWmQ3dCtwZWRtV0YyTCtLNEU4ZGFYRzl5YXFDL3BieFl0TXN2YzhlTFla?=
 =?utf-8?B?OHhUYzZiVjlSMWhCNXFLT2F3L2EySUY0dHBMMkhGTXRMZTNvTm5LMCt1STIy?=
 =?utf-8?B?OFYrVVgvVUhRZkY4VEZNdkV0TEpVdGRDb29vVzVaTWt2bEo1aTExemttWmQv?=
 =?utf-8?B?akJwSStJdUVTa1Q4aEwrNEJIL2JSTzZkb3BaSi9PaHZiaEpRaU5NRTFEZDA2?=
 =?utf-8?B?djlYYXA3Zm9oYkd4NnoxL0UvcXpUUkYrT1RRTUxvOUZvMVZFenlBWEh3WXkx?=
 =?utf-8?B?ckRsN1AxeWZ3RWc5TElUZkoyV1ZLdWV2U0FlT1krcFhDYXV2K2lycE1rN3Ry?=
 =?utf-8?B?SThmcFRJbVZZTXp2ei8zdy9tUDlydDZRV1pyS3A2QWM3aHE4NzFQc0VZT3Ux?=
 =?utf-8?B?aFJiUHV2ZTZYVDc3SmsralBKNTlxYjJvd0JVdC9lZnBLcGFiS2JoV2xMUC9B?=
 =?utf-8?B?cGpCS0NCMitrbWF5L1ZRQjQwaTU0cjIrbHd3M0RRVVVvdUdlK3ZVci8yZzFT?=
 =?utf-8?Q?kyn4rC+qCgFt09DQH8HGflGuN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99829204-0c40-4888-e0bf-08dcbc439001
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 09:29:14.7758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJcBggWarzQigJmFQiqSngUVOp2px9TjxmvAdrgs55NTWyscYloo4Wo4M1OiWMEAyOThBn5axmrazcr5QOKfpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388

Hi Gautham,

On 2024/8/13 17:54, Gautham R. Shenoy wrote:
> ...
>
> This feature bit corresponds to CPUID 0x80000008.ebx[27] which is a
> reserved bit on the Zen1 and Zen2 platforms, and is expected to be
> cleared on these platforms. Thus printing the warning message for Zen1
> and Zen2 models when X86_FEATURE_CPPC is incorrect. Fix this.
>
> ...
>   	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -		if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
> -			if (c->x86_model > 0x60 && c->x86_model < 0xaf)
> -				warn = true;

Some models of ZEN2 APU/CPU require this warning info, like Renoir 
(Ryzen 7 4800H mobile APU/4750G desktop APU,
Ryzen 5 4600 desktop CPU), Lucienne (Ryzen 5 5500U mobile APU) and 
Aerith (APU of Steam Deck console).

So it has to use model ID to narrow down the coverage.

For ZEN1 APU/CPU, this warning can be removed completely, because ZEN1 
doesn't support CPPC.

Thanks,
Xiaojian

> -		} else if (cpu_feature_enabled(X86_FEATURE_ZEN3) || cpu_feature_enabled(X86_FEATURE_ZEN4)) {
> +		if (cpu_feature_enabled(X86_FEATURE_ZEN3) ||
> +		    cpu_feature_enabled(X86_FEATURE_ZEN4)) {
>   			if ((c->x86_model > 0x10 && c->x86_model < 0x1F) ||
>   					(c->x86_model > 0x40 && c->x86_model < 0xaf))
>   				warn = true;

