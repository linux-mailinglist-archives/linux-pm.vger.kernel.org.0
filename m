Return-Path: <linux-pm+bounces-37662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD4FC428C7
	for <lists+linux-pm@lfdr.de>; Sat, 08 Nov 2025 08:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CAD3AEED4
	for <lists+linux-pm@lfdr.de>; Sat,  8 Nov 2025 07:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF33280328;
	Sat,  8 Nov 2025 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Of3iYOQp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EC3233723
	for <linux-pm@vger.kernel.org>; Sat,  8 Nov 2025 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762586260; cv=fail; b=NkGEIx4mGBOWaTjoDxrfxKZnt/coU95zmniUZ0bbQfVcQjcSrUgmGOHjbBHU85ZRhpA45BqVdMNxfdtXbVy7DkmqoqEo57SqvLlMJBySWL5cWsHoHdm0BzsPhs4by38AO9mPCLjyEs3Up5d3ktHsAgtxUDiHWMHOOBUvgRyUgtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762586260; c=relaxed/simple;
	bh=/zyL+37SFSTG5EahZZRJcAeyquMiG2mL32v7hXzwrlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YpPlezF+FK3ICfSHfxQMynG6yzl5vlXm9lISicgpWvb98a4BPuL9pV8kcj6ccdZjym9PH6UYGSlA8etzCqpKVz5/DVH1Vvu5SMmZkg3PYR8xepFdJ2tpq6v7dwV40BR8cD83lFXfW4bePX51aICJDTnOR+k1R+42pju6NjrsP2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Of3iYOQp; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762586258; x=1794122258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/zyL+37SFSTG5EahZZRJcAeyquMiG2mL32v7hXzwrlo=;
  b=Of3iYOQp4iH+dZGB/dYZxZ36oA6psl6WuA4KPd8QcnaJKarWJIfmwsU2
   cpTMKyu5lp2c53gM4oFQ3SHd7p/Q2Qq5t3uCNRSh7z5RRkcdm+v2d2bSc
   TcGMeAVWEU+HJkRxazk/iXxhoO9YZ3QcUPNQT4x4h0N6xZB7eIqXGW7oc
   ziF69pUYqA+F6xfS2cSdHgfLEylaxzrzxySqdceDvDnH4REivtOKXkoZ3
   Lz65LuTs1wZH6AYeJjg2DIkCjaYK3c49xfd01Z35eDMM7ONI+lhEp2vo2
   iMtBszhtPiaFhhMj1531jgzl5gUwvXxAInX0/35n0eHKJe+SaedkiZ0g9
   Q==;
X-CSE-ConnectionGUID: xF58IlzkThKLoWbUNr1dBQ==
X-CSE-MsgGUID: fnNlXLqZQM6QWyM1/Z1AgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="68373518"
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="68373518"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 23:17:38 -0800
X-CSE-ConnectionGUID: AAFy0zW2SoOyIdL7jTInJQ==
X-CSE-MsgGUID: z7WRpORzRHqmTfnSK4FU0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="192606389"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 23:17:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 23:17:37 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 23:17:37 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 23:17:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Au6zmEyjsTZCTaXLtoXZ6J+0N/70V12S7MmnmZGFKN9nRRuhJbOCh2Ciqgnx7GhpEEwiiuWJi8nsq9m5qMtZSxCwScKEvx7S8/YD7gFooX4RJtMgfT8sojhl/Es/WBKR3ZxO3DCGuQAw5dwou6jFWBTpwmlD6u73NoL6lj1mGVSMcaBSTY3+162TciDkTMv0yCVyAKiCUWDIoUHM0esOVJ2qflMJGujFuyHV64ff/GkhDxcssDJ3hpMP6wx7hxCNknGgmwF/beXvhsiqHP/Vzx8pmMTtobpk2YCrY6goyNKO3ElHiAwnvlOldNEux/tzoqobWWBRcAev9fIHqPSw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zyL+37SFSTG5EahZZRJcAeyquMiG2mL32v7hXzwrlo=;
 b=pL0KOB29+hyEvCR+8kIAoY3ihINZXP3V6ynAckJjWggiLJBmE3J9vmPQYuyfYCHQQxRcs3/MejwRV9z0iwo/zKZF6nRvE4QBhhM+4dUwE8LnhfDqkakrHIclQj/cOxfHL1R6gaJxfTUq/K4qz/VzEW/oEq86HUIar/4tbtSaibu3W9FMeetoixPHkmqK6JLwaBhoPUMRRW48QTiuRMmA7+kOT5MH2N6MqDKZLaf1Wx6vbYFo3qRoQuY0LdpiJL5gEixm6Dj7plGlO6cT2uZzeNfOVlfQCyV+DsOCxzqllTtiyYr57DgK9x6bhekJijgpide/2vf42KWFbf8VnpIn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Sat, 8 Nov 2025 07:17:35 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 07:17:35 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "pavel@kernel.org" <pavel@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "dakr@kernel.org" <dakr@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v3] PM: Delete timer before removing wakeup source from
 list
Thread-Topic: [PATCH v3] PM: Delete timer before removing wakeup source from
 list
Thread-Index: AQHcUCey5mM4Y0BgGUORxre2UfhhorToWe9g
Date: Sat, 8 Nov 2025 07:17:35 +0000
Message-ID: <LV3PR11MB87686D8E65B5895D66FD1EB5F5C0A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251027044127.2456365-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0iAHMUQ99Mc_cBDHPHcjG5p+o67SDmvwd_eAkDxR5zZmA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iAHMUQ99Mc_cBDHPHcjG5p+o67SDmvwd_eAkDxR5zZmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|DM4PR11MB6019:EE_
x-ms-office365-filtering-correlation-id: 360d094c-c177-4ad3-010c-08de1e96e426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?S24rZ041ZWNyWWswVDF0dm9KbnBzbzEwQm4xTkEzcGc1YmNJaVNNeXFiVmRr?=
 =?utf-8?B?SkJXaWprWFR1M25Kcm5yZHFZbUVnalB5TjF3WGs5N1A5bmVtSnBSQ2ExdlZM?=
 =?utf-8?B?MzJ6ajBoVWVQS0RNQ21VTzVNMnNRRmlYRXBCY2hqbGRNOTA4K0E5bGhpYW12?=
 =?utf-8?B?aXdWa21XbDJhVnNqUENmYVVpeGdnUVRTWXVneFZqbk1WbTJ3eTFDbVoxM3p4?=
 =?utf-8?B?Y09heVFob1MrZjc3eUFrOFFwcmdGend3ODZSNnNzdWFZWnk0YTBLa2N2M1do?=
 =?utf-8?B?c3VtaHVENndQMTJzSjlwRFk1QjR2TGRDazBCLzdtYWU5VWQrU0pWMktqYUxL?=
 =?utf-8?B?SURYQTJUTFFlRTBDQUw4OHdoWGl4eS9qRTgwWW4vNHVPSVlaT3FXTFBEZkFI?=
 =?utf-8?B?dmw1ODgwd25GUkNGK3I2T2J1MHlvUGxsRnhta0lLQlZRdkZlZ3Y3SFhuMFRN?=
 =?utf-8?B?dHArV1NxVm5LNHlmaEc0OUFGeTNHSDhETWx0VVhIaWNBM3FncVZ4Y3VFZnVU?=
 =?utf-8?B?cHlzRy80ZVJWWWh4OG1SMFJBdkhYWjBqYlJ6aXdQaWZCYks4YmRVbUtPVkY1?=
 =?utf-8?B?MStpdC80ZC9XSjh5SDU5Y2xScjh3YUxBUVRVeTdDdmxJUlJmNnRickxQcm9H?=
 =?utf-8?B?czIyMW5KbHh5R2preXJGQ1ZHUjgvcFg0cXMwV1hPL0ZZdW4rQjZ3TFowZkhD?=
 =?utf-8?B?VHZBbldRSG11YVlhTUxHZ2M0VUlDQVI3d0VRckdsRWsva1psUTEwWTBnTEFL?=
 =?utf-8?B?akpNM1AvYmlrTnljTDl4YzExSEFtV1lsNGp4VWEwWnJ1RjA3VGIvempiM3d2?=
 =?utf-8?B?QWVNTmNLTzFNcGFJU0JOaExpbnM3c2JPQ2hJTjN2VGsxSmp4MHVkZTM1bUdG?=
 =?utf-8?B?Y2gwdzJQcHRCNjIyWlNLZGlFNi9OZmlhL2h1VmN1THBFbUpsaXpab1AyKzEw?=
 =?utf-8?B?MjNnOEFvT0tUTnExWVNzc1djaHJMOC82RHBFbHlwK1RuaXdxbDluM1QwL0lx?=
 =?utf-8?B?ZWxYYThTQys3TkxrTG1mOFhiU1h4V1hlVlNsMmpZWDcwUVczY3U2WlZOVjU2?=
 =?utf-8?B?K0k2K084azNtcWFRaHpucGhLcFZ3VElUem53WWpXRkp5QjhnS0RSczk4a1Ax?=
 =?utf-8?B?VjBvYzRxcmlqL21uY3pEUE1tMFVKL05hWWZ6ODM4M3dTU213Q2NySkRUMk1l?=
 =?utf-8?B?YTA2bmVtYzh4UXY2YXRsN2JJckhpL240QU5uL09URDZ3enVkZnl1ZEcvZDVT?=
 =?utf-8?B?QVNqblhuMGhmK0pSTEZEZnBjaEpjVFN5eUY2dGowbnI0VEU3aUtPZG9COW4v?=
 =?utf-8?B?L2FVRTYvMGVCRmhhVGZYcUNXTkJ5U2dvQW0wRytaQXcwVFlwa2NUaWFOY1By?=
 =?utf-8?B?UTVFbEdhbXpPenJ5ODhjazVPS1FPNXp3aTYrYUY2L3NRT0tnNjU1QW0xTm0w?=
 =?utf-8?B?T0pCTUhTQUNOWHBwcm84WUJiRldITW8xZjhNSDZpOUdneHlFSWkzcWZHb1hh?=
 =?utf-8?B?Y0h5bTdHYXVoRFpjUkFYbEN0ODFDS0ZSSnpzWC9xd085QkdyZ2NSN3gyNGpZ?=
 =?utf-8?B?VC9iNWwvK1l3VHQ1c2QyZ2trWFpPdkF3WlRMOXV2Wk1SVVFYQkdCdjRjOUVU?=
 =?utf-8?B?Y3p4VG5CblJRQ0Rjcnl6d25DMVIyYVFlUXlQTTNJeGlLOHYxUlFhVmtkTVFI?=
 =?utf-8?B?R29NRUhKS1NWNVlYbTJWN1VnSDZrUnNVNmpTNHVncU5WY1BBaTNIQThibHJs?=
 =?utf-8?B?cUZBZmNudGJ3UWhJa0lQYVBsZjAvVHNET1dkenIzdEpNMjBxRm0xcjdicWdw?=
 =?utf-8?B?amRHNTZTUVNVWndYUjlSSTNlQkJlTVNLcU41ZkVvNWVBdWhiVFZDWll0YW1t?=
 =?utf-8?B?V2pBSjlIaFJ0ZnFRbmZXeWNGYllZQUZoZzRxN1Z1b2ZqRGlScklMcUJabVRV?=
 =?utf-8?B?YVRjZ1p5Zkl4VGtTM1lHdU1BVGFwbTdCZkdJZFZLMkpKdlRsSGVNVFhZVDE3?=
 =?utf-8?B?SU5qaGRlZVRncUs5alpZNi9rTEk2bFB5OHFyS3BHL21kd0drR3dVdFhWd3lT?=
 =?utf-8?Q?YXGgyf?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUp5UTBtbDN5Ykt1dXY0SnNkV2dxN2lGYXY5Zm4xMnpMT3lYTWt5SHZ4QnhR?=
 =?utf-8?B?QlpBOENTVGE5ODdyVkRaR294THhMdDJYaXo2NHVON2F5dVNIcjRzeGVnNE5n?=
 =?utf-8?B?RWFyMzk5UnhFcm5pZHYxUmRsdzdGSlgvTlZmTkZIcEM4S2tSd0xONDE0R0ZI?=
 =?utf-8?B?VVFHS0JMTnYwdG1WbHNQWTk4M0dMK1FpQ2x2bGJENTZFdjV0T2psY0FQa0hX?=
 =?utf-8?B?SlRObjJrK2JGNzRjb0Mwc28rdG1WdUNoczRPYzd2REhZUnpQUjRIMmg1ZUJ5?=
 =?utf-8?B?VXIzZlh1QzVXMjUzWXpCaEdyRUdMSFlXeElQbXdyT0Z3VnJEbVVXRkNVS1ox?=
 =?utf-8?B?TU5wdXhIdi81alhZbzZMQTNPMEljOUdYS1BzbkN2NHZtQnRRYVJzblRVRGRx?=
 =?utf-8?B?QUdCYVM3U1V1dFFibWNMM3M2dHVnaE5WeWNWaFg5NmJEaldscXEzQm8xZktv?=
 =?utf-8?B?YytQMDlrRnhnTnRuZDdOSS8zbjVzc2g0dVYxMmtKN2cvemZYamJJUzJxWURh?=
 =?utf-8?B?QWFYbzhvb2hBOG9OSVRzV2krajlISWIwVjdLWXBGUnRoVlZvU1FrYUc3a0VH?=
 =?utf-8?B?NzEva0JQdTU1WC9VTGI1RklkZVJWTm1TRDBpQ0Q4WkdLcDM2anQvWmd4RVc5?=
 =?utf-8?B?SnFCdTJsdGhFOGJ2blV3cW1Yd2t1ak5sR09UWU5BcmZkVlBtanBFdDZIVktk?=
 =?utf-8?B?cHFlTGkvSHdNVGtEQWcyemtLdkYxdmxBLzRlbWV0NGJLeDkvRUhRalZQaVNQ?=
 =?utf-8?B?N2NySHRRNkF6WlpKTFprNkpoMVZzclJrdVJWK2xNRGFjeTFoWVNjWXhyczAx?=
 =?utf-8?B?TXoyOG1jZ0g2YUxpV2tGNHAvRjMvYmd5MU5hSktidEJESzRUaklGYlFjUmN6?=
 =?utf-8?B?c0VrQ0ZFR2cwdk9kRHlRY3BsL1JyWnF0ZE5kVzVyZG9NSS8zYzF4Y3djc1Qx?=
 =?utf-8?B?NjkxU3l0TExQNjJKNDhRV2VjbVl6UU93aU1qNW1LemFUSXJkWkRWZlNldkxI?=
 =?utf-8?B?amV5WitPL0t2Uk4zK0ZaclVMb2ZHdStHZGtWUnhpbWpKN1Exd1oyb1FYQkZY?=
 =?utf-8?B?MTRPMjEvbk5lWVU4Y29tcVQ5WVd3ZnEwaHpRKzBxcTBHenVhTG94aU9uenRT?=
 =?utf-8?B?NTgzMTJiMHZtamdkQU1VZkNKVXhDZVFacUlJM3NyOWdrUlRNTHQyc1B4bzVO?=
 =?utf-8?B?M254UVI0MGZUK1pleUtDd3dNTTJqVjZIaDVBWXg4Z1NaYkxjUVBvNThtcTJR?=
 =?utf-8?B?ZEFkOXRpcm51d0RtbGU5NTJoc3FadHQ3Q0Vqd3lSSnNpRXR4Z2U3S2QrMUFw?=
 =?utf-8?B?WXNLQ3JoVHUwZ3RQZUs0Z0ViWThGbXBsYmpXQjVCOWZacys1UWk2dEVmSXA3?=
 =?utf-8?B?SXh3QjAza0lIWWsxQzFPakluWEkzRHdZaVYxY0grMjUwcHo0NlJidkdYdHFV?=
 =?utf-8?B?cWhjR3hMbnN3bkFROWpNR1RZMG1xaTFKSmJZTFVNdzZoRUZQRHZqVFFHWXJF?=
 =?utf-8?B?Tjh3Q2VkS0Y4RG5YRk1RUlF5TG5VNHZWYnpLM0xjMmNZblMyMjlvb1owT1Mv?=
 =?utf-8?B?NVNOb29yVWJYRlpJWEpmc1VmQ3NQemx2S3NaVnJybjhaaVRsVHh0c1FZOFZR?=
 =?utf-8?B?RmRoZUYwTEZpR0ZjV2Vsa1ZlTTlZcE1YcUdZcldDQWFXenZvcXlyZ2VuWVRx?=
 =?utf-8?B?TnFmcEVIeWQwTHg1ZmpPdzZub05wMFA5OW81VXp5ekthVFdWSEJtR1dncE5a?=
 =?utf-8?B?TnZuSjQ0c21OYnVhVG82UmNKcGhFQTlBYUlRNWtSc21Gc0hnVzh6R24ySHFm?=
 =?utf-8?B?dkVJV3FJOEtKMkwxQUl0YkpvNEIrMG1rZ09OWDZKUllUakVEMVhDMmhoanR6?=
 =?utf-8?B?bDRkV2QwOE9zYTZrODgrMUNydWU0Y0lFMGMrWUsweTNNc2xuZHZDSDdHZGRT?=
 =?utf-8?B?TXo5bmhaZU8vSHRRaGNqR21KSmcxYUNRUzFsVk45N1JtT28xeXNEQUpsa3l0?=
 =?utf-8?B?a2RpL3pid2FJTGh2cEx1Y1FOVmNTL3JJMEp4bzdmME1oU0Z1bXlTSXVVMVpY?=
 =?utf-8?B?V1VUSXV4WDRhcmozRGtwTnB2cldLRU9RUWFlNEVkaW83TGtiOFprRVdvR204?=
 =?utf-8?B?UW52OHY3VlhyRDkzQWRjOXlsUmw5ZVNpTEZvUHBoVlYxYzVZRzdVTGVucG5R?=
 =?utf-8?B?M0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 360d094c-c177-4ad3-010c-08de1e96e426
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2025 07:17:35.4481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gi3kKzDOv8mh1L4iNj3Yx4c+E4jO7P6XR/h565BdtFnXXj+h2uhYG390iOSh1cc9QEfyMYBUzOWhQX4cGe5ZvOKtM+EOvGOoE/th3fZteGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6019
X-OriginatorOrg: intel.com

T24gW0RhdGVdLCBbUmV2aWV3ZXIgTmFtZV0gd3JvdGU6DQo+IFNvIHlvdSBuZWVkIHRvIGRlbGV0
ZSB0aGUgV0FSTl9PTkNFKCkgZnJvbSB3YWtldXBfc291cmNlX2FjdGl2YXRlKCkgYWxvbmcgDQo+
IHdpdGggd2FrZXVwX3NvdXJjZV9ub3RfcmVnaXN0ZXJlZCgpIGJlY2F1c2Ugbm93IGl0IG1heSB0
cmlnZ2VyIGJlZm9yZSANCj4gcmVtb3ZpbmcgdGhlIHdha2V1cCBzb3VyY2UgZnJvbSB0aGUgbGlz
dC4NCj4NCj4gRnJhbmtseSwgSSdtIG5vdCBzdXJlIHlvdSBrbm93IHdoYXQgeW91IGFyZSBkb2lu
ZyBoZXJlIGFuZCBJJ20gbm90IGdvaW5nIA0KPiB0byBjb25zaWRlciBhbnkgbmV3IHZlcnNpb25z
IG9mIHRoaXMgcGF0Y2ggdW50aWwgSSdtIGNvbnZpbmNlZCB0aGF0IHRoaXMgDQo+IGlzIHRoZSBj
YXNlLg0KDQpUaGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4gDQpXaGVuIHRpbWVyX3NodXRkb3du
X3N5bmMoKSBpcyBjYWxsZWQsIGl0IGludGVybmFsbHkgc2V0cyB3cy0+dGltZXIuZnVuY3Rpb24g
dG8gTlVMTCB3aXRoaW4gdGhlIF9fdHJ5X3RvX2RlbF90aW1lcl9zeW5jKCkgZnVuY3Rpb24uIFNp
bmNlIHRpbWVyX3NodXRkb3duX3N5bmMoKSBhbHJlYWR5IGhhbmRsZXMgY2xlYXJpbmcgdGhlIGZ1
bmN0aW9uIHBvaW50ZXIsIHRoZSBleHBsaWNpdCB3cy0+dGltZXIuZnVuY3Rpb24gPSBOVUxMIGFz
c2lnbm1lbnQgdGhhdCBmb2xsb3dzIGJlY29tZXMgcmVkdW5kYW50IGFuZCBjYW4gYmUgc2FmZWx5
IHJlbW92ZWQuDQoNCkFyZSB5b3Ugc3VnZ2VzdGluZyBoZXJlIGEgc2ltcGxlciBhcHByb2FjaDog
anVzdCByZXBsYWNlIHRpbWVyX2RlbGV0ZV9zeW5jKCZ3cy0+dGltZXIpIHdpdGggdGltZXJfc2h1
dGRvd25fc3luYygmd3MtPnRpbWVyKSBhbmQgcmVtb3ZlIHRoZSB3cy0+dGltZXIuZnVuY3Rpb24g
PSBOVUxMIGxpbmUsIHdpdGhvdXQgY2hhbmdpbmcgdGhlIG9yZGVyaW5nIG9mIG9wZXJhdGlvbnM/
DQoNCkFtIEkgbWlzc2luZyBzb21ldGhpbmcgaGVyZT8NCg0KQlIsDQpLYXVzaGxlbmRyYQ0KDQo=

