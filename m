Return-Path: <linux-pm+bounces-22392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC450A3B301
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 09:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFA03ABB95
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 08:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288011C330D;
	Wed, 19 Feb 2025 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qBnPwwJo"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D901B87F4;
	Wed, 19 Feb 2025 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739952059; cv=fail; b=R+a9n9O7zt4Lyh+8NG1pFot0GtDTbdKZ5gSz/ZNrAX5qSH4vAsag1wpqubvYiTnCMIxZiBJVB17ECndTOSZAVRcrhqRDVseNtS5qWnIINAKhzWMMipXMIymCyurmy8HzMUEMZgXfiyysT2qZNBhIpt06kjiSojzlu0noI7SBtKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739952059; c=relaxed/simple;
	bh=BJ4xmvvd64jDfkU6YiHMw8YTlLt1NWp3zHQQ6siIKqU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ATqhKLEcn21RQ1/OYbHlKH62DtgbSGUhV2fWsnyZQka2gVNk1Peb3AEYoWwN6o/Ih00TtWudOioKnOQo8pvwDutMz94Bq5ZBEXeUIi0Wjl7y1rjxIDhivqVAH3qTIhC7ppENefXYJxxohyQO5e/FgzlzxVdPBGoTD2KQCGEyvz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qBnPwwJo; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUKZ30VCUh52qwfUsEcjLAk3d10spHQOhiGwxLDgL6F8n8CvdcJeDPUcCuL90LPZHcFZR01h/PK0Iq9vOmdyslE95cBKqCg23pjfpuvqybNQVZDUqGHEZDdqnMq5seQgFmh92JQljkvBnA4j/istmUopBYsWtXvDAg5RkA2MaEOnf8/6T1kWFoPPAISxDnZgLl9KdqpZuix3wDcjlbXW2puLGf+Xo+RAKT4D8oOrOZVGMfaYnVKbWRlujftOngYdDFNjJZzkd4rkwdOKO+G9WDXoZdf14p+RvXfQIB5LHhiwQpKOkrBEx69tGvLlR29XdL3MkY6LFVnt3X7ZBtIyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlyGHIjWtqw1XaBQqlQYV+fY2QssjFpNy/D1OSlOY88=;
 b=eUKP+a6OwEdawo7ANl5Pq+OmfcZpR78CxnSS+Z/oU4FSal6d4N9V7OTjKJXgBAL4bXTPLjf34QreP6oOFY/4ev/yNeq1LUtL6xgb1/3DfWWpPye0eMyT6jHMvFSxyM3Y8c2UaMrMTyVB54DjnjHA9rMz+OzP5kFX2r2jYYdCxG+0TTbLpLlt4DLf55x1O+5QVSIxFDhPvnFfudYg4AGUbfkISXjouQy7Av/p7P9NgKWrdqyhXhPCsOWOS03mTXwwNL6n58EdGsthbTl4edTrbL7jlDbccYdcuXM6CQnQNYLwFE2xs9UXESU+W21l3aXSXX1nrGzxwvgPWED6WYsFvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlyGHIjWtqw1XaBQqlQYV+fY2QssjFpNy/D1OSlOY88=;
 b=qBnPwwJovPwZE0FQWTp40lDHEpxFv0TvJvn+GACBhBBPeTFANLeneT+VI2oWGYmkV4c1QZj8pGMoTnentQIuSmIR9XwS8YdjP/o6Dt7lpnKghTK8jt/ELZUEnrLdxfo3VK7pSwYZFAWSc/1XSbzzSuqxJfwEozpDvUmPOWVNMoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 08:00:49 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 08:00:49 +0000
Message-ID: <87a59577-3b66-49ff-a0b5-0cddaa670a27@amd.com>
Date: Wed, 19 Feb 2025 13:30:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/18] cpufreq/amd-pstate: Drop min and max cached
 frequencies
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-4-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250217220707.1468365-4-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 39505e4f-cc11-4ee5-eb52-08dd50bb8594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Snk4eWFJSWd4aHpQVU9PSUxRaFBoRnFhUmg3SGhCNGlxd3YyYzg1UnV0dDVx?=
 =?utf-8?B?eC9xR3Y3blk5VHJFa3BDcjJsSnZieHRrcW8wRWh5eFYvK1ZWQU9lTDFjKzE4?=
 =?utf-8?B?WWx1RWlDNU82R3cyS1ZHck1MQWE3dC9tRDNpQnhGeHkrZE5XVlRvbklRNldo?=
 =?utf-8?B?bGgxSmQ1RXVBUXFlTlVrN1VDL1orYTlXRVJTcXhtNHczMUpPVElVa0l2Q21I?=
 =?utf-8?B?MVRDUWRrVjFLSnZCQm1VL1pRUVE0ME9sS3lYQmJZK3J2OGt2U210a2dqUlYz?=
 =?utf-8?B?aEMzVkRuZmtIb2pqRmdhNVNFQ0N1OTBOTC82ZmpoekZPcHBPa05TZ3Nqblcz?=
 =?utf-8?B?Sy9Bb0trTVBJNDgyK0Q4Qkc5Y2FnUFYrb2U3bE92aVB3MWlaalc4c2ZGK3RF?=
 =?utf-8?B?SWh5N3RUdS84dmlKVENEMHI4czJ0TDBVVUZGZVBHUU9keVpFbzJFdnpVRXJK?=
 =?utf-8?B?ejhuSlptSCtvZUs1ZlZ6YVV0dmR4OVNscVlOUStPbHNrRGVMcllLZmVjQlNO?=
 =?utf-8?B?TnI2S0ZsQURpOThCdVhIRUt2NEk3VXFrYWhobSs4WStGTE9FQVVJVGQ3MWg4?=
 =?utf-8?B?MnBwVHlhd2lzWVhOdE5jbDNPb1czN1BDL3BzV0p1RkxlVFArbis2N0w0YUw1?=
 =?utf-8?B?a3lrTWptSHdvRnpxY3B1MytkTkU4cmhDVGxWSEVGMTd3ZlMyQzBHQ2xNRUNo?=
 =?utf-8?B?VU54WDlUM2ZGYmNmU0xPV1ZKRVZreUNwcTlXSXJ0SkVEWDFub293Q21PZ04v?=
 =?utf-8?B?UzhWSE9VRW5XSXQzNk1COWw2S2JhRHdGWThvZmpCTjJzRitGbEN4TCt1Q2tE?=
 =?utf-8?B?QXRkeDdOS1lZMHhza2ttSEdxV05uVnRJMmlJcmhzNHpPWVl1SWlxbERBOFBm?=
 =?utf-8?B?SlhLYlhzb3ZrY2czZVFpTWtJeU9PR1hDOFdZbE01SkZpQ2hicmpoOHA1SWdS?=
 =?utf-8?B?SFpQOC9ncTFiVTZlUW91eG0rUkVCbUk4ZFphcXkvdXdjb3JURis1ZnFBZThk?=
 =?utf-8?B?WCtRL2xIQVowQ0RnNDNUMlloc1dpcGlyNjJpT3Z2bWFMTGhWL2JYUFo0UU1u?=
 =?utf-8?B?NC8vSkhqY0VPeUdKc0ZqbTZuMWhJbmtZWWxsUWhtUk80aytKZHlOTG5JbENU?=
 =?utf-8?B?SndjcStVWU4xMlFuWVY5dURKRm9VOGpXWlB5bE5MNlVoWVRUU3NBVlZDbWl1?=
 =?utf-8?B?bWlZZVJUUlhhV0swNjU2NmdSd3psRTZuTmlMWFgxSXIzL3c3dlJLc1hVNUV4?=
 =?utf-8?B?WkpGUzJQdUoxeGg4akFPQ0UzWEhoNWd1UHhuOWxDZzlkcC9oakpwWExtZ1Ar?=
 =?utf-8?B?ejhGaWdhSWI0c1FUb0xiczNDdDNMbjYzdG5TQ2MxcllnSTNtTVVCRlJJcHFn?=
 =?utf-8?B?MFhxRjYzY241UDlaNXJKVFZ5aHN0VnpCdEIwaVp5aHBLYU5oaGVISEdCa3Rw?=
 =?utf-8?B?dHR4eENDL3lNZW5OcThSbENiZnhOc09XZ1NJc1BsSXhPNGU3R3FEaUx2WTdp?=
 =?utf-8?B?bTFkMFVsS3diMi9UYy9oL1dBa0Y5dk1wRjBNTkVuSHZOaXpiY0ovOFM5dVIv?=
 =?utf-8?B?bGVYT0xkY2taNWVJM1AyNU9zeTRKN05QRTNWeXNmS2FQaHZ5TmtTRmpXZ0J2?=
 =?utf-8?B?bS90MEp2emZ1ZW1PRTluVzBRQnoxT2pGSUU4cVR5ejBWenRXMFd6alZWSEZv?=
 =?utf-8?B?KysvaDNiNUx5UDVVcnFub2Zia2t3Q0x0OEdFZGxIUXlrSUkwS0FDUnVaT0oy?=
 =?utf-8?B?WjJ6a2gwOGxGRmJBbzN6Z3VWdDNJTS9mbkFzM1hpRnpacXEyUGQyREV3WG11?=
 =?utf-8?B?WWpLTkFMRlc5VFFuYlF6dkRmeXllbHZDMHl3LzlEVkF5aTl5N0FoM3p4Mlly?=
 =?utf-8?Q?0hZljeHQlV7jt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzVXemU2SlJybFVXcTZCa2toRDBseUFPbm4zRHVGZjdEQmZpZEhhc1Vvd3Yy?=
 =?utf-8?B?YSsvZEJBUTdLc0JQMzZMdVAwVkMwMS9UcnExYkplakRROHk5bWkvRXIrTXBW?=
 =?utf-8?B?bHZVQ2l0d0ppZitZTFJ0MWhzNzBGeDNXdzZOQUdkR3cxTGRaOVhBaVEycGFM?=
 =?utf-8?B?eGc0b2NDM0hKUzhMVWNKejlELzUwV1g3aHc5akFDSzJPSWcwVjVFS1ZDMXpR?=
 =?utf-8?B?RGZXSFRESDU0UlJDSFZsUjBoVDRzV1lwamRKS3dtQUhsNE9qQnZtWGlPZGNJ?=
 =?utf-8?B?aERvQjU1RVJ0emVhSTFFb3FYc29MTnRZaTlXZ1ZEQ0VlYTBWb1V6ekVkTUM1?=
 =?utf-8?B?cko0Ukh4c2oxaDEzN3dBTTFDOXRya2Zhdk1DWEh4OXNwYWQwYTNLeU9rVVJZ?=
 =?utf-8?B?T1UzZ1J6eGd4UkVhMi9jdjZsMllJRHVhbDROd0RVd3FzQnhJY0t6TXRqRU9J?=
 =?utf-8?B?NXU5S0Q0SllYdE9oQ1B4WGJvaTdUSVNjd0pubHpKaGhjbjl0YUx1cjZLVFFt?=
 =?utf-8?B?eWRqWEpBMituWkszL3NLVUxwalZMNWszaGVDcEFhbkIycGhiaDZMOWllMEky?=
 =?utf-8?B?S0ZiQWY4R3Y4QjRHQzFpWGtLbEQvSnR4MzFpRnpvTVA3dUtHbXY3RDQxNklm?=
 =?utf-8?B?QmYwRkdSVWtWai9MZExVMGpaRi9HV0llTStWT1dycjlURzM1dytuREJjeEtC?=
 =?utf-8?B?QWVIVXovS2tsRFd4NHBjbmRGRldhNjFDZGEyamk4bjJGRm12MnozWTJjNG5l?=
 =?utf-8?B?VjVpWm5hVU15dXFxN3lqVmJOaDNEaXZwd1BsY0VCa2lYLzhkLzhoUUJ3bDJP?=
 =?utf-8?B?T0ZST2VyeGNGY3dSZVBWbmJWanlYeTBDTDVHeS9FYzdkQ1FrMGFRRGhEVW04?=
 =?utf-8?B?bW4xQlpjNUVBM201djBBcmtVU3Vqem45VHhzeExoMkdBWjdHdm16WnI4bG5n?=
 =?utf-8?B?VmtRUm5JeStpMlRtZ0o4U3VhUFhKSG9GazNWRitxRmRydEltT3dzWlhRV05C?=
 =?utf-8?B?Tjc1bi84blY3Y2VPK25XVUhSMUxaMklPcm1xRWl5cXh1YktwTTBza3ZVZE5J?=
 =?utf-8?B?dFpkWGhrdDdadmtiMlJ3bXQ0Q2tTWG55Uk16ZVVxdWl1d25ESnNIMVFuWExr?=
 =?utf-8?B?WURxVzFKOU91RjkzUnhrZThPLy9pT1VHalZucFlEQUxaUzc3dldsaXk1S3RJ?=
 =?utf-8?B?ZEpjUWMxWTAwTmNqbnlFenR0UVM4QWc2TmFuQnEwdlF5b0pyZExTRW1EckZZ?=
 =?utf-8?B?Z2JNKzRCWFZaMHRIeWZSTFBRY2MrbE1aN2V3QmZBWU5qSmtod1ZmNmJ2RW5R?=
 =?utf-8?B?L0g5ZWhZdEJkUnJjeVJweWFoSFZ2aHNHWDN2b0poeGFXbGwzbit4UURBRWhn?=
 =?utf-8?B?QXc0M1M1TnVVcjR5T01rU042U2VLQTBMUlZCa29pc2w3MVBzbmEwZ0xnWlMv?=
 =?utf-8?B?ZkNsZEtDRE5YYXlVVXlDVFk3elRrNHlEUUJZS0xSVWtsUG9KQ3kzaGFOY2VH?=
 =?utf-8?B?enpVdHA5a0hEQXJQdzRZVkN3bUdiRFY3R2NzV1NoK0ZkK3NoVWdoWEtqbENz?=
 =?utf-8?B?MnBVb3ppVWFUN3BEK2MzdUtibkMwY0dEaFE0U0U4QSs4Um9HUEx4c3RNRDAr?=
 =?utf-8?B?b0p5d2FrU3BCd0hkZ05PNXoyQ0trY3BkT2loQ1ArVEI3aUF5akZIWEx6ejgz?=
 =?utf-8?B?c0Yrd1h2djdBTkl4blU5aDk1R2E4cy8zU1h3alo5dGdjTUNvazV3QnNpcHo5?=
 =?utf-8?B?ZFJTRGg4K0lHYlZ4WG84dVd1TUtocTE1eUpQSHAzUHZ6N0hTRmxLSktaMzVt?=
 =?utf-8?B?eStFMVJ6THBTcFZYeEpsc2QyRHo5QktYMmVLRVNyNDN6UkZWcUh5SXBDYXN1?=
 =?utf-8?B?SWc0eW5JcjdoeFRSSEEwN2hVSVJnSHBLVC90eXZEVWNqZEtDN1g2OVVHTDhQ?=
 =?utf-8?B?ZERkLzhZbE1uY25VZ2diUVZnUFZvQUFFVFRzK0grWVh0UWtSZGJXMk5BWDVu?=
 =?utf-8?B?TEVGUVBKTElNSzR5M2M0MDJLcDArQVJPU0NpVURPR3pheGwwdE5HWk5GWGRw?=
 =?utf-8?B?M29PSHRIVEFET3VVcVZ6U01BZmozdi92b2dGNFgrVk5HbHRhRjVkSlBuLzJq?=
 =?utf-8?Q?Z8qc3yRVLpGp/24hXJ+TBJzSr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39505e4f-cc11-4ee5-eb52-08dd50bb8594
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 08:00:48.9888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Un4G22RZNRIwaVt2wGWci+32WMW9FdtRmTi3nVHHQgRxETwWy48NuqYVvlVVRu7DgtXEdiHzDXK0LFjZL7w+3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282

On 2/18/2025 3:36 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Use the perf_to_freq helpers to calculate this on the fly.

Can we call out the below change (in the -1550,7 +1525,8 code chunk) in 
the commit message, or split it out to different patch 

* Adding the if check in amd_pstate_epp_update_limit()

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> --
We need one more hyphen here I think i.e."---", otherwise the version info is 
showing up in the commit message

> v3:
>  * Fix calc error for min_freq
> v2:
>  * Keep cached limits
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 14 +++----
>  drivers/cpufreq/amd-pstate.c    | 70 +++++++++++----------------------
>  drivers/cpufreq/amd-pstate.h    |  9 +----
>  3 files changed, 32 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 3a0a380c3590c..445278cf40b61 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -214,14 +214,14 @@ static void amd_pstate_ut_check_freq(u32 index)
>  			break;
>  		cpudata = policy->driver_data;
>  
> -		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
> +		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
>  			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> -			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
> -			(cpudata->min_freq > 0))) {
> +			(cpudata->lowest_nonlinear_freq > policy->cpuinfo.min_freq) &&
> +			(policy->cpuinfo.min_freq > 0))) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
> -				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
> -				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
> +				__func__, cpu, policy->cpuinfo.max_freq, cpudata->nominal_freq,
> +				cpudata->lowest_nonlinear_freq, policy->cpuinfo.min_freq);
>  			goto skip_test;
>  		}
>  
> @@ -233,13 +233,13 @@ static void amd_pstate_ut_check_freq(u32 index)
>  		}
>  
>  		if (cpudata->boost_supported) {
> -			if ((policy->max == cpudata->max_freq) ||
> +			if ((policy->max == policy->cpuinfo.max_freq) ||
>  					(policy->max == cpudata->nominal_freq))
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>  			else {
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
> -					__func__, cpu, policy->max, cpudata->max_freq,
> +					__func__, cpu, policy->max, policy->cpuinfo.max_freq,
>  					cpudata->nominal_freq);
>  				goto skip_test;
>  			}
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 87c605348a3dc..a7c41f915b46e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -717,7 +717,7 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>  	int ret = 0;
>  
>  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> -	max_freq = READ_ONCE(cpudata->max_freq);
> +	max_freq = perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf));
>  
>  	if (on)
>  		policy->cpuinfo.max_freq = max_freq;
> @@ -901,35 +901,26 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
>  static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  {
>  	int ret;
> -	u32 min_freq, max_freq;
> -	u32 nominal_freq, lowest_nonlinear_freq;
> +	u32 min_freq, nominal_freq, lowest_nonlinear_freq;
>  	struct cppc_perf_caps cppc_perf;
>  
>  	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
>  
> -	if (quirks && quirks->lowest_freq)
> -		min_freq = quirks->lowest_freq;
> -	else
> -		min_freq = cppc_perf.lowest_freq;
> -
>  	if (quirks && quirks->nominal_freq)
>  		nominal_freq = quirks->nominal_freq;
>  	else
>  		nominal_freq = cppc_perf.nominal_freq;
>  
> -	min_freq *= 1000;
>  	nominal_freq *= 1000;
> -
>  	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
> -	WRITE_ONCE(cpudata->min_freq, min_freq);
> -
> -	max_freq = perf_to_freq(cpudata, cpudata->highest_perf);
> -	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
>  
> -	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
> -	WRITE_ONCE(cpudata->max_freq, max_freq);
> +	if (quirks && quirks->lowest_freq) {

We can avoid the "{" for single line if statement, to keep checkpatch happy 

> +		min_freq = quirks->lowest_freq;
> +	} else
> +		min_freq = cppc_perf.lowest_freq;
> +	min_freq *= 1000;

I see that this min_freq part of the code is unchanged, just moved few lines below. 
If the moving is unintended can we avoid it, so that the diff is optimal.

>  
>  	/**
>  	 * Below values need to be initialized correctly, otherwise driver will fail to load
> @@ -937,12 +928,15 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
>  	 * Check _CPC in ACPI table objects if any values are incorrect
>  	 */
> -	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {

Shouldn't we retain these sanity checks for min_freq and max_freq?

Thanks,
Dhananjay

> -		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
> -			min_freq, max_freq, nominal_freq);
> +	if (nominal_freq <= 0) {
> +		pr_err("nominal_freq(%d) value is incorrect\n",
> +			nominal_freq);
>  		return -EINVAL;
>  	}
>  
> +	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
> +	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
> +
>  	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
>  		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
>  			lowest_nonlinear_freq, min_freq, nominal_freq);
> @@ -954,9 +948,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
> -	int min_freq, max_freq, ret;
> -	struct device *dev;
>  	struct amd_cpudata *cpudata;
> +	struct device *dev;
> +	int ret;
>  
>  	/*
>  	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
> @@ -987,17 +981,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> -	min_freq = READ_ONCE(cpudata->min_freq);
> -	max_freq = READ_ONCE(cpudata->max_freq);
> -
>  	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
>  	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
>  
> -	policy->min = min_freq;
> -	policy->max = max_freq;
> -
> -	policy->cpuinfo.min_freq = min_freq;
> -	policy->cpuinfo.max_freq = max_freq;
> +	policy->cpuinfo.min_freq = policy->min = perf_to_freq(cpudata, cpudata->lowest_perf);
> +	policy->cpuinfo.max_freq = policy->max = perf_to_freq(cpudata, cpudata->highest_perf);
>  
>  	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>  
> @@ -1021,9 +1009,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  		goto free_cpudata2;
>  	}
>  
> -	cpudata->max_limit_freq = max_freq;
> -	cpudata->min_limit_freq = min_freq;
> -
>  	policy->driver_data = cpudata;
>  
>  	if (!current_pstate_driver->adjust_perf)
> @@ -1081,14 +1066,10 @@ static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
>  static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>  					char *buf)
>  {
> -	int max_freq;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
> -	max_freq = READ_ONCE(cpudata->max_freq);
> -	if (max_freq < 0)
> -		return max_freq;
>  
> -	return sysfs_emit(buf, "%u\n", max_freq);
> +	return sysfs_emit(buf, "%u\n", perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf)));
>  }
>  
>  static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
> @@ -1446,10 +1427,10 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
>  
>  static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  {
> -	int min_freq, max_freq, ret;
>  	struct amd_cpudata *cpudata;
>  	struct device *dev;
>  	u64 value;
> +	int ret;
>  
>  	/*
>  	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
> @@ -1480,19 +1461,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> -	min_freq = READ_ONCE(cpudata->min_freq);
> -	max_freq = READ_ONCE(cpudata->max_freq);
> -
> -	policy->cpuinfo.min_freq = min_freq;
> -	policy->cpuinfo.max_freq = max_freq;
> +	policy->cpuinfo.min_freq = policy->min = perf_to_freq(cpudata, cpudata->lowest_perf);
> +	policy->cpuinfo.max_freq = policy->max = perf_to_freq(cpudata, cpudata->highest_perf);
>  	/* It will be updated by governor */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
>  	policy->driver_data = cpudata;
>  
> -	policy->min = policy->cpuinfo.min_freq;
> -	policy->max = policy->cpuinfo.max_freq;
> -
>  	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>  
>  	/*
> @@ -1550,7 +1525,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	u8 epp;
>  
> -	amd_pstate_update_min_max_limit(policy);
> +	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
> +		amd_pstate_update_min_max_limit(policy);
>  
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>  		epp = 0;
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 19d405c6d805e..0149933692458 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -46,8 +46,6 @@ struct amd_aperf_mperf {
>   * @max_limit_perf: Cached value of the performance corresponding to policy->max
>   * @min_limit_freq: Cached value of policy->min (in khz)
>   * @max_limit_freq: Cached value of policy->max (in khz)
> - * @max_freq: the frequency (in khz) that mapped to highest_perf
> - * @min_freq: the frequency (in khz) that mapped to lowest_perf
>   * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
>   * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
>   * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
> @@ -77,11 +75,8 @@ struct amd_cpudata {
>  	u8	prefcore_ranking;
>  	u8	min_limit_perf;
>  	u8	max_limit_perf;
> -	u32     min_limit_freq;
> -	u32     max_limit_freq;
> -
> -	u32	max_freq;
> -	u32	min_freq;
> +	u32	min_limit_freq;
> +	u32	max_limit_freq;
>  	u32	nominal_freq;
>  	u32	lowest_nonlinear_freq;
>  


