Return-Path: <linux-pm+bounces-15520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2819999F2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 04:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6521C2253D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 02:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DC614A85;
	Fri, 11 Oct 2024 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDDRUB8m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9065C2F44;
	Fri, 11 Oct 2024 02:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612284; cv=fail; b=uJgJhK5ix9pIOfxMEL7Llv6WpwoKvxtU23E8bWcR4dHR5IvZZugzZTvloMmEWwYALfM0JKCuxVLm92gqpjd8DeWoRzNegmi4kFMfjjIh21lqVjmdB1WuXdWUtHBeEYUKbMdkdEmLvTdTHxA9yKeZFKGC2IvdeImXmut/QUeLgIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612284; c=relaxed/simple;
	bh=wbYT9XmVvtcLHu1HtfYvOJ+x6Il/7Kl9VTpvQS861JA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n2XQhyfHN/bF4i1FoEGX7+k/seOITsSBGmyCzKzQiucnlrZ+KatlVXSRIaTjJF1wo7+O+1iif3FucaAyVkMfWtSCXxrzJ4cF0JKBHCJwn52K3K//bR3X0zkvLZeAYuY3FMjYSr2WBJICli3RpuDej9lRWKMRq8Ml8NATqPPXDkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDDRUB8m; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728612283; x=1760148283;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wbYT9XmVvtcLHu1HtfYvOJ+x6Il/7Kl9VTpvQS861JA=;
  b=PDDRUB8mMEdV/rC1gUBOgxUT8GFPXbcxJvqoxEl9gmy4nlQxSwrSiyk7
   YftWUVQvz9Hdm+LPGz7bnE3dpFsUw4EHi2C3P6E+UaZKpuTLmvB2sWIbw
   XtM68wBuoKBh4kLBmTcqYkSnWxijGc4Jxu9qXWQHf5xrF9xL/oT7A/X9Z
   rLyDZPTysAU0Wis03HmTWMFYViLpQOghexJ2dXmo13cobYg0zAqVm62IS
   DIJneJJt0GiVg32gRATEMEqB0bZwy7rcB4bQZNMbIDu5tq+nYe+FPQ3qL
   lVDGmaDuoaCIn8SD66hDkILPJT+7WPOcDKF27R5tojJYFzlLtpFue7/Qu
   A==;
X-CSE-ConnectionGUID: UHyu/tV5TvKmHb36y1FIhg==
X-CSE-MsgGUID: umGb3CtYSomqukAjrt8PaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27895086"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="27895086"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 19:04:42 -0700
X-CSE-ConnectionGUID: vHIhirD0QfWGJJD9LdImbw==
X-CSE-MsgGUID: td/qvp0iSUeI35sCONg0vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="114227310"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 19:04:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 19:04:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 19:04:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 19:04:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 19:04:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqLmS6kADe0Aew6y7kF/Zl6OW+PXhX1jCML6mmM1qvQvq6CWSNzR6GO0J1hmb9QYcL1VYyCayXRmqIbe9z60ycL0Yr5U9FMf3bfjJuDQXg/B4QYIyAOlh/r7FBny+Z6dLIRi28YUCZGsgxNKKF0gIPWFE5euns8ggGd4hVf2ke0vWwNjysCzcRM5Jxc/be0CncwxE6Q1n142BCnXB6UeJ0cQF8mTKv+o16eOO8cE2qZNiDSeEM+zZArbXSdJP94teLBrt38+g7G39ldCdV1sTjKG4b9fkTfjBZDuNewTUUKV/iTaNaemBlxgh140T/PjZuafuQShGC7aScCIswF01Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbYT9XmVvtcLHu1HtfYvOJ+x6Il/7Kl9VTpvQS861JA=;
 b=MA6poRhjAe/haa3h2hj/u+HIivcHV/RL1MjIyHlv+CuFcZiarZkaUsyf5y/8ABkrnKcfpcNtQZ9jMS4SbDHJGG/HjaeS8rndlj1ZG2d9j45yxqFppJinTJVIPtyFJUOolSQI8fQr8R6AE8Lp5Mh0EN35+P6xiwELHnlakBjMdSlf7J0BZmNtL+WZesqXdUNB8Msnup0TJ88MPiAQ/Fn1WqwyUKczAUhuSMklZa0/6ScUt0s40Flv/xkNh8wA4fMalMgCU3F1xgYeoWIxf9fbJQjjruYASq5EkUanuS1p+s4F+dj+aZfuNTtX3oDqimKR1IQx8mf/yqkMWq9m6Y0veg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CY8PR11MB7899.namprd11.prod.outlook.com (2603:10b6:930:7e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 02:04:38 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8026.020; Fri, 11 Oct 2024
 02:04:38 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>
CC: "Luck, Tony" <tony.luck@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "thorsten.blum@toblux.com"
	<thorsten.blum@toblux.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"yuntao.wang@linux.dev" <yuntao.wang@linux.dev>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Pandruvada,
 Srinivas" <srinivas.pandruvada@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH V2] x86/apic: Stop the TSC Deadline timer during lapic
 timer shutdown
Thread-Topic: [PATCH V2] x86/apic: Stop the TSC Deadline timer during lapic
 timer shutdown
Thread-Index: AQHbGhvZfNGMa41IfUyc5MO9dEzvXrJ+slqAgAAPuACAAfbPAIAAFsCA
Date: Fri, 11 Oct 2024 02:04:38 +0000
Message-ID: <8161ce3f9c874539195c53feb34a5cee421abf96.camel@intel.com>
References: <20241009072001.509508-1-rui.zhang@intel.com>
	 <f568dbbc-ac60-4c25-80d1-87e424bd649c@intel.com>
	 <CAJZ5v0gHn9iOPZXgBPA7O0zcN=S89NBP4JFsjpdWbwixtRrqqQ@mail.gmail.com>
	 <edb18687-9cd7-439e-b526-0eda6585e386@intel.com>
In-Reply-To: <edb18687-9cd7-439e-b526-0eda6585e386@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CY8PR11MB7899:EE_
x-ms-office365-filtering-correlation-id: 013cf7ea-f0d7-4110-de13-08dce9990fc3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N1NMMzViTm1MbzRudEJnUEZUcGc0WHlUNXd3TWpyS3kvWlgzWkZZZ3M1ejhu?=
 =?utf-8?B?OUc0bU1Gb2E4TmNKd0N1OVZSMkt5WTBEcWZMTmxGNTBHNENIV3VRckQ2aEhr?=
 =?utf-8?B?bVM0clU3UFdya280N2taYnRBY1lhU2YreG5BRVhHbk43TTREYWs5eDdYNjU0?=
 =?utf-8?B?c3BLVUhNamVWR0NmMDNoaFlGeUlvUUZHMmErQ2NjRi8xUmd5ZTNSbFY4eGR1?=
 =?utf-8?B?WVVib2luOTE4OVZOSWdRUGJxb3Fqekc1aHVONW0yMmVsUEdOcGpZWm9UWW5L?=
 =?utf-8?B?TGlySFZPM2RHN0pHVEdnNWVQRlhQYXpTS1AyUGE4UlpFS2ZJU3B6dWpyaGNH?=
 =?utf-8?B?NXV0bi91V1ZsT2VWK0p3ekpJU2JpNUlJRDZHMFNQQ0VUbUM3bGpFR1pPNTlM?=
 =?utf-8?B?N29BYXU5bjdWOElFZE9sVjRLWVhvQlRPK0VaK3lndGZFVG15d0tIN004R0Zh?=
 =?utf-8?B?SGVwWDZVamdSdHZkTkk2QjRVWjMrWlpHSnZSSkszQ1h5NURYby9kUTArK0Ft?=
 =?utf-8?B?YitCRjBqZFhMR3JnYklialV3Q0FXWnRhYzA2ZUxWbGFvSDZMTitBbWRFdG55?=
 =?utf-8?B?Zjc4NGtTVDVlK2ltY1Z2U3JjM0hyZCtucWVjWUhVQzk4TDE4aVZQRUJzclZL?=
 =?utf-8?B?bUF0dUVHVDVKUUtXQ0k3NjF4Uk1sbXdlbVNuOWhMQStGcjhCdDV4dGlFd0Yx?=
 =?utf-8?B?aUd5bk9TVU1pNGRTdjhrN0Njck92TWtCd0tKNGF0OEZRbi9vUExiYVI4bVV6?=
 =?utf-8?B?ZzduZ1FZTWFTTCt6eE10dHFJeUk4T3VnZWxKYzl1RHdrMnBjSG9YREV1TmxY?=
 =?utf-8?B?MkM2VXVadlpyVDlQMk5ncSt1UEt1bUJjSjcxTU1tZlpMNElvQkZtQURjY1Q3?=
 =?utf-8?B?YkorcG5kV2xhZXV3Y0s0V2I2bEN1ZmlMb2N5K1FZbnpGYTFSZms0cXhFNXBS?=
 =?utf-8?B?NjM0T0M0UTh0MkdNSDJBNEQ5bjdYNkorR0s4RlBPK2Y1MHZTeFd6UWU1R0lL?=
 =?utf-8?B?dnpyaTE5NHY2SlNyQVNHWXhtcjAvVi9meHZWR21wcWN0VUxlTm15WnJOY1FQ?=
 =?utf-8?B?TlFiMG9jRDBraVpjeWJKYmVKQUw4dkVmVDAzUUU2Q2JpWUpCcHJQWExJRk5N?=
 =?utf-8?B?MHlhaGEvOWRtMVhzSzl6YzF4Vk80Z3ltTUpRTGdZS1BtSjFzVnRtY2hyRlNl?=
 =?utf-8?B?aWx0dWZwSWluWkFDa3lFaHlDZ0lCYmZpdllFbHJJSDVjNG52a2lSTldrck51?=
 =?utf-8?B?WHI5VDlGd1ZVOTRuK2xLUjJlN0p5aTlOVUpnSlhKZEQ0WGQ4SFAvVjRhRFRJ?=
 =?utf-8?B?Uk1hYWtJUnZlMjBuZVdKdjl5NUw4VFRYM3h0NlFjdGVqb0VPOFlrQ2F1UnJh?=
 =?utf-8?B?NGg1Z0RKQitvNUJJZVJ2N2lSYk5UVjNzUkNZQTFVMkdOMXJRcUZzSXpEMnhy?=
 =?utf-8?B?bm5KdjZ1OGJlNlpFaUhtRXcrMC8wNWZlS1lyVDZNbjBESG8vOWlmcmJtUEtj?=
 =?utf-8?B?SWpPSDR5d3NOdnNLc2Iva1VITU8wdHBzNnRZZzhMbWM0RUlscFZtQ21VS1du?=
 =?utf-8?B?SDdvVkNmS2pPaExGaEo4M1k4dGRFSUpSR0JoMVBhRDVoS2haeGpTVm1XdmdY?=
 =?utf-8?B?dVM4RDZyaDFHTlVmcTg4Y1JxUzNXc0dQcW1SZGpTUDFPR0lvY3BlWGpsemF4?=
 =?utf-8?B?MnBMNFo5SXpVOUc5R29BaGhZWk1XUm1hQ2JoTnc2THNUbG1OamZUVFIwYTli?=
 =?utf-8?B?endjcm5pYWlneUZpazhDN1ovZk9SOXpZN2hjM2d5THJzcC9UWFVrT2pUTk8w?=
 =?utf-8?B?S3VmTHlZcVRsa2ZpQlBhUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTVFbnFMRW1CT3lLN0RleWdxNnFJN2djVDl0QUVpRkF0ODQvcDRyWC9Ddk91?=
 =?utf-8?B?YUZxTkFGTytGczg3R2dWRFN4ZFBNd1FtWUloUWxUY1p2R0oyRmREZmxDeGdB?=
 =?utf-8?B?NTBRQWVMZHIwZkJJNmdPY3F4VnVPbTFWeTFudi9xalZhM2JkNHZQMDJpRXJx?=
 =?utf-8?B?ejM0RCtZRWFTV3Z6YVIrVDFJSGtEUWVBRE8zRFVCYk5oY21EbXIxNVl3SVRC?=
 =?utf-8?B?YyswekZqY29wZWwzMHJUemd4cDNTMWhuazRDdS9vMDNxNnJHOWZSbHRMOVJC?=
 =?utf-8?B?K0NCSFY5K3ZybWpORjE2QngrN25BUzc5d21ibFB0azllV04yVUVnREFXNlZ0?=
 =?utf-8?B?MHBud3gwNjF2U1pJN0tRQi9zZ1V3MU9hRkdTVlVyYmNDV3FjWVpaVVIvQWVX?=
 =?utf-8?B?QVo1UDZ3MDZZNWFnL0NRZkttZy9SdUQ3a1Y3ZVZvU0FHSTdFbnoyaWJXSzc2?=
 =?utf-8?B?bmQ5cVdudkZCb1UzaEFmTk9qZ1hpZkU1WE1qVjBBQUlUaG9yaUZLRG5uQWpx?=
 =?utf-8?B?WEJ0VEJkYWVMeWR5M3g3bHRSUktvOTFnanR3bGhVajZTVkR1a0thZkgvRUln?=
 =?utf-8?B?cEFPdEsyejVWTy9WUTZ4SGIyRUJlRmFmNndjVFVKNktuNnp1TnlrdjJhUm1J?=
 =?utf-8?B?NW1iQkI5UVU0ekpkYTdXS256RnZ0dEFyS0xPbk1tVnM3QzR2alU5aHlZL0Zv?=
 =?utf-8?B?WFNWQVZtd2tadHNvTEhQS3UwaENVQ0dxSXp5N0phSzR5QWVjdEVxUzFBdklv?=
 =?utf-8?B?NHRtS0JRWElNdkxPMHgzRmJCdUorZ1NLK0hEczU4T1JYazE1RGx0SGl3MXh1?=
 =?utf-8?B?WThFeitzanBPSjgyZUdzWVVwZHl3OWNtZUVnVVg1VkV5UVp1ZFFVUUxmNlJ4?=
 =?utf-8?B?NmRkbEx3TDZrdWZ5MW9lUFUrWEkwNER6TFdsVm9PS3p4OERmZnhDMVpadkwv?=
 =?utf-8?B?UEYrbjV6NXhmVGFlOXpURHFHOGJhM2dlcFlEeENsOFJ1NEIwZHdPMjg5TnBT?=
 =?utf-8?B?Z3grWGI1Mk96blpvdC9ZN2I0Q0ROV3MyYUZ0b2U4dHVMK0s5WmN5OW9yN01M?=
 =?utf-8?B?N29yVkpRdTg5ekVvVndMblFDSEhuYkJLSEtyZzd0RVdEemdqd0J6NDQyS0pZ?=
 =?utf-8?B?S0J6c09Jb1JFbHNuK2Z0Z0tuTjNINDVHd2lrN2NuWDRVNTZPWngxUDRWVUpx?=
 =?utf-8?B?QTZNM0JRUitNZE1yTUt6b3RXNWxrNFhlbHdLOUVzc2l4akV2L2JGTVQ0eDhj?=
 =?utf-8?B?ZTRYdzRteVdEZG0vbmFwZUpjMGdDNUJhby9tYTVRVllLaW1aQmFLbDZ5clp5?=
 =?utf-8?B?QXdpSFFUVC9tTnBxdnBqWWw2M3JKb3g4K2pRRHl6VWtaOHViUlhoeTljUElt?=
 =?utf-8?B?bEJMaTNBSDlvS0hYc0QrTTNxS0hEeTJZa1U2NUF6bks3OVYyVDdMWEMzSHVN?=
 =?utf-8?B?L1ZaZ2kzRnl6Und1akw4blBVMy92aXhnOVdqQVdITWJZQXRrVzJuUUpta04y?=
 =?utf-8?B?L0J0RkZoMkZmcU1yRHRZN1FXUHJ2cG9vTEJub2NldjhKMHZmcDlOM3Q1STUw?=
 =?utf-8?B?OU9ockhQWmgwZEJSZk5ZdnJMa09jaFJvYVVYZytobWNqTDl3clROaHAxY25O?=
 =?utf-8?B?bDlrZDBTMjdFdDFGOE0wUzU0VENkVWFWUm1Oa3RoaCt2L1FqR00xd0JraTJ0?=
 =?utf-8?B?QytmQldlTXJ4bTJGcmZ0bUVac2FJNkpNKzcyMFVadzR1QzVoaUdBaGc3V1cz?=
 =?utf-8?B?Tm12M2liQmt2aTB1Z2RoSks4SEZDMzh3SENIU01GRStPNm1SeTlPbXBBRmwy?=
 =?utf-8?B?dFlURksrYXhpMkQwR25hczVQNXBQLzQxWVg1QWV1cGRUVDZxQWNPSFNGK3RM?=
 =?utf-8?B?K1R0YnV3cmVKMWpjUGZtQnV5di9lbEZIakhNOVA2K0tSSGFaUFdQZEJmZU9z?=
 =?utf-8?B?TUFsMmtPVFliRFpxbW1JWkxvNzFXMm5QMS9MV1ZxdThyS2JZRzNWY09na0J2?=
 =?utf-8?B?VktjbXFwdm43Z1UwK21OSGFCK2tsVXFDTDhqU0FhYkFPaWhtUnJ5YkUzOFRo?=
 =?utf-8?B?LzlOVHVpL2I5MFBxU3ZPMHMxTXhPUXArVmg1U2IwMExnUHJQQlBJYUNSZFhV?=
 =?utf-8?B?VGxpemN0TVkyUHpoWjFkM0Yxcmp4MkZ3UFRhVkMrdUZSRzc1cG1VenFTZmx2?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <540A931140E0C54AB8F3ADFAB6D4652A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013cf7ea-f0d7-4110-de13-08dce9990fc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 02:04:38.3016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HgUM8yJr1Bz/6iNa1VBss19ctfmGYkDg32PcaPJA+IkYQnjO7Ja9HQo2Gj3nJ5OLQqG+G6mFQt9Q7uya9af7ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7899
X-OriginatorOrg: intel.com

SGksIERhdmUsDQoNCk9uIFRodSwgMjAyNC0xMC0xMCBhdCAxNzo0MyAtMDcwMCwgRGF2ZSBIYW5z
ZW4gd3JvdGU6DQo+IEhvdyBhYm91dCBzb21ldGhpbmcgbGlrZSB0aGUgY29tcGxldGVseSB1bnRl
c3RlZCBhdHRhY2hlZCBwYXRjaD8NCj4gDQo+IElNTkhPLCBpdCBpbXByb3ZlcyBvbiB3aGF0IHdh
cyBwb3N0ZWQgaGVyZSBiZWNhdXNlIGl0IGRyYXdzIGENCj4gcGFyYWxsZWwNCj4gd2l0aCBhbiBB
TUQgZXJyYXR1bSBhbmQgYWxzbyBhdm9pZHMgd3JpdGVzIHRvIEFQSUNfVE1JQ1QgdGhhdCB3b3Vs
ZA0KPiBnZXQNCj4gaWdub3JlZCBhbnl3YXkuDQoNClRoYW5rcyBhIGxvdCBmb3IgdGhlIHJld3Jp
dGUuIFRoZSBwYXRjaCBsb29rcyBncmVhdCB0byBtZS4NCg0KSSB3aWxsIHRlc3QgaXQgb24gb3Vy
IHRlc3QgYm94ZXMgdG8gbWFrZSBzdXJlIHNraXBwaW5nIHRoZSBBUElDX1RNSUNUDQp3cml0ZSBp
biBUU0MgZGVhZGxpbmUgbW9kZSBkb2VzIG5vdCBicmluZyB1bmV4cGVjdGVkIGltcGFjdCB0byB0
aGUgb2xkDQptYWNoaW5lcy4NCg0KdGhhbmtzLA0KcnVpDQoNCg==

