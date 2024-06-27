Return-Path: <linux-pm+bounces-10107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F36B91A4BF
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 13:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6D628311F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 11:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BB51482F5;
	Thu, 27 Jun 2024 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WSneaU9u"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB02313BACC;
	Thu, 27 Jun 2024 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486807; cv=fail; b=CaqSO/sfGjW1fuUXTb9hG/ryrnO5mgPqFIEZzMWOcL3Lt8RFAvwobQXt/z1d9QIRovvNEyqY8E6CPBw4rerUneZ4u76DqANQnWiTDt6298vzvz62CKtv2n5pnk2dcLq0SnIAJdztl8pBq+XsCsWMQ/dWo1uKvnlHsrgNk97Swmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486807; c=relaxed/simple;
	bh=GT8VuPOf4Z2/7m6441fPaLPJ/7kW3yse84Wsq39uuXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QTzZL/0nkyn5AF6mc6xZauEOgNYeGNWcXl9ijnmNYorA9k2ANBIkrgm3zxdJbt/4Y91QRiWK4ro2LaJRz7uk0dWtLaLYoGygm6MRy/W0iLDO4hUiTiOa5oPxpdXLEKTqqXn6AX437FDJ9ZgX7MYWe/2bTGj4I3cXNy9Ro+byGcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WSneaU9u; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/8MnBd9xoSEnlbqYrbOmeHPKtW6dJU6k2Vnjf8PpcLzE8WBQywMksQY/gmRgC/uTTbyDYGs0d65jFw6g+vViwoghd1STB/a+CztARjRJPrILy+EXuKI3EAjtW/gAVzXBDW0KNQGJ5cLBGTe59GQltCaE2X0qFz5x5r5gS8vm49W8pOpdI1sBydZ69qL2VL+qKtqNTXWDNovErvCT6T34rzUa6WS0NzXF1EwGD49mLDS9uqntdg/Zti/jTS5cRSghi7LCMMnXNrn0lUTRFtMCkRzfz4TrCuOdNx/jjdvcZOA+X967xSisyhSuUMMHZaGs4W+v4okgIhASzf8/yn0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecYF1O94PyCjHjuG5DGj1pCRVyUq1iTdNiuKmm+UxPY=;
 b=eOJu5t3d+hM/+WcXBTAogMxuA30RVXY3eaAbOoHPidIKuFY2m9DgTEFiOzDTUHkWbWjITAMgd6kQebB03Zx5fYggu4E10e97WAE9jNuDsX1fvWx/JlsglyXgLRxjxFP2p4tK8O9TLp8g2hzp1+OKQbKrT953dQE30SDtyjKej8fmJSSm2i1gIDw24jBptUFqFAo6Lt8ztBbsg8ZGV4+/8+eIZVNMNXTc0zfuyXhsdQ81Px5gFMxg+WnK2Yc/1vFiG0rSjza4WXXoeq2kjii2/PKEj146y5M21iLG4ZyFtHVYjRi/fSKZZ6472eVSOuq1rYKU94hIim8lWyvFqzHxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecYF1O94PyCjHjuG5DGj1pCRVyUq1iTdNiuKmm+UxPY=;
 b=WSneaU9uknBpXBlExdXOk3tXbaRo1rKB/MO07XGALsd2f1zYqOaZngt3h0dnYQtcUY+Ew+lVHhLihvonRS8G0sNvJGdKQ58Y/rly2OTYyZhNUwTOZG/8Y+1K8tEUhN9fvwuSZO5x/sr9Gg+yYBJMi2Db1q6ckpEAZKy2Uu6k9JA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:13:22 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 11:13:22 +0000
Message-ID: <a33b64e1-51bc-4c71-b342-7f1e4257e2f4@amd.com>
Date: Thu, 27 Jun 2024 16:43:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] perf/x86/rapl: Add per-core energy counter
 support for AMD CPUs
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "irogers@google.com" <irogers@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de"
 <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>
Cc: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
 <20240624055907.7720-11-Dhananjay.Ugwekar@amd.com>
 <18e0c72823d916d82aa48fb6690375f960a9d9ea.camel@intel.com>
 <dff31583-adaf-4da8-954e-f35f7ef5a5d3@amd.com>
 <f2dfe380f06bdde6bf4aabc9c45ddea7e28d35fd.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <f2dfe380f06bdde6bf4aabc9c45ddea7e28d35fd.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::30) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SA0PR12MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: 8560342e-bbdc-42dd-7ea6-08dc969a27dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmExZzllOUNHQ1dvZ0s5YUVOVlR1Zzg0OFVjZmJKV2cyamNjL1lxQ1RMSjc2?=
 =?utf-8?B?SzljVEJsWDZ2enJkZDIvUEhlR3VOdW1wTGRrNkVhdDE3dG5WcHV5Y3Z1bDZZ?=
 =?utf-8?B?eU83QlV6Ym8vYkIwQktQTzRYN1JMQithbWpLd21tL0F5THJxRlU0R0xhWVlP?=
 =?utf-8?B?bnhhYXZrRGQ2cjhpRTR2QmJlRGZFbkxqZVhWeGl3eHh0VnRNZlJISnVnTGlY?=
 =?utf-8?B?NXBubUhZL0xNZVZ0OTBicndQT1Y2ZVp6MUlwb0EvZU16RFZvT0Zad3dWamN3?=
 =?utf-8?B?cEM0QUdrMFMzeXFaeGtzR3dwbndwNzZWVlFrdTE3Y2JKb0VTbGJkU2EybFFk?=
 =?utf-8?B?bEZ2YTVlM1NSMzRJTWRJQmtjcGh5MmlzdE82dENYN1VlRUVST0VCaFZQRXRP?=
 =?utf-8?B?RjUzR056R25yTGtodG5jNHU5OEljaHkxbTVuWUZDREkzcytWRmlEN1YvWFV6?=
 =?utf-8?B?aWwwdW1GcGwwVFVrTmExRHFXUEZGQndneVg0djdLZFJHdVRQbFc2dTd0SzdD?=
 =?utf-8?B?dzRIVmJnbFo4SERDYzdxcXBETlF1eEJsZktRWmIzRjAzOGNaRnBHMjIxc2Iv?=
 =?utf-8?B?SGw4OW1ZVUNXZzVSSDVMVHRTcTdYWGlkN2ZpVjIvaTJvSlM5UG1TWEFaN3Jm?=
 =?utf-8?B?TlEwQmZFbHRPRU5vb2plT09hemhOaXA2UUhFM2srQmNCOURKVTU4ZE5qbW94?=
 =?utf-8?B?L1pQMTVaUW1vaHB2QWVvd3hTREJlOXZ4di81M3liTDVEVUpxK0IvaUdpN2k0?=
 =?utf-8?B?a0hIT2cvWjFqTCtubzFCSUQwcWhBNzB2QmV3eEIxbGZSVGpDemlqTGVXc2xC?=
 =?utf-8?B?VXRSaThuUHR5dldtWVRnZGwrSDU1YzdtamNudDRocmVtTnU0bmNKY3VqeFJp?=
 =?utf-8?B?dHlaREMxd0hHUnMwWkFZSWFHS0pDd1htK3ErbXE2MUtsUVRoN0JKdmtvbDI0?=
 =?utf-8?B?c1dtTGREQU9sWGdGMXM4cWZPSEp2MmlQVU13NklIWUNFRVVTZFpQWERxUFk1?=
 =?utf-8?B?RVBQVlNTNGlxWG10TldYQ0hLaFYzSTZ6Sm9xYWl3UmFFdEJVTHJ1YU5xd28r?=
 =?utf-8?B?eUEycTRkUXQ4eUE5WTVWd1hWMkoySExFNUdaRlNkK1YxN054c2MwTVRHNHhQ?=
 =?utf-8?B?ZEdGRFFXRnNPbkFYaDZEalhzWjI1VUR1bFIzNG9WYXM3Z1d2ZlpzdEt0bDha?=
 =?utf-8?B?U1RRbXd2NFErREZFT3BuRitLR1ZNZXUwSmQyUUw2ZWFZSUFKUmpUWEF1OEFa?=
 =?utf-8?B?YStYdlF3dmJGdlJZNnpGQXBRc3NsQzNlOUtkSFVWUThmWWZLUU50OCtWVmpj?=
 =?utf-8?B?WGlVd2JHeU5BM3oyd2pkWk5iNjczSHdjK2w5RE9OdldreWZMQUMzUzlzQktH?=
 =?utf-8?B?bHVwNEh0VmRMZ1V3T1E0RWVKUnZzUjhMbTQzQTZMSS9FSDRMLzhUZzFUUy92?=
 =?utf-8?B?TVZYM0V3U1RzWC9UcERyNkgydVpiRHp0OGNYUjJ0WjNuOFFFaUhXTjdMbkhG?=
 =?utf-8?B?MDNrVGF3VVV2MDQxQ0laM1Q4eS8zVjBta0F4RURzWlFVNWRZeXppbzdRU3pT?=
 =?utf-8?B?eHkyRURWVEFMWmhCVGlzZlFJMXBKSSt0Rk1mWlo5OXNzRjA2Tm9PemZCWG42?=
 =?utf-8?B?cGhma1hvNzMrMDk5UllwN3AwMlBlQlY2TnFIS1dEd2hLRHM2MnhKNmY3NDN5?=
 =?utf-8?B?SUgxNVJuekl3RGlZTGtCSTZoK0tBZFNYa0tDRi9FeUdFWXplNHlDZ1VkUVRI?=
 =?utf-8?B?Q3BVcWloZEZxQXNBelFYOVpoL2pqdWlyd053MkRnM0d6ZEJhZjRtMXAzSjRU?=
 =?utf-8?B?aEUraDgzUDF6UFBVL3d2VnVnc1k1cHQ4N0ltUmhiMzJxK2poWGd0RTIyS1Bj?=
 =?utf-8?Q?aGSYw4Asm3N37?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWRuY0JqcmZ1QzZzN2J1c2oxaVZFT29ySVY1YU4yRnA0YkhsRVlqWENLWnZK?=
 =?utf-8?B?aWZqdjlNazgzenUyS0hYUjJWaWxxM2M3cVpjNXRHOUR5MThXRWlUTWZhQzEz?=
 =?utf-8?B?OVMwOEVJT2pyaFFwNlp4eG1zTE5JWmM1Ti8wY0lkeGZyNW5ldjN4NHI2SHpO?=
 =?utf-8?B?MytSbldMeDVNc0V5eHlzOWh0MUlkak9ENjAxRVF1SFQ3b0ZDc0laWnlSRm0r?=
 =?utf-8?B?MlZGZ3hHYjFDdUI1cFRlRllPZXpTd28rRnZhWXlOWEdWZXNGRlBDTzhlcGUw?=
 =?utf-8?B?SUpLMEY1T3ZDaHlOanljd0pFSWdCcGdYM0EvRWhvOWFmeG1VQVRid2dVNmZS?=
 =?utf-8?B?a2RUYmRJS21YYjc4UTd0M053TUFwYkdJNmI3dytSUDZFTHU3OHdFdWtmUzlI?=
 =?utf-8?B?TndFUDROUzRWRTBwQlNWanE4dEZCQ05qRFpKMmNEeGtnNDM1bHlGQUM3MVdG?=
 =?utf-8?B?NVhBNEtrL292aGtqRUNKTHRJWUx2LzZBWXhhQ3VoNGRIdFpXK09yTlBuL0o5?=
 =?utf-8?B?RUV4SEZUOXUxR2lIelpsTkE1MTA5cUFyejBESkVoZy9qNmUxc2N5cHZ3ZnlX?=
 =?utf-8?B?UWhOK3czK2lkUmhnN2VXNVNiQ1VHN3FHSDFhMU1SaXpPb0ZJMUIzblEvTWVR?=
 =?utf-8?B?UytWeGx1Z0Z2ZWN5LzQzTUJjUTVSL2oxSVNOK285SVB5bjNHS3pkQ25GbTdN?=
 =?utf-8?B?anppZi9vZGhxcHBxaUhjQWlXcFBaUWFEd0Z2QUJBcEJnb1lOUTZzcGIrbHdo?=
 =?utf-8?B?Y01UOXRzS21QNEh4VmMyWlVUemRzR0IzMGdENGZsNitUSmJ5Q09jL29QcXNB?=
 =?utf-8?B?ckhMU3kwTmowbU81eERkODY3T2cwamFUL3lyeFJFdUdnSWxveU1wMEZOdm0w?=
 =?utf-8?B?dzBDcVEwZVlUbk01VllMZGpnZ3AvN3hYN25nQnZjRkNPR1BHcit1SFF6cTZy?=
 =?utf-8?B?dE54UDNqUTZxZldjMWYzQWVHVjJETEdnNnFoUnpuaVJmWG9oZFc4NUVnaXpE?=
 =?utf-8?B?UjBJL0w5R25LdWhKVHk2S3FkWFkyYi9UU3VHUG1HTUZybGtxYTJubUt1bjZq?=
 =?utf-8?B?RXcrQ0dLUTRRcjlXQk1YcW01bGh2WUEyeVZzUVdnZVBSYjhzWTIwZmVuVk1D?=
 =?utf-8?B?Mys0Mk5WOXlEK3FEa29pUi9zNUhtMXBEY2VJUjQyMWs5U0Jzamh1VU11L3BO?=
 =?utf-8?B?b3hpbGd5Ukx0dkM5OWQ4RzRKbkI2WlpMTHFmSkp5YUZCRStkY2pwYmV2RUw0?=
 =?utf-8?B?d3VodU9RbWVaN0pmcHplSi9uQytIT201VFdKcktOWndtVWFOZENSWVRONlYx?=
 =?utf-8?B?QUx0MEsvdXZPcU02OGp0S2hoUGJUSWF2TGF2Ky94blN6N2pNVm8xNmROc0hK?=
 =?utf-8?B?WldQMEZsYjI1WWNVYWZ2Rzd0Vi8zaUptYW9LL0tpR0gxS25UVUpOZUJLL05Y?=
 =?utf-8?B?NnFtTEdaOEpKMm02K2VWMnZsSEFxbjdTQmpZeGxMUC9Td0tFK2JvSmVIeEhj?=
 =?utf-8?B?d1BkbUxMS2JMK3ZjK0dVY0Z4VkQ1cHdDMUx5ZndVMjRycndHVUJSNFVZd0x2?=
 =?utf-8?B?SXVuR2NTZjIyaUZGdERYRXZOZUtsOEZJdjcrYXFrRU5WRWgwOW1jWm9USGdj?=
 =?utf-8?B?WUhxR2Nyclhha0F1Y2Zya3czand6U083RWljaWRsb0pjNmoyR1N1TFplcEdW?=
 =?utf-8?B?V1hzencwbG1FTGJuVVhwcGZocWtHY1VtQ3RPUEhCWjRtbDc1TWtsWERSRzFC?=
 =?utf-8?B?V1VLV25sS0dyQnpuQWNDdWd3SVBxTUx5YTZxSW1LbFNNYTdLVVdlbkEweUtM?=
 =?utf-8?B?b3lUZ2xVVjhveEFDNmxDd09BYUd1Zm9QMEM0bkZudFFaNTVkdER4ZjhMVDNh?=
 =?utf-8?B?RDFqVmxHQlNITTNybDlTeXFOdE13RXJ0S1BqRjZ1dDZYNURWVHh2YTlyZGgz?=
 =?utf-8?B?VzIzendtZDZvTklOb1I4V0M1RGRKMjN2QVNwNlpISnVMUzRuSHczdmRsY3VK?=
 =?utf-8?B?MHQvL2p3NnpMTU5kWVVLVFdRa3EyNTdGQnBPcmR5d01Sc2ZYS2pmSzhOaXV5?=
 =?utf-8?B?TmlockxRYkxOTktqVkJlZlA1YnNCbExNektYNGlwQzF0ZWdTMWN5NjhYMnFj?=
 =?utf-8?Q?aWmCBzpMBi/bRIjqisn/0/MBS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8560342e-bbdc-42dd-7ea6-08dc969a27dc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:13:22.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: He+m1TrXNtGlHrk6KgKrbjKDjDC1Bdj5VjqM0rfNY/dIXNduZqE49WfcBhPVstIU3poNewCJYsCzVTd/WaV5NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478

Hello Rui,

On 6/27/2024 12:19 PM, Zhang, Rui wrote:
> Hi, Dhananjay
>>
>>>
>>> [...]
>>>
>>>> @@ -685,6 +774,13 @@ static void __init rapl_advertise(void)
>>>>                                 rapl_pkg_domain_names[i],
>>>> rapl_hw_unit[i]);
>>>>                 }
>>>>         }
>>>> +
>>>> +       for (i = 0; i < NR_RAPL_CORE_DOMAINS; i++) {
>>>> +               if (rapl_core_cntr_mask & (1 << i)) {
>>>> +                       pr_info("hw unit of domain %s 2^-%d
>>>> Joules\n",
>>>> +                               rapl_core_domain_names[i],
>>>> rapl_hw_unit[i]);
>>>
>>> rapl_hw_unit[] is for package pmu only and
>>> rapl_hw_unit[0] is rapl_hw_unit[PERF_RAPL_PP0] rather than
>>> rapl_hw_unit[PERF_RAPL_PER_CORE]
>>>
>>> you cannot use rapl_hw_unit[i] to represent per-core rapl domain
>>> unit.
>>
>> Yes right, I saw that all the elements in the rapl_hw_unit array were
>> actually 
>> using the value from the same register "MSR_RAPL_POWER_UNIT" or
>> "MSR_AMD_RAPL_POWER_UNIT".
>> Except for the two quirks,
>>  
>>  737         case
>> RAPL_UNIT_QUIRK_INTEL_HSW:                                           
>>                                                                      
>>                                                       
>>  738                 rapl_hw_unit[PERF_RAPL_RAM] =
>> 16;                                                                  
>>                                                                      
>>                      
>>  739                
>> break;                                                               
>>                                                                      
>>                                                    
>>  740         /* SPR uses a fixed energy unit for Psys domain. */
>>  741         case RAPL_UNIT_QUIRK_INTEL_SPR:
>>  742                 rapl_hw_unit[PERF_RAPL_PSYS] = 0;
>>  743                 break;
>>
>> So, as for AMD systems the rapl_hw_unit[] elements will always have
>> the same value, I ended 
>> up using the rapl_hw_unit[PERF_RAPL_PP0] for
>> rapl_hw_unit[PERF_RAPL_PER_CORE], but I do realize
>> it is quite hacky. So, better to do it cleanly and add a separate
>> array/variable for the core events.
>>
> yeah, that is much better.
>>
> 
>>>
>>>>  
>>>>  static struct rapl_model model_amd_hygon = {
>>>>         .pkg_events     = BIT(PERF_RAPL_PKG),
>>>> +       .core_events    = BIT(PERF_RAPL_PER_CORE),
>>>>         .msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
>>>> -       .rapl_msrs      = amd_rapl_pkg_msrs,
>>>> +       .rapl_pkg_msrs  = amd_rapl_pkg_msrs,
>>>> +       .rapl_core_msrs = amd_rapl_core_msrs,
>>>>  };
>>>>  
>>>>  static const struct x86_cpu_id rapl_model_match[] __initconst =
>>>> {
>>>> @@ -858,6 +957,11 @@ static int __init rapl_pmu_init(void)
>>>>  {
>>>>         const struct x86_cpu_id *id;
>>>>         int ret;
>>>> +       int nr_rapl_pmu = topology_max_packages() *
>>>> topology_max_dies_per_package();
>>>> +       int nr_cores = topology_max_packages() *
>>>> topology_num_cores_per_package();
>>>
>>> I'd suggest either using two variables nr_pkgs/nr_cores, or reuse
>>> one
>>> variable nr_rapl_pmu for both pkg pmu and per-core pmu.
>>
>> I understand your point, but the problem with that is, there are
>> actually three scopes needed here
>>
>> Some Intel systems need a *die* scope for the rapl_pmus_pkg PMU
>> Some Intel systems and all AMD systems need a *package* scope for the
>> rapl_pmus_pkg PMU
>> And AMD systems need a *core* scope for the rapl_pmus_per_core PMU
>>
>> I think what we can do is three variables, nr_dies (for all Intel
>> systems as before), 
>> nr_pkgs(for AMD systems rapl_pmus_pkg PMU)
> 
> Not necessarily, we already uses rapl_pmus_pkg for intel systems,
> right?

Yes, but scope of rapl_pmus_pkg is actually *die* for some Intel systems
(Xeon Cascade Lake-AP to be specific), right?

Whereas, all AMD systems have pkg scope for power PMU.

> 
>>  and nr_cores(for rapl_pmus_per_core PMU)
>>
>> Sounds good?
> 
> what about just one variable "count" and reuse it for every cases?

Sure that would be cleaner, albeit not that explicit, will make the change 
in next version

> 
>>
>>>
>>>> +
>>>> +       if (rapl_pmu_is_pkg_scope())
>>>> +               nr_rapl_pmu = topology_max_packages();
>>>>  
>>>>         id = x86_match_cpu(rapl_model_match);
>>>>         if (!id)
>>>> @@ -865,17 +969,34 @@ static int __init rapl_pmu_init(void)
>>>>  
>>>>         rapl_model = (struct rapl_model *) id->driver_data;
>>>>  
>>>> -       rapl_pkg_cntr_mask = perf_msr_probe(rapl_model-
>>>>> rapl_msrs,
>>>> PERF_RAPL_PKG_EVENTS_MAX,
>>>> +       rapl_pkg_cntr_mask = perf_msr_probe(rapl_model-
>>>>> rapl_pkg_msrs, PERF_RAPL_PKG_EVENTS_MAX,
>>>>                                         false, (void *)
>>>> &rapl_model-
>>>>> pkg_events);
>>>>  
>>>>         ret = rapl_check_hw_unit();
>>>>         if (ret)
>>>>                 return ret;
>>>>  
>>>> -       ret = init_rapl_pmus(&rapl_pmus_pkg);
>>>> +       ret = init_rapl_pmus(&rapl_pmus_pkg, nr_rapl_pmu,
>>>> rapl_attr_groups, rapl_attr_update);
>>>>         if (ret)
>>>>                 return ret;
>>>>  
>>>> +       if (rapl_model->core_events) {
>>>> +               rapl_core_cntr_mask = perf_msr_probe(rapl_model-
>>>>> rapl_core_msrs,
>>>> +                                                   
>>>> PERF_RAPL_CORE_EVENTS_MAX, false,
>>>> +                                                    (void *)
>>>> &rapl_model->core_events);
>>>> +
>>>> +               ret = init_rapl_pmus(&rapl_pmus_core, nr_cores,
>>>> +                                    rapl_per_core_attr_groups,
>>>> rapl_per_core_attr_update);
>>>> +               if (ret) {
>>>> +                       /*
>>>> +                        * If initialization of per_core PMU
>>>> fails,
>>>> reset per_core
>>>> +                        * flag, and continue with power PMU
>>>> initialization.
>>>> +                        */
>>>> +                       pr_warn("Per-core PMU initialization
>>>> failed
>>>> (%d)\n", ret);
>>>> +                       rapl_model->core_events = 0UL;
>>>> +               }
>>>> +       }
>>>> +
>>>>         /*
>>>>          * Install callbacks. Core will call them for each online
>>>> cpu.
>>>>          */
>>>> @@ -889,6 +1010,20 @@ static int __init rapl_pmu_init(void)
>>>>         if (ret)
>>>>                 goto out1;
>>>>  
>>>> +       if (rapl_model->core_events) {
>>>> +               ret = perf_pmu_register(&rapl_pmus_core->pmu,
>>>> "power_per_core", -1);
>>>> +               if (ret) {
>>>> +                       /*
>>>> +                        * If registration of per_core PMU fails,
>>>> cleanup per_core PMU
>>>> +                        * variables, reset the per_core flag and
>>>> keep the
>>>> +                        * power PMU untouched.
>>>> +                        */
>>>> +                       pr_warn("Per-core PMU registration failed
>>>> (%d)\n", ret);
>>>> +                       cleanup_rapl_pmus(rapl_pmus_core);
>>>> +                       rapl_model->core_events = 0UL;
>>>> +               }
>>>> +       }
>>>> +
>>>>         rapl_advertise();
>>>>         return 0;
>>>>  
>>>> @@ -906,5 +1041,9 @@ static void __exit intel_rapl_exit(void)
>>>>         cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE)
>>>> ;
>>>>         perf_pmu_unregister(&rapl_pmus_pkg->pmu);
>>>>         cleanup_rapl_pmus(rapl_pmus_pkg);
>>>> +       if (rapl_model->core_events) {
>>>> +               perf_pmu_unregister(&rapl_pmus_core->pmu);
>>>> +               cleanup_rapl_pmus(rapl_pmus_core);
>>>> +       }
>>>
>>> we do check rapl_pmus_core before accessing it, but we never check
>>> rapl_pmus_pkg because the previous code assumes it always exists.
>>>
>>> so could there be a problem if some one starts the per-core pmu
>>> when
>>> pkg pmu is unregistered and cleaned up?
>>>
>>> say, in rapl_pmu_event_init(),
>>>
>>> if (event->attr.type == rapl_pmus_pkg->pmu.type ||
>>>    (rapl_pmus_core && event->attr.type == rapl_pmus_core-
>>>> pmu.type))
>>>
>>> this can break because rapl_pmus_pkg is freed, right?
>>
>> Hmm, I think this situation can't arise as whenever the power PMU
>> fails, we 
>> directly go to the failure path and dont setup the per-core PMU(which
>> means 
>> no one will be able to start the per-core PMU), 
>> Please let me know if there is a scenario where this assumption can
>> fail.
> 
> I mean if we do module unload and access power-per-core pmu at the same
> time, could there be a race?
> 
> why not just unregister and cleanup the per-core pmu before the pkg
> pmu?

Yes, better to be safe, will reorder the cleanup.

Thanks,
Dhananjay

>>
> 
> thanks,
> rui
> 

