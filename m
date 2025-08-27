Return-Path: <linux-pm+bounces-33195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDA1B37FAA
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 12:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5840A1B663E4
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3BF34AB17;
	Wed, 27 Aug 2025 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MP55ic5q"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911FD281508;
	Wed, 27 Aug 2025 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289796; cv=fail; b=c9fFyNtNnRtaVJHtkwtRjHK807IW85eLv2ku3cW93YAWvbhvJAY74CqUg9XMdTrmcnffA7DyRxv/fHJUXeYUWwdXsCQ5DNIMfI++JSZyWLtFvF6rWtZYq+6G+DHgAR7Pjb+dDl3TalJOUUbIoM6BCfHO5GfIhqS8g0K4H4Ik2PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289796; c=relaxed/simple;
	bh=4GHBOqzTsqTpFFrce88fW4oSO1+Vh0yUVxOT7bBJcPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N82Uga4b3hLbV6pPoTDMtrj/xqmGFVTG1THyVZZc0wXl7r3F7TgJcKvi4FETgIBfWg3Q/Elp+5F16up4bO2gLCXpuzYDE1olcYtJgihiZLoZtQi+cvqFYsN2O5KN/dTY8FTrWv7V3luVIQ0b+aB+IIIX/8BXt7NX4uRBM5FtTgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MP55ic5q; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bl7I9s78awOLenrR/GFGCKDZAph3+7tV0vNtR28P1WEbdQc5aTcxdUxcPs1SScISowvAJ/9Kr3pIH5hHinL8sNbxzomgVG/H+NOzU9jpAv+GfeSm/gO2wGPrFn//dsoprNAaQxWJbd+V7wIJ7bELUU3/lQNHnqRPg7dsmzozXXtKUTahK705IQecssZPtJEhMbn5ZsNANFYRAwX2lv1Q+ElHr2GjgHvqveXUn9VLzSMQjojthye1qx+MDjDDTSvfFYkzr7tp4RlbLZlwp75TSDNXlSb+Xal2+rDY+32vE4XoU6ruHKD7rLpHlJgqBgJskLNpnex1gWFvL6Z21wgY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZz5xjak69nobmLb6okoUAan5g1d4TStsxO6NtTIkkQ=;
 b=PTHj4tDmg71zo1Dkk7/vYSWT7h6TpETt9wME8ciT/kM/9VPMcPi5po1mtvZ8DG7F6n476fXDiy7Y604YYvmBwRaRgawF9UN92xEtELmit0xEWrvkoXoyTkaCGb9tA2AEzb8oSXQbqwM1rAkCm4FvwtncWuCKJw5QvAMT9vEwgBbLktjKBmWsWYEZlm5XpcmBNe5duJbL+oAG1PPTYcgoQFhSDZGiONvjERtL0tEX9DCG0GuI0jYAEkcGjW8so7r32PtQf+3E3sbAsUZAj9kzpzN3uCPEYu61svTiKTIaxSMEC6wLWx7j+IJPFo1Yrfpdkr3w4OkAtLz7dZ+96dWSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZz5xjak69nobmLb6okoUAan5g1d4TStsxO6NtTIkkQ=;
 b=MP55ic5qExLkM+LdWLE/7ohAnUkJ/te1or7EkX8QNDTfKtj0qO8pVTD2QyJkEYLDK+hVAoyrMTKVKbC+rzpIblzAPZZYirK7QoAWiTdAOJM+MYVCqSmoi1yyRahDbDx2Y5eiJFUxklGGIbLZPlgXW/q7zzwy5KGkHNGwgIQUGlhsgBek3yvDh5Gs4IlvpOgj1mmlx95ELuheEoKJac0UJnrg43VUwlyggjx6zKM0CTKWX+pM7QntYbQYWaPECCsUaVktBeikPtwMFbdc1Zw/V9XdNdN4X4Ul3r7iZtxyYUqD/adSSFtJNNrtXHsfvUzf2sCTNfzdTdJyW6fn/X0OpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Wed, 27 Aug 2025 10:16:31 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 10:16:31 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <luceoscutum@gmail.com>,
 Sumit Gupta <sumitg@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 2/2] cpufreq: tegra186: Initialize all cores to base frequencies
Date: Wed, 27 Aug 2025 19:16:27 +0900
Message-ID: <2748485.BddDVKsqQX@senjougahara>
In-Reply-To:
 <CALHNRZ8SfAZHm5PszA0uCbr0QUYFSkdayVwEwjgRYX2JT0xhfQ@mail.gmail.com>
References:
 <20250826-tegra186-cpufreq-fixes-v1-0-97f98d3e0adb@gmail.com>
 <24066927.6Emhk5qWAg@senjougahara>
 <CALHNRZ8SfAZHm5PszA0uCbr0QUYFSkdayVwEwjgRYX2JT0xhfQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::18) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|DS0PR12MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 00874474-c937-4942-a9a9-08dde552cacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0dGK0pUZnJud01NcTFJekZ5VWhIc3duRi9yVzJKNnJDYURuaGV6bURwRUd2?=
 =?utf-8?B?NlV5YnRUOWxkZlVUTE1HcUNmYmZ6UnpBVFdOV0RmWmdYd1ZWZG94c3FQazda?=
 =?utf-8?B?bk5CbnEzVUYwQmYzZ2ZxLzZoMDlVVTJxbjdvcXlPUEcwNHkzRWV0WG43Q0pv?=
 =?utf-8?B?V01Hd3NIcy93VlF2VTlyMlJwVGR3ZFRBYzJadDBVNDdiTzEzQ1dFUHpnWWtU?=
 =?utf-8?B?MURTTEt2ZlpZV2NLUWhLa29PZnF2M0FZNm9vZjEvNER0MUs4bk5Fcit4eVVs?=
 =?utf-8?B?M0JDNmpBMTl1Uk94Y0lENHlTVnI1TThVL2xlQ3FaOUVHcnRlalY0WjA3QVg2?=
 =?utf-8?B?cEMySTNPVEM4U21MOUVpMmI0RTNpOStzdFJVN3dvRTRlaFRRejRWSTZEVCs3?=
 =?utf-8?B?anFnSCtkazhJaFBPTXozc0JBUHQzWW5UOFR5TVN6ZUVpSkdtSUpzSWtqYUNX?=
 =?utf-8?B?OWVsVEtOWWpVSlFqNFBMU3JzMWlQZ1NmYVlhUktNZ1pLWHl6YnF3VmdDcGtJ?=
 =?utf-8?B?c3ROYmhVK3U4MGIzQWpNalVFMXpHdzRVR3hFMlBmTDVpejNYcGRVUm5RaWJI?=
 =?utf-8?B?SlZRbEZlQWNMN0Y5bHdWTU00Nm8vM241ZERqU3d3N0JtWFNINndNTlFSK05W?=
 =?utf-8?B?NnBvd2dZMGRrejBLNURnNUJMQktiZTRQZFhkRHFkb3RUVUthUld2WVpEYkpS?=
 =?utf-8?B?SkxmOE45V0tuejM4SEdhanZRdWlQYzFqU3NvQVdlSk5ldlRVZHBzNHh3cTV6?=
 =?utf-8?B?cVNFdzEwZTJzU2UxclVIaU1LdHBCdDRxdGRRWFdJVFl5MGMyVVROSnFRU2pS?=
 =?utf-8?B?MWVtd2htQlFOZ0taajByOGs0RGYwdS8xNmwrVERuK1ZnMktIUTE3cHpSM3Rp?=
 =?utf-8?B?T2hjYWdSMk1hQm1XQkFlYmRSYUo3WDFTY1dwbG1Va2lCZnhoSWNNUnRrem9V?=
 =?utf-8?B?NWJOaHJ6aDNTbXE1YmMySlNUaXBtandERFZuWWU3bVZKR21McytqZkJNdVAr?=
 =?utf-8?B?bXNDeS9ESS96UEkyVURmNTZCSHRLRmltQi9XYzY0T1lRQkpnZHh0VkI1WE9z?=
 =?utf-8?B?WVd1UjhOdVo1bWhmek9nTkIweDg1MGlmL1lGdGhYQ3ZOeUtUOUE3Z2N2Z0RL?=
 =?utf-8?B?QVFCdm9kRFYvc2JidnZvbEs5ZEZDbFphQnMzUkx0RjM3Q2R0S3k0WXpLbEt1?=
 =?utf-8?B?QTNYWjRFTlJDQXRTMENrMFE3YU1xTFUzTmFnd2ttV3lQRVZIb0hqUFZvRVlx?=
 =?utf-8?B?bTd0RytVSlNkaDZ1SkpvaGtvdWYrMm9Fb0lidENLWXN4WGkzcTJIZUQ4Nk1O?=
 =?utf-8?B?cTBnM1kwemtIZXFoU3lYNWlPOWlyMW1TNjVCZk1RUEV2Nm1tZ2Ftbm8xRTZj?=
 =?utf-8?B?ckE3dHZZVWZCY2l4ME14NHV0S0tWRUJ6MlR2aHdpYXFtRjFjWHNUbjRJcFVq?=
 =?utf-8?B?WHkrdTQ1aWhWWEl0MDc2SGVnUzRQckVDU3FYeVdEZExDQUd6djhNckhGUllM?=
 =?utf-8?B?R3ZCSENSQmJqckhFWk42Yllmdi9hTlFGMjBiZEtWOW96cnQ1TUlnNVRiNEhx?=
 =?utf-8?B?S0R5dVhrUXhFSjJLU1FDUFJ6RG1ITTJHdDUyVnA2Q0xTWEJCTlVyQVVhbkRv?=
 =?utf-8?B?RU9IblRUNk1RTUhwTlhKRUFzRnhNQUZDUnBoZXFEcWkyUWtEYi9LaWdTeGV1?=
 =?utf-8?B?MWQ3cGkzbmVKSmN4RWlJcU9lY09kZjRiOGNVSmMrWktoK3MzVEYvdlpCUEtM?=
 =?utf-8?B?U1kxY1J0NTdDNEljSUtUamErZHl1dzR0dTF6TllscWRCUlFIVjZaY0NQZTJW?=
 =?utf-8?B?a05NbzBiOW8zSGNQcDFubUhkQkR3dWd1bGlick91ZjhpWE9WeTVHMW85d0gv?=
 =?utf-8?B?a3VSWjRhUzZZTm5BU2lQNDRuRlRVeCtoTk5KdUQ0U0dueUlwQTQ4Nlc5akND?=
 =?utf-8?Q?WYkvRjDmK40=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGhWRVRaRnNmS3I3N1NUTDJwdGE0emlCdXFEcWNMd0VzeHVEbmx4MVlIZmJK?=
 =?utf-8?B?eExpOG8yWmJmdzROQ3NQQUErRVRsbFNSNlBnTW9MTE1SbXU3RTRiaWlxVTll?=
 =?utf-8?B?VGRYNmwzYzhpYnJIcVpuYksxQlcvZVBId3RkNUxqenBuVEsyN2JTcEJQeFBQ?=
 =?utf-8?B?dUtyRWtrbit5ZERUTGMwRlpWa1Vld3Jxclo1clorcVdWUE81VWoxSXAwa251?=
 =?utf-8?B?bmhsU3UxK3ZqZ3lBYUhPQWNybHVxLzQxWGZ0ZGljSExxelArTFBqQ3JZdEhh?=
 =?utf-8?B?UHk4WHhIYXZ4bFlTckRaZUdiOVZPWGNNQnZMNE85TTRWRnpVQ0tGN3JjdHI4?=
 =?utf-8?B?MXlQOUU2Mm5RaUNJLzE5MlRRUSt4OGd6MUJ5YjNQWVpLWFp0d09rSG4xYnlJ?=
 =?utf-8?B?eHNWQ3JTbjJBdHdHdXpHUmpVajVFck9zQmd3SHp5amJlRmN5YjlYdXE1aDBC?=
 =?utf-8?B?cHBGWWtoa1JKMGI0N2dadWR5TVN6cXBMd1k5b2IyNFZIN3ZPQ3JqVlltampo?=
 =?utf-8?B?TXlLc09McDBiQVZxaTNrRnRBVWU0KzY4WGZiQnVGdzc3Mk92OHp3UlhKSFdN?=
 =?utf-8?B?REErVElaNmNrWldGM2FpVnVoZWRFQlFIMklLVmpta0xXZnlZZ2JGSVFrc3ZF?=
 =?utf-8?B?emJLVXpmblg2RkJDRWtNODJoVjljMHUySmIrZkZjVE9lSEhMTEVRYlVpWXBL?=
 =?utf-8?B?aXlkanpUSU5sZzVuL1dSc3JEOVNpUGZIR2lDVysyL1IwTlR5bEd0azU4aUFT?=
 =?utf-8?B?K0prNTlISzBhVWNwMW9naW1RT0NrUkFCUVFZaks5K3RmOVIxeFBUZ3JGckZN?=
 =?utf-8?B?ZVJYWFdGOXJ0YnRVRHcxMTlZS0xMQTR1WGRBZEhpWldPcDR2Q3J0VHVQNE1R?=
 =?utf-8?B?cTFwVDBEY2dQNzJMMnc0N1pHU2UyLysweW8vV2hGSThwTnozc2U0Nlk4WTBa?=
 =?utf-8?B?NFVYV29Ob3lrSUZFQXM1ejdvZm0yRHo3QW4zTUhORGpQNHViSC9XQVJSeUo1?=
 =?utf-8?B?bDIydDVWUmZldFFja3d1WWNnL1YvbDE2eVlkNnFBYmY0S0JaMlF5ZzZvcDRW?=
 =?utf-8?B?OEpEUWtTaW9qcSszRzlvdVh1TmZ6d1JWWmtaNmFNZW9uaHdtY3RzOUNuTCtQ?=
 =?utf-8?B?dDNMcUR6ZHdCRE1KTkJoenk5QVlTc2EyRUdKcVUvTWw2ZnlPWkxkaExUM2Jw?=
 =?utf-8?B?ODIxYVNneWJSeDF4V21QSWQ4OFhFc1cvdnZzaVVJS1kxUnZrbHgxWEhWRVpG?=
 =?utf-8?B?NWFtSExmTkFnSk4zNGtXZHNkZFlmWnhnaHVuekFqM2ZqUFZnZzZ6Ulg4S1lI?=
 =?utf-8?B?K3VUb1FaN1JyMDAzT3RCc2lOK01DTVpGRjg0bGVNTDkrU1lsaFJKN3VyeVoy?=
 =?utf-8?B?UnhlbFMrS0NzaG0wdDErNWplY29aaUYzdkcwYVNMMStYOC9uQlZHcldpeGt2?=
 =?utf-8?B?MGN0VndBdkNNeFZpMW5zQTJrYm1EVXQzV2E0b254K05PV0U0Kys3ak5reGZv?=
 =?utf-8?B?cXNKWHRJdWlTSFRBY3c5TG5idy9aVC9jNDUybm1MQ1BvQi8wRkdKZ1dQZ2d1?=
 =?utf-8?B?cDE3c3BmNnNONi9uMDNyWkhmVlovMGlhR1BlWEw2WTJIellyRjRwVnN0ekF4?=
 =?utf-8?B?bXA1K215aHIxQ0dsQmkwQzZiK3lmeTdnSlpUQkFuVjhNUXRtZ0dXbmdIaW1x?=
 =?utf-8?B?RzBjdHdBcUNIeFdJelRUSnNPaEJ0M2JVTlB0QzVCcEhDMmpqWll5UVlTSVl3?=
 =?utf-8?B?RzJCV0FHaVJwbjNjdWcxbUdHa1dndDVSS1gxb25Cb3dtUzhUMWwrYncwMDdZ?=
 =?utf-8?B?MlJ5cWpIZ2FoZ2dEdWswT1Rtek5IWklka3lXTytUcEd1WElvVHhIQ2ZqVmtR?=
 =?utf-8?B?MmxtcEx2bThVYnJlcy9jUWJpQVFjemwzQ1o1TEsxdUl3TG9vQ2hqMHBqLzFs?=
 =?utf-8?B?ZklTdjJDMmd0UmNYNzBFekphb3hrMU1pUUw2WXk1TUtLQlkwbU9LbEI3cmtV?=
 =?utf-8?B?WDIzWjcxZThCWWtiSmlwdTQxckl2SUNCUit2ODhNU0cyaUYxY2wwUHZXMUhI?=
 =?utf-8?B?YmNjZmlvdDBSZ3dvM0ZSZ01mTW9XakcrMzl3UkdVcEZFR1U3NnIvc2hxRlV1?=
 =?utf-8?B?LzVoNW4vQTZ3dHpHZ2xyUkRmaTBlRFNJaC9GOGRiWHd4R25SS1JIcWZZbFho?=
 =?utf-8?B?L1g1bWxHQndSdzhveXlwVmh6cEM4TUhwVVJYclpwYW0veXdZNVhZZElWbFFi?=
 =?utf-8?B?U1lrUEgwRTRURmM2ZzRiSzQ3QWlBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00874474-c937-4942-a9a9-08dde552cacc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 10:16:31.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CfYTS2Yn4MjnqSX85KRqG1hicv0h48aQGIGhrJdAouqBluNooCmEo+ggiuU1S/WSbc0dFXMM/xWX+hJ4akKiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632

On Wednesday, August 27, 2025 2:54=E2=80=AFPM Aaron Kling wrote:
> On Tue, Aug 26, 2025 at 9:09=E2=80=AFPM Mikko Perttunen <mperttunen@nvidi=
a.com>=20
wrote:
> > On Wednesday, August 27, 2025 5:16=E2=80=AFAM Aaron Kling via B4 Relay =
wrote:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >=20
> > > During initialization, the EDVD_COREx_VOLT_FREQ registers for some co=
res
> > > are still at reset values and not reflecting the actual frequency. Th=
is
> > > causes get calls to fail. Set all cores to their respective base
> > > frequency during probe to initialize the registers to working values.
> > >=20
> > > Suggested-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > >=20
> > >  drivers/cpufreq/tegra186-cpufreq.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/cpufreq/tegra186-cpufreq.c
> > > b/drivers/cpufreq/tegra186-cpufreq.c index
> > > 6c394b429b6182faffabf222e5af501393dbbba9..ef288705f00b0918d0f8963ef9c=
c9f
> > > c53
> > > be88091 100644 --- a/drivers/cpufreq/tegra186-cpufreq.c
> > > +++ b/drivers/cpufreq/tegra186-cpufreq.c
> > > @@ -229,7 +229,8 @@ static int tegra186_cpufreq_probe(struct
> > > platform_device *pdev) {
> > >=20
> > >       struct tegra186_cpufreq_data *data;
> > >       struct tegra_bpmp *bpmp;
> > >=20
> > > -     unsigned int i =3D 0, err;
> > > +     unsigned int i =3D 0, err, edvd_offset;
> > > +     u32 edvd_val, cpu;
> > >=20
> > >       data =3D devm_kzalloc(&pdev->dev,
> > >      =20
> > >                           struct_size(data, clusters,
> >=20
> > TEGRA186_NUM_CLUSTERS),
> >=20
> > > @@ -257,6 +258,14 @@ static int tegra186_cpufreq_probe(struct
> > > platform_device *pdev) err =3D PTR_ERR(cluster->table);
> > >=20
> > >                       goto put_bpmp;
> > >              =20
> > >               }
> > >=20
> > > +
> > > +             for (cpu =3D 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++)=
 {
> > > +                     if (data->cpus[cpu].bpmp_cluster_id =3D=3D i) {
> > > +                             edvd_val =3D cluster->table[0].driver_d=
ata;
> > > +                             edvd_offset =3D data->cpus[cpu].edvd_of=
fset;
> > > +                             writel(edvd_val, data->regs +
> >=20
> > edvd_offset);
> >=20
> > > +                     }
> > > +             }
> > >=20
> > >       }
> > >      =20
> > >       tegra186_cpufreq_driver.driver_data =3D data;
> >=20
> > Looks OK, but I think it might be better to set the frequency to Fmax
> > instead of Fmin to avoid any slowdown during boot.
>=20
> I considered this, but I'm somewhat skittish about setting Fmax by
> default due to seeing instability across different tegra archs and
> finding out that the t210 devkits have been factory overclocked on
> mainline for the last six years [0]. That may be less of a problem on
> t186+ with the bpmp having more tight control over stuff, but... yeah,
> I'm still wary. But on the other hand, I set performance governor on
> boot for my android builds and have not seen any obvious cpu related
> instability on p2771 or p3636+p3509, so that might be okay. If you
> still think Fmax is better, I'll update and send a v2.

Yeah, I think it should be fine on T186. BPMP is in charge of managing the=
=20
frequency in the end and if this causes instability it would be a bug in BP=
MP.

Mikko

>=20
> Aaron
>=20
> [0]
> https://lore.kernel.org/all/20250816-tegra210-speedo-v1-0-a981360adc27@gm=
ai
> l.com/





