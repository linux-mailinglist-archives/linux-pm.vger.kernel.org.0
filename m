Return-Path: <linux-pm+bounces-14035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB529757CC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 18:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6F928DA23
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7501D3EA76;
	Wed, 11 Sep 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kDbUhoHn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F04084C
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070492; cv=fail; b=GdtQK5RYE6eJW+goQvqWO9qhIypR0+AMyso+hk+FnDJW7LljLAQB/E/HrJfI23Eh0FatSTyC9zUprkAyPW9u4nlKQJoCvuso6WI/PcsS737+B34GdxDudRxGyCazSNqPi8lEb9VMdkuI74WVZVrZM280XJ4eFy68ezNyroi/tMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070492; c=relaxed/simple;
	bh=GDKTQFr8CJPc11NDuQm4IYc+Y7u7wb0yR4hHtNv0xjU=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=VPZqUgUeiqTYRalnwG5aFIvj+zRpxgO7mf5yWeeB9nOcAF/S+x89znzbYw2TKMQo2unntuxEMnLqJ4V3vAHKzDIi8Kg30tcrtY92slJ6G8zjc/z1S3Hq4B4PpCHllAkx0OgG2r4Nd0HgdOgVoUAHDj/pgwQcisvHgsZK20OMVYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kDbUhoHn; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWE+rKpreGvB6aad5oIWhvas/HzbwA6H5ZW5Ur740iW91Z1f+1DvsZID1xwUGBOtfiBgsNo5Awe7jt5PcYFkAhMIbCsHamq5MeBr9//rLSlk79rcvqnRpr3M8HMe8s+xGEAM4/azi5Lckh6KTU92P0BsjGqrTA1wNNcMAhJsAXjtDcQrMyUVQUNE/LuG9j6eHHdopjFjyS3b2XhOilWmdRbgbkTtO49uZxl5J9tAom5SplnBsDCKLIIKRK7ccoSToxYKPGtnfS0qt/KbZu+9k9jj/fS8GU1Do77oHOen2Ua/x+l8hOzBF83vwrY1dc2RBB33itfKOVJ7SbjsyXYBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7ga0kegOvm5pZ/4n1djdEh1bdVFtzScf7/1fBZr2Zc=;
 b=i17oOw3EEHpXq+vskGLaz7ioP4GukIJRAB6DSN8p4nG3mcsOQvUCqwyR67inXkwc8LJZlVqceAOqE1KaEdK/9Yw6EHjy2SGOi4caHJdbr1o3q/YoDzccMSSBdjjKzE59dwtfNgXURXcS5f8HHcMtBMvsxWERIhN+pQcsjU+FlIFMeX4+KHVU9GmoNQyRLX9Pgz5gyApOorUhs/AGOK7Q5ur0N17d0SAJvldFzkVO6Cfel9enrQaM0xyziAGBzk+OLhqUOdPgQKSHBWrtzk2Yphv3pUqQZmrL7kZv7EZPZHSntS2r6AtHVTc/0rcWoY51TsiQrFek8UK7HCiRkijrAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7ga0kegOvm5pZ/4n1djdEh1bdVFtzScf7/1fBZr2Zc=;
 b=kDbUhoHnabmXPU6OPGudkDsirm/YGEXjUBEH7fo/GWZkS6dK0B/uTt+2t2n9ToBqPAo7q9PLfcOJUD7uu5VdUh1BV5jDYGPqGXaSuPFq1XIJjntr0FmucC5C3nzl10tD5PPlM8zyfIGqNnI5f5VrVOK6n3VvJ4m3G+b2JGKv5jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 16:01:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 16:01:27 +0000
Message-ID: <0f490e10-bab5-44d2-aa9f-efd80d306083@amd.com>
Date: Wed, 11 Sep 2024 11:01:23 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: second round of amd-pstate changess for 6.12 (second try)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0167.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 5792b1b9-20c8-4ef9-d935-08dcd27afe39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjZDWFR0UHdDM3JuNWtSVUhJWmk2OUhKRHh5TmsvZkMyM3gzZjZKM0dRSG9k?=
 =?utf-8?B?VGpLelo0R1NXa0xhUlNZTXlESTA2cFJYak9DUE91QStvd1FIWHJmVCtZS0ZQ?=
 =?utf-8?B?SjRMRjlCekRPbUJ4MGJXNXAwNmlFYW1sL1NWc0p2VVAzOTBNZ1NuRzJTMHE0?=
 =?utf-8?B?Tk56WmQvZnpQMldtQnJkTktQYjZnOFptWVM1NE9YZkhRUnhyRXJzamVJSllv?=
 =?utf-8?B?NWk1QTBMZGMzQjE2RG1Ha0M5TU8wOC9pUTl4NVlWVmwyRi9WWFNFTk52c09L?=
 =?utf-8?B?YmVwQmhNK0pDTm9laDhudk55ZGJPMWFjTTgvN3FrZ3JnQTJ2a3REbnlZSFMv?=
 =?utf-8?B?K3pYTmJOQVVUME9vckhzdDViTTVzUk5kZjloSlhlSUNHY3JvdDREbXpCR285?=
 =?utf-8?B?ZktDSFY5bVUxdVR5elBRcGJLV3duZDAwWTk1ZXVqZEwwREJlN3Z5VElvNk5E?=
 =?utf-8?B?Mis1QzVPRVlybkRHSHpuTjgvT29jRnpCaUJZaCtIeGlCYnM2M3NLNlYxOWZo?=
 =?utf-8?B?clFtUXFmSUk3cWVBMzhxUEtzTlM1cG5kYUxhWHJNcSsvNXROT3RrMnN0NnE1?=
 =?utf-8?B?d0dQekhFNUdhNHNBSTJLN1NncUNCVDI5L0s0Rm9hVFl1RU9sMWMyYzNEajBa?=
 =?utf-8?B?RHF6TWt1ZUNxMjRPdHVRWFE1aDlMaFlaMmFsbmx3S0JlYkRYeXZ3d0FaVXZr?=
 =?utf-8?B?TWk0UUFkazNDVm5SaFBraFpDYm42SDdYRFMwclZKaEVKbCtLYTAvSXcyMnRY?=
 =?utf-8?B?ai9uQ0I2eEplWkZ6SXQybGg4bTZIQ2dKa09RK2FQWW5sc2NxL1F2NkE1UVdu?=
 =?utf-8?B?a0gyQnFQMTRFajdYRk1wQVBudWRqMC9pTmJ5bXNyeGs0bzJYaGhaWUQ0bmdt?=
 =?utf-8?B?SGlVbzd1MU1CVzVuOTV0dlBFcVN3dWErZFR5V3pVL1lYVmsvUjNhUHUyWTg5?=
 =?utf-8?B?MHNLeG1ob0NkK3lHVW1zUGphazdqbFMvd3Z0WHFkWHVYbFZaY1Evb3VPenZV?=
 =?utf-8?B?Ri9CZnlQYTZITjRxNXgwM3crUkwzTXhHTGVRUjJQOWZoYVVTV1JTWjh0SzFC?=
 =?utf-8?B?ZXM0eTkvQ09weUNZd1pWbkppZkc2cjNtUG00eGJLYXVFOEI4Y3JPK3lJQk9H?=
 =?utf-8?B?eGFtTy9sOFYwdzFsdW92MlRqTjZCblBaZnY0Q3dQTytYa3Q5SHB0czNZelFq?=
 =?utf-8?B?cFVxMzNkcjJ2UTNsaUZOZTVWRHhwY2NqK1FsNTFUc3l3dG52WEV6Y21lUUpn?=
 =?utf-8?B?S3NRNjNqd2VGTjdiNXdhcW5SdWp4bkMxdldQZkxnaHVCK3NSQkw2Z29vSEw1?=
 =?utf-8?B?RVJjVk93alo2WkdyY2UyNzRjMFNjQ2s3RE5Mbnczd2djRE9JTmVJbEdRZW9D?=
 =?utf-8?B?VHM2djF4M1VvekNLN2pLaG5yd051Zkt0eXpQVkx3alNDYUVIQU1zZ0o4MzNs?=
 =?utf-8?B?YlYyb2Q5WTk0Z01WMUdYcDNwWjd4dTMrblN4RTdDd2pJb3U2NXFBS3RwWGNJ?=
 =?utf-8?B?OEVsbmVWNmp1RmJDU0ozYXcyWGpoazRIbi9MNzB1MUhjdWdJTFdZMlpLeUNt?=
 =?utf-8?B?cXplU0VhWEUvRmQ3RXZSekxUQkgvdHJkNHh5dzJ1YjFVa015TU80a0pzQUpx?=
 =?utf-8?B?UU02NnhReDcvRVF0K2ZKL1REUFh5dk5UeGxrREYvVERlWmZycnZLQXNsZjdW?=
 =?utf-8?B?TGpld1RBS3pZckx2TTFPS1QrZnJyL3Y0WVBpdmwxeGorMW5IQmw1VTlJYkdN?=
 =?utf-8?B?VWYvc0FUZWU3QkxENU9EMEo4eW9vRmcya09XQnJaUGJNaUV0THF1ak1TMlFL?=
 =?utf-8?B?ak0rZld3TGhVT2FUUEJkdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjFRN3dtOXBlS2dyOTNXSGRBSTZ0c2M5ZEkwT3BxUmJIdDZmSzZvbThSMEU5?=
 =?utf-8?B?dmQzUlI2Tm04REhCaWNaY1lsRktCNDI2alBGYkQ5ZVZWR3VXQnkzSzNUR0hs?=
 =?utf-8?B?cG5vam1IZEJmYnJZYXdvdldTaHhEWW1pazMzYzlxdW01K1VTaC9udHVQOVlo?=
 =?utf-8?B?WWo4eGVCZUZ2L0kveFcya0hIKzlqOFByZEpUNUlmcGZaMmhVREZFUWZYTnZM?=
 =?utf-8?B?UWQ1WHJXUmtPdzhMZTFhTXJjU01RTUdSV1ByN3FFYWUyZTVVTTAwdkUzM1FO?=
 =?utf-8?B?aDRoc3B5dlBsQVdpSzQvSVpQaS9zL0pEbnNqamNFcG1JZHlEa2hSR2szVkJ1?=
 =?utf-8?B?MUVWN3pIcmZmY1FoeWQ5bDdjaGVlalAyT2ZxOU5QU3VsVG0zZUdKUXJhY0xH?=
 =?utf-8?B?aVpTbHNyejhSd3crOWF5bDg0U0tGRzZrZFVCT1pJUHRuanU2UVFaY3lVaEhj?=
 =?utf-8?B?SW00cjRqTDhRRm85cXpESTE2UTg2Z2NhMGVvYmxqdDk0MS9XWU5RWktWNUpX?=
 =?utf-8?B?eC9nVFFrTDRUNDRtOE01c0V1b3ZFUERVZFl4MFU0dFFVc1JiQWJBZnU0ZUlL?=
 =?utf-8?B?bXFJUjkvT3FIbUViQkNPUUc3bjgvdm1GUnc3d2dxQmlDTEtUMXJUOEd1dXRF?=
 =?utf-8?B?Vk1vOHJNQ3hDNTZOUjFPaGJMNFhpY2dnZk5jU1Z1RzFDMnUxVjB4dk5wWmF3?=
 =?utf-8?B?Vnh3eXdXL0E5b3A0cGdnK1NnMS9rZm5Uc01Ua2tXR1FuQUowQjdmc0FINVdr?=
 =?utf-8?B?N3JwUVRhSWRTZnVIZGpqeXVBa0xYL0RTMnErd0RCeVJmRW54cDFST2hlVitY?=
 =?utf-8?B?YVk1dXhCaTUvbVllM01sOUtIcWVpNnFWWEdkUHNzRnFSTHhzSXVNSW1xNE9z?=
 =?utf-8?B?ZmRDaVd0cVJXVjhGM0R4NG5jNVBDeXpDT0wwdU9YRS83Q2NoYU5RUUxOdE5t?=
 =?utf-8?B?cCtiT2I0cEJHNzQ0TjlFbE01QmFXTnY2Wkd3MmkxV0RVUGdJUU8vb2dSMWZK?=
 =?utf-8?B?cngvZW5PUU1Db2tXRjluek5aNWl1WGdMR09zOWhJcWU3UGFnK2t3M3l5RHlh?=
 =?utf-8?B?NXZ2eEYvUDFXdmFEbHhSSURNU0hOanNCeHl6STB0Z1p4a0FPSFZKR3E4cG5V?=
 =?utf-8?B?T01iMkdqRE1jaEVTNXo5ckNqYnoya1RMMkhGNHJacHpGWDcvcVdEeEpaZHNX?=
 =?utf-8?B?d2dwNmlkRXpKa3NBVkZTU2hqK09Zc2M3aStnMHJBUUJodUUraVJSRmVRdVRG?=
 =?utf-8?B?UTdPNXBTOUtlNlh6Q1ROYlVVY0Fwb3krQXRjYmJmd0hQOU5mUDh0WDVFT3Jo?=
 =?utf-8?B?RUtrUjVGM05Dd0lqa0UyTHVLNkhaa2owdXBsQnA5OWczVkYyTUN0b0lPaEE0?=
 =?utf-8?B?dkpvOFlsZG5jV2FTNUVLMDFITTR3Q043NGhtTG1GZzZmMUcwYTBKVGgwcS9p?=
 =?utf-8?B?SlpoaWtvL1RGM0xES0ZZalR2SzBzUFduam1kOU1kTVBJTk5JN1N4ZkEySDJj?=
 =?utf-8?B?V0ZjaDVrMnFxL2RDbFNPRjdlYkV2TGMzZFRKaEIvVnZHS01zUlZOY3B4eVMx?=
 =?utf-8?B?azNFQ1Q2WUdUVnNBS1lYYnY2dmp2amRWS05lalhjcmV5SFpaQzFBbG9RU05F?=
 =?utf-8?B?ci9YMW1hbUNqV0dhZFYxWDA2Sm5jZnZUNjlaY0JnNWhuY2hZUndJdmJRVkhF?=
 =?utf-8?B?bjJPalV3NllreDd6U09KSFhvT216L1hpaHZyUGJLY242cFJ6bFFwOE5zVHZq?=
 =?utf-8?B?R2RiNFdmaTRCUXVGL1J0WWJEdFVwSjY0SUIrYm1yek5HaDJRbW5vMEJ6dFBV?=
 =?utf-8?B?cTNjWkMxYzJKRmUzcTdjMmsxc3RCeGhEQmlYRFlkck5XY0pBREk4YTJtYjlw?=
 =?utf-8?B?SWszRnhzY1dGdktzdjE3MjloWTM0eGh5dGVSbW5UTEh0UEF4L1VIN3luR09J?=
 =?utf-8?B?VUJldWt2K3M2L0p2UEl4R3hGQlpGbVh3bTlzcG1HWklEeW43NUxKVjVmMjFE?=
 =?utf-8?B?WUpPak1ySlcvM2RlYWdVMjFYcFpDSXJYQTFjS0pyRlprUklNaWZobWZXMmZD?=
 =?utf-8?B?VTdQMzB0S0tCVUgwRHBpeFNwb0thQUhzTkxXZGZvMkV6OWMvWE84Z1Exa3NS?=
 =?utf-8?Q?lp6M6+NCKM7NIWmK7AnBlF20P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5792b1b9-20c8-4ef9-d935-08dcd27afe39
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:01:27.4014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X34BnHzpO3uwnRe2AiVTDMP5YICDGJAdJvhS9stP/vQGz6Mu4GZq7Ztkyt1zjevFymalAHaQdkUZqQ1WxA8xFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805

The following changes since commit 6b612d1bac67b0f483fde7779a45f6310274d4eb:

   cpufreq: ti-cpufreq: Use socinfo to get revision in AM62 family 
(2024-09-04 20:43:59 +0530)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.12-2024-09-11
 
 
 
                                     for you to fetch changes up to 
93497752dfed196b41d2804503e80b9a04318adb:

   cpufreq/amd-pstate-ut: Fix an "Uninitialized variables" issue 
(2024-09-11 10:53:03 -0500)

----------------------------------------------------------------
second round of amd-pstate changes for 6.12 (second try):

* Move the calculation of the AMD boost numerator outside of
   amd-pstate, correcting acpi-cpufreq on systems with preferred cores
* Harden preferred core detection to avoid potential false positives
* Add extra unit test coverage for mode state machine
 
 
 
 
----------------------------------------------------------------
Mario Limonciello (13):
       x86/amd: Move amd_get_highest_perf() from amd.c to cppc.c
       ACPI: CPPC: Adjust return code for inline functions in 
!CONFIG_ACPI_CPPC_LIB
       x86/amd: Rename amd_get_highest_perf() to 
amd_get_boost_ratio_numerator()
       ACPI: CPPC: Drop check for non zero perf ratio
       ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn
       x86/amd: Move amd_get_highest_perf() out of amd-pstate
       x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()
       cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into 
amd_get_boost_ratio_numerator()
       cpufreq: amd-pstate: Optimize amd_pstate_update_limits()
       cpufreq: amd-pstate: Add documentation for `amd_pstate_hw_prefcore`
       amd-pstate: Add missing documentation for 
`amd_pstate_prefcore_ranking`
       cpufreq/amd-pstate: Export symbols for changing modes
       cpufreq/amd-pstate-ut: Add test case for mode switches

Qianqiang Liu (1):
       cpufreq/amd-pstate-ut: Fix an "Uninitialized variables" issue

  Documentation/admin-guide/pm/amd-pstate.rst |  15 ++++++++++++++-
  arch/x86/include/asm/processor.h            |   3 ---
  arch/x86/kernel/acpi/cppc.c                 | 172 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
  arch/x86/kernel/cpu/amd.c                   |  16 ----------------
  drivers/cpufreq/acpi-cpufreq.c              |  12 +++++++++---
  drivers/cpufreq/amd-pstate-ut.c             |  41 
++++++++++++++++++++++++++++++++++++++++-
  drivers/cpufreq/amd-pstate.c                | 151 
+++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------------------------------------------------
  drivers/cpufreq/amd-pstate.h                |  14 ++++++++++++++
  include/acpi/cppc_acpi.h                    |  41 
++++++++++++++++++++++++++++-------------
  9 files changed, 305 insertions(+), 160 deletions(-)

