Return-Path: <linux-pm+bounces-39324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE63CAE91E
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 01:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4C41303D9EE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 00:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238ED247DE1;
	Tue,  9 Dec 2025 00:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CzB/58F6"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA021B9C1;
	Tue,  9 Dec 2025 00:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765241695; cv=fail; b=SJeDeMlxMOHmfD8W7SVHQnr8whjGJDCaH5jQq/C8do4NcYD5e7jZ4I4g6Aqv1jVaXbc41XELtECH7xwFhGb09Qv+aa7rT4E4Vjg2uiPrCQhVQYqvGyLGNAG4YQYtPeXCbi3YUJJ0BqDbUaDx2nOa5wxzytIrQMwmrgcDGS9CEXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765241695; c=relaxed/simple;
	bh=O0WsGiw4lrxEgJTi3lIqGZxfF+h+Bf/4yzZmXRgAga4=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=HTaFM9kH2FfrSPm+tTxgGCnaUnfIi0IBNkJDz09ETSM1k+zg/gLe5mg8kdpgAt5zT85FnGyBTpvVDnvQWbL0DI2nKKi38wZLaNhh1ec2IxqCEHieKuESwKq4DJ95OI/STFUOy2bok+uAxAM8E6BSHbUi9aHzXBNvn8zk0tPTOhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CzB/58F6; arc=fail smtp.client-ip=40.93.194.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCjuf74TpjRUJ7/rQaiR+bUXmladC5rVHca1EwxgJZzgoPatO7WhtbTj5sNXzF7lI44s2dhrc0nIU2Xl7JliOlVMBoOd6uA0oveRxoTzZL9SRV8GaudZtI5TJOXa5yZkGoUalo+jZuavgx+0tSCzXWMWVmFjF+dlo9Aopufv9kQ9G5jRrK5cgF3dP0UpVdtUj0IT1MbVAPgh4OMRbYRxU/fGBkRVxnc7pVwly2pDy7yVZk6j/ZH+09vbdUWwSQOuYMR9JaZjUpApAwA9uFsZ4Mmju5cxRF/ExRGmOEl8i6pyfdaywo/yfqIxiQ+CTh3eWohDQnK8WIhhlglGpKv/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAFSN55nNa9lZnRHbxqXF8HeBZeHaMGALM3fWxMTGzo=;
 b=gxgLmVimKiWp1DPiSVMC6b8f4IMXaWP+8BpZG6oV2WrZh1AGdP+6R+HV/zGrd/lPcEJEugURELKcQvicmseFKp0MS+v1OK10RrxntGgQJhqYQbQhi2WyrX/IKGyE+XG6BuwjCpD/2198Ou1Yx6cVS5nrZTIDOJfhxyd8cFVzolu6oNnIpxthj2nCU1XG+N9/GhoxYlJlItWtZu6ta01yt4ra4TvhDVI9e1A/GUMIPk76dkUM1Dm+3xSFeTJ4D/urwiltcCyfvGs2l/uMPNS69fnjAImhB9cnMoPyMZM+oW0O1Q/f1mOA0by6pfQmUOhnwX1krIZn352qFxm8kZMXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAFSN55nNa9lZnRHbxqXF8HeBZeHaMGALM3fWxMTGzo=;
 b=CzB/58F6Qd5XnTBMlVSvu4eIf8ZFkXY2b1YaPzucGTzZupUrPJo/W0X2Rr5w7aZgv1mTvMvFV8Rd+Zhm+aVcQWUhOMsnuyZDXT4DqjGVjC9J0C64W1B9e6z5kHthzWiZZ7jw4GXwXf/R7UAkXBVrty4IRs55s8/5hvEYSlv3eiQnc/ZL7BKZoPckDNDLe+zIy+V03HADV0P9b7kdyrjnj/m9iosISCWVcwA3fYfTzPbb4QRynO5nh3Dct4dXBMU0j5U/EtE44bdiXvU95L/EVw6KuTSKidlu7QgbRcW/mRRv7fRlKOc+zNg+NLVhIzmkmUrutpkVqYUL3hMOPa8HSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 00:54:50 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9388.011; Tue, 9 Dec 2025
 00:54:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Dec 2025 09:54:46 +0900
Message-Id: <DET9YBKJ7XSC.FFZZQRIAW09V@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Will Deacon" <will@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] rust: build_assert: document and fix use with
 function arguments
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
 <20251208134933.24372874.gary@garyguo.net>
In-Reply-To: <20251208134933.24372874.gary@garyguo.net>
X-ClientProxiedBy: TYXPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:403:a::35) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: a638df87-1a1c-4ba3-081c-08de36bd8e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkNUUFJxL1p5a1NlY0FSUFJOV01SN0pISWhBYUNFUXhFdlNvQVpVMHV3V0o0?=
 =?utf-8?B?aGR3T3FJR2YwRzdySjZBd0FBWjF4SHpPU3E4bjBGaEdKZXZkQ3FjZ2NTUHBQ?=
 =?utf-8?B?a3hLTHlId3F6K2d3OC9WTERFelcrN2FaR3M2NERldS9vY3RmcE9STkxocVNj?=
 =?utf-8?B?dlBrMWVWNk5lRGREV3RWZ2hDRjlEd2NuaXc2cURnV3NIRHJBMG1aK3JFcGRG?=
 =?utf-8?B?a2FBTjJzYkpPVnJvSlMvRlpINTFobng1N3JkYkIxS010cDZxaU1wMWZYRThV?=
 =?utf-8?B?UjNXUk81TUh5V0p2WGtKZnM4QXY4VzRMOGVHMVkzVGxhWFk4NU93b1pwWmZH?=
 =?utf-8?B?dTFhdTIxeldyL1phazNoQSt5VW5haitBbWlIM1FTMFpLMFhCaHN0OGtSSjFO?=
 =?utf-8?B?QnkyL1liazZCQ0RGVFI0MnIzVFJWb1BaVTk5NzdQUzRNS1QxTVArSi92OVVS?=
 =?utf-8?B?M1Znc3lVdHpsRkttTGtJWTRNKzhRZU5OZktNNUtRZHNIOHpaZW9Xb1pvc1cr?=
 =?utf-8?B?WWZZaGJNN3docXRodEs2OFNPZlhyZXZRZDgxWGtzVVF0ZURGZFoyVUd0MTEz?=
 =?utf-8?B?Y0lMSlFkNkRQSU1ReHhUeXZEblBVYXQrcWNpMlNMMEpxNXp0bSt6eDF3TzNK?=
 =?utf-8?B?QlZFelAzL2U5bmxuaXU4cGdobGZtRVB3S0FndXJNam14VW9WQWlFK1cyWDRk?=
 =?utf-8?B?RVFzOXp2NzNHNkJXUlpJSzlSaHlSRXR6RFkyZ0RqcTR3MDRJM0RRbk9GQUpv?=
 =?utf-8?B?WXRjQkxGcWVnYjVjbU9SMXNTNXpwZndjZGxQU2FqZllSaHBaQWp5VGpYZG85?=
 =?utf-8?B?V2M1OVBmMDV0aFd5S28zRDRPVjhjS2hxT2lOVWZ0dGR5ZmRCZEpsREZrdUpR?=
 =?utf-8?B?ME9vTlZMN2FNNEFLVk9yb0c2SWxmUndNdnh0RUlEVzhtUGp1cVM5aVlQVWlx?=
 =?utf-8?B?Q0U2MGRjMFFBQUZDMVg4OUtLVjVwLzNvT2RSWTNaRCtGTGtGNnZJU0VtSG9p?=
 =?utf-8?B?YlRUZk9VdDVWblRMb1p6WW0xWU0yUkVtb1dubVArV3JMdkIzdkxTT1R1TC8r?=
 =?utf-8?B?YU9rSXlFcWZRUjQrMnZZdm5BOGgwVEdNQmdhK0d1VnJyRmQ2Tmo5RVgxbXhq?=
 =?utf-8?B?RnZSV0dmTmR4TVgvRjFCRC83bjRyeHBEb0RzbXltRXpCVWNjcG9lRlQ4QWg4?=
 =?utf-8?B?T2k0S2VQTWtRZWhYMFNMNmUxdmR0MHNtMGhReVU5bmtIWWwxTzM4WmpTcVl4?=
 =?utf-8?B?UkhzTnQ1dEljV0V2eEI3MlJCSmU4SVltSVRMSlV4RXdYYzdjR09YTStjN3lp?=
 =?utf-8?B?SHJpWjBlZTBULzZWTktnY25lRHpkT2o5OUxpekx3SHQ3VUIxdTU1SVZKa0VR?=
 =?utf-8?B?TGpnMmY5aWd4ZUppOGN3M00yL1hYZ1pHZHFCNG5TcWNIanhLR0xMOTlmRU5R?=
 =?utf-8?B?cVlDajQ4K3lGV0dBaDYxQ0tyVVhac3BCaDIrdkhtOWpwNUFYUXRMVXdIZDdo?=
 =?utf-8?B?UVczZ1lsalA4d092UzQ0OThOWlBxY1dvYlBDYmhsR1Y2eG50em1ET1FvWEp4?=
 =?utf-8?B?U3Z4RFprM05Ec0kvUHQvWVFQVGxrNmVtZU5tcFRjc2ZBNmVRMkJSSmg4V1U5?=
 =?utf-8?B?L3NBMmw4N3BuQzhCZVRJc0g0ekNHRktVZzhHVDkzbW4vb1pYYjhpVWZITmI2?=
 =?utf-8?B?bkpWNDdkZzB1V0lvTEEvc3hlaGdibmt1K3piV1VoUGxQTzZsS2ZiRjJMZzB4?=
 =?utf-8?B?ZlR3ZmZrckFab2NHZW9IWTdtbDhwRzNER0loVzZvQnUzYWRGaGszWitQaWJ3?=
 =?utf-8?B?ZFJNalBhWXVxUlhacTdyQ2FDbGFTTExjTi9tQ2J6VHJQaEJkYTU3MzJ2OHVl?=
 =?utf-8?B?RkNGck91ejRzS0JtN2hiQ3oxRnljQTNic2EyYjBOczdDT3UvY1J3OG81Ymdt?=
 =?utf-8?Q?mvzVMmckd88OMKePBoaiStch+391NL0M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWdHTnJURDN5Z0RTN2dFVGZrc1N6aGN2Rk5XR1ZBUFFIN3hyK2d0Z3R4aGY3?=
 =?utf-8?B?REJ0NjdxZ1dscUF2M3h0NGZFQ2NWK201SVVJVWVlenB1WllmNDBtQmJGRU1j?=
 =?utf-8?B?NkhVTlE0UVEzTFJka2NNTi96YzY3S01QSGpNQjNZdWZHeDM5dEYxMEt2RWZp?=
 =?utf-8?B?UjBHRzFyZzhSQlJTc2sxQmpaRkxvSnpRSjNtR3F0L3MvRWlmNnlqRjlyM0Q4?=
 =?utf-8?B?MUJTMlNVSEQ5U2Vwejk1V2M3VHlxYnVJYlJaZkZZVjNhNkE1cENWMFMzODdl?=
 =?utf-8?B?b1luY05YMmhnNG5OYTEzNVRNMnEwN0lJS3Z2RmtrOFVXTjJkNmlpQVY0Vi9s?=
 =?utf-8?B?RnUrU2JhdG94UmY3MWZPY1lHNUdpY3JvZ3JJSmpOaHZIVmlyMmltVTdxdTl4?=
 =?utf-8?B?SFc1dE9WS1lLU3BhRVNobGtSdmE0YjZtRDFNY0RUVVFJNXA1Mi9SQ1JmbkRX?=
 =?utf-8?B?d0FPcVZreWZMckxzUzI5RU9CZVdKL3VIY3IzMlBhZU9GUmllbWR4NnBhLyt3?=
 =?utf-8?B?NXZ3cVpvRDBFU21RS3ppenJjUm1ZTmMzU0hNTWcwVEdNUnllTlJBdGVFaENh?=
 =?utf-8?B?UlIvRFI5ZEVTMXhoTHF4RGZxbmxXQjdKeWxtWFNLMkQ4NHlFS1ZDdlhBc2pS?=
 =?utf-8?B?Sk1ha1d5ek5UVGthdmgwdXZ0c0E0OXRvSzNHNEVlalhHQ21iT2oyVmZLQXNy?=
 =?utf-8?B?cEFyaEtNbWJ3ZU9Kb1FsVXY3YTJaNHphSWIxaWszOHI0M2xRZ0xtQ0pvTkJ2?=
 =?utf-8?B?M0hGVCtnUEhnamxVdit1cFc5Vm1XRkk3VkFwa2hacFdVcDF4NGRGUllXT2NR?=
 =?utf-8?B?a3A4U2M0VEd5NzNXaWpBMDJRVE1RM2hCNlVraXBvQncydFo3REUzYmxQRVl6?=
 =?utf-8?B?RkpDTWlpR2NRNkx0WFFuZU9PdlM3K1NQRkpiRlVaWU5YK3Bidm1wMnhvc1dl?=
 =?utf-8?B?MkZsRCt2NmZmQzk2YTNKZ3ZvN0tHNzhqQ21UUnVhMWx3c1V5M2JydEp1UVlS?=
 =?utf-8?B?R1NQUXVibi9UUVRXbUdJZ0hjSkFFNXd3ZW9FdEtrdHJnaWtXMStCUVcyaDVi?=
 =?utf-8?B?RlRUQ3FaMzBQQytydjhlUzZ3SXd4SkU4VUpKMk9FVFRIcWhKT3BEVFIyUndJ?=
 =?utf-8?B?ZlBXQkR3UndlR1I4T2ZZRGRjSTZUWWxWMTRkcnFnUTA4TTdZdlh5ZmtNUzFY?=
 =?utf-8?B?RkVDMFlZVmhtaGZWVXF6QWJhMGpmcFpnMzlEMnJDTW9PVEc3a0JJaGdOR3k4?=
 =?utf-8?B?djRiT0JUcXBVZm96cnlaU2FsaVFUdy9UT0tIU1Y4VS9QOUhDMU94V1RmWHFE?=
 =?utf-8?B?dDdCUnRiV0o4ZWNkL1JFVDVKTkRlTmg4QlBmMlpjbzUzKzYyMVFqZ1ZKSDBm?=
 =?utf-8?B?S2t4R2Y4NldwRDA4T3M2VGRWN2pQcEZTVzhOdS9VNWhDN0JvWThCMTdUNk8z?=
 =?utf-8?B?enk2bml2TnJyS3g3alp2WCtTYWxaSGF4R3IzVDZrQ2VJM0VuaVYva1A5VU5M?=
 =?utf-8?B?T05CNTdJdTkrVUttR2F6ems5dWtLZ3BFcFA4bHFLMk00R1UySzBCNEJrbFJo?=
 =?utf-8?B?bC8wa21NTzEzQWZVVXZxNzUrUTh6TGZvc0kvNVJ5RXVIRG50Z2hHbmZ6RDU4?=
 =?utf-8?B?NWlMQjYzcmdsdk05SU5rS1c0eWRicWNKbStTeC80c1pxdjFNSVNhUFVsTDEr?=
 =?utf-8?B?b3lFbnNsV3lsTC9XN05DKzlPOUxEZ3EwMEc2d0lTSFo5VXZob2dmYlFDTGpl?=
 =?utf-8?B?ZWZLVlVEZmFJNFlSYk5CYnJkbGFsVlk2WkNxaDFuZlE2SG9TNnlDOStlTGFN?=
 =?utf-8?B?czlodjF5Q0VmaFpZejJmNk56ZTlzbytjeWt3UFVvazJwUjNSU0UwRlVMSU5x?=
 =?utf-8?B?MkpMU25qcXJVa1pIaTg3c0lLWmJBaHhWUU1WUEVDSHMwZFNNQ2l0TW1jUzMw?=
 =?utf-8?B?L2VQeDJad1ZTS2pLQnBjWmh5Q05odHM1NmdGNEs1dGovWXh3N0o1WWlzVkta?=
 =?utf-8?B?M2dCVmJIMVMzRWFTa1dET0lEdi9jOUttY2NEOS9QOHlVR05FdUdtMEo1R3hx?=
 =?utf-8?B?c3pybElqaHl6MzdLWURkbGxmaUJ1VnYwUzY3Ym9uR2dEZ2ZQL3FSZzVqT3RO?=
 =?utf-8?B?M1hYb09HRnJpUHNiRCtaU2pkOGxOc3NNRDJWdnRSYW8yQkh6czc1Vy9qVHpQ?=
 =?utf-8?Q?gUcXlKGxF0CMz487Gr1MldEG7Q9Mbu/HZFmgQFr0m+Me?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a638df87-1a1c-4ba3-081c-08de36bd8e62
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 00:54:50.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ea2dCh9179yFe4MANVLXTeOg3UZCuIH6ttoeP2jTP1B0EqUXOsPpOA0qF069kufnQorotoIhh3A+wjr8Tg7EEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760

On Mon Dec 8, 2025 at 10:49 PM JST, Gary Guo wrote:
> On Mon, 08 Dec 2025 11:46:58 +0900
> Alexandre Courbot <acourbot@nvidia.com> wrote:
>
>> `build_assert` relies on the compiler to optimize out its error path,
>> lest build fails with the dreaded error:
>>=20
>>     ERROR: modpost: "rust_build_error" [path/to/module.ko] undefined!
>>=20
>> It has been observed that very trivial code performing I/O accesses
>> (sometimes even using an immediate value) would seemingly randomly fail
>> with this error whenever `CLIPPY=3D1` was set. The same behavior was als=
o
>> observed until different, very similar conditions [1][2].
>>=20
>> The cause, as pointed out by Gary Guo [3], appears to be that the
>> failing function is eventually using `build_assert` with its argument,
>> but is only annotated with `#[inline]`. This gives the compiler freedom
>> to not inline the function, which it notably did when Clippy was active,
>> triggering the error.
>
> That's an interesting observation, so `#[inline]` is fine without
> clippy but `#[inline(always)]` is needed when Clippy is used?

Precisely. And sometimes just moving the code invoking the
not-always-inlined function that invokes build_assert is enough to fix
it, so I don't know of an accurately reproducible pattern. It also
occurs pretty rarely.

