Return-Path: <linux-pm+bounces-24447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAEDA6D887
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 11:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2CE1892E37
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 10:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317E125DCE5;
	Mon, 24 Mar 2025 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xl5QVuBp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABBB25C6FE;
	Mon, 24 Mar 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813062; cv=fail; b=YadTxaGnYc5mjW67hhFMIVwwmq3kiKvQ+REJqSOr4RI/1F0tWeQ/H+dmhCRt9IsZlK38yekbhCgdXP9hVseO0FmlZFpmROop1jPRCiX4hRiiI2cLM8aVaFp/KZNNyaVobJiyNPn6uB3iN9jTayAEpt9UqELtZLMz1xrBGGrTsMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813062; c=relaxed/simple;
	bh=y+eIHS36PoYjQwW61HqrBPLmdGkfYoZWLsCaHVslS7g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GGUMVVivjyb9XDw62qO6YtTj98n5mO7g+PCxjHNb9Ry0mrs89KjT1mCAFapkAPp0Ph6kpwZ9ijo2zKQMT4GRanidc2LNu1O6FjDkFW3dJeHQKVenl2dQY0h22ShEzyumyzX1ne6qLlyCO5T9JHe6monR7Eyz8rkzFp0b4oDoN98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xl5QVuBp; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPe5HxszUs0skKrcc1KiGQdl+z6GQwN25mF4OuYDdnBfjytDHNrA7i+cyULCuVhh19ZnMpF9ExC6q7UDx7JcK+7uqrUd8rHHRh6ugdZ9veDfuXP0lVKMWPNOdgygCMpUP+tNFKr545DBS0m9cGKdkAQHNTe9Cj6pA4lonW26lG8A4axVbeTFAxnix1yf9HCQj5ArkCsiE5rdOsBy0yNE2aDcjMYgkd7sQKshZBziTYqv2il+6jgpeL6sTZu3kDsOntZAmxTs0z/73oNumAxmLcXfAVI6XkkQQXKBKkoIKEB8XrNUKUZUgHzWcb3aY1PU5AZqmR9BhQV5UgHlaflRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlrzc0+bYuPfgCBhijqa8YqiEEjPyi4wfZqRc7m+NN8=;
 b=N6FuitwjCkTQpdenxEqcPFhr37nt6yMLCJ5PaQvgCDzeA6s59Wymdm3DSlCer4QrQRmd4HRmQX8zIDKd7LElkLS/tKVDlWojTYii4xRmb6PDF+XDpYyegeb2cfvucK08Yg6VYB+ilGEqy2yzRezGp67ab+/Awtga1udgOL+l8LjBMNZehqXsj9cAx2EmFjJOGWRaDR9hwtCzNYFWablOQmwOqMtf870KSgxT+qEoKcmWZfICfNxyJ2OGqFCR7iAQ+cUJwGA7kYqws1KgRLJG7k+R8j6Aiqu6jLeAHeANpFPghQ0pLUNcMQSfJLatH5IuEYSHsG8sxvjiRBvQsO40mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlrzc0+bYuPfgCBhijqa8YqiEEjPyi4wfZqRc7m+NN8=;
 b=xl5QVuBpK+x8z7QonWNLxo2rhA1yCqmNXOXdjESpdr9xVfo0nuEKzk6+70eiVGFAVZD363HMB4X2Txnu68obOpwD28JP6PsQ3/iFxPE5CchAJ4KIzNgZ9/uyF9S8+KpPjMEFxbxCSkDRe3XVb30I3lO/CnbisZj+ksl1Gl8bqZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 10:44:18 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 10:44:18 +0000
Message-ID: <301ad0d4-f8be-4787-ba3d-e4311e5c386f@amd.com>
Date: Mon, 24 Mar 2025 16:14:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] cpufreq/amd-pstate: Add support for raw EPP writes
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250321022858.1538173-1-superm1@kernel.org>
 <20250321022858.1538173-5-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250321022858.1538173-5-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::17) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CY5PR12MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: ae261365-00b8-4a93-532f-08dd6ac0d411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cS9yOHJhMUFieHB6cGlCZkRXRkdqV2ZjNUNIOHhUR3Awd0YybVJkNm9scFRX?=
 =?utf-8?B?N1NLaWU4YWJIUzZTbGhIclhRUmJQMGc4Q1dyZ1VPT0IydXlyVC9aV3Y5SkZX?=
 =?utf-8?B?Y3ZUaDhoa0JQbDZHdEZDLytzVEVHVURuYTUzWUFVVDlTOVJTcExxOE5GUm1l?=
 =?utf-8?B?L2NKekxMUUxNYnhWdmxnSW00ZnNydW1CWWZEU0hBZnM5NmNNblV4T1p4N1Az?=
 =?utf-8?B?Z2tuakdsV1NVeDNDdlJTYkF5eTcwZ1hVU3MxZ05yVHk2WTJIRWRUTWNUNzA3?=
 =?utf-8?B?TFFSazNGK1dVR25Bd3EwdnNpQVFzcnovM0Q1Wmc1L2lXZ1lOUW1LU0tPWTh4?=
 =?utf-8?B?cUFJbTJZUDVMYWFSVEVlaStLN1krOHk5Ylh0RHJLRlhvbHIxcmYzdjVNZEJQ?=
 =?utf-8?B?UWdUNENvSWZ2Qi95QzZYc3lYR1N1RkJnM1U3K1VxV290TGl6SWZYcTk2QmJB?=
 =?utf-8?B?MzA5dFlKcEYzeEQ2cTNiR3h1Wjk2bFNwd0c3QUo0N2J3aU9PcFJMQ01rMm1B?=
 =?utf-8?B?NkZBcmdMdkljTjZYZ1Y4Mk1zRUtvQUk2a09CWXhoYnlIUEM5OEpGMStyeG9p?=
 =?utf-8?B?RHV6TGdzMm12T1JidmZuMFVPVWsvZkdqYXhvSlVaMEFzcmZ0RUxyOWxoWk9T?=
 =?utf-8?B?ZTNhVWxBd0V1eHFoeEEwanl5UHhLZ0cvTi92dHZjUWNhUThFT1FnOUVVc1JI?=
 =?utf-8?B?Z0FYSG9iOG5MRVBLZWp5RFVOSCs2VTlFdm9UZ2NFWEI1eXJzdjdTaTlGTW5t?=
 =?utf-8?B?Vk9KcnBpQ3Bkd0pOOXNVY3ZFREcwVUJDNHNYZ0t5Q0tJZUdqZEtiV1pxL0Fk?=
 =?utf-8?B?SFYrb3ZRM3VJd29SNERUbVNJTy9GdDZxejFPNUZpaGxLVXpFVndPVTZXNWFV?=
 =?utf-8?B?NDlXWUVqZ1BTS2czWWJ4ckN1SUFkMS9vMzcwcDJ5RXovYUxJTkd3c3VXdjNP?=
 =?utf-8?B?cWZKaXVPdUVzeEM2REVybDg4WTQrMXVaV25zV3hLb3c5Y0JweHFJYXFJNjhz?=
 =?utf-8?B?LzJlNnFXVEVNd3Q3d1c3TGorWG41TVZvNlNuaEw2VDZPUGdrZk1TSWVnaldI?=
 =?utf-8?B?Z08relM0S3djSmlyU1NkdmY0ZGJ6R0ZzU2hMdmlZYm1WRWZFa0FUQ3lmb04y?=
 =?utf-8?B?UnA5ZGRRejhLTkVsNEE2SnZ5UVFEc0drY0I1aituWjk4YXRhOE5HNG1ISVN1?=
 =?utf-8?B?d1Q0b2xISG5jRURMdzFOL3d3ZzE5VkpPVVNkMjBtNzNOQWF0RTBra1lwaTA0?=
 =?utf-8?B?Mkw3TTRlK3h1SjI0Z2xvdU5RdWpTekxvckVnTlZFUVVBUnQ3T3JyYTZNNHBE?=
 =?utf-8?B?S2hKaVVRbyttZkJPelhCRm8vSTJIUWtpc2IyNitqWVpLdTBvUkJEV0lVRVV1?=
 =?utf-8?B?a285QUtDZDU2MkpGcW5xVFM5VDB5RTFFKzROQ2hPaGJoSTNDOVZRbVFHRmhH?=
 =?utf-8?B?S3dNUzBFQjhWdkVpM0tycmVDYjhpK2RCWjN1UDdXV003Nnl0aXFCWUIySmhk?=
 =?utf-8?B?UXZJS0RHeVJtTjFjODZheExoSm1nSXFZRmQzT0lOSWhwbXFOK0NDQkl2K3pM?=
 =?utf-8?B?Nk9iVno3Zm94ak1laXFZR2ova2NmakRIdnZUYzJabXg3bVM2ZVlIV1pEZ21W?=
 =?utf-8?B?NXdSWmN5ZzdhVTYxNWY4NVFMUW9wSEhOVGsrcXdUL1pCRUt3dDFPSUdBc2I4?=
 =?utf-8?B?MkZVU3B2NlRrT0ZpMEo2RW40T3luVWdpOWlLOVh2WWJHbXArRGZGYUxQRWsz?=
 =?utf-8?B?Y251T2pFc3hzdjRWM3BPY0JWelFpdDN3d1lnNGdLaWFLWnFGUmdDRTVYVHkz?=
 =?utf-8?B?VE45NjFZMUR1b01Vd3d0WmFxV0pHdnYrcUxTOFB0SnlrRUNydVltY3N5MUFm?=
 =?utf-8?Q?HQ8ZPRT2Lob7D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUZIUkVvMFZNUFNLMlZUVERpdVNkV0NvNlZYVzFWVXluSVRDVndHTFZta0tK?=
 =?utf-8?B?T2Ixck1uUmUxSW9RbC85WUlRZXNTMjJlWUxjSW93KzQ5Nlozdnk4WkdxU3Rl?=
 =?utf-8?B?b28vRGhiQ2lxbUFVY3EyTnZLV20zY1BOS1h2Z2w5TlVyMkQxWHdpeHJFVjlk?=
 =?utf-8?B?VDJHRVRHcXhBQ0FpWVJvcVdJRlpyczdCS09jSFRtamhSTnF4YlVqd3Rkb3Zr?=
 =?utf-8?B?Skl0SzBvYllpeTZpV2NVNkdkU2dINDBpc1hQSm0zWEdPeEx6QUdrTWQ0bU5h?=
 =?utf-8?B?cDZ3VkN5QW9kMWFWcFhnazB2amp6TjFqcHZSY2lPcTNJb0NlMGl2eUEvZ2cw?=
 =?utf-8?B?MnRIbWRIS3p5eWZNb1ZqMlY2V3Q4UWVzYU5vY05rRXNDdmFuNGN3c2ZDRlQr?=
 =?utf-8?B?MEg4UVAvWnRKTnlGNEZTS29UMzRHVDhacnd0djc2OGVyNWJDUHVzNXZDaGtJ?=
 =?utf-8?B?N1NGWDR4VDg2Q0NYMWdZU29yNkNHNG56ZUd5U08rWkJYSHNSMnFJNDdITVAw?=
 =?utf-8?B?dk13T3VJRy9PTWk3QUg0VFordkVuVUt1WHZrTG45QjBCcE5HQjVRY3BmTDNG?=
 =?utf-8?B?WmZRUlpTa0pTUGZmeG0yWXF4a3d4aVNpMzRieDUvczdvUXpwMm9tWHFMakly?=
 =?utf-8?B?TEVkWnpaQjNadDJhRTVrL3ZUZTBlRU5rVWc4SncvSktIcVFKaVV5elgySldS?=
 =?utf-8?B?OXVjZTlSYldmSkxzaXArQ2pBTFVGVW05OWdiWUYwby81VE9GS2pFTFErazB6?=
 =?utf-8?B?ZGI4SkRsQitneHVadythOXpZTm9Bd2FhaXpqWU50WDhUK2RqSExRclRZZFRn?=
 =?utf-8?B?QzVaRnUwL3Z4Q1lBazc4Yk5NWExyTFZZeDhuUE1qeVoyTHBVWkZoR083bjk1?=
 =?utf-8?B?aGQvbHdQNVNmNERlSjRUUXl4SzcrNUNpTlRtMStDUXAwMXN1MXlHOC9DRUh3?=
 =?utf-8?B?VjdWaFJibC8ycVhMc203YWNaYUFyc2xKL2dXMU5EQWVsS0FESWR2RlBqcWZU?=
 =?utf-8?B?U2QrNGlzOVdmQW4vd0dZa2VYbmJwQnpwVTZMTWI0aDRNWUl0Tzk1M1RlQWQr?=
 =?utf-8?B?ZnJqdUcwdUZZcnFZWitMUklpZ2RQaGVPVFpMNEMyb1hlendreHJDUTlpRzJZ?=
 =?utf-8?B?UmdKeXVPYXpUTFY0cTk4YzFhZzR0MzRTMUNkMVRTZUROOXZEZFdJUjNON2Fp?=
 =?utf-8?B?MFhadVZLQnNsNjVLV1FsUGhGbDhWQVRBWkFUQ3luUXc5ZjV6M0p2Mis3YmtU?=
 =?utf-8?B?ZnoyWlNXZDloOVdlaHBwZE5ISzlYQnhSMkVoWjdRL2dBcDNqbjlPMlZkdXRB?=
 =?utf-8?B?dXp5YUlQUnNES2lSUUh5MU5jWXFUR25scnQ4RWgvS0xBVStzRFQ0R0wyVnBD?=
 =?utf-8?B?VDdIMzV1S3hsMEE1KzhpTi9CcDc1L3U0bXVWMDZGbERac2NrYnZtN2dRNStq?=
 =?utf-8?B?SDNjWFNTK2puWUx3eGJSYzhvL0toVjlYVkFWM3JBQXNFS25WSitoTzVXam43?=
 =?utf-8?B?ZDFsRkdmZEI3REdGTzh5U09yMHhRNTBkenFYNnhiWFJERGJJRlZTVWc4WStI?=
 =?utf-8?B?U2Y1U0tWTWgvbjR4ZG5jU2p3WGZvQW11L0tFeEVGcnJtcktxQmNpSkhYOW9O?=
 =?utf-8?B?aWlwRnIxOE9XVHhmTm5VUDc0OGIwRUpLc0NaSHRJMm9lcjM1YUJzL3oyZ3Vj?=
 =?utf-8?B?a0EvaWlnMGYrenFuNDhRMkcxZjFTamk3dHlhK2IrWW9hR2JDZGpVeExTbDhJ?=
 =?utf-8?B?STdGTlYvWlZ3NEJqZlBvS0JRUnBaMGMrSy9PU2pzTkJvcmVCTjIwY0tUT1Rp?=
 =?utf-8?B?TGROa2M5VlBkZ2ZSbnVXeFFGdFJpQVV6bUJ6MWwzZmxsQVRCUS9KUG9aL0Fs?=
 =?utf-8?B?dHhTdlJORUYxUmxxbDhJUUhFZVpHWm9TaVlnUlRHMGxycks5QXNVZm1OWGRk?=
 =?utf-8?B?cHh2NGY5d0FWa0pka1JjYjRkekw2NDJ5dWhYOFlDcXBPM2M2RmpTV3ZibXJO?=
 =?utf-8?B?UytQV0FHakhsVk5uWTdrYVo0YjB6eGdIQVJIQmlXKzEwaXFrc2xVYVMrOXRJ?=
 =?utf-8?B?L1ZNc2pJMmhFZnU3cms5YmR4YXlBa0ozZFZvMWtJK0tVeHVpaDFLVElZMFRw?=
 =?utf-8?Q?Bp7DR9/wQLaTbSsvZgTBKkP46?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae261365-00b8-4a93-532f-08dd6ac0d411
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 10:44:18.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: en+UlC6Mmp3rMsnAhlQSOqrABZDbsBzgaYautqenEUV7TkMnf2j0Zx9W6gojO4WXnvXfr7HO/GWwZDVzKGho9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298

On 3/21/2025 7:58 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The energy performance preference field of the CPPC request MSR
> supports values from 0 to 255, but the strings only offer 4 values.
> 
> The other values are useful for tuning the performance of some
> workloads.
> 
> Add support for writing the raw energy performance preference value
> to the sysfs file.  If the last value written was an integer then
> an integer will be returned.  If the last value written was a string
> then a string will be returned.

LGTM

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 16 +++++++++++-----
>  drivers/cpufreq/amd-pstate.c                | 11 +++++++++--
>  drivers/cpufreq/amd-pstate.h                |  1 +
>  3 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 36950fb6568c0..0e4d2e0aaeff7 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -280,16 +280,22 @@ A list of all the supported EPP preferences that could be used for
>  These profiles represent different hints that are provided
>  to the low-level firmware about the user's desired energy vs efficiency
>  tradeoff.  ``default`` represents the epp value is set by platform
> -firmware. This attribute is read-only.
> +firmware. ``custom`` designates that integer values 0-255 may be written
> +as well.  This attribute is read-only.
>  
>  ``energy_performance_preference``
>  
>  The current energy performance preference can be read from this attribute.
>  and user can change current preference according to energy or performance needs
> -Please get all support profiles list from
> -``energy_performance_available_preferences`` attribute, all the profiles are
> -integer values defined between 0 to 255 when EPP feature is enabled by platform
> -firmware, but if the dynamic EPP feature is enabled, driver will block writes.
> +Coarse named profiles are available in the attribute
> +``energy_performance_available_preferences``.
> +Users can also write individual integer values between 0 to 255.
> +When EPP feature is enabled by platform firmware but if the dynamic EPP feature is
> +enabled, driver will ignore the written value. Lower epp values shift the bias
> +towards improved performance while a higher epp value shifts the bias towards
> +power-savings. The exact impact can change from one platform to the other.
> +If a valid integer was last written, then a number will be returned on future reads.
> +If a valid string was last written then a string will be returned on future reads.
>  This attribute is read-write.
>  
>  ``boost``
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2a62b12148544..b0de50f390e07 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1318,6 +1318,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	char str_preference[21];
>  	ssize_t ret;
> +	bool raw_epp = FALSE;
>  	u8 epp;
>  
>  	if (cpudata->dynamic_epp) {
> @@ -1334,6 +1335,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
>  	 * matches an index in the energy_perf_strings array
>  	 */
>  	ret = kstrtou8(str_preference, 0, &epp);
> +	raw_epp = !ret;
>  	if (ret) {
>  		ret = match_string(energy_perf_strings, -1, str_preference);
>  		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
> @@ -1353,7 +1355,9 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
>  	if (ret)
>  		return ret;
>  
> -	return ret ? ret : count;
> +	cpudata->raw_epp = raw_epp;
> +
> +	return count;
>  }
>  EXPORT_SYMBOL_GPL(store_energy_performance_preference);
>  
> @@ -1364,6 +1368,9 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
>  
>  	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
>  
> +	if (cpudata->raw_epp)
> +		return sysfs_emit(buf, "%u\n", epp);
> +
>  	switch (epp) {
>  	case AMD_CPPC_EPP_PERFORMANCE:
>  		preference = EPP_INDEX_PERFORMANCE;
> @@ -1378,7 +1385,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
>  		preference = EPP_INDEX_POWERSAVE;
>  		break;
>  	default:
> -		return sysfs_emit(buf, "%u\n", epp);
> +		return -EINVAL;
>  	}
>  
>  	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index b4c5374762110..b6be2b8fbffbf 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -108,6 +108,7 @@ struct amd_cpudata {
>  	u8	epp_default_ac;
>  	u8	epp_default_dc;
>  	bool	dynamic_epp;
> +	bool	raw_epp;
>  	struct notifier_block power_nb;
>  
>  	/* platform profile */


