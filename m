Return-Path: <linux-pm+bounces-10058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2929185E8
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 17:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCF91C215E0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FD718A95F;
	Wed, 26 Jun 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QpwFqRYq"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C66FBEF;
	Wed, 26 Jun 2024 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416067; cv=fail; b=AD6Aw50UIwvPkF8/sHqZvHbqmo54nYjmeThKr7+OfmbfbGL1AqkI/Y82ApQtMkk0WcpRbQmNl65AR740AzazJ1XQqq9Dv2rP10cQx0jzQuHpSHFhCArkyyn+edU37XI9SwYpX36EQzhvbQpvTjryWl5/JGy9NXUPtp1FWrLqPR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416067; c=relaxed/simple;
	bh=vicc1mxpgWO5QYLBhNXT8QYYKRup2yAu3Uu44SCbi1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gZi0+rAmjKBSWiv17UKM/kd02JAjFm2kmn8bmVlWCkVtR3lxuDm33J5JIr/XUOuFVB3uP3gscN5wjVnGZIH69+zukr1yr+T16qFKEwAbZiDudAs9akPO2DPB0z6UCkVKIfCi4SUMnSF6XmOkFD5b8YCjQmAPWjUaEFooeqg6+o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QpwFqRYq; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjS/nSQMvBuAXq4rQb2SDNtec0yHhp2Dxwjc51CP3V1yt+nG4v3aESbpvR4jxSoBOWkvAcD32IpDep2tLW/jc43WlcCiSBLUfaJNWlhU0SLn9R8xMofKmaly19mE2U4F2OEAfRW4WFOwewgSfEBaPeA5mU04+RL7O6X/hSesMNXO1jffgsSRY/ipyBT3hlTqcizoLhmfkpWYlAmAmoU+eqNwled1FrYN4w7oDSzs0avcQgSIvEeya9zpLMlZhRdGiysbv5L23aQOxsnoo7XevQMxKfuBXUdFcqst/QX1mouZfynYTn0fJ+FXxw8XHCJf8wsKgiEEhr2p57rmeo8T8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GPLbhsLvbpCYTuwYfRw1vE5qDo5W2kVSUjwFu1RRu0=;
 b=l+po3zQFyt7ezPd/xfx8Rk/uD/H5GEHHhMVC9kr3T9NtTgPfeJb1NlDURFfhV7gTschDi+ekuFm+ULWs+mY3IjRICIIB5lCvaOc6G+XCT4HpwgNMaPS7oRKkA2ZcXxSz0QbahXLjvH9sCGmC0Y9MS8U8dX5EdZnB3ZQ3qdLmLiUfJ+2PV0BPNvpCkN3KTvDrKNaE8Ppre2tLd3ubfxphpattiUxIdiQOYxvNicWdvto1WgP6cNSHA83TsU7w2IJQFNWiO1aJ7R0bN4cmFvo/mTkEAnlB0qgFRWXbNyrZ5Xkvg9Ie6GCPOdwGT4nqJ395dIqdDIwWmztEXl39eolAlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GPLbhsLvbpCYTuwYfRw1vE5qDo5W2kVSUjwFu1RRu0=;
 b=QpwFqRYq+RFVI1nJDKTenuVR6ldT+bNRzopT9Fr7N9xB/6mPnNA5kPZvY2EIWmzd8uLuXYMJp8+ZCV+MbS+lN3HAwwrhc2YsWXn02ZaMWnrMeBpo2MqFFULeEfkO5qkm3sDMn/0xfbhcmweO/xxxRYozR/LCgH3idkroPEsYRp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 15:34:22 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 15:34:22 +0000
Message-ID: <29c857ff-264c-4f0d-942a-18ea21c2a4f3@amd.com>
Date: Wed, 26 Jun 2024 21:04:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] perf/x86/rapl: Fix the energy-pkg event for AMD
 CPUs
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
 "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
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
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
 <20240624055907.7720-3-Dhananjay.Ugwekar@amd.com>
 <2003fe3c97132e528cb738e6f81f7a3a004fbf77.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <2003fe3c97132e528cb738e6f81f7a3a004fbf77.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::20) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9ad3bb-d977-4a69-be59-08dc95f5739f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|7416012|376012|1800799022|366014|921018;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVZzSnpybXhqOUhSaTlnTEhCRis1UlB6K0VQUGsydEZWR2VzeXhJelh5OEJM?=
 =?utf-8?B?d3l1QmxCZElhVWlSNW1yN3dNc0JITzMwTGR3QUtaUm96QWVRMUdZdTB0aEV1?=
 =?utf-8?B?OXRLTzFyT21INVQwMEY4OWY3OUdMZXVSdkFwYzlnbVptY1AxMTZSaGVQREk2?=
 =?utf-8?B?WmZmRWcrN2dpSEJTZDk5OUxpQlFMWkR5ekN3TTVuWk5xQ1lETytueUxsc1Ir?=
 =?utf-8?B?d0s1aEZQZTJiTlkzbmRyQ2hYdU9iczlXY3M5QXdJaVJ5VjNGRXNJdWFBcGFQ?=
 =?utf-8?B?SzdoUUxLZkx3bWdYYWo3VGd3d1JySitzcjFGVkRiRUhwTkt4a0xyUFVoYVBS?=
 =?utf-8?B?cEtrZXQ0NE5UNkUyeFJicFpiZ1ZtaDc0Mm1tNlAvMzE3MmlLTkdDaVNkcStn?=
 =?utf-8?B?V0J4ZGc0MWNHVmtxaWZVK2VWR0tyb0dsU0ovbUM0emNUQ2xsemVFSUUrRVND?=
 =?utf-8?B?OTZkcnZ1dnRXV3hTd2V0UGI3UkhzQStLUUNmQnUwYTdKV0RuMXgrVG91c3Fi?=
 =?utf-8?B?NGk1K0xpMVdpTHA2NU80dFlhWjQ1bW1zT3F4ck9JbEhCb0xiTCtGaUQ0OG9M?=
 =?utf-8?B?enF4L3FvZkFlWFErU1FJU3dROTIzdG5WTVNEMkVGRUhOWjVkYlBVQ1hTTkZL?=
 =?utf-8?B?cXFuWlJnZmRjUnZRdTdwQ1FjVkRDYm5wK2tQUjJFaW80M2hzMGxpWFFXRDNo?=
 =?utf-8?B?MjJ6QSthSXNlTW5wTDdTYkp4dXRaS3RId1lpMEdFbXFrcGx6cDFab2wrRzVu?=
 =?utf-8?B?clZwMndkNFJCaytUNVFPVkI2bHIwc3NDYWNqSUtkNEJHemhkWFRQZ3FBbmJC?=
 =?utf-8?B?WlJQakx4NjNKeUljNWFjRHVYYyt4WkxESkdaYmFZZjRvNWRLNk9HWVhhejg0?=
 =?utf-8?B?WGg2RzlLa3JSZzJTRncwNUNmdUNZcUVpRVhHY3ZoN1dpcUM1MnVESFVzR1Vp?=
 =?utf-8?B?VlJmWEIrN28rT3YvZUc1Vk1ra0lSN1I2MWszOU5rTEk4bGw1eWJjcThDYzlV?=
 =?utf-8?B?WUZFc2NycHRpais4NUl5djEvcTFSQkNzME5LRjQ1d3ZMYTFaSm9aeUJ5TlZ5?=
 =?utf-8?B?UEZSL0ViNzNlSGRSOFV6Q1dTT2wwS1dGWGhVbmUxUkFZajZWbktTVVpacG9l?=
 =?utf-8?B?NVhiRFJwYXFrMy9XK3FxazB4Nk8vMGU2aS96MVozZUU4bEE5Q09aRVVST2d4?=
 =?utf-8?B?djRoU0V2UDhBT24yeHp5N3lxc0ZWcFduVWkzcDlQMzBDVjQyak9VWnJEM24w?=
 =?utf-8?B?R0JRMTA5OVFCWmVTbGVpVmxsUi9yOFU5TjhwMkJBMVNkQkRRRjFlTWRyelhq?=
 =?utf-8?B?aE9kSUdleEVNZGNFSU9XNHZBK2RNaWluNGtudExqcW1hQ1NMc2JraE1UWU1L?=
 =?utf-8?B?VmFYWmVoMjZ1b0d4cXMyaVNoVDRvL0ZNSVlBbllOcllFakMzTkZXaXU5UzUv?=
 =?utf-8?B?dFZWWGFTTnBNSlg1VXoveVo1a3dnT05BYWpuczJBWXl1TDBkZnhwSWhEbUt5?=
 =?utf-8?B?NnJJbmxQV2k2L0JLMzNOaFBtbm9heTMxWW1lOWV3QWcvVnhyaHZJcmE0N2I4?=
 =?utf-8?B?enY0b3pqcWdGako2RjYrNjQ0eXVwazJpWXI4TFNobFpCMDRONGhBc2lTVDNM?=
 =?utf-8?B?OU1ieTk3M3dGTEtrbmE5cFpGYjc4NUphRjhCeFd5eUdhOTZIQzVTc3RYNm5H?=
 =?utf-8?B?NC80a1lOZWptOEp2UWtMQThnM0dTOHpTM005cnV2T3VueU5sQlNOd1RtRXlS?=
 =?utf-8?Q?4fDLTo5lx6yDGB2v0I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(7416012)(376012)(1800799022)(366014)(921018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzA1TTJTMjR2RjJLZnFNaVM5eUJLU284ckNza05hMFpFdzBwRGp2eWczUVhF?=
 =?utf-8?B?L3E2MnVBTG9GcDdBalU4MGRrcVZIL1JqcU84QlYxQ1Rjb2M1KzNHL0FtaVJy?=
 =?utf-8?B?MFdudDcvSjRpT1pVbzVWMkIyK2IzYlN0bXRTMHRPd3llSTdvTU9ucloyMllu?=
 =?utf-8?B?N1F3cDJCQjhNcGtUQWFmVzMxYkZFcXBqaHNpYXliQzMxSmtuc2RQbXJnRVk0?=
 =?utf-8?B?Z2Nvd1FKOStiVEpDdng3M3REL08yMXcyRXFHejBiQlNGRjNTMTA3V1M3bVRZ?=
 =?utf-8?B?cnVYZHljU25xWU1OS0VMZEJCWXhuQlZiai8vaFFiSFRuMS84ZVBoaU0xQ216?=
 =?utf-8?B?UXRiSXRLNHhKTHE5M3Vsckg0b2wrYWFrZk5nUWtRZm8xV2VKeGtCaDgxY0E0?=
 =?utf-8?B?M1dEcVlldWo0Qys2Z1NKSmd4NmhsdnFzT3pqcm1qUjVrNndxckh4RjBCU0No?=
 =?utf-8?B?LzFvNVNjZUlES240NjNmbkd2U1ExUGF4enFKd3F0djNwTHdERlZzNFlKZGor?=
 =?utf-8?B?ZlZZN091NndYVHUvR0lEVlNyYWF0Z2F2MThJdXVMcG1LS2FWRXlPdXY4T05q?=
 =?utf-8?B?UWkxZlUxaGFTeE5YUXp4Q3FYL0J3Z1VWSTNEMnNRWk45WUh5SkxmclVZYXRE?=
 =?utf-8?B?Z3owaDlCdFNtTU04M3ZGWHk1Z090SUlOeG9BVGRtdTFHb29PNnFLT3o1a0ty?=
 =?utf-8?B?R2VFUzZHR0pYRmx5S1RRaTc4WFBLVDV4MFoxMThUQlU0T21Qc3lMdC9BVFVH?=
 =?utf-8?B?ZEZaMGNqeHdBT1luVDVBOEFxQTFRK1lURE40dHRhd2ZacVAwbE0xNzNQM1Ez?=
 =?utf-8?B?UjMrU2EreHVtejE2ZENBdGRTWTZ4NzRWY1FZVlB4a2ZoUzQ1Q2RBeTE2NTVH?=
 =?utf-8?B?R0RQRjE2dVBEaFZTaEExMjN1R2RUMEZKYXFET2QzSHpCSDdpVjdLWVR3MjBP?=
 =?utf-8?B?OUJyTHVqeCtxSzBwUnhkaHhsbzJYMXQ1VDBQKy9VTWlNcTNXTHF1eWlGM3Qr?=
 =?utf-8?B?NDArbStNNVIrOXNoOHZiU0pORHlKQ2N0N2JVMndaYUhJQTk5TVIxeHVWb216?=
 =?utf-8?B?WStDNFQwd212MWs0RXVmbHBKSTl4aDdNZGxicHRTSGtvKzZyc0NtRXJ0TjRG?=
 =?utf-8?B?OTV2emhvTEtoRUFVSkUva2hDVHFGb1ZYL3k5dWVTL0hub3NKcDQ0ZVVCa2oz?=
 =?utf-8?B?R0duMWVja2N5TXBWUXVPZkxLNno0MHFLOGlIYk1zSzMwL1poOHZyelloOXhZ?=
 =?utf-8?B?OHJiSHd4cEhNblVSeGV4WmNudDZvVWE2SW04SGVLREJEY1BvR1Rxc25zdFla?=
 =?utf-8?B?aUM0RCs4NmdOamY1a09PNDhiOXdEbjZjV1BpY003L2s2cjVxNk9JcEdPT1Qv?=
 =?utf-8?B?c2ErZVdmQ28rZnJqWm9rVkZEbjR5Y20xSzZjT0xCMlAyR1VFOGRrTThGSngw?=
 =?utf-8?B?aXV5R1NoUHFoRzZxZnhBam1HdkNzK0hLNG53T0FVVHA3S01NTG5RTTM3MDFi?=
 =?utf-8?B?NVJIcFg5K3cwbVQ4MmRKelZIQzNxS3piUkcrTTRwZHhaTDU5VzM1Uk9wOWp0?=
 =?utf-8?B?WXVqQ3ZGcnFGS1p6Y0VnWEZLWS82TkQ3MUROSE1FQThnU0wzY3lZRzJXRC9D?=
 =?utf-8?B?NVd5MCttUExuNFhUYXFma3V5YWRzVTZFcjJIbTRCL3UyS2xmYURtQ0xpM2Jk?=
 =?utf-8?B?YkNuZkVVcjBOSmlxUXNUMWFaazZvbi8raTV4MUZSRWQ4dWZITXFYcHlCcCsy?=
 =?utf-8?B?WkxJYmlwSytlUkFtMjViRys5VVF4L2xnNm03OVJaRlVINmM1Z1lqeXFYNDYz?=
 =?utf-8?B?eU51ekJKU2ZRNnAvQTYxVjlMRmFORit4c2xLakVEb0RIeUZhVHROYVhYbDlm?=
 =?utf-8?B?elNsZVhlTnFSN3RESCtMQ2hjWlZuY0QwZUdvWklPMDVoVmZmZjh1dUFqeDY1?=
 =?utf-8?B?dVhIcFlXZ2RLcmVKMTNENFBaMTVQQXo3dzk4eEQzenYvRHUwMHVTQzVQMkZz?=
 =?utf-8?B?SWFYVWZjanQ1K2ZIWVVoK0IrVmpvR1VFQ1NQZ1orU0RDeVVDd1NIWmRobHZm?=
 =?utf-8?B?WGFLSmM1NEJsWXc4aEE5VjU2czhCWUdzTXlXbmtNTDRPcitCQU5EZUZSTDcy?=
 =?utf-8?Q?h4AQIcbyXnhO1zwuFWm5jMC/2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9ad3bb-d977-4a69-be59-08dc95f5739f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 15:34:22.2228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7MbfGido5Cqn9oCcPZdmNfBq8iIT6cIbtZIaQ8tqFz9etjlv0OsomJZuXatJ4FIi4BgwXm4Mm/i1GxwZhgiJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042

Hi Rui,

On 6/26/2024 7:48 PM, Zhang, Rui wrote:
> On Mon, 2024-06-24 at 05:58 +0000, Dhananjay Ugwekar wrote:
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
>> Intel and AMD CPUs, we have to replace these macros conditionally
>> only for
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
> As there is no code change compared with V1, I think you missed my
> Reviewed-by tag
> https://lore.kernel.org/all/e1f70a09f85dbd0ee3f32dffea37993e141269d0.camel@intel.com/

Yes!, forgot to add your Reviewed-by tag, will add in the next version.

Thanks,
Dhananjay

> 
> thanks,
> rui
> 
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

