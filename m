Return-Path: <linux-pm+bounces-10055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A4A9183D6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 16:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4813D1C21D0D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7910E185E7B;
	Wed, 26 Jun 2024 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUbOTn5B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FDC1802DB;
	Wed, 26 Jun 2024 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411718; cv=fail; b=iIRf3yZ7X6I0ngDKwDMR23rmFEn9W02vUHNO3Tmpx4YinWZPQ+/RlSDNxeQiO3Qvely45sH51TMzIpKl0+wkod82cifPz8PmKDeX/F9utv9FgFQ8CtGDzpbm1i5RaAO9mucm+Js+/IGmbQFb197UHRv3A1Sr2rlRYabeBSOxu7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411718; c=relaxed/simple;
	bh=bH0K+nY/Z74th5ngZp7CVGFz7x6W13VRKmzormkALvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PQGRW6r2JZkK/LIPTG0vgRVpbjUCbq/8yE3hyI4ce1F4d2+jjsjsIiv7gP0vQ8nLOpB/t79c5yGGxfLU7FoUF96UrC5yMfPte9nqOaAmBnWwvel337iWh3vq+BpAqPKw2wvNAFBwCPzs4LBj2Lo6px9dY0WsfmT3ZDZ2v6AN64I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SUbOTn5B; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719411716; x=1750947716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bH0K+nY/Z74th5ngZp7CVGFz7x6W13VRKmzormkALvY=;
  b=SUbOTn5BaZnzhi4G71sg0heFjWPW8wtD3wR7ME8uqJ3vhhPRFs6VzQ3g
   VwSLK45aOYha9efqOWUJ1PDrEbUKKtAKTDvC9G7Cp5JglLMuNhrktmmF1
   2g5FQSsM63Zv5s9yUGN28ewBzWFSJU+2Hqn22R4YLNoHwZIXx3FLLzVvm
   K8lz1oL8J6FBnmbIwK1uQCmUAksekeNU86bKUlfNH4wrHxoT1WTUdoehR
   lL/hcACQ20qRVlWczfRnGwnhmeWGrUDxMcjiTe8HawiGKO5fEOy/ZMKwp
   O3l6FD5x9YMRV33HUT8nKC0PQ3r4VU4L5emMy/r6QsHdoccz5iQNpj1HM
   w==;
X-CSE-ConnectionGUID: b/0DTBaQQ5GLZRD2T4BX9g==
X-CSE-MsgGUID: gLLl7LaGTlaZJo/Vj3RWLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16318598"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="16318598"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 07:14:45 -0700
X-CSE-ConnectionGUID: dCAjNkVWRMuvKMkIe7fEdA==
X-CSE-MsgGUID: Ih0EktapQdm2A50yQOZTwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="44440509"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 07:14:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 07:14:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 07:14:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 07:14:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 07:14:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU8YHz1HK+sEjibCyr/46Ke/Dbpx2vdDzXfc4kDG60YHZUR7fJ6lrPA6bfaIEFdDwpMLsSND81NTGPqZ0hYNypk8XBxdjm25tE3ay8QA2J41UJdEuLVr6PJQ9N7KlO3ZWwIqbMNT0YkeC3c9C1eoGAi6W79ZCgj86WU1aEIW4mbn+lx0o76EuLNrc6LlcBOsjKqoUvy83Fgc8vUm2p9Rnl0tfhZMGP9B/ffk28zvHEuzt5Mz+PKlYhXH8Gh5ntKoO62L20FNkANu6NG1CL+8+EQ87ZClStWAXr5ATbeTcTYODIn/ZQuvVF0EI9GZdlBAtvCl0+km2+AEkdrCKh+kgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH0K+nY/Z74th5ngZp7CVGFz7x6W13VRKmzormkALvY=;
 b=maRhPKeahkUnoSwoiPU8EsEWEXHd3jXzaB4dtoaPiugC+L7dm+s10pqU231nVzH8WfKM6AopOKgjjwAhLtRLBkSd2ozrkVLjJMOcuw9wiBw6ACHV9YoolWYHINjte+qw0y27YhDrPUeu39lP1Cq9MXqWuX0AdEF0KVxToYOyNCFikRgeWpTDRhDMGd4zNdxMdQ+EP0WjXCEgwfstX9dszunRUfDoeMaV2INSok1pIK5yH3iWItOgLio7fPPyhcuUPTUbEIZXe8ji0teYx1BiAhyWd9dQ5Gb/RbHttHPYst2oh1H8mKeGEbSqxopTHS5pLGq9QcDPSWgZVdUXr7HOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by LV3PR11MB8507.namprd11.prod.outlook.com (2603:10b6:408:1b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 14:14:40 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%7]) with mapi id 15.20.7698.033; Wed, 26 Jun 2024
 14:14:36 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"irogers@google.com" <irogers@google.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "kees@kernel.org"
	<kees@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Dhananjay.Ugwekar@amd.com"
	<Dhananjay.Ugwekar@amd.com>, "bp@alien8.de" <bp@alien8.de>, "acme@kernel.org"
	<acme@kernel.org>, "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>
CC: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "ananth.narayan@amd.com"
	<ananth.narayan@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 01/10] x86/topology: Introduce
 topology_logical_core_id()
Thread-Topic: [PATCH v3 01/10] x86/topology: Introduce
 topology_logical_core_id()
Thread-Index: AQHaxfvR+VpoP6aOOEC5liaI3DFjx7HaGmCA
Date: Wed, 26 Jun 2024 14:14:36 +0000
Message-ID: <efe9cd89b70542facf862ea8e8ae8e2f19c8cc5e.camel@intel.com>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
	 <20240624055907.7720-2-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240624055907.7720-2-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|LV3PR11MB8507:EE_
x-ms-office365-filtering-correlation-id: 023d0c4e-581b-4a6a-9d39-08dc95ea4f88
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|1800799022|376012|7416012|921018|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?ci9HNUtVbVdzMEIvK09kNGgwNGthNXNNMHBqcHZlYXMwRUo4QUxZT053T0dn?=
 =?utf-8?B?WVhlRkYxczVTVE9lT3g4MFZHd1BoM3IzTkc2Yi9oeWpwSmhXaFRwam9qTXN5?=
 =?utf-8?B?elJRb3FtSTdYQmMrYytCNWlLREM1YXlzZ3RIVUZFcGZlM2dKMnV1WG5YSFcz?=
 =?utf-8?B?NDkwZ2dhSFhQamdXdTNnWnIxMHVFSHp6clFINGN3VFhHOWMxSWFmS0FoM1FE?=
 =?utf-8?B?MUx1eW9ablg5b3hiTTV5akpYQXFDTlFXbUFraEgwckUrZlBJODhnNy8yNUZK?=
 =?utf-8?B?RTRBOWRibzBJVmN2TzdUdDBOQURXT1pyY0l3OXJCeXZCdnZWYlo1c0JTT3VE?=
 =?utf-8?B?RHVPYWZqWlFwR0xOdnhpNXU0VlU4Ungva3Y2ZVliWkg5TjhZWmRGRzdzR1Av?=
 =?utf-8?B?R1FhOEM0ZExzbkw4cnNMc29zZ2RMRzJPV0Z1bW00c1JhY1R0SWE5UGtQNEtW?=
 =?utf-8?B?T1I3VlF1LzZlalpkRWpUTUpnaG0vQjlMVEtqb00vdGZaMXpYcVk3YjN1eXY1?=
 =?utf-8?B?SVJuK1d3SXJXM2owTDlFZFBYbS84QmpuOTY1VG9McGtRbXhiSG9NTHBBaVhE?=
 =?utf-8?B?TjlESjBlMlU3SExtamlCU0JjajhMclkxMVRCUTlKdzVkUFNWS3RzdWE4REpI?=
 =?utf-8?B?VG1BV3UvSUg0czlOdU9RSE1uWWFjV2djR1lMd0VBZDF5RGxCYncwY01oNzBm?=
 =?utf-8?B?Wm52VkFRZ1ZweE9KS0hJSmFJN2dBVHl3ZnA3WC9hQm14SGNiVDZDOERWQnlE?=
 =?utf-8?B?dmpwY1JBU2RqNDZLTlR0Ukg4MmJZV2RSZkg1SmptL3FWZGNOaEhWS1VjeWRw?=
 =?utf-8?B?aFZmczlTYkJlUEY4ejllVTNHREZJcEIwUmZPbWEwQTk5YnBLYzVzcnp6c1c5?=
 =?utf-8?B?MXlKS3NhVmhJMWdncDJ5QjBLZGR1c092RE5vYU5ET3JKVzU2K0FkSWZ0aXVl?=
 =?utf-8?B?MzRxWHhwOUZBQXNiY0xpNU9BZ09hM2R1WlZoRXc5d3NxT0t4UU1IQkQvZldz?=
 =?utf-8?B?SVRCZ0RidU5tdkRZTm9uSTJtejJBSU5qL29FdkpYTDRad1VXbHhETmZPM3li?=
 =?utf-8?B?bXFyRENsRVRJLzIwampyWGNMMGtNSjJQMWxsa1BmNEowRThSbHBvNDE5ekhG?=
 =?utf-8?B?OTFSdHZWYVlmcFpaTW1UMnJTOU92NXZzek4xbWpSbUJ6c3hhalRINmo1c20y?=
 =?utf-8?B?Yy84dXl2WUVnVS9GdGtuZmtxc0pCakx0RW5oTitCdE1uV00yZlZ0TDdWODYv?=
 =?utf-8?B?YnU5WEd1a3FWN3h0ZGRwZXRPQ1djeERBYWM4NXh3cms4N1ZMeHJXNlprMUJH?=
 =?utf-8?B?cjA4djRoLzlIR3JpSWthSFRleGc4UENXaWJnMmJ5Y0ZiWDVjM1p4QmphdzFM?=
 =?utf-8?B?ZUlpSUZrZ29NV2h6NW1nQ0FwS1RtY0tSL2wyWTI0WDhPeUdCaUV1Z3ZpVi96?=
 =?utf-8?B?N0pSL0V0aVFzR09ySy9iTHBWR2xYbllsdXlhSFJwS21mNnMzUVp4ZDhmNkNq?=
 =?utf-8?B?d2ZIUWF6US83VElHaWR4cDYxT3IveHpNL2kxSGRHTGRSY2RKbHB0N1FMNzJm?=
 =?utf-8?B?OFR2U2JiaHlkOElzbFQ1WjAvUUV1cUtrYjh3K1JoWnBMNC92dDFQRGJhdm5Y?=
 =?utf-8?B?QnRpaHVNUTVBcDdOWisyK2QxY2lYZEdzSXVlK2RlSEZlWWJwMHkwd0E1bXlF?=
 =?utf-8?B?cDgrSFVxSExxcTdDZzYwQ2VSNWU4QTlDN3hEcm5zREU0ZHdzUE8ySnpXUTZq?=
 =?utf-8?B?dEMvdWxRK0ZWdFlYcnJBMnduRHRJRkw4RWVnOURkL3VUOXU0cm5Pd0pSNHVn?=
 =?utf-8?B?U2M0alE2alUzQW1MVmRMcWMrUjFyeFlnT0NGcnRoSkVOb2F1YUxKY1I0d1NS?=
 =?utf-8?Q?UOfQdK2qYz7pp?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012)(7416012)(921018)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0JWTzQ1dTEzaHN6UGhzNUlHUFZzMzA5MWx6RlQ3U2NyaVowK0lMZFVxcmZv?=
 =?utf-8?B?eEk1NU9aTnNUNS9iQ3FYeTBUMFZTTGRzdFRvVW0zZGxlWXhOM3BzbXpxUHNG?=
 =?utf-8?B?NDhmbXlTT2puUkRXK3kyRHN3T1A0ZXhSeCtmM3VqNm9sTG9NblpQeW96MjQ5?=
 =?utf-8?B?YnpiQitXb3RnUGlNUmc2Sy9PbU1ITmZDcVp1a3M1RWhvaHJLbllub1FPRzVF?=
 =?utf-8?B?cHhYaXF1OU9xaWhWV2NtSE9ReEM3bDh4bnBrcFd3dUxlQ241UFV4bG1OWGND?=
 =?utf-8?B?U28rVWhFVlRwdUYwNC8yK0pNZEs4REdsVW1GT21SQVNxNDNOSDlsbGN1SzVO?=
 =?utf-8?B?amNDQ2Q5QTVQRk5McEJtU2Y3bWRUeUpFQTZWVk91bi84dlRaRm40SkZFU2tM?=
 =?utf-8?B?ZVcwSGlvOUVyTFE5VGdKcXBEWmR5ZlJhR0JPcTZ4UGJHTys1WUlicjlJQWxk?=
 =?utf-8?B?MnByeWpzRXcybHc1dnhNRGU2QmpoNnlId091M3JxWENTWVB6RHVZcDJFQm1n?=
 =?utf-8?B?SExrNEhtdG5ZL0ZtMEtUN2xBZWRSY3J0VDQ0LzFYdFV5WnVKWXVCT3F3clNq?=
 =?utf-8?B?c1MwbVB1aVRWYlAybWtaY0dCalJUakswVUQ3eHZGaXNHaXNObnpTNlZwNHRM?=
 =?utf-8?B?Q3RiVzlzMC9RajdUVDFPcEh2N1A4Q0FHT3A3OG5yU3lqQlJxdHpaeThURFhu?=
 =?utf-8?B?ZStrcSt3TFkzMWM5bklLbUdpVkQ3eFY3djNDT1M5Wm5YeFJwVDR6SElkK1hH?=
 =?utf-8?B?bHdrdk9LQjZ0VWE4c1NjR0xtN1lBdnExRm9Bcndtci9xU21qTUl4TUNTTStI?=
 =?utf-8?B?akFUd0c3clRaR0hoRkdBVjgvRUhZcFJ6SUEzOGlpMHhlYWt4ZmhCeTlNelh1?=
 =?utf-8?B?N0p0NU00TkRCS1lkV0o4aEVPdVBiNVovV01FUWFWZElJNVY3alhBYlVEUzlH?=
 =?utf-8?B?OGJqQWphdVVJRFBXMmVqS05QNzRiNlBpZmJxUlluTXRXSkk3NjVnNVVmNlV2?=
 =?utf-8?B?UVhyNHlqZ2xKQUoxZ0JoZ01kQnJwS2JSZUh6eFQ4NzgwbU5DcnQ1b1FMcjFa?=
 =?utf-8?B?Zk5PZ293RTc4cWFyOXYya1FhNktXRk5qbEVhcjZLQS9JenNnRDkzVHZQMG9C?=
 =?utf-8?B?dytOUllCT25ZV0M5UHpnM0JVQ0t0UEpKcjA1L1oxZ2h1emprdDJyMVVZemhs?=
 =?utf-8?B?SUczM3JjZW0yRjR4cjNZUUVrQ2xDU0o5YkZ1ZklXUlFoTlJzVnJabURjUXdk?=
 =?utf-8?B?VUNjam9EMW1vZHltSW1FVllWUnBYaVo4SExqeVB0K0tiYkFZWW9aemNLRDd2?=
 =?utf-8?B?Ukp3OWt4YkZGTnF1cDB6YUlUYTlNbzRLSmlMUEc0K1plT1o4UDdwSE9xU3Ev?=
 =?utf-8?B?N1pGVVlFc1BYc2NZSVlueG5UdUxycmhpaWFnSTM2VG5kaDZKYWZlaXhlTktP?=
 =?utf-8?B?Q0dINmxsWUpBTWppZTJjckJqVFBPTkpmdGNnQkdKMnUxQ1h0OVNuUE1HQ3Q1?=
 =?utf-8?B?WUVQdWpYVjYwZytpSTgrNVNJSDFUN0pxZnpvaG9VTXpYSEl0ZXVkN1ZiT29Q?=
 =?utf-8?B?Q294OHNyd0FyRXd1dEg3SmFCaDNnZkkyWU1FN2hDN0Q4b3pNQkgyZitibEIv?=
 =?utf-8?B?aWJ1elNlR0R2cmJWUnVYZTdvQTNNNUNRTXhOekd6cCtwOVB4VFYrTHRSd3Ir?=
 =?utf-8?B?SVdDcU1jUGhMR0lzYWFuY2lPRFVNdEN4MlNkVWhDenJYaGJRUTJWSzRrUVh4?=
 =?utf-8?B?c0M5eDBwWllnT1FodGJBR1p3T2EvSmZIOTJ0dHoxTS9qaFIvRUpwNVQvREN6?=
 =?utf-8?B?Y1hJVUFXQTZQYmcrVnBOWmtqTUh5ei9qWkZyNmlKNWdKM2l1WjU4REMvNStu?=
 =?utf-8?B?dDVQR24yekUrdkZhaGQwVUZXOUZZVjJjRFF5aEF5YWZleWVDd0pFbWpwUFpq?=
 =?utf-8?B?bGQxdWlrRDg0YVFRcll6ZkkzTFZIZmJkbjdEUXY0eXNqY0xPbkxWdXZBWVp2?=
 =?utf-8?B?TDdhalE4dS9nUU1jUE1kb2J4aVhyc3R2WmNWQjl1ZHgxZURNYmtCK2lhUDRY?=
 =?utf-8?B?ZngrbWVibGo5VFdGUXdDbWdTWHg5T2pQN3g0Z2tJemR4ekJ0dW5tSUtLanJC?=
 =?utf-8?B?Q0QvdW9ZQXBmNGh2TDVSeWlieitZOHpQQytwR0hGOTlYT1Z3NHV2UFpIT3BG?=
 =?utf-8?B?QW1ieXlBUDlMblUzaUt3cFc3SGExc21LSjBnSDNybGJBNm1IdjlPM0VOSzV4?=
 =?utf-8?B?MXBwZ2FwczFUbmNKVTA3TXkvdk53PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BCBBB353E5F1C4EB92A58C5DE009957@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023d0c4e-581b-4a6a-9d39-08dc95ea4f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 14:14:36.8603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: maZRcci3uAvTjG4t+E2sT6g7mfy34bBjQhymMI8O37ZIgWZjKLXmodqfN5mX0LQNdbtpS8k+eiG2GFdjbcDtiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8507
X-OriginatorOrg: intel.com

PiAgRm9yIHVzZSBjYXNlcyBzdWNoIGFzIHRoZSBwZXItY29yZSBSQVBMIFBNVSwKPiB0aGVyZSBl
eGlzdHMgYSBuZWVkIGZvciBhIHVuaXF1ZSBjb3JlIElEIGFjcm9zcyB0aGUgZW50aXJlIHN5c3Rl
bQo+IHdpdGgKPiBtdWx0aXBsZSBQS0cgZG9tYWlucy4KCkFncmVlZC4gQW5kIHRoZXJlIGFyZSBv
dGhlciBjYXNlcyB0aGF0IGEgc3lzdGVtIHVuaXF1ZSBjb3JlIElEIGlzCm5lZWRlZCwgbGlrZSBp
biBkcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmMsIHdoZXJlIHBlci1jb3JlIHRlbXBlcmF0dXJlCmlu
Zm8gaXMgc2F2ZWQgaW4gYW4gYXJyYXkuCgo+ICBJbnRyb2R1Y2UgdG9wb2xvZ3lfbG9naWNhbF9j
b3JlX2lkKCkgdG8gZGVyaXZlIGEKPiB1bmlxdWUgY29yZSBJRCBhY3Jvc3MgdGhlIHN5c3RlbS4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBLIFByYXRlZWsgTmF5YWsgPGtwcmF0ZWVrLm5heWFrQGFtZC5j
b20+Cj4gU2lnbmVkLW9mZi1ieTogRGhhbmFuamF5IFVnd2VrYXIgPERoYW5hbmpheS5VZ3dla2Fy
QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPgoK
dGhhbmtzLApydWkKCj4gLS0tCj4gwqBEb2N1bWVudGF0aW9uL2FyY2gveDg2L3RvcG9sb2d5LnJz
dMKgwqAgfCA0ICsrKysKPiDCoGFyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5owqDCoMKg
wqDCoCB8IDEgKwo+IMKgYXJjaC94ODYvaW5jbHVkZS9hc20vdG9wb2xvZ3kuaMKgwqDCoMKgwqDC
oCB8IDEgKwo+IMKgYXJjaC94ODYva2VybmVsL2NwdS9kZWJ1Z2ZzLmPCoMKgwqDCoMKgwqDCoMKg
IHwgMSArCj4gwqBhcmNoL3g4Ni9rZXJuZWwvY3B1L3RvcG9sb2d5X2NvbW1vbi5jIHwgMSArCj4g
wqA1IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2FyY2gveDg2L3RvcG9sb2d5LnJzdAo+IGIvRG9jdW1lbnRhdGlvbi9hcmNoL3g4
Ni90b3BvbG9neS5yc3QKPiBpbmRleCA3MzUyYWI4OWE1NWEuLmMxMjgzN2U2MWJkYSAxMDA2NDQK
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FyY2gveDg2L3RvcG9sb2d5LnJzdAo+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vYXJjaC94ODYvdG9wb2xvZ3kucnN0Cj4gQEAgLTEzNSw2ICsxMzUsMTAgQEAgVGhy
ZWFkLXJlbGF0ZWQgdG9wb2xvZ3kgaW5mb3JtYXRpb24gaW4gdGhlCj4ga2VybmVsOgo+IMKgwqDC
oMKgIFRoZSBJRCBvZiB0aGUgY29yZSB0byB3aGljaCBhIHRocmVhZCBiZWxvbmdzLiBJdCBpcyBh
bHNvIHByaW50ZWQKPiBpbiAvcHJvYy9jcHVpbmZvCj4gwqDCoMKgwqAgImNvcmVfaWQuIgo+IMKg
Cj4gK8KgIC0gdG9wb2xvZ3lfbG9naWNhbF9jb3JlX2lkKCk7Cj4gKwo+ICvCoMKgwqAgVGhlIGxv
Z2ljYWwgY29yZSBJRCB0byB3aGljaCBhIHRocmVhZCBiZWxvbmdzLgo+ICsKPiDCoAo+IMKgCj4g
wqBTeXN0ZW0gdG9wb2xvZ3kgZXhhbXBsZXMKPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVk
ZS9hc20vcHJvY2Vzc29yLmgKPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oCj4g
aW5kZXggNGZkMzM2NGRiYzczLi5lMWVlYjQyZWRlYWYgMTAwNjQ0Cj4gLS0tIGEvYXJjaC94ODYv
aW5jbHVkZS9hc20vcHJvY2Vzc29yLmgKPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9j
ZXNzb3IuaAo+IEBAIC05OCw2ICs5OCw3IEBAIHN0cnVjdCBjcHVpbmZvX3RvcG9sb2d5IHsKPiDC
oMKgwqDCoMKgwqDCoMKgLy8gTG9naWNhbCBJRCBtYXBwaW5ncwo+IMKgwqDCoMKgwqDCoMKgwqB1
MzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsb2dpY2FsX3BrZ19p
ZDsKPiDCoMKgwqDCoMKgwqDCoMKgdTMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgbG9naWNhbF9kaWVfaWQ7Cj4gK8KgwqDCoMKgwqDCoMKgdTMywqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbG9naWNhbF9jb3JlX2lkOwo+IMKgCj4gwqDC
oMKgwqDCoMKgwqDCoC8vIEFNRCBOb2RlIElEIGFuZCBOb2RlcyBwZXIgUGFja2FnZSBpbmZvCj4g
wqDCoMKgwqDCoMKgwqDCoHUzMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGFtZF9ub2RlX2lkOwo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90b3Bv
bG9neS5oCj4gYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90b3BvbG9neS5oCj4gaW5kZXggYWJlM2E4
ZjIyY2JkLi4yYTZkYmY5NjVkOTIgMTAwNjQ0Cj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20v
dG9wb2xvZ3kuaAo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RvcG9sb2d5LmgKPiBAQCAt
MTM3LDYgKzEzNyw3IEBAIGV4dGVybiBjb25zdCBzdHJ1Y3QgY3B1bWFzawo+ICpjcHVfY2x1c3Rl
cmdyb3VwX21hc2soaW50IGNwdSk7Cj4gwqAjZGVmaW5lCj4gdG9wb2xvZ3lfbG9naWNhbF9wYWNr
YWdlX2lkKGNwdSnCoMKgwqDCoMKgwqDCoChjcHVfZGF0YShjcHUpLnRvcG8ubG9naWNhbF9wawo+
IGdfaWQpCj4gwqAjZGVmaW5lCj4gdG9wb2xvZ3lfcGh5c2ljYWxfcGFja2FnZV9pZChjcHUpwqDC
oMKgwqDCoMKgKGNwdV9kYXRhKGNwdSkudG9wby5wa2dfaWQpCj4gwqAjZGVmaW5lCj4gdG9wb2xv
Z3lfbG9naWNhbF9kaWVfaWQoY3B1KcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoY3B1X2RhdGEoY3B1
KS50b3BvLmxvZ2ljYWxfZGkKPiBlX2lkKQo+ICsjZGVmaW5lCj4gdG9wb2xvZ3lfbG9naWNhbF9j
b3JlX2lkKGNwdSnCoMKgwqDCoMKgwqDCoMKgwqDCoChjcHVfZGF0YShjcHUpLnRvcG8ubG9naWNh
bF9jbwo+IHJlX2lkKQo+IMKgI2RlZmluZQo+IHRvcG9sb2d5X2RpZV9pZChjcHUpwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoY3B1X2RhdGEoY3B1KS50b3BvLmRpZV9pZCkK
PiDCoCNkZWZpbmUKPiB0b3BvbG9neV9jb3JlX2lkKGNwdSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAoY3B1X2RhdGEoY3B1KS50b3BvLmNvcmVfaWQpCj4gwqAjZGVmaW5lIHRv
cG9sb2d5X3BwaW4oY3B1KcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oChjcHVfZGF0YShjcHUpLnBwaW4pCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUv
ZGVidWdmcy5jCj4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2RlYnVnZnMuYwo+IGluZGV4IDNiYWYz
ZTQzNTgzNC4uYjFlYjZkNzgyOGRiIDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUv
ZGVidWdmcy5jCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9kZWJ1Z2ZzLmMKPiBAQCAtMjQs
NiArMjQsNyBAQCBzdGF0aWMgaW50IGNwdV9kZWJ1Z19zaG93KHN0cnVjdCBzZXFfZmlsZSAqbSwg
dm9pZAo+ICpwKQo+IMKgwqDCoMKgwqDCoMKgwqBzZXFfcHJpbnRmKG0sICJjb3JlX2lkOsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAldVxuIiwgYy0+dG9wby5jb3JlX2lkKTsKPiDCoMKgwqDCoMKg
wqDCoMKgc2VxX3ByaW50ZihtLCAibG9naWNhbF9wa2dfaWQ6wqDCoMKgwqDCoCAldVxuIiwgYy0K
PiA+dG9wby5sb2dpY2FsX3BrZ19pZCk7Cj4gwqDCoMKgwqDCoMKgwqDCoHNlcV9wcmludGYobSwg
ImxvZ2ljYWxfZGllX2lkOsKgwqDCoMKgwqAgJXVcbiIsIGMtCj4gPnRvcG8ubG9naWNhbF9kaWVf
aWQpOwo+ICvCoMKgwqDCoMKgwqDCoHNlcV9wcmludGYobSwgImxvZ2ljYWxfY29yZV9pZDrCoMKg
wqDCoCAldVxuIiwgYy0KPiA+dG9wby5sb2dpY2FsX2NvcmVfaWQpOwo+IMKgwqDCoMKgwqDCoMKg
wqBzZXFfcHJpbnRmKG0sICJsbGNfaWQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJXVcbiIs
IGMtPnRvcG8ubGxjX2lkKTsKPiDCoMKgwqDCoMKgwqDCoMKgc2VxX3ByaW50ZihtLCAibDJjX2lk
OsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICV1XG4iLCBjLT50b3BvLmwyY19pZCk7Cj4gwqDC
oMKgwqDCoMKgwqDCoHNlcV9wcmludGYobSwgImFtZF9ub2RlX2lkOsKgwqDCoMKgwqDCoMKgwqAg
JXVcbiIsIGMtCj4gPnRvcG8uYW1kX25vZGVfaWQpOwo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L3RvcG9sb2d5X2NvbW1vbi5jCj4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3RvcG9s
b2d5X2NvbW1vbi5jCj4gaW5kZXggOWE2MDY5ZTcxMzNjLi4yMzcyMmFhMjFlMmYgMTAwNjQ0Cj4g
LS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS90b3BvbG9neV9jb21tb24uYwo+ICsrKyBiL2FyY2gv
eDg2L2tlcm5lbC9jcHUvdG9wb2xvZ3lfY29tbW9uLmMKPiBAQCAtMTUxLDYgKzE1MSw3IEBAIHN0
YXRpYyB2b2lkIHRvcG9fc2V0X2lkcyhzdHJ1Y3QgdG9wb19zY2FuICp0c2NhbiwKPiBib29sIGVh
cmx5KQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIWVhcmx5KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBjLT50b3BvLmxvZ2ljYWxfcGtnX2lkID0KPiB0b3BvbG9neV9nZXRfbG9n
aWNhbF9pZChhcGljaWQsIFRPUE9fUEtHX0RPTUFJTik7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBjLT50b3BvLmxvZ2ljYWxfZGllX2lkID0KPiB0b3BvbG9neV9nZXRfbG9naWNh
bF9pZChhcGljaWQsIFRPUE9fRElFX0RPTUFJTik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGMtPnRvcG8ubG9naWNhbF9jb3JlX2lkID0KPiB0b3BvbG9neV9nZXRfbG9naWNhbF9p
ZChhcGljaWQsIFRPUE9fQ09SRV9ET01BSU4pOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiDC
oMKgwqDCoMKgwqDCoMKgLyogUGFja2FnZSByZWxhdGl2ZSBjb3JlIElEICovCgo=

