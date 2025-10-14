Return-Path: <linux-pm+bounces-36103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A06A5BDB90D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 00:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 922614E53CF
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 22:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1CD3064BC;
	Tue, 14 Oct 2025 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ml9BgZir"
X-Original-To: linux-pm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8BD2EA173;
	Tue, 14 Oct 2025 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479568; cv=fail; b=DASea5WxJ/1u+FB6ZVak/wp+7fSXh55XaHu8bmiAzZ0RbR76cy6dTjMVc3cFiCM66dcLSMwVFWtWU4MxISjHi4pwmGIDJioJN6rTiGhP5Hp4swM9u5E+QT3Ll1DFe+Niym8LrjgD+sEEsFuze7PHDSRThkmQvOU8oByYD3OpRGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479568; c=relaxed/simple;
	bh=/otWnmc6e63Lp4zUweIwjAbVMw7Y/J4lcqzHVXZkzJQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XDPeR2H0244iBwBvPvzNjqoDBCt7YE9gWyseP11xyAqKRaBpA+AFadZupCMOwNO/K9jMu10ved3C8qGWQjN1ULeleS+T1WbxeSypQ69usz5gHiZWr3KgMJGcso/xeMnqiFYjyUS4YBQCqHFUfW4G8PvxRzEtRQScQdOOCoF/WLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ml9BgZir; arc=fail smtp.client-ip=52.101.48.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcjG7nTSFMF9LFCAv6Doscv6inR+62qnEnwNyW/sHZ8IIq8ETUF2yCjzQ05+/tg2Icg6KEWHy/AqQ2d9zigp3WFhA7QELQ+RyhaiEG3fC+WwtvtS4snAD7i2smGncp7R8/B3uT4VQHMKlGQXItTJy/WI9HPHg/ySECEC+hrPlaKFUenDa9R4V+EwW0tnDlMQMH3pSq8kUfGLmc4PEZRXQLRsnQeq3OJDGuF0Z9j9wSRFy0Z4FJVV77+UKajxMM1yXJojRgExkmIx0Nmf37dI1uqvOIM9B2HmjBxeW7aQ3ZVR4DWHjaF9F+A7LxFpiyGQrQnDyV7iNnuk9hTeGQTLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7/uCB6tTmbvwy6ZzcjN8e0sSWvW9RbQQYIVjmji55Q=;
 b=uV4MUC+e0UXJAFcONZkA2d/PLlt9fWGAYAaAegiAvA7IoRX331BvJPsX++cRnZrsOZXAlOLWnt1Wzv5E/7Zwp/g9+Ahhx8BQSBCVpxxdaR9fgM3NT79bS53HY2RrWLHf/4q9qVWpBD8T5kbS1Bw112UO5Hodz6Gwb2sniMBpLoA+v5btkluDA6ZVCuB2zCTS48Dz5ozLCXunQixtXMduEs580eM0/aOFjqGCCLDpcYow240J8kyrl1kgYEn4AtaNd80eIemiCEH0J6RorkSmJ02wxTbigSN6/fRpRAKjyM2MDp/epTVk4j45D31cocVpSRzP4MH+7xC0QpRmyuYBNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7/uCB6tTmbvwy6ZzcjN8e0sSWvW9RbQQYIVjmji55Q=;
 b=ml9BgZirY1ytQaP5iM4Qu95ARzXRrpd6FhaHwwff7UmfgiMuGPWIuTrLWRW14C3e1LBVkxraza3U0APfFihjiVCkdY0mA63hU4NQwO7J8YkEK3qHghCIFVHZcbl2kxGWdq7MaM+aWPechREywFCFTKutC5TQpOAnwwIudNxWprlkYXaYZDjl5dzrhHFR8apvBu1m83cVuoYDGk2UEuBfyJZKbPZwr5kf2DY+juwFi3nZ3W6ARc6AEsSDK+5p8qCBg8BUqkZ6qqbvQSLpg69Lh8xzo5qlVaypQ1AApRtADfEdNAwYCMpPfGocaIe0Svz+2Jd9LAIW/UHEDh5LI9IhrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB8333.namprd12.prod.outlook.com (2603:10b6:208:3fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 22:05:59 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 22:05:59 +0000
Message-ID: <e2346583-0c70-44a1-b0a1-ed41b1175835@nvidia.com>
Date: Tue, 14 Oct 2025 18:05:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/17] preempt: Track NMI nesting to separate per-CPU
 counter
To: Peter Zijlstra <peterz@infradead.org>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-2-lyude@redhat.com>
 <20251014104839.GN4067720@noisy.programming.kicks-ass.net>
 <4a237ec0-05ae-439b-a1cb-6b7f451c0d7e@nvidia.com>
 <20251014194349.GC1206438@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251014194349.GC1206438@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:408:e8::28) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 4457b672-6dda-48f0-e891-08de0b6ddb39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qi9FUkNaaW1WWmVxR2JDV25QamVDWUljS0YrWFZtMnlGaVphSkQ2SlJJQUYw?=
 =?utf-8?B?Mjdhcko2azNhWTl2YVNKbjVrdWloVzRsQmptYURuOUI3NVpRekZtNUtjc0dQ?=
 =?utf-8?B?STQxQWw3d3A0ckRRWXU1ZXY2Wk5MejNSVFQ0Yk55eG9saUVkZHFkaFBsMUZ1?=
 =?utf-8?B?RUlMRGdSM2txOUlXUHljb1VUWFFUc0JzU2wwWVdscjhvbkZpZVR4NUJ2aU9o?=
 =?utf-8?B?bmozR1Z2RDFDR1E1TXJ6NE5SZnh2ZjVlYkRFVjFzM21MaDF3bTNueXdJYXA5?=
 =?utf-8?B?M05YbUFuVGZlRmpuT1MreEdlK2o3Tml6WVJNRitsdGlwTkkrUDVFMndUZUNl?=
 =?utf-8?B?cDZxR3kwbnZqUFBGRmVjR0U0SlJUWUhneWFUWEE5Mkl6aVNFTExZMWxDRzJ6?=
 =?utf-8?B?d25UYkxnQ3dTSGlMdU83ZGJaU3ZKZ2loRG82OVRPYUMzNHZsK3hsamdaYzVp?=
 =?utf-8?B?WE03Wi9BQldvL3MxdS9vZllsZC9BZzB4M0E2SHpDOWpoMDd2YnJiWFRLSTFH?=
 =?utf-8?B?bWxpNlozeCtVenRtTnJOUW4rMkpVNkRZanRDQjdhSEFIeGlNMUludUxuY1k1?=
 =?utf-8?B?Mk9kRjhqaWxRZVZlbGN3aVhWck5RbXJzNzFoZlA2ZWUvb2ovWUIwTlY4d2Vn?=
 =?utf-8?B?Sm9pTlY0WDl2ekRBdDAwME9WcCtBUWlCRnBhTUFpcll6NTN5V1RRRUR2R1lr?=
 =?utf-8?B?YmxQbzFSOWRPZTVFZEJGaGNxOTVtRW5OM0ZBNGNCYy9rTk9qWXpCU2pXYXd2?=
 =?utf-8?B?aGpiS015VFBjSlpPWllJNEgvMjZ3azRKcFp2cDJQOGUvbTkyVkVQZ2hjc004?=
 =?utf-8?B?QnJmdldocjV1blZtdUcwSXVRQk9mUVVhL2VaMFRtOXl0RnhtL1RNSUo3QUVx?=
 =?utf-8?B?U0pSWFBPQlJYcUNnS0ttYVlaK2ZQSXZ4YkpzanNKZXhFRlNESG81dHF5NlIv?=
 =?utf-8?B?WS8ySjhQZlk3RUdIOWFESndGejhhMWNQZ3U2ZnZSbHNOdHZ4RzdVdVdzT3Bq?=
 =?utf-8?B?cnNZd28yOU1jeWxOa0I0bGlPa0M4alVpRE1Jejl5QkxtMklLemx3dkh6Ni9V?=
 =?utf-8?B?elhKQUZocG1OdlBTcFJoY2VmVzZPN0tUSXhmRW4xanpuTzJYZzl1SyszQUxi?=
 =?utf-8?B?VUR2UXhQV2kvdWhDazl4MEhMMHpLTVpUaDZHZ2Q4QVlqM0NqbWpLUTJxSy92?=
 =?utf-8?B?eXhvSG9jSXRrdks5K0QxUXE4Q0EybG5uTzVFSEFOZ3MrYjUrQ0pYRm5RVjNn?=
 =?utf-8?B?OUQ1Y09Rb1lqYk1WTm5SZWVaSEdyV1ozNVEyQjlFRXMremtQbWk3dlMwSXd6?=
 =?utf-8?B?aG8wRmduMWtnRG5nVUt2N0J6NkpVbFVRYXcvUGhabmVtUmhNQWM0ekl4TlhF?=
 =?utf-8?B?TlIvempINTd2VzJybkw2Q3MzZC9PNlVxUEVKOWlneHNKMC90MldrZVREVWVP?=
 =?utf-8?B?U2t6QUVIT0FEVjJsSjdoNW1EbVFtdERFbCtVVklWV00vYmNPWm5wWGRqTU1U?=
 =?utf-8?B?SzRxQWZTbDVCZG9uOWtaMHYyMWtkVm5QcGRtMklDNUdWUHI2ZTh5UFF4ajJV?=
 =?utf-8?B?a2lXL0p3WUJ6RzNaQXArVDd6WjdKS0IxZWRRK1ByWk84LzFoeDVJNU94b1pO?=
 =?utf-8?B?a0IvbWJ2K1h1aUt4TzR0R1NCamFoZjJnNldoTm5mR0EzUWxhUUZRaHdKcG9y?=
 =?utf-8?B?ZG9rRHlxQTFtUFJyQTZBbGpUNGNyNkdMaExxL2EyTnd6TGRJanowUm1EZGhE?=
 =?utf-8?B?UDNnZlJrUm1qTE1KOVhzSjV4VlYvY1NWNnZnVnpERFoydkdvemxaSmhqTkFy?=
 =?utf-8?B?SVdpeEw3VnhLMlRMdDRPSmlmMHdwTzc0bHlUdXNpeTh2N1E1TXArOGN1cEd0?=
 =?utf-8?B?Q0s3QktSZ3RONHV3WjRTNlNiT1E5RHk0U2dHSFpQMG83TU1WWDlMZlpxbjkv?=
 =?utf-8?Q?rHyHUVqavkNdGI5abZPUHGmfTrGWWqei?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEdvcFhNb1dyY2VYYlRkRytiUkNoczB1dldRSXU2UU9IanFQckxuNHNvRms2?=
 =?utf-8?B?d3FIMW9HTldZcXRUd0hoSHdzNXREWXVsYjR0dSsrWGtibTNINTVPcm5uRUw5?=
 =?utf-8?B?SVN2VjMya3U3TTVvM2k3V2dDODdLSC9hcWhtbHgxcnl4ekNRRVd0Slg1VVFv?=
 =?utf-8?B?Nks3Y21DSWRFSUQzU3BVMk1JcGEySjNDcy8vendCVUxleDBma1pwcnM5REZ3?=
 =?utf-8?B?RFU2M3huLzk4YUxrVjFQOTI2NFMyUDk1aTNJYUpWVW9uN1I3MXBQWldPUVU0?=
 =?utf-8?B?bXJqS1AveGpRWXUwMGJEeEhPaitxLzVXNkIzNUhDSVhweGdtb0diWkVuVDc3?=
 =?utf-8?B?d2NLMDhTNXo1SDRIMEdybkRUeUlFeE1OeUNMTUhRUHdNMWRBWlI3NFltdWJV?=
 =?utf-8?B?NjU0QjhiREw5VFVKRkIrdmlDNlMzaDU2SWszYmMra1RHWFZFUE5OaVd3ODlI?=
 =?utf-8?B?YzNzRDlnUkh6V3lUWTFYbmR2SmZXK0lZMTVSQUljdzVMVlBkZHpzckpLZWY5?=
 =?utf-8?B?dER2UGFQUndqSnBWcEg5VXdSRUt1TXlMKzQvSURqaExGN2pNbjdQQzdVL1hL?=
 =?utf-8?B?MWlYOVN5VHlkbEV2aTFUMlRmbldTM1NsTzhnT2xFUmt0V05QancxYXBWVUx1?=
 =?utf-8?B?U3U2M0VqdTVRQzB3Mk5pSzhNVW55VUM1Wno0OWoxYzZvQ0lvNWRTRWViUngz?=
 =?utf-8?B?TkxlRXdhaEVUQWozWm9BczFKeTQ5MUwxMEZMM0tCSUJtL2NKZCtOSVBMZUNH?=
 =?utf-8?B?cW1ERisrc29rOFdLZnZOdEQvQUhDamYrWEw5bFlScGRFU2xHQS9OTXc0NFNk?=
 =?utf-8?B?YnMzTVpRMm8zWXRiT0lvWWZRaEptc0ZUbW1WNE5DQTd6Mm9BZVNnbkkyQi9E?=
 =?utf-8?B?d3AwUjYzOUtsaDNabTVtdE5NMGJDMVI0UFpON1c5Z2M3ZkR2akJFdTJuK1Zs?=
 =?utf-8?B?aVVEaG13MXF0WlM4OUNaUFNJcE5aRXVaVm9KOThaa20vOVhCeUZxY2xiR3VN?=
 =?utf-8?B?Z3ZJbUNrazVPKzdUNWZNMFRZSVdGK2xEcmZsclZxeUozVktUK21WSGZCT0RW?=
 =?utf-8?B?UGRCTDJINk1JVFNWL0taWWVvM0RQL043T0Z1NUlYQ2lKaVRwdFB6ZW5DV3Y2?=
 =?utf-8?B?NEVlckNlMWhiazBJUDVFMUIwQjhjOUg5Zzd5UjExUm8yMVJpdmt4ZjNxVGtM?=
 =?utf-8?B?S3lpM2FKR2VYeFRkVDVzeGpBaHA1T1hScER3WHZFSmF6YlAxTFdQSG9zME1w?=
 =?utf-8?B?ZWpJeVFZQWV5U3VFbE1QWTVkUENwTHlqZTRPMXpsR1ZiUmtYYVFCKzNMK2dB?=
 =?utf-8?B?TnFLR1BCRUVaM0h2RzFwYmFLZVYvd0ZNQWNUWEh2bmllSDdoYnRNcVcwbkl2?=
 =?utf-8?B?Szhzb2t0NmpRMThuUTQ1V0NmS3UwR2pSVlQ3VEFRZDBSRkxmS2JOdkM1cWlJ?=
 =?utf-8?B?WE9pbGNQZ21GY3E3d0pGZXpTVjJXQzNWK25UVENqbFBkOHY3QlpsN21tTXUv?=
 =?utf-8?B?TlIrS1owKzE5VDhwbUFiUXE1UXJGL0FnSWlwNFlhZXo4cjlvakdhNmc2S1ZW?=
 =?utf-8?B?alN2enFkWi9XazhibXo1RENWbndGL2kvbWlXYUtGTUhnQTNWOEM0akZuQ3hW?=
 =?utf-8?B?VnpSWkMyTlNjai9oR1dZWlU2QlFyU3dmU2ZGbjR2YWIzdHp3a0ZDLzVtVkpk?=
 =?utf-8?B?LzVNc3VLQ1dtSndMdXJqemF0Z3dYUHc0eU93NVFjVmsvRkdDMGR6ZUUrbEQ2?=
 =?utf-8?B?ckJBRWhMbUdReEtQZDhxbFpjWkUzZVJEMDlwS05OaiswakVSMDhEYzc4d2I3?=
 =?utf-8?B?QlloNFZUYlQyTGRZMWRSbXdTL0Y3U2tkRmorbE56Q3EzYXJSRGVSeWJteFhi?=
 =?utf-8?B?Ry95UHpZTjdRbnA5N1htR2t1T2s2T1F0US9jNzZ6ZEdZQzZZVnpBcDNvSjgv?=
 =?utf-8?B?eU8rWmJyUVQwKzRTNzhKNDI5RVFsbDZzR0k2ODlLa3dXcE5iQlFJNGNlMHU5?=
 =?utf-8?B?ZDFEQnF4TElXMURDUUNYYXZaODRESkp6ZE1ZM2VJUEJJZFo5VjY3WENnMmJP?=
 =?utf-8?B?V0lMMnZZWWdZbmU5UWV0bkFnKy9OaHdraDY2cnZkcm5QRHRjY2NoNVBld3hX?=
 =?utf-8?Q?ZASGsV9UerX/b7PS3BqHn3TY1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4457b672-6dda-48f0-e891-08de0b6ddb39
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 22:05:59.1902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7OPXtyfxKrmXGj7qG7e7wbj+kTlaJIUFzMRYtKXtoFp/CqWxH8DrIwQUMO04as2Tgbb+f1KF+1nlB4kFUsGZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8333



On 10/14/2025 3:43 PM, Peter Zijlstra wrote:
> On Tue, Oct 14, 2025 at 01:55:47PM -0400, Joel Fernandes wrote:
>>
>>
>> On 10/14/2025 6:48 AM, Peter Zijlstra wrote:
>>> On Mon, Oct 13, 2025 at 11:48:03AM -0400, Lyude Paul wrote:
>>>
>>>>  #define __nmi_enter()						\
>>>>  	do {							\
>>>>  		lockdep_off();					\
>>>>  		arch_nmi_enter();				\
>>>> -		BUG_ON(in_nmi() == NMI_MASK);			\
>>>> -		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
>>>> +		BUG_ON(__this_cpu_read(nmi_nesting) == UINT_MAX);	\
>>>> +		__this_cpu_inc(nmi_nesting);			\
>>>
>>> An NMI that nests from here..
>>>
>>>> +		__preempt_count_add(HARDIRQ_OFFSET);		\
>>>> +		if (__this_cpu_read(nmi_nesting) == 1)		\
>>>
>>> .. until here, will see nmi_nesting > 1 and not set NMI_OFFSET.
>>
>> This is true, I can cure it by setting NMI_OFFSET unconditionally when
>> nmi_nesting >= 1. Then the outer most NMI will then reset it. I think that will
>> work. Do you see any other issue with doing so?
> 
> unconditionally set NMI_FFSET, regardless of nmi_nesting
> and only clear on exit when nmi_nesting == 0.
> 
> Notably, when you use u64 __preempt_count, you can limit this to 32bit
> only. The NMI nesting can happen in the single instruction window
> between ADD and ADC. But on 64bit you don't have that gap and so don't
> need to fix it.

Awesome, I will give this a try, thanks a lot Peter!!

 - Joel


