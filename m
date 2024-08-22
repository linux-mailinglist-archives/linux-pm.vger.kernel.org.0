Return-Path: <linux-pm+bounces-12717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 663AA95B4BE
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 14:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36BE1F23A12
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD941C9429;
	Thu, 22 Aug 2024 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXIBDyrt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7C1AAE36
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328695; cv=fail; b=InKOScSo1zhFoSlzuuEIzApaZtFZsroN0bM3kLC+JWId/zyuoxzn+juliHwl6Nyp2n5OCDCbQnT7mfj9g+FKubniJWjznmE5o85smebMOVC60sJIJNq4c94hjmDy+1wYVvYSszfLM01B4NtMlEjb7SKAUnX77rTbDZXMHqlR4h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328695; c=relaxed/simple;
	bh=7uGkUU9gbCXhKuBh7hgZJ55r/41Vu+4AFNvaROfE3qE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uqz0CKtsKFjQ7RRT0dkLNKtMW+CPvebCmqDs4vGDIPBIX82Kk8u9l7xpu8aB42MXEK+3uiLX2Vd3EXTSXhcwXFzsbmoW/sKTryry+RSFw85J+ATunT5oJe9oA/yiKcz/Ou/40CCyei/8g06HCCzv8KezkeKaX+PPjBwkJdvj58U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXIBDyrt; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724328694; x=1755864694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7uGkUU9gbCXhKuBh7hgZJ55r/41Vu+4AFNvaROfE3qE=;
  b=fXIBDyrtqzLIT0K7BH5aT0KRhAcN/sUm/dhCSITlTEA7qsrSKQiKFP8W
   NsIKBOGcMkUyB14NFWxX+cobv354x9E43uKn0GdEMJK3zlheH+/S+exS0
   4H1/585TKpHV2x8DAxT4UY4hyZ4kTvcTgJG0FJCGCOSSxz+R1lTCRPY1+
   w+7QZF1exj7SBuQQeEXUJDvhe+7/1Ad0srxSIgKlTyM8iovUmFMdjhPSL
   3Y5Xfx+hQ1QdGpocoz1Qs9eWYsG6Qg7P4gvXQANEUGSxmlhJ0szOHUccr
   io1Xid76WE9v7Lrks8EnDF3dB5qJoSYq7DdZUwNss6kEY4btFghnpVwyu
   w==;
X-CSE-ConnectionGUID: Zbxo1SeLShu6qL7CNgfnEg==
X-CSE-MsgGUID: 64QBZzFcQ52KPUXZP+wiSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22892031"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22892031"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:11:34 -0700
X-CSE-ConnectionGUID: TVz+b1uySeiRyCPJoDFy+Q==
X-CSE-MsgGUID: In4MSEp/S+Gc2/JfqQ9NtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61431940"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 05:11:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 05:11:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 05:11:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 05:11:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 05:11:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1FBCypEYVpWGG9OauX/WNh9XxStZBwHjdZBjWh0Q96LHshzwPfhM3OZfNUifcQ/ib5EwQQ04xWhTzZ8jy3sTVal4ZxX1tAECutSvwZWw0qknV2nCAx0ajd5gcDWJ6WicypyS3CsOW2sntGWYMQuhmanD84JBCOE87TyZ2B/CLZ/9Wj3++N/E6aCEz5FqpNZ4z5Cjtnr7HWoMmTPKtoFAygPwlp0vhKGyzXzxY//N9SaHx0nwxV1z3Xq4pdEb+i1QV6+P9z+VH+pHH9/vqtlAvvavdaNsBf1CTZ9g8Di9j/dMELpZaXSfToOSGKNZMgJ8BnPuCfubtaped8L0BQ13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uGkUU9gbCXhKuBh7hgZJ55r/41Vu+4AFNvaROfE3qE=;
 b=KIbuMUicNag640vbn3jzX8wMTd7oYR7VKlEgQ8gPm4FXQmwyeK18nxOw5Jm3Fb5EKSHkwcVnlygmG5vhb+YWkx5LkuV6e6PxeZ5V22lVhOCK8sLlalLJM2vBaN1qKWoygY3qQQH7hKCtv5acxTLMvqEwWTZC9/DxFV9tTiMemeRqWGg/SHQrQv11iUHoumv3XbDiI3UNvB5U1LrB2+GQZko7RGjUNh4e/QkhT+pbF77jtXJmgtpa79FiIrYT7RKZAB7H2eMA/VrloIuM56QAeRRBwoJGYHAASjORZqzHiVBEMr0JkQJpqNof1m+EB9/fNYo8VMVH3j77w9h0g9Wbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 IA1PR11MB7387.namprd11.prod.outlook.com (2603:10b6:208:421::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Thu, 22 Aug 2024 12:11:30 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 12:11:30 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "quic_manafm@quicinc.com"
	<quic_manafm@quicinc.com>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 0/7] Add thermal thresholds support
Thread-Topic: [PATCH v2 0/7] Add thermal thresholds support
Thread-Index: AQHa9AVXUG9+if23L0i94LJXXQBhg7IyJwIAgAAgegCAAL9gAIAAKe+A
Date: Thu, 22 Aug 2024 12:11:30 +0000
Message-ID: <dec10692d8bf72b425509d2ea002eebbd7238ccd.camel@intel.com>
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
	 <1942ed0b96419621583d4a0928883aafd8c2f7f2.camel@intel.com>
	 <CAJZ5v0gW-iaL34Mz2M0gzh-ooDbw=Rp=M_-dt1Ctqhxm3wUGQw@mail.gmail.com>
	 <0494c22b09f9143d2a22e1f0ae2ae79b7d61ab63.camel@intel.com>
	 <CAJZ5v0hbPRGyNYv0LjSjqFiH6uixDtsO-2Dbq8Qi_9fWhSwz4A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hbPRGyNYv0LjSjqFiH6uixDtsO-2Dbq8Qi_9fWhSwz4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|IA1PR11MB7387:EE_
x-ms-office365-filtering-correlation-id: fa5a8011-94b6-4843-6507-08dcc2a38e70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M1VUV0pYc0FDazloU1NIbXlOUzQ1VFJtTFBwQ05DakpQYTVYcjl3Z0phbXZu?=
 =?utf-8?B?d0d4ZGI0NUhZczE2dEt4cGszV3NiYnhRSE4xYjBHTUNabnF4RitGeWFZNnVp?=
 =?utf-8?B?dk5KQnhNY0dXQlV1eVZQVjFSNlQvZ3VkNVdZYncxeGdXY1ZmQnpKZTlGZVps?=
 =?utf-8?B?SDBMTnVYaVJ5VEtWNm9zblJPRFJkUjV2UTJLRmlMSGxMRDd6b0QzZXhlWUxR?=
 =?utf-8?B?OUxtN3drZEN3U0RLemJQM1JwemJkRGlKS2czK3h2eUpiMWRpS29OQ0htZyto?=
 =?utf-8?B?L09wOHBZOUhIekdkUnVQRW9BKzdiTmdYVFhxa3hhOWxiRU4yR1lRQ1JZZEI5?=
 =?utf-8?B?UDc2ZmQ2ZXd2ZC9IcTlMUmp3UHk2VlF2NjUxTWRSTDhsZlVYRUFYemM1aEN6?=
 =?utf-8?B?N0tWVHZsUjVZQ2ZuMWVpQlFPWituNjg0RnA2dVlMK2hoTXpOMDg0YkhQYmVY?=
 =?utf-8?B?ZWZGckRCUHA5QUpkS2VmWTJjNEVxeTNoZTZRSndIZ1EvQml2WFdhRzZvYnZW?=
 =?utf-8?B?RWZIZlE4WGhkREZPU29pOTFPSTR4Q2FkN01meWJUMnJobEFpMmFHNTZ5R04v?=
 =?utf-8?B?c2lTOXRmNWpydTVwSzZaZDY4cVdONG8vM0tMY0U0c2hoZ0NONFo3TmZQRWVS?=
 =?utf-8?B?NVgwbVl6djAveW5HK3lNbm9NNDR3TS9DT2xqRU5pNDRDbDZlUnRhZU1XQWg2?=
 =?utf-8?B?VU1XdHNQR3JFaUNkM0FXNDJVSFZZTWY0ZjRSdDRYOU16MnFQUWZpV1BIWTl0?=
 =?utf-8?B?V3lSV2doRlk5dlBzMXVCTmxuQWhYN0R4cENHcFR3MVU2d055L0xndCs3S3JW?=
 =?utf-8?B?bFQ0NTE2NmtGRFp0OXNzZWp6d3ZYQlRCN3RjRGN2WlpqRjV3RDZoQTJ5eElQ?=
 =?utf-8?B?emNJWk1kZ2s4cUxka29hd2VsRHc0eDdjYy9rUnJJeWQxMm8wYmVFWC9Ob2hY?=
 =?utf-8?B?OVkvZmd2cE9vaVlvUExTdGhFRGZxRXVTOVdvbmxlcVdBT2RzNlp5VlMrQTJs?=
 =?utf-8?B?aWNidGtPNmJJeHZnbDI4a2IwUG1oVzU5N0RaemgxRFFjUTRPVjBQdU9hWHI2?=
 =?utf-8?B?T1VDeGJjVnNhU0pVVTVSTnVKd05XbXNYellRakJYMzI3MWdqaUhCdGRzb2VC?=
 =?utf-8?B?MU4yWEhaemRLejk0emVwQjA5S0ZDeVpNOGZaVWNPUU9wR2NNWkZSZkViM2pU?=
 =?utf-8?B?VmExK2t3S2ZLa1JJYnU5VGdYZ3pDMmk4cnZlMmJvbnROZUV2N2VVYlI1ekdI?=
 =?utf-8?B?ckE3SDlXbEhNcDRNaHh3QjAwN0RFeVp6RG5ZM2Y2aE95NnhmZ0Z3cVRTRElY?=
 =?utf-8?B?UDhMZ3dvckpKT0JqcktFVjNjVGw4VGNLdFpUZXUzdis5TXpBM3J3YzVUK2pm?=
 =?utf-8?B?cnd0ZUtvRlRMNmwzN0Q3WGZWRllpWmJlTGlodlAvWjFoLzA5aVJ5SmtuMVVv?=
 =?utf-8?B?V3VVYkM4all3UFNJS1EwdWRMeHllZ0VHV0Y4N2JzOW9RYnkyYW9SUnJOSlZT?=
 =?utf-8?B?UU9INzJMMVFqc1ppMGFwRVRISXNxU29mdGNhQVJWV3JreXN5QUZ3NS9hUDc2?=
 =?utf-8?B?bjZxeWlITFZ2cW9pZDh3TTNyeDhTbmxqd2VQVmRRQlJuSTZ4cXJSd21JYVJI?=
 =?utf-8?B?ZzVZM2d5Y2hFT3VoeHoxczUrWElGb2laNEhsZUU4TU52MUxCVmI4QytsdUYy?=
 =?utf-8?B?bXVIeVlSbWVJOElyYXN5OS9qVW9ZY3N2c0l3bVgydGQ0cHplc1lTMFJXUlh3?=
 =?utf-8?B?UDZjZitLVVZwaDkyRjdCcjhmOVQrUHpWamdyeGlhYkljbjBWdzluYXpiNGI4?=
 =?utf-8?B?WTZZTHJtRGs3dlJHVThISUFLK2tZNFBIb2puVVhwOWhyYnM0Z0FKNml2TTE4?=
 =?utf-8?B?bFI4WEJPdFhoRHRqMkpHMzBPaVRPZ29LY3h1ZXZwSU12SHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TG96S29HVVBBV09sNllaUEJYaVFnZzR3VEkvQjRySjNkQWpKVDVpRFJ2emxQ?=
 =?utf-8?B?bGdrMmFYN3RxRENxcGlGNEdXQjNUaklqZlRtRmRWSGQyQWJ0amQ0SnM4OTFt?=
 =?utf-8?B?MzdvZGJYUXd0MXorRHVYMDNuekxndDVxK1B5MndkZzVieUdVTEhMUmRhU1I0?=
 =?utf-8?B?VTE1SzhpWkdZdWJDaUVreXNMTHd3RWtxcmF4YnlYdWh6UkdUUWI3YVBmWWpm?=
 =?utf-8?B?WnF2WG9FQzBzNkdSOFhaNUY4aEgxK1dqQ0Nib2lISkJhTDVFU0dIUzZDRXJH?=
 =?utf-8?B?VHJoblN1TTVIbDlsWXlvUG5hbEFNMlQrU1E2bTJ0Rk1mVkcyRy9hMStTQnBW?=
 =?utf-8?B?bzJwM2o1cGp5QUgreGtHV1JPcFYvK0c4c0tXc1B6L3drOEdvT1FXN0c1VlUw?=
 =?utf-8?B?Z0Rib2lEVFNxdlYvZEF5ZGlPNFRldzhWQWp5NlBTeEZEVnNlbURleHg3aGlN?=
 =?utf-8?B?aEVLRUdVV0VRK3B3Z0FmN1ZITzVqRWliS0QrOVZ5UU81WThFVzZwc3VWMVA5?=
 =?utf-8?B?cjhsR3Vqb0JJNERKTWV0eXEvN3lPWjkrU0N6bkdQZG5wMlE1UUlKemV2NmFo?=
 =?utf-8?B?M2pBVE1acTczclVtdXFmQkNrNVpmZzZOdDdJM2w3bThPS1QrQTBpUGZ0bG82?=
 =?utf-8?B?dC9RSUVIM1JVKzQ3dUdhZys0WUR0RkhlODFLcnJYc05UMHFmNWx0RWJiRHJ3?=
 =?utf-8?B?Qmd3djQwRXJlWEFMU3JGUVo5TmwzWFlsUjhxT3FkM1VzN2RRTTFWTXNyRnl6?=
 =?utf-8?B?M0Z4SE1GMWdUb216VjNINThkbFNyM2ZlYmZSc2xLdUFmbWVZWGhJTzR1RXh2?=
 =?utf-8?B?aW5IK1dBQWN1S20zVHFPanNVTXRFQkVSNFdXbEFIenI3OCt5VThVeG1malZ3?=
 =?utf-8?B?amh2enA4RUc5M05FemRGSk96MzFSWHdSN2M1LzExNzZXMVF1cllOZnNTTm5E?=
 =?utf-8?B?aS9QMDBSTjd4SG9zd0ZlQkJuSjZkWTdRSlMzV0E4V29pMWJzTTl6eTNGTFBZ?=
 =?utf-8?B?MW01SWU0T2s1Slhxdyt0ckxJOC81L0NSOHA2MVVhbWtiRkVaNngrdU13Q0Zp?=
 =?utf-8?B?bDd2SmxlTytkRDFhdm9RQ3hITFR2U3RwTFp4b2hBSHZVSUxxaThzNnR1WmN4?=
 =?utf-8?B?YWNzMlR1dGFraUlPaGZOOGE5STlMbnF3bUt6Qm1iSWk0RklER29KeXpLYmFX?=
 =?utf-8?B?aDVkOVUyQUVqNVBiam5mUEoyRjE4aC90T3FPekVZdDhCVi9BTUlZdStyU1hS?=
 =?utf-8?B?RFlpTGtzWk42M05vUHdjZXRpRDNMdW9QQ0xpcTg2SHZGWHVzWFpENXRGdWR1?=
 =?utf-8?B?TnZOK3FFMzFKWEFhVkptN0hoYmFONXg5K2ozQnZMT3lRRWxTZTByK1ovZCtE?=
 =?utf-8?B?cnY4TWFESm1IWk9IQzJ2bXVmM0pQWHU4VkVEc2xWSjQxbmVubGxRa0F3WmdE?=
 =?utf-8?B?WG8yMTZFeXk0ZlFOOXVyR2Y5dFRBckU3VkNIakxKZURWUms4WXRnRXBKTXhO?=
 =?utf-8?B?UWpZU1Q2ZnFSRTZvS1NXenhMUndEWlVjS3JRdkxGdnQrM3NQK0FEQ2lFVzAy?=
 =?utf-8?B?TTFqdjZsT3ZoTnNjbStRaG0zZXRHY282UGxURzZUTDgwa1IxOStYMUZESzFB?=
 =?utf-8?B?c3JCcFZhWjdKZFlmb2RjVHc1NG1YVHJJUlMyUURxZnhVZFM5UjVROGhOTXQ5?=
 =?utf-8?B?SnIyTldHL0NLcjlwbWkrNHRSKzF3R1VBbmZCMlJZWGY5Z1N1Sk8zVFJkdTFV?=
 =?utf-8?B?b0hlc2pXWFFySENXL1hMVnJhUWEzSk1aYmVRd2FQNXQ2aTc0S1RRTGR3dVMy?=
 =?utf-8?B?ZUR5aUJBbUJpRU81MTgyN0J0RFdCbHMzTjFRbWpmME5ISVFVVlFUNGpZc1hD?=
 =?utf-8?B?bDRtbFVmWHNyTEZZUVRUQ3FyalBLSlZML0xwQzR4UHV0Mk9HajRVQ09IczZF?=
 =?utf-8?B?M2o0d29HeERwRDdaTVVzVEZST0tTMUhJdFJoZ0hzWnkwbm5pd0dCZ3VoNUhD?=
 =?utf-8?B?ZmF5dmdObUxxTHkzdVBrTzlUeUV6NkRRVTNEbldaWVk4VEo1eEpDNlphdWM5?=
 =?utf-8?B?bVlTR3FqM0cxWm9jS2R2djRvUXYydnltelluV21ZMVA5RGtSeldCWnJBNkdN?=
 =?utf-8?B?Qm0wYTMzUlFVdElKcGJBWEpQM1JYN2NMZzFpeWc4RUk4UlF3Unhrd3hNaFVE?=
 =?utf-8?Q?6j4KkzPwlUnUST+RBVNdqsg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57CFB028B683184DAA0F1D11072A841E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5a8011-94b6-4843-6507-08dcc2a38e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 12:11:30.4587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFKGxROWWOGDFvByl15LIZoMQprmRUdXoa+ZbRjKKm6RaiJkSISxPM3zVTDgPCNnjNZHKbmKuuBS5tnFH2dmomvTWrd/62lcAS5lNdoZR7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7387
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA4LTIyIGF0IDExOjQxICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1LCBBdWcgMjIsIDIwMjQgYXQgMTI6MTbigK9BTSBQYW5kcnV2YWRhLCBTcmlu
aXZhcw0KPiA8c3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+
IE9uIFdlZCwgMjAyNC0wOC0yMSBhdCAyMjoyMCArMDIwMCwgUmFmYWVsIEouIFd5c29ja2kgd3Jv
dGU6DQo+ID4gPiBIaSBTcmluaXZhcywNCj4gPiA+IA0KPiA+ID4gT24gV2VkLCBBdWcgMjEsIDIw
MjQgYXQgMTA6MDTigK9QTSBQYW5kcnV2YWRhLCBTcmluaXZhcw0KPiA+ID4gPHNyaW5pdmFzLnBh
bmRydXZhZGFAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IEhpIERhbmllbCwN
Cj4gPiA+ID4gDQo+ID4gPiA+IE9uIEZyaSwgMjAyNC0wOC0xNiBhdCAxMDoxMiArMDIwMCwgRGFu
aWVsIExlemNhbm8gd3JvdGU6DQo+ID4gPiA+ID4gVGhlIHRyaXAgcG9pbnRzIGFyZSBhIGZpcm13
YXJlIGRlc2NyaXB0aW9uIG9mIHRoZSB0ZW1wZXJhdHVyZQ0KPiA+ID4gPiA+IGxpbWl0cw0KPiA+
ID4gPiA+IG9mIGEgc3BlY2lmaWMgdGhlcm1hbCB6b25lIHdoZXJlIHdlIGFzc29jaWF0ZSBhbiBh
Y3Rpb24gd2hpY2gNCj4gPiA+ID4gPiBpcw0KPiA+ID4gPiA+IGRvbmUNCj4gPiA+ID4gPiBieSB0
aGUga2VybmVsLiBUaGUgdGltZSByZXNvbHV0aW9uIGlzIGxvdy4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBUaGUgdXNlcnNwYWNlIGhhcyB0byBkZWFsIHdpdGggYSBtb3JlIGNvbXBsZXggdGhlcm1h
bA0KPiA+ID4gPiA+IG1hbmFnZW1lbnQNCj4gPiA+ID4gPiBiYXNlZA0KPiA+ID4gPiA+IG9uIGhl
dXJpc3RpY3MgZnJvbSBkaWZmZXJlbnQgaW5mb3JtYXRpb24gY29taW5nIGZyb20NCj4gPiA+ID4g
PiBkaWZmZXJlbnQNCj4gPiA+ID4gPiBwbGFjZXMuIFRoZSBsb2dpYyBpcyBtdWNoIG1vcmUgY29t
cGxleCBidXQgYmFzZWQgb24gYSBiaWdnZXINCj4gPiA+ID4gPiB0aW1lDQo+ID4gPiA+ID4gcmVz
b2x1dGlvbiwgdXN1YWxseSBvbmUgc2Vjb25kIGJhc2VkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IFRoZSBwdXJwb3NlIG9mIHRoZSB1c2Vyc3BhY2UgaXMgdG8gbW9uaXRvciB0aGUgdGVtcGVyYXR1
cmVzDQo+ID4gPiA+ID4gZnJvbQ0KPiA+ID4gPiA+IGRpZmZlcmVudCBwbGFjZXMgYW5kIHRha2Ug
YWN0aW9ucy4gSG93ZXZlciwgaXQgY2FuIG5vdCBiZQ0KPiA+ID4gPiA+IGNvbnN0YW50bHkNCj4g
PiA+ID4gPiByZWFkaW5nIHRoZSB0ZW1wZXJhdHVyZSB0byBkZXRlY3Qgd2hlbiBhIHRlbXBlcmF0
dXJlDQo+ID4gPiA+ID4gdGhyZXNob2xkDQo+ID4gPiA+ID4gaGFzDQo+ID4gPiA+ID4gYmVlbiBy
ZWFjaGVkLiBUaGlzIGlzIGVzcGVjaWFsbHkgYmFkIGZvciBtb2JpbGUgb3IgZW1iZWRkZWQNCj4g
PiA+ID4gPiBzeXN0ZW0gYXMNCj4gPiA+ID4gPiB0aGF0IHdpbGwgbGVhZCB0byBhbiB1bmFjY2Vw
dGFibGUgbnVtYmVyIG9mIHdha2V1cCB0byBjaGVjaw0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+
IHRlbXBlcmF0dXJlIHdpdGggbm90aGluZyB0byBkby4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBP
biB0aGUgb3RoZXIgc2lkZSwgdGhlIHNlbnNvcnMgYXJlIG5vdyBtb3N0IG9mIHRoZSB0aW1lDQo+
ID4gPiA+ID4gaW50ZXJydXB0DQo+ID4gPiA+ID4gZHJpdmVuLiBUaGF0IG1lYW5zIHRoZSB0aGVy
bWFsIGZyYW1ld29yayB3aWxsIHVzZSB0aGUNCj4gPiA+ID4gPiB0ZW1wZXJhdHVyZQ0KPiA+ID4g
PiA+IHRyaXANCj4gPiA+ID4gPiBwb2ludHMgdG8gcHJvZ3JhbSB0aGUgc2Vuc29yIHRvIHRyaWdn
ZXIgYW4gaW50ZXJydXB0IHdoZW4gYQ0KPiA+ID4gPiA+IHRlbXBlcmF0dXJlIGxpbWl0IGlzIGNy
b3NzZWQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVW5mb3J0dW5hdGVseSwgdGhlIHVzZXJzcGFj
ZSBjYW4gbm90IGJlbmVmaXQgdGhpcyBmZWF0dXJlIGFuZA0KPiA+ID4gPiA+IGN1cnJlbnQNCj4g
PiA+ID4gPiBzb2x1dGlvbnMgZm91bmQgaGVyZSBhbmQgdGhlcmUsIGlvdyBvdXQtb2YtdHJlZSwg
YXJlIHRvIGFkZA0KPiA+ID4gPiA+IGZha2UNCj4gPiA+ID4gPiB0cmlwDQo+ID4gPiA+ID4gcG9p
bnRzIGluIHRoZSBmaXJtd2FyZSBhbmQgZW5hYmxlIHRoZSB3cml0YWJsZSB0cmlwIHBvaW50cy4N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGlzIGlzIGJhZCBmb3IgZGlmZmVyZW50IHJlYXNvbnMs
IHRoZSB0cmlwIHBvaW50cyBhcmUgZm9yDQo+ID4gPiA+ID4gaW4tDQo+ID4gPiA+ID4ga2VybmVs
DQo+ID4gPiA+ID4gYWN0aW9ucywgdGhlIHNlbWFudGljIG9mIHRoZWlyIHR5cGVzIGlzIHVzZWQg
YnkgdGhlIHRoZXJtYWwNCj4gPiA+ID4gPiBmcmFtZXdvcmsNCj4gPiA+ID4gPiBhbmQgYnkgYWRk
aW5nIHRyaXAgcG9pbnRzIGluIHRoZSBkZXZpY2UgdHJlZSBpcyBhIHdheSB0bw0KPiA+ID4gPiA+
IG92ZXJjb21lDQo+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gY3VycmVudCBsaW1pdGF0aW9uIGJ1
dCB0YW1wZXJpbmcgd2l0aCBob3cgdGhlIHRoZXJtYWwNCj4gPiA+ID4gPiBmcmFtZXdvcmsNCj4g
PiA+ID4gPiBpcw0KPiA+ID4gPiA+IHN1cHBvc2VkIHRvIHdvcmsuIFRoZSB3cml0YWJsZSB0cmlw
IHBvaW50cyBpcyBhIHdheSB0byBhZGp1c3QNCj4gPiA+ID4gPiBhDQo+ID4gPiA+ID4gdGVtcGVy
YXR1cmUgbGltaXQgZ2l2ZW4gYSBzcGVjaWZpYyBwbGF0Zm9ybSBpZiB0aGUgZmlybXdhcmUNCj4g
PiA+ID4gPiBpcw0KPiA+ID4gPiA+IG5vdA0KPiA+ID4gPiA+IGFjY3VyYXRlIGVub3VnaCBhbmQg
VEJIIGl0IGlzIG1vcmUgYSBkZWJ1ZyBmZWF0dXJlIGZyb20gbXkNCj4gPiA+ID4gPiBQT1YuDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhlIHRocmVzaG9sZHMgbWVjaGFuaXNtIGlzIGEgd2F5IHRv
IGhhdmUgdGhlIHVzZXJzcGFjZSB0bw0KPiA+ID4gPiA+IHRlbGwNCj4gPiA+ID4gPiB0aGVybWFs
IGZyYW1ld29yayB0byBzZW5kIGEgbm90aWZpY2F0aW9uIHdoZW4gYSB0ZW1wZXJhdHVyZQ0KPiA+
ID4gPiA+IGxpbWl0DQo+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiBjcm9zc2VkLiBUaGVyZSBpcyBu
byBpZCwgbm8gaHlzdGVyZXNpcywganVzdCB0aGUgdGVtcGVyYXR1cmUNCj4gPiA+ID4gPiBhbmQN
Cj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBkaXJlY3Rpb24gb2YgdGhlIGxpbWl0IGNyb3NzaW5n
LiBUaGF0IG1lYW5zIHdlIGNhbiBiZQ0KPiA+ID4gPiA+IG5vdGlmaWVkDQo+ID4gPiA+ID4gd2hl
biBhDQo+ID4gPiA+ID4gdGhyZXNob2xkIGlzIGNyb3NzZWQgdGhlIHdheSB1cCBvbmx5LCBvciB0
aGUgd2F5IGRvd24gb25seSBvcg0KPiA+ID4gPiA+IGJvdGgNCj4gPiA+ID4gPiB3YXlzLiBUaGF0
IGFsbG93cyB0byBjcmVhdGUgaHlzdGVyZXNpcyB2YWx1ZXMgaWYgaXQgaXMNCj4gPiA+ID4gPiBu
ZWVkZWQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQSB0aHJlc2hvbGQgY2FuIGJlIGFkZGVkLCBk
ZWxldGVkIG9yIGZsdXNoZWQuIFRoZSBsYXR0ZXINCj4gPiA+ID4gPiBtZWFucw0KPiA+ID4gPiA+
IGFsbA0KPiA+ID4gPiA+IHRocmVzaG9sZHMgYmVsb25naW5nIHRvIGEgdGhlcm1hbCB6b25lIHdp
bGwgYmUgZGVsZXRlZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFNvIHlvdSBhcmUg
cHJvcG9zaW5nIHRvIGFkZCB0aHJlc2hvbGQgdmlhIG5ldGxpbmssIG5vdCBhZGRpbmcNCj4gPiA+
ID4gYW55DQo+ID4gPiA+IG5ldw0KPiA+ID4gPiBzeXNmcyBhdHRyaWJ1dGU/IFRoYXQgaXMgbm90
IGNsZWFyIGhlcmUuDQo+ID4gPiA+IA0KPiA+ID4gPiBJIHRoaW5rIHlvdSBhcmUgYWRkaW5nIg0K
PiA+ID4gPiBUSEVSTUFMX0dFTkxfQ01EX1RIUkVTSE9MRF9HRVQNCj4gPiA+ID4gVEhFUk1BTF9H
RU5MX0NNRF9USFJFU0hPTERfQUREDQo+ID4gPiA+IFRIRVJNQUxfR0VOTF9DTURfVEhSRVNIT0xE
X0RFTEVURQ0KPiA+ID4gPiBUSEVSTUFMX0dFTkxfQ01EX1RIUkVTSE9MRF9GTFVTSA0KPiA+ID4g
PiANCj4gPiA+ID4gV2UgbmVlZCB0byBkb2N1bWVudCBvdXIgbmV0bGluayBtZXNzYWdlcyBpbmNs
dWRpbmcgb2xkIG9uZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBBbHNvIHdlIHNob3VsZCBhZGQgIk1P
RElGWSIgYXMgd2UgdGVuZCB0byBjaGFuZ2UgdGhlbSBxdWl0ZQ0KPiA+ID4gPiBvZnRlbi4NCj4g
PiA+ID4gDQo+ID4gPiA+IEFsc28gbm8gaHlzdGVyZXNpcywgdGhhdCBpcyBwcmFjdGljYWxseSB3
ZSBjYW4ndCB1c2UuDQo+ID4gPiANCj4gPiA+IFRoZSBkaXJlY3Rpb24gdGhpbmcgaXMgZXF1aXZh
bGVudCB0byBoeXN0ZXJlc2lzIHRob3VnaC4NCj4gPiA+IA0KPiA+ID4gSW5zdGVhZCBvZiB1c2lu
ZyBvbmUgdGhyZXNob2xkIHdpdGggYSBnaXZlbiBoeXN0ZXJlc2lzIHZhbHVlLCB1c2UNCj4gPiA+
IHR3bw0KPiA+ID4gb2YgdGhlbSB3aXRoIGRpZmZlcmVudCB0ZW1wZXJhdHVyZSB2YWx1ZXMgYW5k
IGRpZmZlcmVudA0KPiA+ID4gZGlyZWN0aW9ucy4NCj4gPiA+IA0KPiA+ID4gPiBUZW1wZXJhdHVy
ZSBjaGFuZ2VzIHNvIG11Y2ggdGhhdCB0aGF0IHdpbGwgZmxvb2QgdXNlciBzcGFjZS4NCj4gPiA+
ID4gWW91DQo+ID4gPiA+IHdpbGwgZ2V0IDEwMHMgb2YNCj4gPiA+ID4gZXZlbnRzIG9uIENQVSB0
ZW1wZXJhdHVyZSBpZiB5b3Ugc2V0IHRlbXBlcmF0dXJlIHRocmVzaG9sZCBpbg0KPiA+ID4gPiBD
UFUuDQo+ID4gPiANCj4gPiA+IEV2ZW50cyBvbmx5IHRyaWdnZXIgd2hlbiB0aHJlc2hvbGRzIGFy
ZSBjcm9zc2VkIGluIGEgc3BlY2lmaWMNCj4gPiA+IGRpcmVjdGlvbiwgYnV0IG92ZXJhbGwgeW91
IGhhdmUgYSBwb2ludC4NCj4gPiANCj4gPiBUaGlzIGlzIGdvb2QgZW5vdWdoIGZvciBzb21lIHNl
bnNvciB3aGljaCBjaGFuZ2VzIHNsb3dseSBsaWtlIHNraW4uDQo+IA0KPiBSaWdodCwgYW5kIEkg
dGhpbmsgdGhhdCB0aGlzIGlzIHRoZSBkcml2aW5nIHVzZSBjYXNlLg0KPiANCj4gPiBCdXQgc29t
ZSBzZW5zb3JzIGxpa2UgQ1BVIGFuZCBib2FyZCBhcmUgbm90IGxpa2UgdGhhdC4NCj4gDQo+IFN1
cmUsIHNvIHRoaXMgaW50ZXJmYWNlIHdpbGwgbm90IGJlIGZvciB0aGVtLg0KQnV0IHdoZW4gd2Ug
ZGVzaWduIGFuIGludGVyZmFjZSwgSSB0aGluayB0aGlzIHNob3VsZG4ndCBiZSBzZW5zb3INCmRl
cGVuZGVudC4NCg0KPiANCj4gPiBXZSBwdWJsaXNoIGJvdGggcmF3IGFuZCBmaWx0ZXJlZCBldmVu
dCBjb3VudCBpbiBkZWJ1Z2ZzIGZvciB4ODYNCj4gPiBwYWNrYWdlIHRlbXAuDQo+ID4gRm9yIGV4
YW1wbGUsIEkganVzdCByYW4gYSBzYW1wbGUgb24gYSBjbGllbnQgZm9yIG9uZSB0aHJlc2hvbGQu
DQo+ID4gDQo+ID4gVG90YWwgbm90aWZpY2F0aW9uIGZyb20gaGFyZHdhcmU6IDIyNA0KPiA+IE5v
dGlmaWVkIHRvIHVzZXIgc3BhY2U6IDE2DQo+IA0KPiBTbyBkaWQgeW91IGFwcGx5IHRoZSBEYW5p
ZWwncyBwYXRjaGVzIGFuZCBydW4gdGhlIHRlc3Qgb3IgZGlkIHlvdSBkbw0KPiBzb21ldGhpbmcg
ZWxzZT8NCldlIGFscmVhZHkgdXNlIG5ldGxpbmsgdG8gc2VuZCBub3RpZmljYXRpb24gdG8gdXNl
ciBzcGFjZSB2aWEgd3JpdGFibGUNCnRyaXAuIFNvIGRpZG4ndCBhcHBseSBhbnkgcGF0Y2hlcy4g
SSBkb24ndCBzZWUgdGhlc2UgcGF0Y2hlcyB3aWxsIGRvDQphbnkgZGlmZmVyZW50Lg0KDQoNCj4g
DQo+ID4gPiANCj4gPiA+ID4gV2UgaGF2ZSBhIHdob2xlIGZpbHRlcmluZyBpbiBkcml2ZXIgdG8g
YXZvaWQgdGhpcy4NCj4gPiA+ID4gWW91IG5lZWQgYSByYXRlIGxpbWl0IGhlcmUuDQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGVyZSBhcmUgbXVsdGlwbGUgdXNlciBwcm9jZXNzZXMgY2FuIGFkZCB0aHJl
c2hvbGQgYW5kIHRoZXJlDQo+ID4gPiA+IGlzIG5vDQo+ID4gPiA+IG93bmVyc2hpcC4gU28gb25l
IHByb2Nlc3MgY2FuIGNhdXNlIHRvbyBtdWNoIG5vaXNlIHRvIG90aGVycyBhcw0KPiA+ID4gPiBp
dA0KPiA+ID4gPiBpcw0KPiA+ID4gPiBtdWx0aWNhc3QuDQo+ID4gPiA+IA0KPiA+ID4gPiBXZSB3
b3JrZWQgb24gYSBjaGFuZ2UgdG8gZmlsZXIgdGhlc2UgYXMgZGlzY3Vzc2VkIGR1cmluZyBsYXN0
DQo+ID4gPiA+IExQQywNCj4gPiA+ID4gYnV0DQo+ID4gPiA+IG5vdCBwb3N0ZWQgeWV0LiBUaGlz
IHdpbGwgcmVhbGx5IG5lZWQgdGhpcyBhcyB0aGlzIHdpbGwgYmUgdG9vDQo+ID4gPiA+IG1hbnkN
Cj4gPiA+ID4gbWVzc2FnZXMuDQo+ID4gPiANCj4gPiA+IFVubGVzcyB0aGVyZSBpcyBhIHdheSB0
byBsaW1pdCB5b3VyIHN1YnNjcmlwdGlvbiB0byBldmVudHMNCj4gPiA+IHJlZ2FyZGluZw0KPiA+
ID4gYQ0KPiA+ID4gc3BlY2lmaWMgdGhlcm1hbCB6b25lLCBmb3IgaW5zdGFuY2UuDQo+ID4gVGhh
dCdzIHdoYXQgdGhpcyBjaGFuZ2UgZG9lcy4NCj4gPiANCj4gPiA+IA0KPiA+ID4gQW55d2F5LCBJ
IGhhdmUgdG8gYWRtaXQgaWdub3JhbmNlIHJlZ2FyZGluZyB0aGUgdXNlciBzcGFjZSB1c2FnZQ0K
PiA+ID4gbW9kZWwNCj4gPiA+IHJlbGF0ZWQgdG8gdGhpcy7CoCBGb3IgZXhhbXBsZSwgaXMgaXQg
ZXhwZWN0ZWQgdGhhdCB0aGVyZSB3aWxsIGJlDQo+ID4gPiBvbmUNCj4gPiA+IHVzZXIgc3BhY2Ug
ZW50aXR5IG1hbmFnaW5nIHRoZSB0aHJlc2hvbGRzIG9yIHRoZXJlIGNhbiBiZSBtYW55Lg0KPiA+
IA0KPiA+IEdvb2QgcXVlc3Rpb24uIFRoYXQncyB3aHkgd2UgZGlkbid0IHNlbmQgdGhpcyBjaGFu
Z2UuIElmIHRoZXJlIGlzDQo+ID4gb25lDQo+ID4gYWdlbnQgdGhpcyBpcyBmaW5lLg0KPiANCj4g
SSB0aGluayB0aGF0IHRoZSBhZGRpdGlvbiBhbmQgZGVsZXRpb24gb2YgYSB1c2VyIHRocmVzaG9s
ZCBzaG91bGQgYmUNCj4gcHJpdmlsZWdlZCBvcGVyYXRpb25zLg0KPiANCj4gSWYgdGhhdCBpcyB0
aGUgY2FzZSwgaXQgYWxsIGJvaWxzIGRvd24gdG8gcHJvcGVyIGNvb3JkaW5hdGlvbiBpbiB1c2Vy
DQo+IHNwYWNlLg0KPiANClNvbWUga2VybmVsIEFQSSB1c2Ugc29tZSBjb29raWUgYXMgcGFyYW1l
dGVyLiBIZXJlIGFsc28gc29tZXRoaW5nIGxpa2UNCnRoYXQgY2FuIGJlIHVzZWQgdG8gbWF0Y2gu
DQoNCj4gPiBCdXQgaW4gZW1iZWRkZWQgc3BhY2UsIHRoZXJlIG1heSBiZSBtb3JlIHRoYW4gb25l
LiBIZW5jZSB0aGV5DQo+ID4gbmVlZGVkDQo+ID4gbmV0bGluayBtdWx0aWNhc3QgaW5zdGVhZCBv
ZiBqdXN0IG9uZSBjaGFyIGRldmljZS4NCj4gDQo+IEkgc2VlLg0KDQpUaGFua3MsDQpTcmluaXZh
cw0KDQo=

