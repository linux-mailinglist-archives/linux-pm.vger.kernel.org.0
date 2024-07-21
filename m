Return-Path: <linux-pm+bounces-11273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D84B9384F5
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jul 2024 16:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4DC1F2124A
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jul 2024 14:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE2F16087B;
	Sun, 21 Jul 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsiNbtcW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECA1DFD8;
	Sun, 21 Jul 2024 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721571469; cv=fail; b=D40eXIEhEnsddZVjM5Lq+WdYOWkzZo+0qIS3gX9CQ07C1DT56Dr8vrXYxPq+AJdnvU/E0T38bMq4y+Gw9KHgM1ih8nUioOtDpYW9CXlF7F3IdNR32q5+TlC9k6FelkyDZtSpqmcXyeW1fkwEIVbc/OmXPNUPGnOTnWTD0M4GyY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721571469; c=relaxed/simple;
	bh=Xbk7wdxi+W4N0Vd9UeSnYFIbb6t3ZhOGoVlmIVYyNvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WMomHAev71HmbMfq2YOHS2p8ZITl1AgrrGg+W3yPxdOddx6O8ZTph3cQrk7OIbllxiqqcIB63XDtTVBZanomos4WsV2Xa+y8yuVyq8OmtLDCCAgSUIjElgUEWz3mie2QozvHkon25c7cZc+BVr0I9rm+YJG9CtQ9N4U4OvGjd4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsiNbtcW; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721571467; x=1753107467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Xbk7wdxi+W4N0Vd9UeSnYFIbb6t3ZhOGoVlmIVYyNvc=;
  b=WsiNbtcWk8s/RTz0IazJ0heJbFBiKiQgFKwbj/hT3JzL4foF7xTpRooY
   38iouX3U/tV8FVQtw2Qo9O0ZkqDadm0cEV3lN27/Oc7bPSQ2GNFX+dJF3
   oFCT78DV6ZxN3JCBNhUZg7058kqG5A7UCRq/mUzz7nXk+u6NwGiY9zyvk
   CGL/RHpGOjtUr8XmeVI9JOuknaKE7hgu+T+NSSETuKs9rpcrJxYYGP7kg
   5CuQxS2D56BDlvwZvKUYfbsxH2fwzxt4BgdNrvnY8YI2M4ZURSnWCJgE2
   tjT64iRi3sdsHRNPgtjQPCSHq6TK/f233EaQxJojc7zvXEL7wAKg5x+Dw
   w==;
X-CSE-ConnectionGUID: 7A7RP/8iSSSGUQVsqA0oPA==
X-CSE-MsgGUID: QY7rKhJrTBeww4ymBAwOmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="12640367"
X-IronPort-AV: E=Sophos;i="6.09,225,1716274800"; 
   d="scan'208";a="12640367"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2024 07:17:46 -0700
X-CSE-ConnectionGUID: p9XWDIdfQcmCYnQvjFT1BQ==
X-CSE-MsgGUID: wqlPtI15SXmUNBJW3bDv0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,225,1716274800"; 
   d="scan'208";a="51877023"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jul 2024 07:17:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 07:17:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 21 Jul 2024 07:17:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 21 Jul 2024 07:17:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7B/qrR8AHBH+zP7pog7gm1JtHpnINS0jhM0sO3utzHcVUGcWKGQaane8Ss5W8unSoen0Jvr075PdIO8qIKCvLXpdqBhFmTAnc4Ld+jjm4dl0qsrYcF/QjcKXuT5wd9JKQmJG3qcTAGIzjUHTR5qvX8oun4+CDop5Z9KslME45Eoi1lUOOin+fWLbJKWR8ZGrnhYvccC8j3k018bNfpKhLjlvZIbXjnSsrbCskmn717HgB/xKGX6a+IDpvE/udqOGRTe4CwmA+KjaaOb7bpBUpfLLiaBUrbHyQUmQED59z/dt6Pel83e168vLnkpiDH0T8xyRPZxc9RORKqrfAIKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xbk7wdxi+W4N0Vd9UeSnYFIbb6t3ZhOGoVlmIVYyNvc=;
 b=VTFnRLV2MiSj7de3uaOoWTiA78j0p+083xdqMOCsqF5iCQRX2dizOIrY2EPVyja2wGqOTKao2D0BxhGaNut6hGs9PJk3+/xd2lt4krI+uEzB/tomVcFFjxBBOWGdCkdrR7azQY2rEFBW7EEDb3V9e54A+IS/CTY/zcqayUEpCJaXleWvKy4rlpiMTFPWf1rpseeMcGt6JN85b7dGR2qnwkGc4zatdw1ozbbWobAxeDWRWBOlgtw6H/7b025PdF4O+pk+rm/8kObBUZPEGqLAqURcNFZ/RId1VlASgHR2IgXoWPa3IlCSkWouuN41PJcyBWyNk/fGjCMIzqtKTE41gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW5PR11MB5786.namprd11.prod.outlook.com (2603:10b6:303:191::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Sun, 21 Jul
 2024 14:17:42 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7762.027; Sun, 21 Jul 2024
 14:17:42 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"Dhananjay.Ugwekar@amd.com" <Dhananjay.Ugwekar@amd.com>, "acme@kernel.org"
	<acme@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "irogers@google.com" <irogers@google.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"Larabel, Michael" <michael@michaellarabel.com>, "sandipan.das@amd.com"
	<sandipan.das@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "ananth.narayan@amd.com" <ananth.narayan@amd.com>
Subject: Re: [PATCH 2/2] powercap/intel_rapl: Fix the energy-pkg event for AMD
 CPUs
Thread-Topic: [PATCH 2/2] powercap/intel_rapl: Fix the energy-pkg event for
 AMD CPUs
Thread-Index: AQHa2cOQ281/U8pyC0SnDudrUQMJSLIBPfeA
Date: Sun, 21 Jul 2024 14:17:42 +0000
Message-ID: <2a81f438306b82620bb4db9065d2cbf3e4c2d56c.camel@intel.com>
References: <20240719092545.50441-1-Dhananjay.Ugwekar@amd.com>
	 <20240719092545.50441-3-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240719092545.50441-3-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW5PR11MB5786:EE_
x-ms-office365-filtering-correlation-id: d6aabc5f-5813-471b-2b23-08dca98fe2a3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?U0QzUnpEMEQ3b3l2cDA4T210S1dUZ0p5eVB4TVBJVVdqbjJGaVR5VXVKNjJS?=
 =?utf-8?B?NjdPSWpzMGdwYXdaR0taUXoyUm1EYUpWdjdNR0h1YnJhQlpRbnFZalJSOG9S?=
 =?utf-8?B?Y2JPRE1lUnJCck13emhCK0Q4Uks2d0dINk8xUlhkYTJSdGJ2cE5sa1YzTUpD?=
 =?utf-8?B?OHFaVWh3bFkyWnZTYWZkK0ZTQkpBZUFEeFkwSW5aaVg5K0ZUdS9sQlRCVXlt?=
 =?utf-8?B?c1FpM0ZSVjhTTVNMVmRVL3BBQjhZSThyMzlWcFB2d2RVb1NkZzBVRmFubXZk?=
 =?utf-8?B?ZGFnaFV4eUhSamR4V3NIRld1bjlkM2dOSmdnVnRPSGRmb3RkdnE1OGprMzg4?=
 =?utf-8?B?cnJ1RzBvVW9JUzVkM0dBS01RMlhvakhIL09LNXVadXRZbHkvUWZqblBKcHIr?=
 =?utf-8?B?cGJnY1lxeVB5N0hTM294Y3dQa2daYmZ0UzBvUXgvaEJRUWhaK2Uwdks4aDFn?=
 =?utf-8?B?ZEU3NnV0MnAzcStJTkdBWkQwS1RlNXZWYTN4NHlUVDd6aVV2a3VDWlBqNzU0?=
 =?utf-8?B?K21rbG9nZnFFTkdvUGRhTHh2MjBEaFRsYUtVVFhIMG5CUU1Ra0J1eXc2cXoy?=
 =?utf-8?B?UTcxSUg5eSttcUU0bDRrUHdzcWFmOENXdW4vOHR1dXNjZ0tqc2IrVnEzWVkz?=
 =?utf-8?B?VUdzWHdBenk4WFdmWUtkSUsyeVJvOUhDTTVqaVMrdzRONkt6UWR4cTlIaE9n?=
 =?utf-8?B?ZHVVd2lSZGM2WC9xYi9yQm03Ky9MMWRia0RLSkRMNlZMZ3NIMlFUQ2ZnSmsr?=
 =?utf-8?B?R0Y2WGw3aS9JWEordnR0N3dCbDRXOTk0YnRRVVVXMU5DNGZkR1N6Zy9rd3VT?=
 =?utf-8?B?M1NnTlcvdm51VWNnUmlLR0hNdDBHTzZZeDdleVVjem1Kc0g0c1RSUXRwS2lT?=
 =?utf-8?B?VXhLN3BHVm54MEgyRW9XR1F0SHpTVG5NUGNaVHRpanJtTkQrMHhqVS84WmZ4?=
 =?utf-8?B?VWJCOVBuN0hNYUEvbkJLY29nNVA5NjUrdURYZ1pzdkFUNTNPUnVrRitnNlhI?=
 =?utf-8?B?d0tBRFE1R2duZDEwYWd4NTBUakIwU3R2YldnL2tLZUltM3NGc2ZXUjhmUGlN?=
 =?utf-8?B?dVE5RE1WemlzVHd0MGhLUzRBT3NqNy9LN05WWDJtblgwVFNEMFhBNnozMGlB?=
 =?utf-8?B?N29URnZNeklISE91aDZZUHRLc1YvS3ptdmZ2TjR2aEhrbmlBMmRveGo2SGw1?=
 =?utf-8?B?NEVMb09TK0s5akpKSEdLdEljRjViVGhqc2JFb3ZIcXoxb3JlZEpJWXV0SlZP?=
 =?utf-8?B?NTBUSGRWNVR5Y3RLcEI4aCsvTGVaMkJMd0NrSDZYcUYvaE5uNnhJUnQ1VGlP?=
 =?utf-8?B?bnE5aG15K040QTFvK2VOR05EUmFpaVhxazBjSWJ6L0FCUWdaa1MrVURnSXZn?=
 =?utf-8?B?TDErYzRLaUsyS0Fpd1NTdllvQTlyamgyUFJsZVpHczRSN3NQa05aeEVrQWdJ?=
 =?utf-8?B?QWxMMTArczB6U29GQVdJVWZmb1FUdFgzZHJCejVscnRjeHhiYUl1WnhOWmtu?=
 =?utf-8?B?ejZ0SW1GaWJ5RDdNa1BOQzg2b3FrdGdBZG4wTkRtQWJoZTNqLzlZRmRmS2hN?=
 =?utf-8?B?NktGRVc5ZGc0aU8zU3VvVEhkbEt6ZmpKYVZOT3Exc3Erd1pmTDNqcDFvK0dW?=
 =?utf-8?B?dU5Pd1hpYmptMEhqVFhWS2hpSlJTbUpIVGNxbno5QkVGTHVMaUlZNWZRZXhN?=
 =?utf-8?B?MXVSNno5a1ZuNmhjS25seHQ3cGI2QmtKOFpPQ3RYQ2lCdWFMSFVBangzcHBp?=
 =?utf-8?B?VGx5cnFOMGllQ0liZXNrYmZMS0U4a1ZRVkpTMEZYY3U0WkJFRmhSUTJRSnJm?=
 =?utf-8?B?YVBlUGU5cUw1eG16cUZ6d2o3ai95MnUrS0s2WTI0a0xSK2NDZ3pHZjkyRzZt?=
 =?utf-8?B?QnBPWU9pOWM2UTQ1c3ZKUURldnFJb01zdlppeHlkOE5Lb29KQ3lKTC9xY2hP?=
 =?utf-8?Q?LtSX4SZwEKk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czFka3FTSHlvRlhOdmlvY1k2d1RIVlg3dzlCTkxkbDZMd0E4eWlGY3lmcGJF?=
 =?utf-8?B?ZjVBYlR5bTRka1BWZWx1VDZ0WENpTW5zS0dZY2lKc0xXSEFIakl3WVhNczFF?=
 =?utf-8?B?VlI3VmUxWXUwVGlWajhDeThjK1VpR1pVTGszWStlK1d4Zk5GTk80OGM0dUVL?=
 =?utf-8?B?endFN0VCWGN4NHRtSEhwaC91T24raXh4bmFWeWk4aThUU2N0L2EzUHZvdG1R?=
 =?utf-8?B?aVduT2g0OEd0MUxCbmNOMk9RQjd5UXl4Q2Mya3lEeElHL0pJZ3A0ejFCdmtN?=
 =?utf-8?B?YW5XRjdrdHdiYVNzNldDQ1pwcmJROTJYQXd5WXUrQTZMQVRSdEZQYy9xdGp0?=
 =?utf-8?B?blNOOS9HNWdxSnpkV3p0RDl6TVdUaDdTSm1vMm5xd1l6WFNLL1dJZlRaMTM1?=
 =?utf-8?B?MExNN2Vlak5yWlFwTGRKQnFWaEw0aWFSTmFCSTI1NXN5UmFPWDI0d1BtVkF4?=
 =?utf-8?B?QzlrUWhlSWFISWhON3BDczBWbkRHZyt0OHBJTUUwa3dVSEU5ZjkxTi9CaXYx?=
 =?utf-8?B?dE1QcEFLcHFnN2tibk9TYzZWb2U0K013Tm04STJoaFVFQ1hWcThLa1U0Vity?=
 =?utf-8?B?YWRYRHF1cThwYkVtb2YrOFY5cngyR1d6eWhPaUpucmtKYTk5aHpaRXVtUjlW?=
 =?utf-8?B?QlJHTFZXQnhhRnUzM0p3R2xnQUhxL0ZDeWc4a052bXhOaTdkdFNqdmlOTzdD?=
 =?utf-8?B?alVWVFdya2xJZDk5VlYrOVU0cG52ZVFHMDJZdmh6OGcyZmN5MlJqTmoxRVhY?=
 =?utf-8?B?eUZXdlRkV25NWkNON05GTTdDN01hWVhuQkw1bCswSDFUejJQa0xwSlR4SFpv?=
 =?utf-8?B?V2UwU1p1LzdYUUZNbzhMUUhwTVV0RTVGTGgvL2pRNkhWeldDclNGQ2FwdkJt?=
 =?utf-8?B?cVNhREk1V3ViaFkvRUJESEUxNXZyZEZtZ1pMU05JTWh0WW5PQTMvUHlZb0pi?=
 =?utf-8?B?K1RodWtRbkdsLzNKT1RnWVgvUWFZV2U3c2RRL0cySFc2cVQyU2d6cVpSWHRp?=
 =?utf-8?B?ZkExSWFiMVFyaVJkU1VXcXZ6K1NyMFRzRGgraXIxclRlOEJ6ZHBMV0g5ZTFO?=
 =?utf-8?B?SHRIenUrWWhiY1FnY1JEanhrV3FaOHdNSmwzaE5OeHdMTENxUzNycEJITzM4?=
 =?utf-8?B?Mm9yWmVUc01iUmw3aldFUUZuWXRhelRMdG1vaVdvZ0MzbGJqL1BIY1U3ZkY2?=
 =?utf-8?B?SkZwYWhiWElLUHh2NU15dlFINkU1U0ZKNDVwL3dMZlR2TStpYytkVlcvTW1K?=
 =?utf-8?B?cG9zYWJlZE05VW5EUnQybERZTTJsaHNwdkp1dGU2ajdJYXlKMXRxVHcwZW1Q?=
 =?utf-8?B?RmlhYzlvRzlYSUswYkY4anNmWUt5eVNicm9QVW1mZWdMcW1mZVlwTzg0N001?=
 =?utf-8?B?STdoS3BQTE5pODdjYkJNbk42OHc4b0w0aWtMVmxGV2x5OFFSbUlsSTRvWERW?=
 =?utf-8?B?NVJmYmtGb2tydm1NZGk1VjMzMmhhSC9hMkUvOEkzSHBsS1E3Ym9xTEt0bGFO?=
 =?utf-8?B?YUdBV3ZLZTBlRVJwanYvNzRXN2IwRVJaMG5nVUxhSVBiZUh3R3JlemVObCtk?=
 =?utf-8?B?S3krME9uK2gxY245bmVaVzMyVUlsY1pXcTNGS2VnRDVmVWNobHdOU2RicmVR?=
 =?utf-8?B?TnQvV1VzcktoRXFrTFNjMVNoa3RqM2NZSW9ybHo1RUJSanlFTVBUVzc0eUh2?=
 =?utf-8?B?Z1U5blFZMmY4cmJwNEp6N0ZOdk1ZWVgwOXlheW9teTVmWHBGZ3RWVGJHUndB?=
 =?utf-8?B?UGFxMjh2SzFmU29DZWZxRWRCaXkxcjVhRlBxaEJZRnNmQWlRaHdFYzFXcisz?=
 =?utf-8?B?RGJRWUhOK3dCZXZuV0F0c0h2RXpyNVVoTHpVdjN4S2QxSERaRU8vR1RNUGJM?=
 =?utf-8?B?OXc0YmhDRDY2RkVXbjFybDZTdG85Ulg1OTFacnZTVVZhcHFNODYrcjcrZjEr?=
 =?utf-8?B?d3FjczY1UjU3ZWxNWkgzbG1XWGk3Nm1PTnI4alhtQSt6TlY0cFpLaHdoZi9G?=
 =?utf-8?B?OWZQR2lNK3ZUM3pTT0dlWHFyNUx4a3BjU3NKKzdUanlDci9nQUI2eFhTTGtE?=
 =?utf-8?B?QWNEWmdBaHhtNWltak53ZElrK1p5dFVGdVhnRFFBUzlWRGRLZnBOVFUvNGdY?=
 =?utf-8?B?ajBmK2xtenpWQk5EbGpmQ2UvOUQrSFRRZ1EvQko2ZmU5VUhzajR4THdMKzFx?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66E8CEDB9AA051438B727C8D160031E0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6aabc5f-5813-471b-2b23-08dca98fe2a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2024 14:17:42.7226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPgM86+hiXeY8tI4tfN6kSpQMqROknCfKj9AKLwZXIHsTI25qeDJHRZo3LpPVKYAXEYwhVBPSy123COidfvcbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5786
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA3LTE5IGF0IDA5OjI1ICswMDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToNCj4gQWZ0ZXIgY29tbWl0ICgieDg2L2NwdS90b3BvbG9neTogQWRkIHN1cHBvcnQgZm9yIHRo
ZSBBTUQgMHg4MDAwMDAyNg0KPiBsZWFmIiksDQo+IG9uIEFNRCBwcm9jZXNzb3JzIHRoYXQgc3Vw
cG9ydCBleHRlbmRlZCBDUFVJRCBsZWFmIDB4ODAwMDAwMjYsIHRoZQ0KPiB0b3BvbG9neV9sb2dp
Y2FsX2RpZV9pZCgpIG1hY3Jvcywgbm8gbG9uZ2VyIHJldHVybnMgcGFja2FnZSBpZCwNCj4gaW5z
dGVhZCBpdA0KPiByZXR1cm5zIHRoZSBDQ0QgKENvcmUgQ29tcGxleCBEaWUpIGlkLiBUaGlzIGxl
YWRzIHRvIHRoZSBlbmVyZ3ktcGtnDQo+IGV2ZW50IHNjb3BlIHRvIGJlIG1vZGlmaWVkIHRvIEND
RCBpbnN0ZWFkIG9mIHBhY2thZ2UuDQo+IA0KPiBGb3IgbW9yZSBoaXN0b3JpY2FsIGNvbnRleHQs
IHBsZWFzZSByZWZlciB0byBjb21taXQgMzJmYjQ4MGUwYTJjDQo+ICgicG93ZXJjYXAvaW50ZWxf
cmFwbDogU3VwcG9ydCBtdWx0aS1kaWUvcGFja2FnZSIpLCB3aGljaCBpbml0aWFsbHkNCj4gY2hh
bmdlZA0KPiB0aGUgUkFQTCBzY29wZSBmcm9tIHBhY2thZ2UgdG8gZGllIGZvciBhbGwgc3lzdGVt
cywgYXMgSW50ZWwgc3lzdGVtcw0KPiB3aXRoIERpZSBlbnVtZXJhdGlvbiBoYXZlIFJBUEwgc2Nv
cGUgYXMgZGllLCBhbmQgdGhvc2Ugd2l0aG91dCBkaWUNCj4gZW51bWVyYXRpb24gYXJlIG5vdCBh
ZmZlY3RlZC4gU28sIGFsbCBzeXN0ZW1zKEludGVsLCBBTUQsIEh5Z29uKSwNCj4gd29ya2VkDQo+
IGNvcnJlY3RseSB3aXRoIHRvcG9sb2d5X2xvZ2ljYWxfZGllX2lkKCkgdW50aWwgcmVjZW50bHks
IGJ1dCB0aGlzDQo+IGNoYW5nZWQNCj4gYWZ0ZXIgdGhlICIweDgwMDAwMDI2IGxlYWYiIGNvbW1p
dCBtZW50aW9uZWQgYWJvdmUuDQo+IA0KPiBSZXBsYWNpbmcgdG9wb2xvZ3lfbG9naWNhbF9kaWVf
aWQoKSB3aXRoDQo+IHRvcG9sb2d5X3BoeXNpY2FsX3BhY2thZ2VfaWQoKQ0KPiBjb25kaXRpb25h
bGx5IG9ubHkgZm9yIEFNRCBhbmQgSHlnb24gZml4ZXMgdGhlIGVuZXJneS1wa2cgZXZlbnQuDQo+
IA0KPiBPbiBhbiBBTUQgMiBzb2NrZXQgOCBDQ0QgWmVuNSBzZXJ2ZXI6DQo+IA0KPiBCZWZvcmU6
DQo+IA0KPiBsaW51eCQgbHMgL3N5cy9jbGFzcy9wb3dlcmNhcC8NCj4gaW50ZWwtcmFwbMKgwqDC
oMKgwqAgaW50ZWwtcmFwbDoxOjDCoCBpbnRlbC1yYXBsOjM6MMKgIGludGVsLXJhcGw6NTowDQo+
IGludGVsLXJhcGw6NzowwqAgaW50ZWwtcmFwbDo5OjDCoCBpbnRlbC1yYXBsOmI6MMKgIGludGVs
LXJhcGw6ZDowDQo+IGludGVsLXJhcGw6ZjowwqAgaW50ZWwtcmFwbDowwqDCoMKgIGludGVsLXJh
cGw6MsKgwqDCoCBpbnRlbC1yYXBsOjQNCj4gaW50ZWwtcmFwbDo2wqDCoMKgIGludGVsLXJhcGw6
OMKgwqDCoCBpbnRlbC1yYXBsOmHCoMKgwqAgaW50ZWwtcmFwbDpjDQo+IGludGVsLXJhcGw6ZcKg
wqDCoCBpbnRlbC1yYXBsOjA6MMKgIGludGVsLXJhcGw6MjowwqAgaW50ZWwtcmFwbDo0OjANCj4g
aW50ZWwtcmFwbDo2OjDCoCBpbnRlbC1yYXBsOjg6MMKgIGludGVsLXJhcGw6YTowwqAgaW50ZWwt
cmFwbDpjOjANCj4gaW50ZWwtcmFwbDplOjDCoCBpbnRlbC1yYXBsOjHCoMKgwqAgaW50ZWwtcmFw
bDozwqDCoMKgIGludGVsLXJhcGw6NQ0KPiBpbnRlbC1yYXBsOjfCoMKgwqAgaW50ZWwtcmFwbDo5
wqDCoMKgIGludGVsLXJhcGw6YsKgwqDCoCBpbnRlbC1yYXBsOmQNCj4gaW50ZWwtcmFwbDpmDQo+
IA0KPiBBZnRlcjoNCj4gDQo+IGxpbnV4JCBscyAvc3lzL2NsYXNzL3Bvd2VyY2FwLw0KPiBpbnRl
bC1yYXBswqAgaW50ZWwtcmFwbDowwqAgaW50ZWwtcmFwbDowOjDCoCBpbnRlbC1yYXBsOjHCoCBp
bnRlbC0NCj4gcmFwbDoxOjANCj4gDQo+IE9ubHkgb25lIHN5c2ZzIGVudHJ5IHBlci1ldmVudCBw
ZXItcGFja2FnZSBpcyBjcmVhdGVkIGFmdGVyIHRoaXMNCj4gY2hhbmdlLg0KPiANCj4gRml4ZXM6
IDYzZWRiYWE0OGE1NyAoIng4Ni9jcHUvdG9wb2xvZ3k6IEFkZCBzdXBwb3J0IGZvciB0aGUgQU1E
DQo+IDB4ODAwMDAwMjYgbGVhZiIpDQo+IFJlcG9ydGVkLWJ5OiBNaWNoYWVsIExhcmFiZWwgPG1p
Y2hhZWxAbWljaGFlbGxhcmFiZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEaGFuYW5qYXkgVWd3
ZWthciA8RGhhbmFuamF5LlVnd2VrYXJAYW1kLmNvbT4NCg0KRm9yIHRoZSBmdXR1cmUgSW50ZWwg
bXVsdGktZGllIHN5c3RlbSB0aGF0IEkga25vdywgaXQgc3RpbGwgaGFzDQpwYWNrYWdlLXNjb3Bl
IFJBUEwsIGJ1dCB0aGlzIGlzIGRvbmUgd2l0aCBUUE1JIFJBUEwgaW50ZXJmYWNlLg0KDQpUaGUg
VFBNSSBSQVBMIGRyaXZlciBpbnZva2VzIHRoZXNlIEFQSXMgd2l0aCAiaWQgPT0gcGtnX2lkIiBh
bmQNCiJpZF9pc19jcHUgPT0gZmFsc2UiLCBzbyBubyBuZWVkIHRvIG1ha2UgcmFwbF9wbXVfaXNf
cGtnX3Njb3BlKCkNCnJldHVybnMgdHJ1ZSBmb3IgdGhvc2UgSW50ZWwgc3lzdGVtcy4NCg0KVGhl
IHBhdGNoIExHVE0uDQoNClJldmlld2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5j
b20+DQoNCnRoYW5rcywNCnJ1aQ0KPiAtLS0NCj4gwqBkcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3Jh
cGxfY29tbW9uLmMgfCAyMCArKysrKysrKysrKysrKysrKy0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2Vk
LCAxNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KPiBiL2RyaXZlcnMvcG93ZXJjYXAv
aW50ZWxfcmFwbF9jb21tb24uYw0KPiBpbmRleCAzY2ZmYTZjNzk1MzguLjJmMjRjYTc2NDQwOCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+ICsr
KyBiL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KPiBAQCAtMjEyOCw2ICsy
MTI4LDE4IEBAIHZvaWQgcmFwbF9yZW1vdmVfcGFja2FnZShzdHJ1Y3QgcmFwbF9wYWNrYWdlDQo+
ICpycCkNCj4gwqB9DQo+IMKgRVhQT1JUX1NZTUJPTF9HUEwocmFwbF9yZW1vdmVfcGFja2FnZSk7
DQo+IMKgDQo+ICsvKg0KPiArICogSW50ZWwgc3lzdGVtcyB0aGF0IGVudW1lcmF0ZSBESUUgZG9t
YWluIGhhdmUgUkFQTCBkb21haW5zDQo+IGltcGxlbWVudGVkDQo+ICsgKiBwZXItZGllLCBob3dl
dmVyLCB0aGUgc2FtZSBpcyBub3QgdHJ1ZSBmb3IgQU1EIGFuZCBIeWdvbg0KPiBwcm9jZXNzb3Jz
DQo+ICsgKiB3aGVyZSBSQVBMIGRvbWFpbnMgZm9yIFBLRyBlbmVyZ3kgYXJlIGluLWZhY3QgcGVy
LVBLRy4gU2luY2UNCj4gKyAqIGxvZ2ljYWxfZGllX2lkIGlzIHNhbWUgYXMgbG9naWNhbF9wYWNr
YWdlX2lkIGluIGFic2VuY2Ugb2YgRElFDQo+ICsgKiBlbnVtZXJhdGlvbiwgdXNlIHRvcG9sb2d5
X2xvZ2ljYWxfZGllX2lkKCkgb24gSW50ZWwgc3lzdGVtcyBhbmQNCj4gKyAqIHRvcG9sb2d5X2xv
Z2ljYWxfcGFja2FnZV9pZCgpIG9uIEFNRCBhbmQgSHlnb24gc3lzdGVtcy4NCj4gKyAqLw0KPiAr
I2RlZmluZSByYXBsX3BtdV9pc19wa2dfc2NvcGUoKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBcDQo+ICvCoMKgwqDCoMKgwqDC
oChib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9BTUQgfHzCoMKgXA0KPiAr
wqDCoMKgwqDCoMKgwqAgYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfSFlH
T04pDQo+ICsNCj4gwqAvKiBjYWxsZXIgdG8gZW5zdXJlIENQVSBob3RwbHVnIGxvY2sgaXMgaGVs
ZCAqLw0KPiDCoHN0cnVjdCByYXBsX3BhY2thZ2UgKnJhcGxfZmluZF9wYWNrYWdlX2RvbWFpbl9j
cHVzbG9ja2VkKGludCBpZCwNCj4gc3RydWN0IHJhcGxfaWZfcHJpdiAqcHJpdiwNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib29sDQo+
IGlkX2lzX2NwdSkNCj4gQEAgLTIxMzYsNyArMjE0OCw4IEBAIHN0cnVjdCByYXBsX3BhY2thZ2UN
Cj4gKnJhcGxfZmluZF9wYWNrYWdlX2RvbWFpbl9jcHVzbG9ja2VkKGludCBpZCwgc3RydWN0IHJh
cGxfaWZfDQo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgdWlkOw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDC
oMKgaWYgKGlkX2lzX2NwdSkNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVpZCA9
IHRvcG9sb2d5X2xvZ2ljYWxfZGllX2lkKGlkKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHVpZCA9IHJhcGxfcG11X2lzX3BrZ19zY29wZSgpID8NCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG9wb2xvZ3lfcGh5c2ljYWxfcGFja2FnZV9pZChp
ZCkgOg0KPiB0b3BvbG9neV9sb2dpY2FsX2RpZV9pZChpZCk7DQo+IMKgwqDCoMKgwqDCoMKgwqBl
bHNlDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdWlkID0gaWQ7DQo+IMKgDQo+
IEBAIC0yMTY4LDkgKzIxODEsMTAgQEAgc3RydWN0IHJhcGxfcGFja2FnZQ0KPiAqcmFwbF9hZGRf
cGFja2FnZV9jcHVzbG9ja2VkKGludCBpZCwgc3RydWN0IHJhcGxfaWZfcHJpdiAqcHINCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4g
wqANCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChpZF9pc19jcHUpIHsNCj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJwLT5pZCA9IHRvcG9sb2d5X2xvZ2ljYWxfZGllX2lkKGlkKTsNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJwLT5pZCA9IHJhcGxfcG11X2lzX3BrZ19z
Y29wZSgpID8NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdG9wb2xvZ3lfcGh5c2ljYWxfcGFja2FnZV9pZChpZCkgOg0KPiB0b3BvbG9neV9sb2dpY2Fs
X2RpZV9pZChpZCk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcnAtPmxlYWRf
Y3B1ID0gaWQ7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodG9wb2xvZ3lf
bWF4X2RpZXNfcGVyX3BhY2thZ2UoKSA+IDEpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAoIXJhcGxfcG11X2lzX3BrZ19zY29wZSgpICYmDQo+IHRvcG9sb2d5X21heF9kaWVz
X3Blcl9wYWNrYWdlKCkgPiAxKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBzbnByaW50ZihycC0+bmFtZSwNCj4gUEFDS0FHRV9ET01BSU5fTkFNRV9M
RU5HVEgsICJwYWNrYWdlLSVkLWRpZS0lZCIsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG9wb2xvZ3lfcGh5c2ljYWxf
cGFja2FnZV9pZChpZCksDQo+IHRvcG9sb2d5X2RpZV9pZChpZCkpOw0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGVsc2UNCg0K

