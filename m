Return-Path: <linux-pm+bounces-9624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2DD90F6F8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 21:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9782844E3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D82B74068;
	Wed, 19 Jun 2024 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ndSMkZ98"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74994524B4;
	Wed, 19 Jun 2024 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825579; cv=fail; b=p0AkZJF/a3iOzWstwM8gzwTQlmrfHZks7ChDL0PbJlpblVMrXOd3Qffdu2BOjk2aclzWyxpcLN9Fuh1HYUm/k56b4zalRhQoz7cNDk9B85WXb0Lsxi0njEkDz3UlunHv6tpRlg5TSR4OXzXDTdOxdb0orcMecUnd9CZmsNidbhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825579; c=relaxed/simple;
	bh=1aj5++4ltv5I3ENuTolino6Wk8CP8SG4HeibH63D6WM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hbauo3SrtFGqv9f0L03mrEz4r+WHoUPmWASE9/DyCS7m4QUgxZdTyaiS3eNrg3mF5X2Tf/BN+qE3u7TXP+kE190gX2xgVBaDUs/czHAHlQBdI+TfbSo5BTj0uC3swkfms8wfVZoJ6p/Z6CzrbH/whv+XstM53gw8Q6MNYc1mLHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ndSMkZ98; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEDNRa+Ac6VwbmcSmsjXSNKgNkZHvd1gh1dghvAAiK+oW7tykPIiVno9uur3UJ0Zl7g0iS4AgI5tkppxW4ibZh7tag1WqBXqXthfRUS26c6gEIjmeyZVw1sHrd1qgbMp403EQIihvSa7agZjx646l8Na0EbiI4vNBKw2bN1BeFITykdp0LDN9U/1oHxpvt9IeHCf+uXoSNFIpMMe16QfX0ThI0PJVAPGKxXOXIWa8FuNc3oBz8vVDAcKkRzMRL/bwrxDAe9DrwxT2c3iEtSTixWOCV1Xx244ux78YIdRx1RMHjVd72UHJNDd2cWO3JSzvYiRd4Mc/X0tw4OzKUU9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/WHqbURZe3IXeUP9Wh53SIdKfhYAT0Flq8F67dQsG8=;
 b=Vg3AJYqg7xRXoVDdGdVoofONIuZpr3nD8HpSQdBf3yUiBQkFk4ZYfpYm1DaEUKoIVEnXbH57Zp4H9MSePOf523HRCu+Db0BcIYDTJYoOP7c2OE1OYubwDYZ0Eumc6EsyqkR6bZcIKpWdgK+WPyTkk5i74l3gtBfK2uQOZAe4KBAstsGgmdpsO0/rwbkOM8y5Ew33ejNxOZnNKEiUVErsM6wgfGuBZLJRSGqGs9rZIVIgU/G6V9ePOJkq7fgszok6E3LF7k4JIAiPO7+LRowelqyIrYUZDj+VMgOt0+bMVUrLSlG7cRdTop9SycUuY+oILPF2w5H+xh9XpdCznSVeBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/WHqbURZe3IXeUP9Wh53SIdKfhYAT0Flq8F67dQsG8=;
 b=ndSMkZ98tcH6uph1Exio56IeuyLFSSmsfR1hxElSiFXNWxZlt3ccDWJ4vIV2xtq4AFrDQqrPwhgxKJXIPaR+c3qtptU2zp1ju1ZKVQGqc6WGfiWN7uALbnd01A9TqMBJbcxNKwJDlOMNR8e2SEt5CT4kA4eeSlgId3JAm/J2C+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 19:32:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 19:32:55 +0000
Message-ID: <e32c77c2-6284-44e5-8224-c3484d8631c9@amd.com>
Date: Wed, 19 Jun 2024 14:32:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/9] cpufreq: amd-pstate: initialize new core
 precision boost state
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, gautham.shenoy@amd.com
Cc: Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718787627.git.perry.yuan@amd.com>
 <a9e6d487f7405e1c5b4affbd5ebeb4098f0e70e4.1718787627.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <a9e6d487f7405e1c5b4affbd5ebeb4098f0e70e4.1718787627.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d6195d-53cb-4ae4-8205-08dc90969df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVd0a3F6NFJraENUNXo2dTZqRklXYVArQzVNSU5DZlFtODc4bUNKd0lyMmc0?=
 =?utf-8?B?M2pMSERFaU80cG9JTm9rTDhUbXJueitCdzJsaThUWjNIRXFMeWIxZlBOVjNV?=
 =?utf-8?B?RnZYRnJlOE9BQ0cxcjludld0NStWMWZWaVJoakc5cXNkeUtaRWxTZGVramZy?=
 =?utf-8?B?U2VlYTIxVWcrVnMwUExHdTQ2eVFReGs2ZU5CT1FUM1EwY2U4NzE5Vi9vTnV1?=
 =?utf-8?B?N1hWSmV4NE9Fa04rV2ZRNXlvMjBwZVlrbkxSWnRXdlpRTVExMlNicnFLNU96?=
 =?utf-8?B?RStTNVFud1QrdXA3NTZud3F3Tjd2aXVaUDZQSUpROGZ3NUlUT09QZDlxeVF5?=
 =?utf-8?B?bytvNkxndzE1cCsxWXlyQlNlWG1TcHZBdDdSVWlkZ3dKTFpVUFBzbTlmb2d4?=
 =?utf-8?B?SG1PWGVDNkRNekZRY2hiU25qVGdESWRxZjZDbzdFNlFXM0hhb1NxVnhIQUJX?=
 =?utf-8?B?Y2M5cmNDR3hFMkhEejc4SlY3RWhtUTJ4Z09vdWZncW5wcFlITEpvZ2VwZGRL?=
 =?utf-8?B?MjN1OTFQSDg1a2hMTWV4eTJGMHBDTE1ZQWhNdXZyczkrcVNuK0ZBMkNkeEZM?=
 =?utf-8?B?dGw4akQ3cHRHK2g5Z2w5dUVaWisxSFdjU2JRZ3JER1lTUGI0NGQ3NzJ1MDQw?=
 =?utf-8?B?VWZKbExtK0E5Uk52bEtTbndLVHhsZDJ4YnpsdG9iOEZTbGpTSHJoN1dWM2hN?=
 =?utf-8?B?MVBtTFllT1pqZHNNMDUrNnVWdVQ4ZmZRT0dXMmJxU1l1NWg3OUlCZGNNQWZM?=
 =?utf-8?B?NXk0aHpsMEJadGpGV25tTlgrelJqbDJYQm9rL1A3VEoyVlZuUUlLRjBIU2Fm?=
 =?utf-8?B?eDF0T2diZGZISXRmRk40YVFYRXk2c0Q5ejdVUzRlTTVFN3BWeC84NFhZbUZn?=
 =?utf-8?B?UUFDTitXRW9BTFVQczYxQVdmaXdXc3RDMTlXdmJhd2ZZL21zQnRqdmhSOXhj?=
 =?utf-8?B?QTd2MlM2Tm1VYnphRmcwZ3VOT3c4NmhLWVdxTEFjQit0TDBNREh4NS9EQm13?=
 =?utf-8?B?N3JMejhKaUpZNUpRQWc1M0w4UjNSNnAxWUlNY2tkM3FSRWhIb3RjeFloaGRY?=
 =?utf-8?B?UnNqSzN0L2thSWdLcUVnRllrUjl1a0M4Tk40cjNwcUJSeThUWXBxZDhmUlNI?=
 =?utf-8?B?V2xaVlI1VW53YmxDYStNUzhxdW00R1M4ellna2hKWlZwTlV3NmRWQm9WdlVq?=
 =?utf-8?B?RWR4WEU3THNLSm13RlBqODQvL0tjb2k0L2ZDZkJwZkNvWHNGSFpaVEFLaE5B?=
 =?utf-8?B?S09LZGFDMGlDcW5HbUdXS0s0ZDlqVldzbmVrdGVIMndyQW1UYjFvOGx0WVhO?=
 =?utf-8?B?cmVEUkhSS2I4Ykt3UTlaK0dVS1NwTFNpQ3A1WURZZWxzVTJGNUdRVWZ6d21P?=
 =?utf-8?B?dWpzU25pV3pGMDRkVlRLY2hnUGFUR0J3aUxJNXY5QVZtNGJZVnJwbW8xNEdB?=
 =?utf-8?B?bm0yMy83d0VNMVltcG00RHZqWXRsZlg4b1hRZXFOaWVnVVRYbGtYM25lRzNU?=
 =?utf-8?B?VTFXbDR4dE9hMWQ2c2Q3eXZmZnFHK2x4S01ZcmJIdmV6REkrU1I1YUVBWUo2?=
 =?utf-8?B?VVJYK1pIaFF2VU53OWd6eGdFZlRJQmdySDNieklTR2d0SXNBUW5vTTVDZE5U?=
 =?utf-8?B?cExnV1VPR0NwbVJseCtxS3psd3dyMndudzd4WG1rVk9FUS9WMm10VUVFdlRL?=
 =?utf-8?Q?U+x6mZ6jdsXUD0dAZmY8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFJWUTRLODhtUFdTSjFTcGRnczJtZ0RSajdaaHVUTklTdXJCYnVTVzdqSFJp?=
 =?utf-8?B?RlRPL2VrUWphUDZxWWxoa3ozTFpGcEhiRnRQM29KTG1ySHlOZlRlSTAra3Jt?=
 =?utf-8?B?cTFQOU9OanFoc0piazZPa1RlTmIxZWhGSjgrZWx6TktpTHJHb3YrSHBmWTFa?=
 =?utf-8?B?a3lkdE9MSm5ydkhqUmFUSHdsa3dqRXVFanh5emRsTGVyNnl4YTJCanJ2N2VB?=
 =?utf-8?B?d0QxbnVRSmdjRXZVbitoTW5COUFUN3lDRFJocHlpZWgrcW1GK08yVE5mY3ZM?=
 =?utf-8?B?ZG9nb0Y0dW1TWEw3dGJvN2hNcm8ycFBQUm5BWE51RDVMSWl6aGQrNnBsRkpW?=
 =?utf-8?B?WElTcjdtQnpZd0wzNmxUaUdiTnZnejA0SWRIam9jVDFGR1p6aCtrWDJWVVJY?=
 =?utf-8?B?UmxlYzRQYmRTckdYTUwwT2JNRHVLUkVwOVQxKzNxU1JNZ2RFcGRZc2l4Q1pT?=
 =?utf-8?B?ZWhzR0orclp3WDJCdVBSaEJCTFV0UTNXVFl4bkk4d001dlV6anhBNERWd2c2?=
 =?utf-8?B?V0FXWUxidjMzWlFyckIzYUdCbkJ3RG5LSUwrYTFxcWRIQ3lJc0pXZlNHWlJx?=
 =?utf-8?B?R04wV01wWjI5bWZZVGx1QUZ3OUlxSWRKckdKMVRmdWRvdEk0TEZNNmlhSUJs?=
 =?utf-8?B?M0E3WnpNQlFURFJaMmxJVjljVlJFbEtGSkNmU2hRUmo3SmFnYWsyb0tJbDBY?=
 =?utf-8?B?NHdYSEVQWGJUMERjOWxac3hZMk5iVE5KUTEzbWxLWWVxeFh3Y1JaRTFKVGZJ?=
 =?utf-8?B?Sjl6M3RqbE42cWZna1VpQUgzcHBVZ3F2TXBLblZXMThGUVh3d3Iva3lzRVdG?=
 =?utf-8?B?QjJNb2tmeURBVTlNUExtQUF0UDBta0VKeGttNE91RFpZd0V0UE0wSmt3REFZ?=
 =?utf-8?B?dTU2VzRheHN0eXdIVldQM2swaGY4YjVxd0RGcFJaZmF0b0NEZURhZWR6dHdN?=
 =?utf-8?B?aDBUZk82SVpLaUxnY3M2NnpXd1pBS3B5SEZzcE9yS3h4c3Q3cDR4bHZDdGJO?=
 =?utf-8?B?eXJ6ZjBJdWJtUlpRdGtGVGFVWEY5MkRNMklyV1VNN2RTcit5ZnJsc0FFbE9Z?=
 =?utf-8?B?NUt5U05NNkZoTTQwdlY3c2lyelc4NUR6U1dFYzd1aFZzQ1RUS3hPNFJxVWo5?=
 =?utf-8?B?ZzkyRU81TFQ5K2VqMUtYMTFUeXBxTnVESlF5TkU1aGd3OCtDd0N2THc1clNG?=
 =?utf-8?B?M1o1OUpCZDVsQkRnU3I2c2Z3VDJjakM3OHNIcDI0NGxNMWRtQXJMMDZCMnBJ?=
 =?utf-8?B?RWxqMjUveFlvRWgwOExRekZUREhPNkJyZ0E0ZTlDM1NscmFVeWlDWnEwMnhU?=
 =?utf-8?B?QkFuRFdoaWMrZkdKcklJU0c1bkUrRTEzaVZiUlBqU3MvYi9BMmw0d2FVTldI?=
 =?utf-8?B?QlJVVDdQQ1JFWkg4TDBaTHBnaVhXd0YwTTQwT3p0U0R5VkFBUWg4U1pXRnRV?=
 =?utf-8?B?MDU0ZHN2cDlka0VXeWJoOU40N29wUHdiVDVJRW5NbXgwZlNaTlpXbW9YNUNY?=
 =?utf-8?B?dm9zNlBVVnBRby9Fek5ZOWZocFBlaGhpT0VuWDdZWlhyNEhNRWxIdytvV0lB?=
 =?utf-8?B?cnRhMmZzSjZMRWQwUHlLMjJpRUd1NWxNbEJQUmpXd0xmcUZCK1p5TFpqMkJN?=
 =?utf-8?B?R2RkSXU3WlIyTm4vUXNZWjFhL0VYVGdPNlpIWW9KZVVNTXJMcnMwVU1EYmhr?=
 =?utf-8?B?ZkFmQzd0VjI1MVczZlBpbTNKaW9DamhZTFF1RnJNNWllc295TTgzSE9nOUlv?=
 =?utf-8?B?NVd4a3hnV1FYajZMMElDUjZIWTBDUm91ZForaWlGdDd2NUJYNDFvNnpoREdY?=
 =?utf-8?B?L2o5U29xVkI5ZDJSTkRGcTVJQnlucGUyMUFGaldEcDRWdCtXNE9Hb09qOFYy?=
 =?utf-8?B?eGdEa3loV1Q5RUZ6ajNLSGRoSHlQek92TjBocFo2RmRnNFhQcGhLT1J0WEs5?=
 =?utf-8?B?RnE1djhWVUlPTEdLT3M0THVIUkJVZno2TnJEcHNKc1VDMHArUFNsTzBxdEJW?=
 =?utf-8?B?dkp2aWY5UDYvRk5JRkExdm9UTzFmVEp1Nks5TnRCZkZSallzK1g1eEZDd1NE?=
 =?utf-8?B?ZUVyaFZCWHFqWDVHa3JwQVNDbDZqVysxK3RLeEZvdERrQ0FJNlhITHJWNURz?=
 =?utf-8?Q?cecSsKOn7BEkVlo2loUWDQm0L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d6195d-53cb-4ae4-8205-08dc90969df9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 19:32:55.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQB1JysqsKgfK20e40Ozzg2Sv554LZE+gqH14J7Yj6+P/xl3ZfylXUUSmcaT06OVQZzcmiFp2JINBXy1Ypy3zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284

On 6/19/2024 04:16, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add one global `global_params` to represent CPU Performance Boost(cpb)
> state for cpu frequency scaling, both active and passive modes all can
> support CPU cores frequency boosting control which is based on the BIOS
> setting, while BIOS turn on the "Core Performance Boost", it will
> allow OS control each core highest perf limitation from OS side.
> 
> The active, guided and passive modes of the amd-pstate driver can
> support frequency boost control when the "Core Performance Boost"
> (CPB) feature is enabled in the BIOS.  When enabled in BIOS, the user
> has an option at runtime to allow/disallow the cores from operating in
> the boost frequency range.
> 
> Add an amd_pstate_global_params object to record whether CPB is
> enabled in BIOS, and if it has been activated by the user
> 
> Reported-by: Artem S. Tashkinov" <aros@gmx.com>
> Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 59 +++++++++++++++++++++++++++++-------
>   drivers/cpufreq/amd-pstate.h | 13 ++++++++
>   2 files changed, 61 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5bdcdd3ea163..0c50b8ba16b6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -102,6 +102,8 @@ static int cppc_state = AMD_PSTATE_UNDEFINED;
>   static bool cppc_enabled;
>   static bool amd_pstate_prefcore = true;
>   static struct quirk_entry *quirks;
> +struct amd_pstate_global_params amd_pstate_global_params;
> +EXPORT_SYMBOL_GPL(amd_pstate_global_params);
>   
>   /*
>    * AMD Energy Preference Performance (EPP)
> @@ -694,7 +696,7 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>   
>   	if (!cpudata->boost_supported) {
>   		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> -		return -EINVAL;
> +		return -ENOTSUPP;

You're using -ENOTSUPP here and -EOPNOTSUPP in amd_pstate_boost_set(). 
You should be consistent with these error codes.  That being said I 
think the other error flow needs to go.  More on that below.

>   	}
>   
>   	if (state)
> @@ -712,18 +714,38 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>   	return 0;
>   }
>   
> -static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
> +static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
>   {
> -	u32 highest_perf, nominal_perf;
> +	u64 boost_val;
> +	int ret = -1;
>   
> -	highest_perf = READ_ONCE(cpudata->highest_perf);
> -	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	if (!cpu_feature_enabled(X86_FEATURE_CPB)) {
> +		pr_debug_once("Boost CPB capabilities not present in the processor\n");
> +		ret = -EOPNOTSUPP;
> +		goto exit_err;
> +	}

This needs a little bit of unwinding to think about whether it's correct 
return code.

This is the call path:

cpufreq_driver->init_boost();
-> amd_pstate_init_boost()
->-> amd_pstate_boost_set()

So if we end up with a platform that supports CPPC but doesn't support 
boost we might end up nuking the amd-pstate support "because" of the 
lack of boost.

For this reason I think it's better to set the return code to 0 in this 
specific place.  The others in this function look correct to me and if 
fail should cause a critical problem with setting up CPPC.

>   
> -	if (highest_perf <= nominal_perf)
> -		return;
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
> +	if (ret) {
> +		pr_err_once("failed to read initial CPU boost state!\n");
> +		ret = -EIO;
> +		goto exit_err;
> +	}
> +
> +	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);
> +	if (amd_pstate_global_params.cpb_supported) {
> +		current_pstate_driver->boost_enabled = true;
> +		WRITE_ONCE(cpudata->boost_supported, true);
> +	}
>   
> -	cpudata->boost_supported = true;
> -	current_pstate_driver->boost_enabled = true;
> +	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
> +	return 0;
> +
> +exit_err:
> +	WRITE_ONCE(cpudata->boost_supported, false);
> +	current_pstate_driver->boost_enabled = false;
> +	amd_pstate_global_params.cpb_boost = false;
> +	return ret;
>   }
>   
>   static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -1005,7 +1027,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   
>   	policy->driver_data = cpudata;
>   
> -	amd_pstate_boost_init(cpudata);
>   	if (!current_pstate_driver->adjust_perf)
>   		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>   
> @@ -1387,6 +1408,21 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
>   	return false;
>   }
>   
> +static int amd_pstate_init_boost(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	int ret;
> +
> +	/* initialize cpu cores boot state */
> +	ret = amd_pstate_boost_set(cpudata);
> +	if (ret)
> +		return ret;
> +
> +	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
> +
> +	return 0;
> +}
> +
>   static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   {
>   	int min_freq, max_freq, nominal_freq, ret;
> @@ -1465,7 +1501,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   			return ret;
>   		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
>   	}
> -	amd_pstate_boost_init(cpudata);
>   
>   	return 0;
>   
> @@ -1704,6 +1739,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>   	.exit		= amd_pstate_cpu_exit,
>   	.suspend	= amd_pstate_cpu_suspend,
>   	.resume		= amd_pstate_cpu_resume,
> +	.init_boost	= amd_pstate_init_boost,
>   	.set_boost	= amd_pstate_set_boost,
>   	.update_limits	= amd_pstate_update_limits,
>   	.name		= "amd-pstate",
> @@ -1721,6 +1757,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>   	.suspend	= amd_pstate_epp_suspend,
>   	.resume		= amd_pstate_epp_resume,
>   	.update_limits	= amd_pstate_update_limits,
> +	.init_boost	= amd_pstate_init_boost,
>   	.name		= "amd-pstate-epp",
>   	.attr		= amd_pstate_epp_attr,
>   };
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index f80b33fa5d43..133042370a8f 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -102,4 +102,17 @@ struct amd_cpudata {
>   	s16	epp_default;
>   };
>   
> +/**
> + * struct amd_pstate_global_params - Global parameters, mostly tunable via sysfs.
> + * @cpb_boost:		Whether or not to use boost CPU P-states.
> + * @cpb_supported:	Whether or not CPU boost P-states are available
> + *			based on the MSR_K7_HWCR bit[25] state
> + */
> +struct amd_pstate_global_params {
> +	bool cpb_boost;
> +	bool cpb_supported;
> +};
> +
> +extern struct amd_pstate_global_params amd_pstate_global_params;
> +
>   #endif /* _LINUX_AMD_PSTATE_H */


