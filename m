Return-Path: <linux-pm+bounces-17590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3FB9CD5D7
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 04:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F491F22119
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 03:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4B315B153;
	Fri, 15 Nov 2024 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="evBQvQTA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F43FBB3;
	Fri, 15 Nov 2024 03:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731640950; cv=fail; b=tb4zvIiTn/RTna9t6b8SywZ3E5ye+O0ZKzezeWhM3lK0XTQFl9RApd2dqDT6zhLnl37kFQ74W1Sh2n0YYXGUs4gauN9bGr0I019fjgp3NNMT3IoobfEJu7iZEy41Ermp/JNBBbxdQLkSvrN7Veh482FeHZM5262O17qsQRJjyb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731640950; c=relaxed/simple;
	bh=AsReNcYUhLiTut9W1soY2drd+IWEjCt4QBczE1JHcI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gvWczaaKpesSLk0Wx5bsDaQCoCeJJOAeEzDpBBHGmgEAeFhCGNEUG13rcZgDFbg/fpZ7pN6cgyk79vgafNA1utVN0lGP9cGDNb41bfy3AuE71sA2WN08W50168UuItIEfQXtlNY7Z7mciqpPbBzbi2u0SrtLwEUHj/FnnVy9K8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=evBQvQTA; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttmqlktD1tuTNK7M+KxjXLxEZG+dHt8LqTTSFUKwr92Ehk3RrTgmow1vxuxRtwKAQ6qIrpfaaeIzYDbocq10UPeuNkLVRTWQSbEXhM+7km7vKbiUSbgapwVnBIvkFckMmRdNvvL3SulvHuWp5ElUuuHCebkWg4SI5fLUtPDnanrv5644ngI4+mnQlSFkfUm8AmpBMmL17QV4/3WNIODXuwFq+4HAJygOvhgP/p+/sXXCsE0TuGDuugUY0lGYM6YgA56ACHWPxF/6KTpGm6zRZXEEM3X2IX3/s0MOfcG9pLpPz8FOcLlntnZLf507Ywz3eOIQOyGOwr/BrHAbE4hdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbYK39YB8Jegjrjd0YXbHHmnSM5X35QUPcic0yS1bDE=;
 b=vvWVZgcU/fKqcIm34Yc9f8GY1ywHcNDEGiy/K5T9mL4dYxkGongCgR3OMfFpehm88wPnyCYejTiGfoydpDXnrNLV6A16/FosVURxyEo9dkltY3rHpeD/LLmSQ0sS4v1vLNO8qOCQi/jnir+PgN5tbgJBQLuixl3KS0L9arjrKvDZK/d/isPgFnT5FbQnWWx5NK/x7lRzglZdrk6WRrglN3SrKmHlVRIW/8AdnjBdH1hTvvrgIV/3LV0dpG71QdzQYc2xkjoYedOvbWvJ/wys3MFXbNBKZR7ZBIqn7MJc3qkJU4xtcUrPydXAx7VIhYWbi16TrryXUidDCrIkpKvmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbYK39YB8Jegjrjd0YXbHHmnSM5X35QUPcic0yS1bDE=;
 b=evBQvQTAk/TqSw8ebM8X5cPTAOXsvu5WRTVFW5NKuA4ntv7PEKvXOTw/eqEMwLR15WZCAHlSrdMbyd2//5D6ndHLEsu5DlX6rpcw4xmKx+j2CkflDr/0DJN6xZ+dqmQ/srNceXLyw7lLtVqtjStsMpnH7Skv+GwI+uQv13/s39I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 03:22:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 03:22:25 +0000
Message-ID: <bcda4bbb-ef20-448f-a2ad-fbe9f3bbbd20@amd.com>
Date: Thu, 14 Nov 2024 21:22:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuidle: Do not return from cpuidle_play_dead() on
 callback failures
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <4992010.31r3eYUQgx@rjwysocki.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4992010.31r3eYUQgx@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0067.namprd16.prod.outlook.com
 (2603:10b6:805:ca::44) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 9529a189-1f8a-462f-870b-08dd0524ba24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2t2R2huMGFCSi9uVVlmbTZ5eFJBSElnZkhCWmJONkhxM3VZcEQrUlV1cGxy?=
 =?utf-8?B?VmJ4ZXBzTEdjbzhPWUhyYnA0QWtKa3dBV3dCS0lsTlBzZUNPYWZPelVpTlBC?=
 =?utf-8?B?UnRVQVl6UGkzbHNCclBHY051M0VmWVcxbzJGYkFYRlpYNE95RHc5emRPOEUv?=
 =?utf-8?B?YWVRUHB4T2NOaVdSd1JGeFZPdHAyNjkvSXBzbzdvTFNwZk1ZbnVQeUZ6RVd3?=
 =?utf-8?B?eXdDQ05hUnF2RzVzb20vTnhaMWdIS2FBd21GcXEva1dyTTNxZUpXOVdaS0xO?=
 =?utf-8?B?RnMwN1dBTUhaUHNTSVV0cHBzSmZQK2VzYkJCaFM4S0ljQmE5Y1dZV0lPamM5?=
 =?utf-8?B?NDl5YXAvWWZWU1BSekxRZ3R5cDk2RGxoUTNrbC9hTlgreWRBcDdNbVR4SlJ1?=
 =?utf-8?B?emlFMFc0eGpaNG8rako1MkJTUWpXRjVsWWRZVU1hcFhpL2FTTFgvRFMrWk1u?=
 =?utf-8?B?bEhYZzVZRnZDUzdTcG8xdlZPOCtTVjZqWEN0TXFpYzNRNXY3azJVc25WVm9m?=
 =?utf-8?B?MnNxQVdObDRaeGpsOHp4WWh2MVZuUTNXb3pJaVdNN0wzMjlkZHBrTXJvNXBx?=
 =?utf-8?B?S1lES21JcVFvL0dmdUJQZnYvVysvemFObHZnSlBmdkNFODRoYk9JelIwRnhD?=
 =?utf-8?B?YmdCQmpZZ0pBWXdsTktSc1JabjkydWV3bE1nbUFoRmF2Q1dUcXV3S2U5b0VH?=
 =?utf-8?B?citmT1MyM3YyalYrVTFEbzMzMVlYZU5QY1VmM21NL211SXNNaVlMaFZnQndu?=
 =?utf-8?B?Y05tZHEwTkh2bmtpTW9iTWduUDZSZG1VRmFiWjIvRFJsQUd3TEdKWks1RHY0?=
 =?utf-8?B?dGdZZkRhSVdPdjBvcWxGeWV5NStIR1FNMTJYaXBjZ0NxR2h4Q2RyMDdSc0ZP?=
 =?utf-8?B?RjNNL2lndkNTdHkwR1UzekhjTDd1OE1YNkFXSzZNZGEva3RYcWpISUtQeUhr?=
 =?utf-8?B?eVR4TFlLek5KSDBlcC9ZTjZTbkgzVk42VWxpeHJ1Y1hNR3lUVDRuVmxSSmtt?=
 =?utf-8?B?NFlJdzMzNlZTOE16OE11VXhXNUZFcUxqOHBVVU1OUFFsdDJmaitmWmdaanln?=
 =?utf-8?B?THM4eHByZVZSUFRHY1A4dlVPeUh3dGlTenhER0xJOC8xUVlCeVk1Z0tMWkJp?=
 =?utf-8?B?TGxqUVdKU0U2eW9iZlZvVXlmOVBYeGtyS3ZhVjlsbzZqKzBDN2VHa0pObENM?=
 =?utf-8?B?Y1l1alpNbGwwYmFyamNGaTdpQUtJb1NIVmZqQ04xY3ZaVzhFbkE0TTl0cXBR?=
 =?utf-8?B?WnYyVklyRlNZY1o5aU01U3l1b3o3dVFXb1g5TmRrV0JHYUdDbWl0aStXa1E5?=
 =?utf-8?B?dEVTQkF0WGFKa1Y2RzVvckNlVlNOaEkvcDREb0xYZWpVSWxzT1k2amh4VElO?=
 =?utf-8?B?MGZYRVpsNzQ5dUl0bGk4WFU3c1FzTGlpb2JhRmQ5SSt3Y3BhZVcvZFNsUGc2?=
 =?utf-8?B?WnZId0R1K0pyZlhMaVRBVW1IdG5Qdy9Qc3pvdTE4T0RnTExSUkJ3aWdoeTNY?=
 =?utf-8?B?UnAvSlBXZzhlZGV4TTBBT1dQaGZyditaZVlOcDJGTlFyMzhRT1pVSGoyOWNr?=
 =?utf-8?B?Q2RSN0llbGFid2lpRnVyeXRKUnNtSG5zN0FOYjVvd1dqb1Rya2Erek4ybWdt?=
 =?utf-8?B?Y29xazRRUWdLZFNlZmxsYzBycUo1RWhsR2RLcFFLSmVNMjJGSFZKRkR3NHdD?=
 =?utf-8?Q?2zy+p0Cx+Zm7i4xDRUMo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXVSUVM0aWJ5S1lVdmhJZ2tjWEhEVzlQUmFxMytvMndtd1ovenNPQ0FOc2pl?=
 =?utf-8?B?a1BKbno0a0srZlA0ZTNjdWJtSGhjUExRTEVUVGNVQ0h0VENvWURSb0svalJ1?=
 =?utf-8?B?SmNMc1FLcU1XQUpCdTZLWVd5QlY3bFpWRnYzblA0YS8zdWRzc0dYN2JFYzBm?=
 =?utf-8?B?YnJEbjlYYXgraGRIWlVvTVo5VE5ManJPRm9QcWVzWDJxWnV4SDdyTjJJdEVJ?=
 =?utf-8?B?TkcvOXF3Wms0amdCOXAvdXNiM1JSRk85NDRiejdCbE5SdkVQSXpGQTM2cDYw?=
 =?utf-8?B?SWluZmpRWlVPbzdyNmRab2tMZzRNc0EwSi8zR1JCTjZxSE1lL2x3a1RpRndW?=
 =?utf-8?B?SXFFSlg4V1I4TGVNS2xRK3cvak5HWndXTDg1VzhlUTVWVVYvd2VvMFVTbGJK?=
 =?utf-8?B?MlhwMnZQNng5ZWNGOUZaQmFsbEpjc0NZRjl1bG9wSkR3MlpTNUp4RjJ3YVc2?=
 =?utf-8?B?Z2dhNXg2MllLeDMveVdTQ1B2WFpIL044a1YrSWlMZlZPUUNja0hoSmE1N0Nu?=
 =?utf-8?B?emxrUGxCbi9OY1lDWVFMZE1KQjNhbzRocVplY3liczdBaE9nWldmUDBjelRs?=
 =?utf-8?B?ZW45c2h0Qkp6Zy9LaVozWmMzZndQbUdrZDUyNUZlamhvZzhNRmx2bDZad012?=
 =?utf-8?B?bzk4U0NGT1BXbGZBdnJnZzlHaGpiZmVNbzZnRUxoRC9waXhqVW5YcEd6WWJa?=
 =?utf-8?B?K25vY2ZNc0E4amFjUituZGRjZTcydldhRHRRc0VIbitZS3hNTFlraUtkMWlR?=
 =?utf-8?B?aE1lK1RYN2cvM1RGeWs1S3V2cDhjMTcwZXViQkpTZ3pNanB2anpYcWFIQWFD?=
 =?utf-8?B?UlJlbFd4UDAyMFk5V0t3aXdtNmVpNEc3cXBhSWhkZVVWU1AySlYrbnl2aXM1?=
 =?utf-8?B?Y1BWS1lkSmltRnF0N2Ixa296VnB3bVBXY0dRaENGT3RWWVlxdFV1V1ZXNU1u?=
 =?utf-8?B?OGhJNXFWZWY0L01taWhaQk53T2drck04Q05oM3hLaXdXYi8vZWJiczVlNDVp?=
 =?utf-8?B?N3g2QUlVR3haRFBENUp6VStuZ2VmUGZrdUgyTlpQWWk4V0Nsem5EK290aWJC?=
 =?utf-8?B?SGVXVitxK2w3RHNWUEdDYnUxaktCUFpOU2JXWFZrNXBPUlVOQnROaEZZbWpY?=
 =?utf-8?B?aC94aGIvUWp6czhnbEptZFBFdDlvN0t6ZUNQWCtkYWFzQVpFR1BOTTZOY0ZT?=
 =?utf-8?B?MTBYYllHOUxLMU0vckYzdzRJNnZmeVdnNjJBeWRDZ2ZOYmpIUEJ2bjJyY2Z6?=
 =?utf-8?B?Vk9CTG1Jbkw5clhjemVSTDZJblJsYUVxWVZZZnRieGRtN2Z0YUhyQittT1Rp?=
 =?utf-8?B?UDcxZlROVlh5MHlidnFYRXBmeExzenRFY2ozZW1EM0hndVJLd0h0eHlQdTg1?=
 =?utf-8?B?Z1lJYS9zYStvSCs5WC93d21rc0xSV1RJUml2YmdaQ0JWSDlIK01WQ05rc1Q1?=
 =?utf-8?B?REpyamlJU3lwdkt3Q0l3U0V4L3U0Uk8vMHA3cFhtc2l4bTk2OXVMc1RRTld4?=
 =?utf-8?B?U2Nkek5IV1krYS9PQkpwNmFyK244bS9zRkx5MnVNVDdoUGhMU0ZyY1dTanUr?=
 =?utf-8?B?R0lPMkUyeVJ0d1NLMVJKSjlxSElZYWlrUCsrazM2aGhpZUxJTmZCSEJYKzQ3?=
 =?utf-8?B?eXlmRGpZSU54Mml6NWlOOVhCK2ZMcXlINGY1eFBtNkVwd2tpTnlqMVZpNVpk?=
 =?utf-8?B?MC9maEdSb3BWL1llc1Q0eFVubDFWUlRpNnNnM1FBaXFvZ2czMHJWdmR3bGlO?=
 =?utf-8?B?c0Jyb1RMTkVrS0FHSzUxc0FsR2czYTFiQ3JNOU1oVlVyN1BaU1JUQTlPR2tr?=
 =?utf-8?B?MG4zblBTRlBOKzBNNmd1bCtkbmR1SWtXeWFqdFZxR1VVTmdVb2c3bHBnSFlJ?=
 =?utf-8?B?YXA0N1UrQWpablkvQmVEL0RqNWFubHR0U25uS1hZUUxiNkJuYW1za0RVQmtI?=
 =?utf-8?B?dFFCbXBGbU1xRnNqSjNET3dpQlpFbHlhRGE3Yng5b2cwQ0ZLK2JzakJFYnIw?=
 =?utf-8?B?Q0M1RGh5cHdFM0JiYXJzbWJhZUtUUVI3aklybGt2UnJaVWMzbUlLa3VOUHJD?=
 =?utf-8?B?V0puMTY4TFhldE5IUE9ybGpRMG1xYTN2RHhsUjlWRXBTWWxITGJ4MVBadC9m?=
 =?utf-8?Q?92B3FGutc+IEvZ62O1bikkFp9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9529a189-1f8a-462f-870b-08dd0524ba24
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 03:22:25.8970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ur4VIkQKNphqGS1G30lvFomO/kpHx9ZBF9DsVfsHj1BmigyUDnJF8NDx07hrPlkJMuXcL448ATYfm8hLeXJLLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

On 11/14/2024 11:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the :enter_dead() idle state callback fails for a certain state,
> there may be still a shallower state for which it will work.
> 
> Because the only caller of cpuidle_play_dead(), native_play_dead(),
> falls back to hlt_play_dead() if it returns an error, it should
> better try all of the idle states for which :enter_dead() is present
> before failing, so change it accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com> # 6.12-rc7
> ---
>   drivers/cpuidle/cpuidle.c |    7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -70,9 +70,10 @@ int cpuidle_play_dead(void)
>   		return -ENODEV;
>   
>   	/* Find lowest-power state that supports long-term idle */
> -	for (i = drv->state_count - 1; i >= 0; i--)
> -		if (drv->states[i].enter_dead)
> -			return drv->states[i].enter_dead(dev, i);
> +	for (i = drv->state_count - 1; i >= 0; i--) {
> +		if (drv->states[i].enter_dead && !drv->states[i].enter_dead(dev, i))
> +			return 0;
> +	}
>   
>   	return -ENODEV;
>   }
> 
> 
> 


