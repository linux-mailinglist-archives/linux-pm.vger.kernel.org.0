Return-Path: <linux-pm+bounces-9748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DB7911F46
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 10:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D4B28B5A5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E60716D9B3;
	Fri, 21 Jun 2024 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p4RVrMHF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F518E20;
	Fri, 21 Jun 2024 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959775; cv=fail; b=hBSBfUNB2akBiziloc8y8KkR6Kinna8wRsJeCRrygCputS6RIf68I7+xdZSXAQSAwdfasvdBxbNKNmzDXybYvwKdnOzR59SYU0dsuzvdUrmhmeKizDtyqaWGadNJBmUBEGqTpdyHthWDtxzAPY4BZClIms8m49BFIP6jzkijrJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959775; c=relaxed/simple;
	bh=MmdH05nfOHg8jrqVZQ/8kylZ7y+AsywzZLlNYLm2JcY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sI2dK2v4b1DT68V5O4RY53XCoB7MwSGthbGJ91xrrQsfbN8eRvMlVuR+xenU1qgnCuIWxeY5bByRgXkiaFl8eVC7I9RhZOB1Hq8+wN+2yDE54lEE/0iYWLfmXihLkx3Da8J8RQUevYQ+cs8HJwRV4kk14teWI9SNjduK9ulkK7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p4RVrMHF; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWhLyZD4YrdX9thCsNMqCVzBXuBtiwjoiEU9SA8rPht2wmxZWroFPtF1VoAI7YkUE9lOI8jPJdCGtUw2W57i3H2uGURqidE+twKwgxKU14PRXTM+JGO/3ryHXAjdnsO67P9M0CaqTZ3cyp89DizFN8rWgsiBuPLs5iO3OfNoSZK6tQidnrGA8CuTySmd5kM9zfbrBy74cCEKN7n3421/QUUbzR9U8o5MJ42cfq0FJfTOG8uNw3zPA/4uirVEMbQQ+8Dulyqs6Fmpa/2oS42AQ80EpKUN7IyhiSTagvkqhLyVBL+lyQQhsHGBGl3L6vkJxztiJuYBCzUs3frE+JCd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq7s3a/2x2czjTCy0TZa26wKrn/KS+jEwew+cP5hH6A=;
 b=XOts1OunwbgL6Hr41fBbMQmZIxfh3C021rJcqBL7mputmVVCwp2DIpfg+pqyQRwIPYZua9m9cq2tKqyA1hTI5z9UPJ61Ry7JaFFOBmxMb1x/syAXCPQ0WZOtu9BmgZ97pkm4zhF5nqD1qQ9C4NTzHAZoriLSdLXeaUgsRTpYouEXuP0Wpfa4qaUthcrq5EK3HR7Rz9XHSYndSFNPMk46FbSHJ5bnYeSDwz9kNoqDKI04Fn5n4L1yILYbbFygzQvngzQMsKTKqrFirq95ekU0JyECVpQOglzamFAyN1ir8lcHmr4tyIiMdxfaMnFfWNM8PrnbuM2d9lMeH0KBU/Jkmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq7s3a/2x2czjTCy0TZa26wKrn/KS+jEwew+cP5hH6A=;
 b=p4RVrMHFB07/7LQztLNRAVKPwXFQgdhVQHBHy0p5PQSDKYj5NELIBas8cYTqloi5dJiAAp8gYfZzC3TOi9ayfKKAFl6+4HO9F6wwCAKbkKZyb7YEsS+mspQxiO7trkOg6f6XgdFIsPswGzAYlkU38oSsCw2T4JyKlPH/siTL5vQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 08:49:29 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 08:49:28 +0000
Message-ID: <79fd7c1d-2d3a-46b4-8a0c-56bfda036a94@amd.com>
Date: Fri, 21 Jun 2024 14:19:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Add per-core RAPL energy counter support for AMD
 CPUs
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, ravi.bangoria@amd.com, sandipan.das@amd.com,
 linux-pm@vger.kernel.org, rui.zhang@intel.com, oleksandr@natalenko.name,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org,
 gustavoars@kernel.org
References: <20240620125703.3297-1-Dhananjay.Ugwekar@amd.com>
 <a26b9774-f9da-763e-aebf-5d66a6d44377@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <a26b9774-f9da-763e-aebf-5d66a6d44377@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::15) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: ee05f329-03f6-4e31-8494-08dc91cf0f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFphT1pPbmFsZzBEcjJhVnFRU3pxWVd5UlhEdDhJZGtwY1JhS1ZDZUhUTjZN?=
 =?utf-8?B?WjN1RFJFd2QrZ3VmMmFlaHJJRTlQRENXZFpMRFNVVFNSc1l3UjFyTmtEZUc3?=
 =?utf-8?B?ZUUvcTByRENYcTRtRisvNEVYUUdROEEwRTAxZ2svK3lxYVVONHBTRnhYdFpF?=
 =?utf-8?B?KzZvK0wraXh2UlZYRUtYdDRrYmRWQ2RuYnNVcGRONDlibE5jcnZ5aHdxTmVP?=
 =?utf-8?B?MkF6VGYvRDFGSHdPNTNFcGtrWXZkY3RFZkZsSit5TVowWll6OHhtQTBSVGJU?=
 =?utf-8?B?U3V1eFNkUXhsdjc0cXpPdUVLZGduK2xFaHc3L2pMdVlCLzRpSnVsYVBJdENI?=
 =?utf-8?B?WlpmdW9Ja3J5U3BESllqMS9OaUZwUmxyZHFBcEVscm1SUGN1d0xDVUpQbzZR?=
 =?utf-8?B?TWs4dVJDWEVXVUJJZllFc0l1VlRuQTk4VDFEOTU0YURFUVdCYlAwUG1meVBv?=
 =?utf-8?B?Y0d2NGhnMm9ZajNxRllmczdMZzVWaWsxVW5oQnBMUHUrODVwTGtxc0ZVMVY3?=
 =?utf-8?B?SFM1eWtMZ2VUNUM3VXB3bVBCbWlVcGtHUGo5YXJ1cWk5YVpVOGJIeit3MDRB?=
 =?utf-8?B?YW1hNmhwR3RDdVJiaDROZW1BTWlRa24xRFhqb0RKQkVoekVDeDk3VjV0eERw?=
 =?utf-8?B?K3hSYWEwbWZLMXQwaFFVRE1GU3lacmFpZStxSVFwVDZjd2xGY1BKOHhxZVc4?=
 =?utf-8?B?WS9aWTZHc0liNEZXYTFDdVhDWVZDblE2eUtBWHZpUzNEZHZOcEM3dnNNcElK?=
 =?utf-8?B?RVpJMnBvZHJSbDBURFRpaThna2VvZ0ZyVlZvWGt2MXJtL3IyT3Q4dElCK3Vm?=
 =?utf-8?B?QlpOTXVzV09jTktrWGpKM0VPbFdqTWtDWitkZTgxK2ZBcmN1N3hCaE1DR21N?=
 =?utf-8?B?SXZYNjdFWDh0a1U2dlNtYUNqMWZMcUNSNElYNmhMQk1IazJrL1VBelJ0ZHAw?=
 =?utf-8?B?WkIzdDYvRjVDUHlSV1V3MVZXcWM1MGZSVkc2TFZ5OUp6MHoyeGFXYTVxS1JD?=
 =?utf-8?B?VjY1cFpxY09vU1V4aXBLNlRLbHBGQXZHTEFoNVRNYStYQU5mTnI2ZWNWRzNi?=
 =?utf-8?B?VC9uR3NkeUJzVWZXYXQ4ZTV4VlhqYnl0bmZSR1F6N3p5cnBFV3cwT3ZzanlK?=
 =?utf-8?B?NFFXRTVDQjBrNjNkTW9yVFY1Wk91dTUwN3pVbjFlcVdkQ1JyUUVQN2dsMkRT?=
 =?utf-8?B?N3VxUFlkaTJweVloZUNJZWdJTEtiQjdHTlZ0Y1JPR1VLODBiQUppS2h2d2Jw?=
 =?utf-8?B?aFhmL3NBdGhwditiT3VZYWR4dnRSSm03aHhyU2xEbWZoNnJ3c1BNaG5QbWNa?=
 =?utf-8?B?V3RqSWo0a2tRZ2Q3U1g5WDZLQ2FCV0c1QmVRanFobXRyVG9zN3NNMVY3RGlE?=
 =?utf-8?B?M0Y2bllXYUw1b1c1NW1tS1hsMlp3U2IwNm5VdENFMUF6ZTFLa2xmMlZEUFJr?=
 =?utf-8?B?VHlJMEVrMTJVaFBTVmZTZTFKeU9lVlNtQk92bjhyUmwzTFM5a3NSaisrRXRP?=
 =?utf-8?B?SWtqWEh1RlAwZ0R2WmhXSHB0WDNLbjBKenhYYXMwOEVhQldDa0VWMEh1NGly?=
 =?utf-8?B?QnMza1hWOHBlUjFpdVdkMlNubWhaSGJ1ZWp2UGE5UlN0OWVBZzZEQnBQekxr?=
 =?utf-8?B?UW92THVENkw4RVljdWNtV2w5M1BicXZzREFaalpJM092Ky9BcDRqOGNpSW5o?=
 =?utf-8?Q?87K4ddPliM/vCLN7mPE1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2M5VVk4bW4wdFhtSVR4SGo3N0YrcVZEL2EzRHUvOG9xbEE3bHIxTUlWcGg1?=
 =?utf-8?B?MEgxTXR3TjVHTkRwL3RnUTJmd2Zmc255TDVZWDlvQmhSSTJUOVRpWVJlZDFr?=
 =?utf-8?B?alhtSndlVWFKS05JQ1NmbndZeFZtN0piVXhwRENpelNjcVdSWHJ3Rnp2b0Yw?=
 =?utf-8?B?aFNkaWRDaGNLSzlwUEZCaHZxVGFCQmhUWnhoa054b2FmYnJrSktyS2o0NE1q?=
 =?utf-8?B?eC83dXJvVldudlZmelhheWkyMGZvbFZIdStJTnNxQ1Y4Y3JMSHpyYnY0ZjhX?=
 =?utf-8?B?ZFRhVUdINUNhMnpqcmNNY2RTa3VUM0pyL0VVOFdyWUVkVGxrbllMdFZ4d3Yz?=
 =?utf-8?B?RndSaDlKaUpySFl0QUdTUzZrSjlqUkxyNTA1MlBsakovYWNKN0lQclQ0eEVp?=
 =?utf-8?B?RFVubkhpOHJWTjVLUVpEd1czU0JEWFZsMjkwWFpyYVh4N1FDeGlBOVQza2pV?=
 =?utf-8?B?dVl3emtOVENjVzgyNWVHdUVOcHN0Q3p5REpWZHpLNWRCT0hOTm40enZSaGZr?=
 =?utf-8?B?QVN5MTNkRmpEdDN1Z1BWQWhEUHdzNHlIa3k5N0dtRGJXd2ZGYTdGU05UZkZ1?=
 =?utf-8?B?UEdKK1JYQjVHVFNKT1ZHV2RWV2xoc3lwWmVLeWlGdVNuanJnUVlUSFlKdGpN?=
 =?utf-8?B?Ny92WExIL1BSNE5hMGlDRmloUjYyNHhqYzZIYXMyc04wRW1mcy9EKy94VmJ3?=
 =?utf-8?B?bDJkTEx0L3NqVWtqVzdRUHpRbEtqQkNSQmRKOS9jYlo5S0MwbHJ5WmdtSVd2?=
 =?utf-8?B?ZldaVWp3MzNDYUhzODNXckhpdVFXNlJvSTlyekhFRGNmSmpOMU1RcEU1dmlE?=
 =?utf-8?B?Z1h4TVM0NWZMRkZHK250dTJLbUwrKzR0cDRSZ1RBR2YvenFTZGpqK3FQWGRP?=
 =?utf-8?B?dUdGNVZtaUZkZ3ZpUXdGUzJwVnhwaWpxajEzWmJNRDNFQ2J3KzB4ZXdVcWxK?=
 =?utf-8?B?Q0pvcXpNSmxXbWplbnk4SmRCMnhnVjh3SUFxUVN0ZWdhbTBiMGtxL1Nnaldu?=
 =?utf-8?B?OGhyTUZiUEFjaDNCQWR5c0hTODZCVkhvUXV1ZDduL0xzMjNHMGNZQUg4b0hj?=
 =?utf-8?B?U1JXamFZMmJacjFmNU5DR1V0ZCtWbTJGbyt3Z2hVSzJBMXJqaGE1YkdFWXM2?=
 =?utf-8?B?dFpscmxZbDhMZjhpcXRyY0gyQzY5T0pEclp6cWVpdGFlK0tOaDZpSlJMUTA4?=
 =?utf-8?B?WXJFYXBQdUg5R3FmcUJyR3AzbWZja2dETDJmb0JHMUN0YzRXVGNxYUNhOTVl?=
 =?utf-8?B?TXhZQ2lhSElZaCs2dnRWNGE4NEZaS29jbVo1OERmcWJ3TElEeU9GcTdOenV3?=
 =?utf-8?B?Rmt3UWlaQ2lEcStLUzJWNnRJM0FCczdtRlh2T0lzdFp5dnBoeGM1VDVjeVZo?=
 =?utf-8?B?UGxINGdiMWcraWVmQ3U1ZHloNjJHUUpGZ0ZZUVBSWU50NmM2N3ltYXVENzlB?=
 =?utf-8?B?b2pKZjNZWGdvT3JRNEoyWkFMN2RJL2poWXY0Ym5OOUU4aHYvVEJaSlV1ZFcr?=
 =?utf-8?B?VVVNU3BzeHFjY25tZ1JqMFJCMkFTNm81NGZSV1VzOWhnT3pDR3lUbitFKzM3?=
 =?utf-8?B?cklRNHR5STB6ZWtuQzZJcUdWdzVBRW5xbVo2VmRPV1B1eHNFM0tTMnQ1a09i?=
 =?utf-8?B?Zk9CQ21ISGtKbzZzTlEzVk1tQ2lwQ0dmODZmd0FqTDZRU25CUlFpNjlwN1py?=
 =?utf-8?B?eGp6cFRTcFVJeE45UGo1TjdIUjJzY245VVcrcXFnL1g2aVhHT1ppZUpwNG9m?=
 =?utf-8?B?RU1lZUVSYStULy9hT1lIaWVmZDJ5QmdPZTlId29uQWlnYjU1VUQwMUhLZVhD?=
 =?utf-8?B?dlc2VmR4TXd3bW84R0xJWXJLMXc2aFZENXo3dVFKVjhmbDFFSXpTZ3VNbGxh?=
 =?utf-8?B?UndLMmlMZjBib2Z2aDRIWmtCdFIvR1Q0ZXIwWmxWSk12d2xWL1QzcWRJckNP?=
 =?utf-8?B?c0V6OUpKd2hva0hyd0MwUU1VbmdZZGpsdm9yVk5mTzlNM1RSNE9NZ2Yxb2Jt?=
 =?utf-8?B?cEVMTDVVdkpMbXhNMVhMSG0rMm5teVRYdWEydmJIUjRTcTJKK2E4Tm9seHBm?=
 =?utf-8?B?UWJ3TE9BRHhQNk9uL01vbmN3ZCtJbEJuY2U0OTZkZnBXS1QvUjIyRGUvTklD?=
 =?utf-8?Q?+Kix9wZNd9Tk56AXkc09qGbvj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee05f329-03f6-4e31-8494-08dc91cf0f21
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 08:49:28.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVVjgr5FEX/pZMoSUD3jWL3XhyJCdFj/Pvb2DViy9l92Qaxv4QCS5SYIO1L4OmUtq2v/ItyaV6RIKy49AVQC2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

Hello Prateek,

On 6/21/2024 1:54 PM, K Prateek Nayak wrote:
> Hello Dhananjay,
> 
> On 6/20/2024 6:26 PM, Dhananjay Ugwekar wrote:
>> Currently the energy-cores event in the power PMU aggregates energy
>> consumption data at a package level. On the other hand the core energy
>> RAPL counter in AMD CPUs has a core scope (which means the energy
>> consumption is recorded separately for each core). Earlier efforts to add
>> the core event in the power PMU had failed [1], due to the difference in
>> the scope of these two events. Hence, there is a need for a new core scope
>> PMU.
>>
>> This patchset adds a new "power_per_core" PMU alongside the existing
>> "power" PMU, which will be responsible for collecting the new
>> "energy-per-core" event.
>>
>> Tested the package level and core level PMU counters with workloads
>> pinned to different CPUs.
>>
>> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa
>> machine:
>>
>> $ perf stat -a --per-core -e power_per_core/energy-per-core/ sleep 1
> 
> When testing this on a 2P 3rd Generation EPYC System (2 x 64/128T), I
> ran into an issue where it seems like the energy reporting for the
> system is coming from the second socket. Following are the CPUs on each
> socket of the system:
> 
>     Node 0: 0-63,   128-191
>     Node 1: 64-127, 192-255
> 
> Following are the experiments I ran:
> 
>   $ # Run a busy loop on each thread of the first socket
>   $ for i in `seq 0 63` `seq 128 191`; do taskset -c $i ~/scripts/loop & done
>   $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 5
> 
>   S0-D0-C0              1               0.00 Joules power_per_core/energy-per-core/
>   S0-D0-C1              1               0.00 Joules power_per_core/energy-per-core/
>   S0-D0-C2              1               0.00 Joules power_per_core/energy-per-core/
>   S0-D0-C3              1               0.00 Joules power_per_core/energy-per-core/
>   ...
>   S0-D0-C63             1               0.00 Joules power_per_core/energy-per-core/
>   S1-D1-C0              1               0.00 Joules power_per_core/energy-per-core/
>   S1-D1-C1              1               0.00 Joules power_per_core/energy-per-core/
>   S1-D1-C2              1               0.00 Joules power_per_core/energy-per-core/
>   S1-D1-C3              1               0.00 Joules power_per_core/energy-per-core/
>   ...
>   S1-D1-C63             1               0.00 Joules power_per_core/energy-per-core/
> 
> From the energy data, it looks as if the system is entirely idle.
> 
> If I repeat the same, pinning the running busy loop on the threads of
> second socket, I see the following:
> 
>   $ # Run a busy loop on each thread of the second socket
>   $ for i in `seq 64 127` `seq 192 255`; do taskset -c $i ~/scripts/loop & done
>   $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 5
> 
>   S0-D0-C0              1              11.79 Joules power_per_core/energy-per-core/
>   S0-D0-C1              1              11.80 Joules power_per_core/energy-per-core/
>   S0-D0-C2              1              11.90 Joules power_per_core/energy-per-core/
>   S0-D0-C3              1              11.88 Joules power_per_core/energy-per-core/
>   ...
>   S0-D0-C63             1              11.76 Joules power_per_core/energy-per-core/
>   S1-D1-C0              1              11.81 Joules power_per_core/energy-per-core/
>   S1-D1-C1              1              11.80 Joules power_per_core/energy-per-core/
>   S1-D1-C2              1              11.90 Joules power_per_core/energy-per-core/
>   S1-D1-C3              1              11.88 Joules power_per_core/energy-per-core/
>   ...
>   S1-D1-C63             1              11.76 Joules power_per_core/energy-per-core/
> 
> The whole system seems to be busy this time around. I've verified that
> only half the system is busy using htop in either case.
> 
> Running some more experiments, I see the following:
> 
>   $ taskset -c 1 ~/scripts/loop& # First thread from Core 1, Socket
>   $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 5
> 
>   S0-D0-C0              1               0.02 Joules power_per_core/energy-per-core/
>   S0-D0-C1              1               0.21 Joules power_per_core/energy-per-core/
>   S0-D0-C2              1               0.20 Joules power_per_core/energy-per-core/
>   S0-D0-C3              1               0.00 Joules power_per_core/energy-per-core/
>   ...
>   (Seemingly idle system)
> 
> 
>   $ taskset -c 65 ~/scripts/loop&
>   $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 5
> 
>   S0-D0-C0              1               0.01 Joules power_per_core/energy-per-core/
>   S0-D0-C1              1              16.73 Joules power_per_core/energy-per-core/
>   S0-D0-C2              1               0.00 Joules power_per_core/energy-per-core/
>   S0-D0-C3              1               0.00 Joules power_per_core/energy-per-core/
>   ...
>   S0-D0-C63             1               0.00 Joules power_per_core/energy-per-core/
>   S1-D1-C0              1               0.01 Joules power_per_core/energy-per-core/
>   S1-D1-C1              1              16.73 Joules power_per_core/energy-per-core/
>   S1-D1-C2              1               0.00 Joules power_per_core/energy-per-core/
>   S1-D1-C3              1               0.00 Joules power_per_core/energy-per-core/
>   ...
>   S1-D1-C63             1               0.00 Joules power_per_core/energy-per-core/
> 
>   (Core 1 from both sockets look busy reporting identical energy
>    values)
> 
> Hope it helps narrow down the issue.

I think my assumption that topology_core_id() will return a unique core ID 
across the system might not be correct. It seems the core ID is unique only
within a package, will fix this in the next version.

Thanks a lot for testing and helping narrow down the issue!

Regards,
Dhananjay

> >>
>>   Performance counter stats for 'system wide':
>>
>> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
>> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/
>>
>> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/
>>
>> This patchset applies cleanly on top of v6.10-rc4 as well as latest
>> tip/master.
> 
> P.S. I tested these changes on top of tip:perf/core
> 
>>
>> [..snip..]
>>
> 

