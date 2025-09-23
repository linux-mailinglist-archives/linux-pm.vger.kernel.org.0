Return-Path: <linux-pm+bounces-35194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C28B9441F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 06:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B32B481860
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 04:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D0930CDAA;
	Tue, 23 Sep 2025 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8PFTwfR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2F625A63D
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758603164; cv=fail; b=FjRlvIVn3mZsaUDeoiw+u+d/tLYrx6b52OcHpm+Co4k+Dh8PLykrasB3VHDyr4pURwnrZEdfHj3HkObdZTicnEslmPh205yV07O3zYX9dpftTXE42NBRyYdPPU5FEAEOnzs7fZGkoYCI2RM6SK1kIBoJj51UBj56J/IJG6zMQeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758603164; c=relaxed/simple;
	bh=BPoPQ0zMHYP86yzucsciTPuMU3o3pZtoXn6GqhdkqZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W4U5hY9VKTJEHuL0LO8hfu9FgpaoDwXrTzuii4t4IXb4NI1y9BeQc0oAtqtjUoddsgyLn++gvPZEdpmeTWnacLJG7DqCWh5YpN/u8GAOPFOge84gMR9lBf0j/Nia+15bXUoZQD2hnbYJGld1b5Vm7RAOWMMaIdIciNYsHPNdUhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8PFTwfR; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758603162; x=1790139162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BPoPQ0zMHYP86yzucsciTPuMU3o3pZtoXn6GqhdkqZg=;
  b=e8PFTwfRCWDdjMk246efFoQfpL+fFQhyNY7raUX2u5FGAQeBIvLG8NGU
   tnxTkIm4KFqbWbXhxZSEWSh/e8qAVR1nHkDsfnDIfVo6JY73TLyP1pk5Y
   zSFVrYBCav4wBZbgKGZBgcWGULOUCZ2MhddORk3bVabZYauH27aHtTij7
   DK+8UfUHHXt57bJqEjsJ9sSt4NYjDvP5mO2A0QZelVRc5mWWgmDeGB9WX
   MHYavr3UOsBgruLg96KcuRhm4N5W6Rj3CGnig/V/WTYye4CpC1yOVKbPp
   FEnRAsRx4s1hK8KTcjrEYUtOsESaCnDs8Sa2oC8i7bqw7PLSY8dbszobs
   Q==;
X-CSE-ConnectionGUID: WOGlHz21SaaFJLH52RlgEQ==
X-CSE-MsgGUID: sN2gR/91RhWZq/7YZC6x8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71496463"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="71496463"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 21:52:42 -0700
X-CSE-ConnectionGUID: QgGXRRxZRdyY9iETAFGDmA==
X-CSE-MsgGUID: rWmiHiXaSUSu80iVj86WqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="176594658"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 21:52:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 21:52:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 21:52:40 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 21:52:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkXcVnl6bOkaY/vtNjPh67Ni6cBMMYUvpcZggPX2j8sS0beTMdc6ge180kpoDt/nJHqVQW60zTVq49CCq29Nny8z+hOnwFwEXhbYpNMXARZWXzHgLwnBqP1ECmXmD4+AMGaV/7lhfL86DfqnDtGa2d9+mK5hczTgyDU5UlbL81WdQMby0z9NU0a6zCIVVNJbgGtSoREFezei7OQSn2K/RHLvtqN311wEPxaVe4f7T0nCBmpNADyqF3vUtRa/h1apw2t752K7EEG9TWE8TGaZ5oIOEOv5Uo+fOILO5SaZBQELzbiDlqSk41K9LcSmePoMjUt5PHm2qClZy2LqsyuU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPoPQ0zMHYP86yzucsciTPuMU3o3pZtoXn6GqhdkqZg=;
 b=gI7a+OWhEGITsgMhX9BDIC3URYvjdqy9h13HPcGYVu6ndtUNUu+C27ZnGxGTSuX/Mfcx0RJNm9kU+4zLD8IQ4Xh2ekiYdG7cjbHydJTswh3FVBSo6Y4FGaxcg8z8eoODzdH6skyTsWh8rrksKyRE2Zzd8y23w3F93xCqFb8+D6axhUb041YaZ61/vYDS8IyaKaicU+IfOM7pN/lxox8763gd51NFjpSYLdLow9+BTJy04rBjR5o0lc4Svz2j9pYKh3bhtl8xXbIaCWPb7rJPM6OOhleRaBq6VoAWha3+LeQDvJH54qvCWuMWcz+fd1mWce3N3ShRt/EvLBCvFrm7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by SA1PR11MB8811.namprd11.prod.outlook.com (2603:10b6:806:467::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 04:52:37 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 04:52:37 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "pavel@kernel.org" <pavel@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "dakr@kernel.org" <dakr@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] PM: Delete timer before removing wakeup source from list
Thread-Topic: [PATCH] PM: Delete timer before removing wakeup source from list
Thread-Index: AQHcK+j0aZNN1Fuc4E2edmZTAlGrq7SgMOgg
Date: Tue, 23 Sep 2025 04:52:37 +0000
Message-ID: <LV3PR11MB87682A511B8C0ED226C3BBDEF51DA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250921042537.3118333-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0joEhp9rt1WfN6eHfnuw_d2zrWFvd=Mn4NXRqO41xhsEQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0joEhp9rt1WfN6eHfnuw_d2zrWFvd=Mn4NXRqO41xhsEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|SA1PR11MB8811:EE_
x-ms-office365-filtering-correlation-id: 13a756f7-d10c-44f1-4ebd-08ddfa5d0480
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UndvYUlOLzVhTHZ2UFAwVjVEK3o4bm5sTFowNmg0aFluR2JiUUo2LzZIVms4?=
 =?utf-8?B?TVRmVXc4R1g5N05ka1RGZklmQnNDcDhCQ1ZPa1VjdVRScW11cDhMQlhuc0RT?=
 =?utf-8?B?d2s1MDdITFV0TW5rZVorV2hibGhLR1NlMEFicEtKRzV2VnI5TDFCdGN1clNS?=
 =?utf-8?B?ZW1ybmlpY0NTUVVGNnBIdlhUbzI0bWZwRE96aW9Wd09TcGs2d2JFT3BGc1pm?=
 =?utf-8?B?VDA1bjNpVUsyekNQZXZ4ek1UdVlwSktOK1ZsYURuRHlzcnVoVUt4SFFNZVJX?=
 =?utf-8?B?cFBQRlpRMFBFVW03TmppNW0zMnFCS2loRmZTWVR3OVRwV0hwVXc3NzE2VWdX?=
 =?utf-8?B?bFZuTTMvWlBnYWNjNVAxc0FWa05yb3RvKzlOVVZmRHl3c0ozRTlXazVYbWVR?=
 =?utf-8?B?cytZVVdiellac2pib2p0cXBla3l1em5TK1JVZWkzMlhLQXN6anVvbjRySlM5?=
 =?utf-8?B?Y0h4bXNXQkt5d1hiY0ZFTUZqcktiNUxmOFR5cEV2Q0NpK2VSVnBhcTVBclNL?=
 =?utf-8?B?Z0w3bzJqTUJ4bVNuVXgvL1lDZXdHakhxbTlwbnFEN1BWRzdJK014U0YxQlBw?=
 =?utf-8?B?V0JDV1VCeG9RUW9BU0oxZjdud09abHJ1V2xYYmZSV2g2YURmNmMzUU9ydXFH?=
 =?utf-8?B?bGxKUTdrZW0zdlZFckNGVkVWNVdPY1FORlc3UDJsTkttY0Jid056cHduT1Jt?=
 =?utf-8?B?MTh0Ui8rZkN5U0tQUy9SMFhUY1I5WlYzRlliRGo2TFp4U3RaZG1jUmlDOTNz?=
 =?utf-8?B?V1o3bU13YnBUTkNsUndpWU5tRzAzb0ZpeXUxeG5lcXZpU2kvNXQ3b1N0T0Z3?=
 =?utf-8?B?dG1yaHZwcTAvb0ltYjAwckJpTmxiZzdTNjEvZ1BGOCtEMmRFNllaQmNpN1U2?=
 =?utf-8?B?T2tZWnZNbThVaDU0OG1GZ3FoYnVqa2UwR29jcmZYOFZ4Qm8vTVFKL3RKTXpO?=
 =?utf-8?B?Qlp4OTV4ejg3dmZIM1NjOWpJT0tRbStrMVZMT2JUTW9KaURINUx1eWdldWQv?=
 =?utf-8?B?RDZuMWJ3RFNlamljVm5xd21EdGJBci91ZnROLzhJNWlseEw5a2R0b3RKL05E?=
 =?utf-8?B?SGZKRHZoSERGcktXVmU5b3hKZHdRNnNGeUtaUGNvR1RmZHk5aFhtcy92N3BJ?=
 =?utf-8?B?R1ppUzBmUXNkTHZjbHFYODBDTGd3czRFUGpXWUFJa24rQStjbmlUT2k1Qy9H?=
 =?utf-8?B?c09ZWkVObHMxcjVkcFFWaHdkTlFNWTR4N3RveXh1eVFFT09qdXFLL3Jqbk1p?=
 =?utf-8?B?ZVZZd2JmNnp2b090OVQ4cTVwSXJkNHN1aDRnczVXeE9KY0FCeGFxS2lhZFlW?=
 =?utf-8?B?anN4YzFjUm9QV2RkL1dzUXhJV1RyeHFUTGZ6bXJsMmd2TEpuM2Q0L1Z4Zjky?=
 =?utf-8?B?QklncnlyeEk4V0dZNjdDZS9ETkFOcXZQWk1KWE5aOE1FTzBYK0UveWU2TFBX?=
 =?utf-8?B?Y1dYdVVPMGMyVFQ1NFlUWHBlMndIVGhVanRZdlo1R0M1WkFWYzAwSjRDQW9K?=
 =?utf-8?B?QmNyaWRXVlhzdkg4SXVScUxOK2Z5RGtWK29nWFNrbGIxMnRXcVQxN0VHNHNI?=
 =?utf-8?B?a3kzTzNpOFZqa0kwSkdKN3RXODlMUVBCSFcyTitDR0R5MThqdUZXVHZHM1U4?=
 =?utf-8?B?RzZEYkZ1STQrQ3ZkOUVDZksyUGpNdjZKSk5pZTJvT0FPTWpzcG4vUHBWR3BL?=
 =?utf-8?B?MEw5Znp3b01pZlFjempYQTNSYW5GUXlmbVZ0RmMrNk9iSTlmR1ptTXBCTldv?=
 =?utf-8?B?WG5IZUd6VnJYYzVjTEZxQXpzR00yT3BoaUE2L1UzbXBTMndEVHVLTitBalRB?=
 =?utf-8?B?YmpSdktoUFdxb2Z3RWNnNk5VL1lvd3liaVR3UGNJOGlKb1pseFdhZFNXNUVp?=
 =?utf-8?B?UDM4YTUvcWdXb2syT1BONkFoQ1pqZzgzUmFTbXBaOXhaQ2l2NUxFdE9hNWpQ?=
 =?utf-8?B?THE5L29ZQU5FMzQ5bzZBa2dUd29oSlI4cXdnd243bE93b0liejhNdm9NU2pK?=
 =?utf-8?Q?Wv6iiNCGTspAjWxymxulffLSLf0AkM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjdJTFEyK3J2QzRPSTRnQU8yanZsUzBDdjluRUJJb1JrcWZCVmJMdmJlZFFy?=
 =?utf-8?B?VzVxdVFmL01jOVRVV1g3ZTJqUERsU0srY1lJbyt6K0p1ajdWYUVzemJiaFlL?=
 =?utf-8?B?Q3cxOUVPaVZKVkVadS9wRStmVnNOaGJuWWU4cTZCZS8xUit1ci9vYXJTMWFN?=
 =?utf-8?B?TlFSNDN3RmJ5T2VUNXNlUWR5ZSsyUytTWVdGa0N5R1VaTlVQdWk2U1JJUGRI?=
 =?utf-8?B?Z3U4aXBuWDMwYkU3MGZTOTRtMDAzUUJreGltTEJJaUZqTi9BbldLL0Y5MjBJ?=
 =?utf-8?B?ZlIwZS9pSVJxMDQzZlRBb2JFWS9pd2xvTlFsSi9zVDNFbVJ5RW56T29EUWt2?=
 =?utf-8?B?ZDA1a2NsVGVJZjc4VU5HYjZmZEhzUkFDR3NGOVdWbnRTL05yY09GaDMvK3FG?=
 =?utf-8?B?N1BJUE0zZGdCRXc5bHdKeTZSUVM4SGVwK1BTVU96ZEUrTENrbXVCVGVNZ2wy?=
 =?utf-8?B?VGdjenJlZnlybG5VZ056aHZ3R2ZSbktaL2Q5aDlpN1NHaFgvekZpTHdlR0pr?=
 =?utf-8?B?a0VEV1BocUJldTJPckd1ZUdaR0JpeGVzQ0x3RmptQXZ4T2JqK1UvUHBlMWRm?=
 =?utf-8?B?TGsxTGN1VXVrMlhEa1p6VHdPMW9QQkdEcS9QZlB4UHIrU2FBdHRnNitMY3Zy?=
 =?utf-8?B?UG4xa3pUK3JCZkU1WXZjQTdCL1pqaEtGQ0RLTklFTUhMRFRhYlM4RVV2VEwy?=
 =?utf-8?B?OFltWGxTbHg1OUxIZUEvWmlMMVRlZW9wNkIza2VqODRvTDAxVkVFS0k5SlVT?=
 =?utf-8?B?dG8xczBKQ0h0MlkxZzQ4NEkwVndiTVRyV3NXVmhiVHZhTTVaem1XcVJNZ2hy?=
 =?utf-8?B?ZjRscGNHS1lWRWtFcC9ia1kwbmNJNHFUUVozcHppRjFPa1dYMWpTbm1LTmxM?=
 =?utf-8?B?Lzl2MFN4QkdzbjZrSTlVc0dyaUdMdnY0alB5RGtnZEJqWlAxSCtPeklEYkxy?=
 =?utf-8?B?dklmK3A4RExmQnhSU0RvNFo4aktZSjFHMVQ5UXJKdFRKQVVCN1dHZDRWMElW?=
 =?utf-8?B?Ymp3alFWRW5CWUNscGMwODVjNkduaEo4aFI1V0JjVTRSdjJYeGt0R3RsK3Bk?=
 =?utf-8?B?Nks2MGh0cWNhaWRaQXE5SWUrMkFZbTVhQnd3VjdxUnJXWUxxcTVNdHFyTTJN?=
 =?utf-8?B?dkdsS3RLVmkyUkdoK28yOUxNODVOUXNPWGVSMHVxOVo2QWJrbC9wMEFDMXlp?=
 =?utf-8?B?SWF1SmpOb2RQSWo4RXFoY3h6M2krQnJWK2xqbGhPNnNFSjlFeThUejFBWStK?=
 =?utf-8?B?V1BWVlliUGVUVXRFeUxKZUZnZGs4blk3WVhidmhMbW92ZEZLcTVTZ2kzOUZj?=
 =?utf-8?B?RzVNY1U4SlliZGZGZnY4TWdxRVlYbWZHbzUxNVNzUmhVMjExdjFTRXpBREJv?=
 =?utf-8?B?ak9LSVFSSDR0Z0pXTkpwRzA5b3BXLzVBbWFoNWlvR2Nxd21GL2dGb1FPRWdJ?=
 =?utf-8?B?cVM3ZnRNbzZNOUNjYUxzQlZ4QWFPemY1d1czOTBmNDRwalJMSWdqanUrajFr?=
 =?utf-8?B?bi9VclBxd0xIaHNOTDR5dDRxbTBUQnFhMGJnWXJEamhvYzRZckNiWTU0MGVO?=
 =?utf-8?B?dGxNak9WQTV2MWc4bVhNOEU4UzB0TWxCY1BPL1pRQVNGTzFydDNRY0UzY1h0?=
 =?utf-8?B?ZVY1QW9FSHJCYTV6cVJhRTFsbjV3bk1oWEluKzhUV2ptMUdJREF0RklpWHBw?=
 =?utf-8?B?bUVQVDBpaU9pS0xvdE1reHNsdWNKdCtkSzFGOEI1bHpQeWdxY0RmYjhmODZi?=
 =?utf-8?B?V0s2T3lubzBGc3FkcVNxTXlFdXB5QjFuSTRtN2tRQkwzNi93STdFUFE3OHpt?=
 =?utf-8?B?QnJPckZTaFRaKzQyZktHeXR3dEJ3OHNTbXF0bVVwU2VPRWNULzRPNzFkbDhr?=
 =?utf-8?B?Z3F0cmFYMGZ5TTZFaXdkVEdkQmk4bHo2cy82Tk5JcWhFc09oU3J3RHJPamZh?=
 =?utf-8?B?WSs2RWFzbkNXSEU3TWJ3cTVGR29wODM0elZxT25naG8vWGYrS0NwTjlJODB6?=
 =?utf-8?B?Y0FQVnNybkNZSDB0M0R1bzdZRmk5a3Z2cnY5UWRQMytMRmdMYXhNbmRJc09z?=
 =?utf-8?B?TWtwdkxaamJQQlNlaHMvMHk4WlZiTlc1RStlT0l5V1ZyOXJvWkRReWR5eUg1?=
 =?utf-8?Q?RQ+toy9xAqbYISqcoyHBX/JJ2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a756f7-d10c-44f1-4ebd-08ddfa5d0480
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 04:52:37.0712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vAmR04mvYxCL3IAY8CZ8lsxiQbonCdSZpwpdT+jIhLyZYIXBW6l0gjIZT5LbfbVeFPUXU+FHU+m1q0rhd21BOjjIQ12J0RsLJ7v3oI8Ov8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8811
X-OriginatorOrg: intel.com

T24gU3VuLCBTZXAgMjEsIDIwMjUgYXQgNjoyNyBBTSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6
DQo+IE9uIFN1biwgU2VwIDIxLCAyMDI1IGF0IDY6MjcgQU0gS2F1c2hsZW5kcmEgS3VtYXIgPGth
dXNobGVuZHJhLmt1bWFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBNb3ZlIHRpbWVyX2Rl
bGV0ZV9zeW5jKCkgYmVmb3JlIGxpc3RfZGVsX3JjdSgpIGluIA0KPiA+IHdha2V1cF9zb3VyY2Vf
cmVtb3ZlKCkgdG8gZW5zdXJlIHByb3BlciBjbGVhbnVwIG9yZGVyaW5nLiBUaGlzIA0KPiA+IHBy
ZXZlbnRzIHRoZSB0aW1lciBjYWxsYmFjayBmcm9tIGV4ZWN1dGluZyBhZnRlciB0aGUgd2FrZXVw
IHNvdXJjZSBoYXMgYmVlbiByZW1vdmVkIGZyb20gdGhlIGV2ZW50cyBsaXN0Lg0KPiA+DQo+ID4g
VGhlIHByZXZpb3VzIG9yZGVyIGNvdWxkIGFsbG93IHRoZSB0aW1lciBjYWxsYmFjayB0byBhY2Nl
c3MgdGhlIHdha2V1cCANCj4gPiBzb3VyY2UgZW50cnkgYWZ0ZXIgcmVtb3ZhbCBidXQgYmVmb3Jl
IHRpbWVyIGRlbGV0aW9uLCBwb3RlbnRpYWxseSANCj4gPiBjYXVzaW5nIHVzZS1hZnRlci1mcmVl
IGlzc3VlcyBvciBsaXN0IGNvcnJ1cHRpb24uDQo+IA0KPiBIb3cgc28/ICBZb3UgbmVlZCB0byBz
cGVjaWZ5IHRoZSBzY2VuYXJpbyBpbiB3aGljaCB0aGF0IGNhbiBoYXBwZW4uDQoNCkhpIFJhZmFl
bCwNCg0KVGhhbmsgeW91IGZvciBhc2tpbmcgZm9yIGNsYXJpZmljYXRpb24uIEhlcmUncyB0aGUg
c3BlY2lmaWMgc2NlbmFyaW8gd2hlcmUgdGhlIA0KaXQgY2FuIG9jY3VyOg0KDQoqKklzc3VlIENv
bmRpdGlvbiBUaW1lbGluZToqKg0KDQoxLiAqKlRocmVhZCBBKiogY2FsbHMgd2FrZXVwX3NvdXJj
ZV9yZW1vdmUoKToNCg0KcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZldmVudHNfbG9jaywgZmxhZ3Mp
OyBsaXN0X2RlbF9yY3UoJndzLT5lbnRyeSk7IC8vIFJlbW92ZSBmcm9tIGV2ZW50cyBsaXN0IHJh
d19zcGluX3VubG9ja19pcnFyZXN0b3JlKCZldmVudHNfbG9jaywgZmxhZ3MpOyBzeW5jaHJvbml6
ZV9zcmN1KCZ3YWtldXBfc3JjdSk7IC8vIFdhaXQgZm9yIFJDVSByZWFkZXJzIC8vICoqKiBJU1NV
RSBXSU5ET1cgSEVSRSAqKiogdGltZXJfZGVsZXRlX3N5bmMoJndzLT50aW1lcik7IC8vIFRpbWVy
IHN0aWxsIGFjdGl2ZSENCg0KMi4gKipUaHJlYWQgQioqICh0aW1lciBjYWxsYmFjaykgZmlyZXMg
ZHVyaW5nIHRoZSBpc3N1ZSB3aW5kb3c6DQoNCnN0YXRpYyB2b2lkIHBtX3dha2V1cF90aW1lcl9m
bihzdHJ1Y3QgdGltZXJfbGlzdCAqdCkgeyBzdHJ1Y3Qgd2FrZXVwX3NvdXJjZSAqd3MgPSBmcm9t
X3RpbWVyKHdzLCB0LCB0aW1lcik7DQovLyBQcm9ibGVtOiB3cy0+ZW50cnkgd2FzIGFscmVhZHkg
cmVtb3ZlZCBmcm9tIGV2ZW50cyBsaXN0DQogICAvLyBidXQgdGltZXIgY2FsbGJhY2sgc3RpbGwg
ZXhlY3V0ZXMNCg0KKipTcGVjaWZpYyBJc3N1ZXM6KioNCg0KKipUaW1lciBhY2Nlc3NlcyByZW1v
dmVkIHdha2V1cF9zb3VyY2UqKjogVGhlIHRpbWVyIGNhbGxiYWNrIA0KKHBtX3dha2V1cF90aW1l
cl9mbikgY2FuIGV4ZWN1dGUgYWZ0ZXIgbGlzdF9kZWxfcmN1KCkgYnV0IGJlZm9yZSANCnRpbWVy
X2RlbGV0ZV9zeW5jKCksIGFjY2Vzc2luZyBhIHdha2V1cF9zb3VyY2UgdGhhdCdzIG5vIGxvbmdl
ciBpbiANCnRoZSBldmVudHMgbGlzdC4NCg0KKipXaHkgbW92aW5nIHRpbWVyX2RlbGV0ZV9zeW5j
KCkgZmlyc3QgZml4ZXMgdGhpczoqKg0KDQotIEVuc3VyZXMgdGltZXIgY2Fubm90IGZpcmUgZHVy
aW5nIGxpc3QgcmVtb3ZhbA0KLSBHdWFyYW50ZWVzIG5vIHRpbWVyIGNhbGxiYWNrcyBleGVjdXRl
IGFmdGVyIHdlIHN0YXJ0IGNsZWFudXANCg0KVGhlIGZpeCBlbnN1cmVzIHRoYXQgb25jZSB3ZSBz
dGFydCB3YWtldXBfc291cmNlX3JlbW92ZSgpLCBubyB0aW1lciANCmNhbGxiYWNrcyBjYW4gZXhl
Y3V0ZQ0K

