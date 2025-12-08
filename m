Return-Path: <linux-pm+bounces-39279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E70BCABDD3
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 03:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 746673009F86
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 02:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD57454654;
	Mon,  8 Dec 2025 02:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FZPMefvA"
X-Original-To: linux-pm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEDC3BB4A;
	Mon,  8 Dec 2025 02:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765162035; cv=fail; b=cwp6EwH0xF+woZSs1TsclD5m5yKpGLN3G43zbQv5IODsJoGuCQEyTPg3QOMwmWRuTLo9T1DjTFJ3fM+yQWg1Z2y0WmxqubP6pjkcJNbLWH7fa4kB8rRW1NEaRSok/39wGe2SPG8ILOTEX3GFUYFHVRAtorupw5HYd7/lH8PsjPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765162035; c=relaxed/simple;
	bh=9ARlfeso5f8M91X2ome6xSCVPpBqsftrP2cQnV0tpe0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=iY+yzplPWbHSl0ERZ5LJ8G+glXE2ualjSslaLRxMy5/KQVUCLcHYOmKIUfVhUZzq/qvhyqW+A7GiHKgo0lzMl4Zijd9jV0OUS/r+rGYBuyHZCg823mnAK9ihZCcN4Sbf+TXzGErsG77xVOCBS621rugSOmWVeXinFJ5kFDKcobI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FZPMefvA; arc=fail smtp.client-ip=52.101.43.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvW3kruGo6l/greJdgppX1kogIGGd1/IFhc9bgI3IHnK49zFA+Dda6EvKLQ9yNeqCq+CVShXK5EyskN2reCY6jDpoIwqzfGyKvzoRLKuegrYTGJ086h07o3siuZYbpX+3eREe7iI2QLhrihImvcFkHXb3Ra+K3A8BMdSbB9UDItrbAcXHTpX3qlbZp5b+LsUpu7m3V9BtAtBTF9Ome7COqT68+xpQJfltSdmPYsx7SGYX+pYXMZyoOqAJiH0IAMCzDQk5VsB0Tpp6wCX4pDvWBRoELWzVjxau8yQa3iDzJFDsxxIfbQjjHpaJu8mePMG4WjLaG4zUeLzZGppX930Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRZjm7Qthm4Jxdw79ZgQFYQMxMZ1LCTbdJnLKQcbcUI=;
 b=gUR6jfavZYn/gdbSYEIoz0fXrKO/4GVv7w0BGYUY/g6V5w8iDimY+Hry62iuWVBusiyX+1WLwu4vc+OxNREqzcNeIyD7Lhy+qyTTYUx8lF4Ip+B3BgwJaYwagLzdTG2ZrzHUP08bsz5Wyuie76P52KOaaMe0H/mS54CduufBJBzKRBR565Oge96nS00PMaDsjrN2EjBFD5PRmc0N/2a2kl3iz5+RaozerQrEjTAhzJ394kk73wITGEODvZh1miiDUBsUHu3FHmaZ95HfHBhNXCn//6FQ51KLsfRAfRNiQUYQTm5rF/6JFRjU1W8V5hY/1WwksRuVMcAKXDYtQQB8tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRZjm7Qthm4Jxdw79ZgQFYQMxMZ1LCTbdJnLKQcbcUI=;
 b=FZPMefvAyG7ocmLR8zPrIdC2TsbNFn7Dj/FLS9JDDZFyRX2OH8OUyALgrpqTdqVUFHBoN/OCRkF2tUzO0hItn0YPmVjofcfeE9gP3pyl6sOWiNnmyHYeEH3xRa7KO3ruw71km56s45XsXJwUAaywrlF2hTD+KRO+ljWsWcMesA6A3ri4VYYodxnoP6UsQKrqlGAjUX51PYOKWOVsQ9ZaTubo1cEUgrbZhWfobz6FQ6p7huem8RiylngZ30C7lPgeukFjgwnVT7MbK+L6HWVx0jfagE1P4Ekd82WiimoleoXRsdt/y6CHSMvEd4Vib/zkmAyLHWBrq73gxahykExUrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 02:47:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9388.011; Mon, 8 Dec 2025
 02:47:11 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v3 0/7] rust: build_assert: document and fix use with
 function arguments
Date: Mon, 08 Dec 2025 11:46:58 +0900
Message-Id: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACI8NmkC/3XNTQrCMBCG4auUrB3JT0NaV95DXKTJ1A5oI0kNS
 undTbtSxOU78D0zs4SRMLFDNbOImRKFsYTaVcwNdrwgkC/NJJdaCGmAAnQPunqwqUwnUNq0Vnd
 91wjHyuoesafnJp7OpQdKU4iv7UEW6/W/lQUI4LVUppeoG82PYyZPdu/Cja1Ylp9A8wtI4GBbt
 K1D42vtv4BlWd4SwMRO8AAAAA==
X-Change-ID: 20251127-io-build-assert-3579a5bfb81c
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
 linux-pm@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: OS3P286CA0052.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:200::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 4109b5cd-1bb7-401e-d228-08de360415e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1lEdFJHY2MxVHBRSGJiNWJHeklqdFF3b3ZWd3NrdzhjUkw1OWJPSXkxWUpD?=
 =?utf-8?B?ZGVYbUJsM0xrK25oQjdMcllBNmFuVGM2VjUwaVJpUkdHMHVxSUFnMmE4cDZ4?=
 =?utf-8?B?dGM4VndKalNieXh1NU1LcTMxSCtmNlc2T1ErM243ellDMHpBcEFIMitvQlh0?=
 =?utf-8?B?ekFuUGREM1g3eG1YRlJYRUE3amZZRzRFOTloU0lQcmFsYm5nNUFhdzVEdmRO?=
 =?utf-8?B?VTBUaHNnSFc4c01oUGRwczlQRW1VemRCY0VoNjIzaHFOaU9KUTZHRHM3emVS?=
 =?utf-8?B?Z0pQUGQwcjV6ZEZVRjhhMXpoaVowOW4yMVFobDF4UDdNajhtaEhaeVJydk1x?=
 =?utf-8?B?RUMrbDRhUGpGenJucmZ4dWlzUVd2N01OVldrUTlQNlJIUzlFUytKMzJmRXBU?=
 =?utf-8?B?MGxLUUVyZ05kREpZT2dNamJDTzBCY3pyV1R5bGlRczBwNVVLOG12d1FSWlFC?=
 =?utf-8?B?dEQxVGlTQnFCd0FlZ1JIZU5PdFBDOXRmWFdoR3A3a2NkMEhNVnVubEdhSHVN?=
 =?utf-8?B?M1BRcUltVURZV3VkeERtRjhXa1pTdVdVTVhLWUtyaXBPbFpqZEJYYmp4T1o5?=
 =?utf-8?B?ODZRVGNVNmVzbXBUM2xyK3QzanRBWGZ3QllYTHUvcHFiQ01MbkRvNWN3bmkw?=
 =?utf-8?B?ZVlRNjYzWU1rdzczVlozcVMxRkRnMVArUFphSWo1NGRpakN3NGR2UVRNWW5W?=
 =?utf-8?B?UGtLWFVDcStPZFlPeDcvUmZQTHVLUktXWjJJVmQzYXVXMWtacW5lc0dEWlZp?=
 =?utf-8?B?VTQxMWZ1dzhLS3FJSUdqQjVGRnlMeVE2NndTS3FVYUJDNWlRNnJHRmVab2Fq?=
 =?utf-8?B?ZUl1YTVpOXlsT2Yxc01rS09kYjBPWjBHY3VoU3RYWmtmMG5sSFM4bytMUTRB?=
 =?utf-8?B?QU1MazUwd3h4TkdOYWhyWXB5TVFmYXVpNXYrMmJ3NFJxdi9YYnRxUXMwbndR?=
 =?utf-8?B?UjFJMzZNQnJNaEV4N0hMVUM5MFJXZnVQcUcyVHFUdC8vc1RPUU1zdmRnOG1t?=
 =?utf-8?B?aHBXQ3B5ZkVpQjQxM1JmTElsVy8wSks4aHZnb3MxcFViV3E2V0VWK01LWldU?=
 =?utf-8?B?M3A5YlJaMVJXWTZZQTdRQ0taRUIyOTRzUDRyK25rRWsrdGI1Z01BQXBlc2Ji?=
 =?utf-8?B?SStlTVhSQW1DUXpVUVZabkxjcUZPNmhSN1ZyUzhnS2NHb0pNOC9zSjcybDhu?=
 =?utf-8?B?WlErUXJzbzdwdS8ycWtmbU1idWliaGwyUzZzYXlnVjRnemdCWko4V0xXOU9F?=
 =?utf-8?B?V20vVXZKRDJ6aEptU2JWK2xpYWZvUDFDazdlOFJEbmtuN29MQktFZGVxZWds?=
 =?utf-8?B?TmpJUUY3V1hiclZ6cFVhcUVlT0kvVjdWNklGdlQrdkZFNjg0Skl2ZUY3ajRY?=
 =?utf-8?B?eGNheEhlVHhPZlhPQnpBbFh2SFgzWU1HaC9wQmkwWEpUZVFzYTAzb1ZMd2ZD?=
 =?utf-8?B?WERldncrUnhrU2VSQ0R0Q2NGUTcwajhkK0wyS1lXcjhoMytDVnFDQXVSbnp6?=
 =?utf-8?B?c3M4bWRuZ2dGVjk2MmFjTjlJeEh4WEtIc2kwc3RvQUZmNnZoNjk4cmNvOHpW?=
 =?utf-8?B?MkxEUTFaN0N1bnJnajhYOXRPWlllTHdyZnkzaUVsTncvYTB2clEraW5vL0xu?=
 =?utf-8?B?eU9aUDkwdWtjbzBxclg3a1N2ZERkaWlUK1BDZ2dvTms1ZXk3dXJpRVFXa3BN?=
 =?utf-8?B?c210T2ZWdlRFeXRlRXVGQ085UXpjL3JXQ2QwTjNnL2g5dktOdmFuWWdhc0FV?=
 =?utf-8?B?bWV2eG5pM01CRTJ1OWZDckhlSXBHZ3RPNTB6QkNHRHdXNy9iNjE5SU5XWHRO?=
 =?utf-8?B?YnpuTmtLZGNJQXRVdGNVU0Nnc1VaRGlvNm9WejFBTlJqajN2dTVWLzVqRzk0?=
 =?utf-8?B?Ukp0eXpoQnUvNnpVTVZQWVlpUTVua0twcWJQbGdzTjhNb01UOEt6b0plY0pB?=
 =?utf-8?B?MVoxNy9TQmhqdDFZMVFqZ09uUGxZQzg4bE9sdnRodEFnUTdmdUtMVnJ1VG5v?=
 =?utf-8?B?Rkw0anFQTmc0VU9zZVB4cVluQkR4UDBxcDA2TTlzWUU1SC82WUsrN0R1SkUr?=
 =?utf-8?Q?hKkoCN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0Myd2JYL09Cd3ZUcDRRcGhZeUNxb1l5RnZMUllkQVRXZXV3aFBBNm85SkRU?=
 =?utf-8?B?YWVwUzg3UkFIVmpuS0duOFNpQk5zNnhlcHR2aEJlRmluUUJIdlQ1R3BCM0ZP?=
 =?utf-8?B?Z0NFLzU3TlNLcDE2MS9NWHVWMUVuUG9RTU1sd2NNU2RidGJFbmVHLysxTHFn?=
 =?utf-8?B?dGM2TGtmSU1oUGRxNW1WNzRocGdDbHFjMWdoU3pKUjh0cEpGR05Dd1BTdUl0?=
 =?utf-8?B?a2ExdWJBaHpnbGJHdS81dUVMbFI0YXh2bDZEYnM5eW1qVmdUTHRkTFkzcDNX?=
 =?utf-8?B?dzgzT2VHQk5vRCs2Vkx4dlY1VHcra3ZxQU1JK1RpaXcwdnNPTXU3WHhkNFVZ?=
 =?utf-8?B?YU9JWDR1STk3L3g1T3p3Z1grYytlTjRPQ21jUDF2YzAzT2IzUmEycG4zTTdC?=
 =?utf-8?B?SXRqLzJBQll5TWI0akdZSVpacUhzMWMvWG9JZWtNVGRJaEdLSkFyREo5WDR2?=
 =?utf-8?B?NlppT2N1VEpPQnBrWkNMTVRGcnpLM2RIWHdENnlVamVYWU5PcDBuaXh1L1BP?=
 =?utf-8?B?a3Q1d2o5eUlHWUZRZ0E2NkFLejQzQ3V1V0ozdHZEZFYvK1B6cnhmTWFSMzZ4?=
 =?utf-8?B?cDBDRHhxNkJCUnhoY0RmNkNYaDBCSmFRYk5rV0VnY1o1dTJQaVphRXIwK290?=
 =?utf-8?B?TjRhMmtjOEF2eTVKbTBmM0JMbHZPUVFwVjNWQS9NZVpYSG5vdWRRZXFuRFhI?=
 =?utf-8?B?SHdjaUphR1kvcWxrb2VkT1AyVXA3S200aC8veUloeFJva09KUTdGYUFwRXRS?=
 =?utf-8?B?ODE0Z2JEUUJHU0NLbHJKd2ladDk4NzdLeVJ0MHh3dE1OSFQ5MlhpRVl5dW9p?=
 =?utf-8?B?QTJlMXkzQ0VUWWRpd09nVm5GcFV5S3l1M2NibUgrSWI5K05nZHRheGpvaFhE?=
 =?utf-8?B?c1RyVmppMVBaRWk0WDJsUVBSenMvMFlvWW05bmpIMUNwZGYyWE9rQUNNa3VI?=
 =?utf-8?B?VjZwWlhZS0wrL3dJV0ltem9BUk9nUGZ2cFJhSmdDQlkvN3h6Ym1zYWJ1UnR3?=
 =?utf-8?B?UFVIU2JSdGNDdHNLL1Fqa0U0RVJIV3hzeE1oN3hzWWZQR2FONmZPZUY4cHln?=
 =?utf-8?B?eG55RlkrSTg4RzRxZnZtdVh1THQvT2hhd2tTVldmeGM4Q1VEa0c2MC9BcTVN?=
 =?utf-8?B?MGtiVzB0ck5PNmUwRDlMc0E4ZERzMTIrZnluOFNZRXUxNk1wYTgzRG9uSG8z?=
 =?utf-8?B?eG1GREdpWG5URmdSdE5pNW1aZXl1MHVJZlRRRTNPYXhkempkZmdrV25mU0pO?=
 =?utf-8?B?aGlyT1N3T3o4SVl5NXFncnMwNVVCcUh2QUJ0SnVrc3pFUGVCdVgvUEhQZ0Zv?=
 =?utf-8?B?ejFsa0RrRnhLZlBHYUp2L096NVZwRG4xcUszaWZTQzZ0SDFhL2JhU0V1djk4?=
 =?utf-8?B?Zjd5aXhENHo1RU9qbUVEdUFua0c2Yk5LYk9tMHBRTUZWYUQxWEtpUk9WNS9z?=
 =?utf-8?B?eDZma3c4c3JWcGZWMFJmeVk0SGNkYVJrZ0VYRE1ocUNXSkhmdzhGQjJ1Y2VL?=
 =?utf-8?B?M284djFyU0VKVmNXMjlmZE01K1BmS1NhNytQdHQ0RE5ETlE2dDREdkxSOHFX?=
 =?utf-8?B?Qi84MHV2QUpoSmxWSlNhNmZBVU1LM25mK2JCdVJWTEZwTWxuazJkajNoRURz?=
 =?utf-8?B?VDd3VExNVUFiK1ZEMk1CdHFXSmlMNTg1Tjk0TTN6SmJYaDJlbk81cGpEeklR?=
 =?utf-8?B?alpBRGRVR1JzbTl2YVhqcnZTeFIvMThEUldLZ3RQS0QzNzNSVUtqcjZ3TEpS?=
 =?utf-8?B?a1lWWUw5ei92OWljSHVhamJhazFHUHk4dHRQc3B0MjE1dHBhckJMS1liOC9M?=
 =?utf-8?B?YUQzUVVwS3RuMlhBdFJVQlVEZ21rTk43UkQ5dkxBQ01kMUNBQTBoa1VXTDJS?=
 =?utf-8?B?dy9ac25JZnllTWl1b1NMejY5ejN1Q010UVlOSUxsZlRFVXRIdlpxcWlCTlBa?=
 =?utf-8?B?eHB2Y1d1dXV5UkJDU3JSNlNWNC8rMDNhYjQ3SUpPUk5KVzFWUWw0S1dDN3dn?=
 =?utf-8?B?anFvUDdkZFBnMWtkT1pXRndrNmZGTzdReUFxNFdxV1AxVHlMYzdKZlh4VDEr?=
 =?utf-8?B?RUptS1NwYjlZSXBaeldJRkZreElXaGxhdTZ1dzBpSVJKRkVaTnVBcWdTVHhQ?=
 =?utf-8?B?NTZYSGZtbEtGNVluS2pDYmx0VkFIWEVpVzVsNXhvZG1aWFByR20yTTQvZW1Q?=
 =?utf-8?Q?no+hPFxIVZPCGtCBm0cTpqSYKZd1aCd1XTUfplHMvAaC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4109b5cd-1bb7-401e-d228-08de360415e0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 02:47:11.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0IyyauT07huZ/WYVr6n7wHcIgiFTL0VW5hnIrjLR+D/mMP4s27hxkXwtvYfruactedLumXDEh6jWzYeAvF47g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347

`build_assert` relies on the compiler to optimize out its error path,
lest build fails with the dreaded error:

    ERROR: modpost: "rust_build_error" [path/to/module.ko] undefined!

It has been observed that very trivial code performing I/O accesses
(sometimes even using an immediate value) would seemingly randomly fail
with this error whenever `CLIPPY=1` was set. The same behavior was also
observed until different, very similar conditions [1][2].

The cause, as pointed out by Gary Guo [3], appears to be that the
failing function is eventually using `build_assert` with its argument,
but is only annotated with `#[inline]`. This gives the compiler freedom
to not inline the function, which it notably did when Clippy was active,
triggering the error.

The fix is to annotate functions passing their argument to
`build_assert` with `#[inline(always)]`, telling the compiler to be as
aggressive as possible with their inlining. This is also the correct
behavior as inlining is mandatory for correct behavior in these cases.

This series fixes all possible points of failure in the kernel crate,
and adds documentation to `build_assert` explaining how to properly
inline functions for which this behavior may arise.

[1] https://lore.kernel.org/all/DEEUYUOAEZU3.1J1HM2YQ10EX1@nvidia.com/
[2] https://lore.kernel.org/all/A1A280D4-836E-4D75-863E-30B1C276C80C@collabora.com/
[3] https://lore.kernel.org/all/20251121143008.2f5acc33.gary@garyguo.net/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v3:
- Add "Fixes:" tags.
- CC stable on fixup patches.
- Link to v2: https://patch.msgid.link/20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com

Changes in v2:
- Turn into a series and address other similar cases in the kernel crate.
- Link to v1: https://patch.msgid.link/20251127-io-build-assert-v1-1-04237f2e5850@nvidia.com

---
Alexandre Courbot (7):
      rust: build_assert: add instructions for use with function arguments
      rust: io: always inline functions using build_assert with arguments
      rust: cpufreq: always inline functions using build_assert with arguments
      rust: bits: always inline functions using build_assert with arguments
      rust: sync: refcount: always inline functions using build_assert with arguments
      rust: irq: always inline functions using build_assert with arguments
      rust: num: bounded: add missing comment for always inlined function

 rust/kernel/bits.rs          | 6 ++++--
 rust/kernel/build_assert.rs  | 7 ++++++-
 rust/kernel/cpufreq.rs       | 2 ++
 rust/kernel/io.rs            | 9 ++++++---
 rust/kernel/io/resource.rs   | 2 ++
 rust/kernel/irq/flags.rs     | 2 ++
 rust/kernel/num/bounded.rs   | 1 +
 rust/kernel/sync/refcount.rs | 3 ++-
 8 files changed, 25 insertions(+), 7 deletions(-)
---
base-commit: ba65a4e7120a616d9c592750d9147f6dcafedffa
change-id: 20251127-io-build-assert-3579a5bfb81c

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


