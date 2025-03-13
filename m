Return-Path: <linux-pm+bounces-23953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1ABA5EB27
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 06:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B433B77A8
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 05:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D821F4C82;
	Thu, 13 Mar 2025 05:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIze8h0s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D52AE77
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 05:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843767; cv=fail; b=qN2MoeBpl3Jpb8wO3q0LBlA03ywVGTRM/u+514YtsuSGRRSH1YQvm26SrvGfvmsxa3SyPl154eqPZWKidkw58UJx9d1/9IBZefpsNMshgmS9MUHWFsHOORdTjXH4aHFI1fOYgXTpdY8brSeevkH6G7g+OnEoWazod+sSCatDkXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843767; c=relaxed/simple;
	bh=ALZ/84+Xw68UQD2JQPjBSlCH/+LcfH1V8tD1zcYnXh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NvkwQlc4p80/C/H3dNNeS2/lJ2ufOfGq/qfWuCyTT8tbiqH0En1SH7QusQ3DgwbypRF+8PdN/HeWHuIfSSA9aI4YZGh0QRbyD0yjeiuMp9WtV3N5ywId0+oCN8NXxd/gAj1G4+n05gA8N3/9nTiqYR2NkXhI3BZ7hqfzQ+tNYWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIze8h0s; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741843766; x=1773379766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ALZ/84+Xw68UQD2JQPjBSlCH/+LcfH1V8tD1zcYnXh0=;
  b=ZIze8h0sRwi7f2w/IPfJ4RqXx/2pscp8O+Uf3Ik/zDToBmu3LzGyJ3N0
   2LKaE8Lq9XLkCrtUhuJtXBUk8g9CcUtt2SeNRw9hcB+v8G13wc4VU7TEN
   OQ81RwFXOBWd7Qra4RHyxBEDyN72VO4OophDqICuCP5UacjvbrvNLwEoq
   nWihmZiWaclQ93d8uBglNOeGIGaJGfu38+OkwaYPGrmQFm4PuoqSMPmqV
   e66ARclvHt9v2BLXZJfEUxuniRTV8MOw6mCDuJ9jZvJiLODaTm3GAmkzD
   AhSsItbBo2xl+gEhbt7b09sj8gnW9MyFCO3V3muZPZx/F/DlCGJu81nCh
   A==;
X-CSE-ConnectionGUID: p2HLphF9Qim3L+uuV2zAmg==
X-CSE-MsgGUID: sAVTJ54vRlOY6jtQ6MNArQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="54324655"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="54324655"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 22:29:25 -0700
X-CSE-ConnectionGUID: 3YhkkXiKT2qsVIC8MKIG0A==
X-CSE-MsgGUID: uZAMCpTHRnm7sVp9HUeDjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="151808840"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2025 22:29:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 22:29:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 22:29:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 22:29:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF4GnkSpDw27w6DKxn1s1lMJxgKxlUipDHO5TbXFLMFWfOlKTLJfZJuAaxIsChfLNolf05SYWad8fdcSgHSGFnUnwnFu78UOpJDkOYGqeuHdyFRnWBkrkQ8w2bfToqm0JVcdwGos2OGQUzjy6uMEeuH5Ii8YDhuQkKAHzR4U7ug+lrkGE4cFMLHeEu3zeo6P0wKoBTsySJXUhadXxDK1/DZeudw5/Lw1GeNfvqxQEH29eBgG1XcbCWrDpp41XeHXfnNSIeeldFSDDQhEnUEr6RXu2W30UOif+2mLQXARz+KYM7Qhhyp2zEtsy6gUQOdUOfCotH1aHryYFHcpT1s6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALZ/84+Xw68UQD2JQPjBSlCH/+LcfH1V8tD1zcYnXh0=;
 b=x57icUd80FBErqmd4E3fQStNEvkVgq+JFix7tB00wn2+HO7wizqx1r6GCmrsovJbLnQh5yBEeDWHANLkMvdTOkYiQ12DV75nuH20J3OBcZK3QF6rowenxvSVZ0eRVXyj01hSzd3KFvfNjAGoLVcfdxzq+ngWOEOmqN3KKcj+J4y4FpC9/+sp3HTBN9uRhm3lbzLOe7MVcLYf0PTBGB5EScM0p/xVGwqAQaXgqqcGm9NZJneneIOSonmaSdtKp3mozImUaSK/K4TNJm2FiJH61XjoZHOwSKkKXeRtv0844bDALRPku/64wpjfzuQkFOTXTcWDeGb20KyA1Py1ykLK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ1PR11MB6300.namprd11.prod.outlook.com (2603:10b6:a03:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 05:29:20 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 05:29:20 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "163ff391dc6d4f828ecff95e87f5003d@secunet.com"
	<163ff391dc6d4f828ecff95e87f5003d@secunet.com>, "Gwara, Mateusz"
	<mateusz.gwara@secunet.com>
CC: "Neri, Ricardo" <ricardo.neri@intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"Wassenberg, Dennis" <dennis.wassenberg@secunet.com>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "Pandruvada,
 Srinivas" <srinivas.pandruvada@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>
Subject: Re: TCC cooling on Meteorlake
Thread-Topic: TCC cooling on Meteorlake
Thread-Index: AduSf3zXUhT47FfIT9KWQYQvuThKWQBWWDkA
Date: Thu, 13 Mar 2025 05:29:20 +0000
Message-ID: <5e9075f31acbd5a1ef549cc3cd2236173a41353a.camel@intel.com>
References: <af33f856b8414a5e93f11c8c65b46881@secunet.com>
In-Reply-To: <af33f856b8414a5e93f11c8c65b46881@secunet.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ1PR11MB6300:EE_
x-ms-office365-filtering-correlation-id: c559f070-2b46-4ca5-420b-08dd61f0018b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U3EyUE9zTTlNT2w3QWpURXZabHlJUTg0NEIrK3J1NXFhVGVhOEM5SUQ4eFlS?=
 =?utf-8?B?OEN5VUUreS9uLzRmWnZCTWhySzRYdks5RnczWm1NZGxkd2tBT3QxSFduRFZN?=
 =?utf-8?B?VklvUHQ1VFVzVTlSR3Fac1BBdkV4ZTU3Y2VablVuVVova3dtVnZGM0lCelVU?=
 =?utf-8?B?WnhMczlYSjd3aGFSZk1DZ0R2WlF1T0ZtcEQ4ZEltbVlVd3hKSXh0REtoVjR2?=
 =?utf-8?B?WUZ4UGNRQWlCeU5KZDJFZ0t0aVhtSU51NVdWTm14dTJIY1p5YzlhUWxkUG9U?=
 =?utf-8?B?STBXK0FtcFFrMFEvVklyUG5vMFJnT3Q1YVBrb3hxSTJkRmlmVFFNd21xZEc5?=
 =?utf-8?B?N1BUOHM4UUYvSVBKQkFnbXNONGhsdzN2d2JSNmxUMUlUS1AyQnRleng4NitC?=
 =?utf-8?B?RzFHYkVMeHNzTFpPbGZZbEdWMkNhUEJpaEtCVTlWd0JvSk0yaXRwNDVKRE1y?=
 =?utf-8?B?YVhjamFLYUNiVkUyT3l1UkE0M1ZMUmdrdm8vSUNKWFd3VUdnc2ZmVmV3NXMr?=
 =?utf-8?B?VmN3Qy9KZjlqVkg3OTByaW9tQ3JxUVlwSzlGZE8vTHZIUzlvYkZIUTEvV1cy?=
 =?utf-8?B?MHFwVS9Fc2t3UTdlOVFRMFUxenkzenBlZWNROHRIMCthK0piKzJ4SmlzZVY5?=
 =?utf-8?B?ejUyMXcrUzJkM1pvNVNrV29XQSt6dEJCVWczcUp4eXQwaFJ2Z1Z1SHlZaDdK?=
 =?utf-8?B?Vzd1dXk4UHo1VjZGV2RvV01kYzljTmN5bXhwdVl5eFpua3JsY2YxQWd3Ym5l?=
 =?utf-8?B?UFlHaXNUYlhSTjF0cXh2RHhTcmpmRTU4U3dxY0lHSXRpRzhsQStudVZMcWRr?=
 =?utf-8?B?L2xvd0RnbnFDOWNrMmFmdjE0VERHUGExN20vWndpNG0zckdILzE4emJSZk1o?=
 =?utf-8?B?QWNxcDhyQWY1ZGtWdmkvZEp4ODg1dnVia0JFVWhhSXZ3MFJraWZBZ2pMdUdr?=
 =?utf-8?B?MUxPQ2o0aUdlVWdtUTd5SW5ydzNEalBMR2RzNWN5aGlLc2VSMGlaYkVReUVu?=
 =?utf-8?B?TXluRVozMW9hMzdsMWZ6V2VzUzYvTXBBRkZJVkd4eER2WmNvZjM1M1haOUNT?=
 =?utf-8?B?L3hlcnRkRy9YQWhLS3BCK3lpRStKQ2JmYlZxMFd2YjR2NWZNZXd6WitZOG5E?=
 =?utf-8?B?clB2anlZQk9aaFFvUCtjY0I4NTRDZVYxZkJqU3ZzZVM0VXFCTkdqTEFUNmZD?=
 =?utf-8?B?Y2NqK2pnSGlvTXovcmE0a2dCOGRzdFBLNVcxTUo3b21YNzM1QzZqdlExcSts?=
 =?utf-8?B?K2dKMHcrUllvcEtIMVJzUHRGZ3RRYmNXYnZxSU9FZzhhUzN1QVN5M0N4Uk55?=
 =?utf-8?B?K1VXSnA0ZjBGN3RnUk1RWEsyNE5GRU5qU0Z3VUVSUlUrUmhsY2cxY1hkTHYy?=
 =?utf-8?B?QTRURjArWEVCSnNHUjltc1VsL1hJTGovYTRZeFFvZitvTkkyeHJZOEpOUGVS?=
 =?utf-8?B?UzArb3pvMDEyTzJ1V1I0MkJZbXd2VHlSSnVvRVJudVV3ZjMxVGNuZUhjLzky?=
 =?utf-8?B?VTRSWVlEWE5haStvdkxNOVltU296SkQ0R2NBZzlGZURaZll0ZTByTXowcWNi?=
 =?utf-8?B?L1NvSlVHRUs4SHlSYTVIZXZKTFVvTU0vWHNmZ2tjM1VsSHdLSzVWa2U1dkt6?=
 =?utf-8?B?a3lOM3BlSTVzZEpwRThzcThyWWlyMWZQZHpjTVZaQ29kR0FyTGl2NW5reVhk?=
 =?utf-8?B?TzhuOHRDa1VnZ1B4QmtKVXB4Zk0xVnNZY0YwdXZBRS9OQ3N6Q0ZDMXl1dnZp?=
 =?utf-8?B?NFFER0FWR2tiVXhjVmJMeG9Gd2lVTzJNNTRCM2NZelNkY3YzbUV3Ui8xSmJm?=
 =?utf-8?B?Z3hIMUJjL2F2eG9VWVBBWm1LNjdQcER5VTJTeFdDMGpkVHNGL3gyY1IwSWdr?=
 =?utf-8?B?YTc5MmorNUhncG5kaUFCZCtxUE42S0JZcW1ZYTJXdVdTWG5UNnRUd2dUU3FK?=
 =?utf-8?Q?FF6hn3EDIN8Gd/6h25anoZsH0/bvIyYg?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0h0MWZRUUYxQ096WjZhSDZyZXlhemM1RFhYM094bGRXWEpoSTRGc1pnTEdt?=
 =?utf-8?B?WUVrdEgxR3B3bHU4KzVRbFkzN3VxWTJ1ZG5DTm4vM1VzeUdVbVhwaTBmYm94?=
 =?utf-8?B?RmNaUHJiRHZGaVVzR1MxNGRlTUZhdFJhRlY1bDVXWm05d1FHMVowNkpoSk52?=
 =?utf-8?B?dGcwRUVYbnFHTGsyK0J5aldFTG1rb3BHMURlU0tHU3ZEVHlidVI0aUg4WW1s?=
 =?utf-8?B?Nnd5VnFCeW9Md2UwUkFyVmt1MmVyb0dQNDIrRlVtbklVYTU0M2N6RU1HS2RS?=
 =?utf-8?B?WEY4RzhiRC81WWZGY1E1YS9pZWxWUk9uYTJyU0tzQ2p1b1dWU2VETVg5VjZJ?=
 =?utf-8?B?WFhUb2JPVjJ0eU1CL1Z5TDhIMnhWVzZVTy8vSGlHNzc5dWZueEFhRGliSFpa?=
 =?utf-8?B?NDUzYkFXZmY3bGRqY3V4eE8vcTBJYjNzVzA3WXBqa2VRQW9iYmVjQTBJZENE?=
 =?utf-8?B?MTNUYWZIV0VOVjBWQlBSSHVaSWg0MTZFNXc0djMyWGVyUFdpTW1sM2ZuSHI5?=
 =?utf-8?B?cSsvZllNcHNsdHNWMEpHL1RLazlGRWMrMHVySXJCSHNNcTdocEEza2Q1Z1I0?=
 =?utf-8?B?dEw3MjFIRWhxdE55aU4yUk9jSndmTWQ4cHQ5ZWRyVjFXOVhtRGxXbkFEeEtv?=
 =?utf-8?B?cUFoNmRxclJhQU5IcDc4cXh3cHNRRFBLOU5ZeTJJN0xkMGhiNHNRa3BZcGFq?=
 =?utf-8?B?bC9kUUJzazRldnMxenY4MUFZdHhlL0N0TFR4OTlMK0ZqRXd2aG1BUnBFQ2dq?=
 =?utf-8?B?ZEMxdFJJcjZYeWs3cXptaUlxQjRYSklpaWpOOHJuczNFOVFqNC9DUnZRRkdk?=
 =?utf-8?B?NGJjR0dPMXpjSnVTRlpMb2R6N2lIUDkwUUgzSG8xbk0zRFhyVE14dFJXVG1t?=
 =?utf-8?B?MUFPdDBlMlB1empVN2lwRXk3dCtOVlZSTE1uSVY5d2xGdG9hMFlINlF3RjFj?=
 =?utf-8?B?dm5WK0o5UC9LWU1PNnFxcmJvbVl6MVUyZ2VGLzBKdzN3ejdTVDBtTjN4Q1Fo?=
 =?utf-8?B?Q1lMQVBwcE9YL0ZNL3ZWSUhXT0o3STQxZXRLaUI4YVRTeEtaanNQempKQ2Nt?=
 =?utf-8?B?L3hxSjYybG1jd1RCZzZjRXFqQ291MC9BWk1GYjRpdHZvdjY4MTN2VTRrSGU1?=
 =?utf-8?B?R3U0aWRISFdHeDc1QmF3eW5kcHRnS0oyNU5nczBjcEdraE04VEsyR0RpcGh5?=
 =?utf-8?B?UTQyOFBsREZnbTBhT2hTZTZQWS9KYWlBR3ZGR1Q4YnFxcDgvL2xEYkdFRnQv?=
 =?utf-8?B?R041MHNaTGptTkY3MUxuN3ZWampJeW83dEVrRVlleS9PejJCUm1YRnplcmFj?=
 =?utf-8?B?L3NYZ01LU2cvb2U2YWg1RUdDSGpaaG1RRDVOUVczbUxCMUtDRVBXL1ZqM2hR?=
 =?utf-8?B?Q0FhT3lIMDAyVU1ZZmp2ODNSQXR0dXFNY1dNUXFpT09YS3ZSOVlNaENZK2o5?=
 =?utf-8?B?YTEzWnNieTVKbHJJaHNMVXgyS0dhVUpGWXBiTlFyL0xTK3J3a2JORDVrUUZF?=
 =?utf-8?B?UUFWSkZpWm1xUXNZcEVRMG1IWlhxN2E3N1RZWUpVbXI5UjBlNlF4ZFo1SzZ0?=
 =?utf-8?B?OUV5VTFzaTNOSVNRWUdUbmUwUDErUHFubDNoLzQ0ZTNyVVRZMmxIeWJkRlFS?=
 =?utf-8?B?MTYrM2EwemxuTGYzTDNERHJkc3FGd1dtcW9qSHFuODF4L0VtMHhZNytncVlI?=
 =?utf-8?B?RzUvYit1d1JzcHhSMmV6V3JReklPMDl1RkJnWGhLMTJaM2ZhTWpwTTR0QTVx?=
 =?utf-8?B?eDd0d1RFdVlOUGhHdHp5cFNVRVI2VGpiUXFvRC9WV0h6Y1ltU3JmU0YwQkc2?=
 =?utf-8?B?S3JFQlVwdE9zbWpWdEdkaG5LZlFadmF5VStvMVN2WjRNTlZBblVHZXY0Rnc1?=
 =?utf-8?B?Y0pMeFNsV3JjZ25qNHQzdkFpaTlYVmkzSWlQdEhTNG91anZLa3kzUGhxRU9Q?=
 =?utf-8?B?Q2xUclkyYVlDZlZ4NmE4bnBjaGw4Q3ZTSkJrajB4bkY2Zy9JcGs5a0lwcnVH?=
 =?utf-8?B?R2VZNmNIemQxem9hcTlIcURENnpkYWRCcm5NcjFsQnozZGV0MHNibVlNWUdR?=
 =?utf-8?B?eVUyOVh5WTE2dXdrWmlTQVBIcDhXajZpNGZsVDlLMjR3Nml1UnJ4TU1tbFdL?=
 =?utf-8?B?b3RvdDN1SC93TktUeWIzc3FlTTBLVnRqRnNDUVlVUkhvL25LNmM3cDBia2p4?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F7C3F59B2CE334D801F2EF5BA87D85F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c559f070-2b46-4ca5-420b-08dd61f0018b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 05:29:20.1941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9qMwpzzcoyECJuVlLBRyTo6FdCCeyjD7lKB20xW4spBJ3hWLrxkqC6RwZ3cKWOrGyjBFSvWUeMyAxeBlrtbZKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6300
X-OriginatorOrg: intel.com

Q0MgU3Jpbml2YXMgYW5kIFJpY2FyZG8uDQoNCk9uIFR1ZSwgMjAyNS0wMy0xMSBhdCAxMjoxOSAr
MDAwMCwgR3dhcmEsIE1hdGV1c3ogd3JvdGU6DQo+IEhpLA0KPiANCj4gSSB3YW50ZWQgdG8gbWFr
ZSBzdXJlIHRoYXQgdGhlcmUgaXMgbm8gY29uZnVzaW9uIGJlY2F1c2UgdGhlcmUgc2VlbXMNCj4g
dG8gYmUgdHdvIHNldHMgb2YgZHJpdmVycyBoYW5kbGluZyBUQ0MuDQo+IEFzIHRoZSB3b3JraW5n
cyBvZg0KPiBkcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL2ludDM0MDNfdGhl
cm1hbC5jIGFyZSB2aXNpYmxlDQo+IGluDQo+IC9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDA6MDA6
MDQuMC90Y2Nfb2Zmc2V0X2RlZ3JlZV9jZWxzaXVzDQo+IGFuZCBkZWZpbmVkIGluDQo+IGRyaXZl
cnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfZGV2aWNl
LmMNCg0KeWVzLg0KDQo+IGRvIGhhdmUgYSB3cm9uZyBvZmZzZXQsDQoNCndoYXQgZG8geW91IHNl
ZSBmcm9tDQovc3lzL2J1cy9wY2kvZGV2aWNlcy8wMDAwOjAwOjA0LjAvdGNjX29mZnNldF9kZWdy
ZWVfY2Vsc2l1cz8NCg0KSXQgc2hvdWxkIHJldHVybiAwIGlmIG5vb25lIGNoYW5nZXMgdGhlIG9m
ZnNldC4NCg0KPiAgd2hpY2ggZG9lcyBub3QgdGFrZSBpbnRvIGFjY291bnQgdGhhdCBNZXRlb3Ig
TGFrZSBDUFVzIGhhdmUgYQ0KPiBUSnVuY3Rpb24gb2YgMTEwwrBDIGluc3RlYWQgb2YgMTAwwrBD
Lg0KDQp0Y2Mgb2Zmc2V0IGlzIGFuIG9mZnNldCB0byB0am1heCwgbm8gbWF0dGVyIHdoYXQgdGhl
IHRqbWF4IHZhbHVlIGlzLA0KcmlnaHQ/DQoNCj4gDQo+IFRoYXQncyB3aHkgSSB3YXMgd29uZGVy
aW5nIHdoeSB0aGUgbmV3IGRlZmluaXRpb25zIGluDQo+IGRyaXZlcnMvdGhlcm1hbC9pbnRlbC9p
bnRlbF90Y2NfY29vbGluZy5jDQo+IGRvZXMgbm90IGNvbnRhaW4gYW55IE1ldGVvciBMYWtlIChv
ciBBcnJvdyZMdW5hciBMYWtlICkgZGVmaW5pdGlvbnMuDQo+IFdoZXJlIHRoZSByZXN1bHRzIHNo
b3VsZCBiZSB2aXNpYmxlIGluIC9zeXMvY2xhc3MvdGhlcm1hbCBhcw0KPiBtZW50aW9uZWQgaW4g
dGhlIGluaXRpYWwgcG9zdC4NCg0KeWVhaC4gV2Ugc2hvdWxkIGFkZCB0aGlzLiBQYXRjaCB3aWxs
IGJlIHN1Ym1pdHRlZCBzb29uLg0KDQp0aGFua3MsDQpydWkNCj4gDQo+IFJlZ2FyZHMNCj4gDQo+
IE1HDQo+IA0KDQo=

