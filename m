Return-Path: <linux-pm+bounces-14462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E67F97C8CC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 13:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5248D1C2318F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4703A19DF68;
	Thu, 19 Sep 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vVHzjc66"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E3F19D8BF;
	Thu, 19 Sep 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726747176; cv=fail; b=qEps9pT0vde6PXEhevQW3VlBNo73Krwg/XCeNVcSOShTgbKhUhnRR78xfvLxglKag7Fhh6o+pwMDfkEKjYfjIEZ3SgYshW9pv8xuMWi4bR1aiey+wKhxjxHdHhMf+EL0CJ+4IB9AhK6ZdTHqb0aDx9buo0o2fFkcpImMBFdtoko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726747176; c=relaxed/simple;
	bh=7V0f/f9guHNu7sC64qEuW8R13ABKxk0EvLM+bSDlK/o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=B7BxLfnAB58F8Y7m8PHfsShPlfLf46cAxuv2WKCphn72cfqD2LRCWB02QytQc0jkyCr2ai07UHBJ1+BBHQk6ifCAI1dhg0hjhNixJvL6SxF5m7AXpocwpm5ClAsGLR+/ruSz7qougKjMjX/tNeA1a0xYCWK3AaCdSB89xV3U3c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vVHzjc66; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFzksRt9DvIAlYU2vkGLaG4amrAkCqdH5oonAiytwECpV/pv56IBZL6DjvC9W0uRo66A3qt4371aWV6FA+/cevN5qS5OgVQTwyTJnNVs5C2xZpjazLfjJsCUeNfnEoyGjNcpkVeV4t2P13coqeO+fnC4RtYOiJjL3zwVkn0hjuY41EcfCdE89tVUeoOE89d7zmaryUWNFdXqJMGQTsFfFaYIc5+tHbyc11Cf/PjNdrAijRnHIMgoTuQiGLBZK4PH8+5YSE9LnEn9I4X+pU5mreH6xfeQFGcnc76axnpQXvjgH3wXNS4O/LKy6w+n+nHnXHjrepwblnsMkfZ8IGnzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoIGSlMIQRDr2pq3U62k50+a0lLLhLMwtt+p9LzKGsY=;
 b=qdfddmEs0iEnKaoEqOFH1a9m+YE+rtjCCetrMzH7/UROEn/U1Jkz4gogneHdKyvmG0afivbWx3OLYYyq41lwnr2Kp+2+WdH9LYUtht0jMKdrYzU7nokdIyOmY9VD8eiRH087IdbxIh+rkAPNh8ywMhjjsvhA4hPM1eeETfI/yNDRAW/a9mloH6Q/mN3jrphI18gTRMl3BJiwdVTlKiXxsQNTjZpWVeCJxN+J0yM7gCKB0TAXNG7bT+wVvyWEmvjiPWsiNLcDQ7G8mB4Qml0q8bG/rqXpGER2X6UrRs6HagKzUrE5rSWlcGT0D0r6VO8v1UC9DOm8TxQhvnquksYCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoIGSlMIQRDr2pq3U62k50+a0lLLhLMwtt+p9LzKGsY=;
 b=vVHzjc66PzMaC3eNg4aYDKFzAz4qEn668KNfAbT5kq/T3/zTxn91oVxGgAL149G9O6fwvTqfT9C6Cvjj+lnwY/YnQ9Sx1PNcWZmeu9FV+M48q2koDpKRzIr0Cfk/6AEGlfFFAPkbJ8L228YwNfXW4LJga2xEbOjZJHOsHmLrUcfBTraGON+eAVIcp0reEWodEl5SCapcwTK/KBrDqgcdy1L8RbKNvEX2eTp1iYBRWb6/STOmO61Bvw2ZhUkJPJFAoXJf5DcQlTuxP0XPMurWoov6AY1n0xj4b16rQm2XVxu0afQMzEbIuNBEJkEkHFuYsEE+bBQcUgaSK0nIrkMlAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB8041.eurprd04.prod.outlook.com (2603:10a6:10:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 11:59:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 11:59:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 20:08:12 +0800
Subject: [PATCH v2 2/2] pm: cpupower: Makefile: Allow overriding
 cross-compiling env params
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-pm-v2-2-0f25686556b5@nxp.com>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
In-Reply-To: <20240919-pm-v2-0-0f25686556b5@nxp.com>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726747701; l=1195;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=fMo/GNBeKM8Yzn76Blt/N2LBPZebcMz9USwf2IPh7sI=;
 b=ngEq6iNVxJpbaeWYj3qEu/rLiyb46vFqsortEdwAHuVYPTGhtu63/MNoWBKRnDdFWcdnxXfmr
 W1nH1im3BYnD1qUU/phezhHs6UZsGlUBdiG2afuv1QlYWB8hKdaVXpI
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
X-MS-Office365-Filtering-Correlation-Id: 5088639a-0d81-4912-9ffd-08dcd8a285a8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zml2QmkxL0VDZGd5RURyTWkraVZMM3JrRFNQMVcyVE5RZHd6RktSaFNBSnRK?=
 =?utf-8?B?b2t4MzJMUGdFamRMMi9KL3QyWUd5TTBEbXlhdzRFWjdVMjJmL05XRDVIQzM2?=
 =?utf-8?B?K0NaekRQNEFCUXMyZDZzeWVJeGZHR0RnRm5tMjZuZmxFWmdWZVQ4MWdNSGNW?=
 =?utf-8?B?ak0xak11MGRRWWxnN0pBTDcvN21Oc1BwQy9wZWM3ZEdTN3hFOUg3OFAyeWdG?=
 =?utf-8?B?Tm1yQk81TG1UdnZRZWJSSXNSY1RLNEpHUWk3Wko2OU1EYVlVK1h1SXFUYkhy?=
 =?utf-8?B?VnRGY1VCaVJsb1hsSGZidHNSdksyb0Fza0hvUDB2bzlqQkhMdDlJdjJnWkZE?=
 =?utf-8?B?Z05xeVYxSGZpUHFaL3BVeGdQVDN4cmFoTklINFc2dDEyWDMxKy9CZER6aXh4?=
 =?utf-8?B?SVVYdG5XN0NEdVhiR1Z3amE0czZpVkl6WnloSTdzbWZQSitkM3M3RWt4ZXdW?=
 =?utf-8?B?SmJmeURjZWl4ZHU5c21ETGR2NU9vK1pLZldMOXcyTm5GeUVDQnJLeFpKWWhN?=
 =?utf-8?B?UHlZVmJ0d2VLWDI3YVR0WDVBQm9lMlJFZDY3QmFwZThGZ1RiNWFtM080bkpG?=
 =?utf-8?B?WW9rYlVrR3pDR3BTYXlmQjFWdkpJUks1SGRKMGtHMFY4Vmx4TDlBQ1FWdTNY?=
 =?utf-8?B?d2lqcWc0cTYvN3hZeXFYVmduN05nUlhZakNNQjlXamdiV0ZyN3pDalZkT0NH?=
 =?utf-8?B?VGREL0hWdTcvQnQzQWcyMFg2RVB5S2pCREJaUEM1WDlGN2hlVGVMUUhVeWlp?=
 =?utf-8?B?eXd1RWd5UnM3TFJycGFnbDIwcDZTWjZXbURDN0RxaTlOcTd5VUNBRUh4R29R?=
 =?utf-8?B?U0gwYlVtc0d3RmlvSkxJS2l3V01TeW8vNnNvejZyZUZLWkd5aHN4djN0SSth?=
 =?utf-8?B?bHdQZGNnVmFtQWtONDJuOXllaTdPQlBrdGV1UUZqR0orMEtmMS9ZMXJBTk52?=
 =?utf-8?B?Z1dMVjlQVGFIa29CTEc5Rjg1Y1NWWDFxRGIzZ3hoVnF3WkhnWU5MUHYrdklz?=
 =?utf-8?B?MHhGK29uWkJWYmR2QUNQRDZkQ0FodG1OY1U3RlRHejZDcFRVOVVvbzVySjAr?=
 =?utf-8?B?cEJSRVU3VEZoVFRPU2QvWUcvWXFWbGZMYWlHZUVUeS9nd0FvQ1VKN3hCYytp?=
 =?utf-8?B?c1NTbkpPdmhLZlo3cXkwVXcwaSs0VnV4SnZYR2ZRMno1eTRuM1JLOU5mMFdB?=
 =?utf-8?B?a0JjWTJxUTZiNXNLcm9hcGN3K09OTk1KSW4zMGFYR1RYRFV1R3YwN2VtKzBW?=
 =?utf-8?B?VGlXY2E0NEhDK0F0Vi9Ldmh6WXF5eDJEcTdCTTdpU2JINnFjbGduSEVDMmU0?=
 =?utf-8?B?QkcyYWozSFhtSldiS1lOTzZSbmtZRDYrWWk1TXdkQnI0aHdQdWFRUWh3aStv?=
 =?utf-8?B?cnErVUdKOFgrRTlqR0hGMm1SeHQvbHVLSmJvOHZrY1FuYWZtMjZ3MVlZSFdM?=
 =?utf-8?B?VFlrNjVCZVhBQ0tiL2RzVkJYTGxDOUVlSzY3aDB5Z3FZWHNkOER6bldoSmN0?=
 =?utf-8?B?bXo0L0lXUEk4Q2YrM2hETEJacHJMSG5jT1lDdmZvTmhjMFVpYVdtNmc2TjJL?=
 =?utf-8?B?NHI1TE5oMENTelJEZE9lQTN2ZCtlV3Rwcnc1SEtNQVRCZkZlV25Nek5IWFRk?=
 =?utf-8?B?cEJoaGJJZVpOL0x4azd0Q0FOV1JyU3BKLzZtQWVEOElGQzBSd0M4OHI5dHpP?=
 =?utf-8?B?YWdMZ28xbml2N3U4UjA3L24xOHZ2ZlRhQ3FmcldGcEkxdDZLU2JjYy9FRFM1?=
 =?utf-8?B?ejlFZmpCd1FMVTMwN0ZZMnZuMk8rN0RpVnhnTG4vc25ZcFBEWTVlQ0g2U3Zu?=
 =?utf-8?B?b1IwdlU4L1ZBWloxSjhjZkQ3NU1vTkdDeDVCMXJnRmhVRmFSY2dhaTlsOTZZ?=
 =?utf-8?B?RmFLdlQ0UFFldFExSmpJWndvQldrTW10YUxYbzQrK0x2Q3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVYyczA4bVZLOXpSSk1YYWVSU2FnSTVOWFRBZGFWNEd5eUFTb3UvU1ZQdnE1?=
 =?utf-8?B?R0hVeU8xTHNjd0hJT0RsOVgzMmdSS1RZTFRYZyt3QnRCOS8yVGkyMTZ3bERh?=
 =?utf-8?B?aUVVR21lQXMydzExQ3JDM2hlYjJSdElCelpsU3BMc3Vpbnp0cHIrK0d1RkU4?=
 =?utf-8?B?R1U5a3RqZEpZNzhkTzZsZzJYbjhXWm1yS2FnMEJMcWZrNlBNaHJpckxCMC9N?=
 =?utf-8?B?VVY3UFZxb21GaHh5Z05OMWVpbVAwZXNkNFVmYXYvMDRubDl6REtjY1phWnVI?=
 =?utf-8?B?cmQvV096bmpvMi9FM1FidFA5YUVjeTh1cCsvTXkxczBpRzBiNlFTbzNwRGJC?=
 =?utf-8?B?WFpMU0xpQmFwa0ROVFlHNVVhK2VNNzJEdFJYZVEzOXIrVVVKRVNtc2lOajNx?=
 =?utf-8?B?YitwdEFRU1BNblFxTGlGQmMxd09JaXo5UDNBd3dhMVIreENjdTVIeFFUclBW?=
 =?utf-8?B?amFqelR3NkNuY2UrWGNkaEMyaDJISmNFQkFSMnFxRTB6UC9BYXpiWDA5OXhV?=
 =?utf-8?B?NTJNb0J0T29iR0MxVjJJWVdSOUw2aWlyam1WTm44RzZlY2xDVzFYY1VjWmFI?=
 =?utf-8?B?bTFmaVlHZXJGSnl2Q2diNWIzYUdWYlNWa3orcURtSmNuM3hDcWtjTHh2YURk?=
 =?utf-8?B?S0pDNjdXK0NQUkd2SHVIekVZdGVLSXhDTmVCK0pPMzE1N2RrV0hUYnErNjFz?=
 =?utf-8?B?NTlObURCYXplTURneE54SEdWSXRkNXNlNDA1aG9tcDFBWHg4Yjc4ZHV4SWF4?=
 =?utf-8?B?ZUVqdGJIYkZlOW10VjQvbm1ZWUlBNUdVdFh1Q3YxMVpPcDR5bWNXK3M4anUv?=
 =?utf-8?B?dHRKcmlTbko5eUFLcFpVUXZWazRHbTVaWDB5T1ZVaEx4aHQ4VEtjNDcxYXVp?=
 =?utf-8?B?TElRdURNRVd4M0s3dkcwbk9LcUVZYTZrQU9hQ2N0L1VMeWJCaUw4ZzB4TmZi?=
 =?utf-8?B?MWtqdWZsazR6VVJScjMxVEErRi9YUDduOXRlUG1pT1FwRi9JWU1MOWJzOEtX?=
 =?utf-8?B?MlQzcmVMRUJqbWg0eWxlZDZXbU1OSU5PbWppYnlVUWlMbE1NMWxGeDdGZWtu?=
 =?utf-8?B?OEtsMmowQWdwT1lVT0lLeEhLTmprdzZ2M0ZWekRSSDlEL1RRbEhHSTVseG1k?=
 =?utf-8?B?ZjlWUXY0T2FJd0tTTHQ3L0ZPbTVPd3J0T3I4WDFLLzN4Qi9yb1Y3OFNhSGVp?=
 =?utf-8?B?WHJEWWd3Y2Q2SmhFdTQ3Y1FTWlZIUkl5Qi91YWR3RGQ1d2JsT1dWQ1N1VlRT?=
 =?utf-8?B?NFBLSWJsRHhyL2lpZFRxWXd6Ym9GOWpIZnV0MDhlaGdpMmNQb05vV2RqYzV6?=
 =?utf-8?B?OGU0dVI0NmJyYTdWOFgyby9ENGV2L2wzbmk2MkRkSjRPdnVlc3FNSU9ha1Nt?=
 =?utf-8?B?NUVwYXc1TnAyd045dVVqNTRYMzZDWVduK21DU1JaVTM5T1hTR0xLakVjTjJO?=
 =?utf-8?B?UE43QlVvTWNjMThVenhqK3AwY2gwSThHVnd3dFV5SVlvYm5Sdm03QWhmS25H?=
 =?utf-8?B?L1BWOGcyT0J3NmtxVDI3VEFGY3V4RmFXUndIM1ZOdVpvNmVNU3J0TnIwNm04?=
 =?utf-8?B?dnFRRzFpNm42ZkN1Mk5EMytKNkNPc1luZCtGK0ZhN2U2SjVYR1FBeEhzZmVn?=
 =?utf-8?B?TWF4d0VtZExndFVyM3IwamIyTGVrdFJOakJweEVhdUpMZ0RnMXhkL0NOOGZB?=
 =?utf-8?B?dU40MnFQL0F5VTB5amR0WUJHU2w2NDY5c1U2L0VoNlVWLzNVSnFYb1FtS1B2?=
 =?utf-8?B?Q0pUaGxXeVBEV0tvRm85R3A1VWJKRG9mcEVjUFNrY0xXWm45TEwvdlAxSE9z?=
 =?utf-8?B?aHlUcUNuSVNMaDRsajlJZjdqYjZBZTFzK2FsTmk5TUpjWU9LYU1Manh2bEo4?=
 =?utf-8?B?MHF2L3kza3hTSHdEbDJwRWx5Z1MvQ3pGNmdRbXFEd0VFOWtJMXV5VFMweHdr?=
 =?utf-8?B?RlV4U01OSHpkTk9jWU9RVFhYU2RCTDFSbVVXTkRqQkF3b0VQZlp5Uk03aHVV?=
 =?utf-8?B?Y1ZUOU9FNzBrZDFNOExSQ0RGRXVPQ2hrZjhsaVBjMEUzQlBOTEk0MmNOT2kw?=
 =?utf-8?B?c2FYSUFvRnhQS0VYaEJhaSt5VWxwMU1EcWM0K3Y1WlQ2ZTg0RE5QZGQ5MTdD?=
 =?utf-8?Q?+apWaOo0ck4w7m2J9q/XKzWUk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5088639a-0d81-4912-9ffd-08dcd8a285a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 11:59:31.9749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0NrzrCNTN2rIEyOsNuIJHxWgIfFZ2RNBUng18DkdiaVAQ5S/V/LnBSbx8Z1g+yZo35W3r/A8l9wiHrnloTtdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8041

From: Peng Fan <peng.fan@nxp.com>

Allow overriding the cross-comple env parameters to make it
easier for Yocto users. Then cross-compiler toolchains to build
cpupower with only two steps:
- source (toolchain path)/environment-setup-armv8a-poky-linux
- make

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 tools/power/cpupower/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 6c02f401069e..e2a48af6fa2a 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -86,12 +86,12 @@ INSTALL_SCRIPT = ${INSTALL} -m 644
 # If you are running a cross compiler, you may want to set this
 # to something more interesting, like "arm-linux-".  If you want
 # to compile vs uClibc, that can be done here as well.
-CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
-CC = $(CROSS)gcc
-LD = $(CROSS)gcc
-AR = $(CROSS)ar
-STRIP = $(CROSS)strip
-RANLIB = $(CROSS)ranlib
+CROSS ?= #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
+CC ?= $(CROSS)gcc
+LD ?= $(CROSS)gcc
+AR ?= $(CROSS)ar
+STRIP ?= $(CROSS)strip
+RANLIB ?= $(CROSS)ranlib
 HOSTCC = gcc
 MKDIR = mkdir
 

-- 
2.37.1


