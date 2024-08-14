Return-Path: <linux-pm+bounces-12194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F4995142D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 08:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC4A1F23E8F
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 06:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A07B7345B;
	Wed, 14 Aug 2024 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6iiSMhK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E554658;
	Wed, 14 Aug 2024 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723615760; cv=fail; b=EpeTL7B4nh5vlalTBoO4STFMPoGoEIzCS39VCx05+hraA3BuH9aekcH95d2Wy8XCEpYKdKOe9bCbONutQN/PB6ms3Xpo6ZlIEdbS6yMbzKkfLs22kRwqXj1BGUH+75OBPxF6NqsNNZ8F95hpFXTUq+43RYxudX2847tKm2Mk0zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723615760; c=relaxed/simple;
	bh=Nni22T7HKbTRIcmb3TKPUN4vkPlZDOhUpCUx7iykqmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YhWN1McoNCpM+nFhV2iMx97KIGW94HOFX/KATtwEzOzgUEzYglj7Id00f6Vk2hq/srUgRvFBMO6aHjAiHtLD1n95FGyRAKH5Dg588rxYXX6HWBx/34NkjN5quI7T+pI8GaqvB+ag3bugAS8mnJMu4QeyTqQ0TTEMRomJ5Ra3KUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6iiSMhK; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723615758; x=1755151758;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Nni22T7HKbTRIcmb3TKPUN4vkPlZDOhUpCUx7iykqmM=;
  b=m6iiSMhKTqemI54eKNWOSTqcUy50SNre+8RRsFzSE6a25BuyKMIN/hEl
   XCgez1Qt0h9nSIDQIEEqJwVS/svbTL3skhuryvslY4q6BMsBWexF34M1o
   KIDnjxagMZ7vqmme1IYppWmuQ1btH3iB3FYhcZgVXBJHrktAY5V7oOno4
   h1sOGVYIWHZIk3ffotSKWve+sqbe5hxioEEoxnlFRaFVQwJduwojziFj8
   2YXdR6p44RRYfpxvm5mTCkuDTymXdO+eNZcUQog1EdL6Ytg0sm2Rrfr68
   TUXEEnLJRrARpnUgcRxb09t2UtWtXcu20vs2cisIbt5Sxq8ComATBq9KN
   w==;
X-CSE-ConnectionGUID: wv0pefw3TIi3gXFiiZTMMg==
X-CSE-MsgGUID: E42ujEsBRQuQH27I2uxB/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="24722065"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="24722065"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 23:09:17 -0700
X-CSE-ConnectionGUID: rVEkFHZDS0C7pSTmQRP8Wg==
X-CSE-MsgGUID: 2t5i0H0JS8mxI8ZXDP14Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="63299959"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 23:09:17 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 23:09:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 23:09:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 23:09:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UietjyK+9Ri6tj3XEnKFgM8zyBf/AjsKlRh9S+gd6LCPHsJgRxGu7PELyyPA3ikOG5rk6elYdDvJeK2XmdLCIE0ZvHmlxbyPPmiQF6U17E5gqQG3cH6YHhvrGkvfYCwv4SxJLWNypXaefuDzTP+1njFUv9wic5H/J/es2hYIRlPb1ThHRBVqdEO738R6Bx8MXAynbyMSWLlJKpcsbKI0WVzZzpUXjiZSJ1ydzCij7FwIM+BnBPBFZ1AbJRurvpDIFQuRvInmUsMRB1Zhq31/2uiorD34lcDUR20JiUQWeqe4yJBQDjqOctEpZqdKl2p6qIwSyL75v376RLOfJl6fNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nni22T7HKbTRIcmb3TKPUN4vkPlZDOhUpCUx7iykqmM=;
 b=OaQNXT+cLBm5HxzK1EpgmD4pE8xPG4m6W1BvZD1WauGr/yKOFxMku1ezMcqNGXKqJKBEdyZYEDxunBoK/xWGdeFMUgMqLgq9PBMZLCBozBXbdwMPDI5iOOX/kqVAn3N3PHzifk49qkyIVfUj9mfKdCfd5Ya9jVu2i3Rs7W6bEOifij3ZTXGH5jcL/KRcxEMZPp1SKzLq9t+f2uCMugTWiHHSGsZfl8W5EB8QtQXLdR453hMy6Sx+FlItEcOy/pl94FjaRDmqvEQsCSiGbG4pvjIyLlRvkIWfEbL573a6Ktny4gI6DcFUZHxHC71voAjpKIhDsnCHEJ3uKeSFn4Rv2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by BL1PR11MB5239.namprd11.prod.outlook.com (2603:10b6:208:31a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Wed, 14 Aug
 2024 06:09:13 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 06:09:13 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "peter@piie.net"
	<peter@piie.net>
Subject: Re: [PATCH v1 4/4] thermal: gov_bang_bang: Use governor_data to
 reduce overhead
Thread-Topic: [PATCH v1 4/4] thermal: gov_bang_bang: Use governor_data to
 reduce overhead
Thread-Index: AQHa7Y0/nb0hc/COjUmHmsGZ2tMf8bImRdwA
Date: Wed, 14 Aug 2024 06:09:12 +0000
Message-ID: <2f16fd5a59d6655ec9339473d516ac49c89e43f8.camel@intel.com>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
	 <2285575.iZASKD2KPV@rjwysocki.net>
In-Reply-To: <2285575.iZASKD2KPV@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|BL1PR11MB5239:EE_
x-ms-office365-filtering-correlation-id: 22281524-cf88-4e4b-35ee-08dcbc279e92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: N7s4lEcKFsKgZcrtFks4grm6RsKF/tm0XEAE/rS2YL+m69pjxqAIZx21AyAMNDAISfYEveS6/i0DIMFx2HOqHllgaYgwY9cCuLs3SuxSYPqjREyw1CtPbvMlGjASIfSzC0KugsGAwaeVBJA6c1mltuNgOa8xhrDYERNs8vmGiEmMiaQk3H20qO8NRFpAbHXyFxg2L6uFBNGhdMOYqh/+yTyYh0a4YjMCjWFb1qm0y2diQUXcZqTU/wrCCRFeox32GMhxQxiw4h6+ybfAXam9UtI95AacQ1qypI/QKJNyI0ehTTNJF7Sdtc8Gbz37vitttNTLX57v3O4HXbEPBtj5b6+f0UycUnA+ikVcx8wT35xAdl9gaDmhB6wJUtKmUBLt1clPK7GqVvET8tvaRRcOyOnPbfPqrNtT+7dtAv90dznnDQzcEPGWOmc9sih+roQVmFtVFz0tPFrFD3HknWse1V8OE73dPzsQ2qZW+3/AcJa0Sgc0rnRnEkEMPFec7rZyu7pCNHscbZHcyB+IEsyQbhTl1jwrznj8VevDcwcICX+unJkXm3iKWfFyfmuNswarGLDM3A+o2kbvbxlbu9sTg7xu3bW34RfgDIjptvwDTU+mvQQYWLQvyIO1O3Q5VLWPLucFPIL5kfpFOPVYyXiCnCseqD3ukRjC1ZD2+bvY2Ns=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzB0OGVNZlV3bzNzZTg4bjF3MjhSelY4RHdDVHNsSmpGK3JkWEgxUEtJVy9V?=
 =?utf-8?B?Nk9LVDgzTzV3SmRYSEhTU3R5N0diTUk3WWR2eFlORTgwOVNiOWFNUGZGQWM5?=
 =?utf-8?B?ZS9talZhVlpFNFl1SmdIS3NCYWNaT2NxVkRQTllkNlpvSEhlQ2FCVnplZXBo?=
 =?utf-8?B?UkF4aTRqWVdNcmF6QVhsZHhkRVNVVEhGL2ZqZUdPUjMxeG00OFNDRFFGOXlx?=
 =?utf-8?B?d3Bna0o3TnhsbmM0L2lwZ3BuTkNxeWNGMFBleG5ZTUcvMjBhbjU0STUxQnJN?=
 =?utf-8?B?a0ZZL3B0TGhYdnhabjByZjZiTmllejIrMllWZ0ZDNm50eEx3UEN5aWcyUVps?=
 =?utf-8?B?enZaeGwwYjFMR1hqblFueVhSaCs4UzBtc2JVdDRjRzBnTElvODNkcEtWVEZa?=
 =?utf-8?B?VytudFllT1dJRzdva1RyRldOemxiTUNJQ1lEaEduVG1TVUEveVNtR3pLOEFJ?=
 =?utf-8?B?ZXFXYStyQXpHWVM2bFJzN2FiZkphcDV3T0hFVjh5VzQzVHkyaHl3cHF1L3U1?=
 =?utf-8?B?cWdaNzF2VVprbHNkOGpUVGxnSEkwODBEMXBoUXBrdXBmVndpUkZzQUhHUXVk?=
 =?utf-8?B?MmVIVHRORkUvbElYNjk4dE5sK2Y0YUlwNHRtODBzMWJiYlBKU3NRTmRjNklj?=
 =?utf-8?B?NTV6cm5MeHZrSzZGU0Q5SFpSQXEzTmpVYnRCUlRoYi92VEJZQXo1V2w5L1p0?=
 =?utf-8?B?VXVpWGxmd0Q0YXlJMkpaZTZFSXdHVDdzbTBLNkp4WnlRY0ozR2pzeUE4Tlcx?=
 =?utf-8?B?c1J6QkZ3bTdtdWROc2g3czRQdTF3SFc5QkVFdG4rOGM5bnZMTW1JaGVxR1ZJ?=
 =?utf-8?B?ZEJvQU1Bb1JVM21FejRaNnF6WWw0Zlh2R1ovZ0VDSWw2a25uRzdBbFZpZnBO?=
 =?utf-8?B?eGFCTWZSTEtIU296SkFPVU1mS2pFRElHVml3MGtBS0h1a2NUZzFITUdMSGFF?=
 =?utf-8?B?ME5KWHVIUHBZbHVsNGh5eUxBL0hBWXNMcS9nYy9OK2RnUCtqeVVYNjhIVmU5?=
 =?utf-8?B?K2ZzKzczMSs5SXREY2NvNC82K0tnUDB2NlJHNkoraE16OHFBWVgxYU91UEVk?=
 =?utf-8?B?NTF1MUNDYTJNYlhiMGs0RWVqOWJTaWU4Qk41MkNzM1lrS1FzVDZvSkJYaldX?=
 =?utf-8?B?RUFUb3NDYnkwcW53enV3MEVjTVZ0eFBuL2tIVzhRTDNpaFdBQ3hCMldwdTVs?=
 =?utf-8?B?Y1FLRjdmUzJ0eEJUbnFjdFgxT1FsSkhQWnVYSVNTZFhWak10YVVPMGZnMmcw?=
 =?utf-8?B?TForbS9HR2lDaWkvSWJHdEFhZXB6T1VyTTNaNFZZVXdYUmdTK0pUa09OMjFD?=
 =?utf-8?B?amVLbHlhREJTVDFSVzhSNlRMc0k0ZHhKcWJKZGlCRys1UllDaXhBOFFFdklV?=
 =?utf-8?B?aUZBR1hFcnhzUEZLYkd4LzZ3S1hkNmowRzh6aktVclpncmhVa1hLNzdJZ2hn?=
 =?utf-8?B?K0N1dkp4NWpzek1oRGtZVzdnSlg0Y1BaQ1NGYlBQSW1rNHBSdEh2UjBFNVUy?=
 =?utf-8?B?ZS9ucFZGU0p4MjVVaTdTT2h0Tmc2ZVo1NlBwNG1ZYjk1ZGV6TjhKQ3YrVmxo?=
 =?utf-8?B?dUs2clpzWXFkWVpZRXBGRXMzU3pNaFA1R25CQTBoMktkdktQTVpHalRVVlR4?=
 =?utf-8?B?MnZqdUk5ZzNmcnNUWU82b2FwOVZWTXlFZjZrUjRyS0EraFRIZlhKUWx6c2Jr?=
 =?utf-8?B?aTlBMmJ3ZDVYanRtbHdYYkhJVUtDb3NsTFkyREdhNUZCSGd0b2ppaXlhNVds?=
 =?utf-8?B?VHlGVmNHTUg0aGd6dDlNV1Z0ZHN6MndMZkgyckR6RWJqZk4veE9lTVRhV2x6?=
 =?utf-8?B?d3BTdzdHRHBpWjlvbVBIZ25sTmVCQmpDTXJyMUkxUGV3aFF2Wm90c2xuK2M0?=
 =?utf-8?B?bVZzNHl5TmVsU3pDR2J5dzRzZ1pKTitGR2luS1E1T1J4K0YwMGZ6VlZ1SGhy?=
 =?utf-8?B?clRNTHEwVHVOMk9Wb1lKL0p4WllodHZNdXdmM0lRbGJaeE9zaWl0S2U3cFZW?=
 =?utf-8?B?NHdhZkFLU2xhektsQ2IrVmJDODNsTW5qQVRGVStJQlZ2b3poQzVnS0lzRWhs?=
 =?utf-8?B?d0djbDh2S1U4cEpWZ1VsQUhMYXVDOHdlS1FzeHEvTTB1MlZ6bXMzSHdNUDBv?=
 =?utf-8?B?b0lHYVUwSVFDV0h0Z0E3UGZja2J6Mk1NS0wzVS84UWZSVThSVDh2bWNmbCtQ?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <331AA008B9CACE408C19C26DECE2F3BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22281524-cf88-4e4b-35ee-08dcbc279e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 06:09:12.9636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+B1OhcN/n8D5hUuYgnaXQCTNOhQ/UWymx3HafjQReTCy/dIaqeUJ2JI1Yrfums2A99uaTMQ0cDz640QH1UaZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5239
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA4LTEzIGF0IDE2OjI5ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gQWZ0ZXIgcnVubmluZyBvbmNlLCB0aGUgZm9yX2VhY2hfdHJpcF9kZXNjKCkgbG9v
cCBpbg0KPiBiYW5nX2JhbmdfbWFuYWdlKCkgaXMgcHVyZSBuZWVkbGVzcyBvdmVyaGVhZCBiZWNh
dXNlIGl0IGlzIG5vdCBnb2luZw0KPiB0bw0KPiBtYWtlIGFueSBjaGFuZ2VzIHVubGVzcyBhIG5l
dyBjb29saW5nIGRldmljZSBoYXMgYmVlbiBib3VuZCB0byBvbmUgb2YNCj4gdGhlIHRyaXBzIGlu
IHRoZSB0aGVybWFsIHpvbmUgb3IgdGhlIHN5c3RlbSBpcyByZXN1bWluZyBmcm9tIHNsZWVwLg0K
PiANCj4gRm9yIHRoaXMgcmVhc29uLCBtYWtlIGJhbmdfYmFuZ19tYW5hZ2UoKSBzZXQgZ292ZXJu
b3JfZGF0YSBmb3IgdGhlDQo+IHRoZXJtYWwgem9uZSBhbmQgY2hlY2sgaXQgdXBmcm9udCB0byBk
ZWNpZGUgd2hldGhlciBvciBub3QgaXQgbmVlZHMNCj4gdG8NCj4gZG8gYW55dGhpbmcuDQo+IA0K
PiBIb3dldmVyLCBnb3Zlcm5vcl9kYXRhIG5lZWRzIHRvIGJlIHJlc2V0IGluIHNvbWUgY2FzZXMg
dG8gbGV0DQo+IGJhbmdfYmFuZ19tYW5hZ2UoKSBrbm93IHRoYXQgaXQgc2hvdWxkIHdhbGsgdGhl
IHRyaXBzIGFnYWluLCBzbyBhZGQNCj4gYW4NCj4gLnVwZGF0ZV90eigpIGNhbGxiYWNrIHRvIHRo
ZSBnb3Zlcm5vciBhbmQgbWFrZSB0aGUgY29yZSBhZGRpdGlvbmFsbHkNCj4gaW52b2tlIGl0IGR1
cmluZyBzeXN0ZW0gcmVzdW1lLg0KPiANCj4gVG8gYXZvaWQgYWZmZWN0aW5nIHRoZSBvdGhlciB1
c2VycyBvZiB0aGF0IGNhbGxiYWNrIHVubmVjZXNzYXJpbHksDQo+IGFkZA0KPiBhIHNwZWNpYWwg
bm90aWZpY2F0aW9uIHJlYXNvbiBmb3Igc3lzdGVtIHJlc3VtZSwgVEhFUk1BTF9UWl9SRVNVTUUs
DQo+IGFuZA0KPiBhbHNvIHBhc3MgaXQgdG8gX190aGVybWFsX3pvbmVfZGV2aWNlX3VwZGF0ZSgp
IGNhbGxlZCBkdXJpbmcgc3lzdGVtDQo+IHJlc3VtZSBmb3IgY29uc2lzdGVuY3kuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5j
b20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvdGhlcm1hbC9nb3ZfYmFuZ19iYW5nLmMgfMKgwqAgMTgg
KysrKysrKysrKysrKysrKysrDQo+IMKgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jwqAg
fMKgwqDCoCAzICsrLQ0KPiDCoGluY2x1ZGUvbGludXgvdGhlcm1hbC5owqDCoMKgwqDCoMKgwqDC
oCB8wqDCoMKgIDEgKw0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC9nb3ZfYmFu
Z19iYW5nLmMNCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiAtLS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL3RoZXJt
YWwvZ292X2JhbmdfYmFuZy5jDQo+ICsrKyBsaW51eC1wbS9kcml2ZXJzL3RoZXJtYWwvZ292X2Jh
bmdfYmFuZy5jDQo+IEBAIC04Niw2ICs4NiwxMCBAQCBzdGF0aWMgdm9pZCBiYW5nX2JhbmdfbWFu
YWdlKHN0cnVjdCB0aGVyDQo+IMKgwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3QgdGhlcm1hbF90
cmlwX2Rlc2MgKnRkOw0KPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHRoZXJtYWxfaW5zdGFuY2Ug
Kmluc3RhbmNlOw0KPiDCoA0KPiArwqDCoMKgwqDCoMKgwqAvKiBJZiB0aGUgY29kZSBiZWxvdyBo
YXMgcnVuIGFscmVhZHksIG5vdGhpbmcgbmVlZHMgdG8gYmUNCj4gZG9uZS4gKi8NCj4gK8KgwqDC
oMKgwqDCoMKgaWYgKHR6LT5nb3Zlcm5vcl9kYXRhKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuOw0KPiArDQo+IMKgwqDCoMKgwqDCoMKgwqBmb3JfZWFjaF90cmlwX2Rl
c2ModHosIHRkKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29uc3Qgc3Ry
dWN0IHRoZXJtYWxfdHJpcCAqdHJpcCA9ICZ0ZC0+dHJpcDsNCj4gwqANCj4gQEAgLTEwNywxMSAr
MTExLDI1IEBAIHN0YXRpYyB2b2lkIGJhbmdfYmFuZ19tYW5hZ2Uoc3RydWN0IHRoZXINCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGJhbmdfYmFuZ19zZXRfaW5zdGFuY2VfdGFyZ2V0KGluc3RhbmMNCj4gZSwgMCk7DQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiAr
DQo+ICvCoMKgwqDCoMKgwqDCoHR6LT5nb3Zlcm5vcl9kYXRhID0gKHZvaWQgKil0cnVlOw0KPiAr
fQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBiYW5nX2JhbmdfdXBkYXRlX3R6KHN0cnVjdCB0aGVybWFs
X3pvbmVfZGV2aWNlICp0eiwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZW51bSB0aGVybWFsX25vdGlmeV9ldmVudCByZWFz
b24pDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqDCoC8qDQo+ICvCoMKgwqDCoMKgwqDCoCAqIExldCBi
YW5nX2JhbmdfbWFuYWdlKCkga25vdyB0aGF0IGl0IG5lZWRzIHRvIHdhbGsgdHJpcHMNCj4gYWZ0
ZXIgYmluZGluZw0KPiArwqDCoMKgwqDCoMKgwqAgKiBhIG5ldyBjZGV2IGFuZCBhZnRlciBzeXN0
ZW0gcmVzdW1lLg0KPiArwqDCoMKgwqDCoMKgwqAgKi8NCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJl
YXNvbiA9PSBUSEVSTUFMX1RaX0JJTkRfQ0RFViB8fCByZWFzb24gPT0NCj4gVEhFUk1BTF9UWl9S
RVNVTUUpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0ei0+Z292ZXJub3JfZGF0
YSA9IE5VTEw7DQo+IMKgfQ0KDQpjYW4gd2UgZG8gdGhlIGNkZXYgaW5pdGlhbGl6YXRpb24gZm9y
IEJJTkRfQ0RFViBhbmQgUkVTVU1FIG5vdGlmaWNhdGlvbg0KaW4gLnVwZGF0ZV90eigpIGRpcmVj
dGx5Pw0KDQpUaGVuIHdlIGRvbid0IG5lZWQgLm1hbmFnZSgpIGNhbGxiYWNrLiBUaGlzIG1ha2Vz
IG1vcmUgc2Vuc2UgdG8gbWUNCmJlY2F1c2UgYmFuZ19iYW5nIGdvdmVybm9yIGNhcmVzIGFib3V0
IHRyaXAgcG9pbnQgY3Jvc3Npbmcgb25seS4NCg0KdGhhbmtzLA0KcnVpDQo+IMKgDQo+IMKgc3Rh
dGljIHN0cnVjdCB0aGVybWFsX2dvdmVybm9yIHRoZXJtYWxfZ292X2JhbmdfYmFuZyA9IHsNCj4g
wqDCoMKgwqDCoMKgwqDCoC5uYW1lwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD0gImJhbmdfYmFuZyIs
DQo+IMKgwqDCoMKgwqDCoMKgwqAudHJpcF9jcm9zc2VkwqDCoMKgPSBiYW5nX2JhbmdfY29udHJv
bCwNCj4gwqDCoMKgwqDCoMKgwqDCoC5tYW5hZ2XCoMKgwqDCoMKgwqDCoMKgwqA9IGJhbmdfYmFu
Z19tYW5hZ2UsDQo+ICvCoMKgwqDCoMKgwqDCoC51cGRhdGVfdHrCoMKgwqDCoMKgwqA9IGJhbmdf
YmFuZ191cGRhdGVfdHosDQo+IMKgfTsNCj4gwqBUSEVSTUFMX0dPVkVSTk9SX0RFQ0xBUkUodGhl
cm1hbF9nb3ZfYmFuZ19iYW5nKTsNCj4gSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC90
aGVybWFsX2NvcmUuYw0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMv
dGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiArKysgbGludXgtcG0vZHJpdmVycy90aGVybWFsL3Ro
ZXJtYWxfY29yZS5jDQo+IEBAIC0xNjkyLDcgKzE2OTIsOCBAQCBzdGF0aWMgdm9pZCB0aGVybWFs
X3pvbmVfZGV2aWNlX3Jlc3VtZShzDQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqB0aGVybWFsX2Rl
YnVnX3R6X3Jlc3VtZSh0eik7DQo+IMKgwqDCoMKgwqDCoMKgwqB0aGVybWFsX3pvbmVfZGV2aWNl
X2luaXQodHopOw0KPiAtwqDCoMKgwqDCoMKgwqBfX3RoZXJtYWxfem9uZV9kZXZpY2VfdXBkYXRl
KHR6LCBUSEVSTUFMX0VWRU5UX1VOU1BFQ0lGSUVEKTsNCj4gK8KgwqDCoMKgwqDCoMKgdGhlcm1h
bF9nb3Zlcm5vcl91cGRhdGVfdHoodHosIFRIRVJNQUxfVFpfUkVTVU1FKTsNCj4gK8KgwqDCoMKg
wqDCoMKgX190aGVybWFsX3pvbmVfZGV2aWNlX3VwZGF0ZSh0eiwgVEhFUk1BTF9UWl9SRVNVTUUp
Ow0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgY29tcGxldGUoJnR6LT5yZXN1bWUpOw0KPiDCoMKg
wqDCoMKgwqDCoMKgdHotPnJlc3VtaW5nID0gZmFsc2U7DQo+IEluZGV4OiBsaW51eC1wbS9pbmNs
dWRlL2xpbnV4L3RoZXJtYWwuaA0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IC0tLSBsaW51eC1wbS5vcmlnL2lu
Y2x1ZGUvbGludXgvdGhlcm1hbC5oDQo+ICsrKyBsaW51eC1wbS9pbmNsdWRlL2xpbnV4L3RoZXJt
YWwuaA0KPiBAQCAtNTUsNiArNTUsNyBAQCBlbnVtIHRoZXJtYWxfbm90aWZ5X2V2ZW50IHsNCj4g
wqDCoMKgwqDCoMKgwqDCoFRIRVJNQUxfVFpfQklORF9DREVWLCAvKiBDb29saW5nIGRldiBpcyBi
aW5kIHRvIHRoZSB0aGVybWFsDQo+IHpvbmUgKi8NCj4gwqDCoMKgwqDCoMKgwqDCoFRIRVJNQUxf
VFpfVU5CSU5EX0NERVYsIC8qIENvb2xpbmcgZGV2IGlzIHVuYmluZCBmcm9tIHRoZQ0KPiB0aGVy
bWFsIHpvbmUgKi8NCj4gwqDCoMKgwqDCoMKgwqDCoFRIRVJNQUxfSU5TVEFOQ0VfV0VJR0hUX0NI
QU5HRUQsIC8qIFRoZXJtYWwgaW5zdGFuY2Ugd2VpZ2h0DQo+IGNoYW5nZWQgKi8NCj4gK8KgwqDC
oMKgwqDCoMKgVEhFUk1BTF9UWl9SRVNVTUUsIC8qIFRoZXJtYWwgem9uZSBpcyByZXN1bWluZyBh
ZnRlciBzeXN0ZW0NCj4gc2xlZXAgKi8NCj4gwqB9Ow0KPiDCoA0KPiDCoC8qKg0KPiANCj4gDQo+
IA0KDQo=

