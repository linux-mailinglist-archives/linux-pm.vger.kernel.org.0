Return-Path: <linux-pm+bounces-19361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684F39F4482
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 07:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F32A16CD92
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EA0171E49;
	Tue, 17 Dec 2024 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5XFwVL8z"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04B15F330;
	Tue, 17 Dec 2024 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418218; cv=fail; b=iLoaQvjx8Guz1kcyAFHMTYFET8Qh9WeELRjRINQ8X4O2+AwSIZjmtzw2GRv2y3hxuzIeJe8Sa55YTaGXT1uCJV0gK4vbIMVUrKDhnxqtY0kO2hy88us2gvCx1dqGNw4kkudqIuRIQpN7mgMnrrtIAqbeUSqj3OFc2aqVY0Vxsfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418218; c=relaxed/simple;
	bh=/+p2IJx/555khIv4C3a7qZ9zIzAX6pdzOi0vTVbYbZg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YlCrO81q3JTWaZ0M8xVyZ0OCxGViNac86LRXO3yeG97SfrBwDc/GtsEjJTzxD+31m/Zk+7ABuEjJkVrO3ikREyAhnAyM/TI+MSfSwFx2WvsUIgKSXGaOvRDMCAoth69Y13WpbRwHAOsz1LLqaxtGvkF2GHv5CnQAtHUzPZW0QAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5XFwVL8z; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzvZjhu0MyJc5i7i/iPg0CulWAk/nGTqDh9Cq1yedLrKWs2k/WhlSH70Gs3YRFOO7yNuxZrcQsAaAQV4KSO3DOE3UReiAcOgYSCfl2OxJujYY9DmPA0YSIDGkGrz28ReNLRtClK9M7ANvzymKui5V4ipU8Ctu4Bm8x1RGPHjp8QW6sUjyNq4qRvqIni5mDriz5X3oHfvTX5JvFWwR9cJO5MSUk/J1EqyDLZSBiR5sAO+W1gXOZrYEzkxcXiH/wX8eIrYDPg9v71tW0NvlC3/9lyFydRYKVkYE4pH/0LRQLxclSpJV7ICbHCKz3bHhjJ6T18WYIA5i1I1Pj0m673V5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmF69MuksTQ2cgmel9MqLGSP8PLZ2ZyjPu/B2Dak0F4=;
 b=xPbRhSvsQ0Wmej1x3L3CYyoVoC+CHHk2AeKWeTYaIJSjRTgogUChppKu8Nqln8xZaeOPMaY8/K+n5ptdUAe8ldq5ry0dDWnBSbKLakoiTZenf484/MjrOg1ISAdIhnJmWEVDE8DypXdZtmUQtiLgj0A+iG/NrgTa00BzwJcvyz0LPWKmyh2itgQoq17pZFQcr9+kk5zZUBVivaeDNaRlkfAv8tnsjKug/0RuiXlaFxxFRccwVQdGWXA2ejfv5Qk0fXEioFSMhf54BpcQMkATKvGSpuUAK03xgTqLRkcY3X1X1QydhbIhRSpmNk6ZO1IvAqE+opvKVV8pwOdWtGVAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmF69MuksTQ2cgmel9MqLGSP8PLZ2ZyjPu/B2Dak0F4=;
 b=5XFwVL8zLY9vLOZiJHF5THgYoYem15ZQDAIaAgkwCoH7daO75Pmd2woTp2CSEREX1c6DIOh7CVIG6e6BjS7jVOgGLzbHR6MZLU57+BLFvJ6mQpV0MfKGeA5wfa/kBTalfiX8hpPczajwEQtAp8q0HVyG2HOROLOPavXVQl7xLWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH0PR12MB8126.namprd12.prod.outlook.com (2603:10b6:510:299::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 06:50:12 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%3]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 06:50:12 +0000
Message-ID: <cfcbf8a4-7254-438a-8b0c-29807e07ed90@amd.com>
Date: Tue, 17 Dec 2024 12:20:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] cpufreq/amd-pstate: Move limit updating code
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20241209185248.16301-1-mario.limonciello@amd.com>
 <20241209185248.16301-11-mario.limonciello@amd.com>
 <d120814f-7393-4d10-a6de-ba09948f4243@amd.com>
 <6ea8c643-6977-4ce2-be1e-b0b0a73e8306@amd.com>
 <5330c947-7bfc-4932-800e-9067a9f78470@amd.com>
 <a8c6ff3f-2ad8-4926-9ac3-f0f39ceffa2c@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <a8c6ff3f-2ad8-4926-9ac3-f0f39ceffa2c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::6) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH0PR12MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f79e851-277a-4ee2-1766-08dd1e670de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFoyL0ZtWHQ1L0ttSk1OYlo1cEovazY1R2svWmRmQlFicXhaaWFXZUg3dkdX?=
 =?utf-8?B?czlvck1HUStBZXVla0pjYnQ2K2trNTZiNit3Ym9xM2ZheU96cTY0b2tvRk5r?=
 =?utf-8?B?M2lycDRwQStsWEtUZnZHSnRVVXdjTVFvd3ArQ2pEM1hLYlRoT3FsWmFrL3Jl?=
 =?utf-8?B?YkxPQU0zZzlrMGNFMXM1NHdyUlN4bGFsTEpOOUd0Wmd3a09VaWIxWnk0ZUxH?=
 =?utf-8?B?MHFpdGJ2V1RiM1BkbE1IOGV3Yk9QZTBNUU5MeEpPT2pTZkwwMy9mdWs3UEdG?=
 =?utf-8?B?MzlFQllCdGhuMVdEb09Ea2lFWW5TZW12UUFDajRVTTFSajY2SDBSRGRyYkpy?=
 =?utf-8?B?Y09OWEVpUzJRbFBXWUJ4cjFyNENRMU0vdFR5czYvVEF5SkVCNG5VWUZ2QjIw?=
 =?utf-8?B?UVY0UWFyZEhyZEV0WWJxZkxhWXpDRzRvZkpWVXVVdlRuUlJLKzMweEdTZlhw?=
 =?utf-8?B?UUFVcEN1Nk5SUmZnZmtIc200dys0Zjh0amtYNFNIeEdIWjJYWk1VbzdRT29a?=
 =?utf-8?B?empTS3lnMzd1SU1KZjZQWkJzQnI4ZlFnYlYydGNEblk3SUVlVHJnd2M3YXI5?=
 =?utf-8?B?NGliTVdSWElpNUFxa1g4UW1GcmFla3pMZjV6ZEplNG1nTzJNbHdCNmo4NXI2?=
 =?utf-8?B?Z2h4dlFXSE4wYjY0c3hKelhsbkpkOVViNGx4cjVLRG5JZ0tKcUhTRUtXaU5E?=
 =?utf-8?B?S0d0eGh1Vmk1OWtyNWloc1NlaWdCMDFLTW9Nbks0U1ZSdGlYcGFiOFdPWWJO?=
 =?utf-8?B?M2N1b243eFY1WXFWNkxIYjFBVXVWRE14eDdKRXJydGpzY1NaRVBKUXk3bUhU?=
 =?utf-8?B?NGZ2SnpRUTlyZUxjZ3hSQzVwaTh4Rmk5OWxxbllrOUVvakZ2TWJkWTRYZGRZ?=
 =?utf-8?B?ZUMxTjdHWktMd1JBRUQ0eXJsRVVMQklXdjZpeG54UWdrWkE2WCthK05hYjVU?=
 =?utf-8?B?eWVTQlFidkU5R1NtanBpVkZKakhQbzNwY2lVTU9GbVFXOTRoMVZHdU40OUFE?=
 =?utf-8?B?ZmNYSzlBZVJid3VXZHdmSElIdTRKbFBqdHVSOFI1NkVreUJGSXFoUnNuNHdL?=
 =?utf-8?B?V0RGZ1Nic1hCcTNEOFVvaUJRYjRQOHNSVXJYb0tGbUFwMEpvZ28yOFAxZHll?=
 =?utf-8?B?NmsvZVFLVFJNcm9kbE4zUCtQSlozaGo3SXowcFFKdEJHc2dsaG5MYmV1VkRZ?=
 =?utf-8?B?OXVROXRNcUJNTmtQV0tBaDFPYldsb3RUU1A0YWtWOVJmRmhMZW5ZV1h1aDNT?=
 =?utf-8?B?WkFzVFp3UjdvUElYdHpoMi9HSitkYlBEeEZVNHVmTHF2QmFud1hLZkZldFB5?=
 =?utf-8?B?SGZVbWZMMDNxejFHY2RWNEVLUjFmWVNoakFIMHpwSy9wYVZqQmVnQzhPd0Vq?=
 =?utf-8?B?VStPQVZQMUZ4VlFycTNrdnBRWnJNRlN6VDZUbDY4ZllwSkJrS1Y0d0xoYlIr?=
 =?utf-8?B?RUtEa1MwdDFjYlNRMFhrTmN1OGE2d2RlTms5M2F1NVRPTFJ6MkdaMkRKUlpo?=
 =?utf-8?B?eDBzajBXeEpiVWhUaXdxYm9UUEtjMDVuYm8xWVk0TCtWL2Rvc2xLb2F4ME02?=
 =?utf-8?B?TXQwTnRiSE1zUE5RZ2hwZEUvbktjL1VPZDFZaTNrZ1MxN2tVZnNvL3Z1T3JV?=
 =?utf-8?B?L2xpK2ZRL0huZ1U2bjB3RmpjeGwyay9PUHNRTGJLelErS2trQVVlVEIyd3Rm?=
 =?utf-8?B?aVlLSjdDcFlxbTl2R2JGT3J5R2pPd2tIQUkzWGlqenh0TGd6SEdKTzhOTEtt?=
 =?utf-8?B?YXBiT3ZpZmRoVmdwSUlTcXNHMmxCbmc3U0E0ODdBclNlYlRJYXBKTytRdTc3?=
 =?utf-8?B?cTVZRXJVY3lRM2lEZ09yZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emh4azN2ZkZxSmhGc3VNN2N3ZkpndlBPS3oyN0tobjAyQmxZbU9tSGo0VWZo?=
 =?utf-8?B?U0dYV2lGZVZLZFo4Q0J5d3hJVFNaV1dLM3AvSzBQOFFnYUNXZ1lkdUFhM3Az?=
 =?utf-8?B?K1hFdzhjNjlicFgwbVlVdGhGK0pxSWtOaU1YekZTNWRDZmwyNGhqSmpxaEsx?=
 =?utf-8?B?bU5oZURXWGlnOHFoTkdWMmpGNElKTDhaSGVsWTdqbmdoTkdWSmZlNFVnbUNr?=
 =?utf-8?B?ajkyOWY5b2F5RmJDVTVDdWJsbUhuS1ZXcGQyYnhXcVJHMGNpcHlPVzI5MW9D?=
 =?utf-8?B?VzNrTTZqdG40ZnFveHVIcGZqc2RHNVRpSDloeHc3dEp1QXA1RVk4dng4Nk40?=
 =?utf-8?B?TU1RT2VzZTc4SmRuUm01R1hqaWlEdGRxRTlIRkcvb083aUhRUC9KblV1SmVl?=
 =?utf-8?B?cjZzVXM4L2F6eVBDRTJuWU43VVpaemJXTWNEZkI1Y3FIZUhWTmlpeUVvbFcw?=
 =?utf-8?B?NWZGVndybytzYWlOMnlSTjNTRCt2NEhRanQ4R0dlamdhcncveHpnTi9vZ1JF?=
 =?utf-8?B?RFFydTBWMFUwbzBnWkJERHVTYW5lT2d0ZHdXNUFvRkZLM2dtTEhiS0UwR3Nr?=
 =?utf-8?B?bVVYV0t1QWJ2U1ZsMmNjSGU0anBFS3JSWk5jYVVjTGY2bHY5YzNEMHgwZ3FJ?=
 =?utf-8?B?TVlCN3lIQ1hCdUlDcDRkUHZxNjNOYVM2MEZoQUlCR0k4Y1N2bXh4L3czVFRo?=
 =?utf-8?B?a2drTG03NDZwRTI5OEVBM1d4d054SEF6VG5HaEdxMXByb1Nqa3ErTno5NndY?=
 =?utf-8?B?cmNhOFBQeThtSG5DNUdiS2JBR2FQY1JkVHF3MWVrT2NXQVU1TWRSWW9uOXZK?=
 =?utf-8?B?dExTR2xmT3d3ektsVW9ERUFvZkZ5Q2ppNGtZVXlwSSs3MWRoS2dWM1p2MlRB?=
 =?utf-8?B?WlpHdHc4NDRqc3Vyb3NFNjZpSVhHMXBDTHcrOXdvampadU5qQ1hKcVhCRlVk?=
 =?utf-8?B?cC9CVHI4YVdVYzRLQTJXaVo3Ry9kY1VERDlyaEErbUpDN2J1TFBDcUJyVlkr?=
 =?utf-8?B?VWt0Tml2Y3l2MjRiVWlydldEbnpJYnNjcjlrK2Jvd3JVcjgrMmw4RlY2MGFU?=
 =?utf-8?B?V0NBbUhSaU1UaXBMZk5nOHZwekRSbTRmSVYxd3p3NEREckVhZHNsNjZyVkNx?=
 =?utf-8?B?SUM0em03RkhjSy9MNVN6bkZmMHpVZXY4ekNHUGQ0alhKcy9XSjZOS3pqNmRR?=
 =?utf-8?B?R0ZsQ1FSa3lmRmluTDNMZDJVWDM2TW10K1RBT3kvMzByMldaTUwzUmxxV042?=
 =?utf-8?B?UG1lOFJXRzdiTE9wSXFoWmlOTzhDQzVOL3loK1ZaRndCQ2ZXdWEyeHJtdGt4?=
 =?utf-8?B?bDNhTHdCQUNFeTZxSWJmKzBmMVdUbEx2Z1ZPSmpiblExUkhubklkM09uckpC?=
 =?utf-8?B?MjZKTUNUNzZmVVdFNXYxaFF2MzhpQlNhNUtRTjZNeHRIaG82T0llSDV0RXJ0?=
 =?utf-8?B?b1VYcFhKRTRZZWJHRjJNL3ZWV0pxOVV1ZC9IQkFuVnptZnJVRmNxS1c1cHl6?=
 =?utf-8?B?eUFZYlU3SUo4bVBPUTJqR0g1UysyUVV6K3dvVDVyVnRkdnhROGZuMStpOGNh?=
 =?utf-8?B?MmQ5RGw5RmpIcGY0RCtBWXU3RE1qMkZlem9JaDF1ZmNURUZiMFpadEhXazhZ?=
 =?utf-8?B?REM3K2JQT0FxQldyVDUyRUlHV1BFbzdicEt2aE9nN2RxaytzZTV2anU2ZHBJ?=
 =?utf-8?B?OXUyYmR0VXlZQVNRSHpnTDhobG92cmZtbTVIeW1ncnJLMGFrRjFNS1R5Z3di?=
 =?utf-8?B?YW5TUGVFZkRTVnh4eGt5ZXlNdzlUbmhlZTFUbTZhNUJDSGordHZOci9jczNp?=
 =?utf-8?B?V1g2VkNPWW9aSjBEUUFwbHVSTzAzK1gvaGxrLzZoZWw0WlJFbFZpOS9zUlVZ?=
 =?utf-8?B?Ymc1Qm1hSXhOb2R2NUZPS2Z6cmxKQXluenZzSVNJWE9FK2lDUnNWenpIbVVK?=
 =?utf-8?B?Slg4L3pmaGh3YnhNUmlCa09MdnZsbWFDUVNNWE5EYkhlS1BQUzB6YlpFWUFw?=
 =?utf-8?B?MEZoN1ZJSTI4NWJWZVJXMkFLdzE5ZnlaSC84REtSb24xQS80Zm1udU5GNmlU?=
 =?utf-8?B?UFN5WGlDbmV2TGFFTHlEeXkxQkVVOUtBZDBuRHBmdTBvYjc4OUpycm5pQ2Vo?=
 =?utf-8?Q?MP6GhW2z+M+mRFJJQ0RmzoQdi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f79e851-277a-4ee2-1766-08dd1e670de1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 06:50:12.3105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieFyqz8oRepw+G9Pux8crL75TqYO/QmjT+bF74s0QXdNkicz38qp4WzufalCNJgfTUAofowqk5kqChoAPZrI8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126

On 12/16/2024 9:09 PM, Mario Limonciello wrote:
> On 12/16/2024 08:45, Dhananjay Ugwekar wrote:
>> On 12/16/2024 7:51 PM, Mario Limonciello wrote:
>>> On 12/16/2024 08:16, Dhananjay Ugwekar wrote:
>>>> Hello Mario,
>>>>
>>>> On 12/10/2024 12:22 AM, Mario Limonciello wrote:
>>>>> The limit updating code in amd_pstate_epp_update_limit() should not
>>>>> only apply to EPP updates.  Move it to amd_pstate_update_min_max_limit()
>>>>> so other callers can benefit as well.
>>>>>
>>>>> With this move it's not necessary to have clamp_t calls anymore because
>>>>> the verify callback is called when setting limits.
>>>>
>>>> While testing this series, I observed that with amd_pstate=passive + schedutil governor,
>>>> the scaling_max_freq limits were not being honored and I bisected the issue down to this
>>>> patch.
>>>>
>>>> I went through the code and noticed that in amd_pstate_adjust_perf(), we set the min_perf
>>>> field in MSR_AMD_CPPC_REQ to "cap_perf" which is equal to cpudata->highest_perf (which is
>>>> equal to 255 for non-preferred cores systems). This didnt seem logical to me and I changed
>>>> cap_perf to cpudata->max_limit_perf which gives us the value updated in scaling_max_freq.
>>>>
>>>> I think as we removed the redundant clamping code, this pre-existing issue got exposed.
>>>> The below diff fixes the issue for me.
>>>>
>>>> Please let me know your thoughts on this.
>>>>
>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>> index d7b1de97727a..1ac34e3f1fc5 100644
>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>> @@ -699,7 +699,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>>>>           if (min_perf < lowest_nonlinear_perf)
>>>>                   min_perf = lowest_nonlinear_perf;
>> here^^^
>>>>
>>>> -       max_perf = cap_perf;
>>>> +       max_perf = cpudata->max_limit_perf;
>>>>           if (max_perf < min_perf)
>>>>                   max_perf = min_perf;
>>>
>>> With this change I think you can also drop the comparison afterwards, as an optimization right?
>>
>> Umm I think it is possible that scaling_max_freq is set to a value lower than
>> lowest_nonlinear_freq in that case this if condition would be needed (as min_perf
>> is being lower bounded at lowest_nonlinear_freq at the location highlighted above).
>> I would be okay with keeping this check in.
> 
> Well this feels like a bigger problem actually - why is it forcefully bounded at lowest nonlinear freq?  Performance is going to be awful at that level 

Actually this wont necessarily deteriorate the performance, as we are just restricting 
the min_perf to not go below lowest_nonlinear level. So we are actually ensuring that 
the schedutil doesnt select a des_perf below lowest_nonlinear_perf.

(hence why commit 5d9a354cf839a ("cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq") was done),
> 
> but shouldn't we "let" people go below that in passive and guided?  We do for active.

Yes I agree, we should allow the user to set min limit in the entire frequency range, 
I thought there would've been some reason for restricting this. But I dont see any 
reasoning for this in the blamed commit log as well. I think one reason would be that 
below lowest_nonlinear_freq we dont get real power savings. And schedutil might dip 
into this lower inefficient range if we dont force bound it.

Thanks,
Dhananjay

> 
>>
>> Also, what is the behavior if max_perf is set to a value lower than min_perf in
>> the CPPC_REQ MSR? I guess platform FW would also be smart enough to handle this
>> implicitly, but cant say for sure.
>>
> 
> I would hope so too; but yeah you're right we don't know for sure.
> 
>>>
>>> As this is already in superm1.git/linux-next after testing can you please send a patch relative to superm1.git/linux-next branch?
>>
>> Sure, I'll send out the patch once we finalize on the above if condition.
>>
>> Regards,
>> Dhananjay
>>
>>>
>>> Thanks!
>>>
>>>>
>>>> Thanks,
>>>> Dhananjay
>>>>
>>>>>
>>>>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>> v2:
>>>>>    * Drop lowest_perf variable
>>>>> ---
>>>>>    drivers/cpufreq/amd-pstate.c | 28 +++++-----------------------
>>>>>    1 file changed, 5 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>>> index 3a3df67c096d5..dc3c45b6f5103 100644
>>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>>> @@ -537,10 +537,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>>>>>        u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>>>>>        u64 value = prev;
>>>>>    -    min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
>>>>> -            cpudata->max_limit_perf);
>>>>> -    max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
>>>>> -            cpudata->max_limit_perf);
>>>>>        des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>>>>>          max_freq = READ_ONCE(cpudata->max_limit_freq);
>>>>> @@ -607,7 +603,7 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>>>>>      static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>>>>>    {
>>>>> -    u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf, max_freq;
>>>>> +    u32 max_limit_perf, min_limit_perf, max_perf, max_freq;
>>>>>        struct amd_cpudata *cpudata = policy->driver_data;
>>>>>          max_perf = READ_ONCE(cpudata->highest_perf);
>>>>> @@ -615,12 +611,8 @@ static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>>>>>        max_limit_perf = div_u64(policy->max * max_perf, max_freq);
>>>>>        min_limit_perf = div_u64(policy->min * max_perf, max_freq);
>>>>>    -    lowest_perf = READ_ONCE(cpudata->lowest_perf);
>>>>> -    if (min_limit_perf < lowest_perf)
>>>>> -        min_limit_perf = lowest_perf;
>>>>> -
>>>>> -    if (max_limit_perf < min_limit_perf)
>>>>> -        max_limit_perf = min_limit_perf;
>>>>> +    if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>>>> +        min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
>>>>>          WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
>>>>>        WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
>>>>> @@ -1562,28 +1554,18 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>>>>>    static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>>>>    {
>>>>>        struct amd_cpudata *cpudata = policy->driver_data;
>>>>> -    u32 max_perf, min_perf;
>>>>>        u64 value;
>>>>>        s16 epp;
>>>>>    -    max_perf = READ_ONCE(cpudata->highest_perf);
>>>>> -    min_perf = READ_ONCE(cpudata->lowest_perf);
>>>>>        amd_pstate_update_min_max_limit(policy);
>>>>>    -    max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
>>>>> -            cpudata->max_limit_perf);
>>>>> -    min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
>>>>> -            cpudata->max_limit_perf);
>>>>>        value = READ_ONCE(cpudata->cppc_req_cached);
>>>>>    -    if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>>>> -        min_perf = min(cpudata->nominal_perf, max_perf);
>>>>> -
>>>>>        value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
>>>>>               AMD_CPPC_DES_PERF_MASK);
>>>>> -    value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
>>>>> +    value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, cpudata->max_limit_perf);
>>>>>        value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, 0);
>>>>> -    value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
>>>>> +    value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
>>>>>          /* Get BIOS pre-defined epp value */
>>>>>        epp = amd_pstate_get_epp(cpudata, value);
>>>>
>>>
>>
> 


