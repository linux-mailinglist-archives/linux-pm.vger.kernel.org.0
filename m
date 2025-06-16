Return-Path: <linux-pm+bounces-28768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E98CADA584
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 03:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A092A16CAF6
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 01:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD2722097;
	Mon, 16 Jun 2025 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFlVytnF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC05CD531;
	Mon, 16 Jun 2025 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037455; cv=fail; b=qbUDQEPvYVQt5KfEmPHPqL8oPlslge9lKAL+Q+RR5EZOG8Vb98VlS4IYyixCSrH7SkjPMC/VQmsUGw6VxiUCYNuXhHBv3krzj1FgiURTqQzfglboDXGppuFy4qsUUBzNyAxc+rLKUtB8zaOYKqGUaYQYyU065wPm3uDCMf3PVD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037455; c=relaxed/simple;
	bh=DDRUHbXoYOhV7a0n6TtSa44AwOT/oJbkdA7KwK9Sq2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aMYUseemdgl/s+9rQ/U2iZqWsPF+o2AG7b41VuGzbFKnk/qV0YS3P4Q6EayoNTIf0AWK/7V+71vCYGuatKKsz7HAXJMm3E5J+SrHQ3CVza2+rEilCENwvBA1nsuA2LquZn7vLuTtEdr1Euc2q5nCh37PX3i32qc8IDBbi7IqFBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFlVytnF; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750037454; x=1781573454;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DDRUHbXoYOhV7a0n6TtSa44AwOT/oJbkdA7KwK9Sq2g=;
  b=oFlVytnF8Z9BqFdZ5+l72c2Zd4NouZyoDQBcqDMAEt2QI16lPMlacNcR
   t5aQL8T10d+wlUJSnm56agSyK+9/9A/27/j0SNPoBDIs80Z8AB7Gm9FCu
   DCF1tm9Ej9aX/SlN/k2JE7Yka9u776yZ4oXq2oGcaH7BLnZOwxKkqzRCw
   BKN2D6P1VXQ8z9aPi78TSur2cvHC2Ks7GDDQpPjxqMpUMsLBmOzS9QJ20
   zHbSgniffdYlXncXTQn31FRKda/+1+Pyk4bgrqWvgKCuP25KnHejIbuXs
   Aeyt3zJ2m9u4h8lbXm4RyNrKPnFr/HCGtIG2lvforgnySesYfunJi4H6E
   w==;
X-CSE-ConnectionGUID: 7W/33vI7TUePzg58qx0CtA==
X-CSE-MsgGUID: WRN2lSKHTFO9PPykX8Wrtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52153866"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52153866"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 18:30:50 -0700
X-CSE-ConnectionGUID: r7P2zfCwTJCUOKWU7YyVFA==
X-CSE-MsgGUID: DbmrlSiiRVOf9M9/INYxRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148188726"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 18:30:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 18:30:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 15 Jun 2025 18:30:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 18:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQV4DrP/Qcd8WGBZFkaGGhlrhTXndrsHfBfHFzN+E0eauYe7aX54leKVo6NljkvPPzM4q2KTJkZXcdKsGPp2GR0ucKeqiTutSezq/LUO34fIKGX6F3fnIqL1BjzVArCkhWX8P1y5pFQkBNFr/uiDOGkLdLHz3xDb3O4PLt/q6hTU7yxcjcVpz0JE0ILGluUuShigOhvsVQ8dLF1PKEbAMmMkVGL4UrB8xrCPrQaOtIiohl3OiN/osqpmxeW8vD8XrTk+Q0Rv9G64D506YNIGyjkbMhASciNTZdFtAgWFfj5weJWW36LU9LoIJZEa9c9EP2/RmygNiIx76Qbfs7OavA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDRUHbXoYOhV7a0n6TtSa44AwOT/oJbkdA7KwK9Sq2g=;
 b=yf9j9wqhRzAVa7kwj+psRUO48MOYbZlW4CqjLLJ671nW/l8h+zlZgq7D4UxsKX4UPTIR2lkaoqPcUJHx/S4hlQD9RHmQEi4xq0mblIt/YwJEYMmym72xuL5x34H8a5DQ7B0s7ehHuV+dwJ20lGB/F4yaINir2SYL7RvU0/v2MdzxLa4GGRwaX7Q0rj3zXZTYCcpm0NN4LdSomNxgx5IeXG/R6U56XKs246d770xNtT4HUiAhpqPGfaxdsthBREyJEh60gM7fEIfH0h60mcYGl+R1eHSPZ+b91HU3EECxlgbF3ik5fTSQYhEDlsgUUpgNcXG8rtz5/8iXiEQ1Ss42Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by SN7PR11MB6969.namprd11.prod.outlook.com (2603:10b6:806:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 16 Jun
 2025 01:30:25 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8813.024; Mon, 16 Jun 2025
 01:30:25 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "calvin@wbinvd.org" <calvin@wbinvd.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>
Subject: Re: [PATCH] tools/power turbostat: Fix MSRs with CONFIG_MULTIUSER=n
Thread-Topic: [PATCH] tools/power turbostat: Fix MSRs with CONFIG_MULTIUSER=n
Thread-Index: AQHb3NL2i2J5gxlD0kSQij6sbmPYl7QFAs+A
Date: Mon, 16 Jun 2025 01:30:25 +0000
Message-ID: <99f09d35e30fa335508823e9848a3365936ac9b3.camel@intel.com>
References: <81f4c402d1fda7c2419aac1148061a0789112e76.1749849645.git.calvin@wbinvd.org>
In-Reply-To: <81f4c402d1fda7c2419aac1148061a0789112e76.1749849645.git.calvin@wbinvd.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|SN7PR11MB6969:EE_
x-ms-office365-filtering-correlation-id: b85e50f4-b835-4d94-cec4-08ddac755e8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VE92OTNraFVtZ1Q4dUZ5MnhtZXpRYzlXMDV4cmhEVk5kT3NZT3plWDQwM0sv?=
 =?utf-8?B?aTV5N054am85NDVYa2xGTVl1UGY1ZkNXcGNXMjZoM2dDY05kVnNxUmtmRWdK?=
 =?utf-8?B?TlJudHhlbGJYRzkzMFhFSDhjV20ycFhVcHZEdzVaZ0J1VlNGNHBtYjgvWnpr?=
 =?utf-8?B?Y01HdXBKUmEwa1hCWGV0RWduN01wdEhFK0F0RFZtZkwxQjBTOWJ4QXU2YVpT?=
 =?utf-8?B?MHAwKzFrUno2bDM3NlZ3aENlTThJT2Jwa28zRktqamR4VUx3Q0N4V0t3VDVw?=
 =?utf-8?B?a3dhdFN3VTNXd1Z6ZVlWeGczVitMbFlpMEdlbnpaSnBMUlRzWnRWOFUyMkFN?=
 =?utf-8?B?M2gySEZCVUdyL21NNWlJVnlFTUtBbU5NSTd6S1Z6d3JLbWV6WG9UcFE0U01m?=
 =?utf-8?B?b3VZVXc2STFsaFRyOEFzbEtzQ3lEZVo3dWI2WDVOTWVzbFZVTmJ0R1Fta3Rw?=
 =?utf-8?B?dTdaYmZlcHhucFVyTFZrWi9LN3NFSWY4aXVBNldVNCtLLzhFRmJBRHI2S0RZ?=
 =?utf-8?B?NFZnejhjRTkwMjdQQTVPcEZFUU5SME0xMDQ0VUxjTUMrVVZva1o0Q3dYZ29j?=
 =?utf-8?B?eXM3Z0pMczZOTTdsTGlVYm1wZDg4SUNJMER1YjJEWkdYZGFnSmd1S1hnRjRP?=
 =?utf-8?B?RHo5d25xeENmSG5heFYwK1JOWStTQnI5ZkNaaDExSVdRYnRrbSszQXNZZDBI?=
 =?utf-8?B?MzdxcnpoT1VET3JYeklqbEloUGR0TUl4WEpCTG9Mb2NQTXNYNVhRNjJ1dmNL?=
 =?utf-8?B?MlMxQllPZEFWM3d0TGRLNkR6WVgzUzE2LzNtMUhiWU1LTm9XS3Z5Z3ZHYkZv?=
 =?utf-8?B?Zm9xUDJNZGE0UGlOZjI0NnFKNzF2VTdIRnBIUUN6VHVVQjhGL2oyS2JZbENo?=
 =?utf-8?B?V3BkK2FlRURrRXhOcUg2Qjk3QVJ2VFBKV2tETUVXVVlHV0g4dy9YSC94bGJC?=
 =?utf-8?B?R25SZmt4ckIvNDJKTkNseHlCaStlanJHdHpjR3FEekpuL2ZXdmNtRHA2bTFM?=
 =?utf-8?B?NldpL29xM3ZGYTNET0YzYXlRN3A2UVk3UlRoVC84M1hNcmJFT3JEMmdQNGt4?=
 =?utf-8?B?RnQrVnMrSzNScDE4aXRESnZoUkxteitTZDZtbTNKRDdMMWVna25WYUlzWkZt?=
 =?utf-8?B?aUI0dmxJSFVybXVuYmVJcE45THFpamhpOGpsK2xYc29KS1lXTmpJakMrT0ZX?=
 =?utf-8?B?Z3dRTVJoeTJ5VjZXR2hDcXJ2VDJ1MDk0clhHSVV1MjZSSXl1NnBySGRmMno2?=
 =?utf-8?B?TEJNWWMyK21yUXJWeGxlVmJEenlUb2VhZmhQSGNrV1NrZ1M4M3lTc1llYjZ6?=
 =?utf-8?B?VVNzK1R1dVMrVHptY3FWUTRyd2dzT0lGTGFxRys1ejZCKy9SVDRKeHRYb1dt?=
 =?utf-8?B?SWRNVlNOREhZNkFGQkthckNpeDJBdnNBK1FKOUF4Sit2YTEvc3RzYlZKQU9r?=
 =?utf-8?B?cGwxbFFvM2RFK3cwZk1XSk1vWjRpUDJlc0FyQ3l2WmlKM3ZKcW82MEloa2pm?=
 =?utf-8?B?SW5kMTgwYzhMaHlSbXZkUzZyazNoNkVUVjVMdTZobUlNS0kvUnhEdXZVU0NI?=
 =?utf-8?B?VURSbm5QTEVEdmRua3d2blpmUDBUOVRKVTdhUG42ZXYvWTR4MzBlN1N3TVc0?=
 =?utf-8?B?L3JYUU5OdmxCbUUxWTByMy9UelZsSVZjTlQ2NzlvQ0Z6OXI1MTZocllxSnYv?=
 =?utf-8?B?MWFMZXdFbEdzZmVUbUhWV2dqUlJQS3dGU1MzOUNrUWdZUmY0RG1NbGM1dTJp?=
 =?utf-8?B?eW5HWEZVQjdNM2dhRWVWOWNkekZTZkJ5RnhWZ1h3bllIS2o5d3dOYVhvYjNp?=
 =?utf-8?B?b0dvZU1jL2E4SXdteFZ4TERrd2plQ1JPbmF0cHNBSU5lb1NHVlpTbFJ1c0kx?=
 =?utf-8?B?Z1FzRW1IZGJrMG4wUlMxeVdacEEwWHpvcndueXRLT0VONDh0QTRONEYvUEh3?=
 =?utf-8?B?bjhiZ3FEZzNsWVJSYld5ZVkwUDZzaVNhcFI1NDJQNjJhL25RQVYzcGI2YkVN?=
 =?utf-8?B?YzdlME9qSE93PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnV0bjNIVzBndzN0eUQ5WVRiaXhlV01QWkVHR3FROWpybk5ybkVoRVZrNnJ5?=
 =?utf-8?B?V2dYWWdZQ3dHcTZKRTlhdHVrZmpBVkQxcTFBSGo5ODh3VTI2dDVjUzRNUnox?=
 =?utf-8?B?ZXViN0h3MEhGK3NTQnhiZjZGSmlUOHVYUzdrTHdmeldhcjN1MU1SS2E0ZXpM?=
 =?utf-8?B?c0pTaDArenlKUXROWGtUTlgwOEk4LysvT1pndWMzL3Y3dENpdjlBTmhnUERW?=
 =?utf-8?B?L3N4bEJES0hpQjdXNmVKS25IelpJbmV3alVJOVJCOTNGaGdFRTJmR3pvdGpj?=
 =?utf-8?B?Z1h1dTB5WjNpZUdiSjdYMXV6bTdIdlEwTmFEVkpseGxRc3hhazZqREp3d1Uv?=
 =?utf-8?B?cXpYWVJKRTlqZ1E4ZmV1bDNBYjY4cDJTTXJNUU1lSmVOMm1yYWRveDVUQitG?=
 =?utf-8?B?VWVXWFoxajlOSFRiK1BFQU1aQVIrWmczZk93K3pnR1J3SHVkT05KUzZDMlIv?=
 =?utf-8?B?N0t3VUZlVlRuZys5UkFaMlJScXJDZ2RzNUtJVWFwSUk0MzdTVTZiUkoyaXhG?=
 =?utf-8?B?dktjMjZLZ2NnelhZUVdxY0VpVFVraHNPS3l6RnlwTUVtaWMrVHVwVEVEeHJQ?=
 =?utf-8?B?Z1J4TTNCMjBkVlUzODlLTk9EYXh5TDdUaVdBa0F3UlpIaUJuY0x3Y3RLWTQ3?=
 =?utf-8?B?cERSWnZROTE5blZyS3FIcmlPQ0JkSlMxa0lJWlhwSXo3cVZwUEdnZnl6cEJh?=
 =?utf-8?B?WVBoTkQzY0N0bFNFRy9vNklEZ1RTSW1OY1NqOU05cU4vaDlpdFZ1ckVIM1Nq?=
 =?utf-8?B?bTE3OHNhbUhXVzhham9uSkVHd2VsSEV4dUMzRGhOUzlMOVI4dXphM3c4OFpT?=
 =?utf-8?B?TkNTMHJBV2IyQTdiWll3bTJhQUs2dloralBUR0VWTFNaT3Yram9UdG9kQjg3?=
 =?utf-8?B?bTJxb3krNVo3cWU2TWpOVDUvWHpERXdmamFjdDcwVnZ2NEVPeGJWOTYzNCtr?=
 =?utf-8?B?MFR2RlFPOWRIb0lkQWczT05oK1VzNm5ZWGZmeDBSTjlvRW5zNE9MdGpLL1Vm?=
 =?utf-8?B?dXFKSHQvVzd2TTFiaTh0RTFIM3hXY0IrTG5Celg4eEVuZEdndWJ2SnoxemJ5?=
 =?utf-8?B?NzFhMitubXdMZjE3Z0JUQUZCS1BjUC9wYjJ6U1ZDTWxhejJkOTBETTJOSjNq?=
 =?utf-8?B?UldJa0E0bDNPeFVIYWxWbTBkeW1LM2lkM2t5aDJzd0VKc2xLQUI1VlovclNm?=
 =?utf-8?B?cHJYVTRIZFIyYVNvMXZITzJTd1c5UXRHRTFhRWo0VzY4anBBSUd0UVpDd2Zx?=
 =?utf-8?B?cm5HS1lmWDZ2aFlMNEZFM3NTNHhpcUdCS3VmT1VwZVBiQWI2R2I1dG9taFdh?=
 =?utf-8?B?b1ZtVkpoaVQxMWxnMnV2bGNTOXYzdE9JVGpBbmZSK0sxakNDRzZ0bW9FQS91?=
 =?utf-8?B?RWRtYVBMbERYTU5DYnFLY29BYmlDMmljSE8xTUZQRldlQlczR2N2N1RmSitz?=
 =?utf-8?B?UHE0WUNGdmV2KzdDK084S3FPczh5aE1EK09wejBnOXo5YnZITFRGTTRKUEcv?=
 =?utf-8?B?ejVuUnZNN3grVmJ4K2g3VEYvcXJwc2ZodFdjZnppWFkzZVJHTDR6RERjNUNI?=
 =?utf-8?B?aGVBbDZ3NlVUS3BKTFlzYVgyRGYxaEp4VFpQMTBZRHhMREQxdVk1VDZNcGha?=
 =?utf-8?B?Nk1xOXBpL0dCK3ZrUDZYQXlHM1VDeU5lQkIyTENuM3UvVzFJRW9CSWJiMXJK?=
 =?utf-8?B?MVh3Y1lqZFh6UEVMbWNHMFNlVExXRWJka0lTb05TRFVXdnRSV29RVTd2SnRv?=
 =?utf-8?B?blJSaDZKM09hWHNRamR1ZXlSOHI0c2lHcWQ1VUl0ejV2K2FhUENDcXZEdzMr?=
 =?utf-8?B?ZjRzY2Z3Z1g3OU5jQ3RNSCt0WjJ0TU5Ucmptbmx6NzBJN3djRncxL3dEelJH?=
 =?utf-8?B?KzlISk9WVVRSSUozcWNjektHT0pTYmJwL1lGcE9sL1Jkd1JNWU5adlI2NWtD?=
 =?utf-8?B?alY2bFl5V1NmUi9DUFR0eHVaZjZNMVlpWmRjbGxtQkpxYXFTMm8zOGZpSVE3?=
 =?utf-8?B?bWtTQ0pSUjFiQ1IvYk1XVERPTmx6SmhuM3VJT3ZKY092aUFUQm5WZkxyYWp6?=
 =?utf-8?B?VG1SSWhHVnEzbXZyMGRRVlcwelZVMXJTYWRoU0MyZXVvaUJlWWJJUG1nUlg4?=
 =?utf-8?B?MnVidFBXbEpJY2UvY2xLaWt3VWNpZTlybkk4RzdaR2phREFGMk9hVFBXTVlW?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A59A54F081596E48A0AFDE827BDCE71A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85e50f4-b835-4d94-cec4-08ddac755e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 01:30:25.3636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7DJZrYK9WC1uhcfsARfmNzMpXuKUwhIm6tTN4oBiqKpshjFLMhxBxAbX7m3yTmJBtOlxR46CihHcfmX1rSfkbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6969
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA2LTEzIGF0IDE5OjIwIC0wNzAwLCBDYWx2aW4gT3dlbnMgd3JvdGU6DQo+
IEhhbmRsZSBFTk9TWVMgZnJvbSBjYXBfZ2V0X3Byb2MoKSBpbiBjaGVja19mb3JfY2FwX3N5c19y
YXdpbygpLCBzbw0KPiB0dXJib3N0YXQgY2FuIGRpc3BsYXkgdGVtcGVyYXR1cmVzIHdoZW4gcnVu
bmluZyBvbiBrZXJuZWxzIGNvbXBpbGVkDQo+IHdpdGhvdXQgbXVsdGl1c2VyIHN1cHBvcnQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBDYWx2aW4gT3dlbnMgPGNhbHZpbkB3YmludmQub3JnPg0KPiAt
LS0NCj4gwqB0b29scy9wb3dlci94ODYvdHVyYm9zdGF0L3R1cmJvc3RhdC5jIHwgNyArKysrKyst
DQo+IMKgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL3g4Ni90dXJib3N0YXQvdHVyYm9zdGF0LmMNCj4g
Yi90b29scy9wb3dlci94ODYvdHVyYm9zdGF0L3R1cmJvc3RhdC5jDQo+IGluZGV4IDkyNTU1NmI5
MDc3MC4uZjdkNjY1OTEzYTUyIDEwMDY0NA0KPiAtLS0gYS90b29scy9wb3dlci94ODYvdHVyYm9z
dGF0L3R1cmJvc3RhdC5jDQo+ICsrKyBiL3Rvb2xzL3Bvd2VyL3g4Ni90dXJib3N0YXQvdHVyYm9z
dGF0LmMNCj4gQEAgLTY0OTYsOCArNjQ5NiwxMyBAQCBpbnQgY2hlY2tfZm9yX2NhcF9zeXNfcmF3
aW8odm9pZCkNCj4gwqAJaW50IHJldCA9IDA7DQo+IMKgDQo+IMKgCWNhcHMgPSBjYXBfZ2V0X3By
b2MoKTsNCj4gLQlpZiAoY2FwcyA9PSBOVUxMKQ0KPiArCWlmIChjYXBzID09IE5VTEwpIHsNCj4g
KwkJLyogU3VwcG9ydCBDT05GSUdfTVVMVElVU0VSPW4gKi8NCj4gKwkJaWYgKGVycm5vID09IEVO
T1NZUykNCg0KQ2FuIHlvdSBwb2ludCBtZSB3aGVyZSB0aGlzIGtub3dsZWRnZSBjb21lcyBmcm9t
Pw0KDQpJIGRvd25sb2FkZWQgdGhlIGxpYmNhcCBzb3VyY2UgYW5kIGRpZG4ndCBzZWUgaG93IEVO
T1NZUyBpcyBzZXQuDQoNCnRoYW5rcywNCnJ1aQ0KPiArCQkJcmV0dXJuIDA7DQo+ICsNCj4gwqAJ
CXJldHVybiAxOw0KPiArCX0NCj4gwqANCj4gwqAJaWYgKGNhcF9nZXRfZmxhZyhjYXBzLCBDQVBf
U1lTX1JBV0lPLCBDQVBfRUZGRUNUSVZFLA0KPiAmY2FwX2ZsYWdfdmFsdWUpKSB7DQo+IMKgCQly
ZXQgPSAxOw0KDQo=

