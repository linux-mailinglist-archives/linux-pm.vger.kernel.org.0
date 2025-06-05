Return-Path: <linux-pm+bounces-28137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634F9ACE88F
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 05:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1431779AE
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 03:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F4E1C5F06;
	Thu,  5 Jun 2025 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjTZ7EXO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6FF1EEE6;
	Thu,  5 Jun 2025 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749092831; cv=fail; b=dfZxCmYeUzFbzqZtdOnK129TdXkReCmR+vKf7Rg7s+Z3Rppe+c0q1EnTwnwhz1HIBUNvCbHPBS55JpGKn4LjzUix/rd1pZKiZOoHMUucgphRUpPxbrbGxA0qzDvLO9nECYru+lQNJBeG75kribSv46xj0fVwnA9ehs2Om96emds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749092831; c=relaxed/simple;
	bh=VQ7UyhG9TrBSlnuHVx8FnxeodDCPgf0hJsG0wkAFq+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fht2oDeh1ByT30qWFRHHmRi1wRV86hiOmAbEpVGmtiuboFHpZvP236DphIP585E8NGuCM7Ej3zPWfPpxViy7WUcPTrKcNPYhnr98lgIq03m0RpK6C62vqUQ4G7rlbwcIwTH597e1tvQfnwwXHPBOoO/a7qcQIdXkgGQE4qIjx/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjTZ7EXO; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749092829; x=1780628829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VQ7UyhG9TrBSlnuHVx8FnxeodDCPgf0hJsG0wkAFq+4=;
  b=cjTZ7EXOztRAU0Cm1LaRkdXCVGXRYxmdbgKh4wVk+zXQa4lu71OH9cr9
   feO1TSmMwebHyJ/EKnBGpEyG2MX8833vVSzq9R8hZp99tgbgCzCTNt+8J
   hQdb8TSXQwJSM2SXrxyGGKEOXYjX3KMYrvcr5mIcK3Y/dp2is9PxD4V6m
   3235gFvLG9OZ8LJMkyajjRDs3i4QHmWLVdboHLT+ccPyt6PT9lNFwGYS5
   5HPNtHjqAOvTLmmQNnGfjNsk9mLWmULIU/z615i+cRkST3kQVjQQi+IBM
   F5lgjWfkfYxXmxUEi2l4JKakre1+J5Uf0+pG+Lvk98/dQvn5NhNSciNPm
   A==;
X-CSE-ConnectionGUID: KJCyxbIcSIqezhZzSRgCnA==
X-CSE-MsgGUID: KFygZWJSRfKCMxjVCfVC5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51068767"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="51068767"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 20:07:09 -0700
X-CSE-ConnectionGUID: KjKNBlgyRTmYB7x5DJACMw==
X-CSE-MsgGUID: yWyDJAtMSImUlic7ikTr2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="150392654"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 20:07:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 20:07:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 20:07:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.49)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 20:07:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7gUkNFS+DZ2d3+wMtOE1YqRk2jMhuvKX0vQBJ/e8Bj5/9cDGXfH+nBch6WZ0YKW2oGmrR/ZGbtAGAT+/Zp9T4/vzDL7F12g33aH+Hu9ecKrGHcqm+uofFZ4dant4OHaOL7WpXo4yUOmesJgF1pYQal7UophjXktRgJP2Jn6j/b1XSHYyxi12JTFJGlKqYXyxuPeeJW2ht7az0dibV/nd4itR6tlCnq1S+x3xgGCw4E3XvgRgt/Ih8Ib9HI3v36MCWhi/0I5iWuluHYfspARFKDrX8TU8P2EJmRT20NBeCBs7fbt1wf1bFSWWzc8caBAgy6ZyM2+YIUFtXgeZrf1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ7UyhG9TrBSlnuHVx8FnxeodDCPgf0hJsG0wkAFq+4=;
 b=gjYfkW3Lh+pmn0v1f4EwAJXRrOUkJVJKn4wNYVgZC8RR/lxo4T8Adrdq3FephupWgNq51NI6xOn1q7CJUuJmGEeeYJnecJQv0wVOLgVzjMnrdwkpQHuE0GzR3etX/4QuSfBW8dXt3gqBJGpFBS8r1YcdOwWP7dJM5c9wzaXwPzBXFlGOexW/h5b242s0hXDcYdZ1Kg6JySyW4DumqZEXuHou3xvD89UnBt5jI/4J+tsHWsX877oG2IvXGVdV52K0ddtoXf+LbulOr5vuX9m8zK+cDOkO1rTW/WMBbmOyCcGspmGe0uE4ijqaS1wtFRY4u+rSZXf3IlHkr9OUeQoJ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by PH3PPF23335A1E7.namprd11.prod.outlook.com (2603:10b6:518:1::d0e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Thu, 5 Jun
 2025 03:06:25 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8769.029; Thu, 5 Jun 2025
 03:06:25 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] thermal: intel: int340x: Add performance control for
 platform temperature control
Thread-Topic: [PATCH 1/2] thermal: intel: int340x: Add performance control for
 platform temperature control
Thread-Index: AQHb1ZA7gn/+BRW2hUK5BKaCbnhSkrPz4oMA
Date: Thu, 5 Jun 2025 03:06:25 +0000
Message-ID: <f33e302aac482860eebf5e5f45a44df77455512c.camel@intel.com>
References: <20250604203518.2330533-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250604203518.2330533-1-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|PH3PPF23335A1E7:EE_
x-ms-office365-filtering-correlation-id: ef82de62-a0ff-4f00-d246-08dda3ddf576
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cGdpN0RKdUQ4cE81ZWpwVGd1NWRxZHEwRGVyL1BnUDh0OTd2T0lmdDBXMzJ1?=
 =?utf-8?B?R3Z3QzI4L29VVE1senJZVFc3UUlOb1p6M1R4RUV5UDhUQkxObzBzTU9kbElK?=
 =?utf-8?B?bEF2SjdwWDc0M1M1Q0V5Zm5haWFsT0UrTVd6dlpmV3g5SDZEaDJjc1dGaFgv?=
 =?utf-8?B?eG1BbGVESnh1cS93T3NTVFIzUWFJVzY0MWZtME5tdkQvVVFaN2pJcjVrM2FB?=
 =?utf-8?B?VDFaK0VZdHc0ZVB1bUZzMlR3c1B6cHZyclFrMEZ6WWM5djN3QlZMOXNGNDNK?=
 =?utf-8?B?eTEvb2tNaGVJMCs2aUJVTDBGNDNKQm9WUkk3SkdnMldmTW82dnMyR0NEZWtk?=
 =?utf-8?B?cVQ2SWN0M0FKdDZZUGY5cEJKTjkxbi8vZ2xZVzBmUEZBMDNnRXZhTjdiRU9P?=
 =?utf-8?B?MUZZMlJVa1kra1FxNVRacEs1alFnQXIvemVScy9ZbjZCcGRaV3BSRFZPMXMz?=
 =?utf-8?B?eVdrWWRPMXI4V0Z1Nk5JTllKSEd1aitVcGRNZDRPSmNzMUxmZldCQURNRmgw?=
 =?utf-8?B?MklJTk5jRlpiL1RoNUVidlNUMWFOSUNpYjM5QVUvSWp2eVY2U0JmbmJWN0hm?=
 =?utf-8?B?ZHdNK0RGejUrWEprWEE2MVhpQUVnTXZRNTBKYk9hWEZIQ1p0dXoxemg4UGpX?=
 =?utf-8?B?U3ZJdWZvWGxPblJZVGxva3Bhd2lKSU9PQS91UlNCeVNPaFNUWjBwN2VJMHJi?=
 =?utf-8?B?a0o1dzRQSm8rZmZuWFZNb1QwZWRBNlZZZDRRRVBOcGtPYmFWSEVlU1pXQjJi?=
 =?utf-8?B?eGpSTFRvOGFaeUs1TGkzTEVLMy95QzhMMyt5bm85bklHeUZ4cVQyZlUwV2kr?=
 =?utf-8?B?RGhreWJ2LzVXOE50UjdsNU1tZWtoOHhueUVVTVdnd3MwMjI3R1dOMFZ4ZDdB?=
 =?utf-8?B?SS9VM3FsRDZwZk9xMjhreUc0cHdHMDAvakxnL0U2NEdJTVBYemtCU3UyTWFa?=
 =?utf-8?B?NVBVTlhmNDRodW1seHZDQlBGeWtIb1V6WFZOM3BPdGZ3N2ZhbEFTaS9MeXZp?=
 =?utf-8?B?Y0dQMC9WYjF1dktIZ213UDhPMmJ1bE92alEzZ1JsdExBNERzWGErWEVIOW16?=
 =?utf-8?B?MnpMd0Z3TnJpbVNiSzBTOC9qZEZEekg5Y05JOVo3V2MxdUptY2VUOXpDYkI2?=
 =?utf-8?B?MHVXcmpVdDhaQVZqcXhoMWZDSXdTT2lXN2M1Y1dNOWxLdzBJZ2ZuNHBDT1d0?=
 =?utf-8?B?TjJxYWhzcG9OYzVWMFREbkMvWSt3SW03RGVVeWcvTGJjTjJydDBPbFUvUU81?=
 =?utf-8?B?YStzeXBIRGhodmF2Z3JvTHozdFZWRUNwaldrdEQ4aHIzZXJjTDdSTmpnL3ZG?=
 =?utf-8?B?bUFiRWYrZXhjSEIzcStqUXBvN01Md0N0bE1BSDhHamY0dURCTC8zT0tYQ0JF?=
 =?utf-8?B?aTY3SncvT0VLSE5KcXFvZmoxVlp1ZXhXYkQzbU1GNzV3T2l0K2RpRTNZUDNN?=
 =?utf-8?B?WjNKYWNEeDFQMVEvWDJiK1JZejVOUnJmd1pPR0lINStuRGFNRWxBSnRBNkls?=
 =?utf-8?B?M3NPQmlpTmg2WEwrMUJlMVdtWmZFUDhuYmdsbTVjaXJJRVRoWUNMVG00dTI2?=
 =?utf-8?B?a0lqcElhUGdwWC9sWncweW5iVC9zRlIvV0VhVVVKS1NBZ1BmMytJdDIxdjJy?=
 =?utf-8?B?bi9JbHhVVTQ5NTlpOFp6aWE4YVR2WHBOMk56K1lQRHBsNmhaSFgvL0NzS2x4?=
 =?utf-8?B?N3N2VXkzZ2F6RVRJelVCVzBUUHN5RDE2Y3NHSDhmQ1AvQlI1WktETTQ3L1RU?=
 =?utf-8?B?ejNKVDZxUWZ0YTlieE5Ma2dvVmIwRUFCLzZZanZ2T3NLZkZoaUozNDdCK0Rq?=
 =?utf-8?B?ak1aNkhORnJ3U1cvM3pSMml4QVlhVmxMdXNRSzZmZE9nclpTWlBiT0lDNU9o?=
 =?utf-8?B?cDhnelNDaWdZL1B0YzkvQmZIdEdkMDB5aGV0SEhOQXZseC9GbS9Dd3lOS3ps?=
 =?utf-8?B?eE9SdFA5UThzNGRaNzhUOHhaa3R0QlR4MDlDSlBISC9yeGcxNFZrL3Rra3h6?=
 =?utf-8?B?a0c0cGVJTUdBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RThWY2ExMmc0M0ptZ0wxaUpJdU1iS0Rla0dUbHErWHNrRVNRQ1FiU3lKeFRG?=
 =?utf-8?B?a2xkV0creHhGWEFhWk44ak1JeFdWZGVEbWVjTmtpbHY1NHkzbUtjR0RvUXZq?=
 =?utf-8?B?M0VwVi9vblVIT3A2LzhBWWFIVjN3SVBIRWQ0elhmRmI4S3N1aFF5Ynk0Zmp4?=
 =?utf-8?B?azlLV0p4Y2o4S1I1d3hQclhaeTRLVi9pU3JiaTNBeEdDYjFXTVRvV0ZlNTJl?=
 =?utf-8?B?ZUpwV092VXp5ODYvUGk5dkdvQ05NRkI2aWNMNy9UczdZYWZIc2hDMUpoNE53?=
 =?utf-8?B?VFUzVm5ud21SU1I0cXJiYUR2MTZaU25sWXM4ZTJ1L3lTekxhK1RhbVFtY3pH?=
 =?utf-8?B?K1VCd0RVVGhZWkxnUEw5d2d4WEtmR3l2ZmswREp5NWxsM3FYWU5kVkNTM20z?=
 =?utf-8?B?Tnk1MFRueUtYTHNaZ056UUNuditsd0w4K0NKYjhpU0ZDYlhpaXdsWTZldFFn?=
 =?utf-8?B?YVJQeDMxTXFnOHFQV0tsRlVLT2NNaUtuSWx0YUVmSWZMOFhDbHVNNnBQSGlU?=
 =?utf-8?B?OGF5aHNodUJuc3p2MGtlQ3kvVktGQUdLVC9iZ0puR2dTSnF5cEFSditwWENK?=
 =?utf-8?B?SjUrYWpHdlQ1NG1sSktFamowUlBmKzB6ekpwd1BGdmtBNGxvNkg4MVd3VjVM?=
 =?utf-8?B?eHh1WUx2MS84VnVvRi9PamY2YTg5cUNsZVBsWlFYZ1B0TFc2Y05hNkh5QUly?=
 =?utf-8?B?MmpodEJPc1RwQnJnS2xVRFE1WitoY28zaC93cUwwQytnQ0loKzdTd2ZUZHhh?=
 =?utf-8?B?aUtxU3oycEFEbUFPSisyVXE2eDVyam9uWVFOSkxidFcwUjFqMjJBTGNNUnFD?=
 =?utf-8?B?ZUVHdGpvSll0QXJmK0dzZ3EwdjhFU0JPVXZhVHZLZ3VGdER5a1hNVEVZeURk?=
 =?utf-8?B?ZWJYb1JubitlU1krZGlFL3RYQ01OeGhCS1JvRlh3VElPWVBoYWtKUnZ4TXd6?=
 =?utf-8?B?ZGNRUHpaMVYzOVdwcjFQZmE2NVNZSm9FakJPdHloY0pFVnZqendLNWFseDQ5?=
 =?utf-8?B?R3ZhYktNUFdXeXoyMThsTkRwZzZPUmpVSlRtQUFEZmNCNGdpWFM3S2pOSDB2?=
 =?utf-8?B?Q0JobVRUOXVWVWE5NFptMEJBS3Z3YnZQWkM4NXdJcUtQamdHdjcveWl4dnUz?=
 =?utf-8?B?bmVUTTl2QWlzV0l5eTF6Z1d5OWpVVUU0OVlZeHcxNjZ4M0JkTlVVSnVKUGc2?=
 =?utf-8?B?Z0oyTTVtR2I3NE5UUHp5WEVHNlVHMGd6Wkl3NUF0RStzNE0xcVBjV0lvM1ZM?=
 =?utf-8?B?ak9XUGNnZ0xUY2hlL0NKUnJQU2I2TTc3eDdBUEdsWjZKL2pWckZXVmxEbmRp?=
 =?utf-8?B?d3ZGZ0pWRVVxV1p6dGVuTTVEa0lWanNRUEJDbFkvM0JkTDFXcUc2ZUdVNUJv?=
 =?utf-8?B?eHh4aXhGWXJ1WDQvTHozNE1teER1clFWSWtQVkcxLzlaWVNBRjNpUVUyZWVI?=
 =?utf-8?B?b0JBQWFtOVM0SlJhbVNuTUp1NVViTjE3OXplU1h1alVyWUlvV2N3NFJVTit6?=
 =?utf-8?B?VE0yOWpMd3FuY3V2REFiNHhYNWpDZS9XbnFONzVRbUtuNjBVRlhocWNWUWox?=
 =?utf-8?B?M0xoV2ZlOXMrZHRvVTB1T3BINkpiemtNMUlQajF0VSt6d2x3cjlYTGFta1h0?=
 =?utf-8?B?cUl6L0N1SHE4NkZnMkxGWUc4UGNLdThZUXduVTloS1NvTm1Vd3l5NnlwaFQz?=
 =?utf-8?B?R3loRFo3d2taZlcrSTZlb0lFVmc0MVNUNWFyT1puUWd3MDJuZWloY1REWlF4?=
 =?utf-8?B?ZkV0ZXB1SmZPbWZkU2VjY3lXOGpOUnZQMUtkVlFNZTJpTVExRHh5a1pobmZ4?=
 =?utf-8?B?MThMWVlyVHI5RlFsb1dsZ3BzeGU1c0lreXF0RzRMc1VoWExJY3NkTk5UTTNa?=
 =?utf-8?B?RFpRMk9GRVBJUllxS2plZmhCazk1cmVDVFkzRFY4QnBLOWtJT0FsTWl3bGlH?=
 =?utf-8?B?MDhUb2tjSm1ZL0E0dUhFRTRIUzlzNXE1aWRPSkZaZW1ySTlUQ3ltVzM5dFlt?=
 =?utf-8?B?SGFRbVIxdHE0cFpoS3N4bVZQd0hWb2tsYnlLZ2V2ZFNNR2F0WXZZbmdYOUNm?=
 =?utf-8?B?TDVjemh2Z1F2NmhxZnFpWVFiSVZxb00zN1BkK0dma3FMbk5hOXlON3Y5Z3pz?=
 =?utf-8?B?RTM4Mk1xUllFL1dSQzZkOVpMcVI1Sk1rOHF0KytIczZ0NkVMRFhqT1BuNGt4?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDD56E13CD2D674B99581ACBE32B312E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef82de62-a0ff-4f00-d246-08dda3ddf576
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 03:06:25.7545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9beeAs+mXtSWLA4lwiTEXyqDUFvvxooX0qnaLdQzGw5oUY6xmdNyUZdcVQKDxYPbgZq3Erc+JP6MzQMG9ZdSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF23335A1E7
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA2LTA0IGF0IDEzOjM1IC0wNzAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdy
b3RlOg0KPiBBZGQgYWRkaXRpb25hbCBhdHRyaWJ1dGUgdG8gY29udHJvbCBwZXJmb3JtYW5jZSBv
ZiBwbGF0Zm9ybSB0ZW1wZXJhdHVyZQ0KPiBjb250cm9sIGZlYXR1cmUuIFR3byBhdHRyaWJ1dGVz
IGFyZSBhZGRlZDoNCj4gDQo+IGdhaW46IDAtNyBsZXZlbHMsIHdpdGggMCBiZWluZyBtb3N0IGFn
Z3Jlc3NpdmUuDQo+IAk3IOKAkyBncmFjZWZ1bCwgZmF2b3JzIHBlcmZvcm1hbmNlIGF0IHRoZSBl
eHBlbnNlIG9mIHRlbXBlcmF0dXJlDQo+IAlvdmVyc2hvb3RzDQo+IAkwIOKAkyBhZ2dyZXNzaXZl
LCBmYXZvcnMgdGlnaHQgcmVndWxhdGlvbiBvdmVyIHBlcmZvcm1hbmNlDQoNCkJ5IHJlYWRpbmcg
dGhpcywgSSBrbm93IHRoYXQgc2V0dGluZyAicHRzXzBfY29udHJvbC9nYWluIiB0byBhIGxhcmdl
cg0KdmFsdWUgbWVhbnMgbGVzcyBhZ2dyZXNzaXZlIHB0YyBjb250cm9sLg0KDQpCdXQgd2hhdCBk
b2VzICJnYWluIiBtZWFuIGhlcmU/DQoNCk1heSBiZSBteSBFbmdsaXNoIHByb2JsZW0sIEknbSB0
cnlpbmcgaGFyZCB0byB1bmRlcnN0YW5kIHRoaXMsIGJ1dCBpdCBpcw0Kc3RpbGwgYSBiaXQgY29u
ZnVzaW5nIHRvIG1lLg0KDQp0aGFua3MsDQpydWkNCg0K

