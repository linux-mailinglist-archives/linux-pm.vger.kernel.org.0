Return-Path: <linux-pm+bounces-11299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D738D9391AB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 17:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28048B20B26
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 15:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01D516DED9;
	Mon, 22 Jul 2024 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaAogkIJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC6B1428F1;
	Mon, 22 Jul 2024 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661694; cv=fail; b=kTua8gLlGJ06hWRJ5G8fyL6/+jJFaY944j6nM9Ed3qJnbw7LHPX0lCjWM6totpGw6M3UZSOzZQnktPKn5iAPDy6jfBdh19kpdC20vh6YNPwaejz0kRbovdW0k2maBAQzOwa0c0PpJxQdpi8DNubAzT02UIl/6+RwUW040RsHDiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661694; c=relaxed/simple;
	bh=UPSrCtfES6f0T861z5GijZRh5+J6cpeqllnCtx47dcA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hKHBvuZTQIQc+U6I2FTXp92awNBpinAAAYNipetHBo0KAkQrINGz7/6kTTgJKSqO0V6AADkgRbvszgJl4+foJ2qSpPGrr4cVtaVM3bzKxqOvyYxaFKK0ThruPn1H75LDQAo0YGadQzf0yAuA3f1UOfnu3U6lBXDlcxlYfDbQBVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TaAogkIJ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721661693; x=1753197693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UPSrCtfES6f0T861z5GijZRh5+J6cpeqllnCtx47dcA=;
  b=TaAogkIJ4jPCNpQs+fc0CADxBJZlybviqecGLtoSTMh1Js+adyuDbjWr
   AwBoa6/cOtX46j2BnkxwFeEFT6azQ8H8LIAY44hFFX3bZNlnPBFNvfKYM
   B1k4+3WOt+4uYMWqAvV0TUdSIXCKL1cOycoLXtliWvTUTvSZ5Z9CuqFjm
   WVzO47a6XJ2D9FnBAqliPmbabeaHyS6Q03Po9oDWHuRZXrImLnXoP8plh
   m8lC8JkslEMos4+G85aV07nw2PmDbVb5ia12vDBbtz6aLRm/S06GW5XX2
   ZR8EkJ0/YxNVVrc51b1SF/DZOANeWUJB+R0fPxQyplMoeEgGN9XmXlNYy
   A==;
X-CSE-ConnectionGUID: 41HuLRJ9T7KqmgTLCEcjvQ==
X-CSE-MsgGUID: X/NbEO2UR3qFT4ImtMBZUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="22999339"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="22999339"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 08:21:30 -0700
X-CSE-ConnectionGUID: KVfE2WjgSKW2trUPTNKVXQ==
X-CSE-MsgGUID: d5eee0UgTEOHenLpCVJE0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="56093532"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jul 2024 08:21:30 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 08:21:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 08:21:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 08:21:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+14vNtn6CJFOWNnFb5RS4r1LR7zOAVolxst2x0Wo5f/zZBRmDbTM6bD9NNKmosVC7mqzr6hRPPO8i0od+VuVSdn2Z6pJYnkJ0elKGJGFBEXCRHVJoQAtRvGQSpb6idfsIjIFFsjt0kY14SLMrjprtgu6WogNDr+R7qzphfSpkfdV0evZiiYM/S5gl+gVw+XNhOYGIG8G6EWfs5//6KUcgARfKd2WekdSFbSO6F62rjI2luoKLpTjQJmUQxkl4esjo5dx7VKELivkhRK+jxhPPg63wr2zcnTgl0P7229np/X1QZp63Aq8ERUcGJV+xbDnp33o/yg7aEOyD+SeCHvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPSrCtfES6f0T861z5GijZRh5+J6cpeqllnCtx47dcA=;
 b=E5cgj30H/dsQ8cOZ2SPQkolF9tDMZ0HRiwOtG/zAqC5wPHRbVhWFoZawmmy7AsVj39rnbrb2i7cKYYiTdCYK1Vxy1R2NKMnNvYZdMHgihmaGgIdmQIfqh28L22uvCN17Tiye9Se2C90QzqfYAmiehtu0NfliAe82aCWTC3VACDIYCF7K4Cm9L0xeGE0iAGl52tiXxt4rjlmE4ygz603YqA1T/YD0VqPmIdsLqfJD4wkYJoAwkgSkUz4ONrpPKy0uul+4330JkNDzHAev3uaYhf+u9sedb8oC8TwirGNN2s3AFX5lgrwmA3KhXg0RrZD8yIgIMgmyLVc/6Sgg1SaYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB7270.namprd11.prod.outlook.com (2603:10b6:208:42a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 15:21:25 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 15:21:25 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "acme@kernel.org" <acme@kernel.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"Dhananjay.Ugwekar@amd.com" <Dhananjay.Ugwekar@amd.com>, "x86@kernel.org"
	<x86@kernel.org>, "irogers@google.com" <irogers@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
CC: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "gautham.shenoy@amd.com"
	<gautham.shenoy@amd.com>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Larabel,
 Michael" <michael@michaellarabel.com>, "sandipan.das@amd.com"
	<sandipan.das@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "ananth.narayan@amd.com" <ananth.narayan@amd.com>
Subject: Re: [PATCH 2/2] powercap/intel_rapl: Fix the energy-pkg event for AMD
 CPUs
Thread-Topic: [PATCH 2/2] powercap/intel_rapl: Fix the energy-pkg event for
 AMD CPUs
Thread-Index: AQHa2cOQ281/U8pyC0SnDudrUQMJSLIBPfeAgAEvpwCAAFucgIAAAqkAgAAWNgA=
Date: Mon, 22 Jul 2024 15:21:25 +0000
Message-ID: <675268cbee83af84fcb093f69541452b0bc9cb29.camel@intel.com>
References: <20240719092545.50441-1-Dhananjay.Ugwekar@amd.com>
	 <20240719092545.50441-3-Dhananjay.Ugwekar@amd.com>
	 <2a81f438306b82620bb4db9065d2cbf3e4c2d56c.camel@intel.com>
	 <9c492669-d97b-4040-bdcf-e7f5a5ac7e09@amd.com>
	 <77ea13bb319d6408ff262b10ed744c2e80c5fe24.camel@intel.com>
	 <32281529-316c-4927-8344-945df1af56d7@amd.com>
In-Reply-To: <32281529-316c-4927-8344-945df1af56d7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB7270:EE_
x-ms-office365-filtering-correlation-id: e7ab6466-4aa6-4943-9aaa-08dcaa61f3c5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TmdiaFAvRGxqNDJ1QnFxLzE4NXJPVEx5MFdRelh4cGFGTGZnV0JGVXdjaUNw?=
 =?utf-8?B?MDlkSlpBZThmK1kxUHd0TElUMEVqVzFnZWxvcFY3WmNyckZVZjF4dndjaFZW?=
 =?utf-8?B?OHV6dkF1enRZUWNZR0NuZEtrbTBMRWtZNHRGNUNOYktyOW55eHYyN2l1YkE3?=
 =?utf-8?B?OEdZYUJuRU5QcmtIWkFobHk5L0xMSGN6eEJVTzNRV1Q2ZXczZmlHc2MvWXFT?=
 =?utf-8?B?bWdueWNzSVo0bnV5LzVXR0ltejI0eGNwTVpvV1ZFRVZyREFGTUtwaFBRaGVk?=
 =?utf-8?B?RGt0YTJZSk53dnhhREZ5c3cyR2cyRzJsbHpVbWlpYTBVeG15UVhmaGEvdHA1?=
 =?utf-8?B?RnptNkxUR3FLS081dVVFSDRtUlRVZHlCVTltcUZ1OTBCQWJQb1EyWU9ZZ2tl?=
 =?utf-8?B?bmFCbWNpOGh3cnZzY2p6cGJ1dldtMUdvd04yMDNyNGZNYVQweWJEK2VWRFVw?=
 =?utf-8?B?QlQ4V25SNHpHY1FCMHpTTTJaTERycFc2d3RaNUxialNTWWtTMXlLZjNocWRG?=
 =?utf-8?B?RTNtU05Oc09BYlpMWXlCK1lmbFhlKytyMlJLNjVWTm9JblhzOUkrbjVzQmRU?=
 =?utf-8?B?cGxSZkJ4dkZvSTBoeFhqYktQY3JYUk03RmFWMXZNMkYxdjQwbUJNZGdZeElK?=
 =?utf-8?B?WGNrbDdlWGc0UmFzSk9mUWRjb0M4b3F6OGVuTEpOTU95aGdMcWpGNVF5ZWdm?=
 =?utf-8?B?UVM1NTJDazlObktLVmZrNGVxekVUS3NHZFdMVUFtS2Q5cjczaVg1aWlUYksy?=
 =?utf-8?B?S3FSWlQzVTN4Vk1PMTNiM09wRUNrYVFZSDVZN1lPbFpzSEpNakJFUGZIMEFy?=
 =?utf-8?B?VW8vT09DL052eXcvZkNBVU1SUkFOYmJUMnZwMkc4by9DdWtaNCtndEkzYTV6?=
 =?utf-8?B?aCtDb0FnQWZoeHV2bTZqWU55WUZnL0tCL3lVczk3QVFRSUw3b0MyU1A1aHp6?=
 =?utf-8?B?d3dSOWoyTlBXNTFqMDR1MnBrdnZ1eVM0WlB2TVl6cWVLK25LZ2tEVHhneGtE?=
 =?utf-8?B?ZWpkM2d2dXdlUTEyZnFHcWVkL0VSalBjMDJ2ajVia2Q1aWpRcGtaZWw3ZkFm?=
 =?utf-8?B?MnU5SkxkWnhWTEhGRlp3Y3ZOY1JmWFBsUGVMejdRKytBeXI3Zzcwdm9wTmEr?=
 =?utf-8?B?amZTb1NSenk2emRpN1BZQ0NSNlk5QjEyUGQ2Slc2SjJYcTRWbDZhT3FxYkMy?=
 =?utf-8?B?emZVTGtoU1J4b045dzJicHlyY2Jmelo3MWk1VDFBRGFkZmJSRTlFSkhZdHdV?=
 =?utf-8?B?YWFjQmlJb3RaVERoZmV6bldYaEh4ZnU4NnF6V0JvSFovb0xQcXIxbU9ub09N?=
 =?utf-8?B?Vmd2TGVIWjhURlorUTVSTWpMb09mRmJmaVJkWG1lWmVWVElUc3VKOTZDSTBH?=
 =?utf-8?B?OGhJZDQzSE5lMER3OC9wa3JrWDJUdk15T05UOHJ5b3ZQN01nQnYrcjZnd3ll?=
 =?utf-8?B?alU1MFl2YmtON0RKSVM4bm54MnVoN0xUaUVKaEE4Y3QxbSs3eng2Qk1YRktZ?=
 =?utf-8?B?L2JCL3ltdkp1RUZLVHJTK0FNNnN5UnV0U3Zxc2s0TWF5TTg0dnA3UklZK3o0?=
 =?utf-8?B?c0kwZVR1N1lXWTJFdVFROUlmcXBYdVVmc3dPRDdtUHhydVgySHhORDNuNFFN?=
 =?utf-8?B?QitoRVJ0b05XNXlCTDFjTkV2NGdkSnlueUZBbms2bW9pbTVYaEhRU2s5amZQ?=
 =?utf-8?B?VU9kbmYzSUlxYVNVRWZWeUVOck1lU1JaMC85WmVPWVRwa1VzZjUyazdPL2dM?=
 =?utf-8?B?UlFuS0N4Y2h6anNIaFd3cW1aUFZ6WVJXZWozaUxMYzd5bC8vQ0E0M2k2OXJw?=
 =?utf-8?B?ZWthaXpnQ0pyeU9kalRCanZ3WVFnZ3FyNGhlV3UvZ0MyVmFrQW9ReWRhdUF5?=
 =?utf-8?B?TjlqRXZkaFZJRGRSRjRzVW5tcG53QUhTd3pCeSttdnBhV25jYk5UZWsyLzJB?=
 =?utf-8?Q?WplDkc91f5g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODBNQzMwYlhwZE9pUVFaQ0ZIRTJwZlRocE9uTHQ2NXpPWGl2Uy84MzBWR1pa?=
 =?utf-8?B?VG5mbFFKRTU0dERGQ1d2MXQwa3JnUjhibDRjeVpUa1R4eHB2aWwwY0dBTlZ1?=
 =?utf-8?B?TGFFbU5uZVdmY0NLTmI4bmJSL3ZIU3Vvc1JVMXRDMGZvd05YdWhJYmRidnBJ?=
 =?utf-8?B?U3RpTDJ1aTFucy82MUNWcEp4cm5wM2o5NlpaZ0dvRlFrSWVVRElLcGhTei9O?=
 =?utf-8?B?WjU1N0k4UzR3d01MSmRKWHdEVWxYZGNTMVp4aWNFbXhMVldWTXZsUmJKdHVK?=
 =?utf-8?B?M1VtcFVPNm45N3RrYnZwUmI4TkR1aGVLSEl3QjZyMmtkU01hQzJtd2RzcWdk?=
 =?utf-8?B?VTcyYWhMbHFJOWxVYm0wcVJqS3EvRnpYQ1lvOExiRUxlazVSVmhuOWNQYjFV?=
 =?utf-8?B?NnAzM0FWaG5SWm5sblhOYkRybm9Fak9KVDZxKzArT290ZnpVV0tlZytXQkhD?=
 =?utf-8?B?SUc4NzN6Y0xPVVFLZUprZ2hIWFVKTW1obndJSVBlUHFjSGdaTDFwUE9hZ0ta?=
 =?utf-8?B?YW1LeHhaZ21rOFMrYzIzWkVNTHc3c1pXTWlRbkJQVGFhVmVGck1vblRJN244?=
 =?utf-8?B?aXU2UXBkZVR1RHk5RElTWGhiUXZwY2Vjb01RS091RUkrQllCeVdLb0pnaUZL?=
 =?utf-8?B?RWdIckJUVHJJczd2anV5Smt1STlDSExFREhaODU3ZHdxUm9paEovWUNLYkZW?=
 =?utf-8?B?R0VQMWJDSXc3UnVVQnFSQjUvQnNLRGJOdHNqNVduRVA0M0dDTU9TcFd1dVBl?=
 =?utf-8?B?UWZrdVNEczBkSkxDTDI3MlJrdVF2UGt0NzJUb0NJZ0RrTkt3Q05kRHIyamt0?=
 =?utf-8?B?Sk9Ra0c0Mm9QQnhBSTJ4NHRlNmF3Qit1L1R3Q3ZKdDJzbS80MkdCcW5Ddytn?=
 =?utf-8?B?MExMU2JoRi9YRklOaW1tWjZRMmZOY0JtOHk1NXYxYUltdGxmcnZNb2h2Y3NE?=
 =?utf-8?B?VEdNSTY2TEFQWXMyZDhhaVZtc052WTBuZ25MR0w3U0dsRGt2cEJPMDlQME03?=
 =?utf-8?B?c1N3RDVkVzBaZmxEN1BqY01FcFNwaG1zWnZMR3RORzJaYk9CeUZtaTViVzVE?=
 =?utf-8?B?Mkw2MFBjZ2l4TmNPQnRzMzQ5Ky90Nytkck4vclhGVTg5b0RNeVI1OHJvaGx0?=
 =?utf-8?B?dVVPekNFTGQzREFZczdCbmF6MDdIZ0V4WHo0MnJ3SHd5YnA4U05aQlBGdHF1?=
 =?utf-8?B?UElvNHhvd0svd1AvU05sSzNvbFBOa21POGVnVkJoejhEWE5DS1NvNUpOTDNI?=
 =?utf-8?B?eXJPZDNlajM3S2w3QVE2SGxSNXJRcFdZVmRZMUgyZ1gwWm1MVytpcHVXcWtY?=
 =?utf-8?B?ekdyeWNKY1ByK2ozMjlib1hJUFBrNjNJcm1BNlFVSlZsNVBaQWxiR0tFamlt?=
 =?utf-8?B?OWxiYmpzY0ovZGx5WEd1MG02cGROdldac3N4SmM1cy94RVpiZjZiVHJEY2tH?=
 =?utf-8?B?MkpBaTNZY2k3ZnowZGs5aStWY3VNdVRNRGNFUDQycG8zU0tBZ3grRk95Nktw?=
 =?utf-8?B?NVpXdFZhRHpUUVc3eDZodjMyYjNXRlo3amhZajAyUGNIUEpWN3ZsOTgxbjYv?=
 =?utf-8?B?L0tKVHRkNzJ1UVpNcjNtejFFbFpBSTJaU0kzK3NJOS9JaTQwZzIvNkJ0RUxm?=
 =?utf-8?B?czc2Yzc5djRqWm9NNlpNZGtNNVF0TktDU0VSRmFhNXBjaEw2Rk9GdW5Gd3NP?=
 =?utf-8?B?azRKMy9JRndGeEQwSktLS2RlbGpXYjhnbnNCdVFDZ2U5ZThycDZNbk0wZUVy?=
 =?utf-8?B?UmJjNlNnZUMvNHpQMnJPRVFiY3MyaUsyVmxkWTdtT2lFQ1NpdnoyN0pxUmJj?=
 =?utf-8?B?VkhiRHQ1SUt0RHUrVFV2V1ZuSkRoNkhCYjVnUkhVVldGNW1yVkZvMzBCc0tv?=
 =?utf-8?B?NWpXQjB0STNTMDh6M2wzNnlXQ3RqVGVWS1p2NS9PSkxDaHdzNytGNUpqNUVm?=
 =?utf-8?B?VDhrdlIwK3dabVB5ZlE3bGZ0Ymd3TUl4czV4OTlzYTc4YUFWNVZSWUFYdmhS?=
 =?utf-8?B?WHEvajFqamZEdXRnRjNwenVBbUNiL0hEVTF2cTU3OVNUYVZKbkExdjZibTNV?=
 =?utf-8?B?UnMrVGNNWGYxSUpnR0xtS2NSdXk5MXVqaTBnc0VacU1tY2p1K3NldzlhY3hI?=
 =?utf-8?B?dmNUQklGL1B4dHZEWEhPWloxVDhGcm5mNkRFQXRTRzdWNmxOeWI0L3MvZnEv?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A62AE948D851C4A953A3645F30FAFCA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ab6466-4aa6-4943-9aaa-08dcaa61f3c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 15:21:25.7605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+nybMB5v0+9gQiTbTkZJbYIrVeQ+Kv3uHmlYI0toaofFoifVLv6HI+gIxa9/7dqdx7/sOw08YJ5rlhCPHHGkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7270
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA3LTIyIGF0IDE5OjMxICswNTMwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToNCj4gDQo+IA0KPiBPbiA3LzIyLzIwMjQgNzoyMiBQTSwgWmhhbmcsIFJ1aSB3cm90ZToNCj4g
PiBPbiBNb24sIDIwMjQtMDctMjIgYXQgMTM6NTQgKzA1MzAsIERoYW5hbmpheSBVZ3dla2FyIHdy
b3RlOg0KPiA+ID4gSGkgUnVpLA0KPiA+ID4gDQo+ID4gPiBPbiA3LzIxLzIwMjQgNzo0NyBQTSwg
WmhhbmcsIFJ1aSB3cm90ZToNCj4gPiA+ID4gT24gRnJpLCAyMDI0LTA3LTE5IGF0IDA5OjI1ICsw
MDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90ZToNCj4gPiA+ID4gPiBBZnRlciBjb21taXQgKCJ4
ODYvY3B1L3RvcG9sb2d5OiBBZGQgc3VwcG9ydCBmb3IgdGhlIEFNRA0KPiA+ID4gPiA+IDB4ODAw
MDAwMjYNCj4gPiA+ID4gPiBsZWFmIiksDQo+ID4gPiA+ID4gb24gQU1EIHByb2Nlc3NvcnMgdGhh
dCBzdXBwb3J0IGV4dGVuZGVkIENQVUlEIGxlYWYNCj4gPiA+ID4gPiAweDgwMDAwMDI2LA0KPiA+
ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IHRvcG9sb2d5X2xvZ2ljYWxfZGllX2lkKCkgbWFjcm9zLCBu
byBsb25nZXIgcmV0dXJucyBwYWNrYWdlDQo+ID4gPiA+ID4gaWQsDQo+ID4gPiA+ID4gaW5zdGVh
ZCBpdA0KPiA+ID4gPiA+IHJldHVybnMgdGhlIENDRCAoQ29yZSBDb21wbGV4IERpZSkgaWQuIFRo
aXMgbGVhZHMgdG8gdGhlDQo+ID4gPiA+ID4gZW5lcmd5LQ0KPiA+ID4gPiA+IHBrZw0KPiA+ID4g
PiA+IGV2ZW50IHNjb3BlIHRvIGJlIG1vZGlmaWVkIHRvIENDRCBpbnN0ZWFkIG9mIHBhY2thZ2Uu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRm9yIG1vcmUgaGlzdG9yaWNhbCBjb250ZXh0LCBwbGVh
c2UgcmVmZXIgdG8gY29tbWl0DQo+ID4gPiA+ID4gMzJmYjQ4MGUwYTJjDQo+ID4gPiA+ID4gKCJw
b3dlcmNhcC9pbnRlbF9yYXBsOiBTdXBwb3J0IG11bHRpLWRpZS9wYWNrYWdlIiksIHdoaWNoDQo+
ID4gPiA+ID4gaW5pdGlhbGx5DQo+ID4gPiA+ID4gY2hhbmdlZA0KPiA+ID4gPiA+IHRoZSBSQVBM
IHNjb3BlIGZyb20gcGFja2FnZSB0byBkaWUgZm9yIGFsbCBzeXN0ZW1zLCBhcyBJbnRlbA0KPiA+
ID4gPiA+IHN5c3RlbXMNCj4gPiA+ID4gPiB3aXRoIERpZSBlbnVtZXJhdGlvbiBoYXZlIFJBUEwg
c2NvcGUgYXMgZGllLCBhbmQgdGhvc2UNCj4gPiA+ID4gPiB3aXRob3V0DQo+ID4gPiA+ID4gZGll
DQo+ID4gPiA+ID4gZW51bWVyYXRpb24gYXJlIG5vdCBhZmZlY3RlZC4gU28sIGFsbCBzeXN0ZW1z
KEludGVsLCBBTUQsDQo+ID4gPiA+ID4gSHlnb24pLA0KPiA+ID4gPiA+IHdvcmtlZA0KPiA+ID4g
PiA+IGNvcnJlY3RseSB3aXRoIHRvcG9sb2d5X2xvZ2ljYWxfZGllX2lkKCkgdW50aWwgcmVjZW50
bHksIGJ1dA0KPiA+ID4gPiA+IHRoaXMNCj4gPiA+ID4gPiBjaGFuZ2VkDQo+ID4gPiA+ID4gYWZ0
ZXIgdGhlICIweDgwMDAwMDI2IGxlYWYiIGNvbW1pdCBtZW50aW9uZWQgYWJvdmUuDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gUmVwbGFjaW5nIHRvcG9sb2d5X2xvZ2ljYWxfZGllX2lkKCkgd2l0aA0K
PiA+ID4gPiA+IHRvcG9sb2d5X3BoeXNpY2FsX3BhY2thZ2VfaWQoKQ0KPiA+ID4gPiA+IGNvbmRp
dGlvbmFsbHkgb25seSBmb3IgQU1EIGFuZCBIeWdvbiBmaXhlcyB0aGUgZW5lcmd5LXBrZw0KPiA+
ID4gPiA+IGV2ZW50Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIGFuIEFNRCAyIHNvY2tldCA4
IENDRCBaZW41IHNlcnZlcjoNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBCZWZvcmU6DQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gbGludXgkIGxzIC9zeXMvY2xhc3MvcG93ZXJjYXAvDQo+ID4gPiA+ID4g
aW50ZWwtcmFwbMKgwqDCoMKgwqAgaW50ZWwtcmFwbDoxOjDCoCBpbnRlbC1yYXBsOjM6MMKgIGlu
dGVsLQ0KPiA+ID4gPiA+IHJhcGw6NTowDQo+ID4gPiA+ID4gaW50ZWwtcmFwbDo3OjDCoCBpbnRl
bC1yYXBsOjk6MMKgIGludGVsLXJhcGw6YjowwqAgaW50ZWwtDQo+ID4gPiA+ID4gcmFwbDpkOjAN
Cj4gPiA+ID4gPiBpbnRlbC1yYXBsOmY6MMKgIGludGVsLXJhcGw6MMKgwqDCoCBpbnRlbC1yYXBs
OjLCoMKgwqAgaW50ZWwtcmFwbDo0DQo+ID4gPiA+ID4gaW50ZWwtcmFwbDo2wqDCoMKgIGludGVs
LXJhcGw6OMKgwqDCoCBpbnRlbC1yYXBsOmHCoMKgwqAgaW50ZWwtcmFwbDpjDQo+ID4gPiA+ID4g
aW50ZWwtcmFwbDplwqDCoMKgIGludGVsLXJhcGw6MDowwqAgaW50ZWwtcmFwbDoyOjDCoCBpbnRl
bC0NCj4gPiA+ID4gPiByYXBsOjQ6MA0KPiA+ID4gPiA+IGludGVsLXJhcGw6NjowwqAgaW50ZWwt
cmFwbDo4OjDCoCBpbnRlbC1yYXBsOmE6MMKgIGludGVsLQ0KPiA+ID4gPiA+IHJhcGw6YzowDQo+
ID4gPiA+ID4gaW50ZWwtcmFwbDplOjDCoCBpbnRlbC1yYXBsOjHCoMKgwqAgaW50ZWwtcmFwbDoz
wqDCoMKgIGludGVsLXJhcGw6NQ0KPiA+ID4gPiA+IGludGVsLXJhcGw6N8KgwqDCoCBpbnRlbC1y
YXBsOjnCoMKgwqAgaW50ZWwtcmFwbDpiwqDCoMKgIGludGVsLXJhcGw6ZA0KPiA+ID4gPiA+IGlu
dGVsLXJhcGw6Zg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFmdGVyOg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IGxpbnV4JCBscyAvc3lzL2NsYXNzL3Bvd2VyY2FwLw0KPiA+ID4gPiA+IGludGVsLXJh
cGzCoCBpbnRlbC1yYXBsOjDCoCBpbnRlbC1yYXBsOjA6MMKgIGludGVsLXJhcGw6McKgDQo+ID4g
PiA+ID4gaW50ZWwtDQo+ID4gPiA+ID4gcmFwbDoxOjANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBP
bmx5IG9uZSBzeXNmcyBlbnRyeSBwZXItZXZlbnQgcGVyLXBhY2thZ2UgaXMgY3JlYXRlZCBhZnRl
cg0KPiA+ID4gPiA+IHRoaXMNCj4gPiA+ID4gPiBjaGFuZ2UuDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gRml4ZXM6IDYzZWRiYWE0OGE1NyAoIng4Ni9jcHUvdG9wb2xvZ3k6IEFkZCBzdXBwb3J0IGZv
ciB0aGUNCj4gPiA+ID4gPiBBTUQNCj4gPiA+ID4gPiAweDgwMDAwMDI2IGxlYWYiKQ0KPiA+ID4g
PiA+IFJlcG9ydGVkLWJ5OiBNaWNoYWVsIExhcmFiZWwgPG1pY2hhZWxAbWljaGFlbGxhcmFiZWwu
Y29tPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERoYW5hbmpheSBVZ3dla2FyIDxEaGFuYW5q
YXkuVWd3ZWthckBhbWQuY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gRm9yIHRoZSBmdXR1cmUgSW50
ZWwgbXVsdGktZGllIHN5c3RlbSB0aGF0IEkga25vdywgaXQgc3RpbGwgaGFzDQo+ID4gPiA+IHBh
Y2thZ2Utc2NvcGUgUkFQTCwgYnV0IHRoaXMgaXMgZG9uZSB3aXRoIFRQTUkgUkFQTCBpbnRlcmZh
Y2UuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgVFBNSSBSQVBMIGRyaXZlciBpbnZva2VzIHRoZXNl
IEFQSXMgd2l0aCAiaWQgPT0gcGtnX2lkIiBhbmQNCj4gPiA+ID4gImlkX2lzX2NwdSA9PSBmYWxz
ZSIsIHNvIG5vIG5lZWQgdG8gbWFrZQ0KPiA+ID4gPiByYXBsX3BtdV9pc19wa2dfc2NvcGUoKQ0K
PiA+ID4gPiByZXR1cm5zIHRydWUgZm9yIHRob3NlIEludGVsIHN5c3RlbXMuDQo+ID4gPiANCj4g
PiA+IFRoaXMgc2VlbXMgbGlrZSBhbiBpbXBvcnRhbnQgcG9pbnQsIHdvdWxkIHlvdSBiZSBva2F5
IHdpdGggaXQsIGlmDQo+ID4gPiBJDQo+ID4gPiBpbmNsdWRlDQo+ID4gPiB0aGlzIGluZm8gaW4g
dGhlIGNvbW1pdCBsb2cgaW4gdjIgYWxvbmcgd2l0aCB5b3UgcmIgdGFnPw0KPiA+IA0KPiA+IFll
cy4NCj4gPiANCj4gPiBUaGlzIHJlbWluZHMgbWUgdGhhdCB3ZSBjYW4gcmVwaHJhc2UgdGhlIGNv
bW1lbnQgZm9yDQo+ID4gcmFwbF9wbXVfaXNfcGtnX3Njb3BlKCkgYSBiaXQsIHNvbWV0aGluZyBp
bmNsdWRpbmcgYmVsb3cgcG9pbnRzLA0KPiA+IDEuIEFNRC9IWUdPTiBwbGF0Zm9ybXMgdXNlIHBl
ci1QS0cgUGFja2FnZSBlbmVyZ3kgY291bnRlcg0KPiA+IDIuIEZvciBJbnRlbCBwbGF0Zm9ybXMN
Cj4gPiDCoMKgIDIuMSBDTFgtQVAgcGxhdGZvcm0gaGFzIHBlci1ESUUgUGFja2FnZSBlbmVyZ3kg
Y291bnRlcg0KPiA+IMKgwqAgMi4yIG90aGVyIHBsYXRmb3JtcyB0aGF0IHVzZXMgTVNSIFJBUEwg
YXJlIHNpbmdsZSBkaWUgc3lzdGVtcyBzbw0KPiA+IHRoZQ0KPiA+IFBhY2thZ2UgZW5lcmd5IGNv
dW50ZXIgYXJlIHBlci1QS0cvcGVyLURJRQ0KPiA+IMKgwqAgMi4zIG5ldyBwbGF0Zm9ybXMgdGhh
dCB1c2UgVFBNSSBSQVBMIGRvZXNuJ3QgY2FyZSBhYm91dCB0aGUNCj4gPiBzY29wZQ0KPiA+IGJl
Y2F1c2UgdGhleSBhcmUgbm90IE1TUi9DUFUgYmFzZWQuDQo+ID4gDQo+ID4gd2hhdCBkbyB5b3Ug
dGhpbms/DQo+IA0KPiBBZ3JlZWQsIHRoaXMgZ2l2ZXMgYSBtb3JlIGNsZWFyIHBpY3R1cmUgb2Yg
dGhlIGFsbCB0aGUgUkFQTCBzY29wZXMuDQo+IA0KPiBXZSB3aWxsIG5lZWQgdGhlIGFib3ZlIGNv
bW1lbnQgaW4gdGhlIGZpcnN0IHBhdGNoIGFzIHdlbGwsIGFwYXJ0IGZyb20NCj4gdGhlIDIuMyBw
b2ludC4NCg0KU291bmRzIGdvb2QgdG8gbWUuDQo+IA0KPiBBbHNvLCByZWdhcmRpbmcgcGVyZi94
ODYvcmFwbCBkcml2ZXIocGF0Y2ggMSksIHdpbGwgeW91IGJlIHNlbmRpbmcgYQ0KPiBwYXRjaA0K
PiB0byBjb25kaXRpb25hbGx5IHNldCB0aGUgcmFwbCBzY29wZSB0byBkaWUgZm9yIENMSy1BUCBw
bGF0Zm9ybShvbiB0b3ANCj4gb2YgdGhpcyBmaXgpLA0KPiBvciBzaG91bGQgSSBmaXggaXQgaW4g
dGhpcyBwYXRjaCAxIGl0c2VsZj8NCg0KcGF0Y2ggMSBpcyBhIGZpeCBwYXRjaC4NCm9wdGltaXph
dGlvbiBmb3IgQ0xYLUFQIHNob3VsZCBiZSBhIHNlcGFyYXRlIHBhdGNoIGFuZCB0aGF0IGlzIG5v
dA0KdXJnZW50ICh0aGUgbmV3IGxvZ2ljIGlzIHN0aWxsIGNvcnJlY3QgZm9yIGN1cnJlbnQgZXhp
c3RpbmcgSW50ZWwNCnBsYXRmb3JtcyksIEkgd2lsbCBzdWJtaXQgaXQgbGF0ZXIuDQoNCkkgdGhp
bmsgdGhlIGZpeCBwYXRjaCBpcyBnb29kIGVub3VnaCBhcyBsb25nIGFzIHdlIGhhdmUgYmVsb3cN
CmluZm9ybWF0aW9uDQoxLiBDTFgtQVAgaXMgbXVsdGktZGllIGFuZCBpdHMgUkFQTCBNU1JzIGFy
ZSBkaWUgc2NvcGUNCjIuIG90aGVyIEludGVsIHBsYXRmb3JtcyBhcmUgc2luZ2xlIGRpZSBzeXN0
ZW1zIHNvIHRoZSBzY29wZSBjYW4gYmUNCmNvbnNpZGVyZWQgYXMgZWl0aGVyIHBrZy1zY29wZSBv
ciBkaWUtc2NvcGUuDQpUaGlzIGluZm8gd2lsbCBtYWtlIHRoZSBmdXR1cmUgb3B0aW1pemF0aW9u
IGVhc2llci4NCg0KdGhhbmtzLA0KcnVpDQoNCj4gDQo+IFRoYW5rcywNCj4gRGhhbmFuamF5DQo+
IA0KPiA+IA0KPiA+IHRoYW5rcywNCj4gPiBydWkNCj4gPiA+IA0KPiA+ID4gVGhhbmtzIGZvciB0
aGUgcmV2aWV3Lg0KPiA+ID4gDQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4gRGhhbmFuamF5DQo+ID4g
PiANCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBwYXRjaCBMR1RNLg0KPiA+ID4gPiANCj4gPiA+ID4g
UmV2aWV3ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCj4gPiA+ID4gDQo+
ID4gPiA+IHRoYW5rcywNCj4gPiA+ID4gcnVpDQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gwqBk
cml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMgfCAyMCArKysrKysrKysrKysrKysr
Ky0NCj4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KPiA+ID4gPiA+IGIvZHJpdmVy
cy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+ID4gPiA+ID4gaW5kZXggM2NmZmE2Yzc5
NTM4Li4yZjI0Y2E3NjQ0MDggMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9wb3dlcmNh
cC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9wb3dlcmNhcC9p
bnRlbF9yYXBsX2NvbW1vbi5jDQo+ID4gPiA+ID4gQEAgLTIxMjgsNiArMjEyOCwxOCBAQCB2b2lk
IHJhcGxfcmVtb3ZlX3BhY2thZ2Uoc3RydWN0DQo+ID4gPiA+ID4gcmFwbF9wYWNrYWdlDQo+ID4g
PiA+ID4gKnJwKQ0KPiA+ID4gPiA+IMKgfQ0KPiA+ID4gPiA+IMKgRVhQT1JUX1NZTUJPTF9HUEwo
cmFwbF9yZW1vdmVfcGFja2FnZSk7DQo+ID4gPiA+ID4gwqANCj4gPiA+ID4gPiArLyoNCj4gPiA+
ID4gPiArICogSW50ZWwgc3lzdGVtcyB0aGF0IGVudW1lcmF0ZSBESUUgZG9tYWluIGhhdmUgUkFQ
TCBkb21haW5zDQo+ID4gPiA+ID4gaW1wbGVtZW50ZWQNCj4gPiA+ID4gPiArICogcGVyLWRpZSwg
aG93ZXZlciwgdGhlIHNhbWUgaXMgbm90IHRydWUgZm9yIEFNRCBhbmQgSHlnb24NCj4gPiA+ID4g
PiBwcm9jZXNzb3JzDQo+ID4gPiA+ID4gKyAqIHdoZXJlIFJBUEwgZG9tYWlucyBmb3IgUEtHIGVu
ZXJneSBhcmUgaW4tZmFjdCBwZXItUEtHLg0KPiA+ID4gPiA+IFNpbmNlDQo+ID4gPiA+ID4gKyAq
IGxvZ2ljYWxfZGllX2lkIGlzIHNhbWUgYXMgbG9naWNhbF9wYWNrYWdlX2lkIGluIGFic2VuY2UN
Cj4gPiA+ID4gPiBvZg0KPiA+ID4gPiA+IERJRQ0KPiA+ID4gPiA+ICsgKiBlbnVtZXJhdGlvbiwg
dXNlIHRvcG9sb2d5X2xvZ2ljYWxfZGllX2lkKCkgb24gSW50ZWwNCj4gPiA+ID4gPiBzeXN0ZW1z
DQo+ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4gKyAqIHRvcG9sb2d5X2xvZ2ljYWxfcGFja2FnZV9p
ZCgpIG9uIEFNRCBhbmQgSHlnb24gc3lzdGVtcy4NCj4gPiA+ID4gPiArICovDQo+ID4gPiA+ID4g
KyNkZWZpbmUNCj4gPiA+ID4gPiByYXBsX3BtdV9pc19wa2dfc2NvcGUoKcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBcDQo+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgKGJvb3RfY3B1X2RhdGEueDg2X3ZlbmRvciA9PSBYODZfVkVO
RE9SX0FNRCB8fMKgwqBcDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgIGJvb3RfY3B1X2RhdGEu
eDg2X3ZlbmRvciA9PSBYODZfVkVORE9SX0hZR09OKQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiDC
oC8qIGNhbGxlciB0byBlbnN1cmUgQ1BVIGhvdHBsdWcgbG9jayBpcyBoZWxkICovDQo+ID4gPiA+
ID4gwqBzdHJ1Y3QgcmFwbF9wYWNrYWdlICpyYXBsX2ZpbmRfcGFja2FnZV9kb21haW5fY3B1c2xv
Y2tlZChpbnQNCj4gPiA+ID4gPiBpZCwNCj4gPiA+ID4gPiBzdHJ1Y3QgcmFwbF9pZl9wcml2ICpw
cml2LA0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYm9vbA0KPiA+ID4gPiA+IGlkX2lzX2NwdSkNCj4gPiA+ID4gPiBAQCAt
MjEzNiw3ICsyMTQ4LDggQEAgc3RydWN0IHJhcGxfcGFja2FnZQ0KPiA+ID4gPiA+ICpyYXBsX2Zp
bmRfcGFja2FnZV9kb21haW5fY3B1c2xvY2tlZChpbnQgaWQsIHN0cnVjdCByYXBsX2lmXw0KPiA+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqBpbnQgdWlkOw0KPiA+ID4gPiA+IMKgDQo+ID4gPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoGlmIChpZF9pc19jcHUpDQo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHVpZCA9IHRvcG9sb2d5X2xvZ2ljYWxfZGllX2lkKGlkKTsNCj4gPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdWlkID0gcmFwbF9wbXVfaXNfcGtn
X3Njb3BlKCkgPw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHRvcG9sb2d5X3BoeXNpY2FsX3BhY2thZ2VfaWQoaWQpIDoNCj4gPiA+ID4gPiB0b3Bv
bG9neV9sb2dpY2FsX2RpZV9pZChpZCk7DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGVsc2UN
Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVpZCA9IGlkOw0KPiA+
ID4gPiA+IMKgDQo+ID4gPiA+ID4gQEAgLTIxNjgsOSArMjE4MSwxMCBAQCBzdHJ1Y3QgcmFwbF9w
YWNrYWdlDQo+ID4gPiA+ID4gKnJhcGxfYWRkX3BhY2thZ2VfY3B1c2xvY2tlZChpbnQgaWQsIHN0
cnVjdCByYXBsX2lmX3ByaXYgKnByDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPiA+ID4gPiDCoA0KPiA+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqBpZiAoaWRfaXNfY3B1KSB7DQo+ID4gPiA+ID4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJwLT5pZCA9IHRvcG9sb2d5X2xvZ2ljYWxfZGllX2lkKGlkKTsN
Cj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcnAtPmlkID0gcmFwbF9w
bXVfaXNfcGtnX3Njb3BlKCkgPw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRvcG9sb2d5X3BoeXNpY2FsX3BhY2thZ2VfaWQoaWQpIDoN
Cj4gPiA+ID4gPiB0b3BvbG9neV9sb2dpY2FsX2RpZV9pZChpZCk7DQo+ID4gPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBycC0+bGVhZF9jcHUgPSBpZDsNCj4gPiA+ID4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHRvcG9sb2d5X21heF9kaWVzX3Blcl9w
YWNrYWdlKCkgPiAxKQ0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
ZiAoIXJhcGxfcG11X2lzX3BrZ19zY29wZSgpICYmDQo+ID4gPiA+ID4gdG9wb2xvZ3lfbWF4X2Rp
ZXNfcGVyX3BhY2thZ2UoKSA+IDEpDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc25wcmludGYocnAtPm5hbWUsDQo+ID4gPiA+ID4gUEFD
S0FHRV9ET01BSU5fTkFNRV9MRU5HVEgsICJwYWNrYWdlLSVkLWRpZS0lZCIsDQo+ID4gPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoA0KPiA+ID4gPiA+IHRvcG9sb2d5X3BoeXNpY2FsX3BhY2thZ2VfaWQoaWQpLA0KPiA+
ID4gPiA+IHRvcG9sb2d5X2RpZV9pZChpZCkpOw0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZWxzZQ0KPiA+ID4gPiANCj4gPiANCj4gDQoNCg==

