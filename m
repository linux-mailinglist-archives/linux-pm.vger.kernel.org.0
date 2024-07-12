Return-Path: <linux-pm+bounces-11020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FB792F466
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 05:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1EB2831DE
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 03:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2FDF4EE;
	Fri, 12 Jul 2024 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EXzQemcM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C97D528;
	Fri, 12 Jul 2024 03:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720754952; cv=fail; b=cKbuTE1wG5Kfc8eGJcWsabkW+NkKbu5Moytx4CttRostZcH8ndQI7vZ0NSKhoeqGWPP9C2T3N5LzkJGPLUDdkpo9Ds7ttWEARAARyKyPDb6WYLAFEDJud8zKCGN5NusI4F5jx/zr9X7dXMzBnOUy68mUa684E7JWeIa8bALcFwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720754952; c=relaxed/simple;
	bh=VuiRnoseWnsNPOwe4Tm+INg7O+X6UwRByqtSUUj+UOY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DCvvOVS89Npi2x7LxQmsuQvjs5Y8Hc2P5oADc6nE/TgtA0einas4UZw9cJLGYp8Mi0X0+kdoTvrZo1WL71I3fJOp9u37d1uqOjBC1pyAkOK4RNxajMlpdOpnZv0Bs3E5vHT8PDVyYG0CgZnR8Bf5Tgd3NrYWeHih9ctIK1pJXPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EXzQemcM; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQGR+ViYnAY/9syluKcCle2n8/MYzpENSYvKYtKGI6zJ3haBca6OqQ02JviJ+UaQYZgYuCbXsrEppGB0UGpSV5yDcZOBzW0CMFYiCN8fpwvMWRNx4XDkMvo44q3e3ivU9C2NUYzLWWm3O15LQZze2KrX/kyxRm8wzl3QiXDAOGhdNDf+TDUfXlwtx8pMUzozdIMBucIxWQlC0hrEAmXL/MyTvWWZsyN5BLuaJyhTfIHuMZQUmQy8B/ZmBG0ZmtktBnnYCAx5avRzMjE1nAo94728xbtJLV5satPwtork8vNA+6hVfJdUyJqVi/xHRunYsJJvTZYK9eNq8/BPuzmY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHH+IY45vTqpjU2RfLBbrni0HKZFAZZ9LltpQ3tqZVw=;
 b=m4UHnCLzkPYmAaiMox/W8ULmSk99a3n+rSSfdZHwiyhpFhTkwrmCrDzYa3+tyCPfrx4to4MxhkgEQxQv2R1GOrdLdDrzr4Igj6KaUa4XksvC0lHlrUEeyuacgj9gAhTMGlmU40ywoBbcwhxugz/XRGFeSPp/srSCvrNAyAzP6p1mxkANYbhoDrgU1qa30qU7iJobPYg3ElIkbRIvMieVIqPN8+9pXKasboJIetwEYW0zSjdmmsSNlLHgrmLE/bW51M/6vRd//f2JlzeXZcrvs4rTYJAJ2gkhWtvA7im8y5cznazvmgx77JVt2AWYTFnxTjU8ZkiJzQPC0kZEoJtGww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHH+IY45vTqpjU2RfLBbrni0HKZFAZZ9LltpQ3tqZVw=;
 b=EXzQemcMJtGf7OBxBRgutLSnTRMfbT4ybvzTRGHliwZoxNkwE/SWF7w9stkrEWNwRSmoZUbT9g4Ux0E9Gfe+DKyDTRynej04O0T2yiCw1Nmtl7S5bUvNVIykA+0WEbZGTd3P32Qhyaq9gG22dnzXo3Qw2Ii8Yxs809zwHNt8/9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 03:29:06 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 03:29:06 +0000
Message-ID: <193f190f-9020-411b-a5e1-6ad277b4be9d@amd.com>
Date: Fri, 12 Jul 2024 08:58:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] perf/x86/rapl: Fix the energy-pkg event for AMD
 CPUs
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "irogers@google.com" <irogers@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de"
 <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
 "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>
Cc: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
 <20240711102436.4432-3-Dhananjay.Ugwekar@amd.com>
 <4caed546c761218467796e5611430f23f070bf3f.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <4caed546c761218467796e5611430f23f070bf3f.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::16) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: a993224d-3624-4e32-8452-08dca222c8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTI4RnpEQ3cvMGRSMXpVT2tGa1E2eVlFdUZrOEtyOFdRL25rNmlqdmpDQVZs?=
 =?utf-8?B?YkIyalc0K0tFbGpDckRlK2VxRStQZ3RzU2N1bmsrcW52S0V4eE53NjlqQ25D?=
 =?utf-8?B?M2tERVIzS0xjQ3ZhNXNEb2wwQTVKWXEzSTVIZ1VHOFhWRWg4cFF3dEFJb28w?=
 =?utf-8?B?d21LYXpwdXdIaDkzK1g5bjlrSisycUlvSkRlbU90UWNhRk1PZUxNTTJNUHV0?=
 =?utf-8?B?ZkZCODB5SkhobE5UL1g5alFkaTN0a1VodWdITnV5WlZxKy8zS0Y1T2hoWHcv?=
 =?utf-8?B?Zzd5Rnl0YkVhaFNYc2t2ZCs4dndVc2M3QU5SV1FyU1BicXllNC9JT2p2Lzhu?=
 =?utf-8?B?Yk1Id3h6NG03WTVnQkcxdklVTExRcGN0TFc4dUlNRFZqS1FoZ0lXaWEzdXY0?=
 =?utf-8?B?SW84L0htOFBnc3JjeTQrdm9wVXRSVWF6M2VZbXdsZEtkVnM3N3lGcjU2THN2?=
 =?utf-8?B?SXdzM3ZHY0dvOHJFMXRtdC9CTm5GMml2LzhIaXFYV3lmMGMrNDBGSW1uYk5p?=
 =?utf-8?B?RC9DRk5ML0pzbGZPdnh6VnVKbFZMUXN6dGVkTko0Q1NHeFpTTmVtcEd0Y2tH?=
 =?utf-8?B?VFZHa0ZPVVUzT1pyQkZ2eVl5djdHWHIvRkh3ZnVaT2Z2VUVhcUVmMWpjWXV3?=
 =?utf-8?B?U0pHWXMzakwrL3RSeFlJNjllaGpJdGVyVi9vSzJGM2xJWHUzeDBWSmRqQ0Nn?=
 =?utf-8?B?amhkYk44U3lGekNrUU1KVktZdjBYbnd6b3JtSmpwaXYyeFZjSkJSZWdteEM3?=
 =?utf-8?B?VUdwak5xWlVYNXJIZGVjZTFnTlgrMW1Nb1VjejVGV1Q3MkFCNEdEb0U3b0xH?=
 =?utf-8?B?ZnlRckNSSTEwTE5QZlg3VG5TY2RwR0NMWjYwbi9CN0VhYUtvSG5JSWJwTjdr?=
 =?utf-8?B?WUwyaHVmbWVOb0hib0ZZZFRIMldBOHhQZTBkQUR1dERCWW1sdnk3ODZGZVNE?=
 =?utf-8?B?MHB1Q0VzU3hRaUU3QnlscFNMVjBOL0lUZVErWHk1UDNsb1NtMllEdTlhSmV0?=
 =?utf-8?B?VjJlVnNBaElsckVVNk5UZ2J0VGdhRjE0cjd2MFNvamNEdjZHeEFYaUtQNGRO?=
 =?utf-8?B?N3RIdG5OcHFrcGwraEhkdnpYcng4ZDN6MXIyYVZoVXpkaXpBOGpsMGNhMTV2?=
 =?utf-8?B?OVUvUG9jbU1uLzNLUlM0Qk9pWHhNclQzMVhqWldlT1NTZ2NBbUw4Wmk2VjhB?=
 =?utf-8?B?VGNkdUR0RW5hUGI4SUVuMTNudHJrTXZWZWdKNWZ3UFNGMEszb2xsNk9pMkZq?=
 =?utf-8?B?VDVYV2lTODZVYzB4ZWlld1RqY1VHM1dORVc5OU5uS2Voampwa29xZGxHclNu?=
 =?utf-8?B?RVkyVGVmd3JmNXFQamYzSzJLYWdadEJEMXZwakNFTi9sWmx6WDYyN3Q2WXBQ?=
 =?utf-8?B?bElLNVZvak9GR1RNY3pWUm9rMzJZdnRSRDMvRmV4alNDVnpjSUhiSUNKODRt?=
 =?utf-8?B?cSt2bXRtekM5dUgzbnVydkFENFFqQzlBWHJjZ3JjREVWSXM2cGZEa0wyUS95?=
 =?utf-8?B?ZkUwamx1V1NFZXg5bGYvUWFNejlyOHFwMEpyajVPZlNvK0lNa1N5QUdpK0dO?=
 =?utf-8?B?VjNwaWl0RmpWNmVlcUdKaVdTaHBRUFVDcUVwalRSNWs4ZnIxWkpFMGlId1F0?=
 =?utf-8?B?UDd3UHJLVit2QTYwZkdrK1RxTzNPS2VrcnZ6OWRnNWpNNVM4WVRobm11TUhH?=
 =?utf-8?B?M2VDOEJrV0lwaHc2MnpRY0ZUK1drdDVvYXFQVGtGaFgrVzNxZjEzbGRoenQz?=
 =?utf-8?B?eDl0UlliekhYUDV6SVBLdTc3OVMwY1Rnb1FETk5FcHJrYUJjeklMbmJITEl2?=
 =?utf-8?B?QlZ2L3l6WktVT1VWL212dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVNySzV1cSsyK0d4SitReFZKc2xlU284c3ZPdmlSam1QUWhBZVRURVRiY1lD?=
 =?utf-8?B?aDJzRWFHdlJGak9zQWxOZ0pHZ1Z5YVNuNGxGdEpGc1ZXOEkzV3RMVWU5TWd5?=
 =?utf-8?B?czZSREt2dUtsdGt5NWhTR3FGK2pQMGs5WkZNQ01zZC9jVUdaS3k1ajFESEtF?=
 =?utf-8?B?N1VLZVM0WXdmYy9DWnZUOHdiTjFSMi84NGYwQUphUmZDMlM2TGY5cXRDTHNw?=
 =?utf-8?B?RnpuUXdQbUNMSW0ycWNEVXdqclhjaGNSckFpUTgwNlpwLzltd29qb0ZOYWhX?=
 =?utf-8?B?aGd1R1JTb0lKL3JYTFNUOEFZRlB5RnhGZ3h5WlZLYlh4WWRwT3hWWEY1dW56?=
 =?utf-8?B?dkVFV0VmVVNMSzdzcmNBVGtUcGU5K3BnNFhGYlFDYjRZdTdLQklZZUZRRTBy?=
 =?utf-8?B?dCtHOTVQbkdmQ2JqZ0o2QVkrRG1GTU5JUnRXVnJaRFE1NEtCd2phZEFYMGx1?=
 =?utf-8?B?Z2RuYStuV1pPVHZVdXdCZWRlVHU2WWtMek1hLzhLV3FtSm51Qkp2Y0hVTFlJ?=
 =?utf-8?B?RWZtb3dncFJhdklibDR4eDlZS1dwZjlmRmJRM3UwcWRRRmt0clV0c3R0VmtT?=
 =?utf-8?B?MlJHVUJiRlh3TnB1YkdWTFRTbXVNcXBlZkRrSGl4cTJyWXg2MmVhT3FLTkp6?=
 =?utf-8?B?WVZyMEt2U09MRXh3OTdIU1FEaXNjeDlHWndrOVIwbE1HMDdnT2FjRXdTRUZB?=
 =?utf-8?B?OFRuRVB5cjRqZXVNL1BoM0dMVnRPTUF5QnpEN2g1ZlFUdUFRUGNydlBSVkVr?=
 =?utf-8?B?QXNDdjVEQnlYUnMwU0NZL1FOTkJTQ0QwQkJJQS96T0QzaWlwbWgzVGRjZ3dF?=
 =?utf-8?B?UFRIRnUzeDFVYmlEL0ZjQUk5c1RkYUR3SGdnWWhGdnFlSzJJMnFCY1pVQXFy?=
 =?utf-8?B?dHlkNWhCeEIrRlNFejBEZzNmRkt6b012cThqVC8xYlYvd1VKKzc2ZXFGc1hu?=
 =?utf-8?B?M0w1bHV3QWx2c1RJVjhvaVIrK1FFbFZia2FENWd5aEpIRWFBQVcrU1Q0ZmhI?=
 =?utf-8?B?cFE5Q3Q5aFRoeE54Z3V2K1RxVWh2dkNBYWQyRU9HZnA2a1FOVTB2dHRCK29P?=
 =?utf-8?B?T3REM1NWSXpFL0orUCszRGRncDJtUW83Vi9VVDdXL1dXWHRHMitiQ0tYak9T?=
 =?utf-8?B?S2tSeGM3R0RCT0tsa0xpcEdvcktiYThWMmZNeTJyVEl3RGVzNmpIVm9QRGhv?=
 =?utf-8?B?dDBvZnhjRW8xL25aYmd6NjZMUnU1TWZHaWlmZnZ3S29qTlB4TnliWUxRTjJK?=
 =?utf-8?B?bmI1RjJ2MFFLVWcyaGwzUDUyWTNTbDFKb0EwdXA0RHpNNFdtK3VwRlRZNElX?=
 =?utf-8?B?TzZnSklWTjM1bFVXL0g5Z1VaS1ErNG9NNEs5VGI2TWs4enkwbHBHMUxIdVpw?=
 =?utf-8?B?L2ZGL3VxM3diYi9DSjFPUEJscCtxaEZlazFMZE0ya2cyYTZObkhkckhWNFVU?=
 =?utf-8?B?cmlVRy9Zd1ljbDRhK1NNR21yWGxsSmM2K1lXQnNldlV0blBFSkRrNXl2MTUv?=
 =?utf-8?B?a3J0eG44T3g1REJuUmxpRWhHSGhlOHpvTmJnUEZLRmxyMUY0TGlvY1djNzhC?=
 =?utf-8?B?cWt2TW5ZdXcydkhQdHJua0E1emxQcHlYSmxiY29vSnhDYThZaWh3N1JEQkV0?=
 =?utf-8?B?ZFNTWFpWMWxDbVRCaGdLWk1ZSWVzSkJ6cGJDOUxKS01RQTlsNk85NnZySXlX?=
 =?utf-8?B?MDFad3ZHQVRXeW43VUxGN1ZLOGJjTERGVGMxcmgzSXQxellnbjA1QjdUVEV6?=
 =?utf-8?B?Ympid3NJZTdQbHZRNjBrV3p3WEFWUTZXbGxSSmFKc0dMakhwM2RBUDZ3S0ov?=
 =?utf-8?B?MUpRNitkNkR6NEJ4aEVvVGtVREFkTnpFUFpwemNyRGJmRVNFY1ZmSUJReGxz?=
 =?utf-8?B?VmlkV0ZMSFV2QVF2NklUMElQNHdKaU5JWDc0RE9mLzFFWnJPWDhYajFJdk8z?=
 =?utf-8?B?cmpEa2hUeVliWm9FR1A1aEoxdUZUc0haQVFJdmxQdXRXYnh5aXZBdWRxM0p3?=
 =?utf-8?B?RjBsemwxdFpmcW15Z3paeG5jMzdvUkFUbFFnYkNtTUs5d3RNclN4TTh5RW5N?=
 =?utf-8?B?ejl0azVDQnVNQXBmeFY5SFhsdXE3UjExWkpDbC9pellSZStEczZ2WXVFMDM5?=
 =?utf-8?Q?fBmyb97q4vUbgXTBOpa/mj2nz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a993224d-3624-4e32-8452-08dca222c8d2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 03:29:06.4822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEt4t39K2LRf7yE640/Vu5dVwBwOJOTg3H+s08J+p/3makLXdWnlAH1vV+WrT2zft7MjkbjsO2PbUtlQB56sJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088

Hello Rui,

On 7/12/2024 7:34 AM, Zhang, Rui wrote:
> On Thu, 2024-07-11 at 10:24 +0000, Dhananjay Ugwekar wrote:
>> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026
>> leaf"),
>> on AMD processors that support extended CPUID leaf 0x80000026, the
>> topology_die_cpumask() and topology_logical_die_id() macros, no
>> longer
>> return the package cpumask and package id, instead they return the
>> CCD
>> (Core Complex Die) mask and id respectively. This leads to the
>> energy-pkg
>> event scope to be modified to CCD instead of package.
>>
>> Replacing these macros with their package counterparts fixes the
>> energy-pkg event for AMD CPUs.
>>
>> However due to the difference between the scope of energy-pkg event
>> for
>> Intel and AMD CPUs, we have to replace these macros conditionally
>> only for
>> AMD CPUs.
>>
>> On a 12 CCD 1 Package AMD Zen4 Genoa machine:
>>
>> Before:
>> $ cat /sys/devices/power/cpumask
>> 0,8,16,24,32,40,48,56,64,72,80,88.
>>
>> The expected cpumask here is supposed to be just "0", as it is a
>> package
>> scope event, only one CPU will be collecting the event for all the
>> CPUs in
>> the package.
>>
>> After:
>> $ cat /sys/devices/power/cpumask
>> 0
>>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD
>> 0x80000026 leaf")
> 
> You still missed my Reviewed-by tag for this one. :)
> https://lore.kernel.org/all/e1f70a09f85dbd0ee3f32dffea37993e141269d0.camel@intel.com/

I didnt forget this time, just wanted to give you a chance to review the changes :) (although they are minimal)

Will surely add it in next version! 

Thanks,
Dhananjay

> 
> thanks,
> rui
> 
>> ---
>> Changes in v4:
>> * Invert the pkg scope check in init_rapl_pmus() (Peter)
>> * Add comments to explain the pkg scope check (Peter)
>>
>> PS: Scope check logic is still kept the same (i.e., all Intel systems
>> being 
>> considered as die scope), Rui will be modifying it to limit the die-
>> scope 
>> only to Cascadelake-AP in a future patch on top of this patchset.
>> ---
>>  arch/x86/events/rapl.c | 39 ++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 34 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index 0c5e7a7c43ac..df71f38ad98d 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -103,6 +103,13 @@ static struct perf_pmu_events_attr
>> event_attr_##v = {                              \
>>         .event_str      =
>> str,                                                  \
>>  };
>>  
>> +/*
>> + * RAPL PMU scope for AMD is package whereas for Intel it is die.
>> + */
>> +#define rapl_pmu_is_pkg_scope()                                \
>> +       (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||  \
>> +        boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>> +
>>  struct rapl_pmu {
>>         raw_spinlock_t          lock;
>>         int                     n_active;
>> @@ -140,9 +147,25 @@ static unsigned int rapl_cntr_mask;
>>  static u64 rapl_timer_ms;
>>  static struct perf_msr *rapl_msrs;
>>  
>> +/*
>> + * Helper functions to get the correct topology macros according to
>> the
>> + * RAPL PMU scope.
>> + */
>> +static inline unsigned int get_rapl_pmu_idx(int cpu)
>> +{
>> +       return rapl_pmu_is_pkg_scope() ?
>> topology_logical_package_id(cpu) :
>> +                                       
>> topology_logical_die_id(cpu);
>> +}
>> +
>> +static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
>> +{
>> +       return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
>> +                                        topology_die_cpumask(cpu);
>> +}
>> +
>>  static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
>>  {
>> -       unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
>> +       unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>>  
>>         /*
>>          * The unsigned check also catches the '-1' return value for
>> non
>> @@ -543,6 +566,7 @@ static struct perf_msr amd_rapl_msrs[] = {
>>  
>>  static int rapl_cpu_offline(unsigned int cpu)
>>  {
>> +       const struct cpumask *rapl_pmu_cpumask =
>> get_rapl_pmu_cpumask(cpu);
>>         struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
>>         int target;
>>  
>> @@ -552,7 +576,7 @@ static int rapl_cpu_offline(unsigned int cpu)
>>  
>>         pmu->cpu = -1;
>>         /* Find a new cpu to collect rapl events */
>> -       target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
>> +       target = cpumask_any_but(rapl_pmu_cpumask, cpu);
>>  
>>         /* Migrate rapl events to the new target */
>>         if (target < nr_cpu_ids) {
>> @@ -565,6 +589,8 @@ static int rapl_cpu_offline(unsigned int cpu)
>>  
>>  static int rapl_cpu_online(unsigned int cpu)
>>  {
>> +       unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>> +       const struct cpumask *rapl_pmu_cpumask =
>> get_rapl_pmu_cpumask(cpu);
>>         struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
>>         int target;
>>  
>> @@ -579,14 +605,14 @@ static int rapl_cpu_online(unsigned int cpu)
>>                 pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
>>                 rapl_hrtimer_init(pmu);
>>  
>> -               rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
>> +               rapl_pmus->pmus[rapl_pmu_idx] = pmu;
>>         }
>>  
>>         /*
>>          * Check if there is an online cpu in the package which
>> collects rapl
>>          * events already.
>>          */
>> -       target = cpumask_any_and(&rapl_cpu_mask,
>> topology_die_cpumask(cpu));
>> +       target = cpumask_any_and(&rapl_cpu_mask, rapl_pmu_cpumask);
>>         if (target < nr_cpu_ids)
>>                 return 0;
>>  
>> @@ -675,7 +701,10 @@ static const struct attribute_group
>> *rapl_attr_update[] = {
>>  
>>  static int __init init_rapl_pmus(void)
>>  {
>> -       int nr_rapl_pmu = topology_max_packages() *
>> topology_max_dies_per_package();
>> +       int nr_rapl_pmu = topology_max_packages();
>> +
>> +       if (!rapl_pmu_is_pkg_scope())
>> +               nr_rapl_pmu *= topology_max_dies_per_package();
>>  
>>         rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus,
>> nr_rapl_pmu), GFP_KERNEL);
>>         if (!rapl_pmus)
> 

