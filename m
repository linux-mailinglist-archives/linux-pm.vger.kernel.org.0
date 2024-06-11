Return-Path: <linux-pm+bounces-8950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F312F903E86
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 16:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDFF3282CB2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 14:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0AE17C205;
	Tue, 11 Jun 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q06QeoQs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168DAD2C;
	Tue, 11 Jun 2024 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115449; cv=fail; b=ibedHpFQJP5s6zQixOhGVstaYuKkbVq/1Yn5mlc54pNrwBur5nN+Y8Y+Msx43SEHoII51T5ef8O6r01Z44EpX15fTquvQHEw0s5MpXE2ggO9B2S45SfvtvYkt88R1pseF/Q/Q6mKnp5u8K4RF9eJfOPj8w7EGrGZLczGNBcZPxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115449; c=relaxed/simple;
	bh=JOgC7J5GnAww0oesY37DRzpCuRC3CVaarX0gB/AFOps=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iB9zoEPptY52iOICXoqv3TMrAOuZA5V0vN8/2s03s9XIAxvr0y2kf7QgB3uweCfBO3fmKfQjZujGHTz1bQ85/dr8r4fJJBIrA19V7/gh2BGFsfA36Sy72yDH1Pta2kjmObUaPeEh6k+oQpVXo0m6C5xieIoxwSyvrHssQLsPmYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q06QeoQs; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EG6ZzmisjY0+VP9DDXVOAjLI2c9A2v6O5D4UU6AMYF2tSGKXU3Y5qJksYB5NBmZrPtuhic18T8kyS63rVyl2nZJlT8f417qyq4rr+1G11FVXSSuoXFbbe9ksmyTxVBk/Q2ElkDwf5umicmz9J77utrWC21U4JJmK/OlJuRo+395GTC395zihgt1pigoBMSTRiaRk4B1ukCyLtwfb3TUeOHIMfZR5uq5WYv01dGBQ6qMnEnuOtRZHyLzZF6vI5mh4x/Coy8afKdYe/TJu+Y38VeLor9YXU+t9NNvKJ5ztaSOQ4DqhsCJIE5ZsWY8hGbOcM6BzOGDABCg9leoV4Jp6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaZsXanyBt6U4ehOdaROFA8jR7dnf4W8bgVPD6oYIJo=;
 b=GrVwRgl0VbpBp7CrE8Ze+v7iOyTc/ppD6wY7QnMiaFs84MKmmHwsgPnP6v5GnzcAt0d80KH3MNQFmD5ZKg8jrPsnXsSU+2mCqwl1VZinoWcEKzgKrxIFsh9bnVosQUfF7w5GDFUb+LTlAz2qZaUzbARK4PwvYJdFNvm4A4N9jfdLQlIQpMmGVA/g9UviTAdC7Q9U8y4N8ENH9p8MNYgaJywgO9UIYpj+dkL/UMR16DkY1m8yhazKEozNrS2AViZnx3QGlWy4XN3ddlp9JurkmTSbBd53BKTPeXBKqvJUo6k24fEJ9oYuE1k3QOYVdrOYTdx/qUo47GNfSquNcEwXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaZsXanyBt6U4ehOdaROFA8jR7dnf4W8bgVPD6oYIJo=;
 b=q06QeoQsZviagd3LIGUfm7RvgirKoC2wCVe3JXxNRMiEUhcathjBlQ/jzcBJV0nDAd9Z39Wl12f/w2KMlQTSKP9ael645q7bRedL1zVCE4CFUnLh0JdaHvFm56XbXx8zc3+N6/k0+DUFWTAwF9VUkKut+MeuwULTREBf6CDi33k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 14:17:22 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 14:17:22 +0000
Message-ID: <cfd06af3-a950-400a-a858-1dd67b968e69@amd.com>
Date: Tue, 11 Jun 2024 19:47:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "irogers@google.com" <irogers@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de"
 <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>
Cc: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
 <20240610100751.4855-2-Dhananjay.Ugwekar@amd.com>
 <e1f70a09f85dbd0ee3f32dffea37993e141269d0.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <e1f70a09f85dbd0ee3f32dffea37993e141269d0.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::13) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 904bc36f-358a-4239-06fc-08dc8a2135ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|366007|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlNDdkcrbm40UVcvYU9rRjk1Ym8vaEhjZEI3WjFEREViWFRyaDQyTVJYd0k5?=
 =?utf-8?B?Zi9uSEwraDgvMmcwaCtLMCtWdTBnOW1oUGZnWlpjSDhSMDNxeFpmR3liT09T?=
 =?utf-8?B?aHd5WjkxN0xGQTR0ZzZUdkVhYjNaYTBleDNsZDdBRjlXUU9ydE1LM1J6eXgv?=
 =?utf-8?B?Z2todHJTdjhNN1IrWFRoM2doRzFIaElKa2xoVTE3YXNkZUN3OWZWOW5uTGkw?=
 =?utf-8?B?TnJOcm5MSXdkak1qV3Y0V1VPRkMxWmhRL1o2UkJnVEd4R3FSUXk0TWJEWWMv?=
 =?utf-8?B?Njh4WHU1WUpwTnN5ZGtaWUZwMFRDQmZkNHVBVmYwUmF0ZE1pYUZ6cU8wR1ZN?=
 =?utf-8?B?aVA3UXhzRnVTZzNudDdwbEhIdFpHR2s1M3IybGxvQkk0aURNWkZkanRvWllr?=
 =?utf-8?B?anVuQUh4M3lEa05aaXZ0RjBKTWZyYXk3ZHU0RHpzL01PUzZzbHJ1aE9udWI4?=
 =?utf-8?B?UEI0UlhlOHBRdHhiK3lyYTZCYUVkWFVtc1RlbjhkYmJ1QjNnc3oyTEVNYklv?=
 =?utf-8?B?MW1ZdlpYMml5bkMxTDcxemR3NllJbHZaL09UcUhINGtuNmpHVTN5d3J2Nzhi?=
 =?utf-8?B?Qk9BZHhidHI3ejZkVUpaT3hidEF1bjZSQjM4Uzh6ZEtzdkZaalRqNWdlZlM5?=
 =?utf-8?B?dXV2R2FtaTFKeGV2V0l3VXl4Y2N0L3B0L01CT2llNXlZdGlySlA1bi9ZSFA4?=
 =?utf-8?B?aVBsZmhZSW1pWG5UN1NkRWZ0aDU1enJ4SFI4ZUhMQzVQS0tiMVc2K2VkV21I?=
 =?utf-8?B?VGJjZkZPck9wTUx5TEFzWklPTEZTMmI4SmJaZjl5THJIWXlxN2Q0SWMzU1pC?=
 =?utf-8?B?NnRFUWYreDZlUlljNytGZlNQeTJXRUlsaEdNTStESEhyZGFPVVNsczJicGw4?=
 =?utf-8?B?UzU4cG5rMHhyUDFDU3RXdHkrSzJzSHVBMjY3a2htN0h0dGxtZC9jelFEVGlX?=
 =?utf-8?B?cWVTdHc5NUV5ZnU4eExhU0ZuR2JNdmRuR3F1b3U2ODNFcmQ4b1VjQ3B2SytT?=
 =?utf-8?B?NVVXYU1jNEFXT1FqRTZiQmx0aXNCUG5wbGQ5Z2w0Tis5b1ZPekFMOHA3Lzho?=
 =?utf-8?B?emlBR240ZWRBR3FoNEZtb3VHcmJRcSs0MTIzMGRyQm91SVp2eFZteFJ0aGo5?=
 =?utf-8?B?NGlHa3B4ZEpVRUQzc3d6OXBwVmJmQnNaSTZXeExDY1BYUi9WRUVsbGE2aGwx?=
 =?utf-8?B?L0NBRWszcUdZVkdrM2JzUklCWG8vOXZVR25saDJueVRzWmZiNmNFSGdMYTBt?=
 =?utf-8?B?OGVOVmdRMGVUbmt4ODBUM3p3RXNvcE5ab3RNV1UvRnBKWHdhaHNISUFkUVUz?=
 =?utf-8?B?NlI0UDJrNFdDY3l2Y0ppazd5bTQ0eGlxQWNYQjJLSGl5TERXRHdzdEtILzNk?=
 =?utf-8?B?My9zVFNQeUF2YUFQbzRSQW1lVmtMRVAzTWhkekIyQ0F5cmt1ZVpMU0Znb29l?=
 =?utf-8?B?bVFQdUNWa09hdk9BbHZsaVVhSmlYQVZVWXcyMWR2aDVjRnI5ZzhCWkg2Y2Vn?=
 =?utf-8?B?bU5DQVhqcjQ2elF5d0kwRnAvQ1U0T1NXaTZ5OERuS05LQU10bFBLbGhEQlJj?=
 =?utf-8?B?NHJneTVEVU9pV1hvRGM5WlZDOVBhVUFqK1hxK1lHMENqSmdnSzd3UW1nUklt?=
 =?utf-8?B?NmkyUWpTZHllVGhvZUtqQTR0RnVHRjQ4akRZYXZwKzVDTFJVMlpJTm4yNStl?=
 =?utf-8?B?d0l5cW50d3ZLcTYyU2Q4TjUvd3FYTHE1b3NvZ1oyMng1MHdnMXZFKzFwWVpI?=
 =?utf-8?B?V25LbVY0WWoyUDZZT1U1VHRTaFREcFpoRjNualRPNzZvMzRLVW02ZmpNbmxP?=
 =?utf-8?Q?rQfwFhc3mqBO/HlSRKCaG5qtBKg4KSU+ZGtEM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVROWElaUk5qYWpjQW1CZThYSTBGM28wUUY2dmJDS01jcEY0Smlyb3NBejc2?=
 =?utf-8?B?aXNwOGQyTld5TVJyQWtid3ZKd3gybHAvekprU2hiOGU2bVV6NVQ5bWZDbnV5?=
 =?utf-8?B?MjhheHVVNkZHZjJnd2J5Z3lJeStpYy84V0g4azVwVXcrSU5COXUzSGVLMUd1?=
 =?utf-8?B?WDRDb2IvQmxVUW1xSEZHUDZpSkg2cVFrUGdJWWRFOWNlblN4Tmh3SGdpMkYv?=
 =?utf-8?B?ZlRDZEgraXpiSGE3UVBEZ09WNjltUDZEWC83TVoxVlJHU1B5am1yV1dXN2FT?=
 =?utf-8?B?Zjg0Ym9KcFBHcXppVVJ2WFQ3c2FDNFl1YXVERVdocSt0M0FmR0wrMDQ3R05y?=
 =?utf-8?B?WXQwdm0wNXdkaXVuQi94akdkWWRqQys4MFBQWldlMngzWERoR2FyNVJuc2hh?=
 =?utf-8?B?enN4VHJxSXVvYWY4QVlhOW1XNmdNZ1R0Q2FaM29JMFFOTWtqeGJlM3VTMnNF?=
 =?utf-8?B?OUwrT1FQZHN3WVNMcGpLUnhqNjFtUElnT2xVSUJmUmlyem5jYTBDalBMZFRF?=
 =?utf-8?B?dENjL3Fib0orMFduTHI3RkRHL1FubS9LWjNrelI1SWZ2THNmZmpzZ2YrUkI3?=
 =?utf-8?B?aDJIR0dhRllBK2JsK2dlUXpKZFBJdjNVbUtPaFVsdnBwc0FlalhsWG1pcy9W?=
 =?utf-8?B?S3BneEVpclA0YTUvaWVwQVR0VjJnZS9Ec1J2NmFHM3lXOU5NcnplemRQbG1U?=
 =?utf-8?B?TDZDTCtyMjNVcGl2QWxrbjFiR25xbGFtUHpEd0dtV0hhNlZoT0U3WnByQS92?=
 =?utf-8?B?R0JmUC9MRVY1WHlhM01KSUdhN01PMHJnd3BxeC9jUjMzMWhHZ2ExdEVkQnFT?=
 =?utf-8?B?S29RQ0RDVUpSK3J3bWo2QkV4MVVlYytYQ0VyRkZHTjA5Mzk4U21QdEhnQWRn?=
 =?utf-8?B?MzFMRkFWZHRxR2VQZjlmVDRhK1BNenhEK0wvQjJpa3Z6Ykhua2ZPMVhxQnc2?=
 =?utf-8?B?ZUFKZzhXcWVWYk44SEJhZlUwWlNGaW9DNkdWMzNDTDFya01jWlNVallBODZX?=
 =?utf-8?B?dVVNUkpnYnRLbTBlcnp4ZlpwemlaeklDcWF4QTRkY25veldpRGhtQ1BaL3B5?=
 =?utf-8?B?ek9nK2tiYTFZOXZEaUNGN3VINE1HUU43cG9DMVJ6UUhGUFNEdzVvWWlPRG5N?=
 =?utf-8?B?b21rYi83VzFUb01aam1SR2dwcHl5d3ZqSkc2UGNBS0pBNEcxVHA3Vi81Z3N2?=
 =?utf-8?B?OExpNERrbldrbUdibmY3ekFPZW9NVXZKd2Jjb2QxcVU0aGZZdzY5aUpGKzZR?=
 =?utf-8?B?TlhCVUYwTE5PMGViTXZyLzB4c2xYN2EwV0FuSkZTREdsVlc2Nk1Ed2lTNit2?=
 =?utf-8?B?SW9tSzZLOTJzendJRlFJSkE0NGpBSmcraU9ZYWE1UVVuWXpQclJHZFBZbHov?=
 =?utf-8?B?dlM0c3JrR1FUMWxGdFFwR3NSdHVsUCtLUGo1MWNXajVMR204cDl0UnEzQzNL?=
 =?utf-8?B?dDlJdUdkSHNFNDJheXNBOFFxeXdPVEt5ZUtlZzBucG00QXJQZURTa3RJSmFz?=
 =?utf-8?B?MDlNSy91SjZTRUZZbVU2QVJPYWxOdjdzaWFJYVBoczJYTWFSREhjV0FKUS8v?=
 =?utf-8?B?RDZqZktKRml6bWU2M1ZkaFBlcHdhMXpmbXpXWnVKU2dHM0dtOGhBN3ZFOENE?=
 =?utf-8?B?NmJtTjVzRVZNOCsvT21BNlVrRTE2UzJBT3Z2R0FBcFRDZFM2aXhsSmFtcHIz?=
 =?utf-8?B?V2poNFMxZUFQUGZFTTJtQUhVZmVNb1lET25aaTI4OXhNMkRqeXhBT2lTRjZZ?=
 =?utf-8?B?Y2JPUEg3NUh6MlhCNGE2K2g4MjB5d1E5VWZic1RlaXEyNXErVFFielNPRHEx?=
 =?utf-8?B?RXNGSm93bzJIKzQ2bDB3U1ZwMThGeUg4OEk4NzB4NEpHcTAyYmNWQi9ldzF2?=
 =?utf-8?B?UmNsVUR5ZFVtOWRrZzRicDBJOTZqSElKZGVsSHpJRERiN2pUS2RnTElYdnls?=
 =?utf-8?B?ZUcyUDUrSytwb21mZEY5c1U3dnQ3cnp5bWxPZkRTV3g2eFJtVVJLd2psMENj?=
 =?utf-8?B?ZWJtYllqNyt6S1lReWhVeVVOKzZpR1UwS0Y1YU5jQnBJaXVhdHFRZUJHQVVl?=
 =?utf-8?B?cmpPRTJrWEEyeWJONGhvZDVGaEQ3bHVQd09zeVZnaDJlUVNvSXBwclY1RlFN?=
 =?utf-8?Q?wdYqiIdvfQsRwiQ09fKZYGZkn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904bc36f-358a-4239-06fc-08dc8a2135ee
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 14:17:22.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsEaVOTjMY8Ej0WbTklghXVP26wr56+80iuEIpeQ2x5mXpz+QcvN7IyX9K0OaT2UqHEgbJmgHBs5iebtPKVKjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422

Hello Rui,

On 6/11/2024 11:05 AM, Zhang, Rui wrote:
> On Mon, 2024-06-10 at 10:07 +0000, Dhananjay Ugwekar wrote:
>> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026
>> leaf"),
>> on AMD processors that support extended CPUID leaf 0x80000026, the
>> topology_die_cpumask() and topology_logical_die_id() macros, no
>> longer
>> return the package cpumask and package id, instead they return the
>> CCD
>> (Core Complex Die) mask and id respectively. This leads to the
>> energy-pkg
>> event scope to be modified to CCD instead of package.
>>
>> Replacing these macros with their package counterparts fixes the
>> energy-pkg event for AMD CPUs.
>>
>> However due to the difference between the scope of energy-pkg event
>> for
>> Intel and AMD CPUs,
> 
> Actually, on Intel platforms, the energy-pkg event is also package
> scope except one platform, and that one is the only multi-die system
> with RAPL MSRs available.
> So that is why the die/pkg logic was introduced in the first place.
> 
> I like the macro/helpers in this patch. The logic inside them may need
> to be optimized for Intel platforms, but that is a separate task.

Yes that is correct, however anyway the die macros return the package 
values on a single die system, so I preferred to use them for all Intel 
systems (single or multi-die). 

We can surely update the macro name or logic in future to make it more 
semantically correct.

Thanks for the review!

Regards,
Dhananjay

> 
>>  we have to replace these macros conditionally only for
>> AMD CPUs.
>>
>> On a 12 CCD 1 Package AMD Zen4 Genoa machine:
>>
>> Before:
>> $ cat /sys/devices/power/cpumask
>> 0,8,16,24,32,40,48,56,64,72,80,88.
>>
>> The expected cpumask here is supposed to be just "0", as it is a
>> package
>> scope event, only one CPU will be collecting the event for all the
>> CPUs in
>> the package.
>>
>> After:
>> $ cat /sys/devices/power/cpumask
>> 0
>>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD
>> 0x80000026 leaf")
> 
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> 
> thanks,
> rui
>> ---
>> PS: This patch was earlier sent separately(link below), it has not
>> been 
>> merged yet, it is necessary for this patchset to work properly, also
>> it 
>> fixes the pre-existing energy-pkg event.
>> https://lore.kernel.org/linux-perf-users/20240502095115.177713-1-Dhananjay.Ugwekar@amd.com/
>> ---
>>  arch/x86/events/rapl.c | 30 ++++++++++++++++++++++++++----
>>  1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index b985ca79cf97..73be25e1f4b4 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -103,6 +103,10 @@ static struct perf_pmu_events_attr
>> event_attr_##v = {                              \
>>         .event_str      =
>> str,                                                  \
>>  };
>>  
>> +#define rapl_pmu_is_pkg_scope()                                \
>> +       (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||  \
>> +        boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>> +
>>  struct rapl_pmu {
>>         raw_spinlock_t          lock;
>>         int                     n_active;
>> @@ -140,9 +144,21 @@ static unsigned int rapl_cntr_mask;
>>  static u64 rapl_timer_ms;
>>  static struct perf_msr *rapl_msrs;
>>  
>> +static inline unsigned int get_rapl_pmu_idx(int cpu)
>> +{
>> +       return rapl_pmu_is_pkg_scope() ?
>> topology_logical_package_id(cpu) :
>> +                                       
>> topology_logical_die_id(cpu);
>> +}
>> +
>> +static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
>> +{
>> +       return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
>> +                                        topology_die_cpumask(cpu);
>> +}
>> +
>>  static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
>>  {
>> -       unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
>> +       unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>>  
>>         /*
>>          * The unsigned check also catches the '-1' return value for
>> non
>> @@ -543,6 +559,7 @@ static struct perf_msr amd_rapl_msrs[] = {
>>  
>>  static int rapl_cpu_offline(unsigned int cpu)
>>  {
>> +       const struct cpumask *rapl_pmu_cpumask =
>> get_rapl_pmu_cpumask(cpu);
>>         struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
>>         int target;
>>  
>> @@ -552,7 +569,7 @@ static int rapl_cpu_offline(unsigned int cpu)
>>  
>>         pmu->cpu = -1;
>>         /* Find a new cpu to collect rapl events */
>> -       target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
>> +       target = cpumask_any_but(rapl_pmu_cpumask, cpu);
>>  
>>         /* Migrate rapl events to the new target */
>>         if (target < nr_cpu_ids) {
>> @@ -565,6 +582,8 @@ static int rapl_cpu_offline(unsigned int cpu)
>>  
>>  static int rapl_cpu_online(unsigned int cpu)
>>  {
>> +       unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>> +       const struct cpumask *rapl_pmu_cpumask =
>> get_rapl_pmu_cpumask(cpu);
>>         struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
>>         int target;
>>  
>> @@ -579,14 +598,14 @@ static int rapl_cpu_online(unsigned int cpu)
>>                 pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
>>                 rapl_hrtimer_init(pmu);
>>  
>> -               rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
>> +               rapl_pmus->pmus[rapl_pmu_idx] = pmu;
>>         }
>>  
>>         /*
>>          * Check if there is an online cpu in the package which
>> collects rapl
>>          * events already.
>>          */
>> -       target = cpumask_any_and(&rapl_cpu_mask,
>> topology_die_cpumask(cpu));
>> +       target = cpumask_any_and(&rapl_cpu_mask, rapl_pmu_cpumask);
>>         if (target < nr_cpu_ids)
>>                 return 0;
>>  
>> @@ -677,6 +696,9 @@ static int __init init_rapl_pmus(void)
>>  {
>>         int nr_rapl_pmu = topology_max_packages() *
>> topology_max_dies_per_package();
>>  
>> +       if (rapl_pmu_is_pkg_scope())
>> +               nr_rapl_pmu = topology_max_packages();
>> +
>>         rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus,
>> nr_rapl_pmu), GFP_KERNEL);
>>         if (!rapl_pmus)
>>                 return -ENOMEM;
> 

