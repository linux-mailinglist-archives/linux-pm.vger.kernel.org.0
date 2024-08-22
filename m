Return-Path: <linux-pm+bounces-12762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2E195BE0B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 20:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA241F25CC6
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353861CFEA0;
	Thu, 22 Aug 2024 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4vGQYmw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656451CF288
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350387; cv=fail; b=qDToGWjk4XPTkzUUelaRpKY9g6fX90VdvO1IVR8gXqQb5l3hRIVz53QZ1wOGekvolqGcHrFP0p87bhrL7ZHiQJiSux8KkF7LedVANc9XPPLuw/PArDPIuwDiJVXWooj1XL4u9WkUAgX2nSSfXCBqwVMh7iFR8J1qtml2BLP+hb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350387; c=relaxed/simple;
	bh=ulsVGXF2vXGqHRlkNkD67Nkl/Zq84x2jfS5MAqG/Xg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NG9OfA0jf6fM36iOxGtyMcKMbv85SMKcJKHblAIbPnx2KHc/az0QNQOsXVu9TPuIcDNbby/jwHhF9uOoWSLo1OjAvwKdM3ElWyXbFlR3uEJ3rzw7rAv69ZPON4BLrhNnaYFopY0lZ682aJAA2bcJkQtDItNsU1rzLiZWelBSEHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4vGQYmw; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724350385; x=1755886385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ulsVGXF2vXGqHRlkNkD67Nkl/Zq84x2jfS5MAqG/Xg8=;
  b=F4vGQYmwrBR22F05AJDaQitnYtEbikkPbBQ6YGzvpopyCtySI5ch8ctM
   POefCb0g64P6Yq0+18OU72nmmYBuQzIOeGPWDMdEAwcCx4fXUN8qzXPRN
   iajLrq6DtG6JBbAiykt+peTvbT9ZOJIZfNKl+LiwBAhiQRjGjoy8vQ5Fx
   4OhC2Skgw4D5rx8YIGgtxC4RSDVrCD456XZd7grdlGGINqFDFqwOGxy1s
   VXgYhOFJUC/aNGFB2hiZzFvrFsDoYZc39d1keYR/bx/M7oRMkp75FXL4c
   4GqpK9ydsbm/IliiQhABGev03IogTWDCWfbsUdVLaatjpe1vI5LE7VbiA
   g==;
X-CSE-ConnectionGUID: d50eYnKoQRKR8R3fKLgcRQ==
X-CSE-MsgGUID: Tt2LECF2Rr6CUakeKm9J1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33411230"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="33411230"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 11:12:57 -0700
X-CSE-ConnectionGUID: ZjBo8B89TYeHw9hzBHnorQ==
X-CSE-MsgGUID: iLfY/EkKQualPAc/L1Ii8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="99053158"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 11:12:56 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 11:12:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 11:12:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 11:12:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yh8qNplvCwg2H4FsCF+SYP6NC9e13QVkbHM/X8IHnlJWUs+cz5Mw4EFreSPkPvwVSwITxw5FWJOD6vTxOcKiGh9WDn7tRBbaZDxqGNUMli/5FpguBeoI5NUwo0Tkqt9ay9jo8E8YWukLyYSjxGlxfWVYETetjwW7Ufzu2aHiJw3ajKs89vCjBWCXPMzgbaxbo0Uk3pUx92nFKZ36LjvP+51NgF7DgTx8gr2RMQPnTrvOuVALAcwF5qsjL6XGf3VyAr5ltpHod+7SYmp9QjEF1MKesowRz+ULFzUTpS/jMSVv77tJvBMx/CQGHXsr2JtHAwWYbOf8ZbaGN375Hs21Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulsVGXF2vXGqHRlkNkD67Nkl/Zq84x2jfS5MAqG/Xg8=;
 b=nttLjUfse+uHfoLqp5LyLO3hZkxmpva5HuGYM7G6kxUtQViAd7IjaTWxjzatRAaNi7IJheVpva9h0najcG3sjlOCssBOYCfHS8mljuYh1TxRzudxUk/sgPPDAkgGY7IFkJGYzez05h2rR5TQr7H30Sy/3719/90XoGjoZZce5Dzj/aZfeP4PoX3cRAofVUnuvxYLr3wtNom57ZwzrDXEP1YoLBC6e+k+46M2H4wycKhrmX1JhKhbpMTILnIPq6fqDuKBT74UgVzi7S0/d4+ep61I9r2Gctu8rydq9PezsAjhdEZHSi81/Z8UU4/jN1XabF3zoQkLN1ThdNmjwo1thA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 LV8PR11MB8746.namprd11.prod.outlook.com (2603:10b6:408:202::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 18:12:54 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 18:12:54 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "quic_manafm@quicinc.com"
	<quic_manafm@quicinc.com>
Subject: Re: [PATCH v2 0/7] Add thermal thresholds support
Thread-Topic: [PATCH v2 0/7] Add thermal thresholds support
Thread-Index: AQHa9AVXUG9+if23L0i94LJXXQBhg7IyJwIAgAAgegCAAL9gAIAAKe+AgABS+4CAABH+gA==
Date: Thu, 22 Aug 2024 18:12:54 +0000
Message-ID: <babbb2d4e3d53e7cde77025507ecf9ca3256dc1a.camel@intel.com>
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
	 <1942ed0b96419621583d4a0928883aafd8c2f7f2.camel@intel.com>
	 <CAJZ5v0gW-iaL34Mz2M0gzh-ooDbw=Rp=M_-dt1Ctqhxm3wUGQw@mail.gmail.com>
	 <0494c22b09f9143d2a22e1f0ae2ae79b7d61ab63.camel@intel.com>
	 <CAJZ5v0hbPRGyNYv0LjSjqFiH6uixDtsO-2Dbq8Qi_9fWhSwz4A@mail.gmail.com>
	 <dec10692d8bf72b425509d2ea002eebbd7238ccd.camel@intel.com>
	 <8b832b56-faf3-43d5-88b2-c91b0a0bbaae@linaro.org>
In-Reply-To: <8b832b56-faf3-43d5-88b2-c91b0a0bbaae@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|LV8PR11MB8746:EE_
x-ms-office365-filtering-correlation-id: 1436e8a9-2094-4f19-21d1-08dcc2d60b16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ckVOTEFlRjBaUTk0MlFSQW1DSUN2aDVQL0V3VENBZm9HVTg3ZlZXNzQ1eGpI?=
 =?utf-8?B?WnJqdzdrYzdVbms4MXBzTGJyOUZjSkg4cTM3b21HNk1Zc2MxdkhxVS9teTIy?=
 =?utf-8?B?SGlzUEdVYm4xOEpDWTVjS1lKcDVaZ1hZR3NWK20wbXpEQmsxWm1zTjhuQzZM?=
 =?utf-8?B?dS9oSEpvbjRaVVo5WTlvWVZUOEYzNHc1K3NiYXFkZGk0N1BhSElwRGI4M294?=
 =?utf-8?B?Vi8wVlVlOWhWbk4yaFZiaW9TZGFKWjQrYnRvK2oyM1htU3UzYUhpcm9aUlBC?=
 =?utf-8?B?RUdFaFBnUzZHUnFGZklRVzFHYnAwNGFtb0YxYkxGeUF2TitJZXRTK05BSVRu?=
 =?utf-8?B?VHJDcVRMRFJsSHhJY2ZMcHZNeUNwWXIxZ21ZS2Nib2p0emVRR0RWZVd5NEM4?=
 =?utf-8?B?S1lGb3dJSXp2TzZ2NVhSOHVTNVA2bGRuSFpJOHQvQnpZSW1hTUNwclVSUTU1?=
 =?utf-8?B?Y0ZaUTJaVzUyVUg2OVZHS3VRaUZRa21Kb3FFRGVMaUw5TUZUcGdWQ0txN1hJ?=
 =?utf-8?B?NDdsWEkrZVB0dnZRZUt5Vkt4UEo5QTlHMDd6bkdudjJtRFY5UHlRejFRaEFx?=
 =?utf-8?B?azhWNW5ONTltdjM1RXEzdFZMR25UK1VWTVZxWCtHOGVqQU5kbWxFY2VXQVI5?=
 =?utf-8?B?RVpuT3JIODU0WGIxbm1CYmRiTTZ2NE9QZ3BVQzlxeUhsWXpJRjYzOXEzU2RH?=
 =?utf-8?B?QmRVK1hvb3paZ2hPOTV4NnVlQ0I1U2VvaEErMDJ4L3hUdytEWk9yZCs0T1pS?=
 =?utf-8?B?ODdCOEZDMnZjeTgzRTJPS242U1UxNDNVcVJSUS9hMGpVZlZCb28yK1dpODZU?=
 =?utf-8?B?Y0lmVHkvdk1CT0IzWW4xOXN5UUptaXpyZW80cVppcWxBbzFIWThWVnZQK0VP?=
 =?utf-8?B?YkZlbmNpa3huNmtFcEhpSXhMSUdiYkZpcnlKcmJBcmRyQnNSK3dxcXFIOVd2?=
 =?utf-8?B?b3BlaG4vVTA5ZnlLRW5tYlNqQTgyMk1aTEhCRTF6dzBQMERXeG4vdTVXcjk0?=
 =?utf-8?B?b1J4bmUyNUpEMG5STjRYdFhzTEd1VmduTS92aWEvS20wczl0TTlWVTlKY2Fl?=
 =?utf-8?B?bDNPejhmMGpMczRCOGZpSWd6TDFaaldNVE9sam82d1BERVZvTXcreEF1UXhi?=
 =?utf-8?B?d3I4ai93SkpQQVRwMnJKRmJTNkRvdzQ1c2p3c3B2Sm1ScTRSZ0g2L0pOcWh1?=
 =?utf-8?B?MnJUNXpRR1RVMXdTemF1RkpCRDdBVXpVR1NoWG1ETWczekZ3YTBxdWpxK0NJ?=
 =?utf-8?B?UVZESTBlMDFGZTFwa3A3SHB1YkJ4SnRXc1JXbTFqTW8ySWN3VHo1MGVnbzZF?=
 =?utf-8?B?VTlvSzh3SnlNOHd2ZFlQNlQybXdpaGdUVFJzZEdVcXlpV2FvZXRvVnRXK3RN?=
 =?utf-8?B?amRNTngxczlWSUFRd0NnVWtia3hHUyt2V0pnczFMUUlLaFd3OURabFpSVHJs?=
 =?utf-8?B?aU5ZNEZTbnpKajFObW1DaFVCeEpRTDdmMXhqbW54eXBpdkJuRDVRejNnNmZj?=
 =?utf-8?B?NDkvRk1aVm1ValVNblVWTXFnb3lBTXhST1ZVUnc5anZpRWU2M1NQYWp0ZlBO?=
 =?utf-8?B?VnRNVU1NMkllNi9XRGVRK3JiOFZuTmYydEh3bjY0UWtQTmZPSGp3YzRKZ3hh?=
 =?utf-8?B?VnN0cEprM1dmTUhoNHBsSWszbEo5aFB0bTVYdUdINThoKzJLTmdoY0tuVlVW?=
 =?utf-8?B?Z2M0SlRrbStlRkVrM3pwNGdzQ2UrQzZ1YzhFNnVoRE5BQTBzdENnc0FJWHZt?=
 =?utf-8?B?RjFvTmd1UzZQUFljR05FZjBLdG43eWd2TW9sRlFQQUpraVdubWJ2NVdiWGFn?=
 =?utf-8?B?ZXlHU1kvdEYwajhjbTRsM0tWbkhUNkN5b0Mxbk1DWHcrNTFITHNNem9WV3hG?=
 =?utf-8?B?eGhoRmNxclhVR1hNajdYblFISi94bmIwcmFWWkp1S0IwYmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkJFbkp5bUxDazBZcFBxRzI0eWYydkdWRmZFTTdsL3kzdGFFeWV0ZFA4R0ZN?=
 =?utf-8?B?ZWc4YUFmYVJnVkttQ3FCMVV3SjNmV2JlNkxNcDJaZU1LYTBvaFJHTmNuQm90?=
 =?utf-8?B?bG1YR1dFVHlXYkliWWd4SDQ0bUJUVk40T3NOZWdvSXFSbGsvYzQ0WWZuSjh1?=
 =?utf-8?B?QlRES2hyM3ZUOGpqVWE5UlJJUkcwWUNzRFdudmZndmk5ejFxVW9Eemc2MDZw?=
 =?utf-8?B?dUtweW9GMk1jdkJMZi9KMmlpMktHVFlxUlBEMzVOaDlxVm1NQlV6R2ZESmEz?=
 =?utf-8?B?dG5QWkxENnBLcjZZV1pRM3RMbXJ6ekc3dlYrSzhOUkNyQU1WcU5VRGFBdnBY?=
 =?utf-8?B?ejc3N1Joa000Q1FPb3lkYWM1VHRiSnBNdlJLQnpRbUFpQWdOeDIrNFZJOUVy?=
 =?utf-8?B?cXRPdVJuUHZKeFJ3S3gzNFFaRnFrSEMzZ3JaRE5QVzFoVzJmem9JZjR6endT?=
 =?utf-8?B?eGhWNUw5SFp1NmNKRE9mNVdWNklrWUtKVnpXNzdWL0s4cGtEcG1TMzJRZlA5?=
 =?utf-8?B?TUc4QzJNbTdTUzQ3enVya0ZyeEovSEhyalRDRWNHUlpzQXNrTHZoZGQ1UVNs?=
 =?utf-8?B?aWVvQzlRdXcwZjJVRHJ2Z3YxeXJxczBwdlJwaUtNemNIY0dTdG5mOUVIZTVu?=
 =?utf-8?B?Z1pOem5jRUxzQzJWS01HR1BZUW1iQmNkUURQNzQ2eE1RTzZDaFlhanQxcEVa?=
 =?utf-8?B?U2FiSHF0aGRUNmdNdmRpejBCME9vVjFaYU1KNktVbTJZZE5NVDlsU3NjMWo4?=
 =?utf-8?B?LzR4MmpQTkc2OFhpdHFrd1ZDMHRXZnJLQU5KUUdSUThPZS81b2ZVWVdlWVgv?=
 =?utf-8?B?eVlqa1FkTU80U2xlRDhqd1lMWE8vTTAwZnlHbko2UXhTT0l4ZjVPOXVGTnhV?=
 =?utf-8?B?NUNiSXpHUHl0MzgyNjRxNDBYVDljKzFRUzVqOWVkNkVUaWJIMDQzL1lvVDh6?=
 =?utf-8?B?RzJZcVQ2VTQ1T3JROGFaWGVkR241UFJPUUM5OWNUbnVqQWE0RlZzaS9zcUoy?=
 =?utf-8?B?ZEJmekxqcHhOUlRtUTBhUkdYUlZNa1ZsU0N6QWQzbk11dHlZRmlZV3JNbEZE?=
 =?utf-8?B?ckFodFhXTW1aaTVsdVVpeUdqeXJweWpzbzF6NmtTUjVDam8xakNTdy9HU2t6?=
 =?utf-8?B?QzhDV1ZOdlJZRUJ5aiszLzQrR0dvbDhSb3hmRG1kOFl1ZmNXcm9wTUVQeDJ4?=
 =?utf-8?B?SWdkUlMrRFpkRzdUQW4rcXRhWTV2MTdrT29sQ2ZtMzFLMVd1b3dkMkI4cUJi?=
 =?utf-8?B?WG9MRlpZeElwdW1NZm1HQWFCYkVZSENZVGpFNHhmMGRRVmRCajNna3R5Z1A3?=
 =?utf-8?B?ajVxWlBNd3l5Vnh5NDBlQk56VytuMFZTdUF2bXBYWkdubmNadHV5ZHlTajBU?=
 =?utf-8?B?Sms4N3RiTkQ2bk9jMTBKYmZKK2ZRQS9TcTNkdmNVWE1xQ1RWUmM5V05qT2RQ?=
 =?utf-8?B?VlVqeEJINVdRUCtDMTlLM3dpclZtL3NVYnQrVWhlaHRlL3FzTWx4cVRsMkpZ?=
 =?utf-8?B?aGJ1a1J0QnQ2YkFvVTdOU2gwLzVCeW4zaS9MNytLOUFGd1NvWk9IYW9JY0ZD?=
 =?utf-8?B?VUJSM3A2aGhFN0JzdzJpVkVTQktqWEZjaTlPTWFuVmIzdVBwRUc4VWp4blhB?=
 =?utf-8?B?eENIR2lvdHlMQWpVbC9mNEJvUG8zbCtvK2VYZHpHNzNIZGk5QUNmT0pCMmxm?=
 =?utf-8?B?UnFmRm5CUGVuRXkzTmV2YzZwQnVTM3F5SC9SSTZNUWNEdXNkWWN5eHRzV0pk?=
 =?utf-8?B?WHJjbTQ2cU9acDY1VWl6c1FFS1Y3VzcrUXlzRm1ZOFNSNm0zVk1SYmc2K0Nn?=
 =?utf-8?B?WlNkZWIydG1LbmtOUDBiT3l0OXNGVUlyWGVicEgycFQvUTEvQkY5aTFWRTYr?=
 =?utf-8?B?ZHpHT1JjOUVadFV0eUk5Uy9HUXpUNjV4RjR0T2RLVGt0SnkwMlQrTXVxTWpt?=
 =?utf-8?B?a3NJUkdkcFFzMC9renVmNUtENWxUY0Z2VnRhRkZTMU5kK3NkMjl1QVZRWi9Z?=
 =?utf-8?B?R0YxS2hrWW5FTEt1U0tOUUlDTmhUR0RkWi9QZ2JlMmUrOGZqWjFHTVB4ZUVT?=
 =?utf-8?B?a1dTS1BCNVY2N2x2ekxFZGI4b1lhYlVESElFbFVUVTdia0FLYTJjeEFlbXdz?=
 =?utf-8?B?ejJYZGVyR1hTekNrWUplczlzSHpCdWFDeE91UllOV3ZVMXJhTnMrUEQ1T01k?=
 =?utf-8?Q?qAgitd5h53GwY7O0FoaywcM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD02692B95932A4CB7053994F213F422@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1436e8a9-2094-4f19-21d1-08dcc2d60b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 18:12:54.4152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qqyUGdu7NcmgKcjpakuhrIupyIM4qxuxopvSAcsNClYx259pt1mTTeoH19VSUTcsMAr7BOrkxgzohKhnqYJAyRq+X3Pe2pacNRCl4Jetwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8746
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA4LTIyIGF0IDE5OjA4ICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gT24gMjIvMDgvMjAyNCAxNDoxMSwgUGFuZHJ1dmFkYSwgU3Jpbml2YXMgd3JvdGU6DQo+ID4g
T24gVGh1LCAyMDI0LTA4LTIyIGF0IDExOjQxICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gPiA+IE9uIFRodSwgQXVnIDIyLCAyMDI0IGF0IDEyOjE24oCvQU0gUGFuZHJ1dmFkYSwg
U3Jpbml2YXMNCj4gPiA+IDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT4gd3JvdGU6DQo+
IA0KPiBbIC4uLiBdDQo+IA0KPiA+ID4gU28gZGlkIHlvdSBhcHBseSB0aGUgRGFuaWVsJ3MgcGF0
Y2hlcyBhbmQgcnVuIHRoZSB0ZXN0IG9yIGRpZCB5b3UNCj4gPiA+IGRvDQo+ID4gPiBzb21ldGhp
bmcgZWxzZT8NCj4gPiBXZSBhbHJlYWR5IHVzZSBuZXRsaW5rIHRvIHNlbmQgbm90aWZpY2F0aW9u
IHRvIHVzZXIgc3BhY2UgdmlhDQo+ID4gd3JpdGFibGUNCj4gPiB0cmlwLiBTbyBkaWRuJ3QgYXBw
bHkgYW55IHBhdGNoZXMuIEkgZG9uJ3Qgc2VlIHRoZXNlIHBhdGNoZXMgd2lsbA0KPiA+IGRvDQo+
ID4gYW55IGRpZmZlcmVudC4NCj4gDQo+IEFjdHVhbGx5IHlvdSBhcmUgbWlzc2luZyB0aGUgcG9p
bnQgb2YgdGhlIHRocmVzaG9sZHMgYXBwcm9hY2guDQoNCkkgdmVyeSB3ZWxsIHVuZGVyc3RhbmQu
IEkgcHJvcG9zZWQgc2ltaWxhciBhcHByb2FjaCB3aXRob3V0IG5ldGxpbmsNCnNldmVyYWwgeWVh
cnMgYmFjay4gQWxzbyBzdWJtaXR0ZWQgcGF0Y2hlcyB0byB1c2UgSUlPLg0KDQoNCj4gDQo+IFRo
ZSBnb2FsIGlzIHRvIHRyYWNrIHRoZSB0ZW1wZXJhdHVyZSBlYXNpbHkgZnJvbSB1c2Vyc3BhY2Ug
d2l0aG91dCANCj4gY29uc3RhbnRseSBwb2xsaW5nIHRoZSB0ZW1wZXJhdHVyZXMgaW4gYWxsIHRo
ZSBwbGFjZXMuDQo+IA0KRXhhY3RseS4NCg0KDQo+IFRoZSB0cmlwIHBvaW50cyBhcmUgYSBmaXJt
d2FyZSBkZXNjcmlwdGlvbnMuIFRoZWlyIG51bWJlciBpcyBmaXhlZC4NCj4gVGhleSANCj4gYXJl
IGRlc2lnbmVkIGZvciBpbi1rZXJuZWwgdGhlcm1hbCBmcmFtZXdvcmsuIFRoZXkgaGF2ZSBhIHR5
cGUuIEEgDQo+IGdvdmVybm9yIGlzIHN1cHBvc2VkIHRvIGJlIHRpZWQgd2l0aCBpdC4gQSBjb29s
aW5nIGRldmljZSBhbHNvLg0KPiANClllcywgSSB1bmRlcnN0YW5kIHRoZSB3aG9sZSBhcHByb2Fj
aC4gdHJpcHMgYXJlIHRyaXAgd2hlcmUgeW91IHdhbnQNCmdvdmVybm9ycyB0byB0YWtlIGFjdGlv
bi4NCg0KPiBXcml0YWJsZSB0cmlwIHBvaW50cyBtZWFucyB5b3Ugc2hvdWxkIGJlIGFibGUgdG8g
YWRkIHRyaXAgcG9pbnRzIA0KPiBkZWRpY2F0ZWQgdG8gdGhlIHVzZXJzcGFjZSB0byB0aGUgZmly
bXdhcmUgd2hpY2ggaXMgbm90IHBvc3NpYmxlLg0KPiBUaGVuIA0KPiByZXVzZSB0aGVtIGZyb20g
dXNlcnNwYWNlIHdoaWNoIGlzIHVucmVsYXRlZCB0byB0aGUgaW4ta2VybmVsIHRoZXJtYWwNCj4g
bWFuYWdlbWVudC4gSXQgaXMgZGlmZmljdWx0IHRvIGRlYWwgd2l0aCBiZWNhdXNlIG9mIHRoZSBu
ZWVkIG9mDQo+IHRyYWNraW5nIA0KPiB0aGUgbG93IGFuZCBoaWdoIGxpbWl0cyBmcm9tIHVzZXJz
cGFjZS4NCj4gDQpZZXMuDQoNCj4gVGhlIHRocmVzaG9sZHMgYXJlIHRoZXJlIHRvIGFsbG93IHRo
ZSB1c2Vyc3BhY2UgdG8gaGF2ZSB0aGUgYmVuZWZpdA0KPiBvZiANCj4gdGhlIGludGVycnVwdCBk
cml2ZW4gdGVtcGVyYXR1cmUgbW9uaXRvcmluZy4NCj4gDQpZZXMuIEkgYW0gbm90IGRlbnlpbmcg
YmVuZWZpdHMuDQoNCj4gT2J2aW91c2x5IGlmIHlvdSBzZXQgdGhlIHRocmVzaG9sZHMgdG8gYSB0
ZW1wZXJhdHVyZSBlcXVhbCB0byBhIA0KPiBtaXRpZ2F0aW9uIHRyaXAgcG9pbnQgdGhlbiB3aGVu
IHRoZSBsaW1pdCBpcyByZWFjaGVkIHlvdSB3aWxsIHJlY2VpdmUNCj4gbm90aWZpY2F0aW9ucyBm
b3IgdGhlIHRyaXAgcG9pbnQgZ29pbmcgYmFjayBhbmQgZm9ydGggYXMgd2VsbCBhcyANCj4gbm90
aWZpY2F0aW9ucyBmb3IgdGhlIHRocmVzaG9sZHMuDQo+IA0KTm90IGNvcnJlY3QuIEl0IGlzIG5v
dCBhdCBtaXRpZ2F0aW9uIHBvaW50LiBUaGlzIGlzIGhvdyBzZXZlcmFsIHNlbnNvcnMNCnNldmVy
YWwgc2Vuc29ycyB3b3JrLiBJIHN1Ym1pdHRlZCBhIHJhbmdlIG9mIHNlbnNvciBkcml2ZXJzIHRv
IElJTw0KZnJhbWV3b3JrLCBzZXZlcmFsIGhhdmUgdGhpcyBpc3N1ZS4NCg0KVG8gbWFrZSBpdCB1
c2VmdWwsIHlvdSBuZWVkIHRvIGhhdmUgc29tZSByYXRlIGxpbWl0aW5nLiBOZXRsaW5rIGlzIG5v
dA0KYSBsb3cgb3ZlcmhlYWQgdXNlci1rZXJuZWwgaW50ZXJmYWNlLg0KDQpMb29rcyBsaWtlIHlv
dSBmaW5hbGl6ZWQgZGVzaWduIGFuZCBqdXN0IGxvb2tpbmcgZm9yIHBhdGNoIHJldmlld3MhDQoN
Cg0KPiANCj4gDQo+IA0KPiANCg0K

