Return-Path: <linux-pm+bounces-29947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB14AF07D1
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 03:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C91A4E121D
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 01:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3CF1459F6;
	Wed,  2 Jul 2025 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uz8VXID2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313572637;
	Wed,  2 Jul 2025 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418856; cv=fail; b=mLR6DIJWUqaRV2iIzfrFTr1DV+sruh84oFD+PgK2xJ75XBawTE1lOt2oz5VcjvWNNIRP1yXR9NjD2N2L+zIwbCIWyEKjqJPgFNBnO4GFRb4n+IUpEG1d0fW5XJZxQiGlgiBIxAwRfpc7zLrAOLl8Pj/HGaU8GmjchN3CRa92Lko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418856; c=relaxed/simple;
	bh=T9fSBbf8pFZRSS3vHH4KNYlT+Ivlr8Wm+Gp+12k2RcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NhzYGPbUI7dWROLUX3uKl2RQSL/OjP7BMLYLqbM3Vst41kon884WF8E18yEF/JyDIRo0bV5G4vI0vmyCntxYVTzH5clCdtVNX5Fpkz+xCy5b8G4aLBd4NR7EB+3QC6/ci90viwujUIn6ePRL4C0/s1h4cJAbtosdTBLMePiN/zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uz8VXID2; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751418854; x=1782954854;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T9fSBbf8pFZRSS3vHH4KNYlT+Ivlr8Wm+Gp+12k2RcY=;
  b=Uz8VXID23LkZVnP2fQSnRorfi9RTNvjda1iemPSTEli5OQRg7hqyGD6C
   iO11+6uLblrWL7mgC+rxWIVfvMH33p1VsQkEGav6YhV99VtfNLrrKgfdN
   AXcuVzA4mh8Df1x6X4TqPyv5SiffpUhM6ziowHdFQUDS7Etoi5hd4HrZ6
   1iPj684Pv5WnxSuMyKzL7Sr3N/hdm0321MjLOy2lxxm/qvqkr7HViOe7V
   GBwSDuDzmi4hGKr8TFA52gxutoQ2DQxXLbBkmNOdDa2MCKFxlzx82fVeU
   J9rcG0UsOnyq3uzHyD5cp9p8+EX63BWEXiVd8Sd6tqykt6LCQPGvPrtdt
   Q==;
X-CSE-ConnectionGUID: 2gQBFkhhReeY8x2ldWjaaQ==
X-CSE-MsgGUID: V4CxJ6R5RCSrbKL/quIHeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53792081"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="53792081"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 18:14:06 -0700
X-CSE-ConnectionGUID: IT3otWA4RN+RKwXoyLbHsw==
X-CSE-MsgGUID: a/TphmMwTp6rTpTlo0CGow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="154473245"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 18:14:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 18:13:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 18:13:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.60)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 18:13:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMptBW+oDPA379mlatQxFBn2zXTJDEn7hikuZBD61wWULwabdTWFr/UY5jLazp8zewEM+r/RYX2o7uT6/WdWMas2E5NYxCSzj4aERqKzhAehK1L8xwb1IsNqHupwIJ19MHcBkd/L5hdTcJ758KRWpHUTQiSLSYpMmZ9uFw4s4rL7QRwLHyeul5euuObgR2uQgPoYI1nvFD5E4j6zhDRsBOx5XspVo6++hiqY7fgafaE/xZUajYMrZ/I2Mu1J5fynqAgvRA/osWfYkM8xWHM5Yjc2xqfkkEA1fJRniRsoCEEVOE09h5DYiP+2GzM+FX0XYsmqyTS0NWRRkO3TWZLrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9fSBbf8pFZRSS3vHH4KNYlT+Ivlr8Wm+Gp+12k2RcY=;
 b=aRO8oVSJD0RTTLMfzAkfMWBRVmOCqryLXorlhPjDuihk7gGMD9vw+0gVxAMHzPD/ZyTLUH0ZvApwCqfg4FoB0uFGn0sjue/QblR+uC5hEVM7OKkorp9kuMB+Zw5hKdpVHPiK7+PbszDGqqigD0iyW7wBnpnlHobrbh+V/UaLczesyZNcPaMNRgrdtKeqCqxSWJ8i6ZzrECQQAd6PAo7kTylvuyL4O+046bNleb1U87F1z8HrZMhbtu6dEBbke+GQmsN1p1VSdi7+VKSLc0AQXMW/F0FfZg2lzzHFcFVk7M4KiiORp5VfadmUbGhTpA7kcwH2V78S4Bw7s9eKeLUfqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by PH7PR11MB8456.namprd11.prod.outlook.com (2603:10b6:510:2fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 01:13:39 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8880.021; Wed, 2 Jul 2025
 01:13:39 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "benjamin@benis.se" <benjamin@benis.se>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "W_Armin@gmx.de" <W_Armin@gmx.de>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Thread-Topic: HP Omnibook Ultra Flip 14 - power profiles
Thread-Index: AQHb54aI/x4TucNMjkG3sTXjdCBKkbQa6rUAgADA7YCAAS9BAIAAAueAgAEwPIA=
Date: Wed, 2 Jul 2025 01:13:39 +0000
Message-ID: <fad3442f78f82154f507cf485057c6688659e4a5.camel@intel.com>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se>
	 <9642ad7e-3e57-45f9-bfd9-beac3e55418e@gmx.de>
	 <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se>
	 <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de>
	 <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se>
	 <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de>
	 <3b25e59bc1b162ee8f43ffbd3c50589a52d540af.camel@intel.com>
	 <rFJU7KbF6iq0CxJtSjPu4vLVjWata5hY1Kl-wOv253p0C2W7egJQQrkUnkSqmr1vXDXeTwwtwp0u5ZnQU6pZmPuJ7TnNBVgudMG-q5MRHyM=@benis.se>
	 <ee9a2111eab5a8bc95fb406d8bfed12bcc5616b9.camel@intel.com>
	 <w1oZ3TmKGo5jIZitOAFijvrms0dIML16dkDbNsXKgfWVrmwZO8tiSajRChU8GDgN-VELm13UZekXJl2I4L0iXfT9v0xjlJaJLmdypJ5Tc9Q=@benis.se>
In-Reply-To: <w1oZ3TmKGo5jIZitOAFijvrms0dIML16dkDbNsXKgfWVrmwZO8tiSajRChU8GDgN-VELm13UZekXJl2I4L0iXfT9v0xjlJaJLmdypJ5Tc9Q=@benis.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|PH7PR11MB8456:EE_
x-ms-office365-filtering-correlation-id: b20fdce6-a5b6-4026-72f9-08ddb905ad88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WDhFZVUraXRReTl4U1cxblE4TVhEME1iZnYzZzdXdXRmOWMvb0tpUXBXNmhw?=
 =?utf-8?B?T0l2VnNYNm02aER4SVlTTXNIMnJuZk8rcXk0cndxYngwOXp1K0YyOG9HZXc4?=
 =?utf-8?B?SE9ldFRWQkg2bHlFbmJzcVRqcGFpdmluMUd3YnZhMXdNczhZa0l3Qy9qbkpp?=
 =?utf-8?B?cWwxbFc1R0prYzZ0VnJ2KzZQZUhDbWFVY0tQdWNtZUhVMGxzUzNTMlNpK0c1?=
 =?utf-8?B?U1QxYStWU21NOFRybHJ5V0FnNnhCR2ZjTXdCczBHL3d0emVSNTQ1L3Nlb2R3?=
 =?utf-8?B?ZXQ5VEFRZUJWVVQvOHkzdmdlWld5enVpOTR5UVJLMlkrcTNTQnBjQW9Eb3pK?=
 =?utf-8?B?YlREY3drQzNra1BuUHhjVVFXVGxyQUZ1N2xzNnBiVjFKc2NzR2hoOXFTMHVJ?=
 =?utf-8?B?dGZOZHRqSTNUOWhYelllQVBVTE82d09YN05HRDZmMXVRYW16M0RoZ1J6QkZD?=
 =?utf-8?B?bXJKUjFISkdWYThkSWxNZUdzb3p3WWlOL1dmMGVhSm4xVXdJREZzTndtbGRU?=
 =?utf-8?B?QnNNVWgzSUliQzdyN1pQbm9xNlRXL0ROQXZ2UnAzdTgwakM3MUxZbE1NL2R5?=
 =?utf-8?B?dUViNWRNeitSUlU0d1Y5b3VEdkx2b3RmQVFqYndLakMzc2dZTFQralpDeHZ5?=
 =?utf-8?B?c0VtVVVpZ05GcUl1aFdKNmdGTFVlbytyTXQ5MGU3NFlTemNHbGhwcjl3cnd2?=
 =?utf-8?B?RW1YM2dySGhvOU0vdHhXeno2Y0taTFY4NjNVYzQ3cmo3d2tTc2N2ZHowbk1z?=
 =?utf-8?B?eitSdnMzZ29mS1lQV0lJTXFTTGVKQjBIZ0N6WTNTQUhKWTMwWlpjZVFvUTBW?=
 =?utf-8?B?U0NGLzRhWUEvTUI2V3p4NTJwa20vSzV2dHZjdFJ4VlFiajhxZmZ6Y0JkWGZh?=
 =?utf-8?B?UDI1RnpzZFkwSmF2R0poS2pnTmlmaG53Vk5EU1ZrYzlhSWN1MWtvVE9QODhX?=
 =?utf-8?B?WWtSaC83czFka2p0LzlQS082RENoQTJmbW1tejc1dE9sRm5aa0U5T0RtVktP?=
 =?utf-8?B?NnBxUjJDbjdHTHBqbFIzK2g3Ymt5UnZZOXVhdFNBTjBzL3MvZitzK0V0MFc0?=
 =?utf-8?B?ZzhYQlE1ZDhEZ2FrcE5rdlIvRU5VbmdKYUx6K2hRWTJsdTd5NTBwUFRQRkZL?=
 =?utf-8?B?UGVnWXgrVmRlOXhnWXNVdnVkUTJSSkN3ZW5wd2NmbGZOZ2pvbktSNkVCMDZN?=
 =?utf-8?B?T2VDNU9LQUN2a05jeGl1UWhxeEl2WDAyTk1iUi93cTV1dDBRYzZmVFFUL3Z1?=
 =?utf-8?B?d0ZRYmpGcWkyaW5LRk9ycVhIdEtubGpNYXpIenJHVEpEMHRyeThtRGQ0L28v?=
 =?utf-8?B?YjVrb1BSR0FDdG5Lb213ZUtzOWs0QlZpc0dMVEFzc1ZldCtIUGJWdFpxcXpF?=
 =?utf-8?B?c3haT0VpUHU0MkhCQitJWEhwWkxDbEpjb1BkbDJmYnFJdllvZkFRY2xMbFBL?=
 =?utf-8?B?REYyUmNNWmp4Z1d4Ui9pRE9CaThreWdIbXhsdkp1OFJ3YzlibDVoeHMrNFdR?=
 =?utf-8?B?T3d0d0RSWVM0WnRiYUZrRko5aDFWcElQeHhjQ3o2cmRNK0VKNXZDcFpQUWRu?=
 =?utf-8?B?SzJTNE9xZ3RibW9HR1Z1TGVudEJ0b0RuY3FNdEh0aDZqdkhmODRVUm5xem94?=
 =?utf-8?B?MHNaWFdiL25XYk1qMTVCVS9tQXFQdTVBYkxQM0xSeTRzM21wVElpaUVBaTVZ?=
 =?utf-8?B?YW9FbFN4bzhmV2YwVkNaRGtVMkVlZ1diY1ArbXpOb1A4dWRkWVBoNE5CaCsy?=
 =?utf-8?B?QUw0T3VwV2Y4TDBzeGNvZS9EbzltdmpyNFh6MDdIdVZTWE55VXRFZ3pCN3Ey?=
 =?utf-8?B?bVpvdWo4SEUyZzJtbm1QdVNtbHhMS1h3T1ZjdUg0UmoreGc5MHRWWkRZdXJK?=
 =?utf-8?B?UjNVOWNXRGRnaHpUTGlzVXlWL1ozOUlIR0xrZ28yK1lQS2JwN0FLVGFJdVNI?=
 =?utf-8?Q?0g4JoZ3yrM0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUNZcGdTTTlWYklrQlQ4OUExaWZGS2J1K2dvVVFpNnFxTlJyamFjR1RnVFJ4?=
 =?utf-8?B?UUJVbnZsMUt0OGcwZEZ3SHM0L1cveXhQNWUwR1ZDSnhHUmdGbDBsOS9hTXpD?=
 =?utf-8?B?R2V4ak5Bc1F5M1VMQ0hBS091SDJwbGJnTXY3cTZpc3RkWlpvYkwzTHYwQ1h0?=
 =?utf-8?B?STM1dDhEOFlsVlBiamtBb2hTd3F0Qmh5UEJ2SVowa29xK2ZtV3N1UEJYZGYx?=
 =?utf-8?B?SzhuUGlXMnp2VTd3MS9ONzFJd2hqTlpXdnoyZ1BWZEI2dzk5VTJGVVZEUTIr?=
 =?utf-8?B?M2dHdEFtSS9Cc2RBejRiUzVKaS9hN2ljMjNxMUNBVW1DYTRUNk0yS24zbktp?=
 =?utf-8?B?SEFya1piNE5NUTBBbjNqTVpiWEJ3V0hudktlWHU3NldFZDVvU3dZM0k3ZmhW?=
 =?utf-8?B?ajdvQlRUQU0vVmd4WFBSYlVEbHRZNC9EdFNzQlFkOVYyeng4SHk4WmpxSmdY?=
 =?utf-8?B?MmFSMjhIbk9kU1lTejdZLzFLOXlzNWhFa054aDZEaTZPUGRrUEFabkY0Tkhi?=
 =?utf-8?B?RXJtMmdyTlZKQkkraTFoWUoxcTFvTUsyc0NuVU5idjFDaWwydUNOdTFvQzh4?=
 =?utf-8?B?d2hjMk0zWTRvWVNtdkxoTzVFTkpuQXNVUVMvcURWNzF1Qk5rUGhaNTFzazJR?=
 =?utf-8?B?MFZtUkJ1QllxMjg2TUc3VlZsWnZQV1RpUE9waXpuS2cyeE9RTE51ZW1venpj?=
 =?utf-8?B?cXZ5M2Zva1N5WlAybTJzcXdrSWlDVkJ2QUo2U3poMHdwRjBMeU44WVppMGt1?=
 =?utf-8?B?K0hQaTYvWFlheXBENVBnZTZ6VHBjRC9NYndjc01peE55a3g1YjFZOENFK1k5?=
 =?utf-8?B?N21VMERTbnlaKys5T3Qra2IvU0FIajRUZHd5UVBHS05ocjc0VFg3dlA2VzRs?=
 =?utf-8?B?WkFVOUxUUnRYci9vb2ZFaGJzQ0FiRHk3c2hEbU55bENvZ2M4ZlI4TGJLOG42?=
 =?utf-8?B?eEtJd1JCWjJOenZhMWJlRGdNdEM5Z2h1VjdZUThRSDgvTTVvak5ZTk9QcHNV?=
 =?utf-8?B?TXFaZXdyZTJSRUNJK3RsWjlOOU9VYnJxSm14ZXlPSWZkV2YrYXBMOVlTSDlJ?=
 =?utf-8?B?OHU5NmVSUWEyVm1xeEt5VjExU0dRTTkzdno2MUMzOFhPbFJPMEJhUlB1Smww?=
 =?utf-8?B?Vm5lR3N5ZFc3OWNWTDJjazUxUDFnUEdsd01HR29IVVpSQVZmNUpyMTdUaU5V?=
 =?utf-8?B?bGFpeTlaTjd5L0ppWW9CU2tlbyt4N010VEVzdC9BTHRlL3pSWXAxZ2JSNmdp?=
 =?utf-8?B?N1JvdU9lMmxyb0xNWEtBS0FvKytlVm5nNm9PUE1jTEhIbkx2WnlzREhvUWQr?=
 =?utf-8?B?N3VWbkprbFovbXJPWmptYnMzYlVvZnh5M0EyM2NpREdaS0JVMzY1YmVBTVNo?=
 =?utf-8?B?NUR6YUVvcHl2clJUbHo0dUxQYUJlN2U1SHNmNWFjd2dlL2t2VjhrdGMvTDUz?=
 =?utf-8?B?MWJneWMzcWlzeFV6L1JneDdJNWs0OEdYQnNCVXlHU2dhUXk1YW8xMENpSGlK?=
 =?utf-8?B?WGxZNEprc1I4QkhSZ0RNVkM1RHJ4TEZQNTIzc3NETE56S0JEditEUXovelFK?=
 =?utf-8?B?Q2JERzh0WmNlTGpCcWs3MzRmcHFpU3UvcG9TUXAxTzIzVTRSVEo1VlB4dm9B?=
 =?utf-8?B?UVYrZUU1QXVac2t4WkM3V3h5VFZ0aHFrUENtTUxIMUxVZFdldTRwcThyM2hR?=
 =?utf-8?B?bnAxZTQ3V3pIbVhsSndZamU5a1ZsRCtuVmJNMDhLTEFQNFV5YTRLUlNDUnEv?=
 =?utf-8?B?Tis3ckVQcFZCZGJRRDVxdnJybGozMXFVL1dXd3lZVlVDbmFzS2Z5Mm9BeUNl?=
 =?utf-8?B?c0NINWxONDg2STNTVXdVVUsvaldjYUtMNWs1aFlUQnQ3QzFObkhDWG9PaGox?=
 =?utf-8?B?dWxNNFRpYWNBWWJsWmVEMUlhVlBIYzhRMDFJYi9FdXljTVBOMG51SjZ5eDVD?=
 =?utf-8?B?NkZQR2lkTmFQdndqY0l6Z09wcjNiOVp2M2ZFWXBROFRwdEsrN3BRR1BzQlBL?=
 =?utf-8?B?UVRhNnlid2NxV3JQVnBJNDNORnp6N21aTXVrVnpMRXZ6M0FxY0JYa2xMcU91?=
 =?utf-8?B?bUFUMkdHcWtJOHZUZm5mSHpmRmZDTTAvUlcwTDE2MVhoNmtrZ1Bia3N1ZnVP?=
 =?utf-8?B?SFByLzh3bFZoMXJURjhGdFhiQlpSenFrUXlIaXZRRmxvMGYwbHREamFVbzYw?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <170EDB5F982114429038FB96D946A318@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20fdce6-a5b6-4026-72f9-08ddb905ad88
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 01:13:39.3487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63rpv+iKZdjpuGNl/bFH+5CZxgY6G7qyRU1Q8qm1X/DFw+bkrBrqslpwWQqNtMkxwBO/edXwZmbk+TDjawd3qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8456
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA3LTAxIGF0IDA3OjA0ICswMDAwLCBCZW5qYW1pbiBIYXNzZWxncmVuLUhh
bGzDqW4gd3JvdGU6Cj4gCj4gCj4gCj4gCj4gQmVzdCByZWdhcmRzLAo+IEJlbmphbWluIEhhc3Nl
bGdyZW4tSGFsbMOpbgo+IAo+IAo+IE9uIFR1ZXNkYXksIDEgSnVseSAyMDI1IGF0IDA4OjU1LCBa
aGFuZywgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPgo+IHdyb3RlOgo+IAo+ID4gT24gTW9uLCAy
MDI1LTA2LTMwIGF0IDEyOjQ4ICswMDAwLCBCZW5qYW1pbiBIYXNzZWxncmVuLUhhbGzDqW4gd3Jv
dGU6Cj4gPiAKPiA+ID4gQmVzdCByZWdhcmRzLAo+ID4gPiBCZW5qYW1pbiBIYXNzZWxncmVuLUhh
bGzDqW4KPiA+ID4gCj4gPiA+IE9uIE1vbmRheSwgMzAgSnVuZSAyMDI1IGF0IDAzOjE4LCBaaGFu
ZywgUnVpIHJ1aS56aGFuZ0BpbnRlbC5jb20KPiA+ID4gd3JvdGU6Cj4gPiA+IAo+ID4gPiA+ID4g
PiBTbyBJIHRlc3RlZCB0aGVybWFsZCBhZ2Fpbi4gU28gaGVyZSBhcmUgc29tZSByZXN1bHRzLgo+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gQmVmb3JlOgo+ID4gPiA+ID4gPiBSdW5uaW5nIFZhbGhl
aW0gdGhlIHBvd2VyIGRyYXcgaXMgMzV3IGFuZCB0aGUgZnBzIGlzIDQxLgo+ID4gPiA+ID4gPiAK
PiA+ID4gPiA+ID4gQWZ0ZXIgSSBoYXZlIGluc3RhbGxlZCB0aGVybWFsZDoKPiA+ID4gPiA+ID4g
UnVubmluZyBWYWxoZWltIHRoZSBwb3dlciBkcmF3IGlzIDQ0dyBhbmQgdGhlIGZwcyBpcyA0Ngo+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gU28gaXQncyB3b3JraW5nLAo+ID4gPiA+IAo+ID4gPiA+
IEdvb2QgdG8ga25vdyB0aGF0IHRoZXJtYWxkIGhlbHBzLgo+ID4gPiA+IAo+ID4gPiA+IGNhbiB5
b3UgcGxlYXNlIGFsc28gYXR0YWNoIHRoZSB0dXJib3N0YXQgb3V0cHV0PyBzYXkgInR1cmJvc3Rh
dCAtCj4gPiA+ID4gbwo+ID4gPiA+IHRzLmxvZwo+ID4gPiA+IHNsZWVwIDEiCj4gPiA+IAo+ID4g
PiBodHRwczovL2RyaXZlLmJlbmlzLnNlL3MvS3RSdENRWGk3bVM4R01pCj4gPiA+IFRoZXJlIHlv
dSBnby4gSSBhbSBjb21waWxpbmcgdGhlIGxpbnV4IGtlcm5lbCBhdG0gc28gdGhlIGxhcHRvcCBp
cwo+ID4gPiB3b3JraW5nIHZlcnkgaGFyZCAoSSBhbSB0aGlua2luZyBvZiBsb2dnaW5nKS4KPiA+
IAo+ID4gaXMgdGhpcyBkb25lIHdpdGggb3Igd2l0aG91dCB0aGVybWFsZCBhY3RpdmF0ZWQ/Cj4g
Cj4gVGhlcm1hbGQgaXMgYWN0aXZlLiAKPiAKPiA+IEkgc2VlIHRoZSBURFAgaXMgMTdXLCBub3Qg
c3VyZSBpZiBpdCBoYXMgYWxyZWFkeSBiZWVuIHNldCBieSB0aGVybWFsZAo+ID4gb3IKPiA+IG5v
dC4KPiAKPiBJIGNhbiBkbyBhIHRlc3Qgd2l0aCBhIGRpZmZlcmVudCBsb2FkIGlmIHRoYXQgbWF0
dGVycz8KPiAKPiA+IGNhbiB5b3UgYWxzbyBwYXN0ZSB0aGUgbHNjcHUgb3V0cHV0Pwo+IAo+IEFy
Y2hpdGVjdHVyZTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeDg2XzY0Cj4gwqAgQ1BV
IG9wLW1vZGUocyk6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAzMi1iaXQsIDY0LWJpdAo+IMKgIEFk
ZHJlc3Mgc2l6ZXM6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDQyIGJpdHMgcGh5c2ljYWwsIDQ4
IGJpdHMgdmlydHVhbAo+IMKgIEJ5dGUgT3JkZXI6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIExpdHRsZSBFbmRpYW4KPiBDUFUocyk6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDgKPiDCoCBPbi1saW5lIENQVShzKSBsaXN0OsKgwqDCoMKgwqDCoCAwLTcK
PiBWZW5kb3IgSUQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEdlbnVpbmVJ
bnRlbAo+IMKgIE1vZGVsIG5hbWU6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEludGVs
KFIpIENvcmUoVE0pIFVsdHJhIDcgMjU4VgoKaHR0cHM6Ly93d3cuaW50ZWwuY29tL2NvbnRlbnQv
d3d3L3VzL2VuL3Byb2R1Y3RzL3NrdS8yNDA5NTcvaW50ZWwtY29yZS11bHRyYS03LXByb2Nlc3Nv
ci0yNTh2LTEybS1jYWNoZS11cC10by00LTgwLWdoei9zcGVjaWZpY2F0aW9ucy5odG1sCnNvIHRo
ZSBURFAgaXMgaW5kZWVkIDE3Vy4KCkFuZCB0aGUgdHVyYm9zdGF0IG91dHB1dCB5b3UgYXR0YWNo
ZWQgc2hvd3MgdGhhdCB0aGUgcHJvY2Vzc29ycyBhcmUKcnVubmluZyBhdCBhcm91bmQgMTdXLCBz
byB0aGUgcHJvY2Vzc29yIHBvd2VyIGlzIG5vdCBjYXBwZWQgaW4geW91cgpwcmV2aW91cyB0ZXN0
ICh3aXRoIHRoZXJtYWxkIGFjdGl2YXRlZCkuCgpJIHN1c3BlY3QgdGhhdCB0aGUgZmlybXdhcmUg
Y2FwcyB0aGUgcG93ZXIgdmlhIE1NSU8gUkFQTCwgYW5kIHRoZXJtYWxkCmZpeGVzIHRoYXQuCmNh
biB5b3UgcGxlYXNlIGRvIHRoZSBmb2xsb3dpbmcgdGVzdAoxLiBkbyBhIGZyZXNoIGJvb3QKMi4g
cnVuICJncmVwIC4gL3N5cy9jbGFzcy9wb3dlcmNhcC8qLyogPiBwb3dlcmNhcC10aGVybWFsZC1v
ZmYubG9nIgozLiBydW4gInN1ZG8gdHVyYm9zdGF0IC1vIHRzLXRoZXJtYWxkLW9mZi5sb2cgc3Ry
ZXNzIC1jIDggLXQgMTAiCjQuIGFjdGl2YXRlIHRoZXJtYWxkCjUuIHJ1biAic3VkbyB0dXJib3N0
YXQgLW8gdHMtdGhlcm1hbGQtb24ubG9nIHN0cmVzcyAtYyA4IC10IDEwIgo2LiBydW4gImdyZXAg
LiAvc3lzL2NsYXNzL3Bvd2VyY2FwLyovKiA+IHBvd2VyY2FwLXRoZXJtYWxkLW9uLmxvZyIKNy4g
YXR0YWNoIHRoZSBmb3VyIGxvZyBmaWxlcwoKdGhhbmtzLApydWkKCj4gwqDCoMKgIENQVSBmYW1p
bHk6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNgo+IMKgwqDCoCBNb2RlbDrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMTg5Cj4gwqDCoMKgIFRocmVhZChzKSBwZXIgY29y
ZTrCoMKgwqDCoMKgIDEKPiDCoMKgwqAgQ29yZShzKSBwZXIgc29ja2V0OsKgwqDCoMKgwqAgOAo+
IMKgwqDCoCBTb2NrZXQocyk6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxCj4gwqDCoMKg
IFN0ZXBwaW5nOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxCj4gwqDCoMKgIENQVShz
KSBzY2FsaW5nIE1IejrCoMKgwqDCoMKgIDEyJQo+IMKgwqDCoCBDUFUgbWF4IE1IejrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgNDgwMC4wMDAwCj4gwqDCoMKgIENQVSBtaW4gTUh6OsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCA0MDAuMDAwMAo+IMKgwqDCoCBCb2dvTUlQUzrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgNjYwNC44MAo+IMKgwqDCoCBGbGFnczrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZnB1IHZtZSBkZSBwc2UgdHNjIG1zciBwYWUgbWNlIGN4OCBh
cGljCj4gc2VwIG10cnIgcGcKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBlIG1jYSBjbW92IHBhdCBwc2UzNiBjbGZsdXNoIGR0cyBhY3Bp
IG1teAo+IGZ4c3Igc3NlIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHNzZTIgc3MgaHQgdG0gcGJlIHN5c2NhbGwgbnggcGRwZTFnYgo+
IHJkdHNjcCBsbSBjb25zCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdGFudF90c2MgYXJ0IGFyY2hfcGVyZm1vbiBwZWJzIGJ0cwo+IHJl
cF9nb29kIG5vcGwgeHQKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBvcG9sb2d5IG5vbnN0b3BfdHNjIGNwdWlkIGFwZXJmbXBlcmYKPiB0
c2Nfa25vd25fZnJlcQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcG5pIHBjbG11bHFkcSBkdGVzNjQgbW9uaXRvciBkc19jcGwgdm14
Cj4gc214IGVzdCB0bQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDIgc3NzZTMgc2RiZyBmbWEgY3gxNiB4dHByIHBkY20gcGNpZAo+IHNz
ZTRfMSBzc2U0XzIgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgeDJhcGljIG1vdmJlIHBvcGNudCB0c2NfZGVhZGxpbmVfdGltZXIgYWVz
Cj4geHNhdmUgYXYKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB4IGYxNmMgcmRyYW5kIGxhaGZfbG0gYWJtIDNkbm93cHJlZmV0Y2gKPiBj
cHVpZF9mYXVsdAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZXBiIHNzYmQgaWJycyBpYnBiIHN0aWJwIGlicnNfZW5oYW5jZWQKPiB0
cHJfc2hhZG93IAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGZsZXhwcmlvcml0eSBlcHQgdnBpZCBlcHRfYWQgZnNnc2Jhc2UKPiB0c2Nf
YWRqdXN0IGJtCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaTEgYXZ4MiBzbWVwIGJtaTIgZXJtcyBpbnZwY2lkIHJkdF9hCj4gcmRzZWVk
IGFkeCBzbWEKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwIGNsZmx1c2hvcHQgY2x3YiBpbnRlbF9wdCBzaGFfbmkgeHNhdmVvcHQKPiB4
c2F2ZWMgeAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGdldGJ2MSB4c2F2ZXMgc3BsaXRfbG9ja19kZXRlY3QgdXNlcl9zaHN0awo+IGF2
eF92bm5pCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBsYW0gd2Jub2ludmQgZHRoZXJtIGlkYSBhcmF0IHBsbiBwdHMgaHdwCj4gaHdw
X25vdGlmCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgeSBod3BfYWN0X3dpbmRvdyBod3BfZXBwIGh3cF9wa2dfcmVxIGhmaQo+IHZubWkg
dW1pcCAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBwa3Ugb3Nwa2Ugd2FpdHBrZyBnZm5pIHZhZXMgdnBjbG11bHFkcQo+IHJkcGlkIGJ1
c19sbwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNrX2RldGVjdCBtb3ZkaXJpIG1vdmRpcjY0YiBmc3JtIG1kX2NsZWFyCj4gc2VyaWFs
aXplCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBwY29uZmlnIGFyY2hfbGJyIGlidCBmbHVzaF9sMWQKPiBhcmNoX2NhcGFiaWxpdGll
cwo+IFZpcnR1YWxpemF0aW9uIGZlYXR1cmVzOsKgwqDCoMKgIAo+IMKgIFZpcnR1YWxpemF0aW9u
OsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVlQteAo+IENhY2hlcyAoc3VtIG9mIGFsbCk6wqDCoMKg
wqDCoMKgwqDCoCAKPiDCoCBMMWQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgMzIwIEtpQiAoOCBpbnN0YW5jZXMpCj4gwqAgTDFpOsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDUxMiBLaUIgKDggaW5zdGFuY2VzKQo+IMKgIEwy
OsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMTQgTWlCICg1
IGluc3RhbmNlcykKPiDCoCBMMzrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDEyIE1pQiAoMSBpbnN0YW5jZSkKPiBOVU1BOsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gwqAgTlVNQSBub2RlKHMpOsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDEKPiDCoCBOVU1BIG5vZGUwIENQVShzKTrCoMKgwqDCoMKgwqDCoMKg
IDAtNwo+IFZ1bG5lcmFiaWxpdGllczrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gwqAgR2F0
aGVyIGRhdGEgc2FtcGxpbmc6wqDCoMKgwqDCoCBOb3QgYWZmZWN0ZWQKPiDCoCBHaG9zdHdyaXRl
OsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOb3QgYWZmZWN0ZWQKPiDCoCBJbmRpcmVj
dCB0YXJnZXQgc2VsZWN0aW9uOiBOb3QgYWZmZWN0ZWQKPiDCoCBJdGxiIG11bHRpaGl0OsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBOb3QgYWZmZWN0ZWQKPiDCoCBMMXRmOsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOb3QgYWZmZWN0ZWQKPiDCoCBNZHM6wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTm90IGFmZmVjdGVkCj4gwqAg
TWVsdGRvd246wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOb3QgYWZmZWN0ZWQK
PiDCoCBNbWlvIHN0YWxlIGRhdGE6wqDCoMKgwqDCoMKgwqDCoMKgwqAgTm90IGFmZmVjdGVkCj4g
wqAgUmVnIGZpbGUgZGF0YSBzYW1wbGluZzrCoMKgwqAgTm90IGFmZmVjdGVkCj4gwqAgUmV0Ymxl
ZWQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOb3QgYWZmZWN0ZWQKPiDCoCBT
cGVjIHJzdGFjayBvdmVyZmxvdzrCoMKgwqDCoMKgIE5vdCBhZmZlY3RlZAo+IMKgIFNwZWMgc3Rv
cmUgYnlwYXNzOsKgwqDCoMKgwqDCoMKgwqAgTWl0aWdhdGlvbjsgU3BlY3VsYXRpdmUgU3RvcmUg
QnlwYXNzCj4gZGlzYWJsZWQgdmlhIHAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByY3RsCj4gwqAgU3BlY3RyZSB2MTrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgTWl0aWdhdGlvbjsgdXNlcmNvcHkvc3dhcGdzIGJhcnJpZXJz
IGFuZAo+IF9fdXNlciBwb2kKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBudGVyIHNhbml0aXphdGlvbgo+IMKgIFNwZWN0cmUgdjI6wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1pdGlnYXRpb247IEVuaGFuY2VkIC8gQXV0b21h
dGljIElCUlM7Cj4gSUJQQiBjb25kaXRpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb25hbDsgUEJSU0ItZUlCUlMgTm90IGFmZmVjdGVk
OyBCSEkKPiBCSElfRElTX1MKPiDCoCBTcmJkczrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIE5vdCBhZmZlY3RlZAo+IMKgIFRzeCBhc3luYyBhYm9ydDrCoMKgwqDCoMKg
wqDCoMKgwqDCoCBOb3QgYWZmZWN0ZWQKPiAKPiAKPiA+IAo+ID4gdGhhbmtzLAo+ID4gcnVpCgo=

