Return-Path: <linux-pm+bounces-16301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB859ACAE8
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 15:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B091F22151
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8B81AC8AE;
	Wed, 23 Oct 2024 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a2lV5Q4p"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AB61AB51B;
	Wed, 23 Oct 2024 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689333; cv=fail; b=p4wvNdSo1hMCeSPI6hoY8S6QFWipZe+4WpHuAsaMlBO0fcSdxNFBwiKUOVJnB8K2kcR1aqAyxZ47cL8NfClJjgqK1YhcOlPO9Qcsl9Ry0Z9YcH6khWUNbzCpvH9kVwaZes+g0AgSC0FlXzrC9i97s2NMMCaBrMmb5bHKFk3yu34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689333; c=relaxed/simple;
	bh=WmKcuXVJD3KnasYrLdS5Jj6QcZlv7tlQUXTpIcAytIY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lBDHKPDaUtTWskIItU4YApAXyVyAxD+CXI8DS5UcU5RL68EkcXSuBalxY4XATodblwgbXCIejmySh7d1cC8G2ZCsgb9i7SlrjiYKTmo/+GDyZJ4iF3tTcXcAkhcGufZzxv5MgedWE4ky9KImZfgSqd9O/gYK/a0xCqQxBPLmK3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a2lV5Q4p; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8RwhrTmVc5ALG25Irl0o5ZVBJNYZZesIfdzhxj+KrSRb2oU3SY+YqegFAEr26mbfvuZzZSwyW6dlsxlvC3RJpWG5J+m5GnhnIXY2Psrp4aRPSiz8sI5oABOSxPS3jCG5YwT6XkWi/U5JfYHflgeHaK+dIw8EJPjUka1YUQug9QNps1cXP/+g05921+WX87FZ04yz6J9PA2zcGfJmdiXgJsCQdr7kBG6TWLdM/+lw6/Ok3c1Hhx0GEfn6IUDFxBmAWQ5sOv8mf1UoF5c93A8PN+1+mVEJb53qzpw/6OKsKWsytTsxVbFerC3qI27wRA1j2usSgLWIT3fYJB3K0OnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuxnnmbHqBPZi2dsj1PH7iNqaalYbSwhJVY3gXyWwiw=;
 b=yENChzXOQOJfv61JggJjE07+xyKLmJrVRZa5uhX/ziy8SBFcPgqBx1CxwJy7jysSaZYr1+Ji+p6vV2MI0LWmNOp/6Ve0Bps8WvgeC+7l7rX5ZkYTHXfU7XpSYPakKlSZISWQGkDtmGoE9uJYz4adcfv3PHIUvXxXgNFJoQ+Xn0CTRCsKcAdcqElmvgPqy3av/qUQkZivPQ0/ZSibEv7gWkqA+/f2uqqq7j3KySJ1ysE00S/wuygNHGjCpjQp5mw58eByURimYa+CjQt20dJQymYEK9TT03if6uYFU9ZSvh2Rl3cTLzhd1EHw4e5zW//hVjaboU+4pgjhv716q4vNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuxnnmbHqBPZi2dsj1PH7iNqaalYbSwhJVY3gXyWwiw=;
 b=a2lV5Q4piPlqdcbmo9ysM4/OB75Yrh39XEDBRAt9gffPGonkeh1Ne8dkriydkukzEl3v1ftLU/Z830BWTyKrvlDqiwsdB8NAnraiO1WJbRha3GNz8vaEL+u9GU5dNeqGgHy3qwLNb17OoKLFYFV4ikpTG9j9JUffYp9uCIwCRUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 13:15:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 13:15:28 +0000
Message-ID: <1f98dce5-acff-4c3b-8190-8230070fbe7f@amd.com>
Date: Wed, 23 Oct 2024 08:15:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] cpufreq/amd-pstate:Cleanups
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 gautham.shenoy@amd.com, perry.yuan@amd.com, rafael@kernel.org,
 viresh.kumar@linaro.org
References: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:806:6e::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f10489-5ea0-4803-1215-08dcf364c3a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXNlQ3pxUTMvelZkVjdOaVcwN1FNbUt1WG1uWUEvd1hTMU4yN2RnYU8zRkdH?=
 =?utf-8?B?dFhjeVdTSkZrdFJISFpkRmNrY1lyclVHa3Zra0xnc2dTVkhoMkl5cW5aOTdR?=
 =?utf-8?B?WWhyZmwzQ3UxaEFWSlFmTmU3QURnMFp5b1VFVHR2SWhQdERFL1pVM3NUUE42?=
 =?utf-8?B?K2RJYkFDdzJJeUhIbnlGNlo3SkNXUDduck5MaG1hTVltZ0ZWNHpyOC9Hb2E3?=
 =?utf-8?B?TjQ3T0RzTVFuWWVTZk9sb1NvWWdtL0QxaHc3a2xXa0o5NFIvYU4rbm9lcDVO?=
 =?utf-8?B?T3Y5YUdCaXVMVVp3aGFXWUQ4bDkrRkovSFFKaVpNbnUwWERjZjkwWHFEOWFs?=
 =?utf-8?B?MVRCL0lzbmYyUnMwN0YvWUt3bzBvaDZweGUxUW1OdHI2Rnl1NUFtcXdEbTdj?=
 =?utf-8?B?cjF3Wm9scUxPazBJeS9WZTdYTUlLSGhRVFFjTSt5NDZMdElzNWFuaU01QTNV?=
 =?utf-8?B?UmRJemJuUVV4RWJURTM4aXlDV2JiNzF0Q2cvMXBYaXhNK00yMWJUWlp2cFZR?=
 =?utf-8?B?bzZIRkVXYmVzdStzL1VRS29QbWhkVEowbmlIT3owMDJEdVdNZWFRT2FCbHJZ?=
 =?utf-8?B?bDBVanRJQ0tFR1pCK0ZNZU11c1FsWGpuSmJHUXJqV2FYOXI1SjFkbXV0NHly?=
 =?utf-8?B?UjFSQnRtYU5uZ1VMNzNiT2JIbmZGVmlGQ3dZSDRubHFRNnhyTG5OKzhYdHBW?=
 =?utf-8?B?N3FJYUZnZXg1b01HWEdVZHlha01kMUxzdVdTa0xTUzVwdFRmY25OcXo1K2g2?=
 =?utf-8?B?K2Rxa0c5eXpZclRFNVpSb3dvUWJDd0kxZWtKTkxwbUx1UVp4Ny9QeG9FUThD?=
 =?utf-8?B?dE5JSGlPV2Z1ZUpDenpVM24zU2cxMEgwcVFLNHpSYTRxWHpjcnNWek9FajdH?=
 =?utf-8?B?dUNsUC9QV21yVVROaFJhUHBKTStCL2JrQkloVEdoU1pKRmIxOUw2enpSMlp2?=
 =?utf-8?B?WmE0bHltcVgwa1FVYTZZejhIK0I5ZGRzMVIvVEtxRHBLTGl3eWJGeDNjRG9l?=
 =?utf-8?B?T2UyaG9lK1dIbHg1ZWFDamhJYm9hTmhacjRVemQ1aVVLaTZMTWkwaWNJcm1u?=
 =?utf-8?B?elFQNCtUMUNVTVVkaDRtam8yOTB5eHZZN1NWYmlIeFJTK0lYSEhlZDJSOWlh?=
 =?utf-8?B?OVZNWGdSVFJoVWJUV2Urc1RySzJBRXN3bGhyWjdjREpkTk9rdG13M1JSV0hR?=
 =?utf-8?B?SFF5ZE9ZTXFMalhCZmQ4SHV6NDRWMVdDSmJGRnZvVjh1Vm00VXN2NWYyVlJI?=
 =?utf-8?B?M3ZveFJhOWQ2ajRmMjMzSnhlVHR4ditnb29sOGQwdjcwREdmWVZ6S1lEb2Vo?=
 =?utf-8?B?Ym1WTnVFd2htTzdEaEcySVNjUnUzSi9RMUxUdVRwN1RJREc3V1MrTGtlbHRL?=
 =?utf-8?B?czR0dUNkR00wMnN5anhwdktrZnBheWVDUnNhczlZMDBsSjRDNGtsTXg5N0Zj?=
 =?utf-8?B?QXFRRzI5NXRpWkhyRkoxNTFiQUovcG03b3hCdFE1MlpITDhTU2h5M0VTaHBo?=
 =?utf-8?B?TjN6L3F3RDdOKytXSEFXOE1UU0pKMWpLQkNCcUtGci93SUFMYTE5SjNTQ1RW?=
 =?utf-8?B?VXhVUFF3ODV3eEw1L0hNRG5mMjkyMndodUpMS2I0bTBMNWt3QzN6U3d4OEg5?=
 =?utf-8?B?NHdzVTVvbHNBWDNUMzVLT1pjOTBJcVMycEc3K1ZsUmFTa0RBMDF2aFdnZWs2?=
 =?utf-8?B?cjlkem1uS2FxdG1TakQwU0N0UjVVL2t4VUpkeUFoTFk1czVYQnNEaiszblJM?=
 =?utf-8?Q?KbGbuO73isBuPAIogA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk02aTAyRVhvcjk5Y2srK3NOVFlyalBTVXQ5Yi9ad0pVdGNMWWxKK3ROZDRj?=
 =?utf-8?B?NkVnaG9mMlpWcWZSRzlRVlNWcW5GVGxuZGRxVzNsL3N1U09YaGsrcmN3STBY?=
 =?utf-8?B?bC9nSEx5V1JPbStpalNzSmhUUmNEdVozNHRHM0t3RyszNzlDNkE0QTlzZnR1?=
 =?utf-8?B?enlOMXJWWnRONWNER0txcEJxTDh0N1NGaUwyM3Z0TGMwRTZ5YUQyMWxzdXln?=
 =?utf-8?B?MDVlWDdsdVRMT2dkNG1GRmJnSElnMTRqOTFpckZxTmc5NTl3YjEyZzhmVkZD?=
 =?utf-8?B?TnF5NTNqTUJFY08vcEUzZmFtbnk0djhPbnArNnVTMHFvMWVaSUIrSTdEQ0RP?=
 =?utf-8?B?RVhWT3ptZmZJS0cvZ2JUcGdseXR0Tzd5Q1lFZ001eDcwVU0vZ3V0bUFlc3JE?=
 =?utf-8?B?MGFFR0lCQ2hsRWQwZEhuNHJEQk8veEwzOElOSjk4RXBYY1hXOWI5Szc0d3NL?=
 =?utf-8?B?c2xxTGhsOVRxUHZ5U3Bmcks4dHZNWDlndlk5ZnJEdTgvQTJOVUUxNmhwVXVE?=
 =?utf-8?B?d05ubmZRanNKQzg2Uks2YXVDZGhEdm5XT21jekJaMjJkcTFKWXMxRWZyZ0xI?=
 =?utf-8?B?SlNpQzg4Vkp2QnBJa3NGTVBQdThyL1I3U1U1WUdjdmtMbW1KQTZOOERRZVFn?=
 =?utf-8?B?ekwyU1lpTGxydURsSEllRVJzQm5PUm1xYUQ1dXVqSUczQU9nd1ZhTUNmdkRx?=
 =?utf-8?B?dmJvcklQc3AwV2RKcHhOYy9IbTQ4bzg2UXdFYVlCYkRCRTZaSWZrUW40b3hN?=
 =?utf-8?B?VENZUms3WEdkMitDb2g2SDAvVk5UUzR5ZU4zNGtwTm51T2p2WWJKbi83Rm5z?=
 =?utf-8?B?Z0J6RkUrdFB4TGxNODJINW82bFlXc01DUWdCUFpCWmIwYmV4MVFQbW92M3Bj?=
 =?utf-8?B?UHVoNk9LTitZUTJOTGJEYXJOazZVekwzVjdXS3ZWcFFFVmJSdm4wcWoyOHp0?=
 =?utf-8?B?N2FFeERoZnQzeVprZ1hIYTlUbnk1aHgxR3g0SExCQWVoYjJ6SFJLaEY1dHp4?=
 =?utf-8?B?RlY0K0lhTHZISlMvOE1ZWktSQ0xHU2ZJLzN4RFBqcWdFMmRsVGFZU0R1MGVU?=
 =?utf-8?B?Ung0eVMwNTFqSk5PVGpxN3NXbUtoUm52L3NoWlJtZjI1dytUcjNIY3Zmd2ww?=
 =?utf-8?B?UEZ2czd0ekE3ZURMTGdadExzbksxWXZEYTNLMUZ2cWhQbHpSTkRKamRwTHFZ?=
 =?utf-8?B?eXF4Ukpxa242ZFgwR0w5MlNUWUdvRUY1bkpOVjNvY3ozcXV0cFhLRk1JR2Zj?=
 =?utf-8?B?eHk2cTVWRWdsV21xbXJlRzVrdWJVb2V5MTllNC9HdWFnNUVka1BjZ0M2L2hM?=
 =?utf-8?B?WmlQRDBKQm9JeW5tN0RIYzBDOXFZR0JucEU0Nk9nZWxjVTE0NXY0NnpxYnlq?=
 =?utf-8?B?SVRwSGZxeTNKR1E2emVqUzRKSHRBU1VrbG9NQUM3QkFaS09LekIzMUFPN2dR?=
 =?utf-8?B?d0tiYllaVDVDVmdlNjR6VCtJRVNoRVNpUHJ4RmhyRnZ1My9iM0htTFZHVi9p?=
 =?utf-8?B?T0R2bTdZdmFueTBtcjBucXY0aWgvK0ozK05RU2F6aFcxS1UwNVdxOCtDMndF?=
 =?utf-8?B?SElZUUJzRlRocTYvT3dLOGhhYkJWZ2ZjdG9od1VXZ090VEltK05QT3R2NTRn?=
 =?utf-8?B?V25od2VNdFlReVp2SjdxUm9CN0V3MS9Za2ViaDhCWHZiN1EzcHBxS1I4RkE0?=
 =?utf-8?B?Qkh3dngra2tDMmxGVGFNTGkwdXlCSGplek0wZkxRcHdQL3RiZ214MUczdUc0?=
 =?utf-8?B?ZXVJQWdzeS9UUkJ4anJpbldrL0JZT1UxMm1YcllBazhFWFU0VlpnY1VFemhY?=
 =?utf-8?B?ajNubXVCNnhoOHlVTUF3RzZYSmZjeWJJc1NaMVNhWDk2dmtOOGRlV21lTko2?=
 =?utf-8?B?RkdVVGZXQzdsSE5LTExEcjBCSzNrOXlDVHZUaE5JZW5KNUZoRnFKenNzbXFV?=
 =?utf-8?B?QlBvL1VONlI4eHIxenZqMmFNYnlpMGo3QkFMTVdvaVRQeVBlZk9Oa1MxUGFp?=
 =?utf-8?B?T1BoenNYZC9QcGFCcTgrTUZyRzNWa05zNDlSMTJveHZTRGtJamljNkxrOGpa?=
 =?utf-8?B?Q3NBVTBubHdmenlHZ0hEZk9JNnZEcjk3Q0IzSXBseVl4SHluT3JnOEZzMzMw?=
 =?utf-8?Q?7HWXhlJkvWmNAIavOAeg33TOp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f10489-5ea0-4803-1215-08dcf364c3a3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:15:28.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTJYp2LSz7HWWt3viCEl+po427aobyvsNOfsLRS82LVbNwKaSJElY5TlPu9abe1j+vZkVGsD4Iq0ZIV9AgyfpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269

On 10/23/2024 05:21, Dhananjay Ugwekar wrote:
> Explicitly rename functions that enable CPPC as *_cppc_*.
> 
> Do not clear MSR_AMD_CPPC_ENABLE as it is a set-once register, i.e. it
> cannot be cleared.
> 
> Propagate the epp value to shared mem in the reenable function.
> 
> Replicate the offline flow of MSR based systems in shared mem systems.
> 
> Dhananjay Ugwekar (4):
>    cpufreq/amd-pstate: Rename functions that enable CPPC
>    cpufreq/amd-pstate: Do not attempt to clear MSR_AMD_CPPC_ENABLE
>    cpufreq/amd-pstate: Call cppc_set_epp_perf in the reenable function
>    cpufreq/amd-pstate: Align offline flow of shared memory and MSR based
>      systems
> 
>   drivers/cpufreq/amd-pstate.c | 39 ++++++++++++++++++++++--------------
>   1 file changed, 24 insertions(+), 15 deletions(-)
> 

Thanks!

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

