Return-Path: <linux-pm+bounces-12526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37067957EF5
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB301F23DF6
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6EE158541;
	Tue, 20 Aug 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIKVuvDl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD834084E;
	Tue, 20 Aug 2024 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137557; cv=fail; b=cq1MQ+D+zd1KbNxcHPzHQ1WFsw16rOhb+Aq4pZ16bpvmck7u42vmbpGS4LEvgsH+Jgnmzu3C53MGkVF/Jj7+5VsrRmPjL3bzsr7FocpoWs8MElWYs5MowmmiZ1DbDH9O0fH1tZ9WIIGFBJU4LMyAdDnPd+gX1HIxA213ZYWuRFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137557; c=relaxed/simple;
	bh=M9h2//5ET6MKRgHFpSRtnNFKKrC9JzexpHYa68c0liU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oiKzd704+Z+zV/r52NGqmsawNwwp+5khrl17nZm3bmQ7Ll9YU7g5MeUMYQzplw111zq4fbJXsFHqTWlIhaYbyAnot/RVf+5NNJdJsm5m14X9iMC42Nm3wYsoKDNdJMfKC2ZQDAg618071z6FXHZwcPhHvTjanhet7rZ7odiIw4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIKVuvDl; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724137555; x=1755673555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M9h2//5ET6MKRgHFpSRtnNFKKrC9JzexpHYa68c0liU=;
  b=KIKVuvDlMhpTQ/hjfRZyKzDub+CYpHzU1CHcaF39hoDOT3agnjPBG00L
   YCbj6YMk1wkV5b5CBhKivkwC2gjeFypmnlh2oB66iz75q0mY+pZREM1/A
   IAzEKtBsSxS0YV9/x8gxQSYg+TZGPxkqDjJxQN/+yncwfj5WN/3l/QHTj
   h8zSZ6xp/hx2B9mzJMYVrShp2Pne3V/mHVUP0i5hPP4k6wmEshHBQPV8T
   PrjAY18f9WvQA2jR501LFiIXayoTajtfIK9WRyCrDdtb6diddHYYhL1M6
   TalTQSeqNDhMkn5f9WKddmwxZ5ETHg4arjTRwsNANSXT1BbD0ek9QvVq7
   Q==;
X-CSE-ConnectionGUID: 8TLmqFsaRZ+VTkwT5FLeow==
X-CSE-MsgGUID: QXL+3sw7SCuwSVWuExL9BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26215718"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="26215718"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:05:55 -0700
X-CSE-ConnectionGUID: zT//zSEHRCm7FOrh0st2hA==
X-CSE-MsgGUID: 8igXAg42S/2CPdwk8GNhRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65453230"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 00:05:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:05:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:05:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 00:05:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 00:05:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=So/NcPzaXHJikO3FoHolYh8rSEYaWMl982EXKLt1sl9j+UzKBQ/wGcy0McxhmQojGZCH/+uICwFfG6LpWc5AVxnt0q1qKgnBeA4ia6s8u9PgClFmeSz5Z4yKASvkBV+aXVnInkqWe0SEpQNM0HrF04vzS6hl4XCI5W8bVZJmlnJCePjNloB2r3TDmH3MLNgT7X3aNEB8J4TW7zqO8AbhR2E6pIRK385/0R4zkgUh3zn4r8XU7UWOSei50hqjofCOPc4C8x/vHNDNB1StGjYuSxojHG7I+7EXKf59SxvjtgZz2NyPQ7h1cbuuDDLQdhXXGKWbhmch6Ap6RhoX83l2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9h2//5ET6MKRgHFpSRtnNFKKrC9JzexpHYa68c0liU=;
 b=ZkItGihQqJl10m77ieETrNl7OllbI48K2FR3VGJK6dOJhblgz0wWMbJUbZVotipkforRN29nerCsIHlVK7lZ45XAIjwTNcejdcY0O7PujArvcNFkAh01nazWqi4pt8zEITxnkrWUmUUnUPxBsp9hcXiDtF2CtzanHil7vY3PtS8XvXkexNi5XvELMBGL/IwAO3QnKIcFcs5I5fo8vgH6+jtWJ2YEn3I4aydr/mqQcw923sZ0GL2529J38AYP9bRtlMqLulY71zkfuDEpuImx/VYThFRxE0HHCVv5y4w9wYWcKLFKFWy+KvXz3cpSf+cf2zpWLRVjqwhhg8XBAqUPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 07:05:51 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:05:51 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 05/14] thermal: core: Move thermal zone locking out of
 bind/unbind functions
Thread-Topic: [PATCH v3 05/14] thermal: core: Move thermal zone locking out of
 bind/unbind functions
Thread-Index: AQHa8lKt7Vuzwpgj3EajjN5FC5LtCLIvuiCA
Date: Tue, 20 Aug 2024 07:05:51 +0000
Message-ID: <eafd7c9056ab3d691cafe2db136135abd2d7ed81.camel@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
	 <3837835.kQq0lBPeGt@rjwysocki.net>
In-Reply-To: <3837835.kQq0lBPeGt@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5125:EE_
x-ms-office365-filtering-correlation-id: 5f50480e-3723-49f0-1cc1-08dcc0e68687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cXg2bFo3M0orQktub0JBNks1c0FBN2lXOSttb2pSTmxZVUpQSThBT3B1WDdZ?=
 =?utf-8?B?SmRFSGpRUDg4bkFMMUcyYUdVZzhsTmp4cmZKSllXSHlNM3JsWHZEVmhnMy8x?=
 =?utf-8?B?UFdSM1dPTkRqdDAraEI3L3FZSXBlNHkveVI3bTc0dTlDbmxDQXhFcWJBZGlz?=
 =?utf-8?B?NnNJaE9QOVNhT1RhN0pMa3NOQzdFeURlQVVnNDhhQWhwWGdEZmxqODUzUUM0?=
 =?utf-8?B?bW5rcm5OSXA4S3N2OUVhd1kzZjNHdmNKVGpQMEVIeDhnazZ2L2dyd2NBZ0l3?=
 =?utf-8?B?MVJ2NHJxUE5ydkE0eVB5SnBTY3NlbE1wcGdSOVB6bDBBT0pJUkZXeFlaazlj?=
 =?utf-8?B?M2Mzdi9vUXJoNjJTbk1VNlFwOGhEaTVEdEJTd1Q5K21jZmFFeHhyWWFadmNW?=
 =?utf-8?B?WEthOGNldkt4ZXFoOTNSNnFIK3ZBckNNOEZIUURKVzdQNllsTVppSGkzMU9t?=
 =?utf-8?B?YVZuUWpMbm1WN0dzREl2dzU3NG5hM05OZEY3WCs1Rk5BRWJCVFBwdktYUzFi?=
 =?utf-8?B?aUFteWgzUHRBR2QyN0d3ZTlGUGFrTnNzZkNBS3NRRXRvOXNhNXdJRC9xa1R4?=
 =?utf-8?B?UFVyakFVL09QUExSeUxIU0x1Z3p0RzFxVldaZlA2YzQrYVViUEliV0haS080?=
 =?utf-8?B?bDFJWG1yRFBYWXYvUVFyTzNzbFBPM0Q4aWVQYzFEVVQ0LzBpVlh0Um0wNUEv?=
 =?utf-8?B?Zy9DTHNMWi9GNGNJdFh1cU5oWE1aZTFoZVg0Y3Vzdy9ac1l4S2dJeXF6Q245?=
 =?utf-8?B?Z0UxMlN0SVJXYVVwVTMvbW82ZTJGSU1SVlZvVFdZT1ZJTXFncXVMeG5ZZ3J3?=
 =?utf-8?B?ZTVZQXlxQWVqN2ExTHBDSVdsVGJVbEVacjFOSXYrK1E5M1ZlNDdBczlZSnhr?=
 =?utf-8?B?VFVMTm15R3NvQ3N4dWZ3Y3N0aVVudkVzV1V2aDQ5SFNHNzJYaTMrZ0tkUHRF?=
 =?utf-8?B?WFJDV0g3RytXV29sMFl6WmZMbndyT2IwaXoyaTBkSE1ZeW9YbzZsb3JpeXJD?=
 =?utf-8?B?QkhobWZsNFFJTmt4S05OaE1yRkFEK2l4QWROSnZmdkE0enRNRkZzSVZTSEkx?=
 =?utf-8?B?T1AvYjg1VElXWmRpSTBLZU1jcnVRY0ZDQmZlR0hSODc3QzN4Z2JSYlBxSTY1?=
 =?utf-8?B?SithNlhkUGswbTdtRnBVU0ZnV21ydHVFUldRMEgrNk9wMzZNN09QRkJuMVB2?=
 =?utf-8?B?U0VCdzlLM1JUcG1ueWtRMkdpRFVORlJYdGpoT1lDOFBOQU94STJ6TVNuTmtr?=
 =?utf-8?B?RTQ4c3FJemFPWlFhN3hDWjFQWGx2K0NBREpiR0NKOFQwekhUd0hueUVOeUcy?=
 =?utf-8?B?UnFJYnh1ZVE5YXgyRkxUOHZVcXVqWG15WUFYZnB4SzlqNUhlSkF6N3YvZ1Np?=
 =?utf-8?B?alAvVTByQkNNNWp5ZU50KzZEclNhR1AveVRIUjJhaGpZWkF4NFRsTmtZRGds?=
 =?utf-8?B?T3doMkZJQjNlYmoyTENRdkI1T2ZDQ3BaVzRER1Z5aGhJT244K2wyV0Jvak9L?=
 =?utf-8?B?MklmMSs2NDhBUllLV1lpYm0yemJtaElpSDUvRDBadGtPNUFZMExlTnNVVHRw?=
 =?utf-8?B?b1NpcnJHSEFlZkp3SUJMSDJGMnpuYkwzUi9RVE5XUDh5eHl0WDIxcTJ5aGtq?=
 =?utf-8?B?NWpLVjlHbnp5S2t4MUZPMGl1VjVrNjF1VUVLanN1b0p2eDdsbUVaWjBqRHRN?=
 =?utf-8?B?SC8wSHBQWDYyTGNRcHp4SkNGcDh2T1BwbkxiZ25MRW9YZGxMMm5nTytPTEpm?=
 =?utf-8?B?OTRwdzVQMVFBbEU2eWM3VTh6OHNnamdGSzVMOEhaNHBZeEhmWjdGaENObCs3?=
 =?utf-8?Q?4jR7ELxH0YkCnWuXTw8D02hdJKLizcVAptsGs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFA5eUlzSTZwWWhnUWNPb2RsUkttajg4RGtyd2l5Y2Z3VS9Bak9xZ3JOazQ3?=
 =?utf-8?B?MW93ZmdvWlpwRlgxRGhpVXJmZXkwMmJxcUk2S0FRTHJjbXMxZlV3S1AxZmZW?=
 =?utf-8?B?M242RlRBOWpqRjFJVWZ1TzdCNkg4MU5yRFFjekkxQ2lINzVhaUFHS0tCQk9S?=
 =?utf-8?B?REZMU3BIZ3BYb3hGYmtYQUFBNWZWVytlUjNlallya3dDV21HRkRxeVo4R2ZN?=
 =?utf-8?B?V2NXcTZqbi9MZ0V4SFNqUUFMQ3lSVWhlLzJYY0h2Sy8ydmtpVEc2a0J1VEZI?=
 =?utf-8?B?UnlOcE0xZGJjRzdiZmtuNHNBOS9DajlFazdOZ0Rrei83TVVLYVJvdURGSDBG?=
 =?utf-8?B?OFlrVGU0U1NBV2Y5dlA3N0ViKzBuSGtmd3h1K3B2aWdSSis1eGcrRjVKRTVv?=
 =?utf-8?B?SHFNaHE5MmRxc0dUUGg3NDFpUlZwUEhoRGROZ0FIZk0renlOYjNYWnhlTElR?=
 =?utf-8?B?bi8yangwYzBNcC9RNUwwaDU1MnRzVVdTTHA1Q1dSMGRYWnFEMGNUK1A0c2NL?=
 =?utf-8?B?Z2hmZm11NG1RQ1BVelI4em9yakl4YURWN1QrQXBuRXV1UnJ3S3MzTEdwVnhG?=
 =?utf-8?B?bFNPZmt0eWlDaGlsSkJId1c3aGtDNTI0Tmc1YmcvTlhNNVVNZU1INjZYNjZB?=
 =?utf-8?B?NXEzbVB0bGpZT25sMFNtU2xieEdSQmViRzVoN3ZsNW10cUZtc0tXODd3bER3?=
 =?utf-8?B?R0g2elFkR0FJQ212bnQ0V201NW5hdVlWMkg5Q1RvYk1MSGRZUTdCUnBEQ2Fk?=
 =?utf-8?B?eDFLa3Q2K1JjbldRcHVRRlQ5UlIrM3RlclJpOUNDZHJGS05XNFBGSWJEcElB?=
 =?utf-8?B?b1FSNjFJM3FJNmk5ZmM3dDlwZTN0aEtBT3BNdzI1UHIvb2VrbkRKVm8rSVh3?=
 =?utf-8?B?ODl4N1AwT3kyNFkyczIyaTRZVkRBRCt5WVNhQ3NRTzRQTjFycWZVRXp0Sm9I?=
 =?utf-8?B?dnROQVI5MG1UbUw4dVFUY2Yrc0FwWDVLalhFczJnZWdNc0FpYjFEcHZVelFC?=
 =?utf-8?B?QldnblY0ME1Qdy8rS0FMTU1hQkJBUm9lbFpxQjd0UE9xT0J2MGpqSVQvb3FB?=
 =?utf-8?B?d2RvMEMvb0piQ0U4TWJ5ejBVWFMrTHJ6QVRXUFNsd25nckpnZWZENnZDRkhl?=
 =?utf-8?B?VFA0N1lXZmZBeGxuanVWVEtZT1p5TVM0cmo1TGNVL21HNWlsdzFGZnM4Qmxq?=
 =?utf-8?B?MUI3MlZzcWc5bkVQaytJcW1DNmxKZjFOVGc0QW1CQmJFSlYwNGlWT1l5SndG?=
 =?utf-8?B?U3dldUNkWXhsQXhWVE5DWlhUc2F4RytBRStXVTJPeWMybnpsMFBZTzF1OUtm?=
 =?utf-8?B?T3ZZaHYzdHVjSEIwVFhnaXhwd1FGSHBIc1Ywam1OMGdVcVFUeWNHaEFaM2hk?=
 =?utf-8?B?aFg0NlB0Y2Mydm00UytxUlhXc0FMaXdhSDFQZU1EM0psWFVhcjhGT2wwNDVT?=
 =?utf-8?B?NDM4M001S2JrYVJRNjhWNERVN1ptbWVOOUROTG50NDMvQmdJMTZ3RDNiRlN6?=
 =?utf-8?B?M0MrNkR0a0cyUndoQUFlYzVJT3pXNHpzS29Sb2diNUdNeFpIallxOTI4QmN3?=
 =?utf-8?B?NmFZelhhVi9lNHpEa0lYQXExQ3loRXdvWUJVMXZSd3UzanE2K1N5ZVJVQXJV?=
 =?utf-8?B?ZmNaanVNaklncFF6OTA1QURxVWs3SnFLU2dqVXdNZmFYNW00NkNDaG00bWox?=
 =?utf-8?B?K2MrTmQzYXBraDA5d0dPdFF3Ym5aajBmNCtlQ0JZeW5NSzZzVU1yWlhuRnJH?=
 =?utf-8?B?R1l6Z0pRL3lyc0lRejJyMlNTZFFLTXFaN3YxdlE2ckU5MkhPaXRIZWljcWly?=
 =?utf-8?B?dU1nQ1dXcHlCZ0xnLy8vRTE1ZitiWFVhRFFmZ3RSaW1FTjZpd1VXQkNibmhT?=
 =?utf-8?B?OUMrOFhVS0FwM0ZNc1dpQ2FpVHFOd1VSdGFqS21vR2lSMVhWalRBdkxqdjlr?=
 =?utf-8?B?NmRIdmhjOFVTejMzZHVBOXVuWHR0WlkxWm1yemtpTkZwQmFDM0t0ZGR5QWky?=
 =?utf-8?B?cElkOEZvQlZ2VFJ2WVdjbHBkbnY1aitObStQb1hzQW9RbnNMcVF2NWNSMG1k?=
 =?utf-8?B?Q2lRUjhISFgyUDZWZWdSd2JyWFV5d0NYNlNFRC9jYzM0Q25pWGMrcVNlMUc2?=
 =?utf-8?B?eU9yVStjWngvNmJpSkNXNk5zSENYeVgzMVdheVRuUVhMWVY5Z0t4Q09tbGU1?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47FC6E31D49A134E97DC7DD05EFD1E19@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f50480e-3723-49f0-1cc1-08dcc0e68687
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 07:05:51.1528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVGF4wc4/1xN80z4y7Yg17KZhGOvIDbujEhfzCBpQ0VyOyMRM5D9ANZiilJuHgdzr43X5YDpDztNWXsNmPIoaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDE3OjU4ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
Cj4gCj4gU2luY2UgdGhlcm1hbF9iaW5kX2NkZXZfdG9fdHJpcCgpIGFuZCB0aGVybWFsX3VuYmlu
ZF9jZGV2X2Zyb21fdHJpcCgpCj4gYWNxdWlyZSB0aGUgdGhlcm1hbCB6b25lIGxvY2ssIHRoZSBs
b2NraW5nIHJ1bGVzIGZvciB0aGVpciBjYWxsZXJzCj4gZ2V0Cj4gY29tcGxpY2F0ZWQuwqAgSW4g
cGFydGljdWxhciwgdGhlIHRoZXJtYWwgem9uZSBsb2NrIGNhbm5vdCBiZSBhY3F1aXJlZAo+IGlu
IGFueSBjb2RlIHBhdGggbGVhZGluZyB0byBvbmUgb2YgdGhlc2UgZnVuY3Rpb25zIGV2ZW4gdGhv
dWdoIGl0Cj4gbWlnaHQKPiBiZSB1c2VmdWwgdG8gZG8gc28uCj4gCj4gVG8gYWRkcmVzcyB0aGlz
LCByZW1vdmUgdGhlIHRoZXJtYWwgem9uZSBsb2NraW5nIGZyb20gYm90aCB0aGVzZQo+IGZ1bmN0
aW9ucywgYWRkIGxvY2tkZXAgYXNzZXJ0aW9ucyBmb3IgdGhlIHRoZXJtYWwgem9uZSBsb2NrIHRv
IGJvdGgKPiBvZiB0aGVtIGFuZCBtYWtlIHRoZWlyIGNhbGxlcnMgYWNxdWlyZSB0aGUgdGhlcm1h
bCB6b25lIGxvY2sgaW5zdGVhZC4KPiAKPiBObyBpbnRlbnRpb25hbCBmdW5jdGlvbmFsIGltcGFj
dC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2Nr
aUBpbnRlbC5jb20+CgpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29t
PgoKdGhhbmtzLApydWkKCj4gLS0tCj4gCj4gdjIgLT4gdjM6IFJlYmFzZSBhZnRlciBkcm9wcGlu
ZyBwYXRjaGVzIFswNC0wNS8xN10gZnJvbSB0aGUgc2VyaWVzCj4gCj4gdjEgLT4gdjI6IE5vIGNo
YW5nZXMKPiAKPiAtLS0KPiDCoGRyaXZlcnMvYWNwaS90aGVybWFsLmPCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgwqAgMiArLQo+IMKgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jIHzCoMKgIDMw
ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyMyBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+IAo+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJz
L3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMKPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gLS0tIGxpbnV4LXBtLm9yaWcv
ZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jCj4gKysrIGxpbnV4LXBtL2RyaXZlcnMvdGhl
cm1hbC90aGVybWFsX2NvcmUuYwo+IEBAIC03ODUsNiArNzg1LDcgQEAgaW50IHRoZXJtYWxfYmlu
ZF9jZGV2X3RvX3RyaXAoc3RydWN0IHRoZQo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmVzdWx0Owo+
IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGxvY2tkZXBfYXNzZXJ0X2hlbGQoJnRoZXJtYWxfbGlzdF9s
b2NrKTsKPiArwqDCoMKgwqDCoMKgwqBsb2NrZGVwX2Fzc2VydF9oZWxkKCZ0ei0+bG9jayk7Cj4g
wqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGxpc3RfZW1wdHkoJnR6LT5ub2RlKSB8fCBsaXN0X2Vt
cHR5KCZjZGV2LT5ub2RlKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biAtRUlOVkFMOwo+IEBAIC04NDcsNyArODQ4LDYgQEAgaW50IHRoZXJtYWxfYmluZF9jZGV2X3Rv
X3RyaXAoc3RydWN0IHRoZQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAocmVzdWx0KQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byByZW1vdmVfdHJpcF9maWxlOwo+IMKgCj4gLcKg
wqDCoMKgwqDCoMKgbXV0ZXhfbG9jaygmdHotPmxvY2spOwo+IMKgwqDCoMKgwqDCoMKgwqBtdXRl
eF9sb2NrKCZjZGV2LT5sb2NrKTsKPiDCoMKgwqDCoMKgwqDCoMKgbGlzdF9mb3JfZWFjaF9lbnRy
eShwb3MsICZ0ei0+dGhlcm1hbF9pbnN0YW5jZXMsIHR6X25vZGUpCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBpZiAocG9zLT50cmlwID09IHRyaXAgJiYgcG9zLT5jZGV2ID09IGNk
ZXYpIHsKPiBAQCAtODYyLDcgKzg2Miw2IEBAIGludCB0aGVybWFsX2JpbmRfY2Rldl90b190cmlw
KHN0cnVjdCB0aGUKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRoZXJtYWxfZ292
ZXJub3JfdXBkYXRlX3R6KHR6LCBUSEVSTUFMX1RaX0JJTkRfQ0RFVik7Cj4gwqDCoMKgwqDCoMKg
wqDCoH0KPiDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZjZGV2LT5sb2NrKTsKPiAtwqDC
oMKgwqDCoMKgwqBtdXRleF91bmxvY2soJnR6LT5sb2NrKTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKg
wqBpZiAoIXJlc3VsdCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAw
Owo+IEBAIC04ODYsMTEgKzg4NSwxOSBAQCBpbnQgdGhlcm1hbF96b25lX2JpbmRfY29vbGluZ19k
ZXZpY2Uoc3RyCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgdXBwZXIsIHVuc2lnbmVk
Cj4gbG9uZyBsb3dlciwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IHdlaWdodCkKPiDC
oHsKPiArwqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHRy
aXBfaW5kZXggPCAwIHx8IHRyaXBfaW5kZXggPj0gdHotPm51bV90cmlwcykKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwo+IMKgCj4gLcKgwqDCoMKgwqDC
oMKgcmV0dXJuIHRoZXJtYWxfYmluZF9jZGV2X3RvX3RyaXAodHosICZ0ei0KPiA+dHJpcHNbdHJp
cF9pbmRleF0udHJpcCwgY2RldiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVwcGVyLCBsb3dl
ciwgd2VpZ2h0KTsKPiArwqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZ0ei0+bG9jayk7Cj4gKwo+
ICvCoMKgwqDCoMKgwqDCoHJldCA9IHRoZXJtYWxfYmluZF9jZGV2X3RvX3RyaXAodHosICZ0ei0K
PiA+dHJpcHNbdHJpcF9pbmRleF0udHJpcCwgY2RldiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
dXBwZXIsIGxvd2VyLCB3ZWlnaHQpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2so
JnR6LT5sb2NrKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDCoH0KPiDCoEVY
UE9SVF9TWU1CT0xfR1BMKHRoZXJtYWxfem9uZV9iaW5kX2Nvb2xpbmdfZGV2aWNlKTsKPiDCoAo+
IEBAIC05MTIsNyArOTE5LDggQEAgaW50IHRoZXJtYWxfdW5iaW5kX2NkZXZfZnJvbV90cmlwKHN0
cnVjdAo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdGhlcm1hbF9pbnN0YW5jZSAqcG9z
LCAqbmV4dDsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJnR6LT5sb2NrKTsKPiAr
wqDCoMKgwqDCoMKgwqBsb2NrZGVwX2Fzc2VydF9oZWxkKCZ0ei0+bG9jayk7Cj4gKwo+IMKgwqDC
oMKgwqDCoMKgwqBtdXRleF9sb2NrKCZjZGV2LT5sb2NrKTsKPiDCoMKgwqDCoMKgwqDCoMKgbGlz
dF9mb3JfZWFjaF9lbnRyeV9zYWZlKHBvcywgbmV4dCwgJnR6LT50aGVybWFsX2luc3RhbmNlcywK
PiB0el9ub2RlKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocG9zLT50
cmlwID09IHRyaXAgJiYgcG9zLT5jZGV2ID09IGNkZXYpIHsKPiBAQCAtOTIyLDEyICs5MzAsMTAg
QEAgaW50IHRoZXJtYWxfdW5iaW5kX2NkZXZfZnJvbV90cmlwKHN0cnVjdAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRoZXJtYWxfZ292ZXJub3JfdXBk
YXRlX3R6KHR6LAo+IFRIRVJNQUxfVFpfVU5CSU5EX0NERVYpOwo+IMKgCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZjZGV2LT5s
b2NrKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG11
dGV4X3VubG9jaygmdHotPmxvY2spOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGdvdG8gdW5iaW5kOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgfQo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqDCoMKgwqDCoMKgwqDCoG11dGV4X3VubG9j
aygmY2Rldi0+bG9jayk7Cj4gLcKgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZ0ei0+bG9jayk7
Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9ERVY7Cj4gwqAKPiBAQCAtOTQ1LDEw
ICs5NTEsMTggQEAgaW50IHRoZXJtYWxfem9uZV91bmJpbmRfY29vbGluZ19kZXZpY2Uocwo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaW50IHRyaXBfaW5kZXgsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZQo+ICpjZGV2KQo+IMKgewo+ICvCoMKgwqDCoMKg
wqDCoGludCByZXQ7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAodHJpcF9pbmRleCA8IDAgfHwg
dHJpcF9pbmRleCA+PSB0ei0+bnVtX3RyaXBzKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gdGhlcm1h
bF91bmJpbmRfY2Rldl9mcm9tX3RyaXAodHosICZ0ei0KPiA+dHJpcHNbdHJpcF9pbmRleF0udHJp
cCwgY2Rldik7Cj4gK8KgwqDCoMKgwqDCoMKgbXV0ZXhfbG9jaygmdHotPmxvY2spOwo+ICsKPiAr
wqDCoMKgwqDCoMKgwqByZXQgPSB0aGVybWFsX3VuYmluZF9jZGV2X2Zyb21fdHJpcCh0eiwgJnR6
LQo+ID50cmlwc1t0cmlwX2luZGV4XS50cmlwLCBjZGV2KTsKPiArCj4gK8KgwqDCoMKgwqDCoMKg
bXV0ZXhfdW5sb2NrKCZ0ei0+bG9jayk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7
Cj4gwqB9Cj4gwqBFWFBPUlRfU1lNQk9MX0dQTCh0aGVybWFsX3pvbmVfdW5iaW5kX2Nvb2xpbmdf
ZGV2aWNlKTsKPiDCoAo+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL2FjcGkvdGhlcm1hbC5jCj4g
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQo+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvYWNwaS90aGVybWFsLmMKPiAr
KysgbGludXgtcG0vZHJpdmVycy9hY3BpL3RoZXJtYWwuYwo+IEBAIC02MDksNyArNjA5LDcgQEAg
c3RhdGljIGludCBhY3BpX3RoZXJtYWxfYmluZF91bmJpbmRfY2Rldgo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgLnRoZXJtYWwgPSB0aGVybWFsLCAuY2RldiA9IGNkZXYsIC5iaW5k
ID0gYmluZAo+IMKgwqDCoMKgwqDCoMKgwqB9Owo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJu
IGZvcl9lYWNoX3RoZXJtYWxfdHJpcCh0aGVybWFsLCBiaW5kX3VuYmluZF9jZGV2X2NiLAo+ICZi
ZCk7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHRoZXJtYWxfem9uZV9mb3JfZWFjaF90cmlwKHRo
ZXJtYWwsCj4gYmluZF91bmJpbmRfY2Rldl9jYiwgJmJkKTsKPiDCoH0KPiDCoAo+IMKgc3RhdGlj
IGludAo+IAo+IAo+IAoK

