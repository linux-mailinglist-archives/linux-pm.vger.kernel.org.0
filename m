Return-Path: <linux-pm+bounces-37776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F3C4C7CB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 09:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B09188CD63
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3822EA756;
	Tue, 11 Nov 2025 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rinlr2Hn"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012001.outbound.protection.outlook.com [40.107.200.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EAF257846;
	Tue, 11 Nov 2025 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851346; cv=fail; b=HNMcd4Gs6wUd/bLbItR79lUpwbgkqoe/N7qO/sVk9yzoB4V8v0+tipcanhHGp1+X0hb37k0Nc8Kj++bD2oq7PmWzBP/dkQRNEf/m4/pcKVpCUX1BG9L7gfh/MmCYuEowpbHhrPYc7XjBpNJ2FGvpsntpqQTLvQ8A4DKaxeEHcYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851346; c=relaxed/simple;
	bh=bS5+NztMTrfmBfImzaRaW83p67LNrqdxKdLleZ3D6dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGj9OgaSL0fXRPv94YSTa38N0Moshpd5uvYGiD1G20pwJd8sSulU31631/aG70dJejC7edVyCCkLUdJ1T/gDuZd6LxjtDsvgMiYoqhRszxIqCZSq8bafs7t3G2+T7+mbv7GHws8/DlEWh08ddgvv7OEeoLQIcCNaXP6cSYFkfMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rinlr2Hn; arc=fail smtp.client-ip=40.107.200.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCIxFyIU5LAor2vVhxU2sRTT9CTAZK8cqvQWqk5tI4l4YwBaWpPs62mXQ9vwJ8um5Q+ES3Xv0WKEqxAzGwFW/Mub4Bj4s1W5Jb6Ix7uQq3DfS4mEHQSrnsk88BIq+Ll0/McVlg3wIFSRF5g+4UjX1s4hhk7H7CG2ur+pMKh53wVtBw45d+eU9ot0ehAyOkdhaNxlXJrwzcwkucm9QpBD81o4pTHz8ZkS7BM219wFdsxDe8xgYGDI4Xo9/2+v5KYw0hEcURll5fG9vxDc94UaG/yZpUXdMRo+T3DCLR3Wd/8anO3YTI9PxiulSgSS0cD0nWaYSBhVry3yYCONbXAIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37+Ku69/rEoKiWKvDYdjbq+urOGEVlSSylnY4AWpKbk=;
 b=JH/kuPgKSLAQbiSJT38FxLJdRyEts1hrz4wWhrcZ8rQB8YGC46TnocF/YJjceXTnD6H7wx9WVKxLu/9FX6Rjuop2XAOkBhA2gB8z6wn4+xFGA3/UF4c/zeZJ9nR8jZp5KtXZStT6o7Y93AUSf2yjYARCHSHmWQJ7jHKBzHwkpyLfQ/XKoltuL98fp0wA14KwluuQXaOZ5m3d01E0gtLfwbCeScbL39Hicpi6dJUpTAC9jw/7t6N5CnZxihl7B4xeCsXUrNrV05WI735qeZoJSOpM+b3bcrGRXx6CBI/3l6youFpBSIpCncj2DoYUB5ft2X3pwg84Cs7ppsBJ3mAU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37+Ku69/rEoKiWKvDYdjbq+urOGEVlSSylnY4AWpKbk=;
 b=Rinlr2HnKw76kV+jhorwq9KhSU0YxtYmA7q3ejB7z3efufphq1BIhh8ERSS/Iph4+DNAHrip6etUKHlfhaFeKWtqbj6vePLNlL+ewPvu+ZE80sLld/y/jaeBv4PxOQhmfuSIPX5Sqw7EWn97vlHKcgwjjD/O8g8V6suO6zC+Rho8tucfXUaD/vh+hMUNY9ZKNcDQGpyrTYpGgX/8QSBZrqhhfLDQPkFwX63n9iD18XXbpPug61jCtSZj5DJtXdtVL1kL5TBDPFT5OcbUqN6ylBNlXu1Z6OilOLn17PTSx9c0N16QDy88mGWudlCNmUyJ+1vW3SvnUqNP6JC8jgjj2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 08:55:42 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 08:55:42 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v3 01/11] devfreq: tegra30-devfreq: add support for Tegra114
Date: Tue, 11 Nov 2025 17:55:39 +0900
Message-ID: <3455911.aeNJFYEL58@senjougahara>
In-Reply-To: <20250915080157.28195-2-clamor95@gmail.com>
References:
 <20250915080157.28195-1-clamor95@gmail.com>
 <20250915080157.28195-2-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0004.jpnprd01.prod.outlook.com (2603:1096:405::16)
 To DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7f2fa2-8be7-4cac-c6fc-08de2100182b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGk0Z2RXTDhjTXAzR3JNVnlQVU5PSjAwWFFERDRBSDMxeU15WWdqZExsNGRy?=
 =?utf-8?B?STRWZDNwUDhBODUyM2JDTklGbGU3VVMxSjVlYUtRaGxqcURuQlpwZkJVR3ZQ?=
 =?utf-8?B?V1RWTlQ5TlpuVGhTVHVrV3ZiaFlhQWNZNFkwUmkxSzVUWUZTNjI3dktiWFd6?=
 =?utf-8?B?TkUzSm1hTEJ0b3ZlR0RVbmw3VzAyOVJYZ01UcGdpVXNCbG45bkZyMEY4RlY1?=
 =?utf-8?B?Q0Yrc2NxQlVWeHgxd1ptUjlzTW5IelVxNHI3T0JJTmRnaDJiOWV1MFhwd2ll?=
 =?utf-8?B?WGVkSGZWVEgrbDlhakNCWFpGQlZYdnRxSi9YMGpnYTlpcnUzKzJIdFpEOGxq?=
 =?utf-8?B?UEE2VnphbkJmWjVEaGNwTjFDdVBjOWxqNjNjMHZ6TDJKemNUMFBFLzhzT1Ny?=
 =?utf-8?B?TjNxejNPdFJrbit5WmRETHdmOUF1d1QzZ01BaEFpQW9RWnFRZGxOQ3pkNWly?=
 =?utf-8?B?WTZtZFlJOFhoYjR3ZGhUc3VpdjIvbHBET3EyYXVydmszZm1wMCtNaENNOXpL?=
 =?utf-8?B?aEFGay9oNVh0b0xJQ2J3YzB6TE9rWkF0Mkhxa2orU2w1VTVhcENQSEJpNnZ5?=
 =?utf-8?B?cW1US04rdDBnbHFuUHg0M0kwRHEyM0VkZHdMaDZ0U1ZFVitKQ1lIWEY4dnc4?=
 =?utf-8?B?QkJicUt0R2NYVGhoaDdKY2c0cXV4SXp3NlJjMCtrMVptOEEyUjRqMkpJR3Jx?=
 =?utf-8?B?d2ZTdXlvRmhoS2RHa1JldG4xTDJxNFFsSFU5eE85THdxRVBEcXlZZU91K3Jk?=
 =?utf-8?B?T1k2djNUYkQ0OTBJaXl3eUFjUjVkRGUxQnBUVGNtdkxDZWdaaXMyUnZoR0Vi?=
 =?utf-8?B?bERBVjZjMHhXWWZ3ak1RL3Nid1VKUEp1NHU2Vm5FSzJ2UWg3ZWhIZVZodEdp?=
 =?utf-8?B?U3phelFaQ0NmR3Urb0xHNENhU0xlL05aODZpWW9XaWk1VUE5N2VPanJrSm5l?=
 =?utf-8?B?bkZOUHExdW5HYnYwUDMyRUJVNzdmRFFldExsV2Z6UVROR1hZcEZWWGpkcHU5?=
 =?utf-8?B?MGFiNHlFTkt3RlRGT1pJVy9tYmx6YllxK2ZiNzBGTUlSQmdzV2c4WFlZSzNE?=
 =?utf-8?B?ek5zQVZNZ1U4ZDJEVHgwRkp6aDd5Z1JUZmZEV2NnRGdneklSYnJxMVVoUjRu?=
 =?utf-8?B?eWtSY2FKMjRUTmUxMkdRSW9ydzN4blk4ejVsWlcwVG13S1ovMnUwaE9Qclor?=
 =?utf-8?B?Z0Z1bGd2cXE0YmNvY3NQWVdJUGlyV1RiSWsxNG05SkFqeHZ1TldSeVdPZE9P?=
 =?utf-8?B?N3o5OHZkOWVtMjh5Nm81QkdQdktuQ245OFdPVEozeWRmWStCNWtNRzl4ci9h?=
 =?utf-8?B?TlVRSzVweDZmM1pPWEhlV292OWNnQ0pUWGFhUmxiVDFNb29HdVpyVFlkTXlJ?=
 =?utf-8?B?dnVXNzZVNXlOMS9KbzVBVXc5VEtjOUM4KzNzYklWemZpdk1VYTM1NzVlNStL?=
 =?utf-8?B?a2RKWG4zV3QxN1ZtREFzSlJBOUNCUnFLczBLa0lQVDhLTEhRWUIrL2VSSnNn?=
 =?utf-8?B?R2JyZkkzRmhVNVhLK3JHWitRQmxzeUtHbHpyQ25HQko2Um9yUTRmRFpHSk5N?=
 =?utf-8?B?N2hDeFU3Tm8ySkM5V3Q2NG9CWEF2aEsxdjdIYjhMTmkwZlQ1NjdvNDJvemd6?=
 =?utf-8?B?K1ZmQ1BOUGF0SVZKTUl2MkpiU2hZT0NKa0lWWE9CNWVkL21JWnFxdkdYRjBx?=
 =?utf-8?B?M3BMNW9NSTZKT2ZnS0lUVHdaMm5Edllld2E0bis0WEZ3SCtrV3hyNkVtZEhS?=
 =?utf-8?B?Z1dGZ29tdlhMMVBCRnJaM3IrMGdvdng1ZVltdTI3QlpIZUt6Rnl5V2tYUlpp?=
 =?utf-8?B?OStCMGNsVGN3Z2xTcUNEUXFFZEdLd05OTDBTV2d2U1NBL3VTbFFxaGl5Qi96?=
 =?utf-8?B?OVNLSUE3TDFTVVlxamFBcnBRcm5sZ3ZFYkJJUS9rVXFwOVhCdEU1LzcvT05z?=
 =?utf-8?B?dFhzVHJDc2YxZWpNS0pTN0ZiNExUdGdVWkRyNlJOT3dob3g4WFVpeVRNeGVi?=
 =?utf-8?Q?oPucP+h+dQMLyvUubAtA4b+EDS1uCM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHR2NkNHZlplZHBibGdvbDBxTytMLzJvU3grcUNER2xHSTlPSHNCS0U1UGtj?=
 =?utf-8?B?em16aHpIb0RCTW93ZGJyZThXVmNSWkxpa1VKeExFZzEzb3UwSlplc2NxVkty?=
 =?utf-8?B?QzRTQjZwd2x1SjNYZ3RWeXAydzQ1MmI1blNXOWo5azBabGF1b0FYYlVranZW?=
 =?utf-8?B?NW9vSE1yWG9DdG9obmRraXgxM0hHK3AzcGNGNXQ2UE9WYzUzOEpLaWhDOU1i?=
 =?utf-8?B?REJtaUlKUzF4MHVaMmFQK3drN1ROaThOcTgwcTZVYlB4TWdSZVhuTDNBZVE2?=
 =?utf-8?B?ZWptZnYydGVkVllsM2ltZkNWQmdJMjhmM2RqM1VLa3Y4bGhpNE9rTHN2VnJz?=
 =?utf-8?B?NkFDRHFjOWE4OXo3OUZvVTBleGpZS2hrSnZUSmp6a0F5cmhLODA5NkpLb1hz?=
 =?utf-8?B?SlZVNEdBc01DeGs1VUtsYkVUSmRqN2gyUEVpM3NCeURiVHRYU3c5V0RiMzh4?=
 =?utf-8?B?Y3BBU0kvaldkMEl3cmxNRHFaYTdVMG9tNkFnZmN5M1FoRHJ6TUFaTlo4b2J6?=
 =?utf-8?B?KzZHRUI0S21NdnlwZ1BoakYrR2ZyeDQ2d29ha1JhY0gwSUNWNnIvTHJ4VlN6?=
 =?utf-8?B?ai9UdTAxYjVDTW5GdUhMU3BlRGptUi9jYktoSU45UXZ6SFNXR1IvRmg1Q3RX?=
 =?utf-8?B?NUFxTHlyTkYyVDdGZGFzSmhHOE0rWnRsMjM2S1RrWWhBeEltTFVKa3JpMjll?=
 =?utf-8?B?RjRIS3lPdkRLdytFTXduSmJUUUswZTRDU2xHWFc4OUJzSkIxWi9NUnJLcmpY?=
 =?utf-8?B?VHQzTUNFQ0wxYmJCTGpjcFYxVEp0d1lQMWJDSld1b3o0WjBaSHh6K1JFWksv?=
 =?utf-8?B?d3VubTZqcm9pWERwZitEcmJSU0ZJUmk4ZE80R3NNdDZ0azdyenlaaUY4WEU2?=
 =?utf-8?B?YWlVR3hQUUxKUzBFWGcwMitDNXROM2RLYmlLRC94UnFrQ3RTM3B5cWlqeXBP?=
 =?utf-8?B?cEhnNTNlbEhvU0lSRE43blVnRDJocHFhQ0dCVUt2ck9tWTB3bFluV09GQVcw?=
 =?utf-8?B?Q3lDTkpNZkMvTGRVOUJsOElSVTVIdFRRNzFOU3pEbS9KWjIxYzlCQUVmbSt0?=
 =?utf-8?B?a1VzZTdQWTc2TlAvQmMyUVdCZk1vcWFRcVNiUUx4VVEvTDhCc0kvWnAyakRy?=
 =?utf-8?B?UWJxS1ZLd3V2M3BQVG9DeFlJUWF0UTBEOFdXaW1SUy9Qc21jWHJVeURTRzM3?=
 =?utf-8?B?Qmp0eFpqMXMwUS9IVG1QRU9JdEl6b1R5anlXUlNCVFRDUzcyMEJIKytCSFBB?=
 =?utf-8?B?Wk5QVEdkS2h3eXRxRDBiWDlKNE9GV0w5TjJPMndaYWM0dEpKQWI5ZWRJb3dJ?=
 =?utf-8?B?STAxNHppa25PcnBLSytVU2VSREs1RVVnVW4xMDNKWk9WdW1ValR4eVZEakRl?=
 =?utf-8?B?ak10eU5HWDRhUTZsQVZDMFR5RFAvYjNjUnRxVXltVmYva0NNNTFKcG9IUXFO?=
 =?utf-8?B?WGhtTjdHRzJoaHJic1M0MXErUzFiNktaVmhsQ3g5TlBHdEdDdXhWZ3VJbDA5?=
 =?utf-8?B?Q1A2QmgwaGhkZWE5ckIvLy9jUzluTi82d2M5ZU5MSlhnMjc5dkVtZ2ZIV3lM?=
 =?utf-8?B?RHgrajBnT0ZMV1hVSG16WHJGYWtkNnhZQVlqQWcrQyt6RGZqZHB4cTBOL2Yw?=
 =?utf-8?B?d1VlREc1cnVsUEp2Y3ltbmlVcUJJMXRwTUlwb0t5M0YydTVZZ2M2anBqclky?=
 =?utf-8?B?TVNxbUwrNDRSbUhtOWgvTVhGblNvVW14Ym1aNmduMFJXV0xJWW5iOFh3VnZI?=
 =?utf-8?B?VURLaW14aUZFREtnS01US0RrSG9wVzMwQ0o5ejR5MlBiOU0zTzJDNCtKTEg1?=
 =?utf-8?B?N1VkejhMUGJjMUFOMGR5S2ZRSExPeHZWbEYwS2RSMnR0b3lram10b3ptQmpF?=
 =?utf-8?B?UGxDK05ucTF3V3NFY0EwYk5SMmJtaVB2MS96UU5NZUpLWTF5U1owVEkrLzl2?=
 =?utf-8?B?QzNaU0o5MzYyaU1Md1JPQWYySWozdC9MUHltZDZWZ3d4NFVGQXJnMC80Y3Z1?=
 =?utf-8?B?ZEE3d3NGMGs1YytuYXU5T2VvOUhtdjJPK2w5STI4ZS9NRFlWRkVQUWJuUWs3?=
 =?utf-8?B?K0ZhWnJhWUlCOXh0OWtQZy8wQlg5NDV0Q3Nsd2dnaTI0STdQRFlweWdiMlZT?=
 =?utf-8?B?bTJ0Wkl2azlaQmhPZW5BTGJjcXJ2OUtpcmZzYlBONXU4VVpyUTQ0UkQwUjZZ?=
 =?utf-8?B?b3VMUTdaejZlekNBWGxaNXUrOXl4SndMQkR0YnVjMTk5Wk84V1V2cUs2U2xx?=
 =?utf-8?B?cG5DMjFuWDdsaHdxNk9LWnJiT293PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7f2fa2-8be7-4cac-c6fc-08de2100182b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 08:55:42.3691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzxtHWh5r8bk4VLh2yCnYTy5ksSMBBlvE8hafNiXAvVkZCLB+en+3hv2Lq9nc1VGSXK/t+lYWegj6Ijzl9iUAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568

On Monday, September 15, 2025 5:01=E2=80=AFPM Svyatoslav Ryhel wrote:
> Lets add Tegra114 support to activity monitor device as a preparation to
> upcoming EMC controller support.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-=
devfreq.c
> index 8ea5b482bfb3..d976077d4757 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -980,6 +980,7 @@ static const struct tegra_devfreq_soc_data tegra30_so=
c =3D {
> =20
>  static const struct of_device_id tegra_devfreq_of_match[] =3D {
>  	{ .compatible =3D "nvidia,tegra30-actmon",  .data =3D &tegra30_soc, },
> +	{ .compatible =3D "nvidia,tegra114-actmon", .data =3D &tegra124_soc, },
>  	{ .compatible =3D "nvidia,tegra124-actmon", .data =3D &tegra124_soc, },
>  	{ },
>  };
>=20

Looking at my copy of L4T r21, the EMC count_weight should be 256 on Tegra1=
14, while it is 4*256 on Tegra124, so different SoC data should be used. (I=
 haven't checked if anything else is different)

Cheers,
Mikko



