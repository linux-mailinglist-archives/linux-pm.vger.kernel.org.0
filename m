Return-Path: <linux-pm+bounces-41270-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCXDG6u5cWnrLgAAu9opvQ
	(envelope-from <linux-pm+bounces-41270-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 06:46:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D69620C9
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 06:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C1FA4EAFE1
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 05:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9606B47A0DD;
	Thu, 22 Jan 2026 05:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LXTxGt2H"
X-Original-To: linux-pm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD027F18B;
	Thu, 22 Jan 2026 05:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769060772; cv=fail; b=nGes7JMyY3fjRMYUL0mbqfuRd33m1L/Jmoo1m35yEVa5IdrKEmLNNRspn+XHYeU6hpEObdHnz6D1ocCTIoDTcgyhqF1cd/+EP2DH4S2/nd/Lz7IQWBk1TBdw9VXkvUYNt2p88H9OQa81Q5ADrYMxQbtPt0DVM9XMxaAv0CR2lZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769060772; c=relaxed/simple;
	bh=sjVoiXk7Pf5RTR/OKOrT3wisnTGcftsCl9CI1VwgB+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uL1IRt33+wPKntktBsTnTTjJVqY3RJmGBd3tOtj5AjBdYxvx7DsCwi+Onm46f+YR6Adb/dp30qCDCmvKkwjVL0aXDko64qTHJL1FUUYnOB8qad1XtjOU8yi+U7qIOUvnGLylsYXwvGGhpBR6xxLuBirhudFFJS7ORG8B2QVGl/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LXTxGt2H; arc=fail smtp.client-ip=52.101.85.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEK7JwpwooriPFybQcI+OWfDuGNZjcRnY1tC/JsigwYW2eMzl8b7+N/Aq2Wr+kHeExA3x5d8T+kSgiFm+UfpzONWaHl+gE4ACQzCE9zoLkPyDTCoNTqcwOsk1DQwhH6H1vJcME+TTCK0gW3BPDBxV2L3M2pP1ItFBH2pL8rAYg/iZ32CLZdj/reBSg3XspLeS/j1pUICHMU4au/Y2MvFnvKQ489pvvZGSNkNUWGGFLkZhH9BSFHozyZwc/9IO31EWrqHQ9btMsVweiR1dADkL/7SG+S9pQkZU6ngHOzudDGipsMOsxufcD/yFVBtPYqX7Tj/gjQGD8yuk7twsMplNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LUCiAYgljG6cPJ0g2a/4/hrpHA/FCZGOlvHufOxhUw=;
 b=ONZect4qOBrICgo9Hxwffe4p26N/QXImJqaDnHfYuTpFnHnPoH4JP2dx837xyTkH+MYcaNOIiWzO+ajkzm2a2IBWmskBgDNkaztIOLPGgds1fHaQinhydnCcv2zRhVJmzGQc69wTtAJfhrjX+J40rJ1vUwvlWZZ630WROh3dyA63gY5rZ/sX4jh/hH3AS9tzcQxxeWimj0l8eSgN2SxnSwIgPxEF+1Cu0hE3mNZDeJXX3Ej/E/qOl+ylfudjcDece+eidbjaF8bCltpVB1gTKBFUEedDNyZrXM668hISBZ8WQD6FMv4S1x5EjUeqSZxUqFssC49K6v1YvfTXR8PIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LUCiAYgljG6cPJ0g2a/4/hrpHA/FCZGOlvHufOxhUw=;
 b=LXTxGt2HgOjs3bOKxdtdPVGS1rfsMy0X6dG/QJaJwis58MHe4+3rLOCk67Upe+vuE8a3juB44naTHk/N8x2ywQBYmQxIZl4AgluhwOSjNVnGgBlNlOVlSJtHvCA6JeL1KKIn0CsKDRpi+wuM4cy3lsCaBVYrcIg+IeNqt/M1rwi7UzQb1Y2aO/a/ajZtSdnvQg/qjwnodsijl4hF0kviKHYCkJ6hEd/1PY3zSvsNX4HzbouGqa3JsJU2FnedwED58+7wAgiLQGw1KiiDH79sZJ9SPvqe7tJgxxvkLi6qmcXe/RKgzRTp4E4XlAz4SFZg3bvTxig5B/pkDVK0Xz2aDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 05:45:52 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93%3]) with mapi id 15.20.9499.002; Thu, 22 Jan 2026
 05:45:52 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v4 11/12] ARM: tegra: Add EMC OPP and ICC properties to Tegra114
 EMC and ACTMON device-tree nodes
Date: Thu, 22 Jan 2026 14:45:48 +0900
Message-ID: <7678982.MhkbZ0Pkbq@senjougahara>
In-Reply-To:
 <CAPVz0n1zqo1TyaV=+fc6YzOKH9TqOBEatruZTAVGg9hFEWmXsQ@mail.gmail.com>
References:
 <20251125120559.158860-1-clamor95@gmail.com>
 <4370037.mvXUDI8C0e@senjougahara>
 <CAPVz0n1zqo1TyaV=+fc6YzOKH9TqOBEatruZTAVGg9hFEWmXsQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4PR01CA0112.jpnprd01.prod.outlook.com
 (2603:1096:405:378::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 87657f2f-dce4-44b4-1155-08de59798110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0RIb1pKd014ZFA5Nkg1OXdGbHBVYlhMUEJpYmlBZnRjcGFIY0d2cjlBbWZ1?=
 =?utf-8?B?NGpVTzIyRVBsOFVMQ3dtMHZ1ZjlOZ3hJaHlFVHN3OE9QS09uWmZEUXl6YU5V?=
 =?utf-8?B?UkJvckFwZE9weFhSZ3RMSjhYUnpiWGhZa29sU2dOMkhRNU1Tc3d0OERZb0NQ?=
 =?utf-8?B?QVlDYldEbXdzTWRWY2NuYTRuUDVNeGpOMi9OSEl6cXR4T1p0emp1RGpMWG1H?=
 =?utf-8?B?T3BqRlcraVlzVSs0K1NBUEJ0Ym1XdnB0WFRkeUVOQTZQNElxaG5nOEU0OHZm?=
 =?utf-8?B?UVRlTldZUzN4R3F5bnRTS0IzdVplZ2Ruc1NBa0IzR2JtNStwOXMyNDBlc1Vr?=
 =?utf-8?B?ZDV2ejNJbGZjNzZVQ3cwN0E3NUh6di9pc0x5alNRSkloa3YzbUFpemlSUWhw?=
 =?utf-8?B?M1hLc1JEazRiQVZPUW4xYlplQ2FldXlTV0JldGd1N2hNamtYKzFiK2p3T3po?=
 =?utf-8?B?NTNyZ3JNSWFyaDA5RHUySlZRb0UvQ1MzRDVHbjhucVhockFjQ1dDbHViNmo2?=
 =?utf-8?B?Q2VwTmx3WUk5N25tWkNSeTZBS1hUdmhhQUdsMCt6NEVZMHRBdnlxaWxEM1RM?=
 =?utf-8?B?M2xSTXYzNG5KQWNlM3UrNGhMNjdmRFo5ZWlNenRoaDFpTU9XOVdEVzNiWHUy?=
 =?utf-8?B?QzBTRXBudUFjd1RpWmNzMnhuSkpqOVVpTFJQK3dQekY0QlJWWlBYS2VIWmhP?=
 =?utf-8?B?c1JQT0JRalQyMndwbWNpa1BzUjlNcVVPQmFXNU9iajltbmhVMWRES0orNTRX?=
 =?utf-8?B?MWpVcjVoNDRIcE95R1FDajNHQ3hhYXNWSDJKTUZEZ254akhDODh0VGJPelZZ?=
 =?utf-8?B?TkRKWmZPcHNMY3Z5NkhQaFQxQUlaTkJjU3JCWHdNV2pNSFNkc1FSNWJacmpa?=
 =?utf-8?B?djZWZ2dicEVqREVzTFZybDVIQW9NL0xzeGVwdUgrYU4vcmlXK3h5Y2g0cHVm?=
 =?utf-8?B?dU5FOTFiQkJtc3dOV0xRTGVtbW5ubWVhd1h1Ynd5SHBWSlBsQk1vZ1dnWjVR?=
 =?utf-8?B?RkNTcFlVVDEyNXhLbU80aXY3L2JvK0xRczByWm1Nd2pBWHAwUVd4cksvVlll?=
 =?utf-8?B?Qmg0dFUxTjRZQ2FUeU5OaFQxRVdneG9IRVRKSVNSYmduYkFKN0FmVFpNeFp1?=
 =?utf-8?B?Nm1rNENNTzd2ejg4bUo3ME1BM1E1cTV3c3NkaDdtWTdCb2hxdnUvNFRFa1Q1?=
 =?utf-8?B?V0FaQU9ybEJLeDB0Z0RDejRXYTBnMkdZNU1uK08zNUZ0Rnl6Tm9VNHE1dU5r?=
 =?utf-8?B?UFJNbzVMOFJKelN6MnZFa0RLeWdDcjhNeW1qVkhNSmJZdi90UFBuQ1UvL2FJ?=
 =?utf-8?B?RWc5Q2lzWFhyVWJ4MUl4VnI3WlN6aHlySkpMaktla1JWRnE1eGwvRmxhS2Vw?=
 =?utf-8?B?SUxNZ1V1TXlKdWtiNEN6R3NWNW1vVDMxN3ZkYWhaRE9FQ2tPTE5RQko3czll?=
 =?utf-8?B?bElBMVpIbWJOaS9naEszSnF2L3pxQzlZUXZreXM1VS9WYWh3bkYwMDBBV1V1?=
 =?utf-8?B?Z3doQVhvWC9TWUNPbUE1WU1CWndqQmV3V3d6ZHJxbDJ2SWR6YjdlTjl5cUZ0?=
 =?utf-8?B?cFBHN3NsSExBeUpWWkh1encrY3VLem95ZHJQUXFDaG10cW9DeHorS1pLMllU?=
 =?utf-8?B?YWdCdE1CTEdVampRTG9oY2JaSlVsYU1uVnhuMjV2OXdHTUFaOVVLUmp1TWpB?=
 =?utf-8?B?SkY0a1ZzNlhnZE5lbWMvTThMK2dmN0sycVNIOWZ0ZE5OR0FEY3JMb0FZYXlN?=
 =?utf-8?B?ZTVodHV2RTEzaEdKUy9GV3pPS1BKdzFvS2VFamVoVVpUVGtYei9PKzRvenJC?=
 =?utf-8?B?cWVNNFcySVRUUHlNcHJDamhEWFhkbGpUMXhTcDhiVUkxTXFDcHk4TytLelJi?=
 =?utf-8?B?Q2lEbHFXaDRnc0x5RGwvcnpzMDdzWlRoR29VY0lwa1JhbC8yZHpPcXl5Sy9C?=
 =?utf-8?B?VTNWVGduVGtWcUIvLzZwZjRzaHUwT09SYU01Vk5iSkhiYkxqd2tLbUtuNTNw?=
 =?utf-8?B?akhQQWpnRyt2ZXd6ZFZwREFxbFhKMUhVeFlhZGlMWmc4bjlFdENZLzRCQ3Rk?=
 =?utf-8?B?anYrVDRIUG9mTDVEYmZBQTZuajlmbnVwa3lrbXhwVjlTcUNmc1l4ZnVXbjFn?=
 =?utf-8?Q?akAU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0VvTmtDZ1k3NWg2VzVHWlZkS1cwWE9uNitVaHRDY0JBWmhiSGNWckp3VTRt?=
 =?utf-8?B?NllLR2VXOFUzQ2p3TDF1dW9mWmZOWVg1eXFtUy9XQVBkZVl5VzBsS0srNEVH?=
 =?utf-8?B?Wkx0aHRSdGJnN1hIMUZ0ZU9hM05Vd3E1aGNVOFZDeTkxNG1vYlNvOHZtWm5E?=
 =?utf-8?B?TmFhZjNZSWNpK3hNUzdYT29OZXdwQWZmR0JFMFNpUHJrYzJkSG1Lc3hQdkpN?=
 =?utf-8?B?aWE1Rk9nWHNhZlMzK0oyMm9IUWx2ZUhyK05qSU16ajNKUlBLWExIY0FKYXZx?=
 =?utf-8?B?T2FKRWVCaFJmMVRJSnltOXZOdWlTcFpvcUxNYU5JcXpnQUhTNVpkckMwZWJt?=
 =?utf-8?B?TEtybDBWNWJiYmErYlhSZkg4MHI4Zm50VS9UTEhINlNYYjIwN3lNOFZ3d1BM?=
 =?utf-8?B?MXFwVDlhTFk3aUR1eEh3b1FsK2JHakl4YkVNZEtLeCtlaTFFb05iTncxazJK?=
 =?utf-8?B?NDdsQWJ0RGFzR01FRnBFNitkZEhieEcyNnBqY2JkT21wOTlmbkJJM3FDOUth?=
 =?utf-8?B?WStXb2d1WU5BSXh5RHIvc0JsbHBQam5WbjYxQzdVOXdkWDNTZ1o1WmVxTElJ?=
 =?utf-8?B?VENXcjIxN21QUXRvVEJjOVRkNnRyRHB5Nm5qL0JFaDZvc2VYT0RNaU9VQlll?=
 =?utf-8?B?S1hVdG8rejV4dzFnT0xHYmRkbE9PSnptLzVwUlR3U3luMW5vYVVpMjJONFps?=
 =?utf-8?B?TkhTV3UreTZ2QnM1UnIwSzRmSWFaQWIxYkUwZHkxWXJ6MUpZRyt4dmEzUitE?=
 =?utf-8?B?c09IaUQ0aTQ5a0JzNWJZdCtGMDN6cFBYUGMxZmtQdXVlZnV3SFpuMU9tblYw?=
 =?utf-8?B?akY5akRqcDlHdktoMkZxbEJ4cWFENXF2T2pPd21XYnBtUXp6Qmk3eG9qQnFO?=
 =?utf-8?B?UFprY2l4clZ6czRHUkQwWGt6cG1EK1lSeE5EOWd1ZzE5eTQ2azFTTzMySnd1?=
 =?utf-8?B?OXhyRC9qcklWejBCVzA3Z01ZWnc2dDRTOFBsd0VFRklXRzBQVDJVcmdwVngx?=
 =?utf-8?B?dHp3b3IxZWs4ZFRPck5yRWxMSnB0S2o4OW1ObE5DdXl4Q2I3dWVIRzlIUExI?=
 =?utf-8?B?Y1R6ZitpUG5oWDJTa3RQWjBXMjBEY21PNVA0VndtK3JJVzNxSVBaQ0RLN1lk?=
 =?utf-8?B?UE5lV3ZaVnlEUS9iN1FuN1VNTWZBTnI0NlJtTWU5U2hPUEJFRWF2bXZBTUJ5?=
 =?utf-8?B?YkVCWmpkK2xuMTdtcVBaZkxRMlIyRzRmRitnSkFHemhSWVNtU3l4S2QvWXlC?=
 =?utf-8?B?M09vWGdnVTZpNkltZGZjRzlDWUFmKzJFY1p0aU5kNGxVOFJFc2xlTjhFSVhk?=
 =?utf-8?B?V2dmVThYWWI3d2FYWmVaOVhGRk81M3dlUXhYVi9wUXVNT3dFU1R4bWc5QU1r?=
 =?utf-8?B?QWV5MHBYelp1TGhZeStId0tGNmhtRVcyYmh2Q2QvVXZ0SVh4L3pMR0kwTXRa?=
 =?utf-8?B?ZjBKeThzZjVOQWhYSmdQV1VyNnZZOXh3WURNK3VQSEdlYUVKK3laUjJJbHAw?=
 =?utf-8?B?TDEzcTUrOXNCMFhnUGpSdGIyTFVPdFZLNVNGaDJZdktyL2F6VDBybGR1WmJs?=
 =?utf-8?B?eEdCUDF6TklnMkZSR0JhT1l2aFF1cGdHS21pMk9SMGVtTHV6QlR6RUNSSmNR?=
 =?utf-8?B?OTczOS91QjI0NjVZQ3Z4citsaUZ2N0FTQTJSRm0zQzcxdGdIZk9qN1NlUFlw?=
 =?utf-8?B?WkdQSzR5VW9tbW1yYzIvYUpSeEJtQk5EdG1DWU1GTlY3ekhiSW1yWkx3Y29l?=
 =?utf-8?B?VUtRa0VEdHltYW9oWjF5c2ZBUVJncHB1ZDZSei9yZW5FaFJ2V1d5TDd2MWVR?=
 =?utf-8?B?VjAvUGNobHBzd3ErNlQvbWhQcS9NNzVTRHNnbkJhTWZhZ2xvOUxuSnBncnJB?=
 =?utf-8?B?ZU1QTzBNRTBtWVJJZ3QvRXlzN0dKaXZWY3dISHVuUFdBRURPYW4wNDZjc3Nq?=
 =?utf-8?B?cTVCQ05DRXY5YlpCVVR2eXQ1czNYcGZNR01jZ1hoczhQVmYvbE84Qm1xcmIr?=
 =?utf-8?B?eUxWN29SSEp3VExxRWNlbnl3Z2JnK1Q4dnc3S1VnYVc5YlBlb1dLUjJpSnNF?=
 =?utf-8?B?VHhGR29FSzBmc2I0SlpKTFFjWFNlVzhVc2xyb2VuQ0oxMEdFcTYrTjJKYWJV?=
 =?utf-8?B?dlpidS93WGlnT3pIdW1WVFRDbWRqUDZTMHdxdWY4eHRBRlc5OE1JUDEzSHlq?=
 =?utf-8?B?Rk8rZGtRcnljZ2RPWWJKVVlyS1BPcXh3YmhYaUczTTh1V00vMnNKQnh2cjQ1?=
 =?utf-8?B?Skg3R00vVnVwc2RNUjN5ZnJmZmwyTitrbGthMlAwN0NXd0RwTHc5RzhSbGJt?=
 =?utf-8?B?ME1JTmJqQjk4M2Z4aEk5K1dVMUgvVnp0dEF4M2xPVnplaWlUV05sNmg3M1c1?=
 =?utf-8?Q?09gjIlZuAaqiB1oYNw3zXwrfYmmCRtvIKjwJgtGH9f118?=
X-MS-Exchange-AntiSpam-MessageData-1: nj6nWhr5/t2Wrw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87657f2f-dce4-44b4-1155-08de59798110
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 05:45:52.6501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfa/ulBE7v1wgpVfIHm0DRJknkrdVZMxb1e11xsSCTEr8hwYleJrbeWH4ThaBT0sy9YbAuYKP1veF4DtukfMBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41270-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,gmail.com,baylibre.com,samsung.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pm@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim,4.44.146.176:email,7001b000:email,4.44.103.184:email]
X-Rspamd-Queue-Id: 94D69620C9
X-Rspamd-Action: no action

On Thursday, January 22, 2026 1:57=E2=80=AFAM Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 21 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 09:56 Mi=
kko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Tuesday, November 25, 2025 9:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > Add EMC OPP tables and interconnect paths that will be used for
> > > dynamic memory bandwidth scaling based on memory utilization statisti=
cs.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../dts/nvidia/tegra114-peripherals-opp.dtsi  | 151 ++++++++++++++++=
++
> > >  arch/arm/boot/dts/nvidia/tegra114.dtsi        |   9 ++
> > >  2 files changed, 160 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/nvidia/tegra114-peripherals-opp=
.dtsi
> > >
> > > diff --git a/arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi b=
/arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi
> > > new file mode 100644
> > > index 000000000000..1a0e68f22039
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/nvidia/tegra114-peripherals-opp.dtsi
> > > @@ -0,0 +1,151 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +/ {
> > > +     emc_icc_dvfs_opp_table: opp-table-emc {
> > > +             compatible =3D "operating-points-v2";
> > > +
> > > +             opp-12750000-900 {
> > > +                     opp-microvolt =3D <900000 900000 1390000>;
> > > +                     opp-hz =3D /bits/ 64 <12750000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +             };
> >
> > What's the source of the opp data?
> >
>=20
> I have used tf701t (T40X) and tegratab (T40S) kernel sources, to be
> more specific board-*-memory.c files. Timing struct for each clock
> contains min voltage field which was used to compose these opps.
> 1390000 is the max core regulator voltage, taken from tegra11_dvfs.c

Thanks! I also looked through SHIELD Portable (roth, T40T) memory tables an=
d this appears to match except for the 528MHz opp.

The opp table here is setting the voltage for the 528MHz opp to 1050mV for =
the high end SKUs (T40X and T40T)[1] and 1100mV for the lower end T40S, whi=
ch makes sense. However, the roth memory table (rel-roth branch) specifies =
1100mV for the 528MHz opp. My understanding is T40T is supposed to be at le=
ast as good silicon as T40X, so it doesn't make sense to me that it would r=
equire a higher voltage, but memory timings are a dark art and I would err =
on the baseline side and keep the voltage at 1100mV. Let me know what you t=
hink or if you have additional information.

FWIW, roth also specifies a 900MHz opp. I think in principle T40X/T40T in g=
eneral can reach this but it might only have been characterized for roth.

[1] T40X is SKU 0x3 and T40T is SKU 0x4, and these are mapped to soc_speedo=
_id=3D1 -> supported_hw BIT(1).

>=20
> I have converted an entire core_dvfs_table table from tegra11_dvfs.c
> and I am planning to submit those later on too along with
> powergates/domains configuration for tegra114, but that is for another
> time :)

Sounds good!

Thanks,
Mikko

>=20
> > Cheers,
> > Mikko
> >
> > > +
> > > +             opp-20400000-900 {
> > > +                     opp-microvolt =3D <900000 900000 1390000>;
> > > +                     opp-hz =3D /bits/ 64 <20400000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +             };
> > > +
> > > +             opp-40800000-900 {
> > > +                     opp-microvolt =3D <900000 900000 1390000>;
> > > +                     opp-hz =3D /bits/ 64 <40800000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +             };
> > > +
> > > +             opp-68000000-900 {
> > > +                     opp-microvolt =3D <900000 900000 1390000>;
> > > +                     opp-hz =3D /bits/ 64 <68000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +             };
> > > +
> > > +             opp-102000000-900 {
> > > +                     opp-microvolt =3D <900000 900000 1390000>;
> > > +                     opp-hz =3D /bits/ 64 <102000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +             };
> > > +
> > > +             opp-204000000-900 {
> > > +                     opp-microvolt =3D <900000 900000 1390000>;
> > > +                     opp-hz =3D /bits/ 64 <204000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +                     opp-suspend;
> > > +             };
> > > +
> > > +             opp-312000000-1000 {
> > > +                     opp-microvolt =3D <1000000 1000000 1390000>;
> > > +                     opp-hz =3D /bits/ 64 <312000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +             };
> > > +
> > > +             opp-408000000-1000 {
> > > +                     opp-microvolt =3D <1000000 1000000 1390000>;
> > > +                     opp-hz =3D /bits/ 64 <408000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +             };
> > > +
> > > +             opp-528000000-1050 {
> > > +                     opp-microvolt =3D <1050000 1050000 1390000>;
> > > +                     opp-hz =3D /bits/ 64 <528000000>;
> > > +                     opp-supported-hw =3D <0x000E>;
> > > +             };
> > > +
> > > +             opp-528000000-1100 {
> > > +                     opp-microvolt =3D <1100000 1100000 1390000>;
> > > +                     opp-hz =3D /bits/ 64 <528000000>;
> > > +                     opp-supported-hw =3D <0x0001>;
> > > +             };
> > > +
> > > +             opp-624000000-1100 {
> > > +                     opp-microvolt =3D <1100000 1100000 1390000>;
> > > +                     opp-hz =3D /bits/ 64 <624000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +             };
> > > +
> > > +             opp-792000000-1100 {
> > > +                     opp-microvolt =3D <1100000 1100000 1390000>;
> > > +                     opp-hz =3D /bits/ 64 <792000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +             };
> > > +     };
> > > +
> > > +     emc_bw_dfs_opp_table: opp-table-actmon {
> > > +             compatible =3D "operating-points-v2";
> > > +
> > > +             opp-12750000 {
> > > +                     opp-hz =3D /bits/ 64 <12750000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +                     opp-peak-kBps =3D <204000>;
> > > +             };
> > > +
> > > +             opp-20400000 {
> > > +                     opp-hz =3D /bits/ 64 <20400000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +                     opp-peak-kBps =3D <326400>;
> > > +             };
> > > +
> > > +             opp-40800000 {
> > > +                     opp-hz =3D /bits/ 64 <40800000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +                     opp-peak-kBps =3D <652800>;
> > > +             };
> > > +
> > > +             opp-68000000 {
> > > +                     opp-hz =3D /bits/ 64 <68000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +                     opp-peak-kBps =3D <1088000>;
> > > +             };
> > > +
> > > +             opp-102000000 {
> > > +                     opp-hz =3D /bits/ 64 <102000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +                     opp-peak-kBps =3D <1632000>;
> > > +             };
> > > +
> > > +             opp-204000000 {
> > > +                     opp-hz =3D /bits/ 64 <204000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +                     opp-peak-kBps =3D <3264000>;
> > > +                     opp-suspend;
> > > +             };
> > > +
> > > +             opp-312000000 {
> > > +                     opp-hz =3D /bits/ 64 <312000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +                     opp-peak-kBps =3D <4992000>;
> > > +             };
> > > +
> > > +             opp-408000000 {
> > > +                     opp-hz =3D /bits/ 64 <408000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +                     opp-peak-kBps =3D <6528000>;
> > > +             };
> > > +
> > > +             opp-528000000 {
> > > +                     opp-hz =3D /bits/ 64 <528000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +                     opp-peak-kBps =3D <8448000>;
> > > +             };
> > > +
> > > +             opp-624000000 {
> > > +                     opp-hz =3D /bits/ 64 <624000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +                     opp-peak-kBps =3D <9984000>;
> > > +             };
> > > +
> > > +             opp-792000000 {
> > > +                     opp-hz =3D /bits/ 64 <792000000>;
> > > +                     opp-supported-hw =3D <0x000F>;
> > > +                     opp-peak-kBps =3D <12672000>;
> > > +             };
> > > +     };
> > > +};
> > > diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/d=
ts/nvidia/tegra114.dtsi
> > > index a920ad041c14..6221423b81d1 100644
> > > --- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> > > +++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
> > > @@ -8,6 +8,8 @@
> > >  #include <dt-bindings/soc/tegra-pmc.h>
> > >  #include <dt-bindings/thermal/tegra114-soctherm.h>
> > >
> > > +#include "tegra114-peripherals-opp.dtsi"
> > > +
> > >  / {
> > >       compatible =3D "nvidia,tegra114";
> > >       interrupt-parent =3D <&lic>;
> > > @@ -323,6 +325,9 @@ actmon: actmon@6000c800 {
> > >               clock-names =3D "actmon", "emc";
> > >               resets =3D <&tegra_car TEGRA114_CLK_ACTMON>;
> > >               reset-names =3D "actmon";
> > > +             operating-points-v2 =3D <&emc_bw_dfs_opp_table>;
> > > +             interconnects =3D <&mc TEGRA114_MC_MPCORER &emc>;
> > > +             interconnect-names =3D "cpu-read";
> > >               #cooling-cells =3D <2>;
> > >       };
> > >
> > > @@ -655,6 +660,7 @@ mc: memory-controller@70019000 {
> > >
> > >               #reset-cells =3D <1>;
> > >               #iommu-cells =3D <1>;
> > > +             #interconnect-cells =3D <1>;
> > >       };
> > >
> > >       emc: external-memory-controller@7001b000 {
> > > @@ -665,6 +671,9 @@ emc: external-memory-controller@7001b000 {
> > >               clock-names =3D "emc";
> > >
> > >               nvidia,memory-controller =3D <&mc>;
> > > +             operating-points-v2 =3D <&emc_icc_dvfs_opp_table>;
> > > +
> > > +             #interconnect-cells =3D <0>;
> > >       };
> > >
> > >       hda@70030000 {
> > >
> >
> >
> >
> >





