Return-Path: <linux-pm+bounces-21771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A28DA302AA
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 06:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B88188AA77
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 05:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B154F2F852;
	Tue, 11 Feb 2025 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wke++C/M"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F78726BDA8;
	Tue, 11 Feb 2025 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739250163; cv=fail; b=j/5I64/Ryyl7ZtYOKnxG3DVC1JKMMk1da4XN/aOHahmxjGNLnBiFSRoi6/LQhNtizMak50X1TpPSQY9SaKt5Q2kKt4MS9XjZDRZW6seza3JkFF8R7Zxwb+2s1OWy8CHDq25TOmE0IgR1wgYd3rofNOEVDFA4Aqc+FDm08wCIxNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739250163; c=relaxed/simple;
	bh=1i2OClVK42YsGebIbBQfBXjzwchijh5+c4n1aqGNDGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BdhVGlVu3NH7EyxZspHK6GatvMCpZSRo3kaKHsddWLOJd6AQBL0BfeqDji/p6gaabE13JszCe97uV3yltWfts439xEnFvFERx+mNZN2RhQN/GSPpyzF51MiFRxt9fyuMmynRBLaCXMpNieCeNxjHqBLSRAAsBrWzkbleN39SNlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wke++C/M; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ac725Sp3577TR9hJk6SN24KuUlJkqY9m/t+OFTt6X7m3koFI5igG793uLiJUjyKRjmPHgvTXo+ZmBPgwZmXe/YlTInvzgIws3kmiQLY7mLy/4izIFs1KRrJrkxDyjErD/hcHCURpGT72t9VcPlHM+IOn1oD6yDEkeV2QE2S38E8KwbjCtDB3CFyzji8hX6V/bD35tA2Sc2XF5Ula6+Ua7v3u+uwKjwrVFJU08lirJNQ0Z7fNuYS9aYTxIf84tj+gENpxghv1NsdRCZGNV3zTen341Za+tLW8ASRVTqrqprOzhsO/vPuTrdaGgLIUk+QohDYTYdkYBu+okYkMBOZjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wK2D70bCWHSujCReTW3cpqW6C/+815p0LxdQ0nfJW04=;
 b=RaYw59YPoC76+i/BMHJjXh/aqSJPtwKG0/hvBhTY4a43S+rDOyy1dwRPXVnCmhP3vH2oFITELhwl3EARuXNClQ6csyebEcVdkCw5B2jpMj8LdJ7BEtF4XLqxIPpYV1bLPKe3wUK5B5zOYYeUS0dU2tZL5zBKhj3BosMW75QMy4vqq9gb6KS98sHCllhVDQDAkm0HdXM0OiZJlDfDces4b9Sd9GBX1c59OsUMHMrCM0DGPeckRYprpsO7qOimwWGKWe8mDbpZ4+L6lvelAfUVkkcbKwgjTXjJMQaQ2qgHKcNX3qptiU9bBCGtD40ELJ+LmGYYpeWsqMNR7tI10LJhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK2D70bCWHSujCReTW3cpqW6C/+815p0LxdQ0nfJW04=;
 b=wke++C/M02QjxnICPzra7Q6IUzRkqH8D1IBWgVRpGqg41Imn6YZuB8lh+ub6rYU2N6Uf9p62BKQFOmI/pOWzvmiRc4WtScZtimOohFYixGLNbHCunsoeyiEhQixNCue9g/qaCkiZ58vM21w2kk59s5YW4puxmIgC+3qFpyvtZ0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 05:02:39 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 05:02:39 +0000
Message-ID: <adccc912-bf93-4320-8011-21c0220c839a@amd.com>
Date: Tue, 11 Feb 2025 10:32:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] cpufreq/amd-pstate: Overhaul locking
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-5-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250206215659.3350066-5-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::9) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7cdfdd-6e41-4869-4047-08dd4a594eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmR0N01Obll2cHlJc1YzaElkTWV4ZTkrVm00RjNFRXlqRXNNbkRseTZidkpT?=
 =?utf-8?B?bi9ONmpzNnlCNXNRZ3pSZlZtaTFKSmxrRHozRGQ3eW9UWGhFbnBSaHBGQ0lW?=
 =?utf-8?B?MXMvczY4d3BiamZkZ1lNTmdoU0ZqZUpqS1o1S1RmbEYxclpaVURwZTg4TENN?=
 =?utf-8?B?dEdFaEZPQnpseUlPYXc1ZU9HdGNNT1FXVG9udW1mM2JEeGlHdWJsUVFaYkVs?=
 =?utf-8?B?M1lDdzNnQm9MMXpxUUk2NE42NVlmZXRvSGZpS3dFUmFTWG5oVngvVGtYTnVl?=
 =?utf-8?B?UEdiTjFHZGtvR2krZW5oSCtxQ1ZmYjkyYjlWUFc2M2t1ak9udEhveU5Ja1g1?=
 =?utf-8?B?R0hBd0ZxOEY2cVhtSzhoOGpvS3g1ZlRXVjhtYWFzRTcwKzloR3dORGJLUU4r?=
 =?utf-8?B?ZS80NEQ5NVBuSDN5UzA3SnpXZlJYblByVnNWL0JkdmpQWmJUS1hLT3Z1N2JN?=
 =?utf-8?B?ckoyaXhUWGhDQ2lmUHVCa2JCak1qZUY1QjNZNnRHSEdCQ1NEMW05R01EZk55?=
 =?utf-8?B?WlM2TkNoUzFaQUQxTmJPMVF2UTZ3YjNmNlNLVWFqMWJxT2pHRmdFYmMvejg2?=
 =?utf-8?B?aG83RTJHUG1IVkI2bEZsUm1aUmk1OXNHcExYYVdNblo5Z0JBaEVNU2ZQbnRw?=
 =?utf-8?B?RUhuSHNTc1RKRjk2cDZNN0F4bTBkcXAyUE5XTTF1bEprRXdnYnZ6SmZUdkRU?=
 =?utf-8?B?ak5hMnp1N0wyRXRQM2JJSGxBeVd1dVd5ZmpMeUlvSWRiZFJnYXc2clJ6NU9Z?=
 =?utf-8?B?MCtCMVkvbStDS25VRW04OEhRT0toNDgxQWU0SkNUSWdBVS8wWlVOeU5MMGpT?=
 =?utf-8?B?R3pUZ0lQWU1ra3RvbDdUemNQNG5aSXk1WUM1N01YM281UVVSa0hhMEFZbDZk?=
 =?utf-8?B?WVZJWkZWMkdkNnVCN0wxanFXZlRnV0U1aUxGMUtwajRsaVlNKzNFUXBoSXpY?=
 =?utf-8?B?cTVEUDNtcmlHQlA3TC84dWlRcUVYdmJTNURITGR4MmgyYyt5M1Bqbmt2N0Ir?=
 =?utf-8?B?eDNoYkxtNXEySnVoQUVueUhQcGl4eTE0SHZGNUZyckJPdDZORk53NitES3k0?=
 =?utf-8?B?WjEzVWNQRmNZR0RzYTNrWE5GcVZuNU50WVh0dlJQSDFOQVpqSVNWdVF0VzNo?=
 =?utf-8?B?R1ZkemRydUx1ZGU2K1JsV2JYSllzTktsYVJwaU4zaUozT3lReW5ja0IwRDJR?=
 =?utf-8?B?Yng5MzhDaUdLTmRXc0pYZDh1ejVkc0F2UVB2TnM0ZHBLYnNyWTVteGlJWmNr?=
 =?utf-8?B?a09CZm1tcDFJT1JXakV2U1pvaHNhZWRHRXU4REY0WXpsQmxia216NjkwM2VS?=
 =?utf-8?B?WjBGTGNNMTRLd0JrbHhMV2dtd256anFhUWk2NEFkY0NFdWhwd0JmelZ6MjY0?=
 =?utf-8?B?M3dGU0JzTFhYTmhvcURFUloyNGdmL244SDJ5Mno0MUZ2SFplTmIvOGxyZ25C?=
 =?utf-8?B?MnVJakM2eE42RlpOZlAyMUlkVkhyVzZYd3BiVm00ckFnenNZQXBCWFg4WDkw?=
 =?utf-8?B?K0pxQWpNaGc5YzNsUk1URUpsSmZvVkZHbWUzcEh5YTZsOE01TGQ4WnRWYTVn?=
 =?utf-8?B?U2JrVENsb2ZSMjFsSnJET25tbnVXYTQ0cUNBNGlCaWhzK1lEWEhHamwydVBy?=
 =?utf-8?B?M29ycTZMbmpZcU1WTUNQVkEzbkc2V29pSnl1YXBoMTN3RGk2ck14VkMrWmRS?=
 =?utf-8?B?OS82cDJvd3VaQlh6U3VKYWtkOEorZHIvUWFqZ1NwL1huSEdsN2toZXpSLzls?=
 =?utf-8?B?U0ljVXF3OHJMYXNTeElRV0R5eFJiTXduR093b0dLL2NtWlRjdEFsbGhCS2Z2?=
 =?utf-8?B?TXNYMDUyaWh1VUlkSno1Tk15R0UzTHpJTkhDajBLOG1lTGJVSVVFcXFXNFFZ?=
 =?utf-8?Q?pRLx+1h83o62T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXF6aUJJWlExb3p5d1Z0SDZoTXlJZmxzMk1vUVltZEpqcVMrdnVEVjI5a0x4?=
 =?utf-8?B?TTViazNwU1hYcXEvcGZaRzNFWFlhT3BwOEVnOTRTL29WanNaelNORThITDMr?=
 =?utf-8?B?d2d2NUxmMHpCQmttN1VjMVJyYzJScnh5MHpVTklFM1FMMFZyeWxNSTd6czJz?=
 =?utf-8?B?WFNQMnI3bzhUWFRDYzgrbGs0VWJNQ0h6VWZnbll6bG1QdzhpbTZCVXhyalZ1?=
 =?utf-8?B?QSt6bzBvUnZ6ZzVib2E5eGpuNU8xYXd6ZnBDU09qUm5QRG52S1F5MThNazdo?=
 =?utf-8?B?VHpud2F6cUpLSzAzV3hVenFrU256dW95YnhsZmRVeS9WamlYZXRrb2o1U1BF?=
 =?utf-8?B?ZE9qOW1TS3hWRG1Semo3SHliK3I0S2xXN1U3REpOaHBkZkVlZUs4K3VxbGdx?=
 =?utf-8?B?aHUrRnIzb3djMC9WM0NiaUphL1JjenRIZkZXUFI1aEZnbTdHL1owblBMeElO?=
 =?utf-8?B?eUl3N0lYVks0Z0FpR3VkcjBZcWV0NVdqdjFYYllXbDU4V0VtZUxSbWFOVHhm?=
 =?utf-8?B?SmtJSXpjUjNtcitQMm9jQm9LTHFhNHMzNENMbmRlT0pud2VUVEVJMTdkYWRN?=
 =?utf-8?B?L3I5eDloYnE2cWd6TzJCTktCdHVGZVg5OEp0U3E4VFVTZUhVTkMwOGNkYklE?=
 =?utf-8?B?YjRPbTFHV0oxOEU3QTJLUkI0K0cwVy9GNFFTRnZOOFdkd0owUTg4VHpZNFh0?=
 =?utf-8?B?c2RPSFMrejd3ZWQvTjZ3eStISmxBMWRLZCt4dnVLcFh0UzNsRVJUck9nYjRQ?=
 =?utf-8?B?dGZ2eTB1RVFhckhFNVgySjkzN05GOXRBMFlueFg2RlhxdDBiOGZ1SnhidnFl?=
 =?utf-8?B?NnlLSDZ6NXUrMFN3aSttbkZ1UFJRTmRjVDMvd0d4TmhYM1BUVS9WbktabG1U?=
 =?utf-8?B?N0laLytBM0NnNHkwRHhTU2VIZVZQblRnd1VSYm0rYWZ2SEE3dTZ1TURIblpD?=
 =?utf-8?B?WnIzSi82OUpxeFh0SzAxOUc0TWlkM2dETHpGZHh1d1JlaHNuNSsySlh6UEx1?=
 =?utf-8?B?RGFuZGdnTXJPeDRjbXl0aXJSUldGVm14VmRoK281QUpsb0tjMWg5YmFyWjli?=
 =?utf-8?B?eDM0Y2dZVVFNMHFzRlV6VUt0Z1pDb1hBdFBZQkpxeDlkSEpQREUyUDhjUWsr?=
 =?utf-8?B?UjZnK0NLV2JMMEs1Vzg5ZU1La3FOcWgrOVJsNUpKZzB6a0lrN0h5Ui9BNnM2?=
 =?utf-8?B?OTlVNXFYV0R2UllNczBZUWw1MXdvckNsRFh1aDZJL1pDM3J1NllzK2sxTDVy?=
 =?utf-8?B?TVd4TFV3UXVHVVNPT1pOUHp6bHNyZmt5OXVMMUg1dkFDaFRnQXJwUExzMkR0?=
 =?utf-8?B?MnFBR2pSTHk0LzQ1dXFJaG5UenUyRzZIWHpybHFlUG5XempxdVo1VkVqQVZJ?=
 =?utf-8?B?ay9CVlVDNnhKc1lwNXV2djdSSUI5S3R2OWZ3WUhyWS9rVG5XY2M0Sk9vUmFF?=
 =?utf-8?B?RS9uVHcwMFRWVzE4Y1RqY3Zrd1RkMzVjRTNFeU55eHNKcW9WUlVVQUJkWVJy?=
 =?utf-8?B?aHM2VHh4T1I3eklBMFV0S2J0SUdwZ1FXUDA4b1FMdXVsVjc5MTVvSkpWL09G?=
 =?utf-8?B?a1hHQ2NCa2VTdDVrMHJzSitOVUczUGtCMUJPWk55YjdycEVxUWhIeVhQZDZt?=
 =?utf-8?B?TEZzU3V0dTFjRnNiOEJKUnBPT3NjSW56d0xJTmtNWHl2Smw4endjeXloSUI1?=
 =?utf-8?B?Vm90U3R0Y09zb0NVUnkwUFRPeDNkNEM3NENCNTNvQVhUL2JhZHEwQUZuNk9F?=
 =?utf-8?B?WE9NSUNvV25VRHhqQk9iWWlKMjdmeHJhdnlUdTl0c0QwUTZDQ3pDY2hBWk1H?=
 =?utf-8?B?S0JWQkd3KzFzc0xhcWFXYW5IVTB0amJMdCtiaGJtbjhJbUxsR0xXSHVaSjA1?=
 =?utf-8?B?WUV3Ykd6elR0MGI5M1RvQnp3VjIyMFpubTRxRlhjblhzVlNlb3FyY0cxNTVj?=
 =?utf-8?B?VC9mbytCTHJRSXpWUXpQaC9ielhTZThseFRnTWNvc1pyMys3RWNCUkVOUU1u?=
 =?utf-8?B?bDlJWWl4WC96c0JNYSt5RldqMTFxOWlLOUNtc2FHUE1mTjFYWmNhbXhGSExs?=
 =?utf-8?B?cEJTcjdEblBQNElVNVgvYVhmam5Yd05zM3VQU0QrLysxTUk1SUYxcThZNkJo?=
 =?utf-8?Q?nqcpVVm5Vxg6PUNk6ZH9yDkJ3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7cdfdd-6e41-4869-4047-08dd4a594eaf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 05:02:39.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPgbUr6dZp6xFMHLTKgXc/iatGKvwfDX8PtwUZ5RToYKJvxU1huTBPdw9mtdx4bG7TwgnLD8GenJnpoDtOK3Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890

On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> amd_pstate_cpu_boost_update() and refresh_frequency_limits() both
> update the policy state and have nothing to do with the amd-pstate
> driver itself.
> 
> A global "limits" lock doesn't make sense because each CPU can have
> policies changed independently.  Instead introduce locks into to the
> cpudata structure and lock each CPU independently.
> 
> The remaining "global" driver lock is used to ensure that only one
> entity can change driver modes at a given time.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 27 +++++++++++++++++----------
>  drivers/cpufreq/amd-pstate.h |  2 ++
>  2 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 77bc6418731ee..dd230ed3b9579 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -196,7 +196,6 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>  	return -EINVAL;
>  }
>  
> -static DEFINE_MUTEX(amd_pstate_limits_lock);
>  static DEFINE_MUTEX(amd_pstate_driver_lock);
>  
>  static u8 msr_get_epp(struct amd_cpudata *cpudata)
> @@ -283,6 +282,8 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
>  	u64 value, prev;
>  	int ret;
>  
> +	lockdep_assert_held(&cpudata->lock);

After making the perf_cached variable writes atomic, do we still need a cpudata->lock ?

Regards,
Dhananjay

> +
>  	value = prev = READ_ONCE(cpudata->cppc_req_cached);
>  	value &= ~AMD_CPPC_EPP_PERF_MASK;
>  	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
> @@ -315,6 +316,8 @@ static int shmem_set_epp(struct amd_cpudata *cpudata, u8 epp)
>  	int ret;
>  	struct cppc_perf_ctrls perf_ctrls;
>  
> +	lockdep_assert_held(&cpudata->lock);
> +
>  	if (epp == cpudata->epp_cached)
>  		return 0;
>  
> @@ -335,6 +338,8 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	u8 epp;
>  
> +	guard(mutex)(&cpudata->lock);
> +
>  	if (!pref_index)
>  		epp = cpudata->epp_default;
>  	else
> @@ -750,7 +755,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  		pr_err("Boost mode is not supported by this processor or SBIOS\n");
>  		return -EOPNOTSUPP;
>  	}
> -	guard(mutex)(&amd_pstate_driver_lock);
>  
>  	ret = amd_pstate_cpu_boost_update(policy, state);
>  	refresh_frequency_limits(policy);
> @@ -973,6 +977,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	cpudata->cpu = policy->cpu;
>  
> +	mutex_init(&cpudata->lock);
> +	guard(mutex)(&cpudata->lock);
> +
>  	ret = amd_pstate_init_perf(cpudata);
>  	if (ret)
>  		goto free_cpudata1;
> @@ -1179,8 +1186,6 @@ static ssize_t store_energy_performance_preference(
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	guard(mutex)(&amd_pstate_limits_lock);
> -
>  	ret = amd_pstate_set_energy_pref_index(policy, ret);
>  
>  	return ret ? ret : count;
> @@ -1353,8 +1358,10 @@ int amd_pstate_update_status(const char *buf, size_t size)
>  	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
>  		return -EINVAL;
>  
> -	if (mode_state_machine[cppc_state][mode_idx])
> +	if (mode_state_machine[cppc_state][mode_idx]) {
> +		guard(mutex)(&amd_pstate_driver_lock);
>  		return mode_state_machine[cppc_state][mode_idx](mode_idx);
> +	}
>  
>  	return 0;
>  }
> @@ -1375,7 +1382,6 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>  	char *p = memchr(buf, '\n', count);
>  	int ret;
>  
> -	guard(mutex)(&amd_pstate_driver_lock);
>  	ret = amd_pstate_update_status(buf, p ? p - buf : count);
>  
>  	return ret < 0 ? ret : count;
> @@ -1472,6 +1478,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  
>  	cpudata->cpu = policy->cpu;
>  
> +	mutex_init(&cpudata->lock);
> +	guard(mutex)(&cpudata->lock);
> +
>  	ret = amd_pstate_init_perf(cpudata);
>  	if (ret)
>  		goto free_cpudata1;
> @@ -1558,6 +1567,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  	union perf_cached perf;
>  	u8 epp;
>  
> +	guard(mutex)(&cpudata->lock);
> +
>  	amd_pstate_update_min_max_limit(policy);
>  
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> @@ -1646,8 +1657,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  	if (cpudata->suspended)
>  		return 0;
>  
> -	guard(mutex)(&amd_pstate_limits_lock);
> -
>  	if (trace_amd_pstate_epp_perf_enabled()) {
>  		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
>  					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
> @@ -1684,8 +1693,6 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	if (cpudata->suspended) {
> -		guard(mutex)(&amd_pstate_limits_lock);
> -
>  		/* enable amd pstate from suspend state*/
>  		amd_pstate_epp_reenable(policy);
>  
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index a140704b97430..6d776c3e5712a 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -96,6 +96,8 @@ struct amd_cpudata {
>  	bool	boost_supported;
>  	bool	hw_prefcore;
>  
> +	struct mutex	lock;
> +
>  	/* EPP feature related attributes*/
>  	u8	epp_cached;
>  	u32	policy;


