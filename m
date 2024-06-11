Return-Path: <linux-pm+bounces-8914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 976A4903689
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 174DDB2546D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABED517332A;
	Tue, 11 Jun 2024 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJX9xH5T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013047772;
	Tue, 11 Jun 2024 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094643; cv=fail; b=J7cEzKAVzgeC3B41jXO4KR+uLkfoKodR6ufIW+unzHtXf1Ic/Eu2T7hozHGoNysX1NlFrZeUU4NAQ3AbxwI45WGoPS/+y8jCoIeekoZ8K/XjVlwbjoxaYS6gAbKt07zuX+bcztuLPEOb58n9W2pteG4SL28zID2U2k6+899IXKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094643; c=relaxed/simple;
	bh=9z9a+vduSWrBN288DFS8yUaWRy50t4F2/Oras33+sjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oBlSPDaF+UH8nXRCdstvsT4GZIviUWnwEZKfAPrmuqD1GwySRThCzzbcZBjNh1HqbDFa8YhhjQ7dkBywnViXZ0HFykP6OQPTKedJMoiVrn9+exmuX6JONWaTABp92DmYMlXc7JpcticAf34Yr3Uq2FSpJfj6lZKkvcZGINbXl1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJX9xH5T; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718094641; x=1749630641;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9z9a+vduSWrBN288DFS8yUaWRy50t4F2/Oras33+sjY=;
  b=RJX9xH5TqDsNPmHTRtHdF7PXJ5bsscz66PIRNWXoY1KvAoXTiNyhBipP
   G53cheLe09wtL93KCakDllV8rF8DFeZ/TLDkfCFkf+agIifGggxpjnwxf
   +ZISLtLp6FU7fkNtIeDwBUJfXZpByACUon5wigzrSpeQZ+aHvRlFQSrWh
   W799Gx7wLe88DdC3qmdNKX6TG3smVrqKZO/k+gpHqhoBxTYayYxCuv+TV
   E+6+E+VNajWrOXp3thF4+IEFimTThUxIJZvqvoRYVsIoX4svDzUtoRzwu
   18GGRHWX3UhtODamk5SbJhHKpnWAha7528CcBHlZkDMq64NDnWn4IR2M/
   Q==;
X-CSE-ConnectionGUID: YlM1BMorSsCowg0Npd07xQ==
X-CSE-MsgGUID: 1drv/Bx6R2y56ADiEP+5sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14620211"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14620211"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 01:30:06 -0700
X-CSE-ConnectionGUID: PLF/W63ASz2lFhYaCmxWjQ==
X-CSE-MsgGUID: O9YG/4/jSKi1YHJ6JDRFnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="43919530"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 01:30:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 01:30:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 01:30:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 01:30:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRoir3kJhM5haia5plZZdgAy5w3h/k8KpWQ6LI4ooc5fNKCr78LDSxHhl4jQMotz9l0bRjr13G0caRRQJ6gq01yKqESIfYPCXJAzQdJarFk9xSCLJOP3LihgXrpQl9ZDXwmgVUAPArMSmE91g368jrGPy1Z7tKLDsSsdM+OsRS448b4QMPL96GmNtplzM4TZJ3+nCSWNz4UqC3ez4aeMDyVzZfukfASJn+snReddSncBjjKmkAF68nDNbsoK+rjPdoynkZgy86sUGHfZC+ilWt8+Wb/veiPjqAHwQ+ls3VgOgAiEZb7/qPzSCdEn7qnBeve9WcB9dDjlYuFVdBEz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z9a+vduSWrBN288DFS8yUaWRy50t4F2/Oras33+sjY=;
 b=aOmDEFDaoqnR8A8Dq399e0MJJC210ogQxNnssR0VQ1veM8uWvksQowmtF01gNjmQPalfjmllMMis8r0IOXv5HrstHVRCAmb9oRzcvCIW5VoEffB0f0YHphBXe4d7Agyk5xUx8Egcc+hlRavWSF3UWiciIrCJ4bADBPZ4LayO2WK/BSLs+257aA7V5/jlS3pOkPK8ZZXvlBfPSIjqbzjh+rCO+QWDCs6rrsrXooZs3nYUfJJuz8V1np2alBSrlzRSZ+PYotEUT527Fb94y3K6E4Sgv7NpXIpyK3SAiYYiCC2Y6mG99OkujculHismpJR+fwncBATQQonpGbBk8c0i1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW4PR11MB5891.namprd11.prod.outlook.com (2603:10b6:303:169::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:30:03 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 08:30:03 +0000
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
	<acme@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
CC: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "ananth.narayan@amd.com"
	<ananth.narayan@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH 6/6] perf/x86/rapl: Add per-core energy counter support
 for AMD CPUs
Thread-Topic: [PATCH 6/6] perf/x86/rapl: Add per-core energy counter support
 for AMD CPUs
Thread-Index: AQHaux6GVDymRc0x20igDx23yXMxKbHCPN4A
Date: Tue, 11 Jun 2024 08:30:03 +0000
Message-ID: <d7f1d65c7e8872dee2a97ee47be191496d048d1d.camel@intel.com>
References: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
	 <20240610100751.4855-7-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240610100751.4855-7-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW4PR11MB5891:EE_
x-ms-office365-filtering-correlation-id: 320d2067-0506-4fc3-8829-08dc89f0b134
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UGx1Q2NBUmc0c0RNSHBLNFpRbDZFWVMvaFdPSXVTaWRnS3BqbFpRTktVaWhB?=
 =?utf-8?B?VzhRMnM1UldnSVl1U3RaMHNUUEMwVjR4NDlxeWlzQXlpN2laWkVtUVoyUEQ3?=
 =?utf-8?B?S2Z4V291K2x6OHhxK3JqMU5kbm1KbWlUNVZLZVR1Z20wdmcvWmMyWnNZV01K?=
 =?utf-8?B?a2RId3NRb3VZNGs5aTh2OVlkM3J3TXRySyt4aTgrc0IxbEMwVWJXTTdQN2d3?=
 =?utf-8?B?T2RYTTVsMG9lWlYrZTkrTEhIQ2JNc2krSXpOUmdpcDNZYlpQMFBKTlhHOC9x?=
 =?utf-8?B?cVNrT1lCWjl1a3FYaTVsVlA1RU1CcVpjTGJWS3VOMUkxTjk4VmRhdkZDSWZp?=
 =?utf-8?B?c0NsV0xBdW1UMFc0SXhtVVo3WXRZUXZ0SU1ZeVJHOXNMZDJ2Y3M3NFFibGRX?=
 =?utf-8?B?TEJLbTBoRE9UOFVZTlVHaUlHUGg0NlRidnRhTnZzeis1NWpjK1B5djRoRStj?=
 =?utf-8?B?T09TdnovbjBqWmlmRngxN0R0czRjcm01RXlSRUJkcDJvLzJ5K0NReWJyeGg5?=
 =?utf-8?B?SWcxamxKUEhQV3gyYUxmQVh3dng4Vm1DN1RRejg2ZUFiRHZreFJUMFQwZXU4?=
 =?utf-8?B?WFBSNjRkbDVJU2hqbExLZTZMUEhkbXV6T2tXSTBYRHBaSGtLbTdLV2lZVVFC?=
 =?utf-8?B?eEgrblRpQjAxZ3FEVnlUSHA1S00wNFhVRitNTEVxQ3dXNjg3OE9XNUVUSkxX?=
 =?utf-8?B?OEZRd2RML0Y3eW5MMVNtUmlscjdXTFN6eWJONWx3U3o2Z0E5NU9EUHdTNVp4?=
 =?utf-8?B?MjIvV3A2RTVScmRpRUxsS3M4azZ0Sk5DQ3JNcm9Yem5VUE80MkcwVWRSUmhF?=
 =?utf-8?B?dUVaUGpON0IzNFgxYllpTzREamhhdmI0a1kxTWJtZ1VMZjVjMzBsa3U3dVZP?=
 =?utf-8?B?dXNtTVlFZmkxNC9BVk1rQjJSWHpReTBlNitLZWVlQ09hTDgyTXpESGlxL1FW?=
 =?utf-8?B?cTZVbm4ydmhIOEZVRE4xQkRPVDBhaVZzQUtHbmpyTTBETWxUVEpCTUtuVG5H?=
 =?utf-8?B?RHZSZlhBZ08zNVM1WUZBZ0Y5a3RCWHF5cHJJSnJFQklHRFMzbWYzVGlmTjFD?=
 =?utf-8?B?YzdhK1ZiWDJjTUZTdFU1ZFJZeVcrWDNvOXh5VjZTd1lXL1VkS1ZDM2g4RmRJ?=
 =?utf-8?B?SlpVbXJCUTdmbXlWTXp3MVR4OXhDQkVpclV1elgrcG1NUW5UKzZEeUt5dThz?=
 =?utf-8?B?WmtUWUxLVVJpMCtrSzBXU1hzVU1naG54WW5xYzA5cGhweG9UWXNvcVB6MWNU?=
 =?utf-8?B?UGcyRnVLVy9Wd1hOaFpQMHgwWjBEYklUZVh0ODFIMUpNZ2RPczVReWVMQ0I4?=
 =?utf-8?B?cWhYNG9xTDByenB0MU5lR3R6TktkVG9lOVdFSnJ5MW1hdGdxTjQ0S0hGT1d6?=
 =?utf-8?B?Y2plelFJdnlyelBxNk9NWVlVMzZhaHZFNUp2VFhZQ29sMVpQUkNhUnNWZVdC?=
 =?utf-8?B?YUxaNm9KL2dMc3A0blBtNG82Nm9JZWhwUlZpTldIWlNEQWJHQlllNjVUZjcy?=
 =?utf-8?B?bjVvNnRKNTRkbFhYVkxaNkxYMllrbjY0VmFlYmNnT0owZzNrcjdHamtYS2la?=
 =?utf-8?B?eis5SXBYZWdqbWltRUZrU3VVWlMxbjNXVExMOXNBY1czNlUrdW5GVzl1MVBm?=
 =?utf-8?B?anlwRy9DaEpGM3BtSkFxVXZqY09jcEJrSjB1dUtGTzJvRlN6S0Zhb25rYWRB?=
 =?utf-8?B?RW5VN0M5MWtHUjJ6d09ZNm80NTBqVGhjRTN6QTJlTzExcnVJQkNqd002ZmpL?=
 =?utf-8?B?bzVwNWtZZGNtNHUwNm9ENXlaeFBIZFBabndBYndTUXdYMld0YzVkc2VyU3Rr?=
 =?utf-8?B?QzdnN2R5bVdYNFVoOUNhRzJnbUEzOVVrTjEvUDdkTFltZVFGaDJRdVBocy9k?=
 =?utf-8?Q?87pp6923BsA9i?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW10TWhDM2UzUGwrcnpSdTdRamd6b3VOV3RWQzZHM29NdEdGa2dvY3FBd1Fi?=
 =?utf-8?B?ZC9QdVBhc093MXE0NzgvY3hKSlJuc0ptV1dXV1FacExmMVA3WTFuSHA0dkFM?=
 =?utf-8?B?azM2YVk3dWtvMVVkcDA0UVcvVHVTZ0FCbmNHczFMSlpNand2ejJ4bHNpYStt?=
 =?utf-8?B?VDZvTWRGQ0p6MlhKSFBsTVR5WStRVEp6SEhucDBQVStXYXlwdHFsNUlxMjUx?=
 =?utf-8?B?cktLQzhOd0xFZDY1RTBXUTdTWGZ0K1JxaTN6WGZzK2x6NzV0K0NITlp3ZUxv?=
 =?utf-8?B?RnFIby9nNldiZVdNbnlaekNDUUN0VnhWMXdyc2JuZGRkaThkL0tpeisySy9Z?=
 =?utf-8?B?YlJ0WURnYnBNK2dTd1Q3bTNIL2ZiSFVYY1g0VHNaaUNwbFVtaG9wOTArcHRZ?=
 =?utf-8?B?bTNaSm9wVmdYaUpBYkFZMWE3WHE3dXZ4bmVmUFNCZHNSdyt0dTdUckluYlhG?=
 =?utf-8?B?Si9FR0xZUXd5M0JPWGdyZXV1K1RhUXpod1FxRno4dU85SnhNSmpBSGJxWkx2?=
 =?utf-8?B?U1NuWkE3dUtabEJaVmhmeTdzOVN3TVFqRmpvL20zUWRsOFRsYlFvemNXenM4?=
 =?utf-8?B?MlcwNVAyd2pmWENTbzdIM1JGYU15eDJJZWM2ZkszZ29SaHdTVlZ6b0h6Z3h6?=
 =?utf-8?B?SE5yd1NLWWhrcllScUYraHZyNUIxNXFobm9YMkhHbklRMUN0MUxDWEJGSmV2?=
 =?utf-8?B?eTNEZXNkbWZZbVpSeTZMNGMzd1U0L1lYRHZOa1p6S2J1K0xtemkrUnFWWWF1?=
 =?utf-8?B?aDhTd1hYQ2tRT1haTW1zUnRJTnZLd3FsR1p1RzlMbThRY2RwNlNhZEIzVlNN?=
 =?utf-8?B?UWxMYzBidjJOU2lLSk9lVnA0Q3FBQmhxWWJMNGNtRnVnd0kwM21FZEhFa1Vz?=
 =?utf-8?B?VkRFVkorRGFwQVF2ZU00anRyS1VKSWhPdUFIWGFhVHk2eXBTRjRXVHFKL25o?=
 =?utf-8?B?NE5wMHdyMjNsdG0rUi9UU0dqcG8xbWM0OXpVQThVc3ZQMFVrWmlBakVKTnFT?=
 =?utf-8?B?OE9scktsQnhIUXUxNFo2c3RHWWxseXFtM2dHRnZTNllKTEg4c2NpL3N3TURL?=
 =?utf-8?B?a0JKcXFkYmQ1YUdkY2hrVmJHTDVYSGg0VWxDOFhITlFIZjMvUUZiWVZTN29I?=
 =?utf-8?B?Wk5uZXliayt4cDNJUEptY2J4TVVnSExzUnVuanlCQis0STdaZlpjQ3hVQW9l?=
 =?utf-8?B?Z045dzRheUFnbFdwMUJsYytGUHdjcVZWWDluUEhpNkpTNGw3TDBKOTJINjl5?=
 =?utf-8?B?Q3pXTGRFMXBvc2NqUXV0Z0VFZmttYW9jN1l5VHdBMDhBUVlocllLYnFKOFVo?=
 =?utf-8?B?K1l6RXBQckoreldsVmZraVFEN3c5ODFBY1QybDM2d1BvWnNHblBMU1p1cW5B?=
 =?utf-8?B?TzhqeVpmSDV6dlNqWFR4cWJQZ1FnbVExZlNHMFAyN2FuZXhZS0RVelh3L3My?=
 =?utf-8?B?UVNqMW44dlFvTkgrK09YMEJ6bE40VnFrT2ExVDRIVlJhaXVuZ1RtUGVCOFRJ?=
 =?utf-8?B?YzlUMlgxZ3VlaTdBeTRUTzZJZ1REVWx2dUtQUFBScmg5dUpvNkt1Vm0rdzQ4?=
 =?utf-8?B?MlhEQ09hWTlRZ1NtZ1VtVjE0aFNTSnhQMndVWHhLSmZOcGJTeEJMeW1tTkc4?=
 =?utf-8?B?ZDhKRkZrcHVJMW43c05mQVhZUGxvYU81TVpvZEJDWlRXOGxpVnJ2N2hPVjZF?=
 =?utf-8?B?WFoxVFpBNnlnUUFINTBzWGtiejB5QmlxYldzaUVqcE5vODluVHVySVBTY1k5?=
 =?utf-8?B?Zi8wYW85R1lVOFJuQmZwNFAyaXI0ZXQ1a3hUaTcwSmcvQVJRNXVxR3dudnht?=
 =?utf-8?B?ckQ5WDBEYUk1QWx6VUcrUzZYRjNKQnlHUnV5T1BoZVhCWlN6RWMzYldxY1d6?=
 =?utf-8?B?dk5XMkZHWVpKcytUNWYyRlVsWk0rbjhJeVdMWkxnaEx5NUxpb29qaWMwRWtV?=
 =?utf-8?B?REU1dHRITnp1VkVNUWw4aTZncVo1eGpMZVpNQTlmZ1FIYk8vckNVUXh4M0o3?=
 =?utf-8?B?cUd4RW9NZWt6SU0vSTQzd1RGRStFbG5DVHNTdmlsVWZVZUF2akpKai9MVTlF?=
 =?utf-8?B?dlpsWVYrQ29VN2dhQm5JNnZPY1huYTBvV2tWMytxVldiSnE5T3dGb2tRWnV0?=
 =?utf-8?Q?oTIWAG6jZLv+2cy8xMOMoP28/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF0E92AE8CAE0449BB4E28812EEFAE24@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320d2067-0506-4fc3-8829-08dc89f0b134
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 08:30:03.7827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +F9YrHdgy0NpZ93jIGAvK3TBB6vWDONlkg0LPfUYCAsZQcQzRF2Auydf+XLC7VxBVg/uLxa2/1+HT6aqiFEjIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5891
X-OriginatorOrg: intel.com

PiBAQCAtMzQ1LDkgKzM1MywxNCBAQCBzdGF0aWMgaW50IHJhcGxfcG11X2V2ZW50X2luaXQoc3Ry
dWN0IHBlcmZfZXZlbnQKPiAqZXZlbnQpCj4gwqDCoMKgwqDCoMKgwqDCoHU2NCBjZmcgPSBldmVu
dC0+YXR0ci5jb25maWcgJiBSQVBMX0VWRU5UX01BU0s7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBi
aXQsIHJldCA9IDA7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCByYXBsX3BtdSAqcmFwbF9wbXU7
Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHJhcGxfcG11cyAqY3Vycl9yYXBsX3BtdXM7Cj4gwqAK
PiDCoMKgwqDCoMKgwqDCoMKgLyogb25seSBsb29rIGF0IFJBUEwgZXZlbnRzICovCj4gLcKgwqDC
oMKgwqDCoMKgaWYgKGV2ZW50LT5hdHRyLnR5cGUgIT0gcmFwbF9wbXVzLT5wbXUudHlwZSkKPiAr
wqDCoMKgwqDCoMKgwqBpZiAoZXZlbnQtPmF0dHIudHlwZSA9PSByYXBsX3BtdXMtPnBtdS50eXBl
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjdXJyX3JhcGxfcG11cyA9IHJhcGxf
cG11czsKPiArwqDCoMKgwqDCoMKgwqBlbHNlIGlmIChyYXBsX3BtdXNfcGVyX2NvcmUgJiYgZXZl
bnQtPmF0dHIudHlwZSA9PQo+IHJhcGxfcG11c19wZXJfY29yZS0+cG11LnR5cGUpCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGN1cnJfcmFwbF9wbXVzID0gcmFwbF9wbXVzX3Blcl9j
b3JlOwo+ICvCoMKgwqDCoMKgwqDCoGVsc2UKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiAtRU5PRU5UOwoKY2FuIHdlIHVzZSBjb250YWluZXJfb2YoZXZlbnQtPnBtdSwg
c3RydWN0IHJhcGxfcG11cywgcG11KT8KCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgLyogY2hlY2sg
b25seSBzdXBwb3J0ZWQgYml0cyBhcmUgc2V0ICovCj4gQEAgLTM3NCw5ICszODcsMTQgQEAgc3Rh
dGljIGludCByYXBsX3BtdV9ldmVudF9pbml0KHN0cnVjdCBwZXJmX2V2ZW50Cj4gKmV2ZW50KQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gwqAKPiDC
oMKgwqDCoMKgwqDCoMKgLyogbXVzdCBiZSBkb25lIGJlZm9yZSB2YWxpZGF0ZV9ncm91cCAqLwo+
IC3CoMKgwqDCoMKgwqDCoHJhcGxfcG11ID0gY3B1X3RvX3JhcGxfcG11KGV2ZW50LT5jcHUpOwo+
ICvCoMKgwqDCoMKgwqDCoGlmIChjdXJyX3JhcGxfcG11cyA9PSByYXBsX3BtdXNfcGVyX2NvcmUp
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhcGxfcG11ID0gY3Vycl9yYXBsX3Bt
dXMtCj4gPnJhcGxfcG11W3RvcG9sb2d5X2NvcmVfaWQoZXZlbnQtPmNwdSldOwo+ICvCoMKgwqDC
oMKgwqDCoGVsc2UKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmFwbF9wbXUgPSBj
dXJyX3JhcGxfcG11cy0KPiA+cmFwbF9wbXVbZ2V0X3JhcGxfcG11X2lkeChldmVudC0+Y3B1KV07
Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXJhcGxfcG11KQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7CgpDdXJyZW50IGNvZGUgaGFzIFBFUkZfRVZf
Q0FQX1JFQURfQUNUSVZFX1BLRyBmbGFnIHNldC4KQ2FuIHlvdSBoZWxwIG1lIHVuZGVyc3RhbmQg
d2h5IGl0IGRvZXMgbm90IGFmZmVjdCB0aGUgbmV3IHBlci1jb3JlIHBtdT8KCj4gKwo+IMKgwqDC
oMKgwqDCoMKgwqBldmVudC0+Y3B1ID0gcmFwbF9wbXUtPmNwdTsKPiDCoMKgwqDCoMKgwqDCoMKg
ZXZlbnQtPnBtdV9wcml2YXRlID0gcmFwbF9wbXU7Cj4gwqDCoMKgwqDCoMKgwqDCoGV2ZW50LT5o
dy5ldmVudF9iYXNlID0gcmFwbF9tc3JzW2JpdF0ubXNyOwo+IEBAIC00MDgsMTcgKzQyNiwzOCBA
QCBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZV9ncm91cAo+IHJhcGxfcG11X2F0dHJfZ3JvdXAgPSB7
Cj4gwqDCoMKgwqDCoMKgwqDCoC5hdHRycyA9IHJhcGxfcG11X2F0dHJzLAo+IMKgfTsKPiDCoAo+
ICtzdGF0aWMgc3NpemVfdCByYXBsX2dldF9hdHRyX3Blcl9jb3JlX2NwdW1hc2soc3RydWN0IGRl
dmljZSAqZGV2LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNl
X2F0dHJpYnV0ZQo+ICphdHRyLCBjaGFyICpidWYpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqByZXR1
cm4gY3B1bWFwX3ByaW50X3RvX3BhZ2VidWYodHJ1ZSwgYnVmLAo+ICZyYXBsX3BtdXNfcGVyX2Nv
cmUtPmNwdW1hc2spOwo+ICt9Cj4gKwo+ICtzdGF0aWMgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUg
ZGV2X2F0dHJfcGVyX2NvcmVfY3B1bWFzayA9Cj4gX19BVFRSKGNwdW1hc2ssIDA0NDQsCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoAo+IHJhcGxfZ2V0X2F0dHJfcGVyX2NvcmVfY3B1bWFzaywKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgCj4gTlVMTCk7CgpERVZJQ0VfQVRUUgoKPiArCj4gK3N0YXRpYyBzdHJ1Y3QgYXR0cmlidXRl
ICpyYXBsX3BtdV9wZXJfY29yZV9hdHRyc1tdID0gewo+ICvCoMKgwqDCoMKgwqDCoCZkZXZfYXR0
cl9wZXJfY29yZV9jcHVtYXNrLmF0dHIsCj4gK8KgwqDCoMKgwqDCoMKgTlVMTCwKPiArfTsKPiAr
Cj4gK3N0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIHJhcGxfcG11X3Blcl9jb3JlX2F0dHJf
Z3JvdXAgPSB7Cj4gK8KgwqDCoMKgwqDCoMKgLmF0dHJzID0gcmFwbF9wbXVfcGVyX2NvcmVfYXR0
cnMsCj4gK307Cj4gKwo+IMKgUkFQTF9FVkVOVF9BVFRSX1NUUihlbmVyZ3ktY29yZXMsIHJhcGxf
Y29yZXMsICJldmVudD0weDAxIik7Cj4gwqBSQVBMX0VWRU5UX0FUVFJfU1RSKGVuZXJneS1wa2fC
oCAswqDCoCByYXBsX3BrZywgImV2ZW50PTB4MDIiKTsKPiDCoFJBUExfRVZFTlRfQVRUUl9TVFIo
ZW5lcmd5LXJhbcKgICzCoMKgIHJhcGxfcmFtLCAiZXZlbnQ9MHgwMyIpOwo+IMKgUkFQTF9FVkVO
VF9BVFRSX1NUUihlbmVyZ3ktZ3B1wqAgLMKgwqAgcmFwbF9ncHUsICJldmVudD0weDA0Iik7Cj4g
wqBSQVBMX0VWRU5UX0FUVFJfU1RSKGVuZXJneS1wc3lzLMKgwqAgcmFwbF9wc3lzLCAiZXZlbnQ9
MHgwNSIpOwo+ICtSQVBMX0VWRU5UX0FUVFJfU1RSKGVuZXJneS1wZXItY29yZSzCoMKgIHJhcGxf
cGVyX2NvcmUsICJldmVudD0weDA2Iik7CgplbmVyZ3ktcGVyLWNvcmUgaXMgZm9yIGEgc2VwYXJh
dGUgcG11LCBzbyB0aGUgZXZlbnQgaWQgZG9lcyBub3QgbmVlZCB0bwpiZSA2LiBUaGUgc2FtZSBh
cHBsaWVzIHRvIFBFUkZfUkFQTF9QRVJDT1JFLgoKPiDCoAo+IMKgc3RhdGljIHN0cnVjdCByYXBs
X21vZGVsIG1vZGVsX2FtZF9oeWdvbiA9IHsKPiAtwqDCoMKgwqDCoMKgwqAuZXZlbnRzwqDCoMKg
wqDCoMKgwqDCoMKgPSBCSVQoUEVSRl9SQVBMX1BLRyksCj4gK8KgwqDCoMKgwqDCoMKgLmV2ZW50
c8KgwqDCoMKgwqDCoMKgwqDCoD0gQklUKFBFUkZfUkFQTF9QS0cpIHwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJVChQRVJGX1JBUExfUEVSQ09S
RSksCj4gwqDCoMKgwqDCoMKgwqDCoC5tc3JfcG93ZXJfdW5pdCA9IE1TUl9BTURfUkFQTF9QT1dF
Ul9VTklULAo+IMKgwqDCoMKgwqDCoMKgwqAucmFwbF9tc3JzwqDCoMKgwqDCoCA9IGFtZF9yYXBs
X21zcnMsCj4gK8KgwqDCoMKgwqDCoMKgLnBlcl9jb3JlID0gdHJ1ZSwKPiDCoH07CgpjYW4gd2Ug
dXNlIGJpdCBQRVJGX1JBUExfUEVSQ09SRSB0byBjaGVjayBwZXJfY29yZSBwbXUgc3VwcG90PwoK
SnVzdCBGWUksIGFyY2gveDg2L2V2ZW50cy9pbnRlbC9jc3RhdGUuYyBoYW5kbGVzIHBhY2thZ2Uv
bW9kdWxlL2NvcmUKc2NvcGUgY3N0YXRlIHBtdXMuIEl0IHVzZXMgYSBkaWZmZXJlbnQgYXBwcm9h
Y2ggaW4gdGhlIHByb2JpbmcgcGFydCwKd2hpY2ggSU1PIGlzIGNsZWFyZXIuCgp0aGFua3MsCnJ1
aQoK

