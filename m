Return-Path: <linux-pm+bounces-13452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF6796A80E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 22:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC691C2430E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 20:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579DF190463;
	Tue,  3 Sep 2024 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aVw1kzfF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB131DC725;
	Tue,  3 Sep 2024 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394206; cv=fail; b=nvcEW6LJNvK9PdjKhtXIN/PC0NKYzsrAzrQxyqnmMvSzOSL+THKNpqf6QTf3OL2P1HvZA9oUaHIpjSiu6Wbm5TndJDWGmnBXtP3gNjzx1+oKZGxVU/QqxIovpWyIxZ79hQpxZ79LTb6DuQNcExJ/1KNIEM50QmG8gsWhJ1QODmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394206; c=relaxed/simple;
	bh=2cSoMVSueaPxUWIomS/CcmnzzaPfkbNwGbY6Ya6hZsU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BjAJf7H4Y7Ne7LaM6VRQpgmZCu+388yb7ED7dNhhH6hVQARXchrXj8k5VLaXLamVi+CqTIuar+Ng1zxiEUHyuE9nLAu4BlbhhnDqIn5zqQvRA05gz6L0V03o1uCnPSzVT+n6SniglIRAW4yoYAm42J276skRL4B+ndCIUzw/GZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aVw1kzfF; arc=fail smtp.client-ip=40.107.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBC+VV7iWczV980+Qj1Msz1dnP8eOaZl615B+kSVDW5OhEUy+MdIzFpc8QSKGWMePP/LNj17EeexYAP5Y7h+gxS50hAujLyIFm+uxBnRdX1lHxYujbq5s0+bpd8yYMCJQ5VLdxTa2JPm8vbuLJkDZkC+e9KNWKCKg5NZDyrNpWrExHISbD+ITTyNjxm6fySyDth4nmj7VKjfR5so6y1Y3sUgXyjNwRMcQtSlT4Tg246gAZ8srYzxK73Kt5irEm42JgTSDVl2ELaG+5wL9VH5vCOrSiRDo5KOe/I9rCgItHaCzk2jJyj0AuDUcjnvLvtcX3Kr2Q2MsxmDsu5HuaRm2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2/uQaciw3tfqZKGKbrAP0GR2qWNjZkfsldGRrajQbU=;
 b=HbPqIqz1uRwVXUV9OpmzlJ9EfAGONyVGudKHc+gt3slQ0LXdTfgJWxQHIbx1OtQHJtz6pjgZhV7+FKiCUiObOc9ekvsujVh6ZEaNX+vVzOSqTNMjuyyWkSCpdksw8kYzD+FBBxNRyzCohEicoNE101WUlWt3RDzAsSHs55S+tyxnBY3CcnZx+94uybMSdWB/AyAMLXiujvR0UxpZ16JVTTNDI7hqBvmXh423XQdGzCGWWc3069FMj3VW7tdZW8yqkPK6Q7D6IY9pZx6x5lPQyYo/o1Z2oMp1IoewGWfYHCunvKFcDtGoLFVtWIJVneGIC4QPv2rvJvnq5SSbjjkOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2/uQaciw3tfqZKGKbrAP0GR2qWNjZkfsldGRrajQbU=;
 b=aVw1kzfF2Kymt4VCoqNfPyAdpI3Knr2Rg+0MwoltCrwHvq4F0YIICL+Du/AQec5LPUD1aKryEcE737l9+nuoWD5QS+oyVFDleFcLAVcQXXJaaWWJ+pwypzDcvbaAj0K4Zu+Ol1mKIPx7jTbk0YETagqFfWLuKiNV2nUVdpYQXho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 20:10:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 20:10:01 +0000
Message-ID: <645f2e77-336b-4a9c-b33e-06043010028b@amd.com>
Date: Tue, 3 Sep 2024 15:09:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the
 scaling_max_freq setting on shared memory CPPC systems
To: "Jones, Morgan" <Morgan.Jones@viasat.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "perry.yuan@amd.com" <perry.yuan@amd.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "li.meng@amd.com" <li.meng@amd.com>, "ray.huang@amd.com" <ray.huang@amd.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Arcari <darcari@redhat.com>
References: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
 <20240702081413.5688-3-Dhananjay.Ugwekar@amd.com>
 <bb09e7e8-5824-4bc1-9697-1929a4cf717e@amd.com>
 <d6392b1af4ab459195a1954e4e5ad87e@viasat.com>
 <bb49cd31-a02f-46f9-8757-554bd7783261@amd.com>
 <66f08ce529d246bd8315c87fe0f880e6@viasat.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <66f08ce529d246bd8315c87fe0f880e6@viasat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0049.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: b29d8c78-197a-4064-e1eb-08dccc54646e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2hUWXJjbXZWclVldk1VNzNEZ2daTUJ0b2tyYjdrY2VyT3drSTFUMmRSNndN?=
 =?utf-8?B?SU5oTmcralE5VHFMK1NEMGl5eWlzOFVXcm5BcHAxQ2ZrU1JnV1l1RTUxeTFk?=
 =?utf-8?B?eXpLYlBaSkhUTU4wWnh2MjJZWWEvTE5qU2tkbk1zRW5XZjZVS3g0MzA0Rlk5?=
 =?utf-8?B?NCtBWkpZbThWRlRrdUl3Sysxa054ZVA5SDhha1RsYklLQ2V0T2JMbXV6ZEkr?=
 =?utf-8?B?dnpHL3R6NXpMN01iMmYyYXp5SGFyWnE1ejhJdGZQNnNaSkE1dzdISUpqQ0sy?=
 =?utf-8?B?b0NnZWtWQ1FwM2diemZGdThTcVQzWHdEbUNRREVvUk9GdnR0ekRDekNNR3I2?=
 =?utf-8?B?SmVsUjREY0haYy8vaFIyNDBJMzJFbmtuZmt2WlN1RURBN0NNSDRFTEMwNzZF?=
 =?utf-8?B?R1JwNlg4RGFLWmRRSWwrZThQMVhZNHlvQTVycU0ycFBMcG9acnNrK2p5VWJQ?=
 =?utf-8?B?TFdManhQSDRVS1oxZ2tJeWlKVTBqa05sdGtBcnFmZU5LRGR5SmJhdzA2MEF6?=
 =?utf-8?B?dVpzbk5TZEI0UWF5Z2ZWSlErRk1sVGZSNzYwSkJidEg3Q2dpT1ljTk51UTBa?=
 =?utf-8?B?dHplc3d6WW53TWFrZFR3bGhUYThWbm9wQkhyUjZJZm1ldUpDK2dXQVh2d0pZ?=
 =?utf-8?B?eHpzQko2WHJDOEhnOUF1OWRZb0lid3k0S3lDb29tejV0SlBIcjJMVWQ5cXRW?=
 =?utf-8?B?NFZvZ3JQSzNJb2VzVFdyenhyeFdZTllSR3JwVkJDOXptdVp0bk14aThLcGZj?=
 =?utf-8?B?Y05OSTB1UUx4aitFYjZrK0ZqL0xvN3ZhTENySEJ2cDhXaGhrZXdqc28xZXIx?=
 =?utf-8?B?WkNkVE9md3d2RGhNSGR4aDZRVWpLcEQrNERJdHhFMHdzZG5JVVBhMWJoLy9D?=
 =?utf-8?B?U0dTQktzR2ptRk1xOFprMGhRcTFhYWdoN1RDWHVwNFVJeXVuOEFOV1R3Mzg0?=
 =?utf-8?B?SElJZ1Zod1dzQ1Y2NzhsTnVZKzFNWGFNdFFvdE5EUXNVRmJvbmorc2JsS3Ay?=
 =?utf-8?B?Zk1nVnE3N1FTQmVwcU1qODFjSXFYeHQ1TW5rVjJNQ3JydTVubGlLV3JxNHI3?=
 =?utf-8?B?cUg3dVBEYVZES3F2eHB0Tk5JMlp0UUJmSi8rM1liRlNFbW1rYVEvS1JpVTBH?=
 =?utf-8?B?bzBMMHZmeE5YTkhWaDF3THNDY3IxYWc4K1l0Q1lxTUM0SThxbzBHdnJKS3or?=
 =?utf-8?B?MHlueDBQMjUxVmVLWCtyQy9xUm1SMitKWnVNZ201dEl2cUt1QStXTnJnd2ZV?=
 =?utf-8?B?UEFVSUIrVlQxMWxVVm9tZnJMTTB4M25YbU1oMkkwS3ZqOWxINnk1Ty9hTitx?=
 =?utf-8?B?QVNHT1RQaEFZaTJVN3RCZ0tlTnA0RGpFVUNZNXRWMkV5cDVjMmhKRWpKM3dC?=
 =?utf-8?B?c0tWakw0VEZHdy9tWHovdWJHTDFlVzBWOUNPK21Pdkh5Ukc4dkVuSEhRS2Nn?=
 =?utf-8?B?SVhzSTd1K2RlMitSQUh0RGNtaDlWRmZzYjZGTytmTjh2TGxzRTVxaTBnOTVC?=
 =?utf-8?B?ZGFIRmsrY2lMcmFaNWl4RzZLVmpWVjNsZVZFSEhuM090Zm1jbFVCMmk0blVR?=
 =?utf-8?B?VWVoRTB6ZUJ5T1hHTk9NemN4ZndlVkNLdUZnTWZ3dzNzQkhNRE9SdGsrMkxt?=
 =?utf-8?B?d2lldTlBdUFXSFBhaHpwdU51OFZzRlo3ZWl6MTJaamRnUU9IUldiYzFTVVVX?=
 =?utf-8?B?THpkaVJVQUJtQTNiK3hKb3JjU2Z2M1ZmcWk5anFlbTRwQXdPTUNnYkxRT3Jz?=
 =?utf-8?B?RFlodGNsOHEyYUswTmxnd3dYNlYxbm0zRytQV3VkenpsdnRjeUd0ZVN2TURx?=
 =?utf-8?B?U2Y3VVExSGlodXhpU2theVZ5UWNuNXhpaDgzallhdUVwTHh0bHgzZzJqL1F1?=
 =?utf-8?Q?oleW98Rx2v05j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eC92UEZUNGFxQlkvZGRMQnA0M3lVcThyRWhWMnQ2WTl0eEREUlUxVlZQekQr?=
 =?utf-8?B?OGZOWnZvUVIwU3NjNjBkbU42Q3d0anlZdUtGeVRuV0dHbitxNndaTlltd1lp?=
 =?utf-8?B?RnJkQUlhL3ByaklUTUU5NVR5OVlGNzZYT3Raak5tcGFKQUlUZklQTGZ5Smpi?=
 =?utf-8?B?bkEvbGw4RVpERjNUT1J0RS9jY2NhbzJBWWlYN0pSOU9seTJVTUNlbUR6UDhO?=
 =?utf-8?B?bTE3YWpVbmxiU1dRcExwZHBKUmNIMk9hcHJ1U2puNHRBTDlUKytKSjNIVjlR?=
 =?utf-8?B?MlZOZjhDYU90MnNSamVzczhQSHhXZ2krL01WU3BmaDd6WTZnM29keklkU3BP?=
 =?utf-8?B?a3FtSUVlb3o4Yi9XeU5PRnJjZGl3OTdidFNBaTNpMURONFdsejRrRFJ2RHlO?=
 =?utf-8?B?TktjcjdDRlFBOW10dERGL2JxTU9tZXpXV1FhVUg0NkUveVFUdXdjZFNpMjBq?=
 =?utf-8?B?U3ZPVkFCeDBRNHMzM1QzMnBDK1luN3hxS0lRVFRUUnVrbDBVa1R5T2ZVa1Fw?=
 =?utf-8?B?VmhEMkFQeVZHOGwwQ0h5VkRmK01wUk5Tand1OVRGbXBKRm54ZnhKWTMzT2hI?=
 =?utf-8?B?ZkRIUC9GQ1NpaFkxbjNlVVJ4eGZJSFh3UlEvekR0S2hnVUJ3QmNCM2xlVHE0?=
 =?utf-8?B?MmtJRlRld21LWDFZYkhtQndkbEx3NythaTNQZ2MzTlJMcm9PMmpmYmpRSlZp?=
 =?utf-8?B?czNTUHdsb3Q4K2JjWlFiM3lJTm9EWHBrcWxjSVlBaVlQOHlJVFMvbVBMVE1t?=
 =?utf-8?B?MDQxNkpYR3lSMlBxalRTTUhLSVdjMlVvazVPSVZVZ2dibXF3MTlTVlVIb2or?=
 =?utf-8?B?ajFyUnpDR3BaUzFyTUxiYm5FbXMyeHh5Z29FNDJLazk2RjJ3TFlWRVpLY2FU?=
 =?utf-8?B?Y2dOVE9scE9tUDYxTHNkTjN4SmpEWFRrcDc1TFN0YW9xRCtNVXVEMzVmNi9h?=
 =?utf-8?B?M3FMQ283VGdZRGRBOTJNclNaZlRmSXd3WlZBMFBlaGVNbGJUczg1QUJBdGpr?=
 =?utf-8?B?amtkdnVYQ2lOOVVsekxBWFdWZXU4Z0JTbDRibzNBQS90bUxGbm1pMDlhZUlC?=
 =?utf-8?B?M2xIY3FyQUVaY0UzUm1kVGZTdTl2bzVVVWdxYWNiVlF6eEJLeXpMODNRTjg5?=
 =?utf-8?B?QUhaTmtMekNSRlR5VldzZmwvT25qVFlUaWdONEVzLzZ0SVJEZzl1c041WkUz?=
 =?utf-8?B?Q3BrdHVnMlZrbjhVVlZCU21DSUczMm8zTWRzSExqeGc0M0xKWnVQeW80Nnk5?=
 =?utf-8?B?dG1oeEFmWEVjWHNlWkhxbGNtc212MkhlN0dNUGFFb0haZWRCRk1tR1ZQN0Y2?=
 =?utf-8?B?ckVQTG5jcjhSc0ZvUXpUcTJtaEFRT0xLZFUvK2tPajZuaGlRZzBaTTl3MCtn?=
 =?utf-8?B?QjM4S2xhYkFYYXJ3b3AvaG80NXNMNkZmaXV1Mklqd3NSSzFBemlza0RheFJk?=
 =?utf-8?B?SVloTytoWHJQNDA1U3lKaHp0SGY0bTB6RXM1SkJiUEcwdFczeFcyRTFkQkdO?=
 =?utf-8?B?RmpheHlTZlgrWENNbzVQbEtXM205VUVrWDFnWjhoeldXQzFVNUxNVmZwNnhs?=
 =?utf-8?B?bDZPbFY0aTA5UlVPa2Y4aTFEQ1Uza1ZmMTYvczVGTVVwbllHSlcwVUdhQkY0?=
 =?utf-8?B?UFhxenUvV3UxMC9yWGw1TFFWZkhuY0l1UXFRQW15YWliV3hLTksvSm5tMktG?=
 =?utf-8?B?MGRWeXhIc1lQMDNBdUhRU2E0bi8yWnNJSVhoSWY5a0NMd3BGdkIyMGU5NjBY?=
 =?utf-8?B?T1UxYzVIQ3NqNTNRajQzaFRJWWllYkYrUFNTMVZ4R1Jia3phc0tRd2dNbEpy?=
 =?utf-8?B?b2Y1R1M3a1pPSkkrTFZlMU9NSy9qU2cyN09lNjlSblVpMGhTZXpsYmlEQ2RV?=
 =?utf-8?B?SFR0ZlQ0UkFKNVhaZ3MwM3Q3dFhqUGR0VDBlcUdnbFlXczVpb1JkcUpZRy9M?=
 =?utf-8?B?cjdhVWpiMHlWSWlLMnhXRGNMUVQ2UHdCYS9XRGVheHBGaE02dmw0RENsSTl6?=
 =?utf-8?B?UCs0a1AvOEh4Q1pOUUdycFNzbzFOTnJ5TmZpcjEvVTNjNmxycFB6TU9MeFZB?=
 =?utf-8?B?ckV6UEtDaVFodUNubXR6Q1M5aEkzWDkybmk0MURPc2lxVFFYejdTeVZ5M1hY?=
 =?utf-8?Q?OgVM4xnfi1Ukf6Dv4qUv0fJZX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29d8c78-197a-4064-e1eb-08dccc54646e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 20:10:01.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShV/e0OkiqjhxBPm/gvXU2iTse0RjvjHT2eMO4oawUDPO6bFjJ9IJlOnBg/5DFrumuj8VuFbXUIYbO+7RwSxog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753

Morgan,

OK that's great news that it's just a backport effort.  That same commit 
also backported to 6.10.3.  Can you see if 6.10.y is affected?

Ugwekar,

Any thoughts on what else needs to come back to 6.6.y off hand?

Thanks,

On 9/3/2024 15:07, Jones, Morgan wrote:
> Hey Mario,
> 
> Smoking gun here, the max frequency is incorrect on 6.6.44+ but is correct on 6.11.0-rc6.
> 
> Linux redact 6.11.0-rc6 #1-NixOS SMP PREEMPT_DYNAMIC Tue Jan  1 00:00:00 UTC 1980 x86_64 GNU/Linux
> 
> analyzing CPU 12:
>    driver: amd-pstate-epp
>    CPUs which run at the same hardware frequency: 12
>    CPUs which need to have their frequency coordinated by software: 12
>    maximum transition latency:  Cannot determine or is not supported.
>    hardware limits: 400 MHz - 3.35 GHz
>    available cpufreq governors: performance powersave
>    current policy: frequency should be within 400 MHz and 3.35 GHz.
>                    The governor "performance" may decide which speed to use
>                    within this range.
>    current CPU frequency: Unable to call hardware
>    current CPU frequency: 3.34 GHz (asserted by call to kernel)
>    boost state support:
>      Supported: yes
>      Active: yes
>      AMD PSTATE Highest Performance: 255. Maximum Frequency: 3.35 GHz.
>      AMD PSTATE Nominal Performance: 152. Nominal Frequency: 2.00 GHz.
>      AMD PSTATE Lowest Non-linear Performance: 115. Lowest Non-linear Frequency: 1.51 GHz.
>      AMD PSTATE Lowest Performance: 31. Lowest Frequency: 400 MHz.
> 
> We're running amd_pstate=active and amd_pstate.shared_mem=1, and our workloads are back to normal performance on 6.11.0-rc6.
> 
> Morgan
> 
> -----Original Message-----
> From: Mario Limonciello <mario.limonciello@amd.com>
> Sent: Tuesday, September 3, 2024 10:55 AM
> To: Jones, Morgan <Morgan.Jones@viasat.com>; Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>; rafael@kernel.org; viresh.kumar@linaro.org; gautham.shenoy@amd.com; perry.yuan@amd.com; skhan@linuxfoundation.org; li.meng@amd.com; ray.huang@amd.com
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; David Arcari <darcari@redhat.com>
> Subject: [EXTERNAL] Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared memory CPPC systems
> 
> Hi Morgan,
> 
> Can you please cross reference 6.11-rc6 to see if you're still having a problem?  I would like to understand if we're missing a backport to stable or this is still an upstream problem.
> 
> Thanks,
> 
> On 9/3/2024 12:51, Jones, Morgan wrote:
>> Hi there,
>>
>> We are experiencing a ~35% performance regression on an AMD EPYC 7702 64 core machine after applying this patch. We observed Linux 6.6.44 starting to cause the issue, and performed a bisect involving rebooting the machine over 15 times. (Note that kexec didn't successfully identify the problem, since the PM memory mailbox is never reset).
>>
>> It appears that we are getting a max of 2.18 GHz when this CPU can boost to 3.35 GHz, explaining the slowdown. Blacklisting amd-pstate solves the issue at the expense of the performance increase we used to get by using it.
>>
>> Is it possible that the upper limits were implicitly at the max CPU power before, and setting the upper limit to something other than the boost frequency can reduce performance now?
>>
>> # bad: [7213910600667c51c978e577bf5454d3f7b313b7] Linux 6.6.44 # good:
>> [58b0425ff5df680d0b67f64ae1f3f1ebdf1c4de9] Linux 6.6.43 git bisect
>> start '7213910600667c51c978e577bf5454d3f7b313b7' '58b0425ff5df680d0b67f64ae1f3f1ebdf1c4de9'
>> # good: [72ff9d26964a3a80f7650df719df139f5c1f965d] arm64: dts: qcom:
>> sm6350: Add missing qcom,non-secure-domain property git bisect good
>> 72ff9d26964a3a80f7650df719df139f5c1f965d
>> # good: [0fffc2e1bf40a2220ef5a38f834ea063dba832d3] ARM: dts: sunxi:
>> remove duplicated entries in makefile git bisect good
>> 0fffc2e1bf40a2220ef5a38f834ea063dba832d3
>> # bad: [8cdbe6ebfd1763a5c41a2a3058497c0a9163311c] pinctrl: renesas:
>> r8a779g0: Fix CANFD5 suffix git bisect bad
>> 8cdbe6ebfd1763a5c41a2a3058497c0a9163311c
>> # bad: [5dbb98e7fa42bebc1325899193d8f13f0705a148] drm/mediatek: Turn
>> off the layers with zero width or height git bisect bad
>> 5dbb98e7fa42bebc1325899193d8f13f0705a148
>> # bad: [691ec7043122c9c8c46d84f6e6cd85d13d50cd93] selftests/bpf: Null
>> checks for links in bpf_tcp_ca git bisect bad
>> 691ec7043122c9c8c46d84f6e6cd85d13d50cd93
>> # bad: [a1359e085d75d7393a250054e66c0a7bc6c3dbfa] perf/x86: Serialize
>> set_attr_rdpmc() git bisect bad
>> a1359e085d75d7393a250054e66c0a7bc6c3dbfa
>> # bad: [e99d9b16ff153de9540073239d24adc3b0a3a997] wifi: ath12k: change
>> DMA direction while mapping reinjected packets git bisect bad
>> e99d9b16ff153de9540073239d24adc3b0a3a997
>> # bad: [d027ac4a08541beb2a89563d3e034da7085050ba] firmware:
>> turris-mox-rwtm: Initialize completion before mailbox git bisect bad
>> d027ac4a08541beb2a89563d3e034da7085050ba
>> # bad: [e6c9eca327e6a41a81e7eba0d0ddc13da37f82a1] ARM: spitz: fix GPIO
>> assignment for backlight git bisect bad
>> e6c9eca327e6a41a81e7eba0d0ddc13da37f82a1
>> # bad: [b8cdefdaa555bbfc269c2198803f8791a8923960] m68k: cmpxchg: Fix
>> return value for default case in __arch_xchg() git bisect bad
>> b8cdefdaa555bbfc269c2198803f8791a8923960
>> # bad: [13a71384ae6a8779da809b00c6f378dcead10427] cpufreq/amd-pstate:
>> Fix the scaling_max_freq setting on shared memory CPPC systems git
>> bisect bad 13a71384ae6a8779da809b00c6f378dcead10427
>> # first bad commit: [13a71384ae6a8779da809b00c6f378dcead10427]
>> cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared memory
>> CPPC systems
>>
>> cpupower output:
>>
>> analyzing CPU 47:
>>     driver: amd-pstate-epp
>>     CPUs which run at the same hardware frequency: 47
>>     CPUs which need to have their frequency coordinated by software: 47
>>     maximum transition latency:  Cannot determine or is not supported.
>>     hardware limits: 400 MHz - 2.18 GHz
>>     available cpufreq governors: performance powersave
>>     current policy: frequency should be within 400 MHz and 2.18 GHz.
>>                     The governor "performance" may decide which speed to use
>>                     within this range.
>>     current CPU frequency: Unable to call hardware
>>     current CPU frequency: 2.17 GHz (asserted by call to kernel)
>>     boost state support:
>>       Supported: yes
>>       Active: yes
>>       AMD PSTATE Highest Performance: 166. Maximum Frequency: 2.18 GHz.
>>       AMD PSTATE Nominal Performance: 152. Nominal Frequency: 2.00 GHz.
>>       AMD PSTATE Lowest Non-linear Performance: 115. Lowest Non-linear Frequency: 1.51 GHz.
>>       AMD PSTATE Lowest Performance: 31. Lowest Frequency: 400 MHz.
>>
>> Thanks,
>> Morgan
>>
>> -----Original Message-----
>> From: Mario Limonciello <mario.limonciello@amd.com>
>> Sent: Tuesday, July 2, 2024 10:49 AM
>> To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>; rafael@kernel.org;
>> viresh.kumar@linaro.org; gautham.shenoy@amd.com; perry.yuan@amd.com;
>> skhan@linuxfoundation.org; li.meng@amd.com; ray.huang@amd.com
>> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; David
>> Arcari <darcari@redhat.com>
>> Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the
>> scaling_max_freq setting on shared memory CPPC systems
>>
>> On 7/2/2024 3:14, Dhananjay Ugwekar wrote:
>>> On shared memory CPPC systems, with amd_pstate=active mode, the
>>> change in scaling_max_freq doesn't get written to the shared memory region.
>>> Due to this, the writes to the scaling_max_freq sysfs file don't take
>>> effect. Fix this by propagating the scaling_max_freq changes to the
>>> shared memory region.
>>>
>>> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP
>>> support for the AMD processors")
>>> Reported-by: David Arcari <darcari@redhat.com>
>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>     drivers/cpufreq/amd-pstate.c | 43 +++++++++++++++++++-----------------
>>>     1 file changed, 23 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c
>>> b/drivers/cpufreq/amd-pstate.c index 9ad62dbe8bfb..a092b13ffbc2
>>> 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -247,6 +247,26 @@ static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
>>>     	return index;
>>>     }
>>>     
>>> +static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>>> +			       u32 des_perf, u32 max_perf, bool fast_switch) {
>>> +	if (fast_switch)
>>> +		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
>>> +	else
>>> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>>> +			      READ_ONCE(cpudata->cppc_req_cached));
>>> +}
>>> +
>>> +DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
>>> +
>>> +static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
>>> +					  u32 min_perf, u32 des_perf,
>>> +					  u32 max_perf, bool fast_switch) {
>>> +	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
>>> +					    max_perf, fast_switch);
>>> +}
>>> +
>>>     static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>>>     {
>>>     	int ret;
>>> @@ -263,6 +283,9 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>>>     		if (!ret)
>>>     			cpudata->epp_cached = epp;
>>>     	} else {
>>> +		amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
>>> +					     cpudata->max_limit_perf, false);
>>> +
>>>     		perf_ctrls.energy_perf = epp;
>>>     		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>>>     		if (ret) {
>>> @@ -452,16 +475,6 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
>>>     	return static_call(amd_pstate_init_perf)(cpudata);
>>>     }
>>>     
>>> -static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>>> -			       u32 des_perf, u32 max_perf, bool fast_switch)
>>> -{
>>> -	if (fast_switch)
>>> -		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
>>> -	else
>>> -		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>>> -			      READ_ONCE(cpudata->cppc_req_cached));
>>> -}
>>> -
>>>     static void cppc_update_perf(struct amd_cpudata *cpudata,
>>>     			     u32 min_perf, u32 des_perf,
>>>     			     u32 max_perf, bool fast_switch) @@ -475,16 +488,6 @@
>>> static void cppc_update_perf(struct amd_cpudata *cpudata,
>>>     	cppc_set_perf(cpudata->cpu, &perf_ctrls);
>>>     }
>>>     
>>> -DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
>>> -
>>> -static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
>>> -					  u32 min_perf, u32 des_perf,
>>> -					  u32 max_perf, bool fast_switch)
>>> -{
>>> -	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
>>> -					    max_perf, fast_switch);
>>> -}
>>> -
>>>     static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>>>     {
>>>     	u64 aperf, mperf, tsc;
>>
>>
> 


