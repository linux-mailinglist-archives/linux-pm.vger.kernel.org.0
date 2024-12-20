Return-Path: <linux-pm+bounces-19563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 742BC9F8E3F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 09:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C468C16C578
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 08:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406E21A8404;
	Fri, 20 Dec 2024 08:51:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020102.outbound.protection.outlook.com [52.101.225.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB21A3AB8;
	Fri, 20 Dec 2024 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684685; cv=fail; b=tQ1jyU5OvRvB+sOa3LCZPjOCP58qLbRBqLRTYRrBviT0K+kHsBUXTJQLvNyLyuKThFaSdMsd/05XKA1o3yRLBz8xKIxkyTfgR76OFXZKNO/nQmbKzD9GgTWC3grtOux/oH478/n/4kxE9z1oF9zNE+SQlnrEuQbMv2+AhcUDkhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684685; c=relaxed/simple;
	bh=9sGyP4U+ig+XyUedWAeqlgUQVPu3O3VwW2pjOfe+hRE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sJYFqexdx8MimPPqeyoX7C0q3vkcAThZ5kuK/iUDuzMa5bgpT5wNG1AN0O9IAoOMe00jR/ALQE5pVA5MLpf5DzG3E5cd5f15eqIHIC/UVatSnd/xrEuBQG7/TNbZHqZImZ2jvF2yPrVbKIHu790WMV9iaTa1WyS2fiqa7dHBnnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xa4AfZcVNFfhacx7O7jK76JFlAkgFHmForM7cvhHkEoT2tf4G+7VXMdOzYuiU7gaG+vFZPwPrcDPqY+sbmOQtNrj86rc9eqfOr9e7EhvSGX92SHvOzTvaPg2IWxjKslqb4+E76IIz8apdqk7dg8vWWW1Rb1odYAyol1IIRssND387dpNuHpJSx2u7p1Fho3U0C6s/OyingSYQgKh31dHI9NTv4K8HhcoFFAJGmS894h7cCwdnOXdp3OOrPsx//LizwpBVe9OG94Tt+lJN6l6pP0OIpDYs3DfoB9M9kk4al6+h76PBcrgitZqYUt8XYfitHIzdkvcf/GjaMDM7w2A3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFX78gU7jDK6zjtSB4OQUyezIjG6wWJxf1yn9Bl8+w8=;
 b=a0BMienUvKPhNctui6PzZmNl2i1DTOwQXoRzPyg5U+eYOV8jqGFOObYWGmbAwR3rLOEwBa2toXKQpu4gZwxRqkrib+CumQAR+uqRBXjnRa6KmWexetV5TdfbUDMm7kwquLKNE9aCSx7fpyo4ejWUCRpYDl+xCwwUBIvacNFBnIbylAcIVfOQTD90WCCsQA5UgorQyvWicqBj7h1JTcSR2ML2iGsElEk6BRu9h0ZuNAi6KWO97SdceyvO5qhl3Y4gXkRg+lCo7X1/e10l1+B7IGU0TvMrZ5cWf96OS8Szvr2DXGpCUX8/27IwAK7Lv26/r36QwvUVzus3ntHVkxpVJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN0P287MB1045.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 08:51:19 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 08:51:19 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: tarang.raval@siliconsignals.io,
	Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 0/2] power: supply: Add STC3117 Fuel Gauge
Date: Fri, 20 Dec 2024 14:19:53 +0530
Message-Id: <20241220084958.32367-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0254.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::20) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN0P287MB1045:EE_
X-MS-Office365-Filtering-Correlation-Id: 776dd8e8-2cd1-4c60-07ff-08dd20d3786c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MndSbDM1cHVqNzkwSUpudys3NTNmM2JNODQzTHNUKzFhQk5Ud0Ezd2JLSmZB?=
 =?utf-8?B?VEZ3RExPUGJiMnUrbmgxRlZoZEk0bkJDUjgrcXQ2ZTh1OWpzME9teWdWZVZW?=
 =?utf-8?B?NTk3ZUNDMkxjWUJ4ZWdDSUs5b1h4cDE3S3J0YXl1Qng3WUhIL1JROFVKRWtM?=
 =?utf-8?B?a0svVEMwbE9DQ1NZU0M5dTZBbVJyMW9INmNORlhLQmprenlJV1lUSGdXeUlz?=
 =?utf-8?B?N3VWMzNHTWQxRFQ4ZE9iNmlYUlVqdWpxTzczWWdncTJFNHU2ak5BK1U5NDRy?=
 =?utf-8?B?QWlGRldLU0svaGpNZDcxY3Rnb3oyWmo1OU04dVl2OHo0MVBJbEFOYlBNQ1J6?=
 =?utf-8?B?REZLYkxycHhkeEw1OXZ6Wm1MbzU2ZnNsYTU0SVpCZUtKUGRFd1FKdGdMQ3hQ?=
 =?utf-8?B?RVhEa0tmVmpOQzhGTUpUZUthVkh0TUxyc1FrZ2h5UHdkaEZIOVJSN21nWXFi?=
 =?utf-8?B?amU2aTZGSVFpZlhkd2w2MnBUa1FDbXFGT2hkQ2tIWlprRE9UNGxaUTJqNU43?=
 =?utf-8?B?MHh2M3BWb0lUcVBBY1JnK0tGVDIya244SHNTS0lYY2hoNUhwNkN4QmJ2QWd0?=
 =?utf-8?B?NUR2RGtPeVVNODJ4eTBEdXNPckttaXhjS1hScnNZamVpNGJObkZwZHlWUGtD?=
 =?utf-8?B?NWJ4M1FiTk9zbExIWEZXR0JOSkxCdWw3OUZLMGZYS2FEcVlNcDNaSTVvSWd3?=
 =?utf-8?B?NCtiVnJWeCt2TW1WMWVMUHdrbmhXVC9MVFhIOXVsaVoxdHpLbUxSeUNwbGph?=
 =?utf-8?B?d3RuVXdHNkFQM0x4Y2ExelltNXM0K3BGL2Z5R1NpYTdzVWpZdEs1TEp4Z1Fi?=
 =?utf-8?B?TWNUdWVwWUY4Um1HWkg3ZnR0MGt0a1NJYVk4TDYxT1FhTGlQRWFPQzYxejMv?=
 =?utf-8?B?OUxxZ0Z3dXdUMnh2TktUQ0NrUGFIRm5NT0ZqZ0RhbWVaQUtJRGdDbWx6UUlJ?=
 =?utf-8?B?ZEhUNmVJK0N4akt1VFZDemlMT1ByTTlNU1VsMUpFbHNZbkJ1aWZzdmY2MW84?=
 =?utf-8?B?MkhtNHUwQ3lqL0RSc1M3RDI1L0pRWGVxVDhWbWNET2VSa3F1UlZ1ZE9VUU50?=
 =?utf-8?B?L3pmQmtiSHBtWXM2Sk5kSVBaMlZSUDhzRDErWlRuOGQySzlEeHlIdG0xVFhj?=
 =?utf-8?B?M1RrTHJNN0V4Zk8razAxeDFsVUV3MzZid0lpTk8wci8yTkNZUjJpVDJlN2lG?=
 =?utf-8?B?ejJVazBIOEtsUVdML0FBSjRyZU9HbSswN3FpaXJwU3NLUS9acmlCSU1IQWVO?=
 =?utf-8?B?Yit2QUtrNkNNTDdtcGpobU5IOVVUQ3Y2THFyV0F3RDQxNVQ4L3A0N1BQNFFz?=
 =?utf-8?B?eWwydTcra3VOUm5LNDd1alVNMEpwYzZBa21zSm9ndzhMZ1U2MGhCUlRaNVg5?=
 =?utf-8?B?RGVYUFN1SkxlZ2Y1WVFaN1FZeXdLcG04dS83RWV5aGFSZlpCTGtRRDVXWXBM?=
 =?utf-8?B?MWIrOHVsSXF2Mjl5K2lrcnprMGFsbFRGbmpEMG9UMjh1ZnN6bXh1TXJ4dnU2?=
 =?utf-8?B?U1lqK29pZ0ZpUjNXcUdNcXRoMjhQZmRnSjY4UWQyMjU0QkNHdHhoUCtwb25w?=
 =?utf-8?B?ZVA1dGtoWEtaWVU2RitsZTJkRmczUktzWjYwSXBCM3dpVFBLRXhmekt3cDBT?=
 =?utf-8?B?b3FxUzdhN1F6dUdNOVJnSkcyeXRicStRbW1yYWpCbHVuQzRaMXBNRXQxQXVF?=
 =?utf-8?B?ZGV0RGtsNi9renRCY2I5eVlHOHQwTEU0SEd3WmloUnMwWC9jdXZkUHNBTnRr?=
 =?utf-8?B?eUJBUEFGWlh4YjE3Zjh0TkljajkzTnlmTi91YjBSUWlKUnh5a1d1NnRDRExi?=
 =?utf-8?B?RU52ZmVMdlJsWndadlVTM253VXRCS1BtcDhzMWM0bjBDNFFaakpOcDB3OEFm?=
 =?utf-8?Q?LFRkVcllUQ1kb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmtEWlBJTW9YNWpVQXVFWXZyOHVkaHpiMmNoMWFtTHdROExQUjduc2hFMEdD?=
 =?utf-8?B?ZlpNS1VkdkVCY3JFbkFVOEp5MmhsZ3VDcG5NdG1xTVJUU1VwSUgxT2JPcVRD?=
 =?utf-8?B?T1pSMFFUM2pSNm4zc0NXR2ZFMmFtNFJETmFzei9vZEl0Z1VzZVUvYlU0WTdm?=
 =?utf-8?B?aXdUaUVjY1Q2UVM4RTV0NnhNZFo2V0cxMjFvTDZ1TmZkL1NtUVVCZkRPaEo1?=
 =?utf-8?B?UWVRcENRTW9iVlZ0a21jdkcxdXlaSVpFb1VpbTJybFFlU2gwbmFSaHAwUTZI?=
 =?utf-8?B?cFNzMFBoRzl6TEZraFFYSm83RDk1bDZ4b2JKK253aUtXZ2xBejgrSEkxYnV2?=
 =?utf-8?B?ZisxK1ZDVU02RWRONWZYY2RlM01TdEo1emQ0MW9tT2lSVWYvWkVGL09qTG1z?=
 =?utf-8?B?elh1eWljYlpTeVUya25BMmM1ZFN5cndZRnFtQUZVeitxNFFoa2FWbnVXNFpq?=
 =?utf-8?B?K2YrUGhpWVpUQWNiTDdzWGJsNTYyeXlKNFNEeUhVNEtacG4zaGlMMnFlQTBH?=
 =?utf-8?B?SjhmNHhUTE9HNUYzOGFMU2pzRDM5THNqTWN0V3dzQ3h3cUFuakFxcjZ4L21U?=
 =?utf-8?B?aUtxUE1NN2E3UWdwZ0ZEeUNaWFgvbDBEVjJOck1Mc1dTaWR5ZUJRUUs2S1VR?=
 =?utf-8?B?UUxIY0ZDY1BOYlZBL1RCUnhnUVlJQVpBVEY3UzBTN1NjYlM2b3pPYnd2WlI2?=
 =?utf-8?B?d3owUDZYZHhYeHhncGVUdUNETHdhdncybjRGZCszcU5iRFlWN2R5bmhzd0hM?=
 =?utf-8?B?TGdhdWJ3TEtFd05HREZ6Q1krSnFhM1ljN0NCZTFWQkxCR2psb2hvWWV5TGZu?=
 =?utf-8?B?c1prdmpRVnpxaHNDdkdvaEtFQzdZUG1ZTS9hd0QwZC9nY2U1aElxRWdEWWp4?=
 =?utf-8?B?b1pUdjdsN2x0ZG1FaFNTSGV5cDF1a05kTDZtZmRpVnI4QVlYNXlaU0VaUG83?=
 =?utf-8?B?Q0kyRE5jc3JwcGVjWFNaMElmUFFGQlFESy9PUk1vQmVOTDRCSG5RZ3BWams1?=
 =?utf-8?B?NytLMXFsYmJmR1JZSEx5NUhrRklhVkdmbjZDZUZmUjFuWjhUNXp0RHZISlNP?=
 =?utf-8?B?WTRXSitMSzU3YjVpQjMrVVBldjdzakdXS25UVFczWVBBZVZwRGt2LzBJWUdp?=
 =?utf-8?B?c0NsekcyWGJIRWVFdHAzSU1MdUY3ZDhjWjRWY1BjdlVoN216eEIrYTdhSFhD?=
 =?utf-8?B?MEJnRkdUemd0RFF3clIrREgrbDNEYnMzMDVFam5hTTFjenRoZXlxWCt3Kzkw?=
 =?utf-8?B?WkJGSFJmYTh6a0J6OXYzRlBDaHV1YjRneDcxVG9OQ21tQmpuUU9WMVpYeVF3?=
 =?utf-8?B?NHdsL3pKcU16SnJBOHNMN0E5UUQ5RFVpYXlrY0xDVUpmdkgrTzh6V3N3NHBh?=
 =?utf-8?B?RXpzQ0dKVnRDb3FoZ0FpWFZDMUVaS1Mvc2RTazNrdmRPdHFDc3NMQUhISUNY?=
 =?utf-8?B?SEtuUkV1Ly81Y2w4TzEzYmZTZ2FqaUpQU3lBY2NHdllIWldkdytpY0cyNGtH?=
 =?utf-8?B?aGJnVG4zTTBOaXVqY2ZXRjhJYy9KSGlwT0NNUUxrK2FDWmxkUGZDU1JIeWZP?=
 =?utf-8?B?N3lnOXVHVzg2WUxHYTArUXNPR2o0K1Z3bG9DYVByZUF6czd5ckNOMnV3T0s0?=
 =?utf-8?B?cGYyMnE1ek00U09IcjJxRXN0Y3QvRm9OZkdFc3lVa2hBSk83ZTVyUmhOMVR6?=
 =?utf-8?B?R0ZTNmJKMExNeFd0bFJCeHM0L3FaMHlmQU9ZSjNHVllBZTgzanY3RXdxeGho?=
 =?utf-8?B?NVBBWHdLNTFOL2g1cC8xMGN6TlZvc1N6Rm85TlBnVkRkeklBcnhiV0hub0hh?=
 =?utf-8?B?ZDVYU2RnaExkc2ZiZ2NTRCtPKzR0aXlJRGNYME5wN1ViUGlqTWFDL0JGbWI4?=
 =?utf-8?B?WnM2amxpRjZuWW5DVGpod2ZnNSt4T3dvUUpja0orKzE5TDZuYVhGY3VNemp5?=
 =?utf-8?B?TDUreXNyemVnUHVtRnBlQjRZd081K3VLdThmZkd6N3NoQXYyTDZ5VDhlUGVR?=
 =?utf-8?B?M2hIUG5qT1VhUDg5Qjd0UG0vRDVLdk9vMUpGemdsaVhlNnNzc21RUTlsOWdx?=
 =?utf-8?B?d01QV2NLY0FjZUIzdDhWL2JYcFVhMTh6a3BybEtXNS9GbHYwZmNGMEJWaFZ6?=
 =?utf-8?B?UnBDdXhZczNraUpkbnBFK1B0TWlGU0RjVWw5eWxqY0ZCU0ppUDhUbGFtMFlk?=
 =?utf-8?Q?iQNsCZi9ROmm/t706Nk1tOM=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 776dd8e8-2cd1-4c60-07ff-08dd20d3786c
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 08:51:18.8499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnB9N6OOmXd9+R/az0czC50TcG0gRInVw/aYGvWPtYInZuOiDNzIDoXF4iTZBGWOs3AkCpltPT6ci1IcZm3ibJlcT72Ca0Q/KO6HWnymAVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1045

Adds initial support for the STC3117 fuel gauge.

Output of test_power_supply_properties.sh

TAP version 13
1..33
# Testing device stc3117-battery
ok 1 stc3117-battery.exists
ok 2 stc3117-battery.uevent.NAME
ok 3 stc3117-battery.sysfs.type
ok 4 stc3117-battery.uevent.TYPE
ok 5 stc3117-battery.sysfs.usb_type # SKIP
ok 6 stc3117-battery.sysfs.online # SKIP
# Reported: '1' ()
ok 7 stc3117-battery.sysfs.present
# Reported: 'Discharging'
ok 8 stc3117-battery.sysfs.status
# Reported: '30' % ()
ok 9 stc3117-battery.sysfs.capacity
ok 10 stc3117-battery.sysfs.capacity_level # SKIP
ok 11 stc3117-battery.sysfs.model_name # SKIP
ok 12 stc3117-battery.sysfs.manufacturer # SKIP
ok 13 stc3117-battery.sysfs.serial_number # SKIP
ok 14 stc3117-battery.sysfs.technology # SKIP
ok 15 stc3117-battery.sysfs.cycle_count # SKIP
ok 16 stc3117-battery.sysfs.scope # SKIP
ok 17 stc3117-battery.sysfs.input_current_limit # SKIP
ok 18 stc3117-battery.sysfs.input_voltage_limit # SKIP
# Reported: '3577000' uV (3.577 V)
ok 19 stc3117-battery.sysfs.voltage_now
ok 20 stc3117-battery.sysfs.voltage_min # SKIP
ok 21 stc3117-battery.sysfs.voltage_max # SKIP
# Reported: '3200000' uV (3.2 V)
ok 22 stc3117-battery.sysfs.voltage_min_design
# Reported: '4200000' uV (4.2 V)
ok 23 stc3117-battery.sysfs.voltage_max_design
# Reported: '206000' uA (206 mA)
ok 24 stc3117-battery.sysfs.current_now
ok 25 stc3117-battery.sysfs.current_max # SKIP
ok 26 stc3117-battery.sysfs.charge_now # SKIP
ok 27 stc3117-battery.sysfs.charge_full # SKIP
# Reported: '3000000' uAh (3 Ah)
ok 28 stc3117-battery.sysfs.charge_full_design
ok 29 stc3117-battery.sysfs.power_now # SKIP
ok 30 stc3117-battery.sysfs.energy_now # SKIP
ok 31 stc3117-battery.sysfs.energy_full # SKIP
ok 32 stc3117-battery.sysfs.energy_full_design # SKIP
ok 33 stc3117-battery.sysfs.energy_full_design # SKIP
# Totals: pass:12 fail:0 xfail:0 xpass:0 skip:21 error:0

v12 -> v13

- Battery information and RAM data add into struct stc3117_data

Link for v12: https://lore.kernel.org/linux-pm/20241219094915.19059-1-bhavin.sharma@siliconsignals.io/T/#t

v11 -> v12

- Removed direct scaling (* 1000) in userspace property values.
- Modified stc3117_convert to ensure proper unit conversions.
- Returned -ENODATA directly without scaling.
- Corrected Singed-of-by & Co-developed-by

Link for v11: https://lore.kernel.org/linux-pm/20241216070457.8083-1-bhavin.sharma@siliconsignals.io/T/#t

v10 -> v11

- No changes                                                                    
                                                                                
v9 -> v10                                                                       
                                                                                
- Use error code instead of arbitrary values                                    
- Use Co-developed-by tag                                                       
                                                                                
Link for V9: https://lore.kernel.org/linux-pm/20241213063813.32371-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v8 -> v9                                                                        
                                                                                
- Corrected the error message                                                   
                                                                                
Link for V8: https://lore.kernel.org/linux-pm/20241210080954.5067-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v7 -> v8                                                                        
                                                                                
- Add output of test_power_supply_properties.sh script.                         
- Change 0X to 0x in macros.                                                    
- Fix typos and Specify units in property comments.                             
- Remove stc3117_update_battery_status function.                                
- Convert voltage and current from mV/mA to uV/uA.                              
- Represent temperature in tenths of a degree Celsius (1/10 °C).                
- Export average current and open-circuit voltage (OCV).                        
- Use devm_delayed_work_autocancel.                                             
                                                                                
Link for V7: https://lore.kernel.org/linux-pm/20241202094328.14395-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v6 -> v7                                                                        
                                                                                
- Removes extra spaces.                                                         
- Fixes error handling.                                                         
- Fixes the logic for checking battery status.                                  
- Fixes typos.                                                                  
- Removes unnecessary commas.                                                   
                                                                                
Link for v6: https://lore.kernel.org/linux-pm/20241130094531.14885-2-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v5 -> v6                                                                        
                                                                                
- Use shunt-resistor-micro-ohms property instead of sense-resistor.             
- Remove the battery node from the binding examples.                            
- Add interrupt bindings to the example.                                        
- Correct the Signed-off-by (SoB) order in the commit.                          
                                                                                
Link for v5: https://lore.kernel.org/linux-pm/20241129114200.13351-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v4 -> v5                                                                        
                                                                                
- Fix variable names                                                            
- Limit code line length to 80 columns                                          
- Add interrupt and monitor-battery properties to bindings                      
- Correct error handling with return dev_err_probe()                            
                                                                                
Link for v4: https://lore.kernel.org/linux-pm/21c08a45-34f1-443c-97d4-6baf9fa01b67@kernel.org/T/#t
                                                                                
v3 -> v4                                                                        
                                                                                
- Added support for current, soc, temp, and status properties.                  
- Addressed comments and feedback provided by Krzysztof and Sebastian.          
                                                                                
Link for v3: https://lore.kernel.org/linux-pm/20240205051321.4079933-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v2 -> v3                                                                        
                                                                                
- Resolved DTC warnings and errors                                              
- Formatted the changelogs                                                      
- Added monitored battery properties                                            
- Replaced 'additionalProperties' with 'unevaluatedProperties'                  
- Replaced '&i2c6' with 'i2c'                                                   
                                                                                
Link for v2: https://lore.kernel.org/linux-pm/202401080530.0hMWnrIg-lkp@intel.com/T/#t
                                                                                
v1 -> v2                                                                        
                                                                                
- String value is redundantly quoted with any quotes (quoted-strings)           
- Found character '\t' that cannot start any token                              
                                                                                
Link for v1: https://lore.kernel.org/linux-pm/46bba29c-330d-417d-ad84-ceb5207fdb55@wanadoo.fr/T/#t

Bhavin Sharma (1):
  power: supply: Add STC3117 fuel gauge unit driver

Hardevsinh Palaniya (1):
  dt-bindings: power: supply: Add STC3117 Fuel Gauge

 .../bindings/power/supply/st,stc3117.yaml     |  74 +++
 MAINTAINERS                                   |   8 +
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c     | 613 ++++++++++++++++++
 5 files changed, 703 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

-- 
2.34.1


