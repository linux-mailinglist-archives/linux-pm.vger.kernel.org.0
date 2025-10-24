Return-Path: <linux-pm+bounces-36802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6CFC07AFC
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 20:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD563AB7C5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB88345745;
	Fri, 24 Oct 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGT3o0bX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F30254B19;
	Fri, 24 Oct 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329688; cv=fail; b=IfW8ei6fCak2edb7Ob/BWgwGjekvBtdHZ/KFeZo3oCcqnqWUnvTNX1YgD5OOKN4ptZ+/w3cHcMb2afPmuzgYccfwDQVg/HeGMpvaDF6S6w4IUjTT14cuQ3p5AS2N9K7UgECSRf+3lc3rpB47z3k+WeN6DKR+/ykGl8UT4bjjkjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329688; c=relaxed/simple;
	bh=RJfs79lBQhwBM8cN38U9RWxVQVJgWQYH+uhMywQ5jqM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Uqffl34ZuRTIUWGto/oCfYNOsgsQ5/P7H0kL0aQZbaNydLlv93be2lCCtMrLYV5NGXveaJiigiaoH8b9PQnNj+RFaFeECAosKg0ZEGSpRFWuPumDMM7sBIx4fNfWyBmfGtIZdmvrqJQ5sxhqtgowqPWAP++mb5s3ceTt3PiU3ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGT3o0bX; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761329687; x=1792865687;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=RJfs79lBQhwBM8cN38U9RWxVQVJgWQYH+uhMywQ5jqM=;
  b=nGT3o0bXYh350cixLDXAX0HuxhK1j2J+qRATcMhFqG3NaYO+kTi2J+yR
   2KyuOw31baQiQJC27siC7lXjMXhHuYxVWexCxPresQM/r6jJHC+pfPlSB
   h6SIXlWqhA+qSwUXp3anOp0Towh9OmphoFBSlP24VuD2sKSbucnt1LMva
   I5StM78zvTIfE2m1Fhop68rzlQaxzgJoBka4O9fJ7CpEUpxzaqK8yblcu
   +T9Bxr2/mO6jk2QUUo1b4jji5YjupdF5sIXXBA66nuqj1DBqW48OnYWor
   4TnhMzVv7EddvUEUBxIUMym1JTu+AtWMU8ZKx2biAoyhtbanV71Oj330O
   g==;
X-CSE-ConnectionGUID: lj4gp455RtGWq4C5/vAA6A==
X-CSE-MsgGUID: GGAQyamRS1ewdMtRZkvJIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74634175"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="74634175"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 11:14:46 -0700
X-CSE-ConnectionGUID: fx71Go5wT5uXVpEFWNc73Q==
X-CSE-MsgGUID: 7ma2iQ+2RYmuGXwSksyEOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="185257984"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 11:14:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 11:14:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 11:14:44 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 11:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAXUdidQoj/vscYw7YBJaMn3FgvD+6Log8AyIcV/iX/4vJ1/XkADenO351JggYJTqhR0TNpRgYY7kwtXZzyMp1cY1cFJMqGmasprxHTmnfsCHJvV/xvB1ARdIWyvxygI9aSy9ks+jaChNrIFzaDfmmX+l/Dp5vQar7irCsljQJ0x2A6nfGsRpjnoWEA14l7/jiurd+A3saZRl9EfJqXRebbxzQ5t6FB29ivDfbwHKQ/nqx6LH+PR7+ppv9vjY0hc7INCv33ILuMT2LrobFagdaiIqiWERFDq8WHKSs9S9mi3f2oWwRt9n+mPBf8ehvBZvdZCtzVUqKdecbtNrJqSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwxisUKeXKdX+yVLpQazYvTrE+s53QTwCd0rxXVafic=;
 b=PSRXxqq3h88ivdwm+uqNfnf+waFg9pMTPxAvFi9uMeEQf2vRZVRMgOUseFvGexmFU2GEtv3OxlGrDssAIglRYwb6OP7LpusV71BzbtLkkU/2bWdt6q3eW4C2Agz2x7/3/xybpDzMZbbIIRjMViIMN0Z5b5DSA1D5y8Ud+MBChzwAopuWRr2hYX28p4QKOuTGq6bH/n+ttDICEy7NiWAGgZxvSlSB872mdWL7axurh/8CkAiXVsEhuTWijxWMxhcP7oNBNXM5TTICyUkLervh0aZQfomaCm+kkscOLnTWQkSHGxGjX3b5+u87m6MzAvzvhY6yS9EgYSm3C7YIuaLuvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8564.namprd11.prod.outlook.com (2603:10b6:610:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 18:14:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 18:14:42 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 24 Oct 2025 11:14:41 -0700
To: Joe Perches <joe@perches.com>, Ally Heev <allyheev@gmail.com>, "Dwaipayan
 Ray" <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
CC: <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, "Nishanth
 Menon" <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm
	<linux-pm@vger.kernel.org>, <dan.j.williams@intel.com>
Message-ID: <68fbc211c59b9_10e910034@dwillia2-mobl4.notmuch>
In-Reply-To: <769268a5035b5a711a375591c25d48d077b46faa.camel@perches.com>
References: <20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
 <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
 <769268a5035b5a711a375591c25d48d077b46faa.camel@perches.com>
Subject: Re: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6db46c-bd38-4fe6-f1a9-08de13293461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDh2a0ZXNkpBRmxSNXFLTXQzUlMrZ3drcGJxQkN2R0tSbzAyMDBUUHExTlQz?=
 =?utf-8?B?dDBxMGhtRU12TVFVNlZtKzk0OVFBWThRWFQ5RHJFMjlvUi84amQ1Y1FaR3ZP?=
 =?utf-8?B?STlUZHpjMEZCTHN3R2FLU2E5VEFQK1hCeE5SbXlhZldVcDI4dmxqR0RDTWVq?=
 =?utf-8?B?aTYrQzNVYjJvNDBNMHR4VElUTDJpbC9kUkJPK0FMTEdoMjFvL2xnSjNNMmM0?=
 =?utf-8?B?cDR3d0taSnd0S0YwOE94RjFRSHVnbDVLdTVMRGtYSC9Nb25lVU82R2pmRjlE?=
 =?utf-8?B?eVFHMWd6Y0xlelJ5RmNXSUkySERvZmhsWGsrU2hKcThVaFRQUmZibVIwWGFS?=
 =?utf-8?B?ck01aGg4N1BuYTFHUUhsS2FkMWhIaWlmNDB5dWFOaDlXMlhSM2lWVGxBUElC?=
 =?utf-8?B?WTVDQW02TDVKVlhyaVYrbFZSTXpSTWJtYy9KR1hvM3o3QUxRQ1lYSW5XQ0oz?=
 =?utf-8?B?REdKWUVqS21aTm9ZdWlZeVloMmRQRm1uWlBpajdsMTkwT1hwUTdVZ2pmYVpY?=
 =?utf-8?B?bTZmZE5uMzIyaWdEUHFSditwcXZ1THhEeDI1WnpUWU9PdmxUK05tWVVxbUhk?=
 =?utf-8?B?cHZaVG5mOHVNdFp1MmVZMlpWMStTSXR2UHZiOTlILy91RGNQSzZlMkZTZnZ6?=
 =?utf-8?B?akRacW9QeW96blJQanBuR2pxSk1YcUs2UWlGekwzSnVQVFE3RjJRaDBOby9o?=
 =?utf-8?B?R3JZdlcvelBBN3NtWW1EUEJpaEFRM0ZKZVdKWnVDK01GSmRkbFNYUnFhMTJm?=
 =?utf-8?B?aFZlY2JtamU3RVhLNnJReHE4U2J2aEkzajZwN1RtZVNUa3dUT05RQlRBUGlo?=
 =?utf-8?B?N0d1YWo5MTh3TEJUaUlFUDNjNmx4QjRkbHlROGNYMnFmVndUb085Qjk1Wkxx?=
 =?utf-8?B?Y2ozSVNxb0xiS01kRU1NakI1VTJ0bnZRMjJMdC91YjVNbHdLY05PaEtVeVBi?=
 =?utf-8?B?Uk5xeVg3NmFUVmJaNjdJRlZhaWZxNWhhUUNtMWxVQ3NXVWZScWtqQjNWZ1pk?=
 =?utf-8?B?WDBqL0Q1MDlpTW9zU0xUbDE1a0dMaVpRQkJsWlFRZmt5YUdUeUtwdUYrcGdO?=
 =?utf-8?B?anh2TkU5dEE5TlRCNEpJZlc3UEo4bmNudWs4bHRueFg3Y2dKNEt5bTl1Ylph?=
 =?utf-8?B?Nzh2WnpmLzNDNWhLQk01Y0l1aHEyQThuSHJGVkpJa3h0eGZYQ1hFRnl1dWRk?=
 =?utf-8?B?cUhRU051U1N5VEFtdlIxTm1OcE1pMVFwV2dLcm1uazYrZHlBdUlUalZjVC9J?=
 =?utf-8?B?eGdhb29kUXEvMGZlS1hNY0dwRFpVNDMzTUthMnRHekFtV3ZEZHJKZEdSZGpI?=
 =?utf-8?B?MmFWM29RamR6SGFZbU5UdWF2R25lOHR3ejNSMm50R2F4U0k0cWNFcy8rZndT?=
 =?utf-8?B?MWQvWS9VUmcxZURMbVJYZ3dIbmpQSVNiajhTOGVrZVRQUWRWVy92T1JMWWRm?=
 =?utf-8?B?OHFFQ3I5bUpTODRYZmNhWFoyblhKTHRWdkVIUXdGaU1zT1ErQTdPRlVLYVV2?=
 =?utf-8?B?Rm8xZGVMS0Vrb1hOUFB2Zkc4c0lHcU9wRDhrRFNBOXY0eWNaUHNGSjdGOTRD?=
 =?utf-8?B?U1IrL21Nc0trYUlOVE9vNWJsUjVkVlVQVzhYcFluSGNnWkNOU3JvU2lzcGsx?=
 =?utf-8?B?VzhrU3pFb0JmeWdEM1N5UGhBcUlrajUxWjZVU3hoNXVuWVN4SjF2UTMwT2li?=
 =?utf-8?B?TkpQTTFSWlVrOVlkclFiemtxRERHbnd0alNFK2ZmR0N2SDJ0SFlqOFNFV3lD?=
 =?utf-8?B?NDQyNk4xODJ0MTdTZ00rZ3AzeUxTZk54bkdqNjNjVmpLM3pnNXJCcmg1L0Jj?=
 =?utf-8?B?RjU2UHVkZ29uWXQ4RmN2ZU1TWUpXVG5OQTFFamJNUU8vSFNVY29tNDRiTDdx?=
 =?utf-8?B?d285SGV4a2pQMHBEYjNpc3BJUWFvMlhQSHBFQm5jeGRDaTFjR09TZFFjN3F3?=
 =?utf-8?B?S1VUK2pkZUZVbDZ4cGc1N1l3WUQ3aWU5a1ZnS0F5TXBJSkdCQWxmL2lmdFpS?=
 =?utf-8?B?SG1nZUdzaGJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0t4MjlqeXZGU2N5L0ljeU9pN1k0UmZRV2N0eW81SUhVc0RIWmJDVWhqc0NG?=
 =?utf-8?B?OUZuenV6QVdueWdpRkZVTVFPME0xcEgrSFZ4MlZiYVk2WGQ4bDZjbUd6clVH?=
 =?utf-8?B?WWs5S1dmalAvOG1RYjZHLzVRUklpdStjZVBoNllVRG5tV0o2VTFWT3BFZWxo?=
 =?utf-8?B?N2lsQm1yM0RmSGtJUkROS2FFODZmN05ZY0dJYXRsN1UvMElyZHpRTUNqRUxR?=
 =?utf-8?B?anc5TzR2WlUxaURTaDZiRE1lMVdmZlpaRUJVVEJsYjI0T25hNHg3a281akkx?=
 =?utf-8?B?SDJyNmt0dlRkSElRa2xiNjJ4ZHl0cGxIQmRyMzJzVlJpZU1aMExHUENJamNv?=
 =?utf-8?B?S3BiWlZBU1UzcVhraVRnU05lbThQdFZpdnp3YldWZUhISkJnU3Y3Q0hqNiti?=
 =?utf-8?B?V00wNks3UEluRFV4Z25jbE84UWVYcUJLQURMazI2ZmQ2M1dENEVhTWNPZFFB?=
 =?utf-8?B?TnJQbWRlMUtEQnhBUWFrZWRhK3FaQ25EUEpwN2k4R1JQNVZLNVlFYkRQQ0Zj?=
 =?utf-8?B?VFJKaE1FVXdoV1g0NlIxQm9IWFJnK21jM1FHWUFYNXJPNjhLTGJzdCtIWGVp?=
 =?utf-8?B?eUZhVEtNbVhNbnF5WGZWanBmVkpWdTJOU2YwdFBVZXJsQ0l0bGFWZmJGdVRj?=
 =?utf-8?B?Sit4UjB5NktPRndpTm9GUllGaUNuSmxMcFMvYVJHQVplcjJmanozWWxTQWxo?=
 =?utf-8?B?ZnZydER6M2FPcGNIQ05heWs1YlEwUFhJdENXNEhBamNyd0hETUxRdmZDSktN?=
 =?utf-8?B?alRsRG1oTnh1VVJqQlQ3NlluRDFqMlE1SEppTmIrSGl3ZlRVeVFmNWpyNUhH?=
 =?utf-8?B?VTJXOWFxU0dDT2xTcjFpRFpxSFQ1QWJMekxwcm5LRWM1RDdYRVZLM2lhU2Vn?=
 =?utf-8?B?cVpaalRLWW54cGxPQ0UwcTJ2dm5qaGE3R1AzMlp1REhTOGRYWTFLbWFhRDNG?=
 =?utf-8?B?ZkFHU2E0SzBqbjNsc1plMjRzSDJhYklwMzJmd0VHSVM2UWI2NTJzWHJIcy8r?=
 =?utf-8?B?SjZUeTdndzdjbGFKZ3AzbnpVQVBYZEhOTWllUjFrRitoMzN6R1JMNXlEYmlO?=
 =?utf-8?B?d2lPL0c0OHdPNnF5djVDdzBFay9MZG9CZ0tWcHYwclZOOFBLNkh0dTFqNmpI?=
 =?utf-8?B?RXlpTWd4YVBDMmNWR3JmYUZyYVBaSkNCTnhvVWpoS0xPb0FmMUxjVjVvdGRN?=
 =?utf-8?B?Tyt0Qk5pT1d1dmpHNFBHTVRkRWh2OFpwVDVrMXlWV2Y3OXVHR0FPSFl4ODR3?=
 =?utf-8?B?RkczMkF4SmNTdEo5dkp0ZXVhVmd0cStZYzR3ejlROUsyWTQvSTd3eDh0N0tU?=
 =?utf-8?B?U0NueEJvSEl6RmZSanh4S3JvL0ZqWWEyWkJ0a0FRZnFGOWk3bHhNS0JJVURU?=
 =?utf-8?B?c2hwRStCUGR5RWUxR3ZKRDh0MWpaeXdDMGQyVmQ2U2pWUVBweVBTWHNCbk4x?=
 =?utf-8?B?ZjJBSXVUQ2VsaWpxbVpRbmxZa0NpZUFtMUc2WUFwa3BVZld6U2pGUDRQby9N?=
 =?utf-8?B?K05Ha3c4STdNS09BVDlickxxS0FMZFZHeENKVnZjZk50cDRrbTY2S1BvcHEx?=
 =?utf-8?B?UEhLWVJnNWVxbGIxR0QvQ1VsWmZ2NFVOS0ovQjhxdEJtZW5qL1ZFSitnNDF6?=
 =?utf-8?B?ZjBnSWoxeGtRaGt0K1BrZ2hGZWRkTEVjd0wxMjMwaThzZkE1RVN0MXB4a3F0?=
 =?utf-8?B?emxVbGt6NHRRV2VQU3FHK2xqZXAwaitGYzkwUjdrRzFCTEpjaTRFdWpwdThO?=
 =?utf-8?B?Wm5Zc0hGblZiRVR6MTI3TW9raGIxMTVEeXdkZ3JFbnpCenhMMjdjZ0ZzQWx0?=
 =?utf-8?B?eTBRZlAwS3BWRGgwTjFUaHU1aEY0ZkpIV1pNVkpYd2JXNmV6U3BqeVlRQVpF?=
 =?utf-8?B?ZzBUOWY3VkU2SXMwZk5EeGRpK3RhM1ZFU1h4ME1MTDBxME95b21TaVIvTVJu?=
 =?utf-8?B?QWwrMFJKWFU5QUdmZlVUZ1FMaE15cHFNOTJ4V29kQ1psVjNMMUxrTHdxSHN4?=
 =?utf-8?B?eGg1M2RzSFJ1WmZJbGhhQzFkY2JoeXhHZ2NNRTRYdkZnLzhrUm9TZzc2RFJT?=
 =?utf-8?B?UHNSZnlxOE1ZcEdCVUxpc21IODE3WXQ2ZnlWaEp0dHluelJNUGtoUjNjem1t?=
 =?utf-8?B?OE9YOXZVMGp4Sk5GeEMreTRHQ3FNd0V5a2lsTXVOUUtnb0hDenJsY2R2Y0NZ?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6db46c-bd38-4fe6-f1a9-08de13293461
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:14:42.8258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Dit4qu5CUlzJJp2G2lZWFc+jzXsXXs/0bUJxsqh7KiMEVDPjDU5SpKTZf0Qzy3M0NDzrMbqRc/6BktiNEO7jHoaIZIUaxerna0/ogOVTLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8564
X-OriginatorOrg: intel.com

Joe Perches wrote:
> On Fri, 2025-10-24 at 22:59 +0530, Ally Heev wrote:
> > pointers with __free attribute initialized to NULL
> > pose potential cleanup issues [1] when a function uses
> > interdependent variables with cleanup attributes
> > 
> > Link: https://docs.kernel.org/core-api/cleanup.html [1]
> > Link: https://lore.kernel.org/all/68f7b830ec21a_10e910070@dwillia2-mobl4.notmuch/
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ally Heev <allyheev@gmail.com>
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -7728,6 +7728,12 @@ sub process {
> >  			ERROR("UNINITIALIZED_PTR_WITH_FREE",
> >  			      "pointer '$1' with __free attribute should be initialized\n" . $herecurr);
> >  		}
> > +
> > +# check for pointers with __free attribute initialized to NULL
> > +		while ($line =~ /\*\s*($Ident)\s+$FreeAttribute\s*=\s*NULL\b/g) {
> > +			WARN("NULL_INITIALIZED_PTR_WITH_FREE",
> > +			      "pointer '$1' with __free attribute should be initialized to a non-NULL address\n" . $herecurr);
> > +		}
> >  	}
> 
> I think this a poor idea as almost all the instances where this
> initialization is done are fine.
> 
> And there are a lot of them.
> 
> $ git grep -P '\b__free\b.*=\s*NULL\s*;' | wc -l
> 490

That is significant. ...but you did say "almost" above. What about
moving this from WARN level to CHK level?

With that change you can add:

Acked-by: Dan Williams <dan.j.williams@intel.com>

