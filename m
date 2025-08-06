Return-Path: <linux-pm+bounces-31978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67309B1BDDF
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 02:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224A66269E4
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 00:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6A745038;
	Wed,  6 Aug 2025 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bSURK64z"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2094.outbound.protection.outlook.com [40.107.244.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CB327455;
	Wed,  6 Aug 2025 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754440002; cv=fail; b=j/OesY/vGNi/JojZERdx9qLpUq9G/XVC1Tsy/9CIA5V51KhReQonoGUVT1c/T6UASrKX0RXYwmfpgBMJhyUTZ3A5rK45IVFDm+ue6tzIL9i6SPcx6cEDQ9oHi0UGEiyjvD67h6V6o35tc5ffuRJs5mVD3KsHYA1hEElh56DCoLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754440002; c=relaxed/simple;
	bh=WRqSxipNHFJNU85hhi08/3R8UV/uFAmkT6p+moLkQsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T9sZkrPAHW6USKdWS5J+o18PWxQoAcU2P0d59ZNvebBoC8TgI3Oh87+AY/gAht2owctJoWHR4U3u2w1qWGLqZpT10V21IQbS5cGoNdKBI7iiIjTgLigIDYEkHH9ytNdXrYBc+CIKFq8NI2Op5WybiLAJD9SFHHxafvC1IZ4O2Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bSURK64z; arc=fail smtp.client-ip=40.107.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkMqDLGSbqOWY113fgLodoz99SHyEXkklc0PH3tqbEKB4p1QzIwLawoUu5NtMFjK+EHoAwQQNLdeY+aycTbarRuXH68HW0iHwwj4ilEJG5sfivruu2eGUnU1rkOClTePnCxIRdh+qUuUExPsT892D/FdIqOpe5rm2w6m9MVOtL5V2I/HmwzZImssWrn5wNVmLjJ+Brp2lW4hBMHvhKItFyzWs5kSh4zrOsnvbi7hOfRttI17Bv5zY7bj5A0xYUTpwObNBpwmUvrgto4HbMJT7m4bqk+/4gvgancEmUKbH90JyZDWRZGW1dzEye1qVQ/E/+af4CuJ0NT+eyNf/QInJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxB4h68mbL/7mi+1mbXW6vqiPdlZSczcQUmtc1/ZIRU=;
 b=FnShvyUlDoJx6r7KeCRuwCkkPp2TET/KZDEFTGTNO3KHTGJAUHG9+J2rxGPWRW4c8OPVb73XuUhKSMD22TydeID5xqPPmHiVe+x+Y4NueihmIIpUKWFjwUW6vjZMMhQFl0O4IJkJezSFGb3URybQd37ECo4tJszDa7tTx7UzA9Nk+XDJcSn1Y1xgNMclxSZSx/L7tadKiYvRA61Wu9/PmClpmHz4FjAd+FKLO4HTvoijR2SlcdMq9i/3G7y8ZijafxJ1r/2jOAPnbAG2ipnv6P8eAdJAZxrp0Yu7Eykio9AyCjHb4awJRezn5TPEhgzEEkmYMrwIQ32ZLHXEcFlliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxB4h68mbL/7mi+1mbXW6vqiPdlZSczcQUmtc1/ZIRU=;
 b=bSURK64zTWNp57U7nZo9iKb5V0Zw0aU9XCwoWy6sbTw1t0wmaVfNOlAQdI7iUbNeRy3EXYxNabzqxO9pVtiTuzjg7+2ZNpapbKUYywyIXaMV+wnhB0DH2aLIq1FKXpndWDNGPlzm5sko7edo0uyPm6WKcHMogdb1/XcYtpgqcRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DM4PR01MB7715.prod.exchangelabs.com (2603:10b6:8:67::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.13; Wed, 6 Aug 2025 00:26:37 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 00:26:37 +0000
Message-ID: <8252b1e6-5d13-4f26-8aa3-30e841639e10@os.amperecomputing.com>
Date: Tue, 5 Aug 2025 17:26:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: CPPC: Increase delay between perf counter reads
To: Prashant Malani <pmalani@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, beata.michalska@arm.com,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Ionela Voinescu <Ionela.Voinescu@arm.com>
References: <20250730220812.53098-1-pmalani@google.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250730220812.53098-1-pmalani@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: CY5PR18CA0037.namprd18.prod.outlook.com
 (2603:10b6:930:13::20) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DM4PR01MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: c28389b5-e823-439a-1779-08ddd47fe7a3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aStGSkFBdm4wS1FjN2U3eEFPYjFta0dqcDdudXllMHNaMW9PdGgxYlgvbUp6?=
 =?utf-8?B?L3cwdWp3TTV6NUw4VU9zK2hGYUs1TFpKZ054b3VMNVlvdWJPTWx4M002UjBa?=
 =?utf-8?B?MFdSSDMyajFBaEhtU1c2dkNPais5OWhsekI4Zmo1TGM2Q2N1enNnT2owdjZu?=
 =?utf-8?B?amVORjZnVUNSMzRLbXBHdHY5TGJyMCtoK3ZlRkovVzZsb2piMlkxaG5ySDZL?=
 =?utf-8?B?RHBIQ3FFTVI0K1NFVndlYzkrOWJKNlc3ajlrc21nYm5OejAwUGpkRXRYZ0d3?=
 =?utf-8?B?S05PQlB2YUZkMnc1Q2JHWnhhaEFWL011ajFRWTNLWmdpL1dqYVhONXNma2h3?=
 =?utf-8?B?bGJyY2FUOVJnOU4zQlVyWnZNU0lIcW85bzNpVm5ySFdRTm1QdXpZVm52RW5B?=
 =?utf-8?B?a0FtSTlhVUxWZENYTWZjeXhHMGg2YnVocW5PbXV6dFRNbGtJWWNnV3lHYkt6?=
 =?utf-8?B?S0NEeHluSlZEenNpbXZLU0ZhNk50RDZwKzd3TWUvUTJPZk9mWVZyZE11cG5C?=
 =?utf-8?B?TXl5ZmorNXJBMWhFMW4zWjhPTVpuU3BkY3ErVkVGYVpVUDNrNWR3Q0tsSWh6?=
 =?utf-8?B?RndHMUpFSlRvbVh2S3RCVzB1enpFVjFxSzJKUlVRS2IyRjJzWnc0ZDNNVWR6?=
 =?utf-8?B?WHMxa1lwL1dCY0F1SS9ZRWJsQTd3NzNUK3V1eFhOZFRNSWZIZ0F5R1lnVGpH?=
 =?utf-8?B?dElhWmlJQ0ZITjRyMWtmOGhsdlArNkpDUVZFdDlzd3RqL0lmdUJRcHd3Vk1s?=
 =?utf-8?B?Y1U1eDUrWlRsUzJOZDFwdHRjcmVaQlZyWmdjVTRTd1c3Znl0YnpVRUwyZ1lW?=
 =?utf-8?B?WEQwSGtBSDZ3ZlZzeW96NW50N0RZUTdFUEJCN2hnSDE4blhPK0ltWE9TcWIz?=
 =?utf-8?B?cXhsZDRpeHJnalRlbXFLb21EMzl3QncxZEJzbUt5V05VTWZwSCt0RmFoL1lB?=
 =?utf-8?B?ak52dk9mQ1dWY08rcFFHQlB0VGhWc1hoSGdFclFRb1lKanl6SkY3bzhKY3dr?=
 =?utf-8?B?QUxOdUVGR0o1ZDJNUDYyQXRBN055YWZ3c3k2dHBWYU9sdTlzZGtTbTJHVmcz?=
 =?utf-8?B?NlpXT1lWUGcxT2E0VkxKbFJIRndyMkN6aVYzQjRnNzJkOXJUYWQwcW1uc2pP?=
 =?utf-8?B?M21TTUFUSFRWaXltSVp6dTZtQ1hOMWE3dW5lalhJc2RubWx2azdXK2lNa3dz?=
 =?utf-8?B?emEwVzltdDhqUkFidDdhQitoa1RWaWJLSXczdGFUTlZmdmc2NGxDWDZnUlVP?=
 =?utf-8?B?L2h4Ryt6TzR5aHFaT1R0bXlCeUoxRVpwQWZnU21xa1FDZ0U2VmV6cC9vdHhQ?=
 =?utf-8?B?ajNacnA1Rm9YSmtnbDBHY3RnS1RZOUVweDh1SGJPZ3A5WWl6cUxtOGc1aU9X?=
 =?utf-8?B?dnhEMzNkTnV1ZC9oYWhNQTk3MUROTzJ3Qis4aXlJRzdvK2tjNS9xd1dCWXZ0?=
 =?utf-8?B?SVg1WU9PaXF3bmxGWDk5Z0NUVTNxUzh6dEJ3Rm1tUTRZWVFnR3lYc2dmQW4y?=
 =?utf-8?B?Z0pLamFJdjVlbjg4c29xRmJiMGE1b3VMUHNTUmQ1clFydXJFTXFmaDhKQmdy?=
 =?utf-8?B?ZlNXWVJpcWNBajNvbHNJejZZUjMxb0VIdmxaMUZnS294dzgyS0daejMvMUxY?=
 =?utf-8?B?R0RCbE44YmQzQlpCaVdETWJtdXY5Vm1PZnFIMmJoSUp3Y3lHd3h1UldWYmVH?=
 =?utf-8?B?bHNLUnllYkZ2YjBhVEYvR0lndTZ6dkE4MU82M0FzNDJaZ3V1VXZFbEFwR25o?=
 =?utf-8?B?cjlVa2ZDMTNxeXIrc2ptV0ZnRWlEcDM3QnJURmI1c0RyMmJ3bDZHVlNRNytG?=
 =?utf-8?B?NTBJNXNEV2VZSkFiZVRqcEtuZDc3bGFlSmpLRWtqT2I4VkpiV0tRcDBFaDQ0?=
 =?utf-8?B?K3JVa3JSMDhQVy9adkJKS1dKU1dWdmhTbGVMa3VSaE1RZlJTOHFhcHhNWldP?=
 =?utf-8?Q?8y97Cnn/zlg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVQyZ0xSVnpMaDRzV2lINmZnVkFKK0NRcER6Uno4a0I1SmxXUkxUNXVCVmJ1?=
 =?utf-8?B?enA0ckQybzgraDJOYnh4bVpNdDVEYldTeklCV09udWdmK2ljSUNrRDRVeHNz?=
 =?utf-8?B?S2tmTzdJZjV2WXQyM2pMMFo3MjdtZXNNdkJnNFRJR1BqbjFLd01zK1llNElZ?=
 =?utf-8?B?VmlYQTdVNFRyb3hLbXVaa054WTFWaEdmYVhBN2daVk56Q2tITGlDR1hKZTFa?=
 =?utf-8?B?dWIyNFhnQlRFR0RPMWIzRmVzTlNuQlpQRGZacnRZM0lGQzI3R0l5M1RaaURP?=
 =?utf-8?B?b0ZiSVpJNXA5NWdCMmN1MmVnVE9SbzJGS2VRVjllYk1Ga1UxNzdlbUZJdUpx?=
 =?utf-8?B?a1RrM0tvWkY3aXJCcWJYQmtvcGFNRmNqM1oxVUJyYk9vT3RkOTBTbm80bmpu?=
 =?utf-8?B?U2xtcFlnejhDM3VwcnZvSSs5WTgvVFlybWkxQUhzVHdNRjFmWnZJQVlCZWQz?=
 =?utf-8?B?N0oxejhmcFMvbG5yVUZkMWZSSUdORG85R3FHQ2NLMDlzV2tZNkRZenN2clcr?=
 =?utf-8?B?TVlzQmw5T2hyUTh3VWRscmpsZjV4RkN6NWE0Nm40cFkzc2hxVkp1WDVDdmlL?=
 =?utf-8?B?Z2k2UDRrczJ6SDBGYXZ6eGJxWnRxL1ozVEhiQW9ocy9KSTk5N0FlRTBmcW9r?=
 =?utf-8?B?T2kvRTJJcTZGM2RmZEtkV2FyYTZ5cVl2eHp2WEZCWE9Rd3NDUm0wdjNYQjAz?=
 =?utf-8?B?VVVaRWFsRXU1eE42MWdIa0UzNnVITlFJOFVwUVhmR044ZVF3Sm8xRG96OG4v?=
 =?utf-8?B?ZHJaS3FWaUZOYlBSWWZ5bW0wTzJOeTVnNjQ3ZG5uR3ptK1MwdFRLUVlaeHFi?=
 =?utf-8?B?QkZmUkN2Vkc1VERJV2lhaTdqZjVEUVlyTG94NXAwdFNFQ09uQnMvWkZkUGpU?=
 =?utf-8?B?aFU3bmJnU0dnY0tvU25tWTg0L0d1YW0zM3VOMWxGRmlEd2pSRmlNNk1Udllo?=
 =?utf-8?B?cVRQUVE1U1VScnVKeFozdi9MRGpqQnFOUlQ5dVYzUFArMDdscmVHQTB2K0dI?=
 =?utf-8?B?UkYwVms3VW45dW5QeVJNOHVEeTRWcW8vcXNEMjVsblBrN2VFMjd1OStlQ0xv?=
 =?utf-8?B?ellXZWdqS3Z4anN0L1M2cDl6aW9xMEVJbTcrT0Vxdm9HOWlqWk9xVXZiZzRI?=
 =?utf-8?B?aEMvUWVFYjJzL1FGZ2dBSEN2U2d2TkQwdmh6bUxDRk96OHU4N1lLRXZhUzNJ?=
 =?utf-8?B?VVhHQnlvSFhqWmhVZEV3bnYwV0FLV1M5SUFCN3F6ZU4wVmU2ZTVSUzdaMWo1?=
 =?utf-8?B?ZE1VVTZ3aStvZXg5cGtMa3g0UEZGVzlDeWkxTXJZT0tZS0MrTzNrSnltczlp?=
 =?utf-8?B?VWpzZURQMmtXZ3MyTDZKaUdtL0Q4SnBxbW5FU0YwUjZSeEorL2lPcWpLS3dq?=
 =?utf-8?B?cUN3RWg3UXdERUpJenpTT3A4M2c0VzZxeDVkKzNCaXhib1pTRXpLTnpGQ0FS?=
 =?utf-8?B?Q3QvZWd6TmxaanlnZ0ViQ2xVUUtKdzRHMEFFckFqMlRGbnl3NmJ2dzVmbEFa?=
 =?utf-8?B?QWVGZHVpcFQzMFBRNDJ5ckdBNERKa2xoUkRPUDZja2NZOEwxUVVuK1RoS2ho?=
 =?utf-8?B?V3ZWRzAwd1dNOWpoVDVNYlVoN2hRaGhHd21vS21YdFg2ZWlteTgzL0ttZHUx?=
 =?utf-8?B?bzVmRVVaZFRnRlhUN1ZwK3pqWDRBT0dWb1IxeUpWbFdxRXFSMFpYdlVQeGlV?=
 =?utf-8?B?U2cwNmo1eUNFNEJZYmxpNTVTem83ZEpwc1FnVXZMYzBlVjViK2VXUktZaUZn?=
 =?utf-8?B?VWtIQTI4Zi9OeHd3Z3ByblVaR0l0a1pvdWRHRERYZnl6d09KWW9naU83dnRv?=
 =?utf-8?B?YUlXNWV6NFEzTlpxTXlqZHpFRXoyZ0lNNEdxaWpFTEUwOFVvV0xnd0JVNStF?=
 =?utf-8?B?Z2dXdUwzUU1XanRYWUlkT1FyTTFQQ3ZzTmk3cTZueTNieFkzWEJuOU1McDVE?=
 =?utf-8?B?TW44OHorVXlyZjNNR2NsdG8yWGJWeUpMYmFZSUp6a2NVMnFpeFNLWTBCcTdU?=
 =?utf-8?B?cCtTR3RSVkptUWQ5aDhIM1ZjNWhvRTV2RDBsTC8rUEZQbVBkUm4vLzh4NGNR?=
 =?utf-8?B?VFA5RkVTQ2NqejdpdUY5cmxNajFhd1MrUFdxdjZEcGVpQ0daajVNMDZWNzUw?=
 =?utf-8?B?QzJTQkgxNGlTQy9yMkYwcVpFRnRVeFd4bmJQMDdxaWl4dXNPNjdWcDEzZE1u?=
 =?utf-8?Q?eY1DHk2jF6/Bkl9Oe//Bh2c=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28389b5-e823-439a-1779-08ddd47fe7a3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 00:26:36.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHnWp2+PXb0Z7fWLdZRwdM1GZJysFji6r3xZXnN3VXEUqqCSQsDfr3j4+opX23L/l+6Uqsfd4b9PDb/1qZBv4P0Az1dVy27VybTnk31IvGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7715



On 7/30/25 3:07 PM, Prashant Malani wrote:
> [You don't often get email from pmalani@google.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On a heavily loaded CPU, performance counter reads can be erratic. This is
> due to two factors:
> - The method used to calculate CPPC delivered performance.
> - Linux scheduler vagaries.
>
> As an example, on a CPU which has a max frequency of 3.4 GHz, if we run
> stress-ng on the CPU in the background and then read the frequency, we get
> invalid readings:
>
> ./stress_ng --cpu 108 --taskset 3 -t 30s &
> cat /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq
> 3600000
> 3500000
> 3600000
>
> Per [1] CPPC performance is measured by reading the delivered and reference
> counters at timestamp t0, then waiting 2us, and then repeating the
> measurement at t1. So, in theory, one should end up with:
> Timestamp t0: ref0, del0
> Timestamp t1: ref1, del1
>
> However, since the reference and delivered registers are individual
> register reads (in the case of FFH, it even results in an IPI to the CPU in
> question), what happens in practice is:
> Timestamp t0: del0
> Timestamp t0 + m: ref0
> Timestamp t1: del1
> Timestamp t1 + n: ref1
>
> There has been prior discussion[2] about the cause of these differences;
> it was broadly pegged as due to IRQs and "interconnect congestion".
>
> Since the gap between t0 and t1 is very small (2us), differing values of m
> and n mean that the measurements don't correspond to 2 discrete timestamps,
> since the delivered performance delta is being measured across a
> significantly different time period than the reference performance
> delta. This has an influence on the perf measurement which is:
> ((del1 - del0) * reference perf) / (ref1 - ref0)
>
> Previously collected data[4] shows that cppc_get_perf_ctrs() itself
> takes anywhere between 4.9us and 3.6us, which further suggests that a
> 2us delta is too less.
>
> If we increase the time delta to a high enough value (i.e if delay >> m,n)
> then the effects of m and n get mitigated, leading to both the register
> measurements (ref and del) corresponding to the same timestamp.
>
> When this approach was previously proposed[3], there was concern about
> this function being called with interrupts off but that was later found to
> be not true [2]. So, waiting for a slightly longer time in between counter
> samples should be acceptable.
>
> Increase the time delay between counter reads to 200 us to reduce the
> effect of timing discrepancies in reading individual performance registers.
>
> [1] https://docs.kernel.org/admin-guide/acpi/cppc_sysfs.html#computing-average-delivered-performance
> [2] https://lore.kernel.org/all/7b57e680-0ba3-0b8b-851e-7cc369050386@os.amperecomputing.com/
> [3] https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
> [4] https://lore.kernel.org/all/1ce09fd7-0c1d-fc46-ce12-01b25fbd4afd@os.amperecomputing.com/
>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: Ionela Voinescu <Ionela.Voinescu@arm.com>
> Signed-off-by: Prashant Malani <pmalani@google.com>

Thank you for cc'ing me the patch. I posted the similar patch ago and 
had some discussion on the mailing list. Then someone else from ARM 
pursued a different way to solve it. But I didn't follow very closely. 
If I remember correctly, a new sysfs interface, called cpuinfo_avg_freq 
was added. It should be the preferred way to get cpu frequency. Please 
see 
https://github.com/torvalds/linux/commit/fbb4a4759b541d09ebb8e391d5fa7f9a5a0cad61.

Added Beata Michalska in the loop too, who is the author of the patch. 
Please feel free to correct me, if I'm wrong.

Yang


> ---
>   drivers/cpufreq/cppc_cpufreq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 4a17162a392d..086c3b87bd4e 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -718,7 +718,7 @@ static int cppc_get_perf_ctrs_sample(int cpu,
>          if (ret)
>                  return ret;
>
> -       udelay(2); /* 2usec delay between sampling */
> +       udelay(200); /* 200usec delay between sampling */
>
>          return cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
>   }
> --
> 2.50.1.552.g942d659e1b-goog
>


