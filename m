Return-Path: <linux-pm+bounces-11017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AB392F453
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 05:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5F42834DE
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 03:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4136ACA6F;
	Fri, 12 Jul 2024 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/+3jWSE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA439460;
	Fri, 12 Jul 2024 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720754456; cv=fail; b=iWVU4qV/m9ddA0a6qcjCZ7FdJzhkYIwID3t5k6xDG1y5jM9Ye5GzRRTEewRWLnM6ByTDPdzq+u2l5uv5U84bvJdGJJC6TtuQYGTGj05lu9m2zRIce7ZwKVOxh03h59TvOE8nqlVoRzlIr1i4+VBWS4Yo4o5oTiGhuZghBUy+2u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720754456; c=relaxed/simple;
	bh=K6qLP1DM3as7FqR/x9L/5q0uosZF8VGSINzqosRKg/E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R6N32hQRzec76EDDDh+fsUdUbxIHLdynVG3MeFUuJDbkm2wGmMlTy/1efQvV9/Grt72TQTn/agNe1+abfs7tOdBoAUvGfZOzLDdBU2b4JqRWPnclvi77llYaLtP8YudXSCF2UJA4G16cXqMiidgrBtb7ZLr73yi6CaMowWGoe28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/+3jWSE; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720754454; x=1752290454;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K6qLP1DM3as7FqR/x9L/5q0uosZF8VGSINzqosRKg/E=;
  b=C/+3jWSEaDnJX4rIHiGgLzaFlu9daUaD290c13eshOTlV4xLwFm/qeKp
   U7MUiGKJzYquiq9LqlGRSUJfeGfocI18sfvIpTjtH2ErSYRy8x/9T9uEB
   zuU9SujC/xbdTPbmZJjbFc4C/UwoAlL+PG26O779yjENgm1vwZXKPQLpt
   A+FD0M35k6Y2Ma9xaLtQDM10idyv4ZpMRQHtIEEZwDsB3mRB9vgKGOAqk
   xE5O2nHgKvoaDT1TRR2VDavgU7JDOePFVjZxMm+CP7PnPEdF/sOde7bVi
   lVx8Fq5TAeOb64MJJ0blFSAZ4CbtSzldKDEQAobfn3lvBPQ1NCyf4zoNz
   w==;
X-CSE-ConnectionGUID: wfCF4LfDQhmDIxYXvONpJQ==
X-CSE-MsgGUID: w9Ye7i3PSZK8zlGT3cx2pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18321158"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18321158"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 20:20:53 -0700
X-CSE-ConnectionGUID: JN4uhxPgSPKkTD0FK2Gjbg==
X-CSE-MsgGUID: LbSiOcaQT6uBFq9/alyWgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="53363347"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 20:20:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 20:20:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 20:20:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 20:20:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 20:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blrjK5+g5M7pyTcSKVigatQs8cvx5dE4j+QzdVjTqnnmW0khpTmIZ4WQHb6Td0mCDTf30hVZ5rDjUffDHQekmW/rLb41NE3J/7fEolqQ7cQPBvQuPM/avQhxHM1PHfs31o2w2VocsurWOB2DKp112EG1/5PG6AsveDp6rpl3x9A0ardqk8jDnTMiVe8oZvV8p29lgFiGMlzJ8t/R8QXni4Hi0hxnZtbmoYmd2+yiO6N6CnKuBBH5d3kS2YqGQaOm1TMi5lO1zqadpnVb1lfZiyPfHXqNoDyeAaWYg92tr0NOv+kMuixLSwpweh7RtW83SC0elucdHYKduIAS5ODxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6qLP1DM3as7FqR/x9L/5q0uosZF8VGSINzqosRKg/E=;
 b=WV8kPQqbcjJbitCCe+hDSMC1tkY2w4JgaNyudy0YUg1C80WxMn+y8m+o+l4PvLQUgL5Gwy4ZQ+NiDbCyoaZ5ayGbnXUjRK4Bh3xXLfmBX3VuLvP83sZAjHak16tfLvwHaQwKi/+UAS9a3tDzSExWYOq5YVbymDR+Nv4ZXkoNdEYVzY8zHHLX3Mf/jmFMUKFow4mLIcUAdv+cscNxe1UltPtg9lWbg893d8uNKKqB5RUMpNyNQd9PDtXM0wdBr3IAzSbYFqi2Dn9kV2BaAV4DmiP9cHYoUOuh7Gg9mhLzgzhDBhbsqhNt1YDPbAgRVIkttw8ZZ0g8Z6MdyvIwdFmi5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 03:20:46 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 03:20:45 +0000
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
Subject: Re: [PATCH v4 06/11] perf/x86/rapl: Add wrapper for online/offline
 functions
Thread-Topic: [PATCH v4 06/11] perf/x86/rapl: Add wrapper for online/offline
 functions
Thread-Index: AQHa031EmS6hH2ALW02PhjkSipi+h7HybfCA
Date: Fri, 12 Jul 2024 03:20:45 +0000
Message-ID: <870180d96abffb8859fe8663115c2da86fcecc60.camel@intel.com>
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
	 <20240711102436.4432-7-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240711102436.4432-7-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH7PR11MB6497:EE_
x-ms-office365-filtering-correlation-id: 019f5526-c413-4212-c7d8-08dca2219e9e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eXVpTmpZaFpVbEptbWswUzZTT3VPSW9jZkR2bDNNZm5lNHUzcDZTRnk5ZjQr?=
 =?utf-8?B?UVJNV0c2MW9ENUs1ZmE0MDVKZmhTcXB1eDU4QzRwcUl0OHIrd08yZVRwQ2Ez?=
 =?utf-8?B?QUhjQ3AzWnFkTFdzMUhwYjFsSDBqTnRTTE51RDRWdEpEWFZyY29oK1R1a1Zo?=
 =?utf-8?B?Lys2RWdGcWQyOUxXYTlnRXNpVkU5UUtCZk9lRkZVaS9veTM5L3QzamhneC9v?=
 =?utf-8?B?cEZZN1RiZFpCdkZIaE01K2c0YmkyOGFOTHB5N0JKZ0U2UWJ3VVRrV0tyWkY1?=
 =?utf-8?B?MHRHSTIzQWxseksxREovWi9PNzY5eVlGdU9NOGVqbmhnS0NrYXdPZjhJNGQr?=
 =?utf-8?B?Mkp2ZEpodGhlcnFEL2NjL0R1dUF4ZWswYVVNaVZ6ZVM5anFJbVR1cTBmNlZO?=
 =?utf-8?B?YlBpRnNWTmFRU3FoV2cxOUVOejBMNlYxa05JbjdYOVEyRURLQjYrYmxxYTRq?=
 =?utf-8?B?WkkxT2t2cWhtTHduUmx4QzlUYW1SMlh1eWtxTFZIUHVxWUdwUlBEL090dmx4?=
 =?utf-8?B?R1l5TkZ6STNocE5rWXN0cW9CZ05nUUpmdHNUWGI4dlowSCtjUUhyNnRtK1RS?=
 =?utf-8?B?dU1tcWpSTTVCWVYrb2s1WHVZbzBkR1R2NExMZW5OVnhSM21iOVdwTDJDN0hV?=
 =?utf-8?B?c0pTbkVydnl0NFNNeXJ0WEtuQWtGcDkzeGRqcUZTaXJQcVhEMjNYOWI5MUlx?=
 =?utf-8?B?am95VE1lUWZDRHp1REdNckhWYlZIaEtaWUJQU3V2V1l2L2Q5cmVvYW5SMVhL?=
 =?utf-8?B?VXdKeXpFb1FNV1pKVG5CSVBtYTdnTVdkUUs3cXAwR1d1V2pPVkZMb1dmTGdH?=
 =?utf-8?B?S3pBMytKSkZhTDd2Ymd4ZVVaQWl1Wk1TSk9yWVd1Qm1RMUp6MmRzN2IveWVB?=
 =?utf-8?B?WlNoREsvY1pCd0JwZ0xvMzdBV2tpakU0YWJKRDBvb095OEVJOFJlaDJlMnlF?=
 =?utf-8?B?Z3liNCtuYVBHU3dKTmJpK09YM2tINktSc0VaSmZRWWNqc1BDa0V5WWc3L0Nt?=
 =?utf-8?B?eTU5YW5zbFZBUFBQVWVDaEhaSEt1dEpyeWh1enN3OXRId016TXExaWNSNjRi?=
 =?utf-8?B?b3o4UC9mK2EvQUt4RUIzY0tkQmtyMERmZExYc3U2RSs5c01ZRGRzcmJpK2Ix?=
 =?utf-8?B?Y3N0VDBCN01ZeXVKcUhzQUNXWWRRbFdRSFRqaitycllUa0x0eE1TUll1QnA4?=
 =?utf-8?B?THFrVmRmTnhDcGNmYUpjR3d1a2p0Skw3YUxkaTZkVmlCUDJLMWs0YUN5UEJi?=
 =?utf-8?B?c1JzUEtIRXB6N3dKYUxlYjlyOUlZVUVMWjVXalhiOUxDVzZ4UjVpZ1ZmWldE?=
 =?utf-8?B?V2NHdjNESUZEZm5NNy8vZGVDcHMyNHF6TkdZaG5OMFFEL2kyRUkxQkNNdERH?=
 =?utf-8?B?RmZvS05GNGl4b0d3bUZoYS9XaldGOE0zSGkzaGZTeVhDanNLQmZCejRTdGFv?=
 =?utf-8?B?bWJ2N2JpOW9sMkx4UFFDNDN1WHJtZ1JuMUttSHZWOVRCUi9nRmpRVDVIaCs3?=
 =?utf-8?B?aERMWHhReFJYanFrd2FtY2FiaDMrdFRsN1ZQdnJESzY3MHNIanRtc2tHR0pS?=
 =?utf-8?B?YlpHb2VkejNPYjY2c3lGN0F0VDc0Y0dYVk1iZjJscnlsY092ZU9Sb0hLenN5?=
 =?utf-8?B?R3l2Zk5PaUJ0MGx0NXR0MU5UTTcyOUpxZ0Y4NGNBc0ZXWGJxdms1WUR1MnhS?=
 =?utf-8?B?d20rU2RFT0xkbVZraWc3bzhYT015ME94UFB0SFNZdDV1MzZ2Rnk2Vlc4UTVY?=
 =?utf-8?B?RVFtM3kweVpCUkRuYm5VTC9Xa2hPT3I0eFVZVytyUDM2Z0xlLzVUaUdNMWpZ?=
 =?utf-8?B?d1VaKzd1Z2oycm9BdjVaZEZhNlF1WFhmSzFIeURoc1hSS3hEaE9kcFpHdGww?=
 =?utf-8?B?RkxJZ0JkOUh1MUZwT0NGSUJKWDZjOWFkRllpK21pWTRMMFZELytHU09GaUNK?=
 =?utf-8?Q?dwCpHBBOlUU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHNxWUNwUjNncVIraFFzQWtpWTVwZzE3TlVISzdTOHV2NjQzRFlmNU5pTGdP?=
 =?utf-8?B?Z3RxcksvL0k4MjVIWDFsZFdMS2xFcFZOc1RrNk9WeU04dTZUaUJDcTZFQVd5?=
 =?utf-8?B?VGEwbTJXblI2blljVDRQbURaWC9QYWlIOU9YYk1ReGZYSzdMN0xrZGYxUUFy?=
 =?utf-8?B?a2VMNWQxQjhHWUtOTXJDNzl6eC9sVzIwV09NRFcyNitZREhNY0NRa3BUcnBD?=
 =?utf-8?B?UTRCbGxkY2YxRFlSYWdxNjNzbGF5a0dKY284YkN0V3pLM0FoT2REZjV4dUpI?=
 =?utf-8?B?WUJ3aktJbWxBT01yRzlmREVxeVl0Y2h4UzgxSGdCbnozQXJXRmNmb1VDSjZV?=
 =?utf-8?B?ZjErc0xMNUgwZ2xoS0NUakM0QUl6QXFYT2ppQm9LY1pGeUQwZlk2b1BqUWxD?=
 =?utf-8?B?WkZJbTVhU3oxSEthTXRKS0s3QlJlR2toNmxxS0x4YUlpTVRZbEI4cDRGL3pT?=
 =?utf-8?B?RzQ5KzFhSFVndW9ETnQxMlBIVzEyejRBYVl1OXVvR3NxRkdISkNYZmF6dmtZ?=
 =?utf-8?B?cEtpRWFpOEJnRndaM0hlNS9UN1F3OEJMaTYwZkhrZHhMbzIwS0hLbFg3NWpr?=
 =?utf-8?B?bEtVMER4QVlWSnNDbkdSazRPWjZ3N3I4b0c5RmJDd085Vk5kN1dsckZWazVa?=
 =?utf-8?B?RTRxMlo1TWpEaWZxWDRyYjNsNitQSWlkTTdxME8wQ1kxeFV2aDQxWUl0Vkgw?=
 =?utf-8?B?T1lwL0VDQXhXNUFpZTJjTG80WmZaSnZSL1BOZmJQNGl2NmJySFlIYk1BdHJ1?=
 =?utf-8?B?SDFnRmNrcWtQQ1N3UDN1Njc1bThnbUsyV3pxSnhGb3RvaklaRks2b0JBMmxB?=
 =?utf-8?B?VFQxRHI3QlhrRzNReWs0Z0FpWU9jd0F5TnFMN3c1cTRSM3N6Mmh3R1oxMk5q?=
 =?utf-8?B?WHhmTFdUR3dFeHFrZVhtcCtRNVlQK2NRR3RFaDlrbVh2dWN2d0JybHhlWE5G?=
 =?utf-8?B?VU1rYXlFMVNocFZYZDkzMWR4KzZmQTNiM0lucEc1VzUwTnR6VG9BZk8vbGpl?=
 =?utf-8?B?cTdicVJ2d0tCN205VDFrdGRLWFhnSzFzSGd5bEhTMzNXREJpNnRnSy9CZGcr?=
 =?utf-8?B?Wm9aaEVMdTA4Z3o5SXN5WVdzYnN4VEZvUjlmWUgyYncrQnFVcmtvU1I1U2wr?=
 =?utf-8?B?ZE1oOE5sekc5VXJtbExkN1NyQ0svM1dWbjVFcHdvYjU3WDVBQ3FWT0ZQakZS?=
 =?utf-8?B?N0EzNVlKUUpmaXRrZTZjSEhaWmtDS3VkVnpiaTlqSXpGTjlXYU5Ibk5HWjc2?=
 =?utf-8?B?T1dPWG9nS3NWRnRvZEU0NWlzOFlxNmVWT0djK3RoNXV2YnRzNmUxdmJkdEkv?=
 =?utf-8?B?ck9EMUVHVkhtTUpOMDV5QUhtUkdaeDZ5UlRWN05tNG8yTUM0N1lTR21OenZv?=
 =?utf-8?B?N3h0MGo0WTZZZFlUL2tmQXNpMUlhd0Rka0hOK2s5WWdEaXN2aFZrRnp1YXQ3?=
 =?utf-8?B?R1VDeXgxOUlEa1NVaWRoRHVUbFd4d1pZdjFoUlo5SXVnQjBFaVFlWVl3Ulow?=
 =?utf-8?B?UUNkNTNYVlJFWVR0am05NnZoZWdCNkxVV0h0WnJkVGRjOFRsZjcyUE16NWdX?=
 =?utf-8?B?cGtXYXBLTitocWhiQXhqdDViQU5KR0tsS3F5RnJqKysyYUVQVUpsQTNyK3NK?=
 =?utf-8?B?d3JrWmt4US9EWVA4cGVkOXFiRm1LRFgwVXB6QVBNMkxxMnh5Kzhyd3Q3MUxF?=
 =?utf-8?B?eXNFdkNudUY2T04vUkhpRmczNUFmSnNGM1BZMWZoNEdZN2luVk9KTXNkaVVZ?=
 =?utf-8?B?dEw3UEtTMTljSjB1Mi9pLzNJTzRHWHVQKzJPRjhwc3FvZU1yd01xRFJtYWho?=
 =?utf-8?B?VWJhVGNHemE0VzlieHRPR1pKWEhjYXlqL0FwYmdFZ3I0MlBRTUN6OTBSNE9K?=
 =?utf-8?B?VUpwZ1Y3MUZaUmoybmNUc0luTE5mRGhVaHFzNnozM1pNVk1tdDJjbVB6d1N6?=
 =?utf-8?B?NkVVQkR3dGJHQzRYSHFONytUR0NLYzMwM3dwS2JUZ0JvTGoyRG80bURxRHV3?=
 =?utf-8?B?VXhjaG9BUjUzV0NUeWZsejd2blU4V1p2VHV0aTBJSjN0NXZZbDJqdjJqNW1W?=
 =?utf-8?B?WURQVDUzWWhmem1IUjE2WUZ3TjF4OS9lakIzejNQdk9iTm1NR056U0hnN2ts?=
 =?utf-8?B?ekM3dUlsUjljcjFBSE1uRmgreXRCU0ROK2lwRjlYL1RhaXlELzZoY3VpeHdC?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CE6E6319D02C4458A1004F3415751D1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019f5526-c413-4212-c7d8-08dca2219e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 03:20:45.8562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9S0LjJNACgZcvTZ4ib7114FhnEnYS0Grw+ibgpnv1u9rjDDpROKCAiWmjBmCeuItnIa4jedtOAS8zSvOXyW+0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA3LTExIGF0IDEwOjI0ICswMDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToKPiBUaGlzIGlzIGluIHByZXBhcmF0aW9uIGZvciB0aGUgYWRkaXRpb24gb2YgcGVyLWNvcmUg
UkFQTCBjb3VudGVyCj4gc3VwcG9ydAo+IGZvciBBTUQgQ1BVcy4KPiAKPiBUaGUgQ1BVIG9ubGlu
ZSBhbmQgb2ZmbGluZSBmdW5jdGlvbnMgd2lsbCBuZWVkIHRvIGhhbmRsZSB0aGUgc2V0dGluZwo+
IHVwIGFuZAo+IG1pZ3JhdGlvbiBvZiB0aGUgbmV3IHBlci1jb3JlIFBNVSBhcyB3ZWxsLiBUaGUg
d3JhcHBlciBmdW5jdGlvbnMKPiBhZGRlZAo+IGJlbG93IHdpbGwgbWFrZSBpdCBlYXNpZXIgdG8g
cGFzcyB0aGUgY29ycmVzcG9uZGluZyBhcmdzIGZvciBib3RoIHRoZQo+IFBNVXMuCj4gCj4gTm8g
ZnVuY3Rpb25hbCBjaGFuZ2UuCj4gCj4gU2lnbmVkLW9mZi1ieTogRGhhbmFuamF5IFVnd2VrYXIg
PERoYW5hbmpheS5VZ3dla2FyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWku
emhhbmdAaW50ZWwuY29tPgoKLXJ1aQoKPiAtLS0KPiDCoGFyY2gveDg2L2V2ZW50cy9yYXBsLmMg
fCAzMCArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAy
MSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9ldmVudHMvcmFwbC5jIGIvYXJjaC94ODYvZXZlbnRzL3JhcGwuYwo+IGluZGV4IGUzZDBhODJl
MTJiOS4uMWQzNjU2NWQwY2I5IDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L2V2ZW50cy9yYXBsLmMK
PiArKysgYi9hcmNoL3g4Ni9ldmVudHMvcmFwbC5jCj4gQEAgLTU2NSwxMCArNTY1LDEwIEBAIHN0
YXRpYyBzdHJ1Y3QgcGVyZl9tc3IgYW1kX3JhcGxfbXNyc1tdID0gewo+IMKgwqDCoMKgwqDCoMKg
wqBbUEVSRl9SQVBMX1BTWVNdID0geyAwLCAmcmFwbF9ldmVudHNfcHN5c19ncm91cCzCoCBOVUxM
LAo+IGZhbHNlLCAwIH0sCj4gwqB9Owo+IMKgCj4gLXN0YXRpYyBpbnQgcmFwbF9jcHVfb2ZmbGlu
ZSh1bnNpZ25lZCBpbnQgY3B1KQo+ICtzdGF0aWMgaW50IF9fcmFwbF9jcHVfb2ZmbGluZShzdHJ1
Y3QgcmFwbF9wbXVzICpyYXBsX3BtdXMsIHVuc2lnbmVkCj4gaW50IHJhcGxfcG11X2lkeCwKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y29uc3Qgc3RydWN0IGNwdW1hc2sgKmV2ZW50X2NwdW1hc2ssCj4gdW5zaWduZWQgaW50IGNwdSkK
PiDCoHsKPiAtwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3QgY3B1bWFzayAqcmFwbF9wbXVfY3B1
bWFzayA9Cj4gZ2V0X3JhcGxfcG11X2NwdW1hc2soY3B1KTsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1
Y3QgcmFwbF9wbXUgKnJhcGxfcG11ID0gY3B1X3RvX3JhcGxfcG11KGNwdSk7Cj4gK8KgwqDCoMKg
wqDCoMKgc3RydWN0IHJhcGxfcG11ICpyYXBsX3BtdSA9IHJhcGxfcG11cy0KPiA+cmFwbF9wbXVb
cmFwbF9wbXVfaWR4XTsKPiDCoMKgwqDCoMKgwqDCoMKgaW50IHRhcmdldDsKPiDCoAo+IMKgwqDC
oMKgwqDCoMKgwqAvKiBDaGVjayBpZiBleGl0aW5nIGNwdSBpcyB1c2VkIGZvciBjb2xsZWN0aW5n
IHJhcGwgZXZlbnRzICovCj4gQEAgLTU3Nyw3ICs1NzcsNyBAQCBzdGF0aWMgaW50IHJhcGxfY3B1
X29mZmxpbmUodW5zaWduZWQgaW50IGNwdSkKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqByYXBsX3Bt
dS0+Y3B1ID0gLTE7Cj4gwqDCoMKgwqDCoMKgwqDCoC8qIEZpbmQgYSBuZXcgY3B1IHRvIGNvbGxl
Y3QgcmFwbCBldmVudHMgKi8KPiAtwqDCoMKgwqDCoMKgwqB0YXJnZXQgPSBjcHVtYXNrX2FueV9i
dXQocmFwbF9wbXVfY3B1bWFzaywgY3B1KTsKPiArwqDCoMKgwqDCoMKgwqB0YXJnZXQgPSBjcHVt
YXNrX2FueV9idXQoZXZlbnRfY3B1bWFzaywgY3B1KTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAv
KiBNaWdyYXRlIHJhcGwgZXZlbnRzIHRvIHRoZSBuZXcgdGFyZ2V0ICovCj4gwqDCoMKgwqDCoMKg
wqDCoGlmICh0YXJnZXQgPCBucl9jcHVfaWRzKSB7Cj4gQEAgLTU4OCwxMSArNTg4LDE2IEBAIHN0
YXRpYyBpbnQgcmFwbF9jcHVfb2ZmbGluZSh1bnNpZ25lZCBpbnQgY3B1KQo+IMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gMDsKPiDCoH0KPiDCoAo+IC1zdGF0aWMgaW50IHJhcGxfY3B1X29ubGluZSh1
bnNpZ25lZCBpbnQgY3B1KQo+ICtzdGF0aWMgaW50IHJhcGxfY3B1X29mZmxpbmUodW5zaWduZWQg
aW50IGNwdSkKPiDCoHsKPiAtwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgcmFwbF9wbXVfaWR4
ID0gZ2V0X3JhcGxfcG11X2lkeChjcHUpOwo+IC3CoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBj
cHVtYXNrICpyYXBsX3BtdV9jcHVtYXNrID0KPiBnZXRfcmFwbF9wbXVfY3B1bWFzayhjcHUpOwo+
IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCByYXBsX3BtdSAqcmFwbF9wbXUgPSBjcHVfdG9fcmFwbF9w
bXUoY3B1KTsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gX19yYXBsX2NwdV9vZmZsaW5lKHJhcGxf
cG11cywgZ2V0X3JhcGxfcG11X2lkeChjcHUpLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdldF9yYXBsX3BtdV9jcHVt
YXNrKGNwdSksIGNwdSk7Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQgX19yYXBsX2NwdV9vbmxpbmUo
c3RydWN0IHJhcGxfcG11cyAqcmFwbF9wbXVzLCB1bnNpZ25lZAo+IGludCByYXBsX3BtdV9pZHgs
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjb25zdCBzdHJ1Y3QgY3B1bWFzayAqZXZlbnRfY3B1bWFzaywKPiB1bnNpZ25lZCBpbnQgY3B1
KQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHJhcGxfcG11ICpyYXBsX3BtdSA9IHJhcGxf
cG11cy0KPiA+cmFwbF9wbXVbcmFwbF9wbXVfaWR4XTsKPiDCoMKgwqDCoMKgwqDCoMKgaW50IHRh
cmdldDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXJhcGxfcG11KSB7Cj4gQEAgLTYxMyw3
ICs2MTgsNyBAQCBzdGF0aWMgaW50IHJhcGxfY3B1X29ubGluZSh1bnNpZ25lZCBpbnQgY3B1KQo+
IMKgwqDCoMKgwqDCoMKgwqAgKiBDaGVjayBpZiB0aGVyZSBpcyBhbiBvbmxpbmUgY3B1IGluIHRo
ZSBwYWNrYWdlIHdoaWNoCj4gY29sbGVjdHMgcmFwbAo+IMKgwqDCoMKgwqDCoMKgwqAgKiBldmVu
dHMgYWxyZWFkeS4KPiDCoMKgwqDCoMKgwqDCoMKgICovCj4gLcKgwqDCoMKgwqDCoMKgdGFyZ2V0
ID0gY3B1bWFza19hbnlfYW5kKHJhcGxfcG11cy0+Y3B1bWFzaywKPiByYXBsX3BtdV9jcHVtYXNr
KTsKPiArwqDCoMKgwqDCoMKgwqB0YXJnZXQgPSBjcHVtYXNrX2FueV9hbmQocmFwbF9wbXVzLT5j
cHVtYXNrLCBldmVudF9jcHVtYXNrKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHRhcmdldCA8IG5y
X2NwdV9pZHMpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiDC
oAo+IEBAIC02MjIsNiArNjI3LDEzIEBAIHN0YXRpYyBpbnQgcmFwbF9jcHVfb25saW5lKHVuc2ln
bmVkIGludCBjcHUpCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+IMKgfQo+IMKgCj4gK3N0
YXRpYyBpbnQgcmFwbF9jcHVfb25saW5lKHVuc2lnbmVkIGludCBjcHUpCj4gK3sKPiArwqDCoMKg
wqDCoMKgwqByZXR1cm4gX19yYXBsX2NwdV9vbmxpbmUocmFwbF9wbXVzLCBnZXRfcmFwbF9wbXVf
aWR4KGNwdSksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGdldF9yYXBsX3BtdV9jcHVtYXNrKGNwdSksIGNwdSk7Cj4gK30K
PiArCj4gKwo+IMKgc3RhdGljIGludCByYXBsX2NoZWNrX2h3X3VuaXQodm9pZCkKPiDCoHsKPiDC
oMKgwqDCoMKgwqDCoMKgdTY0IG1zcl9yYXBsX3Bvd2VyX3VuaXRfYml0czsKCg==

