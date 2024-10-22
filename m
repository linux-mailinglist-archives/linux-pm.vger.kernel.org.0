Return-Path: <linux-pm+bounces-16220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DCA9AA2B1
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579381F23829
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ADA19DF4A;
	Tue, 22 Oct 2024 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aMgGNhVw"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7870319C560;
	Tue, 22 Oct 2024 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602209; cv=fail; b=e/ok/ZFkKVM9OrfTcaJJULcQyDNZ9LxvUjsz0SzEImPLyLi7sVhvgxYLBCzp+NPsprhsGA1qWdRmL06Qhy8sYXsDL/WfRTNJOygJVZrWlIxyO7kpc0SFCx1mck3Q2R7ivkXLyJ8ympapoYCu9HaU4nHSd8XkVWGr/MupEiHghH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602209; c=relaxed/simple;
	bh=qYmXf1HN21ZPhXAR0lHqhLqZ7U7AONrKV/9MDdc35dU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qXbo+hOyZqi80G9cpf7OMYH0mOtjukgFFQIw4DVIRrx6hIQPMDfdLEFknFin+BjWLLUgqYOGOcEHrlxFI4AX+rsFEifLb9jICJgBpSDnysGeQW9dox9MSCwXDu1CGV+FVxiLmLIJN/lmOrK8BphiaVRZRWPhErkyZSKaWK9/Ng0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aMgGNhVw; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbdYz2V5L4ERKTD0FFsqSfvOdu3elBzTCcV7FQDDW0vKHDbkjc2mOjmlNlyN10uu6+yNUk5caWIFVqPY6ynMzwdVhIwW5hby1eyBpErQed+ncMRnGHp2pwG9mYrmthDeTCndJMaEdq8jGNvHb+xFJPlpDf4tmB8RrdFyJbKURhf/Nu8+mpntapan4RgSO396JW7oX53xaccoIak5bdc11Fa3ZIYV3SpaUC+r4jpmY840KeX9fIe2fJ3MMG/lgaD8csUuUDOFFgzMY/wKrEk18QCONH/QzSAiFt/d2B9imsmKD7u+fVNPIkYK/XIWNIVpH5/LwRXEks9gau3U0040mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GDHQajzi4h2IA3ssA8WksKH4RDYRR9ms2n/bh9exq4=;
 b=NsT1ZsTP6qpQYDsMuNUBD8LDre7N/ralCVij/W33N6uWz2HFdA7UCjze2i4OT5PJ4KZvy5Wab+weyvl1cG/dwqGDKiklgpP0rXsJWR25ScopBPcaQkZrKaZ0sZ2yMKKLdLT6lpm/tXlekZ7ybYrfVf10V1xD2ldjY9i7DgyRJlK0ac+9GhPasND09hLkxqYZ/pMkpWOkoExe7pademaKkuDN159iqzEbc7caIrPVpecM8vX/xeMl5upQRAoIiZdoOy9BPJQDNP9Sd64yz+TIfnmddls/aebKip8a9+uzlPE1xEkfV0tNLJfdZok9229nzZn3iBEBsNWC6353+jzX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GDHQajzi4h2IA3ssA8WksKH4RDYRR9ms2n/bh9exq4=;
 b=aMgGNhVwlKV99azO5mjCjbzLUd8ErRpn5UNRsIApZod/hmUEBAS0WX8xGo/mSH0kKquIgTUuH2zDrz1pDbLn+EVtbSU8sgnr6QuYlib/K481o3hIe56/d85tgfFzxjf99CqNfs5XT6xoQknRyFvquGzaC6y4yXM7+VF9986xO1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:03:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:03:23 +0000
Message-ID: <5247ada7-78f1-49e3-8076-cd85386126d8@amd.com>
Date: Tue, 22 Oct 2024 08:03:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] x86/cpufeatures: add X86_FEATURE_WORKLOAD_CLASS
 feature bit
To: Borislav Petkov <bp@alien8.de>
Cc: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
 <20241015213645.1476-4-mario.limonciello@amd.com>
 <20241022124202.GHZxedmqPeFd5F3sL3@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241022124202.GHZxedmqPeFd5F3sL3@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:806:23::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 08239f8c-ae23-43f9-92ca-08dcf299e908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Znp1dlkvRThCcWtZaDF5ekRPY3d5NVErRmlBeGpHZXFNMFZpeGRRbk5Ucmt6?=
 =?utf-8?B?STlza0dRZUVtQ1R2YUxhZDVKZjZ3SjNkQ1VlM2tudDFXeWhEYmhwMEhxNEYw?=
 =?utf-8?B?ZFM3b2RQSVpPcEFhUFd0bmFTZ3Q2Z0dSc05qM2FDSE55bE5pS3QzanZwQzVu?=
 =?utf-8?B?RkZQemZhWnpRZUlBaTJlK2FQUzBmMCthL0hNY2IyZit4dlg0T3poay9IU3Zv?=
 =?utf-8?B?TGcxUnh5aGNUbDFFTElEV2hlWS9JSTVsYWJTUmp4bFIxb1hJZnA5NFFnY2Iy?=
 =?utf-8?B?TGdQd3dMNkRCSGxYL0xiN1hVVUZXUkl1bDJkRWt2REh6cGZsODZkaVRhRXlx?=
 =?utf-8?B?Mm4vc2hMbktDRWF0RjJKd1hwZThaRXVpT0p0ZTBabkxraVpmQkc4Ull3QWhk?=
 =?utf-8?B?THI3eUNKY280cGNSMGloTnIvMXFUNmVINFJKWVE2cllQenF0Ym5PWnh2aVVB?=
 =?utf-8?B?NEZ2OWJocTVWM2FIYjJjSE9TVE9Rd0dWb2pSR0xrN28xVnE4ZFBVZEFZREpl?=
 =?utf-8?B?UERjQXVSTnJqdkNOaExMaklvNHBUME5kbkRZdmovRmwwZkMzcm9HVWNVQ2Jt?=
 =?utf-8?B?T0tuR21DWCtROEErOUdYTWdBVEFHdmkzekxyd1RvRmlUNERiSTNaUzF3am02?=
 =?utf-8?B?VEhpUmRsQU9OdHNPdk9qbG1sR1dRdnVIVGJINVkzdk5DR2hTemtBbnZQblFC?=
 =?utf-8?B?SmFwTXliUksvaTkyeWNBVXcxT0Q1WHlRL0NxQmFwaWpsak1RdE4yNTZ1aDZL?=
 =?utf-8?B?SnRoUkNnSnJLcmV5Qm90dkE5NCtTeG1veERFVzRPTG9PbkcvUVVrQTl2NDEy?=
 =?utf-8?B?RmJZUmY3M25ZK3piN085RkhCVVFHRXpRcGdtVy9WUmhZd0JEZ25jZlZtU0Ny?=
 =?utf-8?B?di8yZFZDVjJkZnRpY0c4N016VkN4b0hTYzVHK3N0MlZZcGV4aXJFKzdRQmFU?=
 =?utf-8?B?LzJySXBsM3ZoeGY3ZWlldmNVeTlJTHVZSjlZU0dkY1JVdkMrLzlWcktvRFVw?=
 =?utf-8?B?bFhnWU5VSktzb2RyMkVMOStyb0VHckZoYWhsU0ZOYWZoandyTEJGVU1LOEp2?=
 =?utf-8?B?dWxEbTBRV2F0Y2xxWVZENm5TUmdoVW4yaXhIZW5NU0UxSjdaTTJhdFJlNTZu?=
 =?utf-8?B?N29EaVdvNmI2UVhoRG1kZm01ODhPQ2swdThHeGxnK1ArWFpJRFNwU29RTzd0?=
 =?utf-8?B?ZDVtRWFoVHBHTXZuVUtSU2dFTHpRVHR6c256YVBhUkdFdEg4QzBpT0dvREhI?=
 =?utf-8?B?ZkR0UU8yYkxTVE1YUDNkaGdFbEtTSXp5U3IvZGVSRStnTVkrWDJudHJkOXRv?=
 =?utf-8?B?aTBoeWVDOGxZSFJ2N0RhZXdUNEtCMS9oUDU1TWRNNitpaFBXN2hJU0gzU09D?=
 =?utf-8?B?bVpqOE05K0F0WjNCZ3l2cnJhMW1LVGxpcVB1SWRYbXVBbGkvQzY2bm9UT25a?=
 =?utf-8?B?SWJvc2o3Zk5vSXpNWUE4TmpCWnczVForWkdWN1VPaVA1d2IrQlNYOTRmYXA5?=
 =?utf-8?B?QS9kQzRHM05mOFBzSVlod2JwOTFiTXZocklMZ0QycDY2RHJFMit1Uk81R1F0?=
 =?utf-8?B?alF3SVA4aFFHRGQ2aWxvaDJiNENUTCtnQVdJYUowR2ZtQVYvMzZnSFpETGVq?=
 =?utf-8?B?V3I4TjhHa1djcnRtZW9YcHBQODRKRnk2eHp1V2tWemM3aTB1eU03ZWpacEVy?=
 =?utf-8?B?RUFHdEJFM1hUSk16eHJqOVkzL1hrcXNCVjhBNUtxQVIwb2h4aVcrejVWcm5t?=
 =?utf-8?Q?AztT9whU0RHSY+ob3nzS9GqluCZ3ZSeK0lCC5VD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3N1a1Bxcm81MWxpcWdSclBYeXRmcmxrZzVESnExZTZwTU80cHdCdTg3TE1h?=
 =?utf-8?B?ajRxdllYcDk2S2ZBcktJZnUxdjgrdlk5VE5IbWdoMU1FSDVvVzF2ZTc3ZGd5?=
 =?utf-8?B?MThDUzQrVUlHOXJJaVFWSE1rRWgyWXNiSS9ubzJEbFVMM0VPclJMd29JT0Jq?=
 =?utf-8?B?NThldUhCbEpZa3FxNzh0YzA2cW0ybVZ3Z0d4VHkySHFUV09lQSszR3ZnR3pp?=
 =?utf-8?B?WjlNRlZjY1kvRzZsZHFLalN4SHA4RGpZU2NRelJ6SklsVTJtRi9wSno2cEM2?=
 =?utf-8?B?OFE4U0twL2JQb2JYRmVzakdoa091Sk51eTBHbVZydHlWc2t4NSsyZ0UvcDl1?=
 =?utf-8?B?cWlNa1hoUXFmZUE3ZEJzYlhNbW5JbVRMMmhmejZ2VENLbjR3TGF3NDR1cWk3?=
 =?utf-8?B?OWhRZFVubUF2Kzdhc21sK3hOcS9sZUVvVjVyelQ0QWw3SUdMcDFhQ2FYVm1o?=
 =?utf-8?B?dWE4WlpWUnJuTWdDUStUU0wrL1l2ZHdSdTU2ZHZod0UzYzdnUUhFbTBoL3l2?=
 =?utf-8?B?NGxaUzdlUUxkajdBZUF4TURlS2g0ZHE3azFlTEJuQTFBSkdnQnZBUXdSWTVv?=
 =?utf-8?B?Q3FCWlBDRnhmazdISlNLZzZDNnBRZHNtaHdUOXRRVnRYYi9Ba1ZJc0Rla3l2?=
 =?utf-8?B?dTI1ZHNxcG1HMGo4WTRvZE5iMVQzZkcweW5VWDExNU1uZ2RnVlloY3FqUEJr?=
 =?utf-8?B?aDJXblBMOVBGbkJvUXl1WEttdFBsRU9WN0F4QU9ITTJONldpeEE4VUpEaXpL?=
 =?utf-8?B?YVluMEluZlI3RzRDVmxrcE91SDZpYlVBUXhVMUF1enpaM3BxOHlyNW5La01s?=
 =?utf-8?B?QVFQQjZCUWZWTVdzYzBBaWR4SjJYeXVaSVdpM3k0R3NINnR3MzZBZXJ2UnRr?=
 =?utf-8?B?YXBmMXRzNEsrQVFkbHJXS1dZSzdQQnFnb0Q3TzBlQTlrcEtZZ2V2dlBUeUxl?=
 =?utf-8?B?emM1cTdCS0N5VjR3cE9uUnQyZVQvSzdLTzVrdjZQRnlFUVEyUnorcnhIamVC?=
 =?utf-8?B?bGFLRmQ1dGpBMlhzZEhSN3JweGJtZHlYTXVaSjdkUCtyUGI0Qkp6UkFLUnhV?=
 =?utf-8?B?M2x4NWVvbk5FbHhzMS9WQXlWSXFVTlpYMExESGJhUXg4YnBLL2hSdG5aUU9R?=
 =?utf-8?B?ditlb21vVit1YlRQZHhwTkhQY2E1NGtBYjBGWExjRFBrTHJRT0xFR1FoN3E5?=
 =?utf-8?B?L0dsNzdQbmtVS2xHRGk1OXZOektsTDFFaFF2WUZFTTBzanJmQUJmalBJYUI1?=
 =?utf-8?B?U2I3UkJDRkhsbGRWNTRoR2psYXprWGJuRVErMHpIYlZYWmJxaWdnQTJ0MzRN?=
 =?utf-8?B?SFhWZDlpNDV0RXJhZXFORERxVStRTmlxUDVUKzZPeEZEOGUwUTIxaFcvTXpn?=
 =?utf-8?B?TDVPQmh1Q2VaTklTYkZQRCtWaWx6aFFacHoyVS8xZlhzMzlZVmlwZmtrdFYx?=
 =?utf-8?B?cksrcVFEVmdyWHI4VmJIVTA5MVYxSkhYdjdkeHQ4cklQcFdma2Q2L3JacXZX?=
 =?utf-8?B?SDUvbm04Y2k2SDNoRkxFWVE1V0ZYQmRwZWp4NUdmSEFPems4eDgrekFXbHdS?=
 =?utf-8?B?dHIzRVlObnZhelBwVjVRa1JBWllBMVIzWE1oUXZ6YzFVWmJZSzg2N0RGQjRK?=
 =?utf-8?B?V2d4Y3Y3Q29yZW9jd1NsY1lUYlkvdFliajBtZTRmOWVjV1pyN2lGVExYTjA5?=
 =?utf-8?B?Q1BtUGY4WHBROVZobnJsSEhLQlhkaXFwZnBpdTBIb3E5RHZDZHlQK1RjU2lT?=
 =?utf-8?B?VWtaSll3YjFqL1hUeG1BdkIzYysxMXJoL2V2NitCdWxTSjhSVTQ1VXhnaGlQ?=
 =?utf-8?B?bjM0dXhtaTZQdk9FcWhPUTdQNzYyQi9WdE5UMmRkZDBQSTFUU1ROVW10MXNy?=
 =?utf-8?B?cG5iWExWNUx0QVRXL3l4aUVMRnlXRVp3VXNPMkhFR0VvTExTUWFnWCtSNjBZ?=
 =?utf-8?B?cFdFUlFqdElkUFdMelZENDIzZExGNnM0QzRhSWZ2WllJejBxR05mZ2xsQVdU?=
 =?utf-8?B?QWJPbVZ5cWtJcVpLV3pDdkpYbGdTdWtSQ0w5Q0VIbHJKVHVrYnkrc1lqNGVi?=
 =?utf-8?B?ajRmaXFDWjNURTE2UjNoVjA1RGl0ZjdSSWViRUVpVm84WGZuMzJrbDdDdko0?=
 =?utf-8?Q?v72tWGR+ZZ829zyv2digfl7DE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08239f8c-ae23-43f9-92ca-08dcf299e908
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:03:23.5189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiYSjUfxJXFyJtykzRthZFCX85EVYXjRmq0R8CXmDr2KklQOuMKS5rxVrVQ9cMqvJv7h3g+S27UwHxCmf4PFkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535

On 10/22/2024 07:42, Borislav Petkov wrote:
> On Tue, Oct 15, 2024 at 04:36:34PM -0500, Mario Limonciello wrote:
>> From: Perry Yuan <perry.yuan@amd.com>
>>
>> Add new feature bit that indicates support for workload based
>> heuristic feedback to OS for scheduling decisions.
>> When the bit set, threads are classified during runtime into
>> enumerated classes. The classes represent thread performance/power
>> characteristics that may benefit from special scheduling behaviors.
>>
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/include/asm/cpufeatures.h | 1 +
>>   arch/x86/kernel/cpu/scattered.c    | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index cea1ed82aeb4..3e8e67b8ec7a 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -474,6 +474,7 @@
>>   #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
>>   #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
>>   #define X86_FEATURE_HETERO_CORE_TOPOLOGY	(21*32 + 6) /* Heterogeneous Core Topology */
>> +#define X86_FEATURE_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
> 
> As already discussed: X86_FEATURE_AMD_WORKLOAD_CLASS
> 

Yes; v4 does this.

https://lore.kernel.org/linux-pm/20241021180252.3531-4-mario.limonciello@amd.com/T/#u

