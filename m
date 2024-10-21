Return-Path: <linux-pm+bounces-16122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BA59A71AA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320481C21C07
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F931F9A9C;
	Mon, 21 Oct 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4rwaySo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48E1F942E;
	Mon, 21 Oct 2024 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533571; cv=fail; b=pMiDwtldCcsz6RbgdsLeL4qo4+z8AJJvsAlKP9ltDCv8Q5gH39dIYwzZMqN7uIKmhyujl7NBNXUnt3hthWmevOUfpkHvV5EO/sR34VCtxcD4xswXxq7SnclaCgsHQXG0qTPQay7zct9oDcovydKfCWXpK7HSTK+qYY8Wfkb77Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533571; c=relaxed/simple;
	bh=pHWpFsCwzW7r4e2o9tOzGeltumUwzVNLrlk90VDlT2M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MQMSy6F9bTUwWcx/fyqHIRI4wjUMCwGKZMIOa2bTiKm1jEyFuWrNkD+wg+le8kZVOYQUZSYQVUgxbl4cefLeTeoVOK3oka5Ha9WG6oXWcfskcoprV78IqKNNLE69sUx5tSeWd2h4qe9Qa7pFo0jSVkJsMRIw3mvJx5xGVtnycF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4rwaySo; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729533569; x=1761069569;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pHWpFsCwzW7r4e2o9tOzGeltumUwzVNLrlk90VDlT2M=;
  b=h4rwaySohMOBEEtCQfZvtjIBUH99hM/hCU6Zfe3EabkNftQ8I60Mm2dg
   6CNOxao0h6OG+uX/F8mw+cSWT2MnGjsdxob+Vn5XdRF7Gjerkk1vvccS5
   MhhadJ/R5or2ITOl4KhgT90gCCYGGeuqC++GOfAaXsl+hgNWoDXIVxT7X
   RKEz1sKCsVfWeqob5nN90Saqtz0UxWPiyGlciLc8c5h7dxM/lEb0gLyUn
   On7DsVR8SKMg33psp7vjZaLO5djyYQ1TUy7jQEzTE+RtVacWBM42T/fiT
   ym+eGHKA+cb1CTP6rEri2NMbtMhU1aPzZ25Bvyb5/aHYdqozYod2Iqzgp
   w==;
X-CSE-ConnectionGUID: QLOw9KjDTfqs0J75gU+fTg==
X-CSE-MsgGUID: H3jfGE4oQ4SZKaqkJUSrUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40153798"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40153798"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 10:59:28 -0700
X-CSE-ConnectionGUID: iSfAV/UHQmOh4jnA8eIaGw==
X-CSE-MsgGUID: 7rj89QycQMe0skklt55AhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="80003957"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 10:59:28 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 10:59:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 10:59:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 10:59:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/BLC+LdVGsNoFX47udc+Ph1c8kVFOoIi3oncxB8PLms7M6p37Jj/dKP8SnbAhwSzSKsZx7MsUXbjI9efjcn/6CvdgtNzt8YTavMpjN/+NMCS2POntvbSnSBw/L2LI3SQvw9+8gAo0cGX0leOAu9JTC72kim6g35jmwjiZRm+Z/fr0ib2CKRgC/RvMkxVQnIPB8esw5aGlId3B6pAhH71gqoh/T/3dBlITL1ZE7Uvo/EBsE5Q7deG/RBlhATsmFEt+pO3i9dXOxv9I8z+f5kVmBbvfzRiblyJGXhZlN0tXhK2eK8o4jq8QVZ6dDGC2bbQlLOkiCXuS/esRKFxj5TKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHWpFsCwzW7r4e2o9tOzGeltumUwzVNLrlk90VDlT2M=;
 b=HxZ8rfQh8Pn2GQbyU3qB+xDn2HOj0w3hph2odDmhxyxnLNIiZGG9+qOwC4ykpYj/N5BCCSbJ1Ew5/mMH7eSYW8YYCBGR9yy8Ov2p66KzCVLoBweGJgsgVhXV4d0x2TSpvyZHOARAB8nrNCbg7ByZfyNhS0aGrvg4oeDtsaTwWxzvtgbkV+hL0CldkmSwxWDjAwF4QCCeBxAM1BIh3qecflzW2s7V7IqdUXtjDplLaFj2BBf7xr1aER0aCdOwuEJlfPFy1/HcUjwHpI1rSRjnyNj9vjSPjz/xyItTQgPPjDFuWBOvsdjrPDmsCj6/yw+s1c7rxwpbcFb14WaZ7Q3ebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB8832.namprd11.prod.outlook.com (2603:10b6:208:59a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 17:59:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:59:24 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, Brice Goglin <brice.goglin@gmail.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: RE: [PATCH v4 02/10] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Thread-Topic: [PATCH v4 02/10] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Thread-Index: AQHbE0e4PEbT+P6DKUeyDzQ1CdSMMbKMzJQAgABGHYCABEOqAIAAMfcAgAAI47CAAAo4gIAAAfHQ
Date: Mon, 21 Oct 2024 17:59:24 +0000
Message-ID: <SJ1PR11MB60834693031EB4CBA4BE7BFDFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
 <20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com>
 <20241018161956.GCZxKKrLeTg0VTdfWA@fat_crate.local>
 <20241018203053.2x6oyws3dkxfw6rm@desk>
 <9534B53F-7B91-4525-97DC-889EC3836658@alien8.de>
 <20241021163656.zyyugk4vyqyhzh3i@desk>
 <SJ1PR11MB6083A4F82CCC844D4C8C7D6AFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20241021174519.GIZxaTL7o85C_w2ucR@fat_crate.local>
In-Reply-To: <20241021174519.GIZxaTL7o85C_w2ucR@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB8832:EE_
x-ms-office365-filtering-correlation-id: 49cd248a-38be-4649-375a-08dcf1fa18f5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eDk2S2xEY3FxeXl0RWZqTmF1ZnVDVDVvZGxENjRGRGNlbjA2WEdjSHVyQUE0?=
 =?utf-8?B?WEVGRlJaZlJvV1FPWUlyaVAyVjhJOGowV0dpVHMzcGdZMW1ZSm16ei9YRFRq?=
 =?utf-8?B?Q0V5QnIySU1xd09XYlZmM3dEc3doeG9FZk9zQll3TFNUUDlzUHR0R2x1Q1c0?=
 =?utf-8?B?R3hDOFpTSVQzQVhZVGIwTVVjSnkvVllnelMraExwK3VVN2I3SFZpWm8vUEl2?=
 =?utf-8?B?alRFZXR3MVhKdHFJVlNFbk5YVXJva2xnNlhJcUhWK2Q5WVR3V0dkSnZxeDcx?=
 =?utf-8?B?cUdQdklpUExrRHdidWdOaFNmRkZnKzJSbnhNM05WazdscWZBNGFNZ296ZVJP?=
 =?utf-8?B?R1BTdUNPQWlIUG1lZ0tJOEtDc0NjVHZTWkE0dWEwU0JsVnFPZ2hHMmR3M3Av?=
 =?utf-8?B?RG10SkVJZSt5aXJpaDVqT3N3T1Y0cjlIRTRpbGViRnpDK3hvcWRXR2NxMlg0?=
 =?utf-8?B?YzhlRFBmNlljZEl4STFRd2QxSzdyeVpucGh3dXhJWWZ3STE4OTdnVlcwVWc5?=
 =?utf-8?B?bzdxL0VsVlBjZE55TkFVMnFlYTlCYWJHN2Q4Vlhmd0RIanBjc3NwKzBnNFpN?=
 =?utf-8?B?ZUhXOW5PUmxTQzBJTEp1YkRaU08xSVhqQVFVL3A3cHlFUVBNUmdpWi9lVGNv?=
 =?utf-8?B?TXVySG5FOFV1NjllTVB2SUhGRjlwQ3NZVmYzTHVlRHQ0L3ltUWN2RGpYTnFD?=
 =?utf-8?B?eVhoK0hMcEUycVpWenVPVTRMSlUxQ21oZUV4V3ZkZGRlbCs3dUhIMHlRb3J1?=
 =?utf-8?B?TlJaSCtFTVV5ZUhFZXlBbXFDUzI5YTZMWkgzT3ZTSVk3TlljaDdicTlwWTNj?=
 =?utf-8?B?V1M4S2pXbk5WazNIZERrdW9JZmhmRzUwYUVram92VGZrTU01dytBa3phbGRO?=
 =?utf-8?B?R1lVOENnZzFFcnQyUzZGd3BDNWhhQVhnaThkMnNKRFN5b3VEKzBPaXRYMkJm?=
 =?utf-8?B?WFh3OFB4anRrc1FQOG9xRWFTeE9kY2NOOC9tT3NsanNwQVZBR3RCenBHNThH?=
 =?utf-8?B?QUdxZFhvN0pFaFV0cVFiWFJUbDJJdHM2WWlMdzhIRGxqRUx5WVNldE1XL25Y?=
 =?utf-8?B?dkQ2bmxGbTBFWnp3WnVFV2RaS1lmcTZPRU02cUJwemFodzM1T0d2WDVvem5a?=
 =?utf-8?B?OTBvT0R1dTN5Rk5MVWttcXYwdk1OQUZjRDlmaHp2SHZaYzR6aHcxZnVSblJi?=
 =?utf-8?B?ZEpCamt5NjFoaWJEV1ZEcEhvb0lVUGZpNlE5bnJoY29hbmh0TG5pL3V4S2t0?=
 =?utf-8?B?dVlJNzlZUHlzVUNqWFVHRVRMc0RiK1dua0lQUElPc2JyUzBPTk9ObGhhdHpP?=
 =?utf-8?B?aEIwTjB3TTZIZEN0QSsxVENXRXRWZXRId2l0RkNQYjFqM3Nwb0lwSVM3K0pN?=
 =?utf-8?B?UWx1ZHZWNzlNRVNXazR0ZWRibFhSNGZqOFBWcFRSUmNNbkJld04rSUFJTUlR?=
 =?utf-8?B?K0wvcy9LTFVRS1lMd3FLVVZTNjh4QTMycUs1MldjK2FVMlVrUm5OV01lMkp2?=
 =?utf-8?B?OEZPVzVrVklHaUxMZXgyNG1MbDlHS1BNWE13TXBxMnpBMGo1VHF1UnJLMjdW?=
 =?utf-8?B?RUhOYUlDbTI4ZVpMbXIxS2VGRDRyTWtvQ2pUZGloSjJVRERrdVNJME9aclJ4?=
 =?utf-8?B?NmF3elJoR2lXTHRZbFZYSnYyUG04cE9yN3pEYlk5UWJLd205MzB0VFB4bktq?=
 =?utf-8?B?aE1WdnRYajVyL0d2Q2ppNjc2eVgrWlRKbjMzNlo2dTF5bnlHMWx5c0o2OWlm?=
 =?utf-8?B?WkNxMi9zMFVVMC9JeE5zSEM4cUJDVUk5c3RONnpUczRYS2ZtVVZ5Wi9sZDNE?=
 =?utf-8?Q?RSl+DTuqZeKnVcSdroET38ILzEQyU8GGnCGbk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnJwQnNJSGF6RzJSQXBwUjZRc1hQWHNJMGx3bGtLNFlGQ1JKVVNpQVlHVnB6?=
 =?utf-8?B?b1FnSHpKRklWWWFRcEhlWXRiamw3OXBlb0NwT0F4dzlqd1lkQ0gwczBWbDgz?=
 =?utf-8?B?M2tOLzJoWlB6S1FRdnh2MmJaSFVYU3lXUkdRMWgwdjdDZmYyNXVPeENUaWd5?=
 =?utf-8?B?dGQvY2dzWGpBdlFuWXNabTRPdFNMR213RmxDTkhLaEtsM3E3U1pNdlVuSjFH?=
 =?utf-8?B?cnBzbWFsUGxlMVQ2NDlUYVU3azRQbk03NE9rYWNWeW1uR1JDSTA4dUpTVElp?=
 =?utf-8?B?THR0a3dxRW13Vm1yYzRFbC9FT2g5cFllNCtiUC9QcWlpYURFMWlGTm01SVAw?=
 =?utf-8?B?WmdYZ0djVnE2MFk4a1dJbUJEUG9LSTFsWFFhSWdmcUFBQzkwVUtyUkQyd0t1?=
 =?utf-8?B?RXVId0ZvUDNPU2RuQnJJeU9YNXNvWjRHeWZNTEJTdWNDeFFIOGtDM3k2Uytl?=
 =?utf-8?B?bENzK1o2U2xFZEZ5dndmcVU1T0pkYmd2RDNhQmZ2WHJrNmQvWXd1d094Njlk?=
 =?utf-8?B?U0JDSjh6ZnBZMVV1L0IrOFJVRDF0bnhkK2xyYzU2T2tWeUZ6MmZKV01JVGEr?=
 =?utf-8?B?dUIzZlZzWHN1eU5DRnZOdktqditoNEIxOHMyMTlxRjN4Vkd6NUIyTDJIYjBp?=
 =?utf-8?B?MTdsMjh1YzJJRFRQa25iUE5qZ1drbXFCbzVIVkRONEVGcTlnYzdTa1hVOS9I?=
 =?utf-8?B?L3JtcXBJTEFpNVJjRDhQZGs2cS9kNXNXKytHMnBVdlY5QmJ4Qit3WkZ0ZnBv?=
 =?utf-8?B?Ykc4OG50TnFqUVZSakdxRy9KclhSeXltcU9jNXVFWTB5RUJCUmJvMGpmUzJt?=
 =?utf-8?B?bGt6ZkFpdjF4QnBjbVZOME1LNzVVQTRzK0VLYi9XWlhiR3RRRi9LeFU0YW5C?=
 =?utf-8?B?cmNPN1JOTUFGdDgvbyttUkhqd0pqVlZkWGF6V0VWMEZxU2hzZWNMcVc1eTlx?=
 =?utf-8?B?WXlsV3pWNUJZN2FrVC81NVZibGxZSVg1U2ZDUmNKSzBreHIrNzFGU0tMMkJz?=
 =?utf-8?B?USs5YUE4QnJuSTJ2WE1sWHZyTTBjemFIUElEeDZmNkd3V2wvMWtoSkM0OHZF?=
 =?utf-8?B?dzhZNHdCKzQ4bUdzY05GNTRlYU52SkVZdXYwNDVKa25NNUtNalpnVm1aL3hx?=
 =?utf-8?B?VEN5dEszekM2cENvbU5IZWhuWSsva1RxS20yVW51TStmVTc0R1BuS0RwQ0xp?=
 =?utf-8?B?SkdDNlZFOFhmOWJ0Y1cvYlRLc1g4c0hhdnREWVpyakd6S3NkVzc5WG1TYXlS?=
 =?utf-8?B?V09ZNDRCejFFdWx2Sks4UE5iTlJxWVFIejExa3Q0S3hGMFc5MzRZcFJEbCtD?=
 =?utf-8?B?QWNDUUpkODNPc1ZnSHJUNmVDeUtjTGM1OG85ZVo4UkMyREs1dVFLdG5nM2dO?=
 =?utf-8?B?bDk3c0ROWi9oZWNkWWpUMWFnYmZZamp2elduVEJUdmE2OUFTdndNM3dNdWdo?=
 =?utf-8?B?WTB4T0JzeW50QnBRU1JmbG9EU2syS1hPYTdCa3hsdWw1WVVOcyswendncVpI?=
 =?utf-8?B?NysxVmxFR09IWlA5cDhEeDdBakJTa0VXbzdQUmFOMFNyMHVPZy8xM1VJOFRE?=
 =?utf-8?B?QkVjeHh1Wmt2RFRGMjFsSU14ZFEzMXltbUZvMWFJQW5BM09RelFlVmZoV1J0?=
 =?utf-8?B?TXhYNG8vY292eG9nN0Z2NDI4VnJ0WjR3UGV6L2d3SnozLzlMRnVyZllDOW1T?=
 =?utf-8?B?bjE2OHI0dG5VRW5BcGZyS0J0WjBMSDl6VEVJVWU3bWs4cWZPT0hXaFBPUS9H?=
 =?utf-8?B?RWx1RmdrU251YVFvNVZFZnRwNXo2Y1ZBem1ERmVJcm5LOTgwSDB1VFhtalpu?=
 =?utf-8?B?aE9GM3NwV1hjWENMaFVCcVIweGNXbDFRakFudktUcFpIQmRVaVZLRkFNOTZO?=
 =?utf-8?B?ZDFac0J6Y3R0cVVEWkQxRVEvOHU5Z01SYlVpM0htOWhhQWRmSzJyQ1JaR1dO?=
 =?utf-8?B?aGlxN3JBZitoRG9uWlVERW54bStmdUxWNVNGMFVlaUMxaDlSUERzNnBNNTFa?=
 =?utf-8?B?Z09CYldWTDBCVHVJWm9xa0lNMnk0MTIrUDFOVVc3TXd4ZDBFV3N0enlwK1U1?=
 =?utf-8?B?Rkt2RXU0K1JJWm5RL21tWjU0YU1OM2RwQmtlU09tNlo0ckd3UDBwR0pBZTVr?=
 =?utf-8?Q?hokLF+A2wCYwI8+L3r3aY/8Vw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cd248a-38be-4649-375a-08dcf1fa18f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 17:59:24.1989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3yMjbUbWAXC8VUopmCDNZD6MI5r0/nHpJE8hskOPSmeyIrGwnC2EgNPBRBAI7Lqrz9+XAYTkNdMXo09h2IHnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8832
X-OriginatorOrg: intel.com

PiA+ICNkZWZpbmUgSU5URUxfQUxERVJMQUtFX0wgICAgICAgICAgICAgICBJRk0oNiwgMHg5QSkg
LyogR29sZGVuIENvdmUgLyBHcmFjZW1vbnQgKi8NCj4gPg0KPiA+ICNkZWZpbmUgSU5URUxfUkFQ
VE9STEFLRSAgICAgICAgICAgICAgICBJRk0oNiwgMHhCNykgLyogUmFwdG9yIENvdmUgLyBFbmhh
bmNlZCBHcmFjZW1vbnQgKi8NCj4gPg0KPiA+IFRoZSBuYXRpdmUgbW9kZWwgbnVtYmVyIGNvdWxk
IGJlIGhlbHBmdWwgdG8gdGVsbCB3aGF0IGVhY2ggb2YgeW91ciBQLWNvcmVzIGFuZCBFLWNvcmVz
DQo+ID4gYXJlIGJhc2VkIG9uLiBDb3VsZCBiZSB1c2VmdWwgd2hlbiB0aGUgc2FtZSBiYXNlIGNv
cmUgaXMgdXNlZCBpbiBtb3JlIHRoYW4gb25lIFNvQw0KPiA+IGdlbmVyYXRpb24uDQo+DQo+IEhv
dyBhbSBJIHN1cHBvc2VkIHRvIHJlYWQgdGhpcz8NCj4NCj4gR3JhY2Vtb250IGlzIHRoZSAibmF0
aXZlIiwgYmFzZSBjb3JlIGFuZCBmcm9tIHRoYXQgdGhleSBkbyBhIEdvbGRlbiBDb3ZlIGFuZA0K
PiBhIFJhcHRvciBDb3ZlPw0KPg0KPiBXaGF0IGRvZXMgdGhhdCBoYXZlIHRvIGRvIHdpdGggdGhl
IFAtIGFuZCBFLWNvcmVzPyBBcmUgdGhvc2UgYWJvdmUgdHdvDQo+IGRpZmZlcmVudCB0eXBlcyB3
cnQgcGVyZm9ybWFuY2U/DQoNCklmIHlvdSBhcmUgcnVubmluZyBvbiBhbiBBbGRlciBMYWtlIHlv
dSdsbCBzZWUgdGhhdCBDUFVJRCBzYXlzIHlvdSBhcmUNCmZhbWlseSA2LCBtb2RlbCA5QS4gQ1BV
SUQgd2lsbCBhbHNvIHRlbGwgeW91IHRoYXQgdGhpcyBpcyBhIGh5YnJpZCBwYXJ0DQp3aXRoIGJv
dGggUC1jb3JlcyBhbmQgRS1jb3Jlcy4gQ1BVSUQgd2lsbCB0ZWxsIHlvdSB3aGljaCBsb2dpY2Fs
IENQVXMNCmFyZSBQLWNvcmVzIGFuZCB3aGljaCBhcmUgRS1jb3Jlcy4NCg0KQnV0IGluIHNvbWUg
Y2FzZXMgeW91IG1pZ2h0IHdhbnQgdG8ga25vdyAqd2hpY2gqIEUtY29yZSB5b3UgaGF2ZQ0KKGxp
a2VseSBjYXNlcyBhcmUgZm9yIHBlcmZvcm1hbmNlIGNvdW50ZXJzKS4gVGhlIG5hdGl2ZSBtb2Rl
bCBudW1iZXINCndpbGwgaGVscCB3aXRoIHRoYXQuDQoNCldlIHByb2JhYmx5IG91Z2h0IHRvIHB1
Ymxpc2ggYSB0YWJsZSBvZiBuYXRpdmUgbW9kZWwgbnVtYmVycyAuLi4gYnV0DQpJIGRvbid0IGtu
b3cgaWYgdGhlcmUgYXJlIHBsYW5zIHRvIGRvIHRoYXQuIExpa2VseSB0aGF0IFdpa2lwZWRpYSB3
aWxsIGdldA0KdG8gdGhhdCBiZWZvcmUgSW50ZWwgZG9lcy4gDQoNCi1Ub255DQo=

