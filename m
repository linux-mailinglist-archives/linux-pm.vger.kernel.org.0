Return-Path: <linux-pm+bounces-11015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B0292F441
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 05:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891281F21EEC
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 03:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C7C153;
	Fri, 12 Jul 2024 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOrHv7V5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E799EC2C6;
	Fri, 12 Jul 2024 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720753413; cv=fail; b=HgzKPb5imSMTHDFWy6jeXYRfsCXen0cy0+WLO0KDk/9JUBV/PfIkRheZmRkFRqbhmOPSzPTFDJbdNnDKzFUAEdCgsVsEJmJ/ms3mm807lVb4DJdD97LenwNscZKsqQI6sYd/5hYVImjAwPfPaJqDxd3/Ti1M1tHwW71iQu/RXlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720753413; c=relaxed/simple;
	bh=URajL45sokqUMPED8iHecrdWQN01FWuChgHgmQR6UO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gjsOaf7mww89zlku3BDDxIeUzWuT0fVM33mBJ5JfyBQhTsSeOEy9s1FCfex592EaVGNxV78OdpweR9dAhZQQXxyAzDVe9zT8KDgq1qItVSg6blQ+906oqAq7i/xvHQlF6bPfFaYlsCgRzs5qHQQGutFLYp/KABdk3yx/92wZwas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOrHv7V5; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720753411; x=1752289411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=URajL45sokqUMPED8iHecrdWQN01FWuChgHgmQR6UO8=;
  b=OOrHv7V5QRXseyB4AKiJJnFWiGqO8LWLUOq0hxDjgSOG8Fnl9mi+prZv
   EuWMHIA3MhHLWWZEwoD/wgHVE0c4k7OfdaHvpL2lOF569T24DXoqUd64q
   A3URd7mIlhMoFTN6+Jc7gOCnpd4QWs3hIXpwTO035E06gA2wtayMAPO9t
   1cpbrbl7Uwh6H+x8+pbvQtAbjOaMRikIaX6uFoKeeeQiSrOMpi7X00/i/
   5CISQ2I1SdYjUzRpzzb4eFzwpa0V0W4fGNFq1gKwIRi761WTXxOXRZDGo
   eHCeYUy3Ec6EQt9zmU3CW4svsO1OQQ3qqFVcaKoj0kBc13bqP4C3lRVQt
   Q==;
X-CSE-ConnectionGUID: Xd0t8MvWQZKzR6spPDbyXg==
X-CSE-MsgGUID: ZzxyC7ddSu6JDpJlZyoSOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18319989"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18319989"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 20:03:30 -0700
X-CSE-ConnectionGUID: 3/bzFIZ+Quqe5iQz12X5cw==
X-CSE-MsgGUID: 1fnMdEl9QDmqTAiuRM+KLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="53361109"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 20:03:30 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 20:03:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 20:03:29 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 20:03:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIgbnnUwd3vRfvPQ+w7liUWyuWWE9jgBXOKvnVYrj0xfVrgOEYryWx8O5pFhTK2KBFGgPUmznr4oUGJdcQIB4diiCMopD8zaCcteg0zlJ5SIgy8D/9LCrk8Xj2KuH8WuF3u908+T5EndrgJU+a6KJcLxJmFSJqf9riiAwSfHwboRUakkFs646pdFGmZodIc3B8iMw4ivYIGs6gA6PNTTxyatybF4mtg5geYEYB3ffQb05PVozd/k/VkckSEKgOt/3NHFLr8taB0z5LtWOYu1FNYRyOu4zJ5tuobjgd1goEOB5gmZcDfczO7MEm8MI6dZ/d6rk8A1o8+j85R1j/JfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URajL45sokqUMPED8iHecrdWQN01FWuChgHgmQR6UO8=;
 b=MxAFh8SeKr0n85uMMcmwbCFzNaYEAAOaTfvFAMF7blKYt9TSm9D35dLDOMpfV6Ztv4LYYGODPWz4z80/hxl4m4L2oQfpZNVw1mViKrjn8jjn8vL+B3nruIYnxPtIhgr+okKVyRjKaYI7vKpPkIyikWEYZKzKm5gv+yu6OapJv+qLWikY6K5COvoN9TsRTsvBjGDArmbmzaPtYUQpyQ+i5zYyZApHoxDmu1rV/BGWkzS8vklPxiIRyJLZsLhW41LdEhrkv+SNIgr4vS+sgaL9oG//broMEdEAGg8kwqoeVXc9I6PXrDiZkXMCb3uz/wO1RYnxCTWJn+D/oga2i12kog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB6370.namprd11.prod.outlook.com (2603:10b6:208:3ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 03:03:02 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 03:03:02 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"irogers@google.com" <irogers@google.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "kees@kernel.org"
	<kees@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Dhananjay.Ugwekar@amd.com"
	<Dhananjay.Ugwekar@amd.com>, "bp@alien8.de" <bp@alien8.de>, "acme@kernel.org"
	<acme@kernel.org>, "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>
CC: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "ananth.narayan@amd.com"
	<ananth.narayan@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 04/11] perf/x86/rapl: Make rapl_model struct global
Thread-Topic: [PATCH v4 04/11] perf/x86/rapl: Make rapl_model struct global
Thread-Index: AQHa030n7qOcCPmnyEqGHLoKmyEMS7HyaPyA
Date: Fri, 12 Jul 2024 03:03:02 +0000
Message-ID: <f73f64390c0479c962b591d94c89b3eb4aa55e84.camel@intel.com>
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
	 <20240711102436.4432-5-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240711102436.4432-5-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB6370:EE_
x-ms-office365-filtering-correlation-id: f1ced899-df5e-4a77-48c4-08dca21f249a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?K2RkWUdveGVyTkt5MW1kdVdaNTkvSmg3RStXTzBOUGJ3MUpYZlMyYVRQZlQr?=
 =?utf-8?B?UHBjWk5hb1dNb1ZMdFl6M2xxOFhRcjJqQk5IbDBoUU02OC9pa210Y05vL0o2?=
 =?utf-8?B?YzF2Tys3MkZ6MnRmMHVOVlFVeTJLUHlsVHBiMEhndFRiU2tLdWd5MHNIM2Vj?=
 =?utf-8?B?OGVWc1NPOTRJZG5yaWlpQW05OVh1Nk1IVWQ1OXBCSUVqRlhCRXhtMG1lOUhC?=
 =?utf-8?B?QmJ1N0kycGRIVjhia0dtUzAwRkJ2V0JCdjN4NmRIOFFiejZ5aE11cTcyRE1V?=
 =?utf-8?B?VHdNRTkyMTdXUy9Jc2hEYU1NUjVMOVlUQkdESWV0RmYrYUV5cnlmNFE5RDgx?=
 =?utf-8?B?UjluK1B1Qk5EajBKOHlSTzVQS09reFBvMFdIQXVhTVBPSXRwQzArcjBxOTJZ?=
 =?utf-8?B?R3BqVXlRUjFmZ3ZyR3FPUVhvbUNxSmd1WndmdldPbnUvYWNSWXl5YjhHK2hh?=
 =?utf-8?B?R3JtNHUvTzZLQzJidnBmdEduazRSRUZpSy96cWdvam5UWXo1bzhtWS9NYXpW?=
 =?utf-8?B?aVFWT2xjMVVRMnZ5VjU3K3orMGZDQVFMNTA2dnM4NVpkV3N1cmgyT1VXamNy?=
 =?utf-8?B?YkMrMytDSjg4WE4yRExyUWJITmdaUE9jd256WHB6ejdsbFk5NzljajlsS04x?=
 =?utf-8?B?anNKVzBvL3pYMk1Pa1pKTm5QRlowWjM4TWVOUTMwVmovTXJxMHovUHBFZEFB?=
 =?utf-8?B?MXpoc3pzRmxIcEI2YnV3V21JWFhUWmR3M1NuTE9XdGFWWENaUjBVS0VMZ1Ex?=
 =?utf-8?B?dFVTVERSTUp6WVNMLzFPdVM2MlZTdnorWEM0bjhSWGcvaUgyWDJaaENFZUlT?=
 =?utf-8?B?OEZvcHBiTDluWVBPTkZkM1NYQ0s1T3hIckhLOU9HY3ZKQVB4M25sM3Z6anJF?=
 =?utf-8?B?QU0wOFVFUzltWlUreEU2dVFZQmhUaWYzdGtNZnF6b0VkeGJYSmFZWTBpWkRw?=
 =?utf-8?B?ZXMyc09xUmNtOGNJMnV5dDEwankvL05pVDlyU0YzNjJHWkRxdjEyNERNUTZ4?=
 =?utf-8?B?UFpYUDFMQTRpMVErUnNzU2p0cnNkQkhUa24zdUZ1RHhqdjhaV0RvT0ZDYVR3?=
 =?utf-8?B?NHdITWc5dFlwcm5BZ3VtKzZJb1dYUlZBSUg2L09tSC9Ud3UyVHpFL01yODlh?=
 =?utf-8?B?QWxLTnQ1N2pPZUphTHpSYURFRExXQXVDbkgyaWI5Uytub1o4RUltTDRyQjlq?=
 =?utf-8?B?eVhPazNvb2ZyMjBpbUdKNUZwalltdjB2V0hTYldaRlFDdXBXOEtlRE9iOEl2?=
 =?utf-8?B?Uy9DQ293b2cvNGg0RnY4WTlrSzZLaEJNcHpGYmFrV2JacHhYTU1Yd3ZGNklD?=
 =?utf-8?B?TTVwdCtkdXpQenlYUG90UzdONDhuRXJ5S1VsbFNpaVh3TElBK0VIYkl3cFlR?=
 =?utf-8?B?bnJNNWhXNVJYZFFQM0xXdE93K1BBREV3dHg4U28xWk1mRDc3bm5ucDBLNCs4?=
 =?utf-8?B?cUhvb1pHOWVocEh1NkdYeW5yUmt1QkxBaThUUlZhU1VsOElMQXFlYWFLOUhz?=
 =?utf-8?B?bEoyRnpLdkgrNGhZV1FSazM5Z3o2NGE5RVVvUE5ZV2s0L0wvSyt1SXJWSjNK?=
 =?utf-8?B?Um9RL2ZXanY1blBWWUJnZHR1elBNb0VqWGxWcFE4Z1NGUTVGUXYzNHFXY2ZV?=
 =?utf-8?B?L0RLbFd6MVRpMDd1VkFFNlpTaHpSYVhwZE1IQ0FxWEtua29mZjRlN3A3elYr?=
 =?utf-8?B?ZDhSNlIzQWhqYUxtWFN3clpUQTVLR1ZaQVdPS0NzUk4ybnc2amI5SnpzRWRC?=
 =?utf-8?B?TDQzQTliMTBvVEFKbHRjcU04UExmVjRmNkhtV1Fxbi8yMENFNmlUN01kN202?=
 =?utf-8?B?ekRYemtpaGRGc0N5YkZtYWI1ZmdIdHo0WnZzUmpaUVdaN2VUOGg3bitsQUcw?=
 =?utf-8?B?ZmtNbmxoeVN2dWk4emtkMktUa2xWSC9adjJ6aCt5djBKczVFVHhwazgxUXQ1?=
 =?utf-8?Q?4CzFdNzdfAg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V21DNDVlNzVEbkx3TWh3VDFQL25yckJqQ1c5enJNT09lbHNPSTZza3RiZURh?=
 =?utf-8?B?NTFQYXlqRGRUcEh5c0NzM2VQemRLQ0V3WDcvbGFnOUt2eWEzMjZqTkJlSUpO?=
 =?utf-8?B?MEx1cldvQURGQlAraENlQS9jcWw2Zm9vWUZlY3RHVTJjekdvR3MvL2dTRTBh?=
 =?utf-8?B?dzZZNXlvVDdFdWZudGp3Q2NJdDBEUEEzbUxXYVNoUmZtY0R0dmJpdzA5ZndT?=
 =?utf-8?B?RU9qem9HUmZGVXYvdjFncVlsS2NqUFZJVER1Ri9YQzF5OXNUdm5uNk1QV3Ez?=
 =?utf-8?B?Smxmazg0YUNtNjErTXM5K0M5eUoyTmNNaGxzc21jbno5MTQzZitjalRYSHVF?=
 =?utf-8?B?dmMrdzZCeEZKV0o5TlFYRzhyYnViWDcxdjBaV1AvSi9sa09rbHZTWUZ0MXB1?=
 =?utf-8?B?WG1aTE93YS9EOS9LMmRTVjVPdnYxZTdqN2JvUnRLc3pBeEZLaFQ4RGZReG5K?=
 =?utf-8?B?VTNKeUZjQjJVY2RSSFkxQ25ES05lMzdBRG90czNNMHBlbEhzcGZDYjUyTW9L?=
 =?utf-8?B?SmVpVy9OZ0YxcE9uTzFrcjlEMU04Uld0SmJ0cXJUUHoxNXZNUFdVQ1d2UGVC?=
 =?utf-8?B?aTBVUVdEYlZPeGVJNUdCdWVKeWJDSVZqT2RDekF5TkFPU1MxKzlYTG1VZ1E3?=
 =?utf-8?B?bW9rbUZobHJ1WHdBVWEyRUZPN092dStkbEVacS85cVlvWGwwZ1YvbW03RmNv?=
 =?utf-8?B?U28yZzYwSXh2anlWbjBIR015ZUNwR0EzSTBMNlhxNkl6b05RN1lzcjZ4VzBM?=
 =?utf-8?B?dGJEV3VITlBnZ1FwS1FmOW5BdUVlMVhnSjQySHBlaVNEZXYyNkNWcVpjTXFG?=
 =?utf-8?B?REJGU0RQck5OY0ZkaVF6dmRDRWNUWlluZjFOU2FpS0x1ZncwK2pBMzltRnR5?=
 =?utf-8?B?OXNsN0RDM2FZM3ZwV1AyY25ZYm5jQVFPZSsvVEdPUCtUUEUwQmRiM0hXZ1FH?=
 =?utf-8?B?N3hZeWsvSXk1QUVsaFVCcFhjMnE3SWJmNGpiUy9lK0t1bGhDbnUvMXJMN2dy?=
 =?utf-8?B?azlxN211TzNTZDFjUUJ0Rkp6RW9MdlZwMWh3WkRCeEhScEpjWWJsVjRzc3VN?=
 =?utf-8?B?T2Q4a0pGSW50TnNCRDFTRSttempZSVh6NzRuWmpGSkRwQmlJOHdQK09RTHMx?=
 =?utf-8?B?b293NSthNGk5ZmRNNXBwUzNSaG9oYUcxUmIzYkNiNEdsK0RoZE1JVUhrYWkr?=
 =?utf-8?B?YlMvVVZSSzhaWkk1bzN5TUZmSFJzUmJtK0hoSnhhMGYwMFZySEhtWEova2kz?=
 =?utf-8?B?cVBMQ2sxM2lLREJtRjdhd2p2TDZ2aWY3RFZPcDBPZGNnc2dkWmNQaGtpU0tI?=
 =?utf-8?B?dE5ESzBDYldjcWI1QmxWV3hwWStDbXBoaDdRMi90ODhXdlp2cEhodmhrN29k?=
 =?utf-8?B?THdOdnVycVZWSEExb3BGczFhUk5yV1NTMFYyOXV3cDhXOEUwNTIzQi96TE83?=
 =?utf-8?B?eTBSVk1JL0RhWUZpd01HcG12R2krVVZycDlLMytPWVVMM2VvRlBRTjJ6STcx?=
 =?utf-8?B?OWpDVGl2QVIzRW1FdFZYWi9obWpGa3BzeDloNnZBZnVJM2EwTU04SUg3QXpM?=
 =?utf-8?B?S3crL2luaXNhNElPWUlzMmU3dnFmbkFURjZMcGUzaUwzRVEycWQvdFVwdVB1?=
 =?utf-8?B?bkdRY2ptR25RcUdZeG84bGNhdHI1NzN6U2VsUnVZZVJuV010ejZXU2N4Z0lu?=
 =?utf-8?B?V1FBNmx5NTdraUY5TWRTaUJTSWhGY3BtT0h0dzhiYStzMHVtYld0c1VmUmlQ?=
 =?utf-8?B?cDRDelRrSUFFWEJmNW5FMjlEVGpQeVFYODVxRmhkWlIvYlYzL0FUTmZ1eXlu?=
 =?utf-8?B?ejFMczZZT3JHK0NZNEk5VnZkYkp5cXMrRXpUNGRsazdlb0ROMStNekZZaWhy?=
 =?utf-8?B?S1FDUm9uaTlmd1U5clpjVE1aRFpsQUtYUjl2TzhxUVlPcDFzQzl2YXVUWEZT?=
 =?utf-8?B?a2RVWFNmbWNSTzhCb2Q3U05RVXNBK05BWi8vR1NzYnkwMnBXQmlWTHovNjQv?=
 =?utf-8?B?bUpXZlZHejVZbnRPeWFSOUNTOUs4YnVLL25XcjdYWkcyM1l0NW1RYldCU3J1?=
 =?utf-8?B?bkdwdFVZUlRSMEtnS0s1cGplSW5wTSsvZTduUG1yL0VvcHl1UDRtV0JuYXY2?=
 =?utf-8?B?b1BaYU0zamlNVGh6VHZHT2puSnFzVW1PQnA3djBjNjR3WjhlUmhhanlSL1BC?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CAD29A11D275B439C9CACD16E1424CF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ced899-df5e-4a77-48c4-08dca21f249a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 03:03:02.1522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTZZ1jqtRvLasUJElvCqeuPk0PPVQtq/pUWqLmOVCC9BGzqC6hanvlAx/Ek6nqCym7HVrizt0JS/sQtCxYjLEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6370
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA3LTExIGF0IDEwOjI0ICswMDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToKPiBUbyBzdXBwb3J0IEFNRCdzIHBlcl9jb3JlIFJBUEwgY291bnRlciwgd2Ugd2lsbCBuZWVk
IHRvIGNoZWNrCj4gcGVyX2NvcmUgY2FwYWJpbGl0eSBvZiB0aGUgY3VycmVudCByYXBsX21vZGVs
IG11bHRpcGxlIHRpbWVzIGluCj4gcmFwbF9jcHVfb25saW5lL29mZmxpbmUsIGluaXRfcmFwbF9w
bXVzIGZ1bmN0aW9ucywgc28gY2FjaGUgdGhlCj4gbWF0Y2hlZCByYXBsIG1vZGVsIGluIGEgZ2xv
YmFsIHZhcmlhYmxlLCB0byBhdm9pZCBjYWxsaW5nCj4geDg2X21hdGNoX2NwdSgpIG11bHRpcGxl
IHRpbWVzLgo+IAo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IERo
YW5hbmpheSBVZ3dla2FyIDxEaGFuYW5qYXkuVWd3ZWthckBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6
IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4KCi1ydWkKPiAtLS0KPiDCoGFyY2gveDg2
L2V2ZW50cy9yYXBsLmMgfCAxNiArKysrKysrKy0tLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9ldmVudHMvcmFwbC5jIGIvYXJjaC94ODYvZXZlbnRzL3JhcGwuYwo+IGluZGV4IGMzYWZlYWY2
NzljMi4uNGVlMDg3N2ViNGQ4IDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L2V2ZW50cy9yYXBsLmMK
PiArKysgYi9hcmNoL3g4Ni9ldmVudHMvcmFwbC5jCj4gQEAgLTE0Niw2ICsxNDYsNyBAQCBzdGF0
aWMgY3B1bWFza190IHJhcGxfY3B1X21hc2s7Cj4gwqBzdGF0aWMgdW5zaWduZWQgaW50IHJhcGxf
Y250cl9tYXNrOwo+IMKgc3RhdGljIHU2NCByYXBsX3RpbWVyX21zOwo+IMKgc3RhdGljIHN0cnVj
dCBwZXJmX21zciAqcmFwbF9tc3JzOwo+ICtzdGF0aWMgc3RydWN0IHJhcGxfbW9kZWwgKnJhcGxf
bW9kZWw7Cj4gwqAKPiDCoC8qCj4gwqAgKiBIZWxwZXIgZnVuY3Rpb25zIHRvIGdldCB0aGUgY29y
cmVjdCB0b3BvbG9neSBtYWNyb3MgYWNjb3JkaW5nIHRvCj4gdGhlCj4gQEAgLTYyMSwxOCArNjIy
LDE4IEBAIHN0YXRpYyBpbnQgcmFwbF9jcHVfb25saW5lKHVuc2lnbmVkIGludCBjcHUpCj4gwqDC
oMKgwqDCoMKgwqDCoHJldHVybiAwOwo+IMKgfQo+IMKgCj4gLXN0YXRpYyBpbnQgcmFwbF9jaGVj
a19od191bml0KHN0cnVjdCByYXBsX21vZGVsICpybSkKPiArc3RhdGljIGludCByYXBsX2NoZWNr
X2h3X3VuaXQodm9pZCkKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgdTY0IG1zcl9yYXBsX3Bvd2Vy
X3VuaXRfYml0czsKPiDCoMKgwqDCoMKgwqDCoMKgaW50IGk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDC
oMKgLyogcHJvdGVjdCByZG1zcmwoKSB0byBoYW5kbGUgdmlydHVhbGl6YXRpb24gKi8KPiAtwqDC
oMKgwqDCoMKgwqBpZiAocmRtc3JsX3NhZmUocm0tPm1zcl9wb3dlcl91bml0LAo+ICZtc3JfcmFw
bF9wb3dlcl91bml0X2JpdHMpKQo+ICvCoMKgwqDCoMKgwqDCoGlmIChyZG1zcmxfc2FmZShyYXBs
X21vZGVsLT5tc3JfcG93ZXJfdW5pdCwKPiAmbXNyX3JhcGxfcG93ZXJfdW5pdF9iaXRzKSkKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtMTsKPiDCoMKgwqDCoMKgwqDC
oMKgZm9yIChpID0gMDsgaSA8IE5SX1JBUExfRE9NQUlOUzsgaSsrKQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmFwbF9od191bml0W2ldID0gKG1zcl9yYXBsX3Bvd2VyX3VuaXRf
Yml0cyA+PiA4KSAmCj4gMHgxRlVMTDsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoHN3aXRjaCAocm0t
PnVuaXRfcXVpcmspIHsKPiArwqDCoMKgwqDCoMKgwqBzd2l0Y2ggKHJhcGxfbW9kZWwtPnVuaXRf
cXVpcmspIHsKPiDCoMKgwqDCoMKgwqDCoMKgLyoKPiDCoMKgwqDCoMKgwqDCoMKgICogRFJBTSBk
b21haW4gb24gSFNXIHNlcnZlciBhbmQgS05MIGhhcyBmaXhlZCBlbmVyZ3kgdW5pdAo+IHdoaWNo
IGNhbiBiZQo+IMKgwqDCoMKgwqDCoMKgwqAgKiBkaWZmZXJlbnQgdGhhbiB0aGUgdW5pdCBmcm9t
IHBvd2VyIHVuaXQgTVNSLiBTZWUKPiBAQCAtODQ2LDIxICs4NDcsMjAgQEAgTU9EVUxFX0RFVklD
RV9UQUJMRSh4ODZjcHUsIHJhcGxfbW9kZWxfbWF0Y2gpOwo+IMKgc3RhdGljIGludCBfX2luaXQg
cmFwbF9wbXVfaW5pdCh2b2lkKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3Qg
eDg2X2NwdV9pZCAqaWQ7Cj4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IHJhcGxfbW9kZWwgKnJtOwo+
IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGlkID0geDg2
X21hdGNoX2NwdShyYXBsX21vZGVsX21hdGNoKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFpZCkK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PREVWOwo+IMKgCj4g
LcKgwqDCoMKgwqDCoMKgcm0gPSAoc3RydWN0IHJhcGxfbW9kZWwgKikgaWQtPmRyaXZlcl9kYXRh
Owo+ICvCoMKgwqDCoMKgwqDCoHJhcGxfbW9kZWwgPSAoc3RydWN0IHJhcGxfbW9kZWwgKikgaWQt
PmRyaXZlcl9kYXRhOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgcmFwbF9tc3JzID0gcm0tPnJhcGxf
bXNyczsKPiArwqDCoMKgwqDCoMKgwqByYXBsX21zcnMgPSByYXBsX21vZGVsLT5yYXBsX21zcnM7
Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcmFwbF9jbnRyX21hc2sgPSBwZXJmX21zcl9wcm9iZShy
YXBsX21zcnMsIFBFUkZfUkFQTF9NQVgsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZhbHNlLCAo
dm9pZCAqKSAmcm0tPmV2ZW50cyk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZhbHNlLCAodm9p
ZCAqKSAmcmFwbF9tb2RlbC0KPiA+ZXZlbnRzKTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoHJldCA9
IHJhcGxfY2hlY2tfaHdfdW5pdChybSk7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gcmFwbF9jaGVj
a19od191bml0KCk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+IMKgCgo=

