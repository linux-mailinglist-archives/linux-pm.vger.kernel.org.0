Return-Path: <linux-pm+bounces-38539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC9C84342
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 10:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E438D34D2DF
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 09:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B63254AFF;
	Tue, 25 Nov 2025 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvARWEye"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09117269B1C
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764062615; cv=fail; b=CiMyzYzFt2d6iNs96uqzs0iw/st4jMTN84Z3J87rYUe26OsdmpkIQuYEqoBHHKLw/ZumAwvfloFpfnQc/BNJRhbmsdD23Tb8iPAKvvykgO04tA9yoDQFlNU+G7/9E+mUp/Im2f7AsjRNJG/+ttKTQqn/I4C2a0b08lfI7jhaW74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764062615; c=relaxed/simple;
	bh=nHz2EFImucIiwTqp66QbPeD882RRydXcKo1HNiN9uAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gWJfZpzvXUkvEc3tvv/Z/VMKMdTbYMwK58SRupRmGG707zZAG1WgfRoYMXYyiZ1naNoRNGbPkmgjrQeqUCDnrBVsD2LGpo/xZf9acUUqyCITYDSQMzOrvBIqf3fa7cOoIdm8nOdvTWVI2QCMkryY2JS+p8v1E5uRX+jBw7L6HLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvARWEye; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764062614; x=1795598614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nHz2EFImucIiwTqp66QbPeD882RRydXcKo1HNiN9uAg=;
  b=NvARWEyeXa1VbEWxrCQV62qhiFp3BUQSeNKp6hD1413NPUcbF2XwIx8Z
   tWxic1SttuEQ9yUlbtmbZ9w0W61nFpoRT4ysE6qXmjaFacDAx9+l4HsoI
   /9Kdl62UF635rw0tnODak5M3j/xxand2LjwLrcIeUI6CqRGqmayehz596
   MeF2boQJFKJQp8ttPFP0+tqCyU6QO2l2nX8sFWIHpzhIGe0mQgBXshgwV
   DUzaO5/8XhMBvS+sSYaBXM3ca9BKX5+daPo3dX3hhdd3RtNHWpZZLqM+V
   +F/7B4T7H4EENjSNg7QLapL+QAG2O+YZj+V1JLGBcl7fnGKid41Kz0+Jz
   g==;
X-CSE-ConnectionGUID: MqirSPuwQUGJsgG4c/LUEA==
X-CSE-MsgGUID: b5oRiTLbQM2bFO0NqV31eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65781598"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="65781598"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 01:23:33 -0800
X-CSE-ConnectionGUID: uAfzwqxpSaGw5V07qiISxA==
X-CSE-MsgGUID: h3IuUcXXTYeGfqZltKjhUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="192469776"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 01:23:33 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 01:23:32 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 01:23:32 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 01:23:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqXgVeqNeWyLA8NQLeGnOMuYrrTqRA45zID0ERyvZ9/44Rrv2uFKX1hznNbmg5ieIogEltTp6IdVSe/kcvEwnig3V0jHO2gmaVQGDKCLTg8qIp2/RJNukeYtwbhl0rYiaDU8am4xAlULPwySkAgEoc7Iz+pwgkDZSB8nsewD64xd4XSXpeekHoYv+cPvhswKrVkXUVfRKqD7iYhvTTPUOKkdKGuzde1CC8zLjOwOEQ/DY18KcHLQEEur8oXpjPPFCcxhhLiwHCcP8q+3TOAJNJcYx9GVt2S05wHjQ2kSI0iiCTuzaVeOWFzGz3QVkr0jfccvXQlGFSJLKrjaFs3/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHz2EFImucIiwTqp66QbPeD882RRydXcKo1HNiN9uAg=;
 b=HUw3ggt3WY5KEnkMMGCAkcYshQqvrz1eUtAC+N0WxNMiJotvDIWrMGMpW0ntECu10E97h/yLtBcfsD6vbsBH4J+1/m0JW9T0dmkM2ZbJr7w+ZNVyT3gxBVBP+e2mIwzsF2eau55Jk2W7+V4OYUXaotJdrEp85cu8KHA9okvjoHeITm1BhxkqNIk9cNdSaSDVnLst2ROphNZkro4kFTfjWKG7ph3ZTDcIaidPmBoK/z18QuMl1f/xbKNS1MNJ1hNp3IZpJccP4yaKVUS+pL5goQlntDHvKf2Qwt1NREsBrk+jTUR4MmXVDp3CMEstRgZvyFs8tLpd0vA08VOlYjPbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by PH0PR11MB7168.namprd11.prod.outlook.com (2603:10b6:510:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 09:23:30 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 09:23:30 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Lukasz Luba <lukasz.luba@arm.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"bsegall@google.com" <bsegall@google.com>
Subject: RE: [PATCH] sched/cpufreq: Fix capacity calc in shared policy update
Thread-Topic: [PATCH] sched/cpufreq: Fix capacity calc in shared policy update
Thread-Index: AQHcXeptnEOD6bRJr0mzbLDctwrQBbUDHO0g
Date: Tue, 25 Nov 2025 09:23:30 +0000
Message-ID: <LV3PR11MB8768D5F17B1F9575DE2804B6F5D1A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251125032437.2056626-1-kaushlendra.kumar@intel.com>
 <71ea7728-6808-4bdf-9437-3746ff8664fc@arm.com>
In-Reply-To: <71ea7728-6808-4bdf-9437-3746ff8664fc@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|PH0PR11MB7168:EE_
x-ms-office365-filtering-correlation-id: ac4e5919-6305-4c3d-3b25-08de2c044c85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?R0ZUbS9DUEdiUEw5cDhsdFBWenU0NUZ0OFB4RnQ2NlBFQ2tSS1EyQUNwRStq?=
 =?utf-8?B?a3NVSmN0SW1jNUc1TU1uQXdTK3IvMmVWUWhkQ2pUWVc4WFhWSWo3VHdUUk5I?=
 =?utf-8?B?NXRsVHppSURRSjZCN000d2xPbmtxcndsZHAwY3BwM2RNRlp3cy9OdzBYcjA1?=
 =?utf-8?B?alJJVEIxRFY3eS9CYUFGZTBhcVZYaWpLNXplVlBoSTlaSFVjV0xrekxZZkwv?=
 =?utf-8?B?Z0dzWEtvcU5FZDRTVmZ6OVY1a1hVVTVFY0t5bWtxMmZUN3ZFS21vbnVMeCtC?=
 =?utf-8?B?cnV3MWNqeTVJOTlQZzQ5NmhmQXJoVlZYbzA5THRvS0oycDlTOHdpMDlzU3k0?=
 =?utf-8?B?NjRwRThOaERsNUpmbmpVaXFaQW9ZOFphUGs0L1Uwb05XMkh2N0JpcUJ0UEpI?=
 =?utf-8?B?TlphT0lDWCtJZDJtNnJSN0tWUDJZVTRDZEtiZEhqcURpV1I1UWdCRnBia1d1?=
 =?utf-8?B?MWYyYmJVejVkZzJvYXdjeXljNllFZVpNMXVtcXdqaFFmU3EyVWpOVXJXdEJM?=
 =?utf-8?B?bXV1cWRid1AxSTJJS1ljU3VLeFM3U2VESzN1a1ZYeCt1UUF4THc2YThZV2Yr?=
 =?utf-8?B?Y2F1WE1MdUhmY0pwV3RpUkx5MklIT0t3OFFHK0x3WDBBc2g2R1dKMksveVpw?=
 =?utf-8?B?OUs4clpOTTR4aG82SHVSUGN5SFl3RVU0OXlpMkVhMkd3cjFXYTQzNHFnWUQr?=
 =?utf-8?B?U1B1QTJWU0c1WjF0ZjRpL0ppRzZmTGQzcFd3aFM3QmpKZWRpeldwcTVOUnlQ?=
 =?utf-8?B?OGRRZGJITVN2dDNMTlhDdURLWm5GYWlTZ2szNStSQ2lnVzBhTEMwdTJrSFlk?=
 =?utf-8?B?MVhvZmJUWHhMUmg4YURqeUoxeXM4azBiamF6dUtiYWR6dTVCOXpkdEhQOEoz?=
 =?utf-8?B?WkdqZEY3MVMzUHRuOWtlcHV0QUpPZEpmbGdsTUpyMUtjayt1Wld3ZXVSai9n?=
 =?utf-8?B?NklhcXZacjM5dFFJU2JITzZMZzArbnJCZ1E1VlJZcXhQT1V6RnJpY3pFUXIx?=
 =?utf-8?B?d21QMkJpNE85L1V4M3psMTduMEJ4RHJGaTJMR2FmVTNXUU9kaDA0UlNiVURv?=
 =?utf-8?B?LzdKRFArWG4vTWdPR2RBUVMzeVVNNkZMSE1qYW9YRG5mYm5nSnUydlZBUzZr?=
 =?utf-8?B?NWtXZkx3NUpoUWJPL2ltZmZmSUh4MTVoQWo3aFBnR3hOYTNLOS9hUS9NZ0hp?=
 =?utf-8?B?dGpjQkNGMFNwbitQQjFBTGJJMXdWLzlFTEJYVmYxU3NHazhzd0FWczAzV2tP?=
 =?utf-8?B?bWplcTNhLzBwTFRMbmtkc1MyZHJqUFJqOEZtQmhIcklzSDB2S1cxYnV1bzlh?=
 =?utf-8?B?dExUekc1Q1JIcExKL2VYaHdBVURVZGZ4dDlxVGtsaTUwa3lMZnRLYVUrSTFh?=
 =?utf-8?B?bUxldzFwczVCdEdXcEtEWVJNdXdya1dGQUJBKzVXRW0wM0FsSjNMalpqYVFp?=
 =?utf-8?B?S3ZXeVZqSVNENnFXa2tOUXd0cGo4MzlMSVpVTXBtMzdzTkVlaFB0bHY0VHRC?=
 =?utf-8?B?dkkzOVBZN3VscGdhQUxyemQ2Q0xXQmhxVUJuSWZxRXlrbUo2ZzRmTzdWc2xz?=
 =?utf-8?B?azNyUnBuUm9jWkU5NHdqVVo0MEdiMGNUOHF1NGQyUCtIWGgwWXF5YlJnZW41?=
 =?utf-8?B?MEF5akpldTlMK2xvNlQrWlp0dHJqcXN1eWlxSzNmajMwSFBnK2NXck9FWUcz?=
 =?utf-8?B?VGt5ZlloZ1loV2NrVzlHenhBSitpZkFIZTBKRGdicEFOZ0o1QnF5c3JEaGwy?=
 =?utf-8?B?THp0bEFVYlNackR3VWdWM3E1aGl4T0orbEYvU3FlbEdtQUxmZDU3RUZ5Z05Q?=
 =?utf-8?B?ZHBNU0V3SG1HR2ZldlU2UlJOZkEyMkd4RXlaMnp6TGRzOUU2VFZaQWp5bkRi?=
 =?utf-8?B?NjdQSGlJb3VrTEk4UFY4dGhNU0VzQkxFL0FkQTZnbmV0eUI1L3N2b2tXYWhs?=
 =?utf-8?B?SUFPcmUzemh4RmNSVnJ4K2dHd0VtYnFCS29xc3F5TnowdjdOQ3NEcmV6YTdk?=
 =?utf-8?B?OEJBMS9MbnAra2czR2JTNWR4OURweHhUTE4xWkxJb1c2WU5xMFUwcTJXVElx?=
 =?utf-8?Q?B/qT1j?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkJVR0dwaTVTV0psU1JUcTNFSGRqdXo3OHVDcDEycXAxTmpjemNJai9wVlJk?=
 =?utf-8?B?N2RsUGNCUkVJMXdURGdQQWRmcmQvQ2dabWpGVGJuREpqZDBvVFExNmljc2Vj?=
 =?utf-8?B?Skxjek55cEloOVNIbEFPYnpKUWJDQWZLMVc1ZU9nS1BxZTFMMm5YQllFZFk0?=
 =?utf-8?B?b2tYNlJzcVlvaU02djdMaXdWT0Rpb1VLWnkxOFZGSXAxbTluellnODdEOWxP?=
 =?utf-8?B?dXR2bFU4dWdMQngyRE5BVDVXUU1zak82cDRKZ28vTkVCeXZHTFRZTkMyTEor?=
 =?utf-8?B?dmtrcElLMnJGK0lnaVBjd0hxMGZnaDd5VDllYWtxVW42M3ZwVUovcEtuQUFB?=
 =?utf-8?B?d1l1cDNUQnpXTkJpak55THJyb0ZnaHFRRC9OZERac3JPc2UzMXYzWG5pUXpL?=
 =?utf-8?B?eERCa1F2dFVyZlAxT1oxZTRVcDU4VDFXdjlVdkwxRXp5QWR6YkY1b3NmNW5n?=
 =?utf-8?B?WHhJaDRJdXJIV05vKzVIcVBqajU2WFJ6cVlQUDJ2UkNRc2RQc0R3VFVqWmxh?=
 =?utf-8?B?ZlFkaDBETDNDVGdISC8rbDRudEQxNHVhNFlMMEhTbFdTNnphS3V3d29QOVov?=
 =?utf-8?B?eWRqNHhDRjlWU1oyYmpZZEZWU2paM0RSTGRMN1FwRTFvbXpXckpaUC9HS09O?=
 =?utf-8?B?RFhuQTlpc0RFYXZiemREem1BY3NNeWV4UHJweFRlMmZWbGZiekhDWDVUUXYx?=
 =?utf-8?B?Szg5aTU3bXFSaEdXaVpSbEZncWsrYkluRVZXMlQxRTMzQ2djQ0xnakt2TjAv?=
 =?utf-8?B?dElOYTdkcGdvblBJTnVRbWZjQXhmemJCaEkrbFFjQTlIbFkrV0oyNUVYeUlx?=
 =?utf-8?B?NXRlU2x4MGR0K0FNdGNiUVdDQ0l4OFB6eU1wVzBjRFpEb1BIcnZ4d3EyaWd6?=
 =?utf-8?B?eFlwSXhZL3VCb2pNZ01qbVBvK3RHSlU0UXBMUjA0QlcySXZ1Wi83OEowcVJl?=
 =?utf-8?B?SnFBMWJ1MTNHZUFwRHg2RlRmWEF2TWdUWXE5Y3NTWk55M1ppVDZiZkhzaExF?=
 =?utf-8?B?U3hyWDgwQ05lMnU4eWh4SDRvbGp3emc1RytqVXFtYlllY0J6Wlh4VG1rODhN?=
 =?utf-8?B?d0ZieDdsOUdURmhmRlhYVE92a0s3Z2N2YUVMVmxQSm5jb2ZyWWFGRU9SUVZr?=
 =?utf-8?B?WVB2cm5wSXFaRnNWU2U4dGM1MWg2L3pGSHhzQzhubWxWL3JTU2gvTUdrd3VI?=
 =?utf-8?B?d3Z4S1lTbTlnYmo2d3Azc2hnUzc3VDNvVUZzZFM1alVXK0duYWR0VjhuRVBY?=
 =?utf-8?B?K0t5UXRNTFAwb2VTWHQxdjJJeXdiNmoxRW9pU21Ea1NHY1lZNVpFc1ppK0Rv?=
 =?utf-8?B?R0orZkMzUmxodllVV2lrVnlyVXQzYzIzZ0MyOUVuNk5RbGo4UzZ1aTl2UWdY?=
 =?utf-8?B?cTlUdU1ZS2hnVWdOUDVxKy9mK2I1WU56SjZHTktieDRZOVpFNGx1MzJJRG9p?=
 =?utf-8?B?NGVUbEFQL1d0RkMySVVUck1uUXlUdUJEaFpBZ0krcDNqcnYrT3NjVi93bmVD?=
 =?utf-8?B?YjQvVXN4Qk9EOEJRZGZhVVd0cFl1ODhEdEdISisvT0ozczFwSmRXOFpYYnZT?=
 =?utf-8?B?R09vVzByQnhGdW1IRXFGdXM3SXNrNk9OMFdYalJRYlB0SWdnTEx0dEwvL2tH?=
 =?utf-8?B?NTVvanBpcFVyampoR1Q5YTZFSU8rckMvZjVOL1VyTExQT3g2OVhZWFpERnFx?=
 =?utf-8?B?VTBRTHlRaWJ5Y2diNG1oVG9YVzRqcG1aVEd5dXNaOUZoZWc2a0VJYmdqUkNz?=
 =?utf-8?B?dmR6QlJRaHhmZWIvM0JMU1FneDNybmwvVHE1NW83aUlubHNFc3poems3V25J?=
 =?utf-8?B?WVFJYS9QdDZtQmlKa0U3bDVSTUJRdXhPM210N1FtWWZBYWlHTDBWSy9FRXZD?=
 =?utf-8?B?T3ZvNjJ2SXQ4Y1JmbEFVdlZzcGJwejJSNlVqNERZZkRhZmZZTkNiWWo2OS81?=
 =?utf-8?B?Z1kvL1hXRGhwZUZDdW9GQWx6MU5rY3pOdzcrM1ZmUjIvSlRINjZ0NWtkclVk?=
 =?utf-8?B?Y3VnckdBTTBSWXFqU2dseGJrUjhHUEcxK3VOZEhjM1RHT2FSMGNLTGxxSytZ?=
 =?utf-8?B?VDltMTc4aEd4MTBzcmJZTkFTd3gzdUdwWUFld3gyVG9EYVliM011Z1ltMk5P?=
 =?utf-8?B?L0NXQzQ0eXp1SlQ3amRpcU0ycHhDUVA4SkdDTy9PSldjT0JNVGh2SU1KTjV3?=
 =?utf-8?B?cWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4e5919-6305-4c3d-3b25-08de2c044c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 09:23:30.7861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wFVjtWeGXbAG7HwSgP28Jn00+gNZsX2qiQKYMkA20nDelnLDjiWkxNCkRTOYVm4jciVBw8p0dQKrgEGlGsbbdf+/4BZKW+7nKiKO7XUrfTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7168
X-OriginatorOrg: intel.com

SGkgTHVrYXN6LA0KDQpPbiAxMS8yNS8yNSBYWDpYWCwgTHVrYXN6IEx1YmEgd3JvdGU6DQo+IEhp
IEthdXNobGVuZHJhLA0KPiANCj4gT24gMTEvMjUvMjUgMDM6MjQsIEthdXNobGVuZHJhIEt1bWFy
IHdyb3RlOg0KPj4gSW4gc3Vnb3ZfbmV4dF9mcmVxX3NoYXJlZCgpLCB0aGUgQ1BVIGNhcGFjaXR5
IGlzIHJldHJpZXZlZCBvbmx5IGZvciANCj4+IHRoZSBDUFUgdGhhdCB0cmlnZ2VyZWQgdGhlIHVw
ZGF0ZSAoc2dfY3B1LT5jcHUpIGFuZCB0aGVuIGluY29ycmVjdGx5IA0KPj4gYXBwbGllZCB0byBh
bGwgQ1BVcyBpbiB0aGUgc2hhcmVkIGZyZXF1ZW5jeSBkb21haW4gZHVyaW5nIHRoZSBsb29wLk9u
IA0KPj4gaGV0ZXJvZ2VuZW91cyBzeXN0ZW1zIHdpdGggQ1BVcyBvZiBkaWZmZXJlbnQgY2FwYWNp
dGllcyBzaGFyaW5nIGEgDQo+PiBmcmVxdWVuY3kgZG9tYWluLCB0aGlzIGNhdXNlcyBpbmNvcnJl
Y3QgZnJlcXVlbmN5IHNlbGVjdGlvbi4NCj4gDQo+IEhvdyBpcyB0aGlzIHBvc3NpYmxlPw0KPiBJ
cyBpdCBvbGQgb3IgbmV3IEludGVsIFNvQyAoYSBjaGlwIG5hbWUgd291bGQgYmUgYWxzbyB3ZWxj
b21lKT8NCg0KVGhpcyBpcyB3aXRoIHJlc3BlY3QgdG8gaW50ZWwgcGxhdGZvcm1zIHdoaWNoIGhh
cyBFLWNvcmVzIGFuZCBQLWNvcmVzLg0KDQo+IA0KPiBJIHdvdWxkIGxpa2UgdG8gaGVhciBSYWZh
ZWwncyB2aWV3IG9uIHN1Y2ggcGxhdGZvcm0gY29uZmlndXJhdGlvbi4NCj4gDQo+IEl0IGxvb2tz
IGxpa2UgYSBoYWNrIGFuZCB0aGUgbmV4dCBuZWVkZWQgc3RlcCB3b3VsZCBiZSBhIHNpbWlsYXIg
aGFjayANCj4gdG8gY2FsbSBkb3duIEVBUyBhbmQgRU0gaW4gdGhlIGVuZXJneSBlc3RpbWF0aW9u
IGNvZGUuLi4NCj4gDQo+IERvIHdlIHJlYWxseSB3YW50IHRvIHN1cHBvcnQgc3VjaCBjb25maWd1
cmF0aW9uIGluIHRoZSBnZW5lcmljIGNvZGU/DQoNCkkgdW5kZXJzdGFuZCB0aGUgY29uY2VybiBh
Ym91dCBtYWludGFpbmluZyB0aGUgb3B0aW1pemF0aW9uIGluIHRoZSBob3QgcGF0aC4gDQpMZXRz
IGhlYXIgUmFmYWVsLiANCj4gDQo+PiBDYWxjdWxhdGUgcGVyLUNQVSBjYXBhY2l0eSBpbiB0aGUg
bG9vcCBhbmQgdHJhY2sgbWF4aW11bSBhY3Jvc3MgYWxsIA0KPj4gQ1BVcyBmb3IgcHJvcGVyIGZy
ZXF1ZW5jeSBjYWxjdWxhdGlvbi4NCj4gDQo+IEkndmUgY2hhbmdlZCB0aGF0IGxvb3AgdG8gc3Bl
ZWQtdXAgdGhlIGhvdCBjb2RlIHBhdGggdHJpZ2dlcmVkIGZyb20gdGhlIA0KPiBzY2hlZHVsZXIu
IEZvciBtb3N0IHBsYXRmb3JtcyAodGlsbCBub3cpIGl0J3MgZmluZSB0byBnZXQgdGhlIGNwdSAN
Cj4gY2FwYWNpdHkgb25jZSBmb3IgYWxsIGNwdXMgaW4gdGhlIHBvbGljeS4NCj4gQSBsb3Qgb2Yg
Y29kZSBpcyBiYXNlZCBvbiB0aGlzIGFzc3VtcHRpb24uDQoNCkFncmVlZCwgdGhlIGhvdCBwYXRo
IHBlcmZvcm1hbmNlIGlzIGNyaXRpY2FsLg0KDQoNCj4gDQo+IE15IGd1dCBmZWVsaW5nIHRlbGxz
IG1lIHRoYXQgaXQgd29uJ3QgYmUgdGhlIGxhc3QgbmVlZGVkIGNvZGUgY2hhbmdlIA0KPiBpZiB3
ZSBnbyB0aGF0IHBhdGguLi4NCg0KWW91J3JlIHJpZ2h0IHRvIGJlIGNhdXRpb3VzLiBMZXQncyBp
bnZlc3RpZ2F0ZSB0aGUgRUFTL0VNIGltcGxpY2F0aW9ucyBhbmQgDQpoYXZlIG1vcmUgY29tcGxl
dGUgYXNzZXNzbWVudCBvZiB0aGlzIGNoYW5nZS4NCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2su
DQoNClJlZ2FyZHMsDQpLYXVzaGxlbmRyYQ0K

