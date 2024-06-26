Return-Path: <linux-pm+bounces-10029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D8A917A8B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D1E1C23A94
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 08:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE0616190B;
	Wed, 26 Jun 2024 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d2vFYUmK"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB753161313;
	Wed, 26 Jun 2024 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389450; cv=fail; b=n0xficG5tRJahri6lod6shJfeAM43sdGq5OOpzZouZaSO68RWeRpLuPJDhiBck9TrTNEL+mToSUw7dgkmyjnhiLpAukvIDYipuE3CNWqMgewxapu8wg4nTrddUuKPl6GXZm9/f0oAchcQJm4jGZXrbVu4rFCv51UVtFOcb3N9eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389450; c=relaxed/simple;
	bh=Gvpqvtx3fCk3D2N/KuomuF1w763cU7fLY1D040wOcNs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UhgepoZ4zsbpq9EdKr5sKs9c9FP3S7/CbFMfdhgndhrOyEQCepNhN9zJvfhV8wzkMP3T/pjoaBGRDv5SYO4puqRwyArWiXpyxqnxmk8ZIEx0agM/cwJI6rjNrWJZh3XFUJ0/gXHx6l92wyoNynR9oqd8nhL9XeDbGRQewZTo31M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d2vFYUmK; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfyxpJr3/WYdjNkj/mCxj0rYLKdCIR/4iBpnetHglsQ2iln0GnE1310ZTU6RjbDmIdxjg5cLBWmPyn49cM21hjQ/92KEa+xzo9EqK1AZ5JYcYZuHpkbGFz0JEeDrOW2a8kpXyOJEsxdpd5kbTURim8iVc+4V/rsWsbGzRBLiiBPt73OZr1rOHgRdhdP6LxBGZ2ut1Bmh39m/yJ+W3GVtq3VlAsskFu8TnfUUzr99nmInQZFA3sUMV0i/TtS8VoLSKxhS/cOAr2/Ragf2hFHmaleOKAF4BG+f1zribHuaKCZ78TNJ3560Vifgg+Z15Sm2fW0k6W6jsgac+kWOpPwUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb3Cfbs+0+PrfAK1esrBzjrX1gV2bYSs+4O40Q8qiq0=;
 b=J6sXbTVEGeSbvJWGmex5BLKyn41VyaM3qVbOUuq4RSBxssWJdTO+nNtmHjASFBJtzMWvydMhuSul/KMH/a1P07eRGCPDOw+e9ZaANQayuFLIhihA9N7zAzwsQ8G9I7YONSvDuMEFp1bJyMPqfb2wCLdZ8veVmI8EOzfQ6KgMCO+yyzIFNbkhEe7j+rNtgCzbeFUenmdw6OHb/l3awI+CBnMCyYPxcCORHvhV62+q8W1w54nWN0QBr9ZUP1rJ8FuGLRTejoocQXR5qsGP4NWBdTqWEJ6XxV8AqNGkLhg4VcT7v3hTLEX2dY2/eumj516eglUiBb6SyhOhagdQddvLNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb3Cfbs+0+PrfAK1esrBzjrX1gV2bYSs+4O40Q8qiq0=;
 b=d2vFYUmKgkIenzJ5KRflj1LBGecGcyqe5cCKw/sPN1eCYKkg5SZD3RTX0MHbAUPif7kUk7StXzXY7S0+VJElTbM57mjmsR4ossL8Zrn1fnpfI4DeMv4WQnIEuTJiyJMkfZ5PC5i3q3il1iGbJJwKCwnGYihP0IneuxfeIS4Y6pM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 08:10:47 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 08:10:46 +0000
Message-ID: <c13b1b65-dd04-468b-a5b8-71d3ed4ff2bb@amd.com>
Date: Wed, 26 Jun 2024 13:40:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq/amd-pstate: Fix the scaling_min/max_freq
 setting on shared memory CPPC systems
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>,
 Perry Yuan <Perry.Yuan@amd.com>, Meng Li <li.meng@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
 <20240625134127.4464-3-Dhananjay.Ugwekar@amd.com>
 <be834b5a-508e-49d1-b608-62192cd7bdda@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <be834b5a-508e-49d1-b608-62192cd7bdda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::13) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: b59616d0-f47a-4c2a-96de-08dc95b77b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3RKWi81bS9sVnJXV3dBK2toU1lMcWd3cHVZMFhxYm9mQlhRREp3bldvNlZa?=
 =?utf-8?B?a3BrdGhocnNVeVJXUTVWQXJXWjB6U0xyeVREaEFKTDFveElUcVdXMUhnY1Bw?=
 =?utf-8?B?bkRKRFFzVUN2aVRsTDQ0VlAxS1dHdkhXcVdhQ1ZQQlF4d0ZCaStmRHMrbWFo?=
 =?utf-8?B?NWdTRzlGR2RuaStqU0xWR254ZjZXUFRhYm0yUFd5TTZLRkFZdXoxNjFkTnJM?=
 =?utf-8?B?dkNlY1lKbTJTVkFEYnozNFozSjBMekpPM25PdXMxT05LcXl6c09kdmxkM3Y1?=
 =?utf-8?B?a2Y5Qkc1UjgzSVp1UnkzbERvMGVpTUtNY1U4dHJJZUM3YU5LSjFTaXovU2JI?=
 =?utf-8?B?RitWem1LaGhDY2h4Y3NYakpPbUdNMEd0NUZOSFBiWWNJOUpqMEJ4dU9SeWkv?=
 =?utf-8?B?T3pWT1ROcmorWTRRMTFmd1FHNXBkb29scSttVzNYYWw5cFg2T0pWejFOM0FV?=
 =?utf-8?B?WlRpQjNXeENickgyR1pBaU4weVVEbDYwNGxEQXFjT21kcjd6Ulg1YlQzdDFk?=
 =?utf-8?B?bytEMUhzemorZjIxb0d6bmxGekZBVGNZTzNUYlJJalE0dDd0dWNQbW40QUtD?=
 =?utf-8?B?MWxCWmd3RVlZVXg0aUNuZWMxMmhpWlI0UFdST0JsTDlwbjFIaGlHdGpxVWs5?=
 =?utf-8?B?WThOa2doOUw4ZkZBLzJRVHI5R0w1MmlrYmhLa3g1R0l4TWRObDRteHovd1ZX?=
 =?utf-8?B?MzU1VFJCTm01RzIzUitFbGxRM2Q4TEN0NS8xQmpvOHhRNEVNTFNWenlyOW5B?=
 =?utf-8?B?SXZCVFBqc0RJQzZBZkVqemxwM2JuVkFzK1dYQnhnem5TNEt4NUJtMUlsVndL?=
 =?utf-8?B?STc5WGVGMk1mRWVlOUhEK1JKSjJsTEo0MHRJUjJNK04xZGhoYmpqYm5kTkpG?=
 =?utf-8?B?MHQwQ0NnRjgyZjdYd0p1YXA0NDE2Wmh0dXlIdjlKT1FrS0FMTzlMMkFBMGRp?=
 =?utf-8?B?WVRvR3F4cWJhdWx2Yk4yQmwwS3BsNWhYVEEvTitKZmpiUTNFKytWaTJNNmp6?=
 =?utf-8?B?ZndYVG85UE05ay9IUWMxQ21jQ1k3dUMyVENBc1l0bTJVMnNRampHalhYaWJq?=
 =?utf-8?B?MDRxaDRCSHpiQU45SW9kdUJMY0lydWtJUUxtZVd1NVc2VitXQ3J1STVGSkFR?=
 =?utf-8?B?M3NNTHZ4czczdkJ1aTVKTGJNQS9JYytxWWpUUEZHM3I1akYwelFpM2U0Z3FO?=
 =?utf-8?B?NVE0My96OEE4dWdaMlRwYzNta0xaUEtSOTdrV2JVcVpPM2FOcWxJRE9YbGI3?=
 =?utf-8?B?dkVUSWhDUXRmaFhwN2NpN0pXZDJVUDE3YzRzbkdpOVdKQ0l2MmhpdThSQjV1?=
 =?utf-8?B?cmg5RGIrYXZnR1hGdmtENXQ1S1EySXB0Q09SQ3JDTjRnT1RseTYvT0VYTjVW?=
 =?utf-8?B?ZnRUNzF4L0paMm9sK0FXd0kxUFkyRHlXSGZxQWI0MGJSV3BLQ0tqMEIrT2pU?=
 =?utf-8?B?YTl2OG5RMlhlVFNleTEzbzRNRVp1NThMMUViZkhYRjVYS2V0a056UWRmUWRk?=
 =?utf-8?B?Qm1uREtsa29jRGo4OEsyQmJVMnBVSkI1QTB4K3pHZVVldm5PQXVWQmtzekNa?=
 =?utf-8?B?bEx5U3JOL3laUmNUa053VTFaY2lRNExtZ1hWNmI1ZnEwU3hGajNsY1E0YzVE?=
 =?utf-8?B?NjZ2M1FoNkVKTVFzRklIOHljYm1icFVLQVNnQjVvRndxbGtkc3g4dDRtVDl4?=
 =?utf-8?B?cERkOWJGU0RHajRlYUZJQnZ2cUxiZ1ZkdFE3WTZ3bXVYWUtIQ2xUaHBhcjZQ?=
 =?utf-8?Q?IiosNus+RqOA6SE/gY6Mr3RVhy/1NycIc+8pvKB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blppUlE3aDhQVm14RzhiZ0JLTTBBS0hKRVF3Z1Ezd2syUzcycUFjL0c5Sm5z?=
 =?utf-8?B?K1kwckMvd1UwTExRcEtvU0YvdHZsMWppSFpzb2VUWDMydURJZVFIckhXV29F?=
 =?utf-8?B?Mlo0enVFbW9GZlU5dmdqVytHSVRYVWRVbGpXV0pndlhDWlRmVExzVFIrMUti?=
 =?utf-8?B?L0ZlWnY3VmNSUUo3Z0hqRUdwVzVZZ0lkeThobWYxYXQrSm9UdFZWOGdUYjgw?=
 =?utf-8?B?elJ6cUEveTBLUncvOGxJd2pmVGsyczloeFZUak1uL0VWYXFpbVpvczBGL0RD?=
 =?utf-8?B?OXlIRHBEblVVME0xKzB0ZlA3S0haZ0JBZC90YWhRK29GdU0xdW10QlM3d05j?=
 =?utf-8?B?WHh3T2hQT04wWktDY29xdWQvUWtSRDRsMG9xWlhlTnFMWStuNnMwQnVoZ3Fu?=
 =?utf-8?B?ZmlXcGY4YVZMMXRhNlZ2RDVLcFFRVDRZVHZlQTFidk5sWUlYa2pQOENYSURX?=
 =?utf-8?B?TzJhRDhqbThyc09zZlB3WUJkVXZiejVhTE1hWEFmNXhYTmptbkd3cU9jTWRL?=
 =?utf-8?B?bVY1dG15ZVJQRG5pRkpvMWJLZjJEcTBraVA0c2h4U21yR0VHa2ZEa3liRXV5?=
 =?utf-8?B?bjlMMkd5TXZGN1FNVlNpNXVmTGE3R3NYZXlES0k4WnZCdEg3UGhwQUFxQjJZ?=
 =?utf-8?B?SHFBeDA1c2lSR2xsM2REcm94OXJhV0NpS2dIT0kwWHdidFIzZXA0ZDNMMEF6?=
 =?utf-8?B?QjhKSjVObGhDV1ZjOTcyM3F4RUVLL1pYanhDeEY5YS85b3hYRW9BeDdkOU90?=
 =?utf-8?B?c3NBc3lyZ3F0KysyOEVOUkl1STAvVGxlUjNMMzlTYURHcDhaOTV3dFhCYTJF?=
 =?utf-8?B?dXhXMGl4RStaRXFHMm5QU1pHeEgxUDlWUjk5MzJQQkZNT2gybnh5R3JDVEVw?=
 =?utf-8?B?TXdkbFhaVXc1RlF1WlYzUkRDellsTnRDZXJmd1NaMVNDMThFdkdkenE5Qmpx?=
 =?utf-8?B?U3lNZitSbVdrSmY4NUpJWlgvdFJaZ0gvZkxBMUJiTnJOamhha3FWV1ZoZXRi?=
 =?utf-8?B?ZEV6YVZUQzdmT1RNK2N2VmRYWFE4ME9lSkh4RytPL1ZlbFp2SHo5UzE2Nkp0?=
 =?utf-8?B?VjhvajZCQ3RBNXVCU1gwVnFxNGdLMTBqWmNxbzRiTGhVS2YweFBKeTZxa200?=
 =?utf-8?B?QUNBMVZXR1A2Q1JoQmJMTmhQazJleE0rTnVjSW5DbmFQQmw4OXdJZkREaFFP?=
 =?utf-8?B?TXBqakZWMVFiMXVIQStHZGYrTEZtYTRNU21xRWdpMnZibkkvUytzTENQQzlZ?=
 =?utf-8?B?ZEpzVWluSVROU3pCUTRla0U2cWtOcnNud3hjT1RvTnJLYUZUMDNSeUhNMGR0?=
 =?utf-8?B?V3NUMlA1ZHVxSmw0VDZQQTRXZS8ySG0xOUIvYjNHNTV3dHhFVHYreHRIMlVz?=
 =?utf-8?B?SDVzZXRaRjRHbDlSampDUTBKN0UzdEJTNXhlMkU3dzhndHlVWXFFQ3J0UEsy?=
 =?utf-8?B?a28xLy9rSUZjdUlqS1JubEFYNDViWlBrRjVlb2s1NUY4anNPaXhaVnJvd1VM?=
 =?utf-8?B?SEhXOWQ3UkM5M01HcUdTUEpuZjZyZjFGMlAwK2IrVlUrT3hCUk80cmVTU0xx?=
 =?utf-8?B?bHZMRGJBd29lVnpIcDViN3BSWUI0YmJNL0ExWVVLdDA2Ym9UWVF5WTh2WWQ4?=
 =?utf-8?B?Wmx3bnN6V3ovS3pWM21zaVFsY21qNjNmdWlSenorN2VBWEE5Sks3WkszOElw?=
 =?utf-8?B?UXZnVUtRK0UwbXBwQVhUQVpXa0xmejhHL29DcUY3c0hlcGlheVJBZklkWENB?=
 =?utf-8?B?T3NLM2FXODgzUnAybjhrd3lnMGc5L2Z6VVZvME13bmFKS3pHREJVdHZxYmgx?=
 =?utf-8?B?MXg4eDJtTmZtWWdETU5OWnMwVjhDUTVETmxBdERrNlkvb2o3aWRMd0ttN3h6?=
 =?utf-8?B?cytUWTB5bnFxY0oyTmV6ZUtQUkVZYzB5Z3AzT1NrZXlOQUdheEZSWEhUODdF?=
 =?utf-8?B?MmRReUNCVjVId3NzS1VmNUZaRDMwY2Fhb3IydndpajJIbWV1MWMra3lHNkRQ?=
 =?utf-8?B?VmhzKzJJTHo5WEI2a2tHL2pJUm9leVBXQkd5b0p4dVhFNnR6ZmRBU1lJMjJl?=
 =?utf-8?B?L1pudURKT01jNC95ZHFjbUg0QVdNTHVCaWU1OFBIbnA2QlFLUlplbWx6WC9a?=
 =?utf-8?Q?OWH0HsDvw63ocE0xoofjDCuTa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59616d0-f47a-4c2a-96de-08dc95b77b9c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 08:10:46.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyXFX5lqJC/dX3F0+o2HPFH2j5k7wYd8X9aN9Egm21nxn1EzhMpxaM633nbVfJgcJKe/PHqHbicbeEKp214wwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103

Hello Mario,

On 6/25/2024 8:39 PM, Mario Limonciello wrote:
> On 6/25/2024 08:41, Dhananjay Ugwekar wrote:
>> On shared memory CPPC systems, with amd_pstate=active mode, the change
>> in scaling_min/max_freq doesn't get written to the shared memory
>> region. Due to this, the writes to the scaling_min/max_freq sysfs file
>> don't take effect. Fix this by propagating the scaling_min/max_freq
>> changes to the shared memory region.
>>
>> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 9ad62dbe8bfb..7c1c96abe5bd 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -264,6 +264,15 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>>               cpudata->epp_cached = epp;
>>       } else {
>>           perf_ctrls.energy_perf = epp;
>> +        perf_ctrls.max_perf = cpudata->max_limit_perf;
>> +        perf_ctrls.min_perf = cpudata->min_limit_perf;
>> +        perf_ctrls.desired_perf = 0U;
>> +
>> +        ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
>> +        if (ret) {
>> +            pr_debug("failed to set min max limits (%d)\n", ret);
>> +            return ret;
>> +        }
> 
> This feels like a handgrown implementation of amd_pstate_update_perf() (IE static call updated to cppc_update_perf).

Yes, I didn't notice it, better to call the existing function.

> 
> Can you just call that instead?
> 
>>           ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>>           if (ret) {
>>               pr_debug("failed to set energy perf value (%d)\n", ret);
>> @@ -1547,6 +1556,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>       }
>>         WRITE_ONCE(cpudata->cppc_req_cached, value);
>> +
> 
> Spurious newline added here not relevant to this patch.

Yes, will remove it

Regards,
Dhananjay

>>       amd_pstate_set_epp(cpudata, epp);
>>   }
>>   
> 

