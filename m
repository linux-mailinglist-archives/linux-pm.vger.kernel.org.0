Return-Path: <linux-pm+bounces-28448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE34AD4D7D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDB73A550F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 07:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1992B23504E;
	Wed, 11 Jun 2025 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j/t+hwCP"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012058.outbound.protection.outlook.com [52.101.71.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A8C22ACFA;
	Wed, 11 Jun 2025 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628471; cv=fail; b=rjS4wa4JetQo3AUsygWsSQ8BHYVbgWfcnPiPLISgiK/27mA20F1qZoUXt2M/dyoDjxqunJn39TWTbP/Wde0AhaOTBwwztifxhE9CWYpzswIML1cL8/qJ3cWdtmM4k/isdwD/h6fZLxXgFUgECUtowNMwbBfe3djsIRd9AfDdFhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628471; c=relaxed/simple;
	bh=1UWcKV20UeAZBooCibNBAqAJjkV1w18enL9dvXXG570=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=kEQnR7hcp4VU3E/RADoc8tulDCg6vvTQ91GR+2CRQSrJu65lab48rLO5ito1Li6Lh8ygYjXiEAYj3N/DQMm7LmZCwE1DW7SNUD5JMvZqzkcCkqO0OPQmDI5csjtVIxqcAMA1alCSp28oAh96Jv7KHN60JWItVn4wF5HoLLGSZWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=j/t+hwCP; arc=fail smtp.client-ip=52.101.71.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouU84yrazX0HidoNBo+LN4p5laFhgkOXitljn0tAHwYAXX1lMZnK3KF4ahd6aMQjWEqZf6pw5ihKfOuqKDeSEIsMA0rLWjZ2hqfF7KeuBrZRgV9gkPb/CDhPqd9pTlngglo9F4FuX/+WQK6JX1WJhEfgmBfi3WcdTURrxKfyz8RtSmeNwU8zpWNVw7UlbX5RdT0D6SWLW+pNy3cQPn8y/pxxw8Wc3wGKFGE/7OKfXMCT4NvBezOOuluX3+RzLf1dzO5C+SH5IJDvX5rbHZGxKJqOQE7IcYkM4qLODA4WmGQpdX1JqcclvaEZgoVmWEQnKmVp4Irfli6SnvRP+ukuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgvEy2Q8BwI3xsFk0r/tu3dySdzpYVgDUbHgRbct64Y=;
 b=rnzz+zTLTW8EHIzDqxZD/TOcxjAPxKmcZFEKUldIdHemIvyasa23lC9TMRMJLqFYqFdAK/BKd83a6a/x6a2tuc+xSI8JOouAaDwtioZ5SnUYGAFHY1LtXtCEF6EU22p0fQmUtJT/0zUlaEWg4oBtipKIo3WQdPOoSkoxHJvrur44016er4JMcRGuQTIPV30jTimMtf1TfNNuCQzs7a9PeFfBj+AijO3JSueKBQGCTamzwVO+oLVYqs4XtD6FfF4eMEZ6FOmMY8pxQzkhpzs7QcmRN55gOfWxj6AKQqJsOFO0pryaM53A18ZHfaT0NvsdZI6MCsAUYpbVb2gQTZJz9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgvEy2Q8BwI3xsFk0r/tu3dySdzpYVgDUbHgRbct64Y=;
 b=j/t+hwCPsGZisL3LtCYrCoLPyt6NmN28FG7eR96LkqIT1rcjkhd9DC7fjYO4JvPyCuD191XKqouKdgoPphKTrmwtYk4rCI+a0HE5j/9oJ1OmIEwzpMdRs2jPFWEAV5rYo845TFhzK3YKoHNP5QvH00kCFYIOipXHEFnW5u0OSg4cJf4pLa9VLyiRN/TScfdady2jOY1J0GqX/y+6JDhjyenWSleNFKuNLjV4WBOXyKaYRlRlHf9dsljPaCNz8S/9s/MPnA35pekLH06eIXB/BW+Ha8NpxWXWu2v5QVFt7+bfVa+RY9Dgn+3Lw9Hce09ENfE1je3gasvsBWlE7MB0+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8346.eurprd04.prod.outlook.com (2603:10a6:10:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 07:54:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 07:54:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] firmware: arm_scmi: perf/cpufreq: Enable notification
 only if supported by platform
Date: Wed, 11 Jun 2025 15:52:42 +0800
Message-Id: <20250611-scmi-perf-v1-0-df2b548ba77c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMs1SWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0ND3eLk3EzdgtSiNN1Eg5TUFItE00RjA2MloPqCotS0zAqwWdGxtbU
 ALqHBa1sAAAA=
X-Change-ID: 20250611-scmi-perf-a0ded8a5a303
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749628374; l=1170;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=1UWcKV20UeAZBooCibNBAqAJjkV1w18enL9dvXXG570=;
 b=b31HGw7vcLczDloDefDQRg1dipfnsGU+4thLPcvgozaWSpOFyrDc08MD1NzpZv+0MNE3WqbgI
 rAWPqoakiSSDfi/DsJitU110IwWihDzOd2U7XUboAqikuny4Hyi5aMS
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: a426ddcb-869e-4a28-d923-08dda8bd2f0b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDVBVGhCV2FKNDJRd3Z1dHlGZ21PZlM3cG8rVThQVzI3aFB4RG5wR3RKMGZa?=
 =?utf-8?B?OUo4UWRJN2NWUFc1cUNpVUd4Y3I4ckFURzYvaW1hQ3M1M0FPZHZuZHgxZWNl?=
 =?utf-8?B?dWcrbC9sS0N2UlpxWHM1K2gxZndwWjJRbmJBa1lyc3o2V0V1N1h5UjZjcmkv?=
 =?utf-8?B?NEQxWXhLRVNaVU93bjNCUHVEdllrVUxlMy9XTW9ob1JxM3ZGWEdZeEZvSjUr?=
 =?utf-8?B?R21uQkNIN0hvWGw5aVJzUnR0R1FYZXI4eDlSaHJSc0tFQXFsWVM5ODNYbnVi?=
 =?utf-8?B?RDJXeG56eEh2dUc4dnFtZ2FHa3FteExzSVIrYzNlRzRscUYrcDNlODE2ZW4r?=
 =?utf-8?B?OFZwYU1URlI2dDZSdmFMQ3ZNcHgvTnFwRGlEVDYzT2VSVE9hc3RnM3hBVjZD?=
 =?utf-8?B?MlBLbTdRcEh2Sy8vOEk1R29LUklaQjc5aGdzajJldmlPSml4NHB5YU1JcnpK?=
 =?utf-8?B?SFUvcWJlU2tQUlJtUytPRVVCVzNCcTVTNVB3Q1BuYXRNbnVTSWtWZmNCVXY1?=
 =?utf-8?B?YTlJUEtxZnJqaFVUV2xOVk9vM2lzcTJ2L2JLaWo3QWNPWThQSTR6b0xrcWZP?=
 =?utf-8?B?R2MvYTFDTTV5U2tkK0xleXBxSVpLR2FybDRLWHNMcFExNVd5V2h3aFJvN09Y?=
 =?utf-8?B?TVBZRWcyUXhabVM5SzJBT0tmWnFnWmZ5Y1F0dmkvSEhNVUtNRXk0SjdwWnZr?=
 =?utf-8?B?cTFSQVIwczNOVll5OUNKUnQ5MjkxYXhCZFI4bWVnd0VSYW9XM29INkhSYmJK?=
 =?utf-8?B?c056b1pQOVNDUHFCOFBIUVd6VmJ5NWhLdnpSYmRBTlMrOUFZOVpQNG5zanpo?=
 =?utf-8?B?OERoTEpndmRCWTdsVmQwZDFPOHYwcnowbUpzVmlKa3Evb0VweFU1NERJTUdR?=
 =?utf-8?B?QmkxelZzcng3ZGI5cFc4TDVVdGtmMldweEhQQ01qQ1NkQnJmOVphRHkzN3do?=
 =?utf-8?B?bERtdStNUW90K2xnZm1haVQzTTQxSkpoMUdrMkNBTHhJOVFaeHR2VWJXRitM?=
 =?utf-8?B?SGE2WjdTRVd6dElFaEpMT2xoc0hodFZQeFlYWWdmWWpQbjZPcmpWcldHSGRh?=
 =?utf-8?B?Q2U3SUtzYW8vdE9Pc1lBMWlOMG9zelZLeWtreDA2c2tnYk5sVlJEM1RTK2FW?=
 =?utf-8?B?SFd4UWFKTHdJSHFCb05CUTI3OHdQSTVyc0dVbk0xS1VvcCtNWGc3d0F4OFZE?=
 =?utf-8?B?ZktOWXAzQUNnMTN6N1B1WGhIZC92TXpka29YeUNONWJnVmxyR2RZTHdTMWxK?=
 =?utf-8?B?ajRpVHEyYUFJLzRtTWxvYUpjaHhHaTRBSGprQ0JGZ0R1NThtUkNNSW8xa0dQ?=
 =?utf-8?B?blozRmptSCsxbUJ3ajIycW5nbFhsNEorcDJENFRyN0pXRlNmdEVHRzBRVWNS?=
 =?utf-8?B?OURNckFSSUJHK0hmOXdaTFVKTk5aaTcyeU1POTM0RlBKZ0h4UVhMTUN5UTZq?=
 =?utf-8?B?S2p4WmhjZW95TjBWMVVCZERiVHVYK3ZFNnBhTWtNbTFkTzd4L2x4WU11a0gw?=
 =?utf-8?B?UTBabFBoQWVWRDhjYzljd0FPN3ZRcUk0S1MyWDBmak81NlRLN25pNSt0RnFz?=
 =?utf-8?B?cmk3ZFJhZXlFVU52aDZFZlVDMTVFVFdkYzk1aXlVZUIrdjR5OWtYaDFwUGVi?=
 =?utf-8?B?RjA4S0hKRGVpODZwUG53enhsZm9TTm1Nb0g4ckdFanliU0dMNVZ3UEdBKzF5?=
 =?utf-8?B?Q21NNVFCR1hCL0poTWJrL0NyUENWSlJieGYvdjlkL3RIZzUzTFpRdmJvS3lk?=
 =?utf-8?B?c3NQRXhDR3piSEJxQ3padG8rZnNZcUxEbUZwYjBlbDd6UUh4YmhvaFlvZm5l?=
 =?utf-8?B?QXQzbmlIN2JUMGl1d0V6djh4cEJNUVF6c1FaWnBEbHZUUlArWTBQV1hVM1hH?=
 =?utf-8?B?eXdIT3U4bE5TQlh1dHh1dTlLWDhZZWZRMm5obFNjUjV4OGlzYkRSZ2VlcVNu?=
 =?utf-8?B?Uys4cG14WTNvaURTNkVRd1lGNWtjZjZOOFE1eUVncmNiczRISlBFNGYydGpP?=
 =?utf-8?B?MGZ1cTVUMmNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWdsYUZRT2RRWlRBY3MvQTdrLzFLUy9oNmtqbWs2ZWp5aTJrbEVTbGZTcEpY?=
 =?utf-8?B?T056OFF3NW1iTFhyb2xYWTdmM3JhQlJqbE5uNzZiNFBCZ3hXdkh6NS9TcXRw?=
 =?utf-8?B?Y3VrTTVzUmJ3NWNEYjA5TmoxWmNNelFkR01GOGlmaDVwRS9mazBELzFjUmdl?=
 =?utf-8?B?MndYSkVHekp2RUM5aTM2VGF5M1Yzc1RuSWpSVHVjQUh2NFJZOElpNVFzL0RM?=
 =?utf-8?B?V3l0VTE4cHlIT0gyZVhxSnBxOG1nL0drcDR3dXIxN0hrc0tuVFYzbldJT0JU?=
 =?utf-8?B?WnM5RWVoN0h5N2tHam9waGhQOUVBa0hGclpPeW8rY3B4U25Fd1lFSlNhVUNu?=
 =?utf-8?B?S1RYYy9UQXNheDU2SnVodXZIbDR1cXRSRHFCNVJYeWtickxVbm93SGZ5ZG1o?=
 =?utf-8?B?TUt6azg0QklYVno4RWFQWmFSUU9EaVh2TXQvc2txNTFMYVNiQnppOHNER2tv?=
 =?utf-8?B?eEFkWXlRQXhPMHJiNHZrNllrdVVISEhlMTMxa0FXdWxJb3E1RkxiQlp5TE50?=
 =?utf-8?B?OVpyUHRvdDRGTjJqYWxlZEVlTFNpMXhaV3drZU9jb1JBcnBrYzl0UG03VXVK?=
 =?utf-8?B?c0NWRVdhdVFVZ1pRbHVDa0tFYXJvQUFhUXFBeUF2YmFwUDlISWVYYkwzVTdU?=
 =?utf-8?B?VjRIZ1cvWU43OHJ2N0Uxbi9pbjQ3NlRhNzlQUXBSWXVpU0gzeWdycDRTMm1r?=
 =?utf-8?B?S0QrK2JVS3FQMUorWXNRbEc4QzU5cVJjTkRTNmRJS2MwajA5VDFIZlVRcTRW?=
 =?utf-8?B?RFF5QjhJVVROU1VxSVczY3JkTDhYbkN4UlhzNm5QU0ZHUDE2eCtveFJNdkdq?=
 =?utf-8?B?cXVKSnpmVzRzY0FBMlRXWldKeTIydlFNWTZ3OTZtM1BsTVRrcUlzOVNYV1I2?=
 =?utf-8?B?MDFvL0VsSzJXamJ6cFZUdHA2TU9pQlRSUU5GUXhRNEdrMGp3MWd6anRaM2RY?=
 =?utf-8?B?UW9UVHZyUzV0MSttMzJYWldpUFg1TFMxQkVibDRYQzRsYXFjenlJemgxYXNq?=
 =?utf-8?B?RklVcGsyZzVwRzhJek1zWXY2eG53TkV5bUNYQTNFWGo5K2VhbkZQNlMvUHg1?=
 =?utf-8?B?amN3LzZSWUlnOUtmQzB2SnlxdUlSS0V1OFZtY0doVFIxc1pxWTRpTjNneDJG?=
 =?utf-8?B?Z09hT004TElFUDBvTEozN0c2ZUE0TkpvMC9JM1VNVGNwd1JOa1lUMUdCR3Nt?=
 =?utf-8?B?VWVxOTk5d1FNTzBpOVBWc2x4SjhjWVVXbm9RNExmeDlrRyt3WEJSYVVKQmlT?=
 =?utf-8?B?aEt1dTUrUU5Yc291MnhyYVpvUkt6WGJLQktXVXlKTmV0NnhkN2QzSStvKy85?=
 =?utf-8?B?WG9KT1dLY2RpRnFFeStoQ2dIV3Q0aklpL09XTm9Jb3FHSGtnS21rWW5FdFFq?=
 =?utf-8?B?QnEwVTNPNlBOQzNwVitjejM2ZytzYmJSZjUrbDdwc2k1T2ZtVHloc29JSW53?=
 =?utf-8?B?RXVCMlZRTFp4dlFDMHlOQ2h6MjBXTGo5Tk5wb3dRWmRKZjZodUduNk9UVG1v?=
 =?utf-8?B?dm8rVkpvRVJUd1dQV29YdVVUTlIrMXdESmdsVTRGdm5TdGpySjh1YTZVYXQ0?=
 =?utf-8?B?SUlPdFdNYk54U2xNUjh2OVBKa3RVRG9kNXV3QThsTTNONmZrUjk5SzlRRTh2?=
 =?utf-8?B?ZGVTQWFJMVRYeWhVVHljZEJzWTRRdFR2cEYyOHZtMFFsN1o5MHdpZUFSN1o5?=
 =?utf-8?B?c29PTW1MTENXdUZyU3h2TmFTZFJCWXZWTGhrcFJuZGZUcmwvRnlOYmhJbmZS?=
 =?utf-8?B?RGZFTDRSektybEhvTkZwNkV5N2RCMUhuSkMxREJOZERRSEJ1enhFYU1SQks4?=
 =?utf-8?B?cmpwQ1Zqd1VlUW1Sdm05NkxSZllKclpWOHlyNTFNRW43MmJLdW0xWS81b1ZX?=
 =?utf-8?B?M2N6UGFCS0ZVUWFQUDV2azgyL2NBRUlJNnQwTGtlaG5PbjlyZkd6QUQ3RlJw?=
 =?utf-8?B?UUxFRTNpS0RBNUtrT0pGZyt4MkpLSHFXMzJHdU00VzRLaFFxOTBjUW5NSy83?=
 =?utf-8?B?Snlkd1VMZkxvbFlrajdITXRVM3JkK1lTcVZ1UVpKMFZRTTJtSUlpU09KemRm?=
 =?utf-8?B?WTV6WUVTOWUyWExaNUV1ZzhtTWRpOXppTmpxTDhzNnc3K3RIQ1NmR1pkRDJG?=
 =?utf-8?Q?eq92sSs/qFe+797+xqFlb5a2y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a426ddcb-869e-4a28-d923-08dda8bd2f0b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 07:54:25.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wd7+xYPducjmUSAhYPyOKlj4bafJeKAKrN0bwvQMzL0pbvzOVvw5EMgo9s/gAkh0f4P/I2BJTQGdkBZ4kjMftg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8346

PERFORMANCE_NOTIFY_LIMITS and PERFORMANCE_NOTIFY_LEVEL are optional
commands. If use these commands on platforms that not support the two,
there is error log:
  SCMI Notifications - Failed to ENABLE events for key:13000008 !
  scmi-cpufreq scmi_dev.4: failed to register for limits change notifier for domain 8

If platforms not support perf notification, saving some cpu cycles
by introducing notify_supported ops.

While at here, patch 1 is a typo fix when doing the patchset.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      firmware: arm_scmi: Fix typo for scmi_perf_proto_ops
      firmware: arm_scmi: perf: Add notify_supported for scmi_perf_proto_ops
      cpufreq: scmi-cpufreq: Enable perf limits notification only supported

 drivers/cpufreq/scmi-cpufreq.c   | 25 ++++++++++++++++++-------
 drivers/firmware/arm_scmi/perf.c | 37 +++++++++++++++++++------------------
 include/linux/scmi_protocol.h    |  5 ++++-
 3 files changed, 41 insertions(+), 26 deletions(-)
---
base-commit: 19a60293b9925080d97f22f122aca3fc46dadaf9
change-id: 20250611-scmi-perf-a0ded8a5a303

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


