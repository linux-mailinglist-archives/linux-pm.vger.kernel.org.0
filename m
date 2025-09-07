Return-Path: <linux-pm+bounces-34105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A67B47B09
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 13:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1612201089
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 11:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D236264619;
	Sun,  7 Sep 2025 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISKi/Z8b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EEE239E9E
	for <linux-pm@vger.kernel.org>; Sun,  7 Sep 2025 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757245212; cv=fail; b=lnZYSC7/6mVoRrYJiG/Hk+/tXZjn6wlIeHipMpAw2sffW3qZgkMVimzRMjJL3Jyw6xx7AM86KUeTtqkirBQfvw754NVnSdeKFWVlBV0X8w8tPTlBfBPjxlAbO8uGRbAnGs5J3wqmFrbvT1kulBbzjH1OdJ40IKingKPK6CqOHpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757245212; c=relaxed/simple;
	bh=45wxii0ZHk9bj0RZmR1VWLZRIN2oXCcPHDJKHEY70p0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u/jy0+BfFIwr9uttImENjzDdFhT/QSSYGTPzTte8ZQo33rVIsKIUMc+7dqL83VvglsbFNZZ90/jKhz14u64BZEEAlpkK4WI2IP8VGcLOumnuwWscXRAnCv7FafelmeaJV4VwTpiJXP7lIG/MDJ9bX78VwfHEaD1v3VXpuAVRg1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISKi/Z8b; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757245211; x=1788781211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=45wxii0ZHk9bj0RZmR1VWLZRIN2oXCcPHDJKHEY70p0=;
  b=ISKi/Z8bdZ2qbJadOrslnrck8Fnr1WyDY+ar/jTU4eLV8rlpdkWrb1bw
   SDO4f+WW5WvffCLfmQLzo6Z9GNjJw2MTG0SkxPdVSVxEPC5sQ3YdR9B6r
   UmTZc7Bmdk8ezhnvXmzbFEcqgbE5P5nCNEE9He428MhRLweVGCuGTcjsN
   lzwu4j6HDBgiHTz3ydWpdt6RMD1dhQUSkZ1R/JP0dmbTu9iRba4vC7FmI
   1w1aKUavgXRhM+Ipp/iycEH64dyECx3lWc44GcuQ5C+lF/puSNqBgvTdD
   Rns2Tu/2h36Ak1rG62eW9GmAQuW89tYDdVsm3vDMZpUp2ZSCb8CGy8Tkp
   w==;
X-CSE-ConnectionGUID: ICBSVmnqRamCaLrMdbtwrA==
X-CSE-MsgGUID: ROzv6WEzTFSy8zhXlKYBZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82114709"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82114709"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 04:40:10 -0700
X-CSE-ConnectionGUID: uapv4BNSQyeg8HVvm/G1ww==
X-CSE-MsgGUID: Jj9IXHnGSLWIFmXHfVwLGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171813128"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 04:40:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 7 Sep 2025 04:40:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 7 Sep 2025 04:40:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.54)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 7 Sep 2025 04:40:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvcjoKSnaohbct8NZ5J1cMkxckIQ0ij34dK37CLcTWY1GJFd+svd/o3SC0IbGHlQoyjEuzLtQrNytTpgOSEngHu4/FyI/KypNCOYK6QjFuNIsb2P2wRy3Ul8hC4AzJMplYtPnKQQWpRPgcvODD0Mts84jQmuoe0INChMdW7Q2OrVJyP1uBtBGMD+uenFj2CE5fhiXDb2nSz3LQppbNy1vcWsQw6ZrVI9qPSXSKMVmFBUuz2fqkd402fRZVEoiF9makO+OliXLjpCSJc9/KLB7lRzUmUKiBms11rPsXJtCA9NvahFpyy1u8aM3bytYd6yQD3f6Ybl3ouzIg4aSP7XNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45wxii0ZHk9bj0RZmR1VWLZRIN2oXCcPHDJKHEY70p0=;
 b=b4tT8cIzfPcjEtwDxIlUbNB7w25pTmbXfoDzxN3kGLxzf5WDiY/Fw5oAShpGOrI4RwWB6aYzFVxzne2T4cpML1b+6ShihCc2blpmBBb/UcqKeuJTMpf2fw3FaOZNZZtsX57jkXzfdq3p2QwynUZdN6rO3coGrucZHe0MQZKLo4+Uhhz/v7NUTArCaiKhCeAftU/9BtD1xp+mSveEYHx3CyePEwYwlK4wahFT7ZGQLz9RemL5gsyhnHFx0dU2AwJoroC220DL6uefYAvJVGHpbhHoLhBO8nXZWz/7UVnB7f8uj0jPCBhNhfgRpreMxXXvDONfB4NSkCOQTqbCySINVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by DS0PR11MB7310.namprd11.prod.outlook.com (2603:10b6:8:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sun, 7 Sep
 2025 11:40:00 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%4]) with mapi id 15.20.9094.018; Sun, 7 Sep 2025
 11:40:00 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Chanwoo Choi <chanwoo@kernel.org>
CC: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
	"cw00.choi@samsung.com" <cw00.choi@samsung.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH] PM / devfreq: Fix memory leak in devfreq_event_add_edev()
Thread-Topic: [PATCH] PM / devfreq: Fix memory leak in
 devfreq_event_add_edev()
Thread-Index: AQHcH9xhPkVgqy4HNkOc9PMjfp9y07SHlyjg
Date: Sun, 7 Sep 2025 11:40:00 +0000
Message-ID: <LV3PR11MB8768AF18A57F706B3F75F646F50DA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250907085942.3278910-1-kaushlendra.kumar@intel.com>
 <CAGTfZH12WSf0osq__7LGnNe9tsmC-+G1HPfJgY6j2eTmXAT_nQ@mail.gmail.com>
In-Reply-To: <CAGTfZH12WSf0osq__7LGnNe9tsmC-+G1HPfJgY6j2eTmXAT_nQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|DS0PR11MB7310:EE_
x-ms-office365-filtering-correlation-id: 7dd4b318-39e8-42d5-644d-08ddee034774
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZEpnc1VOdU56Mmo1TnBROXF0MzZIYktZaVhtUjM0Y0x3S2dHWGtxMzNnM0Rv?=
 =?utf-8?B?a0p0UHpnRnJrdFd6WWdvOCtBNVYrQ1NkU0Z6WnJBd2FkMHZLcHREdHBCcUtC?=
 =?utf-8?B?WS9TemhFWnpib29IKzVWUm5TNFJvMDNjeGZPMTd2MEF4ZC80eTNwKzRrdWtW?=
 =?utf-8?B?Y0Urclhsbnh6S1JMSE94TCswaDliRXVBMmFvYXR1bHlSK003clBaSnBzTVFq?=
 =?utf-8?B?ZUNzR25OVjhxMHByVUZud0pvZ2hVbktOem5HMnZHMDl1RWhwSGZlNzNFaVhM?=
 =?utf-8?B?NlFsRGtCQ1JlTk9zNE9ycjFVU3gxSlZCVTNUOWovOHZpRTVhYmFFMEJ2a05p?=
 =?utf-8?B?YkNmaklSWFJiQXo4TkJ1UFZrVE1GVjhkc0lXcXU3OFAyN0tCQmxLSnRxblIx?=
 =?utf-8?B?b1VqVFdsZGRTWVBSb3B2UjdQSEdxMmc1QytpbDMwZ2tUNmJBR2xycHFUOXl0?=
 =?utf-8?B?OVBkYWo3SEw4TURua0RwVU90NmZuVkk2UC94WmxoS1liS2JmUUcwNHRWSGcw?=
 =?utf-8?B?enI0WkVMSDRyWmVKRC90VkZqbDFjbnllZG5kbmZsMVFXV2wxSW9RWUo2c3Vw?=
 =?utf-8?B?dmZ4bzNFZmJIRTZCMUNQT0t6cllXRnpCY0paYXo2WkRCZnNRYUdGMFh1T2xv?=
 =?utf-8?B?ZmdxS0dETEhjWTErdnFXd0dQdnlnODd6aDc5eXEzVEJXNkxaM1dEL1ZKRms3?=
 =?utf-8?B?STNzYlhXUGFQRmIvbzU0dDVNaWZmMU1HcDhsOVFlWE9iM0FSOForNnVIaUpE?=
 =?utf-8?B?aE1iV29EWmVhVnN2NmRuK3FCWjRVRGdGeTcwcUhYZ3ZzUTZqODdXWUJOSVFJ?=
 =?utf-8?B?RXFpTEJDejNEWDkzV1pTRXkrSG5pM0FMQ2p2dHVBWkR4L1BTc08ycjV5Yitp?=
 =?utf-8?B?K1pkcmJkcEYrQnppcmxzNXcyc3N6b3JKOENTanBHUVpSYXNsZDRTMzZYNEpQ?=
 =?utf-8?B?QmE4RldRNHVqVkdnQ0ViN2ZLRFV5NzEzT0t1VVhOVEhvSzNvcjNCM3lmQkt1?=
 =?utf-8?B?VGJPalZ3dHdsTHM1TTJmWTArM0JEZkdJalp1ZWJDY29aNW5tVSs4bkl4Y0Nj?=
 =?utf-8?B?SWQzYTBlc3UrUW50U0pueC9OZVdkRkVjMUZJQndFL1d0YnFjd2pFdFJuYk9Q?=
 =?utf-8?B?SDlQTzNTQ0hVSHVCblN3UXZSbnZmOWEyNHhCMkpRSHRLQVZBTUFLZUxUb0R6?=
 =?utf-8?B?SDRZMnZEaUlYemlpWUdhdUt2YnEyMUQ5cG14UlpYSHlTVExoZUx2WTNvVXpy?=
 =?utf-8?B?alJBc2RqOFVna0YwaFhuVkRkcG40WmZyWm5YWmU5YkVWNlVyOVhnMnp2R2ty?=
 =?utf-8?B?RlpsSFVzbUVxMzNlVFVZUDBtclNOYTlXbXNsYVNiZlZPWmlLbDFTV1pza2ln?=
 =?utf-8?B?R0JjT0JJWEdEVFVkWVZ0blJSd2syR2c5bkJpTjZkblIwZUl6UmRtcmIrTCtZ?=
 =?utf-8?B?THE3Vk5HMjhUWFBCVVBKQmhycHdHWXkrMTRiQUpFY0xsRTJwM1pQTnhNVXEx?=
 =?utf-8?B?a2RKQWRVc2lra0RWM2pTQTdFa0xENEJoelJQdlRnLzEyclY2aC9oUkdEM3Jq?=
 =?utf-8?B?c004cEYrRzdkWW1mQzc4cjBJSDFaNnNwWDdicXVXRkJSbkVLYUV2cXFwWERO?=
 =?utf-8?B?SlQzaFl0czFVZzE0TVg5ckFKd2xBcTcyNkRSTFhPZ0prRlZINGsyWkhycVhv?=
 =?utf-8?B?OCtnTjN4TXp2cmJpMDVQTGJiMEg4Rk8vaDlmTlVsN3NtM3BWOWVJYVhlZkZ3?=
 =?utf-8?B?aVZHclhWMldrcS92MnhFL3RsVDVhUFFqVUNQQTl5QnRha09HRm92cjFLcWp4?=
 =?utf-8?B?aFdLRDN4Mk1sMXdLeWUyVzg2eUcrK1VKMjVXQmVWVzIzT3Jiam1ncXBuOTY1?=
 =?utf-8?B?YUhIbXg0MXJNUjVDN3NaL2gyakxLcHpjS1BNd1JrNG1Hb0RabS9pczQ4NHl2?=
 =?utf-8?B?Ynp3eFBWbHJzY2FucUJzbGdIN2Z6b3NpVFllc20xaXNmcms1OE50MkFORm5Q?=
 =?utf-8?B?RklyQUVOQVdBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWZEb0dydHFQWWkrd0xDTi9DNHRHbWl6TTFmVjYxSjlOTFJib2pDTmQwZzU2?=
 =?utf-8?B?dWFLZEV2OEkzRVc2Q3R4dUJ4V2V0QkZrY2lCYVp3TWxqSCtLNEJEZDZWU2F4?=
 =?utf-8?B?NXdhUDZJOTFCZzB0MlZvYWx6U0JSR3Fxc1lUK0V2WjcyMnhsYS9zUEhBN042?=
 =?utf-8?B?dzY3NlUrZzc3cmI4cUp0RHRDUnlWRmVwUkJ2aElBS3dIaWdIM0VEdVRhTlIz?=
 =?utf-8?B?YlZXMyt6eFBsODlVZHY4YUlieUx4TG9Sb1lXOWZDVGhib1U4MlZpV3paa0gr?=
 =?utf-8?B?NTlQcnZ6Z2V0Y05MTEdGZEI3TDdlbjNCenU4VjhqT0pVaWNxNkk1dEFvanhZ?=
 =?utf-8?B?TW1xa2l5WXQ1TnE4Vy93dDdXRXZKRXVaalU5TXlIUGhNejFGSzd6UkFPYWU1?=
 =?utf-8?B?SUZKSFNYb3RPQndlZkpzY3lNZ0hFTGxUYjJVRW9oRkVsdGFTeGhRVEJQM3Fx?=
 =?utf-8?B?bHRuLys0YXY1elExREFiWU0vZ05zTHg1ak5LY0tiTURzSGZDNEZrSWN2bUwr?=
 =?utf-8?B?KysveklXWWVsb3drZ3piOW9aYlA4MldLdTMwbEkyYlM5YnVpZU5Ob1hTRk00?=
 =?utf-8?B?clhYZm5xWUhWd05nbXJ2MlMyQStEOUpkYWJWZkpKR3FwdjFnNXI2Z09kTzB5?=
 =?utf-8?B?d05JVjNDMlVxaGVpWmRtaXczVG5MdnljSzBkMkZBWTF5Q01zdEs5Si9sU0VT?=
 =?utf-8?B?bnVPSnBvWEgyRElHZmZMcHhmQXFrTGJnV3EzOUxSdFhXWUFaVTQ3eUdqeFVH?=
 =?utf-8?B?M1UzN3FnbDIxUWd3eHUydFZjVUU1Y2huaTRwc3p6UzlZNm5CTkt1T0M1WDhC?=
 =?utf-8?B?RzRsbFQySElMRS9QUHVLcy8vSjFIbGROdERLRjhPOU1iQVJWSTZ1SHAva1pt?=
 =?utf-8?B?ZjhMVGtzcFRhaFE0UkIwY1Y1OHNwTE5aRDFOM0hXRCtyb1pWSnZxQnlrY3V6?=
 =?utf-8?B?dXV5SnVqMU1OaEVNRXZyR2dNK2ZvajFncnhERFBLMmtNVElUK1JlSEFnMklH?=
 =?utf-8?B?SDdTREM2eUVKRGVEUEZjdUJnazNWb3RPNmU2czMwNnkyY1M4VG1ORlZMMENS?=
 =?utf-8?B?NlI3dDZwaE03T2VaRXpjQW5jL2luNkdkQ0JpSEYwTnBadHRRSnRtSzJ5ME5J?=
 =?utf-8?B?Wkw2bUtrYnJRejhmTVNLaDJDcnZGclJzT1dJeS8yVjc1Ty9tYjZ6cDRLNXM1?=
 =?utf-8?B?YVZ6UWs0V1VsTEpqK0pXU1RnVER1T0JuMnVOZUJiNTdPY1k0NURNMEEvbmZp?=
 =?utf-8?B?VFZtZDlldlQ2UHFUVkNrTnowazFnT0F2Y01ZRVYwQjRXbmxCbzdOcTYyM0dT?=
 =?utf-8?B?dFNKeUFBcFFSMlcvREV5T2kzNkdIc0djZUdnTkwrK0E1OFFidFJMQjFKM01a?=
 =?utf-8?B?OW1MenEvL3ZOeklDSlFJbnEwUVpyMTdlN3FLTzJWY0tTSzZFZm51dnBLdVAy?=
 =?utf-8?B?Y3NUVXpHa1N1UlhLZHZ2Q2JNL0tEUmZhZDlNSjJ0NCtOcmhmNDJySVJhMk1p?=
 =?utf-8?B?blRKSWxqRVN1TCtlSE9EUEt5dkw1UXFnak4zM3VDNkdtL0E3Vy8wSCt4K2tj?=
 =?utf-8?B?NzBvTk9jdzFpajZmZDl0WDZNaTY5V1NZUVpYRHpSVENaUUZnNWF5K0NmQzl2?=
 =?utf-8?B?UFYra2tDeUlONDYxSER0ZC9HRmcrOGN5dUd1QkJnZGRDQXJWZVhxbXVNM3NW?=
 =?utf-8?B?emlEZUlQSW9lRE91YmFXT0pGVDdrUGdXeUxpNzJISURDZ2tNeEp4KzNvQXZJ?=
 =?utf-8?B?eHRXenM4WXJCRCsydXlzRXp0MHR0aDNScUNiV0t3WUVGSFBaUFhoWmxhMk8x?=
 =?utf-8?B?K2JreHVNQkxTNytIMmVQUHF3ZWhTTmM4aDUxSXo5YlJMSlBtaFhMeVpjc3Nt?=
 =?utf-8?B?dUNIc3lZaWM3ZWhNTkJmT0lTQ2VpQm5waFd5aHJad2NmYW94cnd0alZGSzJz?=
 =?utf-8?B?b09YYm1RRmJLMjVGNnpEWnVGNk9uRkJmL2VWTkd2aGZ6Q2pkWFBqektESGYx?=
 =?utf-8?B?aE4wMFROaVJUQ2UxcEd2U1RnTk1WTHlQd3VmcG56SlBXZWczU1prQ2p1d1A1?=
 =?utf-8?B?Uk5sQ2Q3bENTaHR6QTdoUEtxbGN0YUV5cHBPWC9BK1B2RERMWUNOdld3MjE4?=
 =?utf-8?B?UVVNbms5UEdsUEFpZjNRMjJrOGwxcXI0Um1oTmV2b09RS0FVbFVJaGg5M3dR?=
 =?utf-8?B?Mmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd4b318-39e8-42d5-644d-08ddee034774
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2025 11:40:00.7017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7LfebZ+svzOtZKZsmRMd/vWQk0E7/AECf2esytUCquFrCh/HOiDeRTcGuERzCO0vVBn98EPrEa6YzLh5KLBEh2dT2vTyELH3yj0GWd1MRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7310
X-OriginatorOrg: intel.com

SGkgQ2hhbndvbywNCg0KT24gU3VuLCBTZXAgNywgMjAyNSBhdCAzOjE2IFBNIENoYW53b28gQ2hv
aSA8Y2hhbndvb0BrZXJuZWwub3JnPiB3cm90ZToNCj4NCj4gSGksDQo+DQo+IE9uIFN1biwgU2Vw
IDcsIDIwMjUgYXQgNjowMSBQTSBLYXVzaGxlbmRyYSBLdW1hciA8a2F1c2hsZW5kcmEua3VtYXJA
aW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBtaXNzaW5nIGtmcmVlKCkgY2FsbCB0byBw
cmV2ZW50IG1lbW9yeSBsZWFrIHdoZW4gZGV2aWNlX3JlZ2lzdGVyKCkgDQo+ID4gZmFpbHMgaW4g
ZGV2ZnJlcV9ldmVudF9hZGRfZWRldigpLiBUaGUgYWxsb2NhdGVkIGVkZXYgc3RydWN0dXJlIHdh
cyANCj4gPiBub3QgYmVpbmcgZnJlZWQgaW4gdGhlIGVycm9yIHBhdGgsIGNhdXNpbmcgYSBtZW1v
cnkgbGVhay4NCj4gPg0KPiA+IFdoZW4gZGV2aWNlX3JlZ2lzdGVyKCkgZmFpbHMsIHRoZSBlZGV2
IHN0cnVjdHVyZSBhbGxvY2F0ZWQgZWFybGllciBpbiANCj4gPiB0aGUgZnVuY3Rpb24gbmVlZHMg
dG8gYmUgZnJlZWQgYmVmb3JlIGNhbGxpbmcgcHV0X2RldmljZSgpIHRvIGF2b2lkIA0KPiA+IGxl
YWtpbmcgbWVtb3J5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2F1c2hsZW5kcmEgS3VtYXIg
PGthdXNobGVuZHJhLmt1bWFyQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9kZXZm
cmVxL2RldmZyZXEtZXZlbnQuYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS1ldmVu
dC5jIA0KPiA+IGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEtZXZlbnQuYyBpbmRleCA3MDIxOTA5
OWM2MDQuLmYwZTdjMzFmYWM1ZSANCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2RldmZy
ZXEvZGV2ZnJlcS1ldmVudC5jDQo+ID4gKysrIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEtZXZl
bnQuYw0KPiA+IEBAIC0zMjcsNiArMzI3LDcgQEAgc3RydWN0IGRldmZyZXFfZXZlbnRfZGV2ICpk
ZXZmcmVxX2V2ZW50X2FkZF9lZGV2KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiAgICAgICAgIGRl
dl9zZXRfbmFtZSgmZWRldi0+ZGV2LCAiZXZlbnQlZCIsIGF0b21pY19pbmNfcmV0dXJuKCZldmVu
dF9ubykpOw0KPiA+ICAgICAgICAgcmV0ID0gZGV2aWNlX3JlZ2lzdGVyKCZlZGV2LT5kZXYpOw0K
PiA+ICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4gPiArICAgICAgICAgICAgICAga2ZyZWUoZWRl
dik7DQo+ID4gICAgICAgICAgICAgICAgIHB1dF9kZXZpY2UoJmVkZXYtPmRldik7DQo+IA0KPiBJ
IHRoaW5rIHRoYXQga2ZyZWUoZWRldikgc2hvdWxkIGJlIGV4ZWN1dGVkIGFmdGVyIHB1dF9kZXZp
Y2UoJmVkZXYtPmRldik7Lg0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcgYW5kIHRoZSBmZWVk
YmFjay4gWW91J3JlIGFic29sdXRlbHkgY29ycmVjdCBhYm91dCANCnRoZSBvcmRlcmluZyBpc3N1
ZS4NCg0KQ3JlYXRlZCB2MiBwYXRjaCB3aXRoIHRoZSBjb3JyZWN0IGZpeC4gDQoNCkJlc3QgcmVn
YXJkcywNCkthdXNobGVuZHJhIEt1bWFyDQo=

