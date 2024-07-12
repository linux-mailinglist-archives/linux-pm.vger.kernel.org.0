Return-Path: <linux-pm+bounces-11016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A097092F445
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 05:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3681C22D36
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 03:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47BCC8C0;
	Fri, 12 Jul 2024 03:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEzAqgOX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81C1944D;
	Fri, 12 Jul 2024 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720753640; cv=fail; b=dEnITwMcx3Cu9GVnb+Eyvkzpp5AS5+ar6Jrvwouwm3hDP3T7P4r2OplCaALzPAlLzKAvqelEwC2XEoecjkYr1iktMAlgcfMdlTqgVa+u/YFcR8qB/jATiO0bAQPehGts2AqIeE1Wc2QGhIRbHuJnbOZmEEPF49U2YywyIA6lkIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720753640; c=relaxed/simple;
	bh=88DHclXA1ulDGcCMwqJecpELh2oCqngPE2RzBRJbYKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UIvwgGVu3DZOtsEq8tHhHaaz18ccMW0BAycJFQKVjw4PI6O++v8ysaoL5X9KMZLPiKlbEoaGYfGJz2hp8jAMPQCG7e4dznXVQoR2mobaSmq+kq0vCXWgyo0Xs2eUinD4BY6JNmxy5VTxg2cBkn73D6gCfM041ZKzO8AelW3zJf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEzAqgOX; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720753639; x=1752289639;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=88DHclXA1ulDGcCMwqJecpELh2oCqngPE2RzBRJbYKI=;
  b=DEzAqgOXt16LyvpxJy/1F3urmunqPSTkWDn5w3Onl1JaLTVj1xjzdnvG
   XSnES6SPcJ5O4e1zFPNoE1MyECy7VViNPCh1ntKZuov+cwHBsEaDy8NJS
   Tk8oAW2FWZyWrFJdstwfLWtwLkmAbRZyN2e9kNh4TN1yPKP0dOPdcCYdg
   zfFjijJpJFV0Y66fJ7Fq8Atu7yc3sGO6OX1ySkN/5OtFeokeO1ep/Zng9
   nIQjn8r2wJIt7ETnYJH/pSN/PRWMBC47SWOL9Vr3l/pskABgMUboMOIFS
   Ph9nEZd9MEKtUuh0AFUnaNXYn/aKPFohy73Bse/NXLV2HDeWheYkV/k+a
   w==;
X-CSE-ConnectionGUID: dX8he630TfWPdzQFj7IZww==
X-CSE-MsgGUID: rvIYwBeYTF6mSZwpq+D9xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28771083"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="28771083"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 20:07:18 -0700
X-CSE-ConnectionGUID: x/CcpHzrS6eCLMk2Fpd2PA==
X-CSE-MsgGUID: wRUzogMySJuvlgDANh0qsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48788469"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 20:07:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 20:07:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 20:07:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 20:07:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSV0+mkd+pXP/Jq6qzMLdJ2/+kDfl0jWW0d8caSRKc80fIrD7xRbQ8w8EmjIC5zMpd+QbhBvLxiqBbZP7sFUufS/5wsHCepWzFh1Qvl8cAEPxzTe4hi4Ly1nj8Wzjkrpk5qnzJ93QwFqFPy6jQPfHS2sLWG2MoJB2u36uyzpm774Sfm2XpbshkMlV8w/t/e280dlLsIhEw6BNPez1z7/zvOwz3NpBxAxN743z75lCZogV744VKv0gkQlsM/Sa9sytsEG9Xf5TUjNZQRObwzcrQGbE+Op/xvo+pjk+mDmVQ6mLm++eepI6sW2cCRHJvQKAvaFjFSWnlxnIFHCdXSorA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88DHclXA1ulDGcCMwqJecpELh2oCqngPE2RzBRJbYKI=;
 b=lQNyHzE4b3IEmoOVQrBD+e/h2gf3nwJNbP0GppbLiXWu648GlW0Nn+qF5/j2f4nl2/ZU4HVPwt/ddK+9kmemosLyxPtQJ2JfaZoOmuiZtmZcLw9HE12iwUkUHpz9pSM++BxGvaRnmqVq7j9xBLxQJzJ+YkbKg3avzMMXuLPm4f5TJvY5JMx3fjrMiNK6A2m0LmECW5K8C1kRQZF6tTcMxNLm9mpo2vTIwQ4W1Q+Kb0q9R0UfwVE51aVpElIpGwpechUZ1weKxAVXO2+2h/gDHhGyqgKnMx1N2R1PA0BCS3VT/DsvbsIswtVVKP2A+91P85hC5eK0rcaDXVM/3MBn3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB6370.namprd11.prod.outlook.com (2603:10b6:208:3ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 03:07:07 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 03:07:05 +0000
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
Subject: Re: [PATCH v4 05/11] perf/x86/rapl: Move cpumask variable to
 rapl_pmus struct
Thread-Topic: [PATCH v4 05/11] perf/x86/rapl: Move cpumask variable to
 rapl_pmus struct
Thread-Index: AQHa030xiJDjuMzU2EWNgKhHja9YJbHyah4A
Date: Fri, 12 Jul 2024 03:07:05 +0000
Message-ID: <3cd5daf2424205564be29d9d23644b693eb9f355.camel@intel.com>
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
	 <20240711102436.4432-6-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240711102436.4432-6-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB6370:EE_
x-ms-office365-filtering-correlation-id: 17285ead-7241-4d54-eeca-08dca21fb589
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?VHBicFFodnBjM1VZUHUzNjVnL1VrWjJ2dkdFc0ZRZEdrVFdlMUxIWlpvNy9O?=
 =?utf-8?B?NEY4SXBUQTB2cmtHb1Y5UHNVRUgrRkZvMlkrTlY5MnUrMHYzVTg0ZkJ1MWNK?=
 =?utf-8?B?UXlEZ1N1Y05hd21ha1h4MU80NnFxU0xnRUlMUU5Wa3J6VDkzb28rV0pIT0hk?=
 =?utf-8?B?Nk9XSkt4MnVDRHhJdm9JNVVsMUdGekk0amc0d2dYTzBQWnVSL0hoaTB0OEQw?=
 =?utf-8?B?SHpQajhQYXBSbHVySVB3NmpxdkxvTnZEN01SYmJsQ2htRDJLZGpkMHlSVDlR?=
 =?utf-8?B?WThZb0c4TExPTXdtWC9RZHk5NklNWCs1UGRtMHNjZnJOMFZ6KzF6QklOcG14?=
 =?utf-8?B?aTVNb0Zpci85NFIvNjZkU3NXTXArVE50Q2x1ZkV2OFM4Q2cxWFRWWnVkdW1h?=
 =?utf-8?B?U2RSaWVZUzRHVkdkcDh6YlBFajlta0wzNkM5MjYvcGdEYjFKY1VFNEtYd05B?=
 =?utf-8?B?Ky9lZG1MdXVJODcwYU5KdG55M2IrZjQrLzNKa3c0NlcyNGgzRFVhdXFJalV5?=
 =?utf-8?B?R1drL1JSWXZWaXFVdVhoeTNEdjVhUUVVTjJJWUNkWERxenl2L04xZWg1SGtu?=
 =?utf-8?B?ZDY5dTBuSWQyRnBIZWF5UjNGdHlpWk1rTjJETFJreVV4YTRZSTFUREgzWTds?=
 =?utf-8?B?Ny9hYlN2STAzaGpySzRWVHVYSnJFQVJ5SmlSd0tRS3dOSlpmNC9EOEVPWmZt?=
 =?utf-8?B?SzFBUElrOU4veXhaWFJJcEp1QS90aGdGcmRpajBFZS8rdzRJZ3Q4eXhVMFdO?=
 =?utf-8?B?Y2hRQVJaOHlLdCtzdjZqSWVMb0FsbmpqeHBiVDNNdkhqalJha0VlK3Y5dFE1?=
 =?utf-8?B?aUh5M1Bxbkhud01ONHdpYk9Dc0M2V25RaEJxMEVydU8rNnVVbTF5MnJzTmVy?=
 =?utf-8?B?YklDYnBXcUdWUXR4Zzk3V1pqcUdncFZYZU04aXMzSDBGc0IrVHh4U013Nys4?=
 =?utf-8?B?VjdJQmVFeHhzWTVkNVZXZ1BKYng0VU13c2d3TU9uMk1GYjBpVk9rMGt6dmNk?=
 =?utf-8?B?UkpNYi9ybGw3Q3RIQi9PVSt2Rzh3R2pRNkFvdDA0SXNac0JENXQ1WmxCQzFl?=
 =?utf-8?B?Ukp0d1llOGlOSkIyQnovKzF5aVVkbkFtVlk5clk5OG9FbmxlR1hQaTFjVnd2?=
 =?utf-8?B?ckViL2dOVUY3TjJ2c1I1ZDRhQyt2TlRpY3N3K2cxcnVjREpqRUFXVk5ZYVpQ?=
 =?utf-8?B?QU5RZWp2dTZhV0lxa0xjUWhmKzdxTkFhWUU2dkVVUCtnd1o5T1pzMVBhTENj?=
 =?utf-8?B?MThWbmtwL1FLWlRlaFIzV0tBWERaN0t1dFBxaS9QSTJGOWhyR2xyUDQzZ1VT?=
 =?utf-8?B?a0IzQWtjYlgvdjhnTVNrdDhIUVRaL3NiYjBuY0w0YWoxQTNsN2R6Mzdaa2Ni?=
 =?utf-8?B?ZmozTFJTQjJnS1ltTVRYUUJjdzZjN1V3ZXRWT1dQVlh6QTZJUENnTzBidU5Y?=
 =?utf-8?B?di9zVnJ5ejFlYVl6d2xYWnJrTW0rZlp6RXJ4NldPWldnSjNObkN2cDJrV1ha?=
 =?utf-8?B?bGdrMFlCazIvTVRSWmRjU1p1Qndtdm4zN1E1Z1VMZlcreFM2dDZtVGVaNTdu?=
 =?utf-8?B?NXhyaWhHQnViclpTV0RvN3VKL1Y0eko5MWFCUGFsOEcxKzZ2YVFpTk1JZUlY?=
 =?utf-8?B?MEw0RURxVXdSWHNwQWhhdjVMOFh6TTJsNmxLUkxOQy9VUHlrdW5rejJ6RVFh?=
 =?utf-8?B?VUU2a0QwVU5EUXpVUkZ5VFhEMDQwOE9KUXVPZllpVlVHVG5TS0MvdzFWeERO?=
 =?utf-8?B?WXlQeVlHTVpxdnE4VERETHBoay81VEhlbEQwdGdLUWVCZHNtbHNVWHBxdVkv?=
 =?utf-8?B?a09TRmtUeXFIa3RJalNLcGJoNlFsQnc4Mzd6T2ZzODM2b1ZlMWxkcVV1ZHUv?=
 =?utf-8?B?QUFEcGxLTEpENjVMclg4WjkxTFVXZWdQdWtMQ2t0aFJzNDFnbG1uSnl4ZTh4?=
 =?utf-8?Q?lVYHnMqGodc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ynp3ZTVSZk02L1Ztc0RIRHYySVhieHFBelF2N2hnNU1DVU9RbnFka3ZqbERG?=
 =?utf-8?B?WGNRSWdOVHpnL2RaZjR1T3BuU2hNTHVIZ2JaV1pVTkpNb05IRDJOcUoweE01?=
 =?utf-8?B?MVNFUkZFc3BIZVUyTEgvdm5RNW94UDNkVXphd1JwMXd5aFRFb1ZMSXJnSzY1?=
 =?utf-8?B?WVR0eFo2VzVmZWg5WkZsbnJZZU1WQXFaZFFZOU10UzB5ajNJcTk5cUFJZU5O?=
 =?utf-8?B?ZlMvaWgyVHNTNXhPTGNJRE5vTUt1UXcwbTltZ085VTNjMDRRZHRYZXJLM3pi?=
 =?utf-8?B?UXVtc3VGWlVOdzl6ZTBPVXZOM3kveElFL1NUdGd0TGZmL0JmL2kzbjY4T3dm?=
 =?utf-8?B?WkpuYlE1YWtPWmRBZHZqamlneFdCU1dzdUxaVjFLcGxsOHcwVWtaS2xVYmRG?=
 =?utf-8?B?RzFuaW4wL2ZGZDVJamdrem5nZ2JYYzN2Z2RmSmc2WmZLYVNkZzJRaGxNYmVP?=
 =?utf-8?B?d1BIeThWVVB5UGlpODNmZFgrUlUxdHB3L0hVWWQybUZRWHVUUmlMYzU4UTBh?=
 =?utf-8?B?RUxOSWNzSHJjWTZXMEpCRnhvYlBmQXQ3K1hCWnJmdVNCYWR4U3FEL05ab3ox?=
 =?utf-8?B?b2htRlVmL21UWVRvWS9RNEpYSkFVeVJMY1dnQkhJTkNicWdVTnhObHpzeW5G?=
 =?utf-8?B?YzY4ZGRKdDVETldIcmxOQmRZZ254cC9XeU1VeFJHcVBac3NONmZDTFhCb3ZZ?=
 =?utf-8?B?WHhvMzl0R1dXUzB0UDJxSndheURFY0NWOVB6T1JEb29YU3lqRjQ2dnF6TjQ2?=
 =?utf-8?B?dEJnbCt4OFg0clZYYzBsY0hWeExML1JSVXM1bCtReG1sQURwZE5WYmR6SXR0?=
 =?utf-8?B?ZkRtY0JYU3ZGQjc1ZXVCS0E2aC9heHdjaVhIbWg0RlpiTFZYSU5kdXFsMXNm?=
 =?utf-8?B?NGUvcHQ1OVVHWDJ4LzVwazFxWHdualBiL3ZsNDVkOFMxUHFaa21VdUR6T2ZD?=
 =?utf-8?B?UFpvWTRES3g0VTUzN3pIR0VRQSszKzQvUVcxNGZvRnA5M2wzOGNiSFBqTmRU?=
 =?utf-8?B?U2lTNnF2L1dJcTJoYTEwcHhSRWFncGJsdG00b2owMWZySzJoeUlQWGd3SXha?=
 =?utf-8?B?b0w2dVhrdnFNazBlVWZ5ZW5vQ2Jua1I2Sm1KVFpKdDZrYjV1YzlxUVZQbkxQ?=
 =?utf-8?B?WStlVkRzR0RCVXJiNHlNUkwyMnpQaER4YXdlYWtIZ3FqQzdnUndzWW5KWjlx?=
 =?utf-8?B?NmowOE5UV0sxR29lZ0RTODZSTHFLcUNzTGsrUEZ3MVZ1RFpub3VtNmp5SnZi?=
 =?utf-8?B?cWQ4WWRPRndQZ05LekdZN0NkbCtaRmgzSEtaQngvSEcrUm0vS2dVY2xJSzc0?=
 =?utf-8?B?Ni91V3M5SHFyNEloODR4NGw2eThnWkJxNi9CUS9uK0EyRCszbjNHZFltZTA3?=
 =?utf-8?B?N1pCZXIyMVFDM2t5UnI5SlR5RkwxWTlJbUVOaXQyTllQaUZWblJsbmdxQmQz?=
 =?utf-8?B?MVVpczZzVUhlUDZMWnBDcm9ZV1F2VHdLZ2RVVDBCdEZJa2s4QVRwZ0VtSW14?=
 =?utf-8?B?WFhqcVpHTE5LSmlXS3pZamxQOTFQT0YrcWN4MlJWVm01Y05XTzh0eEFUOEtO?=
 =?utf-8?B?MU5DYlR5V0g4TldrV3VuTGpGa3Jrc25XamlDdE5wQW95NjJaN1VrajJ1YStY?=
 =?utf-8?B?S3VONXpDZktkZGp3dVRDS2M2RTUzOTFDMSs1RlNRU2QxeFB2TTczeWJETWpx?=
 =?utf-8?B?YnlKcjhYZ0FEVXpXUEdlWUg0VVNkRWVJeUp1L1F5b2daTE5LeStOSDNtMFU2?=
 =?utf-8?B?RUJ5ajk1UTcyWkhjYWtHNFZxUEZ3a2MxdS93ZWxjLzNuTGgvZ3h1WkN2Q29H?=
 =?utf-8?B?TEdrMFhUWC9uUkRFa0gyeVdtR2N0VHZpUm5aaVZHSDY4UE9CbGwxbjJwVE9G?=
 =?utf-8?B?WXdmMHMvSlJEM1I5R3ZWLzNlRkRBTzd4YnF5ZzlBOUlyWTZSMmJ2VkYxS2w3?=
 =?utf-8?B?aUNDdFA3VE9QTktPcFdENHBIK3R5N2R4dEs2cWVtd2tZK3k1UEUvYnlIeklF?=
 =?utf-8?B?WWs0d2JqT1grdjBXQlprdkkrcXNQV1VaQmdBYU11YVBJWStBbGFDd0hGSDhq?=
 =?utf-8?B?V1BXYWoxcnIybE5nMVJXU0o5a0NhRnBmRG1sUGJCamp1K1Babnd3OUpXSExT?=
 =?utf-8?B?RGRGeHdMM0w1aGowNGV1QkpPV3FUY01Uc0NORE9sTEdVL1RBd2hqK2x0em9D?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FEFF386CE39F44598BE0664E37B4D01@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17285ead-7241-4d54-eeca-08dca21fb589
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 03:07:05.2790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4bsG73e1ApSkA7atAYib471SGM2X3sebaQM8XQRfWp8Aw6a24m6aBR+AWf3VttGiLHJxbFrtCOqroKyZCHXuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6370
X-OriginatorOrg: intel.com

PiBAQCAtNzEwLDYgKzcxMCw5IEBAIHN0YXRpYyBpbnQgX19pbml0IGluaXRfcmFwbF9wbXVzKHZv
aWQpCj4gwqDCoMKgwqDCoMKgwqDCoHJhcGxfcG11cyA9IGt6YWxsb2Moc3RydWN0X3NpemUocmFw
bF9wbXVzLCByYXBsX3BtdSwKPiBucl9yYXBsX3BtdSksIEdGUF9LRVJORUwpOwo+IMKgwqDCoMKg
wqDCoMKgwqBpZiAoIXJhcGxfcG11cykKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldHVybiAtRU5PTUVNOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoIWFsbG9jX2NwdW1hc2tf
dmFyKCZyYXBsX3BtdXMtPmNwdW1hc2ssIEdGUF9LRVJORUwpKQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT01FTTsKCm1pc3NpbmcgZnJlZV9jcHVtYXNrX3Zhcigp
IGluIGNsZWFudXBfcmFwbF9wbXVzKCk/Cgp0aGFua3MsCnJ1aQoKCg==

