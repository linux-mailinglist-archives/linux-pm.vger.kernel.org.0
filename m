Return-Path: <linux-pm+bounces-12286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A225A953FEB
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 05:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59368283AA2
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 03:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FD53716D;
	Fri, 16 Aug 2024 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8gRATc2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62DD25622;
	Fri, 16 Aug 2024 03:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723777246; cv=fail; b=jj00AmCxv7eQmNXWXYt1Z8ov0RpiIQ7pWF2q0dVz4f2rOzXMvOu9LufpWLfn9wnwX7fKkEpSCrizkn0kI7ML4z79NX0lIK1khNnzW2ilO+oqhPwuc1RqdIwy2ohGPlR3nnKAgFTPVolBOd1FvaEMuRDae9xeX/RvMHF37mtm2IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723777246; c=relaxed/simple;
	bh=WVjmwAA4jjmc5N4swjreVt2gonALZ/30nmSrK4CeO2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OCKKsxMD4S/CqDh7LF+fHdP4TZiGWMhD2Nss/76z4EA5/Y/Rq0ldUIapQP6XtVNBxMstAr679qc4ZP1ckEIZD0Ry7nC4e2Bi3xQITp9AFbgTBmRKguEfCdVBPHK0dfytBavi3APsn8MwN77Hi+qQzXo3xxNLX9ZSmXuVx1bLs0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8gRATc2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723777245; x=1755313245;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WVjmwAA4jjmc5N4swjreVt2gonALZ/30nmSrK4CeO2k=;
  b=O8gRATc2iiY1S8ywNkwgGr4A/Pyu5/+wl6x7X3U2WFjTCxq6gVYccpBW
   oCt35p2/F20AdpkaM29EjQK9nloyE/N4LFIFE5S/eRdCLnZ2Dr+kiUFpu
   v7BlthQE3hw1ErVJ5wViX9gyRNTz/tYPTx82E9l0WHVD58hlYhZeyyMl/
   2msdar+HDe5AfNpJkNrHcdKb1+a1pMDaUuc9dyR1ESyXky8E9SXpxuzm2
   sxdgLpb4jbTAMAiZROKL1W1/61WseMGJy3l2GHYyXIIqhhcqGEvk0LoMP
   tck7CgF5iGlTq1LYVyfYLP7g7NE/5lAzoBoIs15X2MO/gfyi45aVkpcry
   w==;
X-CSE-ConnectionGUID: mV4ucidPStadroVgK+NBrw==
X-CSE-MsgGUID: uB1j7qJUR5SK8pGwlLr3Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22032881"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="22032881"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 20:00:45 -0700
X-CSE-ConnectionGUID: V4DBr77CSmaE3TBdqNRVtg==
X-CSE-MsgGUID: 5VeGefPETcirR0djYAGwWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="64435463"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 20:00:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 20:00:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 20:00:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 20:00:43 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 20:00:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r75w6Ey5aPs92vyXdpReVb6HqBuhv0Ft3QZSSY/0yDvBA5OICRHF1QwoeXW+gtWWYiP6gkL4Ax6ksFoK95dV2A/P7L9ZtSqCTjCqwjX2Fws0dVYtkrzNiKKi8rplNL04ywPHhm/qzjqaJN4mUaDmNz5YapYOZYrclGgEza3HYrTg06C5rHDOohrABIpZnAHdvmrRvupQAPLYcKideJjG20Uc1NP0nE8HDVctw3I0/r2ZmLB455ryozBV6EGJI3Ch3D3VBVafnZfYnprzrH7xCu8sOpBNSk6F1y6iqoGhRt98qiHZd85aTRTv+vUxn4498mpCmc0YvhMx/DLW7A+raA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVjmwAA4jjmc5N4swjreVt2gonALZ/30nmSrK4CeO2k=;
 b=lRUcRSXGBXlAkJryPVp/kXHlji53a6VbrMCzD1FXVffYUyW/DJv6EcGzTO1ssCwpr2KzQwkMDgXbzTfgMNdU7WdIt2FcjZEkP5wxFRjjzFY6kLwLf4SF81Ju3wc8NV1wUcNvpaeDQ6sHzvSVfZ5/sAJuxLIzaQdzXa9NNHQyU3khvxhl2rF+HKEKPJkfPujmTlxleVF/ZuU8PxJzlQGFUzMr6Bt75tMCqF9J0JFw5jJGr4fLL/rXylGVEe3kM8TdVYXnfjy1mHlxK/WeUl6TKu640Ycf/130xA1IhxC7hIHwzK+eHysrm4BS065/eIVgLijT4tM0hagFG9PbFgAXuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 03:00:41 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 03:00:41 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "peter@piie.net"
	<peter@piie.net>
Subject: Re: [PATCH v1 1/4] thermal: gov_bang_bang: Call
 __thermal_cdev_update() directly
Thread-Topic: [PATCH v1 1/4] thermal: gov_bang_bang: Call
 __thermal_cdev_update() directly
Thread-Index: AQHa7Y5F+xqDs8VhGUyX2qEbC7cmALIpNdcA
Date: Fri, 16 Aug 2024 03:00:41 +0000
Message-ID: <9324a2e2a89d17ad18796cf3d3933cca165415d1.camel@intel.com>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
	 <13583081.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <13583081.uLZWGnKmhe@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ2PR11MB8500:EE_
x-ms-office365-filtering-correlation-id: 572439aa-3e97-4fea-c640-08dcbd9f9d29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q0lsNzJrOWEzTnNGUHQxQ0RLR1MxQ21IaVVHUWhnTHBpQWZIUWxSM1I0NUl5?=
 =?utf-8?B?WEVVaWRlOWhvM1ltQVY5bjJrd2IyYlNLOVZGME5GdDVNNXRQV0FxN2VUMzZK?=
 =?utf-8?B?bjEzbit3clVsT2tEeks0RlRkWmdweWRUTkxjaXBZT05ZT0tndStHc3NOUThH?=
 =?utf-8?B?K0RFRXQzTnN1K21KbGdpQWt5TVpvR2RVdmtrVDFLR3MzWjltK3VDdDRBR2Nh?=
 =?utf-8?B?eGkxQjFCT3ZjOUFNdWJrTnZYNjAyaWYrYk83czAvWnlLV09zYzdXTHF2OVJk?=
 =?utf-8?B?cDNKSVRNVW5mNzVvUVFmb2dtWFFUOTN2NU1KRmtVR3dTdDdNK3VDQmxpQ2ZM?=
 =?utf-8?B?dkoxRU53anRycDU5dVZTbHAxRFNHRnJjVzg1cks3VlFQSmVMTWxsYmJFSTVB?=
 =?utf-8?B?bVV1a0lwSWVIVDVFaWpnN2YrclBtQ3Awcm5MWmkyU1cxK0FsQitKR1gyaGsy?=
 =?utf-8?B?Sk5vQjJ5RW01SVlXRlo0V3JEcE8zZzIzWWovdm1yYTI3Qk1iWmxFLzZjSjhx?=
 =?utf-8?B?YkJ2QS9rS1lJak5zMllweWlmYVZ0NG15bzk0MjlaTTRTUGZuQUdLbllCbm1Z?=
 =?utf-8?B?Y2dmVldpbUtnSHBWbVYrNU91YWVjcGhqTXpqTmdJS3ZkZDNKSG9zM0Zia0xD?=
 =?utf-8?B?UERNaWFUd2ZDN3BhWVlNRUlpQWYvTStsY1RyTFJ2eGQ4R0xVdGpid01yV045?=
 =?utf-8?B?VjJWRGtaSEw1cEZaL0pGelJYUkhPaUFFT2R1MGpGS2FSVFZXbWh0eDVvT3Nu?=
 =?utf-8?B?eWNPMndkUmlSTG11MFRVUHJqcXhKRCs3UDJaaUtKQmpQRlU5ZUVuMnl5WHFC?=
 =?utf-8?B?MW9jc2JwVE5DT2lsZWVPdi8yb3NSbFlocFJUanlUWStVOThnc1RUT2FhZkNz?=
 =?utf-8?B?NzU5cDZ1YmNLUHdLV0paWmlrQjhKRkFnUGRyclJySFpTWUNmcjhPY2NscStv?=
 =?utf-8?B?cWxyZlIvWGw5V05IcGlPbHdhUG84TXUyS25hZ3o3WFpWZTlBVjdncHFTQ0hB?=
 =?utf-8?B?cVdQaW5nYVJWZWp3R2NjS0N6eTB4dkt6d2RjR0ZnMmRhT3dLbklub2VZdlZo?=
 =?utf-8?B?c1RsM3NhN3RKTmlTKytVNm5Xa0FZMEdpbG1mV0NMU3h0TlZZMHdSZVNmelNp?=
 =?utf-8?B?ZlpuK0JUV29YUERJWi8rcUF6YXRLL1FOMnRlVWJaaW1ySmxRNlpRamhveEZz?=
 =?utf-8?B?V2dKc1pKMjFpaFA3MytBMWIzclRwQjJTN0x4K1ZqOFBOUFJnNnA3U0ZJWS9L?=
 =?utf-8?B?bDBoeTRNaVhIdDRaRWpTWWIxaURBSFJROHNNaCtSNFB0ZXhqTnZRTmxSazBn?=
 =?utf-8?B?cS9IMFl3cXVpY0dQTC9XN05EVW5ZTUV2UDh0bmRXQnZvaStUNnlaNCsvSVZz?=
 =?utf-8?B?VElRdGVjUzR6Um1WSDJjTENlTzNwZ1Y3dTMvSkNRbEh0OGNhbUFZMkVVQk1T?=
 =?utf-8?B?YmR4YVROMGNqWlBWNkkyOHVCdkxKVVluSjhPTUNFZkptc215bzNVWldUSWwy?=
 =?utf-8?B?UVlQdERMSlBwSjJRbXU1K1NZNkZ0Y0doanlZYmRCazNkcTE1U0JMaFdZemhl?=
 =?utf-8?B?eEdIWjQwcU1NRkFoZXRzczUwV0JaYmF4YkJFKzVnMk1sZlRYem1uSU9tYTMz?=
 =?utf-8?B?aXUxNmU2aERzcUNOK3JTL2tLb3RJemZjTkl5SUE1QzNwMkFzTVF6RmZyanoz?=
 =?utf-8?B?MHBNUTFlNkt5WEdRTHB1Q2FQMExITDNpUC9pSklVL2QrcEo0cUtpenc4WEo0?=
 =?utf-8?B?eVVPQWpUZ1VaSUN2c2Uxb2xrZS9lcWJLMCtxZWFSNkQrMlk5eXNkNlB5YU55?=
 =?utf-8?Q?s6lqO20WJfpNkVdaJFjAFVnME9n0WnAeEF7BA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1RHMFN2MDBlekRTMm1CbmJXMFhrblVjZWZLc21CZU4vMVdxQUFOVVVjOTgy?=
 =?utf-8?B?aThTZ2NzN1pYaXFHd3lXWitmbDlFbXBUdjZscWhIR2RtOHp1d1BIckdqUlhL?=
 =?utf-8?B?NHdTdDlJSy90RDNTWXpnNW55ZVNvSHJBMjM2ZGxLa0dtdHR4NG9NdSszTkRq?=
 =?utf-8?B?MkZ6MmN1TnRGZFYyc2RIMDVnVTFmUXdMWU1DejZzdC92VGpyLzJubDl0WENT?=
 =?utf-8?B?NnJMSHZxT2c0VEowRlVsMm5SeHFkRTFmaDIrd1NxR1UrZWtqdjByT0dySHM5?=
 =?utf-8?B?Yi8xcmZVekpteGR4UFYzQU00ZEg4WVYvQWswNWxBclNoZGFzcWlxKzlPcDB5?=
 =?utf-8?B?b3FTdDZuZW5mTXJ5UjR6WVVka2pPaW0yZmhXR05iTElhUmVwemNiR3p1RlpG?=
 =?utf-8?B?YVN4TlBMaTlMZFQxT2lweEJ1bk9GNnVRaG1MaHNlOGlJRVQ4bkpOM255OXFR?=
 =?utf-8?B?UHlvUTE3bUNnUUtmRmFXeXlvSlBUU1UwN1g3RW1FQ0dnZVpQNG9GdDF3ZWVq?=
 =?utf-8?B?VzhETjZmTEtEMWRvWlBXR3hhZjlCczZjaUpZSGJydnhwMDNka2FYRnNlakZH?=
 =?utf-8?B?dVp6TExNZGkxdmVkWm5uMGt5bFRvdXE3UEE4NWp2eVRuNjFaRzU5czl6VXFq?=
 =?utf-8?B?Q29oZTNnTzVtT0RYbHVUYWlKZXFHTDJFRm0xa3EyRU0zb1ZwU2lNUTBlek0w?=
 =?utf-8?B?ZFJkUXQ5dG1sQ1JGUmdLb21rQzJjVUoydGlPditUVVBKSUZNaG1RL3A3TTVq?=
 =?utf-8?B?T3ZzQUNrMUVoQndubGtFdmgxY3dOaXJ5YWkvSGs5M3RxaUYrRm55dXJLOEVF?=
 =?utf-8?B?VjNRN0I1Ri9HYUE1b1R1L2VteFlDS2V6SGlFVUpjYXQ2Vno3NUFwV21ZcHlM?=
 =?utf-8?B?SWRueTVUbEZJemNhdXA4d1pYU2hyNmV6dFF2SkpXMXp1bzVoVm15ZnRqUlJi?=
 =?utf-8?B?RUVaME5pZlNjVDN4TTNiTEFybE1reVZ5MEJFWnFLSVhOVnRLWE8rYThZSUpw?=
 =?utf-8?B?SHdBRWNTd3V6YkVZRHJKL1JjUG4vbDNzTG5FUHlBL1IxVDNmbW5abk9nMm9M?=
 =?utf-8?B?Umt4RnR4cDRldVUxS0ZxcnE2eGV6OERXTFFxbWc1UUVrNGI3c2ZmWkk5YTVo?=
 =?utf-8?B?a2NhN2M2bEw5QUlrdnkyMk5VdERsN0lueGNob2UrdzB1REdVNkJVRE9yN203?=
 =?utf-8?B?WnlmOXdvWWwzVkFhdFlHSHBDNjhhYkNtTXFXd2hJekR1MmgweThiQVFkNkEr?=
 =?utf-8?B?b1lmWmt1VVp5anNLNjVPSmNodWFOa29PRFhiRWZjNWhVazJtU2FwaUVrZnAz?=
 =?utf-8?B?VFhMY01FL284dmZwYlI5NzBUdndUaW5Hdm1RRHJab2trY3AwajNCb0ZFTjNy?=
 =?utf-8?B?dy82TEcxK2FLSjBUZmxFU2ZYaHg1ZFA2RWp6SklJZDlqbmUvRnlGR3ZjUXI5?=
 =?utf-8?B?TEhHelBVRVFHQ0lwTkQyT204ang3czdpcnZSSStUR2NCcjdXM1BaMW9RK0Ru?=
 =?utf-8?B?T25sSjZTKytBYldTZG40Q2h1Z081N1hETFJWR3dKOU10cWtPelRVeE00SGll?=
 =?utf-8?B?aG1wSS9pODNRb084M3E4RHpPbFcxOFlrVXU2SWVRSVAxSWZ3cCtMekdqRUdK?=
 =?utf-8?B?R21YVFRIdzdFckw0NGxFVmhVdTlPSEtOT0VXYTlTRnFQS0hia0J4TzVJM3F5?=
 =?utf-8?B?T1FqRjVLZE1QT25GeGliRWp3eWlzeXJDb2VEOEVhNFh6WWIyN0N1M3NGT1Fl?=
 =?utf-8?B?SGxWTVVnUXI0YVI1RTVCeGk0d3RFdDZUSEpRbGtjYlQ5N1dsMDRwR21UdDZz?=
 =?utf-8?B?UUhLQ29sTzN3b0lLcWtKdUF4TWpxYTFSUnk4bFBxZXhtR04waXJZU0hxOXdF?=
 =?utf-8?B?VG5mbHV6SW1mUlhMbnJ1M3ljTE5TYlM0aEJTRHVpenJ2OE9NL0pCSm1lN3BP?=
 =?utf-8?B?TkYwYU4yNVNwVnZiTzBabUlEMUtzT3h0MFJDbW95MkMzYXJCa25zYk9HT0Ny?=
 =?utf-8?B?M3JrU2dpTnpUb1drNXllYkVmdi9QVDVXRlpaWFpjcXBWTSt6OXpVeGtSNHd1?=
 =?utf-8?B?T0E1Y0JBTlNwalBsYWdNQk9YUm5rTlNSZzBhVFpkVFdNL2N0SEFIdVN5YW05?=
 =?utf-8?B?QUR2T0dLNkdDUVZ2dHZhT0RubHV5eG8zS0hKdmJEd1pOb0VvdkQxTFNhQU1X?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9095E70EC17CE94A8E90679297D1312C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572439aa-3e97-4fea-c640-08dcbd9f9d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 03:00:41.3461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZJKX3/a71FuzTQ4ikJa1yIBiKdFkMKW/C/E7rn9GVxmakPdQvYY3eIa6nJM3KnE5RFOsIpBhDQHB1fTEvEt5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA4LTEzIGF0IDE2OjI1ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gSW5zdGVhZCBvZiBjbGVhcmluZyB0aGUgInVwZGF0ZWQiIGZsYWcgZm9yIGVhY2gg
Y29vbGluZyBkZXZpY2UNCj4gYWZmZWN0ZWQgYnkgdGhlIHRyaXAgcG9pbnQgY3Jvc3NpbmcgaW4g
YmFuZ19iYW5nX2NvbnRyb2woKSBhbmQNCj4gd2Fsa2luZyBhbGwgdGhlcm1hbCBpbnN0YW5jZXMg
dG8gcnVuIHRoZXJtYWxfY2Rldl91cGRhdGUoKSBmb3IgYWxsDQo+IG9mIHRoZSBhZmZlY3RlZCBj
b29saW5nIGRldmljZXMsIGNhbGwgX190aGVybWFsX2NkZXZfdXBkYXRlKCkNCj4gZGlyZWN0bHkg
Zm9yIGVhY2ggb2YgdGhlbS4NCj4gDQo+IE5vIGludGVudGlvbmFsIGZ1bmN0aW9uYWwgaW1wYWN0
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29j
a2lAaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwu
Y29tPg0KDQp0aGFua3MsDQpydWkNCg0KPiAtLS0NCj4gwqBkcml2ZXJzL3RoZXJtYWwvZ292X2Jh
bmdfYmFuZy5jIHzCoMKgwqAgNSArLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL3RoZXJt
YWwvZ292X2JhbmdfYmFuZy5jDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gLS0tIGxpbnV4LXBtLm9yaWcvZHJp
dmVycy90aGVybWFsL2dvdl9iYW5nX2JhbmcuYw0KPiArKysgbGludXgtcG0vZHJpdmVycy90aGVy
bWFsL2dvdl9iYW5nX2JhbmcuYw0KPiBAQCAtNzEsMTIgKzcxLDkgQEAgc3RhdGljIHZvaWQgYmFu
Z19iYW5nX2NvbnRyb2woc3RydWN0IHRoZQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGRldl9kYmcoJmluc3RhbmNlLT5jZGV2LT5kZXZpY2UsICJ0YXJnZXQ9JWxkXG4iLA0KPiBp
bnN0YW5jZS0+dGFyZ2V0KTsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBtdXRleF9sb2NrKCZpbnN0YW5jZS0+Y2Rldi0+bG9jayk7DQo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpbnN0YW5jZS0+Y2Rldi0+dXBkYXRlZCA9IGZhbHNlOyAvKiBjZGV2IG5l
ZWRzIHVwZGF0ZQ0KPiAqLw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX190aGVy
bWFsX2NkZXZfdXBkYXRlKGluc3RhbmNlLT5jZGV2KTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBtdXRleF91bmxvY2soJmluc3RhbmNlLT5jZGV2LT5sb2NrKTsNCj4gwqDCoMKg
wqDCoMKgwqDCoH0NCj4gLQ0KPiAtwqDCoMKgwqDCoMKgwqBsaXN0X2Zvcl9lYWNoX2VudHJ5KGlu
c3RhbmNlLCAmdHotPnRoZXJtYWxfaW5zdGFuY2VzLA0KPiB0el9ub2RlKQ0KPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgdGhlcm1hbF9jZGV2X3VwZGF0ZShpbnN0YW5jZS0+Y2Rldik7
DQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRpYyBzdHJ1Y3QgdGhlcm1hbF9nb3Zlcm5vciB0aGVybWFs
X2dvdl9iYW5nX2JhbmcgPSB7DQo+IA0KPiANCj4gDQoNCg==

