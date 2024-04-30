Return-Path: <linux-pm+bounces-7377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D536C8B7A37
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 16:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF2A1F23FF7
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B991527AB;
	Tue, 30 Apr 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OX7XVGzd"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7ED152781
	for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487776; cv=fail; b=CfXaI7L/JKgifG2lww4gxe0zsYpBc4KRvwqQ06RRqQUekMw5kXhKOtKpk/CHvkoTFjMkzm++DqTDZPKqf39vNCRRYcW/dRSCCJqN6qiifmfOkOCNKUqC6sMetctywbXOfjEne35mZNWZzJHu9QcURJ5Z9YzauGrkRnbPURCE99M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487776; c=relaxed/simple;
	bh=CQthAVOTdbVHsJwnC6oIGFCAGW2xmJINzHSjh8G6g9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a1h++yS6My0ODnMUqbvjwgIylqjqAUKpJTUY6GbjrhIMygNEBt0D7nTCuz5n42JMDnbxqMlm1DKA9hc+Hgg1RWv4Qqq5Ys3TFsDTiKQwAwrJL3YWacaaYtiqCfP/2Yu/J4FswiMwHiGhkEJrf0mwfsMmf3AV++AAXeF65lx6wLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OX7XVGzd; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ0E2bz/mVjdKGbVOZe3/h3EHo1pNlVkC9ygasKt68C3jfASR4RN+i4LUitpdUM6j7WqL3KxzuWS43HfMnu2MOffNwvdx+eRHS0lw4mtJW6EWEIclSmIJhlF7TC/rpufSuUIondkh8djTKwLwSZIwoJsPpt4btOVP5+b8YR2LHX54h3wv7VonuzwSbFVd0m68zQXFJl8v9LlLBprsYfP7c5uSSOhr7PMSpE389xdC1MKH6hah7Tp2Y8LuH1hb+eWSkS+b5/ifTo+N/Q6CkXnRSB1++RBM5t0o0U2qOskFm9Ra33rWXKvbgWeJk4tkB8mQro2w87m4RYe+DN7d0EKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyUuKYMXLHohxiosyIxV3qc4TnaIyH0HnlRq+jwlKiw=;
 b=P1uzN5lNqv0m5ceyYWE4uyJ/qI5ijMQ39Dx9GWA/c19KPGXcgg5IQZfS8exQv//GIuN9GQFtLsu8LrqB7Dumd+OhmUW9WYih7b8jUBwjiKq/DC5rXnhg3yEgKqbkrGeWpL7Zw5ehO5rhjAjeQznGbA7D2kHd4sf+YHOPHJZSJjRg/3vpsNo/o7tqkmvYq0i10IRfIkND1sSBzYsi3is/hwQArRNCTNYQ7pi40jNq8QhJs/ZZ0LnlawfR+Qa7gvt49MhXlP1y4ES7TKPiUrMvE/Hvs/iLtQD1ncKodxraSGJRBk0YrilWKVV77CzlkLWIEX0TWRzxoZeqZ2YCv5F0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyUuKYMXLHohxiosyIxV3qc4TnaIyH0HnlRq+jwlKiw=;
 b=OX7XVGzdFfFnHLkTm7GbR51Mkiegu9gprFtL1DXj8VtURSONTjGO6kjSQqAIOGiMBeXsyOJLgbUul0EjM6lKNslPaIYBwHEmpOdEmwLsAKvZ58ujZQa3CrxcqSHWmLFJGID2pMxPZTG3HliWmxyMe0AREAsXCbt0tN7UTG6tcHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 14:36:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 14:36:08 +0000
Message-ID: <2b4930ea-c8c9-4743-aa46-f387056f2a1f@amd.com>
Date: Tue, 30 Apr 2024 09:36:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: sleep: Optimize the pm_debug_messages_should_print()
 function
To: xiongxin <xiongxin@kylinos.cn>, rafael@kernel.org
Cc: linux-pm@vger.kernel.org
References: <20240422093619.118278-1-xiongxin@kylinos.cn>
 <20240423081723.412237-1-xiongxin@kylinos.cn>
 <2f07ea21-c89b-49dc-a7b6-8c4e207d1af7@amd.com>
 <408bbf09-58ef-4d55-ba89-a64dbce25085@kylinos.cn>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <408bbf09-58ef-4d55-ba89-a64dbce25085@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0177.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2efa6f-55b7-4ba6-6dcf-08dc6922dfd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1VyQXVxUmVEZXBSRUFOYXM4aW1rdHA3clBRTmQ0ZmZ1OFpic1hNcWpXemlX?=
 =?utf-8?B?V1pmdWJjM1BDUjg2NlJkYVdZYlJHeU9ySmM4d3NZbWd0bFdrSWJJRkM5a0xn?=
 =?utf-8?B?YUQ5ekdOTnU5V1F1b2U2TEsxeGl4dXhJUHdmS29IQmJsWmQrVDM1VEhJY3ZG?=
 =?utf-8?B?TXRNT2V3Ti9RYmpjMTRZV0g4M1FSZjlpYTNnaktpN2hIcHRxNUV4d2NtS2FL?=
 =?utf-8?B?ZitXeEVwMFRaYVNBSmQ0YVdsTDZsVXFyTDhQN0MxbDcwYm1BekxsdUcwZGJV?=
 =?utf-8?B?ODJRblVLVWZCWitnOWpEYm1nT0lmYXBCR1UvemlsZE0yMUkvdXdjcUdqcWF4?=
 =?utf-8?B?aVVMNWdoVnlCQ3BscU1Yem5tbTBManoxM3VpV2ROOG9WdEdvalE0SjJpYWZ0?=
 =?utf-8?B?cXFLR1RPRnowS1dDY1cycjkwaVJXaWRwckd5K01uYWtpaWVxYldoakNEdDBk?=
 =?utf-8?B?eUtMOXk5ZkRuYTk0clB4ZjVrNktEdlVhWFpLb3dSU00wSjdiOXFyQ1NDcklG?=
 =?utf-8?B?SmlKOU56a3MraEtXTlJ3U2ZxM25FK1FTenY1WEdFZ1gvd0F1Um9DKzdFS1FZ?=
 =?utf-8?B?cW9qbEF5K3dDeENwWVozQzVzcDRIUDlXSTZVU25OY2ExbytlMHZmbjVNeXEw?=
 =?utf-8?B?N1o0bllYM0orM1B0bVYxc0pkZkY3OUs3WmkrcXQ0MWhoS0ZSOFJRU1NiZU04?=
 =?utf-8?B?Vm5RR2RmZTdsRzViRmY2MzRZeS9lTmVDN0dvanpjSDFsb2g4QjdRQWFzWmlH?=
 =?utf-8?B?S2I2M3AvSHVLZlRFbmtNM2NPOTk5c0VFMWxRWHpNUkdNUDFhcDNXNDU5UDQr?=
 =?utf-8?B?YnZhc3JqQ3ZTazNEcGRJSkh6OGllSDYwYWRuYkdMc0ovZjRGUVJzY2RxSTJS?=
 =?utf-8?B?dk5TQ2NRRk15bXBHT2RSdmxIM0F1M0R5UHhNeVF0dFdZVVkvYjhEZk04SG0v?=
 =?utf-8?B?SjdQaStLU1o4Sm01WXE4UHEvWDQrYUJXUmtGT0NjQ0FJQnZibmlnVHQybEF2?=
 =?utf-8?B?VmY0b2lWNGoyRDkzWnVVejRzN1JrbkN4WVlWdVA3WW9jQ0xwejVXb0QweFEx?=
 =?utf-8?B?amhMS2FlazJhWkI1TWhJSmZ2MVZmSWNMeGhIYno1Vzl3bFBJNjJ3NWNNYmc0?=
 =?utf-8?B?OW0xazBneE85R04wMVE5UU1IRWZGc3BoT2txL0JpYnAvVnRaQWNCVGd6czBR?=
 =?utf-8?B?L0VNWENHc3pRZmx6dlA4c1VsOG1ERjZhRG5ZbzBqWDJyWVR6bjVaaU00YW5Q?=
 =?utf-8?B?SzEweUZpQ1dxdElKQU9oN0lrZmxPR3dQWGVSUEtZRXJqV2s4eXFEM2w2cjNx?=
 =?utf-8?B?T2xaOXozSk1ISS90Q2VlYjd3ZzE3cGlBK3JCQmFvN1FxZ1RIVm9FSTcwUXN6?=
 =?utf-8?B?ZWhZZkxVNXR6SkQ5S0I2eDA5SGFTVGhiQi95Y2ZyR1BvNjdFU0gzRFF6MC9l?=
 =?utf-8?B?MTA5NTU3b25HNjlkYXJ5WExSb0lPL2lRU0xwTmgzb3ZBb3hjQnlEQUlnbTU1?=
 =?utf-8?B?UUhVTUxxVno1dS9HOHFUUitoR0JoOWt3NDVqOENEVTRtVWE1Znp6aWZKNVZm?=
 =?utf-8?B?QWFUM1pPdG1TTXdHTEpoN1hGSXJETGhOSE10YndTVzRId0hKMVhid2Nqendv?=
 =?utf-8?B?VHkySVR3Z1J1WkZqNHhMcGl5VjMzQXhzS2IvVGgrUEEyNG1HTkh6NUNiN25k?=
 =?utf-8?B?WmpET2x4Zjl6NFpKVVQ1dlNpMG91bWkrcXhDM0ZBWnpYY1QwREpZUExBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUlDVVI0S1ZHRTg3VlZsVlo5Uk4yUVlUOUxRYXNDNUFrMjZBNXNvOUFEMkdC?=
 =?utf-8?B?L1E5K08xc2t5Q080TWFUNkhVbUtoNk5LbnF2T1BmM1BqQlA4MFdWdktqc2RG?=
 =?utf-8?B?bnh2aHBDeG5RS3RWV1FPZEVFWFFhNzdDdk9qelczRTk5QmZHSlFqNUViS2Ra?=
 =?utf-8?B?bnRnOExoVEprTFNqOE1BTUhXOHM4M09Zait6MXZTc040Sk94SGd6YWYzTlJv?=
 =?utf-8?B?Mk5icnEvUC84ZEtpbE9kYVRXcDR6b1g1WkEvQmxoMzJCUjBGR0NPTi9VbStk?=
 =?utf-8?B?RkFkM3dyMTNMb2pLbGkybFlOcmgrV3MwRkNZSTFnUlg5WEVtbWErM0FlNk4r?=
 =?utf-8?B?MGhlMHd2aXFWK2lVNHphb3VZbVJXVnp1dWdXYXZoeW5KbTB3UnFlNkVRVmtE?=
 =?utf-8?B?RXQ2dmhoalN3dzJJV3Z5ZExKVmJWMmY4QUZBYlN0Tkt4akl0K094VUdHeEl0?=
 =?utf-8?B?bFAya3FzWHJPQVZLY1dKWm9xZ1h2VVpFYVg2YldxZlN3ZHVHSWgzaTBJWUZU?=
 =?utf-8?B?Z0d4c2QvaHplc1M2a2xWMWhZN2YrcGpYWXRsVzV6KzdLQ2tYUDdwUVU5WWRX?=
 =?utf-8?B?ckxrbGwvYUFtbUFZOXBieDBZQ1NTelg1eVFIU0FLWVlrV1BFaEY4Nzlma0Rw?=
 =?utf-8?B?UmdNdlducW42ckk3cUY4aTg5NDJkYW9CUDdYREFJMURka3ZzZmxlVFJ1Vmp0?=
 =?utf-8?B?elNpV3UvbHdIVnIvSU9vRlpuRWZsWVBFQWo2Y0N1M29RcXlWbGlyQmFRajRX?=
 =?utf-8?B?VTU5bmxpWFRheENSQXh0SXByZ0dyQWV3WkpCVlU0YlNqMHFHbmZxYkJWcDls?=
 =?utf-8?B?ck1WUkxncWhxcFNTMHdnK2pMSGN0QURkWElidFIzT2QycVFuSDRrZFpVVGR4?=
 =?utf-8?B?OVBqQ0tOa2h3eDNNakc5U0NVam5Gc29aVDZCNTlzZFA3VEc2TkFJeUVzMWxs?=
 =?utf-8?B?Sm5QV1Bsd1I3cklSSDh2T1VhWFRYSUU4cFczSk95MURzWFNSMUpub2JKRS9N?=
 =?utf-8?B?OGtzNGRXRFBJL1kzNktFM2Ricmhrbmt0QmJKcEdmVHQ3L3duWlBHQ0tLMVA4?=
 =?utf-8?B?Q3pZVzNtNjNWaGNza2tpY1ZUTTdVenB3MnZtVHUyMjU2YjR3R2xTazFORkdR?=
 =?utf-8?B?RWNMSEwvTVV4TGgxQXdnNC9Td2V4d1dkR2NGV091Y01RR093cW9RQ0psY3Jw?=
 =?utf-8?B?Tkd6azlyOUFPUCtuazZWcHk5TkFFaGV5TFJrZHhpUkJ0TWV1cFlvRXR3cEQw?=
 =?utf-8?B?MHhjUkljRFhYelUvZERscytiQ0ZRM2d5OW5ucmtPSmExQWY5VVF2aDlXeTR3?=
 =?utf-8?B?TzQwWFlTSGJET0JzTmowaTMrem13TTNHdkxORVpDM2FxYytUaHBqY3JOOUlJ?=
 =?utf-8?B?Mnk5anNvSTNjY053bmVUNWZvVlAycEZtcWJweXZlTFRDNjc4Um91ZmpHMmtS?=
 =?utf-8?B?TFZsc0RRTlhwZFREbkZLdTRhdElzQ3ByN2RUdjlRY1pqTzZSTE5ONzJNekdW?=
 =?utf-8?B?d1ZqUnJQSFgzMFRJM2cvSEVkbXBhZEo0R2xwMW1ySzhKdEJtZFROTkJmYjRK?=
 =?utf-8?B?K3F6a1V0ZnU0bTVwb2xYQXVjV0twSXBobU9EMjlqS1c4Tkp0Vms1bnY4SGc0?=
 =?utf-8?B?SVlzUkt5M0RnV2VVcE5nM3FLWTBTY3ZGQUJhN3BMS0dNT3NaN0F6c0FUbFBE?=
 =?utf-8?B?cDd4VFQxS3Uvc0tyUnRDUmRtUEZqYnVOQ0JXSXpLemJZS2t5Q3VTNXh5RGNm?=
 =?utf-8?B?STBRdXV6Q2UwMllsOGpuaWhDdGlFQ2JGbzBqL2R4Y3k5QkJyYUJMQ0JtNGxp?=
 =?utf-8?B?KzBGMHBzVTZTaUt0YWs2d1lYOXRBZHErSjN1RGFJMmpvYUlnamo2SkFNZGpF?=
 =?utf-8?B?K1dQd3hFKzFtb2lZQmZTajZBdG91c0V6NFdiWFpBNmJGSnRSaVM3S3ZwQ1pR?=
 =?utf-8?B?NDQ0V25FZGZ5bWZkQy9TWG4wNHh3bUh3TncrdUdmeUMrZzd6eFZzV0Z2azh6?=
 =?utf-8?B?RjhYeWNwcDlYSlpJQ3hhTERiMC8yWWFaQ2x0Ni96QXQ0ME1xTGl2djdtZGJV?=
 =?utf-8?B?M29RV0xoeHlwaE8rQzJldS9RbU12SEN3MnF1aTBVaGpvTnFSTFEyN3NRd3Vv?=
 =?utf-8?Q?wpR19ppfs8hbRbV8uPRdUkgY8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2efa6f-55b7-4ba6-6dcf-08dc6922dfd7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 14:36:08.6718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjAqhj0i+72PpdkjUI2PnZzNOlu5Aug3oQmiQM0Z6k36Djijfio35AdRqxvJsiPOOCaG+jB3vDVUq1IrPSsZhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284

On 4/30/2024 03:45, xiongxin wrote:
> 
> 在 2024/4/24 00:52, Mario Limonciello 写道:
>> On 4/23/2024 03:17, xiongxin wrote:
>>> commit cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg
>>> messages at suspend/resume"), pm_debug_messages_should_print() is
>>> implemented to determine the output of pm_pr_dbg(), using
>>> pm_suspend_target_state to identify the suspend process. However, this
>>> limits the output range of pm_pr_dbg().
>>>
>>> In the suspend process, pm_pr_dbg() is called before setting
>>> pm_suspend_target_state. As a result, this part of the log cannot be
>>> output.
>>>
>>> pm_pr_dbg() also outputs debug logs for hibernate, but
>>> pm_suspend_target_state is not set, resulting in hibernate debug logs
>>> can only be output through dynamic debug, which is very inconvenient.
>>>
>>> Currently, remove pm_suspend_target_state from
>>> pm_debug_messages_should_print() to ensure that sleep and hibernate main
>>> logic can output debug normally.
>>>
>>> Fixes: cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg 
>>> messages at suspend/resume").
>>> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
>>> ---
>>> v2:
>>>     * Resolve the compilation error and re-submit with the fix
>>>       patch.
>>> v1:
>>>     * Revert the commit cdb8c100d8a4 ("include/linux/suspend.h: Only
>>>       show pm_pr_dbg messages at suspend/resume").
>>> ---
>>>
>>> diff --git a/kernel/power/main.c b/kernel/power/main.c
>>> index a9e0693aaf69..24693599c0bc 100644
>>> --- a/kernel/power/main.c
>>> +++ b/kernel/power/main.c
>>> @@ -613,7 +613,7 @@ bool pm_debug_messages_on __read_mostly;
>>>     bool pm_debug_messages_should_print(void)
>>>   {
>>> -    return pm_debug_messages_on && pm_suspend_target_state != 
>>> PM_SUSPEND_ON;
>>> +    return pm_debug_messages_on;
>>>   }
>>>   EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
>>
>> Did you miss the proposal for fixing this for hibernate by adding the 
>> extra variable to monitor?
> 
> Can I change pm_pr_dbg() in amd_pmc_idlemask_read() to pr_debug() based on
> 
> pm_debug_messages_on condition?
> 
> I suggest not adding a new variable to this.
> 

I don't understand the opposition to the new variable.

The whole point of /sys/power/pm_debug_messages is so that it's a one 
stop shop to turn on power management related debugging at power state 
but nothing more.

You turn that on and you can get messages from the core and also any 
drivers that want to emit messages during that time.

If changing drivers back to pr_debug that means that users and software 
need to manually turn on BOTH /sys/power/pm_debug_messages as well as 
dynamic debug for any power management related messages.

Whereas if just adding another variable for a condition then just turn 
on the sysfs file for any hibernate or suspend debugging.

