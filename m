Return-Path: <linux-pm+bounces-24144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B27A648C3
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 11:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40EB16C07A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 10:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBBC22CBE3;
	Mon, 17 Mar 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3FpAWMC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85E142E67;
	Mon, 17 Mar 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205986; cv=fail; b=TG8sueGP5u3xssykmotih7xoWsqPbiQJYh6uZCXLYXmBeN7iMl6GpC3gsxm7VVsD+XqlcjlMarMzPLz/lKvTMLTnUaxImm3QNY/Fl0HCvF8iXWxANC5pcxpclp701BOaSm9wYXAqLyaGk0dspc5IJzNnL1Y0hBphvzY9vYuLjQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205986; c=relaxed/simple;
	bh=Uj9RUTxb/xYMGhMzb2TwvQYJQQF8bDNuygal30bLZw8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tKHNtQVRU9+nM6t/fQqvFOECwXtMrV2mU0ciwnVuzknTEceXSzYld1ifAwREMB9yJccdkmM2lybrkGN8K1lJrGX4K6ICsfZfLU2UxntxHa/4wwhtadY/KmcGXCBa2BTRIXDCAVU2UWU0d9qgD6HXifndPCU/jI1/8gKXM/aBYVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3FpAWMC; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742205985; x=1773741985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uj9RUTxb/xYMGhMzb2TwvQYJQQF8bDNuygal30bLZw8=;
  b=C3FpAWMCusA5ITxG24L5PggamgWry4VatRt359Xe3uxWeKDRIeMt6zEl
   zDn3nAm5ymPfM1kgAb7ufIlUUwPetRtDmZzoJMqRItlz3KtxNyFJPc6Ak
   /zdav4um9guf1SJvHx3HWewg9BijyfGxrR0TLkFuagRPufE/IysyDoS7l
   brC5p8BLqHJECLTMFUMqH1+P1xI8zvepJmYME3+yADSyBTNexCik6Tacs
   l4WZQVahrdxo3bVHXhb1a6WfbdZc0Pn6kznWFSLlA8B3IiwzAwtJfsYw7
   1j/xKnymHtFifspzwe9f4uox+Oa7O263k/q5/2FdmtdHAYTmseMFngjln
   w==;
X-CSE-ConnectionGUID: T5Rlp8inQcqoHp3N+Lb9SQ==
X-CSE-MsgGUID: +3ug400/TOGH3RtcsCh/tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="30876727"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="30876727"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 03:06:24 -0700
X-CSE-ConnectionGUID: wEPVObm0RGmvYtmPb0NZeg==
X-CSE-MsgGUID: NILNhhalQMikcAd71QIZJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="126092874"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 03:06:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 03:06:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 03:06:19 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 03:04:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/h6h/ECLFRE11KZjWZtULytGcCm5WbmS0+cddycjsk3HV97ncxMb3bCPfYqDqQ2LnJVQnjUxumfHPg1nwydOEvHbY4X2lQA3o4RI01tGe3+MXERv2JUYw61+ClbS4b9oA3ZDNKYwOKOztTQDdR7BRu97uvzFDkyyTh4boMY0hpQiGpJMuOdGqVQnpNLM5aqNqZTyBS14gPOJ5taQHW3ETyk2WYr7DcXWs1KUlph81wPJt0+T3o9/w87daqU1zWHWIeBYbrGuUuA4UGuYA/7rLgY1Fs/wVX9cSIZvD2dHqfHqz5UTZORl0LbeO/BSxWxGLc2GgHzNSA2EZoVJQyGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj9RUTxb/xYMGhMzb2TwvQYJQQF8bDNuygal30bLZw8=;
 b=ILaBb1DeIeczQvzWfSJDPi1tWfwWzInZYJfTdWsBJBciJOtjPJH5JeEI/4uWWzm9sWwEDd+RAR6T0v7hIhCLXA41GnTGNUpWSpSy3ULtaaPYSv4cYqRodOF8OYjgFHHFicr4TKNGubGHcQ3BtlxScCjxPhLAfFs3FL6CG/RSIrBfQvx3ZMMFxSLLSQ00dTTDIDlFFHkFmNtempUwxyr6RvdKpw411Gjkn/ZDLOkTD8m/aSITAwuY5plqUtSizQrT2DSB9I0I3wL6AN6eht3BUSNyeRSgg/K1w+Ht90xXHtnDuI0rMPCeTc0Qy2NKdOPBaGKXD1XtUfyZDGL8rWOffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7670.namprd11.prod.outlook.com (2603:10b6:a03:4c3::18)
 by IA1PR11MB8247.namprd11.prod.outlook.com (2603:10b6:208:449::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 10:03:51 +0000
Received: from SJ2PR11MB7670.namprd11.prod.outlook.com
 ([fe80::c3bf:576d:1abc:eb24]) by SJ2PR11MB7670.namprd11.prod.outlook.com
 ([fe80::c3bf:576d:1abc:eb24%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 10:03:51 +0000
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
Thread-Index: AQHbjHwfO/1QphUhLUSIeLixfeE6q7Nh/R4AgBUtUjA=
Date: Mon, 17 Mar 2025 10:03:51 +0000
Message-ID: <SJ2PR11MB7670F63C7052C88637D305DF8DDF2@SJ2PR11MB7670.namprd11.prod.outlook.com>
References: <33882f284ac6e6d1ec766ca4bb2f3b88@intel.com>
 <f18607ca-30dc-43de-be77-fec69968aeec@arm.com>
In-Reply-To: <f18607ca-30dc-43de-be77-fec69968aeec@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7670:EE_|IA1PR11MB8247:EE_
x-ms-office365-filtering-correlation-id: 9bb8238e-ba48-484c-cc07-08dd653b0495
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OWZ3b0lZbHM4dGw1RXVpWmRpRDhBNmFUeHdEYUR4WDluNlR2UXZMQmY4T2hv?=
 =?utf-8?B?bWdYTkFobnprbzYrWWdFNXJ0c1JNZUIvMGF5SEp1ek8yNXQ2ZjlXMGpoOEIy?=
 =?utf-8?B?R3VRcDJDL0s1NlU4c1Bzb01FWnNNbE90dVh6eHJVdFFka0VLMWFSN2hXeHdT?=
 =?utf-8?B?Slg0U0g3dGVUUHhWMVh4L3RWNjdVVnZTZ092VGZtZVNGNGlqdEtGaTZsbm9h?=
 =?utf-8?B?V0Fjbzk3QTlGRGpWVnJDU25yTTJvWDc1WUdwUUJCU3ZPSVJqbU03cEJ6SHpi?=
 =?utf-8?B?T1lLMWk1Zm9JS1N0Y2V6YUdRQ3UwWjR1cEhja1hGTmdZaWthbEFqQXZ6Yjh2?=
 =?utf-8?B?REFOa3g3dXVlUUN2QkVBL0xMdTlGRnpQYUdGNUxjdXIramtnSHM5MXZOMmFz?=
 =?utf-8?B?MEpRMHpWd2tEbWQ2VmpDSTdVNU1VamhrS3M0OW1mQkd6RHlMclFKR0JhM0dT?=
 =?utf-8?B?WEdDSEgyRFM1cEtYWHlIclpKYmFUUWpKK3k4OVpYNVh5M1ZScWo4VTRFWWlh?=
 =?utf-8?B?V2Y4MU13cm9QYzN4c2V2QkpTVDFqdm52M0Q5UCtmL3IzNUNvTG03WGdnSWFV?=
 =?utf-8?B?MHlsN2dxbjVncVRuY0xrWE01K24xZ0poR1MrRTU5TFhQeGJvcFkyaVU1aWEy?=
 =?utf-8?B?SjNUTFVJVkh5VGxKODRDcXJwQWN6TWU1akFjM2JPdXpqTEZ0ZlB2SlV3dXgw?=
 =?utf-8?B?d3B3Ry8ySUd6LzFLTmZGVTJwTmsxRGNDL2c2ZXlOL1pqajRibGFLWjF0cjdh?=
 =?utf-8?B?c0hPb2JoZE9WS29jcFdtMGNKOEM4V1Q2L1pUTHZCQ2kwQXcrMkIxNnNYOEZS?=
 =?utf-8?B?a2JTc0c3Uk54ZDBFTDhjUXlMdURBZER0NTE2NjlyQ2VNMG5KT1VLbGlNRnB5?=
 =?utf-8?B?Z3dzbnlQNCtvZWVtbkVEaVl6MkF3aDRMNFlQZkRrYS9uSGc0b25YOGpQQm52?=
 =?utf-8?B?Wk1ST044bU9uR1ZRWlpQSnBqOWwzMTFWb1BpNFNZcklhRHdWN0JnUGNvYXV2?=
 =?utf-8?B?V1NpWUNJNmZwTzdGVVUwSlNnV1U4UHhpVXN3ZTFZWUlGN0xFZjFHRXRvQ0Vx?=
 =?utf-8?B?TFhnWkFtdTYybXpZSG5nSUp1MDBocVdCcGhQbFhZcWN0TCswWGNKRCtZVTFx?=
 =?utf-8?B?TlZKN0hGSW85NnZRaEhYcWZycmdCR1hiSnpjUFdHU1U4ZGhMcXdUVzJmUmF1?=
 =?utf-8?B?NUdRaEwvbjFWT2xTNzRWMnNQSTd1R1I1YWI3VzlrMG0zTFB5L25oTTdEZ1B4?=
 =?utf-8?B?bzZSc3hpQ2xQZS8vNDhCZUN4ekdVemptWUtiUzV1ZEVzRW0vU1kxYXFMRHFB?=
 =?utf-8?B?NDRqbHhqcEJNclRwc2Q1Z2R5aFVaQ0RCNjJ0N01CajNNRXRzNExJdjBncDNF?=
 =?utf-8?B?U09wbzFTeSt1UHBuVDRhbXlWcXRaMVVPM1lqQW5qZDJ6T3llNSsyQmY4TjlE?=
 =?utf-8?B?UEFUOGFYMmdWMWdpU1VRbStTSjFJUnZsNk96Qi9saXhVQVArRGlPQXV6Wld4?=
 =?utf-8?B?a0xzbWJuQ3UxL3d4N3RjNEVuNnRsNW52TlpPWkF6RWhlbUhsaGJOeVVWeWph?=
 =?utf-8?B?RnV0RTh6UTMrUG55YVBRcGJMM0VQNFo2dEtXNkhBc2Iza1BIcCtBaHZaVTUz?=
 =?utf-8?B?TTZwazgvNEhramxmQUliR3IyaThqZVZYWHlSVVFLend0OUZibHVHRk8xUFlC?=
 =?utf-8?B?Ukd6VVp2bmMxeGs3bjlielVEakhZVUwyODVSdVNCVXpZWmFkeWczWld3UjNW?=
 =?utf-8?B?L0JFa2YyTlBoUmYzTGEraVZDYko2Si85VWZ4c2w0ZThROEJXY0toaE50QzMx?=
 =?utf-8?B?MWlENGJiNTJDZHZKSzdMckFrZVZwdVA0bWE5QUQ2L0pTQXhCVlJ4ZlRPOUVu?=
 =?utf-8?B?bzRIelI2eUMvUXB2a2QxcmMyU1BHZHZIYWVvVFdpRDY2V2R1MHovcGtvSXpr?=
 =?utf-8?Q?HymZKlyzu2lalYwXFG/8qR1sWYouD5bb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7670.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlFSWFlmb09VWnFWTytmR2I5elFyT3RjQ0ZIejhaZ09xVGM5TGo1SGZVYXpr?=
 =?utf-8?B?NXkvVVZRNllOYjRKci9pMGlRL01NUHFnQnQwQW1TWXp0WUNQa2FXVnRXQ0ZZ?=
 =?utf-8?B?NG9BUzg1TFliMWFoQ2Z1Vlc0OGJHYnRNOUE0bTI2bkJCODQ4bHBOek55MGNT?=
 =?utf-8?B?L1NxT3Z3d3JRa1hJWng3UlFmUzN1MmJjUzdYSEhmOUpLOXlOSG1GNHRkSHVD?=
 =?utf-8?B?U1pWMzhmK3I2S3ZaemFkRm9QdkF2Y25FWmZocEViN1FOUkswNnlkMlhIeTd2?=
 =?utf-8?B?bmhhNGlwVExONmNiQUFoQ2JhYmhNR25WV1kyV1cweEdmZm80ZkZTUjFMckZ3?=
 =?utf-8?B?a1pwMzNFcElVN2I5d2x1UWtEMGxXS0NNYjJ5NVQ0QnJYTXlqVjhSbE5NV1cz?=
 =?utf-8?B?aU90RXlNTUwrOCtia1N3TDFPbk5HYWhUdXYwNEFYVWo1eEo0OEJiQjlZZVNC?=
 =?utf-8?B?djg2eXRaWkg3VzRDVnpxNjlweWY5U00xcFE4cjRNOUtjZ3hXS2h1amdUNG1i?=
 =?utf-8?B?Z1ozbzVXSStPZytWZzdWdE5xWnBYWFFDelZNU1ZmMzU2T3BxZTdrK1NDTUVS?=
 =?utf-8?B?NHN2YmkyWUx1KzJ4L0xXaXdpVy9lWEQ4NE9PVUo5NEdDMkg0UXRySlRKMmpN?=
 =?utf-8?B?Y1FSTWhZaURrOHBWUzR6dDgvM3p0UHFUVTRqUFBXLzBhOVF0Z2NBcmdFbWpX?=
 =?utf-8?B?OEcxN1ZBL2poQjNPYldIMDIwdmFHcVZJSWJwaXlxSlBJdFk1ZVoxeDdqc3dT?=
 =?utf-8?B?ZUJUeHRRM1RmaXpRSWVRTWFvV1JKSG50dHh0UElkODk2S3FmTmhaOFZzemVs?=
 =?utf-8?B?M3pSc2dPcjkzdEJ3bXkvNVhFa0duM0wzT0x3UThzWU01V3I0V0NENUp5Q1BR?=
 =?utf-8?B?WGkyRGhvZGFxaUJLVTRpOTFJME0vSUhzcVlkRGprLy8yK2tDaFVsKzZIR1dJ?=
 =?utf-8?B?Uy94RE5iczZQMVg4bG9WZEh0QXBocWlBN3crZytLSlE2dGxEcE05UWhhSVhX?=
 =?utf-8?B?SjJwVjlycFh1WFV0cUVvWktaZzRsckhnT2VuakcrV1Q5RnJDSGxJcFpGbmNj?=
 =?utf-8?B?RG5pZ0VXQml1Z0doUEdSN3Mwbk9wejRPV1M4VUFCY2RXelRKUER0anZ2K1F0?=
 =?utf-8?B?bHFFU1RDQXV5OWJJa2J1YnYzb2c0TXdmY1FSQ3FrRHo3OUJtck8wL3FQeEty?=
 =?utf-8?B?Z0tRenVISlljNWpwTmQxeXE0c0RNK0lPWHFQQ1h0U0huUFBHYzlvZ3VXaDJE?=
 =?utf-8?B?ZjdFN1JiMkNQMTc5ZjBUNWlEd3J3MzVacG1sNnBEY04xQnlrUzluMENKKzdD?=
 =?utf-8?B?eTE0L0dqdC9lNTNsc0VUR3B5TFQ3UFZtUjI4NDRoZzIreE4yckpCMmFWQ0ZK?=
 =?utf-8?B?ZDNrc1NBUXo5UlM5WGZSZXh6NVp6N0FOVTZBYkhXN3M0a202MnNhT2NLVXZt?=
 =?utf-8?B?UXRudjNFVDdXNDhia0Z1dTlEOFJFaXVxMDBmeG9CWnR3Y0J6eStrOGY3b21s?=
 =?utf-8?B?MW1LVmJZeDYwM29YOXQvQ3lvUUpLb01aYVR2SXBlQ0lGR3A3TlNHQ0JtQXBX?=
 =?utf-8?B?RUFBeDZrYzMyWU8zU1dWL0FtSGNHZUJ6V0oycnZES0xjV1Nlb3ZhSEx3Tkxm?=
 =?utf-8?B?V0s4U290cmZxUmZxQkxhZHp0U01MVVpGOThBNFhHZklrcWk3Q0ZVY0dTWE5C?=
 =?utf-8?B?bVVqMnZUb2Z6Wlhpd3U4RDBWZmJpR2pGaWRqaXBOQU5vR0NqOVNTbk1VRERF?=
 =?utf-8?B?YTVYem0vSTVLMGxDa0JGQVlXMHE3VHhMT0E1Njh2S2RWRG1iZTZycUZCaVQ5?=
 =?utf-8?B?QVNYVSt3bVh2VzFNVGRydXNST3Q3YURNSWJaOVQxaHZqc3dxNG05WnA3M214?=
 =?utf-8?B?dXBJQi9LVXRwS3dJZmIxSXhnVXlERTYzcVEzbWdPb1RoVGJ5YnBEQk5wQ2k1?=
 =?utf-8?B?NHFGbWVrdHcwdWV2WnZvNHIyNGkxMGJJR2Z0R0lEeldVbGVpZFZUNjA4aGxj?=
 =?utf-8?B?YVpsL3NOeXFsNDRNMHlFWVJmbXhyM1JxM1RWQlhoUTY1VE9LYVBwUDdXZklY?=
 =?utf-8?B?MEthU2ZlUHo0S25XQU1OYVFXeG9ZaFczSWQxQ2hNL3FFQjFHWS9Rck1QbzRp?=
 =?utf-8?Q?rzRIUUnl/QgXr8A030NGdROwM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb8238e-ba48-484c-cc07-08dd653b0495
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 10:03:51.0705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 53/PvgrDr2xcOiz20ARtChWTifPeXhR3Dh8xOYLmRJEw2av/2wgQ91WlXyGh55EgxqLibzKGzpAU5ayTXuMnig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8247
X-OriginatorOrg: intel.com

SGkgQ2hyaXN0aWFuLCANCg0KRm9sbG93LXVwIGJlbG93Og0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IENocmlzdGlhbiBMb2VobGUgPGNocmlzdGlhbi5sb2VobGVAYXJt
LmNvbT4NCj4gU2VudDogMDMgTWFyY2ggMjAyNSAyMjoyNQ0KPiBUbzogS2luZywgQ29saW4gPGNv
bGluLmtpbmdAaW50ZWwuY29tPjsgSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPjsgUmFmYWVs
DQo+IEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgRGFuaWVsIExlemNhbm8gPGRhbmll
bC5sZXpjYW5vQGxpbmFyby5vcmc+Ow0KPiBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LXBtQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjcHVpZGxlOiBwc2Q6IGFkZCBwb3dlciBzbGVlcCBk
ZW1vdGlvbiBwcmV2ZW50aW9uIGZvcg0KPiBmYXN0IEkvTyBkZXZpY2VzDQo+IA0KPiBPbiAzLzMv
MjUgMTY6NDMsIENvbGluIElhbiBLaW5nIHdyb3RlOg0KPiA+IE1vZGVybiBwcm9jZXNzb3JzIGNh
biBkcm9wIGludG8gZGVlcCBzbGVlcCBzdGF0ZXMgcmVsYXRpdmVseSBxdWlja2x5DQo+ID4gdG8g
c2F2ZSBwb3dlci4gSG93ZXZlciwgY29taW5nIG91dCBvZiBkZWVwIHNsZWVwIHN0YXRlcyB0YWtl
cyBhIHNtYWxsDQo+ID4gYW1vdW50IG9mIHRpbWUgYW5kIHRoaXMgaXMgZGV0cmltZW50YWwgdG8g
cGVyZm9ybWFuY2UgZm9yIEkvTyBkZXZpY2VzDQo+ID4gc3VjaCBhcyBmYXN0IFBDSWUgTlZNRSBk
cml2ZXMgd2hlbiBzZXJ2aWNpbmcgYSBjb21wbGV0ZWQgSS9PDQo+ID4gdHJhbnNhY3Rpb25zLg0K
PiA+DQo+ID4gVGVzdGluZyB3aXRoIGZpbyB3aXRoIHJlYWQvd3JpdGUgUkFJRDAgUENJZSBOVk1F
IGRldmljZXMgb24gdmFyaW91cw0KPiA+IG1vZGVybiBTTVAgYmFzZWQgc3lzdGVtcyAoc3VjaCBh
cyA5NiB0aGVhZCBHcmFuaXRlIFJhcGlkcyBYZW9uIDY3NDFQKQ0KPiA+IGhhcyBzaG93biB0aGF0
IG9uIDg1LTkwJSBvZiByZWFkL3dyaXRlIHRyYW5zYWN0aW9ucyBpc3N1ZWQgb24gYSBDUFUNCj4g
PiBhcmUgY29tcGxldGVkIGJ5IHRoZSBzYW1lIENQVSwgc28gaXQgbWFrZXMgc29tZSBzZW5zZSB0
byBwcmV2ZW50IHRoZQ0KPiA+IENQVSBmcm9tIGRyb3BwaW5nIGludG8gYSBkZWVwIHNsZWVwIHN0
YXRlIHRvIGhlbHAgcmVkdWNlIEkvTyBoYW5kbGluZw0KPiA+IGxhdGVuY3kuDQo+IA0KPiBGb3Ig
dGhlIHBsYXRmb3JtIHlvdSB0ZXN0ZWQgb24gdGhhdCBtYXkgYmUgdHJ1ZSwgYnV0IGV2ZW4gaWYg
d2UgY29uc3RyYWluDQo+IG91cnNlbHZlcyB0byBwY2ktbnZtZSB0aGVyZSdzIGEgdmFyaWV0eSBv
ZiBxdWV1ZS9pcnEgbWFwcGluZ3Mgd2hlcmUgdGhpcw0KPiBkb2Vzbid0IGhvbGQgSSdtIGFmcmFp
ZC4NCg0KVGhpcyBjb2RlIGlzIG9wdGlvbmFsLCBvbmUgY2FuIGVuYWJsZSBpdCBvciBkaXNhYmxl
IGl0IHZpYSB0aGUgY29uZmlnIG9wdGlvbi4gQWxzbywgDQpldmVuIHdoZW4gaXQgaXMgYnVpbHQt
aW4gb25lIGNhbiBkaXNhYmxlIGl0IGJ5IHdyaXRpbmcgMCB0byB0aGUgc3lzZnMgZmlsZQ0KICAv
c3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHVpZGxlL3BzZF9jcHVfbGF0X3RpbWVvdXRfbXMNCg0K
PiANCj4gPg0KPiA+IFRoaXMgY29tbWl0IGludHJvZHVjZXMgYSBzaW1wbGUsIGxpZ2h0d2VpZ2h0
IGFuZCBmYXN0IHBvd2VyIHNsZWVwDQo+ID4gZGVtb3Rpb24gbWVjaGFuaXNtIHRoYXQgcHJvdmlk
ZXMgdGhlIGJsb2NrIGxheWVyIGEgd2F5IHRvIGluZm9ybSB0aGUNCj4gPiBtZW51IGdvdmVybm9y
IHRvIHByZXZlbnQgYSBDUFUgZnJvbSBnb2luZyBpbnRvIGEgZGVlcCBzbGVlcCB3aGVuIGFuDQo+
ID4gSS9PIG9wZXJhdGlvbiBpcyByZXF1ZXN0ZWQuIFdoaWxlIGl0IGlzIHRydWUgdGhhdCBzb21l
IEkvT3MgbWF5IG5vdA0KPiANCj4gcy9yZXF1ZXN0ZWQvY29tcGxldGVkIGlzIHRoZSBmdWxsIHRy
dXRoLCBpc24ndCBpdD8NCj4gDQo+ID4gYmUgc2VydmljZWQgb24gdGhlIHNhbWUgQ1BVIHRoYXQg
aXNzdWVkIHRoZSBJL08gcmVxdWVzdCBhbmQgaGVuY2UgaXMNCj4gPiBub3QgMTAwJSBwZXJmZWN0
IHRoZSBtZWNoYW5pc20gZG9lcyB3b3JrIHdlbGwgaW4gdGhlIHZhc3QgbWFqb3JpdHkgb2YNCj4g
PiBJL08gb3BlcmF0aW9ucyBhbmQgdGhlcmUgaXMgdmVyeSBzbWFsbCBvdmVyaGVhZCB3aXRoIHRo
ZSBzbGVlcA0KPiA+IGRlbW90aW9uIHByZXZlbnRpb24uDQo+ID4NCj4gPiBUZXN0IHJlc3VsdHMg
b24gYSA5NiB0aHJlYWQgWGVvbiA2NzQxUCB3aXRoIGEgNiB3YXkgUkFJRDAgUENJZSBOVk1FIG1k
DQo+ID4gYXJyYXkgdXNpbmcgZmlvIDMuMzUgcGVyZm9ybWluZyByYW5kb20gcmVhZCBhbmQgcmVh
ZC13cml0ZSB0ZXN0IG9uIGENCj4gPiA1MTJHQiBmaWxlIHdpdGggOCBjb25jdXJyZW50IEkvTyBq
b2JzLiBUZXN0ZWQgd2l0aCB0aGUNCj4gPiBOSE1fQzFfQVVUT19ERU1PVEUgYml0IHNldCBpbiBN
U1JfUEtHX0NTVF9DT05GSUdfQ09OVFJPTCBzZXQgaW4NCj4gdGhlIEJJT1MuDQo+ID4NCj4gPiBU
ZXN0IGNhc2U6IHJhbmRvbSByZWFkcywgcmVzdWx0cyBiYXNlZCBvbiBnZW9tZXRpYyBtZWFuIG9m
IHJlc3VsdHMNCj4gPiBmcm9tDQo+ID4gNSB0ZXN0IHJ1bnM6DQo+ID4gICAgICAgICAgICBCYW5k
d2lkdGggICAgICAgICBJTy1vcHMgICBMYXRlbmN5ICAgQmFuZHdpZHRoDQo+ID4gICAgICAgICAg
ICByZWFkIChieXRlcy9zZWMpICBwZXIgc2VjICAgIChucykgICAgJSBTdGQuRGV2aWF0aW9uDQo+
ID4gQmFzZWxpbmU6ICAyMTM2NTc1NTYxMAkgICAgIDIwMzc3ICAgICAzOTAxMDUgICAxLjg2JQ0K
PiA+IFBhdGNoZWQ6ICAgMjU5NTAxMDc1NTggICAgICAgMjQ3NDggICAgIDMyMjkwNSAgIDAuMTYl
DQo+IA0KPiBXaGF0IGlzIHRoZSBiYXNlbGluZT8NCj4gRG8geW91IG1pbmQgdHJ5aW5nIHdpdGgg
UmFmYWVsJ3MgcmVjZW50bHkgcG9zdGVkIHNlcmllcz8NCj4gR2l2ZW4gdGhlIElPUFMgSSdkIGV4
cGVjdCBnb29kIHJlc3VsdHMgZnJvbSB0aGF0IGFsb25lIGFscmVhZHkuDQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvMTkxNjY2OC50ZFdWOVNFcUNoQHJqd3lzb2NraS5uZXQvDQo+IA0K
PiAoSGFwcHkgdG8gc2VlIHRlbyBhcyBjb21wYXJpc29uIHRvbywgd2hpY2ggeW91IGRvbid0IG1v
ZGlmeSkuDQoNCk9LLCBJIHJlLXJhbiB0aGUgdGVzdHMgb24gNi4xNC1yYzUgb24gdGhlIHNhbWUg
SC9XLiBUaGUgIkJhc2VsaW5lIiBpcyA2LjE0LXJjNSB3aXRob3V0DQpSYXBoZWwncyBwYXRjaC4g
SSBhbHNvIHRlc3RpbmcgdGhlIEJhc2VsaW5lIHdpdGggQzYgYW5kIEM2UCBkaXNhYmxlZCBhcyB0
aGlzIHN0b3BzIGRlZXBlcg0KQy1zdGF0ZSBzbGVlcHMgYW5kIGluIHRoZW9yeSBzaG91bGQgcHJv
dmlkZSAiYmVzdCBwZXJmb3JtYW5jZSIuIEkgYWxzbyBiZW5jaG1hcmtlZCB3aXRoDQpSYXBoZWwn
cyBwYXRjaCBhbmQganVzdCBteSBwYXRjaCwgYW5kIGZpbmFsbHkgUmFwaGVscyBwYXRjaCBBTkQg
bXkgcGF0Y2g6DQoNClJlYWRzDQogICAgICAgICAgICAgICAgICAgICAgICBCYW5kd2lkdGggICAg
ICAgQmFuZHdpZHRoICAgICAgIGxhdGVuY3kgICAgICAgICBsYXRlbmN5DQogICAgICAgICAgICAg
ICAgICAgICAgICBCeXRlcy9zZWMgICAgICAgJVN0ZC5EZXYuICAgICAgIG5hbm9zZWNzICAgICAg
ICAlU3RkLkRldi4NCkJhc2VsaW5lICAgICAgICAgICAgICAgIDI1Njg5MTgyNDc3ICAgICAwLjE1
ICAgICAgICAgICAgMzI2MTc3ICAgICAgICAgIDAuMTUNCkM2LCBDNlAgZGlzYWJsZWQgICAgICAg
IDI1ODM5NTgwMDE0ICAgICAwLjE5ICAgICAgICAgICAgMzI0MzQ5ICAgICAgICAgIDAuMTkNClJh
cGhlbHMgUGF0Y2g6ICAgICAgICAgIDI1Njk1NTIzNzQ3ICAgICAwLjA2ICAgICAgICAgICAgMzI2
MTUwICAgICAgICAgIDAuMDYNCk15IHBhdGNoOiAgICAgICAgICAgICAgIDI1NzgyMDExODMzICAg
ICAwLjA3ICAgICAgICAgICAgMzI0OTk5ICAgICAgICAgIDAuMDcNClJhcGhlbCArIE15IHBhdGNo
OiAgICAgIDI1NzkyNTUxNTE0ICAgICAwLjEwICAgICAgICAgICAgMzI0OTI0ICAgICAgICAgIDAu
MTANCg0KV3JpdGVzDQogICAgICAgICAgICAgICAgICAgICAgICBCYW5kd2lkdGggICAgICAgQmFu
ZHdpZHRoICAgICAgIGxhdGVuY3kgICAgICAgICBsYXRlbmN5DQogICAgICAgICAgICAgICAgICAg
ICAgICBCeXRlcy9zZWMgICAgICAgJVN0ZC5EZXYuICAgICAgIG5hbm9zZWNzICAgICAgICAlU3Rk
LkRldi4NCkJhc2VsaW5lICAgICAgICAgICAgICAgIDE1MjIwNDY4ODk4ICAgICAzLjMzICAgICAg
ICAgICAgNTUwMjkwICAgICAgICAgIDMuMzYNCkM2LCBDNlAgZGlzYWJsZWQgICAgICAgIDEzNDA1
NjI0NzA3ICAgICAwLjY2ICAgICAgICAgICAgNjI1NDI0ICAgICAgICAgIDAuNjYNClJhcGhlbHMg
UGF0Y2g6ICAgICAgICAgIDE0MDE3NjI1MjAwICAgICAxLjE1ICAgICAgICAgICAgNTk4MDQ5ICAg
ICAgICAgIDEuMTYNCk15IHBhdGNoOiAgICAgICAgICAgICAgIDE1NDQ0NDE3NDg4ICAgICAzLjcz
ICAgICAgICAgICAgNDY3ODE4ICAgICAgICAgIDI5LjEwDQpSYXBoZWwgKyBNeSBwYXRjaDogICAg
ICAxNDAzNzcxMTAzMiAgICAgMS4xMyAgICAgICAgICAgIDU5NzE0MyAgICAgICAgICAxLjEzDQoN
CkNvbWJpbmVkIFJlYWQrV3JpdGVzLCBSZWFkcw0KDQogICAgICAgICAgICAgICAgICAgICAgICBC
YW5kd2lkdGggICAgICAgQmFuZHdpZHRoICAgICAgIGxhdGVuY3kgICAgICAgICBsYXRlbmN5DQog
ICAgICAgICAgICAgICAgICAgICAgICBCeXRlcy9zZWMgICAgICAgJVN0ZC5EZXYuICAgICAgIG5h
bm9zZWNzICAgICAgICAlU3RkLkRldi4NCkJhc2VsaW5lICAgICAgICAgICAgICAgIDEwMTMyMjI5
NDMzICAgICAwLjQxICAgICAgICAgICAgNDg0OTE5ICAgICAgICAgIDAuMjUNCkM2LCBDNlAgZGlz
YWJsZWQgICAgICAgIDEwNTY3NTM2MzQ2ICAgICAwLjYwICAgICAgICAgICAgNTE1MjYwICAgICAg
ICAgIDEuMTYNClJhcGhlbHMgUGF0Y2g6ICAgICAgICAgIDEwMTcxMDQ0ODE3ICAgICAwLjM3ICAg
ICAgICAgICAgNDg2OTM3ICAgICAgICAgIDAuMjANCk15IHBhdGNoOiAgICAgICAgICAgICAgIDEw
NDY4OTUzNTI3ICAgICAwLjA3ICAgICAgICAgICAgNTA0Nzk3ICAgICAgICAgIDAuMDcNClJhcGhl
bCArIE15IHBhdGNoOiAgICAgIDEwMTc0NzA3NTQ2ICAgICAxLjI2ICAgICAgICAgICAgNDg4MjYz
ICAgICAgICAgIDEuMTMNCg0KQ29tYmluZWQgUmVhZCtXcml0ZXMsIFdyaXRlcw0KDQogICAgICAg
ICAgICAgICAgICAgICAgICBCYW5kd2lkdGggICAgICAgQmFuZHdpZHRoICAgICAgIGxhdGVuY3kg
ICAgICAgICBsYXRlbmN5DQogICAgICAgICAgICAgICAgICAgICAgICBCeXRlcy9zZWMgICAgICAg
JVN0ZC5EZXYuICAgICAgIG5hbm9zZWNzICAgICAgICAlU3RkLkRldi4NCkJhc2VsaW5lICAgICAg
ICAgICAgICAgIDEwMTM5MzkzMTY5ICAgICAwLjQ0ICAgICAgICAgICAgMzQyMTMyICAgICAgICAg
IDEuMjMNCkM2LCBDNlAgZGlzYWJsZWQgICAgICAgIDEwNTgzMjY0NjYyICAgICAwLjYzICAgICAg
ICAgICAgMjc3MDUyICAgICAgICAgIDMuODcNClJhcGhlbHMgUGF0Y2g6ICAgICAgICAgIDEwMTc4
Mjc1MDM1ICAgICAwLjM5ICAgICAgICAgICAgMzM2OTg5ICAgICAgICAgIDAuOTQNCk15IHBhdGNo
OiAgICAgICAgICAgICAgIDEwNDgyNzY2NTY5ICAgICAxLjI4ICAgICAgICAgICAgMjk0ODAzICAg
ICAgICAgIDYuODcNClJhcGhlbCArIE15IHBhdGNoOiAgICAgIDEwMTgzODM3MjM1ICAgICAwLjM4
ICAgICAgICAgICAgMzMwNjU3ICAgICAgICAgIDMuMzkgICAgICANCj4gDQo+ID4NCj4gPiBSZWFk
IHJhdGUgaW1wcm92ZW1lbnQgb2YgfjIxJS4NCj4gPg0KPiA+IFRlc3QgY2FzZTogcmFuZG9tIHJl
YWQrd3JpdGVzLCByZXN1bHRzIGJhc2VkIG9uIGdlb21ldGljIG1lYW4gb2YNCj4gPiByZXN1bHRz
IGZyb20gNSB0ZXN0IHJ1bnM6DQo+ID4NCj4gPiAgICAgICAgICAgIEJhbmR3aWR0aCAgICAgICAg
IElPLW9wcyAgIExhdGVuY3kgICBCYW5kd2lkdGgNCj4gPiAgICAgICAgICAgIHJlYWQgKGJ5dGVz
L3NlYykgIHBlciBzZWMgICAgKG5zKSAgICAlIFN0ZC5EZXZpYXRpb24NCj4gPiBCYXNlbGluZTog
ICA5OTM3ODQ4MjI0ICAgICAgICA5NDc3ICAgICA1NTAwOTQgICAxLjA0JQ0KPiA+IFBhdGNoZWQ6
ICAgMTA1MDI1OTI1MDggICAgICAgMTAwMTYgICAgIDUwOTMxNSAgIDEuODUlDQo+ID4NCj4gPiBS
ZWFkIHJhdGUgaW1wcm92ZW1lbnQgb2YgfjUuNyUNCj4gPg0KPiA+ICAgICAgICAgICAgQmFuZHdp
ZHRoICAgICAgICAgSU8tb3BzICAgTGF0ZW5jeSAgIEJhbmR3aWR0aA0KPiA+ICAgICAgICAgICAg
d3JpdGUgKGJ5dGVzL3NlYykgcGVyIHNlYyAgICAobnMpICAgICUgU3RkLkRldmlhdGlvbg0KPiA+
IEJhc2VsaW5lOiAgIDk5NDUxOTc2NTYgICAgICAgIDk0ODQgICAgIDI4ODkzMyAgIDEuMDIlDQo+
ID4gUGF0Y2hlZDogICAxMDUxNzI2ODQwMCAgICAgICAxMDAzMCAgICAgMjg3MDI2ICAgMS44NSUN
Cj4gPg0KPiA+IFdyaXRlIHJhdGUgaW1wcm92ZW1lbnQgb2YgfjUuNyUNCj4gPg0KPiA+IEZvciBr
ZXJuZWwgYnVpbGRzLCB3aGVyZSBhbGwgQ1BVcyBhcmUgZnVsbHkgbG9hZGVkIG5vIHBlcmZvbWFu
Y2UNCj4gPiBpbXByb3ZlbWVudCBvciByZWdyZXNzaW9ucyB3ZXJlIG9ic2VydmVkIGJhc2VkIG9u
IHRoZSByZXN1bHRzIG9mDQo+ID4gNSBrZXJuZWwgYnVpbGQgdGVzdCBydW5zLg0KPiA+DQo+ID4g
QnkgZGVmYXVsdCwgQ1BVIHBvd2VyIHNsZWVwIGRlbW90aW9uIGJsb2NraW5nIGlzIHNldCB0byBy
dW4gZm9yIDMgbXMNCj4gPiBvbiBJL08gcmVxdWVzdHMsIGJ1dCB0aGlzIGNhbiBiZSBtb2RpZmll
ZCB1c2luZyB0aGUgbmV3IHN5c2ZzDQo+ID4gaW50ZXJmYWNlOg0KPiA+DQo+ID4gICAvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9jcHVpZGxlL3BzZF9jcHVfbGF0X3RpbWVvdXRfbXMNCj4gDQo+IHJv
dW5kaW5nIHVwIGEgamlmZmllIHN1cmUgaXMgYSBoZWF2eSBwcmljZSB0byBwYXkgdGhlbi4NCg0K
SmlmZmllcyB3ZXJlIHVzZWQgYmVjYXVzZSB0aGUgY29kZSBpcyBkZXNpZ25lZCB0byBiZSBhcyBs
aWdodC13ZWlnaHQgYXMgcG9zc2libGUuIFJvdW5kaW5nIGl0IHVwIGlzbid0DQpwcm9ibGVtYXRp
YywgdXNpbmcgaGlnaGVyIHByZWNpc2lvbiB0aW1pbmcgaXMgbW9yZSBDUFUgZXhwZW5zaXZlIGFu
ZCByZWFsbHkgZG9lc24ndCBnYWluIHVzIGFueSBleHRyYQ0Kd2luIGZvciB0aGlzIGtpbmQgb2Yg
dGltZSByZXNvbHV0aW9uLiAgV2UgbmVlZCB0aGUgY29kZSB0byBiZSBsaWdodCB3ZWlnaHQgYW5k
ICJnb29kLWVub3VnaCIgb24gdGhlIEkvTw0KcGF0aCByYXRoZXIgdGhhbiBvdmVybHkgZXhwZW5z
aXZlIGFuZCAiMTAwJSBwZXJmZWN0Ii4NCg0KPiANCj4gPg0KPiA+IHNldHRpbmcgdGhpcyB0byB6
ZXJvIHdpbGwgZGlzYWJsZWQgdGhlIG1lY2hhbmlzbS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgYmxv
Y2svYmxrLW1xLmMgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KPiA+ICBkcml2ZXJzL2NwdWlk
bGUvS2NvbmZpZyAgICAgICAgICB8ICAxMCArKysNCj4gPiAgZHJpdmVycy9jcHVpZGxlL01ha2Vm
aWxlICAgICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL2NwdWlkbGUvZ292ZXJub3JzL21lbnUu
YyB8ICAgNCArDQo+ID4gIGRyaXZlcnMvY3B1aWRsZS9wc2QuYyAgICAgICAgICAgIHwgMTIzICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9saW51eC9jcHVpZGxl
X3BzZC5oICAgICAgfCAgMzIgKysrKysrKysNCj4gPiAgNiBmaWxlcyBjaGFuZ2VkLCAxNzIgaW5z
ZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jcHVpZGxlL3BzZC5j
ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBpbmNsdWRlL2xpbnV4L2NwdWlkbGVfcHNkLmgNCj4g
Pg0K

