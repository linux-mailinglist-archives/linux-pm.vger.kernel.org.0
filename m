Return-Path: <linux-pm+bounces-39141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C73BC9DA21
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 04:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE863A9281
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 03:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F80B20E00B;
	Wed,  3 Dec 2025 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TknYbWkZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26C2B9BA;
	Wed,  3 Dec 2025 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764731999; cv=fail; b=JWeysklpdK3d2uBE+398MDILdxYDUoMaRgZbt1WUFIgwn7Z9X4pOKnm3PwYBVXAJbzUl5KerRYnuUjpWB9FZklS4OsauSGQxyUOUeJVb6JyBovIHOTCCeMUqC4H55CZopykI0zf8fhSxMCiTBK+DRkyLFBKMotwvFPlYXt+sMyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764731999; c=relaxed/simple;
	bh=xuILns+zuO6Pkt6Y/wac6haZc1yCFWg9c6Ix2x320Kw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=mQw0h8rehrM/3/Dcic5k41HSPU6NFAuJfbfika5uPmOHxJ0cd5Z1njcW0ao3jNULHauIE+aIGaepbeoFDhoICuvN7OKAAeSbujbX0WwIa3sDvwR8GU4Jf78dvS4C+KA4WJzppo1cjQNtx1r/QMalCPaVWWgMfK0dWGHtnOIksVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TknYbWkZ; arc=fail smtp.client-ip=52.101.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4gZQVeSlK0EAXjEAO5IxLkhmATzY7Zwc1FevMFGD/H/ox7pzybviaeU49K+0xQ7oOwtIG8EkUDtfAuj8zNSZkvcbwodSrN/yETaDG/x/BAV9W6UVYZQaqt0Og++c7D8NnsNkEzFbywpdcTaxSRIENtztADUZRF+LKRfAo1Vv2WiHRY+eJAOsZRtXE048sYKwFHQBQRIcBkBKIhBgxGhhbaxRUZX9AUi6jURrCYOY9ovjsekDziVtp/7ySAzeRFWcoR6DbZzaNKTuooaN9B6cxZVUyX5gUaMw4ti4g40v1GsqB6rlGXv/OlHCF97LzIvCVjs3PSOHWG3cvjB6phiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuILns+zuO6Pkt6Y/wac6haZc1yCFWg9c6Ix2x320Kw=;
 b=inC0sa1s32i7yzlL5+sLww1rIrOlrWrZkMUrdG5FyC5kIq2ehSPms7d6xeCGujm2seTiKuMUcfp5xNc+GX1sy0LTW0MG9RdtIqGYQDG/7qyKXkOhdB7Kipo1QuLqu/oE8aKFjQp+T1nxEcAFBOter72Gd5+/XjMPJTssV+BMd7+Cdbic8gnuMBCrrg1MxDCkYeXzVx3V+shapP2oQpOu/VOHGepKkFrW1lG1hDSCM+M9GAOo3XE0wt1qTynhaB34tPmis27k9E6hjOcaxlGJHCkqXub3UfmqS+tFFtySXclSthNglj3s2nwq1akSZJ6heYVIlu89BowXxfRpML3MDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuILns+zuO6Pkt6Y/wac6haZc1yCFWg9c6Ix2x320Kw=;
 b=TknYbWkZjsVMyrjNHP4FrTQXGy8VBsxYjJQ7HZHeQg+ta/n243Ix6C5OqSuIlOueKega9soVQ7lT+y21wYr/GTL86eeRUwKXsijfvIet3eE0m6QwLUBQvO0WCQ34kr1s+6exVvy4if0Y0hGlOCVAsbsCvhvbpeYf5UbBVTEXSdzM81BNIGmUJbOqax8C654CSiqAaIwmWiHf9kV53VNtbr8uwqsiv3Wmkh+2/zB4AJ0Y+Tv7g2q7Fqnss/8HUSgBOSEVXTZMNRyDmqnP3jhe8GQtB8F6GltECRFclcUBQcr0iL2joWVls4irARMTTzh+v5NI73X1zLztSywKORm2yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 03:19:53 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 03:19:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Dec 2025 12:19:49 +0900
Message-Id: <DEO9A3YCUEBI.XTTH17KQLWP4@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] rust: build_assert: document and fix use with
 function arguments
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <0A952509-8A00-48A0-B975-C23608A6048E@collabora.com>
 <CANiq72nSo4vuXc+XW6yynbNvpZi2vJEshXw2zA1RPgSUWwAZ_Q@mail.gmail.com>
In-Reply-To: <CANiq72nSo4vuXc+XW6yynbNvpZi2vJEshXw2zA1RPgSUWwAZ_Q@mail.gmail.com>
X-ClientProxiedBy: OS0P286CA0041.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9e::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: c45fc1c7-a1fa-4301-765e-08de321ad387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmVqRWF0bHc4MU9JY2RPWHRCUStyRzk3aWh0UHhsRU9iQVp2d0Vjbm1QUWVE?=
 =?utf-8?B?cDB5RUFEL3hlTWUvK3lnQ0R5OWY2d0dtZGh4SDhkelZGR3dpdStTV05qZWRC?=
 =?utf-8?B?Q0J6TFpVZ3RmNWtHOGRiN256WHpvVVE3cmJtNHdGYzlSNldRYnNyZ3l0QjRS?=
 =?utf-8?B?STdSTEFPTGptNnptbm5oTHU0aEkvbTViakxIWTFxTzc3b1BDdTBNd2RUa0cy?=
 =?utf-8?B?RW1qQ1dqTE40d2UvZHV4RmxBd0pzakNjaDlncXByWEYrVVJhU2YwbW1XWVIx?=
 =?utf-8?B?blVLN3p6ZWR0SnpYZDJzRWpvY2RyTlBzQng1dlJJdmRYZlYzc0JHYnd4eXVV?=
 =?utf-8?B?TTFZOVQ0bVdFR3N0WTlVZDFHWDdZT2NGb1ZxbjFJTXF0UG0rUDZGeHpubmFU?=
 =?utf-8?B?YVZnNXV4RCt4Nk5ndXNqTnpWWjFpbkJiTi9GTEZzWldTT1h5RmJWRTVzZTQ1?=
 =?utf-8?B?eEJKM0tZbXFmYVZ0ZGd3SHZLZjA2ZjhmUmZQVTBocXEzeXgxWlV2TXkrMXBo?=
 =?utf-8?B?TnM5dGVEZ04xUXl4aUFnd0ZYOXRVeHM4L2lDM3BPNk56eWs5SEY0TllCYURZ?=
 =?utf-8?B?U0gvTlFrT2hhbTZyd0hSYWZEZmRYNFk0dkNEYnFwemFhY2pjZ21NNm43emRa?=
 =?utf-8?B?M3pBSlRnTEJLV1U5WWtFYW5KQnJGRFZqS2psRHZldnRSZ0FaZGRYeGJEMm1K?=
 =?utf-8?B?bVB0K2ZtdmhybmdOb1pyUWdLQWpKZnAwazE4Rmk3OFVYaGE4WFVJc0VvMEdM?=
 =?utf-8?B?VW9rWHo0WnNnRTBSdmNZYm1sWXZIWGVIOFd3RTdNaWZCcWc0UmhHQXVETk1i?=
 =?utf-8?B?b2MzVlg2VGhTOXF0OWZ3THdaR1Y0Q2ZxZVZXV3ozVWdocE1ndDQwV3RncFVv?=
 =?utf-8?B?RWUwai9kd3MvbGxXRDdzUGFOU1dRUVg0eU9BTzU3ODdnVFhoelZ0ZnRCZjVN?=
 =?utf-8?B?a2tUTDgrQzZDckVaaUd5VDgrN0lKdmJvZXUxMkEzMVp0VENodkh4SVZkNk9m?=
 =?utf-8?B?Rld3Ky9RbGNPRkFvSDZsLzd2SXp3UUdvRDNIT3dtSGZ2SFpHMlBWMWJTQjlh?=
 =?utf-8?B?UHpIbFVGNkVDbXk5YUhMOFZZZnRzeGowbCs3YUJka3FaSGVmeGRhVzRPb2Fl?=
 =?utf-8?B?MHBxY05jb2dnL0xzNnB6V2JJekZSaDM0WEF3SFd4REFoUzQrczBKek9kMGJT?=
 =?utf-8?B?algyMitncHY2YzVWYm40ekpMS2lCWkU1UTQ3OUNPc0RxMlhvdk95WVo1TVB0?=
 =?utf-8?B?Z1l5K2ZPVkdiNWk5aDZmbmdaOW11azdITHBmR3hMRzZsOWNCWVdxNkxEbFFW?=
 =?utf-8?B?OWdpTXp0cGRZQUJ5NGVURWY4ekRqRi9WS0JsYmtsTDJuQ2ZJT3NBR2laWXAz?=
 =?utf-8?B?T2o3Sjh3V1pZeHNrVzY4bGhIc0xUdnFiNVA3R05RZTFOaS82ZE9SR3dIUEgx?=
 =?utf-8?B?Y3hOYUUrcjJNOE5URzBGZUppby9DZ1ZnZS9YbUlFQnJDTWFzVVR1TmxRc2Y3?=
 =?utf-8?B?NGNjczQ0UHpVUXJwZ3pXbnhETnVuQUcrMWdZMEtTYXl5TDdEWldKZHlzWFR6?=
 =?utf-8?B?M2J1NEYrZHRKL1ZOVTZMTGVwM1JLVmxDSEV3QVVGclEySWltRHE0Vk5PZ01B?=
 =?utf-8?B?ZTFzWHpyd1N5QXpDS093anVVYmhTMkl1b3lHWUNXTnBjODR0MVEzOFk5Z3N3?=
 =?utf-8?B?emo2bG1Gbk5KNDlKd1piZ01BL0hSSkRlQ21YU1h2bjhROGpTeVZ2RzI4b3kr?=
 =?utf-8?B?UkZVOHhWbGNJQzBWNzJ4a1lJY2FRYzdqWHZ2amQ1Y1FzUWJSaE5oNTB1a3Bz?=
 =?utf-8?B?UWNIdThnSmdYcVZQQnJWd0p1M0U1K2t6M0FITnFlZE56eHFRVVRKQ3pJaEd4?=
 =?utf-8?B?Y1BzMU5yazBjZUt4TTlBQWl2YzE4WW1GWWlzMW1OajRBSXh0ZitZcnBhc2tM?=
 =?utf-8?Q?bQeoONTsTjrf9HbiEIp87a5jctKhymgN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WktuU1RhVXhHNml1dG50a3NwVEZJNzVCaFdvRjRmMW1VVkw5ZjY3YzZFUHFN?=
 =?utf-8?B?VFJmNFhVWGF4Z3MvbWI2bCtiTmNLQzFVWm1nb2JUNnZYWUNCK3MyQS9VdUdN?=
 =?utf-8?B?bVNLdHN0SUFxaUhPS2wraWZhUlhtWGVmWDdOVTgyVVZRcEtkenl4ZFVvb3FV?=
 =?utf-8?B?WDU0OUUyQ0wvVE5odi96dW1DSWozWXUxcXBFMHVXQ0tiOHBRTU1ZMzlyZWJ5?=
 =?utf-8?B?b2QzVEYzNFFIL0U0SjJhd1pXcktMdnd5TzlldVpZdHlVYnQwdjBLMHMzRmNt?=
 =?utf-8?B?dHpZSnJVMmlGcjY0amxOZlZ5eUQ4YmxDajBNT21pRjZWaGJVN0R5TGJyNDdW?=
 =?utf-8?B?QUZsWE5mN2pzTzhEOUxndnZ2K2ttYnpRU1J0dU9VODlJMGV6eGRIYlc5Mk5D?=
 =?utf-8?B?Z2pxbkFIWHFzZlVBbGlzdDBxOXg1QVVJZXFjRWFGZC8yYSsyeHdaNzVsTnlG?=
 =?utf-8?B?VDRVQ1Y4ZjVDYnovZmFSbFErY1p1VmlqbFE3S0dFUE9QdlFnNjhxVE1GaTJS?=
 =?utf-8?B?dXBxUmdLajg0U0lXa1ZIdTlCR1g3SzB6dkF5ZXFmT1BZYnIxVDN2SzZpR0FR?=
 =?utf-8?B?UzFDQlMxVEpNaUpIYm56QjlJRTFuQjBmMHdhc1pGSlhtSVNndnRhcG9uWk5i?=
 =?utf-8?B?RU8wY2hJQ2NnWnpHVlE5SDlTVFRjRndZV0dadDRRRXJIb1puanNneC9DTHNy?=
 =?utf-8?B?USs1dlhuZUJ2d2Y1V2NlWWdOOXVIYUVtWEw4ZDljRmVoUnZZRG5wL0g1TWJv?=
 =?utf-8?B?bkYwK3IxbEFIN2ROOUNpcmtYM1RSTDZlWkUzSFhBV2RnaWtvNXdXajY0bC9V?=
 =?utf-8?B?WFRUbzFlRmlDZWVtOUZ3MkE3dkdBaFQxZVZmL2JtcGIrellyeTBLQVBZNzdo?=
 =?utf-8?B?aW5Ydm1ScXU1OGJ1NWZzL01kdUFXMnRZS1hRdExELzZpQWErL0NUaDRxMlk3?=
 =?utf-8?B?c3JtSUhBbnlaVmZoVmU4dkhZMVcwNXlFQVRoY0FCSGxsRGZlNkQ1MzBtUjNr?=
 =?utf-8?B?YW12Uzljd1dqWlk5Y08vcGErdHByOFpXdmxTZWV0T0xkSkp6bmhLdnlCd2Fz?=
 =?utf-8?B?L0FBQWVVdmNvTE8wRi82bVFML0hXQi8vdC9QVkZzd2NLWm85czFsbDJZUG5k?=
 =?utf-8?B?SlBtc0VKL0QzZlg1eUZQeWhmLzVDVnBEZ0psT1Z0Q0hXYVE4bmQ3aXovRjVT?=
 =?utf-8?B?QVNVYVdwQ2lsck1RaERJWFhmOEZnZkg4T3Z3RGNYbitvM1VuMkw5Ykt4WkFw?=
 =?utf-8?B?TTJacnRnNHVBZXc3ZUlUK29sUE1ZdzJHS1h1YndYQjY3V0dOek5oeVR6WGpY?=
 =?utf-8?B?cEJGVkFwQThlTVBqeHZuS2U3Q2s3dWgxY3p3YVd5eUd3TWpGNTRVN1ducWFv?=
 =?utf-8?B?WE44ZCtZMnVaUVNSLzNDdmttTnB0NGwwVEhVREoyS1I3VjF5RkNZTmZuYmg2?=
 =?utf-8?B?cWNORDI4dU9mbldVY1FHVTMrTEdaekdrb3dob1FSSDJKU1owd2ZLUy9UN0dB?=
 =?utf-8?B?UncxNVRlV0VYZGJxVzdnbG11TmY2SHpKZHByUTQ5b1YxRUwzOWl2ZjYyd1E0?=
 =?utf-8?B?U0JhdWFTajdaQ2JmalBTUVNqcGkveWt6Mzl5cFdWd1h3QUxkdklJdElFQ3FN?=
 =?utf-8?B?aUZDeC9DZlpsUnhEVnN0SVpoeVhKTWRpU3gzZGdsVkc4Yng0eVpYeUdOc1B2?=
 =?utf-8?B?SzRSQ2Z6WTVoclJkTE8wczcrNFJjNFo3M0ZtdUN1VFNHNEdjelBFZC9hVjRO?=
 =?utf-8?B?WGpiZnFBYUs3Q3dyK3hRL1JreHRDenFVQktDOXlEd21wbzQ0Mk5KRFREZHAv?=
 =?utf-8?B?d0s5QzZKNWxuYWpGWXZ2SHF4V2xhbXpRVWdpQ3JVOGVUZmhVNjdoNFRNUmQy?=
 =?utf-8?B?UzRRT0hCRUpxeWNUT2pOYmIyWFFpWTc0QlVjNmRkZHd4QlNwdi9WV1BoWHpU?=
 =?utf-8?B?cC9HYmJJcm5rZGhkd0tYZ0kwUGV0SW5VZkpXeTRCWThIY1VyZk9RK0NWOURG?=
 =?utf-8?B?d3owd2VJdFNaY1Yvd2xzUEUvSWtObE5OWGM0aHNsSHZndTRJU0VpeDBKMm9x?=
 =?utf-8?B?cnBlemVianVxemZTMnJoWE1Ca21pc21MY1MyYlBBc2N3djdTVjM2bU45aDZW?=
 =?utf-8?B?dVc0RXNaMWhOYTNpSng5QkpSR2Joc3IxeUFKTklPQmRVTkJPWTRGR24vRU4v?=
 =?utf-8?Q?GxqQTYxH7QAYXuI2q+VbiTq8eH7p0IvH9IskibTiA6BO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45fc1c7-a1fa-4301-765e-08de321ad387
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 03:19:53.4370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2UYpq7+xbeIaXpJKufHiopw+4luKfZAR5Fq89nIoIwXQsfsgMS/6Z0Cyy3zV+i9RV8zWDO/iu4jm8nfNklP/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

On Mon Dec 1, 2025 at 2:48 AM JST, Miguel Ojeda wrote:
> On Sun, Nov 30, 2025 at 5:09=E2=80=AFPM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
>>
>> Ah, should this have a Fixes: tag?
>
> Yes for those that trigger an error, e.g. the `Bounded` one with -Os
> in mainline soon. We probably want Cc: stable@ too -- it is not too
> risky to add these anyway.
>
> However, the tag should be different for each commit depending on
> where each method was introduced. #1 and #7 are not really fixes, so
> they don't need it.

Shall I respin with some `Fixes:` tags where appropriate then?

