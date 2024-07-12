Return-Path: <linux-pm+bounces-11013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A292F3E9
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 04:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6731F22DF1
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 02:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD84B79F6;
	Fri, 12 Jul 2024 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwyi4HFF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4E07464;
	Fri, 12 Jul 2024 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720749871; cv=fail; b=A6qtvge0WItA5LuRUW/q2ykuWPnKmdbXmH1FsTUdlZQnDnyn7r70uKtASapca+wATwJTyXeqbFVdX63Kai6bHTP3CM0DH/ZN2rkdT+OcOM2ePMoa8YkTxijKZrDxmt+rzbAV3W1GZi/qti4EYOVUcmnMdVOGnWGXN1r0aU7ibYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720749871; c=relaxed/simple;
	bh=P1auCa4zuV3D1zX3U5urUizFoJ3ZF81744THZKkCy7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hg2Pu1K0NglYqQLWQLsZyjUJsIRZ6wOL3iUdYRMkWhHKch5JN2DNoh4FC3w9pgOb7zrHqgYrqGdDARNI0fkF9oFB0meT/EGtZrJtpfRVM3PoCM3yMfMmn7pdk6KhKBYldZT89mJHdNOOT++P7yCpECdVA8iOOf4rSbypN76P5rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwyi4HFF; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720749869; x=1752285869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P1auCa4zuV3D1zX3U5urUizFoJ3ZF81744THZKkCy7Q=;
  b=cwyi4HFFzCzPw/jS1FiJF6pReB2LEcpAaEn3cF4WgwSjHWVuxrVpfHqt
   SQ+D+WFMUaKetS3H55f7Mle5KRmju0oncnXkKmHrTTZ83Cr+NJ69mB9EC
   XZIY8HFZ5Ilo+L+9J8Y/kJ5QFw/5ekz2wAeJb7vn+SsGgYk7A31jy0g92
   EcQO9qt0FF5PAK85kPF35mT3fLGuBvPZO7ZFW2NSrpFlsrcjMq17eflg6
   6ppHyKKnXKBABcMfzeo2BQBwl+nZKV0YJ/uJr+tGyu+91gVdN9wRWYnhi
   RMnG4XUMpioLMvqGIzOXKKRa21px71L5AzcNqDarMb41U0PC+uITiPZev
   Q==;
X-CSE-ConnectionGUID: sX0gnxnJSTiekZ75Yv+SXw==
X-CSE-MsgGUID: CnoOzoarTaugApoa1+ZN/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="21935021"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="21935021"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 19:04:28 -0700
X-CSE-ConnectionGUID: W60rmkGVRG28451A8APgbw==
X-CSE-MsgGUID: z9cO5TL1Qf21drYvNzbE6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="53143493"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 19:04:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 19:04:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 19:04:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 19:04:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyX/zDWbcUPnWBnnHEttxKZw0ZT42Zjndb42PIFVj3WtseeOEea6JmnDgsu1yZLmboda/sAhyZuy+BecZ3jJpuxj6xqiaFiA0MmNl1DTafa9KrTJb1bnzDCKbsDegZ8i2Zojip6gMt1X7UAeUVhF5+WNA0ll2xS8fAltTvIUqhJiUi1g0Eh5ckTOFQpOzzu3cJwf0iOL5i1lDYvCg986bxAhVcI1oR6zJ9rXzBmF5ZAM52Hmh4UDMngdy1aC5ZrungO/6AXGVDExY5FQ0/H3OMDoHIO7Jbhian5tY1FjY6U6Nag40fiVbPiBRdsG0j7WCkUwve1ErJc0cENOl26MWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1auCa4zuV3D1zX3U5urUizFoJ3ZF81744THZKkCy7Q=;
 b=LTwE62TmY7XP8vBUj4xVQ6gVuORg3lsuhezfpK8mdxdj5+ciPhbl+dj+Qa7XDM18ITCPSURVbTsgcsghvR2FbimzsxL1fhuxG3Dg4j5nZJw4lDEN/jXafgkeiLX89UGdH8kHqDGPqXFLuW7c4puWEfN4v93IpyevAuFb5ymO+dvTGsAXo99zuF5m2c3OSW0cwi2BSI3DyILXMLI+VPwSL3RTgETacEm4spGPl2z6hzrLZg7BGe2oFTtlG+rkdhYrR69sXVtOn8wUDU9NUYpR0zhKGVgSPuWtO8s2iV9vnw8uPgsp8kz15RH9AiaXCqQQqAEdmXuCMp0Rg9YFwsweBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CH0PR11MB5266.namprd11.prod.outlook.com (2603:10b6:610:e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 02:04:25 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 02:04:25 +0000
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
Subject: Re: [PATCH v4 02/11] perf/x86/rapl: Fix the energy-pkg event for AMD
 CPUs
Thread-Topic: [PATCH v4 02/11] perf/x86/rapl: Fix the energy-pkg event for AMD
 CPUs
Thread-Index: AQHa030S+vbjzdhkCUy/2eLODqm9QLHyWICA
Date: Fri, 12 Jul 2024 02:04:25 +0000
Message-ID: <4caed546c761218467796e5611430f23f070bf3f.camel@intel.com>
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
	 <20240711102436.4432-3-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240711102436.4432-3-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CH0PR11MB5266:EE_
x-ms-office365-filtering-correlation-id: d99d63b0-5a80-439e-76fb-08dca216f447
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V2pNZFRGT01ZUFprRXdsZHd1enVUYmVUeU10Z2JKYkgvc0JZclhVNjJMT1Qw?=
 =?utf-8?B?TktYTUVIQWpxd2FrU0hKREZJMEk0SmhQUWk0NzdiSUMrV09NVkN5cXJ6MlZ5?=
 =?utf-8?B?NHd2U3laTmpRb010bkVkR1hydk4yQUllUmpQSlF0TnQ0NmJUQjl6eWhBdThu?=
 =?utf-8?B?WHAyWXdqOEJtWHd2UWVnbVlmQllXdWlsazVJK0IwQ0lJYktHNTgvQ0F3bVR0?=
 =?utf-8?B?UTNPZTBvckIwYkV3Vy9Hd1lnSzVVbGhkaHY5cll3MDZkR29icVQ1cFV2RjZa?=
 =?utf-8?B?WXVYWlBDcUxRZ1FJUWNPYnYvWUZkbDd0MzdPckdDWmQ2a0ZqVTUycVlyR25T?=
 =?utf-8?B?Y29jSVpBMFVHaUc1OFFNaFExQmF1MW1iNzRhRFJQbTE0dkkxQ0tzK2tDMklN?=
 =?utf-8?B?TVovRUk0ZUZGYjR1S056WHBWVTlJd0JTUktocXBVcjNiQXhxZ2JFbElXd2pq?=
 =?utf-8?B?ZDdNWmVDRDVQeStvcU5vUHpub0NsckRVMTc5VWhlbTVmTGVxbDYvcjhmZ0o2?=
 =?utf-8?B?dnZWajFWS1pkM2VsaklGRFNHZDcvOGphc0FaZld1ZnVrYW40RitSTUU3amI4?=
 =?utf-8?B?YS9WN2hLVDdkQytwS2YxSGdJVS9ZRlF1end1eHoyVk1PSC80ZkxKT3doblpU?=
 =?utf-8?B?R0VGb1lsUm0zQ0l6bVhuZllPZWRTWTRScnRNWkx2dkdqejNraUEvbFVwNHZl?=
 =?utf-8?B?eUxJSHhlN0R4bk5wVzI0b2F2VU9Sa0pPdHBOcklKUFF2T1hlSUVLOHV1WHNs?=
 =?utf-8?B?VjNuRERPcDhaSVhBUklvNEJaVlJPNU5FazhUVlcvWi9kMkNTcDN1SUpKb1My?=
 =?utf-8?B?enVGVUZzNGs3NEpmZzFVNm92TjJCWG1YYlJmb2V4VnAvTXhyZmNNS3phcStX?=
 =?utf-8?B?YXNWWGdHMDB5Mm41b0w0K3RLOHRPd0JaSFhFU0c0bk9uSllFZUxzYkdqT1Z0?=
 =?utf-8?B?S3FIYmtPMVBLakVCZzJmbjhrMXQrTXVWT2dGWFFWdDd1NzFscmxoYzlZSkR3?=
 =?utf-8?B?cnVCVm9ENVY4YmR4WFhpeC84TkhMU2cyc0JTNUpld3ZvZ3BETDFaVm0vM25R?=
 =?utf-8?B?SVNTemhnTzB1RUJKVkdZL0ozTmp1KzFqcTVRdHV2RTZybEw0ZElpemFXWnJN?=
 =?utf-8?B?NHkzSGxZTWtnb2FNMGN4RFlWUmF4QkVCaittQ2dRaXQ3eTY4UkYvNkJ2UHU4?=
 =?utf-8?B?ODlZRE4zREF5SXlVcFljL0lIK1N3cVQwLzFQWjYva2F0cHNIUkhWMEdBZHo0?=
 =?utf-8?B?VGphcUdtVTRqaXRGUjNJQzJuc0laZU5sTjRCcG5tMUU2QW5zZk0yenZRNzcr?=
 =?utf-8?B?Vng0d0ZJYkJqQzBLUVExbGxsaU5LZU05a1pzM1JxSjBqTDE2SHJ5WTRPWlFh?=
 =?utf-8?B?eUExME8vaVcxQ3hNQ2VhYkNUOFNYT1pCT2ZSekxPRUNnM0Uzc1oxbXc3TE9M?=
 =?utf-8?B?amgwVTN3Vm5HcWdHcisxOGZROVhHL1V4VVNNN3lray9tMERYUmNYSCtXcEhG?=
 =?utf-8?B?YVk3MXhUUVV3R3lHbk1HVGw2NXJHQmFGdm1MeUZIRlR3eTdnWTVFaCtuTmxM?=
 =?utf-8?B?RlA0T2pqQ01FVDF5TzlaNFRSb3JYSkpsWXBGMmtyVitKRjJKdEJTcXFOSDE4?=
 =?utf-8?B?cW01MDB1aHhPazIrdVdWdzFzWUhIT09uamJJL2ZOZ0hVRUY1WjlReE56YzV3?=
 =?utf-8?B?VHJEQ0JxL0MreGNONVlzZFM2NkI0aWgyMHdJdi9MMFJhOUNNNUFyMzU0RjMx?=
 =?utf-8?B?NDZ1VVh0TFZtMDA5WC9na08vcHI0WXIrdGFnRTJ3Q0IwMHg4Y25zMXMrRTQ2?=
 =?utf-8?B?Q2t0Y2Z0dTdSR1lLZnNGMERrOUM3eWp2UFRXdjFiVDVrOEZWNzYzdHBZcy9x?=
 =?utf-8?Q?wdlHW2E/TW9QI?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amRCU2hBdHh4V1A1SDg3enBWWlY1UE5XaUZGV1dKaDB3MlpLZlBkTVRHb25n?=
 =?utf-8?B?Z1ZDeFhsVVlRVkh2cEkyWEhUYTU4VzhjbHg3OXBFUzdNRkZkbWhQQXYvaFl2?=
 =?utf-8?B?VDZsTDl2UkhlRndSTHpHcVc4aXVZNUJ2MGQ3TzlSbjI0Q1dZdnFzbVg2cEpa?=
 =?utf-8?B?cW9SR1l6WXFsRm5YcWZBZkVHZHJyNldVak41WE5wRUtTMkNSbFFEK3hZS0FK?=
 =?utf-8?B?djErR1ZXTXoxOWQycWs0Wnk0ZHpUSW5NMjI5dU5mb3FIU0djT2pacG1ISXB2?=
 =?utf-8?B?ZVIzTkpldW03eTRYbktFejJjSW1WdzM3ZHFHdFB3Wk9wM2NhMFZ4VXhlczF6?=
 =?utf-8?B?b3M2K1NONGt5c2NCS1JTWHlJaW41ZUcycmRwMUsraXRwNFBjcmdoTDdOc1JG?=
 =?utf-8?B?OW40bTBrcmw3bWRMKzdWSzRyTG03d2RCVmxKVXB0bHNyUHBJazdJdDZTNW9Z?=
 =?utf-8?B?OFY3WUtOT0xZWGx4VC8yc3NTQStIMHp5a2k2aHgwL2c4YXN5ejI2Q2d2NWpj?=
 =?utf-8?B?SElQTlRLQXVnUXpwekpQRUR3cVhWdVMxby81bEZXQXI0eVdLeTJ6TUhuTndm?=
 =?utf-8?B?U0MxMUlYb05BRlZMU21kNTl5WmduQkZaNkR6MnRUbzNrZHhEVklHQkYwUEUv?=
 =?utf-8?B?OTcxbGxXelV3OGM3NDNJTXE0bG04YkMzS2VMUXZwMEZQR3RXYzltLy9telI1?=
 =?utf-8?B?QUNhc2Z0VTJDdk15UFBLNmUwaGNtQjJxYnh3empXUnptQ0o2MUcvSmdSbVRn?=
 =?utf-8?B?cjI2bXVqeG5ZUmk1bDg0N0NyVHVlNzZxZnlVZGRUeERXWnI1bisxKzRreFB3?=
 =?utf-8?B?Q2lmNjIwN0JlbTN6amV6NEUvU1htaElNQkgyZHFvckpnbkp2VnozNHVuaDdj?=
 =?utf-8?B?ODBVQWxpVVpHL1FVbmJRb2daVjBDc2RtTm5PcTFqejhtajRuN1RDMnN0UXNP?=
 =?utf-8?B?bStzZ1RQUUJrS2lydmhuMkhhdytEWHY4blZCNUpFOEJ2dXdMQ3NSc2R2QTBB?=
 =?utf-8?B?MzBJK0hwak01VTMzTmM3RkE1RExUYkp2cjRSM085VHErTnQreENhamZrcERS?=
 =?utf-8?B?aG5OTjkvOG1GaG1DRExmb1htWmVWbVhCRlJWYk1iYkNFa1pJUFFVemgxMzly?=
 =?utf-8?B?d3c4WlBCV29nZHZaellrZXJRUVFoVkMyVFlEbUlSajlJZFg4QlBGaWR6T09i?=
 =?utf-8?B?MG5ZeUZWU2xISHNOUGhNVjJPanJOc0V2WU1FbGp5SWN6NjlBMWNQaytvb0l4?=
 =?utf-8?B?SExGNUc2NktCRk42NjRiWDBnbGE0OGJZUnplNEN5U1U4amh1K3VSblNwaEU5?=
 =?utf-8?B?K3hqVG5OQVZXVmVpQi9EeFkwSURvckxRWTI5R3JMaEJNMXRnTHhmMnRZNVRK?=
 =?utf-8?B?dDhQeDM3MmVObkQydDM2MUNJaktMODVYclU3RHZiTHpxaXdMYzhNTjhORlpN?=
 =?utf-8?B?RVZMaUh6RnJscE5WZHdQR04rdWRGZDFXZlJrY2lJcXVkYlhubEJQaFR3UU5B?=
 =?utf-8?B?Y1E1Uk1nb0x5RFlTc21ZWWVHRFZjWENtdmZDWWgwSzFoZ1pwUkNPcFpGdTRW?=
 =?utf-8?B?RUhIOTFSdWUrbG5vWUNKSmFaMTB0S3ZNTmZvVUlSUGt3VExOcEVTenE2c1Fy?=
 =?utf-8?B?T2Z6czVJY0o3cjhLWDVqYUVOK0tUb2NVb3ZKQ0Q2Sm5iUmxqb0RFbUdiQnF3?=
 =?utf-8?B?VjJLNmF5eW01T3R0cVBFbmJNRjNPekMrMnRKRUZUb25UTkZxU2RidVhOa21L?=
 =?utf-8?B?UkpERVpGeTdUeFhydU91MmozTGxzdy9McHp2Q2xJOUwvczhMaW9OeUhyU1VP?=
 =?utf-8?B?TGQ1Q0x5dzZaUlUyamFldFdtUWNSN3hkbWZOeGt6blRKRWNub0JTT3kvVmc1?=
 =?utf-8?B?YTBSNFlvc0xRUjJScTM1Z2tDbE5GUy91TVJ1VUhQbkorb3I5c3AxbnRkZkh3?=
 =?utf-8?B?akNiUzJwYzB6WFJJbFRFUWJqUlp2eHhLeFRDWG9lbkcxY3FKcy9MZ29LN1E2?=
 =?utf-8?B?ZG12cUl4b2hxUWQ2bk5nNjk0Nk5tdHVYQ2ErQ2pWT21GZkNZeWNadURhZEYz?=
 =?utf-8?B?c0dPMU5samJlSFJ6WGFjbFptT2VtWk5zSXlpdnI1Mk9pdFF2aHdQWTdiNTVk?=
 =?utf-8?B?VW5YYUxuUkdvaHJVRFdBSHgwZHhBM3FMYkc0RWJZTmNUVnNFRndhYUxlZTBC?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84C80555C673954A80AE07D1C064F65B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99d63b0-5a80-439e-76fb-08dca216f447
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 02:04:25.0731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5R1xohY9VQfXmJZSRNPU1U68lM70V8jMh6hhSaK5cALb0CMxpjgQlJPy+IArTjF/1VpXot5u3DsX+NdRDODCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5266
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA3LTExIGF0IDEwOjI0ICswMDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
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
bmQgQU1EIENQVXMsIHdlIGhhdmUgdG8gcmVwbGFjZSB0aGVzZSBtYWNyb3MgY29uZGl0aW9uYWxs
eQo+IG9ubHkgZm9yCj4gQU1EIENQVXMuCj4gCj4gT24gYSAxMiBDQ0QgMSBQYWNrYWdlIEFNRCBa
ZW40IEdlbm9hIG1hY2hpbmU6Cj4gCj4gQmVmb3JlOgo+ICQgY2F0IC9zeXMvZGV2aWNlcy9wb3dl
ci9jcHVtYXNrCj4gMCw4LDE2LDI0LDMyLDQwLDQ4LDU2LDY0LDcyLDgwLDg4Lgo+IAo+IFRoZSBl
eHBlY3RlZCBjcHVtYXNrIGhlcmUgaXMgc3VwcG9zZWQgdG8gYmUganVzdCAiMCIsIGFzIGl0IGlz
IGEKPiBwYWNrYWdlCj4gc2NvcGUgZXZlbnQsIG9ubHkgb25lIENQVSB3aWxsIGJlIGNvbGxlY3Rp
bmcgdGhlIGV2ZW50IGZvciBhbGwgdGhlCj4gQ1BVcyBpbgo+IHRoZSBwYWNrYWdlLgo+IAo+IEFm
dGVyOgo+ICQgY2F0IC9zeXMvZGV2aWNlcy9wb3dlci9jcHVtYXNrCj4gMAo+IAo+IFNpZ25lZC1v
ZmYtYnk6IERoYW5hbmpheSBVZ3dla2FyIDxEaGFuYW5qYXkuVWd3ZWthckBhbWQuY29tPgo+IEZp
eGVzOiA2M2VkYmFhNDhhNTcgKCJ4ODYvY3B1L3RvcG9sb2d5OiBBZGQgc3VwcG9ydCBmb3IgdGhl
IEFNRAo+IDB4ODAwMDAwMjYgbGVhZiIpCgpZb3Ugc3RpbGwgbWlzc2VkIG15IFJldmlld2VkLWJ5
IHRhZyBmb3IgdGhpcyBvbmUuIDopCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9lMWY3MGEw
OWY4NWRiZDBlZTNmMzJkZmZlYTM3OTkzZTE0MTI2OWQwLmNhbWVsQGludGVsLmNvbS8KCnRoYW5r
cywKcnVpCgo+IC0tLQo+IENoYW5nZXMgaW4gdjQ6Cj4gKiBJbnZlcnQgdGhlIHBrZyBzY29wZSBj
aGVjayBpbiBpbml0X3JhcGxfcG11cygpIChQZXRlcikKPiAqIEFkZCBjb21tZW50cyB0byBleHBs
YWluIHRoZSBwa2cgc2NvcGUgY2hlY2sgKFBldGVyKQo+IAo+IFBTOiBTY29wZSBjaGVjayBsb2dp
YyBpcyBzdGlsbCBrZXB0IHRoZSBzYW1lIChpLmUuLCBhbGwgSW50ZWwgc3lzdGVtcwo+IGJlaW5n
IAo+IGNvbnNpZGVyZWQgYXMgZGllIHNjb3BlKSwgUnVpIHdpbGwgYmUgbW9kaWZ5aW5nIGl0IHRv
IGxpbWl0IHRoZSBkaWUtCj4gc2NvcGUgCj4gb25seSB0byBDYXNjYWRlbGFrZS1BUCBpbiBhIGZ1
dHVyZSBwYXRjaCBvbiB0b3Agb2YgdGhpcyBwYXRjaHNldC4KPiAtLS0KPiDCoGFyY2gveDg2L2V2
ZW50cy9yYXBsLmMgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+IAo+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMvcmFwbC5jIGIvYXJjaC94ODYvZXZlbnRzL3Jh
cGwuYwo+IGluZGV4IDBjNWU3YTdjNDNhYy4uZGY3MWYzOGFkOThkIDEwMDY0NAo+IC0tLSBhL2Fy
Y2gveDg2L2V2ZW50cy9yYXBsLmMKPiArKysgYi9hcmNoL3g4Ni9ldmVudHMvcmFwbC5jCj4gQEAg
LTEwMyw2ICsxMDMsMTMgQEAgc3RhdGljIHN0cnVjdCBwZXJmX3BtdV9ldmVudHNfYXR0cgo+IGV2
ZW50X2F0dHJfIyN2ID0ge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoFwKPiDCoMKgwqDCoMKgwqDCoMKgLmV2ZW50X3N0csKgwqDCoMKg
wqDCoD0KPiBzdHIswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwK
PiDCoH07Cj4gwqAKPiArLyoKPiArICogUkFQTCBQTVUgc2NvcGUgZm9yIEFNRCBpcyBwYWNrYWdl
IHdoZXJlYXMgZm9yIEludGVsIGl0IGlzIGRpZS4KPiArICovCj4gKyNkZWZpbmUgcmFwbF9wbXVf
aXNfcGtnX3Njb3BlKCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+ICvCoMKgwqDCoMKgwqDCoChib290X2NwdV9kYXRhLng4
Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9BTUQgfHzCoMKgXAo+ICvCoMKgwqDCoMKgwqDCoCBib290
X2NwdV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9IWUdPTikKPiArCj4gwqBzdHJ1Y3Qg
cmFwbF9wbXUgewo+IMKgwqDCoMKgwqDCoMKgwqByYXdfc3BpbmxvY2tfdMKgwqDCoMKgwqDCoMKg
wqDCoMKgbG9jazsKPiDCoMKgwqDCoMKgwqDCoMKgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgbl9hY3RpdmU7Cj4gQEAgLTE0MCw5ICsxNDcsMjUgQEAgc3RhdGlj
IHVuc2lnbmVkIGludCByYXBsX2NudHJfbWFzazsKPiDCoHN0YXRpYyB1NjQgcmFwbF90aW1lcl9t
czsKPiDCoHN0YXRpYyBzdHJ1Y3QgcGVyZl9tc3IgKnJhcGxfbXNyczsKPiDCoAo+ICsvKgo+ICsg
KiBIZWxwZXIgZnVuY3Rpb25zIHRvIGdldCB0aGUgY29ycmVjdCB0b3BvbG9neSBtYWNyb3MgYWNj
b3JkaW5nIHRvCj4gdGhlCj4gKyAqIFJBUEwgUE1VIHNjb3BlLgo+ICsgKi8KPiArc3RhdGljIGlu
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
bm9uCj4gQEAgLTU0Myw2ICs1NjYsNyBAQCBzdGF0aWMgc3RydWN0IHBlcmZfbXNyIGFtZF9yYXBs
X21zcnNbXSA9IHsKPiDCoAo+IMKgc3RhdGljIGludCByYXBsX2NwdV9vZmZsaW5lKHVuc2lnbmVk
IGludCBjcHUpCj4gwqB7Cj4gK8KgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IGNwdW1hc2sgKnJh
cGxfcG11X2NwdW1hc2sgPQo+IGdldF9yYXBsX3BtdV9jcHVtYXNrKGNwdSk7Cj4gwqDCoMKgwqDC
oMKgwqDCoHN0cnVjdCByYXBsX3BtdSAqcG11ID0gY3B1X3RvX3JhcGxfcG11KGNwdSk7Cj4gwqDC
oMKgwqDCoMKgwqDCoGludCB0YXJnZXQ7Cj4gwqAKPiBAQCAtNTUyLDcgKzU3Niw3IEBAIHN0YXRp
YyBpbnQgcmFwbF9jcHVfb2ZmbGluZSh1bnNpZ25lZCBpbnQgY3B1KQo+IMKgCj4gwqDCoMKgwqDC
oMKgwqDCoHBtdS0+Y3B1ID0gLTE7Cj4gwqDCoMKgwqDCoMKgwqDCoC8qIEZpbmQgYSBuZXcgY3B1
IHRvIGNvbGxlY3QgcmFwbCBldmVudHMgKi8KPiAtwqDCoMKgwqDCoMKgwqB0YXJnZXQgPSBjcHVt
YXNrX2FueV9idXQodG9wb2xvZ3lfZGllX2NwdW1hc2soY3B1KSwgY3B1KTsKPiArwqDCoMKgwqDC
oMKgwqB0YXJnZXQgPSBjcHVtYXNrX2FueV9idXQocmFwbF9wbXVfY3B1bWFzaywgY3B1KTsKPiDC
oAo+IMKgwqDCoMKgwqDCoMKgwqAvKiBNaWdyYXRlIHJhcGwgZXZlbnRzIHRvIHRoZSBuZXcgdGFy
Z2V0ICovCj4gwqDCoMKgwqDCoMKgwqDCoGlmICh0YXJnZXQgPCBucl9jcHVfaWRzKSB7Cj4gQEAg
LTU2NSw2ICs1ODksOCBAQCBzdGF0aWMgaW50IHJhcGxfY3B1X29mZmxpbmUodW5zaWduZWQgaW50
IGNwdSkKPiDCoAo+IMKgc3RhdGljIGludCByYXBsX2NwdV9vbmxpbmUodW5zaWduZWQgaW50IGNw
dSkKPiDCoHsKPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgcmFwbF9wbXVfaWR4ID0gZ2V0
X3JhcGxfcG11X2lkeChjcHUpOwo+ICvCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBjcHVtYXNr
ICpyYXBsX3BtdV9jcHVtYXNrID0KPiBnZXRfcmFwbF9wbXVfY3B1bWFzayhjcHUpOwo+IMKgwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgcmFwbF9wbXUgKnBtdSA9IGNwdV90b19yYXBsX3BtdShjcHUpOwo+
IMKgwqDCoMKgwqDCoMKgwqBpbnQgdGFyZ2V0Owo+IMKgCj4gQEAgLTU3OSwxNCArNjA1LDE0IEBA
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
wqAKPiBAQCAtNjc1LDcgKzcwMSwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9n
cm91cAo+ICpyYXBsX2F0dHJfdXBkYXRlW10gPSB7Cj4gwqAKPiDCoHN0YXRpYyBpbnQgX19pbml0
IGluaXRfcmFwbF9wbXVzKHZvaWQpCj4gwqB7Cj4gLcKgwqDCoMKgwqDCoMKgaW50IG5yX3JhcGxf
cG11ID0gdG9wb2xvZ3lfbWF4X3BhY2thZ2VzKCkgKgo+IHRvcG9sb2d5X21heF9kaWVzX3Blcl9w
YWNrYWdlKCk7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IG5yX3JhcGxfcG11ID0gdG9wb2xvZ3lfbWF4
X3BhY2thZ2VzKCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlmICghcmFwbF9wbXVfaXNfcGtnX3Nj
b3BlKCkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5yX3JhcGxfcG11ICo9IHRv
cG9sb2d5X21heF9kaWVzX3Blcl9wYWNrYWdlKCk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcmFw
bF9wbXVzID0ga3phbGxvYyhzdHJ1Y3Rfc2l6ZShyYXBsX3BtdXMsIHBtdXMsCj4gbnJfcmFwbF9w
bXUpLCBHRlBfS0VSTkVMKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFyYXBsX3BtdXMpCgo=

