Return-Path: <linux-pm+bounces-9189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20658908B51
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 14:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484001C223FD
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 12:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE839195FE6;
	Fri, 14 Jun 2024 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="D+afaoxL"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2021.outbound.protection.outlook.com [40.92.98.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1EE13BAC8;
	Fri, 14 Jun 2024 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367190; cv=fail; b=MlmqRlzaqRKs9iTa2nPfkkgyGR483vy0NElbtQN8mLodgD+TUkfbxPIQ7UbfiSVhajQ3gXxz+CNkH4qrM0MlthbCYCjzyZ2SSH0ikMnhmXSR9K4iqmnhNs9YwLULTEByBRI4OH/nDx/96Ar+F9dV/IVXw4KYJfewelwkKLIAYQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367190; c=relaxed/simple;
	bh=s/S1AbkEw5boYCzD9+3wJAwCeZYMR7x6bMfZUI98uDw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QzyQ2GnhN4SUwYdqmPZlqhM4mvt5ciDzyd7+Z4acyyuQuK9GxMGGmgDSr5ru9eyirxZDgTC451ZBYR63/Mp4RDc46TTwtk/wdI1Z3jGmUyhsn7mTXBJtXhZDadkZBO5WxKded4zF1sVRtoS1ZJg8guWQPH31jmm43MhQ+MaK45o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=D+afaoxL; arc=fail smtp.client-ip=40.92.98.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThXS030NkDBrxYNdNhhyvm4q1FuE3XTY1g3+SFaCIrnefcrDa5G8YV0XxUYnRjMQnHP7U56uxIRIyRbdLPtpehRTQqrgfL4XHRDTEXkwlGuadFIh4uU4ss2o7q5HvNoW5HJZTQilRBgwLulHUzY86RE6zEyUVwDUEN/sk4//OjQhnXd99nK75R2vAVb24x2EjqV3ikl8smPZyiF6So+eREPve8RGvLUdRShNjrTphYn7EoY3V+ets5Ckle3K89Vk/SNOQV1YzDNCDf7oeC2m+QCZUjTc7//cwO3fyrauQuHsccDykAWyNGK/ZObvUZdf5QBqX9SMuTQevUshDB7PZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HhuG+tchywiRPvCCRkbnT5Vf2kZltnT51pUeBaaKdE=;
 b=MOoYekuKPxD3tI2da/J7PfUWQCxBSh/AA5lRWa/FdgsKgVmtcYtq6R9qwLiDOrWN3nVDLXmTgTFAagGtssAa/B9rkfkIOu2pndzHZPuALlapWTN/Rg19wHVEvA/TcI3iuwyJEZCwpPcS6PxFNzOzS1AoA6OJKcxKmeavS4AJn+LI9GBehHmxlHjPntWvN3jQqKlk7rBU1rxcTKxWb9wFm/VPDUA5dyQgyncjuAtx5CU3kYVqX2b7JP5fDgg/59bmklrOAeE0IbMpugHUkPHwYJ0+XZ6HwUg+Vv3d7CzhW8Gznqvw0CvHSmcmBXZmGe1yQxhlQaoK413VvXOcbP09/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HhuG+tchywiRPvCCRkbnT5Vf2kZltnT51pUeBaaKdE=;
 b=D+afaoxLAgvSHszQQMhCBfsVZ24Lcfzm3Ol6SwPlaweWVvhT3HqlEmtbUvHrnLtqWr0+hDgaG80/T+4GQYO22WwQv3jNTqeIRlGXu6fgcSYXR3cSAVOYHbDK/0V7RrQ+2VieCY7+4bx1ikNyllQPg5dfK8beDrYrKAj1ETxWhvByce1L8nLTJNQyBdDCoAT0MvvWXdUYgtuYdmcjtkgTKjGotMNKiztDZ+vGKvDe6Vt9Xw2bKZ3UFVjL+EItqM/pAcamYcE2aaOZ2sNVZ99B5ADAjvyD5u3n8+6GVpn8x+VrOm+QHh7wIHgr1xsZAzmsSJ2rsTUlFWfQqUV448vTyw==
Received: from OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f1::11)
 by TYWP286MB3382.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 12:13:06 +0000
Received: from OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1167:655a:7fa5:5cef]) by OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1167:655a:7fa5:5cef%4]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 12:13:06 +0000
Message-ID:
 <OS3P286MB2490D85DD16331E5942BCEC4B1C22@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
Date: Fri, 14 Jun 2024 20:12:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq/cppc: Remove the desired_perf compare when set
 target
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>, beata.michalska@arm.com,
 rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 hotran@apm.com, Riwen Lu <luriwen@kylinos.cn>
References: <20240530061621.36byo5a2iqc6o2az@vireshk-i7>
 <OS3P286MB249076187B3497D1EDD70988B1F32@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
 <20240606090737.z3qenphikjs5ijj4@vireshk-i7> <ZmgQ06jtJBPh5wat@arm.com>
 <20240611091049.lrypvvluntf37uff@vireshk-i7>
 <OS3P286MB249073C57E2B5A36F45A02E0B1C02@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
 <20240612062404.yjfduze4bvgyts6a@vireshk-i7>
Content-Language: en-US
From: Riwen Lu <luriwen@hotmail.com>
In-Reply-To: <20240612062404.yjfduze4bvgyts6a@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [HWTlcsSL2YB/qAPF+HbqkmnwByVLGVpm]
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f1::11)
X-Microsoft-Original-Message-ID:
 <c49ab142-0526-4b7b-a2ab-39ab3aa727c8@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB2490:EE_|TYWP286MB3382:EE_
X-MS-Office365-Filtering-Correlation-Id: ed427f30-4eb9-49c0-1f11-08dc8c6b58bd
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|3412199022|440099025;
X-Microsoft-Antispam-Message-Info:
	xU/zco++OmyUXubIYZn4JGW4fF6wvhq5k3SOm5YGy4INymZd+dyVoI6mRI81URiMw+wOFDM0rgkQEJ56pJci4s5ymkc01C6rP3MNzK983fv16Avm0sUe3NhWqqmCg8vxdPKvggZgclbvEZ4zOWxZh6QnzPFawgw2hy2FIGtU0JF0iVKFFzFz3IjV59XSqG98qIa2lkiGcSAVVDnOXEmF+qtfkz6YiKFtWynIH4lFm7aOLHoC99dezVBVyuLO4a6vy8UvnU5S4IwnLvlP1t0F4PJAwFiH8WGF2IL/mLnCGUw5Ar7CHeFTq6e+Pw8BUc1Amy2uzuXO8pXccAf77ZvaQL5a+5OCIiACEv2aWfDn5M4ZMZEBI7srnwt0H56yLwjkMixk/EjD0150E1oLXpWhkvqmcO01AkQOrGjE8pDrJ78C6u4baU/aTJFa37LldfgCQ1XaTHQ1seMlLaeZFQLmdPgowHqSp4F2aCpcYhcW2DcneBlFLRWpNPHD375mwaBXGPx5I4pEUlKKwrOd6yQYguCGE3LM+10kSlRbWmcI1WE5W2NCwz6BIfg+dBgo3wWh
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0FqWHZ6RTcrV00xR00vNkh4TTkxTm5QYnhZSWdnaWtvMEJQK1hRNnNPQUxC?=
 =?utf-8?B?cUxWd3J0RnM4cURxV2VSaGlYRjI3am1UWU9OclZVdG54SkhnMVN5ZG1IS1Ur?=
 =?utf-8?B?NjJVMVZHY3I4UlorU1B3SjBDMFN0L3RTclVGSWN4RXpKdk5XQVB5R3RmRVkw?=
 =?utf-8?B?WXJxcTM1eWJvZ0djUm5ubms1N0FNR2tiS1JoK0hCV2crVHdNYjkvQmdUWTJ5?=
 =?utf-8?B?bW1GaGpVQTJnYlp4QTNGOUwyQmF4VXBBdkh1TjJEMUQ4bUtHZ2hLT2xxa1Av?=
 =?utf-8?B?VEJwdEdHN3F2SS9SVTRwaGo3WWliQjdRVGRQRVlmSWlacCtQYklud2J1YVpk?=
 =?utf-8?B?d3hOKzZ2ajFGVUVKcDV2YThxL09QanV2cy9KV2VzMEtZeENBcFpreDVRRmNp?=
 =?utf-8?B?OUkxSUVCVjlEdUxJa21FNUtFRnlaSi93ZlFjRFhCN21Sd3F4ZzFmeTJCSEtz?=
 =?utf-8?B?U0x6ZlltVE0xNnBJVVJtOExFdXBSSkRsTm1ZSFc5enZ1cnF0VzUvd3NuU3p0?=
 =?utf-8?B?ZTEyTTFrMkdJQVQ3UFNYcnZTK0RJT2xlbFdPMU1MZFU4amlGb1A0MVlqbkQ1?=
 =?utf-8?B?a3dVQjdKYnVzMThwemt2NjNLV2pGcmYzZ0hCM1RDTFNFQnFNSTJnUXJORUlX?=
 =?utf-8?B?UzFhNTBlZXdEc0s3RUovQ2tlZXNuc1Nvb0hvVkZJNm9EbkxZZUZpQkVhdzh0?=
 =?utf-8?B?S3A2OTFUMFB2dFVxdnltWXVjVUhYOVZlOXNjYzV4M09OQ0VmdzBGbHhiZFNZ?=
 =?utf-8?B?eDdscU9KV3FwQnkzMEd2c0hiR0NRWDRwSlhHZDRKL3ozNlB2UDRnL0pYK0xm?=
 =?utf-8?B?MllCbjJCdGxMWDNKdnRNbVZmVlc3VGk0NXRma1RkL0wzN3hwL1VZSU9SNEtE?=
 =?utf-8?B?UFZnSGQ5b08wSm0zbTRJaTFhKzU2NGpMSDc3Z1RGeS9WbDZQaVhESXoyY0xI?=
 =?utf-8?B?a2pBU0Rta0NBTUlIQkFScnh3d0YyWUdWTFVUbTZHdGlGYzJySmZvMTdzQmI2?=
 =?utf-8?B?cUpHYVlsbUpYaFVMSTM5dlNlSUVCNzBWVllkU0Y5aWtORXpGVjNFeDB5QVFF?=
 =?utf-8?B?R2RwU2lRRkNWeXlHS2RQU3RsbUcvNHgxMmFtcnlhRjBENENPOXVVeHlFaFU2?=
 =?utf-8?B?ZXlIRThTa2lXRFhnbW1WQ0xiWjJMejQ2NVd0NWhxd3VCcUhTaG01RmlqY3Va?=
 =?utf-8?B?WmpsWmE2QnozVitWUjNDcFJYNWx5Z2t4K3lSNThOZ0Z1NWtHQnU0R1pSaEJr?=
 =?utf-8?B?eXZwaTA5eWlxUERTbndSSE9QY1ZXTnVmZXBsRGVMTXQrZUlxcXp1dERzbVpx?=
 =?utf-8?B?czdUaCtrREtYYUlSdW9MR29DdlF2WDlrOC9oY1RDOGJTK285ZWx3eEc2aTAx?=
 =?utf-8?B?NmNpUGFJMFlFcHhuSDVycld2ZFRudG9WQTE3YmUwT2MrRnUrc2ZwNHhUQ2dR?=
 =?utf-8?B?Si9kL3E2RjEzRGd2dTR1amZzQjdYaE9LSVpwYXorZGZzVnFyUnRlMXRiYVdy?=
 =?utf-8?B?amE0L1NQZEo1SVBVeDlMcDVrNkI4SWtBVFBDMktaSnhHL1l4SS9sM2drc1dR?=
 =?utf-8?B?VFVKZ2NHYURqdWNZQmpuOGszc1ZNQmFZcExIR2MxWHpJVU5LWnl4ZHkxYldE?=
 =?utf-8?Q?D6n/CAIDX7RbnwMdoMHm5JTbWV9UKXPdjvomrmtF4CHI=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ed427f30-4eb9-49c0-1f11-08dc8c6b58bd
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 12:13:06.0332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3382

在 2024/6/12 14:24, Viresh Kumar 写道:
> On 12-06-24, 10:52, Riwen Lu wrote:
>> I think it's no need to remove the "desired_perf" local variable here, the
>> code is seems more readable.
> 
> There is no need of a temporary variable and I don't think it increases
> readability at all. Moreover, same needs to be done in
> cppc_cpufreq_fast_switch() too.
> 
OK. I'll push a patch that remove the desired_perf temporary in 
cppc_cpufreq_fast_switch().

