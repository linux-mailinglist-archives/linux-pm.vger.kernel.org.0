Return-Path: <linux-pm+bounces-11022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5554092F46A
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 05:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AC51F21FC4
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 03:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB866EAFA;
	Fri, 12 Jul 2024 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fe+SO6KS"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2953A8BE5;
	Fri, 12 Jul 2024 03:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720755064; cv=fail; b=LxuIPnwUyKHtZVzYfWthw0eAcdHVC4g4E7y+/nkgKcmOgSnenp+OqugqlG75p7btj3OJfURBhpmp8JgjUFmruFJOQEaIxdUWb6/8y+MZRVsUJEPYlvxXrYz+ncB2X4RgHvwXdJiK0cudAst4E9C+JqHbVARjFNUNf7iJ4qWf/HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720755064; c=relaxed/simple;
	bh=RHt63JxDVqN1nUt+pYSHIjJjtayywuRVg+RcwUNk7QU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pjCLplAosXH54nUFEy1GZNWyWzO55H1Vo0H+yVr0Dmjdj0cOBRSuWfEtDhAO3oeI4txu69yu3Jq/VMwa9kMAgEBI6y6e1MnUDs0NxfDCKYPqHzQBrCp3NEUo1t25xhVBYWjehGebYtH0IqHWlVx06nqh/7UMfYx28CccDn+KZmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fe+SO6KS; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLfT7Zrsuebj01JyyrXcl+ovOUWSqhX7o0XxwN2Z9Hs1OTysZFYV6lWC7v+M2ll+e7W2UhZjIUduq+p7f3J+rUTV3QJxeJxyiaOeG3BoBZ+CMYf7IopYF4L8krhUDDi3p1e6CONu04R9hAiHf3I919ApUEjnrzmoVpRhYyVvEPJj/pHbzB2m4hjV/4/MP8C/HE4I1wJy2wgIU+56TKteMpeTtkLyREibcms0kLC86/pfyGauaB2QODHTLDQe5h1jOOvaJgA2PPV5z3F0wVcKVss1XGfRYeDi/9M1XgLXu9hYS7lw94s+KksfKtR1mX/0RcI0BidYUyNy1dx2YOF+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSgFffbLBj43OyCA6q3/TYYwz5vCG3huL+M8gVeTOHM=;
 b=lc3csemNGH5UwCz+Qjq6o3WBS8coSXPZBa4TKANoBPvqnKAKj7nMMxazx/K4fTAmwDcclg+foNHNTjsUJtNO5Ba/ooSksnuzSn+qIjrrTl2MdrIEY8uAvEC45d93D1dBwiM/vNnnflOSTmf8FcLMKwPIo+L/rx7hl/rd3DDB7Ok3gUu7BnKcPInjLWFbeHPltS/2oMKMl8vrSuLZxdWp7m+u8R32KMGQJjbRq+JBicSWr++DdbW49boJJig4CUchse586LoM3QPe0j9aGh20kjz1QGPB/d/gOOXKeANPOfl5mBnse1ODZoaGo5iwdEiZ8qNMiEEIg+PmXvTNwr3Aag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSgFffbLBj43OyCA6q3/TYYwz5vCG3huL+M8gVeTOHM=;
 b=fe+SO6KS2T26Hoo3I0keMwB+4xI9izdZ4s3vSjK8jQ/aBRNZAgdctIDXrdXpPeNzhQgqdOTW9iiHwJLqkFVMbuTfBCsSxrsphjxlaMdnvrVJ2eqsGq0/bL4+BqdyvzK/tBrO7otv9q4LMP14KsTy3FFrGk/EhQjICZ3xjh6q8lQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 03:31:00 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 03:31:00 +0000
Message-ID: <96c20328-6227-4076-b6f3-98e05319c729@amd.com>
Date: Fri, 12 Jul 2024 09:00:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/11] perf/x86/rapl: Move cpumask variable to
 rapl_pmus struct
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "irogers@google.com" <irogers@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de"
 <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
 "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>
Cc: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
 <20240711102436.4432-6-Dhananjay.Ugwekar@amd.com>
 <3cd5daf2424205564be29d9d23644b693eb9f355.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <3cd5daf2424205564be29d9d23644b693eb9f355.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: dab2d5f3-c550-45c9-2be6-08dca2230cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVlJck1nUUhnSVp6TUtvVGE2Q1FQWTFNMjY2bjlYNXIraXNBOWZqb2hpbHdD?=
 =?utf-8?B?M1dxMUNkTlBXNmdqVU5BT2pjMnFzaXJFOERuQmhyR2FXTXNtanpSNVdlMXM0?=
 =?utf-8?B?MEFaYVp6UFdvbDZ2QlZncXRiRTVyQWRmY1NnTVl1V2hZWm5rUTgrMklYVm5r?=
 =?utf-8?B?N2VScEJxbkNYa1BpSERxMkI3NFhMVVZNZ0xTcHVlUDR4Q0RuUGZuOEJTWmdX?=
 =?utf-8?B?RzJ2ZzdXRkhGbjk2NXhpRkVyeGUwR0V6VkNSRHFRRnRRbXFyRU1nM3hrTldN?=
 =?utf-8?B?SEpUbXV0eDdVMDVMbW1xdEpwUGtDNVI4d0FZWkJjYVh3T2JJWjNBSkdQUHhI?=
 =?utf-8?B?REZZemEvU0JNcWtmQlQwTjlDdDQ5enRMS3J2aS81bS9QclhWVFVKSFliWUJk?=
 =?utf-8?B?NjYzQi81WkswSW1uOHkwbm95Wm9NQXF2YnNucjlUOThTclFXTHhsd3FsR2Iz?=
 =?utf-8?B?SDRNZk54dU84RG14RU5Pc0lpVXUyUGxLV1pYWmpvZk1LcS9hS1NPNW8zU1Qv?=
 =?utf-8?B?YUh2ODZoZkhxZ1FqYTBxOGFid2JsUHpubnpwSkx0K3hCNXhmYVZXQjdiRjUy?=
 =?utf-8?B?cmYybWxZZjJtTlNub252TnpkbjdFN3JDZmgyUjdISURlMFg2MElUd0F1cVla?=
 =?utf-8?B?UEpVRGhjZWNUZmpGYmVyWEZBaG9iTXBRK3kra0JtaFU5R0kyUUs5YzRySFFn?=
 =?utf-8?B?b0tQWFdvS3NKbWZIbVUrVnJmZytEcEx5T0dlV3g0ZFFlZkdCZCtmK2NKSmVQ?=
 =?utf-8?B?b2duaUtvV25WdmtlRDRSdXlzOS92anBMLzgrZG5IelVHRERkV0s3Sk4vd001?=
 =?utf-8?B?Z1krWFBSTFRWcDNRVm9CdllnaWZEU21tdUtPckZDTEFkRnNxbW1vRE1jcHdO?=
 =?utf-8?B?UzRGdnBZVFp4QmQ4dVE3VjVFdWZHYk8xZE1aQU0yc1lITXhva1Qyb0RmOER5?=
 =?utf-8?B?THcvUm9CRkN0Nm8weEhSaG1OMThIcHF4bC9jaTFhU25qWGlnRXlhRXBoamNW?=
 =?utf-8?B?dWpyZ3d6WU00TndKNVUxNm1nQmlMZFhpOXZDeGhWdFA0QU4yK0h3dlVvOURy?=
 =?utf-8?B?M2xGZjRpUWZWNXVFUTJBclhpWGt1QkFpdFh5NmZFWXFVeHZYcGQvU0diK3lQ?=
 =?utf-8?B?RGdrWjN5WllGeG9MWHhUanVwajEvRFRIT1hwbE03RzdSZHhsanRmeG1wWW00?=
 =?utf-8?B?dVY2M2dEYlNmelVlTlB3UW9rcVZCYndOd2FGMzVQUTdxa0ZvOGxuSGwzQmt2?=
 =?utf-8?B?OEhhZXlRZUo4S1p5VThyKzRLdlNNRmlaWlNKTzNlaXJidVZRV1dubkVCbFdP?=
 =?utf-8?B?azNXNzRMNldFaW1Bd0JIMTBMYnJhTmU2MTB2MjhyM1ByTnVLdldtbVdMQ1Jl?=
 =?utf-8?B?SXhHVXJzUUdqdklBenA3dEdGQ2VtRFNWbzQySzhzdC93ZjVmOFQ5VFJiamc2?=
 =?utf-8?B?R20yeVFJeWRIb1M1cHAyR1haODFCWHBleUlKMWVjbzJQUEJ2dTJDN1BiWnND?=
 =?utf-8?B?SVNJUDRLaUxmVUU0akg4TnhFem45cEpWOWZQMDhUR1RaNDhtVktvd3c4azR1?=
 =?utf-8?B?Wk0zb2dSeVAzVzVSSXBSRnNrMEUxTlk4S21xWEU3bmdwc0dDZW1SbXgvNkxV?=
 =?utf-8?B?ZFVPK0xoNTV5MTNiNk5IUXFmbkZtWUVyOHFYUE1FRHNGeW5TZDduamZZcytl?=
 =?utf-8?B?TXVsaXlzejlIN056OXZCSFgrdmlpK2YvME52b2MzZVNtZEZnRFJHSXY4ZFhn?=
 =?utf-8?B?ZC81NFpnb2M0eTVOZHo1NVhGaU1LRU1ybFVod0Ewc0IxdUdiUW1DLy8xb2w0?=
 =?utf-8?B?bW5mT0pWdVpMcHRndUU3UkRFYm9INXh4cmxTNU14Y3QzNjFCZWdicGY0SmNl?=
 =?utf-8?Q?FFupKyn3dQQRH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVRvckZPTkx0VUxrZTFMck5icDY1UUswWWtDeTU3M2daOG1HU3hkNHgrTnpj?=
 =?utf-8?B?YXFnL2lYbWtZMlBlV2k4Vm9zNGxxemJLcGJkei9HUGNiZ1B2NzY4OTZoYVA4?=
 =?utf-8?B?YVZXakFnOTFuZFhDQjNWTmxjWWJraXZmVEJaMW1xZWFXZmdsVWlxMW1EeDIz?=
 =?utf-8?B?eHUzeVoyaWRqcjFSZUo5QlFmeWlQbUR2RFFHOStPZnEzUGpzL0cvRE5tYW9a?=
 =?utf-8?B?N21HMTBrbGU0UDJCTkoreEFBTktmMHhMVzNMRWhsckM3anhkc25VUzMwc1NW?=
 =?utf-8?B?VHB2YkNZQlA3dGtMSDQvTGRuVFRPUUFwTEpqdXN3RUFPWHQwYXRJZzNGcm5N?=
 =?utf-8?B?dHUvbERIczlUNDhNR0ZWR2d6VWl0TytHais1Q3J5aU5OTGNxSTRDUnZSdFR3?=
 =?utf-8?B?anR5WVd6bnlVakUvWHc3eFVZd0l6QVh6eHYrTCsvWkNDVlo3VklMTklLU1Fr?=
 =?utf-8?B?Ly91T2VoTmNiTHBxbFAzaTVaZVFtWFI4YVhCNHZmMUV4UUZVVWRndE9NenR4?=
 =?utf-8?B?aVVDQnZxZTloL3lJYkdiMWFSNWJnWWluRkF3VW5lZldhdStrQ1ZhY0dtcmxl?=
 =?utf-8?B?U3luSnFTWWlnZ0VHcmlsT3plS1d5cHR6SDBJSm9qUWtac2QxRHNDS3lUM3JL?=
 =?utf-8?B?ZGYyTzRSaG9mRU9yL3ZpaThRZWVEbFgrYWNuMjdUZ3d6bnYxMXgrcmkwWHpW?=
 =?utf-8?B?ODRzaE9mTS96NWxxMGtaVGtxTFlQMHQwdVV1Y1Jzd2xOc2xzUmMzNlVVRGZp?=
 =?utf-8?B?SEZQM2pyWndGc2RaSW9SaXlmc2RtVER3RnVWb2VTaU5rZFZQcm9EVlJUYWh2?=
 =?utf-8?B?bzhWNzBVY0lBNzlOelFodDZxYlpyL0U1TlR3Z01MTlBpNkl5bURvZ28xZ25X?=
 =?utf-8?B?RFBIdisrdEpTbkRHSlUyUDVzZWhHWHdBQm8yaGEyR1BYWENvYTVLZndpTCs0?=
 =?utf-8?B?ZldORUJEOGdvT3JZb29adUhYYlZCSEMzbHNqUGwwUEo0S2Z0WWxORU9WTm81?=
 =?utf-8?B?Um1TT0lZTkx4ZC80YW9IcHVaZVFFMDg3cXhVWUwwNE8waFkxdXlZN1JEeXhM?=
 =?utf-8?B?Z3VvSzZSSEl4TklhdFV3MlNObWF1eEpNQkVSVGhOTWxGdm90TzVoMHBXSm1K?=
 =?utf-8?B?Vy9rNE5nVjFqVWRxRVdhRy9oYW1iMEFjTjJocHltM0dLb1dVanVyVmJ4a0lX?=
 =?utf-8?B?bHMxZjVBclZKUjl2TjJuK2ZEU09wdWZXVjNPNlRWZUhZWHFneHFSOEFyZXlv?=
 =?utf-8?B?clkySCtlU2hndzZ0Wmk1T2lrck1RL3F4M1o0c3plN0tGRGFHaXFCR2J3eURJ?=
 =?utf-8?B?UU9PSzdQL0hrUnQ2RkFUS29MdlhSWlk5Qmo3b2EvTjN0WXhHeUgya2NNL0kw?=
 =?utf-8?B?aEVOTWpvMmFVUHFDZUF0YXVBWnpTbnFGRGdJMEVnQVlDaHc3UVhWZHdJUmZF?=
 =?utf-8?B?QkZOQXdGK2NaMktGTitwWnRvallqVEswelRkejFLemtaa0dJNkdkaFA5SVFQ?=
 =?utf-8?B?MzUzS09OakJpUk9ibWFONWFTWVY1VnBya0hzWmpmK3JBeWRvSzgxQnB1Qkh4?=
 =?utf-8?B?YUFRUDVFS0NWZTJIZW53S1FlSTlRVWVtdHpPYzNhdFdGOUxWeHhoUnkwUXkz?=
 =?utf-8?B?enZJdWYrdVhUYWJwWWNzQUgvV2NUL3FXR1hXMGtsL0VvbkxrYVRHUGVVSk5T?=
 =?utf-8?B?Z0JXZE5TSHk5WmZzaGpVVWFZZnc3TnZTQVRyNUNHY3kwKy9MVjFmckdKVXhS?=
 =?utf-8?B?K1hDQ3pHc3JUZGJFajd4Z04xZ3dCYmdBRk9DNWlxajJBbkRlMndnYmZEYUsx?=
 =?utf-8?B?dUlWYmFaS1Fzc2R4eS96NTN6VDRQallFUDlHTnh0SWFodjlnQkVEbnNkV0xB?=
 =?utf-8?B?ZkROcGYzRlFFZ3FOOVVHY0lsOHJlc0wwQ25PbnYrYmtGcDVKRlVTVkF5b0pB?=
 =?utf-8?B?QVpwS2JteTN0RVUxek16MmlSandxbXcrN1d0Q2JtMGRrWjNuYW1NSlhpT2oy?=
 =?utf-8?B?NzBDUjcyYWZWQTkzZE5NS1MwOExvZUhzaHZ5TjRnWko3VTdWS2tWUHVKN3lL?=
 =?utf-8?B?OFh2eVp5RTNTSTRETytIeTFGVkFTLzZTWTltK01Xdy9PZVZzOUQ4MC9McTZZ?=
 =?utf-8?Q?gT7UKaPu9VR4a4kIXASW26opx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab2d5f3-c550-45c9-2be6-08dca2230cc9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 03:31:00.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EyJcLZ0OBNLLKqkxB43Ioy/rjWEc2bZo4KcWzypg4eNDWD4G2iB2cKF62ZkXkvdfjU5NP/ys5eZhqP3GVsuiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088



On 7/12/2024 8:37 AM, Zhang, Rui wrote:
>> @@ -710,6 +710,9 @@ static int __init init_rapl_pmus(void)
>>         rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu,
>> nr_rapl_pmu), GFP_KERNEL);
>>         if (!rapl_pmus)
>>                 return -ENOMEM;
>> +
>> +       if (!alloc_cpumask_var(&rapl_pmus->cpumask, GFP_KERNEL))
>> +               return -ENOMEM;
> 
> missing free_cpumask_var() in cleanup_rapl_pmus()?

Good catch, I had it in one draft of the patch, but then it got 
missed in the final one.

Will fix this

Thanks,
Dhananjay

> 
> thanks,
> rui
> 
> 

