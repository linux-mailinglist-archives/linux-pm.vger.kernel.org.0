Return-Path: <linux-pm+bounces-22858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB4BA4331F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 03:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0A77A4F64
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 02:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208AF14A627;
	Tue, 25 Feb 2025 02:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dPnGt6vE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575B1494DD;
	Tue, 25 Feb 2025 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450928; cv=fail; b=Et+ydsX61X58NM/pGVMcUTUxj8DdmSZWhn4k36pK97zJOpBKMipO0HHMcx2RHkfhYE0CUwiNu67mSBRJbC2ZO2Bfl0C3GCmf7aTAwc2IaHd6dAPLSN7gBJjJs/PDauqWnSBDX2XjoO5HGuoavPQ9IslSbVBaqanAgAXZAoQwzCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450928; c=relaxed/simple;
	bh=3KWKEcBZDcGFLv8mnpHaQjbRce5vtIZj5f4P5Oy+oI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cJIcoSUEn08W3OoRkPRPDOoPTvEbTgalDGieFuYCNsnNN6oBYCoGRRmNukcHcAkf4aQBy7vR6RMsIe5RFFWEu07ETH+xvKBST9U1DD11618OvBzpszAsm2arcoaq52/lw8qu6p07cpVdDmW43m9Gvew19Mbyotn3V03OiH1+BzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dPnGt6vE; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hi1XSwjN6f1Y+z6OPoxsL/jlq5XbXe18emyorlX1ct9vXoeVnCRuvc6+H3vyouL7bbvwzkfDiXuJ2CwmeIAUWF6hD/yw2e+aAZQhWj1iVATxLIHQGKzXjXanBTB2gFdSMnjdn31EL+nMwSD/87do41Db25atCmSR0C8AklGin+utn5X6GDAoS6te+i/PO3/+meIYycsKWldFNbEkSNeb/l82+ZUeIkEtp44wUe7HY/MdHp17uJY7feaNS3VBEH7GYYHiDFwmjnC1+gjkWwsf38mL3vSf+dtoT58rj+/Cex/6fmJslKfOZOQfALcyDCBYhn+wl+Vskf5rAu+LpuMA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86+8xrDY88TFzmSni65Fetb67TrOG5njyI7W2+8ZRME=;
 b=ETH+NPzxHAjVJOrIAVwXW7v40nSjs7QfB+p9S2odOvTUO2DagimbpsmNVE3RaF8v96PflTKHrT7CMGrI9OFMNPpT8xSI+JeVeg4xrsBdnQdO8qtInOmL1cnqBO6qnUFZRvxvem/jlTAwLWJi8WhJzR8HsNHM3X61q/SuqFNOJeUQ0dhFG6Kv0d46bw3g/95XFtzKVUM02GNGhEOgifHZosaqglPrx6GRC09U9z0ON3qTBkwijyNcntLxx1CyfDoLa+l0X/UQnNYDck0AUJeYWEh818F8XC1rYCfT2tmICqYsM+j2JXWanl9jNoZn46Mozxib35/6MF2oQvaLTwoV+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86+8xrDY88TFzmSni65Fetb67TrOG5njyI7W2+8ZRME=;
 b=dPnGt6vEsqxvjSPqce09mTwUCd5xuQnXAZMRMguTpddA7CfhKPAiyyEjPq1DweXSzK3Ua0oyXzHcSksItprnsDorqH0vD5hIB80QWjksK+lbSYkdiG4XLZ+hpfHDKt1QN9vh2Ho/HEgwdMZWUjHVFfV2YM73q6dWxq5K/NAgdwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 02:35:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 02:35:20 +0000
Message-ID: <6feda9d4-aa51-4903-8d6e-9444ad423fd2@amd.com>
Date: Mon, 24 Feb 2025 18:09:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix the clamping of perf values
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, rafael@kernel.org, perry.yuan@amd.com
References: <20250222033221.554976-1-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250222033221.554976-1-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: c28999dd-e021-4f18-1be0-08dd55450c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dy9YM1VEd0pqSjNocWJtUnk2c0t1dkpNY20xeDIxYmI5aGYyY2hRWkdVc1FY?=
 =?utf-8?B?MEcwazN5Ti8rNWFWR013bGNNNEhXa3pDRVhyejFnVjQxUlpMT2p0N1pSaWFl?=
 =?utf-8?B?YmNaOWxpelcvTFQvclU1QmVubzg5ckdsU3FZR0gzYzVVZnlMQml6WW5WdVV1?=
 =?utf-8?B?TjlEUGFsWU02dm55RklJZWU2czlrajVVVDRKVDZOMWNJblNKWVVnMzBkdUtm?=
 =?utf-8?B?Q2hGcDNONlVpTk5ta293VnJzVkJvbnIzTnVoTkJIT04yVVczUDBEb0IwVVVF?=
 =?utf-8?B?RFVDTjg3NjVIQWkvVW1wTnhqMFI3dlAvL3U3RXBaZTYvczFONVM2K3RPajVu?=
 =?utf-8?B?MEZSNG1KQUE1ek5VaUtueXdqMFJZRkE5OEpUK1pFN0RyRnprWUhvWEhJU2py?=
 =?utf-8?B?WGgxanJZbEphTWRCU1BRV0xXRGhWUUFIOGRqWVNNcnlHWjFQYXFFRVZJY3Er?=
 =?utf-8?B?MEZWZmRJV2NKSjMxSURTVkZXaWZlNEtQc3R3K2t5WFZwYjJoOXRpbVJpbGdt?=
 =?utf-8?B?VmF4aTNXRkFQeGpDV3BUalV5TEVwSWVUL0tDc2hPaHJZaU5rZW5hZVptUzdZ?=
 =?utf-8?B?bTVkN3Q4ZGQ4ZHRuZC8zZUdITmJaanQ5a0ovSVdrclV6ZmVwZFZoc0JTM2hQ?=
 =?utf-8?B?RE9jbm5WZCtlVDR6cm5CUDlMcjBRYWc3dGpJMk9yN0NYaFpKTGR2aGJDdlFo?=
 =?utf-8?B?MW1WZHNVVGNoK09Fc3ZIMG9oY0FxUW4yb3JPWmRqUFJWZWZYQ3ZtbG1mOWhM?=
 =?utf-8?B?ZG5iNFJ4TjFDM2RaRTBmZnhWRVdZQWU0cThpVUQ5UzIzZStaRFBTM1E2QlJL?=
 =?utf-8?B?ajlTb3NqRGY5SmRRUXJoNFF1d1lRbWlPL1lkNEFUZDZydk1VVkVLcXRUK0M0?=
 =?utf-8?B?SnI3c295S0tYOUhoVXhCaFdqQmNDVS9qM0RibkY5MDZHcUF2cDZBNE1VSFFz?=
 =?utf-8?B?OFgvdzNpL3ZsN09JTW9rbDJraXhEV2pZVXFHcFZmNkdwQmVtY29Ud1YyeEp5?=
 =?utf-8?B?Nkh1UzdMeWt6U2wvWDB4RXp4L0x5TXVJcXJlbUpOdXhQdytOaHRTWk9zanpn?=
 =?utf-8?B?S1YrRE13MjlwaHlUbi9GZmFVZm1VQXpqL3dSRlY2YU80b3FiNVRHam1KU1ph?=
 =?utf-8?B?KzR2dWpLQU5RSkJBMkl0NUhVTkVxY2d6QVpxQ052dEFCQ0FyeXBUYXpXbkMw?=
 =?utf-8?B?OVZVLzB4dERUWkRiWXVOMEtxdVMyVFdJRXZ1TXRXQWFQNk9UNll4aDl0dTB6?=
 =?utf-8?B?RHZPV0F1NTdHcmg0UXVUNE9VWS9kYTIzQVUzZ1Qyb2psU2pPcU5Bb1htQmdW?=
 =?utf-8?B?VkRNWlhRQkZKV2RyY25Jb2xIU2p2OWZFWmo1NjZXejJhVnlWV0FNSkhZQ29w?=
 =?utf-8?B?RjF1SUlYdkNYaTFBZ01PbWdxYWxHS1loZi9PclRxbEFzbzVQcllXZVJZdEEw?=
 =?utf-8?B?eHVpbldoOGFQSloyK0FaK3R1VGlGN2pxZE5sVHZrYWlMYy90NHJKakFnaXV0?=
 =?utf-8?B?SjRkWlE4UTgxc3pLVlFIM3FWc2FvOUQva1ZRZmVpSEZkV29GUzhLelhabXlq?=
 =?utf-8?B?SzRqYjNDeUtyT0hjTFB0YmdGT0ZSVmROb2hXb3JtZHVXVmp0bkZYZDRkWnFa?=
 =?utf-8?B?cVErYVE1aXRLakJFNEdPZXdpSDJjdXlJQm1JSTFnWlZ4a2sxVkFLcHpWWnQ3?=
 =?utf-8?B?bkZLc2hCUnRWdzVnL0NpR2Z1dWRaaFQ0bDFIWFZIbGtRWU1iamFIUjZUdU9O?=
 =?utf-8?B?OHlIa2dqSERyUTQwZ0JUNUoyRlU0TSt3K2NSQmg1L2xTREZ2TlJpWkpJMGNW?=
 =?utf-8?B?cnJYYnF1dWhyVkU5SXIvOUQ0eSs0SVFXTXpYNlBUdnFQcDFZUXEzNnF1MHJE?=
 =?utf-8?Q?pHkqpKp44JX+f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUcxWlVkeTVlRXhvSFNUOWxCd0FjZkk2SlRhbUJTSjY2dnVvdTZzblU0dWwy?=
 =?utf-8?B?L0tOdGw3K2orWXNuTzBRZE1td3ViRm1DSTlnbTFPN2E2MTM2TDJzY2hjbWw0?=
 =?utf-8?B?UFVjSElpRVNGSnpJN25HVVdwT28xOEhVM2RNK3NyOS94clJTeUF1WWZremJh?=
 =?utf-8?B?OVdvL1ZDbDFuRjVINkRpTVFSRWpzeTdxVkZVeG8xMWNDTEhrUzFiT1JIT1Yz?=
 =?utf-8?B?ODBvbWF4WG1ZK2ZBNDVXTnhta0NJY1FFeXZQWCtwRnhtT0poaWFKL2lXWGxO?=
 =?utf-8?B?QTBLdGZoK1VVN3g0LzNrbFljWlNkRG8yR2pFdUl5c1FMYXUxTWlJTVRaN2hs?=
 =?utf-8?B?ZEhzTVROYUpoc1lDcDZaTnkvQ0ljeHQ4TG1Xc1d6Y09nOGpLNU1na2tVRmk0?=
 =?utf-8?B?eDFuV3BERTZ6Q1M5NnFWYmZLcm5xMXUrcCtqZFEyMC8wbDRPYytxbnRMOHZD?=
 =?utf-8?B?U2lKRGZBNXMxbjErU1VVbFFIUHNzWDg1R3hucXJMVktlQmJKQWhVc1ZSTHRE?=
 =?utf-8?B?anJtMW4wMHlYdzlGT2xYMGlUSkJWRE9Vay9iSHFyWmkyY0h5M3N5Z2RsL01z?=
 =?utf-8?B?bUhmUUFacGR5ZTk0QkkyTEplRnVjaVJYUWFPNk52YUNjWTI1UlFTRmtqb1hx?=
 =?utf-8?B?SitrQ2g5R0V4a0F1V2xsb0d5RERlYno4cEV5SkRuMmtibStqRlRvTU1NK2pQ?=
 =?utf-8?B?bEc2OHdwUVh6T3ZSQit6L0ZobU5XVWNtdEJyU09PUy9zSFl6Z0hJNFVFNVlD?=
 =?utf-8?B?K0F4TUl1aGd4NUpER3NXZlhoaVRvOSttdTZ0OEV2VXNERE9MS28zSTgxNkFo?=
 =?utf-8?B?Q2o5RDJiWnhrVm13QU10Z2FZMUhudDIyME1UNGwwMmVMSGovcXZwZUtYQTNs?=
 =?utf-8?B?VFJvUmg4YmVNS0xIN21ON2hrWDR3SGw4VVYwa2JZTnpzYlNxL1d2bUY4TE5D?=
 =?utf-8?B?SzBKY05OdW8vTVVmMHl3dHZwS3FjMkVBSWcwQ05FMHRMTnlYNXpzcHRhRXVI?=
 =?utf-8?B?ZnQ4Umg2a21TMWk4eDkwb3ZwN1U4Sk5GMUxOaVJraFBKdHhoTkJ1ZXA2RGNk?=
 =?utf-8?B?d25ETUs0WWxLcXA5eFl5SGdMcnA4U0dIU2tQa0F5SjdJanUvOEQ0cVppRll2?=
 =?utf-8?B?Nzl3NmNXY0lzRlRKcnZ0MXA0Qk5DLzRKZ2N4bklqQW9ud293MVUxMlN6eHkw?=
 =?utf-8?B?anA4VlNsbldkelNPcXVXeEJ0QktIdmw5NWRscGlTSnhDeGlNVjBhSVZRYTFL?=
 =?utf-8?B?Y0JxVUg0N3h4c2dnS2FMeUtmUkwyM2hNVXNtTTNSVGNjRFRHWjllalhRVXhN?=
 =?utf-8?B?NGxFTVJEUjViSHJpTExoKzVUc2hxa1paQ0RYSkszZm5qS0RSTkpDYmlpcEt1?=
 =?utf-8?B?NTlDRUl2dFA2VkJnU3RyRWx5b1BReDVkSis0MkZRcW5PU3YzdGQ1V1lqYml5?=
 =?utf-8?B?cG5SU3U2bFR3c0V6WjViTGdlMXNCcFRlV3QrR0NKTDUxdFF2SVJ6ZkdwVUEw?=
 =?utf-8?B?cnVjanRmQXo3ZlJTTjV1ZjJpd25Pc2psUHovOE5rVWgzdXY0d1ZrSDdvL0dZ?=
 =?utf-8?B?U0FmekNrRFFpUUxPZWhKUWZIRmQ5U1RaTlNaTGx2blhnVGMxVmFkbG9XbWxi?=
 =?utf-8?B?Y2FMZ2dxNGJ3QUFlWUU2UnpVYTNvdG40Ny9JaUVFd0FuTnh2Q0RYS0M0eU8z?=
 =?utf-8?B?dy9CMTIxRHR2NjVNUmZYaC9RM3hVeTN4NWErZFViQUduRlUxZXRBOXVyaStD?=
 =?utf-8?B?TmsvdC9oUVBJdjJJaHhhTCsvakJOcEJ4aUFZcHhobjFTYmFqc0hZRE1PR01S?=
 =?utf-8?B?bnhDTW9KUHJVOFZ3dXgrclRwVEdTVk9SS0Y5SUo3RjZjbzl0ZDQ2UkYrR2dL?=
 =?utf-8?B?bjczdjFZYVYyYkJRN3lXWktGL1NQK1kxTGNWRGMzUU9PczNzc25ta3RQT3Q5?=
 =?utf-8?B?bkdBOW8zRkNNZ0R3RFp2ZUZEaVFwS1V4bFVCU1FtQyttZVJmcXo1SGp0a0xu?=
 =?utf-8?B?OEh6L2JmaVJ5YWNDU1oyalE0NGxVMTJ1K2ZTZlk2WmZJWWpRbDJlUmxtVkYx?=
 =?utf-8?B?R05VZWxMeE5FWEphWUovWU1qTGE4ZlVhUFppMXBnNm56RlpiakN3ajNRTjBs?=
 =?utf-8?Q?+T9pK0bwk0NQRSwduajpvBjQ4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28999dd-e021-4f18-1be0-08dd55450c26
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 02:35:20.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NI2TWNAQGWDi68KI3rnypo6LGncr9+V+158Vw7sIpcnsOmvAphRmkfCxXuFgR/HOJhIqqBX3liSAdNv6Q8icZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804

On 2/21/2025 21:32, Dhananjay Ugwekar wrote:
> The clamping in freq_to_perf() is broken right now, as we first typecast
> (read wraparound) the overflowing value into a u8 and then clamp it down.
> So, use a u32 to store the >255 value in certain edge cases and then clamp
> it down into a u8.
> 
> Also, use a "explicit typecast + clamp" instead of just a "clamp_t" as the
> latter typecasts first and then clamps between the limits, which defeats
> our purpose.
> 
> Fixes: 305621eb6a8b ("cpufreq/amd-pstate: Modularize perf<->freq conversion")
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll rebase my series on this for v5.

> ---
>   drivers/cpufreq/amd-pstate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9ab95ec1f828..4705a644db6d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -144,10 +144,10 @@ static struct quirk_entry quirk_amd_7k62 = {
>   
>   static inline u8 freq_to_perf(struct amd_cpudata *cpudata, unsigned int freq_val)
>   {
> -	u8 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * cpudata->nominal_perf,
> +	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * cpudata->nominal_perf,
>   					cpudata->nominal_freq);
>   
> -	return clamp_t(u8, perf_val, cpudata->lowest_perf, cpudata->highest_perf);
> +	return (u8)clamp(perf_val, cpudata->lowest_perf, cpudata->highest_perf);
>   }
>   
>   static inline u32 perf_to_freq(struct amd_cpudata *cpudata, u8 perf_val)


