Return-Path: <linux-pm+bounces-20059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F833A049DF
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 20:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A861888045
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 19:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A9E18FDD2;
	Tue,  7 Jan 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SkucW9FK"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A822594BF;
	Tue,  7 Jan 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276818; cv=fail; b=CI3smLYpE0fJ89mF8+sxGL8z/oiQzD4Adn+LCB3TrH16G9HlgLEEc2aDG0qyRBVn6xO/U33OMMxxBtNfP5P3ucRno+qWvaF0KOx3JLTSZljcKSVyS/nREMFA8viND2VQLqdOyHywJyqNRa5xHl3R07JZMGj/2me5VJPDhLsagJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276818; c=relaxed/simple;
	bh=ob2MFshkHjH2TLMHRXu0i6jcwRdQZBu9d6gsSJtRK2Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IF9MkmzGmZApkwJf5P8fW+4wTCdwa2XGdDyiaPpA5Ws3rbETOM5Erts1wUjYifeaUkzlETmGBav6Ioz0CrUTd46yIGc7IX012kYSI+Ar1NnhyxOXjsCu9fRfQZKLvuiEC0B3gEsNgDSTqsNhAXOPXKc4blxQLO3CoXY1/KhRHSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SkucW9FK; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIWPaAi6f70Pi6W1k3CzxONKevz2a/qWLLsrtz+yVyyg4LkmjiwABKqotwxi4WkMP+R+7inb+FGsFmNhur8Nj7pZG4tjvUzerrrtaz7wOtOnvhBwjVrY1cYigyOc7bCxWwbDvehrk7ok765Jz+jSAqVPg3UMch4/Bj607dbj29agJaSUoQMlEhYKxRA5BNObdh0TibeFJG93quATPHIr25VITm0hXbbDYeRtr+e10B/y/8mpC009PzEyGpyNcDmfV4Vooxey1L9uC61y8C8aHoy7oXtoW3FCfQnccvnIzgYsTiccbMvfdqnJZfXm8wN/KT/n3VJ5VLJTVn4BMgfRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ybf+TodQ+/LGhNxRI9rQdelwcQzLYqORBHYlg/uCKlw=;
 b=G1ZMhHU5XM2YZ9OsL0GjFnO5xKVmnhRpWvDCn0iZvN8IrAI1Lq8qmB6UPZRGCfoVrQ5EY8jo5hfv4E53FIHttvdmpHD1ADJZZH71BJISRBlCfnwd+mfO8M3OFH75JTpwCQFn8vmNpqI2GYeZaEwk1wkmsbu9R6fIfv/uRj4+WIAYqRo9fat2mkOVgwf4KDO1Af5hFp8QZvsfADdA2EM1PYiMpld335NzolByltdTRXAVRY7adLQ77iQic2PlElzr24NUdUoqSvsa0JZJ5RZKKfnVa7Y4KTXDkAoRYhS3Zo78OOyKmV4TivkEv+m8AZPAnw4qvodWemf7QM3YA7Yk+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybf+TodQ+/LGhNxRI9rQdelwcQzLYqORBHYlg/uCKlw=;
 b=SkucW9FK9ZMKTLFKEGZLasyTKNSCWclah9A9y6q2t87szN3EvDJhtsKp/R2fQpe2m+iAEQ91T87NTqd4SmYrpHFhNRQU1daAVyMYDqYCSZ+wl6RgzH7G5wNBcKTC/NbuE6894GgzbvYciFFsZwmpe0djarvvtumDLMer8the2QU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 19:06:52 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Tue, 7 Jan 2025
 19:06:52 +0000
Message-ID: <c8b2d107-e7a3-47c0-afe8-1c256e0fb1e7@amd.com>
Date: Tue, 7 Jan 2025 13:06:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Refactor max frequency calculation
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Naresh Solanki <naresh.solanki@9elements.com>
Cc: Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241219192144.2744863-1-naresh.solanki@9elements.com>
 <Z2ULvwb1hePiDmwj@BLRRASHENOY1.amd.com>
 <057d8f01-c1ee-428c-8c19-80edcf9017bd@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <057d8f01-c1ee-428c-8c19-80edcf9017bd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0047.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::20) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3eb4e7-72fb-4ced-e2ef-08dd2f4e7204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUxTdjhZVmZXd2FvMThtWlYzeUFZQ1Z0S3ZjbnZCbVpVVXRaV3h2eFRHdlBK?=
 =?utf-8?B?WFVmZEtvdGVXWW5ibFRkTmZaSk5jSVVCUGJqVE9kTXBKL3I2TVJ6NWhTN0ow?=
 =?utf-8?B?ay95L2lFVlBMMit6QTBPVzlqbEtncFczNHF4MFJkQUZWOHpUUS9wR3ZLV3FE?=
 =?utf-8?B?a0pBWGU5c0FaV0g2dzlHOTV3Q3dxS2ZTRHVHUnNxNHRsUGFTMEttYUhkTTZ4?=
 =?utf-8?B?TFpCa3QyRVJRcWJvcjZMSG9OYnE2OXY0TDJRS3lBb2UwMUZsc0c5ZVFBcUcr?=
 =?utf-8?B?a3cwZEJsVm5FVmZJelkyNXdGS0hwREd1aEFyMzNxSURaNHJYK3NCeTBOY21j?=
 =?utf-8?B?ZHRrN2tKaXNiY0wxNFBSbWFwZXBWS3hFbnZ0bXF2TDYrVGZoNjZ2OGIza2lD?=
 =?utf-8?B?QnBERm9KdEgvV1ZET253blhmUzhnbkllYVcxV2NSc0Q3Y1pWM29aM1ZyWGFN?=
 =?utf-8?B?cHVPdnlUZGJLUmhEVTE3bkxMQ0x6TzNDc3BGS0E1K1doZXAwd1BDVzRVWXdv?=
 =?utf-8?B?M2VINjFlTHNKdEMxVkUrOUc2dThjQ0ZvbGF5TW5zRXNnME5zWExQcTVnNkZH?=
 =?utf-8?B?Mzh4ZkRmKzFWOFlUckxSOWkvTG5zVlV0V3puMUpsSmRMYXVmNWV6cjJhbnB4?=
 =?utf-8?B?NU9NV3ZTdnAvUjFTbHQ1SU9OQW45WFI2ckI1eno4Q3k0am5TM2ZvQklYM1lV?=
 =?utf-8?B?L2JCcWFkdGFON0orQXJzZ3NWN1N0bHV6WGhQK053a3VYM0hNT2toL002UjFw?=
 =?utf-8?B?VWp1dUpZa0RiYldBcm5DejJ6RE8xNjM5UjJUZll0QVU2aml6MGNjQ2J6VEFW?=
 =?utf-8?B?R2thdU5weUVhTHpVcURSa3dNT2NmczFYdHVnMUx1ZUdLV2NqcDNnRnpQc1Zx?=
 =?utf-8?B?V2xyRFZLeGxYalNUUkhxVDNRSzQrUHAyVFV0c29yd3lvQmlzUC9qUWhTRzhQ?=
 =?utf-8?B?MFRwbXhoNmtLd2RYdHFsWEJpWUlDS2w0N3g1OHVnYlhOSEVDVWRvUVVpNkxD?=
 =?utf-8?B?UG1vS1B4dU9BSWRMQUFqTWF5eDVxNnJleEZ4aTJjQ2lPTnBiTy8wajNyRjlo?=
 =?utf-8?B?T0V4NHB2SlBIcm5WZ3BjQzI2cFE2b21KM3BqaElEU3pUb2FZVW54VUtFUGw2?=
 =?utf-8?B?TzNLOUJNVm1OWTlpTlo1TVJ5NEZoVTZ5eEU4K0RnSWo2RS9pb01ndEcvN1dQ?=
 =?utf-8?B?ZFArNHJKdUxyNzErWk02K25LSFBkSHhDalhuYjF2cWpNYmxLVi90ZVdtZVh5?=
 =?utf-8?B?S2JaOUtNN3FvOStiVysvWElTbHNvVFlETHlaM3ZwRDFZVEZObi9jYTJjWHVZ?=
 =?utf-8?B?YnV5ZWJwbWxPcFVzVU0yVUJlTHlxbFpEY2tCNHljL2F6SDVvSUtLRmo4cHda?=
 =?utf-8?B?WC9YNkxlMmpXVTE2MnJHKzEvZDRNcWJiZDVnalRQUWJKN3BHNUgyYUxITXVS?=
 =?utf-8?B?ZS93dldib2dIcDROSDJEMi9TQUNVaTYyUXdUYlVPZHcrR1Y1QUFKTEU5ODlV?=
 =?utf-8?B?MFBtVUYyQUE4TlhpT1U0Q20rWnBSdWFnTzFNZURmczlObDZCejB3TjVGWmhK?=
 =?utf-8?B?TEZGdmZDWXhiUngraU15dVBCYlVKYUxNaXIvMEF2V2lQN1ZMMEdwOTRrSlo0?=
 =?utf-8?B?czVOY0FicjE1aDM0Vlkya0h1ZzJkSmVhVC9TcW51eWdlR05WdW8vWXNhNXh1?=
 =?utf-8?B?SkRuazRWOWN4NkphOTBOUU0rL2k2U0xGdUNIZmFhVXRPZ2FaTUw4QXVkVFUz?=
 =?utf-8?B?eGdkdW5NdlJGaExtOHdQSnBtQ3o0SmUwWkFUTW5LdTNQZHBmdFFiT2Jvakxu?=
 =?utf-8?B?SU5CZEppVElEbzdxeEZjZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEZSd3ljNlVLR1BFMWx0V0k4bERPUVdWWFpPek83NjQyZlRTdTBMUlE0aVlE?=
 =?utf-8?B?VytuTDNFTHlCL2h4d1Q1MDIvWjZwN1pWejc5YWFnZXd1QVZFZDJtczV0aTB1?=
 =?utf-8?B?dDlWVk5pakQ4MSt3WnlvMGMzSksrM3N6UWZ0c0RIOXNoOUZFUnZRSjFBeERK?=
 =?utf-8?B?UnFwYUdHOEU5MVVaNlRnNXY1OUhkcWdGKzg3NTdJdkhYOU1nTjlWdWZiQ0d6?=
 =?utf-8?B?a0h5dHE3Z0VETjVPai9OQitkZ1BRYXBuZ3UxQmdLWGxOUTMrbURwa3k1QXhq?=
 =?utf-8?B?RTR1NjFFYVdKSWpLNkdDWlhIWmRLd3c1YnJRc2E3aDg1Y05GcEFnTHBoT0lI?=
 =?utf-8?B?ejF2dmV6bXk4Rnc1MTNKUkQ4VTdzaisydE9lREZBbDIvcEMwRXc5S2owUXI4?=
 =?utf-8?B?Y21Pbng1Uzc0SUdJWStyRlhtU0lFMTdSaWd6WHFOYXpZbExJNVdiUU9lRXdF?=
 =?utf-8?B?a2VGOVZObE5MMXJDTUlxeEFCMGR1VzFCUitjblNhMEE4dmR2a3M3RW5KajNT?=
 =?utf-8?B?QTFOcUJrR2ptbHM3R04rVTJ1MEtMcVZhb1IrNytFSGlLd3oyUWhDaThrSmNN?=
 =?utf-8?B?S2VmeWhtU2tlNXBuRTF2MlhJRWRnVTdldlRQNGlMeVpHUUlubE5zZE1uMzlr?=
 =?utf-8?B?NXFoSURDb05VU0R1Zyt2bGVhQzBRd2ZNek5jVGJuV1hCV3psOUtsVytqV3Aw?=
 =?utf-8?B?WWlNRS9TQ2kvbDBGY0ViMDhsblVOMTl3ZmlDd2MyS21LdGR6NFNRV3pCckFP?=
 =?utf-8?B?eGhYL1UzWmUwNmlRZWhsUmhoYjFTY1RFeVdYdzJZaUtGa2dVOVloOFpCb3Jt?=
 =?utf-8?B?Q29jZW5tUUo3ZG5PTU9JUU1DT3lVb2w4WHZWeUZwejg5UXp5a1lwcEIySUdU?=
 =?utf-8?B?Z1FGNktZaTJTTGcrZk1CRWlBbnpsRGRNT1YzSDB4K1Z4cEVoQ0NxMlZvb2cy?=
 =?utf-8?B?bnBRdDdzN1loRjF3NDlEK3NaTm5sbkhycGZHRW8rUEhwSFgxRUlBMTIzcE81?=
 =?utf-8?B?ZjQwK3NEUGphTThpVVhRKzhLMjlOdTlhTGZWMXpaNmdWWU5NRndZVWNiOTVY?=
 =?utf-8?B?NXZKVXFWYVU1Y2dUU3ljNVlKM0x3ZHZBelZTMEF1SkFiQjVqTzViTllQSkc0?=
 =?utf-8?B?MmJDS0ptRGRTMTVJMFpDL1VQVnlhUUNYdWpocFFENzNiTVhxZVRXRUxqS3Fp?=
 =?utf-8?B?ZThDTTNEZzdWcmdNNWdxRG5Pc3RtdUVqUUI4WkVycUR4ay9LaXBVdEFkRkhs?=
 =?utf-8?B?OTFHV2JrZS9UMXdKMVc4REk3emVmK2czcWpwNng4NkFwTzNaN283d3ByLy9m?=
 =?utf-8?B?VUlrVTRoUG43ZkdxQnJkbzdpWlpQekRiai9WZEthSzZuNnhENFJrcXR1MXVu?=
 =?utf-8?B?RjhPc29MeGkwRDBtdlUvbFRjM2tSbjhPL2hZZm9iN3hyMEtvdlVJU3VvcStC?=
 =?utf-8?B?ZFo3MWpBdmVRS3JCN1VHcXpnU0VzdVdOZWh5UHJVTGNIOTAza0RPVkJpdTR0?=
 =?utf-8?B?WjZWOFpFbk5zTFNoYnZGcWIzdXFBYWdmLytpM3JsRDV2OHNsUG5rK3FRL29T?=
 =?utf-8?B?cE9SNzg0NS8xVTdUM0l3VTQ4OEtib21LeXhUN2JBTCtEQUxJeWhwaHRSUWtp?=
 =?utf-8?B?cERBNlE3SlBHRHYrM3o0c3JjNWZ2M1lmdXFGVnYxK1JMbFcrQWZ4RHE0S1JN?=
 =?utf-8?B?azlDb1R4dVc2K2xSajRLb3d4ejNDaXVaVURzQm8vRk1ucVJwZWRRMHM2b1Ra?=
 =?utf-8?B?dkE0TUtLY1kyQjZ4TkhGUVpjNjRZQ0dzclZPdE5sRU1nb0UvQStPbHNuMUov?=
 =?utf-8?B?eENvNDZLUlJRWUQwR09UN1pyTVpiVi9NUUVlaWhBdkJYWnJJRGxuTW96bjE4?=
 =?utf-8?B?bHUraERZSU1jTjhoNHovek94V3lPeG4zaUJEVXNhemROZ292Vk5JTzRBUEhK?=
 =?utf-8?B?M2QwTUtFNmZEN0w5V0JhZ2tQQWVRNUpLU3BzMHB0aE1uVUV3OUI0Y1lWR0xQ?=
 =?utf-8?B?dW5MUEpNaEx6VFR3T256TG81Q1hxcGozdWNEM3dTeWZueG10d1FZdTBKa1RP?=
 =?utf-8?B?RG9zRG50c2hweFIzME5VSkJOdXF0SXNiZ09yTkVWT3Bub2FpUDFka0pFR0xH?=
 =?utf-8?Q?oM4lPA2B8hhC2+uykY/O5ljnx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3eb4e7-72fb-4ced-e2ef-08dd2f4e7204
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 19:06:52.4821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeRPf49T9NxLKLTaHgkpLBjDVRzQDP6sKyps6RwwsK568k8yTQiDo8KSdEx+6I8bSLUL2F/RaERO40l/d4epxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314

On 12/26/2024 23:49, Dhananjay Ugwekar wrote:
> On 12/20/2024 11:46 AM, Gautham R. Shenoy wrote:
>> On Fri, Dec 20, 2024 at 12:51:43AM +0530, Naresh Solanki wrote:
>>> The previous approach introduced roundoff errors during division when
>>> calculating the boost ratio. This, in turn, affected the maximum
>>> frequency calculation, often resulting in reporting lower frequency
>>> values.
>>>
>>> For example, on the Glinda SoC based board with the following
>>> parameters:
>>>
>>> max_perf = 208
>>> nominal_perf = 100
>>> nominal_freq = 2600 MHz
>>>
>>> The Linux kernel previously calculated the frequency as:
>>> freq = ((max_perf * 1024 / nominal_perf) * nominal_freq) / 1024
>>> freq = 5405 MHz  // Integer arithmetic.
>>>
>>> With the updated formula:
>>> freq = (max_perf * nominal_freq) / nominal_perf
>>> freq = 5408 MHz
>>>
>>> This change ensures more accurate frequency calculations by eliminating
>>> unnecessary shifts and divisions, thereby improving precision.
>>>
>>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>>>
>>> Changes in V2:
>>> 1. Rebase on superm1.git/linux-next branch
>>> ---
>>>   drivers/cpufreq/amd-pstate.c | 9 ++++-----
>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index d7b1de97727a..02a851f93fd6 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -908,9 +908,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>>   {
>>>   	int ret;
>>>   	u32 min_freq, max_freq;
>>> -	u32 nominal_perf, nominal_freq;
>>> +	u32 highest_perf, nominal_perf, nominal_freq;
>>>   	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
>>> -	u32 boost_ratio, lowest_nonlinear_ratio;
>>> +	u32 lowest_nonlinear_ratio;
>>>   	struct cppc_perf_caps cppc_perf;
>>>   
>>>   	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>>> @@ -927,10 +927,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>>   	else
>>>   		nominal_freq = cppc_perf.nominal_freq;
>>>   
>>> +	highest_perf = READ_ONCE(cpudata->highest_perf);
>>>   	nominal_perf = READ_ONCE(cpudata->nominal_perf);
>>> -
>>> -	boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
>>> -	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT);
>>
>>
>> The patch looks obviously correct to me. And the suggested method
>> would work because nominal_freq is larger than the nominal_perf and
>> thus scaling is really necessary.
>>
>> Besides, before this patch, there was another obvious issue that we
>> were computing the boost_ratio when we should have been computing the
>> ratio of nominal_freq and nominal_perf and then multiplied this with
>> max_perf without losing precision.
>>
>> This is just one instance, but it can be generalized so that any
>> freq --> perf and perf --> freq can be computed without loss of precision.
>>
>> We need two things:
>>
>> 1. The mult_factor should be computed as a ratio of nominal_freq and
>> nominal_perf (and vice versa) as they are always known.
>>
>> 2. Use DIV64_U64_ROUND_UP instead of div64() which rounds up instead of rounding down.
>>
>> So if we have the shifts defined as follows:
>>
>> #define PERF_SHIFT   12UL //shift used for freq --> perf conversion
>> #define FREQ_SHIFT   10UL //shift used for perf --> freq conversion.
>>
>> And in amd_pstate_init_freq() code, we initialize the two global variables:
>>
>> u64 freq_mult_factor = DIV64_U64_ROUND_UP(nominal_freq  << FREQ_SHIFT, nominal_perf);
>> u64 perf_mult_factor = DIV64_U64_ROUND_UP(nominal_perf  << PERF_SHIFT, nominal_freq);
> 
> I like this approach, but can we assume the nominal freq/perf values to be the same for
> all CPUs, otherwise we would need to make these factors a per-CPU or per-domain(where
> all CPUs within a "domain" have the same nominal_freq/perf). At which point the benefit
> of caching these ratios might diminish.
> 
> Thoughts, Gautham, Mario?

No; in this day of heterogeneous designs I don't think that you can make 
that assumption, so yes if we had helpers they would have to apply to a 
group of CPUs, and I agree at that point the caching isn't very 
beneficial anymore.

If the main argument is to make it easier to follow we could have some 
macros though?

> 
> Thanks,
> Dhananjay
> 
>>
>> .. and have a couple of helper functions:
>>
>> /* perf to freq conversion */
>> static inline unsigned int perf_to_freq(perf)
>> {
>> 	return (perf * freq_mult_factor) >> FREQ_SHIFT;
>> }
>>
>>
>> /* freq to perf conversion */
>> static inline unsigned int freq_to_perf(freq)
>> {
>> 	return (freq * perf_mult_factor) >> PERF_SHIFT;
>> }
>>
>>
>>> +	max_freq = div_u64((u64)highest_perf * nominal_freq, nominal_perf);
>>
>> Then,
>>          max_freq = perf_to_freq(highest_perf);
>> 	min_freq = perf_to_freq(lowest_non_linear_perf);
>>
>>
>> and so on.
>>
>> This should just work.
>>
>>
>>>   
>>>   	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
>>>   	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
>>> -- 
>>
>> --
>> Thanks and Regards
>> gautham.
> 


