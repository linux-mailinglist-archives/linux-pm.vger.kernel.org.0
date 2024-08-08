Return-Path: <linux-pm+bounces-11994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F2994BD08
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 14:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3A12891B9
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 12:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94F818C348;
	Thu,  8 Aug 2024 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V+NsP/V8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1321487C8;
	Thu,  8 Aug 2024 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119073; cv=fail; b=Xs7fyBL81jYdT3q4E7KH3SsWptV8FmQWrH1vVOr/qPJDLQeiu/a+ap1WwvhCwqSZV5mDWWDnuO9NC8KnjMlfZpH7aj/fi+jGy0FBY5JHsMq0DLXwToML0oUcMwvfZBMiz/3ls5ni/MTxl4qFc8iB/RttLq/70W5O9mJ8XhIrUKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119073; c=relaxed/simple;
	bh=6J4+8tfLRuj0LNWPN5Kmxb2oAOwnPfDUygkpq8j62YA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XkIvho94ygcbEbLNHXOILTjRB9Ct6fSyDKZtDyAAult4bm0NM+y0ewiDJQJGY2RV7f43sJu1Y6kBmz/Af+Humj4UcIhwbFYTVhh9TuELKdWBR67y4xXAIE//NULayTOJYMItk6dPqOPB8HAujeB8dZNcfVSfBEnScNOwO3+ut4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V+NsP/V8; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klLy/8M8PWiX3KLueCajrTnoQU2mhACrjyQxBJUne6QUb7UY0dHNwEAQCqCCYzDnRhM9g06iuVt70oOoJT+g9RI8uadE4WHqhBbQd5Pl2cXq1P0Eyh0tCWV+mtVRp5CowJZ1iA8ssfmPK/BYpn1V+qV2SK8EJilhF3GBEpkNa76X1obZ2ZHBbjSIBnSoAjLGVo0zuCjYbIRrbrY+lm6ilRooAatIzKsnfsrCXr/WNIiE6WxFpwBiG9sSSHY8Ni6DSR1eovL/Jig8ZkVA+3L72LHvou26FOj/YmEW2hRj1mLeCvZ+KN+whNuT2EjKDh9DnwULy1z++qVueVTeW9THiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soWW/fnnXw3rJ00tUQjF27KG+JyttFcVDakbV1J9qDo=;
 b=A1JUOALOTW+/1JNYnP/BbtT5mCN5DdqEBsqLtRLdFdBspNY5USxyQVoYKC3doQFLsmBq69JSNGDW4S5DUVTN3odWeSWeEIc6T3xRKIdFC8ifiYvBhGPdPCFc9cgVRdsVwWQPrcDUGMc7mQoPcyWaapCZW+rjtC24plJSRv5GZldf3T3+A/mF0VEQWFeeLnCSieD0rwTbMX6txS83slPlKsqlapHgeGBWdpLOY1L0yNIyOHrHlXwu5LaXtvmkR0IoXCtiYipsK9tGOfyRcKb0G+LsePSFSPr0dHyWAP8LlI8lK2mLml1r/3REekR0vn7724hyb4Pb/SntuM+4ukDY1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soWW/fnnXw3rJ00tUQjF27KG+JyttFcVDakbV1J9qDo=;
 b=V+NsP/V8ocBJ7kiK/3qVdS+C3ecsdnaOJV4aTTRfQCF0P9Hu03ZECnNTKSc4GP85DVwRsrP3HA/0FiUrs5xqueaq29KRbwRS6zCHsNRKNfOahOApLAVEON6UMcs8RXagRcNlVb++DfGfj9qGEe/fT8lkVnL1ehu3VSoCEJ95rrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH0PR12MB7838.namprd12.prod.outlook.com (2603:10b6:510:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 8 Aug
 2024 12:11:08 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%4]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 12:11:08 +0000
Message-ID: <d2573f67-ae0d-4f50-a035-a05aa89b8122@amd.com>
Date: Thu, 8 Aug 2024 17:40:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf/x86/rapl: Fix the energy-pkg event for AMD
 CPUs
To: "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 rui.zhang@intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, ananth.narayan@amd.com, gautham.shenoy@amd.com,
 kprateek.nayak@amd.com, ravi.bangoria@amd.com
References: <20240730044917.4680-1-Dhananjay.Ugwekar@amd.com>
 <20240730044917.4680-2-Dhananjay.Ugwekar@amd.com>
 <3956760b-de6e-4726-ac4f-e03738233f73@linux.intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <3956760b-de6e-4726-ac4f-e03738233f73@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::6) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH0PR12MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da70e26-2c7d-4615-218e-08dcb7a32f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3F6YkV1V1dmUVJHVGRidURZR2wvZ2lHdFRCV1lObnFBK24wekNranBvTmtU?=
 =?utf-8?B?WG9vNFRlVUJYTDNkMnYvckpUY1lnNWJuSDMwaHA5T3JtcXZDcGpYZWRUcVND?=
 =?utf-8?B?VE4wVzM0dG9PUFZMcWxLM2xvSHhmY1lNNkZBOWRiaDFHUWFQYll4YWFxbW05?=
 =?utf-8?B?VnVVTjQzTTF4M2wrc3Z4N21HNTUzdlJFZGhDWDZxWXQ3NG9JRmIxa1lIbGds?=
 =?utf-8?B?Y1JJRFVVNmd1bXZ2YllMcTZER3BLMFQ0dEF4S21Ecml1QVZNc3NpQnkxZWFD?=
 =?utf-8?B?Q0NzSXRkWkZIS2pZU25CV1cwSkdTK3hWNlFQWUlqTDU1K0I4YnhvTFNsYnhU?=
 =?utf-8?B?dExtdi92RkFwS3R1RUhvdUt4bmpqY3N6TTJTVkIwNmpSakovRnhEeDczeTR1?=
 =?utf-8?B?eVVDUTlSTkgwZWVodjU4Q0V4VUI0a2EyTWpDV1Blclc3cVh0WGE4M3FHb1VQ?=
 =?utf-8?B?NDkxR1VkR0xvNDRwak1LOG1YY281dXFPRkd0WHNxTDVxMDdMQStOMVVmUUVI?=
 =?utf-8?B?VmhWNEllRDZqbmlUQUdGVXBFTTRkdG5aanNaNkxqbU9SMDErcDc2SnNhVFEr?=
 =?utf-8?B?SmVjcVZlNVFPT2N3andXazZZajFUa3FsblZtb2ErYndBQjlUaExIT05Yc0FK?=
 =?utf-8?B?WXFjRFVSeHRIOHdUQm9JOStrNFVXQTUyUEtXQU5naEluTDd1RVJVYmdVSExi?=
 =?utf-8?B?ZHhqQUE5UldjRVVmQVFiMm10d3NlK1ErZS82dHR0d2MzSGx2YU4vSkxDMDI3?=
 =?utf-8?B?bmRRTTJjcWlrNThyRDBVdHBTTVZUOFN2TXB2aUd4WitUUWxoNVNTbjJwZGlp?=
 =?utf-8?B?SFVWR29pUk5xZkhxSGd5bGs1K0tTMG5EQWF2WklyRllONXZvU0V1Y21vaFFK?=
 =?utf-8?B?Yi94dXNCYUZmM0hZTDVwanlJa3lxWEFENisxVmRneE1EaTJSS0lDdnZTcVJ0?=
 =?utf-8?B?bVp3cVBKM09oam4wTmFZbEdEZW1CWXNGa1B2dHVNRUxaTUtQYnUrSGhCa21a?=
 =?utf-8?B?NEZZdUh4R2EyYUVFeDBQYmFrZWUxRUhlVjZLUFhwU1lLNEc4RjJiclBWNHlZ?=
 =?utf-8?B?YUFodU11TUQ4YlFmTk9weGc4dXNXcUtjaUNTaFRsWHVKNHJVdVhkZTJzRGxk?=
 =?utf-8?B?c3AybFFTVE9xWW9ocU9aemUreVlUUy9tNDJ5OThIWmlkTWpzQVVmKytjay8r?=
 =?utf-8?B?SHdMQWtZQUhjMk9zYzN0L1YvdGJGZjBrTm44WEcvaVdGOW9RTVNDR20rSGFj?=
 =?utf-8?B?T0l3NEdKdWVZaEJWT0N2aE4vd0NZcUNXdU4rTTNVREY3ZmNuQkliUXNtYjRF?=
 =?utf-8?B?QW1JbzEzYWRzQUI2Ry9IbzVpYXp0QlhtNkVZVXoyN1JFbDc0VU15cHkxSWdz?=
 =?utf-8?B?Q1VxV3pvNnAxRDRleEtkSnhncE82TWllVHVkY1UyaXVDY2k5d0ZUeEwybmFK?=
 =?utf-8?B?R1hYb3pJS0JmRHlobXJad1gvbnNFYlVXZi9Ucm9LUEh4TWV5b0VwVTlwdmdC?=
 =?utf-8?B?VVZOdERXSTJ1SnlsdTFDZndWNTZnS0l1RFQ0MWhjWkxEaVI3MEk2Y29kcTh0?=
 =?utf-8?B?YzU4ODduV3FTcGJCT1dBcldWVDBtOHZSVkhWV0hNVGEvcjBOR0crU1RhSGpk?=
 =?utf-8?B?VmVyU1lFbjVHTktMWWd6NXgyL3p2cW9nRElPT2QxMnBmVXlKZFB0SWk5SS9w?=
 =?utf-8?B?akdZQkZxSm1LZWhtU3NFQVVHVy9jVW5Nc3BPSkJuekVJR2ltZXJQVHlZb0JB?=
 =?utf-8?B?L1g3am9nbzJuZ3RWUFI3SXhHZWd5VjlDSDZwTDhoQTZSdm52Qkg5QzF5Vzdw?=
 =?utf-8?B?TmNaeVZ0YWFJcXJyVGc0dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWVJbTZhRU1POHVaVU9Qd1BvK3N0SG4vTjBNN2drMmVuZWZIREt0YVNoL0Zj?=
 =?utf-8?B?aXEwZFVmY09lOGt0OXNGMEZLSDZOdFI2Zkc2NDFIWmZjeExXc3h5QjBTOFdT?=
 =?utf-8?B?dGk3M1E3UERaOG5vL29QYTVieGZZYk9xTEtDVUpVYXR0RU03eEtJVEVKWUU0?=
 =?utf-8?B?MkJtRkxMVjdUYXY0VHUrQTJ2MUU0MVVHQ29EeE9zQUVnMGRPbVRBRmRlWk5t?=
 =?utf-8?B?ajJSMVFzM3hsMStVSHI5WVkrWmZsN0hkcmZKbS8rTnJtcGtvTGZKNkJFT053?=
 =?utf-8?B?TDgzTktjaXB0YUxvT2JGNDEvdnVMMExqdlNlRUF1czB6d205V1hSUlBIaW1a?=
 =?utf-8?B?d2tiRDdaOUs3UCt6RUtTazNHNkdCdE01YUpUOTVSZC9aVlI3WnZOVjd0MzZZ?=
 =?utf-8?B?WTNYTzhYaVBsU2d5R1NhcWtpUithMU9rYnp5bFFRZGowLzNva29GU2RjRGFO?=
 =?utf-8?B?YlpMblBxNEdhcGMwYzhNV05kMXd3c1FlcWVSSC9HSUp1N3dLNGNGZzkwNDUr?=
 =?utf-8?B?dVRrWW5BcnJXNXJNZkJHb2thU1hacUkxK3dja0Z1aDhYNjVmS2NXZlU1TWFS?=
 =?utf-8?B?VytkcWg2eWhaKytwSGJuTzQ1RjZsWU9KZXZERm5YekZCckhveDNTQVdKaDF0?=
 =?utf-8?B?NE14MjZTNzZXVnhPNXN4a1hmY3VjcXROeVhvejcwYzhrU2tHSTk3QkdRZ1pp?=
 =?utf-8?B?ZDJYbS94Z3JpMDUrODRRN2JON28zcklZNW5oKzJHWUw5WEhnTU4zOEVvTGtL?=
 =?utf-8?B?bnBpLy9DTkx5WXJKeEhNb0NrN29JZ1ZFTXhpT1pDYVNudFpWWGtaSnRzMlJ2?=
 =?utf-8?B?MU1RSTlheU4yeGhwOXVkbFUrUWs0SEd4OVlGdGZIWmFleHBHaGlzQ1JLYVJV?=
 =?utf-8?B?ZFpDWWxwaXBzY2grVmErTnp6bmlDK2YzZWVJenczRWh1M3dtL3lsdUEwRU9r?=
 =?utf-8?B?Z3lBZVhkb0RwWDBsUTNFMXR0SHhxTkNwdmNFUS8wMk9Qa0p5RUVMcCtBN2p4?=
 =?utf-8?B?OS9ieERMcnd3UkdDbmF5TndiWjhHQXROVkFuSW9JN0RyZzVsWFJMdFErWStI?=
 =?utf-8?B?dEJjY2NNTVBpS295Z25LejIxdnRrbjlGdEFpOVNEb2hzUnpBaVpocFdSc29M?=
 =?utf-8?B?SlJ4UHlCVWxCZkRBaE1YVzNFbGl4ZjQzOWZUYlFpRmhkM0gvVXRkZnZlU0dG?=
 =?utf-8?B?MlFqZVN1bUszZU53VDZVTnlmUTRoRW5oSU1HQVFGYnFOZGRJZ3MrV3JkQjFl?=
 =?utf-8?B?Nno4UXJ1SDdPN2FIbDBuZEw2QUt1aCtqaGJwa1dzWjdnS2RNaWV1dGtBQWhK?=
 =?utf-8?B?WlFTMFZOY1ZlemR0WmVEekdYZkhyRVpkbnZsSVJZNWRia1d4WXFDTkc2RVox?=
 =?utf-8?B?blp1aml3S0VhN0ZjTkYwb2RQVmZiS1NKSVJpeVlYRDd3aXIrWUdONUNLRDRO?=
 =?utf-8?B?WmN2MTh5VjFQOU9idUh3NHNBRFo0NEdPUzh2eEFGNFhYSHpGMU5RdElPVUw4?=
 =?utf-8?B?andYSk1KMm0vUVAyWmFJTkk3VzY3Nkd5WGpVRFcrRTl3V1lLcTFXT2NGRGdu?=
 =?utf-8?B?VGRKQWVUNVFxRXVFWFZVS0VvWjVBeHl0L1RJbnEwSTBVY25EZEIxdmVyZ0ho?=
 =?utf-8?B?bWtESksrQzF6eXNzdUhpVXJtdEo3Vis0L3lGN2hHcTlsc1B1dEJUMEI4Q3kv?=
 =?utf-8?B?cURXUjUrL1FvRDdjUVpyRDlZK09nRkp2ZGtIOUJEaFhmcnJsdCtiYUlpZlJI?=
 =?utf-8?B?V3hUK0pYTjFOWk9ZcVBaV0k2Tk1iNXhrWW1QN1RmZGpmTEJRMTZRcmlTRXpO?=
 =?utf-8?B?ZjdyL3lhMkJQS0NOMXpwbU9nRnlERDI1N0RCTVVHYXFCaGdTeWUvQ0VXMC81?=
 =?utf-8?B?V0hyV2M2OWp2aWNHZVp5RnF4QXNsY042YUVkdUQrajJRY1d3dFNaVWlrS2hH?=
 =?utf-8?B?ZTFxYlRtK0F3RmV2cytyVmg3VTVaQjdKUlhpdXJoanZ2NVVxRHBMOHYxVkF0?=
 =?utf-8?B?eWo1OUdZMExwQllxNm9DYnMrUklMcDNEbmNuU0thZldtYnRScEt2VE9BdnVY?=
 =?utf-8?B?djJSOVhtZWFsSXFubG1iU2tQWHVDZXZVTjd4TmN0dGdxR3BuT2YzaVNxK3ZV?=
 =?utf-8?Q?pH8IPwfTpMVXZRCs4rW6ihFkE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da70e26-2c7d-4615-218e-08dcb7a32f2a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 12:11:08.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nx/8i0KCmtz+hoc59vfwsAEiHAyoLm24FJ+YYUcwECfsXGhdhuvK40HBU+iOPrPBOd6+tBfbmwOZuCk4sULw6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838

Hello Kan,

On 8/2/2024 8:56 PM, Liang, Kan wrote:
> Hi Dhananjay,
> 
> On 2024-07-30 12:49 a.m., Dhananjay Ugwekar wrote:
>> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
>> on AMD processors that support extended CPUID leaf 0x80000026, the
>> topology_die_cpumask() and topology_logical_die_id() macros, no longer
>> return the package cpumask and package id, instead they return the CCD
>> (Core Complex Die) mask and id respectively. This leads to the energy-pkg
>> event scope to be modified to CCD instead of package.
>>
>> For more historical context, please refer to commit 32fb480e0a2c
>> ("powercap/intel_rapl: Support multi-die/package"), which initially changed
>> the RAPL scope from package to die for all systems, as Intel systems
>> with Die enumeration have RAPL scope as die, and those without die
>> enumeration were not affected by it. So, all systems(Intel, AMD, Hygon),
>> worked correctly with topology_logical_die_id() until recently, but this
>> changed after the "0x80000026 leaf" commit mentioned above.
>>
>> Replacing topology_logical_die_id() with topology_physical_package_id()
>> conditionally only for AMD and Hygon fixes the energy-pkg event.
>>
>> On a 12 CCD 1 Package AMD Zen4 Genoa machine:
>>
>> Before:
>> $ cat /sys/devices/power/cpumask
>> 0,8,16,24,32,40,48,56,64,72,80,88.
>>
>> The expected cpumask here is supposed to be just "0", as it is a package
>> scope event, only one CPU will be collecting the event for all the CPUs in
>> the package.
>>
>> After:
>> $ cat /sys/devices/power/cpumask
>> 0
>>
>> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
>> ---
>> Changes in v2:
>> * Updated the scope description comment
>> * Dont create rapl_pmu_cpumask and rapl_pmu_idx local variables, as they're
>>   used only once, instead call the get_* functions directly where needed
>> * Check topology_logical_(die/package)_id return value
>> --->  arch/x86/events/rapl.c | 47 +++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 42 insertions(+), 5 deletions(-)
> 
> I just posted a patch set to clean up the hotplug code in perf.
> https://lore.kernel.org/lkml/20240802151643.1691631-1-kan.liang@linux.intel.com/
> 
> With the cleanup patch set, the fix may be simplified as below.
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index b70ad880c5bc..801697be4118 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -646,6 +646,10 @@ static int __init init_rapl_pmus(void)
>  	rapl_pmus->pmu.module           = THIS_MODULE;
>  	rapl_pmus->pmu.scope            = PERF_PMU_SCOPE_DIE;
>  	rapl_pmus->pmu.capabilities     = PERF_PMU_CAP_NO_EXCLUDE;
> +
> +	if (rapl_pmu_is_pkg_scope())
> +		rapl_pmus->pmu.scope = PERF_PMU_SCOPE_PKG;
> +
>  	return 0;
>  }
> 
> Could you please take a look at the cleanup patch and give it a try?

Sorry for the late reply, I was out sick for last few days.

I tried out my fix(modified) on top your patchset, the energy-pkg event seems to be
working correctly,

On a Zen4 Genoa EPYC server:

When idle,

~$ sudo perf stat -a -e power/energy-pkg/ sleep 1

 Performance counter stats for 'system wide':

             33.93 Joules power/energy-pkg/

       1.001969742 seconds time elapsed

After running stress-ng:

~$ sudo perf stat -a -e power/energy-pkg/ sleep 1

 Performance counter stats for 'system wide':

            376.16 Joules power/energy-pkg/

       1.003985155 seconds time elapsed

Please feel free to add my tested-by on your hotplug cleanup patchset.

Thanks,
Dhananjay

> 
> Thanks,
> Kan
>>
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index b985ca79cf97..7097c0f6a71f 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -103,6 +103,19 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
>>  	.event_str	= str,							\
>>  };
>>  
>> +/*
>> + * RAPL Package energy counter scope:
>> + * 1. AMD/HYGON platforms have a per-PKG package energy counter
>> + * 2. For Intel platforms
>> + *	2.1. CLX-AP is multi-die and its RAPL MSRs are die-scope
>> + *	2.2. Other Intel platforms are single die systems so the scope can be
>> + *	     considered as either pkg-scope or die-scope, and we are considering
>> + *	     them as die-scope.
>> + */
>> +#define rapl_pmu_is_pkg_scope()				\
>> +	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
>> +	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>> +
>>  struct rapl_pmu {
>>  	raw_spinlock_t		lock;
>>  	int			n_active;
>> @@ -140,9 +153,25 @@ static unsigned int rapl_cntr_mask;
>>  static u64 rapl_timer_ms;
>>  static struct perf_msr *rapl_msrs;
>>  
>> +/*
>> + * Helper functions to get the correct topology macros according to the
>> + * RAPL PMU scope.
>> + */
>> +static inline unsigned int get_rapl_pmu_idx(int cpu)
>> +{
>> +	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
>> +					 topology_logical_die_id(cpu);
>> +}
>> +
>> +static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
>> +{
>> +	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
>> +					 topology_die_cpumask(cpu);
>> +}
>> +
>>  static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
>>  {
>> -	unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
>> +	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>>  
>>  	/*
>>  	 * The unsigned check also catches the '-1' return value for non
>> @@ -552,7 +581,7 @@ static int rapl_cpu_offline(unsigned int cpu)
>>  
>>  	pmu->cpu = -1;
>>  	/* Find a new cpu to collect rapl events */
>> -	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
>> +	target = cpumask_any_but(get_rapl_pmu_cpumask(cpu), cpu);
>>  
>>  	/* Migrate rapl events to the new target */
>>  	if (target < nr_cpu_ids) {
>> @@ -565,6 +594,11 @@ static int rapl_cpu_offline(unsigned int cpu)
>>  
>>  static int rapl_cpu_online(unsigned int cpu)
>>  {
>> +	s32 rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>> +	if (rapl_pmu_idx < 0) {
>> +		pr_err("topology_logical_(package/die)_id() returned a negative value");
>> +		return -EINVAL;
>> +	}
>>  	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
>>  	int target;
>>  
>> @@ -579,14 +613,14 @@ static int rapl_cpu_online(unsigned int cpu)
>>  		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
>>  		rapl_hrtimer_init(pmu);
>>  
>> -		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
>> +		rapl_pmus->pmus[rapl_pmu_idx] = pmu;
>>  	}
>>  
>>  	/*
>>  	 * Check if there is an online cpu in the package which collects rapl
>>  	 * events already.
>>  	 */
>> -	target = cpumask_any_and(&rapl_cpu_mask, topology_die_cpumask(cpu));
>> +	target = cpumask_any_and(&rapl_cpu_mask, get_rapl_pmu_cpumask(cpu));
>>  	if (target < nr_cpu_ids)
>>  		return 0;
>>  
>> @@ -675,7 +709,10 @@ static const struct attribute_group *rapl_attr_update[] = {
>>  
>>  static int __init init_rapl_pmus(void)
>>  {
>> -	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
>> +	int nr_rapl_pmu = topology_max_packages();
>> +
>> +	if (!rapl_pmu_is_pkg_scope())
>> +		nr_rapl_pmu *= topology_max_dies_per_package();
>>  
>>  	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
>>  	if (!rapl_pmus)

