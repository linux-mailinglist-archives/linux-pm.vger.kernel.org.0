Return-Path: <linux-pm+bounces-7593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BA78BE6CF
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 17:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C14D1C21F2B
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259261607AB;
	Tue,  7 May 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k+FqdQz8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646E15FCF0;
	Tue,  7 May 2024 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094109; cv=fail; b=hEKDZBIr68FuYUjhEe+X1sFBaLUmjkG3kpMoEHqDZK5nXc9UWLSnpI9dm0+0MP1bRs16k4GqSZVipZ2RflVPzdRyxSZfvwESPYotcFO/igZOk742VljzijUGD7aFG0zjLoxL79YHtZHymvSusk/9+VczCZGyQN7ihBzrMFy6+6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094109; c=relaxed/simple;
	bh=WGsQyI6WbRq3OO/Is993TFH5ShoQQpYpjPh6k+JbbUY=;
	h=Message-ID:Date:Subject:Cc:References:From:To:In-Reply-To:
	 Content-Type:MIME-Version; b=Sy4EVMCBmGpAwfejD2vPJLq+qQP/+pjcFmN3Smlmgsm9PxSfNID5BMCumCVMW+HSuSkgD5Yko5kH+kay17oTgFTxzJvtfGtvj5CsvDgHcg1+jmUBU7PZquxLGkcu6srX3I4Kx4TB3GUKGo4hBv2Fnw92SBEUM8zTKu0QCcH6lmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k+FqdQz8; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dds1PpbOHTPTT2BePE4a3N0E6U8pYcmFUwicU1DzkzPR0m0lJBEa8niKEWiXxMROvCk/oB1Z5p0v6d3sU2GRgvs7jop4hBCHy6dg37ATmf+Kvzh+PXyP6+EP2804wAqVT3cibLqC4qGu8c/WLLp7Qq1o/mXXeL8Ynwse2PtIZS1oA6aCo/aQBzbF9h4CqxDBKFVmg3S98apZvls7JfPDxmYIB+N78uDeQG3vL43ZhXEs5fMiAC6TG41DXabPcp9BD1CUzmxEFSmIuVOZiG0PPKIJ1tBoAkllRxP0/kckVzvH2Ek9LZpVo10gbPvwO3tpts1sBqV0vrqttHb2TkPqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5v496g1/Odu1g2PS5ynYbDWAxJTa2xj8rt/s7/e+DE=;
 b=Qb20F8BRPgRuSVdkM3PGcxcy1AOeYCmUzmlLrCKGggn4kabCmpinIU6Y3/JWWtntmqffz4YAOX7V7Qw8QsSEfvmaJBNB69tSsLAx3oGhRUdXk4Y7JAxyaw6RP74NtHkgqY6FLE66kMw35HqhmyubfT/gXOTkFvrdftpPQLUjj1Dsifh++OfW8McyQdIZ159+HUzQOOfaykTsjvjQv4CDrRakJlxhIhFGOKurHUi0hmdsS08wjNvOfzFQAV7Txqso78RUtEa5JPX6L0ypTZUjMXCa5b9PHVm7MMzVNQHtkVb1xq8jS1e8oRLLX+uF17nahknhvMJ/t43nnOOROVHuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5v496g1/Odu1g2PS5ynYbDWAxJTa2xj8rt/s7/e+DE=;
 b=k+FqdQz8EPt81hcRKbomkjlIPxKE4q18eEw6BfMYDa8qhYPX0/lHEaHEgnJaYq5Oa4d+GT3nd/xEMy0ZxvKzHu+YJJLzoVeEoAYQ7GWXfl9tIWE4M6AwdgUibdF20dvFQGRHVToFy3japw/SPgydCExni+3bICy/ZiPg6cLd9e0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 15:01:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:01:39 +0000
Message-ID: <e095cc78-3a95-4a65-b379-efc8a37608da@amd.com>
Date: Tue, 7 May 2024 10:01:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] Documentation: PM: amd-pstate: add debugging
 section for driver loading failure
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com, Borislav.Petkov@amd.com
References: <cover.1715065568.git.perry.yuan@amd.com>
 <ecc1c5a061859f9b9532e54f2b64d1cb5fd593c4.1715065568.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
In-Reply-To: <ecc1c5a061859f9b9532e54f2b64d1cb5fd593c4.1715065568.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0041.namprd04.prod.outlook.com
 (2603:10b6:806:120::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b09d4ae-0dbc-4bd5-54fb-08dc6ea698ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjZlSTVic2FXSWVPSHZtNzZSajIyYStSM0kxYUNXL3BFRStKMEdEM01iWm1p?=
 =?utf-8?B?OTJac01ZK3ppRnpPSEk5OTNjeUxqTGM0SHBFSVBzelRlbUJwZy82YWlweDk0?=
 =?utf-8?B?Tm1LSVk5RUE5Wm5ScU56aVRKVlQzZTlvcGJIeGRDQlNtWlRTRmZvbk5zbm9F?=
 =?utf-8?B?NFF4QjBWY3d2U1ZNMjNrcEpETklBcnFpS0JLVkh3UEp5dldkMkliQ2Y0eXdj?=
 =?utf-8?B?R2tlS0kycjJOVW16c0hKbVdIVURYMDQyOHZQNGt5QUIrSU5yTnJQeERaQ0F0?=
 =?utf-8?B?MDErUGJrVkVXLzVMN0NxdFZMencrRW9CbGxZeGVnY3hOQkdLMFcxdFNzU2w4?=
 =?utf-8?B?T3lVWGVWMGFqMHg4Wkx5UHM5NFoybTg1blRVSzhPNVBaaWFwY2Y4UVR0dUtv?=
 =?utf-8?B?N3NsV3M2eWdYZGtTdXhVblluSnlFbU1CT1ExSHJ5bnhyMkhMQkljNjMwS29Z?=
 =?utf-8?B?R1UvZ3k4OUVzZHhEWGRKV2Q2SW42MVFyWDhZbEd3eW9WN0JGaFJDTzgvWkh0?=
 =?utf-8?B?MnJ1R29LYmNaY2NRZzBqUUJPQ2RuU3NkZjB6Z0UydFl4eUZhMWFzQWY3V2s3?=
 =?utf-8?B?bTVvdGo2NkVsT0xiVjR4RmljdUxkTjBFNGgxRlo0YXpXQ1JTaC9Sak9sR2dQ?=
 =?utf-8?B?Vk9YcmJyNy83Q2xVbEZaZ1BkdGdUVzRwTEx1RlZqTDlOakl2ei95RFhEWXF4?=
 =?utf-8?B?NXZWbUZ4VUIzYlFVRzZjZTh1Y1lERWtobisyYW4rQk9TK2UzR2VvamZ2ZXRJ?=
 =?utf-8?B?a3JMbXp0YzE2czFIelI5QUQrZVNGWlo3U0lNRVlIL3NZY1lDOHhlWWZvVGxH?=
 =?utf-8?B?S3p5WS9WUTExVjM1dHF5L00zdjQ3YmsyVjBEbGFzVEY1QW50STJyajB5cWpH?=
 =?utf-8?B?RDFnSWVxaGtIWGx1cFc1WkpTSlcwdGRUUmdGbkw3c0w4L2d2NE1lTE5qZzhp?=
 =?utf-8?B?Z2J6NXpRTFB6M2F6MnVaK2hJd2ZMSXQzM2hrZEE5aGNwS1N5WUVyZFVwanBK?=
 =?utf-8?B?ZGs0UXBXNmV2L21CdklvTDJMMjZVYkwzRkRYZWFHVHJodTdFRTFjZW9pYlVt?=
 =?utf-8?B?V3BOaTNYU0hxN1dQUkFnejFMRGo3OWVqOVkrcGs2cGs3aytZd1RLbVp5bTc4?=
 =?utf-8?B?K2tUa1MxQ3pjQzlMRnBrTzV1cUdHa1VyZTBOdXJKT1hyY2JITHJQZEFhaDEy?=
 =?utf-8?B?bWc0dDcrUDZEa3NDdVNhZUFHZlAyeStEOUZTeXhpQUMwOVNPeE5iMkVmSnRz?=
 =?utf-8?B?YTQ3ZTJtS0tYYURyWHBCWVRkaDlkZ2NmME56dDF4VHQxUkxmS0p4ZVdlNVBh?=
 =?utf-8?B?S3ZqeXJWd2FITHg4cmtJNC9tWjd0SDBkY05acjlmU1pKbEFtNG9QUDJxTGtr?=
 =?utf-8?B?amRLa0Qvb3ZVcGQreTVYdm81ejRaRVhkWGJsYTFOa0ZxdVphUHozUWxVYVJl?=
 =?utf-8?B?enBMWCt4SXQ3N3Rud2pGT1lSTEJ5ZFAxVkR5NDBBV3dZbEJLTVNmYUovYlEx?=
 =?utf-8?B?YUJYWUc2elJrcXE5UVZ5ZkFLZFpYOEZlZ2diQ1NLRFByeVN3SXFDOXlodDVu?=
 =?utf-8?B?QnZpK1MxVUhBVXV3U1VkcGFsOWw3SUpZS2t4WXJWMHlicUlNeFNrSnZ0U210?=
 =?utf-8?B?bmRMRDY1U3V5QStGWi9WSG1CdW9RakkvUkVrMjZIbU80bWdNSFJDUS9HTjlt?=
 =?utf-8?B?R2wyV1BhZWhiQ3VkS0FaV1laMG5wbVh0UzRVakhuVE1raHBBR2tZRm5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUJrMUUwbWcwUWpXbng5SjlMNHNUby92UXhVM3phZ1RoUkZkM1FZT010QVVu?=
 =?utf-8?B?cFgycGNaakZzUVNQcmFtVXhaR0hnTDlta0NacEoxUTZub2RYd0NCZm01M3My?=
 =?utf-8?B?d29FQlRpMnBmTDdJMG1ERnJ5ekFReDUzZnV2ZjRwNytIS3pnTkIwdFdQL20z?=
 =?utf-8?B?K3M3dWU1QTU2Sjc3OG8zYkN4cnEycW16ZTgyOEEzWGtaYzVhdWRUZTZqZytR?=
 =?utf-8?B?MUViM29VSk1hRGQrckZzYXF0UUlpS1RIZ25PMVdIZHBUM3hLQ1N4Y3NvQVBM?=
 =?utf-8?B?eHErRksxNDhBREVKSVA4YUZ2WWxCSU9mbFVOM1p5RTFJcnQxaElSVmdSU2x0?=
 =?utf-8?B?dlJhdHEzZ0JyajBnQVBkL1RwNS9vWGhZQkJuWGlKcndDQVpSTmY2eTg5NUh5?=
 =?utf-8?B?L3pTdnAzQjBZeXc0c1V0MTJsTkFOeGxvOXAxekpsb1pVVFkvUmZIeWNwMGd6?=
 =?utf-8?B?MzZKV1lYUkFrSS85UzYzZ2VkdmJiL1ZYakNSZ1M3dE02dHY2Qy9TSjhaZnJz?=
 =?utf-8?B?a0VDaHh5czNUdlFHclVuOHBRVmNQc21YSzR5Z0ZENkhxRUUxS3RtaDRUMkJU?=
 =?utf-8?B?YzJWR2lrcEFpWklCc0M3dHF0cGVMUGlnQjhYenlLYlBuUzVXR0VPS2VCS0Fz?=
 =?utf-8?B?a1RsTUlFTUN1bTl6amFaRFlXWXpySjREVjZiY01jcHdVV2FKSVBrSTZrY2lo?=
 =?utf-8?B?YzlUMGMrSlh1b3c3enZDS1IyMHhHM3VsVnI4QjVmOEo5bGZ1cGNESzBReUxv?=
 =?utf-8?B?c2pXVGNoUHF1SXA3SDVINHFZSHlpNUM3RkhEYjhlTjlHSS9GcVdQYi9WaW9G?=
 =?utf-8?B?bUIwRVRBck05R3JNQkdxaFNFY2lIeURUUy9rVU5KSXpYNk1KRjVaTWlTbFJh?=
 =?utf-8?B?TEJjN09CZFhqSDBiM2IrT2N4LzBET3kwaDJQWldsVTlYMlNSelFFVTY0cEY3?=
 =?utf-8?B?NVU0THg5U1BZSVVHY2o5ZjNkK1RwaEZFQW9KdDR3b0VzRW9zQ3hQYkgvYitl?=
 =?utf-8?B?WTZmVDVpOHBFQWhyL0w4T3VzaDF6RVhzanExWGR1ZlBiVG8wcklZZ29XNzBS?=
 =?utf-8?B?NW55RXA2RXFhYmoyUDkrN0VGOFc2ZVVIdTQ0ejEyRTlLelRJVEFJN05aN2ZX?=
 =?utf-8?B?ckRpL3ZESFFVT1Q4cE1CRTQ2NkFKWDlZZm9WanNpd2plYXF0dVcrY1YzRjVT?=
 =?utf-8?B?Vm90WTV1cnhlamV6T3pFUzZzckkxVUZYaEUxcHVGQzJZSHF6TzRhWHhWc2JO?=
 =?utf-8?B?L21SRGxTVTkva2hqSGRod0ppSGVWeFFyUTlNZXRvNlplOHcyZ2o1d1B2VXh4?=
 =?utf-8?B?VjU4NXBmTjJRNXRJMkVOMVpsWVhOdE5GZDFxWTBweWd3NGYvNWJWdlVmT1Qy?=
 =?utf-8?B?akpucUlIdzFMekUzSm5Zd2JqSjE0VkVmZ04xVk4xN085a1NQOUdyWVlxbFpU?=
 =?utf-8?B?N2NIMzdsUE1hTUJWUFpSOElTeTRDSnVPN1RwdVFrR2lxODlyNW5hK3RFVDBW?=
 =?utf-8?B?dzZpbFNhekNRdXgybmxDVjJVcUFDNS9tRnRYUGZkbFd2YnlvTEdUOUpjdVl3?=
 =?utf-8?B?dXNERTd0WU5vRFpJR0YzSlJXelhmbU5xNnovTTBzTGE0SWhVcy8rcUxoSVNB?=
 =?utf-8?B?bDRnbi83eHhrK002WEIwcHI5ejBKTlRZVXM2eWtyV2lxSWtpaDNHbExoc0kr?=
 =?utf-8?B?MTY4UExybGRWNXV1QXkxbXhWcXM5VnZ6c1dpZWZsMGtVeDQwc2dqemRkUUcy?=
 =?utf-8?B?S0ZMQ2FFT1d5dHcxcnpYcklKVXBZY2ZhZ1Y0cHlHQmJDTDJzSFE2a29uUmF1?=
 =?utf-8?B?NFNLekMySzJnbVdHQ3YvYzFwVmhVVk4vWWtLT3cxL1d2OUpKbmRtdjFvaGsz?=
 =?utf-8?B?eGJSRkRYM2o3TnNySFFoU2Z5ODAzOE05Q256bEZlTDMrYXNtMmsrS0lKRlls?=
 =?utf-8?B?YkRpcE5NTk9FTHB1eFFOcXJ6M05mME81ZmNQbzJveWZReGRSSWZnSUlwTFB4?=
 =?utf-8?B?QzE4aktIaFRlWlA2aDZ6VnhPakhzV0R6cElaL3hhaGVVK1VYdE1zYVNvM1VZ?=
 =?utf-8?B?dHBvZGNFMk1OZnpqalFROVNRbVBIRTJrNmhjcDJpQ3dwSjJYWkhjRnY2c2t6?=
 =?utf-8?Q?loJQ3fP8tT3RNlNM2VlV0sf65?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b09d4ae-0dbc-4bd5-54fb-08dc6ea698ec
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:01:39.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AX2MxjR2ldOYTffMp6MgkrsuIt2tv4sXhbn/AexzRF8oPj0r4+85kHWg4QIrtQt2v5xRZfG5+aN1/c1X+5oINg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246

On 5/7/2024 02:15, Perry Yuan wrote:
> To address issues with the loading of the amd-pstate driver on certain platforms,
> It needs to enable dynamic debugging to capture debug messages during the driver
> loading process. By adding "amd_pstate.dyndbg=+p cppc_acpi.dyndbg=+p  loglevel=4 debug
> amd_pstate=active" to the kernel command line, driver debug logging is enabled.

Here's an attempt at rewording this paragraph to consider.

For debugging issues reported by users with amd-pstate dynamic debugging 
output is often needed to aid in root cause.  amd-pstate does use a 
variety of CPPC functions that also provide dynamic debugging output.

Add documentation showing how to use dynamic debug for both.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 2695feec1baa..230e236796f7 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -476,6 +476,19 @@ operations for the new ``amd-pstate`` module with this tool. ::
>   Diagnostics and Tuning
>   =======================
>   
> +Debugging AMD P-State Driver Loading Issues
> +------------------------------------------
> +
> +On some platforms, there may be issues with the loading of the amd-pstate driver.
> +To capture debug messages for issue analysis, users can add below parameter,
> +"amd_pstate.dyndbg=+p cppc_acpi.dyndbg=+p  loglevel=4 debug amd_pstate=active"

Two things:

1. AFAICT you shouldn't need to set the loglevel, this should only 
affect console right?  Most users will share a kernel ring buffer or 
journal.

2. I don't think the debugging suggestion documentation should include 
explicitly setting the mode to active mode.  Active mode is the kernel 
default already.  Users or their distro may have set the mode to a 
different mode by default and this may change things unintentionally for 
them.

> +to the kernel command line. This will enable dynamic debugging and allow better
> +analysis and troubleshooting of the driver loading process.
> +
> +Please note that adding this parameter will only enable debug logging during the
> +driver loading phase and may affect system behavior. Use this option with caution
> +and only for debugging purposes.
> +
>   Trace Events
>   --------------
>   


