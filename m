Return-Path: <linux-pm+bounces-39250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B6ACA849B
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 16:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA5223051152
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE223446B2;
	Fri,  5 Dec 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtjQt4CA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E152F9DB2
	for <linux-pm@vger.kernel.org>; Fri,  5 Dec 2025 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764949884; cv=fail; b=dIFgSsNWmnxBhAKpuKXVkVgcnho1blx829AfpOPiRfGmXFvv7uoyiIJiHyITM6apkcdXS1CIOe70yQ6wJu31QukT7oX8MfKIPrhMXdqWoZhbNG7whUtcrf5+9Tt4ojJ1oeN0sZpiSspnbmJslxyVZAZXTzkX+1ezkV9Hgki+xg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764949884; c=relaxed/simple;
	bh=bql2jVfF1HnqIakVB99sFJw8IW8dF5Bp0l6929aCWJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RQ6Mrkw8bCtVFGaCDViUQvt4TnU0tfBJPk/6k7vX1iyLnAKbzl+mx1oAbpCfwEwaJBomOOuFvcQHnMcyRgqm8Np0oYwUzKktGVzbbbzvCKTjKUNqU8XGtsgiyFFGzpxXyDgBNBtkLtCIbH0lQ7+B4e1R4AzAbJWbUmGCGQigx2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtjQt4CA; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764949880; x=1796485880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bql2jVfF1HnqIakVB99sFJw8IW8dF5Bp0l6929aCWJY=;
  b=jtjQt4CAi6XcsNsm5lOAxE9pACFaAvHyD58yrvK5P6qaMb51UmWwzNv9
   0Kn++q6qizGh720AYPUcHJ+Y+vwP8eIbWHerNvVssjeeaEhXEVvspe0rD
   E4ITZu2veMHZDLYj8YkXkKPyVSB85qi8wqGsViAnIfxx8g6OPRwlmsNHL
   MKyXpN4NI+M6d8IHmp4HrCc6OEOt9If0r0jjXW5D+7mWk22WZ/CtJe58N
   JutKmP86z0lHHYy2DP2+H4zkMAR8QwuhzqrelaCYhct1AhvxI+o2N2Hbb
   /UDM+/ADfv8evHJshO2cmK55PeZuyUJfC0t1Y8+O9difILXmp5QzTngcm
   Q==;
X-CSE-ConnectionGUID: LNJrVzitT5WEMQoLJpKcHg==
X-CSE-MsgGUID: 0cQ+44lFTri5nbTJz7Y/VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="66918675"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="66918675"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 07:51:15 -0800
X-CSE-ConnectionGUID: pyb+x8UVSlq8JJlNVKsycg==
X-CSE-MsgGUID: 1oUZG591RrW9ERSSftWbAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="194622549"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 07:51:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 07:51:15 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 07:51:15 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 07:51:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axqEQbFX9sTfd+GfxlxlfFycmR+PUh+qsm9x9W36fM8GCS5SrR+dxq+s8DDO/+rEs6Aw6G8LajXd7aqvON+biDekOnZRMcIMeR5kTuc7DcrkdAuXIf+wIQGPB9aEVyx7iEJ37ickzkU5Sf3DP1BaIrcWzZPaNMZb71U5dThjZgAQGjaV7e6CB1AZQtm4bnab6d0oP61Gn86fd+g75T9/3vv/OnPKWLAae3WJaDv6K2JDoSF3PGuIvF4hJ/m7EwZ9s1D00/SeJG6jMQBFo6LKbzzWQn414s/gc0twm7D40OSF/7mbWMkIiHHHiFaxoBWixl8f/goE1I7N2YxC/DcCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bql2jVfF1HnqIakVB99sFJw8IW8dF5Bp0l6929aCWJY=;
 b=ab0wof4uluJ4u/LssRooMW9xS2Sv60XGfDT64Vm0J6RIvuYn6KN8iP7NrhyEQCq0EYg+pO17Ny5xVI84geXUc2SbV/jcAU1S+1uhFvjPKug7qZA3DHg95bbBFIxaCyGeYIF18svVORdB7yvlragPJvkuL6NgJdJ4jkGn3veeplNqZ/v0eb08xYjgmp5p5aWVZFe/h/Ayzm0Z5jShAKX0gF4jM4vZlV3A2FyR0erPwotQdnopjvcDfrStMoil0tK/mhBKVGo+c7y6XeW2GHkSqyA5JHM1b9l9xg+L4SRmT/elbDtVhZMxQWzUybe1PYAzDBhC9GhaE2smFKAT8CQgXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by CY8PR11MB7108.namprd11.prod.outlook.com (2603:10b6:930:50::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 15:51:13 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 15:51:12 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Len Brown <lenb@kernel.org>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] tools/power turbostat: Refine iteration parsing
Thread-Topic: [PATCH] tools/power turbostat: Refine iteration parsing
Thread-Index: AQHcZe+6MiOJpwg4PkSAF7eU1Su+ULUTMeFg
Date: Fri, 5 Dec 2025 15:51:12 +0000
Message-ID: <LV3PR11MB87687A5680688B67D27FC469F5A7A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251201031811.1362803-1-kaushlendra.kumar@intel.com>
 <CAJvTdKkYz7JxW0eW0-2hcxg-1ThS4=2HnHZUdhp_=c-VPAVP3A@mail.gmail.com>
In-Reply-To: <CAJvTdKkYz7JxW0eW0-2hcxg-1ThS4=2HnHZUdhp_=c-VPAVP3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|CY8PR11MB7108:EE_
x-ms-office365-filtering-correlation-id: 1bc758dc-e366-46dd-4883-08de34161ddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cm5pL0locEFkVVkvZHJGN21udFNjeHlIUlllVENpNzlLZ1lLRnZ2Vk5Ddnl0?=
 =?utf-8?B?RU10RXpSdnFiZmRaandFaURNVGd0WjE0eGpLUkFtZURxYXRNdlZlTmJCT0JW?=
 =?utf-8?B?dTFDWnlFN3BlV1JBVDJQWkh4dkJGMnhsam9HSFhvYW8xR0ppeENPazVrQXdi?=
 =?utf-8?B?eTZIMDlJNDg4Z2o1UC8yOFUxOVNyWlVQNjBaVm9HUWxGUWMvekdJd3huVXBl?=
 =?utf-8?B?WHFlSFIwOHRydzlkZjdDRGF6OWRlNTRQMGZvYkY5cEtFYTdlYkRnNVR3Mjhy?=
 =?utf-8?B?YXMyajJpNXAvcWY2cDNvTWcxcTZzSDZrc0lNYXkrZjQ4MERBWGdScnlPblo0?=
 =?utf-8?B?TkZnRU9wM1BjY2ZFRFpuc1NMZlRqb1dGSjQ1RFZTZUd4SHZ1OWcrU0l0RkhH?=
 =?utf-8?B?bzJpSmZrbCtXL2dodjJHSGRnZytLMDhWMUk2V2cweDZUMm9TQTc5MGEwVVZj?=
 =?utf-8?B?bzkwS0dyN3k0NGxlVHZTWFlpbWR4NGc2emdiVWZvaEhaK1NCL3VpaTh5NU0y?=
 =?utf-8?B?ZXdxKzhmK1NIeHBPUDg4VDhvYUQyMTI4dHg4TVRSbXVDQ0tzUjBXRGZVeWNl?=
 =?utf-8?B?Z1NpamdKTVczRUZyZE84eW1BSHpqNUpvUlkwcWRVdXFMZWtRRW5wNElkUVh2?=
 =?utf-8?B?UDZkNSt4ZGtQRHNkVWh5VVdCMXVhN0ZORmhJUFNrZ3J2dGlUNWduMkprcSts?=
 =?utf-8?B?RGQyM2lnbG1qWTY1d1hHVkxqaHVnazgrckN3SXhnQWxlNkN1ZG4vS3J3S3hM?=
 =?utf-8?B?MUZqWEZhbDI1ZHJ3WFhSdmhrNmJLdDJ3Uk81YjBzcG0rNnk0dDdOZlhSc1Bm?=
 =?utf-8?B?SHFuc3FaeHZ2Z2MwRjBvenhEK29tbDFEVFU5d1gvbkYxNnp3WE9samNlYmQv?=
 =?utf-8?B?blUxY3BDT3c0YW5sdUx1eHFBMjV4TndlZWhNNFhWL2xJdGd2YzNxcHpSSlV1?=
 =?utf-8?B?cGYzSUJWdUxNNGI2a0ZPYkRXQnNvYXIxU1lIRDdoMG5UVmVIYjZRa0NUaC82?=
 =?utf-8?B?UUtyYy96T2xwZkVQQm1pRGg1d3JYT3lJZ1VMbXBtSFlkb0dTRXNXSXhnWjFi?=
 =?utf-8?B?RmZnSGt4RFhsdlNBOEpiMUdHS1FET2dKc0Vva0xJMEkwMTI4a2pnSmVTeGJC?=
 =?utf-8?B?OTVWRFExK053aDNoY1pMMHBvS09McXI2Qzl4b1FoM2dQR1VTTFQ4MzdOcUIv?=
 =?utf-8?B?MUsxcFlIRkJzQnpiUGErS2VQVjRZV21Yb2dFc2dRcG56V2hwN0FRZFpKQUJx?=
 =?utf-8?B?OXA4bndobEFYUlpkQ3pmOW53WjVPbzZvZ05FbjU3UFZ5MlJaWDF3V3ZaK2NS?=
 =?utf-8?B?bE5vNUNoQ21LRzF6RVZQaU5LMUVmNWdYYllhdVIzbTJVYUkvOTJDclZSYjJS?=
 =?utf-8?B?SUNJVU9uUE1uYjM5U0tDY2ZLVGQwb3dMMzdid0FMa09yblFidjc3emF2Q2JM?=
 =?utf-8?B?dWRXdjhocTlyWDNGaFl1OHdZaTZub1I1U0V1K3kzVWUxeUEyZUZ6Y3pmSmRh?=
 =?utf-8?B?WCtOYmg0SzFoV3FWV2huWTNCak1vUkpXTllGazVkVUZxaXBDZzQ2VXE3MkdJ?=
 =?utf-8?B?WFNmbUVyNHRqVE4zSjltOVRKeU1WSzZqOURQWFA5Z2xQZjZtSTJLdnBpZkFx?=
 =?utf-8?B?YjlvODZWeWZteXNYMlBid0RGb1RtejlRRE0rQnpDd0h3WS95RlQyU2NiSWt0?=
 =?utf-8?B?UW5wVGJFbjl5M0dQNnhRdUxHSVF6blc4YlpBbG5PSXUwSXlSSHdkb25CYmVJ?=
 =?utf-8?B?K1VKSGc5KzA5WGwvNXhiYnd0bzhKTk0ybVgwUmY5WmQxNzV6MHZHUzlSTGpI?=
 =?utf-8?B?RmxJTGhreGlFZEFPbklaVDR4TzRMQWg5enVBdDVaVWNPK0U1Mkt2aGFYVEZn?=
 =?utf-8?B?VGNnRUgzdU5EbkEwWFhzRDlKckRzV1VFd0kzUXQ5SDBSaEY4RURxZ1BPSkx4?=
 =?utf-8?B?N0NyeXdPbTBwcWZwZXN5Ti9lbnVJSDF2dHpsZUo5bmErTnFmQXFJaGhQTDdh?=
 =?utf-8?B?aGY4YkgwcEdsSTl5dVVHN3Y5M0NKM09HK3gyQXFyMWRnL1VZcjJybnA0R1BB?=
 =?utf-8?Q?c2iz+R?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVBZWUdqdTFSbUFtd3UrZ3JPc3B1a2Z4STVSZWtNUGhReVQ0U3NUd0QzcGUx?=
 =?utf-8?B?MHkwcXBjdk84MkxvdWZrRDJRWFBFMy9oQ04zUkx2amJiQWRySWpRa0ZEMm1i?=
 =?utf-8?B?SWY4SEdqNmw5aE5kcDV6bm9NSWJJMFFKQ0NyaFFqOWd2dXI5cytadnBJeU9l?=
 =?utf-8?B?bTd5Vyt6cWpsM0ZMMnFwMXVLaTdTL2wvRCtRWENoSmZQTmcva1d4WXk4V0pZ?=
 =?utf-8?B?OEZIR1ZOQWZlNWRGSHZLV1ppQVdlR3ZQQStORTNmWjJDMTJpc0pFRmxQMnpN?=
 =?utf-8?B?L093b2RvQzFpQXgzTG1USW1maEdnbUtCd0NQVlV6Uk1OQ2YySjN1NU5nU1pQ?=
 =?utf-8?B?ME05ZXRvWlFxVUc3alc3cm16RGozZlkwbWhmamxDK3pIbEo3bFV1UTR6c0U4?=
 =?utf-8?B?UHpFUGVXMzEyai80VStOVTVNWE51S2VRS0JRRDhtb1lIZnBnUWIweFlyUXZj?=
 =?utf-8?B?SWgvaEF6WHFsRVVGM21rdzFMN3ZLd2ZhTzB0cll5Nzd4QXh6b05IbnJaL3l6?=
 =?utf-8?B?UnROak1JYlJPLzBwNDc3b0FXcWZiQWs0eUVkeDJxYW11cm9oNWI2VXY3ck1M?=
 =?utf-8?B?RW8xUHZlYmdkS3g1d2NoVmd2SGtGU1ZMOHV5V1dSL0tab0VvdEFhNzJXSllL?=
 =?utf-8?B?MzJ5SHNJakxMQ1IrejJLVERzdktLQVVkRENLbSs4ZTY2SmEvYUE1bkF6ZzRG?=
 =?utf-8?B?VCtuQUMrYUhTMzN1ZmM3N3VUZDRCeG1hTnNjbzVWcnl2NW1jUG9sdVV0eFlO?=
 =?utf-8?B?N2NSUUVOanlXeDduNlgzSUQ3UW5qWEZIUVg4Yko1MTMrbGpIVlhHcHVFVVhl?=
 =?utf-8?B?MGhXWXFoLzNDbXVjbXVHODFUZjhpL0RwakU2a1VVVnBQMFJFcGZhQmRWUGRx?=
 =?utf-8?B?TExjbGNxSkJwOFdUT0l3WERGOStnSU5GanRRemltRE1BT2FaUDJTUno0MmdH?=
 =?utf-8?B?Zm1ReHhGcjdSVGc2empDRDA0a3BlRnNaWFVvdlR2QW0wMDlIUzFoQVJNKytI?=
 =?utf-8?B?QnNKakU5VFplbXZpOENxbHEwZHJjTDBSRkF1d1k5aFUyUTFWZ3c5c05GM0pX?=
 =?utf-8?B?NDRMZmExZitvcVNlUlZZZTFndThiK01zWUhCK0tmVHdlVVp1blBqOWlUNnpE?=
 =?utf-8?B?QlduYWwxSHVWRGVHeEh1YjVCL0xYQXR6Vlc1YWFKVVcrcVdNTW5RMW0wSHhN?=
 =?utf-8?B?M2g1cHpyeWZLNFJJeVh1VGtidEZacVplbzR4SXlWMmpiMzg5N2Uwa01MdzlR?=
 =?utf-8?B?NTJGNVZpK0V1YnBjRFlIN21NZEQ0WTNzQ2l5eE1seVdFaE80ZFBGTCtqUUxp?=
 =?utf-8?B?ZWl3cnZlNVFTTWtjVTJodnhNeGdYaTV4QThJOE1ReWloZjhsSEYrQjJnRmhF?=
 =?utf-8?B?cy9rYWVNZkVOanM3S2ExV0ZtUVZ3TS9lZU5KS0ZIdlkwaU9QdFd4bEl2MzdZ?=
 =?utf-8?B?Z1NsOEZzN2krSTlaY3lOUzErM1NCNHhJN1RDVEVaYXNqSk1GSUFaT1lvamtW?=
 =?utf-8?B?YXZsazluT3dhQXdVZUhhTGY0eTJJdWJuZjUzSzJFRUo2aEtSb0lJYi9xMUxQ?=
 =?utf-8?B?a2lXK3d3UFpDQ1U2QXZQeVNtWG1acXRiTllQeEd2N1N6TnFUWElnZ2JDTFV2?=
 =?utf-8?B?QlhGWjNocmRZTDNMNEdiNVZnMkRHV0FHMTg3OUE5WSs5MDJkNjBmam9vNjR5?=
 =?utf-8?B?SW40QlE0eXpiRGxZZ2dTQnhwU3d2T1lsNzFBdkNTQTRmTVA4MmVmNzNpajZq?=
 =?utf-8?B?VzFHR3pKR2VTam1iWldlNEhmN3RTZjVXbk9kVHF1dE5zZVJpMnNXRUJxZ1VG?=
 =?utf-8?B?NC9Ucjg0YXo2OGRIbC9LL3lhUEZrUjRFVmtUYXNaaWxIaEdSZ3ZseXBKd1J2?=
 =?utf-8?B?NDJsSEJNa2h4ZmJNaHZJTWRQU1hwSDNoZmQ2YnJnUzYwRHhqRmRrN3kwTjk4?=
 =?utf-8?B?NjBRQk52YTRhMGZIK3dDajBYRnRSQmdkMDhnby9kUFlsMUZlWEZGY0dKaFNV?=
 =?utf-8?B?UHVxUjBycTFYL1B2dkdxODRYZVo0S3RNWWtzcnBUQXFOVUpwdm13NnhxaFc4?=
 =?utf-8?B?RzFvTjl3Y09KUXhIcW5vVGxXVWZzSXd5U1ZXYlV3Z2dabXhHVXZOOXJGbzhE?=
 =?utf-8?B?YmhDWUVINVYzeU9kMXR5T0NJb0tEbmI3OGlkNTVnd0prS3FibWhlRjBwbGNm?=
 =?utf-8?B?VVZvcE4rdW8vckIwd1N5OU5odXE2TXZnSmNtQldGcG16Y09SQ3JVaWowVUZV?=
 =?utf-8?B?OVFZSlRzSW5EVHh5Qkp2akZKTU1RPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc758dc-e366-46dd-4883-08de34161ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 15:51:12.7992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TY7fTfihK5ddVQTn+PPJ5PtAQ8WXxIxbQt3FAwB0FAL3I75ePrhx5sfMkt1vFvUtJIdfXtlEo9qfCL6Vv/V1oFvtwLA31hptiKF7bnccUK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7108
X-OriginatorOrg: intel.com

T24gTW9uLCBEZWMgMSwgMjAyNSwgTGVuIEJyb3duIHdyb3RlOg0KPiBMb29rcyBsaWtlIHRoZSBj
b2RlIHR3ZWFrZWQgaW4gdGhpcyBwYXRjaCBhbmQgdGhlIG5leHQgd2FzIGEgcmVzdWx0IG9mIA0K
PiBjb3B5L3Bhc3RlIG9mIGNvcnJlY3QgY29kZSB1c2Ugb2Ygc3RydG9kKCkuDQo+IA0KPiBCdXQg
aGVyZSB0aGUgcmVzdWx0IGlzIHNpbXBseSBhbiB1bnNpZ25lZCBsb25nIGNvdW50ZXIsIHNvIHdl
IHNob3VsZCANCj4gcHJvYmFibHkgYmUganVzdCB1c2luZyBzdHJ0b3VsKCkgYW5kIGNoZWNraW5n
IGVycm5vLg0KPiBJbiB0aGUgdW5saWtlbHkgZXZlbnQgc29tZWJvZHkgc2VuZHMgYSBuZWdhdGl2
ZSB2YWx1ZSB0aHJvdWdoLCB0aGV5J2xsIA0KPiBnZXQgYSBiaWcgcG9zaXRpdmUgbnVtYmVyIC0t
IGZpbmUuDQoNClRoYW5rcywgTGVuLiBBZ3JlZWQg4oCUIHN0cnRvdWwoKSB3aXRoIGVycm5vIGNo
ZWNraW5nIGlzIHRoZSByaWdodCBmaXQgaGVyZS4NCg0KV2lsbCBzZW5kIGEgdjIgYWNjb3JkaW5n
bHkuDQoNCuKAlEthdXNobGVuZHJhDQo=

