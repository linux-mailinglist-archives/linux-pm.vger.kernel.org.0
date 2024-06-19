Return-Path: <linux-pm+bounces-9615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B6790F541
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2182834B0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98944155C80;
	Wed, 19 Jun 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OHh8EuLQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7044200AE;
	Wed, 19 Jun 2024 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818688; cv=fail; b=DKMG8ZHT2t53sJezUUslCxI5gkNTSw8awpYq6q1lagckACmzWePxDA6QhuF4KpMSQzgF+6QsMfmzAPAkNNzNshkARVzRsVtQIPF41NT2dGoTb+zczlEeOcoa49kyxTZTNubF606bT6Vdp2XtO+hH8HfnpZpEZCqaTeytdAn47GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818688; c=relaxed/simple;
	bh=WtebBU49itd8p3KscI70V7TCBS3Tqm/cVDHaXIvmSH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kWnQ7rpD7KeorWaNOHTFaN8bf5+btNViVxzJqREhSPjM/YlX+PprdHjcM4rvORtWEulzo+F8Qowge8yEWuR05XesO+3ZTzeiYf5QyAPtQ7+7e+UTg65A+SzWzZzd3Q9sWEqVWJVsG4Nl8PyLcuj/fDWXL5NxaOSDPG90smbarM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OHh8EuLQ; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCBb4FF6HSJqICHG1TK04qTVkW53ILBZGhpKbEhAnxRJshcz2GeAcS4W1lZM4MlLUR/I2BfK92/C4lO37PqgI6GgH0NXvL3lfsDbf+ANrnaXgFHhyb92eLtOST++Dno6HxKPGfMP3Xbzo4eSowkdtLzqlwIASamAW/c1+VFQad1E6LPN+Fe5rtXWnQag9TG5q4FLA9MKdcs4DVhAkUggNc7oHR4OG+cMCGA4NMagLI33Cad4X6tI3+auYdhceC5CHw6U639NRlWXILdmxxkCaSWxOUUv1+x7nI6ixY4NrBUpcwvSVVXDvszmfzGpnfrSa0+tgmIrCXhPh1vRjhbXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsqpbwF8DdfonZZsiNrcMYOjhMQy7Ir7rRjjJxAthmg=;
 b=TsyduUqe0FHUmquxxw4pootF7c1c/OMLhgcsHkjkKp6AoTmzWqUsQM5LFQEhO9hNeaVmJgOQeAsd6L8xCJnOTak8Wa/8LDiaRgLLY1zpX4mAwco8VLViutHPre3CbiSGKYVxLrn5Zq4ph2SlUXwYqvwD4bvnKfx8MuTNuoCaWESdlR0KSXAr3D4P/opWOLW3O8QQGQmAHWBcrIvu+nyA71VgJKjMULHoJSf1ne9Gbbt68Ih/HQnNVTFkVTSdjSyYNlV0EaEVfNmcQDd9wUzWdfRb43FLMfF3uOaCnW/R76Ttxt+HLyZv4+LpEazPXstZ906fQys03igTPzKVMEcfqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsqpbwF8DdfonZZsiNrcMYOjhMQy7Ir7rRjjJxAthmg=;
 b=OHh8EuLQOogsxAzYY6TMD8JlqvQZGf67AOpunhYHnX8kE9TkzsDyICJg70RV71bpAAdMsxVSAOKZDIr5AuVJmbIK/JoKPJEf3yb9PpGfwABAchMH6O/6D7jVPVzLmK9PwCcQ+6VNbFeKzMKeSCrJd7S4aERkkPEWmolF5nxdMSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Wed, 19 Jun
 2024 17:38:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 17:38:02 +0000
Message-ID: <6b780c70-91b2-4d1d-9d4a-cbde8d91d8dc@amd.com>
Date: Wed, 19 Jun 2024 12:37:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/9] cpufreq: introduce init_boost callback to
 initialize boost state for pstate drivers
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, gautham.shenoy@amd.com
Cc: Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718787627.git.perry.yuan@amd.com>
 <9d1ba8e29feddcfcee0b8a91be3d6950bfa00720.1718787627.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <9d1ba8e29feddcfcee0b8a91be3d6950bfa00720.1718787627.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:806:122::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ea7ab5-af4d-4a2c-55b9-08dc9086916e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmNyWFZlZmhYYkRmS0FTZ1RTb0xzWGg3RDBkV2JvODZvRlU1ekVEbmRqcHha?=
 =?utf-8?B?WkdkcDcrS1I5MXMvcWhFblZGd0N6WFg2Z0RINEpSdCsyeGh4bDJRR29LVXlI?=
 =?utf-8?B?S2VZTzNmOGdpZzhoNGlOaGt4bmdHVFlaaEt5ayt5YWI4QVg4dDh3eTNEY0N3?=
 =?utf-8?B?UGFSV3A1MXRiR2I1N3k1WVpad0NMcVVNSURjdCtweHl2b1hqRGRkNWJMb3JM?=
 =?utf-8?B?ZDNsUVlZcVhYeU1VbnVNRUZ6U294NFRVdU5NWUVDUTFyVmhIc29UdFZ4TWRO?=
 =?utf-8?B?aVlRU1hGa2ZQSVM2UjhxamRNeW4yY2c2dUlZTEN1OFZiZUFJVGNRL01BKzFv?=
 =?utf-8?B?K0NWMVgxcThBaXBERnJ4RGdEU0w5aEJ6eVlsdm1xald4YzdsVnFiWW9oaGZZ?=
 =?utf-8?B?clN2WXh3TE0rcDRFUHdhUnlnTURTS1kzb3pVbUNDdlZGd0ExMkdNMHMxM3hu?=
 =?utf-8?B?cGVkaDkvdmJmSWQ1ZEwzR2NBU0U3SlpENytXUHVIZGh6aW5YbWI3aFBybWZM?=
 =?utf-8?B?bVgvenRzUTRUV3RNTlpNSFkxSEVPVC9sOWYxY05aTWc2ZGhHVW5rWEVqRlEx?=
 =?utf-8?B?Tk0vcVAyUGJxRWRxNjR0UkxPakZ3YmhDU2JjMHNTa2pIVjFtanc1K1pTWThV?=
 =?utf-8?B?bW1rNDRzMWErSVJ1SUE5TnJRb0NISE1DQU1YSE15YjlQb0RJdmxqY05nLzVq?=
 =?utf-8?B?UjR4Z0NRZlhIRFFYb1VqNUkwejZNMGdaMGZqY3Z6ampVWGV3cUxPa3RJV0FD?=
 =?utf-8?B?b1daNm1jSmRSaVpsYlhoQndXbnVmZ2VOblRlbUk5NGxENWtTazhBSVVVVGVV?=
 =?utf-8?B?OVIxQmlVbFU4SG9MSDlzblo1WURyRzV5UmtHazNWZkZlNVZnWmM3WGlmOHBo?=
 =?utf-8?B?aEtOWktLZHdLTlVCcitvYXJMMHpIZGVqQURyc1JJVlVvc1kyYzVBeE1VL3ZB?=
 =?utf-8?B?UW9GREVLSXowVW9uUTEyVFExZUExc0pQaXVLYmNXYkg5RXRrV1JyaWJmeWRG?=
 =?utf-8?B?K2tEZTE1bjJEQWVzei85dzl4d0NBZlBmRDZtK1JBT2d0ZFBXVEhRTXhGQldN?=
 =?utf-8?B?WUprWjEybUpMQzBxUk9QRDBYNm9tOU55cTFydlpVU05ZbXo4dXlIV0JJeVNt?=
 =?utf-8?B?dmx2MHBVZTE3QURNWnQ0WDdGREdLMzcxcFc3akRNOVNtRXF0K0N6QXNBM2Zm?=
 =?utf-8?B?TDg1aUlId3lMdUY3Z09mSkwxOUErV2tQZGFjZklOVll0RVg4WjI0UUdhOGxT?=
 =?utf-8?B?ZitqckdCQWwxSFB6TEdHcU9Lc2t4V3UrejlsNWpSa3FpbnEyTHFsRW9WdUxB?=
 =?utf-8?B?RXhIeEJMMFVmV0ZkWUJTNTlxSUtFbjFMRDZzc21KejR5blZ6clRUNmRYajNX?=
 =?utf-8?B?UTYvYjNZOWJVTXQxWGNvZ1JvcEpQQmozTVFUekVXRGFzenBvTTgwRDVDLzRN?=
 =?utf-8?B?NzRZcUFMWHpLZ2hmVTIvZkdHY0lCbjZrbWoxNU1ScDJpbEY1dzhaY2R1YVFq?=
 =?utf-8?B?MXkweHlhVGRjU2s2amtJeHh3WCtjVmNHc3dWbVpENnZXbEViMUtZYWpHYXpN?=
 =?utf-8?B?ZUlHc240SzhwMXhmMFBaR0RZRGR5Q25DNE1PY3VLZE95aDAxRkFsZVpzTkNj?=
 =?utf-8?B?SUxDc2REVnUrNGZmN2ZhZ1A4cWxITENEZ0hoUWlDY1Q3dlpGR0d0Zm5nWFYx?=
 =?utf-8?B?MGxEaGhkbkVJUzg4VjhZTUVzakZGVzdJMCthRVZIRkFWU0lUTlhYRWdIUUNh?=
 =?utf-8?Q?wB58hsWW4S7/B92MGTr5YAlgHrUCRqu+Fz1sJ5p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUV1VUJyUzlVRlc3WWhpc2ZwbnR0QzQxOHJyNERlVVlHQWpicVgzTkV4Vlpm?=
 =?utf-8?B?alJURkV2ZlgvRnMzWUxNY1hCYzFaZmpHRXg1QjN6K210WFh5aURHSVdOZ3lB?=
 =?utf-8?B?djM4Qk1wZTlod0tKd3B1NWVGZmRGd2xKM2RWL2E3eWg1SlNabG9aV1lMVUcr?=
 =?utf-8?B?T1QvVmlEQjJYR1JXUmhvVVlBNy9yYkluVUZNcWhIWVB0LytSdkhwbUw1ZFJt?=
 =?utf-8?B?SWJUcVltRWJCUkM0bW1rL24wanNVWmdVVTBPbG9qRC9yaE5iZWZWaElENWNJ?=
 =?utf-8?B?aW8zYjdIeEo0cys4S2g4KzhqZ2RDSDc0YzNIYWk2amJYQmNDSVM2UjAvNHRp?=
 =?utf-8?B?SHlwZDEvYnUrMFZ5WFNDZmlUT0dQMDNhMXpMYTJodzBSWi8rRTk5bFM0d3dx?=
 =?utf-8?B?MHdNOW1pUVRKSTl1V3pJMkNvRDJ1MlRtdEJGbzllM1U1cEV6Wk12TncvdTQz?=
 =?utf-8?B?cU1jMkFzTWN2d3FsOWVMTGFVOWY1ZTR2cGVYeE5CS3RUVTJWNWhjRkVlbXVX?=
 =?utf-8?B?ald2VjEvK0JNeUJpR0FWVFNHajRhNEwwc2Z5a3I1NUdKVWxlVE4zTFNaM0Mx?=
 =?utf-8?B?K3FqcFVWQU1PdWhEUWFLME5yQmxRMnVCMy9RSmpvS3Qwaml0dDlueDZ6Ry93?=
 =?utf-8?B?ZkZHOTRKc1BQNzFaMTVkbWp0dnFweTVMaFRXUEhKaGN3WlBvbWZ3QjVUVXc3?=
 =?utf-8?B?UUEycWQvY3VqdHRIZVFDQk1vOHcvdllWVkhzRXlJRG1RbkNkdW5JMUNUSXpt?=
 =?utf-8?B?V2dndXhEZndrVXBjVDYzS21JdERHb3lFanErcnhIVm1oMHc3VUpHcUphVmlF?=
 =?utf-8?B?QXJjcG41MFMzdWQ1dHRwdjFIcnYzOHJrcHVrUkVId1hLVzkrRVduUnNHcTZE?=
 =?utf-8?B?ZVlDbFRPUDFZK0QrMU9OWXk3UjBVRktmQ08wbHRWdEdxWEw1MWlnRzA0bUxn?=
 =?utf-8?B?bFlqWFVKdHpRRk1KdDl4bVAwMExnZFRUS2hkbkJwVHgxK015dW5ZbTRMTmNV?=
 =?utf-8?B?aHNMTDMyOE11ckN6R0dORlhXR3FmbFp5NUd6cS9ZbjhCU0c3ek9xWFpxaDBp?=
 =?utf-8?B?UWZPYlU5K3VBclpNWkpYa0VDMktFbkNjQkd5SFpCZm9oNHVaVTREcUdoVXgx?=
 =?utf-8?B?ajVGWktodWErdytzSzFGNzRnSWx2QkU2NHlaa1QyUjdhZ1kwWWNZSTEzSnF1?=
 =?utf-8?B?NlJOT3VYVzczUzdwL3ROZU13UlNNUGlBWWtEcUpZcEtMcGgzZXh3VHVnbGs2?=
 =?utf-8?B?U05lWVZPY0wzOEhZcmlPdFozV0ZaQ3NKSFlaVm92dmhtdzRMZFAwTy95c3ZY?=
 =?utf-8?B?aU43SWlHRmNya3dKN3dvQlFSc1lkckxKNWpuUnhKeEFBUy9jaG52UUY4d3ds?=
 =?utf-8?B?dmV3dElCdUJZc1Q0a3d0QWFRNWYzRkFMdnZaVko5MkIzbS9URnN4NmN6WFlk?=
 =?utf-8?B?SVFENzl6YldEbFNjKzcvY2VlNEJnWGtKakQzZGRiNDRGZWlGOWlsZ2hrNVo2?=
 =?utf-8?B?aXZoUWJOanlIRDdHVXBmSWViOXZVeWpteXRIWGx6ODhTTjA3YkVqYjJaa0xp?=
 =?utf-8?B?MjZjY3M2ak9TMVU2RzhJVFRoNDZCWm9oOTFUTTc5R0JXN3JyV0w3SHNXRnBm?=
 =?utf-8?B?dzd2M1pqZEgrU0g3ZDB0YWJWb2JwZVdaYTc2STl6bWdoR204dnZrRDJMTTI1?=
 =?utf-8?B?T0ZsNlFYdzRLeW9vLzJyZWE1cDZINE43NkxDM2d4UTZRcFJIUjFYYm1rdUx1?=
 =?utf-8?B?NWlLNkRjRzVQNms5bXlGbE5PNUY3Y24zV0ZuY0tkelNodEx6dkoxVjVMeEZ2?=
 =?utf-8?B?cEhHVU5rakd1aE53ekN1c1ZmK1NPU0VQL3UwYm4ybFRYdm5JRHZ0aGN4V1h3?=
 =?utf-8?B?SWMvZUdSVXBUQ2hGMmVVNThhN1lyWnhVTU9UVWVmZVVnZzRQelJwcEtjM2d6?=
 =?utf-8?B?WXlVQm5INGR6UG5EV0w3ZzF5WE1RMFdvNVdNcmFTMHE3dDZnNzZHOG9FNGhq?=
 =?utf-8?B?MkVXTlVYcWppV242dU4rZXZodUE3dkZ4RUllT2lWUWtYMnNtNUpXQUNwSlhG?=
 =?utf-8?B?aStNa2hENURDMlZQSFpjNjRDMzA4RDhhb2xPR3g5MmVXNFAzcjFNY2c3QkRZ?=
 =?utf-8?Q?iiEL0a5q417lFAI33l4v1W9ib?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ea7ab5-af4d-4a2c-55b9-08dc9086916e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 17:38:02.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrDQQNIfhDlVJoo4iNzzSFaAMue30gTzqWO8u4HEkCLEGLNspEHp1809e+9SAgWYHF7uR3Ry45zLkBDIykKGrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035

On 6/19/2024 04:16, Perry Yuan wrote:
> Introduce a new init_boost callback in cpufreq to initialize the boost
> state for specific pstate drivers. This initialization is required before
> calling the set_boost interface for each CPU.
> 
> The init_boost callback will set up and synchronize each CPU's current
> boost state before invoking the set_boost function. Without this step,
> the boost state may be inconsistent across CPUs.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/cpufreq.c | 13 +++++++++++--
>   include/linux/cpufreq.h   |  2 ++
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1fdabb660231..64c6770e24c8 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1429,8 +1429,17 @@ static int cpufreq_online(unsigned int cpu)
>   			goto out_free_policy;
>   		}
>   
> -		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> -		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> +		/* init boost state to prepare set_boost callback for each CPU */
> +		if (cpufreq_driver->init_boost) {
> +			ret = cpufreq_driver->init_boost(policy);
> +			if (ret)
> +				pr_debug("%s: %d: boost initialization failed\n", __func__,
> +					__LINE__);
> +				goto out_offline_policy;

You've got a mistake here that you're missing curly braces around the
"if (ret)" block.

So what's going to happen with this code is that no matter if 
init_boost() succeeds then you'll still offline the policy.

> +		} else {
> +			/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> +			policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> +		}
>   
>   		/*
>   		 * The initialization has succeeded and the policy is online.
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 20f7e98ee8af..0698c0292d8f 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -409,6 +409,8 @@ struct cpufreq_driver {
>   	bool		boost_enabled;
>   	int		(*set_boost)(struct cpufreq_policy *policy, int state);
>   
> +	/* initialize boost state to be consistent before calling set_boost */
> +	int		(*init_boost)(struct cpufreq_policy *policy);
>   	/*
>   	 * Set by drivers that want to register with the energy model after the
>   	 * policy is properly initialized, but before the governor is started.


