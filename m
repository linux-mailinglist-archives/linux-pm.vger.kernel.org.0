Return-Path: <linux-pm+bounces-28767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87661ADA553
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 03:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946933A8963
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 01:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5232F852;
	Mon, 16 Jun 2025 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/qAYDBK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423714F98;
	Mon, 16 Jun 2025 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750035845; cv=fail; b=HBvLkC8WxfJOyuCd3J/3AX11juo/23CZ0TLUT16iI1jOjUSAfRJrkJeTjGJjiUZyobLW62JBFFxTJLHAoVeoxs0E5eLlrgTMOvEIbY4gEXdIhMsdQQP6M4ap+MB4SIF1iLsU3MLOyVlbbDiuCcI/LzwEdNEvk9L/DEQ+yL6/6tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750035845; c=relaxed/simple;
	bh=HxITkF1xEjHw5oF4CJCtou2cU+by2y/zb/bFiczmaoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BTb9X/0/U7AwQxCR9fHDdjDwY9zmmskGWm4HnQarek/mi6rR9a3TI63jzknrGhEYsKuTIJZ5OJwxwAp1C4czZtyChwVSLjcr1kfqQxRsxwBC1+A2aHiLcn1qApmCwZOyYejxvBmM8zMmrru14fLzSDE85v2Wp+z5YacyuQu8sTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/qAYDBK; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750035844; x=1781571844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HxITkF1xEjHw5oF4CJCtou2cU+by2y/zb/bFiczmaoA=;
  b=W/qAYDBKdfBEtq9B82jTFgKf23JJA7yHNbXwBJIqqD5wSH/rMUZUZCpK
   V/DC/3NmneAaLZ1Q1cbFR82oqrJ3Fwt9nO/5lw/5YkpO5wmM8lX8ltrc7
   bNU0a+oQC2pNtGLztNW1fZdtys2wON9WGslSklBmjTlUCdHUjFIVqIXwK
   BKycsC/EJyvXpi7eDwJ815xoCwSg9feCKFf+c0fcuekD9F4DDccBaNgdv
   vLGgAcf8foPa+ZfXUGsCl7pYSxtAUbwc2hOlRwpOjam+fQdgJY8J560xG
   Y6tNzSJ9Ml0H5N6g8dklOIINfrMOzU0qTtN8JGw+zX0iVftABf2OwgP0y
   g==;
X-CSE-ConnectionGUID: SuWBj4u4QWCMFzmziyd3kg==
X-CSE-MsgGUID: igCXoAfMQyyt047TnDC8/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62779485"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="62779485"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 18:04:03 -0700
X-CSE-ConnectionGUID: /lWg7vXETwyCXMXwY7X5Dw==
X-CSE-MsgGUID: lWyqIBU4Q/S2VnJG/OK7Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148701157"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 18:04:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 18:04:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 15 Jun 2025 18:04:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.54)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 18:03:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgI4Aa8RCMoHFwuNGXWyl5UeaJRW6RRCz+lsHIPfz2eMURihkGOWGuVxMmwozNwzcj6WfDBzMwDJclMciXsKkqGiK4EeUA7fqu4hSwIfd6k2OLypRB/Z5fKYJkx1OxrZelsjAy0dADdwgywRvSQER5tG1II/dkI1JUoAa6rchxOW3oDhzIjrg4Al1VXPdyhlqdGqR0UM6LYlugVmc91On/O8lze20nFeM9l9E7xk2D6vvoeaWGMKmy4m3t2BaV5qPsBESm1sHrKaLLBwrihmU5NGVMB8O5l/rj4SsyiUeThiy4YjTJX7ZIsAKXuWma91MWBQSY8kPen0KgIbAUGJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxITkF1xEjHw5oF4CJCtou2cU+by2y/zb/bFiczmaoA=;
 b=on14PcsTRgDckTsIP2ceKwer5RA3fkcs2buZ19FSdaLJhCylDSnuYKE3t0UMsLwEc+F+ZBpcNfiM+XGtW7IDWyEGbldpsxUTjdEYMVUcu/GZ7bVsiwViiQp6oRcdhWpx+aXD6oTbiK7nZhMhBHqDOaapnRsOOnwcZnRpEm3l0wXqYehN3MvRoo7mthTrjoU2eZI/1O4hD2V3tE4XHqYlC6Bburd/lVNn2bhBn1lLnbfGUEJJJwztb9dXwnjS2AcuiLXxDEWHABzk6LL9qpng7I0mA3KYnVK1J/WM//GV3KREIsRLR7LePTVjB+A/qEIW5zI01Ch6vNlXhZqSSIWPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by DM4PR11MB6551.namprd11.prod.outlook.com (2603:10b6:8:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 16 Jun
 2025 01:03:56 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8813.024; Mon, 16 Jun 2025
 01:03:56 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] thermal: intel: int340x: Allow temperature
 override
Thread-Topic: [PATCH v2 2/2] thermal: intel: int340x: Allow temperature
 override
Thread-Index: AQHb3K0NjbLwByBqUUKU0eT+QXVE6rQE+7aA
Date: Mon, 16 Jun 2025 01:03:56 +0000
Message-ID: <0c415d9c5331c505d81072359a8421a84fc5fa4d.camel@intel.com>
References: <20250613214923.2910397-1-srinivas.pandruvada@linux.intel.com>
	 <20250613214923.2910397-2-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250613214923.2910397-2-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|DM4PR11MB6551:EE_
x-ms-office365-filtering-correlation-id: 3b303f98-c687-46ff-dc64-08ddac71ab85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SkxYTDlvVmljQU52SXJrSVNBeEREdysxRC94Z0hxYnZiT1ZQNWRrVmtFaS8v?=
 =?utf-8?B?K3VONDRIK0c1WVNPbVQxVFlxeVRwZkY3OWc4b3ZFMjN4TThVV09YRDkrcWpy?=
 =?utf-8?B?b3pEYXR3NWJNMFY0Umd1eW1abHRYck9hVWNwZUs0YWNpMWxuQ3NLLzMyVXBt?=
 =?utf-8?B?MVcwNUtlTnN0QzE2WC9pSTloMkN5aCsvanJ1WTB2bnhiMDR4WWhqNjRwaEFD?=
 =?utf-8?B?SjN6TUV4SUFYNFVNMjJBS2o2OTJsNGFjbUVvdHFGMjY5bmdGek5NTTdtdFhw?=
 =?utf-8?B?NmNicXJNcTNUVXlTNlFGTW5kL05JTWkxcitMSzhRYzJ2OUJuTjFlbGJaa05H?=
 =?utf-8?B?NlVQYVQzcGxtVEpjVW9IMGpDK2JtdHJBUDgxUDNVM3JFR2RZYnJwcW9KbUo0?=
 =?utf-8?B?NGxWMlhpbWFuS0lOT2FhVUFRU3dKOEQzR3B5S1JLSUFYUFYweXdqYktTWjBE?=
 =?utf-8?B?VldXamxHZXF5M285SnNXend1OFI1NllYZzkwVlF5QVRUUlJMcW1HWUFzdmhD?=
 =?utf-8?B?d05JdkdVMjBabG8ydDhCYVhaVFVRUkpyNEt2Z2Y2VElGRmZ4LytnTnNiT09I?=
 =?utf-8?B?RXVIZEpVT01NMGt6Nmc5WHJhdGpmRm9jdElRejZ3Tm5HeTF0cEh5cVFLMmpq?=
 =?utf-8?B?OXJwMXRCdDE1M1FBeDBDRGtEdUVDRUh1TGlnVS9hR25IUWtMT3p3V2tqcDQr?=
 =?utf-8?B?N3NoRWp1REpZVUR1cnNPMkpxT2dkSm9IOG8zbUlGL1NUbXFSV0tOZ0hKRjBx?=
 =?utf-8?B?WDZkZUlkVUFRZERGd2dSamd2ZFBkNzJ1MGtGV3dSVm9HYldJOE5hWWppQUJh?=
 =?utf-8?B?N3J4SURVWHF2RG5mQ0REbDIzM0JEcS8weDU1akNtVTVEVmtOQnpmNDZreWlj?=
 =?utf-8?B?QklqS2hEQ3p0Ulg3K0ZqL2tDVGZYUzJWRFgwZUM4WFd5b0FVTHJ3YnNGUjBp?=
 =?utf-8?B?QWxmQ3FqTVQ2cS9VenFhbEkzdzVtczRIRjAvWFFNUU1SRXJlQmsvbXhLd3U1?=
 =?utf-8?B?RW9EMGpBNlJxVVVNamZXSXVhYTRXZjA4RjhJWFpVWmhYRDZ6ZlVxZmQyb0o2?=
 =?utf-8?B?QnBoYXhuSzBNS3NSZklyZ3hDUkxCT1EwOHJzeC9OUWhLL2NDZnBGWVZkcWRT?=
 =?utf-8?B?cE0vWC9zbE1yc2YrdHVRK1lEVldJMWM0SzNRUW5Vc1VLa1Fac05YU3d5R3pi?=
 =?utf-8?B?bE1yRFVSSjE3aDh6TGZEUVdZbE5qeUVGRTB5NDJZb0cwREhickovZGQ0SjVY?=
 =?utf-8?B?YzV6S1lJZkFxM2FEMkY0QzNma01KS1BsZk1kcHJPZ2tqdzVKOFNObkRETkgr?=
 =?utf-8?B?aUwwYjBqZVcySXlFWWxMOXBFeWFtY09RVVFzN0JGUk95K2JZcHZkOWE0eVRQ?=
 =?utf-8?B?WWhTY2ZERTdOQzUybXNZd2FrSi9zbXhXdHE4ZEtHMGJsZjhvWWlBaERrKzBk?=
 =?utf-8?B?bEw1azF2QlRvTzhIaE5QVTgzUmRDQ2ZmZ0tIYklLUHRGcHd3eXRFbkdQN2l1?=
 =?utf-8?B?NW9BanpIdkZsZFV4WitVUTBqTFlSblNyUzRkL21oa2tPcy9SRG1rYmpQT2Nh?=
 =?utf-8?B?eDFlNU52Mm5sU0tCTlBCcFlwQ3ZtNWJ1VS9jaGg3VGZtemk4Vkt0SlNiNTJQ?=
 =?utf-8?B?REoreDhBRWZudWVUOTlJMWQ2V1dIQ2M3bUJNWWQ4alZ3cjlqM1VNMVNFNWZR?=
 =?utf-8?B?cGRrNDl1dUM3dFNGaFJiQnJHeThQYW5lbHVSUXRhNTl3Qy82Z3UyNDlqOVE0?=
 =?utf-8?B?OFU3U1YzVlgxVVFFbmVXV2dhWE1FVERTNjlRSnNCM2F2UEYwSVZCQ1NmdmZm?=
 =?utf-8?B?dkNKbzlrR0hkNDF0Y0pWOUMwNFMvS0VZMXErSkExam5LM29jRWgxRzBadGhK?=
 =?utf-8?B?bVpBUzhaU3AyckVqeXhmLzcxS0swc3dJN0pkNkJXMmdnYWtYSks4VXhLTnhB?=
 =?utf-8?B?dEJWYTQ0Wm55V3liTnN1ZWdPZzJGMVJKQlpkTTZGM0g2di9vVisyTndpeE42?=
 =?utf-8?B?dGI3UWhQWHVRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2daTUtHRDlUUGQ0WTNtTThLcFlHWWpxdGpsV3V1ZFRpT0RMU3V2cVNEcml5?=
 =?utf-8?B?MXJ1d0d6enczRDdYTE5xMVdONHYyRUY2QTErZGVRQ3EvdVRNbFNqRHVJSGkz?=
 =?utf-8?B?VzZYWjJvQStFVHpaaTRudldBblhvbUtBcCtRZDhnWFFqd1pBTkRraUFxdzV4?=
 =?utf-8?B?YzBkeTdxa0Q1QUd4cjVrL0JPYmZYNHZ2eEE4bTBJTWxwT3RRRVFId2I2V0lu?=
 =?utf-8?B?S0Z1TUdTTUZ1clltTENSZmxDa2h0Zk10dVIzQSt6b0FzQTZla3pQWmw0M2FM?=
 =?utf-8?B?UmNzYVBpMVBTQU4yQzBFQzFRTWJpMUxyS0pzNnJza1lWTXREa3lTSVVmTTRY?=
 =?utf-8?B?WEVkNFV0TmdFOFhXdE1QcDZ0dVlCTzZnbmVIdmlVQ0JQMW5Mc1RFcUVUcHkz?=
 =?utf-8?B?bU1mSzBneUN3R2FmUG50bU03OStWQU5KMGc0dThMc3Y3NlZMVzFyOVJkdUQ2?=
 =?utf-8?B?b25NRGNzd2Vuc05hVStGK1pKdTFoTytINDNhbjdrWTI2OGNCY3I0WVR3cmw2?=
 =?utf-8?B?dWJpUzlVeFAvK1ZaR0NKSElEZkhPckdmN3huemMrOUdLamZnZW5hV2hoSldt?=
 =?utf-8?B?TGNPS0p5U1FzTWRHbEEvNVZXWEhVRGhhMVpHVUpzYmJ6bTRlWjgrc1FJc3BX?=
 =?utf-8?B?RmJmQlBJRGptSHpHQ1RtU292eUpCUUlGdnZDSzVmbXJiaVhjS05kWkd2emlD?=
 =?utf-8?B?L3JEUFk0UlJ0UTJlaTg5Y3dhTkpjZEJxbXI5MlpLNUJCb2dPRW1SckRQdUgz?=
 =?utf-8?B?MU83VmxGa0VHOGM4aXF2WXQ5Z1owMFNUNUhPWUc2NzUwWDVRSEdPa1dhc3RO?=
 =?utf-8?B?Z3M4T1h1NGVRcFYyMkw4UjhEeE1Nam5sUHFQakdpZjdJRm1Pa1Nwb0tyamtV?=
 =?utf-8?B?S1hEK1g4T3JIbS8xNXI1R0ttWEZFbUJRZy95NXM3cEdPMEJhZkZyNjZrNTFo?=
 =?utf-8?B?UTJiTUlzNlhUTmEyYnZGMU4wYnZwRTVQQ2VLZHBKT2NHL0FFckYrUHpRYWt1?=
 =?utf-8?B?SmhDTjFWampSYmVEeU92b284cTIwWXl5V052azZXZHJOS0dqVFhWWVVTS1hD?=
 =?utf-8?B?OWdzcWdVUW1wd1FJYW1CQWxubmordHBRQ3V6YTRPS1JOWlduZjJWdW80WXFk?=
 =?utf-8?B?M052UUtlRmN5Y09QZVE2MEtCMTZhVUovWExDNG0xckxneXJ0YUo1U3pVNlJM?=
 =?utf-8?B?c2o0ZXVmMzQ2OUhWdlB0UUNTY21tcFNseXprZXRkeW5Zb1FnK0J2a216dU56?=
 =?utf-8?B?N1VjeEQ2NDZyTUN0T1lGSCtKZlppa1h4Y2tJL2RSVUw1aVZ0Um5oencwai9Y?=
 =?utf-8?B?VHhzaytQaWdaTmV4VGRyRSt6L0pPSkNRRzI3ejA0RFdUZ0w3U3ZNOEVHLzN5?=
 =?utf-8?B?V080SlhkS1FjMHViWmJvb1JUYi8xWGFpT1RtV2RCZ1V1ZncvQzVsRThucnZ0?=
 =?utf-8?B?aVhidFJ6VnhKREVLMzBVT1FTTXBEa3dpU0wwN25WL0VZRldtT1lxZUFtOXcv?=
 =?utf-8?B?NVNyckc5bzlJT05pZlg3M1A1aUV3K28yai9NTmNpSjg2OTAyZHpJd2tUWVAx?=
 =?utf-8?B?TU9UZlVCM0J0c2dGdWpNbi9oU09LY0lpemVxMitpa0pRYVZMdmw2RHBSMklq?=
 =?utf-8?B?RjZJZHN3d2pUY1BQU1FNRC93NWl1cG1wcXQvMmtzMmtKTVY4UDh2RG8rR0Q1?=
 =?utf-8?B?STNiUzRWeHB1V25pWjNsZSt5eUxhaTZyZnlKZjUrS3A1ZFYwZEhsV0NFQ2lW?=
 =?utf-8?B?VnZmQS81RlM4ODl2eEFzL3dOblR1cHB4TktOZWJRSWZsTEw5MFNoM3AxSUpy?=
 =?utf-8?B?MC8zMy9FWTFESS9sQmhGQm5CcnNqeklVajAyM1pDQ0pDTHpvMDdrdnhxUFdC?=
 =?utf-8?B?SHd0SGFqblUvbnB5akt6K29XOUhzN1k3YUlFM3VIcGRxWmlYaXgxcFkyQTNn?=
 =?utf-8?B?bS92ak1uUGk0ZXJxUXJtQURieCttMTJVdXR1VTVrQzQvM3VsTDVSbFdrbmpH?=
 =?utf-8?B?ME1za3JjZElDOUFWRFo1OU9IWnVhL2QramFTWFM1YjJLMHlyc3loVFg3RHBh?=
 =?utf-8?B?ejJxZDZDalRIL21VT3NGWmU1UnBST2FsU1BMNjRyNytxYWIwY2w2dnlIaWVC?=
 =?utf-8?B?M0gzVkNHUUFISnFHSkovVW43YVl4TWZYRFEvMGx6UTUyWXZzNE9oMms0UVhy?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E68A73EDFEE324408BEF4FED15EBF169@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b303f98-c687-46ff-dc64-08ddac71ab85
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 01:03:56.4975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9qiKooS8Y428wGAM5WYNqJTCv5SHgc8fYdhzotsSJGNxTC5ppD8/8BpoYY1P5ZMqvWSngOss3bfRdWElJyUqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6551
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA2LTEzIGF0IDE0OjQ5IC0wNzAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdy
b3RlOg0KPiBBZGQgZGVidWdmcyBpbnRlcmZhY2UgdG8gb3ZlcnJpZGUgaGFyZHdhcmUgcHJvdmlk
ZSB0ZW1wZXJhdHVyZS4gVGhpcw0KPiBpbnRlcmZhY2UgY2FuIGJlIHVzZWQgcHJpbWFyaWx5IGZv
ciBkZWJ1Zy4gQWx0ZXJuYXRpdmVseSB0aGlzIGNhbg0KPiBiZSBhbHNvIHVzZWQgdG8gdXNlIGhh
cmR3YXJlIGNvbnRyb2wgbG9vcHMgdG8gbWFuYWdlIHRlbXBlcmF0dXJlIGZvcg0KPiB2aXJ0dWFs
IHNlbnNvcnMuIFZpcnR1YWwgc2Vuc29ycyBhcmUgc29mdCBzZW5zb3JzIGNyZWF0ZWQgYnkga2Vy
bmVsLw0KPiB1c2VyIHNwYWNlIGFnZ3JlZ2F0aW5nIG90aGVyIHNlbnNvcnMuDQo+IA0KPiBUaGVy
ZSBhcmUgdGhyZWUgYXR0cmlidXRlcyB0byBvdmVycmlkZSB0aGUgbWF4aW11bSB0aHJlZSBpbnN0
YW5jZXMgb2YNCj4gcGxhdGZvcm0gdGVtcGVyYXR1cmUgY29udHJvbC4NCj4gL3N5cy9rZXJuZWwv
ZGVidWcvcGxhdGZvcm1fdGVtcGVyYXR1cmVfY29udHJvbC8NCj4g4pSc4pSA4pSAIHRlbXBlcmF0
dXJlXzANCj4g4pSc4pSA4pSAIHRlbXBlcmF0dXJlXzENCj4g4pSU4pSA4pSAIHRlbXBlcmF0dXJl
XzINCj4gDQo+IFRoZXNlIGFyZSB3cml0ZSBvbmx5IGF0dHJpYnV0ZXMgcmVxdWlyZXMgYWRtaW4g
cHJpdmlsZWdlLiBBbnkgdmFsdWUNCj4gZ3JlYXRlciB0aGFuIDAsIHdpbGwgb3ZlcnJpZGUgdGhl
IHRlbXBlcmF0dXJlLiBBIHZhbHVlIG9mIDAgd2lsbA0KPiBzdG9wIG92ZXJyaWRpbmcgdGhlIHRl
bXBlcmF0dXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXMgUGFuZHJ1dmFkYQ0KPiA8
c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQoNCkxHVE0uDQoNClJldmlld2Vk
LWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQoNCi1ydWkNCj4gLS0tDQo+IHYy
Og0KPiAtIGNvcnJlY3QgcGxhdGZvcm0gc3BlbGxpbmcNCj4gLSBNb3ZlIHRoZSBwdGNfY3JlYXRl
X2RlYnVnZnMgdW5kZXIgUFJPQ19USEVSTUFMX0ZFQVRVUkVfUFRDIG1hc2sNCj4gDQo+IMKgLi4u
L3BsYXRmb3JtX3RlbXBlcmF0dXJlX2NvbnRyb2wuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA2
NCArKysrKysrKysrKysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDY0IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90
aGVybWFsL3BsYXRmb3JtX3RlbXBlcmF0dXJlX2NvbnRyb2wuYw0KPiBiL2RyaXZlcnMvdGhlcm1h
bC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcGxhdGZvcm1fdGVtcGVyYXR1cmVfY29udHJvbC5jDQo+
IGluZGV4IDc4NTBlOTFhNmUyYy4uMGNjYzcyYzkzNDk5IDEwMDY0NA0KPiAtLS0NCj4gYS9kcml2
ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL3BsYXRmb3JtX3RlbXBlcmF0dXJlX2Nv
bnRyb2wuYw0KPiArKysNCj4gYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFs
L3BsYXRmb3JtX3RlbXBlcmF0dXJlX2NvbnRyb2wuYw0KPiBAQCAtMzgsNiArMzgsNyBAQA0KPiDC
oA0KPiDCoCNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gwqAjaW5jbHVkZSA8bGludXgvbW9k
dWxlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvZGVidWdmcy5oPg0KPiDCoCNpbmNsdWRlIDxsaW51
eC9wY2kuaD4NCj4gwqAjaW5jbHVkZSAicHJvY2Vzc29yX3RoZXJtYWxfZGV2aWNlLmgiDQo+IMKg
DQo+IEBAIC01Myw2ICs1NCw3IEBAIHN0cnVjdCBtbWlvX3JlZyB7DQo+IMKgDQo+IMKgc3RydWN0
IHB0Y19kYXRhIHsNCj4gwqAJdTMyIG9mZnNldDsNCj4gKwlzdHJ1Y3QgcGNpX2RldiAqcGRldjsN
Cj4gwqAJc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBwdGNfYXR0cl9ncm91cDsNCj4gwqAJc3RydWN0
IGF0dHJpYnV0ZSAqcHRjX2F0dHJzW1BUQ19NQVhfQVRUUlNdOw0KPiDCoAlzdHJ1Y3QgZGV2aWNl
X2F0dHJpYnV0ZSB0ZW1wZXJhdHVyZV90YXJnZXRfYXR0cjsNCj4gQEAgLTIxNSw2ICsyMTcsNjMg
QEAgc3RhdGljIGludCBwdGNfY3JlYXRlX2dyb3VwcyhzdHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4g
aW50IGluc3RhbmNlLCBzdHJ1Y3QgcHRjX2RhdGENCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGljIHN0
cnVjdCBwdGNfZGF0YSBwdGNfaW5zdGFuY2VbUFRDX01BWF9JTlNUQU5DRVNdOw0KPiArc3RhdGlj
IHN0cnVjdCBkZW50cnkgKnB0Y19kZWJ1Z2ZzOw0KPiArDQo+ICsjZGVmaW5lIFBUQ19URU1QX09W
RVJSSURFX0VOQUJMRV9JTkRFWAk0DQo+ICsjZGVmaW5lIFBUQ19URU1QX09WRVJSSURFX0lOREVY
CQk1DQo+ICsNCj4gK3N0YXRpYyBzc2l6ZV90IHB0Y190ZW1wZXJhdHVyZV93cml0ZShzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgY29uc3QgY2hhcg0KPiBfX3VzZXIgKmRhdGEsDQo+ICsJCQkJwqDCoMKgwqAg
c2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpDQo+ICt7DQo+ICsJc3RydWN0IHB0Y19kYXRhICpw
dGNfaW5zdGFuY2UgPSBmaWxlLT5wcml2YXRlX2RhdGE7DQo+ICsJc3RydWN0IHBjaV9kZXYgKnBk
ZXYgPSBwdGNfaW5zdGFuY2UtPnBkZXY7DQo+ICsJY2hhciBidWZbMzJdOw0KPiArCXNzaXplX3Qg
bGVuOw0KPiArCXUzMiB2YWx1ZTsNCj4gKw0KPiArCWxlbiA9IG1pbihjb3VudCwgc2l6ZW9mKGJ1
ZikgLSAxKTsNCj4gKwlpZiAoY29weV9mcm9tX3VzZXIoYnVmLCBkYXRhLCBsZW4pKQ0KPiArCQly
ZXR1cm4gLUVGQVVMVDsNCj4gKw0KPiArCWJ1ZltsZW5dID0gJ1wwJzsNCj4gKwlpZiAoa3N0cnRv
dWludChidWYsIDAsICZ2YWx1ZSkpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJaWYg
KHB0Y19tbWlvX3JlZ3NbUFRDX1RFTVBfT1ZFUlJJREVfSU5ERVhdLnVuaXRzKQ0KPiArCQl2YWx1
ZSAvPSBwdGNfbW1pb19yZWdzW1BUQ19URU1QX09WRVJSSURFX0lOREVYXS51bml0czsNCj4gKw0K
PiArCWlmICh2YWx1ZSA+IHB0Y19tbWlvX3JlZ3NbUFRDX1RFTVBfT1ZFUlJJREVfSU5ERVhdLm1h
c2spDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJaWYgKCF2YWx1ZSkgew0KPiArCQlw
dGNfbW1pb193cml0ZShwZGV2LCBwdGNfaW5zdGFuY2UtPm9mZnNldCwNCj4gUFRDX1RFTVBfT1ZF
UlJJREVfRU5BQkxFX0lOREVYLCAwKTsNCj4gKwl9IGVsc2Ugew0KPiArCQlwdGNfbW1pb193cml0
ZShwZGV2LCBwdGNfaW5zdGFuY2UtPm9mZnNldCwNCj4gUFRDX1RFTVBfT1ZFUlJJREVfSU5ERVgs
IHZhbHVlKTsNCj4gKwkJcHRjX21taW9fd3JpdGUocGRldiwgcHRjX2luc3RhbmNlLT5vZmZzZXQs
DQo+IFBUQ19URU1QX09WRVJSSURFX0VOQUJMRV9JTkRFWCwgMSk7DQo+ICsJfQ0KPiArDQo+ICsJ
cmV0dXJuIGNvdW50Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3Bl
cmF0aW9ucyBwdGNfZm9wcyA9IHsNCj4gKwkub3BlbiA9IHNpbXBsZV9vcGVuLA0KPiArCS53cml0
ZSA9IHB0Y190ZW1wZXJhdHVyZV93cml0ZSwNCj4gKwkubGxzZWVrID0gZ2VuZXJpY19maWxlX2xs
c2VlaywNCj4gK307DQo+ICsNCj4gK3N0YXRpYyB2b2lkIHB0Y19jcmVhdGVfZGVidWdmcyh2b2lk
KQ0KPiArew0KPiArCXB0Y19kZWJ1Z2ZzID0NCj4gZGVidWdmc19jcmVhdGVfZGlyKCJwbGF0Zm9y
bV90ZW1wZXJhdHVyZV9jb250cm9sIiwgTlVMTCk7DQo+ICsNCj4gKwlkZWJ1Z2ZzX2NyZWF0ZV9m
aWxlKCJ0ZW1wZXJhdHVyZV8wIizCoCAwMjAwLCBwdGNfZGVidWdmcyzCoA0KPiAmcHRjX2luc3Rh
bmNlWzBdLCAmcHRjX2ZvcHMpOw0KPiArCWRlYnVnZnNfY3JlYXRlX2ZpbGUoInRlbXBlcmF0dXJl
XzEiLMKgIDAyMDAsIHB0Y19kZWJ1Z2ZzLMKgDQo+ICZwdGNfaW5zdGFuY2VbMV0sICZwdGNfZm9w
cyk7DQo+ICsJZGVidWdmc19jcmVhdGVfZmlsZSgidGVtcGVyYXR1cmVfMiIswqAgMDIwMCwgcHRj
X2RlYnVnZnMswqANCj4gJnB0Y19pbnN0YW5jZVsyXSwgJnB0Y19mb3BzKTsNCj4gK30NCj4gKw0K
PiArc3RhdGljIHZvaWQgcHRjX2RlbGV0ZV9kZWJ1Z2ZzKHZvaWQpDQo+ICt7DQo+ICsJZGVidWdm
c19yZW1vdmVfcmVjdXJzaXZlKHB0Y19kZWJ1Z2ZzKTsNCj4gK30NCj4gwqANCj4gwqBpbnQgcHJv
Y190aGVybWFsX3B0Y19hZGQoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHN0cnVjdA0KPiBwcm9jX3Ro
ZXJtYWxfZGV2aWNlICpwcm9jX3ByaXYpDQo+IMKgew0KPiBAQCAtMjIzLDggKzI4MiwxMSBAQCBp
bnQgcHJvY190aGVybWFsX3B0Y19hZGQoc3RydWN0IHBjaV9kZXYgKnBkZXYsDQo+IHN0cnVjdCBw
cm9jX3RoZXJtYWxfZGV2aWNlICpwcm9jXw0KPiDCoA0KPiDCoAkJZm9yIChpID0gMDsgaSA8IFBU
Q19NQVhfSU5TVEFOQ0VTOyBpKyspIHsNCj4gwqAJCQlwdGNfaW5zdGFuY2VbaV0ub2Zmc2V0ID0g
cHRjX29mZnNldHNbaV07DQo+ICsJCQlwdGNfaW5zdGFuY2VbaV0ucGRldiA9IHBkZXY7DQo+IMKg
CQkJcHRjX2NyZWF0ZV9ncm91cHMocGRldiwgaSwgJnB0Y19pbnN0YW5jZVtpXSk7DQo+IMKgCQl9
DQo+ICsNCj4gKwkJcHRjX2NyZWF0ZV9kZWJ1Z2ZzKCk7DQo+IMKgCX0NCj4gwqANCj4gwqAJcmV0
dXJuIDA7DQo+IEBAIC0yNDAsNiArMzAyLDggQEAgdm9pZCBwcm9jX3RoZXJtYWxfcHRjX3JlbW92
ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gwqANCj4gwqAJCWZvciAoaSA9IDA7IGkgPCBQVENf
TUFYX0lOU1RBTkNFUzsgaSsrKQ0KPiDCoAkJCXN5c2ZzX3JlbW92ZV9ncm91cCgmcGRldi0+ZGV2
LmtvYmosDQo+ICZwdGNfaW5zdGFuY2VbaV0ucHRjX2F0dHJfZ3JvdXApOw0KPiArDQo+ICsJCXB0
Y19kZWxldGVfZGVidWdmcygpOw0KPiDCoAl9DQo+IMKgfQ0KPiDCoEVYUE9SVF9TWU1CT0xfR1BM
KHByb2NfdGhlcm1hbF9wdGNfcmVtb3ZlKTsNCg0K

