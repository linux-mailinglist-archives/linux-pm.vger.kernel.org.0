Return-Path: <linux-pm+bounces-8905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E162903159
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 07:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0525B289DF0
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 05:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C34171074;
	Tue, 11 Jun 2024 05:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzTZx/dQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B8316F90C;
	Tue, 11 Jun 2024 05:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718084141; cv=fail; b=dmd+y065MjPxguEvc9Zx4bGIiwy7PJ3gpszmskQTvxiinLA1it4mEfLauJVKsOUXiF5/oln973YqsoewhYStZrJd0jD4JRXtRLaRjMnCANqDeKg6zd6I66WU6r3NoTiLMP6rbSNkOShEtrdlvoqtFoT6yDcczNmVdx4tTerrDLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718084141; c=relaxed/simple;
	bh=5NTwNMJ0lifdhCy2xPjO6a0iBGOAVFV1WJrpazcFmCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lwzxQzrt8Gfj9FcsbptZ2fPtXUw9Hn56E7A/lNO4mgomlbEaNhFi5MWkl01vOr4MFbaXiBpQ3Lgnsikys40I9G/hbXL+s0NK1R1I1QDiRl41y7BvPAkPJWRu6MrKMDIXcU40llRW5ya2GFFjNsTN1LjxRQqFoAC8fQDSxi3qnE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzTZx/dQ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718084139; x=1749620139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5NTwNMJ0lifdhCy2xPjO6a0iBGOAVFV1WJrpazcFmCA=;
  b=nzTZx/dQc2UUIU4dXzAhjuTnOBX9cp4DRE5S5YdGscfEF3Qy5ck2YRXp
   2dj3dR8cJ500uMj1O1N7WVgdgVY8gFzAhs2KSfZH5+7pEjS4nlPC+zozf
   52FcOZByeIVEDdHAKQq146c5dVR8ujuRC6EVOd0CwH9DK6mADLJhk091X
   pXEleXI3VL6VKiqVXb8MkbaPO0Cvq6mXxHmFuA74katpz1k82/3fjv+PN
   w0uvJGArkr9u0nf5jV/AbDELNNuhOMKjO9p8EXrolQKzWAu1Q/zns0vrI
   Kgw6ceIpJSO9POLAe4WZrQYHMIJnvZc77tTDoaSU0sewsK9yy9zJfvcyc
   Q==;
X-CSE-ConnectionGUID: eUn93fFQSkKrpEvRBDf5AA==
X-CSE-MsgGUID: YMqe4c2jQOSUACNFNE6kaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25351132"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="25351132"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:35:38 -0700
X-CSE-ConnectionGUID: o36+y0WTRomNtPopt9f+Jw==
X-CSE-MsgGUID: olWq5wkDSxeUmzFEzHphvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="39986551"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 22:35:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 22:35:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 22:35:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 22:35:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbC1/U3MfL82XiMNbCbu4xuMqz5X5+HgesDefUQ4Itd7YTXCBK5huuli6aIX2lSeGgI6RGCGGOqN0iNhd30hijzsae3Gjiw9v35tSFDHBqjmUxiq6+3pGB7ghY040K5ews7UX1zjvQskrXR+WDlZQwe5KlFrQ3QCaSK1yI2cAxZefNuOjPBLSSKaW4bH7KkzyHvU+/+0/jLAZG/LDm3iHEjl60fxtowpReW8UQX4BP8vr5ckXrp5QJ6a4HZOyYbD1tbPgDV0wH/VpL1Ao2s/9LLBHqKDx1Cn7EBNs0VW+h3I+87m3Awphc9fzsOP3zOZM8JlcQTlWNJtvjL5IpbCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NTwNMJ0lifdhCy2xPjO6a0iBGOAVFV1WJrpazcFmCA=;
 b=gQDPnfrP6YCR6aN4n2z1tu79uZL7SzXNryKrPErH7/HYN4VRQBfW3T0EaHnutGPzvFIdg6XgTEVnF7/PkElvtfqG8ye8NlSMxN+xsTUoWNE4/cAVrcLpk8bY0UIO+ybdQvYG8m/pftfckGZJatK2yMgjbwCRwub2ppV27t9/5CTbqdZqtorRBdgi02aLd/a0OueMsHozCPADWyNzFQK3AZ9Kw97ORtyZH9rtUTM7fvXtTtAtzzL5Nwux5Cmk0oxAsIFxW7ZSmS0LtgQe66xUj/TqJHLqpg6Ix65WjNToWxo3WORsyGUqWPeL5hKfCXSmkoRbeiL2msx4XGtb0JE1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB7941.namprd11.prod.outlook.com (2603:10b6:208:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 05:35:35 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 05:35:35 +0000
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
	<acme@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
CC: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "ananth.narayan@amd.com"
	<ananth.narayan@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/6] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Thread-Topic: [PATCH 1/6] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Thread-Index: AQHaux6YnIyxED7TwUOU5oC/XLb8DbHCDB8A
Date: Tue, 11 Jun 2024 05:35:35 +0000
Message-ID: <e1f70a09f85dbd0ee3f32dffea37993e141269d0.camel@intel.com>
References: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
	 <20240610100751.4855-2-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240610100751.4855-2-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB7941:EE_
x-ms-office365-filtering-correlation-id: f66c883f-b029-4926-0fd2-08dc89d8516d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?Z0pUdXNoaVRQYWF5KzdPSVVOUWxTYzdVRExYK2YzM2VrR1p2NlZ6eWhha0pR?=
 =?utf-8?B?NTltaEZmWmdQYmt2Qkt6RXZaeDFyRGFvUXIxYUgyQlc1OHRqWldhZll1aGtC?=
 =?utf-8?B?WU9xRjNLRXZtMDJLd1owSzAvWWFXc1RITG9HUGVBdXd2dHEwU1hvTHVVbzhy?=
 =?utf-8?B?ckd2V2M1eGpEZ0NabXN2SmppaXN3ZkRLQVZhdkFjeHEwbEREVVZwWDI2L3Aw?=
 =?utf-8?B?RkswTnhhYm56enZxMUE5SnpLaGlZN3pnZXNCMnlaeVlpQWc1cVFTZVpLUG1u?=
 =?utf-8?B?VmNOaC80ZDZlZWQ1U2xSb2hLM3puWHU2QWoxazJnd0xjZFpJVmZXaGVQa0xk?=
 =?utf-8?B?cGJOQm5ZNis1TFFxWGJkYW51eUlBYURTak5NNkZobnVoQjhMc0RDVnR2aGcv?=
 =?utf-8?B?dzRHT2Jzem1hdmVMV1RsajNNZTdrRlR4OURUYzBRMDkvUmRzWkd2UTBVZHVJ?=
 =?utf-8?B?RHZiZHBOOTRJYjU2TjNub29MM1pDQkkzYU1XamE5V3d1ZmJIbE5pMVViWm1B?=
 =?utf-8?B?TTZKUFZib3ZQZzBJd0Z6emtKb3VVVE1DN09GcEQzaXlLay9iNzE1azVCb3lx?=
 =?utf-8?B?YkVHSUorb2VMOTNOd29NV1UyM1BGS096bTlEanVnTUNhM3NMeW1pbXlka2ZL?=
 =?utf-8?B?K2xXS1JLbCtpdE9qRmFxSlpmQVEwOTR5c2VwZnZ0TG96bGFsUEVxaUdXYkpR?=
 =?utf-8?B?eXZsdWJram92WklJbkUvZVJNQ0l4VVdaK2s2ZkF6T2ZZM1dRUzBYK2tBQk43?=
 =?utf-8?B?OFV1eWgrSEY2NnQ4SmF0N2hZdU5aeUpzNEFvMjJUOTVnNEMvZzZFN2xIQkxw?=
 =?utf-8?B?RHloYVJjazBFNU5vKzdUVytSeWlMdWJPTFFPeVhiUDR2b3hRWklvUENpamJ0?=
 =?utf-8?B?NFQ1eUY0dVRhUm90OUhUUnIraExSb1pCcGwwUGwrN2h5TTNESEhETkZQbitp?=
 =?utf-8?B?N1lHY0IxVWJuWnRpNk5OVmtYajVZaVNzZjUzZXFvOFRSZFFmTGI4VitSbnFK?=
 =?utf-8?B?TFFVYW5pMWQzdGI4bzduODIzQ3RiaHJwUjdEMUNJWklMdndBRzRKTnc0bXRY?=
 =?utf-8?B?ZFdwT0QwanIybmlQd3JzZkdsUjhEZGVDeW1Xa0lSRjBOdnVBL0RSQ1QxOTl1?=
 =?utf-8?B?VnJHSUtyaGwxU2l4YjZwd1JwMjF3REYzWDBsSFZPaVdZd1lGUmZvZTVRVTZI?=
 =?utf-8?B?bVk0QzB6cUhGc0NNK09EVnRGSGlnclBoOXRxR1lpTlY0NklQdXY4K2hRajY4?=
 =?utf-8?B?YS9Wa0xLUHdzb0hkMGpPZ0FKTVNmZlBteWlHa3FGSTlFS0JHZm50bHVpM3BF?=
 =?utf-8?B?WWNwUnRtRFlXdzBDNWpQNVV5MHpyZHZxQWNYcUlXSkFPYWQyTlRqeXFCK2RW?=
 =?utf-8?B?bEZHSDdUNHJrMjRaYWJzTHduQ2JRUmZGUVZtd0p5MWNFT3VLcmtkVlRkalpB?=
 =?utf-8?B?MFo5aW92clhOR0VISElnZEV0dWw1WkVIeVZJMnRHenBKUFhUN1dHZWdRM3Rx?=
 =?utf-8?B?aWZnb0xDQk51aEVkUlZYcEtWa0I0bVZyczdBN2J4dFZiYmZMcHFFYlc3OWFi?=
 =?utf-8?B?c2RqT1pORnBFSUNSdm1nZ3BWZ2o3TmRtWjExVHNuZFhTU2xwRm8vcmpNd0RR?=
 =?utf-8?B?QUZNZnZ3OE5WSkJHOVowK0JXOWhKbmZRNldRYWRKcXZJRXNlMW4rUlIrc3FP?=
 =?utf-8?B?cithNGl3Zm9DNjZ3cndBMzNSSWl3YmMyR1Q1bm9UMmVuRFF5Ym1lSVIyK09E?=
 =?utf-8?B?V20wNTdINW5QNnplMkYrdzg1NGZYdjFjdFpEUCtaRkFkMTdMb2tRR0lSanpx?=
 =?utf-8?B?NFJsL0NWNkp6NXFDRWhmNDI0aWNJeDU1dFhubEgxdFlkL1drNEpiMk85UXVG?=
 =?utf-8?Q?P3zX5bc+3+fNx?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1N5RGVKQStPTXNxeVI5SGpFRENHb3dFSm5CeHU2QUpERkdjQWQxZEc1WEdU?=
 =?utf-8?B?azI2UVVpakZVY1VLOStLbmdQQWtUMkdma3hMdVFWT2czSmprSEJWQ1lyd2tF?=
 =?utf-8?B?bmdhNno4OW9UOGNrbk00N2VnNk8wZnVtbDZxSEF4Q0pLMUFTZ3dOemJCNHRn?=
 =?utf-8?B?aGdrWWMrYmdnbmJ6VXNGTjI2TUo4bVJreFU4YjllWmdLeTVTVkEzQXByM3p3?=
 =?utf-8?B?Z2dyenhBclozL21Qc2Ywa2xSZWxYZkVRem5RUmZyVFBpOE0wcElSR2VhNzZw?=
 =?utf-8?B?dHVaWitEaGp4RWRJL2Z6Y2xjbXRwcDNPcFlWY2lXUXFWc29LTWtGQ3FiYjhs?=
 =?utf-8?B?eE1QTStxZlRFWitmeEV3LzlxOXFySFV6clNQb3p4Nlh6RUgycGVGQlgyWmJm?=
 =?utf-8?B?YlFSMWh3aitUZFA5UmtCNmlrOHNRVTM3Y253WUtwRTJUWC83TmVGNzdnSEJ4?=
 =?utf-8?B?a2hsQ0Y4UzNKWFlhWHZJdE5QY01UdUZraGxLdjdiaXFWQzU1KzZVWVZnS1E3?=
 =?utf-8?B?d0liWStOZ09YSjV2TDM2Qy85dExpaUJUN0xwMStLemNlbWdlanczdlVRcmVw?=
 =?utf-8?B?U0dTc2EzcHA4NEpnZFU1YStJaEVCK0UxbEF5WXlzSUNpWFhLNE5vWExMYjlV?=
 =?utf-8?B?MjZGdGFKQmRJNVZCd0p4WWcwZnlWSzNRdVpsMEhQRmZJVk42SGtYRmU1RmtK?=
 =?utf-8?B?MVBHOGU3R1BiYUlMdnpOSEdpaEVRWUo0UnNwZmhycXN3dmFDcnNjMlpPdDBL?=
 =?utf-8?B?K0JCU2E4RjJsdDRRNTVoSzgvL2c0RlJSdlk4TTBlVTlkRTg3T2NYZitnR2RY?=
 =?utf-8?B?Qm0xbXhSdlRub1J2Qk14UE9wekpMVFlWcTFBR0lzTnFwOWw0SjNSR2tESFdj?=
 =?utf-8?B?a2RTanROYUxJdFo4Vkp1OS9XbTZPaVNJQ0VyeG93WEswUU5TemhmeEluR1BE?=
 =?utf-8?B?cXU0RHcvem80eU5qR0VzWDF0Mkx1cC9OQ2djRXJEWWZFUG1xU2s3bHhlNEI2?=
 =?utf-8?B?VnNDUXJIWGtKR0pVQVlQMXQ5M1ZrUHpsVHRZRkhXUXJPdUw5Sy9hMVhZekRX?=
 =?utf-8?B?RUNMOWlycXNlMkdhcGdad3JVYTlEd1F3bzJJUUhFdWVXS1dLbWcrZEtrMVZU?=
 =?utf-8?B?ZFJ4V25nZEMwZlVXZzhHUHRUcTZWQ1J0MmhYbDA0YnBhYldjZTVWYnpaSFgw?=
 =?utf-8?B?UHpwNlJqTGg4cHVlZCt2b0lCSjFER3U3S0ZINDB2amoweCtsZGVFd2N0T1dn?=
 =?utf-8?B?aUFCblA5ekdSYkR2YmpuOS8wVTRSbUNMRXp1S1hBemxDZnhaV0xGcm9kbjN5?=
 =?utf-8?B?REJua3J5dU1wR3VtM1A3ZllqaHdKcm1YVVFNaDBCYkdERXFaUVlXMUU4TEtI?=
 =?utf-8?B?OHcvbFRmOWJaRWN4cEF6UVF3OElWcThhUC94ZEJ4cHVyYVFRVGtYdkhWSFAv?=
 =?utf-8?B?N051OHBMY2JwUFNBUlBpMjM1cngxQmN3SGZSbXFWODRjYXl5K0pWUWdEMEVB?=
 =?utf-8?B?K3psaFREYlZkZis0UGI0aDhNbTB2bHMza1NvbVcyY2VXWTVwd1JvVTYxMDFo?=
 =?utf-8?B?NkpjNlBPd1ovdmI4Y0Fab2JmTlRmU0xmN1d5UVJOSkdrUlB4MHBhZThwVktD?=
 =?utf-8?B?VUlkUUE2Q0M1NVF5ZWV3MW1WaTZhT1JiME0yNGd1RHJob1RidEczUnZIc2hG?=
 =?utf-8?B?MFRucXBiU1phdUdMTkZZVXNob2JjVDErZ1dXZG1OSUtxN1M4Y08zbTRoYkd4?=
 =?utf-8?B?NHJsNUNXWDBuN25QRHBsZ2RXY1NiVnEwVHRvNTd2L01jcjFkcHZ5U25SSEtx?=
 =?utf-8?B?Ny81WnNUdmh2WGNTT0RDTW9VbUhsWGtWTjBwN2dFOTFjNnFmUDdqdDMveDZU?=
 =?utf-8?B?cGpQRXhNbWRhdmVaeFRuaTNwOW1JM2JNS1U0VXhjRlM5Y29ISnVFemM1aE96?=
 =?utf-8?B?Z2IxY1RzemxjWllBQWNBZWZpMlFYUW4yK0VnSTdjK2Y3RHNjcXVoRVhlK0N6?=
 =?utf-8?B?VXYrSTRPVTR1dldrdDcxWktEVTJFS20rM0d5QzZRWG5hcENaK0thU1pTbHBH?=
 =?utf-8?B?azh1dnFaT1EySURkVXBHaWtMSmo5VGNhWkFDVEhZMDlmNGUzTEI5T0hyK25Y?=
 =?utf-8?B?VHFJNDFLY210dXBIWXo5L1RsUDFUNUg2ZUdvUkQ3eCsrVVQwV3dqdSs0cW01?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21257FFA195B074A8D54AC857A60000E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66c883f-b029-4926-0fd2-08dc89d8516d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 05:35:35.1426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFHq6gQsAF9kNTxPFArFNFwZBi6b43M11nZuhzGxTmaklhH1lKeLjDLvmfWNKlxIPOpttD3aH9TGe6t/bCxMQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7941
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA2LTEwIGF0IDEwOjA3ICswMDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToKPiBBZnRlciBjb21taXQgKCJ4ODYvY3B1L3RvcG9sb2d5OiBBZGQgc3VwcG9ydCBmb3IgdGhl
IEFNRCAweDgwMDAwMDI2Cj4gbGVhZiIpLAo+IG9uIEFNRCBwcm9jZXNzb3JzIHRoYXQgc3VwcG9y
dCBleHRlbmRlZCBDUFVJRCBsZWFmIDB4ODAwMDAwMjYsIHRoZQo+IHRvcG9sb2d5X2RpZV9jcHVt
YXNrKCkgYW5kIHRvcG9sb2d5X2xvZ2ljYWxfZGllX2lkKCkgbWFjcm9zLCBubwo+IGxvbmdlcgo+
IHJldHVybiB0aGUgcGFja2FnZSBjcHVtYXNrIGFuZCBwYWNrYWdlIGlkLCBpbnN0ZWFkIHRoZXkg
cmV0dXJuIHRoZQo+IENDRAo+IChDb3JlIENvbXBsZXggRGllKSBtYXNrIGFuZCBpZCByZXNwZWN0
aXZlbHkuIFRoaXMgbGVhZHMgdG8gdGhlCj4gZW5lcmd5LXBrZwo+IGV2ZW50IHNjb3BlIHRvIGJl
IG1vZGlmaWVkIHRvIENDRCBpbnN0ZWFkIG9mIHBhY2thZ2UuCj4gCj4gUmVwbGFjaW5nIHRoZXNl
IG1hY3JvcyB3aXRoIHRoZWlyIHBhY2thZ2UgY291bnRlcnBhcnRzIGZpeGVzIHRoZQo+IGVuZXJn
eS1wa2cgZXZlbnQgZm9yIEFNRCBDUFVzLgo+IAo+IEhvd2V2ZXIgZHVlIHRvIHRoZSBkaWZmZXJl
bmNlIGJldHdlZW4gdGhlIHNjb3BlIG9mIGVuZXJneS1wa2cgZXZlbnQKPiBmb3IKPiBJbnRlbCBh
bmQgQU1EIENQVXMsCgpBY3R1YWxseSwgb24gSW50ZWwgcGxhdGZvcm1zLCB0aGUgZW5lcmd5LXBr
ZyBldmVudCBpcyBhbHNvIHBhY2thZ2UKc2NvcGUgZXhjZXB0IG9uZSBwbGF0Zm9ybSwgYW5kIHRo
YXQgb25lIGlzIHRoZSBvbmx5IG11bHRpLWRpZSBzeXN0ZW0Kd2l0aCBSQVBMIE1TUnMgYXZhaWxh
YmxlLgpTbyB0aGF0IGlzIHdoeSB0aGUgZGllL3BrZyBsb2dpYyB3YXMgaW50cm9kdWNlZCBpbiB0
aGUgZmlyc3QgcGxhY2UuCgpJIGxpa2UgdGhlIG1hY3JvL2hlbHBlcnMgaW4gdGhpcyBwYXRjaC4g
VGhlIGxvZ2ljIGluc2lkZSB0aGVtIG1heSBuZWVkCnRvIGJlIG9wdGltaXplZCBmb3IgSW50ZWwg
cGxhdGZvcm1zLCBidXQgdGhhdCBpcyBhIHNlcGFyYXRlIHRhc2suCgo+ICB3ZSBoYXZlIHRvIHJl
cGxhY2UgdGhlc2UgbWFjcm9zIGNvbmRpdGlvbmFsbHkgb25seSBmb3IKPiBBTUQgQ1BVcy4KPiAK
PiBPbiBhIDEyIENDRCAxIFBhY2thZ2UgQU1EIFplbjQgR2Vub2EgbWFjaGluZToKPiAKPiBCZWZv
cmU6Cj4gJCBjYXQgL3N5cy9kZXZpY2VzL3Bvd2VyL2NwdW1hc2sKPiAwLDgsMTYsMjQsMzIsNDAs
NDgsNTYsNjQsNzIsODAsODguCj4gCj4gVGhlIGV4cGVjdGVkIGNwdW1hc2sgaGVyZSBpcyBzdXBw
b3NlZCB0byBiZSBqdXN0ICIwIiwgYXMgaXQgaXMgYQo+IHBhY2thZ2UKPiBzY29wZSBldmVudCwg
b25seSBvbmUgQ1BVIHdpbGwgYmUgY29sbGVjdGluZyB0aGUgZXZlbnQgZm9yIGFsbCB0aGUKPiBD
UFVzIGluCj4gdGhlIHBhY2thZ2UuCj4gCj4gQWZ0ZXI6Cj4gJCBjYXQgL3N5cy9kZXZpY2VzL3Bv
d2VyL2NwdW1hc2sKPiAwCj4gCj4gU2lnbmVkLW9mZi1ieTogRGhhbmFuamF5IFVnd2VrYXIgPERo
YW5hbmpheS5VZ3dla2FyQGFtZC5jb20+Cj4gRml4ZXM6IDYzZWRiYWE0OGE1NyAoIng4Ni9jcHUv
dG9wb2xvZ3k6IEFkZCBzdXBwb3J0IGZvciB0aGUgQU1ECj4gMHg4MDAwMDAyNiBsZWFmIikKClJl
dmlld2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+Cgp0aGFua3MsCnJ1aQo+
IC0tLQo+IFBTOiBUaGlzIHBhdGNoIHdhcyBlYXJsaWVyIHNlbnQgc2VwYXJhdGVseShsaW5rIGJl
bG93KSwgaXQgaGFzIG5vdAo+IGJlZW4gCj4gbWVyZ2VkIHlldCwgaXQgaXMgbmVjZXNzYXJ5IGZv
ciB0aGlzIHBhdGNoc2V0IHRvIHdvcmsgcHJvcGVybHksIGFsc28KPiBpdCAKPiBmaXhlcyB0aGUg
cHJlLWV4aXN0aW5nIGVuZXJneS1wa2cgZXZlbnQuCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtcGVyZi11c2Vycy8yMDI0MDUwMjA5NTExNS4xNzc3MTMtMS1EaGFuYW5qYXkuVWd3ZWth
ckBhbWQuY29tLwo+IC0tLQo+IMKgYXJjaC94ODYvZXZlbnRzL3JhcGwuYyB8IDMwICsrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2V2ZW50cy9yYXBs
LmMgYi9hcmNoL3g4Ni9ldmVudHMvcmFwbC5jCj4gaW5kZXggYjk4NWNhNzljZjk3Li43M2JlMjVl
MWY0YjQgMTAwNjQ0Cj4gLS0tIGEvYXJjaC94ODYvZXZlbnRzL3JhcGwuYwo+ICsrKyBiL2FyY2gv
eDg2L2V2ZW50cy9yYXBsLmMKPiBAQCAtMTAzLDYgKzEwMywxMCBAQCBzdGF0aWMgc3RydWN0IHBl
cmZfcG11X2V2ZW50c19hdHRyCj4gZXZlbnRfYXR0cl8jI3YgPSB7wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+IMKgwqDCoMKgwqDC
oMKgwqAuZXZlbnRfc3RywqDCoMKgwqDCoMKgPQo+IHN0cizCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+IMKgfTsKPiDCoAo+ICsjZGVmaW5lIHJhcGxfcG11X2lz
X3BrZ19zY29wZSgpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoFwKPiArwqDCoMKgwqDCoMKgwqAoYm9vdF9jcHVfZGF0YS54ODZf
dmVuZG9yID09IFg4Nl9WRU5ET1JfQU1EIHx8wqDCoFwKPiArwqDCoMKgwqDCoMKgwqAgYm9vdF9j
cHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfSFlHT04pCj4gKwo+IMKgc3RydWN0IHJh
cGxfcG11IHsKPiDCoMKgwqDCoMKgwqDCoMKgcmF3X3NwaW5sb2NrX3TCoMKgwqDCoMKgwqDCoMKg
wqDCoGxvY2s7Cj4gwqDCoMKgwqDCoMKgwqDCoGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoG5fYWN0aXZlOwo+IEBAIC0xNDAsOSArMTQ0LDIxIEBAIHN0YXRpYyB1
bnNpZ25lZCBpbnQgcmFwbF9jbnRyX21hc2s7Cj4gwqBzdGF0aWMgdTY0IHJhcGxfdGltZXJfbXM7
Cj4gwqBzdGF0aWMgc3RydWN0IHBlcmZfbXNyICpyYXBsX21zcnM7Cj4gwqAKPiArc3RhdGljIGlu
bGluZSB1bnNpZ25lZCBpbnQgZ2V0X3JhcGxfcG11X2lkeChpbnQgY3B1KQo+ICt7Cj4gK8KgwqDC
oMKgwqDCoMKgcmV0dXJuIHJhcGxfcG11X2lzX3BrZ19zY29wZSgpID8KPiB0b3BvbG9neV9sb2dp
Y2FsX3BhY2thZ2VfaWQoY3B1KSA6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IHRvcG9sb2d5
X2xvZ2ljYWxfZGllX2lkKGNwdSk7Cj4gK30KPiArCj4gK3N0YXRpYyBpbmxpbmUgY29uc3Qgc3Ry
dWN0IGNwdW1hc2sgKmdldF9yYXBsX3BtdV9jcHVtYXNrKGludCBjcHUpCj4gK3sKPiArwqDCoMKg
wqDCoMKgwqByZXR1cm4gcmFwbF9wbXVfaXNfcGtnX3Njb3BlKCkgPyB0b3BvbG9neV9jb3JlX2Nw
dW1hc2soY3B1KSA6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0b3BvbG9neV9kaWVfY3B1bWFz
ayhjcHUpOwo+ICt9Cj4gKwo+IMKgc3RhdGljIGlubGluZSBzdHJ1Y3QgcmFwbF9wbXUgKmNwdV90
b19yYXBsX3BtdSh1bnNpZ25lZCBpbnQgY3B1KQo+IMKgewo+IC3CoMKgwqDCoMKgwqDCoHVuc2ln
bmVkIGludCByYXBsX3BtdV9pZHggPSB0b3BvbG9neV9sb2dpY2FsX2RpZV9pZChjcHUpOwo+ICvC
oMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCByYXBsX3BtdV9pZHggPSBnZXRfcmFwbF9wbXVfaWR4
KGNwdSk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgLyoKPiDCoMKgwqDCoMKgwqDCoMKgICogVGhl
IHVuc2lnbmVkIGNoZWNrIGFsc28gY2F0Y2hlcyB0aGUgJy0xJyByZXR1cm4gdmFsdWUgZm9yCj4g
bm9uCj4gQEAgLTU0Myw2ICs1NTksNyBAQCBzdGF0aWMgc3RydWN0IHBlcmZfbXNyIGFtZF9yYXBs
X21zcnNbXSA9IHsKPiDCoAo+IMKgc3RhdGljIGludCByYXBsX2NwdV9vZmZsaW5lKHVuc2lnbmVk
IGludCBjcHUpCj4gwqB7Cj4gK8KgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IGNwdW1hc2sgKnJh
cGxfcG11X2NwdW1hc2sgPQo+IGdldF9yYXBsX3BtdV9jcHVtYXNrKGNwdSk7Cj4gwqDCoMKgwqDC
oMKgwqDCoHN0cnVjdCByYXBsX3BtdSAqcG11ID0gY3B1X3RvX3JhcGxfcG11KGNwdSk7Cj4gwqDC
oMKgwqDCoMKgwqDCoGludCB0YXJnZXQ7Cj4gwqAKPiBAQCAtNTUyLDcgKzU2OSw3IEBAIHN0YXRp
YyBpbnQgcmFwbF9jcHVfb2ZmbGluZSh1bnNpZ25lZCBpbnQgY3B1KQo+IMKgCj4gwqDCoMKgwqDC
oMKgwqDCoHBtdS0+Y3B1ID0gLTE7Cj4gwqDCoMKgwqDCoMKgwqDCoC8qIEZpbmQgYSBuZXcgY3B1
IHRvIGNvbGxlY3QgcmFwbCBldmVudHMgKi8KPiAtwqDCoMKgwqDCoMKgwqB0YXJnZXQgPSBjcHVt
YXNrX2FueV9idXQodG9wb2xvZ3lfZGllX2NwdW1hc2soY3B1KSwgY3B1KTsKPiArwqDCoMKgwqDC
oMKgwqB0YXJnZXQgPSBjcHVtYXNrX2FueV9idXQocmFwbF9wbXVfY3B1bWFzaywgY3B1KTsKPiDC
oAo+IMKgwqDCoMKgwqDCoMKgwqAvKiBNaWdyYXRlIHJhcGwgZXZlbnRzIHRvIHRoZSBuZXcgdGFy
Z2V0ICovCj4gwqDCoMKgwqDCoMKgwqDCoGlmICh0YXJnZXQgPCBucl9jcHVfaWRzKSB7Cj4gQEAg
LTU2NSw2ICs1ODIsOCBAQCBzdGF0aWMgaW50IHJhcGxfY3B1X29mZmxpbmUodW5zaWduZWQgaW50
IGNwdSkKPiDCoAo+IMKgc3RhdGljIGludCByYXBsX2NwdV9vbmxpbmUodW5zaWduZWQgaW50IGNw
dSkKPiDCoHsKPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgcmFwbF9wbXVfaWR4ID0gZ2V0
X3JhcGxfcG11X2lkeChjcHUpOwo+ICvCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBjcHVtYXNr
ICpyYXBsX3BtdV9jcHVtYXNrID0KPiBnZXRfcmFwbF9wbXVfY3B1bWFzayhjcHUpOwo+IMKgwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgcmFwbF9wbXUgKnBtdSA9IGNwdV90b19yYXBsX3BtdShjcHUpOwo+
IMKgwqDCoMKgwqDCoMKgwqBpbnQgdGFyZ2V0Owo+IMKgCj4gQEAgLTU3OSwxNCArNTk4LDE0IEBA
IHN0YXRpYyBpbnQgcmFwbF9jcHVfb25saW5lKHVuc2lnbmVkIGludCBjcHUpCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwbXUtPnRpbWVyX2ludGVydmFsID0gbXNfdG9fa3RpbWUo
cmFwbF90aW1lcl9tcyk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYXBsX2hy
dGltZXJfaW5pdChwbXUpOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJh
cGxfcG11cy0+cG11c1t0b3BvbG9neV9sb2dpY2FsX2RpZV9pZChjcHUpXSA9IHBtdTsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmFwbF9wbXVzLT5wbXVzW3JhcGxfcG11X2lkeF0g
PSBwbXU7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKgo+IMKg
wqDCoMKgwqDCoMKgwqAgKiBDaGVjayBpZiB0aGVyZSBpcyBhbiBvbmxpbmUgY3B1IGluIHRoZSBw
YWNrYWdlIHdoaWNoCj4gY29sbGVjdHMgcmFwbAo+IMKgwqDCoMKgwqDCoMKgwqAgKiBldmVudHMg
YWxyZWFkeS4KPiDCoMKgwqDCoMKgwqDCoMKgICovCj4gLcKgwqDCoMKgwqDCoMKgdGFyZ2V0ID0g
Y3B1bWFza19hbnlfYW5kKCZyYXBsX2NwdV9tYXNrLAo+IHRvcG9sb2d5X2RpZV9jcHVtYXNrKGNw
dSkpOwo+ICvCoMKgwqDCoMKgwqDCoHRhcmdldCA9IGNwdW1hc2tfYW55X2FuZCgmcmFwbF9jcHVf
bWFzaywgcmFwbF9wbXVfY3B1bWFzayk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmICh0YXJnZXQgPCBu
cl9jcHVfaWRzKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4g
wqAKPiBAQCAtNjc3LDYgKzY5Niw5IEBAIHN0YXRpYyBpbnQgX19pbml0IGluaXRfcmFwbF9wbXVz
KHZvaWQpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBucl9yYXBsX3BtdSA9IHRvcG9sb2d5
X21heF9wYWNrYWdlcygpICoKPiB0b3BvbG9neV9tYXhfZGllc19wZXJfcGFja2FnZSgpOwo+IMKg
Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJhcGxfcG11X2lzX3BrZ19zY29wZSgpKQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBucl9yYXBsX3BtdSA9IHRvcG9sb2d5X21heF9wYWNrYWdl
cygpOwo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgcmFwbF9wbXVzID0ga3phbGxvYyhzdHJ1Y3Rfc2l6
ZShyYXBsX3BtdXMsIHBtdXMsCj4gbnJfcmFwbF9wbXUpLCBHRlBfS0VSTkVMKTsKPiDCoMKgwqDC
oMKgwqDCoMKgaWYgKCFyYXBsX3BtdXMpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gLUVOT01FTTsKCg==

