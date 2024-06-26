Return-Path: <linux-pm+bounces-10062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039AD91879F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 18:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1550DB27362
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 16:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9BC18FC7C;
	Wed, 26 Jun 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HbUwiCtj"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8C718FC63;
	Wed, 26 Jun 2024 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419871; cv=fail; b=fe6p+YpPHy/ZxB8fQtrsFc/beMQx+rW+S28e6JiwZOqZQ/7nwR+yJjx2lU0DOCqVcvh6gzu5O8+nr4T4uJMq2x7L99QQcbiMRvMTZDKzPM9nQyV50vKgtZkdcHN0TasVCWLXr8Z/o30q/cJBffNvgOUZ187cKx15Yw3w8WUpMX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419871; c=relaxed/simple;
	bh=mBgCCeHFX0RZCxx/qhTS0vP17hXeEigJTeYFE7ZVWYc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j7si9tmIs96p2HVnIqoM7/CzhxD0QYHsBRqqs7NqYfUZ2Ta/+8Tfh1O0kIRxTvZrH8+0Xe0Wi0aimkQtUIDEoPArLZkV9AmWS2LVfg0wl2aLXHNz2hZBx6uW5trZBeoZyOsJaPdISbsaoHc1Wrkk9hc9q9dFDgJrr4sPD92m5Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HbUwiCtj; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaV21NJtx9E4OW4ncuuiX0+yA5dUZyiG7zI3VewyWRf4PiVW2jFQzz/bptD/j0UDviiMMK4vSWVoZyLAHTsh2sJTuv9K+YA4OIvwfmWEvBI4ywmoDlma/otVoJMZeWt93LHesitNVA+8C/Koj2Pa/IbMYbRx4L9X0v59CJpmnH3xDg/eLTiR16UuywbJdaPeaGQ6AGXmd3k+KO3JqWFLEpTzUTxaIbOEedSIgPVB0zE0spjidPfVzQsTQxtk0MuQjCQu1Yg+YNLh4S94ZCY0JGGouYsnek4R1JpZmk5iJh+EikpQLWj9O3ubWewL5UuParAz4XCpIV/HKqm7u77Ytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjCmz5fdQ8q+GWWDffOUIFHyTHHjqUfeT6+jkJ1pm0Y=;
 b=m5KX0euCWN22Is2Bp76n4RSqosBZ6+wspuY7fx7ltqmp9vX5aCHRRvpF+JbT7+Ei7lKcb8ZGKpnshOC4cCxT0TY9H6GzdEYMBZO2F4EZj/3kha61730MIegER/vrGKqs/jSM1suRslH6V+OlkCjEE9teASMijqll/nGn1gbnhKAQq9DwXoPE9eCSHw3K6XmeF3L2Vp6Hz39b22mZk87OPKIoJg1aJ1VjePNIRsEXRb0GEsG3fJcvKWN5lpOy2xUfhgCYoGmFN42rMImDQPEPUGTynRQTesAYOS9lUVeQ5Z1kn+GmIY6jVL0ZFe4qyqF6+DDn/d346hmIEEAdffXgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjCmz5fdQ8q+GWWDffOUIFHyTHHjqUfeT6+jkJ1pm0Y=;
 b=HbUwiCtjWW1ay2iky1u/XN3kLBV2wCWb/7cVQoCi30vPW7oFySslfysbNQZTmgg+7Rtk90uWewmb181tElaGP3BWqfQM1z9UtS8jFxYjZ/4otJzxXTvwRZTkUrrvM37qjQUoHe9r1oIQCpT/1sTf79wdTU6i7SAtSMyTz5kL9MM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 16:37:45 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 16:37:45 +0000
Message-ID: <dff31583-adaf-4da8-954e-f35f7ef5a5d3@amd.com>
Date: Wed, 26 Jun 2024 22:07:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] perf/x86/rapl: Add per-core energy counter
 support for AMD CPUs
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
 <20240624055907.7720-11-Dhananjay.Ugwekar@amd.com>
 <18e0c72823d916d82aa48fb6690375f960a9d9ea.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <18e0c72823d916d82aa48fb6690375f960a9d9ea.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: c089da0a-fed1-4ad4-1bd5-08dc95fe4e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|376012|7416012|1800799022|921018;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3hBZWY2OFMwMWkybjduQ1pSSjFIYmZWMHdVTExzUER1NEpOcERlK0FEVWZj?=
 =?utf-8?B?dVBWZ2JxREk0Sll2dmNrUE13eVJubXNST040NGwrTDhUMEo4YWlYQ2REdFhw?=
 =?utf-8?B?ZmZBcG8vSUc3TWZoUFRKcTBrT2UydGhSclpmR1FQUEgzZUcwQ3Z1L0NtT0ww?=
 =?utf-8?B?eEs2UEtyVFg5OHRzeTQ3Q0lwSDZYZm9rV1pSSm9PSlBvelJHVFBOaE5kTUFs?=
 =?utf-8?B?ZHN5T00yVGVoR01vaklnRmw4aCtKZnVIVXROb2t0UnQvTk5mVDcxbS80R1Vp?=
 =?utf-8?B?d3dHT2JvTStCaHdET1FTVHlwY0hFNXF4VytBWm42clQxS1lhN1dua3I2LzBo?=
 =?utf-8?B?bHI4dHMxVFN2Q2J4MGxBME5TT2l1Qk1vTFlGQUMvRHAvYmdZbXh4N3NrSkh0?=
 =?utf-8?B?QmZZeW1IU1l4VC8wL0JYTWpXakMrMHVPSnZUTS93Yi91TU9hOUxTdDJhYXlK?=
 =?utf-8?B?YWJPUVgzZ0hiSUFDSkE4cExya0EvRDk0RGtLcXc0VVlZSUFtM2FhZkNNTXcw?=
 =?utf-8?B?OXJUakZNWTVBN0JJMUU5dDhoMWp3MkdaZ09XbXZJMUQ5d0JuRGRKQmZkM2Ni?=
 =?utf-8?B?enFwbWI4YnY1SngyOFpIeVVTUndHWWZoL0hzNWE4a1A2QWRhMGdNZWlaTkh2?=
 =?utf-8?B?TkRQc2JFL1ZXeFBJVytFSzZKOE9qZ2tuSHA2VHNKYWRTMm96NmU1SEw4Tzh2?=
 =?utf-8?B?L0t2SE1nVnpOekdrbWgyWWswcGk0VUZIMUNTdGVEd2UrTmJ2Qjd2WW1YR2dG?=
 =?utf-8?B?U1E1NUFPS3lCeGFoMXdlbUl4bzJLMUgzaUtWMFlURG5LaUhHNU1yYlQ5UHNR?=
 =?utf-8?B?QVF2NHdZb1FrOFhNNUcvVFczVU94N2U4WHJ5UDhZb2xZVVJ3ZVhxZWtUa2pm?=
 =?utf-8?B?YnF2OWpxbDd1ckVuenVldk56VnFLd0ZTWTc5MUI4OTIvTDVMQ3EyNjdMdWFW?=
 =?utf-8?B?Tm92TWV4cWZqM01BQXlMTXREOW5JQnQvRlBLbURiOUF4Sjg4ay9aSVljRkZl?=
 =?utf-8?B?UmdzZFd4ZmVFYUUvNjBkSkNtSE01QWIycU5OZ29xSzM1WmdPUDdjZ1lVRFZJ?=
 =?utf-8?B?dmMvVjNLMGVJRFNBdGpJRjVKTFVxcXMvV1NkUllMMEhWSjFGTjdpSngwM1M2?=
 =?utf-8?B?MXNWRHYrVm1tSHJaV0tCYW5HK3RnZlhZekpGUGQ1dnpPTlluMCszSHcrZy92?=
 =?utf-8?B?L2Q5ZmpkWnNrRUZsaUsvY3E1WUltYkZQTEw0OFNXZkRYbThLMkdQTWY2aFZ3?=
 =?utf-8?B?TEJWNE5QNkQxTzNYMTF3ZEVLRWxNWU4yZDFlemR6NUptYzR5L09Zc0pqZmRK?=
 =?utf-8?B?Q2VnRzlCaWVVK1RoS3FxT1NmNXYzY2Z3UHhsMnl4cGNTZjZ2eFQwYjJSTGFX?=
 =?utf-8?B?UjBuQ2JBTDVpbkwxR3NaLzdKbFAyM1piU3prQVU0UlEwdWFoS3dSMngxWlRF?=
 =?utf-8?B?NU51eXkveWhRWERUMXNodDIxelFQLzRVdkx0MmZRaVdBSkRJMmFXWURRZGpM?=
 =?utf-8?B?Z0FJRnRuUU91U3dnY0JFbUhlcmRQRjVWQlVkWGpEaXFRSGZRVTE0TnlFRElU?=
 =?utf-8?B?SFNodHJ4dE5lUFVSa1htVXVwRnBvUko3MTBIQU5CS0JlSWpsSmdOSmRsaVZz?=
 =?utf-8?B?MFRqWnpSbzJFcU1UY3o5SXFOZTBIdHd6VUh5SEMrTEtSR2o1bzJQQ0huNGMy?=
 =?utf-8?B?bSt0Skd3VlUrdVNmQXFNWXlNZUJqOG5vYUVOUzcrNjRSYktucUI2elBvakZT?=
 =?utf-8?B?NlREWmlCdTBJcVdSc2s5OWlGZ0h4QWZnTmlHSzRzbkwwbk5UTUFKY0M0WGtD?=
 =?utf-8?B?dWlYRUlzcmtZNEZjQTNySXJvMmJqU2FBb1JIY3NsQTNBUmdGT1lMYmt0MVkz?=
 =?utf-8?Q?5BVzRrq8o3Zy2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022)(921018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S21Rais0dDkwTUJVdUlZVHo4L2ZYem9ITlliTC9WWThqQmxkTDhPZEVkaEEz?=
 =?utf-8?B?YThzNWlIUW4rcmZlclo5MjBqUVV6Q0VCeTBBRDhHempibU1XcFYxNm5YcTQ1?=
 =?utf-8?B?bjZtRDhhT3FqUHNvZDQyZkZBR0xobnJrekJUOWJud3U3SEFvVS8wQURlYmdR?=
 =?utf-8?B?YzQxSjY3WDEzaFF3Z2xrQy8zS0N5OGhtdGFLWnhUQ3BFckk1d3lvanJFUTRh?=
 =?utf-8?B?SVJIS0J5TjRITmtBWXh1UDFVQUIwSjJkQ2NrckI0TEdTUXkyMFpuUjRiK1hR?=
 =?utf-8?B?RnpXYTlKdnJlVU00TEFxVzJKUWlLeU1ub3lHWXJyU2xDOVdaVGZ2d1JIYXp5?=
 =?utf-8?B?MGFYYnFqOEVwd0Y2dGN5RXp4V1pFbU9WU1hmNWxiM3Zac2NUYXFFREdWazZN?=
 =?utf-8?B?WGV5dFdRdkt6dUViWXFEbU0rMyt1S0hGM1M2eGtPdFUvUkRKSXg2bEEvQ0ho?=
 =?utf-8?B?VW42Ukc2ZVIrMHJnMkRyajJhOEgyUzJFUlRJVXpqZk50OU1ZUHRoeUFTYmFK?=
 =?utf-8?B?cFQrRkVodEVtcGVIMG9qa1FNVkI3SGVnQ1BhZndGUUlEOVBKZWhnNnBHYkZl?=
 =?utf-8?B?eW52aTZQT3IycXZraCtKUnhpdlMzcEtWcUI2Q3Z3bmZwM2gyM0VyK0JRYkNw?=
 =?utf-8?B?NFlNclpiMTNvY2Y1aElzejJlZkwrQ0ZBYmN4UHZFcUdBT0ljWDFvdkdsWFQ1?=
 =?utf-8?B?TllKUERXL0FyclFvRE80b0RDbzhKbCs1RUxWMTlBaXM0L0ErZXRndDQrQ0Ry?=
 =?utf-8?B?R0gyK0hINCt5VVlNanFvMlJJcVpFTWYyMXRHL0JyazdBZTl1ZktCQitFdFFD?=
 =?utf-8?B?NDVvTTlDZjM0OFdXV0xsUUxaT3RwV3RSZk14MGdOY0hhRkNyNTFKdHlDMktY?=
 =?utf-8?B?OE54NGxpbVd3aFg5cDVDajV0MXNNMTRiTjZNZ1FIc1lUNEJRRlRIS3NrNTNY?=
 =?utf-8?B?aG10cXdBZFlycjBXMmMzWlRvSjlFWmxaMk12VzhjOG5JU3BiNFAwQ0ZLbXFX?=
 =?utf-8?B?OWZiai82K05NRmVoWTAzanBEUkc1N1diWXI5U094WVhIWHR1akRMT3VGVWVp?=
 =?utf-8?B?Yk5jSGc0L3NLdk13M0NpNC9sWDcvbW81eWxRQnVOUFVPcUREMTlYY0tBQzJI?=
 =?utf-8?B?RlN3WHVCd3JmbW9XM0l3N2REK1NtaHY0RFZhTlJ4eWJOMmIxNThuY0VXQzJz?=
 =?utf-8?B?RzMyYytQZlRNcXFyT1RCOXpvK0RUU2xlS0RUb1ZSdUFIaGJMSEdDQTJvdG56?=
 =?utf-8?B?OXNsN0tFNnJoa2Z0dWMyZXVhRVBPR0FSSlF2MlViYjA0M2ovM29hNVd1WDJD?=
 =?utf-8?B?Z3NzR0hUR2Q2TmFvNGFjMmZHWGgrREcwVTE5RTl6dmtzSnBWdjlrLzJlaWhF?=
 =?utf-8?B?TGVja1hydTBQRjVMdStJd2c4Mk53THR5c3luaXN2UWNWRGpQdkhKU2VQUXVY?=
 =?utf-8?B?NVFOYkg5ZFFPS0tuQzFmNWp6bmdtdmlsaE5tVExpUC9ZR1RKWWZoa200Qnl1?=
 =?utf-8?B?MWdYcjFUdDdmTWdKRHhVS2pVOGcxUWFRZ0FMWGJPazdHT3FIZytTZ1VMMC9w?=
 =?utf-8?B?VDVIWmRpMW5zeHpIMkEwV2JzRFA0b3d4RzczMXFVS0sxcjVsdHVNMkRDT2dF?=
 =?utf-8?B?bWx3bWx4UXRrdXE2Qzl2SGxVM1hqYW9qTlNueCs0b0NUS0NmdGtPYmVDcHlR?=
 =?utf-8?B?cE1lNVNFZDcxelphZTlqT3poKy8zdzNrOXJ3d1kyZm5PL1VKMVVTMTczanhT?=
 =?utf-8?B?MU5zOGRVcjBFL0VpT3Z1RUszbFNMYUcrRmtPbXFzdDNnQ1FkeTgxNnVuU2F4?=
 =?utf-8?B?UHZtemkxNWppK3FMKzNveXliUGZwYUhpS0NJZDRtNHBtdDJuRnhjVTdVY0lw?=
 =?utf-8?B?S2dDcjBRTHNYUTNSZmo0a2U4TkdRbjJOTTI4M1l1dnYya3g2MmdWOTdkNzk1?=
 =?utf-8?B?bDhsT2MzTnNqd0U2VERERXlza09wN09DR3ZoQWl5MVdkamR4MVE5eDdxdHVr?=
 =?utf-8?B?NEdIcnNSMTFPS1FqYUVuSXlrUS9GYit0WXdWc3dRVjFLMmgvVnd1elprRG1l?=
 =?utf-8?B?YVEwcDMyd1p5R2RHTVhnazRFZ2FmQWJCeUw0YkJ3K1VQZ1ZJVCswRmY4cFRP?=
 =?utf-8?Q?SG6aBv78hGc3g+jqDJ/tbIBFv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c089da0a-fed1-4ad4-1bd5-08dc95fe4e6d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 16:37:45.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJ0gQLhdWq3QP+gW3SaY8xtoEJBIpKaI0kOxtBympC4KbIVGMIs54yh+zjWndYtkGghbW2Jrxlt3ua2jubHD8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275

Hello Rui,

On 6/26/2024 8:48 PM, Zhang, Rui wrote:
> 
>> @@ -131,8 +146,10 @@ enum rapl_unit_quirk {
>>  };
>>  
>>  struct rapl_model {
>> -       struct perf_msr *rapl_msrs;
>> +       struct perf_msr *rapl_pkg_msrs;
> 
> IMO, this should be part of patch 8/10.

Makes sense, better to move all the renaming code to 8th patch.

> 
> [...]
> 
>> @@ -685,6 +774,13 @@ static void __init rapl_advertise(void)
>>                                 rapl_pkg_domain_names[i],
>> rapl_hw_unit[i]);
>>                 }
>>         }
>> +
>> +       for (i = 0; i < NR_RAPL_CORE_DOMAINS; i++) {
>> +               if (rapl_core_cntr_mask & (1 << i)) {
>> +                       pr_info("hw unit of domain %s 2^-%d
>> Joules\n",
>> +                               rapl_core_domain_names[i],
>> rapl_hw_unit[i]);
> 
> rapl_hw_unit[] is for package pmu only and
> rapl_hw_unit[0] is rapl_hw_unit[PERF_RAPL_PP0] rather than
> rapl_hw_unit[PERF_RAPL_PER_CORE]
> 
> you cannot use rapl_hw_unit[i] to represent per-core rapl domain unit.

Yes right, I saw that all the elements in the rapl_hw_unit array were actually 
using the value from the same register "MSR_RAPL_POWER_UNIT" or "MSR_AMD_RAPL_POWER_UNIT".
Except for the two quirks,
 
 737         case RAPL_UNIT_QUIRK_INTEL_HSW:                                                                                                                                                                      
 738                 rapl_hw_unit[PERF_RAPL_RAM] = 16;                                                                                                                                                            
 739                 break;                                                                                                                                                                                       
 740         /* SPR uses a fixed energy unit for Psys domain. */
 741         case RAPL_UNIT_QUIRK_INTEL_SPR:
 742                 rapl_hw_unit[PERF_RAPL_PSYS] = 0;
 743                 break;

So, as for AMD systems the rapl_hw_unit[] elements will always have the same value, I ended 
up using the rapl_hw_unit[PERF_RAPL_PP0] for rapl_hw_unit[PERF_RAPL_PER_CORE], but I do realize
it is quite hacky. So, better to do it cleanly and add a separate array/variable for the core events.

> 
>> +               }
>> +       }
>>  }
>>  
>>  static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
>> @@ -705,15 +801,16 @@ static const struct attribute_group
>> *rapl_attr_update[] = {
>>         NULL,
>>  };
>>  
>> -static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr)
>> +static const struct attribute_group *rapl_per_core_attr_update[] = {
>> +       &rapl_events_per_core_group,
>> +};
>> +
>> +static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr,
>> int nr_rapl_pmu,
>> +                                const struct attribute_group
>> **rapl_attr_groups,
>> +                                const struct attribute_group
>> **rapl_attr_update)
>>  {
>>         struct rapl_pmus *rapl_pmus;
>>  
>> -       int nr_rapl_pmu = topology_max_packages() *
>> topology_max_dies_per_package();
>> -
>> -       if (rapl_pmu_is_pkg_scope())
>> -               nr_rapl_pmu = topology_max_packages();
>> -
>>         rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu,
>> nr_rapl_pmu), GFP_KERNEL);
>>         if (!rapl_pmus)
>>                 return -ENOMEM;
>> @@ -741,7 +838,7 @@ static struct rapl_model model_snb = {
>>                           BIT(PERF_RAPL_PKG) |
>>                           BIT(PERF_RAPL_PP1),
>>         .msr_power_unit = MSR_RAPL_POWER_UNIT,
>> -       .rapl_msrs      = intel_rapl_msrs,
>> +       .rapl_pkg_msrs  = intel_rapl_msrs,
>>  };
>>  
>>  static struct rapl_model model_snbep = {
>> @@ -749,7 +846,7 @@ static struct rapl_model model_snbep = {
>>                           BIT(PERF_RAPL_PKG) |
>>                           BIT(PERF_RAPL_RAM),
>>         .msr_power_unit = MSR_RAPL_POWER_UNIT,
>> -       .rapl_msrs      = intel_rapl_msrs,
>> +       .rapl_pkg_msrs  = intel_rapl_msrs,
>>  };
>>  
>>  static struct rapl_model model_hsw = {
>> @@ -758,7 +855,7 @@ static struct rapl_model model_hsw = {
>>                           BIT(PERF_RAPL_RAM) |
>>                           BIT(PERF_RAPL_PP1),
>>         .msr_power_unit = MSR_RAPL_POWER_UNIT,
>> -       .rapl_msrs      = intel_rapl_msrs,
>> +       .rapl_pkg_msrs  = intel_rapl_msrs,
>>  };
>>  
>>  static struct rapl_model model_hsx = {
>> @@ -767,7 +864,7 @@ static struct rapl_model model_hsx = {
>>                           BIT(PERF_RAPL_RAM),
>>         .unit_quirk     = RAPL_UNIT_QUIRK_INTEL_HSW,
>>         .msr_power_unit = MSR_RAPL_POWER_UNIT,
>> -       .rapl_msrs      = intel_rapl_msrs,
>> +       .rapl_pkg_msrs  = intel_rapl_msrs,
>>  };
>>  
>>  static struct rapl_model model_knl = {
>> @@ -775,7 +872,7 @@ static struct rapl_model model_knl = {
>>                           BIT(PERF_RAPL_RAM),
>>         .unit_quirk     = RAPL_UNIT_QUIRK_INTEL_HSW,
>>         .msr_power_unit = MSR_RAPL_POWER_UNIT,
>> -       .rapl_msrs      = intel_rapl_msrs,
>> +       .rapl_pkg_msrs  = intel_rapl_msrs,
>>  };
>>  
>>  static struct rapl_model model_skl = {
>> @@ -785,7 +882,7 @@ static struct rapl_model model_skl = {
>>                           BIT(PERF_RAPL_PP1) |
>>                           BIT(PERF_RAPL_PSYS),
>>         .msr_power_unit = MSR_RAPL_POWER_UNIT,
>> -       .rapl_msrs      = intel_rapl_msrs,
>> +       .rapl_pkg_msrs  = intel_rapl_msrs,
>>  };
>>  
>>  static struct rapl_model model_spr = {
>> @@ -795,13 +892,15 @@ static struct rapl_model model_spr = {
>>                           BIT(PERF_RAPL_PSYS),
>>         .unit_quirk     = RAPL_UNIT_QUIRK_INTEL_SPR,
>>         .msr_power_unit = MSR_RAPL_POWER_UNIT,
>> -       .rapl_msrs      = intel_rapl_spr_msrs,
>> +       .rapl_pkg_msrs  = intel_rapl_spr_msrs,
>>  };
> 
> All the above renaming code should be in patch 8/10.
> Or else it is a distraction for reviewing this patch.

Agreed, will move it in the next version.

> 
>>  
>>  static struct rapl_model model_amd_hygon = {
>>         .pkg_events     = BIT(PERF_RAPL_PKG),
>> +       .core_events    = BIT(PERF_RAPL_PER_CORE),
>>         .msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
>> -       .rapl_msrs      = amd_rapl_pkg_msrs,
>> +       .rapl_pkg_msrs  = amd_rapl_pkg_msrs,
>> +       .rapl_core_msrs = amd_rapl_core_msrs,
>>  };
>>  
>>  static const struct x86_cpu_id rapl_model_match[] __initconst = {
>> @@ -858,6 +957,11 @@ static int __init rapl_pmu_init(void)
>>  {
>>         const struct x86_cpu_id *id;
>>         int ret;
>> +       int nr_rapl_pmu = topology_max_packages() *
>> topology_max_dies_per_package();
>> +       int nr_cores = topology_max_packages() *
>> topology_num_cores_per_package();
> 
> I'd suggest either using two variables nr_pkgs/nr_cores, or reuse one
> variable nr_rapl_pmu for both pkg pmu and per-core pmu.

I understand your point, but the problem with that is, there are actually three scopes needed here

Some Intel systems need a *die* scope for the rapl_pmus_pkg PMU
Some Intel systems and all AMD systems need a *package* scope for the rapl_pmus_pkg PMU
And AMD systems need a *core* scope for the rapl_pmus_per_core PMU

I think what we can do is three variables, nr_dies (for all Intel systems as before), 
nr_pkgs(for AMD systems rapl_pmus_pkg PMU) and nr_cores(for rapl_pmus_per_core PMU)

Sounds good?

> 
>> +
>> +       if (rapl_pmu_is_pkg_scope())
>> +               nr_rapl_pmu = topology_max_packages();
>>  
>>         id = x86_match_cpu(rapl_model_match);
>>         if (!id)
>> @@ -865,17 +969,34 @@ static int __init rapl_pmu_init(void)
>>  
>>         rapl_model = (struct rapl_model *) id->driver_data;
>>  
>> -       rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_msrs,
>> PERF_RAPL_PKG_EVENTS_MAX,
>> +       rapl_pkg_cntr_mask = perf_msr_probe(rapl_model-
>>> rapl_pkg_msrs, PERF_RAPL_PKG_EVENTS_MAX,
>>                                         false, (void *) &rapl_model-
>>> pkg_events);
>>  
>>         ret = rapl_check_hw_unit();
>>         if (ret)
>>                 return ret;
>>  
>> -       ret = init_rapl_pmus(&rapl_pmus_pkg);
>> +       ret = init_rapl_pmus(&rapl_pmus_pkg, nr_rapl_pmu,
>> rapl_attr_groups, rapl_attr_update);
>>         if (ret)
>>                 return ret;
>>  
>> +       if (rapl_model->core_events) {
>> +               rapl_core_cntr_mask = perf_msr_probe(rapl_model-
>>> rapl_core_msrs,
>> +                                                   
>> PERF_RAPL_CORE_EVENTS_MAX, false,
>> +                                                    (void *)
>> &rapl_model->core_events);
>> +
>> +               ret = init_rapl_pmus(&rapl_pmus_core, nr_cores,
>> +                                    rapl_per_core_attr_groups,
>> rapl_per_core_attr_update);
>> +               if (ret) {
>> +                       /*
>> +                        * If initialization of per_core PMU fails,
>> reset per_core
>> +                        * flag, and continue with power PMU
>> initialization.
>> +                        */
>> +                       pr_warn("Per-core PMU initialization failed
>> (%d)\n", ret);
>> +                       rapl_model->core_events = 0UL;
>> +               }
>> +       }
>> +
>>         /*
>>          * Install callbacks. Core will call them for each online
>> cpu.
>>          */
>> @@ -889,6 +1010,20 @@ static int __init rapl_pmu_init(void)
>>         if (ret)
>>                 goto out1;
>>  
>> +       if (rapl_model->core_events) {
>> +               ret = perf_pmu_register(&rapl_pmus_core->pmu,
>> "power_per_core", -1);
>> +               if (ret) {
>> +                       /*
>> +                        * If registration of per_core PMU fails,
>> cleanup per_core PMU
>> +                        * variables, reset the per_core flag and
>> keep the
>> +                        * power PMU untouched.
>> +                        */
>> +                       pr_warn("Per-core PMU registration failed
>> (%d)\n", ret);
>> +                       cleanup_rapl_pmus(rapl_pmus_core);
>> +                       rapl_model->core_events = 0UL;
>> +               }
>> +       }
>> +
>>         rapl_advertise();
>>         return 0;
>>  
>> @@ -906,5 +1041,9 @@ static void __exit intel_rapl_exit(void)
>>         cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE);
>>         perf_pmu_unregister(&rapl_pmus_pkg->pmu);
>>         cleanup_rapl_pmus(rapl_pmus_pkg);
>> +       if (rapl_model->core_events) {
>> +               perf_pmu_unregister(&rapl_pmus_core->pmu);
>> +               cleanup_rapl_pmus(rapl_pmus_core);
>> +       }
> 
> we do check rapl_pmus_core before accessing it, but we never check
> rapl_pmus_pkg because the previous code assumes it always exists.
> 
> so could there be a problem if some one starts the per-core pmu when
> pkg pmu is unregistered and cleaned up?
> 
> say, in rapl_pmu_event_init(),
> 
> if (event->attr.type == rapl_pmus_pkg->pmu.type ||
>    (rapl_pmus_core && event->attr.type == rapl_pmus_core->pmu.type))
> 
> this can break because rapl_pmus_pkg is freed, right?

Hmm, I think this situation can't arise as whenever the power PMU fails, we 
directly go to the failure path and dont setup the per-core PMU(which means 
no one will be able to start the per-core PMU), 
Please let me know if there is a scenario where this assumption can fail.

Thanks for all the helpful suggestions!, will incorporate them in v4.

Regards,
Dhananjay

> 
> thanks,
> rui
> 
> 
>>  }
>>  module_exit(intel_rapl_exit);
> 

