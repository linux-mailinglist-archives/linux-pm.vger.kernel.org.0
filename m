Return-Path: <linux-pm+bounces-38949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40186C95B32
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 05:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C75E341CBB
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 04:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B161DF271;
	Mon,  1 Dec 2025 04:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZQ5M9qOx"
X-Original-To: linux-pm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5AD134AB;
	Mon,  1 Dec 2025 04:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764563809; cv=fail; b=F1nHCYbq/g2ZiKw1evyjWdwiz36DDbezOLLlFGtPQKjpaBAsg2Z8ZbEQhrse4s8w7aVyXXjq7mQDgPdCPa4QqeMSj9bXBVlmtp1HdTaMmmqSFukgfD/SSm2/dldyuXm6Nz6E5Sw46MemVpu4L+5aBRtybGbjfJnYZMitxkfNXls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764563809; c=relaxed/simple;
	bh=vqMn55mBVtUt9bL2NatrESANtVVQHgkL/Df6o2gMZrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=meJYrjW39TvZXoAh62Cv48zu6ndfje58WCqzG4uoYXR2lzoheZ5HHMl3pNpqgFQRVYgAV9Bw5n8KuRFM+dQ22fgfqPgN9plAzKQFWhtye7aOixXU3L4eKyoPRTqGttyArr7hYzXtMmZrX3mN740Yxw+Rcz1DW1IQPVOp/VwXYjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZQ5M9qOx; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHfwZb10PIDCzJ16p1HIuF4ectl1HT9vEVisybrDeaspLd88GyOEscvztWWg5TDayg2yUTj+QEZuQ1QxCph2wcLU5eOnF9AguNKGjZF5tKQUXPiXZ6vS7mTJV5v+U11z25wVpf+sBTAPSCFzDDo+g/x1gZL6nX9l8fbKhvxIXfREe02NWSXuXtarrjYD5wsklFChXxrotYmSgFWJ1hqt2QTCiao5HzRTVq4xH5X3mrXJdmcPHcOWkqNMkuE9HBWq4rsUnRXJdD4/cXRkjk0Te4AH7yIPg0XTdTtrfVAq8CdvJxFiYZbd/ZrKrYoO/WWrGMEA3UsWTfwplpGNSCogjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClV+xiAN0tHcj8gS+cydeNjORHapHU3noPPFW2yyqz0=;
 b=QABL3lYabyqtzF750QL6X3BwdjBpa+bjYaUdG6AiHetgSDAiMvmAE6KiwhWO4Cvxcj+SKxWlwtZV/ATn9nrgU9wdTWBtKINhl7CMFEd9M66vrybm592pjVNrBtu9dv+Ikc6AC21eGxjPt3xiPRRkKNUu35JhmbVS74O1hYBrTQ2si+iNDFUNSi0qfgPRB8w7sH0tdpRMywFJJQKOu4naJrcppJeKG9ur7SsjfdcWlhtuYnYVIALgI5iH86eugLV+JglSdM7b7+F9u4HLn2mYFpWUtYsrLhH6v11Z2wy52dEDHuQk1FO/lPMWaT3fj3u8PF/att7f3JDe6Vv/d6Y3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClV+xiAN0tHcj8gS+cydeNjORHapHU3noPPFW2yyqz0=;
 b=ZQ5M9qOxfkytst8JNe1gL1gFXRbAdnSPdIn2spqhZbRqVfpD9vD7gkTsUALfXOagTPpM0I9EC1dLEJHqChJVc88DwptznsjyNnBBglmVdsg81UAFtle9Iay3IVqE8OOAyedRo6+8E+EXI6X8Kbp/hqVqdO8f+UXvKkX1HfWykG0pV4dQa71wT/BPSYd4XQDrDXcdKaDfzTCoa3X8TS07mL0mDvzxp5NgfROEeeyf2oQzG0WwL+phWnmjB+DpqSTd/7AjwS+3/RD1OI3I977iXtjzGwU8oI3QSWOBWLLXUV89fU7bSc6U2cM818siN4LcDWMlJ5wbDkl+XVebqajBuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CH1PPFDB1826343.namprd12.prod.outlook.com (2603:10b6:61f:fc00::628) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 04:36:45 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 04:36:45 +0000
Message-ID: <ea455598-fc0e-4768-b540-5091f7ccd025@nvidia.com>
Date: Sun, 30 Nov 2025 20:36:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] rust: build_assert: add instructions for use with
 function arguments
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com>
 <db6a6b28-c0be-4bd8-a0b4-70431df7737a@nvidia.com>
 <CANiq72nGUuK9VTYJGob7pnXU5zuuCzqfw6fezAFpbqvte1sDFg@mail.gmail.com>
 <46b5eef7-2e8d-4801-93d0-6cea10f62dc9@nvidia.com>
 <CANiq72mhXajwj7HjiW_HQq9nO4o-HwBFUya3wjT8pRkWx3xjZw@mail.gmail.com>
 <7d157605-4c59-4e04-8c41-1f7a4c86b34c@nvidia.com>
 <CANiq72n0UkuAtW=2JZK9Y7TK4VO8rKsMSvpv52BsW5+C2z9Dew@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CANiq72n0UkuAtW=2JZK9Y7TK4VO8rKsMSvpv52BsW5+C2z9Dew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::25) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CH1PPFDB1826343:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a250dd-e415-4eae-bc55-08de30933b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cCtKMG9peitiTjYvOGUzSGhpNUdPRktULytuSWp3cCsrV3BzaG9KZHlJVXBt?=
 =?utf-8?B?eTlTV1ZLazNZZlRpU2FQUjBBNkZwcWpXVTI0TVFPL3A5VGJJRFU1UVczZWRJ?=
 =?utf-8?B?VjB0a29JR3NRYTJxNW1WaUZ4R1Q0Ymt5cnd0L2dGUG80T0xDblMybmk2czFr?=
 =?utf-8?B?SVJqYlJVZTR6d3RJRkFjWHNwM3lUUW45eEdZVk5CazV5UlkrN2dSQUg1ZDBZ?=
 =?utf-8?B?clc0citsYWRWK005WW1aRC9xdUttTTFWWGoxQ0w1VkxhakNjNlpBcnhHQ3p1?=
 =?utf-8?B?NmJxRlBIcndLZWJxbVJiVHFzcGZIQWFncU9jZGpGY3NEOXJvRzFGT3hzVDdB?=
 =?utf-8?B?R1pPZmlJRXNLb2JOSGY1amcrL05WZGlhSUlhc3lrbzVyK2tuNmlSUURxWXBG?=
 =?utf-8?B?NWNhRlhsTkduNXZSZVZ4RUI2Y0JjYk8rak8wcEY5ZG5DZ0FZN1pLdDN5ZW9t?=
 =?utf-8?B?Z01lS3RtTjllLzRzT3VjelFKREJXRkZWVnhGREQyYmxvTHhoZGpMR2pTK2lj?=
 =?utf-8?B?eXo2ejkvZHkrN2RtL2d6MnVYdlRWTHM3NUdlMkgyeHZKZXk2bUdzSmZ6bXlw?=
 =?utf-8?B?djhMaU80S2p6TDc2MFFwUHlXd1ZvRWVyWE4vSW9NZGQ3eStkNlVrVlRudlMw?=
 =?utf-8?B?dFZ3WVdYTmxod2hQMXByQ1BGcTRYU1g2ZXBTd1puMHhkUTZ0T0JreTBWZFI5?=
 =?utf-8?B?ODRheXoyR1hkVUtvdkhEK1BuMTdNOGk1WDNwUDdGUkRFV3RjMWJ3cFFYeVN0?=
 =?utf-8?B?dHV1MzQ4Zks1NGw0V1Brc011WHdCZFM1QWNqQWx1bi8ya0tMV01taFExTU45?=
 =?utf-8?B?cDk0WTNwK1p5dFNvYkVCaGJYUitURkhGK3YxOVpWZ0phbGtFeXk0SnpvQS9L?=
 =?utf-8?B?VVk2dFZwZExtY3RFbUNzdVg1MzdMa2lIUUZJMW91dXJWajBzcnRsKzgxWUdD?=
 =?utf-8?B?anl3bXVFWmpyb0FQZlltNzBLRzdUWTVjWVhWb1liTWZWcW41WkVpOUxHRGk4?=
 =?utf-8?B?bGR2S2R6UExRSk5WRmkyQkIybkw2RzM4c2RXMEZocGRKUlF0cERTdWEwZE9p?=
 =?utf-8?B?T1NKZHFOckp6OVlEWmtkc3BsV2p5aGlpYWJzVVJTUFAwaGZqOU5ZMnNEcExj?=
 =?utf-8?B?Y0tlUytqWXcvTTJZSHRkTk9BTDdLVVVLckt6YjdVdTZTdHo4ZVczSUpsdWFu?=
 =?utf-8?B?b0hYdDhvYnBoT0NzRjJEYjg5ZU1sWGJQdE1PM2pLY0Jjdm5lQ3BacTZZS3pK?=
 =?utf-8?B?YWdKSzJCSjZHdEZNZUxBSElGOE9yaTlnTThFakl0NkhMN2FmT3dWV2FrcjlP?=
 =?utf-8?B?SGN6SnR0eENHVzBNQmZGWDRpc1Q3M3owbEl1aTNNWFRIeHBLUmFVRU9OM0dU?=
 =?utf-8?B?MC9ocEZLeGJudm9VbFo2YytXSUJlSnlxOHN5c2tmVWxnU3Jvdi9yZUlDYWJF?=
 =?utf-8?B?RTFJbHdpMTQzQ05HTEF6ajNDUjI5MEJJR3pnWWdtMjZxM3V0emRISXZuRW96?=
 =?utf-8?B?S1pDTnluR1FhdTlhbnRRVWgxdVZ6cDFWbWFZTm5tQzg0bFd1eHRYS1hYVFBX?=
 =?utf-8?B?bzNiYmV1T2Y5VXE1RDVmeng3dG55UWZEVFhXcVZMWWhOcE9QUzZ6NHpZSUxZ?=
 =?utf-8?B?c3p6dU9jeXcxMWppdGY2RG9EaXhlSXgzNyt0c3p2RUdmYnA3U21NdmxtK0ZH?=
 =?utf-8?B?VHRYYlpNeGZrNG1VSnNMdXhocG5rYnY4V0xIM01OTC9EeHlzNnAwaW1jenRp?=
 =?utf-8?B?UWRDQmJGbEdsOGpiR1c4VDJzNmJRbzh2N1BwQWk4cHMvckJuaFcxWHNaMjR1?=
 =?utf-8?B?aWl0cUZYM3ZLdFlzK0JycWxxR2ROQkZwU3dNL3FldXY1Zk12NTdvTUlLUG00?=
 =?utf-8?B?L1dJVE9LVW1WVUdGc2Y0TCtEQjR0ajdWbDNvWldYeDVsaENHWmNORUx5UGs3?=
 =?utf-8?Q?mvFVAcJ29bWqk36n5MryPA+H9Iekvgtr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ympucm52WjFoakoyRVVRVVV5QWVmdXJvVDBGWkU1SlQvNTB3RmgxZkp6N016?=
 =?utf-8?B?V2hqbDAwbWpRaVl1TmVseUtzdEdJOXZzS1F0ZjhycHJpeStXYWFPQkZlMVdh?=
 =?utf-8?B?MWdTMlFkMkVSVXJkQUlDSnJBbURoUzIzdHFDeVQ4S1JJOUJDRFVjVmJxRnJK?=
 =?utf-8?B?dnU4UUVveFJDTldoVlUyYkdZbytsVWs2TEg5VFluQ1plRDk2YlJ6NnVkb3Bt?=
 =?utf-8?B?ZXYvSlV5OUM1YklFa09kMEIyclVTVUpTK1lqdVo2ZVNWYUZnT3BoUUplZW9z?=
 =?utf-8?B?Vmx4cEFPYkxoa04yWkpjcldWenRyaWhrajE3UHdBVDFEWm81ZXVvQmVNRldG?=
 =?utf-8?B?NEZvaXlOYm4xcVdwUi9BV0d4M0Rrc2ZVQ0RFdlpCVzZQKzdsaXo3dE4zeWtw?=
 =?utf-8?B?cTVhUVQvR3lVcm5EbkZmNWhuaHMxUkdXWlVUNWU1cTIzSWlMY3hDaGdsUE1B?=
 =?utf-8?B?OXVYN3NrOXN2Vi9MRGlBN20vc3kxeFkrUmZVMytsYlRHV0h0Wk05azNpYUE4?=
 =?utf-8?B?Q0lYQVo2WldSSEp1ajBnUlZrcWhzeDdsUXgxdzlCOFJNdmFuVjRXQ0czcW0w?=
 =?utf-8?B?WWw2N3JLZWR0bUVBelJHVUY2bi9mOXc5YnltV2p3Z2U5VjdsU2dHcnZCVTBK?=
 =?utf-8?B?VzhmaVROMlJaWC9XYWpnNSswMS8wNnB5cFpoMWltdXE4MVQyVm5MY2djTXAw?=
 =?utf-8?B?UlZ4d2NuOEs1aEkzQnluOGMzUVc1dDFhTGJwZ05uN21nU0lNaGNSL25oKzNJ?=
 =?utf-8?B?ZVVPZWVHbjdIeTRCeFAzSXhCcnhycGljYlBJNjE1alkwUW15MHZzOTRUblI1?=
 =?utf-8?B?clNweU1Bd3d5c0lxdFdENmZwOWRPQmZhMll1WW1nUXNRWHZkSGYwUVFkNFN6?=
 =?utf-8?B?YXUyQzE4ZGNCRWQxdEhuNGcxYkJ1NFhLWWpnVGNUbFRoYjVLem82Umk1NlhI?=
 =?utf-8?B?NEt0cjNuRGw5eFRad1VRRXZOeEt1RzF2MmM5OGlnT2JrN3FzdU9kNU5jb01I?=
 =?utf-8?B?Y055UFV1bms5ODh2OVdQa3NZZDJQRW15Vi81Rjk2UHhnK3hPbUJjRysvL0pQ?=
 =?utf-8?B?WWNqeUYrVFptWjRlNjBqbUg2MW9EM1Z3ZmVoMVZYTzJyang1UmZaanpRYzZr?=
 =?utf-8?B?cTRlL2xMZWpKY3JBcW9qU2wrcWtXR3ZGOE9JZThhaFlTODc0L1hmdHpBOEhU?=
 =?utf-8?B?YjBoTjRkNk9YL1Fibi85NmRvOWFQTGd4cnVyQnh6c3B3SHl5eUltTTlTcXJP?=
 =?utf-8?B?MWVGc05sSG5vKy85TjdUNzVYcTMya3FlVklqOTVjNGYxakkyblNzeGJDTGN1?=
 =?utf-8?B?VmxHa016M2k5TXU0NW5WU01Ed25oZFdoSVBMUTdFL25NV1o2d0lZcnZkS3Uw?=
 =?utf-8?B?WXNsV2xiK2xuZkZTckh3L015a3grN0Z5WGl4K1UrZUN0SnNFTXJvRXMrR3JT?=
 =?utf-8?B?R1N5bW85aFczUHFRQlNRaVlKeDZ4MWgyekN2aXAxK04xN0tYNi9IYlBwdks0?=
 =?utf-8?B?Q3pFUEQrMEUrMDlnaFRDMHFzSENOR1BKenhISTc1d3dJeThybUtOSUdHWHpI?=
 =?utf-8?B?VnRRd09QaVc2RDhCR3NISXE3NkNqY1lEVitvVTg1ZnVIbG1ad0NhRkxlUUdv?=
 =?utf-8?B?V0pRNFNoVG1EalNuY2d0WDA0aEllTlNuQ1RHZWxMTDR0Rkl3SXZqZmIrQ3hq?=
 =?utf-8?B?SG90cXZOaXZjbzFFWHJ1alFGRkxmai8za1MrTWNIZ00zQ2MydVdmKzVVZVpJ?=
 =?utf-8?B?Tk5UekNOWVJrWmE4NDFkOFVienpsSVpDWm1NVWtOVDdmZ2NlMHdGVWx1N0hh?=
 =?utf-8?B?Ry92MVBXSzIzQ3Z4TmRrQXBGV0dvY0xOS2o2RFhVS2NOWkVUSkZrL2Zxb1Q0?=
 =?utf-8?B?eHVFeWd1c2hzQkwvMzVMRFpuMlBEZ3ZsRDhxWmZjQ1pHNnRIa2F2b3lvdEhn?=
 =?utf-8?B?NiszTGtIQ0w0eTlVUFFJTlcxNXZBMWE1cGMrZ3ZIQ2RTclgzVFhGZkRqeGR4?=
 =?utf-8?B?Q2YyZU85SWRJeXJDT0xRbGpZdDZGM1dDSURWb1MxYmNrMWV6TzNmak5Wa1dT?=
 =?utf-8?B?dWlsOVp5MGxRRDNpY2dPZVNoN1dmOE1qQ3ZidzVjR2lsMmVVb0srMnR1K3Jk?=
 =?utf-8?B?U05QMHphRlZqQ0dSK1dMdUNmWm1XNFI2Y0w2dkdZSXRlTkt5T2c1b3hwL0sx?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a250dd-e415-4eae-bc55-08de30933b70
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 04:36:45.0511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onq+5YKEpuVnl6JtAVA2zoThmhNuddFetR5eordSHj/l/29DVVN/zkMH3khsE8RINAcEiALZb6TiAqhAqUFGVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDB1826343

On 11/30/25 7:44 PM, Miguel Ojeda wrote:
> On Mon, Dec 1, 2025 at 1:52 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> More precisely, it was already *hinted* to be inline.
> 
> By inline I mean it is marked `#[inline]`, which may or may not get
> inlined, but it also has other implications, e.g. codegen can get
> delayed even if there are no callers and is concrete.
> 
>> Then that is conceptually wrong, because it must be a runtime check.
> 
> No, it is not true it must be a runtime check -- it depends: you can
> use such a function in some cases just fine.
> 
> That is the point of `build_assert!`, after all.

This seems strange: something called build_assert!() should not be
put in places where it might not be possible to verify at build-time.
It's built right into the name.

> 
>> Sorry for the fussy detailed questioning here. I'm trying to bottom
>> out here because CLIPPY=1 is a very solid requirement before posting
>> patches.
> 
> No worries, but I don't follow what you mean here. `CLIPPY=1` is still
> required to be clean etc.
> 

CLIPPY=1 is effectively part of the developers' tool chain. It is also
one of the ways to break the build_assert!() call sites.

So now we have to go around and annotate the functions that *contain*
uses of build_assert!(). Otherwise we end up with an unreliable tool
chain for developers. This is not where we should want to be, in the
long run.

Is there proc macro magic we can come up with? Or rustc or clippy
changes? So that this is becomes a better foundation upon which to
build?

thanks,
-- 
John Hubbard


