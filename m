Return-Path: <linux-pm+bounces-38176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 067B7C699B0
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 14:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B255C2A580
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27791FA859;
	Tue, 18 Nov 2025 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koh5wNsl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F0325771
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763472619; cv=fail; b=S+Cz705lnnvIxaE6aA7CXuVfyCbPfY74uc61P1Hc9/puNoAEqRpuBKuYgRw158DiydGZwSGE+5Ho4lOHb+PxdxpUlnn0VVcCvfHFeC+DRmX6GMFHOaCA6cZodrcoC75OYREytIuVbW4WmkFaxDgwlujKiVz6/rZNlymrkm1nAik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763472619; c=relaxed/simple;
	bh=SfdJiVSOx2ME3i+Lvy2q5eksrceUZi3WOTUVCjTzpW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=be/iGWMvFfMpshl8n7p2VgEOfggvGZGlhLX8KpTJhyuayPwLW20mGISUBFlz7xwaWQXxEx9jiBUv8VebJp5X76Wh9jfsFikHY9q8hXVgZvpHJvL+RzMrk+UpLejgQyt/DT9oCSE6NFwAZ+qow5COhNsFYQuTYKvEm6PuSkCISso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=koh5wNsl; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763472618; x=1795008618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SfdJiVSOx2ME3i+Lvy2q5eksrceUZi3WOTUVCjTzpW8=;
  b=koh5wNslslC/i7nCG2sctepDL5+LlSnaUXaWJC3RtteekHK+4olvQIXZ
   h7hXgRgPC4SoKvFGmsbCBJVZFHPLjbGmE4uWJRzeFpv83VnWwmvEoNTQl
   UM0uK/fPolRL3J8JpzX+9H/5gSp4wBt3EgyiZ7qjXE3UX0aCgz2Yrd74b
   mRA2nel5VrjevMJdjHfYt5B5TCYSFB9ua5V4VLvC+1RQiJkNwTf80nd0U
   ZWxUDESG1/AbcsIIreVZqJbjBB8Elk9pDst2f4JgmXEhUjlDZSS734mpO
   5PVgaNcY7oupAGVWs/1dWwuXgvIO30Lsl/iexbyqKmBYU55ZebDVXAahD
   w==;
X-CSE-ConnectionGUID: Z4eeADFJSDmsIn6bEyfK5w==
X-CSE-MsgGUID: /4aaktQ3QsSZM1NLK1HRrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="88142676"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="88142676"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 05:30:17 -0800
X-CSE-ConnectionGUID: QeU0+4oQQVaGlceIG+MwcQ==
X-CSE-MsgGUID: fazUwkc1RPW3f+5HHoJIKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="194872130"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 05:30:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 05:30:16 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 05:30:16 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 05:30:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2/R/Vg2zO9Va3U3sAGfZLPFJ0xyLABj3wkrde3hC5oYl2ZKKIaUTfc425ouc6XJz6hHhHtXxW++Hp0/1n8ajc6jKm9zafvcou5/WGSPsE16P2CY9jUUSup3jU4Tj44VmCMAJmA+RdQ/QkMXQ4e0Au/MCysNd7udT4jy4o61AZY4uQ/HErJWuPe+pehgA+xn1xSbwMJxygWX0eHLKUmMxoWDcRKUX3//bvIoqqNY2oAGIlWxt6lVQpN0NXS65+Dk6QqQGTUQuiSWnqTHWkthY6P8XiMS5sgmeV0b53dwD9aSt8Jg7ryYxNr3CmG/5MwNgDyG3Hbo/EOCMpyjKb1rcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfdJiVSOx2ME3i+Lvy2q5eksrceUZi3WOTUVCjTzpW8=;
 b=kVlmvt5z2ulsyzJO59Hz0IdrURujM6JEu4n5y+SQrPku1/isaHQehrMv2dVpcU4ClHTykrOow1E+0S6U86bVUVpd8PKY0YG6DOtZqDwBlzt3ErnoZhlzUQrzRzTwobRU4IdT2IVGx+Iz7uWrTOlq73beVhRryzseb/+o62rYS1/fNhFDFUe/zYS68oiiIkgmyoXygbksaWv/ckDB6iunZ0es5r4N5l0KtRahsMQMBrrTeE6Yuc5RY3ROgIp38hpPdU8rVAiAEh8bJRxtxSjQhUwrqeBZZcqxM1UoC88jQS6W6e1sWP1ShPlhHhuIcolswzUswgytw+zT6+a+Nnd3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by LV1PR11MB8792.namprd11.prod.outlook.com (2603:10b6:408:2b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 13:30:14 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 13:30:14 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Subject: RE: [PATCH] cpufreq: use cashed resolved frequency
Thread-Topic: [PATCH] cpufreq: use cashed resolved frequency
Thread-Index: AQHcWIYuz217eVQsOEaStBuc6wFs4LT4bZ3w
Date: Tue, 18 Nov 2025 13:30:13 +0000
Message-ID: <LV3PR11MB8768EFACC0ACAC8DA65B0281F5D6A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251118064606.2777035-1-kaushlendra.kumar@intel.com>
 <242f6e83-fca0-4225-a196-e573202c2a95@arm.com>
 <CAJZ5v0hKncY4krfQQnszizr8k9p9PCT5GD2bQ_3SXj-8H1RcuA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hKncY4krfQQnszizr8k9p9PCT5GD2bQ_3SXj-8H1RcuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|LV1PR11MB8792:EE_
x-ms-office365-filtering-correlation-id: 93692d1f-39ef-4bb1-398e-08de26a69aef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WlZLMmx6d04xU3lDTGF0emdndGwraTFNWDJQaFpyemFpckd6c1paU3pYT3Z3?=
 =?utf-8?B?WFExdWVDVTQySVRvcmhYRjZQNHMyVWpMUUcrU2ZBbjM3eGl1dlEyQUtJZWF2?=
 =?utf-8?B?SGlTSHRsaHAxaGxUMHVzaFpOVGNqTC9yZytGN0RzN0c4VEF4U2YvUHl3bzZr?=
 =?utf-8?B?YTBPZkErcEp2NFRMRGZUZDBSZHZMdjNZa2RpZ24raG9zcW5nOUlWRVgyS1lh?=
 =?utf-8?B?bHBrd0FEekhVa1RDcisremRUWFpXWTAxWXZ2YmFyb004K0dYaUNjWG1JTU9W?=
 =?utf-8?B?YktuN0tpYk5CR25MSUdzaGI3akdTK2JQTVR3bUVVRTA2ajVxN0VEaEk2WlFR?=
 =?utf-8?B?QVFpVTNodmRLSjg4dHdJUG5MU1Q0SlN3UkZISWtQZWR1REhsbnBmakpjUWpE?=
 =?utf-8?B?NFpaK1c4Q296eFJzSVZYTlpCbGZoODFXM0RHSEIzQ095UVcwZWxhaitNeDZ4?=
 =?utf-8?B?N2dvNFZ3T0x6Q0VEN0d4UVJPaDRXeVp0VjFGTUw3T2hJc3VqOHh2UzZuZDB5?=
 =?utf-8?B?cUwzek9DWHBrRWpUdDI1MWRQb09yRlJnVTBSRGZHeWtpNVBXa2JKajBkUHRE?=
 =?utf-8?B?N1ZrY2wwS3FXcjFYNXRVZGJtc3pDWnI5Q0tVUVNlNmQ3cGl0UXQ0NlRTYVFa?=
 =?utf-8?B?d0p6SlBoeXNPZXpCZUdjdWtxY1pRMkN6N0k1NzNScjdqUlFBYVFMK25HM05G?=
 =?utf-8?B?ZTArWHdxMkM0UHRVa2JhRElTQlNHNEVhdmMrSnZUV0ZhK1Y2SUZ3M1ZaTGpE?=
 =?utf-8?B?UUQ0K2FvZUx0VHllWFB0K0t4bXd4SE5xd3NKTkpvMVU3WVFNdys3MUd5ekk2?=
 =?utf-8?B?aHhpNjZoMHF0OGxqSG5sWFVMZlk2Y2JiWTR6OTVseHJjNnFIbjBObG1rb1Fz?=
 =?utf-8?B?aFpLdnliSHNET0lDZUNkUkNod3FSdEdERG13UGc0ZkdoVUVZT2dSTmM1T0JM?=
 =?utf-8?B?dyttY0c2ZDRBTHBxZWVubmtRbWdTQ0twSE14dVNqcUIzMkc1bUxFSnRRcFBU?=
 =?utf-8?B?N2FUblJFNXlxbkxvTzdKMy9VMlQwYWpNS211QmY5dldGQzF2N0I1L2llYUhp?=
 =?utf-8?B?OFlHY0lyUWgwTEZJdUNPTGd1MFFaSi9xdHNYem5sRVM2cmFBKzQvdDc2RldK?=
 =?utf-8?B?Nlk1by9UN24wamNBeVprQlh6U2wraktKc282N204QjBlWmJhalc3K0RSRmtB?=
 =?utf-8?B?dE00Q0JHWEFtMnl0TTJKblJZRGlXQm84YTczZGcxcGI5UHhBMHA5UVRFNElT?=
 =?utf-8?B?SFBTK1dIV1JPR2cvb2o4TjUvOHNKQkUvZzdnS0RnZ1VWSUN2UkJZNDg1NW5E?=
 =?utf-8?B?clJEWndYNTdMYU5sWUxKYkZRZGdrMGJCRE54eEJ0NW9JUFQyYWdqeWkvcjhJ?=
 =?utf-8?B?TUE0b1VDNFcrYlNockVjK05kWjVQeHJCYWVtY0NMQ2pPMFRFSC8vSlU3dHlY?=
 =?utf-8?B?cFYzbGdlVlZ1aDRtelRSdmF3bUI4R29ua1BIWFdkU2tjb1lDa0dNS1pEcFpo?=
 =?utf-8?B?N2JwL1Vkejl6OHVDWUJrWGFKSVpUUmxmQVA0TUVlZDlVMDgwMys3bExVM0JY?=
 =?utf-8?B?QXBueHRUK21qYkNNcGM1TFYvZUJGM2lFWlUxMkFNNm4zd0JmUGhsb0pqcEVN?=
 =?utf-8?B?QjJyckx0MHYzb0E4UjJOM3BIOXl0M2NRNjB4ZThnSU1oVmxOY3ZBalU4Rmo1?=
 =?utf-8?B?TEk3dHJzbytseUVMeEpDYUR3WnFNWVd2Sm9Oajk4UjY1S1NndThnSnJDSll1?=
 =?utf-8?B?aWF3S2d2WCtXQ3d6elU1SXpZMXdKeUJyOHh3QXFncjdFcCtnY2cyUVUvTHRn?=
 =?utf-8?B?TGp4NnN4VG0wcWEzMjdiQkFRbGdKNDFyUU5ySHhSS01vZFFhRnM4WENqU09a?=
 =?utf-8?B?UktBbmlxbWZUZ0p6aFY5Rm5uUG9rK0cvV0VmNU5XWGNrWWpIeEJJcjFEQXlT?=
 =?utf-8?B?WHRmcUZ5b1RmRTQrcHRnUXFxd1BQdHlaWjJnbWZFVFlSdGhwYy8vMzcvNG9O?=
 =?utf-8?B?SHk0MzROSEpPaUpyNUwxbzg1eno2alV0TWg1amx0aE81RlBPcDVTUlpNeXFy?=
 =?utf-8?Q?+qb4LF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzZuczlzU3RoYW8rZHNZTmxpaU5PRTg5NSs3T3BRWnJVTFBIRTVVTE56a2hS?=
 =?utf-8?B?MG9UWUFwaktvS2lIUVpYUm8vOENld2hUQk1jeFZPdmxVcjFoVlFRSHZML0lx?=
 =?utf-8?B?TVdwMjJBQXZQa0lPZzZKR0x6dXh6elZQakdmRllLNWZhVmltT3NLWlliQXpM?=
 =?utf-8?B?dUpwcmpjK3NjMTdLd25WVk5zcU00WFVvYWo4TmpkdThQWm4xUGRXeTJOT3p0?=
 =?utf-8?B?WldmZmVYVkdnT25JMThXL2hic2gzSVhkREJxbnpFYVVhNUZoY2MxOTlsdi9y?=
 =?utf-8?B?S0lPQkU0TUZUYVJXNDRGb1Vsem1GVDZjVjNoVFdnWUJoSVBYQmdJWjZCSTFw?=
 =?utf-8?B?VzcwWmRRSm9OUzVNREEvUTIvQldEVmRlNVV3R0VvTkhVZ3VVcVNFd0EvUTAw?=
 =?utf-8?B?MGRDTUFuM1VHS1NzU3R1SXlmaDl4U2h1TEhIaEhUdWNWMGlBcmNtNHg5ZmFT?=
 =?utf-8?B?aW5tUjV0cE9xU0p5S0NSR04rWDFPemRkVS9Ldm8rQytnZE9MUWU4Vkh0cVRo?=
 =?utf-8?B?RkdpSElrVDU3dEEwUngrOWN4ZmtsVUs3eThQc1RzcHpOOFYwbnFZNWZXY3pn?=
 =?utf-8?B?aGR2OGJCZzAzQThGUHVScW56Q0pMWmlzb1pKdmZIT29TZDRxRHNKZXcrMmdo?=
 =?utf-8?B?ZTdua2hxa2phZVQ0eFJGYUcyWG4yb2NWT2ZIQmNKU3NUVEFiZDRqVXljNTZm?=
 =?utf-8?B?SFM4VURQY2NURjBNYnlHK0VhVkl5dkc4czRDcWVVaFBOZjlMRVlDZmdydTQr?=
 =?utf-8?B?bm5uejB0ck02R0VsU05ldDlpUUovZURqYUZ1Y3pLQWlrVEUwb21vb3dVYnVw?=
 =?utf-8?B?MHRpYlpPbTZGT3JsNU9xYXFLWDJ0ckszMjhvT29oQkJlQVBHYVR0eHY0SHFC?=
 =?utf-8?B?RWpqV0F4Y3p2S0pWVG1JcDBFQ2pFN1plbGdTdndZblNBU09wNDlQZkJEeER5?=
 =?utf-8?B?S2RMblpQdFRYcWpmbVZqQXZQdStPVkpBc3l6bzQyeTIzd2xScnNlUW9aaEtQ?=
 =?utf-8?B?UmduWDdvNjFNMkxZY1dPZnNhZzNrcjhFKzJOMzZ4OVoyRUx0TkNLYnRIL1Ro?=
 =?utf-8?B?a0hiR3VIdVdod0JOaW1rTG9BSjYvUXZhQ3o5a3ZJaHVFMmFmdmI5S3FrRjZU?=
 =?utf-8?B?NWc5bG5paHA1TUhmSTBDVnhibXdhL3ZGWnlMU2RtK1U1dkgyd01sSVRQZzl5?=
 =?utf-8?B?eTMySXZ0eGxHbGs0RE5JR2VBZCsvZXYxNENQSTIwMDZaYndESzIrbUZRcGFN?=
 =?utf-8?B?aStXMDhKU2N1aHUrczNTOGUya1FSaVRWQmFqeUxoRmVjS0xJUFVGb2hhS1A4?=
 =?utf-8?B?MFI0bWxBaU02YUJzOXpOUVFaK044QWphcFN5M1BhL3MzdTFxbklVdllvSDUr?=
 =?utf-8?B?RzYzb0hkUi9nR2dQeWJKb1R5aGpVZXZUNWMvTDBMMVFCbVdjMnI5L1BKSGRY?=
 =?utf-8?B?RXJZNnZ5RGZiWlZPckJ3SXVkcDJ6S1ZVdU9rUmFzeXlrd1hxcTZwSE1FY0VT?=
 =?utf-8?B?VnhYOFpucng2ZVExSVJqaGEvODdpN2MzOURXS29oaTdlTHh1cnIzY0VtbjEv?=
 =?utf-8?B?SUY3U0FhcWs2VVZobm1BQjQ5MXo0d3FLYWJRaVBWOEZweDIvY2tzMDBjWWg1?=
 =?utf-8?B?NmZ5QnBKdS9pMDlicXpNbEtBK0lWTGhzSTNWT1R4b1M2bGlXSzdTS3dkMGpY?=
 =?utf-8?B?SzYvbXNCTXYvRjBKLzZtbW9UK05ORTlkS1ZvamMrRnJLWDh2dFlBQ0dyWjl2?=
 =?utf-8?B?T1J2QTcrdUE3U2JUTXB1Tm01QlNtdHExUG1EaEVNNG1vcFM1RmQ3bnRrRzlG?=
 =?utf-8?B?QnNOUGZVc1ZUV1MyOFlTSXRmSXNUbHdpdG1IMDhDcXFvbW5ERklaekJCTFpW?=
 =?utf-8?B?MmdvVERDNlNhdjlCQ0d5VE1Qb3dLQ1FuLyttNXdNQjUvWVhRUWxUTHdzK3Vp?=
 =?utf-8?B?SEE4OTI2SFQvK0lEZ2Q3NzJLNUxCdUZZWFd0TTVFNVl6Ujk4UTJ5L3hPRWJn?=
 =?utf-8?B?WUd0TG9kaVRCTTl0Z1hNNVBQQzlEYW5wanZJWWlYbGRPVEdTUnJZN0JrRTlV?=
 =?utf-8?B?RVp5Wm1XNVJmV0NwNFpuQjlRdVArMitJSDJFMDFKNUU0eHVlL0ZHcXJETE5Y?=
 =?utf-8?B?MStGZjhtSTVWbDByWE9TbzdzOFEvMThicDEway9xRW5jUlo2aHorNDRQanJX?=
 =?utf-8?B?SmYxVWl3NTdVQzRsVUhyNEp3ZWJQc25OODZjRUszWWJFSEhTRHYxR2NOUnBy?=
 =?utf-8?B?V1RMU1Fxdm1hTGcydlNCblVQc1p3PT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93692d1f-39ef-4bb1-398e-08de26a69aef
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 13:30:13.8937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWagbRJ2UL6JGPZUmFdnw0E3fvX0UPcy981Z6NnJqMfOiJw5F/GzSsAS+KExfh9rpVy0ys6tzoFEsX45NuGyoj5bDjiWmmT01GzaGz1BfDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8792
X-OriginatorOrg: intel.com

PiBJdCBhbHNvIGFwcGVhcnMgdG8gaWdub3JlIHRoZSBkZXZlbG9wbWVudCBoaXN0b3J5IHJlZ2Fy
ZGluZyB0aGlzIHBpZWNlDQo+IG9mIGNvZGUsIHdoaWNoIGlzIHNhZCBhbmQgcXVpdGUgZGlzYXBw
b2ludGluZy4NCg0KVGhhbmtzIOKAlCBnb29kIHBvaW50cyBhbmQgSSBhZ3JlZS4NCg0KTXkgaW50
ZW50IHdhcyBhIHRpbnkgZmFzdC1wYXRoIHRvIGF2b2lkIHJlcGVhdGVkIHRhYmxlIGxvb2t1cHMs
IGJ1dCBJIG1pc3NlZCB0aGUgY29uY3VycmVudCBtaW4vbWF4IHVwZGF0ZSBhbmQgdGhlIGZhY3Qg
c2NoZWR1dGlsIGFscmVhZHkgZG9lcyBjYWNoaW5nLg0KDQpCUiwNCkthdXNobGVuZHJhDQo=

