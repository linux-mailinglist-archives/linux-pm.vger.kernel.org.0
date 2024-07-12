Return-Path: <linux-pm+bounces-11028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8CF92F563
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 08:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769E3B21F6E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 06:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339F213D502;
	Fri, 12 Jul 2024 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acTwbQ1n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF241C77;
	Fri, 12 Jul 2024 06:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720764928; cv=fail; b=WM6RiuRZIEskfoNoydBbE/Wj+aTagngMIRvdibMXSO3aEG9XvVME8XX+1mKrGzTl1GQ+W2MD87gYoQwAaJ9CVGp2ZNQ08UpjYqcfZHvRhmxtnYjMA69rCIu1659TzEV7gMemxJzT83Z79cWWfeSKBszxqaSNvORJRpYmMC1LJgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720764928; c=relaxed/simple;
	bh=O9fjB8uV9szL33/hDytsk5WELP+h3vTw5mfyfrtL5XE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ccnbi0RBDNfoLaKOfS85JftOMzYy1/Un9NXtrmPInu5ZAwZrxgIBjda0jCn8fF6WSqXHy8R3+4XrZwqRLnIzJrLNTmKGU1+iGLxZxrvM0nbyR3gIWc5nxWEFCL+kmt1XTmLSucglli7GjvBBp3JjgI9hukiBuO2C5iU73DBbB4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acTwbQ1n; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720764926; x=1752300926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O9fjB8uV9szL33/hDytsk5WELP+h3vTw5mfyfrtL5XE=;
  b=acTwbQ1nrrSyX9n53tprh3V6Q5VCAoYdUMuiAY+fjv2ARXL1W5CYuyLC
   zHZdf+xwyZpfgW0Xy7T+jiV/iwVP9MEgOudqbmpE0JT89Ks3HPem0W5vG
   ESuB/nNgT173LdE8dD3XAuPoDGFUCDKc1Re7l6l9wYdujPISsqfoq8oRv
   OaQmjjlfo2pXx2x45Q5L85SEz1sikhuIn6k9H1SDvElBlNQi9DGT1RAlj
   MEzXWfBDj2nuRg4iHYmgVsXLs2VmK7eJQJ4ALK60xW4pHSOqozqtNSV1G
   9IGq4ETkbX9UwLzHykxRojBn0o6zNqyloTN5d4Bg2yPtHl7tBl1NM5iqs
   g==;
X-CSE-ConnectionGUID: Z8Qo6jMsSdO4AMc+Yk/qLA==
X-CSE-MsgGUID: VEUz621zSYijstBXLpJcmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="29586097"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="29586097"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 23:15:25 -0700
X-CSE-ConnectionGUID: A1vW8x8DQ4aIMO0I09eKkg==
X-CSE-MsgGUID: ZOy5vgZcSlOlvxhlPG+08g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48904908"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 23:15:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 23:15:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 23:15:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 23:15:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 23:15:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IucLbLG9dgiUG2l/Rss0vxVMemGIA7/r9pHgUgTnMWVe8R4PUMkD9Gz5CKHslUhhFj7uD2vok/XIqy7qfTjTxK0id+4OC2aI+X5EgIiLal33Q/CAOGYXXyCbXwY/QOD1JMYwtaXBkOoC/hzEnrQSlvdx3wOk9PekU306omNrsgouQTnKu/7G8flyRzSicgsU2SaBFMI2+iMAzi+i1uQxuzh6km9BNCDAXRJ6SYhZXR1jXbNZMNfH/Tfq0ginYbMZU1Axsaz6eY6SL3K2vkDEOdgDGBcHk3o2Ps2a2yBL/f8CwRydpIfwSfy3h0jLbmKM8GTWAWLSdEW6YQdhd2Hvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9fjB8uV9szL33/hDytsk5WELP+h3vTw5mfyfrtL5XE=;
 b=XL/6v/puZKIG4ckJ3dqOFt5pf4PsYlRbtORUVjl/df9cFRX/SZxTxzgue/gVVFVK3YBx9pMnPaRRjPAfqfKB60bib5RqdcV8MjPoCpyM6s/qdMdYyzuaFiEIOZeBdpbd4rY1DMrmUCGm1U2zOnvKvQvlVsJfAgj4uUkHWNR7Pv9NnkjHNmcG0JstzTp8EN+fWYC3IlnIAUIDaVlo5xV5GyuaZrA7qSKJRapaSu5ngcn9GWL79Un2XL9ENRJOXzFc+vpaKYRt0IVmf44Ha/sXhcVD352Hd6zICkIYBtLRqVMpxy4KmVFqOc+gbQILLqYjFZUTNHjHdvCaQykOWgLr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SN7PR11MB8281.namprd11.prod.outlook.com (2603:10b6:806:26b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33; Fri, 12 Jul
 2024 06:15:16 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 06:15:16 +0000
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
Subject: Re: [PATCH v4 10/11] perf/x86/rapl: Add per-core energy counter
 support for AMD CPUs
Thread-Topic: [PATCH v4 10/11] perf/x86/rapl: Add per-core energy counter
 support for AMD CPUs
Thread-Index: AQHa032EYn+N1i1vF02tpu9bEYPrebHynrGA
Date: Fri, 12 Jul 2024 06:15:16 +0000
Message-ID: <6eac25a0c523144980b7f606132d49221906e911.camel@intel.com>
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
	 <20240711102436.4432-11-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240711102436.4432-11-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SN7PR11MB8281:EE_
x-ms-office365-filtering-correlation-id: d5a9c223-b45d-4bd7-1b24-08dca239ffca
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eGV2aER0UzkrbU9aQzMyVG1haktPYjNlRGRVQXUwZ1hndkxmOHZJZWRoVDQ1?=
 =?utf-8?B?N0R0Y3Z5b0dscHVObzcwZEJ1QTVwTVJ0SXhuUjYxbmROYm9LL1A2Ry9OYVhG?=
 =?utf-8?B?RDhNM1R2WkhxVExacUw3QmJta0VyVldaYnNVbkp4SWhBNjBZeEFmY2RHSmYy?=
 =?utf-8?B?YlErZHlSQVlEbDZWbHd6N3dxbWhKMjRWZUJVWnhpRHF4bjlMbjN3L0VjWDJP?=
 =?utf-8?B?YjBFc0hRWitKMSs4cVR5SFVSdkJqRXNZZFIxWWVidGx4R0h5WWlUSU9Nckxl?=
 =?utf-8?B?MHpVZGdWbi9Oa1ovMTR5MTY2ZHJMc3R4c1FrTUlDYVlOM2puYis4NHE5a3N6?=
 =?utf-8?B?b1FIQUZCZzBQRENxdXBaT04weUw3R29YMmZMZFJGVXZuS1Q5VHNSdmFib2gr?=
 =?utf-8?B?QXMvSHFNc3JhQnluakNvam1vWTFaYU9oWmhqOVREemlnOFlNbkY5WW1QMjRw?=
 =?utf-8?B?RzFkOVVydHNidkdTNkhuYjhEaElVVlU5TDExdVpJb3FBeDkrcGpFQ3R4Ymhs?=
 =?utf-8?B?Y1ArUStZVjZRMG1RYm1DQ3BFVCtwQjBCS3RoRTlvTWZzZFpEWjVhTmNwUGk3?=
 =?utf-8?B?YzBQVGY3NnFHa1pTenlpZmJsc1dqSkFnUUcvejJnbzQzRm1TY2ZuRHU2ajFM?=
 =?utf-8?B?ajl2MnRVWk00RldKVTFNODRGQm9iZzFFMGxEYWJFUHVGKzlMTFBLVUN5MnZN?=
 =?utf-8?B?OWdVL3dvTk9zNUVhRG9IVzh1TEk2Mnl6OVFjNnF4NC8yQ2s2MUY4akdOMHdL?=
 =?utf-8?B?cTlQcUdXUHpWQlZiU3pWZTV4c3MvaE4xZXhacjNXdlgzY0gwSDlKNnhpaHYx?=
 =?utf-8?B?RnYydkZPS1BjQW80VnBNa2ZLYzFVUjVCcG12SnZTM2NhZHV5T3A1djl2UVd4?=
 =?utf-8?B?MW5BYmFaSXRTZ1E5VWV6b0xMcVptd3RObE1OM1NJOG9FNUd3Y0RXZGNwenFJ?=
 =?utf-8?B?U0pRYWdqSHZsTmxSbjlqS1d5THJEdmlQc3haamRabFd1WDN3U1RoMnlZSk5z?=
 =?utf-8?B?bUZaeUNDRDNSODl0VlFrWXpqRCtTSHlKWkNjOXJ2VGgxUzFqTUVSWERvRm82?=
 =?utf-8?B?MHltRVlrL2l5ZXFuVml1L09BeVZHNWJTUks2MERkUUVlTEpUcU9UUXRQNmVm?=
 =?utf-8?B?NWNkVkxvN284MGR0TVBDWmZId0lRQU5PYklER2JCMUx1OElXZTAzL00vZTZi?=
 =?utf-8?B?NXY4c2lQZTJIZGE3STJ4cVlpckpGdUVBK0xKa0RadFRtYmRCZjRVb0FsUE9H?=
 =?utf-8?B?LzY2Z2gxOFFyM0ZMRjdJcGVUeXZ3YlR3T05BaWpBYTFQV2VJeXk0bG9MQjJn?=
 =?utf-8?B?M1QyY1pKVlkxV3FBSEdGYVNjczN0SFJxYVpjZStBbktjbCtKWHlLQkJYamdz?=
 =?utf-8?B?U2M4Z1QwTWI2K3lnQ3Z4U3FFaUZETXA4RitMU0ZWMUJrSkhEYk1qMlFnajl2?=
 =?utf-8?B?eTRKeXBta2gzc2FHYmF2dVN3VTZScGxBMWVzSlV4V1hGM1JoWndnenBoL2FK?=
 =?utf-8?B?Y0I5L3ByY3AySFpTYW5DQzdWOU83UTRrUXpRRkhZTzB2VU5GRGYxNkY0L2Ji?=
 =?utf-8?B?bXR0TElVZ0RzUzZFL0ZiVkRwNjRoN0dlTEd1RXU5OXJVSHZucjRkWkppai9r?=
 =?utf-8?B?WjJOenh1NW9QcGRGeTdVZ3ZKcUJsTHhtckNKazdrNDJSQmRJOVRZVXkxTlhT?=
 =?utf-8?B?L1pQWEwyWWpnTEpuaHNYV2x3VU9GWjNWc3Y2T2Rsc1J6Y3YwLzUxVWNEVnJF?=
 =?utf-8?B?cGQ4dmdiRXBkdExyaG9zdjNPeW5lVENqVUhQSy9YbS90dEZaSGdmOWx1NFVK?=
 =?utf-8?B?MDBqcGZEUDgwQ1RpZjJpRkxBTGhqbTcvZnRncisrdno4dkpGRFI5ekVGWEt5?=
 =?utf-8?B?eGo1S2V0UnR5a01rZW8zMVQzVzZ4NGtwY2RKaDlWM3lpQm9ZUloxS2EwdXV5?=
 =?utf-8?Q?zLMkPN/hf/c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmgzaU43VVI5ZUpBTU45ay8vdUo5TGw0NFhyWFZ1cHJLQTQ4c290ZnM5c2Rn?=
 =?utf-8?B?Y0xRWFNtVERkWFlSalM5VzBrOHhETFBXVkowOHdXRjZDb2FUN2QweVpNWkhj?=
 =?utf-8?B?OG55eDJPVTBXR3JUdmdEZ25VcU9ma0xTVTFucyt5VDFKeTRWWmJoTUs4emQx?=
 =?utf-8?B?UjFsM3gzRUU3d0VDSnRxdlBWaVpoTUE2RlFUYzhQZGROOXBzSGR2RnRYK0Yx?=
 =?utf-8?B?UWxXOXMyVFdyM05zUWRjOEE4V1JGVmRHUDYxazdDQ1ZxZ1IySy83L0QvWW5p?=
 =?utf-8?B?cjNwMXo5S1JiM1ZqblhpRUxNcGRrNWFvY25wUGM5eGdQVWczZmVidlM3MTk4?=
 =?utf-8?B?TDdMUE5xVDRCdktGZEJ1VFFSTVJnQ0RWVGFKdFhCemVDV3ZROEgyMHhZTnNV?=
 =?utf-8?B?c3RpSDV3dDhaQU52YXQxVGdpaWRTaDVJSVExdzV2cWxlZytaM3VmdlNrYkJ0?=
 =?utf-8?B?Y3NpU0NJK1E5R2N3TmJINTR5dFNLVEUrTjdEbUZJNW1TWFZjdkJWVXMwMHhq?=
 =?utf-8?B?NjFoQk1kY0x1MSs0a3h6N2pmaExkUnUwQXBvWEF3aTlqNklnMmRCRkpiUzhJ?=
 =?utf-8?B?YVdoOUp2SzA5UXFEdmZrb1d5aGZOeXYwTlk3S2Ryd2YwZGRuUjFSbjZ5SDVI?=
 =?utf-8?B?SG9qcHB2aEp4WSsveThXc0ZHTmxEUzZMN2E2aGhRUTBkbjNOT1RWaE5FUENG?=
 =?utf-8?B?azdVaTIxYWRxVW40ZStCanVRM3lwL0NOQjV3VkVIL2NFYkpSVkJxTExicnZD?=
 =?utf-8?B?NHRtR3FaY2ozSllrTjhnTWt1cU1DMVRjZzArSFZUWVZCbFF1K2pRSlR3MVJO?=
 =?utf-8?B?NTVrNEtHelo5Qml3MnBJakswK0VrRmZ5a2x0NVNHU2VLaTI1QThMRURoZXJu?=
 =?utf-8?B?YjRFUkZQdUxsaER2d3FuaW83TnZIMW5BREtIenVaVTYrT1NkVVBxeWtlTWR2?=
 =?utf-8?B?RXV1UmUyNjgxcWxZWkRYL2ZNQVVqUmJMYzVvSDRmeEFENVd4TXZHeUpUTjlV?=
 =?utf-8?B?LzNVaEF5U2F0Z3pzdjFPVnUveHNYVUN5dWNETzh1L3ZCZkVEcnI4amJYcmlV?=
 =?utf-8?B?a2xQRnZhWXFoeWIzQzZDSEhOTjEvME5xaUQ2MCtJSVBsZG5uY0lFWUVPWHNw?=
 =?utf-8?B?RUkvdGh4OFhOUzBwSlliTGp0RkdEL05ITlB6ZXI1UU5QRFFvV2hzZUhwZ3pt?=
 =?utf-8?B?cFhkUEhvMm56VE5EejRNUzQ4MjlzTU9RK3BDUk4ycGtlUkxxWVdteFdOM0N5?=
 =?utf-8?B?T0JTVVYwU1Z3N0N0OFVIWHI1ZEVtWHA2Z0pyRlBYbjBaVzFxcUQ0Q3BrRWFt?=
 =?utf-8?B?VU5WbHZobi94SExReVczaTVCay9zc3lkM2tyTTJNU3AwNG9jZlNTNy8xeHhO?=
 =?utf-8?B?VjVPamQxUDRrT2dFRHVDdUxpeVUrcG9rQnVQd0x3UGFndDk2NDRwdzl4S0xC?=
 =?utf-8?B?U0kzT0o4ZG13OTM5ZzZRUGNxTURZQjA3eFo2R3BneC9Iald3NGZUMGlqdjJz?=
 =?utf-8?B?VEhjaytXYkdtT3NlS2NyaVlXMlBXMnkxUlZOY2JWbnF4QkFQYkJmR1BqYndZ?=
 =?utf-8?B?OXpSRGJ6SWN6NkoxN2xQWG4zb0pWZElqdHFHMVdZdWdsaTh2SkloYzBuNkY4?=
 =?utf-8?B?QVdxL1E5RGxJN1ZLNnU4cEREeFlZVGtrRmVuTUd1NUorN1UxRkhxeW1aWHdF?=
 =?utf-8?B?aWROeExMcEcxRE1UUEtWNWRqaHNJcSthTGtJcFRQMG40Y0djcEpYd1NWRVYx?=
 =?utf-8?B?bExSTlY4dGFkQlF4MFhUd0paZzZ1M1NxdzJGTU1UeWRlQ09UUlJ6MFFEWmZ3?=
 =?utf-8?B?RGg2Q1JiK3RKODV2blcyTHM3WWs0QmhyMmpob2FYK0JSMVZHUEhOWEVRU0Nz?=
 =?utf-8?B?T3pXRjRkak84M3BCTjBjaWcyOUVXNTRUK2N5V1hKQnhrQzZ5Zlc3OFh3cURx?=
 =?utf-8?B?ZTl0bTBFa3pUbjhPZVV5UlVJV1MxSk5RSThYMGtScEJUd241MXloY0ViN2Z6?=
 =?utf-8?B?WkNwYmxRUk50VG54TDNCL2Q1cWkwY0Vla20zc2owRU9EVDV0OG5TU0REMzJH?=
 =?utf-8?B?OWtuVTR4MTk5SFV6L3lVQTQ2TitVN2dqeDlzS3RCSEdIb0dJMzZsWUViWUhG?=
 =?utf-8?B?anB6NVVoSjZhVXpFa3h0emJUOHlyQ1B0UmFPVHpLdDZSckZnaGVBTTd1NWhn?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8E2A4976048A34EB9F60661CD482754@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a9c223-b45d-4bd7-1b24-08dca239ffca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 06:15:16.7573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJGVRIrzLWVv8ZLKcXGaU9R+njT1X547oW1ooZ6agTsBxOBKZObABki9YthOGc2mN5gfO5vbxc5yc6ummVHGZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8281
X-OriginatorOrg: intel.com

PiAKPiBAQCAtMzUyLDkgKzM4NCwxMyBAQCBzdGF0aWMgaW50IHJhcGxfcG11X2V2ZW50X2luaXQo
c3RydWN0IHBlcmZfZXZlbnQKPiAqZXZlbnQpCj4gwqDCoMKgwqDCoMKgwqDCoHU2NCBjZmcgPSBl
dmVudC0+YXR0ci5jb25maWcgJiBSQVBMX0VWRU5UX01BU0s7Cj4gwqDCoMKgwqDCoMKgwqDCoGlu
dCBiaXQsIHJldCA9IDA7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCByYXBsX3BtdSAqcmFwbF9w
bXU7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHJhcGxfcG11cyAqY3Vycl9yYXBsX3BtdXM7Cj4g
wqAKPiDCoMKgwqDCoMKgwqDCoMKgLyogb25seSBsb29rIGF0IFJBUEwgZXZlbnRzICovCj4gLcKg
wqDCoMKgwqDCoMKgaWYgKGV2ZW50LT5hdHRyLnR5cGUgIT0gcmFwbF9wbXVzX3BrZy0+cG11LnR5
cGUpCj4gK8KgwqDCoMKgwqDCoMKgaWYgKGV2ZW50LT5hdHRyLnR5cGUgPT0gcmFwbF9wbXVzX3Br
Zy0+cG11LnR5cGUgfHwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKHJhcGxfcG11
c19jb3JlICYmIGV2ZW50LT5hdHRyLnR5cGUgPT0KPiByYXBsX3BtdXNfY29yZS0+cG11LnR5cGUp
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjdXJyX3JhcGxfcG11cyA9IGNvbnRh
aW5lcl9vZihldmVudC0+cG11LCBzdHJ1Y3QKPiByYXBsX3BtdXMsIHBtdSk7Cj4gK8KgwqDCoMKg
wqDCoMKgZWxzZQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9F
TlQ7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgLyogY2hlY2sgb25seSBzdXBwb3J0ZWQgYml0cyBh
cmUgc2V0ICovCj4gQEAgLTM2NCw3ICs0MDAsOCBAQCBzdGF0aWMgaW50IHJhcGxfcG11X2V2ZW50
X2luaXQoc3RydWN0IHBlcmZfZXZlbnQKPiAqZXZlbnQpCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChl
dmVudC0+Y3B1IDwgMCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAt
RUlOVkFMOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgZXZlbnQtPmV2ZW50X2NhcHMgfD0gUEVSRl9F
Vl9DQVBfUkVBRF9BQ1RJVkVfUEtHOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChjdXJyX3JhcGxfcG11
cyA9PSByYXBsX3BtdXNfcGtnKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBldmVu
dC0+ZXZlbnRfY2FwcyB8PSBQRVJGX0VWX0NBUF9SRUFEX0FDVElWRV9QS0c7Cj4gwqAKPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKCFjZmcgfHwgY2ZnID49IE5SX1JBUExfUEtHX0RPTUFJTlMgKyAxKQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cgp0aGlzIHNh
bml0eSBjaGVjayBiZWNvbWVzIGJvZ3VzIGZvciBwZXJfY29yZSBldmVudC4KCj4gQEAgLTM3Myw3
ICs0MTAsOCBAQCBzdGF0aWMgaW50IHJhcGxfcG11X2V2ZW50X2luaXQoc3RydWN0IHBlcmZfZXZl
bnQKPiAqZXZlbnQpCj4gwqDCoMKgwqDCoMKgwqDCoGJpdCA9IGNmZyAtIDE7Cj4gwqAKPiDCoMKg
wqDCoMKgwqDCoMKgLyogY2hlY2sgZXZlbnQgc3VwcG9ydGVkICovCj4gLcKgwqDCoMKgwqDCoMKg
aWYgKCEocmFwbF9wa2dfY250cl9tYXNrICYgKDEgPDwgYml0KSkpCj4gK8KgwqDCoMKgwqDCoMKg
aWYgKCEocmFwbF9wa2dfY250cl9tYXNrICYgKDEgPDwgYml0KSkgJiYKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqAgIShyYXBsX2NvcmVfY250cl9tYXNrICYgKDEgPDwgYml0KSkpCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKCndoYXQgaWYgYml0ID4gMSBm
b3IgYSBwZXJfY29yZSBldmVudD8KCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgLyogdW5zdXBwb3J0
ZWQgbW9kZXMgYW5kIGZpbHRlcnMgKi8KPiBAQCAtMzgxLDEyICs0MTksMTggQEAgc3RhdGljIGlu
dCByYXBsX3BtdV9ldmVudF9pbml0KHN0cnVjdAo+IHBlcmZfZXZlbnQgKmV2ZW50KQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gwqAKPiDCoMKgwqDC
oMKgwqDCoMKgLyogbXVzdCBiZSBkb25lIGJlZm9yZSB2YWxpZGF0ZV9ncm91cCAqLwo+IC3CoMKg
wqDCoMKgwqDCoHJhcGxfcG11ID0gY3B1X3RvX3JhcGxfcG11KGV2ZW50LT5jcHUpOwo+ICvCoMKg
wqDCoMKgwqDCoGlmIChjdXJyX3JhcGxfcG11cyA9PSByYXBsX3BtdXNfY29yZSkgewo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYXBsX3BtdSA9IGN1cnJfcmFwbF9wbXVzLQo+ID5y
YXBsX3BtdVt0b3BvbG9neV9sb2dpY2FsX2NvcmVfaWQoZXZlbnQtPmNwdSldOwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBldmVudC0+aHcuZXZlbnRfYmFzZSA9IHJhcGxfbW9kZWwt
Cj4gPnJhcGxfY29yZV9tc3JzW2JpdF0ubXNyOwo+ICvCoMKgwqDCoMKgwqDCoH0gZWxzZSB7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhcGxfcG11ID0gY3Vycl9yYXBsX3BtdXMt
Cj4gPnJhcGxfcG11W2dldF9yYXBsX3BtdV9pZHgoZXZlbnQtPmNwdSldOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBldmVudC0+aHcuZXZlbnRfYmFzZSA9IHJhcGxfbW9kZWwtCj4g
PnJhcGxfcGtnX21zcnNbYml0XS5tc3I7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKClRvIGF2b2lk
IHRoZSBhYm92ZSBpc3N1ZXMgYW5kIGNoZWNrIGZvciAoY3Vycl9yYXBsX3BtdXMgPT0KcmFwbF9w
bXVzX2NvcmUpIGFsbCBvdmVyIHRoZSBwbGFjZXMsIEknZCBzdWdnZXN0IHdlIGRvIHRoZQpwZXJf
Y29yZS9wZXJfcGtnIHNhbml0eSBjaGVja3MgYW5kIGhhbmRsaW5ncyBhbHRvZ2V0aGVyLCBzYXkg
c29tZXRoaW5nCmxpa2UKCmlmIChldmVudC0+YXR0ci50eXBlID09IHJhcGxfcG11c19wa2ctPnBt
dS50eXBlKSB7CglhbGwgc2FuaXR5IGNoZWNrcwoJcmFwbF9wbXUgPSAuLi4KCWV2ZW50LT5ody5l
dmVudF9iYXNlID0gLi4uCn0gZWxzZSBpZiAocmFwbF9wbXVzX2NvcmUgJiYgZXZlbnQtPmF0dHIu
dHlwZSA9PQpyYXBsX3BtdXNfY29yZS0+cG11LnR5cGUpIHsKCWFsbCBzYW5pdHkgY2hlY2tzCgly
YXBsX3BtdSA9IC4uLgoJZXZlbnQtPmh3LmV2ZW50X2Jhc2UgPSAuLi4KfSBlbHNlIHsKCXJldHVy
biAtLUVOT0VOVDsKfQoKWy4uLl0KCj4gwqBzdGF0aWMgaW50IHJhcGxfY3B1X29mZmxpbmUodW5z
aWduZWQgaW50IGNwdSkKPiDCoHsKPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gX19yYXBsX2NwdV9v
ZmZsaW5lKHJhcGxfcG11c19wa2csCj4gZ2V0X3JhcGxfcG11X2lkeChjcHUpLAo+ICvCoMKgwqDC
oMKgwqDCoGludCByZXQgPcKgIF9fcmFwbF9jcHVfb2ZmbGluZShyYXBsX3BtdXNfcGtnLAo+IGdl
dF9yYXBsX3BtdV9pZHgoY3B1KSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2V0X3JhcGxfcG11X2NwdW1hc2soY3B1
KSwgY3B1KTsKCmV4dHJhIHNwYWNlIGFmdGVyICc9Jz8KWy4uLl0KCj4gKwo+ICvCoMKgwqDCoMKg
wqDCoGlmIChyZXQgPT0gMCAmJiByYXBsX21vZGVsLT5jb3JlX2V2ZW50cykKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gX19yYXBsX2NwdV9vZmZsaW5lKHJhcGxfcG11c19j
b3JlLAo+IHRvcG9sb2d5X2xvZ2ljYWxfY29yZV9pZChjcHUpLAo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG9wb2xv
Z3lfc2libGluZ19jcHVtYXNrKGNwdSksCj4gY3B1KTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0
dXJuIHJldDsKPiDCoH0KPiDCoAo+IMKgc3RhdGljIGludCBfX3JhcGxfY3B1X29ubGluZShzdHJ1
Y3QgcmFwbF9wbXVzICpyYXBsX3BtdXMsIHVuc2lnbmVkCj4gaW50IHJhcGxfcG11X2lkeCwKPiBA
QCAtNjI5LDggKzcyNSwxNCBAQCBzdGF0aWMgaW50IF9fcmFwbF9jcHVfb25saW5lKHN0cnVjdCBy
YXBsX3BtdXMKPiAqcmFwbF9wbXVzLCB1bnNpZ25lZCBpbnQgcmFwbF9wbXVfCj4gwqAKPiDCoHN0
YXRpYyBpbnQgcmFwbF9jcHVfb25saW5lKHVuc2lnbmVkIGludCBjcHUpCj4gwqB7Cj4gLcKgwqDC
oMKgwqDCoMKgcmV0dXJuIF9fcmFwbF9jcHVfb25saW5lKHJhcGxfcG11c19wa2csCj4gZ2V0X3Jh
cGxfcG11X2lkeChjcHUpLAo+ICvCoMKgwqDCoMKgwqDCoGludCByZXQgPcKgIF9fcmFwbF9jcHVf
b25saW5lKHJhcGxfcG11c19wa2csCj4gZ2V0X3JhcGxfcG11X2lkeChjcHUpLAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Z2V0X3JhcGxfcG11X2NwdW1hc2soY3B1KSwgY3B1KTsKCmV4dHJhIHNwYWNlIGFmdGVyICc9Jz8K
Wy4uLl0KCgo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmFwbF9jb3JlX2NudHJfbWFzayAmICgx
IDw8IFBFUkZfUkFQTF9QRVJfQ09SRSkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHByX2luZm8oImh3IHVuaXQgb2YgZG9tYWluICVzIDJeLSVkIEpvdWxlc1xuIiwKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhcGxfY29yZV9kb21haW5f
bmFtZXNbUEVSRl9SQVBMX1BFUl9DT1JFXSwKPiByYXBsX2NvcmVfaHdfdW5pdCk7Cj4gwqB9CgpB
cmUgd2UgZXhwZWN0aW5nIHRvIGhhdmUgbW9yZSB0aGFuIG9uZSBEb21haW4gZm9yIHBlcl9jb3Jl
IHBvd2VyIFBNVT8KaWYgbm8sIHdlIGRvbid0IG5lZWQgaW50cm9kdWNlCitlbnVtIHBlcmZfcmFw
bF9jb3JlX2V2ZW50cyB7CisJUEVSRl9SQVBMX1BFUl9DT1JFID0gMCwJCS8qIHBlci1jb3JlICov
CisKKwlQRVJGX1JBUExfQ09SRV9FVkVOVFNfTUFYLAorCU5SX1JBUExfQ09SRV9ET01BSU5TID0g
UEVSRl9SQVBMX0NPUkVfRVZFTlRTX01BWCwKK307CisKYW5kIGNoZWNrIGZvciBOUl9SQVBMX0NP
UkVfRE9NQUlOUyBhbGwgb3ZlciB0aGUgcGxhY2UuCgpPciBlbHNlLCB3ZSBzaG91bGQgdXNlIGEg
bG9vcCBoZXJlIHRvIGFkdmVydGlzZSBhbGwgcG9zc2libGUgcGVyX2NvcmUKZG9tYWlucy4gRWl0
aGVyIGlzIG9rYXkgd2l0aCBtZSBidXQgdGhlIGNvZGUgbmVlZHMgdG8gYmUgY29uc2lzdGVudC4K
Cj4gwqAKPiDCoHN0YXRpYyB2b2lkIGNsZWFudXBfcmFwbF9wbXVzKHN0cnVjdCByYXBsX3BtdXMg
KnJhcGxfcG11cykKPiBAQCAtNzEyLDE0ICs4MjAsMTYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBh
dHRyaWJ1dGVfZ3JvdXAKPiAqcmFwbF9hdHRyX3VwZGF0ZVtdID0gewo+IMKgwqDCoMKgwqDCoMKg
wqBOVUxMLAo+IMKgfTsKPiDCoAo+IC1zdGF0aWMgaW50IF9faW5pdCBpbml0X3JhcGxfcG11cyhz
dHJ1Y3QgcmFwbF9wbXVzICoqcmFwbF9wbXVzX3B0cikKPiArc3RhdGljIGNvbnN0IHN0cnVjdCBh
dHRyaWJ1dGVfZ3JvdXAgKnJhcGxfcGVyX2NvcmVfYXR0cl91cGRhdGVbXSA9IHsKPiArwqDCoMKg
wqDCoMKgwqAmcmFwbF9ldmVudHNfcGVyX2NvcmVfZ3JvdXAsCj4gK307Cj4gKwo+ICtzdGF0aWMg
aW50IF9faW5pdCBpbml0X3JhcGxfcG11cyhzdHJ1Y3QgcmFwbF9wbXVzICoqcmFwbF9wbXVzX3B0
ciwKPiBpbnQgbnJfcmFwbF9wbXUsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3Jv
dXAKPiAqKnJhcGxfYXR0cl9ncm91cHMsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVf
Z3JvdXAKPiAqKnJhcGxfYXR0cl91cGRhdGUpCj4gwqB7Cj4gLcKgwqDCoMKgwqDCoMKgaW50IG5y
X3JhcGxfcG11ID0gdG9wb2xvZ3lfbWF4X3BhY2thZ2VzKCk7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0
cnVjdCByYXBsX3BtdXMgKnJhcGxfcG11czsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoGlmICghcmFw
bF9wbXVfaXNfcGtnX3Njb3BlKCkpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5y
X3JhcGxfcG11ICo9IHRvcG9sb2d5X21heF9kaWVzX3Blcl9wYWNrYWdlKCk7Cj4gLQo+IMKgwqDC
oMKgwqDCoMKgwqByYXBsX3BtdXMgPSBremFsbG9jKHN0cnVjdF9zaXplKHJhcGxfcG11cywgcmFw
bF9wbXUsCj4gbnJfcmFwbF9wbXUpLCBHRlBfS0VSTkVMKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYg
KCFyYXBsX3BtdXMpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVO
T01FTTsKPiBAQCAtODA5LDggKzkxOSwxMCBAQCBzdGF0aWMgc3RydWN0IHJhcGxfbW9kZWwgbW9k
ZWxfc3ByID0gewo+IMKgCj4gwqBzdGF0aWMgc3RydWN0IHJhcGxfbW9kZWwgbW9kZWxfYW1kX2h5
Z29uID0gewo+IMKgwqDCoMKgwqDCoMKgwqAucGtnX2V2ZW50c8KgwqDCoMKgwqA9IEJJVChQRVJG
X1JBUExfUEtHKSwKPiArwqDCoMKgwqDCoMKgwqAuY29yZV9ldmVudHPCoMKgwqDCoD0gQklUKFBF
UkZfUkFQTF9QRVJfQ09SRSksCj4gwqDCoMKgwqDCoMKgwqDCoC5tc3JfcG93ZXJfdW5pdCA9IE1T
Ul9BTURfUkFQTF9QT1dFUl9VTklULAo+IMKgwqDCoMKgwqDCoMKgwqAucmFwbF9wa2dfbXNyc8Kg
wqA9IGFtZF9yYXBsX3BrZ19tc3JzLAo+ICvCoMKgwqDCoMKgwqDCoC5yYXBsX2NvcmVfbXNyc8Kg
PSBhbWRfcmFwbF9jb3JlX21zcnMsCj4gwqB9Owo+IMKgCj4gwqBzdGF0aWMgY29uc3Qgc3RydWN0
IHg4Nl9jcHVfaWQgcmFwbF9tb2RlbF9tYXRjaFtdIF9faW5pdGNvbnN0ID0gewo+IEBAIC04Njcs
NiArOTc5LDExIEBAIHN0YXRpYyBpbnQgX19pbml0IHJhcGxfcG11X2luaXQodm9pZCkKPiDCoHsK
PiDCoMKgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQgKmlkOwo+IMKgwqDCoMKg
wqDCoMKgwqBpbnQgcmV0Owo+ICvCoMKgwqDCoMKgwqDCoGludCBucl9yYXBsX3BtdSA9IHRvcG9s
b2d5X21heF9wYWNrYWdlcygpICoKPiB0b3BvbG9neV9tYXhfZGllc19wZXJfcGFja2FnZSgpOwo+
ICvCoMKgwqDCoMKgwqDCoGludCBucl9jb3JlcyA9IHRvcG9sb2d5X21heF9wYWNrYWdlcygpICoK
PiB0b3BvbG9neV9udW1fY29yZXNfcGVyX3BhY2thZ2UoKTsKPiArCgpJIHRob3VnaHQgd2UgYWdy
ZWVkIHRvIHVzZSBvbmUgdmFyaWFibGUgZm9yIGFsbCB0aHJlZSBjYXNlcy4KCnRoYW5rcywKcnVp
Cgo=

