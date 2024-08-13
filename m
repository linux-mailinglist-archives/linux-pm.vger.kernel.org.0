Return-Path: <linux-pm+bounces-12129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C3094FEE5
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 09:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DACAD1F23921
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9973969DFF;
	Tue, 13 Aug 2024 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVJcV5Rh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99696339AC;
	Tue, 13 Aug 2024 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534740; cv=fail; b=q95TRRxbtqGHhp3UEwKSEqUnCmBDA6EFa2TNS9M0SjmGAdQ7fOwVlyFHqor1Lwyg3zg+SkKjHDj4wLplyzPYwnsZRPtu6SuIiHjEasRK6x7d0pvcxHOvwdSUz0B0ikN50cKyJ8y3gDqlucb0Aj8kewZ4TMLMl4FO/wHyVLc/vsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534740; c=relaxed/simple;
	bh=31HLLK9pYjcLvlZ1XO8dfTx2YpstESAABc5aqwmUjeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pSpAZyeN9cK2oEpqNjOoG13vxqMWL7O7OX4PTROtMpbz3wIijcLuBHoXhiD7UA3bX8ng0udQdw0+74uXnS5CsILnqyMNkTkBfSqmFPVl2m/Jc6H78C/U86/FvqX85cDhnuqncspTkiJVMat+8Uo02SA8M/3/wr7IY5IFjitPwAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVJcV5Rh; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723534739; x=1755070739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=31HLLK9pYjcLvlZ1XO8dfTx2YpstESAABc5aqwmUjeE=;
  b=eVJcV5RhleZz7HjJAh4I0aoK1glVn2Mn+HV8IiiYSOhicZBvEzNpB5XK
   r4mzafqORnv9NplrNNhj83K6fWxK4v8gyOHKNycAs0/+yuZNt98gJ6z3M
   nbR7k1PZq1/0DTDycOn7p0is0+UQEzGCn6ITOrHOLPV2kU6BuekHk0d2l
   LXcONWvapONDUicKm5yNQ5kkT4Riae7yD2oK+DnXd1AqLNJxpu9pWx380
   poPGEVD0L5Z/uEoSKricogXfFFDKMQTSj7s6jRcIKTinLCwGxJSmxmb/5
   fSP/pSY0swV3KMbxK8fdP2Bw4V35/aRULgfpMHLes+dlVx0Z1oLPz4CYw
   Q==;
X-CSE-ConnectionGUID: ISNZniIsShKwF3AumIg8TA==
X-CSE-MsgGUID: tFKs1DddRQCB8XY1lW0K4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="25442183"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="25442183"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:38:58 -0700
X-CSE-ConnectionGUID: CEeb4/8xSNCZorymhQ0DTg==
X-CSE-MsgGUID: PVy0hocNSE6hvE0FIqZVXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63419058"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 00:38:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 00:38:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 00:38:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 00:38:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAFijiCC99Fy1TL0aq7x7XykQtNpQZq2KXCakpy5EaIOfmvu2F+5mZodx6/Z8uF83GTDS/8R0f5WjCCq0vFVh89alKSbPnAFSrITWOqsQkqhCbeVQdnWVWZPEUPihAOohWZRUw78a+Gl908bUNYKwib+27TV3QiDuf4pcGEO84lG7hdAVFR3ZSGH/isqtZ6tX/YRp72QymRAxjb5efFen2M3OUyGQyeTZh0KfsdB8YJxV1Xm8noQhWjk9PloA8qpAf+nGs1c9vmACBLGmTp0zQyZTKI9ZMI456Xsi9cJyZI9AMmBcE9w/iGsMd6E5poqK0SWuz3qFaXl1jWKFMefnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31HLLK9pYjcLvlZ1XO8dfTx2YpstESAABc5aqwmUjeE=;
 b=eCNmI1A3059p6/0UFAtasK1hw2E3l0wyCZ65XGw8LaNw2TizgV7RsLDumkEyfooagozgrONx7+x0aSyKRbNuSo3Bm1Tc2gYKyF32qmrcZc/qYkU02xOh6/t38tOdj7rIlW8C9Su8xwEI5VqITvXVCLY2Qmxlx7KL0Lui7LicxNzrq6ipYSUT4W8m23vIMZcqAoq0ZILrq49EUwFeIWi4G635hjonQyPFN3xHkhwH/cdu4AMwYU1FIp5uIPwTzAE4XCrySA4nOl4/rxjaAjnWujU7iBfJsQOg0eTr72x9W3UwRvn9lbWaQww0dvVG8lxbdZQk9wPGf17K2POQxsdRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW6PR11MB8391.namprd11.prod.outlook.com (2603:10b6:303:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 13 Aug
 2024 07:38:43 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 07:38:43 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 04/17] thermal: core: Clean up cdev binding/unbinding
 functions
Thread-Topic: [PATCH v2 04/17] thermal: core: Clean up cdev binding/unbinding
 functions
Thread-Index: AQHa7L/rDF5lhSPHoUuCwIiW/lYhfbIkziMA
Date: Tue, 13 Aug 2024 07:38:43 +0000
Message-ID: <dd7ffe0d8a14bce8975ff66d84f013a249427a15.camel@intel.com>
References: <114901234.nniJfEyVGO@rjwysocki.net>
	 <2819322.BEx9A2HvPv@rjwysocki.net>
In-Reply-To: <2819322.BEx9A2HvPv@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW6PR11MB8391:EE_
x-ms-office365-filtering-correlation-id: 209574d9-d54a-4c8d-d0f5-08dcbb6af552
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZXl1YzMySjRwUVdiTmZPVjVOZUg4andaem1qTGpzeGdQbHRReklabEdjZ3hq?=
 =?utf-8?B?Y042TEtrNzRvZ3Q2bzcxMno3N1Fza1VNREt5Ym1FS2QrejVSMW0yamJFMzhD?=
 =?utf-8?B?QmtrMnoxb3lyeForZkJGTmlJWEE1NksyeXVHWUVQL0x1aktRRTB4dW9uYW9M?=
 =?utf-8?B?L2VWeTdMd3V6NjU4Q3NvcnZPcC9hRnFCSy9LMmFZTm1nSDAwRDhZaUloamJC?=
 =?utf-8?B?VzFSUTVidEhuVkc0d29CZlNmM200QnI5QkE2S0lMMFA0NDZldTZWUkg2UXpE?=
 =?utf-8?B?T3lqbTgydlpWQmcwbHJ6QkVjOForcit0ZHBGV1lDVmtEUE9IYU5FYjBQVG03?=
 =?utf-8?B?d0pHWnJtLy9DTzlEREk4b01SM0JRckQyZ2ZZblVuWVdXb2dWU3d6UDJDZnEr?=
 =?utf-8?B?b0g5U3RnckJqMTI5V1hva3Z0cWwybDdjWUFpd1dYeU1DdHNxSkxKdDF4Nk5Y?=
 =?utf-8?B?dzVJRFdXeTV2alhESjFBTEtkL3hnNDdaSFVDdTh3UHg1b0h6c0xOdWJjc3d3?=
 =?utf-8?B?ejhFMlUwNjVYb0VGK0VWTEx3TkY4Z3VlZGR4Z0pSYlFXdDRSazJTSkgzVVpF?=
 =?utf-8?B?SFdWeC9BY0poNGRpbWhldUFheGNDaUNadmJDMjk4MUEyS0x0dHNrcmhqL3hY?=
 =?utf-8?B?QVlxaUx1Y3BVczFuTkJ4VkJTeXd0ZzhIQStia3lyeXFYYkpvYWxVQWRXNEV0?=
 =?utf-8?B?VE55TlRhRHJEQ3B4cEtqMkdHalY1ZmI0enhaVFl5OVZBeTFER2YrS3I5Mmg1?=
 =?utf-8?B?NWw5WXpKb25hRThyQmlRc294VEswSFkrTEt4M29zYmpnamppaEpYM2ZuR0FR?=
 =?utf-8?B?aHNUSWw0Y1BNdWx1SE9ueEtCcHk2blJaYmFuQU9YNktoTXdCbHZXclJwemtW?=
 =?utf-8?B?b3FyYlVJVmFvNWNCRVk4S29yalJJREkxanVZeTZmV21POEVneERhYWVUWitz?=
 =?utf-8?B?QVZkVGM4MGk1aXlkalhsVjhERUtJMjRQMEVUVGlzMGdUaGJrRG9mUm1idFNX?=
 =?utf-8?B?TjUyQjdvNEw4b2hEL1V2TUhZWnRSajJDTjFmT1VpQTRUdjlNLzZ2bVJ6YTBq?=
 =?utf-8?B?UG16dmkxY1B4Y25SODlMYndEU3MvcGNwWnU5SjlLOUJGdHNoTUZITlFnOWZO?=
 =?utf-8?B?ZDN0UDEyL2N5V1R3cGRCWXFkcUxlWE9KNnFCaXRXYlhROGVYazlYV2tBKytj?=
 =?utf-8?B?alBBQisvaVFSdGtEZ1F0djdoTzc2WFhYdkdkanVKRHViRExUaSszMWp3ZE02?=
 =?utf-8?B?dVdWS0poUHpQcytUcCsrOGgvelhmNHN4dXl2bHZuUXZrc0ZIR0dWSmovN21W?=
 =?utf-8?B?VlA4dUVQWE44K0J0cXNSVGZLZnhrZGhqWEFPWEVYaVhFU2hhUDF4US9DZTdm?=
 =?utf-8?B?SjVUVkJySHN4aTRUN0cxMmJYOTdabFVUSHFzTmhOOCtGZDMrTE4wRWxnNi9R?=
 =?utf-8?B?aXRQVUhDOWlSVThZeFh2WU9sSGZnMWFHY3o3bk10VDRXS2theThxVEVydW1i?=
 =?utf-8?B?eXNmR2lWQXpSUmZoYTZjM2Z5SVRPN3hiKzVVM3lwV21FR0VaL056eHEwNVlO?=
 =?utf-8?B?Ung1VkhmczNqamVQR3R4ZmhkdGs5LzdCMGV1Z3ZMK2RlYktqb1plUGJBYWdk?=
 =?utf-8?B?Y01ibkVJMXVFVTQ1SGdqbW1ycTYxKzRvWG9JU29IV0lPaUxTbGFPb0dmWDZr?=
 =?utf-8?B?eHc1SmNHQnpBZVF1ZW9wTnNMS2tLT3pKTWxCRkszalZtd0M3clVSN3ZCZ0VL?=
 =?utf-8?B?NGN5SUxPQ2p6dWQ2WklGWHhXNmk3bG44RnQ5MUVUN0lyUWhVOXR4U3dSQWln?=
 =?utf-8?Q?QXHcpg3SL23RLMm26mYLJzwjFn4qIbcRw3ZUc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHdEd3NLTWZnVnJoR0V0dVRvQkZBUXNzOXpOWGZsUHl3UnNyWXMrWkV6ZjhY?=
 =?utf-8?B?R2ZCRGdEblU4dEQ0U2t5aU1NbEpUMkxlZU56OTJDSGFBQUFCU0EzcnNIVWZX?=
 =?utf-8?B?NHhkYm5wWXN6K3o1dHhDbnovNDArWFIxSUdYYTQ4QWRXVWw1K0xDenpFY1RF?=
 =?utf-8?B?Y21hSlpKVVZmLzFEZ3J3V1I4YzYzSW96Y0xWNGpJTmFrL0hrVENmSS9SenhB?=
 =?utf-8?B?dkdqRWN2Qjk1emc0QVpwMW5NVFBFVUdFY2Q4R2E5TEdzbzVEbFZjTlE5RjVy?=
 =?utf-8?B?aVNNb3lEWFlBM3V3Sk5SMVN5c1V0cVJhcG9BU1I5Q1ZKdEUrRkpMSHgyRDNE?=
 =?utf-8?B?YjVoblNkS3YvSkp4Q0NZM1JEUHUyOXgyNFhaczYrRGtRTG9JcCt3L0hPVFFs?=
 =?utf-8?B?T1pMd3crc0h2ek0zSGlqODBHcWpDcVVDRFlMZmtUN3hCVDFsOFdsQUxPTXBv?=
 =?utf-8?B?YXBWMDZpeGxWN1dWZm84RW95WWdscWRnclVENUhOZ3k5ZkFKUlRENW5jSzZU?=
 =?utf-8?B?ZnoyRU1lNmVTenRaVk5OMVBOdHZJaDR4ODZSRDlHbml5bWdTRWxwNHZsMVNN?=
 =?utf-8?B?VVNHZUY4R210NzQ4VUcxWGFUWUdsRFdFSjFXSmE0dk9HV1grSngvRW0xVjdN?=
 =?utf-8?B?dERLZmpHM0RrTGZQT0hWTDJEVVQwUGJudGNTSmtyYVQ4aG9vYTE3NXhPUjg5?=
 =?utf-8?B?R2I2QUNpWlNjUU5JT3Mrc0VLUzk0QW5kOXBaTTNOUXBrR1BrWlJqaGJVNXBQ?=
 =?utf-8?B?bHJLQTBLZUtOWTk4cjcrOU5LS3ZOSlNtNFZWK21QK1ZaQThLYlEzOXhVa3ph?=
 =?utf-8?B?RE1SQXhjeTdNdGNRMUUvTllhMjJpajNwYUZxaHU0cWtDK1NzNmNPUnRtcXdD?=
 =?utf-8?B?T3hua1dPVXU5TERjelBtSG1EcC9IakVxaUJzL3RFMHBWdHNiNVdFeHoyb1pZ?=
 =?utf-8?B?TlYxM25jVTBpbXh5TGVydFVkSUQrTHlKekZIbHczWTJ1ZFVOb28xQ3FGNDZj?=
 =?utf-8?B?M1RHTzFLMUVuSG5JaEl3Q3pZVHB6TytZWFVHaDVqS1poNHBncDdJVUFtWG00?=
 =?utf-8?B?ZUo1UmlCaTY5ZndEZFpobXdEbzRRMkFxbmVqcDhTakc2SjFMTVlPSUg1SjVu?=
 =?utf-8?B?dFJnRTBOd0NQUjA0dEJ3a1E5MDk0VmdyeExjUkxSWWdOVW55RTZZejJLS05o?=
 =?utf-8?B?dzduR2t6TlJ2Q0Nhbm5wVVdGK0lFenJFazRJRmFnbWUrVlp5UngxVUxvREtI?=
 =?utf-8?B?RnQzWk80Uk43QldTSHc2YWlrRnpQaGFnVFlOejhsc21UZ0FSTlVmYURJaEsx?=
 =?utf-8?B?L1dLcGZVMWdmWmhrd3BVdko0UyszRUFXWWxqa2ZBOXcrMXRVQzQ2T3pYTXRo?=
 =?utf-8?B?Yjg0NXh2dzBQSEh1UTh5MEZvMmNrc210bC8xT3lSbHJ5NXpMZHgvcHJGRkw0?=
 =?utf-8?B?ZXB1NURheUF0YkRXcjN1cUQzTWRqeFhKVXRLRUZnekNBV0xRc29jMW52N0g0?=
 =?utf-8?B?TU5HanhYQ1BIM3dMZHpCT2w0bVlqd1VJNXFWVkdTMVhaSU94cWU5U3dRYlY5?=
 =?utf-8?B?aXRGaWJjR1F2dlZEVTV1bURlRm5xU2hMM3ExbHpMYkRlLy96dWNkQ1R3V1dH?=
 =?utf-8?B?UTlWeHpXWlhIL00raXYyV0pWT2l0dEd5dkFvbGR4VVlZaHBucGNJNDBLY2J2?=
 =?utf-8?B?WjRDRkdFeXVkL0ZBQy9yYWVmYmVtYjVFNjBqTFZ5ZE9OTGMzOUMvKzZuc0d6?=
 =?utf-8?B?eTlTTHd2YndrQkxKdElvNHNjUlByMlRuMWtKbUdodjE3MVlCZk5lUlRBUS90?=
 =?utf-8?B?Y25qL09jditjNWFLZWZWTWhMUHR4Q1pzY0h2dTdtNU1FUUxGQjJ2aHhkVXll?=
 =?utf-8?B?ak84SW4yaE5vb282U2tlYXlYWFJmYVN5RExuanFVMjY2ZWFKNG5tTkVTM0pG?=
 =?utf-8?B?dm02VHVDMVlWalNIbDZlOTBrc2tJZU5jR2tPU1g1dmpVRVg1Y05EQUVrY0Rj?=
 =?utf-8?B?ZTFRTmppeTJvUmdjbmFyc0VqVEJVVDVPOXZiVXFSQS9PNUViMnVFc2hiSE1O?=
 =?utf-8?B?Rytic1dIMDVydzVLekRQN0Yzbkt1ZG0xeEt0RmhnRUpTT3hxRjJuQ0ZsMlpi?=
 =?utf-8?B?QTFZYTAwdEkrWWtsVVVRbUhOY3hDRTdBSFg2b0cxaWdrYzZBdVhmaTB1ajdm?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CED96A842CDC34C809D897479E20561@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209574d9-d54a-4c8d-d0f5-08dcbb6af552
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 07:38:43.5913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIXByLR48DrHYToby2HO2F3TBAmmCK45D8OfMeVPKzs1GZzA1+L+HQXQk3aYSAizdpviUzmr3cEID0hxijpI+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8391
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTEyIGF0IDE1OjU2ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
Cj4gCj4gQWRkIGEgbmV3IGxhYmVsIHRvIHRoZXJtYWxfYmluZF9jZGV2X3RvX3RyaXAoKSBhbmQg
dXNlIGl0IHRvCj4gZWxpbWluYXRlCj4gdHdvIHJlZHVuZGFudCAhcmVzdWx0IGNoZWNrIGZyb20g
dGhhdCBmdW5jdGlvbiwgcmVuYW1lIGEgbGFiZWwgaW4KPiB0aGVybWFsX3VuYmluZF9jZGV2X2Zy
b21fdHJpcCgpIHRvIHJlZmxlY3QgaXRzIGFjdHVhbCBwdXJwb3NlIGFuZAo+IGFkanVzdCBzb21l
IHdoaXRlIHNwYWNlIGluIHRoZXNlIGZ1bmN0aW9ucy4KPiAKPiBObyBpbnRlbnRpb25hbCBmdW5j
dGlvbmFsIGltcGFjdC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFm
YWVsLmoud3lzb2NraUBpbnRlbC5jb20+Cj4gLS0tCj4gCj4gdjEgLT4gdjI6IE5vIGNoYW5nZXMu
Cj4gCj4gLS0tCj4gwqBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgfMKgwqAgMzIgKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCj4gLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxOCBp
bnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKPiAKPiBJbmRleDogbGludXgtcG0vZHJpdmVy
cy90aGVybWFsL3RoZXJtYWxfY29yZS5jCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+IC0tLSBsaW51eC1wbS5vcmln
L2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYwo+ICsrKyBsaW51eC1wbS9kcml2ZXJzL3Ro
ZXJtYWwvdGhlcm1hbF9jb3JlLmMKPiBAQCAtODA2LDYgKzgwNiw3IEBAIGludCB0aGVybWFsX2Jp
bmRfY2Rldl90b190cmlwKHN0cnVjdCB0aGUKPiDCoMKgwqDCoMKgwqDCoMKgZGV2ID0ga3phbGxv
YyhzaXplb2YoKmRldiksIEdGUF9LRVJORUwpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIWRldikK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PTUVNOwo+ICsKPiDC
oMKgwqDCoMKgwqDCoMKgZGV2LT50eiA9IHR6Owo+IMKgwqDCoMKgwqDCoMKgwqBkZXYtPmNkZXYg
PSBjZGV2Owo+IMKgwqDCoMKgwqDCoMKgwqBkZXYtPnRyaXAgPSB0cmlwOwo+IEBAIC04MjEsOCAr
ODIyLDcgQEAgaW50IHRoZXJtYWxfYmluZF9jZGV2X3RvX3RyaXAoc3RydWN0IHRoZQo+IMKgCj4g
wqDCoMKgwqDCoMKgwqDCoGRldi0+aWQgPSByZXN1bHQ7Cj4gwqDCoMKgwqDCoMKgwqDCoHNwcmlu
dGYoZGV2LT5uYW1lLCAiY2RldiVkIiwgZGV2LT5pZCk7Cj4gLcKgwqDCoMKgwqDCoMKgcmVzdWx0
ID0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3lzZnNfY3JlYXRlX2xpbmsoJnR6LT5kZXZpY2Uu
a29iaiwgJmNkZXYtPmRldmljZS5rb2JqLAo+IGRldi0+bmFtZSk7Cj4gK8KgwqDCoMKgwqDCoMKg
cmVzdWx0ID0gc3lzZnNfY3JlYXRlX2xpbmsoJnR6LT5kZXZpY2Uua29iaiwgJmNkZXYtCj4gPmRl
dmljZS5rb2JqLCBkZXYtPm5hbWUpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAocmVzdWx0KQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byByZWxlYXNlX2lkYTsKPiDCoAo+IEBA
IC04NDksMjQgKzg0OSwyNiBAQCBpbnQgdGhlcm1hbF9iaW5kX2NkZXZfdG9fdHJpcChzdHJ1Y3Qg
dGhlCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfbG9jaygmdHotPmxvY2spOwo+IMKgwqDC
oMKgwqDCoMKgwqBtdXRleF9sb2NrKCZjZGV2LT5sb2NrKTsKPiAtwqDCoMKgwqDCoMKgwqBsaXN0
X2Zvcl9lYWNoX2VudHJ5KHBvcywgJnR6LT50aGVybWFsX2luc3RhbmNlcywgdHpfbm9kZSkKPiAr
Cj4gK8KgwqDCoMKgwqDCoMKgbGlzdF9mb3JfZWFjaF9lbnRyeShwb3MsICZ0ei0+dGhlcm1hbF9p
bnN0YW5jZXMsIHR6X25vZGUpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
IChwb3MtPnRyaXAgPT0gdHJpcCAmJiBwb3MtPmNkZXYgPT0gY2Rldikgewo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlc3VsdCA9IC1FRVhJU1Q7Cj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gcmVtb3Zl
X3dlaWdodF9maWxlOwoKTmVlZCB0byB1bmxvY2sgdHotPmxvY2sgYW5kIGNkZXYtPmxvY2sgYmVm
b3JlIHF1aXR0aW5nPwoKdGhhbmtzLApydWkKCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB9Cj4gLcKgwqDCoMKgwqDCoMKgaWYgKCFyZXN1bHQpIHsKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgbGlzdF9hZGRfdGFpbCgmZGV2LT50el9ub2RlLCAmdHotPnRoZXJtYWxf
aW5zdGFuY2VzKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbGlzdF9hZGRfdGFp
bCgmZGV2LT5jZGV2X25vZGUsICZjZGV2LQo+ID50aGVybWFsX2luc3RhbmNlcyk7Cj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGF0b21pY19zZXQoJnR6LT5uZWVkX3VwZGF0ZSwgMSk7
Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0aGVybWFsX2dvdmVybm9yX3Vw
ZGF0ZV90eih0eiwgVEhFUk1BTF9UWl9CSU5EX0NERVYpOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4g
Kwo+ICvCoMKgwqDCoMKgwqDCoGxpc3RfYWRkX3RhaWwoJmRldi0+dHpfbm9kZSwgJnR6LT50aGVy
bWFsX2luc3RhbmNlcyk7Cj4gK8KgwqDCoMKgwqDCoMKgbGlzdF9hZGRfdGFpbCgmZGV2LT5jZGV2
X25vZGUsICZjZGV2LT50aGVybWFsX2luc3RhbmNlcyk7Cj4gK8KgwqDCoMKgwqDCoMKgYXRvbWlj
X3NldCgmdHotPm5lZWRfdXBkYXRlLCAxKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgdGhlcm1hbF9n
b3Zlcm5vcl91cGRhdGVfdHoodHosIFRIRVJNQUxfVFpfQklORF9DREVWKTsKPiArCj4gwqDCoMKg
wqDCoMKgwqDCoG11dGV4X3VubG9jaygmY2Rldi0+bG9jayk7Cj4gwqDCoMKgwqDCoMKgwqDCoG11
dGV4X3VubG9jaygmdHotPmxvY2spOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgaWYgKCFyZXN1bHQp
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ICvCoMKgwqDCoMKg
wqDCoHJldHVybiAwOwo+IMKgCj4gK3JlbW92ZV93ZWlnaHRfZmlsZToKPiDCoMKgwqDCoMKgwqDC
oMKgZGV2aWNlX3JlbW92ZV9maWxlKCZ0ei0+ZGV2aWNlLCAmZGV2LT53ZWlnaHRfYXR0cik7Cj4g
wqByZW1vdmVfdHJpcF9maWxlOgo+IMKgwqDCoMKgwqDCoMKgwqBkZXZpY2VfcmVtb3ZlX2ZpbGUo
JnR6LT5kZXZpY2UsICZkZXYtPmF0dHIpOwo+IEBAIC05MTQsNiArOTE2LDcgQEAgaW50IHRoZXJt
YWxfdW5iaW5kX2NkZXZfZnJvbV90cmlwKHN0cnVjdAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoG11
dGV4X2xvY2soJnR6LT5sb2NrKTsKPiDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfbG9jaygmY2Rldi0+
bG9jayk7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUocG9z
LCBuZXh0LCAmdHotPnRoZXJtYWxfaW5zdGFuY2VzLAo+IHR6X25vZGUpIHsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChwb3MtPnRyaXAgPT0gdHJpcCAmJiBwb3MtPmNkZXYg
PT0gY2Rldikgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGxpc3RfZGVsKCZwb3MtPnR6X25vZGUpOwo+IEBAIC05MjMsMTUgKzkyNiwxNiBAQCBpbnQg
dGhlcm1hbF91bmJpbmRfY2Rldl9mcm9tX3RyaXAoc3RydWN0Cj4gwqAKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJmNkZXYtPmxv
Y2spOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG11
dGV4X3VubG9jaygmdHotPmxvY2spOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZ290byB1bmJpbmQ7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGZyZWU7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB9Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiArCj4gwqDCoMKgwqDCoMKgwqDCoG11dGV4
X3VubG9jaygmY2Rldi0+bG9jayk7Cj4gwqDCoMKgwqDCoMKgwqDCoG11dGV4X3VubG9jaygmdHot
PmxvY2spOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PREVWOwo+IMKgCj4gLXVu
YmluZDoKPiArZnJlZToKPiDCoMKgwqDCoMKgwqDCoMKgZGV2aWNlX3JlbW92ZV9maWxlKCZ0ei0+
ZGV2aWNlLCAmcG9zLT53ZWlnaHRfYXR0cik7Cj4gwqDCoMKgwqDCoMKgwqDCoGRldmljZV9yZW1v
dmVfZmlsZSgmdHotPmRldmljZSwgJnBvcy0+YXR0cik7Cj4gwqDCoMKgwqDCoMKgwqDCoHN5c2Zz
X3JlbW92ZV9saW5rKCZ0ei0+ZGV2aWNlLmtvYmosIHBvcy0+bmFtZSk7Cj4gCj4gCj4gCgo=

