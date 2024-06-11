Return-Path: <linux-pm+bounces-8971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAF79044E4
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 21:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25531F25043
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 19:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253693A27B;
	Tue, 11 Jun 2024 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QAvpsbX/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5597979B7E;
	Tue, 11 Jun 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134535; cv=fail; b=EM0a5sx1XaAs7v2RDSCfQWfSXeSQbjxvisqIARTy4RDVchf74AfHhvMCbua+/9/TjnU3LA6zJgIujloiIbiKxgGzGQ5Z58hr2fxRlSjrJ/c0B2wVpevFEhXV/bAIh4qaJVHw8kh4FN9Ys11SyUYTOjoXq/W7KwigQMIR6dTC3ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134535; c=relaxed/simple;
	bh=9UdfIXoti6pN1hls3+eg5s4P66Poku61wTOzldUHHI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V291tBFvcX6MxkoYbHATVFFQG4a8pWQjUmi4/ONshRZzsNychZOAbBx91shZQlQRzZMd7IP+KOLPWmX2oYR2uupZloNHglRv/0d7AHujC+HpWbd6H/VNdqco6u3FeOYQ1CUC7UneIkGLTFDXfB1LvHC+DYYExH7I5Kg6mJXf0Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QAvpsbX/; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGzZNPRHHl6H9qkqH98ICLp1UY6U3YFxwme5MMljh3HzjKb71vFyd4Hnno7Ctbo3Pe4mebCiiO5HxtsoqhYQRP0dlJJ3u3S2Abqljsx5OmOks+1GfxuLvmv62lebH3xClJkxn4RShJkj5Qlk4Xx9RZTtGem4ShYl2FoPFgjrs9nNVjQh+FwimC2bVFJH4g1VuY4+5a6fDvyeBgvs7Kzx+cqnYjI5ctSXuA+4H5YpRvmoQvrAPRjl9ePRmUolxftHVuqw2HWG0jvUAiWj9yine7gViwQ5UT1zhaB8IN/YTwD790AXhKyN5ig0rStQ8VRZdzBs4HPtpEUAA8WDeBbEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iMSODi8bWHrBfz/rIXPz8zqsTuPdXWEH0MPJo4npL0=;
 b=l3qfoGzNFjXexTAzC9SsXk1M0Re7AIfyVYJ75BQDL8fXom8v7kMupW29zgcug1CDLFNzTQ3W/qyHZdbNqp8TbgS5uHhGaa/+XkFN/mK/ZJXLaSaTuRv62YOL/wFBIZYfQg6h0rDNMrdMwAvXp5ztEjX9MeStOgWHOknaZ5exPzbRIy1IozbHOBYc981yXIKe3zCDMCa0gDtB6TXSrpRVhnf9f+TD/Hru/k84aT71zMWpDwhBnz3jG4yZBmut241W89n7Dpo8fF5UMiLMRCuocvnQOF1IPgnroYTslGdrVFcgX2GjGyHmkaQQWLwC0Qas7TQ/vIxm/pDpHrEJgNpnAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iMSODi8bWHrBfz/rIXPz8zqsTuPdXWEH0MPJo4npL0=;
 b=QAvpsbX/JUOFfZ0X6uaJTkzi3ytK8iobxkmde1xClOvAeJjKfhMo9wJiyEwut7+Xg0j1oGbhkYq3Ka/i6mWvLM92G5Fgi1GMz47t8E+YoLYGYIWsmb8hTYiuCY0Mk/hhAzkddnNU/NI430fTZaEURpjwGiuoZkvJqi90zZtFDzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 19:35:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 19:35:27 +0000
Message-ID: <aecb3986-aa2e-4725-b08b-473b35ca8221@amd.com>
Date: Tue, 11 Jun 2024 14:35:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] cpufreq: amd-pstate: automatically load pstate
 driver by default
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 Borislav.Petkov@amd.com, Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
 Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1718095377.git.perry.yuan@amd.com>
 <39b55abeb278d9ae1688c0b87cb7ec8a3e37932a.1718095377.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <39b55abeb278d9ae1688c0b87cb7ec8a3e37932a.1718095377.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf86133-680f-4ad7-5b28-08dc8a4da55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzNHcW16SG0veXhzOEtGUXc4cW9UVTJhbDhyMkxPY1IrZnNGSi9HMGNpK0Ex?=
 =?utf-8?B?VDRoZjllellsKzBOVWg4bTRBdng4TWphMHkzVmJla2hmaTlrSEJLSFNwcUdP?=
 =?utf-8?B?SFRmaFF5K0xPekdZY3g4V2ZPN1pvOC9OcGk0L3BxR3N4VUlvZ0dkUzhCbU56?=
 =?utf-8?B?L1hDK3E1SGMzWXZ6WXlxSEthVFFieVpWVDBOcWtOK0REZVp1SWhEQVZodGl2?=
 =?utf-8?B?ek0yVVlIcUI1TG1tdDdqeFBqNmhMcGhaU0JQOC9abGh1MVM2QUlHUnNSS3J1?=
 =?utf-8?B?eHVGUVNnb3VtVXBjcmpVWHZyU0FzU1lpRTJJTE1HZlUrODc3Z2JtVTRFZTdG?=
 =?utf-8?B?WVRpNW5mY0xucVMxbjNoNkxGdmxJcFpheG56Qy9kRzVZQWFncVd6WnAyVVZI?=
 =?utf-8?B?dWZEdnc2dll2VjRaVEJqbWo3QUZzMkdZcmpNM2cxa3J2NEdSVEFlZkZmci9B?=
 =?utf-8?B?RWpjVm96My9zS2puVTd2V1NFOVBObzNuVXUzRS9aMGY2b1ZoNFdrRkpnZ2Vm?=
 =?utf-8?B?NnEwTUdBTmpRcTdYMWVmOWlNTGIxYmlVY0IzNTFaTWE1UmlkSGcveWdyM2d4?=
 =?utf-8?B?RHd3MFZPeFZmcVlPT3ZtZGRHMTRtN2lHb2syNkpOYlFvM3BMWTE1NkdyalNN?=
 =?utf-8?B?TnB4MkQ3cU5pNTJpUTR6M2Y0bEtuaWZVZS9NUlJhaS9rYXN3bno2blh0Y3d1?=
 =?utf-8?B?KzN3L01FNkxmeW9UZWt4RExQTG9NazAvYWVFRFBRVlJXUlhVcHRXV1A2bG5Y?=
 =?utf-8?B?VWQ3YlFTTXdabm5HK1NUTGp1U0VFSHE4WUpMVHZzc0duak5ubndBRHJKWmxp?=
 =?utf-8?B?Y092RGtQQkZMYzJMK3hEVjJMbDlaMnltL3JBc2ZnZ3dySzM5T2RlSENUeVZ0?=
 =?utf-8?B?UjRyalh1MTRjcHBSam5IcnAxRDdTcHdMdGxFNmVkRnNOMUtqNGhpU3Q5VlN3?=
 =?utf-8?B?VGtONmZZbHFJdzhwbTE0R1ZTWVpjRjdWWjJBeEtSdXc3bjdoUDRTZjN2Q2pX?=
 =?utf-8?B?TEl6UVFBZ0t1S1lHMWUvZktJclBudngzdlU0ck5UcEFEQU44aWhSMWRCTTNj?=
 =?utf-8?B?dkk0b1FwOTVJZlRBcmw1d2hXczUxNFlsL0FtL3pxaE83ZUFIM2FZQVl5Q0Iy?=
 =?utf-8?B?alowUlZwM3RuZmE1Y1JpdVpJaVRWYzcyV1V6N0szNWJCK0kwazBGa3VESFVT?=
 =?utf-8?B?dVFYVnIybTVuSUtoSmZLRHdRUHUwL1RlUzdhZ3gwTmxwWk1JVXE0MnAwSlJR?=
 =?utf-8?B?Rk1YMndJSVpBWk1qV29uN2V5bjNZK1BhVzFrRUN1RFZOZU9sSHlsMFpjMmwy?=
 =?utf-8?B?b3ZQZDZtWm0rNlpiM2U5bE5IZzZoVGh6bk5mMnYvK01HUlpWSUthOVJPQjhS?=
 =?utf-8?B?eDE1MVc1Z0ErQmhGZ3NNWDdSMFJ1VFRPbXhGTWdQQTF2SlN1SWJmemNVNjlv?=
 =?utf-8?B?cy9ZcUtXUVdNcU5JMmNma3d0bTBERzIwZGptRXIxakdZMk9kNEV0aHVJTU1s?=
 =?utf-8?B?anNQU00wUlg1UlY0b1U3amRwUEdJWHFLVjhISWhsTTBXOFViVDAzWmowY205?=
 =?utf-8?B?TG1pNEIzZzJIV2NNc0xDS0NDemhpVlhGdWFPWWtBUFVyYnZQSU5uWU1IUHIy?=
 =?utf-8?B?aUs3V1RvWjZqTUFRMUE3b2g5ZDJUYmtrTmY3UE9GVkJLcFBWR0tONGdOVzFl?=
 =?utf-8?Q?dMz3gc2YnMtKsmKW4ecT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0tCWnhrUlRyVldEaGs4OHBLNU13a0QrVi9zWDltbzB6SW5ISUxFRms0ME50?=
 =?utf-8?B?VzFOMUN5OG5heWpCSWRpMnpXRmE5aW4xbjlMNzBaSE9wMVZucnh4S29PR0Ey?=
 =?utf-8?B?Njd3MDNtcWU5OXF1dW8zSUt3YUhGcUJNWk85NFpBYy9KRld2alo3ZGJDWmFK?=
 =?utf-8?B?enNwZituclhaNEhGUm9mUE1zL1VoYkx2YkJTOVJRWWptUnltOVVWZVBSOFhB?=
 =?utf-8?B?MEcxR2s0Snh4VlJpRHQxbVdyYmNqRmJqYUVKS0JSUlVrUXNsSkZETFhuSnF6?=
 =?utf-8?B?U2ZWSmQ5ck9ueWFQM2Z1VmlVaEZCcTZFN1d4Q1d2OWsyWXVMUDlLVnM2bU9O?=
 =?utf-8?B?dmM3NFVuaU9vK1UzYkxId3prU2pEQmZ4S3ZDOHdzZWc5TUlrWlAzV29ydyt1?=
 =?utf-8?B?dHNocy9HU05sRWx2WGpEQkhKOUQvWkpQd0FsOVlqbnk5Z1JBTnpQTVVMZUtr?=
 =?utf-8?B?d2x1U2dpek1MT1ZSRmRDbkY4WDdpWTEvSW5NbHJLNDk1dm9ZQ2c5aHZqOU1r?=
 =?utf-8?B?blBqME5va2RScVhFK1FYYkFmVXowNU0ra2tpNnRBR2tQRmd1cU5BSlpvL2xo?=
 =?utf-8?B?ZFFOR3c5b3FsbXFOY0xxVDVsZ3BWV2ZtaFpTbVJuelgrcmtPYmFHYU80ZkVk?=
 =?utf-8?B?czB6Qk8yeHAyVFZRL2x6OHZIUmRHTXlaa1pEMlA0SVR2ZnQzWUpPVENJKzF3?=
 =?utf-8?B?WmFlQ3pEd2Q2VjlRMWxzQ0Z1S0svcTU3U205UlZyaGgvcGxKdmFSb0R1N0VU?=
 =?utf-8?B?bktBSUs3aGU0WWlwYjBic2JYM2NEYXErZWtuZWJ2RHlWTlc1RTJMWnNKeEJD?=
 =?utf-8?B?N2FtWWlpeER2Umd6N1hMTC91NVdnR3hZTmdyWWxKbVdYeXZKb2JFOWJjSitp?=
 =?utf-8?B?MUdxZmRvZGk5YmpLbWNheUlwYmpPalZnUDNXeGtLanhEN20vdnhySk02UU1l?=
 =?utf-8?B?YlVmOWZsdFhiczJqNlN3MzdORzBwL2w0VXFEQTlZbThSWWwwNlZ1M2xFYzlX?=
 =?utf-8?B?MW95SnVhOTZVTGlidmp1QkYwNy8zckl5emJYbWk1QzhHL2RSUEszRkppN3c1?=
 =?utf-8?B?anY1azBtR0V4V3N1S0tKeUNmWWZvOGNGNnYrZVhBMVZ0dmlVYlBzVk16VzF5?=
 =?utf-8?B?WE5WWUZqbFNJaWllMzZZbEt6ZUZ2cFJ5ZVhNbnVJNlRJZWExRERoOU1lbVJs?=
 =?utf-8?B?Z3ZUUWNiUFZISXVCN3k1M21rSnRPSE4xZlZRbDhoVXF5ekNJUFE4MjB4eDRI?=
 =?utf-8?B?b24yMWNqeHdZdi95YXV0aHFiTGppRHk4c0o2MHU3M3R1ZHhNNmdNV2NUMjd4?=
 =?utf-8?B?eWFHMHFQeDJzdnNQOVQ2WlFoVi9veDFaRkhBSjF3UEl6NVhRNkF5UUlKaytL?=
 =?utf-8?B?Q2cvRkhNLzF0bWhZd3RrRC9qY3UwajhvcmNLeTFCOGpOZlowamMrK2RvdXpq?=
 =?utf-8?B?bDFTUDVPR2pZemJnaWY0UnNtNWduZk81VkYzRWUxZU15Q1pVUFA3b09ObHVB?=
 =?utf-8?B?ZVNRTE1GdFNiaU5mY2owUTFyNzh3cStHOTlUVTRnZG5kbStVYnFDNWZ5Q0Jr?=
 =?utf-8?B?WGxhWXZ4NDl6WXhUZjJQMDRCWEJIL29BOHI1SXVWdURVM21ZUGFmendmanBP?=
 =?utf-8?B?anJhTDFSQWsvaXJpSUtKem8zQnFuK1cvRnRBanV3SndoMEFvbTF2anJwZWt4?=
 =?utf-8?B?ZlBLZ2dZcUw2L2IzblFXNUFFdUQvOXB3MnIvcllLZzQveFF5U0hEK2xYeUF3?=
 =?utf-8?B?SUZCSXRSdDdGS29HNExuamJ2QStnSzBEYXpiQzVhWmIrTVB3aFVOR20vL0Zl?=
 =?utf-8?B?ZnlGamNicTI5UUFNRCs2US8rZkhsSWxxVmxsYndtRlpZcmVoUjMzUHpaUzZr?=
 =?utf-8?B?byt5REkwT0hOcXgyZjFMY0dhbzk4cjFPVUJ3M09NK3FKbXR6dDFQcDZQSlBG?=
 =?utf-8?B?cER4aDdGdUMxTFBJWlUrN2ZIeDFTbGdNN0swSm1aenhrUVk0TFhBbmtLdnR0?=
 =?utf-8?B?MmQ3WVNWTGpWVkIxUDBNVzVCOFlFMGxaeXo4Wk9aajlHV1l3U3ZLbkJvMGQ5?=
 =?utf-8?B?cm41dG9tVVErMWhjTS80TGY2bXdJSEtGRFMzaWpvZDhrQ09ZcGZiQW96dFUy?=
 =?utf-8?Q?Auc+GU4FoAigPXK6NIdqBIjSI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf86133-680f-4ad7-5b28-08dc8a4da55b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 19:35:27.2558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /InDlVu+A+7vndS1LV65zu+2aEF5Tpy3oxAVCFePVWQJ3dIGGEr9MuW1pD2uc3rX4NeUkeKCazS/sOL668fktA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311

On 6/11/2024 03:52, Perry Yuan wrote:
> If the `amd-pstate` driver is not loaded automatically by default,
> it is because the kernel command line parameter has not been added.
> To resolve this issue, it is necessary to call the `amd_pstate_set_driver()`
> function to enable the desired mode (passive/active/guided) before registering
> the driver instance.
> This ensures that the driver is loaded correctly without relying on the kernel
> command line parameter.
> 
> Meanwhle, user can add driver mode in command line which will override
> the kernel config default option.
> 
> [    0.917789] usb usb6: Manufacturer: Linux 6.9.0-rc6-amd-pstate-new-fix-v1 xhci-hcd
> [    0.982579] amd_pstate: failed to register with return -22

This is currently "intended" behavior.  There is a comment remaining in 
the driver at the moment not part of this patch:

/*
  * TODO: We need more time to fine tune processors with shared memory 
solution
  * with community together.
  *
  * There are some performance drops on the CPU benchmarks which reports 
from
  * Suse. We are co-working with them to fine tune the shared memory 
solution. So
  * we disable it by default to go acpi-cpufreq on these processors and 
add a
  * module parameter to be able to enable it manually for debugging.
  */

Would you say that the performance drops are worked out on the shared 
memory designs?

* If so; this comment should be dropped too in this patch.
* If not; this patch really shouldn't be done as is.

> 
> Reported-by: Andrei Amuraritei <andamu@posteo.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218705
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fa486dfaa7e8..6e5c398810bf 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1841,28 +1841,37 @@ static int __init amd_pstate_init(void)
>   	/* check if this machine need CPPC quirks */
>   	dmi_check_system(amd_pstate_quirks_table);
>   
> -	switch (cppc_state) {
> -	case AMD_PSTATE_UNDEFINED:
> +	/*
> +	 * get driver mode for loading from command line choice or kernel config
> +	 * cppc_state will be AMD_PSTATE_UNDEFINED if no command line input
> +	 * command line choice will override the kconfig option
> +	 */
> +	if (cppc_state == AMD_PSTATE_UNDEFINED) {
> +		pr_err("pyuan cppc_state == AMD_PSTATE_UNDEFINED \n");

Looks like a debug line escaped into the patch.

>   		/* Disable on the following configs by default:
>   		 * 1. Undefined platforms
>   		 * 2. Server platforms
>   		 * 3. Shared memory designs
>   		 */
>   		if (amd_pstate_acpi_pm_profile_undefined() ||
> -		    amd_pstate_acpi_pm_profile_server() ||
> -		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +		    amd_pstate_acpi_pm_profile_server()) {
>   			pr_info("driver load is disabled, boot with specific mode to enable this\n");
>   			return -ENODEV;
>   		}
> -		ret = amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);
> -		if (ret)
> -			return ret;
> -		break;
> +		/* get driver mode from kernel config option [1:4] */
> +		cppc_state = CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
> +	}
> +
> +	switch (cppc_state) {
>   	case AMD_PSTATE_DISABLE:
> +		pr_info("driver load is disabled, boot with specific mode to enable this\n");
>   		return -ENODEV;
>   	case AMD_PSTATE_PASSIVE:
>   	case AMD_PSTATE_ACTIVE:
>   	case AMD_PSTATE_GUIDED:
> +		ret = amd_pstate_set_driver(cppc_state);
> +		if (ret)
> +			return ret;
>   		break;
>   	default:
>   		return -EINVAL;
> @@ -1883,7 +1892,7 @@ static int __init amd_pstate_init(void)
>   	/* enable amd pstate feature */
>   	ret = amd_pstate_enable(true);
>   	if (ret) {
> -		pr_err("failed to enable with return %d\n", ret);
> +		pr_err("failed to enable driver mode(%d)\n", cppc_state);
>   		return ret;
>   	}
>   


