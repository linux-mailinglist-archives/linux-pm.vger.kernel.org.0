Return-Path: <linux-pm+bounces-8384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65588D3AAF
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 17:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D57D289FF6
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5BB17F376;
	Wed, 29 May 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cL8FrZrA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8C17BB17
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996106; cv=fail; b=mqe0FFd9EeiHi4FuCsPglV3vRzQL1kefv8dnnPhAveqUi0QAgbRjHRtF6Nd2VakMp9iBAxi7pyK3U6eybfTzUYXiLFqXkRNzXvOoWEjh6WoMURcCwGJA3NtzL/pR6c1boN8P4q6Y6/ZS72bFYn046VZFh4V7WWGTNyDyDEj0YqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996106; c=relaxed/simple;
	bh=9HwwixhQlSYZUKgDJE7rAtDyzUWls3l6N2kQMERLjtM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LpFQu3C75BsjnwGoW2Q9+uHEBei9KuUKSlMa7f42MltsscNCFcElWZZr5rnHBsSAQU8AJ8f4IU0qGm4l3cWticrK+A3sN1uPUYqPKq7TQm/zVTYqnqSm+xK07qgw1IYXICigtvJq2vi/PhklYQuP9nUk370G/dmT3RUB7X8sJ5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cL8FrZrA; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716996104; x=1748532104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9HwwixhQlSYZUKgDJE7rAtDyzUWls3l6N2kQMERLjtM=;
  b=cL8FrZrAyp3OmkrsjS5B2ibWe990ZNCHmpjR8bP4Z//BTDePa2vu3DsS
   Cn99ZAtNRAXl2GxSjzvAzsmeMVU3EZtUlfknY/VOn/At7FBWs9k5+AB9s
   kMuVZehfl05c6Xd84YwSFBcEcFEOAnIo2w0DwQTWL5iDL2yeejBgzuTnC
   I8VZ1SdV/+QfEIRua5AmqUY0K5jm2Mhzv0dBH1p51jozD5K/E5AQNArg6
   idKHuh7KJok6t6eBnG/fpSaMjMJYlwZuPgN90yUsjxI1Nv+FrkEVrwU1r
   QbJtcRReq3H/kFOhx2IqhwfK33Pdm/6Hi/tc0xphg1v5CGTRsYj2MDhqN
   A==;
X-CSE-ConnectionGUID: zbCKHB9pRNWqmOw77ZzXGg==
X-CSE-MsgGUID: bC3MsxmVQ16I3EsSnKZxyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13572699"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13572699"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:21:42 -0700
X-CSE-ConnectionGUID: OwGhEGnbTW+0gTkOnEfB9Q==
X-CSE-MsgGUID: aJrhY8rrSXyv5uMEoXY10w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35428674"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 08:21:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 08:21:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 08:21:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 08:21:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 08:21:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4u9kk2NnEqdBezwCtptol7lt1CBbhLB5iikH/zN+O0T4xzOelD5aPu/GQ6XU+QqQG1JD7a9I6W6hezvizafEEot2xxCpRlFODlJJZGJyenW2Q7bQI2LIybrRHK+fmNA3U5kXQWOgdH4i58UUcm74Vz1LqPEVzZ2aVw0Z2vR3PDfKZvWzPditZOJEgWfZ9/keIh+//bjcSnyAa46gSFCXrpZL8Mw9OKUithlIKzig3PiM7GJ9S2kZ+6o8lmz0lu0UonmEOPAxxhkaMeFwyQ8rDh5GlF4iDuhcbWx8mHttwlFT5iLwBk8DP2UbWB+w76VINqL48F78wyqSbUo0Kl0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HwwixhQlSYZUKgDJE7rAtDyzUWls3l6N2kQMERLjtM=;
 b=oJRyORcSZLou5MylX/cWcmjF8ZzbQ1+JNPXOpYKVQp0muX2GLjI4xteyvde+XUA5xVomjb+62wlobKDrBJp6t+ccAfFzv/yQkZ0N7aeduBY0ahUPLY6C5eLFKmgd7j6dogb2mvnj+LF5UPY/5tcysW/1e/paIN9xESllQPQiwh99DaaFr1RN00C7uaLVN0XoWAnyvLO/eR0U4B9U6RVsrlgpfc9axwFPlFpmdmlR5l/l5vjhkwH84EcrhYhh2i+HUxGo/TnhTckIFBiH4ofr/H/02XzxcV0kyagFL1p8+c3omR8C7Tt78d00Vyqk0g/E+sMCFwPrGu9uWXbQhAJ52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS0PR11MB8069.namprd11.prod.outlook.com (2603:10b6:8:12c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 15:21:38 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 15:21:38 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC: "hdegoede@redhat.com" <hdegoede@redhat.com>, "Brown, Len"
	<len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"mike@mjones.io" <mike@mjones.io>
Subject: Re: Dell XPS 13 9360 (Kaby Lake): Power button LED stays sporadically
 trying to S0ix suspend
Thread-Topic: Dell XPS 13 9360 (Kaby Lake): Power button LED stays
 sporadically trying to S0ix suspend
Thread-Index: AQHasa6KFS/oR0IvNEK/HUE4c2Jg37GuVGgA
Date: Wed, 29 May 2024 15:21:38 +0000
Message-ID: <2c0eae5ed4c60289d4fa09ec5a8251d0d7314256.camel@intel.com>
References: <83326c68-e1f9-43b3-8cc4-6cf88cfbdbfa@molgen.mpg.de>
In-Reply-To: <83326c68-e1f9-43b3-8cc4-6cf88cfbdbfa@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS0PR11MB8069:EE_
x-ms-office365-filtering-correlation-id: 9552bfe8-88f7-4fb1-f849-08dc7ff30940
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NVRKdm15RndkWTUxeDltRVFjU1Yxc3hiMVZGM0RxY2JzS2NCWWFMMTloUW9I?=
 =?utf-8?B?dnh5dVBjR05wUGpXYXlDbEFrUmp4N1NRRTFqUkQ4M21KQzdqd292ZUZqVUNh?=
 =?utf-8?B?UXlzRmNuT2ZpOXpxNlBhYmQ5bm55aVdKUDBwVXBSK2R4SVhtbjBuVGxTbm02?=
 =?utf-8?B?T2pWdXhHWTFNSmEyeU14Sk9pWGo3cGY0NW9IN01HYVhZd0E2YkJidjMrK2V5?=
 =?utf-8?B?aVprKy9LbEkwZy9uZVRXZ0UyZlpRU1U5Skp1ZXBHRmcwUTUvVVRHZjlNa1My?=
 =?utf-8?B?bFFNdGNDT0pSdHk4L3FXR3YrTUxxb2lNallUQW14VHFqa1RFdFhFTXdCRGt6?=
 =?utf-8?B?anV3SDlkLzlBSjNPSk5ZOUU2TXVGRjFhNHAyRVdLRGh1bWNrUE5NUVBOZVla?=
 =?utf-8?B?d2FzZHJPQXBzc1ZQK0F4V1dmUzdrdXdhdHQvNDdPcHJ6QlRxSXN4K1VIZHVr?=
 =?utf-8?B?bi9aYUxuYkxOYzg2WXplZ0YzcWRtNElhamYzTzh1VkFTVmhUek1GV2ZFand6?=
 =?utf-8?B?OFUrZFlvYzJydEpaUUlBU1Q3QStZRUFna01YR09xRmQ5TnRDeE1YYUc4bUNH?=
 =?utf-8?B?dHlQejM0Sk9sTGMzaFplQUtSRHNjOWo3Ump6TkltakFhQVl6cWxzeUMzWnVG?=
 =?utf-8?B?V3ppUWo1eTVobE1hODFKbVBQaG9oWjJDRWlYbnlyaHhGZ2pEQ09oZ1FiNklG?=
 =?utf-8?B?S0xWTk5rOHkrMVRDT2NVcGRGckNmZk81S1JBRm1LSjZUTEhUWldwSjVDL0JU?=
 =?utf-8?B?WWFwUGoxNk9tWWozanRvaWMwQS9xNGpxTWRJOHB4TDdOcitzeHM1dlNId2Yy?=
 =?utf-8?B?RkR2ZUJSdC9PbnEzWHY4cTRKR3pNZ0RScFdCZ0FRSlQ0K21tTTF5S255M3lT?=
 =?utf-8?B?VGRsOHNDdi9aWWxCTitYeEovZnJCNWVYUFkzUk1USmdUS01YOEVHajI3QUdp?=
 =?utf-8?B?QkFsekZ6QUppN2lEeStUdGVNa01LVVpwd1FhZEFWZ2pyOTVheFRvMjVUL2Jj?=
 =?utf-8?B?NGN4U3E3TVA3ZkNkRFlOeDRORU5pZnhuUVdyVm5xTmwvM0tCK09rNUZWMU5Q?=
 =?utf-8?B?UGRwUVZCYVQxOXhXUkJEMEt4SkZaRFBlVGszM1BsUXg2dzRZcVgrbENseFNH?=
 =?utf-8?B?SUlidUtmaUdOMzdYeUJXNHlhdEpIclRMWmZaR0NvTWRqekxZdy9XR2Z6MGt5?=
 =?utf-8?B?N2g1Qk9WL3VXU2Z2V1NjcHpSQ0Vab01PWVBFZkdKSzh5dUVUaEFjNTNMZVlB?=
 =?utf-8?B?OVBCVXpRQ0dxcjNBazVKTWFiT25HbVM0UzVtcHU4eEJxS3JVSk9DdzU0K3NI?=
 =?utf-8?B?MHZvZnRTcG9FcmlzenR5RTBaSUtWVVgzVURyN0V2YmthQ1dIczJOK0wyTVFR?=
 =?utf-8?B?OTh3Zjc2YWlSMWhGWlhkNlM2azN5MkhRUUJZZVJDZFVvdmprWDZFVzBMaEs1?=
 =?utf-8?B?NW1MZ1Z4THkwWkN6TXF5UCtCZzAwTmlrZUlzOFRXTUVaV09oZkc5UmVtb1ls?=
 =?utf-8?B?MkxURmowTk5md1FYbEhGN2J6NXBDcnZsVHAyUW1jOE5MYW1VeE1SQTNrVXl4?=
 =?utf-8?B?R1Q3aEF2ZnRCa2k0akZOZ3VUekVxY3Ftbnp4eU8rS1JzSUVhL3JXVXRtTzdp?=
 =?utf-8?B?OStNRS8xbXYwZUNGVFpsOHZScWw4a1dRdmxqVjFrMmFtOXpzYTRDUkxBYlQ3?=
 =?utf-8?B?KzJQekZCN2ZFODJKN3IzYlcvTHdlcGMzSmxScXA0QW85cEJpMjYydFREZnda?=
 =?utf-8?B?cllYTVhCQ3JUeUFTSDhaMU9FeE5qVy9IUnpSZFhGSDFxSG1LYjJ5NHM3K1Vy?=
 =?utf-8?B?QW9aQ2ZFMUdkOXdzQ3ZYdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0dwZUQyaWxHS3lidWhnQ1FQUkY1dVUvdk9oSjVIb24zOWhPVmNlbXg1aENu?=
 =?utf-8?B?RkFjUHRQS01JU29rc2RSWm9QbVQ5blNPOHlRbGwySGxxZ24vcXRwVndzclQ3?=
 =?utf-8?B?RFVwUmovM3ZyMDRFaDM0VEZXYVBuMkFlMHcreVBCcklwejVPSmJjak1hL2dm?=
 =?utf-8?B?VjJ2dGtubmxsamlBbTFMcVRnNEtnR0NOWXhVOVBhMUw5U0FDKy82NGZvMnp2?=
 =?utf-8?B?QWNiSkM1TXU3WTJxMWN0WEhVSWMwalBac0xvcmxxY29CZXEwZlJ2U3BOUTFa?=
 =?utf-8?B?YURYUC9tTmlVcWNwMEhQMFh2TmQ0cVUwZTdoUVYzU2tRMnNLYkNmdjVDa3ZK?=
 =?utf-8?B?U201ME9JWnErY1RKRzd1WEMyb20xOG50MXM2MVJ2WjBFVGQvTXZUWENpTGZ1?=
 =?utf-8?B?Z2p6OWgvRlRRWjcraDYzdmpCZG1tbTZuNkxDcG54N3Y0QncyNC91azhEMHpG?=
 =?utf-8?B?NndLa1JNMlREWHo0aE1BTGRINmR3L1pGcDZzSkgreG1xMUFNWFg4ZmRFd0c1?=
 =?utf-8?B?WUZaeis1VFdaYklhczRhOXpXSmV3ZjRNZi9KcWtEaXAveGh6b3BqSVJmM2Fs?=
 =?utf-8?B?MmNCem85VzdpQlpvcTdQYkpXN0pYSE1xMTQvL2kwcjhqSDdwa0tXM3dLQnlC?=
 =?utf-8?B?UU9JQUpNbm5JOUc1VFFVVVdCK0VXWkxCNVRsdjlrbkJWZGJTYmEyYkFCNXVG?=
 =?utf-8?B?UTI3eWNiTWd4cnR2amQwK0t6eVNraGxXRkRFQzN2TjlCNDFFb0xVUlJxRkJk?=
 =?utf-8?B?VzdPR01FQnlwUG9IejgzSXZoTkRzYWpucFZCUlZlNTVqWFphSENXaWhxMUlh?=
 =?utf-8?B?bUl4b1lhZCs4UXdsb2JRaWRmNUtKT0pkSnBuRnNqVTFaV29uN281anpuYzVz?=
 =?utf-8?B?WmVYMmpVS09sNnl0UUN1bXdJV1VvZkw3d0QxRXRudjRqczBhUEptOGJyZG53?=
 =?utf-8?B?MVBzUnpmeG1OZFdZa0NjS01wM2t3ejRwaFZFbVB3cmNpdkpqSmdZK2VYbStU?=
 =?utf-8?B?anJLSHQxd3BrV2dlWXdjYncwVlpMVjdnVG8xZ1pKWlYyUGlrYUVadXZSemtP?=
 =?utf-8?B?YW1IWllmYk5iZ1BQQ3dvYnE2bXFORHZLQ3hBaHI3MmNjVDlHcTc3ZWE5Slpv?=
 =?utf-8?B?RFEvQUtqc3BsQnEvdlE3TS9lRVM3NEI1eCt5M2ZnVlo4NkNOT0I5T3B5RnMx?=
 =?utf-8?B?TDUwclU1V2w5M1dONTVZd2FlSFNDRXZBbkVvblozNWtyTHJEZFFZNTJ4NlJI?=
 =?utf-8?B?UmdrMGlwUllncUdKUGJueXArNUkwOEdqRll5S2g1OFlLZnlXV3RhTnZIWmJj?=
 =?utf-8?B?bUJ2ZGV5aVZJcVV3OXN3MUo0MmlqeStLMVpOWHJ3QW8wVTFLMEE4TzNhMVVK?=
 =?utf-8?B?cENWVGJjMVdWdmdkZWgwU2FZRVZlRHhKaEExL3NLN01KTUdlanZhdEY5ZHZo?=
 =?utf-8?B?UzBkVjQrM3ZCRTdZSGtZWjRkcFU4b1gzeEViZ2VmMXFYZlVLa010VzJycUph?=
 =?utf-8?B?UEV0aElGUzN1Y3dmb0NZb0hFKzArQThHZnB0bkhub2E2eEJVTDZJaHFLeHhn?=
 =?utf-8?B?emVQaHRENVZNVk1CeWZxVnUreWNsWGNnbzhycUI5QktxeHNaN2hCN3hKQnow?=
 =?utf-8?B?WlR1REdVVWYrNi9KQ1V6V2VBdE83dk5VWTRjUXQzL3kvY1JLSzlRZXh2eVhW?=
 =?utf-8?B?Y1ZzQ1YrZzdic0paano1TmJJbGtOMU5IL1N4d2xIbzN3ZmxnbitleU5QOG1N?=
 =?utf-8?B?QkxOMjgzV0QrbkorMXNXNlZSS0ZJVk5VQWxWbXFjc1l3MDBsNG9pcHBmV1NN?=
 =?utf-8?B?L1BQblNHQjFJTUMxSUc2enlXOEtwc210ZzM2NVhTbGtOS2ZTYnFPdnFQdWRm?=
 =?utf-8?B?REZBZGFRZ3BpRG8yQlpmR1p3WnRJYUlBKzFNQ3lDaDk2S2dPQ0dSTHFBNVF6?=
 =?utf-8?B?RHFRdVZWNDNDUGNPT2M0a0pSZHZlV1VNNC9QbmVLeXM3QzBOSlgxTXUyV2RN?=
 =?utf-8?B?aCs2ZjNzQit4bFlER1ZHbmprQ05PcUk0ek1hdjJhcS9FL3hXMUtzalFzcUhE?=
 =?utf-8?B?Q0JkQVZYL2Z4UTE4bHVvVXRGRXcwaGF4MnlnbysrTHlkTmRCU3JSdEhuNWpj?=
 =?utf-8?B?bUpJQTlad1UzOXZrSmtBaWpTOE1hbFFMbnhFYy9BR3VRM3hGWCtCdldNSm9y?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43B81C61732B5146AF8916334C983AC8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9552bfe8-88f7-4fb1-f849-08dc7ff30940
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 15:21:38.8476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oSwmhUaT6/32x+D4AwvqAdo0Sh0LBPk+x6O/2mvWlIjRy78LJNKOZdzWkfzS554Juhgon2OeXatjPVlL/+8NvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8069
X-OriginatorOrg: intel.com

SGksIFBhdWwsDQoNClRoYW5rcyBmb3IgcmVwb3J0aW5nIHRoaXMuDQoNClRoZSBwcm9ibGVtIGlz
IHRoYXQsIHRoZSBzeXN0ZW0gbWF5IGZhaWwgdG8gZW50ZXIgUzBpeCBpZiBpdCBpcw0Kc3VzcGVu
ZGVkIHdpdGggaGlnaCB0ZW1wZXJhdHVyZS4NClNvIGEgZGVsYXkgbG9vcCBpbiB0aGUgZHJpdmVy
IHN1c3BlbmQgY29kZSBpcyBpbnRyb2R1Y2VkIHRvIGFsbG93IHRoZQ0Kc3lzdGVtIHRvIGNvb2wg
ZG93biwgZWY2M2IwNDNhYzg2ICgidGhlcm1hbDogaW50ZWw6IHBjaDogZml4IFMwaXgNCmZhaWx1
cmUgZHVlIHRvIFBDSCB0ZW1wZXJhdHVyZSBhYm92ZSB0aHJlc2hvbGQiKS4gQW5kIHRoZW4gZW5o
YW5jZWQgYnkNCnRoaXMgY29tbWl0IDkyOTIzMDI4ZTk3OSAoInRoZXJtYWw6IGludGVsOiBwY2g6
IGVuaGFuY2Ugb3ZlcmhlYXQNCmhhbmRsaW5nIikNCg0KPiANCj4gVGhlIGRpZmZlcmVuY2UgaXM6
DQo+IA0KPiAxLsKgIExFRCBzdGF5cyBvbjoNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqAgaW50ZWxf
cGNoX3RoZXJtYWwgMDAwMDowMDoxNC4yOiBXYWtldXAgZXZlbnQgZGV0ZWN0ZWQsIGFib3J0DQo+
IGNvb2xpbmcNCg0KICAgICBbIDI5MTguMDkxNzcxXSBBQ1BJOiBFQzogaW50ZXJydXB0IGJsb2Nr
ZWQNCiAgICAgWyAyOTU2LjMxNzY4Nl0gaW50ZWxfcGNoX3RoZXJtYWwgMDAwMDowMDoxNC4yOiBX
YWtldXAgZXZlbnQNCmRldGVjdGVkLCBhYm9ydCBjb29saW5nDQoNCnNvIHRoZSBzeXN0ZW0gZG9l
c24ndCBnbyB0byBhIHNhZmUgdGVtcGVyYXR1cmUgYWZ0ZXIgNDArIHNlY29uZHMsIGFuZCBhDQp3
YWtldXAgZXZlbnQgaXMgZmlyZWQgYW5kIHMyaWRsZSBpcyBhYm9ydGVkLg0KDQo+IA0KPiAyLsKg
IExFRCB0dXJucyBvZmY6DQo+IA0KPiDCoMKgwqDCoMKgwqDCoMKgIGludGVsX3BjaF90aGVybWFs
IDAwMDA6MDA6MTQuMjogQ1BVLVBDSCBpcyBjb29sIFs0NENdDQo+IA0KICAgICBbIDc5NzcuNjM3
OTg3XSBBQ1BJOiBFQzogaW50ZXJydXB0IGJsb2NrZWQNCiAgICAgWyA3OTc3LjY0MTQ3MF0gaW50
ZWxfcGNoX3RoZXJtYWwgMDAwMDowMDoxNC4yOiBDUFUtUENIIGlzIGNvb2wNCls0NENdDQoNCklu
IHRoaXMgY2FzZSwgc3lzdGVtIGlzIG5vdCBvdmVyaGVhdCBhbmQgd2Ugc3VzcGVuZCBpbW1lZGlh
dGVseS4NCg0KPiBEb2VzIGludGVsX3BjaF90aGVybWFsIHByZXZlbnQgdGhlIHN5c3RlbSBmcm9t
IFMwaXggc3VzcGVuZGluZywgc28NCj4gdGhlIA0KPiBMRUQgc3RheXMgb24gdW50aWwgdGhlIGRl
dmljZSBpcyBjb29sZWQgZG93bj8NCg0KeWVzLCBiZWNhdXNlIHdlIGFyZSBzdGlsbCBpbiBkcml2
ZXIgLnN1c3BlbmRfbm9pcnEoKSBjYWxsYmFja3MgYXQgdGhpcw0KdGltZS4gQW5kIHdlIGhhdmUg
dG8gYmxvY2sgc3VzcGVuZCwgb3IgZWxzZSB0aGUgc3lzdGVtIGNhbiBvbmx5IHJlYWNoDQpQQ3gg
YWZ0ZXIgc3VzcGVuZGVkLg0KDQo+ICBJZiBzbywgY291bGQgdGhpcyBiZSANCj4gYmV0dGVyIGxv
Z2dlZCwgc28gdXNlcnMga25vdywgd2hhdCBpcyBnb2luZyBvbi4NCg0KaG1tbSwgYW55IHN1Z2dl
c3Rpb25zPw0Kb3IgaG93IGFib3V0IHRoZSBjaGFuZ2UgYmVsb3c/DQoNClRoYW5rcywNCnJ1aQ0K
DQotLS0NCiBkcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfcGNoX3RoZXJtYWwuYyB8IDUgKysr
KysNCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfcGNoX3RoZXJtYWwuYw0KYi9kcml2ZXJzL3RoZXJtYWwv
aW50ZWwvaW50ZWxfcGNoX3RoZXJtYWwuYw0KaW5kZXggZjViZTJjMzg5MzUxLi45MWE2MTQ5ZGYz
NTAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfcGNoX3RoZXJtYWwu
Yw0KKysrIGIvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3BjaF90aGVybWFsLmMNCkBAIC0y
OTgsNiArMjk4LDExIEBAIHN0YXRpYyBpbnQgaW50ZWxfcGNoX3RoZXJtYWxfc3VzcGVuZF9ub2ly
cShzdHJ1Y3QNCmRldmljZSAqZGV2aWNlKQ0KIAkvKiBHZXQgdGhlIFBDSCBjdXJyZW50IHRlbXBl
cmF0dXJlIHZhbHVlICovDQogCXBjaF9jdXJfdGVtcCA9IEdFVF9QQ0hfVEVNUChXUFRfVEVNUF9U
U1IgJiByZWFkdyhwdGQtPmh3X2Jhc2UNCisgV1BUX1RFTVApKTsNCiANCisJaWYgKHBjaF9jdXJf
dGVtcCA+PSBwY2hfdGhyX3RlbXApDQorCQlkZXZfaW5mbygmcHRkLT5wZGV2LT5kZXYsDQorCQkJ
IkNQVS1QQ0ggb3ZlcmhlYXRzIFslZENdLCBTMGl4IG1pZ2h0IGZhaWwuDQpTdGFydCBjb29saW5n
Li4uXG4iLA0KKwkJCXBjaF9jdXJfdGVtcCk7DQorDQogCS8qDQogCSAqIElmIGN1cnJlbnQgUENI
IHRlbXBlcmF0dXJlIGlzIGhpZ2hlciB0aGFuIGNvbmZpZ3VyZWQgUENIDQp0aHJlc2hvbGQNCiAJ
ICogdmFsdWUsIHJ1biBzb21lIGRlbGF5IGxvb3Agd2l0aCBzbGVlcCB0byBsZXQgdGhlIGN1cnJl
bnQNCnRlbXBlcmF0dXJlDQotLSANCjIuMzQuMQ0KDQoNCg0K

