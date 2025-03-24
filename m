Return-Path: <linux-pm+bounces-24439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A4A6D286
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 01:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0E718941A1
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 00:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C50163D;
	Mon, 24 Mar 2025 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWQyPHeO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CA163
	for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2025 00:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742775448; cv=fail; b=pUtdLZP5shuk4CsIJMxAb0iuzPl9+fISXo2zgpJuSgwqdxM/77frpy2dWJx89dgt+TT1MwOpQ6meJ3y/Wtp/d3TOSgtqhLo40pcbu7eDLXeJJMUquSwx6owlI/4W2kgcHS5miay46F1nkXCypDVzHadH/oDFeO8jVAUqtb7aLpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742775448; c=relaxed/simple;
	bh=eD6COkgS1Eebxb0ASdc3LMxok0KIZ5nRUNrb2XdY+kA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DUajwFecY5+ljrDU+RjVWp+EronNFHc4wNrw71XQQmWtq0n3HFhK4SMeDdXf158JgLp7DVsf/r1xhYyQz6W8tuu8G3SMrHI2637yo1LzL4Tu8nrnCEhigsowerPIkL1kq0aD27L4HLy3fwfvI3r/124x25+aJ8gQDdl4qUF1QwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWQyPHeO; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742775446; x=1774311446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=eD6COkgS1Eebxb0ASdc3LMxok0KIZ5nRUNrb2XdY+kA=;
  b=bWQyPHeOLSRRux0t494sIWYdbumCr2fLs6gWdzINfA4d2LgbttBj16Ly
   UM4di+W90UOPBZGDQi8tIIIHVXAQnA8j8pyN96NJF+qbs7bBu2SaSPpaA
   6Zgw6DIuVv+VfgVYxY3jaacw3pt5/vY2cRHIBTZJmEQjQ9Ga5iPL6U7UU
   oXPw6/5ltCtZNNsiDGF5ENNew55vs9AzxPVXn87UGeksz8Hw+PlDtmMCp
   KTlXiL3ZHQodUN2MSXwAMkHChIzISPHrWBP/xzghk9tX/Lf1/jZQgtSBT
   W7QSlzYC6y0JTm7XPFtNuaPsNsuhQefCGX9V/bomTPAJGUuCnbVvYPxto
   A==;
X-CSE-ConnectionGUID: B/OKjytkQ4KaKeH8ajqtRw==
X-CSE-MsgGUID: MzmQS7axSrql/dfrhaIgOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="43842534"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208,223";a="43842534"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 17:17:25 -0700
X-CSE-ConnectionGUID: azlc9wA1T6uDzIiU5E4EbA==
X-CSE-MsgGUID: bKsbBfibTqaJBIvSMzJ95w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208,223";a="124838133"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 17:17:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 23 Mar 2025 17:17:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 23 Mar 2025 17:17:24 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 23 Mar 2025 17:17:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHptouhG6UFerlQJR9daojz9UTiytOhTuYvOWL7TnSiEixHgWiJVgPzxPlPzLJnBVa0BmlTRB9KaoUQgaGNv8kvv8rmveOFgYCAe8k67k/hYPrhpoy/pb+WGLGC+cNMkMcSrrVkeW/RHOK6zvjmhQHywh0eLprGr/753H0zl/hZN0GcZ6lMATb65altxMATrl/WqDaPHUUlt7eGfkpbcXTo+n0vNXyYw1c9PDqV8n6z5QViGiT0NJn4j48H/jdVql5hOXd6D/H3du0VoBdiOLiu8ppKlsfZHsRKqOqTmpy/UJuS8zcJQN+S/ljyv9+Eur7B9uDDIxsjYJHtjRKzZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf032uhawXiO/6ky8FbFn1q7KVcsScPAkrqXAJfzePw=;
 b=tMEUU3GRbu3J+uNr4yy3Kq7Ed7wz4Vb9wFktJoC7LwbI5YUTgHAn50/AFlU/OJpSA16iBh9koGlE0UneeTu4lt0dBVjX2HczUbwUURBljFPAANrGnehBgzaaP3xjVkrl8ywRa5LUVrNxkDTZqnVlFZ7rtooMqlgwV+V66muBNq5kNoBUtGimz5T2ZPAIj2yHaD2LMStC9sDfZ9wshoftEyqJKFlfGo3iwLFTPnRXVOQduhVi8Py4o7QuBUHwmSIoH49VPcWVAd0KUYq5Nz2uW1UNFIT0fjZ9HgcBVRpgU07hzTQBSAqfVvF76pw69TNyAT5Xhr8YGYF07aUm7gR6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 00:17:07 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 00:17:07 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "5e9075f31acbd5a1ef549cc3cd2236173a41353a.camel@intel.com"
	<5e9075f31acbd5a1ef549cc3cd2236173a41353a.camel@intel.com>
CC: "Neri, Ricardo" <ricardo.neri@intel.com>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"163ff391dc6d4f828ecff95e87f5003d@secunet.com"
	<163ff391dc6d4f828ecff95e87f5003d@secunet.com>, "Wassenberg, Dennis"
	<dennis.wassenberg@secunet.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"Gwara, Mateusz" <mateusz.gwara@secunet.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "Pandruvada, Srinivas"
	<srinivas.pandruvada@intel.com>
Subject: Re: TCC cooling on Meteorlake
Thread-Topic: TCC cooling on Meteorlake
Thread-Index: AduXIcaE4XBbkGi2QAiWzDN54mFkAgFMEwKA
Date: Mon, 24 Mar 2025 00:17:07 +0000
Message-ID: <17a637f633a7560ca87d7461fc56632e5f9e41cc.camel@intel.com>
References: <24742814b1fc433cb778dc6ecb7c671d@secunet.com>
In-Reply-To: <24742814b1fc433cb778dc6ecb7c671d@secunet.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SA2PR11MB4907:EE_
x-ms-office365-filtering-correlation-id: 3643a8a9-ad8a-4a56-e756-08dd6a693690
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|4053099003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aHRBemtKcUVDZjJYZVlVV3dMTkVsSHZYOFdZTFFVL3U3MHpudWtzb3NzbWZw?=
 =?utf-8?B?ZStmbE5BM0F5MFdwUTVaTlBBM2tNZDUraTBETjJOalV6NExrMXFWWDN2QlJy?=
 =?utf-8?B?VThNck9taG5DTmkrRERROWZicDViVlFJV2lzRGtKZnNXaU96blhvNUkrd0Ev?=
 =?utf-8?B?WHBsYksxeVhyQjgyNDlpbDU3YmFrdlZ6SVZwU3Z1ZTlmNU9nbjdBSVh1elZV?=
 =?utf-8?B?V1VNUnhTSGZFbEVaRnB4QmFHSVp3bHlSUTlVWnIxYU5JWG1HM0REa1VBSW41?=
 =?utf-8?B?ZjZybDBMQU03YVVKRVFaSno3L2dkMVRIc0JKTUxMVWMrQ3JmaHFZN0h6Rmo3?=
 =?utf-8?B?cWFrUCtmVGFEMlFIVTRlRnNOdGMxazVHekVKSXF6dEFJbTdEallpNEhUM3BQ?=
 =?utf-8?B?M21UQTVoQjcxMDFtTzJOOThSN05jS01JNExqckQ5NjF5cVFPeWtidmhmUnYy?=
 =?utf-8?B?RUJkZUdscGk0aHpwZjdOR3NMMmtVL1VYaEZ5RVFUNng2MjBpdG41ZEsyU25w?=
 =?utf-8?B?MFMxeTNVVFhXWUsyZmtQMUMwcVgxelNMeDcxMjk0WGc3MHNPSmtqa3pPcitt?=
 =?utf-8?B?bUhRU2xUK0ZJYzQ2cWxHbE9mMitqM0hWZFFXeG5wSTA0d1NFVHdycDBjb0V6?=
 =?utf-8?B?NlF1cnUwNVpkR1RmVTVDNVZyRmVyN1gzSnlyUS8yL3BKRUhRbDZMY3kwMXNI?=
 =?utf-8?B?ZTlwU2VFSVdQYWJnbTlla0s3eC9rdnY1d3NERU1obEI2Wks0S1FpZWgwTXBN?=
 =?utf-8?B?RFhaUHZESkd6STNYYjZYbjRjQXlqWWxwYVkvbzF3UzFYdWE1dXg0YkdYT08x?=
 =?utf-8?B?SU9WUEpNYUp0TTd3WGZ0VmRoNGIxNjhzaUpDL2MweVltaDBSS1NqS1NHQXN4?=
 =?utf-8?B?aEo2WTBwSldyZHFXK3h3ZTk3bWw0b2xma2NXQlFmQ1hiWDRtL25vdTZjblk0?=
 =?utf-8?B?OGV3ZGhBYXd6M1hRQkhjZ0d0eVpnRGpPTXowZ0gxNGptWWRVY1N4OE1ZdlZa?=
 =?utf-8?B?QkVnb2sxa1lNZlozekpad3J2N2hzVktmWTNoQUo0TlpXeFB0dlpud0RGa0cx?=
 =?utf-8?B?YVlJQ09IQWNsLzFIMXdEY2Zuak9XOGlTWkNtVGxJVExrc1VPejVPU250dExy?=
 =?utf-8?B?Y2lab1gvdmVGb2FGOVdNZldQZDA1Zjh6WkNIdGJVSmdQWEJucVh4c0E3VE51?=
 =?utf-8?B?QzFVTGdhS1gwcDc2Q2RwUGwxTUJXaTB4UGpRMmpnamJ5eGJlRTlBRFptVndN?=
 =?utf-8?B?aGNYTDdSWHFkZkR1MDJxUUJNcmVWc0ZKU2Zja0FNaTFwM0JiZjVrdzVtZFZW?=
 =?utf-8?B?clRvOHZlVlZsY1FyRGp1TWlLaUNQWGZ6VEJPbHBpMU1Yd0ZoS3F5QVZidjNa?=
 =?utf-8?B?c2YxOU43Um9ZS1cvK0V6YllReG10bE9yRjVVQ0l5REJpQS9RY01KVnhESllj?=
 =?utf-8?B?U3dIVjRCZGpZeGs0d3FyK3BCc3NpQ2NvdnF1YmhFUFJ0aHVjeG9TS0F6TC91?=
 =?utf-8?B?aEpueXZJdEdBOXhUUDE4WmpGOWo1dzUzMTg2WW55SWlPMlV6ZkgxcW9oMTIx?=
 =?utf-8?B?ZDdTYU15c3VXOVZqWlArbkxXS2dHdml4Rmk0OVdhZmROU0huZVU0QjZkRGNG?=
 =?utf-8?B?THJWZmhMbGlpVEdPeVFWVExOWkgxN3ozWm5uMWR5N2ZwQ1FjZHA0ZWZ6bFdh?=
 =?utf-8?B?WXlKbGRRY3FTbUxxbkpTSXFOR1Z6UGY1ZUExWGt1TVNPR1lvNXJNNmc1Tzgy?=
 =?utf-8?B?SEVPbzdUdm42Umo4bVFOdDRxZTJJTjdxSmppaHhSbU5MUkJZQ1FhS2lPb2Mv?=
 =?utf-8?B?cVdqNlZRT1orYU1VUEVMcDIvT1d3ZWpOUjdkaGtrWE9kMTkwMVE1dVRlczdS?=
 =?utf-8?B?YmZBYzFWUk9WVWdybzdoWTlkVTFWaktJbFJPRGVMU1d4OEM1L0xQUGR1a0hu?=
 =?utf-8?Q?ASnM/HirdMryTUS3gktginU5jgeCjGyO?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnBNR2lwL1QrVVhYem1ldFp3bnoyRVllb3MvSXdkTjFHOW0rdmEyc0VkT3Ji?=
 =?utf-8?B?MkhpK2svVDRoUXYvaVZLSnBJSys0RTNxUUppcXZYV3lhTXREMmRiQklsV2d6?=
 =?utf-8?B?dmZONjZUaGxrcEFjbW12VmVTNUlWMktlWFdab2dGQnJaQU5tcmd3ZENMMVhQ?=
 =?utf-8?B?cGl4bmZsNThkV2FLYUExODFNTUFxc3hka3VNZzFxTmtyYkZXNzVDTzR0cVJi?=
 =?utf-8?B?V1hpcEFOWFlCQitzbjcxb3Y1WS95VWtrR2ZjY1BZMy9jMWxQbXUwblVVTmVq?=
 =?utf-8?B?c2ZPZXJtQlZ4UTUzYnFIWXZqQVRnN1poL1NqQWV3N2hHY01ZeC9kaDdjcmZ6?=
 =?utf-8?B?cTlBeXdlSVVWcE8rSU0vcTJKSWwxUGtqWHlPcnpoc2QyQUpiWmZkQW03cHl0?=
 =?utf-8?B?ZTQ3TGVLVXIrc3VSV1JaczhObVdHcXpxRFZzc045byt1K2xUZmh5eDF5ckZy?=
 =?utf-8?B?WGhHd0xuMCtEVHhqdWtxdmNsSWJIUWNwTk9CVEduc1R4WkFjWkdNYmJKeVR2?=
 =?utf-8?B?d3c5VXpXazdFazg0YXdFd2ZUZ0lqeFFrZHJQM2FPSWcyeWpPWm54Z0l4bUt0?=
 =?utf-8?B?NldzSzZFcFI3NzNSWDA5djZpVHZHUmFJSWlST01wUDRaVmVGeVNicHI4TXl0?=
 =?utf-8?B?V3ZxZEVKaktnY1ZSbEJJK2hmeG1weTNuOGJBNUtGeDlaTzhQWTFzZlRPVXpo?=
 =?utf-8?B?eW9WZUZGS1dtbGFuSGwvUlBsaGJ0UHNxdXBoWVBTcm9McEd1NXVWbU1JZE1H?=
 =?utf-8?B?S1lOZGZuQmtnaTNqUzMrL2ZvdGlrTWszN0xER1JsYjNtaGNranB1YVhJU2NR?=
 =?utf-8?B?ZHdZWktGb0liVmhYYXVJRjVuQ3J2K1hVajdjeHllWkZ5V2cwRmcwaXlNZEEz?=
 =?utf-8?B?NlQ4cUNIM3B0OEE3My85SHNUeGJGazdhK01GMGVibVdzVFMwZjJJK0N4YmU5?=
 =?utf-8?B?R3NQRnJFNHo1UWxCOUhFU3FQVXZvL0xjbnpUOXpnVlBBcW5RRHg5MUU4ZDBU?=
 =?utf-8?B?YllzRkkvODhHT3ZTTnhhWUhHejJCamJ5WGhRTjgrbnNBV3lYcVNwVm9FTFNQ?=
 =?utf-8?B?SVpkWUUrcm9rcmh0YXZkTUV4T0xCSXBjd2hjZ0JlYmw5NURMRUhxb3Y3dmFS?=
 =?utf-8?B?TWIyT0dBVE1FNm83MFBjbVdvMGFpU0R4M2hKTjFJTDRtVURRYUNmbUFQYzYw?=
 =?utf-8?B?aFc2L2IrWDgvbUp4MlJ5MUVJbTl5ZVYrYXlTL09lNVN0OWw4bzI1TVg1RGJk?=
 =?utf-8?B?d3g5bDZrQ2VEeTlPbVhZOEZpZFRaODM3QXB4bHlOSjBkUWZ2Q1FLR0R6RGlV?=
 =?utf-8?B?OHdaMk9lNUFTMXRVU0dnUmlmeHNSWnlyczlrMSthbU1QNlQ3WVBWN09uaDNQ?=
 =?utf-8?B?YjJRSHN3RXVpaStFOGJKc2xmU3REaEUzYStleWxCOGNBcWhCQktTUmZhc1JG?=
 =?utf-8?B?dFEzWURFaDZIbjNZRCtJY1hsV3NtRTJiNEo4UzZpUDkxeTVwWkVDNHlUVytU?=
 =?utf-8?B?TzBZSzd2cGdhbDVMdVd6bGFkTVZhSXhHNEF0YnFWT1QyazVkcXZhVURVR0Zh?=
 =?utf-8?B?RUxVaGFYdWxEQXR4ZE1JaUd0SE5RcHMxTWZ5dUZXVHhaQkhOeUt4VEVVYXg2?=
 =?utf-8?B?My9tN3ZScXlSTDFkVG9GQXY3TTNyT1hEbVF0SHdmeVNqemhJVmI2eDZua1Z1?=
 =?utf-8?B?cGJRZmM5U2FXNThFTDh3ZU1aMStWUmVGMVlid1Z5dGRlK2loZjJyckV6U3Nj?=
 =?utf-8?B?VlRmRy9CWjJubjVwVEQ4MHZrRE8vRWlDcmo4TUI3Uk9yRkVEUi9OWVd3ZWFr?=
 =?utf-8?B?SUlnb2lOTXNPRWJmK1ZwYldXdTIwQ3o0d25DLzgyVEtHVVNBRlNwQjI2aGN0?=
 =?utf-8?B?c2xlMndSZ0h5dFJMNGpPYk1hYTRzcVhhVjlqT1JGWkZIV0ZXeFRDM0pKNklJ?=
 =?utf-8?B?Q0oxZVk0cFQ3WkNGeVdUQ1RJNEducHpxOWVROHJCOXZtd1JLTjlUbGhzeXpV?=
 =?utf-8?B?LzlwSHFLL1QzN0wvYklPWnhmZUh6YnpNa2JmWk9HYjRXYjdkd2Z4K3l0MHVu?=
 =?utf-8?B?ZDJSV0JOTG1wVzFIYlNWQzhDRGtRZTVkL3JUS2h0dUh5ZFlnaDJOUUd1M0FM?=
 =?utf-8?B?NXdUTUtpYS9HOGhFc1ZUYjlVV2RwZGtWNkdhWTFDMklPeHFyOGRXYzJZLzBn?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: multipart/mixed;
	boundary="_002_17a637f633a7560ca87d7461fc56632e5f9e41cccamelintelcom_"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3643a8a9-ad8a-4a56-e756-08dd6a693690
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 00:17:07.5747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuqaPSgf4BgNV0dcyzzCb6yTKy0YtQX0qGoqtjqKEA1xjf++eMWiqOmF6cdO1MDSxEjD3mNs34Dvs6rDCb5zNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
X-OriginatorOrg: intel.com

--_002_17a637f633a7560ca87d7461fc56632e5f9e41cccamelintelcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <904AF16DBE74784D9970DC7485DBC067@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gTW9uLCAyMDI1LTAzLTE3IGF0IDEwOjMxICswMDAwLCBHd2FyYSwgTWF0ZXVzeiB3cm90ZToN
Cj4gPiB3aGF0IGRvIHlvdSBzZWUgZnJvbQ0KPiA+IC9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDA6
MDA6MDQuMC90Y2Nfb2Zmc2V0X2RlZ3JlZV9jZWxzaXVzPw0KPiANCj4gPiBJdCBzaG91bGQgcmV0
dXJuIDAgaWYgbm9vbmUgY2hhbmdlcyB0aGUgb2Zmc2V0Lg0KPiANCj4gVGhlIG9mZnNldCBpcyBz
ZXQgdG8gMTTCsEMgb24gYSBNZXRlb3IgTGFrZSBDUFUuDQoNCmRvIHlvdSBrbm93IHdobyBzZXRz
IGl0Pw0KDQo+IFRoaXMgYmVoYXZpb3IgYXBwbGllcyB0byBvdXIgY3VzdG9tIGtlcm5lbChiYXNl
ZCBvbiB2YW5pbGxhIDYuOCkgYXMNCj4gd2VsbCBhcyB0aGUgcmVndWxhciBVYnVudHUga2VybmVs
IGJ1aWxkcyAodGVzdGVkIHdpdGggNi44IGFuZCA2LjE0KQ0KPiANCj4gDQo+ID4gdGNjIG9mZnNl
dCBpcyBhbiBvZmZzZXQgdG8gdGptYXgsIG5vIG1hdHRlciB3aGF0IHRoZSB0am1heCB2YWx1ZQ0K
PiA+IGlzLA0KPiA+IHJpZ2h0Pw0KPiANCj4gVGhhdCdzIHRydWUuDQo+IFdlIHJ1biBvdXIgUmFw
dG9yIExha2UgZGV2aWNlcyB3aXRoIGEgVENDIE9mZnNldCBvZiAzwrBDIHdoaWNoIGlzIHdoYXQN
Cj4gaXMgdXN1YWxseSBzZXQNCg0KYW5kIHdobyBzZXRzIGl0Pw0KDQo+ICBmb3IgdGhvc2UgYW5k
IGdlbmVyYXRpb25zIGJlZm9yZSBvbiBhIHJlZ3VsYXIgVWJ1bnR1IGZvciBleGFtcGxlLg0KPiBU
aGlzIG1lYW5zIHdlIGFjdGl2ZWx5IG1ha2Ugc3VyZSB0aGlzIHZhbHVlIGlzIHNldCB0byAzIGFz
IDAgd291bGQNCj4gbWVhbiBiZWluZyB0b28gY2xvc2UgdG8gdGptYXggYW5kIHJpc2tpbmcgYW4g
dW5jb250cm9sbGVkDQo+IHNodXRkb3duKGkuZS4gYWN0dWFsbHkgcmVhY2hpbmcgdGptYXgpLg0K
PiBIYXZpbmcgdGhpcyB2YWx1ZSBzbyBjbG9zZSB0byB0am1heCBhbGxvd3MgdG8gcHJldmVudCBw
cmVtYXR1cmUNCj4gdGhlcm1hbCB0aHJvdHRsaW5nLg0KPiBTbywgdGhlIG11Y2ggaGlnaGVyIGRl
ZmF1bHQgdmFsdWUgZm9yIE1ldGVvciBMYWtlIFRDQyBvZmZzZXQNCj4gYmFzaWNhbGx5IGNhbmNl
bHMgb3V0IHRoZWlyIGhpZ2hlciB0ZW1wZXJhdHVyZSByYW5nZS4NCj4gDQo+ID4geWVhaC4gV2Ug
c2hvdWxkIGFkZCB0aGlzLiBQYXRjaCB3aWxsIGJlIHN1Ym1pdHRlZCBzb29uLg0KPiANCkkgaGF2
ZSBhcHBsaWVkIHRoaXMgcGF0Y2ggb24gYSBjb3VwbGUgb2YgbWFjaGluZXMgdGhhdCBJIGNhbiBh
Y2Nlc3MgYnV0DQp1bmZvcnR1bmF0ZWx5IHRoZXkgYWxsIGhhdmUgVENDIG9mZnNldCBiaXQgbG9j
a2VkLiBTbyBwbGVhc2UgY2hlY2sgaWYNCml0IHdvcmtzIGFzIGV4cGVjdGVkIG9yIG5vdC4NCg0K
QW5kIEZZSSwgYm90aCBpbnRlbF90Y2NfY29vbGluZyBhbmQgdGhlIHByb2NfdGhlcm1hbA0KInRj
Y19vZmZzZXRfZGVncmVlX2NlbHNpdXMiIGF0dHJpYnV0ZSBhcmUgYmFzZWQgb24gdGhlIHNhbWUg
dGNjDQpoZWxwZXJzLCBzbyBJIGRvbid0IHRoaW5rIHRoZXJlIGlzIGFueSBkaWZmZXJlbmNlIGJl
dHdlZW4gdGhlc2UgdHdvDQprbm9icy4NCg0KRnJvbSA1NWI1OGI4YmE3NDI2ZDhiZmRlMjZkNzg4
NTVkNDkzOTA2NjkxOGRhIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogWmhhbmcgUnVp
IDxydWkuemhhbmdAaW50ZWwuY29tPg0KRGF0ZTogVGh1LCAxMyBNYXIgMjAyNSAxMzozMTozMyAr
MDgwMA0KU3ViamVjdDogW1BBVENIXSB0aGVybWFsOiBpbnRlbDogaW50ZWxfdGNjX2Nvb2xpbmc6
IEFkZCBzdXBwb3J0IGZvciByZWNlbnQNCiBjbGllbnQgcGxhdGZvcm1zDQoNCkFkZCB0Y2MgY29v
bGluZyBzdXBwb3J0IGZvciByZWNlbnQgY2xpZW50IHBsYXRmb3JtcyBpbmNsdWRpbmcNCk1ldGVv
ckxha2UsIEFycm93TGFrZSBhbmQgTHVuYXJMYWtlLg0KDQpTaWduZWQtb2ZmLWJ5OiBaaGFuZyBS
dWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQotLS0NCiBkcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50
ZWxfdGNjX2Nvb2xpbmcuYyB8IDYgKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3RjY19jb29s
aW5nLmMgYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfdGNjX2Nvb2xpbmcuYw0KaW5kZXgg
OWZmMGViZGRlMGVmLi5iZThhZjI2OTQzNjcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3RoZXJtYWwv
aW50ZWwvaW50ZWxfdGNjX2Nvb2xpbmcuYw0KKysrIGIvZHJpdmVycy90aGVybWFsL2ludGVsL2lu
dGVsX3RjY19jb29saW5nLmMNCkBAIC02NCw2ICs2NCwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHg4Nl9jcHVfaWQgdGNjX2lkc1tdIF9faW5pdGNvbnN0ID0gew0KIAlYODZfTUFUQ0hfVkZNKElO
VEVMX1JBUFRPUkxBS0UsIE5VTEwpLA0KIAlYODZfTUFUQ0hfVkZNKElOVEVMX1JBUFRPUkxBS0Vf
UCwgTlVMTCksDQogCVg4Nl9NQVRDSF9WRk0oSU5URUxfUkFQVE9STEFLRV9TLCBOVUxMKSwNCisJ
WDg2X01BVENIX1ZGTShJTlRFTF9NRVRFT1JMQUtFLCBOVUxMKSwNCisJWDg2X01BVENIX1ZGTShJ
TlRFTF9NRVRFT1JMQUtFX0wsIE5VTEwpLA0KKwlYODZfTUFUQ0hfVkZNKElOVEVMX0FSUk9XTEFL
RSwgTlVMTCksDQorCVg4Nl9NQVRDSF9WRk0oSU5URUxfQVJST1dMQUtFX0gsIE5VTEwpLA0KKwlY
ODZfTUFUQ0hfVkZNKElOVEVMX0FSUk9XTEFLRV9VLCBOVUxMKSwNCisJWDg2X01BVENIX1ZGTShJ
TlRFTF9MVU5BUkxBS0VfTSwgTlVMTCksDQogCXt9DQogfTsNCiANCi0tIA0KMi40My4wDQoNCg0K
DQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQo=

--_002_17a637f633a7560ca87d7461fc56632e5f9e41cccamelintelcom_
Content-Type: text/x-patch;
	name="0001-thermal-intel-intel_tcc_cooling-Add-support-for-rece.patch"
Content-Description: 0001-thermal-intel-intel_tcc_cooling-Add-support-for-rece.patch
Content-Disposition: attachment;
	filename="0001-thermal-intel-intel_tcc_cooling-Add-support-for-rece.patch";
	size=1191; creation-date="Mon, 24 Mar 2025 00:17:07 GMT";
	modification-date="Mon, 24 Mar 2025 00:17:07 GMT"
Content-ID: <D569944361A621458A9A9AD3F63D2507@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSA1NWI1OGI4YmE3NDI2ZDhiZmRlMjZkNzg4NTVkNDkzOTA2NjkxOGRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+CkRhdGU6
IFRodSwgMTMgTWFyIDIwMjUgMTM6MzE6MzMgKzA4MDAKU3ViamVjdDogW1BBVENIXSB0aGVybWFs
OiBpbnRlbDogaW50ZWxfdGNjX2Nvb2xpbmc6IEFkZCBzdXBwb3J0IGZvciByZWNlbnQKIGNsaWVu
dCBwbGF0Zm9ybXMKCkFkZCB0Y2MgY29vbGluZyBzdXBwb3J0IGZvciByZWNlbnQgY2xpZW50IHBs
YXRmb3JtcyBpbmNsdWRpbmcKTWV0ZW9yTGFrZSwgQXJyb3dMYWtlIGFuZCBMdW5hckxha2UuCgpT
aWduZWQtb2ZmLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+Ci0tLQogZHJpdmVy
cy90aGVybWFsL2ludGVsL2ludGVsX3RjY19jb29saW5nLmMgfCA2ICsrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9pbnRl
bC9pbnRlbF90Y2NfY29vbGluZy5jIGIvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3RjY19j
b29saW5nLmMKaW5kZXggOWZmMGViZGRlMGVmLi5iZThhZjI2OTQzNjcgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF90Y2NfY29vbGluZy5jCisrKyBiL2RyaXZlcnMvdGhl
cm1hbC9pbnRlbC9pbnRlbF90Y2NfY29vbGluZy5jCkBAIC02NCw2ICs2NCwxMiBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQgdGNjX2lkc1tdIF9faW5pdGNvbnN0ID0gewogCVg4Nl9N
QVRDSF9WRk0oSU5URUxfUkFQVE9STEFLRSwgTlVMTCksCiAJWDg2X01BVENIX1ZGTShJTlRFTF9S
QVBUT1JMQUtFX1AsIE5VTEwpLAogCVg4Nl9NQVRDSF9WRk0oSU5URUxfUkFQVE9STEFLRV9TLCBO
VUxMKSwKKwlYODZfTUFUQ0hfVkZNKElOVEVMX01FVEVPUkxBS0UsIE5VTEwpLAorCVg4Nl9NQVRD
SF9WRk0oSU5URUxfTUVURU9STEFLRV9MLCBOVUxMKSwKKwlYODZfTUFUQ0hfVkZNKElOVEVMX0FS
Uk9XTEFLRSwgTlVMTCksCisJWDg2X01BVENIX1ZGTShJTlRFTF9BUlJPV0xBS0VfSCwgTlVMTCks
CisJWDg2X01BVENIX1ZGTShJTlRFTF9BUlJPV0xBS0VfVSwgTlVMTCksCisJWDg2X01BVENIX1ZG
TShJTlRFTF9MVU5BUkxBS0VfTSwgTlVMTCksCiAJe30KIH07CiAKLS0gCjIuNDMuMAoK

--_002_17a637f633a7560ca87d7461fc56632e5f9e41cccamelintelcom_--

