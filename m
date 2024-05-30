Return-Path: <linux-pm+bounces-8404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142048D45F1
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 09:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E5E1C217A2
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 07:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F76A1CD20;
	Thu, 30 May 2024 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVpHuqo3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F94F1B7E9;
	Thu, 30 May 2024 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053665; cv=fail; b=M5hqKHPnm9WrDrkiQ6CCs1CDGhRJ8HmGDrSJk/zVkvpOOL3favoavOyzWh9spUjmh2RFxe6XFf1oCyxmKuhFTwicGjMEWUcvx1BtUZAmGKOqcehhD0F9l/qZRymgfeklA5yqwhw63HRxxYvqQeDm5Hc9VUTeyxwQVO+HYNF+oSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053665; c=relaxed/simple;
	bh=EgeEdMEzeJltcQ7iWzqQAIaW4y9wuWX6s1dOp0Awe1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SJ6C7r9e5s9D5gRg6cracSSbEMrjtEiSicln6rpisk8sXgteQy3xitSJBEMwhXcgypG18ObETr1cnToWKvY6PaSPnrvFrua9lIAz+o1b9JxHkKrvouvfqrCs33Z0/H90/JCEGf+tuz/13TJd+pCX6S4l4kq7tNzoCpb8icQ7AEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVpHuqo3; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717053664; x=1748589664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EgeEdMEzeJltcQ7iWzqQAIaW4y9wuWX6s1dOp0Awe1U=;
  b=MVpHuqo3xEfCyF+iOQfjR7BQZRB5KQy+THEo6pwj4wrJVANA648MW80p
   MKZruHUvJ5re5EwyKpTtCB+436kM6WhEfvF69OBBK1bTjmJ366jB5N+ai
   RL2NgeQAiHBIjuKvzNFSz8qrSuZVb+0HckdQSL301hBD5NtouKHnjt6JB
   yGtjE6Oi8wLR+tpMo5Z5aWUdtN1f/4ASI7AK+Nwbi19GdOaUGOGJzT0d8
   6ndTHZRoSlDyXc1GMkA/X/5aIHsot14Qy2WqcglB650yheWJkfRg7bfZ1
   /oKZ9NjHtBhF5FA8uiHhMD1JFkoCY/4qkTcEkGTTuNZcJ5JABGwlv/Ld7
   w==;
X-CSE-ConnectionGUID: IgcKBZJpQqCBRV8NhVBtew==
X-CSE-MsgGUID: 8LuQa09+QROxGG/5Resa+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13457291"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13457291"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 00:21:04 -0700
X-CSE-ConnectionGUID: m2vbd/WMTZmSf1AaPzAc/g==
X-CSE-MsgGUID: IcVXYDdgS2iBYK/qOArUEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="73180121"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 00:21:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 00:21:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 00:21:03 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 00:21:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5uYYXtswWS0xS/e3Oq3ozuSKc/Ls4qljMew5NfHc5Z/mznOo+u39FF53HU0W79O3PSwNoTcDe5fvmCJuDTj/8rbDNd//d1iCbN+D6COg3o+PXtqIdZ9UfGHm2GcTb3a25lPLNa+TUulGBeYVRykbSgVe/Qwn63333lPewv5zh1j2pBOe4P+wiq9wggwfwTyrFSoIttJ7x7zxGURXtjuzgLW/unKuSBjdwAB+WIUHvhdG/E7kq53SseJXYNNmhWNoHt/n7a6ngJJxVO7hjldHgT1DW/IYf2IWuezYsyDbdGxkAqdnmQJJ7bBP00Ah4DwzGpyA3JzsCsoYEqp713JsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgeEdMEzeJltcQ7iWzqQAIaW4y9wuWX6s1dOp0Awe1U=;
 b=duqqjTUcptG2PRrGmV6sOkFl7n99OHtBNu1IEXKXoIONO/SIWoK39C7Juf+CNh5b7KALZS631xBYpnAbwUSt0+S4ldnuAJc1LC9q7EdakgEg9i6lItyXY49jt0IJ1v/xZZc5mYONJDe9fsaYgcl4SaxBVihVtVN/26Y4mAJdCguc866WDodEwuQefcdawpYfzNms70Z0t8CBH43K9JFHGusLfc87R4wdofyo0PSAQO2o82W37LIN2l7gt6f+qcuaJjfr0aeS+uN6drwiW1UfO19bNvKu5cbE7a1+JGAgtNs4lhvcPG8oR6BPFF+BXeRoMD2W7Fif4HEyH4ItLI4VnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SN7PR11MB8026.namprd11.prod.outlook.com (2603:10b6:806:2dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Thu, 30 May
 2024 07:21:01 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%6]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 07:21:01 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "linux@treblig.org"
	<linux@treblig.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: int3403: remove unused struct
 'int3403_performance_state'
Thread-Topic: [PATCH] thermal: int3403: remove unused struct
 'int3403_performance_state'
Thread-Index: AQHasfEeufqbYt15x0mp79cScKNUG7GvX/UA
Date: Thu, 30 May 2024 07:21:01 +0000
Message-ID: <cf30918b5db386910ee38a33f3cbc0bd7da34a4e.camel@intel.com>
References: <20240529175309.83294-1-linux@treblig.org>
In-Reply-To: <20240529175309.83294-1-linux@treblig.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SN7PR11MB8026:EE_
x-ms-office365-filtering-correlation-id: c6d35d59-b54a-4fdd-5ec0-08dc80790f23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eFovMGRjUnB0aVdCcmdQTGhIQkJLc2x1SThwejYxNnJzRnB3N3ZwdmphYy9m?=
 =?utf-8?B?SjhodG9mLzQ5T1FhRGRCT21ocm1OU256YUdlQlBkTXQwSDdUZHJTVTQzb3dO?=
 =?utf-8?B?ZzdQVkFpUG1jaHZqdHNJdUdxWHVvdFJJamI4SDlrZzFEYWxVZmJzdVFjenAv?=
 =?utf-8?B?ZndhTXJWTHMyNWkvZlpaWFlIZjZZTEpSL0lFU3pCeFVlOGVBNVR2QTNOSklD?=
 =?utf-8?B?RDMxclF3OVk2ZXFoTnVXNXhTS3hObGJNWFJsc0xnQ0dPL2hIak95QUV0K0lP?=
 =?utf-8?B?SUNRUGtPMmRLVEIyVW5yTGUwMitqRGI2QXFBT1NLczN4bGxsUzhpMmppaERl?=
 =?utf-8?B?OHBTdTJRZW9BaTFqdURpL3dXMWtFdXIzcWlacGxEdmFvNHAzV1NaN0lSNmQz?=
 =?utf-8?B?eGtNbTZjMUo5WXJFaFQ5c0VWWHlWWUsyL1ZRQ3g2KzJBSTNia3hzRTRuWll2?=
 =?utf-8?B?d3pjTmplTWtEWTJYK2p2ak5rRFByNkttc3d0VWVtUC9XUENUWmxmTXhNYlY0?=
 =?utf-8?B?bk45U1JUbnBHNnJIeWhvNlpFSmxZQWhoYzNCbkh2a3RNOWFZc2kxcldqYmJw?=
 =?utf-8?B?S1d3K2JzZmVDQUVUTDN1SlV2a1BMcURwc0NIQkhwZ2x4MHpGMW1INEpVVFE0?=
 =?utf-8?B?dTVnTmV3d3RndTlyci9BeUUvUWxUUUt3aFdMd0grV1A1TjN3ZWdWb2JYSG9i?=
 =?utf-8?B?cnczQmVQRGVuQ1NtQnNtc21CMkRidEcwdWIzTlJXT3JPK0g0S2FWRUFod0d5?=
 =?utf-8?B?R1NOQUIwVHo1Z0pQRXR5YTVKMjFxdUFxaHFhL1hZYUxna3FGbGRJSWxCUVJR?=
 =?utf-8?B?eFpITXZLQkliVk9mZmRkQjM5eTZHVVdVMm0zdXdGR3EvYlQ3N2NYalgzQ3k5?=
 =?utf-8?B?TnpOdVp3ajFZQTRzWlNkU244R2ozUmJrYTkzUGUyR1MyaEdadS9DOGIyVldw?=
 =?utf-8?B?SUU1RWhSMVprNXdSUXhyMGRFSWY4MTFzZkZidHl4MlEvamxVTHBZejdNQUhB?=
 =?utf-8?B?VGlkSVFZSVp1NFREZG1LNngzL2dTNk5MY3F1eHZYalYxbm9tbHg3bVZOT1R4?=
 =?utf-8?B?N0FVNGNDcEt5dXNWakc2aGdFVTVPdkdMelRnZkJhZnIwSHZDTkhkNCtvdGdn?=
 =?utf-8?B?UjNPVUozN3FBS2N4b2VSWFRkWkduVzNTSGlsUGhnSy84czBnRkhPQlJ2ZWJV?=
 =?utf-8?B?TUtWWGhsRlVhRFh6eU4rK3BUc0R6QklRL3Y3R3FndndaYTNaUUdHaUJLcWI1?=
 =?utf-8?B?ZURTaUhGNk9IRkJ4aDBMME1Ob2hGbE5nZFpadUhoWHVlVnVMb0FkN0JxYkdR?=
 =?utf-8?B?em9ESVpNOUc5TCswOVR3QTVzZmFYYnNPbzE4VVRMR0RoU3JvMC9qSkJYOEZB?=
 =?utf-8?B?amJQQXVsanNqNXI5OFY4eHA1WUl1dnBXbWdDbkhFUlRGMjQ3MjNPaGw3WGpj?=
 =?utf-8?B?cUVDWUZ4VVZSbFFuUEhyYkhrY3JodHlTaDk0dkdnT0hSOEsyZnBQT2ZhaWRT?=
 =?utf-8?B?UFRyM3NLL2FKdXlKNjNMUDBCbGd4ZGRSZVQ1anQrSnRRdU1uMGx1b3RyWTQ5?=
 =?utf-8?B?MVlYV3VkRFlOUFdyQmJGb3JERHQvazZNMXM5Y21HdUx3SUFPQjJieExLQy9W?=
 =?utf-8?B?YWhSNVgrNzNUUlFUZUo2QkRuSDlSTUJKUUlVejBNN2dubGVyWDM5cmxNWGYw?=
 =?utf-8?B?aUtXQVdtVHMzQmsyMlZhUVNlQzNLZGVldFowYzVBSnN1WStXRWtwV2ZsdDMr?=
 =?utf-8?B?S2U5U0xKSlZzQ0RrTW5TM3BZWmRwR0hjWHFWZUVKRlRRS1pwVGtpTTI2NGZx?=
 =?utf-8?B?ZmRIcjhXQmR5ZGhxWm1kQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHRXZGk2dzFpOHp0Y0paeUd3clQ1MVRQSElxbzVpSUJzekRpZDdDcGpEelZv?=
 =?utf-8?B?ZmMxU2dIUEFyMkVlUHpXNVN5OGsxeVVFZ2Z6RFQ3dlNhUVE4S2drL2RSa3pU?=
 =?utf-8?B?aFB5bERKSFNRN0VwN0pKSU16cmNFTjlHb0JMZVNZY0dJLzNYK2pBemptNnhi?=
 =?utf-8?B?SHRIMkF5eWRlakxMdVU4TEVrUURQSE9IWFN0VjhyM2ljNm1nYjRWeTRSNnZ6?=
 =?utf-8?B?YWxmS3pPN3IwZHprV1ZBTTJJeDJRZUVvVWkxNWlNRm9nUlBlNU1nNGlHSHFW?=
 =?utf-8?B?NmNpZ1U1cnZpcjM2MW15bm45VUZDWWhDREZnelRoeFB1VVJVR3Jldk9md1Rq?=
 =?utf-8?B?OG1ua1RxUUZQVDJWQU40YkdyS1Z4UExWSGNicnRoZjBVMW9nUXIvcGpuM2Zk?=
 =?utf-8?B?dUJvSTdWQlRPRFZDYnRrcGV4OEtwbTY4RkU0bDBvbnI2T2VjRmpQZ0lXSHZW?=
 =?utf-8?B?Z1hxd0UwSGx5M3dOaXRFQjV2SDJWTVp4NXpjWUJDRTE2QWpjRlpPVFZzOVVr?=
 =?utf-8?B?RkhXdDdxMUtsQThHRXhWbGY1MytJSjR6OXh3NVNLakdHT2JZZ2lWZW9jZXpp?=
 =?utf-8?B?WFRkaUQyTkZ4WjRkbmRIYzNXQnM1bFhkQ09yb05jSmZEaDNmc2tHWlRFU3RT?=
 =?utf-8?B?OERWMHBCVm11ZDl0MDd4dXZZYlNObE1KWVc5WFg4RW4vazdGMGVQQkorM2hL?=
 =?utf-8?B?enM4UHM3OTBPUFE3cHYrWnhHZ1UraVJvVHEyWDlwUmRnSFdOZDZXYVdtK3NO?=
 =?utf-8?B?R281V0xUYlluSGJxUkQzekVITmJIQkg3c1VYOXQwOHVjMUlBUkhheGczMHlh?=
 =?utf-8?B?RFhtdExyTURtSFlzaGc4NHg0T09HSEIzZ1FQak1FTnVBYmhTYWV0SFRxL3Zt?=
 =?utf-8?B?ZEdMcnY5ODZxQnRIMVIyU3pia25OQXQ1Yk1LUitxbm84TkRxSFFUNnZFQ1Y4?=
 =?utf-8?B?OXEwY1R0b0JNM3c3RzJFQmNKWmU3K25Zb25BS0tMS05ka3ArdXRTNjNodzNm?=
 =?utf-8?B?bkptMTJtcUJNWElCT0lHa2Z3L1oyNHdncHJhKy9NYkdFYzJoRkh4NGtIN0Q0?=
 =?utf-8?B?Q1FQSXdXTTdQZ200cUZGdGMrMm9IbjJUQmNEYkdvZzcvTXB1c1pxMmdyRkxp?=
 =?utf-8?B?TkpHUm51ZjJ1RHVjMzBRNjBJbC9NU1pWdlRlM050VnBNSUtvOWNRRzF4L2Ri?=
 =?utf-8?B?dmtLT1BDYVVsRmxBT1l0RnR2RjE4U0pQMGpVekVMRTBtMHJMTWdjdW5jM25a?=
 =?utf-8?B?ZDZQeHBiUVh1bUROQkpWbDBQcFM3REJ4aUFFVmErU1dYRnF3Yjk5NGc5aWN3?=
 =?utf-8?B?cVY1R3VQb0owK3hrNFIzWUY0endmTCtSY1NKMUJ1T1VDTzVFNWhjWUlEYmdV?=
 =?utf-8?B?QndEdkEvUGFJS0puSmd5SkxtQUpnOW4yWm5Ya2tiNTAvekZwd3pmNHFpaFJm?=
 =?utf-8?B?RzBGbHlHNWlScmhqdndqbmpaRkJ1b1JPSnE1eEgyZzcrUDV5U3NTeDFEOXJz?=
 =?utf-8?B?YkE3UWllbW1waUxWaEg0Qm53RENuZlQvT280VkVrN1VwUngyRTRSWFF4N1Ay?=
 =?utf-8?B?WldHWXMxWXIyZnRtcVljc2t3S0xNYkZyQkkwdWhwamRxcWd1bXZmSUhQTWgx?=
 =?utf-8?B?S3JtbHZVN2J3S2Mvazdvc0haQ0h4ZFRVcll1SGRaeEhUa01LbG5WTTdpdjNH?=
 =?utf-8?B?ZVhvY3pUN3NHZStKWUxLZmRmeDc3QmZQbDIzNU1KYm9rU3F4VGx2N0lSWHVZ?=
 =?utf-8?B?ZjBaVlNLc3NseGFvYitybUpyd1hCVkFrYmMvSlROSWZZUCtQQnNpSFYzQzA1?=
 =?utf-8?B?dVNxcWFLY3c2bFZpS3pSTkV5QTM1OXQrZGNwSUxiTHk2cW5leStON1A4MUxT?=
 =?utf-8?B?aFp6QUo1ckRjd09uMTVjSUVRUzJ4RjhRbHdpTDU1NHU4Mk5sVC9lbkU4bUxN?=
 =?utf-8?B?UUFQbWRyL1ZZaGc0YmIzRUNFZ1prd3NrRG96QkF2NTRqNjlsbVNqUE9yQzdB?=
 =?utf-8?B?cVFucDhFTExnSzRIbFVLcXdZVDRuRzdZVFN5TEo2SWduTk9wSUZyV2w1VGNU?=
 =?utf-8?B?R1ZJS0RkV29aZnVHRUx2Z01ERldGL29kZDFmZTRGZGJNdUNUNjc0N3lJVmNp?=
 =?utf-8?B?TUxWWnIrMFhvN0dFdFl0N2d6eHZyN2RWWnY3UFBvSlp6TFhyZ0o5RWFJRnZ4?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6868F3D350B9549AC8AEAF357A196E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d35d59-b54a-4fdd-5ec0-08dc80790f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 07:21:01.3097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eh902mWxoAhWnZnymq6TUcemT0o9707pxZ/Ruoy8lVSS3G7VAZ6AYTOeR8mO9QhjHT+ePBQRTNkjdEaqJxM8JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8026
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA1LTI5IGF0IDE4OjUzICswMTAwLCBsaW51eEB0cmVibGlnLm9yZyB3cm90
ZToNCj4gRnJvbTogIkRyLiBEYXZpZCBBbGFuIEdpbGJlcnQiIDxsaW51eEB0cmVibGlnLm9yZz4N
Cj4gDQo+ICdpbnQzNDAzX3BlcmZvcm1hbmNlX3N0YXRlJyBoYXMgbmV2ZXIgYmVlbiB1c2VkIHNp
bmNlIHRoZSBvcmlnaW5hbA0KPiBjb21taXQgNDM4NGI4ZmUxNjJkICgiVGhlcm1hbDogaW50cm9k
dWNlIGludDM0MDMgdGhlcm1hbCBkcml2ZXIiKS4NCj4gDQo+IFJlbW92ZSBpdC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgPGxpbnV4QHRyZWJsaWcub3JnPg0K
DQpBY2tlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KDQoNCj4gLS0tDQo+
IMKgLi4uL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL2ludDM0MDNfdGhlcm1hbC5jwqDC
oCB8IDExIC0tLS0tLS0tLQ0KPiAtLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMSBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVy
bWFsL2ludDM0MDNfdGhlcm1hbC5jDQo+IGIvZHJpdmVycy90aGVybWFsL2ludGVsL2ludDM0MHhf
dGhlcm1hbC9pbnQzNDAzX3RoZXJtYWwuYw0KPiBpbmRleCA4NjkwMWY5ZjU0ZDguLmMwOTRhNDIy
ZGVkMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1h
bC9pbnQzNDAzX3RoZXJtYWwuYw0KPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQw
eF90aGVybWFsL2ludDM0MDNfdGhlcm1hbC5jDQo+IEBAIC0yNSwxNyArMjUsNiBAQCBzdHJ1Y3Qg
aW50MzQwM19zZW5zb3Igew0KPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGludDM0eF90aGVybWFs
X3pvbmUgKmludDM0MHhfem9uZTsNCj4gwqB9Ow0KPiDCoA0KPiAtc3RydWN0IGludDM0MDNfcGVy
Zm9ybWFuY2Vfc3RhdGUgew0KPiAtwqDCoMKgwqDCoMKgwqB1NjQgcGVyZm9ybWFuY2U7DQo+IC3C
oMKgwqDCoMKgwqDCoHU2NCBwb3dlcjsNCj4gLcKgwqDCoMKgwqDCoMKgdTY0IGxhdGVuY3k7DQo+
IC3CoMKgwqDCoMKgwqDCoHU2NCBsaW5lYXI7DQo+IC3CoMKgwqDCoMKgwqDCoHU2NCBjb250cm9s
Ow0KPiAtwqDCoMKgwqDCoMKgwqB1NjQgcmF3X3BlcmZvcm1hY2U7DQo+IC3CoMKgwqDCoMKgwqDC
oGNoYXIgKnJhd191bml0Ow0KPiAtwqDCoMKgwqDCoMKgwqBpbnQgcmVzZXJ2ZWQ7DQo+IC19Ow0K
PiAtDQo+IMKgc3RydWN0IGludDM0MDNfY2RldiB7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
dGhlcm1hbF9jb29saW5nX2RldmljZSAqY2RldjsNCj4gwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVk
IGxvbmcgbWF4X3N0YXRlOw0KDQo=

