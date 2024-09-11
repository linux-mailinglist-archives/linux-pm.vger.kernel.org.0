Return-Path: <linux-pm+bounces-14036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91F89757D0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 18:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178C31C21823
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 16:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1711A3031;
	Wed, 11 Sep 2024 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TOLlQ6kb"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6A3EA76;
	Wed, 11 Sep 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070531; cv=fail; b=AE4ST+1du3l9OPOvpJ4nrslKgCNBg99VTg4KF64UHI9gFI6BfDgP0+Z31zgoPGxf75UN3F2/6o/D/1Q3DPdkmPlApbEUivpBzM0moyyy8aUSuy75agVde/9S+CGNT+gFvd3dL2xwtNh6P6wde8/KuQNbTMCOvXBPEy5TttwI+hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070531; c=relaxed/simple;
	bh=WArCZcXogjj7bPI2/sFFG/zseLUFPy05bQqaT9bH0tU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=apvTOV/VEumM5pezQ05+RLAVepVSvqvwZQxV1RiX8cNgN66p+j7TkcR2ysFpPlft2lJaD83cTSxJnIQmKy0IVRU5HEFeMbIsbkwO3dR9qEOmZHWzpefgPy3hWk7ESKGjNGi9s/lVYy8cOtVAPLg7uvZTh+iTIlL5TA13Zk3ygXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TOLlQ6kb; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaDoW+wrcJdbslG6fzt/FDF6qnJfA64CgFyE9EFFwwJSNoBq7VwX3MnQENUFMdKcqvJG3jHjP3YMLfOWu+5cZRIvrdmXL6QprZhYOfaRIoZwkhFWBQQYDA7T+Chf9d37W5+E/Mf7lL1rEx06HqODIQeMCMLC7Sbe1yWZt2GKlLzHGoq2cK5fX9Cs5683Uyx0xi4yTD/a1BUSeWhNyeEpk/BrUgdVp6th3n7/1NGq3XitVeVf4ejGnx3XWJug0N/FpZ56H4tHE6AJzqwVIcKR44lvSdew27OfOHq9DUDUwr8wqaeJfkHRXumd+5wZBgo8I7oRnPhckMiYfq73V2womQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzbtIllT9/C+h9HXxgImQ9zeAcU3cwI1OHsDEVi1jYg=;
 b=PszpzzcdaM8p/FGJGrdh3vkDaK72Qs0aiZf9fdrzBZHyiy+r0OY9+cmc25NVdqM65Vhepu852a6M51WtbTi8475P5H0Dk5jBRxc6fYn6+mJi/S2jJJ8a5uNW7cyNRuavl7g7e2q0ypY/x4aHsp1rNGTCc6p2negvxzDfSHwxEZ28F4oe65mgtk+/2d19eXyB/yQ3ie991rOSZLZ0omGlk6wnwfMEdui3wR0GHGqlGBEaPc7+L6vownlkIpohXoFUgBB0gfyztspyDBb+cINSuy7zYSo3/OlFxmg24hWZvFCsjrde/ArJJ/Sw3UbZmWuXjuVNuh/jXVt6EqhfGWknmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzbtIllT9/C+h9HXxgImQ9zeAcU3cwI1OHsDEVi1jYg=;
 b=TOLlQ6kbGTAwneB+jLq7gEUYR+X/ld9nuifFkKvhcIwqfdKeG62p3b1n17IcvYZVTTWoBI8xV4hTy9Ys+wvhfVkHkVoY6YQ4ZiOiHXzavb+4aE5vVZ65i3xBIVeVQ6Nn0HzdoKkDin7khQwKHyiXwUt2UN9b/WO7ICXPIYkT+Bo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 16:02:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 16:02:06 +0000
Message-ID: <0af7ec21-d470-4efe-98ec-9b4879575478@amd.com>
Date: Wed, 11 Sep 2024 11:02:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate-ut: Fix an "Uninitialized variables"
 issue
To: Qianqiang Liu <qianqiang.liu@163.com>, ray.huang@amd.com,
 gautham.shenoy@amd.com, perry.yuan@amd.com
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240910233923.46470-1-qianqiang.liu@163.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240910233923.46470-1-qianqiang.liu@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0151.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ec58da-182a-4901-ce58-08dcd27b1580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGFHaTlUQ3ltVGo3Ymh0NndCVHZiUEhQZUxDblJqMGtSYzNVU0dPZzFiOGNF?=
 =?utf-8?B?YjE5b01pRzVsVkx1UjVycWZGOFBWY1RsV01GOWtLMWh3YVhCbVNlaDVNU1JS?=
 =?utf-8?B?SFlsOTNRRWxrR2ZsS0RTZlc4cFZuZlZJUWdVOG1mNlBSVERXckJKL3k0UFZz?=
 =?utf-8?B?eTlFcTNBcmsxYWR2azYzYXY4NUxjZXpLSkRwekg3UDRPc3BoL203TTdyQUoz?=
 =?utf-8?B?ejByTWhVbGZ6ejl4aXV5clVvTThFL21iUnBXOFV2UlJoSmRuM0hPQ2xVczJW?=
 =?utf-8?B?a1pSOGYvdm02UVdoc3MwdWtSTTJta0VDRGx3clZPT3dhd3lHL2JhaHhBSkFE?=
 =?utf-8?B?LzBsYnNvQWQ4Y2pabkFVU3d3ZzFLMjdlT0VycjdkUHQreE1KeDBWUFFoN0w5?=
 =?utf-8?B?UTU1YVVNL3pSRnA5aWNrZloxcW9qd2dnQW1hdnVlQlo2NmFPOGMrTEk2b2Nj?=
 =?utf-8?B?V0QrUnhxZ2huSFlCSDRKaEVRS0thdnlYSWRNSWt1aVJmbnk1VjNOWTJNR2V3?=
 =?utf-8?B?bWVnQndJM0tWR1BKbjhKelRaR2k2TkYxTDFQTjBQTjY5RWdxdStsamNUWGtN?=
 =?utf-8?B?TjlTV05LdVdpZlBZUXowSmlmQWc2ZTVlc0RPNVJWc1owWVBrQ05VNXJ5T3My?=
 =?utf-8?B?aSs5RFdXT3ArQisyZUpBd0hTV3IzTmV2bGRtRTlReHJ5QzlmZVVuNmNQOG9G?=
 =?utf-8?B?c0g1REtPajd1MnNKRFE5b3JVejJpTS9rSWxEQ3duZGwranZhc3dTYW9HM2JT?=
 =?utf-8?B?T21jeGo5MFFHNEQ0aHpWbG56U1pOdHRlMDk0djZ0TGppeGRsekVlUldZZE9Y?=
 =?utf-8?B?QVcrdEV0WU1lWFBlbEQySmJqLzBadzZmZ1hvTTMyeWMrZ0RBRHU3dVd3SHgx?=
 =?utf-8?B?aUl6SUs5RU9VS2Y2UHorOXdQSWwxMkJXelZCay9aeU5HSVRqS0FWUVUyeDNJ?=
 =?utf-8?B?TmtGb1pHV1NsOVNaV3lUdlBscGxjRzR5SHlwYUVPVkNxWjlRTTlJKzh6Tk1j?=
 =?utf-8?B?TEt4ZGVpNUlPUVFxRHUrWGZsTGQ5dHIvU3RlYVA4bmFTKzVyV25MRFkxK2wr?=
 =?utf-8?B?REluV0R3aE5nMzZhWTJTTWZSU3FEUnlReXFXZmxndTc1aFk1RUtjRzdqUHFX?=
 =?utf-8?B?K3FCU2hNOFNaZGRZMXJsaTlhc3JHdmswbXYwaTNUaHVHdDhLWE9senFtcnQx?=
 =?utf-8?B?SHZwTTRVdkZITnJQWm05QUNEMDlselk5VjBLM0xZUTI0YUtVZ0dMUHUvL1Ur?=
 =?utf-8?B?K0d6bGN4RGhpT3Q5blphaVNUdlpMV3FuOXBJNXpsOUxDdzRBRDE0TFNySGlC?=
 =?utf-8?B?SUk0UjlSMzJtZkQ0NnA0cWJnYnA3TGRML2pBQmtMcnlBWUlMKzR6cGtLdlFv?=
 =?utf-8?B?aXF1Wmw0U2paMXU3TW13bmFkeXRMUW9tWWp6akNOazR3ZDJsQy9pRjcwbDBS?=
 =?utf-8?B?VGNLNHJkSUQyaFVJVU9vSkQ1Z2txM3RORDdMWnNPYVgzMnNzWlAvMWFLSUNp?=
 =?utf-8?B?RnJTbHhMSUhGeDlDbi9OSEdtKzU3ZVJTNkVCaTdNS0lVdzVtbjhQVndpdTli?=
 =?utf-8?B?bmZ0dEFSandOcStqcEQvZDBaMDBLbHFxMzVDSkhpdnNndzM0dEFvZHlkODZK?=
 =?utf-8?B?a29HMHhtYlU3dGxlUjZMakJ6VndrcWZRZktvdDZ0MERLdS84SjdSQjR3NGg2?=
 =?utf-8?B?UXJoZlU2SWhCaEczTU0rMVNWekROQkg5TnFYajVMbFp2cWZzbS9Dc2dGcHp2?=
 =?utf-8?B?RVdQSi93RG0zOXdOSy9zam1yaG5iS0VieVBhNDVZY2lxUGFtK292WlJnQjk3?=
 =?utf-8?B?Y2JFc3BEOWNGSVJ5QWEyQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTYvZEpoeEs2YThMVnFiOWlrNGNyL040anVNTklia2JFaE85d25sdlFyWlNO?=
 =?utf-8?B?WUNOY2RGaUx1c1V0dUdCSWt2MVFTUlY0L1drb2NRa3p4NkgrMVdSVS9EMHRY?=
 =?utf-8?B?Rjc3bjUyM3ZhRDhZck1tOHRoMmFtb29QUGVGNHZWdGVZY0VBRVpEMGdiMDBm?=
 =?utf-8?B?aGRiSzFuYWU5WHZzb0NtMHE1Vjlzbzk2dHlPb05FU3Vtb2ppSDI2TTVuYWpo?=
 =?utf-8?B?VmpaU1lPd1VzZHFXa0ZsMmVwNHlDV0FWR2xieHpTLzFsVWJ4K0M4SXc2S2c0?=
 =?utf-8?B?U1ZHR3grYkx0Sm9TaVZISWZ1REtrbHhXaXVQV09KWmwvYUQzTkFIODlIU2R5?=
 =?utf-8?B?L00xbTRvQjVnS3RuWTdtbHM3cjlycEowYUxrV3NlQ200MG9zdmtoZmFFOW1B?=
 =?utf-8?B?bXZGMFhhVjh4S2JDcU16bk9YOE1BV1VlU21ZYk12dEtDREhOZU5nQmhRTUxS?=
 =?utf-8?B?cTlnR25BaTY1ZkVyOXE5Y09iOWlrc3pRbkNuRWhqNVJLeTFmSFJUWFFLWm13?=
 =?utf-8?B?S2I0Q1RmdEMySUJaOHRaR0JPc0JqMUo2cHVoZG1RMklJZzM1eFBybUdGZjdN?=
 =?utf-8?B?WmtmRmZxZ3FjT01aUnNrUUZXWDRHQ2xDem1oaCs5R3RnNjU2MjBlRWlpYmRW?=
 =?utf-8?B?UDU0QVplYjY3YmI3YmJxMmxDcTFXNmFIaFdua2J2VThYaDk0NHhvamlGVHFS?=
 =?utf-8?B?RXBrZ240c1AzUm1EWDdKaEN6aXB5MWUzMUt3cnhDN244Z2VaKzhGdFh0WlZq?=
 =?utf-8?B?VUJhaTVnRndLa2Q1R1JYSHE4blh4elBSVnBQbVU5UzM1cmVOQndkK2hNazZn?=
 =?utf-8?B?K2VtSkw1MDkzV0pIVGg1UlMwdTNOZEhPNGZDT2hIMjVMZDBMUjFick9hWWtU?=
 =?utf-8?B?bCtTQjBLU2VuOG0yZDE3ZC9Wb2JkVlRkOFlUM3h2VUVCaU0zM1AxaTdDSFhr?=
 =?utf-8?B?NmY1RlFkenpXZHQ3cjRZVWhsZUNweFU4Tkt2MExuWWxHVnBUWVErSjgxWjE4?=
 =?utf-8?B?aS80WjE1WnZUN211QTZnNURJa2RJbVh0WU9HTDBzejNma1BQRUU3QjZodjdG?=
 =?utf-8?B?eFRXeGFXdlRlUlJPYVVXVHdwNlBHSEJJbDRPWU4vb0lINmp4elZkdzlDUlRq?=
 =?utf-8?B?dS84dXNvdWVkR096VEQrSlhsWXFHUk5RSWx3dDJCbFVsMkE3aTNJWTRQei9x?=
 =?utf-8?B?RXY2ZU40QzRDQStsbUt4cXd6SXBSMHRUSm5oWXlQS1FWMWVmcnYzbk9mQm5P?=
 =?utf-8?B?VnBCL1lVQ2lCbDhzb25QTnlxciszaW1oYnBiWlZZUFcycDVYUGhHNXVIQTJK?=
 =?utf-8?B?SGtOWW02QW9nV1hlcFlHek5yTncvdmlpeVJLbDZQSXlXK3JaaytPb2NFcHoy?=
 =?utf-8?B?QTR2cTVnaWhCd3BqenQydTN2TTQ5ZUpTQWpaenhNQ1U2WVVwWGZMTG14NUxy?=
 =?utf-8?B?S1JZeDdVaGJoTzBOaEtka1ovVk5NcUUwa0xhWW03VjRyQWFuMWZIbXpWaGQ3?=
 =?utf-8?B?Y2xZcEZXVDJXN2hJWXZHeHNHNmlTdENVWnhURWdhUWpRZy84ZzhzUjRreXdt?=
 =?utf-8?B?OTdQa2sxUkQzcTcycXNRMDM1dXJ4UWQrQVJkTFBpTFdBaW5wRE5mb3FlRkh5?=
 =?utf-8?B?dW9SQlA3ZjhXUURjNjgybWQ5dTlqWlZUS1F2ZHhKaHQ2d1d0TVUzVGtCTlhJ?=
 =?utf-8?B?RmZIZjNrTHF0UEh6cjZOUmtvWm5aVWpBaEpNTlpFTEE1ZWNXa3prZVFjaFNt?=
 =?utf-8?B?dlRCVEw0YldFQTVFR0ZpSjc4VFJuT092SnhOYmx3REZ0OHgzWjVpY1IzZDh4?=
 =?utf-8?B?OGtCMEZqVk5mQkt4ZGlWS3ZPTTNGTU51US9HYXJWdTdTTjdhakZVTkwyVkpH?=
 =?utf-8?B?TiswUitHa1pFdjFRdWZKK3dVc2pGVHlTWWtuOUZ4WUlTVEU4dTM2aERWZkMz?=
 =?utf-8?B?amczeEN0NGxDTkJQSTBaVlcySWxYQWU4SDBDa252aGM1endXYjVMVWhOZmhn?=
 =?utf-8?B?Yzc5RjVOOFA0bXdzWG16V0o0WG1INklsQyt0UHZJYlVYUEk5S0hmT05INjhI?=
 =?utf-8?B?Mlo2K0wra3hOT0F6UkpWdmUyMk96bnJFODlFZjU4M0VQVnJCbTFCaSs3cHFj?=
 =?utf-8?Q?abAfT1MLmUG3TLgRQn0RH5CGv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ec58da-182a-4901-ce58-08dcd27b1580
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:02:06.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBTYB4MKQuBgEHbeIkdZA/XSL3Gf52O+6Lzd974YB5N2tWXNb1hEOuKCIQzhrIuYUp2wRCKIfWfvtGUyiG52Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805

On 9/10/2024 18:39, Qianqiang Liu wrote:
> Using uninitialized value "mode2" when calling "amd_pstate_get_mode_string".
> Set "mode2" to "AMD_PSTATE_DISABLE" by default.
> 
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>   drivers/cpufreq/amd-pstate-ut.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index c291b3dbec38..f66701514d90 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -270,7 +270,7 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
>   
>   static void amd_pstate_ut_check_driver(u32 index)
>   {
> -	enum amd_pstate_mode mode1, mode2;
> +	enum amd_pstate_mode mode1, mode2 = AMD_PSTATE_DISABLE;
>   	int ret;
>   
>   	for (mode1 = AMD_PSTATE_DISABLE; mode1 < AMD_PSTATE_MAX; mode1++) {

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

Much appreciated.  I needed to redo the PR for 6.12 and I added this as 
well.


