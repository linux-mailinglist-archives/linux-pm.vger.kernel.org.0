Return-Path: <linux-pm+bounces-8052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC048CC510
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 18:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3B6B21E91
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4D93BB48;
	Wed, 22 May 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bEtTwAuP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A8C224E8;
	Wed, 22 May 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396410; cv=fail; b=Qpm05J1BQq+qR4pdXdQrtzhabdZZcqyS/YAYl6zihI6GDdg0HoqNP0gVqwuMoDJXCmL8iTZpG/6gWYYY5c1elX3Z+UH2QuyBg71ueqqxF+NeTFRfvMe2LSBcJXqZZuz5QC9+RSpUTnGuUPuBZzVZ34yh13Tn1p3o0IwPpWfJR28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396410; c=relaxed/simple;
	bh=0JeFAAiPE/K1Yx44TxqohrWnGI/ra4G5bsdGDatUyQ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D3HL14TqjWBEOcuKvHmA7Gh0nDBci4sBeF2u2NgmVmvo879+7NFAb2fiOv5KpXGVj4ZBWTOm4OFrEggE/1hz5eaqrK5ufPxafDzENYwAw/r+/M5udJ8KCtL6QcoJD1sS+sPps2I97rgic7lE2SReFO+tG4RIxSXrMWV2aDs29jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bEtTwAuP; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mw88zR1ujaPiyufctSlJ4jK4b0LlV2UCeugYQtb5ub+UGf56Kq5/kVTU2Otb7wyq4oznhB+vjF2dzmE6SHTavsbDPkXi6EDZ8zduFuwlBXdJ6NbyTn49pZEFeONcCoey0QgsvFf1oVRBzCvhkKhe4Q1z2J4WTB+7hgxoJ536LAoSPMYkse0F+TynQSpi8oCxyFN3rXW00EMBquPAGd8rIQlnAnZbNHIpp4IampA2hmVf7gQ1zD6ZrVLMUGQXHqvDYuuOduHx9lv44Qnu4NIJx1oo9EC0flZeqaKqyEphtCYugAL4qOl0KnXI7L5tc9c18nY+dxMAWIhVrPm7XzMBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/5TRZoH0Eu995ZUzQPFuM+hl7c/vvkF00Ey9p03/+U=;
 b=AyvwnKLHSSvkhLK5Yl686krUMjTYf4ntBMD+KI9Cya3kGuhIP5eOzPYCrR0ovRemIhklL3qzeRVeeOhoNfbJaIB7xqCy1ahfYc1i50JHglIVPmWnRounln3gc7HqrR4Y5hSGgT055excS5DWGtPmXmSRpPCE8iy1fcdCX+7xO6cKSegcDopxaYs5k340JEEg1tUNByMb93rkm2AcLnR1x3Dk7vX2RrjBbCm9pmiTHT5ZPzkFVn/Uf5O1YRgRRjiuISl79gZasBKaiVr+XfUQR0KfyoKpssu2Fpb6DqFdPhoewceoxxlUVWfVWmPKvAMCenp4AUGl+Myj1xQk7Wya9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/5TRZoH0Eu995ZUzQPFuM+hl7c/vvkF00Ey9p03/+U=;
 b=bEtTwAuPRUo/SXVBJmFAExmKWZiMu65/48b6r8qS0StkcMu36/hor6bkcwpB32yxnB/HFFz65svKxWUv/P8PCILYWSs/yJBXHbvPZkpLDfxWV3JAxmgHpTAixCPL7JsRaztZZbb9hi+DfUgdqg8FeABkUAO4c5iPNjZwB9/dTCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 16:46:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 16:46:43 +0000
Message-ID: <7407f7e8-d7e9-42cf-8ab1-b002a88c2436@amd.com>
Date: Wed, 22 May 2024 11:46:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq: amd-pstate: change cpu freq transition delay
 for some models
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 sandipan.das@amd.com, kai.huang@intel.com, perry.yuan@amd.com,
 x86@kernel.org, ray.huang@amd.com, Xiaojian Du <Xiaojian.Du@amd.com>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240429070322.999500-1-Xiaojian.Du@amd.com>
 <20240429070322.999500-2-Xiaojian.Du@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240429070322.999500-2-Xiaojian.Du@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: afad7d92-19de-4fc4-f510-08dc7a7ec2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmdkbGZUTkx5ZlJKdXpOQXRlR20zeFN0cDZZL3M3M3hRRkNNanRTMEtFYlE2?=
 =?utf-8?B?VVI4R01POFV4bVpUUzZQcUxhMDVqRFBmM3kvQitVWmw1NExTbHloV1U2SWh5?=
 =?utf-8?B?eDdGQTcrUzY1UitORGZjZUExenAyZGlFb3lKMUpGQkRiZjBieE5sUmVhQWxn?=
 =?utf-8?B?Tk9SV0NURlhRQ1pXRkE2UUN2eHBnUkxPZDY3T0wzai9oVDg4bmQycVgrMDRV?=
 =?utf-8?B?cEhFQ01HK0plWlFCamhUdDNBVmRPRU9BbWxnK0NCS3pTUGZvTTJRajZ4TjhB?=
 =?utf-8?B?ZC9xNllzMTNISytxbWlRQ0pwNVQ2SFRnMnBzT2tpdnZwQ3RiNWc5NEV6WFBN?=
 =?utf-8?B?NythM0VIcnFnTU9ncnZvdWxyTUZzcnJyN2lvdUVqQXdJZWs5eEJVcHAyTU1E?=
 =?utf-8?B?UnlpSTFiTDVGTk9JMXFDR3EyRWV0MkJ0MWFBQ2JSUnZDV0JWZGpKVCtuMWFj?=
 =?utf-8?B?WjFyVFduZ3VhcEViMTRNWWUvaC9xRTdFSHAweGs2RzRjbGI2MGw5amhrazdO?=
 =?utf-8?B?d3VCclRvVnJrdStqRzdVc05Wdkt4VTVBMk9wSWtEVTVHWTg3bnVZNCtmMStu?=
 =?utf-8?B?ZWxhVDJ4ZkxGOTZmS3VpMEFwVUF1d2NHN2ZHS29EWk83R0VDa0FDdWtrRWRP?=
 =?utf-8?B?enpMTDJidWZjRFpYODY1RmRXVUIrSWtJM1pFbmdZK3h5MHkvMXUxOFRZcS9E?=
 =?utf-8?B?Ly8zYmZvNFV3eEhiN1BRczFVOXdibVJqZ2pBek9nR2lES3p3Z0E1cE1nV0Vl?=
 =?utf-8?B?RzZZaVhIUm5tRCtDWUJGZFp5Y3ArVjcwaHdDbyszN0g4RFMramFxQS9QMW9q?=
 =?utf-8?B?ZVNvYU5Ya21nekJBK29ISVJJVjVCcTdrOTNpRG4xY1dtQlBnMGxZM0hNWlBH?=
 =?utf-8?B?UXhOQ2hZeURGQVdJODRTeWx3WUV3Y1c5a0ZpcDQ2ZGVweXVIR1hYdzhBeW5C?=
 =?utf-8?B?L0IwN0VHSkhwK1RUYVhPM3FuVzI4b2xTbWRtVU0ybjlLb1h4ejhxb0RSY3Rw?=
 =?utf-8?B?bDhSTTZrQlJNSllUNEdHR2crdVpYQitOZy9DNUVBTlR6dit6WGdNY09rZlJp?=
 =?utf-8?B?OWdQMnZIdjdMUjRLWmVhK0xlU01vTlJXMW1EWnR2aDdVVWV4RldlbVMvZVhT?=
 =?utf-8?B?WmZ5ZFJBNGFqNGRsaHhXVW0xRUEvWFdsSUJMYWFXOU9BbGFTZ0syc01qWFpK?=
 =?utf-8?B?SkhDeUc1ZEp0bndYcHRLT29aVkxDNSthN0RPNktYM3RQclV0QkJUS0lWZXcx?=
 =?utf-8?B?Q3NXNUk4R0k3NVMybTZkRUZCcERvSld6YnVpQzNlR2hlb0N1eG5DOEJZZjVX?=
 =?utf-8?B?ODRaNzBNaWpuVUVaOUhzTkZNMVRTZXh3QURHNmZ3aFQzYllXYTE0K1VDNXVT?=
 =?utf-8?B?eEc5cXg4Ty80VklPc04yZ1UxSjdlaUZpQ0RMZTczWEJKaWRhb3JadXcrMktV?=
 =?utf-8?B?WTVtYkNTYjAzUlhySGlUa1I3emlXTnI5aFV0Uy9NeFJhNURSVHYvM2tpR253?=
 =?utf-8?B?NzVFdDZUVlYyTzlmMmltWlVQMXFjdzJLMEhYZ1hIbGlkS3VyRlN1WnRGSFpx?=
 =?utf-8?B?bzRvcGZHaEhXMVJ2bUYvOXp2MWpiN1FCc0ZIdnBBMVNGMTgvazlCUFdtM01y?=
 =?utf-8?B?dGh1MFFoZ1NxQWswSUxEVGR6eklTbzIvR3pDeDd6Qko3RXJnOUtzMW1vZXVx?=
 =?utf-8?B?UFR3d2VyY2hrUG4zbWIraVllcmZxaVM4K0FlVkU2VW4vcWtScEdEdDhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXA5WktaK0NmNXFEOWpYMnJxMWZYcVVxYTN3clJ6WGQwU2VTN0VvVXI3YWtB?=
 =?utf-8?B?VGlDRys1Qm1aRWVHdVI2TWM1cXM2a1ZHRXlvK3o0Tit2T3JtN1hJc3lCVVFP?=
 =?utf-8?B?dXpTZ0pJTS9ITEZvZFMrZjFLYkVGRVRVbml5NXNmdExTVzRlYkVwank5VDZY?=
 =?utf-8?B?VHo3REp4TFBvMXE0UWJ0NnFMVUR2NnJlaWhaSWlNNDlyWjBiQ3ovZTF5Ty9K?=
 =?utf-8?B?L1lxb1c4dFBab1dLUFYvUEZhVWlCTWplaXVqbEtpVjB3UUpvemYxNGh2QjlZ?=
 =?utf-8?B?Wi9uMTRtTW8wMGxQcmxSRkVFR1NacE9wRnE4RmJZMkh3SlRMQ0UzWmJlZ1VE?=
 =?utf-8?B?UXdpNDYxdlZuUTRDTllzTVhJRUdvOE42MWRSOWgzelJiU3IxN09VWEtVdU1Y?=
 =?utf-8?B?WlR2MlVQbDg3dW1WS3hCZ0d6L0FBUVUxL0l2WlF0NG1KMGZyZGs3SzJTZ29B?=
 =?utf-8?B?cDVFR25aSG1SQTBxaWRYVEZvUFNLZHgyMmFxTlp4bU1NY1pMQUlGS3pmUFBm?=
 =?utf-8?B?K0REbW5CK2dzb2tXOEcreFFuVlFlVHdibHFJZk9JdEp1aC9LQ0d5QU9YeTJa?=
 =?utf-8?B?WndjaWxZN0NXZlg2L0xjRW1qYzdDMVR2b1JEc3ppQ1lucVZ0M0FiY0hEKzhu?=
 =?utf-8?B?TXJ2SWxWTzg3MlpHaDg3Rk9VTXBGRWNQYnFreWJuaE44bW8yc2lNdWNtT0hi?=
 =?utf-8?B?L2hHTHJQZDd6a3lnS2MwNFEzOTZ1ai91MzNCU1Azc05XZnRZZS9taGRiT3NE?=
 =?utf-8?B?N2xuZEJpUkhmb1huK21MSVJiVlpPYUY1TDhHNSt0U0h3MkxMNDV3MytjenlB?=
 =?utf-8?B?QjJsRUFxK2lqTHVQZmYxVFNZZ0V2NnJjbVFhK3YxeVYwZlcvUWN0OWwyZXNp?=
 =?utf-8?B?U1RQclpZZitSTjFLK3NDanNoeXJXZmhFZTM0TnB4S0ZRY3FGU29hNGNXU2kw?=
 =?utf-8?B?UlZ2SXRPZFBjNVJNazhKbENLNksxQ09pQnhQc2QwSi9lYnB3QnBUSHE0MFVI?=
 =?utf-8?B?eFVvZ0xhb0p3VThld3Z0dEsra2pKbFBHL3YwWnlNdHBsKzd6Qk9ncUh3eXhG?=
 =?utf-8?B?Sy9HNWxKUEs1aGhaaEJWcjZNV093VElpOFBUNWdHVUIwTktGMlFCRHhSTHVr?=
 =?utf-8?B?L25sQm1JOXdNbzZHdlFVN0xJWjJCeFpwRmZOb1o3OENYTG9Ya1ZQUzc2ZWkv?=
 =?utf-8?B?Y2FPSWRUaW5OaHczTmJDS0dEZGtLSHlSU1lRbktIVGt5TFZVMlN2bEdNclRF?=
 =?utf-8?B?RW56UU1kbUVOSWFPdkt1ek1yclViYTN1bEhsWTk1ck11cm9sTzRyenluR1Ay?=
 =?utf-8?B?eEVmNTBCRzZwS1Vvc1lyUlNKcGswYW11VjMxSFBLUVBNazdBd00yNlErNTVl?=
 =?utf-8?B?Rm5pd2VPUXVCUDN5NkdMWDhwblMwckdHNFdLNEo1M1Y4OXNFVmxoYldlVzJp?=
 =?utf-8?B?b1hyOWRtcS9QVGlqRTlkTmdEZlVJaXJrb0daMXJLeXRrUEViVU1xek9IbHFT?=
 =?utf-8?B?Q2paLzRVWkhvMTI0SDdydVFiOWlwQ1FDN2d2Z04zbDkwODgzUEZHN2xxV1JU?=
 =?utf-8?B?Z3ZIdUdZSS93WVFIWGVzV1JEV25QZi9ZcmdRdjB0dk5UYmFjYWxkcGNZRDJ5?=
 =?utf-8?B?dHlSRTVucklnaTdBbEV5TVNXZmZCek81TWdva0EzcFBVSDdUbTFmQUR6cmhV?=
 =?utf-8?B?a09HUmROZmJpRXZsY09nTkJBTXlEbzZMSzFCbkdxaVVxU2lrc2ZIVEY2M1dm?=
 =?utf-8?B?RjhBczNOeVk4Z2N0YlBlYXllaWxKcEI0ZmF3UndRQUZmY2JPdk5tV1IwY1No?=
 =?utf-8?B?UGxqS0hJdE84eDhqYlhJZkZTTEtpa3NOWTRON3VIOExiKzVQM00rdFh6enZU?=
 =?utf-8?B?MjNkN1RkbGhuOSs1QVpnVVo1OHBkTHQxQ2lybExPbkZWSnhtaC9abW4ra1Vr?=
 =?utf-8?B?WVpXaFhyazdnWWU0TVg0cVY1UjVJR3gzTUhZTmZaRW9RZXJYTG0xa3N2VzNW?=
 =?utf-8?B?aGg0R0YvMThtV2lKbWNWVjhJUEl4aGhpYVlqYWRvcUNEeWtPMDhKRC96MUtz?=
 =?utf-8?B?T2dVSDFZSGVWU3d5dHRnZ3czU0pLblUyTVlUU0FndlN3MkJObmhaV1c3NUpv?=
 =?utf-8?Q?EwjENuAjVgUT+ATFlaIrkuE9F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afad7d92-19de-4fc4-f510-08dc7a7ec2eb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 16:46:43.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nt5JK/duOBmImJjLA43OuW8pi/y1UZUgQZGpOBfDrnxLVYecsk1hXD27eSnVSIS/260dOaWVIWu4v9NeO49uMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428

On 4/29/2024 02:03, Xiaojian Du wrote:
> Some of AMD ZEN4 APU/CPU have support for adjusting the CPU core
> clock more quickly and presicely according to CPU work loading.
> This is advertised by the Fast CPPC x86 feature.
> This change will only be effective in the *passive mode* of
> AMD pstate driver. From the test results of different
> transition delay values, 600us is chosen to make a balance
> between performance and power consumption.
> 
> Some test results on AMD Ryzen 7840HS(Phoenix) APU:
> 
> 1. Tbench
> (Energy less is better, Throughput more is better,
> PPW--Performance per Watt more is better)
> ============= =================== ============== =============== ============== =============== ============== =============== ===============
>   Trans Delay   Tbench              governor:schedutil, 3-iterations average
> ============= =================== ============== =============== ============== =============== ============== =============== ===============
>   1000us        Clients             1              2               4              8              12             16              32
>                 Energy/Joules       2010           2804            8768           17171          16170          15132           15027
>                 Throughput/(MB/s)   114            259             1041           3010           3135           4851            4605
>                 PPW                 0.0567         0.0923          0.1187         0.1752         0.1938         0.3205          0.3064
>   600us         Clients             1              2               4              8              12             16              32
>                 Energy/Joules       2115  (5.22%)  2388  (-14.84%) 10700(22.03%)  16716 (-2.65%) 15939 (-1.43%) 15053 (-0.52%)  15083 (0.37% )
>                 Throughput/(MB/s)   122   (7.02%)  234   (-9.65% ) 1188 (14.12%)  3003  (-0.23%) 3143  (0.26% ) 4842  (-0.19%)  4603  (-0.04%)
>                 PPW                 0.0576(1.59%)  0.0979(6.07%  ) 0.111(-6.49%)  0.1796(2.51% ) 0.1971(1.70% ) 0.3216(0.34% )  0.3051(-0.42%)
> ============= =================== ============== ================ ============= =============== ============== =============== ===============
> 
> 2.Dbench
> (Energy less is better, Throughput more is better,
> PPW--Performance per Watt more is better)
> ============= =================== ============== =============== ============== =============== ============== =============== ===============
>   Trans Delay   Dbench              governor:schedutil, 3-iterations average
> ============= =================== ============== =============== ============== =============== ============== =============== ===============
>   1000us        Clients             1             2               4              8               12             16              32
>                 Energy/Joules       4890          3779            3567           5157            5611           6500            8163
>                 Throughput/(MB/s)   327           167             220            577             775            938             1397
>                 PPW                 0.0668        0.0441          0.0616         0.1118          0.1381         0.1443          0.1711
>   600us         Clients             1             2               4              8               12             16              32
>                 Energy/Joules       4915  (0.51%) 4912  (29.98%)  3506  (-1.71%) 4907  (-4.85% ) 5011 (-10.69%) 5672  (-12.74%) 8141  (-0.27%)
>                 Throughput/(MB/s)   348   (6.42%) 284   (70.06%)  220   (0.00% ) 518   (-10.23%) 712  (-8.13% ) 854   (-8.96% ) 1475  (5.58% )
>                 PPW                 0.0708(5.99%) 0.0578(31.07%)  0.0627(1.79% ) 0.1055(-5.64% ) 0.142(2.82%  ) 0.1505(4.30%  ) 0.1811(5.84% )
> ============= =================== ============== =============== ============== =============== ============== =============== ===============
> 
> 3.Hackbench(less time is better)
> ============= =========================== ==========================
>    hackbench     governor:schedutil
> ============= =========================== ==========================
>    Trans Delay   Process Mode Ave time(s)  Thread Mode Ave time(s)
>    1000us        14.484                      14.484
>    600us         14.418(-0.46%)              15.41(+6.39%)
> ============= =========================== ==========================
> 
> 4.Perf_sched_bench(less time is better)
> ============= =================== ============== ============== ============== =============== =============== =============
>   Trans Delay  perf_sched_bench    governor:schedutil
> ============= =================== ============== ============== ============== =============== =============== =============
>    1000us        Groups             1             2              4              8               12              24
>                  AveTime(s)        1.64          2.851          5.878          11.636          16.093          26.395
>    600us         Groups             1             2              4              8               12              24
>                  AveTime(s)        1.69(3.05%)   2.845(-0.21%)  5.843(-0.60%)  11.576(-0.52%)  16.092(-0.01%)  26.32(-0.28%)
> ============= ================== ============== ============== ============== =============== =============== ==============
> 
> 5.Sysbench(higher is better)
> ============= ================== ============== ================= ============== ================ =============== =================
>    Sysbench    governor:schedutil
> ============= ================== ============== ================= ============== ================ =============== =================
>    1000us      Thread             1               2                4              8                12               24
>                Ave events         6020.98         12273.39         24119.82       46171.57         47074.37         47831.72
>    600us       Thread             1               2                4              8                12               24
>                Ave events         6154.82(2.22%)  12271.63(-0.01%) 24392.5(1.13%) 46117.64(-0.12%) 46852.19(-0.47%) 47678.92(-0.32%)
> ============= ================== ============== ================= ============== ================ =============== =================
> 
> In conclusion, a shorter transition delay
> of cpu clock will make a quite positive effect to improve PPW on Dbench test,
> in the meanwhile , keep stable performance on Tbench,
> Hackbench, Perf_sched_bench and Sysbench.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Rafael,

You can swap my R-b for an A-b for when you pick this up after merge window.

Thx!

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2015c9fcc3c9..8c8594f67af6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -50,6 +50,7 @@
>   
>   #define AMD_PSTATE_TRANSITION_LATENCY	20000
>   #define AMD_PSTATE_TRANSITION_DELAY	1000
> +#define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY	600
>   #define AMD_PSTATE_PREFCORE_THRESHOLD	166
>   
>   /*
> @@ -868,7 +869,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	}
>   
>   	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
> -	policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_FAST_CPPC))
> +		policy->transition_delay_us = AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
> +	else
> +		policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
>   
>   	policy->min = min_freq;
>   	policy->max = max_freq;


