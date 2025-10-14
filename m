Return-Path: <linux-pm+bounces-36092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E107BBDADFC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 19:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 682B0356818
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB323074BD;
	Tue, 14 Oct 2025 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VpC0T/it"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEEA305064;
	Tue, 14 Oct 2025 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464754; cv=fail; b=uryFs2hjPKotdsawqP9Qqz6i27jkdHujopT3BkSputynCdgJnvkAYHI6abiF2e0LawCDc55n38V66Vd50zlYEYcCmUWOsuFhSn9ju4No0uY4sdGuuIBCE1Y5fLsSgsOK0KVBK8txCTOmzMA+5/kqD1ZNhox+k4dNZ4zEVzciZeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464754; c=relaxed/simple;
	bh=qKUO0nVpsXqWBaU5qjlcReec51r1fjJaKTlSkqlgw7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aqJXlM2b8Pmioq+B+kgJVo3mnNfLovaqgZK2MujTEPZPU7C9gKY+S7DuD0Js/NLWp4fstlquqNqkauvOJYiP5TYqOcNGvpEKrCfuERkL199Jv8IXXK0nO3aXtBqFiDa0vPDsoUGkjNAk/9fBCmpcRC5tYl+ZXUphTSelFn+SRNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VpC0T/it; arc=fail smtp.client-ip=52.101.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1n58FmpOaZaowVhV26O9mx3APM/RDWGnxrzJmrW8cY1qrmlx84ZyVIrciHcBY2F7lrLs3hFxoRlfMCZn1vFd5nmYLpQwLZf269gpSk4ce5SAvZdnBSTmTXogCc5/MnAt8ZiYHturf7Xc20XxxI5yDkX4arWBtkRENKcCFxr4bfl8k9Y9hNx0jLp5FClxiLGm54x5jrTfZU1yhb8vDs4B9CNH1DKcEyBEXKw1FwfGUNgcUr0gBMNUDpzDAK67W0lcNTylAx0CmwhUk3VVko+POXNeHNAT0g8/iJm+fZDhVlZj1LYJ3yKIV/ffLVNbxwIaWVokU5fnU6cAR0YJ17Pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehU4tk+4OeClyhvpY7SyeOrjEeyYRUvRYOWaWAn8gQ8=;
 b=Da8maxAEaDfJscCIEJZKYaH9xywVHYaGPjCy7ofRJUz8XtqRZNPCuCCzrZCWRCe9/dxtFDt0wyiRJIlEwl6qIBSWnv2xEraB8wxxegeoEBuUymGgRop+RJ2LrigUYcdcHPX+V+T5pCR1i4J2UxhS1K7QMfsGTtj3NiY21Q+kDfE0aS/kg7cYWB2CL7OEbdvlvl5hDp+AHQwYV6vmOuSpuyzpcq1XQgzq0ZPuNIjHiNnbaR9YZnPrX3NiPohik8O4ma/F7DsYtyBMfx5JowmKcrJ0zjUtOtFeg/V/yS8C/URrRTfUB2+9LxfDvN09cUtoVkJcROomnDPejlTNwZV+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehU4tk+4OeClyhvpY7SyeOrjEeyYRUvRYOWaWAn8gQ8=;
 b=VpC0T/ityUVLj3cEJ6t9mw0zgcm0AQCMr3TZaf1y/IO1SIlTQQQhLMfhfxEWvEgiBlvpP8NyIiWc/i4bi+1noBl+N57bHIgWXoXbrFtLjluXQmWaf55XzMICzDdUgWj1um+wrlMVXwGzE8nJ6oNqafj8fG38diELTGk4gb09LgNuYFOEYYzhx/0LHdP9sqx8jaEIgljUHE7b4BuKGsu55O0947ypjb27LFj8LXKDUs1P0he8lHwYp2ME7mKtOhRuDn5JBbVW/sehzF65YUTgQpooJAi++sDUVhHRv607YqImavDqviM97s0xWhS5dV42Jt8nNFcdiAguWagaRlzEXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BL3PR12MB6426.namprd12.prod.outlook.com (2603:10b6:208:3b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 17:59:05 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 17:59:05 +0000
Message-ID: <c58d01f7-2589-465b-b10e-ba39e01deee1@nvidia.com>
Date: Tue, 14 Oct 2025 13:59:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/17] preempt: Track NMI nesting to separate per-CPU
 counter
To: Peter Zijlstra <peterz@infradead.org>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-2-lyude@redhat.com>
 <20251013200035.GD2734756@noisy.programming.kicks-ass.net>
 <d481f196-703e-4ed0-8db1-dbc3822c349e@nvidia.com>
 <20251014082506.GO3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251014082506.GO3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::12) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|BL3PR12MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d034d2-fdd1-4159-8d6b-08de0b4b5d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG54K3V3WEZwa01HQ0o4NjZEWnZvQ1Q4UHoyWEhGcHIxaTlUcGEyL2dtbmtK?=
 =?utf-8?B?K2hub3ZPaXF4c29pY3JLSXduY2VvVDMrNlM4bDRIRmREVDIybFBMN0lnUDRk?=
 =?utf-8?B?MVZuRkJjTHErdnRzK3g5Z05KemRBNkYrWDJKUjFHbmo0RXp6Z3A2WlI1YXJD?=
 =?utf-8?B?Tm9nL05wTHFRQ2lld3ZubDhadHJaVFZHOW50QWljd3J6RTVENHhsU25COXdW?=
 =?utf-8?B?WHcyNmI1UkZhWE56dmdGMmFic3piTm5ETXVLY3ByUWdEYVZnNXVPQ1VKL21q?=
 =?utf-8?B?eUNaT2tTUVFKSmJUMFN5VzNIL2ZhZXZaQTRrNzN4TW9yUEljUUF6MDlNL1JU?=
 =?utf-8?B?bU5xRVRoUk85TW1aN1U4VXd6R09ZeDRiSTB0eklKbmRISjhsQjRGWWcyeGxQ?=
 =?utf-8?B?cS9VUFF1a3p2emlNTEFKQVlrSVJvYlE3U1lJSkNDcCtaMUVzVlRnN1N3UHl5?=
 =?utf-8?B?QWJoNk9xUldLY0xZdWdsTnpHQmU5U3BGK3FYc0VPTElkaHFKQlRwMzI5WEh4?=
 =?utf-8?B?MlhMMlFzYzg2T1QzWVRkSHNOdXJLTER3K2xvT3ppRkJnTVpzKzJHVUxNeno0?=
 =?utf-8?B?cTFBeGtreVNSK0ZQdjNhVzdRQVdKNlVKOXNhUEx6UXE2RGcrclA1MU01Rkhy?=
 =?utf-8?B?VXptMW5rUmh3aE1MTTdzQjAzS0RLOEd0emZaeCtiQnFqK2NZWXBOOHB0QW9R?=
 =?utf-8?B?SGdCNmgzWFRpN08ra2UyUWlWUWdYQkpQRzZxdXFpY0diNmwxSzZIQnBPZVJq?=
 =?utf-8?B?ajAvVW8wemcyM2U2d3pFMm5BditJYVd0Ly9DTDM1ODZWeFBhTi9SeS9xU01X?=
 =?utf-8?B?bUQraThvNmFvMU5ZSThMNFlRMlFyWmZwNG9PRTZBRUdhbXgxTVk5SW14bUJH?=
 =?utf-8?B?UFc4TVlZKzJuZlc0Z25GdGRFTFBmVHY2Tnl0SURvZ2VJcllVb1JSdDZGVktS?=
 =?utf-8?B?YldrSld6Z3EraXIrTkRBMm5nOUZZTWI3enN4UVR4L3gzVWZQbGNNMkQvTk1Z?=
 =?utf-8?B?Z0ZpQkcxaFlselQ1d0hudEo3Y2hRZGgrM29WZWJwckUwNGFMcWxFNDlQOU5P?=
 =?utf-8?B?OG9VTjJXaU5XNERCYnZIQXVUTHFrQy9kMmhwZkU5Z3NOQXJJekFya01xV1hD?=
 =?utf-8?B?bjIrUUlDTjhpSmNkUHcvLzljSjZGYnZsdXc2ZVViakpuSWFRYWQrTE83T2Ru?=
 =?utf-8?B?TDkvSzFxRlY5V1Y3UDZ3cE5JNGZZOWNrUmU4NW5yaUhZQWhkNXp6b1pXWTdO?=
 =?utf-8?B?bmtaM1BMaCtER3BrQ2Q2TGdvVW1PNHBUSEQxVXptSlZPbGdjMEp3UmFFaUxJ?=
 =?utf-8?B?MGlFVnQyMVNUcmxhUmNXWXBvQ3BpQ2NPVERvejdpazNPajd2Nm9UVTZ1RjhD?=
 =?utf-8?B?MTdmQ0RidExDc1JKQ2tFVGl3Z0lXM0ZLa2dpU08xVmUwektWUmI4Z08xNXN3?=
 =?utf-8?B?dFZQVnNIQXpJUHZjY0lJOXhyeUdicXlxcHc0dVIzTElmTEdDcUIwOG84QTYz?=
 =?utf-8?B?ckRqVHllb2pMd0g4aEwvUU1VQisvWDlreFRMMjFrYzJTOGZLcnVKbTQwYVFI?=
 =?utf-8?B?T2xBcEMyOUVYaFM5cW16Nncxb3hCdFA1R1R6WHhUWUwzZERRWnlaaW56WVEr?=
 =?utf-8?B?SFNGZzNoekpQOHJwUGhjQ1JwNitiUm9HZFdPaUJWdVhYek5Ed1diZDFFTlN5?=
 =?utf-8?B?dThWWm1NT2hVcmVPQjVaUU00RUFuSzdyd3JsTDRjNVVGMUlxbXdkeUZWcFVu?=
 =?utf-8?B?a1UzK0daRmR4eWk0MkNDWGFtSy94UnRtNDBFRXk1TDFJUTVkNmFwTUlzbmJs?=
 =?utf-8?B?Q3RBNXltOW96WW5SOS9lZ3hwQW5hSURSUW1DSEpBM2RTSHlFTXBhbTNORGNI?=
 =?utf-8?B?dUpGeVlCL3c1bURtVDd3OEU2NitqYnpXZEQ1KzdBRVl0anRYaUNpZytkRTVj?=
 =?utf-8?Q?FhqqNNMRmfyf7BLl7aYBgkKzCtXDGDff?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFZiUlk4UWRlT2R1dVhVMXQzZFBPYXFqdUpkak93SVVCM3BFbVhJbmpENEx6?=
 =?utf-8?B?Y0hHdWJUL2tnTmlrUldUWW9iRkQ2WisrK3RnVGhEZllvTWR0UGtOWHdMeGx5?=
 =?utf-8?B?QkNrZnU3c0F0aDYvTGZBK25GZzBBQnhpQXQxOCtkeWNkZVNiRWtwTXg5TFIv?=
 =?utf-8?B?Nld0aVNOYnVnOE1neWJaR0tXN3lZWUIya0NSRWltN3grUkVjam81UDN1M0w1?=
 =?utf-8?B?V282ZHAvMldFdmJoamJNdDR6RzJyQ0hLaXRZaUlHWHFVN3YyazlsV0lFRzhP?=
 =?utf-8?B?SGd3dUQxcFVCVDA1UCt6MC9QaXloUlhyL3h1RGQrZE1tQ0hjSDRXeU4wbUpv?=
 =?utf-8?B?bnEvUituLzhURUYzTEY5dnQzUmpCVldyWll1Tzh6VTRqNVlETjRxcHh5Ukx4?=
 =?utf-8?B?VXhEMURRZ2dXNG8rbHVKSlRGSVNnb3BQblRTVmdtRGdOaDRMZEF5cmRSWk0v?=
 =?utf-8?B?RnVuYVlVVVQ1ZnNteWhsYWIzWGhUVzFabzMySURTZUgyYU00d1BYZnB5WkJD?=
 =?utf-8?B?dzlVNE5zd2VVZW50UnVkU3oya2UwcEdrRkNQYzg2Z1p4d3phVGVlODZWbFVQ?=
 =?utf-8?B?eHN4SzBkWEZzYWdFaEJjQU1sRVdFdGhENTJJd2E3aXdOUmJISmJsdEpYQ2gx?=
 =?utf-8?B?ZFZoSktKQXFCaEZWZEllZGdmK2tGS0FFZVhVWG1HTmp4UmdndDhBYjM3VVc3?=
 =?utf-8?B?UzNFSnV5N241MXJJSXl0Snpqb0Z6dmRQbC9tbGhMa3hYVXF6a3J3U29xMS8r?=
 =?utf-8?B?TUxyVisxUkY0eGVobi9hNzRqVDRiTkRnMjVDUDM3OGFqMWlwK1pQMXRBWXU0?=
 =?utf-8?B?SjNRUkJaODBWZTRHV3ppa1pKTXFvRUQwcENWYisraFBCWmtONGRZRmlPOExi?=
 =?utf-8?B?MEJiTDJCb2l6MnFlQ3VTUkIrdlFnTy9BaXpEdFl2RFpERStlR0dWU1FEbE41?=
 =?utf-8?B?ZnlEZ1hsUURjR2MzQ2pxQUNONERzTy9USGlpMGV4L1Rna1h5OHRVYTJDemtw?=
 =?utf-8?B?NlExSUpoK0dhUjBIQnp3TjF1UVIweXp3U3M3RW9jM0VYRWhyY1FTQ0hKNDZI?=
 =?utf-8?B?QU45SjlYMWtsZVRqQ09KVDF0YmNwRE9ibnVmSFpqdVo0a0lPZ0hhSllHa0E4?=
 =?utf-8?B?a1VmYlRtZWJON2VBOGxCSnhHUzBGNXRtRElOTklJWFlQN2lCUGhiVnRvSlpL?=
 =?utf-8?B?K2tVU1JhVGdmUk1SUFRNMVhpOWp2L2tJT2xTMW9zY2VUOCtSVWkxZWxFK0xX?=
 =?utf-8?B?UjFSQlN3V0lEcnFRMmxKNnprQ0RIaFNzR1dtYk5jQ0FtYlZYajRVb3V5ZHpj?=
 =?utf-8?B?VzMyNnNaSnEzWnU3cWZwQk93eTZESWNhQi9MNHVtc3c3RlVsVit3UEFvSDVt?=
 =?utf-8?B?TUMwWEF3RXhRbTBGcXIzVWF4ZWZieHVZR3dnQkhFU1c5Z3ZjMWt2cGI0eE1F?=
 =?utf-8?B?NE5TaEtvVnJjcjAxUk91N3FJTFlYSUpYUGF1Y05NSi9BTVRYYWNRUjNZaUUz?=
 =?utf-8?B?Z01yZ1FPNlUvTzYyaTFFQXl5ZFczNnhsZW15U0ZSRUw1TDhoQTdKTTQyMUtU?=
 =?utf-8?B?dm1wYUlhaHltT21CUFo3ckFqRlgrVDhnU1BoMTI1bTgyVE9OaDRXOXUvc1Rx?=
 =?utf-8?B?anh1MFFEcG5QZHlSWmExZ0ltaVZjWGl2bjhtSTZSMTlIZjd3ZlRCbkVIN3h1?=
 =?utf-8?B?Ylg2U201M1JnQ2NvNTBCUExxS1Z4YTN2OHNnclg1NmxuQWxKWjB6enFROUVF?=
 =?utf-8?B?b3lCUm4yTHhpSlRLQXhoSFNKWVZYUFZiUUh4V2xJanN5R2pHR25zM1paWkhy?=
 =?utf-8?B?dUNsSk9oZlVqeFA0blh3dDJDeXBLSUNoSkM1cmhRYWVQcWRNTkpGenA3QWY5?=
 =?utf-8?B?aFNXa2hFek1rdVcxUDJHaThBMVlKWis1ZnQ4dmRBUC8vbFZCN3NldEZqK0xF?=
 =?utf-8?B?eFJNN2t3SUhpN2VaeEJNdDQ4NnRkU1ZkeWR2TFJsUkQ1N1ZtNUl5cEkrTlRa?=
 =?utf-8?B?NCtxbFA1clRqMVVicWlOK282STgrcmVTZnQ4dGRQbmQ1Wi9wVFJVdjA5NVM0?=
 =?utf-8?B?SjQrOGlrNmFBa2k0bVZwZWZrUm15YkNkcGM3UzMraTdYQTRTNWYwYzJubWln?=
 =?utf-8?Q?HoPxskgiS1OAjW/h98Dhphop4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d034d2-fdd1-4159-8d6b-08de0b4b5d84
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 17:59:05.4184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7i6uX9fYkbwWjLm1MRdlUZ97e6Gy68ARyd//jK3hHh6ArvFVF0xhP8XruzUUEY5D1zpCrdRS98FEwK/qhYsd9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6426



On 10/14/2025 4:25 AM, Peter Zijlstra wrote:
> On Mon, Oct 13, 2025 at 05:27:32PM -0400, Joel Fernandes wrote:
>>
>>
>> On 10/13/2025 4:00 PM, Peter Zijlstra wrote:
>>> On Mon, Oct 13, 2025 at 11:48:03AM -0400, Lyude Paul wrote:
>>>> From: Joel Fernandes <joelagnelf@nvidia.com>
>>>>
>>>> Move NMI nesting tracking from the preempt_count bits to a separate per-CPU
>>>> counter (nmi_nesting). This is to free up the NMI bits in the preempt_count,
>>>> allowing those bits to be repurposed for other uses.  This also has the benefit
>>>> of tracking more than 16-levels deep if there is ever a need.
>>>>
>>>> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
>>>> Signed-off-by: Joel Fernandes <joelaf@google.com>
>>>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>>>> ---
>>>>  include/linux/hardirq.h   | 17 +++++++++++++----
>>>>  kernel/softirq.c          |  2 ++
>>>>  rust/kernel/alloc/kvec.rs |  5 +----
>>>>  rust/kernel/cpufreq.rs    |  3 +--
>>>>  4 files changed, 17 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
>>>> index d57cab4d4c06f..177eed1de35cc 100644
>>>> --- a/include/linux/hardirq.h
>>>> +++ b/include/linux/hardirq.h
>>>> @@ -10,6 +10,8 @@
>>>>  #include <linux/vtime.h>
>>>>  #include <asm/hardirq.h>
>>>>  
>>>> +DECLARE_PER_CPU(unsigned int, nmi_nesting);
>>>
>>> Urgh, and it isn't even in the same cacheline as the preempt_count :/
>>
>> Great point. I will move this to DECLARE_PER_CPU_CACHE_HOT()
>> so it's co-located with preempt_count and run some tests. Let me know if that
>> works for you, thanks!
> 
> Well, I hate how on entry we then end up incrementing both. How terrible
> would it be to make __preempt_count u64 instead?

Would that break 32-bit x86? I have to research this more. This was what I
initially thought of doing but ISTR some challenges. I'd like to think that was
my imagination, but I will revisit it and see what it takes.

Thanks!

 - Joel



