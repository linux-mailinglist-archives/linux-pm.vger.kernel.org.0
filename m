Return-Path: <linux-pm+bounces-38851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA3FC90986
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 03:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB1D3A6D2E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 02:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1AF26ED28;
	Fri, 28 Nov 2025 02:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MMvkkd6h"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6726CE3F;
	Fri, 28 Nov 2025 02:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295926; cv=fail; b=KlKmutag7BYtlcCG7WGx+SymyhKUO0ofEwWs394ZjyhG0DuaXaiETHFfj/u/drtkfYGweGVLGe34NMCa1wzLYw4gZ/EEjL738AfnCmtPkhUCsXH0iFZhKrdnfONxKUEbmGk7yxguOEFThWKJ2pqqOK+IsAeTHsHWquJkqKMElV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295926; c=relaxed/simple;
	bh=cFssExtbUkGZXAtxBcxSqFSWHyMjZGWi92N+j3tA76U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FA6WcqRrhbWrZ3OJ0vgHpDNXZ5BRVR9FbnEPQ3bOOUa3stu6r5lrXnaBd7SL/VctM1nxtvZ7TNzgh1D2DyYfhLNJ3adGQ0c1Ouc5voRyIbN7m8kydM/Uff81PntgYh2Y6X2H/xMBssU2WCKPZMGCTP5PP7B1zcz69gaAqKS8QOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MMvkkd6h; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIuRZpSsCgOBensj/Iz9o7HpM+yLVfaPWEONUXq1dhG2YK2jmqA3v+WoSCGPPm8kErOIOY0XKSn7L78J95ZyduHjgqLbSZsgu9uFLCVjaQQLrkOYS29wNJfH2quNmcCTKKT2oQO+P09A4RG1uhC64xYY4A9gp9xuCI98W21u++oYDtoBWyyEyyw6/GM5PWrTS+p1LZ6WlPXQ8XwnVm7t7YKsfRlCOs+Ij9JSixzha+KpNvEep8RAGMPimaCoBmWkL5RiTu+T/Wgo5p4goh9oLPiDTKcTsasVRfEA7mbCa8/gZpZlb77WhBkCO22UmCpnJ3rr2QqgyF5MqR1MpD1Egg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYIjmbfc2zLoa5LWK2EuzGrhkBxvq/L8BcWUi4+CVik=;
 b=CKV5r+q6bXrlB7mKnoEtIp4Nfk5lSvR1j8rnDLlHh8F0Hb6z+5nWPhI4yU1OBfPb+6O82xeK3gZeBinuKGTnTsqP8F0dOWBnaZoKJdNY+jREx514a5pKjf7b3zqRw5tMOTaJzLl4Z6VJSo18zmFw5MH+nNs7drTV1SaCuyrLohP7xbLhoKyH1v2/eUZlhZa9p65RN5aj95dBCrDJhViw+CtAsF8IntcDGl1wHLT+LKrN5PM/VyqpRzwxRjAfYUORHwc5zZMinfatL22ylJfq4vptAgPb5kTsLzZp+1hNrtVJsZ8H89qvjXK7fmCBLtEHzrOvrJfa2IQnMeLlhSlYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYIjmbfc2zLoa5LWK2EuzGrhkBxvq/L8BcWUi4+CVik=;
 b=MMvkkd6hv64Lv+kx2Snem8ZW2+S2QjP6URyUSFDc90b06Hf13oggKCNGDdZMS4iYWxawsh3vkfB5Q3HmOBrrgMKyP2R71oaXokgzrAfBm8/Ta4/tswUF5nyY7EbG2f16VW/ajq4GwZZuTKspvw8rn7HCGQaaZnECn1UQ33gORNEsftR5c1aN08b7kgSY5JQb8Je5SFsTpbo/JmIhPPQb6WGvOXKbqhnqjv4kUMw4IoOFv98mbCt1TXrpEgZ7s7tsUpmdDW36rrVk8jI4ld3tLBv//dat/0BiACvCnSYRjcyEYcJca6WVETfC6lzjBO6YANFJoP9CAPuz0dEMVWwwQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 02:12:00 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:11:58 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 28 Nov 2025 11:11:38 +0900
Subject: [PATCH v2 2/7] rust: io: always inline functions using
 build_assert with arguments
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-io-build-assert-v2-2-a9ea9ce7d45d@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0182.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 51cf0744-f482-4e48-2e1c-08de2e238283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFBNaDVVWTdtWm85YlBRQ1pQclkwa25Pa1JQcmE1L2tnbmZ2M3Z2K29EU0lZ?=
 =?utf-8?B?YnlWVWpwOHNHYjRia3pnZTI3U1VYNm5ubHFJWm1zZ1Vjb1JwRmpxQ3d4YytE?=
 =?utf-8?B?aVNBRE56MjhSK0t5d25UMnBVUFVBSzlWbSt2KzlZUGo5eFBHcENFdzVKSUxh?=
 =?utf-8?B?R25CdWNBZU90LzdUZjIrTC95a3AxS2Y1UlNJT3FsK0J5cWM3RHM0TG1JV3lw?=
 =?utf-8?B?RWhOTVdza1MvVkRSNlRyclJDN1YzVlFXamNHRGdaWDB1dlRxWWx5RWErazVL?=
 =?utf-8?B?K2FHZC91Wk5pc29QWHE0SmpINGVKWWV4SDlJeDAwQjAxSzFhRWgwNGh6T3Va?=
 =?utf-8?B?SENlNHo4MmNCdnVCQmlWdVdYUE1XRXVxaHg5aGUrY0JZT3l2US9qazZoeGcv?=
 =?utf-8?B?MVF2UDRBL0Y0enhKQVJwL2xWaDNTMWJTQlZTd1JWYXZaa3owOWNtVmJ5TGkz?=
 =?utf-8?B?WUdBTnhIbXdFMjloM0JseTk1enVJM0tQNDVXS3JITURmQ1Bla01rcHN3VHBZ?=
 =?utf-8?B?RHIxOGxucU92Ym9DUFdwNkt0VGZ0bm51TzdQTXhLNGpSYVFNZXFVOVU2ZHp2?=
 =?utf-8?B?TXFpVGNRa25rWHBtZTVuUzJJYzFWdWE5ekdidnRlTFJBSUdaS3FEOVg3bFZ2?=
 =?utf-8?B?WGlXTnovemgwcjkwR1J5ZVB0cEw5cm51ODFNR1F0eUlMYnZTaXQ1SnNXQzk1?=
 =?utf-8?B?T1F2aThOMFJacmNkT2xjVmhXTWdGT05MSVliaGJJdzRxUWdWeXJVT2x5SFlF?=
 =?utf-8?B?K0tySUdMZWQ3bEx4NVdQb04xcDBaNTNWTFVmelhFSzZLdjBGMW9XS0Q3M0E0?=
 =?utf-8?B?eVF6WUt2SUFYK2hxUXBhMnZWa0o4M1NoZ2t5cFNpNURZSkRBVmJMUU5UaXdR?=
 =?utf-8?B?c0dIMVBuSmFyT0dtRjdoVy9OdEJybXJ1em9Ha0wvN3ZnaDJVVWtidVd0a21N?=
 =?utf-8?B?NzZyM3NUZXRteVZ2SzVWZ2xOTUp4anJpZlJvWFBxSVJFWTZBdHJqZG1Ndjgx?=
 =?utf-8?B?RkZ6Y2U2dENHak9YKzFYUGh3dFU0STFUOGxjSTNlYzBSemNWdzJNTWRpMlF1?=
 =?utf-8?B?UHovY25GVnpkNDBSZXdPYWd5WTl6Z1dKQWlNMUo5UmFYZ0FVUFYrUVlhTmpm?=
 =?utf-8?B?TjMyd09pMVIwMDczR1h3ZnZNMnd6SDBkY3lGRHUzK2xYRDYvN2lFekNMdDJv?=
 =?utf-8?B?TkNxd1FPQzJTQWVXSzk4b0tBQ2RFQUhsN2hORm1ONkZBb01TNldPb3k5UTJ0?=
 =?utf-8?B?VVphUGI2U2RtSk5udDZIN3hMVEYra2Q5dWdhd2hlSEVqQ3RNS3pSbXo1YmYr?=
 =?utf-8?B?MVBtS09sTnhKZHVQTVN0S3ZuTWs5cjlrSHh6TUU3Nm5peENua1ZKZ2hrYU1i?=
 =?utf-8?B?Wng5SGZmTWlTRzFzS0hUdkxhRDB5RnlaZmwrVndFcGU5UDFVR0NxcitrelRT?=
 =?utf-8?B?ck5McUlpQXFPUzlmd29lNGh6aGgzMk9EeGxKT0NJYmlSVnVVcVBTU3BSNjli?=
 =?utf-8?B?UFd3K2lDUlBCbkFsWCtrQW9EVW15elQ5a0VwUC9sd1A0RnpLYXRxZERYVzRN?=
 =?utf-8?B?T2s1RytvaHlMcTFRSEhSaVNSRjFMRUtCdjFrTEdVMFpxRU00cW5xTDZxUXFh?=
 =?utf-8?B?NEM4bCtSYUNYOHlXM2owYWpvU2tqVG5TKzdldWVpQ3A2aEtLTk1yV2VIbWQv?=
 =?utf-8?B?ZE5xRzd2K3lGTUdGQkR6aFpkbThGcy8zRTNNWk9iQlJnY09PZ05WVXFINk9I?=
 =?utf-8?B?UHV3K0ZPMVYwZXhGd0N2bjdHZ3YxNDRoOWpHRlQweUwzc2c0d3NKMWk1VXd4?=
 =?utf-8?B?NFo0Y2NpZDYrelM0Q2ZDOFR1dW9xM2Y3U09saFF4ZHNaS0N0WEgwOHF1aEE0?=
 =?utf-8?B?Uzg2TFFyVERHUkpCeEdhMU1sY01hTE9tM29XOW9iRDBPR1VKS24zQ0VJa1Fr?=
 =?utf-8?B?ZEFKWDd1K1puU0o2RDZXSTN0Z2pDWTBRalppTGs2bmx4dEJ2T1U1UTRxSVlM?=
 =?utf-8?Q?j0jy7ckXrmifjJaayhaO7nIPJbs6KU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajlzbnJQZ3pOdTZ3WVFrN3hWdTc4d0ZGbk5Md1lWRFlHNnE4OXNUdzVnWFBK?=
 =?utf-8?B?cmNCYkgwMldmdW8yOG14ZCtuR2l4M0JWdEVxWFZNRUQveU9MM3kzRXdzWVBY?=
 =?utf-8?B?K2RkU21xb3RxbkxlV1kwT2h3Zi95QkFIUGxsWUNmVkNRYTZYTVptdFJkTWpu?=
 =?utf-8?B?R3FML1krRUhseTFCd29lZWpGeFVDRENJalhHT0pxOERYbnZZQmppTGlKWVJ4?=
 =?utf-8?B?dG5qVHBkQ2lsc0JwWU11a2p0QTM5VXZPdEFkNWVsbGp3SUIzcHd4bTl3anQx?=
 =?utf-8?B?OFRLR2lnKzFLSE5HYVpoVTBnOWRwUWNaV28yM3loK2JHNmd5TnkzellEVVJs?=
 =?utf-8?B?VVZJWDZRQ2VkSXg5SUJ6V3dGQ3lDVk4zQ3ZFK0UrczJzV01PUThVU203eVN6?=
 =?utf-8?B?V3RDWThhWHVoVUc3MjZ6SjB6dStSOGgxZ0lkSThSNmE2MTdmR1JCZGRhQmlG?=
 =?utf-8?B?NWpCSHprcjAzMVNtcUlQd2JTS2VtTStrbm9vQWxtTmQ1cWZUNHVCdmV0WVFF?=
 =?utf-8?B?dkZQeW5nR1VtZlFlTXpnOTM2Y2ZGV0tVTllBcmtPWGRwT1BJQzJVaFQ3QVlI?=
 =?utf-8?B?OE4zcE0xQmkwUFNNT0gxODVza0F0K1JUa240YjBHNWlkQy9xeVQ0VEwwQzZr?=
 =?utf-8?B?VTlSaDF6QlF4Szkzc1hRY3BJb0VnWURLOWt2U1VEWHFncVZQYVp2QVNZWWRQ?=
 =?utf-8?B?dktWQnJxRTZWd0dTOGl0M3Q3aTNRNnliVU5keGxSVHZzdUErVytXMXo2TTBs?=
 =?utf-8?B?Um1YTk1wd1pPRU9qU04wV1hlZ2hsYU02R2duMnJjY3VoeGowZitjWnl0dlNU?=
 =?utf-8?B?c2p2ZjJHNmgvZ1Zja3JyS1B5WEcrK3hXdUFBM0N4VXR6VVdia1N0aTlGcHh4?=
 =?utf-8?B?My9WcXhkYkpoU2ZEWmFnbWpCTUl3WlRGRDhOeUZXUFpQb2dmNTBsakhuNUlt?=
 =?utf-8?B?MUtyOGJWU081K3dkUmRwSUhpc1hhZUJxRGVRQTNFcVdQWThBdkFnNllWUlcz?=
 =?utf-8?B?NUN2Z283TWtNMnlMVkNFOGNJZXJPOURsSVU2Z21SVThNMklBd1pXaTBucUxD?=
 =?utf-8?B?NDJkV2F6Vy9hU0doMktWZ05GN3pHcjkwTzBRZ0ZOT2R3RFl0QjVKeDBFSWFy?=
 =?utf-8?B?YUhkZjRxMFBRNHJKYTV0dmpHWHpURDM5TFlXOWxmYm91RWl0bFpHWG9oZVdk?=
 =?utf-8?B?NXo0L2NxbXFkd1ZPVjhpampaNjc1aEhkb3BCUWpUMXgxbnBIYVI5cnRwNk9I?=
 =?utf-8?B?ZWU3OXdzaWNGaEZ1QzRLZHNhbnFGZk9TSWN5VUhGZTcyUlR4Y2lYUEIrWWVT?=
 =?utf-8?B?YjdzbXN3ckhXcXJEVzloeTk5UVVkd3FsUUVxWk0yVU1iOExRd1h5d2lPcUk4?=
 =?utf-8?B?eEtYZHVHRi9Ua1JOMTlNMWpLai9qczhEck5uaytOb3lwdllJN3NmK0d6MUtF?=
 =?utf-8?B?aVVxY0FiWnpMZU1mT2lBTU5reW9sZ2FHYzJRVzlPTWpvcU5Zdm5UL2NzTE5v?=
 =?utf-8?B?OU16M3hzUnk3TFBFQmRaUFl0cE5nWFhaR2I1bWdQRFdxT2Z2VmhsdmRwZVJs?=
 =?utf-8?B?ODZOcTBxMm1QNFJFZUFCQ0lmSVZxb0s4WTRiQkhJYWxndEsrZ21tcUlyYXlk?=
 =?utf-8?B?UkFoYkRNY2FDZ0pyUjFoaUxFRHMxTTRzcDdZUmd5NUNiajFIUnB1QnQwZkZu?=
 =?utf-8?B?c1FMc2d4ajhveFFLczNockVaNEM3MnBqWmJNOEprTzl0bzAxMjcxMHNyVXpF?=
 =?utf-8?B?dHI2dllFS3dsc2NGSSs2VFQ3ZUJJVFdrYXhsZkI5ZVgvREV3Vk56QmtMSHU1?=
 =?utf-8?B?Y2d6Zmo2YnZrb0tBQzVVZTFYcTNYOXVERko2VVRlUmVlYjRzZzBPZHdlUEQr?=
 =?utf-8?B?YUJwdUlDeWg4KzJBZnJjb0RvNHBWMXp1SEsxbkdTQWNHcDFrTmJ2SW4zbnNt?=
 =?utf-8?B?bEc3VU10R1RibkMzWkhOWmJaN2RMMlhzY0NtY3VVTCtMVWtWdSszcTBCckZ0?=
 =?utf-8?B?Y3VBQnhZUGtBS1pHemVQSUtDZzhKTXg4T0dlL1dXbFlzcWJOMlFrbDBvdDM5?=
 =?utf-8?B?NklvdlRIYlJtTk1hbjBvQnJELzJ1dzdOSEZrK2laT3M1VThzeHhrbTNUZE0w?=
 =?utf-8?B?cWRYdlFGeTJGV294RWVmS250NUptNWQ5Zk5SY0lRalFNUlNmc3dIbVZjdjhF?=
 =?utf-8?Q?4NfRCmH5werhc9B0MdGyW2OjDm993UHqC/bgR/CZMPuk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cf0744-f482-4e48-2e1c-08de2e238283
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 02:11:58.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKIS0/UVpYWw9YjMgKFEkw5z5M+ZuiZDw1THhSV/4Jp1CaDfKpwdeROhUaNrzvgWYbJC+e234mk9w8HoF8SyKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617

`build_assert` relies on the compiler to optimize out its error path.
Functions using it with its arguments must thus always be inlined,
otherwise the error path of `build_assert` might not be optimized out,
triggering a build error.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io.rs          | 9 ++++++---
 rust/kernel/io/resource.rs | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index ee182b0b5452..ccdd394099cb 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -120,7 +120,8 @@ macro_rules! define_read {
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
         /// time, the build will fail.
         $(#[$attr])*
-        #[inline]
+        // Always inline to optimize out error path of `io_addr_assert`.
+        #[inline(always)]
         pub fn $name(&self, offset: usize) -> $type_name {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
@@ -149,7 +150,8 @@ macro_rules! define_write {
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
         /// time, the build will fail.
         $(#[$attr])*
-        #[inline]
+        // Always inline to optimize out error path of `io_addr_assert`.
+        #[inline(always)]
         pub fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
@@ -217,7 +219,8 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
         self.addr().checked_add(offset).ok_or(EINVAL)
     }
 
-    #[inline]
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
     fn io_addr_assert<U>(&self, offset: usize) -> usize {
         build_assert!(Self::offset_valid::<U>(offset, SIZE));
 
diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
index bea3ee0ed87b..d9851923562c 100644
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -223,6 +223,8 @@ impl Flags {
     /// Resource represents a memory region that must be ioremaped using `ioremap_np`.
     pub const IORESOURCE_MEM_NONPOSTED: Flags = Flags::new(bindings::IORESOURCE_MEM_NONPOSTED);
 
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
     const fn new(value: u32) -> Self {
         crate::build_assert!(value as u64 <= c_ulong::MAX as u64);
         Flags(value as c_ulong)

-- 
2.52.0


