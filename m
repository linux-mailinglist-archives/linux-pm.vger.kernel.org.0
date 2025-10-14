Return-Path: <linux-pm+bounces-36045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05504BD82FE
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 10:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 741E34EB661
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 08:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C532C15BA;
	Tue, 14 Oct 2025 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZAMUhq+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439622DC32D
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430762; cv=fail; b=CBs8xwhQ3U/2AYIHDQGC+qnDv+o6JS1gDaTMvSD6eg2jUwIJpQ9lQ39a4bO0eXJtlUGc68w2Homs7JT0IUO+fw57GhfFFqJ/87/cTZuclqCGhI9nLxoBrNr9f6OfeQh8B4FvLfDCwpaF6Sh0eho3H6IP1A9plHbG3en/sFa3wWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430762; c=relaxed/simple;
	bh=JuKhDeFdTKzH1S5e04gu0UUqmAyKTkfra1cxM6xXQYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iy+AoBEiRWcx+OCfjXKranLdoeeBV++GWVehwwiR0Jgw14k8cySZDfdxcJd81qDi62C7WWASlGHbh/0mdTqWqbRWrK2IBajmxPZYhIMNyeQh0IUIcE1VYRwvqiNXotH/MDJBSoUPM2zCLyrFV5lI6O79zIHfmF/MAXxULOl/N90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZAMUhq+; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760430761; x=1791966761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JuKhDeFdTKzH1S5e04gu0UUqmAyKTkfra1cxM6xXQYo=;
  b=SZAMUhq+W1CmTpTJAqW4+0mdaJxwnDc9mBtqrq6YkT4KhZleheXBtd0C
   +FgB5IZ+qPZJS/56gRLANjbXcwuvphlFHLrQnjIkFW71wHqtqFLWktlup
   +IaPwTTv5SSoh97Vm0bxt4VbxVANsvwzDaa4fCE4Mi/GAMDeIT29aAe+5
   bx4huZZRcCyoRGFIyKkOlyWihY4V4+zs/UOJRVvVJ5ZlMNMQ4sHET/ON9
   tBVs2Gwu7D0AbVG0fBRFk4epwCHZH61eVSm32O0czvwn3qcadi1/aEP9j
   GBjtkmPAPxls+CagcE2ydfkSJL7GgbAWOs003piWkwcTF2j+UGMEQCGJg
   w==;
X-CSE-ConnectionGUID: XYygFHqYR7i653FBr6bt3A==
X-CSE-MsgGUID: y1/EFd54RCqfw735Oykh6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62480948"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62480948"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 01:32:37 -0700
X-CSE-ConnectionGUID: qY+32vbCTG24i+jn2O4oAQ==
X-CSE-MsgGUID: XPK31K6xSveDeqiPN68m8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="212797780"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 01:32:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 01:32:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 01:32:34 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 01:32:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6b3B1wyNpfEOlIMKwvpAHr0/abyR8p/zbGadu8268Rx73o+9oaUCEM/4fscs6X5cf5ZI5OIEu1nK6IzVCUzIA+HbMm4X+dNk27yWu+eXs9w1R1TuUSPUnlGsdj89BzegCF0Rj9Nmlz2+Rn9/jkePsdPfMAfQM7KiqZX67RVdBKVGxpjAavRh3aR39iooJONNYr19YWT6rsl+Fu4xubSWTmsTBPuvGl3Eckte1lCePcpapwKEnSxGyH+8ZY8eX4cKPf4pGEaL3nmTQSGsBp5/XRPc2NPEI1i8w6XfmxQxTUVDYKUE2Tbyav2KjsUk2GdG7ALUxj4gwnVuA4z7aESzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuKhDeFdTKzH1S5e04gu0UUqmAyKTkfra1cxM6xXQYo=;
 b=yy7OpsNkQtcXzD6NQ+ySTZZBHgQxhCs+jRyrgGBe3uMjYGsQ/Dn6CWoJ5ymSihuPksLjPHkNf4btvJcP+QdYJNPWUeKB+05/PtvQPA3j5i9tYb72Jn90scdk42ie6M3QPgN4Dg+yBWeR9UW4/Kjn6KK/Wb0WwuAr3iCojm6sIsU1HM1ZfbNdurD/ovMW4qMLq1pqj2049DW3lRcwW1Yym4eGSALROvCE946xAAkeNASlHvlIN89KdVR5lf0mn/bB/UPq2kYNmmIV2c+WdR1lA9260dX6mwTMm3pJlw/7OvIh22N5shjaVIded//jOPgUCHyBE3dhZbGZ7r+9UVtmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by CH3PR11MB8342.namprd11.prod.outlook.com (2603:10b6:610:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 08:32:31 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 08:32:31 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "pavel@kernel.org" <pavel@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "dakr@kernel.org" <dakr@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] PM: Introduce CALL_PM_OP macro to reduce code duplication
Thread-Topic: [PATCH] PM: Introduce CALL_PM_OP macro to reduce code
 duplication
Thread-Index: AQHcPHMowmygu+QRUUCJn9PveF12+7TBPiaQ
Date: Tue, 14 Oct 2025 08:32:31 +0000
Message-ID: <LV3PR11MB8768BC1D37DA902428C384DBF5EBA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250919124437.3075016-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0iXAO6Z1t-LeGgutsJRbfL7+Xtszq0h_pG+QFfPbfET7Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0iXAO6Z1t-LeGgutsJRbfL7+Xtszq0h_pG+QFfPbfET7Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|CH3PR11MB8342:EE_
x-ms-office365-filtering-correlation-id: eabd5216-6801-47d6-9ee9-08de0afc3784
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RUk0MFRKakw3Vis4UG1PRnVQVWY2VUhCaytaY3ZVSWlUam1pblY2b0JlVy90?=
 =?utf-8?B?SVhsdGFkWGRxa0Q0bEE5NnR6K1dRWmJiL2MvaHhVekNWaU96S25qSFRVZDlm?=
 =?utf-8?B?ZHppaGt3ZjYrWi8va1UwSTkwZGh6NEtmTm0yWENrM2h1V1hxUWFXMmRBYVQ4?=
 =?utf-8?B?THlBU25VRmora0orbzBGL2NvZEFCNjdqaW5TRWoyZnpxczlOUjhFdWtJZHdL?=
 =?utf-8?B?NFBEVjRBNEIyOTljM0VQaWhhT1hoY2tYSnJmQ0JWOWt6S1FaK0tiM1ljb3JO?=
 =?utf-8?B?b2pvTVBQakFoSzF0RGk1Wmp1T1FNOWQwV2dsY2U2L0FyM3NwVmhDUE1OZU52?=
 =?utf-8?B?TEREUDFHc1Y4SHhVM2xrVVMvMXlER3ZlZ3NoR1hNYWlaWGxRZGFQOHJYTm1m?=
 =?utf-8?B?blZoOFkvZVF4RVV0YUNYMUYrWjJVSVR3UHVXczZBZnNTY3RQakRKS1hraXRH?=
 =?utf-8?B?SlNVR0lSRndSa2g4N2IrelBTd2xOOUV5WWtmbzZ1dmdQb1lrdnR0Z3lKVlEw?=
 =?utf-8?B?NXdpSmpEVDhlVkxYV0ZMRzYxZEF3cTk3SFdBSkJobjZGN2MxUVppMnNDeElM?=
 =?utf-8?B?Syt6ajBMdWFlZUlaNHJiK2lHeENrdjJJQ2FkZC8rZzFxems2THEvR2VwZjcv?=
 =?utf-8?B?aHB2TUZWTTZRK29LdzhpaVN0R28zNVZIa0N5YTJxckp3UUV3bTErUGJHaXNY?=
 =?utf-8?B?TjhmNk1wZ2pCcFowWFV2NXVWbFJUVGtBN2k2emVJL05JSUNiZFVhRzZKbzNK?=
 =?utf-8?B?R1FiQ0RsOFpwOUJCRjh2bXJKaG82OWQ1N0R5MmEwQkl3ZUJtT1hYVFBieEtU?=
 =?utf-8?B?SWJjRzBQZjZrdzJTcEp0V1NSL2MwSzM4U1FTMVFyRmZVcHFsdk5pSUJycjZC?=
 =?utf-8?B?b2U4eHMxejc5YTZjcFYva212MmJWaXNoN3pkRlJTOENkZ2o2SkxGTFhmcUJ4?=
 =?utf-8?B?UVlzbTZXRXcybHYrNUxKa0laTm9uL1QrZ3pWYWM2ZHZNb0F2Zkxzck5ZUkc3?=
 =?utf-8?B?YzRoZS9qN1p0RE8zcU8zSlFhbDRMTVcyMnJMRnU2R2x2bWVpN3R2WThjTS9L?=
 =?utf-8?B?SVBqQ1dHbjMwQURnUURMNUVZUTFjQ0V0c2YyalQ5NkJ2TWtrdlFwb0NhbmRr?=
 =?utf-8?B?NXdseGY3eWNhOU9mRWFxVzhsS3BYclpGUHFSR3JxZE9mKy9DY1ljSEt5NGNp?=
 =?utf-8?B?Ykx1STJBbDdxUkc5Wkd0ZkZFZlpOUm5QSjhIUldsMWt1allSVVRsNlpzcUg5?=
 =?utf-8?B?VnErME9YSkpac3dwRU9QVkN6ZkkraTZZS0JuU0J2WmNkRGMyQ3NXRDJJc285?=
 =?utf-8?B?MWdROFlubXNGWGdzRWdBTklsN2xjUUoyeGdpK29WOHBxaW5RUXFtdi9rZURj?=
 =?utf-8?B?bkJpdk5zL09teUxxSXc2UmZ6cjJaaUxWN3BXT2ZMOUhNZmc2MWViVFR5VmY3?=
 =?utf-8?B?MnQ4VndLbnQvcEgrOE94NmtaT2pQS2w5M245MnpRU1g3a1ZvN0RMdDNzUzQw?=
 =?utf-8?B?bVpVWWIyRksrVVJmcURxR2plNHpGd2NiMGJNN1lwOFc0Q1lYeWtzS1BURU5D?=
 =?utf-8?B?OE9TSW5HOW95SU1wTVVNcUcrZzhXbTZjTzFTdUltZ1JScFA5c1J4TXhJNGNt?=
 =?utf-8?B?MjEwM1o0Y1dVYjBiNU1oN2pVcVZVeHAxclU3Y01FaGpIZzN2U1lmWEtxWU0w?=
 =?utf-8?B?MXI0N1lsaGRCakxRT2hpYjdIcHlmTXlaaEtiZGlOTUZydkJNVlhESG5FTCs0?=
 =?utf-8?B?WUJsL2ZtUlFmblFwRmxqd29ocWcxL01sT2ZJd3luVDJEMVNBTzlES3JQZVU3?=
 =?utf-8?B?dU1rbUovQi8yYk1CVUwySm9oTkxWQ21oR3BKQzRrbXdhRUwrS0xBYXVIQVVx?=
 =?utf-8?B?dHB2bHJ2MnNyb0J5R2tQTEY4WklVRjlLTXUveVk2dElCK0JqUWp4NGRPU2JY?=
 =?utf-8?B?UFVxWjAzVkFSU2U0ZHR3V1YwSmsxNUhSNWx5N2lzK1dHMmE5TlcrcHlmaElF?=
 =?utf-8?B?cXVCZFpWZXZpQWpTUTgwV3VVUnRYTzBTSkw5UW0vdXVENVh2MVFTdGZaaVNU?=
 =?utf-8?Q?LghncG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmsrUGFQQ2VXU0tWUFFHQmwxTW5aN0s0YzQ0UDJBZDhFQjIvYk4vN2IxR2hW?=
 =?utf-8?B?MVZrYndRNUhWaXRMWk9handGQ2NTaFBrZ2txKzJPYkRYb0ZLc0pmWThDaEtl?=
 =?utf-8?B?TEM4UkxKeVB2UU9YUWVQcUUwSUZOL3lEZlk1KzlrUmF4M0JNS2FobFZHekNV?=
 =?utf-8?B?bU9uMzdGYTlLekFhdFNvRHNsaGVJNysyTnRqd3drcHhldkk5bUFNZ014NDIx?=
 =?utf-8?B?Z3RHazBPS3pRVXBESGxhaGFxUEtsM2plaDlod1ZvUk9RaDl3QjZiYmJHeGIv?=
 =?utf-8?B?UU0yZ2UvY05aUUlndk5vU2RxL2U5NXhYRHdZd3Y5djlhR243K2w4OW0wUkNU?=
 =?utf-8?B?Mm94ZDdnNnN6MlVuYkVQS1N1aWR4UWw4andoYk1ndm8zNVYzQmpCREZSeldS?=
 =?utf-8?B?NGpFNXNoTi9kYmRacWR5U3dyQ1VrTnhkUHhvOHRSSlJYelZ5OGx4YTd3NThB?=
 =?utf-8?B?cWxhN2h1L2hRZEpGb2JwdEtmQTNMbTJFajlkUUl0NlBqemdyUEFPL0lzS3c1?=
 =?utf-8?B?WmJzSjBSR3IrL3JaN3J2ZS9FU1AxNGkweEpFUVAyRG9HQ045ZmpVTmRzTXV3?=
 =?utf-8?B?clV2aTRNcHFyRms0b1kzNzlhODlEelJubEtvRFZoeWw1c0JPclBoQnpCVGxK?=
 =?utf-8?B?TjJFYmJDRWQ0czV0M1o3NGZ4RWRXMnBVSGtYdHgreElMTkQrSnp6M0JxYkJ5?=
 =?utf-8?B?UG9uRkFtaDlTYVpkVUdESm8zL1ZsdGZEUldPaWVSd3hrR3oydnB3bk8zQWlt?=
 =?utf-8?B?YnVTekZ3UjRMMllHVlkva3VNaHZOTSs5QXVoYktJeGp6YmEzNFNFZG9PcEwx?=
 =?utf-8?B?QjduNmNmSFFXWVdaWmRjMGtzWkxEZ2xycFhpU1lhNHhLVDU4dHE5bGpGelhY?=
 =?utf-8?B?SFE0eFUycmg2MFlnWUNkeU1JZFNJek1SMTQzMGR2YzJGSC9lZGlNcXhFME81?=
 =?utf-8?B?S05TWFU2OWo4UWg3cUpmUGVUaVozMEUxa3JTY1Vhc2l3akcxTmg3QTBjR1Z4?=
 =?utf-8?B?bFZQWkVnZGdVdE1HdHRjdjlxdjlKamphUDBMdzJaL2FBa3U5dGpVYWxwY1ll?=
 =?utf-8?B?R0xjK2ZRLzN3Y1dCNU51NU51ei9wODdKZEZVVUFrQlJ4S2o0Tk9QNERKR3JM?=
 =?utf-8?B?MkN1OTlPMHA5ZFZYdlVyY0dqTXBSNzB5dkxMdEFWYVlGUjRVWU9wZ2gxWjlQ?=
 =?utf-8?B?eTRsYzhkKzhtcEdjWmVLUkhWcHVsR1NiMHFvS0hrMlRMbFJIWVZ2Z2xKL3hu?=
 =?utf-8?B?Yjc3T0Y5WTd2ZEJNYU5yeExtNGt3OGRRd2YvSHppQUVwNXI3WFJOTHhJVGNq?=
 =?utf-8?B?V0ZjR1hySmxoQ0pscytpbDFqOC9TSFc1dW9NeWpkV0ZFZ2VrT3NSbnE1WlNl?=
 =?utf-8?B?ZHZwazkxM20xZUN3Q0F5Wm1RemdUSXFuYThXUGFkVHpqSHFiNGQ2TUIrSHNI?=
 =?utf-8?B?RGw5M2tZa3o3U3FOZWIwY2U3dUZ4aVhPYUMrbGtScUFwNnZCYkpFQXNsbW9m?=
 =?utf-8?B?M1hPVWZPMHh4anV5dVRobElMaEVHaDl2NWVDSmxXZFpsckIyM0c5dDBrcUVk?=
 =?utf-8?B?dU1pMmo2U1dMdVJrZGV3dFlablhvWEl0bERza29lbFo2bGUwa2xRcW80c3hy?=
 =?utf-8?B?TXRNQ3VzMTcwVDJZOGQvYjltcDNsUFU1dzZGZ2swUGpOVEcydlFrbTV4UjRm?=
 =?utf-8?B?cVBZOHRSRWtpY0N1dVN6UGloNHhvWXJIWEZDTktMUUR5SnlRQVM0YWNlUHpH?=
 =?utf-8?B?cU5CcGhEbEVBcHdYNXpBdk4xbWpoc2djN3Z6ZEpOb0h2VG1NSU9qSjZmb3l3?=
 =?utf-8?B?Y29zc3crcUovcWdNT3pRd0RTcTJQOWt6UC9xS2NpcEppRnltaTlUL0owNFdT?=
 =?utf-8?B?NHRvNXlVNEthVmY0WXVhNHBjTTZHbStEczhKa2xkLy9EUjRMMjYySEtEWVVt?=
 =?utf-8?B?U2c3aGFTMDlwQ01Ed2RjQzMvMW5qQ2I0WldWekZWNnk5Q1JoZDF1a1V5Vlo4?=
 =?utf-8?B?Y1l3RGk4U29UdkdYVVBsYUxBaGtFN0pSZmJoaWlIblJzUnA5NXpZSW9mWU1I?=
 =?utf-8?B?L2RLWFBsalR1S3hEdDhkVzlMbHdtZWlaZlNHTFEySEVWN1lsTVdubkZjOHRW?=
 =?utf-8?Q?h3bH4f+45bDnru3IKblufw01W?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eabd5216-6801-47d6-9ee9-08de0afc3784
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 08:32:31.2422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHBbfYhNAZcORxV81ibf8woygKdIDaIhpD71kd20FG7v96UY0BBJCGvQfbQfj8wMB1bT8+CqOakN5KIGWUHkK9KqRnb/vSwQbdiiLUIZWP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8342
X-OriginatorOrg: intel.com

T24gVHVlLCBPY3QgMTQsIDIwMjUgYXQgMTI6MjcgQU0gUmFmYWVsIEouIFd5c29ja2kgPHJhZmFl
bEBrZXJuZWwub3JnPiB3cm90ZToNCj4NCj4gV2h5IGRvbid0IHlvdSBpbmNsdWRlIHRoZSBmdW5j
dGlvbiBzaWduYXR1cmUgYW5kIHN5bWJvbCBleHBvcnQgaW50byB0aGUgbWFjcm8/DQoNClRoYW5r
cyBmb3IgdGhlIHN1Z2dlc3Rpb24hLiBJIGhhdmUgc2VudCBhIHYyIHBhdGNoIGFzIHN1Z2dlc3Rl
ZC4NCg0KQlIsDQpLYXVzaGxlbmRyYQ0K

