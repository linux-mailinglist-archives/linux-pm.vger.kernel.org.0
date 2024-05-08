Return-Path: <linux-pm+bounces-7621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB748BF54C
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 06:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31DA1B20325
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 04:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AE510A1B;
	Wed,  8 May 2024 04:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7qsU2bl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB18F54;
	Wed,  8 May 2024 04:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715143566; cv=fail; b=f/Hj7Gh6KpYbu1/VL1LCQ1qQvO11F2bFCDbPc8gnHqfEAyp1brLQaP5D7FqR7fIbw24F18Kx5igNUuco9m9NHc7DarVptmaoI3kWS1IiqjH+Xa8i88hZgJeTvjiw+g2H+9udd48z4ZcbmnL2Tmh8VGEeg9moXmIiSXll0jjXvdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715143566; c=relaxed/simple;
	bh=57S05LkM5qhWpFSHOVky4+JfcnazUoCyNm03LKLx8y0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qpi34tJ7cth+yg8mXwc8X9ekTQBXGcAKtp9FW0YRSSmkMI06Jr+5pVVBBDOd/hIXo5FCv32+nBQrUS9glxvZ0hrvMpd+Y/L/nreMVUMLGXLXbbxTnyI+jeccNlWDdZFBNWVilDHVlFmf7Z1NdikY47mwzG0BTsxQ1BzxtZdmWaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7qsU2bl; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715143564; x=1746679564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=57S05LkM5qhWpFSHOVky4+JfcnazUoCyNm03LKLx8y0=;
  b=Y7qsU2bl6aAqTROQf+u/CE/2T4/aacXCz3tfJUGLGLwP8Nq6/hqIKecS
   WdKHp7wf6q4/mg09X3VFu+653CPBvVhex2qFb5coQqusFJJN/OPmehBS1
   Tt/PE/uJolpk0EP1GZ8/KrQVYiOg9yZmUzqKe8KLazFqt3FkRXPgxtcA3
   6zcMs9/+IpDLkybKhlEjfRQt+l8pkZFQy84XHPKKjoqUm3JQeg+bLOwbu
   NoO0K237jJqO+SSmtPALhmrE9ZNwN5pXxtZbhCgLW12+3IUcORFeJ0Wur
   +YptemM3mcU6JMBK8v9mTmRaUqFn7HNlfaiTAIfTJkcNi1CND3fLYUOgW
   Q==;
X-CSE-ConnectionGUID: mEr+NghSQSi4GfTppc5IYw==
X-CSE-MsgGUID: WkZxNb1zQ5+/mys92xxZ7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10847750"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="10847750"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 21:46:03 -0700
X-CSE-ConnectionGUID: D6P5peKDQ6GL5b9oqwHScg==
X-CSE-MsgGUID: voL7OtttTTC5JGL24W9YTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="28807932"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 21:46:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 21:46:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 21:46:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 21:46:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXmaTzqv4ZuSnnBBe41M780zr2AUmQlhoaiKEUq6e88sRVQgIjdTcqZIud3xH8rGUcAAr1NiPa+cUXzGLSJknJhgEE8RYpkJMxY8oBHv6saYyB8EaeNZU5F2e7MHDj44oj1oSNFPV9KL9VbouBesbRRtFvFrCZDY+5AZKUglEo6imfNzmUCx00AA3rJRM2ZbI14P5dWICq5kJSuHhVuDDNB4LJSgLUFhXY4hhW0K6FLUbDuAjImMHwlpby0DIPlofwe2kan460Yc8rNJrn2KGH2qbmmmrmUr8IdOI5AtXNIrs3VndAXgH8gx5EnOtIOHyF1+txYDujWpqrivBMT3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57S05LkM5qhWpFSHOVky4+JfcnazUoCyNm03LKLx8y0=;
 b=LsbFAXkVmeEWoWAY606fv/A0JsZ0Fp6Cc7+u3SWTSIZMbb5Ae8neQFlkfmtcX6Dd3tDVuc7rHEkzHrJe+dv1sCONMeFx91z1urNwxK/pxJsEHDdhfjRxi/e77oNXtTVyAlMiHOoKvT3zqtYgZz4yQIjU1csywNzGduBaQSaOu33JyW0MRlAd3KB88i6I+9Vt7zuA2OfyYoz4spQEcKfFXB07dKNxZCWBoa378BJHoYM4nZ4wSKax/cJZ3nN1SkV0bz3OeEsaEWU2F2k6FlCZMi1eBLrbF3gU64ChnqsFj4/Wp3eeIAA2CiIKAhCkgPXq5yMpxZvCeNCW1tTK27XWJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB4944.namprd11.prod.outlook.com (2603:10b6:a03:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 04:45:59 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e620:6fe3:711c:a6bb]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e620:6fe3:711c:a6bb%5]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 04:45:59 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>
CC: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "Brown, Len" <len.brown@intel.com>,
	"stanislaw.gruszka@linux.intel.com" <stanislaw.gruszka@linux.intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Neri,
 Ricardo" <ricardo.neri@intel.com>
Subject: Re: [PATCH v2 2/4] thermal: intel: hfi: Shorten the thermal netlink
 event delay to 100ms
Thread-Topic: [PATCH v2 2/4] thermal: intel: hfi: Shorten the thermal netlink
 event delay to 100ms
Thread-Index: AQHaoPj8Ix9MhFyASUKQ5UYisCRsZrGMw0oA
Date: Wed, 8 May 2024 04:45:59 +0000
Message-ID: <32ff72ce3207460a993008d10730d077ee14969f.camel@intel.com>
References: <20240508034352.18414-1-ricardo.neri-calderon@linux.intel.com>
	 <20240508034352.18414-3-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240508034352.18414-3-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB4944:EE_
x-ms-office365-filtering-correlation-id: 8e27f943-faef-448a-8774-08dc6f19c1da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NHM0dEpBYW5mSGpGcUN3YkR5WnJUQjRZRG52WFdMcFFldTRveVBRY0JybHYr?=
 =?utf-8?B?V0kvUnVObXFLM2dOb2s0aVNnTU1XOGtYQlM0NlNHS1ljSWFmN2pXQVltUmoz?=
 =?utf-8?B?UXloNTFoR29Tc09wcS84VXVRcmo4ZU10M1VSQWo0WG5uZ0VhMWY3d0dQaFB6?=
 =?utf-8?B?MU5hMVdDMS9WVjBmc096RUE5N1ZaYWVpT045Y0FnK0VLUjVybWVybDVHM3NS?=
 =?utf-8?B?anM4dVRmZjFHalRoMjFuRXlvT1BJbHY3OVgxR3lJSXYrblA1UjlYZmJPVEJ2?=
 =?utf-8?B?dFVMKzZxZlNJZ0VXK0Myd2hPYlNYNy9NZ05JbXg4VDdZYVc0bzVvTit1Wml2?=
 =?utf-8?B?cWZVNXYvaE9DR200SFJJKzJLVmZEWlNpdnQ4d3MrZEY1SUdQa2F3RGxKU0pH?=
 =?utf-8?B?MllCR2sxcGhCVTZzQ2JWOXc3VlJTbXQyb1B1T1VsUjR2RkQ0aUs1WmdaSU94?=
 =?utf-8?B?QWt3b3dheHRYOXpuV1cxUTZDVlNIWXFxMk9STm5VMzZhaXBmaFJvQzV2RzZR?=
 =?utf-8?B?c0dxNzl5VHlodUdQUk1vSXNZSDB2dEJYWVlkdUZpZjR5MW5LbSs2M0E5K29Y?=
 =?utf-8?B?UnRRL1lQSWd3VDMvT1pqdnR0MjBRSkZOWkVKZFNsMHZOSndjVXFLMW94Y2NI?=
 =?utf-8?B?OW9nVE4zc0FRcUNPdWxpdTU3MVU5SDdOa1BjMWZvK1hnOTU1Tm9VZklMQXdL?=
 =?utf-8?B?SmxLVnFJUE9BcmNGekRaWnQvOWwzMjRxZG1Cdlhsbk95SDF1Nm14ZkZ0VlhL?=
 =?utf-8?B?SVdpOG5mZUFCQitDSXJ1NDRRYmdRLzh3b2l6ZnJSMDZ3Z3l2OXF4YnNXYVZT?=
 =?utf-8?B?Uyt3NFp4cjV4eFB0Ungxcm05Y2ZJd2NHTnF1V2RNMm1WcmMvMnRUeFJiNUJP?=
 =?utf-8?B?NVI5RytzcnQ3OFg1MWtRRGV6UnVvYXVDdWUvQjZML3JieGFUVU4vT0JFZmFO?=
 =?utf-8?B?cFhkRkd3eWFONm9CTUR1VlBtT0FPdW1JOFZ1Q1BUV1NTSHo1NkNXQ3h1bTNx?=
 =?utf-8?B?YWMybWNRTGxmWURoMFRTOTBWdTI4VVE5ZHREOVRnZ3JDMFBvaG55MlpVWktE?=
 =?utf-8?B?OEthb3AzWnFPL2lSdk90WnFQcUgwekV0TFhONHVqMWtPNmNkQlJJeG0wWWx6?=
 =?utf-8?B?aVhPeVcwOWM5QlYzMHVHaEFtejVDZGtCZVd0UDFuUmJ5YTdhTnJ1akFaY3k4?=
 =?utf-8?B?ZnJET1dUcS85Q3BJRloxWDNCdFBTTE05TTFEQjZHR3RjVEsyRUJTTHV1WlhL?=
 =?utf-8?B?NFU3U3k5ZWU2K0w0UjdSdnYvNE9CRWt0eXhVRkE4VUNrUVY0aVhHbEhOeFlr?=
 =?utf-8?B?a2MxVllYR08wWTlzelNsQ0UwR3BKVWZ2YWZPVkRZSTZobkpMeUpCeWQrUzVE?=
 =?utf-8?B?c29FRnJwc25XQmU0WVpVd0wyMlJxdXpmeHlUMmpLdlgwWnk1dkpPTDNBdFB4?=
 =?utf-8?B?ejJSYkNTakZidXFGRnpjM2RBRVJsbHdNdWExVCs2bk5DMWkvZGdWVlc0a0ts?=
 =?utf-8?B?Tmx5U2x3TG9oZTFRL0ZJRHBnVXZGVnBEb0VMRmU3YnpHSlgzdU1uUnc5dVBq?=
 =?utf-8?B?WnBnRFBtWGtUYU1OUWtkQmY0cDlCZzZwaytScGxLSlY3S2VUMXh3Qi80WXcz?=
 =?utf-8?B?Nk52dm5wU0lXRm51cDN1UnFjTmFvK09qdkdpOEt5WUkvaHM5dUxzQzl4VUtx?=
 =?utf-8?B?aWorSUJsWjlDQ2VhUHh0VjliZWVvb3UwT0lac2d5dFU3WWdBTEZhZGFENWtw?=
 =?utf-8?B?Q1lsM1VRUXU5YWs5aEwwNDlzbUFhTTZFQlY4VTRDNzJ5TWlLQ2pidGNLRWxX?=
 =?utf-8?B?T2JCdmJKbUJ3QnlhOHhBQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzRnQmE4SzRnSktObXFja3dMZHlsbXBqSm01RHZpREJ2MC82N1hZall2ME1s?=
 =?utf-8?B?UFJzR0YrK0JORDI1dVpnKzA0c0VLd3lvemVBa1dOZXNOWjRPcDFuNGY5Mm5N?=
 =?utf-8?B?VjdEUHptUnRCSnVZSTcxbkpmQzZUYVZBODNjYkoza291RjRYQXhIZ3k3VnNv?=
 =?utf-8?B?d0E1a3BmVWZ2U2FZcUk1TzFibG1xRXJFbEhYNEMvcDlGTitRK3hEWk4vZk9H?=
 =?utf-8?B?TEhyQVNRV1I4ODRnWVltRDlrczhKMWRrSXJvNGRPSU5QY25saHVNek1JM1By?=
 =?utf-8?B?UG1xdy9nU0pabk1HT09KZGVKVW43QmJydEVGZ0hHTUYvQmZmV3hiRVVaaHRT?=
 =?utf-8?B?RkY4RVN1MGpyTWpFMWFuUEVZdEZGeW45bFh6a1BIOWNRdGRLL295cy9TWXdZ?=
 =?utf-8?B?ZmNVNGdIcU9LTjRBMVVZUkxGTElMMk9qem5LTndkVGhaTWhiY1JmNGRuTmI2?=
 =?utf-8?B?NGZ3V3dBQ0hhbWhHclVtM0toZ2MrUi85ZVYwUjJxeW1NanEyeS93Y3B6aUMr?=
 =?utf-8?B?bkI5ZFpFbXkrdjYxYkh5b1RTOEVFWTNhREZHcnhPV09icldEbFM4aFF6OE5i?=
 =?utf-8?B?UG5VMDFqZUJxbzNrSjk3NUtwU0cyZFBhZStNZWFOZmxHOTlvQnhxWDhLaGMx?=
 =?utf-8?B?amt0enIxcUtRMkRwNlVrbzlDcW9OZ3pDYlFkLzZwdXlqM3c0eDFzNnVTS1Mv?=
 =?utf-8?B?ZzVsNWhtRWVzWmo1ZUhLRURBTk1jTE9SclNyZlM5TGNicDk0UXQ0clB5U01p?=
 =?utf-8?B?ZnVuS21wTmE2dnpneFB1MWJTckxrRFNZWWlwenlyZGRrSmRaMUl6bVdTdXZ0?=
 =?utf-8?B?dDJkSFowOWQ1dllmNk9ibVF5SzZHMDk5UWlIb0dPai8zSXQ0Z01CUyt5UFk4?=
 =?utf-8?B?V0dNVzRsOWxsOTJLaGVHVy9KUmRXWWNDdk5hMmFiZDZoV1JJbFkreUVsaGdi?=
 =?utf-8?B?QTg1WGs5WmhvLzVNL0t3YXdKejBSQWxQNU1QSU1oT3VUN2FzNnptbk9RcThy?=
 =?utf-8?B?ZldzdU1ySGxXNm1NNFFoTVdkMVp3UGR5cHVyYUhUdmtxb2Z3azRYVmdTWTA0?=
 =?utf-8?B?aGZDcGN1UnI2U3huYXVKYzdaVTNxNmltcCtjTzhkS1VQRmQvWVNaYWZTS0pq?=
 =?utf-8?B?eHZzQWJxYmNPaWFKZ0lLRWQ2ejN3K3hvRUVYTlZiVnlhbXNMd0tDSm5wQ254?=
 =?utf-8?B?aVVKVjRTdGNIbzhhM3JkQ1ZxZVBkWUp5YlVVWmZ1Rjl1bkRVZ0lkMjl4QmpM?=
 =?utf-8?B?dzE0dVJuRkw2R3h3cjlRd1RZd3MvOXFiZDllVG9aK0Jlb25GZWlGUXNRY1M0?=
 =?utf-8?B?YjhYdnl6TURVak9tWmdIeXlCL2dWaCsxTnNoM2pYMXRvaG1MYTFnbnY3V3BE?=
 =?utf-8?B?b0lQYnJoanJHM1oxQldQVml3c0hRNkhvdHRhSWZiUzVDT0d4QWt5VHhTMDJG?=
 =?utf-8?B?QzhzMWxlQ3pjTGhZQng2Y3B4M2xKdG42QnRPMHZoV1hFVnBuRTRvSnRrcW1k?=
 =?utf-8?B?YkJ1RVpOZDZOTS9oZWh2cjhRdHEwVTFta09ZTTI2UUZrZ2ZSRnkwVlQ0OEdB?=
 =?utf-8?B?OUtsdWVRL0VBVHUxQXJMVERsMWNvbyt1eDRYbkVwa0JVTENwd1R6QzJRd0Uw?=
 =?utf-8?B?TjhHOGl2Y3QrbzhUdjZFdEZDN28yN1pnNTYyZGk0ZGVTdVY1bTNTUEVyejBF?=
 =?utf-8?B?cUE0a3o2aS91S0dmb0lDMDQyNHNoQk5QY055NGZYalJGK1JXOWdGR05rR2tB?=
 =?utf-8?B?aW5VZENuZmMvYXFWeTBVQXNXZVBtMHdWdzBaSU5oRU1zTTA4WFB3WTBkZkZq?=
 =?utf-8?B?THJuL0FRYTNoRGlMbURWMGc2a2NvejlUN3d6YXQyeHZTSHBMcFQwU1R1WFFP?=
 =?utf-8?B?SWRvdTBmNGd1MzBvWmlpOUlJSCtKVWwvbGdlRHZ4NGFMcy9RWHY1bXdlc2F4?=
 =?utf-8?B?b3lWcUExWERlRlM4K1dtUkpnRDFwaUhHSGgyUkZSVDRKbXVFbWNpaFVpamxr?=
 =?utf-8?B?b1l6Nk83WGJlYjBpSVFyMVBVUDlqU0htQW1XOFE5MzVGUjBEL3NmZjZlNG14?=
 =?utf-8?B?R3Y5WXMzUDd1WFNaMDZsaHNnK3BHdjdVMmk1UDJKV2w2SmhyWlNpWlJZMnRk?=
 =?utf-8?B?RHpBQ2h5T0NjS0dYZ3phU3RvaXNCUWRKRXpmUDRabHJqSytFQll0QUFpZFUv?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF1717CE253A674CBA2CD8E4D3FBF3B4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e27f943-faef-448a-8774-08dc6f19c1da
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 04:45:59.6406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpBcyfs+GgZvFWDEA/n1V05zKVrwMYsbByN9uCrfKfKwhLMMlu0T9zAkVIjN2u7JaUb34Ez8U7cZnf/nSCLxrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4944
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA1LTA3IGF0IDIwOjQzIC0wNzAwLCBSaWNhcmRvIE5lcmkgd3JvdGU6DQo+
IFRoZSBkZWxheSBiZXR3ZWVuIGFuIEhGSSBpbnRlcnJ1cHQgYW5kIGl0cyBjb3JyZXNwb25kaW5n
IHRoZXJtYWwNCj4gbmV0bGluaw0KPiBldmVudCBoYXMgc28gZmFyIGJlZW4gaGFyZC1jb2RlZCB0
byBDT05GSUdfSFogamlmZmllcyAoMSBzZWNvbmQpLg0KPiBUaGlzDQo+IGRlbGF5IGlzIHRvbyBs
b25nIGZvciBoYXJkd2FyZSB0aGF0IGdlbmVyYXRlcyB1cGRhdGVzIGV2ZXJ5IHRlbnMgb2YNCj4g
bWlsbGlzZWNvbmRzLg0KPiANCj4gVGhlIEhGSSBkcml2ZXIgdXNlcyBhIGRlbGF5ZWQgd29ya3F1
ZXVlIHRvIHNlbmQgdGhlcm1hbCBuZXRsaW5rDQo+IGV2ZW50cy4gTm8NCj4gc3Vic2VxdWVudCBl
dmVudHMgd2lsbCBiZSBzZW50IGlmIHRoZXJlIGlzIHBlbmRpbmcgd29yay4NCj4gDQo+IEFzIGEg
cmVzdWx0LCBtdWNoIG9mIHRoZSBpbmZvcm1hdGlvbiBvZiBjb25zZWN1dGl2ZSBoYXJkd2FyZSB1
cGRhdGVzDQo+IHdpbGwNCj4gYmUgbG9zdCBpZiB0aGUgd29ya3F1ZXVlIGRlbGF5IGlzIHRvbyBs
b25nLiBVc2VyIHNwYWNlIGVudGl0aWVzIG1heQ0KPiBhY3Qgb24NCj4gb2Jzb2xldGUgZGF0YS4g
SWYgdGhlIGRlbGF5IGlzIHRvbyBzaG9ydCwgbXVsdGlwbGUgZXZlbnRzIG1heQ0KPiBvdmVyd2hl
bG0NCj4gbGlzdGVuZXJzLg0KPiANCj4gU2V0IHRoZSBkZWxheSB0byAxMDBtcyB0byBzdHJpa2Ug
YSBiYWxhbmNlIGJldHdlZW4gdG9vIG1hbnkgYW5kIHRvbw0KPiBmZXcNCj4gZXZlbnRzLiBVc2Ug
bWlsbGlzZWNvbmRzIGluc3RlYWQgb2YgamlmZmllcyB0byBpbXByb3ZlIHJlYWRhYmlsaXR5Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBOZXJpIDxyaWNhcmRvLm5lcmktY2FsZGVyb25A
bGludXguaW50ZWwuY29tPg0KDQpBY2tlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwu
Y29tPg0KDQotcnVpDQo+IC0tLQ0KPiBDYzogTGVuIEJyb3duIDxsZW4uYnJvd25AaW50ZWwuY29t
Pg0KPiBDYzogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5p
bnRlbC5jb20+DQo+IENjOiBTdGFuaXNsYXcgR3J1c3prYSA8c3RhbmlzbGF3LmdydXN6a2FAbGlu
dXguaW50ZWwuY29tPg0KPiBDYzogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiBD
YzogbGludXgtcG1Admdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IC0tLQ0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiDCoCogRHJvcHBlZCB0aGUgZGVi
dWdmcyBpbnRlcmZhY2UuIEluc3RlYWQsIHVwZGF0ZWQgdGhlIGRlbGF5IGZyb20gMXMNCj4gdG8N
Cj4gwqDCoCAxMDBtcy4NCj4gLS0tDQo+IMKgZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX2hm
aS5jIHwgNCArKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxf
aGZpLmMNCj4gYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfaGZpLmMNCj4gaW5kZXggZTJi
ODJkNzFhYjZiLi5kODJiODc4OGIwZjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9p
bnRlbC9pbnRlbF9oZmkuYw0KPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfaGZp
LmMNCj4gQEAgLTE2Niw3ICsxNjYsNyBAQCBzdGF0aWMgc3RydWN0IGhmaV9mZWF0dXJlcyBoZmlf
ZmVhdHVyZXM7DQo+IMKgc3RhdGljIERFRklORV9NVVRFWChoZmlfaW5zdGFuY2VfbG9jayk7DQo+
IMKgDQo+IMKgc3RhdGljIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpoZmlfdXBkYXRlc193cTsN
Cj4gLSNkZWZpbmUgSEZJX1VQREFURV9ERUxBWcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oEhaDQo+ICsjZGVmaW5lIEhGSV9VUERBVEVfREVMQVlfTVPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAxMDANCj4gwqAjZGVmaW5lIEhGSV9NQVhfVEhFUk1fTk9USUZZX0NPVU5UwqDCoMKgwqDCoDE2
DQo+IMKgDQo+IMKgc3RhdGljIHZvaWQgZ2V0X2hmaV9jYXBzKHN0cnVjdCBoZmlfaW5zdGFuY2Ug
KmhmaV9pbnN0YW5jZSwNCj4gQEAgLTMyMiw3ICszMjIsNyBAQCB2b2lkIGludGVsX2hmaV9wcm9j
ZXNzX2V2ZW50KF9fdTY0DQo+IHBrZ190aGVybV9zdGF0dXNfbXNyX3ZhbCkNCj4gwqDCoMKgwqDC
oMKgwqDCoHJhd19zcGluX3VubG9jaygmaGZpX2luc3RhbmNlLT5ldmVudF9sb2NrKTsNCj4gwqAN
Cj4gwqDCoMKgwqDCoMKgwqDCoHF1ZXVlX2RlbGF5ZWRfd29yayhoZmlfdXBkYXRlc193cSwgJmhm
aV9pbnN0YW5jZS0NCj4gPnVwZGF0ZV93b3JrLA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSEZJX1VQREFURV9ERUxBWSk7DQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtc2Vjc190b19qaWZm
aWVzKEhGSV9VUERBVEVfREVMQVlfTVMpKTsNCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGljIHZvaWQg
aW5pdF9oZmlfY3B1X2luZGV4KHN0cnVjdCBoZmlfY3B1X2luZm8gKmluZm8pDQoNCg==

