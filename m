Return-Path: <linux-pm+bounces-35266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DC0B982C4
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 06:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654A77A8927
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 04:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CC62AD2F;
	Wed, 24 Sep 2025 04:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MeC+GSrb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C18F9C0
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758687314; cv=fail; b=WkObxUtVvYelT/yWOCK2CTkL2uHUWzJliJo0ytE9Lf42KfbDpRyUGIPQsJlTYSDfbZyUp30mjGnW3EbxESQO41QXAcOHUomdU+gN2qf5EtsgkJ56w7Gn3Mmd7CIJlx1EAh5VT0yq5KMtN2thM68tpIHhw4p9ozsZHCQqQ/pRIpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758687314; c=relaxed/simple;
	bh=TgPY+MnMF8nPRd03n80LtXeDkZZGqJ3zCRFkJTwEnYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S7LKvlZL4ST/RN/pgMz+K30PodmF/PDAFGhg+GqM5oN4JFPszYbCogRij7eVvlXFFGtgz+7L8OiiGOiweAS++rd+Kx7EHB7gwRe/pVkDOo55gvIqwO238deRs9SzaoOKLxmY0ieqc5Ft9Tg2ZkWZv/KWo6DTuVJOFZYhC4MJWYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MeC+GSrb; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758687313; x=1790223313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TgPY+MnMF8nPRd03n80LtXeDkZZGqJ3zCRFkJTwEnYU=;
  b=MeC+GSrbcRLb74ibO5HTYYeGaIT0YRimynkRr24LoBelFsbZ6x6ZYCy1
   Tetf9TAxcSDTfingLgy4QIBBNyNzzjGlFgclxNYO4Vs157jZivEmKt3sW
   EI+fM8JdRTWwZ/HRy1BuKMMw4YDRNIHWW2Ck6Vc0TOthXUEvs+DI6XtY0
   wXeLAGr2Y4LaR2WLT+0P5eMgSlGboIA8HR7FAaFvQ1Ve7rDfOGLzpF0s/
   zXTA4Dv4qk5H60wGt6lV8I4MSILryN4Z2FymnJ7PITxgA8Z4P5fKTgOj/
   lmpZ2TgV3fnb2MVEOrUf5T4DDPxVY89TJULJ1U6WYnBYgR3Jqeso7WT/l
   g==;
X-CSE-ConnectionGUID: tU72mvsuRBW8x+TFDpw45g==
X-CSE-MsgGUID: Asuzw3ldS0iUD5YwAmYHSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60017675"
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="60017675"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 21:15:12 -0700
X-CSE-ConnectionGUID: dp7iRrdXTs2GHVuVksBSug==
X-CSE-MsgGUID: 5HBhKI3AQomF3T81epXwIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="182199722"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 21:15:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 21:15:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 21:15:11 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.11) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 21:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKqyJvfKm3ilqf0mprrws0NXgAq76SseBN/xwBYHwSxV5KyMxr1fpw3siK6/Q7X8EhFwasIPJJ/mCF5XPxe+425f/N72g8fUzMfltM8qGQ9aaYT1cooSu8I34IWr+1ogwKbNM8qwPkmAt1oaCuqILnm1CFVvTtIayBrIfxp4R2/juyA0fWxHFR2jyOhBZapqAWQZ2YRbppyuTwtdD/KgoWNC9lkhD8T//V4F1rI3LeMkexkPM/YA+9K1KxjCkM4eQcDtkpOO32Ier2lpoai2/dYAoBZ2ibPp77vkVjXJgTSZPflplRzkbWzpknUP0zhObimxnqGch47/lde5WWz2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgPY+MnMF8nPRd03n80LtXeDkZZGqJ3zCRFkJTwEnYU=;
 b=Tfm95aOstqN4y7tViCKOW5p3z2k2cdXCbB7WwsWEu+ico2W6vuE8a8Pt30NyHZcYwRUFxlqWGUtrhEYvsOsUMo+4/lYwdcLtQxOGg7Knp5MWwf2Oru0lWdE6zGsG+nQetdJ6d7akVzXR8nOFwmXn/MjPupolucGuHetkfOX1pkgqwjuVRKs6JgSEbHoRwJKop8cTv+CQOPppEk/OJGZSjsIWlG7WHyRbLCV9Ot3vSZhWBuuO9Z4XP7PZrMd+PuXhbEs29TRPDt9CQ7c8ASEdR0RzLIs7m9oalaYbUFSDi7JtGv5HWyk7hFWTn9536Cwqzt+HM1V8QhTh8HLwstj+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by SA1PR11MB8524.namprd11.prod.outlook.com (2603:10b6:806:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 04:15:03 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 04:15:03 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "pavel@kernel.org" <pavel@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "dakr@kernel.org" <dakr@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] PM: Delete timer before removing wakeup source from list
Thread-Topic: [PATCH] PM: Delete timer before removing wakeup source from list
Thread-Index: AQHcK+j0aZNN1Fuc4E2edmZTAlGrq7SgMOgggACDIACAAQa60A==
Date: Wed, 24 Sep 2025 04:15:02 +0000
Message-ID: <LV3PR11MB87683634AEFDF44A845A9282F51CA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250921042537.3118333-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0joEhp9rt1WfN6eHfnuw_d2zrWFvd=Mn4NXRqO41xhsEQ@mail.gmail.com>
 <LV3PR11MB87682A511B8C0ED226C3BBDEF51DA@LV3PR11MB8768.namprd11.prod.outlook.com>
 <CAJZ5v0iMrq3uWBWZLkT0jf7ja9jzk1AdvUCM-tGgx+8zQQWPvQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iMrq3uWBWZLkT0jf7ja9jzk1AdvUCM-tGgx+8zQQWPvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|SA1PR11MB8524:EE_
x-ms-office365-filtering-correlation-id: 3ea5e2c0-3f2f-4b2b-9c6d-08ddfb20ef55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OTJhUFl3QXJYd0pNckFOV0hCUUVHa3dhL29ZREhad2daL3doTTR5aHQ4TUlm?=
 =?utf-8?B?S29KU2M0aEJ4ZmhGWFBBaEFUWUFrRXFlSVRpT0R2SnhKVHRleVU3ZkRBc0to?=
 =?utf-8?B?MUNkY0U0eS90R2k2N3NUdlhlVmE4Q25QYmFRY0NQcU5RY0NtQzJKbFVMWVFn?=
 =?utf-8?B?M3Q1QlMrZHVXM2tXSjNFYlZaa1hjRzlNNW1tTHhmc1h4RUZQejh0ZFJyOWUr?=
 =?utf-8?B?MkMzdkJibHpZT3pKM05vOC96ODVQbTczZGhGZFMwMVJVV3RSUlpjODl6UzdL?=
 =?utf-8?B?blNIZmFZSWtOS0FLVnhhV2lpN0pWcGFRM3VVRWpRRmVYR3NBZjhpMFlzSlph?=
 =?utf-8?B?SHY0MDN0YzljSUo3bEwweW56UlU1WVA1MlJtaFdCek0zS29LbHdNenlZN245?=
 =?utf-8?B?bWk0U256cCtTc0lVZitaUUFaLytiRDZnVW5XaVA4N01jMXp3RE9XTCttRFJK?=
 =?utf-8?B?cVJQL29jcVFnbGVzZTNRME1scGZJM2tFT1htLzVoV1ZUMlFLUEV5MmFjcldM?=
 =?utf-8?B?Mk9nU2I2a3ptNDRyQnc1YjY5bGVSTXdkUEowVzNHYWVLeVh0OUlwaXdFWjRH?=
 =?utf-8?B?a1B2Z1RuNmczMG1RMHhuZDBJQ2lHUnFldmZJSUFQZTc1NkRvc1lEUXFwQWwz?=
 =?utf-8?B?bkh5a253eHYrd0VSTkRselRjTy81QzJDaUEycjBWaTBtUDVNd080STNsbU1v?=
 =?utf-8?B?aVZpMzBwYjBFWEdmNXdqdHlHeW8zUjBSMk5YZFljajZtUWduQkFLSVV3Vzgz?=
 =?utf-8?B?MDZWbzVzZ1dacklzZnNEZy80cWo2b3lhVnlROTNmYURudFpIQUhRbmlVZGZV?=
 =?utf-8?B?UlhWdG5XZnAyV2xtSlFyQUNJTENSMCtla0U3RHVkM1k3TzBMaUw4QTMzUGht?=
 =?utf-8?B?RzlaTjE2WDBEQkpRdXVMdjcxVEJYWE1ieWdubCtPbkdRN2pwMS84ZWs4TWFo?=
 =?utf-8?B?VkpyNWpSUk82eWpPTnI0ZWV0TUt5VlhYL095WCsyZVhzcitQL0g1OFpscU52?=
 =?utf-8?B?V1JIT1RJVWZJYk00TW4wMFQwRUxCNTRMM1owZEdROFRsMTdnRDZMN0tKQjll?=
 =?utf-8?B?S1hGNXpCR1hFaWFEL2tzOW1YcFEzZ2VwN29DMDlvWm5DLzZ0TXdpcEE4N2g3?=
 =?utf-8?B?cmZ6cEN2SzB0VTNkM3drVDh4NFVyaUdDSFZXWHpSRGNTZWdYWWRSR0xOUnpn?=
 =?utf-8?B?b21lcVQxdkJrZ210SkVyVnJTU0dkTGx4QUxvVk82c1hnb0cxNWl3QWhpSGkw?=
 =?utf-8?B?aXNXVkU2azZ4WndyeFNmUUpVdGxKc0hEU1ltS09RMFJKZ3RhTWZXdzhtWklM?=
 =?utf-8?B?UHpDZlFKOTRoWFRBemZEUDduMTltbTFjR3VSMVUrL3ZBTit4anZiUnZ3b2VJ?=
 =?utf-8?B?SkJKb09yY0JMbFBRbWwzVjErdmtVbjAxZ0pJa1BIa2pNQjVGQ3dvc2t5T2NS?=
 =?utf-8?B?QUxkcVY2Z1lCRWovZDF4dithT0dtcUY4elkzRUxJR0RRYWR4MWZBLy9KM01M?=
 =?utf-8?B?MUwzN3RXU3BPN0FZYzZqQU9ad3JlcHFhZ01xcUZuYU55MEVSWWpDT0ZlcE5p?=
 =?utf-8?B?QnJPSitBM1dGcEJQaWJJeWVMLzdLZy9iQ1hEZ1ByMW4xbFhDOEpCSDI2ODB1?=
 =?utf-8?B?SEdGTE9mdlliN3FOTmE5N2Z5OXVhYWtwZ3Q2QmUwVm9KNi9uenpkT05UclEw?=
 =?utf-8?B?ckM5ank5REYyVE5OWWpKN2svTW5NVi9KTXd2NzFicldFVW1KcVpPRnZCNGRi?=
 =?utf-8?B?cmxuNjEzWGRpTVd0U2ZscVVMVjVGYUk2QTZhbTRPMjN3YzREN2k3L3dPb0xX?=
 =?utf-8?B?bzc5Z0xaVldBOGhMby9MaENPY1ArMXlmNjQ4c2tLSFlSZ2tZVWRnK1Vtbk50?=
 =?utf-8?B?V3E3QlJkVlRBUnFLYnpVTXJMbmpsTlQ1UzZ4c202bWdSREl6R1lBK0k5L1pJ?=
 =?utf-8?B?cW9mM2JsekpOSjBhbTdsUEtVY0lVNWl6QjBqVnAwdDNRSHcyNHdwRFN3Ymg5?=
 =?utf-8?Q?YFt1XH0kZtEjp7dC7nDYWIuc7o/2u0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDZ0R2F6MGUremoyYWpZRjhrSHQySHBwc29DYkxKOGcvVk5QVjJSczhIRHRq?=
 =?utf-8?B?dXYwS2hDWjYzd29ieG50WUFoNXR0czg5ODNIRTR3dyt6YllXTDU4aFdHNVU5?=
 =?utf-8?B?RnJyS3RselMrU2FQL3A5eHl3UTNZR2JBTTUyQStuejdjL0FFd2dVUmdIVFNx?=
 =?utf-8?B?RmwxZVovSGthY1FGMEVBVVpBdVFsNGxsVnAxcno1a2hoWTJWQTA2bmJuVUlv?=
 =?utf-8?B?MUxHSDJ3MUVEVjQrQ0FPR3cxdThaVnRobnFwYm1BUklDTGl0MEVGS1dySldX?=
 =?utf-8?B?WkRjMHozbVJkWUtSQm5OcHZNZUVqdTd0RlcwSDd6Y211bVpUdCtGQ0JOM21H?=
 =?utf-8?B?NVpaTE94dHV3RHFXejBjRmJpd3NwOE9UMzZ5Z1BXN1NPanhQbHlrWDJwbElK?=
 =?utf-8?B?ZVE5cnBjWkV0UHdqeTlMNUZOdTB4RklsNXdMeUcrU01XejVCclpOVENmU01P?=
 =?utf-8?B?K29pKzBKcHhJV3JYblJXUVNqeDFiOGZtVEtXOFNBVUxHYkYvdngyc3VVT0Yz?=
 =?utf-8?B?U09aQXNFNFQxL0ZmUXh6TmE4VDVNNklmc2NJNk1rT0pJcnliZW1aYmc4YUl0?=
 =?utf-8?B?SHFVdFlJZTNmeWtzUEZtOE9LbXdFbTlrdDhyUDFXS1EvdFliWk42cU9iNmpG?=
 =?utf-8?B?aW9Ea1MyYzNXaTJCU3hUWWdTTk5sNEtEUDZQOENlRVZVRUdBQnMrd09NM093?=
 =?utf-8?B?MUFnTG95ODBreWJDZnJhNnA3TURxTGwzWHI2Z0dGYklnNm9hRE5ML291V3Q4?=
 =?utf-8?B?UDdCYmlsajU0REx4RGp0MlhveDVnR0hWUTIxcWhESmNjNnhIMGF5a3RaeTFR?=
 =?utf-8?B?QXpEYUx1UFl1QUFaaGdXekF4T2E2ZlVVaEtaQk9kS0lNTU9iZUdJZmNiTEVM?=
 =?utf-8?B?WHZvRy9KbzRkK0Mwck1MRWF2aEszZTlIRGFmd3lKOWVjZXFDNnRWandRSjRE?=
 =?utf-8?B?Ulc3NUM1TDFYNVRMTmNCQVhLMVNCaDk2dmJPUXNGZmlmRkJhT2pjUU9HQ3pl?=
 =?utf-8?B?UDdkWDJxTmlGZEdqK0VPZnM1TGFpc1ByNXc0U21jQS93RGlOQnNXSldtZkVW?=
 =?utf-8?B?ZlBZbm9sRmdieG1mZTdjZ1oyaHhKd2NMalFzQ1doSERuU1ZhR1N2Y3p3QzVT?=
 =?utf-8?B?NWR5L2c3a1hsVlpKc3BGS21ZTTA5d2dvRHJmcXM4aDhhZDBWVHhRakRpNlEr?=
 =?utf-8?B?RVlNVmoremx0NzUrS1V3T1BjUjA3alFPc0x1MnpwRjFPK2RWZWdXRnZFNE9U?=
 =?utf-8?B?Tk9CYm1CcXRUQnp5cUFDYzlTQldhaXBMc0I5TGpzeHdEYUhPd0NlQ1oxcTVp?=
 =?utf-8?B?V2t6S1dpMWJ1dHlwaEUva1pBY09BTldLRGxRZXN1a0FPWkplVXF5eTVsOVVk?=
 =?utf-8?B?VzVibEdYeVBQRTloT0dmVkl4ejFSb1o4czVjd3cvOFUzeTdDSUNUUVBCdE8r?=
 =?utf-8?B?TzFjUThFamd5L1NPOGt2RmJCQVFodml5eFpwa1lFZndNQTBCMHhpMmlRRDJk?=
 =?utf-8?B?enVnbTZHNkx3Tm92eUk3TlNWcVdHY3pIalFIUFR2ZGxDYzI1cGR0UkVvVlp3?=
 =?utf-8?B?M1dDRG1uL1UvOW1YVXZ2b25VM2xMNlV5NEkxbkcxbzd5eEs5Y1RYZURPZVIy?=
 =?utf-8?B?NVhBbzBTN0Y2b2FjUkJYUUxiMjd0VTc3MWtSRitsV2FOWWdwZExYbSsvMWlt?=
 =?utf-8?B?elZVaENqUnoyM2JlUmxUU1ZSUVVNTjJ2dUxwN1RNMjdRSWxLMWdqSngwdGJL?=
 =?utf-8?B?cFAxb040L0hubGdNczY0ZWZNZ1pWY09lMkdHUEpVMlF5bXJONkNUQ241Z2tv?=
 =?utf-8?B?blBuK1Rpd3dwYWpVdVh0WkxQaC9SeE9yREZxc2phN0krZ1hnMWY5MzFrRk5V?=
 =?utf-8?B?cDY2RWt6QVZObVRob0FRcEtwcjkvbmsxaW1Vb21LRkR0cjZnVFVuYTZ6YVVp?=
 =?utf-8?B?UDZhb3JPcmsvQzIwTldHT3pnY1NkeXRmYTlyZ2RVZGFkcGRJd0Z5M202ZzJB?=
 =?utf-8?B?VmNyYUFnaUt6TXZFa3pwSG9rL3NhOFFXR290VzFQelQ1b0h1b25odENWQ1Np?=
 =?utf-8?B?N0JCT2lyUDdrZm1aRkpBZWdhNTZzNDY0Vms5L1l0VktaczFpdkVyeUlJSkd2?=
 =?utf-8?Q?QLH0rHjO5GhDbvxUApH6bkYRp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea5e2c0-3f2f-4b2b-9c6d-08ddfb20ef55
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 04:15:02.8874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMFASDTOnf3Nc33ZoWsSSSnI23vfqtWbHaRnprB1VAF2U6KA6zqGm1iGLPzU9Y3wqA7lU+ZmHr9zzQlnEQqNeB3eT/EU7RbNc3sn/pX1Vzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8524
X-OriginatorOrg: intel.com

T24gVHVlLCBTZXAgMjMsIDIwMjUgYXQgNjo1MiBBTSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6
DQo+IE9uIFR1ZSwgU2VwIDIzLCAyMDI1IGF0IDY6NTIgQU0gS3VtYXIsIEthdXNobGVuZHJhIDxr
YXVzaGxlbmRyYS5rdW1hckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gU3VuLCBTZXAg
MjEsIDIwMjUgYXQgNjoyNyBBTSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gPiBPbiBT
dW4sIFNlcCAyMSwgMjAyNSBhdCA2OjI3IEFNIEthdXNobGVuZHJhIEt1bWFyIDxrYXVzaGxlbmRy
YS5rdW1hckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBNb3ZlIHRpbWVyX2Rl
bGV0ZV9zeW5jKCkgYmVmb3JlIGxpc3RfZGVsX3JjdSgpIGluDQo+ID4gPiA+IHdha2V1cF9zb3Vy
Y2VfcmVtb3ZlKCkgdG8gZW5zdXJlIHByb3BlciBjbGVhbnVwIG9yZGVyaW5nLiBUaGlzIA0KPiA+
ID4gPiBwcmV2ZW50cyB0aGUgdGltZXIgY2FsbGJhY2sgZnJvbSBleGVjdXRpbmcgYWZ0ZXIgdGhl
IHdha2V1cCBzb3VyY2UgaGFzIGJlZW4gcmVtb3ZlZCBmcm9tIHRoZSBldmVudHMgbGlzdC4NCj4g
PiA+ID4NCj4gPiA+ID4gVGhlIHByZXZpb3VzIG9yZGVyIGNvdWxkIGFsbG93IHRoZSB0aW1lciBj
YWxsYmFjayB0byBhY2Nlc3MgdGhlIA0KPiA+ID4gPiB3YWtldXAgc291cmNlIGVudHJ5IGFmdGVy
IHJlbW92YWwgYnV0IGJlZm9yZSB0aW1lciBkZWxldGlvbiwgDQo+ID4gPiA+IHBvdGVudGlhbGx5
IGNhdXNpbmcgdXNlLWFmdGVyLWZyZWUgaXNzdWVzIG9yIGxpc3QgY29ycnVwdGlvbi4NCj4gPiA+
DQo+ID4gPiBIb3cgc28/ICBZb3UgbmVlZCB0byBzcGVjaWZ5IHRoZSBzY2VuYXJpbyBpbiB3aGlj
aCB0aGF0IGNhbiBoYXBwZW4uDQo+ID4NCj4gPiBIaSBSYWZhZWwsDQo+ID4NCj4gPiBUaGFuayB5
b3UgZm9yIGFza2luZyBmb3IgY2xhcmlmaWNhdGlvbi4gSGVyZSdzIHRoZSBzcGVjaWZpYyBzY2Vu
YXJpbyANCj4gPiB3aGVyZSB0aGUgaXQgY2FuIG9jY3VyOg0KPiA+DQo+ID4gKipJc3N1ZSBDb25k
aXRpb24gVGltZWxpbmU6KioNCj4gPg0KPiA+IDEuICoqVGhyZWFkIEEqKiBjYWxscyB3YWtldXBf
c291cmNlX3JlbW92ZSgpOg0KPiA+DQo+ID4gcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZldmVudHNf
bG9jaywgZmxhZ3MpOyBsaXN0X2RlbF9yY3UoJndzLT5lbnRyeSk7IC8vIFJlbW92ZSBmcm9tIGV2
ZW50cyBsaXN0IHJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKCZldmVudHNfbG9jaywgZmxhZ3Mp
OyBzeW5jaHJvbml6ZV9zcmN1KCZ3YWtldXBfc3JjdSk7IC8vIFdhaXQgZm9yIFJDVSByZWFkZXJz
IC8vICoqKiBJU1NVRSBXSU5ET1cgSEVSRSAqKiogdGltZXJfZGVsZXRlX3N5bmMoJndzLT50aW1l
cik7IC8vIFRpbWVyIHN0aWxsIGFjdGl2ZSENCj4gPg0KPiA+IDIuICoqVGhyZWFkIEIqKiAodGlt
ZXIgY2FsbGJhY2spIGZpcmVzIGR1cmluZyB0aGUgaXNzdWUgd2luZG93Og0KPiA+DQo+ID4gc3Rh
dGljIHZvaWQgcG1fd2FrZXVwX3RpbWVyX2ZuKHN0cnVjdCB0aW1lcl9saXN0ICp0KSB7IHN0cnVj
dCANCj4gPiB3YWtldXBfc291cmNlICp3cyA9IGZyb21fdGltZXIod3MsIHQsIHRpbWVyKTsgLy8g
UHJvYmxlbTogd3MtPmVudHJ5IHdhcyBhbHJlYWR5IHJlbW92ZWQgZnJvbSBldmVudHMgbGlzdA0K
PiA+ICAgIC8vIGJ1dCB0aW1lciBjYWxsYmFjayBzdGlsbCBleGVjdXRlcw0KPiANCj4gV2h5IGlz
IHRoaXMgYSBwcm9ibGVtPyAgd3MgaXMgc3RpbGwgdGhlcmUgYW5kIHRoZSB0aW1lciBjYWxsYmFj
ayBkb2Vzbid0IGRvIGFueXRoaW5nIHdpdGggd3MtPmVudHJ5IEFGQUlDUy4NCj4gDQo+ID4gKipT
cGVjaWZpYyBJc3N1ZXM6KioNCj4gPg0KPiA+ICoqVGltZXIgYWNjZXNzZXMgcmVtb3ZlZCB3YWtl
dXBfc291cmNlKio6IFRoZSB0aW1lciBjYWxsYmFjaw0KPiA+IChwbV93YWtldXBfdGltZXJfZm4p
IGNhbiBleGVjdXRlIGFmdGVyIGxpc3RfZGVsX3JjdSgpIGJ1dCBiZWZvcmUgDQo+ID4gdGltZXJf
ZGVsZXRlX3N5bmMoKSwgYWNjZXNzaW5nIGEgd2FrZXVwX3NvdXJjZSB0aGF0J3Mgbm8gbG9uZ2Vy
IGluIHRoZSANCj4gPiBldmVudHMgbGlzdC4NCj4gDQo+IEFnYWluLCB3aHkgaXMgdGhpcyBhIHBy
b2JsZW0/DQo+IA0KPiA+ICoqV2h5IG1vdmluZyB0aW1lcl9kZWxldGVfc3luYygpIGZpcnN0IGZp
eGVzIHRoaXM6KioNCj4gPg0KPiA+IC0gRW5zdXJlcyB0aW1lciBjYW5ub3QgZmlyZSBkdXJpbmcg
bGlzdCByZW1vdmFsDQo+ID4gLSBHdWFyYW50ZWVzIG5vIHRpbWVyIGNhbGxiYWNrcyBleGVjdXRl
IGFmdGVyIHdlIHN0YXJ0IGNsZWFudXANCj4gPg0KPiA+IFRoZSBmaXggZW5zdXJlcyB0aGF0IG9u
Y2Ugd2Ugc3RhcnQgd2FrZXVwX3NvdXJjZV9yZW1vdmUoKSwgbm8gdGltZXIgDQo+ID4gY2FsbGJh
Y2tzIGNhbiBleGVjdXRlDQo+IA0KPiBZb3UgbWF5IGFyZ3VlIHRoYXQgdGhlIG5ldyBjb2RlIHdp
bGwgYmUgY2xlYW5lciAoZmFpciBlbm91Z2gpLCBidXQgdW5sZXNzIHRoZXJlIGlzIGEgc3BlY2lm
aWMgY29ycmVjdG5lc3MgbWF0dGVyIGhlcmUsIHlvdSBjYW4ndCBjYWxsIGl0IGEgZml4Lg0KDQpI
aSBSYWZhZWwsDQoNCllvdSdyZSBhYnNvbHV0ZWx5IGNvcnJlY3QsIEkgZG9uJ3QgaGF2ZSBhbnkg
ZXZpZGVuY2UgaW4gcmVhbCB1c2UgY2FzZXMgZm9yIHRoaXMuIEdpdmVuIHlvdXIgZmVlZGJhY2ss
IEkgc2hvdWxkIA0KUmVmcmFtZSBpdCBhcyBhIGNsZWFudXAvaW1wcm92ZW1lbnQgcGF0Y2ggcmF0
aGVyIHRoYW4gYSAiZml4Ig0KDQpJZiBpdCBpcyBmaW5lIHdpdGggeW91IHRoZW4gSSBjYW4gY3Jl
YXRlIHYyIHBhdGNoIHdpdGggeW91ciBzdWdnZXN0aW9ucy4NCg0KQmVzdCByZWdhcmRzLA0KS2F1
c2hsZW5kcmENCg==

