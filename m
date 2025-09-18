Return-Path: <linux-pm+bounces-34935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD6EB8297B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 03:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491FF189AA46
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 01:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F245224AEF;
	Thu, 18 Sep 2025 01:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Es4hGFWI"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B0D19E967;
	Thu, 18 Sep 2025 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160674; cv=fail; b=LfSCElBAycpp1f0MdC6rZdbUbtfRPAO4iZLv+F09ptmWRUqcPe3pMt6Z1K9FSOk6C9RB7SrKyFm69nzKoG+PjY2osOcOFpmwFeBgGLZ+Y7j2IQM5NPDXGMq4adTPHU8LAlhc5kJ1G8RVpS9dAGm7sE3nKqsj9j1c5RpbmirHScU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160674; c=relaxed/simple;
	bh=PkgbzQrMSTpyPW280ZTdrn5DOTp6n3qVVrzj1uCldPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=muboVd3dDmGnptY9K+8xhgOH8+znR+grLCqWElgQI6cNsOSyylBAXIyIKlLDbqajYlmpY46odaG1/k2SL5M6aR2ur72iAxRBXIqIa9kWkXb6RR70FqS2ThGE9G1JiINuaybdJ2mPUYpgiGnArRb/kXimHxdG9iClANO6Z4kKu8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Es4hGFWI; arc=fail smtp.client-ip=52.101.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRxr83CZnIWBB31VLxg67e1ijIGDF/Mbbxzl1INnaHrFEZTc6g8fJuBdicnlMxTk2KgHEniQI4erIHeRKcT0rcHZaD/8q48/wlCwWEHCbKzTdN0mzE13KAQNLLCAGU+gLpeXueCGr/17yorbZX0RHjx5W22XH53thqF0N2M5Rw4AN1xTKOZ/mPIaZ5hD5wBXh4PJqjcVLmNiVkWsWhkrs487bOWg2RMRwcCDFAeY8UyV9KrVQ2sxxILxFOHYd/fF3BbnXrQgLXgj+MfwqUw9GA3sssXfliWJdcc4uFx3mcR+zAqFwK1dt3NNEyHJ99geJr190gt0BwCJzHRPey426g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkgbzQrMSTpyPW280ZTdrn5DOTp6n3qVVrzj1uCldPw=;
 b=CtzLw1F7GEbTwV7WmQ8h9s30P6pxyJaCiU5TFvk+zC1BLBIbgcaqd7VwI/OVpI8jnsZQsVwj3qOLOk1AFCO7b/SF3iup/n0bY3AQGMyJ7k4sPmUWXvbRV4TQd27zBJg/f3dv0lGI68WjkTRktWXSPG8RoLde9HzU1gHPs1N2gv0VDxA0dchvcW00GE8u+OqUcxgyQigiIIXKNBgHYYp6MZOtAG8555GacSJiB3rn+6Cex08cZW57Zd3LQw1mDJ42y5Y9aLuuNA+A9mCWQeQsF77sX6KcTPLLAoa77XMGamwpQZoypW3rPB/dZ80vFRlQ8Q42YwsU94TbyM0tmmdSoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkgbzQrMSTpyPW280ZTdrn5DOTp6n3qVVrzj1uCldPw=;
 b=Es4hGFWIDaWTqIVfcGLcAoa5CuL3ueiOsR8JOrnVa/nKmpcdkX2IsAg5aroyLuH7eRc/kpMIYUY+qVTEBgDZcmOo1gNebs1dqASwQBgMG9oqjBvFbkTkgjNccbNsUpfptJwxWPX1fz4FXKAYSl9FrNNY8BNYMoPoZzBSuIB8RMfC8uHyc7bVpNw280WQ7+xv4nlUY0URxjORG/lfufsNo/pBCWF/q2oB73jIHUQiGpafiR4TCsbVfYzxKGpdMVbgs45FGuXSkAxT64be51QVH3648/iL6eHxetpA0RJgXHfvEHxP++t8hwb15hJoNhKR1j5d58X9OXUfLThl0jktiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 01:57:49 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9115.018; Thu, 18 Sep 2025
 01:57:49 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Robie Basak <robibasa@qti.qualcomm.com>
Subject: Re: [PATCH] devreq: move governor.h to a public header location
Date: Thu, 18 Sep 2025 10:57:46 +0900
Message-ID: <9049326.T7Z3S40VBb@senjougahara>
In-Reply-To: <20250903-governor-public-v1-1-111abd89a89a@oss.qualcomm.com>
References: <20250903-governor-public-v1-1-111abd89a89a@oss.qualcomm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4PR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::19) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: a635c797-f008-4940-46a8-08ddf656c537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MCtIbEUvL2lVS1FTYnZ0UklweTRnWmF6U2ZXQzZldDQwZllSUjBTUVNRQ2Ju?=
 =?utf-8?B?Z2dQSDdQUU42dXk2YlhsUXVIT0ZONTViVjZCVUY1aFpDd0o1MjJjNVIxcnNK?=
 =?utf-8?B?VDY2RDlYVVBvUFR4RjV4dWNGTUdwdkJIVkdDV2JyOVVNSG5FSGFBN0FrUllR?=
 =?utf-8?B?cWNUbitBSmJQSTZsaDZYdm9KblVwcWxXc3hodWliMWlOWHVnNnpKKzNvRkQ0?=
 =?utf-8?B?WDc1VEp6THV4Tm5Jb1pKNWVFNU5QSVBVTzB0Tko5NjZhYk83Y3V1VDhwdWd1?=
 =?utf-8?B?by9MQ1h6TTluVy81UHR6NE1sQVFQRGlzRkxFWnVRVUhkZEVKQ0JYSFk5M0tN?=
 =?utf-8?B?QVpmYjVMR1E3aGc0UlYvakdkakExMExZYno1bXJtN1RSQVRQWXdCV21QS2lP?=
 =?utf-8?B?anh1MGpiY3NSTXdkUU9Kekh1MW1HWllCeWpOZHRnWndxd1U4MHRzL2lqTXBO?=
 =?utf-8?B?a0daeldaeE9ZRHUzZVJqSVZRa1dJZW1HYWFVN0NUeTdqajNYUDQvbkNBUUlm?=
 =?utf-8?B?N01raW52ZWhhMWYzYXFsVmhGM0J2YjNqWHJlbkp6TnR3d1ZKek1Vc0lzQS9L?=
 =?utf-8?B?eTdqcXZhZWh3UTNoUEtqUGpHQmZCUHVMNzc1ZGVXOXhlVVBZTjRqZ2lCUG41?=
 =?utf-8?B?dlJVWmo3KzZKbUFpTDJsK2FFQURLQW5aQ2tCUjhocDNtSW4rN3d0RllTTXUv?=
 =?utf-8?B?NVRoUlRLSkpPNWZuSnV1Qlc1RS9xWHFGY3MrTGRtNXJtMDlIYkF0djM0MlFW?=
 =?utf-8?B?U3BDWnB2cFFjWlBka25SQWZyV3NTRk1XeHJXU09NMVd3aWlVNSszczFkZXlC?=
 =?utf-8?B?V2c2UTVJT28zeE5FZi9mVnF2Q3NHU1Bqc1FmZmMxN1RjelE4QU1HWHdHR1Mr?=
 =?utf-8?B?UkF1RXlQSUk4SDR1KzQrTXlmdmQ0SkdpNG1vbU1KRFZ4MHRnSE45LzNPWjQv?=
 =?utf-8?B?NGdTRmlid2drRC9PejFEZk9zeEdwM1JYNmREN2RhMjNOYVhhZG9mSUJ2WnN3?=
 =?utf-8?B?SlVvUkJFTWNkMmpIa1pweTlMdGV5aTNSNnBMRkU1R2xLNVA2VldkUUU2dE5C?=
 =?utf-8?B?cDMwWm42ZzRLQ3BCSGZEQ0lVbXNSdTl0VmNrclBlNHF6VTVsTjNGNEdyaEJ2?=
 =?utf-8?B?UWxvL2xackpWb1JzOWpmTjRCekZxZTFRUWZWenJ1QUMyOUdrZzRuQ3d3SGNE?=
 =?utf-8?B?Y0JheVJUV1l6Y0tneE5FTHR1VlRwR0dKOUxmeEdSbnpxUzM0WGNZa0phOFE1?=
 =?utf-8?B?RGhldXdpWWRPQ2kxamdpNWdCVnRzRjc1aG5mTWtzNFBmTFY2VVRTMDBaTUYx?=
 =?utf-8?B?Wm8yVlJrbVpVRktUNkJwZ05ZSkl1ZEFQQnNTTkZQSnBVSUhXZ1A5bzM3eXdY?=
 =?utf-8?B?NzhLRnJGUFVxMEJQeDAwQ012WWFpRWtFMkR3cW1UTmFSVldJdTdqVW9wRnFZ?=
 =?utf-8?B?NkJaMTk5NlZkMjUycExpQ2k1V3ZDbEQ0cmtubTBkMVYzT1FvL0xtM0tWVEZ5?=
 =?utf-8?B?OXo5eEFFUlFncFA0NGFTbVFWM004UEJuakdZY0NYSFBBOUlkeVZJb1ZNV1Z3?=
 =?utf-8?B?ZStENWN5NmFFSWcrdHd5dENmRTRzNXMvdGd0OUhHeXYzODllMWVLNVoyb055?=
 =?utf-8?B?aWZvajhJRVE0Z3Q3RVA3Tk5RbFlHbG5OY1BGMEhPZnNFbHJwK3hNQndUMmJ5?=
 =?utf-8?B?Wklud3g2MXJpK01PcUo3c2U3bG5QQXRzbFVwRG9KaWZhZTdvRHBuN0gyZVU3?=
 =?utf-8?B?aHFiQXZqYXZnbnZuK2hYTDVpeWswTVg5TVdyZTA5Szc2WjBtbTd3QkdTblR6?=
 =?utf-8?B?RHV6clNnZnFKSURDS09ZUW4rVkJEV3VvbzJsNE9FMmVIV3JQMEZ3bzF0NmJi?=
 =?utf-8?B?aUFQVkFKTncwZVM2UVVSNEM3ZFhsSVhMelJ4K0cxWE04YVU2VC8ydk1xS2ND?=
 =?utf-8?Q?XoIvwUvFICw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEpMZFJhR1ZrelVocy80dEIwTTVUZTdvL3l5R0ZyTTRROFB6NE80bXE5MzNL?=
 =?utf-8?B?K0ZqamkxUm1KaDE1dUJsT1Z2S05HNmpRQ3psdWoyN29wRzlsL1B6cmpzWnlX?=
 =?utf-8?B?dG1iSFNnNUtadkIzMTBlVGlnbmtMR2cyQnFST2R5Sm5mL2NQMGpZTjdYV0Jv?=
 =?utf-8?B?RTBtMVJoeEpsWmxHRVRzQVFnMHR5UXlkYlFLM0NtWW5xRkFBOU9LbzlZdXNa?=
 =?utf-8?B?TmtIbGFKUFlkLzYzUEtZK0Z5eTNWeGRwYmpGeDUzMnFUM3NNVjJUaFhiSmY4?=
 =?utf-8?B?Tit0bjQyWjF6U2pVdzBCQ1pkR0plNnpIbWlDeURuVDhrclc2MmZsa2ZvQXJ3?=
 =?utf-8?B?N0E4bjhPYk05cFJyRlEweFZScjlnanBSMGF6S1JyY29NaU5KbTc1bSs3Y3BB?=
 =?utf-8?B?dzdzaTZoNTNkNUIzOHhDSmNUUHBZZGRGdGd3VG8yNFFQN3RpTGxUdVBXSnBZ?=
 =?utf-8?B?RlRxL2VCek9FVXVMYjdhU0xEYkhDT0l2dTgzY1AycDZvSE9jTEdvVXdSamJ6?=
 =?utf-8?B?YlB5TmVsMi9sRnZ0T1V0Ylo4N21hd05zdzZXU21xbThUMlVSeG1zTE41ZVNV?=
 =?utf-8?B?dUtuYURpWm9NeUdGVlozMGtHN1VRSWQxSG5ua1RZdjlCY1dwRDZiV2I2bXJh?=
 =?utf-8?B?VkY3K2pRZFBJdHFLM2hJMHdrVU9Ka3BtclM4cDA4VXI0QWFSNlZDSzNlYmVH?=
 =?utf-8?B?dEVmaXBEUHNUWnorQUNoaGZOUENBQzhZK0E0ZThKejZ5MjlUcG8zeGsrZ20w?=
 =?utf-8?B?NzI4VXYwYWtWWlpkaFZMN1VFZHBFNnZDN2FPemJVTHlScGFPdzJNYkxvV08z?=
 =?utf-8?B?MDJuUENORXF3RVZoUUl1VWdiTVhlcDE5VDBkd29uZ1VweGdZSmwxVXJtbkxR?=
 =?utf-8?B?ZTRvZElwSnlwYWErcnhUbWRoc21ra05ra1UwZFBhbXp6ZzRXS0xJYmVneisz?=
 =?utf-8?B?UUtxc2s5eW56WG9rMXBZdkdEREtDQzNVV1VONTM3SU9VWkpmSTFuT2xCYlFE?=
 =?utf-8?B?N3N6c0U4eGFrQWtKeXdURVlnTTZGRTVLSm9JQ3NQUmdLOUVpTytvZnByUlBq?=
 =?utf-8?B?Wm9nUGZzOEFZZi9oYXB3bnJCdFMwdUxCblg4eUZRaEVIb2FET1FFK1M2azAr?=
 =?utf-8?B?bkZKZHhxQnpHOUVKWHhwcmU4V09TUXovazNlMXQ1ekhWbGtUUVlEWENYNTBJ?=
 =?utf-8?B?OTA1R2dlV1N2WmF3cE5QdDBqUkpHbTRKK0djODRINDY3eGN4VkFKUzRSbFl3?=
 =?utf-8?B?NldKUUUxRG9KeHZTY1R4cnRlZW1EVGhCZ1VJa3lZTlE5UGorbCtpVFp4em5y?=
 =?utf-8?B?dWpQV3NVb2x1dFpSQU5aS1pkdS9FTXhZVFRlNzhsYWU5NGxLbW1iVHM0NmJ1?=
 =?utf-8?B?TjRxWTJ1RjRSZExxaG45dzhqNlNULzNtcVhMR3BNZ3VZY0k5Sll3RzkwV0dp?=
 =?utf-8?B?eExRTUZUV00xZnpXZkNydDUrMGFxZEE2WU9UU3l0UmN0S0ZUekpHcmt2WGxE?=
 =?utf-8?B?cFJIWXR6Vm4rMlJVSktpc21XSEU3K0Y1blV4SkdYQkZqSEh5cHFxWklKbks5?=
 =?utf-8?B?OG04Y29uY1IwK2UvbERSTE50VENtMWFheFMvT0h0QWRJcUFGckxHQ1RTQ3VV?=
 =?utf-8?B?U1hUdHRlZUcrMG0zRFdwd08xcEtwaTJlVXdhQU03SjB2NVN5U1dqN25IOFg3?=
 =?utf-8?B?bEtIT2l6cE5yb1VLNEdtcTh4cEx1dEhuZUhxMVM3TnUzdEw4d0Y0NzRnZ1RC?=
 =?utf-8?B?aTllaCszVzlyMzBUWmo3SHlVTXVSN2hSRHB5dWk4MzA3d0p1eFRLUmJEb2c0?=
 =?utf-8?B?TXgwbjkvT0x6MmNQbnBGNFlLcTBzQVVFdGxoUlFMWEVQS2IyTE5uclRWNzdz?=
 =?utf-8?B?RDJNZmNNZldTeFVyWHBxOG9ScDR5Zk9ZUEgwWHdmVmFrMGZXTnhSMmduVC9w?=
 =?utf-8?B?VThyNlVjNGdWU1VmaTh0RnMvYjkwU3IxRlppT0RzUno0K3VWMUkxdHNiNjl4?=
 =?utf-8?B?SU93MDlISkY5alV2cHpLTjA4MXQzTUZ0SVRGeGhkTGtyYVVHYVc5YnhLQzVn?=
 =?utf-8?B?L2trSVM5MXhrTS90aFNSTlhUUG1pUzltVFJvQTVuaS95cGRuQ1pmc3ZLd3Uz?=
 =?utf-8?B?OFM1UVkzU2FUb0ttVzU2MEYvYWdpMnRGSzVtOU9LVml3NTJOK2s2Y0x1YVFB?=
 =?utf-8?B?cW5OZ25WVWFXR3Fia3ZHbG1XS09FTnVpYnRob3hldXZTZmtSZTl4c3RveTRk?=
 =?utf-8?B?d0pHOGZsOHNZeGVHeVRpOVFxWEFBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a635c797-f008-4940-46a8-08ddf656c537
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:57:49.4413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Vc2wFvKmUI6tviRcMr2wi91das+tQirX6vBwJKd7KgTE4qJqH3RN3Hqo2DFnkqatR48d7O6olBDKeo68+4+gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313

On Wednesday, September 3, 2025 10:43=E2=80=AFPM Dmitry Baryshkov wrote:
> Some device drivers (and out-of-tree modules) might want to define
> device-specific device governors. Rather than restricting all of them to
> be a part of drivers/devfreq/ (which is not possible for out-of-tree
> drivers anyway) move governor.h to include/linux/devfreq-governor.h and
> update all drivers to use it.
>=20
> The devfreq_cpu_data is only used internally, by the passive governor,
> so it is moved to the driver source rather than being a part of the
> public interface.
>=20
> Reported-by: Robie Basak <robibasa@qti.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> ...

FWIW, the commit subject is missing the 'f' in 'devfreq'.

Thanks,
Mikko






