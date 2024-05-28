Return-Path: <linux-pm+bounces-8224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FBF8D1495
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 08:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A7C1F23B40
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 06:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735D161FF4;
	Tue, 28 May 2024 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnZIXQUh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F9F61FC5
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878406; cv=fail; b=WurG8R8ajyiIWs6jU2yxGs6sG7Czw0KX0/XT1PTWClJ0XrbPi2XIlwcSld1DjSIcVprXoY0Lh0cSuCISor8CAUIYZRc9wL1ggkgaLkvGDbMS06cps6lYaRTZREBHbebMRtyQ2soxFyiVuGC4Jh+HgvTx9lRX7jX30GQrUlfEX7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878406; c=relaxed/simple;
	bh=sUElqut45HbK731jzpP5Ak9rEBK33A1FdBhkdx+R0O0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RJTIQVPYw9D//T7ZIgrjpPi5qlOkCk8E7PLR7al3ifwCVTN3o8x/Cu29t4xVqkXkT1a59zxKU6FkuP17bkOrNABtqyr0UTrI5eKopASVWRBKmy7dFMfUBDKnGic6m0pwgpN7in2+XkCam8YHYabVXnMLAd3DnW5kYzr7+5PU5+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnZIXQUh; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716878405; x=1748414405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sUElqut45HbK731jzpP5Ak9rEBK33A1FdBhkdx+R0O0=;
  b=DnZIXQUh7Fmt6biB7TYQQRK47g0PpLJVr2uIV/Gr3KQi/PVkthkde36x
   EuAaMQRYdwsBlGJCUH7LEQrNKvcyPAQWM7hdIwcb39xiVjZwgvOQdUX/i
   iuzCNd514CCzUyPbYhU1MGZAb3UFH2nWv5LNLwcjCJHhvIPI9PjOhKjBQ
   T5Y/BnbUTF1qDjwpkynWF3piHYgO+k/IJn+J11/8TVnpCRDdAKUtO6Icz
   Z6gjtcEwgzqJN2ZKZTI4gRX0yKWPOTRvToIyG92MjfQY1Cmpl1GxnVwWG
   S1HZsU7apX6Qe+6v+rl+TyOrsbMjw1T+5ZWtWlJveBo+nsvycOs8bhRjJ
   Q==;
X-CSE-ConnectionGUID: b34A6DgyR2G9nL83K9nSxA==
X-CSE-MsgGUID: zqExFwzpT5evI3ZFv7m6mw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13325527"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13325527"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 23:40:04 -0700
X-CSE-ConnectionGUID: ZIyVKQU/Q226E5qK8eQwZA==
X-CSE-MsgGUID: iyqA4ugDRqqjR9uojx0Xkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="34884477"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 23:40:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 23:40:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 23:40:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 23:40:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 23:40:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8CrMGVykVlmx/uA5CHYX3vbpNjvgwDAW004x28gHrZ9EoHSaI42PChCfzHv1fDXTL/gMSTMu3DcoU5Ajrgb5vNymuor45ZsYFuqS5gJdTEU5Nis5jzJVY/paoQg1WWPL8zeNjx6ZbyqjJA77mJojv+einEm/D09eaSwX3xqcE3FPge9psfoaBD6Hq3gZbH0I074/Wpz7EVhtulTZVbJRmiBMUiKJUrfPEkLs/ZpwjtJV7X5kxJxrbT6AYc6yTkzlbgiMuso+FD9tKODXvlUWOC5OThqzxapReRrYrX3ShTxyfF0WnJZpsExliV5SoJO6N7OcrUqTWcxMOHMgIevDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUElqut45HbK731jzpP5Ak9rEBK33A1FdBhkdx+R0O0=;
 b=jgiPwMB3aIiYvDoC3r8L9uWqTzrwpxMYhRoIssG2pp78jta+bj2c/FQuXm/GwguyQ7JI9Z+HiQ6qkfgKFlAI2tqckEpwnhBuFbEvthYnuvIxSrc0wwPkuIQ9BHFRmI4kGjQARb9n88WwOxXrddiBAMZssMyeaUDAjI4M/yg6jcspVv6SR+ghvcT2OlFaX0IrTExrXlSaYBwTe9zgRSP9vE1lCBlvb0FX9l+I1EOV4x7tx2SjpLOqDnJPiFyUjnEkhxF6qS7VV1NqkXDYHGBW56qvOxLT6bqoouXRHueSMxVEZ8/r0OCJmHXtFzByjTyFJWmFYv2wWbhRF65lnPYXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Tue, 28 May 2024 06:40:01 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 06:40:01 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "Zhang, Rui" <rui.zhang@intel.com>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: powercap ABI clarification
Thread-Topic: powercap ABI clarification
Thread-Index: AQHasDVBmt4fLub+TEqhVM90qIokgbGrIT8AgAAZboCAANx9AIAAHCIA
Date: Tue, 28 May 2024 06:40:00 +0000
Message-ID: <c7c033a64ec6fc2247bf7c922612e6f889c86597.camel@intel.com>
References: <59e5a949-ef20-4f11-a0a7-247c457f1dd3@linaro.org>
	 <9c97e4f8549744b1e2464a3b632f0716514ff55c.camel@intel.com>
	 <084eb643-f410-4e66-9561-4dcf5924dab7@linaro.org>
	 <5cb71aef90ebd2d613f0643446b8a1db049f4d50.camel@intel.com>
In-Reply-To: <5cb71aef90ebd2d613f0643446b8a1db049f4d50.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|DM4PR11MB6430:EE_
x-ms-office365-filtering-correlation-id: e1ecde48-937f-407a-a877-08dc7ee0ffde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?LzY4RHdQSlZyaGxQTmdnN0s5TFJzWlQ0QTZNU0hXWTd4Ny9aVVorWlRqU2My?=
 =?utf-8?B?bnNwVXVGM2VpVXhVODcvVHJrdWRTV3lHcXpTTjRTN0F2eWVuMndwRjQ2QjIy?=
 =?utf-8?B?TjZEUUdWZWRvZkdhVkY5T3l2SGdPUEx3d2syeGhOd0tPZjdrU3hQME4rM3Mr?=
 =?utf-8?B?YVRNWEhSS1Z3YktVZThEaE5vQ0ljaGZ1V2E0Q3VoQzQ0NVJhOXNiRjJZUTdO?=
 =?utf-8?B?VkgvUElNYWt6eXVSaGQ4bEYvN3N1MHZ2Z2FvckYzZy9jdGFjK2ZLY3lkWXB1?=
 =?utf-8?B?ekN3ZnNqejhkblJYdTZlYnFrclhzNUV4T2FKMExBRERwamp3aXQzT0luWDdt?=
 =?utf-8?B?MVA0aFN2Z3JycnQwN2dhaGk2b0JFUmR5K3BvRzNOMk41RlhMMW5qQ3FzQlVr?=
 =?utf-8?B?eUM0U3VvTFJVM1IydVByeUFHV2syZEZIcTRRK3lJek5Gb0JzUDFIcGF4YTk5?=
 =?utf-8?B?VXBtNEdXeTQzbVMrWFJBSWw5emhGOTRIbFRpR3JYN3pZUlNDOFN3N1AzRGxk?=
 =?utf-8?B?SENCYVZhNTA3YnIwYWVKSFlCWHYwR1dkQWU0aDIwaDB4a2JJUE1ZNThLSVJY?=
 =?utf-8?B?RFBKaWM3S0FOVHVvS1pTOEUwUjVNT1hOYkR3TFhzUTdtM0pwREU1d0o1TUg1?=
 =?utf-8?B?SENGSWo2cHpZSkR1ZzUzd1k0MnI2ZU51Yk1OWkUvcHBJYTRNenk0alVtVENl?=
 =?utf-8?B?bHc0TmpDMVlsSWEvSEc0eUVIM0x6ME91Ym5NMTVOa2o0QVpYYWZwa3p3dmRI?=
 =?utf-8?B?K0IvRlZGYTlZOGJyNmthNDMrd2pFQXdaSHBVRG1OelVWSGlFZW1FY29hM1FG?=
 =?utf-8?B?eWp0anpLSFRQWVpabHBQZS9uN29CYllmSWR3S1pocGpiV1RjQWtpaFhsSjJW?=
 =?utf-8?B?THBnN2xJUG93OFRETERnb2NTUzkwYnVXb1M3dVdFQTJuckxqbzNBUUpLbzE4?=
 =?utf-8?B?WlRCdm9UMmFFSGc3T2VLeGRJbUh4SFZQUTc0bnFsQ1lnK0d0Z3gydzI5dXd3?=
 =?utf-8?B?eUcrZFdZRzA2cVZpNFRDTGtGWkdDYWhFenJDaElGTmZBOVU5Vk52UjF5ajdY?=
 =?utf-8?B?S1htVHg2L1UxcDFrNXBtNDZRWG9jUlRxWGNtcjZLR2E4MEVadEhTMDhyQlNI?=
 =?utf-8?B?RXNET3dpcmJ1U3RhbjJTNEhFMm9KM0RKc3dGNnZLUU1xR1p2aE43VWxCZG1w?=
 =?utf-8?B?b01lZ1hlZjJ2dlZ3OTFGRjNIcHYxSVFMSjUvQlovSUNQOWFLQ1pFYkpwaFhy?=
 =?utf-8?B?VkdSRDRPNytzbVZMa01YUFl0Qk9SYVRDcFRQdmZJNWp5NSt2Mm1hRmxhb3Q5?=
 =?utf-8?B?Q2dYTmJPQmQ1RlVRNEZGZm52OTl4OGFEYnc3dWZQQnpxZE9JTURvT3Zhclkv?=
 =?utf-8?B?T0tUby9GUy9NdmRVbDdUWXpHamdtSm5XVFg3TnVTMTNVK3h3OTRIN2VDYWJS?=
 =?utf-8?B?TVZqK0djQStmNHJOaS85WU1idnNRdmNJWTVOSDdHUm9ETC9EdGd0RzFvSXdj?=
 =?utf-8?B?eFJ5bUhscWhQcFpUYzFGVzNQOHJ1QWlvWWFmOWRNMVlzQWU0ZFpPZ1p4eWdm?=
 =?utf-8?B?TzMxam5PRnF1TVlrTXRoSjRNU0RhdHdJSG5KVXQ0cEI2VjJ3eFU0eUZZVk1w?=
 =?utf-8?B?VERWQ01OcDRZckp4amJVVWlrZlB0WktBSUl1bGlPWnpqT0lqSmttK2hXRjds?=
 =?utf-8?B?WkFUdW1LVis4VWdUT2VldjZ3MDFNdGl2aHZTVnliNFdiT1dkMXRObXZYYmFa?=
 =?utf-8?B?OWp3YUFyQStPSjZmSThyMmxOR1EwcHE3NkdWVnFIeGVJVzBZdVNpbjFYb25s?=
 =?utf-8?B?TDAxNzFsYUhDb1RyN2RmQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T25ZQmR5VzFqN3hDRUxicGhhM0lmcUs1dHZtRHJ3ak1mMkV6U2JCVDdac2Nw?=
 =?utf-8?B?TjR2cm5EekNCN0NrT1YvSVcyNXpXd1BHVXBGaFZxTDNicUZGVkhrL21DZk1B?=
 =?utf-8?B?OHVWWkkvK0ZQTWhoMGNKTHJBS2xBaC81ak0zRVV2TDhzb09XdlIwTkFBQlNP?=
 =?utf-8?B?VUdISWtQTnFWNEN0Z1lRNXROalNRdVpHZ2RNYm1mTEIvWloyazlwdzNsSnV1?=
 =?utf-8?B?RjdxZmUrT0NEVW4vMFAwZ0Y3N1o5OTg1WWo4TVBLd3NrSkpWMDVNdjRZdDNK?=
 =?utf-8?B?NUExZEJiWjBBUmdJTENvREJNMDN0VUZTaXpzMnorYjVITEFMdHEyWGVQQUJT?=
 =?utf-8?B?ZXFyTjBCbjdid0EyMWFWTTAvUVdKbmR2K1hxMWQrTlJSbTQvUDFWRTdXSjJt?=
 =?utf-8?B?MXc2WDVrZ2ZRK01OSmVZVVFvK0FIZUl2Rm1kSUtaRmtMVE1DaGxQdGw3TXho?=
 =?utf-8?B?eE5uY2RIVFNWQ2lHQTFNN25pdUd5TlhqeEQ0MjJKVDRZZVNOZ0ZLdFZsMmNM?=
 =?utf-8?B?WlVHeWF3VkJHNTdFVDU4QWVYeVpCOWZ0aVg5amdIMituRTFKMll3UXM1d0c4?=
 =?utf-8?B?dGViRmswNS9pck1qeGlUd2ZVckw3aGNnaWhuYTQ5VHhCd2pUVTJsSHI4Q1pM?=
 =?utf-8?B?bzRLTVp5NnovM2JDNXpKVGtJTHl4VlowT21jN2htb3BrMHB3TTRJY1VuQWli?=
 =?utf-8?B?aDYyaTBOR1hMMTVob2IxQzhGQ21KVG9IVmtxaUZqcnV0MzVuYi9GWDduS0x6?=
 =?utf-8?B?alJyWXhib2IyUmRDa0JYcW4rdTZ4ZHBHY3ExOGJlR1dEZFJaNHRSdE1LVkZ6?=
 =?utf-8?B?d3pWMlRKYVFqM3pNK0JqbzNucTlMdU9ZTlhXTHUxTHkraW15SWhSK29NTXQy?=
 =?utf-8?B?L0MrK0xLRTFYT2xuSkErYXM3TFhlbjZ5MFE3aFBGWWRzNGh2N0NucDJzMTJu?=
 =?utf-8?B?S2hyeGJIeDkvRlU5Mk4yYlBqbWwweUdiakREU2N6ZkcrMWYreXZlb0dFZFBt?=
 =?utf-8?B?OHNFbWYrbHVXWml3L0dkL3dGak8vZUlJVDlSYllLZld1enZLUzVMemVmYnlJ?=
 =?utf-8?B?TDZzNlFCUlM5R21UU0oxNmFuQlcrU3ZVVC9BR29aYWFZcWZhdFV1K1hQZlBy?=
 =?utf-8?B?d1RsOEpGTFBiWE4rTUJ0bXR6VFF1YnJMZ2pXdUFEblF5NERNNTFaK2FhUWtm?=
 =?utf-8?B?OVMyQm8yOVZsNFJ2YmVWQTNUNmVvUmh2Ukh4WGZTUTg0dmU4QmFBbDJCcEht?=
 =?utf-8?B?VTRkaGxFakduZnBKZDlCc1gxd2lHOE9XcGdDYmFIaWl5bElwdC9NbmI2YlhM?=
 =?utf-8?B?clBYbnAvR3FFM0EzOEtlaXhXaVJaOCtEREhKZXRnQm1zRDFTcEhVWEhhcjlr?=
 =?utf-8?B?Um9vTmxFRE82QkVFeUMrdTVTT29YcGpPMWk1QWpRNzBKV1FSNEJVOE1CTDRL?=
 =?utf-8?B?RTlJRWpub1JrUE44aDdXaE5MTmw3V3V4ZnRZdWUyMVNueS9ZNndWUjZIN2dn?=
 =?utf-8?B?anN2YXRDOERMTzZiSm1yMkxzRVh4bHFJRnM0a2hMT1ZjejBoMlVPRjV6aVFT?=
 =?utf-8?B?VGRQMjdDOVlyczlZbkFtQi9UTGNITTVTeStZZ0hUbjdNVlJ2dTUzRHRHMk8v?=
 =?utf-8?B?WUNHNUlkbjQvVDYwejR0dFJta1J4eWdOZ2tMYS8rSTNCWGpEMzNMWks4ZVU3?=
 =?utf-8?B?Ymlwd28zVytNNGhPclhRWmdZb2tLQkYzdVA0bGdvbmxqUHJNL3Ixa1RFSXcw?=
 =?utf-8?B?ajhjSk5LS1BIR2p1ZHZWZDk1bEZQcGRrblFWQ0JMYmF6VjRodmdYYjc1M01p?=
 =?utf-8?B?Q2gyY2VCbnUwdGFPSmlyUjEwMGxKWXJMeU9reStqcWN4aXU3TGpyWEdZd2p3?=
 =?utf-8?B?Z1NrS2Mzclh1NjRod3ZLU2tkQ253QjNoZlozaWM2cHRobTJjbXVqSERDMjVj?=
 =?utf-8?B?WEdIWjFKaXJUSUZiUm9qMDBSMHpnazhDQkhKei93NURDZWtpa0VNcWdYS3h4?=
 =?utf-8?B?dVFqZ3VzMVN6elladGVlTGxBc0VoV0VjVXI5SlRwLzZlZzg0dzBHUm1NcVRj?=
 =?utf-8?B?ZitvM0JHTVpyZCtuajFTc2xNbjRSUER6a1Nic3AweXVVSEVuTzBEQi9kajdJ?=
 =?utf-8?B?NDkzQWUwOC9TR21QN2hWckNJMkdZOUE2ck5FVE5tR09ZVHBwZWVGbFhhamxr?=
 =?utf-8?Q?eD6pGZkMTWLbxP1kslCdRRg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB569CB3E3289743AAC27F5646B5E1EE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ecde48-937f-407a-a877-08dc7ee0ffde
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 06:40:00.9781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MteZls4Q439IBSoR51WHEsaQCi9aaMZD7OiLIXn7+R4EDmtMO2HWchyjpCtV2PXspelGSSERuPGcGaFgGCgSzzfYPsEaGHm7rgmXZHpXeR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA1LTI4IGF0IDA0OjU5ICswMDAwLCBaaGFuZywgUnVpIHdyb3RlOg0KPiBP
biBNb24sIDIwMjQtMDUtMjcgYXQgMTc6NTAgKzAyMDAsIERhbmllbCBMZXpjYW5vIHdyb3RlOg0K
PiA+IE9uIDI3LzA1LzIwMjQgMTY6MTksIFpoYW5nLCBSdWkgd3JvdGU6DQo+ID4gPiBPbiBNb24s
IDIwMjQtMDUtMjcgYXQgMTQ6NTUgKzAyMDAsIERhbmllbCBMZXpjYW5vIHdyb3RlOg0KPiA+ID4g
PiANCj4gPiA+ID4gSGkgU3Jpbml2YXMsDQo+ID4gPiA+IA0KPiA+ID4gPiB0aGUgcG93ZXJjYXAg
QUJJIGV4cG9ydHMgc29tZSBjb25zdHJhaW50IGZpbGVzLiBFdmVuIGlmIEkNCj4gPiA+ID4gc3Vz
cGVjdA0KPiA+ID4gPiB0aGVpcg0KPiA+ID4gPiBzZW1hbnRpYyBpdCBpcyBub3QgcmVhbGx5IGNs
ZWFyIGhvdyB0aGV5IHNob3VsZCBiZWhhdmUuDQo+ID4gPiA+IA0KPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoCDilILCoMKgIOKUnOKUgOKUgGNvbnN0cmFpbnRfMF9uYW1lDQo+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgIOKUgsKgwqAg4pSc4pSA4pSAY29uc3RyYWludF8wX3Bvd2VyX2xpbWl0X3V3DQo+ID4g
PiA+IMKgwqDCoMKgwqDCoMKgIOKUgsKgwqAg4pSc4pSA4pSAY29uc3RyYWludF8wX3RpbWVfd2lu
ZG93X3VzDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIOKUgsKgwqAg4pSc4pSA4pSAY29uc3RyYWlu
dF8xX25hbWUNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAg4pSCwqDCoCDilJzilIDilIBjb25zdHJh
aW50XzFfcG93ZXJfbGltaXRfdXcNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAg4pSCwqDCoCDilJzi
lIDilIBjb25zdHJhaW50XzFfdGltZV93aW5kb3dfdXMNCj4gPiA+ID4gDQo+ID4gPiA+IEFyZSB0
aGUgY29uc3RyYWludHMgY29udHJvbGxlciBzcGVjaWZpYz8gSSBtZWFuLCBlYWNoDQo+ID4gPiA+
IGNvbnRyb2xsZXINCj4gPiA+ID4gZGVmaW5lcw0KPiA+ID4gPiB0aGVpciBjb25zdHJhaW50cz8g
T3IgaXMgaXQgc3VwcG9zZWQgdG8gYmVoYXZlIHRoZSBzYW1lIHdheQ0KPiA+ID4gPiB3aGF0ZXZl
cg0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gY29udHJvbGxlcj8NCj4gPiA+IA0KPiA+ID4gQ3VycmVu
dGx5IHdlIGhhdmUgdGhyZWUgY29udHJvbGxlcnMsIE1TUiBSQVBMLCBNTUlPIFJBUEwgYW5kIFRQ
TUkNCj4gPiA+IFJBUEwuDQo+ID4gPiBUaGV5IGFyZSBhY3R1YWxseSB0aGUgc2FtZSBmZWF0dXJl
IChSQVBMKSB2aWEgZGlmZmVyZW50IHJlZ2lzdGVyDQo+ID4gPiBJbnRlcmZhY2VzLg0KPiA+ID4g
U28gdGhlaXIgYmVoYXZpb3JzIGFyZSBjb25zaXN0ZW50Lg0KPiA+IA0KPiA+IFRoZXkgYXJlIGNv
bnNpc3RlbnQgYmVjYXVzZSB0aGV5IGFyZSBSQVBMIGJhc2VkDQo+IA0KPiByaWdodC4NCj4gDQo+
ID4gwqBidXQgdGhlcmUgYXJlIG1vcmUgDQo+ID4gY29udHJvbGxlcnMsIGxpa2UgRFRQTSBhbmQg
U0NNSS4NCj4gDQo+IHNvIHlvdSB3YW50IHRvIGRlcGxveSBjb25zdHJhaW50cyBzdXBwb3J0IGZv
ciBzb21lIG9mIHRoZXNlDQo+IGNvbnRyb2xsZXJzDQo+IG9yIG1heWJlIGEgbmV3IGNvbnRyb2xs
ZXI/DQo+IA0KPiA+IA0KPiA+IEFyZSB0aGUgY29uc3RyYWludHMgc2VtYW50aWMgZGVmaW5lZCBv
ciBpcyBpdCB1cCB0byB0aGUgYmFja2VuZCB0byANCj4gPiBkZWNpZGUgdGhlIGJlaGF2aW9yID8N
Cj4gPiANCj4gSSd2ZSBuZXZlciB0aG91Z2h0IG9mIHRoaXMgYmVmb3JlLg0KPiBNYXliZSB3ZSBu
ZWVkIHRvIHVuZGVyc3RhbmQgdGhlIG5ldyByZXF1aXJlbWVudCBhbmQgc2VlIGlmIHRoZXkncmUN
Cj4gYWxpZ25lZCB3aXRoIGN1cnJlbnQgY29uc3RyYWludHMgYmVoYXZpb3IuDQo+IA0KTm90IHN1
cmUgdGhpcyBpcyBzcGVjaWZpYyB0byBSQVBMIGJlaGF2aW9yLiBZb3UgaGF2ZSBhIHRpbWUgd2lu
ZG93IGluDQp3aGljaCB5b3Ugd2FudCB0byBsaW1pdCB0byBjZXJ0YWluIHBvd2VyLg0KDQpUaGFu
a3MsDQpTcmluaXZhcw0KDQoNCj4gPiA+ID4gSXMgdGhlIHRpbWUgd2luZG93IGdpdmluZyB0aGUg
ZHVyYXRpb24gb2YgdGhlIHBvd2VyX2xpbWl0X3V3DQo+ID4gPiA+IGNvbnN0cmFpbnQ/DQo+ID4g
PiA+IE9yIGlzIGl0IGFuIGF2ZXJhZ2UgcG93ZXIgZHVyaW5nIHRoaXMgdGltZSB3aW5kb3c/DQo+
ID4gPiANCj4gPiA+IFRoZSBhdmVyYWdlIHBvd2VyIGR1cmluZyB0aGlzIHRpbWUgd2luZG93Lg0K
PiA+ID4gVGhlIGNvbnN0cmFpbnQgaXMgYWx3YXlzIGVmZmVjdGl2ZSBhZnRlciB3ZSBzZXQgaXQu
DQo+ID4gDQo+ID4gVGhhbmtzIGZvciBjb25maXJtaW5nLg0KPiA+IA0KPiA+ID4gPiBXaGF0IGlz
IHRoZSBwdXJwb3NlIG9mIG1pbnxtYXhfdGltZV93aW5kb3dfdXM/DQo+ID4gPiANCj4gPiA+IEl0
IGlzIHRoZSB1cHBlci9sb3dlciBsaW1pdCBmb3IgdXNlcnMgdG8gc2V0IGEgbWVhbmluZ2Z1bCB0
aW1lDQo+ID4gPiB3aW5kb3cuDQo+ID4gDQo+ID4gSSdtIG5vdCBzdXJlIHRvIGdldCBpdC4NCj4g
PiANCj4gPiBGb3IgZXhhbXBsZSwgb24gbXkgbGFwdG9wLCB0aGVyZSBpczoNCj4gPiANCj4gPiBj
b25zdHJhaW50XzBfbWF4X3Bvd2VyX3V3ID0gMTUwMDAwMDANCj4gPiBjb25zdHJhaW50XzBfcG93
ZXJfbGltaXRfdXcgPSAyMDAwMDAwMDANCj4gPiBjb25zdHJhaW50XzBfdGltZV93aW5kb3dzX3Vz
ID0gMzE5ODE1NjkNCj4gPiBjb25zdHJhaW50XzBfbmFtZSA9IGxvbmdfdGVybQ0KPiA+IA0KPiA+
IFRoZXJlIGlzIG5vIGNvbnN0cmFpbnRfMF9tYXhfdGltZV93aW5kb3dfdXMNCj4gDQo+IGJlY2F1
c2UgdGhlIGJhY2tlbmQgZHJpdmVyIChSQVBMKSBkb2Vzbid0IGltcGxlbWVudCB0aGUgY2FsbGJh
Y2tzLg0KPiANCj4gQnV0IEkgdGhpbmsgdGhlc2Ugc3lzZnMgaW50ZXJmYWNlcyBhcmUgZGVzaWdu
ZWQgZm9yIHRoaXMgcHVycG9zZS4NCj4gDQo+ID4gDQo+ID4gSG93IHRvIGludGVycHJldCB0aGlz
IGNvbnN0cmFpbnQgMCA/DQo+ID4gDQo+ID4gV2hhdCBtZWFucyAibG9uZ190ZXJtIiA/DQo+IA0K
PiB0aGUgbWVhbmluZyBvZiBlYWNoIGNvbnN0cmFpbnQgaXMgcGVyIGNvbnRyb2xsZXIuDQo+IA0K
PiBPbiBJbnRlbCBoYXJkd2FyZSwgcmFwbCBkcml2ZXIgY29uc3RyYWludCAwIGlzIG1hcHBlZCB0
byBSQVBMIFBvd2VyDQo+IExpbXRpIDEuDQo+IA0KPiAiTVNSX1BLR19QT1dFUl9MSU1JVCBhbGxv
d3MgYSBzb2Z0d2FyZSBhZ2VudCB0byBkZWZpbmUgcG93ZXINCj4gbGltaXRhdGlvbg0KPiBmb3Ig
dGhlIHBhY2thZ2UgZG9tYWluLiBQb3dlciBsaW1pdGF0aW9uIGlzIGRlZmluZWQgaW4gdGVybXMg
b2YNCj4gYXZlcmFnZQ0KPiBwb3dlciB1c2FnZSAoV2F0dHMpIG92ZXIgYSB0aW1lIHdpbmRvdyBz
cGVjaWZpZWQgaW4NCj4gTlNSX1BLR19QT1dFUl9MSU1JVC4NCj4gVHdvIHBvd2VyIGxpbWl0cyBj
YW4gYmUgc3BlY2lmaWVkLCBjb3JyZXNwb25kaW5nIHRvIHRpbWUgd2luZG93cyBvZg0KPiBkaWZm
ZXJlbnQgc2l6ZXMuIEVhY2ggcG93ZXIgbGltaXQgcHJvdmlkZXMgaW5kZS0NCj4gcGVuZGVudCBj
bGFtcGluZyBjb250cm9sIHRoYXQgd291bGQgcGVybWl0IHRoZSBwcm9jZXNzb3IgY29yZXMgdG8g
Z28NCj4gYmVsb3cgT1MtcmVxdWVzdGVkIHN0YXRlIHRvIG1lZXQgdGhlIHBvd2VyDQo+IGxpbWl0
cy4iDQo+IA0KPiA+IA0KPiA+IElzIGl0IHBvc3NpYmxlIHRvIGdpdmUgYW4gZXhhbXBsZSA/DQo+
ID4gDQo+IA0KPiBUaGUgUEwxIGlzIHVzdWFsbHkgdGhlIFREUCBsaW1pdGF0aW9uLiBXaGVuIHdl
IHNldCBjb25zdHJhaW50IDAsIHRoZQ0KPiBwYWNrYWdlIHdpbGwgbm90IHJ1biBhYm92ZSB0aGUg
c3BlY2lmaWVkIHBvd2VyLg0KPiANCj4gPiA+ID4gQ2FuIHdlIHNldCBzZXZlcmFsIGNvbnN0cmFp
bnRzIG9yIGFyZSB0aGV5IG11dHVhbGx5IGV4Y2x1c2l2ZT8NCj4gPiA+IA0KPiA+ID4gTXkgdW5k
ZXJzdGFuZGluZyBpcyB0aGF0IHRoZXkgY2FuIGJvdGggdGFrZSBlZmZlY3QuDQo+ID4gPiAiVHdv
IHBvd2VyIGxpbWl0cyBjYW4gYmUgc3BlY2lmaWVkLCBjb3JyZXNwb25kaW5nIHRvIHRpbWUgd2lu
ZG93cw0KPiA+ID4gb2YNCj4gPiA+IGRpZmZlcmVudCBzaXplcy4gRWFjaCBwb3dlciBsaW1pdCBw
cm92aWRlcyBpbmRlLQ0KPiA+ID4gcGVuZGVudCBjbGFtcGluZyBjb250cm9sIHRoYXQgd291bGQg
cGVybWl0IHRoZSBwcm9jZXNzb3IgY29yZXMgdG8NCj4gPiA+IGdvDQo+ID4gPiBiZWxvdyBPUy1y
ZXF1ZXN0ZWQgc3RhdGUgdG8gbWVldCB0aGUgcG93ZXINCj4gPiA+IGxpbWl0cy4iDQo+ID4gPiAN
Cj4gPiA+ID4gDQo+ID4gPiA+IElzIHRoZXJlIGFueSBkb2N1bWVudGF0aW9uIGRlc2NyaWJpbmcg
d2l0aCBtb3JlIGRldGFpbHMgdGhlDQo+ID4gPiA+IEFCSXM/DQo+ID4gPiA+IA0KPiA+ID4gSW50
ZXJlc3RpbmcsIEkganVzdCBmb3VuZCB0aGlzIG9uZSwNCj4gPiA+IERvY3VtZW50YXRpb24vQUJJ
L3Rlc3Rpbmcvc3lzZnMtY2xhc3MtcG93ZXJjYXAsIHNob3VsZCB3ZSBtb3ZlIGl0DQo+ID4gPiB0
bw0KPiA+ID4gc3RhYmxlPyBPdGhlciB0aGFuIHRoYXQsIEkgZG9uJ3Qga25vdy4NCj4gPiANCj4g
PiBZZXMsIEkndmUgc2VlbiB0aGlzIGRvY3VtZW50YXRpb24gYnV0IGl0IGRvZXMgbm90IHJlYWxs
eSBoZWxwLiBJdCANCj4gPiBkZXNjcmliZXMgdGhlIEFCSSBidXQgZmFpbHMgdG8gZ2l2ZSBzb21l
IGRldGFpbHMuIE1heSBJIHJlZmVyIHRvDQo+ID4gdGhlIA0KPiA+IFJBUEwgZG9jdW1lbnRhdGlv
biB0byB1bmRlcnN0YW5kIHRoZSBwb3dlcmNhcCBmcmFtZXdvcmsgPw0KPiA+IA0KPiBUbyBiZXR0
ZXIgdW5kZXJzdGFuZCBob3cgUkFQTCB3b3JrcywgeW91IGNhbiBkb3dubG9hZCBJbnRlbCBTRE0g
YW5kDQo+IGNoZWNrIHRoaXMgc2VjdGlvbiwgIjE1LjEwIFBMQVRGT1JNIFNQRUNJRklDIFBPV0VS
IE1BTkFHRU1FTlQNCj4gU1VQUE9SVCIuDQo+IA0KPiBUaGFua3MsDQo+IHJ1aQ0KDQo=

