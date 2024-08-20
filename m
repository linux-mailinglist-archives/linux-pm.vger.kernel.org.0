Return-Path: <linux-pm+bounces-12525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412ED957EF3
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED45C284651
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6640316CD00;
	Tue, 20 Aug 2024 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4bVVq5o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0616A39E;
	Tue, 20 Aug 2024 07:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137539; cv=fail; b=PGUS6cnHzlNtk3bdjLC+qJIUjcWRQcw+ihY2zQoDTnTVRedFGeSQpcqt1S3UYhCpeL1i3RCD6cWG6soiEQlZFbkwk8EiG4U+0LtJzVtMlu7UXNpyq07pVBL23fmDPXRYVP1+mi4XlPH6/SHSGqKQn11YQuWMWa+RHQU7vbtVyrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137539; c=relaxed/simple;
	bh=gwoSAz61A/yk3gH/aP1aNzSUin0KW6UDO3JbFFBlwp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t5aiOC5o5VfVb9wKUeY+PplaAjQIKXPCP7l4rYWEGBaVKtuhOhyqcJFPbm2mTzPpSdjn+E67LnEheRrvfgR4KcoklcbHHUJtQxytOURoeHeYXpnF67FczB4qPeKZfvJ9XLrdxSyn2SBkDsnGYb4kSJVARZdVnBa+lOBnAHMqyQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4bVVq5o; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724137537; x=1755673537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gwoSAz61A/yk3gH/aP1aNzSUin0KW6UDO3JbFFBlwp8=;
  b=a4bVVq5od6Yge1vryivFVtezjG+R+m0P/NWz4ag0TUtAy9R7XpNC1uGv
   gPnsIMWMTLr11GQrAkazBPzumTr/SkFdXw+rKxOFKO7lr/9lJ+BP9bUBJ
   91QQCWY4mKEdTuZQMhKKK4moL7EfOP0GS29wQPkpGeNw0Uz7KenTc+PeC
   BqBnnnhoBpkWTc/fjR5riOE2vC9j23Oh/pEWC2hVfIfQeDsSiybnrpX+E
   CZVNeT7BpR27eqXTmWGWW5D1aPFXACjVYr/S/VffPUKhgEZvmh6ME+vcW
   SLu//kpsFYc/RmNQfxvHemQmvJ4gqvKCvKe79HypmLn1zt4jDboOrtQzT
   A==;
X-CSE-ConnectionGUID: 1qB9pVaNS2GBhdEGlOejvA==
X-CSE-MsgGUID: zSLGQ85kTW6rzCqsppGf5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26215472"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="26215472"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:05:35 -0700
X-CSE-ConnectionGUID: rY18O1HnTF6P3jNYEw6fIg==
X-CSE-MsgGUID: yYLgUc5xQSO+PtfKakVasg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65453009"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 00:05:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:05:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 00:05:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 00:05:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5CL/zE06WuTQNVHUOLhHfHG1srA7V+jKaqC9Vw3wc682mmcCXq8Lop/YF83JZVIuChuh0kQnQ+bHhZHfchku1Xw5SiNjtyGdsNI/y7MybTBZ64VRSVxU6fFbKClPK+131Qnvy8dyIlytvKnI57hc3NGf4QTeiaPgR1nrg4fhbDk5CuBdG0b8BgFHCuHwBKrhyTr9y86MrLcJXDOSEwqJ3rgD3+V9dkbpWQYY8Sy9aQfDZYOWWNGrRhbLWnDyhM/FUvLLyNUp1zHTOvsObGn82R7rTV2p6MQvlSM4Zne+iW8Qlcr9WeX4NHjXJC+muRvEZMEWXkflMuO7vecI85jrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwoSAz61A/yk3gH/aP1aNzSUin0KW6UDO3JbFFBlwp8=;
 b=VnmNy/q3wyPwxZxrFASw+u1tDN6TvMq+Bzk21VGh9g0DrVx/Y/o8IMspGoZROgZNs6vkbgMiDsYoGxlRJT50M7mQ1+gqRvhxo93ZYm0zX734ruQrWDgpRXkBlPNH3wXNfq1Q3NjylmsjgKqUgKtzJ4AtiuzMN6611Qe4NKPa92fv2IIDCYoUc5Qa161rSNywTNCXrvZGoVZ/vt5hYBxASJaYeG1KEsEt3ME7x02W8E3MAmB6zmM7XfGQqMAfaVQQGPvUiUGKxYlMKrm8whOZQIpAAw7mFwqp0FhKS7BwOc3rNAFYRYJNXldmxy8p42WcYRUFg/UiqD3jtC9iDExm6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 07:05:32 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:05:32 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 04/14] thermal: sysfs: Use the dev argument in
 instance-related show/store
Thread-Topic: [PATCH v3 04/14] thermal: sysfs: Use the dev argument in
 instance-related show/store
Thread-Index: AQHa8lL4GLrGZ81jt0aShzXWM0W7L7IvuggA
Date: Tue, 20 Aug 2024 07:05:32 +0000
Message-ID: <132e3703d5f82379bd634712fe624764b43423aa.camel@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
	 <1987669.PYKUYFuaPT@rjwysocki.net>
In-Reply-To: <1987669.PYKUYFuaPT@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5125:EE_
x-ms-office365-filtering-correlation-id: 6e80291f-0b09-40b5-67ae-08dcc0e67b3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VzBkREQvQWJJeXlGT0N2RDRSUkVoRU54S3lVZXdCL0cwYllCVGZVY2xEeDdk?=
 =?utf-8?B?bTJwbzgyY0s0YjFjbVJkbVlTZ29TVDB2eEg0SEd0Qk9xWGlHb1ZzdG5lMnlV?=
 =?utf-8?B?TUp2QzgwRVdGZ2hFU3ZoRFRxeHAvcThlWU5FTVZ6dDJ5TXUzK1pncjkvN2lI?=
 =?utf-8?B?SDdRcGp6K2ZrQlBtQmlZdE1ZQy9FSUd5bFovU2FCNDh4REFYREFsam13VnFj?=
 =?utf-8?B?dnlzZSsyUzlHNWJ1dkhwbDlzdzh5aXZUZzdrRjEzNnBZWmVWNVFFVHErenVT?=
 =?utf-8?B?TzAwUmJpUDloSmJCR1NVeUd6aHJ2OW4zcklRYmdQS1NZSzR1SG5MOVB1VWpF?=
 =?utf-8?B?Y3dsbGtyemI1R1J4YUk1eWZIaVRXSE5IRmkzcGJKQUdQQ0dKWTVYRXJaWDF2?=
 =?utf-8?B?Qm5xZ1dSOGpJUkxBdHlvaWVPMkVlZk5VWXRIYjNzMkYxdW91WjVnajR6TDZI?=
 =?utf-8?B?em9XenRZci8xQmVoVlBReXVXcWNMbGlOTVczSWV5VXhUOWM4OXdxb0JiaXR0?=
 =?utf-8?B?LzFOZVY1NTNkOFV4UjlVSGo1aEJqOWl4YSt0aGg0Zy9nZEdhV08yUHBIdXl0?=
 =?utf-8?B?d0Eycmlkb0IrUExBSnB5TytKK0tZWGxPaGo1aU9WcnBONW5MZmlEdDlCczlG?=
 =?utf-8?B?UW9pWkxGNkI4aWQ4elpod0Q2bHQ5aTdhMWN1WFFvcE9wWWN5UTlSSFl4dDZr?=
 =?utf-8?B?M1V5ekJRaWtFdjNwYlYyN1cxVEM5cWRXN1VVK29VZ0FQTGJRRlozbnRjTGo1?=
 =?utf-8?B?QUdFTDh4NlpmdUt1K2RYTHF3WVNqaUFkMzMyRzI1R2tDRUJ0MzFBUWVpcmNl?=
 =?utf-8?B?NE5udE1tcFRZTjVOWFdhQ3hBempFbWloOElFanhWbU9rMVpKS0JpQVVsU0ZI?=
 =?utf-8?B?MUJKeFZycXFIamhPdE16cUdldExMTzBHZjJCYmk2YUcvT25COFZkSVVDWlND?=
 =?utf-8?B?b3BwMHpzN3lRM1NvM0ljVGFUWEdFendzTFRUL2hqMUhvTjZtRTNGdm1uWFNv?=
 =?utf-8?B?aXB6NDJCQTRVSEFjZnRmYnUvZ0t6K0lyVjQremVBVExhQTdHaEtMZ3pKYXpX?=
 =?utf-8?B?NElGRnRiOC91TTBzYWVlcHFzNXdtMExEVm14R0d5UHhmTkgzNzhMVUdkUnRV?=
 =?utf-8?B?aEowWlNmY2c3SEpSbEhnUmdFR2RPVXEvR3pYeCtTNlp5Mk1yZFdKYlpXeG9X?=
 =?utf-8?B?bDFWV3NOaTcwNFV2MEdaRVRTZ05qdnhBMVNWNWI0YlgzTDM5TTlYYzFFb0Rl?=
 =?utf-8?B?dm4xSkpISjVxOWwwa1lYeWQyRHJubXlYc0gycWw2eEs3WlVaNjduZGVVS0sz?=
 =?utf-8?B?UGdmNnhKakhRTGI2WWZhbVlnY2FDYU9KTVlHNEhUMGtOSm0walF1c2pEN3k0?=
 =?utf-8?B?Wm1ueDQ5V2lyaEJGNGIyWTlUTWVmRE0yU3ZJaStGRitkRzlvaHplQUU4eDVQ?=
 =?utf-8?B?aUFCWFJoU0tYTXBUcHdaNmJIMEZVbDFsZEZxbUNlZ3lFUktSeG5sNUs4ZWpG?=
 =?utf-8?B?U0FuZ0F5ZzdTR1FYVkw0aWRQcVJ3ZCtPWFpHU0k0eEFBZXJTcjg1TFFPNkJm?=
 =?utf-8?B?b09jQzdIQXZJbkxCQWxpM2IzVHFrejh5Ymw0MDB0K05DWnBtMjdGWG0yVWpr?=
 =?utf-8?B?SlZwcHhhb1hobFNOS2ZHd05EMjJ2Qk1tV2RwQVc3SkdmOU9HaWZ0Q3BoYkhI?=
 =?utf-8?B?QVdQdWd3QXB2Y1hxN3JvK1RsREF4WUFvVG1BaUYwc08raDFoT0NsWUNTN0ox?=
 =?utf-8?B?RWlFSTZ5MUtNblRRZWFYTXgwc0s4VXpVTmFkaEs4V2doSWZLdk1MdUxQTmcw?=
 =?utf-8?Q?cgb7UkyJaqIdxZ3EMv+yscHFUx/9IiISfxBuE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTlaWFRaUEIrdStkcHBnam5pUTVTcUlPejVBUHlpOVBUM0NzeUdvWXFyc1NS?=
 =?utf-8?B?blZsbUpvaDg3NFFpdTVkZGhoTmd4aGp2ZEZWYy81b1ZOSUdtVFJMSVpxZHg2?=
 =?utf-8?B?VDR5WnJ1R1hEQng2eDB4UHR0Sk1TVlZsMk9rRDJPaUQwRFJEalhPK0Z5QzFX?=
 =?utf-8?B?N04vZFJydTN6dWEvWG54NjU2djRKT201SVJzS1lOdE5sRVprOGtpZDRubkMr?=
 =?utf-8?B?c1pKUmEydTFUWVNqTFpGWmhhQ0tsZVBTUk4rQ0JlbVJtTDdZZktJRUJ2MDFW?=
 =?utf-8?B?RC9YR25PbDhUMWlvTVJJdm9wWkFHV2FVQ3hiS0QrSHV3UFgxQktGdlRIaEZa?=
 =?utf-8?B?ZC8rNnBIV0pPZE1ZaWo1MUlMYlFLT0JKSDJtVFIzSm1kS3J2bFFXbTdmYzdG?=
 =?utf-8?B?MXdIY0ZzWWNWUERNdjhkSXhET3YxcncvTnFlVkJOUjlMSkNTdkM4M0pSZDlj?=
 =?utf-8?B?UmFnRFJmRnNLOGZqL2g1TkdSRStFU0s0N2ZyZWlzNXd6Qk95VDd1YW9qdG9i?=
 =?utf-8?B?QXJvaGR5aGxYOFgrQWtFMHF1MVBxOVZCVzlPSzVCcml3N2ZJRTNqUXFPVHUz?=
 =?utf-8?B?MDFiVW5uYnNITjZDZHVkSGZTeVY1WDJ5SDR6NXMyenN6bTZocmI4dTlSTFZs?=
 =?utf-8?B?eFZkWU81b0lHamFwcDM1SkpweDRvc29YYWpvd05qZTF1WmpqQzIzdnFid3lI?=
 =?utf-8?B?U0NEVDY4OFp5Tzk5R1RZdTdZWTcwYm1WZnVEOUluMzFvczVMY2JnWi9vbDJT?=
 =?utf-8?B?Ukx3YVNIZmVTMEhxUk1OMlQ2VDNIM24rVkN4dVVZOWZxNk5xbFpraDFsaTZJ?=
 =?utf-8?B?VDVYNjIxcm1DaVZzSkhWVmtJTk9udWQ0UHZTb2QvN2NHOVFWUGVuNktVUm5z?=
 =?utf-8?B?aHNoSVhLMWJyaVM2cy9kdnNLaFVMRktMMTVzSU1XdUVseTlZRkp2ZHkrWDZT?=
 =?utf-8?B?Q21JUHk4V041TmlVUDVVYWpNTHNWQ0xZOENjTnU2NGU0MjFBQ1V3T2FMTXV4?=
 =?utf-8?B?VU5vakxVK1VrUEtHRStLSFZ2RnRvSDRibThNTlExanFwL3RwWXJ6MCtwMFB1?=
 =?utf-8?B?SjA5dGlrU0hCalIwR0JhT1B1M0t0NFgrUUwvb3JEMnNHTy9QMXloUVVOVEo5?=
 =?utf-8?B?Y1NVKzVFV2FIcnBSUGR0dllDWGhyRjlWSk1OWW5CaFBVNVBrdWx5UnBBWUFI?=
 =?utf-8?B?akJVZXVoNFk3bHJjb21rN2lPRm55b2kzd2tPTTRhSWQ2K2hvVng2ZXppVWNF?=
 =?utf-8?B?Mys2V2xKZGg0NUZZSWpDQ2tRMGk2NWFsRXRFMG1NRkdvbnFGN1NNZDVsSmRR?=
 =?utf-8?B?WmgxK0dFN2laTVR3L1VrUFpsaTVNaW1XQ0pRY3JDU2NYM1hiaWpINmVYRWpX?=
 =?utf-8?B?RFdMM2JNSlI5K0RPSGRLNUc4SmI5cGJhT1BhcEdXdU5vWGplcVNjbjU3Rms5?=
 =?utf-8?B?OEJRcHltOFRwcEsrWjZUeTd4RDVSbXlVWWtyVU1ZSlRnUzhzbFJOdVBMZTRD?=
 =?utf-8?B?bS9wN2tCWlBjb1dHcW5ibE1vbGk3SW52Z3loT2ZKdXNhVmM5SFNqK1JpVU5o?=
 =?utf-8?B?Tk1BN0hiR0ZpL0UxZFFVbFlOR3BtS09SMDdxYUZORlFBQm1IQURaL0NLVDFR?=
 =?utf-8?B?dUFVSE42R0JZZVZ6cFk2Wlh6alZnOWUvRVdjVE1XcHhnazVMOTNHOHFIVXgx?=
 =?utf-8?B?cUpoSFZ0YWJhVUZhcks0cEMxVmZ0VURJaWVqMWxzOFYzZi94aXNrUlpUOHR6?=
 =?utf-8?B?Nk9UNFRDT2ZBNE9nbTVyY3JYVGtSTUwrS2YxVkc5YWI4YmZrU1BzVklTakVR?=
 =?utf-8?B?ZHhGU0g3cjBsb2xiSTZUZ2t6WWF3Q21ZVzAzY3loMmpKZDNOUWxqcEFwcnFO?=
 =?utf-8?B?T00ydGhXZVoxSGNOcG5GcmU4dHFKTVRYQ3AvNTdLQTl6bWswWmRxYTNzTU8y?=
 =?utf-8?B?aVJtLy9SbHpHdnhGNHJvbkEvTE55cUdNOVVyWDdBdTZFb2xNYW5mQjVnWVMy?=
 =?utf-8?B?RVFmdFIzS0NaRzZqalZyZjFTMWdpSFlYRmlmS0xUWlg0ZjY1UzZQYXlXN2ty?=
 =?utf-8?B?VHFnd09VSlljK0VTNGh1WlljTlFPQTlGampxOUtORmROR1NtLzJGTXlSKzNv?=
 =?utf-8?B?MmlyLzFhT1prRmdNanVvRGhPWTdNRGlhZVpoRU0xRy9mNzZJL3JjSGowTHd2?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7578C9487D9AE499A2DC4C81BF142C4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e80291f-0b09-40b5-67ae-08dcc0e67b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 07:05:32.2241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHqNq9Zb/ZsRWMBWEEj3rWzYTXK9L6XXHQrkH4ZK4oLQqq0Rzw0D8Osl0m66Nwbr0+BiDZKyR6pVtWcoZS8nMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDE3OjU2ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gVHdvIHN5c2ZzIHNob3cvc3RvcmUgZnVuY3Rpb25zIGZvciBhdHRyaWJ1dGVzIHJl
cHJlc2VudGluZyB0aGVybWFsDQo+IGluc3RhbmNlcywgdHJpcF9wb2ludF9zaG93KCkgYW5kIHdl
aWdodF9zdG9yZSgpLCByZXRyaWV2ZSB0aGUgdGhlcm1hbA0KPiB6b25lIHBvaW50ZXIgZnJvbSB0
aGUgaW5zdGFuY2Ugb2JqZWN0IGF0IGhhbmQsIGJ1dCB0aGV5IG1heSBhbHNvIGdldA0KPiBpdCBm
cm9tIHRoZWlyIGRldiBhcmd1bWVudCwgd2hpY2ggaXMgbW9yZSBjb25zaXN0ZW50IHdpdGggd2hh
dCB0aGUNCj4gb3RoZXIgdGhlcm1hbCBzeXNmcyBmdW5jdGlvbnMgZG8sIHNvIG1ha2UgdGhlbSBk
byBzby4NCj4gDQo+IE5vIGludGVudGlvbmFsIGZ1bmN0aW9uYWwgaW1wYWN0Lg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KDQpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KDQp0aGFu
a3MsDQpydWkNCg0KPiAtLS0NCj4gDQo+IHYxIC0+IHYzOiBObyBjaGFuZ2VzIChwcmV2aW91c2x5
IFswNi8xN10pDQo+IA0KPiAtLS0NCj4gwqBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9zeXNmcy5j
IHzCoMKgIDE1ICsrKysrKystLS0tLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBJbmRleDogbGludXgtcG0vZHJpdmVycy90aGVy
bWFsL3RoZXJtYWxfc3lzZnMuYw0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IC0tLSBsaW51eC1wbS5vcmlnL2Ry
aXZlcnMvdGhlcm1hbC90aGVybWFsX3N5c2ZzLmMNCj4gKysrIGxpbnV4LXBtL2RyaXZlcnMvdGhl
cm1hbC90aGVybWFsX3N5c2ZzLmMNCj4gQEAgLTgzNiwxMyArODM2LDEyIEBAIHZvaWQgdGhlcm1h
bF9jb29saW5nX2RldmljZV9zdGF0c19yZWluaXQNCj4gwqBzc2l6ZV90DQo+IMKgdHJpcF9wb2lu
dF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIs
DQo+IGNoYXIgKmJ1ZikNCj4gwqB7DQo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCB0aGVybWFsX3pv
bmVfZGV2aWNlICp0eiA9IHRvX3RoZXJtYWxfem9uZShkZXYpOw0KPiDCoMKgwqDCoMKgwqDCoMKg
c3RydWN0IHRoZXJtYWxfaW5zdGFuY2UgKmluc3RhbmNlOw0KPiDCoA0KPiAtwqDCoMKgwqDCoMKg
wqBpbnN0YW5jZSA9DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250YWluZXJfb2YoYXR0ciwg
c3RydWN0IHRoZXJtYWxfaW5zdGFuY2UsIGF0dHIpOw0KPiArwqDCoMKgwqDCoMKgwqBpbnN0YW5j
ZSA9IGNvbnRhaW5lcl9vZihhdHRyLCBzdHJ1Y3QgdGhlcm1hbF9pbnN0YW5jZSwgYXR0cik7DQo+
IMKgDQo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLA0KPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRoZXJtYWxfem9uZV90cmlw
X2lkKGluc3RhbmNlLT50eiwgaW5zdGFuY2UtDQo+ID50cmlwKSk7DQo+ICvCoMKgwqDCoMKgwqDC
oHJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCB0aGVybWFsX3pvbmVfdHJpcF9pZCh0eiwNCj4g
aW5zdGFuY2UtPnRyaXApKTsNCj4gwqB9DQo+IMKgDQo+IMKgc3NpemVfdA0KPiBAQCAtODU4LDYg
Kzg1Nyw3IEBAIHdlaWdodF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGQNCj4gwqBz
c2l6ZV90IHdlaWdodF9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0
cmlidXRlDQo+ICphdHRyLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQ0KPiDCoHsNCj4gK8KgwqDCoMKgwqDC
oMKgc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6ID0gdG9fdGhlcm1hbF96b25lKGRldik7
DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdGhlcm1hbF9pbnN0YW5jZSAqaW5zdGFuY2U7DQo+
IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0LCB3ZWlnaHQ7DQo+IMKgDQo+IEBAIC04NjgsMTQgKzg2
OCwxMyBAQCBzc2l6ZV90IHdlaWdodF9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IMKgwqDC
oMKgwqDCoMKgwqBpbnN0YW5jZSA9IGNvbnRhaW5lcl9vZihhdHRyLCBzdHJ1Y3QgdGhlcm1hbF9p
bnN0YW5jZSwNCj4gd2VpZ2h0X2F0dHIpOw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgLyogRG9u
J3QgcmFjZSB3aXRoIGdvdmVybm9ycyB1c2luZyB0aGUgJ3dlaWdodCcgdmFsdWUgKi8NCj4gLcKg
wqDCoMKgwqDCoMKgbXV0ZXhfbG9jaygmaW5zdGFuY2UtPnR6LT5sb2NrKTsNCj4gK8KgwqDCoMKg
wqDCoMKgbXV0ZXhfbG9jaygmdHotPmxvY2spOw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgaW5z
dGFuY2UtPndlaWdodCA9IHdlaWdodDsNCj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgdGhlcm1hbF9n
b3Zlcm5vcl91cGRhdGVfdHooaW5zdGFuY2UtPnR6LA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRIRVJNQUxfSU5T
VEFOQ0VfV0VJR0hUX0NIQU5HRUQpOw0KPiArwqDCoMKgwqDCoMKgwqB0aGVybWFsX2dvdmVybm9y
X3VwZGF0ZV90eih0eiwNCj4gVEhFUk1BTF9JTlNUQU5DRV9XRUlHSFRfQ0hBTkdFRCk7DQo+IMKg
DQo+IC3CoMKgwqDCoMKgwqDCoG11dGV4X3VubG9jaygmaW5zdGFuY2UtPnR6LT5sb2NrKTsNCj4g
K8KgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZ0ei0+bG9jayk7DQo+IMKgDQo+IMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gY291bnQ7DQo+IMKgfQ0KPiANCj4gDQo+IA0KDQo=

