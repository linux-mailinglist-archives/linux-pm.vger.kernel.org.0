Return-Path: <linux-pm+bounces-10092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12812919F8C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 08:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3EAB22399
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 06:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2BB3A8D8;
	Thu, 27 Jun 2024 06:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ii1v714s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FEF29CA;
	Thu, 27 Jun 2024 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719470978; cv=fail; b=lQo0mmbTP/S4UwC61WzGx9FX5lPTp5MXJrO9nakBkWo3XrturyYE0+5FWe/xMkbcbP1wlehfCixmQ6o2B7kbPzjhoKM81Eq6OICiHInB4nKMIF+6uBAhzuAfQ8JCjjGzYrntDPLtPnCI2j6pJ3AgV4UzUpLcXeA/H/cgsB0qkQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719470978; c=relaxed/simple;
	bh=C4sYzPjvW85naXFPkBu/THo6rP0J0wKxaRU5DARLty8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ewZSW4B7Lm7CR28Gi5pWSTG+sm9Xs08/fMMNIPXyUILM896jDTLbWwdfmSOaXqyfIWddlrHRrCaOrfJIXuApv7L3JhOke8bQz6C8fTXuH54g9jUEa50r4Awiuvy5BZxfGlDTnHwoXwefjg31u2EtflnzKYUHPOKO5RhLww6iRVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ii1v714s; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719470976; x=1751006976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C4sYzPjvW85naXFPkBu/THo6rP0J0wKxaRU5DARLty8=;
  b=ii1v714sFPgJ0Pz2lcpllcAqklOZlxoicnM3KZdqdKILDKfdPoa4UGsq
   5AshOhsBsWYTqgwLcpYxa5JYDHrAkDHrR/4tjC+7B4EY0wghOQGEXE0PT
   M6fM6A7UyOdR6F7uesEMG7LIs1miN7OJVRAl0Ep8Ya9sw/Mk5Mr+Yu1zq
   OdEiq+3H72nf+3fxSwF+0s2P2WY0oKT7NIdfByCY8YuguCPKo7OLQGql7
   NfaR+X1rwf4pir8kAafV0lUrAMaa4eYhD8skxSqQ/fEbvbmJeIHMw4GZK
   sOSjv63vMrZHPHmqJc25UrYoWwsbjBBa2mCmA6EzqIbGP+LFR0Jvoiekh
   Q==;
X-CSE-ConnectionGUID: tk1assOhQyuKGGZca3ZuxA==
X-CSE-MsgGUID: pX9kCtSxSF6VqBBNDdpWkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="12274727"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="12274727"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 23:49:35 -0700
X-CSE-ConnectionGUID: FxI0tbocTVGpOC5ijnl/yw==
X-CSE-MsgGUID: 9sck7i7iR5SwrcJWWIyo+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="48738327"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 23:49:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 23:49:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 23:49:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 23:49:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz8l385LbPZ9sY7g4eugZInaocxgKn5nbccFBQSuK2s7RLYfTzc+AIIkOODzNUgs7uxTZcq+DijWAsF7PPJpPaf7iJbFgSL58r3NUEVhWWYg1KQY2aQfbr5GK7t2SX2KBazzz5JbOIvqHKlP8ADgd+hQlk+clg7bHaxb127rSi8VxwkqORnmBWS4O8zbmw04bXAC5afRS53bDPis51p2zSqZ6OtHgF6FGRSXcmLYZdBQwS83Koxj5wJoiVjgnzlk1U5gAHTiuBElx7OGFkUDAIhr1Io/xwY4yKaRAYboHMJ/4+2yVT560y6MjfeHjotqtYV35YwqHm3/rfSiqR6PTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4sYzPjvW85naXFPkBu/THo6rP0J0wKxaRU5DARLty8=;
 b=ZYqyQjDWT2WSUpLt+xZDBEJx1mcpT3F67I+MKG0ys6edVJg1M21sXn+z6BmhirX+AHfgGIDTvk8AAO0TGlOC1ygWfDO9sQM2cHxHpN7m4yc5HV36ANRz3lppuavTPkZjjduWcZz5LPvUDOerYeaSfn2Vt9Tmx0g6XjwCHNsxUgi3onVo6UKlKyDyUeSvecGROHmxaiBZHOWkJ4u4WVS9XqFIWczOg32goftedHPqLo05h13MfSEmUg816jC4NOdbDde/1JJCTbFsTuGtSeXWiHWoBTdOwKt7IGPHwsLSpuppRJHpl8AOWueXKtqYzx2Bxdk6ZYsYrC1zfV+7sUC4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SA2PR11MB5083.namprd11.prod.outlook.com (2603:10b6:806:11b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 06:49:26 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%7]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 06:49:26 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "oleksandr@natalenko.name"
	<oleksandr@natalenko.name>, "mingo@redhat.com" <mingo@redhat.com>,
	"irogers@google.com" <irogers@google.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "kees@kernel.org"
	<kees@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Dhananjay.Ugwekar@amd.com"
	<Dhananjay.Ugwekar@amd.com>, "bp@alien8.de" <bp@alien8.de>, "acme@kernel.org"
	<acme@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
CC: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "gautham.shenoy@amd.com"
	<gautham.shenoy@amd.com>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"ananth.narayan@amd.com" <ananth.narayan@amd.com>, "sandipan.das@amd.com"
	<sandipan.das@amd.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 10/10] perf/x86/rapl: Add per-core energy counter
 support for AMD CPUs
Thread-Topic: [PATCH v3 10/10] perf/x86/rapl: Add per-core energy counter
 support for AMD CPUs
Thread-Index: AQHaxfxH+bqbABPQbUKOwDk8vLyuq7HaLDeAgAAWGACAAO4DAA==
Date: Thu, 27 Jun 2024 06:49:26 +0000
Message-ID: <f2dfe380f06bdde6bf4aabc9c45ddea7e28d35fd.camel@intel.com>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
	 <20240624055907.7720-11-Dhananjay.Ugwekar@amd.com>
	 <18e0c72823d916d82aa48fb6690375f960a9d9ea.camel@intel.com>
	 <dff31583-adaf-4da8-954e-f35f7ef5a5d3@amd.com>
In-Reply-To: <dff31583-adaf-4da8-954e-f35f7ef5a5d3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SA2PR11MB5083:EE_
x-ms-office365-filtering-correlation-id: 5130b7c8-3c01-4105-2def-08dc96754937
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S29VNlRZeHRKZFBYSkJnQndHb0g0SVp4T1FaYyt6RURKWjg1MTdBQlNFMlRx?=
 =?utf-8?B?WUVWNHY4cmtHN21zMTFqTSt4VnROMUZHL1JRUWZMR2ozell0aUUwc2xldUk5?=
 =?utf-8?B?TTNhc2Y4NW9NT2k1RE9xTFFUbGNOVEx6dGRhbXlBYXhDUUpOcTdnV29BMWJy?=
 =?utf-8?B?QXNyemM2OXZGd3YzMEpIdWdHUmc0V2pKckprK3JDKytrU1V3UEQ4ZGExVGV0?=
 =?utf-8?B?WXM1SXlmNEFiWkpDbnVybjQzQTljdTFaZEJJNWQrK29rR0NGbko4ZU1GZFZS?=
 =?utf-8?B?eW9SYjNUazVqLzNYUGdSeEpuZU5yZzNUQXp3SFVtQXZxZHhLMytYQjBvY1Ra?=
 =?utf-8?B?VXF6V1lsSVhQTmtQbzhReE1TYUNTRGMwQmZIdFhSRmFaYXVLbDl5VGZ2dlVy?=
 =?utf-8?B?ODV2VnBDcnAyQmRSUlFla28yb05mT05iajNoZllBOFo1NWxxWjV3T1Q3clND?=
 =?utf-8?B?VUhNZ2Q1emF3S2pDMDlvK25MQmJ1dVdPWVEycm5zVldENTVoaEdhak5rSElT?=
 =?utf-8?B?bEFkamRPZVpvTDZNTU55MmVMdVFEQ25RVWZqeGpYaU1xTkRGYVJLWkJuWi9q?=
 =?utf-8?B?QVhlVmVmQ21kU2JoRk5JaEc1M1poZUR4cVZmUkkrbzRrdC9jYSs0d3Ixc0o0?=
 =?utf-8?B?NExlNkhzbzlSN2RKYkc1VkZtb2N1Y2RzMXU4emRjaHR0bkVRbEptVXFnSGh2?=
 =?utf-8?B?Z09pdzMvM3UyQlF2MU9XeWUrd3FDRDNDUCs3N0YrZ1B0NGhGdkh1eUxxSnZQ?=
 =?utf-8?B?WkcyN21OQmpXYU9Bd2t0WXhaekloaS9SeEduYkE4ZHpCYktIZVhvQ1BwcUM2?=
 =?utf-8?B?M0NMR1NPUGJVTjdDWitMbXhYZkxlTzlsOXFIUTk0M0hwNmk5aW9scXVQdTU1?=
 =?utf-8?B?WlhLbXppRzJOemVicUJnRnlDMUxjd1FiVExFRlNGVkwzK0ZHL0NZc1A0QUdV?=
 =?utf-8?B?eFMyUzlhZVNFWHJRUENFd1ZsVU1BOWUxQXdKb3lsazk4NkpmT3NPWXNxbERi?=
 =?utf-8?B?bGxFMnNudFE2OTNFMFZ5ekQzYm1mWm5wM09Menc2dzZzZHRGRmNpTEduUUZ0?=
 =?utf-8?B?MUZPbWpUWlpnN0h2RmtFNk1lWVBuSWpNQ2VOYjgvMCt4S0R3NWtvTjZJbWtp?=
 =?utf-8?B?VHZ0MW5qcDNicXhTTUhUaC9hRkFNQlEwZVI2cVZXcit5czdRVitIeGVGdlFu?=
 =?utf-8?B?d0ZzLzBVTHZUNG1HZkFhTkNVWGN5eEhoMjhlZVlqY3A2b1Nxd2toVEt3ZExw?=
 =?utf-8?B?MUZhcjQ1VWtveXk5Tm9keGJuQ0hER09BY0gycDBMSk4wUEFiVlllWWl1ZkFr?=
 =?utf-8?B?NFFMTEt5VHMzbnMrenV1YVJSaUk3Smt5bDI4dUJUeXdXdmM3Uk5PcVg5aWV4?=
 =?utf-8?B?Y3ZiYXB5R0xrNm43RGpQaGRBUGtzdVpvT3Q2MmRqV0JxMnRaWDF0aVlUUDlO?=
 =?utf-8?B?RFJkaDJqeW1BcFNreW04dFppTUlWZi9rVkxVdnJlZzNTWW5xRlB2aSsvNDRv?=
 =?utf-8?B?a3V2WU8zSnp2RWc4Q29HZ0xHM2VobjIxVHVRRzd6Ymd2TWV2a2FpekdLR1JV?=
 =?utf-8?B?N0hzWGN4K2diWW10V3pDakRxMnN1aGlicnliVm4wKzI4aDBKeS9ncDN6Qy9Z?=
 =?utf-8?B?cHQ1Y3JKSmNjNUxzU2I2dk5mZXZhWncvdU1LelhrbHM0Y2ZKK2tLVndWa2xn?=
 =?utf-8?B?dzhXWXhRUlhiNUFxajdKTjBnbG9nelZtV3EzOG5BUEcrVnc0em9QQ3lmeStU?=
 =?utf-8?B?NWF3eEtFd3Q5ckdzZ09wR2Z1M3B3NEZYbzZLNjl0L2JPbldKOXVwaVErTVZh?=
 =?utf-8?B?dnlLVEM3YlBrVHBaODE5RDV6SlFLU1pkUklJaW93UTdVdTdHWHdId0tZYURV?=
 =?utf-8?B?VzVPWGYxUUY2NXgwWE9tK1VZaXowaW1pZ2Z3SDlMdnhsN29lbzZkays5MDhj?=
 =?utf-8?Q?nvLtcvD7kVg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjFFMWZDeTJubCtRaUtEUkhDVmVnZEtFYUtuVTBURmxsdFNLa3BvSTJ3a1BK?=
 =?utf-8?B?ak5LYWtYM3RscjhJQkFwd3RpZmorcm4rMDFCWkFPdHhCY3M2eC9RNUZBYlZ5?=
 =?utf-8?B?YkNpQzh5OWczMnR1QnBpMFN3ZzExNVAxdERsbDFVZUc4OVhFTDY5NjdRTGdk?=
 =?utf-8?B?Q2JGMHBHOVI5d2NuZ2IvVFVBa0ZlTzhUcmRZUGlZblUvaWREaGtYK0UzazFU?=
 =?utf-8?B?dHNmbkVPbzErQ1FLYnVGeDIySlZZSkRGckRaK1lDaGxhd3lhRUoxNWZjSjMr?=
 =?utf-8?B?aHQ5bUg4R3pLT3FXeHlnNHM4Qm9LaDN3OC9xY3F2M3M5Smw5UWNpRFh6Q01i?=
 =?utf-8?B?eGFidlRqVlJVTDhULzYzMnN2V1ppZWhDeUp5UUFFTHFsWlMxdXNObjM2UGYv?=
 =?utf-8?B?akJvZGRlMU1qMkNmaDN6NGJHTkxlcHlWZ2tRWFJNQVFna3JQNE05K3p1eitl?=
 =?utf-8?B?azF0SWprdDYzdG1DajNFa2ZTT3hLRjkxVndIcXRqcXArK1p4Wm9JKzBHR1N0?=
 =?utf-8?B?UjVxbDZ0b3hFU2ZkQnRURVBtaXlldmVJeEZCSEJKYkExZVgzaG9Kc29VVzhV?=
 =?utf-8?B?RmJPTGhMSHU2emVDWGdzZFViS0lqWk1SWjhhZDQ0Y2NLb3kzUHVFZU1HVWZj?=
 =?utf-8?B?R0JiYzhvRitoUGFrWnIwUmpCK2tadlc1WnlBeTVKbnM4Vy8yU2dRYnRlNllR?=
 =?utf-8?B?MzIydnU1b09ZbkFXMEFNaGNaNno5WS9XUDZMNUpSQzZYenNFNWlrWjFqRzJw?=
 =?utf-8?B?RklITWxQRkpqR1RSWElwOUdpck03UUNpcGxhSTJFOFMxRDRwTGhuY3l3M09B?=
 =?utf-8?B?eVZBTXVpT0ZabmpjeWtONzRiN1lCelEveXlWYXF1Sm41ZVQwVEZ5cUk1dkVQ?=
 =?utf-8?B?VTNnSTAyM3Z6VlA1RitpTmNJN0RZK2hOdjJMUFJHZEtCbk9BcG15OFFjODhR?=
 =?utf-8?B?YzBmVmc1Mm5BSWZLWDVNSmsyQ0VDRXNBMWNISnMydXgrbkdlT2lGMjFsYnl0?=
 =?utf-8?B?Z0dXYThOZ1o4Q1lZTHc3N0dybVR2N2RLK2VWcEZNbjlRYWlZK2xxK0JpRkNo?=
 =?utf-8?B?WGRyV2h3K1ZINmFtdTZwRHU5c0tQQTMxeUg1dDdSVC9KTUpPajZUWnpGQjdx?=
 =?utf-8?B?MDIxR2dCci9kaVliSXdlV1NCbDJ3TWF2dklTbXBLMUdWT0hmQ3dKUWwrSFhX?=
 =?utf-8?B?RXR6all2MXpxUmFwSi95ZzArOEorWk9PQkJCeTJLbUhHUXRlZFlLWlVBL3Bn?=
 =?utf-8?B?azVxOE5RMUd0Q2ErVU1SOU1lRGIwVWdJbTQrYjNqYXJpMWFGclg2NGNDWFk0?=
 =?utf-8?B?MnZwSGlXN0RKdm9hV3V0aG5tV0dKWUw5NVhhNVI0bGFwREptK3ZpUlRrS1A4?=
 =?utf-8?B?NGVJaXBJTFBNdkd2TkRiRFF0akhEVWk4eXlXcEV3OXFsQ2JiRk1HbkcybVFQ?=
 =?utf-8?B?TkMrVTJvMXIrNFFoTzgvMmFZZlJuelR6Q0xOdFRlbFh5MWNMZThLVC94QjFv?=
 =?utf-8?B?WGNscmlIRVNZZ2FZS1QySVBwYUZTL0tSYUR2OTlMbHJiVUkrRmpHbGkxaHAv?=
 =?utf-8?B?ZUNzVFQ3ZHBoaXBHd29kbVowUlRPeHAybzlVY0IrMEl4RlBwTWdqUCtGWTNx?=
 =?utf-8?B?eUN4cnlzS2JFUHl0Z2VIdFovVE5kRjlDbFJ3eGhzUVJrQUcrdDN3dTZ4a1N0?=
 =?utf-8?B?N3o2dU5zcGxaU29LM3YyM3FLRmhNNjd4ZnlHVHQxYmxNUUJ6WDBHTXllclJv?=
 =?utf-8?B?N080NnJ4Y3krWHgvUFJRUGJ4aHBmOXRZT293NG4vcXcwSm04djlyMVpuT28w?=
 =?utf-8?B?eGVSTG9seVllRTUwM0czUVhXQ3cvK2pJYzQ2czV5ZktBNDBJVWpSR2ZzUEdr?=
 =?utf-8?B?VzlJQ0lWY0NqKzMwL2dFSnJwVisvbHdMTDRNK01nVjJPamFXcm8vcGpsR0tp?=
 =?utf-8?B?L29jV0thamdScUFObEhodGlSOUY2YnQwVTVYMWw4dkVTSFoyNDFhTVZkeFd6?=
 =?utf-8?B?ajJ0dnpWQmVOVUk0UEFyaTZEMU9vT3gvbWhoNThZVHU4cDRHQVR2THRJdnlE?=
 =?utf-8?B?U2p3WDlrZWhDc1o1M1RFeWRCQW9EVkt5NUdpdEtvdnJ6U0tpRUR5M0x6dkJB?=
 =?utf-8?B?V2dFOC9wU1o0elV0cjhaUVNrVW5lME54ZkJSbDdTWC90eDJGdlIxSG9GSTNm?=
 =?utf-8?B?Rm1ZMDA4YVdMMG9mTDRGUWU0aG5KUWxZNkdwZ0xiemZoWEdveXA3SzlsV2Jz?=
 =?utf-8?B?c1pkN0NmLzJtMkhVbnZxbFdObTFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <311A23A0160D4B46855C47FD8119EC7B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5130b7c8-3c01-4105-2def-08dc96754937
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 06:49:26.3153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sqE168sbAbABR/TFSrKH9ac7mlPnhoiNv9YSsWLWnPO5k49o1mRvmJVu67Kz1m2h+0v8su6k31+KxbS5AsJ5/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5083
X-OriginatorOrg: intel.com

SGksIERoYW5hbmpheQo+IAo+ID4gCj4gPiBbLi4uXQo+ID4gCj4gPiA+IEBAIC02ODUsNiArNzc0
LDEzIEBAIHN0YXRpYyB2b2lkIF9faW5pdCByYXBsX2FkdmVydGlzZSh2b2lkKQo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmFwbF9wa2dfZG9tYWluX25hbWVzW2ldLAo+ID4gPiByYXBsX2h3X3VuaXRbaV0pOwo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oH0KPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwgTlJfUkFQTF9D
T1JFX0RPTUFJTlM7IGkrKykgewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKHJhcGxfY29yZV9jbnRyX21hc2sgJiAoMSA8PCBpKSkgewo+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX2luZm8oImh3IHVuaXQgb2YgZG9t
YWluICVzIDJeLSVkCj4gPiA+IEpvdWxlc1xuIiwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmFwbF9jb3JlX2RvbWFp
bl9uYW1lc1tpXSwKPiA+ID4gcmFwbF9od191bml0W2ldKTsKPiA+IAo+ID4gcmFwbF9od191bml0
W10gaXMgZm9yIHBhY2thZ2UgcG11IG9ubHkgYW5kCj4gPiByYXBsX2h3X3VuaXRbMF0gaXMgcmFw
bF9od191bml0W1BFUkZfUkFQTF9QUDBdIHJhdGhlciB0aGFuCj4gPiByYXBsX2h3X3VuaXRbUEVS
Rl9SQVBMX1BFUl9DT1JFXQo+ID4gCj4gPiB5b3UgY2Fubm90IHVzZSByYXBsX2h3X3VuaXRbaV0g
dG8gcmVwcmVzZW50IHBlci1jb3JlIHJhcGwgZG9tYWluCj4gPiB1bml0Lgo+IAo+IFllcyByaWdo
dCwgSSBzYXcgdGhhdCBhbGwgdGhlIGVsZW1lbnRzIGluIHRoZSByYXBsX2h3X3VuaXQgYXJyYXkg
d2VyZQo+IGFjdHVhbGx5IAo+IHVzaW5nIHRoZSB2YWx1ZSBmcm9tIHRoZSBzYW1lIHJlZ2lzdGVy
ICJNU1JfUkFQTF9QT1dFUl9VTklUIiBvcgo+ICJNU1JfQU1EX1JBUExfUE9XRVJfVU5JVCIuCj4g
RXhjZXB0IGZvciB0aGUgdHdvIHF1aXJrcywKPiDCoAo+IMKgNzM3wqDCoMKgwqDCoMKgwqDCoCBj
YXNlCj4gUkFQTF9VTklUX1FVSVJLX0lOVEVMX0hTVzrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gwqA3MzjCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByYXBsX2h3X3VuaXRbUEVSRl9SQVBMX1JBTV0gPQo+IDE2O8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gwqA3MznCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoAo+IGJyZWFrO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gwqA3NDDCoMKgwqDC
oMKgwqDCoMKgIC8qIFNQUiB1c2VzIGEgZml4ZWQgZW5lcmd5IHVuaXQgZm9yIFBzeXMgZG9tYWlu
LiAqLwo+IMKgNzQxwqDCoMKgwqDCoMKgwqDCoCBjYXNlIFJBUExfVU5JVF9RVUlSS19JTlRFTF9T
UFI6Cj4gwqA3NDLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYXBsX2h3X3VuaXRb
UEVSRl9SQVBMX1BTWVNdID0gMDsKPiDCoDc0M8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGJyZWFrOwo+IAo+IFNvLCBhcyBmb3IgQU1EIHN5c3RlbXMgdGhlIHJhcGxfaHdfdW5pdFtd
IGVsZW1lbnRzIHdpbGwgYWx3YXlzIGhhdmUKPiB0aGUgc2FtZSB2YWx1ZSwgSSBlbmRlZCAKPiB1
cCB1c2luZyB0aGUgcmFwbF9od191bml0W1BFUkZfUkFQTF9QUDBdIGZvcgo+IHJhcGxfaHdfdW5p
dFtQRVJGX1JBUExfUEVSX0NPUkVdLCBidXQgSSBkbyByZWFsaXplCj4gaXQgaXMgcXVpdGUgaGFj
a3kuIFNvLCBiZXR0ZXIgdG8gZG8gaXQgY2xlYW5seSBhbmQgYWRkIGEgc2VwYXJhdGUKPiBhcnJh
eS92YXJpYWJsZSBmb3IgdGhlIGNvcmUgZXZlbnRzLgo+IAp5ZWFoLCB0aGF0IGlzIG11Y2ggYmV0
dGVyLgo+IAoKPiA+IAo+ID4gPiDCoAo+ID4gPiDCoHN0YXRpYyBzdHJ1Y3QgcmFwbF9tb2RlbCBt
b2RlbF9hbWRfaHlnb24gPSB7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAucGtnX2V2ZW50c8KgwqDC
oMKgwqA9IEJJVChQRVJGX1JBUExfUEtHKSwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgLmNvcmVfZXZl
bnRzwqDCoMKgwqA9IEJJVChQRVJGX1JBUExfUEVSX0NPUkUpLAo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgLm1zcl9wb3dlcl91bml0ID0gTVNSX0FNRF9SQVBMX1BPV0VSX1VOSVQsCj4gPiA+IC3CoMKg
wqDCoMKgwqDCoC5yYXBsX21zcnPCoMKgwqDCoMKgID0gYW1kX3JhcGxfcGtnX21zcnMsCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoC5yYXBsX3BrZ19tc3JzwqDCoD0gYW1kX3JhcGxfcGtnX21zcnMsCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoC5yYXBsX2NvcmVfbXNyc8KgPSBhbWRfcmFwbF9jb3JlX21zcnMs
Cj4gPiA+IMKgfTsKPiA+ID4gwqAKPiA+ID4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IHg4Nl9jcHVf
aWQgcmFwbF9tb2RlbF9tYXRjaFtdIF9faW5pdGNvbnN0ID0KPiA+ID4gewo+ID4gPiBAQCAtODU4
LDYgKzk1NywxMSBAQCBzdGF0aWMgaW50IF9faW5pdCByYXBsX3BtdV9pbml0KHZvaWQpCj4gPiA+
IMKgewo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQgKmlkOwo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgaW50IHJldDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgaW50IG5y
X3JhcGxfcG11ID0gdG9wb2xvZ3lfbWF4X3BhY2thZ2VzKCkgKgo+ID4gPiB0b3BvbG9neV9tYXhf
ZGllc19wZXJfcGFja2FnZSgpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBpbnQgbnJfY29yZXMgPSB0
b3BvbG9neV9tYXhfcGFja2FnZXMoKSAqCj4gPiA+IHRvcG9sb2d5X251bV9jb3Jlc19wZXJfcGFj
a2FnZSgpOwo+ID4gCj4gPiBJJ2Qgc3VnZ2VzdCBlaXRoZXIgdXNpbmcgdHdvIHZhcmlhYmxlcyBu
cl9wa2dzL25yX2NvcmVzLCBvciByZXVzZQo+ID4gb25lCj4gPiB2YXJpYWJsZSBucl9yYXBsX3Bt
dSBmb3IgYm90aCBwa2cgcG11IGFuZCBwZXItY29yZSBwbXUuCj4gCj4gSSB1bmRlcnN0YW5kIHlv
dXIgcG9pbnQsIGJ1dCB0aGUgcHJvYmxlbSB3aXRoIHRoYXQgaXMsIHRoZXJlIGFyZQo+IGFjdHVh
bGx5IHRocmVlIHNjb3BlcyBuZWVkZWQgaGVyZQo+IAo+IFNvbWUgSW50ZWwgc3lzdGVtcyBuZWVk
IGEgKmRpZSogc2NvcGUgZm9yIHRoZSByYXBsX3BtdXNfcGtnIFBNVQo+IFNvbWUgSW50ZWwgc3lz
dGVtcyBhbmQgYWxsIEFNRCBzeXN0ZW1zIG5lZWQgYSAqcGFja2FnZSogc2NvcGUgZm9yIHRoZQo+
IHJhcGxfcG11c19wa2cgUE1VCj4gQW5kIEFNRCBzeXN0ZW1zIG5lZWQgYSAqY29yZSogc2NvcGUg
Zm9yIHRoZSByYXBsX3BtdXNfcGVyX2NvcmUgUE1VCj4gCj4gSSB0aGluayB3aGF0IHdlIGNhbiBk
byBpcyB0aHJlZSB2YXJpYWJsZXMsIG5yX2RpZXMgKGZvciBhbGwgSW50ZWwKPiBzeXN0ZW1zIGFz
IGJlZm9yZSksIAo+IG5yX3BrZ3MoZm9yIEFNRCBzeXN0ZW1zIHJhcGxfcG11c19wa2cgUE1VKQoK
Tm90IG5lY2Vzc2FyaWx5LCB3ZSBhbHJlYWR5IHVzZXMgcmFwbF9wbXVzX3BrZyBmb3IgaW50ZWwg
c3lzdGVtcywKcmlnaHQ/Cgo+ICBhbmQgbnJfY29yZXMoZm9yIHJhcGxfcG11c19wZXJfY29yZSBQ
TVUpCj4gCj4gU291bmRzIGdvb2Q/Cgp3aGF0IGFib3V0IGp1c3Qgb25lIHZhcmlhYmxlICJjb3Vu
dCIgYW5kIHJldXNlIGl0IGZvciBldmVyeSBjYXNlcz8KCj4gCj4gPiAKPiA+ID4gKwo+ID4gPiAr
wqDCoMKgwqDCoMKgwqBpZiAocmFwbF9wbXVfaXNfcGtnX3Njb3BlKCkpCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBucl9yYXBsX3BtdSA9IHRvcG9sb2d5X21heF9wYWNrYWdl
cygpOwo+ID4gPiDCoAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWQgPSB4ODZfbWF0Y2hfY3B1KHJh
cGxfbW9kZWxfbWF0Y2gpOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFpZCkKPiA+ID4gQEAg
LTg2NSwxNyArOTY5LDM0IEBAIHN0YXRpYyBpbnQgX19pbml0IHJhcGxfcG11X2luaXQodm9pZCkK
PiA+ID4gwqAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHJhcGxfbW9kZWwgPSAoc3RydWN0IHJhcGxf
bW9kZWwgKikgaWQtPmRyaXZlcl9kYXRhOwo+ID4gPiDCoAo+ID4gPiAtwqDCoMKgwqDCoMKgwqBy
YXBsX3BrZ19jbnRyX21hc2sgPSBwZXJmX21zcl9wcm9iZShyYXBsX21vZGVsLQo+ID4gPiA+cmFw
bF9tc3JzLAo+ID4gPiBQRVJGX1JBUExfUEtHX0VWRU5UU19NQVgsCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoHJhcGxfcGtnX2NudHJfbWFzayA9IHBlcmZfbXNyX3Byb2JlKHJhcGxfbW9kZWwtCj4gPiA+
ID4gcmFwbF9wa2dfbXNycywgUEVSRl9SQVBMX1BLR19FVkVOVFNfTUFYLAo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGZhbHNlLCAodm9pZCAqKQo+ID4gPiAmcmFwbF9tb2RlbC0KPiA+ID4g
PiBwa2dfZXZlbnRzKTsKPiA+ID4gwqAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IHJhcGxf
Y2hlY2tfaHdfdW5pdCgpOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ID4gPiDCoAo+ID4gPiAt
wqDCoMKgwqDCoMKgwqByZXQgPSBpbml0X3JhcGxfcG11cygmcmFwbF9wbXVzX3BrZyk7Cj4gPiA+
ICvCoMKgwqDCoMKgwqDCoHJldCA9IGluaXRfcmFwbF9wbXVzKCZyYXBsX3BtdXNfcGtnLCBucl9y
YXBsX3BtdSwKPiA+ID4gcmFwbF9hdHRyX2dyb3VwcywgcmFwbF9hdHRyX3VwZGF0ZSk7Cj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiByZXQ7Cj4gPiA+IMKgCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyYXBs
X21vZGVsLT5jb3JlX2V2ZW50cykgewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmFwbF9jb3JlX2NudHJfbWFzayA9IHBlcmZfbXNyX3Byb2JlKHJhcGxfbW9kZWwtCj4gPiA+
ID4gcmFwbF9jb3JlX21zcnMsCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAKPiA+ID4gUEVSRl9SQVBMX0NPUkVfRVZFTlRTX01BWCwgZmFsc2UsCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHZvaWQg
KikKPiA+ID4gJnJhcGxfbW9kZWwtPmNvcmVfZXZlbnRzKTsKPiA+ID4gKwo+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gaW5pdF9yYXBsX3BtdXMoJnJhcGxfcG11c19j
b3JlLCBucl9jb3JlcywKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmFwbF9wZXJfY29yZV9hdHRyX2dy
b3VwcywKPiA+ID4gcmFwbF9wZXJfY29yZV9hdHRyX3VwZGF0ZSk7Cj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0KSB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyoKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBJZiBpbml0aWFsaXphdGlvbiBvZiBwZXJfY29y
ZSBQTVUKPiA+ID4gZmFpbHMsCj4gPiA+IHJlc2V0IHBlcl9jb3JlCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogZmxhZywgYW5kIGNvbnRpbnVl
IHdpdGggcG93ZXIgUE1VCj4gPiA+IGluaXRpYWxpemF0aW9uLgo+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX3dhcm4oIlBlci1jb3JlIFBNVSBp
bml0aWFsaXphdGlvbgo+ID4gPiBmYWlsZWQKPiA+ID4gKCVkKVxuIiwgcmV0KTsKPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYXBsX21vZGVsLT5j
b3JlX2V2ZW50cyA9IDBVTDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0K
PiA+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gPiArCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAvKgo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgICogSW5zdGFsbCBjYWxsYmFja3MuIENvcmUgd2lsbCBjYWxs
IHRoZW0gZm9yIGVhY2ggb25saW5lCj4gPiA+IGNwdS4KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCAq
Lwo+ID4gPiBAQCAtODg5LDYgKzEwMTAsMjAgQEAgc3RhdGljIGludCBfX2luaXQgcmFwbF9wbXVf
aW5pdCh2b2lkKQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDE7Cj4gPiA+IMKgCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoGlmIChyYXBsX21vZGVsLT5jb3JlX2V2ZW50cykgewo+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gcGVyZl9wbXVfcmVnaXN0ZXIoJnJhcGxfcG11c19jb3Jl
LT5wbXUsCj4gPiA+ICJwb3dlcl9wZXJfY29yZSIsIC0xKTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIElmIHJlZ2lzdHJhdGlvbiBvZiBwZXJfY29yZSBQTVUg
ZmFpbHMsCj4gPiA+IGNsZWFudXAgcGVyX2NvcmUgUE1VCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogdmFyaWFibGVzLCByZXNldCB0aGUgcGVy
X2NvcmUgZmxhZyBhbmQKPiA+ID4ga2VlcCB0aGUKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBwb3dlciBQTVUgdW50b3VjaGVkLgo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX3dhcm4oIlBl
ci1jb3JlIFBNVSByZWdpc3RyYXRpb24gZmFpbGVkCj4gPiA+ICglZClcbiIsIHJldCk7Cj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2xlYW51cF9y
YXBsX3BtdXMocmFwbF9wbXVzX2NvcmUpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhcGxfbW9kZWwtPmNvcmVfZXZlbnRzID0gMFVMOwo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gPiArwqDCoMKgwqDCoMKgwqB9
Cj4gPiA+ICsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHJhcGxfYWR2ZXJ0aXNlKCk7Cj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiA+ID4gwqAKPiA+ID4gQEAgLTkwNiw1ICsxMDQxLDkg
QEAgc3RhdGljIHZvaWQgX19leGl0IGludGVsX3JhcGxfZXhpdCh2b2lkKQo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgY3B1aHBfcmVtb3ZlX3N0YXRlX25vY2FsbHMoQ1BVSFBfQVBfUEVSRl9YODZfUkFQ
TF9PTkxJTkUpCj4gPiA+IDsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHBlcmZfcG11X3VucmVnaXN0
ZXIoJnJhcGxfcG11c19wa2ctPnBtdSk7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBjbGVhbnVwX3Jh
cGxfcG11cyhyYXBsX3BtdXNfcGtnKTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJhcGxfbW9k
ZWwtPmNvcmVfZXZlbnRzKSB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBw
ZXJmX3BtdV91bnJlZ2lzdGVyKCZyYXBsX3BtdXNfY29yZS0+cG11KTsKPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsZWFudXBfcmFwbF9wbXVzKHJhcGxfcG11c19jb3JlKTsK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gCj4gPiB3ZSBkbyBjaGVjayByYXBsX3BtdXNfY29y
ZSBiZWZvcmUgYWNjZXNzaW5nIGl0LCBidXQgd2UgbmV2ZXIgY2hlY2sKPiA+IHJhcGxfcG11c19w
a2cgYmVjYXVzZSB0aGUgcHJldmlvdXMgY29kZSBhc3N1bWVzIGl0IGFsd2F5cyBleGlzdHMuCj4g
PiAKPiA+IHNvIGNvdWxkIHRoZXJlIGJlIGEgcHJvYmxlbSBpZiBzb21lIG9uZSBzdGFydHMgdGhl
IHBlci1jb3JlIHBtdQo+ID4gd2hlbgo+ID4gcGtnIHBtdSBpcyB1bnJlZ2lzdGVyZWQgYW5kIGNs
ZWFuZWQgdXA/Cj4gPiAKPiA+IHNheSwgaW4gcmFwbF9wbXVfZXZlbnRfaW5pdCgpLAo+ID4gCj4g
PiBpZiAoZXZlbnQtPmF0dHIudHlwZSA9PSByYXBsX3BtdXNfcGtnLT5wbXUudHlwZSB8fAo+ID4g
wqDCoCAocmFwbF9wbXVzX2NvcmUgJiYgZXZlbnQtPmF0dHIudHlwZSA9PSByYXBsX3BtdXNfY29y
ZS0KPiA+ID5wbXUudHlwZSkpCj4gPiAKPiA+IHRoaXMgY2FuIGJyZWFrIGJlY2F1c2UgcmFwbF9w
bXVzX3BrZyBpcyBmcmVlZCwgcmlnaHQ/Cj4gCj4gSG1tLCBJIHRoaW5rIHRoaXMgc2l0dWF0aW9u
IGNhbid0IGFyaXNlIGFzIHdoZW5ldmVyIHRoZSBwb3dlciBQTVUKPiBmYWlscywgd2UgCj4gZGly
ZWN0bHkgZ28gdG8gdGhlIGZhaWx1cmUgcGF0aCBhbmQgZG9udCBzZXR1cCB0aGUgcGVyLWNvcmUg
UE1VKHdoaWNoCj4gbWVhbnMgCj4gbm8gb25lIHdpbGwgYmUgYWJsZSB0byBzdGFydCB0aGUgcGVy
LWNvcmUgUE1VKSwgCj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIGlzIGEgc2NlbmFyaW8g
d2hlcmUgdGhpcyBhc3N1bXB0aW9uIGNhbgo+IGZhaWwuCgpJIG1lYW4gaWYgd2UgZG8gbW9kdWxl
IHVubG9hZCBhbmQgYWNjZXNzIHBvd2VyLXBlci1jb3JlIHBtdSBhdCB0aGUgc2FtZQp0aW1lLCBj
b3VsZCB0aGVyZSBiZSBhIHJhY2U/Cgp3aHkgbm90IGp1c3QgdW5yZWdpc3RlciBhbmQgY2xlYW51
cCB0aGUgcGVyLWNvcmUgcG11IGJlZm9yZSB0aGUgcGtnCnBtdT8KPiAKCnRoYW5rcywKcnVpCgo=

