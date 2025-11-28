Return-Path: <linux-pm+bounces-38855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3DEC9099E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 03:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD213ABE47
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 02:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE98288C08;
	Fri, 28 Nov 2025 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KRft4C05"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF47275AE3;
	Fri, 28 Nov 2025 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295938; cv=fail; b=CtXfiOrz57oWi+6fwhApUMmLMQloGGAny4sb57A+9nYNezvZsNqiV2x9XTmEcd0WNZztQ0rrcCkAaiw6xKc/RxHRBbrkiiOW0h7sfxTMuNk/bMv87tX8UbBSKg3LxdsCov98sMsHwAvvyYd4udgGkyDn1/puIa6OHMMawIDGs+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295938; c=relaxed/simple;
	bh=k1Tq2b8UMcbC/FhWncSwlXREffeopTkT/lsmDNsaIo8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=noo6NwJLiXL/5vuaN+DxyzX0HiDyp9Ufly6AMcWKtr/lxaEDc8aQQqECXGUFCNQaGyRKLzkSRL05Du7bv9+IpIFRh7QFC6KnyuGAo3z1r4DpPqrfhs7ktt7HsJFWEuXc02qzSqfieIHo0FKpM5sv9AeEO5OcVZDlwihGtflzV2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KRft4C05; arc=fail smtp.client-ip=52.101.52.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dA2HsDLtlmMk9yooJrpAl0UOekpWo3G3ZQSfYKsTraYfovD7b8wBQrm6lPga+hM8nikX9qH5tg2kZbU5hpxJk1CEfLSfA+pvrKIEybL+MNO1tko+DJEMfqboZBoQiAqBBqPJWjvTnZny0w3yx/RiEj57DAotKMwzsRxO2icR1Skq9haG/OzANuENtSX0qMNihW+Aj3rAk0XTzHVrVpunKCq4mC1PcWP49CG14sN11WBrLfs9erptP4fBjjpmvBujyjybDuKGrjDhDAY38I2Ko5nJQpC7AMDWbXIzPltaqtMxs38/uExm+TTj4Jgdqhb56ib0VTAVD1T8uVM5K3AIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZfkWDB4X0ZVHJPctaFOSUbLLlKf/345cKFY5Oiu8Cs=;
 b=xteuKzmoaPDvhukkqm4yYcbk9kpuRMTiQYD9/j7XkunyTDFcLwrMGaaschs/Bm8M/4DGJ/0+VBihdCQHe1HLT78XmEn1jqw6GIaLq4HwBpsbkM5OEK7FD/cMUgHgt6XK3r0I/nhVGwuXS/eyMd8VHlIbbPTF6usOzn/7sCtTVNTc4eCQjBlriQS11gknyAVbmi/1pUDTzr/VbFdOKKJvaiq19BNaHGRA+OhJbVQlSpg5X56Kgo8DdJ2btLnI9JHOK2QZ2DRG1Q0g+3rLgNg03UzH5+dnkiXZp1IZfHcnS7ClmsQjXMZwK3T6JFS60n/PUtU++vcPE7UECMZzyoHPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZfkWDB4X0ZVHJPctaFOSUbLLlKf/345cKFY5Oiu8Cs=;
 b=KRft4C059DQv38gi70ssZTzDI89X0BfYYfg9U8fiEZ/HxunDGe3BIuJ1hCJuHiqM+XJcfWx5xLex3tuuQ+BGvhgpcV/cBoabTsIH0E6KQvZLR0nU8WsLlLKu5HZoDVI2S0UROmj+Qmn1cN2yDACeaC0cEkHbhJ/alhxAaPL7TkV5TZTQ8I+B3dI8Isez2nYMpDjYACX6w6q/+EkHfSyNNQKLxau04AXfqj5enemkJteI1TC85vYfrNNp29MbDU6NaqaEKd/gC3rr90b2pRMN8aMeRo1xjilArh+iABHaBsXaKzyXwIiCpezW1Tnvcq7SJdP6g1EsMODmKPPhc32Cbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 02:12:13 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:12:13 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 28 Nov 2025 11:11:42 +0900
Subject: [PATCH v2 6/7] rust: irq: always inline functions using
 build_assert with arguments
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-io-build-assert-v2-6-a9ea9ce7d45d@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: fdde30cd-3d3f-476d-2966-08de2e238b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUxSTlVMTWp0Rlp1NENPQ0RmSXk2WjJLYmJNbzdJZW84QTJNelBxSG5EZnZw?=
 =?utf-8?B?RGFjZDlvS0kyNmJad2dlMXUrS0ZyUGQ3cEhja1VvTUpVUjN5ekcwK1lnRytl?=
 =?utf-8?B?NEs3V0Y0Tm91N0xjd05tWlExamxWY2JBK0N1Y1FyMUZXeFJpK01IaVZXUHVw?=
 =?utf-8?B?eTRVZmlsbDZFMUxsVUZSYU1iUE1wTWo5Q2x1SEdWMEdVMVNrYlNzRVJQdDhT?=
 =?utf-8?B?bjFXdTJNUVBpMmdVOG9kWTRoY1E1STcrM0hUUmc0RDBKWjJKUVpraEhhTThP?=
 =?utf-8?B?OE5VWDdFdTEvdnNjSE1nOUlXTWNRL045S3Nva2VtNXBoMERvc1hWMGdRcDRO?=
 =?utf-8?B?MlpJZHN0WTF5eFNpR2FoUkZ5WGR1ZzFHZU11Rlc3TkhmVHVVWDE2YnRTS1FT?=
 =?utf-8?B?amdHdnZkd1lkcWd0ZlljK2NYL091RXJ3WFVTZXFNV3UxUGs5UVpMY0tyTk5C?=
 =?utf-8?B?WDhQUmRzQ2NnRWljdVpyWTdjSlJBM1VoM2g2bVlsNThFSXd2QWFmR3o0ZUdi?=
 =?utf-8?B?VDRhTlhJVE1UUEpCMWY0U3BLbFdGemE1QW9aOVBFc2VWam1KenI1RDdidnky?=
 =?utf-8?B?cWd4ZE5vbkV2a3FQcWNNbjcwVHNSQXFDdW82cGRLUkUzRHcxeUVJcDhESmg3?=
 =?utf-8?B?QkN3YkdtN3ZVdzVKaUNGSU5XcGJQM2U0NEJLczloUjduVTB0WjVvcUt6ZXpF?=
 =?utf-8?B?SytVSVlzRHdPRHplc3M4RnZsNEQrcHdFblVSTTV4ejJVWVdwQjJEdE96c3N5?=
 =?utf-8?B?N25IT0pMOFpEam1qUnFwWjRJbzdsZXIzdlExUDkyTHJ3MU5ZQWloK2wyZUFI?=
 =?utf-8?B?S0tPRnpucWFHNFZiejFwSzNlOTZiNGtkRzI0OW91WnZjUXJ4dVFKYi9iNXYx?=
 =?utf-8?B?T2hGV21KRk14cU11Y0s0RmFSYi9vTVJOWk1ZU1pMcHp0NVlmaHMxcW9Xa1dF?=
 =?utf-8?B?bUtvRjNuVDFCWWtROTJsUEtXeFpjS250MnAzNWl6UzFKZkRIa0FjN09Cc3Zp?=
 =?utf-8?B?VVo0cDJuSDl2VXZVVmhENTE3ZlBZTXBoVkcyMG1PV1czNDJOektKb2VPcHRm?=
 =?utf-8?B?Q2JnUGoxN0ZmRDV3MXNlck42QWJwUmp3MkUxL2h5cUZoUUlLWURIRHA1N1Vx?=
 =?utf-8?B?aTlmVUxwZERIWE1KaXBJdVYxeitCK29pL2FOa25qcWQ1dzJnbjFKV214U05X?=
 =?utf-8?B?Ny8wTGdQYjBIMXZxdC9YL0ZETlZGeVpGcVNLditwTDBBNHJIYmFjTmNEVDNk?=
 =?utf-8?B?dlFLcEYyMStHVkh0MDFuL1BSVXl6Q0wxVUhGMFRhSEhkdktYQU04WVhiTHRD?=
 =?utf-8?B?aGFpYnkreSs1OFd0djhpRjNLMjFIWE9ILy9JU01OTEtZa2RRMWFnOTE0c0tF?=
 =?utf-8?B?Mm9pODhVd1h4VTFMV1JLOFIxU21iSVZsSXA0YjZTK3c4WEpqZzFhQnJodTht?=
 =?utf-8?B?eFdtUUtjay8wWHZkWUhFK0dEY3JyeTJsSldNVXp1K0tic1hRYzdUelRXdThW?=
 =?utf-8?B?TkR5eGhQbGN1VlRXWmtORzJWYUxGR3RwbEpNWCtFaGhCdWRIZ1VpdlFzQnBS?=
 =?utf-8?B?OGdHS0VXbE45MjlkYWxxbGVxYjdUd0FSaXc0OWJpTWxoSFZJRkNMWEVGSHlz?=
 =?utf-8?B?SmNUZVoxc0JkUVFrMXRrOWtadVp3YzdqZi9NS1UvdmxUZXhCWVVrUlY1YnVx?=
 =?utf-8?B?ZkxlOEVBNFdkbGlMNml6Vld6MGdrT3dVMTZ1MWk4akRBTmNtdWNIVU1LRFdV?=
 =?utf-8?B?MXd6T1FDMHVQMk1hMFcvMUNxK1Fua1VDM0NmUjFxZlRvZkR4ay9PME5kY1Nm?=
 =?utf-8?B?MVR4dEZMaEdwTEZRNGJsS0xaRU9acXZHb3dpRkNra3lSZXMycDUxNVdzZW91?=
 =?utf-8?B?K0tOSG44V3dWTG9ZVVVnSEtVWWtQUi9OU29DRXRiek5tdzUxVlgxOWt1UVZN?=
 =?utf-8?B?WDVHMG1xajhlNitMVmRaVDRyZVpzdHJwd3lzRkQ2SnM4a0x2MlpvSFZwZXYr?=
 =?utf-8?Q?T3uqkiXYUZaC0uybNTbLucb5qJ2els=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGIvYnZpaDVPb1p3TFpyS1RUOWhsN0RmaTlFeWoyRW9qRDF4K1l1V2xTRy85?=
 =?utf-8?B?MGFWN0MzNTZYQXlJQ3Z0c2c3eVZWa1Q4UmgzbTNaczhES2hvMi96RHJ0Z2Er?=
 =?utf-8?B?NXpNMjFQWjVYbUNPcEpCRURlWXhzVUVPQnVSeFg0TmhPcmNod3RhdW4reHJi?=
 =?utf-8?B?TkJGMTlGNDZPL01DQ0d0NUhURDVUeldMOTE0RGEvYnpWWEVqOE9ZWHZ4NlBW?=
 =?utf-8?B?cEtTaEJ0ajVFMStJTWtxeFRvdnlJRUJrZEIwM2Uzb29lOUJQd3JERmFZYjVp?=
 =?utf-8?B?c014ejdSdUtYM2hVY1AwTWxLSDA4anIyd0FnODgyelMxeXdMSWp5UGd1WTly?=
 =?utf-8?B?Z2RIcmhUalg5SE9BTnNUek9wMHUxZEJhSHNWZWt2cmROSlVJZmJmcDBlZFpU?=
 =?utf-8?B?M3ZGZ1pLT0RjVVFZbnZZaWdleitLbmh3cFNvUStRMHU0U3htL2g3VUhWM0lq?=
 =?utf-8?B?Ty9ZMlI0RGlNS3hvT2JrUXd0VkxEZWFKSmRSNnRONVFVcmcwTnE2d0l5S2VL?=
 =?utf-8?B?aFVmRjFNTjZEQlVhU0hTNG00dkYzdGtQZklNc2NkaWN2SWVxcWc2eDE1U0ZJ?=
 =?utf-8?B?bDAzR084RGkwUzZaMkNEZGIvdTZWdDRkOHNSRGhvMnljdFpjUUhMUXRRWHpN?=
 =?utf-8?B?c0poYjFZRUxLbFJjOU5TN0NKcVpwcytaRURzdmI0akRRS2lXTXRKZVYxLzVl?=
 =?utf-8?B?eE02c2g2MEFpQUdkSVBBUVR6cW85YkJUL1Fxa3kzZ0I4RjNJc2lZTUk1TlE3?=
 =?utf-8?B?UVFGT0tBMXRRYS8vSXZlZFpYZ21PaytMZHdBSDNYQWhVbjliK1hPQVNqRWR1?=
 =?utf-8?B?S3gvN1RRVFgzRGFZZEprbnpYYlZuam50d3ZoTDlLUk1GWmpVdStKS1NjeUZ0?=
 =?utf-8?B?dXpCeGFmbGlQendVTXNCaHBoYUFqUU9ucFN0T1JPaVVWcGdWNDJpRjdyQkti?=
 =?utf-8?B?MlI4ZzRVMUk2dUVhMGRrbVNJQ0d1MCtta1oxWUNmQ2d5U1h5Q09iWkRON0JY?=
 =?utf-8?B?T0VoaW42UE9CLy95aEhtM3hlOUJRMVZtb3BRSnZ0TmlYaG1sSjl2TnpCMk9r?=
 =?utf-8?B?QS96bUdCUncyWGN3eDduNUxHNlFFUXQrVmsxeWRpVCt5VjdwL20yT0Z5Y3dR?=
 =?utf-8?B?dnZmSjlyNWl6QWNOVVZ2Wktva2V6eXVweTR2V3BWT2IrNm1KWVpCdDlGb0xt?=
 =?utf-8?B?VXVSZGFoeS9rMUQ2SE1valBEUG5YcnlQV1MvOFprYng3ZCtRYUxsT0M1WlB3?=
 =?utf-8?B?cWdrRG5ZYmtUWGFWVzk0VGQ3QTBhWVRWWExEOE42UzNPZFFFVFEwRjZnVHdD?=
 =?utf-8?B?MDF3cGd3VDJqUjkyOFB4SXJHVDA3U1VTVkxzbXpDRFFzTTREa28vMlZTOVN1?=
 =?utf-8?B?ZDYwaUhLSWY4WFp4N0t0NE9kSmJqTllKQmtPQlB3bnN1Qzd0Rit3azdkYTBQ?=
 =?utf-8?B?b1VmR2hwTU5MWHVoRkFVY2MrWi8xSXVQUXhSSTlsVVpwY2drLzNyclVBMnk1?=
 =?utf-8?B?SGwxMW9GbjhBWXVQcXRGWHNyeFVJejBlbDhJRkZPVDVlSjMwK3NiRmtuaUE4?=
 =?utf-8?B?N3FvOEJDSXlqK1BWMEd0Wll2bFdVQjhaTU9uNzQzSWF6c3ozcVZBaTdSK0Z4?=
 =?utf-8?B?ZXNzM0JZc3hPcU50Z21CdkozRU8yVUNDM3FXVldRYlg0dWZieWhEcjl5K3pl?=
 =?utf-8?B?d0swYUI0b2o4bWRuSEZnU2NDZXlBYTg3TEo0azhQa2ZNd1A4ZG5NYWNhK0NC?=
 =?utf-8?B?UlloWU9hdWtiSHJ3MldON09lcDVkK3ZMaGMrQzJaaGF5UjJiR1RTRkI2SVFj?=
 =?utf-8?B?Q2Q5dGJYUXRteXZaaFJaWGhNWElIcW5PT25LV1p5VjJ1VlJ0S3NtVTl2S3Y2?=
 =?utf-8?B?MUNiSDlRcTlTK2tLNUR2TmlJVUhBTncxSVNDNWFSNXFJTmhaNkhUWHpEZWkr?=
 =?utf-8?B?eS9FbXVnM01Oc3hkVzlEemJJZS9KdmxndEpPS1RDY3l2Tko1bE9kQzNpTXRQ?=
 =?utf-8?B?VzZBNzh4eFJBVXBRTmtXeTR6aGltYS9EYVE5QmhwYXhOcVVQS2pEN2l4d3pC?=
 =?utf-8?B?bDIwQisySjFiOWpObnhtRlF5K05QcEgvbENqTUZTRGE3Z09XOVZ1Zk9yVUts?=
 =?utf-8?B?WnB3SVZsZVpSVXFqUXBxdVdqNnNldDlCem9id0xrVG1iYTlJZUF6Nlh3bnh6?=
 =?utf-8?Q?M6Zcf2wgBMcIqZOEpfxJrrRL3HbQrDbRmIB9MoUPbQ4N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdde30cd-3d3f-476d-2966-08de2e238b42
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 02:12:12.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCOGg0/64P39BysIbpBNiWbOKwmxzzzSNWMzkiKxLLCqOSiqtR+pmzUGl2aMzxF969tEBkzNa+6r+5Dc0PKWig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617

`build_assert` relies on the compiler to optimize out its error path.
Functions using it with its arguments must thus always be inlined,
otherwise the error path of `build_assert` might not be optimized out,
triggering a build error.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/irq/flags.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/irq/flags.rs b/rust/kernel/irq/flags.rs
index adfde96ec47c..d26e25af06ee 100644
--- a/rust/kernel/irq/flags.rs
+++ b/rust/kernel/irq/flags.rs
@@ -96,6 +96,8 @@ pub(crate) fn into_inner(self) -> c_ulong {
         self.0
     }
 
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
     const fn new(value: u32) -> Self {
         build_assert!(value as u64 <= c_ulong::MAX as u64);
         Self(value as c_ulong)

-- 
2.52.0


