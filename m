Return-Path: <linux-pm+bounces-12523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D224D957EED
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF7E1F23DB3
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9BC16C84F;
	Tue, 20 Aug 2024 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXcvqOWh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB616C68F;
	Tue, 20 Aug 2024 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137506; cv=fail; b=OVydCop7QlT7hPEZKAp4orZhvKalnYmVikC08bdT1zFiHOa36vrTGpvxkztj3GVUz4aB4bULdd73Q2d+/OLQZ6z485IlCabkBEn/4ljV5TSJTpI7x0k4kpQD6j1SQp/ApPlNwdzZZo8FDRyY/82GUp0tJND1bToabtm0TLsDw+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137506; c=relaxed/simple;
	bh=1PEmVwBjIc3Xc4fiZUaE4CVT026aYLI1g4FcuvA+sFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nZ0mY0x03Szb0FTP+0p8irAvknetKqACCosra83Vm9ZIQUfVwtCLdHW9fUw93FX6jPZzaOo6lucWH3QFeBIyeZ9mfZO05DfBpDGaREsh5qGNBFJv0qNckevj44EZXZRINXW12PxLYAct4z33c8IiTzObLBe1MMmSdUDj/6NI6ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXcvqOWh; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724137505; x=1755673505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1PEmVwBjIc3Xc4fiZUaE4CVT026aYLI1g4FcuvA+sFc=;
  b=KXcvqOWh3CG7m9zmTY+VR471CWZAB73BQW6dJLTF1AZVr68FDbcs++/R
   2dFdCUZpVE553Pez46sm7C3dxR6P6gH78XA7EwNVK1C8BiZBRqrLMuYSR
   YjdrSkHo6xbswhQTWPJPb6fTAAk+kGqa/Fuoh6p6oPvYcqDZ4SM88d3UC
   jweDjby3aDIJ/EMpF+yKL+Msoz6edr7meQEvtMSiL5lUr7HWOhg2aSS68
   hKJ8waj6gaTVtt/y1oRdz+IeNIjQnQ105Mvt1WAwD8soJfNTFwE3llx2V
   YGot8FnieK952zmj6HoFq7YtSDVk31xdHF+ycXc3zARl0/Q6eaLGhGCx+
   Q==;
X-CSE-ConnectionGUID: l2J7Hf0BQWyu6C3YBouF+Q==
X-CSE-MsgGUID: t1MORT39S1mmv3InK5shJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22582437"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22582437"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:05:04 -0700
X-CSE-ConnectionGUID: skR2jMQNRZO6EIqS1nMORw==
X-CSE-MsgGUID: C0EQxWYmTbSODvhzG4VHWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60330101"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 00:05:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:05:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:05:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 00:05:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 00:05:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnumSlhwckgBIfeFux1HyCkkD8JXbaQsQynfKDsMdhZO/VA6045GVH9w0yxUWs5/FfnPEwsMOGuYAfTUTd/Ymv0vqTDLHgm/T7jmI+uiLqsfnV4M7lZ9wMxTASpnzhn+dgg7Sv751X8F2xc8Bp2eE/0SL+BtAEZvjKx1tsj/PF8x5xp598ZU0YNbhJiU7grExd6eq2pO2vyP8cYeuNO12Y10ijy6eRZafwbl6UqJLjTQbd/ZpYYOIO4CXaeOUgn822+C0gyGlnoDYCRat5NUnS/sNTP+cX9opd45u7plCVQKr2ErwgKxHlctgUgFjPuYTnhfoFi8hBN3BQhO5/jkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PEmVwBjIc3Xc4fiZUaE4CVT026aYLI1g4FcuvA+sFc=;
 b=mDA0DrU6ehPEmO25R1JRjUSQB/o+I+zgfGdVkzDMCyOqi0wUCKoOT2lsfCs0ffv2H0L9WnaBX+u6h+mM2YfZ2dVH+0tfDcCqIFs2+XTM7OJ92MnqpPMy6/DKZEJm0mabSoPaZqD5IoaGG8ksjxI0cX9bG0lS8rRY4zES/Jh6Sc3Hs/7cz1zrq3hPomRXMpLYbp3YoDH3eLf81vvQBBGYIQzBsEdlfZjVkjPHSO1/qPbd3kIJxNzQPrnVMIkeO1nzAH1lc2vhbLb9nevJuyouyLfq7KdRdF13CSDVtaFeHDQNtNLadozio2V3twJjkX04bnQzef7P4EMZWS7pXpQifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 07:05:00 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:05:00 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 02/14] thermal: core: Rearrange checks in
 thermal_bind_cdev_to_trip()
Thread-Topic: [PATCH v3 02/14] thermal: core: Rearrange checks in
 thermal_bind_cdev_to_trip()
Thread-Index: AQHa8lM4JXGuSb/woUub1AhMz8AVELIvueOA
Date: Tue, 20 Aug 2024 07:05:00 +0000
Message-ID: <3bd97781fbd2e82a6c14a2e22aff2d4304c3206e.camel@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
	 <3324214.44csPzL39Z@rjwysocki.net>
In-Reply-To: <3324214.44csPzL39Z@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5125:EE_
x-ms-office365-filtering-correlation-id: 9bb791a0-b5e2-41ab-a866-08dcc0e6685c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a1FoOEJSMWJwNjBraEkwU0w2RVNtSm42WDlmOG9aWVZxaEhZcFcxdFVuMHVw?=
 =?utf-8?B?RU1HeU01ekgrMnlqeXdyWkQyTkw3MCtOUjZZRzkranJ4K2h4eGpQdC90K3FC?=
 =?utf-8?B?NXBtdlhhZXhPMldHb0puSFZzRkwvMTRjK1Bkc3ZLcG1kbUdGNmtITmxvdHph?=
 =?utf-8?B?WUEzUzI0OHVMeUVhV1dUeml5elJYWSthNm04dXZTbzdNQk5kMitYcTMwdEdV?=
 =?utf-8?B?UVhPKzFZVE1GN3NsK0c5eVlPeXlydHo0L3pJYStEWThjQ1dPOHlGdnBSVTNV?=
 =?utf-8?B?R1BpSWZSaTZwTmE4QTFGUldQRDl5M1dycXpSZWhPUTdCV2Q2RHhBVWQxaDlF?=
 =?utf-8?B?dnJ3TGVJYlhmYlpVdkxtT21EK1ZMNVJmcTRkQkFuOWkvZXNyRWNmNEJiY2dn?=
 =?utf-8?B?YStzTWFGenpHc2N6d0w2OVFabFJyUlhzVlk5dk42bGc3S3pSeW1lODlWNXdZ?=
 =?utf-8?B?eUZGK0g3dzkzVXFJclZadXRPeFgxWjhyRmQ2eWdwNzE1ZjExRm5NZXo1WmUr?=
 =?utf-8?B?bURzR3ljZlQyK3VKVFJCd1loN0J1N2RxeDVxdmd1d2pjWUx2cFdnOXhRRVlu?=
 =?utf-8?B?aURnOEVJVkFvN1pIbmJLd1h2ekJRbndWTjRNUFBqeWM0REFNS2lHaVNsZ1VV?=
 =?utf-8?B?eW05a0tYeUlXcEtkMjVZRzNNZDRzYUFXSERUZzdLT1RJYW1nSlk0RjJyUEVm?=
 =?utf-8?B?YU5tMVZibmgrRExaMXAwZnpkOEovVjlTNXMrV21UcTR2cXVGWmtIQWJaWkgz?=
 =?utf-8?B?OGhFWTk2aUM1bVdGN2dJbjJ6OE1OZGJvdDlzNENGVHR2L0hzRkdVMThnbUVa?=
 =?utf-8?B?Ykd0RVhvdmtvWTFVbDRSZU1vVmh5WXlIRWRGSG5PTGpvb25aOVA2VWxJb01V?=
 =?utf-8?B?QWJmcDdPeHJVYitoVFc4elhSVWZEakdWN3FGSzE0dVJBN203Qnh2L2NtbDVr?=
 =?utf-8?B?NUxUTFpDSmc0S21BRmc2bG9BdWY5eEM3eHN0WDlXSXkzL3FpZk1IVlN1QlZr?=
 =?utf-8?B?VFV0d21GeWVLb2ZMTlZpWXVxa0F4ZHUyYzhaWFEraVIzNytIb29UcmQyVFZq?=
 =?utf-8?B?YlgvQVZVUE1HbUZHcVgvTjdoTnBVdWw4WEdHazdMc1B6NURreElMUEZQQXF4?=
 =?utf-8?B?ZGh1ajBHb2JnUDlyYk1yaVdvRkVDcXB2SHpDY0gyMnpUaDBMcEJYekhvUkx2?=
 =?utf-8?B?ZzA4empCbjBPZ1grMGwzSlFjQ1hhVFprcWxLbDdhbVpucEFJb01WVEFjMWFp?=
 =?utf-8?B?Qy9TYjlGd2JaQ3ZxQnpKY3FQN1FhMGw1eTFTMm5uRlNFVjJKbHRudXZreC9z?=
 =?utf-8?B?MU9HUFVSNXptcDV5K1hsVXJOY2FtVi9LTGl3bkt1d29pOEdYYm9sNlN6ZFkr?=
 =?utf-8?B?U0Y0aXEvZEdvRzFEa05NYmdsOGpjV2lweEhEUjNwRi9KdXU1MnpXVVZrcm1p?=
 =?utf-8?B?b0EzUEtKVmVkNDBLSFRhbkljUXo4MUpDZTdxTjlIbWcrdFd0Zk9WYU4zN1Ro?=
 =?utf-8?B?TnRXcUwzb0RlSTJRSW9xWUtxTVhycEllRFZxZFl2aG1neEkzNXRGNVlTeEl1?=
 =?utf-8?B?SkI3UXRkM05nUm1XcVI1M1FLVHl2eDg5MjdZck9UMHh5ZC95cDAwNnBGU0Ey?=
 =?utf-8?B?UndaWDNaTFdNcGVUL3B3NzROaDc1RjRkMm44aVF1WDkwaXlndndMb3IybGJY?=
 =?utf-8?B?bFppaXp1akhuQ0hyeTJ1eHZJd2RFNkdWSVRZTEp2d1JEUEZSV24rbHJRMFFr?=
 =?utf-8?B?NGtCUXNRUENuc1o3TUJFVytxRFZTODNyZzRvQTQ2TkhCUlMrbEI2czRzK1c1?=
 =?utf-8?Q?aOI2Fav6vs08u5+f8vame4TmLveZcyLb7WFe8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDFoalBJYk9DdEY0MGJmZmdBbFdkVE1QcXIvbkUzdHJET3ZGbmtvSXB4ZVFr?=
 =?utf-8?B?YWdCcTI5SnpGQTdOd01mVDZhT3RSaTQ1NDAxbnJ6WHp4cThQQ1FJQ1V4L0VC?=
 =?utf-8?B?RkVGWTd4ek10L3FWTjMyZU01dE9NWXUwT2o0T3k0QlhlbXpmVTUyUEN4TmJ3?=
 =?utf-8?B?MkprWkVPM2cySlhsMVJaandsRXJJN2VSWUFsdzJ6SjlLWVF1dU90NWY3V01E?=
 =?utf-8?B?b1doOWc4RTdRMHBHbmdKM3Vzb1pPUlBUQUxIbWF1SjRNTUZ3c2tMMENLdVpC?=
 =?utf-8?B?YWxpV2lMWkJpcmdJeEFXdHFDQm5nWWt1WUs2QXFTQUFaWkVwbnZjNlZ1cFNs?=
 =?utf-8?B?bnRWN1JlaE5HdUdvc0VhSjZtSHVxcVEvQlZuRFNvMmRsYmNPUHl0VTlBTFV1?=
 =?utf-8?B?SVNLZ24wQXZ4L1ZXNnM0QUdqMlgrVjJldWFoS21UcFJiVmZRUnR2em92Y29v?=
 =?utf-8?B?emVuOUcwaDVFZ2NmNENXVXhlUmdTbjJxdXZaWDhLUjJUZFhDMllJeC8rUXRv?=
 =?utf-8?B?Y2dqRDVUeDBQRFR0WXN6b2JsRWJqWVVFb1cyekViay9YaHNhbGp0UGthS2xI?=
 =?utf-8?B?TGNCWmxXQWZNUWJTbll4dTFKWG5mSDBPSlFicllialRHKzRoU29zRGdITVlM?=
 =?utf-8?B?RlpsNDN3NHFMZlVpSHpFc1hDOS8vQVBZZDF6UUhQVUFkZmZSNmxEVzlRSHg5?=
 =?utf-8?B?RHhhT1EwSDBxVmgwV290K0JnTVZud1RzMTBuVWRERlZ0Vk5vWlFXMmxKRzJC?=
 =?utf-8?B?Z2x3YVYxR3dQcVFDT3ZSUkcxVVdYRlNiN1BOWHc4cnJUYXB4b0JDeDZQQmh2?=
 =?utf-8?B?UDZnRHAyUHFsSVZGYXEwNFR0cGhBYnVnWHdHQzB0a3IzSWUrYlFLTmJwVEpl?=
 =?utf-8?B?ZitYeDVLQjN4Uy9JOVlVZVhHb1FTOTFacGlSSmg5RnFBRGdidVVmd3hTaUlQ?=
 =?utf-8?B?ekZXSDBBZERCcGlOK0ppalZyajhhL0VGK2RXVWVoMFhQM0NlTktmaStzNFhY?=
 =?utf-8?B?Uk5zNHlTd1JWdE44NXlLQTJIN3dZU1FPQzcyZXZFUDZmbFhlZW16bW1iUHhn?=
 =?utf-8?B?WmtaaFl5OXluaGVpcHl3SVVGRTdmK21ia1N3Z0F3dlAra1lodmFYNDhVdGZj?=
 =?utf-8?B?UnFCc2JYcjlzMlFsV0ozVlF1WTFibGxLTmp2ZWZ4QWhXMFNOWUlTcTYvYUJv?=
 =?utf-8?B?QStzVFFab0ZmMm1JNEFVbTBrckN0K3RmckxzWDcwUFBJa1FRUFU2WEZqeURS?=
 =?utf-8?B?dE1GWndxd3Q5Y0Z2M1ZjcUVnc1hsOWgrUmtIcFUyWENnY2NkdmpFckN6dGFD?=
 =?utf-8?B?dTY0VzZNMFpYaS9LUC85S3BFMDFUbUVXeXYwZ2VUUkNtMENmdHUzM2tlZTdB?=
 =?utf-8?B?cDh2Wng3bnZ1THRXbUlyUnBkSjRQMXl0NDBQWlBCRFBmbjFYTnZKK2MyUDAz?=
 =?utf-8?B?YUlxK1Fkc0JsUHU1eWZwbFh0MnJMRWUzQzRib3hVZFl5ZE1sMVJ3L29JN3FQ?=
 =?utf-8?B?RzZldE9ndTVZblNjVkh5cnozMEswNkM5N21hSEpMT1liZ25iRVl6RUc3bnhD?=
 =?utf-8?B?VWhFcTI5TitRTU1sbE9qWEtNeFpYemJmOTBEV2hjOUl2d3cxRFY1UURIa1pW?=
 =?utf-8?B?Vk5rRVkrNnN4K2J4dFBySUE4eGZCWmpDRHNKYmFFZjdFT2RRdGJpd0pIZmlH?=
 =?utf-8?B?V0xFZ1l1cUtNVWNYdmJ5YTNQdnMvRlVlK3RVellRWmtYUjJHRm8vZ3hoRlFJ?=
 =?utf-8?B?NlNtWkpmeG1ud1hyYkttbEh4elhrcko3b0JqUGtabEdyUGNTai9CSTlMYUxw?=
 =?utf-8?B?cFU2dWxXcE5FTitIdlNxZUowdUwyczN3dnJ2QnFHZENBc1BLTzBwTHROL2xR?=
 =?utf-8?B?VnhOSGttZE5rSFprTytPR1R1N0o1QjlSVnBYcWVMOEpFNDAyUVZ1TllKZTlN?=
 =?utf-8?B?Qm9RM2ZYMEZxOUI3WjhmOFlvQnN3a204czFtZ2lPZm5DbGVKUGhaQmY1S1gv?=
 =?utf-8?B?eDdybnUvRXlXUWpOVnA1Zit0djV3SXV2dG1PdzNHNHhWcFowQUtJSFVaYm42?=
 =?utf-8?B?WkdSRFpNQ3lBUm0xei9vVi85bkczNmduQi81UmN2K0hYazVSbUNFNm9pU2tD?=
 =?utf-8?B?K2M5bUZ5TDArSzloQjdxSk1wVVZFbU9JelkwaHBWaEFVTStNeTNFcUQ5NkhI?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <224D66AF1D98C4469585F8B5CF5D182B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb791a0-b5e2-41ab-a866-08dcc0e6685c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 07:05:00.5650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWT7mh4DHxfuBTEOumh1i48GrPcM/DD11c+q7KIse4Uz+6/te5ygiRo8XU4tBWVp6RPg186wHLQgINbt7Pmubw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDE3OjUxICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
Cj4gCj4gSXQgaXMgbm90IG5lY2Vzc2FyeSB0byBsb29rIHVwIHRoZSB0aGVybWFsIHpvbmUgYW5k
IHRoZSBjb29saW5nCj4gZGV2aWNlCj4gaW4gdGhlIHJlc3BlY3RpdmUgZ2xvYmFsIGxpc3RzIHRv
IGNoZWNrIHdoZXRoZXIgb3Igbm90IHRoZXkgYXJlCj4gcmVnaXN0ZXJlZC7CoCBJdCBpcyBzdWZm
aWNpZW50IHRvIGNoZWNrIHdoZXRoZXIgb3Igbm90IHRoZWlyCj4gcmVzcGVjdGl2ZQo+IGxpc3Qg
bm9kZXMgYXJlIGVtcHR5IGZvciB0aGlzIHB1cnBvc2UuCj4gCj4gVXNlIHRoZSBhYm92ZSBvYnNl
cnZhdGlvbiB0byBzaW1wbGlmeSB0aGVybWFsX2JpbmRfY2Rldl90b190cmlwKCkuwqAKPiBJbgo+
IGFkZGl0aW9uLCBlbGltaW5hdGUgYW4gdW5uZWNlc3NhcnkgdGVybmFyeSBvcGVyYXRvciBmcm9t
IGl0Lgo+IAo+IE1vcmVvdmVyLCBhZGQgbG9ja2RlcF9hc3NlcnRfaGVsZCgpIGZvciB0aGVybWFs
X2xpc3RfbG9jayB0byBpdAo+IGJlY2F1c2UKPiB0aGF0IGxvY2sgbXVzdCBiZSBoZWxkIGJ5IGl0
cyBjYWxsZXJzIHdoZW4gaXQgaXMgcnVubmluZy4KPiAKPiBObyBpbnRlbnRpb25hbCBmdW5jdGlv
bmFsIGltcGFjdC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVs
Lmoud3lzb2NraUBpbnRlbC5jb20+CgpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdA
aW50ZWwuY29tPgoKdGhhbmtzLApydWkKCj4gLS0tCj4gCj4gdjEgLT4gdjM6IE5vIGNoYW5nZXMK
PiAKPiAtLS0KPiDCoGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYyB8wqDCoCAxNiArKysr
LS0tLS0tLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxMiBkZWxl
dGlvbnMoLSkKPiAKPiBJbmRleDogbGludXgtcG0vZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29y
ZS5jCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQo+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvdGhlcm1hbC90aGVy
bWFsX2NvcmUuYwo+ICsrKyBsaW51eC1wbS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMK
PiBAQCAtNzgxLDI1ICs3ODEsMTcgQEAgaW50IHRoZXJtYWxfYmluZF9jZGV2X3RvX3RyaXAoc3Ry
dWN0IHRoZQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdGhlcm1hbF9pbnN0YW5jZSAq
ZGV2Owo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdGhlcm1hbF9pbnN0YW5jZSAqcG9zOwo+IC3C
oMKgwqDCoMKgwqDCoHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICpwb3MxOwo+IC3CoMKgwqDC
oMKgwqDCoHN0cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpwb3MyOwo+IMKgwqDCoMKgwqDC
oMKgwqBib29sIHVwcGVyX25vX2xpbWl0Owo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmVzdWx0Owo+
IMKgCj4gLcKgwqDCoMKgwqDCoMKgbGlzdF9mb3JfZWFjaF9lbnRyeShwb3MxLCAmdGhlcm1hbF90
el9saXN0LCBub2RlKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChwb3Mx
ID09IHR6KQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
YnJlYWs7Cj4gLcKgwqDCoMKgwqDCoMKgfQo+IC3CoMKgwqDCoMKgwqDCoGxpc3RfZm9yX2VhY2hf
ZW50cnkocG9zMiwgJnRoZXJtYWxfY2Rldl9saXN0LCBub2RlKSB7Cj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChwb3MyID09IGNkZXYpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiAtwqDCoMKgwqDCoMKgwqB9Cj4gK8Kg
wqDCoMKgwqDCoMKgbG9ja2RlcF9hc3NlcnRfaGVsZCgmdGhlcm1hbF9saXN0X2xvY2spOwo+IMKg
Cj4gLcKgwqDCoMKgwqDCoMKgaWYgKHR6ICE9IHBvczEgfHwgY2RldiAhPSBwb3MyKQo+ICvCoMKg
wqDCoMKgwqDCoGlmIChsaXN0X2VtcHR5KCZ0ei0+bm9kZSkgfHwgbGlzdF9lbXB0eSgmY2Rldi0+
bm9kZSkpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsK
PiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKiBsb3dlciBkZWZhdWx0IDAsIHVwcGVyIGRlZmF1bHQg
bWF4X3N0YXRlICovCj4gLcKgwqDCoMKgwqDCoMKgbG93ZXIgPSBsb3dlciA9PSBUSEVSTUFMX05P
X0xJTUlUID8gMCA6IGxvd2VyOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChsb3dlciA9PSBUSEVSTUFM
X05PX0xJTUlUKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsb3dlciA9IDA7Cj4g
wqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHVwcGVyID09IFRIRVJNQUxfTk9fTElNSVQpIHsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVwcGVyID0gY2Rldi0+bWF4X3N0YXRlOwo+
IAo+IAo+IAoK

