Return-Path: <linux-pm+bounces-30380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 461F6AFCF3D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 17:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA871BC25D2
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 15:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E751E50E;
	Tue,  8 Jul 2025 15:30:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF51C4A0A
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988611; cv=fail; b=jp8we2ZkhnTJcY2RBkXnjoq06wG/xozLtNv+sPIb7IHtBjHZHkzf5E+5M83OUYQxOI9k00SIsEg4TFWR/4j6aNh+eU3n2fkXibn/VjFNNKjS5EC1pjGchYQiwj1+48wzwJGd4Muwc3EeAdjslVdgCBX6pcyhlwtzeP/sp8Uq0Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988611; c=relaxed/simple;
	bh=Z3oNklfSeNNU8WGwYkGOiQl9DNLiuPN8OEb/D6VbDWQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uLYEe+V7+PRbfnzztrquF0Wg/mgP6tRWSBD/BRBCu2rS67EuJeu92mJ64CFTzVgMfgaPAMcyBxipOsikbdTDsx4iPrBvwZ7MjJMldjuNjCFNvRRf7t9EUUDspn6Jm3Hz4p5al3l1EuXy5M7oDBmpvyk7PzrITbIsWX32T00htkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568BsZ1n028556;
	Tue, 8 Jul 2025 07:56:25 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47pyb5jx5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 07:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6He2zsjEvhx+ksd5ZJH56ewa7kZr0OuKb/TBpCuh2unS3NM/e6+zB/Moia8N4oQQ+/RCdBSH1RlNc96trGf/yXt8xTxIZ1OtEmW6/PwuJchhLMKDKs9dcODw/NbnGG2/jz7ejSClj7ihHsGfTKkIXN/dir0eMDl5ay6coVljtmfIt4grYw+EDAzA18RPb7T2PK9dkmKIbZmYxT/JO7jm9TsuOv8VNvfWEzilEga8KB5dZlnfvXxgCJNzZdQu7aAA60jw1GeN2tDWw5LilMQb6yKCgAIEuWL2Nolhpz7qSBZsDLvsy7Cb/7dp9LkWcH6G3JZtAG3R6JcWxR0y7gygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ou/Al5n+PVMC2FynHB6awznBNKiddCPg+1Q4vgUEgkk=;
 b=BDRQ8fUwbAlkyp4xQq9WE8dAp4xzWhU3XXHOHZ9JTIxRM3kJL1IrWCGmXv0FzEY3+7S77mfUlv7Eg28NMiMeFFXM0VkU+AlNUIOOOJhcs0UXg2WsD9Bxvh4RGD0mBtprgVDswuPQphu1P9uBowhcAh/cwkGHN+lLYWOloUfrYEAsEovwgQGo3avoTGOFgaW5/yQleNPBQ5L8qousCa4BeqHtD61fRH6IVv8mYELZmNgjrWU1PdKbL0WU64S1bLQqxORwTxAD2VLA3J0G+vGVU114itD2IsHBrrQkifbCfdNERHPa5CEl9MEqgP6fofLnfoIVsESTfUovFcidGh/7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by SN7PR11MB8026.namprd11.prod.outlook.com (2603:10b6:806:2dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 14:56:23 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8%5]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 14:56:22 +0000
Message-ID: <e32f6ab0-256a-4d8b-a0b6-3df2d9978b03@windriver.com>
Date: Tue, 8 Jul 2025 08:56:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: question about behaviour of cpuidle on 6.6...seeing *many* missed
 estimates
To: Christian Loehle <christian.loehle@arm.com>, daniel.lezcano@linaro.org,
        kgene@kernel.org, linux-pm@vger.kernel.org
References: <0dd1f3be-3bdf-44c9-a6d5-623077714149@windriver.com>
 <7d43a796-d831-430b-92d9-53b3d8351fb6@arm.com>
Content-Language: en-US
From: Chris Friesen <chris.friesen@windriver.com>
In-Reply-To: <7d43a796-d831-430b-92d9-53b3d8351fb6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:208:239::32) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|SN7PR11MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f928d0-3fb8-4bb0-a3c6-08ddbe2f99f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2RRV0ZTVFN5TWR1QmVKRkNoeWhZSlVGbFFSMUlzK0lZZ1VqUTNkRGJVWUpX?=
 =?utf-8?B?cnBkT3RzTk0wN2VFa21rdjRMSG5GOVlPQS9xVWp5QXRxMi84ZVBSRHhTZ3BF?=
 =?utf-8?B?WFVUeSsrTlJZNkVGemxHU0E1VVFZSGh5YTA2SXVHSFZRQ1VsK1pxSjNkM1hz?=
 =?utf-8?B?MHoyQWJUTVNJR2YrVUhIZldsSVZXYkVXUjIyKzdxbU1XSTVxVysyQWpRN0NQ?=
 =?utf-8?B?R3RGN3EwWXBBOUozTkY0Zk9GaEVDaFdQV0JiL3pkT0tEUUtVUzRGMU9YcTZP?=
 =?utf-8?B?aU54THhpVExJdFRTZHp1VWh1bUJ1TjJXVGQydDdWMjVmQjE1Q3VmV3ozSFpl?=
 =?utf-8?B?WlpHSGNnWjh1YUV2SDZ5T2ltYlFtTzgyUEtCRGZTd3hIK2RNak9odE5IejFJ?=
 =?utf-8?B?aCtRdS9zMFV4M0k5WDZXM1lPM0hhOVVXdFc5QmJvYWlYT0xiekxFQ09HTU51?=
 =?utf-8?B?Qmc4Rm54dUlsM29vdVhQZmExMTk3TlU3OXlzTGxoMHN5d1RaOWo4R0Z6NFBW?=
 =?utf-8?B?UWsySzlQVmo5a3llamNMQmI4Q3ZKU0VVbmVrTDZBZSsvWm5FU0t3YnZxVVNR?=
 =?utf-8?B?MnQrc3BMNlFBL3ZLSVgwM3dCS1FsWXBWaGFGQ3hFZnhhQmwyc05NUHJqWGRl?=
 =?utf-8?B?RlV1Ujk2NC9hY2Zxb1MvL1VYZlRCc1JCMWU3Q1I3aGlRaDB2ZDBRTnI5M1lr?=
 =?utf-8?B?bWZ4UnFTMGcxVGxLejBtZmFmWnJqK1pYd0dqT0UrWGU0b2ptUTRhZlpjOGs2?=
 =?utf-8?B?bkUrdS9wWWhjVVBYOStiK2g5QWl5RGlvMnMxd09SOFprYk5zMEczY0tzUG9a?=
 =?utf-8?B?ci9GaEUrbDdGWSttZ0dTVlprQzFoM28vYlRKb0JpS1ZWRHdFb2IzeDZVRTAw?=
 =?utf-8?B?TlhwS3RMSTZCWXpWdXB6VStXb0J4MXBzQTV2cFk5QmZsK3ZacVRNMDhKME45?=
 =?utf-8?B?Tk9TMHZ6SzVDckQ1UWFnRHo2Z3ZhSnRSMVN0TFRVb0tFOWpVWXIra1BwWDdU?=
 =?utf-8?B?M01tQWo5NXdQNzFaQlJwaG8xZExwNEdVUWt1TFFGWHBqd1FPd1BQUWVQZDBE?=
 =?utf-8?B?NnhzMWVxUE8wU3ZGWG9XS0hnMjZDZExnT3AvMHM0M3YybWxUcHBsb2ZjN0hx?=
 =?utf-8?B?Qm9MMTNFZEhJR0lkQkhmY3ZyYlliaXVhUHRqRjd2ZDdqUVNVemF1UFRQRXYw?=
 =?utf-8?B?UFA3UmEvMlYvVGYyY1ptZUFiMllIa2pWSUlXZm53SG96eVFGbWFWa1RvRmFq?=
 =?utf-8?B?Ykpmb2d6a3J1TFlMRG8wY3R5MUNKM0F2ekVjY285NWZoU0s0azdlV3VLVDMx?=
 =?utf-8?B?SUhVUnJtQnlyUmNKVzA3aGhMb2V2MDVodGlETytlbDN4a2RUdkE1cTFRa0RE?=
 =?utf-8?B?OHBtZDh1WjVvczJhRXdObi9uYmJyZGxsd1RnTWl3ZENKaEFkZEc3NDRidXFL?=
 =?utf-8?B?cWhFWDhBMUFTS2RhQlpjMXBPSmw5SE9NNUJhMUNhYXRaUExPamtHWnplL3NP?=
 =?utf-8?B?dE5QVTZyeUhURVZ4Z1ZRZkhWajZxWE1BZ3U0bHZSejZGK2dqaTZZam9xVk1C?=
 =?utf-8?B?QnZNbWhOM1JITVJtbUNuVytPMU1lOTd0RVhabk5aMGpjVHpRalpDZE1rUElX?=
 =?utf-8?B?a2h6K1B0RU42STFBVXhneTZydHRBSFBvM3ZXVjQ5OUtJR3VSRk5LWVY3YWZ0?=
 =?utf-8?B?dGt0Ui9leW9LaWJiMEl1cWpObnJ3UkNOYUFIeDNJLy8raDdsVmk2L21ZZEZh?=
 =?utf-8?B?dTlKRFl5NkdjNXBGWkFnZUl3RXh1YUdkOWxkZld5ZDdPR2dzSnZzcEU4bnB5?=
 =?utf-8?B?Y25qejAzZWhhT2xjQThJRTU0V2doS3E1MUhNOVU0b2dGZlh0ZUh3YTBiSGZX?=
 =?utf-8?B?K3VFblQxY3J4K0EyeFlWYXVzWjcyWktGcGdBM3hRc3pWakE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB8806.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEJUNGtBOVJ0MW5oY2l2N2xnUVp5aUpLVEhhOXEvY1NSMjB3alZnTlRNOXlP?=
 =?utf-8?B?ZlJLeTVZV0kvWXd5b09XOHZMVXVVOU9XQ0FuWkpjL2dIYTByZ05UdnNpWlAw?=
 =?utf-8?B?clQvc3dPS1hjb2lOODdOTS9mV1M1UHo5Q1lNbG1WSTF3Qmo0RmpVTlBtd202?=
 =?utf-8?B?cG0vNnREUG9ZSDNtdGYzQjF4SG9xd0Y3cWJpT1FEVDY1d0k3ck0zUTcyVjRD?=
 =?utf-8?B?cGVVaWg5QlRnQ25kTlpnVG1wR1dTZUdtZnR2MXBrSUNNc1hhZUpxV2V2MWVk?=
 =?utf-8?B?SG9EVlRmNlVBWXRFelhZeHg1YTFyR1U4NFY3azI1a2dRUk8vTG9NcEQ3U0hy?=
 =?utf-8?B?dlRUNXhkWGpTYmhXNHFHc01QaVMyZDF5elhkKzZTelNsaW1yMGZGcmZHY1hv?=
 =?utf-8?B?OHZNdTRXWFZENXNLdlljeFBkcXdlYSt0ZEluZGZzRFZWTXI3cWxhOVQraTl4?=
 =?utf-8?B?bGNBTTFrUmFJaURGS2VFaWdtNjJXTGhCcUNVT0IzYkJCYVFqWmxpMU5MalZP?=
 =?utf-8?B?cFZUNjMxYmFIYzM1U29GZDNFZ0E0cHRBRVQ0WjkyKzVyWDI5M2YzUTh0SUZG?=
 =?utf-8?B?NXhVdTJqRmJoOTJrOVJZbTRWU0RmWnVxVWZXVFdXRHo2VXd6V0FnOUNGelBi?=
 =?utf-8?B?VUJKMVljSXhMLzh6dDFrck1HMUtscWlZSnFDLzQ2MUN6bG1LbjdmdjVTWDB0?=
 =?utf-8?B?QlB0Q05BZWdoUml1SFQrRS9PeUFsRUpGNWtzSGU0bEFWL2pKY1FTRWU1Nnht?=
 =?utf-8?B?TmhxMXJ0NWN1czI1akQ4ek5Sa00rM3lKT1NOSC84UkRqR0R3bTZTeTZESzV5?=
 =?utf-8?B?YXdtMzdLSTF1cTl3dEhseWpLR0V4M282dVVwd293b052UW5INnYwUEdPWVd4?=
 =?utf-8?B?OFZxNEpGUVpwbnA3SFNmWCsrWWk1MldDRC9WQ0dtaHJzbW1wckJTVzViREtQ?=
 =?utf-8?B?WWlUZmFNZzU5SkFndEZ5MDdrZkM3Rll1RmlkUFJIYU93Zkl0c3E4UGJ3bng3?=
 =?utf-8?B?WDN1R25ZTXhKRkt3dHVERS81clJ4ZkxGN2cvK2VLMHE2VHNBa0NGeFVrSXZG?=
 =?utf-8?B?WFU3b3NOcnlBTmdVWjN1NHVDbFM2TmV3L3cxd3pqTTBKK2NMN3F3SjhoNDRa?=
 =?utf-8?B?bTZXY0V5NlZWVzUyeUNMN3ZOVEp5aDFzcjJRZ0tvdVJjMDR0U2t5dktGaE4y?=
 =?utf-8?B?YkhjNXdCMW45bW05Wm1mTVlMeU1PMVJxQ2ZnbW5JQ2lYUzZKYVU5OCtaVTlt?=
 =?utf-8?B?UXpjU2ZPQXFCV2o1NSs3aDhSMWZEakJBTU5ZZEJQd2lLN2tlVGRhL09hSUFT?=
 =?utf-8?B?UlJGQTBFSmpsZkxPc2xhZ1lZYkZkTUM0Wk02N3RWMXhaYjR5bDZ1YXRrVEV4?=
 =?utf-8?B?RUFxRi9BMERYUFpTUTRkVTc3SCtCZVZnTWNMT05PQmRuWVNnaUZyWG13T0VC?=
 =?utf-8?B?aldFMTl6Q1ZwbDBjaW9acWZrRG9sVWtXTjlWRW1lWHNlMUZVSjNSdTdlR0xy?=
 =?utf-8?B?WS8zZjJhRmhPYmhYUzRVeUgxeE80aEZQdkVxVnlXT0xxMHB6L21IVzR6eURs?=
 =?utf-8?B?dk9yVCtCRnVJTFdtZUVwV0Jid3hTT1hxcTZwd290ai9INVRvVk5MQ2RxZGx0?=
 =?utf-8?B?VjdyT1g2TExnOEpCMkFXYkNia2IzclM5R0xzNXBwNjd1WitWaTJ6WDlkRVlY?=
 =?utf-8?B?aXlncm1ZZTd4K20zeHh2OU9SVkxnWWlQL2JrZDY0cTY4MWtpcVI5R3dFMGgy?=
 =?utf-8?B?TkFNSXJLRDY4ZFErMTNSZHAvMkMyNWZZQXZCZ2xxdUVwampUbkd0YnVtcGZ2?=
 =?utf-8?B?WGVkNVFnM0FyNFQ5VE1ySWk2eVoyYUdkbkxYQlVTZm5UM2U0M1BGNzVoM05M?=
 =?utf-8?B?OUt6MGROT0RnQ2ZnejJoR0ViMTBGbVVHRUFqTEVBdlpxamZmNkJoOUd4NUFi?=
 =?utf-8?B?eVJzWkZZRmEwNXI5NUduVFNMdkM2aWswUmdRaWVsVWQvaGtRQlZIQ1g3OWwr?=
 =?utf-8?B?TUNiVlN4emx1TUpHZmw4K2tyMkg0b25xaUU4KzNVTjFKMVRFaUNqaU9Sa3Bx?=
 =?utf-8?B?dUEvR0gwbjBBcXNzOFJZRkNKbjZrVlAzcEdKQmEySW52SUNjZzQ4VWw3V3hJ?=
 =?utf-8?B?QS9hSjBVblpnbHVLY011SkZCRmFFQjUrejdDeEJhcnFZYlcrS1F2MnBJby9U?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f928d0-3fb8-4bb0-a3c6-08ddbe2f99f6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:56:22.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QO1uOAWatqYGsRHhNfnJKn8lK7CuUorcPDHmDynO6OTeTWIs5/vgSzc5shBUjcDqDVpSENecYJCbvQGRx/+h59LZ/XftL41SsOafPwcr6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8026
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEyNSBTYWx0ZWRfX09d7e4vQ4MNd GBbKuUliIy3YUjsJjTfh8MpxRuF3hKYSsTJUk7wugUa5i2dx8IA2CYZRua66wHT0wvz3BsK2TZ1 Sg0Nw0VphonoPkTPjHKxEyRvr0Xg3bjYOJLFj5tcY/SF5RqNYk+FmqDkNQop0sujJZArlueKM0O
 QBE1vlnQ1CRd60jxo/hl/4LbVp2jeHx4kImu7Hr8a/udD+0A6uVLoRvdyJhXluqmSiw49o20Co4 THwFLAPV362VQrWLWVSo5jRG8j1VQJVddSv/5n1WjGz2bOekg7vkiah55qCjfw2DEv3tM5LYxvO 9RFD0nCRz27UtaTMZMagIdGzdgQR/ZIFSTiGJkjr0hNEuVIaTUiS1Sw92VYNomIe0c82Gjnc3EP
 tiwdUwYvHpx+afEtYVQNRcXlnWnIhja7iRZuAzqU6ixmgtla26U4D80Je1uaw8VgHzJO6dzV
X-Authority-Analysis: v=2.4 cv=V5590fni c=1 sm=1 tr=0 ts=686d3198 cx=c_pps a=FPEtuPkCzHsnJ8XfbyoA9g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=yCOTQmV8_SjKz6MKC4IA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 1GsQ8-EKmn0x_t1h5YwdL76v_oBbDlKp
X-Proofpoint-GUID: 1GsQ8-EKmn0x_t1h5YwdL76v_oBbDlKp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2507080125

On 6/27/2025 1:49 AM, Christian Loehle wrote:
> On 6/26/25 19:26, Chris Friesen wrote:
>> Hi,
>>
>> I've got an Ice Lake server running 6.6 PREEMPT_RT, currently using the acpi_idle cpuidle driver and the "menu" governor.  I'm seeing some weird behaviour with cpuidle and C-states and was hoping someone might be able to shed some light on what's happening.
> 
> Does your kernel include
> 3cd2aa93674e cpuidle: menu: Avoid discarding useful information
> (since v6.6.93)?

Finally got around to testing this.  It looked promising based on the 
description, but in our testing this didn't resolve the issue.  Still 
seeing qperf latencies in the 120us range.

Can anyone else reproduce what I'm seeing?  Should be pretty 
straightforward to try out.

Thanks,
Chris

