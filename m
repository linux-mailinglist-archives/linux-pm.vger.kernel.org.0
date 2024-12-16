Return-Path: <linux-pm+bounces-19311-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8109F32F6
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 15:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C0D18850F1
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0906720764C;
	Mon, 16 Dec 2024 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5o3AeOwp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE4206295;
	Mon, 16 Dec 2024 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358606; cv=fail; b=YioqSDEsq1pZ6lquwl5EhLMy0q1Cyyoq0fx9+Qk9Yu2LS+Bs01U30bif5B3xTg4SwpxNQGUum5TSp2RfVxp07QiROVKBgq5sYhFXM74cZxs/hVzOG1VaOLZf5YOfYA44pKYmYL1Wp5peh0bfs0bs1cq7Lputcq+FBBOUBWd9uDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358606; c=relaxed/simple;
	bh=1CYrFM8LnZHcaesfFASGCNW5bUs391uLPbWixyMB8P4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sL7n5R7nIXdZaxbNjbetwpoPHp/1nNPrAxAYD+yRz7+J3y3/nLxBdKOuIUuHJ3b8gFM4C7r2CgHMW/6COroryXYXKZ2vvhEgUPZGLjthYWep10G9UT3oUzp/UTn4aMo6DMKd2L1Z7sWUlviVfwTGMoFQyFAMNk02RNUmA3abCzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5o3AeOwp; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNvb12gC9PdsGQBlc63rOLnGRvj8buKmGO1BvefHad3D08ivK7eleKRj+yDbypOkfXdSMeeJ3MIXnABODsif1ziE8Tb/6N3b/3v6/Ym/YvcdAOhgl/ogUZIf5LFMoacDWlEkZ/pba+U+B8+aayz5Tj8u4XCXlTmats7P4CNrtOt+KLzYZN6ccwVddbHmhlSjpVwrinpo2N1IriR9+tVv7xx7k4yHuYzGnG9GkXlQ0dIJtrxZ3zK4p0ViYuJ66QCY121pV0pi4YvLoKZtPTwg5C3KmtFhOe6GBeRyvXcWj98BdWxadNpYiVqLKQHAWQ/eu6YsW6nnTIy/9TMcZgqbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8uRm7WpVVha4AE54pLbwU4t/VLWNdtv32HDRUousnM=;
 b=ZmOqErGA86WZ7l3fNlW/+VDdn1zlbCMSv7iVAi/AlOfCpAFrsIWEwJtY9GiCEiVQmkqRZZmwzFzIpx+jMz48WO7U8XBZxTPIgdu8bSWkK/kh5b+0ACXHwn0VdNdmZAtau0B5CEMUPttI7Q3DMpJo4Vu5B3US/x/zLyAIi9ypqjoU8sVSpblBVHeM9MWqGY+bS59SwIjlquGk93+EgsYa7z9Q7+0NFdG/ggAmIlnd90xmlmDDXEQD1lhDxTjkWVct9uE4sU0MXzy8W+p3d8FlZitNv1FHASAxW0RkDW6PTIadMOqDY7CbdDbxBNxy4f+g8mBzzQgtTG9Tb/MXpAn5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8uRm7WpVVha4AE54pLbwU4t/VLWNdtv32HDRUousnM=;
 b=5o3AeOwpx3/RbMv0x+IrBSNSedUHcq7GJrtePulc2d677jSazZjYRHHoUwXQqb0KFzzQAB3m8pe/DLczZIahx4Lr7CDDzWwrD8bV/+9fwSXmMeK3Lq8rFZv+ri9z16p0IpTkOzy+8moVho6pLSNAdrLXxG2gpzhB6NH/rI/Mugo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Mon, 16 Dec
 2024 14:16:43 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:16:43 +0000
Message-ID: <d120814f-7393-4d10-a6de-ba09948f4243@amd.com>
Date: Mon, 16 Dec 2024 19:46:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] cpufreq/amd-pstate: Move limit updating code
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20241209185248.16301-1-mario.limonciello@amd.com>
 <20241209185248.16301-11-mario.limonciello@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241209185248.16301-11-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::21) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|LV2PR12MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf0cbab-2e9b-48fb-4524-08dd1ddc43e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDNvVE01NEZlWmV2aGRoMVhSS1daeUl4NnBjMnFFSnQ0K2tnTHd6Mk8vQS9Y?=
 =?utf-8?B?TlF1dlFheS8ybTc3NlhkNzRLbm92czZ6S2hXdG5pQ0ZyNDM4cXJ1cGtpNnNw?=
 =?utf-8?B?YWtaaW5CY1hnTFE1U2FVdTNHcDgvTXlvVW9LMFpEQkZDT0lEb2tYUy9LL2RZ?=
 =?utf-8?B?RkYybVZxM0wzaHg4MktRYXUrQVE2SERiZWQyd1JnNitaR2RBSlZkaHJtOWJk?=
 =?utf-8?B?cnEyY0VTNm9OcFU3YUpXMDRLMkdqZWk4azR1YWxObmJyL1NpazRMY1ZJTkNB?=
 =?utf-8?B?WjF6eEMwU3l6YUZLWUl4Y2RVUEY2enlVazFJMktIM3FvZmlkQ3c3LzA3eERC?=
 =?utf-8?B?b0RMZUI4L2U0NUc3b3pKd1FBY2prYVVLUDJKa2IwQTlYS2ZMcjQzTHNaN1Rz?=
 =?utf-8?B?dGxJTVJEelFKSDVoLy9PbmhaWk1vUTd0R0xmK3dWSlcxaHp5QXJOM0o4Snlo?=
 =?utf-8?B?Tk0raDF6ajhFeUtsVGhkSXBISStMRjA2bkFBcTBINUZ1Nm9qU0R3bGNUdjhG?=
 =?utf-8?B?Z085SFVibzRmV0hxUkQxVDZPZWRIZEd5ZXQ4Q2RLSzF6OTJVZkpCVm1hcXlo?=
 =?utf-8?B?NnQrdG9XeDhSNEV2UmZxMUtZRTlrRUQvM09WU1loeG83ajNEbmRNUnhLNzJv?=
 =?utf-8?B?UDdVbi9SbW4vc05KT3lnMnJxTWhoTmZoUE9oWjJLZXdRdmRDR29MQkVZM2Y0?=
 =?utf-8?B?UmRUazVJMEZ2SFZkMVFvMTBmTEZFNmM5VS80VXpxTm5IUWdncERpWnR6RTVv?=
 =?utf-8?B?QktZekZlTExOTDRUalhEUE1CRStDRHJDZXhZL3hoWldlS3JoK09YamwvUzNJ?=
 =?utf-8?B?MlB0VDVqY3NpejFMcDg3V1JBYmRUa0Vuem9lcWVZamJ6czFZLzV0emk2Z283?=
 =?utf-8?B?VFZCdHVBOXNhSjRMVTZ4Y0tjdUVmYzk5QXR1c2Fja2VRZzU2OWdpbGxGTjJX?=
 =?utf-8?B?YnYrdEVsZVJFY2hQMi9lYXFQVHpkeHVpVGFaZUh6dUNReXp4bnc2dktRM3dF?=
 =?utf-8?B?b2xtWmlFMUFUZkRNNi9iUHJqKzFFKzVBUzhXSVR6d3U0Z0c4VVlvS29DZXo3?=
 =?utf-8?B?cU1Hbm83emVVSFRQU0RiTmhvUTl5c0o1czBwTkw2dVUrOXpPNEgwMFNOTURn?=
 =?utf-8?B?QjllTHJwUjl1ZzZQcEhvWXJvWWZsaDFBOVlHN3lpaWt3TGpCWWJZWnEwa0RW?=
 =?utf-8?B?aDFLYi9vRUZqV0FMU1ZFYkxOb1A0Rkw4L0RoOFBuSWZKak5QMmxlc1VFcnZr?=
 =?utf-8?B?L281aG5PeHFzWmJhbFp5YkpPODI0UkljNUsxM1d6Q2dLSExybXRza0oyQnBa?=
 =?utf-8?B?ZXZ0M0svNE03bzltRXg4THlPS1lDdVd1alBUZkpuQWIvaW9vdWY0U1c4ODkx?=
 =?utf-8?B?U3FkTUc2clgxbHFhclViT3JKa25Ua2xzVUwzbHRqNDhOV1dDQmpUd2R4SytJ?=
 =?utf-8?B?SlJubGw0Q2x4SUFKcE05WEdJdDhiQnFWV3MzbVRMT1FhSE1lU0pDb3Z4K1BI?=
 =?utf-8?B?OXM1enhBQ3AvVWk5bjVpeHFOLzhyQUZRQlh0YWpvWnlnSXlCTmRLMFNQaGl0?=
 =?utf-8?B?a1BYd0tjbFJIR21SVUU0OVhicFZNRFFEMEFHblVDNnBBUEZOOGR4QVZXMFVx?=
 =?utf-8?B?Q0prcFNXVzd3TnFObE1GRWNaTmxVVXFDclVvc2tqZkZ2dGxiTlVSTU5XR3or?=
 =?utf-8?B?Z0VhbUNCdjNEYXRGaUd3cEttSUhEbk93WEROYVpsOVJEdlhIOU1YeVNPSVRu?=
 =?utf-8?B?SmF2bFRTTWNYK2ZtNk01S3hPY283SVBoYXhROEZnU2syUWxKVGl5T3Z6bldp?=
 =?utf-8?B?bFYwbVVvNDlGK29zczRsS25pa29aMWM4Z05RaHZnSjBobWNSeUR2UUhJcGFK?=
 =?utf-8?Q?HsDWPKGYZd/yi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTZOT20rc1RNRHNwRStOVzJCbmtPNExoV3RNbDdSOHF1OXBhZkRZQVJsSE5k?=
 =?utf-8?B?ZTUzbVgrS3VGbG82KzA2aHlSdU4rSnphVEt0RVN6RWdVQW5KSWFoNm9CcnMz?=
 =?utf-8?B?ajNXY040VlZQVDh4N2lTTTlWeDIzVUEyUnIwZ0hqY0FnblljY2d4MUN4VVFn?=
 =?utf-8?B?c0FrRnJmd0lJMi9tajZZenJZVHpURTRYdnFkQWdPb3lYWnVEOU9xd3l2L3dm?=
 =?utf-8?B?NUo3WkdtQ2hHRzFiTmFHUkM0WWRSdThLNC9SZ2dtTjFoWklXdEE4TXZ6cFVq?=
 =?utf-8?B?MjBTb0VMUjJaZTQzK241Ynl2T1NJcWRRTnlrNHlMYzZ2UWwzYmw2WXM3c2FB?=
 =?utf-8?B?SUVyQ0ZIemJ1aWJPTnZGQlRGSzNVc0pKTmdBTGZCcXByY2xsZFY3MGJ1Q2V0?=
 =?utf-8?B?NWFKOEtPNkZDTkRPQUtRRmF0ZW9lTzVJREwyV3MrZkl3MVkyMkRGM09Ob1BK?=
 =?utf-8?B?aTRzNjVMTCs4ZE1DQkZoSFZCZGVUT2FDOTRWY1VnOTNLZDFOYUw3RTZycjRF?=
 =?utf-8?B?dldEZUhMTlVOTGhyaTNoVU1WNzBLOG8wUmt0dWlaL1dhdTY1eFppYitERW5x?=
 =?utf-8?B?SkFLQWZTSUR5TWhjaEU5eFJwN1VuakppM25uU3U5YzlYbVlaZGVpV1hOdDBW?=
 =?utf-8?B?RDJ4UDRLOGxIdFVYYVloSTFtYmxvWDdENDl2YnZyUlRJa0hhSFI5NFFjQzcx?=
 =?utf-8?B?NVVpWG1URGdvT2pzY1Q1QjhVZ3ZzUkxqbCs1Mlg1eGxCNGdRN3BEaE0vNm1l?=
 =?utf-8?B?QkNNUGN5YXhMeVFHeGtnanhpQkRVTjFPdFZBUEVqeEkxQm5OYTI3MytHZ01l?=
 =?utf-8?B?dGZiMzloZHpROVRRT1hQYXhFcmhUM2NOOTZocDR3bDFkSkhMdFJVYW9TOUFV?=
 =?utf-8?B?dFdCQThLRFhqUm94eFJXeE1XMHY0bmZ3N2FxaTlRM0lWQWdoQjl1ZERmb0Q5?=
 =?utf-8?B?ejFSUzJxb3duenlubDhORnd3MVZKb0FCSEMyUy8zOTBoL2RGSVRTVXJVaGdo?=
 =?utf-8?B?TGtWTk5FalNiRFBneEExUjVNdEQzd0UxZklkZjlFVmZTemNuQU4ybmFTWHR0?=
 =?utf-8?B?RXR5Sm9GY2thNlY2SFMzT1VwZjZnZkNkRzhVWCtiTEN6S1BUalpwNm1kY2I4?=
 =?utf-8?B?RDJnZzJDTWhBdXl3R1F1Nk1RNjBudGYvUUtwcnljczBzR1NOSVJpVDR5Yy80?=
 =?utf-8?B?L29ROVF2WlJucXBWc0MzWFdhaG53TEFuckpMaE9pSkdMUlBKUlROR0ZYVWM0?=
 =?utf-8?B?SGxVWCtENUZZVHZUNmpFeHA2ZHIzdjMvMFFBT1dXR3N1YlFISldTNEFTRHk3?=
 =?utf-8?B?ckJyQUw2OVNPMTByQ1FReFlPR0JrWUdqVUxUU3l5cmN1UDhWQXNCQXFDU1Vz?=
 =?utf-8?B?azhsck5IL3VhNTc3VEpwdHJXZEdCK1J4VnVkV0JMWWJTNlVjOGUzWEs4S2lJ?=
 =?utf-8?B?TmF3aElDRHJKbnptR3pnM0p0aFlsc3Y4bkw4c3JydkdFUndnaTdaRjUxWTlV?=
 =?utf-8?B?YS82dDFPL2lFR1FqeU1qRnVmYzlzZGZIck5LZ0xweS9oZ1o0TFFaRklqbCtL?=
 =?utf-8?B?QjBSWEFMNXAydkxTekJNS0RxRU14dkFoMjZUM3Rkc1pLaXpOcHB5Y09KVzl0?=
 =?utf-8?B?WFRubWZmSDZnUW1aMEdWcXNSWC9Ybk96cU93N0w2Y1d4OElzS3lpMGc0YXp0?=
 =?utf-8?B?SkRlcEczc0lPdGxJcWY3bmExR2RJajZGODFaNmNNNmhIUnlIM0hoc2wrNThs?=
 =?utf-8?B?TWlqdEpJTlp1WlVrdk81VkhtU2dPVEpucjhUN2t6WXA2dU9ESHBCaS9COXhw?=
 =?utf-8?B?S2xOekJzWGw3eG1ZZXhueWFodEQvblA2Z1dFOUFVdDlFQy8wV3dNdVhyaTZp?=
 =?utf-8?B?Zkdob1VZa0hoUkZmeXdhV2hOZjdJVnk0cEtXdy83Tlk5S1VqZEJ2UVNGKzFZ?=
 =?utf-8?B?VU9WZWZRYWVmdjQzbW9DZUpDQ0orakRKa2JuMGNpeCt5cms5UDVqWElDVGI1?=
 =?utf-8?B?R3NJZXFXd05nK21XM1BnMUdKcU9RVHp6WW1oNVRZbUFaZXovbDRhYVhpaVBE?=
 =?utf-8?B?Yzc0ZzVQdEFWMnNOSlBldTFiTHFJbllTMEhXMU56L3h6ZzFjWkNxZktZV0Vn?=
 =?utf-8?Q?ZLsRx/jKcIlcGL4VkLmrwOKks?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf0cbab-2e9b-48fb-4524-08dd1ddc43e1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:16:42.9296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGx9Mt3lEm/ZCoCAUeBnEr5sqreOFPL3gw4yTYXcmUkYvU1pwKQsOy+3bWDslelHEdhgABcXM8LcQKLhCzerBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799

Hello Mario,

On 12/10/2024 12:22 AM, Mario Limonciello wrote:
> The limit updating code in amd_pstate_epp_update_limit() should not
> only apply to EPP updates.  Move it to amd_pstate_update_min_max_limit()
> so other callers can benefit as well.
> 
> With this move it's not necessary to have clamp_t calls anymore because
> the verify callback is called when setting limits.

While testing this series, I observed that with amd_pstate=passive + schedutil governor,
the scaling_max_freq limits were not being honored and I bisected the issue down to this 
patch.

I went through the code and noticed that in amd_pstate_adjust_perf(), we set the min_perf 
field in MSR_AMD_CPPC_REQ to "cap_perf" which is equal to cpudata->highest_perf (which is 
equal to 255 for non-preferred cores systems). This didnt seem logical to me and I changed 
cap_perf to cpudata->max_limit_perf which gives us the value updated in scaling_max_freq. 

I think as we removed the redundant clamping code, this pre-existing issue got exposed. 
The below diff fixes the issue for me. 

Please let me know your thoughts on this.

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d7b1de97727a..1ac34e3f1fc5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -699,7 +699,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
        if (min_perf < lowest_nonlinear_perf)
                min_perf = lowest_nonlinear_perf;

-       max_perf = cap_perf;
+       max_perf = cpudata->max_limit_perf;
        if (max_perf < min_perf)
                max_perf = min_perf;

Thanks,
Dhananjay

> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Drop lowest_perf variable
> ---
>  drivers/cpufreq/amd-pstate.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 3a3df67c096d5..dc3c45b6f5103 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -537,10 +537,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  	u64 value = prev;
>  
> -	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
> -			cpudata->max_limit_perf);
> -	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
> -			cpudata->max_limit_perf);
>  	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>  
>  	max_freq = READ_ONCE(cpudata->max_limit_freq);
> @@ -607,7 +603,7 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>  
>  static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>  {
> -	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf, max_freq;
> +	u32 max_limit_perf, min_limit_perf, max_perf, max_freq;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	max_perf = READ_ONCE(cpudata->highest_perf);
> @@ -615,12 +611,8 @@ static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>  	max_limit_perf = div_u64(policy->max * max_perf, max_freq);
>  	min_limit_perf = div_u64(policy->min * max_perf, max_freq);
>  
> -	lowest_perf = READ_ONCE(cpudata->lowest_perf);
> -	if (min_limit_perf < lowest_perf)
> -		min_limit_perf = lowest_perf;
> -
> -	if (max_limit_perf < min_limit_perf)
> -		max_limit_perf = min_limit_perf;
> +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> +		min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
>  
>  	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
>  	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
> @@ -1562,28 +1554,18 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u32 max_perf, min_perf;
>  	u64 value;
>  	s16 epp;
>  
> -	max_perf = READ_ONCE(cpudata->highest_perf);
> -	min_perf = READ_ONCE(cpudata->lowest_perf);
>  	amd_pstate_update_min_max_limit(policy);
>  
> -	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
> -			cpudata->max_limit_perf);
> -	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
> -			cpudata->max_limit_perf);
>  	value = READ_ONCE(cpudata->cppc_req_cached);
>  
> -	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> -		min_perf = min(cpudata->nominal_perf, max_perf);
> -
>  	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
>  		   AMD_CPPC_DES_PERF_MASK);
> -	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
> +	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, cpudata->max_limit_perf);
>  	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, 0);
> -	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
> +	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
>  
>  	/* Get BIOS pre-defined epp value */
>  	epp = amd_pstate_get_epp(cpudata, value);


