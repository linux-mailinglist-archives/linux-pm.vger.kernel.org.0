Return-Path: <linux-pm+bounces-16258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB09AB766
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 22:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD52B21B3D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 20:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE44D1C9B9F;
	Tue, 22 Oct 2024 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QCA8UmfT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3646D13AA2B
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627533; cv=fail; b=l7X1fiiIR4Rbmqo1uJtZxtPcsx/sesvD8k/vfwdJvt5zm2Z5UE2B747DYmM1kMSGVYn+w/PtkEw0n+nulbqRwsjCfnHP2ngexluFQyJs/VDKVi27OTnWVv4htw50+Y1v9lqiy0JXNUp2eini9E05iZtmkRNBRQwCoV3Dshc4nps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627533; c=relaxed/simple;
	bh=lNYjvjcZP4HzrIr3THDZS3vea7RditlybSpvr2x3qt4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EPivIwAvrTew9ODVqSZUfyTjMqHUQb4w8PpT4AZlkqtnBB73oeOOLFUev4bvWpyDvijaxRuo5NYCr5lP4+510jB6bg5g+VBdJVAolQ47BrZiSGwP9SV3l9/M7xdUWBnVwzq765n8toticP4wQuwfGWWVAwTyiU4fxg4gUtbfO+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QCA8UmfT; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyW46DtL3sM9tXzs/UiOQNkeH0/lit0/uTrTLfvC3BiOv8jvjQLPL4awGtOr2ow5wG08J5uALal8WbhBUysVuJEF5VeaQ2drXC45j2vGh/lCONR171ru+446vwNfzilaFfI7y5XxrMhaHwByMFI8H5NdVqiVXH1/WB2gzRI27o5b7B65Q+CS+Wscm4syd8EOMahzjv1aSSuQw4z5p600CikBc9HFoM/U82P5B6pDty6cSIkYiFiTUxdoN75GGucpTvhYgN73BAE2PDGwq1C5SBG9zNLgJ+9mvdSilNCReuri+AFuuoJOGK3HYOZV2dMBdpnWeawBJdoylsrrSgRYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGOI1UptpZYkv9IL0ER/qo0L7aJwwuJPPEWh2Kp/jt4=;
 b=oPxStzdQRDg+rJuqaKxJjB3cbsk5cNkTI/C/IN/daYtTD8WqiUQ8uAXNK5RMU7gwpvMAcbycAA+WXJHD5kmigRwAYY8LYKuT6ew6Xs0YGgGw+C4EqfNK38AwRCKLOx0Kfw9BX/6AWebh69ObdfsrqHTEej3DqAUghF3/6AEJd5BpSQkN5h2+h457xxZbNpfVUp+2xl21XyVkiiPoObr2f30xWF49V5jM3C9JQhkSQFgHunnFLD2WIhjRe8Qnz6Mu2lLsRhoo+0LSpMtIxELjJybIu/ao1JO9K5lFtg6+RN19ExbGU9xSN/RhONWqe+5DeRJgwyPtdD+jmZwVL/uDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGOI1UptpZYkv9IL0ER/qo0L7aJwwuJPPEWh2Kp/jt4=;
 b=QCA8UmfTzBBdvnj5YnlocRWV8YavnYTp+PQX9dJ+EAZVNQi7oazbRpWlIcrXyawNtRbK5tXLsUiIxDJmaBTA6ZxxptHClGO6T3PzuVeElKmEKOJ81wdlMJ0Am8fgf0c7/DI6vaFT2+4QwAScQUbgoiwbfNCjpGSSGvJ9tR5jN4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 20:05:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 20:05:29 +0000
Message-ID: <a2e7c093-66e2-4efb-928b-86fd55c21f65@amd.com>
Date: Tue, 22 Oct 2024 15:05:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Preparing next amd-pstate PR
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
References: <bfd6e381-b3e1-457e-b992-d6d9be5e446d@amd.com>
 <CAJZ5v0gwO6hLGu1iNu+GKz6_LAMaZdY_8htDhVoFVixUhSO1zg@mail.gmail.com>
 <CAJZ5v0j7HpUN-heihZL3HZDMLV0y7XCw2nvkHgFCGZPhhFroAQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0j7HpUN-heihZL3HZDMLV0y7XCw2nvkHgFCGZPhhFroAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:806:6e::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: 822bf512-0dc1-499d-c6c1-08dcf2d4e0af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UExrT2FZQnFHeEVUKytyR29xOTFJa2hWWjBKL2hHN2JLNWFkaFZ4K25ZUkdI?=
 =?utf-8?B?ZUJRdWhvWVlVdDFDLzAyUThIRmdEOEJhOHl2akNzT1psdjhDRlRzeERvVVlo?=
 =?utf-8?B?ekFDOUNZc05rN2tLQWltSVhqeWV3dkxveFozQ1JIOUNPZTM4MEFGb2NwUnVV?=
 =?utf-8?B?c2ljb1dVbGY4MTVmS3NCeDV4OTBEMmpjV25NUEgxMDh6dmwrd3dzbGFqd3ZF?=
 =?utf-8?B?dGdUd3UyNExpblg2SlFPTlUxWFdQZ1p4MS9WSW5tdXMvR1VqcHRCdlhua2FG?=
 =?utf-8?B?bUhjTHBUQ3ZUNkhzdVJkajdHdVY1U2xYOGhuSGtMM2kyRTVxcTZNaU1DdStR?=
 =?utf-8?B?akh1YlFWakFvL3JvVEF0WW5HWGl4OU5BejhMUzRLc3QvTHpBdXNTQkhnTk45?=
 =?utf-8?B?YStkRnF3WXFmU2xmM2Jidklab2haR0xJNTFFWGZaTUFZbzFuU0Q4MVdlQkd4?=
 =?utf-8?B?UEJuK1RITy9CSDNYaTQ0dE1zZ2lzb1JtVHkrcldCWWxZOUNYa1huWXFtWU5K?=
 =?utf-8?B?K2JPV2tXOWVzbnIyWHlKbFNiNFdKYkhCS0RIQUlTdVFKaEx1elhBYXdiOGNX?=
 =?utf-8?B?MmdIb2VMNVNmL0huL0l5S2VvT3NrK01RT2J6Vk41Y2MxMTUxU1lNaVd1L2lJ?=
 =?utf-8?B?dVgzeTkxTGNWbEY3SnB6VlFabHl0Z0c2U1Q5NUJ6WnliZHBrL3dLd1NpeHRC?=
 =?utf-8?B?YXRWeHkxc3ZJVHZWOXpRdEZkQlVDakMvT2VsbVZockwxVmsvOHdPMGV2NEFI?=
 =?utf-8?B?bnlpckczbEdQT2VvMEF4YnR1cVl5eVlvdS9uai9iUHdvQWVWb05NbGxveGdI?=
 =?utf-8?B?eWhBYWU3YVd5K2g5TmdqM3NRYVFvLzFUN3g4cERkYUZsZlhVdHFPanFqR2dk?=
 =?utf-8?B?b0xFWHFJN2xYMzZzZHJhU2V6eFN1VGd0WE5TVDlmT0VhSU51bHovd3MvdkJC?=
 =?utf-8?B?ZVUyU005NmZFekVwVEUxUW9oU1FYVzkzajhyWGVDVVJTV21HeUxyaDBrckhi?=
 =?utf-8?B?dUZrN045OEpxQVRVTTZlT2dHK2hGRVV2UWYvOUhoVmh1MkQ2SytQYnlTUjdN?=
 =?utf-8?B?aFRFbWI4M1FDNDBPZ2Y3bXJvcXdyOXZiUEdlMFBoelE2YlhWSUx5T2s0Sm8v?=
 =?utf-8?B?aUFmQVh1UDdPdGk1SDNOOFRMQ3ZjczE1aVpnN25hYTZVZGpGQUVCYTVqc2xu?=
 =?utf-8?B?b3E1YlZnRUxFdVRpdGt0c0xxUDlidVJKRE1XYnlWVXBCR1BnSnZES21qQmhY?=
 =?utf-8?B?NWF3c3RCYktyb3EwdGFkb1BlOXZjYUo4TGtlSUZPTXhZV2tRUFFHU2dQTHBU?=
 =?utf-8?B?bnVlSExCeVpVSlZlbmk4allKemZXT3JzYVRzTHZ0dkUrRms4TGNNSnE5SjVx?=
 =?utf-8?B?RGlDZHN2eTM0SmxLbDVINHZJYnA2SkMxZ05kTGY5amdINzkrMWwwaXpNY1Br?=
 =?utf-8?B?Q0tERmt2NGhDZG5ESXVoV2pRSXpqWGxNZnlGazJ1NVN3bUtreWlzek5rZ2Mx?=
 =?utf-8?B?Q2Y2SXRyZGozOHFESmxYNWdnR21ZUlNpL3I3MUh1V0prMGdoc0QrZ2hGdXVt?=
 =?utf-8?B?c285LzE1T2s0TlZUTFRtMDdKYVJFZzNZZlcxaWxxc0U1UlRibkFJYW50OEkz?=
 =?utf-8?B?Y1hXa2tFUWRZeS9TNGtha1V2KzgyMVBzM2lLVXRycG55K1FJamp0elprQlpu?=
 =?utf-8?B?VHRyNncxTXNiWktZbnE4K2MxZW1TS0xlZUF4dHZTMG1oSDJPUzlPQTVwMDJY?=
 =?utf-8?Q?tSGzYqrqVdNxeT9oQV7yLa5sd24AXRRVjQpCOft?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEZvbnNQYzM1UitUdUpiUGhuREJNT2pPOXVBc0dSdkQ3b2xXUy8xcUtIb3ZS?=
 =?utf-8?B?VDllZ3Bwc3I2RGh3U044UnlTT2tuLy9JTWFjS0FTRk9Pd0U3SnZObkdoUnRk?=
 =?utf-8?B?L0N1VVRYNlV0SWZaeFVyZUhMQ1FpQUc3MmRmNnE5M3l2MnpybE1HeEh6VWRr?=
 =?utf-8?B?RHdWMHBJSDE5VG9FK3BUY1JsWHhOT3M0UFNkVVV0b0E4cklMUmJHWnZvdnpt?=
 =?utf-8?B?RGxyUStGWUlaUlhQWGRFRUwvMHE5d3RZOUVZQ0xUeFczVStyVmNhNnZYYURx?=
 =?utf-8?B?SXhJNnJUTTNld1doeDhGQ3grd3UyQ2xoQVFjWmtHazV0NHBkWnBGU04zamdD?=
 =?utf-8?B?TkdKRFBrNE9PRkkrVHVEcGhidWJuY1BBemRQZURzeW9yazJXTVk1M2xFZUpw?=
 =?utf-8?B?ZDliQzJpL1BEalRTOWg3VVA4UzNGTjBEb3JsV0o5RXM3VlpaTlo4SHpEVmg2?=
 =?utf-8?B?OFVhZ3FUdXlSa0VOdTg2cytZU1ZIVmZnQUtuVnR3c3JhRUgwUnhBTW1CK1dj?=
 =?utf-8?B?MnhZbnBJdWJEUGJJUDhyQWM5Nnk0R0haMkdkUSszMnZYanQzUmxoelpJMzVB?=
 =?utf-8?B?MC91Qk9oV2ViOWdxUXd5Z05GYlJCUmUxeDY5a252a0FQZ0t0VjlvM3hqdlFE?=
 =?utf-8?B?UUU5MUhqV0hxRGI0Z0tmbXd0cko2c3dXTUJKWFFOcG5rNVZ1eVV4cno0MzZ1?=
 =?utf-8?B?QXNGV1pOa1ZpU0tUcmVsYlFUZXRkSisrT2lQSjhUWnc5bm9pL08zbGM0NVJC?=
 =?utf-8?B?R2tiZ25RQlp1SFVCeHJEa3FMY1llWDJZVFUvWllxVVlFRnAwbDVvMy9tQjlO?=
 =?utf-8?B?bzd2dU1NUlloeXBERURJZjN6c1NoVjRhWXJWYjREUFZCQ3N2U0hsN296M2ZW?=
 =?utf-8?B?OHI2cUIrb3JsdWlLbmp0eGdpS3BiSnZpcmQ0T1lnZnNJYWcwNVVuNmtya1Ux?=
 =?utf-8?B?VnRBNkZqV04vNzVaeUxZdDRXODgwUE1QZUlTbld3aGg0NzZnRFUyKzIxN0Vq?=
 =?utf-8?B?KytmalR2OWozM3Z3My91MGczQzY4Z2NKL3pMQ1FheFZNV1lpb3Q1S0hkbGdq?=
 =?utf-8?B?MldyYU1mdURkZ0UwaGRpbHFxdWE0ekIzbE4wbk8rek9oWTRSV3l3d2ZBVnBF?=
 =?utf-8?B?T3dpYWdvamRlaHVHeWxHWG9Paktha2JhZ05aZXlHckhGWm9iVVVjZ0Zmeldx?=
 =?utf-8?B?eHpvdXhTTFNBVzNmQUovZWw0UGgyWWlEb0RVV1IwNEIwc2VnbW1FNEJGVEdx?=
 =?utf-8?B?dmxnU1o2QlFNOHFCMjZVcHgvbFZocEJFMDVSdzcyMGNRdHpVTHpDdlI2N21P?=
 =?utf-8?B?aWE1SktHTG1oVFU0QVlmK1hHbjJlRElZdjNaSGJlVUFmcG9sSnhwNnB4WU9w?=
 =?utf-8?B?V3hGNS9rcGEvZ2tKN1ZmMHRhTStCM1pMU01KV09iQXdGOWkwdzkwNUpvSUp0?=
 =?utf-8?B?eUNyb3JUYkhnYXVTeEora3p1VnRPbFNYQzFhM1ZFZHdqQXlIcmZ4V3g1enJk?=
 =?utf-8?B?ZWY3WURXcTVNbGRKUWhuQnpoYWgrNmJPb3lKTk8wR1JuNjJDWk8vVW1INDJj?=
 =?utf-8?B?N2N0NEsxblFDNi9XdHZ2YjloZSttampoQm1hZW1UdS9sV1FnRHZaZ0tBeldG?=
 =?utf-8?B?YTVFSmNjeDYvQWpSL09JRVlXV1JxTDc0bzBnODIzSUFETHVyVVJ5RFE2SitY?=
 =?utf-8?B?WWFFSkJZQ2JmdGRKK3lGcDQ4Z1djRnVSeHdVUGVuOWJSQTExK0h5QUl2alJ6?=
 =?utf-8?B?OVZobFArQ3hsVjhOcmwzd2ZCMEFRMEJKcERyOW5qZ09rbGxEemxCNzhmS2lK?=
 =?utf-8?B?OWVENG9ON3BRVllkVE41OUMxZElTbXVwaHJGbzJSeGQwOU0vMzhERmNOMUF2?=
 =?utf-8?B?UytRdi8xWlZ0MmxLdDd0ZVlBM0NPWWdWYXpHOGplWmlxNUNmc3J5d2lPODd1?=
 =?utf-8?B?REVtb2J1Z3RoMXp2THRSK1FIZldObTRvYi85OUtsMHZXY2FhSWI1djA4OUtM?=
 =?utf-8?B?T1o4RWlHd0QxbDQxdFNaUFJXU1JQY0xsaVdscEhmRTFLYVhVNlhGekZQV1RC?=
 =?utf-8?B?VXhrd1dHQkZ2VytiREp2Z2RRNG5iYnNLRk9QZ0UrL1BtS1FDa2VCeFV3TG9l?=
 =?utf-8?Q?hYEAwrVvNO2K6rHzEqvt141zj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822bf512-0dc1-499d-c6c1-08dcf2d4e0af
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:05:29.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LifeaE7mg+djAVp3tiYuseOdx/5vPTLpFCp3P4leIYX4Mad+sHgQszH7jziLDtWaHC8aUIhk6jLA3bIaiGoqsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600

On 10/22/2024 15:04, Rafael J. Wysocki wrote:
> On Tue, Oct 22, 2024 at 5:32 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> Hi Mario,
>>
>> On Tue, Oct 22, 2024 at 4:14 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> Rafael,
>>>
>>> As Boris mentioned we need to drop these two commits and go through some
>>> more review.  There's an active series under review for it.
>>>
>>>         CPPC: Use heterogeneous core topology for identifying boost numerator
>>>         x86/cpufeatures: Add feature bits for AMD heterogeneous processor
>>>
>>> In order to prepare the next amd-pstate 6.13 pull request, I wanted to
>>> discuss with you the best way to do it.  Those commits came into
>>> linux-pm/linux-next with this tag:
>>>
>>>       * tag 'amd-pstate-v6.13-2024-10-10' of
>>> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux:
>>>         cpufreq/amd-pstate: Fix non kerneldoc comment
>>>         cpufreq/amd-pstate: Rename MSR and shared memory specific functions
>>>         CPPC: Use heterogeneous core topology for identifying boost numerator
>>>         x86/cpufeatures: Add feature bits for AMD heterogeneous processor
>>>         cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory
>>> systems
>>>
>>> Unless there are other conflicts I'm not aware of I was going to suggest
>>> that you just drop this entire PR, and then I'll take the other commits
>>> that were in that tag besides those two in an updated tag.  I would then
>>> do the next one based on content in linux-pm/linux-next instead of 6.12-rcX
>>>
>>> Does that work for you?  If not, can you advise how we should do this?
>>
>> Yes, it does, no problem.
>>
>> I'll get to this later today.
> 
> Done now.

Much appreciated.

> 
> For the future, I would suggest sending pull requests with stuff that
> has been reviewed properly.

Yes, my apologies for the trouble.  Lesson has been learned here.

