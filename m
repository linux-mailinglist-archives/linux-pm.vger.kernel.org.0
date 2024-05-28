Return-Path: <linux-pm+bounces-8270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BAE8D22C8
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 19:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37341C20DAF
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161E43AC16;
	Tue, 28 May 2024 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VmvuU6RS"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC43481A3;
	Tue, 28 May 2024 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918578; cv=fail; b=H6MZSNZgHf5Q9XY/WNSNLU2WIlgRlRkxALjt+ETDXGM6l760kZ9O7VN1Td1Kh3zfsw4kFGv4unVMimJnt0PEGj4SIkrKcVd2+DmvASAsaAR6T3+wvv5bYMmVBGM42C7TTsH/zMxVqd9FaiHdfYzCrbtqJ80QG19V/q5U1gMOmv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918578; c=relaxed/simple;
	bh=oCvcLRww2kBVgPdoF6lg+LcTM8p99JLpRSQbydjPcJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H7baNOLzd6M+Q5Iv3ubAxNhuNOgSjWj5WkQ8ewZhmYt5bhv63XOOI5OyIYgmwuAf3P7nK4yXQtRZWVLJGW8teiWPea9OICZJKPAAZdKMrkE+2V1gN6pn27n7FqcTuV6uBLU98dVVNGQv9Jl4jWGniFv0lOudjYr9yzuW128Q1Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VmvuU6RS; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7fLEwtF5CucUbG7vwdL9oGhBZTKFNWtE5MzjCYjD9zHJD9Tj0h//MoLZokOoK/GrREkX219c27PyQXqTW0VIuHSLsdmsCflocv05rSs/eYoTaOpBVvTduJ5QW8guZPNEw7jYTS0dWNwAuIKK0J80KnOcJaDyJzJJsnqBcnN4goXxA2wUjBfvfdJuspaniJPoyju0ATfDHZULuhsGjMly8TV0D/LE8VoaLkiqvZan5v3g0PWtxlMPhvS6RuQAJVMjiT5pjr0hbf8t1moWGa401Lqz7zpkljZOorDwVmkJiIuaa5+f3HVTTadVw0FHognreZXVz/CRGQq+cf7vnS4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYs0NomLsOndYtULi7eOrX0ZP8N5O3K59GOQxj72KO4=;
 b=jkcE1IBB9lGPJm86r1xPMxaTrWPrcIieSjCss1mN+B4IZuoh6Vv8o9xyLW/4M/XOdF6RR418t56ELa/61HGMtDvIhZVZWNwqCFHeh0ZjCWCGP/NzAILz/uIzLSrd1qqhnfWzYF/LMm3qZHUmF9Ltyo2t2G97siRBR0hn9ONF1HjHbYNpp3WZ7SQGsecGJyQYcIBt0pvyRDNzti3HhWxDizUg5iEL/XD1BVy8UUMrcqlnVw3gNBa0qr+1HfYnVJwNdGwi8Ndgi1QyP5zNW7v6k96qmejLyiBl0INkfsBizFfCTOfZvtyBo4Ddjjr15boEw0/if9kCC9ym+57J9dRrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYs0NomLsOndYtULi7eOrX0ZP8N5O3K59GOQxj72KO4=;
 b=VmvuU6RSRxrMzM3J7EYz/iv5wq3m8c73C/pAh1FO8gqUVVLE7Wobl0bdtq/fpydFN+2TkNf4iIvLYpWkZGhUI7RC5j1pstF7j2SByUWT5S4COKs5TBdGB3lE+dUkm6L0Nixszj1Rhcp9VCPhus3E4HdkPSJJBF0lDM+XdIbdZxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 17:49:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 17:49:31 +0000
Message-ID: <0edd0485-274a-4b3f-8ecb-60708963db8a@amd.com>
Date: Tue, 28 May 2024 12:49:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate: remove global header file
To: Arnd Bergmann <arnd@kernel.org>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Perry Yuan <perry.yuan@amd.com>,
 Wyes Karny <wyes.karny@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Meng Li <li.meng@amd.com>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240528121124.3588248-1-arnd@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240528121124.3588248-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:805:f2::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd7bca3-b804-4a14-c476-08dc7f3e8708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFNUR0RVaUNKZ3RSN3dFU3VYdnlka1M1Nm9kQzBENnRGQ2FHRjh3K3pRTlor?=
 =?utf-8?B?NmVydW9uZHFPMERiR05xWk15cXVrWHZXa3hLSnBvUE4ydUhqbnEvWDRnUVFV?=
 =?utf-8?B?OGx5bW9zWkFLU0RqYmkzNWppQUFZZzN3YTc2NTBLL1R2TUhWWWxwM3VwdHlV?=
 =?utf-8?B?ZnNVeFRNaWsrOUJDOGZqTHJGSTNtUUx5T1JadzFlNXJYdjl5RjRjaitUNlky?=
 =?utf-8?B?QkRneTlpbzdORGF4YWVuZjNXR1FxMjA3Y0U2NEpXa0ZDL0F5REkxelhIZEVB?=
 =?utf-8?B?aWFBaTg3RTFzWFhmNWJOdUx4ZkxObFRTTGVjVi9SLzdVL01pZ2FXTWE0TG9k?=
 =?utf-8?B?OG4zbEpiVFJUTlFpQzlhV252NitqL3hVc3k2OGVKelZoamoranBqdmZIQnpY?=
 =?utf-8?B?ZWMvYkFweDNXYnVuc1F3Z1czRVRpcFphN1U2ZjNoV0E2ajFGQmpoaFJtNmdP?=
 =?utf-8?B?Y25PZ0JOcXRrUytEdzhERktUV3JmTEZEeHZWcEQ3aTZMMy9hOHpKVDZ0U3dr?=
 =?utf-8?B?d1NRbml0T2NuU296UTlyUDhGcndGckFFQzR4ZnQrVmpmL1drSW5YSDBsRGVF?=
 =?utf-8?B?bldXclhwSEtDNkRuYXk2STlDVW9wQ2dOcTQ1aHUyaWNUcjVXVjVDcjZJQTRa?=
 =?utf-8?B?Z1A5OERwU0kvZnpyZmxHelQwRDFodnMrRlhkMFNoc01ZSHdXQyswdUxEb2Fp?=
 =?utf-8?B?S0Z6Qm9nZWVoWkZQbkQzcFZuWHBubDl1ckFEZ2VOdTRwKzlrSTR6NjhueWFH?=
 =?utf-8?B?SUdpWW9ZREZFaUxPUGpuMjA0UU5kU0JrcXlxNjlIM3RUN2R0Q01NWmFXbXJX?=
 =?utf-8?B?aXZlUXBuUzV1Wkt6WldUMlUxWFBJVTQ4Tm1mNW4wdjczT0NYeUJJK0lpZCtv?=
 =?utf-8?B?YWZkUC8rRlFqQ1VlZy9VQXEySnlWbjEvazBIdGV5YVU5Y0tLNmV6VkZSTDNy?=
 =?utf-8?B?SzNNeFRLb0NsbWpxQ1haYS9SeWFhc3I0NitEVGZ2YjBzVGFLWTNtODZXR1lM?=
 =?utf-8?B?QXgrSmVzWFNxaFlGSk0yWjV4YjZaSDVQNzNjZGJSUG9uN1A3WlRUQ2lXb2c3?=
 =?utf-8?B?NGUwZVovUGxUeGxTQnBwY3Ywa1N5SDdrdlhuQW9hNDg0YjZFRHErQm5uVnZj?=
 =?utf-8?B?VjIyZkx4dSsvSTN2Z3gxdEpsNjlJRjVzbUtqN0F6NndaRk4xQVNjeC82MDNn?=
 =?utf-8?B?eFhWWWl1TTR1U1Q2RXZFTmtFdUU4ZlM1WDhaeEFKczhQN0RyNWs2cUZuZkV3?=
 =?utf-8?B?bC82ZzJkcjFDSWpsQ3hiWENTQ2NJR2hVMlVKeFE4NEpCTmJ5NnJicXlMZ2x1?=
 =?utf-8?B?T0F6TjMwM2NnQ3R3Q0xkc1VrM0VMSysreTlSUXJIQmwvMnlIQ25KOEduUmJi?=
 =?utf-8?B?eGtkdDhNU0h5b2F1NkxxRVZNN1N3Ly84U1NTelJ1Vi9uYlhQNGt0WHJTQldu?=
 =?utf-8?B?bFNiWWVRd2Z1WSt6MDU4VkN1TDk1MWdnZEFLOHhGdDl0b01yeWtkaDBDaHdF?=
 =?utf-8?B?U0Y3WU9QQnlNQmY1Vm93WUR0UklrcVl3em5xTm4rWlM1Vmh6QXNNSUtESXpY?=
 =?utf-8?B?czRsd3RtRFBZQ2hvd0N0YUpvWFhnMklxMTZuVS9ISUg2S1p0S1gyRkNIbUxF?=
 =?utf-8?B?VmRSWW1NZjBTYzNuNVF0cGx4aHoraGYrZlA5U2RFR2Z3a1Z5ZTNGQkRXeTAr?=
 =?utf-8?B?dDhuZjdrZHFoRDdrczZIVjRSdi9CSjRWMDZCRVlvZ3FKNUdaYXd4TVd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2pYMERhR2lFMCsxdXlVWSsrN0xqZGtOZ09ZekpTUHorZzFiU2tNVUNTd0Jh?=
 =?utf-8?B?dWVIa2J1ZlBEc1R6OXN1dnJ6YlVWNTQ0R05vTnRCMHBLM2tXZUFFNXFQN1Fx?=
 =?utf-8?B?OTRnWmV2UkhiS0l4TXd3MWg0UTFiMW5VMFB5UTg5cCtyY2paVnpnTU5SMDRh?=
 =?utf-8?B?YVp0LzhSN04rVmVWNEo0cmZnQ3EwY3pqZ0NZSDBaMWo0Rm9oMnhwTWhiQ0px?=
 =?utf-8?B?cUlMTmdHQzI3dFBJWDVMc3ZSZGljdmpQRUJsb3VtMHlabGF4YzdwUmZydkxE?=
 =?utf-8?B?bFlxVGcxNFB4WExFZUtlSDNDbEZFZDVKNVlOZi9vY0s4MEdPZG5SVy9VWkZ6?=
 =?utf-8?B?aVdDNDU2WHV6d2lPclIvaHhaemZESFNDYnRUaWN2d3pXeUZwNDNVQlJmeE9J?=
 =?utf-8?B?cDM5SzFLKzkzRG45Q1RqSUxaWnVha2JRY0hYd1Fyb3htUVBQYXVZY3NVM0Q2?=
 =?utf-8?B?S281UlJIUDZnQlVMeDk3aEZPN3lUYnl4WTlsL0krcUErNGJlWFRuSzNYN1FW?=
 =?utf-8?B?MDYzK0JoNEs0MXVubHZiY1psUXhRazl6SHR5UGZZbEZqZDRuMm5XdUUwVjRm?=
 =?utf-8?B?VTltYkN2d0Y3cmJpMmgvaWJFYVcrdHdmMG1tNzQ1NlM2dTVkejV5T2dKaUQ0?=
 =?utf-8?B?WnhvV1RjYStiUktScFc1TXpZSEdaZFJlUmVKSDZTeTFGRzlxWDRKQmloMHJa?=
 =?utf-8?B?ZUJqekZtdzZaVVdMS3o1bTRvNzVxcUhSYTUvNkdCZmlYRnloRFlEbCt5cDQ1?=
 =?utf-8?B?SzU5Q0ZERVF0cnV2VmR3Rm8wZkFhamdnWm8vajc3TER0SkhhUzV2VlFGU0tW?=
 =?utf-8?B?MDhmUktOTHUvbkNoSkR1SnI3T09oWVVISlV1c0cwRjNwNFhLWXdZY1FESGZF?=
 =?utf-8?B?bnFmekxTK3R1NlRSQ2p2SGpTZmNzdmU1NWFKc0lsbGp5ZE5BU0UwdXB1L2tt?=
 =?utf-8?B?VU5id01XZ2l2d1prZEpxR1FLb3pqb3BGZHpyOHJjbHAwYWdHZUdlcUlUQkVk?=
 =?utf-8?B?ZCtLMFBkV3VkVmpNUy94cXJBV0M4YnEzZEhnRHV5OVA4bVJSdVVwTmc4NUw1?=
 =?utf-8?B?Z2dQdGQvZnNnbDgvL0VIV21YVWVKYW9wMnJuOHh2UGpWWVBVNERXaHQ1L1lR?=
 =?utf-8?B?OWxDS2Q0dGNlK0RzeWthVVdSRU96dHVjY2RtVUxHMVBMWVA3Z3VwT0d2THFI?=
 =?utf-8?B?V0hodzNua0NVd3krWVZ4U3VBbGk5T0wrczBncjhydWdZK0RMUUFQRGhjRHNz?=
 =?utf-8?B?QmFMT0tGbjkrTTVDYmtGT2lpR0dTZndsMDdrMWJEdG4wRklpQS9Yb3BENVZQ?=
 =?utf-8?B?WmpROU1hdUtPVlFDeUFJVkpqZjA3SGZJWWxCSHZkVWh0MnR6anJmcnowUGZ3?=
 =?utf-8?B?c1FESU9CN1lnVmtLUyttRUM4M04xNGZnODRrbTMxNzFFYWZMQWIyWWxqaWJ3?=
 =?utf-8?B?M25kaHA4dWh4Z1ZEcllFV3FTMklKSXMwamtVeTdUbFduK3ZOdGVWMzhTRE5J?=
 =?utf-8?B?cDBUbGw5UDJsMGFrdjBRZzBjd0tsQlBhaVBKZFB2RnIrOUtMak55cUppcTFO?=
 =?utf-8?B?alpZbGd6Q09wZTRncHRPZnJmQkVHa1VhUGZScHNQdjRmM3I2b0ZIWnMvTGNk?=
 =?utf-8?B?cWw0R2kyWnl0NlBaYi9NTXo3WGZvTG81OXdwK3B1WHg2NFM5UXdLb0xJQzhF?=
 =?utf-8?B?R3FnQjhXU0NWcXMzSnhXa2NPRE1zMnFZNEY5d3lhWGxUVnVNTUdYZmhJRjF0?=
 =?utf-8?B?Rkt2ZVBiOFJMa2dhbG4weDZnUElmNU9uUkRmcDV0WG9TaG9SUUtEME1XZ0pt?=
 =?utf-8?B?eE1zdUYyUXkyQjl5MzFHV3dPSU5vUTF2M3lkc2hIckZvNGhaeHM4a0RtUHk0?=
 =?utf-8?B?WWhybzlRdW8zTzRZaWVGR2JCV25ubG5DZUlmRVU5U1A1dDV2cUVTeHdWQTRp?=
 =?utf-8?B?VVhFcE1QSkFPbjhPcXRqSFJ0RXdlaUNxRWcrendJTXYzYkpqdDFhaDVha1hz?=
 =?utf-8?B?QXBSaEUvRFI0c3RFYm5pYnpFVm9ZM3UvMHd3dHJ5OVVsVDFsR1hwME5rZzIv?=
 =?utf-8?B?ZDFWa0J0amZHNFZNMnI2cTVBcWovMUVOb1g3US9ZaGUyN1Zwb2JLLyt6TWx3?=
 =?utf-8?Q?6zbyyZQTlzY7BKS4i9zUBCNch?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd7bca3-b804-4a14-c476-08dc7f3e8708
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 17:49:31.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqS9162n3P5avw7nrpuypy2apohZleMuPvN/xJntpwt4JtPjsfpnOhilUk3bCjFHFdHNxqgngAzsP0MEBKhdVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449

On 5/28/2024 07:09, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When extra warnings are enabled, gcc points out a global variable
> definition in a header:
> 
> In file included from drivers/cpufreq/amd-pstate-ut.c:29:
> include/linux/amd-pstate.h:123:27: error: 'amd_pstate_mode_string' defined but not used [-Werror=unused-const-variable=]
>    123 | static const char * const amd_pstate_mode_string[] = {
>        |                           ^~~~~~~~~~~~~~~~~~~~~~
> 
> This header is only included from two files in the same directory,
> and one of them uses only a single definition from it, so clean it
> up by moving most of the contents into the driver that uses them,
> and making shared bits a local header file.
> 
> Fixes: 36c5014e5460 ("cpufreq: amd-pstate: optimize driver working mode selection in amd_pstate_param()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   MAINTAINERS                                   |  1 -
>   drivers/cpufreq/amd-pstate-ut.c               |  3 +-
>   drivers/cpufreq/amd-pstate.c                  | 34 ++++++++++++++++++-
>   .../linux => drivers/cpufreq}/amd-pstate.h    | 33 ------------------
>   4 files changed, 35 insertions(+), 36 deletions(-)
>   rename {include/linux => drivers/cpufreq}/amd-pstate.h (82%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 070a39b2b098..35a75ab8ef05 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1107,7 +1107,6 @@ L:	linux-pm@vger.kernel.org
>   S:	Supported
>   F:	Documentation/admin-guide/pm/amd-pstate.rst
>   F:	drivers/cpufreq/amd-pstate*
> -F:	include/linux/amd-pstate.h
>   F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>   
>   AMD PTDMA DRIVER
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index f04ae67dda37..fc275d41d51e 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -26,10 +26,11 @@
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
>   #include <linux/fs.h>
> -#include <linux/amd-pstate.h>
>   
>   #include <acpi/cppc_acpi.h>
>   
> +#include "amd-pstate.h"
> +
>   /*
>    * Abbreviations:
>    * amd_pstate_ut: used as a shortform for AMD P-State unit test.
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 1b7e82a0ad2e..91993647e09e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -36,7 +36,6 @@
>   #include <linux/delay.h>
>   #include <linux/uaccess.h>
>   #include <linux/static_call.h>
> -#include <linux/amd-pstate.h>
>   #include <linux/topology.h>
>   
>   #include <acpi/processor.h>
> @@ -46,6 +45,8 @@
>   #include <asm/processor.h>
>   #include <asm/cpufeature.h>
>   #include <asm/cpu_device_id.h>
> +
> +#include "amd-pstate.h"
>   #include "amd-pstate-trace.h"
>   
>   #define AMD_PSTATE_TRANSITION_LATENCY	20000
> @@ -53,6 +54,37 @@
>   #define CPPC_HIGHEST_PERF_PERFORMANCE	196
>   #define CPPC_HIGHEST_PERF_DEFAULT	166
>   
> +#define AMD_CPPC_EPP_PERFORMANCE		0x00
> +#define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
> +#define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
> +#define AMD_CPPC_EPP_POWERSAVE			0xFF
> +
> +/*
> + * enum amd_pstate_mode - driver working mode of amd pstate
> + */
> +enum amd_pstate_mode {
> +	AMD_PSTATE_UNDEFINED = 0,
> +	AMD_PSTATE_DISABLE,
> +	AMD_PSTATE_PASSIVE,
> +	AMD_PSTATE_ACTIVE,
> +	AMD_PSTATE_GUIDED,
> +	AMD_PSTATE_MAX,
> +};
> +
> +static const char * const amd_pstate_mode_string[] = {
> +	[AMD_PSTATE_UNDEFINED]   = "undefined",
> +	[AMD_PSTATE_DISABLE]     = "disable",
> +	[AMD_PSTATE_PASSIVE]     = "passive",
> +	[AMD_PSTATE_ACTIVE]      = "active",
> +	[AMD_PSTATE_GUIDED]      = "guided",
> +	NULL,
> +};
> +
> +struct quirk_entry {
> +	u32 nominal_freq;
> +	u32 lowest_freq;
> +};
> +
>   /*
>    * TODO: We need more time to fine tune processors with shared memory solution
>    * with community together.
> diff --git a/include/linux/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> similarity index 82%
> rename from include/linux/amd-pstate.h
> rename to drivers/cpufreq/amd-pstate.h
> index d58fc022ec46..e6a28e7f4dbf 100644
> --- a/include/linux/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -1,7 +1,5 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
>   /*
> - * linux/include/linux/amd-pstate.h
> - *
>    * Copyright (C) 2022 Advanced Micro Devices, Inc.
>    *
>    * Author: Meng Li <li.meng@amd.com>
> @@ -12,11 +10,6 @@
>   
>   #include <linux/pm_qos.h>
>   
> -#define AMD_CPPC_EPP_PERFORMANCE		0x00
> -#define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
> -#define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
> -#define AMD_CPPC_EPP_POWERSAVE			0xFF
> -
>   /*********************************************************************
>    *                        AMD P-state INTERFACE                       *
>    *********************************************************************/
> @@ -108,30 +101,4 @@ struct amd_cpudata {
>   	bool	suspended;
>   };
>   
> -/*
> - * enum amd_pstate_mode - driver working mode of amd pstate
> - */
> -enum amd_pstate_mode {
> -	AMD_PSTATE_UNDEFINED = 0,
> -	AMD_PSTATE_DISABLE,
> -	AMD_PSTATE_PASSIVE,
> -	AMD_PSTATE_ACTIVE,
> -	AMD_PSTATE_GUIDED,
> -	AMD_PSTATE_MAX,
> -};
> -
> -static const char * const amd_pstate_mode_string[] = {
> -	[AMD_PSTATE_UNDEFINED]   = "undefined",
> -	[AMD_PSTATE_DISABLE]     = "disable",
> -	[AMD_PSTATE_PASSIVE]     = "passive",
> -	[AMD_PSTATE_ACTIVE]      = "active",
> -	[AMD_PSTATE_GUIDED]      = "guided",
> -	NULL,
> -};
> -
> -struct quirk_entry {
> -	u32 nominal_freq;
> -	u32 lowest_freq;
> -};
> -
>   #endif /* _LINUX_AMD_PSTATE_H */


