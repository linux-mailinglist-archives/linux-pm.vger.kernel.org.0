Return-Path: <linux-pm+bounces-18596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3639E4D1A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 05:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCBF18806AE
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 04:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB8D18E764;
	Thu,  5 Dec 2024 04:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vjdi2k4H"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C79014A90;
	Thu,  5 Dec 2024 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733374212; cv=fail; b=X7BnIp0IWSfbsGdjujou+nEBKcwguPyHNnu3h7layNBWNfZFZ7KJJrOIqv+c3qEUjcucQcWWvDxYBhF2G7lrhItqvyGnd5rJOfG8qu1+PDSfVRYMnFCh8c0aXOyTxE6YSs/MbnoKdl0LIkx6OEMY/6NI9SJZDPge9Q0l+BqGweE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733374212; c=relaxed/simple;
	bh=Kar2YKF8HX3aLFOG2A37lkK6GxOsX9xcHi4mW6eaEP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RpAh3gO3x5t5dDnp2uYr55FMlGWOF6/euQxa6GyIi0VM30Tq5gGUGt4i33dbnwBbzqWEl4+pHqJMRVnarHW9WUtDcSIrPHMk0qGEq0PzbqvFfE39jqU+3UhdICDK/nFiMMhnFom0Eu+KVZqB1FvqhAKPLa2WUZsLtMJd1EfuyW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vjdi2k4H; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0yJcMHnpBehbHUpYh9AvHKp9twDH1ExEj8bdLQofi9DXiSfazvF/Mz8xQEVPZ6vLA2lmXh3jzVTchdJ2gTK4Ckhf+RhLyBbcjogmfgPR6lEoz4CaVCP9ysXnNC/DjNr6PE7Qcg3FeHpJ2u2nKoR2Kf5UXk/1Z5DCsR0TbIldotRYphpCUIXGGgSsOuO3VgjbYVmvZwJ3XEV+pud1Ckuse54dVicoC77161sBuXryiP3Oqr1gWXfqslkcS+tY5IW0RCc0sq0yqBui159nzBAIKOfccV9P7VDK/giQAhMR9TtfaP940eQXQ8jhCeSr8+wW69RzZK0PKmQMaerJk558g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAjlXTqbsJeHn+j0iBdTANJBTNXhkUPs/+9BHTRaWIA=;
 b=KL7HLB24plFgj5BcAQWZPuyDVNIq9oTXaetBCR8DQRFPq8FE3jvZdzJAmU8Yu77Aq8Nws0UtuSFwnDfh9KqvcWrwWRuCZmbjd7StlKJA1CVxh+GJnzTiiMDTEfKA/G1zC8/Clbg+NDC840+5uZ2dJdMM3M9ffe4hp6mhXRZL2MTP++NjYklPhiSSj9JqPPBY18GAUVemzr3hrT2q5Vuq0xwP1UXx5PZs/fp90lq7u7URWQsYmmEPgHZLMDHeRDlYBuyLXDS55zNgReRVIfH/ap7RUVlZ1J8F6CKjEb8W8fC10yOeCUXgl3zAd6AUmBCyEjrLt4q0xcdPLYiwxJtuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAjlXTqbsJeHn+j0iBdTANJBTNXhkUPs/+9BHTRaWIA=;
 b=vjdi2k4Hclw/6Mxh5hVfAVipBAspt+oPSBTJibBcFm35GX8oOH1iCC54HAe2WqC/TDQgl9ZZDmlxahcucDTxhkt5lq+VpjI+ju37/xy0Fe7KfMNli5tJ8EXop31ydUOPuFpuNf4jTe5mKEkyDXuMbsrSJE/n1eu4GHEe90ixmOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Thu, 5 Dec
 2024 04:50:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 04:50:07 +0000
Message-ID: <45e46f51-c31d-4e14-be1d-4ff7f2569c38@amd.com>
Date: Wed, 4 Dec 2024 22:50:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cpufreq/amd-pstate: Reuse and refactor code
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 gautham.shenoy@amd.com, perry.yuan@amd.com, rafael@kernel.org,
 viresh.kumar@linaro.org
References: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
 <9cd10b8b-ff56-4171-ad9c-df84fdad6be2@amd.com>
 <9b829b10-3b95-4aea-844f-fc7b0b4b601e@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <9b829b10-3b95-4aea-844f-fc7b0b4b601e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:806:126::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b68d8fe-b8fb-4dae-1ae9-08dd14e84a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEFLd1c4U3ZLZjdNeFFsZDFWcmhFUTNvYXkrR09YZUxTTi9yVDQyQjVuSFZV?=
 =?utf-8?B?aFFVUGpKcmdqSWdNMVpsZjR2Q2NaVHJYaERBbHNxRzNGZEV1TzU3R1RwbVh0?=
 =?utf-8?B?NWhaeVdxVmd3U1RBQ0t6ZjNmQkdBRGpUaU9XVHVTY21MMFBBbFhLTklPQ0k2?=
 =?utf-8?B?N3dhaHdVSFZ4Y2ZiQUtmdmhSWUVkRnAwM3l4WmJMbkpiUUszRnhwa3lKOVRl?=
 =?utf-8?B?bUszcWQxN1FjaXJneUU1Vm41dE1WWDlrYTRudHRFdHoyQmd1OEZTUVdFN2Ru?=
 =?utf-8?B?ZFpXQ1dQQVVMTGlub3RrbC9Fa3JZcFNyWHdxNXRIQ1dZSVAzd24zTGtBUVNX?=
 =?utf-8?B?ZU9ES21QU1J3NnRZMFl1RVpkbC84ZEZldllrYlYzUS9VZy93VkFTNFdvL3NU?=
 =?utf-8?B?eXhnTHhOUExZT1BvUWtqeWR5clFkQ0c4WlFvQW5CVkI2Mkh1dnZZUk1TNSto?=
 =?utf-8?B?Ry9PdjduWEZnRFlyRTAvQXBlMkF5bjFUakJWSHdKNVlqbTNqeGk1dWQwQ1Yx?=
 =?utf-8?B?eUltemZkNFUxSlg2TWxPVW0zL3VMSThSVlkyaDlZRU1DRWdLNHArSk55emFO?=
 =?utf-8?B?bUtvcnR6dlRWVEhCSzNNWWJPWDZJVjdQQ011SU5tblVYalV6VGVnOG40anNY?=
 =?utf-8?B?cXZDcWxHRkErZGU3Y0VHczRtNDBCbWk2bzN2blJ0a2pPSEdidjk2bU0vRXdG?=
 =?utf-8?B?Q3dIWWgzQ0JMU0FGTkxmdU1hZHdTeWJON1crRy9xamVPYlZNTWM2NWt0cm9E?=
 =?utf-8?B?Mm9Gc2VuYmZ3MXhoY3dhUm93anNKM2prYzNnSTVjaExLc3lDc01QSkdGVnNq?=
 =?utf-8?B?cFgySS9LQzhyVDdYVXRpUnAvdDN0VW1WMHYwYWpiUEpoeWV2Q2t0Z1A0Si95?=
 =?utf-8?B?MWhocDV5TDA2dVZJUjlxSU9XNStqcFBZSU13M3FQYkNYL0h5RTV5NHBGNmlS?=
 =?utf-8?B?MGZVVXkrVmppaVlDdmpqVUttR3hhNlFEK2RobHVHMFQzMkhZcm1GQ1pZWEZ6?=
 =?utf-8?B?QWMrZkoyVWZCbHlReUNWSDR4LzUrU1hiY2JEeFU3bnJ2Si9nSzQ1Ujdic05Z?=
 =?utf-8?B?L2NiYzRkZWNMRVcvUGZwMTV4anFDNHBHQVc0MzA2K0ROL01EVnI0d2xjbkdw?=
 =?utf-8?B?dU42VzB6MGZYWnRBem9iZS9TWXBuYWFvcEZmY0VwRlFRK2FDZVluN1d4Z2tv?=
 =?utf-8?B?a3pxaUdGa0gvMDNjMVoxTjI5S0xPVWhESzNTRGVjUTc4T2IwaU12dEsrZnl0?=
 =?utf-8?B?eHlhMUw0MDAyTFloMmF3TjA2aFRNWW5HeG51TlpsT1MwTXRWNUtqUUpOSFJF?=
 =?utf-8?B?SllCaXB6OVNJQzFmdnk2ZTB4L25rSU1hMERibFIrU1NTLzVKTkt2S3c3aUIz?=
 =?utf-8?B?MmdUcE1JMXVsSzhFYzZzdnJ4NGVGbEE5dnlsSWNZcE5IZTdoUHBmVG50TDli?=
 =?utf-8?B?TGNNS0lsaHNKaWpzNk9Hd3lzVkVnUGgwa1QvWEZydWhwRm8wODUxZG5UREF4?=
 =?utf-8?B?anpMUWEwbUpNTHliR1FzcEtvdUpRVENxYTlEVElaYlNvMHp5UTRxcCtKQW00?=
 =?utf-8?B?VU45MXR5YVBtclhHR3VGSThhMUQ3Ri9SRkhiby9rcjBtaU1lVmU4ejV2ZVUw?=
 =?utf-8?B?a09SMnVmN2Y2am9GQ1ZnU29taXVWNmNWaTFoRENUT1pKWUJpblhiUnpwRVcz?=
 =?utf-8?B?Q2h5OStvK2lySFIvMER5SFpCcG9UbmxTTWc0U0oxRXZRTXJYNXJtTmxRWS9n?=
 =?utf-8?B?NzJUNzlxSXVVQ0QyT1lIcS8wWWRZNEgvckxLaEJjTHdCcDY4SU8yRTUxVUFC?=
 =?utf-8?B?c0JYQUh1S2xpMmZHSnNmdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWczdzAvZ2hyRitwNXphVy9FVytRVzBIN3RPZ3ZkTmc2ZXhSVTY5WkRSSG4z?=
 =?utf-8?B?VGUvSUxXVGd2UDZFcHZraEtmZ0pENlZOQnMzTjNubVZUdjZGNzVQcHFmWm1s?=
 =?utf-8?B?MTQzeDV3Sk9yQ0Y2TVBWOXQzTnFkWGNNWURUTitleHR2NlZVcElNaDJtT1VI?=
 =?utf-8?B?NXU0VUJPUURRN2lUcjFuWmxGdkFtL1o3WnBJQmo2TXovUTBWKzd5dVRrOUpj?=
 =?utf-8?B?MHg0TlpzNVQwRE1oOG1rVktIZlJsLzJHMGsvRXdISWk5S1NDd3F4R1B1Qi94?=
 =?utf-8?B?aXdEWGg0a1dCWktOMFBndWwwak8xS1lpM1lhSjBoek1lRDBLUHZUZ2s1bGEz?=
 =?utf-8?B?WVlKd1FiR0xyTXU2OEJRclhVdTRSQmlwakFWTG5xL2ttclQyeDB3R0x6Smo5?=
 =?utf-8?B?NUREd1QzeFMvRlFES1NwRXJMTzl5eVZDbGs2ZkRtY1ljclVlUnJHaGd3K0g2?=
 =?utf-8?B?N1Q5U3JTd3R0ZUJZcEpZVXVIa3JjTXU0YitmeUJwV3RyL2RTRXVrbEt6aWly?=
 =?utf-8?B?UU5xSFhXeW13Mlk4RGFQeVpSeDdNMjZydG5KV1IwOW5tbk1yeXNJMko4T1Rn?=
 =?utf-8?B?NE4yaExIRm9nVFNXMmJ3NjJKcVY5QTlhTWVwa3pRMmlLMUhWemRKWjYzOG1n?=
 =?utf-8?B?blg3VzE0aGRESUpzZ2VxdHNuOUovZnhjc2NDYlV6Nll4WC9xNUtJMUQ3cE9y?=
 =?utf-8?B?MndIUmdoeGNSczdEa0JRQkFzYzZmTUlWOHV3OFV0NHJJZG9XM0ZXY2VDSTlF?=
 =?utf-8?B?ZDlFdXRjUGgwMzhNY2pTUUtiRDRqS0I4MWpnanNVMnVBY2ZGbVBzWjQxNyty?=
 =?utf-8?B?cUdYV2E0RnBlaHBpV1h0QmJtSkJlUXZLUDdIMUFubjRwUXFnNDFKOEI3bjdD?=
 =?utf-8?B?M2RYSC9jQmYrL2kzdFFqRTZ2Vmc4SnZidHhrTmtXM2VNSW94eEYrQ0dhbDR4?=
 =?utf-8?B?OWhlZitYYXlabUpiNkVtZHhEUytMY29lNjYrWFY4M1BaalBmTE1zMjN0S1l4?=
 =?utf-8?B?ZyttbmhGQkV3cHh3Q21WMm9rWWp4MmI2L21LWjdtR1lwR1dFa3FWZUFqamdC?=
 =?utf-8?B?blp4VkYxeEx5MDROckFkNjBsZ1M4SXRhalRlNFovZW5kT0lFYUhFN3Vwdyt1?=
 =?utf-8?B?M3V1SFFpdmwwcTdZQWF1T2FGZTg0MUlubjFMWGFjQ2NjSktkT080YVM0MVdT?=
 =?utf-8?B?M0ZpOVlkRzRXa2dVSEw0QXVCcmkzUC9LQkJsVmM4akdQZXpKRkNEejIwdnZV?=
 =?utf-8?B?RS9KSVRjdVo4ejA1SzlkTHJXK0pBTWI0c2xyTzZiYzFMNEV1ZVFESHBleGdi?=
 =?utf-8?B?bStSZ1hZNERnUytJSEN5Zk1sdTBYODVObWhXTzBFbks5cDBsOUZvN2dyYVJK?=
 =?utf-8?B?ZFd3dHpGeURhcHR5Wm5WWlNYdzAramxhSzdkbjUraHJXeVpHUzhyL2hBS2tN?=
 =?utf-8?B?WlFIaGRUNEYxcXRkTjZMV1BWUjRwcmt0MTNjTDNPclJqSXd1WmNyNndDQ09s?=
 =?utf-8?B?Z1lGQnV1S0x6YUZSZEV1VURBRHc0bXBOeFVuSlVxK2R2eDZFMnZ1c3Y3THFX?=
 =?utf-8?B?L05IUUdGaTVKa3F5dk1XcGRsdUJSSVJMRkZSYTAzUG5Ydnc2WWljWlRrRkR5?=
 =?utf-8?B?MVpOVkR4ekt5WmVjWnlDQ2F4ZTVXV2R3WlYrZjBWLzdyNlkzd1NwRFVqdHJG?=
 =?utf-8?B?R3VpTTR6VGM2SGdHZlVpZ2FHQVBRb3BaU280bVFsQitsTWZyb0pFNW9CYTM3?=
 =?utf-8?B?L0RINUIya3Y4ZWlJL1UwR3g2djNhVlVlSStkNDlzSi83Q3BCb0NEL1k2YVFW?=
 =?utf-8?B?cUJmT2hwNUc2UFdKWnhkeXg5bThWNHlDeENOamNaaTU4eHJIalRIdk1xbzhI?=
 =?utf-8?B?OHNEQW16czAzczNVbm9hT2tYZGtyRkJRaUtQRFJWZzBMeHRSZjhaaXlyQi9R?=
 =?utf-8?B?QnV3UFk2OE5ob0E1NXh5ZXJQNHlITGVkMUZ5V1RncjY3a2NzaUkweDkzU1Yv?=
 =?utf-8?B?NXZxS0t3THNQVk12bVNhWmwvdWdLb29GWVVWWVlmSUQ0RkZqWHYyUWhISGVD?=
 =?utf-8?B?ZzByYlJpU1J0ZTlQUWhkZmdidzRBQ2ZhUDRNOElVMDdCSmdjdGV1UjRUSEpt?=
 =?utf-8?Q?1+HdTAV9IJubfdwD6eG0GoaNn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b68d8fe-b8fb-4dae-1ae9-08dd14e84a7f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 04:50:07.2544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5hA9H2cBoJC7Cf4MLkcT7dqNo0YAG+6hIwpizdGQjHjMccxpizMAmynh10u7lgM0SYj5AshgvvtYuVn09fk9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008

On 12/4/2024 22:29, Dhananjay Ugwekar wrote:
> Hello Mario,
> 
> On 12/4/2024 10:37 PM, Mario Limonciello wrote:
>> On 12/4/2024 08:48, Dhananjay Ugwekar wrote:
>>> Use static calls to avoid frequent MSR/shared memory system checks.
>>>
>>> Reuse existing functions amd_pstate_update_perf() and
>>> amd_pstate_set_epp() instead of duplicating code.
>>>
>>> Remove an unnecessary check for active mode in online and offline
>>> functions.
>>>
>>> Eliminate a redundant function amd_pstate_epp_offline().
>>>
>>> Dhananjay Ugwekar (5):
>>>     cpufreq/amd-pstate: Convert the amd_pstate_get/set_epp() to static
>>>       calls
>>>     cpufreq/amd-pstate: Move the invocation of amd_pstate_update_perf()
>>>     cpufreq/amd-pstate: Refactor amd_pstate_epp_reenable() and
>>>       amd_pstate_epp_offline()
>>>     cpufreq/amd-pstate: Remove the cppc_state check in offline/online
>>>       functions
>>>     cpufreq/amd-pstate: Merge amd_pstate_epp_cpu_offline() and
>>>       amd_pstate_epp_offline()
>>>
>>>    drivers/cpufreq/amd-pstate.c | 151 +++++++++++++++++------------------
>>>    1 file changed, 73 insertions(+), 78 deletions(-)
>>>
>>
>> For the patches not already reviewed:
>>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Thanks!
> 
>>
>> I'll add this to superm1/bleeding-edge.
> 
> There is a small warning in the 3rd patch, how do you suggest we fix that,
> should I post a new version or you'll modify the patch at your end?
> 
>     drivers/cpufreq/amd-pstate.c: In function 'amd_pstate_epp_offline':
>>> drivers/cpufreq/amd-pstate.c:1664:13: warning: variable 'value' set but not used [-Wunused-but-set-variable]
>      1664 |         u64 value;
>           |             ^~~~~
> 
> Regards,
> Dhananjay
> 

Don't worry, it's a one line change.  I'll take care of it when I 
migrate it to superm1/linux-next.


