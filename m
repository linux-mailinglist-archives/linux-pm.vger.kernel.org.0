Return-Path: <linux-pm+bounces-7594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB8D8BE6D5
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 17:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED09B1F22734
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849CD16132B;
	Tue,  7 May 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hLU/2pmb"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B40161318;
	Tue,  7 May 2024 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094147; cv=fail; b=dO1FCa4coM2XwkXP04dr4D+PJy0FKQuQR7LTjuX4LGAl11QotZIJHBCzeXWMXOi1KsyQkoPpx9NgcXKTv2mMfpM+x/vlIf4abSv/y2cdK6vgG0TwlqyNvKxuQ775tXg9lT6EFStulxtXYicm1AvA7PYhQ8MuA+hve31/3qmWWeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094147; c=relaxed/simple;
	bh=QJ2lUaUKhX7097p3yX4s9SHr9GLKe48tPIZd8Ib56/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bW90Pwe5C+kzizBUxjB4CzUdHoveAKzWbalb3/fXsSyxRajRv6k7blv9mV4K1+6DRyivqcDUFrfaF54W1X6FV8ghspu6c8HVxL3JQ8xHNkkBbRGrDUed8VZ3SRDLdIAhdyKukA++vHW8rb5odMWT79NL50OTepEqlhAHjEPrCfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hLU/2pmb; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEPVm6UBn0/mzBpxKE9zpKEaoJUdSGFVjDCLplNjwTWR//aWrZ6zYkHXQoiHxMjuzCvFcKPemvAviBTJgYm7Qm+axaKZWIdXXsF2JVgMrowzlzRzZdc6E5kL0l0OAhs0pg4dlvi7LkvzRXtvoN4QJCk3HCicP+T/pK8WOYpjaCJPCDT4zqvFVzGXnpbMYWzPvDeuHiO8F4Z+JpipABYPzBhvN6+9TGMOg0FQLjD7DTQWnCMXXOzPUoUamjpSKkC1X9bpPv5UWFKFCv9t296izRtHlbrjZmCqhiP5OVqVnsN2i56u87Eonscjq1NsFfvwy48QpvCSbl4kolf4RIThAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQxnvUgWV9poFPaw6wjDHfTTu/hhyKaWdi8YmBCcYBw=;
 b=OL5WRXlpXaGQiFwgUwGEbud/0i5zL81SFSQH6xDb0VQ89WRLh51cLYFpKS4hCeImbW7t+rP+C7nw0ic9SHVJP2R8eN7z80VD2hAzgLi6pX3TRQRuXxxUW4rxjV2xJzst3bF7nJ5+z00kt+rgioaPlnORYHpaPdXen4Gufub9rK2pkWFPgFy7ENJvUKq4aAbwaYY3K+7vdCbT7H/YjFeCPUePXn7p7vGNuHVAZD8BN+INlao/YXElOYwk4iFc5/tesbyO1v9jZC6yYSFMItoCCuRLd1BuBwh44lcM8XNqbOWYhZiTojdckkxmH6pLIAIX2UV6NR62ZwdAkSUNUZTwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQxnvUgWV9poFPaw6wjDHfTTu/hhyKaWdi8YmBCcYBw=;
 b=hLU/2pmbUqYEsLk7OPtU6SZaaX8ySISBW7EMbq6XqsJNoI97rMBZmLb4anF07sPnL4uCObaH5ktxUN2jcNYn5kJoy7+cfkeQG19qQWJk0F/HAf4xj1Zpl4Eyp0J2TwX0PGPYUHcQ9yxH7gHOcalsV2VKMYMIcbvBp7rm2slDCA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 15:02:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:02:18 +0000
Message-ID: <f1e9ed0d-f05b-439d-9a11-2242443b485a@amd.com>
Date: Tue, 7 May 2024 10:02:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] Documentation: PM: amd-pstate: add guide mode to
 the Operation mode
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1715065568.git.perry.yuan@amd.com>
 <651c35dfa654b4331e597647b38a21fef477083e.1715065568.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <651c35dfa654b4331e597647b38a21fef477083e.1715065568.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:806:120::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b5bf41-b403-470d-3f96-08dc6ea6b080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1BHR1JJbXVhZUM3anR6NG1KNGN3Rnd4bTd6dWFyTnN3N3N0aEFaSGFEOHRh?=
 =?utf-8?B?R3VoYkZieUZnN1crM2o3UzRwRWE1c0RFbTMwWE5HRzlEVXdzZFh5UmN0dXdV?=
 =?utf-8?B?d2QrcWVpbnpSR215alFJRlUxMEF6UXR3N282STYxemg3V0E1U1plNDhuM2dy?=
 =?utf-8?B?MFcwbFJyWDFQL2diaE1TTTZGOVNweGZJck1DRDczMERNMDFJM1haK1YxV1Fk?=
 =?utf-8?B?cmhoa0UyVHV3cmxuZnlrT2JEVmxVenEzcE1BNzRka05XKzVzL1RyNXNIcE5l?=
 =?utf-8?B?aldvdlo1VXpUanRuVFU5Y1hLTDhWbkFuTDZZK2ozL1YxVkJDSE5IK1pMMUpY?=
 =?utf-8?B?dmxuczVpNjE1NjJLYjVRM3lyS29oYm02Mm9KaWVaWEp4SkVmemdHNmVlbW1G?=
 =?utf-8?B?THYra2V5QnBSaU56b3NIc0QxUGxub3NBR1pUcTZXano3WW54Nmo0RDd6SVRM?=
 =?utf-8?B?SVhlcnFKU1NZaW5NaW5xUy9oWUtYbHQ5K3lWK2tzNm9CRFcvKzU2d0ZMMFRh?=
 =?utf-8?B?dWlnZkY0OXA5K0p1U2hYYXFtVnZpcGdBM2p6QnB1TFhHN1cvNTNqNkJyb2ty?=
 =?utf-8?B?UVRXRkJyZlR1VDRocytrYVNneU9DVWttc0VoYzErT1VVcW5ENEhGR0srWG9K?=
 =?utf-8?B?ZkZsdDFnd2ZTTjJFMEhTZHp3dHRBc2RBMHhoL3FpWEUxSUY2eHF5d2phbjIz?=
 =?utf-8?B?ZmdWMWVYbFd5ZVZZUEF5bkRsZHhqZmZVL2x1RHlQSElUa2ZmWWZSOUEyUUZ1?=
 =?utf-8?B?MFNvRVRPcnVQNGJVcXRzcHdtc21WZkFNTGtWOVRZTEdLeHNQdE9OUnFhdWRL?=
 =?utf-8?B?d1BaVSswU3ZoOXJCN21zNzlKbzVGRWdkdURFaFFFUEExaFZzRFM3T2tsTTlY?=
 =?utf-8?B?UmhWNFB4dWs1d21WdlU2NEkxVjFKeURKZnVYVTZOeXBNazRNTlMrMlB2cWlp?=
 =?utf-8?B?NTh3bkVOY2ljUHUrT3gyTUNlckNvTWJibnVISkNDdk5EbHdOU25DbER3eW5S?=
 =?utf-8?B?NzVyaWFBaWRva0gwYzFiSFVPbVJBMzllUXlSVzJJeERDNk8yVnp5TGRYT3Zl?=
 =?utf-8?B?eEhBV3cvVG5SeTgyUEZxaGZJMlk1ck9GK0Irbm5TRURPaGQySTFEdmQ2dHhv?=
 =?utf-8?B?c3VnSXJBYk1Vb0Y2WHlZTmovNjU3aHBEWDFPSGlwQWIwclFtNUlvWnZ3K3hX?=
 =?utf-8?B?SDZIbHpVbHlTbW55TjhXcEMwcGE2TXl1bzlSS1dkM0c1MFQzVkdhSmp6Vnlz?=
 =?utf-8?B?TjQwR2NKdUp0Q3ozT1dwQ2pDdFVNOTV0a2w5NGtadGxhZ05UZE5uMVFXb3N0?=
 =?utf-8?B?elB3SXE5Nno1Ri90cmp0VFZEV1RKaXJObDMxYWN4SkRKd3ZreVRDVFpFRVBx?=
 =?utf-8?B?YUk1dzVvejZDVmwzbW4zWU9ZbkY5djFGQnpkZnd4dVp3U0kwUFJnaWozbld5?=
 =?utf-8?B?SXZZQ1FiYm1PRjFkODBzMnhFMW4xTmRXOVRnVFcwVzF1NGNiS0l2Z2xiT3RI?=
 =?utf-8?B?T1hlMXh6aEJnMHdUZ085bklIdndmalFuWXNTa1oyUFRYN2RWNnFqNS9GTVgv?=
 =?utf-8?B?MzZPSUpkZFc0OUpSaUZ2WGQ0NUN1aW9LWllzalNuLzQxL3FnZzFqMCtueVBy?=
 =?utf-8?B?OWY2b1pkTmljQldObTg4Wk1QY3VvQlBveXZFUmt4c0ZuVFVSNFpvK2pNTHN1?=
 =?utf-8?B?QlUzcTZRbUdTWUNlT2dRNDE4WUVCclRjc1JtVEdDRHBUZS90VkE4aFBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzJGam83Q2xFams1aFoycW9MVDlpSUYyT3RaanNNQ2ZYMXRSYXlBS0ViVmVu?=
 =?utf-8?B?QzdYeXNXZ1RCbzgxOFNLL3NvWk1jbExZWk96TXZvK0JYUUR5ZHRTTDQvN1RL?=
 =?utf-8?B?NjlmMEJQZmNMRGY2TWhlQ01rVjBCdzlOd3padWdpd0ZtMG8xVVFUTEVLM2pV?=
 =?utf-8?B?QzRuWHJKQkxCK0NVUEcyK29uZGJLRDc3V0VFSHdsVXRhRkMyRTFLRmJDbFln?=
 =?utf-8?B?SllkcFc2N0VSczc5bG1OdS9iMUVnOGZnejJhNnlZS1d4OThRUEl5N2tSTU1S?=
 =?utf-8?B?YTNkRVR5ZUM1TmFHT2dUYWVsaTZSRmdDaUc1UXp0UmlQT3MySU1QYVZha3VZ?=
 =?utf-8?B?cVpwdkdSTEpBWlc3MTlYTVJxN0tqSkhmbnZ0TUxkdlVnUXdnQVRqaGJQQlg1?=
 =?utf-8?B?UDBYOE55bFF0L2w2dStYN0NFM0VDT3M1UytHVDl3WHZaN1FsUEt2V2NnbGM2?=
 =?utf-8?B?N1h2UVN5OFlpYU1Gb2tzVkg5cUxPUmR4a2ljNmpiSjhGLzBLejh1V1ZHM0tD?=
 =?utf-8?B?TzM2ZGxYN1lQanlGc3ZsaUEvK3g3SlBwdG1PRjNtckhySEFGMHFrN3JXYTNX?=
 =?utf-8?B?RndPREJNWGhzS1EzazNpOVZWZWF5a09WVFZCN21hdjJ2a3hNaDFKUHlHTVBF?=
 =?utf-8?B?YmE1UW4vZkVyYmhzbnF5Qml6eVJJSWhiUE5MNDIvWkw4QUxOampyRTdya01J?=
 =?utf-8?B?YW5KZ3ZxU283Z2k0K3k3S3NONVdYUk9WV2M2aFU1a3pZSjBFbkprN0VEcC9y?=
 =?utf-8?B?bVBXQjRFNWdydUM5OStRSHRDcnFSZ1BKN3JsN3NTOTlMOHZCS2Q4UmJ2YVhu?=
 =?utf-8?B?aC9namVLejJHM2JuUXQvZnE3RDFINjdaTDRwa05QMzduWGFiS05BTWJxczh2?=
 =?utf-8?B?bUw2a0VmeTFWeHRCSkdYN2ZGRWhTUFFjeU1lV1VzVGh0alp5dTZRQnVvVE9S?=
 =?utf-8?B?bGtYVExadjVXbnJNZnVNL1RFUEE4cXRBZUVrNmptaHJBQ3ZkT216RjYwR1Iv?=
 =?utf-8?B?cjlYbVdJZVRUQUZndlNBWkpOMnY1UVVyMk5MNzNrUHMwcGN1cUhERXkxMjgz?=
 =?utf-8?B?akZ5V3pjWTMyMm1ySkNhZFU4eWEzK2xIdnVEMC9aYldNb3c0SzlmSmRESUo3?=
 =?utf-8?B?U2tYSGFUMXlXY0JuK3ZLdTZ3RVQzRTM4RDdZa2hCZ0pjRHEveUxoSWQvaWh2?=
 =?utf-8?B?THB2bUdyYkhERGVIR0Q1V1B4ZWFLNFpCZlZSYnFUaTJudUhGQ0RHYWpsMVpS?=
 =?utf-8?B?M2NieEVqQll3RVR4UnRXK1hXR0s4cEdadUZ1YllDYkM4RjhZZzNJeTlZS21r?=
 =?utf-8?B?U1J3SUQzdjE5U3dpeFRWYVNSQjRqUEpsYmIyVlJzTkFtOWd0OFUyK1hvTmlF?=
 =?utf-8?B?YWtNWEdvdncyM0dSbGNmR3hrZkJZVXFyQUdoN2VQcTJBSithTlJoUWNRVDYv?=
 =?utf-8?B?MVh0UXQ3MmplM0FXTUVSRXlwUUFILzJHaSs1Q2VJY0J4SnROUXA2d1E4MjZn?=
 =?utf-8?B?bXUxVktwR0dralR5K1hqY2pKVERYMXVDalM4WG5VWGJpaFkydVhwNG8rVnBx?=
 =?utf-8?B?ckpWbDVBa05MOE9yQUJjUStlNktOM3hoOWUySlV2WnFRRDYvL1o1MUtXNDBk?=
 =?utf-8?B?RlJJMEoyOVhuN0VuR0lESENaL3JreHNZdWIvZFRLMi9nWC8yU3BHUlphakQx?=
 =?utf-8?B?eHRzeVhVNVUvQzNQZnhjT1I0WkV0R3g2UnBCWWlWVDJVVllIVUQwMnRjcDkz?=
 =?utf-8?B?YTRMN3F1OUdxWGRmZE5vbXhkc2dMVGFYdm9heXhGaUx4Si9SLzVhUnFwZjA1?=
 =?utf-8?B?K051RUZ0K3lqSUZ0di9WQ1lZaUVvbWZ2ODRDWEVVZnlERDJMTUN4VFBKSXNq?=
 =?utf-8?B?eEtWMWNSaVNhSTBIWVNYbGc5KzA2VDRyY1krMHBJU1l6VitEdkZFYVp0Vno2?=
 =?utf-8?B?MW9JS3pMZ0FqZFpvK2x0Mlo1eCtyWGwwczYwSDdpVVRRellyTDNiWFlqZEtj?=
 =?utf-8?B?Tnhya0M5WDgzbWVHUTJxaVNvak1vNjBYOFhiQzNrTzhKSEZ0ZTVGRmlPTi96?=
 =?utf-8?B?UWN0SFp6bWJsZW4vRUxBY0JPdEREWW04Z0I0YlZUeENnMHljOTVHY3BKcTVT?=
 =?utf-8?Q?3WUi+W8Gg5U4oyCyEv/siPCzU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b5bf41-b403-470d-3f96-08dc6ea6b080
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:02:18.7711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ww0fHHfNgFGCs8AeK35khsqHDVvGPeLRTlKqh5RSK6OExOHFnhGsCA87qkWIAaOdTU5EMoH/Siw2dhYmp1upqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246

One nit for next version.  The title should be "guided" mode not "guide" 
mode.

On 5/7/2024 02:15, Perry Yuan wrote:
> the guided mode is also supported, so the Operation mode should include
> that mode as well.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 230e236796f7..9fc924930595 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -410,7 +410,7 @@ control its functionality at the system level.  They are located in the
>   ``/sys/devices/system/cpu/amd_pstate/`` directory and affect all CPUs.
>   
>   ``status``
> -	Operation mode of the driver: "active", "passive" or "disable".
> +	Operation mode of the driver: "active", "passive", "guided" or "disable".
>   
>   	"active"
>   		The driver is functional and in the ``active mode``


