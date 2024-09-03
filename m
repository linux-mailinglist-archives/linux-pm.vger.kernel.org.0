Return-Path: <linux-pm+bounces-13435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3013696A151
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 16:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548F71C23EA3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6CA187FF7;
	Tue,  3 Sep 2024 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MTsGGjIB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB336143748
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375280; cv=fail; b=ItesQETv2JjKMCzXYph31P/UnONAS2EwQqY6aouCsGoCstxrHEdq13me0uRjFfMgnGDY3l46UJVdldMrR6Kta1z5/UsmADHXpDb9UABc/NYfrcneR/Fx74WBw1rgY/rULwwC8uDWt2bKDR8PTdsET5lsEKN6A5r4RT+ZsWWlc18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375280; c=relaxed/simple;
	bh=SHnaul1RW+E3a3wSMs/q+PzWB/1a5A0C70dTm1tRocA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QBGktWn/epX81T0NYJv3Te/IYVFvI/hsZgmYErJIIPytO9zcDCxztTwsFjMAkO2h0lfpUkI2hpFwy0vJLwqhTw/+gpRfiXN/0BH33Q9Qu/seDONqEZXmixejHMx+BLRFJeqNdwa05kdRNR207h1VjqKNQmfc82u15vKwoDwTcL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MTsGGjIB; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ed+PtaQ95qZOetHH1o7hdLnMjXNYhrCcDtdM2kYfm5geV0LOQ4EMbZen2fVZCWUCZ9LQHeSwSacqrP84H8y4gj6qRK8EVfpXz8sSqc3JQRE8avedKss38vq3KIAZISVTKiiWpcRLzK2XwasaMvEn28YLzz6Po5/KQbtGxzUNUTlsPXxn3gMJquNL0r/lqMVjkj6DcX8MlhcyFCnrAk/fyRhesZ44m0YV5iaMVkLF5G7X/xS3XsLZVF9v2YpfcsAnRGvI3VX4eWXEQjksEv1gbjcu56xpHvC5AEaCEdtg+vjwP9OUWHEy8J6Y16VqugKucIpBALX8TMe9iEfYCxzWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xqk87Fc5W5v4MbpZE3ejII6ZtGL6vqCCBnLJu8k73Z8=;
 b=MCgET/GJUMfgzaH+hxmdj503CvgDMvDM2bAyYu0JuYnBGjLkTurRNVbobcK373/b7CGZ+qH9OI5RTWwYmJ2ICQ7JnZQR1JRieejACZs1XpW1k3Svgx4MeBSURoJKXMYy3U2K/EUTD7rVbjLJSbxsrmgvofZMpOwqFFLkT9YgtSt46AZVHwg7km6bKEfAOJVjXWata6/LkCMjYd+Cfk/vzclLOjAdzk/cSfk3TVMJCRlBsOxKg+TO3fUfKkwCGA7DtqJ0D3Bv7ima8uMh1x/Ji1n4iVXQeI1sGmiOvvZfH8POEA23n4dOHqFraZDbHPD7vWE3UqBnQoNaEtGJhWZU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xqk87Fc5W5v4MbpZE3ejII6ZtGL6vqCCBnLJu8k73Z8=;
 b=MTsGGjIB4itWj//EWZ9m6sdZ6j3S4V/tARt6n4s7YjIOC9eNy7Cd2A0NUhMTinFvtTT+Nv49iK3YvPu8iZ1DThwmlMg4F85Y1+5o8aa12WvXfL6bv7EmD0cB73S+UA9jsIvY2EXzMgHgPM2Jnd3iKGJysAxhNYEvdPogRHxWKIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 14:54:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 14:54:35 +0000
Message-ID: <cda08f96-586a-414c-9c93-bd010d6d2d40@amd.com>
Date: Tue, 3 Sep 2024 09:54:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: amd-pstate-epp: CPU freq never hits minimum level booted into
 OpenWrt but does under Arch
To: John <therealgraysky@proton.me>
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <rc3yUl_FpebZCJhCPscpyJ2UtuKGSwB7B4E4mr4OjdrJFIkftiWJvWrRBwXzMfqICV_NZWqMvyey5Iw3XqyhIhQ3k9beU2p_V8NARfUdQ-M=@proton.me>
 <CYYPR12MB86554E10C5F1A155B7F049F79C932@CYYPR12MB8655.namprd12.prod.outlook.com>
 <365cb75f-4d47-4e77-a202-ddb171f92004@amd.com>
 <cJ_RYyxqXiGtT99l77dXTRIbOQEW-i1nAwHunOhkVWKJwm6uzRhSocbqbr60eJjqZc34apTRIq2pK5uyINZvdROB3yNrHPAiVO8uJpI9gfg=@proton.me>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <cJ_RYyxqXiGtT99l77dXTRIbOQEW-i1nAwHunOhkVWKJwm6uzRhSocbqbr60eJjqZc34apTRIq2pK5uyINZvdROB3yNrHPAiVO8uJpI9gfg=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 433e1e0f-e75a-4cb9-d081-08dccc285352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUZ5MWlRQklSS0ZvVitMdkV0ZnNtemZmVVVtUC90Y0h6SEZvYWN0QStIb0lK?=
 =?utf-8?B?OWh2UUVKRnlJMTFZeUl3a044eHlhUlBhQnUrUFZtbTVLRlM3VU1LSlVSeGZs?=
 =?utf-8?B?U3YxS2tPMUNQWDU0MitWRW1HaGFRZnl0SFNrUUlhV0JLNU91d1BySmpmUnVG?=
 =?utf-8?B?TDRQUnRkUkk3STNDVEJRSEtzNXpMT2Y4UEdvZW01S3lTK3VabVUrS1VLeXNL?=
 =?utf-8?B?MzlHeE9ESHZZUmE1R2F1bnJpSEFObDF2eUtmNFRlZUY5WjhhbmtHa0NpRElU?=
 =?utf-8?B?aWZqanlHb05nQjZacUFHRktNbHNrSkE5YmRScXJhVDBhNk9RY2hjbnMvbFJx?=
 =?utf-8?B?QWFUMUNFRU9IM2MwcVpMSDllWjlITlIxSGhzTnlaVC9BM3BqeVlWZDV5MUV1?=
 =?utf-8?B?NjZndW5oYlJ4WWxld1VNQ05ldWNVWEhnVXdzYXJyd2pyWHVRdFBZV2xIWTh1?=
 =?utf-8?B?Sllvb2Q4TnBGVTBiZ3Z4azFBeGlKaXhHeGFHK0JIaFNhWUp0ZkNBaU11TnZO?=
 =?utf-8?B?bW0vRmh0b2w1S1lsQmpsRjNGcE45MjlXWm5WQUdaY1FCUDRoazVUQnhWdUhK?=
 =?utf-8?B?ejRuYVVmKzJuVlRWaHJPZGprVjJPbmNrdlBGNUY0b1Jtc2MySnRvTXZwd24z?=
 =?utf-8?B?MkgyR2lOYWxtL2p6WU9QTmYxMTN6Q1I2c0hEQzFvZzcvUFM1MXVKdHVaV2JU?=
 =?utf-8?B?R3JEVEZUSk45c0lsTHAvbHZZalVUa1Iwb3h6cHNIZXRWQTdva25xYVpXSkY1?=
 =?utf-8?B?THBnQ0cyajAwRlhubDR6VlVvUkNzTnRQU2syaFIyVVFXZnVvTzBCT1JBeitR?=
 =?utf-8?B?RE1ITG55dm5YQ3d0eVY0NXlCQXR1MFcvd2JSclRoVDJHTmNlcUVSWE5SQmRo?=
 =?utf-8?B?N0dJeUlDNVU5RTNvOERCUnJBc3R1ZjAzbWVZZi9WOTJRM2JJTS85ZlBwTEJ0?=
 =?utf-8?B?NEwvZzc2M1gwVEtQQnV1eERkdlBoQ1NpYWphRitnN3hUdzdwZXhDUU5xeEZ5?=
 =?utf-8?B?a28yQVNFMStRaVZsU2ZpTzR5aXEwdDFodEpoTWR4a2hWZ0xLN2VSNXZKdllv?=
 =?utf-8?B?NlpHMFRPQ29VY2RkQVhVam5ITmJoTHduaGl3cHVFZEtvYTEwZ0JxVkJMR0RF?=
 =?utf-8?B?ZGRNMHZZc05iRk5QdUpaTmtoSDJpVWZlM1FJKzJEanljZklFTWJCR1BsNHlh?=
 =?utf-8?B?SXZobXRTR1J5d1YxTjRuV2k3OEpIWTZVcFFQUnFxREFIYWhVZ0xnU2V6UWxs?=
 =?utf-8?B?ZWQ3a3F1N28xenFQZ2RoRWRIcXlMY2owZ1NQTTBPRm8rV1YvazArM09WSytq?=
 =?utf-8?B?NGRjSjNqZW1LVDREc25SREd0U2JzZ3N1ekxEdHZkTGQxMlFKRzE5NHE1eWgy?=
 =?utf-8?B?eTdNR2VSTzkzallIQWxyZytCZG4vNHVzT2lYb3pUZ1Y2czJkYVl4amMweVNF?=
 =?utf-8?B?RXlmUmJSVlpmK2lYc1VuUVhZOUF6aUlnTm9LbHhBMUlKRWNEYmZxLzRwaFlw?=
 =?utf-8?B?TCs1ZFB0OC9YVGlVVG1uNHZaZ3NvdzFSMm5nZkxIY2VRZ2RYekM4dGxDUkRs?=
 =?utf-8?B?ZFpuZXJsdTBlc3JvdzFDOTB6MjZMWDNmR2xVRm01RUErN0tQL1FVUVd0Tlhw?=
 =?utf-8?B?d1VTVTB1TkVyaGtIL1dDb0pBVFNlVmxHdUtBdjRqWkJWYmUyRjFoa2VDNXdV?=
 =?utf-8?B?N1JCeENRNG40K3Y3UktWSmlPZjVYdE1xMk9JckM0elVDVm9hN1prQTljNWlH?=
 =?utf-8?Q?jpfu7+HOpDZ5sbPNoE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjQwZ01oTThSRlVzd0FnNHFYRGFOcnFQVG1uQkttbVJIUzk3QklKbC8rcnZi?=
 =?utf-8?B?VGkzZzFWTlBHZ1cxc2s4a2RVYkQyc1Vwa2JvcVZxVnRFeUVwOUFrekNpK1Zm?=
 =?utf-8?B?UWtKTnVqK1c5Q3VLQmFDM2NwY0hPRUtLNU1iWnI1MDJ1VWhjY2JvWU5pQy9M?=
 =?utf-8?B?RWRFclJUUnpsYTBSdzNaU3l3WEY4dkRmSkxvWkpTYkphaUsyOGZGTFB2SlhZ?=
 =?utf-8?B?MU1zUlpwZ1dPbmZzYUJVdncvQ0FxWE91dHVPUzVsQnBkSDMwNXMzNmZlSlBy?=
 =?utf-8?B?TXltLzNSd3BLbjlnZEs2Zk15d3drbFRDeFlYRWpmU3UvWmRlUEc2K0ZyNElj?=
 =?utf-8?B?U2ZUMHh0cFlGQ3NXaGNVNlE5Umh2VjM4aFEySytheHNYMHFWbThmaGZMcGxW?=
 =?utf-8?B?T2QySDdFOVlRVFk4MHpZVEpaV2RHUzBnVi9LYU04QXEwMFJMSDQ4TWpyaFFl?=
 =?utf-8?B?SDIvM3kvbmZZc0FqcHYxWWUwQzhvOEpJaGNTSEtCcUZ5b0xPV09qT0JvVXRE?=
 =?utf-8?B?WFZuVzdjY08zU3B0OHVsanMveXVvN0lKYVZQaFZXazJ4NEFIcVVlN2VRODk5?=
 =?utf-8?B?T3dIV0xFUjJteGJyK0dHUm82MXNsMkVmTkN0L21OK2FxQlhmU0w3dEpkdW1Q?=
 =?utf-8?B?V0RMRGtwcFI5V0U3SFVwTTNCWTJ5eFU0dXJsMFNDRDdza0lkbFVBbnA4aUlO?=
 =?utf-8?B?cmhNNGRSRUVBbllSTy9TTjVrVGZtWThNNWtDbjZVcWphK1FqUWZCcFViNktE?=
 =?utf-8?B?Vy9BNS9XTEhCUVh6OGlESE5HelVCUVNhQXhhZkNTblVkNVFnMytpRElEUHRO?=
 =?utf-8?B?a1U0MGx2VkV6SEthQnI3U3dzZzQrS3gvQzk5SXlLUWxBTmxpSmcrVWdiVitP?=
 =?utf-8?B?ZlV4ZEkrQm0rS1R2Mjg0d0hJU1BtVzFhVjBmV1lhSTFLU1V3eGNyUGR2c1JO?=
 =?utf-8?B?dzUxZVp5Yi9CQTVhVHZYZnFhWlJmQkZuT2JzRzV4VGU3dUhBREhlaFpqVnZx?=
 =?utf-8?B?UStEK3A2LzBSdStPVzk1QklQTno2bmJqanlxTTJHMC9YMWd2YjZsNkpaN1Z4?=
 =?utf-8?B?V1kwclRKT2RVQlpmWDd4cU1xOE5USDcrMUl0SXZSWXJWRGZrWEd2dC8yVGF2?=
 =?utf-8?B?V204MUVLTFh1R25tbkNhODJlamtENHZWVVVuTFVCbzY5VEpieXdQVkd5K3p0?=
 =?utf-8?B?amlOUWozUy9nM25VRENBUDA5YVh2aVFTSmxXRTUyTXAxd0gveGZjOUI1NU5s?=
 =?utf-8?B?YWpCbW1IRzJVZzVpMFNRQXRzUHVLbjdVQ3d2bkF6WjVhRUtyTXpQUXhWUG1r?=
 =?utf-8?B?M0VmclNwRWlUcHJRVzdRL2FqV1B0ZFNMbGcveCtwSUd1YkUwcmlUbHNJRWs1?=
 =?utf-8?B?Rk1HMFhiMWpIK2RJNjRTR01LcGM3cjBrU3BlWVlvN04xY3R3ZUVnUUhlS1lW?=
 =?utf-8?B?T29MN2JKUUtpUDdVblZYem8xWWYvbzhiZmhBbHZsclhtT1VOSjB3aGxtM3V6?=
 =?utf-8?B?aERRU1AwWkZCT2xZTThURGRGZFlmVyt5YXNrRUpnNVpMeWl2N0FtQ01tNHox?=
 =?utf-8?B?azllaXdiSGg4ekxrelkvYmUrN3F4d0plQ3I2ano5MWFaU0pFVng3TlBna09Z?=
 =?utf-8?B?a1NaaE5zclZuaDBzZ2VGZ0FGTlIwNXBPKzVVSm85czh6SkhaaEs3dzc2bXpO?=
 =?utf-8?B?bGtLdURDL2Qya2NKSmhWQmJoNHJycmdPU2NxbE5seEp0WHJHNFZRYVdRMVZB?=
 =?utf-8?B?SWNpY1JVY3JZSERGOGhJTTZlQVp5QVZDeUNRUkEwMTkzQUFWWjhpZ0t2T08w?=
 =?utf-8?B?YUlBOUxmV1h6MzFIUHBDbzl2eWhVNW5OT0JtZ2dvN1ppd0ozZWt2eC9ndnZM?=
 =?utf-8?B?UFZkeEdCUXNONGEvOUhxMzFkLzlpTkFvVEEyL0RhME45Y0o2MDAyRWNtUFBT?=
 =?utf-8?B?NzRpMVFjb3lBaVQyM2FWVEJwenRXYitTQlVHM1B2NGxVMDBjdDUzbHdCSUNR?=
 =?utf-8?B?QzlZM2NkaHIvL1QyS0l3U21TbjQxTi9ZaVFGWEFxcHllcW1HTmR1YVBIemg2?=
 =?utf-8?B?QkZTQzgyWVhZSDlHKzlYemZhbklnaGR2SG9vbks5a1FoTzFWV2lxMXVYT1Zj?=
 =?utf-8?Q?Q6m5AViXT8Rd7Wj724LjVHSTU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433e1e0f-e75a-4cb9-d081-08dccc285352
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 14:54:34.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BabKAeEaW8JlQXGnupvWdXZJrOX56DR+xjdojL3ShaOEnzUXyViDlnckRJdrW55gtlync+PKIgW3Yqa8CuocaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247

On 9/3/2024 09:52, John wrote:
> Thank you all for the replies and the willingness to help.  I believe that the issue is that OpenWrt's kernel is not compiled to be tickless.  Please see this PR I sent which changes that[1].  When I build OpenWrt with that PR applied, I am able to see the 400 MHz idle just fine.
> 
> Since you asked, please find the Arch Linux kernel config[2] and the OpenWrt config after applying my PR[3].  If you have any suggestions to modify the OpenWrt config, I am glad to hear them!
> 
> 1. https://github.com/openwrt/openwrt/pull/16317
> 2. https://gitlab.archlinux.org/archlinux/packaging/packages/linux-lts/-/blob/247bbd4865ff5f8d6afa820383c3d025f443ff78/config
> 3. https://gist.github.com/graysky2/286a298c1619e78778b8f9e780b18088
> 
> I unsubscribed to the ML so please cc me on your replies.

Great, glad you've gotten to the bottom of things and thanks for sharing 
the update.

> 
> On Tuesday, September 3rd, 2024 at 9:32 AM, Mario Limonciello <mario.limonciello@amd.com> wrote:
> 
>> Hi John,
>>
>> My first thought is that you might not be enabling amdgpu in OpenWRT.
>> If you don't enable amdgpu on an APU then some IPs in the SoC will
>> remain initialized to the firmware defaults. So I would start with
>> checking this.
>>
>> Something else you could do to confirm it's not a userspace cause is
>> compile your arch kernel using your OpenWRT kernel config and confirm it
>> replicates or not.
>>
>> If it's not amdgpu and you can't figure it out I agree with Perry's
>> suggestion to open a bug report for us to characterize this. Please
>> attach kernel configs from both so we can do a scripts/diffconfig to
>> understand.
>>
>> Thanks!
>>
>> On 9/2/2024 21:28, Yuan, Perry wrote:
>>
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> Hi John,
>>>
>>> I would like to suggest that you submit a BZ ticket to resolve the issue.
>>> Loop Mario and Gautham for help.
>>>
>>> Best Regards.
>>>
>>> Perry.
>>>
>>>> -----Original Message-----
>>>> From: John therealgraysky@proton.me
>>>> Sent: Tuesday, September 3, 2024 3:21 AM
>>>> To: linux-pm@vger.kernel.org
>>>> Subject: amd-pstate-epp: CPU freq never hits minimum level booted into
>>>> OpenWrt but does under Arch
>>>>
>>>> I have a mini PC based on an AMD Ryzen 7 5800U APU dual booting Arch
>>>> Linux and OpenWrt (snapshot). When booted into Arch, the cores idle at the
>>>> minimum frequency of 400 MHz with amd-pstate-epp/active. When I boot
>>>> into OpenWrt with amd-pstate-epp/active however, the lowest frequency the
>>>> cores will drop down to is 1,383 MHz.
>>>>
>>>> As a test, while booted into OpenWrt, I stopped every running daemon and
>>>> stopped all network interfaces. Checking CPU% in htop showed more or less
>>>> nothing using the CPU that might be keeping it from reaching 400 MHz.
>>>>
>>>> The kernel version for both distros are in parity (currently 6.6.48), but do differ
>>>> in their respective configs. I am wondering if kernel config options might be to
>>>> causing this or if there is something else that can be checked.
>>>>
>>>> # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
>>>> powersave
>>>> # cat /sys/devices/system/cpu/amd_pstate/status
>>>> active
>>>> # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver
>>>> amd-pstate-epp


