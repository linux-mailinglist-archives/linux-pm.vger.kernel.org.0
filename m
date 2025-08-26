Return-Path: <linux-pm+bounces-33062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 421B1B351AE
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 04:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273D01B60968
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 02:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3808635B;
	Tue, 26 Aug 2025 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KwAz3Sm8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD48220694;
	Tue, 26 Aug 2025 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756175415; cv=fail; b=UV0HM+XgPUsi4/8cx+1LW8mAw3TQb0Zxs454xU3rEPJisUL/kdkapqF6oiE8m3ChYT3nixB5g+eMf+jOQtqOWLyw3nOl5PzdZnQOxU3VqcacOyJiA0Hu+pIMQa2xgMB+ZJ3zFV8h4ix6wqCtQ1ga/B5InaM/u2Gx+X19+72foQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756175415; c=relaxed/simple;
	bh=ot4jYRxaRsgRiUA4+br9v/m3GSFxEw4kWsMWU21ybsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NSGO7eERx7emMDP9oIML3cE5Z9lQNNfqzejHDN6ul41Pf32AAs31lYWffR2FVlVl3RKN35mF01jhKO7+QZoJrHdakDwSS9CFYkeDzhJECivvZ5wF5j+fDi0WCJsZgLhFEOv8d9Fed1Bw+P2krhCfAnr/7UMYROWpd1d+QvJ/Zjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KwAz3Sm8; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QH2qwLwX5TcJrw43QMJ7TXab2Dww1hm+3n5rKasR8yDAB68m8e1xfKI9p8xUwPfvx1aWWTJkOGgsmX4+du3V+wZGF8e9/WiidAgmNLtlpbZqEpG4zeyhaNcTfX7bVDq1jJ6xiDOGD130hvbWqYdiu3/CYy6rBMuTlfhZpvneSEwTLtW+oNirJYDJb0adY2anXQQRAXvHo+ljqDwW6elioFHrkCyQk8adK7e7plVLe/XW84E9uGRHSqYmrar6ZulK5dn/MRinmfO9iJFSGPphEIUNN189YfLRaIRYOEUMzWQlJKd31JzmTpDOJAzqUe5sN7ZZI3cLKOnBUIuwiNSQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/L/gGp51qDEz+4gACuamITWv2eWS57HuLUSQdxZz5vE=;
 b=IEyzJTNCE6b7dytfnmo+S+g75EwTWziP+HWXGTE0c5M1oX6fimXhoErnTWUakPBkQThrJSayM0CN4+hAmqhblnmIIByytyQtrM7C3VAMJIbssWv2Iu4O5gM+cA7V4Nq117bUMcmVqO1gMFj5KKktlMmyB7qMnsfZ9EoNF5dfMdLjbT1KsHBqswE24doquIc/ik+hDQ1gLDN9Z/oL2ZKj6UACS7I6H/AdGOwTqr+UDEO7uFWHTo+He6KZbRz8ompa3WAGMSjEai+INmz2cisBQBYMcibtBn4omlMv0HuW9XLXbDLL1bp9jfB4qCYY3ffdPYqMhnlEa95B0vE01autOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L/gGp51qDEz+4gACuamITWv2eWS57HuLUSQdxZz5vE=;
 b=KwAz3Sm8yrJWXzbSrHU8z64VZbXQj9xAMe4BP66k/T7ycbJUos61qozpM81jiPHrSG3YSlX+w76aouIhA4L/m19V/O9bZcqgL0j+2v2Yry+UXogbtzCC1fUt/6q4rhToDkLfbyILRu1ctcbGsC+IGd/qVMSuDeS8A7k0LNMW+ZbyTqZasklubvJIv0M9ZE0Y2m/bVRHC6QOftwxN7jPvNehGCtDsrORZ6QvLfKmYWbSt9b2QHLLVdQOCuiQnvQk41dL4Vd0uDV4k92DKc432w1A57KcIsdu4iuoj3zi1k9RdOwsop5sWCIYp8HOIp89WgDh7JC8p0FJK1FJN40rWsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Tue, 26 Aug 2025 02:30:04 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 02:30:04 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v4 5/6] thermal: tegra: add Tegra114 specific SOCTHERM driver
Date: Tue, 26 Aug 2025 11:30:01 +0900
Message-ID: <13836716.uLZWGnKmhe@senjougahara>
In-Reply-To: <20250825104026.127911-6-clamor95@gmail.com>
References:
 <20250825104026.127911-1-clamor95@gmail.com>
 <20250825104026.127911-6-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0170.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::10) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cd566e-3f20-4d37-4ae6-08dde4487702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enQwdTBmUXJqNkdjcStzalRvdUlzdzB6cGd4MUNxQmExUTVHN3RoRjAwVWph?=
 =?utf-8?B?NnkzQW5zYmZUcDFHK0hYTWZONk11Q2JSc09BYS9yWm5kZkMwL0xXWlRqVGg5?=
 =?utf-8?B?Q0RVVFgwRThOMlhTZ0hneFVsZWphS0NWLzdmV3UzczQ2UVFDUXhpZjYwczgx?=
 =?utf-8?B?cUpFOTk3MWU1Y2dPRS9XVGZLdEVKTHQ3Y3hLMHR5eklGZ3dpRENCMklYNTJi?=
 =?utf-8?B?eHpBS3pwUHorcG5ZK1czcFNlNVJxNE5Pbjd4WWVydmZnaFJxRThrcm41eUhP?=
 =?utf-8?B?bkU0Y0FmWWNrak92Z1lHRk42Y2RhdC9KVjlnWWM2bGZHemFsOWhmSDMyei8y?=
 =?utf-8?B?aEhCVlZxUitGbE1GVzJyT1kyZ0lmMS9wbGtJbWV2dDhqY0NMVGFMYVkyeklY?=
 =?utf-8?B?dG5USmdLb2IxanpnZzYxM1QweVYwR2pyOGU2TGlRdHN6NThGdHpZMjdKdXlL?=
 =?utf-8?B?aGlDTEFEV2dpSW1EUXFyRzVuUmJ5bmlWTXJBRngzQ05Ield0dCsxcXQ4a1F6?=
 =?utf-8?B?dkpwTURVSEVWK3FKSStDSGZURDA0RkREUlJCbW9QREZ3VGhOcEMzWGl5T3Ax?=
 =?utf-8?B?cmZnYkpGWFk3UzEvS2RoYkxFZnRXeGRzSDZrMlU3ckV3MmtBbm9uWEF6YmpH?=
 =?utf-8?B?dktPT3RudmdBa09TQ01ieVlwa1pwWDQ4a2Q3d3VZZ05nOEJXVUw5MEVFRzVN?=
 =?utf-8?B?VjQwRFJ1aHR1ZkZ5YThWOWFlZ29VQXBrMklScytLN2FCdVIrSkhpOFhSSDN5?=
 =?utf-8?B?eTdBMHpJY3c3ckxqa1R3TnY2YUExRXBWTzk1dGNRR3k1M2tvci9yRWRJejlh?=
 =?utf-8?B?cXR2b3lUaDFWSXdkb1lmekxnWlBmNCtnWmI5VVdkaUJ4clZ3MkFhU0dPL1NR?=
 =?utf-8?B?ZmNDUS84NUhLMVJyRnRZRHVkaWMzd3N4OUNyL2ZyTldRd3F1b1llRDdkeUgx?=
 =?utf-8?B?M3pXZkJkN216NVdkcitQdXN3M1FWOTBhS24yYlBJZnJ5U01aaThyTTg0V0k5?=
 =?utf-8?B?SXFER3l3WlpsVHFURXdNd0ZKY1B5MnVOYkYvQkg3WDd3STNGSmJxSVhZVVYx?=
 =?utf-8?B?eFRXc3gzY3laY0VHRmIvcEI1NGNBeDRSVzFVaDJKOWJjbkZ6SjZBWm9uNU94?=
 =?utf-8?B?Q2RwYjRqVGZhcjhNS2dZOTJSY0srL0JXQXZ6WldFUWl3WXhIbDRQZFp0RzBJ?=
 =?utf-8?B?RE5laC9LVGlTQlRuQjdINmEzMi9RTWVrb2l6UHZEVVdjNzJWcVkyZCtLeVBM?=
 =?utf-8?B?WHJNRUFPd2taVjRpVm9SdmV6UGk3cHJ0WDNadE9OZU1TeUVmVGFxTWl5Vm1N?=
 =?utf-8?B?b3RoRWNLNjBnWnM3aWxlZ0tCRjJNL1FCRE0vVEJyOERqQkx4MGtUWDI4OEhJ?=
 =?utf-8?B?V21oUVc5S3hhL0Y0UGZteDJQK3IxS0tvalErbzhVTVlPdnBsVkNHSXdNMHpH?=
 =?utf-8?B?SjErT2Nmc2ZqUGNxeWVhbzVjeFQ2aFowUXRicysyVXNLM0ZndWJKY2lPNUlR?=
 =?utf-8?B?Z0lIaFVOVnYrMkJaa1JMZ0R4Slo2U3FDdTE0VFFjQVpOZzgwY1JNWDYycndY?=
 =?utf-8?B?ZkRQU1pXS2V3RjB4L3IrdjdhUWthN0xrbGJpZnJKTS96TEpxSm5aQmx5MUtU?=
 =?utf-8?B?YUJvRFg1UHd6S3ZGRnlNQ0pZbnBNbFBWdG1HSCs5Qkgzc2VVSzNPcmtUUWhR?=
 =?utf-8?B?UzZkcjE5NGZCWXZQL2Y2MEZSU2xHeWNnV1l3Q216WVJrY2RFREZQR3NNWnM1?=
 =?utf-8?B?TkVoS1V1bVFOWURRbVJBUjRnWWQyRHVTcENvOUMxb2ZsVHNIVUhsOUgyM2Zm?=
 =?utf-8?B?UmZkTkNLUno5WU8zZlFBejZRSXFUaVMvZzZ6eGYxbThqZnBadGhTVUdKdFdK?=
 =?utf-8?B?Wi9qeVVtWFdzR1ducSs2RE4yc05IRW1SWDMwQzc2eUY5aEZiSzRrRkUzMUJ3?=
 =?utf-8?B?cEhzZThFOGduT2JST2tnLzN3ZW40TDFZUWNDZ20xQ0RmclFBSDgvNTJmSXZH?=
 =?utf-8?B?UUdDZXExZ3BnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHBCbS9NSWRSc3F0OFdwaG1IdlRCNElQb0VvOUk0clNMNzhnWWluYm1MN0ZY?=
 =?utf-8?B?NWFpZGNoS0IzanlLUTNVSWpRc2VabjcyNFVjb0VKWTFxZ2RXRkFKdktnNEVj?=
 =?utf-8?B?d1JzQ2l0VEM1ajhkNlNnakxrNW00RlVvRk4rbUx4Mk96bnZmS1JZYjkrVTU2?=
 =?utf-8?B?bVd4QmppZHdqVytCQkVmWTJYLzNlSWVvUUZDT2tBSlc4dUZUdFV1a2w4YzR3?=
 =?utf-8?B?cm5tdmdVd3lEMUlHR291dGZqRUpKL0lQSXBRK3RPdjl0UDNXeUtmUEYzSTVX?=
 =?utf-8?B?Qi9jb3k5K05oVVBMeGExK01tT0Z2T1ViMzVsUG8zSU0wM0lENDFDYWp3TjBE?=
 =?utf-8?B?bmgzUVJad1MwWGRCNDVSWVVWVitRMlpNWnNzMExnTjBYWWNTcWUxcjBhelEr?=
 =?utf-8?B?eDZVM1BPcGpvK0loQkFHWVF2ZkpTbWNBWS9oWUc0RWNHMEtPUDJ0TTg4SHlY?=
 =?utf-8?B?elFFTitnOXA0L1EzbWZ5VWhmTTA3MEtwU2RlK0o0SndsWUdsK1BCdkVONTJS?=
 =?utf-8?B?bEsvSkNOdkFIZFdHcFFUNEUwZ0ZmT3ZETjlJcy9INTc5a3lrUS8zbWhxZ0E3?=
 =?utf-8?B?cG9US1NqaFkwbTFiVnhXZHdocXVmbUlXbFo2S2M3UjRRTERtdHNNbUdPL2F3?=
 =?utf-8?B?RWlYSU5FSUEzUU5Kd2tIckMwOE0wV28reHZrbmtPOE1nU29hSURYMjNQOEJX?=
 =?utf-8?B?OUI0azRzQkh0MnhjeDF2aFIxcGQzZ2JnVTNmQmpZdzAwemVYMThUY3I3NFN3?=
 =?utf-8?B?RHBqbGFGVmZkcDllM0tYWG5BZEQ5c1hoVCt3NzA5aUc5MEhBSUtlaVVPeC93?=
 =?utf-8?B?dUJMdGVzYUdRalloWFNVWFprM1FsZ2VEU3htanI5bTFUWGZFUXN0MktNaE4w?=
 =?utf-8?B?eUdQcmNOMkJqUU9xUkgvK1lPN0wvSkR3VmxiMk54Vzh2d2pOYmlZZDJXTlVS?=
 =?utf-8?B?Z001eHdJazgvSlhqbUVDcENoZ1dvVHdOb1BTZmFwZnJaRmljN3ZhZVpJeDNI?=
 =?utf-8?B?OVRWT09Ub2V5dEdnUnJ4cGFSUHdPck1zbjkzMnQ2S1JqcjYxUXA4VnlXRldV?=
 =?utf-8?B?NWRmRjZWN1U0RDZhMk1XM3Z1eWd5OElVOGVrYndOUWRnUFNWdFV2dGdKMmlj?=
 =?utf-8?B?dVRlYU4wcVo3NGhXbVFqTkE5b1VmT3p1RHJVWGlGWDN4ZmtmazVyelZiYWlB?=
 =?utf-8?B?aDErOUhjZ1REcW43aHFUcnYyWWxlTklFNncxZXgvdXF3c2hwcHo1V1l5RkFJ?=
 =?utf-8?B?MHNIYVMvN3dLRk92RG1QS1dDZEc2Y29JQjlWZjdxZFM5VjVQcSs1cmRsdmhD?=
 =?utf-8?B?anY1cEw0U0k3MUZiaHJPZkUyT2VUYlNsUFllTjZjbWtqN2FZLzdxL1lUSHAv?=
 =?utf-8?B?OWR3eDN3SVBlKzNMMVZ0L2dWcTZRZkliRXZkNnczWWlVUUR1RGtyVk81RDNj?=
 =?utf-8?B?T1l5SWJEejRpNForbkZtOWEvWXBqR2JOT0paSnY1MXREUnBsRzhDTUQvcWQ1?=
 =?utf-8?B?b2ViNTdGa0twNHN6TDZJRFp1N1B3Zmg4U2J3TmQ3bi95bVpuL1QrL1hUdHBl?=
 =?utf-8?B?ZXRSSTFwSkd2djU3THkzdW94cHN5d1d4U2lJYVN0TXpxTjBhWlFEc3FmNTBD?=
 =?utf-8?B?aUpPdlRXNTdjRk9kNFBxTFIvUTFJZnpTNEt5VmF0dVdsRjBTMEtGb0VxaVpO?=
 =?utf-8?B?dDdtMTdKcnh5cWtwNTlteGJRbkJVR3BFbDZmdzNiV2FmS05zUlRmT3ZKcVo0?=
 =?utf-8?B?c1E2SWViOEdGQXpQM3NVMjhpSlZqclR6VmtLRjB1bUNpdDh0b0MxSi9TcDVU?=
 =?utf-8?B?UzZsRmEydVYxeDAyMXpvR1YzREJnV2RSTmtDMzRxSDhMeGRDeEV0bXhmQVhp?=
 =?utf-8?B?dDFHU1BrS1hrcE5scmE1SUZBcWRYb0VWZ3lnbGNIbFZGUjBHbnRzM3RUWUJo?=
 =?utf-8?B?WDZaakNaSm1JOFkxZ2RBSXVNWCtHUUMzYWMvdXg5eGxyWDRmT1hTTExFdU5F?=
 =?utf-8?B?VzBXYVN2NFBiKzYrNERiemZleDZ6aHhTNkdRN2lJazB3YklyMWlSSHVObVhY?=
 =?utf-8?B?S2Z1RHdtWXBFaU9KOHo3U1pHMGVUaVhnRlMweUptd3NIaFJmcjIzcERKK3Bu?=
 =?utf-8?B?ZUh2N3R6V3NLMkVTUDZqME4wZE00bU1rbmhuQUcvMmZYSlVZSU1CYjdRcnNZ?=
 =?utf-8?B?WkoyZ3MyWmp1aVg1VkVucEgvbDNNUWVZVXB3c2ZpMWdPZDNNaDI2YmlYZnJU?=
 =?utf-8?B?V00wK0lrOTRkSC9WY3RZOHByWWZnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cd566e-3f20-4d37-4ae6-08dde4487702
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 02:30:04.4551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhnRcDYT3QC+WXxKdYtAH69kC2voxpzft9rHJrFgD4Pf1SV+uULxw5FThzokRoFbbeywsb7iM3eWzrXtathHEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036

On Monday, August 25, 2025 7:40=E2=80=AFPM Svyatoslav Ryhel wrote:
> Add Tegra114 specific SOCTHERM driver.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/thermal/tegra/Makefile            |   1 +
>  drivers/thermal/tegra/soctherm.c          |   6 +
>  drivers/thermal/tegra/soctherm.h          |   4 +
>  drivers/thermal/tegra/tegra114-soctherm.c | 209 ++++++++++++++++++++++
>  4 files changed, 220 insertions(+)
>  create mode 100644 drivers/thermal/tegra/tegra114-soctherm.c
>=20
> diff --git a/drivers/thermal/tegra/Makefile b/drivers/thermal/tegra/Makef=
ile
> index eb27d194c583..9b3e91f7fb97 100644
> --- a/drivers/thermal/tegra/Makefile
> +++ b/drivers/thermal/tegra/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_TEGRA_BPMP_THERMAL)	+=3D tegra-bpmp-thermal.=
o
>  obj-$(CONFIG_TEGRA30_TSENSOR)		+=3D tegra30-tsensor.o
>=20
>  tegra-soctherm-y				:=3D soctherm.o soctherm-
fuse.o
> +tegra-soctherm-$(CONFIG_ARCH_TEGRA_114_SOC)	+=3D tegra114-soctherm.o
>  tegra-soctherm-$(CONFIG_ARCH_TEGRA_124_SOC)	+=3D tegra124-soctherm.o
>  tegra-soctherm-$(CONFIG_ARCH_TEGRA_132_SOC)	+=3D tegra132-soctherm.o
>  tegra-soctherm-$(CONFIG_ARCH_TEGRA_210_SOC)	+=3D tegra210-soctherm.o
> diff --git a/drivers/thermal/tegra/soctherm.c
> b/drivers/thermal/tegra/soctherm.c index 926f1052e6de..bfc438fbdc59 10064=
4
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -2048,6 +2048,12 @@ static void soctherm_init(struct platform_device
> *pdev) }
>=20
>  static const struct of_device_id tegra_soctherm_of_match[] =3D {
> +#ifdef CONFIG_ARCH_TEGRA_114_SOC
> +	{
> +		.compatible =3D "nvidia,tegra114-soctherm",
> +		.data =3D &tegra114_soctherm,
> +	},
> +#endif
>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>  	{
>  		.compatible =3D "nvidia,tegra124-soctherm",
> diff --git a/drivers/thermal/tegra/soctherm.h
> b/drivers/thermal/tegra/soctherm.h index 083388094fd4..aa4af9268b05 10064=
4
> --- a/drivers/thermal/tegra/soctherm.h
> +++ b/drivers/thermal/tegra/soctherm.h
> @@ -142,6 +142,10 @@ int tegra_calc_tsensor_calib(const struct tegra_tsen=
sor
> *sensor, const struct tsensor_shared_calib *shared,
>  			     u32 *calib);
>=20
> +#ifdef CONFIG_ARCH_TEGRA_114_SOC
> +extern const struct tegra_soctherm_soc tegra114_soctherm;
> +#endif
> +
>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>  extern const struct tegra_soctherm_soc tegra124_soctherm;
>  #endif
> diff --git a/drivers/thermal/tegra/tegra114-soctherm.c
> b/drivers/thermal/tegra/tegra114-soctherm.c new file mode 100644
> index 000000000000..a573a9d1439c
> --- /dev/null
> +++ b/drivers/thermal/tegra/tegra114-soctherm.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2018, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2024, Svyatoslav Ryhel <clamor95@gmail.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/thermal/tegra114-soctherm.h>
> +
> +#include "soctherm.h"
> +
> +#define TEGRA114_THERMTRIP_ANY_EN_MASK		(0x1 << 28)
> +#define TEGRA114_THERMTRIP_MEM_EN_MASK		(0x1 << 27)
> +#define TEGRA114_THERMTRIP_GPU_EN_MASK		(0x1 << 26)
> +#define TEGRA114_THERMTRIP_CPU_EN_MASK		(0x1 << 25)
> +#define TEGRA114_THERMTRIP_TSENSE_EN_MASK	(0x1 << 24)
> +#define TEGRA114_THERMTRIP_GPUMEM_THRESH_MASK	(0xff << 16)
> +#define TEGRA114_THERMTRIP_CPU_THRESH_MASK	(0xff << 8)
> +#define TEGRA114_THERMTRIP_TSENSE_THRESH_MASK	0xff
> +
> +#define TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK	(0xff << 17)
> +#define TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK	(0xff << 9)
> +
> +#define TEGRA114_THRESH_GRAIN			1000
> +#define TEGRA114_BPTT				8
> +
> +static const struct tegra_tsensor_configuration tegra114_tsensor_config =
=3D {
> +	.tall =3D 16300,
> +	.tiddq_en =3D 1,
> +	.ten_count =3D 1,
> +	.tsample =3D 163,
> +	.tsample_ate =3D 655,
> +};
> +
> +static const struct tegra_tsensor_group tegra114_tsensor_group_cpu =3D {
> +	.id =3D TEGRA114_SOCTHERM_SENSOR_CPU,
> +	.name =3D "cpu",
> +	.sensor_temp_offset =3D SENSOR_TEMP1,
> +	.sensor_temp_mask =3D SENSOR_TEMP1_CPU_TEMP_MASK,
> +	.pdiv =3D 10,
> +	.pdiv_ate =3D 10,
> +	.pdiv_mask =3D SENSOR_PDIV_CPU_MASK,
> +	.pllx_hotspot_diff =3D 10,
> +	.pllx_hotspot_mask =3D SENSOR_HOTSPOT_CPU_MASK,

In L4T r17, I see the hotspot offset values for both CPU and GPU at 6000 (i=
.e.=20
6 for upstream).

Also, I notice that the driver is relying on the TEGRA124_* DT bindings for=
=20
internal indexing, hence requiring that TEGRA114_* values are the same. Whi=
le=20
that should really hold, I think it'd be a good touch to add some=20
static_assert()s to assert the TEGRA114_* and TEGRA124_* counterparts are=20
equal.

Otherwise, looks good to me!

Thanks,
Mikko

> +	.thermtrip_any_en_mask =3D TEGRA114_THERMTRIP_ANY_EN_MASK,
> +	.thermtrip_enable_mask =3D TEGRA114_THERMTRIP_CPU_EN_MASK,
> +	.thermtrip_threshold_mask =3D TEGRA114_THERMTRIP_CPU_THRESH_MASK,
> +	.thermctl_isr_mask =3D THERM_IRQ_CPU_MASK,
> +	.thermctl_lvl0_offset =3D THERMCTL_LEVEL0_GROUP_CPU,
> +	.thermctl_lvl0_up_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK,
> +	.thermctl_lvl0_dn_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK,
> +};
> +
> +static const struct tegra_tsensor_group tegra114_tsensor_group_gpu =3D {
> +	.id =3D TEGRA114_SOCTHERM_SENSOR_GPU,
> +	.name =3D "gpu",
> +	.sensor_temp_offset =3D SENSOR_TEMP1,
> +	.sensor_temp_mask =3D SENSOR_TEMP1_GPU_TEMP_MASK,
> +	.pdiv =3D 10,
> +	.pdiv_ate =3D 10,
> +	.pdiv_mask =3D SENSOR_PDIV_GPU_MASK,
> +	.pllx_hotspot_diff =3D 5,
> +	.pllx_hotspot_mask =3D SENSOR_HOTSPOT_GPU_MASK,
> +	.thermtrip_any_en_mask =3D TEGRA114_THERMTRIP_ANY_EN_MASK,
> +	.thermtrip_enable_mask =3D TEGRA114_THERMTRIP_GPU_EN_MASK,
> +	.thermtrip_threshold_mask =3D TEGRA114_THERMTRIP_GPUMEM_THRESH_MASK,
> +	.thermctl_isr_mask =3D THERM_IRQ_GPU_MASK,
> +	.thermctl_lvl0_offset =3D THERMCTL_LEVEL0_GROUP_GPU,
> +	.thermctl_lvl0_up_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK,
> +	.thermctl_lvl0_dn_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK,
> +};
> +
> +static const struct tegra_tsensor_group tegra114_tsensor_group_pll =3D {
> +	.id =3D TEGRA114_SOCTHERM_SENSOR_PLLX,
> +	.name =3D "pll",
> +	.sensor_temp_offset =3D SENSOR_TEMP2,
> +	.sensor_temp_mask =3D SENSOR_TEMP2_PLLX_TEMP_MASK,
> +	.pdiv =3D 10,
> +	.pdiv_ate =3D 10,
> +	.pdiv_mask =3D SENSOR_PDIV_PLLX_MASK,
> +	.thermtrip_any_en_mask =3D TEGRA114_THERMTRIP_ANY_EN_MASK,
> +	.thermtrip_enable_mask =3D TEGRA114_THERMTRIP_TSENSE_EN_MASK,
> +	.thermtrip_threshold_mask =3D TEGRA114_THERMTRIP_TSENSE_THRESH_MASK,
> +	.thermctl_isr_mask =3D THERM_IRQ_TSENSE_MASK,
> +	.thermctl_lvl0_offset =3D THERMCTL_LEVEL0_GROUP_TSENSE,
> +	.thermctl_lvl0_up_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK,
> +	.thermctl_lvl0_dn_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK,
> +};
> +
> +static const struct tegra_tsensor_group tegra114_tsensor_group_mem =3D {
> +	.id =3D TEGRA114_SOCTHERM_SENSOR_MEM,
> +	.name =3D "mem",
> +	.sensor_temp_offset =3D SENSOR_TEMP2,
> +	.sensor_temp_mask =3D SENSOR_TEMP2_MEM_TEMP_MASK,
> +	.pdiv =3D 10,
> +	.pdiv_ate =3D 10,
> +	.pdiv_mask =3D SENSOR_PDIV_MEM_MASK,
> +	.pllx_hotspot_diff =3D 0,
> +	.pllx_hotspot_mask =3D SENSOR_HOTSPOT_MEM_MASK,
> +	.thermtrip_any_en_mask =3D TEGRA114_THERMTRIP_ANY_EN_MASK,
> +	.thermtrip_enable_mask =3D TEGRA114_THERMTRIP_MEM_EN_MASK,
> +	.thermtrip_threshold_mask =3D TEGRA114_THERMTRIP_GPUMEM_THRESH_MASK,
> +	.thermctl_isr_mask =3D THERM_IRQ_MEM_MASK,
> +	.thermctl_lvl0_offset =3D THERMCTL_LEVEL0_GROUP_MEM,
> +	.thermctl_lvl0_up_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK,
> +	.thermctl_lvl0_dn_thresh_mask =3D=20
TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK,
> +};
> +
> +static const struct tegra_tsensor_group *tegra114_tsensor_groups[] =3D {
> +	&tegra114_tsensor_group_cpu,
> +	&tegra114_tsensor_group_gpu,
> +	&tegra114_tsensor_group_pll,
> +	&tegra114_tsensor_group_mem,
> +};
> +
> +static const struct tegra_tsensor tegra114_tsensors[] =3D {
> +	{
> +		.name =3D "cpu0",
> +		.base =3D 0xc0,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x098,
> +		.fuse_corr_alpha =3D 1196400,
> +		.fuse_corr_beta =3D -13600000,
> +		.group =3D &tegra114_tsensor_group_cpu,
> +	}, {
> +		.name =3D "cpu1",
> +		.base =3D 0xe0,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x084,
> +		.fuse_corr_alpha =3D 1196400,
> +		.fuse_corr_beta =3D -13600000,
> +		.group =3D &tegra114_tsensor_group_cpu,
> +	}, {
> +		.name =3D "cpu2",
> +		.base =3D 0x100,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x088,
> +		.fuse_corr_alpha =3D 1196400,
> +		.fuse_corr_beta =3D -13600000,
> +		.group =3D &tegra114_tsensor_group_cpu,
> +	}, {
> +		.name =3D "cpu3",
> +		.base =3D 0x120,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x12c,
> +		.fuse_corr_alpha =3D 1196400,
> +		.fuse_corr_beta =3D -13600000,
> +		.group =3D &tegra114_tsensor_group_cpu,
> +	}, {
> +		.name =3D "mem0",
> +		.base =3D 0x140,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x158,
> +		.fuse_corr_alpha =3D 1000000,
> +		.fuse_corr_beta =3D 0,
> +		.group =3D &tegra114_tsensor_group_mem,
> +	}, {
> +		.name =3D "mem1",
> +		.base =3D 0x160,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x15c,
> +		.fuse_corr_alpha =3D 1000000,
> +		.fuse_corr_beta =3D 0,
> +		.group =3D &tegra114_tsensor_group_mem,
> +	}, {
> +		.name =3D "gpu",
> +		.base =3D 0x180,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x154,
> +		.fuse_corr_alpha =3D 1124500,
> +		.fuse_corr_beta =3D -9793100,
> +		.group =3D &tegra114_tsensor_group_gpu,
> +	}, {
> +		.name =3D "pllx",
> +		.base =3D 0x1a0,
> +		.config =3D &tegra114_tsensor_config,
> +		.calib_fuse_offset =3D 0x160,
> +		.fuse_corr_alpha =3D 1224200,
> +		.fuse_corr_beta =3D -14665000,
> +		.group =3D &tegra114_tsensor_group_pll,
> +	},
> +};
> +
> +static const struct tegra_soctherm_fuse tegra114_soctherm_fuse =3D {
> +	.fuse_base_cp_mask =3D 0x3ff,
> +	.fuse_base_cp_shift =3D 0,
> +	.fuse_shift_cp_mask =3D 0x3f << 10,
> +	.fuse_shift_cp_shift =3D 10,
> +	.fuse_base_ft_mask =3D 0x7ff << 16,
> +	.fuse_base_ft_shift =3D 16,
> +	.fuse_shift_ft_mask =3D 0x1f << 27,
> +	.fuse_shift_ft_shift =3D 27,
> +	.fuse_common_reg =3D FUSE_VSENSOR_CALIB,
> +	.fuse_spare_realignment =3D 0,
> +	.nominal_calib_ft =3D 90,
> +};
> +
> +const struct tegra_soctherm_soc tegra114_soctherm =3D {
> +	.tsensors =3D tegra114_tsensors,
> +	.num_tsensors =3D ARRAY_SIZE(tegra114_tsensors),
> +	.ttgs =3D tegra114_tsensor_groups,
> +	.num_ttgs =3D ARRAY_SIZE(tegra114_tsensor_groups),
> +	.tfuse =3D &tegra114_soctherm_fuse,
> +	.thresh_grain =3D TEGRA114_THRESH_GRAIN,
> +	.bptt =3D TEGRA114_BPTT,
> +	.use_ccroc =3D false,
> +};





