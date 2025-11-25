Return-Path: <linux-pm+bounces-38540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D90C84390
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 10:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F7244E1466
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDC32D3725;
	Tue, 25 Nov 2025 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzxK7E0i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0E299A90
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764062945; cv=fail; b=HaDghK0ON/9wLAzuuhbqOCxtbOHyeycfGSui3nBlHhBc67ZTrLJT6S/+NYljxmylh9oBJF+bN6M0aX6/uXYJfDuI5oVIjTL/rhBZx1fLoTkJRxq9BHI/BgWULqT4ecVGcoY2sDm4Wt0PI1s1hyLigHatjApTD7XGxhlKDmhnzD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764062945; c=relaxed/simple;
	bh=3Bzn7GUuJXUWdk5Oim7SBYDAdiX1zxb03V5zBKelJX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o2bLoSxKbbDK4QHwPRFGJJX6kV2Dc6DPLjhfLRz/svnvwPVqFB1CvnI/SNU0Qrbh6tGWO+z1F2HVHLavQlx/vC46Hd6ovJKH+ms2FI0fFugo70CRE1N2bQxg4MsA42IkJSGrEIj+vixAfoRPoSH1r9opldQ540No5gfS5jx6Iow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzxK7E0i; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764062944; x=1795598944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Bzn7GUuJXUWdk5Oim7SBYDAdiX1zxb03V5zBKelJX8=;
  b=OzxK7E0iie7tRQ7umy42lWAjLtCn+01FXJOZndZJFl5+2/zXaV6wT8c3
   y6ICdsmLctHMYFnVta3g9WqhkaO/Z8MYFUEU8YRqTS1bjnVtrqeoC5JaE
   8K/lrlOgZVx6zMI4DFUC6uI+c/sc5EVmrsLZQlX0ZcDSPP6SyS9PV+e3+
   u1rOffJhe+ODReQgtNIgVYvK7SReTDu3XtaCA2Fsn7AjtaWB4ALVPP3Dx
   WRAP0XdjAD9qCsvJRftuI7YgJ/PLBGON3MztU3UCsg29EvK0cTM7Zs7mu
   u0kKLXq+t/2RAhCrBweQ2xDdro+qcjgFCXCS0f0dfTpuIqZGQbd24XMjJ
   A==;
X-CSE-ConnectionGUID: ikkjudozTuG2jBN4pwG68A==
X-CSE-MsgGUID: i4S4WlF/R3qKs7us47WWmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77444563"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="77444563"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 01:29:03 -0800
X-CSE-ConnectionGUID: mIwtEOlgT4Ccap7XwKp0Xg==
X-CSE-MsgGUID: mJR35PkBSKKo+b2SX9gYFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="193021049"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 01:29:02 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 01:29:01 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 01:29:01 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.63)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 01:29:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9qfASh9N9G2pvOTbKcBgJXJ8jKY8CZOEzt/krOcPuqc/dvN6rceXk0oNMm/XjFQmzPIF1WbkILjpObrZgH0LiKduMI5I1EJTW2JtM24bsUOvdEN6VweBWlycMfgNGWspyWpCd3SGg2CJdFW5klSVyeh0Kr1UKhLOZpnUIVJ8kuhFTYpAJjNorpF1Jhryxq8uZJM6aKZwmSfDWaN6i0TWKy5MppDDuk0jK+jSVL3WfcCNIS3gupiql5JoyLqBzj3USlnFFQBcDS/1pw//3SdSbaUfB50ybTtCgYgtC4S5QxedsyhKsakSnesM4y2gM3r+9m5exqjK/gSQKz+uqClUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Bzn7GUuJXUWdk5Oim7SBYDAdiX1zxb03V5zBKelJX8=;
 b=f/OZUO5MNGhAm4gqSYOkr6U9mpwrLb1BRB4rQNiEfZCAGY5Ba6lhzPwWsv14ELeQLF+5ODOXMmrvMQWyz7jYxweuJoMYi2ph9qNgwa7oLFXJDgqhKNvncItXFRB/eN9jtWj+R57VeDVyPYyTnYwXQ1u8e097nh/Cg73FNldJRGjCztv6QY/gksWIEe0ESpCqD639v5JD0MxeGcg+/k9+PxW9B09wPMvrIsilcP9DNP+sKbysJ/r8zUt/MxHxY5FRPklb/BGn3Z1POPj5Qjw2gstUSVFcG+CQo6cuLg9mPmLDkLTIU6cJunOQY1so7EF5cGvTa+y5dmk3LxTitv6ulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by PH0PR11MB7168.namprd11.prod.outlook.com (2603:10b6:510:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 09:28:59 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 09:28:59 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Christian Loehle <christian.loehle@arm.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "bsegall@google.com"
	<bsegall@google.com>, "mgorman@suse.de" <mgorman@suse.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Beata Michalska
	<Beata.Michalska@arm.com>, Ionela Voinescu <Ionela.Voinescu@arm.com>
Subject: RE: [PATCH] sched/cpufreq: Fix capacity calc in shared policy update
Thread-Topic: [PATCH] sched/cpufreq: Fix capacity calc in shared policy update
Thread-Index: AQHcXe3rnEOD6bRJr0mzbLDctwrQBQ==
Date: Tue, 25 Nov 2025 09:28:59 +0000
Message-ID: <LV3PR11MB8768F072852446A04870947AF5D1A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251125032437.2056626-1-kaushlendra.kumar@intel.com>
 <4f5ee76e-1409-4064-b765-3c9aed25cf0e@arm.com>
In-Reply-To: <4f5ee76e-1409-4064-b765-3c9aed25cf0e@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|PH0PR11MB7168:EE_
x-ms-office365-filtering-correlation-id: bde6a121-f26d-4f08-3656-08de2c051052
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bDhOUStMYzlkY3pieWRWMFEydkZyYnA1Y0R2Y3FYa253VXp5Q1lzUFdEL1lz?=
 =?utf-8?B?K3RqZWxhczhYbVhybUswcnhsQ2I1OXlUSWluUjBnZTZkVlYzdTVLcDVBUHM5?=
 =?utf-8?B?TVRzTFBEZTVEclZRNWFIZG0wMFBXNTNTWjQvdlN3b3BrRUZuMlROeFJmWjBh?=
 =?utf-8?B?cEhhRUZOcHp0ZWpOd2FhcHJBeEYyNmsyNHRTbXJOcjVzU1c3Um9Sb2RtZWpa?=
 =?utf-8?B?RGEvTjhJRGxpcnMvZzBlWEFDTWJ6K0lINFNZSThVVmdUeVNqcytzZXprNS9O?=
 =?utf-8?B?QU93dU9SWE5MTGdtM1Vrb0ZGMHBQRnh2bEhFTFZIQUgwZnBkL2k2Z0RDNnFZ?=
 =?utf-8?B?ZDVqeDRyR1FNbTVPNUdLdytTMEJ4Z25YREFkZ1pkUDBFT0E3L3p5TUdWSzFH?=
 =?utf-8?B?cUkycTR3UkF6ZjNYUTRwWXVuT0xRQW0yZlRvODJHYWRSSHZVK3V2UTR5NS93?=
 =?utf-8?B?OEZTY0ppYnJVRHRydkNDeWVmRGRLcE1BdWR2aVo4aVJTSnQzVEZoN1hJTVNB?=
 =?utf-8?B?b2U1RWp2RDNkUHZGSnBuYlBUbCtXc0lnNWRrYkNyeEJYK2dOREhWT0tsUzRH?=
 =?utf-8?B?S2UyY05iUlA4MGhWV3pva3hpVzd0ZXU1RUNXeFRMazJObjdRNTg1a1Y1ZHAr?=
 =?utf-8?B?ampxZnFmK2toU3cxZ0UzNTBPMUNSYTU2N3VOQUc0WFEwOVkzcUVyMEF4M0V6?=
 =?utf-8?B?RXA2ejhtRVlIUHBvaTh1UlcrRzNKWjlCZFZZZlovU29EQVdZMmZZTHlja1pP?=
 =?utf-8?B?V3FnWE5ET0Z5Y01QNXpaSlJxOXRCS3JTRzdQZlg4SkdiVG42ZEFWMzhBbWZ0?=
 =?utf-8?B?WjNiZzNKVk50bVcxQ3RlTkNMdVFMU1FuZEE2ZytPUXc4Z3V6ZHNEdStCdkcz?=
 =?utf-8?B?QTJ3cHJHajljWmE0QndzY2JuOCtZbHNJRDBnbkxmTkt3QnBXajV4eEVHemwy?=
 =?utf-8?B?ZVhFYXBwRnV4TjhMd0RrN3JqZmxHWUxIbGpzVm00Z1czUXI2TG5ueXBFeHpl?=
 =?utf-8?B?SHZMdGZJYThKa2ZOcTkwN1ZWQlo4K0ZOTHhaV3kzSDM4Z1lxT1E2dVpRV1Vi?=
 =?utf-8?B?OEhkN25rU21kZWdFdkk3M01ML0JmRUxwcTRpL0xjQnJzS09LKzEwSzJUdDlL?=
 =?utf-8?B?MWhISG4reEFGbmJDYnQwTzhmRTJ2bDNBamlMN3dsQjdmYmZac2R2VXZUb1ox?=
 =?utf-8?B?OVNTUkthVlQ3cnZzZEQycnVnY285djBmYXFmSWdRS3NRb0dFZlBOUXNCdVo0?=
 =?utf-8?B?UStFa2cwRHMvSmQ3bmZqL0lUY3M5cTRUYjNmNHltSktEekVUL3J2Z2JXZUtT?=
 =?utf-8?B?RDAxNDdoN0twZXQ3VWludnJqajNJUUtxS1l6Y3gzQ0wxNzVqVEdDaUtmS1BV?=
 =?utf-8?B?MEJ1MWVtR2ZoRFF5ZUNtSElwUmJablFad25Ob1VYcVNsWlhjSTJDTU1Tdmx0?=
 =?utf-8?B?WlJLMXhkUHpxSlp1THMrb1paTVlFQmZMNVZkSXJMaDNZNmd2K0Iyb1BMTjIy?=
 =?utf-8?B?bGx6VlJobTNNWUFTc0lwL05vNW96ejM3ZS94TlJ5YUMvTlR1WWY3S2JuTGtm?=
 =?utf-8?B?QVo5bXdsREdrUklaRWFpVTI0S1Zvd3VJSE1rUHFXK0pEYzZRR2hlY2NPNHJ0?=
 =?utf-8?B?bWJrejdKcjJQQmN6S0ZzQTY2TVdQaWRHOFhFMXFybStGa0hWbmRxMW9xc3M3?=
 =?utf-8?B?czZJbmxSbEFKTjFZNVBSRmsySkhZL2d6TWxHUDVrWlQzZVpmeWlaOEJ4amgy?=
 =?utf-8?B?QW9qWElsaXZmd1MzS0Njd1pDRmhrdHVyeGZlSURYaFJMTWMvbXNaZzFvMExs?=
 =?utf-8?B?bThPelNaUjJXNGFhck5ia1hrMUh5cG1CeXZaZlJvVzJobTVEM1dUS0tiZmFl?=
 =?utf-8?B?eXcrZjFJL2NJV3dQODdLTHR6bFpFVEx1Y0pLNDBXMW5NdFhSMHFxR29JWlpp?=
 =?utf-8?B?QUQwN0JrajcrTk9yTVJSdUZQZTY1ME1acTdRNzYzZnhyWHk1amVqTkt0ek9N?=
 =?utf-8?B?M2h6TC9VL3ZLZ0ZFdTdkQzRya0pRbHRIaTBaWmJMYVcxeFkrS1pGNmx6ZEJt?=
 =?utf-8?B?VG5VT01Ea3Z6TnRhSzBoQW9BcXdBS3BFdm8zdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3N0MGdQa0x6VUVpTS9VTjFMMzN3T0FobTdhRGYyTElkYVRkSXBjdjIzUnFa?=
 =?utf-8?B?TThFTitZT0lwZFVoS0NzWGdaK2xPWFBYYnFscFV4NE8vVEdua0pVTUovZWw4?=
 =?utf-8?B?SnFnQUQ2V2hRcWJZOTN4TlVsT1AvcW5ldEJFWThuZFNUM2NYN3hyMkdhUE1E?=
 =?utf-8?B?OFZvVEFVL0dqUk0rU0FNZ1VxYXRpTE9IM1NWaitDNmIxZFQvR1VDbkx4M2xi?=
 =?utf-8?B?RWVhdDRoOG9DbjRTc2JDN1AvT2QrRmlRQm5lbWhVYTk3NUwwQzZxUGEwQTlF?=
 =?utf-8?B?cTBCQWVvRTlDUTVESXBicW01c0VGeWtNZ1JzZTdKdG16V0hGRGVGdStNWTJq?=
 =?utf-8?B?VkErdFdjdmpnVXJ1TkxHVnBOem5obEh2Z3dJdzhscTJtM3dDZDlhSTRSTzY3?=
 =?utf-8?B?QlhZa2R2bFZTR1NsZkpOWkhpdkIwNnJYSFFXTEMwMVRFYW8xOEdWejBmbDNz?=
 =?utf-8?B?bGpiekJmSmZpWTJ6WWRMTDhwQ2FYSHBpQ0pPTGVHbDFzRVE5RmhMQkZoQTRq?=
 =?utf-8?B?d2I2dk9GeG1heTV6MEZueU5iakhZVmFMRHN2Mm9EMmxFNFJ3Umhjcms1ZVhO?=
 =?utf-8?B?M1BrODJ5S3hIZzJFSmZFYXk1bk9iWWZoM1hqaERlSit0MkcwL2U4Q21QNWkv?=
 =?utf-8?B?bmliT3ByVEcvcnJjWVFsdVNxS08rTXJDQ1N6UDY0WURJNXhMSHhwSGFlTGIy?=
 =?utf-8?B?cVorSmpDN1g1c0VWN2FxblFzem5pVlk5VW5TTFB3SnRhVDcvZDcxQ2dtcEFP?=
 =?utf-8?B?ZlR3aHF4L3VnRWhlQmZtblVaZDZydWhjQzZPT2tXaFRPcDZ3UHFmUm5JRUNO?=
 =?utf-8?B?SEIxb1pncFpsRmtQZnIyZWcvb1ZaQk9OQ3VtMEppQTFsSktjRTl6OVJocm9G?=
 =?utf-8?B?NjdtdTF3dmxhdE92RlBuMU1oRUtaNGtlTWgwWlJuYmRFZUtHUldYNnFFbkVj?=
 =?utf-8?B?VVNtZG13dWpQektMeUtkTm1VRjVaN3ppdEdYdEhUcnVVY0RwZUhpY0tDSi9N?=
 =?utf-8?B?MVNrV0p5ZWx6L29Ha0x2WXFzTUJqazdvSmJyVUhKZVNtcjQ0eDhFY0tKajgv?=
 =?utf-8?B?ZjRqTlp4Mlg0U09jdkl3aXVrc1VoOStJVThyYmxSNU5GR0ZTQjNjaGw3WlNH?=
 =?utf-8?B?cFYxTzI5M2V2czBiN0RhZ2ZMZ1puSFlqczFoYkMvRXUyaGNhVnJuNTVlajZm?=
 =?utf-8?B?bUFEVzBDN1dES2tVZTRtSDNXNVJZbCtjWnJNbXBYem5mNUlWNi9pcXJRbmdw?=
 =?utf-8?B?UjVrZ25NYTlkOGFoK1pYRXNMemF1R2ZvOFcxZEJoLzhDQkpnS3BzaGZFS0VM?=
 =?utf-8?B?NlEwUmRQaUMvUXRTK3o4Z3JaQlY2M0hlT004WVNBR0phUHZjZGxoL3BWRWJQ?=
 =?utf-8?B?aGQwM2docU9NY0JDV0o1aE05MXBCN0NQUC9ETnBld051N0pUNHhERW1OQlJr?=
 =?utf-8?B?R1Z4ZmIwQ3NxV0U2OTBNcVE0UlNPak8zdFIzV09Ga3VJQVY5MHhOT2xxdlVu?=
 =?utf-8?B?VWJ2cWJERUM0eGNNL1B1MTVCSnk0VkVUTG9qdDFQVEtQenlSQTVxbit6NDVm?=
 =?utf-8?B?a3MvcFN3RlArZ2tZUFlLL2NGVDlDcXlEdGZ0ZGIvcWhIY1BycHdsQ0VTRDJj?=
 =?utf-8?B?TDNVRjdhdGcvcTNCVXNDd08wYi9vRy9OOTFuUnBZcFFxREJONTV0ZUpkV1R0?=
 =?utf-8?B?SDZkZjkrMjZidkR1MnZSdmoxMkFLNUxMOGw5Q0ZtS1JrSkp3OFBKcS9SeHYy?=
 =?utf-8?B?eWxhbjBYVUN0TWIrb1FGRUE2eFVaUWdMNkZmY0xicENHdXk5dCt1SnFHS2lR?=
 =?utf-8?B?a3o0R1JXdWMrSm5zdnB5ejA2QmVXTG1uVGswSTdWeW96OEd1MCt4OW9ZWWhi?=
 =?utf-8?B?QTQxMVpFZFZDWGtQdDhvMFl0ZC9UTDZITE5ITmdFSGNLMVpKM3R4emZxNUxN?=
 =?utf-8?B?ZGJQYXFsdmdxREtiYmR6d2VzaW4zazB0TWUrZ1lFT0g0blVmSVZyWXpXd0tL?=
 =?utf-8?B?MG9GL1FkazI5clF5S05KSmZ1WnhuY2JVMXBkYnczSzVUQmtmQk5aa3pocmZh?=
 =?utf-8?B?c1U4RzRNNExBMDJsZG8rS2JxY1QxNzlDcWp1UFVMNFNxNWVNcmJVNzhieDI3?=
 =?utf-8?B?Z3ZNZ0RWNkY2bm1EQ1ArZ0ErNk1KaktQWjFyWDRIcVpxK1JHQmovdTkvTzdY?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde6a121-f26d-4f08-3656-08de2c051052
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 09:28:59.3101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gubIZgvbVSwbgyN6nGHg1aOysGewnTDxVKG5Vc8lC9Bd5Kofvuw4OdjWBKx18FfMPRqQ2m+i7JZLArk3NysxPNEmhB2768hsfDPx053UrCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7168
X-OriginatorOrg: intel.com

SGkgRGlldG1hciwNCg0KT24gMTEvMjUvMjUgWFg6WFgsIERpZXRtYXIgRWdnZW1hbm4gd3JvdGU6
DQo+IE9uIDExLzI1LzI1IDAzOjI0LCBLYXVzaGxlbmRyYSBLdW1hciB3cm90ZToNCj4+IEluIHN1
Z292X25leHRfZnJlcV9zaGFyZWQoKSwgdGhlIENQVSBjYXBhY2l0eSBpcyByZXRyaWV2ZWQgb25s
eSBmb3IgDQo+PiB0aGUgQ1BVIHRoYXQgdHJpZ2dlcmVkIHRoZSB1cGRhdGUgKHNnX2NwdS0+Y3B1
KSBhbmQgdGhlbiBpbmNvcnJlY3RseSANCj4+IGFwcGxpZWQgdG8gYWxsIENQVXMgaW4gdGhlIHNo
YXJlZCBmcmVxdWVuY3kgZG9tYWluIGR1cmluZyB0aGUgbG9vcC5PbiANCj4+IGhldGVyb2dlbmVv
dXMgc3lzdGVtcyB3aXRoIENQVXMgb2YgZGlmZmVyZW50IGNhcGFjaXRpZXMgc2hhcmluZyBhIA0K
Pj4gZnJlcXVlbmN5IGRvbWFpbiwgdGhpcyBjYXVzZXMgaW5jb3JyZWN0IGZyZXF1ZW5jeSBzZWxl
Y3Rpb24uDQo+IA0KPiBUaGVuIHRoaXMgbmVlZHMgYSBmaXhlcyB0YWc/DQo+IE1heWJlIGV2ZW4g
dGhlIGludGVsX3BzdGF0ZSBzZXR1cCBjaGFuZ2VzPyBJIHRoaW5rIHRoZSBwb2xpY3kgPD0+IA0K
PiBjYXBhY2l0eSBhc3N1bXB0aW9uIG1hZGUgaGVyZSB3YXMgdHJ1ZSBiZWZvcmUgdGhhdD8NCg0K
WW91J3JlIHJpZ2h0LCBJJ2xsIGFkZCBhIEZpeGVzIHRhZy4NCg0KPiANCj4+IA0KPj4gQ2FsY3Vs
YXRlIHBlci1DUFUgY2FwYWNpdHkgaW4gdGhlIGxvb3AgYW5kIHRyYWNrIG1heGltdW0gYWNyb3Nz
IGFsbCANCj4+IENQVXMgZm9yIHByb3BlciBmcmVxdWVuY3kgY2FsY3VsYXRpb24uDQo+IA0KPiBz
L2FsbCBDUFVzL2FsbCBwb2xpY3kgQ1BVcy8gbWF5YmU/DQoNCkFncmVlZC4NCg0KPiANCj4+IA0K
Pj4gU2lnbmVkLW9mZi1ieTogS2F1c2hsZW5kcmEgS3VtYXIgPGthdXNobGVuZHJhLmt1bWFyQGlu
dGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGtlcm5lbC9zY2hlZC9jcHVmcmVxX3NjaGVkdXRpbC5jIHwg
OCArKysrLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvY3B1ZnJlcV9zY2hlZHV0
aWwuYyANCj4+IGIva2VybmVsL3NjaGVkL2NwdWZyZXFfc2NoZWR1dGlsLmMNCj4+IGluZGV4IDBh
YjVmOWQ0YmM1OS4uOWZkYmM3YTYwNjNkIDEwMDY0NA0KPj4gLS0tIGEva2VybmVsL3NjaGVkL2Nw
dWZyZXFfc2NoZWR1dGlsLmMNCj4+ICsrKyBiL2tlcm5lbC9zY2hlZC9jcHVmcmVxX3NjaGVkdXRp
bC5jDQo+PiBAQCAtNDkyLDE1ICs0OTIsMTUgQEAgc3RhdGljIHVuc2lnbmVkIGludCANCj4+IHN1
Z292X25leHRfZnJlcV9zaGFyZWQoc3RydWN0IHN1Z292X2NwdSAqc2dfY3B1LCB1NjQgdGltZSkg
IHsNCj4+ICAJc3RydWN0IHN1Z292X3BvbGljeSAqc2dfcG9saWN5ID0gc2dfY3B1LT5zZ19wb2xp
Y3k7DQo+PiAgCXN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5ID0gc2dfcG9saWN5LT5wb2xp
Y3k7DQo+PiAtCXVuc2lnbmVkIGxvbmcgdXRpbCA9IDAsIG1heF9jYXA7DQo+PiArCXVuc2lnbmVk
IGxvbmcgdXRpbCA9IDAsIG1heF9jYXAgPSAwOw0KPj4gIAl1bnNpZ25lZCBpbnQgajsNCj4+ICAN
Cj4+IC0JbWF4X2NhcCA9IGFyY2hfc2NhbGVfY3B1X2NhcGFjaXR5KHNnX2NwdS0+Y3B1KTsNCj4+
IC0NCj4+ICAJZm9yX2VhY2hfY3B1KGosIHBvbGljeS0+Y3B1cykgew0KPj4gIAkJc3RydWN0IHN1
Z292X2NwdSAqal9zZ19jcHUgPSAmcGVyX2NwdShzdWdvdl9jcHUsIGopOw0KPj4gLQkJdW5zaWdu
ZWQgbG9uZyBib29zdDsNCj4+ICsJCXVuc2lnbmVkIGxvbmcgYm9vc3QsIGpfbWF4X2NhcDsNCj4+
ICANCj4+ICsJCWpfbWF4X2NhcCA9IGFyY2hfc2NhbGVfY3B1X2NhcGFjaXR5KGopOw0KPiANCj4g
bml0OiBqX21heF9jYXAgaXMgb25seSB1c2VkIG9uY2UuLi4NCg0KV2lsbCBpbmxpbmUgaXQ6IG1h
eF9jYXAgPSBtYXgobWF4X2NhcCwgYXJjaF9zY2FsZV9jcHVfY2FwYWNpdHkoaikpOw0KDQo+IA0K
Pj4gKwkJbWF4X2NhcCA9IG1heChtYXhfY2FwLCBqX21heF9jYXApOw0KPj4gIAkJYm9vc3QgPSBz
dWdvdl9pb3dhaXRfYXBwbHkoal9zZ19jcHUsIHRpbWUsIG1heF9jYXApOw0KPiANCj4gSSBmaW5k
IHRoaXMgYSBiaXQgc3RyYW5nZSwgeW91IG1pZ2h0IGFzIHdlbGwgYXJndWUgdGhhdCB0aGlzIHNl
dHMgdGhlIA0KPiB3cm9uZyBmcmVxdWVuY3kgd2l0aCB5b3VyIHBhdGNoIChib29zdCBiZWluZyBk
ZXRlcm1pbmVkIGJ5IHRoZSBoaWdoZXN0IA0KPiBmcmVxdWVuY3kgc2VlbiBpbiB0aGlzIGxvb3Ag
c28gZmFyPykgTXkgdW5kZXJzdGFuZGluZyB3YXMgdGhhdCB0aGlzIA0KPiAiZGlmZmVyZW50IGNh
cGFjaXR5LCBzYW1lIGNsdXN0ZXIiIHdhcyBqdXN0IGEgdGVjaG5pY2FsaXR5IGFuZCBiZWNhdXNl
IA0KPiB0aGUgY2FwYWNpdGllcyBhcmUgc3RpbGwgcmVhbGx5IGNsb3NlICgxLTIlPykgd2UgZXNz
ZW50aWFsbHkgZG9uJ3QgY2FyZSANCj4gYWJvdXQgdGhlIGRpZmZlcmVuY2UuIFdoeSBkbyB3ZSBj
YXJlIGhlcmUvbm93Pw0KDQpHb29kIHBvaW50IGFib3V0IHRoZSBib29zdCBjYWxjdWxhdGlvbiB1
c2luZyBpbnRlcm1lZGlhdGUgbWF4X2NhcCB2YWx1ZXMuIA0KSWYgdGhlIGNhcGFjaXR5IGRpZmZl
cmVuY2VzIGFyZSBpbmRlZWQgb25seSAxLTIlLCBwZXJoYXBzIHRoaXMgbmVlZHMgZnVydGhlciBp
bnZlc3RpZ2F0aW9uLiANCkxldCBtZSBpbnZlc3RpZ2F0ZSB0aGUgYWN0dWFsIGNhcGFjaXR5IGRl
bHRhcy4gDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNClJlZ2FyZHMsDQpLYXVzaGxlbmRyYQ0K

