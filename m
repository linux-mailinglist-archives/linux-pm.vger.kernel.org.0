Return-Path: <linux-pm+bounces-11018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4673E92F458
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 05:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C0E1F22C62
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 03:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0525DD272;
	Fri, 12 Jul 2024 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRlstQ9k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE1DDBC;
	Fri, 12 Jul 2024 03:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720754565; cv=fail; b=czkq1XveWlakcr1FH2DremPuKMOL7cjYxQypMmVpUsJxrV6hvU3xTAgVymu6AMxkO2gmnlw4N79rk06r1OhfS1cU4GDtMu2qVI+JJwcm8mubmFwTPzvcz+jY3dyIMf0OkppWR1eK8ZaTffY3vr3CIDHyN0V26kcO07t/A4b/4jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720754565; c=relaxed/simple;
	bh=9paoRHEQREzLF2O9VrZmtqzAx2FPaf9kjtDr10vTim8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZyIfbZmF4ggQuFKfHe5OmQjxwXfY+U2x5JBD0TZ60HoEjDf1XHxG5ogYOXIlBewEoxHZhDsapx4QtTHxQGkrB0kvjUILCDb/oed252fYIlpPfSqbK0Xf4O70OWa4ZBJNIcld7IdCTx0KxS/rX8oKYZzrbNjp4trubgI39FPwnGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRlstQ9k; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720754561; x=1752290561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9paoRHEQREzLF2O9VrZmtqzAx2FPaf9kjtDr10vTim8=;
  b=BRlstQ9kmtR9oNx/f5RyMu7sdTfkgA8psRg/JtGM6yw51YK6CtdyLOe4
   WZKEG/twh1eRF+DHEiko9WKS29w5Nvih2UNt3XgRZlGEyZtRI55daYJpo
   la0wfh3UjRZbXECB5cAgEl8pbe2I2ovrIMZSFSPeKVEy2YLw6Dw5VTeo6
   U8T/SS66qSy3nkHYFLJgSwpmVMV8OqORHLZ6ZClOxYPfnY9kF0Pt/03JQ
   YQPLdCkT/Y6+af0xI9Rfb8VMIiimwV+tkgjRc9HSX1K+6neVJgtn/psD4
   5xGAYD+t7uA+VlxFiRXmB0YELk8XFMk7w9TkZPnM8Jmp1tGg5BYW389qb
   A==;
X-CSE-ConnectionGUID: wVG7FUUdT9iqJu0IMjevWQ==
X-CSE-MsgGUID: Z0Cu6F7OQXG4CrIFsNwWfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18296525"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18296525"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 20:22:40 -0700
X-CSE-ConnectionGUID: TuLxw3tvRBue/HWZlI2Tkg==
X-CSE-MsgGUID: ya5mrfygTgWF3w9G50eo1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48867478"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 20:22:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 20:22:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 20:22:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 20:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGreVIs2Cftr0XVGVcKLVbBRzMtbBOR6NfdxqFmY7hO/zHFSByxsHEYGi+MPPZ524LoPSxAwouhP7/rqCR6HbV78vaFehnReehzpe9AvdIsGUgwByq+0Yb/l403Spj1iU3VzSvYCsM07x1SIeRUi/RaY3g2whxZLh8PC9nLbPdReakZySh3XhG4rCGy+qka7NZe5wG7BRyHAwR6OPuHOku2/Em65oMtlbxifYRsFDtm52W9vCc5Pc/0GrAvAeRCh+zamkEnEBctN2r531yTL7HJ2CFaoqUCrTTcZvqo+gmhjWpsNeDRuYiEOVka0OpsmBG5XTD9T5uISJqoWMObFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9paoRHEQREzLF2O9VrZmtqzAx2FPaf9kjtDr10vTim8=;
 b=sCK+k6CKU1hQ3wfwQomos6twvVwciB56MhMfm/gXQo0YS4Jstg91drU7BNtBJEDrWkBGLLGGNeEuO4x7uhezqMNEbYNgHcajlTnKjIoFVAbLarFQU5ehwPUAl6hgKn4ZeeBGJt6q5OPJG3c2bMZimh6iB+LI/crQvV+ZpmeruvV831lQeky1KDfZWeEnV3v/YHotQOnUwvuZRxdn/g/8NQxlatKTOaydbxQWkp8ic1WxIM14so3sXWNwdYxuhWwFtDqam3mgnSSeDO0EPzS1+VgjfLgMqQx7UD//lIlAYdISPZS1LkoZemmE1AHiJJX7hyP1DMVpW4zPqQyYaMxW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 03:22:30 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 03:22:30 +0000
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
Subject: Re: [PATCH v4 07/11] perf/x86/rapl: Add an argument to the cleanup
 and init functions
Thread-Topic: [PATCH v4 07/11] perf/x86/rapl: Add an argument to the cleanup
 and init functions
Thread-Index: AQHa031K4HgZGlmEqUixjMLFdT4MlrHybm0A
Date: Fri, 12 Jul 2024 03:22:30 +0000
Message-ID: <b087a806bbec50ce5752f6e09c70ed9ac4314c4c.camel@intel.com>
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
	 <20240711102436.4432-8-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240711102436.4432-8-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH7PR11MB6497:EE_
x-ms-office365-filtering-correlation-id: f796a600-e6b6-4111-d3aa-08dca221dd28
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SG1kVVVDQkNQTE1xaG1CZXNqNmFLMEVlakpQTUhuQndNREpQUW1EeHNFbDc0?=
 =?utf-8?B?bk83L0M0MkxpaktvaWJDaHQzNUIwcDJ4ckNIbDN2NGpyZkQ3eElCZjZqSTZM?=
 =?utf-8?B?RlFibng3RjhZRDA3cURWRHNzMm5ISjJGZFZHOHd2eTVmYUFaM1FFajBGd1Bh?=
 =?utf-8?B?Q3RnZVZQaEVGZEc0emtSNFNkYXhVRWx6U2JFdVRkSFdoQk11TlRDOHFRMHNT?=
 =?utf-8?B?Z0p0WnRCcHhnSGptcDduTFBGdEFiK016RWRiTmVuV3kyeFVYT0ptaytUbnF1?=
 =?utf-8?B?QzUrcVZoT2gvbTJsMmIwUE00SXpGZFRwcmd6cm1pNTVVbE9KVmZMeWdhdWMv?=
 =?utf-8?B?UVNVNFFKWGhvK0Nha21NN010QzhCY3g2eE1EaXZFV3FUQXM5ZFBDTjd4TUxh?=
 =?utf-8?B?RmJnZ1pMQ0VyNmpkV2FIcnNFODM0Mi9wcTJiREx0cTRRUTBOeDQ1TTd4TmV5?=
 =?utf-8?B?eURoRjRGaHY2bUFPTkU3Rk9XQUVxRk1nVTBWVWlObDNSdkppeW1XbnRGdEo0?=
 =?utf-8?B?RkE3M2NqVHlIWTA0cWVZT0QrQ1B4bFpQNWV2MzVUR3hhcVVOUU90OHNYWnNP?=
 =?utf-8?B?WW8vTkNiNHRtVWVlalNzUExnUnJ3ZTVHRE5OQklNK1BaY01adWhrcFFEcFhm?=
 =?utf-8?B?ZHpWaGFHLzh6UEV6RzVPYUtwUkRRT2w0dGFLQ1paRHBtMGF3S3pzckI4YUcv?=
 =?utf-8?B?VXIwZUEzVkxZQWFqWDNaK2pLQmFOMk90ZGszWk4yb3JyeWVMSWhOaTloZi96?=
 =?utf-8?B?UGppbUdVNWRZOGF2dk1OYjQ3OGlzMWxHWWpMYi9HWUY0eFdFcVAwdlA5MERn?=
 =?utf-8?B?K3A5bzJZZ3ZrWEdDOU1MK00xZGVmb1d0WHBRSlVhRnAxMHI1Vnp1YXAza0xx?=
 =?utf-8?B?U1RtMG5pMmF5MEVhNkR4QVNBQXpNaTVEQ1ZTTmEyVnIyaGlVcnZiTzNmN1dp?=
 =?utf-8?B?NXJtaHl1QUpzekx4UEJNN2pOUU1lNE42b3d6YnFmbmJ5bGFqSGtGMU1wVmh0?=
 =?utf-8?B?clVjbmQ0NHB3RzRuUjdUNHNxdDc2bUM4SVBhRDZjU0JVd0R6QWduYUwzdkto?=
 =?utf-8?B?eXUxZ1VQU0ZGTFl2OVI5QWJOUFJ1K0tZWGNYdzFXeERRNGUwV29CT0M1YTY0?=
 =?utf-8?B?K3JpY3RkSHNTaTllV0JlR01MRUhsZEJ6OElsVG1MVGZUcDB0aElHc0hxRmZl?=
 =?utf-8?B?UEhOdXdpaVFJZy9YYUhFY09sbU1oeTV1cFVNUWo2dGJFU0p1VXIzTFM3S1k5?=
 =?utf-8?B?WmdQaUpXaHBVOE4xSHMwUUtOMnVpWURGS09Ib0JNTjJtazhSNjArb1BvN1JB?=
 =?utf-8?B?WHR3L3drcnVzVnc3eEdZbzd6dGM2dEdWSUdUakhDL0crT3hUQ2FXNkZYaTd4?=
 =?utf-8?B?a3RlYkpmWTJyUERxSXV2dnduVGEvUGNkY1ZPNmdmNVlPODNvVjI1eEpENmFN?=
 =?utf-8?B?eFlLakdkWHQ3SnNWeUVXRU5tR3RQNy9QNDFqREUwVzdWa01VRjJKT29KbjFt?=
 =?utf-8?B?VkFaMEhFZFpISlNYNTZ5Z1owTkl4TlVCalBNY0dBYjVuSUJka1NDMnVNL2g4?=
 =?utf-8?B?ZTZrVnlmeGNKbTh4VUg4VUFJZlVaejlLWGpyb3I5MFVHb2xNNXFWTlQ1THlm?=
 =?utf-8?B?bHNYU0VKQTFPSEp5ZzlNa1VqaGEyR2QxYzFMTWM0MDc2TnI5eWFaTC8wU2NT?=
 =?utf-8?B?bk83cHBOYUp4NnM3aytwSWEvbGpiZnREVFJxUGxYMUVnUFNIZjlwNTNxWmps?=
 =?utf-8?B?T0I4NVl6RE1lL0Q2ajlNTGV5M25kQXlWS25FUE41R0d2OU1ZYWtZTmx1NnVK?=
 =?utf-8?B?dGZUMy8zeVJSemFjR1VlVkdyRkJ2b2FmVlNsWU15a0VyQitDREVDelR0Zngx?=
 =?utf-8?B?V0UzZHgxMnNzSFhGWGxLTHBZZGtqc29rSDB5NVZSVlJyUkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVBGaG9MaWY3MFROWkdaU3g3Skw4QXE4ckczZFQyY0dpcGdkeGRUQTZPRXlu?=
 =?utf-8?B?OXFoaEVicDM3aEd5QzdpM3N6Smk3SWJYR3l1aE44cEl2cmEvT055WUJtYWZi?=
 =?utf-8?B?Qk92VEMwM2d0VEdrOU5XUk5FVVlSNWxNcEtLUTBHcURNQnlDYnZsUEpPV1JP?=
 =?utf-8?B?Sm1lV0FVYytnOUpnUUttWjVLdi9RRFN6MjV1Y0ZEVVZtUkNtcEVvZGVEc21k?=
 =?utf-8?B?Ti9vM3RMTmlqcjFrSVpYek54NWEyTThmUTFPSXpZZUt1bDlCZmVQbW92Mldr?=
 =?utf-8?B?NVRJcHcyMCs5MG0vMmRlbC82ajk1OFloSldubVBRdW13NlNJYUFIYklsRU5R?=
 =?utf-8?B?MHA4cHZBdnE1TzZrQW9yZEc3YUQydkRrMTYxL0ROaVE2Q1BnVnZyNC9ybTM3?=
 =?utf-8?B?RTlBcytsM3VlV2NDQVViaVlDL24zRmZON2ZUNFA4RjNIb09iWXNNVHFkVVht?=
 =?utf-8?B?SWNjNC8rWm9TY3hQUGs5TnlUNVBKUktKTzZBeG50QTRlcEpMSVNnQU9BKzhu?=
 =?utf-8?B?OHVzTGYzdEdDWXNud1Bza1o5eVNBak5TUUxCcFBsSkFQQ2NGVlA0bTZFVG1q?=
 =?utf-8?B?MGdmdU1XTlhwN2djaXN1V1c0OWVxK1JQY2VCbmxRVGREODBhTERMeEpURExR?=
 =?utf-8?B?QUNaOGRYaXdvZEhjcWJEckFXRmhycm14aVo2RDErNlFNZm5ydDA3L3M1MFFu?=
 =?utf-8?B?TWIyckVuWFZpcjU3ZjZWOS9oNjl3M2lpV1N3ZC9rb29JdzVlTU0wVU0rRzVr?=
 =?utf-8?B?MnhjRVBhUStKNnBZU1pkTlJZQ1Avd1NIaTU5cGc0YTFwRzM2bW9aaURiSS9F?=
 =?utf-8?B?Q2hsOGxLRDZvbUZLUnpYWTk5c3d4dDV6WE1jcklaQVVtblY4LzA5SzdmZnFM?=
 =?utf-8?B?RGQwYnZvYkxSNjRYaXY5dE96WXpVSzRCRFFweHh2V1JjRzVmbFFlWjc2NVYz?=
 =?utf-8?B?Tm5FWllLN3dhOTNaMHB3Tzh1RkZwaURPV1R3NWRxNVR5V0lEWklMMlFMQXRB?=
 =?utf-8?B?dWdiSUtKOHdoeWFwMVdueFdzQlFZTVpnWmZNNFc3ZW5wTWs2YnBjZDVrV241?=
 =?utf-8?B?R0p0ejRpMVBWblBSSExhMEtCUWd0TUN6K1VlYUlQSm1LR2F5Sy9ja291bVht?=
 =?utf-8?B?bGFTcGRBbXFXajlQWU8xNWlBc09PYWMrL1oxMmo0c0ovRXZ0OXN0VTBEb3Jr?=
 =?utf-8?B?bUFaTmZrUm9xRWFiYWFacFlWVCtxWkxvOTBVSDV6OTJSeW9LWDMzdExLeG9s?=
 =?utf-8?B?N0xQcGhIeEZBNnhCZVY5ZHZxWmkwNmVCZzAyaFZTd0dOOVhhcER4S0t3aksr?=
 =?utf-8?B?YzBsNDZhQWxIWFFZMEJPcTdLam5UWWc2Y09tZy9pVnFaL2FJV2ZTM3lUbkNK?=
 =?utf-8?B?OFU3TjFCOUNiZURDQStCYjBpZnIxNlgxSWs3emN4ZHBEMW41T3BNUFQvWHlv?=
 =?utf-8?B?bGJsZEtralZhdEswSUdTMndjUTdQaE96bk40cytQKzBPWVZhUUxHdnVOOU1n?=
 =?utf-8?B?eWJSd291bm5RMVdZNHdQNGwzNHJUd3RiTzRjUzJFUjM3dzFpWk9NSEdtdUY3?=
 =?utf-8?B?QlVDb2srTGZIN0FBRzhla1ZNQk5Hd1RQRStTYnVWSldmZFFnV0ZSV000ZTk5?=
 =?utf-8?B?aUx4ZGpkNlJGZGVqVVg3bmE2dVkwWmNuaGNPZjBjSTZjRDF0QVl5WXMwWFN6?=
 =?utf-8?B?YllTTU04Wk9NREgwelJIc1lvWjNLYVNrUTNHRU1WK0xwUTNpTWtRWG1MNlV0?=
 =?utf-8?B?emxnaElNM2ZIajBudDZyclMxQllta25VSWc3UGxDUVpyVjQ0YWFKNkc5OVlR?=
 =?utf-8?B?N1d1WDBOdjhJRXlyWDZ1aWF6S0ZVTEd0V0JRYytQZlNJNXlWaUYvQUNrSXZX?=
 =?utf-8?B?WTFycGVLNTRiWHFWTjZJdTJyNHZuekc0NlRBZmJQZUxvVW10aldWWnNRNlNo?=
 =?utf-8?B?bWNXeC9WVTBoUWkwNU1BN0tFWkI2bXJHWk9vby9UeDBtTFNleXFnMlYwMWJs?=
 =?utf-8?B?UE94K0FQeEhlT0MvaHFYaDZONkFjbE1obCtvdnpvUHZVVmRMQzE3cUo5TWVY?=
 =?utf-8?B?a3NpZ0lrUUJxSVNSVlVacmZ6eGZoY1NSaVo5cmZiZ0V3ellMMWVHeFp1NWRz?=
 =?utf-8?B?Qjl6OUQ0VzdSVUsvVCtiSmlxWFhMbkdKUnF1QXFEQ2lWV3BmUnhadlVRK3BM?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4A04D4A194CF34CA09909CD5950C51F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f796a600-e6b6-4111-d3aa-08dca221dd28
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 03:22:30.7766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3S24Tj3eXg1aaKkCg8Rd0+HsaB32orzs/8LZKcS43qZskat8vG8Qr1elNFPNzd3KrIutofmi4SuqpO2YyZ5DTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA3LTExIGF0IDEwOjI0ICswMDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToKPiBQcmVwIGZvciBwZXItY29yZSBSQVBMIFBNVSBhZGRpdGlvbi4KPiAKPiBObyBmdW5jdGlv
bmFsIGNoYW5nZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEaGFuYW5qYXkgVWd3ZWthciA8RGhhbmFu
amF5LlVnd2VrYXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0Bp
bnRlbC5jb20+CgotcnVpCgo+IC0tLQo+IMKgYXJjaC94ODYvZXZlbnRzL3JhcGwuYyB8IDE0ICsr
KysrKysrKy0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMvcmFwbC5jIGIvYXJjaC94
ODYvZXZlbnRzL3JhcGwuYwo+IGluZGV4IDFkMzY1NjVkMGNiOS4uMzYyZTgyMjg0Y2NiIDEwMDY0
NAo+IC0tLSBhL2FyY2gveDg2L2V2ZW50cy9yYXBsLmMKPiArKysgYi9hcmNoL3g4Ni9ldmVudHMv
cmFwbC5jCj4gQEAgLTY5NCw3ICs2OTQsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgcmFwbF9hZHZl
cnRpc2Uodm9pZCkKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgfQo+IMKgCj4gLXN0YXRpYyB2b2lk
IGNsZWFudXBfcmFwbF9wbXVzKHZvaWQpCj4gK3N0YXRpYyB2b2lkIGNsZWFudXBfcmFwbF9wbXVz
KHN0cnVjdCByYXBsX3BtdXMgKnJhcGxfcG11cykKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgaW50
IGk7Cj4gwqAKPiBAQCAtNzEyLDkgKzcxMiwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJp
YnV0ZV9ncm91cAo+ICpyYXBsX2F0dHJfdXBkYXRlW10gPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoE5V
TEwsCj4gwqB9Owo+IMKgCj4gLXN0YXRpYyBpbnQgX19pbml0IGluaXRfcmFwbF9wbXVzKHZvaWQp
Cj4gK3N0YXRpYyBpbnQgX19pbml0IGluaXRfcmFwbF9wbXVzKHN0cnVjdCByYXBsX3BtdXMgKipy
YXBsX3BtdXNfcHRyKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgbnJfcmFwbF9wbXUgPSB0
b3BvbG9neV9tYXhfcGFja2FnZXMoKTsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcmFwbF9wbXVz
ICpyYXBsX3BtdXM7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFyYXBsX3BtdV9pc19wa2df
c2NvcGUoKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5yX3JhcGxfcG11ICo9
IHRvcG9sb2d5X21heF9kaWVzX3Blcl9wYWNrYWdlKCk7Cj4gQEAgLTczOCw2ICs3MzksOSBAQCBz
dGF0aWMgaW50IF9faW5pdCBpbml0X3JhcGxfcG11cyh2b2lkKQo+IMKgwqDCoMKgwqDCoMKgwqBy
YXBsX3BtdXMtPnBtdS5yZWFkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA9IHJhcGxfcG11X2V2
ZW50X3JlYWQ7Cj4gwqDCoMKgwqDCoMKgwqDCoHJhcGxfcG11cy0+cG11Lm1vZHVsZcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqA9IFRISVNfTU9EVUxFOwo+IMKgwqDCoMKgwqDCoMKgwqByYXBsX3BtdXMt
PnBtdS5jYXBhYmlsaXRpZXPCoMKgwqDCoMKgPSBQRVJGX1BNVV9DQVBfTk9fRVhDTFVERTsKPiAr
Cj4gK8KgwqDCoMKgwqDCoMKgKnJhcGxfcG11c19wdHIgPSByYXBsX3BtdXM7Cj4gKwo+IMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gMDsKPiDCoH0KPiDCoAo+IEBAIC04NzksNyArODgzLDcgQEAgc3Rh
dGljIGludCBfX2luaXQgcmFwbF9wbXVfaW5pdCh2b2lkKQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAo
cmV0KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDCoAo+
IC3CoMKgwqDCoMKgwqDCoHJldCA9IGluaXRfcmFwbF9wbXVzKCk7Cj4gK8KgwqDCoMKgwqDCoMKg
cmV0ID0gaW5pdF9yYXBsX3BtdXMoJnJhcGxfcG11cyk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChy
ZXQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+IMKgCj4g
QEAgLTkwMyw3ICs5MDcsNyBAQCBzdGF0aWMgaW50IF9faW5pdCByYXBsX3BtdV9pbml0KHZvaWQp
Cj4gwqDCoMKgwqDCoMKgwqDCoGNwdWhwX3JlbW92ZV9zdGF0ZShDUFVIUF9BUF9QRVJGX1g4Nl9S
QVBMX09OTElORSk7Cj4gwqBvdXQ6Cj4gwqDCoMKgwqDCoMKgwqDCoHByX3dhcm4oIkluaXRpYWxp
emF0aW9uIGZhaWxlZCAoJWQpLCBkaXNhYmxlZFxuIiwgcmV0KTsKPiAtwqDCoMKgwqDCoMKgwqBj
bGVhbnVwX3JhcGxfcG11cygpOwo+ICvCoMKgwqDCoMKgwqDCoGNsZWFudXBfcmFwbF9wbXVzKHJh
cGxfcG11cyk7Cj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gwqB9Cj4gwqBtb2R1bGVf
aW5pdChyYXBsX3BtdV9pbml0KTsKPiBAQCAtOTEyLDYgKzkxNiw2IEBAIHN0YXRpYyB2b2lkIF9f
ZXhpdCBpbnRlbF9yYXBsX2V4aXQodm9pZCkKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgY3B1aHBf
cmVtb3ZlX3N0YXRlX25vY2FsbHMoQ1BVSFBfQVBfUEVSRl9YODZfUkFQTF9PTkxJTkUpOwo+IMKg
wqDCoMKgwqDCoMKgwqBwZXJmX3BtdV91bnJlZ2lzdGVyKCZyYXBsX3BtdXMtPnBtdSk7Cj4gLcKg
wqDCoMKgwqDCoMKgY2xlYW51cF9yYXBsX3BtdXMoKTsKPiArwqDCoMKgwqDCoMKgwqBjbGVhbnVw
X3JhcGxfcG11cyhyYXBsX3BtdXMpOwo+IMKgfQo+IMKgbW9kdWxlX2V4aXQoaW50ZWxfcmFwbF9l
eGl0KTsKCg==

