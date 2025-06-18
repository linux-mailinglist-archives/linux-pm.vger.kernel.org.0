Return-Path: <linux-pm+bounces-28932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7758EADE1A6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 05:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19920178DA9
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 03:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332B578F4C;
	Wed, 18 Jun 2025 03:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5ypii7g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A49028E7;
	Wed, 18 Jun 2025 03:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750217461; cv=fail; b=ihFSBvsaroEKGzB0O7vJdKI7bJbhNBsk/t0Bx8Icb9vPAUk/JmcFgGPnBQiD+wAwMErUsbBhr4EnOMshTAC+wqfZdQfRa2S/Fc9cJtkfgqYXeP6yYBGtwZDgQiLx/7d+fhFpFbg8NwYJ/QT8va6+K7wAvauBIUlqaJnueIgCswA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750217461; c=relaxed/simple;
	bh=UJlGdJO3Txh7468GXxKspbfDak+YCQJxDc3CHlqPLMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sCWvgKYDPc9/5bC174LzsYU3E1Rjz1R29aBusPHu/FLxw5nelkN4B3MC+P7xhtqbAI1TtjapgXKsUQamxbAbDhbbzpa0PpDQ/Svn11y+5WuLqkQJlN5RlF/UqYvsRwdcrdWaM6CkjJUYkDDqcAJhNS11ZNf9a4OKIlzir8abW0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5ypii7g; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750217460; x=1781753460;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UJlGdJO3Txh7468GXxKspbfDak+YCQJxDc3CHlqPLMY=;
  b=e5ypii7gyCWdEUirAHbq5QR3D7fRWSyFEGNITo8fprh7/A/1Q0BkmVeJ
   c8E2t9fKRCR77q2wjTY0N3zzj3xWn4fUmmsr8hCMHksZf4/rFpA5yJeen
   o01BP5NhJM3JBrF4zzFH+UyNfkc2GjsG6qr52YzNOt6N6NdbNG5U/JqK1
   Ih5WyG5I+UWnJNj3Lzcbkec7Vss+N5gShquXVy6SPN9T0Bj0Vib2tEs6t
   2SeL4k92jmUQrnahu1ZrUmsMfwBKsc7QznwDahIuNVeGziGaja9chiJK+
   AesdlOnwHO1BohCFcFVPXHTQ6/IZUvR6ksgXj0l7gz/rEtF2frz88n+Pt
   w==;
X-CSE-ConnectionGUID: fRCqC+cTSaifqpsfczuOkw==
X-CSE-MsgGUID: JvgToVDSQlCI53myYBc0Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52503320"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="52503320"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 20:30:52 -0700
X-CSE-ConnectionGUID: Ir2U6MTWQou8+1U+ZuT0CA==
X-CSE-MsgGUID: 1CWKzxW2TOSmUi18LlXMEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="180139914"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 20:30:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 20:30:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 20:30:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.65)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 20:30:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDSSwdqb2J6yZrT9DGz7yjCnfR3AjwbxVr8HRTkT7O/bvFclO/E3YqM355lnTeka5DE/jSnNSKCwWYbGGodfB1WN/IMtwOqwacvd//KeDoMNgVFyU+O7KvdnA4cEq84iaANZDnvlZJdUqg0pFth2IdiSUnPtwltgZ5hhvdxOXmd/TWqfmsoEHVO9PUvIHvXA9Nt/kxZDUB0TyffVqVAMutZcUxXCZmTDP+tEB4LvXRJ1d+q67BzLxe8NGS2MIpMHX0JnNbgqEotMtBvmUTRzgslNR71bxmH203uLaWTZdlePztJ0ZQktMbC53Py1jqQbkYI5An0r551QuEqePpKCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJlGdJO3Txh7468GXxKspbfDak+YCQJxDc3CHlqPLMY=;
 b=mz9kQMtTZFAp+yh8C0RmTkvo+92mEIjoQErZMMQnX2W7OwH1SuOFdqZGQCLT9A71yC03F2uQSMSzV76T2QQ8USpEtm0Q78w65hSJnkTTEbHE3q4JktPchCNM0QRmMj5HLzD6w2eMtJhEnqbojjhD89zwGv5dKCLRXaUReXLP6WBl3Pg31owTmQHCoVQs2b5rlwpcJkswM46FCaZa4IRy0I5A3I+6e98CloISbhUAZ8GagP9A/SY3PVigu8LcrRFQT4QvK8XVBBTeeV+utBTdrA3Ocrhab6RBqvemkrzHkRXdFZHDxWOsbv4zCgC20cG45Xo/4wZt5Jsfn1tQ9mtrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by IA3PR11MB8918.namprd11.prod.outlook.com (2603:10b6:208:57c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 03:30:39 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8813.024; Wed, 18 Jun 2025
 03:30:38 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "calvin@wbinvd.org" <calvin@wbinvd.org>
CC: "dedekind1@gmail.com" <dedekind1@gmail.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>
Subject: Re: [PATCH] tools/power turbostat: Fix build with musl
Thread-Topic: [PATCH] tools/power turbostat: Fix build with musl
Thread-Index: AQHb3IP23bUcxMzx+Ea9+TsNH5yFw7QBXQIAgAOmyQCAACXwgIADH/IA
Date: Wed, 18 Jun 2025 03:30:38 +0000
Message-ID: <6e18be89b937fa8fd2cc917eee6b3cd36dd26d56.camel@intel.com>
References: <7edd4c688111a697cfe913c73d074738b3d1dffb.1749833196.git.calvin@wbinvd.org>
	 <17f85f0bfa5446b86188616349b17d02fe207c22.camel@gmail.com>
	 <7325c49d7d2c407f7391ed30e3a7e0c8898bf5cb.camel@intel.com>
	 <aE-T0cZsdoCZOD_Y@mozart.vkv.me>
In-Reply-To: <aE-T0cZsdoCZOD_Y@mozart.vkv.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|IA3PR11MB8918:EE_
x-ms-office365-filtering-correlation-id: b5d1d400-62d4-4aa0-40d4-08ddae187ef6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eXdkSm85M1grSkpVWkw3NHZFWjR5KzJjV0xPaDJrWjU0MExNK0dRVnZVVVRX?=
 =?utf-8?B?YnJyKzZTVDJIWklzZWRtNklUMDg4S05US0J5ZXNROWRtSnF1M0tROWxpaWY3?=
 =?utf-8?B?UU56ZStiOERFZHNDWnZDL05xZXJQOG8rRXRNYUJsZGQ5ZG5sNmppOEc2L2w5?=
 =?utf-8?B?MmFXa3I5YnFaMkUvdTlRVWs0ejVDMUxQSlRZREFBZnFpMk1BWllqVkNpRE1M?=
 =?utf-8?B?Z2t6UTlvVURmSWJsd0NKYVJvMXFGTkJWdXNDcW1zZi9odTdDTEtnQ2N0T2t1?=
 =?utf-8?B?bjNUazBTcUpubndsbHRhemkrMmhnYzM5L3hXWWQ0dzZjQ29MeGZ6WEVUU0Uy?=
 =?utf-8?B?aFBKdjF6OW5jRWRJNktzeHlTVjJyNHlvRUxlVzM4QldTZlIwTUtRS2JtOE4x?=
 =?utf-8?B?bXZoa0RKWm52T1F3ZmZXZ1QzZnJOVFdZSlhQS3hPUzZxZEVkYnlOM1kxZktL?=
 =?utf-8?B?T0JZR1BneTlKcUFtWkJJZzh3b3FVS3NWMlhCQm1PcGxFSFZ2VCtkcDNiUkNM?=
 =?utf-8?B?TU1zdnlOdXBrTU5IYU9YeVM4djlDb1YrbmgxRm9vSlMyZ1R1Vk1NWm0vOFpR?=
 =?utf-8?B?NXZONXNDM2lObkhuVEJiMkF1dEVyRXUwNEZKT29oM3FFcU5BdEFZUkRYSkQy?=
 =?utf-8?B?ME1ZSCtsQUFnbDRoaXBFaTdoUERpSlAwNEdsQlQ1T1ZyWG9QelZBeUJOTzlw?=
 =?utf-8?B?U2o3b21RMHRtcGQyUkMveVc4RWtKT0JxMmZiZHZPWVp0QWRpN2dNSU5iZml0?=
 =?utf-8?B?aHdBMmFlVEZkZjBuZjkrQlFlNjJzZnRwZ1QwNEZkc0EyMlN0OFF2b2dFRTg0?=
 =?utf-8?B?N08rQkk3VWdXZW84bmN0NS9BOVlVemprOUNIRWVpYXYxc0lKMGpDWlZWY25r?=
 =?utf-8?B?K0t5Q0NraTI3aGFlTjhpTFUzZktlU1FSS1Z1WjVOeklMb0VzWC8xSldEeWVy?=
 =?utf-8?B?QzhGSFlvQkxVdjBZeTZzWlQ0a3BEa0t2YllFZjR1ZzlZd2g0cGtNTS84TlQv?=
 =?utf-8?B?NkhyN3ljQTMwNEY5SjdlNVQ2YjM0cjNRMDUrM0NpOU93OXR6R213YlEwNDNk?=
 =?utf-8?B?R0lYaUU0RGRseUFMdzhDR2dIVlE0NFpmUzExS3hXYUpLSmp5Ky8wNXhXVGxy?=
 =?utf-8?B?blVrUnNZL3MyZDFkQW14WFQ1VE9GbEgraG8xVVJuQkJYSE03UVQvRndLY1Zn?=
 =?utf-8?B?UEg2ZUZsRVhvaUxrRGdBaGRXRGtIS1JwMXpheEJ3dm1mY21nMXR3VVdxY3Z5?=
 =?utf-8?B?NUdYT016Z2E5d1VNSDBBbFNZUnJBSFVmNzF6bnRDc05LS3VWejRtaUFnaWUr?=
 =?utf-8?B?MzRXMXRKbWcvZXcxalJwN2xaOWF6RVJWREJmOXNNRGFJRkRBbVVsMXV4TVQ3?=
 =?utf-8?B?aG0yTiszanVZa0lVS3BmTjZaNlBWZW91YVcvbStvdzNFU1pBZ0UrV1I3TUNv?=
 =?utf-8?B?SkpCRkUyakEvTXQxZU43b0xXY1l5Q09wazJSUy9WNWhQY1BlemlaNWxDOHNP?=
 =?utf-8?B?WTJsZXJPR1lqc3ZlakZ3dkdiNktXeDJETHd3SmtOcVYzU3pPcFYvd21kUGJI?=
 =?utf-8?B?VTl5aEdjM05hKzlLWlJRZUZ4NGxrYWxON0FMK1lFV0JyRSsxOVlvODJSN3lU?=
 =?utf-8?B?c0FPYWw5alZWQy9KMHZrWkpYMmdaZXphUVNGV0JzTGx4TDhuK0Z3NzBMRGJW?=
 =?utf-8?B?b3pvRTVsaXRXNXJGT25tZ3BiNHUwbU9kalp6ZVIxUFhlUExvRm1lVVA5ZSsr?=
 =?utf-8?B?YTVEQmFpNnBnQitpTG4xNjVxSHBkYXRHNmVPZlVmTmxxRXd2OGRNcGtBalVQ?=
 =?utf-8?B?b2phMmdTdnBOcEhYRUkxZHhNOVdCRjhnRDhKVjRHbFF4blFnU211SG1pQ1h3?=
 =?utf-8?B?MGtSZXQzeTBsa0kzOC9vYy8zMlR3Vks2NkV5a1dKaDZZY0FBell2UUtkZXpS?=
 =?utf-8?Q?utO1BPYHBw0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTd1UFJRY1hjNWF6YlgzMytSakFXaFlDTHgrU1BINEUzb2RjWHJWN3FKNDZB?=
 =?utf-8?B?VG5yOFNJMzlxdEhmQXB1azJTMFh3Wlk0WHVCU1dNSmY5OVlPaDdENW56dkgw?=
 =?utf-8?B?NU54ZXQ4emxhMG05S2Z5ZEFYSkhsbEttUitMVFRWZUdHWmJqWUJ0bWIzYzZz?=
 =?utf-8?B?M1B2VjlYcmMxNWNSbUxCZDIwZnIzYmkydzZmY2QySHZXTDVBbmIwS2hpRUNY?=
 =?utf-8?B?Y05ZdjVZOHlNNW1mZWtQZVorMlhFUFpOR3IwRFpqaFBzQm1XWTZNb1hLb09V?=
 =?utf-8?B?alg5WTY3VGt4NmFvb3EyVUw1NDhQRFA1TmVGSnJPTEFqNWhieVpjRlZvd0NP?=
 =?utf-8?B?WTN0S2l5ZFhwQnA2UDlHcEJ6b3FNL0ZnbVVzVHVBLzhxcnhzOXROeUs4VUF1?=
 =?utf-8?B?aENNYk9JcFdwMjcxZFZteFVMYS95OEg3N1VVcXNWQTl5cC95WnJLOGNPYlE0?=
 =?utf-8?B?TnZjbTN3WmMxbEEzUGtBWC9QdnpPaExPOXB4d085ZE9Tbk5QdDdtSE5pVmpv?=
 =?utf-8?B?SWVaRUs3dy93S0w3K010STFhVkxzM2lqY0Zpb1BlaHZrZkovMG5wNzhlV1ZQ?=
 =?utf-8?B?K05CNkFmR0Y2UEYzVmQrbU9Ic0t0WWdlR2dYeFFnN3JoZE9hRDVLbWZDVEZN?=
 =?utf-8?B?S2pxWE8xeW5ITTRuamoyQVRJZDBZcTNJZlY1MldiemRqaHRzWWZoNzN1U2hI?=
 =?utf-8?B?WlpjUFdHTW9maVhiSDIwNjAwOWloalljNnNvSGg4cENwb0I5Mmk5L3UzQTMv?=
 =?utf-8?B?VVRtMU96Q0pNVWdPekJHeS9UNDJ6Q2xQVDZIVXVrMURxc21XTmVROWFoV2xV?=
 =?utf-8?B?d0dBTnZKdGZjdnZUc25GWTJocmxSM1pBSnpIRnNHOFpzT21ra2tTRS9zTGs3?=
 =?utf-8?B?MHZib0J5OURNa0tTU0ZrMFBqRUF0QTVPNTZuY1VPK1NkTmRlcVZhdTVlUSt0?=
 =?utf-8?B?QTBlK3c3YVIxNmFCdFdRWldWTXhzRXdGNktReEV5Sm9JQ2IxTzYySFAreTZi?=
 =?utf-8?B?RE93ek1IczFGbFYxRzJteTUxK0d1UUhMcHNyM3Vxdncxei9lYVpBU2IvaWJO?=
 =?utf-8?B?TW1tT3A2UStQVlRMSXZUdDh0a0NpRjhPVE5CdXFOT205M1g0L29XZW9mbENO?=
 =?utf-8?B?clErRjlXeVM3MW0zczk1bnNlMndkQ1laQk9OTW5ncWd5K2J5bUtpR0JqeEo1?=
 =?utf-8?B?bkx1dzYwVnJSalJWNkJ0WCt2Ui91bllYeFRJSUs0YVRUVUhyUExvQ1RJbG1k?=
 =?utf-8?B?aDd4b09mMDA1NkptSGFaSWtxM0xmbHQ4UzdxU3h6b3FzZS95cllmbWRHdWVW?=
 =?utf-8?B?NW1FSnpPYTNIQU83bTZJT29iR09zNTdSNzhHNk10eWwrMFUvNy9va0NZSEwv?=
 =?utf-8?B?NGQ1dmVyR0dyTTNKd0xNYVRrS1loUzVLa3U5VFJ0N041dTc0eFh5M2JQQ0VL?=
 =?utf-8?B?cWtmWEx2emlwaWgzUktnWVFkNnIzQVh3akVXZUFpeHpLRjZUdWdjaDUwN2xz?=
 =?utf-8?B?MlVuY3BYeTdRbXVwN0F6a0JSWXVWbVd4ays5V0hPbHprZVRZNVA3ZGZyMHV5?=
 =?utf-8?B?MS9VazJ6L2sxTmMyWmtlRGUwcEk5OXlua3lBNXA0dHl5SllUd2JJYnBHTkFB?=
 =?utf-8?B?TlAyd0tJeFgvOCt1RnNZU0FiZHRnVWc0S0FiU2FnZ1lMWitxaFRIM3FxRkp2?=
 =?utf-8?B?WTlOOUZXYUdwRStHV002Nm5UWk5iUi9PMkJoOTdsdlFrbGNnc1BMdGlmNlNK?=
 =?utf-8?B?R0VtWUNyazFodE55bHovNVZCUktObUI0ZHlzcUpMNktReTBycE0zYzJkQTBm?=
 =?utf-8?B?ZDVTblYvRUNwVXlFOExiZHRZakdTSlJIbCs2T1Z3a25VY1VkM0daOHRMVTNI?=
 =?utf-8?B?cFZyb0p6VXBYUXhTR3ZFVXNuTHdXSUkya1VPejlwWUdrbS9KdUtMSE15dmhB?=
 =?utf-8?B?V3NzUzQxWVdOZi9IM0syN09aL1Myd3VDSStRcDNqMTUxWXRMaGJZd21EZE15?=
 =?utf-8?B?aDF2WjhISVNhZjRGREE2aWRVZzlxQTRRdnhrelB6N0JZRnV4UERuQk82NzhY?=
 =?utf-8?B?M2s0Ky9yWmVrNm9MR2dsOXppWXNlTjFTNlg4SHpIVTlsOS9VZ091MkdsTkR1?=
 =?utf-8?B?NVMyTTh0WUQzV1hzRjhUNjdOYkh4QXFHM2I4Z3p4aTEvbC8yMU1WYjgrUEJ0?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <219B26E77C4DB149970C4815F6E53C4C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d1d400-62d4-4aa0-40d4-08ddae187ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 03:30:38.8855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /msiyMdgKOW9wQKw9/ByFt4ru4TRmKe/p9A5iFTjTUIWgjedBwEqCcSPgmWTGi7uwyNU5j14Yz50qF4xwDFSfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8918
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI1LTA2LTE1IGF0IDIwOjQ3IC0wNzAwLCBDYWx2aW4gT3dlbnMgd3JvdGU6Cj4g
T24gTW9uZGF5IDA2LzE2IGF0IDAxOjMxICswMDAwLCBaaGFuZywgUnVpIHdyb3RlOgo+ID4gT24g
RnJpLCAyMDI1LTA2LTEzIGF0IDIwOjQ1ICswMzAwLCBBcnRlbSBCaXR5dXRza2l5IHdyb3RlOgo+
ID4gPiBPbiBGcmksIDIwMjUtMDYtMTMgYXQgMDk6NTQgLTA3MDAsIENhbHZpbiBPd2VucyB3cm90
ZToKPiA+ID4gPiDCoMKgwqAgdHVyYm9zdGF0LmM6IEluIGZ1bmN0aW9uICdwYXJzZV9pbnRfZmls
ZSc6Cj4gPiA+ID4gwqDCoMKgIHR1cmJvc3RhdC5jOjU1Njc6MTk6IGVycm9yOiAnUEFUSF9NQVgn
IHVuZGVjbGFyZWQgKGZpcnN0IHVzZQo+ID4gPiA+IGluCj4gPiA+ID4gdGhpcyBmdW5jdGlvbikK
PiA+ID4gPiDCoMKgwqDCoCA1NTY3IHzCoMKgwqDCoMKgwqDCoMKgIGNoYXIgcGF0aFtQQVRIX01B
WF07Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgXn5+fn5+fn4KPiA+ID4gPiAKPiA+ID4gPiDCoMKgwqAgdHVyYm9zdGF0LmM6
IEluIGZ1bmN0aW9uICdwcm9iZV9ncmFwaGljcyc6Cj4gPiA+ID4gwqDCoMKgIHR1cmJvc3RhdC5j
OjY3ODc6MTk6IGVycm9yOiAnUEFUSF9NQVgnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZQo+ID4gPiA+
IGluCj4gPiA+ID4gdGhpcyBmdW5jdGlvbikKPiA+ID4gPiDCoMKgwqDCoCA2Nzg3IHzCoMKgwqDC
oMKgwqDCoMKgIGNoYXIgcGF0aFtQQVRIX01BWF07Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn4KPiA+ID4gPiAK
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDYWx2aW4gT3dlbnMgPGNhbHZpbkB3YmludmQub3JnPgo+
ID4gPiBSZXZpZXdlZC1ieTogQXJ0ZW0gQml0eXV0c2tpeSA8YXJ0ZW0uYml0eXV0c2tpeUBsaW51
eC5pbnRlbC5jb20+Cj4gPiA+IAo+ID4gTWF5IEkga25vdyBob3cgdG8gcmVwcm9kdWNlIHRoaXM/
Cj4gCj4gSGkgUnVpLAo+IAo+IEp1c3QgYnVpbGQgdHVyYm9zdGF0IHdpdGggbXVzbCBhcyBsaWJj
LCBoZXJlJ3MgYSBxdWljayBjaHJvb3QgcmVwcm8KPiB0aGF0Cj4gd29ya3Mgb24gbXkgRGViaWFu
IGxhcHRvcDoKClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uCkkgaGF2ZSBubyBvYmplY3Rp
b24gaWYgdGhhdCBpcyB0aGUgY2FzZS4KCnRoYW5rcywKcnVpCj4gCj4gwqDCoMKgIHdnZXQKPiBo
dHRwczovL2dlbnRvby5vc3Vvc2wub3JnL3JlbGVhc2VzL2FtZDY0L2F1dG9idWlsZHMvY3VycmVu
dC1zdGFnZTMtYW1kNjQtbXVzbC9zdGFnZTMtYW1kNjQtbXVzbC0yMDI1MDYwMVQxNjM5NDNaLnRh
ci54ego+IMKgwqDCoCBta2RpciB0bXAKPiDCoMKgwqAgc3VkbyB0YXIgeGYgc3RhZ2UzLWFtZDY0
LW11c2wtMjAyNTA2MDFUMTYzOTQzWi50YXIueHogLUMgLi90bXAKPiDCoMKgwqAgd2dldAo+IGh0
dHBzOi8vY2RuLmtlcm5lbC5vcmcvcHViL2xpbnV4L2tlcm5lbC92Ni54L2xpbnV4LTYuMTUuMi50
YXIueHoKPiDCoMKgwqAgc3VkbyBtdiBsaW51eC02LjE1LjIudGFyLnh6IHRtcAo+IMKgwqDCoCBz
dWRvIGNocm9vdCB0bXAgL2Jpbi9iYXNoCj4gwqDCoMKgIGdlbnRvbyAvICMgdGFyIHhmIGxpbnV4
LTYuMTUuMi50YXIueHoKPiDCoMKgwqAgZ2VudG9vIC8gIyBjZCBsaW51eC02LjE1LjIvdG9vbHMv
cG93ZXIveDg2L3R1cmJvc3RhdC8KPiDCoMKgwqAgZ2VudG9vIC9saW51eC02LjE1LjIvdG9vbHMv
cG93ZXIveDg2L3R1cmJvc3RhdCAjIG1ha2UKPiDCoMKgwqAgZ2NjIC1PMiAtV2FsbCAtV2V4dHJh
IC1JLi4vLi4vLi4vaW5jbHVkZSAtCj4gRE1TUkhFQURFUj0nIi4uLy4uLy4uLy4uL2FyY2gveDg2
L2luY2x1ZGUvYXNtL21zci1pbmRleC5oIicgLQo+IERJTlRFTF9GQU1JTFlfSEVBREVSPSciLi4v
Li4vLi4vLi4vYXJjaC94ODYvaW5jbHVkZS9hc20vaW50ZWwtCj4gZmFtaWx5LmgiJyAtREJVSUxE
X0JVR19IRUFERVI9JyIuLi8uLi8uLi8uLi9pbmNsdWRlL2xpbnV4L2J1aWxkX2J1Zy5oIicKPiAt
RF9GSUxFX09GRlNFVF9CSVRTPTY0IC1EX0ZPUlRJRllfU09VUkNFPTIgdHVyYm9zdGF0LmMgLW8g
L3Jvb3QvbGludXgtCj4gNi4xNS4yL3Rvb2xzL3Bvd2VyL3g4Ni90dXJib3N0YXQvdHVyYm9zdGF0
wqAgLWxjYXAgLWxydAo+IMKgwqDCoCB0dXJib3N0YXQuYzogSW4gZnVuY3Rpb24gJ3BhcnNlX2lu
dF9maWxlJzoKPiDCoMKgwqAgdHVyYm9zdGF0LmM6NTU2NzoxOTogZXJyb3I6ICdQQVRIX01BWCcg
dW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluCj4gdGhpcyBmdW5jdGlvbikKPiDCoMKgwqDCoCA1NTY3
IHzCoMKgwqDCoMKgwqDCoMKgIGNoYXIgcGF0aFtQQVRIX01BWF07Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn4KPiDCoMKg
wqAgdHVyYm9zdGF0LmM6NTU2NzoxOTogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIg
aXMgcmVwb3J0ZWQKPiBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgo+
IMKgwqDCoCB0dXJib3N0YXQuYzo1NTY3OjE0OiB3YXJuaW5nOiB1bnVzZWQgdmFyaWFibGUgJ3Bh
dGgnIFstV3VudXNlZC0KPiB2YXJpYWJsZV0KPiDCoMKgwqDCoCA1NTY3IHzCoMKgwqDCoMKgwqDC
oMKgIGNoYXIgcGF0aFtQQVRIX01BWF07Cj4gwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBefn5+Cj4gwqDCoMKgIHR1cmJvc3RhdC5jOiBJbiBmdW5jdGlvbiAn
cHJvYmVfZ3JhcGhpY3MnOgo+IMKgwqDCoCB0dXJib3N0YXQuYzo2Nzg3OjE5OiBlcnJvcjogJ1BB
VEhfTUFYJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4KPiB0aGlzIGZ1bmN0aW9uKQo+IMKgwqDC
oMKgIDY3ODcgfMKgwqDCoMKgwqDCoMKgwqAgY2hhciBwYXRoW1BBVEhfTUFYXTsKPiDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+
fgo+IMKgwqDCoCB0dXJib3N0YXQuYzo2Nzg3OjE0OiB3YXJuaW5nOiB1bnVzZWQgdmFyaWFibGUg
J3BhdGgnIFstV3VudXNlZC0KPiB2YXJpYWJsZV0KPiDCoMKgwqDCoCA2Nzg3IHzCoMKgwqDCoMKg
wqDCoMKgIGNoYXIgcGF0aFtQQVRIX01BWF07Cj4gwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+Cj4gwqDCoMKgIG1ha2U6ICoqKiBbTWFrZWZpbGU6MjM6
IHR1cmJvc3RhdF0gRXJyb3IgMQo+IAo+IFRoYW5rcywKPiBDYWx2aW4KCg==

