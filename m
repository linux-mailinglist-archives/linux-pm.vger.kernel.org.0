Return-Path: <linux-pm+bounces-3147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B2084509F
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 06:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BD928E133
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 05:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B2E3B19E;
	Thu,  1 Feb 2024 05:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="r3I+/FpW"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2114.outbound.protection.outlook.com [40.107.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1F23A8EF
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 05:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764409; cv=fail; b=Bgqv5LPGC9pSD2z3SHVpS2Zdp3QE7ZfQboXCGFhImioc3BvHmHpbhXjCMGRdtsRNDKkVw7TupWicgf1Gh29L+VpJffxMsVWUVGjX59hhI3xG6JjACgAChTtWEdBw+/zGkJm6DhMM+xim175tylmiEwKYEoiwaaRbUEABIKSf744=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764409; c=relaxed/simple;
	bh=0bv/OkoEH5k1fHepGZaX33IxlB93lCV6bgldKZNezQQ=;
	h=Message-ID:Date:Subject:To:From:Content-Type:MIME-Version; b=LPHv9ba17sv6voGtWOJJNyupvyD+rFwadaRjGv1zEg74ydT3+gAKjRzud7ziTlyz62E9RKRQuXsgo9xLjNHQHNVKV0HvZcDhAGTRcJ0Wk6Mc361BAsGG4nhSqzAJ4Dx8jJExa8ReWgGTnlbTXtE2g36M6vQPrQMPN8NBCjwgfl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=r3I+/FpW; arc=fail smtp.client-ip=40.107.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIp+FT+YSfrps1Qq+nhmsGT8dfFSrhwQcmYZDHtIbzDC2IFNZiG1vbX8+ecA09obNhjkLih9tIxLVriPlKJxzpws8tmsji9281FKDgGUhsbZA25WRUj3fXfiLP5QDKDvVTGCY5GxqJwjGlcn1aIMlNfRPwUmE13C/IHCEkc7L+aj9mhMLWJGXsaKN11O2qjascNqImk3cwjRV9jV047a9BsDmfgrOK5fhqxDAvUOm44CilKAbtv9i4KbFPlmjMXNlRj/peYy/5tfXXvESIwhZm6i/gVxiTDoCtKLDoAFr5I80lVoU1P1AjuROPBhn4qrSPdzdhpeHjr4RSWIcMM51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80vn0HqZpacFbJGAHyqRZr4nvjLxyKwedDQiC38VB5c=;
 b=HXPks+tQOXWl2BRHl3KkPWLFmLElKa4SdHKwWK6eaY+2FdUahmC4dW3vXXAsAoPCOtrlIgBa3YSzGNUp3A/4evAmxfZoyp6/Wu4GAFIMNvGGyMnzCIvJwyiHl9BXbFKx8rH05OS2fdC+oRkWvIBbN4vGh6gMMSuWQrlb3EF/wHJ/Eb/AoeAGF4VtDLmSz2WWxVsN0U83AK+5A+MVm7g11b8ft4uLa5VwQhgk7X7Ic3pB9KoHmlbeY/obLGPlDP16VPQCOPbQY+7NjsINdfXUbSQX+oY8jXsx3iM8Z8O23OxisbYYh6zM0ZgNn490h2iPsL8bCckT//WyuNaCnRP8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80vn0HqZpacFbJGAHyqRZr4nvjLxyKwedDQiC38VB5c=;
 b=r3I+/FpWlLOf8DkAB23GiiVGHiYGE9ChoSWXVFYKYKoD1uDTOT3qs8OUyop9Bi4fRhv/9PnEHGIXUG9K1g7+tXgIpwAICrRwqXWiUcndkQsO6dGOSWoKPmK8fMof8w1CArLOtDQJZaZafGYjWefvVX124dcIv6q53fzFTjGaZZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14) by PAXPR02MB8017.eurprd02.prod.outlook.com
 (2603:10a6:102:2bd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 05:13:23 +0000
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::aced:6bdb:2796:39a6]) by VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::aced:6bdb:2796:39a6%5]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 05:13:23 +0000
Message-ID: <7338cf52-703e-44e4-2614-eea0e891d295@axis.com>
Date: Thu, 1 Feb 2024 13:13:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Optimize the cached regs in bq27xxx driver
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Language: en-US
From: Hermes Zhang <chenhuiz@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0074.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::14) To VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR02MB10536:EE_|PAXPR02MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d68513-111a-4b34-2882-08dc22e48373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1MOKJTBg+aNP0IiqCn91qcTgma8iX2AE/xrJLKn/mC2OqzxUmpSB/84Wv34UhdfVers5VDhoOrMZzjuBLKE/h6Cm8GiAVaAfj4k7g9U5gf9BFcyaELH21OWk6G5JpzinA3DmXWqHD7Y7ykVWxZoC4fCx1fH7gGQ8m76d2V6xAynrfanPqk1JNaWw3ioDiov7gbRW52m5eYlUdQEolF+wMceGMRwVI0KNn6lPP2+XRuf4YfPICOlzLepTbGJsT08uQtnjOe5xQy6XHJZZk2MmXUnW0w51olrH50pwVhhSUBH7aFHD2GQyO5ha8/cnLrmFx5zZmo1WVrbGKe/7CknQx77UIP3AA36qYCe9IxZ+sb82zSwKcUW1VJ7J9a0wxjTw297fQ56sn9BmD7RdeKz9xBXu+rihwaaRe6K3ABMIbWzhEvqgn/0P4rDgf2IWyFE9qAZYUheUfaHFkH9ppKPab+2xk6bb+wV7rnLU0NCuOhtwQ639drYjFuMNsVAXblC1Q0nqIzX1CaoC8CGmDFssvER1RsUDg3vm5nqgA7USHYFLg2t04ynjBNI9h+uFVmE7MO3GLJR2PsPUtwVFSHyscro2GLS9HLZozQrcP34JpPG2sk6oHlEodRrawXKBOD1yMInj9fga7ykVxgRJRPCiaQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10536.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(31696002)(2906002)(4744005)(8936002)(8676002)(5660300002)(66946007)(6916009)(316002)(6512007)(36756003)(66556008)(38100700002)(66476007)(6506007)(83380400001)(478600001)(6486002)(6666004)(2616005)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTFYSWxlYTNsUkhia1R0NTNqQTFqQzBHOFBDUzg2dWFET2ZnUU1VdWNWb29X?=
 =?utf-8?B?a1JVMThRSWhVeFozU1NLeG9JaGhxTTJVQjg3Nkd0bDc3dFZSZjdvbWNiaW5v?=
 =?utf-8?B?M3N1VktWNlVDY0tIRExENGRFOWVIK2t5L2VERG5jU0cwTGFrTCtBYkd2QUg0?=
 =?utf-8?B?VmhOeTE5MEdwaWtDVWpQMGNNQW5YcTZoY2tmc3VSaGJ6Qk9HWGpvbjBBMjFj?=
 =?utf-8?B?ZjVSOVM5VmwwNys5aWY4azhmUWpkY0srSWhKa2JxampsdjRRZlFCR3RoeXhP?=
 =?utf-8?B?eWJ3ZlR5L3BVVmRzMzJRNnJGdlNGRkJ2Q0x2L3pBMFUvMEthN3Rab1lQUHZH?=
 =?utf-8?B?NGtzU0t1VzdnTldoNjlhSEcyYnAzVWtKODJXeWVkUU9DQm1wTWN2WmtyNUVy?=
 =?utf-8?B?NGg4em94YUI1ZWpRalhPNXBuVFhXYW1ab1B5bWVuR01IVWtDVnZhaEphaG5a?=
 =?utf-8?B?MUx2eHVGenVySWJ6Zkc0T1lJR1l2aDJHbzZ6WUNOWUFHcEdNaGJic2ZhNVBp?=
 =?utf-8?B?WFJyem1ZbTVmdjRPTmxxTHQvSVdxMzAzbWROUlY3a1VxV2FKZHBweCttU3ZC?=
 =?utf-8?B?N3ZFMWtZMlIyeE8waWhVWGtudmxVeUxJY0JpajQvMGlKanlaV1VyTllxb05V?=
 =?utf-8?B?VDRnOWVuZk5yb3RCdlJMNEFmSXczdUJlc3VnZVZzR3VKUGxudUNBQXhOTHdx?=
 =?utf-8?B?ZFRjUi9LTXdLcmxHQW44ZUZSQkJmRG9lUlpGbWpIbExQUlc0WkxwdzNTNlhy?=
 =?utf-8?B?ZTFiRmlvM3lNUStMODVkNG1qcVhxbnNHR2wzb1lHbGFoYmJ3MWxCMVlENEpn?=
 =?utf-8?B?UU1YV0hRTFJtYWNhVzg3RC9VV1hyeDVtMisxOWdVRUt0YUNvZ2xaS1pleDJu?=
 =?utf-8?B?WlVwVThHMFFwdzFYZWpUTXpDcHQwQ1RFMVJzcXhYR0VDUEJTQmFzVmhONWVH?=
 =?utf-8?B?V3A2dStmQlNLbVgyQnAyNEZsVDM4Q0VFMnR1U1JQR3lqVWJpOGtvYzRLejZC?=
 =?utf-8?B?VlBZSDExdE5RMGovTFptT0ppVjRrNVVRTTg3S1pDME1Mck5WMVI1NzZrWTAw?=
 =?utf-8?B?VXg1RUxLRHFUb1hScVRJNGlOUjlqOTBlOVV1RExyc1JlaDVhNVhIZDhFbmhG?=
 =?utf-8?B?WVc2bGFkMGZpOTRBRDA1VzBENExFZ0gwSUNjcUhSeEd4QzRCQUZqKy9nZmk5?=
 =?utf-8?B?cnk3WXMveExGS3A2NGJFeXBRb0dqeUVMVVErTXNMZ3BPcXM3SjkvY0VIdjZh?=
 =?utf-8?B?eFFLVWhHcUlzVHBOMDdqaHIzenE2K3B1c0p1OFlQOXZZQ0lyUkp4YXhVS2dE?=
 =?utf-8?B?WGxTYUN4amhQYlowd0lHYWU1YlhWeHhiTUVVWkdidkJvUUMxbjBCeFpiQkNN?=
 =?utf-8?B?MGQvSk4zOTY0NHFOS2FWYVpkdG5IY0VVWHAvaWVUbDV4YW81bEZGYldoeDJ4?=
 =?utf-8?B?RnBuZFFwMWR3NHErZ3pyRHZId3QvdzJNV1Uzcm1JcFZvTGVjNk9nVTRudlJl?=
 =?utf-8?B?Q3dYVXkySE9mUVhSQ0pyT3h5elpndlFydkQzR0xneURGYUtkWU5wTFVZbDNv?=
 =?utf-8?B?MU1GTkE0L0NZWWVLY0ZhdHhkNXYvZStxV2RVSWxmREJhYUQ3QzE0U0RsakJB?=
 =?utf-8?B?TERwYXRscmp5ZUpqZE0zR2JtRElaV3ZhS05yV0dLZm5GSDVFRXFWWlR3MXJZ?=
 =?utf-8?B?eTRSbXRtRzBvTk96WGhIT1NwOHo4WHNwRW9VK3dSZEJjSS9ua0V2SzFoM1BF?=
 =?utf-8?B?NDd6Zlg5a3NhdzFrVFVwZExyUExmZm1pc0YwUTRtRUN1VmhyMFN4QUNTOVJu?=
 =?utf-8?B?K0wyYlRGQjR2aGM2SkQ4RkpqT1hPNDdpeHoydW5nSHl3cTZMZ1JyK0JmZlJY?=
 =?utf-8?B?c2lCTDdhZUl3VWF5bDN1OSttL2JmdExLSlpQTEJnYU9hSDk0NXNRaVlmOUZ6?=
 =?utf-8?B?eHJUL1ZlTFNCMUxSQ0hPMDdlaTFZeng3MWR2Z2c5UVBpL29UZUE4WjJKVm0r?=
 =?utf-8?B?WjRIZ0J5RzNIT3pNamlrb05wd21yNGVEaDBhckNCQlMvV0hNQTZhVDZINzJt?=
 =?utf-8?B?bWU1NVFodGpWelQwWS91czJ6c2dqbHRPVTR0OU9wdmNKdzdYUkJtZDRTY2kx?=
 =?utf-8?Q?+aEU+yyF093kiVy+oSGjAXywd?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d68513-111a-4b34-2882-08dc22e48373
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10536.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 05:13:23.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPLjWnIdaeUCnUF+i0hn9sX1oE6NieGpvZL3JbtPW6SxQx4Ar8yBZqUZsvR2QaKtPdujp+E9qv5WGSvKJSljUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB8017

Hi,

I want to ask a question regarding the regs cached in 
drivers/power/supply/bq27xxx_battery.c:

struct bq27xxx_reg_cache {
      int temperature;
      int time_to_empty;
      int time_to_empty_avg;
      int time_to_full;
      int charge_full;
      int cycle_count;
      int capacity;
      int energy;
      int flags;
      int health;
};

It will cache 9 regs and I see from the driver code each time if I fetch 
one property for the gauge chip (interval > 5s), it will call to fetch 
all the above regs (since the cache is out of date), that will result 
many i2c data transfer, even I only want to monitor one e.g. temperature 
value from gauge. So, I want to remove/disable some of them, e.g. 
TTE/TTF/TTECP/AE/CYCT which are low interest for us. Do we see if we 
could improve this? E.g. introduce a new module parameter to specify the 
regs which we want to cache or any good idea? Thanks.

Best Regards,
Hermes

