Return-Path: <linux-pm+bounces-9103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB88907A4D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 19:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39201C24DBB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F33314A4D0;
	Thu, 13 Jun 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MRBQxif9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D5F14A0B5;
	Thu, 13 Jun 2024 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301251; cv=fail; b=IqUK1N3vrU7KQnLI8mW5MhcN+5H/8Khl83IqSKS8YfRP7zrjpFdAlWaIs89LAk3WCoceYDv/KnMsUUmXSgSg/NsKPDLUzrNSvUJJQBe+5vYvRdvQHjjQNTN2JbE9+qpzW27kyYx6lM2BVg08yklHJGAGBZ8cprzXYgeYRP68JIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301251; c=relaxed/simple;
	bh=OrI6lwSYSjXbpDjCsQKPY7WzKh6Ww3Bw8JcMEUmDGPE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pPE1+PEyEKSQ0z6AObvUwDdBu16rG2amOy6vh1Fwwo9nuERdg29iQU9/6Zuwbz0qsXWBSm4efJxpFf/TxRyz02Kpvg6Jc8hsgM+2Q/sKmh2IQzZLOWxI+4uG0W7B5xd+TCx9qbG/u6KCO2kCJBl9lei5d3XhbLaAj13ZJYvZ5ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MRBQxif9; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf1+fmOX4pZyau8Nr69hyJvlmWT/agywh2DPjd3At5WLCe9l2yfUJ6wKzF3tP7QhTzYephh+L6y9hXJa0uzfL/5oab4zWANLaVjORhSRd0R6fQdHJ1hCihVyc+G54+MIiUR6QOSxdyGCrVNynRhfCJRhul5u3vB+opbiirNU9u0TdcVXedyHifRMdlLiktqB4YGEr9zO6l82kpSIzTehWuJpiA9W1iv+HqSZv9ZNvy6XsMsC0BhDloB7xEFjWzItDB9eMtHTjS7cqDsg06MkktAg1xdzl9dJs8+tOWpNmTma/nMQc5AD8CsX2CWYxBvMacdqlHhCwmmwWxEn3Fh8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpYa65e3PtfegSoEht8HldHRWl1FPG5MCxqJXyI7yQE=;
 b=Iq8XP5z5XGdzyI2mRu/+GTVQLIkcsidLw3it0V0sWJzi23B8SlHUCGEjpKtXG0UnONkLIGgyNPijG0YyZUNg4XSKnSYr9YBzEoOdOEX2ZqzrAZFfA9Xo3Sqr0ZG0YmALYVb0mHgaO/xg9VWvznITXC8sW8lG4Rn2OjtcXy1AFHovRcq2+BbqpOvofImX/w1W7WTURHEvQGfYTAQwnvzBW5kJ07YI+aMLwevTkb/U/mh1rNa/dqCbd4KFVIgQfv70q4lKSqm0ZKHtlG+0armIwoDQFQDM7OJ+Ysrf2A+AtADNiKVevpHrI+wFywA2/FInE/xAug1SEeIX7w53KuwQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpYa65e3PtfegSoEht8HldHRWl1FPG5MCxqJXyI7yQE=;
 b=MRBQxif9wQdS/lur50+PXnrT5gwI1RxUUBfnQBFCIvo5QnzvPsYalOdFwrMsqKe6Stj5lGDF+y3rgKRCUNrswHdzn/hXlQiazdTvROlNxrloBbeNPUhEIchmLIiQ6zZeMbfpqemirNEFpJmqZIVqmf/yViKKcYxWLkBzzfV5Ofc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7262.namprd12.prod.outlook.com (2603:10b6:303:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 17:54:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 17:54:06 +0000
Message-ID: <36bca242-147a-4eb2-a47a-1b0b7f3bc665@amd.com>
Date: Thu, 13 Jun 2024 12:54:03 -0500
User-Agent: Mozilla Thunderbird
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v11 0/9] AMD Pstate Driver Core Performance Boost
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
 Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718262992.git.perry.yuan@amd.com>
Content-Language: en-US
In-Reply-To: <cover.1718262992.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:8:56::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c662460-429c-4956-c791-08dc8bd1d1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVlBVS92QW0vWjJqWWsrQ0kzYjI1RWpKbmVPTVJ6UStZb1h0YnVnNG9KY1Zz?=
 =?utf-8?B?dkZRN0JLc1FaYXp5Wm1lLzZXZTFUakpJaUJ0VzhkRUp3ZGVkV0pPZ2wrQnRU?=
 =?utf-8?B?aHFOV0ZHUk5ycDVjVzg4WDlSVkdaNlA3NHlNM1UyNVYvMmxpb1B3ek14Qktq?=
 =?utf-8?B?cHVGRk9qaTBmWFpYNFhqMGhoZlZ2MWp5R2VwQVNFM2dqNEh1RWp6UXhpdkxl?=
 =?utf-8?B?dUFRdWh2Ujg4NWhYZGtoczc0b2piRVdoeEZTRkhpc3VUOWhERXZtbmhjNzhW?=
 =?utf-8?B?WE5mZ1lEZUhIVDVWc3dXSk85R3ZXUklRMDNJdzRTUWV3N0l2eWhMSnNZbDdU?=
 =?utf-8?B?Mm5kZDFXWnJHOWhmWU5FK3c0QWVUdUR4cXNPOEpubVhzcENrcWd0cnYvNU9X?=
 =?utf-8?B?THVNbnMxVldZbWZFWk9Hd2xhbEhEdElIQVlYQjlGRWhKSnh6cnRvSlRRcWlm?=
 =?utf-8?B?L0dIV3ZKK0prVDJHTjd5L29WMU9JSEhmN0M0VXJCYkIrcjZHaklDaDhaNzZw?=
 =?utf-8?B?Zld4eWVTWXc5bFpiVCs3bVFaWFdsWjdmRlVxVnpKK1JJNHZ0YlkvU3hYRWxU?=
 =?utf-8?B?TUpoUDlBRTRZV0V2U2dsZWxEZ1pjMncrWGRoZGhFb3JpOEU0Y2xvM2VTbEVv?=
 =?utf-8?B?TDlvOHA0REs0NndidCs0Nlh0WU44RXlySVdWRmtRUlBaRG93aEk1WG02NmhF?=
 =?utf-8?B?R1p4ZkdjaFp4aXFxMmxzekhwREdzMnFTemxHLzhET2JSTjRYVnRuVDlNVHd1?=
 =?utf-8?B?SkVEbUM2Y2kyMXZEVXJsRzA4Nkt2OStGOE5ocW1JMUxhR2lFTVJPbjRsUThL?=
 =?utf-8?B?MWNzM09LckdoWkpTR3RjTVRCb0x3cG1iQjV4eWNvTytxWFZibVQwSWw2OGJV?=
 =?utf-8?B?WnlkdG1xa0x3dHJHNDBpNGxNZ0Y3TFU2UWhJV3V1WnEwSVltVVpVU21OelN0?=
 =?utf-8?B?WVE4cDliUFRTOXUxWHU0eG9GUWZZOWc5ekZTZXBLbkJmUGxPNDEzdksvZDNK?=
 =?utf-8?B?VFlVYWxtRGlvRXZJZm1BekFCbHJXR0hzaHVCVU9aZXdvdzZxOHZjNm10U1B1?=
 =?utf-8?B?bzhrVFM1N0dZVEpINnEySmpOMWY5OEdUd1RhVkNvaHNSQVViYlN6WE1kYmdV?=
 =?utf-8?B?TWJUa0p0VXRiOW0yT3cxbnNIaHdEK0Y5REtmckR5S0tOOWhYNWJMT0F6Wk5k?=
 =?utf-8?B?QyttMno5c3ZFNGFDZXp2VmdyRGV5YjRET1RhT29uMExFcW1tVUVXQkpHSGo4?=
 =?utf-8?B?L1VxMWw0R0ZrTnkzUUs1WEdvZUgxTDZldGtIQ2NwT3dNRDZyUDZ1UURqb09z?=
 =?utf-8?B?ZWdla3RBRjRBYWlOTFVxK0pIZ05UN1Q4QVZqSkhaZVd3cWZ3allTeDhrR2JV?=
 =?utf-8?B?dHVtQWR6YXEwUkIxRFAyMzU1Y0xmL0JtS3NPSG01SlU1bE8wNEdTT3BkRm9U?=
 =?utf-8?B?OHMxNFJsWDlYbG1qZTlLVWRjajVvV21yY3ZJN1JkYzNzSlFBaGoybGhpdCtu?=
 =?utf-8?B?aWZhWmorZVB5cmM0NzNiRDFRMnZMZElwZTVRV0hkU1lPc2drL2xsZXN0VzBO?=
 =?utf-8?B?NFBhdWJtWU5JN1BjTlY4LzVVY1JMQXVvMFpYQ09scFVQREk3SCtveFp4Qk9o?=
 =?utf-8?B?ZWkxM0FpRTJadzdlSm9LSlpjcE1zb1Jvd1dNOWpoa0dBUWdscHF5UklySTVF?=
 =?utf-8?B?L1JCeGVDK2I2aDlVVk9zT2Q5Y2dCZDJXZjZmUXg4TU03TVZKUDdEWGVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUxRcjlOZ0F0TGVVZCtGVC9kUTRRNmovWU9WTWp6OVQ3Y1BLSHZ6bEoyLyts?=
 =?utf-8?B?Sm42c1VCWEIrUjVVQlk1dmJXNTdVSkxyRko1SW9mQ0dOeStOTlVuU1JEOUV3?=
 =?utf-8?B?Znh0OXB6MVZmWWZhVHN2NXhyczVXd0Erd2VNeFZxK3dLaE9pRHpXdGpSUDhV?=
 =?utf-8?B?RWdwUWsyT0hScHJPOERpbTI1ZkJHc0R5UkV6bk5kWDF5UnBXSHRQd1RFYjFh?=
 =?utf-8?B?WVRocm84MzBWOGVOZ3lWZDQ2OURBYWxYZnN3RksrNllFM2ttWC9NNklvcnR2?=
 =?utf-8?B?T2xPY0kzanA4Z1ZGKzlYbVY3M0d4ME9xUGNsT0pQVTAybVRLUG4yUkJrVWZl?=
 =?utf-8?B?RnRMeURua0p2WVJ4VkxEVEtOZGwreldTU3FnUXZqYVo2a3NPczVybzl3MzlR?=
 =?utf-8?B?MnV1MFlBZUhxSFEyN0d3YkVaYVVJN3Z6ZmNpWnBQRUxUUkJ0MU9FTGt6S0F1?=
 =?utf-8?B?ZnNGR25YcmNFa3h3MitEaVhOMFhUQnNEZGJacTNCZ01aTElkb2ZHbFZlMnZ2?=
 =?utf-8?B?WFhNQ3dJTVRnQ1d6ZE54anZGMnV0UzYwYlVwYWJxcVlCQUJoSElHYkZEVkkr?=
 =?utf-8?B?OWVwR0kySnVSdm9CaFBoSjA1c0VPRVA5TDhwQm1SbXN4a3lJOTNUSy8yNGJI?=
 =?utf-8?B?cFdqeE5OL0tmU0JXZHV1czlIeHduSUxQeWM0UTh1RTk3alJBRmtFckhzQzVG?=
 =?utf-8?B?V2pqcGNxSy9kcG93bFFGZFhNY3BJY1J0YWVienNZdzJPVlZ6OEhkcFVPeEtG?=
 =?utf-8?B?ODBIVWFBMXNhTFVGWUh6OFdOcXk1NTVXTXZ2bzcyZWtXbm5yZVBXOEcvNFda?=
 =?utf-8?B?QXhab0VOcHMvb3NkbnBqM3IvVjZUVVZJWU55N1FzY25lTndVWDFMcUZjMWw4?=
 =?utf-8?B?bnlpdHlTUTNidCtBbWttRi9la3ViV3lITmF6Y1AxOVBXQkJMVEQxMjRZajI5?=
 =?utf-8?B?WVZ2RTN2Tzh6TkVxdDZmRDJycUlWdVc4MmhXc0tDc2JGZnB4UVJOQVFzOHZI?=
 =?utf-8?B?WFB5QjFFejdLRFoyYXgwR2pZakxmdXN2NVJ3bkVpbzN3ZUhhZ3BlQXpLZEhP?=
 =?utf-8?B?ZEpLbDdHNE9oMkUzU2tWRkRIWUx6V2NFQk04TmY3TU1TZ2hzcHZZQVBCdkZI?=
 =?utf-8?B?dXNvdGlGa3J1ZVJkVU12K0lDWDViaktXNHFhdmEyTFBrWGpSZXlyNUdBVWlw?=
 =?utf-8?B?MmpaTW1oL0VseVhqYkU3Sm1tR2puVnVHU3RLVDVoQUpybWpxWml6SEprUUkx?=
 =?utf-8?B?U3RzQjcyRG9tZXJGQ0dnU1pwbnNIWmpkTjBIeHNrNEtzNm5qVG5vbCtjYWNQ?=
 =?utf-8?B?YnFxdlVPSGxJUFg0WG14WU1WWFVLeExUbWdUb2tiLytJN1YrVlUxNEN6aXpp?=
 =?utf-8?B?NEhwaXY3Vlh4WW5aVnZtdHAwR0l6bVNmUW5pOUljT1FoUTlxZHNMSGlrUFJF?=
 =?utf-8?B?M2NZN3VLUUt5akFQakVUaStyZWRMZm1WUENjQXpNa3kvVWtjclFUc3Y3VVVp?=
 =?utf-8?B?VFdETXFLVlRzQ1V2WFVDOFNuZVZZejZJUEtSbGZWVFNGdWtHd1d3UEg0bkVS?=
 =?utf-8?B?ZnZyVjhtVGN0VW9oNzFseFpVNkVyNk54QmdQbk1xakx5Rzl4YlVGWWc2Yk0r?=
 =?utf-8?B?YkNuUGluaUJoUEd4d0wwMEdlSFZmSCtCaFc3Z0dhZzg5Z0F1UGdmenNIREJ4?=
 =?utf-8?B?YTZmUUtYYXM3RkI5dm1hUFZXTXlpQm5ITVQxQmVWOFNTWUZYVS9sQ2pNbU80?=
 =?utf-8?B?WUFCTkplQnBEalo2Q1VwS3BYNk9MeUpJUjIvbkZxOVlQQWxnWEQwb3N4ekJk?=
 =?utf-8?B?dGt4VGhLOGppTjVhL0pYK2JBZWt3c0loZ3JvS1lCOWpaRS9raTFqTHFEQWFj?=
 =?utf-8?B?UWRMaVEwd240NHF1bFgrWmExYUYvckxnV3ZtdnBBV2NzcDllOGhJcEhFbnE3?=
 =?utf-8?B?OExtbEdXMEQvU1h2Y3NyY3dzUkh5MjJ5N3hmY0J1VTUwdUFoSG12aTh5Vk5z?=
 =?utf-8?B?alYrOFlaVUllSVdDRjZPSnhHeHY0MzFyb3hCOU9Iam8wYTFIbDFWZGpQeDlN?=
 =?utf-8?B?TEQrVHQ3bnpuczllekFmenpQNnNyZnJMbmpIcFY0MzFvdlhnZWp6b3Izdm56?=
 =?utf-8?Q?0R50XELZBLiEX7ONcS6lOYOm3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c662460-429c-4956-c791-08dc8bd1d1a0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 17:54:06.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mvpQGoXVLd3TSfqhwjWFSamalODNlk6fSVv3VOgbQmGi0gjEHF11By7vEhuBO/n51HpaibZaoWd4CNnsctJTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7262

This is the cover letter, so if no other feedback no need to fix up. But 
if you need a v12 then typos below.

On 6/13/2024 02:25, Perry Yuan wrote:
> Hi all,
> The patchset series implement CPB(core performance boost) feature for AMD pstate
> driver including passisve ,guide and active mode support.

passive
guided

> 
> User can change global core frequency boost control with a new sysfs entry:
> 
> "/sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> Now it also support to update indivial CPU boost state in sysfs boost file.

individual

> "/sys/devices/system/cpu/cpuX/cpufreq/boost"
> 
> And global control will override the indivial CPU boost state by default.

individual

> 
> 1) globally disable core boost:
> $ sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> $ lscpu -ae
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
>    0    0      0    0 0:0:0:0          yes 4201.0000 400.0000 2983.578
>    1    0      0    1 1:1:1:0          yes 4201.0000 400.0000 2983.578
>    2    0      0    2 2:2:2:0          yes 4201.0000 400.0000 2583.855
>    3    0      0    3 3:3:3:0          yes 4201.0000 400.0000 2983.578
>    4    0      0    4 4:4:4:0          yes 4201.0000 400.0000 2983.578
> 
> 2) globally enable core boost:
> $ sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> $ lscpu -ae
>     0    0      0    0 0:0:0:0          yes 5759.0000 400.0000 2983.578
>    1    0      0    1 1:1:1:0          yes 5759.0000 400.0000 2983.578
>    2    0      0    2 2:2:2:0          yes 5759.0000 400.0000 2983.578
>    3    0      0    3 3:3:3:0          yes 5759.0000 400.0000 2983.578
>    4    0      0    4 4:4:4:0          yes 5759.0000 400.0000 2983.578
> 
> 
> ============================================================================
> The V9 patches add per CPU boost control, user can enable/disable CPUs boost
> as the below command tested on a laptop system.
> # before
>    CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>    0    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1666.7740
>    1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000
>    2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3386.1260
>    3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0000
> $ sudo rdmsr 0xc00102b3 -p 0
> 10a6
> 
> $ sudo bash -c "echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/boost"
> # after
>    CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>      0    0      0    0 0:0:0:0          yes 3501.0000 400.0000  400.0000
>      1    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1391.0690
>      2    0      0    1 1:1:1:0          yes 4208.0000 400.0000 3654.4541
>      3    0      0    1 1:1:1:0          yes 4208.0000 400.0000  400.0000
> $ sudo rdmsr 0xc00102b3 -p 0
> 108a
> 
> rebasd to keep syncing to Mario kernel tree: bleeding-edge
> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> 
> Tested result:
> 
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>    0    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
>    1    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
>    2    0      0    1 1:1:1:0          yes 4354.0000 400.0000 1110.7140
>    3    0      0    1 1:1:1:0          yes 4354.0000 400.0000 3110.0000
>    4    0      0    2 2:2:2:0          yes 4354.0000 400.0000 2732.3569
>    5    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
>    6    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
>    7    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
>    8    0      0    4 4:4:4:0          yes 4354.0000 400.0000 2312.2109
>    9    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
>   10    0      0    5 5:5:5:0          yes 4354.0000 400.0000 2310.1011
>   11    0      0    5 5:5:5:0          yes 4354.0000 400.0000 1110.7140
> 
> sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu11/cpufreq/boost"
> sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu10/cpufreq/boost"
> sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu9/cpufreq/boost"
> 
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>    0    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1242.7240
>    1    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
>    2    0      0    1 1:1:1:0          yes 4354.0000 400.0000 2754.5710
>    3    0      0    1 1:1:1:0          yes 4354.0000 400.0000 2659.8159
>    4    0      0    2 2:2:2:0          yes 4354.0000 400.0000 2308.9929
>    5    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
>    6    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
>    7    0      0    3 3:3:3:0          yes 4354.0000 400.0000 1110.7140
>    8    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
>    9    0      0    4 4:4:4:0          yes 2801.0000 400.0000 1110.7140
>   10    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1110.7140
>   11    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1110.7140
> 
> sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>    0    0      0    0 0:0:0:0          yes 2801.0000 400.0000 1233.8630
>    1    0      0    0 0:0:0:0          yes 2801.0000 400.0000 1110.7140
>    2    0      0    1 1:1:1:0          yes 2801.0000 400.0000 2714.4851
>    3    0      0    1 1:1:1:0          yes 2801.0000 400.0000 2732.3569
>    4    0      0    2 2:2:2:0          yes 2801.0000 400.0000 2564.2639
>    5    0      0    2 2:2:2:0          yes 2801.0000 400.0000 1110.7140
>    6    0      0    3 3:3:3:0          yes 2801.0000 400.0000 2732.3569
>    7    0      0    3 3:3:3:0          yes 2801.0000 400.0000 1110.7140
>    8    0      0    4 4:4:4:0          yes 2801.0000 400.0000 1233.8660
>    9    0      0    4 4:4:4:0          yes 2801.0000 400.0000 1110.7140
>   10    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1233.6630
>   11    0      0    5 5:5:5:0          yes 2801.0000 400.0000 1233.5050
> 
> sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>    0    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1234.0200
>    1    0      0    0 0:0:0:0          yes 4354.0000 400.0000 1110.7140
>    2    0      0    1 1:1:1:0          yes 4354.0000 400.0000 1110.7140
>    3    0      0    1 1:1:1:0          yes 4354.0000 400.0000 1110.7140
>    4    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
>    5    0      0    2 2:2:2:0          yes 4354.0000 400.0000 1110.7140
>    6    0      0    3 3:3:3:0          yes 4354.0000 400.0000 2278.8491
>    7    0      0    3 3:3:3:0          yes 4354.0000 400.0000 2732.3569
>    8    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
>    9    0      0    4 4:4:4:0          yes 4354.0000 400.0000 1110.7140
>   10    0      0    5 5:5:5:0          yes 4354.0000 400.0000 2353.0449
>   11    0      0    5 5:5:5:0          yes 4354.0000 400.0000 1110.7140
> 
> 
> Perry.
> 
> Changes from v10:
>   * rework the boost interface with cpufreq core boost control, align the sysfs file
>    created from cpufreq.c and allow indivial CPU boost control (Mario)
>   * fix the pr_warn code format with %zd (Oleksandr Natalenko)
>   * replace sscanf with kstrtobool for cpufreq.c (new)
>   * drop the boost sysfs file creation from amd pstate patch #6
>   * add init_boost for cpufreq.c to unify the boost file creation(Mario)
>   * add set_boost callback for EPP driver mode
>   * fix syncronization issue for indivial boost control and global CPB control, now the
>     two control way will keep syncronization after anyone CPU boost state changed.
>   * rebased to Mario kernel tree: bleeding-edge
>   * run testing on local system, no regression issue found so far.
> 
> Changes from v9:
>   * change per CPU boost sysfs file name to `boost` (Mario)
>   * rebased to latest linux-pm/bleeding-edge
> 
> Changes from v8:
>   * pick RB flag for patch 4 (Mario)
>   * change boot_cpu_has to cpu_feature_enabled for patch 2 (Boris)
>   * merge patch 6 into patch 3 (Mario)
>   * add two patch for per CPU boost control patch 6 & 7(Mario)
>   * rebased to latest linux-pm/bleeding-edge
> 
> Changes from v7:
>   * fix the mutext locking issue in the sysfs file update(Ray, Mario)
>   * pick ack flag from Ray
>   * use X86_FEATURE_CPB to verify the CPB function in Patch #2(Ray)
>   * rerun the testing to check function works well
>   * rebased to linux-pm/bleeding-edge latest
> 
> Changes from v6:
>   * reword patch 2 commit log (Gautham)
>   * update cover letter description(Gautham)
>   * rebase to kernel v6.9-rc5
> 
> Changes from v4:
>   * drop the legacy boost remove patch, let us keep the legacy interface
>     in case some applications break.
>   * rebase to linux-pm/bleeding-edge branch
>   * rework the patchset base on [PATCH v8 0/8] AMD Pstate Fixes And
>     Enhancements which has some intial work done there.
> 
> Changes from v4:
>   * move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
>   * pick RB flag from Gautham R. Shenoy
>   * add Cc Oleksandr Natalenko <oleksandr@natalenko.name>
>   * rebase to latest linux-pm/bleeding-edge branch
>   * rebase the patch set on top of [PATCH v7 0/6] AMD Pstate Fixes And Enhancements
>   * update  [PATCH v7 2/6] to use MSR_K7_HWCR_CPB_DIS_BIT
> 
> Changes from v3:
>   * rebased to linux-pm/bleeding-edge v6.8
>   * rename global to amd_pstate_global_params(Oleksandr Natalenko)
>   * remove comments for boot_supported in amd_pstate.h
>   * fix the compiler warning for amd-pstate-ut.ko
>   * use for_each_online_cpu in cpb_boost_store which fix the null pointer
>     error during testing
>   * fix the max frequency value to be KHz when cpb boost disabled(Gautham R. Shenoy)
> 
> Changes from v2:
>   * move global struct to amd-pstate.h
>   * fix the amd-pstate-ut with new cpb control interface
> 
> Changes from v1:
>   * drop suspend/resume fix patch 6/7 because of the fix should be in
>     another fix series instead of CPB feature
>   * move the set_boost remove patch to the last(Mario)
>   * Fix commit info with "Closes:" (Mario)
>   * simplified global.cpb_supported initialization(Mario)
>   * Add guide mode support for CPB control
>   * Fixed some Doc typos and add guide mode info to Doc as well.
> 
> v1: https://lore.kernel.org/all/cover.1706255676.git.perry.yuan@amd.com/
> v2: https://lore.kernel.org/lkml/cover.1707047943.git.perry.yuan@amd.com/
> v3: https://lore.kernel.org/lkml/cover.1707297581.git.perry.yuan@amd.com/
> v4: https://lore.kernel.org/lkml/cover.1710322310.git.perry.yuan@amd.com/
> v5: https://lore.kernel.org/lkml/cover.1710473712.git.perry.yuan@amd.com/
> v6: https://lore.kernel.org/lkml/cover.1710754236.git.perry.yuan@amd.com/
> v7: https://lore.kernel.org/lkml/cover.1713861200.git.perry.yuan@amd.com/
> v8: https://lore.kernel.org/lkml/cover.1714112854.git.perry.yuan@amd.com/
> v9: https://lore.kernel.org/lkml/cover.1714989803.git.perry.yuan@amd.com/
> v10: https://lore.kernel.org/lkml/cover.1715152592.git.perry.yuan@amd.com/
> 
> Perry Yuan (9):
>    cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into msr-index.h
>    cpufreq: simplify boolean parsing with kstrtobool in store function
>    cpufreq: introduce init_boost callback to initialize boost state for
>      pstate drivers
>    cpufreq: amd-pstate: initialize new core precision boost state
>    cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
>    cpufreq: amd-pstate: Add set_boost callback for active mode
>    cpufreq: amd-pstate: fix the MSR highest perf will be reset issue
>      while cpb boost off
>    Documentation: cpufreq: amd-pstate: introduce the new cpu boost
>      control method
>    Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
>      control method
> 
>   Documentation/admin-guide/pm/amd-pstate.rst |  30 +++
>   arch/x86/include/asm/msr-index.h            |   2 +
>   drivers/cpufreq/acpi-cpufreq.c              |   2 -
>   drivers/cpufreq/amd-pstate-ut.c             |   2 +-
>   drivers/cpufreq/amd-pstate.c                | 197 +++++++++++++++++---
>   drivers/cpufreq/amd-pstate.h                |  14 ++
>   drivers/cpufreq/cpufreq.c                   |  23 ++-
>   include/linux/cpufreq.h                     |   2 +
>   8 files changed, 237 insertions(+), 35 deletions(-)
> 


