Return-Path: <linux-pm+bounces-28135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B790ACE848
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 04:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BCA3A9006
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 02:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C611C84BD;
	Thu,  5 Jun 2025 02:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cuhs1V5e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A684E1C;
	Thu,  5 Jun 2025 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749089893; cv=fail; b=Fp6dCVKeOvp7r08b2r6JZsMqJWBT80LviqCXzpyIVWg1GOh8vHIYBPUVI0IQnFiOFckEUMEDs7sBrHhFfgFLYHLyuLPKt8HdKkNMuqWeYCceltkcb/HyyUT8ntgy626LyEcjBCuA15A/VwXxGJ8fh3sVl5pX337MfnAi7NNtgow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749089893; c=relaxed/simple;
	bh=9UsSveDyRLmIwE4zYZE4qY8s1KKIbnV7AL903pSZlzU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cT0DAAlPtk5N+kKwqMCPs9mFIXh8kLoA5A8bk9r5j1nn8AQtydR9WEnLWYojumREDlGphQJIaigIXc2ZkHTZyQZDOoDUU8k5kb4QMt6WbqNoTsGVTipSi9835OcU3dvwoIcYTirOfLe/pqxpq4YX9vAGptwoEX30Tem6tmUiDqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cuhs1V5e; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749089892; x=1780625892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9UsSveDyRLmIwE4zYZE4qY8s1KKIbnV7AL903pSZlzU=;
  b=cuhs1V5ed5I+cYBB8ThB6E3kmmT6uwwVE/Sb6HG654ltqqUJugfYWFQn
   2f2OUIEaZoKzAl5a7epo17M2bLErgRh9sTtxGYdrWwtzN/gO69gwqjVsU
   PVzykl22VgOUaO1RDNTBBU1cT6MOkloCACdE1kgDZpZGc9fs1lC6dYo9F
   MQH62xTZxJJNmbqW02YKwTvGXdgLh6JhnXigikLXioCdp7QixzFtYneGf
   98cVARkZIEsq1p1oqoCLWqxJZ3O/b/TTnXd55Awx0SATMKgNLxSI47dV1
   Y3rH4tyA8SGrSnaHG4XgE8oYcBs8T76memgFLA0uypnJt4AkYchjEiI62
   A==;
X-CSE-ConnectionGUID: rPJxN/0uQlGMZl7H8w1B7A==
X-CSE-MsgGUID: xgi1zvxASu+eurif72/E5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51340308"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="51340308"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 19:18:11 -0700
X-CSE-ConnectionGUID: xnBmXO8ER2mCwIrGRtjW6w==
X-CSE-MsgGUID: zmmblAnATouDamS5h2Uq3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="150518301"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 19:18:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 19:18:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 19:18:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 19:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAvY7JDyhyk0gkej7SCVBt8TDwkpuk9cjHfESAUCbyjnkyHOuclbqggSvSR7xLBjb2BvtxCGlV90uPbbxHKu18FEf+WhmOsBtrvR/Wck5NMwhsasmN2ai7welsjC/od/cldiUwBTlz43LPb6tvM9Z3ZiugfnNRjXgP0R0C91Muwn27Z7iG4Mzn9tlFBR1Gz/Yx/H+/0DRFObDHBHDoBj3hRS7MezAmEog/FeogFfaNeZBmLGfnR1c5oPhCROs7gdT7Y3/mg86MTlV/bCgzuNokM4BhXNbGrzobTIGZKRrnoI3vo1j6fmJiZbSkOtu1zuZwXEkno1TtBYUGI3CuJQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UsSveDyRLmIwE4zYZE4qY8s1KKIbnV7AL903pSZlzU=;
 b=QURbkSmY7O2qy3HJEGNk5foQFYH0Hk6Mmb+lBo4WKXjA0LasSIfGCVWehpdVF88YNvObSJQF/JYX3LxfILdag9WVN4OYc4E43RAiGtzxG6ygj1yzy3NT0SJyiDaVBzZjLPa5GGum+eCS/fyfIMep5f7p+y+oV9o70yroUiF/617UN9VjZTKCPD04tyXOBhvHD5EDdD7QWxM9yqHPMdcvK7QXVXsf9wDLDkEDek7OER78VSEH9luTGIMU8nUqHh1fJl6pNRd59OOzOLqainpDhAIroGUlj38IHdUKuesHsE2tLJ5vSW4jDT8lsizjhHYBuSreqM2nzDEinpmpvjBjVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by PH0PR11MB4917.namprd11.prod.outlook.com (2603:10b6:510:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Thu, 5 Jun
 2025 02:18:08 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8769.029; Thu, 5 Jun 2025
 02:18:07 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] thermal: intel: int340x: Allow temperature override
Thread-Topic: [PATCH 2/2] thermal: intel: int340x: Allow temperature override
Thread-Index: AQHb1ZA3JL2mYo8Ib068GOxg2oxm8LPz1QOA
Date: Thu, 5 Jun 2025 02:18:07 +0000
Message-ID: <545fae8be782943a92d9df1c4a3ff90b7a865c76.camel@intel.com>
References: <20250604203518.2330533-1-srinivas.pandruvada@linux.intel.com>
	 <20250604203518.2330533-2-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250604203518.2330533-2-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|PH0PR11MB4917:EE_
x-ms-office365-filtering-correlation-id: 892a590d-dc5e-45b5-3497-08dda3d73631
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y1dOQVlxakwvb1d1V0czWWVOdzN6VTBLR2pueUFSZEtVKzdHTzJBd0dZaUxP?=
 =?utf-8?B?N1N5WGlyb3g1OG93ZzI3Qmlrdzhidm5VYVIvU0JEZkZYQ1FiTFVkOWxxRjhK?=
 =?utf-8?B?UGdPblFSK2NmbGFkZ2dwbnRmeDFVZlJ2NDhMQzUwYkF0cXFrYTlIRHpCS0Fq?=
 =?utf-8?B?QlVmWmxHS1JBT01vejM4ck5RTmRQdzZEY3RzbnF4c1UxUjJ2Tks1cElYNDJM?=
 =?utf-8?B?SDZzMjI4ekQ0OEltWEFjcExxRVNTeE42YmFGNDJxZTlFZ3dEYWtuN1p2c3I5?=
 =?utf-8?B?RTlxNk93Zy9ZdFdMSkI5ODNmY3pGUEhjRENpc2NkL1ZaTDlVWDBPMTZmT0Yw?=
 =?utf-8?B?TXErUHgzM3ZpODM5V24wbXZjVGdNeEREUDkyVlRudEdOZFkwdC82YjRVOHdF?=
 =?utf-8?B?UFVZWnlzczVyWmpNVzk0T3ZJUHp3NmpXRmxZNGlrU0pvblRFb20zbmVGZ2xk?=
 =?utf-8?B?SGJvNWdKb0czaWJRTXM0TS9IaFRrTVJOaXRXcVdLWCtiQWpsMkc4ZXpBUGlT?=
 =?utf-8?B?MVBwaVNpdXhDLytVeFZmVTIyUSt5VEFlSXk1b2hUMW81Zm1ORFBNTGlQckll?=
 =?utf-8?B?aFg1K1hSaTRGOFJmcnJ1OW4rVThMSXArVmhSR2VDejRtZElBNVZUWis1YVZL?=
 =?utf-8?B?aHlFV0lEUU5FekVtQm8rU0tFQjlsRVFWTHpDTnJEbU8xdnNYNUJteW9uZndI?=
 =?utf-8?B?TU9XbkpPUHFpQm5mOHZnUzFmTHZTelhuSkQ4blZjZ00xWjA5WVd1cVU1aitS?=
 =?utf-8?B?d0YxdFg4dnBIbUt6TjFNdXJuVjY5RHJSVitqMmpERk1TTUVpenlzelhWK25v?=
 =?utf-8?B?bUZ0aS9JMDBsdE5zOGdlTXcvT1UrQU9XUDhpWTg3NTlMaG9XeStzZ2Vla0hL?=
 =?utf-8?B?RjRVcjNoSzcybDVJVlpsejQyYjJjMlBMM3huK04vaWg4aFhPaHlMUEwzemcv?=
 =?utf-8?B?c3hIa0M0TVRtYk1zOXo4cWNIVXZIRXYrRlJIVEtOM1N1TkR4TDg4UENjZ0hX?=
 =?utf-8?B?bHNCYzFMOXFoajR6YTI4UGJKVHlCSlFGU0wyS0dGQ1dSbjNsYWpHZGVMd1Bo?=
 =?utf-8?B?MVhmdHpvSU1pOTFNemwrSTdYaUgxV24rbDd6UHQ3eWRHRjhTRmRKMkErTEdl?=
 =?utf-8?B?Qi9BWmRYd0pRajFibnNlTmtxcVAyMmE5eUpOR1pkT1ZXd3hQVVUzei9tbFhm?=
 =?utf-8?B?MTBuUEM5c2RDZFFENHVzSzY1QlBpcFViS3FqWFkxaWFrN1NWVGZNd1UwU0V6?=
 =?utf-8?B?R1pOejF1VnFSVUppaU9jWDBaZWhUNTVlOGpHeTJEUjRYQTVCbDFLTHRhTGxq?=
 =?utf-8?B?dERxQUhMU0IyYk1NZVh2aWxHM1R0dms5Q2d4ZDc0M3k3alcrR1NheUZWTHFQ?=
 =?utf-8?B?TDJBNGVML040SnpVZkIwY1NWb0VBNHc3ZlIxdW9WVlQvN1hXdjJFR3hiK0Z3?=
 =?utf-8?B?TUE3SmhtbEdFN1NVcnBYSEUyM3RMUkxOTVV1ek5wc2JEaVdiTjdiR2k1TVZs?=
 =?utf-8?B?eTBUcit3TWM3T0czcXk4alUvbVJsZkZvSm8waGlmZ1JLSVdhKzJBcy9UYWFH?=
 =?utf-8?B?Wlh2Z1V6UXNncmZZY1dCcjZ3Z3dNb2pWc2VnZnRnT3lXa083azMwb093SUhQ?=
 =?utf-8?B?cTVEZGxidXFVbUxLTWlnWEIvQXRLK2psTE0xeU05TGJzVmh1VnMydmpnOEhw?=
 =?utf-8?B?dlJNZFpvOHR5RGUyZzB4UndPaUhsU3lXWmkyeFhkYVI2c2ZqM1NpNzB3ditw?=
 =?utf-8?B?Q0w4Rm5tOFV5T3dLVmVTTnJDRW9Jb0tqaitvT3R5VXk3OVBteUQzeWkyaGZz?=
 =?utf-8?B?b1AwZDNGWm02NWRRNnFpZ09MSzBPNUllTnJPWTBmOUMxN1NSN3YzWmNpb2Fv?=
 =?utf-8?B?VGcvbjRnWG96NTVyY2lUZmxncmpOdjBZZnh2eFhMVnY4bVp4aHJ3VU5HVXVK?=
 =?utf-8?B?alcxZ2N6eWJyVURTcVBqUm0yRU1oL0NCb3R5dGRCRUpYRGs5RTFXbE5BVDND?=
 =?utf-8?B?L3U4KzhGVEVBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVVQWFVlMHBieGJDa2ZTZFoycHVYSklRZkxnekt0b3FZNGhVZENKd3I1c2NO?=
 =?utf-8?B?R0ZIZnB5bVNXSXgwQVRZcVV2U2VTWFNmZkxTUFNOZWxSc3dCQjNjWUxYTzIy?=
 =?utf-8?B?VVFqaDBpcmlVSHYyY2RQU1l1MkR4WFhSbzZ1ZlJFOVFtNGEyaG1WMElGNGVt?=
 =?utf-8?B?eC9wbXFPQ1p3SzZFMXlyN2ZidXcwTFphbHBzR2Z6TUluNVJGR0VwR2RqMEFI?=
 =?utf-8?B?dEd0TUl2SWo4Z1FEWnA5MnlXNjdQbmRYZnhqNHlIanI3aEJYWEFDN2tlb3pn?=
 =?utf-8?B?ZXV0VmtQaGQ4NFBGM2FUdkxkRzNDMjdFbnRjVHVVSUNOZitKaHp3RGxJYWxx?=
 =?utf-8?B?L1owT2xsTktIVzd0VDd6WTBoMHFMWHFsSGdka0JNUUEwdWQyZ1NncVZ4ZVhZ?=
 =?utf-8?B?eVNEWmdtYVVvem1YYWNWNHhqWHJOMnZVMHF2aWhobVhYU1hJcGR4QStuMjlF?=
 =?utf-8?B?TEQyRTZmcThYdEdsOFA5U3lkMmt0RUxLWHY4YXh4VGtlN3RtYkxPY2JRZVI3?=
 =?utf-8?B?WDAzQndZR2RSajhTMDZnempmZkdTZDFpK0k2U0hsVzhHUEhSR3YreXkxaldT?=
 =?utf-8?B?VnJoVEhTSzNnZ0ZRTnIwT1c5YUJ4QzZXL3ZWc2NqWFhudktQaHA1UFQrVnpX?=
 =?utf-8?B?ZmtKaTFpbDFSakJ1SEZBUTVnL2xFYWlsbWdYR2JZRGMrcjB6QXNrc0I0VFBp?=
 =?utf-8?B?Q05RVkN6YlM0UzJHNERwakRCWHIrdk5pVi84dlFVSWZBZk9rb2MzUVJZbUM2?=
 =?utf-8?B?eVRod1B2aDV2cTZYZnkrc3h1ajhmQjZhOVA0NnJRbXRWeC9WQ3lWWmswcmNm?=
 =?utf-8?B?SnhQdG10SEx3YkFPY3Q1T2ZBUTEzd3lUM0h2ZW9XSjlmTmpWUkpNVXI2d3VU?=
 =?utf-8?B?bG8rc3BxcmFuZVdiRE5OTTY0RFpVSjRhYkx1ZGN6Y05qVkhJZ0ovUnNxVW5V?=
 =?utf-8?B?YlcxRU5Xa1MxTHZ3UVlUTTRIMm16MTNVOEZPOWF0WGhRdDBXbVhZWFpYeElh?=
 =?utf-8?B?U09hbHd0Z3M3Z3hvcFo4NHJKRlg2VVRYWkZDT0hlRDM5RkZCNDUvVmUyZXN6?=
 =?utf-8?B?cWo0eExSK3NhanJEbjVueTVXNjhKRGpvRWJ1aW0yL1JQOWdRSUJnZGZNT0lh?=
 =?utf-8?B?eDYzQklwaEdQRmJHS015L2ZxSUlFSGFQSndwQjZHak1jbmxpTnRBNkVEaW0x?=
 =?utf-8?B?ZlI0a1dXTEt0bCs2bC9zMnRFbUV6RzBaVndhd1dxNlE1SGxVQTlxbTNkaDNV?=
 =?utf-8?B?cmJERmtSZ3pTekJweTdxbWh5cnczTVZ6NU10SHc2aVRvUXB6Q0VHZGxpdTUw?=
 =?utf-8?B?Vys5THhpZ0RTYVFjbi96Zkpxb3dxYytnZXIzOERFendGaTNOTjg2bmFteXNT?=
 =?utf-8?B?bzZsYmdpZ0ZGNXdCQ2FrT255N2EvcTEzSHoyNU1xWHBiblRpdDZseHVRMUtE?=
 =?utf-8?B?MWw3cFlvNDN1UEtIZUF3Mkc1VEZnNWNYR2lPNTVwR1AyTUxLdU5ZZUJ2N1Rm?=
 =?utf-8?B?ZUw0THI3K3lwYTRqSTZITHEyaVJYSDlnQmYxZGRFSndZdFZkTG5IalI3Zm52?=
 =?utf-8?B?NkZsQklxQTJ1ODBJbXpKK2F2KytpekVvYVdPcFhweUxpSzYrMUlyUVJXOXNn?=
 =?utf-8?B?WGhYRm10R0E1eGpuc3hxbEhkcVBrcWtMSzVSdTI0U2ttNk5qWGx1MjBxeTJk?=
 =?utf-8?B?NFJRZ2MxUzFwNkpEUTVCRHBEYVprQ3M2TjdDQXdHbFR3OGNOb1ZtN1kvSEYy?=
 =?utf-8?B?Z3ZnWVZzaFl0amhtVWtHeFUrbWJOdUFvYnZzQklpQjUxZHJQV3JYdU5ZSEI0?=
 =?utf-8?B?WW9scTdiUENocllxZnloY2Z5Nzk2SDNydGxSV2Nqd0NrK1JZUmdFblpQR2Nz?=
 =?utf-8?B?aXh5bXNxUFBPaEdBQXc1WWZxTFFLWGNVNWYydndIWE1Nc0MxanoweUNzSWRJ?=
 =?utf-8?B?NE5hTDVGNThsZEdQL1RWNS81U0tINnBpQ3Y0Q1VHRStHU3grZytmRFJadUF2?=
 =?utf-8?B?cGpJUUliRlhLKzVEc0ZtY25ldkVZZHBNbVYzUkpJd3F1WTJmR0NCNjNFQVcz?=
 =?utf-8?B?UmhDYlFwc1Fya21QTStZSFZ1bytmdzJKSWJLNEEwQkZwU0dRbmNyVVVKaE9w?=
 =?utf-8?B?MDBsL3ZJK2dFeEorZFcxdmpURkMxWXB3eW05NHZBOVBTWEQ1Tkw2K2EzOHY5?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66E430D2ACA1D746A37A2863456A75A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892a590d-dc5e-45b5-3497-08dda3d73631
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 02:18:07.8612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N0DEfvpkUSIkveHZYPl5PziDQ9RSsx4do+PwbyyFeKOZ25AAGxVLUoee1oeRtVcJn2W8w1DxwNV2Is6enu7L7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4917
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA2LTA0IGF0IDEzOjM1IC0wNzAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdy
b3RlOg0KPiBBZGQgZGVidWdmcyBpbnRlcmZhY2UgdG8gb3ZlcnJpZGUgaGFyZHdhcmUgcHJvdmlk
ZSB0ZW1wZXJhdHVyZS4gVGhpcw0KPiBpbnRlcmZhY2UgY2FuIGJlIHVzZWQgcHJpbWFyaWx5IGZv
ciBkZWJ1Zy4gQWx0ZXJuYXRpdmVseSB0aGlzIGNhbg0KPiBiZSBhbHNvIHVzZWQgdG8gdXNlIGhh
cmR3YXJlIGNvbnRyb2wgbG9vcHMgdG8gbWFuYWdlIHRlbXBlcmF0dXJlIGZvcg0KPiB2aXJ0dWFs
IHNlbnNvcnMuIFZpcnR1YWwgc2Vuc29ycyBhcmUgc29mdCBzZW5zb3JzIGNyZWF0ZWQgYnkga2Vy
bmVsLw0KPiB1c2VyIHNwYWNlIGFnZ3JlZ2F0aW5nIG90aGVyIHNlbnNvcnMuDQo+IA0KPiBUaGVy
ZSBhcmUgdGhyZWUgYXR0cmlidXRlcyB0byBvdmVycmlkZSB0aGUgbWF4aW11bSB0aHJlZSBpbnN0
YW5jZXMgb2YNCj4gcGxhdGZvcm0gdGVtcGVyYXR1cmUgY29udHJvbC4NCj4gL3N5cy9rZXJuZWwv
ZGVidWcvcGxhZnRmb3JtX3RlbXBlcmF0dXJlX2NvbnRyb2wvDQo+IOKUnOKUgOKUgCB0ZW1wZXJh
dHVyZV8wDQo+IOKUnOKUgOKUgCB0ZW1wZXJhdHVyZV8xDQo+IOKUlOKUgOKUgCB0ZW1wZXJhdHVy
ZV8yDQo+IA0KPiBUaGVzZSBhcmUgd3JpdGUgb25seSBhdHRyaWJ1dGVzIHJlcXVpcmVzIGFkbWlu
IHByaXZpbGVnZS4gQW55IHZhbHVlDQo+IGdyZWF0ZXIgdGhhbiAwLCB3aWxsIG92ZXJyaWRlIHRo
ZSB0ZW1wZXJhdHVyZS4gQSB2YWx1ZSBvZiAwIHdpbGwNCj4gc3RvcCBvdmVycmlkaW5nIHRoZSB0
ZW1wZXJhdHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzIFBhbmRydXZhZGENCj4g
PHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gwqAuLi4vcGxh
dGZvcm1fdGVtcGVyYXR1cmVfY29udHJvbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDY0ICsr
KysrKysrKysrKysrKysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJt
YWwvcGxhdGZvcm1fdGVtcGVyYXR1cmVfY29udHJvbC5jDQo+IGIvZHJpdmVycy90aGVybWFsL2lu
dGVsL2ludDM0MHhfdGhlcm1hbC9wbGF0Zm9ybV90ZW1wZXJhdHVyZV9jb250cm9sLmMNCj4gaW5k
ZXggNmNkMDU3ODNhNTJkLi41ZGNmZDJjYzkwODIgMTAwNjQ0DQo+IC0tLQ0KPiBhL2RyaXZlcnMv
dGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcGxhdGZvcm1fdGVtcGVyYXR1cmVfY29udHJv
bC5jDQo+ICsrKw0KPiBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcGxh
dGZvcm1fdGVtcGVyYXR1cmVfY29udHJvbC5jDQo+IEBAIC0zOCw2ICszOCw3IEBADQo+IMKgDQo+
IMKgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiDCoCNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4NCj4gKyNpbmNsdWRlIDxsaW51eC9kZWJ1Z2ZzLmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L3Bj
aS5oPg0KPiDCoCNpbmNsdWRlICJwcm9jZXNzb3JfdGhlcm1hbF9kZXZpY2UuaCINCj4gwqANCj4g
QEAgLTUzLDYgKzU0LDcgQEAgc3RydWN0IG1taW9fcmVnIHsNCj4gwqANCj4gwqBzdHJ1Y3QgcHRj
X2RhdGEgew0KPiDCoAl1MzIgb2Zmc2V0Ow0KPiArCXN0cnVjdCBwY2lfZGV2ICpwZGV2Ow0KPiDC
oAlzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIHB0Y19hdHRyX2dyb3VwOw0KPiDCoAlzdHJ1Y3QgYXR0
cmlidXRlICpwdGNfYXR0cnNbUFRDX01BWF9BVFRSU107DQo+IMKgCXN0cnVjdCBkZXZpY2VfYXR0
cmlidXRlIHRlbXBlcmF0dXJlX3RhcmdldF9hdHRyOw0KPiBAQCAtMjIyLDYgKzIyNCw2MyBAQCBz
dGF0aWMgaW50IHB0Y19jcmVhdGVfZ3JvdXBzKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPiBpbnQg
aW5zdGFuY2UsIHN0cnVjdCBwdGNfZGF0YQ0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMgc3RydWN0
IHB0Y19kYXRhIHB0Y19pbnN0YW5jZVtQVENfTUFYX0lOU1RBTkNFU107DQo+ICtzdGF0aWMgc3Ry
dWN0IGRlbnRyeSAqcHRjX2RlYnVnZnM7DQo+ICsNCj4gKyNkZWZpbmUgUFRDX1RFTVBfT1ZFUlJJ
REVfRU5BQkxFX0lOREVYCTQNCj4gKyNkZWZpbmUgUFRDX1RFTVBfT1ZFUlJJREVfSU5ERVgJCTUN
Cj4gKw0KPiArc3RhdGljIHNzaXplX3QgcHRjX3RlbXBlcmF0dXJlX3dyaXRlKHN0cnVjdCBmaWxl
ICpmaWxlLCBjb25zdCBjaGFyDQo+IF9fdXNlciAqZGF0YSwNCj4gKwkJCQnCoMKgwqDCoCBzaXpl
X3QgY291bnQsIGxvZmZfdCAqcHBvcykNCj4gK3sNCj4gKwlzdHJ1Y3QgcHRjX2RhdGEgKnB0Y19p
bnN0YW5jZSA9IGZpbGUtPnByaXZhdGVfZGF0YTsNCj4gKwlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9
IHB0Y19pbnN0YW5jZS0+cGRldjsNCj4gKwljaGFyIGJ1ZlszMl07DQo+ICsJc3NpemVfdCBsZW47
DQo+ICsJdTMyIHZhbHVlOw0KPiArDQo+ICsJbGVuID0gbWluKGNvdW50LCBzaXplb2YoYnVmKSAt
IDEpOw0KPiArCWlmIChjb3B5X2Zyb21fdXNlcihidWYsIGRhdGEsIGxlbikpDQo+ICsJCXJldHVy
biAtRUZBVUxUOw0KPiArDQo+ICsJYnVmW2xlbl0gPSAnXDAnOw0KPiArCWlmIChrc3RydG91aW50
KGJ1ZiwgMCwgJnZhbHVlKSkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKwlpZiAocHRj
X21taW9fcmVnc1tQVENfVEVNUF9PVkVSUklERV9JTkRFWF0udW5pdHMpDQo+ICsJCXZhbHVlIC89
IHB0Y19tbWlvX3JlZ3NbUFRDX1RFTVBfT1ZFUlJJREVfSU5ERVhdLnVuaXRzOw0KPiArDQo+ICsJ
aWYgKHZhbHVlID4gcHRjX21taW9fcmVnc1tQVENfVEVNUF9PVkVSUklERV9JTkRFWF0ubWFzaykN
Cj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKwlpZiAoIXZhbHVlKSB7DQo+ICsJCXB0Y19t
bWlvX3dyaXRlKHBkZXYsIHB0Y19pbnN0YW5jZS0+b2Zmc2V0LA0KPiBQVENfVEVNUF9PVkVSUklE
RV9FTkFCTEVfSU5ERVgsIDApOw0KPiArCX0gZWxzZSB7DQo+ICsJCXB0Y19tbWlvX3dyaXRlKHBk
ZXYsIHB0Y19pbnN0YW5jZS0+b2Zmc2V0LA0KPiBQVENfVEVNUF9PVkVSUklERV9JTkRFWCwgdmFs
dWUpOw0KPiArCQlwdGNfbW1pb193cml0ZShwZGV2LCBwdGNfaW5zdGFuY2UtPm9mZnNldCwNCj4g
UFRDX1RFTVBfT1ZFUlJJREVfRU5BQkxFX0lOREVYLCAxKTsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1
cm4gY291bnQ7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRp
b25zIHB0Y19mb3BzID0gew0KPiArCS5vcGVuID0gc2ltcGxlX29wZW4sDQo+ICsJLndyaXRlID0g
cHRjX3RlbXBlcmF0dXJlX3dyaXRlLA0KPiArCS5sbHNlZWsgPSBnZW5lcmljX2ZpbGVfbGxzZWVr
LA0KPiArfTsNCj4gKw0KPiArc3RhdGljIHZvaWQgcHRjX2NyZWF0ZV9kZWJ1Z2ZzKHZvaWQpDQo+
ICt7DQo+ICsJcHRjX2RlYnVnZnMgPQ0KPiBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoInBsYWZ0Zm9ybV90
ZW1wZXJhdHVyZV9jb250cm9sIiwgTlVMTCk7DQoNCnMvcGxhdGZvcm0vcGxhZnRmb3JtDQoNCkFu
ZCBzYW1lIGluIHRoZSBjaGFuZ2Vsb2cuDQoNCj4gKw0KPiArCWRlYnVnZnNfY3JlYXRlX2ZpbGUo
InRlbXBlcmF0dXJlXzAiLMKgIDAyMDAsIHB0Y19kZWJ1Z2ZzLMKgDQo+ICZwdGNfaW5zdGFuY2Vb
MF0sICZwdGNfZm9wcyk7DQo+ICsJZGVidWdmc19jcmVhdGVfZmlsZSgidGVtcGVyYXR1cmVfMSIs
wqAgMDIwMCwgcHRjX2RlYnVnZnMswqANCj4gJnB0Y19pbnN0YW5jZVsxXSwgJnB0Y19mb3BzKTsN
Cj4gKwlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJ0ZW1wZXJhdHVyZV8yIizCoCAwMjAwLCBwdGNfZGVi
dWdmcyzCoA0KPiAmcHRjX2luc3RhbmNlWzJdLCAmcHRjX2ZvcHMpOw0KPiArfQ0KPiArDQo+ICtz
dGF0aWMgdm9pZCBwdGNfZGVsZXRlX2RlYnVnZnModm9pZCkNCj4gK3sNCj4gKwlkZWJ1Z2ZzX3Jl
bW92ZV9yZWN1cnNpdmUocHRjX2RlYnVnZnMpOw0KPiArfQ0KPiDCoA0KPiDCoGludCBwcm9jX3Ro
ZXJtYWxfcHRjX2FkZChzdHJ1Y3QgcGNpX2RldiAqcGRldiwgc3RydWN0DQo+IHByb2NfdGhlcm1h
bF9kZXZpY2UgKnByb2NfcHJpdikNCj4gwqB7DQo+IEBAIC0yMzAsMTAgKzI4OSwxMyBAQCBpbnQg
cHJvY190aGVybWFsX3B0Y19hZGQoc3RydWN0IHBjaV9kZXYgKnBkZXYsDQo+IHN0cnVjdCBwcm9j
X3RoZXJtYWxfZGV2aWNlICpwcm9jXw0KPiDCoA0KPiDCoAkJZm9yIChpID0gMDsgaSA8IFBUQ19N
QVhfSU5TVEFOQ0VTOyBpKyspIHsNCj4gwqAJCQlwdGNfaW5zdGFuY2VbaV0ub2Zmc2V0ID0gcHRj
X29mZnNldHNbaV07DQo+ICsJCQlwdGNfaW5zdGFuY2VbaV0ucGRldiA9IHBkZXY7DQo+IMKgCQkJ
cHRjX2NyZWF0ZV9ncm91cHMocGRldiwgaSwgJnB0Y19pbnN0YW5jZVtpXSk7DQo+IMKgCQl9DQo+
IMKgCX0NCj4gwqANCj4gKwlwdGNfY3JlYXRlX2RlYnVnZnMoKTsNCj4gKw0KDQpzaG91bGQgd2Ug
Y3JlYXRlIHRoZSBkZWJ1Z2ZzIG9ubHkgd2hlbiBQUk9DX1RIRVJNQUxfRkVBVFVSRV9QVEMgaXMg
c2V0Pw0KDQo+IMKgCXJldHVybiAwOw0KPiDCoH0NCj4gwqBFWFBPUlRfU1lNQk9MX0dQTChwcm9j
X3RoZXJtYWxfcHRjX2FkZCk7DQo+IEBAIC0yNDgsNiArMzEwLDggQEAgdm9pZCBwcm9jX3RoZXJt
YWxfcHRjX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gwqAJCWZvciAoaSA9IDA7IGkg
PCBQVENfTUFYX0lOU1RBTkNFUzsgaSsrKQ0KPiDCoAkJCXN5c2ZzX3JlbW92ZV9ncm91cCgmcGRl
di0+ZGV2LmtvYmosDQo+ICZwdGNfaW5zdGFuY2VbaV0ucHRjX2F0dHJfZ3JvdXApOw0KPiDCoAl9
DQo+ICsNCj4gKwlwdGNfZGVsZXRlX2RlYnVnZnMoKTsNCg0KZGl0dG8uDQoNCnRoYW5rcywNCnJ1
aQ0K

