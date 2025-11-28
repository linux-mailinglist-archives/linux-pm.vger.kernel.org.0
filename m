Return-Path: <linux-pm+bounces-38852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E81BAC90980
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 03:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A28F3344331
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 02:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E6C27B343;
	Fri, 28 Nov 2025 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dItY50fu"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7226ED3E;
	Fri, 28 Nov 2025 02:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295927; cv=fail; b=ZO5KJtkGCPTX5azRO1y7RVL/yEuu3N8QAX5Fsro89KZorWeILVpvb+pLn+ox7s9PzxDsr24ZdWb+yYv83DiXRBkqB4MVCVuUmPiP9fJWhsZZoE9cXfYLBNoR74V15JOGKqV7vUwMXrk++2Mkva1BDPcgb6CopXVrto2Z7xIb2uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295927; c=relaxed/simple;
	bh=DftiHYY8mS9FWhvDsznQU1xP4KjJpgtjJVo640v3YPQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ppgfPKp4ZVEiIMN1b6JccUJMh8aPR6rixavxhhl+H18XjMeuazgsf0vvLaHsuS+uPBrDhYJ9k+chQAiTd+TyuPLHoZUZc3Ts7bz2f1X8ilnHHIzK14rvGqsV+Ndc3FtZ8oldg0WigjrP/fFigK/EL4V4TtAMF12pe7ZjfM1U/2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dItY50fu; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knx44pPfMRGa1GW4cYoIrQL57Nql0IL9dixCBPkeUmyPXlrt7b7Iwf56Mgid4WisS5ombgdMVRemWGr8O+5PvyL+STpF/SchvzfkbTJrGo4jES6c/vSYrb52RgStEwJPA+Ia65lBsXNnF7dSFxVKSpmwkPAGQkat4/D8qQWRTI/Zc8gUri+PJvdQhHsbouF4cJSTrfNj0UBDwGkFuaUYTszSPUM+VyVKAYQ3mdeLwF1A+tGUfpw+ABfmsSZV+dINJPWJWoMlGELNjMR8OHbdJMdgS6zrOWO4osJk03lg2v2jum8k/eM6uCXPb0/CPnU7WHGX8Vz0LPB/bVss8+adTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1xR65r5KAp8bT9SYiNVtfqBpTbrHlYewRabA0Gs0F0=;
 b=YES5P39P+NSIwusMIvEJe0xhGY93FYoZUnWx+v1jPpXufFsbsJ5tf1w3iucJ36iXYH/IKODmTVmQE49zpzd0smTF932lxIjpLtatyiTQwi+Wb4BFGKCnxEKFH52ch+KQcgUWIUuCx35hMNqFxI5BDE4nldNghjI2JLWi0c3DUKsX7XY5DBjd23lh4e7b30knI2sYI1+Aew1nJDoBl9tcDKGbJB1gRsJwdSI03bq7FvIyxf/3w177A6cCXiYQcMI9tpF2EowqN3V4lxyIiMgESFu3BBW99uIK1RTPBZT/3GSGFyedhtawpclx1F68NNk/cSehAcFfKJuuYsXNdfjFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1xR65r5KAp8bT9SYiNVtfqBpTbrHlYewRabA0Gs0F0=;
 b=dItY50fuFADkb8Ek+R9J/xhrda2t/bGW76/Tg1NfY3PxV46d0Q9gwhKnhdqt2JewMU8aJmdS9BKnZr69XTJ8NtBHhnTZqTLaw/U6+uk2sEnNj941Aw/d+KtBW/I/y/M+VYWJsH5S28VVE7whpywqpY5qX63JUoWzear404pqEKsTmGWOh133kwlyxnEZkyIDPJFowbN9YtIn3djW35I+bdZj5CuAIDowlXoy2yDQaWNHC+v6anYxd5sHeq3x3Igc21CS+vjHmSGCA7Fa5qAS4+tLFPNydqvrg0aQ60NCHX1ce0R3FMAcnoNdVn2qQSHlhQ56BsdPD5UbPDibyCSaog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 02:12:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:12:02 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 28 Nov 2025 11:11:39 +0900
Subject: [PATCH v2 3/7] rust: cpufreq: always inline functions using
 build_assert with arguments
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-io-build-assert-v2-3-a9ea9ce7d45d@nvidia.com>
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
In-Reply-To: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0224.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 370d74ba-4228-4237-0713-08de2e2384b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFZwbXNxWEpQVW42WEVPVEQwMm53QWdEQ0xwdjBMWUk2Z0U4SG4raWx1Smc5?=
 =?utf-8?B?bWxNTGhVRnNoRDBrWnlhVG8xRU5mbUF6R0lObktrOVhIeHhlLzJ4bS9WUjcy?=
 =?utf-8?B?c25kK1JyaHBmUmZKUGZwaUV5K3RzWGVaRU1jTW5uQ1VOTE1FaG5BYkQvdUMr?=
 =?utf-8?B?MENFcnZlUllRbWtVTG5LNEoyU0dUaURHczR1a2RmT2xxdDFXZW1NN2J0QlZM?=
 =?utf-8?B?WEw4SXcwR0ZPeUhsYzl2Wm9vTEdNNlovbytkMDlIVnRGNFZaQkNlSndEcjMz?=
 =?utf-8?B?dVJGMWZtMHdIWWFPRElhRlNQZGJoT1dYMHFLTVNVMUhKa0RLZkZyMFFBYWtG?=
 =?utf-8?B?ei9VbFdHQk1yMlAvTElNVlNtejdJUmYwVVlCWFg2d0svOHhNQ2l5ZXNHeVpv?=
 =?utf-8?B?S3RqSW5vWVVkcXgrQTJBTi8wZ1VNblY4WjJubHQ3cnNsdGlMekFVK2o2Z1FR?=
 =?utf-8?B?cDByR0gvY0J3azVKS2tSZVd6UjJUTks5MDF4MWUybWJFbUZsWHlEdHpTQytm?=
 =?utf-8?B?MmMwdFhsbVRxejRSU2ZsMk41cnNxK2ttbmFmU1NjN3lPSkt0dTA5eUNLWkRq?=
 =?utf-8?B?d2EwWHFEZ2NkRUJ1YXExUk90NVFpVXhXZFFHLzZDTDRFd2R5K3VkSVh0Ymdy?=
 =?utf-8?B?R2tPcDVJZHpEVURyT3U5WDFsS1dvd0RHQW16RkVuNG8xL3FjMWN6cEMrQlQ0?=
 =?utf-8?B?K2pHamNBZFlGU1ovYzlnVUkyN00zRm1zeWtDQURHdTU3azU2V21JcGY3RlJp?=
 =?utf-8?B?eG9BZGpSWUwzMDZiL2hKbFpOUHBvbmtmcHRkQTFoRjQxcFNqMGlsMStiSXJI?=
 =?utf-8?B?VDkxVFNGWVRRbXBGNUVjclFrVUVBR2svd1d2NVRmWHZ1QWtPbkVsZ0V4UVU3?=
 =?utf-8?B?UWtmcGpVNDA4L2pkeGwxdXkrNkRrNmFQQTZnMWpLdFprcGE0N1lNdWFZZ0Qv?=
 =?utf-8?B?SDZEZEQ3R3puWXlwV3BPM0JrNW5YdXB3ZkxUamhMaDZHS0lKQXRGOXEzQ0NC?=
 =?utf-8?B?QlNGUG5jeUZnTnlnSWJoMXhOVnh6RjJ6VHF5NFVhU21xeWpoa3JmT1JreElM?=
 =?utf-8?B?Q21mdnl6cHNIdFY3VFB0TzZSWTdGa2JEYitMQTJpQllMN3lSZkp0Q2hQb1pX?=
 =?utf-8?B?TkQ2RVIvV2R1SXVWdUxZWkRaZnFUdmVJbjJRampqckVlc3E4Q0c4K0trWmRC?=
 =?utf-8?B?K091RE1RQUE0V3NKNDkvdHpmUFZiQzM4SGFHZFBWcnQ0MHZaTlpnUU9CMXc5?=
 =?utf-8?B?NVhJWnRURlVlZGFYRHlpMkhkSVliWTBjbUtTdFBxQ3BJREFJRGVQYlR4Y1JZ?=
 =?utf-8?B?dG1lWjhMMHJHYzA2aGt4WlBsbTNRUUI2OENUTGsxWUpwYXBOcHZjWTdGczRC?=
 =?utf-8?B?TmQ4aVhqejBRTStaZ0d6L21XSUpqV1lLL1doV3l1eGxGaVZHN0xURXpxT2xo?=
 =?utf-8?B?MVZvZFFtLzRpUGdESyt5MkwwLzBUVmVRTzBISjJYcTNWcUVvWnJjR2dlekRu?=
 =?utf-8?B?bDRXeVN1c3NFdjNOL2x4c0xhb3psa0RSVHVTaW8xZWZVL1JVWGE4Nmx3M0VU?=
 =?utf-8?B?RHlGTmhWbVYxYmZ3RGZYL0piTUl0Unk2TlYyd3FIcFQ1VEFEVlk1bFZVRWlM?=
 =?utf-8?B?MkJtOGNmcTQzeTRDN3FQckRwYVNBeTNpYjhwMmhKQk5VbDU5OWV0RTlBK29B?=
 =?utf-8?B?K1RBNjVVaXMwWk1WQ3pUTkF0VUZZNmFJQWFYVDJ5bUkyMEh5WXdIN1d2SHRZ?=
 =?utf-8?B?ZmtEaTkrTThmdVN5QnVrYWZpM1pGNnZzSkt5ZGI1eGNiSTVKMUpXcE5MS0lN?=
 =?utf-8?B?QWVFK3FINHJ1YUtna1ZlbXY2MkFkK3RlNFEvM1hQbFFpZGNTSzR0UWx3bmpz?=
 =?utf-8?B?OVhTc2RER1VnSG9makhCN1NiK3hnRkNaUTRrWEVSRTE0Z2tPWDJQc0xiVU40?=
 =?utf-8?B?L0xJaUM2TlQ5YlRIY0RpWDZ6U01LK0RtMVlhZTJrSERQR0FGNjY5S0s0Z2xZ?=
 =?utf-8?Q?orsGTavcxuaUbZZTwvCu2ZIovnEJ64=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z25XbGJxbWRMdkhJdTFWM3VjMndTOERDaDZjTEZQNDZpN2RBK0sxWnpMRkJ4?=
 =?utf-8?B?N044cDd2VTNsVktyUzhvalVvMWVhR2xOMzBPZnRZekFva3R2NGlkRGdITitu?=
 =?utf-8?B?MkVHTUV0ZWlpUG1taGNEQlVLZDN4aFBiZ1RNZEIrYkN0RmtOOE10Qm5YTjZ5?=
 =?utf-8?B?bFRTcjNBcFR2dEtzeGJBL1pvWlFtT1RkSFN1V0V5Q21yUVlSVWdxM0k3Znhw?=
 =?utf-8?B?bnV3eUF4SktvQ2tEM2ViS3h3NWpXbXNwQTVTMUpTTGV2M1dkWk9Eb3JWT1ls?=
 =?utf-8?B?RnNXUncyRGZ0NDlEVUFjUlpONHVOeXIvRFFzN0NOVTF0b1RTZHNxSDFCbFlG?=
 =?utf-8?B?OEdZMWlJL0krM3owMlVyRkFzQ1I1MlVITE9FRTJ1N2ZWUTIvSVZMcW54STFl?=
 =?utf-8?B?NWlWS2k1RHhHUDJ3ckJsZXFNdnoydWNGRGRmWHVXS0ZwVndzQy9lR25Xa25t?=
 =?utf-8?B?ZUpKTkNxLzJLQ0VtRVR5SGVpR0hsR2hQcXBZcy8zeDhEWXlLanZYcWdUNWdq?=
 =?utf-8?B?dGwvT2RmUkhpenI3bzBSUUZTcnJGYzFMYWh3ODJLei9KaHhLOU1qRlI1U2ht?=
 =?utf-8?B?OGowRGczQWxEQWFNUWlvQ1lxZmYwYlhyWnpuMjlKYWIxbUZpdGRXYjlKamVz?=
 =?utf-8?B?VXE0TEJTYXRyckRuV3FrODAzT3R6eXZBYXdQNDAzbFE5dzFleFNWK1pJU0g5?=
 =?utf-8?B?WGQwS0prRG1yTERaOFJSUDRKalFaR2lVaUtFN3RWVHkrZFErWGJtRWE0K2pH?=
 =?utf-8?B?cnZ5Q1R0ZjVGZyt6TnRZeHJHOG9MQ3NXa2VjSTRhNEFDRndZY3E4L29DWGNZ?=
 =?utf-8?B?YmtpRVFKMkJkWkpiYkc2SWUxcTRnM1oyYUpCdEx1Z3pyODZWcnNreVYram9m?=
 =?utf-8?B?bi8zaGl3dXMwZGRYR21pQzBCYSs1S0ZNME1FWkhxMlVueGV3UUwvSlRGZ0t3?=
 =?utf-8?B?VGV3K3UveXVxcFdBZy9SbUpXQW91SFNvNXI5OFVGSWpNMzVHTG9MdWZQWHA0?=
 =?utf-8?B?S2c5U2RVb2p0VXNFU3l5czluWWJnNCtqMGFzM1dmVnY4cnBjYlhuQUJybkRh?=
 =?utf-8?B?S3VMakl6RkZaaXVaYmF3dTNPVC8zcjdZMGpPenZicWhnVGVNYW9yLzlZNHQz?=
 =?utf-8?B?dzUyWEF3RlZ0bGEwMUo0b3lKUkVEZ3U2SG9mSXZTejN3K1Y2Z042K1NNNlZF?=
 =?utf-8?B?dGxzODFYT0dmNGJFZFBoYmFvZXIrKzBBbWRuNUl4NnBLNjlGMDJiNHE4RmY0?=
 =?utf-8?B?QThINmtuSDJVK0JuNWVWd2xvY1AzNVBiUERUdGUrWXVRK2Y1Q1F1KzZwM3pi?=
 =?utf-8?B?ZHRVWUU1NVd0dkFrQ1FuV2RMRHBDWFhXcXB4aWJ6N2dGYm1IeHJyREdOQXJx?=
 =?utf-8?B?dFFLSlhvMFN1YUtjWGhhQ0dZMlM3a0ZGOFNGai9VOXVyMVBLOGNNekpxOGFq?=
 =?utf-8?B?clVZNmg4eVAvdkJmV0x0dEhQSTI4MFpRNnlwYnE2VEwyTUpUK0ZHSjcrWjIz?=
 =?utf-8?B?bXJwb3pHTVA4U0t4cE5nOFBNZ1k3VlY2VGNvZUZhZ25kUnkrUTFNaXFtMXBC?=
 =?utf-8?B?ZE5NYjFBY1luU0w2eUQrdmlGd3g0Vm0wcStjcDVmb2grZ3gvVzNXZFJDRDc5?=
 =?utf-8?B?RXBUNlZURng4NlFCM0JFbm92Rm1oMmNwRVY4TjZmMExQbmhMRWp2WjRjeDA1?=
 =?utf-8?B?TkI4MDdxYjR0dkFGMTdSTFo5Tm1MVnN2bEk3WFVKblNSMkRKcEw0NGo0N0hY?=
 =?utf-8?B?UXVvVm8wQVg4VzJjcUVlcUsvSXJKOHdLZXB3K0dQV0tBRGcwNEVKT2Zsd2da?=
 =?utf-8?B?YnJGeTgrb1QvMktZb280Z2xiMXZQUWdXWFZOWmFVa083U3FSalFjb01id0xs?=
 =?utf-8?B?NkswUlpiVzNaSFJUbkwxZDVxNFhKdjR0MkR5TE4wNGFpKy9ybDVULy9QenJs?=
 =?utf-8?B?K2phOS8xUGl1WEtKNW9Jem9VN0wxSk5nL0p6aHFSelBKTElqQUlQWXBWeVY2?=
 =?utf-8?B?VVJhdlhpMzVwTTRFelNOb2JhTlpYdkJOUWViM21LeWxYT0pzdmNEVnl0dkRT?=
 =?utf-8?B?TUg1TEY5VW5CS05MMVdaZ3FQdW5QbTNZdXRNeGlKenJ5bFl5OEk3bmtVMnZ5?=
 =?utf-8?B?VWRkWW9FTzFGWkZ0V21zaHJ5REFtRy9FWnRpZDZVWnB3VU5KMERGQldXZng4?=
 =?utf-8?Q?Q+vP4GwfAl9WLv2Ajd2L81QUDmUiG7v/hy5Rex1sys1Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370d74ba-4228-4237-0713-08de2e2384b7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 02:12:01.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4QJL1UIt02IkAIUtyn43d2+M6zqwCrVFxVNLLdRKT44Gg8o29FB1X1rqyKRTlE/FIfRNpArCtyCc/wdeEQseQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617

`build_assert` relies on the compiler to optimize out its error path.
Functions using it with its arguments must thus always be inlined,
otherwise the error path of `build_assert` might not be optimized out,
triggering a build error.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/cpufreq.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 1a555fcb120a..df5d9f6f43f3 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1015,6 +1015,8 @@ impl<T: Driver> Registration<T> {
         ..pin_init::zeroed()
     };
 
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
     const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
         let src = name.to_bytes_with_nul();
         let mut dst = [0; CPUFREQ_NAME_LEN];

-- 
2.52.0


