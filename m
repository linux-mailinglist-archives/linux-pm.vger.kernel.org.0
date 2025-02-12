Return-Path: <linux-pm+bounces-21927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA35A31EEF
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 07:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94353A06AA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 06:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792E1FBC8C;
	Wed, 12 Feb 2025 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w+8V2A0k"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5C3271835;
	Wed, 12 Feb 2025 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341893; cv=fail; b=N6t40WbSfxIcketF2ar0NvTudLasgKVNW1lYDE82eGjrgp5/hlFx3Tcsixy0zsv5STTIgV5JL5lyRhGAZC873Pqh9+jEQhMOBYAnrYsRDj711nxLGN4VhrL7TBAp7L/9qakuJbsgnOQJO7Iv7ul/sJQRd0Ai8HR51Va2RB0+Frg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341893; c=relaxed/simple;
	bh=c1cxRb4ymEf4UpJ0iV6ruCyObS9qpSe9Tm+tIqGlRhE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OjaOrFrrK1hxauwFpzF/9HvK9HJktoVnPfDbAYEAlUS9SQwE7yKzX+Si70kOaBtLf/xwDYlSxVCEtyGe17B6ufdL0hW4xYpRj9q0+eH//24QVakn6jU8HACgXpwm+WG411J7UGskf6pFbBB2EKJsMPa16o4Gdsl79wj3By/+Egs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w+8V2A0k; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3uYIDgIvGdeT/+HbVDfI0dYzhTGZSWGBORRKnvZi4jlY1C3gkBWk6QIs37d0JjawE5C+n6LN3ZUZNX+MfFBLbI3zYPHlj7yuaQUlSz6c66H8sS5uuaJVcFpZXaNZ3DfRfxi9pzWR8D8pAWLv9AoLuqaelCI6ZFwLZHBXGAPMCbygo1w2DGo8GGgB9S79UNcBreQ6i/E811kQOLbblvccCw8IgCTS4SE+8/LEFkSFGaO5ZmRuX5nO/VB1qSDJqcU0IuXU+Wg5vne0GJ4XvB3Gj1z18NhqjBrDfKT4mEGpV2tGKoQi0en6eUUtdZUIo5ZNvqucuT8r5v134cRmoZvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiypnW0F08JXPsJY0U5E9oxnM/oE5R1/oHug89NmZEo=;
 b=m+sGnc+EFTk034oNCopbuoNQSj2DZD6aQmOEzzHZzXnxIogpGwoZA5jfkN2Auw3leIQ7QI/BhzoKdS2szxw6qPM0iWmPEXTO5Ij5jo7VTY3SQPbMu8jRktxvTtQXmWSrCNRv8uLlPLtR+f2FcfjKp1/AvnzACNCMCHHV/keoIN6sBkhr7thHt9BGOJwvgMxlWQp0D75ag6MLVt+peLQPL0k0jpXndkW3fy8W+ujbq+KEPuG0dcibWz0kxe+da5jz+aZ7nJvU/yNJUcESC7Edunv0mFjyZZYQCYsgHuojpR8j/67HTwA0UJ3QFrfxl09lTSud980VbPISabtYhoO58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiypnW0F08JXPsJY0U5E9oxnM/oE5R1/oHug89NmZEo=;
 b=w+8V2A0khBj7d+1CSXXcLLpCnhamnDXrKwB66FEwZHEB7IDGEo/CHsEGR8sawYgUu0PwkC2GyESD+MdR6raq9TJs9x2ApzowefJLb0W93mwFO6MoKQ7J8XEqUmt3PTA9Evb6hDPsUF19CC5etT9eD0Ok2ZNijr6C13NmLJxgfpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 06:31:29 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 06:31:29 +0000
Message-ID: <4d7dca2e-4245-44a3-96a7-0c9e1ef363fb@amd.com>
Date: Wed, 12 Feb 2025 12:01:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] cpufreq/amd-pstate: Move perf values into a union
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-4-superm1@kernel.org>
 <5577e2ad-6cd0-4fe8-a8e8-28199491ca3a@amd.com>
 <9b38a679-875c-436a-9383-8b0d8a1b67af@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <9b38a679-875c-436a-9383-8b0d8a1b67af@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::9) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: efc803ff-838c-4571-287a-08dd4b2ee23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDBpQ2UrcEVYTlY0RERZaVZFQ1dEVkY2VzJ0M09kRi9zWi9FK3pENzZUMG93?=
 =?utf-8?B?ZGtESVpJMkFzWEVUMUNERmg2akM5RzZCNGNNRmpOV2c4b1J3eS9RcUJBWVVM?=
 =?utf-8?B?OGNjakkvQ2Y1MXNqL3dDV2E2ZmN1YkhleG1SQlZMOG1aWUxyNWMxYXFhbm9X?=
 =?utf-8?B?dVRISFB1R2toNHFBRUZ0akZiMVhRKzF0MkYyU3ViTmUrR2xOK2ZNU3lTYmNk?=
 =?utf-8?B?THhxSWtHQjdVdTgrMG4zaE1UL2JYR0RhRlMySmJXS09tR0kyUHhyODYvRUJ4?=
 =?utf-8?B?YkFndlFlVDZwbjBnSXpEb1dPeHU5NmNPRWpWaVRVOWJaNlMwSXFhQ0RPYStk?=
 =?utf-8?B?TENqTXNpcytIZURuOUxtckE5ZmovSzBBT3VNOUJYRjIreW9UUW5nbk5vK1dP?=
 =?utf-8?B?ajlWNlh2eTZYeW1OeHc3cHdJdm8vNWhnN2pFWmVtdTQydmJVa3ZReUVuTVRR?=
 =?utf-8?B?TWJpNTRSendMSGJKdWdjVFhQMHpuZ1JoWE83VU5qblgzR25JMUNFWDVsaGJo?=
 =?utf-8?B?UzdHR0JDSXRQcjNVOXdOSkh1eEdOR2tURW9lWmtpdDROVXd2ZWJjdDRQcEtF?=
 =?utf-8?B?ellRVTJLTU9Ld1pKWHB1TUp0NG1lMjIvWFVtaTlRTURXWkdEN2g1RVlLVXVj?=
 =?utf-8?B?cit0YWo1TGREN3N4bjFFc1FnMmxNbWNVR1ExZTN0c0NSbEJEYVNFa0JMR0Vi?=
 =?utf-8?B?YUd0ZjdjREhiZ3pJeG4vRHZHT2FPVGRPckhmUStSdVRVaGR3YkUrYkZTRmNq?=
 =?utf-8?B?KytrZ1BVbHZ6MkJjZlBLQ3Z6c21QVDFoa3dOeHZydEdFZEExb2VrTEJUeGlH?=
 =?utf-8?B?K1NNUDlnNCtaV2p2RlpTY2lrRUFCam9tNWRWUXhmb0xiZUV2VzVwdVRZQksr?=
 =?utf-8?B?WlY3azBvZm9mZzdQZHhGeFFXMGE3NEtRWks0NEFNWTVNVUYvSTRWaTJzN3c1?=
 =?utf-8?B?cnZPdEdBTENqMjhiZTJxY3FUYTB1T2NZcTNPV0VwWGlJSkw5dm5ISDZXY0w4?=
 =?utf-8?B?bGczUU11WlA1N1FlckhoUHk3TTlnMkFrcyt0NllGQWtOMXhQbEtxQ3ZialZl?=
 =?utf-8?B?Z3dTdWNhNXpjblBOSExPcDZBN052VWVaUWhyVTRJbW1XcldONmhCTmtQQnJ0?=
 =?utf-8?B?R3RzUTQ5Z0JiYmFOamE3enIrUDU4M0pEaVhxcmpwa24yekxrVi9vUE5JSm5m?=
 =?utf-8?B?YzVCTTFLUW94eWUxODJHYlFvQzdNd2dhTnlwdkN2ZFVmejAvNS92c0dUR3Bu?=
 =?utf-8?B?RUFWS0RNTWlpbXQ1WmMxUXA3eGlLK2JiV3N2ZlIrL3hHM3lEdzVsYjdaMytO?=
 =?utf-8?B?ZkZUYnB5Zlk2OVVwUGZJL3RpOGlJSWZQeEE2L2s2WjdFWElIU0V1cmpCZGNO?=
 =?utf-8?B?Y1cwOGxMajJLMVNOU2ErSDFKRW1kRUpsKzdKUHE4YUpEYk5pNlZ1QWMyUy9W?=
 =?utf-8?B?S0hXREtQaVdqcHlsUUNOdVZuK1RaRmlXMVQ5ZlJ3RVU1M3pyZUxuTURxeUwv?=
 =?utf-8?B?bTVSMm1BaEs4emxhRGtMTjlNZTlrUFdSVWcrd3RNSlJuWWhpN1pvdE1MZnNu?=
 =?utf-8?B?UGcwajhDTG9FVlJwMkFlT2pKRTQwSjNNWVFKeEtqdmRyaDQrQkw3SmtBTmQ1?=
 =?utf-8?B?bGZLQUtPTnI4amxGdmVLTi9LM05FRGI5cUdUWFIxS2t6NEd6dFc3dkFFS3pV?=
 =?utf-8?B?MW1wUU9BTS9GYm5IUzVnVkM5NXNpajZLWHI1QmZUa3ZXY0g2SFBDcVBrbCtt?=
 =?utf-8?B?Nm5Zd0NHMThYcW9Oc25IazFJa2JZWkxrU0dlaFNCaERvakgzblRUT1IzTnhR?=
 =?utf-8?B?ckxYQVgwSVl6cXlwSGg1T2hyWHlGMkUwSi91RzB4ZDJYRzkzamJ2RHhzcjRr?=
 =?utf-8?Q?I0DFWgcTDPSNu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2YrK3pmd2duOWkzNDEzeWo2ZVBIdzRiV0N1dk5DNWE5VFdDZmFsUmV2QzlF?=
 =?utf-8?B?L0s1VW5vanh1RXplYVFBSk9MRUxaQUg1Tml6NkRHSVlKVjBsN3pSVk93NVIv?=
 =?utf-8?B?REtycnIvTS8vcjdpS25YYWJoM0VCYkM1U2VXV0N4ZVhGaFZEUCtVaWJKREJU?=
 =?utf-8?B?endaUkJ5MnNJeXlGWU4yWnNVNVplVm11empwRHpUQUtnRWV1Zm94UFNudjVo?=
 =?utf-8?B?dXdtQjRLSlNSdDk4UFU1elZwYzEra3lvcEpCcHpORVErMHN4dHMzWjFkUjkv?=
 =?utf-8?B?QkhOcWRsQngxNlowSGd1THJ1b0I2eFk2dmxGMmdVZHZWcmwyVWhaaFZKV21L?=
 =?utf-8?B?Rk9vMlhyekxTSmRQZVFmY1JCSG90YjVZL0NkWmFoTDhqMGo3K3BnTGZsaUtW?=
 =?utf-8?B?NFM4R0pwRnpDSnhIcDd0MUd0cUFQYW9ONGxMOXNCQ1IzVk1yd240VkdNWUVl?=
 =?utf-8?B?TUo0bHFFOFZMdzUrVURQWVRIZFZqSE9PVFczMUo4aTFzYy9XSUUxaU5LaGw5?=
 =?utf-8?B?QU9CajZYbEV2YVRPbjZYemxldy82dDI0MEpIcmRnYi9ONEZ6TE5zS2JjUDJZ?=
 =?utf-8?B?NHk4aDkxaTdNTjRwcjYzM2t1aWxaMlNnampHWEhBQXZDRHBURThITFRDM25S?=
 =?utf-8?B?NXR0WXZaQzh2aTVOTHFMSWNQN0x1RlFnTCszcTYxbXloeFVYUFZycW9TaFMw?=
 =?utf-8?B?Um9hVzkyaEpsQXhWc1RFSHI5STFYUW9wTmQwbnZaZkViY0YyLzlmT3JsdHRl?=
 =?utf-8?B?T1dkcFBjeWs5RnRCTFVlOXBSdE9MVXdlTll6UnRxVktHY3RLU1N0WFpGUGZl?=
 =?utf-8?B?YWJBeE90TDdTbStYZTQ1NjhqL3dMNUlwZmVlL3NicFFQYS9GekVUa3hid3dW?=
 =?utf-8?B?VE8zWG9XNlpkNi9qT01PcHhvOVEwQnJRaDhwN1hDZUJGZkt3TVp4Szcxdmpz?=
 =?utf-8?B?ZW8weWtKR2ZCMTdmSFlRTy9WV1Y1VUNrUEN2elpyWFhUMTd1MGNJSHBpRXpt?=
 =?utf-8?B?bkhpTWl1dXBXVG94Y2JpTVNDREx4ZnZTUlRRRktESlZOMGhUUEZpMGgwRDB5?=
 =?utf-8?B?QXA2SWVibE55eks1U05oS3E0QlRzNE9Ybm1KWXN0MWRFdTQvZXhuT0llb2VQ?=
 =?utf-8?B?QjFJdVMzR2Q5RzRDcmFCYzNHTS8yV1I3b1hIUnNta3F2dlJxOExXQTZ0WG0y?=
 =?utf-8?B?Sm1RcEliSkhJZTU0OFpBQUdrWnRUQTZkUEkzK0hEZ1hVTk5TUnJKYWYvWEZF?=
 =?utf-8?B?SDBuTXlES0lNVy84THd0ZWJkQ2h2VVJISDYzNzhTNnZlUEhoWVJSNE8rdC9w?=
 =?utf-8?B?WkVzZitVeGhFbHhwSG9tTmVUeXY4d29lU29udUovNDNoODZueTFDcThsLytX?=
 =?utf-8?B?c2lTN3RVd2h5T0dSQUZzL3E1NDNZNFdqaDdOc0pIaTBUNGNjY1hkR3llWWxa?=
 =?utf-8?B?YitDOXk5aVA5SGtzMlVGck1hek5CUmMyNzZLMEdNUmN3ZGFyaW0yUXhJU0xP?=
 =?utf-8?B?SFl1cE56ZGFYUTdJSWZVWmtKcCsvUmZVYmYrdHYrYnRDelQvMG1UTXYvei9R?=
 =?utf-8?B?SHNBd1pZYTIzQUl5anJmdHRHb05PSXhRMHN4Y3J3dlZLR1FUczBqWUlvM2Ur?=
 =?utf-8?B?clZaakNtMzhjTTVJNjhUMUlLeEhwc0JYQ0xLYjlQZ0ZSTjZqbldtZFhKR1Fs?=
 =?utf-8?B?UW9hTDVvRTgwbnVEVytCd0lzTjhycmtKYnMyVnZseUl4M2pVYzVLeXRIa1lJ?=
 =?utf-8?B?YjgwbmJNOFBnazk5RTArRS81SVpHMndCbjJ6OFA1dm1oWWJKRzZRcGkrL1J6?=
 =?utf-8?B?Zm03WGJ2S2RYekNqUU1vd05BLzUrcGNKclpON3g3bktwOVdtOWdTb1ErNzdz?=
 =?utf-8?B?dFJsSndMb010dDQxSDJIcHdORytNUW5OK2YyTWh1RTN0M2lUNWg1cUJTNEJw?=
 =?utf-8?B?TVhIYktnWlYvWjZibzdvaWJxUU9mdUV5QXhpRnkwbWhTNWlwTHJNSTBKWTcv?=
 =?utf-8?B?OGlKUlpMMnpDMlVUT1pXTVFDSnkycHdCUWw4Q1ZMWHVrTnBrRkdlMlREaVJI?=
 =?utf-8?B?N3BoSVowdk42bUtZNVlzbzAwQzdvdzFINmZuWkVQTkZJeU51Z3lQeU1KeGhp?=
 =?utf-8?Q?O98KDEHAcC1FUPDpYYgpn3PCX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc803ff-838c-4571-287a-08dd4b2ee23a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 06:31:29.5543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJL72kaqehGN+2Ov8sL9d6zJqTmUnjIIUeCrhW+bV2bzsSI3kvTPIilenSlYgBtGbOF9wVIeliv6QebzRhBhSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840

On 2/12/2025 3:44 AM, Mario Limonciello wrote:
> On 2/10/2025 07:38, Dhananjay Ugwekar wrote:
>> On 2/7/2025 3:26 AM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> By storing perf values in a union all the writes and reads can
>>> be done atomically, removing the need for some concurrency protections.
>>>
>>> While making this change, also drop the cached frequency values,
>>> using inline helpers to calculate them on demand from perf value.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
[Snip]
>>>     static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>>>                     unsigned int target_freq, bool fast_switch)
>>>   {
>>>       struct cpufreq_freqs freqs;
>>> -    struct amd_cpudata *cpudata = policy->driver_data;
>>> +    struct amd_cpudata *cpudata;
>>> +    union perf_cached perf;
>>>       u8 des_perf;
>>>         amd_pstate_update_min_max_limit(policy);
>>>   +    cpudata = policy->driver_data;
>>
>> Any specific reason why we moved this dereferencing after amd_pstate_update_min_max_limit() ?
> 
> Closer to the first use.
> 
>>
>>> +    perf = READ_ONCE(cpudata->perf);
>>> +
>>>       freqs.old = policy->cur;
>>>       freqs.new = target_freq;
>>>   -    des_perf = freq_to_perf(cpudata, target_freq);
>>> +    des_perf = freq_to_perf(perf, cpudata->nominal_freq, target_freq);
>>
>> Personally I preferred the earlier 2 argument format for the helper functions, as the helper
>> function handled the common dereferencing part, (i.e. cpudata->perf and cpudata->nominal_freq)
> 
> Something like this?
> 
> static inline u8 freq_to_perf(struct amd_cpudata *cpudata, unsigned int freq_val)
> {
>     union perf_cached perf = READ_ONCE(cpudata->perf);
>     u8 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, cpudata->nominal_freq);
> 
>     return clamp_t(u8, perf_val, perf.lowest_perf, perf.highest_perf);
> }
> 
> As an example in practice of what that turns into with inline code it should be:
> 
> static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
> {
>     struct amd_cpudata *cpudata = policy->driver_data;
>     union perf_cached perf = READ_ONCE(cpudata->perf);
>     union perf_cached perf2 = READ_ONCE(cpudata->perf);
>     union perf_cached perf3 = READ_ONCE(cpudata->perf);
>     u8 val1 = DIV_ROUND_UP_ULL((u64)policy->max * perf2.nominal_perf, cpudata->nominal_freq);
>     u8 val2 = DIV_ROUND_UP_ULL((u64)policy->min * perf2.nominal_perf, cpudata->nominal_freq);
> 
>     perf.max_limit_perf = clamp_t(u8, val1, perf2.lowest_perf, perf2.highest_perf);
>     perf.min_limit_perf = clamp_t(u8, val2, perf3.lowest_perf, perf3.highest_perf);
> .
> .
> .
> 
> So now that's 3 reads for cpudata->perf in every use.

Yea, right, its a tradeoff, in clean looking code vs less computations. 
I'll leave it upto you, I'm okay either way.


