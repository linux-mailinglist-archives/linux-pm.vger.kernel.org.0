Return-Path: <linux-pm+bounces-28769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5EDADA586
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 03:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6846A188EB5E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 01:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5A235972;
	Mon, 16 Jun 2025 01:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SqsClHMr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F9360;
	Mon, 16 Jun 2025 01:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037523; cv=fail; b=JYf9QaYQLEv+ccLQgNfxGTXRwTkFCW//BM06ux9u37aC357SFX6K5Q4WoUQO5uggxj3A0Cf8g3qD7nS+rHgfsF+//ZrwAUWcx5dwgcwZ+Mb0HGEOyHBjtnJBtGeMgjSJBctYigSLXG9fH8DsVWUmdqp4xq1ncKMPDzm/VBRaBPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037523; c=relaxed/simple;
	bh=oxCcbU69UuDPI8UlLNDydc6v2FZ4FC9IAQVIBAkGHrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XRvFrrYpp+b/9vmPesRq+4YNKYO2Sqe+KOJ6dVMFY4RTxf2ms4/ST9Z/wg0xXaSIXgA026jY4M3qhI6kdb6fNTUo2YiJGiYHtLtfD4tcaJSxisncHIGTM1V5pWTqhzbUyd5uIuamOiMdNV2zyIwFMR50Ou6UlDwbprs1e2DsYzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SqsClHMr; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750037522; x=1781573522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oxCcbU69UuDPI8UlLNDydc6v2FZ4FC9IAQVIBAkGHrQ=;
  b=SqsClHMrpt4AlHmYzfjyn/xP4HwKvfW261rKDTnJ96L3ZqVLlSqbCy7e
   N6RjzuRgOC3e3w1MZztyziLXUNwGnP7T2xglnUc71cG14araxnQiBPmJ2
   pFlhKfATeO7isQshDnfrvps5OdmhT5fgzwcpm11gswTgBcjSz2Xo3GQZ2
   r2Zp6Y+03UpVVb6jkcmTRzSTPzjlZMENjlPY88v9z3d/jQgkii7zgXFhM
   p2DEKQKdaIPQxA3djpad0icvuTsyJla+JbBrS4t3nKiSUkxDfGWQEFCsc
   YicFl9j2EAj+fu302I+jT497/VaDAnQfOZqmSWiP64S9/ckVCRxJBWVTY
   g==;
X-CSE-ConnectionGUID: eLERpnzvS0C30zGZxF31kw==
X-CSE-MsgGUID: 98b8tgbRRo2qQ3pqyHK/eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52089736"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52089736"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 18:32:01 -0700
X-CSE-ConnectionGUID: jgOzgOtKTc+mDi1B5ZBnRQ==
X-CSE-MsgGUID: 8MscSWDbQoCI4y9/pfPmTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148881132"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 18:32:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 18:31:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 15 Jun 2025 18:31:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.65)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 18:31:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9T1iJjNwlX5fjP8Fhi3zdGJ1epxhKmhCxh/muY2v1F+BfbOVOv8NN+656si9NoTycHaR23WrBLZLQohFjYM1mE67nWQK+cOGU1wz7M0pWVnbkIsZQnxba/AplXeSgaFyKo9g/OX7AHeigoUOwL7L7xpJ+WVzoVh7Q1sxcsvk2bme+uNsCeR7PvNuG6kH2rQLuNGClKNluvQBe/ABpfryZZCsX27gq5xm+xNL0jkNOlWypp2Cy8TRrZDi0Lf+n7BCQSP8tCNJntXaDC2+bsQBaRYl/gYiJBofA2pZgZZnDMsiMZIoe7HE+1sLyOE3XsW/3EN/BSEQ9cVjsSUg3havA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxCcbU69UuDPI8UlLNDydc6v2FZ4FC9IAQVIBAkGHrQ=;
 b=CFgoG/Fp2hxkZLoJhA/kw9WF6YZuJ1FSxAjy4p5ND/Z4bJh42rHxZpu3c8xrObZ7zv0/1VNx1XOecjBg5hQiL+F45Z+Nfczuxl2YOnKdv08YGM0W6ioIxyH64w7qzBGannUux+aCM8YiaHPfiniQTB1x2aMg4N8iNRk4g0mcfjrC7XPssHLt9riyF4r1SxPHX31z8o35iU3xbP5U5PnYlo6nUUNytyTChwiLt4P5/4li70UOl0tF39xvmyUwMj99upqHcIctX8WZUj2JRYnj8mXDn7DJ0jxXIjASTOSX1bGPVshnLhIZewXNfc1lSEFtIxtaF2vI5HXg9tGyHjl/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by SN7PR11MB6969.namprd11.prod.outlook.com (2603:10b6:806:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 16 Jun
 2025 01:31:43 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8813.024; Mon, 16 Jun 2025
 01:31:43 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "dedekind1@gmail.com" <dedekind1@gmail.com>, "calvin@wbinvd.org"
	<calvin@wbinvd.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>
Subject: Re: [PATCH] tools/power turbostat: Fix build with musl
Thread-Topic: [PATCH] tools/power turbostat: Fix build with musl
Thread-Index: AQHb3IP23bUcxMzx+Ea9+TsNH5yFw7QBXQIAgAOmyQA=
Date: Mon, 16 Jun 2025 01:31:43 +0000
Message-ID: <7325c49d7d2c407f7391ed30e3a7e0c8898bf5cb.camel@intel.com>
References: <7edd4c688111a697cfe913c73d074738b3d1dffb.1749833196.git.calvin@wbinvd.org>
	 <17f85f0bfa5446b86188616349b17d02fe207c22.camel@gmail.com>
In-Reply-To: <17f85f0bfa5446b86188616349b17d02fe207c22.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|SN7PR11MB6969:EE_
x-ms-office365-filtering-correlation-id: f3304058-7e82-470c-f71b-08ddac758d46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TmdURHRuVHdSeGVuMGFFU2ZTWEtraGY2dEl2ckFYeE9kN3RhcWY1QTJGckZv?=
 =?utf-8?B?bFl0dDNoUklUcWZpelMrT3VaaUtQNVd1MkIrbkR6bUswaTNzWjNKUUhqdXRK?=
 =?utf-8?B?ekIzeU9HSlZRUHFoNVc5RUFUTlFwbUlwRDJqVkdmWGtJRlFaMUhrbnNtdDAy?=
 =?utf-8?B?SXZ2U08vME1OTTZTTy9VNkFUeWE5VFNpWGw0R2tjaDJUWHB2MVVxN01COVhY?=
 =?utf-8?B?Y0FEVXo3VEpkVzY4NExEdkZiUXEwQVd2K1ZOTjNaYkJLdm50Z1BrTVJNcHF3?=
 =?utf-8?B?cWt0ZkxjdXV2eGxISzVHWTgrTGN6VStoVHZ0Ym1JUEhFZ3pDWUovWHFPOXJB?=
 =?utf-8?B?N09Hb0NKQWtPeVJtRTcvRzdBNkJmK2hqVHliQWpmalRxTHViak5KTFZWNURO?=
 =?utf-8?B?bHRvRmtyZ2ZqQXgyejlBRVpHRk9HZzZNMHhYdHFKNnA5V2taVDArTlovTzhj?=
 =?utf-8?B?YmxBRDl2NEx1THVZbGQ0TWNtTEhoYXRaN0Q5bThaL3NxeFc3V0NjUUFtUEtW?=
 =?utf-8?B?ZG1aM1phOEVadTVmZEF5eFk2NVE2RVNVMm1FMlFxSHJCVzdXTTVmaFNFNTQy?=
 =?utf-8?B?aVE3bHlYOUpqbTJUZGtJRGJ2QndwaTl4enF3Zy9DWnpmVGxTYWFsQzZCaGNR?=
 =?utf-8?B?SzBiZ2lkZTk2ZitrOUxUbmxWZXoxU2pNRGlrWFk0VDFUdnJvajNzb3g4eEp0?=
 =?utf-8?B?YktUMzRDWGM3N1Z1YnZMcjFLOTFnM21HKzBMQkpxanczYmx1RVJhTVdqK2V6?=
 =?utf-8?B?OXl3eXJRVzNBVnBoVDhaQlQ2VDhPK1dwbUdGYWNCN2dpTkJzWWlHOGtVQ0xK?=
 =?utf-8?B?Q3ZQRE80YVFwVlVGeVg2RDNKUkIrRnNUTkE2ZkMzTlhTUUFKUUswQWlxZUIv?=
 =?utf-8?B?dVNod21FL0k5bW40TkVZSWp6c3Q4S0w1eDNNYXZZV21jdzBNTmNZNG9vQzJE?=
 =?utf-8?B?ZTdtWjZLSU5pWitkSy8yQzlsbW4xVnFjU3hhc1ErRS8vQkx2dkJObHg2TlVZ?=
 =?utf-8?B?dUJxKzFmU3diMS9TbnV0OStUUEM1Z1FuODk3SVIzbVJDaVBmdUZ6Z0RHa2lM?=
 =?utf-8?B?eGlYbFZobUF6M3FTSklWWHRjTUpvZDlSb3RVeE9idzhxKzlMMEFLLzR1b0o3?=
 =?utf-8?B?aHRIUDF1VitYdyswbGxsREFoZ3kzUWhmVjFXOGtKM1JmdjQ1dDNmbWVNRzNX?=
 =?utf-8?B?Y3NWb085TFFkSG53T2NxUkZTQWc0NXJBWEdmZFRKUW9CVEZQL2R0UnZLU3E5?=
 =?utf-8?B?SkdnVGFrTUJvVE1vdjhNYURpWEhRWG5FN08zdWl2MmxPdDlmT1gwZC9sOFdQ?=
 =?utf-8?B?OVRvTUFjR01XT3gza1F0SHBlWStaZ2lSWDVPTm52ZWJNeXVjQjlDQ2lGV2Iw?=
 =?utf-8?B?T3N6MytqSW5LM2VISFdRTG5RM2xMTlJKc0w0MXZWR3c2ZXFLU3BDVzNRWlBE?=
 =?utf-8?B?dmRNVWRuaW1LZmNZUjRMS2ZyTEY4c29QcmMwQmZyNVFUSko0NEdjTVQrdmZS?=
 =?utf-8?B?QlRGQ3pZdmh4azlFQWRKTkFTdU8wR1JsSGVxNXRFMWgyNkNleURPZm1mVGNW?=
 =?utf-8?B?akhISjRwZEpkZk5SVmFPYVBhRHJNQ0R4UzNLY1RlSnk3UXRkemVOTmtGSzRv?=
 =?utf-8?B?NUczeVV1UzVmWlJXK1VwTXNHTDB1eFBWNjhPNTd4OHhzSUkvVjRBSStzTWc1?=
 =?utf-8?B?bE1Zc0crWG9YRXArRk9CL0Q3Sk1keGJtSlJOMmN5Z1I3UFdmSDN5YUYrTWsv?=
 =?utf-8?B?bFhzNlVlKyt2a2dXRkNuemM5Nzd4NmlmaXk0RVRnZEZXZjVJYVhPVktaSW9C?=
 =?utf-8?B?NDZJdzdhOWtUdDFPUjY0QjllblZ4VUhiRzlXMEszejlRb1JXMHI0MWQ0bW1o?=
 =?utf-8?B?TWxMSm0ybHIyQ1FnUC90QnQ0YnprSy9GY3ZYdHNCdlJUb01UMTRoTlpGYVFC?=
 =?utf-8?B?M0tUWkdDdEV3SHNPUlFFcG03cWtvK3FzL2l4ZWdoZklpY0tNRU9JbEtKU2dG?=
 =?utf-8?Q?zyF3TlTc6tLt+xW91L2T8h6Qp4dc7E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVRLWDFWMTR6TjVBME5ESmtXMFdrZWpXaEpyL01RL1pCOGYxU0RoRnNxMDUv?=
 =?utf-8?B?eit6bG56dlkwYkQyRHdheDVhYWFRdFRhVytVd1hnSE82eG1SZlg5Wm5GT2I1?=
 =?utf-8?B?UzllVGNjczZ3bGtaTVJFS1ZZbHd1d2Vua1d4VDRYRWZlNW1JM1J0Q0dsWXBK?=
 =?utf-8?B?WXpndmF3cXd3MUEzbWZoTHNMYXJqcTI3VzlFTWs0WGR5V2hTNjV6UlZLQ0tG?=
 =?utf-8?B?aXNXMU9MRWlMVVVpdDZyTWdONkpvS3JzNHFZVEVpbnFmaWNzdWxmZ0FmbGxB?=
 =?utf-8?B?WHVzdUpXUFZXQzhvMVJTNEc3dVRsOGRiZ3V6S3Qya0FqdWUvcklqb2hEb05q?=
 =?utf-8?B?cWtQS2VndEYyNEJvQk5BMFg5SCsvNGl0VFd6WWtGbm9tZ3FUUW9hTWRzWm9s?=
 =?utf-8?B?TTNqUzNLQnJYQzU5VTRGdDBQSFhVdHhhdEJJRlI2cDNLNUxud3RoNFdjclhQ?=
 =?utf-8?B?a3FTNVZSc3gwU0FPb045Smg2bmw4RTRRZFpiMkFwWUZGQmFLR0haNUozTGN3?=
 =?utf-8?B?TFVzSEtlUlRlK2g1LzdoVTNjd3VZcnVLSFVJdVlHcWR0L0g3U3oyNFUxMklU?=
 =?utf-8?B?Y0MzYU5lc01La3l2aVY4c29IYTNHSDRyay9XMldJWWdkZHNPUm5XMDY1N2xQ?=
 =?utf-8?B?ODlJc3BXM1UvZ3VoMVQwamsxRUtaa0JzM0JXN0JmNmk4UnM1NEthNHVRdEtw?=
 =?utf-8?B?d2wvZFRjTVVKcWhxcU9rMUp1Yk1UTHBkSWxFRTlVMCtuWUh0U09KaEJBelRG?=
 =?utf-8?B?VEtoMXhPaGFDYkl3cFB0dzFtZVVlcndFZU5uQUdUMndLRFBVZ3ZzakczTGFP?=
 =?utf-8?B?ZlJEQmt5a1FZRGtYbkV2a3VnZVVNWENqY001WFhXVjkzM05ndGZYaE1jcE41?=
 =?utf-8?B?dXEyN0tVcUx2UE1BekNsdUQwRHJVcU4zZXQyODVKSG81V2dCS1JjZHRRVVRJ?=
 =?utf-8?B?TFljVTE3SnhxTU8wMU12ZEdFZFhGYlhWTmdXQ0hNS2p2allKMWNjSmRyTjBJ?=
 =?utf-8?B?aDBjd3c1TXNPVWlML29ydW54eS96NE51YnN1cDc2VC9Mb21PUTdMK0UzbVJT?=
 =?utf-8?B?cFlkU3BSU2lyWGhzdnBzdWhrNkVoZEdwaVp6OGNhZ0M2M2g1ZklkaWF6QlVr?=
 =?utf-8?B?TkxWa2ZyQ3N5OTRmelhvZnR5V2t6T2pDVE5ZS0todXFmYW1mWHVDUVB5Yjlj?=
 =?utf-8?B?TDJKcC9UVUNLaWNBbnpLODVybTZpclRMWkRxM0ZZUjVtQm4rTjFUV2o3RnFH?=
 =?utf-8?B?blk0Yy9nem84RDJwbEw5MitIbkg2ZDFtbXZ6ekxkSk9qRmFYQXBzQ1ZhTURi?=
 =?utf-8?B?bUZWUHE5QzNsRVdVVlRCdDYvVDFiK2pxT25hbWhxS2pNNGxlNHM4SjRjbUpv?=
 =?utf-8?B?QlFNS0p2RXN2bTFYY0Vlb0RHbm4wT244VTF3LzJMQVUwWXF4amFLdjQ1TVRr?=
 =?utf-8?B?bG5Sd1VpS2VqV3NiT0ZlajBmVlMrcCs1VjZrbWdDNzRuUmFlN3NST1Ayb0Jt?=
 =?utf-8?B?MFlZWnhackhjSjlNdEQ2YWkwY1Q0amxRUHF0enVjakhYbUQvVWh0YjZEMmVs?=
 =?utf-8?B?OGNqRkRkODhpaDZEdE1wcVlXZUs5Rk5EVk1jaU42YzBTeW9qdEhiNFA4eEg4?=
 =?utf-8?B?a0RuOTE1cTVucm1PRG8yWTduK3d6RkxmSnloVHFhQlhFUUZ6T2YzbDFxYjFM?=
 =?utf-8?B?UFhrSXFjN0RVMDJPUzRVQ2Z5YlJwQnlTVGlGRGlOMU5sOXJXTHMyckhxMWY5?=
 =?utf-8?B?bWlQSllvTlRzV0hsNWtVVmRtSnVzcCtUanJjUlVsaTZQaDBLb0hPaHNXY1g3?=
 =?utf-8?B?R0E5eCtseGVDZVhHZjJCTVFFaVVZdThoOHVaeU96alJJNVRmQUxPbVJPQkxW?=
 =?utf-8?B?anJoMk9pOUdWR3UzSDZnRUF6dS9kYjUxMkJzVFEzckJPWmNGemdGazY4QTdI?=
 =?utf-8?B?ZFVTd2lBNk10Y0NIdGVNS1FSZXM5aHpqNGlPejFDdXI4RldnNS9Ybk93Zkww?=
 =?utf-8?B?TGdFSVRJbTZnV1FDcys1TG5jeTB4UXlGOW9iSHVvZ1E3Z3p2WnNkUzRSSStp?=
 =?utf-8?B?TU9iTGFzV0tiUE9lRnAvcERBWFZpSlJSTXRRWUlQT2ZPcGh6VVJTZjZNdGFI?=
 =?utf-8?B?Tk8zdHYyZEx6blRObDFsQnA4VndaY0ZUWVRFcW9EQ3JVeGpNenhBUzcrbGdR?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FEAC653F2DAF8499212EA91AAC29E1F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3304058-7e82-470c-f71b-08ddac758d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 01:31:43.7429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBWJHknO2sQ2ISy5r06WY4T2zXX0IF9p9IAhV1vw9GUNAWjQyguwoSp89L+Gbl0Ob+Gkfrb5/wHT6UignrRQhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6969
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA2LTEzIGF0IDIwOjQ1ICswMzAwLCBBcnRlbSBCaXR5dXRza2l5IHdyb3Rl
Ogo+IE9uIEZyaSwgMjAyNS0wNi0xMyBhdCAwOTo1NCAtMDcwMCwgQ2FsdmluIE93ZW5zIHdyb3Rl
Ogo+ID4gwqDCoMKgIHR1cmJvc3RhdC5jOiBJbiBmdW5jdGlvbiAncGFyc2VfaW50X2ZpbGUnOgo+
ID4gwqDCoMKgIHR1cmJvc3RhdC5jOjU1Njc6MTk6IGVycm9yOiAnUEFUSF9NQVgnIHVuZGVjbGFy
ZWQgKGZpcnN0IHVzZSBpbgo+ID4gdGhpcyBmdW5jdGlvbikKPiA+IMKgwqDCoMKgIDU1NjcgfMKg
wqDCoMKgwqDCoMKgwqAgY2hhciBwYXRoW1BBVEhfTUFYXTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+Cj4gPiAKPiA+
IMKgwqDCoCB0dXJib3N0YXQuYzogSW4gZnVuY3Rpb24gJ3Byb2JlX2dyYXBoaWNzJzoKPiA+IMKg
wqDCoCB0dXJib3N0YXQuYzo2Nzg3OjE5OiBlcnJvcjogJ1BBVEhfTUFYJyB1bmRlY2xhcmVkIChm
aXJzdCB1c2UgaW4KPiA+IHRoaXMgZnVuY3Rpb24pCj4gPiDCoMKgwqDCoCA2Nzg3IHzCoMKgwqDC
oMKgwqDCoMKgIGNoYXIgcGF0aFtQQVRIX01BWF07Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+fgo+ID4gCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBDYWx2aW4gT3dlbnMgPGNhbHZpbkB3YmludmQub3JnPgo+IFJldmlld2VkLWJ5
OiBBcnRlbSBCaXR5dXRza2l5IDxhcnRlbS5iaXR5dXRza2l5QGxpbnV4LmludGVsLmNvbT4KPiAK
TWF5IEkga25vdyBob3cgdG8gcmVwcm9kdWNlIHRoaXM/CgotcnVpCg==

