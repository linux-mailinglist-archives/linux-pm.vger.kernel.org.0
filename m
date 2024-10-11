Return-Path: <linux-pm+bounces-15541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E48599A6EB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 16:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8FA9B275D8
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E057A8172D;
	Fri, 11 Oct 2024 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVCzjNZ6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47515252D;
	Fri, 11 Oct 2024 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658275; cv=fail; b=GhDDcW8QjqpyGE5s6sNwYScSwGVmzJyiWxLl/piTzrV9yka9cdY1ZUWNT+rX/Re6mcG/eZaix/ulBfomhvrruThppsB36FJzKrJ6cDEA0qIhfmzmSTyCDgvPPTq0n6h160OgaiFWRT8HwQ+aqdD+eiT5yBr1cesYPMDUUJN8siE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658275; c=relaxed/simple;
	bh=TAf536MjELZuxMN7zpfZxaspGKEtcHWCirQqFKMJtkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pSSSf42Nq8twKV5tFTOB0PbNWt/H9IiVCcrW7BdYxd0YDeMsMW6VHquMfThH9E45YrG8WLYx+PajgAtpRSwy1Sp6J5VBrfpZn9gqy9u44g6taGbzQtDj+aees4AMsWdHCoetV00x1y9diEsry6scmiYxIkSuuo3VWIMKpCBitHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVCzjNZ6; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728658271; x=1760194271;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TAf536MjELZuxMN7zpfZxaspGKEtcHWCirQqFKMJtkQ=;
  b=AVCzjNZ6hq0lky4e8boF6L4GPjpTrs9T9B9QfOgT2PAMh696xKEBcB9M
   TOrJt9MDpzOvSEDZgb8mLUFWx/V4i6do8dVVY2P5WO7a7LY/sCXVsOwB7
   FBJeoLRd9O5CXR9YMAVrq6VolCYSD6aTUg/ldm6Fz0IGJr6E/5te3ora4
   s5/TuJG6cmgzSXFrsABY18LOqamp7tQeEiPif3CZk1BEljA+GyJMWkDn4
   MBNWU2we3JwChkabVExokOvylszVRtqz4SjR9V8AG5GIrjygYtB7A67GC
   xbXJ9h+wQo8W3TmYKxcZ3/DKVeNBt47/nURwEdhBNLXvr1eoDSA6gffcW
   g==;
X-CSE-ConnectionGUID: SIZa4asYTcqejefT72z+Xg==
X-CSE-MsgGUID: 75O0gDUQRfij/ejEx10IYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28219777"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28219777"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 07:51:10 -0700
X-CSE-ConnectionGUID: u6lIE2ZXReOepZ5hjsn2JQ==
X-CSE-MsgGUID: 08yS96j3S568vvcMxMGeSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="107659227"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 07:51:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 07:51:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 07:51:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 07:51:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 07:51:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etQDj1oE9Yg9W+ICudwQjfzapjjBRCMQnIEC8nuzr/zKzq4QFM57GQoY4hA4Mt19msJj7AvvZjMDnS/gdWK2tJ6jG0PYq2PYQMnn4oTUGD/TOPKIExFw1tNDDAuA8cEuS2aAJXSSxZF8WPkDhVowT8GyJsO8DWDKw+tVuKTZUkl+57VkEp+wFGIULoUQS31r//j0vPqUQ4s1OXA+6E7agLoemvhyRCv7syWXDB8Kc4gbXUPvmb/43+00dooGLVxW07Ln4h2yME//vjo1c/MlppgGslBqMOtrfSpHlFtl4W1S6519o7RKUgnlxWn2KtE2LVaoYiERB1JBDtH2nAMCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAf536MjELZuxMN7zpfZxaspGKEtcHWCirQqFKMJtkQ=;
 b=DJ0+Jb97a359axR+ZY3MKwOAGF4yGUAxbtGlUx+tjzC3aUtxAVo4AhNYODqBbcAQA4j5uALGSy+bPc67epTUUGuqUrDNYGkGEbQDf5GlE091a+SvPVHJcXkx8h1g0kC4hIYhVXbp4Beq9tx/bEjrQbvDXmDKO+LQ0w+g8aczyTjF4oYRJAAHv8uVvGlis3cTu1IdU3PQKH9U3px3C+L5YQKbkUevLiJ0aNf/mVdM5om6Sj1eG4pv6Ndyo26PJi3l3O/b+xmFz+gYmPj/rWbAmWNcsE6jr6v3Z+wIsJh6jVE2NUJIk2jOtmHIS4UXmFheDBJXc40ye+bqEwOzJZprNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SA0PR11MB4750.namprd11.prod.outlook.com (2603:10b6:806:9d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.20; Fri, 11 Oct 2024 14:51:06 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 14:51:06 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "Hansen, Dave"
	<dave.hansen@intel.com>
CC: "Luck, Tony" <tony.luck@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "Zhang, Rui" <rui.zhang@intel.com>,
	"thorsten.blum@toblux.com" <thorsten.blum@toblux.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "yuntao.wang@linux.dev" <yuntao.wang@linux.dev>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Brown, Len"
	<len.brown@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH V2] x86/apic: Stop the TSC Deadline timer during lapic
 timer shutdown
Thread-Topic: [PATCH V2] x86/apic: Stop the TSC Deadline timer during lapic
 timer shutdown
Thread-Index: AQHbGhvIBpudu4gmjkCMgWFW3n/XxrJ+slqAgAAPuACAAfbQAIAAorCAgABKNAA=
Date: Fri, 11 Oct 2024 14:51:06 +0000
Message-ID: <a6adc8fb982fdf914847990483ae2a263d7d4397.camel@intel.com>
References: <20241009072001.509508-1-rui.zhang@intel.com>
	 <f568dbbc-ac60-4c25-80d1-87e424bd649c@intel.com>
	 <CAJZ5v0gHn9iOPZXgBPA7O0zcN=S89NBP4JFsjpdWbwixtRrqqQ@mail.gmail.com>
	 <edb18687-9cd7-439e-b526-0eda6585e386@intel.com>
	 <CAJZ5v0hF381EHwO7AECgOM08kAQjppq3x9f2e-UHQYdYySCwBg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hF381EHwO7AECgOM08kAQjppq3x9f2e-UHQYdYySCwBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SA0PR11MB4750:EE_
x-ms-office365-filtering-correlation-id: fb1cddc4-3c2a-486e-4c8b-08dcea0422ec
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?THB4b1lwZ3VTMW1DNmpqVUROZGwxLzgwUTJkYzl1cGdWci8vMlpaSHVwYU9I?=
 =?utf-8?B?ZGRnRnRIblFoaU5XdXowSlBMMEwrMHJROG1FM2p4WHYvWnEzdGkvQTVsRjZL?=
 =?utf-8?B?Q3RGMFRRcnhGRXJDWHdVaGttTVZsYWxPbTlvUllXRWJHUEtMTWR6bnUwOTkv?=
 =?utf-8?B?QjFPeE1GYTJhelYvU3NTUlJuQ3ZDbEFBVHZRRGZMREpENmh0S0FjVmdYMzh2?=
 =?utf-8?B?eU9zVXUzN0tUZHBwSTJnY0xRWWk0MU1TbnlKbURvVVNjdWUxdmlEODZ5QVBO?=
 =?utf-8?B?aTFDRkdscEtKYzlMN3piRWVKaWtBME9hb3VsRkR6SGwwSUthSEJkYzQzcVlM?=
 =?utf-8?B?Tk9KejRVN3FtQ25hcFVMbk1CdmN0U3BObnM3QWx0NFFWOWhyK1NjSUE1R3VC?=
 =?utf-8?B?SE1RZDY2NWdjSjFXR0xhTU1xbUNVSUQxaFBSYWZPamdTOGNqQjdYaGhCenF5?=
 =?utf-8?B?Y1dISDA3Z2pjek5Uc2VFVkxuS20zbE9iN2dyZktzUEdjMHJ1ay9LdG1QV01q?=
 =?utf-8?B?clJVWUJ3YVdRVWU1U2VISVRWZEU2aU9odDBWcWVaelpwTW9ScEZtWWR1UkVC?=
 =?utf-8?B?MDVMUDkyMmk5SnJGK0FPWVhMaUdUNUUxZEU3enMrbXphaXYwaVowK1lwQVFH?=
 =?utf-8?B?SXkrdGFlMW9TOUJFVm9wdTJjcDgwc1puNlR5c0pOdUdWYTVGNXQrS0xJSkdz?=
 =?utf-8?B?bzY0dzBHbk9QUHpHaFoySWlyeVN4TUpsMjJMaWY3ZVpwYkNLbmhuTGUyQjRR?=
 =?utf-8?B?dHB0bjEwMEV4c0NKUW0reVBCVGVwYTlDbDhSUTJnbnhEbEJ2ZEloTWJhYVNX?=
 =?utf-8?B?OUhtdG1GR0U5OE9nQ0YwRVhDNXdjT0ExRWVhTTFKYkgvSms3Q2M2TFNicWNW?=
 =?utf-8?B?V0RUcDByTzU1QVNOY3ozakR5MFRpVjFpMFY3VFRXZk1TWlZKU0dDQ0E2d1RE?=
 =?utf-8?B?V2E0L2srMFVzcVZwYmptelVLMVFzR3JiL1FudFBaaERISGpsRVNnUHlaUjhx?=
 =?utf-8?B?YWQzY0ZzWmlzWUx0b1hISytHWnhpMmkyVmdIZG1OWmQzZE9lRkJkWVIzeVp0?=
 =?utf-8?B?NXFJRkM1ZFdqb3MyaTI1ZENrelpPWGluT1puVEFmMlAvSE9GZlViWSt2OGtX?=
 =?utf-8?B?dWN6MXJYWE0rbmRaQ01TN3NMVkJnR2w0QVVGbEJDWTNvS1ZJUDNiZHo2Qmt0?=
 =?utf-8?B?anlCdFoyOXNmVmRZb0FsUGxjYUhyUDJzdTRmZU93S0J1NmxuWFBYM2kxRzB1?=
 =?utf-8?B?aDA0TmV1SUNaOGMxYy9RNGpyQUV0bitVbEczWENkVjB5TlRWTGMxZmZzbmtD?=
 =?utf-8?B?RXZWWVFJckYySzJUb2xMTjRpcWZ2ZEtHMXRXOWhhSExBTko2OENLMzJjMm5X?=
 =?utf-8?B?OWRwemxtb3BXVUlWTUFxTEhQdnVNVFNrcDlDUFFUOXhDVE5yaTJTa1JMWTlQ?=
 =?utf-8?B?NzNZK29ubjRieFVkeUNOcTAvSlkxaU9CNFVkb3dFT3FkeHptRkdtNTZVQUl4?=
 =?utf-8?B?c1RkUmI1ZDl3aWltVTNDNy9NYTlNczZ6MkNWWFBhTXJwVTRnQkJOMjhLU0Rv?=
 =?utf-8?B?Q2I3ZG5KQTlZZUttU2hNSTZ0N2YzU1NTZStNVW5OMlhyRHgwOFNNUmxmTnFS?=
 =?utf-8?B?RkdkT2dOUjFMSVpQUzhvdTU3VFhiTDFYVFBhNnlnNWtJTTA2bUNwSWhFYzB6?=
 =?utf-8?B?TldKVDk2b0ozMGFhUmRWRnpvNnpVMkQvZjJEUTJOQ0NBU1ZscmxLQm1UMlMz?=
 =?utf-8?B?dHpaUTdCTDY4bHdENVQ5bk1oS2ttVU1KWFdIYWx2VHBPQXRaK0VLVkkrNkxN?=
 =?utf-8?B?b0FsSmlvRmREaHllSExBdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkVESHorbDc0Y1VvWDZoV1Y2NUREalR1TlAvbzY3SXY3NXA4UEdRWC9EYUZt?=
 =?utf-8?B?czlNRkRxQXdIS2RzSjZxWmZTaUpPSndNY3F2eUFWaFpDSU00K2k0QlFZQjRW?=
 =?utf-8?B?Z283RmUrNzhXS0FzempQNXRQT0liVGRvc0hwenJCZmR0dFZPMWZXZzRUdXZt?=
 =?utf-8?B?QTBCL1hDOG1DMHo2NVY1ZkEzWHZuVld4SnZQYjhkMVJQUWtMaEFSU24wc09k?=
 =?utf-8?B?MUw5WHJMbFhwczV2N0g5c1RoVUlmOTVmaXFHRFBoV2d2V0dFNUNidVU5dmVw?=
 =?utf-8?B?UzBRZ0pzRms0UFovRlRteXZ4WnQ3QkgzaFJXb000OHpNVmlDQnQ3WU45M21Y?=
 =?utf-8?B?a2VHS09yR0thUnJPUlQ2SnFUL0xWRklha0UwblJTaGlXMStXSGFZZUp0ZDZR?=
 =?utf-8?B?aTllaFBFSnZEa0ZEYzdVV3lBelhFNjZRbHhJQ0FSd0FpRkpQWWNRMUVNYVhE?=
 =?utf-8?B?c3JaYVN5WDh2MDh2cktuNW1XeDdFbExVS2NZWmdKQ0o1ZGJFTVQ0K0d2NUMv?=
 =?utf-8?B?RWFUeVBCRGpMbktPWkJmYkt6dE9oS3V3VlUxM3QyVUphdWhEZmQvMGxnbDdX?=
 =?utf-8?B?Q0xOZ1ljazJvOTgwRFBpUG1HbDN3OXYyMHJnYjgwUkp5T1RZSVpSaTMwVlIw?=
 =?utf-8?B?U3hyWHZyYnlkTGZ6K1ozL3pWb2lrUE5kSzlrVHNPY1ExSU9VQUNIb2hvMndz?=
 =?utf-8?B?cU42VVd1K2pKOGkyYVZXTWNaSUhpMW5ZVDUwWGpJRy9sbklGZGVTV2Ewd3pD?=
 =?utf-8?B?YW5IUkEzZEFXN2QvV294OTBGTFdCUmRuNzBTN2k1VGN3ZVp4dU9PV2VWcTJP?=
 =?utf-8?B?MU5peVAxbGVQOHJaYk5tYTNrYzh4VWNqTUNpTHpqdnRqVnpBYlZ3OHJ6K3ps?=
 =?utf-8?B?Q0dwNE4reTZYMUlsUGpidDFrTThTcjRnNkc5RnBROFRhcGs3djNMazRlQjVy?=
 =?utf-8?B?SE4ycGd2RFN0RTdBeTQ3SGdTTjFXOG4rZXU2cDI5cDk0QnlHZlE3cGUvQVZ3?=
 =?utf-8?B?SDQ1ZUkrMXhZekJMOGtNUGw1RVI5bm82c1BFRFBLTlRKSldNQkZQeWkxMXhC?=
 =?utf-8?B?UWUzS052MFZ0REJJVTdLN2lzSFM5UDlkampWQ2VpdDNvc1lKTXJjaDBtbU4y?=
 =?utf-8?B?OVh1cSt1UUp5OHBqNHdocjVvMkI1cXNCcVI4OVBTMWtLVU9KWldkdW9rUjNN?=
 =?utf-8?B?Q3c4NndyVGwrWjA3Y1JLcmtqL0xtUURrQmpSS1VUTDVnZytrK3lBT2Fzb1Av?=
 =?utf-8?B?NS9wOGhiRnpXOHp2clBXWmR3WGQ5a3VZaWpoUGZYYWdTYnV0aDJrVWNqdmhp?=
 =?utf-8?B?c0Q4SE84eFZtUDhiTUdPdGZZRHExWlFpSUFXYUIyNWdLd1NGNWtiNTZERWIz?=
 =?utf-8?B?cGw4SWEvcnkxMGpHeDdnWkttdFpwTTc5amwrVzV6NDl6UWY0VU1sWU1pM0ZP?=
 =?utf-8?B?L1VFUWpyWHp2M256V2xnWGsrc0tvMlVVNzU0djFFVFArdys3UDB6T0xSemF5?=
 =?utf-8?B?aU40eTZKWWdDS0JBd1REUWhGaEFmckZZYU9LRStaV01hQWlOUzlEYzdWL0Zj?=
 =?utf-8?B?QTY4dDNiV09kbm1GMFo3TEd5U2w4VFRmaDZ1bGJOcy9jM21pTitEeDZrREli?=
 =?utf-8?B?NGIvSTdqbm85aTJMQmdSWnIvdEpCcDFrMkJFc20zTWFJRHVleGJEbTAwZFFu?=
 =?utf-8?B?bUZuWG1QZk1EZnJtK0huQnBqSWVYOUVVbjA4eUtxUmREK0x0d1VySzhhNGt4?=
 =?utf-8?B?Sko5K2xqQzlDM3ptNmZjK2txWlNHK0gwT1pjL0dSbnBPZ2xYRmZZMkswRnI5?=
 =?utf-8?B?MkdTL081Vk1ERXhTZlU0MS9ieWZiUnRaSk9UQUhGaU1ZZTBzbFhMdGJyeHg4?=
 =?utf-8?B?Y3k0VFFUcnV0cUNJdFI0aVBjazhRVUlWV3RuRkFlL25BQmt6bGN1N0pBQyts?=
 =?utf-8?B?N2NPbkxTVUlLWEd3S0FFUWdqYzg2czJhNkdNZ0JYSEdMaGtJS3BVdjNLRzBU?=
 =?utf-8?B?OUJYd2xpUzJLbU9ETDRHSDdrbzkxdDQ3bFdNSUFpcXRjckVwUDVSamZsSjBx?=
 =?utf-8?B?TklSSmo4Tk9MQWR3c2YxM09ta3h4WHd5SDRRNU1aaDRWRGU2R1htQ0tra1ZO?=
 =?utf-8?B?N1o2cm1jeUhGZmpPNC85eHV6RjhaQWtla3NiNVRFVzhGcVk1MGpNOTVESGpy?=
 =?utf-8?Q?f+Ca+kZh/ZDi0uSiNdmVeVg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <649B6FDB428C9441909C6799B834932C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1cddc4-3c2a-486e-4c8b-08dcea0422ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 14:51:06.6051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EoXwVxt33lIoyFejGHxUBmD5Ep+pI11y/ne+Fct/GGir//knjLuR8gr79A/Bu67T7Z5HcABzUxXkauqFIupKl2mMpg91AGnIBudInSo0KlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4750
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTEwLTExIGF0IDEyOjI1ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gRnJpLCBPY3QgMTEsIDIwMjQgYXQgMjo0M+KAr0FNIERhdmUgSGFuc2VuIDxkYXZl
LmhhbnNlbkBpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IEhvdyBhYm91dCBzb21ldGhp
bmcgbGlrZSB0aGUgY29tcGxldGVseSB1bnRlc3RlZCBhdHRhY2hlZCBwYXRjaD8NCj4gPiANCj4g
PiBJTU5ITywgaXQgaW1wcm92ZXMgb24gd2hhdCB3YXMgcG9zdGVkIGhlcmUgYmVjYXVzZSBpdCBk
cmF3cyBhDQo+ID4gcGFyYWxsZWwNCj4gPiB3aXRoIGFuIEFNRCBlcnJhdHVtIGFuZCBhbHNvIGF2
b2lkcyB3cml0ZXMgdG8gQVBJQ19UTUlDVCB0aGF0IHdvdWxkDQo+ID4gZ2V0DQo+ID4gaWdub3Jl
ZCBhbnl3YXkuDQo+IA0KPiBQbGVhc2UgZmVlbCBmcmVlIHRvIGFkZA0KPiANCj4gUmV2aWV3ZWQt
Ynk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCj4gDQo+
IHRvIHRoaXMgb25lIHdoZW4gaXQncyByZWFkeS4NClRlc3RlZCBvbiBMdW5hciBMYWtlIGZvciB0
aGUgbmV3IHBhdGNoDQoNClRlc3RlZC1ieTogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMu
cGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo=

