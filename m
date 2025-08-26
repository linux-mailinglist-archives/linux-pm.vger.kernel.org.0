Return-Path: <linux-pm+bounces-33063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728DEB351D1
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 04:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249075E7224
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 02:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1295D274FC1;
	Tue, 26 Aug 2025 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K5P3mvz7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FA314BFA2;
	Tue, 26 Aug 2025 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756176103; cv=fail; b=JwWw4H1Asv28zyEebYBs2d0eelcVAOiO9lGID+XhoZrdRttnPFmDXeVmiqSt+VR7kNjoC9nH4eiSOXH3sP2hESYguqRct2LBYJbCSmBKoBweJmUMfVdEHthFoFywAtZOcQWhJWFRRh1k9AO+JOmfgv5LtAhF9H5KVHw65sMqaYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756176103; c=relaxed/simple;
	bh=i5s5LfhTuGgrzFuiTOnfWagWkzb/WYSRTleSaoiFL14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fqi3YowsXHzMYviAviwoJkAItDbSNh1pql6rUvMeUOR/745pBKHBfUloEYsxb2xK7cFWpxMeqyioOxcO7Ac6CDjrsLGgNZtHFpj+/143DiXF8FyoeGXB/dkmrQmeaTWr+m8ZAvRKKuAw4ZQLmfy0DgQisQzpnOJM0m9xJwf4g0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K5P3mvz7; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZifpVYotqPXdXIZla15GRK1PaVDN8b17UuvWOM7bbrWVQqbZH8yn+7UfCGw2q7ptKyx9u1InTI2LlaSq6VNrSKctSkXbeKXQKIyiZc3PliKa22IviA9bw68iGffzLL+yNV+rfx963hsaD1e4IVG8Fxeci0XFIsy0ZpDjxZYytVAfjwg6qbL9HtdbNZLHlyiXNAKhWIsPnyskiGQf+OhtWuobA+J3huZR5c7dSrt0uUmmD1yEK35otjIktCPqc5BrQwWb3dbPCok+9+STkfSkzyJkMz4W2K6ewqhbeG0HXYZNEmW2O9gD879NlFehJqANI0rgHRF/NO19lhUi5bc4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTSUGbIbw5mLCLEUrcrxicSjW7NwwUCPYaZJNlQHMuM=;
 b=PeBFeiMyL2lMVD/wEi7K/nuiHl/q6xgEallA/QL5Mh6+HpMnCtiz0CuMQ1LFH36hs3Fz6yFU4vTiOexpzTIGsp/koQGrhjBIBDXyQzi3E47YE9ZJjGzvjQ9yG13MatTlklNqpj3gI704NAHIp3bUIsCAr9s7UogVBMgU5BOq6W7GkdPYMnz+EUz/8oPVPE0yq5ZI3BPIK2sAKM6qxW/E6eWOua0V+8DukxTgT/TKM4KpmQuuDubXvsa09gSAswk8iqqqVpSWdeLY4mP+4J8xb6d4omEauvyrHRJJcRT98OEdp7TrJdny5vageZ3cW4TqfqbErVtvbEa6yGrcFcwGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTSUGbIbw5mLCLEUrcrxicSjW7NwwUCPYaZJNlQHMuM=;
 b=K5P3mvz7H1IkGFu6QFMqaY8KoP3XAQ6Y5TKV8E36IiXWydG20ajZvKtKe9Aa7RVGC/PD5lZX+514OVudsJzd37ZTZL4wBvuKJTnH4niAOTh/YQrgAp+WLkpiW78qSeU2aSqgZLRT3zSqV30Fl8l3tXK3Kq4Vg9UbWoegEs8o5OJbTLAkQF5DDRd00Rdaedj5WoUY5s80ReemVD70IsGrfbmf6gQyPjw40s8fuWu3VsS7FaoTPpBY5Qb6NdbaNOVjbb5dRkW+El0op/rf9i7vpTuqYux4pq84YhHwNCSQpE3O2ZfeEUnkqpv4bmDE2i/FGJMoCQvKUWXFGMICJKOR5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 SJ2PR12MB8805.namprd12.prod.outlook.com (2603:10b6:a03:4d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 02:41:36 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 02:41:36 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] ARM: tegra: add SOCTHERM support on Tegra114
Date: Tue, 26 Aug 2025 11:41:33 +0900
Message-ID: <3372886.aeNJFYEL58@senjougahara>
In-Reply-To: <20250825104026.127911-7-clamor95@gmail.com>
References:
 <20250825104026.127911-1-clamor95@gmail.com>
 <20250825104026.127911-7-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP301CA0040.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::12) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|SJ2PR12MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: 71bb0fc0-1a06-4f4c-66df-08dde44a139b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkZsUG1RaVJkUnJqSG12NHhBOHEveGlsQ3JKT253WlcxNGdLd3NodlIrNUdU?=
 =?utf-8?B?dnVRRHJQdnUvSURxTjE3Q3JzaDBCWE50UlUvc0VxMGl6aFBORmoreVB2VDhN?=
 =?utf-8?B?RGo4eDZmOUtRd2tuaHNQL3J2anNhU0t6alZPVUNaTXEvVkgwLzZKSHdPQVRM?=
 =?utf-8?B?TGJ3ZVpvRFdxdlU0QlNsZFo3V2VvQXBaY1d3b1RzWHZaY0JpMjkyRTgyN1Mr?=
 =?utf-8?B?OVBoWTlqdEx2Vk1BajAwUkxuQW5keThlMHlSMXJ5Z2NKbXNkTkcxSVFVMjFE?=
 =?utf-8?B?T2lXanJSRzU1RG1Iem8vNXgvdHFEWjNhZ3MrNUxqck1hek5qNzBCejBiZ0sv?=
 =?utf-8?B?STg2NDhGbCs0cUU1WDZZdlpBMlNVWlgzWFNZQUxadlV4M1M4Z1B6cUxEMjBY?=
 =?utf-8?B?eFpMZTRQYkJ6Y2NwSVVBYkQ1M3BDc1JidmtvQ3MzMXIwb2t0N0JXYkE1UFJQ?=
 =?utf-8?B?UFNpdUgvaGpFdnFqL3RnKzFKK0ZaVmNlSWlRcFQ2TFlqQTlQNGQvYjVzR0Vy?=
 =?utf-8?B?OWFkU1NVUjgyK0hyU1hBV2J5NTFFTWVESlN0WExQRTdrSnBZaVpqekxpcm5h?=
 =?utf-8?B?MGM5RWQrdzZldlNFT3E2d1RWU1ZnNkhwbmxQQlhJSngrNDJNWjNYbVZVb1Bx?=
 =?utf-8?B?Ujh3TW1ZSURRTDl0cHdLQ3ZqUXBtSHRDOElsMmF6UnU1RVNyeE8wU0QxMW1i?=
 =?utf-8?B?TGg0MHc1T211NUFlQy9ja0Vkamt4UTlGaWQyaDRubEJRd0dxeEJqR2VzR1dr?=
 =?utf-8?B?cjZRRnA5anFQZ1o4VmRvM3dXYjFTd2kzZjk0eW4xbGdHMzQ1aTQ2bzZqSWhl?=
 =?utf-8?B?QUxyN3h0R1dyR2RhbnI5emdmUXpxcklGWFQ1dnNUaTZBNkxrOW5sY2NBN1FO?=
 =?utf-8?B?SkdvSzI3UDZPZlhESmZwK2JkVFhYTkY4V1ZPKytlS2NJN3VySGp3bVpoeWJr?=
 =?utf-8?B?eUpIMVByaFlZU2lqaVN6aGYyUjZPK3ltKzFRbkJsWmFHUkNCZTFpdU1oUXYr?=
 =?utf-8?B?aFp6WTh3YS8renpuKzI5OEx6eEJtRFNESHVKalN0MC9GYm44U05hVFduQkN6?=
 =?utf-8?B?ZHZ3OUVoa05YOWdIRDRMUSt3cXFaTmUwbjFtZDl3Uk5ZWXo5Ujd2cGxjdjhY?=
 =?utf-8?B?SlE3YmJ4cjU5VWJ3WFVqYUJRM1kwbkNEUnZGRURocmtMWUt1cWkzZEg2WFdQ?=
 =?utf-8?B?VjViT3lqUE94VFh0eWN0NnlWUForSDhxR3kwakYrOERlZU93VFVkZGlMcDdy?=
 =?utf-8?B?VGExRXgxTDFqa05pY3pySFRLdG5rQld3ZnlIYktGbnhBTXRteTJBMzFOa1Vq?=
 =?utf-8?B?M3h4T3J1QlJETUVCc0twTWlZamtYTm9CcWlTbjlzSjd0OHAwcWJCRXdnd3k3?=
 =?utf-8?B?TXFVNEhyTUdrNGp2RnozYzNrenBuZmpxRXQxdVhOS0pUNHNjTmxXZkJ4dW9i?=
 =?utf-8?B?TW1XdTJNWm15ZU1QY1VST2pQMWEvd08rREFSajl5RWpyQ1g1UU03aFF6UG1w?=
 =?utf-8?B?MHpKUVJNRWVKUG4rUWtiY0RTOXFzV2N3SHUxd0ZOTzlYMEF1SkJoeUUyOFc3?=
 =?utf-8?B?QmJvU2NDSHVDcjIwU0Y1LzJrM2w1UWUyS3BmVTNRL0FoVFo5Q0Z2WTYxYXBr?=
 =?utf-8?B?WVFPTDQwanJSRnZ5R0lyVzZJdXRwRVh6RXphaVFDZzNWODU4clFuREhuZkFq?=
 =?utf-8?B?RENhbG5aS0JFeUl2cWlqdTU4MDhNRldZK0F3c3lCQzNBQzAxSTU2TkdrYXdR?=
 =?utf-8?B?RGRmdFNJQ3ErbSt3OUdXNU83OUFKK0dLamFqRXEyVVFWMWN5NVZwcStlTFpF?=
 =?utf-8?B?aEdYWVk0N2phSDN4dU9lRC9HRXdrL2N4UU1STnY4NXhFajRnWituWGIwTkRR?=
 =?utf-8?B?YVZrMHIzWVdZMUhLMkZLZzFpbk1qQlJua3d3WDhJa05mb2hQdExZVUYzZUJ6?=
 =?utf-8?B?RTNzUmtOTE15RFYvdy9YR2s4YWo3b1ltaXlHNGNZUXpPN3ViV2lNNXlwMWY2?=
 =?utf-8?B?OVBydzg2RDRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXZGcmhQZDhlSlN5dnN1UWJLT1RtbXhJRmR2QUpYVWNKR3BsM25CYUYzT2dE?=
 =?utf-8?B?RDRQWmRVdUlPdVNOSTBmUUZBajU0WTk1a0RKdlRxdisxcXkvMVRuNEh5N1Nu?=
 =?utf-8?B?dkQxbmpWRkF2N25ad3JVSWRrTGwrQzZ5WjFsbTViQ0g5ZDlUYUhRbXAzTjZ0?=
 =?utf-8?B?QWxIQUF6cDdpTWFJWmRtbndqS000Qk0rOHl1OUpPTk82SW1iRjFuZ2lGQysv?=
 =?utf-8?B?K2NTSFFmb3lRZHhPdGlOU0lWZUU4cUVOQXRqeTZTRzAzd3NGWUpLOTJRb3gy?=
 =?utf-8?B?Y1l2RUVQRjc5a0dsMkRGTWgwRUxXclpBN0VZTFlVSmNwTHROUFVXdzJ5ZzNr?=
 =?utf-8?B?S3lMMUJiZWEwSE5oeXZZc29hS1hEcHdRQkg1amEzWThUSzBtcTdOVmFFTThm?=
 =?utf-8?B?OC9LVUpsbXh2TE1ZSUVlNWhxT3MwTjNoMmlIaTBUMEgzbGRocVJ4dGEyRkhi?=
 =?utf-8?B?cmhHeWV6cXR4SWJmZjAySnNYV0FRVDZvcnhVV2ZJWVV3YUJYMWhzUzc0bDFS?=
 =?utf-8?B?cFV5eXJGR1YwdktQSzZ5bkVJK0hJa1BBbmcrOVlUWHZVMFhSMXFvSXlYTnFm?=
 =?utf-8?B?WXBnOTNLV0dTUldQRFlZb2hRMjZKOWtBeHZHb3JXOFpqRGRQRnRGeFM1ZzEv?=
 =?utf-8?B?ODFJMGNwaHAybnVFYUYxZU9ocHJaRDE2Z0xLVlBxM1FxME51U0ozcThCRUVP?=
 =?utf-8?B?T0hFdkVUOCtFNWd0KzE5NkVwZG1KN1ZqME5ndFROVXlUMzVEUzMyQXhMMHI5?=
 =?utf-8?B?K1hBTjVrSGlaNlAzS2ljdjlJT3FhYUtRcStnRUNJT0FjbDlEMFlYUjVld25j?=
 =?utf-8?B?bnVUaVJHVFJzQmwySjVtdURmaEYxdHNpNUpYM0E5MUI0Z1NGQWxOc3E5bWpV?=
 =?utf-8?B?ck1Ub1JSSk1PK3hPTHc0WUF1R0IzQmptRnRaSU1LdGJac2Zxakh6S2ptVEJh?=
 =?utf-8?B?YUhjQ1BtQzNFbytoc1VwbjF1d3MxSnVMOHVmczdBS3ZYa00yNjg1T2hZWDVJ?=
 =?utf-8?B?M0g3cXVLUHpPZDFuMForRnVPVDFxZk5WU0UvUExYNlkxMHhVYnBZUTFQWTVr?=
 =?utf-8?B?NWFwbTVMVTFSbERsRXk3UmFKZnBuODlLL0ZsT0ZRTzNpZFU1ekJZUWJEbnNx?=
 =?utf-8?B?THMzZzlCRzJvbXNCWVVWd2xROFJXa2N1S2NERTdzaWlRSHNoQm4zUnVTSmsy?=
 =?utf-8?B?T254MWgyUjFXSkRXRmhXaWxDRSt2K2dvamZ4bE5CdzhwK2hLMWw2Qks1bW9j?=
 =?utf-8?B?ZjRXZU10RFhLMm03ZUxIQjdUSk11akdrVTRuNUZuOFcxTUI0c28xSzg4aUR1?=
 =?utf-8?B?aXpVMzZaYjZYejloYUNpcmhnU254cUlxdVlERkY1UVpISHg5cC9VODNsSG51?=
 =?utf-8?B?dkNBUXM0ZWZxU0o3TzBqY1AxM2hmV0J2c2g1NzFXVWRoYVo0YjNoblY4dGlL?=
 =?utf-8?B?NUpJNUkwdHRreEhMM0pRR2JYWDVnOHFuUmZMVm4wNzRWN3FnTEx2UDJqZitL?=
 =?utf-8?B?cFJZVVFSeE82YUxOcHozWitqZkxCQks2TUpiOUJGSmdoUlNXM1hZeVphamdJ?=
 =?utf-8?B?ZWx5WHUwWllwKys1Skxpc3I4TXJOVjNTWHUxaHFZNWFKdmhRYWpWNzk1UndU?=
 =?utf-8?B?SDRUNTdHREttdm43NGpnRmlhSHd4U2hmd2QvZkEwRmhQNW1XUlVTVnZod3lK?=
 =?utf-8?B?R0Z1T01qRkRhTVdzbTN2aXF3Uzhwa1JzdzJnTFZzNjA5NWl0Q25LWnd1WGV5?=
 =?utf-8?B?Vmd5eUJwZjRwNVJ1elVWUzRLeVlFcjdmcVQ5OU5LblI3WVdWOHV6QTZoOGRY?=
 =?utf-8?B?UGVOU0JkMW10WllTbGp3YXlta0pmMGc3bDJkREVyaFdrRnhvb2NqNUphcXNJ?=
 =?utf-8?B?NTQrTDloRSs4bnl1cUY1UEcvWWVGdFRLWTk2RGxoVlZhdHZGclpCcFBoOThX?=
 =?utf-8?B?ZElZcUhLaFJhNG1sd2hwYkJwS1FhL3NiWDRLU0U4YmEyZWVtN0loZWcyTWhq?=
 =?utf-8?B?d1FtWmJIMjBIdjFYaFZ0dlJtN1dEQytzWmhHOWxSOG9YaVA0d05wbkc1SHVG?=
 =?utf-8?B?bmRoRHAxYmZLdklhbUJjeGV3cXJUUXkrejRuZnZzSTV3Wm9YeCtFdmt0cEV6?=
 =?utf-8?B?RlcrVGV4WE8vODJxZVdVbStrc2pMVWljRkdzV00waVAxVXdqQmlDNEIrQUdN?=
 =?utf-8?B?OHBDaVNZOExVbjdVck5Uc2FRSVArWVFiSnJsUTY2VDkvaVZubmk3VGJPd1Uy?=
 =?utf-8?B?K3Y3SzYyVjNkRWhuUU1mRFVEUlhnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bb0fc0-1a06-4f4c-66df-08dde44a139b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 02:41:36.6808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5ixYimQH/3NL5XoPDp9d3PDuzAWsX8ddVRxm49dgZZ5pwh7XjZbxvtQxvvvasSKQlH2GENJ+/wnNwVz4/yITw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8805

On Monday, August 25, 2025 7:40=E2=80=AFPM Svyatoslav Ryhel wrote:
> Add SOCTHERM and thermal zones nodes into common Tegra 4 device tree.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/boot/dts/nvidia/tegra114.dtsi | 197 +++++++++++++++++++++++++
>  1 file changed, 197 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> b/arch/arm/boot/dts/nvidia/tegra114.dtsi index 3ee51d7f3935..c666db564204
> 100644
> --- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> +++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
> @@ -6,6 +6,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/tegra114-car.h>
>  #include <dt-bindings/soc/tegra-pmc.h>
> +#include <dt-bindings/thermal/tegra114-soctherm.h>
>=20
>  / {
>  	compatible =3D "nvidia,tegra114";
> @@ -694,6 +695,46 @@ mipi: mipi@700e3000 {
>  		#nvidia,mipi-calibrate-cells =3D <1>;
>  	};
>=20
> +	soctherm: thermal-sensor@700e2000 {
> +		compatible =3D "nvidia,tegra114-soctherm";
> +		reg =3D <0x700e2000 0x600>, /* SOC_THERM reg_base */
> +		      <0x60006000 0x400>; /* CAR reg_base */
> +		reg-names =3D "soctherm-reg", "car-reg";
> +		interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names =3D "thermal", "edp";
> +		clocks =3D <&tegra_car TEGRA114_CLK_TSENSOR>,
> +			 <&tegra_car TEGRA114_CLK_SOC_THERM>;
> +		clock-names =3D "tsensor", "soctherm";
> +		resets =3D <&tegra_car 78>;
> +		reset-names =3D "soctherm";
> +
> +		assigned-clocks =3D <&tegra_car TEGRA114_CLK_TSENSOR>,
> +				  <&tegra_car TEGRA114_CLK_SOC_THERM>;
> +		assigned-clock-rates =3D <500000>, <51000000>;
> +
> +		assigned-clock-parents =3D <&tegra_car TEGRA114_CLK_CLK_M>,
> +					 <&tegra_car TEGRA114_CLK_PLL_P>;
> +
> +		#thermal-sensor-cells =3D <1>;
> +
> +		throttle-cfgs {
> +			throttle_heavy: heavy {
> +				nvidia,priority =3D <100>;
> +				nvidia,cpu-throt-percent =3D <80>;
> +				nvidia,gpu-throt-level =3D=20
<TEGRA114_SOCTHERM_THROT_LEVEL_HIGH>;
> +				#cooling-cells =3D <2>;
> +			};
> +
> +			throttle_light: light {
> +				nvidia,priority =3D <80>;
> +				nvidia,cpu-throt-percent =3D <50>;
> +				nvidia,gpu-throt-level =3D=20
<TEGRA114_SOCTHERM_THROT_LEVEL_MED>;
> +				#cooling-cells =3D <2>;
> +			};
> +		};
> +	};
> +
>  	dfll: clock@70110000 {
>  		compatible =3D "nvidia,tegra114-dfll";
>  		reg =3D <0x70110000 0x100>, /* DFLL control */
> @@ -858,24 +899,28 @@ cpu0: cpu@0 {
>  			clock-names =3D "cpu_g", "cpu_lp", "pll_x", "pll_p",=20
"dfll";
>  			/* FIXME: what's the actual transition time? */
>  			clock-latency =3D <300000>;
> +			#cooling-cells =3D <2>;
>  		};
>=20
>  		cpu1: cpu@1 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a15";
>  			reg =3D <1>;
> +			#cooling-cells =3D <2>;
>  		};
>=20
>  		cpu2: cpu@2 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a15";
>  			reg =3D <2>;
> +			#cooling-cells =3D <2>;
>  		};
>=20
>  		cpu3: cpu@3 {
>  			device_type =3D "cpu";
>  			compatible =3D "arm,cortex-a15";
>  			reg =3D <3>;
> +			#cooling-cells =3D <2>;
>  		};
>  	};
>=20
> @@ -888,6 +933,158 @@ pmu {
>  		interrupt-affinity =3D <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
>  	};
>=20
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive =3D <1000>;
> +			polling-delay =3D <1000>;
> +
> +			thermal-sensors =3D
> +				<&soctherm TEGRA114_SOCTHERM_SENSOR_CPU>;
> +
> +			trips {
> +				cpu-shutdown-trip {
> +					temperature =3D <102000>;
> +					hysteresis =3D <0>;
> +					type =3D "critical";
> +				};
> +
> +				cpu_throttle_trip: cpu-throttle-trip {
> +					temperature =3D <100000>;
> +					hysteresis =3D <1000>;
> +					type =3D "hot";
> +				};
> +
> +				cpu_balanced_trip: cpu-balanced-trip {
> +					temperature =3D <90000>;
> +					hysteresis =3D <1000>;
> +					type =3D "passive";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&cpu_throttle_trip>;
> +					cooling-device =3D <&throttle_heavy=20
1 1>;
> +				};
> +
> +				map1 {
> +					trip =3D <&cpu_balanced_trip>;
> +					cooling-device =3D <&throttle_light=20
1 1>;
> +				};
> +			};
> +		};
> +
> +		mem-thermal {
> +			polling-delay-passive =3D <1000>;
> +			polling-delay =3D <1000>;
> +
> +			thermal-sensors =3D
> +				<&soctherm TEGRA114_SOCTHERM_SENSOR_MEM>;
> +
> +			trips {
> +				mem-shutdown-trip {
> +					temperature =3D <102000>;
> +					hysteresis =3D <0>;
> +					type =3D "critical";
> +				};
> +
> +				mem_throttle_trip: mem-throttle-trip {
> +					temperature =3D <100000>;
> +					hysteresis =3D <1000>;
> +					type =3D "hot";
> +				};
> +
> +				mem_balanced_trip: mem-balanced-trip {
> +					temperature =3D <90000>;
> +					hysteresis =3D <1000>;
> +					type =3D "passive";
> +				};
> +			};
> +
> +			cooling-maps {
> +				/*
> +				 * There are currently no cooling maps,
> +				 * because there are no cooling devices.
> +				 */
> +			};
> +		};
> +
> +		gpu-thermal {
> +			polling-delay-passive =3D <1000>;
> +			polling-delay =3D <1000>;
> +
> +			thermal-sensors =3D
> +				<&soctherm TEGRA114_SOCTHERM_SENSOR_GPU>;
> +
> +			trips {
> +				gpu-shutdown-trip {
> +					temperature =3D <102000>;
> +					hysteresis =3D <0>;
> +					type =3D "critical";
> +				};
> +
> +				gpu_throttle_trip: gpu-throttle-trip {
> +					temperature =3D <100000>;
> +					hysteresis =3D <1000>;
> +					type =3D "hot";
> +				};
> +
> +				gpu_balanced_trip: gpu-balanced-trip {
> +					temperature =3D <90000>;
> +					hysteresis =3D <1000>;
> +					type =3D "passive";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&gpu_throttle_trip>;
> +					cooling-device =3D <&throttle_heavy=20
1 1>;
> +				};
> +
> +				map1 {
> +					trip =3D <&gpu_balanced_trip>;
> +					cooling-device =3D <&throttle_light=20
1 1>;
> +				};
> +			};
> +		};
> +
> +		pllx-thermal {
> +			polling-delay-passive =3D <1000>;
> +			polling-delay =3D <1000>;
> +
> +			thermal-sensors =3D
> +				<&soctherm TEGRA114_SOCTHERM_SENSOR_PLLX>;
> +
> +			trips {
> +				pllx-shutdown-trip {
> +					temperature =3D <102000>;
> +					hysteresis =3D <0>;
> +					type =3D "critical";
> +				};
> +
> +				pllx_throttle_trip: pllx-throttle-trip {
> +					temperature =3D <100000>;
> +					hysteresis =3D <1000>;
> +					type =3D "hot";
> +				};
> +
> +				pllx_balanced_trip: pllx-balanced-trip {
> +					temperature =3D <90000>;
> +					hysteresis =3D <1000>;
> +					type =3D "passive";
> +				};
> +			};
> +
> +			cooling-maps {
> +				/*
> +				 * There are currently no cooling maps,
> +				 * because there are no cooling devices.
> +				 */
> +			};
> +		};
> +	};
> +
>  	timer {
>  		compatible =3D "arm,armv7-timer";
>  		interrupts =3D


While there are existing problems with the soctherm device tree schema, the=
re=20
is no point in trying to fix them here. So,

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>




