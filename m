Return-Path: <linux-pm+bounces-24511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BDBA719FB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 16:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88536162543
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F411F2369;
	Wed, 26 Mar 2025 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgBybADi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B27B5383;
	Wed, 26 Mar 2025 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002058; cv=fail; b=TOwo8UnmwKPj8UXQQeZRV6Dms9Ie1V19j5sMbHRT1FT6Ng7kq+i3Iv4i7kHMUlXOI1H+kvFKNDxOhDEsSaZnwdh1M+qGV1J5TQtADLZe4ijgv6qIfSCxO6otTeB4JWIskAkD2uU0nUq4E2DuLiAfrpNlkg/5nIgBWVYY27pQ+P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002058; c=relaxed/simple;
	bh=EJda+HWi5odpKX7QNae33+cS78kzO2k/b5rRsHVs88M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oPfWJRKsXYwMIhJ71hVJm+14V7OSDnLQdsHPh8o/PhNx429R9HJUTufsZQ8aFvb2cRnUjpvnDfXoFSDiqM7Mjs4Swkoy40B5fzcy8yoe6KsfEFQyNuSO1nV6LPEI3f+bOgjJEeNiHkvqZD9DuARTyUEXWyROI6SnHooCCbDOUlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgBybADi; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743002056; x=1774538056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EJda+HWi5odpKX7QNae33+cS78kzO2k/b5rRsHVs88M=;
  b=PgBybADiRRUund9X0rSOQjehT5A1rWfpfpjI+tAtU5Y9LPssLvHL+FIF
   212lhJuiNTrlDnepseYPNdnRZzM1jedf5K1NzCuzmKUNTu419aFHWXL1D
   AJVRCBib+Q8rg2tEoW1OSnBumfNEwLrPnQ2XFOU90wbM+iMY4c47fOXGq
   3hQoRmR66eJF8n61Wa+4lcdNw0JQk8gb3S7upCdvYQq2TpcFpnz/eXrzo
   gR25zhm3iOgEJK+NkQYTZFqMiCZaQm6ro5xlTVfz/RqEtpGBeW1hblvor
   iozoJLMoDjbn/v9kF+llRxpNsoaO8p2t2V0K/7PA0A3bmHywohmF9BrTR
   Q==;
X-CSE-ConnectionGUID: 5tLN1O53TF2YiU1wIOArfw==
X-CSE-MsgGUID: W1P2AV93TMaTckoAlqlRhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48176266"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="48176266"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:14:15 -0700
X-CSE-ConnectionGUID: 8EV5LvunQjazPOmOu6muGg==
X-CSE-MsgGUID: kM8+4UpxRu6fskdsi9Jyow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="129655763"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:14:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 08:14:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 08:14:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 08:14:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmufLcd9iKDuSt9SkTkPAQJ+YYBFWINDAu7GtxdRne18d16PtCK1yosGD4rWGhtk54+6EzKASrajFoQwB9qxvZVmHJ26/MWRmBm2GJWFYUSOiprhF08lNcfkLEiwTpaCNdZUvFZiRMvqbXLs/acOESC6mAJ6xfBA6SJcanEY5zS9RRV3/gZyD/oA+ktJgZFseWKAi4iKDwiAjS0T8FQW/mEky1mrsXx59I7hmvgIoNUEaJ23321Wzh6D5ESYl1aH/ck+5U2zigAPalrE1rVAgM4uIihDyV79c83VAdnk2vOWnbI0scS4urmqrNujUfajlKLVLGn+pkw5SABkZkPxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJda+HWi5odpKX7QNae33+cS78kzO2k/b5rRsHVs88M=;
 b=ReOaQHNKgqII1HYh+oxRx5hQXf+PN1JouU+MHw4oLeZK/fbLrdKDuvXXysetZfkOOGBUOyZHiv67ElHCiQQZMaVF0kffV3sIFFWgV3oIfGSsDRrAbxHuiZjj1v0uC5C6sUVx84FhrAIXA07bLeijr8fiCggbNbflVSchYB8n6iq5ypDq26y7EzXGQiK3UnXLE2s/xW/4Tz+lubu/QV/9yY/5eQR9V4YCazmGuMcHBjX5aPWLLsd6ABYuwM1id626D1Ava6IvI2+/Bg4FEN3pwcavd/vZastoq9EXHZv8K6pTrYUsygArqAHrx/X7k/9G3oU9NX5UVzQ5yLACMnz0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7670.namprd11.prod.outlook.com (2603:10b6:a03:4c3::18)
 by DS0PR11MB6447.namprd11.prod.outlook.com (2603:10b6:8:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 15:14:10 +0000
Received: from SJ2PR11MB7670.namprd11.prod.outlook.com
 ([fe80::c3bf:576d:1abc:eb24]) by SJ2PR11MB7670.namprd11.prod.outlook.com
 ([fe80::c3bf:576d:1abc:eb24%5]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 15:14:09 +0000
From: "King, Colin" <colin.king@intel.com>
To: Christian Loehle <christian.loehle@arm.com>, Jens Axboe <axboe@kernel.dk>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpuidle: psd: add power sleep demotion prevention for
 fast I/O devices
Thread-Topic: [PATCH] cpuidle: psd: add power sleep demotion prevention for
 fast I/O devices
Thread-Index: AQHbjHwfO/1QphUhLUSIeLixfeE6q7Nh/R4AgBUtUjCACWWtAIAFF8nA
Date: Wed, 26 Mar 2025 15:14:09 +0000
Message-ID: <SJ2PR11MB76701E015E411063C35938D98DA62@SJ2PR11MB7670.namprd11.prod.outlook.com>
References: <33882f284ac6e6d1ec766ca4bb2f3b88@intel.com>
 <f18607ca-30dc-43de-be77-fec69968aeec@arm.com>
 <SJ2PR11MB7670F63C7052C88637D305DF8DDF2@SJ2PR11MB7670.namprd11.prod.outlook.com>
 <1e870bd8-0e13-4e0d-bbe9-e9f601f59a50@arm.com>
In-Reply-To: <1e870bd8-0e13-4e0d-bbe9-e9f601f59a50@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7670:EE_|DS0PR11MB6447:EE_
x-ms-office365-filtering-correlation-id: 4b3571bc-ddcc-4afa-b4f8-08dd6c78dbe1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q3JyYklzN1dBSmZzZ1E2S0tUWG5HYUsxaStVMXg1Q1RJajZmNEdoZU5JSGN0?=
 =?utf-8?B?YlZUTCszNkV6OFBnZ0dqR1VzK3J3SnlFM2pFdExmUUwxM0hKV3VUN1Z2UURE?=
 =?utf-8?B?cHVjNEVpOWQ0MVNlckpqRWYxbXc0RWZOTlFET1llZDdkNlpTMW5XdzhQdE1N?=
 =?utf-8?B?emdaUXlLNEhQckN6YUVlZlJUaUM4cnpaeEMwQk9icnM1d1c0NEEwQjlqdFU5?=
 =?utf-8?B?S3FIS01TNHM0SXl5Wmh5N1RLd21hNUpBL0FudGdhTXQzUTNBZXg2ZlRiMVJa?=
 =?utf-8?B?dStacCsreVpXbjF2Y3NRWU1xS1UzbW53MCtoK0tUeXRucFdweS9sT0RISTM3?=
 =?utf-8?B?dC9UeWdOb3hNeDhrK25sOVQ0MjN3cE5MLzI2MGhBcDZSYUJsUTd1M3hnSE5l?=
 =?utf-8?B?TDYyMlkwMTEzTXh4R2thNklidkJkV1Vaa0xXM0pYbU9UMlpESkhUb01zakdk?=
 =?utf-8?B?dVA1VzA2OHZEWW90MHZKTlprYmp6WE5zb1RjK0RjYml1SjByQUpmeWJTZ0pV?=
 =?utf-8?B?RUovR2NJQVNhLys1N1l0QnZTRmk0SFc5WDB1TkxFVW5SR1QrNGVYTklTenh0?=
 =?utf-8?B?aU9VTjdvUkdYeFA3bmswbHlRWmN3TkRFTzRtbnM5YVVyV1NQb3o0dVJNaHJs?=
 =?utf-8?B?ZXBrV1k2Mm9ZNFlJUU81ckVBSHNyMEpyTFk1OTAwUW9mYU51OGZkWmVGSWRK?=
 =?utf-8?B?SURueFk1WE9JSFVQMHZFM29ZTDc1WW5jdDNxQ3lDZ1FvdTVkRVkzV29IR010?=
 =?utf-8?B?NFBpRDlCRDJKN2hDQm5mZ1NkRjFmN0NGZXMwOStHVG9XZ0NUQmF6U3JRcVlw?=
 =?utf-8?B?M0pvd2l4ZFFCb3dNaGd5N3RmSkUwVFJmaXVyTDZMcjNPUTBhZlhNOURDUEFt?=
 =?utf-8?B?VmlFSXI3eFhXRWgxVmVyTEJQU2JuVmJpYmcrN3piNVFuVlQrQ3FQQXQrYWx2?=
 =?utf-8?B?RWY1bHBMR0N1bXVVQUV3WktTYy9Cc0MzZThDWVAwOEpUOU5ublVZSjFyRXll?=
 =?utf-8?B?ZU15aDRGVW5QbjBORWxJV3J1dHd0MHVBZ3ZMRkFJQktZa25iN0dkYlk4S1R1?=
 =?utf-8?B?VEJMNjNnVzZpVzhCZU9DWnBoaW16MVRQaEpVejV0Y0syVkJUWjl3N3Y1Um5F?=
 =?utf-8?B?eENxWVZPdUp4THgxNDB3OVlUbVMrckdlYW5kTDZUb0p5eWZFYUVmeS9QQkVQ?=
 =?utf-8?B?d0dVWDczVGR6VVlPY0xTMklPZkZsbWM3OVErQkVSaHVmZVJReENlejl0eTFU?=
 =?utf-8?B?S2ptRzQyVWcxV21IaFJYeUV6eHVLYUVISXV6eTZraVFuVGw3UGcxeTBwdHh4?=
 =?utf-8?B?M2JVb2E1WWFGemlmQW9QNU5weUF3eXl5azVwS3lDWlZJZ3dwc3RmUDM5b2do?=
 =?utf-8?B?ZitKVVg4dnNqY0NjUkcxY3hpNWF4WjNHU1JwR0V0bktQai80WVAybVhGTGFQ?=
 =?utf-8?B?c0dCakszKzExUjNLL09Nam1DdllIUnlUOXFqTitJSy9MZHU2dGVYbzQybmtl?=
 =?utf-8?B?UlkwSzJwdFFMUFZmUmJHV2FKN21oOWpmbm1VZHYwYmsrT2ZwSGtnYWdoRHVa?=
 =?utf-8?B?c3doU1EyczVqYm1sRDBCQjU0WFdia3lHNENlMlNzOGZjRnUwaGVmQXhWRFdD?=
 =?utf-8?B?a0lQQ0FZS1ArUHRYQmlvc1QwOEpPc2RXODNsdHluVnJTWnVINEJINDBlbVp5?=
 =?utf-8?B?eng2SHR1WkZrTFU4SXFZdWUrL2lOWkdOcjhFRUE2VnJZaXNLNUt2ZWFsRGdD?=
 =?utf-8?B?Wm9BWnJhR1o1WUdDOGpldUFFSi9idlFlL0crNVd0b29LTWZIVXFXVU01K2cy?=
 =?utf-8?B?M2ovVWUyb3pjTmhHakVCZzVHc1g0TlM2SXZzN2VURjVaSDZqRE5vV3dDc05w?=
 =?utf-8?B?ejJ2VXJPaXMrb09taXdSckVaY3BYSDhBcTVGa2ZreTZoSlRzWmtxVzltWEQw?=
 =?utf-8?Q?pTmnpfSowonSYqRrtJcvoAHyJbYQxJoJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7670.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enRIN2J3emwzSlZoRTlHd3V4dThYOHNjeE0wRmdVdEpxV2toL25wOUxpM3VZ?=
 =?utf-8?B?VU5QRmhyZ3YwUkVTT3o2RjcvY2V5MmVDdVZmbVo1UU8zQXRUM1hVei9PR1RZ?=
 =?utf-8?B?RkFSOVBiV01Rdlg0N3gwdTZvTWlPN1NRVHZDUXBrUjYyVzFDNTJubXFJMWRl?=
 =?utf-8?B?Z2xma1drLytyWEZUaHoraGN2NWRPdXF4eUVmNHBpZkNYRFRXRXNDcVNGN1lp?=
 =?utf-8?B?Z2Roemh4RUNzNjRsTitLa0EzYkRTcW15VHFTek9hZ0VSZ0l6QkEzMXFNWENT?=
 =?utf-8?B?cWZaNDZkWm1VVlI4WWVKTXBORGljSzk1WCtDV0o4UkZlS2p6eUVpZXNSODFo?=
 =?utf-8?B?MnlDNlNkRlJ6emJUUFh0bFhHMUhQdCthNXh0YjNrT2RlYUFQZmVLbFdkV25W?=
 =?utf-8?B?UXI4aTJBZTJNZ1J1TjFjcFBxTFJhbVdoUUtuN1kxR1ExSUd1d3lrdG9tdUJr?=
 =?utf-8?B?UGVvOXNaU0tBSnRucjQwbUNVTzFrZy81YzI0WC8vZlh5bkVTbjZRVEZyQ0l6?=
 =?utf-8?B?SWF6Y2xQd2E1WG83Uzk5N2ZBTGZsZzJ1TUZCV245bWpiV0VKTXljMS9SQkdY?=
 =?utf-8?B?bmpLcFdWQTJnbXJ4OTV0U054Q2xDdnpOZmlab28rdEdZbU4rWXEvWTdwYllk?=
 =?utf-8?B?TEFDVURZRHlFUUVQK1pkQTdOanovVGg4b21tQU5xWWJyT3dyempCZmdkazcy?=
 =?utf-8?B?VFNCNENWYkFCTEVRSkZ1eDZ5cUYrankzTHRTRTlFajdLcm9PYVB6QUluNUlo?=
 =?utf-8?B?V2c2cVQyY0U3V2hsNzJnalJGSHBsa1laUnVqeWNLTm9PdzdBYmNDcmNxOVNY?=
 =?utf-8?B?eE5zNDIvWFJvQ3pSK1NCZ1FERjJyaXg2NDdZRXNYOStIYUsxZW11Y1l3ZUgw?=
 =?utf-8?B?bXEreDYraEMyR1BkbmFXR2FaVURIWlNXYWg0enFmeExCbWJwbENFQzNzVE1x?=
 =?utf-8?B?WXNxbzlyRm5EZzFxaHYzN3cydk0zTVpmOXl2eWJoR0pna0N6NzZFaytBMjUv?=
 =?utf-8?B?akZFWnZhSU8vb3FFa1hiMUhlNVM4UEVqM051djNON1ZSUWxoWTFraHU0bWJm?=
 =?utf-8?B?Tmh2cWtmcDRFS0RKaWdQOGpVS2FIU29NMU82R3lsc2owUmZhMGlCcWd0MmJp?=
 =?utf-8?B?SVBSeWt2UWQxYTB5LzVZS3JrQkljN3RtWEQ4YmdYUFkzWFNVQndFa2o4SXdz?=
 =?utf-8?B?cjB6UmNheVJ4cHdReFhFZmY0ejExanlua1FrWUlWTzdUeXZGckVUZWZkZW00?=
 =?utf-8?B?d3NaSk0wOGQ0WmdudVZwdDFvTWNCTndpSGZMTk11T0ZpMExPVWtVN0RaSEw0?=
 =?utf-8?B?OTArK1VSM3huTld6MHprSEJiUWE2S3N4YUh3amNqM0VmRGRNUHRPNzdtaVpy?=
 =?utf-8?B?d1U2SEV5UWlhRS9nZnBSK0dST0t2RThCTW5uQVBNR1hUTGpRMFJ1NkU0TlZC?=
 =?utf-8?B?ZU1EMUlYTXhnNVo5RTlQbEpScTViWTgzRkQvMjhQZU5lNGVGY0ZqcTVYZWtJ?=
 =?utf-8?B?d09RZjhuTXRjSEZZY2pNS2UwRVF4ME9WV0hLVVhOL094Y3l0bHJuL1Y1ZVpS?=
 =?utf-8?B?eXhxTVBDMGo0NmFxaFdKajRTaEo1VldWQ2VIYmhSK3RMTWM3TTd3UkkydVV4?=
 =?utf-8?B?eVlnYmx0enBycWpyM3BDVkNCOXJabjl4WDJPdVM3cEN3SE5zZlR3ZngyNEJD?=
 =?utf-8?B?ZG9kVVNrWjlJdlZUY1k3YWsvQW1NZ2MwK09XTzBRcWhlSW44dkRVRHBWVEhF?=
 =?utf-8?B?V0NiLzdNb1I5VHYvUnJUSEgwK2JNbHcxTnQwZEhhald0eFZkQ1o5SWxHR1lV?=
 =?utf-8?B?UndJZWRoL3RHZ2g5SHZiKzVjS0I4dlg4bzlnVGNMWHpvQis2SzZOUGtZdE8z?=
 =?utf-8?B?L3pCRy9lNFkwdE1Vd0MvVmZWYzVNMlgwdmFXM08zN2pYTm8welU0ZUlvQ3dW?=
 =?utf-8?B?cTc2RkJndFpKVGlmakh3bC9tT1FGMlJRWjVUSHRDZ3plZWl2cG5adUhOK2tw?=
 =?utf-8?B?azkyMVRDL2lRdmJGVFQ4dW9nSmlaQ3dNN0lrNGxOdU12UEdZdWxEQXVFVm1v?=
 =?utf-8?B?L2NkcWRmaXBrTXJXTURmeWhYek5RckJVSDY4ekpoTkxZZk9FK3VsbTNvRVJO?=
 =?utf-8?Q?i7x1q695z3SM7Dl1jYWHX82i5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3571bc-ddcc-4afa-b4f8-08dd6c78dbe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 15:14:09.7015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +KRgLrjMII5ic+XY4scCbpO0wttCrUaR0p40i+Wo7+SWSpCII80uSzz4UKlCcw/EHGYw3692OCRZPdTxVwtEEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6447
X-OriginatorOrg: intel.com

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0aWFuIExv
ZWhsZSA8Y2hyaXN0aWFuLmxvZWhsZUBhcm0uY29tPg0KPiBTZW50OiAyMyBNYXJjaCAyMDI1IDA5
OjE5DQo+IFRvOiBLaW5nLCBDb2xpbiA8Y29saW4ua2luZ0BpbnRlbC5jb20+OyBKZW5zIEF4Ym9l
IDxheGJvZUBrZXJuZWwuZGs+OyBSYWZhZWwNCj4gSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5v
cmc+OyBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz47DQo+IGxpbnV4
LWJsb2NrQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnDQo+IENjOiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNwdWlk
bGU6IHBzZDogYWRkIHBvd2VyIHNsZWVwIGRlbW90aW9uIHByZXZlbnRpb24gZm9yDQo+IGZhc3Qg
SS9PIGRldmljZXMNCj4gDQo+IE9uIDMvMTcvMjUgMTA6MDMsIEtpbmcsIENvbGluIHdyb3RlOg0K
PiA+IEhpIENocmlzdGlhbiwNCj4gPg0KPiA+IEZvbGxvdy11cCBiZWxvdzoNCj4gPg0KPiA+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDaHJpc3RpYW4gTG9laGxlIDxj
aHJpc3RpYW4ubG9laGxlQGFybS5jb20+DQo+ID4+IFNlbnQ6IDAzIE1hcmNoIDIwMjUgMjI6MjUN
Cj4gPj4gVG86IEtpbmcsIENvbGluIDxjb2xpbi5raW5nQGludGVsLmNvbT47IEplbnMgQXhib2Ug
PGF4Ym9lQGtlcm5lbC5kaz47DQo+ID4+IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVs
Lm9yZz47IERhbmllbCBMZXpjYW5vDQo+ID4+IDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPjsg
bGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5v
cmcNCj4gPj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gY3B1aWRsZTogcHNkOiBhZGQgcG93ZXIgc2xlZXAgZGVtb3Rpb24NCj4gPj4g
cHJldmVudGlvbiBmb3IgZmFzdCBJL08gZGV2aWNlcw0KPiA+Pg0KPiA+PiBPbiAzLzMvMjUgMTY6
NDMsIENvbGluIElhbiBLaW5nIHdyb3RlOg0KPiA+Pj4gTW9kZXJuIHByb2Nlc3NvcnMgY2FuIGRy
b3AgaW50byBkZWVwIHNsZWVwIHN0YXRlcyByZWxhdGl2ZWx5IHF1aWNrbHkNCj4gPj4+IHRvIHNh
dmUgcG93ZXIuIEhvd2V2ZXIsIGNvbWluZyBvdXQgb2YgZGVlcCBzbGVlcCBzdGF0ZXMgdGFrZXMg
YQ0KPiA+Pj4gc21hbGwgYW1vdW50IG9mIHRpbWUgYW5kIHRoaXMgaXMgZGV0cmltZW50YWwgdG8g
cGVyZm9ybWFuY2UgZm9yIEkvTw0KPiA+Pj4gZGV2aWNlcyBzdWNoIGFzIGZhc3QgUENJZSBOVk1F
IGRyaXZlcyB3aGVuIHNlcnZpY2luZyBhIGNvbXBsZXRlZCBJL08NCj4gPj4+IHRyYW5zYWN0aW9u
cy4NCj4gPj4+DQo+ID4+PiBUZXN0aW5nIHdpdGggZmlvIHdpdGggcmVhZC93cml0ZSBSQUlEMCBQ
Q0llIE5WTUUgZGV2aWNlcyBvbiB2YXJpb3VzDQo+ID4+PiBtb2Rlcm4gU01QIGJhc2VkIHN5c3Rl
bXMgKHN1Y2ggYXMgOTYgdGhlYWQgR3Jhbml0ZSBSYXBpZHMgWGVvbg0KPiA+Pj4gNjc0MVApIGhh
cyBzaG93biB0aGF0IG9uIDg1LTkwJSBvZiByZWFkL3dyaXRlIHRyYW5zYWN0aW9ucyBpc3N1ZWQg
b24NCj4gPj4+IGEgQ1BVIGFyZSBjb21wbGV0ZWQgYnkgdGhlIHNhbWUgQ1BVLCBzbyBpdCBtYWtl
cyBzb21lIHNlbnNlIHRvDQo+ID4+PiBwcmV2ZW50IHRoZSBDUFUgZnJvbSBkcm9wcGluZyBpbnRv
IGEgZGVlcCBzbGVlcCBzdGF0ZSB0byBoZWxwIHJlZHVjZQ0KPiA+Pj4gSS9PIGhhbmRsaW5nIGxh
dGVuY3kuDQo+ID4+DQo+ID4+IEZvciB0aGUgcGxhdGZvcm0geW91IHRlc3RlZCBvbiB0aGF0IG1h
eSBiZSB0cnVlLCBidXQgZXZlbiBpZiB3ZQ0KPiA+PiBjb25zdHJhaW4gb3Vyc2VsdmVzIHRvIHBj
aS1udm1lIHRoZXJlJ3MgYSB2YXJpZXR5IG9mIHF1ZXVlL2lycQ0KPiA+PiBtYXBwaW5ncyB3aGVy
ZSB0aGlzIGRvZXNuJ3QgaG9sZCBJJ20gYWZyYWlkLg0KPiA+DQo+ID4gVGhpcyBjb2RlIGlzIG9w
dGlvbmFsLCBvbmUgY2FuIGVuYWJsZSBpdCBvciBkaXNhYmxlIGl0IHZpYSB0aGUgY29uZmlnDQo+
ID4gb3B0aW9uLiBBbHNvLCBldmVuIHdoZW4gaXQgaXMgYnVpbHQtaW4gb25lIGNhbiBkaXNhYmxl
IGl0IGJ5IHdyaXRpbmcgMCB0byB0aGUNCj4gc3lzZnMgZmlsZQ0KPiA+ICAgL3N5cy9kZXZpY2Vz
L3N5c3RlbS9jcHUvY3B1aWRsZS9wc2RfY3B1X2xhdF90aW1lb3V0X21zDQo+ID4NCj4gPj4NCj4g
Pj4+DQo+ID4+PiBUaGlzIGNvbW1pdCBpbnRyb2R1Y2VzIGEgc2ltcGxlLCBsaWdodHdlaWdodCBh
bmQgZmFzdCBwb3dlciBzbGVlcA0KPiA+Pj4gZGVtb3Rpb24gbWVjaGFuaXNtIHRoYXQgcHJvdmlk
ZXMgdGhlIGJsb2NrIGxheWVyIGEgd2F5IHRvIGluZm9ybSB0aGUNCj4gPj4+IG1lbnUgZ292ZXJu
b3IgdG8gcHJldmVudCBhIENQVSBmcm9tIGdvaW5nIGludG8gYSBkZWVwIHNsZWVwIHdoZW4gYW4N
Cj4gPj4+IEkvTyBvcGVyYXRpb24gaXMgcmVxdWVzdGVkLiBXaGlsZSBpdCBpcyB0cnVlIHRoYXQg
c29tZSBJL09zIG1heSBub3QNCj4gPj4NCj4gPj4gcy9yZXF1ZXN0ZWQvY29tcGxldGVkIGlzIHRo
ZSBmdWxsIHRydXRoLCBpc24ndCBpdD8NCj4gPj4NCj4gPj4+IGJlIHNlcnZpY2VkIG9uIHRoZSBz
YW1lIENQVSB0aGF0IGlzc3VlZCB0aGUgSS9PIHJlcXVlc3QgYW5kIGhlbmNlIGlzDQo+ID4+PiBu
b3QgMTAwJSBwZXJmZWN0IHRoZSBtZWNoYW5pc20gZG9lcyB3b3JrIHdlbGwgaW4gdGhlIHZhc3Qg
bWFqb3JpdHkNCj4gPj4+IG9mIEkvTyBvcGVyYXRpb25zIGFuZCB0aGVyZSBpcyB2ZXJ5IHNtYWxs
IG92ZXJoZWFkIHdpdGggdGhlIHNsZWVwDQo+ID4+PiBkZW1vdGlvbiBwcmV2ZW50aW9uLg0KPiA+
Pj4NCj4gPj4+IFRlc3QgcmVzdWx0cyBvbiBhIDk2IHRocmVhZCBYZW9uIDY3NDFQIHdpdGggYSA2
IHdheSBSQUlEMCBQQ0llIE5WTUUNCj4gPj4+IG1kIGFycmF5IHVzaW5nIGZpbyAzLjM1IHBlcmZv
cm1pbmcgcmFuZG9tIHJlYWQgYW5kIHJlYWQtd3JpdGUgdGVzdA0KPiA+Pj4gb24gYSA1MTJHQiBm
aWxlIHdpdGggOCBjb25jdXJyZW50IEkvTyBqb2JzLiBUZXN0ZWQgd2l0aCB0aGUNCj4gPj4+IE5I
TV9DMV9BVVRPX0RFTU9URSBiaXQgc2V0IGluIE1TUl9QS0dfQ1NUX0NPTkZJR19DT05UUk9MIHNl
dA0KPiBpbg0KPiA+PiB0aGUgQklPUy4NCj4gPj4+DQo+ID4+PiBUZXN0IGNhc2U6IHJhbmRvbSBy
ZWFkcywgcmVzdWx0cyBiYXNlZCBvbiBnZW9tZXRpYyBtZWFuIG9mIHJlc3VsdHMNCj4gPj4+IGZy
b20NCj4gPj4+IDUgdGVzdCBydW5zOg0KPiA+Pj4gICAgICAgICAgICBCYW5kd2lkdGggICAgICAg
ICBJTy1vcHMgICBMYXRlbmN5ICAgQmFuZHdpZHRoDQo+ID4+PiAgICAgICAgICAgIHJlYWQgKGJ5
dGVzL3NlYykgIHBlciBzZWMgICAgKG5zKSAgICAlIFN0ZC5EZXZpYXRpb24NCj4gPj4+IEJhc2Vs
aW5lOiAgMjEzNjU3NTU2MTAJICAgICAyMDM3NyAgICAgMzkwMTA1ICAgMS44NiUNCj4gPj4+IFBh
dGNoZWQ6ICAgMjU5NTAxMDc1NTggICAgICAgMjQ3NDggICAgIDMyMjkwNSAgIDAuMTYlDQo+ID4+
DQo+ID4+IFdoYXQgaXMgdGhlIGJhc2VsaW5lPw0KPiA+PiBEbyB5b3UgbWluZCB0cnlpbmcgd2l0
aCBSYWZhZWwncyByZWNlbnRseSBwb3N0ZWQgc2VyaWVzPw0KPiA+PiBHaXZlbiB0aGUgSU9QUyBJ
J2QgZXhwZWN0IGdvb2QgcmVzdWx0cyBmcm9tIHRoYXQgYWxvbmUgYWxyZWFkeS4NCj4gPj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8xOTE2NjY4LnRkV1Y5U0VxQ2hAcmp3eXNvY2tpLm5l
dC8NCj4gPj4NCj4gPj4gKEhhcHB5IHRvIHNlZSB0ZW8gYXMgY29tcGFyaXNvbiB0b28sIHdoaWNo
IHlvdSBkb24ndCBtb2RpZnkpLg0KPiA+DQo+ID4gT0ssIEkgcmUtcmFuIHRoZSB0ZXN0cyBvbiA2
LjE0LXJjNSBvbiB0aGUgc2FtZSBIL1cuIFRoZSAiQmFzZWxpbmUiIGlzDQo+ID4gNi4xNC1yYzUg
d2l0aG91dCBSYXBoZWwncyBwYXRjaC4gSSBhbHNvIHRlc3RpbmcgdGhlIEJhc2VsaW5lIHdpdGgg
QzYNCj4gPiBhbmQgQzZQIGRpc2FibGVkIGFzIHRoaXMgc3RvcHMgZGVlcGVyIEMtc3RhdGUgc2xl
ZXBzIGFuZCBpbiB0aGVvcnkNCj4gPiBzaG91bGQgcHJvdmlkZSAiYmVzdCBwZXJmb3JtYW5jZSIu
IEkgYWxzbyBiZW5jaG1hcmtlZCB3aXRoIFJhcGhlbCdzIHBhdGNoDQo+IGFuZCBqdXN0IG15IHBh
dGNoLCBhbmQgZmluYWxseSBSYXBoZWxzIHBhdGNoIEFORCBteSBwYXRjaDoNCj4gPg0KPiA+IFJl
YWRzDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgQmFuZHdpZHRoICAgICAgIEJhbmR3aWR0
aCAgICAgICBsYXRlbmN5ICAgICAgICAgbGF0ZW5jeQ0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIEJ5dGVzL3NlYyAgICAgICAlU3RkLkRldi4gICAgICAgbmFub3NlY3MgICAgICAgICVTdGQu
RGV2Lg0KPiA+IEJhc2VsaW5lICAgICAgICAgICAgICAgIDI1Njg5MTgyNDc3ICAgICAwLjE1ICAg
ICAgICAgICAgMzI2MTc3ICAgICAgICAgIDAuMTUNCj4gPiBDNiwgQzZQIGRpc2FibGVkICAgICAg
ICAyNTgzOTU4MDAxNCAgICAgMC4xOSAgICAgICAgICAgIDMyNDM0OSAgICAgICAgICAwLjE5DQo+
ID4gUmFwaGVscyBQYXRjaDogICAgICAgICAgMjU2OTU1MjM3NDcgICAgIDAuMDYgICAgICAgICAg
ICAzMjYxNTAgICAgICAgICAgMC4wNg0KPiA+IE15IHBhdGNoOiAgICAgICAgICAgICAgIDI1Nzgy
MDExODMzICAgICAwLjA3ICAgICAgICAgICAgMzI0OTk5ICAgICAgICAgIDAuMDcNCj4gPiBSYXBo
ZWwgKyBNeSBwYXRjaDogICAgICAyNTc5MjU1MTUxNCAgICAgMC4xMCAgICAgICAgICAgIDMyNDky
NCAgICAgICAgICAwLjEwDQo+IA0KPiBTbyB0aGVzZSBhcmUgbW9zdGx5IGVxdWFsIHJpZ2h0Pw0K
DQpOb3QgcmVhbGx5LCBpbiB0aGlzIGNhc2UsIHdlIGhhdmUgYW4gc3lzdGVtIHVuZGVyIGEgbG90
IG9mIHJhbmRvbSByZWFkIEkvTy4gRGlzYWJsaW5nIEM2IGluY3JlYXNlcw0KdGhlIHJlYWQgcmF0
ZSBzaW5jZSB3ZSAgcmVtb3ZlIHRoZSBsYXRlbmN5IGZyb20gdGhlIHNsZWVwIHN0YXRlcy4gV2l0
aCBteSBwYXRjaCB3ZSBhcHByb2FjaCB0aGUgQzYgZGlzYWJsZWQNCnJhdGUuIFRoZSByZXN1bHRz
IGFyZSBhbiBhdmVyYWdlIG9mIDUgcnVucywgdGhlIG1ldHJpY3MgaGF2ZSBmYWlybHkgbG93IGpp
dHRlciwgc28gSSBiZWxpZXZlIHRoZSByZWFkDQpyYXRlcyBhcmUgcmVsaWFibGUuIFdlJ3JlIGdl
dHRpbmcgYSBiZXR0ZXIgcmVhZCByYXRlIHdpdGggbXkgcGF0Y2ggdGhhbiB0aGUgYmFzZWxpbmUg
YW5kIHdpdGhvdXQgdGhlDQpwb3dlciBwZW5hbHR5IG9mIEM2IGJlaW5nIHBlcm1hbmVudGx5IGRp
c2FibGVkLiANCg0KPiANCj4gPg0KPiA+IFdyaXRlcw0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIEJhbmR3aWR0aCAgICAgICBCYW5kd2lkdGggICAgICAgbGF0ZW5jeSAgICAgICAgIGxhdGVu
Y3kNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBCeXRlcy9zZWMgICAgICAgJVN0ZC5EZXYu
ICAgICAgIG5hbm9zZWNzICAgICAgICAlU3RkLkRldi4NCj4gPiBCYXNlbGluZSAgICAgICAgICAg
ICAgICAxNTIyMDQ2ODg5OCAgICAgMy4zMyAgICAgICAgICAgIDU1MDI5MCAgICAgICAgICAzLjM2
DQo+ID4gQzYsIEM2UCBkaXNhYmxlZCAgICAgICAgMTM0MDU2MjQ3MDcgICAgIDAuNjYgICAgICAg
ICAgICA2MjU0MjQgICAgICAgICAgMC42Ng0KPiA+IFJhcGhlbHMgUGF0Y2g6ICAgICAgICAgIDE0
MDE3NjI1MjAwICAgICAxLjE1ICAgICAgICAgICAgNTk4MDQ5ICAgICAgICAgIDEuMTYNCj4gPiBN
eSBwYXRjaDogICAgICAgICAgICAgICAxNTQ0NDQxNzQ4OCAgICAgMy43MyAgICAgICAgICAgIDQ2
NzgxOCAgICAgICAgICAyOS4xMA0KPiA+IFJhcGhlbCArIE15IHBhdGNoOiAgICAgIDE0MDM3NzEx
MDMyICAgICAxLjEzICAgICAgICAgICAgNTk3MTQzICAgICAgICAgIDEuMTMNCj4gDQo+IFRoZXNl
IGRvbid0IG1ha2Ugc2Vuc2UgdG8gbWUsIHdoeSB3b3VsZCBDNiAvIEM2UCBiZSB0aGlzIGJhZD8N
Cg0KSSBkb3VibGUgY2hlY2tlZCwgaXQncyAuLmJlY2F1c2UgSSBnb3QgdGhlIHJvdyBsYWJlbHMg
bWl4ZWQgdXAgd2hlbiBwYXN0aW5nIHRoZSByZXN1bHRzIA0KaW50byB0aGUgZW1haWwuIERvaCEg
SXQgc2hvdWxkIGJlOg0KDQpCYXNlbGluZSAgICAgICAgICAgICAgICAgMTM0MDU2MjQ3MDcgICAg
IDAuNjYgICAgICAgICAgICA2MjU0MjQgICAgICAgICAgMC42Ng0KQzYsIEM2UCBkaXNhYmxlZCAg
IDE1MjIwNDY4ODk4ICAgICAzLjMzICAgICAgICAgICAgNTUwMjkwICAgICAgICAgIDMuMzYNCg0K
PiBXaHkgd291bGQgUmFmYWVsJ3MgcGF0Y2ggbWFrZSBpdCB3b3JzZT8NCj4gQXJlIHRoZXNlIGp1
c3Qgbm9pc2U/DQoNCg0KDQo+IA0KPiA+DQo+ID4gQ29tYmluZWQgUmVhZCtXcml0ZXMsIFJlYWRz
DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBCYW5kd2lkdGggICAgICAgQmFuZHdp
ZHRoICAgICAgIGxhdGVuY3kgICAgICAgICBsYXRlbmN5DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgQnl0ZXMvc2VjICAgICAgICVTdGQuRGV2LiAgICAgICBuYW5vc2VjcyAgICAgICAgJVN0
ZC5EZXYuDQo+ID4gQmFzZWxpbmUgICAgICAgICAgICAgICAgMTAxMzIyMjk0MzMgICAgIDAuNDEg
ICAgICAgICAgICA0ODQ5MTkgICAgICAgICAgMC4yNQ0KPiA+IEM2LCBDNlAgZGlzYWJsZWQgICAg
ICAgIDEwNTY3NTM2MzQ2ICAgICAwLjYwICAgICAgICAgICAgNTE1MjYwICAgICAgICAgIDEuMTYN
Cj4gPiBSYXBoZWxzIFBhdGNoOiAgICAgICAgICAxMDE3MTA0NDgxNyAgICAgMC4zNyAgICAgICAg
ICAgIDQ4NjkzNyAgICAgICAgICAwLjIwDQo+ID4gTXkgcGF0Y2g6ICAgICAgICAgICAgICAgMTA0
Njg5NTM1MjcgICAgIDAuMDcgICAgICAgICAgICA1MDQ3OTcgICAgICAgICAgMC4wNw0KPiA+IFJh
cGhlbCArIE15IHBhdGNoOiAgICAgIDEwMTc0NzA3NTQ2ICAgICAxLjI2ICAgICAgICAgICAgNDg4
MjYzICAgICAgICAgIDEuMTMNCj4gPg0KPiA+IENvbWJpbmVkIFJlYWQrV3JpdGVzLCBXcml0ZXMN
Cj4gPg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIEJhbmR3aWR0aCAgICAgICBCYW5kd2lk
dGggICAgICAgbGF0ZW5jeSAgICAgICAgIGxhdGVuY3kNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICBCeXRlcy9zZWMgICAgICAgJVN0ZC5EZXYuICAgICAgIG5hbm9zZWNzICAgICAgICAlU3Rk
LkRldi4NCj4gPiBCYXNlbGluZSAgICAgICAgICAgICAgICAxMDEzOTM5MzE2OSAgICAgMC40NCAg
ICAgICAgICAgIDM0MjEzMiAgICAgICAgICAxLjIzDQo+ID4gQzYsIEM2UCBkaXNhYmxlZCAgICAg
ICAgMTA1ODMyNjQ2NjIgICAgIDAuNjMgICAgICAgICAgICAyNzcwNTIgICAgICAgICAgMy44Nw0K
PiA+IFJhcGhlbHMgUGF0Y2g6ICAgICAgICAgIDEwMTc4Mjc1MDM1ICAgICAwLjM5ICAgICAgICAg
ICAgMzM2OTg5ICAgICAgICAgIDAuOTQNCj4gPiBNeSBwYXRjaDogICAgICAgICAgICAgICAxMDQ4
Mjc2NjU2OSAgICAgMS4yOCAgICAgICAgICAgIDI5NDgwMyAgICAgICAgICA2Ljg3DQo+ID4gUmFw
aGVsICsgTXkgcGF0Y2g6ICAgICAgMTAxODM4MzcyMzUgICAgIDAuMzggICAgICAgICAgICAzMzA2
NTcgICAgICAgICAgMy4zOQ0KPiANCj4gVGhlIGFib3ZlIHR3byBpbmRpY2F0ZSBhICszJSBmcm9t
IChub3cgbWFpbmxpbmUpIFJhZmFlbCdzIHBhdGNoIHRvIHlvdXJzLg0KPiBUaGVyZSdzIG5vIHJl
YXNvbiB3aHkgUmFmYWVsICsgeW91ciBwYXRjaCBzaG91bGQgYmUgd29yc2UgdGhhbiBqdXN0IHlv
dXINCj4gcGF0Y2guDQo+IElmIHRoaXMgaXMgc3RhdGlzdGljYWxseSBzaWduaWZpY2FudCB3ZSB3
b3VsZCBuZWVkIHRvIGxvb2sgaW50byB3aHkuDQo+IA0KPiBGV0lXIEkgdGhpbmsgdGhlIGVuZXJn
eSBjb3N0IG9mIGVzc2VudGlhbGx5IHJlbWFpbmluZyBpbiBwb2xsaW5nIGV2ZW4gZm9yIHF1aXRl
DQo+IHNwb3JhZGljIElPIGNhbid0IGJlIHVuZGVyc3RhdGVkIElNTy4NCj4gQ29tcGFyaXNvbiBm
b3IgdGVvLCB3aGljaCBtaWdodCBzbGlnaHRseSBiZXR0ZXIgdGhhbiBtZW51IHdoaWxlIG5vdCBv
dXRyaWdodA0KPiBkaXNhYmxpbmcgaWRsZSB3b3VsZCBiZSBpbnRlcmVzdGluZyBzdGlsbC4NCj4g
DQo+IA0KDQo=

