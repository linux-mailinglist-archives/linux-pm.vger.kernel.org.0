Return-Path: <linux-pm+bounces-17445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D0F9C5E9D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 18:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454D11F22C7E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD2216E07;
	Tue, 12 Nov 2024 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ou5sZ9nE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC220EA5B
	for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431686; cv=fail; b=XySqt0mjYhXZzyJYgfM3ZkKzRfw0jRa+sJlsCXgrfvV+OlaB1kV7ZoAhszf6XqjRnY1T8SH9xXaenwSSo8incwlg3N/ZPt3Oz9b+5bPKsokbkC9t5319ri3Dehh2NyMFpSqNagGMbUFMoHRDZ2LCyzBiV3uTmzgjIsmbEk25/og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431686; c=relaxed/simple;
	bh=rfsEzOdLBrUw8dqrwy06K6AAZCJPz9TzGso7Nxcw4iQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XR8oeywvqyJff+LxHJ0AfbwPgQqjYgaCoaFyiEKoc1OIj4a05TsrWl/oxb8O0RcDWFt+DxyHxj3Ksd0LIJmk3I2M3UgN6VmAY2jaaSHYOxtGMADccKnsi+a3TSKQDf3mG7eVPUsFbRV5JfSYbLtyYwTVcWf8DcNqdACL1Cj/R2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ou5sZ9nE; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731431684; x=1762967684;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rfsEzOdLBrUw8dqrwy06K6AAZCJPz9TzGso7Nxcw4iQ=;
  b=Ou5sZ9nENtIoZix76EFIwuCq3IMI+/XnGcvKuLIgKzfAothhljbV+HvB
   zgPLATWv93MngTml2nggqdSHlUJpHYUlki4AMYrqG6C2KexZqqDBK/3so
   IelUzTPLG8OfJq/7/1AvyRosSOLA+URjYW6Kph90lm3uoMDDx+HiZ19Li
   x3ps8lUBrI+KANaKYl48DRqBDABoeipClsBM4AK7jFY1Yrdzd64+iHAFf
   sWvbfxMkfKj18bTGXyDAc5XILvBc/3ayvlkAQ8t/17Fik5r12Il7CZ5uK
   mw5s79GmHhFXU8sgmHumT9G1qYKQsKbyoldBq87OpTGkWiFreoF5IIic/
   w==;
X-CSE-ConnectionGUID: HjiWvMdeSQqymeNAGAqVgQ==
X-CSE-MsgGUID: s90UmAAVTYWegs0YLsTqug==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31509535"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="31509535"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:14:43 -0800
X-CSE-ConnectionGUID: Tg2NZ0x9S16o/LtzRp6Lcg==
X-CSE-MsgGUID: s6364gUvT7eCHMNdBIah4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="92353476"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 09:14:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 09:14:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 09:14:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 09:14:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKb/Lk4ePt4Sqv8+04AVRZN85zptkiqluIUJlpbl7fMR5UaXLanLVFvxE4Kji9Ae5vaYW+uFp0zq7HuOKXhF/Viy6M0kz4thrZpVyE42VNvXGF9XpPlW7JchyPLjLB5n5L5SDQWuC5f87Yaxxgme9yC+HaNSkPPFBkPUzCOH82uz211cbrMFIaAXx2s5+r7n4fZC427Qg7HQKmc9R+olWMp2r+MkVgHGTO8f6NFYNwHGML2iu2CGeggoq5BY+hLVaHnCiaZGfG+0shruGpuIPJHYtF4QiVcd8LjXjDDuFgXFnEK+5YB7656xXG4xEjRZWj3T9qVoZoyeeBeIXghmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfsEzOdLBrUw8dqrwy06K6AAZCJPz9TzGso7Nxcw4iQ=;
 b=OaiTuvjeOJaj19dMz7eYHfHCFH3QXoymOdLLXw/+Rl/3RpBrvNasWVidYjl9naEYSf36pyd/Zp4FeWf0TpZfuTDOCNNf7zslseNOoSUPZwtzGQcIB8eB807XqzTBI6DxuP7UKl5BhrfytP7KjlF7giFSMI9dDuBIcWlr/ULDLEYbESDk3pkdGwwGhzaLy8U8Djpq7DRP5B+TzVdNN7yvsQy76Lpu2ZeCbkMr3wYFjp2k8Rw1AEuzOc1L7eS7qZyx/LVendNJk+YUKh2Kqh4TrQHU/LUyolooz8gK5QNG5zZRWpbhkiU+wRaSlTsUkSgaOck7EOLGdPtFDn7sXxTOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 17:14:31 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%2]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 17:14:31 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Kurmi,
 Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>, "Nikula, Jani" <jani.nikula@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>
Subject: RE: Regression on linux-next (next-20241106)
Thread-Topic: Regression on linux-next (next-20241106)
Thread-Index: Adsz/DAyCKYmfchHQFK/BeZG6nB2bgAQVdmAADopoNA=
Date: Tue, 12 Nov 2024 17:14:30 +0000
Message-ID: <SJ1PR11MB6129A1C31D55C9ACE64D49F2B9592@SJ1PR11MB6129.namprd11.prod.outlook.com>
References: <SJ1PR11MB6129EDBF22F8A90FC3A3EDC8B9582@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <CAJZ5v0gpg7sd3Qx25WFSbGxFN6-nptxK+QtkHZMMtXW-dnaozg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gpg7sd3Qx25WFSbGxFN6-nptxK+QtkHZMMtXW-dnaozg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|PH7PR11MB6498:EE_
x-ms-office365-filtering-correlation-id: d6e80786-1c70-498b-124d-08dd033d78c2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Mnc4aFJTNStIRTdlcHNVeFNpMFM0RTFHODJkcTR6MkxFd0tQTHp6M3E4UVlx?=
 =?utf-8?B?cEY2aTlTUDA0T084akR5N0pqNmRpMjhZUkY2TGR6aStTM2hXd3dNUVZpaUtG?=
 =?utf-8?B?U08rQmdLRnRudVoySTN5d3RENzNQRloweDdvUlJmQktBRG1wWThSaEFqbmlo?=
 =?utf-8?B?dHVMY1hKMENSbkJRT1EvaDlWUWkwbHJvRnI5RUlrUnY1dGRWS09TL3BnQ2g5?=
 =?utf-8?B?WWN1VytiTVhEY3ZEY21jYkZpZG5hbjZPeDhJMU53c0ZWM1l6cEpyeURTdUhC?=
 =?utf-8?B?ZHpPNHBybCthK00zYlZMRWhCMnM2SnNLRzIxd0RWUnRKMTlQUDduOHhkdi9P?=
 =?utf-8?B?c3lOTmkyNGZrck1tT2xZMHUrZllJYndqdnlDTHdxOTJEVGxjeExiQ1VMcGE1?=
 =?utf-8?B?eGFzZ2l0ZTFnM24yc1pUOGl3M0YzK2JoMmdRbUY4Q1ZERmh4eFlmMkpqc0Jr?=
 =?utf-8?B?NnF6QmZxNjJyUzZTRjZKeTdFeUhDUzBLVDVQQXQwN085R1VaVlBOdDdCb1ht?=
 =?utf-8?B?QVJDNUQvWTIzc3N0cTRVRER1MUkxckNCbzlCTi8zdGtTQnNnMUpTM1k0amFK?=
 =?utf-8?B?T0M3dmZSQzlSRGI1ZlI5OWllVnRDY0FQOUJSRGJMMXQrSHlaR01ZOFJPeVhh?=
 =?utf-8?B?OG1kNURod1FhZlh1alY2cm0xQmpTQ09Xdm1oc3d2cDY4dzkvbVNKWERVRzRw?=
 =?utf-8?B?NFFCUFRDeUtSOEowcU5JajN6Rk5sanJ3cG9JUVFjWHFYZWNKVUhDNDJQeTE2?=
 =?utf-8?B?OStGR3luZGRyRzdlRU16RExmdENaa09XZTd1MXdpWlZzcmg2MXN4dXlwVFFS?=
 =?utf-8?B?aHJEcDdwQlJiYnd3b3dEVGVtbWRYRVgvWGsrV2t6aWNLWDBlQm1pa3VnVm52?=
 =?utf-8?B?dVBYb21ZUjlRVC9ZRlA2MlpnWTVTWUxWMEFyUXg1TWRTRHU1eVVOei83SCtx?=
 =?utf-8?B?SEc1NVpockhVVWp4N3VlYkVYNm5pSWhrMG84SE1wRUtGV0l0T3pUK2p3KzJh?=
 =?utf-8?B?Rit5cmo1bzJRSWdXZEF1OE5zckgxSm1rdEdhMEhqa0FsWUhIWVp2bklNZTYy?=
 =?utf-8?B?QzU5dlhFUUpacUNNakZ4Zm40QzlBampHTU9GdUVpamQ0VUY1aVhlWmYvMXlr?=
 =?utf-8?B?V1ZPM29DQjljMEtIY3RtUXA0bm9qTmNSSWFlclRoaU4vQUlGWndiaHQxT3VM?=
 =?utf-8?B?czN2U2l6aytpMndodlJYZEV3Y3d0cC9CcGtFZW9JZWc3ZzRGdGpXQnBibWhv?=
 =?utf-8?B?cGVMVHNkMnVWRFFhdFNlUEUwMmNhMGV4d1BENzBxeVlXR3QzQ0tadk5taWNP?=
 =?utf-8?B?MjRUWlRXOW1MTXhIU1NHK0Q3NmRmSHVsNzZ3OE5NbmNMTHFZRnBMVWFoclBO?=
 =?utf-8?B?WllqYXNnYUpIVG1wNGFISnZDOU1TTmM3eFZNR3FWZjRPQ253Y25BMlRvcVlC?=
 =?utf-8?B?OGNQK3RuSnUrY082dlRMU2hHRnFMODc5T0pYTUhBNzRIb1BkV1VrT3E0aHRJ?=
 =?utf-8?B?RXRJMWZiTG1GTHFaZVNmN1lBc0phZlhieUREaXhQWDNmN3JpUVlqdTk0OUkz?=
 =?utf-8?B?SWkwUlBnZnhwQyswSFNSL0ZYSmdmMk1CNkJSZTAxK28ydXhDM21CUXNvOE1x?=
 =?utf-8?B?WllqRjFGcm1aQXdwa2Y0OEVTdFFrSVBRTWNwSG40OHJRQnV0NWJSZk9YT21j?=
 =?utf-8?B?K0RUUDJXMngrWUlYUGZwSVJiMU9vOW5KUTFvdUJ3OU90WVFXbHNKQWRZUFlD?=
 =?utf-8?B?ek5YRWEyRFJsdmRnOWx2c3F4QUUyRWpIMDA1cXFhMnF2MmIvZHBmbnJpNDE0?=
 =?utf-8?B?dVRXYnI0bURheHVwbUFJdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K21jN1cyb2hPZ1A3VWJ6UTNvaGNEaWUwcE9aelBBSkRWcEZNajdxTWE1aDFy?=
 =?utf-8?B?WlRUSzhlN1MzR25YdnY3QnZDNlBrYzQ0c0ZadVdpYlphTWJsWndQM00vZk5v?=
 =?utf-8?B?R25VSUJsaWsvRTN0dzJIaTBycG5JaWVtSm91ZUU0QkVYQWpEK0N0RGxIaVAx?=
 =?utf-8?B?cHNObzA0V3NIMkJsS040M3JpaTlHN1VsY2QzSDQ3Kzd5ejR3LzYrVUZNS05C?=
 =?utf-8?B?bWo4TUFreUt2U0tScFcrazNmMlZmUWlveUVSRGVvK3RpUWs3WlFmaGpzazRh?=
 =?utf-8?B?aWM3UUxiRUtwYTBkQk1uVEkzSHA1WGhMOXlhRUhUQ2tVb1dKY1RQMEZ4SGNE?=
 =?utf-8?B?WDhSKzNwUnFCYkRiN1ZFazluWlhOWXk3VHVkaE9ENFZjVlpEZVRiYVNyUXFM?=
 =?utf-8?B?UDZTcEg1T1Z5UlZ6dldFZjArNXZXd0RxV1ZRRDIxRmVIbS9tNHpPL1EzNTY5?=
 =?utf-8?B?N3doUkFSMDBlU3VkV2FkanYxZ3RBY2RpOU9Sb0tQVUZ5aVBBNndIMnMxOC9Y?=
 =?utf-8?B?NDhiNGd2MUZKUnhMVk9KWGhZcysvdnZPT3pqYnVQTVNOZG56bER3ZlN0WUZM?=
 =?utf-8?B?MVd4bStNMzdYTXZHekNhamEzdWl2TytJTkRrQWZPWVdpMDRURDhkc1d4MEFP?=
 =?utf-8?B?MER6VmFzZ0J3VWJtalNPekFnZ3puK0k2YjVsMWhJdU5nOG41b1h1ajRIb3Qy?=
 =?utf-8?B?eDV5SCtRSmhWaHUzRUI5SDhtS2tKRzBZUEtoWWhuSmpPSTNOeTF1bGx6NG9T?=
 =?utf-8?B?RlN5TXlzdjExeEllTUNVelM0dWQ4Q1FrUHJ6TGlXZzB4ZW9NQVo4ZzcwK0d0?=
 =?utf-8?B?WGJCTkk0Z1lXMGxzUU84cHd3cnpCcUxteWgvQittQmlKSWMvSnlSdURSYkk2?=
 =?utf-8?B?aHg3VXZ1cTlkY1o5dzVzRGxXVlI0Szk0UzZOQTZxSnRzMVpQNHk3ZHhSWjlp?=
 =?utf-8?B?VlRVTm1LTGtRaUtzeUx5TUEyWTJDbkN1cmxwVUJVc2d4bXRBYVRoVy9sRzFN?=
 =?utf-8?B?ejViUk9vR2RZUVIzQ1ZpOWkzTmVMN1Y3QUYyT3NPT2RRVjUrdW5MME4vd2Vh?=
 =?utf-8?B?V2QvdUhWRXJRRlVyYnFIaFVSRElES1F3WHpJUU1YNzBCdDVyY01oUHlPM09k?=
 =?utf-8?B?RCtnUGxhYTVVM1ZPRk5qSWxyY0FQU0ZJQS9FSUxYa2haYkZXaklQdWllMDk1?=
 =?utf-8?B?cEd4a0tTb1hCWFM0Z09NMWNOOWk3QndMVmVJZjltSktSd3NhZmREVUh4dFZu?=
 =?utf-8?B?TlRQeXM4ZjFsZ0tzNnplUUZpQUVWdXViQnpxNE9YSHFkYWlYbWNrQllOOU1K?=
 =?utf-8?B?dXJncXRtWkR2bzBqUm50SWJjZzF1V0Q4SlE0QTUzbGFMY1BhRXhmN3MzM1VT?=
 =?utf-8?B?dE96T3FDL2JJOVY4NVdnYzFvVEVINFY2eWYxc3U2b2FGNXE5eTNLMkFXUUdT?=
 =?utf-8?B?RE9GRUczcTNaRjFhMkxscnNRVFpGZGp6K3F5N1orc3duRlNHYWFrcUpmQkQz?=
 =?utf-8?B?MFZFNFNlVDBYOEpjUG9YOXJ6MTJQaTJ4UW5HSENSd1ZIc2kzNXhtL1h4b3Bk?=
 =?utf-8?B?WHM4cnNnM0NZUVE2Z0FmVXpQaWd0VDdlTDFxekJ3YWlOWnJuWEdnYzBsUFhn?=
 =?utf-8?B?V0RPeTByelh5WnF2d0NmQjdvNml1RVZFdkhiUXI4SVhjSDh2QmVVZUF4YVp1?=
 =?utf-8?B?b0I4ZUxmb1RBWHhEKzRpUnFXMFZCQzV6dE5vZXdhbG9nNjlHVlIxMUE2Y3Y5?=
 =?utf-8?B?U2FEZjZiZUwyNkdVejgrQ1BMWmxtV0JXWjRCNG1Yb1Y0ZTloTzczVGJYdDh2?=
 =?utf-8?B?NklIc3ZFSTM5MVM1WnBGUUg4aDFWVkR2LzZEeGZWcENtWitKSzZIWjE2Tmph?=
 =?utf-8?B?MHJaWHk5THB3bW9YY0VnaE53WEQ1VWFQVDR5a0lqd3lyOGJ4R05QUWNvRlB2?=
 =?utf-8?B?YkRwVWRsZ3ZxcTYxc2Rta2kzTVl2MTdDcmd4NnhqS2hZaUhSV2t3MXppRmQv?=
 =?utf-8?B?cG93NHJIZDQwajdkOWdWY1ZiVTBXdElBNVA3a2hyUjJyYTZiZ2lzNmpabHQ3?=
 =?utf-8?B?aVFCbmJlUUtJd3A3dXNiKzJtcVBISm5tRzA0NVdRaWdoZVJUZXE1a2RvV2p6?=
 =?utf-8?B?S0o3RHJMWjZ6c3M1M0lRK0l2TjdzZlFQQ3Rsb05od3ovSWJSa1hsS3MzaXhs?=
 =?utf-8?B?OEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e80786-1c70-498b-124d-08dd033d78c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 17:14:31.0166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RhXFp3CM1/BNh+gHfLKt/UUOGIyoN7XNgX4gMMbY3+MyjlxsR+7Pl8wBvcszT3UBFXz9g2ygOu5mg55GgkxHD49ztI6agXn2hglsnnnPI+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6498
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDExLCAyMDI0
IDY6NTggUE0NCj4gVG86IEJvcmFoLCBDaGFpdGFueWEgS3VtYXIgPGNoYWl0YW55YS5rdW1hci5i
b3JhaEBpbnRlbC5jb20+DQo+IENjOiBXeXNvY2tpLCBSYWZhZWwgSiA8cmFmYWVsLmoud3lzb2Nr
aUBpbnRlbC5jb20+OyBpbnRlbC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS3VybWks
IFN1cmVzaCBLdW1hcg0KPiA8c3VyZXNoLmt1bWFyLmt1cm1pQGludGVsLmNvbT47IFNhYXJpbmVu
LCBKYW5pIDxqYW5pLnNhYXJpbmVuQGludGVsLmNvbT47DQo+IE5pa3VsYSwgSmFuaSA8amFuaS5u
aWt1bGFAaW50ZWwuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOw0KPiBzcmluaXZhcy5w
YW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbTsgcmljYXJkby5uZXJpLWNhbGRlcm9uQGxpbnV4Lmlu
dGVsLmNvbQ0KPiBTdWJqZWN0OiBSZTogUmVncmVzc2lvbiBvbiBsaW51eC1uZXh0IChuZXh0LTIw
MjQxMTA2KQ0KPiANCj4gSGkgQ2hhaXRhbnlhLA0KPiANCj4gT24gTW9uLCBOb3YgMTEsIDIwMjQg
YXQgNjo0MeKAr0FNIEJvcmFoLCBDaGFpdGFueWEgS3VtYXINCj4gPGNoYWl0YW55YS5rdW1hci5i
b3JhaEBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGVsbG8gUmFmYWVsLA0KPiA+DQo+ID4g
SG9wZSB5b3UgYXJlIGRvaW5nIHdlbGwuIEkgYW0gQ2hhaXRhbnlhIGZyb20gdGhlIGxpbnV4IGdy
YXBoaWNzIHRlYW0gaW4NCj4gSW50ZWwuDQo+ID4NCj4gPiBUaGlzIG1haWwgaXMgcmVnYXJkaW5n
IGEgcmVncmVzc2lvbiB3ZSBhcmUgc2VlaW5nIGluIG91ciBDSSBydW5zWzFdIG9uIGxpbnV4LQ0K
PiBuZXh0IHJlcG9zaXRvcnkuDQo+ID4NCj4gPiBTaW5jZSB0aGUgdmVyc2lvbiBuZXh0LTIwMjQx
MTA2IFsyXSwgd2UgYXJlIHNlZWluZyB0aGUgZm9sbG93aW5nDQo+ID4gcmVncmVzc2lvbg0KPiA+
DQo+ID4gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgDQo+ID4gPDQ+WyAgICA3LjI0NjQ3M10gV0FS
TklORzogcG9zc2libGUgY2lyY3VsYXIgbG9ja2luZyBkZXBlbmRlbmN5IGRldGVjdGVkDQo+ID4g
PDQ+WyAgICA3LjI0NjQ3Nl0gNi4xMi4wLXJjNi1uZXh0LTIwMjQxMTA2LW5leHQtMjAyNDExMDYt
ZzViOTEzZjVkN2Q3ZisNCj4gIzEgTm90IHRhaW50ZWQNCj4gPiA8ND5bICAgIDcuMjQ2NDc5XSAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
PiA8ND5bICAgIDcuMjQ2NDgxXSBzd2FwcGVyLzAvMSBpcyB0cnlpbmcgdG8gYWNxdWlyZSBsb2Nr
Og0KPiA+IDw0PlsgICAgNy4yNDY0ODNdIGZmZmZmZmZmODI2NGFlZjAgKGNwdV9ob3RwbHVnX2xv
Y2speysrKyt9LXswOjB9LCBhdDoNCj4gc3RhdGljX2tleV9lbmFibGUrMHhkLzB4MjANCj4gPiA8
ND5bICAgIDcuMjQ2NDkzXQ0KPiA+ICAgICAgICAgICAgICAgICAgIGJ1dCB0YXNrIGlzIGFscmVh
ZHkgaG9sZGluZyBsb2NrOg0KPiA+IDw0PlsgICAgNy4yNDY0OTVdIGZmZmZmZmZmODI4MzIwNjgg
KGh5YnJpZF9jYXBhY2l0eV9sb2NrKXsrLisufS17NDo0fSwgYXQ6DQo+IGludGVsX3BzdGF0ZV9y
ZWdpc3Rlcl9kcml2ZXIrMHhkMy8weDFjMA0KPiA+IGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGANCj4gPiBgYGBgYGBg
YGBgYA0KPiA+IERldGFpbHMgbG9nIGNhbiBiZSBmb3VuZCBpbiBbM10uDQo+IA0KPiBUaGFua3Mg
Zm9yIHRoZSByZXBvcnQhDQo+IA0KPiA+IEFmdGVyIGJpc2VjdGluZyB0aGUgdHJlZSwgdGhlIGZv
bGxvd2luZyBwYXRjaCBbNF0gc2VlbXMgdG8gYmUgdGhlIGZpcnN0ICJiYWQiDQo+ID4gY29tbWl0
DQo+ID4NCj4gPiBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgDQo+ID4gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgYGBgYGANCj4gPiBjb21taXQgOTI0NDdhYTVmNmU3ZmJhZDk0MjdhM2ZkMWJiOWUwNjc5YzQw
MzIwNg0KPiA+IEF1dGhvcjogUmFmYWVsIEouIFd5c29ja2kgbWFpbHRvOnJhZmFlbC5qLnd5c29j
a2lAaW50ZWwuY29tDQo+ID4gRGF0ZTogICBNb24gTm92IDQgMTk6NTM6NTMgMjAyNCArMDEwMA0K
PiA+DQo+ID4gICAgIGNwdWZyZXE6IGludGVsX3BzdGF0ZTogVXBkYXRlIGFzeW0gY2FwYWNpdHkg
Zm9yIENQVXMgdGhhdCB3ZXJlDQo+ID4gb2ZmbGluZSBpbml0aWFsbHkNCj4gPiBgYGBgYGBgYGBg
YGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
YGBgDQo+ID4gYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGANCj4gPg0KPiA+IFdl
IGFsc28gdmVyaWZpZWQgdGhhdCBpZiB3ZSByZXZlcnQgdGhlIHBhdGNoIHRoZSBpc3N1ZSBpcyBu
b3Qgc2Vlbi4NCj4gPg0KPiA+IENvdWxkIHlvdSBwbGVhc2UgY2hlY2sgd2h5IHRoZSBwYXRjaCBj
YXVzZXMgdGhpcyByZWdyZXNzaW9uIGFuZCBwcm92aWRlIGENCj4gZml4IGlmIG5lY2Vzc2FyeT8N
Cj4gPg0KPiA+IFsxXSBodHRwczovL2ludGVsLWdmeC1jaS4wMS5vcmcvdHJlZS9saW51eC1uZXh0
L2NvbWJpbmVkLWFsdC5odG1sPw0KPiA+IFsyXQ0KPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY28NCj4gPiBtbWl0
Lz9oPW5leHQtMjAyNDExMDYgWzNdDQo+ID4gaHR0cHM6Ly9pbnRlbC1nZngtY2kuMDEub3JnL3Ry
ZWUvbGludXgtbmV4dC9uZXh0LTIwMjQxMTA2L2JhdC1hcmxzLTEvYg0KPiA+IG9vdDAudHh0IFs0
XQ0KPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25l
eHQvbGludXgtbmV4dC5naXQvY28NCj4gPiBtbWl0Lz9oPW5leHQtDQo+IDIwMjQxMTA2JmlkPTky
NDQ3YWE1ZjZlN2ZiYWQ5NDI3YTNmZDFiYjllMDY3OWM0MDMyMDYNCj4gDQo+IFRoZSBwcm9ibGVt
IGlzIHRoYXQgY3B1c19yZWFkX2xvY2soKSBzaG91bGQgbm90IGJlIGNhbGxlZCB1bmRlcg0KPiBo
eWJyaWRfY2FwYWNpdHlfbG9jayBiZWNhdXNlIHRoZSBsYXR0ZXIgaXMgYWNxdWlyZWQgaW4gQ1BV
IG9ubGluZS9vZmZsaW5lDQo+IHBhdGhzIGFuZCB0aGlzIGlzIGV4cG9zZWQgYnkgdGhlIGFib3Zl
IGNvbW1pdCwgYnV0IGlmIEknbSBub3QgbWlzdGFrZW4sIHRoZQ0KPiBpc3N1ZSBpcyB0aGVyZSBy
ZWdhcmRsZXNzIG9mIGl0Lg0KPiANCj4gQSBnb29kIG5ld3MgaXMgdGhhdCBpcyBzaG91bGQgYmUg
YWRkcmVzc2VkIGJ5IGEgcGF0Y2ggdGhhdCBoYXMgYmVlbiBwb3N0ZWQNCj4gYWxyZWFkeToNCj4g
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBtLzEyNTU0NTA4Lk85bzc2WmR2UUNA
cmp3eXNvY2tpLm5ldC8NCj4gDQo+IHNvIHBsZWFzZSBsZXQgbWUga25vdyBpZiBpdCBtYWtlcyB0
aGUgc3BsYXQgZ28gYXdheS4NCj4gDQo+IEV2ZW4gaWYgaXRzIGNoYW5nZWxvZyBzYXlzIHRoYXQg
aXQgaGFzIG5vIGZ1bmN0aW9uYWwgaW1wYWN0LCB0aGlzIGlzIG5vdCByZWFsbHkgdGhlDQo+IGNh
c2UuDQo+IA0KPiBUaGFua3MhDQoNClRoYW5rIHlvdSBSYWZhZWwgZm9yIHRoZSBwYXRjaCwgd2Ug
Y2FuIGNvbmZpcm0gdGhhdCBpdCBoZWxwcy4NCg0KUmVnYXJkcw0KDQpDaGFpdGFueWENCg==

