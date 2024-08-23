Return-Path: <linux-pm+bounces-12833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1846395D1E8
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 17:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17BA9B2CCA2
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C493189F2A;
	Fri, 23 Aug 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="faX9CQL0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1928189BB9;
	Fri, 23 Aug 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427775; cv=fail; b=T8FzG6J0XQr7oj1Qghu9cOe4CIzcoy8FO4ivSm3O8zyag4o5lctF5JqRxKO7mfMQmQBZc3E8Q0+ecHBzf3LoU5+NDl6ZzT+m8kbNCoxB835B6jvM85irq4il6cnoCCmK8hY5uieRtRlfeoV+A/JmR7wddwMJXEHBLf8vzSleuxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427775; c=relaxed/simple;
	bh=AfTZYXOFtej1a6NUF9iThNUN0NhNr0hhERdhZKM3kjo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dn3rpaMRkNgb2s1GfjGPQe+eBWF4ZsgMMxLSd0fv6b94omkQkdye/MKM+Fn9RVPty2A8a5d5htO12r8iz9kEWSwEk0XIKfKmsOdJVuRhui+g9PmS5nyjtUafn1uhJYEU46MrmUdN8JRLdcjyJTo33vIP0yLao357LHFBbX5djRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=faX9CQL0; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy3qJTjuphUt4tf91dih18Gq1x+aWb6d40/PTvNZyGndry5Hs8aPQR6lRSXC2GXO2/Xuar5mIhaw2Jr20nGlSJe9qsqVg5mA6c1ohvUvTjb8y/2qvWlcIUeWa3wQeSxd/MvAt5ZGEYEofVEhqpYoNZCrL3B0AaP1Alv6Yp5tyOyK3IOyzVXwlGI0eepAwHvDV/sguKeqPqQz9APYTS+4qkvpQfxzESg/6JSaBjexf5CzWzHhzBpaDyr3+Vx93wbVSmUiiML6muNQbWnFD6LuFNuf/z6rumvQ1DDStqVQg2Xgei2YYU1UXQg/3NNOVXaRbTBmEIP3aVMMdnojUMGDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYez7UwjYSe+koPZ9l170vwZktI/qGD/MkIc4Lq2RrM=;
 b=CJp5ahWYh0onreUUr9wg+OGZZf5JU1C58H7HKAEj2hf5MVdLZWbd2ZAWtVhU51LzsYvUfAxpWSTcr5tkKD56mLqu7VOcuQElu5uZOMs2YOsWOvX2iVaTDIiOIdlFANA025AByeOGX+BwWBgjYsg/5OrgK83P3VJ1q0PfDFRk0hCHntDm4KDv4aEbYOFZqd818G8u/cTGCKIK5ZKMQZ2MiMvAWyGRw3YLIDEiVrhjlHYZur68aVOlhO5Zm+7X/jFRuRji2wfuVRHAIubwPW744nPwh33E6mFGGrYC6dgoW/VI7ezRJArWB1X9Q4UembUBH+VMyD2MDGSsSWIXKegEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYez7UwjYSe+koPZ9l170vwZktI/qGD/MkIc4Lq2RrM=;
 b=faX9CQL0HPJx765WmIWusPmcA+y7Y35RmncsEZuGBj01XMs3x64RRqWlrrvfu7vZvKkF7PITMnEOvCbxoMUvbr4QU3J1j1JGqnc7EUxtVtV6dSIpxuZw1yb6Q9y8KUy0aiaub+ILzJOjsWYIZyEcnd3O5HyUMU6Cgvcmq1WuzG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 15:42:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Fri, 23 Aug 2024
 15:42:50 +0000
Message-ID: <62bd38f8-1265-48ec-8ab5-b7e5a259eac1@amd.com>
Date: Fri, 23 Aug 2024 10:42:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cpufreq/amd-pstate: A set of fixes
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, David Wang <00107082@163.com>
References: <20240813095115.2078-1-gautham.shenoy@amd.com>
 <e53159a9-3451-4255-8fa0-bb9aeee09fce@amd.com>
 <ZsgMXv3sQgcw3aNl@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZsgMXv3sQgcw3aNl@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0011.namprd05.prod.outlook.com
 (2603:10b6:803:40::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bbaab2-a1fe-436e-49ef-08dcc38a3ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkJXZEZvRzJPemxyNmVjNWF2dzBvSGtodHprMVpLdVVRUTN2bElKZkVjZWxL?=
 =?utf-8?B?clZGZU1qUnp4L2VyTGRiU1l0TVpMSEp0TnN3ZHZjUTc1TVlQN1ltdVB6Snhp?=
 =?utf-8?B?M0FKTG9wUC9pVFd3clU0b3A4L1VVaHBhVTR6eGNSWk5PUjNxTXRvVmxwbnRv?=
 =?utf-8?B?YTZHcWh2RXBRTnF5ZmVoUWg3OXFaaDlFUnUvUW92eGUrdEJZekxPamVWQzlV?=
 =?utf-8?B?TW0ySDhRYVlIWXZKeDB6d3pNODBPVm1XOTk5T3ZiSGhkKzZCMkpjY3A4N2ZE?=
 =?utf-8?B?aGFXT3cvenFET0pHTDcyc0xBd0NLZHZlWFZocmJEOWlpK2ZvT290RHVNNS9u?=
 =?utf-8?B?RmdadHNyZ0ZpZmtwRjBwM05NMXR3YVZtdHFiWEkwQ1Q2bFdqUWtXTmRNQ3NP?=
 =?utf-8?B?YlFkUEpjL09XTVprTFdqR1cvcy9nbG45QWJGYVFsaWd6cnR4NXVhS1RKUXM0?=
 =?utf-8?B?OUh3OWoxN1ZaY0hTRXdmbzdWM05Ob0RoVk03UnVIRklPbkMvdytxaUNiMUJE?=
 =?utf-8?B?VkNLZXBLOCtMaHFpRU5ZVytXQndhNGk3c0tSd2xzTEN2dG9ka0UxeWZWUHJH?=
 =?utf-8?B?d3V2NHFLM0wrcGEzaS8zZzVzK1VEc084V09GTUE3K2thWFJQb0RZNGc1ZFlW?=
 =?utf-8?B?dW1nMllySGowcXhtZUJqTFZXYUVsK0JHbVpVc1FkajhiNlRXY2JDU3VXZ2xU?=
 =?utf-8?B?UVRRV0dmMWIzeExxVXRQWXRFTXpMbk1xdDFDeGRiaFBJd1ZLVUpFNk1rT0lL?=
 =?utf-8?B?cHlreDNvYlZlTVg2blFRMERXYXBpRVViZXNQcWc5NGRzWldaWUsrTmRhWnZL?=
 =?utf-8?B?WEttN1lTVHZYUFZiazVBQVFCNnlWeTBUeWU4OUt3WWF4VXpMa21aLytkclJ5?=
 =?utf-8?B?b3dLRW95ZmRSbU9vYW91emJxZThHeCtwYThqckpGalFVSjdJeFE5blVCblBv?=
 =?utf-8?B?ZDhjMGVQQjdOa01JYk9KT2grZDZ5c1NOc1NlNVlPVUpPNC9ZbXZQRFlETWV0?=
 =?utf-8?B?RG92NjZMZm9SVFREN3pxWUkzNGFJOHpmWmlTTSsvWjZVRTMxWjJhcGRuR0ww?=
 =?utf-8?B?N2I3eW1zR2RXMnR1U256UWk3OTNDcXA1cVUyTDUrNmdpUHBCdHczdEZuSTVZ?=
 =?utf-8?B?SjBRaGhlUmdwbksvRjJvOElXVW1POWkxWkJGSGNtSGppWnB1SDhheXp6SXVi?=
 =?utf-8?B?ZEU2SVJvcU5GQkpqK0VOTVJ2b204SGdjTjZQcXBOUzJOQ1NtZTZQYlpMaE9l?=
 =?utf-8?B?UTVoN2E4UjJvWVFOUlV2ZGNzU1VHN3pib2RjSVk3QkZaVjFtelhnb0ZwNmkv?=
 =?utf-8?B?dzlKWENsd2xPU3ZWa0JhYndNeEg4anpTR0ltMWd4NnpINmExNnVzVlRQTDNS?=
 =?utf-8?B?ZnN6eDRiV2R5STNqS2tmZ1ZwRXpMVVd2cUNnUTRlbTdFVGd5YWJUeGJ1V3Nq?=
 =?utf-8?B?UWRSeFlrRUVYeEpDdG1IUndwQXZ5QzdrS05FWmVHcVdHYm9menlXYjJDQ1hp?=
 =?utf-8?B?ZnZIUm55WHErTkFDYit5RHkrNm5zODNSdHVFMnFvQXZnTURiUVpiNXJ0YWkv?=
 =?utf-8?B?UUNNa2R0WWZrYlFBOElJQURJeHorQld0ZEtER3lwQ1k1V3lIcE9YZ0Znc21T?=
 =?utf-8?B?MkhaZWg4T1Byb1VBR3N3K3QyeXNiMnZBcmkrcXdrMGw1cENTYU9jY3daUWtL?=
 =?utf-8?B?YlBXd2tkZ1RMbHdKQ21oZHMxbGlYeWU5NzRXNjZSSHNpdXlZNkhwbFppU1RC?=
 =?utf-8?Q?/QrZMpp7pwPR8cjXl9iIaOBQzOQogfVouFsBjnB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlBYTm05Mnp0Vy9DQ0xYeXROU1NNcFF0MDR5My9FdFhHa1NINUlNOUYvRndh?=
 =?utf-8?B?d3hPdzJkQk1SeTJaUzR6WXFsV1RVY3BBc3VJTllpWTBGbmlxTHhyRmFpVlpT?=
 =?utf-8?B?M0FxMEFyV2J5ZEhHOGNPQ0psQzFFMEhQQzVONFY1TUs5WEhRREJoZ1JnQUgy?=
 =?utf-8?B?ejRkWFQ3akNDeS9rRlFVaCs2cjMrTXIxSVlGT1VWeGxoaFVlVFNINVl6bEV2?=
 =?utf-8?B?d2RGSnBrRmE0K01ESlB5Zng1bEN1RXZjYUtOeExhbVg3L1plV2JJZFFzVGNU?=
 =?utf-8?B?RWRkSnVRRkM3NWJzaGFDai9rdjEzeEhCWUYzMnNUQitrYXZYdGU3bnZWZWww?=
 =?utf-8?B?Ump5bVZmYVk4cW9EeUpmbTB2ZEZzZ0lZemcrZkxMRVZwSER1b3prZGJuSU1D?=
 =?utf-8?B?MGdhUmNXMXpoeTNuaVR1MzRZWW5DaFZNbHBhcnNwcklwbU43blZ0bVpFbjZs?=
 =?utf-8?B?RVVhSXBtUkNnc0RzVExHTUlNWmRWMDdsd01EUkduSDJ2enNyL29tVWVTVUFO?=
 =?utf-8?B?YVJiU3UwWjFCTksxSXRPQVRrMmtkc0NFL0g1R0lndElmeVk5SlMwbktWMGRE?=
 =?utf-8?B?Um1ZZEViUTdxN2wzMlpQQSsvUDUzZDV3cTEwNURlUURzeGo5T2MvKzdqSEtq?=
 =?utf-8?B?WDQxQWlndDMvZ0czM1FtVFpuSC93M1dycExid2tzd3M4WjJpUVhrMk1zTTA1?=
 =?utf-8?B?TVAyV2FoV0ptbTRrNm85MnRTa2ZTell4OHdYRksvSWFVdnhYMmpLSzgrZ2xE?=
 =?utf-8?B?TVF6R2lvdUxLWHBuS0VlNXo0aEQvYXN6ekFlYUV0RUVBWEVxUXNiT2RTNyt0?=
 =?utf-8?B?R3BudmFvZmlkY2YrRGZUdEJoYnI3ejR3Yy9SbHpJM0lsMWpReDlqM1RkWFQw?=
 =?utf-8?B?bEJtbUdDWTl6UWxMSVByVmNrTEZOVlNzREkwOTg2SU1GTllBWDY3ZGxneWNr?=
 =?utf-8?B?RTlWakRJdHowaDJKdTV4MjVvVG9lemxYS0xzMHRHUkpuTlRzVmxIUGR1N2FQ?=
 =?utf-8?B?VThIc2RYQy9ZWE9Ed0p2ckY5UG4ybGpGUlB0Rnh3dHdvQkJvbCtaamJwWGFY?=
 =?utf-8?B?aWZFV3BYdllqWEZOaDBObmJMemtZUzdHUHF4QWlYZkVMa1JkMDZDenFaL0hC?=
 =?utf-8?B?alE0NW5IWlZ4SWdpZ1dVUDNvaytRZXp1c2g5TDJCM2Q4b3VnRjVuZWpyOXhu?=
 =?utf-8?B?VmZPOURQTktzOWdRSTRDWElhQnl3TlBJTGxmVmhoWE9CUDNpeUJsek43aXlO?=
 =?utf-8?B?SDRQZ2M0Lzhlbkt6QlpIRXViK3FoMGhJMmVCRmNRQktNNFlQR0VLb0k2TTU5?=
 =?utf-8?B?aGR1THNKeUlCVStRM2lDLzE3ZkFqZzM2V2ZYcnJUM1c4SW95TTIvbmxkSmc3?=
 =?utf-8?B?MXI1RmVTZDh6QWlqVWRqbktBZDZCMURhWUlxOHpWVDVLajNOYmVFekNEUW1l?=
 =?utf-8?B?TXZjTW01eWovQ0wwQVZpOEsxTDU3dmtxa0RRNjdTWVJmeEdsZE1ONkZEb2l0?=
 =?utf-8?B?MllDN1pTZUFXODdXQWhHOGRsaWlqUEJsek5JMTRCNkhhRTlQWDBCTkdzSGxE?=
 =?utf-8?B?NzVrVy9VQzV2azdDaEVVQTdrSzdIc2ZzakI2NWJZS3ViMVNNWmtBSCt1Y3I1?=
 =?utf-8?B?emFBWlkvTWtJZGFhZ3V3WHVvRjBPdWdUdkZsdU9TR2UxbGNDY0pTcUZ6K3Vy?=
 =?utf-8?B?VTJmRWQwakdoZjh2VEJvTmhKRmZGc2J3RjhQdUcvY1A4NnVlOHRWOElTblBS?=
 =?utf-8?B?WWZBSnNHVWg5QnJMdVZSNnJiNnFsVktxekhvSFpVR3pFZlVWZittZ1dwNTIx?=
 =?utf-8?B?N2d2QW9ia3BWT2VZOXJDUTFLeWlNZ0lOTGRpYzVXV3ZyL2VzeWJvaDQxNVVm?=
 =?utf-8?B?czRsNzloY2lBTmE1ME83T0F6Rlk1dzV6SFVGem9Cc3IyTHQvTjdubnZiMHlw?=
 =?utf-8?B?N3IrQlZod3poZ295RVJndnU0NHJRd0JkaTdrdWx4YVVkbllDVHorZTJuQmpy?=
 =?utf-8?B?V2RtMnM1N1RKcEFVZDNKUHV1aUNZTS90U2tBUWN3MGNVbGZiWkpqamVzQlps?=
 =?utf-8?B?KzlEVy9wNS9sQzE4M1RXQ0loUEtWNXZUczVPdGlCV0xCU2taVHRWcVNGTkQ3?=
 =?utf-8?Q?cBweqfwHq/ndXH9enYz5uBmvC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bbaab2-a1fe-436e-49ef-08dcc38a3ecd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 15:42:50.7422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmpbuYTWCXEZBTy9eJ/oVvjngBuiO7YXMojVQ/m8QpfJTDpuJ+ibwC9Wm8HHVxzLLz+NbpjW/R1GwBfb/BpI2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277

On 8/22/2024 23:13, Gautham R. Shenoy wrote:
> Hello Mario,
> 
> 
> On Thu, Aug 22, 2024 at 03:41:30PM -0500, Mario Limonciello wrote:
>> On 8/13/2024 04:51, Gautham R. Shenoy wrote:
>>> Hello Rafael, Viresh,
>>>
>>> This series contains three fixes for the amd-pstate driver for 6.11.
>>> Could you please include it in your tree?
>>>
>>> These patches are based on linux-pm/master with the top commit
>>> 7c626ce4bae1 ("Linux 6.11-rc3").
>>>
>>> There are three patches,
>>>
>>> 1. To fix an uninitialized variable in amd_pstate_cpu_boost_update()
>>>      from Dan Carpenter:
>>>      https://lore.kernel.org/lkml/7ff53543-6c04-48a0-8d99-7dc010b93b3a@stanley.mountain/
>>>
>>> 2. Use topology_logical_package_id() instead of
>>>      topology_logical_die_id() definition of the later function has
>>>      changed on some AMD processors since the inclusion of the CPUID
>>>      0x80000026 parser:
>>>      https://lore.kernel.org/lkml/20240801124509.3650-1-Dhananjay.Ugwekar@amd.com/
>>>
>>> 3. Remove a warning for the absence fo X86_FEATURE_CPPC on Zen1 and
>>>      Zen2 since they don't have the feature defined. This fixes the
>>>      regression reported by David Wang:
>>>      https://lore.kernel.org/lkml/20240730140111.4491-1-00107082@163.com/
> 
>>>
>>> Thanks and Regards
>>> gautham.
>>>
>>> Dan Carpenter (1):
>>>     cpufreq: amd-pstate: Fix uninitialized variable in
>>>       amd_pstate_cpu_boost_update()
>>>
>>> Gautham R. Shenoy (2):
>>>     cpufreq/amd-pstate: Use topology_logical_package_id() instead of
>>>       logical_die_id()
>>>     cpufreq/amd-pstate: Remove warning for X86_FEATURE_CPPC on Zen1 and
>>>       Zen2
>>>
>>>    drivers/cpufreq/amd-pstate.c | 10 ++++------
>>>    1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>
>> Thanks for handling these.  I'm back now, I'm digging through my inbox.
>> Assuming Rafael didn't already pull these I'll batch these into my
>> amd-pstate branch for the robots to bang on and then send a PR after I go
>> through everything else that happened.
> 
> Thank you Mario. I will be sending an updated version to Patch 3
> "Remove warning for X86_FEATURE_CPPC on Zen1 and Zen2" to incorporate
> feedback from Xiaojian.
> 
> Please merge the Patches 1 and 2 from this series.
> 

Thanks, they're staged with the other fixes that were on the list.
Will wait for your updated patch 3 for the fixes PR.


