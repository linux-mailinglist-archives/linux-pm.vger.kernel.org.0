Return-Path: <linux-pm+bounces-21421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADE8A2981C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047803AC217
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC651FF7B5;
	Wed,  5 Feb 2025 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OQE35yIX"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD231FF5FB;
	Wed,  5 Feb 2025 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777883; cv=fail; b=nD0Zm942emnqXrgq8I736Coe6szV0DRR+5KhPNOb7zIHVXbKZ76MiWw6DB4Rg6AuPLPH0iISHOCPy1N3ixwom6K2p5rMhasarCJz3d2hmb+rnMksmKcC7ZZAaoObftGFW/SKFPsecbEFRcPpE6j6hNZ998jJCD/aywqDdqkWgk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777883; c=relaxed/simple;
	bh=V1zh+foBplyc9gCydjSD8ajiu70aJoQs+q3meT/WW2s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WfnQbF/TkYwX/Yh2EWhJazw58N2GLKPpVS0yIwgtOFKI5gzoFllDZFZIgmF7MD8MJzdRRsnAUY313lzFSkTEtK5iyc1J2a81Ey7h/sZcf1mkSyDkD3pdqm0HWUW7M1A1irek+4PgJ2rM/3fKyvu84E5vf+UvgR22upDPvP9epzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OQE35yIX; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YW1RHMtgw6sozw63989JXPzyzYBVQXgPelf5U77SIFSJJj7smnPXamgItFMwpfp+EVPZj73elFjcmt8UQ2FmHDoLDR+iodyvCaaFG9wocgAhvz9HJ7pieJXzr+bULJ5hkhpOIbS7ufpGoZbZqU4TRj96Y6CBqE5TQt4bDg20kwLmFpXwxNJ3s2vUJEStYKzibJUUq/UETfvU9ySbqz3qc7q/NnWTcv9wDxFMyL6oLrMIygS7WK7HFCUbShywd8EtzX7Ut8scqVgE5bULBVlOWjXe3Rbx/m79MC+CJseGBtwl08zdwbPRURPcIbsfkl2T31Pruc+uyQQWtDXPUMpSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lgf8DofG0ERAUOurifnW1TcNeatKwOPJ3IFUMD4Nxk=;
 b=YTWUDygF7olcSx6vh9e0Bnw0ZE8c4UeiHpMALyGtgj5VCOnGrCLtHEW4ZwqVV3rFxUJmlQLrWvBJl7uOP1I5+eKyOBzCF+2u4tEsXLywHhci0iua2xMjFHbMbi60++x2xyUnkzchT9vevgVoY+EIvw/qa2CYErG/mpevECIDTOa2twGXMKbBQAeW1RUlwbdhz/a6zvdol28+ng3J5mt3ykMvE8ScjbKGSqYpu1uR1L9vdkj6z53hV0n5lTAzOd8S1uQjy2hXgPbfcI5ATToai4fZN8zT488sKS5Rm42pw6WEvjDtrBoHvs5UusFp9Hi3ZXD4SaL1WW0Fws1J1z5BmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lgf8DofG0ERAUOurifnW1TcNeatKwOPJ3IFUMD4Nxk=;
 b=OQE35yIXpSVYIahZENEbo0i0umuw76unGOSrRekpzP1CSk2IPQq1JI9k5rnFIFkdERWio8YdbwULzSrgbKDstPWzcrEBwrISMv5SJOaeKkcM9wl07vjZNBlKbyp0DrgaKDjGn7qLtYK0pk+aHAMQTPsqsWF1ojKSesNR/2vduSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 17:51:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 17:51:19 +0000
Message-ID: <12f4ccea-f795-4c4d-818c-f28dbc5a3c5c@amd.com>
Date: Wed, 5 Feb 2025 11:48:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] cpufreq/amd-pstate: Fix cpufreq_policy ref counting
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-10-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250205112523.201101-10-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ROAP284CA0223.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:73::7)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e0aaec-1ce7-4155-6476-08dd460db212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXdlc0xHVEl1Rm50YUNqOVRJK01DT20zcDc0ZFIyMmJoTXRnQy9KNGZjMSs0?=
 =?utf-8?B?aTByd2V4dElwZy9adEIvU1NVdmZ1RDdSNkNHYUhNdkNqTHdGczdKNy9oUzR4?=
 =?utf-8?B?NWdnYXMvczFEa3NEeE54SXNIMzJPSEtwSXAwWG1iODBPbVQ5QzlGVlMyek5y?=
 =?utf-8?B?MHRkdXQ2WmRlOHB3dXoxZVJYZ2tXelZ6SHhHYXFhem1CTzBNd0RSSkJINFlT?=
 =?utf-8?B?NXF5QzJ0aEh6V2liVHpVb2VKbXJZVXgxVVdNVHR2amcwb011WDFPVlkrMWtN?=
 =?utf-8?B?OTZzRHY1eXR3bmRxVTlKcWpUbzA4b3M3Q0RkeWMxYzYyOW93U0J4U3BiNENQ?=
 =?utf-8?B?MU0weVRDWVd3ZDU3TjNGUTdlSEdoQkFMZVlYQzVHT2ZaTXhIWCtmdXJoc2x0?=
 =?utf-8?B?dld0SWlLZlBrN0FybllpWHJOU2RKUWxWWjVUcjN6QXUrc2VpMjUxYTVwYmQr?=
 =?utf-8?B?eVQxUVZRTVYzcmNOSHdpeURoVGd6RUF4WkhIODBDd1V1M2p5M1MweVN5QlFO?=
 =?utf-8?B?NFpiVmNOcTNjcDY2NUVob1Z3Ylh0M0FuQ2Fuc1lwV3dDN0E1a3hLa0NwR0dB?=
 =?utf-8?B?d2w0U0lhMTcyOEdFSmQ4U2lNWTljWDBHeC9MRkxyNnVBUkFRWlZSR3pQa0dE?=
 =?utf-8?B?TCtyd0xZcStnYWwxbktGSTY1YW5wNWlvaWFEQi9VUjM1OWJtMnBOaGx5YTVm?=
 =?utf-8?B?K0JsbnFvUUN3NjJzeVFpUm83b096ZHlSM25MOFkzamRpRXVyTUY3UnlMVGdm?=
 =?utf-8?B?SlprZ1ljSXpmaFdhcmlDeXJ5UnF1ZVNXbzJFcWlIU3ArU3pvUm5YMlJzQk5i?=
 =?utf-8?B?ZXc3T1FxeE05TTdzbXI4Nm03U25sNmhPZVB5YWwxdnQrK0Fuc29OdUZ4K293?=
 =?utf-8?B?QU5XL3hnR3dNOXIzbVRZcC9XR1VZdDhFSHp2enBmUUJ2WkJ6VmhTN1Q5UWsv?=
 =?utf-8?B?c2JvNUtOS0Rhc3YzQmtYRHFmUjRUbitJRGl1ZWRldmpMMU5USjZLMWMxQ0VK?=
 =?utf-8?B?dFh2TUJwNUVnUmRBbkpjSnl4TkozUU9BK0RhK2t2T0lWMy9USEFtajZRaDlF?=
 =?utf-8?B?dlVMREp2YllJSlFNS3lXZDNKaUdmbTh5cEhqVDJ1WUtrUzd2cnZ5Z09STzF4?=
 =?utf-8?B?Z25qZ3R5UzAwQkZuQUJnTkRxOUxHNVlJcWtwdHQxNDg0V0c1eVd6YnpWUzlp?=
 =?utf-8?B?UWI1UGxWakYrYjM4MFBSeGZKODY4L0pBZG5vWTVmVEVPKzFSMjRyais2OERq?=
 =?utf-8?B?ZnJSeklEQkIweHJHVC9HSVFmRWJZV2M0WnhXaUlybjJ3eHQ1dlBiZjQxZVdQ?=
 =?utf-8?B?NTNjL3JwWXJYd2tmZDJEWUFxUytYcHFyb0ZCNUx2b1NwaG1YaTFZckgyVW5p?=
 =?utf-8?B?SHQ1eEZnMjNHQUxpQ1NNS2J2bDVxWFpGWU9Ia24vem92cVJqU24wNW0zdDJD?=
 =?utf-8?B?SnRpeXRadW9tQnJTaUlCL3ZDTFlEYkpMOHRRR0lISzA5STJIV3ZsZGl6U2F2?=
 =?utf-8?B?aVpDRnJ6bVhUaVdWWjlPWUF1aEJqWW1NNC8vMXFhcFVKczdkVHVOckc0UUdz?=
 =?utf-8?B?cFZFYmRkU0Z0Rlc0OHE3R3V5MTRDWWlGbUk5MnJrN1NGQUNjd1hreFFDQncx?=
 =?utf-8?B?cHV1NWJ4YVRQNUsxR1pSV0lCL3V4WnptN0RtMHdtSnRCdjZuYlNsMytCbXh5?=
 =?utf-8?B?Z3gxbGkxbnNXRjRVKzdYWGl6WkpLaHg0VEpuREtCS0dZczJNK2REMXhCbkRX?=
 =?utf-8?B?ZmZNTU56eHg2VllFdFdZZS9LWU4yZHNybE53U0lnNWtBVnpub1ZBeWtBMEY2?=
 =?utf-8?B?TWJ2QWsyNThIMEs0bTBPMlFIVElRN3JoZFAxK0dybmN2UTArRTUyZ2crTHNp?=
 =?utf-8?Q?eWMotF05eSvzb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE5TOUc2WGNGTWVFamVycFhtTGsvMXltUmZ2SXd1Yy84aU5wSFp4UGJsY2N0?=
 =?utf-8?B?SXd5cW1HMEQ5MHp6VzRFeTJVYjNpYUJ2S2lQTENmRG0vU3ZrNmJGR1Y1S0Rv?=
 =?utf-8?B?U1IyZ2lHeTA4eXZ5R2JvMU0rUlhQVGZaZmtsVmpJNFM4V2ZpamlBWW00Qkpp?=
 =?utf-8?B?L0tNeHJOWXNGNHcvbDFyWTBXWXVGMU1UU2dMWG9MMGMyNi9yTWFuOFBPcVBE?=
 =?utf-8?B?N25IcUZueUJTa05XMUhGQW56dDlzTU5sVW11OURhczQ1NTdSUGJ6UzMyTWRx?=
 =?utf-8?B?MHpnZVMwRjNtRnlLajl1b0NjdFZ3clFZTmduTUtOcVhzcWREMk5IUGhObk9y?=
 =?utf-8?B?YlNvMEMwQmxVNEpKUjJzR0twU1U0c2hNNUYvaW5HcmFPUjVKNG91U1B4M3E4?=
 =?utf-8?B?MnZRQjE0TjA1OHRoZ3I5UlF6N0Z2dldPVUFvWDk0ZHpPVXVrem1FM3J5VFZX?=
 =?utf-8?B?QnVtT3N0MXFtSzR1bjVERHFJNXdjOEVMTnp5WXJMUGhDLzJLcWNPRUVRSCtr?=
 =?utf-8?B?MXdtVFFSODdLbElnek9QYmwxOEs0Zzkrdnk5YzhTWGVyZXpuVm0vakxTVlZJ?=
 =?utf-8?B?Y0pRc1RnU25ZSkRwdHd3cGp5WnJFOTdKWFB4SncvYTVTQVlHWkZrMU1Nd2Z3?=
 =?utf-8?B?VDdvNSt4anFteFljS2tzWjRJY0dCNXRId3JSeFQzOURUL0psd1ZUU2FJb0Qx?=
 =?utf-8?B?ME4rWjY0SkRIQ2lHdGpXWWdOYyt1ZmZHU1BLWjE0SU9YNXVsSVErd3h0bmVo?=
 =?utf-8?B?UEQ2KzhIbFBnVWhyc2Y1ZEZYamhibVpsSGRsVlY0aWRWbE9RdmdsWjQ5eVAr?=
 =?utf-8?B?RHMzck5BUzV2WVpJcHJoOVBlaVNKNEdRMWZtY2tTdTd0ZkRpeWhsSGx0VU16?=
 =?utf-8?B?TzV1WG9xMzFJd2hNenNGaUxCaUlmdjJjMTJqVGhvOHAzbXVxNGVCdXBDdGNS?=
 =?utf-8?B?Nkc5TEpRWmwrN3RhakhoZUFaNEVUTmtwWmx3Vkl5c3lBZ1BBWElNK1E3SGE2?=
 =?utf-8?B?K0tZTDJRdVJRbjA3RzlzNG90RHgwbzVZWnpMdFZZS1VWUFB0dE9QZ3BTdWpP?=
 =?utf-8?B?RG1QRWZ6MERhZllxVkhqNVA5S3BsS0FSbERodlY3eXpRTGJDMWNMWVc0RG5L?=
 =?utf-8?B?UVhlRjJkWHlzREpLOUR0b29SaGxCb2dFOTVZaDJqTm56citEVnhCSitMNE51?=
 =?utf-8?B?S1A5MEptT0o5T3RWbVJsa21XdG5ieUwrM0RJVjhHWE8zY3JDQlEzaFFoOVVa?=
 =?utf-8?B?SGgxMGVZZm9PbENnYUl3MmN0RHVtay9Wd3BhT25hWWFVUFprRnNNUmNPd2JY?=
 =?utf-8?B?RitsOUo0b3hzOGRBSnNtdXZxVEpoL01sRDZJaVVIR1JRS0JrWDNMc2RSYks5?=
 =?utf-8?B?T0E2cHQwYmloa2IzQjREb2Z5ZHprZlJNcnFIOXloUlVhSlVhK3FQaE9VQnJo?=
 =?utf-8?B?d05VcnQ5anR6ZHZiYU9TbDEzRytjNjVFK0o5OXczQXBGSW1WS2t5QzhxN2RR?=
 =?utf-8?B?ZVh6bTY0NGtxeHY5YndPSGQzcHdWZjd1WS9xN3hqOVgvUFZsdUNFSVJPVFp0?=
 =?utf-8?B?eVpmcE1lMnovT2FLMVp5UmozMkszcXJUMVZBUm1iWXU5ZEdPMWpYL0ovR0ZF?=
 =?utf-8?B?VkJBekp3QXNiejNrbDAxVEt4WkljV2RueU8yRGZnZ21PekMwSnVJY0J1MUp2?=
 =?utf-8?B?R3pZL3hVSUFvb1FJL1BrWnJPQzFBMTEvQkVBYWwrR2o4YjltaUY2K1piNHR1?=
 =?utf-8?B?SC9oTHdGTTZmUVU0VzU5dDNSS3hUYmJMaStSU2p2d0drNTFVRnFCNzRoSGcr?=
 =?utf-8?B?UmZGSDlSSTh4di9mTG16SW9JMCtBdGliUklubFZOYVJ6MGhwMThoQjNYVkZt?=
 =?utf-8?B?dWRBV1JGZWRDcUh6WmtpUlJLOWVDQUNmQisxbFhlc2dic3lUWGxYaGc2Tmgz?=
 =?utf-8?B?YmpQQ0hOWFlMcXpMWHoxTTNhdStFZjArV01TT1ZieWJKd3VJMy9CSXZRbFBV?=
 =?utf-8?B?MEduYXRHK2sxK2tjTjNJRHJIRGI5bWlycmM1bFJudmN2Qlo0QjRRMERpYURO?=
 =?utf-8?B?MzBYdyt3QmNpS09HZ3BRdEtUNGtGTDBFUmthSy9JQ0gwS1VTQzJHNnpOUmZQ?=
 =?utf-8?Q?octHn3HCObIegZbSY9iLQ/ouR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e0aaec-1ce7-4155-6476-08dd460db212
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:51:19.5029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltd2MLyYQ9FlhSbs3vDMr3NtX1cc2NedHJWbED9TObCK6hQrIV16mnFPDOkZvRR0MXzAnFvnmCOY6eKiFZTY6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881

On 2/5/2025 05:25, Dhananjay Ugwekar wrote:
> amd_pstate_update_limits() takes a cpufreq_policy reference but doesn't
> decrement the refcount in one of the exit paths, fix that.
> 
> Fixes: 45722e777fd9 ("cpufreq: amd-pstate: Optimize amd_pstate_update_limits()")
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll queue this fix for 6.14-rc.
> ---
>   drivers/cpufreq/amd-pstate.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 107ad953ce43..9c939be59042 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -821,20 +821,21 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>   
>   static void amd_pstate_update_limits(unsigned int cpu)
>   {
> -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	struct cpufreq_policy *policy = NULL;
>   	struct amd_cpudata *cpudata;
>   	u32 prev_high = 0, cur_high = 0;
>   	int ret;
>   	bool highest_perf_changed = false;
>   
> +	if (!amd_pstate_prefcore)
> +		return;
> +
> +	policy = cpufreq_cpu_get(cpu);
>   	if (!policy)
>   		return;
>   
>   	cpudata = policy->driver_data;
>   
> -	if (!amd_pstate_prefcore)
> -		return;
> -
>   	guard(mutex)(&amd_pstate_driver_lock);
>   
>   	ret = amd_get_highest_perf(cpu, &cur_high);


