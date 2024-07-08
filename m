Return-Path: <linux-pm+bounces-10735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1DA929A9D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 03:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16F32810C8
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 01:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378A3138C;
	Mon,  8 Jul 2024 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNHXT0Vk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C0EC7;
	Mon,  8 Jul 2024 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720403785; cv=fail; b=goS/R9660Ux/Piy64Frv2YuSC5oohaaIE745PvWQ9/oEY23ilfyW3KURSASTROcS8ccsKoB0OMC7Y2h4MnXTuiWFBVirmW9bQhN3gQt0omHFjP+FA/1mOImc6Nk4FxK5p4xzJNacY61Mtzn2deE0URMuKQwihZcBllNgw46IVXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720403785; c=relaxed/simple;
	bh=J4VgoNug1toCs3IKWEVuyeVgbEnu8bLqviQk7+alMtQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IVf+HN3NAxhEh1boxuyz2538Bp2lCOOZygW4d1uoAKHR5GoxBzKgSJxPtxI/tOR3ErfNon7nTEzF3Pc+0zj8IrqurThC+xlEAVbsvjMrXiO+hfgvkOvqgAWsmFVSTgzuA5u4XH5eqELWv6sNqhr75X8Kyc+TjkrMQIT6zwG5lcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNHXT0Vk; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720403783; x=1751939783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J4VgoNug1toCs3IKWEVuyeVgbEnu8bLqviQk7+alMtQ=;
  b=kNHXT0VkThCk0SuyQVk/+6KHC98RVJAvbL5+DqrEqAXw52q22oTtZu4A
   ek85Zl60GECl0IlZt8aaEKIGEnQYzZK/nD7XUFYmRI0qAwR6GH1p/Gjms
   SxcPzc3jX0lhTKPK+FRCk5DyepL7Ea14lRGxA6z0R72K2arSEdFTGB8Eh
   TqUuaKeIyIoTlXpWP/b7Ns2JDl30NOn0EiHaLMukImmVwjA0RJLmvti0o
   I80AnsjJhq6higgDOl75u31wQO9L+QYpsdEVtHNSuYE9uVazB7NwoDlRQ
   95KZPsL9G2z32hsaAplMcD2JI7Er1yE8v7l1qr1VMVhnqvVAY5OCKZjfM
   w==;
X-CSE-ConnectionGUID: svTks7rkRU6+6w06tMHGWg==
X-CSE-MsgGUID: LgO3YX27SxChbYxyEhUPng==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="21459677"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="21459677"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 18:56:22 -0700
X-CSE-ConnectionGUID: wZoq8vtVTiKCtjjofu0Ddw==
X-CSE-MsgGUID: mjCbsrP1QAaU8EZV40VGWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="51974299"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jul 2024 18:56:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 7 Jul 2024 18:56:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 7 Jul 2024 18:56:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 7 Jul 2024 18:56:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 7 Jul 2024 18:56:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBKKiRokuS2QgYViIDoWlsRZGFVFFXnc26nk8ldAU9+Eyt/pNOH22swWVmO20Pn9B51Y7w/aGbccNa2TAkxw36zDUiM15Uxf6dhCCcr4AhwJ43e+GMjLMsOhVxrDrCWD1b8IK7Zy/VTae7CsP4+E5cn9GjspKpBxKObt7U6FAe68uFknR8DT2LNCsMnU3g6n+JorXKsYygQVPzs3w3uR/Kn0jOhfIBFeG/XEPYgd+RAWtEg2Gk3ZkHFufozJoNvDhW+4MHfIKlKgZIPWubcn/mkkMutXBr8CvPrA6pmfdZ8Hjl/utUOO8myqlz7yWLIOyXosi6M5nqD4IKUT7o4nEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4VgoNug1toCs3IKWEVuyeVgbEnu8bLqviQk7+alMtQ=;
 b=h3gOaPPpwaWsLjeTlk6KjWRx/R4DtwUwvNOC9CXmtHC7gihd0ACdXbatWcWWgkhWFIFd3abuXHqdJQUo4QatSmxQeJ++0kjr6UpIUGe5hHBu9V3ajwwVfBVmnQfZHk7WD2gbHSr8cw00owhVoe/HZgTVLhOf9DPzOpTPW18l1oTM9hsG0hto/InHwhep18cufgiIzaJlgzchYsmR9R+js5XOn6XFE5ULfdkKt5950Mt7iW7r9ozmSfDz1Wy4rJsA1gi0LoXhNXbZzPaiq2eg58mmqaQP0+v5fwBTKw9PpMu0jAR8F8Tl6dZGCP8h8yX9BxKGvPGagIgJZABhAs0joQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS0PR11MB6328.namprd11.prod.outlook.com (2603:10b6:8:cc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Mon, 8 Jul 2024 01:56:14 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%7]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 01:56:14 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"Brown, Len" <len.brown@intel.com>, "ananth.narayan@amd.com"
	<ananth.narayan@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "ravi.bangoria@amd.com"
	<ravi.bangoria@amd.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "irogers@google.com"
	<irogers@google.com>, "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "sandipan.das@amd.com"
	<sandipan.das@amd.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "kees@kernel.org" <kees@kernel.org>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>, "Dhananjay.Ugwekar@amd.com"
	<Dhananjay.Ugwekar@amd.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>
Subject: Re: [PATCH v3 08/10] perf/x86/rapl: Modify the generic variable names
 to *_pkg*
Thread-Topic: [PATCH v3 08/10] perf/x86/rapl: Modify the generic variable
 names to *_pkg*
Thread-Index: AQHaxfwxVnnLKeOUFEevngJ7z5gzNbHh46KAgADemACAAIS7AIABI+wAgAAuVgCAAt4OgIAAdvgAgAQ5ygA=
Date: Mon, 8 Jul 2024 01:56:13 +0000
Message-ID: <a3193f3801f91a42bf16d4eeafcbdc24cd6d2c75.camel@intel.com>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
	 <20240624055907.7720-9-Dhananjay.Ugwekar@amd.com>
	 <20240701130845.GI20127@noisy.programming.kicks-ass.net>
	 <477c33a2949793d2a8692c925179bc4f1feb7942.camel@intel.com>
	 <35ab02da-861a-4271-986f-f4271637f5fc@amd.com>
	 <738e2dcc26926ce948bc7647cf17d83ed5d637b7.camel@intel.com>
	 <9f99286e-b840-4c50-8ff4-a25f2d2fdc67@amd.com>
	 <bf76302d2d427522d4842cb1df8f58700cb669d4.camel@intel.com>
	 <20240705092416.GB11386@noisy.programming.kicks-ass.net>
In-Reply-To: <20240705092416.GB11386@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS0PR11MB6328:EE_
x-ms-office365-filtering-correlation-id: 265b2ed0-def1-468c-0ede-08dc9ef125de
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bVlkSUpyUFVPYXRPVTU3cUtwZWNPRmtQWm0zQjdWR0VBc0xOTklnT2xmTnNn?=
 =?utf-8?B?clRvZ1J0eFpsRWk4Mm5IOGVDd1JjTE1FUTdSTDJiZ1kxNXNScEN2eW0xTi9o?=
 =?utf-8?B?ZVBzSTA1S1Ardm93TWtWMGhFeVFZUWZZd0gvc0M1STZDWU1xV0RCQVNUUWw5?=
 =?utf-8?B?WUF5ekJJbm5jaGNmVWhYQytZL2o0WUF0a1hTVzNndXRsUTFyd0ZpRWJqNUtR?=
 =?utf-8?B?a1p5M1E0U0hOWDFTVlc5U3JMNi9EVmxnai9CZVJ6SVR4d0dJZmNTZExJTnZy?=
 =?utf-8?B?T2p2N3I1dGw0ellyb2RsTUFIRjBVZDdzMHY1ZzdzUEVRUXVHd2FEbGdhMkRC?=
 =?utf-8?B?VHFrbGVFdU5COWhocnE4eTFkejBoM3ZxK1AyVDRXLzFya1V0R1dzVTFyTStI?=
 =?utf-8?B?S0hCWDRrYmZtNXg5dHMwVU9hOHdpK2VRTDRoQk8rQjZzQlFsUmdrVitYUGg4?=
 =?utf-8?B?L0FWbVBUa1kvTWtvY05CWU5YbE9uK2gwc3BjNlFEZ2Y0T3F3dnQ2Rlg5bU1k?=
 =?utf-8?B?Wllodk9qRllzSkZHb1RKM3ZST244V2h2dEJIUmNGQitINWFsNXg4b1BzNXNi?=
 =?utf-8?B?TjBqTGR4c3FJUnl0bGE5Yk04TTJsWXB1NDdJS2xRQUU5dFJKaUlyYzlXUG5M?=
 =?utf-8?B?c2QvRnZteUxEenE2dE9jZDgxYmo5dGtKV00reGl1TFRYaHhIdElnVTh5MERJ?=
 =?utf-8?B?dkFtUjRpbWdmTlpmSXc0cVpNdnJrRVpHWjRudVdiVWVHazJxTTllMDVMek12?=
 =?utf-8?B?c1diamRuazBiS0xvZGgyNU9MeHoyR1JOWjE3SCtFYm1JMjRRNnRjR2tWY1dB?=
 =?utf-8?B?V0JGbDNZMDdDeHozZkRiKzBBSm1yWlY3eFd2aW9uS2V0ekVaL2tpbmwvTkhB?=
 =?utf-8?B?YnRzeUFuc2RqT2hscGZnNWN2aTBVdlM0ZnMyUG90MEhJWGtONjJ4eGZWaDA5?=
 =?utf-8?B?UjJQamNxcEVTUjNXdUJYZ2U2WFlrc3NQWGFlSXZob3BEOXlldWRaUlBHUXpR?=
 =?utf-8?B?ZWkzUVNnbXBpckFXa01LeU5Ib1hLcnZZN094b2kzUTZvMTBzaXFJbnUyMkVt?=
 =?utf-8?B?OEFOMVhSVkN6K1E5M0dURk4vMjI5UEQ4eEw1d2hrc1RBOXpHL3oxN216T1Zp?=
 =?utf-8?B?WC9TR3FGRjVrUENjQThSbWFWQ081U2JxUmkwK3ZvUCs3SThwQzdPZ1p3QjR6?=
 =?utf-8?B?UjdBdndqMFpRSUZJeTArMS9ySitzY1pqTE9vQk5DRjJpMWE0eGh6ZVFscmFI?=
 =?utf-8?B?MjVqWnlKWkt1VWlGQ0RMTnpwR1k0NEhGemMvT1ZtM3RiaHpUZURUUVo0a2tN?=
 =?utf-8?B?MkVmZlRtSVh5N29BYThMaEM5Q1ZMOHg5dEtMS3dxZHdXdGtFeUVHSGVlNVhG?=
 =?utf-8?B?MjF3ZXZSNFBrNUF2bFlsQzRqZUJxT1E5VXB0ZWt2M1RZSmZZQ3lTWlhraHBE?=
 =?utf-8?B?UlMwOGlrY0hVamdQRjRoa1dONHhzT0NrdzM0UzBvc2VPeG4raTBLQ1FsNVlO?=
 =?utf-8?B?Z2F1NDFSYVpLZTMvODZJNlZEbVhydUNwNHdnUTZkcXpYZWY5UGU4bE54ei93?=
 =?utf-8?B?VlhYYzBpa0lraExGdzdZTjF0Nlg3QkN3bmgrOVdJbUZOdjViNTc4R3dDaWc0?=
 =?utf-8?B?U091cXNCQWc3ZFRqUlpHSHlVSHFQaHJFT0lTMkpVazVmZ1l2WWMvQ3NkUkZ6?=
 =?utf-8?B?OXE5Z0ZXNHdHbzA2REJyaHRmajNjMzF4aDUxN1BrVnRwenh0QWRFcG5penI5?=
 =?utf-8?B?TERLdWlhNkJHVVNSRTVFTVJQcmt4NE9yc0FFMm44TEZJOExWMEoxVzdTVW8r?=
 =?utf-8?B?cXNKQStxMi9COUpHMXQ4dk04Qkt5Y00ybWFNZitLUGJmR096VHphdjR5VEV2?=
 =?utf-8?B?c3dyUjNEK2MzMzhNNUQ0bUM0YS9rbmxCQitXZ0JGbEhHY1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGQxTDg0UFBmUDc5eHRyNWE3MWQyeXFoaVFhZlVVQ1FVTldnbU10WnFLcFpU?=
 =?utf-8?B?RGVEZ01GS1pvU2tRTDcwU29yY3BIZmxzak5VQkh1TytvSTlRNXdva25PVWF2?=
 =?utf-8?B?VlhSUTRoOXp4NEVjWU1sNjhVSWNVNU42Q1VUdTNPdDJ6cEFvWS9Nb1RQZ01i?=
 =?utf-8?B?SldBZUxXUmVVWCtEZldFN010RGdDZ3hYQXBnaXNDdm8yVDRxSTg0Vmh4WFgw?=
 =?utf-8?B?Mk9zUVRFdTl3ZDRHNUdFZjUxcXBuSTJwOFdWZXZ4bU9jLys0NHZzYVNPVFRS?=
 =?utf-8?B?RUx6Qlh1QitRbnNOZ0I2VnMwMkFZY2ZkNElpSXlqNFJUODVqUmhZSlEwTzJG?=
 =?utf-8?B?MTdPN1V4VE41ZVo0cGZkR0xHLzJoMVpKbXRUQUFGdjhsTmxOVkNsUjR3UEZL?=
 =?utf-8?B?dHBMcHJSMEQ2TmNwTGwxTlZ0N0ZKVzY2UHh4ZFlMQ3ZDS0E1L052ZEpXK1No?=
 =?utf-8?B?L2srZlZzbVQzMEs4ZU85VGVHSTQxRC9XQnN4KzgyYjNZTFdTR29BaTdPaXFz?=
 =?utf-8?B?c3FDV1dmL0FyNVNEeUZtMzY1VzlkYWxhN0xUZmhYamZLV1F6ZFNMYVFxM0R3?=
 =?utf-8?B?MGh4clV2VktZdVg5REV4UWRoN1ZMbUZ1akdacVRXZFh0eWErMFdaQnVuVHdJ?=
 =?utf-8?B?OVlQUXd1WTFuQ0JpbUxoaS9WZUNsaU1lVWZOeDBZZS91VEM3YXF1akpKVldR?=
 =?utf-8?B?aVJvRHY5eHBURDg5enZvcmFHeStJVkxKSlFxbkl6K25yOFFxdmtXK2FoNllj?=
 =?utf-8?B?YW5JYjc0ZDVsT2lWa1V5R1lHSUhHNGt3WVlGY0EwTy9TK3V2bXVHMGxHNEV2?=
 =?utf-8?B?cVozb1RYZFhKOUppZWFNUlZ1RXdlL1ZSUmF0WHlvN0ZhdjRTV3MzaXB1MzlR?=
 =?utf-8?B?MWhEeURoL2ZaR0ZQU29UVGNlMDd0NHRpYW9ZM01NZ3FRWnpmZE1Nb0NhZVd6?=
 =?utf-8?B?b0JaV3ZRbzZaMjhWclNHV3Rkd3hlcjZFdE1nTUpKd1JhRVIyZmRVMmJZdjlh?=
 =?utf-8?B?dzVRQ0ZQU1JmMy85YzlkcUh0Z2szOVBiaTNDQTVTU0RFZnRVdXBXb3FWc1JG?=
 =?utf-8?B?ckVHcUs2RWk5enZxZVZsNHZIZTZHZkk5MVNxMXkwZFp4bHBSVFVuOEFKeWFY?=
 =?utf-8?B?Z2VQM085MU10VnowV255b09IM2VwdCtETUdzSi9qajZFd0ppZlAxZVd2RXBQ?=
 =?utf-8?B?OHNZNXFFQXlUTlpxdXNHOUtDazFHeFc4N0FhbkZIRTlqWVJ1OUtwZGpldTY1?=
 =?utf-8?B?Z0FzZUk0ZVpCb0sySmdsS29BTXFtZnBYenpUbmRaYWxneGV4RElnQTkvdEZZ?=
 =?utf-8?B?b0VhakE3VVlOOVJYNE53OU5MQjl2TmtFcTFpNTJLNG1QM3RvbEZnaDdNYXV3?=
 =?utf-8?B?U2V0azhmRzByRElkUHFDVldXS2RHRzlpczcxbWZMakdvd3JGZkNKTjIzUjVR?=
 =?utf-8?B?WmNHZGpZUUwwSlRJZ1NFTXhOMU1DVDdMQ2dSamdHeUlBMmg2NlNYdEgydDY1?=
 =?utf-8?B?cGRiRFZYdUtOOGluYkduRlFRbUtCczhGNFBIM3N4NEV0Ui9qdlhlUGRwZDcx?=
 =?utf-8?B?VTJDeEJ6OXVBZXlNZ3lGWEZBYXVBRDZiVVhpQ3FrdWt5bU13TFZRclNkZ2d6?=
 =?utf-8?B?R1hnYWU3dE1XNFg1RVpmczJYVXY1amJud1FuQ244dTNPQXZFa3ZFbVlDYktK?=
 =?utf-8?B?Q2Flck1xUlJEUlNwZ3VqVHJnMnNkQVU5VCt6NXovYnJVUy9tbVp1NnpsM3FV?=
 =?utf-8?B?SHVjOExjT3RNbUhkdEROVTJhRnl2dVNUWEtzRzl1VFQ3Nm1wZEh1THBCRmYy?=
 =?utf-8?B?S1llTE56dkhpeE1UVWUxNDRUKzJIak5wcnhRQUxEYnV0LzAvZG8xSE9yc2dB?=
 =?utf-8?B?T2ZWOWNXdDc1ZWRQWWlxWUpiaXJYbEwram9vYXg3WjlLaWJ2MFJuQndIUnAy?=
 =?utf-8?B?eHdoc3h5bmlnZDUrSHdVb2pyeWFVQ3FDSWVBcDY3VXM0R0dyMUFFbkVlL1JE?=
 =?utf-8?B?VmozUkE3aGc0T3pBRDBiT1dkUm9VeVVqVmpPM3Z3cDVwYWFXUTlIbTJJWStS?=
 =?utf-8?B?ejh0SUtIb3JienNJS3VkdWVZR0VMSll4S09LNGpuQ0dHRC9BUTdjM3Y2b2Rm?=
 =?utf-8?Q?gTbZJEJUWQHhefXh+tjuwGaGx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49D3B472E4ECF04C8060D481A2F85E4D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265b2ed0-def1-468c-0ede-08dc9ef125de
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 01:56:13.8994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1moO0gy9zJNv4ZO+9W0UnocGipUJyFqukyN+vznqItbW9Ql6R+Z2bzBcDujtBvBXONIZXBcvCcDRVPgKOo35Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6328
X-OriginatorOrg: intel.com

SGksIFBldGVyLA0KDQpPbiBGcmksIDIwMjQtMDctMDUgYXQgMTE6MjQgKzAyMDAsIFBldGVyIFpp
amxzdHJhIHdyb3RlOg0KPiBPbiBGcmksIEp1bCAwNSwgMjAyNCBhdCAwMjoxODozMEFNICswMDAw
LCBaaGFuZywgUnVpIHdyb3RlOg0KPiANCj4gPiA+ID4gPiBJIGhhdmUgYSBkb3VidCBhYm91dCB0
aGlzLCB3b24ndCB0aGUgZnV0dXJlIEludGVsIG11bHRpLWRpZQ0KPiA+ID4gPiA+IHN5c3RlbXMg
DQo+ID4gPiA+ID4gaGF2ZSBkaWUtc2NvcGUgZm9yIHRoZSBSQVBMIFBNVSBsaWtlIENhc2VjYWRl
bGFrZS1BUD8NCj4gPiA+ID4gDQo+ID4gPiA+IEZvciBmdXR1cmUgbXVsdGktZGllIHN5c3RlbXMg
dGhhdCBJIGtub3csIHRoZSBSQVBMIGlzIHN0aWxsDQo+ID4gPiA+IHBhY2thZ2UNCj4gPiA+ID4g
c2NvcGUgDQo+ID4gPiANCj4gPiA+IEkgdGhpbmsgaW4gdGhhdCBjYXNlIHdlIGNhbiBnbyB3aXRo
IHJ1bGUgMiwgaXQgd291bGQgYmUgZnV0dXJlDQo+ID4gPiBwcm9vZg0KPiA+ID4gZm9yIEludGVs
IHN5c3RlbXMuIElmIHlvdSBhZ3JlZSwgSSBjYW4gbWFrZSB0aGUgY2hhbmdlIGluIG5leHQNCj4g
PiA+IHZlcnNpb24uDQo+ID4gPiANCj4gPiA+IFNvbWV0aGluZyBsaWtlIGJlbG93PywNCj4gPiA+
IA0KPiA+ID4gLSNkZWZpbmUgcmFwbF9wbXVfaXNfcGtnX3Njb3BlKCnCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPiA+ID4gLcKgwqDCoMKgwqDCoMKg
IChib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9BTUQgfHzCoA0KPiA+ID4g
XMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgDQo+ID4gPiDCoMKgwqDCoA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0K
PiA+ID4gwqDCoMKgwqANCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCANCj4gPiA+IC3CoMKgwqDCoMKgwqDCoCBib290X2NwdV9kYXRhLng4Nl92
ZW5kb3IgPT0gWDg2X1ZFTkRPUl9IWUdPTikNCj4gPiA+IA0KPiA+ID4gKyNkZWZpbmUgcmFwbF9w
bXVfaXNfZGllX3Njb3BlKCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBcDQo+ID4gPiArwqDCoMKgwqDCoMKgwqAoYm9vdF9jcHVfZGF0YS54ODZfbW9kZWxf
aWQgPT0gQ0FTQ0FERUxBS0UpDQo+ID4gPiANCj4gPiBzb3VuZHMgZ29vZCB0byBtZS4gSnVzdCBh
IHJlbWluZGVyIHRoYXQgdXNpbmcgYm9vdF9jcHVfZGF0YS52Zm0gaXMNCj4gPiBhDQo+ID4gYmV0
dGVyIGNob2ljZSBoZXJlLg0KPiA+IA0KPiA+IEFuZCBpdCB3b3VsZCBiZSBncmVhdCB0byBnZXQg
UGV0ZXInIHZpZXcgb24gdGhpcy4NCj4gDQo+IFBldGVyIGlzIGNvbmZ1c2VkIDotKSBTbyB5b3Un
cmUgc2F5aW5nIHRoYXQ6DQo+IA0KPiDCoC0gb2xkIEludGVsIGlzIHBrZyB3aWRlIChpdCBoYXMg
bm8gRElFIGVudW1lcmF0aW9uKQ0KDQpyaWdodC4NCg0KPiDCoC0gQ2FzY2FkZWxha2UgKHBhcnQg
b2YgdGhlIHNreWxha2UgcmVmcmVzaCkgaXMgcGVyLURJRQ0KDQpyaWdodC4NCkl0IGVudW1lcmF0
ZXMgRElFIGFuZCBpdHMgUkFQTCBjb250cm9sIChSQVBMIE1TUiBzY29wZSkgaXMgYWxzbyBwZXIt
DQpESUUuDQoNCj4gwqAtIG1vZGVybiBJbnRlbCBpcyBwa2cgd2lkZSAodGhleSBoYXZlIG5vIERJ
RSBlbnVtZXJhdGlvbikNCg0KcmlnaHQuDQoNCj4gwqAtIGZ1dHVyZSBJbnRlbCB3aWxsIGJlIHBr
ZyB3aWRlDQoNCnNlZSBkZXRhaWxlZCBjb21tZW50IGJlbG93Lg0KPiANCg0KPiBBbmQgdGhpcyB3
b3JrcyBiZWNhdXNlIGZvciBldmVyeXRoaW5nIHRoYXQgZG9lcyBub3QgZW51bWVyYXRlIGENCj4g
c3BlY2lmaWMNCj4gRElFIHRvcG9sb2d5LCBpdCBlbmRzIHVwIGJlZ2luIHRoZSBzYW1lIGFzIHRo
ZSBQS0cgdG9wb2xvZ3kuDQoNClJpZ2h0Lg0KDQo+IA0KPiBCdXQgd2hhdCBhYm91dCBmdXR1cmUg
cHJvZHVjdHMgdGhhdCBoYXZlIERJRSBidXQgYXJlIG5vdCBDQVNDQURFDQo+ICh3aGF0DQo+IGFi
b3V0IENPT1BFUkxBS0UpID8NCg0KRm9yIHRoZSBvbmUgdGhhdCBJIGtub3csIGl0IGhhcyBEaWUg
ZW51bWVyYXRpb24gYnV0IGl0cyBSQVBMIGNvbnRyb2wgaXMNCnN0aWxsIHBrZyB3aWRlLg0KSG93
ZXZlciwgdGhlIFJBUEwgY29udHJvbCBmb3IgaXQgKGFuZCBvdGhlciBmdXR1cmUgWGVvbiBwbGF0
Zm9ybXMpIGlzDQpub3QgZG9uZSB2aWEgTVNSIGludGVyZmFjZSBzbyBpdCBkb2VzIG5vdCBicmVh
ayB0aGlzIFJBUEwgUE1VIGNvZGUuDQoNCkZ1dHVyZSBJbnRlbCBjbGllbnQgcGxhdGZvcm1zIHN0
aWxsIHJlbHkgb24gTVNSIHRvIGRvIFJBUEwgY29udHJvbCwgYnV0DQp0aGVpciBSQVBMIGNvbnRy
b2wgc2NvcGUgKGFuZCBpZiB0aGV5IHdpbGwgZW51bWVyYXRlIERJRSkgaXMgbm90IGNsZWFyLg0K
DQpCdXQgc3RpbGwsIElNTywgdGhpcyBzdWdnZXN0cyB0aGF0IHRoZSBSQVBMIGNvbnRyb2wgc2Nv
cGUgaXMgbm90DQphcmNoaXRlY3R1cmFsIGFuZCBhIHF1aXJrIGxpc3QgKHByb2JhYmx5IGVuZHMg
dXAgd2l0aCBDYXNlY2FkZS1BUCBvbmx5KQ0KbWFrZXMgbW9yZSBzZW5zZSBoZXJlLg0KDQp0aGFu
a3MsDQpydWkNCg0KPiANCj4gSWYgdGhpcyByZWFsbHkgaXMgYSBvbmUgb2ZmIGZvciBDQVNDQURF
LCB0aGVuIHllcywgSSB0aGluayB3ZSBzaG91bGQNCj4gYmUNCj4gZG9pbmcgd2hhdCBEaGFuYW5q
YXkgc3VnZ2VzdHMsIGFuZCB0aGVuIHRoZSBQS0cgbmFtaW5nIGlzIGZpbmUuDQo+IA0KPiANCg0K

