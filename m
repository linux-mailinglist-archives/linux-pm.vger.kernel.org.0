Return-Path: <linux-pm+bounces-18481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B50C9E249B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 16:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105E7161340
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2811F75A4;
	Tue,  3 Dec 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJUTCY0p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEB81F8924
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240554; cv=fail; b=f7M6DcG7lA5iv0lKZlLY4k/wiaR8Hk5a5Iq9HEG/3GXsXRFFsnaJhk41n7BFkK8yCg3WsHVIkz8uNrnQWK3/szYm8It3cmF9i8yU+1RLPammKqjNU0Tnm6zaAGvcv+rcVwQmV9rCrpLDmlLPaNVPbLRNQbZy/Tn0C2uwxZx6nm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240554; c=relaxed/simple;
	bh=pIl39VpAht7g3+pm+REoMB53kwr6eORWB//IXDqe0m8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eetix1rI633IpGt7x+ucUBr+U1pqb22fSHcedquXYLSosbZJppvSOL58pOLMIXc/qfBkmiJQoVwQ+g9razGK6ipNidNCHNdc/+S2nnAkK3+i3pXEriRZQIZ+0zyfI3Swu72hWj3BxlL8oJ8cm/zUH2aOEsuthnBoajqHBq9Z49g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJUTCY0p; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733240552; x=1764776552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pIl39VpAht7g3+pm+REoMB53kwr6eORWB//IXDqe0m8=;
  b=jJUTCY0pEsBXuI/h1ksYy1AAHAFjAC5HmMlQ59ABP5D1ZoCskTzE1xWW
   3ioIHdJp9flYWfX31LSPNetmEh2+cv3iGOex7bc8cgo4qaPTuqGbgorNi
   NJErQwTgz6dwLi5u7DPRm+kGZfqUlMZJiJiI1BpNugZJDq6eT6Jvz54nY
   NXJTrRS8COUFW/qLU7jCHdWunEAh0svQziu1GqvgTnWY5JceDWiyfIpDU
   UC/BRYG1buc/lS/B0QfcXc1QJIuTEyRP8U0Rrcjv+TPPLPkLXTwi4yGDM
   cchPonmDppz3tyGyFAJ7x1gviPOZYKiilBiFrELUDuwShIu04A2gGvZwH
   A==;
X-CSE-ConnectionGUID: sg4oSGDWSbOM0gYTFQvyWA==
X-CSE-MsgGUID: YdsLdbUaRVOOrizPInAtxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="32820040"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="32820040"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 07:42:32 -0800
X-CSE-ConnectionGUID: 22rQIinXRe6b/fDTe0Iqcg==
X-CSE-MsgGUID: 8fxyT5QzTgqZ1he3HKK8ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="93362522"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 07:42:32 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 07:42:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 07:42:31 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 07:42:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPCW9UWieGa3tuFuP9gerio+xLYevZaKHe72GljQm5lB3vYZYLEa/4U24hXBmTo+FqBCjYlnAYYu8r+RnIzxrjiu2jZXZ9aKrjSdQwiD6z4XhpChIfW/jWzyhRkDuKj8bx56UtntgIeWg0f34+vf/0Oybo36rh5HKdpYRxbdz8ZYG18RNQKRUb2DSLDKSkSH5Z87IeXDGoVJkWJTAfz+JLBA3fVQCR9xqqcrFsNWWOvR4py924GB0MugNXG+T+qJZM5TvRXDoZg9dQuQGT4K8bOLNqMqvlrPz3vVT+AyfkgE4BqBsOVLAT3JCnwU4iHW5EpglBYEZ4zjN+uFoU/MUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIl39VpAht7g3+pm+REoMB53kwr6eORWB//IXDqe0m8=;
 b=uO8wdC2Gei7Ssz7IRaWKz7nfTaP11JSQDhFwyXF5xTE6P7TT0vs2ybZIkEBfQDbouWehzqDBhqNq6OL6njSFQKouT2GG/kKPAsltnB9UC35nDnsR5Hwsk+GBzJgLbks+KgasX96eBtX7auUrtoyoyjO3mwsYo3ltB/wy+vCIkS0T/bCkj8NEJK5XsuWds7wTfKtywOzBl5XQRqj/ewLgsx0yBtgfSKslsueKHbmLKzafQg+haLLAQSVs2v8RWB6UgOgOQrEzxmjZ2jWiqAu4q8fp6UllQnk6sD5e6eQOKQkcZRvaUzFk8pF3bcjmuPI+t7y0kW+675e0AgvnClKoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by SJ0PR11MB4960.namprd11.prod.outlook.com (2603:10b6:a03:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 15:42:23 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 15:42:23 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Rafael J.
 Wysocki" <rafael@kernel.org>
CC: "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Coelho, Luciano"
	<luciano.coelho@intel.com>, "Saarinen, Jani" <jani.saarinen@intel.com>,
	"Nikula, Jani" <jani.nikula@intel.com>, "De Marchi, Lucas"
	<lucas.demarchi@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Sebastian Reichel
	<sebastian.reichel@collabora.com>
Subject: RE: Regression on linux-next (next-20241120) and drm-tip
Thread-Topic: Regression on linux-next (next-20241120) and drm-tip
Thread-Index: AdtFPvBukA2w7biuRBKjE+4t+kPk7gAAkQcQAAOfroAACp3TAAAAUkEAAAU2ZoAAAJkJAAABhCTQ
Date: Tue, 3 Dec 2024 15:42:23 +0000
Message-ID: <SJ1PR11MB61295BDE8405A1A5FFC1CB7FB9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
References: <SJ1PR11MB6129CCD82CD78D8EE6E27EF4B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612965ACA3E84745346F0400B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <5e405ad4-34d6-4507-978f-3d81d4af2455@t-8ch.de>
 <CAJZ5v0iXKvaxz-hmW2+qwTcSmtPJ23Hv04CMnmT=qPE0ytNwLg@mail.gmail.com>
 <56d574c6-6eab-4388-8cb8-70cd615a8941@t-8ch.de>
 <CAJZ5v0gFwu+6Cm7ORs7+TAc5jzXZRBO1uGcttBTTvK4OqT3Q6g@mail.gmail.com>
 <2ad31476-3f37-43cb-96cf-379d50d7b799@t-8ch.de>
In-Reply-To: <2ad31476-3f37-43cb-96cf-379d50d7b799@t-8ch.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|SJ0PR11MB4960:EE_
x-ms-office365-filtering-correlation-id: 4caa3091-d897-462b-24c4-08dd13b11487
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?engzVnhjVG1iekZvaG1jaXNRYnZXazFlVExUdmJtZUNBVWN4VzRHM3RsMHpQ?=
 =?utf-8?B?YVY3dmk2MmMyaUFFaHM3aitFU28zLy9UbThPYUdHOS9ORW5lcXdCM1FKS1Mx?=
 =?utf-8?B?U0VWRlhGeFk4VlpOWkN0UDROeTFvTElHdGM3ZXJNU3VtbGNEbGlnR0JNUlNL?=
 =?utf-8?B?ZnVIOStOcHp6QjFBVjl6dWhPR3l3eEt1RWRjSmd4T0ZuNm9qMUd0SjUrbkdQ?=
 =?utf-8?B?SG12WkVIWWxrSmt1c1dxbnd3RHdkNEU4bmVxUk15Z0lsaWdJbzZwZFpxMGV1?=
 =?utf-8?B?NmoxR1FkYklRUEtSdkdzTWpZOTZkRTJ6OHB4ZHYybHB2UnkwcUl6TmlITVJi?=
 =?utf-8?B?bnNJS2p6cHltbEgwNEY1MytsdUZ0RnpqMG9MNldnWkJwc2I4VmpkTG4rZzBT?=
 =?utf-8?B?bHVSVW1tVnhPTHVBUlFLNCtaSmNlNHpEVk1PbjVzZ3RTZ2VYZXlTZWlDR2p2?=
 =?utf-8?B?UFZQQWMzYzNVQmVLQTF6em9QK3NXVnFUVGI1dlczcGw5d0pvdHQzVkVWMEo2?=
 =?utf-8?B?a3V2aUFnd0FEak1rZlY3c05xSUp0bVlqVkRFUVFZT3I2L1IzWmh3Qk9VOGd0?=
 =?utf-8?B?czQ0NCtmVkRWdHdpN1Bzc1BlYnVVck80Nm4rbE90MUhaNThWWFRqbjUxVXlG?=
 =?utf-8?B?UlVMamNpVHZCMjZ4ekw5NzljQkJrNDFlaDA0OEc2eVd3UHp5OG81b1VVeWRm?=
 =?utf-8?B?SDFUYndRb1cwcUtBYTlWSzlkLzdldCs2RnRkVXoxQjFEWWs3dU5WdnNBT1Bj?=
 =?utf-8?B?bGNsZ2RPZzR4clg2OVdLdk1BUHhTVTkxRVhhSzlhQmJPRE1wbjByVWFYNmJL?=
 =?utf-8?B?OUdkRGcram1USWNBTWxVVmpNRmJNZkVrUGszbVV2Q0Jmc1cwVlZVVDZobFF0?=
 =?utf-8?B?OUNaYS83ZGthU0VvYWkxYWVMQlliQlR5RjViRXFQZ0pNdGI3bm1xcHZtckhV?=
 =?utf-8?B?eXcxOS9UMnUzWVBqM0JIeERoOTVTd3Uwb3h1WHlKS3VxMzc5SngwaTVqMHc4?=
 =?utf-8?B?RkErZGs2N25XQm9vNURwWWJ4ZG1IczBHNVh0M3lQNXJlZklWQit6N2liaEFh?=
 =?utf-8?B?TzlSdUl2OS9zQVB1WTJNbUxUanR1L0diSFhDOFg3VVJyWFl6Mm9mSFRkdUZC?=
 =?utf-8?B?aE55TGRVd3JBZVdnekxSRlFkOXM1N3plUUkxT1Jna1VMTEtZNSs1d3dBQlJW?=
 =?utf-8?B?NUFDSzR5eWYzUmg3eXZOaU0xbGIxejVhUUE1aU92MFpxbHM2TGVnZzk3RnV4?=
 =?utf-8?B?WG90RDYzdkJtRGowQjJWWDZiUUd3TkIvU2c3YVhud3Bmc1JCa1I0T2t6RmdX?=
 =?utf-8?B?VW9XOE9sWWhUUHNTQkhqUXNGU2dnMlFIYklRblMzdW9Sb2dUMXVhaGZsb3dp?=
 =?utf-8?B?K3VtNGY5NW5LOWZFejdROEhqTDZsbklsUnNmZlc2T2RuT1NxdE9nL1ZNazJG?=
 =?utf-8?B?Y2F6QjZuODBWWlpEc01ncGVnTlpVM2hUMzEvWG42Y3k4U2d3ODRidmhOcHNU?=
 =?utf-8?B?TjJhNFRuZVRyZ3pieTdpMU9POXlYVElzM3RRTko2REhOZlJPM2ZyYjgxcUIr?=
 =?utf-8?B?dHRKR1hpN0w1aktmN0x6U20yUWxaSmYyMllZRGI2MlpVaWNHWjRMM1pJTWJY?=
 =?utf-8?B?ZjJPTUVvWW5tVXJRYktHUGszN2V3SW5mL3JOcmFZQWhUZVVaR054bWhuZnV5?=
 =?utf-8?B?dDVhUmVBaUJJcnJ3dFBEUGlTSWZJS0xkdWtFbi9jZW9iRFJSR3puVzlMTHM5?=
 =?utf-8?B?cFBURVg0TzFiRjJEMUYvL1pTT2VJc1ZNaDhady9wTE9LVDNsdzYzSHR2QVhr?=
 =?utf-8?Q?ie/fu0Exc7aISx0R56+U9DjFGn7lOpnRcAjsA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTI2VEdOMW1OeEE5OVpqbFk2ajdBZkxmWE9WMUlJRXBFd0lNeWptRnRFU2Vn?=
 =?utf-8?B?WXNSTlhnOUZzZ2grQWJ5QUdaNVdJOHlGOFJqSVpKVmxldWhmS3dHMDhaUys1?=
 =?utf-8?B?Q0ZHV1lwdWYyTGw1N3pZTDFOSEJFc0gwbGZFS0VkNkxjdnJxa2xQMk40YzR1?=
 =?utf-8?B?U1d2SjBubkNITlJzNnFtTG5zNDlzQ3JrL0w1ZzZRQXArcTIzZG1uZHlZOVlv?=
 =?utf-8?B?bUY1bzVuN2IzL2hGcDhnQVl3STFhQllreURDaE5rVHd4MzExdGxBWnF0d0dv?=
 =?utf-8?B?NzF6TFE2WXB5SEw3UTFLYmpGZ1daY0JHL2VSbFZzRVVBUE8vcG85VUV2L3Mw?=
 =?utf-8?B?Tis0ellVMERKcnoyN1V2UG9RQURIUWxuSUU1T2xHWGpaa1lhOVlYNTdWUWNS?=
 =?utf-8?B?UGh6amh0dnNHRm50bDBuWUpxSTFGcU9VS3dkZGNhMDdoUG1sWVI4SndJWVlN?=
 =?utf-8?B?bmY4SDJiSnZKR3lPSHNYbzRoRnJZY3d3dWhNcWYwZkNnTFZsSm5WelFFRTQ2?=
 =?utf-8?B?blJuUXUvanVtb2tlR2txNTJOR2lCbUl1TEJ4amVra0Z2L1dLaEpQSTlEMG9y?=
 =?utf-8?B?SXpOQVJPZlN3Y2VsWnhQMTUzZ0RadmM2d053Q2lxbWRQYmtGV0QyNWtrV2hS?=
 =?utf-8?B?OW5CZi9vR0YzMzRhTmNEZ0U5Z3NuQm41c2xyclV4K0dWa3JLbnVCaDhaYUFV?=
 =?utf-8?B?UTBKWW0xVksrMldDWlV3bEJkTVlGNGVTc0FHV1FDUFpWMlJoN1pLaEhGUFZM?=
 =?utf-8?B?bFZ2NXBaWGo4Zmp4b2pJbFZOU3lwcmIzQzhBSVhzK2ZiSTRkaVZHdGhyQ2V5?=
 =?utf-8?B?Wk1GR0FYamVuVGFoK1Z1WnNvenpsYkRka1F3ejBEelBGdVBOR2pUbUU4dkhn?=
 =?utf-8?B?QnBYMXBiQXRlcGFuYUJuS2dadjlzb3VveXZSVVVud25ZbGNZRVFRUy9Pa3BE?=
 =?utf-8?B?QXpvVEI2aFRKbVFuQWRWMVhZRlgvM1NpVzJLVklBRlNLK0IwSUFLRzhFUnJy?=
 =?utf-8?B?M2ROUk9ScUZoZk8wN2J5Sk91RytMMXZYSXMzVVpwcHhZQjBwdGwxTmx5V3ZU?=
 =?utf-8?B?UnFqOTNDcjNieG5vL0hlRERRd0w0dmRHTmlsU0VXVFgybEZkMEJsRjE5czJU?=
 =?utf-8?B?bGhmNkY5eEt0bVZlQ1c1NklrY2NrTG5icEpJQ3JYb3l1ajFhYUZnNkVtT01o?=
 =?utf-8?B?RFpGRHR4ZlJYMkllbENvakpaWnF6cTd6UWFvTUFmcC80OEdLWnQwclJIQkdU?=
 =?utf-8?B?by8zVkUrS3I0cCtRM3dQelE4ay9VV1VVZ2FrSXlyTitlQ3l4QStFQWlMSFUw?=
 =?utf-8?B?Y1VPeFZrcEtETlF3WUtNQ3JCSmphUHI1QnBob1FvNkduRHJrdisyWkNycFhT?=
 =?utf-8?B?RU5kckZtV010YnpUU1NES1IwZFp5YmlXdkVpQXZuUzBsODNXQUQzcm12Ky9m?=
 =?utf-8?B?RHdjMkxUajR2UGljNnZIQzhOT3QrZkxwZWxIdEpzZmxoZExsc2FRQk9lelk1?=
 =?utf-8?B?ODBnZmxkZ3RzWktFTHl3QVlnazltRkVwY1UrYm1EMlRoc3dPaEpDVDVHaTJG?=
 =?utf-8?B?U09pRGYrT2tpS2pkS2NuVHp3MU1EM2dNUnUyVTFLYklSOGJsaUJlNUI1T09u?=
 =?utf-8?B?UWQzZm96dVFGVzkzeWdmTS9zQlptNzZTb3ZTdExtZ0hjWlcxSExFVUJReTdI?=
 =?utf-8?B?YW1zMG9CdXptTlhUWU56WW00UVBZa01oL2pVVHVqdEFDaEdsRTA5bHNteWdu?=
 =?utf-8?B?eXpoYUQ0eEJiZjdkbXplbWRYSnZSbVRaeUNLQnU5ZnpsOFJxRmYwVURoSUV1?=
 =?utf-8?B?eDExelhKbVpPaXhvaDY4QnU5MHBjR2MzaWlLdTZFTlFIQ3hDWTg4dktDOWtY?=
 =?utf-8?B?VEhEaWpMaldqVCtzSTNpcnMrYTJsM0Q4eldPUUVoQm5MUS9oMHFaR0E0OG1o?=
 =?utf-8?B?NUlUVEU0UW00MnlUT1hSb2tIcHI1Zm1hcW5xRG94TjNuZGZaMU9yRk9RbVVW?=
 =?utf-8?B?WEVXWmYxUXlhcGFYZmlPWWN3VWVzSURrS2t5ckxXS2xNV0EzcXNrcjlKWG9D?=
 =?utf-8?B?cGJrVEovZXkwVm9ldHBib2JJVFhKazVYbnFNSjUrU085TVdjQXJUeGRuUGhQ?=
 =?utf-8?B?Z3V5ZGpvQkd2TmJnbVRDZnhneEltMFVoZitVU2VEajFhTDdRVkI1UlFPRC9X?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4caa3091-d897-462b-24c4-08dd13b11487
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 15:42:23.0766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8nCSOxondMEUyTHeXpnQQluLAqG06rKL73ma/Msm8HEVIguEKEQoknBC9Rm/exQ0y6dCfpXiVINt54q38u0WIyTpyuzrwTpRrC6kL9Dc5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4960
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIFdlacOfc2No
dWggPGxpbnV4QHdlaXNzc2NodWgubmV0Pg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAzLCAy
MDI0IDg6MjAgUE0NCj4gVG86IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4N
Cj4gQ2M6IEJvcmFoLCBDaGFpdGFueWEgS3VtYXIgPGNoYWl0YW55YS5rdW1hci5ib3JhaEBpbnRl
bC5jb20+OyBLdXJtaSwNCj4gU3VyZXNoIEt1bWFyIDxzdXJlc2gua3VtYXIua3VybWlAaW50ZWwu
Y29tPjsgQ29lbGhvLCBMdWNpYW5vDQo+IDxsdWNpYW5vLmNvZWxob0BpbnRlbC5jb20+OyBTYWFy
aW5lbiwgSmFuaSA8amFuaS5zYWFyaW5lbkBpbnRlbC5jb20+Ow0KPiBOaWt1bGEsIEphbmkgPGph
bmkubmlrdWxhQGludGVsLmNvbT47IERlIE1hcmNoaSwgTHVjYXMNCj4gPGx1Y2FzLmRlbWFyY2hp
QGludGVsLmNvbT47IGludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGludGVsLQ0KPiB4
ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgU2ViYXN0
aWFuIFJlaWNoZWwNCj4gPHNlYmFzdGlhbi5yZWljaGVsQGNvbGxhYm9yYS5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBSZWdyZXNzaW9uIG9uIGxpbnV4LW5leHQgKG5leHQtMjAyNDExMjApIGFuZCBkcm0t
dGlwDQo+IA0KPiBPbiAyMDI0LTEyLTAzIDE1OjMzOjIxKzAxMDAsIFJhZmFlbCBKLiBXeXNvY2tp
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgRGVjIDMsIDIwMjQgYXQgMTowNOKAr1BNIFRob21hcyBXZWnD
n3NjaHVoDQo+IDxsaW51eEB3ZWlzc3NjaHVoLm5ldD4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gT24g
MjAyNC0xMi0wMyAxMjo1NDo1NCswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gPiA+
ID4gT24gVHVlLCBEZWMgMywgMjAyNCBhdCA3OjUx4oCvQU0gVGhvbWFzIFdlacOfc2NodWgNCj4g
PGxpbnV4QHdlaXNzc2NodWgubmV0PiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICgrQ2Mg
U2ViYXN0aWFuKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSGkgQ2hhaXRhbnlhLA0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gT24gMjAyNC0xMi0wMyAwNTowNzo0NyswMDAwLCBCb3JhaCwgQ2hhaXRhbnlh
IEt1bWFyIHdyb3RlOg0KPiA+ID4gPiA+ID4gSG9wZSB5b3UgYXJlIGRvaW5nIHdlbGwuIEkgYW0g
Q2hhaXRhbnlhIGZyb20gdGhlIGxpbnV4IGdyYXBoaWNzIHRlYW0NCj4gaW4gSW50ZWwuDQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhpcyBtYWlsIGlzIHJlZ2FyZGluZyBhIHJlZ3Jlc3Npb24g
d2UgYXJlIHNlZWluZyBpbiBvdXIgQ0kgcnVuc1sxXSBvbg0KPiBsaW51eC1uZXh0IHJlcG9zaXRv
cnkuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGFua3MgZm9yIHRoZSByZXBvcnQuDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+IFNpbmNlIHRoZSB2ZXJzaW9uIG5leHQtMjAyNDExMjAgWzJdLCB3ZSBh
cmUgc2VlaW5nIHRoZQ0KPiA+ID4gPiA+ID4gZm9sbG93aW5nIHJlZ3Jlc3Npb24NCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGANCj4gPiA+ID4gPiA+IDw0
PlsgICAxOS45OTA3NDNdIE9vcHM6IGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVsdCwgcHJvYmFibHkg
Zm9yIG5vbi0NCj4gY2Fub25pY2FsIGFkZHJlc3MgMHhiMTE2NzVlZjhkMWNjYmNlOiAwMDAwIFsj
MV0gUFJFRU1QVCBTTVAgTk9QVEkNCj4gPiA+ID4gPiA+IDw0PlsgICAxOS45OTA3NjBdIENQVTog
MjEgVUlEOiAxMTAgUElEOiA4NjcgQ29tbTogcHJvbWV0aGV1cy0NCj4gbm9kZSBOb3QgdGFpbnRl
ZCA2LjEyLjAtbmV4dC0yMDI0MTEyMC1uZXh0LTIwMjQxMTIwLWdhYzI0ZTI2YWEwOGYrDQo+ICMx
DQo+ID4gPiA+ID4gPiA8ND5bICAgMTkuOTkwNzcxXSBIYXJkd2FyZSBuYW1lOiBJbnRlbCBDb3Jw
b3JhdGlvbiBBcnJvdyBMYWtlDQo+IENsaWVudCBQbGF0Zm9ybS9NVEwtUyBVRElNTSAyRFBDIEVW
Q1JCLCBCSU9TDQo+IE1UTFNGV0kxLlIwMC40NDAwLkQ4NS4yNDEwMTAwMDA3IDEwLzEwLzIwMjQN
Cj4gPiA+ID4gPiA+IDw0PlsgICAxOS45OTA3ODJdIFJJUDogMDAxMDpwb3dlcl9zdXBwbHlfZ2V0
X3Byb3BlcnR5KzB4M2UvMHhlMA0KPiA+ID4gPiA+ID4gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGANCj4gPiA+ID4gPiA+IGBgYGBg
YGBgYGBgYGBgYGBgYGAgRGV0YWlscyBsb2cgY2FuIGJlIGZvdW5kIGluIFszXS4NCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiBBZnRlciBiaXNlY3RpbmcgdGhlIHRyZWUsIHRoZSBmb2xsb3dpbmcg
cGF0Y2ggWzRdIHNlZW1zIHRvIGJlIHRoZSBmaXJzdA0KPiAiYmFkIg0KPiA+ID4gPiA+ID4gY29t
bWl0DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGANCj4gPiA+ID4gPiA+IGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGANCj4gPiA+ID4gPiA+IENvbW1pdCA0
OTAwMGZlZTllNjM5ZjYyYmExZjk2NWVkMmFlNGM1YWQxOGQxOWUyDQo+ID4gPiA+ID4gPiBBdXRo
b3I6ICAgICBUaG9tYXMgV2Vpw59zY2h1aCA8bWFpbHRvOmxpbnV4QHdlaXNzc2NodWgubmV0Pg0K
PiA+ID4gPiA+ID4gQXV0aG9yRGF0ZTogU2F0IE9jdCA1IDEyOjA1OjAzIDIwMjQgKzAyMDANCj4g
PiA+ID4gPiA+IENvbW1pdDogICAgIFNlYmFzdGlhbiBSZWljaGVsDQo+IDxtYWlsdG86c2ViYXN0
aWFuLnJlaWNoZWxAY29sbGFib3JhLmNvbT4NCj4gPiA+ID4gPiA+IENvbW1pdERhdGU6IFR1ZSBP
Y3QgMTUgMjI6MjI6MjAgMjAyNCArMDIwMA0KPiA+ID4gPiA+ID4gICAgIHBvd2VyOiBzdXBwbHk6
IGNvcmU6IGFkZCB3YWtldXAgc291cmNlIGluaGliaXQgYnkNCj4gPiA+ID4gPiA+IHBvd2VyX3N1
cHBseV9jb25maWcNCj4gPiA+ID4gPiA+IGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgDQo+ID4gPiA+ID4gPiBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
VGhpcyBpcyBub3cgc2VlbiBpbiBvdXIgZHJtLXRpcCBydW5zIGFzIHdlbGwuIFs1XQ0KPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+IENvdWxkIHlvdSBwbGVhc2UgY2hlY2sgd2h5IHRoZSBwYXRjaCBj
YXVzZXMgdGhpcyByZWdyZXNzaW9uIGFuZA0KPiBwcm92aWRlIGEgZml4IGlmIG5lY2Vzc2FyeT8N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgZG9uJ3Qgc2VlIGhvdyB0aGlzIHBhdGNoIGNhbiBsZWFk
IHRvIHRoaXMgZXJyb3IuDQo+ID4gPiA+DQo+ID4gPiA+IEl0IGxvb2tzIGxpa2UgdGhlIGNmZy0+
bm9fd2FrZXVwX3NvdXJjZSBhY2Nlc3MgcmVhY2hlcyBiZXlvbmQgdGhlDQo+ID4gPiA+IHN0cnVj
dCBib3VuZGFyeSBmb3Igc29tZSByZWFzb24uDQo+ID4gPg0KPiA+ID4gQnV0IHRoZSBhY2Nlc3Mg
dG8gdGhpcyBmaWVsZCBpcyBvbmx5IGRvbmUgaW4gX19wb3dlcl9zdXBwbHlfcmVnaXN0ZXIoKS4N
Cj4gPiA+IFRoZSBlcnJvciByZXBvcnRzIGhvd2V2ZXIgZG9uJ3Qgc2hvdyB0aGlzIGZ1bmN0aW9u
IGF0IGFsbCwgdGhleSBjb21lDQo+ID4gPiBmcm9tIHBvd2VyX3N1cHBseV91ZXZlbnQoKSBhbmQg
cG93ZXJfc3VwcGx5X2dldF9wcm9wZXJ0eSgpIGJ5IHdoaWNoDQo+ID4gPiB0aW1lIHRoZSBjYWxs
IHRvIF9fcG93ZXJfc3VwcGx5X3JlZ2lzdGVyKCkgaXMgbG9uZyBvdmVyLg0KPiA+ID4NCj4gPiA+
IEZXSVcgdGhlcmUgaXMgYW4gdW5pbml0aWFsaXplZCAnc3RydWN0IHBvd2VyX3N1cHBseV9jb25m
aWcnIGluDQo+ID4gPiBkcml2ZXJzL2hpZC9oaWQtY29yc2Fpci12b2lkLmMuIEJ1dCBJIGhpZ2hs
eSBkb3VidCB0aGUgdGVzdCBtYWNoaW5lcw0KPiA+ID4gYXJlIHVzaW5nIHRoYXQuIChJJ2xsIHNl
bmQgYSBwYXRjaCBsYXRlciBmb3IgaXQpDQo+ID4NCj4gPiBTbyB0aGUgb25seSB3YXkgSSBjYW4g
dGhpbmsgYWJvdXQgaW4gd2hpY2ggdGhlIGNvbW1pdCBpbiBxdWVzdGlvbiBtYXkNCj4gPiBsZWFk
IHRvIHRoZSByZXBvcnRlZCBpc3N1ZXMgaXMgdGhhdCBjaGFuZ2luZyB0aGUgc2l6ZSBvZiBzdHJ1
Y3QNCj4gPiBwb3dlcl9zdXBwbHlfY29uZmlnIG9yIGl0cyBhbGlnbm1lbnQgbWFrZXMgYW4gdW5l
eHBlY3RlZCBmdW5jdGlvbmFsDQo+ID4gZGlmZmVyZW5jZSBzb21ld2hlcmUuDQo+IA0KPiBJbmRl
ZWQuIEknZCByZWFsbHkgbGlrZSB0byBzZWUgdGhpcyBpc3N1ZSByZXByb2R1Y2VkIHdpdGggS0FT
QU4uDQo+IA0KPiA+IEFGQUlDUywgdGhpcyBjb21taXQgY2Fubm90IGJlIHJldmVydGVkIGJ5IGl0
c2VsZiwgc28gd2hpY2ggY29tbWl0cyBvbg0KPiA+IHRvcCBvZiBpdCBuZWVkIHRvIGJlIHJldmVy
dGVkIGluIG9yZGVyIHRvIHJldmVydCBpdCBjbGVhbmx5Pw0KPiANCj4gQWxsIHRoZSBvdGhlciBw
YXRjaGVzIGZyb20gdGhpcyBzZXJpZXM6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAyNDEwMDUtcG93ZXItc3VwcGx5LW5vLXdha2V1cC1zb3VyY2UtdjEtDQo+IDAtMWQ2MmJmOWJj
YjFkQHdlaXNzc2NodWgubmV0Lw0KPiANCj4gQ291bGQgeW91IHBvaW50IG1lIHRvIHRoZSBmdWxs
IGJvb3QgbG9nIGluIHRoZSBkcm0tdGlwIENJPw0KDQpIZXJlIGlzIHRoZSBsb2cgZm9yIGRybS10
aXAgQ0kNCg0KaHR0cHM6Ly9pbnRlbC1nZngtY2kuMDEub3JnL3RyZWUvZHJtLXRpcC9JR1RfODEz
Ni9iYXQtYXJscy01L2Jvb3QwLnR4dA0KDQpJIGNhcnJpZWQgb3V0IGFub3RoZXIgYmlzZWN0IGFu
ZCBpdCBwb2ludHMgdG8gdGhlIGZvbGxvd2luZyBjb21taXQNCg0KY29tbWl0IDIyNmZmMmU2ODFk
MDA2ZWFkYTU5YTk2OTNhYTE5NzZkNGMxNWE3ZDQNCkF1dGhvcjogSGVpa2tpIEtyb2dlcnVzIDxo
ZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tPg0KRGF0ZTogICBXZWQgTm92IDYgMTc6MDY6
MDUgMjAyNCArMDIwMA0KDQogICAgdXNiOiB0eXBlYzogdWNzaTogQ29udmVydCBjb25uZWN0b3Ig
c3BlY2lmaWMgY29tbWFuZHMgdG8gYml0bWFwcw0KDQogICAgVGhhdCBhbGxvd3MgdGhlIGZpZWxk
cyBpbiB0aG9zZSBjb21tYW5kIGRhdGEgc3RydWN0dXJlcyB0bw0KICAgIGJlIGVhc2lseSB2YWxp
ZGF0ZWQuIElmIGFuIHVuc3VwcG9ydGVkIGZpZWxkIGlzIGFjY2Vzc2VkLCBhDQogICAgd2Fybmlu
ZyBpcyBnZW5lcmF0ZWQuDQoNClJldmVydGluZyBpdCBzZWVtcyB0byBoZWxwIGxvY2FsbHkuIEhv
d2V2ZXIsIHRvIGNvbmZpcm0gSSBoYXZlIHNlbnQgb3V0IGEgcGF0Y2ggdG8gb3VyICJ0cnktYm90
Ig0KDQpodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzE0MjA0OS8NCg0K
V2UgY2FuIHdhaXQgZm9yIGl0cyByZXN1bHRzLg0KDQpSZWdhcmRzDQoNCkNoYWl0YW55YQ0KDQo=

