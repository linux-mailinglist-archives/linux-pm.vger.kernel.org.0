Return-Path: <linux-pm+bounces-42512-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNVkDZ+rjGl/sAAAu9opvQ
	(envelope-from <linux-pm+bounces-42512-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 17:17:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96189126080
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 17:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E6DA30154A8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 16:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA5E329387;
	Wed, 11 Feb 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqvxt6VF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440C22EF64D
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770826652; cv=fail; b=ClEjP5jqJMFqAD5tZkWrmbw18PBxeYQET15iKYgMhajQ6vrZP53+YjJzP2F5IYRZtPS1JjQonvDGLZPoFK/V1nWuhzCpmPKFf3RaUhJMdsHgVFu9zTs7SZOeqG1TcoYdDgHhIV0qOGkviIo38x14zHj22f6DwJdt+292VZmsVPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770826652; c=relaxed/simple;
	bh=a1/kx3+YbVAlp4x36WYG3OmDxOiLYriO/pwKJ4ZlTC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ltNOsxJsWN/7dQaLtPmvMjG2Klj8RICty4zzZaR/80Ny3F10++w21o6eZ1uIZ21E47X1CvSw6vobLQuIrUyPt7+aQYso2qvnq2bn97Y+O4XvBArIEAaJAocThUEHSUSEhs9y8Ew9e39Oag7FlkwMd4bynRwzVlyGfpFBZLySNO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqvxt6VF; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770826651; x=1802362651;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a1/kx3+YbVAlp4x36WYG3OmDxOiLYriO/pwKJ4ZlTC0=;
  b=lqvxt6VFRWLRUn1YyP6qAt+lrUA5ED+5RMeBwAu1IVLNvBFsSD/m9CA6
   EHsosQlU6mEuQB2hWgyuyp6QTjMyrfZfEAPM4aQuqZfjrteQl6i2LTsUj
   Rc0hCxTZX7M6d0j2Kxh2XFOdc0KY4V9/jw4Qu7N1yg+pNEdLkm/z1vJ5z
   ZFN3w5KhTz1D+1wJCS+FXYSjLT8PmI0A3tvY6+Ghq1vIvLmkbGkNSlAHp
   Di7yGJDqcUY/yhVEXHVd+cTkg+hpdVcwmfYqwtcnSiHE0tqRjq0ERjo4U
   gPDFX1+s3mO8InSXTHo1hyQEVS2g/RHa/BDbyQYJHTOafXaJLbZFZDYow
   Q==;
X-CSE-ConnectionGUID: TYEzUnbqRyiVziCOdMhmzQ==
X-CSE-MsgGUID: ptEr+9HfTvmm2RZeAysCTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71877157"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="71877157"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 08:17:30 -0800
X-CSE-ConnectionGUID: v5SiiUA7RVaczJQnOmr0Vw==
X-CSE-MsgGUID: 6OWGqItmTNijlLM9Ozh3GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="242910192"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 08:17:31 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 08:17:30 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 08:17:30 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 08:17:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVGUjCcHcXddBucpYrjifi5+q3pI5vgAe8tzRZeHdtzvFWOmaUH/mR6hvYBmjJnZZPky99GkwwfwYHnXCr9nCl7NcFQHCLyhQUX9uhcuNkVbex/GKBVpaD/lOxZOos+CprwW2TbCieRghCbe2WfOP0Dvdn1BsOTp0TfwybJkuuR2ChX45KphQxQjmxzTMiMg+iTMU6xjJoS8PlL7BChvJurqncwNZ81vtA4pWbsOC8LLKcLufmW1iXIc6Y3DZQEHUJi7eNmkziRFVne7gSeJkmbTxl7g3ijrsyjjTeRGk5b9bZPQle4BiEwOG9qXtBqbH2uS4TBXrR7gF0WWE/jnUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1/kx3+YbVAlp4x36WYG3OmDxOiLYriO/pwKJ4ZlTC0=;
 b=xQLuyWrQFxxqXgFciCNJyEytV8Bu6jcvIf1mwF6Sn+ou210dn7+wgrC+n/jFe8ufYC9z62rTNQLwHqKlncvjqWk2+YjXHPyCMPJZQVaRKuDpfWSE/bKMYb49XLjf+lmgoKMTK/Z+HIHneL/v3+v5FZ0ln9Bzm/Kumh7TMQCsZz7Z8rDoSqDIFoAEL3VbpdxvS04CznAaM4Jbn1swG3njmqp/zuX1JUcRNho3LSc5frXaswBxnl+w4I8ZFj2ePvRZ96K74rCvacEh4EtW9UXHTVVmSo6o8fSusmAs7Y4SqHHAbe3+weKTG9sg0KiT9x3kmuK9txjDqk4hHIyEyrbO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by SA1PR11MB6847.namprd11.prod.outlook.com (2603:10b6:806:29e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 16:17:27 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5%7]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 16:17:27 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Shuah Khan <skhan@linuxfoundation.org>, "trenn@suse.com" <trenn@suse.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jwyatt@redhat.com"
	<jwyatt@redhat.com>, "jkacur@redhat.com" <jkacur@redhat.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpupower: Remove incorrect EPP dependency in
 get_latency()
Thread-Topic: [PATCH] cpupower: Remove incorrect EPP dependency in
 get_latency()
Thread-Index: AQHcmEyd6a376sGoJESJEJHT6ypleLV4NPqggAV3pYCAAAFxgIAAAm2AgAABTWA=
Date: Wed, 11 Feb 2026 16:17:27 +0000
Message-ID: <LV3PR11MB8768ED9507F518E313331D13F563A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20260204111104.3490323-1-kaushlendra.kumar@intel.com>
 <96b8e23d-8f65-440c-b3ff-d6afd218d329@linuxfoundation.org>
 <LV3PR11MB8768F16244C44C0554F1C4E3F564A@LV3PR11MB8768.namprd11.prod.outlook.com>
 <861b65f7-6d84-41f1-a284-95e99f37fc68@linuxfoundation.org>
 <LV3PR11MB8768B808DDC32B24D8F3D10DF563A@LV3PR11MB8768.namprd11.prod.outlook.com>
 <CAJZ5v0j+iQZ35nvSc352bVv0x9FRCPPAfWX2-UdwnBPaNmGugA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+iQZ35nvSc352bVv0x9FRCPPAfWX2-UdwnBPaNmGugA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|SA1PR11MB6847:EE_
x-ms-office365-filtering-correlation-id: cae8af1a-c6bd-4904-fe13-08de69890c5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Y3htQXdvTzdvRis5VEhaZlFwN2o4Q0VTTGdSOEw4OVNXUVZuaU1zWjFrSG5h?=
 =?utf-8?B?UlYxbEZGcS96L09lN2tTd2ZaMkNaczN5L3NBdE9OMmR1TFBCZDkxdURzQ0R3?=
 =?utf-8?B?OXNvREVna1gzdklvMHAvZFh1bWhkOFBRdldCakFwaFRWTlBqbG9KYml3dHZX?=
 =?utf-8?B?VUxGMk5ScWlqcnQxRkwwM09HMVRNTEVvS3lJSzVmZkhVU3N6eXNwT2MvcGNa?=
 =?utf-8?B?aE0wbnJVVVRGQVMzMEtzN3g1bHpLWkx5UjNxNnNqY1IvRldLWjBiaUtkekl4?=
 =?utf-8?B?Q2F0dEJsVnhJU01ZbndnLzEvUWN2TUtXSFp4bjBpUTVUd3VYSzBQT3pHeEx0?=
 =?utf-8?B?TEZCM0ZDcHBGeFkzNmVaUlA2dmJqWlpjRFpweXM3M3FJU1FMT1l5a2dJM0Jv?=
 =?utf-8?B?QldHUTBUWXNzSktSQWtYc0JreWJ3WThVUzFCZmJpdStwU3lpdXI4aHY4YzJO?=
 =?utf-8?B?c1FXTEU5ZEVBRVhieDdKZlZ1QUxyYjh2aldoLzNVdjRITUVVTnJObjlIcUtQ?=
 =?utf-8?B?SWFDNGQ4V1hmRXlValJCTDBHN3YvNUN4RXh3bTBaTjlLNHlLVmVWNEszSVM5?=
 =?utf-8?B?MWRtQnVFYTlLT2duaHh1b054OVlObWF1b0MvRW4xOVZ6OVR5TFdIdlNlQXJm?=
 =?utf-8?B?bFJEUkNzUER6T2E5cWVYbis1M05UMzFuWncvcTJXNFVDNG5JRzk1bVdFeTJs?=
 =?utf-8?B?RjFybFYrK0JtTlZlVEh1N3JJMGI3dDkzWjJMdjBDNzRRNW9kcE4xMjVNdFRz?=
 =?utf-8?B?d0VXMzE1UStYOUNEWDJ1SzF6NEFaQ3NIWHQ2RWZhY2lLR2I0NkE4RG5vTml5?=
 =?utf-8?B?bjJXWkNlWVlveXVJMzgrK1IzUG5Hc3YyNG1XZ2M4WjRySDB6djJlRnJrN1hE?=
 =?utf-8?B?QkVGcFEvM04xTEViU3BmMXgvSkZ6ZGtvaDN5V0g1MTc5WFlPQm8yS01vbFVv?=
 =?utf-8?B?T0k4YWlwQnErS1B3Tm42eFZHTDlTeElBalBoWkx2VEw3THpiMXprb3g0N3Qz?=
 =?utf-8?B?RUQ5dGZGZDVZNExVWjI4ekx5YitOV0JWV3BzQkZHQ2EzSjB3SWNSWk9WcXJN?=
 =?utf-8?B?UWJkanBzeGNMQ0ozZ0J4Qnlmd0RJZ0R1eFlzMXVqUTQzOHlJZ0IxR0cvWHBG?=
 =?utf-8?B?V2M3K01ZV29laWtWcHQwMFdVRFZDOTlBT0taOGVBNmxKQ2kyV1lOdDBqMVVs?=
 =?utf-8?B?MHdzbFk5aWVXdEZLWmd0Y0RDcUh5R0l3UUtjdWdFdUxWWk9zeXhEV2xRVnV1?=
 =?utf-8?B?L1hJY3B6YWRGbEMwYXlleG1XWDRjV3RTZVlkNXZUUURzSDY2ZXh4NXMxMGNY?=
 =?utf-8?B?UzVGdmh2TWU0VXFRMm84bmFFWGlJKzB0QkpvaFpqOGl0dDh0OUVHVk9qYnp0?=
 =?utf-8?B?azh2YzdKSXYwMjdZT1VoelFFZlhZV1daelhUeEo1cndSS0hKWTlXbDloUzZy?=
 =?utf-8?B?ZERMU2FoYzNsZHB1TUVyVU5NR1V0b2ZLbjJQOG5Cb3RJaCs5ZFBuUGhXWFVy?=
 =?utf-8?B?c2NRV3dYWXU5bVNZeVYyRFczVlczYW5zaXNzMlY4bkE4SENjSG1SSWNZSXZw?=
 =?utf-8?B?REhrVW8reGJaem1pUnVPYkN5bTAvNlpHTjFFRlNEWERtWHU1YTlITEREbllC?=
 =?utf-8?B?dldlOHE5Rk1aWTRGODA0c2NxRi9HR2FyT1JtcUJmMGYxMEZKREViWlhUUTBu?=
 =?utf-8?B?S2VTMGlKLy9nSXliVVZ5UTZhVDdENFgvMEJqL0pmZkQ0cDkvZ3lCbGErZUl6?=
 =?utf-8?B?Q3pORWpxSnJiTndUeWkzbHRBNGdzaFFsZkxpVU1tMzBkZ3krMm1EREorRnF5?=
 =?utf-8?B?UlN6R0JPeEpRd2NXMDJ3T1htZkhCNUtKMWx1REJUVytKS0o4SE9xTWlqVGFM?=
 =?utf-8?B?MnIrc0UwWUJFM2NFRG5hclZVRUNNZlVXZTIySnZKZmxsSXdsaHNESzIzVHg1?=
 =?utf-8?B?TWVDcVEyTnBTckZSZGRHUy94MjlrNXhZUE41NlJoaVQvbGVEN0VENnhYcURu?=
 =?utf-8?B?ZWN5bmkrUC9QVHBlKzlHL2NiSTA4Z1ErTW9wVWYxMGVWWEY5NmdmTVhCQkth?=
 =?utf-8?B?czFSWUZTVms2MlNITk81UnRSdVprYWpMYWFaNFN1d3ZWT3Z2b2NTTmtydmlh?=
 =?utf-8?B?a0pCTUU0dHg3NUZjSHVFS0lGdEJOZ2hMbnhSdCtkdk9GYnFFbHBGV3ZKL1ph?=
 =?utf-8?Q?BQmqQplyXjlqBuHKYAl4lsA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm4xRlVFWmxnbHJwSnFrNGZSUjlzZlpOOUZHS2RqSFhZbmplVFpXQjFTM2U1?=
 =?utf-8?B?UmRxNWtwamQ5OFdseWVBNVU1b1dHblhyT2lleXo4VFF5MWk4ZW1tU3lyZ1hH?=
 =?utf-8?B?SzN0dWwxaHZOMXB2Q3JITXhWcHd5eXQ4RVEzYThocDZ6VmVMb3J5YmhHSEF2?=
 =?utf-8?B?Z0h2T1ZZYVc4bFkrOHhMMTNWc3NSa3h2SHAzWjJvUm9rUXJrRnY5RjN3OUdv?=
 =?utf-8?B?Q3ZxbWcrY3AxWUZEelZXaUlMdjN2bzQ3bS9LTnl4bWhLUDg5czNBQ09OMWpO?=
 =?utf-8?B?N0NWNUZTUnFzejFBWmcydjhWQ3lBVllPYllOQ2tEc3dPZjNoNVJyUUFxTDF3?=
 =?utf-8?B?clFBVitkUmc2RTRaVENsUHBUTG51amJudkI3dUk4S0ZuampxRTg3aUI0S2RC?=
 =?utf-8?B?Q1Zvd0NFeHR6MWZHdnl2ZVBtNStqZ1R5ekFpZk5ORGhuL0FIM2RYZlVEUUg4?=
 =?utf-8?B?cGh3Q2tPdDJmcHY4ZmNJaGl4OENaTXlWNnl2V2E4S1IrWTE4RW9sNzE2bkNy?=
 =?utf-8?B?Mk15cnhZamZWbnZ6Y2EzclI3eUdPMFBNeDVKUXl1MGQ1NUNJd0dSKzNDNkth?=
 =?utf-8?B?TUJwWjY4NkdDT3NCR3Nibi81NHRwV0FtajgveE1qMlBLR1AvVzRaMDErWEVi?=
 =?utf-8?B?MDkvWDFDdGJJVmV5NUl1VW9aeEdwYW9CaGhMT0lacVcwL2JlbTlWOTNGcHds?=
 =?utf-8?B?dFhybDI4US96b2hlTGRibUd2c3ZzaFM2Q3pQWXlNSFV0RWxRUjZTMVJoZVFP?=
 =?utf-8?B?OGppLzNlK2d2cUZucURidit2T2VKTGFQRHBacnNKOTVCaURIckFlNGVLNG5w?=
 =?utf-8?B?MWRDYnNmd0c2OWZTaVh3QTU5VmxnTUlFUW9sWCtrL1V4dUtHT00xdjhxbzAw?=
 =?utf-8?B?R2V1cHlxT3dYTlN3M0JZaGVrVm9aU2xoQWpCaEh4Wm9STDR0bEtnVExlOWVP?=
 =?utf-8?B?K0JjTXQ1UHh4RWRGWmdWWlFRUkJJYVJmbVdJNENZR2F1S3FXSWdKTUdncGIz?=
 =?utf-8?B?QVdjQzJ5dG9IbUZ4U3ZLenVGbTVnYnMybGJlNU9aczZqaTNaeXJOMFl0d2F2?=
 =?utf-8?B?a2dlNjg0TEpnTTQzUzYwaTNsOHN5Sml3Q1hPblFsNmUwdmo2M05rc2NkcDg2?=
 =?utf-8?B?OFRoMWUyWlF1dGcrcEQ0VkdLOGhuK1BJRGZYZHh1ekMveTVJa2NPWCtZOGly?=
 =?utf-8?B?amlwd1BWbkY1ZHNVWmhGS2VYbHRFNWdTQTBXUzNmQ2I2bi8ycVFLaXdkakpx?=
 =?utf-8?B?R21KbDFtcURvN1FWTnFDV0YzZVlXQmcrMmQvbWJFb3FDQ2tzaTgyTVFCVnl2?=
 =?utf-8?B?bXRGNUw2ZFRkVTViZ281SGxTTWZXOHZCOGpSQ0hGeERKVEZ1VGJDWitsUGl6?=
 =?utf-8?B?UVUvWUZCeWxPYlZwM0kybkRCOHdtYXBvN3M2cERscHp6YVZLSGEzZndQaURm?=
 =?utf-8?B?K1AzZ2YrdGRVb0RXRmtHd0tWSXMwT2Z6Y29lR0xGa0N2OHVkbW5mbzNRb3Ux?=
 =?utf-8?B?WGRlais3Y0RLWUJYbUhnVTF2ZFlZYlB3Wit2aFp4TThmR2JaY1FsNjF0MzNE?=
 =?utf-8?B?SEZCSTFHOVh3bkdXTDllVnFMN2xMU0d1VWN0bWRCR2JrcmRaLzU0cFIyRVpV?=
 =?utf-8?B?WUhmWFZvTzJSNDVaZlNIL0hzUEllU0NZTWpYM3lrQUdjZDRlNlZzakpLT1Fp?=
 =?utf-8?B?VTNGdzhQUEwzb21DVERNeHY1WEV4aEJkLzB5Yllob3gzYm5QREFzM1hZUTVx?=
 =?utf-8?B?YnZHVEd6MzZmaGZaUFdLaGMxYi9iQlhtRncwR0x5Z0lhQlJFTXhhVEdNUXBQ?=
 =?utf-8?B?MFdlUzZ3dTljVXRHTHIxcnJ1cGJLRG5vcjI1M3hMUmY3RVBSeS8xekx4Skxl?=
 =?utf-8?B?MkJaYnJ3K2FxUFp6ejlrUTJ4YXhxT0s4eThtOE5wbmdZRGVxZTZRQVpUOUZi?=
 =?utf-8?B?RGJjaGdXa3ZYOW1GcjlHVERPM2RvVTlmMnpDNVJEc05oQ3pWN2RweHFEWFRM?=
 =?utf-8?B?U3MxaEVVRy9MRlMxMmp4TjJSN1N1V2JzVWRuK0I4RmVkWXp0WjhpOVk5Vzlx?=
 =?utf-8?B?akU3Z0tteGVZZnRydlhGUlVQdG9kemhYVWUyelE2Y0JnV05VK3BhYk52ell1?=
 =?utf-8?B?Q1plV29lUWliY2cxTXpiREpFekEydFNpL1c0bkRJcTAxbnBkQk1FWFhZeDJz?=
 =?utf-8?B?bldodThJaHJocjEzMVNUQ2RjcGt0bERZRWpBMjdBN3RKcUxXTitSVnJscVNB?=
 =?utf-8?B?dXpUbXdhbStCUUYzbHFpL1J1N2lxZ3VUV203aytZMTZOWVBlYkFQUG9td1JJ?=
 =?utf-8?B?a2VlZ2tReURjQU1aNzJoazMvSlRkL09TVkJuLzhMS2kzNnBLM2Zkdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cae8af1a-c6bd-4904-fe13-08de69890c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 16:17:27.1508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtoQCMiL/B5XGLe1z7HJPH4ZktxFKAvgqbBW7yHnlqnMzKv5lGjdRKzuSxW+JlJVcwHIiM7vQbffD8y4yINe7id119gSoyYLyKsFnu71d9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6847
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42512-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV3PR11MB8768.namprd11.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaushlendra.kumar@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 96189126080
X-Rspamd-Action: no action

T24gV2VkLCBGZWIgMTEsIDIwMjYgYXQgNToyNSBQTSBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToN
Cj4gT24gV2VkLCBGZWIgMTEsIDIwMjYgYXQgNTowNSBQTSBLdW1hciwgS2F1c2hsZW5kcmEgPGth
dXNobGVuZHJhLmt1bWFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiAyLzgvMjYgMDk6
MTUsIFNodWFoIEtoYW4gd3JvdGU6DQo+ID4gPiBPbiAyLzcvMjYgMjE6MzQsIEt1bWFyLCBLYXVz
aGxlbmRyYSB3cm90ZToNCj4gPiA+PiBPbiAyLzcvMjYgMTQ6MjMsIFNodWFoIEtoYW4gd3JvdGU6
DQo+ID4gPj4+IE9uIDIvNC8yNiAwNDoxMSwgS2F1c2hsZW5kcmEgS3VtYXIgd3JvdGU6DQo+ID4g
Pj4+PiBUaGUgZ2V0X2xhdGVuY3koKSBmdW5jdGlvbiBpbmNvcnJlY3RseSBjYWxsZWQgZ2V0X2Vw
cCgpIGFuZA0KPiA+ID4+Pj4gcmV0dXJuZWQgZXJyb3IgaWYgRVBQIChFbmVyZ3kgUGVyZm9ybWFu
Y2UgUHJlZmVyZW5jZSkgd2FzIG5vdA0KPiA+ID4+Pj4gYXZhaWxhYmxlLCBldmVuIHRob3VnaCB0
cmFuc2l0aW9uIGxhdGVuY3kgYW5kIEVQUCBhcmUgY29tcGxldGVseQ0KPiA+ID4+Pj4gaW5kZXBl
bmRlbnQgQ1BVIGZyZXF1ZW5jeSBmZWF0dXJlcy4NCj4gPiA+Pj4NCj4gPiA+Pj4gSG93IGRpZCB5
b3UgZmluZCB0aGlzIHByb2JsZW0/IEFyZSBFUFAgYW5kIENQVSBmcmVxdWVuY3kgZmVhdHVyZXMN
Cj4gPiA+Pj4gaW5kZXBlbmRlbnQgb24gbm9uLWludGVsIHBsYXRmb3Jtcz8NCj4gPiA+Pg0KPiA+
ID4+IEhpIFNodWFoLA0KPiA+ID4+DQo+ID4gPj4gV2h5IGRvIHdlIG5lZWQgdG8gY2FsbCBnZXRf
ZXBwKCkgYWZ0ZXIgY2FwdHVyaW5nIHRoZSBsYXRlbmN5Pw0KPiA+ID4+DQo+ID4gPj4gVGhlIGVy
cm9uZW91cyBnZXRfZXBwKCkgY2hlY2sgY2FuIGNhdXNlIGdldF9sYXRlbmN5KCkgdG8gZmFpbCwg
ZXZlbiB0aG91Z2ggdmFsaWQgbGF0ZW5jeSBpbmZvcm1hdGlvbiBpcyBhdmFpbGFibGUuDQo+ID4g
Pg0KPiA+ID4gWW91IGRpZG4ndCBhbnN3ZXIgbXkgc2Vjb25kIHF1ZXN0aW9uIGFib3V0IG5vbi1p
bnRlbCBwbGF0Zm9ybXM/DQo+ID4NCj4gPiBIaSBTaHVhaCwNCj4gPg0KPiA+IEVQUCAoRW5lcmd5
IFBlcmZvcm1hbmNlIFByZWZlcmVuY2UpIGlzIEludGVsLXNwZWNpZmljIGFuZCBwYXJ0IG9mIElu
dGVsJ3MgSGFyZHdhcmUgUC1TdGF0ZXMuDQo+IA0KPiBUaGF0J3Mgbm90IGFjdHVhbGx5IGNvcnJl
Y3QsIEVQUCBpcyBwYXJ0IG9mIEFDUEkgQ1BQQyBub3cgYW5kIGFtZC1wc3RhdGUgdXNlcyBpdC4g
IGNwcGNfY3B1ZnJlcSB1c2VzIGl0IHRvbyBJSVJDLg0KPiANCj4gPiBTbywgb24gbm9uIGludGVs
IHBsYXRmb3JtcyB0aGVzZSBhcmUgbm90IHJlbGF0ZWQuDQo+IA0KPiBQbGVhc2UgZG91YmxlIGNo
ZWNrLg0KDQpIaSBSYWZhZWwsDQoNClRoYW5rIHlvdSBmb3IgdGhlIGNvcnJlY3Rpb24uIA0KDQpB
cG9sb2d5ICBmb3IgdGhlIGNvbmZ1c2lvbi4gTGV0IG1lIGNoZWNrIGhvdyBFUFAgYW5kIENQVSBm
cmVxdWVuY3kgYXJlIHJlbGF0ZWQgb24gQU1EIHBsYXRmb3JtLiANCg0KS2F1c2hsZW5kcmENCg==

