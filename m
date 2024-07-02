Return-Path: <linux-pm+bounces-10371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5439246B6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 19:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB7A1F23D11
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B548D1BF330;
	Tue,  2 Jul 2024 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="itJE+CY7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AFB15B104;
	Tue,  2 Jul 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719942899; cv=fail; b=qLsYTmmE2x4i7BqBieTCN+vTbjewly/fXQCJ7y7S2FVvu4hqEG3mXPtTF7Mxyo169Sil6oIbeI4B5P+qmRtSiaJNmxsZ/lh36586KzypCJcGcLgrZLqq8oUCfXhWe5MO+kwced83sXR0np7UrZOUVRGL4WUCO3nM1TzQn96H+Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719942899; c=relaxed/simple;
	bh=zW6JsaUXu1FErppz17lP9eqe+5BtwgXU/ycNSlYDhkk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pzoawpKmydHJBd2MPDeTeLeLUZ/NEJe07TIFd+7628yTYc1h27iXGWVKAiopGIiX0NOszsrhukbUIsQcmuDhuwU0RN6MZhAKTcV5w2xxTJaiKsF9qZlLJHPrGotGQJ+gtU+DL22ffI9aGz5q3uNZarcX6SC+wH3KL8WNDUKDopo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=itJE+CY7; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXwoycv4SJVOAAJYSmA0qFrmyzZJ6rBRZRlWIEwStvf4+hZSR7Z+TlEF9r2wmmUaCDOStg5Jy1aec0Lb6yP0msJWvinXEU8yOgJPVDDjU5PfwjinRJIPcNdyMvA8XhnTyXR4ILD0SOdbmPjbnSMmNWRP9jVXpVeaX5J8/JOmRV3iGeOEiQj5WKlvHNb1MCz8OcUD+rF/3Cg/eKpYMcmrx0h/kG1U6431XwEvF0SZA60mp7MuQwYW96Eeh38iPMZJlA+Ni/g8Bi3Gjcv2Ztv0aLN9p1YWgu9WhqiSUv+gGz7LIQjsOjHhoQKrySGtg+zxOHILdv+Y9txY5OeVj4FZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdFn24KjnMPlQqtFS6Bb6/iDrMg4IwNfHb1+wH/Plds=;
 b=EAenCg/jgwOo4rYlLOScK5FBd+ZW4Ku9bU4xS3wE8SdnBJgooC29vjc7l1UguogEzahZEQJN6k/QbQ5HAzO99EZuqtRTSqrpMKOl7zMkOuAAwGAuHogn5JIBJSVQx2p2XcgIuylsjazAqlXQGV//+IMdvJCRtrBIAqmZEyewo77jARMPEKbL8/3vsag00WEHOk7DvjvtfG2ID+2OWrws2pu3nu3jp0kWNAVzn6Y93KZGbqcwjvI1+BwCURnUEvC2RM+ic4t99F6Oh9rUlItzEEwK7H29OTBs+8aR8Ipj43fVK4cEab/9omqaw6p4abwGfHtkKNaeSAunXOC8YlkBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdFn24KjnMPlQqtFS6Bb6/iDrMg4IwNfHb1+wH/Plds=;
 b=itJE+CY7xtvAzNS88416F7Fp0tNXf8NH3a/RCn8s2qaD7GzBidn8AjkM2NaDLgDhpUwYg0OOpy+BDsWnJCke2kbEK3xeWfxfn3GYUqqNT28JlziDuR71U2NQ7n6AQly92rFqllL1EKe7DXkzKMyjNgXAPxERotKPQugP5Tpkhbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.33; Tue, 2 Jul
 2024 17:54:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 17:54:48 +0000
Message-ID: <9e0e74dd-7b79-412b-bb1d-0e0ff6d7e989@amd.com>
Date: Tue, 2 Jul 2024 12:54:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] AMD Pstate driver fixes
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael@kernel.org, viresh.kumar@linaro.org, gautham.shenoy@amd.com,
 perry.yuan@amd.com, skhan@linuxfoundation.org, li.meng@amd.com,
 ray.huang@amd.com
References: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
 <cf835a26-1a76-4cf4-840a-c0bc6cb03452@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <cf835a26-1a76-4cf4-840a-c0bc6cb03452@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 266d0f3e-0df6-4f09-00ee-08dc9ac010dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGJWcW9kVWdtdmNBeithZmlPR3ZYb2pSbkdMNVhWK20rZzBYVjM3UWcwK09j?=
 =?utf-8?B?Y2FlaFdoYi9xdFBQQTVZYlRzQmJsVUFqSVprZldiSVN2L1loWDZ2Vm40Y240?=
 =?utf-8?B?ZU95SFc5S2Y5TWgrNDhGTXZYSE9sME91dmpONFdkeFBqWk12Sy84WVUrOXVs?=
 =?utf-8?B?V1hTMXZNRTlmTVZZVC9xK0xpQnoyeE5xUkd0VDBDeHBWZlcrc3R1WGVjUnNN?=
 =?utf-8?B?T3hpbUppL3BNdXAxUUZxRzRyY24zK2JILzJXVGVsbnI0TGVCNnZFVVQ0VVUy?=
 =?utf-8?B?bllpblErQkxnWC9TZVpCbkFzWTVKcm5pRDc1L1NZZ0xNdVVrWm4yaTdwcnZO?=
 =?utf-8?B?S20ybWVhTUF0c01FU1ExQnBDUEdIdEd0a1RRbEhMQ1VqVUo5bG5jZFltS2d1?=
 =?utf-8?B?M0FVQk1OdzQ3Rkg3NEp0RWhLa3ZlWXM2MDYycHRScnpWeXFsK1BDVnhDRkQx?=
 =?utf-8?B?RWJkTXo2VUhmd0RkV0FQUzJDUS85QWhHM3ZIeXhuT0RZODVqc2pRRXNNWkZD?=
 =?utf-8?B?bm9mR3JaYk5KQk83ZG5WM1QxdUVGREdJUGNiNjJpcURIdlA4a3RNcmIxNVh6?=
 =?utf-8?B?SXE5RURTb0xMa0QrMGtKSlBMb0xBYTdYaWNZTFdEV2ZpbGpZN09aa2l6N3Ex?=
 =?utf-8?B?Q1RZTXRFb2gxTEtZVFh6RzFjcExsVXZpNjRaL1l0dzFKU3o5ZDYxUXF1NU9t?=
 =?utf-8?B?M21KNytKdlljT3N2R1REaEJRckVlOUhnSEhkSkJpODQvS0dySFdSUThTTjAr?=
 =?utf-8?B?TE9MczJCSVU2MStwRGY4a1ZmQ1BrdHZCdWlCcmNQYkdjMFpzWGFBcHJhdGRC?=
 =?utf-8?B?YUdGTXNaeEZOMFdpSlNYeSthd1J3NU1vbHRRMXJ4dDJGK1BUZEFGaFJmcmFE?=
 =?utf-8?B?ZWwrdzU1NFhJNW1rSXJmR3NJRUJnZzVYaW5HSm5aNlVESEtTNS9tUURNbTZp?=
 =?utf-8?B?WjB6YzFNbkhsT2FqUldZTzQ5aTNmcERId21mNlRnY2JtcTNPRUxmbytVSHJ4?=
 =?utf-8?B?R0JLMTk5cjdSQUxXUkEvUC9maVptbzROSno1dUJMM3dpaUZSb1VQb2dYeksr?=
 =?utf-8?B?VHFZK0RUbEh6Q1NCY200TFBVZk54czliNElCMG9RM1crbzhNenFxOFZtZnp6?=
 =?utf-8?B?Nm50SGRrVjZCSXp5dklCVlJ5NXVvYkdRdFlicFYzMkNKM2NWMnJkQ1lPVEJH?=
 =?utf-8?B?aWROSDk2THJJQ2RaK0pBQ1FVU1RQdlB6MWJwbmtoNDBHRTN2VTF1Q0ZRQ1NU?=
 =?utf-8?B?emFYZk1ETmlENUh3d1JycnVjNzdpYVNicUVEYUU3ZGhQYW1WS1VEQXd4OWk1?=
 =?utf-8?B?bHN3dGZpL0hScEJRZENyRFgwZUFUMXpvZFFGcXVUOHB1eDJBSHJ5UmJxZmJS?=
 =?utf-8?B?R2ZvUzd5R0ZFSFhLcUtmY21lVUd3U1JBQzl4TGQ4c1c3UEE0VElpRnFmRVVH?=
 =?utf-8?B?SSt6RlArNkpSZU9JdmI4TnJKUU5pQU9BNzZ2ak9mWVRqRUtTOXFrMzg4aTdy?=
 =?utf-8?B?TW5ISk1QUTFsRjNIdjFPK2JiTWpEVUhTZU5zdXNqeWpzRXgrT0thRCs3Ykg1?=
 =?utf-8?B?WGRRSWtFT3pPQ05qN0xVYTFiWXFUSlNjenJmNGR4ak96Yjkwb0pNbnhYak11?=
 =?utf-8?B?bm9ZTjRxMjRXNFVVKy9ma2lZNjlObWJYc2pnRk04dHBaUmliUUdhY01ZNjJC?=
 =?utf-8?B?ZWt2NDdHZ1hqK3l5MGZMMzV1UlNxNjJCUEtESDhnUDhzQjk5N2xNVEh6c0FB?=
 =?utf-8?Q?4GRdT6i2Z9Jvr4iJ4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emtJc1YySWZlcWFwOTNDZ1A4ZVo2TGlya09FNFlVNGVQSU00Znp0Tm9vWXlG?=
 =?utf-8?B?Rk9DZUpuTEJqM2JqMDRMV2ZqMjRsSmZtN3ZMN2FnNWZCRHJxVmFwYVRSK3JM?=
 =?utf-8?B?TnZrdlhxd0hlUDRzb1ZjUVNzZFUzYmFOaTdlOHdiME03Mk9mUzRaNVdpTEsy?=
 =?utf-8?B?NjlXNU10WHlKcXJ6bmZUcmFuL1FSZnlidTJlNUpsUk13MS9EWU9SVVV4c2RQ?=
 =?utf-8?B?WVRJWHdIR29TQ0s5cDdNRWJjYTF4VHloQTM1amdBbkd4NFg5QWRHNUJEQWpF?=
 =?utf-8?B?c2dXanZhdURZN2lHTDFJZE1LazZMWjVJS2wxVHdMOVp6K254K0lKdXJkT2Mr?=
 =?utf-8?B?WFFDNGNFZjdSSFFPVHEyK2FvYUxVUmJRakFmZEJyV2tkZ2NoS1NOcEJkdllR?=
 =?utf-8?B?UnZYalEzeWFBdkI4ZERaL3pYQ3RDeVhXdVFLanBzeElnd0tCOE1UYk1EQnFv?=
 =?utf-8?B?b2dmbWxwNVFCZFZaeXVWd2VhRjJ2M25yN1lWQVdDbFA2a2RybE9uMldUclhV?=
 =?utf-8?B?L1V6cFdua0xCcEU2ZGlmaGM1RmU4ejl4dXlrNW5kelJPclRBbHFRZ2ZVKzVj?=
 =?utf-8?B?Q0F0VjVlSmFnQ25ZZDZuVkdrQ3Y3UzVTdk00WGluamM2Mjk2azRmRmNLK2lq?=
 =?utf-8?B?aHZ3NXBvczE2OEc4T1hIQ3Ntd243TzcrdFg2cWcxTHcvbTFqV29WVTFJMUVs?=
 =?utf-8?B?WjRMY0IwYWo3TmNaWGZ6VERBVVFtdlJsRlJCTkF3Q2Focmo3MkhMU0Z0V0ox?=
 =?utf-8?B?TXR4Q0xqWU1ETUc3RnIwYkZUK0tsWHpWbzBmTEFSTWN6V3pPQlgyWndLbkM0?=
 =?utf-8?B?QXpGZ3EveDdBSXNEUWRsRUtMcDRsN2duQ1VZc1ZPaEI4Y1U1Rjdta05ud2xN?=
 =?utf-8?B?amgwWlJLeFVHblpUMnFQK3c1WE9xWTFQdEpZZXFmS2FneDNQL0RIamFVOG5j?=
 =?utf-8?B?QmF6OUN6elVGemtYZ2Nhcmd4NmVvd0JURW15eXJWVnFBUEpqNVBBOGFKdDBT?=
 =?utf-8?B?ZnJaSDhrTDZMQ0l4b3Z2anlZeFIwS29CK01XKzdmOE5aeU5ydlpWc2JnaTNR?=
 =?utf-8?B?LzBYNk5EckYyaFU4WjFya1Y2SXpBYnZ3WHVyU2Y3RjNtdkkrcjhtQmxIdVRX?=
 =?utf-8?B?RW8vbFVsd1ErcVFXQkdxeHdjU2dvY0tld2xJeWZrQ3Qwd2MzQ01IYStYMXpJ?=
 =?utf-8?B?N1ZWTlR2Sk8zQm1lNDUxSlNLaWZ2RStQeWJUNFExeTB1TmdBOUxMS3czRk9s?=
 =?utf-8?B?SFRSaS81b3pZMXRIM1lmUlIvS1JJa0laakxZckZ5RDQ1WWhXL2IxTHkzTURX?=
 =?utf-8?B?T0lNNmQxZ2xMb25RUzZVaVFjbi83MDFBZkJHL1hETzFReVlZeG5RSjRTdHZF?=
 =?utf-8?B?eWhlbDRaVjV5Ukw5VDl3VDhDUDFNK1JYQitNblMxbGJYR1RYcW9SbDZoMWVz?=
 =?utf-8?B?R2VOR2VBa2JHMkp4VEErSXVsZVBiMzJVc3hENFhWSTRRSnZaVEpPaGhSTFI1?=
 =?utf-8?B?cm5pb1lncHpONkI2dnpEQWhsU2JsbHFLY0VqVi9zS0JzUldNZllDU0FHVFZr?=
 =?utf-8?B?VlB1NEsvemtLeGpZc29lNy94M1JvUnJ1eVRIZXhVamp4UHNldzQ4SUNsUFNL?=
 =?utf-8?B?SW1JQ2QwdkIxaWVXMmR0aHlHdjN3MEtmcytIamlscWZGdnpHby8vL2kzYWtK?=
 =?utf-8?B?SjJSTW1XOEFtR0UxL3lHOFhCMWtxQnpsYjFpU2FZTGZjZnVtSmlkKy9ReEli?=
 =?utf-8?B?b2kzWmJWT0tWQ3prTkhkdm0vZCtiV1IrdlR4eE4xTWxRbXEydEJ4YXFQY0lk?=
 =?utf-8?B?ODRyN2dMWERoMkltUzZhYnJvTHF5UUEwQkJJN0JtOW1pM0hsRnlMT1lmUHNJ?=
 =?utf-8?B?THExa1gvZ0hYLzJlcGtxRmQ3OTc4bzl1UmNrQ0lsTVNNUzZFalZsZDFmSjhs?=
 =?utf-8?B?WDNtUU1BZDd4VTM5djlVSHVFWlRvZU1zdzRyRkoxYlorcjFXS00yTjY2c0tX?=
 =?utf-8?B?c1ZWQkxOK09hUnVxQkVycVl1NDROYngzMW1uZU5sRTk1b0grV21pbDQ1SU82?=
 =?utf-8?B?b3g0WW80d3hLUWNPSnpKNjl0M0JiZ1JiOGlsSWpNWDY1ODlTSzU0K205dVJ4?=
 =?utf-8?Q?+eZUWP03AP7KTRv/hwvlyuRM2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266d0f3e-0df6-4f09-00ee-08dc9ac010dd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 17:54:48.9106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JC2jvoMNoeGfFXOgkQiiQkYFxHD8LEa0iWoS0ahIEudq+SZsPdQpIXQDXg3cx1YuUyI/8xn0ZE3yp9BifJDRTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377

On 7/2/2024 3:24, Dhananjay Ugwekar wrote:
> Forgot to mention the v2 changes,
> 
> v2 changes:
> * Add reported-by tags (Gautham)
> * Modify patch 2 to use amd_pstate_update_perf (Mario)
> * Modify commit name for patch 1 (Gautham)
> * Modify commit message for patch 2, from scaling_min/max_freq to
>    just scaling_max_freq, as scaling_min_freq still needs some debugging
>    to work correctly with active mode.
> 
> Regards,
> Dhananjay
> 

Thanks!  On it's own it looks good.  I've added it to 
superm1/bleeding-edge for some more testing.

While testing I did uncover some other issues that I dropped some other 
patches for review if you can please look them over.

https://lore.kernel.org/linux-pm/20240702171515.6780-1-mario.limonciello@amd.com/T/#m1304e6bfe80b7a76e41d551784542fc1038e03e8

Thanks,


