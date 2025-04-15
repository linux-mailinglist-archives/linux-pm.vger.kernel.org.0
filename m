Return-Path: <linux-pm+bounces-25475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BBBA8A134
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 16:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0A017B609
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A990B20B1E8;
	Tue, 15 Apr 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RFv2Lok0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD161B0434;
	Tue, 15 Apr 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727754; cv=fail; b=f6qtNXtHDMZaKX74sX7f0hUvwYUo2UWAyIuHYDd8A/pEHNpz+ctgHw8xaoBjsHfSPKzFnXi5YLLDN9rJucTh41VWE/D8PT1IFMyd24jfV9F5tbeszE7EBe6PleubVMz8QkIc4K4g4hELkC6vtrXcWqtRGHN1aUe9RhyNGS+BQDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727754; c=relaxed/simple;
	bh=xyjBnfLPVnkj7ZkoQCAN5Ij2ONP7D9CL1pXULClS2tU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wk1/JjkrQt+k3h8RSSENkzl3GE/gc0fJYHQeXt5NFS6ODmVAf8r9vnjNkTT6oaS40PcOAz68V2xWEIXO32RFqOrHZQ8kahEM9C2P0U35qvXyAjWZByVkF+Yv1h2wcKnsh5r6b+GvPX9lwyCTkt5OQj4Rmc5X537zG/PW9D8m7vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RFv2Lok0; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkIV/3iclndlqrojjb1eRIfW+CUaN3bctxwECyifcm4XAqWagEI7TthNXy06pPHaLioiqO3qfE14bFYslxvQIFM/LLz4ghRbRipnfffHltESsl988jIbFYPs4vj2NY7J0A06mmZlxdMAm8k6kstjvIRD2n8S8P3kvsbSCQc8QpgdBOSPcyNT1LvnXxed1JWDmS9wJKRJpqROhn9XDQ3Krq9bMFzOL0FC6Bj0FsKg7Hnzi+rWhS3H7IoxJzqUbeViE/EdRPoMhE3rVUdZvR/SblJo2zlgMEiG3fgbwxNOoWXXO+84b1bt/1yiQBKyrY80ozllzr1aMsEEWZatoSo7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwlcIfEvWCzhAjyja9ClQ8QccK6VavqtCY4neu8a9ts=;
 b=CXylAmqfBWTDFCZSWICa/DFOhIXpJNwcZUFStTwjveVVweIwgYBeiJ/tQA/J0U+pFAizlIeeXL3QdAU+il3GO/SpEFCZAH9mAlDNl+ro3152imQNRnjnRwnUGiREotMAPz8TNrggtNzHUvhDTpRBqlim5tontAKnrbe6mBCvaBct03L1BRBF+gpujY3VwDf1aZHvNmTrV2V2GYEh4V861CA4tENIQ8MgM/c6Ob/NNegr4RoHz0s3P4TuYLFgoU8rY9G7bwfzf6KXGBkWhf2tPqQPxnGpwo8Qa7NnxPcYcxFAoGtde27c0CO8O+tkQTTqmI8EXYzFiQp7ZosEOdwSEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwlcIfEvWCzhAjyja9ClQ8QccK6VavqtCY4neu8a9ts=;
 b=RFv2Lok0EVQ28EGB0vHsbg1WEoWvkxIrG2bG2jopb9IWTsscvVYZZSyLOnzR/qJSQMzQsKH7Ao6brssBwUwqm29/bda7ThlBFG6flzZM6wzwckQgr6nb5NHizOKdcvfJutOwVVeWZlub9y+afGNe2sYc+EeBV4/mXNsnvjryM60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 14:35:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 14:35:49 +0000
Message-ID: <50b0e014-b359-4762-add5-a4835afd372f@amd.com>
Date: Tue, 15 Apr 2025 09:35:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq/amd-pstate: Add offline, online and suspend
 callbacks for amd_pstate_driver
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250415102118.694999-1-dhananjay.ugwekar@amd.com>
 <20250415102118.694999-2-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250415102118.694999-2-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0139.namprd11.prod.outlook.com
 (2603:10b6:806:131::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: b5781b02-dbb5-4e0d-1108-08dd7c2ad0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEtSd2dwbTFMOHRpWVdvNlBHeFNCanZtSWZNM0pDOUkxUG9TQTdGT1hVZnN1?=
 =?utf-8?B?Zk1td0RtR3ljVGJoeHg1Z3dPMkoxanlLeWI5OWxiQzVDTVROUW4zMExPVjc4?=
 =?utf-8?B?bXlFM1lnUVZwcy9kMVhUUjVWekg0ZVVFY1lZalJ5dndXUGhGbXpBb3VHZlJs?=
 =?utf-8?B?UERYSEg2dFRGQi9GUEhzUDVid3gvV0h4VG9FZkkwVEJadGVma0MwazRCNEFi?=
 =?utf-8?B?OXk3ejA5dUFDSFVyY29kM3lrRU13cDE3QWRvN2w0YUhDVXVNSnAyRXdWRlJZ?=
 =?utf-8?B?emQwWjhHZHNCKy9BZDVJODZlUWxRVHp3N0FvYStuOTkzWTN2WVVEWHBwL0Z3?=
 =?utf-8?B?QmMzU0l5VkY0dEpLTi9Md2lGWHJGMU1DcU01blJ4N3NiUWJjcGQ2RWJlTWp2?=
 =?utf-8?B?clBqUUJ2MnB2bTlXQjB0QkFuSndBa2sydEdHU1RPZEl1MVlxM3Q2ZXhTWmxR?=
 =?utf-8?B?YnFuRXpNNk5PakQxOW5oc1hsd05zalRrdlhyRWJwN2dMakZ6a3FmSHBjZ056?=
 =?utf-8?B?cnlzMjNJVEE3YVhFdDJqcld0OVg1bmRRVHVQTnFJd2Q3U0tLQlFrLzJHTVZw?=
 =?utf-8?B?SFJ0QnR0WVRyL01wRUlPdWp5RVlOTVE4UmR2SVNLUXFnVzUxZ3hYc1hJaXZp?=
 =?utf-8?B?emFIcUszam1aTUl1Y2Z1alk0dEdjZmpObHdtcVQ4V1Vob0s4S3QrNnRNbHBR?=
 =?utf-8?B?azN2QzFLTUJSSVAyVURVdHdteVJNLzBVM2ZJQXBZSDJUbHBBOHVmOG1rVkk2?=
 =?utf-8?B?c1VDSkRYZXJRcEFLVW9FaS9xbXQ2bitXN0ZpbHp1cERNcmFJRFFaL3oxSERw?=
 =?utf-8?B?aDlyWnFnS3BFcnFINDZPNXJNTDVXeUU1emFHaDN5RzJqbTFSUmhpc3F4L0Nq?=
 =?utf-8?B?UXN0aERuc3FqUFNkbkhtWStBVE1kaHhZdW9nbmpFazhxMkNWZXBJLzA3VlIx?=
 =?utf-8?B?WHV6bi9hVUdLc3FLdkVpN3ZjWU1Vc0lJNEhCU0kveTBRamdpUFFidTEzNlN3?=
 =?utf-8?B?MFZicDBoUXI3TjJjS3ZZeXY4cjNjVk9aRHR5YnE4TzZCSWhyOUwvNDlwZmFS?=
 =?utf-8?B?cmpKQUVpS085M2xnanZqSUVEWjhUZHdiVTloem8rNzQzYzJ0R1dQMlBoSkFh?=
 =?utf-8?B?dHUxTXdjdUtTU3l0M3pkWUxWbXdXV2dmM0VjSHp3WGlZQjZENmFZell3U09s?=
 =?utf-8?B?Z0pxVkJuSmlDNEd3cjRGOWRVVXJOYS9iWkhIbVNhZHNsV0drZUhRb3RVR2NO?=
 =?utf-8?B?NFJKSXAxOVpNbFdSUmZrcnVwSEsyTndTRDBwQVNqZkhnL2pocnI5YUQ5V3ZX?=
 =?utf-8?B?ZUdXb3Z4blQ0bElpUFB6UmxNVVB4N2E1QmloUzRkdWducGFIbUhDY3diQzd5?=
 =?utf-8?B?TWwzUU1JamhvZGIyWTN1ZWFLYTFDb1Q0dnkxS3dyL1NDSC9NWDkxS1paaDdr?=
 =?utf-8?B?dExIUGZBdGdxU3pRM2RtdVpyVmpMRnI4N2toWVlJdE1Cd2tLMWgvVXoxTEFO?=
 =?utf-8?B?T3plUGFBZk5ENFc1OFRhc0pFUFNKdXltTkxzOUFQajdTYXpIZzhGVFVndzdz?=
 =?utf-8?B?QmlpU0poOWJTNGs5ZUdoYWVGTlBRTjRmNkI4TEhLQUxJTU43RHZobGo1Ykhk?=
 =?utf-8?B?OEE2M3dzRjlJVGREMURQL2dJV1BhYW5mNWZ4eEFMSnByWlVTaEt0eWJvZUZ5?=
 =?utf-8?B?TWgrSVZETzFJOUp5aDBTZFhFUG9KNEp1RmN5V2V2eUFsWjFHcDc2ZGo1ZEpB?=
 =?utf-8?B?VWlMTEhFK2dXbEltbUgrN1UvclY4aSsxcE5Qay9tSGJPd1k0eFhvTWl5czl3?=
 =?utf-8?B?Ty9Wend2UysvNDBwZ1VyV214dGJzQVNIQm12Yi9FUHA5RnpqZXZibS8xam1i?=
 =?utf-8?B?VlJPbVNLZ3NXSDNSYVVMYXdNcHN3SUM5V3BtMWF0K0RTK2h3bkxPby9VNXpv?=
 =?utf-8?Q?rMZZuF1VI4E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW9JamZnb2J0anZzVldLanJtUkw0eHp5NXZzOEJXczltemdtVnUrMXVxNGJL?=
 =?utf-8?B?UVFxVjB6amlwMmVVclRUc3FIamhUMXN4L3RHRThOQThIZTFCWmNwRm5NSjBt?=
 =?utf-8?B?RVYrQTc5ODdXK2hteStxYUVmMjdVclRWYjUrRzNrN1IwTE5lRUxHbUpPVjRD?=
 =?utf-8?B?bWhCS1JkT0lwcHpZUDBzYk9aVzJqY0V0Y2VCSS9IbmsySGhaeHRacytxTEtZ?=
 =?utf-8?B?MDYxa0RZTUJXLzdickxHMkFIaEU5L3ZSaVlZNGtsOVBPeU5xenYyOWZxOEpV?=
 =?utf-8?B?RmtydTl5dkJnSWhNaGF2aERnVnNZUmJSY1NnQUVXeUVXYU1ZczljcmdjdDVS?=
 =?utf-8?B?LzFwWWpyNmQ1N3BTRmpvSHNZaGI1VkVYaWlOTjV1UzFETHZBT25ERW1rNU9G?=
 =?utf-8?B?cGIxdDFZL0cyRHRpNkdEaU5FMlBlUEtoQmhmMFBDbGw3bThvM3RZYTV1MW9T?=
 =?utf-8?B?dGxMNDVTT2w5eSs2N0c5dnMybURNK3JSdU5oWXhmNjZpTElMMXg0SHh1Ynpl?=
 =?utf-8?B?d21VQ0tuZ0pQN0pnaFB6WE1HQlA1dGJkbEtFNlBIaFA4OG5vZjNSNy91M1Bk?=
 =?utf-8?B?Q3JLb210Z29EQjNoOU9IVWZURmx4U0szOWxheURjOG92Y0QyYXBFWEp6TnFL?=
 =?utf-8?B?azN2enRvV2lVb0Y2ZHVaWllKeVNXa0ZhM0N6aU1FamFKMlNqcXhwZWFKTTBn?=
 =?utf-8?B?VVVZa3YyODgvMEl0VkhuZEFuS0RSTWlmWHpQNnVwcFkwc1JMUldIcXNoYW8w?=
 =?utf-8?B?YU83aWlESC9ycjV4dGVjWGU2VnF0b1VPRFNLbnJoWXBjV0VsUEsyNjl3bklJ?=
 =?utf-8?B?T1V0azZTaWdEMDhKMTBHTytrR0dSYnRGTXhFbG9DNUNHZk1oYkVoeE14Tmh5?=
 =?utf-8?B?cFdZUkdmNFpYeEZRY0ptejY4UWN0N3dvTmpLRyttNVBEZlM4NXVPUUZlbnNh?=
 =?utf-8?B?REJYMmZHMnFKQmxOVWl4MjRNYmdJalB0TzhsdkY1YkgwZ1lUYmhhZlJYdkdV?=
 =?utf-8?B?OHRvQzFoRUE5dXhnZzEwNHR1bzBpSVNudmt4QlZnd2lrRHBPbkpRc0xJQXNr?=
 =?utf-8?B?dkFPVzdQTHp3NmJkbjRzUUdqNDZsRi9jSDJGUWw2WDFwb1hlRkI3V2VXVXFn?=
 =?utf-8?B?RXZTMUZZODlaTzNzQVZHQjJyQXI1UzdFOTRxcmU3dnA2Y1ZrTkRuTUJxN3h4?=
 =?utf-8?B?b0c3cHFnYkZGV2ZaaG5ITWdmMlpaSVNJKzlodXRKTHdiR0NqQno0ZEVIRURa?=
 =?utf-8?B?bkwweDZJaHFnZ0V3Sk1wSEErRUJjVHpaUlBLMUFFZVA1Y0dpOUZqSXdJQXBX?=
 =?utf-8?B?MWRUOGxHSjZvdXJWQlBpcXRwcjZTWkJHMGh3cnhOOGJRYWQ0ejFtSld2MGQ3?=
 =?utf-8?B?cU55TzdiS2U1TWNjZTAyTUxZVFhza1FRUURUU1Aya0E0MVAzNFhWM0JoSWFm?=
 =?utf-8?B?QkozcFI4SjhmTEJYZTVCVnREY1Y5d09qU05uc3NUQTZ6OFhaaXVXVVFRZnJU?=
 =?utf-8?B?aXdSZkVNUnAwMDVLZ2Z5ak9GVkFaVzBSTW5EUUxNU096c3IzVG10RVJXYktY?=
 =?utf-8?B?R1hoZGxnQXBSVU0rc3RNb0FtdndtMWxXZmQ1NWV6VlBtQ0l6UnFTcnZMZUhu?=
 =?utf-8?B?ODhxeEN3TzdPanJSdWZQc09vdkpQSWNMZ3JZcDJhbTlLN1lPbTFTeGhERWpq?=
 =?utf-8?B?UWJaek0ya2s2WnRFVHJXM3BDM2o1VS85N3B4cXRidzRXVDIxdmhjK3JvRmxO?=
 =?utf-8?B?cXdaOGRGZXhyTldJcFJUQlpVY2pyVU1wVmR4eTdpY3FkazdXR0huamt6L25J?=
 =?utf-8?B?K25Ua0VBTnB2V3hZK3ZRL2ZCR1ZGQnZ5RDlMTFplODI0SnVvZG9US09hWUQz?=
 =?utf-8?B?Q0hNYm4wWHJ1c0wzWDZtdm9nMjlWVVdUa0lJZjh1cFJBTWFXMVhNcW1PaXg4?=
 =?utf-8?B?YTEvTUhBbnNXZmc4MnhCMEE0K21GQmtsMDlBd082aUhjdVp1aGJ5SXA5UW9r?=
 =?utf-8?B?c2dyMzhsN3Q4cVNQZ1hXWlYwbDdNWWJlVy9sc2hqVDB4Um9iUVBIR09FaEMw?=
 =?utf-8?B?cVNXN1JDc3JLMWFabDl4MFcwUXZ3cjFhU2QvTm03aHp5U0lEcFhWL1A0VjBR?=
 =?utf-8?Q?sX3m6s1i/e8Ttb/PLwYmWoOzf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5781b02-dbb5-4e0d-1108-08dd7c2ad0a9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:35:49.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HVbbWfi9nhTErp+L/85J5LkfAhIbcaPpeaRbqnwxBvC58rxKA0EhTK1I9Bm9MrrAu3d3PmQTblsnXVVdgrwvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863

On 4/15/2025 5:21 AM, Dhananjay Ugwekar wrote:
> Rename and use the existing amd_pstate_epp callbacks for amd_pstate driver
> as well. Remove the debug print in online callback while at it.
> 
> These callbacks will be needed to support the "Requested CPU Min Frequency"
> BIOS option.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c29840ba3b30..02de51001eba 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1568,19 +1568,17 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>   	return 0;
>   }
>   
> -static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
> +static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
>   {
> -	pr_debug("AMD CPU Core %d going online\n", policy->cpu);
> -
>   	return amd_pstate_cppc_enable(policy);
>   }
>   
> -static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
> +static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
>   {
>   	return 0;
>   }
>   
> -static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
> +static int amd_pstate_suspend(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   
> @@ -1618,6 +1616,9 @@ static struct cpufreq_driver amd_pstate_driver = {
>   	.fast_switch    = amd_pstate_fast_switch,
>   	.init		= amd_pstate_cpu_init,
>   	.exit		= amd_pstate_cpu_exit,
> +	.online		= amd_pstate_cpu_online,
> +	.offline	= amd_pstate_cpu_offline,
> +	.suspend	= amd_pstate_suspend,
>   	.set_boost	= amd_pstate_set_boost,
>   	.update_limits	= amd_pstate_update_limits,
>   	.name		= "amd-pstate",
> @@ -1630,9 +1631,9 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>   	.setpolicy	= amd_pstate_epp_set_policy,
>   	.init		= amd_pstate_epp_cpu_init,
>   	.exit		= amd_pstate_epp_cpu_exit,
> -	.offline	= amd_pstate_epp_cpu_offline,
> -	.online		= amd_pstate_epp_cpu_online,
> -	.suspend	= amd_pstate_epp_suspend,
> +	.offline	= amd_pstate_cpu_offline,
> +	.online		= amd_pstate_cpu_online,
> +	.suspend	= amd_pstate_suspend,
>   	.resume		= amd_pstate_epp_resume,
>   	.update_limits	= amd_pstate_update_limits,
>   	.set_boost	= amd_pstate_set_boost,


