Return-Path: <linux-pm+bounces-7623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B148BF553
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 06:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2A01C22124
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 04:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5223910A1B;
	Wed,  8 May 2024 04:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkWxrAxo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE15199A2;
	Wed,  8 May 2024 04:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715143648; cv=fail; b=jesdyqUkGt7G4ZV+ZDJp4XgYHLxQFzEYfrJ4BeoeISeakdtgv0tNoGxnELMUjA8GHv0vHOzH0nd1EHPJOBDjP2VyJQkR19lf8NpeWZIyRSv3OuPfG6NAwH9rhrobwIcAJryg3wX8Mj5HsO7UPAtbLiYup2/8RovlkYftVtKG/QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715143648; c=relaxed/simple;
	bh=tqbxVtU/btsZa85lA4zCksBqdq8tbJxf0jRjoyJMcg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nBEONGaKU8eaQMY5vmmZUgo5gis8L94igGt4Y5VYmKRVEABwvrjWXasddoKfuxhbYBI47KKccyyGZn/ijyIIhSP4YjZcEe3W1y9fPeGAZ8c2PMg98PmhzjvciD9zl87BBYQmYftwiiRPwZhdKu/R2pDX/Nd8xvuZ/qzVoy5GM4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkWxrAxo; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715143647; x=1746679647;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tqbxVtU/btsZa85lA4zCksBqdq8tbJxf0jRjoyJMcg4=;
  b=mkWxrAxoh1tBMd+XZgCdrutbpieli1I5HKQxf+/ZZprthuKQf+iOUcJ9
   C99wiKpRqtxrzgUCQNQBI7kIesv6zM3E4sXO96m+9TXIzKCjAePCmbTvz
   6cNZrngRLXuCm5AFv/HWFgq4Laec0h7/+eYLkfJiyIljHvjBlBDNqfchH
   aKXJjpz3jrZZ6YF7Cdp22BmS3IaJ5mQ7/o7ggDtnidtcCa2fayZ0NncU3
   KFl+BgJ9Z1FRn6+Wf1nbQG6B8zXxJtkWCB3zKeBDSPRkFtK9fnJyZG0nI
   VhJ/2sRFj5gxniBQMOm/0AGFigVOKRDgpdpbyfAv0HcFeQ6Sagn8UQYSb
   g==;
X-CSE-ConnectionGUID: C6fdXy1+ShqkP78BTvhlSg==
X-CSE-MsgGUID: leV6Mb1aQ52Y+11lFCciUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22134410"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="22134410"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 21:47:27 -0700
X-CSE-ConnectionGUID: FUTrG1zJTWG8NZc9QjFcbQ==
X-CSE-MsgGUID: 0hJCQ1OMQuaXIfyrRJSq1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="28849779"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 21:47:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 21:47:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 21:47:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 21:47:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 21:47:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5jZNv9K1UzSL/0P0ospa9tKeD6urWY+ShUO9bp6tESKTjKhUuQShOXOxDwv4Jrprf5v8GrHyM8eLvYA4vfAgrrtbmX70T6A8KIymE/FCmJKVRA0Ed7MEeGbwoMJW+zq6Xar42s7CYmuxOtk4b+uNGKyTvIdM0WTruZptCgtE6+gJwxzLZgLzpgOXUmzdbUD/C3+BVJUVxvCQZmFsXYvkH+vwpED+d82mKsOIoFNqfBfqAtmSjsyP7kT6SubOLRccfF60mKAQIxEKWi4xdyqeyMzCvv8ud6ts6iZOJfh2Pfmfmok2N3wwAje06yUH5LoX2bLbJrwhg/ZA9RgaQW+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqbxVtU/btsZa85lA4zCksBqdq8tbJxf0jRjoyJMcg4=;
 b=L42vcABr3PG6u4COv3hiyJb+wOEGg3KhsNNe7zwsP6OKGp1Z+CrB8s+E/CUYbDaJ6uK5YjhjfAaxepaTleJG7t7V9BIkWVvxnGzK4bYNqecbEjiyLgq1/waJJK59UdlDRMU4oNdVrePggMZz0gLiI1+uFgWpY3H2A5Duwc1CkFt8gvSf/pTHoEIhAMKXzkZbm0x00gIyXGn0oiy2kx7fxdc7+6wZm1H5emUw4XCsZC/aM/wqXINsr4KzfMeOfeBfPUwB5RJEpcBEyYPkLVoeRYwB5f4cv27heg6RJZ1nDsEwd2AKqeoGUpL//iCLJAE3KUWkpKlTbnjI31UTrP9WkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB4944.namprd11.prod.outlook.com (2603:10b6:a03:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 04:47:23 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e620:6fe3:711c:a6bb]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e620:6fe3:711c:a6bb%5]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 04:47:22 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>
CC: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "Brown, Len" <len.brown@intel.com>,
	"stanislaw.gruszka@linux.intel.com" <stanislaw.gruszka@linux.intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Neri,
 Ricardo" <ricardo.neri@intel.com>
Subject: Re: [PATCH v2 4/4] thermal: intel: hfi: Increase the number of CPU
 capabilities per netlink event
Thread-Topic: [PATCH v2 4/4] thermal: intel: hfi: Increase the number of CPU
 capabilities per netlink event
Thread-Index: AQHaoPj8NJ9UHa/zukqubv1/m3Oi+LGMw62A
Date: Wed, 8 May 2024 04:47:22 +0000
Message-ID: <27ccbb20741b2a2f86074f0ac4bda61aadc9faa3.camel@intel.com>
References: <20240508034352.18414-1-ricardo.neri-calderon@linux.intel.com>
	 <20240508034352.18414-5-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240508034352.18414-5-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB4944:EE_
x-ms-office365-filtering-correlation-id: 364a9d81-3938-42b8-5e7f-08dc6f19f36b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Qjkyejl0cGFPdW1PRHQwN2w3S25sTzdCZ2hMckF2N082OEkzU2tqODN5eG53?=
 =?utf-8?B?a0NFQ0Z0NG11TDRpbWlYTmU5SjBJRFFNS2tDc0VWVHBsam8xYThYQ3pYN3hZ?=
 =?utf-8?B?KzJRR0ZyVWhJdjQxM3RYQ2w5eVNuR3FQZHAvK1Y0UnF1VzFhNE5Ic1ZUSy9I?=
 =?utf-8?B?UVhrMDJ2V1J4OXNCdEpWaFhhbVNPaHBnRXRlQ1VDM2FlWVM0aTI0SUo4bStX?=
 =?utf-8?B?dk03OEF3SzZxK1l1SFRiaklNYVNSeXFIYythMDV5U0VHYUI0SXlkWXBMYmhM?=
 =?utf-8?B?TU1mUlFqaGRaZm9DMzJhVjdUY1RCSHM2Qml2WXlTM2V0ZlMyODZ6blh2U1Jy?=
 =?utf-8?B?YkRiZWZOOUMrbGZxanEvM1hTRlUwNDhjVDBBY3I5bTRvTTREbXNuNldXM3Zw?=
 =?utf-8?B?eTlVQ3pTZUt2MEkzWWJ6Sm5lYVNrcnNFOUlVNWFWUmEycnQ4d0lWekhiamJJ?=
 =?utf-8?B?R2N3Vy9tTGxpVlJXb3VLQ3ZZTDFISWZ0T3BQbWpuVjBxaWk0MitCcUpRZVVv?=
 =?utf-8?B?S1NBUWsrS214NUpCY2YwZ1BOajc0UlpWRCtHeHNwZU1VYXNwYnIwQmhwejJB?=
 =?utf-8?B?bjllS0RseXZreFJUenZQblAzMmxrWVJ3QjJYOW1UYkZLZUZ6a21pTUVnK0R4?=
 =?utf-8?B?WFpEcVNNZ3dvNUJwa0JZWE5jQTZhdWZIZVB5dTRYRStCeDVITU5CcnR2YmQr?=
 =?utf-8?B?OCtITENGY3p6Vm1PenRKUDdhMjlJV1VUdUVvRXVkSC9mT0RCb3R4Z25DNGVT?=
 =?utf-8?B?TTRtVEJ4Yi94MGZtMTBYZXFnWWU0WTFuN3k5MEJPSGVBTG55STBQNk5ZWmc1?=
 =?utf-8?B?TWFaWFpXZkJHN3VNOGJwN0RFei90ajNLODVWK1p5c3NHaGo0dUdFWGFBcHBB?=
 =?utf-8?B?ZUUzM1NxSXhZSjYyRDFNN2g0SGx0VXJYNjJpTDVEVXduN3VFb3Q4cVdkTEJ5?=
 =?utf-8?B?WHlnRG1jRTFqVkM3SWNjN005VWlQRktyVkxFbFBZL015RlFmUm4wS3JvTkJn?=
 =?utf-8?B?Z2RoenFwZXV5L3BYK0tCTDVIUXluc0drZVAwcWQ3U251eFNYZmdFTnkxb2dC?=
 =?utf-8?B?WDV2UHMwYjEvK25jbkliaTI5NGVDRHhSU0F6a0JCaXpYR3RGeHQ1cnV5TzBY?=
 =?utf-8?B?dEFqZlpiMEJ3VlVCaXVQQ2JZOTdxNzVpV3AvWnVZOHBxZzBBWC9CaXBJWUVM?=
 =?utf-8?B?OVZad05Jam91b05aMkFHWHlPL0RuNzNQK1pvN2JGL0VMNkNYZHlmblN5ZStI?=
 =?utf-8?B?VmJyK1RqWWg2ZlZIek5uSmxHeXpOTDdvczlPYkNia1NNWnQvemx0OGhFSUVV?=
 =?utf-8?B?TjgzakVXWVNMTXM1YVhlNHhqZTJCaUJsb0oxeVhEblhYV0ZmdG1MWmRiVDh6?=
 =?utf-8?B?TE5LeUlJa1F3SkFDbGIxdDlsc1RoQ3BWS0tXQkxuRHRjZU5pZ2NGdHBaMHM0?=
 =?utf-8?B?WW83SmxmRkZUdFp6ZGkxTzhQSnZQZHBtbDhvNk5XUHdkWWJ4dWFmb2sybTY5?=
 =?utf-8?B?KzNqZVNmczhQSGs1WlduaHQ3RnZKT2JVdHFtR1dJZS95UkIzY2wwTndON2lR?=
 =?utf-8?B?eENSZFRwVG1pb2xtN2lWZE54c2FMS3drRzAyaldvWEFKOXdrV0I0STByY3lm?=
 =?utf-8?B?dmp4RXY0czZQbG15SUJ6OUwvY3gvbVorTmNiR0ZQN0EwalNBMVM0OHA0ZUor?=
 =?utf-8?B?bmJGcDhadUlHUjA4T2IxRFl4L0VOWUZ4SVAwL2NYWmVhME14L1lBcWZCK2pX?=
 =?utf-8?B?SThWdFRKQW5qRkNWT2pzSnpENnBwVUhyNWdUdFBHb0ZWMnRVc2VVYVVtSnhu?=
 =?utf-8?B?RkxhamRmVWZDaDBaNHJpUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1J2ckVVT1hneVFMRUh5R3N2QndGS3hsQWxzMGZsdkJYcUREeUZCU1lneGpU?=
 =?utf-8?B?S0xidm9WcmZDUG41VXFkQm1KTzlkS08zN0ZUOHYvbi9HMDJlMGZHRlZWZndv?=
 =?utf-8?B?Zk1NU2paajlhNnRTTys3YVJTQWJaTmtKeWFTcHF0QnNoWlNnaW5SKzlKd3ln?=
 =?utf-8?B?UXErVkMrL3UzNURMeFM1RUt4V3Q2aDNJeUVEbXdlUW94aklxbzZPaUlFUHVD?=
 =?utf-8?B?S3ZLd3BZbXNQajloUENFdnVzcFV5OC9WOFBDZ0Z3dXRmZVFMTWovdGxWblRk?=
 =?utf-8?B?a0hlSWdybjExaEloY2VrTzRFZTBYbkl6UmtMdU5uQ2NxTkZ2N2twaVJxRk0w?=
 =?utf-8?B?T2d0ZmkwZVViY1duMDgxdUxLUWtVOEQrMU53anRFQjdMWmV5aEhrQjRpWG15?=
 =?utf-8?B?ZnlnbWoxbTB6eHJNNmJUR0xBSXVnREJkbnZ3clFxTHlhWmFQWjYrK0JWb3Jl?=
 =?utf-8?B?RkJsTDBWRjBwT2VvMkljWVNZNFg1emtSMmJiM3ZkUlFiVXRvbHJYUTR1Skl5?=
 =?utf-8?B?R3VKSWt5RVpRY0hYcjlpdmgrTEJBUTlGbjFjd3pNeUFhWGlVYUtKR2pBK1pK?=
 =?utf-8?B?aklVTS9MYUxTb0x6TzUzTXpnTDZXcFltL2VScVR5dzY2dnhHV1FCZWNvcXo5?=
 =?utf-8?B?VGYzTWt3VHRCK3lmbUd0aitCRlI3Uk9sYmw0WkcyMlpSWVdENGRKbXpsVTFI?=
 =?utf-8?B?c0QrOVNrcTNDRTRNTzZnejhSd3FqZ0pBQUdYa0xPNDZrWXRYelZJb0swMDVZ?=
 =?utf-8?B?c1E0a0RiRVhLNDhqRG5WaFhMODBSQ1Q3NlZPb3QvckpEM1ZscmplUDFPeStI?=
 =?utf-8?B?NFFXYVpmQ05mcXdpY2R4SGQzTXFOdVduRTdGeUNCaE5mb25uWTR4TWRoQVJN?=
 =?utf-8?B?WnhncjJiVE5PdW55UHlvajhEVE1SaThYeWFqR1pyTkZVK3VQQmJxNXFENkFw?=
 =?utf-8?B?L2NjT3hCeS96MG9YaXhTQ0VUSHdJYTk2NWxKZjdYMlptODc1N01Fc1R0UjZQ?=
 =?utf-8?B?cWNjcnk3cUE5RXorTHpVd1psU3ZCUzNLcVVKeEVzWW5tZWJpd2Q2KzRZNGln?=
 =?utf-8?B?ZTY1SmR3Ymowb1V5UFlmM0VsS2dGTDJYWTRrZWNZUUxUbWRrY2R2cEVaZWxV?=
 =?utf-8?B?bW5zVGdwNXIxaTI1Ymg0TnJtejhha2xPNHk1Q1ZHekVxeG5JNmJRY1FmM29X?=
 =?utf-8?B?SU1NbXVmSlkzMlpNa29BMmNqT2liSnFmWFk1U3g0WUJ1SnJFMFVWWFhKczZK?=
 =?utf-8?B?bXlWNlRKUXpDMEpOZHNTR1BDNlVvMzlQTEpWTFc1THZHWWlmOERUeUFjQkZZ?=
 =?utf-8?B?VElobTAwY2RqSzNnL3N1Y1d6VGZieFI2Skpjald4WFlpbjQrajF4aUZzYU1J?=
 =?utf-8?B?bUFTZGdSeHFKODUzN1FBWmtvUlhJODYwSDc4MHh0RVRwY3U3U0xzVmdFMHA5?=
 =?utf-8?B?UE1qRGVTV2NvRmhlK2NuVnRmSGMvSVpibVNGV2NtdzliQmJreDNHM0pCYXBJ?=
 =?utf-8?B?R1VyVVRhTFJydjdjV0pWbHI3cTZoVU5GWEYvSEhsdVdPTUFUc1NaMjdDajI4?=
 =?utf-8?B?dy9rblVsUDJGT0pTc1lnWlNxUE9WVkZTQUtrNnlHOGlDWFNxcElCOTN6cngv?=
 =?utf-8?B?ZzE3NTM0b3Rzdll6VHFITThlR3o1Mzc4MGNOMWZVZWxFbnpYOGp3aFRrSmhZ?=
 =?utf-8?B?VEdkeUJsRGFpV2lOTXQ5QUkyNVJ2TmUxZ2xidDFYM2lrWFM1bFpMNHVzMFM5?=
 =?utf-8?B?YUdTbHJxNHAvSStHeTd1TlJGNmJvbEVjMDc2Q0h0dzJUbGJDbkFNdGNmOWw2?=
 =?utf-8?B?cDMrbWRPNHlqaWtBanRDd0ZRKzNXRUN0SGVJdUhscVFrWXR6NG1kcDUyZ1dT?=
 =?utf-8?B?ZUwyTFZyMDBTYk9Vdyt2WjR5ajV4b2hVQ2ZwUzFWZHd0UXFFMnljOGUwSGhG?=
 =?utf-8?B?Vk9GRzNycFVJclBjQm1JZnVrNGdRS3hMM2VsRFNkMDhJM2pseWRsaFplc2Nt?=
 =?utf-8?B?RGpQSGR1clhna0ROVFcrY3BwRW1OU1gzTFBuYzltaUZneFBEbVg3azZGTkVr?=
 =?utf-8?B?cmY5WXY0T2VWa1YyL2tQdko4eGhyRmFFUEtCeGtDTm5GU1ZTdzhzbU1pamJW?=
 =?utf-8?B?ZGFtc3BiVFdsNjV1S3dLNDBpMHM0MU9nSktUTUZ5d3pYWFZKZnNIVlFBQmFE?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4E57F43F1370043A0847957F79C9CFB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364a9d81-3938-42b8-5e7f-08dc6f19f36b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 04:47:22.8120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wkXdf0g/po9BnciskyPzz9BZlENnA2cf5vrVjP+/0L9NEw8LR9fOVXfBGuTrps++Qn6hI7dW3qEl/B1l17CvvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4944
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA1LTA3IGF0IDIwOjQzIC0wNzAwLCBSaWNhcmRvIE5lcmkgd3JvdGU6DQo+
IFRoZSBudW1iZXIgb2YgdXBkYXRlZCBDUFUgY2FwYWJpbGl0aWVzIHBlciBuZXRsaW5rIGV2ZW50
IGlzIGhhcmQtDQo+IGNvZGVkIHRvDQo+IDE2LiBPbiBzeXN0ZW1zIHdpdGggbW9yZSB0aGFuIDE2
IENQVXMgKGEgY29tbW9uIGNhc2UpLCBpdCB0YWtlcyBtb3JlDQo+IHRoYW4NCj4gb25lIHRoZXJt
YWwgbmV0bGluayBldmVudCB0byByZWxheSBhbGwgdGhlIG5ldyBjYXBhYmlsaXRpZXMgYWZ0ZXIg
YW4NCj4gSEZJDQo+IGludGVycnVwdC4gVGhpcyBhZGRzIHVubmVjZXNzYXJ5IG92ZXJoZWFkIHRv
IGJvdGggdGhlIGtlcm5lbCBhbmQgdXNlcg0KPiBzcGFjZQ0KPiBlbnRpdGllcy4NCj4gDQo+IElu
Y3JlYXNlIHRoZSBudW1iZXIgb2YgQ1BVIGNhcGFiaWxpdGllcyB1cGRhdGVkIHBlciBldmVudCB0
byA2NC4gQW55DQo+IHN5c3RlbQ0KPiB3aXRoIDY0IENQVXMgb3IgbGVzcyBjYW4gbm93IHVwZGF0
ZSBhbGwgdGhlIGNhcGFiaWxpdGllcyBpbiBhIHNpbmdsZQ0KPiB0aGVybWFsIG5ldGxpbmsgZXZl
bnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIE5lcmkgPHJpY2FyZG8ubmVyaS1jYWxk
ZXJvbkBsaW51eC5pbnRlbC5jb20+DQoNCkFja2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0Bp
bnRlbC5jb20+DQoNCi1ydWkNCj4gLS0tDQo+IENjOiBMZW4gQnJvd24gPGxlbi5icm93bkBpbnRl
bC5jb20+DQo+IENjOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxp
bnV4LmludGVsLmNvbT4NCj4gQ2M6IFN0YW5pc2xhdyBHcnVzemthIDxzdGFuaXNsYXcuZ3J1c3pr
YUBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+
DQo+IENjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgdjI6DQo+IMKgKiBEcm9wcGVkIHRo
ZSBkZWJ1Z2ZzIGludGVyZmFjZS4gSW5zdGVhZCwgaW5jcmVhc2VkIHRoZSBzaXplIG9mIHRoZQ0K
PiDCoMKgIHRoZXJtYWwgbmV0bGluayBtZXNzYWdlIHNpemUgdG8gNjQgQ1BVIGNhcGFiaWxpdGll
cy4NCj4gLS0tDQo+IMKgZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX2hmaS5jIHwgMiArLQ0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9oZmkuYw0KPiBiL2RyaXZl
cnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9oZmkuYw0KPiBpbmRleCBjNjY1OGY4YzVjY2EuLmExODBh
OThiYjlmMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX2hmaS5j
DQo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9oZmkuYw0KPiBAQCAtMTY3LDcg
KzE2Nyw3IEBAIHN0YXRpYyBERUZJTkVfTVVURVgoaGZpX2luc3RhbmNlX2xvY2spOw0KPiDCoA0K
PiDCoHN0YXRpYyBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqaGZpX3VwZGF0ZXNfd3E7DQo+IMKg
I2RlZmluZSBIRklfVVBEQVRFX0RFTEFZX01TwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMTAwDQo+
IC0jZGVmaW5lIEhGSV9USEVSTU5MX0NBUFNfUEVSX0VWRU5UwqDCoMKgwqDCoDE2DQo+ICsjZGVm
aW5lIEhGSV9USEVSTU5MX0NBUFNfUEVSX0VWRU5UwqDCoMKgwqDCoDY0DQo+IMKgDQo+IMKgc3Rh
dGljIHZvaWQgZ2V0X2hmaV9jYXBzKHN0cnVjdCBoZmlfaW5zdGFuY2UgKmhmaV9pbnN0YW5jZSwN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCB0aGVybWFsX2dlbmxfY3B1X2NhcHMgKmNwdV9jYXBzKQ0KDQo=

