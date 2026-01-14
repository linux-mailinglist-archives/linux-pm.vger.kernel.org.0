Return-Path: <linux-pm+bounces-40877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCDFD21072
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 20:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B90E3025FBE
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 19:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B448A308F03;
	Wed, 14 Jan 2026 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OWZuUHl+"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C95346798;
	Wed, 14 Jan 2026 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418806; cv=fail; b=e8iodyji4nkDCz5DO2VB2q1xrFNfURbgmq70mnROobU0XT3NtkcD1VO8e31AoJdxGGfQOOneJgAU6RHekLN3CwD61GjrZvGmaM72NnuUaBTQxqnYmhFKNHKlpcLKqyOs1Hq0i91EDorZvsgCi5fAE048ztyfEmKkN/AcTI0j884=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418806; c=relaxed/simple;
	bh=HVv8K5pnaqvC72yHAUXdnlF0KxO0PSG7fzX+pvydOCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lCF+g7KIAN1vonxdEpXn5pWr9jHFEcgCj/Rybp7H3Q22UIk+licEAGBXSqGlUmEmYIkoRXwIFXUFmzrbcNXGn7KjWxaVUhXFzTA/qVGMxiFZrrrhNPw75p2kI270LIDxhog0vHDxQwEWGBpRx9UHGs6yndV5WKTWQwfr9+kWVo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OWZuUHl+; arc=fail smtp.client-ip=52.101.62.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBCDPwDmPc/4sDybEYuFAnJIr0tfKdWzum4hg3Lf27uSqHqjvZYwNu74bguJhm6+yt3KgwcFtNPc3uSa4GNll2Gbejq52Orr7ZGxNBmVWdL4p9Dyj7g6u3Xd4mZJnN63RSbx8+Y7eZnnjcg00m8f8gszdZ4CDYNMRdye1lv1VpERwPAH9n29usxURuagLKuN9nNRDUzIKTWO4bpiiV4+O5Tk/gPNgs0bIq6P3/wCTOUgei5dNP8jz7+bKsjE2iCuZF4QFBHPq814Ewpq6V0EuLilm1BhbIiQdss+3NFDn4tw7v1+M8/wXyvPUBam2ffLX6kVSszS4Dref+XQi6s8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVv8K5pnaqvC72yHAUXdnlF0KxO0PSG7fzX+pvydOCE=;
 b=n2pnU901snqh+ADVIy9dPxkiqc77tgRADgOTjT0/fX9WX76SAvIVcL8/4poj5LCNgozdT3n/MK83g5M0vrbn526YhzNanQevYAGytCyh/OugT9tGs1Wdymn5V+Q1H2jZMMAcj/jg89qZ7XrEcIKqlYOM74G8TPj6d4jkweJ+DkK8Tdhl522Y420ho1ps3pUwKtx6VjyJhKhPVTCWtZu3Nnx0NtqVCu1PoUPhYuH04d0z7l0icwNG4/GpXwxTwYw9RpXAVMB9ouzb+uB20gFtaLuUlQbVXPReKgNW5IA0xgy3jaJKrzddNtGTsrK1+hRz2ILYwoyieeau+Yl/moMogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVv8K5pnaqvC72yHAUXdnlF0KxO0PSG7fzX+pvydOCE=;
 b=OWZuUHl+kra1wFh85NgtIOL5S/MXbKJyzNaOX9td2DOXrO+X3TGsJ5cHvRKBN+lqSjf9XrC6VtU0D5SQMlnu+yPhrVnGBkLoATZJueYVsNnRwHJeBW4BA/zr2KGWDUFIyeEAMNWairyZN8Bhqt0RJSHGMBzrmN1/vZEnd1Jl5Q1pBLNU7ikBVuo/Qrgj/o/kc9rs3i1NYUOSX3YygNpvOJb4Q+8B9nLv5p02OIWwZVCvcCLifvElSmdNadpBjYPY4EzRg63KWlslil3/oeaY1qpxOM6E179LHooEV4kHull+ysJCqGaLsx1ME1sOpwaoLShFfQbsMPBBZqqxMIXT3w==
Received: from SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 19:26:42 +0000
Received: from SJ2PR12MB7943.namprd12.prod.outlook.com
 ([fe80::6a18:df97:8d1a:5d50]) by SJ2PR12MB7943.namprd12.prod.outlook.com
 ([fe80::6a18:df97:8d1a:5d50%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 19:26:42 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, "a.hindborg@kernel.org"
	<a.hindborg@kernel.org>, "lossin@kernel.org" <lossin@kernel.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "tmgross@umich.edu"
	<tmgross@umich.edu>, "daniel.almeida@collabora.com"
	<daniel.almeida@collabora.com>, "bjorn3_gh@protonmail.com"
	<bjorn3_gh@protonmail.com>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "aliceryhl@google.com" <aliceryhl@google.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "gary@garyguo.net"
	<gary@garyguo.net>, "dakr@kernel.org" <dakr@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] rust: io: always inline functions using
 build_assert with arguments
Thread-Topic: [PATCH v3 2/7] rust: io: always inline functions using
 build_assert with arguments
Thread-Index: AQHchYpARlj+xJW5okWDQGxkYmpY+7VSDFSA
Date: Wed, 14 Jan 2026 19:26:41 +0000
Message-ID: <14af917dab28321a69b81765d81d33aa4616bce5.camel@nvidia.com>
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
	 <20251208-io-build-assert-v3-2-98aded02c1ea@nvidia.com>
In-Reply-To: <20251208-io-build-assert-v3-2-98aded02c1ea@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB7943:EE_|MN2PR12MB4047:EE_
x-ms-office365-filtering-correlation-id: abc05dbf-b403-4242-b467-08de53a2d8ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkVENnVQWXM3U1ZzVzNoUE5uWGNtYkY5djNVa3M5Z0tiNHJ5WVNOU3lTOGpW?=
 =?utf-8?B?UFo5LzV4clZNcjVDV1UzbFkySUxXenZpWmFEN2dZSnFnRWFYeXdZUTU4OGtX?=
 =?utf-8?B?VXlDTTd6aDZVQXFJWUZxdEtpL1k1UCs3cEQwa1JnRGdRdkMxQWFTcDFLSzdB?=
 =?utf-8?B?K1pVS1NJckd1am5xY0ZCQjZDeXU1empNUTdVdlVqMFFWZlJXeU9sdUFZOUlh?=
 =?utf-8?B?M0wvN0lMS1dLRW9CUXR6WlFGZisxeHFuRExMdzh5eS9JQUd1MlFobXc5Yzk3?=
 =?utf-8?B?Ny83OWszanpWNk9uMHlEbGRqdGNFMUh4UFBlRjQ2T3Y2ZFB0eDR1U3hGZXhi?=
 =?utf-8?B?WU9WbWR5dUhGSitYaENRVVI1d0ZCb0RoZThSeENIcXBwbDZhQi9ITWppL1ZK?=
 =?utf-8?B?bWY0aTFsSUtxazRLZ2YxclRZTGx1UTZKSlhLQWxoY0EwRjNLcFQ0bkdjc1N5?=
 =?utf-8?B?MmZVdzlWUmtJdWxXbTUxYThZa20xSDA5Q05hM0xWVDExakVvUkJWWmNkc1M1?=
 =?utf-8?B?NEFjbnRnK2YzeXFjdlVHcVorZGJLVnNXeDErbkpRdE9VOE1BRmNiMDdqcWo0?=
 =?utf-8?B?MW1CT3pUZVo3Q1FOOVpCSTNOckoyNmt1L0xBRXhVL2t0V2w0M004UEpXRjZP?=
 =?utf-8?B?WmwwOTMwbjlhSWNJRUVIbWxNaE9JbzJlb3pnSXFTY2Rzdm1xSFd6d2haOXpx?=
 =?utf-8?B?QXNzaGJOeTFlTHJiYVRwWktsWlJqTUs5amtjZHNCcEVGRi9NWU9yREY4d25t?=
 =?utf-8?B?ZmlYaEdTekh3RGF3ODNFbmpxNkZuSWJJbjlNT2xzUzZSNlJmNXpUdHpIV2dF?=
 =?utf-8?B?ckRXM29ZQTluTVJMUUx4M3dzRnRqNnhXQzYzZFAxOVVZV2l6OFB3cjdNR1pR?=
 =?utf-8?B?ZE9KWWxrYWRBakU4bjBMSjcwQUhYNDJtVVp5Y2hSZklLVUJwMkF0Sk9yM0dN?=
 =?utf-8?B?UldqSUVzUGFaZXhaaVBzRlRBUjkyYWEzVGhibVdTRGtRSGpOV3YvKzJITzhP?=
 =?utf-8?B?WHBOQi9jOTJ2a0dqbzRQazJ6Rm5acVRTK3pMR3ZEak5OQ09MU0U2SkVYTTF2?=
 =?utf-8?B?bHUzenllWWxLc1JFcHJ5NGFoWlZXOTBpcUpjQTB4NXpQMGc5RjhOR1UvY0FO?=
 =?utf-8?B?UVhLaHl3L0Q0RTQ4bHhkb3RvMTBXQW5Hdmt6ZnVpby85ajZHVTdTczd4bVpF?=
 =?utf-8?B?WWV5OXJFajd0UTkzVVYvbmdNc0w4eHZxUkJlejRNc2Fscmoxd2ozS0NmU2Rw?=
 =?utf-8?B?V0JsT0g1Z0x1dTdnNnJKLzl5NzcyUGFIcFpUTDJMT2VBS2pqU0luZnhzaFZn?=
 =?utf-8?B?V2tuZlFuWGFCcjZCUktEbFFYRHFCZlBVeXFOT1F0MklKWlE5UlhKcWVyVVFJ?=
 =?utf-8?B?S1JxTkc3dTNqMzNrWGlUSk1SaHdZaUt0bGZ3Q3lqR2FINnVuWnc3M3pzMzRH?=
 =?utf-8?B?LzFpNXhpR3BlTkRwWHNxYW4wc1NObnhWRXNnRWlNSHZtd003YkkwakVtOW0r?=
 =?utf-8?B?WXNoTm1QcjF2U2tGUUdOa1FyYWhCRGNjZXJ3TzVXdnBVcVJiYnhHZXF4NG9s?=
 =?utf-8?B?aitJTG53bzBHN2NnZzVmd1doeVc2bHhBTUFxazZsOUFDWUgwdndvTDZVOGpX?=
 =?utf-8?B?NDZWTWVQc0srZmFyQ09QazhsTW84RWFJbHBiQk1sVDgxcktGU0pyQWMzRVZr?=
 =?utf-8?B?eE1NeXMwWVZLK2JuQ0VGWU1GMTdvWEs1M2NlbFRMWWxqdG1vcCthTzBkazlB?=
 =?utf-8?B?K2FXMTBtUUh3TUhFZHkyWE5xZ1NKK1FyNy9TeUtWSERTVXgweWdOZkhNam1R?=
 =?utf-8?B?Z2MzaWFrMGVxcUxFcW93V2c4a0VTa21wUWNMVWNOOG9JY2ZaNWZsMlcwMDZq?=
 =?utf-8?B?V2xTZGFCMWJaM09od3owTFVLQW1ua3RyclZWeWorVVBBZTZWU0tEcVBhRW13?=
 =?utf-8?B?NDNEUEdvdDNFNEZEZ21LNlhZS3VIWStQbmJ6bVhKakE4dEFKR3ZpdG1kMlMz?=
 =?utf-8?B?d3owTWZ3TS9LdzNreklKR3dWZXczYk8ra2txbW1NeE1VbFdwV0dYWGlxdXZM?=
 =?utf-8?B?ZkVrNUttd2lyZ3F1dEphVFAwM0NnYitkbjZKRDA4WGR6U0hraWd3dGcrc3hp?=
 =?utf-8?B?cXBLK3Q3bUpPMjBlTWIwWXloVHNoTTJWN1lGSlNFMmhjdTF3YVRLbEdXNTdP?=
 =?utf-8?Q?rn6q4N9cQ4oRWq8+LI5t6R3niZyxGd2ShhjHZFqnSth9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkgrS0ZMazFoSEUydVhhSmZiL2dXWDdzTzVzc1hROEVmcys4QTdpS3l6b1JW?=
 =?utf-8?B?NWJaUHV6R0Q1V3VEREloOVNOQ1JsZjM2Um9ubDRBUDVqTHVCeHUydHpKei9v?=
 =?utf-8?B?MnR1MzFCUjhBRGhkVkNCSHJ3aDJiTkgzMWlwSEgvREd3NktmTlA0Rzc4d2NN?=
 =?utf-8?B?NWttaitWWndUQjVBRER3Y0MrbmFMN0p1cWtIVVdmY2w0bTdUSVQ1T25MM2Vp?=
 =?utf-8?B?a2xPMmRvTmhwRW5SbXRick1aelZCN01VamJYcEwzUUdQaHBMNGViVFp0NW9Z?=
 =?utf-8?B?dG5OQmU4VmRyYVI5K1JwZmc1MXEvUjl1THJNTDNGMHM3ZFJ2aldhclRhcmtr?=
 =?utf-8?B?VVNxMDl2YlpQZWd3ZjFNaTdtUFdJZmxkclljYlJURUUyYkdoL1BSWUIrM0xu?=
 =?utf-8?B?aDBpb1FOckM0TWNnMUx6NU1JeE5CVVBZYnd3eTdlbUNteVhmN0M1TXJNSENr?=
 =?utf-8?B?bnJoa25PK2V1dXpmdmRhV3Y3cmJRZktMZU5tdzRnUHpLSGprNTkzSXh3dEtO?=
 =?utf-8?B?K0pWbWlOSlN6R3FUNjlRVVB2a3d0OW5FWWp1eXhqa1dyOFluZG5lMUY3dm16?=
 =?utf-8?B?RWpmRGNYRHo2dzFneWQ0NS81czBXVHFIenp3ODBDSkE2QlBnVGNWNlFLbGJ2?=
 =?utf-8?B?TUtOUHJpTDhIeUVYYXNNSkxNV2pVMktvNFh1V0ltaGl0bVhCU2VsWjJVWjV4?=
 =?utf-8?B?K2lOUjJ3UWM1bTRnRzExRnpzVFF2cjc0OStQU1VoeDd4TGFVTXIxSWRydVJ5?=
 =?utf-8?B?OVY2bDNQMG9qTWM0N0NDaTlaU3dITmJsSW9ydWpVMVRSWjZ6R0lXeTgzT0M4?=
 =?utf-8?B?SnNPcWdvaml6TTJxQ2pZV3ROMU5aekE3Mm14Y01RMlVQOTZTb1p1Rm95U2lU?=
 =?utf-8?B?UlpMVzAwaUlvMEI1UmVHdmdCWENZcldHYTVJKy9hWDI2MUlIcFdnMHk3em51?=
 =?utf-8?B?d253d0FzUTByaGFwUnpqRXZKRkxQajZjMk1wNkxTUmtqL1Z2THlWdk9scVJv?=
 =?utf-8?B?b1dNL3BXbGFhRlpudk9uWTRtYk1HVVdLbXNMYjJCZkF0OS9HbVJPdU4rQmxV?=
 =?utf-8?B?UnlXRkwxeVl2QzYrcVZzbjVhY3MycXJCVzcwTUFibUErMnFCQ2JmZmpSYlRS?=
 =?utf-8?B?WUkvaHpwZ0huenpxYXk3d3hCMlM2RzM3WS9TQnBBYUg2ZmUyUytXMVB0K2M4?=
 =?utf-8?B?Q2tHMFhiYW9ncEpDVy9uaXowdzkzcktyd2QzYTFwYVpYVU9lcS9CVXpya091?=
 =?utf-8?B?RlhDdFduTXZ2eVBUSFNFcC9vRURjKzNsQXZkMWF3L0hIenVXdFR2bXNQU0tz?=
 =?utf-8?B?OHR1bkJYUzdGRThyejJMeUlNUTIyTWJ4eCtsTktHaVJvYm85bzN2TnExendB?=
 =?utf-8?B?WjhCSkIxYXBJZE5yUmlUcFNpaFNLNitTTy9YVmZEVlJtNGRyUUJsT0ZnVGto?=
 =?utf-8?B?d3lmSGVSVHNtSExrKys2QXArUGhlRitIRWpIVmlBMFo3TEtuS0xTblBBQTBi?=
 =?utf-8?B?NTB2azY1UW1sL0RKNnRrUTlxVTlWOTZaQ2Z4YVJqSVZROGVIWVJJZVpDbWNn?=
 =?utf-8?B?d0Z2MWhwT1J6SDFBblVYNmZ4Y0hMeU1JU204UkdWV29TRnV4U0pJaUhLeks4?=
 =?utf-8?B?ZlYxRjdwd2RxWlBZUTdPSmhrUytGYjhWU3NyMlhXZjBjQmh3a2M0bVRSWGlY?=
 =?utf-8?B?Qm4zSGUwcWU1VnhhR3VmUFV2eW03Y29BbHhLOTBHbW5WcXI5dEYrZ3NRaUFX?=
 =?utf-8?B?TzRtVm5tWUhLMCtHOElpT01QNkc4dDRZT2RIbEx5aTVBVnhzMXR3ektRL0dp?=
 =?utf-8?B?WXpraDk4RXpYdmVNekE4MlRuWGU5Y3BQc3hOaUpkaVBoSjlwMFJaSE1qOVll?=
 =?utf-8?B?cTlNYjVOMy9Wc3JScS9KOXFxaEtRaWtoNGN6NmppRkM5Tmc5bEdwWDBOTVZr?=
 =?utf-8?B?UHFkY09ldVRsQUNkaW1MYmI0UDA2U3BNYWU3WlVpUXZWY241OEVJNXQ1T1hz?=
 =?utf-8?B?Yzk2WnFZTFY1dzQrMFIrMWNPZUE1TWdtc1RzMEViT3lJMUdob0xBaDhYczd6?=
 =?utf-8?B?Q2ppK0NUUk55YWsyRW5OVnhiK2MzcGJwNU9VT0ZHOTNPWS9nNzdmVVNjQVdL?=
 =?utf-8?B?MkkwcXpjZ3Y1ZDdKUFRkVHhwZHo2WkgxWEdPeFFLdXBsYmFqZ1RTdXM4a0t2?=
 =?utf-8?B?My9OUXNJaEVxcElFZVJ2azR2Q3VDTm5hUjhPOVNwZ0JzdGN1c0E3Tkc0bVBV?=
 =?utf-8?B?R3JNVWh6bmVpajNzTXRRR1IyUTQzT0NxSUN1UTlHNHdHVmdJMzZlelptRFdk?=
 =?utf-8?B?QlQxRDFNTnlhZUthYzFvVlRQM0FGVDdGQUN0THA2YkQxT2ZuZWNOUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A7797C8BE9D7E47B6612E15D6907845@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc05dbf-b403-4242-b467-08de53a2d8ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 19:26:41.8180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWNPjunu3T/zQk7inXcUkUToMOSEop9tCIg3zWgQsvyO7sZDM81T+XjAl145x862xmgVmdaz0bVp/mNQM4RqMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047

T24gTW9uLCAyMDI1LTEyLTA4IGF0IDExOjQ3ICswOTAwLCBBbGV4YW5kcmUgQ291cmJvdCB3cm90
ZToNCj4gYGJ1aWxkX2Fzc2VydGAgcmVsaWVzIG9uIHRoZSBjb21waWxlciB0byBvcHRpbWl6ZSBv
dXQgaXRzIGVycm9yIHBhdGguDQo+IEZ1bmN0aW9ucyB1c2luZyBpdCB3aXRoIGl0cyBhcmd1bWVu
dHMgbXVzdCB0aHVzIGFsd2F5cyBiZSBpbmxpbmVkLA0KPiBvdGhlcndpc2UgdGhlIGVycm9yIHBh
dGggb2YgYGJ1aWxkX2Fzc2VydGAgbWlnaHQgbm90IGJlIG9wdGltaXplZCBvdXQsDQo+IHRyaWdn
ZXJpbmcgYSBidWlsZCBlcnJvci4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
IEZpeGVzOiBjZTMwZDk0ZTY4NTUgKCJydXN0OiBhZGQgYGlvOjp7SW8sIElvUmF3fWAgYmFzZSB0
eXBlcyIpDQo+IFJldmlld2VkLWJ5OiBEYW5pZWwgQWxtZWlkYSA8ZGFuaWVsLmFsbWVpZGFAY29s
bGFib3JhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJlIENvdXJib3QgPGFjb3VyYm90
QG52aWRpYS5jb20+DQoNClRlc3RlZC1ieTogVGltdXIgVGFiaSA8dHRhYmlAbnZpZGlhLmNvbT4N
Cg0KV2l0aG91dCBwYXRjaCAyLzcsIG15IFR1cmluZyBwYXRjaHNldCB3aWxsIGZhaWwgdG8gY29t
cGlsZSB3aXRoIENMSVBQWS4gIFNvIHBsZWFzZSBtZXJnZSB0aGlzDQpwYXRjaHNldCwgb3IgYXQg
bGVhc3QganVzdCB0aGlzIHBhdGNoLCBzb29uLg0K

