Return-Path: <linux-pm+bounces-15826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD78B9A19BD
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 06:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2441C2246B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 04:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609C92B9A2;
	Thu, 17 Oct 2024 04:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lecpjqx0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98B841C72;
	Thu, 17 Oct 2024 04:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729139414; cv=fail; b=TGUpQAd85m+ZCs8xeuOZJi2pFUYRQeecK+QhUNZwgqL/Ifxj1cwmhQiFyQgvGOB0QdoM7EJJntcNDZL3irpl1gmewQwtibZAsSA/fG1nVs45c/uzYsi2HsyxVcGikptzKZ6fmepkFtEx4T+q9ScwAEQ21Xfm+HzS2R7VuSxJ1sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729139414; c=relaxed/simple;
	bh=1miV5q41lCoHG3eiLOVNg9uDQg3UI2nBJUhu/o9RvJM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mE90/abEeA01EuJZO98feO3tJxezF/BNA3RYm7DgI9sDySYqf/EdsAqgyQbAvmiR8RcIHAqLV9QyJVTa5YJl8za6IM0y7c89kARhNgU0IbyrG+Xui+c5Pf4AKjfzPs4i3qhEZffBc+IP+3jIlLfP9/E8Loq3QvMO7xE+W2mLG+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lecpjqx0; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPEyHm9LwGQ+F2YihnPQfTWurYkw6IFa787M3OclaIuhzFGH1HvvhvaWYEKvk1Ynnef6/oq8u6/GF/ZGIO3p0qY1PrRcgFxLhaR+iL3fIYzR9jko9Sb3xBvDtHn0SBFJgsbsHAHvPpq55xA2HxoNCp4NRHa2Wrtr1R3H9rUQPwQAMSFpNa9grclcuV8qlUmvAQtmN9Yo8izi6VcGfJoKIypKSMeHxLHPUFxAI+TO3c2RN2Fl/2ATaqdVO0IPFNTG3M8GhDhdC7ILTRoKXg//11qrNkSDm2frlvRS+btVZQLFcYC+JFDM+cGpO1krZmiCwS3UoiPyHq4edZq+pfswgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWScswtWSp3CFoLHAdfooZQs/XKE3ubFYaYaHeSxcHE=;
 b=gDLE8sbxIl7rTu4c+PCey+9npcy7w9NXBWHuV6sQb/9SjIyE9ICEdiwaHqDTrrq3uOic8XONWDC6iu1G2lC8dKY04gK5ZDNLHzmEibz7Cw7NzpcHNfxczeTHDT/HoX17DnRFM4srztD6PE9KSr5s9fbPap3LhZoljL/SHXyzGEgyRWXsmWf5FmSRcDI79kz+K5k4cyDF46CaPgMCzCKw8jTgKyMcrvfMX07D4wFlcgkcH/Te2G416ScIJCfCkhKRfWpkPsWW9RGfCO3lByNYZTEGxxvp//eTla1a5T/6NRTnzzFGbWvgkJ2uunmpm50be7w7NTVi3bmw3JToSKwM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWScswtWSp3CFoLHAdfooZQs/XKE3ubFYaYaHeSxcHE=;
 b=Lecpjqx0efbKk1zFPGpNVJeWDYoHV/W/XeYYHVtxjVSicOHEn3RvzZtjXkO1tqXBtH21FDaMvI0cjEwnxQu7OXQUEgyDooml7p3CHBzpeZyZff5blhvEeXHCCAJD0HkbCDQSgD5oW7/1B4BtdIBQM0GVg/X0UNV1JYEP+rlG3SQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 04:30:05 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 04:30:05 +0000
Message-ID: <667844b6-fa28-4648-90ba-8eed0c9a3491@amd.com>
Date: Thu, 17 Oct 2024 09:59:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Set the initial min_freq to
 lowest_nonlinear_freq
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241016144639.135610-1-Dhananjay.Ugwekar@amd.com>
 <20241016144639.135610-3-Dhananjay.Ugwekar@amd.com>
 <ZxCK50Qvo4mgC6CZ@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <ZxCK50Qvo4mgC6CZ@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0248.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d25c73f-8c86-435c-82d3-08dcee645fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFhsRUVTSUV0Z1ZURFRaT2dXNmRvUHhHL01COWcrMCtaMUZ5dWJ6djN2VUls?=
 =?utf-8?B?SDVSVi94Q1pmME5iYUc2UUhVTWxxTnQ4ZDZHVWllNjQyUDB6ZmlyU21EYTMz?=
 =?utf-8?B?dWhqNDZ4SHhRYkl2Q2luOUgzMkN6WkxOTkFERFlrdWY5VFd4Tm9MWnRRNE5O?=
 =?utf-8?B?U2Jvbk1pOUIwTFlHWkpUMk4veFFnUWtKYWIwcEt2T1lqR3c4SGRCMjNROEFu?=
 =?utf-8?B?bFRlQXoycHFZUVZJTWZaY2VmVVZwL0N4d2RCUjZrSHZMS2poK0l3YUdKQ3pl?=
 =?utf-8?B?R2dPbUVwbTIvdWpQa2RPWWp6cHBJUDdWeGVsTStCbitLM2orTEFEY0JqZG0z?=
 =?utf-8?B?YXZEQWtxNnRQc29mWFB1WWc5THJHTFNRcXV4V25KVE9sNlNPV2MyWEpncmZ4?=
 =?utf-8?B?UUNVaUFZY3MzVk9BeWQwemVCcnFGNlI5YmZJUms0dWQvRGJuRTJvWlBiOGdt?=
 =?utf-8?B?M0k1S3Q0U2IwZVFuekt0OFhEUFQ5MGZpbzVJSi8zWjNxVUlXWkQvMm9RemdI?=
 =?utf-8?B?Mmh6c2xsM3F5Q0ZxL0dlSnVSaGNZUWJoUy9YbGc5RCtXajBhQ0tmNUN3NW51?=
 =?utf-8?B?d29pM1RmK1FYcktTSlJWS2o0SGhkbUE2d1VaUmRzTlFCUTNWa0dNeWxtR2xp?=
 =?utf-8?B?QXlYV0hZNFpSM1d5M0N5M0pmeGw2M2Jqd2lselhrTHRCQXZvanJsUnVDVE9D?=
 =?utf-8?B?RVk0QmpuZGd6OXplbVBHSDlid0xYb2I0VGh2M1ZzelhzbEE0dGlMaFhPNU5t?=
 =?utf-8?B?a1NtUjZSbFRuSFA0a2xlK1M0UWd5WG9MT1B2cEZEY2pJVFYwSFdsRktIMHE5?=
 =?utf-8?B?LzEvN1NDL3FnQXRQYU1tMlM4N0NscXV0cktMOEw3WVFRaytDWDNHb3U3Wndo?=
 =?utf-8?B?bDMxU28yaXIybGNLR2dCd3ErNDRYOVkyZmNydEJaaFJ3bW9YYWxlKy9ZTXdB?=
 =?utf-8?B?SU0zOEFGUFZwRlVjb3EzdjhUeGlHYnFZVDNBNTU2d1FnWXY4ZlZzSStZR3cy?=
 =?utf-8?B?Q3VETktqTVFGVUxFVjRxbXNTYTBHUzREQ2xZZWp2QVRvTDFTc3NvZzA5OFUz?=
 =?utf-8?B?WklQWTFBLy9XcnVVaUpUTVdHK2tUTWJ5aDJYQ2hNT0x1TG5nNURPQU1aY01a?=
 =?utf-8?B?RHNyMENGTENTRmcwQzhVcUNyYUtuaGxCSzF4amh6ZkNab1JEcFVFdVp5ZFRR?=
 =?utf-8?B?Y3o2WjYzQ0tZMWdGaEZEWHJKbzdGSkYzUEdnKzIwN1k4ak4xUUF2Q2NubzZW?=
 =?utf-8?B?NW9wbW5SYU9DYzg4ZnhNRkJ2MnpLVitTNCs3ZnpIQU5VdlB2Q1JsN05tQmdY?=
 =?utf-8?B?VDJxdkZLaTJ6ZkhGZFA0MTN5eU5admFaQ05NZmdxMHppcWgwQ2lIbmhjSG95?=
 =?utf-8?B?N0tQSTZjZ09oOFpieFUwQzduRldPSUxweDNtR3pLbkhTQVRGWDl0UE9qTHox?=
 =?utf-8?B?RDJKRnI2cWtUekcrYzcyYXZQMjduL2lmVHM4aWI1Y1phUERwY1o5ZVlJNGxk?=
 =?utf-8?B?MHFTVlE5M0xCQnE2TEJMQW13cm9FOFowOEpLMnV5YWRUMURyS1Iwa2RiTHAy?=
 =?utf-8?B?Y3NlbnFrRXNWZmpFNVl3b0EwVXFnR3BYdXZkaDJMWm5jMmtpWkNhZXBJOTlJ?=
 =?utf-8?B?bkZhQmJVTHloeXJjSjRWVzZhZEMxMVhGU2duZkVxVHFsOGwvQi9qOWhsWnk3?=
 =?utf-8?B?d1NCby9UY2RwTWZ6Vm4rRkFCd1VpZ3h2S1ppdGFCNi9kRmxVZTE0b0xTWk90?=
 =?utf-8?Q?kt3yeGqamj7RNYzsceSyHVANeWX1qZUM2AWbyQz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmYxeFcrcUdrWDdsTnNBQWd2TEJINENGWDlHbmRKV1ZUd044TVVrbW5WdGZF?=
 =?utf-8?B?NkVPcS9pdS9abnR3czBUaWhlWWNRUTdTYnRMT1NjdktSZ1dRaWVHdzU4ekZC?=
 =?utf-8?B?ZDV3aWxHazEvTjNiS2hjekFDVGl4TEFTajU3d3ROcTBJbGhGRmMxSDFFMGxq?=
 =?utf-8?B?QVJGaXRVSURaUEc3Z05NVk5zcTZ6USt1d3lKaVU2NW16RkYrcHVoM1F2VDZS?=
 =?utf-8?B?ck9ZZzhIajQ2Ylp6SUZxUVpSN0lVWjd3RERpR2FCanhocjlHVVNvSEhJUXpY?=
 =?utf-8?B?eEtEbnB1R05kVnlEc1NJemZrRDRVUUI0S0I2NXJHMWlhUlhPWE5pRXpjQm5D?=
 =?utf-8?B?K0JVdkpLNE9MNC8zRERiL3dvQWp0WDExTWlpT3Q0VHRGUDZCNkRRMWtkSmdR?=
 =?utf-8?B?OXNLcVFxYWFTNzhDbjNFQk1VRDJFYitNbWpLSnB6NWlrK3lkODBXVEdxWkhx?=
 =?utf-8?B?ZVJTcVlnSC9ieWRMa1FoTTlEZHQ3dXFNNTduUDRJYlZFTzFSblh1TW1mMjVq?=
 =?utf-8?B?RUUvb1FPTWVOU0cvSzdyajJseSsxWkpUVFZBQWxqSlRmU1lsUnZYNjVsVVB3?=
 =?utf-8?B?QkNwdlFhWUpJam9xajRZQWUrWjFMQ0Y4TUgyZHpNYTBtajcwd01aNlFQaG1o?=
 =?utf-8?B?dVF5eHJJRTV4V3ppUWloMnFnTDVISVY5RWJWMG5XdGo3MXY3anJ6dXQxV25Q?=
 =?utf-8?B?N2dVdk1sYnFES1VIOE5sRHFjZ0N6cjNSQXF1amJnRFlLb082QW5iQWRGblBT?=
 =?utf-8?B?ODRERUFYc2RCblUzNSs0YkVaZWhVdFhFRTZMYnNFM0FBMkVIa0kxYzVPL2sv?=
 =?utf-8?B?Ly9OOFNqNTdBU2xwSzdIS1drb2hCYkt3dkhJc2EyOE5nejNxUHNpYkNhUVgw?=
 =?utf-8?B?YlNkMjhKUDRnUXc5UHhqM2NNb2twbVVBY3VVQTZtOHJreEVJN2VXRnd5UmN3?=
 =?utf-8?B?V3ZiRWdnbk1LY2tyYjN2R29JejF1TWR5b1pIbVlXa2k3UlAyaHMxbEp3YVkz?=
 =?utf-8?B?NGtQRnBKR2daWnJFbGVHbVdKYXRxay81WCt4OUxjZmU5dzBpOUR6VmFzdm8w?=
 =?utf-8?B?VHdhUmNka1NtSHVrSFdQVmcwSUFHSDMzdWpyclFpNVRzb0ZTSlVXc0lmR0RD?=
 =?utf-8?B?WXZHVXNYcmtjd3JjKzFBclJaZ2txVkxJU3d1SlF3NDhhbTkvQVIzRFhIQkJN?=
 =?utf-8?B?TXcvYmdWbUtoNXpuY2l6Ymd1NUVqeTVlZmtmME5FWlFkWDVZeGVxTHJWNkZv?=
 =?utf-8?B?SHdHTVAwNFRrZDh4VDZhM1U3eU4wbStxWExGTlpoUFRYOVV0R2g4WEVkU0N2?=
 =?utf-8?B?YVFVVlA2Wm5uS3ZTMTRrLzNPM0k1V3YvbjhneWtTOVJJSmM1T3IvQUl5K0RQ?=
 =?utf-8?B?dFN1akJnUWVKQTFKblhMbVJzRUhaMHU1Tjl5SE9IemNlNXdzWTVOQ3ZSaWJr?=
 =?utf-8?B?L3hJS0VKcWRoU3VRV0RJanY5bnpia2draUZQWGhPazhVbTQ3Uis1WkN5cUtp?=
 =?utf-8?B?a0ZyekRYYjdkNGI4OU1oMXpMbEIyRWQ5bkpQL0xlMmdNYUw5VjlUZzQvdEdW?=
 =?utf-8?B?MHB4Y29vRGVBZ1Q2TlljUXR2YUIvQ1o4a3RIU0pzbEhqWWR5UlkwWmFPcERl?=
 =?utf-8?B?MisvZW9xVlhaZVExVDJlRDFDc0VxSTBxMGdQZ2NLOHBlU1BzNEVxQitkdTVP?=
 =?utf-8?B?c3NhdC8vSlFTNUpuV3NZaVMxckhTZTNPaHRhZVFNUFZBYjJuOThVMzdBbFVl?=
 =?utf-8?B?NWEvdXk2d2NvT09xNVRYWjIvd1Y5bk4yNTBvdXYvZ0pMSGlrMkdCOUZ5TDgx?=
 =?utf-8?B?VlprODVTeHBrU010eVQvU3FMUWJVNWsrUWt1MlZFbURMV29RS05ZNDI1enhT?=
 =?utf-8?B?cmxqSkRyWVpLaUd5bzBndE9VOUZIVDVTMWJ0OTlQdDZPZWVsaWx6anNhYzk4?=
 =?utf-8?B?T3d6c2grWGUrZ1J3Q1k3ZFY3TkYwd2Z6MWw4ekxVcnhFN3hqdUdtSWxRRCsr?=
 =?utf-8?B?SlJvNmc4Y1FKYk1oalZDRjVWcURMWVE5MWkvd2xnN1FENzc2Njh2TERMR2Vv?=
 =?utf-8?B?QzFqNHBJVHEzUi9DdEF0bU91RVZYYkhEVk9ldE50TVlWdGlsajc0dGpzZ1Za?=
 =?utf-8?Q?QjWbN3mn58GRwvMZJcn4z5BaU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d25c73f-8c86-435c-82d3-08dcee645fd5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 04:30:05.4852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96vZlJdTWRndfwkhFX+uH0B/OwnNqzUnM2/PtCaGISo8gCGWlia9cYpYBqbmsNwyQ0beA0u9MkOC30BwfuKhQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359

Hello Gautham,

On 10/17/2024 9:26 AM, Gautham R. Shenoy wrote:
> Hello Dhananjay,
> 
> On Wed, Oct 16, 2024 at 02:46:42PM +0000, Dhananjay Ugwekar wrote:
>> According to the AMD architectural programmer's manual volume 2 [1], in
>> section "17.6.4.1 CPPC_CAPABILITY_1" lowest_nonlinear_perf is described
>> as "Reports the most energy efficient performance level (in terms of
>> performance per watt). Above this threshold, lower performance levels
>> generally result in increased energy efficiency. Reducing performance
>> below this threshold does not result in total energy savings for a given
>> computation, although it reduces instantaneous power consumption". So
>> lowest_nonlinear_perf is the most power efficient performance level, and
>> going below that would lead to a worse performance/watt.
>>
>> Also, setting the minimum frequency to lowest_nonlinear_freq (instead of
>> lowest_freq) allows the CPU to idle at a higher frequency which leads
>> to more time being spent in a deeper idle state (as trivial idle tasks
>> are completed sooner). This has shown a power benefit in some systems,
>> in other systems, power consumption has increased but so has the
>> throughput/watt.
>>
>> Modify the initial policy_data->min passed by cpufreq core to
>> lowest_nonlinear_freq, in the ->verify() callback. Also set the
>> qos_request cpudata->req[0] to FREQ_QOS_MIN_DEFAULT_VALUE (i.e. 0), 
>> so that it also gets overridden by the check in verify function.
>>
>> Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf [1]
>>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> ---
>>  drivers/cpufreq/amd-pstate.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index fa16d72d6058..117ad5988e8e 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -529,8 +529,20 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>>  
>>  static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>>  {
>> +	struct cpufreq_policy *policy = cpufreq_cpu_get(policy_data->cpu);
>> +	struct amd_cpudata *cpudata = policy->driver_data;
>> +
>> +	if (!policy)
>> +		return -EINVAL;
>> +
>> +	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE)
>> +		policy_data->min = cpudata->lowest_nonlinear_freq;
> 
> Why not unconditionally set policy->min to lowest_nonlinear_freq ?

That will lead to discarding all of the user's writes to scaling_min_freq and the lowest_nonlinear_freq 
will become the permanent policy->min value. Because, verify() is called in the scaling_min_freq write 
path as well. refresh_frequency_limits() --> cpufreq_set_policy() --> driver->verify().

> 
> 
>> +
>>  	cpufreq_verify_within_cpu_limits(policy_data);
>>  	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
>> +
>> +	cpufreq_cpu_put(policy);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -996,7 +1008,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>  		policy->fast_switch_possible = true;
>>  
>>  	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
>> -				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
>> +				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
> 
> 
> This qos request can still be set to cpuinfo.min_freq, no ? Especially
> if you unconditionally initialize policy->min to lowest_nonlinear_freq
> in amd_pstate_policy, no?

As we cant unconditionally init the policy->min above, this needs to be set accordingly for the 
above if condition to be true (i.e. FREQ_QOS_MIN_DEFAULT_VALUE).

Thanks,
Dhananjay

> 
> --
> Thanks and Regards
> gautham.

