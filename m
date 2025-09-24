Return-Path: <linux-pm+bounces-35277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A5BB99A0D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 13:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0F94A62CB
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 11:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D822FE068;
	Wed, 24 Sep 2025 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMp4rYh1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBFC2FE050
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714277; cv=fail; b=gO8nmn/IF305+MBtDGwK5AAy6WoKa0hBzS4H+ETH9+xu9YhmfXx5wpeN0g8tBhudOIcx5npM8m1viSsIuEyqEkmtJO9e4GQBVYh3oeFQJVDd2NQJrGq27dMkKP8ZdlBbIk6YGAxGy5fhNGA5AzB1zQ7JZd9A/aVlo0D46J1e5D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714277; c=relaxed/simple;
	bh=lFUCAcHUW2r/BRImBbQAqI+6a6QuHn/WJHQMFtUOde4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bsHi2Wf093m0wZctfL7SB4lgJImaeGxbMtQ7QZSQVc9bvL78hOqLVm4AKo3ezB/eHPMOTOQT72dO6yzjZ4iLU5mDQ3OmprA5T45hYt95rmZTe97V9AWB7FTJ7bZv6oH0cSN5TnGHYHfqiTMho3XFXyJnNbPKeoehlxXa/Tz9uww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMp4rYh1; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758714276; x=1790250276;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lFUCAcHUW2r/BRImBbQAqI+6a6QuHn/WJHQMFtUOde4=;
  b=eMp4rYh1eW8smKjtsu3briN1bZgBzzC9YhgxgZ+qrKvVgv5TAVHmuZvN
   IG6y7YsFKPLRi8FKeVmYnzCPJqISxnjUlm+Q+fApAo61dYbrP4ADhG0TE
   0EcLwC3qTa66j1bCPtTT+QLwS9bsVuLIKCjcKck0YZj+5qeMa1+XK1Ine
   v9hpqsu+xoyD3OCqfrUtxdAg++kLEhrQmSGMGypApAO/P+1tfhFY/LqLB
   5q7LDjWVjDb0Gzec110PEkheWEWcgnQRESDIGzEEhdYlTZtpERAgZCwFJ
   qfQBL8FXOX6FzbHjZQSx/5nHAl6hm2L2P4ebYtlh5mMSGyg8U7lQNPSXk
   A==;
X-CSE-ConnectionGUID: WvCkAigYR4uC0B4qcoJhHQ==
X-CSE-MsgGUID: UpZDviPVR3CWz3JnbWoOTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86451004"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="86451004"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 04:44:35 -0700
X-CSE-ConnectionGUID: LAx4rNTETOS8k3XzokdV1Q==
X-CSE-MsgGUID: IyepWK//S/asHAo5xywPQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176851700"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 04:44:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 04:44:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 04:44:33 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 04:44:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTKuUGmY6aHbTDLN1QNLKKVlUr5van3PASNWpnmYhojlujfKSeSfF+XVFHnhoinscpF0wdY2ylD0n2f854pzCEche9tVAYbfmj9bVU684T49VwoYBMO0S36+39NbXJXtuGU0J4XPrumgDiO9DqpHLGJbeQtxxdjIHRvh8F81FQPhnS/hRi23/uVTKDDQZP59v27xVDm5SbonigiEi+vX6IzaeK+tTpFqfrkXG5T4ula58l7mUYSkf2qQ8LLVRjt4qLvlAceAWEI5mErAgZd+Uiy4dBTrxgZg1FZEhr9cRSZx0kMrCHexPdGc00HRrgKIyiZ0GePUsUNGCdMrrW/dMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFUCAcHUW2r/BRImBbQAqI+6a6QuHn/WJHQMFtUOde4=;
 b=GUQ3MLk+uiBZkYpl9m100dzE+5Uul+EbO2ktFYhUILyXfSGi/JvH1dheXFj533ywDQ/9gqOX1nTACekosfKHlAKiGjcx7XCErA5cuzgnieNdKxePSTvoIvIF4S54PB3EXW3gDEPCkzIJZNBmOGv9Oe8BUOl8/3WSSFrVbzBA3J/SlDVqIj8RACh2d+PcMZVb1lYXviOSizRppcrcZsb9RSKDE+GByyYzuoSAJ8mCvl18llqC8eNOEvbCixSfu9Hnru+cB61ONxkT00JpTnVwN4KwUUDrMJ/FahCC9u8gu7uepKS0emNOtQsrAhqwK4+PYbOajgDTiay1n9iaLA/Gpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by PH3PPF058255456.namprd11.prod.outlook.com (2603:10b6:518:1::d06) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Wed, 24 Sep
 2025 11:44:26 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 11:44:26 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "pavel@kernel.org" <pavel@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "dakr@kernel.org" <dakr@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] PM: Delete timer before removing wakeup source from list
Thread-Topic: [PATCH] PM: Delete timer before removing wakeup source from list
Thread-Index: AQHcK+j0aZNN1Fuc4E2edmZTAlGrq7SgMOgggACDIACAAQa60IAAbNCAgAAQ7gA=
Date: Wed, 24 Sep 2025 11:44:26 +0000
Message-ID: <LV3PR11MB87681815B46313263AF6850DF51CA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250921042537.3118333-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0joEhp9rt1WfN6eHfnuw_d2zrWFvd=Mn4NXRqO41xhsEQ@mail.gmail.com>
 <LV3PR11MB87682A511B8C0ED226C3BBDEF51DA@LV3PR11MB8768.namprd11.prod.outlook.com>
 <CAJZ5v0iMrq3uWBWZLkT0jf7ja9jzk1AdvUCM-tGgx+8zQQWPvQ@mail.gmail.com>
 <LV3PR11MB87683634AEFDF44A845A9282F51CA@LV3PR11MB8768.namprd11.prod.outlook.com>
 <CAJZ5v0g-WkN8PdzFGVVNjVKyYK+QOubr9fog6iSO5frv9ZhGVA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g-WkN8PdzFGVVNjVKyYK+QOubr9fog6iSO5frv9ZhGVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|PH3PPF058255456:EE_
x-ms-office365-filtering-correlation-id: a508dd00-b6db-4668-f20b-08ddfb5fb6b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aGpIQzBBQk9VOVpZbnF2UHUxSkNyVmh3c1dtWHFvN0dGb080NlhhNjN0VnUv?=
 =?utf-8?B?TlhyWkRLSUdLT3hmYm16ZGFzUGdxRTVqc0hRaWpmNEpTNDlxNXN4K2t4Q2xG?=
 =?utf-8?B?NjFvY0JXYW5oR1hLd1FRbWY3L2xOSXdjWWRwd25BeHJXbWV3VTJLSlE2K3Fm?=
 =?utf-8?B?QWo2WGpMT0NJbVhwMnBneDExNlVCd3kvZzFaU3M2RVBrbHEvczRFaU5JRGhU?=
 =?utf-8?B?NVVra2xJMk5uODdzdnc1YkRxOC8yYmlFSTNRSXo2dHJqNWhvMWpLeHlzbDJV?=
 =?utf-8?B?WWJPc2kxdWZPMDJYeWIycDNsMVMybGpmNkZzM0Vkc1pnbzhMd2dxcHFwM0NQ?=
 =?utf-8?B?WDZKSVNQUGJSaTBNQWVMaXpERG5GVjQzR28zdkFNT3lzY1grS1RKNnRtbnJD?=
 =?utf-8?B?Ui96aThwWmQ1elVLcEQwQ21tZjZyVGZNQ1Q5MUdKL2IyUVVFelpHdm85bHkx?=
 =?utf-8?B?MFROT3ZuZno4WDNTUjBEWEZrWmxvZWJlTnR5YmZqa1FKTGQ0U09PZEdTVXUv?=
 =?utf-8?B?S05kS1ptcGZSWWszNjJVb08xSXR4S0V5amIzRHZwTWFRQlhVQ3ltd0IzNm4z?=
 =?utf-8?B?bXc0ZkE0bFlkR3p5ZGptSXplVzdrUTFOaldjM202eWcvaVlhYWhZZ0NpMDRx?=
 =?utf-8?B?QkI1Ky84V0NKZ0dUR0F6S2xNQlA3Zkx6WFVkMEo5SURJQjRhTEJiZmFpQWw3?=
 =?utf-8?B?M1drZEVpb3lYdWV3d3kwNHdxenh2NExRdVNRVkVjRitScDZXV1ZGWC9ZdFVB?=
 =?utf-8?B?RFUyV1Q2MUk0aitKRGp6ZGpMdjlDNE9yWXgvWUg3bkkrK2w2VzBSQ016Q2Er?=
 =?utf-8?B?SklNblFlclZWZFR5elQrb044NWsxV2NJTldxQzdOQWpkL29YMmo3UGpiZHlk?=
 =?utf-8?B?d214aGZ3SEpIaEErRWE1bTkwc09nMnhKaFRTY25YYi9tYUt6SFZjMitJSWtP?=
 =?utf-8?B?Mm1DekQrTFVLcFFISWd0a3BvZXlaZWRWT3MwYVduaWJPZW9RU3lkWFdIMzRp?=
 =?utf-8?B?OG9vNUoxQ2JHQ3hwM0JHVFVOd2E3RlBGdkdia2VvS3ZBUFpVb2VEM1BsWEsz?=
 =?utf-8?B?cGtZMjB1Zm9oR2llQ28xQXZ5ZzM4M3FxZmJ4Tkh6UXIvQmRYd1R1YlBvTUls?=
 =?utf-8?B?b0taN1UwWVorS28vVlJnNkNUZG1uRDZiMU9wQ29GRzhVV1kvdk03Ri93bDhh?=
 =?utf-8?B?VHlZS0NWNnBQNkNxd0pMUjJoeG5CVDl5MUxudHM4eE1aZDBWaVdkV2FjdGIv?=
 =?utf-8?B?czEyOUU0bTA2dzQ3cnFmVVVZN2U1aEw5M0xoaG9OdHphQUNxaitPWEwvU1hF?=
 =?utf-8?B?WlJrOWRsYnlpaU8vT0FubDVjZkErZnV5UXJySi83R1ZmM1orY01FaW5zcFBI?=
 =?utf-8?B?UkZid0V6c0RWOUE2bHR5blVEM29WRXQ3S0dpaXQvY3paNWR6TE1zb1dBdmM4?=
 =?utf-8?B?Vno4MTRpRXBuYUdIZVQ3cXNrSTE1cjlNbk1VNU11L0NBTG1ZR0VQMks4ZnVC?=
 =?utf-8?B?djJnMmdOS281cjZLVWRhVzRTWVhtbi9rSnptL0tzZSthZ3FxTWFQb0wrZHZL?=
 =?utf-8?B?RGN2UmpycElUN0labDRoaGhrSjZJQmNhRUVsSGlKZVpjYXNDd0lzZFZQdVhL?=
 =?utf-8?B?dkxyK0I3K1V4dkE3a3pXalRMVExEdTJvb2xiaFNHWXgxcC9LNWRmR0xDd3dY?=
 =?utf-8?B?NldkaEN3SWpZOHdjdHRORWlzb0YxRy9yc0tFWkhLRDN5b0JCdnpJQ0x1c2JG?=
 =?utf-8?B?bjBJR0k0ZnZKam5wK2ZMS09tcHduWVloUlR2b1FNWEZLRDFGQ2VucVdZQTlY?=
 =?utf-8?B?eHFZUWt5VFdWMjc1UlNmUUxxM1k0UkNFQ0R5WUpxNFFJM3BCbFpOOW8ra2pm?=
 =?utf-8?B?ZWljUXQ5N29qcGk4dXErQjZhOEhvWDR0Q2ZGQWFFUUNOaTFSWXowOHNxRnQ1?=
 =?utf-8?B?aCtTRE9iRkpPV3E5emNpek5EYk02YW1Qbk9FZHRrWDJVNjVmbWJPRmsyc2k1?=
 =?utf-8?Q?1Y2qJhbQCphCdGFXtEURpymTOKTZz0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KytpQUlQeDZCZWR4S1NoWllMQXF0b3ZpaXlJSlZSa20vQVJ0dThHV2RaeVVm?=
 =?utf-8?B?TitMZVZXOGpCQ1pPS3l1UkZTaDROQzFUbHZGT2doYWdpL1dLWXZGb2xjd3Ns?=
 =?utf-8?B?SVF0YXhFSUh3c3plc1FnMUNmaGZOdjF4Y1FzMlByUXlzcFlzWVNGeklGNE56?=
 =?utf-8?B?MDFCZUxLWVpZR0ROa25XRHBtM3lBUjNLbXFhVis5L2l0eGFBbmxmclpoUWpq?=
 =?utf-8?B?R1hjdlhpWkpQNXI4V1QvZ3R3aW5kbUdMWWw1bXIzTDdTS0ZUNVZqRG5hai93?=
 =?utf-8?B?S21TL08rNTB1d2lxNjI2Yjg2SlA3eVJoVkpCcW9TTkJGWkVESkljOXJmOFAr?=
 =?utf-8?B?cGdVRlhiUDV2TExQQXNnWS9sZ0tHV08xbnRrd1RsWHQ5alBPVHprNlVUTnly?=
 =?utf-8?B?RStmVDcvTXlaQVF4QVVQSTBsN3pMZmg4T2xTa3ZxcmdsWmY5bUNNQTVVek1U?=
 =?utf-8?B?YnJlS2xuZm9NdEt3TG1Xd3puU0pGTElEY0ptekNrNXpESkdYS0RybzhZMG5i?=
 =?utf-8?B?bUU2bjZtSTBObzlTdXJDSS9KT1AzRERyY1ZjTnQyTVkzYk9kVnJzL293NkJK?=
 =?utf-8?B?N1ZVTmNWc3RhTGN6OEpnODZUQ2N6clVGVUJBL0kyckt0SHZtSDlQRHAvN0ZX?=
 =?utf-8?B?RGV4Yk8rVlQrQ01vUmcvcHdFM3JaYXZsaEEvYnRVTTlNMlJkaktidmFFanlw?=
 =?utf-8?B?VCtsRDNOVVppbkVvWFFtN0YrMDhpeUxDZ0MwR3V1cHNWbEFuS01VelQ1bTNL?=
 =?utf-8?B?Q0pFemNLZ2FYekJKclpVNFRWaW9xMXdCN1RoUUhZSGVLUnNsSWllR0JZY2Y2?=
 =?utf-8?B?NHpiVDg3UlNJNm5ZcXNPbHlNN0JLamhpa1NjYzVYbEk3a2pqbGNZdmdzTDgr?=
 =?utf-8?B?ODlqYUtkTTN4M3RHYWhWdFdYMUtEdkRjd3pkNTJIenNKNlN2VGMvMFRLNUJO?=
 =?utf-8?B?WG45RU9lbGRyMVpTUzBGblhveHhjcnNXdUFqTkw4eFFqZjN4NzBqY0Y0VlJR?=
 =?utf-8?B?cENJR0o2NXlOMUlCb01NNUpObFc2YkRiQVBLazVLMUNHUng4amtMOEdQSnUv?=
 =?utf-8?B?M2cxVGY2TDdFOWswK2llamhrck9odkQzYUFzVFMvTHp3R2FhRmhrV0dZK0pI?=
 =?utf-8?B?Yis1R3AxQVJIamdnQjF6TzVNdVZZcVJ5Z0ZrWVd5ZUxrblJMUjFxL0pKZStD?=
 =?utf-8?B?emJaWWxvQVA0bXR0SERxZE8xWFZqaGN2ekJweGlJTXk0eWNRU3NNZFR3VU9P?=
 =?utf-8?B?UW1lU1hXNEVHRGlEcysrRlBncTF1VUdxR2FWYVNYNDFOQTJFSUdCa3ZyQXhm?=
 =?utf-8?B?eVZVTkE0TkxjdTRGWlVySHVhZkZPQlhaZjFFaEU0WUs4ZzhOcnU5Y1VYNkZp?=
 =?utf-8?B?L1djS2UvZDZ2UUdPV0xkaGNKWmFEMzR1TE1nSThuNHE0cVI2dzU5dFdRU0R3?=
 =?utf-8?B?UStKUHVOQjNZa2VKSHFJblJSdWF3RXdNcVU1SzhIQVpaaXFmdDdkVW95NGdl?=
 =?utf-8?B?eVRuQkFicUN5RTE3SU5JbXRuTjZyS0pvRVoxQ0o4TndJNFFiOWR2cTVlczM3?=
 =?utf-8?B?UlVrK1NERXRVcXhlS2wwZGJ6b1c5Q2hSSHYxWjlwTmZBZGdQaXRMdWZMaklZ?=
 =?utf-8?B?ZmRDQ2w4SEpmdW04VFMySUZyWmxwWllqT3lOZmIyTDN2QjFkUmJQUWFyU1NK?=
 =?utf-8?B?Y0lyQVdKOFl3SGZ2elhXRVVSakFvK0ZPZTByd1dLK1FCR05jdzVmU280L050?=
 =?utf-8?B?NldWeHZGTnlJU3RCYlp6bjZSQnFaakhGS1ZkdVZZWDQ2K2NVaGFxUldpcU1E?=
 =?utf-8?B?a1ZWM3F0aWp0eTJmRURYakxoZzhrL0d0akJrL1JGdjVCazhtQytvY0NrVHI1?=
 =?utf-8?B?Qm8rQkc4TUJ5dnpsb2wvMHpBa3pPWXlJK1VJdjJELzB4dXhsYkcyZ0tPWXpt?=
 =?utf-8?B?TTdISWxJemU0Nkh3UXZqaG0rSjNkSnhGeVJyTEdQSEpQdGhpcktYbURScWV3?=
 =?utf-8?B?R3d4cjA5QjRaUENUanpyaXV6cGV6dkFRdzhlbWxsdXVMRm1SamtoQ2huWjUy?=
 =?utf-8?B?bkhRVlJCOWxmcG1NVUh0Y1VqZkMxWVdON094OU9XdUdpMmFmU0t6T3hBNkZa?=
 =?utf-8?B?a29tbXM5UTlqakFYcTZPcG5YWXlLNmJ5NzdMekpzN3RMWUhpMTIzWVc4L1A0?=
 =?utf-8?B?dlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a508dd00-b6db-4668-f20b-08ddfb5fb6b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 11:44:26.2094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PIE6vQinX6+1moLRGwzoXjdvqmhx8Wf6EVxhSZSy0txlCN0Eryh4TZmF3+bXC6033UOyyC+0U+K3Z7XNHCHrzr/8wT4bPCeTL9bbjR7b0mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF058255456
X-OriginatorOrg: intel.com

T24gV2VkLCBTZXAgMjQsIDIwMjUgYXQgNjoxNSBBTSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6
DQo+IE9uIFdlZCwgU2VwIDI0LCAyMDI1IGF0IDY6MTUgQU0gS3VtYXIsIEthdXNobGVuZHJhIDxr
YXVzaGxlbmRyYS5rdW1hckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gVHVlLCBTZXAg
MjMsIDIwMjUgYXQgNjo1MiBBTSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gPiBPbiBU
dWUsIFNlcCAyMywgMjAyNSBhdCA2OjUyIEFNIEt1bWFyLCBLYXVzaGxlbmRyYSA8a2F1c2hsZW5k
cmEua3VtYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gT24gU3VuLCBTZXAg
MjEsIDIwMjUgYXQgNjoyNyBBTSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gPiA+ID4g
T24gU3VuLCBTZXAgMjEsIDIwMjUgYXQgNjoyNyBBTSBLYXVzaGxlbmRyYSBLdW1hciA8a2F1c2hs
ZW5kcmEua3VtYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBN
b3ZlIHRpbWVyX2RlbGV0ZV9zeW5jKCkgYmVmb3JlIGxpc3RfZGVsX3JjdSgpIGluDQo+ID4gPiA+
ID4gPiB3YWtldXBfc291cmNlX3JlbW92ZSgpIHRvIGVuc3VyZSBwcm9wZXIgY2xlYW51cCBvcmRl
cmluZy4gVGhpcyANCj4gPiA+ID4gPiA+IHByZXZlbnRzIHRoZSB0aW1lciBjYWxsYmFjayBmcm9t
IGV4ZWN1dGluZyBhZnRlciB0aGUgd2FrZXVwIHNvdXJjZSBoYXMgYmVlbiByZW1vdmVkIGZyb20g
dGhlIGV2ZW50cyBsaXN0Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoZSBwcmV2aW91cyBv
cmRlciBjb3VsZCBhbGxvdyB0aGUgdGltZXIgY2FsbGJhY2sgdG8gYWNjZXNzIA0KPiA+ID4gPiA+
ID4gdGhlIHdha2V1cCBzb3VyY2UgZW50cnkgYWZ0ZXIgcmVtb3ZhbCBidXQgYmVmb3JlIHRpbWVy
IA0KPiA+ID4gPiA+ID4gZGVsZXRpb24sIHBvdGVudGlhbGx5IGNhdXNpbmcgdXNlLWFmdGVyLWZy
ZWUgaXNzdWVzIG9yIGxpc3QgY29ycnVwdGlvbi4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEhvdyBz
bz8gIFlvdSBuZWVkIHRvIHNwZWNpZnkgdGhlIHNjZW5hcmlvIGluIHdoaWNoIHRoYXQgY2FuIGhh
cHBlbi4NCj4gPiA+ID4NCj4gPiA+ID4gSGkgUmFmYWVsLA0KPiA+ID4gPg0KPiA+ID4gPiBUaGFu
ayB5b3UgZm9yIGFza2luZyBmb3IgY2xhcmlmaWNhdGlvbi4gSGVyZSdzIHRoZSBzcGVjaWZpYyAN
Cj4gPiA+ID4gc2NlbmFyaW8gd2hlcmUgdGhlIGl0IGNhbiBvY2N1cjoNCj4gPiA+ID4NCj4gPiA+
ID4gKipJc3N1ZSBDb25kaXRpb24gVGltZWxpbmU6KioNCj4gPiA+ID4NCj4gPiA+ID4gMS4gKipU
aHJlYWQgQSoqIGNhbGxzIHdha2V1cF9zb3VyY2VfcmVtb3ZlKCk6DQo+ID4gPiA+DQo+ID4gPiA+
IHJhd19zcGluX2xvY2tfaXJxc2F2ZSgmZXZlbnRzX2xvY2ssIGZsYWdzKTsgbGlzdF9kZWxfcmN1
KCZ3cy0+ZW50cnkpOyAvLyBSZW1vdmUgZnJvbSBldmVudHMgbGlzdCByYXdfc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmZXZlbnRzX2xvY2ssIGZsYWdzKTsgc3luY2hyb25pemVfc3JjdSgmd2FrZXVw
X3NyY3UpOyAvLyBXYWl0IGZvciBSQ1UgcmVhZGVycyAvLyAqKiogSVNTVUUgV0lORE9XIEhFUkUg
KioqIHRpbWVyX2RlbGV0ZV9zeW5jKCZ3cy0+dGltZXIpOyAvLyBUaW1lciBzdGlsbCBhY3RpdmUh
DQo+ID4gPiA+DQo+ID4gPiA+IDIuICoqVGhyZWFkIEIqKiAodGltZXIgY2FsbGJhY2spIGZpcmVz
IGR1cmluZyB0aGUgaXNzdWUgd2luZG93Og0KPiA+ID4gPg0KPiA+ID4gPiBzdGF0aWMgdm9pZCBw
bV93YWtldXBfdGltZXJfZm4oc3RydWN0IHRpbWVyX2xpc3QgKnQpIHsgc3RydWN0IA0KPiA+ID4g
PiB3YWtldXBfc291cmNlICp3cyA9IGZyb21fdGltZXIod3MsIHQsIHRpbWVyKTsgLy8gUHJvYmxl
bTogd3MtPmVudHJ5IHdhcyBhbHJlYWR5IHJlbW92ZWQgZnJvbSBldmVudHMgbGlzdA0KPiA+ID4g
PiAgICAvLyBidXQgdGltZXIgY2FsbGJhY2sgc3RpbGwgZXhlY3V0ZXMNCj4gPiA+DQo+ID4gPiBX
aHkgaXMgdGhpcyBhIHByb2JsZW0/ICB3cyBpcyBzdGlsbCB0aGVyZSBhbmQgdGhlIHRpbWVyIGNh
bGxiYWNrIGRvZXNuJ3QgZG8gYW55dGhpbmcgd2l0aCB3cy0+ZW50cnkgQUZBSUNTLg0KPiA+ID4N
Cj4gPiA+ID4gKipTcGVjaWZpYyBJc3N1ZXM6KioNCj4gPiA+ID4NCj4gPiA+ID4gKipUaW1lciBh
Y2Nlc3NlcyByZW1vdmVkIHdha2V1cF9zb3VyY2UqKjogVGhlIHRpbWVyIGNhbGxiYWNrDQo+ID4g
PiA+IChwbV93YWtldXBfdGltZXJfZm4pIGNhbiBleGVjdXRlIGFmdGVyIGxpc3RfZGVsX3JjdSgp
IGJ1dCBiZWZvcmUgDQo+ID4gPiA+IHRpbWVyX2RlbGV0ZV9zeW5jKCksIGFjY2Vzc2luZyBhIHdh
a2V1cF9zb3VyY2UgdGhhdCdzIG5vIGxvbmdlciBpbiANCj4gPiA+ID4gdGhlIGV2ZW50cyBsaXN0
Lg0KPiA+ID4NCj4gPiA+IEFnYWluLCB3aHkgaXMgdGhpcyBhIHByb2JsZW0/DQo+ID4gPg0KPiA+
ID4gPiAqKldoeSBtb3ZpbmcgdGltZXJfZGVsZXRlX3N5bmMoKSBmaXJzdCBmaXhlcyB0aGlzOioq
DQo+ID4gPiA+DQo+ID4gPiA+IC0gRW5zdXJlcyB0aW1lciBjYW5ub3QgZmlyZSBkdXJpbmcgbGlz
dCByZW1vdmFsDQo+ID4gPiA+IC0gR3VhcmFudGVlcyBubyB0aW1lciBjYWxsYmFja3MgZXhlY3V0
ZSBhZnRlciB3ZSBzdGFydCBjbGVhbnVwDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBmaXggZW5zdXJl
cyB0aGF0IG9uY2Ugd2Ugc3RhcnQgd2FrZXVwX3NvdXJjZV9yZW1vdmUoKSwgbm8gDQo+ID4gPiA+
IHRpbWVyIGNhbGxiYWNrcyBjYW4gZXhlY3V0ZQ0KPiA+ID4NCj4gPiA+IFlvdSBtYXkgYXJndWUg
dGhhdCB0aGUgbmV3IGNvZGUgd2lsbCBiZSBjbGVhbmVyIChmYWlyIGVub3VnaCksIGJ1dCB1bmxl
c3MgdGhlcmUgaXMgYSBzcGVjaWZpYyBjb3JyZWN0bmVzcyBtYXR0ZXIgaGVyZSwgeW91IGNhbid0
IGNhbGwgaXQgYSBmaXguDQo+ID4NCj4gPiBIaSBSYWZhZWwsDQo+ID4NCj4gPiBZb3UncmUgYWJz
b2x1dGVseSBjb3JyZWN0LCBJIGRvbid0IGhhdmUgYW55IGV2aWRlbmNlIGluIHJlYWwgdXNlIGNh
c2VzIA0KPiA+IGZvciB0aGlzLiBHaXZlbiB5b3VyIGZlZWRiYWNrLCBJIHNob3VsZCBSZWZyYW1l
IGl0IGFzIGEgY2xlYW51cC9pbXByb3ZlbWVudCBwYXRjaCByYXRoZXIgdGhhbiBhICJmaXgiDQo+
ID4NCj4gPiBJZiBpdCBpcyBmaW5lIHdpdGggeW91IHRoZW4gSSBjYW4gY3JlYXRlIHYyIHBhdGNo
IHdpdGggeW91ciBzdWdnZXN0aW9ucy4NCj4gDQo+IFllcywgcGxlYXNlIQ0KDQpIaSBSYWZhZWws
DQoNClRoYW5rIHlvdSBmb3IgdGhlIGFwcHJvdmFsIS4gIEkgaGF2ZSBzZW50ICBhIHYyIHBhdGNo
IHdpdGggdGhlIHByb3BlciBmcmFtaW5nIGFzIGEgY29kZSBpbXByb3ZlbWVudA0KDQpCZXN0IHJl
Z2FyZHMsDQpLYXVzaGxlbmRyYQ0K

