Return-Path: <linux-pm+bounces-15268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A59992FB2
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 16:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690351C230CB
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269021D7986;
	Mon,  7 Oct 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0LRocTt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C51D1D61A7
	for <linux-pm@vger.kernel.org>; Mon,  7 Oct 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312254; cv=fail; b=tVm7gZ8hLN6v2RoXrXm3gYfFCNQdEjCvsYK4Y6ksLq6znRQIGi+XoW/LWLaJo9GZT9LWka3tS3EDqsEcRkrJH3CQx2a3Wojfo6mG9hYfKJB05iLKhk1FLyPdHTG8K9BI6nes4tsGsddVTgKjBqYz28FixnegQuECGqZp1hBLeJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312254; c=relaxed/simple;
	bh=Gp7arJxw92kr9uDQ5Bp2d/bL8kE0JuSnaziTXGntOHs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=V5jDMM/+FyQJmX1yUWA96SKwa1wQ+/oUR2ug5naatoobnbfsb0B4JBAC0KBF+Mhup8RPK506DWJQvR4rl9wR2TItikBwWYm4rBkyGHQamvj9K9Yq1tE5A5l1mG+LJdr8a+bFNDmbM0Edfl+fM0ACSSomz+GSmxLl0bGaHglaE1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0LRocTt; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728312251; x=1759848251;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Gp7arJxw92kr9uDQ5Bp2d/bL8kE0JuSnaziTXGntOHs=;
  b=g0LRocTtztvLjPjNkb7AM0xNJA4IbxouQHDDYhj4XtrcUXZ2ENk9kBIf
   cAmziOCjL/9ewKrJDpiFGE2ypm3B7D4KLuAKth0CMFIr288LQL+2oBYRD
   RJbNea1MsWqlebFtQWmdbhZRqKDzI192YDqbZ96rwOM7gCWdiJDSYLIVX
   5el2dcRqdx9bTJUnBQJk85u80lpkLZsKIyjx7dd+Lq4cTZO1Darx19Zk6
   9el/xUGDtVzLkwcbxhqzlZBxPf00F2KAPQkKop0a3JSy3E+rrE3FUewkn
   IwuJhTWA7c2eLLnojNDeBzhLX6BIcLMw8TJcqu/lyUGaSq4DRCLezSVdE
   Q==;
X-CSE-ConnectionGUID: FvLs6peRTNe0le859qY/qQ==
X-CSE-MsgGUID: vqs2NaW7TZ24P/4DdTsF/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="44936255"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="44936255"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 07:44:11 -0700
X-CSE-ConnectionGUID: baqazROxRT62b4bhwfN6mQ==
X-CSE-MsgGUID: k1MHj8tJQ+u8WvZA0L82sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="112956911"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 07:44:11 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 07:44:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 07:44:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 07:44:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 07:44:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 07:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piFT1wM5kLhQfzGXGEyp1CL9tpvEeCQfHYZ72hphk85IVzM6wSV4RmvcywpHdtX4VwwCcgy/Ti+7nAnFsbysxRuhl07cPXNjtLEiHYR2AbAdcIUrUE9QfZH4Uvtf+DKiN8w9iA00fSdRDA1aQZhAitvOEXkE+aRuZjLDzdwCXlerWfNHgrEAbfquHpie1WatnhTvkl7pERWMQLji0NyNcc9kff+CxW2kqdLba+qoXceSbQMkqTvvSOYJGCAZIMxRKI/IRkoR3j4sME0UpqMrKH7Shnj+9oQqtv0fJGXEdy5lG0IE2csif3GlgbV8VGB0Er0SvR+m4aYpwqwgbKOfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L65qcyfRr9d+HWud/9opoDdEI5E9LYTqz0xLeWa8RmA=;
 b=Yyn3JXfBriGj2GjPlKHxVgOuB88WWfjqhcMTUvz09gKDlSbjt967f372MVVnB0zxe2/H8mVfZSWt6m0UCxLfWyDj+bR0/WjJBT+bcRCw2IpksFScl6vICzG+75tphg4wIjg0vWu5504lFMiOSymQ/FOmEN4fCXu0q0XmKPOg7SAd0j7PpoMTIm4bLv1m2a3aQs9VrxD9qqYoz6H4p4j4rw+VYdY2RCA9Hlqk78JBUyzbCUgZjur9b6T9YplMt/3o/3M3IDlqMlgMbQafGwBxdaKH74JyXT+N7E9Qgv5RmPvEySqYt7AJG1VfJBBtvV1e4qH7fVgYJ8hEtfjagAFUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8483.namprd11.prod.outlook.com (2603:10b6:408:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 14:44:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 14:44:04 +0000
Date: Mon, 7 Oct 2024 22:43:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Loehle <christian.loehle@arm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	<linux-pm@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [cpuidle]  38f83090f5:  fsmark.app_overhead
 51.9% regression
Message-ID: <202410072214.11d18a3c-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 6252fafa-7fb0-4027-4fbd-08dce6de7d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?VZGfiLEU8oAD6tDECtHiNkezZmgNQTw+OkkYpt+2OZjYHpqWtTCsEswCSm?=
 =?iso-8859-1?Q?QZlUdy0ebsTBJ9VY3gLVYO7ccb/IxqSa4NVML+X3c7G/37CwtJ+OHZdvHV?=
 =?iso-8859-1?Q?kpHpVNc6flMyJ+YMPfdfSf/5p+fJSgoOhcvAYP4wEScMsuY3U2PzBYmBqm?=
 =?iso-8859-1?Q?wRWdKyclXZqFe1HhXYnbhnbrFNMY8bCjuu8VDhGazj6EtXocnRtkS5GQdE?=
 =?iso-8859-1?Q?sEIt/ZmSSsJOxU11A8YvtZgAh++qn34eM0m4rrNsWkQlFDzx7NgxXiDGfc?=
 =?iso-8859-1?Q?spmvbjHIIqdO9UMDEtiqejAQRbubG7gF6Yw7DT82nSF0+/fBLDR62UgT8f?=
 =?iso-8859-1?Q?Y2vE15p2OkKm/52KFe8gDDYJeLb0wbgBFdvijtWxAi9OxEF1viafLblnPs?=
 =?iso-8859-1?Q?jkvMQup7JSy88mga6CUZWByTj/4juZVGGI+jEEggQapNOq143nfeATHCs2?=
 =?iso-8859-1?Q?wUsY8TMgrA8S7eF/kf8hsiFmRA3Gke9jB88AVPgZb1BjyjCU+RciKJ6cth?=
 =?iso-8859-1?Q?Wj0+ApQBvNhZ1yC+ZIah/QEwmmAg8u1ykKSL6RtlNLkadPBY8WkYglRHiW?=
 =?iso-8859-1?Q?QxoqO0vpNmrDZDydWSxuG3fpYGkKxBJRm1iZ3mM84TkDNbFQx/TNXY9YlY?=
 =?iso-8859-1?Q?s3mVrW6stefsJ9jdZyC61q4cbmH5toQZ9aYavpMNvWYt3xu2x2KHD4mN3g?=
 =?iso-8859-1?Q?4MfWLxNI10MhH9aSvtJ8JXM8ZjIYdG59+/zssSEyJZ9O6zOGY8YfH1m/jo?=
 =?iso-8859-1?Q?ln+s7ZN0Zh252s339sWm2Buc57jQ/Fv09NBiMEVNLbO3Hn0mQePL4QAtwO?=
 =?iso-8859-1?Q?7mPmh8TAgXZUL235nQxzLURR54wpWyvn1Z1ytXUGuk4tbHrsH9yyJlwIiF?=
 =?iso-8859-1?Q?Zima7jMfTo+25api2HHP32gel340W9y1R/XGKe8cfEfilcTwIvyORzxQcO?=
 =?iso-8859-1?Q?7o6h4aNVsIm/UZ80SMbTZ1nKnD0wA7YsudbIq9GgmkRWA+PuAEml3xx0rm?=
 =?iso-8859-1?Q?4XA/od8ZOIUa9CZH5yXXYz+X4klTU6btgbfGLm2scrNUKn2ofL3cYFKQ08?=
 =?iso-8859-1?Q?wUVelgayE9GNmUabrlYCEamWMWgbREpFYbuSbKQYPUKs5l/2i3wd7r6F8E?=
 =?iso-8859-1?Q?KuQ0fUYYYURJe4ocvnR+UpQklbQx2Nc8mWz1UKxprn62SKgn4QjZNLejCK?=
 =?iso-8859-1?Q?WdhheY9KnRUwOd8L9iNK8XUYeE5RYzm2rOVs8DC+v3r7GmpI/vGQta/0Y2?=
 =?iso-8859-1?Q?flsVphJe+QU17vLKCjI6cAuoe2dJxenprxiIBVjtbiN1f2O1iSotRCLh8M?=
 =?iso-8859-1?Q?OydiotROodsQfDjEfbUC+kYsZPKhRrRsgQQUwQEMwzEqZb4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gQVzRi2nvy5tnBEvEJXkHpME6c+j5rf8Ui6rUA9hM6U/g3UmCsE2m87sV4?=
 =?iso-8859-1?Q?Tv4/viGFr6WLOU01IJCXC4y0Gf2l82YKQxRL2fCFQHBMOwvdVRbRQG98wx?=
 =?iso-8859-1?Q?3gqDk/HIC4b8M57xY9xuX9eIS9HIBOEyrkk6mZo+O/0hGUioU/FMweaI6C?=
 =?iso-8859-1?Q?2NgI5Plw0VhjvP0bMEpMYENai6yaFclHwWcAFFzXZF26g49wJUqid4Jj2z?=
 =?iso-8859-1?Q?aBlC1O8pwEZJvHLxeXNrFI0/4sQu0+937g4r0lzf0qm07Wo+gg9ZX9i2vk?=
 =?iso-8859-1?Q?SWPCohAIRDcLWZfwNhdjf7Q7FlO4kC3+qi5F+MzudRJSeX4OgC66+8iJTH?=
 =?iso-8859-1?Q?yeSxnvUHC7ojLa52rDXCRd1GApOHuGBEQ0GnWoVRQpOk2JduAYmiUDfU8P?=
 =?iso-8859-1?Q?Ad6cSfUHZmvxf+RxWO/Hau91JdfUDNpHheIiOkQ6U0KzSXbvfVEyFZimAY?=
 =?iso-8859-1?Q?5UTIHSz6xkSRR6Oq8B9GVvrtvw/kpSmMQxguaF022ZsZzVEHCUerTCKR/O?=
 =?iso-8859-1?Q?bAJ8lu5w+OEAJO+gJVxPoDI3HP8YAr8fWm/fy4xRSRhX+aNFVZ419lvEbz?=
 =?iso-8859-1?Q?ZAKrzxfGPax0sRIhRWLrf8hsaE03WDk4+gyBQbwrQHxmQSFm+T3T3/4+3C?=
 =?iso-8859-1?Q?cnHF2gQSHmGkxkZBXkvmEqeicS5CXb82z5VeezU4NIZX+jqjWDVplHuFsr?=
 =?iso-8859-1?Q?WvTuleItAqQXZFeUyte6ch1HTgrL9ccXyO0QEWqXfTscMsAJ+mtsLRR0Xe?=
 =?iso-8859-1?Q?/f7OuLlt/qy4fICG2kRzLL3Log73RU9gaytZKMcz6ThwdYcnrVlyGSHAYp?=
 =?iso-8859-1?Q?W1ZvVO4LqR6EfCF2bXheB0pNyb6KDu6GqjDIjrYz0Csnc6A8u+514F2dmC?=
 =?iso-8859-1?Q?U75uz8qZ7o1qDfqg6vce2M7hOcnyaqoheN1Hr0cocO1CelMHUcDxqASL8R?=
 =?iso-8859-1?Q?mo7SDFpRBAXYmVpX1fccgqazvE3z8h3YvpH3KitXcLIbMXiKIdgoW/tkng?=
 =?iso-8859-1?Q?s7pkNee4GaKmMbKUMthDetOH+eCw26T75E957rqUgl4sYTiRnTxXYWW+PZ?=
 =?iso-8859-1?Q?poJ9XeAdUdYqwvmCcDjwMYx+uZSqnJkSP5Hnnk40G3hza7/miXIlJq6dYS?=
 =?iso-8859-1?Q?tf65ttNVZkvZXPguDUoMGW6DNX81sfv/HM9w4uQsYq5J5vZrRqU5a0rRvl?=
 =?iso-8859-1?Q?9mqYi/8HHWtn2mgursEsAoEp+hAx4dwkZ5exQd4s0LXKjkL1T2pIAJpQgi?=
 =?iso-8859-1?Q?1kSzQcVmGQVyjlxSNNNfnOpqnFlwIsii87zZZCQbKUBcm/fvtgFkbwcP3m?=
 =?iso-8859-1?Q?r+0dQuOF30YVE10SMUnjrd2HNQYeRhm4bFrhQkwa9XcecX+fj34646Tokr?=
 =?iso-8859-1?Q?iiHuRTZMn+08bYgnmTx6HE61ektUHR1ef/t1f7+YK/QMgiOSjkLbzRSUci?=
 =?iso-8859-1?Q?QNZIk7YnIAmmO+1sXxLSBDKZwUiwiM4p8PlO/g5pLVUPTD17AbcJfp+x8w?=
 =?iso-8859-1?Q?cqNZ73fkE423xFh1Z3nX6FKGv+mWmK8vUqy/j+PXGq1vIOxjZj0z2kgbVM?=
 =?iso-8859-1?Q?l17c+vwBqsQCuQ4tcAIdsNkRBwEP1Xy+YrCazIMxZhhQoNc7VbC6m7+Z4q?=
 =?iso-8859-1?Q?yzKFhgE6IfruQ7ZjhDvVPzu7/Izl0Dek8UshtFtzmRHEn5XR0m7Rietw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6252fafa-7fb0-4027-4fbd-08dce6de7d5a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 14:44:04.3036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQ2Iqz3ZPXIHQBAlCaU9+TrWzuvMJGx/vya4FhmTV22aIlHeD88xJxpjij0bJTH/u92OUZFibccxkdwgTbaJFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8483
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 51.9% regression of fsmark.app_overhead on:

(
but there is no performance difference for fsmark.files_per_sec
     18.58            -0.2%      18.55        fsmark.files_per_sec
)


commit: 38f83090f515b4b5d59382dfada1e7457f19aa47 ("cpuidle: menu: Remove iowait influence")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: fsmark
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	iterations: 1x
	nr_threads: 1t
	disk: 1HDD
	fs: btrfs
	fs2: nfsv4
	filesize: 4K
	test_size: 40M
	sync_method: fsyncBeforeClose
	nr_files_per_directory: 1fpd
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410072214.11d18a3c-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241007/202410072214.11d18a3c-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1HDD/4K/nfsv4/btrfs/1x/x86_64-rhel-8.3/1fpd/1t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-icl-2sp6/40M/fsmark

commit: 
  v6.12-rc1
  38f83090f5 ("cpuidle: menu: Remove iowait influence")

       v6.12-rc1 38f83090f515b4b5d59382dfada 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   2032015 ±  3%     +51.9%    3087623        fsmark.app_overhead
     18.58            -0.2%      18.55        fsmark.files_per_sec
      2944            -2.9%       2858        vmstat.system.cs
      0.02            +0.0        0.02        mpstat.cpu.all.irq%
      0.01 ±  2%      +0.0        0.01        mpstat.cpu.all.soft%
      0.04 ±  2%      +0.0        0.05 ±  3%  mpstat.cpu.all.sys%
      4.07 ± 18%     -53.4%       1.90 ± 53%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    267.72 ± 38%     -62.7%      99.92 ± 75%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     30.08 ± 29%     -58.5%      12.50 ± 63%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      4.07 ± 18%     -53.5%       1.89 ± 53%  sched_debug.cfs_rq:/.removed.util_avg.avg
    267.67 ± 38%     -62.7%      99.92 ± 75%  sched_debug.cfs_rq:/.removed.util_avg.max
     30.08 ± 29%     -58.5%      12.49 ± 63%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     20.43 ± 17%     -25.5%      15.21 ± 16%  sched_debug.cfs_rq:/.util_est.stddev
      7.85 ± 14%     +21.6%       9.55 ± 12%  sched_debug.cpu.clock.stddev
      0.00 ± 25%     -47.7%       0.00 ± 44%  sched_debug.cpu.next_balance.stddev
      0.02 ± 10%     -18.9%       0.02 ± 11%  sched_debug.cpu.nr_running.avg
      0.14 ±  5%     -14.5%       0.12 ±  4%  sched_debug.cpu.nr_running.stddev
      5.19            +0.6        5.79        perf-stat.i.branch-miss-rate%
   4096977 ±  4%      +8.4%    4442600 ±  2%  perf-stat.i.branch-misses
      1.79 ±  7%      -0.2        1.59 ±  3%  perf-stat.i.cache-miss-rate%
  11620307           +22.2%   14202690        perf-stat.i.cache-references
      2925            -3.2%       2830        perf-stat.i.context-switches
      1.68           +38.6%       2.32        perf-stat.i.cpi
 4.457e+08 ±  3%     +23.8%  5.518e+08 ±  2%  perf-stat.i.cpu-cycles
      1630 ±  8%     +28.6%       2096 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.63           -25.5%       0.47        perf-stat.i.ipc
      5.26            +0.2        5.48        perf-stat.overall.branch-miss-rate%
      1.16           +18.4%       1.38        perf-stat.overall.cpi
      0.86           -15.6%       0.73        perf-stat.overall.ipc
   4103944 ±  4%      +7.9%    4429579        perf-stat.ps.branch-misses
  11617199           +22.1%   14186503        perf-stat.ps.cache-references
      2919            -3.2%       2825        perf-stat.ps.context-switches
 4.492e+08 ±  3%     +23.2%  5.534e+08 ±  2%  perf-stat.ps.cpu-cycles
      0.12 ±  4%     -23.1%       0.09 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.__synchronize_srcu.fsnotify_connector_destroy_workfn.process_one_work
      0.00 ±  8%     +52.0%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.btrfs_start_ordered_extent.btrfs_wait_ordered_range.btrfs_sync_file.btrfs_do_write_iter
      0.01 ± 13%    +178.9%       0.03 ± 11%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.01 ± 13%     +47.2%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00 ± 14%    +257.1%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
      0.06 ±  2%     +11.8%       0.06 ±  3%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.12 ±  7%     -14.5%       0.10 ±  4%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_connector_destroy_workfn
      0.09 ±  8%     +13.9%       0.10 ±  9%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.03 ±  2%     +27.5%       0.03 ± 14%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.14 ±  6%     +20.5%       0.17 ± 11%  perf-sched.sch_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.__rpc_execute
      0.01 ±  2%    +867.1%       0.14 ± 21%  perf-sched.sch_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
      0.27 ± 17%    +652.4%       2.03 ±183%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.11 ±  7%     +67.0%       0.19 ± 12%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     33.20 ±  3%     +29.7%      43.08 ±  4%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.84 ±  4%     -16.6%       0.70 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_mark_destroy_workfn
      2121 ±  3%     -23.3%       1626 ±  5%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.98 ±143%   +5665.5%     171.90 ±215%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.56 ± 14%     +38.0%       0.77 ±  7%  perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.35 ±  9%     +50.9%       0.53 ±  8%  perf-sched.wait_and_delay.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
      3768 ± 16%     +17.0%       4411 ±  5%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.16 ±  4%     +20.4%       0.20 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.__synchronize_srcu.fsnotify_connector_destroy_workfn.process_one_work
      0.89 ± 14%     -35.2%       0.58 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.__synchronize_srcu.fsnotify_mark_destroy_workfn.process_one_work
      0.24 ± 20%    +728.0%       1.99 ±186%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.10 ±  9%     +57.0%       0.16 ± 12%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     33.20 ±  3%     +29.7%      43.07 ±  4%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.79 ±  5%     -19.7%       0.63 ± 12%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_mark_destroy_workfn
      0.27 ±  8%     +13.3%       0.30 ±  5%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.__synchronize_srcu.fsnotify_connector_destroy_workfn.process_one_work
      0.50 ± 17%     +33.3%       0.67 ±  8%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.34 ±  9%     +23.1%       0.42 ±  8%  perf-sched.wait_time.max.ms.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_bit.nfs4_run_open_task
      5.60 ±  7%      -1.3        4.32 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.57 ±  7%      -1.3        4.30 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.33 ±  7%      -0.5        0.86 ± 15%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1.32 ±  7%      -0.5        0.86 ± 15%  perf-profile.calltrace.cycles-pp.mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      1.30 ±  8%      -0.5        0.85 ± 15%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.exit_mm.do_exit.do_group_exit
      1.88 ± 12%      -0.4        1.48 ±  8%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.78 ± 13%      +0.2        0.95 ± 12%  perf-profile.calltrace.cycles-pp.call_transmit.__rpc_execute.rpc_async_schedule.process_one_work.worker_thread
      0.83 ± 15%      +0.2        1.06 ± 11%  perf-profile.calltrace.cycles-pp.__vfork
      1.11 ± 15%      +0.2        1.34 ± 10%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle
      0.39 ± 71%      +0.3        0.72 ±  9%  perf-profile.calltrace.cycles-pp.start_ordered_ops.btrfs_sync_file.btrfs_do_write_iter.do_iter_readv_writev.vfs_iter_write
      0.54 ± 46%      +0.4        0.91 ± 16%  perf-profile.calltrace.cycles-pp.evsel__read_counter.read_counters.process_interval.dispatch_events.cmd_stat
      0.92 ± 20%      +0.4        1.32 ± 11%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.18 ±141%      +0.4        0.61 ± 10%  perf-profile.calltrace.cycles-pp.readn.evsel__read_counter.read_counters.process_interval.dispatch_events
      0.84 ± 20%      +0.4        1.28 ± 10%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.09 ±223%      +0.5        0.60 ± 10%  perf-profile.calltrace.cycles-pp.read.readn.evsel__read_counter.read_counters.process_interval
      0.00            +0.6        0.58 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.readn.evsel__read_counter
      0.00            +0.6        0.58 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read.readn.evsel__read_counter.read_counters
      3.34 ±  8%      +0.8        4.16 ±  9%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
     17.29 ±  2%      +0.9       18.18 ±  3%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     17.29 ±  2%      +0.9       18.18 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     17.29 ±  2%      +0.9       18.18 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      4.19 ±  5%      +1.3        5.51 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      5.20 ±  8%      +1.5        6.67 ±  3%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      6.40 ±  9%      +1.6        7.96 ±  4%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      6.53 ± 10%      +1.7        8.21 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
     11.90 ±  7%      +2.4       14.29 ±  3%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     14.08 ±  7%      +2.6       16.65 ±  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.04 ± 29%      -0.9        0.12 ± 77%  perf-profile.children.cycles-pp.poll_idle
      1.87 ±  9%      -0.5        1.35 ±  7%  perf-profile.children.cycles-pp.mmput
      1.84 ± 11%      -0.5        1.34 ±  7%  perf-profile.children.cycles-pp.exit_mmap
      2.08 ± 11%      -0.5        1.62 ±  8%  perf-profile.children.cycles-pp.x64_sys_call
      1.94 ± 12%      -0.5        1.48 ±  7%  perf-profile.children.cycles-pp.do_exit
      1.76 ± 12%      -0.5        1.30 ± 11%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      1.75 ± 12%      -0.5        1.30 ± 11%  perf-profile.children.cycles-pp.do_group_exit
      1.42 ±  7%      -0.4        1.00 ± 11%  perf-profile.children.cycles-pp.exit_mm
      0.94 ± 12%      -0.4        0.59 ± 11%  perf-profile.children.cycles-pp.unmap_vmas
      1.03 ± 14%      -0.3        0.72 ±  7%  perf-profile.children.cycles-pp.btree_write_cache_pages
      0.85 ±  9%      -0.3        0.54 ± 11%  perf-profile.children.cycles-pp.unmap_page_range
      0.96 ± 17%      -0.3        0.67 ±  7%  perf-profile.children.cycles-pp.submit_eb_page
      0.82 ±  8%      -0.3        0.53 ± 10%  perf-profile.children.cycles-pp.zap_pmd_range
      0.78 ±  9%      -0.3        0.50 ± 11%  perf-profile.children.cycles-pp.zap_pte_range
      0.65 ± 15%      -0.3        0.39 ± 14%  perf-profile.children.cycles-pp.zap_present_ptes
      0.70 ± 19%      -0.2        0.46 ± 22%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.61 ± 23%      -0.2        0.37 ± 21%  perf-profile.children.cycles-pp.sched_clock
      0.65 ±  8%      -0.2        0.45 ± 27%  perf-profile.children.cycles-pp.dl_server_stop
      0.55 ±  6%      -0.2        0.38 ±  5%  perf-profile.children.cycles-pp.btrfs_commit_transaction
      0.45 ±  6%      -0.2        0.29 ± 28%  perf-profile.children.cycles-pp.alloc_empty_file
      0.65 ± 15%      -0.2        0.49 ± 16%  perf-profile.children.cycles-pp.read_tsc
      0.23 ± 36%      -0.1        0.09 ± 27%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.37 ±  5%      -0.1        0.25        perf-profile.children.cycles-pp.__btrfs_run_delayed_refs
      0.37 ±  5%      -0.1        0.25        perf-profile.children.cycles-pp.btrfs_run_delayed_refs
      0.19 ± 53%      -0.1        0.07 ± 89%  perf-profile.children.cycles-pp.mas_next_slot
      0.36 ±  6%      -0.1        0.25 ±  5%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs_for_head
      0.35 ±  4%      -0.1        0.24 ±  9%  perf-profile.children.cycles-pp.run_delayed_data_ref
      0.34 ±  9%      -0.1        0.25 ± 19%  perf-profile.children.cycles-pp.try_address
      0.14 ± 27%      -0.1        0.06 ± 81%  perf-profile.children.cycles-pp.number
      0.15 ± 35%      -0.1        0.07 ± 58%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.14 ± 32%      -0.1        0.05 ±109%  perf-profile.children.cycles-pp.wake_up_q
      0.29 ±  5%      -0.1        0.22 ± 25%  perf-profile.children.cycles-pp.i2c_outb
      0.35 ±  6%      -0.1        0.27 ± 19%  perf-profile.children.cycles-pp.__i2c_transfer
      0.35 ±  6%      -0.1        0.27 ± 19%  perf-profile.children.cycles-pp.ast_vga_connector_helper_detect_ctx
      0.35 ±  6%      -0.1        0.27 ± 19%  perf-profile.children.cycles-pp.bit_xfer
      0.35 ±  6%      -0.1        0.27 ± 19%  perf-profile.children.cycles-pp.drm_connector_helper_detect_from_ddc
      0.35 ±  6%      -0.1        0.27 ± 19%  perf-profile.children.cycles-pp.drm_do_probe_ddc_edid
      0.35 ±  6%      -0.1        0.27 ± 19%  perf-profile.children.cycles-pp.drm_helper_probe_detect_ctx
      0.35 ±  6%      -0.1        0.27 ± 19%  perf-profile.children.cycles-pp.drm_probe_ddc
      0.35 ±  6%      -0.1        0.27 ± 19%  perf-profile.children.cycles-pp.i2c_transfer
      0.35 ±  6%      -0.1        0.27 ± 19%  perf-profile.children.cycles-pp.output_poll_execute
      0.16 ± 21%      -0.1        0.09 ± 30%  perf-profile.children.cycles-pp.btrfs_write_and_wait_transaction
      0.03 ± 70%      +0.0        0.08 ± 31%  perf-profile.children.cycles-pp.sd_setup_read_write_cmnd
      0.06 ± 57%      +0.1        0.11 ± 30%  perf-profile.children.cycles-pp._copy_from_user
      0.06 ± 89%      +0.1        0.13 ± 30%  perf-profile.children.cycles-pp.blk_mq_requeue_work
      0.03 ±111%      +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.rcu_accelerate_cbs
      0.25 ± 29%      +0.1        0.37 ± 14%  perf-profile.children.cycles-pp.extent_writepage_io
      0.11 ± 31%      +0.1        0.24 ± 20%  perf-profile.children.cycles-pp.rw_verify_area
      0.17 ± 63%      +0.1        0.30 ± 27%  perf-profile.children.cycles-pp.perf_event_read
      0.07 ± 62%      +0.1        0.21 ± 30%  perf-profile.children.cycles-pp.svc_pool_wake_idle_thread
      0.14 ± 58%      +0.2        0.29 ± 26%  perf-profile.children.cycles-pp.svc_tcp_read_marker
      0.15 ± 55%      +0.2        0.31 ± 34%  perf-profile.children.cycles-pp.__write_extent_buffer
      0.15 ± 64%      +0.2        0.31 ± 28%  perf-profile.children.cycles-pp.smp_call_function_single
      0.35 ± 18%      +0.2        0.52 ± 16%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.11 ± 75%      +0.2        0.30 ± 20%  perf-profile.children.cycles-pp.copy_extent_buffer_full
      0.54 ± 15%      +0.2        0.72 ±  9%  perf-profile.children.cycles-pp.start_ordered_ops
      0.15 ± 22%      +0.2        0.34 ± 41%  perf-profile.children.cycles-pp.nfsd_set_fh_dentry
      0.28 ± 27%      +0.2        0.48 ± 30%  perf-profile.children.cycles-pp.__fh_verify
      0.28 ± 27%      +0.2        0.48 ± 29%  perf-profile.children.cycles-pp.fh_verify
      0.41 ± 24%      +0.2        0.62 ± 10%  perf-profile.children.cycles-pp.perf_read
      0.45 ± 20%      +0.2        0.66 ±  6%  perf-profile.children.cycles-pp.__memcpy
      0.18 ± 48%      +0.2        0.40 ± 15%  perf-profile.children.cycles-pp.generic_exec_single
      0.83 ± 15%      +0.2        1.06 ± 11%  perf-profile.children.cycles-pp.__vfork
      0.28 ± 30%      +0.2        0.53 ± 52%  perf-profile.children.cycles-pp._nfs4_proc_access
      0.33 ± 22%      +0.3        0.58 ± 19%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.28 ± 30%      +0.3        0.54 ± 51%  perf-profile.children.cycles-pp.nfs4_proc_access
      0.63 ± 14%      +0.3        0.92 ± 16%  perf-profile.children.cycles-pp.evsel__read_counter
      0.46 ± 26%      +0.3        0.76 ± 20%  perf-profile.children.cycles-pp.finish_task_switch
      0.81 ± 16%      +0.3        1.14 ±  9%  perf-profile.children.cycles-pp.readn
      1.10 ± 15%      +0.4        1.48 ± 20%  perf-profile.children.cycles-pp.xs_tcp_send_request
      1.15 ± 12%      +0.4        1.53 ± 20%  perf-profile.children.cycles-pp.call_transmit
      1.14 ± 12%      +0.4        1.51 ± 21%  perf-profile.children.cycles-pp.xprt_transmit
      1.12 ± 13%      +0.4        1.50 ± 21%  perf-profile.children.cycles-pp.xprt_request_transmit
      1.74 ±  6%      +0.4        2.14 ± 11%  perf-profile.children.cycles-pp.sched_tick
      3.24 ±  9%      +0.4        3.67 ±  6%  perf-profile.children.cycles-pp.cmd_stat
      3.24 ±  9%      +0.4        3.67 ±  6%  perf-profile.children.cycles-pp.dispatch_events
      1.07 ± 15%      +0.4        1.50 ±  3%  perf-profile.children.cycles-pp.irq_enter_rcu
      3.24 ±  9%      +0.4        3.66 ±  6%  perf-profile.children.cycles-pp.process_interval
      1.01 ± 16%      +0.4        1.45 ±  4%  perf-profile.children.cycles-pp.tick_irq_enter
      1.54 ± 17%      +0.5        2.02 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock
      3.08 ±  9%      +0.5        3.58 ±  6%  perf-profile.children.cycles-pp.read_counters
      5.90 ±  8%      +0.8        6.71 ±  6%  perf-profile.children.cycles-pp.handle_softirqs
     17.29 ±  2%      +0.9       18.18 ±  3%  perf-profile.children.cycles-pp.kthread
      3.57 ±  7%      +0.9        4.50 ± 10%  perf-profile.children.cycles-pp.update_process_times
     17.42 ±  2%      +1.0       18.38 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
     17.44 ±  2%      +1.0       18.41 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
      4.47 ±  4%      +1.4        5.85 ±  5%  perf-profile.children.cycles-pp.tick_nohz_handler
      5.49 ±  6%      +1.6        7.05 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      6.76 ±  8%      +1.7        8.42 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      6.90 ±  9%      +1.8        8.68 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     12.60 ±  7%      +2.6       15.18 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     13.99 ±  7%      +2.7       16.65 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.98 ± 27%      -0.9        0.11 ± 74%  perf-profile.self.cycles-pp.poll_idle
      0.53 ± 24%      -0.2        0.28 ± 28%  perf-profile.self.cycles-pp.__schedule
      0.28 ± 21%      -0.2        0.11 ± 24%  perf-profile.self.cycles-pp._find_next_bit
      0.32 ± 29%      -0.1        0.20 ± 23%  perf-profile.self.cycles-pp.zap_present_ptes
      0.06 ± 57%      +0.0        0.10 ± 31%  perf-profile.self.cycles-pp._copy_from_user
      0.06 ± 58%      +0.1        0.11 ± 28%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.06 ± 68%      +0.1        0.20 ± 37%  perf-profile.self.cycles-pp.tick_nohz_handler
      0.44 ± 19%      +0.2        0.66 ±  7%  perf-profile.self.cycles-pp.__memcpy




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


