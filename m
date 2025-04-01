Return-Path: <linux-pm+bounces-24706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7C6A77E78
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 17:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929783B0628
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D959B204F93;
	Tue,  1 Apr 2025 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7eRLS/e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA09A172BD5;
	Tue,  1 Apr 2025 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519814; cv=fail; b=uFwBDPepj2nhkY2fMfPY/yysZObfoC93YoWrpaU64XC6qCB1pVMSVUQJMrtKLCe7UAyVGokLpDWLPtyfFTX5xXum0yrLHrZMISBNZXI82meCPXtb/attClMjSz6nmQWh04sUp3aAjSQ0GKnObZxDv391kRRKUsv4byvpBpN2R+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519814; c=relaxed/simple;
	bh=ga7PBedB9P0f8/v40Vj/hDowKyO55uKR1zNruW5fjoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TuE9OjiSrCfCoujBIwwj/p69Ff/XJsy+keBfzlTQu8U0Kj55TNslv5YhxHuVMpbSjezkjqnaC92nrvOKuRYtlXbJPrvDkoWDKl54k1Q8mzS8M/iQdgMqsU2F1m0HpUYWCPHe4XbyajMGp5IcbpjqvTiI13SVPODOuM1M/RbpgwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7eRLS/e; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743519813; x=1775055813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ga7PBedB9P0f8/v40Vj/hDowKyO55uKR1zNruW5fjoc=;
  b=W7eRLS/etUOz97n6juK4aBv75k9/pMBTu1C6I0eLCViFeflEimqbu9gZ
   iSpX18O3O5VjSZBzFjpVrHnlH4zn4g3BCdOHL6fL6XEDYaq4DazZnfvlI
   pQjsEiN21dI/y6u95aeNeLXqBCdyN/1diGKJj9i2/OeY2Dqn2bNRICtYB
   YkGtmqH2aTJUm1aIyXeSrpHxc9JL2Pf1CJajSk9cOOU6gP76L65q7QxGh
   tpHCXFZoagutTw29PtIysKiJvEa7ltD23sx7e7x0ExrHIB7imtx0/cahF
   L4xXIppuwpXBN6hPMTX+MmjdBRLBIRby4CxBFe7C1ZYDXBDyQuYpu78xk
   Q==;
X-CSE-ConnectionGUID: 44tJ9P04QpyRdSdnFCvlFg==
X-CSE-MsgGUID: by/TdfQuRhGFHT8Ay85T1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="55045832"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="55045832"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:03:32 -0700
X-CSE-ConnectionGUID: rCwh7OyvT+WEdjM5ZFB3rw==
X-CSE-MsgGUID: u8HoWifZTxyk+DkLJcI05g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126878533"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2025 08:03:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 1 Apr 2025 08:03:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 1 Apr 2025 08:03:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 1 Apr 2025 08:03:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Co2GmdX2zwEVKwxV8eYx4WEg1d6jPrkqIvpWEQaQ2Wm1V3hta/LlRHmBCI3Fc0LKr4dhKsS4n9sSDoFYbiSNvAJlbFN0SbCd/8C2XxQyoNJ47HvIh6V2YXkGYb4B7wAimkInvL6/AjvAr1+G6dlQVuFFOm+ruIIZwIzLLD3IBAZZSHXVmEv3Fi6pjQKysJ/yhb15bHDMhuFpTlSUdQudFCN7/jzn2uS41+p1pIEB1G/qJJZHSm/olWbB1HLkz1eSBCdCq7hEdtcGoZFlcfT1vSKZ+Y9ALXzNNN9kSpUP4GRSWc5XBmlzk+yPb7a6zzdVHT0RjSTcPQ0xZCOB16v92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga7PBedB9P0f8/v40Vj/hDowKyO55uKR1zNruW5fjoc=;
 b=UbiGZYq8KDHh4kKa372vA8CPdT8OOkznx16vgxAYBBt0W+biin/0hSylLZOESEfqAWW38r51Nx7an0OccEp5trn0XjtOW2g5HKVpFse8Yrp7qjkL93u9WlSafDPhDLdOUFcXJieEKP88LzmZL3wX1/I9qNF/I2tEzfOc8nSsUKVIfiLJAl0giSlCZj2KkLKB72zkS6+/qPNQ8yQi7PgL8E+pySuYEMH86FQO+qeBVoFQp9SM0ZLiyCUBFhzJn1t7YfUiqbdl7QmuQAB+rHaFUQDXCkHGBPWzaHO6QF0f5uaFZxu54umDEF32FBzJqkJc9wpMgLNTPBPsEGAoyx3g/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7670.namprd11.prod.outlook.com (2603:10b6:a03:4c3::18)
 by SJ0PR11MB5181.namprd11.prod.outlook.com (2603:10b6:a03:2de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Tue, 1 Apr
 2025 15:03:28 +0000
Received: from SJ2PR11MB7670.namprd11.prod.outlook.com
 ([fe80::c3bf:576d:1abc:eb24]) by SJ2PR11MB7670.namprd11.prod.outlook.com
 ([fe80::c3bf:576d:1abc:eb24%5]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 15:03:28 +0000
From: "King, Colin" <colin.king@intel.com>
To: Christian Loehle <christian.loehle@arm.com>, Bart Van Assche
	<bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpuidle: psd: add power sleep demotion prevention for
 fast I/O devices
Thread-Topic: [PATCH] cpuidle: psd: add power sleep demotion prevention for
 fast I/O devices
Thread-Index: AQHbjHwfO/1QphUhLUSIeLixfeE6q7Nh/R4AgBUtUjCACZzagIAE3fcwgAAZhQCACVO8wA==
Date: Tue, 1 Apr 2025 15:03:28 +0000
Message-ID: <SJ2PR11MB7670E05E066CCC16AFEA16A18DAC2@SJ2PR11MB7670.namprd11.prod.outlook.com>
References: <33882f284ac6e6d1ec766ca4bb2f3b88@intel.com>
 <f18607ca-30dc-43de-be77-fec69968aeec@arm.com>
 <SJ2PR11MB7670F63C7052C88637D305DF8DDF2@SJ2PR11MB7670.namprd11.prod.outlook.com>
 <1ae51ccc-66cc-4551-b649-2f5883e2f5a2@acm.org>
 <SJ2PR11MB7670B2AEFF7C0DABE6856F258DA62@SJ2PR11MB7670.namprd11.prod.outlook.com>
 <ad852ef9-5207-4b70-8834-2db6aa5e1a51@arm.com>
In-Reply-To: <ad852ef9-5207-4b70-8834-2db6aa5e1a51@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7670:EE_|SJ0PR11MB5181:EE_
x-ms-office365-filtering-correlation-id: c4634583-2d32-43f9-f6cf-08dd712e5c33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bmhKU29FcWMreGZkeUY3S29paVRJeGFWYkZoSTNMcDNyK0YyN2NZcGN3T1lY?=
 =?utf-8?B?OFB0L2R4KzJraDJvemM0cVRlKzFSNmI5ZldFNm1OZ1NxbE5YS1FIRTZ4bGFI?=
 =?utf-8?B?UklKSzFsdDRCTXNHa3Q0c3EreXpZaW9GSHpWOTVjWTdXcGFPcUdHcyt3MXcx?=
 =?utf-8?B?U3M3eTQza0w4SnBQaFI2anNRN3VkQml6RTBYRjB1ZHVySjdYSmpiTGVaUXdS?=
 =?utf-8?B?VkpUa1VFN1Jueitic1VWZVNOQURGMDhpa1ozUWVDNVdyZkdoUEttN29pMnFn?=
 =?utf-8?B?aXgvV0t6dHU2OE5nZEt2Mk5uT09veUJSYlgzeVorWEl2Z0hrYWwyMGRrUSti?=
 =?utf-8?B?ZVh5OGxIT0VZbWZoc01TamRzNGZzZ2RmTHpiSDNJaXNhMlZYRGFncGhZemNk?=
 =?utf-8?B?ZVpPUnBTdGJuejhSYzIvYzBhSGh4TVNzbjJtdWlrYVIxeGIyQTZ4UmM0WitT?=
 =?utf-8?B?NFpMcDhnQlNuWVJwS0Y1TVpZd0tPeW8za0tOY2pPZWwzQzFFN01LUktjbXps?=
 =?utf-8?B?QWRDRzJkaTNQcWxIUncwenp5cmFoa3JId2RmL3ptY0dLOTRNY0pvTW9EQzVU?=
 =?utf-8?B?eXJvUnNFdlROaUlNNmxLUVF0YXZwQkJIbU1aaGt6Mi9pc2l3OXFyU0RhRnhE?=
 =?utf-8?B?VHBMTzlqVFkvVHdFNmg4dHJXbXZjdytDcHBZc1UrMGt0OHpoaCt0Z1dWcmVG?=
 =?utf-8?B?UmRWUUpWam1vYjdxVHJ0a3VWbnRnM01zcm9mK2VvMmtZV0xhNytCOUlVOXJG?=
 =?utf-8?B?K2l2MTBSRGZGUTR6eUxkWUZHVnB1VkJvWWg3d0hhMWtTTUdMa3ZxV0tCZEFm?=
 =?utf-8?B?ZUJoNHVkYm85dlkzeWhpV3MvWU1Jb0E5dXdLWEVOVVhOd01jR3dIOGtaWE5l?=
 =?utf-8?B?SEYyNFdyV2lmamUvM21KNDFzL2duelNja2lQZU1yS0FZL3N1NlczQUVuVTNv?=
 =?utf-8?B?bkp4SG90bW4yMVh4VVpucGlOVUFqZS9pcmtHRXA5NC9JNU5ydk5CNzhEMk1G?=
 =?utf-8?B?SHR6N0FLbUNtd2tIQk9hbDdiRVRSUzdPMkRlS3ZKOFUxcCtmdURmcmxBTTdk?=
 =?utf-8?B?YU9aajl6cG9zQ29ZODVpR1VvTXVOd25pWU9UM2J5cHFBOWUxZDRxY1RkcWVN?=
 =?utf-8?B?R010M2FCcDV3dDl3U2NkUjZkeUFBa1NHZ0JlOW93c3d6aU1ES1RtWC9iOUo1?=
 =?utf-8?B?YVRxdFhUTkRUN2JoaC84ekZCTWRLeVUyUEdXRGxwUmNnbUJuRXdjTEZnMUxH?=
 =?utf-8?B?ZTlScXNZQVN6aDBZK1dFakszVG02YUIvOW5RR0xBUEJmZ2hvZkEvV2N5WFlX?=
 =?utf-8?B?Y2ZSc3IwdVdSV01WVU5Za0UxQlNqUklyN0hCQjdiN05WMGdPcERUa2lDOEtS?=
 =?utf-8?B?eXVBVjVXNTRFcUREZGlSRWM3R1FiQnlwaHJYNktrLzhoSHY2UWZuNUpYL25y?=
 =?utf-8?B?eVJqTUVrNnc2UWlNT2JZL2VDRUlhekJMR0tmaUt3ei9tNkpSSHpDQWlaYTFi?=
 =?utf-8?B?cXN5eis2U055a25vdWx4eVFDRjJmN3hMbDFYa1owSmhkdHJUT1F0T3AwTG1T?=
 =?utf-8?B?WTdRYUZxblZabitQbHQwY3FQa0orOGlhSkQ1bEtFMW02bDFlWlBKQy9FMDlL?=
 =?utf-8?B?WHM1a2ZWemRrRE5qUVNmZWZmSEpDN1FEQ3BWUXE4S1F5ZVdzcDVnRjJXSVNU?=
 =?utf-8?B?NG9TbGp3TnI0KzllZ0UzbXdaZXJidlpRRktwMXNyeGdJa1RYMGNHSFMvUVRW?=
 =?utf-8?B?RytycURMSUxIS28xbXNoMUpQZEhuejlLSkl5UnR4aXJsSE8zZXpnaSsySm1z?=
 =?utf-8?B?WHhvYjVVQS9ZTDdSVGhZR1lSZkdtUnd1UU9oaUZvWUlJdCt0REpEVlF2Zktl?=
 =?utf-8?B?czhrdmxEVVFuVnJEZVp1NW5FUEZ4ay92aUxMUnhRak01NDduVTk2WkhmTEhp?=
 =?utf-8?Q?V/5JtfBeKfLz2cn3pxNXstCHHtEFP/lE?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7670.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVgyQ0dqWWxDaThyd3p0UDRmODI1NGFHaHpMY0VqVVNlSTVoZjI3aGphbkp5?=
 =?utf-8?B?dENXeW5YYTF5d1JNVm9vQ0E4cGpFOFRHYURVR09xZTduTE9LV3NGbjNqSDhy?=
 =?utf-8?B?dW1RTjA3U3E3TUlIY3lhUHdnTUZDcnlUSTkrMDF3c2tNcUs0VEZOckV6Zzh2?=
 =?utf-8?B?eVlFc2Q1dWhvN0QvU3NTY0txd1Q4VmZJbXRubEVGMkVBblk2UTF4dFVDME1E?=
 =?utf-8?B?NDBhNFZMWU4xMm9xMDcxQUk1SVNiZzR3TXNILzlObG1QTFlQbk5kTUIzZW5n?=
 =?utf-8?B?Ujhyc096V1J4OHd3M3VFYTJ3QjRPRE9TNVZGSG1JMmEvT1ZaUm9hdGZObWhs?=
 =?utf-8?B?TlZQUkxNYzZkTGJtZ29HYXlSdEJzM29vb0U0c1hEVFR1aXYxR3BtdGVsVVZN?=
 =?utf-8?B?c1crM3Y3TmpkdDJSNXFBZWtUL0dIRkwwMG5NT2c0aVdFS0thc3hLeWI2SWl1?=
 =?utf-8?B?TWp5YlFxRk14cnhZbzQxeitsUUdxTDloL3JEaGwxT3FpK2wrak84SEg0SmJI?=
 =?utf-8?B?RGZIVWp5ODVERWtGL2tuL1NNM1ZhbFRRM05VRnl3U1RmcVJrZVM5RkFCSkpz?=
 =?utf-8?B?ZzFWaTFqbzlLUElINDB2bXkxV0l4c1cwYUFLb0wzVHZpdEZmOHR6OXNPVkNJ?=
 =?utf-8?B?djFqYXBMd0dPREorMUhSZmlaUitoNldEckwvc285ZDhBamJvZjdJMDF1bnRH?=
 =?utf-8?B?WEF5QTRrMVR5SlRId0g4TmdDays3cHBySjZETElhamlLdngvRlJaeVJ0a25W?=
 =?utf-8?B?cUYxNU1EbmZVeVdTWFFONEt5MFNoekF6TzQ3cFYwdFFqMGpRd1U2eVRpcFpI?=
 =?utf-8?B?a2pHNXpwUDhUNHg4VEoxeTBWQzZ5bVN3ZUdJOVp4U3I0V1M5RkNVeU0rb0Jy?=
 =?utf-8?B?eVQvZkJ2aStST1FqOTBiN0VhWEN6Nlg2ZHhJQlE5enk1bVR4YWNNRVZ1Rk05?=
 =?utf-8?B?MnZ2cXpkWUtBd21JYmlHZUUrcGtkZGN5SmRrOEdhaW9JaGVWOU9wNlJxNE1q?=
 =?utf-8?B?SDB6L0FRWDZtNVBBT2lmeDdyOS9ydDZ3VGhUdW03TzZodzEzbjZ1YVpGdk03?=
 =?utf-8?B?KzJEalo5bEs3UXpOSTA1UStmKzdtbUJjZ2Y3WEdNWUVJdEtyTFdTTzA3SCtM?=
 =?utf-8?B?Z3ZBbExsZy9ER1NWL2MrQktvLysxbUdVcjRtcDhVY0lXYUkrZHVFbFhVMS9w?=
 =?utf-8?B?b3FxRGVnQlBRUTcrOW4xYWRpNDBUUk9mRXlYU3hOb2ZaL3ZJUGtJQ09ySWU2?=
 =?utf-8?B?ekhnL1FNbk00REtPb3p5b3RGeVAyMjQwV1JwUFlURjFCbTZ4Z3hvRDQ5aFQ5?=
 =?utf-8?B?TEVQMWNUdlRyTkV1WGRtY2VrUGxab0VXY05QNjcxcHV6dWlpSG94THc1dzRY?=
 =?utf-8?B?WDMxNWFHYmZCL1h0NEd6MXpITHJWclBuV3VxNTFDMkNDSGtsUnc1S1pmbnN2?=
 =?utf-8?B?Wmo5K2tUVVpHbTRWOTl5N0M3MjgyWGVyWFhKVnMrTUtSeVBUTVRySmZ5RENT?=
 =?utf-8?B?MjNKRUxuQnYzUzRIUXI3UW53NjN4ZktOUWl3aUROeWRsZXg5NFlCNDNsbHN5?=
 =?utf-8?B?V21COEhLc3NGQmZzdXdyNnhtWXcvb3NxQURJbWVMaE4yd2NEK0tKaDZsUVZG?=
 =?utf-8?B?TFUxWDJJNTJUU042Mkk1SzQrdnd4Y1ZUV0JiNTFGNXBCWWoxZmJyd2tmM25j?=
 =?utf-8?B?dVdkaWRGdEFEU0lSSXFFdVp0WFZDTW9VRFJSQmtUci8wUEY0VEpxNy9ZN3dY?=
 =?utf-8?B?UVFJdE03b0tLQmYyY1NXZzkwcEErNVYrMVMzWnFpZXU4VVMwempkR3Vyd0sy?=
 =?utf-8?B?bHRkRDBTOXFEelFuYXdhSkhlVzBGY1FZTzE0dmpZMTZUVUdKRXFWR0pDY2JF?=
 =?utf-8?B?SjU3YzY5Mk4xRk9zdm05UmdjUS9KeTNhYWlISll0L3JMSExnMjIrbTRWbU9C?=
 =?utf-8?B?YllrNDVyWFgyazlHS1h1RUZYdGJrZGdLVkd1eVBTNU9HMFBUNWd2NHFWZHhW?=
 =?utf-8?B?UVFiemRYbEdHNXYwVHRjRnU1bEczc0F1S3lkaGRMU3lBK0JBMW1wWlA5dlpi?=
 =?utf-8?B?STk3UlNCVjJTVXJHOEJyVGNya2c2dHl0OWZnUEg5ZVhXb1NGbEFwTTdqOXNn?=
 =?utf-8?Q?o5bhMM8a8cWzbDiKvtaDTwIMD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7670.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4634583-2d32-43f9-f6cf-08dd712e5c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 15:03:28.5699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvEPQy3534lCdN64rXnE9wiP74W4AKewB//NEb7tbS67VJtP6BG5Rk4Tg+QrKT+RcCqoDfLzYhT+nvIb+JRF3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5181
X-OriginatorOrg: intel.com

SGksDQoNClJlcGx5IGF0IGVuZC4uDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogQ2hyaXN0aWFuIExvZWhsZSA8Y2hyaXN0aWFuLmxvZWhsZUBhcm0uY29tPg0KPiBTZW50
OiAyNiBNYXJjaCAyMDI1IDE2OjI3DQo+IFRvOiBLaW5nLCBDb2xpbiA8Y29saW4ua2luZ0BpbnRl
bC5jb20+OyBCYXJ0IFZhbiBBc3NjaGUNCj4gPGJ2YW5hc3NjaGVAYWNtLm9yZz47IEplbnMgQXhi
b2UgPGF4Ym9lQGtlcm5lbC5kaz47IFJhZmFlbCBKLiBXeXNvY2tpDQo+IDxyYWZhZWxAa2VybmVs
Lm9yZz47IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPjsgbGludXgt
DQo+IGJsb2NrQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnDQo+IENj
OiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNw
dWlkbGU6IHBzZDogYWRkIHBvd2VyIHNsZWVwIGRlbW90aW9uIHByZXZlbnRpb24gZm9yDQo+IGZh
c3QgSS9PIGRldmljZXMNCj4gDQo+IE9uIDMvMjYvMjUgMTU6MDQsIEtpbmcsIENvbGluIHdyb3Rl
Og0KPiA+IEhpLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZy
b206IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPg0KPiA+PiBTZW50OiAyMyBN
YXJjaCAyMDI1IDEyOjM2DQo+ID4+IFRvOiBLaW5nLCBDb2xpbiA8Y29saW4ua2luZ0BpbnRlbC5j
b20+OyBDaHJpc3RpYW4gTG9laGxlDQo+ID4+IDxjaHJpc3RpYW4ubG9laGxlQGFybS5jb20+OyBK
ZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+OyBSYWZhZWwgSi4NCj4gPj4gV3lzb2NraSA8cmFm
YWVsQGtlcm5lbC5vcmc+OyBEYW5pZWwgTGV6Y2Fubw0KPiA+PiA8ZGFuaWVsLmxlemNhbm9AbGlu
YXJvLm9yZz47IGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZzsNCj4gPj4gbGludXgtcG1Admdl
ci5rZXJuZWwub3JnDQo+ID4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNwdWlkbGU6IHBzZDogYWRkIHBvd2VyIHNsZWVwIGRlbW90
aW9uDQo+ID4+IHByZXZlbnRpb24gZm9yIGZhc3QgSS9PIGRldmljZXMNCj4gPj4NCj4gPj4gT24g
My8xNy8yNSAzOjAzIEFNLCBLaW5nLCBDb2xpbiB3cm90ZToNCj4gPj4+IFRoaXMgY29kZSBpcyBv
cHRpb25hbCwgb25lIGNhbiBlbmFibGUgaXQgb3IgZGlzYWJsZSBpdCB2aWEgdGhlDQo+ID4+PiBj
b25maWcgb3B0aW9uLiBBbHNvLCBldmVuIHdoZW4gaXQgaXMgYnVpbHQtaW4gb25lIGNhbiBkaXNh
YmxlIGl0IGJ5DQo+ID4+PiB3cml0aW5nIDAgdG8gdGhlDQo+ID4+IHN5c2ZzIGZpbGUNCj4gPj4+
ICAgIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdWlkbGUvcHNkX2NwdV9sYXRfdGltZW91dF9t
cw0KPiA+Pg0KPiA+PiBJJ20gbm90IHN1cmUgd2UgbmVlZCBldmVuIG1vcmUgY29uZmlndXJhdGlv
biBrbm9icyBpbiBzeXNmcy4NCj4gPg0KPiA+IEl0J3MgdXNlZnVsIGZvciBlbmFibGluZyAvIGRp
c2FibGluZyB0aGUgZnVuY3Rpb25hbGl0eSwgYXMgd2VsbCBhcyBzb21lIGZvcm0gb2YNCj4gdHVu
aW5nIGZvciBzbG93ZXIgSS9PIGRldmljZXMsIHNvIEkgdGhpbmsgaXQgaXMganVzdGlmaWFibGUu
DQo+ID4NCj4gPj4gSG93IGFyZSB1c2Vycw0KPiA+PiBleHBlY3RlZCB0byBmaW5kIHRoaXMgY29u
ZmlndXJhdGlvbiBvcHRpb24/IEhvdyBzaG91bGQgdGhleSBkZWNpZGUNCj4gPj4gd2hldGhlciB0
byBlbmFibGUgb3IgdG8gZGlzYWJsZSBpdD8NCj4gPg0KPiA+IEkgY2FuIHNlbmQgYSBWMiB3aXRo
IHNvbWUgZG9jdW1lbnRhdGlvbiBpZiB0aGF0J3MgcmVxdWlyZWQuDQo+ID4NCj4gPj4NCj4gPj4g
UGxlYXNlIHRha2UgYSBsb29rIGF0IHRoaXMgcHJvcG9zYWwgYW5kIGxldCBtZSBrbm93IHdoZXRo
ZXIgdGhpcw0KPiA+PiB3b3VsZCBzb2x2ZSB0aGUgaXNzdWUgdGhhdCB5b3UgYXJlIGxvb2tpbmcg
aW50bzogIltMU0YvTU0vQlBGIFRvcGljXQ0KPiBFbmVyZ3ktIEVmZmljaWVudCBJL08iDQo+ID4+
IChodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay9hZDEwMThiNi03YzBiLTRkNzAt
DQo+ID4+IGI4NDUtYzg2OTI4N2QzY2YzQGFjbS5vcmcvKS4gVGhlIG9ubHkgZGlzYWR2YW50YWdl
IG9mIHRoaXMgYXBwcm9hY2gNCj4gPj4gY29tcGFyZWQgdG8gdGhlIGNwdWlkbGUgcGF0Y2ggaXMg
dGhhdCBpdCByZXF1aXJlcyBSUE0gKHJ1bnRpbWUgcG93ZXINCj4gPj4gbWFuYWdlbWVudCkgdG8g
YmUgZW5hYmxlZC4gTWF5YmUgSSBzaG91bGQgbG9vayBpbnRvIG1vZGlmeWluZyB0aGUNCj4gPj4g
YXBwcm9hY2ggc3VjaCB0aGF0IGl0IGRvZXMgbm90IHJlbHkgb24gUlBNLg0KPiA+DQo+ID4gSSd2
ZSBoYWQgYSBsb29rLCB0aGUgc2NvcGUgb2YgbXkgcGF0Y2ggaXMgYSBiaXQgd2lkZXIuICBJZiBt
eSBwYXRjaA0KPiA+IGdldHMgYWNjZXB0ZWQgSSdtIGdvaW5nIHRvIGFsc28gbG9vayBhdCBwdXR0
aW5nIHRoZSBwc2QgY2FsbCBpbnRvDQo+ID4gb3RoZXIgZGV2aWNlcyAoc3VjaCBhcyBuZXR3b3Jr
IGRldmljZXMpIHRvIGFsc28gc3RvcCBkZWVwIHN0YXRlcyB3aGlsZQ0KPiA+IHRoZXNlIGRldmlj
ZXMgYXJlIGJ1c3kuICBTaW5jZSB0aGUgY29kZSBpcyB2ZXJ5IGxpZ2h0d2VpZ2h0IEkgd2FzIGhv
cGluZyB0aGlzDQo+IHdhcyBnb2luZyB0byBiZSByZWxhdGl2ZWx5IGVhc3kgYW5kIHNpbXBsZSB0
byB1c2UgaW4gdmFyaW91cyBkZXZpY2VzIGluIHRoZQ0KPiBmdXR1cmUuDQo+IA0KPiBJTU8gdGhp
cyBuZWVkcyB0byBiZSBhIGxvdCBtb3JlIGZpbmUtZ3JhaW5lZCB0aGVuLCBib3RoIGluIHRlcm1z
IG9mIHdoaWNoDQo+IGRldmljZXMgb3IgZXZlbiBJTyBpcyBhZmZlY3RlZCAoU3VyZWx5IHNvbWUg
SU8gaXMgZmluZSB3aXRoIGF0IGxlYXN0ICpzb21lKg0KPiBsYXRlbmN5KSBidXQgYWxzbyBob3cg
YWdncmVzc2l2ZSB3ZSBhcmUgaW4gYmxvY2tpbmcuDQo+IEp1c3QgbG9va2luZyBhdCBzb21lIGNv
bW1vbiBsYXRlbmN5L3Jlc2lkZW5jeSBvZiBpZGxlIHN0YXRlcyBvdXQgdGhlcmUgSSBkb24ndA0K
PiB0aGluayBpdCdzIHJlYXNvbmFibGUgdG8gZm9yY2UgcG9sbGluZyBmb3IgYSAzLTEwbXMgKHJv
dW5kaW5nIHVwIHdpdGggdGhlIGppZmZpZSkNCj4gcGVyaW9kLg0KDQpUaGUgY3VycmVudCBzb2x1
dGlvbiBieSBhIGN1c3RvbWVyIGlzIHRoYXQgdGhleSBhcmUgcmVzb3J0aW5nIHRvIGRpc2FibGlu
ZyBDNi9DNlAgYW5kIGhlbmNlDQphbGwgdGhlIENQVXMgYXJlIGVzc2VudGlhbGx5IGluIGEgbm9u
LWxvdyBwb3dlciBzdGF0ZSBhbGwgdGhlIHRpbWUuICBUaGUgb3B0LWluIHNvbHV0aW9uIA0KcHJv
dmlkZWQgaW4gdGhlIHBhdGNoIHByb3ZpZGVzIG5lYXJseSB0aGUgc2FtZSBwZXJmb3JtYW5jZSBh
bmQgd2lsbCByZS1lbmFibGUgZGVlcGVyDQpDLXN0YXRlcyBvbmNlIHRoZSBJL08gaXMgY29tcGxl
dGVkLg0KDQpBcyBJIG1lbnRpb25lZCBlYXJsaWVyLCB0aGUgamlmZmllcyBhcmUgdXNlZCBiZWNh
dXNlIGl0J3MgbG93LXRvdWNoIGFuZCB2ZXJ5IGZhc3Qgd2l0aCBuZWdsaWdpYmxlDQppbXBhY3Qg
b24gdGhlIEkvTyBwYXRocy4gVXNpbmcgZmluZXIgZ3JhaW5lZCB0aW1pbmcgaXMgZmFyIG1vcmUg
YW4gZXhwZW5zaXZlIG9wZXJhdGlvbiBhbmQNCmlzIGEgaHVnZSBvdmVyaGVhZCBvbiB2ZXJ5IGZh
c3QgSS9PIGRldmljZXMuDQoNCkFsc28sIHRoaXMgaXMgYSB1c2VyIGNvbmZpZyBhbmQgdHVuZS1h
YmxlIGNob2ljZS4gVXNlcnMgY2FuIG9wdC1pbiB0byB1c2luZyB0aGlzIGlmIHRoZXkgd2FudA0K
dG8gcGF5IGZvciB0aGUgZXh0cmEgQ1BVIG92ZXJoZWFkIGZvciBhIGJpdCBtb3JlIEkvTyBwZXJm
b3JtYW5jZS4gSWYgdGhleSBkb24ndCB3YW50IGl0LCB0aGV5DQpkb24ndCBuZWVkIHRvIGVuYWJs
ZSBpdC4NCg0KPiBQbGF5aW5nIGRldmlsJ3MgYWR2b2NhdGUgaWYgdGhlIHN5c3RlbSBpcyB1bmRl
ciBzb21lIHRoZXJtYWwvcG93ZXIgcHJlc3N1cmUNCj4gd2UgbWlnaHQgYWN0dWFsbHkgcmVkdWNl
IHRocm91Z2hwdXQgYnkgYnVybmluZyBzbyBtdWNoIHBvd2VyIG9uIHRoaXMuDQo+IFRoaXMgc2Vl
bXMgbGlrZSB0aGUgc3R1ZmYgdGhhdCBpcyBlYXNpbHkgY29udmluY2luZyBiZWNhdXNlIGl0IGlt
cHJvdmVzDQo+IHRocm91Z2hwdXQgYW5kIHRoZW4gdGFraW5nIGNhcmUgb2YgcG93ZXIgYWZ0ZXJ3
YXJkcyBpcyByZWFsbHkgaGFyZC4gOi8NCj4gDQoNClRoZSBjdXJyZW50IHNvbHV0aW9uIGlzIHdo
ZW4gdGhlIHVzZXIgaXMgdHJ5aW5nIHRvIGdldCBtYXhpbXVtIGJhbmR3aWR0aCBhbmQgZGlzYWJs
aW5nIEM2L0M2UCANCnNvIHRoZXkgYXJlIGFscmVhZHkga2VlcGluZyB0aGUgc3lzdGVtIGJ1c3ku
IFRoaXMgc29sdXRpb24gYXQgbGVhc3Qgd2lsbCBzYXZlIHBvd2VyIHdoZW4gSS9PIGlzIGlkbGlu
Zy4NCg0KQ29saW4gDQo=

