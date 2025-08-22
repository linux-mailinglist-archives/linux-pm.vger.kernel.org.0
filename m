Return-Path: <linux-pm+bounces-32850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A9B30C1B
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 04:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A8307AD790
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 02:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCC3223DE7;
	Fri, 22 Aug 2025 02:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NYdRwLGi"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D9A57C9F;
	Fri, 22 Aug 2025 02:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755831510; cv=fail; b=WMJ8oSLD9xkB8WhIO9Efy8yWMEDcy80Tj/F8wEoEUx0ivVRf8CpVsD+5mSaHvXngqar5G0POi2jmE9LQMi9DVJvuWMUwh3NqCY2+tqNGJIguPx7NuMgHcTWPdYAZxj9F0PWJy2b1gNlhgCpSsar3CIvPDAiZgNRLo1ZfbRXcb18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755831510; c=relaxed/simple;
	bh=DAOmvxcOK4R//SgoEHcDkK2bG9pP67o4tWwFWhnr1ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QbV9UZ/iprAhVg0CtEdWYYFiWi9F3kRCQ9bzij5uzGR/El5J6wpd59s3kjSZCg86kd+ku/AQcoh8tuuVFOWHnbLS4D2+WEEkaC3tgQPS1JwDyuqttTO7s/kSY+AxTya0mPPY3z7A9tr3IpINKdGMYfqmOP8AjMgRlPbO09wz/Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NYdRwLGi; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdrTTO7k4J5ei8mtNllqsVFpNZ/GQIkkmoHr/7aNtfdRMjn24hXJMElclSsHeGY/0A/xLWldqrvfdw2uFW2w2zApHNuuEO0ZDJUVMlT3S0ppSua+FM6pao4X1Y35oNwCA3HqzENO+dFDlB7X6RclRYwLxGBkI9OKzCGKwiKkRnyBpnQGqN8HqVKkGQe1wzLlv4qf/+ax7322V8A5Qpe/NcB/7FDsYGw/myJthxM/S+MMXkjKkpZ/fMKBrNLZyrWtAV1mC/DvMy7vctteVwYWBAZ2Q7mw1Qg7fOwyMiP6/eYtMxiPYBK1HsKrPiOeHi62OkEZJ2cjM08E0/WdcGb3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qt2Pyt/b29wDa6tlMEfuPoVAhjD2TiMPQdkudZLUxMM=;
 b=XO2g1+GtmU5G/M6IfxvwQjLXbCnx3/tx70PWYKx8pX7eyDa8LuWBTvolqAO3cNV8GymAisAdTuDcpPcfnWxWl4navxz294PPJPZKQFNvvZHOrVUKhqDAwsG5RRdRn9J0DebsalCGyR+aB8KpM2WEz2tF1A8/trdSTXpKtbc7HrqTiPa5kSKvXT1sGZw4tvP+QcSBTgDFkUExx+0ZpfsEXbOFCe8hxF8z/2j3XJk/q3VDI7HB4sPJxj+mYrPJdIKhZr5MXTUUI4kwkS8yAXCzsrOrR7yGfwT0j0oc1vRPzrcevyCgzesgtv8BJJMdYkRpKsEc8uGMqcMYjj3wUgKQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qt2Pyt/b29wDa6tlMEfuPoVAhjD2TiMPQdkudZLUxMM=;
 b=NYdRwLGigUf06kod/7K3/WOvQ4h7aJ1NH4okvH9H1kVZnGZdMUdEmY7M/zzh7UHDhvP+aQAafWIUyfUb1hhCHBtqaaPzvWfWbUJdC1mKu6rbBLsugdgR6bb10T2nlsUBrnvR172UAHNtHo6XGiqcNg7P9YXLzhm+aGMZQMBu1VpPL1m14yWcGddzbJEVX7uwXm2L4w9SLwfoOxSZ0XZ1mhdF3dbN5EVPq/7uCAyYQohJRayIv1r/y2Y6pOEK8cWbIa8yrx4OPczRdFzA1kJlPmULsQ/Y1a3GrAOHw/MMiHX8vcTbXmy8V9IhWHOxUKs1m1YmJaiKp09XGSs4EOx6DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) by
 SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.16; Fri, 22 Aug 2025 02:58:26 +0000
Received: from DM4PR12MB6496.namprd12.prod.outlook.com
 ([fe80::bede:bc2a:5e14:e393]) by DM4PR12MB6496.namprd12.prod.outlook.com
 ([fe80::bede:bc2a:5e14:e393%7]) with mapi id 15.20.9009.013; Fri, 22 Aug 2025
 02:58:26 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/3] drivers: cpufreq: add Tegra 4 support
Date: Fri, 22 Aug 2025 11:58:21 +0900
Message-ID: <1914341.atdPhlSkOF@senjougahara>
In-Reply-To: <20250321095556.91425-2-clamor95@gmail.com>
References:
 <20250321095556.91425-1-clamor95@gmail.com>
 <20250321095556.91425-2-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYWPR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::20) To IA1PR12MB6484.namprd12.prod.outlook.com
 (2603:10b6:208:3a7::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6496:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b1c0f6-0081-4c46-7527-08dde127c36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHJ4M0lqTmd0V0R5ZVJrSWJsZ0dKbnhkOHd5VkM5d0NsYXRReUpnbnNucDIv?=
 =?utf-8?B?bFN2VDllalFKTU1QcmZUNHVBNXh6Sk5IZHFRbmxMZXl5Z2FqTUNuUHRPaGc3?=
 =?utf-8?B?MjZFR05Cd0JLSHJhcmVxVmtSNVZpbGY4alB6TDB5RFpjdzFFM3phazFCS0pT?=
 =?utf-8?B?cHNuc2xiNmtBNEdSRWZIcHZYd1o5bE9GN2F0NkRxQ2NTbWNiRXpjUlRTeU1o?=
 =?utf-8?B?dnNEbVd5d0tKak1jb0h0VlZncStJemhvQWVnbE5OQzk4YmNpRHM4Z29GeUh4?=
 =?utf-8?B?N0pieGtJSkRrVVdzamgxSHlVbDhhT1p4VU5tUVczTFNPY3ZkbEtzM0ltZWlT?=
 =?utf-8?B?MGFWN1g1U3E2VVAvTVBuM0Q2OHgyQXppRnY1blc2SWs3VmpsREdaT0h6Tkkz?=
 =?utf-8?B?TEwrUldkSFNDR3cyK1ZpU0g4OHo5VFIwL3o4bU1vaWE0bHo0L3BQSklkOHBZ?=
 =?utf-8?B?b1psK0Y1QStoeEd3dmJDTlplK0hvN2hmVm03cFNtTXg4MVdha3l4aVM0aDNp?=
 =?utf-8?B?b0ZJci9ZZ0ZwMkluNjMzRGlFbjF4NnNyK1dNa3JMQ2Y0aHZHa0RJa2hZa0c5?=
 =?utf-8?B?YjZJdW1VeXNGMm1pK2EvWHIxREI1d3hFcndCRUt1NXdCSDBDUWhyVU16UFhi?=
 =?utf-8?B?eFJwb3FXeDQ5Nk5zRXEweGE1WXY2d3pSNm10TDhFQ2J0ajBFbVJtN2FkY2tQ?=
 =?utf-8?B?WUxuaERFclF6c2xBTHpVSDdLZEtLTVNhZWpaY1pySFJXS3ltQTZWR3FrR0VR?=
 =?utf-8?B?dnVSU21ZTU1oUzBQaGJEa3pzeHlLVjJFU3R4NHhIQ2xhVUZtQVRVV0JDWnNV?=
 =?utf-8?B?SER0RGFKY04zRk1saTVLdHVkaS82dkVlQUt5cDlnRDhsNnloNkdJSSt4R0sw?=
 =?utf-8?B?dlplMldSUGlrZWpCUUdtUUI3N3hZWG1XL3Z1YjFGcUIwUWUxSDgxMnhjK2Vy?=
 =?utf-8?B?eStHMTJHNFdjdW1QR3F2Rkw3aHA0M2QrSTZFN2NTU3dFNFNjcWVJaW9ScDFC?=
 =?utf-8?B?a01Lbm1pa3RLN01yOWwzdkR2TS9QaDV2TGZ5VDhyNWd0WXV0UEtJQkJHS1lQ?=
 =?utf-8?B?ZzVUNUJiYnRRdmNGejBaS1ArS1JMVlcxUHpPdVh4ZDBnL01ReXRTbGZnYSs5?=
 =?utf-8?B?NlRnNWRhcTRPVW5hU2lWd1VldjNML3BZMkswVkthNzFMUnU0WFBiaWUrenpv?=
 =?utf-8?B?SmM4UE80cUhCaFV5b250V0tzSzluTlE4dWxqcmxqdy93eTVuM1VUVm04QUFR?=
 =?utf-8?B?WFRtVFkwNUdrb1A5Ykw1MlZEWklmUlVXbFU1UUVsYXZRV3lEbFdrazJWU1Fm?=
 =?utf-8?B?VWlCRzB6MVA3OGZoTTVOZm1KVXlIWmVlbXlLUCtTaEd4OWpIY1pTSUJDdnpu?=
 =?utf-8?B?a25CSWhjU3pDaENwTCtqd0o4ZmlGYXN4QzBDZnhHMktOdVZGRnQrRlk4OHE5?=
 =?utf-8?B?aWpyNVo4RUFMbVNSZDBXYkVpaXdMOE8yR2RiV1ZNVmplS2NMc21wWFYrVExC?=
 =?utf-8?B?Nnd4NWF6RTVPYmxQNHh3ZU9VNGlQU3FzcWZEUFBieDZmdkhFaGwzVURRcFhD?=
 =?utf-8?B?bUZUVGNJcXIwdWhOeUFIangrckYwZzBlSVN4dUYyblA4bk56YTV2RmNLNEkx?=
 =?utf-8?B?d0M5ZVJobWE5VTU1WndOYjJjdm1qZjd6Y1NuVWlaQzFDb0hoNUxkSElkdTNh?=
 =?utf-8?B?RlpVUUFha2FSQjRpeXVvMTF0djR5SkoydlNJbmFINFFSTlV1MXIwUTdYWWZ2?=
 =?utf-8?B?a0pxQlZqNXFERDJLOEZnbjdDSS9qNlk5SzNvRzVmZXU2allhdUt6MUhoYTFZ?=
 =?utf-8?B?Z1VnUzdNclA4R2NheU8zRlpNOTlUL2JMeGMweFBoRUt4bWVjdlVQVFpDcDFm?=
 =?utf-8?B?N0lIeVdidUtSOGlBQkpGK1NPeVVGLzJzd0g4Z3ZwMFVMRnFCY0k4ZUVlODA0?=
 =?utf-8?B?R3orM1R6SGVHTGpyYUhhd1E3UWpDRE9pRGxDSmpBYzI0WEZER3JpSU1UcU1O?=
 =?utf-8?B?VXc4Zm1GL0xBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6496.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1ltbUFZdktoR1kvRTU2SDdSbFhqcWhsS0hMU2lsamdSQWhKR2RCamZXbHRH?=
 =?utf-8?B?aEFDTDFDUGFOM1VqQVNrU3ZVMXJaMndqMSt1ekk4R0sySGYrVTBETmkwWExj?=
 =?utf-8?B?dG9mdW5nL3RCcG5wNHY0Q1U2NTZrUGlTT2d6eVBKRlo3aGk4VGVlazJCNm5u?=
 =?utf-8?B?Q0pmVGpISXVkZnVtQ1BiZFdLQlRHMEtDOE1hMUFPZ0lwVldid01pRURhV3Zp?=
 =?utf-8?B?RjZmMWNMY1FUaFFoQ3FRYkR5N0Y1NzlyczAxdUhZdDY0WmkyR25Mb2psZDBo?=
 =?utf-8?B?dnltMDNyR1UxYTU4MUNXTUJjM1YrUFgwVE10OCtkbXJnUW11MVlwS2ZLa3Jx?=
 =?utf-8?B?RmNSelRvN3FRNDdkWkdGeStMbmRNai9hZ3VjdWRUSjNaMXZPSElXem5zejlO?=
 =?utf-8?B?VVRPZjR4L0lmUzNFT0xPRStnSHZnYVlPWGRLSjZabWJCWERrVEYzWGFFcVls?=
 =?utf-8?B?S1ZPeVFFVzRqYmt4Y3Nrb3lERnBESjVaczE0ZmJtT0ZqM09vUVpKRVpKR2s3?=
 =?utf-8?B?ZkV6aUxUMFJVenUzOEtMVWUxL3ZGaW5FbWZHNllHVU53UElVcGxYS0FrUG5h?=
 =?utf-8?B?cmYvMk16VXRINjdRRlRJRlM0VncxajJRTUxQRlJqeXRhNGxrQkY3a2QxRVlj?=
 =?utf-8?B?ekFRNUs3NzJvOEVWU2dQVG1wRVlFdnJyWk80d1dwOHlVcHpGYis5M0dwUmwr?=
 =?utf-8?B?cVBXQTVBb3FDR1BSdWVVNFFDODlYVlNOZ3A1UTFOL1g4NEFUa253VndDcVJR?=
 =?utf-8?B?NGFiTlNHVkJ6VFBaQ1JaRzFPRjVZWGZSOUsvZ0Z3cHZRT2cyeHFHTGVDRG5D?=
 =?utf-8?B?Wks4bWo2VUhHcTYvWjYyTElBWU5SNDJxZnI4dU0rWTFnczczbEorUUtacnRD?=
 =?utf-8?B?eEhPcHhwNExkdTF4MFcvYW5WVW1UakNDMTlBa3UwWGRweHlrMG02RjdzamxT?=
 =?utf-8?B?V0prcE4waGg0amp0b09nZWpwMXNITlA3MlVQUkcrakNCQmROclRxaVhLQVpy?=
 =?utf-8?B?ZGJKZGU5SzFkZnF2Umdqdzd6L0JpZ3o3b3JjODI1U04yMElzVnhuMGNiUzRs?=
 =?utf-8?B?eDNoWUNKOWRLUjhIWG9RMTVIWkhFNkRsdk5CZFVXU3E3OTE5SGZ1aGlETFpJ?=
 =?utf-8?B?QS8xK1k3VWxJZzNqT3BJNUZlWjFjTFZqZnhib2ZBQzJXVG9lNEwycU1FNElv?=
 =?utf-8?B?TWtaSkUwOGM4RlUrR0FaZ0NoRm9BWi9SSW9VTnB6NytoOVVGNnNUbXB2N3pV?=
 =?utf-8?B?WGdxK3lHWEVSdk1KOGZLZVhjSW0yTGZaMnRLNkpIelN6TG9PTXRBMjQ2VEVR?=
 =?utf-8?B?TExlRVQ5TzF5VlZmTGFJdWRBUnd5MTdRN2lGcnp2b0xTYmNVeFRVRW5RcXZa?=
 =?utf-8?B?UUlsYmM2VDB4QWxqdFh2OE9qdkxtYkFQNDNtSmNXdzBHSnhrN28wSnlTampT?=
 =?utf-8?B?bnhmQWo4ZWhxMUpGeUNLaHZkRmNFSE9GeTBwdW10blRhT1F2SnpYVzhUN3F5?=
 =?utf-8?B?ZmpHNVBscW9xLzIrRXc0bWtEa2xYMUtYWUxCcjhESUFGcXIxR2hVaklrdGVs?=
 =?utf-8?B?RGFSVXMwRFYyVVBhRHM3K1JWN05OamlReDBYQ3lET1JNa0pFSnlKaVgxSkR1?=
 =?utf-8?B?ekEvSEF4K2xUdlhEazh5Q3hEanlJSTdiWUl5ek0vUXh6cXF0SXBDcmlMa3BL?=
 =?utf-8?B?YmlWemJ4WXJSSnJzWU80V2QyS2gxejQ3djhiTXhDRVczU3lNeEQzVFJLenkx?=
 =?utf-8?B?aVVrcGwrQ0QxeG9FUGR2c0VGQ0liVjViQjBmeEZBVVAwRVFmK2NYNGdkdEJi?=
 =?utf-8?B?UXpwTXJGQVlxTUJ1a1lvNUsrdlVlTXI4Q2hHZTlORmFLWWFPRXhyeHhBUHFI?=
 =?utf-8?B?QldpeGdkS2dMTjN1QmZiZG9YS0JSRk82UjFGWW5SZUEwbzJHcTl2WFBaU1dh?=
 =?utf-8?B?QzNxbHdEakRvcTYxNWdBVnJGYTdDbTUvUXc5djdLTEZBUVdMZVhvTGtMcWlh?=
 =?utf-8?B?OC9RRldIMGUreWJsNnh1UEFPOEp1dFRmYm9RTUNDQVVEdzJwU3hmMDFmUEZO?=
 =?utf-8?B?YXM0a3owSzV0S3dCL21XM096L2RNek1mRkdHRHFsSTVCN0loS1F6NXZtd2U1?=
 =?utf-8?B?cDJaQXRRdGJWN2gyc21xNjU5VytZVEhhS3k4eGw0eGw0amdZN2dKRVdtdk5F?=
 =?utf-8?B?cmVOcHNNdys5ZW5GVFdtRkkzdWIweWllaUtUbUl6VW5DaG9RSnBkYlBSKzR5?=
 =?utf-8?B?QkVDVjJFQ3dVUWxpZW9BL3VKSFZnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b1c0f6-0081-4c46-7527-08dde127c36f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 02:58:26.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAgG/TdZESbBmyWB8U091YD3GUkjlAR68tiVHqGPll87deF7h1Q3frEuKsHMwHHTrM9UA39lyW5wI+pRITZA6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

On Friday, March 21, 2025 6:55=E2=80=AFPM Svyatoslav Ryhel wrote:
> Tegra 4 is fully compatible with existing Tegra K1 cpufreq driver.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/tegra124-cpufreq.c   | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
> b/drivers/cpufreq/cpufreq-dt-platdev.c index 18942bfe9c95..7d15a1224d37
> 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -140,6 +140,7 @@ static const struct of_device_id blocklist[] __initco=
nst
> =3D {
>=20
>  	{ .compatible =3D "nvidia,tegra20", },
>  	{ .compatible =3D "nvidia,tegra30", },
> +	{ .compatible =3D "nvidia,tegra114", },
>  	{ .compatible =3D "nvidia,tegra124", },
>  	{ .compatible =3D "nvidia,tegra210", },
>  	{ .compatible =3D "nvidia,tegra234", },
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c
> b/drivers/cpufreq/tegra124-cpufreq.c index 514146d98bca..6ff2ccc08e5e
> 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -189,8 +189,9 @@ static int __init tegra_cpufreq_init(void)
>  	int ret;
>  	struct platform_device *pdev;
>=20
> -	if (!(of_machine_is_compatible("nvidia,tegra124") ||
> -		of_machine_is_compatible("nvidia,tegra210")))
> +	if (!(of_machine_is_compatible("nvidia,tegra114") ||
> +	      of_machine_is_compatible("nvidia,tegra124") ||
> +	      of_machine_is_compatible("nvidia,tegra210")))
>  		return -ENODEV;
>=20
>  	/*

I also prefer using Tegra114 and Tegra124 in the commit message, perhaps wi=
th=20
the marketing names in parentheses, as the chip IDs are more consistent and=
=20
(IMO) easier to decipher than the product names.

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>




