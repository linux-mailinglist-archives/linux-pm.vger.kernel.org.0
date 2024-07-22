Return-Path: <linux-pm+bounces-11298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D597939044
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 16:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD25282036
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AD41DFE3;
	Mon, 22 Jul 2024 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AfSFUfPY"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE88F5E;
	Mon, 22 Jul 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656937; cv=fail; b=a1Kk3I9Azmq6c6PVPklvOKspVlNLgnfs9c16czlm0zQRYSmDZ72rJbSymLJweKMCp6iGCsPnghBT+xtYoy63lxs/oH6dV6bnQz3A82P7ZwfCo7+s1ZLL/LDmk7y+736amY6bumexfraLak8Ji64UPz0Af19Y2SAh402Nmjm/cyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656937; c=relaxed/simple;
	bh=qbauPOHAkhoVO/OR3c5fPIBc0vf/cJZ8+zcL9upIDX4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L7zP1Dht+pwJMTUsZq6GxaoHs5jahqPybMcFFSPWC9KVhpPFVdTe58H1c0955JfIS0EOgMoUfAl6wSXeCj0iYHmbjmwdonbKadbUaAISjtwo7bMDHC5p1gIn7b6C94KqCI0y6QpZUVyaY6mOORSfVLx0N2oTvibsvPStGqqZJFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AfSFUfPY; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7JncyHyh1R08uDvpqbmRYC04zlOPDHteg8CN4KbnaLmDkFlsyh1Do/HPoL/Fxil0RXoDlqfeOTBbYfZLxsD5TlHW73rQq5xviANc3KptzD1zdSYlOVYev/1Wd6iCBio2U8uz0beFxLuoAYQAtV5wrUQZcW0nnthfK1hAiP8zaqMKw/7orMl0Tno6u9aM0thCxB62jK4gyJH13xxIxttp/BKCwAFmtEoSlHHuMxcajBblnX1YA0KyTN890c7sE73WfdhM5yeztukrTByCrtx//BPcNHPm0r93m4CUMvYZ8ZK7EdOE96h7oycnvZhxIWixgluC/KBbmMm3snkYhGpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsCgzul0Re+UU/S/XEVjW0T05E6OqxMO0VdgMcaF+Lo=;
 b=x4fBmwCVfjG2m/NcvmH6ebI/u21YAmvdV92wemUk7VjDr1i+zk0ZmRVAAA4jjVALaOuBT0Hb9VV7ZzbkiRzaBMo7jabjPJ94M9h1wjJ9MYY//qvqJWQCb08q61QuCL3EStCFZI6cDeSrmxN39Z8CHw0ssbkRUdxdSwfIxJNdTsLEAZIyViCsvXNvLRVuOqpEP0Bs8nVdu45TOSah+GSYyKeKJjNvUley13qtpyS8h4hQBsEXYEVYFvYWYwOKI3vyfI7spIakEyr8Lltgb1BzeiFsLOgxM2RQkNNuWomQMewX420zMrlDc36Gj+iqaQefsEv+WUn5rvw/otigC10slQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsCgzul0Re+UU/S/XEVjW0T05E6OqxMO0VdgMcaF+Lo=;
 b=AfSFUfPYIwKT3g8o6Kh3oTrrP8g+KyfEQc+pJDnBwtAz9CXUSLJAVpSk5uxsiVK48Cp0EEDC5O8khPegGYKQwbLA/S7Wboz0XlZzITgi7uMBgn0txbVvuVy8o4QYTmeGeB3HffrgIi3tbUOoHYIdPGqzw1+ZcKlWhaSBKKNjrko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Mon, 22 Jul
 2024 14:02:10 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%5]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 14:02:08 +0000
Message-ID: <32281529-316c-4927-8344-945df1af56d7@amd.com>
Date: Mon, 22 Jul 2024 19:31:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] powercap/intel_rapl: Fix the energy-pkg event for AMD
 CPUs
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "irogers@google.com" <irogers@google.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org"
 <peterz@infradead.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "acme@kernel.org" <acme@kernel.org>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>
Cc: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Larabel, Michael" <michael@michaellarabel.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "ananth.narayan@amd.com" <ananth.narayan@amd.com>
References: <20240719092545.50441-1-Dhananjay.Ugwekar@amd.com>
 <20240719092545.50441-3-Dhananjay.Ugwekar@amd.com>
 <2a81f438306b82620bb4db9065d2cbf3e4c2d56c.camel@intel.com>
 <9c492669-d97b-4040-bdcf-e7f5a5ac7e09@amd.com>
 <77ea13bb319d6408ff262b10ed744c2e80c5fe24.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <77ea13bb319d6408ff262b10ed744c2e80c5fe24.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PEPF000067F9.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::30) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe0305c-9a12-4319-9a5a-08dcaa56e01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGhpSGVVRGlnd0tmdFJJMXFaclFqMTNYNURTU0JjRWJTTEFZWHNCYmdrNHBa?=
 =?utf-8?B?WHZjVFFRZ2VYYzIxWUljd0dPUUNPK0FhWDV1OU9YMWNKNWdnZ2dJSUNQSGJW?=
 =?utf-8?B?UkhxMmluSWg1OHNXWUtXMEUxOUthOS9kcGdzUXlMeTVsWUF3ZDZoM2o2K09z?=
 =?utf-8?B?ajdqeUV6NUN5TUNlM1dFZkhpYjgzcHZTbGh1dlRzUFRVdzRYR05qRlIwcjdz?=
 =?utf-8?B?ZU13UTd1QnBGOVRacUJHOW5iQTJEQ25IdWI3SDJwbDd5ODhwVk9lQ1M1MUZq?=
 =?utf-8?B?VDdiNWJZY0N2SVNMbkNnL3lWajkwdUo2M1FJbFl2TVdVSzdvWnJJRUJmZ21v?=
 =?utf-8?B?S0tnT0hqUklsc3pJbzJkcmJtQWZ4SERaTE00d2UyVzR3NjVLRUt4V1ppNC9s?=
 =?utf-8?B?eDBoWWJYNGxZaklScXhkdjYrSkoyMVlMM2VGZnl2YzBxZjN3cnRURmx3T2pr?=
 =?utf-8?B?cituUkU5dDU5Y2c4NFM2Y3pET1Q0RDRTdSs0QXRDUUdGMEJLa3FkU29UTitU?=
 =?utf-8?B?Y1R3VHpYby9OSWhEZXJyUndPNG92dEpYbE82VHRaQzNZdTVDMzNCZE9kMkVo?=
 =?utf-8?B?NGNjcjF2TlVqRGxQTVhDWDhTamVpa2p3dnhObklsYTk5SGpBalJhdXpwc0pL?=
 =?utf-8?B?TlFyWi8xbmV5RG5OdWpEdHJuamZuRXQvQytnbi9vaTVOVGw4Q0YzaXRmZVYy?=
 =?utf-8?B?K1dUM0swQkRpdUowcWV3NHVsM3RmUTFEbHdDNWU5bUJJWmEza0d3YlpXOCtM?=
 =?utf-8?B?SWxxczRROGl1ZFN6ZElhZ3M2UGRnUjZwcUJoT0hnNnkxeE5YcDM4aTF0Z2ZQ?=
 =?utf-8?B?VUN5dEN3OElyOGNsVlZiWEJad3ZSL0hSSUk3cllneWx1UHdZTmJOK2x3Z0xI?=
 =?utf-8?B?UDdaOXFXaU1XNmhxU1J0RkM4NVVLc3lwOXEvU3VkOWdnaGxmZUYwdnBCZmZp?=
 =?utf-8?B?L0ZEZkR2dnhKZHMvVCtYVlBybTVYRXhMaFR0UHdqcEpjMW9DbThId0wydnRi?=
 =?utf-8?B?c21xcForVnljV0RmSlJrSm04cUtDYTlsaThuLzBqbnlnUVJuQ1VBTTNXY2FM?=
 =?utf-8?B?eW1TZWg3V3ZzNjVWNXFRZWxvV0kwR2MxK1VYV2tTN1R2VDNOQ0x2UVM0VVc0?=
 =?utf-8?B?OTQzbWM4RDF6ZlJiQmxYbm1pUzBNdTRtL3VvYW9kaFI0T3RTQ2FKRXNEUUcx?=
 =?utf-8?B?UUNiQmhiOXp0NHVOZ0tZaHRiMGtRTXpOMWdtUFZrN254MndXclRST1d3RWlE?=
 =?utf-8?B?blBCRUF4elF2UnZ4Uys1SThvNXFvRkQxRGdBOWEzbUd1WEtWbFVyNUtGZ3NQ?=
 =?utf-8?B?SjdpTEN1cjVCSFB4NHg1cm84Nllpc1ZxNGtoWGdWbGZwR00zMGFkOEJvWE9O?=
 =?utf-8?B?MTJMM0M3S09xWkV5SmFmM090emRqVDVvc21HVFYxbHB4bnRkK21WKzVLWmUz?=
 =?utf-8?B?bjFhS0ZHMFZmZ1BzbksvYjZsbWdCV2pSY3dPUWZFMWJXcGJSSkJiL3puZGhO?=
 =?utf-8?B?eDVjcC82alJ5UFliaXZ3MXI4S1plVEpycWtvV2N2ZlR4cWVFYVRMSXA0WVBY?=
 =?utf-8?B?Zjk5ZTFyaXZ1YjE0UVhnUDR1NWpUSGc4c21saWlnSlp5NnM0T3NHbU05d1U1?=
 =?utf-8?B?YkJiS3Zac0tmNWs0OGlGNUgrdVpMcVd4ZkVJMEo1YWtyQ05BcXRtR2FGT0Jm?=
 =?utf-8?B?dDRQMUFweTBoTWI1c254cm1lUUtHK0ZxektkWmpoMlpWbDV5YWhTbGUyc0R2?=
 =?utf-8?B?N1VQL1d1UDRwbUttelo3ak0xVXRLZi9rcnA1VldZMmRIOWpLaFo5OUdscmtv?=
 =?utf-8?B?V1RCeUdTN3dWQ2QwNlcvV2JlMm1OVGt4VWlUSDBhU2JYUnR6TEZJOGVTekVF?=
 =?utf-8?Q?cAhmaU3MXKmvX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STA2dS9yQWtZNFgwRzNTcjBVVC81OFo1U0Z2NFlPUWlIM3dHcVNmRGh6QnR4?=
 =?utf-8?B?V2RLRTFsZmwwL3JuVVBqdzlLKzFNL0pVUTNiWGJHUU9jSElqRFd0UWl4OUpD?=
 =?utf-8?B?cW1PdTRjdTFWVS9PZm82a1JTYVhRZkNJb2pWQ2dqbk9lTzd3eEhrU1FNR1BU?=
 =?utf-8?B?Y1YyMzFNMDlkMWFxajhicGdoMVh3QTlVOFZmTkxNbkFKRzRoSTR2dU5zcmsv?=
 =?utf-8?B?UG1lajJZSmdMUmd0NC9DUC9LN29WbWZsVDZzRk0xZHlQMG8wY05lcEkrNzBV?=
 =?utf-8?B?cGhOK094RjAzVUkrVzNCUEV6Yjk3TEpZbWtvTzdxWXhuaU53VFNzTFZLTWN1?=
 =?utf-8?B?YnpBNTRSWFlhdVRlR1NqUlZmQ2d5N2Q0V3FjKytjYlFDN2FOb2poZmhFWnBT?=
 =?utf-8?B?MFhlSVRVWTcraUR3UmNwMUVLLzZYeThrckd5MndNUkNOK1N0NTIxdFk3SWY0?=
 =?utf-8?B?RWM3U3hJa3dvWTNvZlo1V3NLeDFFanNZNDRFUFZ6enkxMFBVa0xORkZoRkFo?=
 =?utf-8?B?TStsY0pDUkVrL1YzZW85NWdpSUNrVytCWjdFdlpaK2xUbld4MkVxM2dyNEE4?=
 =?utf-8?B?TmwwNWVkaTJIWE1wN3BJNTRtTXdQRVh0aHNpZkQxNnZzQ2ZhdjE3ZHlqSFRW?=
 =?utf-8?B?QlJCelJCK2dYMDJCdU5TNmh0dituZnZvOHlQSlBHTENpcmNNUExUdDBTWXVE?=
 =?utf-8?B?SDNQdU9qTHJpemI3Tm5JalpsOVpWTVJTSzRyVjA2ZHJnY2ZSWUxSOWJ1alBs?=
 =?utf-8?B?Zm1Iak9DWExIVDFpbitMQnRsblNhYlNJK1RJQTE5emlHby95dzMvRG9Vb3FV?=
 =?utf-8?B?QXcrVWJVcExPU1JIVE05OEZwU2hQRXlwWUJzUWNUdXVLZzRRZFlSeUtzSzJ1?=
 =?utf-8?B?Z1I2WGRCN216NTZPT2tnNDFFL1NmSGwrTW95UFFnSUU5RTd1d1A1L3lvWldL?=
 =?utf-8?B?MklJMFNLZlhzQ2FHTFBaYWFVTndYZWNzbFpZdnVXRGtMZ213VnYzbnMzNFZH?=
 =?utf-8?B?SURoM3FPMXpkRzNldTBmVDV5VHRWN1JSMXlkdW82a3MzdDRQYnNYNkpjTDdu?=
 =?utf-8?B?STlLMW9qZTZOWk51VmZzdm5OUXpnMjMrRm1ha21oSG1TVEVkaUcrbURLSmph?=
 =?utf-8?B?bGJKbmFiWFZyTUhucmtwVFJ6SjMxYXNCSmZNV2NLQXlVaWZoY3owUHVTMjZv?=
 =?utf-8?B?cG9VNnM3MXpvOHdERHQvNGRXMGkzWVB1NlRkUkRJNGtybWVSckh0bXJyMGlC?=
 =?utf-8?B?amFjc3JaM0pqeWE2Q1lSM0JEVE1WT0NCODlXNGVhdG02T2F2QllIemJUM3pi?=
 =?utf-8?B?cG9WdFpGd0gvek5kek5zUU0rSEFTRkR6aW9Sc2hhM0lPSVBoNHZSRkE5RDBB?=
 =?utf-8?B?ek1ualhJVmo0N2owNXBvWjFHeCtaWTRiRGVtaUZnU05QVHhyZEQzdFRkWmNS?=
 =?utf-8?B?anFxVkFUUGtwQmNDQ2svTWFDTkE5ZTBvWDVuK09KS29vZitoQXByaVM5RzM5?=
 =?utf-8?B?dCtENVV3TVpPd3Y4dmZhbzhFUHJ6Z0o5S3FmNjI3aHltd2JRSHU1RURCVENQ?=
 =?utf-8?B?MFp5dm1TL0xnQ3VJd0NzK3k0clVuU29xcVZHYW9RaXNjYk10L3djYzcybkhj?=
 =?utf-8?B?ZHNYSUJxK3hFalVHODhDVUtzUHNkRmNJdXNUei9aUGltSndoU3RoN2lMZmd0?=
 =?utf-8?B?eGZ5MW84K29UMHpoZmpLVFBWa1BNUEt2L29hWGVHN0VneWhSdVhPQ3U1ZzdV?=
 =?utf-8?B?YVVYMHl2dG5oVTJ2NFdtdDlIeXZ6dE9maW8weDB3NEwvdHcwSTdPMTdDWFNq?=
 =?utf-8?B?cEtSTUN1NTBXZ1hpS1hpYUN3R3RmVktGZFZUK0kyVStqM3dGbWtPUW1DQjRz?=
 =?utf-8?B?NkFVS3E2TmRMd3puV3VFQy9rWW1rZlJLVU5KN2FJSVJhQnZBTjNXaFdzRjRm?=
 =?utf-8?B?bUhsOHlZdWpCMGVZSTQzcWJHVUNSc3hlNjUzd0paT3I5cHE5VHAxckk1UHl3?=
 =?utf-8?B?MlNKQkt0b1N6ZUpkQ0RsdWwrdjM5ZmVQejkvVUNJWC91c1ZUeHpkbUVGM25S?=
 =?utf-8?B?Wnp2OTJpSUl0SWtSZWp4aWtBa0dHQ3pCQVFKQ1VlVmd6UDlRbjNJbGJXS3dh?=
 =?utf-8?Q?B2DO8Geh2GFhTWXpCDeX6uhOo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe0305c-9a12-4319-9a5a-08dcaa56e01e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 14:02:08.6688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCWsFS7H5WV1QAMwyRHTiyB+HD7ApZcsnGydy/MLcVgck0Wk/0dAecClM6zDe8MrlFReRgXz1U+qCu/BkDWW4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938



On 7/22/2024 7:22 PM, Zhang, Rui wrote:
> On Mon, 2024-07-22 at 13:54 +0530, Dhananjay Ugwekar wrote:
>> Hi Rui,
>>
>> On 7/21/2024 7:47 PM, Zhang, Rui wrote:
>>> On Fri, 2024-07-19 at 09:25 +0000, Dhananjay Ugwekar wrote:
>>>> After commit ("x86/cpu/topology: Add support for the AMD
>>>> 0x80000026
>>>> leaf"),
>>>> on AMD processors that support extended CPUID leaf 0x80000026,
>>>> the
>>>> topology_logical_die_id() macros, no longer returns package id,
>>>> instead it
>>>> returns the CCD (Core Complex Die) id. This leads to the energy-
>>>> pkg
>>>> event scope to be modified to CCD instead of package.
>>>>
>>>> For more historical context, please refer to commit 32fb480e0a2c
>>>> ("powercap/intel_rapl: Support multi-die/package"), which
>>>> initially
>>>> changed
>>>> the RAPL scope from package to die for all systems, as Intel
>>>> systems
>>>> with Die enumeration have RAPL scope as die, and those without
>>>> die
>>>> enumeration are not affected. So, all systems(Intel, AMD, Hygon),
>>>> worked
>>>> correctly with topology_logical_die_id() until recently, but this
>>>> changed
>>>> after the "0x80000026 leaf" commit mentioned above.
>>>>
>>>> Replacing topology_logical_die_id() with
>>>> topology_physical_package_id()
>>>> conditionally only for AMD and Hygon fixes the energy-pkg event.
>>>>
>>>> On an AMD 2 socket 8 CCD Zen5 server:
>>>>
>>>> Before:
>>>>
>>>> linux$ ls /sys/class/powercap/
>>>> intel-rapl      intel-rapl:1:0  intel-rapl:3:0  intel-rapl:5:0
>>>> intel-rapl:7:0  intel-rapl:9:0  intel-rapl:b:0  intel-rapl:d:0
>>>> intel-rapl:f:0  intel-rapl:0    intel-rapl:2    intel-rapl:4
>>>> intel-rapl:6    intel-rapl:8    intel-rapl:a    intel-rapl:c
>>>> intel-rapl:e    intel-rapl:0:0  intel-rapl:2:0  intel-rapl:4:0
>>>> intel-rapl:6:0  intel-rapl:8:0  intel-rapl:a:0  intel-rapl:c:0
>>>> intel-rapl:e:0  intel-rapl:1    intel-rapl:3    intel-rapl:5
>>>> intel-rapl:7    intel-rapl:9    intel-rapl:b    intel-rapl:d
>>>> intel-rapl:f
>>>>
>>>> After:
>>>>
>>>> linux$ ls /sys/class/powercap/
>>>> intel-rapl  intel-rapl:0  intel-rapl:0:0  intel-rapl:1  intel-
>>>> rapl:1:0
>>>>
>>>> Only one sysfs entry per-event per-package is created after this
>>>> change.
>>>>
>>>> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD
>>>> 0x80000026 leaf")
>>>> Reported-by: Michael Larabel <michael@michaellarabel.com>
>>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>>
>>> For the future Intel multi-die system that I know, it still has
>>> package-scope RAPL, but this is done with TPMI RAPL interface.
>>>
>>> The TPMI RAPL driver invokes these APIs with "id == pkg_id" and
>>> "id_is_cpu == false", so no need to make rapl_pmu_is_pkg_scope()
>>> returns true for those Intel systems.
>>
>> This seems like an important point, would you be okay with it, if I
>> include
>> this info in the commit log in v2 along with you rb tag?
> 
> Yes.
> 
> This reminds me that we can rephrase the comment for
> rapl_pmu_is_pkg_scope() a bit, something including below points,
> 1. AMD/HYGON platforms use per-PKG Package energy counter
> 2. For Intel platforms
>    2.1 CLX-AP platform has per-DIE Package energy counter
>    2.2 other platforms that uses MSR RAPL are single die systems so the
> Package energy counter are per-PKG/per-DIE
>    2.3 new platforms that use TPMI RAPL doesn't care about the scope
> because they are not MSR/CPU based.
> 
> what do you think?

Agreed, this gives a more clear picture of the all the RAPL scopes.

We will need the above comment in the first patch as well, apart from the 2.3 point.

Also, regarding perf/x86/rapl driver(patch 1), will you be sending a patch
to conditionally set the rapl scope to die for CLK-AP platform(on top of this fix),
or should I fix it in this patch 1 itself?

Thanks,
Dhananjay

> 
> thanks,
> rui
>>
>> Thanks for the review.
>>
>> Regards,
>> Dhananjay
>>
>>>
>>> The patch LGTM.
>>>
>>> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
>>>
>>> thanks,
>>> rui
>>>> ---
>>>>  drivers/powercap/intel_rapl_common.c | 20 +++++++++++++++++---
>>>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/powercap/intel_rapl_common.c
>>>> b/drivers/powercap/intel_rapl_common.c
>>>> index 3cffa6c79538..2f24ca764408 100644
>>>> --- a/drivers/powercap/intel_rapl_common.c
>>>> +++ b/drivers/powercap/intel_rapl_common.c
>>>> @@ -2128,6 +2128,18 @@ void rapl_remove_package(struct
>>>> rapl_package
>>>> *rp)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(rapl_remove_package);
>>>>  
>>>> +/*
>>>> + * Intel systems that enumerate DIE domain have RAPL domains
>>>> implemented
>>>> + * per-die, however, the same is not true for AMD and Hygon
>>>> processors
>>>> + * where RAPL domains for PKG energy are in-fact per-PKG. Since
>>>> + * logical_die_id is same as logical_package_id in absence of
>>>> DIE
>>>> + * enumeration, use topology_logical_die_id() on Intel systems
>>>> and
>>>> + * topology_logical_package_id() on AMD and Hygon systems.
>>>> + */
>>>> +#define rapl_pmu_is_pkg_scope()                                \
>>>> +       (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||  \
>>>> +        boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>>>> +
>>>>  /* caller to ensure CPU hotplug lock is held */
>>>>  struct rapl_package *rapl_find_package_domain_cpuslocked(int id,
>>>> struct rapl_if_priv *priv,
>>>>                                                          bool
>>>> id_is_cpu)
>>>> @@ -2136,7 +2148,8 @@ struct rapl_package
>>>> *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_
>>>>         int uid;
>>>>  
>>>>         if (id_is_cpu)
>>>> -               uid = topology_logical_die_id(id);
>>>> +               uid = rapl_pmu_is_pkg_scope() ?
>>>> +                     topology_physical_package_id(id) :
>>>> topology_logical_die_id(id);
>>>>         else
>>>>                 uid = id;
>>>>  
>>>> @@ -2168,9 +2181,10 @@ struct rapl_package
>>>> *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *pr
>>>>                 return ERR_PTR(-ENOMEM);
>>>>  
>>>>         if (id_is_cpu) {
>>>> -               rp->id = topology_logical_die_id(id);
>>>> +               rp->id = rapl_pmu_is_pkg_scope() ?
>>>> +                        topology_physical_package_id(id) :
>>>> topology_logical_die_id(id);
>>>>                 rp->lead_cpu = id;
>>>> -               if (topology_max_dies_per_package() > 1)
>>>> +               if (!rapl_pmu_is_pkg_scope() &&
>>>> topology_max_dies_per_package() > 1)
>>>>                         snprintf(rp->name,
>>>> PACKAGE_DOMAIN_NAME_LENGTH, "package-%d-die-%d",
>>>>                                 
>>>> topology_physical_package_id(id),
>>>> topology_die_id(id));
>>>>                 else
>>>
> 

