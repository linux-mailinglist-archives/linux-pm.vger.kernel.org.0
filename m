Return-Path: <linux-pm+bounces-10054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A059183C3
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 16:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3DA1F23515
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 14:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EFE184125;
	Wed, 26 Jun 2024 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGo2PYo6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DAB155A26;
	Wed, 26 Jun 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411500; cv=fail; b=IKIs5pWOr0wMFI53SapLJ1Qz5e7ycepxpJWwhm2Fcpkt+0/Ufmm1eAblsGn8362lCAPa/BcMbEo7FTUbN7j4P50ZYzdl6pT8YVNjvPITvJf0GkKduWpArnlIMLu86UT2g8Swcn+JH+rSv27WmLTjmDf6bhWKDBjnioQR7yEnVSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411500; c=relaxed/simple;
	bh=/VjA5pncsZuLWrm/YwucXuq0NospMy5uMAH2Vk9u8WY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oDh/JN/4K18+3+EEKDQxi4QdSqLVCqiH6bbpp4K7soD1bDkhJR5b+zQcaZoj1vT5eObWEUjDLVvhaoxdNPna/i+sM+6W7on1ZlVSjd+Bhtyk58sM+vD/XVSPDsLvXwEppLXAKn22zRUtgXNnkzIv+V2FCSizMekm8onVCePSWzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGo2PYo6; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719411498; x=1750947498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/VjA5pncsZuLWrm/YwucXuq0NospMy5uMAH2Vk9u8WY=;
  b=NGo2PYo6AolauNnpx+Fr6O//5+Pwce7vWjxN9EUAOCipQZJ5L1XnzDjE
   8CSC5UIROzP5QPeqHXZdVspk+pgt70RrAhFeV5VbrR434H604mCGniwCu
   CElW1ozdll2i1Rv5S43U+14ZvBE73W/eI66DRg4UmmN904FWSft+NnhYB
   tjtfy1soReV3ZozHXhIPq5tNV6qhs8ATvyx81bwZQQ3KCgTsw79LvdXc+
   gzQj0axUG9ROehC8/IFTgggnBQDsev7OG6D6coCwi+qmUmVHatnzoHTM8
   YsVodEAeEmJfjmimFGZ/o3ZtaiZNWdeomT0OAcGjYh+D2myTw961esJfK
   g==;
X-CSE-ConnectionGUID: CvBrV4HWREa2kasoz0QL/A==
X-CSE-MsgGUID: 83mMQ5XFQKW4Th8v8E7kjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16709893"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="16709893"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 07:18:17 -0700
X-CSE-ConnectionGUID: 3ugCW6l8RqaGq+Sn5fM3mw==
X-CSE-MsgGUID: KV34t0W5QCm427PVdAPYNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="48467263"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 07:18:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 07:18:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 07:18:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 07:18:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 07:18:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Knj9LGyrPWWf8mzssCMJ933uCPUx2/t/eqreAaMQ2eiuG4GX7xLK00LM701uJp7FPNb9GfbaZQ0B/kWJQPoN1QPGrzbMy9p91do1Eyw6wdok7qWDf9IHCYEnDMcUjEQvY2U4jr/22FrS6D+409R9uaV2Fb2hxDqsTIsgBIwaHiFW5HC916CuLFF1dlZ4a4uwpuYD904CFaUbortXizTIxVOXRU/hYKE4h6oI0JBvBFxuTdtKZ5OHxwIVXkpq4+2Vg97HBII1sqI7dRBZi3vi783WgOC+lCbOP55juixxRtB68TdTzk4CQYyQO5Zy1++1RW6y2IXC/XsfteeE/1s/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VjA5pncsZuLWrm/YwucXuq0NospMy5uMAH2Vk9u8WY=;
 b=hkMPelQxaz2SqlQ/xR0LVcGBAugA3anVdj9yQq6hI5ZA5p8DinAYbcC+wGEvGgIeaMpCNULRV7SsVcVuvdmZuhoOJiugN123624NRQU5MpI7fVGmIODB2FvPi8C2qb2Powjm7RF1pRKgMrSbQATykjFXzHh4ZED7pEyFIynQY3UDkOi0TG1zfv7jbl3Dn/ghAooxMvpVTBypdxYhKG5/7d3+8tAqMdO2+pxPCAbhUq9WXOmBHJdcJjNI8/g+SVO4/hyoJDvSb4wDkm2o8D7uDSknsh+sCWMXOVSNcI1mcwsGtvgJLeeyRAgHmR/ZR7zSOznIDvZ0GOApVvaY9EGzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ2PR11MB8321.namprd11.prod.outlook.com (2603:10b6:a03:546::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 14:18:06 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%7]) with mapi id 15.20.7698.033; Wed, 26 Jun 2024
 14:18:06 +0000
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
Subject: Re: [PATCH v3 02/10] perf/x86/rapl: Fix the energy-pkg event for AMD
 CPUs
Thread-Topic: [PATCH v3 02/10] perf/x86/rapl: Fix the energy-pkg event for AMD
 CPUs
Thread-Index: AQHaxfvspfg30Df3+0q1yfc1eqQDo7HaG0oA
Date: Wed, 26 Jun 2024 14:18:05 +0000
Message-ID: <2003fe3c97132e528cb738e6f81f7a3a004fbf77.camel@intel.com>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
	 <20240624055907.7720-3-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240624055907.7720-3-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ2PR11MB8321:EE_
x-ms-office365-filtering-correlation-id: 6023b498-f8fa-4a14-9b56-08dc95eacc0d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022|921018|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?VmlCSFl3MUtGQWpCSTZ3b0Nsei90MzhYRmxqeVRaU2N2ZnJ4KzAvNzhkZm5V?=
 =?utf-8?B?azhNRmczSFFtSHZieVFiU3V0UUdvdzJBRjlZYjhyY01wVFNHSWQ5K3lGSVZ5?=
 =?utf-8?B?aEpwL2liKzhBUE1tWmhkVHdVRzdhcTBteW1iTnE4K1hsMndUcGRsQ0hHQkRY?=
 =?utf-8?B?V2h2NDRKRHRtMTVUVVJsS090SitFYzJNMjcvbFF4WVBQN0JBQzZ5OThtVVV3?=
 =?utf-8?B?a0RYVUswT1ZYWEl5RTVWd0ZLSElGNkcxd0owZEJjbytQRVdSNGpJRndYSWZM?=
 =?utf-8?B?bGN4M09sdHBoYWVuLzUzVkZSVlR1U0lHVk44My9RRzZRYmc0REc0bTJrUko4?=
 =?utf-8?B?TGtwQjlSRi96NS9uMmF6aHBiT2lvdnh0UDRzOXVDdEVsbU9IblRhMzByN3lE?=
 =?utf-8?B?Zy9IeWNIRm5Gc08zQ3JUdTNpTTNDdVlROU1PcFFjVkFrN1BUZFI1UnFxSkNs?=
 =?utf-8?B?Rm5DQy9FMXdXaU5YMDFaeHU0L05jdC9FeVJBeDAyb1VEc3ByZ1pkblpZYlcy?=
 =?utf-8?B?MisyQ3VHbTRZN2d0VGlBK2ZCVnZlOHJtTm84SWZwMURzZW5YWWRBTGIrSzFV?=
 =?utf-8?B?VVBYVGFrczNpWFRDdWRWWGVpZkt5N29UTUVLSFRKMVVrYWFESlZBSUF6VkZl?=
 =?utf-8?B?UDFMamNVTG9CcW9jZHN5VnNXRzIrbFkyR3hBS0sxbXBkZlBVQzFoTU9aQjFF?=
 =?utf-8?B?L3RnQ0JWNmxBVUw2NlhOSWJNbDM1MEYzZmFYY1UxdXBXSkM4UnhUM2RCcCs2?=
 =?utf-8?B?Ni8vZmhsU2xNbjRHOURqZ3BtSGI1Y25mOFlHa3ZqY0VCTnVTNTF4RGY4dGwy?=
 =?utf-8?B?REdPLzBOSDVoQ0RHMDdFeUprdzFpYkkxZkJYT3JiNVV2ZzB3Y2cza2xaRzRz?=
 =?utf-8?B?VHorWGZmcTFxOU83TkdnMUFUMHJEckE3V0djcVd6NmVwZkdpcXBIUkxwdG93?=
 =?utf-8?B?OUY3NDNGZG9JMjVDanlobzdUbGxMbm5Ja1NFNzUzUGVVSGMxSk9JSmN5NU0r?=
 =?utf-8?B?VWFkNU9HMmJXSUttcW9RS3BSQVVpNlE4am9Jd1NjaGdMOWdheTF1azBad1hP?=
 =?utf-8?B?cXo0WTJiOXhOejhRdW9ZR1kyNXJMeGYzd2YyWmFCQTZmOTlwc1o2d3lwM3hP?=
 =?utf-8?B?OG5WOHZwN0E3VnRacmxQREhJK05kbXVZQ3RaME9qekZ6U2FHejhXOXJyWXov?=
 =?utf-8?B?RW9tb3krb0QzODJ2aHViVmczVHJ0RTJSZEVxbS9KSDM4WkVJakx1Q3JKSmQ1?=
 =?utf-8?B?Rk5FWTlhVWMvaS8vL2VFRHFWTmNiRitTejJJeGtQTEMwOXBxR1VJckY0S1hy?=
 =?utf-8?B?Wm1jdlVpK3ZGWXFZUXhqd1JobGZZNjJ2TXU2ckJzV0JoVEdzZVZTZnJoOXVr?=
 =?utf-8?B?UEFxWDN0KzlXRVJiUkFSbHRTN2RDTDNrZHZFRnVLVURCdVRiUkdINFgxNE4v?=
 =?utf-8?B?bUFGNVhPNVNVeldOclZwbDErNUtRYzNlSmdQdTd0TS8xQ0kzZE03bGIzR01Z?=
 =?utf-8?B?L0p4eDgxTVdzRGpyOWN2YmdXcnVtK2dreENRSmg4Y1YvZVprc09EYjVnSGU5?=
 =?utf-8?B?d1RZekgyUmV4NkRrUWpQVkJnTVV4VmMrNVc2S2o2SUtlTktoRXM0Zm5YZFZC?=
 =?utf-8?B?WExreldLVTZ2ZmxER0tEVFNmS2dFT1VZU3lxNm5kdVZUYkV1SjhKUlc1c2tN?=
 =?utf-8?B?T2sreVQ4R2tqYUNEOG1vVGhpMTVJcDNMV3E5SVVGVDAzRlB1UjVDNVp3UHRK?=
 =?utf-8?B?dE1NeVozV1g5QW8rTTQyYm9KSFFlOE9oajZRSU1pOEY2eXdrNjV5RXE5TlB2?=
 =?utf-8?B?QTJxQThRTjY1S1N3MGd1UENweVFpWjY5T0ZWT05wZ0JZL2xEb0t2LzYwbUIz?=
 =?utf-8?Q?KLUHDZjQ3FGzN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022)(921018)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmQxZkR0eVA2YzhScmp1RGozQkJCS0RyUHpTcTlIaTRVbGpRYmJlUmxobmVY?=
 =?utf-8?B?VHZNeDB1ZTQyaHFkZzRnbGU2Z2FHSTRlenN4TnJIamxDcEFkU2l5WnRrUlJk?=
 =?utf-8?B?ZXBqVUJzZkhNSWZuTXNNYTZaMkE4dnlDNWpyS0tOWGxQYkJId1lQRTcvK1VG?=
 =?utf-8?B?MDZsWFplWEFBUWJyUnhMM1g4eGxPNXZEWEFobm80VDR4MlFCS0dZK3orNnhz?=
 =?utf-8?B?b3AvTDkxZ2E4WCs0d2dOR216OS93aFB6WEVEZzZxdXErclV5VklBclVrTkxh?=
 =?utf-8?B?eUJOYXhBSHZ4YSsyYk0zWGpNME9aTXB3M0pKRGlFQnovMzhkSUZTaWJzSGF1?=
 =?utf-8?B?K3BEeTdDWUJPejkvVjJ5K3piTk93Wm1SYTlwZTdhWjlLTm4yc2ZZRkpCQkVK?=
 =?utf-8?B?cW9SbHN4bFlUZXpIYkQxQ2czNlZZYjhlU21iSUszK0c1TklhWVhzamM5QXd2?=
 =?utf-8?B?T2NyM3M2alFmU0pOVlZhOXJ0VUhzbm8wVmpyZkI2Wk5vTVdxZDVUSnZuSTEx?=
 =?utf-8?B?T1ZTM2l6cFBIWjVReE1hSmp2M2h5THRjaElkZU43dmhobEpHaVVMM05IYlMy?=
 =?utf-8?B?WXJRaW15RGpRV0ptVHFyOWZwZlBPM2hucVUrd1lBcEZXNHVwTFhiL25JVXhL?=
 =?utf-8?B?ZjE2R3VoUGJzMTJKZjlsSlVQSFpaeENuL2J3VmVCYm10eEVLREV1bmhrSU5a?=
 =?utf-8?B?SGZGbVljTzY1cStqNkJXVXR1c2xTejIzYVZTNzlXenVGdHRnaHlmWmljUWtH?=
 =?utf-8?B?ZnBYTHA3bzE4QXA1UE5nZm4vSkU2cVRRcVRuRjFHbjNPL2hHYmVHUlJIWnRQ?=
 =?utf-8?B?RHA2R2xzOFJHUjRBZzBQS3ZuUnNtNURVMk8yUlVJOSszbFArUnFwcXV5bk5Z?=
 =?utf-8?B?dWM4TXhqQnNTaXAydmxFbnZaVVM1V0IxVCtIL3B5d3p4MDJXRzV5a3U1c3Va?=
 =?utf-8?B?a2ZYa0lNTW9MNkZXNWJ2eUUyb2srcFBSOVh3M1gxeHJkcUZXNmc1TFVBSi8w?=
 =?utf-8?B?RkRkQUcxOXBiMXZSa09VVW9ndkY3RUYxTDZZLzRSSDhYTzBsM2pmK2pXOE1x?=
 =?utf-8?B?emI0NmNGZnV3clVyY0tUUzg5UkNNcWQ4Z3h2SHFwMVVNZUk4MEZGNU1EYVFi?=
 =?utf-8?B?WEc0YjEwSGl3dUJkYkYxV2szNDRlcU94MUlvV054bEQ1cUtmYVFmNlI4QTdl?=
 =?utf-8?B?RUZMN2dNY3pQSlR0WUtQMkc5QW1uQnl5dkljbUlLaDFjU0phMEEzeUhNOFli?=
 =?utf-8?B?Y2xCdnpqY2V2SlgwODFSQ08yNXovNG5OdlpDMmo4ZFM4L0NZQzlSek5XSlNC?=
 =?utf-8?B?V0VCck9yK2xBNFdrV0ExME9zWHErVGRGREUrSVBnRHpvTjN1SUtETms4Ymk1?=
 =?utf-8?B?eTdDSm45bkxQRVN5SE9YRWR0V1I5a1lmemJBd3ZxVmNSMWtVVGZodlEwNXZW?=
 =?utf-8?B?UUI4cTFiZW5JNnJFY01vRngwdGd5Q25aU1Jwb2lvRmZoU1pJZ2pZazQ3WmNu?=
 =?utf-8?B?a1psdmZGNjV3anNPMDhTb1VSZVZGdXd1YUxQeklDQ2ZUOGd2a0Ria3AxdXZ6?=
 =?utf-8?B?WTM2TmNsK3kvR3BwRVdQUTI2M01UelhpQXVEa0JtNXVFc0NBM3hIK1l4MWJC?=
 =?utf-8?B?SGpZWmJGMTYvRStJV2ZtQm5TZVkzYitKelV4dVQwUnVaWkpUa0R2R081Mm5p?=
 =?utf-8?B?STk4ZUNMUHp6dmdkeG1VVm1CdFpFU0crTTVJRWY4WktmOW9EYUpVWnVCY0R3?=
 =?utf-8?B?Rm9VbWZUd2xCR0pWZXJrMzJwdThwOXZ0Q0hYSHpHZVlJV2h1Y3l3MVRBZ3Fy?=
 =?utf-8?B?VDBPL3FZaGJOd242dENBbitWOHJNYVBKL2hycE9WdE5FMUxoNGlpSUorR2hS?=
 =?utf-8?B?Vy82T2xadGhRNFZmV280SWZaNDJmeStSQkZLVmpXb3Q2d3ZveWN0UmlHcldE?=
 =?utf-8?B?eEEzNU1MYmFjSDcrOFFLeTJZUVIybHh6RkQ4cU04MnF0WDR0SWprWWY4YUF0?=
 =?utf-8?B?bm1iZit5TTZNWHB5WHJhK09WSzhVTGo1Tk83UFBXanZLSmZYcDZYek90ZUpY?=
 =?utf-8?B?a3ZDTUNUUzUwTFpNRUJENFY4RExsSnUvSm42emYxZTNreUo2R09tS1U1eGdm?=
 =?utf-8?B?bHFHNFh6WkFlZDdodTkvUHZ5enJzNGtTejUxZjVZTDlIcFZEaC82V1FHc0Mx?=
 =?utf-8?B?VVM0a1I5OWtobmlNV2xwR2ZhK3ZJVVlmNWhDaHdlMElmUVRiUDJYd2gwZHBI?=
 =?utf-8?B?dy9TcGhuOUxCYWNWclI4bW1LVkN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D72B88FE20FC6245BDDCE7FD14034E08@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6023b498-f8fa-4a14-9b56-08dc95eacc0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 14:18:05.7704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tph/iFdqept3TXP1MqBL87sbeyRfaO/90nlQ6ZTOEr3YzMbrYNqvcV3/KXRvHZKGi0yVGFGZp9+0GDqKhktaVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8321
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA2LTI0IGF0IDA1OjU4ICswMDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
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
IEFNRAo+IDB4ODAwMDAwMjYgbGVhZiIpCgpBcyB0aGVyZSBpcyBubyBjb2RlIGNoYW5nZSBjb21w
YXJlZCB3aXRoIFYxLCBJIHRoaW5rIHlvdSBtaXNzZWQgbXkKUmV2aWV3ZWQtYnkgdGFnCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC9lMWY3MGEwOWY4NWRiZDBlZTNmMzJkZmZlYTM3OTkzZTE0
MTI2OWQwLmNhbWVsQGludGVsLmNvbS8KCnRoYW5rcywKcnVpCgo+IC0tLQo+IMKgYXJjaC94ODYv
ZXZlbnRzL3JhcGwuYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2V2ZW50cy9yYXBsLmMgYi9hcmNoL3g4Ni9ldmVudHMvcmFwbC5jCj4g
aW5kZXggYjk4NWNhNzljZjk3Li43M2JlMjVlMWY0YjQgMTAwNjQ0Cj4gLS0tIGEvYXJjaC94ODYv
ZXZlbnRzL3JhcGwuYwo+ICsrKyBiL2FyY2gveDg2L2V2ZW50cy9yYXBsLmMKPiBAQCAtMTAzLDYg
KzEwMywxMCBAQCBzdGF0aWMgc3RydWN0IHBlcmZfcG11X2V2ZW50c19hdHRyCj4gZXZlbnRfYXR0
cl8jI3YgPSB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgXAo+IMKgwqDCoMKgwqDCoMKgwqAuZXZlbnRfc3RywqDCoMKgwqDCoMKgPQo+
IHN0cizCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+IMKgfTsK
PiDCoAo+ICsjZGVmaW5lIHJhcGxfcG11X2lzX3BrZ19zY29wZSgpwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwKPiArwqDCoMKg
wqDCoMKgwqAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfQU1EIHx8wqDC
oFwKPiArwqDCoMKgwqDCoMKgwqAgYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5E
T1JfSFlHT04pCj4gKwo+IMKgc3RydWN0IHJhcGxfcG11IHsKPiDCoMKgwqDCoMKgwqDCoMKgcmF3
X3NwaW5sb2NrX3TCoMKgwqDCoMKgwqDCoMKgwqDCoGxvY2s7Cj4gwqDCoMKgwqDCoMKgwqDCoGlu
dMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5fYWN0aXZlOwo+IEBA
IC0xNDAsOSArMTQ0LDIxIEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgcmFwbF9jbnRyX21hc2s7Cj4g
wqBzdGF0aWMgdTY0IHJhcGxfdGltZXJfbXM7Cj4gwqBzdGF0aWMgc3RydWN0IHBlcmZfbXNyICpy
YXBsX21zcnM7Cj4gwqAKPiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgZ2V0X3JhcGxfcG11
X2lkeChpbnQgY3B1KQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHJhcGxfcG11X2lzX3Br
Z19zY29wZSgpID8KPiB0b3BvbG9neV9sb2dpY2FsX3BhY2thZ2VfaWQoY3B1KSA6Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoAo+IHRvcG9sb2d5X2xvZ2ljYWxfZGllX2lkKGNwdSk7Cj4gK30KPiAr
Cj4gK3N0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGNwdW1hc2sgKmdldF9yYXBsX3BtdV9jcHVt
YXNrKGludCBjcHUpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gcmFwbF9wbXVfaXNfcGtn
X3Njb3BlKCkgPyB0b3BvbG9neV9jb3JlX2NwdW1hc2soY3B1KSA6Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB0b3BvbG9neV9kaWVfY3B1bWFzayhjcHUpOwo+ICt9Cj4gKwo+IMKgc3RhdGljIGlu
bGluZSBzdHJ1Y3QgcmFwbF9wbXUgKmNwdV90b19yYXBsX3BtdSh1bnNpZ25lZCBpbnQgY3B1KQo+
IMKgewo+IC3CoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCByYXBsX3BtdV9pZHggPSB0b3BvbG9n
eV9sb2dpY2FsX2RpZV9pZChjcHUpOwo+ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCByYXBs
X3BtdV9pZHggPSBnZXRfcmFwbF9wbXVfaWR4KGNwdSk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKg
LyoKPiDCoMKgwqDCoMKgwqDCoMKgICogVGhlIHVuc2lnbmVkIGNoZWNrIGFsc28gY2F0Y2hlcyB0
aGUgJy0xJyByZXR1cm4gdmFsdWUgZm9yCj4gbm9uCj4gQEAgLTU0Myw2ICs1NTksNyBAQCBzdGF0
aWMgc3RydWN0IHBlcmZfbXNyIGFtZF9yYXBsX21zcnNbXSA9IHsKPiDCoAo+IMKgc3RhdGljIGlu
dCByYXBsX2NwdV9vZmZsaW5lKHVuc2lnbmVkIGludCBjcHUpCj4gwqB7Cj4gK8KgwqDCoMKgwqDC
oMKgY29uc3Qgc3RydWN0IGNwdW1hc2sgKnJhcGxfcG11X2NwdW1hc2sgPQo+IGdldF9yYXBsX3Bt
dV9jcHVtYXNrKGNwdSk7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCByYXBsX3BtdSAqcG11ID0g
Y3B1X3RvX3JhcGxfcG11KGNwdSk7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCB0YXJnZXQ7Cj4gwqAK
PiBAQCAtNTUyLDcgKzU2OSw3IEBAIHN0YXRpYyBpbnQgcmFwbF9jcHVfb2ZmbGluZSh1bnNpZ25l
ZCBpbnQgY3B1KQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHBtdS0+Y3B1ID0gLTE7Cj4gwqDCoMKg
wqDCoMKgwqDCoC8qIEZpbmQgYSBuZXcgY3B1IHRvIGNvbGxlY3QgcmFwbCBldmVudHMgKi8KPiAt
wqDCoMKgwqDCoMKgwqB0YXJnZXQgPSBjcHVtYXNrX2FueV9idXQodG9wb2xvZ3lfZGllX2NwdW1h
c2soY3B1KSwgY3B1KTsKPiArwqDCoMKgwqDCoMKgwqB0YXJnZXQgPSBjcHVtYXNrX2FueV9idXQo
cmFwbF9wbXVfY3B1bWFzaywgY3B1KTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKiBNaWdyYXRl
IHJhcGwgZXZlbnRzIHRvIHRoZSBuZXcgdGFyZ2V0ICovCj4gwqDCoMKgwqDCoMKgwqDCoGlmICh0
YXJnZXQgPCBucl9jcHVfaWRzKSB7Cj4gQEAgLTU2NSw2ICs1ODIsOCBAQCBzdGF0aWMgaW50IHJh
cGxfY3B1X29mZmxpbmUodW5zaWduZWQgaW50IGNwdSkKPiDCoAo+IMKgc3RhdGljIGludCByYXBs
X2NwdV9vbmxpbmUodW5zaWduZWQgaW50IGNwdSkKPiDCoHsKPiArwqDCoMKgwqDCoMKgwqB1bnNp
Z25lZCBpbnQgcmFwbF9wbXVfaWR4ID0gZ2V0X3JhcGxfcG11X2lkeChjcHUpOwo+ICvCoMKgwqDC
oMKgwqDCoGNvbnN0IHN0cnVjdCBjcHVtYXNrICpyYXBsX3BtdV9jcHVtYXNrID0KPiBnZXRfcmFw
bF9wbXVfY3B1bWFzayhjcHUpOwo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcmFwbF9wbXUgKnBt
dSA9IGNwdV90b19yYXBsX3BtdShjcHUpOwo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgdGFyZ2V0Owo+
IMKgCj4gQEAgLTU3OSwxNCArNTk4LDE0IEBAIHN0YXRpYyBpbnQgcmFwbF9jcHVfb25saW5lKHVu
c2lnbmVkIGludCBjcHUpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwbXUtPnRp
bWVyX2ludGVydmFsID0gbXNfdG9fa3RpbWUocmFwbF90aW1lcl9tcyk7Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByYXBsX2hydGltZXJfaW5pdChwbXUpOwo+IMKgCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhcGxfcG11cy0+cG11c1t0b3BvbG9neV9sb2dpY2Fs
X2RpZV9pZChjcHUpXSA9IHBtdTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmFw
bF9wbXVzLT5wbXVzW3JhcGxfcG11X2lkeF0gPSBwbXU7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDC
oAo+IMKgwqDCoMKgwqDCoMKgwqAvKgo+IMKgwqDCoMKgwqDCoMKgwqAgKiBDaGVjayBpZiB0aGVy
ZSBpcyBhbiBvbmxpbmUgY3B1IGluIHRoZSBwYWNrYWdlIHdoaWNoCj4gY29sbGVjdHMgcmFwbAo+
IMKgwqDCoMKgwqDCoMKgwqAgKiBldmVudHMgYWxyZWFkeS4KPiDCoMKgwqDCoMKgwqDCoMKgICov
Cj4gLcKgwqDCoMKgwqDCoMKgdGFyZ2V0ID0gY3B1bWFza19hbnlfYW5kKCZyYXBsX2NwdV9tYXNr
LAo+IHRvcG9sb2d5X2RpZV9jcHVtYXNrKGNwdSkpOwo+ICvCoMKgwqDCoMKgwqDCoHRhcmdldCA9
IGNwdW1hc2tfYW55X2FuZCgmcmFwbF9jcHVfbWFzaywgcmFwbF9wbXVfY3B1bWFzayk7Cj4gwqDC
oMKgwqDCoMKgwqDCoGlmICh0YXJnZXQgPCBucl9jcHVfaWRzKQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gwqAKPiBAQCAtNjc3LDYgKzY5Niw5IEBAIHN0YXRp
YyBpbnQgX19pbml0IGluaXRfcmFwbF9wbXVzKHZvaWQpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDC
oGludCBucl9yYXBsX3BtdSA9IHRvcG9sb2d5X21heF9wYWNrYWdlcygpICoKPiB0b3BvbG9neV9t
YXhfZGllc19wZXJfcGFja2FnZSgpOwo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJhcGxfcG11
X2lzX3BrZ19zY29wZSgpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBucl9yYXBs
X3BtdSA9IHRvcG9sb2d5X21heF9wYWNrYWdlcygpOwo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgcmFw
bF9wbXVzID0ga3phbGxvYyhzdHJ1Y3Rfc2l6ZShyYXBsX3BtdXMsIHBtdXMsCj4gbnJfcmFwbF9w
bXUpLCBHRlBfS0VSTkVMKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFyYXBsX3BtdXMpCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT01FTTsKCg==

