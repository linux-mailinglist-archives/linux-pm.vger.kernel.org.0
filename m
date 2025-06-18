Return-Path: <linux-pm+bounces-28931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAABADE1A3
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 05:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEE61899930
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 03:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694AA1D5CEA;
	Wed, 18 Jun 2025 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d77IcfJp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97B239FD9;
	Wed, 18 Jun 2025 03:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750217331; cv=fail; b=Rz936j8HtQyCk3MEBMShYbt9wK2ozmZoK4mb5Hv8St2ZLuBVoYm1vXsWxtXirpuzfpxQi56kXgnZTRjkVZuanMKJMLJvYEbC+PtQipqJIIFFZz1uc0OTlqyYYmsbMWkVoB/uAdT8czNq4aHHSTHAMca2LYPoVYgGNle4QvKd8LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750217331; c=relaxed/simple;
	bh=6gDxaIcb4X579FBIUUZWCoJwjKnOI1ZFVyJIiSFlcH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rG41Bs7lTvrTJdwlo+ncf/eJbgUsV1eVCOjQcXgkM0xLOsYzZ4TUDz+g08XbGZwxUQUvK/rcj8P2y00GUmN2aBq/CGJbDEabx4JhobOD0d0p7Qy6hVVNfM1EC7MMMDDcX/9rLZbuPfY5OCwkE2q53SuxXt/U/k7uhEQLplgJBqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d77IcfJp; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750217330; x=1781753330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6gDxaIcb4X579FBIUUZWCoJwjKnOI1ZFVyJIiSFlcH0=;
  b=d77IcfJpS/7AWkeC8wjsYFd0ilAhAndPw6E9zfiXvvt8QR0OQ1iqoho8
   Oe0L8P/pQUu9McDfSX/6/eSm11V5PhF+VaEKwk+0iUNZAzuq5jmRLuIsO
   Cz9T56KOzWamnO1pr3778ySSzW3cyari0Oxhm+PGYVrG/tiJcfHwXtTHe
   BD7jVLcCUc6uutGvD+jHZb7afBVEFa+P0KJhFPgJdlBmsLY/DIRZWYEhG
   iPszAesUY0MTdqPtmTvO1krq/VavkAAUZ7lzORu+2GVcmOcNzrmLhm5b6
   iwuJKSrw0IyP61vgsM5APoyvLrBzUpcgfX8yRrB3u0FK7HigXpbMlT+AU
   w==;
X-CSE-ConnectionGUID: e/0xeFm4SSCYYhUbJ0K+1A==
X-CSE-MsgGUID: ZGTM3AF6TxOxy18L5s7+2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52503056"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="52503056"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 20:28:50 -0700
X-CSE-ConnectionGUID: qdMyTRp6TSCdxN6p52QrCg==
X-CSE-MsgGUID: c/UqGeSWTMq8KP7xu8HkRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="180138572"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 20:28:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 20:28:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 20:28:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 20:28:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bk3C/SNM87p6lcFXK4nRGVyiZNiXR1USjkwyTweEbRwGcUiG47CyLq8xw81pgRRt0o2G+BR+P3UArTArfR62deEqBbHFRv0pfUPANSEKSHOjcjR6ZybbZxfC/ZUaI7B41vAGgIQi09To7Fh7lJ85aEaLuspAWLbEhx4ePspzbXKQqlyX69I56qz8xiPYr0K4nvR6ghfrYKzxOIOq9FpzuU6Si/iqdWSBz8P8Za8uO/JfZQJ2fVuDNUQ/4/sCUgR28vrltHUP9SZo+FNIHxDHqghxSq7gq5mU+JDQfmJSUbCPLoXqz/RqJfwCd44LXRIc8g46TW1hh2/Q5zyknUbmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gDxaIcb4X579FBIUUZWCoJwjKnOI1ZFVyJIiSFlcH0=;
 b=YBhX/EfdZq0JxRCs2/A/TJzRUvZMf2GtWLCY06N45L+GKZ3mPELL9EDB9vYSphjRzIZ6TKn9ISwhLymXI0ie4G36XdjWEqPKniNGGBv2OJt7U3hvGaz0T0pwzYG+Clg7kU5spZ315mQvCCtNIO4JLlDkvX+MYplEdem8SEvY8j1KoVNCrRY7xmtLKvV/ogr4jiAtl4p3oLxPgcPGPNpR6RF7GfNrUciWVkYnTmqDUBnSHBdpCaC7zjOXhIXw0jqT16UBTRElDejnC2y+Ma80DLvxwrxI3wg2nIwskzfz2JVhmF/7HWXbSCQzxNvy4B+7aYlO0b7ai56Y12K6eU0oag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by IA3PR11MB8918.namprd11.prod.outlook.com (2603:10b6:208:57c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 03:28:18 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8813.024; Wed, 18 Jun 2025
 03:28:18 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "calvin@wbinvd.org" <calvin@wbinvd.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>
Subject: Re: [PATCH] tools/power turbostat: Fix MSRs with CONFIG_MULTIUSER=n
Thread-Topic: [PATCH] tools/power turbostat: Fix MSRs with CONFIG_MULTIUSER=n
Thread-Index: AQHb3NL2i2J5gxlD0kSQij6sbmPYl7QFAs+AgAA0rYCAAxDrgA==
Date: Wed, 18 Jun 2025 03:28:18 +0000
Message-ID: <a813fd9a41dcfc0afc8b68f9ac8d3e07d0b96530.camel@intel.com>
References: <81f4c402d1fda7c2419aac1148061a0789112e76.1749849645.git.calvin@wbinvd.org>
	 <99f09d35e30fa335508823e9848a3365936ac9b3.camel@intel.com>
	 <aE-f35kOO0TywX5K@mozart.vkv.me>
In-Reply-To: <aE-f35kOO0TywX5K@mozart.vkv.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|IA3PR11MB8918:EE_
x-ms-office365-filtering-correlation-id: 2c2b89d3-1930-4343-1608-08ddae182b30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Zyt4THZETWRSQTR3dDZBNUJpdDdWQnFmaFR5M1JTRnNFVFhnekhrR3djblhT?=
 =?utf-8?B?MHZBUjgrZmhjck1DWUVlU2djWTZhM0RyRFNhRjRtQ0hYWURRaUFvT3pCa1hr?=
 =?utf-8?B?MzV3bkgxVk1zQVFyWWFlRVhaT0IyekM3Zm1CeVorTHpTNFR2UUJqZzVDOWIx?=
 =?utf-8?B?T0doL0ZlTGN4RVVXSWg3UVRISU9JRTBTaS9QQThaWnQ5dTNGZEdmNDRFS0RV?=
 =?utf-8?B?T0ZtMFFjZ08xNlRJcitwNFdrTjNKQnhRVU96THFJZndabXBjK3NJVjYwRlNk?=
 =?utf-8?B?SnJUNFR6Z0xrVUpWQnhCWk9CbnhOZ2FUNm9lWGFmWWQwU0x0RnZGay9wcitx?=
 =?utf-8?B?OXRHTHhLVnIxREhGeVNvT3I5S2Z6Rld4Qm5FQ2Z1VkpiV1VJYTJBU01VUTlo?=
 =?utf-8?B?SHVOa0RDaVZPK2dTbktCaDJDUmdxSWpWeHpNN0R5VWF6dEczZDRHc0IvUmtv?=
 =?utf-8?B?VDJRc0VmUUUxZDB4Z1pLQ2NyeUVKM3d1Qk5ZdmxENUdmRFpwenFwVm5PWnBG?=
 =?utf-8?B?NUdNQ1k3QlA0cUo0eVFFeE9vbGJlNURuMVRUNkg5ME5aNTFUOFlwT3JMa1U0?=
 =?utf-8?B?TURMNGdjVHlJa1BQbWdLTXBodGVGYzI5OW5zVVY4SkxhRm9BeDRQbndabVc3?=
 =?utf-8?B?NmVFZURUVHN3dnZzU0c4YVp6aFc4bHRpYlpBaFFvdzB1VC9jSXZzUUFZRVds?=
 =?utf-8?B?aWF0ekRPN0s4K0pTRU5lTzNNaWhsMmNGNThXNm83SGtjbDcxNmFNTG83MlpF?=
 =?utf-8?B?U05pM3RlYWlKdnNMT0c2bDBaazhKVnRUMlp1Q3g3OFN3S1VWWXUrRjFVMmsx?=
 =?utf-8?B?ZklwckNQZ2loRUkxOForTjMrbmlWOVc4M3ZFWVhsR2MwMU5sanJCUkcrTkUw?=
 =?utf-8?B?eWJvV09PYThKZW1kSlkzb29ldXVTVmJTdGUwNlkzdERTWHBHaytYSkpreXQw?=
 =?utf-8?B?SU9sSE11RSt2enlpZ1lHS1dNNzE3Q3NjcmhMT3BEQ05EMlpnRnlXZUM1RUsw?=
 =?utf-8?B?QWhvcGk4Z2thMUYvVWVYMmRZWUY1TDI5dHIxa2dPMlFQTjZCTnZGa0ptdHd3?=
 =?utf-8?B?VmFkR045dm5GcURhUWt2MUFRbUlQQ0lIaGxpbmkxN2hnRDJQK0s1Z243MGtD?=
 =?utf-8?B?OFZsbjlzUEJPOThTWGY2aGhTeVpVMXMyd29zL3hJQ1cxSVA2RHhZRmtRK0hx?=
 =?utf-8?B?MEswMERHY084Sk9FVjN2dWdQRnhPcE5ZTTFNSk9VakRRc2YxOTQzc3dOU2lM?=
 =?utf-8?B?SXdGYmhSL3ZIeWUzbTdVNE1aME1JWXJNNFFIRVdQK2VSRUNoblFuTFY0S3Ar?=
 =?utf-8?B?bXp5SXN5RGF1QTBoeElWTEZZQWpNbG5IcmJ5U2k3eXpCUVl4UmREdlllOVVO?=
 =?utf-8?B?SkNzVC9jbXlra28rb2NNZVJBdUdudGlRR0VhTWtjOFRBK1VRZHV2NFN5ZUVx?=
 =?utf-8?B?QVMzUDFka01vaktJQ3pwbERDT0xwYWRxd21IS3JBSmdxTlNySHFrMzY0QnE1?=
 =?utf-8?B?NkNUa1BTOU91OFBWREdaUXBqNzNXUGUrZkp2NVZzYVJhZTFmY05leXFvdGhP?=
 =?utf-8?B?VG1BN3R6NkVFL0VkbklXZ2ZYRW4wTUp2NkdsRitaS1VDbCsvT29LRXhsVExh?=
 =?utf-8?B?QzlveEpFUWVSNmpOY2tuU3MxNEZiSHZSN243R3dtOU10akYvalNuMXczeEI1?=
 =?utf-8?B?VTV5VjBsa09QMEQ5MDBaL1BMa1d6L2xUbFhUSERSL05Ubkh0blN5Znc4aHdG?=
 =?utf-8?B?UUpYN2NBRE5pTSt1dXRsME5rTnF5MnZISWJTVlYyOU5HOEwrWk4wTXhpRWYz?=
 =?utf-8?B?K1hGek1SYzB4cU1FcGp4bERHUzQzNFdYOG1NL2pWdUY0YUZ4aUhDYW9zZ25i?=
 =?utf-8?B?anNMYll1TmlRRUpzckdjbXNBWTRERjMyUlpjWnArUU1RalRNblJ2VGZlYlRn?=
 =?utf-8?Q?+8srG9IJO9Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um9xSVNZRUYvZkdBNkdEQ0tSRlFjZ2xtNDlncWY4T2poeXZQVkpiZGdOSEhk?=
 =?utf-8?B?TkxTRmVvbXd2ekFLdFl2WDIwbkdiMVF0MHBEZC9NQml6Nm9oZDA5bEphRncw?=
 =?utf-8?B?cVdXS0ZnbkFpNUVFUTkvTGJBRE8xUlV1emtmRUFlTFFUZjFXN0RxMlQwSkZ3?=
 =?utf-8?B?N09ZVHkxdTRsOE81UUF3UmJFQ1doWDdkSFVyRVV0bHYrdkpiVU1QY0VLYnRa?=
 =?utf-8?B?Mm4yMFJjUUhTNU9kTmVZZ0lUVmFjWDZhU0YwM2lSWEVtMSt6RnNDZ3M1bDNv?=
 =?utf-8?B?c2pDMTRJUjhoTUxzVWRBTXhBZStxYnBld2Mxb2lrSFc4MEdqR0MwZDMvUWgw?=
 =?utf-8?B?cVhuZUtCWDIyVzM3bXJWLzJrTERBL09CN0h2YkRFUi9GVklyZEdaMDdlaUV0?=
 =?utf-8?B?WWN1OTBZcS83RXZYSlRMa3F5RkxGTHZQZStDcmhFOFcyZUJ4T0lqYStXaU04?=
 =?utf-8?B?QjNQUVloRUdIekV0SzdDZ0c3WEc3TWdnMkdGZ1RLVjJzbXBTdm00ZHAyWWdT?=
 =?utf-8?B?aS9YSnN3MHd1VDBybWhKMnY5NTBqMytvWVUwVmlqS1BPbm9YQnhwQjE5d2ZK?=
 =?utf-8?B?UGJzRmkrUS9oWDdTN1ZKNXNEVzIvVzM3WkhaNEF6MWRLR2wyQ1YzZmdqQjBC?=
 =?utf-8?B?NlBJTU9iYnBMMUZIK0ZRdUFTemNsSFlmZjB5T0ZTMnZFdit5VkN6QjdBVTdr?=
 =?utf-8?B?Ny9nOWNUYWQrb1JMMXR6emQvemlsSmJ4ZUlaR2RneG9sclcwTWpsTEl6OVh2?=
 =?utf-8?B?OUJ2OGhxb2wwQ21tOGRkQTJEVTgvK3Y0N3MvVHdzSkpwRWp0VkRKajdDZTN1?=
 =?utf-8?B?RFBQMTBmNSt2a0VacTh5TGNiYXpiNldicmR1YWdxcUM4MThoNUtJcWJOclEx?=
 =?utf-8?B?UU02T05GQ2gzRWk0R01EL0l5VnhjS2tSb0ZVR1hNd0FqVjA5RndOZ0JoWk94?=
 =?utf-8?B?TWxYUkY0S1BPVTJzdkdwdllsS0FqYkt3VnlXUWtJQWtkalJZQnhuWStQMjN5?=
 =?utf-8?B?QTM2MThoZmxHdWdWWW5MK2JxdUpSdG9Pa0ZydldhQmM5SVAvdkZ5R2RSTmNu?=
 =?utf-8?B?MVc3QUlnY0NVZkorYmV2amdhdjJ6c3QvS3I5bVc3V2ZlRFc1NkRaZGdYZll6?=
 =?utf-8?B?cUNlSWFXb0l4OVBKUlZUWVpsc0lWMGF0bjJCY1FoU0crRXRJdjlZcE8wV3lT?=
 =?utf-8?B?VFpmdm1wK3NqdmF2T2thR1I5UXRrRThpNkNJc0JuSzV5eTB6YzQwaElXTlpO?=
 =?utf-8?B?N1ZXNHlQaEE1dXRrWm1iTk1UeklwQ2JLQWFyZ25nVVd3Q3BxZHdCVnV1dFZh?=
 =?utf-8?B?MmVBc3YweUZobVRUdzZlT1phZzBBdGluNkJPOENaUm1xWjNkUm1JWlNFNVI1?=
 =?utf-8?B?VDYwaWRWL3pRTjlHREdUVnFyVzhWYll3UGV0bytaZjVrZWVSemlJeS9YV2RS?=
 =?utf-8?B?YjZTNTFsRkF5UjBKbmF4aU4reTlqR0Y1ZmhEc1RmT3Mra0YxSHVLYlU4TnVG?=
 =?utf-8?B?ZnV4V2I5ZTVjYXZ2QzZWTE52QU9hL1pOcWdUZFBoVEtWNzRCa29MeGNnUERP?=
 =?utf-8?B?UEp0K3FpNEd3L0tCQmw0SW1CeUVHY0FDRDRnS25ocVpnb05zY1o5QjQvMmlB?=
 =?utf-8?B?N2VNd1QvcHNwNUJJNExCSTZkUG50QXp6UTk0a2x5SWZ4WDBwQXVZd1NRUzU5?=
 =?utf-8?B?NzhSbEFMTVdhZUd4bFJXbXNjT1M3eXFvNU44QXBGQkd5QmF0VENiUHA4SmtH?=
 =?utf-8?B?TWFMTTBPYW90VDQ4WVdJTFJlNVZUZGFUeFMrNWFaMFhzOVI0T1kyZDcxelhF?=
 =?utf-8?B?YW5oRjQzUWN1YkxWNlBQN2FvY1FNQ2txNll2OVNybXZwM2RBbFFHd010dnFT?=
 =?utf-8?B?LzU0U3NYajkrWU80dlZDamNsdzhkL014N0wvaEg4MXBqeTM2cGlNT0Q5Tmpk?=
 =?utf-8?B?SHhrWmFQUWZjeFpSMEpTRy8vLzRtb0FLUHBKQjJEM01xU1Y1bkFab29nUVJD?=
 =?utf-8?B?V25iTzNwWDMzMU93WnM2WmFNYjc4c2hmR3pka1lHY2VEVGtVSG1NTlFnWHll?=
 =?utf-8?B?VHhaV1NYenpDdUxZN29iaC95S29qWklhRmp4d3JJUEp2SlpJbXg5UTZTcGFX?=
 =?utf-8?B?WkFpTFdJUUFUSXRlUzFhb3BLUDdzc0ozVDJkbUlGWElHZ1RZNjVDYzdOelBT?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AF13F1E29DD8246A740964101231094@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2b89d3-1930-4343-1608-08ddae182b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 03:28:18.2981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rs6dbDqMVjOptYbRhzIkLG4ktUpt8E+FC9ocUZgDQx+0KDCbh0km4qjIe2jzL/6wjrky2bGMhlBvqUPD8jHxfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8918
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI1LTA2LTE1IGF0IDIxOjM4IC0wNzAwLCBDYWx2aW4gT3dlbnMgd3JvdGU6DQo+
IE9uIE1vbmRheSAwNi8xNiBhdCAwMTozMCArMDAwMCwgWmhhbmcsIFJ1aSB3cm90ZToNCj4gPiBP
biBGcmksIDIwMjUtMDYtMTMgYXQgMTk6MjAgLTA3MDAsIENhbHZpbiBPd2VucyB3cm90ZToNCj4g
PiA+IEhhbmRsZSBFTk9TWVMgZnJvbSBjYXBfZ2V0X3Byb2MoKSBpbiBjaGVja19mb3JfY2FwX3N5
c19yYXdpbygpLCBzbw0KPiA+ID4gdHVyYm9zdGF0IGNhbiBkaXNwbGF5IHRlbXBlcmF0dXJlcyB3
aGVuIHJ1bm5pbmcgb24ga2VybmVscyBjb21waWxlZA0KPiA+ID4gd2l0aG91dCBtdWx0aXVzZXIg
c3VwcG9ydC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2FsdmluIE93ZW5zIDxjYWx2
aW5Ad2JpbnZkLm9yZz4NCj4gPiA+IC0tLQ0KPiA+ID4gwqB0b29scy9wb3dlci94ODYvdHVyYm9z
dGF0L3R1cmJvc3RhdC5jIHwgNyArKysrKystDQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL3Rv
b2xzL3Bvd2VyL3g4Ni90dXJib3N0YXQvdHVyYm9zdGF0LmMNCj4gPiA+IGIvdG9vbHMvcG93ZXIv
eDg2L3R1cmJvc3RhdC90dXJib3N0YXQuYw0KPiA+ID4gaW5kZXggOTI1NTU2YjkwNzcwLi5mN2Q2
NjU5MTNhNTIgMTAwNjQ0DQo+ID4gPiAtLS0gYS90b29scy9wb3dlci94ODYvdHVyYm9zdGF0L3R1
cmJvc3RhdC5jDQo+ID4gPiArKysgYi90b29scy9wb3dlci94ODYvdHVyYm9zdGF0L3R1cmJvc3Rh
dC5jDQo+ID4gPiBAQCAtNjQ5Niw4ICs2NDk2LDEzIEBAIGludCBjaGVja19mb3JfY2FwX3N5c19y
YXdpbyh2b2lkKQ0KPiA+ID4gwqAJaW50IHJldCA9IDA7DQo+ID4gPiDCoA0KPiA+ID4gwqAJY2Fw
cyA9IGNhcF9nZXRfcHJvYygpOw0KPiA+ID4gLQlpZiAoY2FwcyA9PSBOVUxMKQ0KPiA+ID4gKwlp
ZiAoY2FwcyA9PSBOVUxMKSB7DQo+ID4gPiArCQkvKiBTdXBwb3J0IENPTkZJR19NVUxUSVVTRVI9
biAqLw0KPiA+ID4gKwkJaWYgKGVycm5vID09IEVOT1NZUykNCj4gPiANCj4gPiBDYW4geW91IHBv
aW50IG1lIHdoZXJlIHRoaXMga25vd2xlZGdlIGNvbWVzIGZyb20/DQo+ID4gDQo+ID4gSSBkb3du
bG9hZGVkIHRoZSBsaWJjYXAgc291cmNlIGFuZCBkaWRuJ3Qgc2VlIGhvdyBFTk9TWVMgaXMgc2V0
Lg0KPiANCj4gSGkgUnVpLA0KPiANCj4gV2hlbiB0aGUga2VybmVsIGlzIGJ1aWx0IHdpdGhvdXQg
bXVsdGl1c2VyIHN1cHBvcnQsIHRoZSBjYXBnZXQoKSBldCBhbC4NCj4gc3lzY2FsbHMgYXJlICNp
ZmRlZidkIG91dDoNCj4gDQo+IMKgwqDCoA0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9rZXJuZWwvY2FwYWJp
bGl0eS5jI24zMg0KPiANCj4gLi4uc28gdXNlcnNwYWNlIHdpbGwgZ2V0IC1FTk9TWVMgd2hlbiBp
dCB0cmllcyB0byBjYWxsIHRoZW0sIGFuZCB0aGF0DQo+IGVuZHMgdXAgYmVpbmcgcHJvcGFnYXRl
ZCB0byBlcnJubyBpbiB1c2Vyc3BhY2UuDQo+IA0KPiBBZG1pdHRlZGx5IGl0IGlzIHNvcnQgb2Yg
aW1wbGljaXQuIE1heWJlIGEgYmV0dGVyIHdheSB0byAiZml4IiB0aGlzDQo+IHdvdWxkIGJlIHRv
IHdhcm4gdGhlIHVzZXIgaWYgdGhlIGNhcGFiaWxpdHkgY2hlY2sgZmFpbHMsIGJ1dCBzdGlsbA0K
PiBhdHRlbXB0IHRvIGFjY2VzcyB0aGUgTVNSIGRldmljZXM/IEkgY2FuIGRvIHRoYXQgaWYgeW91
IHByZWZlci4NCg0KaWYgY2FwX2dldF9wcm9jIHJldHVybnMgLUVOT1NZUyBvbmx5IHdoZW4gQ09O
RklHX01VTFRJVVNFUj1uLCB0aGVuIEkNCnRoaW5rIHRoZSBwYXRjaCBpcyBnb29kLCBtYXliZSB3
ZSBqdXN0IG5lZWQgc29tZSBtb3JlIGRldGFpbGVkIGNvbW1lbnQuDQoNCmFuZCBJIGRvbid0IHRo
aW5rIHdlIHNob3VsZCBjb250aW51ZSB3aGVuIHRoZSBjYXBhYmlsaXR5IGNoZWNrIGZhaWxzIGlu
DQpnZW5lcmFsLg0KDQo+IA0KPiBUaGF0IGlzIG15IG9ubHkgcHJvYmxlbSBoZXJlOiB3aGVuIGNo
ZWNrX2Zvcl9jYXBfc3lzX3Jhd2lvKCkgZmFpbHMsIHRoZQ0KPiBjdXJyZW50IGNvZGUgZG9lc24n
dCBhdHRlbXB0IHRvIGFjY2VzcyB0aGUgTVNSIGRldmljZXMgYXQgYWxsLCBldmVuDQo+IHRob3Vn
aCBpbiBteSBjYXNlIGl0IHdvdWxkIGFjdHVhbGx5IHdvcmsuDQoNCk9yIG1heWJlIHdlIGNhbiBj
b3ZlciB0aGlzIHdpdGggdGhlICItLWZvcmNlIiBwYXJhbWV0ZXI/DQpzYXksIGRvZXMgaXQgbWFr
ZSBzZW5zZSB0byBhZGRyZXNzIHRoZSBwcm9ibGVtIGJ5IHJ1bm5pbmcgInR1cmJvc3RhdCAtLQ0K
Zm9yY2UiPw0KSSdsbCBsZWF2ZSB0aGlzIHF1ZXN0aW9uIHRvIExlbi4NCg0KdGhhbmtzLA0KcnVp
DQo+IA0KPiBJIHJlYWxpemUgdGhpcyBpcyB2ZXJ5IHdlaXJkOiBpdCBjYW1lIHVwIHdoZW4gSSB3
YXMgcmVjZW50bHkgaW5jbHVkaW5nDQo+IHR1cmJvc3RhdCBhcyBwYXJ0IG9mIGFuIGV4dHJlbWVs
eSB0aW55IGJvb3RhYmxlIHV0aWxpdHkgaW1hZ2UuDQo+IA0KPiBUaGFua3MsDQo+IENhbHZpbg0K
PiANCj4gPiB0aGFua3MsDQo+ID4gcnVpDQo+ID4gPiArCQkJcmV0dXJuIDA7DQo+ID4gPiArDQo+
ID4gPiDCoAkJcmV0dXJuIDE7DQo+ID4gPiArCX0NCj4gPiA+IMKgDQo+ID4gPiDCoAlpZiAoY2Fw
X2dldF9mbGFnKGNhcHMsIENBUF9TWVNfUkFXSU8sIENBUF9FRkZFQ1RJVkUsDQo+ID4gPiAmY2Fw
X2ZsYWdfdmFsdWUpKSB7DQo+ID4gPiDCoAkJcmV0ID0gMTsNCj4gPiANCg0K

