Return-Path: <linux-pm+bounces-18787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A1F9E868B
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 17:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9871639D8
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 16:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C9516F858;
	Sun,  8 Dec 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="svW9mpYf"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC616EB7C;
	Sun,  8 Dec 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675724; cv=fail; b=TqbJr2ckL8ATSZMb9o+fnI/Gm6y8eFfovtRS4iEiM5EdeO7zJAsj1nNg+lSbT17SU4IRvunzXO7tcWsbJhx4K+cmlLBdw1i5aH8CNDnQmSeKDDQ+XAiRob/bVelizizLV6Tst39OExoAuZ3VE1oACaNVQa5HEGoYynPvvEHSuB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675724; c=relaxed/simple;
	bh=wo10e7u0vuQ+Bzx7uKgV6k2t39MYLoeLVTXGh4PywV0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LwLi9GzW3aPMJ77L6OHMnvrgDfZ1cyPWRQX9b0eulXG/pCKY2NfPkr5w4UIVROlrsu3HLlzCrIJh/y9+1ukTfTe/xMtp9hF/7WXbgQPVynpU8obB9x6jdbccvmhpWb8LLDxLg0z450/zr37L0kgojWx8wcqxFHi8rWx5n872sWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=svW9mpYf; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpBWQla9UCzx7l+fA8fAkhzpthl31vm574/QO4Z88BhXB42gVDEO8hJXk+Z4LYHK4mPVJMInkE49ApLjXqxS9oqkz7/xrJSfpjb6PLpK7C2RyMScgluEwE4TrAlvrCS8t2gO3VrPeoWy0FZlzwbCwNqSm0cWo/m9mcBdSrKK6PMcfb2tCrEopdI5Pz7J8s1KdOKOIFHBo71MBNXvRzhvxQttyQPGmFLpv/LoErn0QOs3QvocJ5Y1rnJ2nSb2PdbE3lGKjwZYJwfyF3vgwum9gv1J5fwyhe8MZBFAMjEBwyIe7sopVQKOZiRshVbWkNXAGrHmUOltzgLu/52E5nrHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiyFfzw1A0rY5CVqNfTrpsTBe1MyTmIlWXqdu0fs8wo=;
 b=ezKdgQoJksOlyweT8ROtgsEevzsOTxdVDmeS30RRU9YXmUcca79eCHgEBi932r2BtfjEar3kg7wYsdZiCO/FxnH58rQBm1wdO0sGMdht2dLL9Nam9B7yfBibNza2QhI8AH2F+5wES0TLEBTOlVOpD1emx4nQGqYlQA2u1JfePgxgrlP8Jm1hnfoO+Sg/wzGzL1Xl+To8dd1sOiYQPs7da2FVWZmEeFAbIyMUHxPDpKOCVOV/FBNPMDHmOSePAL9qFY+0h2tsBtX0KuVPu6REA87UyNHZ6t7LB/eSaNGxv81VX23ePccaslwPAJImKYzK8/8K4fO1VyyohEcNq45BlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiyFfzw1A0rY5CVqNfTrpsTBe1MyTmIlWXqdu0fs8wo=;
 b=svW9mpYfG/Y3KAbF2KO7vr3goDvHnx3jxEqUZHzQByHsx7T3KAuggUzpgqKu+N1crsp1pvlccvQZ8pbdoxZI9NOv/ZbLcOw1en3Pknr3lI2Yp7T+GX0OBHOhbot9XDXxVcdxHEIlJVDtHHYNxmC+xa3PcAPN8L2rqgNbc9P5T8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sun, 8 Dec
 2024 16:35:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8230.016; Sun, 8 Dec 2024
 16:35:19 +0000
Message-ID: <62f0402c-89a4-4ca8-b443-fbc9cc3b2055@amd.com>
Date: Sun, 8 Dec 2024 10:35:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] cpufreq/amd-pstate: Set initial min_freq to
 lowest_nonlinear_freq
To: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, gautham.shenoy@amd.com,
 perry.yuan@amd.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241017053927.25285-1-Dhananjay.Ugwekar@amd.com>
 <d89bfc1b-37cb-4d8b-b944-8dc385915bcf@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <d89bfc1b-37cb-4d8b-b944-8dc385915bcf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f16d77-a14e-417b-f750-08dd17a64d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUUra0FWZW5rQXkzc1l2a05KT3NqWVJJcmZ4RnlwTUI0ayt3OUVJL2h0NThZ?=
 =?utf-8?B?Nnh0Q1dUb2dwZDFmT3RDK3pqUlhlemZVeHZFWFZ2Wk5hVmJjMnRDdlNoU2Iz?=
 =?utf-8?B?OVJ3K2ZadkVtTnhvWS96eThMZnFacFJqS2JYOHRzTzRPR1pGbXRqQ05VS01j?=
 =?utf-8?B?VkhVQm0yQVdiU2VkVW5rRlhDclVyZzlVM0V0YlVaWWVWRklCajlPUEJqelFh?=
 =?utf-8?B?cG8yRk9uajZqRmY3Z0ZvSXhHeEVkOUEydUo2YXM0ampnVWFSSHBmeXZaZXRJ?=
 =?utf-8?B?NXE3SDZEWGh1YXd3U3A5dXJ2bHF5SXN1ZVA2RTVpUmxlQktpSkM3WlZuaVN3?=
 =?utf-8?B?YUVEWjVRWGNLb1ZVdHVDMmdheXd5bmwvUkpCNWpPN2xwOXdRMHpZalgyN2xI?=
 =?utf-8?B?WWQ4cXRQVHovelEwZGR6aXkrNjdrbmZFTXJTN3FiZ3p3RmlLMzIyRURIN1V0?=
 =?utf-8?B?RVBZWGQ0NjFQSGNlakwyUUNEUVQwcjc3NmhXOG5GTHczaGxaVVVBY3hkeFp1?=
 =?utf-8?B?aWduUW01Q0U0dTdwN2ZFTFozVEluNHMzTGgxL2N4b0JlSG40enlCWmk1Vncy?=
 =?utf-8?B?eFh1QTBkSmJ1ZjdEUlFpTzZPa3pNVzFvbjRqK0JNcjRsb1d6QXF0a0RvR1B0?=
 =?utf-8?B?VEpkUkR2cjZPc09Gb1lBTW56N1p2SFovNjN5VnZXV0h0VVlkMmFJSXZ3b0F0?=
 =?utf-8?B?R1pYWk9lbWdQTUZ6VTJ4WTlLZlloT01hZzBIWXZEOW5BMmlqd0RrQ20yZEVG?=
 =?utf-8?B?bVJYclR4Ykk4NlhzckhsN09TTDJ5SEVUOTNJYSszNWZBcGhwVHpxTnVUTlV4?=
 =?utf-8?B?bjZnUGxaaXF3L2RMdzBpR2dxVm5nSExLLzFwMmZoQXdGSWxCZnQvdFAxS2Vq?=
 =?utf-8?B?R2w2STh0MDZyZ2FmSW5LL2FMczhQekEyRERIc0RTZ21mTTNGbStOcTVXNE03?=
 =?utf-8?B?eHd2UW9OWWxTR05wc0YzOUJNNmo1UFl4SlJGTmdLbXozQ2w3S3lxbXVkMHcz?=
 =?utf-8?B?T01vc2pOZjd0emNWTStrOXFLaUJVck54b3cwcTdkNU1FdUFXNXVRemZ5dVRj?=
 =?utf-8?B?OE9BQU4vTnNLVlNZcTNRRXQ1M1ZTNlRlalF2R2dFb0lCTmthRVRXOXFYaGU4?=
 =?utf-8?B?eDNsYzFPcUtDSkFLOWRQWHpkNlRuejZuSW5PdU1OT2N4d3Jsc1k2Mk45Wmto?=
 =?utf-8?B?WmtCU0ZnTWFSL1hVQ0hWT0lHQlZWZG5waW8vTlQ2NWhNeWpya1BPbzBvemR6?=
 =?utf-8?B?L2ovc0FFQnB3UWI2KzJSY2hFakJ6Z1V0YU5rM0M3MUh3YTEybkU5SS93OFVW?=
 =?utf-8?B?VnJEbXBWNWhhRUc1U0o3WUxrbFJYUDFib2xxbFZQbkpXNVJBRW96SDRDb1Ax?=
 =?utf-8?B?WHVTQWErOGlsY1dHZG5reDEwdDRPVTFvZ1pLVVltOXhMQ3pQcnBzRE0vRzhP?=
 =?utf-8?B?eDE0OXdJYlZWQnBqaTdaUVhITmd1VmcrSnJHam0xTDVDVjRsOWhBaWNSUUsx?=
 =?utf-8?B?OEtQMUY5dW82WmF5L0RwWW5IdlVta1lhVHlWdDhVZVNEV2dHYUFZRjNCQ0ph?=
 =?utf-8?B?ZjlobkQzR1IwVjNLWWFybmpIOWJkSm0vS3BlWVB4TVBxaktVMDZhRGtMa0NI?=
 =?utf-8?B?M1pzSDFZcm9rMUh4UndIN3RWTE5YcVcxNjJaWHEzMXdnbnNObklaR3g5aHFw?=
 =?utf-8?B?bXZVaHJsdnQrU1dvZXE5eVFya0liaU5nUWliOE8xdVhEUUhvTUpBRFlpTWtt?=
 =?utf-8?B?eEljbWh4UnFqc3pUandpcjNscUtGeHoxYzNhelpoQk1FVVE2ajZGU1FyNlJn?=
 =?utf-8?B?UEt5VDhNNldYRE5GY1ZYdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3lYeXVCMm5xcFBoSVY5RWhVZXE5K2RDc204OW8xM1Vwb2hUS0Q1NjB6TSto?=
 =?utf-8?B?RVl6MTlNSWdzT3RHS0hpaFNXVzF6aTFMbXk4enZLZjJHN3lIOCtkS29ydG1O?=
 =?utf-8?B?bFozbi9wcWYyaXM4SVRKMGxGRmZhT2tZMWRrcFJKOFFNUHBWaHVGaDZjK2VE?=
 =?utf-8?B?a3J6TjNWZWpzbU93RnI5aG9CSUc4Z2thS3BTVUVLSnJneGNVN2FxMlVseVdO?=
 =?utf-8?B?ZHlmK2RYNFFCbUpBL2k2cEZjSXR3cHNPaWFJWFZ5eHVoZUlocVV1VFpPRlU2?=
 =?utf-8?B?a09aOE5ZbDRlV0N2azh5WTJ0ZWE2VUdDazA4QkNXbHp2NzNBNFpGU2tWYndP?=
 =?utf-8?B?cnp0K2RIak4vL3hxTVhSQzVQZncrMUcyVXg2TUNMeTNlMVRFQXJjSGd3RUI2?=
 =?utf-8?B?YnczMTB1VWxWc0FybjRrc1o3TUNudzhKWERWdHYzbjd0ZWNtejdpSnovbG9i?=
 =?utf-8?B?VkpFb3lZRUlrNVJVWE5yNy9kT21Gd3hnUjgxQTFJR3pldGh1NWdmYTB2MmpK?=
 =?utf-8?B?dFdqYnM2U3RKOVcxZ1BNZlRlWTZSV2hoMFZzRVBrMjdJdDBURXhrdmcrWGt5?=
 =?utf-8?B?Q3YzT3YrU0Vsc2tjOUlLOUFrQlRqbzNBTmJLSk56bXBTYUdiVjZxK3E3V1I2?=
 =?utf-8?B?aFdtYkVGaUlIL2xGN28wUEdrYWcxeWZzQnluTklacVlNSTd4RVpKUTZWMjZV?=
 =?utf-8?B?TU85QnU4ditET1IwVkF0aWp1OVlqZ3MwVklBOFQ3NTVaK1BvK0drak5EQ214?=
 =?utf-8?B?d2ZOVzZMYURiZmxoUk9CVmtjUmNOV3kwanhjeU42Y1Z2MHE3anZIaUl0Tm9X?=
 =?utf-8?B?YllBV2p0bU4vaVVjcXh0cTBJckYvcWNZcDhSM1BWcFIvWm9TNXhTYTZtV2pU?=
 =?utf-8?B?dUlXU1N4dnBrbXRXUk5KbzFvcURHYndWNk1FeDU0djZ6dWNkQVZkczZSSDRu?=
 =?utf-8?B?Y05XOFU2ZW8yVU9QaGxKZWxFRlorQ2tpbUdWRWV4Q1NIMCtVbnJ0QVFTZk8z?=
 =?utf-8?B?ZlZJYlZRbHZyMVN3UUNnNjVCWlEvZU1ZQnZHbWFIZVZ0M2xWOGdlNVpyOGZv?=
 =?utf-8?B?eUxVTEorZmlBUnBsKzhDVzZXeXhPcHJwcmNUelR4RFhLbHp5aE45U0FrMFZt?=
 =?utf-8?B?TTVmU05xaisvU0RrU0ZIMlFQMzVWSEtNL2hoZXgwejk5OHBBVW9tZWtJYUpl?=
 =?utf-8?B?THRPQXBBOUU2Y1A3N0JJSnY2dW1lS1FHRWVpcDltbzh3ZnJiWHErKzNodFBE?=
 =?utf-8?B?VjVBbDJzY1RnWW5LcWRvZXRtaVZVNERpNXV1c1BGekZZOHBCMXZ1Y0I1NGtp?=
 =?utf-8?B?VmszV2ZXZ3gxQUh5andZZDA4VkNVQWU3c05PQzBPazJ4MngvaVg3d0NaSU84?=
 =?utf-8?B?b1REWDVRU2NQdGZmb3pmK3dYT0tVdTZ3d0VtWDhjL1hrcmNseGNFcmdKK0pH?=
 =?utf-8?B?RXNZdlgvOUJGNEF1c01Ma2tYQjNEQXpKVUFuWVdySXg3eVIzV3haRUlSamlM?=
 =?utf-8?B?REQyaVVvMVYzOVFjT2h2QkpqTU9MMkJxVGgxeGZLQkNHd2VhMlMySmtFNHpG?=
 =?utf-8?B?dnk0ZnFXOHhQZEdmUmJXY0lOYitOTVJWSVB6alNoQWtTU0VUUmRUbENiV2RD?=
 =?utf-8?B?SkN2Y0VwNnM1RzBoVHJEZm9acUVXVEV3M09CYWhhbGRyREZiY3BiR1RudHhM?=
 =?utf-8?B?TlI5SUh6RHI3cTNpcjIwTWVxQlphU1JSbFBWcUN0MTg3L2pWV25YZFNicEFw?=
 =?utf-8?B?NTBEaDBVK3lZM2pMYlZ3bUoyakxuajRnbVF0SFlneGdTa0Izck5iaW8zL1hT?=
 =?utf-8?B?UkZ0VENLdGFaeDFXRnZrYXA4M0JsR05pU1V4YWlyZ0ZSZjN2NlV1YWZqeGpv?=
 =?utf-8?B?MUd4Q3NlNCtxZ0ZxQVk0OGU5b1NIOTRySTJkdzZuRmNtT2VTQStKRG5zSjd0?=
 =?utf-8?B?RkZSa25taE82MVVqYk9uUUExRFQwdzRUcFJxYndTU2VZS0xjbkZzME4vdTls?=
 =?utf-8?B?VkY1R3NuSzVSVWdvaHUxVjRCaktNdmlraWNlMmF1S1lWWjNJbFNXU2JvU3lF?=
 =?utf-8?B?bkQ4eDFmdzdXSzA4MWJPbEVQaWo1QTVOZWE1aFFkVW9XMVN5Wkk0clViWC9J?=
 =?utf-8?Q?XwzwXM5yNJ64nD+IHDJKur9rx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f16d77-a14e-417b-f750-08dd17a64d8f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 16:35:19.1530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgTuG6/8JrlBlBBtVxyOrFbEKFBgA0Y1E9v4k22VRN0XYeYS7vZprdRZI+ps9Wy6LcBD0J2UUfIfnM5aFOPLTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070

On 12/8/2024 01:54, Hanabishi wrote:
> Hello. Maybe I'm too late on this, but I have some concerns.
> 
> On 10/17/24 05:39, Dhananjay Ugwekar wrote:
>> In other systems, power consumption has increased but so has the
>> throughput/watt.
> 
> I just want to bring up the fact that this change affects all governors. 
> It sounds good for the performance governor, but not so much for the 
> powersave governor.
> 
> So the question is: don't we want the lowest power consumption possible 
> in the powersave mode? Even if it means decreased efficiency. Powersave 
> by definition supposed to make battery last as long as possible no 
> matter what, isn't it?
> 

No, the powersave governor isn't a one stop shop to bring everything to 
longest battery.

By your argument we should set the EPP to "power" by default and "boost" 
to off by default when the powersave governor is enacted?

All of those are far too aggressive for a default behavior.  Setting the 
lowest nonlinear frequency as the default lowest scaling frequency is 
about having a good default that balances responsiveness, battery life 
and performance.

Like all knobs anyone that doesn't agree with it can of course modify it 
from sysfs.

