Return-Path: <linux-pm+bounces-10329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF0923A48
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 11:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429921F237C2
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 09:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E3F15572D;
	Tue,  2 Jul 2024 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WvMkW0p7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47D156F3A;
	Tue,  2 Jul 2024 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913178; cv=fail; b=ABII4SGa8gnFI1rU5dXXxbnKlmClYFy5pNAMEidMKm3L2Ih/Qc0rF+Jp5qXgI+neGDqSuHBqsIMUnWWmvtvR8jjK6/qLfwTOqpnEQr5FKLj1DM2HalwGP1D3b+CurTcWm5YDeRBoIVwaB065sIPmrVdQERMbZzgcUjh3wzmKgGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913178; c=relaxed/simple;
	bh=ZdlkIFFmy6pab/DKJd8Pck9CLOFw/KFvnfCvx6RirWs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rp8pDAY8lObbxC55YKs21cHZK0DOMQnG7NCuldVBsbfyVePWL62nvdcMp7B/AKiCHbTHZ1NsKmGnZ5cQ5LNKge5BVCknsk+jRvq6TQB8DHEBtUT2oWd4CKSVAlo4gkWiTOkuV+SmUCBrQ8jVSERCZrrn+5jwtL3bGIBBtf9LlSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WvMkW0p7; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgtfWx29pvDNozjXnfJMoo4DrzLskPzTKxV5qrV5ki2tgPLQQO0HRbMk4rDR0Yp/zHtnDxcdUu3x7acGYhcsiI/tLPs++kViSJTRGxeWedBivOdyQVzUCtrLeeN/PWQhcYctVzOnX3kVbo3aYXPhp8wrzPV2QiD08HIHZ/W8HIws7y/e+KRwXqKkTUDNmjJe9bOqkMIhVodVlHPkSCRI2wbwBz9aaK1jB39DszrsWqH5PcjndYnISDysVebho7Ksnpk/klWliRszXeHBvZCmltTBq8CGic3tTLK4tZM8dAFFuZcxbHxtGjd6rKTGl1BGjO55lN+DaKsK9Gf5k6tFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBm095lWyeKjw63llf2J2WguQ0TiKyjWQGxaNvS2fCY=;
 b=JAgWWaBvZahNlQSMmNUtgCdIPK9ke2KwmGv4r9RKyoT9MdcMI8QrxUu6TU8TJVLM+b4BouPUPRo6dAZ3+wJbZaZYp3g8BwrofEjLCkI/yf2MTxhwPJT57r6NtaxyamewnFOyR6hXV7W7cAERuFZ5DEGg6zgPsC4/wUp+wIcWevDd4sCtHONXIFD572FqdaNdWTikPIc0b2CHJdSqcYIYjHQf3zZIXZp53Wbc48qb/HlUSCfe8F5+6Nw+LNeGrdh+PNez/nYuta4Qww28KSOD0dyctCRyT8JAVhSClCad478uFV/o83iuK/6sUyWyte/aAKocdCRvN/QOT/UREG72lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBm095lWyeKjw63llf2J2WguQ0TiKyjWQGxaNvS2fCY=;
 b=WvMkW0p75H7nLAlHkj4DcRgXVfpPoCxdNrGRHom8fVYPUQ+KNCbIp7ct9xwcMbcx1RtKyvoM616HMROW99qN6xDmG8EaiRx8GIRy74HKmA92f+xp/9y9vCKbZp1rJNKbWDfJ8g07cCFFwCui6mSMZb0DXzEY0YN+k7SdgesuokA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 09:39:33 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 09:39:33 +0000
Message-ID: <b1e53de4-444a-4f1f-ac83-5dceba59b06d@amd.com>
Date: Tue, 2 Jul 2024 15:09:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] perf/x86/rapl: Fix the energy-pkg event for AMD
 CPUs
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, kees@kernel.org, gustavoars@kernel.org, rui.zhang@intel.com,
 oleksandr@natalenko.name, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 ananth.narayan@amd.com, gautham.shenoy@amd.com, kprateek.nayak@amd.com,
 ravi.bangoria@amd.com, sandipan.das@amd.com, linux-pm@vger.kernel.org
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
 <20240624055907.7720-3-Dhananjay.Ugwekar@amd.com>
 <20240701125921.GG20127@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240701125921.GG20127@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::21) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: be38e6a9-e1db-4d9e-2abc-08dc9a7ae12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVRMK051UWQ1cFVqcGtsQWVzOWE1YndBVDliMWVwM0EzODlyelVtc3RRR2Ja?=
 =?utf-8?B?U3pzcTVNTHFla2pydzh0RjhDUjBZZnl6czF6Z1hhbXEzQ1hMZkdISkx2K0Za?=
 =?utf-8?B?ekxiYWRQalg1THFrMjU0eDNkcllESHFnQ3A1cjJRdWp2VkdzaHdIdVRsenI2?=
 =?utf-8?B?WWZ4ZGFDYTZESXd1cElmOURZVVVYdVU4MVBaa1Q2a0U5RllLTnh5OE9SNnFM?=
 =?utf-8?B?K2wxcm5uY244cU9ORFBZY3pKRDJEdDVPRWhmZmdaWHFTa2F5SytWaW5ZSnA0?=
 =?utf-8?B?WENVb3k5K2pPaGhjMXR2RkFUYmVVbzBYZlZWbTdNYVRUNFBUMTU5bkxEUVJ5?=
 =?utf-8?B?SGhWQUR3b1Y5UkQvdmVsR2JROVRFNjR1L0dwdVg2dFhTdDZqMXE1MHNHVHA4?=
 =?utf-8?B?NkxRWTM4ZUtGbC9kaGMvbmQ4cGxDUWY3YlhMVGlwVUE2emdzT2hTNFRqdDNa?=
 =?utf-8?B?b0pWV3NiYktGWS83OVpnN0FybGRRUTNXbmdCTXE2ZE1zRmFuZHQrUGpyVmpU?=
 =?utf-8?B?cEZKU2phY3ZRY0dxSGNwQThDS3M1Yjh6bCtwWGw5NE0zMkhRaHRqZGlMcDdX?=
 =?utf-8?B?Skk0UEd5WGZ4bU8rWk00SENERFNYNXdhSS9DOVM3VllVMVkveG43WGhQT1VS?=
 =?utf-8?B?U05PU1poNXkvYnBPRVlqN1RDOGJPM0hITG1EQ3cvUnE3UG5aZzV0UkoxdHBV?=
 =?utf-8?B?SFVDa1pqdHJzSmgxYjc5UWhNZ3YvNWI3V0pBLytkRUIrK3BnWVJNMUVDcWN0?=
 =?utf-8?B?R2RsaU9mOTRBZElKd1A0VlJWNFJpOCtqUXY2T1lqTWlMYm80Z0EzdzZGTXhO?=
 =?utf-8?B?ZlNuQSttcjNSUHV4ZTluVGgrdllnLyttUkx0citSc09Qcmc3Q1ZCZzQ5SGlq?=
 =?utf-8?B?V2ZzYStaOFRCdFBKRSt5eXZSTW54Z0pnR081K1pCQVg4eG1lSWw0L1VTRlJs?=
 =?utf-8?B?c1RuWVFucm1WcDg2c05wWVFGZXE3NmZjSDhYL1JuK01qVnJQdHJTa1Y2S1Bt?=
 =?utf-8?B?VlJXYkl6RkdTN0ZPYWRyNlpLeGpIWk9PQ1hXVWxLb2d4UlgraUJHK3RweDlq?=
 =?utf-8?B?UFY5QVVNVXhVWmExcDlQRVRyV1VuS1laeXR2UnExYUV6VWVUY0NNcVU4akNQ?=
 =?utf-8?B?ZDVKMDJCWUcyYm9hZ0lYa1lJRTdSdnRERTVqUStxT1ZiUnZvNVhobTdVQ0lp?=
 =?utf-8?B?ZlFEZWF1c2JFd2NJTXJOWWM3K0JsWVZPbUlVS3VSTCtMSkZoOFRtK2NKMHgv?=
 =?utf-8?B?WUl4b2JDSzUzTmt6U1RhYVdZOUI1UExtYUljQitZUTdZNzVXZUFsaGxnNlRF?=
 =?utf-8?B?UUYvTEpDMlFJdEszQVJlblJTRjZzYzFxeldKOW01NktSNTRMOTM4UmVyTjl5?=
 =?utf-8?B?OVU1aU5JSFVCZ3BQVG5oVVl2ci9aR0hxbzlVVVVOc2Q3K0FEZ1ZPeWZLOG1J?=
 =?utf-8?B?cXF1VnhKWFN4ZHpxYkhDVXlwd3duOHNNQ3U4MEdCdWkvMVZ1R0ptaXpvWHYv?=
 =?utf-8?B?SDVSL2E1QVE1L1FGZFJhTXljQnAwRzNBRFcyVVU5dm9FVjFhZDB3a25lUjh4?=
 =?utf-8?B?SjBjK3JnYTVUV29pMnY2TDNpODl4RkwzVU1hR1V1OWNSNUhTSytpZGo2Wk5q?=
 =?utf-8?B?Nmx2TEExYUxTc3RpYTVaQ3Y0RkVnS3I2V0NRNTlVeStHM251NEtHcXpIWmlD?=
 =?utf-8?B?cE0wOC9lRUVmS29SZXl5L2ZPRURzSjM1LytnL3ZZakJFcHA0ak1PczQyMGI1?=
 =?utf-8?B?U3FBYk02VS8rOUJVWnIwQ2U5N0d1czMrcE5zc2hxdEUrMTNWNzA4dWFPb0ZS?=
 =?utf-8?B?dHh6azNjRGpYbktlUkxzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3lVU1orNXdmeTVaU1k3YWFWUHpZaDFsK1BwSXlIN3pPLzZ5VnhudWdyK1NO?=
 =?utf-8?B?QWRNNkhqRm5PVlZnZlF2RXpaNkYralJVL21mR1JPeWp2L2hRUG1QTVptZzcv?=
 =?utf-8?B?UjZPOHFXcjBJTjZmYU9nTVVNVllTbHdQcHRiZCtMWXJTNXgydlZEYk1xV1lq?=
 =?utf-8?B?V2laV2hGYXI4QjFLOXJIRjF2QWdtbjlsK2owVG5VaDFVczJ3NTIzZDcrY0Ex?=
 =?utf-8?B?ZEYwM2lSVTNXYTdnblloSlR2QmFBdHBzWlp0NXYrbitma052b1BqSFVvd25n?=
 =?utf-8?B?NnZCSWdSellneDhhN0Z4Z2J6Yk5rc1locGxqUzAzZjFZZUtVL0k0VFpLNDZU?=
 =?utf-8?B?eG5NdytGQ3FSbFRUUkZsYndabFRxL1k1YXV3M2k2TU9TbUxtSXI4TE5ESWVx?=
 =?utf-8?B?eHk1cTRwdU82TUhqM1ZqbW5XU2NwMGRyVjBBRDJpSm0weHpZNTBqT3IreEll?=
 =?utf-8?B?OXIrckdzUTJJYzNvL1p0Z3djTndEMXJ4QXUvL0pLMjFWQUhkcE9MSm9RdUt6?=
 =?utf-8?B?czNmZUJUOWhlMWhnZlk2ZUtRcUpkc2hlV2VsSldCRkhCcUdwb3Q5NVdtVmsv?=
 =?utf-8?B?TCt1cUhjUFBwRnZPNkFaczJvaGVwZ28xcUZvZi9ROFkwdkI4UXRuMVljd2Yw?=
 =?utf-8?B?MEJKS2doYVRUbzgyQlBMY09KN3VmQlJNUWwrNy9IMElYMXpudUJibnlFWHgr?=
 =?utf-8?B?eEpFeXcrdWZRbkR4V1FuZ2VMWmNTOFZ5RFFJWFd6OVgwV1hZUHFkWTFCVE1J?=
 =?utf-8?B?MVQzOXJiMDE1NUQwWEthY1dLMkcvdHlMT2VaUlFWRjQ0TnhmMWZOL0l4endl?=
 =?utf-8?B?a0lROXJHcnZaMEpKNG01S3Ryc0Z5VERlM2pVVFpPeDRKaytNU0MrVVByRUti?=
 =?utf-8?B?dGMvcG52ak5SeDJRcmJEWlVSTEUybUxKQ1RUUnVuWUUvUUd4MWFVQ0ErL3Yz?=
 =?utf-8?B?VmZFbDh2TWxTbmR6dU91RjU1SlV6ZU9YbXcwNmN0L0tmRGRBSzludmR4aSs3?=
 =?utf-8?B?RmxoOU1vSFgyc0hDMDBwM214WlFMVVFLdXg2OUpRajhwZndmODNPNXZPZ213?=
 =?utf-8?B?QSs2cGRxQ2toRFA5SS9ZQzFYMkNhbnBIQXl0RzYzQ1UxZHp5cW9MTnVDMzlr?=
 =?utf-8?B?eFFSTTVPSjZ5UGFmcUF4OXhHcE9XdTBhd014R0g4eGRmSWdNaHdxWEtzY1Zl?=
 =?utf-8?B?MTBUbk1PSTREeUhlUWt0c05HTlZyMG9BSGZlZHJWVEJwRzEvVWk4cnlhNjZC?=
 =?utf-8?B?c2FOazBVdXRjS3JHdytZUjJPV2tsTTFNV3lyVVBob25PZlRHeEJib3NzU1Bv?=
 =?utf-8?B?Z0RtVkxmekZ0QWoxc3NHTHQ4UDdlSnU4cDdpMGR6YVdmQUlCZnRRbTErbDhy?=
 =?utf-8?B?dDUrSy9lSzZUT25IOFpRSm9MVUZkT1JKR0E3NWR1TENjMkJVR24yaVRTK3Fp?=
 =?utf-8?B?dnRkamFscDh0bmhJMGprRkdsdVE1YU5xVDdoMDVoSlQ0bWJ2Rk5qK05MNHBp?=
 =?utf-8?B?a2hPelRWVVFxajNMQkZ4Q1BnY0VtdE44MXlxQXJiMW1QMjh6MmI4UHNyc2c5?=
 =?utf-8?B?TEl1R2UzbnpoQ3hYRFVtZnBWb1VPa016VUJZRjZtZzN3VXRXdGFRUHRlRnA4?=
 =?utf-8?B?cE91YkI2a2ZZZWlQcGU1YjVaaHZ5NVdWNXFrZW9udHhXcll2NjE4Z0dDZlpj?=
 =?utf-8?B?NU1rRDJVTzVIQk4xYTkwUkVOV3cxSUxwZTE4S0Z2aW5uRlNyL3N5K0tOQlR4?=
 =?utf-8?B?cVhSa25VZHRIK0I2VURyQlViR2Qzc1kzdmR4RnNVeUN4WlJYVStXZHpnQko4?=
 =?utf-8?B?ZEsyaUtWZk9rYjVldW85RGFlcnp1bEExelpKQ3pmQzlJMk9HM244eWNwQXU2?=
 =?utf-8?B?SjJUc0pGR3NMNWd4NzN4QXNxbjZvN3ViQkg1RUtLeS96QUVia0ozd3llME5v?=
 =?utf-8?B?Z01QUk9YWm9sQTNObmRNdzZPbHpKdDBRa3RsRXNnbmduUGdoWHdvK2ZKdEdU?=
 =?utf-8?B?K1VmaWYyb0czdUdVQkJRek9Kam9ObDRDWmJWNUlaa3Zub0luYXh2TkRRblBq?=
 =?utf-8?B?UTFLVkp5U0pMMWpKSGtIbVFLczdEYzE5MTBXSVBLM2lWOU1ucXJhUWxUc21I?=
 =?utf-8?Q?1140mVqzKdeLbL/rdTHVF5KSw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be38e6a9-e1db-4d9e-2abc-08dc9a7ae12f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 09:39:33.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3l1TrH7ktV25LxZiONKRC3RpgxPxMPXdEUTzaTy6zsB4BW4wbiVoVm0xa+prY7xgeRqiPccvZP1pgEx/vr3CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812

Hello Peter,

On 7/1/2024 6:29 PM, Peter Zijlstra wrote:
> On Mon, Jun 24, 2024 at 05:58:59AM +0000, Dhananjay Ugwekar wrote:
>  	
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index b985ca79cf97..73be25e1f4b4 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -103,6 +103,10 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
>>  	.event_str	= str,							\
>>  };
>>  
>> +#define rapl_pmu_is_pkg_scope()				\
>> +	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
>> +	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>> +
>>  struct rapl_pmu {
>>  	raw_spinlock_t		lock;
>>  	int			n_active;
>> @@ -140,9 +144,21 @@ static unsigned int rapl_cntr_mask;
>>  static u64 rapl_timer_ms;
>>  static struct perf_msr *rapl_msrs;
>>  
>> +static inline unsigned int get_rapl_pmu_idx(int cpu)
>> +{
>> +	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
>> +					 topology_logical_die_id(cpu);
>> +}
>> +
>> +static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
>> +{
>> +	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
>> +					 topology_die_cpumask(cpu);
>> +}
> 
> This wants a comment. The next time someone looks at this we're going to
> be confused.

Yes, will add a comment.

> 
>> @@ -677,6 +696,9 @@ static int __init init_rapl_pmus(void)
>>  {
>>  	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
>>  
>> +	if (rapl_pmu_is_pkg_scope())
>> +		nr_rapl_pmu = topology_max_packages();
>> +
> 
> How about:
> 
> 	int nr_rapl_pmu = topology_max_packages();
> 	if (!rapl_pmu_is_pkg_scope())
> 		nr_rapl_pmu *= topology_max_dies_per_package();
> 
> hmm?

Sure, I'm okay with this as well, will modify in next version.

Thanks,
Dhananjay

