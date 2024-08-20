Return-Path: <linux-pm+bounces-12522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E91957EEA
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F151C20F4D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B54828E8;
	Tue, 20 Aug 2024 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gePIVD9U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C618E34A;
	Tue, 20 Aug 2024 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137485; cv=fail; b=XKWhwYxSOSPbclw79vW/SC/LepO1d0n9EfYj5PX9C/VNxq7F+cc8Sc1Fy4McgxZKJLxv+TFC7oAGbxfrehmh5d8+VL0KNx2NiY6JZDHwyTxyX9Hl7UVP3uYCgbcl4lgpgV/8bsYTqBLCuniFi4NaMge6fSVBtYLEqj/fspdiBt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137485; c=relaxed/simple;
	bh=cprf8wdxIRYCxhoxgWIjfZMc9/fH1IM6h4Rux+YYBvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HNAuCBbBZPNx95EAZDpmmq3GZq2NyB+kjCJaNzUUZqeswz80Np6zaEdmvQbgkjEP/xM78LlqwojdPdg9o69SwoVPBfUJo/D6rvS+aqqSwVLa+z/6GvL+jXKx00VCfvF/lIo8faqpDEwb8XxxrkZquZReiG2Eucx1wnaBHuAeUYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gePIVD9U; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724137483; x=1755673483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cprf8wdxIRYCxhoxgWIjfZMc9/fH1IM6h4Rux+YYBvE=;
  b=gePIVD9UK+NLDIQgzhutxkVlUU4hn4O7rqW6Eh4H/t2COlQp6Sg7f3J5
   wGYBFUkkSJUvab5zPNFuZEAS7EjFZPKDp8Y6F6nriggxIjAhCJl5P+wI+
   UnJKKImjeRVL31WI1HFGJQ0wPTqkisT/F426Y1Q2DV9ufNUC9WIW8IzyP
   OTzcfg1urGupzUfV8Yvb7STKfPyR/Em5SGfF73IZ3NGnRj+W7cJXmvB+l
   1mnfoOchwGORvceVhSVa1G5nVBkQ19LqJ+u6COmYEvfiHQZIjkv2gtAz8
   xsapfsdr6p0j/t6+vKe3sJQBqtacRT5R9loypHqTyuqUQKHOEIjd5MZRO
   A==;
X-CSE-ConnectionGUID: /YnrQ4kmR4itI8VnA5bpGw==
X-CSE-MsgGUID: L1nI7hKOSGaqFrho3fg0hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26214912"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="26214912"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:04:43 -0700
X-CSE-ConnectionGUID: s4Q/UaakTOKFPkkq2ZhoLg==
X-CSE-MsgGUID: 8zLsaQz6Q3u31iw9fgHNfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65452436"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 00:04:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:04:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:04:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 00:04:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 00:04:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5Zj3aNJ1UVcteOY5ND3eCDu0geaF+HsChc4UId06mXkJBjbqzh07oy/S0n7S4iT0gHEevq8CG2Y16f8Hk6XI3u8Oh1hBNymGt0O9V6t6tdCSagpYsGqv3ObnH1gqvDrXvDgi9ST6RjM0SnUaAa9kFPvpHUHCXyS/mAOz/gwpdLQcTOClQ2pPXrTU3zoqIntZu+gidxjZ0PVDzWZJ9fX7LD5CjdITc9UavHjlFBbZtGyn6EXfpkqELTIiUSTYGZ4d0Xj5fVe+r1Cpu1dLVD0ffBdGRdobJ4bvZp8NKdQZg/RfNtKnlpi0M+wjwGg9gitHykvlPr9v43ykiiAGNe9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cprf8wdxIRYCxhoxgWIjfZMc9/fH1IM6h4Rux+YYBvE=;
 b=qEDHby+Te3dmxVKdsuzRCPSgD7j8ShfDHtQFsnpddnTXrAXxcca/pqFSOI8yfz8viacWSj9O9COX1/znZsb6LGBP+bcmFoUX2Ttr7oF/MEP2ONyAuxQqhUWGL8v0mrglMotPeBo29t1EXm0W55FOgTvAxcyIsCcr5JVPaFFYfXjOLq720LDFdnPXgorJV5maiNg24VfqV3EeQisbV5rrwwQkcK4OpH2KF4zCLNdywvCi5cUjHnRWgGrh6oBLheH/xi6D1fJUIVtyP0vhysicH0WZ6jdhuKEm9gfjQGvrp/IYBdTpbPl4MENHqS0iUUH4AJK9RNqiEQ+oOpKomC+P3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 07:04:40 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:04:39 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 01/14] thermal: core: Fold two functions into their
 respective callers
Thread-Topic: [PATCH v3 01/14] thermal: core: Fold two functions into their
 respective callers
Thread-Index: AQHa8lMrJxefPUpdvkqIGMkGyfHLfbIvucgA
Date: Tue, 20 Aug 2024 07:04:39 +0000
Message-ID: <037c72a28a803e922819179cb0371af555bd6d56.camel@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
	 <2962184.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <2962184.e9J7NaK4W3@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5125:EE_
x-ms-office365-filtering-correlation-id: 2f89edcd-7dd0-4e1f-e888-08dcc0e65c07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UmNvb1VVbVpJVUxmTWRxZXU2UVl2ZVYwSE1kNHA4d0d5ZUxWVmRlMXdvNmR5?=
 =?utf-8?B?bTdseWdtODE2TGpRRzFYWkp0NGhBK3p5YjNZUUxwMWZ1QUZLNmNlVXFFenVM?=
 =?utf-8?B?ampWWmdPcG04dW1sdjVOWCsrUmlzRGI5R0sycE96YWw3dEowSG11TzdKZ0Ja?=
 =?utf-8?B?b2k2bEhRT0JMZHdyWmtDUHQ0R09ma0Y2dGsreExQR0FCTWY3MW16K01ZVFFP?=
 =?utf-8?B?dHkyYkZ5VTlxcUdOSXFyN0xPQkFCODdMSXZoa0hqY3RVRHJvNnVjL2VkVlg2?=
 =?utf-8?B?Z01TQlc4Ui9JaTBPMmxqeEhHbVBrdkQ1MmhWaWVSMVZ5bFJ5dG1VZFZ3dmRN?=
 =?utf-8?B?MWVwY1ROaGZyZUdmU0RFbE8wY1hZWmhmemxWV1p3ZXl3a3BwTjd3WTJWN1BX?=
 =?utf-8?B?QmVWMXpaTHlvUGE5U0hKS0J4SURYV3ZCZVNUYldhYklESzJhRllLekwydzlr?=
 =?utf-8?B?THByQnh3WlFuZ3RKTDRaOTFaK1IzS1d6dWR5UWJCVklLTnhwQ2NHMjdDRXZy?=
 =?utf-8?B?WmY2MDMxWXVsWHJFSlE3RWtrMmJFUmpXOHZLUFNtTlpMRUc5RGM0R2tCUjlE?=
 =?utf-8?B?bjBrUHh2TXZMakJlR0NkdzUvSFJCNS9IN21VbGkyTVd5Q1c0UHg2TXlHa2dz?=
 =?utf-8?B?dEliVnZzRHBnZGRYaVdLVk05OFlEdFYveTFkNm1LUUEyZnVaRzgxTHRvZG5C?=
 =?utf-8?B?KzFxbitxMEs0SFdQT21EOWlISHpGcGRxUFU1MVBTTHdmRzVCZ0NCRnQ1R1gz?=
 =?utf-8?B?a0ExNkMrYVd5RGo0SmVOZDBQWHZNbGwrN3BDUEo0RW9vVDFpTXV1NitEdDla?=
 =?utf-8?B?ejFQYTFGcnAxVG1ZanRORHNWNTAxVzdxTzc3eUNyU0t3Nm1JbC85dnZaYXlQ?=
 =?utf-8?B?WVhyQVBrcEIyTVdxN2p4Mm5FVENJczU5bFNhWGlrSW50U1N3RDBWWkYzMVBP?=
 =?utf-8?B?QU9SV1pnMnR6dTAxeTI4eGEwUFlEZ2hocVVvRlU3d0drZmFZRVdCRFYzYi83?=
 =?utf-8?B?YmtFb081Y2toZG1LcExPTGZiS0duaXZzWlhaM2hPNWR0enlINmlSbWxQK1hI?=
 =?utf-8?B?cklFVmpOVW84OUVjenFxUGF1T0ZCMmgzWWhMY3dFdm1VMlpndVpiYmZ0bHJy?=
 =?utf-8?B?OUR6RzJEblkvR3lFMjI5RW1xbENYOStwYUV2enE0emlJeXgvTFlRNXlFZXZz?=
 =?utf-8?B?SlZNZkVZQ3Y0clhRellRcXNHOElnOTJwTVFiRWhKRzJLSyttR21DaDN5akxa?=
 =?utf-8?B?aGxvalRwZlhuNzhZbUxzMEZrV3FpMG83eWh5WXFtOTB3a0gxRit5NXh4SUZs?=
 =?utf-8?B?UEFBdkZ6Z3FhZDlJcHg1NEhiQnNhcnlPQlYzRDJZU0ZMM0hLZWhMdXZzSFVz?=
 =?utf-8?B?K09FclNrZEM1Tk5sSkJWbU9OeWhBV1J4TzRDWmdWYWNjVHVQMzRjb0I5L0Mr?=
 =?utf-8?B?c1EzaVg2elRUWm1RNzFsaTBsYmxSdmg3aHpOVys0dGlBSVM4NzlCSWdxNTBM?=
 =?utf-8?B?Ni9adEV1aTRYZlp0VFZNcSsvNUN3UnE5dTVYQW9CM0F5aTNlK3VjUWpyaG84?=
 =?utf-8?B?SkZLek1MUkMxTlRuUHhxSUF0eTZkcFMwR3pMNUFKS09XME5lcXhwS042SDZw?=
 =?utf-8?B?S0JyVEVCVjVZZnBtdEVxVWcxZ1lZWFFpUTBKd0VCSmpubndnbFFObFU4anow?=
 =?utf-8?B?S1F0a3RMamEyREVvNUxDRHpjalIyU1kxdmNybnhOeDFOSGMwTWUvZmZBQ2h0?=
 =?utf-8?B?cThhZ2hyUjdvVWs3clREU0Roem1wWmhEaU5mbDZWNHA2enpaV3gzdlVpOTho?=
 =?utf-8?Q?1qWb6JTH1HE6fla45nzNNgzZ/ItN8CLYtdDXw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1g1WlczSTR2aE9OSWVRc0dJVkhrZWRWcEJEaGMwY0I1N1JiVDRoRDdaMFJW?=
 =?utf-8?B?cHFPNlMxaXRvM0pPMG5BWW9NSmRNR1grWHJqWkJ0T1o2NjRtMzA3NzJKdWZn?=
 =?utf-8?B?SWpGOTVSekFaWG1adDRPakRTQlF1QlFjR3BvTEI0ZkE4SlYrYmFoZk9oeWUy?=
 =?utf-8?B?Y2dCMUh0ZHhQM0kzUFY4dXo0em9Ma0xWRzV4YjUzalVoa2dpMXYyRDI3VG1j?=
 =?utf-8?B?b2ZZUmE4anU2SEkvSDc0ZHNyQ1RnTDhUOHFpWDViTGdHOWxENEN4VWVUQVRv?=
 =?utf-8?B?UWRDOUxkRDYxZStpWTNtcUFFOWxYQWpBQ2NkSTZGcjl5RWQ5ekc3Q0M3VjBY?=
 =?utf-8?B?RFVhRHo4Qmd5UzRYZkRSSmdibG1YcnEyS09FODNaeHE3T0E5Vjc4SmhySW1H?=
 =?utf-8?B?V1h1MW12a2krb1Vra0NiZjJpL2ZHaEJBalJmeUlnK2xYSGw4aCtMMlJZTk5n?=
 =?utf-8?B?L0hFRGEveWJNcnB0eEMrZFMzWFdkRmk4bGxmUkp5R0lyVVRWODd4ZXNyVnRR?=
 =?utf-8?B?YnUxbitrYWRUMVM5ZU5JNStzbXFzaTM2TUFPVGFDc2tIZGY2QkhsTXhsOW9Q?=
 =?utf-8?B?VWZQaEpDbElIQ1YzSjdUR2I1SmVlQVNmbDNqUnFsS2s5RHJaeERtZFQxK2V1?=
 =?utf-8?B?a3VYdTVsU3Ztc1U3TjI0Nm1za2dPS3ppdERmN1RxbFlYZ0tCTkpEWHlnVjBr?=
 =?utf-8?B?U3IyZHRLMFBLTm9ZczFRZ2h0cTNLUFlFL0xQQjJyWGwwT1d6VEpOU1VzUG1r?=
 =?utf-8?B?TytkRDFPdW44UHFESVF6c01LaVNZVW9ISHptYkdpaGtNb2NOWGJnL3pEczcz?=
 =?utf-8?B?amRCRGJObGl0Rmt3Q3I3dkIwaHB1K21ORkFFeHFPajQwWk5JZ0pGMlVGb05D?=
 =?utf-8?B?YmxvSjBsYVFRY1BkSHJRMlRjZ3o2VHdYOXJxMzBSTWxRR1lZTlJMd1hCekE0?=
 =?utf-8?B?aG1YSllSZENNT0FFZ1B6dzlWZUoyWUJ0M1B3VEJiNUxWdWFzQUpwbHVEbGwz?=
 =?utf-8?B?VkJTODJRR21oSXVEUzVRRXVNL3QxMmVwdW1PL1MwT2Q1bllrZ2lPbTNVSVNJ?=
 =?utf-8?B?TUQxM2o1ZEc2QUZvRjJlcHNNY3VzL285cWl2VGhEZFFoTjVGS0RvZU5oVyti?=
 =?utf-8?B?Y2lIQWVTcTlqWUgzdllvNkEvQ2owV1Q4NzJvZ2hKQ1k0aVZMbW9hb3BnQnpE?=
 =?utf-8?B?VktKWndGVFVqbldLUmlEaG9rN0d5K2huSlVIbm5seWVFZS9qbzdhWjBQbWRU?=
 =?utf-8?B?em9YQmxvdkNlOUlhVmJaQThwbEVzTzYzVDB3a1Z0Vmp2K1JmUlk5ZHBwMmNN?=
 =?utf-8?B?UTBPTEdMbFQ3VWw5L1lGcm0zZzY4cnh6NEcrSDRDeTR2RzJKai9UTGNBNjdw?=
 =?utf-8?B?TldPZ3d0S3pERDU4WTlIYUdTMy9ydjVqamhWTU1ST2Z2c3I1cGp4NFlOU0hL?=
 =?utf-8?B?N2IzdVJHQnFaOXV6bXJJNUpNMXFLU3Z6MWUwRnpab3k3N0VjWGFHQWtxUThL?=
 =?utf-8?B?eVFoZXd2SGtyOXhPeHBZQXN0TVhnTjYrdWg0dUl6R244VzlsSFNPMENmNys0?=
 =?utf-8?B?VGZVaktwRFMzYlFUMUVBZVBYQjhwRVhjelR6ZEtVbVdwWC9qSlBScDZ1NHJ0?=
 =?utf-8?B?d2tySWVyZmRmMC9qRnkzQ0ZMMmxrZUNBZjNxcm5VVW5ZWUhCM3lxdk5EUFBR?=
 =?utf-8?B?bXdZZXNwL3MvQVNUQXk2QjJ6NlZPYXpibXhDbHRPeTdsQlRic0tKY1MydjRt?=
 =?utf-8?B?dmdNTXYrU3FzYzJnWjZUTzlRcWZZTi9uTXRoNnlPcWZPZW1KREhPdG1kbFMx?=
 =?utf-8?B?amE3dmxZNjZialVzakRLcnYvTkJSamxYZTIybmxNbVg5MjhueDBxQXZRTlV4?=
 =?utf-8?B?OC84YktXQndnVk9iZi9iMFV2blVFQlV1c240UGxMdUFBd096K09TcGx3SVR3?=
 =?utf-8?B?bS9VRks5UXhGUExvL00way85OEdZdVRoMysydXdXWmhIT201QU45TzdycHda?=
 =?utf-8?B?amVmQXliT1RlNFJIeWhXNGMvYmRzbVZKQnJJWXNORkFleUtEamNxbUo3b0Va?=
 =?utf-8?B?SDNiUWJOcE1qd3VyUk4xemZGT1BXd2g4UC9BVzh4Q3pkMXAyckZTOXhPeUhY?=
 =?utf-8?B?eG9BaHBadnlRclBxcFFhdHdmcXNQam8wSjlBNUdBUGlKQm5Qa1FJUUxHUDB6?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAC9F30819C44F478B75F72389993CFD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f89edcd-7dd0-4e1f-e888-08dcc0e65c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 07:04:39.8173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkcRJ6OYJpCNhUHFyeNGO/0EDVKqVtn16MUXN3A1f4LUn8F12jlruwbK5tQmTH7+c2nc4zRf4vvsXYSa+orAZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDE3OjUwICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
Cj4gCj4gRm9sZCBiaW5kX2NkZXYoKSBpbnRvIF9fdGhlcm1hbF9jb29saW5nX2RldmljZV9yZWdp
c3RlcigpIGFuZAo+IGJpbmRfdHooKQo+IGludG8gdGhlcm1hbF96b25lX2RldmljZV9yZWdpc3Rl
cl93aXRoX3RyaXBzKCkgdG8gcmVkdWNlIGNvZGUgYmxvYXQKPiBhbmQKPiBtYWtlIGl0IHNvbWV3
aGF0IGVhc2llciB0byBmb2xsb3cgdGhlIGNvZGUgZmxvdy4KPiAKPiBObyBpbnRlbnRpb25hbCBm
dW5jdGlvbmFsIGltcGFjdC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8
cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+CgpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWku
emhhbmdAaW50ZWwuY29tPgoKdGhhbmtzLApydWkKPiAtLS0KPiAKPiB2MSAtPiB2MzogTm8gY2hh
bmdlcwo+IAo+IC0tLQo+IMKgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jIHzCoMKgIDU1
ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQo+IC0tLS0tLS0tLS0tCj4gwqAxIGZpbGUg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMzYgZGVsZXRpb25zKC0pCj4gCj4gSW5kZXg6IGxp
bnV4LXBtL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYwo+ID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiAtLS0g
bGludXgtcG0ub3JpZy9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMKPiArKysgbGludXgt
cG0vZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jCj4gQEAgLTk5MSwyMCArOTkxLDYgQEAg
dm9pZCBwcmludF9iaW5kX2Vycl9tc2coc3RydWN0IHRoZXJtYWxfego+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgdHotPnR5cGUsIGNkZXYtPnR5cGUsIHJldCk7Cj4gwqB9Cj4gwqAK
PiAtc3RhdGljIHZvaWQgYmluZF9jZGV2KHN0cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpj
ZGV2KQo+IC17Cj4gLcKgwqDCoMKgwqDCoMKgaW50IHJldDsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1
Y3QgdGhlcm1hbF96b25lX2RldmljZSAqcG9zID0gTlVMTDsKPiAtCj4gLcKgwqDCoMKgwqDCoMKg
bGlzdF9mb3JfZWFjaF9lbnRyeShwb3MsICZ0aGVybWFsX3R6X2xpc3QsIG5vZGUpIHsKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHBvcy0+b3BzLmJpbmQpIHsKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IHBvcy0+b3BzLmJp
bmQocG9zLCBjZGV2KTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlmIChyZXQpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJpbnRfYmluZF9lcnJfbXNnKHBvcywgY2RldiwgcmV0
KTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+IC3CoMKgwqDCoMKgwqDCoH0K
PiAtfQo+IC0KPiDCoC8qKgo+IMKgICogX190aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3JlZ2lzdGVy
KCkgLSByZWdpc3RlciBhIG5ldyB0aGVybWFsCj4gY29vbGluZyBkZXZpY2UKPiDCoCAqIEBucDrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGEgcG9pbnRlciB0byBhIGRldmljZSB0cmVl
IG5vZGUuCj4gQEAgLTExMDAsNyArMTA4NiwxMyBAQCBfX3RoZXJtYWxfY29vbGluZ19kZXZpY2Vf
cmVnaXN0ZXIoc3RydWN0Cj4gwqDCoMKgwqDCoMKgwqDCoGxpc3RfYWRkKCZjZGV2LT5ub2RlLCAm
dGhlcm1hbF9jZGV2X2xpc3QpOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoC8qIFVwZGF0ZSBiaW5k
aW5nIGluZm9ybWF0aW9uIGZvciAndGhpcycgbmV3IGNkZXYgKi8KPiAtwqDCoMKgwqDCoMKgwqBi
aW5kX2NkZXYoY2Rldik7Cj4gK8KgwqDCoMKgwqDCoMKgbGlzdF9mb3JfZWFjaF9lbnRyeShwb3Ms
ICZ0aGVybWFsX3R6X2xpc3QsIG5vZGUpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKHBvcy0+b3BzLmJpbmQpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldCA9IHBvcy0+b3BzLmJpbmQocG9zLCBjZGV2KTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cHJpbnRfYmluZF9lcnJfbXNnKHBvcywgY2RldiwgcmV0KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgfQo+ICvCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBs
aXN0X2Zvcl9lYWNoX2VudHJ5KHBvcywgJnRoZXJtYWxfdHpfbGlzdCwgbm9kZSkKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChhdG9taWNfY21weGNoZygmcG9zLT5uZWVkX3Vw
ZGF0ZSwgMSwgMCkpCj4gQEAgLTEzMzgsMjUgKzEzMzAsNiBAQCB2b2lkIHRoZXJtYWxfY29vbGlu
Z19kZXZpY2VfdW5yZWdpc3RlcihzCj4gwqB9Cj4gwqBFWFBPUlRfU1lNQk9MX0dQTCh0aGVybWFs
X2Nvb2xpbmdfZGV2aWNlX3VucmVnaXN0ZXIpOwo+IMKgCj4gLXN0YXRpYyB2b2lkIGJpbmRfdHoo
c3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6KQo+IC17Cj4gLcKgwqDCoMKgwqDCoMKgaW50
IHJldDsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZSAqcG9z
ID0gTlVMTDsKPiAtCj4gLcKgwqDCoMKgwqDCoMKgaWYgKCF0ei0+b3BzLmJpbmQpCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiAtCj4gLcKgwqDCoMKgwqDCoMKgbXV0
ZXhfbG9jaygmdGhlcm1hbF9saXN0X2xvY2spOwo+IC0KPiAtwqDCoMKgwqDCoMKgwqBsaXN0X2Zv
cl9lYWNoX2VudHJ5KHBvcywgJnRoZXJtYWxfY2Rldl9saXN0LCBub2RlKSB7Cj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IHR6LT5vcHMuYmluZCh0eiwgcG9zKTsKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByaW50X2JpbmRfZXJyX21zZyh0eiwgcG9zLCBy
ZXQpOwo+IC3CoMKgwqDCoMKgwqDCoH0KPiAtCj4gLcKgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2Nr
KCZ0aGVybWFsX2xpc3RfbG9jayk7Cj4gLX0KPiAtCj4gwqBzdGF0aWMgdm9pZCB0aGVybWFsX3Nl
dF9kZWxheV9qaWZmaWVzKHVuc2lnbmVkIGxvbmcgKmRlbGF5X2ppZmZpZXMsCj4gaW50IGRlbGF5
X21zKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqAqZGVsYXlfamlmZmllcyA9IG1zZWNzX3RvX2pp
ZmZpZXMoZGVsYXlfbXMpOwo+IEBAIC0xNTU0LDEzICsxNTI3LDIzIEBAIHRoZXJtYWxfem9uZV9k
ZXZpY2VfcmVnaXN0ZXJfd2l0aF90cmlwcygKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDC
oMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJnRoZXJtYWxfbGlzdF9sb2NrKTsKPiArCj4gwqDCoMKg
wqDCoMKgwqDCoG11dGV4X2xvY2soJnR6LT5sb2NrKTsKPiDCoMKgwqDCoMKgwqDCoMKgbGlzdF9h
ZGRfdGFpbCgmdHotPm5vZGUsICZ0aGVybWFsX3R6X2xpc3QpOwo+IMKgwqDCoMKgwqDCoMKgwqBt
dXRleF91bmxvY2soJnR6LT5sb2NrKTsKPiAtwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJnRo
ZXJtYWxfbGlzdF9sb2NrKTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKiBCaW5kIGNvb2xpbmcg
ZGV2aWNlcyBmb3IgdGhpcyB6b25lICovCj4gLcKgwqDCoMKgwqDCoMKgYmluZF90eih0eik7Cj4g
K8KgwqDCoMKgwqDCoMKgaWYgKHR6LT5vcHMuYmluZCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZSAqY2RldjsKPiArCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxpc3RfZm9yX2VhY2hfZW50cnkoY2RldiwgJnRo
ZXJtYWxfY2Rldl9saXN0LCBub2RlKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXN1bHQgPSB0ei0+b3BzLmJpbmQodHosIGNkZXYpOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJlc3VsdCkKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBwcmludF9iaW5kX2Vycl9tc2codHosIGNkZXYsIHJlc3VsdCk7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKg
wqDCoG11dGV4X3VubG9jaygmdGhlcm1hbF9saXN0X2xvY2spOwo+IMKgCj4gwqDCoMKgwqDCoMKg
wqDCoHRoZXJtYWxfem9uZV9kZXZpY2VfaW5pdCh0eik7Cj4gwqDCoMKgwqDCoMKgwqDCoC8qIFVw
ZGF0ZSB0aGUgbmV3IHRoZXJtYWwgem9uZSBhbmQgbWFyayBpdCBhcyBhbHJlYWR5Cj4gdXBkYXRl
ZC4gKi8KPiAKPiAKPiAKCg==

