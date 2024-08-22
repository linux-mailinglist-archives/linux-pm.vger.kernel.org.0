Return-Path: <linux-pm+bounces-12775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAA095BFA9
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 22:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51928285139
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 20:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B611D0DD8;
	Thu, 22 Aug 2024 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="akF64n4A"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F91CDFD5;
	Thu, 22 Aug 2024 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359284; cv=fail; b=rY6bmWJSe5DCcB87wJeZD856XnnAVMENZIdMzR43G+YwE87QKvIvAZdNzwGg7Lxjt7F3sa3BzSw4i9sdRho8/M4gWN8R/RoLkDglP1iAtVb0VROobSH6wCp77fp1HpYCfXo3HCQNtRe/fmr3eVKmaAQ5CRQA1djjG8H5WkX0Pks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359284; c=relaxed/simple;
	bh=up9SWyM/VQ8cxcfhbXApAoOGx8p+PsQQlBfeWssj5Cs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ep6ne8kpoMZSDVgBSmhdGOATmF6BM5qH3CqP9pCwM4lItBH1zCQhsu5dLmiyo7TKTJOlLZo/K0cwfoY2KyEum/HEJc7T6tYcShGCDwIdY0004ec5u/qPygiiiLzm6ajBTZwEyFkXWCenVwwk0hbX3wuY5qSdE8eGBxjFRU2ViC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=akF64n4A; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3TfLWgt50dS9OoIfXm/IrvvbdgO91xns5ifmObmqmnH6bGgmPlSrboQpSjOn3X+56QOPUd2smnkoVVakRtgDQj/kKy+aAlsGc5ZASNuK+O9nuXjarQOhZuO6SV1lZriHBlFAhYhPrytESoi+1UGmnECq8iwLqs3VJPb8XHbLcJeHWjuzfvpr7Gt0WZ8IEspZIlwgqmIh8OHxiZOkV+vOJDvOJHB/5SNCgjrRb1gaGb7Yv+3ZHH7lZS9Ng6DaMnlxLcqw9WUtYq4IhYjpB0TmIV5KypUXd2TJIhNHxOKQAXfgAGLkzvCZw60Ucr/lEE2DAeMkwA91FovFqW279NGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQJyTG+HsnrPuCYcN4ArFjVvTpk4ztrTQ15OixmxAVU=;
 b=YFLnKt9veldSo6zG3CBWJe5bFaLApxLI25GJ4vXGQHi/vrlV0ZkG55ithB7r/J6Pxy+rSSx88VhA1oRBJ9cigI+9UjWs7AuQlyrasutnCjHWYEsmgVeP6R9vFLVySCL7HzATQLhLkKFFaGOK8TNDLROuDs/OtoFymxUq63MyMVNN6qHKkkgT4AO4PPZ5vrShL30OsNZIn1uN+TSsqoFzldJcZZ2NM1N6ioE3AmYFx1tLzCxbz6EuCQoJINNFLh/cZ6Wuy0fH7m2cAMqZ7S8ykSVUA9z+PzBiNJepAxQheWYC0A3Dcl2o2ZOut5qEGhxrLwxXyiJqfhnJZRT6bff0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQJyTG+HsnrPuCYcN4ArFjVvTpk4ztrTQ15OixmxAVU=;
 b=akF64n4AI3K8Fqr5O7q2givaUMfglg0Y0aD/aXiL+Hsbi32ipX9wQa8/3O6L1tPhOPUbxD44b8FLI/hQW7AdLXyt3ZP2Xa45UjkOkKkq8IF05hFFeghjo/OKhmAvUzNZfmnUJUZME/us56LtUrQnjVzphxvtrA1lYpdqdvLno/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 20:41:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Thu, 22 Aug 2024
 20:41:20 +0000
Message-ID: <e53159a9-3451-4255-8fa0-bb9aeee09fce@amd.com>
Date: Thu, 22 Aug 2024 15:41:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cpufreq/amd-pstate: A set of fixes
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, David Wang <00107082@163.com>
References: <20240813095115.2078-1-gautham.shenoy@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240813095115.2078-1-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:6e::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a84c9a-e900-4b53-4c57-08dcc2eac779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUhmaFo4M3lNbmcwOXVHZE01TmJZa05rTVBubXI4czZaVkVGZENFTVlZRkVz?=
 =?utf-8?B?R0JoMElycit0VUhGYjR4THdGUG1ET1FWeG0vcUoyalJUU01JSFlkdjFoUnN3?=
 =?utf-8?B?WGVSdy9UdmhhUEFhY3ZTZ29qZTh4Nm10Wi9rNnFTMlM2K0xXcGk0Z3cxdk9a?=
 =?utf-8?B?eFVmMWhHZGJWRDRDcTNDa3Z4S1I2VjgvZnc0L3JZeXVIYVBWVnVvMXJPQ2M0?=
 =?utf-8?B?L3BudXk0Q3BTU21NOXBpWkF5SExib0pKZnNnaExqREw2Ukx1Ry9BdVg4UkFL?=
 =?utf-8?B?Q242R1FpbEF0c1poWjJ6RlZvVkNpQzl5SWdFTVRqaWlrdjNwaGI4MTN0dlVk?=
 =?utf-8?B?aDZzNll6bDh5WDNXa0dBOUpvYmlZZnl1UTBJKy9hUFg0cjlvbEJ1RlVPaFgz?=
 =?utf-8?B?TDZNc0dZMXFSRXVKZFdaMGs5L0pIOERwYVI4Vm9VSVlxYXVwdU9ERFVreTdp?=
 =?utf-8?B?aGpCbllnNzBqWTVVWVl3TDFsYlg5Ri96RDYrSUpuWTFpOWd0RnR0Y3JVNG5Y?=
 =?utf-8?B?Ti9LcENrV2Y0cjByVVgzTUM3NXZqbW8wSEhpa3lwOGhVOUYvVFVaZk02T1pn?=
 =?utf-8?B?VXd1clBhMWtubW5TdlBhcHhQbjFoYXlpUkhnMHFVNFZZdkwrcHBQTmN3TDBT?=
 =?utf-8?B?T1VLNWFyY01EUi9RVURMWFd6NmgvVEF2T2ZubmdxZVdKOFlqa1p0U0hZd1dz?=
 =?utf-8?B?WG1sYWs0R3pNcmZ0dnFLR0ttTUVMVzVnU1NmWkZtSlZRUlhHakVLL1FlNHBJ?=
 =?utf-8?B?WDRzRnVvdzg2ayszZXpRNjZEeE4yNjcxV0o4Z2xnYWhLNnlxZ0lqVnpEM0F6?=
 =?utf-8?B?aHNIMzJpWk5adGRPUVdGTmNsSC9xVFB4bzhVK29CVk1oT3hnbzNQYS8xcHh0?=
 =?utf-8?B?b0FFSitpaDVtY2R2c0FLTDdhREE4bHBZY2doRFdLa3FQYnRMbDRKeGdmeTU5?=
 =?utf-8?B?LzRUK3RYcEZkTmNiRVVvNDhaRFpkMkNNa1RRYk1vcnJUeXNHeCtsdE9PL0Ri?=
 =?utf-8?B?TzdVdHMwN0RUOHVKUW9EQklHdTdaQTJ1YXo1WmtuL1NwM3V4NTk2SXpBUHZk?=
 =?utf-8?B?SFR6MjBST0N6eXBTRW52elVIdUxOVkJIcExySFd6NGYzS0EzWVRvNG1BUkdY?=
 =?utf-8?B?enFKbmxEY1BCR09YaVVxMkdrb3F5anN1SU80a0Y3a2psK1FqellZalQwU3Fw?=
 =?utf-8?B?Z2NjSG9aZTZ0c0YzbXVtNWp5c1QrZ2c3RGF4UWdUbzNmRExWTGFvQUdERlBs?=
 =?utf-8?B?bGNPS1pqa0JVV0hFZWl3K3JPVFF3Y29RSDhHa09URVZoZHBLclRKcUVDUFVE?=
 =?utf-8?B?UG40dFZUZG5LR0dRWVJMdzMwaGJVOWg5R2QzT1MzN3J2NzVVVnBTY3lsQzlJ?=
 =?utf-8?B?dEM4Wk1YZzZJL3FwZFpaZi9DTnZEOXZrN21YNzhVUUVwZlFnQjQyV25zYjBh?=
 =?utf-8?B?Y3FiS2Rma0ZRZnJpQmNONE4yaXJqdUx2R2FmVXVyT1VTZm9MS0dFY2RuTkNp?=
 =?utf-8?B?K0Y0S3MzUllUdGVqUUhxdUxVOWZ6dmlHL2RQM2pieUFsZnh4QlBmR3kxTVI1?=
 =?utf-8?B?L1o2ZzJ3UWhMaGhERGZSd1E2TyswODA3N2pacVd4a00vOEovQ3RlaEZtRUZM?=
 =?utf-8?B?TFRaS2hmejZSOW1IUVpteE1icHFZOFU0bU40MDdQK3k1d0I0RHVtZXgxZG9v?=
 =?utf-8?B?SWg3L0NXeWVGU0lRMXphNnZoN1NxWk0zUmxkNWpHSjE3Y2trN0N1REFtOHFF?=
 =?utf-8?Q?aOD/oXC6agP0+YNC8U6DXVRTrIvDqcuQA8uYXDK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm5IZzk3NjN2V0IreVlwNmc0WkRDbmgwdnBhVXBnOVltcm04Z0N6WVIxYjNk?=
 =?utf-8?B?NkFUcG4yK2Ryc2JMRWpIcWRFeTJJd3hmUHJvUTVZbWlobkh5ZU5mQ3FVL0lJ?=
 =?utf-8?B?L1NIS1NFU0p4UjlZQ3ovSlNCK2NZbVRWQVY2Rkgrc3Zyd0x4N3kvdVU1bXl5?=
 =?utf-8?B?REJyejgyNEFQSHV2NWVoK0Vobis3VUZXZkRUOTkyYWkxaWNOSDBlN1VvVlhY?=
 =?utf-8?B?UzFaMWhZU09PcmZOamZWYm5uWnN0bnV1WkZ6cEl3U25JbzRMVVRCdlZqQStp?=
 =?utf-8?B?OEhDbGQxVUN3NFl6azlDSlgxbW9VdG1BaEVhem9CU0F5MldhbitBOS9QYmdx?=
 =?utf-8?B?NTRZSDlBM3d5VTVtTU51WW9jOEkwaUNwSEVrUVpRZXFVdTZSdXpGcVNxcWFF?=
 =?utf-8?B?RjBuQU10YVBiS0NGeXJPMllRNklnc3ZldjI4ZjJlSDJqNEhMT3VLTG5kVk03?=
 =?utf-8?B?ZFd1RFhHNkV0WGljT1NvWE5ST2cxUDZ1SkY5REJaVXEvQWZUZ2hldW9iT09s?=
 =?utf-8?B?by80Yzh6MGc5NWwwZDdVQWF5R2RIdWpFMEt0ZlQySGRPMlNrT0RZc2M5NFJa?=
 =?utf-8?B?RUJtTHJhZlpaUkRlS0l3OVQ0WjlQOXJVeTRFWXZrVThYTzRyWDllanNheEg5?=
 =?utf-8?B?UDR3NWFYcE5qeC8xQmZiWm9QRFhUazhRMk9vYll6OW1SaFdhWkhtWm41V3JO?=
 =?utf-8?B?Ym54Nk1oOE1od1hVeGZEeko3Y1JTcHd6Q3Z5Y1JLa3NhTjQ3V0J0MW0vSlNn?=
 =?utf-8?B?a0xUZVo5aUlWUG4xNS84eXo0bjk3bHNVMzRzbG51R2VrMDhxemk4UUhSaWFt?=
 =?utf-8?B?Z2Q3d2wzL1dKVFZ1b0xYQlNwWWNVSmlFa0hvdDhHekxlWVV6VGY4d0FGbkJa?=
 =?utf-8?B?U21vWkwrZ3Q3cG5pcUlxQ0VuZUNYSURYN3RXd0VaemFYWXhXVmFQaHZYTmlY?=
 =?utf-8?B?Uis5RzhDVXplVnVSZW1oQ2FqN0d5NDMrY1pyRUxLS3FOZ0dyeVhQa2xMbVdo?=
 =?utf-8?B?NjBMaWhueHM3YjhacURBditrYjJJRE0zUE10eVBieUdnVERkOVZQemFoSFYr?=
 =?utf-8?B?OFRKQlhzRG15RkNZNzBsc1RyR2FvbHNiSVc1YVYweEZYcDJOSnNxOElFdGdL?=
 =?utf-8?B?L2pDdWM1S205MkJvQThJM1NxQS9iMXQ2TTdlZk55K0h0SVJ1Zlp5NEI5Slh2?=
 =?utf-8?B?TE9WdDhuVlJwLzBBbVNvSW1ZdHdLMnozd0NNUmJMNjg1WjlpMDNvbXV3Y1FR?=
 =?utf-8?B?YS84TUtUSE1DVk9oOWlOb0pVNDJxS09OSGFVdDFTay92TTVseTkyaHFRNzFM?=
 =?utf-8?B?azBmUzNqY2daN3lYY0hMRGEzR2FQMS9NVnFPS3VJb1M1N0gyV1YySm8rL20x?=
 =?utf-8?B?OWN5Yi83eFB4Q2lhQ05jWlFDb0FZdnhYU0E4d1JhL2Z4YnhSRlNiRWtUV3FW?=
 =?utf-8?B?L24zcEg5MFZsZnVoQWVJN21EQUg3RDQvUlUvR2NJelEyTnJ3S0UyT2tmRWpT?=
 =?utf-8?B?MkJ0U1ZTTDhwbXFwRS9PblZ2NUZLY200a3FzWStkTUpyWVpNdDR0Z0ZqcjVm?=
 =?utf-8?B?YWc4RndnQzc1eGt4MERJVU1Jejc4SDhId3FvTEpmUHh0VGsvUUM3VVpZekh2?=
 =?utf-8?B?SUt1QWRRczF3UGE0MEFwZXRnT1dnS2F3ZDFFK1dndUxNT05JRU1ZVkRKVCtO?=
 =?utf-8?B?cEhaVU1vbFkxaXJTK3hVYjFWKzJLSUV4SndPbFJCWWErdDEyRFoxcFZhQ1FQ?=
 =?utf-8?B?NS91WEcySGZHMkNqZ201SlR2TEJjcWkvUDFlWlNtTUIwMmxHblRFSnZkcjRD?=
 =?utf-8?B?ekxMUHFkUzVNK2RCWE5ZN21mSHhoUTVXUGRHUk9wSlZvUm1HS0l4Q1FRSWND?=
 =?utf-8?B?VFdkalhCKzlrWjJuWWFUS0lHVkRadzNKNjFIbGdMRWlKdStCQ0U2NXdWVVl6?=
 =?utf-8?B?alJxMGhtaCtQTkZ6TFZIamdsRlFFZm9ybjdHRGZMMUxMZGEyeFB6Z3l3TEM4?=
 =?utf-8?B?L3dkVGVFemYvWDM0d29NYmh6aFJjVVZDbGJNTld2NlJSR2hWVUNoQ3ZySlp1?=
 =?utf-8?B?ZW5TeDRiWFI3Ly9NTWZWcnNIKzdLMmE0QVoySHhVNlpKTzFrb3hYTmdEVW5y?=
 =?utf-8?Q?7l+CjT64s59hCRNWLMfiHCVaE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a84c9a-e900-4b53-4c57-08dcc2eac779
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:41:20.6429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5JasZhqoRbK9t4dB6tm2uHtXOyDRmXy+5wyzKs/Pq27WDkima7h0F4G3AOS1okilGorKfxMl/igsVlAV904uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894

On 8/13/2024 04:51, Gautham R. Shenoy wrote:
> Hello Rafael, Viresh,
> 
> This series contains three fixes for the amd-pstate driver for 6.11.
> Could you please include it in your tree?
> 
> These patches are based on linux-pm/master with the top commit
> 7c626ce4bae1 ("Linux 6.11-rc3").
> 
> There are three patches,
> 
> 1. To fix an uninitialized variable in amd_pstate_cpu_boost_update()
>     from Dan Carpenter:
>     https://lore.kernel.org/lkml/7ff53543-6c04-48a0-8d99-7dc010b93b3a@stanley.mountain/
> 
> 2. Use topology_logical_package_id() instead of
>     topology_logical_die_id() definition of the later function has
>     changed on some AMD processors since the inclusion of the CPUID
>     0x80000026 parser:
>     https://lore.kernel.org/lkml/20240801124509.3650-1-Dhananjay.Ugwekar@amd.com/
> 
> 3. Remove a warning for the absence fo X86_FEATURE_CPPC on Zen1 and
>     Zen2 since they don't have the feature defined. This fixes the
>     regression reported by David Wang:
>     https://lore.kernel.org/lkml/20240730140111.4491-1-00107082@163.com/
> 
> Thanks and Regards
> gautham.
> 
> Dan Carpenter (1):
>    cpufreq: amd-pstate: Fix uninitialized variable in
>      amd_pstate_cpu_boost_update()
> 
> Gautham R. Shenoy (2):
>    cpufreq/amd-pstate: Use topology_logical_package_id() instead of
>      logical_die_id()
>    cpufreq/amd-pstate: Remove warning for X86_FEATURE_CPPC on Zen1 and
>      Zen2
> 
>   drivers/cpufreq/amd-pstate.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 

Thanks for handling these.  I'm back now, I'm digging through my inbox.
Assuming Rafael didn't already pull these I'll batch these into my 
amd-pstate branch for the robots to bang on and then send a PR after I 
go through everything else that happened.

