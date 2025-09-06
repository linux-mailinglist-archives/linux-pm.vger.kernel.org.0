Return-Path: <linux-pm+bounces-34041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96286B468F4
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 06:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7F27C7B7E
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 04:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF81267F4C;
	Sat,  6 Sep 2025 04:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJ+duB1r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693692676E9
	for <linux-pm@vger.kernel.org>; Sat,  6 Sep 2025 04:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132540; cv=fail; b=uQ9vaU0Q04YjpBilFeVvHtgRI4vK/w8F57zj31H3VwGdwpFIrBIFCrJHyz6Qn5npZ2KyocwDC7B0hORnmJqwiBgDd9DTM6FOTwO1Wi1gSe+pRKz5adCeX2qLJDW//DwSTxbeLR0Ptc5x/qYY3ygzLMUzJyMU6+7ANot6HapFSWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132540; c=relaxed/simple;
	bh=is6b5+nKc/7rBz4f6fycT0MUeyWeSKN6yPtsRosE758=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XAqB3NBGPjT7/RuMVzc1i1caq5pRVPPALE2hW+DEMiLFX0nHrCocB7+oGw92p3j3ceo6dJb+P42vcys99SwA+uHI/ims1Z9nxkT8qb4laA+CMmFz0bHq+mLnxEb8yKoBoTmFqqWzDz0SLbFADeioIz4FqsvxAulpwit3Dge4kcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJ+duB1r; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757132538; x=1788668538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=is6b5+nKc/7rBz4f6fycT0MUeyWeSKN6yPtsRosE758=;
  b=SJ+duB1rdXkTW1nLIqLLt4TEDzYRMxXuJalQC4fU8RuTYIW4Hf8xLJ+a
   gbfmb7Ie4EbB+QYsB7lqLS5ysic3sKcDoM5PNaOvt0bFfIL5wgcVuwtvc
   I2KzUNuMN/Xz8EFX9vVVAB4fbtrpG5L0hN+xXk4ulAx+CJLMLbjwHT6wk
   UvC7Tck1ExocAkTGlbFVT5Mz0K650ql1XaqbaO4smSdrBzI/fTFZZqGum
   y16pivnprY2oMZUCg6tOW1SCGrShMujeNg8XRBNsfWmnz6706XZVB0X4f
   afcRkxnZSZ3iD5M8z8h83eP38Jnq6V+kTlNO+CLVLT7xlARieVaZ2joyj
   g==;
X-CSE-ConnectionGUID: VjrPDpj9ReOZxMz4nT8K6Q==
X-CSE-MsgGUID: EvpaEi8EQqKIr9EKK/dpSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="63307310"
X-IronPort-AV: E=Sophos;i="6.18,243,1751266800"; 
   d="scan'208";a="63307310"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 21:22:17 -0700
X-CSE-ConnectionGUID: 8nfSZKfpSHezqdB3vJD6IA==
X-CSE-MsgGUID: W6nAqbKXSRCAADq8LTnP7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,243,1751266800"; 
   d="scan'208";a="173126431"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 21:22:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 21:22:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 21:22:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 21:22:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCP0gZEikxH5WoeS7dTDTp1dlH5Sm/kjaYYtyJcaGbnKhgvGG9xLIKoNLggZHeZDI7FOtuobjX7t73xAjiaTR6YCqRK6pAuCZT283Zm1rH0pdmRwssyxs+4Cmc6HbUJmQKElMoxctFfCgdS2SiQDmwiG68bPAnMOeoF6/MChJSiY1TMFJtSUDZyMiLG8hrVnQ5MGrCXql3AjiucrRlaSyaBH9x6CG+EzBZ5YxaxsOPBwB8Fm7/p31dvbomDKsMQlksvj1phh4mPVvDHigX3aMff2SV/4tRkyZeoflGG9+mPrg1SedhYnB95kHyepyLbPaap+R9P/6Gktsio8d6oywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is6b5+nKc/7rBz4f6fycT0MUeyWeSKN6yPtsRosE758=;
 b=IrE+AJDs25E1akWAkrCx2XGaBLw/CZZn1we83YwtMq0sncP0XrvW+V0rkgpyOGPiyEkvMM98hp68vj7CA1QilYcGvxC5sw6bWnjWABMP6301z2Pwxz5lQm7537EQdZMap1I82ZnhoO3v9LdZnStWI56z4U4imOdNT6kwgU+yEAQzxnnBe3OHk1fZlnjn9SBaT4FIb+CFDN+SWqoJYSD+6GsZW1v7FaH8bDcGAHss8gkJ99PEco2uSeUn69QI0bs5MrY2c5n8hpmmHIOxYBfdfuJSo3MDjgehewJWMVl4R2uNepPzkfKcDfbPPVGQyGVw+TBPMa/iXh6xzwjXZfUJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by CY8PR11MB6915.namprd11.prod.outlook.com (2603:10b6:930:59::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Sat, 6 Sep
 2025 04:22:15 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%4]) with mapi id 15.20.9094.018; Sat, 6 Sep 2025
 04:22:15 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: acpi-cpufreq: Optimize SMP calls in drv_write()
 function
Thread-Topic: [PATCH] cpufreq: acpi-cpufreq: Optimize SMP calls in drv_write()
 function
Thread-Index: AQHcHpljc79yHutZ9kCoT6dzvLk02rSFjAWg
Date: Sat, 6 Sep 2025 04:22:15 +0000
Message-ID: <LV3PR11MB8768E28D7A75ADDD9722624BF502A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250904081600.2706572-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0iBdmzD2ansm34HQhXQE+Q6_qUkjW1XC9xK_G8Aw_0ubQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iBdmzD2ansm34HQhXQE+Q6_qUkjW1XC9xK_G8Aw_0ubQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|CY8PR11MB6915:EE_
x-ms-office365-filtering-correlation-id: f67a1e48-5c2a-45c0-7132-08ddecfcf5de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QWQ1YUl2Mm42ejF6dlJHbzl5Vzd6dlFxYXo0ZnN6aStVZ04rcGwrUmZVWnJl?=
 =?utf-8?B?dE9aa3BRN1JMU1VCR0RYc1hNYzdCUUZZdmFHaG5tM3d0L2hJOVRteHNwR2Iv?=
 =?utf-8?B?T3MxVW83dEVQR3ppUzJrVXJ3VFVJakZGSFhLblh4azF6dDlHY0p2KzhzK3VO?=
 =?utf-8?B?bVdHbDlaaEM0WVRlUU9qUFY4b1hQTVd5c3ZBODNLRlV2T0QzWlVwK09zYXpN?=
 =?utf-8?B?ZG1zbGZ5OWhCN1NIKzE3YjNGNWNFUExyTTA3Q2VRZWpZZzJMQlNWSFljL25x?=
 =?utf-8?B?QTVuUkVsSjhLUUlwdThIdHR0NGFtNHY4UENDcDR2TUZGTlFGNm45eU9CVWVF?=
 =?utf-8?B?WFFXU2g2eVhVaVlqZFNqb2wwNG1RMWQwN0pYQ0pWMlZVRHFWd1E3VFIyV3hE?=
 =?utf-8?B?dUMvMG9vY2xEOGhvYkE0WTc0eTNSVVNwVWQvRzk5czJRbzdZYVA2U1NleURh?=
 =?utf-8?B?NDZOZ1lHOENvelk1aGV1WmJqekZDN2wwdTlLMW5MQXdybzRsWXYxeUF1aWt5?=
 =?utf-8?B?YU5TTVV5U2lTRkJEeDRwV3JDUVlQRkNpYUJ6NmhYTTROSDBOWU03bXdRN1g5?=
 =?utf-8?B?SG1pTDk4aFV4dTY3MGsvZ2hoanliYTNhUmRVWTd2SDhFR1ZKb2Z4aFZueFZq?=
 =?utf-8?B?TnpEbk9MZmtLOE8vd0ozczdUL0xsKzBKa0g5bGlLUWxvU1o4TVpmUU1lUlNm?=
 =?utf-8?B?bjYwcWd0UHRsQm4rMUZyV2EwaTE5eU5ROGFSR21ubHAycWhWZkJjU2VFd2s1?=
 =?utf-8?B?ekZWUlk4bWZkUXgwOTJhakpJa3F4WmpaSHhkRE4vMU9JZml4THpVZ2tUbHJq?=
 =?utf-8?B?a1lRNHFBWVZsdFh6UGV5NHk4NDNEQXZ6ZmlCYmpEL2xkU2MyRzhhZlhoZVpi?=
 =?utf-8?B?Q24xMDZwZFJzTW1SOFdKY1UyUXpVWnVRNHk3cVBrMDY0YkhqcURCbkpHNXky?=
 =?utf-8?B?N0dRR1BoMFR4MHEzTEJDcStYZ25xbmNwd1JzNEdraXRxQnJyU1I1ZHg5RExF?=
 =?utf-8?B?dUI4VllqWWxPdk8rQXBnTVEvMzl3d3M0TlVrMkZzSEJtT1krRS9lTTRxZTRH?=
 =?utf-8?B?KytYamtpdlJKQUFHcTZEOGpVWU9PTlFpNTg0U0c4TWpsSzI2UGlneVErVXgz?=
 =?utf-8?B?dDRWaER2OUNZTmNOTG5WSUJBRWZ5QUg5Tk1iUmFpTEIyZ1JPbEZyNUhMcjMr?=
 =?utf-8?B?UDJ4Z1QvdStseFJoLzBYcVI5UzY1UHgxTnIvdkovUGVXOHpxdlJqTFRyaTc4?=
 =?utf-8?B?RVlwbzRJREZmRlpyU0U1eWVySERRVlhmNnhURHduT3IrZHBOVTVGejd2Ky9I?=
 =?utf-8?B?bmFiVjloNWlMWVR5N0EyQ3cvWTlDYUVyQkEvUnJ3T3FXZDFXcEJjbk9vVWg1?=
 =?utf-8?B?d1VYRnhKT2Jram10UW5RN3AzeHcrVGVQTVV5eEZidWNCTXVjVCtScVUvbXUx?=
 =?utf-8?B?d1V0WS9FeSsxM2pzTXRMME4vRUhvZ0lyYnNvWHFQendXbWVPOWZxblBPNVFu?=
 =?utf-8?B?SHV3RU5tRXZ6TTlFTThpQmlnQmJTM0dyOW5uVlVQM21pSFpZcGNMVThHNndm?=
 =?utf-8?B?T0t2SUw0ZVJjaXZTT1Y0RU5SZ2JVNDJQNE9rS0FuMVJGbDh2NTVFVkRrYUpG?=
 =?utf-8?B?NE1BVHEyMEhCNDdPcVpFc2w4eUY3UWZhU0RGMmJnOEc5b01oNlhaZk9GN3pR?=
 =?utf-8?B?SERiVWRNMXNnaWhMVitLdVU5NkZ6dkdGVXo0VFBSNEY5akIycVFTc3d5dkJv?=
 =?utf-8?B?MXo1U2RGWktKdWhyZlg3K1lEZWNYdk50SFRubmlhVW9RdlJ1UWo2citDY1hR?=
 =?utf-8?B?dmlGREdqK0NGU3ZyRGNxeGxncVcvZ1FQK2N1SjVkeHpDRklxMU9ndWl5ZWYw?=
 =?utf-8?B?WlZmOC9vYnRIYzFmSWVSMk5uWEJkTjBKRTY4ZkdDYnVBNVplUlNraGZ1MGEx?=
 =?utf-8?B?OXh6VjBTd0pTRFgwd0wzbDQrdnZwY2RaWE5CeDJaV2g1S3BRZGwxMVlyK3hX?=
 =?utf-8?B?RkZOSmdiY0dRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTRheS9jS3haczhiSnE3bmpiTGlacGplT2pDTEdFbTNiTEVYbVVRcktEcmRh?=
 =?utf-8?B?NzlicFlMLzY1aDNkMDA3QUpOakxmVE5YZW15STBCMExKTDlGMzFydWpibS9W?=
 =?utf-8?B?UUVyTytlQ0VJZmh6WVpWWUxZU2RVbklPbUNFQUVydjhwMDFyTytlOEdCbDdx?=
 =?utf-8?B?MWpWVDh2ekNWUWk4blZaNFZMVTk5c3RwZ2hTNHBESGU1VnRNTGlGeFcwUjBL?=
 =?utf-8?B?VnRlVjlZWDhHR21LV29tZDhHNStNMGhuMEh2Q0ViMS9QZGl6eDNpQVhWWWls?=
 =?utf-8?B?TGFkbk9QSHJ2a0h4Ryt2YjI0cllHckVjK0YvUHhRWUMwRzN2UjBPQXU5Nkd0?=
 =?utf-8?B?Q1BZdXErRERGNUpCTENmOEc0QjliNDdXYnJUL2pkSTFtRmFpTEl3K2pWZHhH?=
 =?utf-8?B?Ui9KLzNoaGtUYjFBU0J5U0Y4eXFuZnZNZTdFS1kxWi9jbjcwUjYxd1cxRTBs?=
 =?utf-8?B?VmU4YjVXVEJVZUFnMng0TTVkb3V1ckd4RXM0ZFF0Um5TSWZIbkZkMjl2V1Iz?=
 =?utf-8?B?LzE3S2hReXBDc0NvMXR5WEdxNEQ5eWdaVXZuMDMvUExzVVExQmdzNy8ycmNp?=
 =?utf-8?B?NU1kdnU0YnprY0xtMVlwNzVwVFAvTnNHVlRqUzQ2MHZYRVZUU0hXNjRUR0xx?=
 =?utf-8?B?VTcwSk9BQTJyc1pzL2ZEWU8weE4yUkQyYm1SUkVHeHhPQUsvMXRCZE5PTHN1?=
 =?utf-8?B?Sm1vdTNxK2ZjS3NmTnprMWFNazhiNWJYRWViS2JwT0x3ak5FYm8yOTVLeTFX?=
 =?utf-8?B?L2paazlDSUhnSUg5UGNySDkrV05MRzhuS0djc21GWFVya1d4MkN3YnF3RUl5?=
 =?utf-8?B?b0dHd2lFUzVKWXJ4bmtKaDMyTVZxWVcyLytGR0pkVDExTG5rYkwzYURlOXVI?=
 =?utf-8?B?a1Fwa0hnYzNFSmd4Y2JPdTBYbFFvaDVFWEM0NW9QYnoycWNSS25DZ1AyVU1B?=
 =?utf-8?B?eVZZNE11dDNUMVo3RGRRZkRHNkVsK2ZkR2hFT0o1U0hOL0RaMU5RZUJYUGQ2?=
 =?utf-8?B?RGFJRXlXTk1nRmNFYXY4ODZTb3NxU1NuY2VvM3RzbURUOTI1OFdrbWNYT2Fm?=
 =?utf-8?B?S1JWN3N2SWFUdVN4cnhwdHlJZzNXMUpFZ3NuREVJeFJ1NXJYckxibEZiVlJK?=
 =?utf-8?B?YkpENWYwSmNhcnppVTlrRzlGSUhvN3NpVkp1QkNwM3NGWGwxTG1NN2J4TEgr?=
 =?utf-8?B?anNjODU1RlY4YWJHWkYwdjVRYUxRWEN5dk1RQnRkNnA1ZHA4cHlTVXVHaXRn?=
 =?utf-8?B?MkYyVUl5WFB1QlRkNU1VYVYvc3JqQ25lVzlQTU51ZlJDSW1QSVRnNjhkRzVS?=
 =?utf-8?B?Z0Zoc3hCaytEdGNia1lyOHQzWHkxNVMwMC84QkY4UjR2ZnlIZVZMN1A5QU5M?=
 =?utf-8?B?VFdHWDV3bmpzLzA2L2luRTByaVhUN29FekpabG0wdUt3V204REIrcDAzZnRN?=
 =?utf-8?B?dE8ybEd1RDZCMEU0S2JCeXlIa213Z1Vvbmh6ZVlRc29jZGlJMVRySktOOXdv?=
 =?utf-8?B?TFh6UjVXSktJdWVCMHFSMkxOV1dKNnJBTW1nOWhnTFB5Ny9jZy9kcGRZWGs5?=
 =?utf-8?B?UXRoWWJXZVFhMktFdVJZcWJ0MnFOUlk1b3JaR0ZjbzBDRkQydG05bDd1OGxD?=
 =?utf-8?B?ZzBNV3kzUjkzQllSa1ArTHA2SXVQTkxIcUpNVmF2VU9yV2kyYVBsZjFRN3Z6?=
 =?utf-8?B?N3djNzhaQnVqMDRrRUtEY1YrWmsvanZwNlFTZjJIRVYyMmxYeHp0V3M4dUY3?=
 =?utf-8?B?cFd6cDEvMWRmOVBTTXZGejVwbTNleGt3R1FBTUVHbndaK1NBbU5vKzlGckh6?=
 =?utf-8?B?L1ZvVnNJT1lXTUdIeGRHWFhqMndBRHp1SmpKbURwTjdxOEdYaEZIUG5NU3oz?=
 =?utf-8?B?b0h4aHNodmNUUDlBZzkwWm90a2tYcnZocHg1Skg3dnE2dU1GUWpzaEFKcnFn?=
 =?utf-8?B?R2d1dmRBZFNmNGxHRlljMUtSa2F2UUFPcFg3QVMxRUZJcnBYV2VxWFBXZ1Nw?=
 =?utf-8?B?SGt5V1ZNWWhod0FSeWdDK3hFdUN4Smo2eWU4YVgxdVB5OUJYMHNIVDlCZCtQ?=
 =?utf-8?B?OFlkU0UyUSsyNjNMTit1TCtZbDhjNmlTNG9pRFlmR2RBSEVpc1VRV3pFMWsx?=
 =?utf-8?B?VzZZL3Z5dW9FMXdra2IrSG9ieDFxZktTYmFDbUxPeHQzb0pUdC9ZKzFVcm92?=
 =?utf-8?B?OVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f67a1e48-5c2a-45c0-7132-08ddecfcf5de
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2025 04:22:15.7081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERyLOxrnHADbGQeO8lSniMBs5h5Q4M2DxRXp/TJulHM9MOp4vpYkla8r/sdxgAH9QhKIZ599jqhwN+mxCePOQyYq65Ok/htwJJfy4gJe52w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6915
X-OriginatorOrg: intel.com

PiBCdXQgc21wX2NhbGxfZnVuY3Rpb25fbWFueSgpIGRvZXNuJ3QgcnVuIGZ1bmMoKSBvbiB0aGUg
bG9jYWwgQ1BVLCBkb2VzIGl0Pw0KPiANCj4gU28gd2hhdCBkbyB5b3UgcmVhbGx5IGRvIGluIHRo
aXMgcGF0Y2g/DQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBmZWVkYmFjay4gSSd2ZSBleGFtaW5l
ZCB0aGUgZnVuY3Rpb24gZG9jdW1lbnRhdGlvbiBmb3Igc21wX2NhbGxfZnVuY3Rpb25fbWFueSgp
Og0KDQovKioNCiAqIHNtcF9jYWxsX2Z1bmN0aW9uX21hbnkoKTogUnVuIGEgZnVuY3Rpb24gb24g
YSBzZXQgb2YgQ1BVcy4NCiAqIEBtYXNrOiBUaGUgc2V0IG9mIGNwdXMgdG8gcnVuIG9uIChvbmx5
IHJ1bnMgb24gb25saW5lIHN1YnNldCkuDQogKiBAZnVuYzogVGhlIGZ1bmN0aW9uIHRvIHJ1bi4g
VGhpcyBtdXN0IGJlIGZhc3QgYW5kIG5vbi1ibG9ja2luZy4NCiAqIEBpbmZvOiBBbiBhcmJpdHJh
cnkgcG9pbnRlciB0byBwYXNzIHRvIHRoZSBmdW5jdGlvbi4NCiAqIEB3YWl0OiBCaXRtYXNrIHRo
YXQgY29udHJvbHMgdGhlIG9wZXJhdGlvbi4gSWYgJVNDRl9XQUlUIGlzIHNldCwgd2FpdA0KICog
ICAgICAgIChhdG9taWNhbGx5KSB1bnRpbCBmdW5jdGlvbiBoYXMgY29tcGxldGVkIG9uIG90aGVy
IENQVXMuIElmDQogKiAgICAgICAgJVNDRl9SVU5fTE9DQUwgaXMgc2V0LCB0aGUgZnVuY3Rpb24g
d2lsbCBhbHNvIGJlIHJ1biBsb2NhbGx5DQogKiAgICAgICAgaWYgdGhlIGxvY2FsIENQVSBpcyBz
ZXQgaW4gdGhlIEBjcHVtYXNrLg0KICoNCiAqIElmIEB3YWl0IGlzIHRydWUsIHRoZW4gcmV0dXJu
cyBvbmNlIEBmdW5jIGhhcyByZXR1cm5lZC4NCiAqDQogKiBZb3UgbXVzdCBub3QgY2FsbCB0aGlz
IGZ1bmN0aW9uIHdpdGggZGlzYWJsZWQgaW50ZXJydXB0cyBvciBmcm9tIGENCiAqIGhhcmR3YXJl
IGludGVycnVwdCBoYW5kbGVyIG9yIGZyb20gYSBib3R0b20gaGFsZiBoYW5kbGVyLiBQcmVlbXB0
aW9uDQogKiBtdXN0IGJlIGRpc2FibGVkIHdoZW4gY2FsbGluZyB0aGlzIGZ1bmN0aW9uLg0KICov
DQoNCkJhc2VkIG9uIHRoaXMgZG9jdW1lbnRhdGlvbiwgd2hlbiB0aGUgU0NGX1JVTl9MT0NBTCBm
bGFnIGlzIHRoZXJlIGFuZCB0aGUgY3VycmVudCBDUFUgaXMgaW4gdGhlIG1hc2ssIGl0IHdpbGwg
Z2V0IGNhbGxlZCBvbiBsb2NhbCBDUFUgYWxzby4NCg0KDQo=

