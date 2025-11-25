Return-Path: <linux-pm+bounces-38614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC83C85AF1
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34A884ED36F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A77325704;
	Tue, 25 Nov 2025 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+XuSAy9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0470D218ADD
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083144; cv=fail; b=ueJc6IuV5NW3V5AMlsznZBPormk1zlk0ZYxG142Psd/k+eVHS+z1HFkoXTZLS+E7NgQStZphsDsq34Aakwarsgrxwb5DvqCgpeWTkTQu3F9aqKlNC9YJfBoGvBNsHaOm1TFJ1pDa0FKjDHZhlTW8BeoX0UbpZTSfxOGeISNDma4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083144; c=relaxed/simple;
	bh=hj4Tk28W6NP85YH5N2ylnhzTkgXRlG55Cf1LZnfISMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZirhYT/D4zmkfMLn2SMejv0IluXvPo3zXq3g1DJJyHaxp5Yt04fE4xD8pV+QFwVzrIHAtlUk4mbFeGsWtQh+x91RnUHjzfbYXtiHYNDtB0+rhBXeguFESh/bCfrGUlB6UDY/9iaSMv00Z9x8bQJmvCu0caqTs8gC667etIiOrgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+XuSAy9; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764083143; x=1795619143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hj4Tk28W6NP85YH5N2ylnhzTkgXRlG55Cf1LZnfISMM=;
  b=W+XuSAy92ln6EOmq7xC7EIDLS19kjt1Risqq81XZPycZZjENm+NTqoFl
   ELb4FgX95WCht4g/ZA6Uw/pENpHyhazee97VhQh+Pkct4cwPdNQa/ZfWZ
   9DZ6b33/dQbZgFAMIL2er46xSlMbWUqAAz8TK/0AZ31813jVRy6ICJcuT
   8me+wAAb9/s9Lowm8gWfgvRTAr3HJHkwhwppOpn05JkzMfGnLCjYjrhWl
   KjzDYXMZ4gzD0Cb+pgou1yzUDfrmhW5yhUG7HQ88lxXydkT9Rb+cmyeEm
   5niBXRHLlaMiKuj7XkNguzy13M1M2JTDkiQJ2hPZ0kv8XcnpP4ZqpDZSk
   A==;
X-CSE-ConnectionGUID: 96pLhMPSRvq6e/SAT6zMQg==
X-CSE-MsgGUID: u5qdA3OTS0yeYQFrP+d/og==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="77580727"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="77580727"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 07:05:43 -0800
X-CSE-ConnectionGUID: rjALU/3KRkeeToFZTAgRug==
X-CSE-MsgGUID: Z8kWsYTVTAeZnCHbUsMI/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="229933635"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 07:05:42 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 07:05:41 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 07:05:41 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 07:05:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lx8R3XzDsI7Zromqig6Np2CHic590IHGI1sv43rSt8zhmokwgFDFC7gbA0xLDLS1paNlv//KJfFSsQAzFW+FVXmGkmCitPIyld1qTM4O22Kq+1Sw8uH+dYb3MCrVxq6332s0Lbix8mJTS9pDHtWsQjycV01Upei+tLSssJkQZWePXyhtk4aa+yVIJ1r2nJHNULZbDwT2rjgDAiPvNX+WYHU4c57vwjgSDrUcGzUDT3GK5p7iwu+ctxUG2JwOveeXHwoSbrSsALPAGOjBM+7Q5jhFkQc1JOmIM+Kl9Gof6XI1v5+vzBk6Pr0do380aLxr5oWZmldrFOu5U2buABLOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hj4Tk28W6NP85YH5N2ylnhzTkgXRlG55Cf1LZnfISMM=;
 b=t6t8Q8R1cJqMwNlR5Crig2Pg8NgZFPdjWWc/aAHfxmLuuThD3QnjuVPGluFdR8+q4EwTc7oO3wV/EUV5ismgGO8U0Tto5Jfuo1SSLWiTkbj1HYq324D+B29KeVHdA7IKfH0Qu71jimJa2wbvA+BcrS4tUVRLPvvIfkL8eX41rYJ66nQS93eKcLtsOeXmE1+/uSRN6n/gjCVb3B6/IEi5J/TIpWFC9cbHsTLgcsI9EY22mVEcXC6lhNe6dbtIenRn5EMOvJFS+IMiJ3MUVNgVxpkhCDLHDX/1cZcTEPsqQPWd/vtpzsHiX/G7LTP3YmyGg/9XhULOIhUgpImeC0QBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by PH7PR11MB8598.namprd11.prod.outlook.com (2603:10b6:510:2fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 25 Nov
 2025 15:05:37 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 15:05:37 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: schedutil: Fix tunables_hook cleanup on init
 failure
Thread-Topic: [PATCH] cpufreq: schedutil: Fix tunables_hook cleanup on init
 failure
Thread-Index: AQHcXgnsIoBPibeWREOSDJ87Hw3w7rUDWbDAgAAaOACAAAlRcA==
Date: Tue, 25 Nov 2025 15:05:37 +0000
Message-ID: <LV3PR11MB8768722EF55328F294AD49C6F5D1A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251125105453.471445-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0gfcwg1+o5-H5tQVd=xM=D1Gufyzdk-WeD4Vmyz_pstCw@mail.gmail.com>
 <LV3PR11MB87686D49A69727A16D913D60F5D1A@LV3PR11MB8768.namprd11.prod.outlook.com>
 <CAJZ5v0jKJYaK5cg2UeaoriVRmFdb4i=S_v=GdH9z07y+5xJWFw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jKJYaK5cg2UeaoriVRmFdb4i=S_v=GdH9z07y+5xJWFw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|PH7PR11MB8598:EE_
x-ms-office365-filtering-correlation-id: 8fd410c5-c227-404a-a023-08de2c34173f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?N1h2OVlFbGVQT1JrcU9WcWxuNUlrK0oxb2cvc2hRdmFsWmZPd0FodTlJZlIv?=
 =?utf-8?B?a2lxamdGbE8yc3RiN29ZY3ZMVUx5SDB5bVczRXB0ZHRDRWJWSlY3dkRhOGdO?=
 =?utf-8?B?eVJWYndTdXZUK3N5OUlIZDRSQTMvdHA2M0xudHRYUU1yMXJ1U1NOVjZveHl5?=
 =?utf-8?B?NmZFVHo0NXgyZjF6ZzJ3NFdZZHpNNmllWWduQnArUjY4SXZCdXUzNlpKWkFn?=
 =?utf-8?B?UDVTR1ZpRks5bWJPMnNVeXB4REtiTHRtQW5hZEg5QWtXNmt4dENEZ29weFQ4?=
 =?utf-8?B?SzlnRHRXcVBNbkxFVGxDR3pMSTlnT2YrMCtWWWUxbmV6SjdEeDBYd3p5RVR2?=
 =?utf-8?B?N1ZDWTlBUTJ4eFBHLzdzRWQwdjlwTXpKeVdnN0VmT2NRRUlaZzNzbjVmWnZu?=
 =?utf-8?B?VFhIZ2p2UUQrMkUrK2wydWVBUWxBYjNQZjY1QXkyS1Zlc3p6OVExZmp1cE5o?=
 =?utf-8?B?cEIzMkNienRwamVJREpJNDd2dlFIbENtK0FvOXVySERnVHlNVEtHcGFvclBJ?=
 =?utf-8?B?akxZcks1cXh6TnZ1VWY2bk9SNVoxVFdkMFp2Z3R2Y0h2QStkQ0pjRVVlU3Jx?=
 =?utf-8?B?OUVrR0x6Rnd3N2J1dE1TL0FBYnl2ZHJyL0RUM2t6Tmc5Nmx5UFFjNXpxdkdP?=
 =?utf-8?B?eUtHZUZvdE1qM0RvK3BmcmRSMVZPT3pPUGp5bGtMM200NlVVUlJYU0ViQXVV?=
 =?utf-8?B?V1VZWFBGeGFmbkMrak9HSmZETW9JbWR3a0tlN0g0S24reCtTcHg1ZUFUbnkw?=
 =?utf-8?B?N3N1cHk3ZkFpMUZqOEZVY2p4RG1vZ2hnUkVraEh5SFpoR1p2ZjFJeXpFL05P?=
 =?utf-8?B?VU1WbTYxZE82TUcwM1FzKzQwWllBdkNGMjIwSUloeEFsdThMV3krRUFkT2xj?=
 =?utf-8?B?RVBIejB0UGRJWDA2OWtkTlltcGVHNUN1ZU95K25aelBCU0hueFdWL0ZyN2R2?=
 =?utf-8?B?eHFXZ2lVYUNMUHlhK1hRWHRCelNkSlQyWjlZbDdRTGVNTWVsQmhVaVhDZCts?=
 =?utf-8?B?bTlyNS9TQlUxSi9Vd0VWWFo2Uk9uQXVQVFk1S3BZY0FDYmdLclpwZnhPb3R0?=
 =?utf-8?B?VWp0VkJsWnlqelRRWitaOEUxSlVQd08yQ2dOZUswRFVOSVhrdFFiS1JZa0VB?=
 =?utf-8?B?d1ZXcWNEUzlRcEYzV2E0UFRnaklhaUxnNmYxNlBoZmRPaTl3N2liZFJOaW04?=
 =?utf-8?B?NlZwcTAwK2t6MWJrZWtxNlBMbStPbkFMY3htM3V0ZlhtYUh5aUNkTnFWMWtX?=
 =?utf-8?B?OE1mOCtOYThsT1NNdE51Y1B1WG1RTTI4MmczVlhsYU5NOERFa0NMTU5nZEhB?=
 =?utf-8?B?aG5wVTc0L3hPeUtFazRZL2x4ZnR0SHhQK1N2VEFndVNMQ1VIWjc1MWNIczFk?=
 =?utf-8?B?cERoY05KRC8yWStqZTFuNnZsczR5djFGbnU2dGdoVG9FZkVDZlA2aERuajBz?=
 =?utf-8?B?TThuNUxYb1ozWXJHVGVVUEJUbmR6b0trOU81a2NXWElwV0IrK3Q0S3Ixc0ti?=
 =?utf-8?B?T2VqUXB0UmpEZzRidFdhcXhDWXVQLzB0R1hMeTBlcVYrR1N1alJQZGowdURo?=
 =?utf-8?B?UzFoTzN3RnhqUkxvc0FpdGx2eFpXVFFtZHRPQVhpL2hWS2gxVFRzQ0dOTVVo?=
 =?utf-8?B?V0ZqWHpMVmowNWJTMzhSa1VORThUZDdBRU4wQXNyQi9mQk9NT285SkwrRVJi?=
 =?utf-8?B?WlhqTW5HOE43YzFaZUtadFp0Qm9UTzhGdGF4SkF6RjltUXJLMGplcWtmVTlN?=
 =?utf-8?B?Q2I4bEU2MklYOVlzUTVRQWZzQzRlUitjSU4vUURVMS9EczRoOGZGZ1dYb0RN?=
 =?utf-8?B?eldIZkhzRUV1YUYydlo4eVd3Yzlyd3R0VjM5YThMRVBITWpCdWwrZURvTzhQ?=
 =?utf-8?B?eXBzemtrenFXZzQxSkRZcGdEdEhxa1c4WjNtTVVPM0R3ZThOSElBdmlIR25G?=
 =?utf-8?B?ajhBdmRjQjFuUXdPQ2hTQUxRMzBNa0NqbWF5K3FtRVl6d2tCTTQ1aEJxVDVP?=
 =?utf-8?B?QkNGaFNUTUtGTEpyZnhxdmJBaUJLRGtVbkhQRjIrdXp6WFAyLzd4d2tleERw?=
 =?utf-8?Q?tgac3F?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnJXS3d4T3dpZTNHWkx6ZEFpVHk2cU41YXhlWS9aT0xUY0gvaGxZNkIvZHpz?=
 =?utf-8?B?RUNSRnlFMjZmVGk5eE56cFFlQmRJVEh4aVFUZ2NnSHJsZTdrRGoyNlZ5NTNv?=
 =?utf-8?B?OXVDQzZhc0RZMXNjREIvM0VZY3ZZVVdwcDhVSERxdTg4c1VzZVlIQzlidlNl?=
 =?utf-8?B?d3Myd3lYVkdVOUd3NVhZRlBWVVk1c09razhYTEYrOXhiM3dtbmtBbGZBMWVa?=
 =?utf-8?B?NUhVcCtBQ0Radm41dUxOV0p5NEdlOWFSUmNaVkZ0SFVTaWlkY0ZqWHNOMXBZ?=
 =?utf-8?B?WjZzVTB4bnVJdVFiMC8wY3RjcjMyb1BGTEtiejR0dnNkVFQ2dVJkVy9xTlc3?=
 =?utf-8?B?dUM4RnpBMUEzUTFDUEVBSmdOWkZBS01YdU9EQ1h0VWlOR1FSZmtrZ3V4dnhv?=
 =?utf-8?B?QUFmb1dNck9ZMWpTSnVKejBndzM3OFI2em1qVUNnS293UC9tZ1FtQ2QrNnU2?=
 =?utf-8?B?Rm50djZaU3VkUExUWEcwclR3UDZzQmNJQko0dThnb1dFVmtaUVIrOElxMGI0?=
 =?utf-8?B?SUF2a1dEY1pUTHR1a1d3R0FHR1FPR05LSmRiaU90K2gydmYzTzE2cE1DckZo?=
 =?utf-8?B?Q0lhSWlKUzBqbkZSNVBSeGJEVE0xdGk2bGVUYUI0SHozNzgrNXZwN2R6WkxM?=
 =?utf-8?B?NlMwWTZYdFBRMnlCRkJKanhvMFlzM1hjcDlhME03UE4xOENhYTczSTVyMjlM?=
 =?utf-8?B?WDRjeW5HdktkZzhDKzdqRE1ucFJkeHFyVlZnV3l2VDd5S0szZ01FUExxRVhv?=
 =?utf-8?B?ZmsvQ05CZnpWVXJkd0FQSk1BV1ZIZU5LMEdHRGh4K0dpQVdJUTlESkhReFNZ?=
 =?utf-8?B?dFdyRnN2NFFNS09lTU1hdzNmcDQ3Z1Z1c1htcGdaNXhWS0VkRWVUdEYrZFA5?=
 =?utf-8?B?Nmo4N05BMi9Md2hCZlZ3RWhWelYzY2JZMG5YUFBIeldBVkNCOGI3Rm93RjVh?=
 =?utf-8?B?ejJJNXpPb3ZsSnBVZzJEcVlBYk15M1E5bDltVFNWUDdXWWZkOUlVRHovN0Ey?=
 =?utf-8?B?VmJ3M2NCN2hCb1pCQ2h1dkIrRFovSnhFUTkrcWtuMktkMGJsb3ZoNitTMmtY?=
 =?utf-8?B?TEVwTFJSdjJxSlZYbzJlZEk4MzQzNC9QVjVxdHNuVmVBL0J3V05vcXd5ZEJw?=
 =?utf-8?B?NUx6L2FWbmloOEdvRlBVbXN4VG0reURCbkJRMUM4U0J2T1ZLTG5rU3RRcXNR?=
 =?utf-8?B?YktLaGdrSzJPN01FM2huSzE4TXB4OGNTWFJESUs3VGg5UFVkV25rU0RWejIy?=
 =?utf-8?B?MXVSODJKc1BsSVFmZGhyRjdWeEJad1h0UmZoZFB5SC9ENTRpZVNFVk5xQU11?=
 =?utf-8?B?UXNtLzVadHg1UGlnZkxPSjJtZ3JMOTVrQW9CZjN0ME1WcHhBZjRVSFl0bnY0?=
 =?utf-8?B?MWpRZk9sQ202RlFjSXUyRENsMWRLNjh1TXZGTlFoMklTVlZhNnV3MWYxYXVz?=
 =?utf-8?B?VUtvRjhpUkxDbms1YXlWNTlxRkNEYTdPWEsvaExOckdtZWlSNGc1eWFjczBL?=
 =?utf-8?B?cnpPNmFpRTk1YWhMdGpGZlNYVGR4TlovVGVKUlo2UXdKYW8wbkVZelhnUXJM?=
 =?utf-8?B?NFRCaXBkaVRqTHIvc3ExckQ0R0NhdlFZMDJvaFEyQkxlQWtYa3lmaWdEazZJ?=
 =?utf-8?B?MmVzTFVWa1JzMFlPdkkxbmoxNXQzMC9RbkkyS2pmM1VqNmliU0RlY3JaRjZF?=
 =?utf-8?B?ZnIvaW5tTlp5WmUyUmhVK1Q3YWk4alRhMzBYWUF0Z09XeFBLTGJyTlhjV2xR?=
 =?utf-8?B?T0lSSGJjNExpcFZoV1UwQUxhSG1nUkF6MVZPZ2NkUXRLaVpxb2dzakQxN0FQ?=
 =?utf-8?B?czZkd3RpMWNuZ3VLSkkxUW8zRTAxVkdRNUR3SnJRMlRKZUdwc1ByZXZqVFBj?=
 =?utf-8?B?Y0xzKzZMYXJ6WnNXaXg0d3NYK1I1U0lNbktBc2JpQUdlZU5vSDlmMkRBUFF2?=
 =?utf-8?B?UFVQTFZJZzZpVU9zVnl4MlJadWJ1c2paSjU3ZVVDaHFNai9LUElkR3c2eDM5?=
 =?utf-8?B?WmgvN0M3N2JQYmRkLzNaSk5PSXFGVS9lUGxKNUJJdEhTNDdSRkdXcWNCekhl?=
 =?utf-8?B?ZlZVb2FDV1FURGQydHFCUnRYYWpPY0k3SkRKa3NXdGRkUVVyaDFacGQ0ZmpU?=
 =?utf-8?B?KzBYdHdGS1djbUJWN0hGaVJzOWUrZ0I5NS83a0o4OHQ0b2k1czBhMGR0VHhn?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd410c5-c227-404a-a023-08de2c34173f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 15:05:37.2690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMa8KItIzO94lHsTpHJHAQhcN2vhZhK/+N4Tk79hXC38PBAIaXrprSHgsH5lhD0qGHHCBvJyVkhqPXLX2swMdPp08v7jnK9sDIw139WMZcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8598
X-OriginatorOrg: intel.com

SGkgUmFmYWVsLA0KDQpPbiAxMS8yNS8yNSBYWDpYWCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6
DQo+IE9uIFR1ZSwgTm92IDI1LCAyMDI1IGF0IDI6MDUgUE0gS3VtYXIsIEthdXNobGVuZHJhIA0K
PiA8a2F1c2hsZW5kcmEua3VtYXJAaW50ZWwuY29tPiB3cm90ZToNCj4+DQo+PiBJbiBmdW5jdGlv
biBzdWdvdl90dW5hYmxlc19hbGxvYygpIHR1bmFibGVzX2hvb2sgaXMgZ2V0dGluZyBhZGRlZC4N
Cj4+IHR1bmFibGVzID0gc3Vnb3ZfdHVuYWJsZXNfYWxsb2Moc2dfcG9saWN5KTsNCj4gDQo+IFll
cywgd2hpY2ggYWRkcyB0dW5hYmxlc19ob29rIGluIHNnX3BvbGljeSB0byBhdHRyX3NldCBpbiB0
dW5hYmxlcy4NCj4gQm90aCB0dW5hYmxlcyBhbmQgc2dfcG9saWN5IGFyZSBmcmVlZCBpbiB0aGUg
ZXJyb3IgcGF0aCBpbiBxdWVzdGlvbi4NCj4gDQo+IFdoZXJlJ3MgdGhlIGJ1ZyBiZWluZyBmaXhl
ZCB0aGVuPw0KDQpBZ3JlZWQuIFNpbmNlIGJvdGggc3RydWN0dXJlcyBhcmUgZnJlZWQsIHRoZXJl
J3Mgbm8gZGFuZ2xpbmcgDQpwb2ludGVyIGlzc3VlLiBJIG1pc3VuZGVyc3Rvb2QgdGhlIGxpZmVj
eWNsZS4gVGhlcmUgaXMgbm8gYnVnIGhlcmUuDQoNClBsZWFzZSBkaXNyZWdhcmQgdGhpcyBwYXRj
aC4NCg0KUmVnYXJkcywNCkthdXNobGVuZHJhDQo=

