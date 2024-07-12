Return-Path: <linux-pm+bounces-11021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE25292F468
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 05:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46182B209A2
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 03:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A94DF49;
	Fri, 12 Jul 2024 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvGUDbKn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F8DDCD;
	Fri, 12 Jul 2024 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720754968; cv=fail; b=egEMvSAS1rWSlGXmJjV38Ff+Hu9CCUeRF1CpjlQ1UWbwYRz010W1BExGO/8KHA9+0WFwSbP+KgaH0LgBEdI5V98oeZk9Z8wunMQeL07RmLuVd9vCF/pyvSVuRNsxe0HhLJ5vUSpZgw/wNV165UMSvdawFRh8SHgfefXdJ8i9x+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720754968; c=relaxed/simple;
	bh=zNRpLMP9SXG3YOptideKgPowPiAj7kWn3WX/uPZpCTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dvQ8W5PUeMzqdCFjXFemi9bQ5JR+YtmnvCzIIiNJDwd1cgRLfMTdWSGe0Id69BrGLToEtOxHKReMzaC66Q4BwGuKQQ8AhA4gHfBQW04nmYEARnHwNXEi3oF71zJqlEw+HbSfkMco7ILMDsUr3Muqiy30jO9lKzYe9sD4q4XzmTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvGUDbKn; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720754966; x=1752290966;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zNRpLMP9SXG3YOptideKgPowPiAj7kWn3WX/uPZpCTk=;
  b=WvGUDbKnk4GXqStBa+H138v6xNTcuc7Os7OEMx2NvGKhxD3dHT+qkNMF
   qLhf62sZ75MmvWx9lWRi2289gu6m/lU/sp7WUUWtXdtnt+l22cwqnS4gT
   qFW2zp+lCOvp+zlYfTAN6mVQiQ4ReoXSftJ5/LksQNP5WYrGbJHoPO1aC
   I2PCaNj4KhK49Z9/IWyTWTSyZ8Ye7+s9F4xBfJi98OkCLQSZvS1WSJOHg
   IVDZ66qshYxC2tD/ptGaPPsbqusAEZxaLtXJpyVgvOcns1QFJuatGanjQ
   PFWyYGmZoRAKIv8l68qFcdVn1G2W9E5PrV/3dQ2LiGWboTj7aw/aBYS2h
   Q==;
X-CSE-ConnectionGUID: D4u8aoFERBmQk2bmElYRQg==
X-CSE-MsgGUID: 7wHixmGjR5WcSpBq3nxU7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="40703084"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="40703084"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 20:29:26 -0700
X-CSE-ConnectionGUID: 012e9ymGT9mxM8h2zd2SKg==
X-CSE-MsgGUID: gx0eLFgkTXuhWBcGqqAE5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="49442517"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 20:29:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 20:29:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 20:29:24 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 20:29:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4X9ER93sXZE47OId1Iqo+WIvc8i1wpZN7+ls+JJpDujsoeRQVFq+Utw7kKyY8LclQorjikQdAKURtmWrOsAY+U5UNbLjl/WqTdejgYkXp3KNiY2+xDsUDkst0BLO1p0IfAYEmgdOhLYYYO0DJglXmkdaNpF5iCg4ho8G6FK5OO88TmKT+85oqW1V8GCnwabs9zouNykPE9zQQ5Bnx7cV9WuEpJQqS+aawIXLMrmNH+tj8ftKhFG455dse32Ux8d9RFC7LTP/46nps67GEmRtTZN51+AcYv7q12lLFFsIfzwVSDEYOIFUqxB3aPHdpDB3Yc7c4U2ds411/aBd9vD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNRpLMP9SXG3YOptideKgPowPiAj7kWn3WX/uPZpCTk=;
 b=irtG5/LAptd+lABqeEJ083FDMHNK+HJqBLokX6lwwJx53e3QFQ6Ij31YE68CoInUhFsL+z1Nx0kA4Ga00fhwjOcGKVbk/W3DcA+fbUUeuNKIhesQXUdXr+62vJMo5A/OfeMXh9mz9pd/t69CoHiYa4CFKHE1tLTZX1jigXTDnlJQKrQ6KjMs5xpLBynv1s/aImHCve9UpSLSMe/5/AWDIGUyUhtpskWrgPsnq5modFWjMok+TJhd+Ld0Hf3fEcYtIa9dX0i070YVKYjftLJYEcWA/OwHkBxAUwraeqhC4BRkspz7P9ehNAn0xrvgR58vMLOVqS/U2pXHQuyJARcYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM4PR11MB8178.namprd11.prod.outlook.com (2603:10b6:8:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 03:29:22 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 03:29:22 +0000
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
Subject: Re: [PATCH v4 09/11] perf/x86/rapl: Remove the global variable
 rapl_msrs
Thread-Topic: [PATCH v4 09/11] perf/x86/rapl: Remove the global variable
 rapl_msrs
Thread-Index: AQHa031kkFdFIloWIkGJgjM14rb4urHycFeA
Date: Fri, 12 Jul 2024 03:29:22 +0000
Message-ID: <dbdc2f6947cfffe0a3dc9a599bb48f31f9e25abd.camel@intel.com>
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
	 <20240711102436.4432-10-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240711102436.4432-10-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM4PR11MB8178:EE_
x-ms-office365-filtering-correlation-id: c43cc0cb-a584-41c6-7c8c-08dca222d249
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UXp5N3luQzRaZkUyT09LNS9BMXd6YTM3aTlPWVU3QkRCak5wZVgzM0s1WXE3?=
 =?utf-8?B?T0hDMkIzRWVub0pBV1JvKy96Nis3RWxPSW1jeHU2V29ieUNvZWlhK2FWMS9r?=
 =?utf-8?B?RjRIUmtDNU9ST3VHeExEd3R6d090ZzA1blRVOUxicFk4MkVFM2hlWElyVjdQ?=
 =?utf-8?B?WjFlWWRZcnNIN0ZIM1pDTTc1MEtVdXRicTNtTldMVjFMdGt5Kzg5alVRQUxa?=
 =?utf-8?B?NWhYbHpTdWUwMTRyQTdLRllRQTdaTGZmbWNSOGY3UnM2WnN4MEM2N2ZvTDF6?=
 =?utf-8?B?d2ExU3ZSRW9lTzV6dTVUYyt6R3RtRG82NXlHNU9qeWw1K3RCK1piaGs5MzBl?=
 =?utf-8?B?NHJoL1VUcUxPaXY1TzI3Tzc5Ri9lTVQzQXJMN0dwZ0IyanpHL3M5b05ab1U5?=
 =?utf-8?B?UWxTbW03OGFaalJPK3JSRVdjWE8vblk1N3ErOFNhVU5WTEJoM1gvMGZWemdm?=
 =?utf-8?B?YTkrdlV2S2ZDVlBVZnBZZmtFc2kyVnRxQm1qbGtoQ0hmek9MZVBEK3UwdFpx?=
 =?utf-8?B?ZTN6STRzWU10b1cxaHZsdnU3aWx1a0twNU9PU0lLcDlTSTM4bW1aNXgxOG96?=
 =?utf-8?B?SzZHdmI2S2tKa09IQ3duVnZoODVyTnI0Y0QwZ25XWGJ0cjhEMktScTRpWEM2?=
 =?utf-8?B?Y0tZcVNNSWZYRjV3WVNiTWZvNWxSeTg4VWk4cTFqRmR1MGJ5NjdqTks5WnI0?=
 =?utf-8?B?VjNNb25xNGxIb0o4eFJ4b3lteTl4N2NlQ1VETGhPUUNuVDN6RzZITmRiTlVO?=
 =?utf-8?B?ZEN0VlhLM0FCZFo2S1N5a1NaVGVORlh3Z2pVdDg5M2JIZ3FRcW5IUUNTN2Ew?=
 =?utf-8?B?eDBxSG5ZU0M3M09Cb1FXWkZPckFRcEpnLzNlNm1SWXVSTTdUNXFOMzhwZ29D?=
 =?utf-8?B?amg3OFNWTmZaYWNmTm9xRlhidzZGQ0Y3aW9oTlpqV29ENS9udWt2MFJUMDNZ?=
 =?utf-8?B?VWJtWWFhS3pLR0s4TkEzTXB2Y3h4ZjRwNHNSMWFVVEtBRkZibi9XcWVidGNl?=
 =?utf-8?B?aE9oQVhWZWVHdE8wVmI2UnY5aElqS0piRjU3UWZWYXpueWVGWmNSbDNRVzEx?=
 =?utf-8?B?dFFpYXROTndvWDB4d25icERLcW1oaG84cGxMVzlpUGU5N0RCa01QeGZ1ODAz?=
 =?utf-8?B?MUJEcEppV2wrdm9GaFNBckY3akRRbnhndW85UDV5QnFWRHNQc3I0N2R4ejE3?=
 =?utf-8?B?NW5DODJ6Y0k0QWZqRmdTUEx2NHhvc0oyNUQ1VGFYV3Q0M25wWldGTnlSbHpr?=
 =?utf-8?B?UE1iYUlOcWo4K0llWTJTRW5LdThFbFBTdDFEWW52OEQ4YXV1dUJicmVCVjJ4?=
 =?utf-8?B?eTlUZDM0NHlBbDhESEpueGR3ZUpTQncwcWdwaTZRREV0T0VwYVp2T2xnZW5p?=
 =?utf-8?B?dittNExrMEN3VFd4enI3blVXU29iQmcrdHNVSUZncHRqa2Z3VDhWdDhjNjBF?=
 =?utf-8?B?R21ETk1BeGNDREJkMWhjb1U3ZVFpbjFYMzFsZVFWM2tKSFJuUDYyWlVqOCtP?=
 =?utf-8?B?ejNNYzhjZm1CdUNBbXJXNTFJdUl4L3lDaFIxeTk2eGdic24za0tDOEw2bFVm?=
 =?utf-8?B?c3VOajYzRVZ4U1Y0dERSMG9DcnpBaWRSMU9XL3dIWjlCVjdHZHNUNkFuS0RK?=
 =?utf-8?B?L0xOQithbVZjdlI4N2JheE14ODNYbS9iVE5KY3d2ejNuZ2hTMkVZZGx6eU5B?=
 =?utf-8?B?L3J1djZEanNLVFRmZFg0bXhwcUVWeXVvbFd2YlAzVXM2dEYyUHpEbGtpcG1a?=
 =?utf-8?B?dElsMVkxOEY5N2ZlTVFwVWhmV29qbUlhTHhuNnQvdDlQRytsUGFGNlJvaVlU?=
 =?utf-8?B?TTV5L3RNUHg0VE1QdVV4WnpmME5qKzl3Yi9uZEtsdHBBOEhKcnFaM2hwd2J4?=
 =?utf-8?B?OWoraEowL0l3aXpTNE9JeG9RM0FHUW5abllJSHRsWUx3UlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEorbTlXeXlaaFZmQ1czckhOK0hGeUFuWTBWN1dSekwrQXc4WjRnSW54YlVj?=
 =?utf-8?B?YVpMYStmWFRsb29wa3lkbHpmV1NuUzdVT2xGR2xNK3RBS2t5L093eURMUUMv?=
 =?utf-8?B?TjdJR2x2MUJSbVNZVXJvWEx2MFRPdFBiWlB0cm1wbVpQMHJrNzlBelJQalZ6?=
 =?utf-8?B?cDRXUGdJREJybW1BRkxheHM4RzlJTWdWb3lCTjhZRWdaQ1UyZUxjUnZWM0xM?=
 =?utf-8?B?S2QwTENRL2ppVTU0V1BEWVYzQ3JsNXNoRXZpV3pPeEJZbGxzbGRXRDYwbFBM?=
 =?utf-8?B?TkJycHJMcFNCYWpKY0NNaDM4Y1FTbDlsZHRJcHYxblh1ZG5INytJRlVJVlVW?=
 =?utf-8?B?YUZPWDJ0amlVTytLZ1VwaWRjQTJJWDhzVFJFSGtacnFvdXQ0L2tIczM1TTVv?=
 =?utf-8?B?THpNay9CaldJbkJRTkRvL2tVeXNiYVUvSTMwTjJQallaNnQzNk5SWkV2ZlU3?=
 =?utf-8?B?NkhsM3NzeFFIeTNONG5kSmcveGdVUldXdndOL1JJbXl6ZS9aNFR6REx5SlN2?=
 =?utf-8?B?Ri9RcDFGTnhySUcxN3pUd3pSS1FISlM2akNPU2YrQnpjRTNVSTAzUERJT3or?=
 =?utf-8?B?d0YwcEo1RUpSZmMyc3JxMnVnTU55SzlpMjBiT2ZqYkI5eWpxSE5SQ0drMnVq?=
 =?utf-8?B?RzdIdTVtRENKVTU5THRvamNUUUhRTm1DQmhkYW5kaThoUlJRK29UQ1luUm9G?=
 =?utf-8?B?dHlyelJuMzNxWVVhVk5wcGU2SnFVbTBoaDBkMzNTMUxxK0lvak1hem1SZTRG?=
 =?utf-8?B?MW5GMUhMa0xOeVJEaTJqYkdaMktUTUxZMXdiQnFqNjhyNnUzVWVaTHA4OXBQ?=
 =?utf-8?B?NTRxNmNTL3Q1UUZuR2JzdE82Y0lHRHdlNXNMdVdURnY2UkdMU0NDWnhLWUNO?=
 =?utf-8?B?dnBtdjNqSDJKUitudklLYkROS1l2QS90R2J4OGZTUzVQT2FweGliU2NhZUh3?=
 =?utf-8?B?dHh5RXpkeEFyTC94NVgvcFQyVDJiRnlUWndGY1RFS1JNWXY3bm1qWkU3RTls?=
 =?utf-8?B?bUlVY2lNYUYya3RtdDZELzRLTnhGNGtScnI4MGEwTnlzNnQ5U0p1M3J0WmN5?=
 =?utf-8?B?bHFQWUtkMnhhYkFzRTA2TlRFR2RHU3VKUTZ1SEtGY3NQeE5GY0YyS0x5aitZ?=
 =?utf-8?B?cTJYS0ZMa204a0RQVW92SlZZZHdyajRmVjJidzBPbVNveTNVaXVOanNyejlP?=
 =?utf-8?B?dFZFcHdheFBZR1cyWmZoZEppaDBIT01yUHZXUXFQb2Npc3dQaFNUeEJQQUxw?=
 =?utf-8?B?ck1SRDliZ3NUT1hLZ1pOTmJ6VktYSERVODMrRkFPdzdUaVBlUnFnLytxNG44?=
 =?utf-8?B?YW8xRG9EalAvTHVVbHRKZFpzMmF4TUh3Z3FzRmt6aDFTZnYxclBnWnZlRTlG?=
 =?utf-8?B?RkJXVHU0anE1a2ZFSklkWEs0d2NDVTE4N2lsTTFxYWZsM0wweXJuc1dTVXJs?=
 =?utf-8?B?blZjei9McGMvVkM4eFF1ZkhlSTBtRTJwbGJPMnZhRkU2UHovc0JiQ2pVd3oy?=
 =?utf-8?B?UXJ4d1hmYWgreXYvc29vMnNiSmFNbGxyZzc1WXFISVZJV0FGaTJFdUMycmNr?=
 =?utf-8?B?UlBacDVFWFREd1lYRnl1NTM1RkxZMnJLQzlQUWV5L1R0YWpJUG1vRWE4Q1M4?=
 =?utf-8?B?emRSWDNRSVptSHFjcEZFNkZ3UTZCWlpmcW0zVFNmaDNYMmRHWm9ZMXg3WExG?=
 =?utf-8?B?NzFPSjgxdFhDUzBkUEloSFNhRjJveS9OTW9VMzhEa2NLUW14VU5DWnZwTVRl?=
 =?utf-8?B?K1REZko5N285VjdxazN1aVdrdWZLUFYzU2Znd21HZllWU1dRRkgzNUp0THJ1?=
 =?utf-8?B?VGdDcFkyczU0cG5rQURaUjh5dGQwU2tPbW10Vlk4bGxleXYzMXB0REZSZDQv?=
 =?utf-8?B?dmFjNXNoc09oZDZ1TjJ2azZ5SkxobllINHh4SnJnMUM0YUpXcXNLb3Y2V2Mr?=
 =?utf-8?B?dWhFWlphSlYxbWMrVVAzcGtlTVdGNTNZWnRZOWZXelpPdWtFUUlJaStVbzFL?=
 =?utf-8?B?SFpsT2hpQUtLdTV6TWQvdkFoT3lrbUkwSUJ1aXdiRGMzNVBDNGg2R1lLUjRm?=
 =?utf-8?B?YTRsbUtvWVA0OW5XbnpUUXUxZGFvN3hyQk8vdWRuVjhDZnNyd2tpamhwT2xB?=
 =?utf-8?B?T0s0ZFUyT2NzNGI4WE5YU3RYblgwb3U3aW94aVhkMUI0UVMxa3JFM0kvbUtD?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A601F8E7E7566489F08D63438ABB3EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43cc0cb-a584-41c6-7c8c-08dca222d249
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 03:29:22.0231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zDuAX2UF3WL1MbWLkeLFMmEKuaFm20KqdvFISFkoUdHbvdvk2ruNwfIL5Q5jTI/rmk27mzq8yXFqfzCk8dQJtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8178
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA3LTExIGF0IDEwOjI0ICswMDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToNCj4gQWZ0ZXIgbWFraW5nIHRoZSByYXBsX21vZGVsIHN0cnVjdCBnbG9iYWwsIHRoZSByYXBs
X21zcnMgZ2xvYmFsDQo+IHZhcmlhYmxlIGlzbid0IG5lZWRlZCwgc28gcmVtb3ZlIGl0Lg0KPiAN
Cj4gQWxzbyBpdCB3aWxsIGJlIGNsZWFuZXIgd2hlbiBuZXcgcGVyLWNvcmUgc2NvcGUgUE1VIGlz
IGFkZGVkLiBBcyB3ZQ0KPiB3aWxsDQo+IG5lZWQgdG8gbWFpbnRhaW4gdHdvIHJhcGxfbXNycyBh
cnJheShvbmUgZm9yIHBlci1jb3JlIHNjb3BlIGFuZCBvbmUNCj4gZm9yDQo+IHBhY2thZ2Ugc2Nv
cGUgUE1VKSwgaW5zaWRlIHRoZSByYXBsX21vZGVsIHN0cnVjdC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IERoYW5hbmpheSBVZ3dla2FyIDxEaGFuYW5qYXkuVWd3ZWthckBhbWQuY29tPg0KDQpSZXZp
ZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KDQotcnVpDQoNCj4gLS0t
DQo+IMKgYXJjaC94ODYvZXZlbnRzL3JhcGwuYyB8IDcgKystLS0tLQ0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYvZXZlbnRzL3JhcGwuYyBiL2FyY2gveDg2L2V2ZW50cy9yYXBsLmMNCj4gaW5kZXgg
OWJlZGVkM2Q0YTE0Li43NjkxNDk3MDQyZTkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2V2ZW50
cy9yYXBsLmMNCj4gKysrIGIvYXJjaC94ODYvZXZlbnRzL3JhcGwuYw0KPiBAQCAtMTQ1LDcgKzE0
NSw2IEBAIHN0YXRpYyBpbnQgcmFwbF9wa2dfaHdfdW5pdFtOUl9SQVBMX1BLR19ET01BSU5TXQ0K
PiBfX3JlYWRfbW9zdGx5Ow0KPiDCoHN0YXRpYyBzdHJ1Y3QgcmFwbF9wbXVzICpyYXBsX3BtdXNf
cGtnOw0KPiDCoHN0YXRpYyB1bnNpZ25lZCBpbnQgcmFwbF9wa2dfY250cl9tYXNrOw0KPiDCoHN0
YXRpYyB1NjQgcmFwbF90aW1lcl9tczsNCj4gLXN0YXRpYyBzdHJ1Y3QgcGVyZl9tc3IgKnJhcGxf
bXNyczsNCj4gwqBzdGF0aWMgc3RydWN0IHJhcGxfbW9kZWwgKnJhcGxfbW9kZWw7DQo+IMKgDQo+
IMKgLyoNCj4gQEAgLTM4Nyw3ICszODYsNyBAQCBzdGF0aWMgaW50IHJhcGxfcG11X2V2ZW50X2lu
aXQoc3RydWN0IHBlcmZfZXZlbnQNCj4gKmV2ZW50KQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOw0KPiDCoMKgwqDCoMKgwqDCoMKgZXZlbnQtPmNwdSA9
IHJhcGxfcG11LT5jcHU7DQo+IMKgwqDCoMKgwqDCoMKgwqBldmVudC0+cG11X3ByaXZhdGUgPSBy
YXBsX3BtdTsNCj4gLcKgwqDCoMKgwqDCoMKgZXZlbnQtPmh3LmV2ZW50X2Jhc2UgPSByYXBsX21z
cnNbYml0XS5tc3I7DQo+ICvCoMKgwqDCoMKgwqDCoGV2ZW50LT5ody5ldmVudF9iYXNlID0gcmFw
bF9tb2RlbC0+cmFwbF9tc3JzW2JpdF0ubXNyOw0KPiDCoMKgwqDCoMKgwqDCoMKgZXZlbnQtPmh3
LmNvbmZpZyA9IGNmZzsNCj4gwqDCoMKgwqDCoMKgwqDCoGV2ZW50LT5ody5pZHggPSBiaXQ7DQo+
IMKgDQo+IEBAIC04NzUsOSArODc0LDcgQEAgc3RhdGljIGludCBfX2luaXQgcmFwbF9wbXVfaW5p
dCh2b2lkKQ0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgcmFwbF9tb2RlbCA9IChzdHJ1Y3QgcmFw
bF9tb2RlbCAqKSBpZC0+ZHJpdmVyX2RhdGE7DQo+IMKgDQo+IC3CoMKgwqDCoMKgwqDCoHJhcGxf
bXNycyA9IHJhcGxfbW9kZWwtPnJhcGxfcGtnX21zcnM7DQo+IC0NCj4gLcKgwqDCoMKgwqDCoMKg
cmFwbF9wa2dfY250cl9tYXNrID0gcGVyZl9tc3JfcHJvYmUocmFwbF9tc3JzLA0KPiBQRVJGX1JB
UExfUEtHX0VWRU5UU19NQVgsDQo+ICvCoMKgwqDCoMKgwqDCoHJhcGxfcGtnX2NudHJfbWFzayA9
IHBlcmZfbXNyX3Byb2JlKHJhcGxfbW9kZWwtPnJhcGxfbXNycywNCj4gUEVSRl9SQVBMX1BLR19F
VkVOVFNfTUFYLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZhbHNlLCAodm9pZCAqKSAmcmFw
bF9tb2RlbC0NCj4gPnBrZ19ldmVudHMpOw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgcmV0ID0g
cmFwbF9jaGVja19od191bml0KCk7DQoNCg==

