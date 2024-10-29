Return-Path: <linux-pm+bounces-16637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546EB9B41AB
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 05:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A841F23AAF
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 04:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940231DE3C6;
	Tue, 29 Oct 2024 04:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FB3iRZ0b"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C62FB2;
	Tue, 29 Oct 2024 04:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730177870; cv=fail; b=k3MW9u2PNwV2msNVNMqrumgkCNGXLeSjdFF9RBayYRGelVcusYYuZakSXjPwe4NFzth8yKSwybfQkoplfYivSb9K3rShHlei2BokNR6pkhaLvDNDunazny92Nm0faYESUDraPfxR2GyeIRh3mI1eZutnWBivKzdwtMkIziYft6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730177870; c=relaxed/simple;
	bh=ydAZjChxBuA13d6ZAH5sBzliBbAkkz/fBbEAxWnnfiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T1fk7+zlpwpg6Y2znHpdZLiJ7eNSI6MUDeJzYrdnIsGOyUYSSwHxbz5WsQx4GdUv3g0McNEZIP5B5+P0/mF0mIM4tdm15RJr5g15MnosC8OHs0CUJ40dTQ325hGHvGDKw9D/afgtgPYqNTQGs8AqLaKe9ZmA9X0319+0Af88usU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FB3iRZ0b; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mz1zN0o4mtjBRGmBX3euXrVTiEMm5EHf2xP+6mK3GxJqSPFCN5qa5F4HH8xffItykm8JgNR8SJAt93S0ZSs6NwMFgV2e2d8iVmx7PQ/CSGxZuz2KMtN7aynknDj25g4/O6ZgZee+7Gb2oDX1mQo0WFTaoBtBOr//JOi6qlyDnyvbqYUBt9Uv6TFdfDpXc6L9rrI5tMwN69PORoX5GaMOGOr+01lS57ooX7Bk9HnkYUWeO5AlZT7I4cSUQRgodRkzD8O18gAGLY0mE33T5e5BpH6F0RdcusnwBpJ92aY0gxT7eAVax/rR9bOBdjAph/oXTpECe7VYGlo5C7w6aAD1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSov9kThoTfxbz9Tq/HlQJWjTNoBHzEj9W8YLxqgBxs=;
 b=dO8DMikq2sGqLg876MaoSYSlRoX0naQ4eDPcD+z4neruW75owFZVrxcY1Y9yBelFxYwwLZuEQ8wisy5+xBSeC9KXJGKp2YJGUnWJGWPTHQXSm5Dun/M3tG03AsKRZCmtg08td8fEvLttURoRDuGsim9TxBZpca+sHMmOq0VjYrwRgA1hhagjIZmViboDIQORnEoeqDepZjqm4/Owu+vaN5mxpJayjXgyVM9IXlTABMlVYNM5wx9i7HsLcnnEQ78DTIqmBKV5tdQ/9+qHt8xVg9zDGN/+jHd1md6s78SCX6Tv5Lez3KUho1lJ75Dh577hhSODIWzrcjlpEzL2eiuqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSov9kThoTfxbz9Tq/HlQJWjTNoBHzEj9W8YLxqgBxs=;
 b=FB3iRZ0b8Kir2kgT+hAMaiznjgEO1v431kFppNawufN9NvuG/yoPuWKbWIs02a6FCFe0/2vl1VArbCOdcGg/dc1SZlYnSqQXtBMAdlit2yL+zDlNX1aKMlGhx7TZWtU+IXWsccYrZPP+rMnZo+z7OakBw4xVYYDZ6YYUEa9Omz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 04:57:45 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Tue, 29 Oct 2024
 04:57:45 +0000
Message-ID: <779c6cbe-8c59-4326-8fbc-99889a13d204@amd.com>
Date: Tue, 29 Oct 2024 10:27:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Move registration after static
 function call update
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Klara Modin <klarasmodin@gmail.com>
References: <20241028145542.1739160-1-superm1@kernel.org>
 <20241028145542.1739160-2-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241028145542.1739160-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:54::21) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 89666163-8a8a-4096-3905-08dcf7d63a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHVRWmxFMTFGQjMyZFRCNk5hWE1CUE5uUThUWVNiTHY1VXB5RUNlbzVQNE5V?=
 =?utf-8?B?cUtGa1ZhS2RtSi85QWVmZUtYYkdVVWNMU1BTTFlscnpWYnYxZHM2WDRQOXpr?=
 =?utf-8?B?TCtvQXhMbHlteUNrNVp4RjB1YW5xMmdpckhqSExpVVF4bjM2NXJxK3Nxamd6?=
 =?utf-8?B?TVJGb21aaEh2alM3VXYwdGhEVHU5VUpnZ1NQLzlVU2prNVRPWGZhWVluQ09a?=
 =?utf-8?B?eHJxTWNFWXNrSFZFOVREYThOZ3A3TWlmZFp1Rm1xNDU4TEx2RW5pbkoyVnpn?=
 =?utf-8?B?dUZ1REpuKzZnZnVsSWwvUGlQVW9tR2hBdWlkekhnMUFCa3VWSkVVclY2ZEM2?=
 =?utf-8?B?M2ZONC9kdWt2bVZmS0lHZTQ3eS9aanJ0NURkOGk4d2kwVzZjbEl5cmNCVStC?=
 =?utf-8?B?MEhVQTVqKzFtNm9LbnBMNWR5L0gwKzl0VTRtRDArRk9yNXExSFFhQ1V5NXVP?=
 =?utf-8?B?YVAwZ21YUlRlb0R2WGNrZ01ST1pYK1FsMHp5cDhFYjNmYnVMejVtU253WUgw?=
 =?utf-8?B?R2RwN2xTVnRtOHFuZktBUkhSR0NCT1g3ajF1NEZEcHh6S0lZUFNrL3Voc1Nv?=
 =?utf-8?B?R0x4aExiK1NYaDJHbUh3SVZObEwyeWUyYjhFQ2srTU1UbnQxWTMxcG5ZdXVX?=
 =?utf-8?B?bnJzWStiV0oreklKYnNacEhXZTlkYkhKSlJoSHlQUGJTSkt5TmprUGllZFdr?=
 =?utf-8?B?WlZtTEtOMXhVdXp5aldqaFN0U3NJQlBLOHFyYnNiR0JiRnVFMzQzNHBqUnFw?=
 =?utf-8?B?Snl2UUZYZlMxbUhaWTdjUlR1ZUYvbXE5V1lwWkxnandkZUhmbWdGVm5JdldZ?=
 =?utf-8?B?a0F6UFdKM0dCNFNKVGdERlhINUVibVJPdHdwRTl0bmtiNVNBVklIS1BqK2Zh?=
 =?utf-8?B?MGFSZ2RndUZrTGU3TWl3aEJHSFducFd3a1VvOXE4R0lUSWEzRjNIYmVLeVNw?=
 =?utf-8?B?Qjd6MHRXRVM3SXBFM2M3bmJ2bGNLMktzQW9FSlMvV3REZ1NqZ3JQYVpxSytX?=
 =?utf-8?B?bDJjZkRoaFNJNk8yR2hjcGQrMng0QVVHL1QrWnFPRG9kSFJkVzZrS1VnVEN6?=
 =?utf-8?B?U2krOXhabGZHY01PbHRGSzNqOUJuRzE0SmNaZVhNYWhBT1pneENrMms4MVcr?=
 =?utf-8?B?b0tqcjRyMUFLODQ2UGt4N3FsVlpla3BhMWJLNUxzRmx2WkUvVWlzMGFOc2Ux?=
 =?utf-8?B?ajVoRTlhYzZEY2c1UytjMHB0Y0RRQkwwU1ZzeXRKZlUzUThnUW5WSVMrQkh3?=
 =?utf-8?B?Y2hkUWZ1SmlpWFhVcTlicG50V0VKS2JoNjdZODkzOW8zUWNHMURIdU1kTjdB?=
 =?utf-8?B?cXFOeldzOGxTek1WY0dMNkFoYlI4RUxha2g4NTRBdmNQUkp6dy9KQWpXQk5F?=
 =?utf-8?B?QjVOdlZHMnkxYWg2SGFxOW96bWd6QnV0cXNwd2xaSk10SEY2ZEhrc2t5WGt0?=
 =?utf-8?B?dFZGK011Z1lERlI0TkpMQUoyK2FuYkNCSzJnMDRPMVRCeS91aHhLcTNIZ2hF?=
 =?utf-8?B?OGpCdzFPNi9meGI3VGRtbXhWREc3MVpSTnFObHVTT0JGOUMxYkFVbDdISnBD?=
 =?utf-8?B?YWRNYllNWk5qdzhVZGM3Ny8zbVZkMWFmOEFBQVJlV0NXa3VoQVZKcExXV0lL?=
 =?utf-8?B?UjFNUTI4cWFOOXEvL2g3RENTRTZuYkFtalg3R0I1YmYvL2FkcE5saUE4SmNt?=
 =?utf-8?B?byt4aEpSUmxPTUoydFhTUk9XY2Q2Q29rYnNuVGV3MFVVNWYxV2pwL3l3MHJZ?=
 =?utf-8?Q?V3BPGAMJFkJpyFlZbWUht41ktgrIWSyIFFL9kSv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THZadXRiY2I2YXh1Q1M5UDNScXU0a1F3d3h5V1E5VExwZWtUWTE4S1lyQmd0?=
 =?utf-8?B?cXlkYU92dVU0Vm9nNHZkdUJWUi84WXdyeUQ2NzJYMXZ1QUhXMzJNdzN0RWJB?=
 =?utf-8?B?YVpucFNZWk1YTUFGdmlmWmpxVi92N3Q5UW5aZS9zejNmUDljalJGbGdtN2xU?=
 =?utf-8?B?S0tJWFBvY2lNbHJlNUNJa1A4YnlacitxRFIyaTRTSEloOUVOQXhVVDRGaDBY?=
 =?utf-8?B?Q24wbmFibm5UaWxOWlpibUJVUWY3VXdqZEtzN1lNbmZwalV1VzVNb0xuRGdi?=
 =?utf-8?B?ZDFSV3N5ejNCM2s5SWltbGRuVUZla1k3NCtzaENybDZGYWZKR1U5bjVKbEZB?=
 =?utf-8?B?Nnk3eU5vb1FaWG51NFVkcUpTWVdCeDBkV1EvcUdHb0FTeWYzSkZxYWE2aUZB?=
 =?utf-8?B?b2c4RlRUZ2FGRVZtUytaTnQ3WGtSejQ4QmRSZXZaVWl1d1UyeVNSRWI0VWh6?=
 =?utf-8?B?L0p5RjJyV3pvd2VEQXR1QXJTcG83TGJUU0MvSW1xeFhPbEwrODhSRkE1ZEhR?=
 =?utf-8?B?M0tnYTBmSGRYWkRKM2cvTWxFNHQ3OUorV3dJd3lleEpQTDU4VUVaSXRsdmVN?=
 =?utf-8?B?U1NEcnN1REFvUkF1VHhlK212N0FFUklYc3A3TXUxcXNmTEMxVnJ1czNhZEps?=
 =?utf-8?B?ZDh0TVV1L0ZrZ1poM2pQTXVhMnFhWFJIZnBtOFl5RzVVSndNSHNMNTgzUU1z?=
 =?utf-8?B?UW5QSlVmdExaSVBVak1GMjJpSENHSU80empuWElBQWNtZ2FGN0IxQ3FDbVBK?=
 =?utf-8?B?NE1icGJTYzF2dUFrdEU5MWRzMW5nU1hNQXlOSXVhTHBTTjFKbkVVRVZubVFP?=
 =?utf-8?B?Y0ovbk96UVN6R01Eb1hnb25GKzZabVpPZlBuaHVkVy92dlBzdGgyY0JNbFJ2?=
 =?utf-8?B?a1liaDlLN1dkbTVMZTUzYjA0bDAyNnRtZnM1WHFMaWtrMVlKMjZob0ltcWR3?=
 =?utf-8?B?dE1NRmJVWlppb3hBQnFhZ3Foa2JxR1pRNTJEaUFTUERBZGtPbzRZdmxhQ1da?=
 =?utf-8?B?dEROSUJpVVFBMGxoNHFtdlhyRGp0QlJPS2d0NG43TkJXdlQ1WVFTWkllZG5X?=
 =?utf-8?B?bGlkSFNjTkx4MGNieDZzb1hxTWlNT0UrVHBMeS96VVRqaWFsaERWenQzWEl1?=
 =?utf-8?B?OXVzUTlhQmZXcXo1ZjBxSmd0TXp4eTJCSnd1RzZ1OHlOZFhJbzIxVHJZWHVN?=
 =?utf-8?B?M0sxTjBJUFRwemR3bzRSQUh4RHZWdWJ1Umo1Nkxoem9nc1VCS3d4ZmJ1MXUv?=
 =?utf-8?B?MjY2M2puZGl1ZmxQVWF6dWo4Nmw2aFJtcGVIR3ZtSnRmcXozdVRsWHEvQmNi?=
 =?utf-8?B?OHBza1dIREhTemY4a2tzdjgvZGFiQlFmSU1paG56c0d2YjkrUVhkQ2FYU08w?=
 =?utf-8?B?K0M3QUpVb3ZBdlp6TjRZLzUyUzU3aUcxV3JDeUpRc0YzeEVRSTdFUUhZMEFZ?=
 =?utf-8?B?QlR3Y25raWhUUGpjSDdoMHpkYXU3RzIzcktwUlhSQ3IycUpjUVNjcFZuTEcr?=
 =?utf-8?B?dEFIMGRVTHpIRWNPSm5Wb0UzajVxemNqZWxiaFVtSzZMU0FrSk1jb29POW1P?=
 =?utf-8?B?cXpYMzlDOTBxMXlrN2pFdjJuUjJPR01JdS9wUkgzYzhEODgzY0xaSHhCdUpZ?=
 =?utf-8?B?Ty9OMkNxeDhVMVgrZE45Z29WdllIVDQ5MmZnQ1llaTlmaE9qcWdvL050Y1Vj?=
 =?utf-8?B?SU4yTkU1dHBKRkViQjMyTysvYzVHRlZpQ0EvRlZuT252V0RmeTkrSXU4OGtN?=
 =?utf-8?B?SGI3ZWxuclhSNGdTMTY0c0t6QzBrMFo3OWpjVWo0ZHdZNk1NVUxOeGVnaTM2?=
 =?utf-8?B?RnU3NnA4OEp3Qlo4U1EvKzdqV00xOVBWZEU2dUFMRXRvbERnUC80Y2dhWUZs?=
 =?utf-8?B?Q0RxSGxJdjZnSFBYa2ladTBhSlo2dFQ2eXQ4Q3RWdlQ4TExucndvb0RlcU9a?=
 =?utf-8?B?eHcyREQ3THgxK3p1dTNhRGkyNkxPSWN2MWJVUGQwMVpkUkJHU0JrOW9VLzRU?=
 =?utf-8?B?MllidEZIZERCa2dRQnl0dW5SUlA4QVJRWjBBSFp0WVhtdDRXczg1bjJrMDNo?=
 =?utf-8?B?aXNvYjlTQ2dKMTl3a1h1blZlL1N3WjJkMXJTeW5yazJucVlHZy9GSmpnMUQ5?=
 =?utf-8?Q?GUt2u6/CRrQR4V5ACmD5AgMIz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89666163-8a8a-4096-3905-08dcf7d63a30
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 04:57:45.4399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtEfBM/DZKpI2yjQ7JyfN5GUrBHkbvbjImqQcQlC4YqZQwhvalyaTwcZtbkzNlNw3lQbl/4jKIM/Aq3iKdR1Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801

On 10/28/2024 8:25 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> On shared memory designs the static functions need to work before
> registration is done or the system can hang at bootup.
> 
> Move the registration later in amd_pstate_init() to solve this.

Looks good to me.
Also, 
Tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks,
Dhananjay

> 
> Fixes: e238968a2087 ("cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver() call")
> Reported-by: Klara Modin <klarasmodin@gmail.com>
> Closes: https://lore.kernel.org/linux-pm/cf9c146d-bacf-444e-92e2-15ebf513af96@gmail.com/#t
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e480da818d6f5..f834cc8205e2a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1859,12 +1859,6 @@ static int __init amd_pstate_init(void)
>  		return -ENODEV;
>  	}
>  
> -	ret = amd_pstate_register_driver(cppc_state);
> -	if (ret) {
> -		pr_err("failed to register with return %d\n", ret);
> -		return ret;
> -	}
> -
>  	/* capability check */
>  	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> @@ -1875,6 +1869,12 @@ static int __init amd_pstate_init(void)
>  		static_call_update(amd_pstate_update_perf, shmem_update_perf);
>  	}
>  
> +	ret = amd_pstate_register_driver(cppc_state);
> +	if (ret) {
> +		pr_err("failed to register with return %d\n", ret);
> +		return ret;
> +	}
> +
>  	if (amd_pstate_prefcore) {
>  		ret = amd_detect_prefcore(&amd_pstate_prefcore);
>  		if (ret)

