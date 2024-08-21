Return-Path: <linux-pm+bounces-12592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE495928D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 04:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640231C22B50
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 02:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4366374BED;
	Wed, 21 Aug 2024 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4yJzvG6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6589856440;
	Wed, 21 Aug 2024 01:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205576; cv=fail; b=HQ5NA9xp/JpRFII5YOq89reOh0O9KC3SZ24wN/gYNqzDFeidZ2qV3BBTGv/2JD4S8Yd6s93BHSBCpjex4pwf1NB4bLWMWWsbpY9r3lTWusM6i8wAd+Z4+fx/BLrju6pqPPNKa0qepV0QansN2OfL5ZNnYuXEuVhCjYTn3rNbVp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205576; c=relaxed/simple;
	bh=2viOCbV4nEinqh2R6XjDHx4ejvmnk6DlAIf9WlEsCEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HK4MEivbDCZU+9x5yK2utDris3n3qDJQmEaAZ+k8F2kodmy7vrqMl3eAkqZ+vUenlQslOq7D/aYjSkrxhhcBNZaw4yYyFXyDjaMlDVfF2BcjQ6VW6QbJoWumUldmOGZuPWkeX1CiDebxuZDpINCNv8HBt9+PpeFELxCemtp/3tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4yJzvG6; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205574; x=1755741574;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2viOCbV4nEinqh2R6XjDHx4ejvmnk6DlAIf9WlEsCEU=;
  b=W4yJzvG6PhD8yv/DlwMqufUT2wtp5A85GKvjfpKAcMu8+ENbdbeGIDPI
   G2QkN7mOJX80FaDofiAv+od5Bk46pVASIfbIYLa9edtWrPbHISboZWtER
   WCDkpAb+hRH9tOGToDUJhbSCkwpdENdibnC3rzhZVdia83CzNy+oW7ReL
   jagzyxM9WTxRsIhTTZowrGNgM+Lda8OPtKWKqAdIGTbnYEAkX0E41bFMI
   JJg7p7bg1HiWLHStXSBmUEXYCvoJPdNT8m14UlrQuZNj7mnvnLoHz+Dru
   KNY5pEohzGiHh7FtPbay8CdKZhF+TpNP7cnv7PsbWPsALRwZDK7HocX2K
   g==;
X-CSE-ConnectionGUID: aoEyQht7Rf6pDaG5E2q9oQ==
X-CSE-MsgGUID: d2Z3ZgbLSiyr6Q1ijDN02A==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33109177"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33109177"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:59:34 -0700
X-CSE-ConnectionGUID: Rn8VIJhRTv+UpGvDDiimXA==
X-CSE-MsgGUID: mHR5Rm3XRv2s+oQrPbA6bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61079280"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 18:59:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 18:59:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 18:59:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 18:59:32 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 18:59:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWyDnz0UhnnVRPwNi0Tk++7wyBQrWkIA41OzjO7kP49TCKqQa93o5a9OEQrikoDpRwpdJ0DvwTg11MdfcrCVezyrdBUUQacU+0f+5D+8fWll2ZGO8h//4XAMMP9aDwWenPiGRygSCmjlW70sUOrUUmvi2YqtZwzvVftXKUjU+0nVJhNl76nyJB7rgHJeUp93XzbmjxzRzMAiar1NRck5QLCOlxssdZDyMZDqHvMvX5NFlYJGQNfTYy+I0DF4IZbn4r3FIixmH6Fa9R9uTv3rwyjM3RSW0JwerbQERR7gegUahpRd5Sc7v+iAMgy9wXSDKCKUM1B7yD937Jn1QbrPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2viOCbV4nEinqh2R6XjDHx4ejvmnk6DlAIf9WlEsCEU=;
 b=Czx3UqdMPAtDES6HYraGMRKoaocvgA75iuk3WMG9Cdbaxo82ZB3JZYgrTog7x5TiFB4atPqugZLw8qgeXlmPkXM52ODENX3YoHs4yz4MQQPQ9qY99NH53zRnAHeT51LlNRmrFWCqOG60v5Uycphzq9v1NWoPrSPKtsur0QV+Nb84xgbRdfE26f0QWBr9nINptMuVPzSX8ylGU9Q0BQ+VtL6xfsb9C73ZesYnCW3BtgItCPdHmPqVe3Yr3M+zMC3LPOruELNgMm6IeFJC8dAbulVodLf71ktMbOQzjotI4CN1KasYwDrhV2VSLJvbUDlyTtGlww6U9gHFq0tQsTnNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH7PR11MB7001.namprd11.prod.outlook.com (2603:10b6:510:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 01:59:30 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 01:59:30 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] powercap: intel_rapl: Fix off by one in get_rpi()
Thread-Topic: [PATCH] powercap: intel_rapl: Fix off by one in get_rpi()
Thread-Index: AQHa8tzLytC2noJKBkenambKuROQZbIw9cgA
Date: Wed, 21 Aug 2024 01:59:30 +0000
Message-ID: <20dde1046dee254091dddb1833b265603bc1bcc1.camel@intel.com>
References: <86e3a059-504d-4795-a5ea-4a653f3b41f8@stanley.mountain>
In-Reply-To: <86e3a059-504d-4795-a5ea-4a653f3b41f8@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH7PR11MB7001:EE_
x-ms-office365-filtering-correlation-id: b8a28d18-025b-4f0a-a928-08dcc184e56a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d0k2Z2JiTlFHM3Uyb3JOcXhuUEtaMlphazZOdnEyVmR1Vk4xcWlqa2x6ZGhM?=
 =?utf-8?B?ZmZMWWhTdkI1aUNMWjcyRlQ3Unhrb2xmMk1kekR3UXBuczhTNmZGYmxQL01L?=
 =?utf-8?B?TVEyS2tKUTQ0bGxUT2phZXdLK2Z1UmNYaW5Rb1A3TXRQQk00aEcrdWJqajd3?=
 =?utf-8?B?WTRwOURiZVF4dVdzekJ5ZW9yTUNMVjMrU1Z0OC90a25CRGs4Q0pUWWo2RmUy?=
 =?utf-8?B?NmVGRnFaL2VsY3ZpeXoyd1V2bElKczZleFBiRDduYnllNkF1MnNhMW5VdzQ0?=
 =?utf-8?B?N1ZVSll3a1NBanBnZzMrSE80bWdRUk9TZjBDN3Jlc0tZdHNRK1N2SkkreXdH?=
 =?utf-8?B?dGhFRWNjd0pkU2kzMU40UVBIbVhjYXdsMlBRUkRyZUJsQms2cytIUm9hNTZH?=
 =?utf-8?B?Wm52M0NSSnZUcHMxcHhwVTRydEpUbW5XSXdBUE5vVFo4MWQ4ZWljQzdBcE9G?=
 =?utf-8?B?aG5KNi9SdmMrUXg1NHpEOTNEdTJxQVNMUDdmRjZnU2ltQWl2bUVJSkJ6TU9B?=
 =?utf-8?B?Z09RcEdWM2NGNEY0djNraG15RFo4dW5rdHR2aXJOMDVlY0RieDVWT2hsNVp6?=
 =?utf-8?B?UmZiUlM4V0tuMlpURVd1aU1UbENjWm1tTmdRT3RQSmE1czliUGtqOEJZWExs?=
 =?utf-8?B?dlIxWGFodlc4YnRQbXZ2NCtEU040cm5wWDdYeU44UXUxaVEvTmRjNlNFcm1B?=
 =?utf-8?B?R3ZuWmowRDhKRkxwUTlSZ2psZUtCUHY0SHZNSnZjMjJVT25mcWlNNWM1YVUr?=
 =?utf-8?B?OW1QeStMdk56QnVkQXJ5QWhWRTUvMUd3Nm5HbXpLMFZNcDF5MkFHMXJ4ZEJB?=
 =?utf-8?B?b2IzRGcwWWNxNHVyZnlHRUc4WVF6VDIxSk9kYUxET1NHRVJSYWRSRk5JZUFD?=
 =?utf-8?B?VUU1UFQrazZOaWdKanBVNlRBM1FxYWNXdXVaT0tXelY0ZjVHdDloR3RqSmF6?=
 =?utf-8?B?aEp2dS9PYWpMd3V5UDVYSEhGZU1WZ2dsZzVad1BFbjJSVHlMK3pOK1JYU2xh?=
 =?utf-8?B?ZHlyWGsvdnkzR0JTeWxrWnBRQVJmd3F3eTMzSExRQjNHakpyTHRHZkt2U0Rx?=
 =?utf-8?B?dzJpaEMvT3phOWJvVnJCTVZKT3NDL2hyR0UyTGppOXRlU29NamtqNFRHV1c4?=
 =?utf-8?B?Ymd1UENNc3RES0htMkhJMFRuVngyUnZoRk5xUUtGVVFrcmhUMzNXUW9oUFdn?=
 =?utf-8?B?dXlQa3dySGpTVWJQVTR6LzFYUzlsNWpFSll3MnpLMXFXL0lpdXZkVmg1SHVG?=
 =?utf-8?B?eXFNeGdxc2hid0dpbTgzNEtSOWFDUEs3ZXdzQ3pPeC9yL1VEZkY4S09SV0pD?=
 =?utf-8?B?U1UrZmd0bEJWb1MyQmNGMHVaYU9YYWl6L0l4ck9Ob1U2VWVBaC9taldQcmdT?=
 =?utf-8?B?MkRmOUs5RTBNNlNuZkFnWHZkVVoxNFcyZFpGSzIrTStlMmlUd3dBRGRYbTBM?=
 =?utf-8?B?V05mOE1TRm5HeTBITVdlWkZHb3BSZTFGOVdhQjNGY1BhaS9lWGlTb2xOTnpW?=
 =?utf-8?B?cDBqUmgwd2VDQXZDNVZJcDRVcDhJSHF4U1QyaVNGREwyMERLeTN0VFVidHo3?=
 =?utf-8?B?MjZLQU16TzA3aEdiK3BJSVI5SERQZHN4VTVwYm03OFExS3JjS0FLMjJPbit3?=
 =?utf-8?B?YTNCYmVmd3RFc3RiVmlvbndpUTR1WCt3UGllajRSdVlYUmFVcU1FT3VUS1dC?=
 =?utf-8?B?M0dRaE4zT28vYWVxYjZ0aWdpS1ZwR3QzNjEyeDRQVEFIYVNzNGpZMzVDSzdN?=
 =?utf-8?B?WGR1ZlpFR3ZtWjNsL2VkdE9mVmtXb0d6VkFWdXBNdEZibno1MFAzVEI4RTcy?=
 =?utf-8?B?WnVMSzE3Q2dkRmlSNTZaYnNmOFBaQmVKSjNzcUtySThjWU1yNHJFYnhOd3h0?=
 =?utf-8?B?UXZDaEp5N1Zyd2hjVDNZYUt1TXQ1aCt4ekYwVk5MeDdYNXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHB3RW5BbTRPZDhiTTNZRVNmdnIwQ1phNlZqMXZrN2p6bUhyR2Z1bjFxaDRL?=
 =?utf-8?B?a0xic3I5NG5Wd0J1dTRCMVRIY3E3Q0VxcVRaQVo1a29NT2JQOUIzUG52dlZI?=
 =?utf-8?B?MVpZUmQxS2xMRGd1bkYvaTBLZ3pjbktFUmc5Z254QkcySU84WHVJTUJaWTZx?=
 =?utf-8?B?cEgrRW1PZlpNMk40TnB6bHYvV1piQmRnM2NVUm45RE5QZmtxUGt3a0JPejds?=
 =?utf-8?B?RUlsaWVtMlM1dWE3UnFXMGhqRzVrWkRJYktRWmRVTGV0Mk5jMDltTS8vWTY0?=
 =?utf-8?B?cU1GdTY2U1h6ZE9lSExNSW1vL3ZxTUdTbTUvVDkwN01LazVReGV2VHpkNnlL?=
 =?utf-8?B?empSVWpraHcvZEFMb0pIZDF3SHpvREtnUDlLZ0dQTHpoV2FPenR3VU1EMnFM?=
 =?utf-8?B?OGpUbHRiOCs5S1NFUXJEYWVHdVNUUEI1UHFQSW5STm1Uak9CMUdST1phWFNs?=
 =?utf-8?B?OXFyOU1zckZJdTJLaHhtVnByaithbDZDQmRGbUo4SVdrdGsrTjNrWG1sd2Jv?=
 =?utf-8?B?QW1TM1NXaVdOc21CMjgxRFljWW5LSmFmdDlXcFpKYmpZRDV2MzhmQmpaNlE5?=
 =?utf-8?B?bkVVUy8rWXB6bmNZS1kvZVI5VXRYZEtXdUZ5bjJiTWVSeVpsbXBrV1A1cWtn?=
 =?utf-8?B?VHhrcXN2OTVJN2Y1WmgvNXB0cjFnWkRpVVkrMitWSjVjMXE3NHZ5RVpBeG1a?=
 =?utf-8?B?aXRUME5NUGh2RXpvbVJpb0YyVlpoWFM0WDhNUGRqRlRkYU9ZcDRPdlVnRFJS?=
 =?utf-8?B?dmJPdEF2bkQzNWd3YXJyQS91UHRUWHNFQzcrVThta0R5NFJ2NmxmbE5zb3Jj?=
 =?utf-8?B?bVBKbGVPSDd0V2QrYUNEWUMxTC9iV3JLbXF3QXNwTDdiZUx6V2tXYWd1OHZ3?=
 =?utf-8?B?WktDYS9YOHJTSUtMMG1vN0lPTlp5UXZVSWdjOUFLRkN0WjVKOXpOZ2xwYVRz?=
 =?utf-8?B?UG5FeXZWUWRCcFN4Nm5jVjZ2UXgwNmk0Q1RybXAyTVhtNC9ZcWNieW1FNys3?=
 =?utf-8?B?RldJeGxNNXBRVExrajJ3TVluV0xTbUx2ZHk2S0s2L0VhNXY5MDZPYkJXOFdx?=
 =?utf-8?B?T2tocEN2bSs4b3dQQmxPRFhQbG9vTWxmV3RkajdtM0tQR2IySG1VWjE3cXlp?=
 =?utf-8?B?SExxQlEyMGpZUG80MSt6M1RPZis4NHVoQ3RnTSt6QTYwV3B3SU1oUENCam9h?=
 =?utf-8?B?U2NMK2pvUjdtUGU5ZWp3T1dveWk3WWxYVXZpT25mb2tCbEJmMjFvbEdvT3Rm?=
 =?utf-8?B?TFVyU1pmQkxKckE1a0NPZzdMblFJajVjUWtRdmI1TWVPNlg4bFhjai9CVzNW?=
 =?utf-8?B?Q0lPOHNQdnQwdHc4SUF6RWJDMHB1ckc0djFVRFFncldrNk1OelcrOUFiaFBh?=
 =?utf-8?B?aFZHNVRvZTBxUkdtS01DbHBhekF5VGNuZzc3OXRYWTVTMlZYZjNmYWx3STlh?=
 =?utf-8?B?eU9JcCtSZ0tEK01hSXJ6SjBVa2s1QW9lT3pyL242ckRtYVM3SUVpMGI5Mk1F?=
 =?utf-8?B?MlRKYU55KzJKdE9qSDFwRk9JTlYvQXBaeWxOa0VValJTR25PaFNkUU1sMllP?=
 =?utf-8?B?OTF0bmRiOEZUWlV6R3dBTjZSb3RyVG8zVFVFTTJlYW1mdTJrMGFveXorL1hG?=
 =?utf-8?B?S1VNZFE1UXN2cFpMZVNTb3lMTDFOcnpveTJQZXg5N096QVdsYm1IbFhEcmdQ?=
 =?utf-8?B?bTkwQ0Ewc3EyNEM0eEJiYzBCUU5COTV1T0EyMVdZOWx3d1h6UERiUGJPVnNm?=
 =?utf-8?B?SmswazFwdXBKOExMcXdwZzVEWk8rdEJiczFhajRKemN2aldIK2NrSWhMVFlF?=
 =?utf-8?B?cGhHY0w1cS9mc3Z5dXNPbUt3ZEprNE9vSW5laTRJS3FxRjFZUGdhN2RaM0Ez?=
 =?utf-8?B?ek1jNFNuRkVHR2xCS1lpUGQ4Uk9QZnU0ZmthcTFhTWVCempaVU80WWx6NHJJ?=
 =?utf-8?B?d1lLWTBWaHVOdDJ6MXhWTVVOcXJLV2hmYk5FamZWRTd2VXZibmZHSnFWbVJs?=
 =?utf-8?B?K1pkZVJ5eWVRTUlMeURELzFpUzNneXhLbzBpOFlleTVKdXlKdHhqUFNzN1RQ?=
 =?utf-8?B?cThqd1ZKZ09MWEVoYjBQclBGeFZqSjhJM1VOVlFQemlTV0xNRjh0L3hvR081?=
 =?utf-8?B?S3ArWXpNd3dpWFJTa3RqQ0p2THV1NHlVY0NhcG95Z3Q2NC92QS9yWmorOXB5?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A8D87C21627C144811A0072E7306FA3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a28d18-025b-4f0a-a928-08dcc184e56a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 01:59:30.8511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EF/OMe2MCOHjzn9AeWYhg8RhFs216gt5KCtiP/s8eZQQGUWZdwJMU9PNY/28SqHN7rbYkYmDpZulZxULFswz2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7001
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA4LTIwIGF0IDExOjQxICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBUaGUgcnAtPnByaXYtPnJwaSBhcnJheSBpcyBlaXRoZXIgcnBpX21zciBvciBycGlfdHBtaSB3
aGljaCBoYXZlDQo+IE5SX1JBUExfUFJJTUlUSVZFUyBudW1iZXIgb2YgZWxlbWVudHMuwqAgVGh1
cyB0aGUgPiBuZWVkcyB0byBiZSA+PQ0KPiB0byBwcmV2ZW50IGFuIG9mZiBieSBvbmUgYWNjZXNz
Lg0KPiANCj4gRml4ZXM6IDk4ZmY2MzlhNzI4OSAoInBvd2VyY2FwOiBpbnRlbF9yYXBsOiBTdXBw
b3J0IHBlciBJbnRlcmZhY2UNCj4gcHJpbWl0aXZlIGluZm9ybWF0aW9uIikNCj4gU2lnbmVkLW9m
Zi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KDQpBY2tlZC1i
eTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KDQp0aGFua3MsDQpydWkNCg0KPiAt
LS0NCj4gwqBkcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMgfCAyICstDQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+IGIvZHJpdmVy
cy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+IGluZGV4IDhiN2E1YTMxZThjMS4uNjdh
ZWM3MzUxMWE3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29t
bW9uLmMNCj4gKysrIGIvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+IEBA
IC03NDAsNyArNzQwLDcgQEAgc3RhdGljIHN0cnVjdCByYXBsX3ByaW1pdGl2ZV9pbmZvICpnZXRf
cnBpKHN0cnVjdA0KPiByYXBsX3BhY2thZ2UgKnJwLCBpbnQgcHJpbSkNCj4gwqB7DQo+IMKgwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgcmFwbF9wcmltaXRpdmVfaW5mbyAqcnBpID0gcnAtPnByaXYtPnJw
aTsNCj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgaWYgKHByaW0gPCAwIHx8IHByaW0gPiBOUl9SQVBM
X1BSSU1JVElWRVMgfHwgIXJwaSkNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHByaW0gPCAwIHx8IHBy
aW0gPj0gTlJfUkFQTF9QUklNSVRJVkVTIHx8ICFycGkpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIE5VTEw7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
JnJwaVtwcmltXTsNCg0K

