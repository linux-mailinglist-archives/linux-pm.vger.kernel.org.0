Return-Path: <linux-pm+bounces-32779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FFFB2F008
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 09:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52581894F31
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 07:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922A1D54FE;
	Thu, 21 Aug 2025 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aSdQ9EU1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B013A265;
	Thu, 21 Aug 2025 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762352; cv=fail; b=WWC3xUK/1fi06epZn2BdNT0SZok+ksCyd0ij+/BjhFQD097bNlEXnUVg7k68HLqeHQ1DSZxZjRpAIA8/lA9eg0wEqZogJUUWg5aBILDonvU4SSau4D0UT3NHsIMjM7tug9iHPd3r1o2A5m99RogRHm1h4MnF2c32RSFaLvpMKlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762352; c=relaxed/simple;
	bh=KO6KyoeanUnLslLu0DFon2FbO5L4rhADqS1z5CDPFig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WDKOnmqshKXOJnFpnVpNkvZzcf7lr8Is3S7DVE8EAxOt3HMPtDkDHQQ2UW9AYR9bphXz/tn8zxyh+YdSy1tobNys0ahlmSwxomYbogj2YwOkHyqsKhTHMGEpKbm8wKYtWJKP876KwZI7fw/7PE+6nYhSzZzpnsS3eFtTG3rVO8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aSdQ9EU1; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2+cMDnl2WJqIoLEyU8z+sGoQ2MeN33hhmVq/Sx9CVQJ1RGgUOyKlGe4eJSEFtGgBehiykH76kD+Fgtz5rxbv4AtrcsR5voNOxn703S2pXp6xvOpIx6Js8BNzk5X54ZpjHQeIJdhyEMJFtEM6p0zgdZTLq4XO6nK79d4uNA6Y4abv9Oa2ZvdHN+ijnPuEhO0Xa8ZJmFSWqj8KXkV+z3Agc9jcOXZIdGCVVYJlPYgw70DErhDxdejL9kNCtRt4fx6Ngjxzb5Lg4f6m+sFf/sBbfvZdRK+yFqFK2S7dXlCr/6nU5IQvdUNdedyzfAo8uXtUBvVYuBID4Wu83I2ARLlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mozZefmYMFS557lEDzsrmFmaIzSPBLetTJu7XszCnF8=;
 b=dzCiZwnGoc1aKIPGYb1U1e9StC+cvIMGU4zeUl2OdlYV4NTSoJn4B7zb47vQAxDZsBJx8sXgmZODc/z14H67uWtrp4b1lu8FZWwbF7qjHBqlkDoCIYHsklxeEQ9+ap/j4WZhSqocPDEaSAnXSm1z6JImv77DdPeU3Zr2phcU4qixg8HYSNyC500IT8v7nkkzWBAZUwaAt7irz1JVwyG0Tp+mnN3BuzfQMEw5gfQ4mtLXCm6UkqHgQP67IloOU7p8XIKE2sEeiNI2NL9//9fznj9D3NmcXEw9E00seq5XkOrmmOdFebUo2EI2LsQqepi2w6eZc1NU4xweIg5RUVSyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mozZefmYMFS557lEDzsrmFmaIzSPBLetTJu7XszCnF8=;
 b=aSdQ9EU1oggWaScQCTkZyrtuSeO/pI3bWK5LoBCPmRiWqf8nA5vcrV9lrpo8qU7ogztlwr6uHpsefMhWGwKfzSx7MX8+bG8BAGTdOri8VaKMqGoEv9sTxOVzlv6XlmmdvIPoPC2AT7USwX/mp/tbGNY0cg7DhjYYk7iD18UIFrUeZRgPJCpvbhv0pTc+WONhEGAXhGmZrH0tXQ3iX70KbqY8xCuSQJAaLQo6NM1wA4gazFflajaPxroWVbvk8AoTZc8FctTZgrLYZeZrVRUP3Z+1FIFngse6CjNcJbMDqQIQ/BiJfPqqZwHnTY88KPKc0HhOzFqgeUmeUktIrf89cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 07:45:45 +0000
Received: from IA1PR12MB6484.namprd12.prod.outlook.com
 ([fe80::fb8b:583b:154:76f6]) by IA1PR12MB6484.namprd12.prod.outlook.com
 ([fe80::fb8b:583b:154:76f6%7]) with mapi id 15.20.9009.017; Thu, 21 Aug 2025
 07:45:45 +0000
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
Subject: Re: [PATCH v3 6/6] ARM: tegra: Add SOCTHERM support on Tegra114
Date: Thu, 21 Aug 2025 16:45:41 +0900
Message-ID: <3656751.iIbC2pHGDl@senjougahara>
In-Reply-To: <20250820114231.150441-7-clamor95@gmail.com>
References:
 <20250820114231.150441-1-clamor95@gmail.com>
 <20250820114231.150441-7-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::15) To IA1PR12MB6484.namprd12.prod.outlook.com
 (2603:10b6:208:3a7::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6484:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ee7b7d-1786-4d42-e40c-08dde086bca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0dHVEllaG9ZYWhkNHFyRFJSSFBBVERVb1BNT3l1SDFiQmlDdm00dlEzVzlM?=
 =?utf-8?B?TXFFWnZZcHEvelZsRWtyUnJIbTdnN05GZy9sQW9Da3RtM0ZaZVVySGVaVFk5?=
 =?utf-8?B?dFN3K0t3bGgzYTJGclAxaUozcmFwZVpHNHhkaVYweVlIaGlSQy93UHkyNGhM?=
 =?utf-8?B?ZWFsTUMrUGtuYWFMNVBzZnlGTURvaHBKVmpXNldzbnFoTG5pNjZLTzJyTGMx?=
 =?utf-8?B?NVJFUmNNNXdtL2NMaE1FMWNsUjJFWjhLT2FTK2NldE5JVktma1FMMllvdENH?=
 =?utf-8?B?dXNRQjdFamNLcnU3NVFlM1hnYjJwK0J1QlE4dUFyeUdYa05aZWE0TG91Qlpv?=
 =?utf-8?B?WTZ2UnhGQnJSMDNydlRjVTVLbHZIbm54SFFzR2JPUUcvRXNtcXZ6OExZWHUr?=
 =?utf-8?B?cDFkQjdLRjlkOVBvM1RDZGVFVkZ2Q1hCQTI4NmJtcXIwZlFKVmIzYjVZV0M2?=
 =?utf-8?B?VmgxRDRQZVV4Q0pSL2FQUmxsRlFOL1dEaTJYUklHb3E1bEpwTHZVTXdmS1Y4?=
 =?utf-8?B?RU1VTjBGbkREUHVRTDF0Qm1mam9XUjFZZDB4MnViSEFxYlFyRGc5U0JBdVZw?=
 =?utf-8?B?RHZXejJuTVlBeDBoc3dVK0dwVGQ2eHZPSmVTcDN3QXVhNGZmZ1VZeStLaFJX?=
 =?utf-8?B?eU5tVVJJTVdxclpSTGhjaVRhQ012a3I3WFZONDNramJ6c0pDK1RJbDFLQ05t?=
 =?utf-8?B?NlNtVThkVDlMVkhMTUhwUmNNWDRmM2VtTWZwM1dqUUVvbU9MMzFLQzNTMWN3?=
 =?utf-8?B?NGYweW9Fd2svcUNqVEhRMXN2d0FZUDNXVFdUeHpLVkEzSlBwMHc2ZHVtajIx?=
 =?utf-8?B?RVlLNmgyNGE5OVppdzhwdkp6UVFMNE90UURya0RPNHBtak5uY1JRSVVjWk1O?=
 =?utf-8?B?VEpUdXNvSTN4WlVPNFhZY3dmTEJJdlgrTnpmaEZDaEhFMWI5NUFXSXpLNFpB?=
 =?utf-8?B?MkFldEIrQjFrV1gxODl1WE50ci94b0V2amNIVmdSckYyNlhlVVZMZFhFWHdy?=
 =?utf-8?B?VUJSZWxZTE5HdzJpRUdXRmlsaFEySlZHYkJ3bkVSbVNTZ3VaaldVWlN1Qkc5?=
 =?utf-8?B?cEx0ZU13NTRyczl5OENQbTd6WnNoNWg0OU5WVFprS25PQXpVeHhWeEc0aC9l?=
 =?utf-8?B?ZmdnM21DVWNRSmF3TVl1U0NWL0FGMkNLNXo3ajJHZTlNZGxJTXlYZUNmRWpX?=
 =?utf-8?B?djJvaVVIN2pnUE4yMnJ4Um5ZY21nTG9JNG04dmZQNkQ2bXFvQi9rZkxWckVE?=
 =?utf-8?B?U2VScmYxL1JMV2JKbVNYQkcvaHIzY2MySUdNZURDUEhYS2tLckhVVVdKQXNM?=
 =?utf-8?B?by93cHZralNrdmR3REJZUitYSmZaL2dtSE43RDBLa2tqM3RHL3BNT05BNU5t?=
 =?utf-8?B?Tjg2b2ZtS2hqbmRWdm5TL3p6dDdpK21CWTJTMmpjQ1BLcG93Y2tSZDlRM1Bu?=
 =?utf-8?B?RWJidUhDL09hWTVIMkh3WFNHdkp0R1Y0V05yaWdZS3N6bGdpdUVEZE9Xdlc2?=
 =?utf-8?B?WnhuU0xZT0licmhDZmdMNXhRLzQrMW00azdwY3NUbHBTd043S1BPVHMrZ1Ji?=
 =?utf-8?B?dGhJRUNOeWZ2K25BanFIaTFxYkwrZXM0ekg4ZEtBM3VKWkJMc2cvOFFCTHI2?=
 =?utf-8?B?VFBOUVpZdGpPSzlFN1RUVmVNMUV6Q3RpaWVZK1NJSUxQakhZbVJNV2xiZ2tO?=
 =?utf-8?B?eDRqQVhrMi9VbDZLWThha01peUp0cjlONHdSRGF2dTB4MHh6K00rVVBPeGZU?=
 =?utf-8?B?QkJYV0thOXB3ZDVFTjlDZ0VkcG5iYnJpdUh2MDBrOVIzcWM3NGNoOVYvaGZF?=
 =?utf-8?B?YTZuSGlrMEdDMi9ySjFtS2F3WmY0YkI4MmxiZXBFYyswRittVGxWdCs1NVg3?=
 =?utf-8?B?VENxbDVsZDI2elFjRmRhclBES3ZkQStGVVdiandRWVJPVnJtMVBTd2ExQWVV?=
 =?utf-8?B?bkNLZTUzSmxWbVg0MHJlV3lxRjRuN2tmQ2JtTUI4eDV5YnU4MXVSNXRXa1U4?=
 =?utf-8?B?UXdIdG9xZzZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6484.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWFrK2RkaVkwd1MyZ0VCMnlSY3VXQWUwOWczWEhaaFFpMEhhNWVuNnI0SmJm?=
 =?utf-8?B?YW85TTlHbW1iRFEvcnVzOFl0c1NhSGcvbXBLRFpzMG41eDQyU2x4NmI2bkh3?=
 =?utf-8?B?dkxwY3g0dXN0ZnN4Q0JqOWh0Q09NSnFORE95NmZqbE9ienp1WHVCL2pmWFhz?=
 =?utf-8?B?OEowdzI2Nk9zbDI2NXR2amNPaUFDUWc3dm5uQmoyUGlmaFFnS2syamVyOTRo?=
 =?utf-8?B?RXpBWUtndUhsTWdja3FpU2lhWUJhRSt3aXlSblg2L2h6ZWI3YkVxY05BRzdj?=
 =?utf-8?B?UEgvUDNlbmhCWFIxZGFqTkVPcDhpWklOY2ZIbk03SGZuMFZPRWIxZDJwSE95?=
 =?utf-8?B?MERKMkUvYTJkbGE2eWQzY0Z2UWVhcytnZnRJaGlJSVhiN1BVOHhtaUtoeXV4?=
 =?utf-8?B?bzFJbzlFR2NzZFU0UEtxVkJwUWVIT05Mek9YQ3RsNVdhTVBoWGpodmg4dDdw?=
 =?utf-8?B?V2ZlaXZjd1EvdmR0QkVIdkVXR1RDVEQ4R1JpZXpDeVdtSnhGNmtGU2hXWml0?=
 =?utf-8?B?YlMrYkFGWFVNSkV6R0xqWUovWTgrY1hyS3l6SFJ1cHhvaFhoYVNsMEJEY2Jn?=
 =?utf-8?B?Slh1dFdXTU9qcjhTN24xb0NXcERhaitib1NFYlpzNER4RHNJZWI0QlRSdjVt?=
 =?utf-8?B?dzJjd0RMQWkrQ29mMGpnWXNwZWF3RVIwbExwTi9OWTdlV3dDWkdNUGJ0UU1n?=
 =?utf-8?B?R3hNaHB5RmxUbE1NenZIY2w2NTE5YUZBVXdvMVZhODcrSWRETERlYkJYYWlS?=
 =?utf-8?B?ZGFWUVBLTU15VXc1MEtxSGZPbE5TdTZHSGF5ZU1LR1Z3cmIxM0hDWVVHbDZp?=
 =?utf-8?B?TjJpOTI1R2tuR3JyS0FndE5EbW1iK0E4dTRnOGM2Tzk2L2k4RFhuL3J6UVZO?=
 =?utf-8?B?amlxQWxBejhLSkRkajFIeEtsdnNXUFErRng4czZFTDVTclVqbkVFMFZXRXFU?=
 =?utf-8?B?NTdneWhIck41bUlCNXgwZmFrYkVnTTIvNFdXeVZUcFZHbjVuN2MyVStZeEhO?=
 =?utf-8?B?NDN1czhVcWtJTzdmMVBCYkRTSlI5TEFNNGMwSzdYSkRZb3BxM3o0N1BEMlQ1?=
 =?utf-8?B?bFprbGExQ01EL2xwd1hUQ3hXU3orTUZOL01qMjhKUkRXTmVhSEdXM3FqR1Uz?=
 =?utf-8?B?Q0VuRXZsV2NoMFJIVDM0YWg3RXFEMnQ0NG9kSndCc0JxeTY4WVVFU2EvN2Yv?=
 =?utf-8?B?SFV5aGwweWZqNml4eVBkS1h4bFVJWUt4MWNMWG5nbzNHWjB0K3R4UFZFMGxM?=
 =?utf-8?B?QXg1YXFNNEROMmp4RmxsSnZWKzgxdFk2d1ZXZ3lIY3gvRk9CU1cxRHMwUFFv?=
 =?utf-8?B?aTV2YTd4M0RWWkZ6RkgxZUx0S2xlTEtDakpzNUs4bXdVYTk3YklEeURPWXl4?=
 =?utf-8?B?RVRsQnVlRzQvcGNYNHo4MzhUTEZTMCtmc1FyMDNEMlZOZFcvcUdpR0ptRUwy?=
 =?utf-8?B?NzJYdGJIOUcwOUhmV1A0NitPc2dsNklVVldKM3pyaHFLTUxVT3VDMEtJNFhh?=
 =?utf-8?B?U3lvRFVwUmkvZmhQWnEzQ3ArZmFkN0FycTlHcDc0N2FoWEprN054UVZkZ1JJ?=
 =?utf-8?B?TmN5OFp3THJZcnJteDl5RHJzNnZkVTJKd0VFYk9CTW9xZzRvODQ5akw0YzVs?=
 =?utf-8?B?U25nRHRWektDZWtOV1NsWU5xZGVnOEo0LzIyaVMydjVNSk1FVFVTc0tTcnl5?=
 =?utf-8?B?ZzdCNEJ2bmpvNVJVZE9lM285Rm45YVZDcXFpQkxhd2hvWVhFWHp5ZU5iWjhO?=
 =?utf-8?B?ZldmRmk1SjVRQVp2WXdRWWpoZUIwbHl3bCt0OWtYQktLVFNzc1hlRGZ2azY4?=
 =?utf-8?B?blpxTW9KV0JHTDZpS001MVUzMzZaays1Z3QyNGphb1VaWlhFSWhVM3hoMnk2?=
 =?utf-8?B?dmYvOElxdzZuTTZEWVk2b3MrMThIOGU5VC9lUDNvUk95aG01WUhWMFozTWJV?=
 =?utf-8?B?bUhkdm1XN280UHc2NE9HblpNdkNRc0VPNWkrblMwOG9xYzNMQlJ5L3FFSVlK?=
 =?utf-8?B?UmNaUkNNbjhWT0RyREpJa3ZOcVd3bTFNQ3pnTjdsaTNYMlgrRnpzMWwzYlJs?=
 =?utf-8?B?cE51dHZvdm15bWJQUGNzcitobGJ4UFpWSFB4b0NuU3pFQTVyUWgrM1M3bUNK?=
 =?utf-8?B?TWtsU3pnbkZkQXg1ZHVqK2ViZ25pUzBOQTlHdDVvbjN5c1VKc2xnZ1czVzJH?=
 =?utf-8?B?bURoam4wMDJOV1Z3K2tzVVhSNlZ3SHNKdnlKeEw0Qk9ic2dkOTlBcmRRejRU?=
 =?utf-8?B?eXpJZUY2UUN3WE1Oa21RNXUrdWp3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ee7b7d-1786-4d42-e40c-08dde086bca0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 07:45:45.4117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sOvtOBF2UKbp7frdgNt7BI7UgUOmrGkNrCucR6fpGBz8T0cMZyFDdVvDXcPj4DgfVrSYAGEhni2ymFWGzCCnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416

On Wednesday, August 20, 2025 8:42=E2=80=AFPM Svyatoslav Ryhel wrote:
> Add SOCTHERM and thermal zones nodes into common Tegra 4 device tree.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/boot/dts/nvidia/tegra114.dtsi | 197 +++++++++++++++++++++++++
>  1 file changed, 197 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> b/arch/arm/boot/dts/nvidia/tegra114.dtsi index 3ee51d7f3935..d9c51e6900d8
> 100644
> --- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> +++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
> @@ -5,6 +5,7 @@
>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/tegra114-car.h>
> +#include <dt-bindings/thermal/tegra114-soctherm.h>

't'hermal comes after 's'oc

>  #include <dt-bindings/soc/tegra-pmc.h>
>=20
>  / {
> @@ -694,6 +695,46 @@ mipi: mipi@700e3000 {
>  		#nvidia,mipi-calibrate-cells =3D <1>;
>  	};
>=20
> +	soctherm: thermal-sensor@700e2000 {
> +		compatible =3D "nvidia,tegra114-soctherm";
> +		reg =3D <0x700e2000 0x600>, /* SOC_THERM reg_base */
> +		      <0x60006000 0x400>; /* CAR reg_base */

Regrettable that the binding has CAR registers here, but that's a pre-exist=
ing=20
problem and not something we need to fix here.

> +		reg-names =3D "soctherm-reg", "car-reg";

Same for these names..

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
<TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;

As mentioned elsewhere, these should have TEGRA114 prefixes.

> +				#cooling-cells =3D <2>;
> +			};
> +
> +			throttle_light: light {
> +				nvidia,priority =3D <80>;
> +				nvidia,cpu-throt-percent =3D <50>;
> +				nvidia,gpu-throt-level =3D=20
<TEGRA_SOCTHERM_THROT_LEVEL_MED>;
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





