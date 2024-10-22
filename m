Return-Path: <linux-pm+bounces-16226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C89AB116
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 16:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0CC284957
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32FB1A0BE1;
	Tue, 22 Oct 2024 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sSMIj2om"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965D199248;
	Tue, 22 Oct 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608167; cv=fail; b=kn5oU2JXbofe8VvzvDc1TxzXI1UChYv64xIkp91zzxAFXJEBgvkklUM54vFReFXJahvjlbRKBf7wPnOpBJ1wgeE279Jcm7tAFpbdyScWuak6IIL0fl2RyNywYUGOyqr5mBzCzllzM2xoAAr7DsUQqkTrfUIciaaerl4kpech7e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608167; c=relaxed/simple;
	bh=m6+RPh656CknA4BdJaTDlDDxr8ns7gy/C+byP4ESAwU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N1V408pi7DRz8fxJf1x3OV1WQ1MSln00TMg2vFGcGgK1i9Ltw2iJL68zpFthMFPRVyRslQF7yxLpyCVVtUJJ/YP7D6rFwlR+hw5u45ZIbbBmXJQxhSljpYwJA5uWQHXkzZYyMUpVe6L9S59dVz1gpuPROXlsfUi8e4vB5IwE/wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sSMIj2om; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKF0rwDhZY9xIlrFhYxZsYwVJgDcSXFHWPZwRdzA0iINXpXTMUN8DYSxKVFTmZrn5BaBg14DUCXKHr8S08qMyhzRKIhqhBjhQcS+GOUFqz9On88qujwc/JJV3L83yyOd6thxMpjO7rRSlr9griwYqfjx5iZm2vv0wMkMf0KACUmwFDu5CNTVOG2CuiqrWkkWa3cYbrNni3QUxlcOfYzRUFnbrGHJe+E4SV0Ht3zRMSowgQdph7r4JAFwJvyyBtLSVC1tvQG8goVzInD6crm/bMQpU/8lbfTsHluZBL9m41GvodbxUzczuZGHRBTva9s94r8rFx6XAQlfzUF04WLc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QDU9h5D04TRrV4UNtqtTLH2ObwXeFQFgSIbMz1nS2g=;
 b=L/bHmPkowdK49RfNl65FNVVGqhpwhMwdVaJisOmvEOlUZqw0JBW6jWYPCgqnTyyBFZmXDUAOqj/0ByMWeW9wY6tMQs0vzn1cky6CCldgVsj2/mTEIbuonwbuuqj34tT0qs04sfzWdtnDmop6PCWW3/N0TKE1ufl2FcIUKgmy1H8SXYaU6rAuADNYPmPtLBC83H/7eK7BjPXBwm3JNrrEgYud6aDN6Aaknr5CJiXiMoF8f/ppkk3i6ShetXoUPLFKDdpR6YrtY8Aa44tDNuoUM0PMRY1QuVGs9CuEdgnLu/U78LWGj8BNuSK1B+W4/PMae38/dQJixWfZCgyRJPSUmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QDU9h5D04TRrV4UNtqtTLH2ObwXeFQFgSIbMz1nS2g=;
 b=sSMIj2omkivCADLsGnNZKxt9YNf6uR9Xv0WpyBWrpbpL93vj6w3SpGugsP7JlkSsb8s4NF04dhWw4nqkWcnG005Dy9u4dMHUzUIRfSPpx9ZdUzTIHGceVG+HmN1vS3AHEexNbHmEGOQ+jhP87qJXn+LEyhpEysZnp61aK9bNqIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 14:42:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 14:42:40 +0000
Message-ID: <c54a76d9-414d-45c2-9bb6-4250a31cdd5f@amd.com>
Date: Tue, 22 Oct 2024 09:42:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, daniel.sneddon@linux.intel.com, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Brice Goglin <brice.goglin@gmail.com>, Perry Yuan <Perry.Yuan@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
 <20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com>
 <1a96323d-f6e9-4a59-97c4-8cab149a7b31@amd.com>
 <20241018211139.wvvfn7az3gp35lwe@desk>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241018211139.wvvfn7az3gp35lwe@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0104.namprd12.prod.outlook.com
 (2603:10b6:802:21::39) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5f768e-145a-4e4b-1059-08dcf2a7c7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2FxQ25uM2xXR1dQRDVCcC9vRUFpbUhTSzFHaEl1cy9SV01QbmpOL3NvM2d2?=
 =?utf-8?B?MnpORFpldVdxMVNkUE1RUXVpckhGR3MxYW1pd080Q2JCd01CQlYrT05NUDVM?=
 =?utf-8?B?Ujl4MmJtVHBjK1dDN1lYRkN0YnRzZ25RajQ1U1JTbW13V25WQjkvZllhUnNk?=
 =?utf-8?B?YXlRMW9aWVZCREgvdzIwakFpYWFRejhpbXhLai9ra09nMk54YmtqNDAwZHZQ?=
 =?utf-8?B?bHlzWE5uak1tU2J3MVcvZC8rQk56T3dPZGQyNm1NcU94aW55akJPcHQzREtr?=
 =?utf-8?B?ekc2N2JocENucU85SFpFOUVFcHprZFJIZzlQTkdJSGhvMkVLb0hheUYxNEMz?=
 =?utf-8?B?WExyNGx0TjJTclUrbHVoOHJ2cmNYWXNYWjBtK21LNUw4WVRmME1OKzZGVVAr?=
 =?utf-8?B?V2h2bXQ2d1ZCTmlXYUdoaVVFai9DK243a1MyVUwzeFRxVm52WE4wQldMcXF4?=
 =?utf-8?B?MFk5R2Vzd1Y4UnZieHZoOGFJclJpNERMNC9rdFB0Y3NLeFd6OVlFbm9QdDhO?=
 =?utf-8?B?WVNhekxJMEE5QlJFZWh1YUdobVlJUCtMUjlDT2NGUUgyNUVIMS9aU3M1S0FG?=
 =?utf-8?B?WmdjYzV4Z2RqTS9aQzZsOHBXNHJDcXhlaXIxOW5yY2UzeFRqQlZ0QkF5S1pX?=
 =?utf-8?B?QTFsbWtxQUI4c1Z1MnBWUVpGTFcwT1VqUXdBb0F6S3pXL3o0TURWRnpxWTJw?=
 =?utf-8?B?YWpHRmZ5ODZCQUk1bWhKbW45eU85d3poSW4wci9iYUtiUkJ1Wmp6b1didktY?=
 =?utf-8?B?T3BITW9vcWVmU3cyeFBpbTNHSjZYQTVlQWcyaVh0dytTMmlHcVpzVDBNY0RO?=
 =?utf-8?B?alU4WWlzMkJ2Q1hpelpnRmJ1Y1AyWGgyU3dLV0lkYjBSWTYrOTN0bVlWMWJu?=
 =?utf-8?B?Q25FTVJCSGpHa2puZnB5VmVOR1Z1TmZkTmt1aGpDS2NPWDdIdFd3bmxCcW15?=
 =?utf-8?B?b08xVGtMVDdwZlBhZWZOdVMxZHZJRlVxY1JhVFVROVBFYk9Yd01JYTlhUXlF?=
 =?utf-8?B?Q2tCTDlJSGVxT3JQbiswYi9PSDc5Zy9IY1JNb21WUGdRU0E2MlpObHQxYnhm?=
 =?utf-8?B?SEhxQjk5TVJLVHR3dk43N3NVQndMZ3FmcFFyaUY5QmRRWUs0VHFQZDVvR1JV?=
 =?utf-8?B?bE5FSVhPRWRBR3RjNG5pZjY0WXR5N0Eza0hkVUYvcUlUbW91dWN4cExoTXYy?=
 =?utf-8?B?WHNEQi9FSEZpMDl6cnZxUmVlbDV3Ym9BdjFqOHhPTHBWUmU0L2tyWnJuMEdC?=
 =?utf-8?B?akhXRlI1b2tnYTJ3NjlmZFdQdXU5WlNTNmV6eTkvMmlXcHl4aEFSblBLRTQr?=
 =?utf-8?B?TDNCeFplak9GZ0FLcTVlTWNmMnJaVkxkNTRwejFxSU83bVJRSmV4NnFZQWJG?=
 =?utf-8?B?b0xIcDZOeGszcmdXb1R4ZXczM2J1Kyt0WVBnNmJ5ZEhJanFRZVp4L3ROYWFn?=
 =?utf-8?B?amNYMUpjZ2lYNXd1WndsZHg4UXQyenk4M09JZDNKNndXdDVyS0hSKzVLQlBO?=
 =?utf-8?B?Z3YxOVZFYUluYW45VGFxTzdWZjJUNVRUeE94TGpwZ3QzSjB0U0Q3bHdxTC83?=
 =?utf-8?B?TWhjYURtbk5rMmZkVTRrYTlCa2Q1UlFpdUNpLzk1M2d5dzY2UDBSbWlPWlNY?=
 =?utf-8?B?UFB4WnlLcTltVlEyQXZXNUZYMjBmRXJwMWwxOUhQcWhEYUpaQ09iemxLdXRL?=
 =?utf-8?B?ZzFVQTl0MVdTSlVBYUM4OFRQV28wSlJvWnVFWGJsTCt0RWJXWTlOZXhDWTFt?=
 =?utf-8?Q?CzNK6MD8HLIy7bRlzRdV5b3lPyH7se4z5pkuibo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkpxUnRwTm5WOW9SMFdWUWlpY2FZVEFXdzJTZTBmWDRFYjNabStSNFhCV3NX?=
 =?utf-8?B?cmgwalFpLzd2d1FMaHpUQzkxSmNOaW9ESHhObVowNHZScktwVkMyZHJCbWgv?=
 =?utf-8?B?YUYydFhWT1hoc2N2UjBkc3EyclM2MlRZb2JweCtyVUxNR1hvM2srZVB1VWdM?=
 =?utf-8?B?cVVtcTJOL3Q4b3RJaVVIN1hsenpuWlhNek54U0JFK0ZNYnI1aWd5T0RRUkdm?=
 =?utf-8?B?U252bVRZWWRvbCtkNWVwNUtYRzVJdTFHVEQ0S05kYjdqakpVQXlhVDFDWldx?=
 =?utf-8?B?aEdzM29pRlpnV1F4MzVqZ1Q0TFluM3JxdUVkMTZnb0FUYmZqWWNrWU1BYU51?=
 =?utf-8?B?T1VwWllMcVdnbERjUWNVMmJ4NXFodFhZSFJVdmhGTTllSks1cHU0TkhRbUV5?=
 =?utf-8?B?S2IwN2NTQjlhc0x5dW1Na3JvcHp3eC9Ra1NnRTFrc3hqQnFPOWdnUHpxajdJ?=
 =?utf-8?B?Z1ZJTFowS29RY084MEF3UHcyV2FEd2o3c3dVb0FnWkVlUGhNeG9jK2dZSWVK?=
 =?utf-8?B?T096YktNVzR6TEhaYmhDc09jVk9mdWM4eXd6d1VWNnViZ004L0RGUzJtc2dW?=
 =?utf-8?B?RXNiWnNuWjVpN2xYN2VDeUVjNzVqNkRDY3ZpWXdZVy96ZXZYTUs0RmF0OW8z?=
 =?utf-8?B?UnlFcGtPL3ZDS0plR2RLTTVPd0FiRUdmbzBrVVVFbU9lWGorZXVnYzBkb0po?=
 =?utf-8?B?TW55aVJSUWhuTTVNaVZ5V2k1dXRWeVZ6VjNYQ3BuU0xMVjV1WEtjREVldFdp?=
 =?utf-8?B?ejhyWTIxYm9ZRnNscHQ2eEE0QXJPZlVWTUxUaGtQbTJMZk1MbkhNMGk3ZmQx?=
 =?utf-8?B?K2VMWVo4SGNHSnZCSWcvcDBKcWc5TVV1dnZqTkJKOW0yN2x4Y3A2M1k1dURu?=
 =?utf-8?B?S29wV3g0enZzK0V3TEtqTjkxaVZmR3VRQ3V1c2hoQnVITllSZ1U3ck1EVUJ6?=
 =?utf-8?B?YWk4cjBjVkFkRFNVWTFrbGpoU2lQYXBRZU9Ib0Vyb29GSmZBZG1sM0QxK05p?=
 =?utf-8?B?b1pNbXpDUkNYWHIrcWFZRnhabjBlckwrYXB2ckk3ZjE1MW5nbmM3VFVMeUEy?=
 =?utf-8?B?YWpQS3dKTXRNU3FXZmcremtEOHpFNjl2QkVOVTFON3J4OEM5Zm90RUVRaGlF?=
 =?utf-8?B?eEorUmM0TEdrWTA1Z2c0VHd1Y0M4ZGpKSVVvUjNLZTlqa04wM2tyb0J1ekpD?=
 =?utf-8?B?M1NSS0w3M2YybnNIZS9TZy9GdFQyVktSUElJalA2Uy9ucWVlUndmTERabi9T?=
 =?utf-8?B?U2lrYW9NbER3N25xYkxlaGNWKzY1Q1VPMmlBclk3TkR5NXN2NWZ0MGg3Vk1o?=
 =?utf-8?B?RVVEb3UxcHd6YTJnYmVGSWxRcHVXRTlTdEpSTmRSNXYxbER6UU5LeDc3TktN?=
 =?utf-8?B?TFoxM1JVVmt5b1Y5NktlNWorVlVoTDRDM1dYRWVmMzFuNGZ5a2cxZVlSR1gx?=
 =?utf-8?B?K0ZzMC9Rb3d6RjY0MmJ6MXBuSHlINlJYUTVTcllGZDZSdWxreE1vN1Irb291?=
 =?utf-8?B?dllLdnEzRzFLN2tOMlJ2UElQbTM3TVpVRk1yK2lwVjhubnVxNlF2VlpxNER6?=
 =?utf-8?B?dG10eWlPNEkwZk9jdzA5bndmL2ZhQVUyVTQrdUV5aHhZeURTY0JZeDBaR3BG?=
 =?utf-8?B?SFBrS3IxNzVLajlhZ3B6cmMvMkNUZVpsNnpUeWgvOXFnMFlybGI0S3YwZFEv?=
 =?utf-8?B?dTlCdTloWWVNVmQ2dXMzRGNqRjBPNWJSSXEwWDJIb25RQVdRNi9KN3pCM3lp?=
 =?utf-8?B?ZVBQbVRvMFRnN0VNM3FFeTdqN1oyWkMrdnZHMnBqL2RvalFyU3pFMklxa2hm?=
 =?utf-8?B?aTlNRTN4S09VQnhRZjMyNmpZY0tnSmtwTDJyT2dWYnlFd1VIT1lOeUh2OGRi?=
 =?utf-8?B?bVo0UjllYVZSaGFiTVBBcEp0OGlENlVzaFRpWjdtRS9xNUxJMVZTeUNMRDVn?=
 =?utf-8?B?NjZBWFd6UDloN3F5ODRjc2hDMjBhb0dlSEU1bWdUUXhCQnA2YjhhTXVDNlht?=
 =?utf-8?B?aG5sSUcwNmxlRWZ2dzQrRXBKQ1p4Vk8rSXV6ZXN5azlUVzI1bkJmNk4rM3lu?=
 =?utf-8?B?QlI2em5ocFJJeUxYSXMzVnlibnV5VXB5Y2xENFNqS0xnT1owNllXQnVhZ2Z6?=
 =?utf-8?Q?h4RMtJfuK0c8EnHXbEEGN4eOU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5f768e-145a-4e4b-1059-08dcf2a7c7bf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:42:40.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btDmZ544yYu5BTvFbH/dAgeYZrDE/6t0m8u6CYlpvpCgedKbTZ7BC7n459qSOn7K1eFHIU5rEJTr2KHosjIPVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458

On 10/18/2024 16:11, Pawan Gupta wrote:
> On Fri, Oct 18, 2024 at 11:28:31AM -0500, Mario Limonciello wrote:
>> On 9/30/2024 09:47, Pawan Gupta wrote:
>>> Sometimes it is required to take actions based on if a CPU is a performance
>>> or efficiency core. As an example, intel_pstate driver uses the Intel
>>> core-type to determine CPU scaling. Also, some CPU vulnerabilities only
>>> affect a specific CPU type, like RFDS only affects Intel Atom. Hybrid
>>> systems that have variants P+E, P-only(Core) and E-only(Atom), it is not
>>> straightforward to identify which variant is affected by a type specific
>>> vulnerability.
>>>
>>> Such processors do have CPUID field that can uniquely identify them. Like,
>>> P+E, P-only and E-only enumerates CPUID.1A.CORE_TYPE identification, while
>>> P+E additionally enumerates CPUID.7.HYBRID. Based on this information, it
>>> is possible for boot CPU to identify if a system has mixed CPU types.
>>>
>>> Add a new field hw_cpu_type to struct cpuinfo_topology that stores the
>>> hardware specific CPU type. This saves the overhead of IPIs to get the CPU
>>> type of a different CPU. CPU type is populated early in the boot process,
>>> before vulnerabilities are enumerated.
>>>
>>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>>> ---
>>>    arch/x86/include/asm/cpu.h            |  6 ++++++
>>>    arch/x86/include/asm/processor.h      | 11 +++++++++++
>>>    arch/x86/include/asm/topology.h       |  8 ++++++++
>>>    arch/x86/kernel/cpu/debugfs.c         |  1 +
>>>    arch/x86/kernel/cpu/intel.c           |  5 +++++
>>>    arch/x86/kernel/cpu/topology_common.c | 11 +++++++++++
>>>    6 files changed, 42 insertions(+)
>>>
>>> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
>>> index aa30fd8cad7f..2244dd86066a 100644
>>> --- a/arch/x86/include/asm/cpu.h
>>> +++ b/arch/x86/include/asm/cpu.h
>>> @@ -32,6 +32,7 @@ extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
>>>    extern bool handle_guest_split_lock(unsigned long ip);
>>>    extern void handle_bus_lock(struct pt_regs *regs);
>>>    u8 get_this_hybrid_cpu_type(void);
>>> +u32 intel_native_model_id(struct cpuinfo_x86 *c);
>>>    #else
>>>    static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
>>>    static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>>> @@ -50,6 +51,11 @@ static inline u8 get_this_hybrid_cpu_type(void)
>>>    {
>>>    	return 0;
>>>    }
>>> +
>>> +static u32 intel_native_model_id(struct cpuinfo_x86 *c)
>>> +{
>>> +	return 0;
>>> +}
>>>    #endif
>>>    #ifdef CONFIG_IA32_FEAT_CTL
>>>    void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
>>> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
>>> index 4a686f0e5dbf..61c8336bc99b 100644
>>> --- a/arch/x86/include/asm/processor.h
>>> +++ b/arch/x86/include/asm/processor.h
>>> @@ -105,6 +105,17 @@ struct cpuinfo_topology {
>>>    	// Cache level topology IDs
>>>    	u32			llc_id;
>>>    	u32			l2c_id;
>>> +
>>> +	// Hardware defined CPU-type
>>> +	union {
>>> +		u32		hw_cpu_type;
>>> +		struct {
>>> +			/* CPUID.1A.EAX[23-0] */
>>> +			u32	intel_core_native_model_id:24;
>>> +			/* CPUID.1A.EAX[31-24] */
>>> +			u32	intel_core_type:8;
>>> +		};
>>> +	};
>>>    };
>>>    struct cpuinfo_x86 {
>>> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
>>> index aef70336d624..faf7cb7f7d7e 100644
>>> --- a/arch/x86/include/asm/topology.h
>>> +++ b/arch/x86/include/asm/topology.h
>>> @@ -114,6 +114,12 @@ enum x86_topology_domains {
>>>    	TOPO_MAX_DOMAIN,
>>>    };
>>> +enum x86_topology_hw_cpu_type {
>>> +	TOPO_HW_CPU_TYPE_UNKNOWN	= 0,
>>> +	TOPO_HW_CPU_TYPE_INTEL_ATOM	= 0x20,
>>> +	TOPO_HW_CPU_TYPE_INTEL_CORE	= 0x40,
>>> +};
>>
>> This isn't exactly generic.  Unless you have a strong need to know "Atom"
> 
> The goal was not to have generic cpu_type here, but the actual CPU type
> that hardware enumerates. I was asked to prepend "hw_" to cpu_type to make
> is clear that this is hardware defined, and to leave scope for generic
> cpu_type, if we add those in future.
> 
>> instead of "Efficient" or "Core" instead of "Performance" I think it would
>> be better to do this as:
>>
>> enum x86_topology_hw_core_type {
>> 	TOPO_HW_CORE_TYPE_UNKNOWN	= 0,
>> 	TOPO_HW_CORE_TYPE_PERFORMANT,
>> 	TOPO_HW_CORE_TYPE_EFFICIENT,
>> };
>>
>> Then you can do the mapping of 0x20 = Efficient and 0x40 = performant in the
>> Intel topology lookup function.
> 
> I can add a lookup function, but I wanted to understand the use case of
> generic cpu_type. If we always have to lookup and map the cpu_type, then
> why not have the actual cpu_type in the first place?
> 
> One case where generic cpu_type can be useful is when we expose them to
> userspace, which I think is inevitable. Overall I am fine with adding generic
> cpu type. It may also make sense to have separate accessors for generic and
> and hardware defined cpu_type, and the generic ones when we actually have a
> use case. Thoughts?
> 
>> After you land the series we can do something similar to move AMD code
>> around and map it out to the right generic mapping.

I took your patch and made the modifications that I thought made sense 
for a generic type while adding the matching AMD code and sent it out 
(you're on CC).  Can you take a look and see what you think?  Boris 
already provided some feedback that I'm going to spin it again.
I think if we can align on that one we can land that patch and you can 
rebase the rest of the series on it.

