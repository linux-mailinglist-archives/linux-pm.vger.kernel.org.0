Return-Path: <linux-pm+bounces-38175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB552C69977
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 14:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 655824E5273
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C17234D3A8;
	Tue, 18 Nov 2025 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWBo60q8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5850834F259
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763472350; cv=fail; b=VSYyZwVj6ZkMuS4IFwrCU/Qr8e+N0FqG6zY8Z/fAA0wllAYXSz55HFF+IoVfzJLKSGkgz9NeAo1hIqAe7K5K/cY3sD+ezDwK90voC9umHPJJXhEZy9O+G4/34C47hwJqF0H2wmCEh0rPivsmBc1Q7s632eSnymr+7bfY4KRG45U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763472350; c=relaxed/simple;
	bh=p1VOr1K139hwr4YSt7GCjODyLRmOXuvHti3sVQHiuc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rnP5utvK5aKZmyguckeKrnWULBVVAyYRx15fFqHYf1N8dPLwwT0B3nNuYJLG/dauG1NJPTNot+jrZtfbZoFpoAyJHltVZNJTJSvGYSx8NzgTbEhNE1L3CL0GKLbIr9BEARx7N/6/GvJieDxSzUqC98lXhlq0usmmrtcNFLoUUx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWBo60q8; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763472348; x=1795008348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p1VOr1K139hwr4YSt7GCjODyLRmOXuvHti3sVQHiuc8=;
  b=LWBo60q8JNTr57TeOsnuCOWE80NJsEo6q/O9QYrleo6Hm2rgUr3VRbiK
   Cdzbg0LOEGKS805X5BOKCDHsFxK6TxtfxMlIAfgAivx7n032kNb803HK2
   FK99aNHx2hfu1VP2gOBW/+JpfoQqn8roc+g8WJ125GorgS/weWxX+4Zr0
   KLeORgT1R713Dvqqvt3F13Y8ewiKvJyecyWr5apTGcu7cfuYo/5d157C6
   RLW0Zka3pZIqkt1wx/iHNHFIJhwB+jb8fd0BIRIFhGmhwjeZzTCATR6qe
   Dy9OaZooJJjN7bg5VyF2YHhIa3k6u2N6qgd400Hh5ZKOmEZF8jlcFrCZz
   g==;
X-CSE-ConnectionGUID: 1u72Ea+DSHqWql9AHFhnLg==
X-CSE-MsgGUID: 28e6/5+OSNWo44V2n+B/zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76950015"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76950015"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 05:25:47 -0800
X-CSE-ConnectionGUID: wJfysInwQp6BWZ0opme9+g==
X-CSE-MsgGUID: wJm1cqK/QPqEL7JWtStA6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="195889695"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 05:25:47 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 05:25:47 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 05:25:47 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 05:25:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+YsohtVaWjT10btqnkdOBIxr9BoAaX4kwQTOPq/frLIoV4fzXaQBh//dlmPye65aiadSzmhxAw5IwA+6sz/xck17tGxRMCw/2dAw45ODJaQ+r2IFkn6Ho1vwbMaq8vIiFZ0GCXVf0FbDupQv0ydg9jT5sDKIWXIoymb0n6VawcrJT83Ay1v/PWmcmPlEyIbeQ4p0iaybCKFppq0mWnMG4KN1tZyADF7ARJL66pjAm6Gp7HlCmvHtfhhan2DLGCZmhVnTT3LA9nAgzmEXpBsq0Pz3Ybzu76vSKno0RviXsoKlHHThCBZbAD+0hNu0rOObB9PjXPH2K3d4vYcfnODtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1VOr1K139hwr4YSt7GCjODyLRmOXuvHti3sVQHiuc8=;
 b=EP0Eu38Vj34uWg/g4+4UKEPZ70YQFQRAdEX4r5ODxEObMSshg/mFwXjYZMVYd2Nw+wTGMfXvqbP8JoGe+MPyPizoD2TfW3jfgIyqqg1CcDLmoNGpy3rY7qW9a48DaK8Q+HDXp20p/7BpaaB2bscCXktEeLUgfnO8YwliMhRXyGSERBsMdheu17RrZ+yEXtf/8pGPkjghX5pokJASXunLB8pncmgvFWgDxIvxtQop3SdqPb1s5fZDTykd7bzVX76Cxp6+lTF7st2CeyRoVrQ6XPwIX+KCZkuPl42Cc35G3lamSE4Oc0H4iPHn9YvHRdHVmXLNEkvoejPOODHla6wjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Tue, 18 Nov
 2025 13:25:45 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 13:25:44 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: Skip scheduling when update work is pending
Thread-Topic: [PATCH] cpufreq: Skip scheduling when update work is pending
Thread-Index: AQHcWIrzsNpIUMF46kCSJVgik6ZxObT4aqjg
Date: Tue, 18 Nov 2025 13:25:44 +0000
Message-ID: <LV3PR11MB8768D1362BE0DBBACDCEBFC8F5D6A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251118090354.118553-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0hMKsttM9_zgcZ0SMHpNBwr1FYQP8z_99brwaX_8zi2Mw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hMKsttM9_zgcZ0SMHpNBwr1FYQP8z_99brwaX_8zi2Mw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|PH0PR11MB5949:EE_
x-ms-office365-filtering-correlation-id: 331f7a6b-3033-46de-92c6-08de26a5fa99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YUtmTlJXczNXcHh5Y2FYMjNwOXYwemQyVTdZUC9yenV0MHVjcHNxaXBjSlVt?=
 =?utf-8?B?VjE3QzduaVdGWHRuU05KcWM0OHZZWUxGTFMxY3VibkZidDYzcW9GWE80NE11?=
 =?utf-8?B?TjhhS3cwZU5NbGFrQm1JWGVWTEZRb2FkZDJoQ0JPVTVlWFRjM1JsR2x0QXRU?=
 =?utf-8?B?YmYzdWFza2YxenBERGxidDdWV3plaDRRYlVsbS8rN2c3Tll5VlpWWVhTdnRZ?=
 =?utf-8?B?YjhJbnNWMi9sR1o5VTcvdW1QWDlxdzR2bDdpNllzbHFYdFBhbnA5SSt1VUUv?=
 =?utf-8?B?UWltU1B6UC8rQ0xYN0V6bi9SQWxuTzhDalFReEFNYzhTZy94L1p5cWdGZlRF?=
 =?utf-8?B?cW9jeWJlemZkMVJJLzZUUHQ4bGNZUWRyQTRDOTAzeVlFRWJMOFg4enhYaXp4?=
 =?utf-8?B?SUw5MWZBVGN6b1JodE1yU3VRQzhJdEh5ZUROemZHWjBZL1NwOGM0MktsNnRU?=
 =?utf-8?B?UnVrT1lxS3k1S1ZWVjRSQ1ptMXlOQ1BYU2UyS21vaDFVSkEzclZJRkJtUnhK?=
 =?utf-8?B?d3RZS2Q1clh4QjRGcEpFem1wNU81V012ZTNPbm9mN3doUnNKUWl3anErQjFM?=
 =?utf-8?B?RTdkdHU5TGJSbFhJcmhoMmQrVEw1b2pldCtIOVZjZnNhVWFvazVESFQ1Yk5x?=
 =?utf-8?B?YXJDTlFwalNUR25pNTlLTXBtbkFXK3hwUjNmSDRoTXBWSlFXYjRWZThzTEF0?=
 =?utf-8?B?YWd5bjJtRFZ1SlBrQUswOXRyN1F6d3JITXZKc0NReWc1akpsT2pLS1VpdUJ0?=
 =?utf-8?B?akFDOGxVV0tLYXlCcnpLOTM5ejJ3RkxiMGRYaU9MYjgzYXMwQ0JFYUhDQ1A1?=
 =?utf-8?B?MjVNZlRMbUYvS3M4MFpnbXhFZVVJZUhRUXBCTmVUVDJRNUY2MURmM3c5dFRG?=
 =?utf-8?B?bHBLTE0vSFVQdmdZaUhENDlsZGJWeW05cVlkTExTNE0zcWdZWmh2S2g4Tldw?=
 =?utf-8?B?VVArQXJ1VElOL2lPV0JRRFl4TFJvUjNQVEhPNnFjbDlwWHNkak5UNVRJU0Qx?=
 =?utf-8?B?SmFpVEtzbWx6UFBuQzUxZzJ1TVdKZEhjdGlyTkp6WFhoazcyNWttUzdId24y?=
 =?utf-8?B?b2laZnBhMjc4SVJBOUwzU3lQTm9QZUw2NjYyWHJrM1Z5WllWS0x2TkZxY2k0?=
 =?utf-8?B?MkFjb1U5dC8zUiszZGQ3d2hLQ2lQcitjSVNWRmdoUVp2NVl3T2lmZWd5ZStx?=
 =?utf-8?B?aURuQ2xGdXV4bHg2SVlDd0VKejZyQ3MzWkVSSWExOUV5eFN2S1hpcnhHOHRy?=
 =?utf-8?B?V1VvbjF0Mkt0ZXN2RGQzTDZuMm9NekFqaWNnQjYvd1hWZUJ0NU9POWt1Ymo4?=
 =?utf-8?B?WmdjYnB6WE8xT2dWWUUwekdLN08wZ01VdlFMdWVHWjY5N1BZTTcwMG96L1ZD?=
 =?utf-8?B?dzIzV1FHdWVHN0liSFpZUzJrQVJwQlJRSkN3UTNBZFdXYlp2aVV1cjJobWJx?=
 =?utf-8?B?Zi9BaFpudjZRNytESE5JOGo3dUViTi9QSXJWOUlCanBSb3d4bmNEaVd5bElj?=
 =?utf-8?B?KzVYd3NQWGRZRlMrZ3pIc3o1OGdhUHFWVC9zVVVmdzFHWXBGbE5wWURkdGM3?=
 =?utf-8?B?N2pxcmVkeUVta085OVFkR1ZmNFRNeEZQMHd6NnZ6bnlxcUtuRmN0NEJWQ0Nt?=
 =?utf-8?B?YVRNNnhFMHlHMmtORTZ4SG0wZUFaUXNZaXJoYnVNUWxFNHlPcUhxWHBLQ1lY?=
 =?utf-8?B?ckdvSjlSbHYyM0lSYWRFbVNjYjh0MTBBRmtGSGVTTFJBRnF6N1BFQkR5NGNj?=
 =?utf-8?B?SzE3OStHQkR2Q1VGNmx6eDF1N2ZWNktQd3YzOFdsWlErTkg1WkJ1M2U4ZWVS?=
 =?utf-8?B?ZHlHdDdIdjZkYXg3cXNHVDVKTzNIWmVKM1pZdUtqSnBiMmNybXd5RS9FU1Zu?=
 =?utf-8?B?clB0OTQ4czdKbVF2KzQ4RUYyc05oU0t5RlVpSDZrSk1obWhYd3NlNDcvYTNG?=
 =?utf-8?B?YVpHTWhWVXBUSTYycmdqMkZIRjA4dlVOd1FMNlM1Zk55bWlTMEhicnQ5OWRn?=
 =?utf-8?B?Q2N6V2xCa2tiSHIrdnArcy9STXk1SXdnSnBjS3grcVl1VHRHd1BONjNNZHpp?=
 =?utf-8?Q?GnqzCj?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L29DRXFJLzFoVEVsQlJDLytsUGlnMGhIeGtIVFM4ZEF3R1V0OVVqTDVwd1Uz?=
 =?utf-8?B?RG5vNUdWeWo3NW1PVTdqMlVZTlllcW5va01ZVkZkNVladFp6U0Uzc0p2UUF4?=
 =?utf-8?B?alZmeHUyaTJMK3RPd1NibXA1RGhmcTVsdUljNm5jOC9BY3ViMGcxK2FaQ1Jr?=
 =?utf-8?B?RlhLM1l2WTJRRTBYSEhNb2NLRko4RThjWGc5OTF6bDdhbnR3Wjg4a1ZUazh2?=
 =?utf-8?B?SG54cHlJeEcwWE1mNFFNUFdGMUtYcnZGWis0cjN6R2lpQ3RoNlJLR25hdnE4?=
 =?utf-8?B?eldvV2p5bFRhYmlBYTB4WWxVbHBHakpIaUVOUzJRQjZSRFVKelR5Wm1jRk5k?=
 =?utf-8?B?eGtvb1lnMVZ1LzRLSFloY3M3YmNUREJIR1YvSVQzaTFoQ2I1WXg0dGtDNjdR?=
 =?utf-8?B?UE5XaW1lSnJKbmp1REhSaHBRVEZvOGNVeFhoQlhEaHNJQ1FGQnBPdHVPZUpU?=
 =?utf-8?B?YXlESStUNk92dmdsOFoyd0tRWHJqRUpoY3ZHRFQyZkNyQlRDdzgxbXZ0MlpR?=
 =?utf-8?B?eEhsbWdCZ3lJWHZFNnYzaENDSHcvN3QreEFxYUlOWHVrenNheDY4QlA2dENK?=
 =?utf-8?B?U0t3MzJWdnhMR2hDWWV1MlYxVEZkYlNPUkluaFg3dGFvQkRuUXluVG00cUNP?=
 =?utf-8?B?dlJIZUtOOFEzcmQ0RVh4YzUrUGJKNHlteXVNSHRsT1lzeTBpTlA5SWNhTnky?=
 =?utf-8?B?QXlZWUpuaExHK1pJTU4xd0paSldLZCtjdmdlMXNsKzd0d3VTUTZkM25Sb0Nk?=
 =?utf-8?B?OG9tbjlhVWlkRFpwdXkxU2s3cDh6VXRsbEZiUEp4V0k4bTBnY3puZmJsT1Vu?=
 =?utf-8?B?cmhkcy95cmI2ZWp0ZHNqd21adHNmNVBxTWV5YkRMVHZFOC94UWlLbnA0NFRP?=
 =?utf-8?B?UktBaDJLcWdXUGdkWEJwb3FFUmZxNURZSmpvVGpIUG5ycXZscElTMC9kUjU4?=
 =?utf-8?B?TGc1Zkt0dlM5UmI4dGIrRUlob09nMEF5dTVvMzdncWYyMTdEeDRxVGJqU3BR?=
 =?utf-8?B?SnNaOTBSdFEwQ0E3dnRreWt3U1JKWVVUOHcyMTNkZmpNY244bHpJQTNuUFdD?=
 =?utf-8?B?cnZuVEZ1RDdtRmh4alhNZDJEUWUvY3p5OFpQcVlzbWE3QWd6ZG9qdWVONko3?=
 =?utf-8?B?bzd5MGFESk10bWVYSVJEWk03UndRd1N1RWRXVEtMRWphc21McS9nZVk2VUYy?=
 =?utf-8?B?TldQTW1TdUc3VU1sRTdWWlRMU2locW1HQmZxaysyZVNaZlQ5WWNkVExaOFBJ?=
 =?utf-8?B?c0RHM3FDdkNqOFZZcW5vMlhOcXZYbU5vRVlGSExxOVRSV2hlUWpFclAxc01O?=
 =?utf-8?B?d01xSzNjeXZJTlFyVStGbzQ3SnFaZXRXNDdWdytBV1Irei8yZk1MNnFheFh2?=
 =?utf-8?B?YmI0cmpsQ0ZlRjNlUDM4NUNkNVBtdVNIRytUQlRRM2gySUdtOGRrYzY2K1Bz?=
 =?utf-8?B?OVdkUFdHdG5qOWVsKzhROWhtYlV6ZDNncDg3OGtIczZJdEdVV1JZUlBrYnNL?=
 =?utf-8?B?dENSdElWdXd5Y3NkbEtGMXF1dGFMK0FIMEdLaGZJVEFyZlllR0NIRWJIR04w?=
 =?utf-8?B?Ny9QSkcwTWNYY3crTU9VWFVZZ3R6Y3ZOU3BLS2wwT1QyR2xDTGlCVVJ4V0I1?=
 =?utf-8?B?MjNtYVVXTjFFU1dwQi9JYWdCSU9yc0pId3NmQ05MNmk5MEhwVmJXc3VVZVd4?=
 =?utf-8?B?bk5OaUZGR2hGTXltV3dpcTZTdENpQmJKSWVZc0s5TWpkYmgvMkRQR1lqKzdQ?=
 =?utf-8?B?ZVQ0c0tFS2Q2aUdMTTNQRE0yQ2g4bDI3T2Y1LzVLeHJ4T1EveTF3VFp4M09R?=
 =?utf-8?B?MjV5QW0vejBsNUx0UytRb0tYb2RlMzV1OHhmVXQ1aHdNRFVIN2ZObDgwRTMz?=
 =?utf-8?B?MkgwZmVEK2ZNOUNvTUhNYWpQQTUzSHY0L2FVVytvSFFMVHcxNGoyZ2RjQUFw?=
 =?utf-8?B?NlhDY0RuZVJIUTJBdTAxTHBZNkxBWllWdVBtNUdxOGVBRjJQZ2NONEFZWFo3?=
 =?utf-8?B?MmdxOVJvWlJ2RTVvY0VJUXpPR3ZVdC9HZE5wYmFueWJUSE0rTS81cEV1cU90?=
 =?utf-8?B?b1VRMGpuekFKSEFMeTZQMnc5ZTQ1QjNyc0o5bmRYSlNyOHNFQWQ0Q3VTSExP?=
 =?utf-8?B?QVpCbkZuQ0gxbkZMM25UUDh1TTFiM1ZWMVI0Y0lvckhsYmV2V2R6UVlXL1VZ?=
 =?utf-8?B?YVFIdFZMNGc5T2tTY2hrSGFBbnpOcnJHWW9PY1dXUERtc2ZjNGtDc3A1MlhS?=
 =?utf-8?B?UjNMcm51R0g3L0tFeitaaVowTzNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331f7a6b-3033-46de-92c6-08de26a5fa99
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 13:25:44.8783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G6Mdmh5wtVTxrdyUJNyyqIMXHOZw/VpAjVbcmXRAARu72iVGLsGa1ijKSFfZNN9bVQtINwijQ7cWUWXmWSHkGeJzrMb9NdNWoztHI1azqiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5949
X-OriginatorOrg: intel.com

PiBUaGlzIGR1cGxpY2F0ZXMgdGhlIHRlc3RfYW5kX3NldF9iaXQoV09SS19TVFJVQ1RfUEVORElO
R19CSVQsDQo+IHdvcmtfZGF0YV9iaXRzKHdvcmspKSBjaGVjayBpbiBxdWV1ZV93b3JrX29uKCku
ICBXaHkgZXhhY3RseT8NCg0KWW91J3JlIHJpZ2h0IOKAlCB0aGUgd29ya19wZW5kaW5nKCkgZ3Vh
cmRzIGFyZSByZWR1bmRhbnQuDQpzY2hlZHVsZV93b3JrKCkgLyBxdWV1ZV93b3JrX29uKCkgYWxy
ZWFkeSBwZXJmb3JtIHRoZSBhdG9taWMNCnRlc3TigJFhbmTigJFzZXQgaW50ZXJuYWxseS4NClRo
YW5rcyBmb3IgdGhlIHJldmlldy4NCg0KQlIsDQpLYXVzaGxlbmRyYQ0K

