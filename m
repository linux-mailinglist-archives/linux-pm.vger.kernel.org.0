Return-Path: <linux-pm+bounces-10464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 445919251B5
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 06:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29FA1F296D4
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 04:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B140413D51D;
	Wed,  3 Jul 2024 04:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKFXMbXF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EEC3CF74;
	Wed,  3 Jul 2024 04:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979661; cv=fail; b=nsMqMZwBafKtm59S4q7256p1js9vrKr9RAMZmHardR4L29wuxjTnrSCu94U8tNkR39j5wqGeP76Xqt1zvCjIHeQ3O/ZCENs1+ZL0BWxdw3Ct+eg4KSeHKCy3g2kL7BxS9qDcwutklxDkDATrV8oDohGaLWilFSH7+1mR13Dpluc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979661; c=relaxed/simple;
	bh=ba4y50hdc/XwklrZuF7Fu4x6LwDFZMVqBMXLdSrLTXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W20YF/1zL7yP1i+B7xf++C7ttBxMdPviTr6YDnDWsSDNyZs/I7NP5n2UchgOA80cYFp1w1B/4RBDLytEh/wgCRlcKMnPzPgbU+M1/b06EkPJ9VojXE3Fmq1Drg/ruVb+VcszHurjQegugQFpQ80+NXwpiMnPRjpVwQx0nGWGLTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKFXMbXF; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719979660; x=1751515660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ba4y50hdc/XwklrZuF7Fu4x6LwDFZMVqBMXLdSrLTXM=;
  b=hKFXMbXFVE3DOU0lkR8ulqLhtctaQQieZDAThxnXmdpAUYIwow6d1AA5
   b6I9sl7qxgomSUgpJ9XJy3aNLpk6d7Pn1FZLYgXKOeopQVSDX+GkSAQfl
   QbTqgxetSQgSTolN6ADqbfh76bHYnYO+mrt1YSKrA7mz2Xy3Q7Eth4cY1
   W6HxDRNVCBOGi8hJy9ex8jSV82BenSmH1AfjvfyavaM72+pqsXJEhiQYo
   Fz/gLiznBa8zd3ysmYHHPQRdNDpfKw6IysTAXJ3vEnQ6Q+mUdBQc7ENSK
   9FtiWamdIa1bEPpL9zskluAPLIC+GO96hkozLRdkzcVwx2ctosKIEy/Dx
   w==;
X-CSE-ConnectionGUID: QN6hBIEHS92LrZNS70cNQA==
X-CSE-MsgGUID: Sl6Mciz+Q+i+tBC+aurT7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16845947"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="16845947"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 21:07:39 -0700
X-CSE-ConnectionGUID: dL45FgETTw2rlUi47oMQNA==
X-CSE-MsgGUID: YYD/VXC7TximRzWO/WGx8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="51295833"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 21:07:38 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 21:07:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 21:07:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 21:07:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRWD4pc1d48UqJXMWkY9OVJ4KzDsMpUpaaQiORpgEJDhptbZn5Jli5R/lBYsHbH+8wWxB/UoVDBV29EcELsqqRmpj9f8C/2+zbWXwiUfUenOY2g1FyVpnlX1ekygg6Z9W7bVi0pK9ZsPxQuAqo4TqLG6fK3GBUUVes6KgJiM//a9OE1G0NiYJ/qQDQNXODfMfT2YoVSImxsmWJgckqF9EGuHQavbPSEpsbxSs4/mYu9CXhFUz3N9ppz3ErWLZnAOjLwr3b4EPHG4bvDp3uhEu2eRR5CkvOQ8s7XFZ7FSAqO25SxVgVyhquuFoPSDeTS+qySm2mjoNSYRw5XUyciYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ba4y50hdc/XwklrZuF7Fu4x6LwDFZMVqBMXLdSrLTXM=;
 b=ZodfWLabeEqPgR06eEky4BV9YMJqT9WctO2FEX9AqfGzoSdLpq8GPxuPIBJenoMnJYZr8H15GZuNL3BLMqDg6pm1u1BgjaBkckTg2OK0q43/2temgWMqQzm9AX0JozGLENt8mhNvh/Ug48KvDxuoX/3Jbv0WOcrtuwKzarKk/Y7wQ5ij7f4rm5q1osLbcTtlRsG49DaPOomx5XXYk+Jd937cheoO6OmxtWnZ3djt+AtxBr9vc1kmAPpNuLcUWJfbg8MgpJOFQNR5EJmMpTxycwVdMiX1jm9+V0mPX8MrdipSf7PnkZN9tEz53Ccfgwh/aucVzecy3rEsLuh02bT5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB5937.namprd11.prod.outlook.com (2603:10b6:a03:42c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 04:07:34 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%7]) with mapi id 15.20.7698.033; Wed, 3 Jul 2024
 04:07:34 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "Dhananjay.Ugwekar@amd.com"
	<Dhananjay.Ugwekar@amd.com>
CC: "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"ananth.narayan@amd.com" <ananth.narayan@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>, "irogers@google.com"
	<irogers@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "kees@kernel.org" <kees@kernel.org>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"acme@kernel.org" <acme@kernel.org>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v3 08/10] perf/x86/rapl: Modify the generic variable names
 to *_pkg*
Thread-Topic: [PATCH v3 08/10] perf/x86/rapl: Modify the generic variable
 names to *_pkg*
Thread-Index: AQHaxfwxVnnLKeOUFEevngJ7z5gzNbHh46KAgADemACAAIS7AIABI+wA
Date: Wed, 3 Jul 2024 04:07:34 +0000
Message-ID: <738e2dcc26926ce948bc7647cf17d83ed5d637b7.camel@intel.com>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
	 <20240624055907.7720-9-Dhananjay.Ugwekar@amd.com>
	 <20240701130845.GI20127@noisy.programming.kicks-ass.net>
	 <477c33a2949793d2a8692c925179bc4f1feb7942.camel@intel.com>
	 <35ab02da-861a-4271-986f-f4271637f5fc@amd.com>
In-Reply-To: <35ab02da-861a-4271-986f-f4271637f5fc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB5937:EE_
x-ms-office365-filtering-correlation-id: 01b00956-26af-4b01-02df-08dc9b15aaee
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RWtxZlZzYXlBNUlpNXBwaEphZ0ZFNEZRTlkveDg5SjRTOHprWXdDc3daK2x2?=
 =?utf-8?B?Zy9TS2ZOTEw4U21CR25qS0VMUDErT1ptcXRFcXhLUmovTmtNbFAxd3RBWmUv?=
 =?utf-8?B?cC9SUHFvWmd0SURLTTAvRktxNlNtUE5IWW1wY3B4UmJGQ3NYVDJCY2hvMnh4?=
 =?utf-8?B?QVpiVmRRb0pRZUhyWEl1d25PVFJHdkV2cURuZUtVSndhaFdJc0JiYWpNSjhz?=
 =?utf-8?B?ak81UUppTmcxWUJBbnNJalczWVl6dXBLSlpTaTczUVJjYlpaaEhYb3hxUXlz?=
 =?utf-8?B?Znh4cjduWHEyMWFpUkkxZWxtbXJGc3NGc2xLUHVYSG0zVTVWQ2pob0tnUnFV?=
 =?utf-8?B?SVFqWW5pcEVOdDZzcXNDUTVkYWhyd0xSY2Z0TlZrVXVJdHhNK0VhSU9qdEg2?=
 =?utf-8?B?Vkx5L0dXQVNvQS9JRzh3OVBRK1ZhYVN4ckpJUG5qbzlRS0E5RGhSZmtCMmhG?=
 =?utf-8?B?U2IveVFVa0RnVlY0WHliVThoaFZWejB2TnVCVG12QU5tRmNqeU5TdmcwNlVq?=
 =?utf-8?B?NXJFUmVvUkVNcEY4ZGUxR3dFUExVR1o1bTk5cHJrMDg2dWROQ1kvM3BscVFx?=
 =?utf-8?B?TFRFRVJKTDVVN3EzRE5WcDNlcmlPVTZMekgzakVNSTVFUGloWk9RbEhTREtZ?=
 =?utf-8?B?R24walI0aEp3V1hYcGFSaHVqY3FSYlNHTmNOYW8wQk9IazkvS2Z3T3Zpb2tq?=
 =?utf-8?B?VExCZTZyc05UQ2ZjWUYwOUNtNmJqendpdUIwUXZ0SEhDdWd4R2lhSUlYWmp5?=
 =?utf-8?B?WWl0cVArWTlrbkhPKy9ZaXRZOUFtV3YvMFAvc1h4YURYZnlrQVVyY2o2YXdX?=
 =?utf-8?B?RTJSK1NDTUpvazlkdHR0Z01lUmZZOGNLYlp5M1RRMWczZFVCMmg3cXppditz?=
 =?utf-8?B?MDZCcG5XU3IzZlIwdWdORXNrbU5vQkJJOWFWdWZqa1hITGNuT3BVRngvSU1C?=
 =?utf-8?B?TDRmenNJZ0VRTTR6Q1dJZTBUc1VEWVY0WWtEYmFUZTlKaExvUmVGT2d0VFAy?=
 =?utf-8?B?SHI0d2lzbjQ4VFArZVFzS3hQNUpkcFpCbG5uNytaUitYdEFMalZDUENLZ1Zw?=
 =?utf-8?B?UENpdGIzMzc4R0ozeHpuWTYrV3NwNFRYQU1tRzBlWWpRcTU1QTVkYzBuY1NL?=
 =?utf-8?B?aVV0RUs2Y05jRUZzdU45Mnh5R1lkWkFHcGRoVGVqTGdMYlZpeVcvd2RWS004?=
 =?utf-8?B?OTNiWUQ4eVZmTWFiQUt6c21oWVZDSnp4YXpPQUY3VUNKNTJKUHA2andaQ0RU?=
 =?utf-8?B?NHFnYUg5Z1U5TnN1NnY3OG8yUGpaMTdnQUdwbmU5M2htSzFwYnd5YWRyWkth?=
 =?utf-8?B?dmxXd2U5Y0lmVVRxdnpxcStkRkZiaHBJckpMUG5ab1BFMGJnVW5tSkY0TUhG?=
 =?utf-8?B?VE1NUHI1YVdSRjlER2xNZjJQek5nOEtkMUZwTFoyTUNmQUpDSGwxYjN6VUht?=
 =?utf-8?B?eGpLeUIyUUt3cjNhcUdnNmFSU014dUwyZGFwcTJ2KzNTWDNCUitkQWZOU1ll?=
 =?utf-8?B?S2xkQnNDZGNjM0FhRHNPclpXK2JuTUhoY2J2U3JuaitrVnBmSTdHeUptYlZ2?=
 =?utf-8?B?cU1sNThTcm5wWkFOUkJsYWpkSUY5UEY1OC9qQ0Jqa09XbFlpRzdwNkFnekdy?=
 =?utf-8?B?cHdJcEhGMjlHWnNnY3Z3bTNPdkN2RmVkWmdEdTlyQlJPWEJLVG1XTVpSN28v?=
 =?utf-8?B?ZklISWE0WkpBQ1I3Sm5GUS8velhPRjM1NnhTWjlBNGNjTEZKQ1I4Yjk3dVdL?=
 =?utf-8?B?dGpybkdqTTJIbWw4Z0ZkSkpQY3FHemVJeVluNGxYSjZlaWZFYllMNDgxTUdO?=
 =?utf-8?B?MFE3RGY5eEtTVHd3SHZrWFVKNGU3ODUzamZVbVVQNTIzN1ZEaXZkQVdTTW5i?=
 =?utf-8?B?QUg2Qm5FRElwMWlDVFVxZG1hbnVPU1BwQzhvSmhTKzlIaGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1NNMnk0eXBEajRHMWt6ZlZONGE0MndPNXdoVXRWUyt6YXZHc3htN0dzbW5T?=
 =?utf-8?B?N21xVjEwR2t0WDk3YnVHemxxS1A3eVR1azlTb3dOS2FaTmtFVG5zNzdaZWt6?=
 =?utf-8?B?TmpUemYxZ0RaYkhvSEZUek1UY1VDdGlaR25WNXVPczlWWVpJb2oxZHRLZVF4?=
 =?utf-8?B?a0E2Vlltc3dQVEppNHgwRHlmNGJXNEpZeFltMyswT01iRXd4OEFnbmZJT2Z4?=
 =?utf-8?B?bThPQWVJdXB0QVFaQlB0Z01KNW5ENUhCOThhMU16ZXYxUDFqWkd6aUZXRlAz?=
 =?utf-8?B?aEU2SThwZ1BiMmZNdHFFdmlYNTNac2dNYWxNOXQzaEg2TW0zb1pUVTFrRFo5?=
 =?utf-8?B?aTNXZ25sZ3k0aFVTK3czTjdSNEtldXVmMFlvOTlEZUlwMlllUDVBUjd2WXRp?=
 =?utf-8?B?YWpNcUFNcDdaYWh0YStoSXhFMmFBYm9DcW5RcEcya2x5SkZPQldOdnJ6cy95?=
 =?utf-8?B?aHhYYUVETHBvdmsxMzg1V2VaczUwZ0NuOSt1dk5yVWdPK05xbmEzbW9nMVZv?=
 =?utf-8?B?NUR1UGc4d2tCNkgzZ21VdDBSb3VuZHFTbi80MGQrUTk4aXlDWUhYclgwWWN2?=
 =?utf-8?B?bjlnQ2dxRm9SeWIzWGZZQmhlc0lnbG1oY2VSUEtVRW8rbXh5RkdIREJ4dlZi?=
 =?utf-8?B?am9CZWhNZFNGZFFucWJJSk0zdGxQV21sR0ZnSkJhU0ozd3RRd1RockY1TVdy?=
 =?utf-8?B?STJqdkh5YnJ6by96T0tLQS9hNm83WExzRUdhL3VDdWpCZkFZVUpYOEgwQWll?=
 =?utf-8?B?bXUzejQwVkFJVkQ1MkRKTXZXSVVvazBCQloyTGpHbkxLUDJ3K25Ec1dDWEJR?=
 =?utf-8?B?c2ZsYjVVRSsvSlRnWDlaZ1BQNFZDZHI5aFVIdFNFYk53QkZnVUJLN0lZZHJa?=
 =?utf-8?B?NFM5N0ZGdklJOGpCYzZYMVJxQXlEVTRWQk5CaVBibVF4a203dzFTbnRuYk1N?=
 =?utf-8?B?YmNGWlU4NTB4Tms3OUpmN0xkb21rTkxzclZpa2Vaa1NHM2ZaRE5NRGloOHAv?=
 =?utf-8?B?aHNzdnhFOHVBaitiWlJjdnNGQ2VmSG5kcXFBNGEzMHhseHFSNVdMWm9RSmlm?=
 =?utf-8?B?S1d3UkZWbDU2dUpTUUtXQWNZbjNScHhYa1R1L1BtT0V6QzZHL3JOcko0M3NB?=
 =?utf-8?B?MlR4VG1sNFEzM0t5WTljMXhxSmFONEl5dVhNbXBmQzkwNWI4NldJaktzZG9t?=
 =?utf-8?B?bjNpdm5FOEl4NWIrRFdyQmRuZXZ1YTNNN0VLL0RyUXVqeVBBUUkrRmp4d3ZE?=
 =?utf-8?B?dHUvRUVWSTZGZ2RaREVvc2ZTMGRNSDN1S2x2YUVLM1I3QStwRzJxam1PMkpR?=
 =?utf-8?B?ekw1UGI1SUFnalpZSy9lc2Y2bGlEK2FtcmNsQk1MMlVCNkxuTm5vTG1GTTE5?=
 =?utf-8?B?V2J2bkpueEJiaEkxUnp6VjNhdFNScjZYOE1yTGZ2TGJHNkxyQWdMTDBFc016?=
 =?utf-8?B?UkxZL3FOMUR2RS80di9jSmR2MUswa1VIMUxKU2ZhTDdOSFVScnRBSFlrV2Nn?=
 =?utf-8?B?TWdsblBVT01HQXM2Nkg0U2tyWFBlNEw4ZUI4a29vR29qUVpEMjM5MlYvS0x4?=
 =?utf-8?B?R1VLZHFJRVVpSUE3T293OStVWnNpa1dqeWtuUGNCa3FWSDZhc3RBRlh5dDVh?=
 =?utf-8?B?ZUtjNm5iQ21kNlE3eWRYZnNHS21IM3IyMC95UHdId3RZMExrNVFEcER3eGU1?=
 =?utf-8?B?bDJHNkpXYXFBMTlsQVBBUUp3Qm9rRjZCcjN3VjJwcUhkT3krdHBjQjAvQitY?=
 =?utf-8?B?cWpMQ3M2eUJoUW8vS1NFUFBHS3lGcnF4RTQrT2FRTFZpamp4Ky9tNmNsQVlY?=
 =?utf-8?B?TG9BNEx5ZTB4M2lrWXc3cmVkNjltRTA3eGpLWGJaT1BtK0pyTmhrd1FydStu?=
 =?utf-8?B?UDk3dmdvSFdhNmN0alY1M1VkYjQ3MlhZZWxkSmlyZi9ST3FqSzdKclpPS25l?=
 =?utf-8?B?S0dKQzdrcUFpYUtqaWZpMzZQY1NjYjUwaGkvTFFZbHM3WjJ1ZG5FaC9MQ0pI?=
 =?utf-8?B?M1BoNFN5VzE1RFM4b0xpTzNXNDFDTEFjbWRId1JLKzNDL0FSTDAwTDBGMzVO?=
 =?utf-8?B?VThLRUY2WVRZT21IZ1RNTzhLTUYxVEgrUlNUaE84VHZGajdxQ3FaM3UybnBN?=
 =?utf-8?B?LzZtTWxpeXh3R0xPcEd0dDFFUUR5KzBjQUFGN0p0MmRLMFdkc2dtdlU1M2xo?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B302B3FB01C9604E91CA3789388F7E44@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b00956-26af-4b01-02df-08dc9b15aaee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 04:07:34.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HM2oCrI0vBIWf5+i/SAzrhXqiNaFSYCSdHhm1KoVWZzkanr+HnkJ/6mwQSzxU0qZgkfLUXvDwU8FqQ9HLLXzZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5937
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA3LTAyIGF0IDE1OjUwICswNTMwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToNCj4gDQo+ID4gDQo+ID4gRm9yIEludGVsIHByb2R1Y3RzLCB3ZSBoYXZlDQo+ID4gMS4gQ2Fz
ZWNhZGVsYWtlLUFQIHdoaWNoIGhhcyBtdWx0aS1kaWUgcGVyIHBhY2thZ2UgYW5kIGhhcyBwZXIt
ZGllDQo+ID4gUkFQTA0KPiA+IE1TUnMNCj4gPiAyLiBhbGwgb3RoZXIgcGxhdGZvcm1zIHdoaWNo
IGhhcyBzaW5nbGUtZGllIHBlciBwYWNrYWdlLCBzbyBpdHMNCj4gPiBSQVBMDQo+ID4gTVNScyBj
YW4gYmUgY29uc2lkZXJlZCBhcyBlaXRoZXIgcGFja2FnZS1zY29wZSBvciBkaWUtc2NvcGUNCj4g
PiBUaGlzIGFwcGxpZXMgdG8gVGhlcm1hbCBNU1JzIGFzIHdlbGwuDQo+ID4gDQo+ID4gc28gZm9y
IHRoZXNlIE1TUnMsIHdlIGNhbiB0cmVhdCB0aGVtIGFzDQo+ID4gMS4gYWx3YXlzIGRpZS1zY29w
ZSBmb3IgYWxsIGV4aXN0aW5nIHBsYXRmb3Jtcw0KPiA+IG9yDQo+ID4gMi4gcGFja2FnZS1zY29w
ZSB3aXRoIHRoZSBleGNlcHRpb24gb2YgQ2FzZWNhZGVsYWtlLWFwDQo+ID4gQW5kIGN1cnJlbnQg
a2VybmVsIGNvZGUgZm9sbG93cyBydWxlIDEuDQo+ID4gDQo+ID4gSSBwcm9wb3NlIHdlIHN3aXRj
aCB0byBydWxlIDIgZm9yIHRoZXNlIGNvZGUgYmVjYXVzZSBydWxlIDEgY2FuIGJlDQo+ID4gYnJv
a2Ugb24gZnV0dXJlIG11bHRpLWRpZSBzeXN0ZW1zIChUaGlzIGlzIGFscmVhZHkgdHJ1ZSBmb3Ig
VGhlcm1hbA0KPiA+IE1TUnMpLg0KPiANCj4gSSBoYXZlIGEgZG91YnQgYWJvdXQgdGhpcywgd29u
J3QgdGhlIGZ1dHVyZSBJbnRlbCBtdWx0aS1kaWUgc3lzdGVtcyANCj4gaGF2ZSBkaWUtc2NvcGUg
Zm9yIHRoZSBSQVBMIFBNVSBsaWtlIENhc2VjYWRlbGFrZS1BUD8NCg0KRm9yIGZ1dHVyZSBtdWx0
aS1kaWUgc3lzdGVtcyB0aGF0IEkga25vdywgdGhlIFJBUEwgaXMgc3RpbGwgcGFja2FnZQ0Kc2Nv
cGUgYnV0IGl0IGlzIGp1c3QgbHVja3kgdGhhdCBSQVBMIGNvbnRyb2wgaXMgbm90IGV4cG9zZWQg
dmlhIHRoZQ0KTVNScyBzbyBydWxlIDEgaXMgbm90IGFjdHVhbGx5IGJyb2tlIGZvciBSQVBMIFBN
VSAod2hpbGUgaXQgaXMgaW5kZWVkDQpicm9rZW4gZm9yIG90aGVyIGRyaXZlcnMgbGlrZSB0aGVy
bWFsKS4NCg0KSW4gc2hvcnQsIGlmIHdlIHN0aWNrIHdpdGggcnVsZSAxLCB0aGUgUkFQTCBQTVUg
c3RpbGwgd29ya3MuIFN3aXRjaGluZw0KdG8gcnVsZSAyIHRvIGJlIGNvbnNpc3RlbnQgd2l0aCB0
aGUgb3RoZXIgZHJpdmVycyBpcyBhbHNvIGEgY2hvaWNlIElNVi4NCg0KdGhhbmtzLA0KcnVpDQo+
IA0KPiBJZiB5ZXMsIHRoZW4gcnVsZSAxIGFib3ZlIHNlZW1zIGJldHRlci4NCj4gDQo+IFJlZ2Fy
ZHMsDQo+IERoYW5hbmpheQ0KPiANCj4gPiANCj4gPiBJbiB0aGlzIHNlbnNlLCBJIHRoaW5rIGl0
IGlzIG9rYXkgdG8gY2FsbCBpdCBwa2cgbGV2ZWwgcmFwbCBmb3INCj4gPiBib3RoDQo+ID4gSW50
ZWwgYW5kIEFNRC4NCj4gPiANCj4gPiB0aGFua3MsDQo+ID4gcnVpDQo+ID4gDQoNCg==

