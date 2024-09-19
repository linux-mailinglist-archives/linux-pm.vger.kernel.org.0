Return-Path: <linux-pm+bounces-14460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB7597C8C8
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 13:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B829D1C22A24
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF52319D08C;
	Thu, 19 Sep 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OoY2tOPd"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644019C57B;
	Thu, 19 Sep 2024 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726747171; cv=fail; b=XPDMgU61q+pP2W5KcNMq9A0erD4aR3ZJs59D/fFYi5/eSjxfCIznTZahK+tdPO95i9J5chOxF+QjkExw6MjUojsvedKDT9u3ppDyB1d3NXARv/G97JyYYZbbSZDSJtsjnSSllSyxD+wC7YaK7Cy6+nJCgszyw72Nhaas1gWSPjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726747171; c=relaxed/simple;
	bh=tobdd50oTWYjlKp1IeFnmJH57pldQpf5ZAnYeTWDnDg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=u/JcxeuVfad1GVWXmLPyHfZHMkNQsWmHkOhEcP43yBAoZ+2GnJiVCwjwHDomIFRMsPgKGfjyAe3CuJOIJLEQLCoyP3NxfLRp5Q+NI0W8ntvLZAECr5xoulLFMWeamCk9GQdllHuj39dgpMpQ02nd6FFsb7hWEO6/C69Yj7YYo9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OoY2tOPd; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBBY3huheu1YEtwh4gyxNDoC4VrRFWUSjf1vu6fMqyu45LTUNFi9GoUYvG1FlFS5gGPAtox2AFq8LZiQo/XEunIdHsJVWnO9QjvBXxGXQPYJ0f7uAehNnbSmuTw6NBWncu2aBWgHn8WPmyu8ttFXdKEOgeAitSoJdv8TY0pR1tXBNJ16w7tbNHJDmjwvISQI0B/pv/HyvmfawY6vy2yd1irpbBddyxsxKsMoKqwMoqTA0OF0DwCXj7H5iz8TZ0J8FpdhzDvLYij7BA512W4RaUH6C+UT60DnIZ97ht81oXro9KGZWbu2WKDYIXX+axmN2V+uaGfoxEd9DhC8UASwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry/U4jd87m1zq5UVTw6OK4Z6KAovKekEmLz+IfCrRdw=;
 b=PlHn3AK/VuZavSs0108T+zmmqw0AaLC8iur44Xmg1PaJZh6CuTw5Alik9cmUkCayb854uFVR0M9bU/RWWHQwV6NuWyJhHkG1+wiReYlDjUrSbdklgx3GoeCEmImC5Cn8C8fvQ9Dt8JhdQcVGDrW9snYkbe7htfztQZqITQu26Q83IBx7HzxO6n/zcMqLGT9FEnFPeTTIkY5HFFFhdPGnNdhKgWWHxJ6jzO6HRIXXoBAzVZH9FTKyuBmhpduWe+BAW3eXMD3Oiqedj0zT9hEgusl2SBIlXkfsnK8HQvUMX0MSReAJU38vRCWR+UUfsZiJNliuO+vt/iPmSfQ/qPHqRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry/U4jd87m1zq5UVTw6OK4Z6KAovKekEmLz+IfCrRdw=;
 b=OoY2tOPd1/lAoDWqREpgqu15YjYWwXr6sbNA5vIMoGCvI8rUWFudPUazu9rQPfJPZNW3QwP8acdAFaQk2FHvVDqFGp8o5m2+xYERIlf7rb0c6AoRGgX0fTi+eOYqADHrG/tgBaxwQLxjqX54s0jQiaLZu+7ZNTIajZRBQmHuKauAnfbESF5uWxSq61Fq/HOSBZMakHS8dbi35++HtwEYU4TAUXBhGjyHmmksLGPGPEiuW05CzPNSv/UoZdAfPqprDO6BU4v/EEDP1ZkzKzEpWt6IoKPic3N+grUG2qcW62VqbY0+kHMJ5gtg7e2Br2TC0AF2EX6tAgvZVcrKI4kWTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB8041.eurprd04.prod.outlook.com (2603:10a6:10:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 11:59:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 11:59:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
 cross-compiling envs
Date: Thu, 19 Sep 2024 20:08:10 +0800
Message-Id: <20240919-pm-v2-0-0f25686556b5@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACoU7GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Nz3YJcXQMLQxPzNEMDk1RzAyWgwoKi1LTMCrAh0bG1tQCtQjtZVAA
 AAA==
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726747701; l=920;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=tobdd50oTWYjlKp1IeFnmJH57pldQpf5ZAnYeTWDnDg=;
 b=Q0A18Nl0UE3T+bYHSuFE9NN4h9VP6TrC/gx0/U4MuhSX3v0Qv1DUK1htO42Djj12fITDxes5b
 I9nRpZJ0olHC/luqnVKjEuLZ0CRslS7Fv5puG5dqhtKtGyVxmFVXoAb
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a55c62-c00c-4bc0-4e36-08dcd8a28235
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2ZldWhuNFRpOElZay93Smt4ZFE5aW1MQ0pKdE42Q1FQNUVpKzh1OUFydVV6?=
 =?utf-8?B?V2Y5NThaS242Zis5cTdoS1YvS1VPbEMrQWlmWFNKN2V5SFFRYlQ3cU01Zmps?=
 =?utf-8?B?YS82UWpyS3ViSUUwTDYrQU9CMmE0bDRtNmtWRlIrZ3lpQysyMk1iYnVkb2Rn?=
 =?utf-8?B?VFBrb056VlgwZFZXZlVwelZkeUdvT01LZzVFdG9ZcEFZeitFOHBWZkgwenBh?=
 =?utf-8?B?SC81WHV3OGVtUzV6U3JIMWJjQ3pYTGFBcWRJMS9NRzNSMnRMSjVLYkNDSmRq?=
 =?utf-8?B?cmtXWDBCTFk5WG1zN1hXNnlLNndaRllvaHJOV2VhZEI1VVB2dzArSEV0VEwr?=
 =?utf-8?B?NkFYUGx3SWIzL3E3U3dIc3ZORURzSncyQmNXQlRLUGNjYTQ3VDZGKy9tdEt2?=
 =?utf-8?B?bHBFSG1oMm00MWNsWGlydUU0T0VVVmRVSU1LWURWYXJyQ253RHZLSlJnaVpN?=
 =?utf-8?B?MmZRd0x4dC8wZnYyejdITnU5MWRvcUxHQi9zUWtFM3FUZmIwWXAwTk1semEx?=
 =?utf-8?B?QkFuS2NWZlRqR3FrUVN4aW13SWlvWmNnd2Riak1kZVE0WGVIaitYSHNxenRF?=
 =?utf-8?B?VDg1Vy82ZUVKOG5QdW1ucDI0dGM2Tjg1VE95RDlUcVBlcHpEYTZkYk55Zmda?=
 =?utf-8?B?SEUya3NqSjZlMm5aVHh4TWpkNTVqZTJ4WTJTb0Mxemlmb09vd3BwSXpleVdM?=
 =?utf-8?B?a0RTN25WMWhrNEFQdUE1NW8wRWFVNSs4bEVkMzlVZlk3VmFSdEs1WE01U3dz?=
 =?utf-8?B?MmZnMzJJdDRqT1VtRk9WYkVGSy9qWURlaVpZcXBWdXM4ZzU2ci9YeEVNZ2pL?=
 =?utf-8?B?R0RvME1Cb2JPb25Id1hoTDA0MDQ0TFZOYU5VQVo4aEtqaE9Jdi9GZFdQYnY1?=
 =?utf-8?B?WkR0ZmhQbkF4VFhBY0pFN0VmZjNpU2RLUjk0Ly9KWjArRjQrSE5NOVhMeGlU?=
 =?utf-8?B?WkZTWmIwa2dWYlZmUnBFa1dBeGhqbEI4WU00enlvczUyYzVIaXczc1J4RzYv?=
 =?utf-8?B?Vnp1Mnk5TnZ2NHE0N281MXhpdlBsSXNxK1ZrVFBrS1piNkVRdDBYTlIvdkpa?=
 =?utf-8?B?WFdWcnZvaDVLdWgrYmx3OC9XVjJPNWhZMGZNV2k4Vk1tYmlMbUcxRi94cXNz?=
 =?utf-8?B?S0tNSDdENXNZSlFXc2p2em9ZZFlsWENDbTd3TE55TEFUN3NKZS9ld0FML3dW?=
 =?utf-8?B?bG5NbUlhRVpLZFNGOUpYNVhvd1prV1VtT2VTb3VvU2ZZVjFGcGN2WUV0RlFI?=
 =?utf-8?B?L0dlZ1ZFbFc0SHdpcnZWMzNNc2RycmhPU0ZNa2t1dEN4Nm5UMFpQbHdiV3Rz?=
 =?utf-8?B?SVViWkMrajVoeUhscGRuenRYQmZobFNCbzJhUEFtMVR2T2NGTEtSaVRNekpO?=
 =?utf-8?B?K2JYc3JEcXRPYkRUeFAzTkFkUUMraGRiR2xMSmlWc3BMTGsvY29DZ0ZDTTNn?=
 =?utf-8?B?dGNCZStzQTFqMHlsYWtYTjJ0Q0h2ZVNqQkRKOWljUExUVXkxWEc4U1l3RDJK?=
 =?utf-8?B?SnJncmovd2d4R21MNXN4MHNNTUo1SkNmL3dtUE9ZTGdkMDdtSTBlM080MnBP?=
 =?utf-8?B?VDJOR1c0TEk5b0RMamVWMXQ5QWp0bmJ2R0hZalpha0w2aEFUZy9VV1F3dGpv?=
 =?utf-8?B?dWJaak1IRGV0QnpzVnpFZkRlaHZPenJ5Rzl1U1o5VGl1ZDd4LzY1ckJzdUg5?=
 =?utf-8?B?YkxPdkd5T0k2L0k2RVVaeVFUOTFDMzdUdEVRdVVGNzNaSnVnSkJGSjBwYlBr?=
 =?utf-8?B?cFZWMU1nRFBidGpsbWd1QjFZT3dsMlV2eXRWL3NUNE9TYmsrM2FwLzdDSGZk?=
 =?utf-8?B?VDZMTlBLZEdpSWVmZWxVakVGU2R3bU16ck5JbTBCQU41V05INGdoUk1SQ21u?=
 =?utf-8?B?ZzZmQ1UwcHhiWEFCYXQ3U3RTR0t3a1BqNUpMVGpTMkUwU0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHJYSVJKWk5mMWNsaldPd1NZV0czVDZlb1FGRkxJcHFXMlhPZ28zN1hJZVRO?=
 =?utf-8?B?TkYxN3hIN2pVM3ZuUXd6VVNhNXB6TC80djRPR3ZyVytOTmgyZ0E2ZkJNakh3?=
 =?utf-8?B?TitzV3pxSXExYy84aGN5THBQTEovc2RWYlcySHExekNFTTJnTDJKS1hyenBy?=
 =?utf-8?B?bnY1Y3dSNXRBNzNwK2o5WjNrQ1hhUUtnejJZUEpIcEkxMzYrTkhRU1ltK3dZ?=
 =?utf-8?B?V1ErUUdVMnBmc29wMlFpWnRDOHFHUDNtdFVtcVJyaVZVK1c2QW5ReVQyKzcv?=
 =?utf-8?B?TjhXYTFkVXI2QlRia3RSZVRaY1pjcHh4NEVscEQ2RE5JUVlXRlNVblBYN1lY?=
 =?utf-8?B?M3RBQWRGemlmK3gvazZBamczSUE4MEtYUnVVcUN6Z0Y4MStwV2NSa1VKNmY5?=
 =?utf-8?B?U082blpqSis0aXdsY3oxa21DZW8rNHF0K3k2Nkl0QzUzY1NVNkY4K1VydnJV?=
 =?utf-8?B?dlRmRDMxUENFQTYrcEUwcURHZEZ6SzVweEF6eDltNGlZQUlsWjBhTUhqMGc4?=
 =?utf-8?B?cWZ0d0cycTlHRVdRaFFJK21WZ05USncwOW1mRDJYSllIMkROZVBxVDN1SDdX?=
 =?utf-8?B?MEtoTDRNKzFYMXpkclFEcmVKUkZROUgyK3BCSCtTT2tRSldoWXNtK05id0Ex?=
 =?utf-8?B?aTBVclRpU3FjMis5QjZ4U1RxcGRVOVFlZnI4ZzJGKzFPQTFpa0hQaGFFQjFw?=
 =?utf-8?B?RWY0NDY4Rjlvak12LzFqMEZQYlQwNjRhbVZoN2s5N2hPc1ZhZ08wZzJXOUUw?=
 =?utf-8?B?SUxzMlZzcUZldmw1ci9tM2hHWUF6RDlZYVQ0cUMxRDlid3IvUU5ZSFZHWUJo?=
 =?utf-8?B?ekxVK0NCRWlDaW9vNnVSS04vRWxBTUhNaTNhekpaMk0xeGRvUlQvMkRCeVJr?=
 =?utf-8?B?eGRuNnluVkpYYnNIcEliazR4b1hMSDlpY2Vqb1FXSlUyR0dKb2JrdnVWbVky?=
 =?utf-8?B?SzhpU2tWd0ZWYUQrM2tkL3Y0LzNYUWNhcEp3MEpHS29FVHc4WUJWaDhxQi9I?=
 =?utf-8?B?Y29LUC96RkVOZW9sTk1BWjQ0L21FNGlkb0Z5RE9IZGxyRXpES1dYV3FlM0Fs?=
 =?utf-8?B?VGlOMmFmcG4vY3dUL0VLdkViMEtIWURIZWlsZkFkTXpnRUVnano0ZUg1Umtj?=
 =?utf-8?B?eVlHWWZzaktNWkNVNklFOEFIZGZuU1JQSjVNcXFLalFnNEtLdktaUW1sWStS?=
 =?utf-8?B?S2loeW42eUgva3pQdXBtWXY2SHhuWVlSRm1RaGkvNC9OeTRXQ3pQc3JjR0FJ?=
 =?utf-8?B?ZmdFNS9VT1Bua01nTkhkWDdRNWtzbUpWSm1uTW9xTDRHSXBBN1NONExIMmdD?=
 =?utf-8?B?NW5vVlYyODBPUks5WXlBWmxpQ2tVTkdlME5wWENBRlZISFJKWHEzckxuV3ZU?=
 =?utf-8?B?QnU4Vm5oc2o1Y1M0OG5ZWkRaT2JPYjNGdExvcGlJRTMxVi9zQ3JQRm9iclgz?=
 =?utf-8?B?VnRud3dMQXNaZWh2Z3lYVXdXaFIvODEzdWt1TVhXMFBWbUN2NWhMUTNhUi8y?=
 =?utf-8?B?K3B2S2pRbUFVT2JVZHpMOUZxVEJDUUJlQzZzdjJNT1BzYldja3Vscy9BZ3JZ?=
 =?utf-8?B?SzFHVm9UVmZ2TU8xMWVVYXVsWEY3YXJuRVFUdDNqcmdTa1ZRUW9objZqRGJ5?=
 =?utf-8?B?T3JOeCs2eWpEbXhILytjTFkwaS9qOTg0K2ErNGNCZ3VVMVhkVFFVTmlWWmVR?=
 =?utf-8?B?SHA0cWhQK0QyRVRhcUZyQnlyZ09zZG9KWitwZlkxdEdzU2YwVWlkeW4yWnVP?=
 =?utf-8?B?amxveW5UbXpLdCtEVTZJTlBJSmlYK3Qwcm5TVVNuVittU0NYbURxY1pldXBC?=
 =?utf-8?B?TUovTjQ3M1h0VFZlMlVpcS9XUWgvZncyLzJNbzlxSFQ5Yy8vRXlqREZMcXJX?=
 =?utf-8?B?NFQySUFpcTR2WndsUldOMUI5a2h0YWhqRGhLQXdrQTVuSG53NUZNQ3hlcTVE?=
 =?utf-8?B?NFRIcmV4V05SNUdLeU9kdklyaE9wU2JocEc5Vncyb0xlTDVZTENoenJhbWd2?=
 =?utf-8?B?eTBvaUIwSTcvV1JiSWFUSmtSaVZEcGJRaktldGZwanZhajhkaU02Tk5sUTA3?=
 =?utf-8?B?NGdoeVA1dzltZzZ3VVNIWEVPMFVLQytSSFpVTzlpU0lsRzlpNmd6cTdtcHE0?=
 =?utf-8?Q?hQfKWdOkbfAvvKEkL++11ECLd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a55c62-c00c-4bc0-4e36-08dcd8a28235
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 11:59:26.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuuS1EEQ4uEJaZhtoFzKhR9wDfdIV5aq4p4JxNwdvMTDh1J5lL8dh4vEzMhlM2ff38oO28fJEYqqDfH/eh5ZXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8041

Two minor patches:
Patch 1 is not relevant for cross-compiling, but done when I playing
with cpupower on ARM64 boards.
Patch 2 is to make it easier for Yocto users to cross-compiling cpupower
tools.

Signed-off-by: Peng Fan <peng.fan@nxp.com>

V2:
 subject update, commit log update in patch 1, 2
 Use strerror in patch 1
 without patch 2, need update Makefile with 'CROSS =
 [cross toolchain path]/aarch64-poky-linux-'

---
Peng Fan (2):
      pm: cpupower: bench: print config file path when open cpufreq-bench.conf fails
      pm: cpupower: Makefile: Allow overriding cross-compiling env params

 tools/power/cpupower/Makefile      | 12 ++++++------
 tools/power/cpupower/bench/parse.c |  5 +++--
 2 files changed, 9 insertions(+), 8 deletions(-)
---
base-commit: 6708132e80a2ced620bde9b9c36e426183544a23
change-id: 20240917-pm-08147f104e70

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


