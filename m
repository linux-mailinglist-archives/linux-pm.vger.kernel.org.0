Return-Path: <linux-pm+bounces-20058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D081BA049CF
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 20:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408423A59C7
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 19:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255F61F4282;
	Tue,  7 Jan 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xPQ+Ize8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43632594BF;
	Tue,  7 Jan 2025 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276546; cv=fail; b=uk3AVXuBmyk0M77j2woAhpFaMWhAZl8248M4MHiC7iDAQUMqvhlCfa/MelfarKe4TAcV2nt1n29loyWqGhWkTISEJepvMBFmkZI7/wa1pU2kNADBOGFA7zOrfNuObTuy+wp/Wm3PDsGU0Ijxhr9/ZGjges21GgmwCECiQYH8woE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276546; c=relaxed/simple;
	bh=WOLX5Vk5O23sO4dvIPixCOXFQWoBzHk1Hk0V1hkovQs=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mCcTpPTogtiNP0sYnBrHxUS76rZA2slyrD6d2jwDqnyoLfhvcr4kpEPeezW9kuQI36wU0WakNUgPoWbADEqVWSFR12BmdGaHba7fIT6Ettz0ezP9zTYpUM5iGlJkpAyy+SHnpqttWebbX1MJMqsrGbsGC7/vDzoGxTEfvW6tXgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xPQ+Ize8; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxP8+E+jL2RsQb+4v2UI91wKQNa/MOHcGQoY2Pc3b6DYKarNeOzAybb5G3CE2BCtcKS9//AJcJwFflsH8ybOQyWLsxVZcFsrL06QZeDLHJc/H3oBvEXWlI45kqv4pIzxxM62ezeoPnhwLI0CCeoTkgDAcMwc91PMYc9ccUZaKA0Z9/i6r1YmhlG+BeQjNbV6vy9Wpp4410QcX2Ut8JH2iW8+05nhoQcft+1769J+kAEQuwkfpl2H/27+H9UuTWoirgt7Jz0ZHj5U3d1PSm9epD5PM/P4QJ0ve9CPicIT39Cr0Q1Fl85dosi/JtE5aq/0uWO32gwHE21hLXFw9jCvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tuuwl6KkRM7Va2kgXCcOFftCu3GHlGVL6n5a4ugiAqY=;
 b=xCX5JUfX7j2PHGg8Zeu4oCpX4Nno31yefr7+tlECIacKDgzYaVXJK1YWvOT2bfDXlMGad8mLdY6Uk8sb8iIy+ljU6edmUrHYEpEzMe6W6OQ4hG58jyWoWbsu80i9YwdaQe0swAs9Rp2ofvdvMnhv0v/JseCOt8r+kzH6e7wh7nBX140tV0IOSU9Cv+560u1hZasf717n2mBMMzkTxKyuj1ILv0Wf37Q4NzlwPWo8O6vBiyRkrXskcfEfCSMhiMC7tqEvUJriufdkfd7MSuOpCkeRSfwy5FEzW+sqnz//ZWIiRzZChbzqlYxR+YrkwKL/dP2Waej+1Wk9OGde10OVsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tuuwl6KkRM7Va2kgXCcOFftCu3GHlGVL6n5a4ugiAqY=;
 b=xPQ+Ize8+ssWB2ZWMZ1FdTqxDi2DV7V1HFDV2tH/9NH4dsXyqBpxAh6B4bbxr+JVieN3PjEg0noNN3bFwWkvYyiOIeNHwtZhqbNFfeJFm1sUBCZzTX9QFGs0XlWCXq/NogWQoyRHtkrtqOXP6kJokzNG4TnuDIO34XzjlXu+4Y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 19:02:20 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Tue, 7 Jan 2025
 19:02:20 +0000
Message-ID: <746f627c-49cf-497d-bfc3-646d2668cd51@amd.com>
Date: Tue, 7 Jan 2025 13:02:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq/amd-pstate: Refactor max frequency calculation
To: Naresh Solanki <naresh.solanki@9elements.com>
References: <20241219201833.2750998-1-naresh.solanki@9elements.com>
Content-Language: en-US
Cc: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241219201833.2750998-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:806:d0::28) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: 6231660f-f3f1-4d54-e27c-08dd2f4dcfe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWYyNDhNb3dKL0hVUHJ2UHU0dzhXNTRnNjlVYTAvYmdrOFl0aVVqU2ZhbU9S?=
 =?utf-8?B?MUFLNGF1MldyWUJocXNXazZLUGZjRlJoNE8rYXhGRHZueHN5TkRtaW1rZVVX?=
 =?utf-8?B?Q21WZmpDUC9wb1BCcE5wUTNNZHdBUEtQMlZjTHhuOFhkc2R4MlJrWG54c1F1?=
 =?utf-8?B?Z1F1ZzJlclJYMDZRS0djZUg1NHN0VDVRK1BkNk9jaEQ2dHRHUzVQYXJISjVK?=
 =?utf-8?B?TjJjQ1NzVVl5NTdFOFhRSWpBUCtjOCt3QVBmNFhEb0VpZnFEVmJFY0VvcWoz?=
 =?utf-8?B?YXpCdFpQZWpEOWQyM3Q3WGpCZ0E5bG8rTHBpU2huVU9zKzA5WXdCQjM2TDNQ?=
 =?utf-8?B?R2ZhcGNCTUNnTXNTN0JsdlR5SGVnTHd5b1NDU1NMK1JnM3VqaGhxV1BIMjc0?=
 =?utf-8?B?bHdYZWZaSWJFNEZNaU9KQmE3M0VjMVF3R2QzUGk2WFlSTTFwblFpRzV5L3Jo?=
 =?utf-8?B?azNqeEtUZVNxRjlEYzFsaGtrWVlHaUVuSEhoUmNHM3g2NDViZXgxZWtweUEr?=
 =?utf-8?B?TkY4SGw0UlVhMllsKzlXZTlpeVlLbEhQZnVSb21YVGlTZExwUUpCdTQ1M0Nv?=
 =?utf-8?B?TjdNN1pBbU4xODZtYlE2Q05qV3d0TVZwUWN3ZncrS0Zhc1prd0ZUTWxBb2dZ?=
 =?utf-8?B?YklRdDUwSDJLOEZXUE4rWldNNDlnVWRjV0JQYlFXcWVYbnNxR3FtTk5JdU1H?=
 =?utf-8?B?N2NPMHZCWWJucWpOTXZmeDdVNWxhSlFkRy9GMUdWZDJPVDREcU4vSk1JZm5y?=
 =?utf-8?B?MVV6V1haS3F5TElDbDBmT05CWHR2SWgzelR6eHp5TmRyY05Uc0tSYStaUFNJ?=
 =?utf-8?B?empvdlpxWmU3S252aXN6OFMyNnFBZkllZ1FoYWY1VENoeHlzREZXNVpzc2ow?=
 =?utf-8?B?Nmkza3hZQ3puRjFEM3BuOGszSDhrZmtmRmNDYjJqV3R0cEpCZW83L05ydktm?=
 =?utf-8?B?VXlQWEJJbmp3ckJkanJabnhZN0JDNTgvbW5sWFZwL0NzeGViM09jeXFXMHF3?=
 =?utf-8?B?Zko4b24xQ2VCVE5EVXRORXNBMndVUmdCb3h0UUNWQm9kRllhMzhCQ25hUHov?=
 =?utf-8?B?ME9sS0diV2kzM29zczRpazN4QnZha3RoWXp2V0pmaG0ydzI5c05zMG9DRFBn?=
 =?utf-8?B?cFpQMGE4QUhpRlU1a24yTFpSWjdiQ1JNQjUya1hkalI2QXF1aFVSZUNwSmRH?=
 =?utf-8?B?QlBJOEZiUGxoN3E4bzJQenUxTkJNUjhCSExNLzNpcG1YUUVzYm9ORUZkSmhO?=
 =?utf-8?B?ZXAxSHc4UUZza2JTcDhCWnFaclp1QTJWajRVYzR4M1N6eGVKOVNjNFZlR0VD?=
 =?utf-8?B?aDhhekhUb1cxdlpzVitmR3RtOHdsU2ljK05hQjVBVS9WOE4xcFV3cVJSTTdr?=
 =?utf-8?B?aFdHK2xDNzUrNHRTVEQ1amdUcHVqMU9BWGpmS0VkeHNWQ1dELzl1bVc5bXMy?=
 =?utf-8?B?OC9HRHdqU0RGZTVOYnI4ejhLdm91cUdsT3dUVzRYK281SmFDUXNUaHRsRkho?=
 =?utf-8?B?eWtoeFVpenQ5Qm9ycDhKWnNPZ0F6dTZFOGp0SEJGMXoyRjMwUnk5VFVLdldT?=
 =?utf-8?B?THcvbFFZQkp6eHl4T3dEbmlJMmZRY3pvUEgyUVNVcVRNcGNoRWkyeHN0VnRK?=
 =?utf-8?B?R0VrRi9jSTVtQkFzLzdvaXdyN3VXWFh1aGxWWHpVSGFOcEs0Njd1aDZPUWRv?=
 =?utf-8?B?M1k4bmZZaXhoVzk0Q0k5blRvY1loalJzZWh5MFY3bEFkMDc4Y1dURVY0ckc3?=
 =?utf-8?B?bDIxUG1VZmFUQXdHaGJ5cVVpbEtqc1E4UWFRSHlQUkxRUzBOdkw0Y3MxelRC?=
 =?utf-8?B?Nk8yaHFZeU9JaG1LVmJaZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEtxQXdIeEVTZ1YzQUdjQ0Fya2RFUlNvcWZ5cmFLS09yekJRY0ZCbzRDbmJt?=
 =?utf-8?B?YjkydUtzanMremZrK09vL3RaRTdib0kyVStTcWdXVDJMOGxEMlpRUjBXdHhj?=
 =?utf-8?B?R0REbFNFMUpjbjhtQTRndEZDM2c0ZkdvUVBZTGRNbGZiamJZL2FLUGRSVXBy?=
 =?utf-8?B?b3NZZzJreWxXSGVtZE5uellkVGxEQ0hwM2Z3S2RFRUVvM3lKdGVabDhyZ1hj?=
 =?utf-8?B?TWdhMGpDODlRcFZRcWQreDlFSzdoTmY1aDRKeG11YmJyYkprb0lGemhPalJD?=
 =?utf-8?B?UVZnNWkzU3NINWtWbXJVeERDR2YwRTg1cWxpeUZsN0dYdmpSVklnalkvZXkr?=
 =?utf-8?B?N3FqaUVIckZnQ2VSTUFRWng0MWJsRHd4THoraUFCYTNJaVBkZE4ySXdVcEY0?=
 =?utf-8?B?QlZjTmhWWEg2Q1lYVGhxaFRMZXhRWkhZYWRIa0RaSTdMcEN4a3dRQ2hvTUF4?=
 =?utf-8?B?blBDem5Pdzl6RGlWSnRaSlFETnkvZkFWYmtGajNmV0E0U3hSYjlJOURKZkxT?=
 =?utf-8?B?bUJxbHU1bWpYZVlta3JCWmIrUU5PUzFBSmFWdzVxemxyTkVSN09HWVVPeks4?=
 =?utf-8?B?TGI5Q2ttTlFVL2FrdkRBNHNhMlFaVHQzVVVlcEFsaTZBZTZBTlpWalZ0Vnlt?=
 =?utf-8?B?Rko0K2dQd05mM1NDL0gxUGhsM3R3amxQNm40RkZLSEpIZUdvQ0pETjVLZGF6?=
 =?utf-8?B?UkNFYW9TNXIwcjJuMERvbUk3SUZKZzgveXgzaEU5SkRSQkR6SjQ1amRnZmhl?=
 =?utf-8?B?d0hKTGRwS0ppWEp6dVc3T05qRWZaWDd6UXdIY29NeTFGazRpTlMrcHppVFBM?=
 =?utf-8?B?KzRkb3JiWGZKNHdJRUhBcTQzM2kxemtoN1F1azIxLzVsdmp3SWJVOFJqUStu?=
 =?utf-8?B?WlZEQ3UrT3VReVk3ejl6VitCTGU1d1hIRDFCT0w5LzJxWlIyUzhxNEdpNXVN?=
 =?utf-8?B?a2ExNXVLTEN5enpaWldmR09iMnVSWnF2V1d0TnBRQTRkZ3FxYUV1NHRKTXNH?=
 =?utf-8?B?d3ZLeEdWRFNUQW02TTRmWG1Db2FMZmRDWXUzY2hjM291SU1Rd01Vb21veUVp?=
 =?utf-8?B?dE51K25sc3dJMDU5SXlXWVN6UGxCRThvZmpudkg2aEVMYWdIdFJSWGIxYURr?=
 =?utf-8?B?b0RuMFhObnhCK3Q2K1J6bUp0L0hBZ3FPTHh3VHIxVTVXcG1Pb0pQcnpRUURB?=
 =?utf-8?B?VUNSb0Yyd2wwY1FzYkllWWEwWXpGU2NvSCtIOUR1VHFONXJRSVZTaDVaenJ3?=
 =?utf-8?B?bVBSdGE1dVJLZHdzcllNQy91MVhweGRWWWYvYkR5Tk52dTA1Q1QzUVJ6WXNC?=
 =?utf-8?B?a2dyb2lOMnJUeXdhVzYvTE5wZW1SN3l5R292TXBlSXFPMTNpcm5RNEJXQWR4?=
 =?utf-8?B?OFM1OXJXKzFDZndJZVhja1h4T01LYVRaRlI1MHVnaEUyYWtvVUUvM0w5MUJz?=
 =?utf-8?B?TzB4anBlcUJ1bkxXbTdZYkR0NEZMcUh4b25XeVRpa1hsSXFJMnJPMStkM0dm?=
 =?utf-8?B?TThJWDh6UHNYSmg3NGwvbSs5MzdaeG9tUUpGZlFmaUtRd2ZpT2hGd01VNU1J?=
 =?utf-8?B?T1FSK0pJNnJRMVRJYldYWDgyVllLQ1JlajdUL3NGSXgvcW1yV0Uwc0IvTzhB?=
 =?utf-8?B?MHJvRXpQdDlXbkxwZVNueEd5aFp3bFhrbkRYN0drUVA5RjlEM3Z5S2RKWnR6?=
 =?utf-8?B?ZUpidnZ6NzVGQmJKQ1VFdUVwam42ZjdwdGZkaElQMVhCTm5zcHpGZXc2V3Nj?=
 =?utf-8?B?WVVSOEU1MmlYdHVHL3FPd0NKbU83UGxpblE0V1kyTVNseEM3VTdBay82ZG5R?=
 =?utf-8?B?K3AxWEVxQzhHNjdMMWRDaGtWUkpwV2ZWUlpnU1ZFMFlOM0IxL29jRlkzdzRO?=
 =?utf-8?B?eCtFV2pObXBscDM0Y3pNT2N1UUJxNFRhSDI2dzZYdkc1ZTdReDdQWFFoY1J0?=
 =?utf-8?B?eUFJV2VtaU0zZTlMem5SVldkNmdpSzhNY0xjNUdkOTdnYXhCemQ2cktuTlA3?=
 =?utf-8?B?SStTOHp2SjV4YzJBNENsdExBdC9FSkhkMUs1MU5taVN4ODI0eEJZS2dmdEhi?=
 =?utf-8?B?QVNLUU1zem84WlFIUUdJYjh3a1NFN29iNGJETlo4UFV6WTd2V25rakE1dlF0?=
 =?utf-8?Q?an3gNc/ozMfU5n8W4Vh9G/9iz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6231660f-f3f1-4d54-e27c-08dd2f4dcfe2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 19:02:20.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEFOZvGivofG8r+qOAS/TnpxNXmvl7QrNxD7Tzi5TRmsgrw/OcgLVMFCHdX/8dEAyfPnjM1fvkzdoTAhz7JrvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123

On 12/19/2024 14:18, Naresh Solanki wrote:
> The previous approach introduced roundoff errors during division when
> calculating the boost ratio. This, in turn, affected the maximum
> frequency calculation, often resulting in reporting lower frequency
> values.
> 
> For example, on the Glinda SoC based board with the following
> parameters:
> 
> max_perf = 208
> nominal_perf = 100
> nominal_freq = 2600 MHz
> 
> The Linux kernel previously calculated the frequency as:
> freq = ((max_perf * 1024 / nominal_perf) * nominal_freq) / 1024
> freq = 5405 MHz  // Integer arithmetic.
> 
> With the updated formula:
> freq = (max_perf * nominal_freq) / nominal_perf
> freq = 5408 MHz
> 
> This change ensures more accurate frequency calculations by eliminating
> unnecessary shifts and divisions, thereby improving precision.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> 
> Changes in V3:
> 1. Also update the same for lowest_nonlinear_freq
> 
> Changes in V2:
> 1. Rebase on superm1.git/linux-next branch
> ---

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

BTW - Over the holiday I added this to my bleeding-edge branch [1] and 
have done testing with it.  I will be including it in my next 6.14 PR, 
thanks!

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/commit/?h=bleeding-edge&id=857a61c2ce74e30fc3b10bc89d68ddd8d05b188c

>   drivers/cpufreq/amd-pstate.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d7b1de97727a..6f6f3220ffe4 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -908,9 +908,8 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   {
>   	int ret;
>   	u32 min_freq, max_freq;
> -	u32 nominal_perf, nominal_freq;
> +	u32 highest_perf, nominal_perf, nominal_freq;
>   	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
> -	u32 boost_ratio, lowest_nonlinear_ratio;
>   	struct cppc_perf_caps cppc_perf;
>   
>   	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> @@ -927,16 +926,12 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   	else
>   		nominal_freq = cppc_perf.nominal_freq;
>   
> +	highest_perf = READ_ONCE(cpudata->highest_perf);
>   	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> -
> -	boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
> -	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT);
> +	max_freq = div_u64((u64)highest_perf * nominal_freq, nominal_perf);
>   
>   	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> -	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
> -					 nominal_perf);
> -	lowest_nonlinear_freq = (nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT);
> -
> +	lowest_nonlinear_freq = div_u64((u64)nominal_freq * lowest_nonlinear_perf, nominal_perf);
>   	WRITE_ONCE(cpudata->min_freq, min_freq * 1000);
>   	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq * 1000);
>   	WRITE_ONCE(cpudata->nominal_freq, nominal_freq * 1000);


