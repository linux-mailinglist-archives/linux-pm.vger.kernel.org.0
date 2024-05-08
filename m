Return-Path: <linux-pm+bounces-7645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011708BFD08
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 14:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC246280E10
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 12:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8055883CD2;
	Wed,  8 May 2024 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uYzKqwAt"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF38839E6;
	Wed,  8 May 2024 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170866; cv=fail; b=LH+nMvcSuLbDdrZ6/XHgDwPTxIxLgMqgIWVxi2eBImDeGVUJz8J1K3NG8g7HYzt7fWY+UpzLWH8IHaXhg4K0nezz+O8HiPAobA0eW11t0Ejxze+VlEOCMT7NZXROo65OPj1m4/UQodX5Og+tkgIno5SRngFzQ1ulQc6V8Xz/joE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170866; c=relaxed/simple;
	bh=hMZerb6J+V0G+lI1rtQ6Uk6xOaL39doUNlx+OzcCh4M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gt2HULPp1+ed8SL7ExFN4He84ESTBB4k7Ehfo7avsM1sfa5uYEaAA68yaZD/yyRgKxt2ghBKVNCT69iJH2upMfpmUOMWaIrzvWsomIO9M/xfeB7dWEIoy9hmZm8l74QKODzgeBpYEuDTprpSLBF6pMZ5tS+i3pW5/Cn5nnHSVWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uYzKqwAt; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OziI8Hwaa8pem7gBkhlfJCJNdIQFc5DuW+3EVyxxT1qwiZgneroEGXuO5bMJ0DhjV5LgxFW16lMi0bXaoMBbfnxDQ5LV7qkbawDEIrBrpgSA/WuaUSBnt7B7zalHtMKgXOrCN6xdueN6YOwE4avfMzdvdzrjjFW2OWzl0T3MRbPpn77Ff3QosWE2Vs9q/pISe+ryWpjafX9NL2Ee0wEo7Fa6CqArw3GCDYiJc0wnJ0bn7wJsmKBTlMY+joF3Rd5/ejP3p4nSkpkmjF6mkhQz3UDbAzDw8hQbejGk0Dpqz7FuCVoX9Gr74s9q4w/DJWgv5ilCxTwxB34WbVktXcfqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMZerb6J+V0G+lI1rtQ6Uk6xOaL39doUNlx+OzcCh4M=;
 b=niqBaJMpLeK5N0YdTMlmVsfeyZWkQs85E2QF36HbDcGd8g3GozmOtJrx9Ka+SaDDWbAJB85k9nc8Ac9+dEiALZaLa/Ezo1NctaAKWJGx0uBe9PQQKrvUnYChA6QCtOziziq/JOMpJWwTcpgsfo0wmHvsAS/geFifqCMRALWoQ+swvO2veKJd8FcM9WFluazqIRbbwbGU1IvB5/DNRlFwzbFjITIiXdl0AymPGfWPp034YdfYMic4BokpFM2LYY6nDzZtoWXk36NAyVtDyCikCLHbYQJFYV3a8HHCDOF6eKHPFScmnLX6W41/LIxvoA98AlGLHlleL8f9WD6MxdQQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMZerb6J+V0G+lI1rtQ6Uk6xOaL39doUNlx+OzcCh4M=;
 b=uYzKqwAtBesmNb7RPLxC5qjUv9un3Gm8gbVIQzE2jCNXgXGhcGTOygqUbaSnUw6rMpoqqdQviaGTkc8MkPizDEHVLlUUmlVyrBmqfemNPBDuEMhBej0otEYxxstS3y+h/wd64sgjylPZw/NZVddFdO7nDCwm58O53mltMNmecXI=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 12:20:58 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 12:20:58 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>, "Petkov, Borislav"
	<Borislav.Petkov@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 6/7] cpufreq: amd-pstate: introduce per CPU frequency
 boost control
Thread-Topic: [PATCH v10 6/7] cpufreq: amd-pstate: introduce per CPU frequency
 boost control
Thread-Index: AQHaoRiYMaTKA50UnUuOnfmHHsxhKrGNE56AgAACigCAACu1QA==
Date: Wed, 8 May 2024 12:20:58 +0000
Message-ID:
 <CYYPR12MB8655F5A8DC7F001E818048DD9CE52@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1715152592.git.perry.yuan@amd.com>
 <49204c6d4a334c0bfbc589dda79b5cd7c4c28b7c.1715152592.git.perry.yuan@amd.com>
 <12430678.O9o76ZdvQC@natalenko.name> <1884700.tdWV9SEqCh@natalenko.name>
In-Reply-To: <1884700.tdWV9SEqCh@natalenko.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=76665d55-ad9e-4d40-b853-f6536b89aa87;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-08T12:19:52Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CH3PR12MB7691:EE_
x-ms-office365-filtering-correlation-id: 88d0297a-e46e-44dd-cd67-08dc6f595113
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|366007|38070700009|921011;
x-microsoft-antispam-message-info:
 =?utf-8?B?VEZhMGs1K044WEZrWUhKVElyQXdDcDZlTFZCeThCZEx4WlpPT1JSczJJNFJh?=
 =?utf-8?B?eWx2N0dSaU00dXFUVG1haUorRjV6QzduempwbnBsWE5WeHAwaUw5ODh6dng5?=
 =?utf-8?B?NENWYVpZZXlIN1hOMVFhWVJzY2V3cVM5cTIxTUtqVnJxQVM2VU5aYnJkaGlE?=
 =?utf-8?B?ZFdaSXkwQlUrUDVCT295Mm9QQkR2VHQrTC9IenlmUkJqSnpGblE1ZEFwUTN1?=
 =?utf-8?B?Rzd6ZlRjQmk0REgvN002MVNiaXNjZ3BiYXNRYmNCclQvSDZzS01ZRytScDdu?=
 =?utf-8?B?MmF1NFdpamVpNmtuSWp3SjZFekhEZEJSREJaR1J6T0NVTGhQWFFpc2loZ3Vh?=
 =?utf-8?B?VHRvaWF3VlpscWNnRklGT1JEU2Y3bVozRkhMeHdPbHR1bXhaUDByRVBTVlYr?=
 =?utf-8?B?OGZzRUcwcEhiYjhkZFlMaFFtcXA0TStJV3poSE96VmpuYVl2WURCUE5lSFZh?=
 =?utf-8?B?R3NtbjQxMkZLVjZYQkJjQzg2QTUyTUxPcHdGN0JjdHgvV0FYL0VYS1RsTnYr?=
 =?utf-8?B?WTVGSXdDYUVSOVlCLzlpRmhxNDRqZkp1ZmljWlQ3ak9DNlpJTld1UzViNnla?=
 =?utf-8?B?WUdXZ2YydHNBRGMraG9JZkxsOHQvTG8wcllOYlhLd2o3a1VVK1VCcjl0V0JT?=
 =?utf-8?B?VnJ2endEQUhLWmRXSnVEbWVrTTdGQ2NJdi96QW4ramo2VFYrTmR1aGFCaDJQ?=
 =?utf-8?B?S3MwVTJPdW1UOEM1QVEwZzl2RlpzZmFWNnl4dmpwVkhkTkNhL1FDMEpHMmRq?=
 =?utf-8?B?NmdwaW5RTEF3dlQzNDhNN2xId3VrVUVkbzlLKzdzS1owSlI4bDlPMFZESnZF?=
 =?utf-8?B?WWRTMTVBQ1VPdWh4bGoybW03aGFKZUltdCtHUkNoeGFSOXBqTlRocEp6R3Bs?=
 =?utf-8?B?TFlNbjBvU2N4K1pDaWIvR3hiQWVWQ1NpUTNhclI4VFh4bUEzUDNhN25mUVMy?=
 =?utf-8?B?MUZBcFRadkRlOVNhVDB6OS9tZEs2cWxubmNETFJZNk5wMThPeUdDNXNIYWFP?=
 =?utf-8?B?cGx5MW9VTUZHNStzYVVVM2JBb0QvMTMxVy9ldkJlQnpGd2VpTFRhdzBwZ1JQ?=
 =?utf-8?B?TnM0MlNvMGZjNlJiaFpWdEtNeVZEWXY4cVdoTnJuQ0l5d240SlJUMUltUG1J?=
 =?utf-8?B?MFBoN1oxUTFJVXhBUmh1b0psUTFkVWZNcktmNXg1M05KYnlzTHBxNHRVTHBz?=
 =?utf-8?B?djgvZmVqYkY0QU1iZkh1TjJFWUlVSit3L05CNzNVWi95VG0wQlYyRGJMSk1B?=
 =?utf-8?B?dUxKdWVrLzNFV1R2OFVwMkl0bi9OcE5FTnB4ZTBiMmFlUFVmS09Qb1lhZERL?=
 =?utf-8?B?Ykc2Qi9wdGYvMC9wQ0NHMEpiaUJweTQrK1JyTi85Wk5UbU8vMWN4cThhVW9R?=
 =?utf-8?B?d2VOaks2MDVpcFBEb0tzeVE3TExoMm5yMTZsQmpJMmRtY25zcmpnRThxVXk1?=
 =?utf-8?B?UW9MYWVQNDZwWjdLdkU2QW5qSDlxMGRaVktBRy9JdU9mY2tLcGl0UUtPUVlk?=
 =?utf-8?B?RllEZldjWCthMXUvVzR3SWoxUFJmZ1dNNFFGazN5ejB4ZFBIalVLUG1LZ21N?=
 =?utf-8?B?eGtFRlNSbjRwT2s3ZXVSOU9qZFM4a04wdkUzOEZHUkxpci8xb0dVaWV2ZHJX?=
 =?utf-8?B?ejdMY1ZTNjhlVno0SlNsL2VYWFhwODhzSk9CUUJlbGdaenFkTTlLZ2VFV2tZ?=
 =?utf-8?B?QlFRS3pmUWtMR1Q4VVhuNWpWbzFCanRLMDhEank0OEpabEs3LzFyQmVhcWhn?=
 =?utf-8?B?K3h2cTk0b2dkcEtiTXBTNWZhdFYyajI4Y2w3R3JIUXMzVWFLYnVKZ0JLOUEw?=
 =?utf-8?Q?TlBFCCgFjGcHWrROvpyMf8o4+DVqzQ3s3U60w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yy9YdXQzLzZSejFxNG8xdmMzZzJRYXhWNG1OMWVseXYxaTBabklvUkZ0WWVS?=
 =?utf-8?B?REtKWFZiYklmZVYwbEs0akwwUUJMQUlNWnpVQnE5bnl3K2dERStPSmliRnJp?=
 =?utf-8?B?N0dLUGZJQmNZbzd5YU9wRmpLVjlHMXZybFovSmlFQzkyZ0RuSXp6UzR6bGI1?=
 =?utf-8?B?WFlCYyt3WXlWMFJXeVlFVFpqMkIxY0R1NTVicFRnay9vN2ROTm9yNkM4UzVC?=
 =?utf-8?B?UGJibWI5cmR0T2lpWFlIMXA5d3ljN2o2NEFldVg1V3FxSC8wdzNPaTFrSE9T?=
 =?utf-8?B?QjhzQkpuQzJ6Ym4vKzB1dlYreTlEYlRVbEI2anBjMVhXeU5jejZscy85dlda?=
 =?utf-8?B?Y3ZveFZlY2FIcjNneXp0NGg4UzBIOWxYWTRKamVSeVY1c3QwU2daTi9CRUxH?=
 =?utf-8?B?aWsralJkeVFBL1pjY2swZ2hqOTYwcUxvTjNSaURrNnJGS0xHdmo1V3VPL2ll?=
 =?utf-8?B?Si9qSGU4YWJjUEhtQ1lVUERBYTFIbU9GSGFkUzJZWGpyMDl0QkRBWVVWbXdz?=
 =?utf-8?B?TE9DOUx0SWZqbUdnaHk1akNSWWtnM1libHJuOWN2VlhZT0djQTZOL1pqU1Ry?=
 =?utf-8?B?dzlRVE1FODJGalNkVzRUYk1nYnRFMXBrdEplMUpRdTdkMkRPQUhEcitaTG04?=
 =?utf-8?B?bW9vN2tUOXgzNDBtSkFlVGdlVURFRVU4bCsraDMya2JBa2VPT3UvVGVWNjg4?=
 =?utf-8?B?bGI5anJnc0xDdGxpSlhBMTZHRWNadDhlbmVaSmNNczhDZU85cm1rSVVzTlFV?=
 =?utf-8?B?WlprbVBJdlYyaVFlVC9jU2lyTkFMR2ZQc1pFVmZLV3dMdDhqTlhUT0RoY3pn?=
 =?utf-8?B?V3cvTXNMTEkwaEZjUHh3L1Y2bGxvRzdhL09FYUR2R3phb0Y0QWQ0aG5EQ0p5?=
 =?utf-8?B?T3RtYy9HaEg2aUpSOXZBRHFxeWtDRmcwU2QzVEMzbm15T1pkNllUVENheW90?=
 =?utf-8?B?ekxPb09BWXZSd1ZPZlVhbllqaHpNZ0JjRGtEejhRYzdUTTRzZGl5QklmQUxQ?=
 =?utf-8?B?WUtOc2tMR0p5YjNDOFM5NXU3eXJZakdnUmxWQmY2OFowcmxmR1FleWNjZTZ2?=
 =?utf-8?B?VDFSSjVkdTQyRWJHWm1DZ2ZYSUxCcVBicW9Fa3o3djl6VWtNRFZ2Y1dGWlZj?=
 =?utf-8?B?Nm8zWmZ2KzVGYldLcDhZbWUyZVA1cmNQQk5xeDJJMzdQc3loY1dLeDJLd0tF?=
 =?utf-8?B?ZzRlVDVROXpiSTV3N3ZFUStrMFAvWElOR1NQTnJwN0VHK2xYNzRlZDROYUs5?=
 =?utf-8?B?YkxXMTZzdXN0S3FnMElwOWhGOGs4YkNBbzYrL0kxZDV3bDRLM0VJaldXWkcz?=
 =?utf-8?B?K0o1enlDemtmTWZhQXBoNThnakUrRGEwMmFWYXA3cGZxcWFGL2puU0RmVXpJ?=
 =?utf-8?B?N3lOb1lENUhTNTBXY2RDaXU3VW1NWkxBR2NyWmc1QWFnRmpxVTFxc3Z5Qk9m?=
 =?utf-8?B?T3RmOUVmWUxuejhzLzJ4SEpjWENaT1BiWTBmMERlUDJiazIwTUhwVXMwTEpj?=
 =?utf-8?B?b2lhNzYxY1pDUVorMnUyTGdlMUNvM2lhTkJUZlZRN0VoOTZya2NZSFJEaXhi?=
 =?utf-8?B?NFg1VkU0cFVIeU9oZkNxbUJ6UXk2Z3JFSlRrNEtJM0FUWWN3VDNZZVI0VzVL?=
 =?utf-8?B?NU1McG0vRTkraGRpV2FPeS9FeDR1OTFlWFhvaEYyRDJSbW85SW5WdGNodmlR?=
 =?utf-8?B?clg4R01iVEpSNzM4akxPS0JESUhzUWtGNXRtS0laTVRPUjJ6TjlnV0tVQjdk?=
 =?utf-8?B?OVk2anE1bURCdFF0V2FlSWRBNVdMSzZwNVBDd0s5bFBRNXpRaG1VdXBuSncx?=
 =?utf-8?B?eisxeUN1OWhoR1Y1YlNsME9oL25sSW0wVnlqd25UQ0NSRUtkcDF0V25QMlZq?=
 =?utf-8?B?NW96OHY1N1dCVU9XVFhNN1YrdnlTaTBtQW05NGd2c3VZVkw4QUR1eXM1QUdO?=
 =?utf-8?B?MExEbDFjeVBxeUt6NnQxN2xUbklYTWgyTzFQdmxKUklQcHNqVHNzdmhsVDNJ?=
 =?utf-8?B?ZXV1L3pUK0o0aXUvOHcxV2tlS3RZdkJ2aGlFUHp1SjZKUEZTTkd0RFpWZFZJ?=
 =?utf-8?B?cHFiZHVrTlIzVDNweHdPQzBHNy83TXRxUngzMkhBbzJ5M2hCTzQ5dTNTVmFQ?=
 =?utf-8?Q?YnDw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d0297a-e46e-44dd-cd67-08dc6f595113
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 12:20:58.2751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zn1M29r4GLp6adLHFE2i2xRslJ+I1/qN0Yldvbzq3jlqxuFZ0DfztXRRsOT411amXMvje4AgPLFONxY7DYmbYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJlZ2FyZHMuDQpQZXJyeQ0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE9sZWtzYW5kciBOYXRhbGVua28g
PG9sZWtzYW5kckBuYXRhbGVua28ubmFtZT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgOCwgMjAy
NCA1OjQzIFBNDQo+IFRvOiByYWZhZWwuai53eXNvY2tpQGludGVsLmNvbTsgTGltb25jaWVsbG8s
IE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgdmlyZXNoLmt1bWFyQGxpbmFy
by5vcmc7IEh1YW5nLCBSYXkNCj4gPFJheS5IdWFuZ0BhbWQuY29tPjsgU2hlbm95LCBHYXV0aGFt
IFJhbmphbA0KPiA8Z2F1dGhhbS5zaGVub3lAYW1kLmNvbT47IFBldGtvdiwgQm9yaXNsYXYNCj4g
PEJvcmlzbGF2LlBldGtvdkBhbWQuY29tPjsgWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNv
bT4NCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IEh1YW5nLCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4g
PFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFt
ZC5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEwIDYvN10gY3B1ZnJlcTogYW1kLXBz
dGF0ZTogaW50cm9kdWNlIHBlciBDUFUNCj4gZnJlcXVlbmN5IGJvb3N0IGNvbnRyb2wNCj4NCj4g
T24gc3TFmWVkYSA4LiBrdsSbdG5hIDIwMjQgMTE6MzQ6MjEsIFNFTMSMIE9sZWtzYW5kciBOYXRh
bGVua28gd3JvdGU6DQo+ID4gSGVsbG8uDQo+ID4NCj4gPiBPbiBzdMWZZWRhIDguIGt2xJt0bmEg
MjAyNCA5OjIxOjExLCBTRUzEjCBQZXJyeSBZdWFuIHdyb3RlOg0KPiA+ID4gQWRkIGEgbmV3IHN5
c2ZzIGF0dHJpYnV0ZSBmaWxlIHRvIHN1cHBvcnQgcGVyIENQVSBmcmVxdWVuY3kgYm9vc3QNCj4g
PiA+IGNvbnRyb2wsIGFsbG93aW5nIGluZGl2aWR1YWwgQ1BVcyB0byBlbmFibGUgb3IgZGlzYWJs
ZSBDUEIgc2VwYXJhdGVseS4NCj4gPiA+DQo+ID4gPiBUaGUgbmV3IHN5c2ZzIGF0dHJpYnV0ZSBm
aWxlIGlzIGxvY2F0ZWQgYXQgYmVsb3cgcGF0aCwNCj4gPiA+IGAvc3lzL2RldmljZXMvc3lzdGVt
L2NwdS9jcHVYL2NwdWZyZXEvYm9vc3RgLA0KPiA+ID4gd2hlcmUgYFhgIHJlcHJlc2VudHMgdGhl
IENQVSBudW1iZXIuDQo+ID4gPg0KPiA+ID4gVG8gZGlzYWJsZSBDUEIgZm9yIGEgc3BlY2lmaWMg
Q1BVLCB5b3UgY2FuIHVzZSB0aGUgZm9sbG93aW5nIGNvbW1hbmQ6DQo+ID4gPiAkIHN1ZG8gYmFz
aCAtYyAiZWNobyAwID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1WC9jcHVmcmVxL2Jvb3N0
Ig0KPiA+ID4NCj4gPiA+IEFmdGVyIGRpc2FibGluZyBDUEIsIHRoZSBDUFUgZnJlcXVlbmN5IHdp
bGwgbm8gbG9uZ2VyIGJvb3N0IGJleW9uZA0KPiA+ID4gdGhlIGJhc2UgZnJlcXVlbmN5IGZvciB0
aGF0IHBhcnRpY3VsYXIgQ1BVLg0KPiA+ID4NCj4gPiA+IGZvciBleGFtcGxlOg0KPiA+ID4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiA+ID4gQ1BVIE5PREUgU09DS0VUIENPUkUgTDFkOkwxaTpMMjpMMyBPTkxJ
TkUgICAgTUFYTUhaICAgTUlOTUhaDQo+IE1IWg0KPiA+ID4gICAwICAgIDAgICAgICAwICAgIDAg
MDowOjA6MCAgICAgICAgICB5ZXMgNDIwOC4wMDAwIDQwMC4wMDAwIDE2NjYuNzc0MA0KPiA+ID4g
ICAxICAgIDAgICAgICAwICAgIDAgMDowOjA6MCAgICAgICAgICB5ZXMgNDIwOC4wMDAwIDQwMC4w
MDAwICA0MDAuMDAwMA0KPiA+ID4NCj4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiAtLSAkIHN1ZG8g
YmFzaCAtYyAiZWNobyAwID4NCj4gPiA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY3B1
ZnJlcS9ib29zdCINCj4gPiA+DQo+ID4gPiBDUFUgTk9ERSBTT0NLRVQgQ09SRSBMMWQ6TDFpOkwy
OkwzIE9OTElORSAgICBNQVhNSFogICBNSU5NSFoNCj4gTUhaDQo+ID4gPiAgIDAgICAgMCAgICAg
IDAgICAgMCAwOjA6MDowICAgICAgICAgIHllcyAzNTAxLjAwMDAgNDAwLjAwMDAgNDE1NC4zMTQw
DQo+ID4gPiAgIDEgICAgMCAgICAgIDAgICAgMCAwOjA6MDowICAgICAgICAgIHllcyA0MjA4LjAw
MDAgNDAwLjAwMDAgIDQwMC4wMDAwDQo+ID4gPg0KPiA+ID4gUGxlYXNlIGJlIGF3YXJlIHRoYXQg
bW9kaWZ5aW5nIHRoZSBnbG9iYWwgdmFyaWFibGUNCj4gPiA+IGBhbWRfcHN0YXRlX2dsb2JhbF9w
YXJhbXMuY3BiX2Jvb3N0YCB3aWxsIG92ZXJ3cml0ZSB0aGUgaW5kaXZpZHVhbCBDUFUNCj4gc2V0
dGluZ3MuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8cGVycnkueXVh
bkBhbWQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUu
YyB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAyNyBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1
ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiA+IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBp
bmRleCAxMWJjZTJjMWRiMzIuLmNiMDA1NWU3Yzg0Mg0KPiA+ID4gMTAwNjQ0DQo+ID4gPiAtLS0g
YS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2NwdWZy
ZXEvYW1kLXBzdGF0ZS5jDQo+ID4gPiBAQCAtMTM3MSw2ICsxMzcxLDMwIEBAIHN0YXRpYyBpbnQg
YW1kX3BzdGF0ZV9jcHVfYm9vc3QoaW50IGNwdSwgYm9vbA0KPiBzdGF0ZSkNCj4gPiA+ICAgcmV0
dXJuIHJldCA8IDAgPyByZXQgOiAwOw0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiArc3RhdGljIHNz
aXplX3Qgc2hvd19ib29zdChzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSwgY2hhciAqYnVm
KQ0KPiA+ID4gK3sNCj4gPiA+ICsgc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhID0gcG9saWN5
LT5kcml2ZXJfZGF0YTsNCj4gPiA+ICsgYm9vbCBib29zdF92YWw7DQo+ID4gPiArDQo+ID4gPiAr
IGJvb3N0X3ZhbCA9IFJFQURfT05DRShjcHVkYXRhLT5ib29zdF9zdGF0ZSk7DQo+ID4gPiArDQo+
ID4gPiArIHJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiV1XG4iLCBib29zdF92YWwpOyB9DQo+ID4g
PiArDQo+ID4gPiArc3RhdGljIHNzaXplX3Qgc3RvcmVfYm9vc3QoDQo+ID4gPiArICAgICAgICAg
c3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3ksIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNv
dW50KSB7DQo+ID4gPiArIGJvb2wgYm9vc3RfdmFsOw0KPiA+ID4gKyBpbnQgcmV0Ow0KPiA+ID4g
Kw0KPiA+ID4gKyBpZiAoc3NjYW5mKGJ1ZiwgIiVkIiwgJmJvb3N0X3ZhbCkgIT0gMSkNCj4gPg0K
PiA+IFRoaXMgd2lsbCBnZW5lcmF0ZSB3YXJuaW5nLiBJSVVDLCBzc2NhbmYoKSBkb2Vzbid0IHdv
cmsgd2l0aCBib29sZWFucw0KPiBkaXJlY3RseSwgc28geW91J2QgcHJvYmFibHkgd2FudCB0byBy
ZWFkIHRoZSB2YWx1ZSBpbnRvIGFuICh1bnNpZ25lZCkgaW50ZWdlciwNCj4gYW5kIHRoZW4gY2Fz
dCBpdCB0byBib29sLg0KPg0KPiDigKZvciBtYXliZSBqdXN0IHVzZSBrc3RydG9ib29sKCk/DQoN
ClllcywgIHRoZSBrc3RydG9ib29sIGlzIHRoZSBmdW5jdGlvbiBJIG5lZWQgdG8gdXNlLCAgd2ls
bCBjaGFuZ2UgaXQgaW4gbmV4dC4NClRoYW5rcw0KUGVycnkuDQoNCj4NCj4gPg0KPiA+ID4gKyAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ID4gKw0KPiA+ID4gKyByZXQgPSBhbWRfcHN0YXRl
X2NwdV9ib29zdChwb2xpY3ktPmNwdSwgYm9vc3RfdmFsKTsNCj4gPiA+ICsNCj4gPiA+ICsgcmV0
dXJuIHJldCA8IDAgPyByZXQgOiBjb3VudDsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiAgc3Rh
dGljIHNzaXplX3QgY3BiX2Jvb3N0X3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1
ZikgIHsgQEAgLQ0KPiAxNDE2LDYNCj4gPiA+ICsxNDQwLDcgQEAgY3B1ZnJlcV9mcmVxX2F0dHJf
cm8oYW1kX3BzdGF0ZV9wcmVmY29yZV9yYW5raW5nKTsNCj4gPiA+ICBjcHVmcmVxX2ZyZXFfYXR0
cl9ybyhhbWRfcHN0YXRlX2h3X3ByZWZjb3JlKTsNCj4gPiA+ICBjcHVmcmVxX2ZyZXFfYXR0cl9y
dyhlbmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZSk7DQo+ID4gPiAgY3B1ZnJlcV9mcmVxX2F0
dHJfcm8oZW5lcmd5X3BlcmZvcm1hbmNlX2F2YWlsYWJsZV9wcmVmZXJlbmNlcyk7DQo+ID4gPiAr
Y3B1ZnJlcV9mcmVxX2F0dHJfcncoYm9vc3QpOw0KPiA+ID4gIHN0YXRpYyBERVZJQ0VfQVRUUl9S
VyhzdGF0dXMpOw0KPiA+ID4gIHN0YXRpYyBERVZJQ0VfQVRUUl9STyhwcmVmY29yZSk7DQo+ID4g
PiAgc3RhdGljIERFVklDRV9BVFRSX1JXKGNwYl9ib29zdCk7DQo+ID4gPiBAQCAtMTQyNiw2ICsx
NDUxLDcgQEAgc3RhdGljIHN0cnVjdCBmcmVxX2F0dHIgKmFtZF9wc3RhdGVfYXR0cltdID0gew0K
PiA+ID4gICAmYW1kX3BzdGF0ZV9oaWdoZXN0X3BlcmYsDQo+ID4gPiAgICZhbWRfcHN0YXRlX3By
ZWZjb3JlX3JhbmtpbmcsDQo+ID4gPiAgICZhbWRfcHN0YXRlX2h3X3ByZWZjb3JlLA0KPiA+ID4g
KyAmYm9vc3QsDQo+ID4gPiAgIE5VTEwsDQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiBAQCAtMTQz
Nyw2ICsxNDYzLDcgQEAgc3RhdGljIHN0cnVjdCBmcmVxX2F0dHIgKmFtZF9wc3RhdGVfZXBwX2F0
dHJbXQ0KPiA9IHsNCj4gPiA+ICAgJmFtZF9wc3RhdGVfaHdfcHJlZmNvcmUsDQo+ID4gPiAgICZl
bmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZSwNCj4gPiA+ICAgJmVuZXJneV9wZXJmb3JtYW5j
ZV9hdmFpbGFibGVfcHJlZmVyZW5jZXMsDQo+ID4gPiArICZib29zdCwNCj4gPiA+ICAgTlVMTCwN
Cj4gPiA+ICB9Ow0KPiA+ID4NCj4gPiA+DQo+ID4NCj4gPg0KPiA+DQo+DQo+DQo+IC0tDQo+IE9s
ZWtzYW5kciBOYXRhbGVua28gKHBvc3QtZmFjdHVtKQ0K

