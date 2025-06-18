Return-Path: <linux-pm+bounces-29021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E582ADF9C4
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 01:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C03F7A1CFF
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 23:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713FC280025;
	Wed, 18 Jun 2025 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWWD58lh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5427FB2E;
	Wed, 18 Jun 2025 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750289604; cv=fail; b=E+xPnZE/0kZKU/SRhp3Y3taPLtw8uay/TqK2JwfJCHLDPe9wqvC6IqFRloWBQciIzo0Vw6uF6oWz/GyFMrCzJdw/0DJbDC7hpGIb5Cd76c3dn1oCfaSsh55JRMAR3mU11pQwlGKvJVPL3n3QjWZvkxOfw1+fkJEFaz5nwOl9rDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750289604; c=relaxed/simple;
	bh=SgUvsI9E8JZKPsdV/VU6EIKqsliwfZtiK8pMUk917oA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dd4ewlu5XbzVcjp7CxyR9leniErc/7sQ2h2IFbxWOn3YeagI4DvGyjzq9DGWEEhXidk8ETEoNxZ9VxPQzyJuPVQWe+ri2VTkbDMjEKSGFKiplCHJT19zGkpZMIr/We0Gqjo6v7tAQUe/Nz7fI+oYD8RdW3OUFQu5kbzmUuVrk6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWWD58lh; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750289603; x=1781825603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SgUvsI9E8JZKPsdV/VU6EIKqsliwfZtiK8pMUk917oA=;
  b=GWWD58lhwqVvNqyaEfcRkmvbDRrOrTse8iNDQCOS6TCdSS6PzND/JtFk
   ooww8mK5pm6Wyk9eRmbyryxVNEXvrTDdsXQYvRD8j5bb1ZeuWeoOCE5Mk
   bVwuAJ9fiNY9nkIV+NDNhwApS4M0cZQsErWxahKL8IZTXtEBuPHQDs3+C
   SG+kmNpIZbPMAInJuzkuZJTt8GkJxfX8eijpXSkdp7Zt15D7oNyfELzYw
   pLwSyTyIoGT6BaDu7mo0NvQjjPQtgPAaA3MS4UOijHYudHeWaAKbPp/o0
   xx+Fvmuv6on1KvejFgKe5+iM8Mj9FLxj7KH7a4kzx6Lx9/5a/TdFIght0
   g==;
X-CSE-ConnectionGUID: AbH40TS4Si+ana2jnOBHwg==
X-CSE-MsgGUID: 3pfLlsFiQ/iZGMFW+BZvOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="75060403"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="75060403"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:33:22 -0700
X-CSE-ConnectionGUID: FKJQ8OvnQ9iflMXY5pWeiA==
X-CSE-MsgGUID: HCli/Td8TlmN9TACrwDfEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="181264578"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:33:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 16:33:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 16:33:20 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.59)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 16:33:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj42dH+K6IppYmIHbUfH8rJTaklOXgbJT0/GdK5lh4Z5p+vjDFcGnqtahzN0kYsKwJlI8unQ2u4Sb4w00mu7MBc1dqMvjbfUa5yC8RjK+6u8bdrBZLAIS/EONmMpvg2S4IIWc4nVHfQ53vbl/9y3LkKJgdzsbmQrX2m26IV+NhlwO+Mt3qohZoFNSFXZF96TgtLFeeUeA7ImbEwrWFW8QcEc1V7nnayaSgkIlYc1cTggUtpC2iVvNaVjTgb3RGpa0O9S4vBZqk4b4eWrtBTSGT/DMeYf/iCrL+T3eUGBN6urpiL2+Pd3Y2bf3dVJf2+DNId688UGt+o3SAi9v3dkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgUvsI9E8JZKPsdV/VU6EIKqsliwfZtiK8pMUk917oA=;
 b=phFxpkJNhiUfcThon82fDHvpKatj/omZ9fMGBhbuEnPqcb8sv1NsOdzS/jgUXJx8XlPGVaj+z4+iJZ8Jg8orSNcOH7qW8MilBJnh2jwcFmkRp6C/F4R2bJgghUhL5ahM41/H3ybetk58mVBJwAL+18p+pt+fsVuDsLbrnWbDzOQRXnjduE5J0iYifeYay3vDq3xSKK33GU6GYSkuNSgLRoDiI4KYYFqxDx3eZGH61Um6sEGK4I4YMuQBjZI1YtfUY8883uLBnWhAlj6SVWf66MM2uhxOLMVustIBYNjLV6+kGkOMzciUBOLxPVwpJjEkDXTrCwmodaWfzs9SfJqSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by IA3PR11MB9206.namprd11.prod.outlook.com (2603:10b6:208:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Wed, 18 Jun
 2025 23:33:18 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8835.032; Wed, 18 Jun 2025
 23:33:18 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powercap: intel_rapl: Do not change CLAMPING bit if
 ENABLE bit cannot be changed
Thread-Topic: [PATCH] powercap: intel_rapl: Do not change CLAMPING bit if
 ENABLE bit cannot be changed
Thread-Index: AQHb3/2hiOOnQME8vESyJTSgb7ndgbQJJgkAgABstgA=
Date: Wed, 18 Jun 2025 23:33:17 +0000
Message-ID: <d2f0b3fa448d11536c26b98067d400a44d9d3010.camel@intel.com>
References: <20250618030330.279410-1-rui.zhang@intel.com>
	 <CAJZ5v0gY7Rp8C8AFzgRzMs+Gq-1rcgKmrG4+nJWB=bGpcKkU2A@mail.gmail.com>
In-Reply-To: <CAJZ5v0gY7Rp8C8AFzgRzMs+Gq-1rcgKmrG4+nJWB=bGpcKkU2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|IA3PR11MB9206:EE_
x-ms-office365-filtering-correlation-id: 4cc3573c-33d5-42c5-e5f3-08ddaec0812a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NHNMb3pRL3pkVjRwSWMyMWVqRUVQOERqRHFFdjdsMGEvNzhlb3h1ajREbkhH?=
 =?utf-8?B?Ky9xdk9NcnhOb1ZhaEtCVEZGWnl5bEVoVEJUdW5EZ3RiWDZSdUF3NjZlYmE4?=
 =?utf-8?B?ZTloaVhWbEkzaTQzcmJMa0xqUHVFR3RsUUdmZWVJNGZ6T0pHR2g1enU5aHdk?=
 =?utf-8?B?aFV3NU5Fb3hLUWFuRlc1c3ZpaEdDSVpjbjd2S3F3MExtQ2ZZUnU2aGJxWGhW?=
 =?utf-8?B?MVdaWHplSzhwVUxZUm9SV3duUjdFSU43NXAxajgzQ1IrODRudVVuSU41eUMx?=
 =?utf-8?B?WU5jdGs2eXJWOWkyTGNqamNuYUxKcThQL1NtdEtTNTJmNWM4YXhybFpMTzVI?=
 =?utf-8?B?eS9pY25XQkRxR2x6RkVsT0RWcGlBTG1PN2lOcnhmbzVKSWxFWnl6ZFpmZDlU?=
 =?utf-8?B?c1NmQlJTM1pUVHRxWVZabXpjcnBKOW0vcVkxZGhML0ppcko4Uk83QWRUa0Fn?=
 =?utf-8?B?aGdVRCtHaDNjalJhZVJMUTc5Z0VjNmN2QkdCb3h1cjdvbWg5eDlNakZzbmth?=
 =?utf-8?B?cGhVVzJQdU1kSEs3UTJ1N1ZRbi9kUUNDeDJkQTZJZVlCNzhHaFJYWU1iWjNT?=
 =?utf-8?B?SERTWGVyeDBGaVFyWll5bjEyNFQ3NFB5d0FUbjB0ZklGSmU3U053dzRDc3c5?=
 =?utf-8?B?QnpQMVFTRm5LaVdxUVNjQXBlTTRUVVpkcjdpMkp3aGZDeXJSQ3VHSDF3Vmhv?=
 =?utf-8?B?aDQ2d3VheGtiYkxFMG1jbnhwRFV1aVFCeENqR2VzcDJCS0ZRZDZnRTQ0dUda?=
 =?utf-8?B?dmloekt1K2xab1IxK2lNTzRIQ1kyeUhCeXp0bUZVRUpDdHUyL2MxY2JSN0M0?=
 =?utf-8?B?a3phVUdKdkliVjI2UCt1L0l4WitqR05TR3c0d0tIMEQ2SmVjNjlpU2xNNWxD?=
 =?utf-8?B?c2c1bkdKL0FLQnZNNnZQUkJZYnZZNnFrVHNOTXJtQWZsOCs1a3Y3OFNaaEoy?=
 =?utf-8?B?bWlPdXhrZFlKazNTRGlaU1NhOTFUcEFmeXdjSkFtUVFNTnNZdk9KTnhzU1lC?=
 =?utf-8?B?aDdoTkRHN21iR25RaEN6MDhWVWZvb3E3a016endXbmxLMlVDUjk4OHFBaFJt?=
 =?utf-8?B?VjlVQVdSV2hWTURta21scWREVG1tM3BnY2tidDBLaDMyZkYvb29qaCtPaTky?=
 =?utf-8?B?R3owY0RlakxqM2ZaaGszMXJJczBibm9RdnRnT0c2TGx2cWRqaFNrRUd4Rksr?=
 =?utf-8?B?aTlaQXRJd244NTM5azdCWlB0STlTSy8wVWFIUnBIMzBpcHU3eVFRMk1STm1C?=
 =?utf-8?B?ZjM1Wmp1ZEtMOWgvb29tejlTOWhWeHNIaVA4K2VVQlc1b2xQRTM5cjltS2dC?=
 =?utf-8?B?Z1FtaFNrNFRQOVVWN1dBRlcwNHIvWGgzTTVHc3ViYS9wV2prcU5NWlRUSmlF?=
 =?utf-8?B?OVpKYTkxTFVkTDhGbW5Pa2M2a2NGTk5YSkVPamgzV3VBZVlyQmNLejdPQnZK?=
 =?utf-8?B?Z2o0UEV0UGVsSlNEcnY4ZnV4RWYyOGhsRDFlQXBnWlZKL3VFWTYwQUVNU1Qr?=
 =?utf-8?B?MXBDOVdvZE1GSk9qRlJxc1Nxd0ZKb1FlMmFHREtXSVBtaHVZeHVPS1VScU1v?=
 =?utf-8?B?MDFXNGdhUU1RR0N6WkE1eG5wcjhNQWJleUdENHIzYy9vdXNYNDRkdGRlUkhm?=
 =?utf-8?B?V1RYd2FPMXZFMm1mSnQ0Z1U2QVJrWEdLZXFXenVqTXBybE5CUHJkc0c4U0k3?=
 =?utf-8?B?NEpUQnlMbEI3OWkraFRkOU1BVTQyWHY1MHdMUW9SaGtwWTIwZ1dYaXozay9n?=
 =?utf-8?B?NFZydmJmTU0yV2o5STNTVHpoZjNvbWI4Wk55WXlTei80VVU0MlgvOE1kK1lm?=
 =?utf-8?B?bC9aaE0vWEplaXFobldiK245YURjRVBQQUZGcWZ3Y0dxVnpOTElOOWFOZXhl?=
 =?utf-8?B?WlR3eTFzRmVVSTZvMzFUUHZQY3FKalJzV0x6cnRFQzBjY1ZtdnV6czZGRTdK?=
 =?utf-8?B?QXVnMmN5VmRZWmZPakxqWFdZOXVWc203UmxGTTJLRjlyM28wSlJkS1ltUzE0?=
 =?utf-8?Q?JNqXDysQW5Q0ssOR+/m+XZeKxfNFlM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3ZJRm02U0lUaGpnZ0tRbmJ0Zm9tamtacmJlUUVRRU9tNmNYNUh3VXZmWjN1?=
 =?utf-8?B?QUNRYk5DOW9pblZOdmNBblVuYzNVTWJWQ2l3YzYyYVlFRXIvdWhpQkI2eEhl?=
 =?utf-8?B?U1ZlVG02ZElqdXB0SlVnbTFhVmtlN21FcVRqaXBqZldubElSWjlsTnExa0Fq?=
 =?utf-8?B?c2I2Y2MrbEU4VGdUWnlEazhLQUo5Y1N6L0NQdU9nMDZvMmFoYVRzMWJXdXc1?=
 =?utf-8?B?NVB2REhYWEFaQzY3dzVPSGhQdi9rcW1QK2xkOWkrTTF5UDRIUStSWFlweEJ6?=
 =?utf-8?B?aEw2NC9lRlkzOUpkTzdkbFVDMFovakg1alJqWDBOK2tNNkZ0NmtJKzc1ME5M?=
 =?utf-8?B?L21jOVVXSjVRbVdxQzFZajJRYkZIN3dHaUo2MnFBUTdyVGhwU0dodGtoT1kx?=
 =?utf-8?B?M3Z6a3FpZXdDQm1oRkJFZ080SjVFQmcwMktlaEJmODJlWGJGZFdJSHZCeElr?=
 =?utf-8?B?UW9qbHErSjl5bXdreXQzZXhLaEoyeGdxY3JsQ3JKUXpmTkdHTmFGWllDOXV6?=
 =?utf-8?B?c0xGTnRNdXBPSGZxazFOdzVOMS9YUVJ0eEFDaGt4M2o0b2VPb1JVcnE4NWxs?=
 =?utf-8?B?a3pkNDF6YXNsYnUwcU1CWm9MMkVVdUJ4a1Z5WHI0K0hKdHRBcnRhYkRrUllq?=
 =?utf-8?B?R0tUZk1udTUyZWt0eWcrSjVsdjk3eThPRTBnTHFBRnVSbldRY1JiZWx1TU1w?=
 =?utf-8?B?VTlRQXY3MGtnNDdmTlJOb01kb25mZUJIWXZSdDNKRXNGamEraXU1MWMxUU5T?=
 =?utf-8?B?RGJad1hINVJPQXJzL2NoQkpDK1NyS3BsdUZNSG1sVWFBRS9Ucm41bndwKzB3?=
 =?utf-8?B?MUJsZ3VkL1l0VEZpZW1lYnhFUUtxeU9JTE5MMS91UXNKTVIrTXdKejIrY3ls?=
 =?utf-8?B?SnhOTktCeDB0ckpIRkorczc3TEZUcFowcGUvdFNjVmorVENjOEpoRmd2c1Rh?=
 =?utf-8?B?cUhrazF2cytTdkt1MkxjKzNjMnhyaUNpcHF2aHE5RmsrTTJYT3NaWGk5WDla?=
 =?utf-8?B?NFBja3BDVjRoQUxIUHlPN1JDY3RmSjVyZ3RjenU4WHUxUnV0Um1vNkgzYlBC?=
 =?utf-8?B?cGFyVGJtbjQyMzNMZWp0NzVRem5LLzBwYkV2N2t1bUJTektWVDIvOHVzc2lm?=
 =?utf-8?B?cTFFQWNiVENvR0V6MlBHc3dGTkV5OGhReUtzRGFJY3FrTjZYMHpzMzJYRGRo?=
 =?utf-8?B?SzJxS0M1TWp3QU0wTmZGMGVhbFhZeExMajhNUjZWSnBObWFaMXlRZll4eTc0?=
 =?utf-8?B?M0MzaTdPNzJNR3hPY1hQTHFEejZhYmhZTC83NVpnVUUwbjQvUGpkMHRaT0tt?=
 =?utf-8?B?dnpJdVNUTjZOcTJ5NlJOdDZpWkhiOGNyTEt0cmZQSncrU0EvWmgwQm4vNzNp?=
 =?utf-8?B?QWt1Ny95bVhaRGZIbUJiL21pRnF4ZWU4TDhUZ2NoMlpTb0RrZVBLRjVCMG1a?=
 =?utf-8?B?VmJaMlRxQWNRcjdrNGx3TWpOc0o1YnBoTmRHbENtWDBOZWIzMXZvYzBGOEF0?=
 =?utf-8?B?RldUcWprVll4ckNra2NMdm5WRHkzTVl0NkJtQXJzbUZ1aExwN1FXb2xLMWlJ?=
 =?utf-8?B?NmtDWWdIL1A3bjVyY241akRQd3FhN0d1N1BDSlB5UzRHL0lEUitucVFJeU43?=
 =?utf-8?B?RTJLbHFEKzhpZ2NxdGRoNkl3Q0dseDMvL0Nxc0JTWGhPMDZybTlKUUp6a0Jl?=
 =?utf-8?B?V1dmZXRRRUFKM1BMTGF0NGZrQTdiUC83M2lmQ0Vsamg2TTJFaWJyVUxOL3VU?=
 =?utf-8?B?d2l4L3N6TEF1a2lsaHFPRFJuclYxT1NxQ3hHSjNGY0I0UllKUjNjOXp1di9l?=
 =?utf-8?B?ZHgvSGtXUGRjQkpFa0tMT1RlUjByOU4wc2lkcWJ3SGpiVGhITTNiQVNLQlpX?=
 =?utf-8?B?UWJhQVdaTXk2NExGTFJmTHlvWDI3aXhFT0U1VzRQbkdKNkxvcWxid255ME94?=
 =?utf-8?B?VzlZUy8yU0JFODcwc3AyVkQzNUw5NFdmWWg3Y29BTEUrTWEyQTY3dVhnd2lw?=
 =?utf-8?B?UGR0YzNnQ1h4M3dSYVhBNzRCNXdVQzRQazhEV3J2MjRBSWhvMGFlR1I0ajhz?=
 =?utf-8?B?eW44Y0ZlTTZyandRYW1STUJadUpXZ3BTM20xSWp6UVNCUEUrUmxIclhRTW9h?=
 =?utf-8?B?REtEaHQ4Z2tuMHRtTTUwMUxsQy96R29Pd3l4bzBYR2JRcFp6TnhTeEpyeEll?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1C58A40CD242A4A9131AE4ECDC288CC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc3573c-33d5-42c5-e5f3-08ddaec0812a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 23:33:18.0398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lB/A9Am6XjL6qV4SoCDdSBBfn+nRB1nCmph85B7oJA9NzcN6cautNEbOLUH227dwADAhX9tV+WOz/Ez5CLk0FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9206
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA2LTE4IGF0IDE5OjA0ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gV2VkLCBKdW4gMTgsIDIwMjUgYXQgNTowM+KAr0FNIFpoYW5nIFJ1aSA8cnVpLnpo
YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gUEwxIGNhbm5vdCBiZSBkaXNhYmxlZCBv
biBzb21lIHBsYXRmb3Jtcy4gVGhlIEVOQUJMRSBiaXQgaXMgc3RpbGwgc2V0DQo+ID4gYWZ0ZXIg
c29mdHdhcmUgY2xlYXJzIGl0LiBUaGlzIGJlaGF2aW9yIGxlYWRzIHRvIGEgc2NlbmFyaW8gd2hl
cmUsDQo+ID4gdXBvbg0KPiA+IHVzZXIgcmVxdWVzdCB0byBkaXNhYmxlIHRoZSBQb3dlciBMaW1p
dCB0aHJvdWdoIHRoZSBwb3dlcmNhcCBzeXNmcywNCj4gPiB0aGUNCj4gPiBFTkFCTEUgYml0IHJl
bWFpbnMgc2V0IHdoaWxlIHRoZSBDTEFNUElORyBiaXQgaXMgaW5hZHZlcnRlbnRseQ0KPiA+IGNs
ZWFyZWQuDQo+ID4gDQo+ID4gQWNjb3JkaW5nIHRvIHRoZSBJbnRlbCBTb2Z0d2FyZSBEZXZlbG9w
ZXIncyBNYW51YWwsIHRoZSBDTEFNUElORyBiaXQsDQo+ID4gIldoZW4gc2V0LCBhbGxvd3MgdGhl
IHByb2Nlc3NvciB0byBnbyBiZWxvdyB0aGUgT1MgcmVxdWVzdGVkIFAgc3RhdGVzDQo+ID4gaW4N
Cj4gPiBvcmRlciB0byBtYWludGFpbiB0aGUgcG93ZXIgYmVsb3cgc3BlY2lmaWVkIFBsYXRmb3Jt
IFBvd2VyIExpbWl0DQo+ID4gdmFsdWUuIg0KPiA+IA0KPiA+IFRodXMgdGhpcyBtZWFucyB0aGUg
c3lzdGVtIG1heSBvcGVyYXRlIGF0IGhpZ2hlciBwb3dlciBsZXZlbHMgdGhhbg0KPiA+IGludGVu
ZGVkIG9uIHN1Y2ggcGxhdGZvcm1zLg0KPiA+IA0KPiA+IEVuaGFuY2UgdGhlIGNvZGUgdG8gY2hl
Y2sgRU5BQkxFIGJpdCBhZnRlciB3cml0aW5nIHRvIGl0LCBhbmQgc3RvcA0KPiA+IGZ1cnRoZXIg
cHJvY2Vzc2luZyBpZiBFTkFCTEUgYml0IGNhbm5vdCBiZSBjaGFuZ2VkLg0KPiA+IA0KPiA+IFJl
cG9ydGVkLWJ5OiBTcmluaXZhcyBQYW5kcnV2YWRhDQo+ID4gPHNyaW5pdmFzLnBhbmRydXZhZGFA
bGludXguaW50ZWwuY29tPg0KPiANCj4gSWYgdGhpcyBpcyBhIGZpeCwgSSB3b3VsZCBhcHByZWNp
YXRlIGEgRml4ZXM6IHRhZy4NCg0KVGhlIHByb2JsZW0gaXMgYWx3YXlzIHRoZXJlIHNpbmNlIERh
eSBPbmUsIGluIHRoaXMgY29tbWl0IDJkMjgxZDgxOTZlMw0KKCJQb3dlckNhcDogSW50cm9kdWNl
IEludGVsIFJBUEwgcG93ZXIgY2FwcGluZyBkcml2ZXIiKS4NCg0KSSBjYW4gdXNlIHRoaXMgY29t
bWl0IGluIHRoZSBGaXhlcyB0YWcuIEFuZCBJIHRoaW5rIHRoaXMgc2hvdWxkIGJlIHN0YWJsZQ0K
Y2FuZGlkYXRlLiBXaWxsIHNlbmQgVjIgc29vbi4NCg0KdGhhbmtzLA0KcnVpDQo+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4g
PiDCoGRyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYyB8IDE3ICsrKysrKysrKysr
KysrKystDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxf
Y29tbW9uLmMNCj4gPiBiL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KPiA+
IGluZGV4IGUzYmU0MGFkYzBkNy4uNjAyZjU0MGNiZTE1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0KPiA+ICsrKyBiL2RyaXZlcnMvcG93ZXJj
YXAvaW50ZWxfcmFwbF9jb21tb24uYw0KPiA+IEBAIC0zNDEsMTIgKzM0MSwyNyBAQCBzdGF0aWMg
aW50IHNldF9kb21haW5fZW5hYmxlKHN0cnVjdA0KPiA+IHBvd2VyY2FwX3pvbmUgKnBvd2VyX3pv
bmUsIGJvb2wgbW9kZSkNCj4gPiDCoHsNCj4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcmFwbF9k
b21haW4gKnJkID0NCj4gPiBwb3dlcl96b25lX3RvX3JhcGxfZG9tYWluKHBvd2VyX3pvbmUpOw0K
PiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCByYXBsX2RlZmF1bHRzICpkZWZhdWx0cyA9IGdldF9k
ZWZhdWx0cyhyZC0+cnApOw0KPiA+ICvCoMKgwqDCoMKgwqAgdTY0IHZhbDsNCj4gPiDCoMKgwqDC
oMKgwqDCoCBpbnQgcmV0Ow0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgIGNwdXNfcmVhZF9sb2Nr
KCk7DQo+ID4gwqDCoMKgwqDCoMKgwqAgcmV0ID0gcmFwbF93cml0ZV9wbF9kYXRhKHJkLCBQT1dF
Ul9MSU1JVDEsIFBMX0VOQUJMRSwgbW9kZSk7DQo+ID4gLcKgwqDCoMKgwqDCoCBpZiAoIXJldCAm
JiBkZWZhdWx0cy0+c2V0X2Zsb29yX2ZyZXEpDQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAocmV0KQ0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZW5kOw0KPiA+ICsNCj4gPiAr
wqDCoMKgwqDCoMKgIHJldCA9IHJhcGxfcmVhZF9wbF9kYXRhKHJkLCBQT1dFUl9MSU1JVDEsIFBM
X0VOQUJMRSwgZmFsc2UsDQo+ID4gJnZhbCk7DQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAocmV0KQ0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZW5kOw0KPiA+ICsNCj4gPiAr
wqDCoMKgwqDCoMKgIGlmIChtb2RlICE9IHZhbCkgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHByX2RlYnVnKCIlcyBjYW5ub3QgYmUgJXNcbiIsIHBvd2VyX3pvbmUtPm5hbWUs
IG1vZGUNCj4gPiA/ICJlbmFibGVkIiA6ICJkaXNhYmxlZCIpOw0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGdvdG8gZW5kOw0KPiA+ICvCoMKgwqDCoMKgwqAgfQ0KPiA+ICsNCj4g
PiArwqDCoMKgwqDCoMKgIGlmIChkZWZhdWx0cy0+c2V0X2Zsb29yX2ZyZXEpDQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlZmF1bHRzLT5zZXRfZmxvb3JfZnJlcShyZCwgbW9k
ZSk7DQo+ID4gKw0KPiA+ICtlbmQ6DQo+ID4gwqDCoMKgwqDCoMKgwqAgY3B1c19yZWFkX3VubG9j
aygpOw0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+ID4gLS0NCj4gPiAy
LjQzLjANCj4gPiANCj4gPiANCg0K

