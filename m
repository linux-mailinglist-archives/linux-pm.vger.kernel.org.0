Return-Path: <linux-pm+bounces-25045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D3A83033
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 21:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D6F1658FA
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268681AA786;
	Wed,  9 Apr 2025 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mp4bNl7t"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63D1B81DC;
	Wed,  9 Apr 2025 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226118; cv=fail; b=dL85D5qiINMFPDjVCqnXXUTnk+17Z8B3dPK1v9hV2Go0NbG/eVWeeWH4HDObPrGNXH909PsQNJTfpHaiiS2+5Pjtxz5e/XzabRWw3ikpGilFW7TkLRCUeTzTxjMC84F2bKZ/W6mXZnnmh07nuGMWAb5EUrmU30edsAPtXact/xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226118; c=relaxed/simple;
	bh=0841FZmfgFhjo29hD3ENaqNbz5FVOorzD86dVyN5jMc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RSi2HsiHfhKw592/QlqkEstaMQHvceQCGNqbn7P3CvKbe+NefuYDzmqpsgrOxKMxH7mIKu8LWBCY1bqcCyg5Uu3dAVdJfJTje1jnRZcD41j7/L0PWEkpYPIVxIXOpmXq5Sd2r6+WRW3cpRuriKLnPHmbcjRvpcjUaUg8WI8OUZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mp4bNl7t; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsQnkXRSYeoKfq+Yk6WYAwe1B7sOCUuX8x9gUj9Yz7nPFnHqKCkWB/UHnMMx5UBAddE1AO95mB4iDLWmGK9P0TkmkdvcVCcuEdSpiky6RXYAdEep9nh2c7jZnv9eubl/RanMbTOY69RuktPDUBj45gZ0vW+tgrWByZNmSPQ/jePsRNTfNU+UOiptz86/ofLiv4VGxX+mWWPXA4DHUJGA4BY6ghs/MZ8D2Ta/n3EuoqDnG6pwXuzWoErsu+AP+cqM7U6jgOv3g3V6kOO6v5nnnu0Yuzc7vpVIUj3GDxstZ9t8XN8ys4ICWsXwedEUuRlC1qu6HErLliY3z3vkzt4U3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIVCZ1SkrOxseicWvTZ+73IVMWpGnHlS0iQHZyJy0HE=;
 b=EI5QwLW7q/objedmclGPykX91SjWyfoZZ+LIPP9uEl5K2AfQtvfBEGvT3e7tW+1rTNQAZuCsEW9ljnIrV4k6lFz5phv6qfSLAqLl9u0OO8M9RfKASUyQvExLZIaJYRTq1Rf6XJxuOOEAjLu7QfgiE/OhN3mb+gsAeEu8C8RSDr7lfnl45dUPsKRnFnRDpNrz+bcLmDFU7PJfHNEIld6lEB9YJo1hS11oZv9QbcRGjuqH4HFmRPBeIPYyMYTilJ+BncfKrDYKH8r8IbUZcJNHOZvHMxXK0fezrk4qjwOWPB9lu1G6wdOt1uPrNy6Ohym748gz5PpOH1MulT8fHrcOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIVCZ1SkrOxseicWvTZ+73IVMWpGnHlS0iQHZyJy0HE=;
 b=mp4bNl7t2vdR/OrpB6XqvE7lDmSJ5BREqaBg7pgxduUEQr3SrZlv8zKDZB49UEI+vnRYSTLaxOAGKfNl5VOBUqxG4tH/LCZdUQRxGItzqvE9VP6LXYgN+0JSrskZ4LFxxWhEg+dpwDiBNIkWePOvFxUU/woNG/Uufd41wLJopUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 19:15:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 19:15:13 +0000
Message-ID: <f8a06d12-4728-43f3-a87f-35728e5d145c@amd.com>
Date: Wed, 9 Apr 2025 14:15:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] cpufreq/amd-pstate: Update asym_prefer_cpu when
 core rankings change
To: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Waiman Long <llong@redhat.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, Huang Rui
 <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>
References: <20250409053446.23367-1-kprateek.nayak@amd.com>
 <20250409053446.23367-4-kprateek.nayak@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250409053446.23367-4-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0146.namprd11.prod.outlook.com
 (2603:10b6:806:131::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 95fb0c5d-143b-4b20-43f9-08dd779ada7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2hsbTdCaE5CYWxBa3dOTmZXL3d1UStYeGFWVnRnNWdKQTZ3eWZLQy9rVkdP?=
 =?utf-8?B?dkxCZ0pBNlNCR1dVbGZpNDZ4MURldkgwYXNzUVNWNVNXL0x5UHdqenZZVjBH?=
 =?utf-8?B?ZHZyUEZnL1RJKzN2QmNGZEd1YTN3cUVIVWRUdi9hYmJ1a0FnaTBJU001czZa?=
 =?utf-8?B?R29hNHU4UjhBb3M0R0dUVmg5cnVuSUVYVytkbE9wRHEzRm9yMktDNGtqZUto?=
 =?utf-8?B?NGxqTXRrUDlqS2hRUUZzZ1hyN2RGTTcvRkJCZ2tnNzhoM1k3Z0k2OWQ2dUxw?=
 =?utf-8?B?ZFY4bVZRdnVkL3ZiWlcrZCtqdjVqdHZpS2VTZnNleGdoQnV4cHljMEVFcURh?=
 =?utf-8?B?WjBVOThmSkUwcjB2TXJaczNtN1dlaVB3eEwxZ1h6RXZyQkVNNFBLUHdQVHpD?=
 =?utf-8?B?bnNrQThJUkViNXMzaTJ4U1Y2d0RRenZrR1VPbEVPU2N4enJET0JKMU9yYnBW?=
 =?utf-8?B?OEJHRWE2RlFEV3JpMVZPbGdSWFVuZHJLblNwbkQ1ZkVFNDJDOVB1OG0wSG9n?=
 =?utf-8?B?Y0JSRkdPYmtiWlIveUdnbU9nUGlOSEc1N3ZZTHlFMTl5NHo4MzkycUpUbjBB?=
 =?utf-8?B?VDhJaUZPNVlBRDBjR3VEd3psRm43ai8xT0ZYWDQyNzcwMCtBa1NjUTVZczY3?=
 =?utf-8?B?RDNHdEFwS0dsb0hWNmEyR01zSlRwNFFXSnZqa0l0NHVLcHlja2xpS2VzRnBi?=
 =?utf-8?B?LzYxa2ZYRUQrYmx2WWdFQlB2dnYrNUgyTmZpZ0FiVGwxSW00NDBnMklHK0pr?=
 =?utf-8?B?QzgxeThSSWt6ejYxWHRTN3RrVDVLVk1iQ0dKUWZEYjVFS3Z4M1hyUW9tVGFm?=
 =?utf-8?B?SEVHOVlkNm5vd2dVOTFEYXY0cHhESlZwQ0xEaDd6V2FvTkVaMTloQ1kwQkN6?=
 =?utf-8?B?dStjeitnU0Npc24ybkswMERPYzhYNHFkSlliOStNbkhzRHJzb2xRZ2VXTHZS?=
 =?utf-8?B?V3FQYTVEY1JzbmJtbTlSemtSQTlPYXkrZFd5Rk5rQTVZUkJVOENlL2Y2a3Az?=
 =?utf-8?B?b2VsdkdBb2JFMS9kbFR1amxLNUdMdUpFeEJEK0V1V1JQTjBLLzNxVGxwRlo2?=
 =?utf-8?B?bDhNRUlnWGxUUFBLaHdUa3JBdngrSmtDZndhSGJsUEp4MU5FVUs2cVVDc2Jw?=
 =?utf-8?B?K2pLWVFzRm92RUZ4TDhUZlNZZVhHRFNzR1FXcWhMYWhPdmF5OWh0Z3hkYlNv?=
 =?utf-8?B?eit5M3VJYXUzQWdvZ2tVZG0zMWswaGpKV3ZtM0xtY282blV4OHRZZzhuSEJ6?=
 =?utf-8?B?Y1Vjdmp3RU0xeWdFNlR2cVVuT08xbVdiOThEUzVsRkZia0FVMTlzK0t2YXZz?=
 =?utf-8?B?a2MyOVdnSmVxUlpVQi9BNjhFRFl3NHJjbkt6SktxMVdhbEtZc1VmVGJ4VEY1?=
 =?utf-8?B?clo0cUJ0L1FDanVsb29oSktreDRzUkR6Sng5czlPblRKUDFYeWlzeTBPNjlq?=
 =?utf-8?B?clZOOGJML3F5dWZ5ZjA3TTJwVU5MVUlGczg1WlRld1lSQmhtUlFBVlVodHdN?=
 =?utf-8?B?SFVwM1FVbGNzT2k3N3lEamdUZlpJcGFwbERPUHJNbUV1c01aY2NBU2tmbnVR?=
 =?utf-8?B?VEViK0s2WnprYkZ3NFJPS0VBMUxURmt4VjlGb2ZmZGNwMnhsNVE3ODNjUXhy?=
 =?utf-8?B?OFRya3JoR1F0WGxjdzlGNkEzZjlLYzNTTVdsV01RRkdTVEo5Q2xQQTd3VW50?=
 =?utf-8?B?cTRBTCtNVWVXRGhFSDhUdnRyclFhSzlzaGh5ZUZ3R213ZDhIbXJCVEYzdkFQ?=
 =?utf-8?B?RG90WjNJbnA4U05adTlBK1lWNm15THBwTFFlNXJRalNMVWN2S0FYYmIzd2dw?=
 =?utf-8?B?eE9kbEdQSlQ4QlNXZEpabnNOR2RjOHBSYUROQlpoMUhzdkFEaFVkSHl6cHdN?=
 =?utf-8?B?dnFQMlpLdTR4S1p6Nmx1SDR3b1Jvb2JQRks5b1dPMUlhTllrYUk3YWtaV3F5?=
 =?utf-8?Q?w4n0qjuXR20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGVCbHBJVnRzeTF5bnNEd3JLdFJDUGdiM25LeVVjSGZWK0dHSkVKZmhNem4w?=
 =?utf-8?B?YkRIQ3dRL1V3Z2orelN3QkIwc254ZTlnd3hyRWZqVDBuV0RPM3NHbGsyNkwy?=
 =?utf-8?B?Wm15Yk1sV3lOemVCTkMrbmVUdCttaW13ZWYrZUJMbmNJZWNhNS9ENHcwR2NK?=
 =?utf-8?B?b1B2T0ZsMlR6SW1uTE52cndYd3NPU3F2OVloV1JHZ2NiR2ZRWWY5elVqMFRl?=
 =?utf-8?B?bURHbGdVcVhXUUxPdkhJSEo3QUIzZHZKY3NNWk9KUlZ2SjVMeFFIVy8rYWxP?=
 =?utf-8?B?TGFMUWYxTmJQNjJ4L3NpWU13ZFhDUEx5UG1SeklWV3Z2M1lmYlhKM2poSXM1?=
 =?utf-8?B?cGtPa0w3ZVF6YkRYMWk1UERKWko2MFY2NDh3b1Z2cXM1QzBHZG9BSm1xUXVu?=
 =?utf-8?B?Z0NWa0JzVkp5YnEyOUNYTm5DSFZBaFRMM1RLamlCS1IyWDdCTEUxNWtZdHVT?=
 =?utf-8?B?bS9FYWExcEp6a2ZkNm1Gd3NmMzNQZC9uY0JuZnIycElnNUhtQVQyZDUxcGln?=
 =?utf-8?B?L3p1UFlWOTJJcFVieGtHNnRocGhwZGYwaHdRUjlwNk9kSERwRGJxblYvRDNU?=
 =?utf-8?B?bVhqNkpocXJvaWxFUUlXRlphbkt2eDhhQm9qUVJVNXNEYlJNWmhOcDNMaC9C?=
 =?utf-8?B?V3dyUFcwc1V0WWpEcDNUMmkrVjVlWGxpa1JsMGxrNjdsWUdjRTVoekZncnI2?=
 =?utf-8?B?MFhoci9HWDB6ZThPcHNtNFRTM3MvT2NuVkVCSEM3aThlaG1RSmZpSnZGYitt?=
 =?utf-8?B?c0owbFNYa2dBdVQ0VVUvRGVoZytadDdiNFY2NVNlTXJxc1M0QkhHVENWMWts?=
 =?utf-8?B?MmdaUzRqVlZoNVVUaW5FMSszZHlEVFpiRWVrZVpNblhGVk1TVk5URmZkUmcw?=
 =?utf-8?B?dVF2UzFaRlR6R2dpNXh6Uko1RDVpN3hyTFVUYjFVNkdaQUhKWEVVcGh5cVlZ?=
 =?utf-8?B?L0pETnh5NytEUVVjaC84citKbFpTYm9aS1VrMm0rUlVyaGFZUDY4MzVCSGRY?=
 =?utf-8?B?c0x1dmFvSzJ6UFVGd3JWVTNqVmZ6Q1ZrTDlpVm5FMHNrZldYbzQ4cEJkRUZa?=
 =?utf-8?B?RHF5QVZCbk1DU1BSb0ZIU3pjTTkvQW85c0FIR1YxaENYUkZJZ204WkZlRzJX?=
 =?utf-8?B?VmZLTW1vUVJiYS93NmFxdEpRalZTZkg0d2lKVERNdXZiZjA3MC9qRk5Wa3Nr?=
 =?utf-8?B?YzRtUFV2Uk5Edm92Qms5d3gvZk9aMlA4S2I2Q0k5b3l1YlFEdHk2Ny9PLzB2?=
 =?utf-8?B?QVJUT3Jxb1NtSlk5WWdobWF1b1J3MWp4NzllTCt0NkphTDhHSEhTY0lTTlBX?=
 =?utf-8?B?MFZha01xVk1BaHZJU2EzbTEwVWVOb21vbXVuVnZQZnVxK0lTeEZjQXp2aXlT?=
 =?utf-8?B?TWtLRy9WU3B2MEZ5dEd5ekJET1VKVytLUlBWb0VHcHhJZyswNFBOLy90L2x0?=
 =?utf-8?B?YzZyTE9sVFZXVExZUnRVeVJFQjBMeUVLWTFpNEp4Skc1T05USURuR2k1SHZJ?=
 =?utf-8?B?ZS9vd0hjaHhucnV0T2x6SExlMHZqWU90ck9jVEszUWpNNUJiUUtNSVNHUlVz?=
 =?utf-8?B?SEQzRlVrNWVOU3NnTDZCUWpIbUUzNHpqNnNrTDVVZWNoUGl4dXJyRGNmdjdK?=
 =?utf-8?B?ODB3M3NuZHNrYXhqZk5CcEZ0eC9mNkdEOC9qRnFoNVdNQmRVTW1tU2Q4aFNh?=
 =?utf-8?B?eXJBdmNScTNZS0NCSWlOU3J1azQ5Q2lvZ3JLQ29Ldzg2UUNVdmJMNFFScEN5?=
 =?utf-8?B?NG5OWWhNazA2TGVVMFJ5MTJmZDlTSVdVTFBBU3E5RTVvb2xhUjVDUWZwZXQv?=
 =?utf-8?B?dlZXYm9LR3JBR1ZsUnRaUWNwd2RCVnlNVjBhMHY0VXFwalRXY3JTbU1kQTFC?=
 =?utf-8?B?VDhkQmdaRTdvalNrZSsvWm9nY0F2eFc5Sk1VYVlMU3kvNmt4c1FZZ1lXZ2hG?=
 =?utf-8?B?eFkrQ2Q3bmZzSkNMeWUzWHVaWXVVOFczVFNNd2RoOU9kR293OEJhTjAyVDhq?=
 =?utf-8?B?SlVEa0xOeDFlZE02VjJibFArMkdkbnR5YUF3VmYwVlRxT2ZJK3IzWEVZZkYv?=
 =?utf-8?B?UmpHaG5DTVZ2TFcxeGtQZ2VCbUFmTEtFT0ZtZEtnZW5heEdIR0ZBRElmT1k2?=
 =?utf-8?Q?ngLm/DIhtlV9PiGeO+Nl2/4WD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fb0c5d-143b-4b20-43f9-08dd779ada7b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 19:15:13.3179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5aDMbpVOdsae9hEMD3Kh9sx1lDhvbmEj3V8HZtIihf0oLn7CfcshAvEPhtkX50lR7Hc4rwHtu850AWUSuZFGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6611

On 4/9/2025 12:34 AM, K Prateek Nayak wrote:
> A subset of AMD systems supporting Preferred Core rankings can have
> their rankings changed dynamically at runtime. Update the
> "sg->asym_prefer_cpu" across the local hierarchy of CPU when the
> preferred core ranking changes.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Acked-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6789eed1bb5b..8796217ccc60 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -844,8 +844,10 @@ static void amd_pstate_update_limits(unsigned int cpu)
>   	if (highest_perf_changed) {
>   		WRITE_ONCE(cpudata->prefcore_ranking, cur_high);
>   
> -		if (cur_high < CPPC_MAX_PERF)
> +		if (cur_high < CPPC_MAX_PERF) {
>   			sched_set_itmt_core_prio((int)cur_high, cpu);
> +			sched_update_asym_prefer_cpu(cpu, prev_high, cur_high);
> +		}
>   	}
>   }
>   


