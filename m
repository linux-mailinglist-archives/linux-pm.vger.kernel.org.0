Return-Path: <linux-pm+bounces-28765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20F5ADA542
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 02:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0E516D49A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 00:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845F1E4AB;
	Mon, 16 Jun 2025 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkCGAudQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2464AA31;
	Mon, 16 Jun 2025 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750034821; cv=fail; b=AgTImpeKASnhGagEZL5MJZuOQeHs6ROYYUBQ1g+FLJ89IXV7pit6ND1/x/uOiw7vwWltjaXeirWpAjNcalgHqxSQrIxg4h/XVuCLZpe5RKoqKxY+zm25TZQ/zojFnmXnutyPbp/zpEeFlj0cAF0L2sqKDvHTlxbpRc8bD7kjJyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750034821; c=relaxed/simple;
	bh=kuES6xIlVeKdYtK/x97nna1jHVEJ1OEb0QAeJNMUIhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UM+eaFzx0siELfv7dzU1UO40ifsKVO/0EyF9XM8vT2m5toODJol2XdL5W9iDOVGs4F07GYctoVDjCsFBzK5oiYF15mXJx/0PliCuNBaBsvIjp1ILc7TKmzvggRBFCu2J1ZfT/gf/WBJndWq1CeE91sCtqbJbxZBLVdYqQnFRhcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkCGAudQ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750034819; x=1781570819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kuES6xIlVeKdYtK/x97nna1jHVEJ1OEb0QAeJNMUIhE=;
  b=HkCGAudQ3mK3uG5+LEpVragR0j4VCRSJYQWQOBV2Q05MqO5YlG0/uuTD
   n58EfYRWyh6rf3hNHSslQIB3zrqaAN1eAOKUe3tn0Y0jmL2ynCEJQH3aI
   Tf5p/N7RO60/mTxvKRsZ8810rk4ihjRUBZkd96aG0ZXzhRLrqTpPWjjty
   wdIgJ2kIEC91fgtO4likfV6Gy3cBlpH4gUDGMOk4Rg9Fzle0C5s3oC676
   1oyVKGnnuLtSWZ2PMTFTMDZYx/qKmjhoniHtMxWwJSZaitDtFaqd666Qb
   cXb4r5+VdSkLKaE6NPxR0wbKec7eGckTl32O9bG2serCON1td69RfWogV
   w==;
X-CSE-ConnectionGUID: Gr3IKQ5SQoiuzbi1V1Qp/A==
X-CSE-MsgGUID: 2oEA5u7UR++Sm5u8puXnCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52306893"
X-IronPort-AV: E=Sophos;i="6.16,239,1744095600"; 
   d="scan'208";a="52306893"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 17:46:58 -0700
X-CSE-ConnectionGUID: xkl/vyRERPysB9K1TCkcDA==
X-CSE-MsgGUID: jPDNOtTQTn6v93sVifSmUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,239,1744095600"; 
   d="scan'208";a="148313258"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 17:46:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 17:46:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 15 Jun 2025 17:46:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 17:46:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sE0CPFrrk/zh1N+Wxbie7pCnFclsV1Y3+EpSYN7SQSSHvhk6fzuQC12WW7WkS71u+VeT9wKyYAVJsltAZu2zTwDa4nUfkaIFn6tDqWfgWCFL6zp73vWPr0UB3j/79++hZdWL6yfu0fYsEv7f8mQzCT+tofEuIgs3pT4i8vfqMGwIJsZXpuBPa5QBT32C6bXSHVKyhlYpWJkTqHuvn1gt/kxUkOEUn3YAtQbVztiIBxrvrADGKGIWm5sGJJADDvL7XC4/+zro3VwFU8M42V11jaZhkAWP47uyI3jT57GhVQOCdRvk0RJ7f4gbYb3miPSZNJCymWXfyfWPHk/LkRljxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuES6xIlVeKdYtK/x97nna1jHVEJ1OEb0QAeJNMUIhE=;
 b=tWDDs1klT2pxfwgcDVOW+odKSl1OXwKQj9mFdFstVpojvXGv0YD4gaPbKnU6hjTljenYzlRoIymrgzhDLMZV3kSNrT+V89iRUxaSZ9wW/ux67HbnqXXLp7D4+unbvfVyAPQhsNhaeuUhQm3CSmqbOVKh2cWIIV2qcNXsdp3YtC8gys99QGjdqMH/K1tJ33JGaJ5OjhqtUiK6eI9P7zQfupyD/lqWsHpO8Sf8a1hImtm2n337ps4NL6W3hBitNRVANg6oCEnKrJmTp90o71xhSKYtg76wZpnDMYosbgz3byECfyAhN7zLj4v3tGhabUJkTjba+4zsJ+ap+YZANsNSFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by DM4PR11MB6528.namprd11.prod.outlook.com (2603:10b6:8:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Mon, 16 Jun
 2025 00:46:55 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8813.024; Mon, 16 Jun 2025
 00:46:55 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] thermal: intel: int340x: Add throttling control
 interface to PTC
Thread-Topic: [PATCH v2 1/2] thermal: intel: int340x: Add throttling control
 interface to PTC
Thread-Index: AQHb3K0NOEa34VG5f0WGQ3Cs10feLrQE9vOA
Date: Mon, 16 Jun 2025 00:46:55 +0000
Message-ID: <0dc5ad78ecd3e9a692c50ffb860bb1b0f93fef39.camel@intel.com>
References: <20250613214923.2910397-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250613214923.2910397-1-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|DM4PR11MB6528:EE_
x-ms-office365-filtering-correlation-id: 9dffb3f7-1aed-497e-ec85-08ddac6f4ad9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MTQ1M0x6VVdBdVlVRUg5MkRvU0RpUmhsYXJ0QXNtVjJUbW9Bai9WKzJxSUZ2?=
 =?utf-8?B?d3Y1c3lOZ2k2MExtR1lSQlo3bW1wd2JZckF3bjdhd0gyMUlJRzFMTEE2cXRZ?=
 =?utf-8?B?eGczdEprVkNKVWJvQ0ZkMDdIczhydUNwbEVRaTFnWkdOQjBma2g4MFczdHlR?=
 =?utf-8?B?aDZRbGsvakVzaitiRUZTL29rZUFyVyt6TzJUKy9TZHVpKyswYnhORFdnSXlP?=
 =?utf-8?B?WkNWditHMGpabmYvYUFwRU1ZazVBRW1hS0hDWjNzWVhLbEx2c2ZQenJUaC9u?=
 =?utf-8?B?MWVSY1hOdzZHMFlxbXZHV05COUNXZ2JhV3lOMUZnMzVlN1p6WWFVVDN1WEQ2?=
 =?utf-8?B?bzA5RUNuVGVwaWxFb3dMRE1vSEhuVndaMEIva0M0UWFJSjVnVFVFYkI5NHVt?=
 =?utf-8?B?V3N5WEpFZXJqYjAxQTNDbngzMXUzaUFxa2tidjFzTStYN2xaSWgxSlU3NHpO?=
 =?utf-8?B?Rlk3RTg4WTJ1NlFLS0Q5OG5JWnNTRVlaYldJV2NPOWpxaGdqTWRVZEc4TkZm?=
 =?utf-8?B?SXMyQzEwcnJVcTFXRGlNOU85Mk1wU0pPaHQ3SkFTQ2NzRUFwODFFS1VqUi9S?=
 =?utf-8?B?dmNvYVd3aHVjNUpSektEMjl1SnlSNG9FeS9LZmZmVU1hZldMbGhLa1NJeUdU?=
 =?utf-8?B?dXZZbnhsWTc4V2tXRytyeE5mY01PanN4eWZxcFR5clNsNmtvTjM4bnliT3FJ?=
 =?utf-8?B?RzZLNVlUcWI1bmw2bCtnaEhnR1hIV2lxbnlvYmp0ZGU0djNZNnBSOTU4RGNK?=
 =?utf-8?B?WDhXZHAzdGxScEY0bDN6eDZ2ZmV4eFFsZDZwNUtUb3pwaVpWa1YvUEVUMitX?=
 =?utf-8?B?VGZjTTBNZDYvK1dtVGFrVXJIVkpQTDJ0eUUzWi9mbVd3K0RHY0ZGTFUvakFs?=
 =?utf-8?B?RUh2ZkdaUHdrcGJKV0tERVFRQmRlWUZrVythbGE5aHp2UFZNZTViRkhqS1du?=
 =?utf-8?B?ajBwekhWN2c4KytHM0NlRVVRelAzWjFuVVl1b0txblhvaTdwNXRPck5YOUFl?=
 =?utf-8?B?elU2Y1VNMWFQeldIeE4rZDZQZDhWbVYrOGdvMVVZczJjVWJrdEI1d3RYT0Zk?=
 =?utf-8?B?UXlWVWRPTU1vUWNja0VVeXk5Tk03MnpHam1wK2p1MFA5NG1oQTFEZUQ1NU14?=
 =?utf-8?B?ZjJ2NnoxUWtaRUVNVFpHSG1qcG5tT0x4R3FsQ2tsdEVhZk1JWHZmUngzMFZB?=
 =?utf-8?B?ZFZIY3dnaVhHOG5RWnh1ZDVBTFQwZW9oTWVYeFNVSTBMSEJmMkxOQzNaUVYv?=
 =?utf-8?B?d3pNenoyS1ZJL3Frb3NyMEI3SnZTc0ROM2hHRkRFOVBKK2dGNGF4NExkODU5?=
 =?utf-8?B?M3YvQVRaSHRvVnhyQjdhWU9oaFZOK0o1WkNXRlNybHNlSEJXc2dySE1JZWhN?=
 =?utf-8?B?N2JMTnowbkkrWjJwOTI2L25HVVJqd0VmK1Q3THdna3Q3TDRZQ056aWZPTXFp?=
 =?utf-8?B?Tm13U0dXOHAzRFlBMG9RYThvdk9yZ1UrNlRnN2JIMzREUkwvUGZmaHBCbnJM?=
 =?utf-8?B?MVAxS25wRE9xckhQZnZMUzdsaEhReHJzRG1ITkNocEJqQUl0WlhoOGpNL25q?=
 =?utf-8?B?WHJuZHlKTXhtaW4wazllenVEZkVYYmtWd251bFJlTzdudEd1bnpzVjdtc2RH?=
 =?utf-8?B?YXMwUlhLQ2tuSkVzWXhpOTZ2WGJFYUppWUNCNzdpZk1USWNCMmx1S3ZLSTRE?=
 =?utf-8?B?V0dBYUNTV2lrZ1JxRERsaVBZZEw4eHJnNkZOa0pkQjNTcE9MYm8xcS9jU2py?=
 =?utf-8?B?c05tTTFqWTJib2pRcEpCNU9TTWl0MklhMk56VkZqbGRucDA2U0lwb3BTc2h4?=
 =?utf-8?B?UjA4Q0pYT1FlbzhVNVRVTjJEbGgwdmRtcVZRek9BRUE2Q09GQnJ2bElFUlFo?=
 =?utf-8?B?eDNlY1FjNk40UlIzSkhxUHBvUjg3d0J1ZFVIRi9uS0MzMjlMMklFTVJoZVFY?=
 =?utf-8?B?TUUvcVZCazV3MGJrQTVoZFg4UnUrYk9nVlNTdjNuUHZ2NjAzcDVreEliQkpV?=
 =?utf-8?B?Y0lFc2RhOWd3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGZyOTVUWWVGQjRHS2xrZHp3Zkhqd1dSMlNLNmhCdThZbVJBVjlLaFpXZGFV?=
 =?utf-8?B?dERjWEFLYVU2ck1qalZHYlJpclJXeGh1OUdSMW9OblpLdEV5azdERGdVdFJx?=
 =?utf-8?B?NkNnMkcxc2pod0YwNGhGWnNENmhXdzhSSVdQUGZGdGFlZDVOUGFaNzRQMTFE?=
 =?utf-8?B?UG1nZXdjVUlBYjNGdjJBSEdxaW1ybjhCSm9DcEI4SUZ5ZXFiQytXMk5YQTFF?=
 =?utf-8?B?ZmJkSWhITmRNOTFFVEk3dDhuTkMzNXVJWEcyTGZJNlJaYkRTd01JLzFMaHpD?=
 =?utf-8?B?VkZMQUVvVmY2aDBSa2tDMmdLOFlrZ1Y4NkxrcFNpUUFsTTZaMnlDQ2dXL2JU?=
 =?utf-8?B?ZWc4UXh5U3NCY1l5M0gxYjAyT2ltZ3p5aHl2clh2a0trU28vWVFQeFU0NUlV?=
 =?utf-8?B?dzVBZnhRcjJmNDhEMEk0YnJTQytTRzRkNkpaaW5YSU5xN0trVDV5ckRGTzYv?=
 =?utf-8?B?ejF5TWhxc3pZQnVaOXlVeld4VHFMMjJYRkcyRFpoZGNtNUl0RGZ3R0RCbmV5?=
 =?utf-8?B?S3RpWnpaZHhuaGFmUDNTOStqeVhnMEVhUTVFR2Q4S1lISGp6eU1pV01rVzJi?=
 =?utf-8?B?WldmbHRhSFdPUWwvRmc0Qy9YMCtOU2s4bjQ0SUM2cGlxL3JFaHBLTE9HbWRH?=
 =?utf-8?B?Q1JCcHFDWVhCdWx0d3dVS3FVQnEwMGdyTVBHUEpLb28vekFBbVU3VitYYmdV?=
 =?utf-8?B?SVkvandFenNlTHlLSFcyRTZDMTNORis5UUxMdTF4YXVtcnpmaEx1aDVWdXpX?=
 =?utf-8?B?Y0pzcnd1Z24rRHdOVFNiUW1tcnNqNURCVUxiVkJTT3VSSElyNk5Nb2YzMU0w?=
 =?utf-8?B?aTJ2T1dqdW1aVE4rTkpqNVAyK0N6QXhhUkRWWXJjbzA5aklkbDFRYWZWaXpH?=
 =?utf-8?B?cHJ3dzVGRHJSdHJEcVp2UU9GcitpU3pUbTZvK1QxMkNoUk93dXAxclo4ZkEw?=
 =?utf-8?B?ZHMyZngrdk1EZkRldlZZTk5LTHVmbFRzK2FISHNkV3hOZVZRWHRNRTRPamNO?=
 =?utf-8?B?WEJmakdOL3NBS0FlSWJ0V0M0cEkvWFdIVjFnZElHTUpXL0hIQlBPYVdiZ3ZE?=
 =?utf-8?B?djVjYXE4VHE1c1ZpaEtETmc3bDhHdU1lUUxJZjZrM1o2Lzk2ZThlSlNYbHJl?=
 =?utf-8?B?T0M0akxKbGlQRldNaWNPSlhVeGJhRmkrRVVqUVRPTURIMC9qVXZuT3diM05S?=
 =?utf-8?B?a1dwMDVHVG5nb2kxS0JjK3BiS3huLytGVm54MjRKUnV4VHZsR2wzeDFJbUda?=
 =?utf-8?B?WldxYTlvSzRmUU9Qb0tYZVdlTDJENjZhT0tTUFBUZ01yTjN0NTc0ZWhaa2V2?=
 =?utf-8?B?RzlWdEY2UTZyUkE4Tm1pNmxaamtWQk1UOHltWDJtemtYSk1KbGxuRzdFR3kw?=
 =?utf-8?B?czdXUEVzODhyVE0zZkRUems4V1JYTFZ1WmVyTW1mV0R2OUV2V0s1ME94TkU1?=
 =?utf-8?B?T005WVlLZWEyYWZEK2g2NVFZMWV4TFdPZmRqYU5SWklGTlZRcDFJMUQ1Yjg0?=
 =?utf-8?B?QmJibnYveUtMa3I2a0U1RzU5NGw5M2VNN1BzYnZrQ1RVQ3JHWmZuWUVSZmdr?=
 =?utf-8?B?ZnNOMnhUaXpOOEJWNmgrYnZFTlZydTl0cU1hWmZES2txL3BLcTNTNldTQTA5?=
 =?utf-8?B?cU4ybVRWK3N2Mmh4ckFKaVlnK3JPNGQwdmMxeU0vVHpycHYrVzE4dmM2bzFp?=
 =?utf-8?B?SHFiaXdjZ09NU1c1M0dtSkM4emt3NVdqcEZzdFZDek5mbGxOTGRvOGtwR2wz?=
 =?utf-8?B?SzRONlJBWmF6alVLSVRHdm1FcVlZTmNPY29Tb2hBcytYREhqV01ZbnF5aWRX?=
 =?utf-8?B?WEpFb0I5emExZDBUcXE4RWdjbjdtRVRvWUZKVWIxbjdNTWhBS1J6cDBIck5K?=
 =?utf-8?B?VzZhOUw5SnhRSjd2c0J0YWdRVmhiQzYyTHZ3S3lGbjdJYW90aVdMY2E0aC8z?=
 =?utf-8?B?emV2YWtOcEtwZkhneVFSZU0yRzJWeTQyWm1CVHUvT0FXbGhUdDF2TVMwNDB4?=
 =?utf-8?B?QkxFazdUL3BLMm1xa0I3NWU1YUdqNnhLUzVKYnhkcEFlVEp0QjlLemxsQ1o0?=
 =?utf-8?B?SE1SYlQxOTIxUjRIOXZhTnQ5aUpVdEhaWDRMNFAyaGtFamNENUtNb0NOL0JL?=
 =?utf-8?Q?PigDpJMGhChl/ZGtbKFCk9Jwe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0AB6F8EA822C34B8D517306868B138B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dffb3f7-1aed-497e-ec85-08ddac6f4ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 00:46:55.3139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYACAqifA2B60FULV+vhwOmE7QtoWqvMPGmOzKBGvnCDeayx4yPLOkkiwcXwGin+mkq9ZuRcBesuKippBD4D8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6528
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA2LTEzIGF0IDE0OjQ5IC0wNzAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdy
b3RlOg0KPiBGaXJtd2FyZS1iYXNlZCB0aGVybWFsIHRlbXBlcmF0dXJlIGNvbnRyb2wgbG9vcHMg
bWF5IGFnZ3Jlc3NpdmVseQ0KPiB0aHJvdHRsZSBwZXJmb3JtYW5jZSB0byBwcmV2ZW50IHRlbXBl
cmF0dXJlIG92ZXJzaG9vdHMgcmVsYXRpdmUgdG8gdGhlDQo+IGRlZmluZWQgdGFyZ2V0IHRlbXBl
cmF0dXJlLiBUaGlzIGNhbiBuZWdhdGl2ZWx5IGltcGFjdCBwZXJmb3JtYW5jZS4NCj4gVXNlcg0K
PiBzcGFjZSBtYXkgcHJlZmVyIHRvIHByaW9yaXRpemUgcGVyZm9ybWFuY2UsIGV2ZW4gaWYgaXQg
cmVzdWx0cyBpbg0KPiB0ZW1wZXJhdHVyZSBvdmVyc2hvb3RzIHdpdGggaW4gYWNjZXB0YWJsZSBy
YW5nZS4NCj4gDQo+IEZvciBleGFtcGxlLCB1c2VyIHNwYWNlIG1pZ2h0IHRvbGVyYXRlIHRlbXBl
cmF0dXJlIG92ZXJzaG9vdHMgd2hlbiB0aGUNCj4gZGV2aWNlIGlzIHBsYWNlZCBvbiBhIGRlc2ss
IGFzIG9wcG9zZWQgdG8gd2hlbiBpdCdzIG9uIGEgbGFwLiBUbw0KPiBhY2NvbW1vZGF0ZSBzdWNo
IHNjZW5hcmlvcywgYW4gb3B0aW9uYWwgYXR0cmlidXRlIGlzIHByb3ZpZGVkIHRvDQo+IHNwZWNp
ZnkNCj4gYSB0b2xlcmFuY2UgbGV2ZWwgZm9yIHRlbXBlcmF0dXJlIG92ZXJzaG9vdHMgd2hpbGUg
bWFpbnRhaW5pbmcNCj4gYWNjZXB0YWJsZQ0KPiBwZXJmb3JtYW5jZS4NCj4gDQo+IEF0dHJpYnV0
ZToNCj4gdGhlcm1hbF90b2xlcmFuY2U6DQoNCnllYWgsIHRoaXMgaXMgbXVjaCBiZXR0ZXIgdG8g
bWUuDQoNCj4gIFRoaXMgYXR0cmlidXRlIHJhbmdlcyBmcm9tIDAgdG8gNywgd2hlcmUgMCByZXBy
ZXNlbnRzDQo+IHRoZSBtb3N0IGFnZ3Jlc3NpdmUgY29udHJvbCB0byBhdm9pZCBhbnkgdGVtcGVy
YXR1cmUgb3ZlcnNob290cywgYW5kIDcNCj4gcmVwcmVzZW50cyBhIG1vcmUgZ3JhY2VmdWwgYXBw
cm9hY2gsIGZhdm9yaW5nIHBlcmZvcm1hbmNlIGV2ZW4gYXQgdGhlDQo+IGV4cGVuc2Ugb2YgdGVt
cGVyYXR1cmUgb3ZlcnNob290cy4NCj4gTm90ZTogVGhpcyBsZXZlbCBtYXkgbm90IHNjYWxlIGxp
bmVhcmx5LiBGb3IgZXhhbXBsZSwgYSB2YWx1ZSBvZiAzIGRvZXMNCj4gbm90DQo+IG5lY2Vzc2Fy
aWx5IGltcGx5IGEgNTAlIGltcHJvdmVtZW50IGluIHBlcmZvcm1hbmNlIGNvbXBhcmVkIHRvIGEg
dmFsdWUNCj4gb2YNCj4gMC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzIFBhbmRydXZh
ZGENCj4gPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1i
eTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KDQotcnVpDQo+IC0tLQ0KPiB2MjoN
Cj4gLSBDaGFuZ2VkIGNvbW1pdCBkZXNjcmlwdGlvbg0KPiAtIENoYW5nZSAiZ2FpbiIgdG8gInRo
ZXJtYWxfdG9sZXJhbmNlIiBhbmFsb2dvdXMgdG8gbGF0ZW5jeV90b2xlcmFuY2UuDQo+IC0gRHJv
cHBlZCAibWluX3BlcmZvcm1hbmNlIiBhdHRyaWJ1dGUgZm9yIG5leHQgcGF0Y2ggc2V0DQo+IA0K
PiDCoERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS90aGVybWFsL2ludGVsX2RwdGYucnN0wqDCoMKg
wqDCoMKgwqDCoMKgIHwgOSArKysrKysrKysNCj4gwqAuLi4vaW50ZWwvaW50MzQweF90aGVybWFs
L3BsYXRmb3JtX3RlbXBlcmF0dXJlX2NvbnRyb2wuYyB8IDggKysrKysrKy0NCj4gwqAyIGZpbGVz
IGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdGhlcm1hbC9pbnRlbF9kcHRmLnJzdA0KPiBi
L0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS90aGVybWFsL2ludGVsX2RwdGYucnN0DQo+IGluZGV4
IGVjNTc2OWFjY2FlMC4uYzUxYWM3OTNkYzA2IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RyaXZlci1hcGkvdGhlcm1hbC9pbnRlbF9kcHRmLnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RyaXZlci1hcGkvdGhlcm1hbC9pbnRlbF9kcHRmLnJzdA0KPiBAQCAtMjA2LDYgKzIwNiwxNSBA
QCBBbGwgdGhlc2UgY29udHJvbHMgbmVlZHMgYWRtaW4gcHJpdmlsZWdlIHRvDQo+IHVwZGF0ZS4N
Cj4gwqAJVXBkYXRlIGEgbmV3IHRlbXBlcmF0dXJlIHRhcmdldCBpbiBtaWxsaSBkZWdyZWUgY2Vs
c2l1cyBmb3INCj4gaGFyZHdhcmUgdG8NCj4gwqAJdXNlIGZvciB0aGUgdGVtcGVyYXR1cmUgY29u
dHJvbC4NCj4gwqANCj4gK2BgdGhlcm1hbF90b2xlcmFuY2VgYCAoUlcpDQo+ICsJVGhpcyBhdHRy
aWJ1dGUgcmFuZ2VzIGZyb20gMCB0byA3LCB3aGVyZSAwIHJlcHJlc2VudHMNCj4gKwl0aGUgbW9z
dCBhZ2dyZXNzaXZlIGNvbnRyb2wgdG8gYXZvaWQgYW55IHRlbXBlcmF0dXJlDQo+IG92ZXJzaG9v
dHMsIGFuZA0KPiArCTcgcmVwcmVzZW50cyBhIG1vcmUgZ3JhY2VmdWwgYXBwcm9hY2gsIGZhdm9y
aW5nIHBlcmZvcm1hbmNlDQo+IGV2ZW4gYXQNCj4gKwl0aGUgZXhwZW5zZSBvZiB0ZW1wZXJhdHVy
ZSBvdmVyc2hvb3RzLg0KPiArCU5vdGU6IFRoaXMgbGV2ZWwgbWF5IG5vdCBzY2FsZSBsaW5lYXJs
eS4gRm9yIGV4YW1wbGUsIGEgdmFsdWUNCj4gb2YgMyBkb2VzDQo+ICsJbm90IG5lY2Vzc2FyaWx5
IGltcGx5IGEgNTAlIGltcHJvdmVtZW50IGluIHBlcmZvcm1hbmNlDQo+IGNvbXBhcmVkIHRvIGEN
Cj4gKwl2YWx1ZSBvZiAwLg0KPiArDQo+IMKgR2l2ZW4gdGhhdCB0aGlzIGlzIHBsYXRmb3JtIHRl
bXBlcmF0dXJlIGNvbnRyb2wsIGl0IGlzIGV4cGVjdGVkIHRoYXQgYQ0KPiDCoHNpbmdsZSB1c2Vy
LWxldmVsIG1hbmFnZXIgb3ducyBhbmQgbWFuYWdlcyB0aGUgY29udHJvbHMuIElmIG11bHRpcGxl
DQo+IMKgdXNlci1sZXZlbCBzb2Z0d2FyZSBhcHBsaWNhdGlvbnMgYXR0ZW1wdCB0byB3cml0ZSBk
aWZmZXJlbnQgdGFyZ2V0cywNCj4gaXQNCj4gZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMvdGhlcm1h
bC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcGxhdGZvcm1fdGVtcGVyYXR1cmVfY29udHJvbC5jDQo+
IGIvZHJpdmVycy90aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9wbGF0Zm9ybV90ZW1wZXJh
dHVyZV9jb250cm9sLmMNCj4gaW5kZXggMmQ2NTA0NTE0ODkzLi43ODUwZTkxYTZlMmMgMTAwNjQ0
DQo+IC0tLQ0KPiBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcGxhdGZv
cm1fdGVtcGVyYXR1cmVfY29udHJvbC5jDQo+ICsrKw0KPiBiL2RyaXZlcnMvdGhlcm1hbC9pbnRl
bC9pbnQzNDB4X3RoZXJtYWwvcGxhdGZvcm1fdGVtcGVyYXR1cmVfY29udHJvbC5jDQo+IEBAIC00
OSw3ICs0OSw3IEBAIHN0cnVjdCBtbWlvX3JlZyB7DQo+IMKgfTsNCj4gwqANCj4gwqAjZGVmaW5l
IE1BWF9BVFRSX0dST1VQX05BTUVfTEVOCTMyDQo+IC0jZGVmaW5lIFBUQ19NQVhfQVRUUlMJCTMN
Cj4gKyNkZWZpbmUgUFRDX01BWF9BVFRSUwkJNA0KPiDCoA0KPiDCoHN0cnVjdCBwdGNfZGF0YSB7
DQo+IMKgCXUzMiBvZmZzZXQ7DQo+IEBAIC01Nyw2ICs1Nyw3IEBAIHN0cnVjdCBwdGNfZGF0YSB7
DQo+IMKgCXN0cnVjdCBhdHRyaWJ1dGUgKnB0Y19hdHRyc1tQVENfTUFYX0FUVFJTXTsNCj4gwqAJ
c3RydWN0IGRldmljZV9hdHRyaWJ1dGUgdGVtcGVyYXR1cmVfdGFyZ2V0X2F0dHI7DQo+IMKgCXN0
cnVjdCBkZXZpY2VfYXR0cmlidXRlIGVuYWJsZV9hdHRyOw0KPiArCXN0cnVjdCBkZXZpY2VfYXR0
cmlidXRlIHRoZXJtYWxfdG9sZXJhbmNlX2F0dHI7DQo+IMKgCWNoYXIgZ3JvdXBfbmFtZVtNQVhf
QVRUUl9HUk9VUF9OQU1FX0xFTl07DQo+IMKgfTsNCj4gwqANCj4gQEAgLTc4LDYgKzc5LDcgQEAg
c3RhdGljIHUzMiBwdGNfb2Zmc2V0c1tQVENfTUFYX0lOU1RBTkNFU10gPSB7MHg1QjIwLA0KPiAw
eDVCMjgsIDB4NUIzMH07DQo+IMKgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBwdGNfc3RyaW5n
c1tdID0gew0KPiDCoAkidGVtcGVyYXR1cmVfdGFyZ2V0IiwNCj4gwqAJImVuYWJsZSIsDQo+ICsJ
InRoZXJtYWxfdG9sZXJhbmNlIiwNCj4gwqAJTlVMTA0KPiDCoH07DQo+IMKgDQo+IEBAIC0xNzcs
NiArMTc5LDggQEAgUFRDX1NIT1codGVtcGVyYXR1cmVfdGFyZ2V0KTsNCj4gwqBQVENfU1RPUkUo
dGVtcGVyYXR1cmVfdGFyZ2V0KTsNCj4gwqBQVENfU0hPVyhlbmFibGUpOw0KPiDCoFBUQ19TVE9S
RShlbmFibGUpOw0KPiArUFRDX1NIT1codGhlcm1hbF90b2xlcmFuY2UpOw0KPiArUFRDX1NUT1JF
KHRoZXJtYWxfdG9sZXJhbmNlKTsNCj4gwqANCj4gwqAjZGVmaW5lIHB0Y19pbml0X2F0dHJpYnV0
ZShfbmFtZSlcDQo+IMKgCWRvIHtcDQo+IEBAIC0xOTMsOSArMTk3LDExIEBAIHN0YXRpYyBpbnQg
cHRjX2NyZWF0ZV9ncm91cHMoc3RydWN0IHBjaV9kZXYgKnBkZXYsDQo+IGludCBpbnN0YW5jZSwg
c3RydWN0IHB0Y19kYXRhDQo+IMKgDQo+IMKgCXB0Y19pbml0X2F0dHJpYnV0ZSh0ZW1wZXJhdHVy
ZV90YXJnZXQpOw0KPiDCoAlwdGNfaW5pdF9hdHRyaWJ1dGUoZW5hYmxlKTsNCj4gKwlwdGNfaW5p
dF9hdHRyaWJ1dGUodGhlcm1hbF90b2xlcmFuY2UpOw0KPiDCoA0KPiDCoAlkYXRhLT5wdGNfYXR0
cnNbaW5kZXgrK10gPSAmZGF0YS0NCj4gPnRlbXBlcmF0dXJlX3RhcmdldF9hdHRyLmF0dHI7DQo+
IMKgCWRhdGEtPnB0Y19hdHRyc1tpbmRleCsrXSA9ICZkYXRhLT5lbmFibGVfYXR0ci5hdHRyOw0K
PiArCWRhdGEtPnB0Y19hdHRyc1tpbmRleCsrXSA9ICZkYXRhLT50aGVybWFsX3RvbGVyYW5jZV9h
dHRyLmF0dHI7DQo+IMKgCWRhdGEtPnB0Y19hdHRyc1tpbmRleF0gPSBOVUxMOw0KPiDCoA0KPiDC
oAlzbnByaW50ZihkYXRhLT5ncm91cF9uYW1lLCBNQVhfQVRUUl9HUk9VUF9OQU1FX0xFTiwNCg0K

