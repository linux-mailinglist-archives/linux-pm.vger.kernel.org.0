Return-Path: <linux-pm+bounces-38854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6172EC90995
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 03:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8EF73345312
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 02:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0747285CBC;
	Fri, 28 Nov 2025 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NwC1jOi4"
X-Original-To: linux-pm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FB3285058;
	Fri, 28 Nov 2025 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295933; cv=fail; b=GxHfXRnNWTP23oE6oZw9gfjiLFgsRS3WYznz8eT/lU8xHAb9ypBa+xzWzVZ0//aH71ff3HqF4JFGOTnavXyY3J8JkUyo/o0MC1Ae2+xAqJt00TuLpNOJmSsjo4Cfczc5pcfbAkmjcnyC539JNaRO8N5u1cZtu2oadtbp/IadiLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295933; c=relaxed/simple;
	bh=hmrpWSgGkWcg/2un9r5d9OUvwyfKWSzPhBH6244TLhE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GDZhOYGkk9o9Z4MXftBLh3HkDeADEffbBhOsOoyW0vAV3b/wijEHmNw99VJGI7QznNEHCUjPrJlBZlkA2sbPgtXhFO32zdxwRnouxjkjqF6o9rgf9FEamQxRz2LZZWmsw13D+n22+djOeYmQws3ZfiT6GOcQfkQDlLoMwCqnXus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NwC1jOi4; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMsJHpcCcDafU1tX5OdiitkVtUpaGLDL2S3l/TnVxJqDmbrFyZbJ8jE088Mr/Dt8RoSKQWWDu44u20b4zrb2ODiVOhR7rKzfdoxmTr8MgNHqI3YVzz00e+h0tzekJ5WsYGIEMFZT7kIJIOOfAxyHhInxsm2rKCfV57p/dk9gHckM2W+G9/Ta73P/kpsIl08xqv/AE9b2dZ21K+5585r6AhF/8NVMSGhJb0dYo7gklHv6gaI4Slqn2zQLau+/TH2dTB2+lsKvKVkbvuRJ/SX0CCHgR4yz9kQXRhribOvvMpwaAeuU3Q5RUKFlLfWE3GxZJaW7tvV2wcb6iaXD+6gCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZIU58KwQva30PEjmwxY1XEMHhv//O2Yd2NRdCdgaKs=;
 b=Bolv4xFCptxA1eTZPay0giqkIENHtdvfSIoPMyc6mhH9M48ySPNXhxKty6/V2Ux88OeRzqU6EDTwSPDo/NOWPrChNOja3IIsBeI+rqtRiqmlX05UcqmMWbD7LHXPYSsY0uv2OHhsvJUuH7v6mM0236+WvbW2up+okMzsCX+/V7HAmtoQ7h437+WZWlzdqg/0mwCQjKOALArSd7k32X5hegOBpqgwsYY0io4689x/jPMApf4B255SVOil/cPVLRs+We6avuiWUPxrDzVkfbr0bEXzU83TywzNQjg4tORPeBzKr6W2dFPowp8GeReYLw81UHZdC5eNizwMqT/NGyFoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZIU58KwQva30PEjmwxY1XEMHhv//O2Yd2NRdCdgaKs=;
 b=NwC1jOi4El9XLM85Y8WqsFabzCOarqKikzIMY8ZmxVbKK/65d1GEP8D433CBb9tzBSJ5rUlX7ZGgFviwntxIPkLqLvpsV607fxUz3TLi260wdtzGUVJxAOsgnm6lloLATIgl4kIQrhRIslFqm0CXKZ2uS/nWFiwTKk/xsfPmJC7DlfKBlL/q/jXIVRicwkB1M+FP884itP8agY3zw3phK+5J0L6g4Yl4wLzlU2jr/N3NnwcBvZDN9anQD24H6PlVy+bTRCPwX9sg9+aKSrElthr7s7RdbE4Wdb00Fp/L6ZIVfkuedlJBwe5wp9cnmcw9NopwVr7xhEQH6xTNVSjhWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 02:12:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:12:09 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 28 Nov 2025 11:11:41 +0900
Subject: [PATCH v2 5/7] rust: sync: refcount: always inline functions using
 build_assert with arguments
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-io-build-assert-v2-5-a9ea9ce7d45d@nvidia.com>
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
In-Reply-To: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYWP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc05930-8368-4ed7-9667-08de2e238911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aitXMGVBQlFtL1MrMEtYTFI3YlovVmtiZ2Q5L0FZMVU4LzBsUllMWHNMUkJ4?=
 =?utf-8?B?SGN4YnFMVlRwNUpaTC9aYlVER2tJT0RYendLQlhtL2xkMjlFQmUzWVJ1ZFVv?=
 =?utf-8?B?NUdqNnpDZHRqNFJZWHYrdW1QYUtwdFZVVGtGMDExSllJNVh5WHJQUkh3ekMv?=
 =?utf-8?B?Yk4remVJQTd6Sk9xbm9nTkJmR2ZiV2J0UmcvTUozcVYxQTJxSlArREo5cTFl?=
 =?utf-8?B?bCt4ZmxXd3RYdzN2UXBlTERwRHQ5ZUpJU2c1bGVQUnRVbkFpamNncFZSUVZj?=
 =?utf-8?B?M1J6NzdIbllpWTZaVE1ZTFM5bHBGVEU4YVhjV0hXTDdyZ3ZTckgyak00aVQz?=
 =?utf-8?B?WTMxSEo2NUh1eUZmSGlIN2o5N3p6WkQyTURoaVZaeWZrbnk1Mk0zeUgvTnN3?=
 =?utf-8?B?ck9nVnJ2Rm5Xd252aFBYWmM5M3J4WkFOclNibENlMGFxZ0JhaEo3R3ZzN2hO?=
 =?utf-8?B?QXdpTklQOHBoZHBGUnlmTjBmdDYrZUxiTS9rVW8zeGU4VERzZ1ZKc2lOb21r?=
 =?utf-8?B?TGNvb29kU1hCemZhMk5tUlZDRHZPNXhHQ1dVYVNMZzI2Mm8zbkwrOWFvQXg0?=
 =?utf-8?B?QUVzZitrN3hXRHBPNEJEWlllczcwTUFHV3gySDdscnR3aHNlbkd0SnFSZGZN?=
 =?utf-8?B?bldUNFlXVUNLdzA5RXM5dlhjVUxNazJ4ZlE1b2JXUmRHdUZ4c0h3VWoyT1kz?=
 =?utf-8?B?TFhYeXhaMzZwM3dKamxSSmdCZUR2dGtRSldTZHZGZVdXUzRWOG1VZFd0RHNV?=
 =?utf-8?B?TGRMMVNxZWcxaXFyWk9lbzNNVC9HcUEyYjdNa0dYNkRlSk1WMkNzLzFLdTlS?=
 =?utf-8?B?YmswVkY1Z1UwRzAwR2xPNkhxWE01c1RBd1BCb0I1Y0t2VGV6VVhpUUZGNDgx?=
 =?utf-8?B?QmVqQjg4ZjRSaXp0ZFIxZjFHMmhSL3BBRis3a0VFQmxzQUdka1VkRTBDUUg5?=
 =?utf-8?B?bTNvaWdXZlpnMEJnVjV3cTZseGxCSERqNDd0aFREV2oyeVM3V2g3TFV3blVF?=
 =?utf-8?B?V2gxZ0lXcTRUdmNDdmtpekVpaE0wdEs2blp1cytJQzVxU1R0L3VINW9RRVFQ?=
 =?utf-8?B?Q3VUM3R3WHNKekFIMW45TzlnVWxXK0szVHQvSnNNN0wrUHluV1RsVlZpOWFl?=
 =?utf-8?B?T0hYQ2lTOHhSWWhuSWdEU2k3cGNTYWoySHpKSzJjZ0wxdG5XZ1haZlQzaEti?=
 =?utf-8?B?OVRLVUUxOExETk5MVmNDYkF1aElwQnVvN1A4bWhURGtGREJVYzl0K1VHRWdm?=
 =?utf-8?B?Q0dxVTg5bUxaN2xSTGtpNGtCdXJSVFRpQ1B0cHJ6VVNDWWx4Z0xUTXdpT3Y1?=
 =?utf-8?B?T1UrUDRPQWR2dGVVdW9QcW1NYjc2RlVacmJtZTRISXRRQThrdjdNWE42cWh3?=
 =?utf-8?B?d3ZUZjV2dXM0VUQ1ZEh0U1BkUVFBZ0ZjRWtmZEI4ZlFWVWxIMnZjcGo5bUVv?=
 =?utf-8?B?RkZ0VkZ0allWaVhWNmNsd0w1VHJWYnF3SFV6M1cydEtIbUFZbnhGSWJsSzVs?=
 =?utf-8?B?TDZ5Z1VqQWp6OUxvdlB6c3I4WFNMT1owdUJ3ajBEdy9uaWZFYnJYcDNTbGND?=
 =?utf-8?B?bDQzc1JaTDlDUDFNTVJBSUlOSTlDVnlsTTB6SzV5Y2M2V0lkdWovOTNsMWxP?=
 =?utf-8?B?bGhpRmdKRDJKaUFPZ0dZQzhnMnc5NUE0dzEvamtPNHFaOGVrM2E2c01yMWtm?=
 =?utf-8?B?ZHpEald3dEZlUTYxN3RiL29UcTVYRXlFZWNUQ2VRU0pkZ0RiNXJUdjI0QzF2?=
 =?utf-8?B?SXcrLzFzUmZaMGZUdmFOL1o2dVd3UFhCQlZjcElGd1N2a3JtRnhIb2c1MHJW?=
 =?utf-8?B?N094Rm5qZkFPMjlQcXcyYm1vQVRXdUNxL1I2QnJ5eHBjMGpxaVkwOHJyRUN0?=
 =?utf-8?B?WUZwSzNKcVdEdXpQVVRKdEZHZmU3R1VUMkpOdlB2TVdRbzQwL00xOEF3MWpY?=
 =?utf-8?B?cGVuTHNmSXFTZkhhOEk3WW9WUnMzemRiN0xJNUgxSnh4Mk5PMGQ5aTdFNE8v?=
 =?utf-8?Q?6Gvmm49HAod3xRpmXpGaS01NfvUwsU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUZzOUJRK2NESTlYOW9xQXQ2azQ4dzNCc1NHWEtJb2ZHWlZUcktSSUlGUUZV?=
 =?utf-8?B?WGV0U0dKVVRaallKdDlzN2pNcFZrVzNaWHJkTDFJRDhmNmdCRWRvQ29lQ09Q?=
 =?utf-8?B?Y2FrL214bzNuZnhiQjZsYWJrK3dyaW1XaEd1NUlQRVkyQkZjMDNSUWYvM0ZR?=
 =?utf-8?B?dnFWNytKYnlBZkoxT2Q2RUpYMXgvNXBRY0F4SDBXcytkMTQ5YWd5aVlqTk1L?=
 =?utf-8?B?OEhPd1llQm9aY3p5Qml2VURnOGxjNUthZHdIblJvTGJDK0lUQmlidDJEMVhD?=
 =?utf-8?B?a2MzT1JkYko5VU5FRzBhRUFJYXEycFNVRDlVcWlxazdtVzdKa3lvTGFYZWZw?=
 =?utf-8?B?enU3aE8xVStKUzFvWG54ZFd6VkVTYkdqR2paNlJiYkpDR3kzd0ppOThZVTVJ?=
 =?utf-8?B?cFdTR3A3dkhYY3AzNHBGcW9IOHF0cXRjT1NXcUtCSzVtMHBBOC9IRjhkeHY4?=
 =?utf-8?B?Vi81cVNjRUZ2TG5zOTFhbXhhQ0lkd0ZlSXRUZGhyNXhuNGJnc2x0YllzdDV4?=
 =?utf-8?B?NGFuMkFmME9FL1JTcml5M001K21UTjBBT09qTXNPZk42aDBaVjdzc2pOWUFw?=
 =?utf-8?B?WFFMUU5xOURZU2pMUFE5N3ZvWUV1WHA3WGpWSU13Q3BuVGJSTklQQmg4d2NF?=
 =?utf-8?B?V0VkcVNtWGw2YXl5anVwaDhOYTV4cHBtOWxqanNSWFlRVjAyTElrQzl1SHBi?=
 =?utf-8?B?QUM2L291aXFSZHFOY2JuVUVnRjlpY25JV2dIcjVyRUtXNFQ1bFNvKy9yOW5q?=
 =?utf-8?B?OEI2T3RmYy9XT2Rub3psbXdnMytwSmlUMzdtdW1aLzVMV013SjBrSWw5aDFz?=
 =?utf-8?B?OCtFaU5rQlkzbE5NMXI3QTZ4dVBTWlV3enpIUHl0Q3dzajEwS2J4TWxlWXVu?=
 =?utf-8?B?QnQvbThaTThMTHpUQVZZTVk4aVNnWTlIVHNkVzMvUHpoY0pqekRVV3JzcVpN?=
 =?utf-8?B?azJxMm8wa2QxNG1xN0ZTWmdhb2dlTkJWRHlPZjd1TmI2dTZac1ZvaHZXOWtq?=
 =?utf-8?B?WGFFK2doaFdOVWNaUDlWNU0wbE5pQXQxbkJyTS9naGNGSHNIQ2dtOGJ5OFRz?=
 =?utf-8?B?cFoza0VTbVI5MkF5WmY1SkdLTVZZTmNMc1pLeitOaDZuRFNsK0tZMXVaVjcz?=
 =?utf-8?B?bG5tSVJwTis0dXVOVHNnQ3NLa21MUHB0c0NuVUtxTXpOanFRdG5PUzFSTm50?=
 =?utf-8?B?eG93c0RVRVFRMHJia2J0MHNZeVIrMzFXWWdQMWRNZlpKSC9aSitFVkpCdHo0?=
 =?utf-8?B?b1gyTWoyT0YrYTljTVhXUGl1c0VWT0JNb2thRkozZTZBbStUZ1Qxb0xNV0kr?=
 =?utf-8?B?dXQyS24rWHFrZ1o0OWlXY3k5R1V1MytFM2VJOFpFMVpLSkhkVW5icmZEM3Nq?=
 =?utf-8?B?RDVoTGFpUDlCaFZEZmp0MGJJRm1sYVBsZGZBRk1YVFZRdisyaERSMzU1OWVk?=
 =?utf-8?B?ZWh3NnBvVlhIKzQ2RkpMR1VnMThZcDkyUThHNXhPa1QrQWhQT0JjaWZuVy9M?=
 =?utf-8?B?MW1lM0VpOENNQTkvRVRCaHViOVBTd0VWaUozQ1JrZURPZi9ObGdDZG9mZVE4?=
 =?utf-8?B?TU9vMmk3L0NrZnpsQm9DT2JyUVI0VXZhQ2lKZzA3bFM4b0psUTlXenpTakJG?=
 =?utf-8?B?alU3QUMyNDF1eWUxeUFGVmdrS1hFY003S1ZoRUhiMEIwQXdHTHJRQkNJbURW?=
 =?utf-8?B?eS9tYXVtQXB0SmRLRlNxNHlaV29CK3VyeUE2YlhtNUZuekxoazJQZHd3QWFK?=
 =?utf-8?B?K0VlK2EzRERTVVJpMFFkcURIcWNYaTY0dG42RE1LZmtGTko2QVhGS1pPSkVM?=
 =?utf-8?B?ZjAxdXI3N2FpbEZhLzlVZ3FBQVZMdmUwVUYzdjlPMmVEM2hLeTJPeVpucERC?=
 =?utf-8?B?c2lsSFpZWnV3L0YwTzZaZXk1alF2SW5NZ091SmFHeG5XSTlieWNxWTdiMmZs?=
 =?utf-8?B?RS9zL0s4SEVMRkhIUEliRWRiWFhGWUNhd2JhRFU2aWhoZzNLZGxjS1dReEtF?=
 =?utf-8?B?K3Q1Q1ZRUDhJcXE0aDBuTDN1Y1Ewd3NoK1BRSnh1aDVKL3hKaEZlQ0N1RS9T?=
 =?utf-8?B?dUFGMVBFaDhzeWhCVDhaSisyZ3Z2UHd6NUl4RU1jV3dDekpRaXBHeHUwUitO?=
 =?utf-8?B?NDVaZ2RHZUZBSGRXNkQ5YjloNFIxSi9URUZIeTNaSlFQVnBsbFIwWmIrblNZ?=
 =?utf-8?Q?kAIbFZQCneyIDCLKgdLlYqSSWI5AH38D5BuDwZVTd2GM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc05930-8368-4ed7-9667-08de2e238911
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 02:12:09.2926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FlZRtdjBfsGjgPzpMCwvGXGvFs8zMmyUiU6Rdb9773PMu2wpUmR6UKAF1qzeRy/7srEyOwUA/bZybrWi7nkyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617

`build_assert` relies on the compiler to optimize out its error path.
Functions using it with its arguments must thus always be inlined,
otherwise the error path of `build_assert` might not be optimized out,
triggering a build error.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/sync/refcount.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
index 19236a5bccde..6c7ae8b05a0b 100644
--- a/rust/kernel/sync/refcount.rs
+++ b/rust/kernel/sync/refcount.rs
@@ -23,7 +23,8 @@ impl Refcount {
     /// Construct a new [`Refcount`] from an initial value.
     ///
     /// The initial value should be non-saturated.
-    #[inline]
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
     pub fn new(value: i32) -> Self {
         build_assert!(value >= 0, "initial value saturated");
         // SAFETY: There are no safety requirements for this FFI call.

-- 
2.52.0


