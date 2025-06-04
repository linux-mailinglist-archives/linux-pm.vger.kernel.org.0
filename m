Return-Path: <linux-pm+bounces-28111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CA3ACDFFC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 16:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEDF172404
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1E0290BB1;
	Wed,  4 Jun 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0A+vQ7x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5A71E52D;
	Wed,  4 Jun 2025 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046482; cv=fail; b=mf4Ljafckm+ILNqdeYmV/fIjaAMloLwzzNtCsd+BGrrC2Mjrva4fPFAhQSltMlCILPwWijOxd6fvZSZr5jm6DaLnWJ1C55vn/YAqxrT4kp0xp7ZvlbYpGtH/5R2oond778B44YdyZ5ETwQnhD+1HYsse7Wrinn3mng+05h9hhBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046482; c=relaxed/simple;
	bh=ZqhRBcsjjJ3+DAVwWCLmlQ0w2XHjBrRMqiyS2WEWVyY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ctbjQcxVQYNPxjY8XDFZxVbrsSfi6elVJLT6mA3TNT0aMSZOo33/5gNb4LWWkVaPRqgRqF3aUTFAFDPRu8XOUuc6nV3JSww8m++rIsh0uSvgCpJIOKHz+vmantWQQHWR2gbC08/BhuUbx5wEWXM56VxTZNUO8u7B78pRCNFidec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0A+vQ7x; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749046470; x=1780582470;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=ZqhRBcsjjJ3+DAVwWCLmlQ0w2XHjBrRMqiyS2WEWVyY=;
  b=D0A+vQ7xM11+fcH7mDpuMKpLwuSsDzv6R3UD26gE/gnYsUvVfiU+TxOD
   6DdlLdSe9LxTlHvsE+E8sNknw7+Neg8KKI2GgT+hVyH6+NiRE/GRj1zVX
   N605kvmSFWjdE8Jp6hoSSl//Bj7s1Znkl1XRxhHplc+YmUCU3lPsS3N6v
   pQkRsSqSGNfgeHBVBoi7tiBE60GhrA+hjR0fwN5FDFWF4lABBsWG3ZwP0
   DtxN7xdKuWeNIOk46umuVf6iRAdLvT4JIcK5O7eBu1vkEuAFeXYWUNv97
   gQCHIDi4LGGbCTvotiiRRR9UrL7vN+/wJGFrtBMRj9I50VMJBMJZzY9Hx
   g==;
X-CSE-ConnectionGUID: PHzfKm8mSoiUzuFiqKQADA==
X-CSE-MsgGUID: qOKj6UXdSb+QuLuUL0jSlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51133959"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="51133959"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:14:26 -0700
X-CSE-ConnectionGUID: Z6vHcuHGTWyLfJi3yDJd3A==
X-CSE-MsgGUID: jOc0U8zUSzCXlnSGFbLO3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="149037109"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:14:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 07:14:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 07:14:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.53) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 07:14:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KskBi1gF0Y4OSkvDImTLxxZfdFbxi9JBTbVBWxMaDvwb0X0izhhbrT6YbKXYw+wvV6gFxqR5f/YZrn7r0Az/348uKIi+uAbl8QrtrvujhA1EI4GjxXKMpKEuytwb1MvFNlBCd0Ys1Z04AXRjrvzWy3khSXSh3IwYrUpbUUwhcE0hfuDJO7pOKeMJd49spPC2iabeCGwM4oD2sWgnzFs/Fcs7kRqGUz6nLsw6QWRLpCTP/IWpIM7rd/5vaB0LC0rbBBfsTV40HeNtb32O/3FK118sovZo8D9px1A5LMWQSrfj8/sZgBukt8mkLyST0TzWWBXjd3+I92SFEA/pDBZQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4YwRNEcBqgb7A2sHMOCpFMorehUF/INfUNq1C8X3+U=;
 b=CyhtOQk34vStndvOAje+RhAo2vRUuXYh+HCHQcTH3RPVFaHc9AR1IfF7MqaOUXTtiwoqBeStFFR6ZcD5vUAK5R1Y0iJXc1gRv91TLmn3CcnEGjdj3et4nAuv14rTDRL78+nSMF28M4TGtKYc3D+IRPZGxNzdDUbpdAzi1fIueJSi0/Qw+8UCWxJZbXRnBUU22JYMzyFnqG/vBzOZPSiEi994WW+3BppupPuUWtAFA+xbeXFqnP3Ywy1HAJxW+Jt8tromJvYGFUkxHd1zCSmRjyDpF2td+GnbZobQ3ToRnrHKf0qMgAfQdIllzB5D+sG2L9te8WCw7+MYowjgO5Mw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7657.namprd11.prod.outlook.com (2603:10b6:510:26c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Wed, 4 Jun
 2025 14:14:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 14:14:10 +0000
Date: Wed, 4 Jun 2025 22:13:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Christian Loehle
	<christian.loehle@arm.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>,
	<linux-pm@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [cpuidle]  85975daeaa: stress-ng.sem-sysv.ops_per_sec
 15.2% regression
Message-ID: <202506042113.498dd81a-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0100.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: a7de8d7a-dee9-4a4b-d27f-08dda372127d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?w5KhsTSrF5Nzt0SiTRLlct1NoeOxlhnABtJlVuPpL9pyNVZMizQ3tScRf8?=
 =?iso-8859-1?Q?oxVTCOHhocOC3+VqW/gIuuShW3hOLs6FpNi6wKISSd7wdzyh20U9AytRuJ?=
 =?iso-8859-1?Q?T7DP6GuaYwdf+Mj08e+ooMhbbSSRT1Pr6RWJaq6YAbLHt0kkvSJD1z7si7?=
 =?iso-8859-1?Q?toA95hYTsJH4bOSzk5V0atQMvc9un2EgfvGnR+FSAR3iSGezOUJTczOqmo?=
 =?iso-8859-1?Q?Llnx5VG6GH7oO6kayul0WcRMzAecZDksIjWFUqkKnf92CvXqL3oaMbERbi?=
 =?iso-8859-1?Q?R/2LzBNpd+5rcSFUu3+3wr2zm+lG/fZWsUdwm+zInnhoaBTnZowTfSE4wE?=
 =?iso-8859-1?Q?lQI0EyTCWaRwW6UsnJJr4FS3lbbeFu3JarQWDd3gsexxXEuTaWxE9cR9SF?=
 =?iso-8859-1?Q?P2YJwH8/mQGt8dwrpJIqzXBh9RCO43WXQIwrUE0b5HsClzMiT6Ql2BXfkD?=
 =?iso-8859-1?Q?F8IrjpmyR+Z4fSeksCZzqavlZK/ggVmhjyCe9XZZNf3iY8wZjeacRUxfcv?=
 =?iso-8859-1?Q?mPEMyr34PWOsXQvs6X6OeowPO9S6sNSFvAwzz+ddJVOCkE+NS1Cp9u+z2R?=
 =?iso-8859-1?Q?BiMczmDoqIoOAzyZh/1M+PisixfsUdujAyxUh0AGzk14+tNcue7dwXYk4+?=
 =?iso-8859-1?Q?niJe6NWZkBghQUF6QjVNRj8iHB/sUyDzxHCg97Kq0kOZ+zKrIa+il61oF0?=
 =?iso-8859-1?Q?DNIHIJoGB4YomR4u5QDTmAUCKO48oyNR0hKCJaP/lSiv28zgnPFTWE39Nv?=
 =?iso-8859-1?Q?RJinLiIwU1leWGF343ufmRF4jc5sElFoBOaahJCq+tDYhA060lKUBLpVRQ?=
 =?iso-8859-1?Q?K62AiX1bP0fWbAQqTZsS/GOdEYg884Mw1Qu40w1XZZ+FiXFJzl5jVYtmrd?=
 =?iso-8859-1?Q?Lx40YlbCz8rfvfKXO1+o3FN6rYbZG3L6cDR9IG6m6mf+NNVb4DmqBlKVsT?=
 =?iso-8859-1?Q?JKSU8dbkAQKZ9GdfSzuMMlXrIiiFZCBB+aoCQbXUNYu7UNrT+7gx9i9Jl2?=
 =?iso-8859-1?Q?8GhqobYK7wS084nC/pJ8bNqVRKFK48pW74sZYXN/MCVBNxghLqebbir/eB?=
 =?iso-8859-1?Q?KLqrjoSf5QCss53ah54CLNN9BlYMQY51JrAo/eNo/DeQjs9/NP9TklJfwH?=
 =?iso-8859-1?Q?srHCl1HAlb6515i42bSn8U5rFg1ly9qDfdJYOKZphdsCX61wkhLUR7XgaH?=
 =?iso-8859-1?Q?0VDG8QhxZ4Z1OMGTDhEdumXROj3/tJQ3iX5GRTOnq5aOee4FFvpOH5iPmr?=
 =?iso-8859-1?Q?TiwooIL8m9BMwzuSOEWAQjt7RhwgQMDu/nWOd7sbrGaniXjLT4z4I7I9pu?=
 =?iso-8859-1?Q?U3c9bbC4UlJGZ4aq0q0K4XBE9hDlqcxnYRsXnn2fvi9ZqxrLdI0X9X6YBx?=
 =?iso-8859-1?Q?oB7rKgCvGDXLDKoZ7asN8VF1UYjJCXdczC1CWn7bPuqT8Vu8w6AhbqWZtL?=
 =?iso-8859-1?Q?q4CTi/fDYSLtYkLu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?99oicJdH7zzxL0P4lD7vGvddp1n8hA1qHihQALP/9mCu6c6ikuW32hZDdX?=
 =?iso-8859-1?Q?MWCCbRZ9E62W2pOumlgrUFYCEOR+uAJmSrxAbG/YgGgJBcVF+x5bz0V+OI?=
 =?iso-8859-1?Q?0kSFU6avTHAd7bw47qYnjo2rw1plNKUTkoZGgU5QFcLg/i+OiryS+D5jY1?=
 =?iso-8859-1?Q?Z9Jy82llDTTLpeXLR3hhH+dUMEwq8nRAhhhvJBTy6sgdKZWMfBeCXpckbn?=
 =?iso-8859-1?Q?HPw4l8dac7R098TdloMYS+lmOpQzp2fgMVya/axmxCTp5b9MGgkV/5GZbK?=
 =?iso-8859-1?Q?LdcIDvOhWe+hxYoFIKt07vn7Z+j8ekniehyoetaobBBFuy0y1lgYryVjw4?=
 =?iso-8859-1?Q?ANZnMQjM0ADuksfV649ONCvH0/xRtNOg5RZ/1TgHA4jSW3/boIJxwyPzuO?=
 =?iso-8859-1?Q?RbVb7IgRCVGB4O/keSMD3yBM/xrDeGXkAciFmhhW/xt/j8egI+J1IJHBke?=
 =?iso-8859-1?Q?kFDMNbf34RKWlKAK2HFkcyR+zj4t74BE2NxfBuqF+zK+SnIEv3b5BeSGmv?=
 =?iso-8859-1?Q?mayHHXrHeNiXBD1PAlYJVvfJe3kt12/uUgNmcRP1tLh6kLgTtnB/sEX87E?=
 =?iso-8859-1?Q?yGptGR6BRw3xqpmQtVA8WdH1hiOYxIZGES5ZmZaXbWGpvBqd5oegVm32rB?=
 =?iso-8859-1?Q?c/aYNSMgiXCmnwEVVpVN+GJXP3Yc4FKhWY0lbdSHTWpdj4CDmOwy/qr3Hl?=
 =?iso-8859-1?Q?l+DplXb5TBXsrFhSNY0Uqb2c4u22hue1gu8QXc365c1whRydfLgelu2hbM?=
 =?iso-8859-1?Q?mmaDtPzyjTf3zruj+PvghcDtRWHrRa2HitzKo6tdHjEURldQJCpRJA3hky?=
 =?iso-8859-1?Q?at9FctFUPtUZH4XD1sHzqa/ogWI2lpclRAUcUMzi2uRae6MBAMnkmXiSkH?=
 =?iso-8859-1?Q?mwQucthR5Sn0e3324ru2cLHk4CyUmX9B2Dp/RJpEQqYAqgZBaeY3W0yo8l?=
 =?iso-8859-1?Q?VvrOLVunvA/cJbZDvss9LxqEN2yTR+o43l8NNOjjxEhnUGJsjXerlYEbv2?=
 =?iso-8859-1?Q?58Obx7QwRmIZJD7fI7vmwvyybNDEXbG8iz6AuXbz3a9IfJlb+8Zm9gXn6v?=
 =?iso-8859-1?Q?7c+r7TteITe/gnDhNW4wZatatn6vsHTgi3CQORgPFoTIMp6XR4AYsg5Aj1?=
 =?iso-8859-1?Q?nnOSvbriqt9uaf3VPF45ki/8TU4qduCTIiyQ0aQepVm8vuhxA6BXbsdkja?=
 =?iso-8859-1?Q?alDPcFZ/QnOixLf5FX7+ZppKcYyNi10khFkMAuDvP9pBMSyPvKIa9gAuc7?=
 =?iso-8859-1?Q?xSPkh+atasTjKYN/mOOPc6hc/Ws+Q06T5DrKs+Be4NTXS1zeucNGcKBO5/?=
 =?iso-8859-1?Q?U/5vuDXi/kiwb3YeDu57hTFnISGp3GOnKqSEWmaBdUD2HJ4XThR87pfzmm?=
 =?iso-8859-1?Q?9c4ArNHnh3zUM5Rb6WREFY5byk+Fs/SuJ9cKOhjrsL6ldZr1xhk0/eLdu8?=
 =?iso-8859-1?Q?CVqjZ4sfV+ZH97gRkgZ7KePLJX5QebZ/TKJDxinAN4HnOdVfGZinZ9THfY?=
 =?iso-8859-1?Q?kEqesqMiFSUNMVfWQ5RijPIWaTdEFHLpVN3vEXrmpiOv7kaMh/8PpvBhxo?=
 =?iso-8859-1?Q?csniT5D8Z/6A5JZQ/7fW3vSbgpBxqZeD06KCmObREZM7kyOpKrlidvvTqs?=
 =?iso-8859-1?Q?mBAhYnPdW+7rYZrMQ8opGf9nenf5jB1pte?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7de8d7a-dee9-4a4b-d27f-08dda372127d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 14:14:09.9539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ks7DioHV/1Ie081CT3ks2noaFN897aVdw5JIEe6JxrN3sjHvynd32YXnOy/rhWr1V2SKKIt88ot2piMNmqF84A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7657
X-OriginatorOrg: intel.com



Hello,

we reported
"[linux-next:master] [cpuidle]  85975daeaa: filebench.sum_operations/s 67.2% improvement"
in
https://lore.kernel.org/all/202503102146.28d80a16-lkp@intel.com/

now we got more bisect results for this commit. FYI.


kernel test robot noticed a 15.2% regression of stress-ng.sem-sysv.ops_per_sec on:


commit: 85975daeaa4d6ec560bfcd354fc9c08ad7f38888 ("cpuidle: menu: Avoid discarding useful information")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on linus/masteri     f66bc387efbee59978e076ce9bf123ac353b389c]
[still regression on linux-next/master 3a83b350b5be4b4f6bd895eecf9a92080200ee5d]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: sem-sysv
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.fcntl.ops_per_sec 28.8% improvement                                       |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1HDD                                                                                      |
|                  | fs=btrfs                                                                                       |
|                  | nr_threads=100%                                                                                |
|                  | test=fcntl                                                                                     |
|                  | testtime=60s                                                                                   |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.dirdeep.ops_per_sec 13.2% improvement                                     |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1HDD                                                                                      |
|                  | fs=btrfs                                                                                       |
|                  | nr_threads=100%                                                                                |
|                  | test=dirdeep                                                                                   |
|                  | testtime=60s                                                                                   |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | lmbench3: lmbench3.TCP.socket.bandwidth.10MB.MB/sec  7.3% regression                           |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory    |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | mode=development                                                                               |
|                  | nr_threads=50%                                                                                 |
|                  | test=TCP                                                                                       |
|                  | test_memory_size=50%                                                                           |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.symlink.ops_per_sec  6.5% regression                                      |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1HDD                                                                                      |
|                  | fs=btrfs                                                                                       |
|                  | nr_threads=100%                                                                                |
|                  | test=symlink                                                                                   |
|                  | testtime=60s                                                                                   |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.file-ioctl.ops_per_sec 81.0% improvement                                  |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1HDD                                                                                      |
|                  | fs=ext4                                                                                        |
|                  | nr_threads=100%                                                                                |
|                  | test=file-ioctl                                                                                |
|                  | testtime=60s                                                                                   |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | filebench: filebench.sum_operations/s 63.2% improvement                                        |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1HDD                                                                                      |
|                  | fs2=cifs                                                                                       |
|                  | fs=ext4                                                                                        |
|                  | test=makedirs.f                                                                                |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | filebench: filebench.sum_operations/s 1.1% improvement                                         |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1HDD                                                                                      |
|                  | fs2=cifs                                                                                       |
|                  | fs=xfs                                                                                         |
|                  | test=singlestreamwritedirect.f                                                                 |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | filebench: filebench.sum_operations/s 67.2% improvement                                        |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | disk=1HDD                                                                                      |
|                  | fs2=cifs                                                                                       |
|                  | fs=btrfs                                                                                       |
|                  | test=makedirs.f                                                                                |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | fxmark: fxmark.ssd_xfs_DWSL_4_directio.works/sec 23.1% improvement                             |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | directio=directio                                                                              |
|                  | disk=1SSD                                                                                      |
|                  | fstype=xfs                                                                                     |
|                  | media=ssd                                                                                      |
|                  | test=DWSL                                                                                      |
|                  | thread_nr=4                                                                                    |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | fxmark: fxmark.ssd_ext4_DRBM_4_directio.works/sec 23.0% improvement                            |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | directio=directio                                                                              |
|                  | disk=1SSD                                                                                      |
|                  | fstype=ext4                                                                                    |
|                  | media=ssd                                                                                      |
|                  | test=DRBM                                                                                      |
|                  | thread_nr=4                                                                                    |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | fxmark: fxmark.ssd_ext4_DWSL_4_directio.works/sec 113.8% improvement                           |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | directio=directio                                                                              |
|                  | disk=1SSD                                                                                      |
|                  | fstype=ext4                                                                                    |
|                  | media=ssd                                                                                      |
|                  | test=DWSL                                                                                      |
|                  | thread_nr=4                                                                                    |
+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | fxmark: fxmark.ssd_ext4_no_jnl_DRBM_4_directio.works/sec 21.9% improvement                     |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | directio=directio                                                                              |
|                  | disk=1SSD                                                                                      |
|                  | fstype=ext4_no_jnl                                                                             |
|                  | media=ssd                                                                                      |
|                  | test=DRBM                                                                                      |
|                  | thread_nr=4                                                                                    |
+------------------+------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506042113.498dd81a-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250604/202506042113.498dd81a-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/sem-sysv/stress-ng/60s

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1061229            -1.0%    1051114        proc-vmstat.nr_file_pages
    179386            -5.6%     169271        proc-vmstat.nr_shmem
    380916           -15.1%     323277        vmstat.system.cs
     46994 ±  2%     +81.9%      85490        vmstat.system.in
      0.05 ±  4%      +0.0        0.08 ±  2%  mpstat.cpu.all.irq%
      0.04 ±  4%      +0.0        0.06 ±  4%  mpstat.cpu.all.soft%
      0.38            -0.1        0.32        mpstat.cpu.all.sys%
      5.34           +10.2%       5.88        perf-sched.total_wait_and_delay.average.ms
      5.34           +10.2%       5.88        perf-sched.total_wait_time.average.ms
      3.06            +9.6%       3.35        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.__do_semtimedop.do_semtimedop.__x64_sys_semtimedop
      3.05            +9.6%       3.34        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.__do_semtimedop.do_semtimedop.__x64_sys_semtimedop
  11910911           -15.2%   10095779        stress-ng.sem-sysv.ops
    198513           -15.2%     168261        stress-ng.sem-sysv.ops_per_sec
     86.60            -7.7%      79.90        stress-ng.time.percent_of_cpu_this_job_got
  11913083           -15.2%   10097903        stress-ng.time.voluntary_context_switches
      1.67 ±  4%     +10.1%       1.84 ±  4%  perf-stat.i.MPKI
      1.86 ±  4%      +0.1        1.98        perf-stat.i.branch-miss-rate%
    393241           -15.1%     333696        perf-stat.i.context-switches
      1.41            +8.2%       1.52        perf-stat.i.cpi
      0.78            -5.7%       0.74        perf-stat.i.ipc
      1.79           -14.9%       1.52        perf-stat.i.metric.K/sec
      2.45 ±  5%      +0.2        2.66        perf-stat.overall.branch-miss-rate%
    386812           -15.1%     328226        perf-stat.ps.context-switches
     16.22            -7.7        8.56 ±  5%  perf-profile.calltrace.cycles-pp.intel_idle_xstate.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     34.64            -3.4       31.20        perf-profile.calltrace.cycles-pp.stress_sem_sysv
     31.37            -3.2       28.18        perf-profile.calltrace.cycles-pp.semtimedop.stress_sem_sysv
     29.16            -2.8       26.32        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.semtimedop.stress_sem_sysv
     29.07            -2.8       26.24        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.semtimedop.stress_sem_sysv
      4.77            -2.3        2.44 ±  5%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      2.90 ±  2%      -1.5        1.37 ±  7%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      2.86 ±  2%      -1.5        1.35 ±  7%  perf-profile.calltrace.cycles-pp.tick_nohz_stop_tick.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry
     12.16            -1.5       10.69        perf-profile.calltrace.cycles-pp.__x64_sys_semtimedop.do_syscall_64.entry_SYSCALL_64_after_hwframe.semtimedop.stress_sem_sysv
     10.18 ±  2%      -1.5        8.72 ±  2%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      2.53 ±  2%      -1.4        1.13 ±  7%  perf-profile.calltrace.cycles-pp.tick_nohz_restart_sched_tick.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary
     11.60            -1.4       10.24        perf-profile.calltrace.cycles-pp.do_semtimedop.__x64_sys_semtimedop.do_syscall_64.entry_SYSCALL_64_after_hwframe.semtimedop
     11.07            -1.3        9.80        perf-profile.calltrace.cycles-pp.__do_semtimedop.do_semtimedop.__x64_sys_semtimedop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.44 ±  2%      -1.1        8.37        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
     14.14            -1.1       13.08        perf-profile.calltrace.cycles-pp.do_semtimedop.do_syscall_64.entry_SYSCALL_64_after_hwframe.semtimedop.stress_sem_sysv
     13.68            -1.0       12.69        perf-profile.calltrace.cycles-pp.__do_semtimedop.do_semtimedop.do_syscall_64.entry_SYSCALL_64_after_hwframe.semtimedop
      7.32            -0.7        6.57 ±  2%  perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range.__do_semtimedop.do_semtimedop.__x64_sys_semtimedop.do_syscall_64
      0.92 ± 30%      -0.6        0.28 ±100%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.semtimedop.stress_sem_sysv
      1.18 ±  4%      -0.6        0.54 ± 33%  perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.tick_nohz_restart_sched_tick.tick_nohz_idle_exit.do_idle.cpu_startup_entry
      1.40 ±  3%      -0.6        0.76 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.tick_nohz_stop_tick.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle
      1.23 ±  4%      -0.5        0.69 ±  7%  perf-profile.calltrace.cycles-pp.__hrtimer_start_range_ns.hrtimer_start_range_ns.tick_nohz_stop_tick.tick_nohz_idle_stop_tick.cpuidle_idle_call
      1.15 ±  5%      -0.5        0.62 ±  6%  perf-profile.calltrace.cycles-pp.tick_nohz_stop_idle.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary
      1.13 ±  6%      -0.5        0.61 ±  6%  perf-profile.calltrace.cycles-pp.nr_iowait_cpu.tick_nohz_stop_idle.tick_nohz_idle_exit.do_idle.cpu_startup_entry
      6.13            -0.5        5.61 ±  2%  perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range.__do_semtimedop.do_semtimedop.__x64_sys_semtimedop
      5.95            -0.5        5.45 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_hrtimeout_range.__do_semtimedop.do_semtimedop
      5.20 ±  2%      -0.5        4.70 ±  2%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.24 ±  4%      -0.5        0.75 ±  6%  perf-profile.calltrace.cycles-pp.llist_reverse_order.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      5.01 ±  2%      -0.5        4.54 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      7.84            -0.4        7.40 ±  2%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      1.53 ±  3%      -0.4        1.13 ±  3%  perf-profile.calltrace.cycles-pp.start_dl_timer.enqueue_dl_entity.dl_server_start.enqueue_task_fair.enqueue_task
      0.88 ±  3%      -0.4        0.49 ± 34%  perf-profile.calltrace.cycles-pp.clockevents_program_event.__hrtimer_start_range_ns.hrtimer_start_range_ns.tick_nohz_stop_tick.tick_nohz_idle_stop_tick
      2.21 ±  5%      -0.4        1.82 ±  3%  perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.wake_up_q.__do_semtimedop
      1.33 ±  4%      -0.4        0.96 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity.dl_server_start.enqueue_task_fair
      1.88 ±  3%      -0.4        1.51 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_dl_entity.dl_server_start.enqueue_task_fair.enqueue_task.ttwu_do_activate
      1.91 ±  3%      -0.4        1.55 ±  3%  perf-profile.calltrace.cycles-pp.dl_server_start.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending
      1.21 ±  3%      -0.4        0.86 ±  3%  perf-profile.calltrace.cycles-pp.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity.dl_server_start
      4.31 ±  2%      -0.3        3.96 ±  2%  perf-profile.calltrace.cycles-pp.do_smart_update.__do_semtimedop.do_semtimedop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.08 ±  3%      -0.3        0.74 ±  4%  perf-profile.calltrace.cycles-pp.get_nohz_timer_target.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity
      1.06 ±  3%      -0.3        0.72 ±  5%  perf-profile.calltrace.cycles-pp.idle_cpu.get_nohz_timer_target.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer
      4.22 ±  2%      -0.3        3.89 ±  2%  perf-profile.calltrace.cycles-pp.update_queue.do_smart_update.__do_semtimedop.do_semtimedop.do_syscall_64
      1.50 ±  3%      -0.3        1.20 ±  2%  perf-profile.calltrace.cycles-pp.call_function_single_prep_ipi.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.wake_up_q
      0.55 ±  5%      -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.__enqueue_entity.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate
      2.66 ±  4%      -0.3        2.38 ±  2%  perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.wake_up_q.__do_semtimedop.do_semtimedop
      1.18 ±  3%      -0.3        0.91 ±  5%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule_idle.do_idle
      1.22 ±  3%      -0.3        0.95 ±  5%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule_idle.do_idle.cpu_startup_entry
      2.07 ±  3%      -0.3        1.82 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule
      2.40 ±  2%      -0.2        2.16 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.semtimedop.stress_sem_sysv
      3.29 ±  2%      -0.2        3.05        perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.schedule_hrtimeout_range.__do_semtimedop
      3.23 ±  2%      -0.2        3.00        perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.schedule_hrtimeout_range
      3.18 ±  2%      -0.2        2.96        perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule.schedule
      1.25 ±  4%      -0.2        1.07 ±  5%  perf-profile.calltrace.cycles-pp.find_alloc_undo.__do_semtimedop.do_semtimedop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84 ±  4%      -0.2        0.68 ±  4%  perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.semtimedop
      2.14 ±  3%      -0.2        1.99 ±  4%  perf-profile.calltrace.cycles-pp.stress_semaphore_sysv_thrash.stress_sem_sysv
      1.04 ±  2%      -0.1        0.90 ±  5%  perf-profile.calltrace.cycles-pp.__get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call
      0.85 ±  4%      -0.1        0.73 ±  3%  perf-profile.calltrace.cycles-pp.dl_server_stop.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule
      0.68 ±  2%      -0.1        0.58 ±  5%  perf-profile.calltrace.cycles-pp.lookup_undo.find_alloc_undo.__do_semtimedop.do_semtimedop.do_syscall_64
      0.63 ±  4%      +0.1        0.70 ±  4%  perf-profile.calltrace.cycles-pp.switch_fpu_return.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.semtimedop
      1.15 ±  6%      +0.1        1.30 ±  4%  perf-profile.calltrace.cycles-pp.wake_affine.select_task_rq_fair.select_task_rq.try_to_wake_up.wake_up_q
      1.11 ±  6%      +0.2        1.26 ±  4%  perf-profile.calltrace.cycles-pp.available_idle_cpu.wake_affine.select_task_rq_fair.select_task_rq.try_to_wake_up
      1.35 ±  2%      +0.5        1.83 ±  3%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      1.69            +0.5        2.17 ±  2%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      2.73 ±  2%      +0.5        3.22 ±  2%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_domains._nohz_idle_balance.handle_softirqs.do_softirq
      0.93 ± 12%      +0.6        1.49 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.98 ± 10%      +0.6        1.55 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.start_kernel
      0.00            +0.6        0.57 ± 11%  perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.6        0.58 ±  5%  perf-profile.calltrace.cycles-pp.sched_balance_domains.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.6        0.59 ±  5%  perf-profile.calltrace.cycles-pp.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.6        0.63 ±  6%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.7        0.74 ± 14%  perf-profile.calltrace.cycles-pp.tmigr_requires_handle_remote.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.7        0.74 ± 15%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.7        0.75 ±  2%  perf-profile.calltrace.cycles-pp.sched_balance_domains._nohz_idle_balance.handle_softirqs.do_softirq.flush_smp_call_function_queue
      0.00            +0.8        0.80 ± 14%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.8        0.82 ± 13%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.05 ±299%      +0.8        0.87 ±  7%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.handle_softirqs.__irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single
      0.05 ±299%      +0.8        0.88 ±  7%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.cpuidle_enter_state.cpuidle_enter
      0.05 ±299%      +0.8        0.88 ±  7%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.cpuidle_enter_state
      0.00            +1.0        0.97 ± 10%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
     59.91            +1.1       61.00        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     59.88            +1.1       60.97        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     59.78            +1.1       60.89        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +1.2        1.19 ±  9%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.2        1.22 ±  7%  perf-profile.calltrace.cycles-pp.__update_blocked_fair.sched_balance_update_blocked_averages._nohz_idle_balance.handle_softirqs.do_softirq
      0.00            +1.6        1.60 ±  8%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      2.28 ±  3%      +1.7        3.94 ±  5%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.handle_softirqs.do_softirq.flush_smp_call_function_queue.do_idle
      2.29 ±  3%      +1.7        3.96 ±  5%  perf-profile.calltrace.cycles-pp.do_softirq.flush_smp_call_function_queue.do_idle.cpu_startup_entry.rest_init
      2.29 ±  3%      +1.7        3.96 ±  5%  perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      2.30 ±  3%      +1.7        3.97 ±  5%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.rest_init.start_kernel
      0.54 ± 34%      +1.9        2.44 ±  7%  perf-profile.calltrace.cycles-pp.sched_balance_update_blocked_averages._nohz_idle_balance.handle_softirqs.do_softirq.flush_smp_call_function_queue
      0.32 ± 81%      +2.1        2.38 ±  6%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.05 ±300%      +2.1        2.16 ±  7%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      3.33 ±  2%      +2.3        5.61 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      3.33 ±  2%      +2.3        5.61 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations
      3.33 ±  2%      +2.3        5.61 ±  4%  perf-profile.calltrace.cycles-pp.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      3.33 ±  2%      +2.3        5.61 ±  4%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      3.33 ±  2%      +2.3        5.61 ±  4%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.common_startup_64
      3.33 ±  2%      +2.3        5.61 ±  4%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
     63.25            +3.4       66.61        perf-profile.calltrace.cycles-pp.common_startup_64
      0.80 ±  6%      +3.6        4.40 ±  6%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.85 ±  6%      +3.7        4.56 ±  6%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.81 ± 11%      +5.6        7.38 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     38.11            +5.7       43.79        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.95 ± 11%      +6.6        8.50 ±  6%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     31.10            +6.8       37.86        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     31.80            +6.9       38.69        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.76 ±  5%      +8.4       10.16 ±  5%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     16.28            -7.7        8.62 ±  5%  perf-profile.children.cycles-pp.intel_idle_xstate
     34.64            -3.4       31.20        perf-profile.children.cycles-pp.stress_sem_sysv
     32.10            -3.3       28.78        perf-profile.children.cycles-pp.semtimedop
     30.56            -2.8       27.74        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     30.24            -2.8       27.48        perf-profile.children.cycles-pp.do_syscall_64
     25.78            -2.4       23.36        perf-profile.children.cycles-pp.do_semtimedop
      4.82            -2.3        2.53 ±  4%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
     24.85            -2.3       22.57        perf-profile.children.cycles-pp.__do_semtimedop
      5.01            -1.8        3.22 ±  3%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      2.92 ±  2%      -1.5        1.39 ±  7%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      2.90 ±  2%      -1.5        1.37 ±  7%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
     12.19            -1.5       10.72        perf-profile.children.cycles-pp.__x64_sys_semtimedop
      2.59 ±  2%      -1.4        1.20 ±  7%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      9.82            -1.2        8.63        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      3.25            -1.1        2.14 ±  3%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
     11.25            -1.0       10.28        perf-profile.children.cycles-pp.__schedule
      2.30            -0.9        1.38 ±  4%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      4.28 ±  3%      -0.9        3.40 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      7.38            -0.8        6.62 ±  2%  perf-profile.children.cycles-pp.schedule_hrtimeout_range
      0.96 ±  6%      -0.6        0.34 ±  8%  perf-profile.children.cycles-pp.tmigr_cpu_activate
      0.84 ±  4%      -0.6        0.27 ± 10%  perf-profile.children.cycles-pp.tmigr_cpu_deactivate
      1.46 ±  3%      -0.6        0.90 ±  5%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.83 ±  6%      -0.6        0.28 ±  9%  perf-profile.children.cycles-pp.__tmigr_cpu_activate
      8.15            -0.5        7.62 ±  2%  perf-profile.children.cycles-pp.sched_ttwu_pending
      2.64 ±  3%      -0.5        2.11 ±  3%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      6.27            -0.5        5.76 ±  2%  perf-profile.children.cycles-pp.schedule
      5.24 ±  2%      -0.5        4.73 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      1.16 ±  5%      -0.5        0.65 ±  6%  perf-profile.children.cycles-pp.nr_iowait_cpu
      1.19 ±  5%      -0.5        0.68 ±  6%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      1.28 ±  3%      -0.5        0.78 ±  6%  perf-profile.children.cycles-pp.llist_reverse_order
      0.70 ±  5%      -0.5        0.21 ± 11%  perf-profile.children.cycles-pp.tmigr_inactive_up
      0.94 ±  3%      -0.4        0.49 ±  6%  perf-profile.children.cycles-pp.leave_mm
      1.63 ±  3%      -0.4        1.20 ±  2%  perf-profile.children.cycles-pp.start_dl_timer
      2.00 ±  3%      -0.4        1.59 ±  3%  perf-profile.children.cycles-pp.enqueue_dl_entity
      2.04 ±  3%      -0.4        1.64 ±  3%  perf-profile.children.cycles-pp.dl_server_start
      2.23 ±  5%      -0.4        1.84 ±  3%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.46 ±  5%      -0.4        0.08 ± 11%  perf-profile.children.cycles-pp.tmigr_update_events
      1.20 ±  3%      -0.4        0.84 ±  4%  perf-profile.children.cycles-pp.get_nohz_timer_target
      4.32 ±  2%      -0.3        3.98 ±  2%  perf-profile.children.cycles-pp.do_smart_update
      2.86 ±  3%      -0.3        2.52 ±  3%  perf-profile.children.cycles-pp.__pick_next_task
      4.23 ±  2%      -0.3        3.90 ±  2%  perf-profile.children.cycles-pp.update_queue
      2.56 ±  3%      -0.3        2.24 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.52 ±  3%      -0.3        1.22 ±  2%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      2.68 ±  4%      -0.3        2.40 ±  2%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      2.14 ±  3%      -0.3        1.88 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      1.12 ±  5%      -0.3        0.86 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      1.57 ±  3%      -0.2        1.33 ±  5%  perf-profile.children.cycles-pp.find_alloc_undo
      2.45 ±  2%      -0.2        2.22 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.30 ±  2%      -0.2        3.07        perf-profile.children.cycles-pp.try_to_block_task
      3.27 ±  2%      -0.2        3.04        perf-profile.children.cycles-pp.dequeue_task_fair
      1.14 ±  2%      -0.2        0.92 ±  4%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      1.56 ±  2%      -0.2        1.35 ±  2%  perf-profile.children.cycles-pp.idle_cpu
      3.22 ±  2%      -0.2        3.01        perf-profile.children.cycles-pp.dequeue_entities
      0.72 ±  4%      -0.2        0.51 ±  4%  perf-profile.children.cycles-pp.hrtimer_cancel
      0.59 ±  5%      -0.2        0.38 ±  5%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      1.20 ±  3%      -0.2        1.02 ±  5%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.86 ±  3%      -0.2        0.70 ±  4%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      2.16 ±  3%      -0.2        2.00 ±  4%  perf-profile.children.cycles-pp.stress_semaphore_sysv_thrash
      0.55 ±  4%      -0.1        0.40 ±  8%  perf-profile.children.cycles-pp.tmigr_quick_check
      0.49 ±  5%      -0.1        0.34 ±  7%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.31 ±  7%      -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.tmigr_active_up
      0.47 ±  4%      -0.1        0.33 ±  7%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.37 ± 24%      -0.1        0.24 ± 10%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.88 ±  4%      -0.1        0.76 ±  3%  perf-profile.children.cycles-pp.dl_server_stop
      0.62 ±  5%      -0.1        0.50 ±  7%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.77 ±  2%      -0.1        0.65 ±  5%  perf-profile.children.cycles-pp.lookup_undo
      0.36 ±  8%      -0.1        0.25 ±  9%  perf-profile.children.cycles-pp.timerqueue_add
      1.49 ±  3%      -0.1        1.38 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.78 ±  4%      -0.1        0.69 ±  5%  perf-profile.children.cycles-pp.__switch_to
      0.62 ±  5%      -0.1        0.53 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.43 ±  6%      -0.1        0.35 ±  7%  perf-profile.children.cycles-pp.finish_task_switch
      0.32 ±  7%      -0.1        0.23 ± 11%  perf-profile.children.cycles-pp.put_pid
      0.48 ±  3%      -0.1        0.39 ±  6%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.46 ±  3%      -0.1        0.38 ±  6%  perf-profile.children.cycles-pp.set_next_task_fair
      0.34 ±  8%      -0.1        0.27 ±  8%  perf-profile.children.cycles-pp.timerqueue_del
      0.40 ±  7%      -0.1        0.32 ±  8%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.54 ±  5%      -0.1        0.47 ±  5%  perf-profile.children.cycles-pp.__switch_to_asm
      0.37 ±  8%      -0.1        0.30 ±  9%  perf-profile.children.cycles-pp.__get_user_8
      0.43 ±  5%      -0.1        0.36 ±  6%  perf-profile.children.cycles-pp.set_next_entity
      0.32 ±  6%      -0.1        0.26 ±  5%  perf-profile.children.cycles-pp.get_timespec64
      0.15 ± 18%      -0.1        0.09 ± 17%  perf-profile.children.cycles-pp.quiet_vmstat
      0.35 ±  6%      -0.1        0.29 ±  8%  perf-profile.children.cycles-pp.os_xsave
      0.26 ±  7%      -0.1        0.20 ±  6%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.44 ±  4%      -0.1        0.38 ±  7%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.57 ±  6%      -0.1        0.51 ±  3%  perf-profile.children.cycles-pp.__enqueue_entity
      0.32 ±  7%      -0.1        0.26 ±  3%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.14 ± 18%      -0.1        0.08 ± 18%  perf-profile.children.cycles-pp.need_update
      0.24 ±  9%      -0.0        0.19 ± 10%  perf-profile.children.cycles-pp.rb_erase
      0.33 ±  4%      -0.0        0.28 ±  7%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.34 ±  5%      -0.0        0.29 ±  6%  perf-profile.children.cycles-pp.task_work_run
      0.21 ± 16%      -0.0        0.16 ± 12%  perf-profile.children.cycles-pp.semop
      0.24 ± 10%      -0.0        0.19 ± 11%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.11 ±  9%      -0.0        0.07 ± 20%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.13 ± 12%      -0.0        0.09 ± 15%  perf-profile.children.cycles-pp.rb_insert_color
      0.16 ±  8%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.do_smart_wakeup_zero
      0.08 ± 11%      -0.0        0.05 ± 34%  perf-profile.children.cycles-pp.fpu_idle_fpregs
      0.12 ±  9%      -0.0        0.09 ± 11%  perf-profile.children.cycles-pp.hrtimer_active
      0.10 ± 20%      +0.0        0.14 ± 11%  perf-profile.children.cycles-pp._find_next_and_bit
      0.18 ±  8%      +0.0        0.22 ±  8%  perf-profile.children.cycles-pp.avg_vruntime
      0.03 ±100%      +0.0        0.08 ± 12%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.write
      0.26 ±  6%      +0.1        0.32 ±  5%  perf-profile.children.cycles-pp.place_entity
      0.10 ± 14%      +0.1        0.16 ± 11%  perf-profile.children.cycles-pp.sched_balance_softirq
      0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.rcu_pending
      0.65 ±  4%      +0.1        0.72 ±  4%  perf-profile.children.cycles-pp.switch_fpu_return
      0.06 ± 38%      +0.1        0.13 ±  7%  perf-profile.children.cycles-pp.__memcpy
      0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.update_dl_rq_load_avg
      0.06 ±  9%      +0.1        0.15 ± 18%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.66 ±  3%      +0.1        0.76 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.06 ± 35%      +0.1        0.15 ± 11%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.50 ±  4%      +0.1        0.60 ±  5%  perf-profile.children.cycles-pp.sched_clock
      0.58 ±  4%      +0.1        0.68 ±  5%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.10 ± 13%      +0.1        0.20 ±  5%  perf-profile.children.cycles-pp.should_we_balance
      0.01 ±299%      +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.update_rt_rq_load_avg
      0.10 ± 16%      +0.1        0.20 ± 17%  perf-profile.children.cycles-pp.wakeup_preempt
      0.06 ± 11%      +0.1        0.17 ± 12%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.08 ± 16%      +0.1        0.20 ± 13%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.04 ± 50%      +0.1        0.16 ± 13%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.33 ±  4%      +0.1        0.45 ±  7%  perf-profile.children.cycles-pp.kthread
      0.34 ±  4%      +0.1        0.46 ±  7%  perf-profile.children.cycles-pp.ret_from_fork
      0.34 ±  5%      +0.1        0.46 ±  7%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.15 ±  4%      +0.1        1.28 ±  2%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.21 ±  5%      +0.1        0.34 ±  9%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.09 ± 16%      +0.1        0.22 ±  7%  perf-profile.children.cycles-pp.irqtime_account_irq
      1.16 ±  6%      +0.1        1.31 ±  4%  perf-profile.children.cycles-pp.wake_affine
      1.14 ±  6%      +0.2        1.29 ±  4%  perf-profile.children.cycles-pp.available_idle_cpu
      1.21 ±  3%      +0.2        1.38 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.45 ±  7%      +0.2        0.63 ±  6%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.14 ± 13%      +0.2        0.35 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.01 ±300%      +0.2        0.22 ±  8%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.16 ± 10%      +0.3        0.42 ±  7%  perf-profile.children.cycles-pp.update_other_load_avgs
      1.95 ±  3%      +0.3        2.23 ±  4%  perf-profile.children.cycles-pp.clockevents_program_event
      0.16 ± 11%      +0.3        0.44 ±  7%  perf-profile.children.cycles-pp.update_irq_load_avg
      2.78 ±  3%      +0.3        3.09 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.77 ±  3%      +0.3        1.11 ±  4%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.83 ± 18%      +0.4        1.20 ±  6%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.85 ±  3%      +0.4        1.23 ±  4%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.86 ±  3%      +0.4        1.25 ±  4%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      1.73            +0.5        2.21 ±  2%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      1.38 ±  2%      +0.5        1.86 ±  3%  perf-profile.children.cycles-pp.tick_nohz_next_event
      2.76 ±  2%      +0.5        3.25 ±  2%  perf-profile.children.cycles-pp.menu_select
      0.14 ± 14%      +0.5        0.65 ±  6%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.5        0.50 ± 11%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.13 ± 17%      +0.5        0.64 ±  5%  perf-profile.children.cycles-pp.sched_tick
      0.06 ± 36%      +0.5        0.58 ± 11%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      1.03 ±  4%      +0.5        1.56 ±  2%  perf-profile.children.cycles-pp.sched_balance_rq
      0.02 ±124%      +0.6        0.62 ± 18%  perf-profile.children.cycles-pp.get_jiffies_update
      0.22 ±  7%      +0.6        0.83 ± 13%  perf-profile.children.cycles-pp.tick_irq_enter
      0.13 ± 12%      +0.6        0.75 ± 14%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.22 ±  6%      +0.6        0.84 ± 13%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.84 ±  5%      +0.8        1.64 ±  2%  perf-profile.children.cycles-pp.sched_balance_domains
      1.39 ±  8%      +1.0        2.39 ±  6%  perf-profile.children.cycles-pp.__irq_exit_rcu
     59.91            +1.1       61.00        perf-profile.children.cycles-pp.start_secondary
      0.47 ±  6%      +1.3        1.78 ±  6%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.35 ±  8%      +1.3        1.70 ±  7%  perf-profile.children.cycles-pp.update_process_times
      2.33 ±  2%      +1.6        3.97 ±  5%  perf-profile.children.cycles-pp.do_softirq
      0.60 ±  6%      +1.7        2.26 ±  7%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.69 ±  4%      +1.8        2.50 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.68 ±  3%      +1.8        3.50 ±  4%  perf-profile.children.cycles-pp.ktime_get
      3.34 ±  2%      +2.2        5.52 ±  4%  perf-profile.children.cycles-pp._nohz_idle_balance
      3.33 ±  2%      +2.3        5.61 ±  4%  perf-profile.children.cycles-pp.rest_init
      3.33 ±  2%      +2.3        5.61 ±  4%  perf-profile.children.cycles-pp.start_kernel
      3.33 ±  2%      +2.3        5.61 ±  4%  perf-profile.children.cycles-pp.x86_64_start_kernel
      3.33 ±  2%      +2.3        5.61 ±  4%  perf-profile.children.cycles-pp.x86_64_start_reservations
      1.00 ±  5%      +2.6        3.58 ±  6%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      3.76 ±  2%      +2.7        6.46 ±  3%  perf-profile.children.cycles-pp.handle_softirqs
     63.25            +3.4       66.61        perf-profile.children.cycles-pp.common_startup_64
     63.25            +3.4       66.61        perf-profile.children.cycles-pp.cpu_startup_entry
     63.15            +3.4       66.53        perf-profile.children.cycles-pp.do_idle
      1.03 ±  4%      +3.6        4.59 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.08 ±  4%      +3.7        4.75 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.36 ±  4%      +5.4        7.80 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      2.60 ±  4%      +5.9        8.50 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     39.14            +6.3       45.39        perf-profile.children.cycles-pp.cpuidle_idle_call
     32.01            +7.3       39.32        perf-profile.children.cycles-pp.cpuidle_enter_state
     32.05            +7.3       39.36        perf-profile.children.cycles-pp.cpuidle_enter
      1.78 ±  5%      +8.4       10.20 ±  5%  perf-profile.children.cycles-pp.intel_idle
     16.20            -7.6        8.57 ±  5%  perf-profile.self.cycles-pp.intel_idle_xstate
      3.66 ±  2%      -0.8        2.89 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      1.46 ±  4%      -0.6        0.89 ±  5%  perf-profile.self.cycles-pp.lapic_next_deadline
      2.61 ±  3%      -0.5        2.09 ±  3%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.16 ±  5%      -0.5        0.65 ±  6%  perf-profile.self.cycles-pp.nr_iowait_cpu
      1.28 ±  3%      -0.5        0.77 ±  6%  perf-profile.self.cycles-pp.llist_reverse_order
      3.67            -0.5        3.18 ±  2%  perf-profile.self.cycles-pp.__do_semtimedop
      0.52 ±  7%      -0.4        0.11 ± 14%  perf-profile.self.cycles-pp.__tmigr_cpu_activate
      0.68 ±  7%      -0.4        0.31 ± 11%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      1.51 ±  4%      -0.3        1.21 ±  2%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.80 ±  7%      -0.3        0.52 ±  3%  perf-profile.self.cycles-pp.update_rq_clock
      0.62 ±  7%      -0.2        0.40 ±  5%  perf-profile.self.cycles-pp.sched_ttwu_pending
      1.33 ±  3%      -0.2        1.11 ±  4%  perf-profile.self.cycles-pp.update_queue
      1.54 ±  2%      -0.2        1.33 ±  2%  perf-profile.self.cycles-pp.idle_cpu
      0.58 ±  5%      -0.2        0.38 ±  5%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.52 ±  4%      -0.2        0.33 ±  5%  perf-profile.self.cycles-pp._nohz_idle_balance
      0.73 ±  7%      -0.2        0.57 ±  9%  perf-profile.self.cycles-pp.do_idle
      0.91 ±  5%      -0.2        0.76 ±  5%  perf-profile.self.cycles-pp.semtimedop
      0.39 ±  6%      -0.2        0.24 ±  7%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.65 ±  6%      -0.2        0.50 ±  7%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.55 ±  4%      -0.1        0.40 ±  8%  perf-profile.self.cycles-pp.tmigr_quick_check
      0.30 ±  6%      -0.1        0.16 ±  7%  perf-profile.self.cycles-pp.tmigr_active_up
      0.87 ±  5%      -0.1        0.75 ±  5%  perf-profile.self.cycles-pp.enqueue_entity
      0.24 ± 10%      -0.1        0.13 ± 15%  perf-profile.self.cycles-pp.tmigr_inactive_up
      0.76 ±  2%      -0.1        0.65 ±  5%  perf-profile.self.cycles-pp.lookup_undo
      1.44 ±  3%      -0.1        1.33 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.34 ±  6%      -0.1        0.25 ±  6%  perf-profile.self.cycles-pp.__hrtimer_start_range_ns
      0.75 ±  4%      -0.1        0.66 ±  6%  perf-profile.self.cycles-pp.__switch_to
      0.28 ±  9%      -0.1        0.19 ±  4%  perf-profile.self.cycles-pp.hrtimer_start_range_ns
      0.55 ±  2%      -0.1        0.46 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.60 ±  5%      -0.1        0.51 ±  5%  perf-profile.self.cycles-pp._copy_from_user
      0.24 ±  6%      -0.1        0.16 ±  9%  perf-profile.self.cycles-pp.timerqueue_add
      0.44 ±  3%      -0.1        0.36 ±  6%  perf-profile.self.cycles-pp.do_semtimedop
      0.53 ±  5%      -0.1        0.46 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.26 ±  9%      -0.1        0.18 ±  8%  perf-profile.self.cycles-pp.__get_next_timer_interrupt
      0.36 ±  8%      -0.1        0.30 ±  9%  perf-profile.self.cycles-pp.__get_user_8
      0.35 ±  6%      -0.1        0.29 ±  7%  perf-profile.self.cycles-pp.os_xsave
      0.44 ±  4%      -0.1        0.38 ±  7%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.32 ±  6%      -0.1        0.26 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.15 ±  5%      -0.1        0.10 ±  6%  perf-profile.self.cycles-pp.__remove_hrtimer
      0.27 ±  6%      -0.0        0.22 ± 10%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.29 ±  5%      -0.0        0.25 ±  7%  perf-profile.self.cycles-pp.do_syscall_64
      0.19 ±  9%      -0.0        0.15 ±  9%  perf-profile.self.cycles-pp.hrtimer_try_to_cancel
      0.24 ±  8%      -0.0        0.20 ±  9%  perf-profile.self.cycles-pp.__x64_sys_semtimedop
      0.30 ±  5%      -0.0        0.25 ±  6%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.11 ± 10%      -0.0        0.07 ± 39%  perf-profile.self.cycles-pp.clockevents_program_event
      0.26 ±  5%      -0.0        0.22 ±  7%  perf-profile.self.cycles-pp.finish_task_switch
      0.08 ± 13%      -0.0        0.04 ± 50%  perf-profile.self.cycles-pp.fpu_idle_fpregs
      0.24 ±  4%      -0.0        0.20 ±  8%  perf-profile.self.cycles-pp.dequeue_entity
      0.15 ±  7%      -0.0        0.12 ± 10%  perf-profile.self.cycles-pp.schedule_idle
      0.14 ±  7%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.07 ± 14%      +0.0        0.10 ± 15%  perf-profile.self.cycles-pp.list_add_leaf_cfs_rq
      0.17 ±  8%      +0.0        0.21 ±  8%  perf-profile.self.cycles-pp.avg_vruntime
      0.05 ± 52%      +0.0        0.09 ± 11%  perf-profile.self.cycles-pp.sched_balance_rq
      0.09 ± 15%      +0.0        0.14 ± 16%  perf-profile.self.cycles-pp.tmigr_requires_handle_remote
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.sched_tick
      0.05 ± 39%      +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.__memcpy
      0.00            +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.1        0.08 ± 13%  perf-profile.self.cycles-pp.update_dl_rq_load_avg
      0.05 ± 36%      +0.1        0.15 ± 12%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.63 ±  3%      +0.1        0.73 ±  4%  perf-profile.self.cycles-pp.native_sched_clock
      0.05 ± 34%      +0.1        0.15 ± 18%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.02 ±153%      +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.01 ±299%      +0.1        0.11 ± 18%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
      0.08 ± 20%      +0.1        0.20 ± 16%  perf-profile.self.cycles-pp.wakeup_preempt
      0.36 ±  8%      +0.1        0.49 ±  9%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.21 ±  9%      +0.1        0.34 ±  9%  perf-profile.self.cycles-pp.switch_fpu_return
      0.01 ±300%      +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      1.13 ±  6%      +0.2        1.28 ±  4%  perf-profile.self.cycles-pp.available_idle_cpu
      0.24 ±  9%      +0.2        0.39 ±  8%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.21 ± 10%      +0.2        0.37 ±  7%  perf-profile.self.cycles-pp.dequeue_entities
      1.17 ±  4%      +0.2        1.34 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.42 ±  8%      +0.2        0.60 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.31 ±  6%      +0.2        0.51 ±  6%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.14 ± 13%      +0.2        0.35 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.01 ±300%      +0.2        0.22 ±  8%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.22 ±  9%      +0.2        0.46 ±  6%  perf-profile.self.cycles-pp.sched_balance_domains
      0.15 ±  9%      +0.3        0.43 ±  7%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.03 ± 82%      +0.3        0.34 ± 13%  perf-profile.self.cycles-pp.tick_nohz_handler
      0.57 ±  3%      +0.3        0.88 ±  6%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.14 ±  9%      +0.4        0.56 ± 11%  perf-profile.self.cycles-pp.sched_balance_update_blocked_averages
      0.13 ± 13%      +0.5        0.60 ±  6%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.5        0.50 ± 11%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.51 ±  6%      +0.5        1.04 ±  5%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.02 ±124%      +0.6        0.62 ± 18%  perf-profile.self.cycles-pp.get_jiffies_update
      0.24 ±  9%      +0.7        0.91 ±  7%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.78 ±  5%      +1.9        2.67 ±  5%  perf-profile.self.cycles-pp.ktime_get
      1.78 ±  5%      +8.4       10.20 ±  5%  perf-profile.self.cycles-pp.intel_idle


***************************************************************************************************
lkp-icl-2sp4: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp4/fcntl/stress-ng/60s

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    543988 ± 20%     +54.1%     838269 ± 13%  numa-meminfo.node1.Shmem
     12730 ± 29%     -31.9%       8669 ±  8%  uptime.idle
  6.73e+09 ± 14%     -41.1%  3.964e+09 ± 18%  cpuidle..time
  13333824           +61.2%   21490444 ± 18%  cpuidle..usage
     81.34 ±  2%     -37.5%      50.80 ± 16%  iostat.cpu.idle
     17.99 ±  9%    +168.9%      48.38 ± 17%  iostat.cpu.system
    454164 ± 20%     +31.2%     596074 ± 10%  numa-numastat.node1.local_node
    507986 ± 13%     +30.4%     662329 ±  8%  numa-numastat.node1.numa_hit
    135917 ± 20%     +54.3%     209698 ± 13%  numa-vmstat.node1.nr_shmem
    506585 ± 13%     +30.7%     662186 ±  8%  numa-vmstat.node1.numa_hit
    452763 ± 20%     +31.6%     595931 ± 10%  numa-vmstat.node1.numa_local
   1634214           +22.1%    1995390 ±  2%  meminfo.Active
   1634214           +22.1%    1995390 ±  2%  meminfo.Active(anon)
   2524592 ±  3%     +15.6%    2917394        meminfo.Committed_AS
    352408 ±  8%     +34.6%     474413 ±  6%  meminfo.Mapped
    714515 ±  4%     +48.5%    1061286 ±  4%  meminfo.Shmem
     80.86 ±  2%     -31.6       49.26 ± 18%  mpstat.cpu.all.idle%
      0.16 ±  9%      +0.1        0.26 ±  6%  mpstat.cpu.all.irq%
      0.08 ±  8%      -0.0        0.04 ± 10%  mpstat.cpu.all.soft%
     18.23 ±  9%     +31.4       49.61 ± 17%  mpstat.cpu.all.sys%
      0.68 ± 20%      +0.2        0.83 ±  4%  mpstat.cpu.all.usr%
     81.36 ±  2%     -37.5%      50.82 ± 16%  vmstat.cpu.id
     17.98 ±  9%    +169.1%      48.38 ± 17%  vmstat.cpu.sy
     23.31 ± 10%    +171.3%      63.25 ± 17%  vmstat.procs.r
    397622 ± 10%     +42.3%     565625 ± 17%  vmstat.system.cs
     93674 ±  9%    +140.8%     225582 ± 11%  vmstat.system.in
   4877304           +28.8%    6283702 ±  2%  stress-ng.fcntl.ops
     81287           +28.8%     104727 ±  2%  stress-ng.fcntl.ops_per_sec
      5942 ±  4%     +46.2%       8688 ± 19%  stress-ng.time.involuntary_context_switches
      2498 ±  6%    +162.5%       6558 ± 17%  stress-ng.time.percent_of_cpu_this_job_got
      1484 ±  7%    +164.3%       3924 ± 17%  stress-ng.time.system_time
  13148151           +37.6%   18086055 ± 17%  stress-ng.time.voluntary_context_switches
    408609           +22.1%     498989 ±  2%  proc-vmstat.nr_active_anon
   1079717            +8.0%    1166491        proc-vmstat.nr_file_pages
     88454 ±  8%     +34.6%     119063 ±  6%  proc-vmstat.nr_mapped
      4314 ±  7%      +7.2%       4624 ±  2%  proc-vmstat.nr_page_table_pages
    178676 ±  4%     +48.6%     265451 ±  4%  proc-vmstat.nr_shmem
    408609           +22.1%     498989 ±  2%  proc-vmstat.nr_zone_active_anon
     22708 ± 23%    +329.9%      97622 ± 20%  proc-vmstat.numa_hint_faults
     10392 ± 45%    +366.1%      48435 ± 24%  proc-vmstat.numa_hint_faults_local
    864151           +18.6%    1025244 ±  3%  proc-vmstat.numa_hit
    731734 ±  2%     +21.6%     889707 ±  3%  proc-vmstat.numa_local
    107144 ±  9%     +24.0%     132852 ±  5%  proc-vmstat.numa_pages_migrated
    489942 ±  5%     +36.9%     670847 ±  5%  proc-vmstat.numa_pte_updates
   1075821           +16.2%    1250280 ±  2%  proc-vmstat.pgalloc_normal
    640754 ±  4%     +13.3%     725943 ±  2%  proc-vmstat.pgfault
    107144 ±  9%     +24.0%     132852 ±  5%  proc-vmstat.pgmigrate_success
    184706 ± 31%    +477.1%    1065853 ± 37%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.16 ± 10%    +163.6%       0.41 ± 34%  sched_debug.cfs_rq:/.h_nr_running.avg
    184706 ± 31%    +477.1%    1065853 ± 37%  sched_debug.cfs_rq:/.min_vruntime.min
      0.16 ± 11%    +160.8%       0.41 ± 33%  sched_debug.cfs_rq:/.nr_running.avg
  1.02e+08 ± 79%     -83.5%   16827421 ±223%  sched_debug.cfs_rq:/.runnable_avg.max
   9759128 ± 82%     -78.9%    2057502 ±223%  sched_debug.cfs_rq:/.runnable_avg.stddev
    195.69 ±  3%    +146.1%     481.50 ± 30%  sched_debug.cfs_rq:/.util_avg.avg
    908.42 ± 10%     +32.4%       1202 ± 16%  sched_debug.cfs_rq:/.util_avg.max
     26.45 ± 11%   +1051.2%     304.45 ± 67%  sched_debug.cfs_rq:/.util_est.avg
    448.08 ± 16%     +90.4%     853.25 ± 36%  sched_debug.cfs_rq:/.util_est.max
    655077           -24.8%     492469 ± 10%  sched_debug.cpu.avg_idle.avg
     39564 ± 41%     -62.6%      14795 ± 94%  sched_debug.cpu.avg_idle.min
    863.02           -16.1%     723.82        sched_debug.cpu.clock_task.stddev
    646.44 ± 12%    +180.3%       1812 ± 37%  sched_debug.cpu.curr->pid.avg
      0.00 ± 17%     +76.2%       0.00 ± 43%  sched_debug.cpu.next_balance.stddev
      0.15 ± 11%    +163.3%       0.41 ± 35%  sched_debug.cpu.nr_running.avg
    102225           +37.3%     140355 ± 16%  sched_debug.cpu.nr_switches.avg
    112896           +42.0%     160335 ± 10%  sched_debug.cpu.nr_switches.max
      3807 ±  8%     +77.5%       6759 ± 16%  sched_debug.cpu.nr_switches.stddev
      2.08           -42.2%       1.20 ± 16%  perf-stat.i.MPKI
 3.949e+09 ± 11%    +140.8%   9.51e+09 ± 24%  perf-stat.i.branch-instructions
      2.99 ±  2%      -2.3        0.69 ±  8%  perf-stat.i.branch-miss-rate%
 1.087e+08 ± 15%     -54.7%   49234912 ±  3%  perf-stat.i.branch-misses
      7.00 ±  5%     +22.5       29.55 ±  2%  perf-stat.i.cache-miss-rate%
  32652924 ± 10%     +18.9%   38827999 ±  5%  perf-stat.i.cache-misses
 4.773e+08 ± 10%     -71.3%   1.37e+08 ±  5%  perf-stat.i.cache-references
    416502 ± 10%     +42.5%     593579 ± 17%  perf-stat.i.context-switches
      4.47 ±  4%     +27.8%       5.71 ±  7%  perf-stat.i.cpi
 7.788e+10 ±  9%    +186.9%  2.235e+11 ± 16%  perf-stat.i.cpu-cycles
      2398 ±  7%    +164.0%       6331 ± 26%  perf-stat.i.cycles-between-cache-misses
 1.747e+10 ± 11%    +148.7%  4.344e+10 ± 27%  perf-stat.i.instructions
      0.25 ± 15%     -25.0%       0.18 ±  8%  perf-stat.i.ipc
      7461 ±  7%     +24.7%       9305 ±  3%  perf-stat.i.minor-faults
      7461 ±  7%     +24.7%       9305 ±  3%  perf-stat.i.page-faults
      1.88 ±  6%     -56.6%       0.82 ± 56%  perf-stat.overall.MPKI
      2.74 ± 10%      -2.3        0.46 ± 54%  perf-stat.overall.branch-miss-rate%
      0.22 ±  2%     -28.9%       0.16 ± 46%  perf-stat.overall.ipc
 1.067e+08 ± 15%     -62.4%   40070510 ± 44%  perf-stat.ps.branch-misses
 4.693e+08 ± 10%     -76.1%   1.12e+08 ± 45%  perf-stat.ps.cache-references
      0.11 ±  5%     -91.7%       0.01 ± 41%  perf-sched.sch_delay.avg.ms.__cond_resched.fcntl_setlk.do_fcntl.__x64_sys_fcntl.do_syscall_64
      0.18 ± 26%     -99.1%       0.00 ±141%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.posix_lock_inode.fcntl_setlk.do_fcntl
      0.11 ± 14%     -89.1%       0.01 ± 78%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      0.11 ± 24%     -83.9%       0.02 ± 43%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.06 ± 36%     -86.8%       0.01 ± 61%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.17 ± 15%     -83.2%       0.03 ± 82%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.04 ± 23%     -81.5%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.13           -89.1%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.fcntl_setlk.do_fcntl.__x64_sys_fcntl.do_syscall_64
      0.09 ± 19%     -89.6%       0.01 ± 26%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.06 ± 35%     -85.0%       0.01 ± 58%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.07 ± 39%     -80.1%       0.01 ± 82%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.07 ± 23%     -90.8%       0.01 ± 38%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_truncate
      0.08 ± 16%     -89.8%       0.01 ± 44%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.04 ± 31%     -81.4%       0.01 ± 62%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.06 ± 16%     -87.6%       0.01 ± 21%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.09 ±  2%     -87.4%       0.01 ± 42%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.06 ± 36%     -85.3%       0.01 ± 78%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.05 ±  7%     -35.1%       0.03 ± 18%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.28 ± 19%     -99.3%       0.00 ±142%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.posix_lock_inode.fcntl_setlk.do_fcntl
      0.35 ± 17%     -66.2%       0.12 ± 94%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      0.44 ± 12%     -44.0%       0.25 ± 31%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.25 ± 25%     -88.0%       0.03 ±154%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.24 ± 29%     -72.6%       0.07 ± 98%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.43 ± 12%     -66.4%       0.14 ± 84%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.27 ± 20%     -73.7%       0.07 ±129%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.38 ± 15%     -49.4%       0.19 ± 65%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_truncate
      0.44 ± 10%     -63.0%       0.16 ± 67%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.39 ±  5%     -50.9%       0.19 ± 65%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.39 ± 13%     -74.6%       0.10 ±102%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.13           -88.7%       0.01 ±  6%  perf-sched.total_sch_delay.average.ms
      2.41           -33.5%       1.61 ±  2%  perf-sched.total_wait_and_delay.average.ms
    754294           +45.1%    1094575        perf-sched.total_wait_and_delay.count.ms
      2.29           -30.5%       1.59 ±  2%  perf-sched.total_wait_time.average.ms
      0.79           -52.6%       0.37        perf-sched.wait_and_delay.avg.ms.fcntl_setlk.do_fcntl.__x64_sys_fcntl.do_syscall_64
      4.23 ±  3%     -31.1%       2.91 ±  6%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    748247           +45.5%    1088339        perf-sched.wait_and_delay.count.fcntl_setlk.do_fcntl.__x64_sys_fcntl.do_syscall_64
      0.66 ±  4%     -43.2%       0.38 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.fcntl_setlk.do_fcntl.__x64_sys_fcntl.do_syscall_64
      0.83 ± 36%     -95.7%       0.04 ±187%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.posix_lock_inode.fcntl_setlk.do_fcntl
      0.35 ±  8%     -22.9%       0.27 ±  3%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.66           -45.7%       0.36        perf-sched.wait_time.avg.ms.fcntl_setlk.do_fcntl.__x64_sys_fcntl.do_syscall_64
      4.17 ±  2%     -30.3%       2.90 ±  6%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.42 ± 34%     -62.8%       0.16 ± 24%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_truncate
      0.75 ±  7%     -26.7%       0.55        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.53 ±  4%     -46.2%       0.28 ±  5%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 87%     -81.0%       0.00 ± 56%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      1.42 ± 41%     -96.6%       0.05 ±196%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.posix_lock_inode.fcntl_setlk.do_fcntl
      0.29 ± 38%     -79.8%       0.06 ±133%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     11.37            -8.4        3.01 ± 55%  perf-profile.calltrace.cycles-pp.common_startup_64
     11.05            -8.1        2.98 ± 55%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     11.04            -8.1        2.98 ± 55%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     11.03            -8.0        2.98 ± 55%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      7.37            -5.3        2.11 ± 63%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      5.53            -3.6        1.93 ± 63%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      5.47            -3.6        1.90 ± 63%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      4.62            -3.3        1.36 ± 74%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      2.54            -1.4        1.10 ± 19%  perf-profile.calltrace.cycles-pp.notify_change.do_truncate.do_ftruncate.do_sys_ftruncate.do_syscall_64
      1.91            -1.4        0.48 ± 73%  perf-profile.calltrace.cycles-pp.schedule.fcntl_setlk.do_fcntl.__x64_sys_fcntl.do_syscall_64
      1.84            -1.4        0.46 ± 73%  perf-profile.calltrace.cycles-pp.__schedule.schedule.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      1.68            -1.4        0.33 ±100%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      2.35            -1.3        1.02 ± 19%  perf-profile.calltrace.cycles-pp.btrfs_setattr.notify_change.do_truncate.do_ftruncate.do_sys_ftruncate
      1.54            -1.2        0.32 ±100%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      2.00            -1.2        0.80 ± 22%  perf-profile.calltrace.cycles-pp.btrfs_setsize.btrfs_setattr.notify_change.do_truncate.do_ftruncate
      1.40            -1.1        0.27 ±100%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      1.82            -1.1        0.74 ± 22%  perf-profile.calltrace.cycles-pp.btrfs_truncate.btrfs_setsize.btrfs_setattr.notify_change.do_truncate
      1.72 ±  2%      -0.9        0.86 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_truncate
     11.37            -8.4        3.01 ± 55%  perf-profile.children.cycles-pp.common_startup_64
     11.37            -8.4        3.01 ± 55%  perf-profile.children.cycles-pp.cpu_startup_entry
     11.36            -8.4        3.00 ± 55%  perf-profile.children.cycles-pp.do_idle
     11.05            -8.1        2.98 ± 55%  perf-profile.children.cycles-pp.start_secondary
      7.49            -5.3        2.21 ± 56%  perf-profile.children.cycles-pp.cpuidle_idle_call
      5.63            -3.6        2.01 ± 56%  perf-profile.children.cycles-pp.cpuidle_enter
      5.60            -3.6        2.00 ± 56%  perf-profile.children.cycles-pp.cpuidle_enter_state
      4.67            -3.2        1.48 ± 59%  perf-profile.children.cycles-pp.intel_idle
      2.88            -2.1        0.78 ± 48%  perf-profile.children.cycles-pp.__schedule
      2.55            -1.4        1.11 ± 19%  perf-profile.children.cycles-pp.notify_change
      1.88            -1.4        0.44 ± 54%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      1.92            -1.4        0.55 ± 48%  perf-profile.children.cycles-pp.schedule
      2.35            -1.3        1.02 ± 19%  perf-profile.children.cycles-pp.btrfs_setattr
      2.00            -1.2        0.80 ± 22%  perf-profile.children.cycles-pp.btrfs_setsize
      1.58            -1.1        0.44 ± 53%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      1.82            -1.1        0.74 ± 22%  perf-profile.children.cycles-pp.btrfs_truncate
      1.44            -1.1        0.37 ± 53%  perf-profile.children.cycles-pp.sched_ttwu_pending
      1.24            -1.0        0.28 ± 53%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.19            -0.9        0.27 ± 53%  perf-profile.children.cycles-pp.enqueue_task
      1.14            -0.9        0.27 ± 53%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.72 ±  2%      -0.9        0.86 ± 10%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      1.04            -0.8        0.22 ± 51%  perf-profile.children.cycles-pp.try_to_block_task
      1.00            -0.8        0.22 ± 51%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.02            -0.8        0.26 ± 50%  perf-profile.children.cycles-pp.schedule_idle
      0.96            -0.8        0.21 ± 50%  perf-profile.children.cycles-pp.dequeue_entities
      0.76            -0.7        0.06 ± 73%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.72 ±  2%      -0.7        0.05 ± 74%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.99            -0.6        0.36 ± 54%  perf-profile.children.cycles-pp.__locks_wake_up_blocks
      0.95            -0.6        0.34 ± 53%  perf-profile.children.cycles-pp.__wake_up
      0.73            -0.6        0.14 ± 74%  perf-profile.children.cycles-pp.menu_select
      0.88            -0.6        0.30 ± 46%  perf-profile.children.cycles-pp.__pick_next_task
      0.87            -0.6        0.29 ± 53%  perf-profile.children.cycles-pp.__wake_up_common
      0.79            -0.5        0.26 ± 52%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.78            -0.5        0.27 ± 45%  perf-profile.children.cycles-pp.try_to_wake_up
      0.64            -0.5        0.15 ± 60%  perf-profile.children.cycles-pp.dequeue_entity
      0.54            -0.5        0.05 ± 75%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.61            -0.5        0.14 ± 43%  perf-profile.children.cycles-pp.locks_delete_lock_ctx
      0.60 ±  2%      -0.5        0.14 ± 43%  perf-profile.children.cycles-pp.locks_unlink_lock_ctx
      0.74 ±  2%      -0.4        0.29 ± 45%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.56 ±  2%      -0.4        0.11 ± 73%  perf-profile.children.cycles-pp.enqueue_entity
      0.78            -0.4        0.34 ± 18%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.52            -0.4        0.15 ± 43%  perf-profile.children.cycles-pp.update_load_avg
      0.42 ±  3%      -0.4        0.07 ± 72%  perf-profile.children.cycles-pp.handle_softirqs
      0.52            -0.3        0.19 ± 24%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.37            -0.3        0.07 ± 73%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.37            -0.3        0.09 ± 74%  perf-profile.children.cycles-pp.dl_server_start
      0.44 ±  3%      -0.3        0.16 ± 27%  perf-profile.children.cycles-pp.start_transaction
      0.36 ±  2%      -0.3        0.08 ± 74%  perf-profile.children.cycles-pp.enqueue_dl_entity
      0.30 ±  2%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.40 ±  2%      -0.3        0.14 ±  8%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.28 ±  2%      -0.2        0.05 ± 72%  perf-profile.children.cycles-pp.update_curr
      0.88            -0.2        0.65 ± 22%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.27            -0.2        0.05 ± 74%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.83            -0.2        0.61 ± 21%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.47            -0.2        0.25 ± 52%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.49 ±  2%      -0.2        0.28 ± 18%  perf-profile.children.cycles-pp.btrfs_update_inode
      0.24            -0.2        0.04 ±100%  perf-profile.children.cycles-pp.dl_server_stop
      0.32 ±  2%      -0.2        0.12 ± 23%  perf-profile.children.cycles-pp.btrfs_truncate_inode_items
      0.30 ±  3%      -0.2        0.09 ± 11%  perf-profile.children.cycles-pp.kmem_cache_free
      0.31            -0.2        0.11 ± 73%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.53            -0.2        0.33 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.23 ±  2%      -0.2        0.04 ±100%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.25 ±  3%      -0.2        0.06 ± 73%  perf-profile.children.cycles-pp.select_task_rq
      0.50            -0.2        0.32 ±  4%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.32 ±  2%      -0.2        0.15 ± 21%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.22 ±  3%      -0.2        0.05 ± 74%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.22 ±  3%      -0.2        0.06 ± 73%  perf-profile.children.cycles-pp.set_next_task_fair
      0.45            -0.2        0.29 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.36 ±  3%      -0.2        0.19 ± 43%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.63            -0.2        0.47 ± 12%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.62            -0.2        0.46 ± 12%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.24            -0.1        0.09 ± 74%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.36 ±  3%      -0.1        0.22 ± 19%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      0.18 ±  2%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.20 ±  2%      -0.1        0.05 ± 74%  perf-profile.children.cycles-pp.start_dl_timer
      0.23 ±  2%      -0.1        0.09 ± 23%  perf-profile.children.cycles-pp.btrfs_search_slot
      0.18 ±  2%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.prepare_task_switch
      0.18 ±  5%      -0.1        0.05 ± 75%  perf-profile.children.cycles-pp.set_next_entity
      0.24            -0.1        0.11 ± 31%  perf-profile.children.cycles-pp.clockevents_program_event
      0.32 ±  3%      -0.1        0.20 ± 44%  perf-profile.children.cycles-pp.sched_balance_rq
      0.20 ±  2%      -0.1        0.08 ± 53%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.23 ±  2%      -0.1        0.11 ± 74%  perf-profile.children.cycles-pp.prepare_to_wait_event
      0.16 ±  2%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.kill
      0.16 ±  3%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.getpgrp
      0.22 ±  2%      -0.1        0.11 ± 74%  perf-profile.children.cycles-pp.__locks_insert_block
      0.14 ±  2%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.f_setown
      0.28 ±  2%      -0.1        0.17 ± 45%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.27 ±  3%      -0.1        0.17 ± 45%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.14 ±  3%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.x64_sys_call
      0.18 ±  2%      -0.1        0.08 ± 22%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.14 ±  6%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.__clear_extent_bit
      0.12 ± 12%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.unmap_mapping_range
      0.17 ±  4%      -0.1        0.08 ± 72%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.12 ±  4%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
      0.12 ± 14%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.truncate_pagecache
      0.14 ±  3%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.sched_balance_domains
      0.12 ±  5%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__reserve_bytes
      0.15 ±  4%      -0.1        0.06 ± 74%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.14 ±  3%      -0.1        0.06 ± 47%  perf-profile.children.cycles-pp.fdget_raw
      0.12 ±  3%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.read_tsc
      0.11            -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.__f_setown
      0.12 ±  4%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.native_sched_clock
      0.14 ±  3%      -0.1        0.05 ± 46%  perf-profile.children.cycles-pp.__cond_resched
      0.22 ±  2%      -0.1        0.13 ± 17%  perf-profile.children.cycles-pp.btrfs_dirty_inode
      0.11 ± 14%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.__btrfs_release_delayed_node
      0.14 ±  2%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp._copy_from_user
      0.15 ±  4%      -0.1        0.07 ± 19%  perf-profile.children.cycles-pp.__btrfs_end_transaction
      0.11            -0.1        0.03 ±100%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.11 ±  6%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.wake_affine
      0.10 ±  4%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.btrfs_get_or_create_delayed_node
      0.13            -0.1        0.05 ± 73%  perf-profile.children.cycles-pp.idle_cpu
      0.10 ±  3%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.10            -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.__switch_to
      0.10 ±  3%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.btrfs_root_node
      0.10 ±  3%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.10 ±  6%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.btrfs_update_root_times
      0.14 ±  3%      -0.1        0.07 ± 75%  perf-profile.children.cycles-pp.posix_locks_conflict
      0.10 ±  5%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.btrfs_get_delayed_node
      0.11 ± 10%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.dentry_needs_remove_privs
      0.10 ±  4%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.available_idle_cpu
      0.12 ±  5%      -0.1        0.05 ± 75%  perf-profile.children.cycles-pp.update_rq_clock
      0.10 ± 14%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.security_inode_need_killpriv
      0.10 ± 11%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.cap_inode_need_killpriv
      0.10 ± 11%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.__vfs_getxattr
      0.08            -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.07 ±  6%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.09 ±  4%      -0.0        0.05 ± 74%  perf-profile.children.cycles-pp.llist_reverse_order
     86.48            +9.7       96.17        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     86.34            +9.7       96.08        perf-profile.children.cycles-pp.do_syscall_64
      4.67            -3.2        1.48 ± 59%  perf-profile.self.cycles-pp.intel_idle
      1.69            -1.0        0.68 ± 36%  perf-profile.self.cycles-pp._raw_spin_lock
      1.71 ±  2%      -0.9        0.86 ± 11%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.67 ±  3%      -0.4        0.24 ± 46%  perf-profile.self.cycles-pp.posix_lock_inode
      0.77            -0.4        0.34 ± 18%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.29 ±  2%      -0.3        0.03 ±100%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.46            -0.2        0.25 ± 51%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.29 ±  4%      -0.2        0.09 ± 12%  perf-profile.self.cycles-pp.kmem_cache_free
      0.24 ±  2%      -0.2        0.05 ± 74%  perf-profile.self.cycles-pp.menu_select
      0.33            -0.2        0.14 ± 23%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.23 ±  3%      -0.2        0.05 ± 74%  perf-profile.self.cycles-pp.__schedule
      0.25 ±  3%      -0.2        0.08 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.31            -0.2        0.14 ± 19%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.21 ±  2%      -0.1        0.07 ± 74%  perf-profile.self.cycles-pp.update_load_avg
      0.16 ±  3%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.22 ±  4%      -0.1        0.09 ± 23%  perf-profile.self.cycles-pp.do_fcntl
      0.16 ±  4%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.__libc_fcntl64
      0.19 ±  6%      -0.1        0.07 ± 72%  perf-profile.self.cycles-pp.posix_test_lock
      0.21 ±  2%      -0.1        0.09 ± 24%  perf-profile.self.cycles-pp.do_syscall_64
      0.19 ±  4%      -0.1        0.08 ± 22%  perf-profile.self.cycles-pp.__x64_sys_fcntl
      0.13 ±  3%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.12 ±  3%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.15 ±  5%      -0.1        0.06 ± 74%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.12 ±  4%      -0.1        0.04 ± 72%  perf-profile.self.cycles-pp.fdget_raw
      0.11            -0.1        0.03 ±100%  perf-profile.self.cycles-pp.read_tsc
      0.11 ±  5%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.native_sched_clock
      0.14 ±  3%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp._copy_from_user
      0.12 ±  4%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.14 ±  3%      -0.1        0.07 ± 74%  perf-profile.self.cycles-pp.posix_locks_conflict
      0.10            -0.1        0.03 ±100%  perf-profile.self.cycles-pp.btrfs_root_node
      0.12 ±  4%      -0.1        0.05 ± 72%  perf-profile.self.cycles-pp.idle_cpu
      0.09 ±  5%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.__switch_to
      0.09 ±  5%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.btrfs_get_delayed_node
      0.12 ±  9%      -0.1        0.05 ± 48%  perf-profile.self.cycles-pp.notify_change
      0.10 ±  4%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.available_idle_cpu
      0.13 ±  3%      -0.1        0.07 ± 73%  perf-profile.self.cycles-pp.update_cfs_group
      0.08            -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.prepare_task_switch
      0.14 ±  4%      -0.1        0.09 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.08 ±  6%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.__wake_up_common
      0.09 ±  4%      -0.0        0.05 ± 74%  perf-profile.self.cycles-pp.llist_reverse_order



***************************************************************************************************
lkp-icl-2sp4: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp4/dirdeep/stress-ng/60s

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   7906549           +34.6%   10644730 ±  2%  cpuidle..usage
    509060 ±  9%     +18.6%     603694 ±  6%  numa-numastat.node1.numa_hit
     95.48            -1.3%      94.23        iostat.cpu.idle
      4.21           +26.3%       5.31 ±  3%  iostat.cpu.system
    355.17 ±  9%    +808.7%       3227 ± 68%  perf-c2c.HITM.local
    660.50 ±  6%    +695.1%       5251 ± 67%  perf-c2c.HITM.total
    273597           +73.5%     474695 ± 13%  meminfo.Inactive
    273597           +73.5%     474695 ± 13%  meminfo.Inactive(file)
    504006           +13.9%     574080        meminfo.KReclaimable
    504006           +13.9%     574080        meminfo.SReclaimable
      0.06 ±  2%      +0.1        0.17 ± 19%  mpstat.cpu.all.iowait%
      3.93            +1.1        5.05 ±  4%  mpstat.cpu.all.sys%
     83.00 ± 11%     -45.0%      45.67 ±  5%  mpstat.max_utilization.seconds
      7.35          +547.8%      47.62 ±  2%  mpstat.max_utilization_pct
    148020           +71.0%     253060 ± 13%  numa-meminfo.node0.Inactive
    148020           +71.0%     253060 ± 13%  numa-meminfo.node0.Inactive(file)
    126007 ±  3%     +75.7%     221417 ± 12%  numa-meminfo.node1.Inactive
    126007 ±  3%     +75.7%     221417 ± 12%  numa-meminfo.node1.Inactive(file)
      7388 ±  2%     +91.7%      14163 ± 13%  vmstat.io.bo
      0.08 ± 14%    +217.0%       0.25 ± 14%  vmstat.procs.b
     86443           +45.9%     126086 ± 11%  vmstat.system.cs
     49974           +24.5%      62229 ±  3%  vmstat.system.in
      0.09 ±  5%     -20.3%       0.07 ±  7%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.18 ± 24%     -23.4%       0.14 ± 10%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.btrfs_tree_read_lock_nested.btrfs_search_slot.btrfs_lookup_dir_item
      0.16 ±108%    +168.7%       0.42 ± 56%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.20 ±  6%     +21.1%       0.24 ±  9%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1283 ±  5%     +11.3%       1428        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    226206           +15.0%     260196        stress-ng.dirdeep.ops
      2335           +13.2%       2644 ±  3%  stress-ng.dirdeep.ops_per_sec
   1077669           +84.8%    1991136 ± 13%  stress-ng.time.file_system_outputs
      3759 ±  3%     +21.4%       4565 ±  5%  stress-ng.time.involuntary_context_switches
     76585            +9.0%      83503        stress-ng.time.minor_page_faults
    486.33           +27.8%     621.67 ±  4%  stress-ng.time.percent_of_cpu_this_job_got
    471.02 ±  2%     +29.8%     611.18 ±  2%  stress-ng.time.system_time
   3830062           +48.7%    5696511 ±  9%  stress-ng.time.voluntary_context_switches
     85006 ±  2%     +75.5%     149204 ± 13%  numa-vmstat.node0.nr_dirtied
     37132           +70.8%      63435 ± 13%  numa-vmstat.node0.nr_inactive_file
     48596 ±  2%     +99.9%      97153 ± 15%  numa-vmstat.node0.nr_written
     37132           +70.8%      63435 ± 13%  numa-vmstat.node0.nr_zone_inactive_file
     68117 ±  3%     +88.7%     128512 ± 13%  numa-vmstat.node1.nr_dirtied
     31608 ±  3%     +75.6%      55507 ± 12%  numa-vmstat.node1.nr_inactive_file
     44504 ±  4%     +89.4%      84281 ± 13%  numa-vmstat.node1.nr_written
     31608 ±  3%     +75.6%      55507 ± 12%  numa-vmstat.node1.nr_zone_inactive_file
    508970 ±  9%     +18.5%     603164 ±  6%  numa-vmstat.node1.numa_hit
      6200 ±  4%    +672.4%      47890 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.29 ±  9%     -25.8%       0.22 ±  9%  sched_debug.cfs_rq:/.h_nr_running.stddev
      6200 ±  4%    +672.4%      47890 ±  9%  sched_debug.cfs_rq:/.min_vruntime.min
      0.29 ±  9%     -24.8%       0.22 ±  9%  sched_debug.cfs_rq:/.nr_running.stddev
      3.12 ±  7%     +17.3%       3.66 ±  4%  sched_debug.cpu.clock.stddev
    336.45 ± 19%     -48.6%     172.93 ± 15%  sched_debug.cpu.curr->pid.avg
      1079 ±  9%     -31.9%     735.25 ±  5%  sched_debug.cpu.curr->pid.stddev
      0.29 ±  9%     -23.9%       0.22 ±  9%  sched_debug.cpu.nr_running.stddev
     25418           +36.5%      34702        sched_debug.cpu.nr_switches.avg
     34673 ±  5%     +25.4%      43473 ±  2%  sched_debug.cpu.nr_switches.max
     22430 ±  2%     +29.4%      29030 ±  7%  sched_debug.cpu.nr_switches.min
      1913 ±  5%     +24.7%       2387 ±  3%  sched_debug.cpu.nr_switches.stddev
      4.67           -12.9%       4.07 ±  4%  perf-stat.i.MPKI
 1.721e+09 ±  3%     +27.9%  2.202e+09 ±  3%  perf-stat.i.branch-instructions
      2.98            -0.3        2.65        perf-stat.i.branch-miss-rate%
     13.07            +2.1       15.17 ±  4%  perf-stat.i.cache-miss-rate%
  43228613 ±  3%     +33.1%   57529406 ±  3%  perf-stat.i.cache-misses
     88448           +45.7%     128869 ± 11%  perf-stat.i.context-switches
 1.641e+10 ±  2%     +36.2%  2.235e+10 ±  4%  perf-stat.i.cpu-cycles
      2656 ±  2%     +57.6%       4187 ± 10%  perf-stat.i.cpu-migrations
    537.42            +6.4%     571.82        perf-stat.i.cycles-between-cache-misses
 9.735e+09 ±  2%     +28.3%  1.249e+10 ±  3%  perf-stat.i.instructions
      0.08 ± 54%    +127.5%       0.19 ±  8%  perf-stat.i.major-faults
      0.07 ± 49%    +691.9%       0.56 ± 22%  perf-stat.i.metric.K/sec
      4854            +4.7%       5081        perf-stat.i.minor-faults
      4854            +4.7%       5081        perf-stat.i.page-faults
      2.91 ±  2%      -1.1        1.81 ± 45%  perf-stat.overall.branch-miss-rate%
      0.59           -21.4%       0.47 ± 44%  perf-stat.overall.ipc
    272306            +3.7%     282361        proc-vmstat.nr_active_anon
    153118           +81.4%     277717 ± 13%  proc-vmstat.nr_dirtied
   1066133            +5.5%    1124738        proc-vmstat.nr_file_pages
     68543           +73.2%     118688 ± 12%  proc-vmstat.nr_inactive_file
     95917 ±  2%      +8.8%     104331 ±  3%  proc-vmstat.nr_shmem
    125885           +14.0%     143516        proc-vmstat.nr_slab_reclaimable
     96269            +3.9%      99983        proc-vmstat.nr_slab_unreclaimable
     93100           +94.9%     181434 ± 14%  proc-vmstat.nr_written
    272306            +3.7%     282361        proc-vmstat.nr_zone_active_anon
     68543           +73.2%     118688 ± 12%  proc-vmstat.nr_zone_inactive_file
     12058 ± 11%     +27.6%      15381 ± 12%  proc-vmstat.numa_hint_faults_local
    982272           +16.8%    1147454 ±  3%  proc-vmstat.numa_hit
    849846           +19.4%    1015038 ±  3%  proc-vmstat.numa_local
   1184753           +16.4%    1379598 ±  3%  proc-vmstat.pgalloc_normal
    647539            +3.4%     669676        proc-vmstat.pgfault
    896017 ±  2%      +9.4%     980665 ±  3%  proc-vmstat.pgfree
    744836           +94.9%    1451948 ± 14%  proc-vmstat.pgpgout
     17.05            -2.1       14.96 ± 17%  perf-profile.calltrace.cycles-pp.common_startup_64
      1.02 ±  2%      -0.6        0.44 ± 70%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.rest_init.start_kernel
      0.99 ±  2%      -0.6        0.43 ± 70%  perf-profile.calltrace.cycles-pp.do_softirq.flush_smp_call_function_queue.do_idle.cpu_startup_entry.rest_init
      0.98            -0.6        0.43 ± 70%  perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      0.98 ±  2%      -0.6        0.42 ± 70%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.handle_softirqs.do_softirq.flush_smp_call_function_queue.do_idle
      1.46            -0.4        1.08 ± 46%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      1.46            -0.4        1.08 ± 46%  perf-profile.calltrace.cycles-pp.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      1.46            -0.4        1.08 ± 46%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      1.46            -0.4        1.08 ± 46%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.common_startup_64
      1.46            -0.4        1.08 ± 46%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      1.46            -0.4        1.08 ± 46%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations
     17.29            +0.7       18.01 ±  3%  perf-profile.calltrace.cycles-pp.__filename_parentat.filename_create.do_linkat.__x64_sys_link.do_syscall_64
     16.93            +0.8       17.69 ±  4%  perf-profile.calltrace.cycles-pp.__filename_parentat.filename_create.do_mkdirat.__x64_sys_mkdir.do_syscall_64
     16.92            +0.8       17.69 ±  4%  perf-profile.calltrace.cycles-pp.path_parentat.__filename_parentat.filename_create.do_mkdirat.__x64_sys_mkdir
     16.81            +0.8       17.58 ±  4%  perf-profile.calltrace.cycles-pp.link_path_walk.path_parentat.__filename_parentat.filename_create.do_mkdirat
     23.62            +0.8       24.42 ±  3%  perf-profile.calltrace.cycles-pp.do_linkat.__x64_sys_link.do_syscall_64.entry_SYSCALL_64_after_hwframe.link
     26.38            +1.7       28.07 ±  6%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_parentat.__filename_parentat.filename_create
     17.05            -2.1       14.96 ± 17%  perf-profile.children.cycles-pp.common_startup_64
     17.05            -2.1       14.96 ± 17%  perf-profile.children.cycles-pp.cpu_startup_entry
     17.03            -2.1       14.95 ± 17%  perf-profile.children.cycles-pp.do_idle
      3.29            -0.7        2.61 ± 19%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      4.69            -0.6        4.13 ± 16%  perf-profile.children.cycles-pp.__schedule
      1.10 ±  2%      -0.4        0.68 ± 31%  perf-profile.children.cycles-pp.do_softirq
      1.46            -0.3        1.16 ± 30%  perf-profile.children.cycles-pp.rest_init
      1.46            -0.3        1.16 ± 30%  perf-profile.children.cycles-pp.start_kernel
      1.46            -0.3        1.16 ± 30%  perf-profile.children.cycles-pp.x86_64_start_kernel
      1.46            -0.3        1.16 ± 30%  perf-profile.children.cycles-pp.x86_64_start_reservations
      1.35 ±  3%      -0.3        1.08 ± 30%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      2.11 ±  6%      -0.2        1.88 ± 11%  perf-profile.children.cycles-pp.read_block_for_search
      1.34 ±  9%      -0.2        1.11 ± 12%  perf-profile.children.cycles-pp.find_extent_buffer
      0.88 ±  8%      -0.2        0.70 ± 13%  perf-profile.children.cycles-pp.find_extent_buffer_nolock
      0.32 ±  3%      -0.1        0.27 ± 21%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.42 ±  3%      -0.0        0.38 ±  7%  perf-profile.children.cycles-pp.poll_idle
      0.15 ±  5%      -0.0        0.11 ± 14%  perf-profile.children.cycles-pp.task_contending
      0.08 ± 11%      -0.0        0.05 ± 46%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.10 ±  4%      -0.0        0.08 ± 45%  perf-profile.children.cycles-pp.io_serial_in
      0.07 ± 11%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.__xa_store
      0.06 ±  6%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.hrtimer_active
      0.07 ±  9%      +0.1        0.20 ± 29%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.06 ± 11%      +0.1        0.20 ± 30%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.27 ±  7%      +0.2        0.48 ± 20%  perf-profile.children.cycles-pp.__irq_exit_rcu
     23.62            +0.8       24.42 ±  3%  perf-profile.children.cycles-pp.do_linkat
     26.67            +1.7       28.36 ±  6%  perf-profile.children.cycles-pp.inode_permission
     81.04            +2.1       83.15 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
     81.05            +2.1       83.16 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     50.62            +2.2       52.78 ±  3%  perf-profile.children.cycles-pp.link_path_walk
     50.57            +2.2       52.75 ±  3%  perf-profile.children.cycles-pp.__filename_parentat
     50.56            +2.2       52.74 ±  3%  perf-profile.children.cycles-pp.path_parentat
      0.70 ± 10%      -0.2        0.55 ± 13%  perf-profile.self.cycles-pp.find_extent_buffer_nolock
      0.39 ±  2%      -0.1        0.33 ± 19%  perf-profile.self.cycles-pp.update_load_avg
      0.35 ±  3%      -0.1        0.29 ± 22%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.40 ±  3%      -0.0        0.36 ±  6%  perf-profile.self.cycles-pp.poll_idle
      0.08 ±  9%      -0.0        0.05 ± 46%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.10 ±  4%      -0.0        0.08 ± 45%  perf-profile.self.cycles-pp.io_serial_in
     22.79            +1.5       24.25 ±  5%  perf-profile.self.cycles-pp.inode_permission



***************************************************************************************************
lkp-spr-2sp4: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_threads/rootfs/tbox_group/test/test_memory_size/testcase:
  gcc-12/performance/x86_64-rhel-9.4/development/50%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/TCP/50%/lmbench3

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    174085            -7.3%     161319        lmbench3.TCP.socket.bandwidth.10MB.MB/sec
      0.58 ±  7%      -0.2        0.40 ±  6%  mpstat.cpu.all.irq%
 6.417e+08            -5.0%  6.096e+08 ±  2%  proc-vmstat.numa_hit
 6.413e+08            -5.0%  6.091e+08 ±  2%  proc-vmstat.numa_local
 5.116e+09            -5.0%  4.858e+09 ±  2%  proc-vmstat.pgalloc_normal
 5.115e+09            -5.0%  4.858e+09 ±  2%  proc-vmstat.pgfree
      1.87            -0.0        1.84        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     48.46            +0.2       48.62        perf-profile.calltrace.cycles-pp.write
     43.82            +0.2       44.02        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     43.18            +0.2       43.38        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     38.09            +0.2       38.29        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     39.70            +0.2       39.92        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     32.76            +0.2       32.99        perf-profile.calltrace.cycles-pp.sock_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.85            +0.2       31.10        perf-profile.calltrace.cycles-pp.sock_recvmsg.sock_read_iter.vfs_read.ksys_read.do_syscall_64
     30.08            +0.3       30.33        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.sock_read_iter.vfs_read.ksys_read
     29.68            +0.3       29.94        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.sock_recvmsg.sock_read_iter.vfs_read
     24.83            +0.3       25.10        perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg.sock_read_iter
      6.10 ±  2%      +0.3        6.37        perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.release_sock.tcp_sendmsg.sock_write_iter.vfs_write
      0.33 ±  2%      -0.0        0.29 ±  6%  perf-profile.children.cycles-pp.write@plt
      0.55            -0.0        0.53        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
     50.22            +0.2       50.39        perf-profile.children.cycles-pp.write
     38.48            +0.2       38.69        perf-profile.children.cycles-pp.vfs_write
     83.94            +0.2       84.16        perf-profile.children.cycles-pp.do_syscall_64
     32.85            +0.2       33.08        perf-profile.children.cycles-pp.sock_read_iter
     40.11            +0.2       40.34        perf-profile.children.cycles-pp.ksys_write
     31.05            +0.2       31.30        perf-profile.children.cycles-pp.sock_recvmsg
     30.17            +0.3       30.43        perf-profile.children.cycles-pp.inet_recvmsg
     29.86            +0.3       30.12        perf-profile.children.cycles-pp.tcp_recvmsg
     25.09            +0.3       25.36        perf-profile.children.cycles-pp.tcp_recvmsg_locked
      0.45 ±  2%      -0.1        0.31 ±  9%  perf-profile.self.cycles-pp.source
      1.73            -0.1        1.64        perf-profile.self.cycles-pp.vfs_read
      3.76            -0.0        3.72        perf-profile.self.cycles-pp.tcp_sendmsg_locked
      0.73            -0.0        0.71        perf-profile.self.cycles-pp.ksys_read
      0.35            +0.0        0.37        perf-profile.self.cycles-pp.tcp_release_cb
      2.08            +0.0        2.12        perf-profile.self.cycles-pp.tcp_write_xmit
      1.68            +0.0        1.73        perf-profile.self.cycles-pp.check_heap_object
      1.52            +0.2        1.71        perf-profile.self.cycles-pp.release_sock



***************************************************************************************************
lkp-icl-2sp4: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp4/symlink/stress-ng/60s

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   6273266           +43.9%    9026187 ±  9%  cpuidle..usage
      3.06           +17.2%       3.59 ±  5%  iostat.cpu.system
      1616 ±  6%     +10.0%       1778 ±  5%  perf-c2c.DRAM.remote
    760173 ±  5%     +21.8%     925781 ±  6%  numa-numastat.node0.local_node
    805692 ±  7%     +21.9%     982292 ±  7%  numa-numastat.node0.numa_hit
    736314 ±  5%     +24.7%     918074 ± 12%  numa-numastat.node1.local_node
    823222 ±  6%     +20.7%     993970 ±  7%  numa-numastat.node1.numa_hit
      3751 ± 13%    +275.6%      14089 ± 22%  sched_debug.cfs_rq:/.avg_vruntime.min
      3751 ± 13%    +275.6%      14089 ± 22%  sched_debug.cfs_rq:/.min_vruntime.min
     26533           +37.6%      36513 ±  6%  sched_debug.cpu.nr_switches.avg
     38279 ±  7%     +21.0%      46312 ±  3%  sched_debug.cpu.nr_switches.max
     12527 ±  2%     +25.7%      15743 ±  4%  vmstat.io.bo
      0.12 ± 11%     +23.0%       0.15 ±  9%  vmstat.procs.b
      4.45 ± 17%     +30.0%       5.79 ± 18%  vmstat.procs.r
     97945           +32.3%     129587 ±  9%  vmstat.system.cs
     39102           +28.8%      50359 ±  4%  vmstat.system.in
      0.08 ±  3%      +0.0        0.11 ±  6%  mpstat.cpu.all.iowait%
      0.19            +0.0        0.22 ±  3%  mpstat.cpu.all.irq%
      0.10            +0.0        0.12        mpstat.cpu.all.soft%
      2.82            +0.5        3.30 ±  5%  mpstat.cpu.all.sys%
     82.17           -70.4%      24.33 ±  3%  mpstat.max_utilization.seconds
     13.41 ± 12%     +75.2%      23.50 ±  5%  mpstat.max_utilization_pct
      0.10 ±  4%     -23.5%       0.08 ±  4%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.15 ± 23%     +74.7%       0.26 ± 33%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.btrfs_do_readpage
      9.42 ±115%    +171.7%      25.59 ± 33%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      9.42 ±115%    +171.7%      25.59 ± 33%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.01 ±114%    +404.8%       0.07 ± 38%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__flush_work.__lru_add_drain_all
      0.03 ±120%    +567.5%       0.18 ± 46%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__flush_work.__lru_add_drain_all
     56.36           +30.8%      73.69 ±  6%  stress-ng.symlink.links_created/removed_per_sec
      1.58            -6.5%       1.47 ±  2%  stress-ng.symlink.ops_per_sec
     81.54            +7.0%      87.22 ±  2%  stress-ng.time.elapsed_time
     81.54            +7.0%      87.22 ±  2%  stress-ng.time.elapsed_time.max
   1567765 ±  2%     +37.0%    2148245 ±  6%  stress-ng.time.file_system_outputs
    368.33           +15.6%     425.67 ±  5%  stress-ng.time.percent_of_cpu_this_job_got
    289.05           +25.2%     361.82 ±  7%  stress-ng.time.system_time
   3905397           +41.0%    5506886 ± 10%  stress-ng.time.voluntary_context_switches
   5566508           +11.8%    6224902 ±  2%  meminfo.Cached
    109602           +34.3%     147151 ±  8%  meminfo.Dirty
   1591188           +40.7%    2239517 ±  7%  meminfo.Inactive
   1591188           +40.7%    2239517 ±  7%  meminfo.Inactive(file)
    517939           +32.9%     688283 ±  6%  meminfo.KReclaimable
   8342781           +10.9%    9253649 ±  2%  meminfo.Memused
    517939           +32.9%     688283 ±  6%  meminfo.SReclaimable
    448532           +13.1%     507124 ±  2%  meminfo.SUnreclaim
    966472           +23.7%    1195407 ±  4%  meminfo.Slab
   8798596           +12.7%    9912816 ±  3%  meminfo.max_used_kB
     57293 ±  3%     +31.7%      75459 ± 10%  numa-meminfo.node0.Dirty
    814916 ±  3%     +38.6%    1129473 ±  8%  numa-meminfo.node0.Inactive
    814916 ±  3%     +38.6%    1129473 ±  8%  numa-meminfo.node0.Inactive(file)
    267531 ±  7%     +29.3%     345920 ± 10%  numa-meminfo.node0.KReclaimable
    267531 ±  7%     +29.3%     345920 ± 10%  numa-meminfo.node0.SReclaimable
    224939 ±  6%     +19.2%     268144 ±  6%  numa-meminfo.node0.SUnreclaim
    492471 ±  5%     +24.7%     614065 ±  7%  numa-meminfo.node0.Slab
     52444           +36.9%      71791 ±  6%  numa-meminfo.node1.Dirty
    777401 ±  2%     +43.0%    1111573 ±  6%  numa-meminfo.node1.Inactive
    777401 ±  2%     +43.0%    1111573 ±  6%  numa-meminfo.node1.Inactive(file)
    250935 ±  9%     +36.7%     342984 ± 12%  numa-meminfo.node1.KReclaimable
    250935 ±  9%     +36.7%     342984 ± 12%  numa-meminfo.node1.SReclaimable
    230941           +36.0%     314114 ±  6%  proc-vmstat.nr_dirtied
     27428           +34.2%      36797 ±  8%  proc-vmstat.nr_dirty
   1392074           +11.8%    1556694 ±  2%  proc-vmstat.nr_file_pages
    398037           +40.7%     560166 ±  7%  proc-vmstat.nr_inactive_file
    129600           +32.9%     172185 ±  6%  proc-vmstat.nr_slab_reclaimable
    112157           +13.1%     126820 ±  2%  proc-vmstat.nr_slab_unreclaimable
    133362 ±  2%     +33.9%     178517 ±  5%  proc-vmstat.nr_written
    398037           +40.7%     560166 ±  7%  proc-vmstat.nr_zone_inactive_file
     27444           +34.2%      36817 ±  8%  proc-vmstat.nr_zone_write_pending
   1630857           +21.3%    1978219 ±  5%  proc-vmstat.numa_hit
   1498429           +23.2%    1845812 ±  5%  proc-vmstat.numa_local
   1884709           +21.6%    2292684 ±  5%  proc-vmstat.pgalloc_normal
    574061            +3.1%     591751        proc-vmstat.pgfault
   1519376 ±  2%     +24.5%    1891950 ±  7%  proc-vmstat.pgfree
   1066920 ±  2%     +33.9%    1428162 ±  5%  proc-vmstat.pgpgout
    128839 ±  3%     +28.5%     165576 ±  5%  numa-vmstat.node0.nr_dirtied
     14308 ±  3%     +31.9%      18868 ± 10%  numa-vmstat.node0.nr_dirty
    203609 ±  3%     +38.7%     282438 ±  8%  numa-vmstat.node0.nr_inactive_file
     66797 ±  7%     +29.5%      86526 ± 10%  numa-vmstat.node0.nr_slab_reclaimable
     56203 ±  6%     +19.3%      67037 ±  6%  numa-vmstat.node0.nr_slab_unreclaimable
     69192 ±  3%     +33.0%      92052 ±  7%  numa-vmstat.node0.nr_written
    203609 ±  3%     +38.7%     282438 ±  8%  numa-vmstat.node0.nr_zone_inactive_file
     14316 ±  3%     +31.9%      18878 ± 10%  numa-vmstat.node0.nr_zone_write_pending
    805650 ±  7%     +21.9%     982004 ±  7%  numa-vmstat.node0.numa_hit
    760131 ±  5%     +21.8%     925493 ±  6%  numa-vmstat.node0.numa_local
    102102 ±  7%     +45.5%     148528 ±  9%  numa-vmstat.node1.nr_dirtied
     13101           +37.0%      17949 ±  6%  numa-vmstat.node1.nr_dirty
    194200 ±  2%     +43.1%     277926 ±  6%  numa-vmstat.node1.nr_inactive_file
     62656 ±  9%     +36.9%      85789 ± 12%  numa-vmstat.node1.nr_slab_reclaimable
     64170 ±  6%     +34.7%      86464 ±  6%  numa-vmstat.node1.nr_written
    194200 ±  2%     +43.1%     277926 ±  6%  numa-vmstat.node1.nr_zone_inactive_file
     13109           +37.0%      17957 ±  6%  numa-vmstat.node1.nr_zone_write_pending
    822261 ±  6%     +20.8%     993335 ±  7%  numa-vmstat.node1.numa_hit
    735353 ±  5%     +24.8%     917439 ± 12%  numa-vmstat.node1.numa_local
 1.097e+09           +14.8%  1.259e+09 ±  4%  perf-stat.i.branch-instructions
      5.84            -0.6        5.28 ±  3%  perf-stat.i.branch-miss-rate%
  62635000            -6.5%   58560106        perf-stat.i.branch-misses
      4.40            +1.2        5.61 ± 10%  perf-stat.i.cache-miss-rate%
  11138634           +25.9%   14026416 ±  7%  perf-stat.i.cache-misses
 2.555e+08            -3.9%  2.456e+08        perf-stat.i.cache-references
    100951           +31.1%     132340 ± 10%  perf-stat.i.context-switches
      2.18            +1.6%       2.22        perf-stat.i.cpi
 1.062e+10           +31.5%  1.396e+10 ±  7%  perf-stat.i.cpu-cycles
      5285           +21.7%       6433 ±  4%  perf-stat.i.cpu-migrations
 5.643e+09           +15.3%  6.506e+09 ±  4%  perf-stat.i.instructions
      0.52            -1.5%       0.51        perf-stat.i.ipc
      0.17 ±  6%    +153.4%       0.42 ± 28%  perf-stat.i.metric.K/sec
      1.65 ± 44%     +30.7%       2.15 ±  2%  perf-stat.overall.MPKI
      3.64 ± 44%      +2.1        5.70 ±  8%  perf-stat.overall.cache-miss-rate%
      1.57 ± 44%     +36.4%       2.14 ±  3%  perf-stat.overall.cpi
    794.30 ± 44%     +25.2%     994.13        perf-stat.overall.cycles-between-cache-misses
 9.028e+08 ± 44%     +37.6%  1.242e+09 ±  4%  perf-stat.ps.branch-instructions
   9176993 ± 44%     +50.8%   13838332 ±  6%  perf-stat.ps.cache-misses
     83186 ± 44%     +56.8%     130453 ± 10%  perf-stat.ps.context-switches
 8.747e+09 ± 44%     +57.4%  1.376e+10 ±  7%  perf-stat.ps.cpu-cycles
      4366 ± 44%     +45.3%       6342 ±  4%  perf-stat.ps.cpu-migrations
 4.645e+09 ± 44%     +38.3%  6.423e+09 ±  4%  perf-stat.ps.instructions
 3.843e+11 ± 44%     +48.1%   5.69e+11 ±  6%  perf-stat.total.instructions
      8.97 ±  3%      -1.3        7.67 ± 11%  perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      7.54 ±  4%      -1.3        6.24 ± 14%  perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested.btrfs_read_lock_root_node
      8.90 ±  4%      -1.3        7.61 ± 11%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read
      4.26 ±  4%      -0.5        3.73 ±  7%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.94 ±  4%      -0.5        3.45 ±  7%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      3.70 ±  4%      -0.5        3.24 ±  7%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      4.02 ±  6%      -0.4        3.60 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item.btrfs_add_link
      3.28 ±  4%      -0.4        2.86 ±  7%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      3.09 ±  4%      -0.4        2.70 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      2.20 ±  5%      -0.4        1.84 ± 10%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      2.93 ±  4%      -0.4        2.57 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.64 ±  5%      -0.3        1.37 ± 11%  perf-profile.calltrace.cycles-pp.tick_nohz_restart_sched_tick.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary
      1.52 ±  4%      -0.2        1.30 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending
      0.64 ±  6%      -0.2        0.47 ± 45%  perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.tick_nohz_restart_sched_tick.tick_nohz_idle_exit.do_idle.cpu_startup_entry
      1.05 ±  4%      -0.1        0.94 ±  9%  perf-profile.calltrace.cycles-pp.need_update.quiet_vmstat.tick_nohz_stop_tick.tick_nohz_idle_stop_tick.cpuidle_idle_call
      0.89 ±  2%      -0.1        0.79 ±  9%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.73 ±  4%      -0.1        0.64 ±  9%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate
      1.41 ±  9%      +0.3        1.73 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_lookup_inode.__btrfs_update_delayed_inode.btrfs_async_run_delayed_root.btrfs_work_helper.process_one_work
      1.40 ±  9%      +0.3        1.72 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_inode.__btrfs_update_delayed_inode.btrfs_async_run_delayed_root.btrfs_work_helper
      2.42 ± 17%      +0.8        3.22 ± 11%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.46 ± 17%      +0.8        3.26 ± 11%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.06 ± 22%      +0.8        2.90 ± 14%  perf-profile.calltrace.cycles-pp.btrfs_async_run_delayed_root.btrfs_work_helper.process_one_work.worker_thread.kthread
     19.41 ±  2%      +0.9       20.29 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.btrfs_create_new_inode.btrfs_symlink.vfs_symlink.do_symlinkat
     19.10 ±  2%      +0.9       19.99 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.btrfs_create_new_inode.btrfs_symlink.vfs_symlink
      2.97 ± 14%      +1.1        4.08 ±  8%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      2.97 ± 14%      +1.1        4.08 ±  8%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      2.97 ± 14%      +1.1        4.08 ±  8%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      4.96 ±  4%      -0.6        4.35 ±  7%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      4.04 ±  4%      -0.5        3.53 ±  7%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      3.79 ±  4%      -0.5        3.31 ±  7%  perf-profile.children.cycles-pp.sched_ttwu_pending
      3.38 ±  4%      -0.4        2.94 ±  7%  perf-profile.children.cycles-pp.ttwu_do_activate
      3.23 ±  4%      -0.4        2.84 ±  7%  perf-profile.children.cycles-pp.enqueue_task
      0.51 ±103%      -0.4        0.12 ± 10%  perf-profile.children.cycles-pp.btrfs_add_inode_to_root
      3.08 ±  4%      -0.4        2.70 ±  7%  perf-profile.children.cycles-pp.enqueue_task_fair
      2.26 ±  5%      -0.4        1.89 ± 10%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      2.60 ±  6%      -0.3        2.28 ±  9%  perf-profile.children.cycles-pp.try_to_block_task
      2.57 ±  5%      -0.3        2.24 ±  9%  perf-profile.children.cycles-pp.dequeue_task_fair
      2.49 ±  5%      -0.3        2.18 ±  9%  perf-profile.children.cycles-pp.dequeue_entities
      1.68 ±  5%      -0.3        1.41 ± 11%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      1.95 ±  5%      -0.3        1.68 ± 10%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      1.62 ±  4%      -0.2        1.40 ±  7%  perf-profile.children.cycles-pp.enqueue_entity
      1.38 ±  4%      -0.2        1.19 ± 10%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      1.39 ±  3%      -0.1        1.25 ±  6%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      1.11 ±  4%      -0.1        0.99 ±  9%  perf-profile.children.cycles-pp.need_update
      0.86 ±  5%      -0.1        0.75 ±  8%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.62 ±  8%      -0.1        0.53 ±  6%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.46 ±  6%      -0.1        0.38 ±  9%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.50 ±  6%      -0.1        0.42 ±  9%  perf-profile.children.cycles-pp.clockevents_program_event
      0.52 ±  5%      -0.1        0.46 ± 11%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.48 ±  6%      -0.1        0.42 ± 11%  perf-profile.children.cycles-pp.timerqueue_add
      0.23 ± 10%      -0.1        0.17 ± 12%  perf-profile.children.cycles-pp.__write_extent_buffer
      0.46 ±  4%      -0.1        0.41 ± 11%  perf-profile.children.cycles-pp.memchr_inv
      0.35 ±  5%      -0.1        0.30 ±  9%  perf-profile.children.cycles-pp.hrtimer_cancel
      0.32 ±  5%      -0.0        0.27 ±  6%  perf-profile.children.cycles-pp.update_rq_clock
      0.57            -0.0        0.53 ±  7%  perf-profile.children.cycles-pp.cpu_util
      0.17 ± 10%      -0.0        0.12 ± 15%  perf-profile.children.cycles-pp.memcpy_extent_buffer
      0.31 ±  6%      -0.0        0.27 ±  5%  perf-profile.children.cycles-pp.nohz_balancer_kick
      0.23 ± 12%      -0.0        0.19 ± 11%  perf-profile.children.cycles-pp.tmigr_inactive_up
      0.16 ±  7%      -0.0        0.13 ± 15%  perf-profile.children.cycles-pp.place_entity
      0.25 ±  3%      -0.0        0.22 ± 10%  perf-profile.children.cycles-pp.sched_clock
      0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.15 ±  4%      -0.0        0.12 ± 12%  perf-profile.children.cycles-pp.set_next_task_idle
      0.18 ±  5%      -0.0        0.15 ±  7%  perf-profile.children.cycles-pp.task_work_run
      0.11 ± 12%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.11 ±  6%      -0.0        0.09 ± 12%  perf-profile.children.cycles-pp.exc_page_fault
      0.11 ±  8%      -0.0        0.09 ± 12%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.16 ±  3%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.tmigr_quick_check
      0.13 ±  8%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.security_inode_init_security
      0.04 ± 45%      +0.1        0.10 ± 20%  perf-profile.children.cycles-pp.crc_pcl
      0.04 ± 45%      +0.1        0.10 ± 20%  perf-profile.children.cycles-pp.csum_tree_block
      0.06 ±  6%      +0.1        0.14 ± 25%  perf-profile.children.cycles-pp.check_dir_item
      0.03 ±143%      +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.asm_common_interrupt
      0.03 ±143%      +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.common_interrupt
      0.32 ±  9%      +0.1        0.40 ± 15%  perf-profile.children.cycles-pp.btrfs_get_32
      0.12 ±  7%      +0.1        0.26 ± 21%  perf-profile.children.cycles-pp.check_leaf_item
      0.24 ±  6%      +0.2        0.44 ± 21%  perf-profile.children.cycles-pp.__btrfs_check_leaf
      0.24 ±  6%      +0.2        0.44 ± 21%  perf-profile.children.cycles-pp.btrfs_check_leaf
      1.02 ±  4%      +0.2        1.25 ± 15%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      0.29 ±  5%      +0.2        0.54 ± 21%  perf-profile.children.cycles-pp.btree_csum_one_bio
      0.32 ±  2%      +0.3        0.60 ± 21%  perf-profile.children.cycles-pp.btrfs_submit_bbio
      0.32 ±  2%      +0.3        0.60 ± 21%  perf-profile.children.cycles-pp.btrfs_submit_chunk
      1.41 ±  9%      +0.3        1.73 ± 10%  perf-profile.children.cycles-pp.btrfs_lookup_inode
      0.37 ±  3%      +0.3        0.69 ± 20%  perf-profile.children.cycles-pp.submit_eb_page
      0.38 ±  3%      +0.3        0.72 ± 21%  perf-profile.children.cycles-pp.btrfs_commit_transaction
      0.38 ±  3%      +0.3        0.72 ± 21%  perf-profile.children.cycles-pp.transaction_kthread
      0.38 ±  2%      +0.3        0.71 ± 21%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      0.38 ±  2%      +0.3        0.71 ± 21%  perf-profile.children.cycles-pp.btree_write_cache_pages
      0.38 ±  2%      +0.3        0.71 ± 21%  perf-profile.children.cycles-pp.btrfs_write_and_wait_transaction
      0.38 ±  2%      +0.3        0.71 ± 21%  perf-profile.children.cycles-pp.btrfs_write_marked_extents
      0.38 ±  2%      +0.3        0.71 ± 21%  perf-profile.children.cycles-pp.do_writepages
      0.38 ±  2%      +0.3        0.71 ± 21%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
      0.50 ± 32%      +0.5        0.98 ± 29%  perf-profile.children.cycles-pp.__btrfs_release_delayed_node
      2.42 ± 17%      +0.8        3.22 ± 11%  perf-profile.children.cycles-pp.process_one_work
      2.46 ± 17%      +0.8        3.26 ± 11%  perf-profile.children.cycles-pp.worker_thread
      2.97 ± 14%      +1.1        4.08 ±  8%  perf-profile.children.cycles-pp.kthread
      2.97 ± 14%      +1.1        4.08 ±  8%  perf-profile.children.cycles-pp.ret_from_fork_asm
      2.97 ± 14%      +1.1        4.08 ±  8%  perf-profile.children.cycles-pp.ret_from_fork
      1.35 ±  3%      -0.1        1.21 ±  6%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.44 ±  6%      -0.1        0.37 ±  9%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.32 ±  6%      -0.1        0.26 ±  4%  perf-profile.self.cycles-pp.enqueue_entity
      0.18 ±  5%      -0.0        0.15 ± 11%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.19 ±  6%      -0.0        0.16 ±  7%  perf-profile.self.cycles-pp.update_rq_clock
      0.19 ±  7%      -0.0        0.16 ±  9%  perf-profile.self.cycles-pp.finish_task_switch
      0.11 ± 12%      -0.0        0.08 ± 13%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.10 ±  5%      -0.0        0.07 ± 16%  perf-profile.self.cycles-pp.start_dl_timer
      0.10 ±  8%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.nohz_balancer_kick
      0.10 ±  4%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.tick_nohz_idle_got_tick
      0.04 ± 45%      +0.1        0.10 ± 20%  perf-profile.self.cycles-pp.crc_pcl
      0.30 ±  9%      +0.1        0.37 ± 12%  perf-profile.self.cycles-pp.btrfs_get_32



***************************************************************************************************
lkp-icl-2sp4: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/ext4/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp4/file-ioctl/stress-ng/60s

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    546948           +15.9%     633790        meminfo.Shmem
 7.157e+09           -11.9%  6.305e+09 ±  2%  cpuidle..time
   9799994 ±  2%     +78.9%   17529038 ±  2%  cpuidle..usage
     81.02           -12.4%      70.99 ±  3%  iostat.cpu.iowait
      7.42 ±  5%    +148.4%      18.44 ±  8%  iostat.cpu.system
     83.54           -10.4       73.18 ±  3%  mpstat.cpu.all.iowait%
      0.16            +0.0        0.21 ±  5%  mpstat.cpu.all.irq%
      0.10            -0.0        0.06 ±  7%  mpstat.cpu.all.soft%
      7.37 ±  5%     +11.3       18.72 ±  8%  mpstat.cpu.all.sys%
      0.60            +0.2        0.76 ±  2%  mpstat.cpu.all.usr%
    309.50 ±  9%    +160.7%     806.83 ±  5%  perf-c2c.DRAM.local
      7890           +98.8%      15684 ±  4%  perf-c2c.DRAM.remote
      7304 ±  2%    +144.9%      17884 ±  5%  perf-c2c.HITM.local
      5429 ±  3%    +101.7%      10951 ±  2%  perf-c2c.HITM.remote
     12733          +126.5%      28836 ±  3%  perf-c2c.HITM.total
     81.01           -12.4%      70.99 ±  3%  vmstat.cpu.wa
    109.93           -13.7%      94.84 ±  2%  vmstat.procs.b
     10.89 ±  4%    +139.9%      26.11 ±  4%  vmstat.procs.r
    249709           +47.8%     369109 ±  2%  vmstat.system.cs
     70448          +144.1%     171942 ±  3%  vmstat.system.in
  11641204           +81.0%   21073025 ±  3%  stress-ng.file-ioctl.ops
    194005           +81.0%     351204 ±  3%  stress-ng.file-ioctl.ops_per_sec
      1716 ±  8%     +91.7%       3290 ± 10%  stress-ng.time.involuntary_context_switches
      1035 ±  4%    +153.3%       2622 ±  9%  stress-ng.time.percent_of_cpu_this_job_got
    591.44 ±  4%    +159.6%       1535 ±  9%  stress-ng.time.system_time
     31.70           +35.4%      42.92 ±  2%  stress-ng.time.user_time
   7851784 ±  2%     +48.6%   11667499 ±  2%  stress-ng.time.voluntary_context_switches
    306427            +7.2%     328428        proc-vmstat.nr_active_anon
   1045114            +2.1%    1066901        proc-vmstat.nr_file_pages
    136748           +16.0%     158569        proc-vmstat.nr_shmem
    306427            +7.2%     328428        proc-vmstat.nr_zone_active_anon
    782797            +7.8%     843745        proc-vmstat.numa_hit
    650421            +9.4%     711339        proc-vmstat.numa_local
    830601            +7.3%     891473        proc-vmstat.pgalloc_normal
    588428            +5.5%     620722        proc-vmstat.pgfault
 4.007e+09           +70.6%  6.837e+09 ±  3%  perf-stat.i.branch-instructions
      2.76            -2.1        0.67 ± 13%  perf-stat.i.branch-miss-rate%
 1.106e+08           -62.3%   41669178 ± 10%  perf-stat.i.branch-misses
      4.93 ± 10%     +16.2       21.15 ±  9%  perf-stat.i.cache-miss-rate%
  25959042 ±  8%     +70.2%   44185905 ± 25%  perf-stat.i.cache-misses
 5.417e+08           -56.6%  2.349e+08 ± 15%  perf-stat.i.cache-references
    260344 ±  2%     +48.2%     385789 ±  2%  perf-stat.i.context-switches
      1.86 ±  2%     +57.2%       2.93 ±  6%  perf-stat.i.cpi
 3.413e+10 ±  4%    +170.3%  9.227e+10 ±  8%  perf-stat.i.cpu-cycles
      1972 ±  3%     +58.1%       3117 ±  5%  perf-stat.i.cpu-migrations
      1310 ±  5%     +68.7%       2210 ± 22%  perf-stat.i.cycles-between-cache-misses
 1.823e+10           +69.9%  3.098e+10 ±  3%  perf-stat.i.instructions
      0.55           -33.4%       0.36 ±  4%  perf-stat.i.ipc
      2.03 ±  2%     +48.5%       3.01 ±  2%  perf-stat.i.metric.K/sec
      6902            +7.0%       7386 ±  2%  perf-stat.i.minor-faults
      6902            +7.0%       7386 ±  2%  perf-stat.i.page-faults
     18871 ±  3%    +788.1%     167609 ± 17%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.11 ± 13%     +57.9%       0.18 ±  6%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.32 ±  6%     +18.1%       0.37 ±  2%  sched_debug.cfs_rq:/.h_nr_running.stddev
     18871 ±  3%    +788.1%     167609 ± 17%  sched_debug.cfs_rq:/.min_vruntime.min
      0.11 ± 12%     +56.8%       0.18 ±  5%  sched_debug.cfs_rq:/.nr_running.avg
      0.33 ±  4%     +18.1%       0.39        sched_debug.cfs_rq:/.nr_running.stddev
    154.91 ±  4%     +52.1%     235.54 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
    173.49 ±  3%     +10.6%     191.88 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
     17.14 ± 17%    +125.0%      38.57 ± 10%  sched_debug.cfs_rq:/.util_est.avg
     76.00 ± 14%     +40.9%     107.08 ±  5%  sched_debug.cfs_rq:/.util_est.stddev
    847909           -21.3%     667195 ±  2%  sched_debug.cpu.avg_idle.avg
    924.19 ±  2%     -17.7%     760.86        sched_debug.cpu.clock_task.stddev
    369.30 ± 14%     +83.5%     677.51 ±  8%  sched_debug.cpu.curr->pid.avg
      1124 ±  6%     +26.7%       1425 ±  2%  sched_debug.cpu.curr->pid.stddev
      0.11 ± 18%     +58.3%       0.17 ±  7%  sched_debug.cpu.nr_running.avg
     61881           +47.1%      90998 ±  2%  sched_debug.cpu.nr_switches.avg
     75109 ±  9%     +35.0%     101362 ±  3%  sched_debug.cpu.nr_switches.max
     55681 ±  3%     +45.9%      81250 ±  2%  sched_debug.cpu.nr_switches.min
      0.46 ±  2%     -13.9%       0.40 ±  3%  sched_debug.cpu.nr_uninterruptible.avg
      0.13 ±  2%     -26.8%       0.09 ±  3%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.10 ±  9%     -37.4%       0.06 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.ext4_map_blocks.ext4_alloc_file_blocks.isra
      0.06 ± 26%     -50.2%       0.03 ± 27%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.13 ±  2%     -15.0%       0.11 ± 10%  perf-sched.sch_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      0.13           -20.1%       0.10        perf-sched.sch_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
      0.13 ±  7%     -57.8%       0.06 ± 13%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.12 ±  5%     -49.1%       0.06 ± 26%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.08 ± 16%     -41.5%       0.05 ± 28%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01           -33.3%       0.00        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.12 ± 19%     -37.8%       0.08 ± 10%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.08 ± 21%     -32.4%       0.05 ± 17%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.22 ± 15%     -44.7%       0.12 ± 64%  perf-sched.sch_delay.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
      0.25 ± 24%     -21.9%       0.19 ± 13%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.ext4_map_blocks.ext4_alloc_file_blocks.isra
      0.06 ±142%   +1147.4%       0.69 ±138%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
     18.58 ±  8%     -47.7%       9.72 ±  7%  perf-sched.sch_delay.max.ms.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
      0.13 ±  2%     -21.4%       0.10        perf-sched.total_sch_delay.average.ms
    293.05 ±209%     -96.7%       9.72 ±  7%  perf-sched.total_sch_delay.max.ms
      1.10           -10.1%       0.99        perf-sched.wait_and_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
    384.95 ±  4%     -27.9%     277.39 ±  9%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.03 ±  4%     -73.8%       1.05 ±142%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    204.76           -28.7%     145.90 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    188.00 ±  4%     +38.4%     260.17 ±  8%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      2949           +51.9%       4478 ±  2%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     19.20 ±  9%     -34.7%      12.54 ± 26%  perf-sched.wait_and_delay.max.ms.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
      0.95 ±  2%     -11.1%       0.84 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
      0.92 ±  5%     -10.2%       0.83 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_alloc_file_blocks.isra.0
      0.94 ±  2%     -12.4%       0.82 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.ext4_map_blocks.ext4_alloc_file_blocks.isra
    384.82 ±  4%     -27.9%     277.33 ±  9%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.96 ±  4%     -32.0%       2.70 ± 13%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.83 ±  2%     -16.7%       0.69 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    204.75           -28.7%     145.90 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 48%     -68.5%       0.01 ± 68%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      1.12 ±  3%     -13.8%       0.96 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
      1.10 ±  5%     -10.9%       0.98 ±  2%  perf-sched.wait_time.max.ms.__cond_resched.bdev_getblk.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      1.03 ±  5%     -18.0%       0.85 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl.do_syscall_64
     21.22           -12.7        8.54 ± 21%  perf-profile.calltrace.cycles-pp.common_startup_64
     28.62           -12.3       16.30 ± 13%  perf-profile.calltrace.cycles-pp.__ext4_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
     28.43           -12.2       16.20 ± 13%  perf-profile.calltrace.cycles-pp.ext4_ioctl_getlabel.__ext4_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.34           -11.9        8.43 ± 21%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     20.33           -11.9        8.42 ± 21%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     20.30           -11.9        8.42 ± 21%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     20.12           -10.0       10.12 ± 17%  perf-profile.calltrace.cycles-pp.out_of_line_wait_on_bit_lock.ext4_ioctl_getlabel.__ext4_ioctl.__x64_sys_ioctl.do_syscall_64
     20.10           -10.0       10.12 ± 17%  perf-profile.calltrace.cycles-pp.__wait_on_bit_lock.out_of_line_wait_on_bit_lock.ext4_ioctl_getlabel.__ext4_ioctl.__x64_sys_ioctl
     13.93            -7.4        6.57 ± 20%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     13.10            -6.3        6.83 ± 18%  perf-profile.calltrace.cycles-pp.prepare_to_wait_exclusive.__wait_on_bit_lock.out_of_line_wait_on_bit_lock.ext4_ioctl_getlabel.__ext4_ioctl
     12.60            -6.1        6.49 ± 19%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_exclusive.__wait_on_bit_lock.out_of_line_wait_on_bit_lock.ext4_ioctl_getlabel
     12.34            -6.1        6.28 ± 19%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_exclusive.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
     10.62            -4.9        5.75 ± 18%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     10.46            -4.8        5.66 ± 18%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      8.08            -4.3        3.80 ± 17%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.36            -2.4        0.92 ± 26%  perf-profile.calltrace.cycles-pp.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock.ext4_ioctl_getlabel.__ext4_ioctl
      3.34            -2.4        0.91 ± 26%  perf-profile.calltrace.cycles-pp.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock.ext4_ioctl_getlabel
      3.29            -2.4        0.89 ± 26%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
      3.24            -2.4        0.87 ± 26%  perf-profile.calltrace.cycles-pp.__schedule.schedule.io_schedule.bit_wait_io.__wait_on_bit_lock
      7.55            -2.0        5.52 ±  7%  perf-profile.calltrace.cycles-pp.wake_up_bit.ext4_ioctl_getlabel.__ext4_ioctl.__x64_sys_ioctl.do_syscall_64
      5.29            -1.9        3.36 ±  5%  perf-profile.calltrace.cycles-pp.ext4_map_blocks.ext4_alloc_file_blocks.ext4_fallocate.vfs_fallocate.ioctl_preallocate
      2.88            -1.9        0.99 ± 21%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.74            -1.8        1.96 ± 14%  perf-profile.calltrace.cycles-pp.ext4_map_create_blocks.ext4_map_blocks.ext4_alloc_file_blocks.ext4_fallocate.vfs_fallocate
      2.68            -1.8        0.92 ± 21%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      2.09            -1.7        0.36 ±105%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      2.51            -1.7        0.80 ± 24%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      2.22            -1.7        0.55 ± 53%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      1.98            -1.6        0.34 ±104%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.74            -1.4        0.32 ±103%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.68            -1.4        0.32 ±103%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      3.49            -1.4        2.13 ±  8%  perf-profile.calltrace.cycles-pp.__wake_up_common.wake_up_bit.ext4_ioctl_getlabel.__ext4_ioctl.__x64_sys_ioctl
      3.35            -1.2        2.16 ±  9%  perf-profile.calltrace.cycles-pp.finish_wait.__wait_on_bit_lock.out_of_line_wait_on_bit_lock.ext4_ioctl_getlabel.__ext4_ioctl
      3.26            -1.2        2.09 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.__wait_on_bit_lock.out_of_line_wait_on_bit_lock.ext4_ioctl_getlabel
      3.22            -1.2        2.06 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
      4.11 ±  3%      -1.1        2.97 ±  6%  perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_alloc_file_blocks.ext4_fallocate.vfs_fallocate.ioctl_preallocate
      1.42            -1.1        0.31 ±102%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      2.69 ±  2%      -1.0        1.71 ± 17%  perf-profile.calltrace.cycles-pp.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_alloc_file_blocks.ext4_fallocate.vfs_fallocate
      1.54 ±  4%      -0.9        0.60 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.ioctl
      1.70 ± 15%      -0.9        0.78 ± 13%  perf-profile.calltrace.cycles-pp.ext4_es_insert_extent.ext4_map_create_blocks.ext4_map_blocks.ext4_alloc_file_blocks.ext4_fallocate
      2.43 ±  2%      -0.9        1.53 ± 17%  perf-profile.calltrace.cycles-pp.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_alloc_file_blocks.ext4_fallocate
      1.84 ±  4%      -0.8        1.03 ± 13%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.ioctl
      1.33 ± 11%      -0.6        0.70 ± 12%  perf-profile.calltrace.cycles-pp.ext4_ext_map_blocks.ext4_map_create_blocks.ext4_map_blocks.ext4_alloc_file_blocks.ext4_fallocate
      3.73            -0.6        3.12 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.wake_up_bit.ext4_ioctl_getlabel.__ext4_ioctl
      3.83            -0.6        3.24 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.wake_up_bit.ext4_ioctl_getlabel.__ext4_ioctl.__x64_sys_ioctl
      1.40            -0.6        0.82 ±  9%  perf-profile.calltrace.cycles-pp.wake_bit_function.__wake_up_common.wake_up_bit.ext4_ioctl_getlabel.__ext4_ioctl
      1.40 ± 14%      -0.5        0.91 ±  9%  perf-profile.calltrace.cycles-pp.ext4_fill_raw_inode.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_alloc_file_blocks
      0.83 ±  4%      -0.5        0.36 ± 71%  perf-profile.calltrace.cycles-pp.ext4_find_extent.ext4_ext_map_blocks.ext4_map_create_blocks.ext4_map_blocks.ext4_alloc_file_blocks
      0.72 ±  3%      -0.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.ext4_inode_csum.ext4_inode_csum_set.ext4_fill_raw_inode.ext4_do_update_inode.ext4_mark_iloc_dirty
      0.82 ±  3%      -0.4        0.39 ± 70%  perf-profile.calltrace.cycles-pp.ext4_inode_csum_set.ext4_fill_raw_inode.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty
      1.10 ±  2%      -0.4        0.72 ± 11%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.93 ±  4%      -0.2        0.71 ±  7%  perf-profile.calltrace.cycles-pp.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_alloc_file_blocks.ext4_fallocate.vfs_fallocate
      7.23            +0.5        7.72 ±  3%  perf-profile.calltrace.cycles-pp.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.62 ±  3%      +1.3        1.90 ± 19%  perf-profile.calltrace.cycles-pp.generic_update_time.file_modified.ext4_fallocate.vfs_fallocate.ioctl_preallocate
      0.58 ±  4%      +1.3        1.88 ± 19%  perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_update_time.file_modified.ext4_fallocate.vfs_fallocate
      0.86 ±  3%      +1.3        2.19 ± 15%  perf-profile.calltrace.cycles-pp.file_modified.ext4_fallocate.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl
      0.00            +1.5        1.53 ± 18%  perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_update_time.file_modified.ext4_fallocate
      3.91            +2.4        6.27 ±  7%  perf-profile.calltrace.cycles-pp.vfs_fileattr_set.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.68            +2.5        6.14 ±  7%  perf-profile.calltrace.cycles-pp.ext4_fileattr_set.vfs_fileattr_set.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
      3.65            +2.5        6.13 ±  7%  perf-profile.calltrace.cycles-pp.ext4_ioctl_setflags.ext4_fileattr_set.vfs_fileattr_set.do_vfs_ioctl.__x64_sys_ioctl
      3.26            +3.1        6.41 ±  7%  perf-profile.calltrace.cycles-pp.ext4_zero_range.ext4_fallocate.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl
      2.78            +3.4        6.13 ±  7%  perf-profile.calltrace.cycles-pp.ext4_alloc_file_blocks.ext4_zero_range.ext4_fallocate.vfs_fallocate.ioctl_preallocate
      2.62            +3.5        6.16 ± 14%  perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.ext4_alloc_file_blocks.ext4_fallocate.vfs_fallocate
      2.78            +3.6        6.35 ± 14%  perf-profile.calltrace.cycles-pp.__ext4_journal_stop.ext4_alloc_file_blocks.ext4_fallocate.vfs_fallocate.ioctl_preallocate
      4.63 ± 70%      +3.8        8.41 ±141%  perf-profile.calltrace.cycles-pp.cleanup_module.cleanup_module.ext4_alloc_file_blocks.ext4_fallocate.vfs_fallocate
     63.44 ±  2%      +6.3       69.74 ±  6%  perf-profile.calltrace.cycles-pp.ioctl
     12.89 ± 11%      +7.3       20.14 ± 24%  perf-profile.calltrace.cycles-pp.stress_run
     12.09 ± 11%      +7.6       19.72 ± 25%  perf-profile.calltrace.cycles-pp.ioctl.stress_run
     10.90 ± 11%      +8.1       19.03 ± 25%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl.stress_run
     10.82 ± 11%      +8.2       18.98 ± 25%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.stress_run
     10.33 ± 11%      +8.3       18.66 ± 25%  perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.stress_run
     58.86            +8.7       67.52 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl
     58.61            +8.8       67.36 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
     56.77            +9.4       66.18 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
     23.48           +26.4       49.90 ±  7%  perf-profile.calltrace.cycles-pp.ext4_alloc_file_blocks.ext4_fallocate.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl
     30.04           +30.1       60.18 ±  7%  perf-profile.calltrace.cycles-pp.ioctl_preallocate.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
     29.54           +30.4       59.89 ±  7%  perf-profile.calltrace.cycles-pp.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     29.04           +30.6       59.60 ±  7%  perf-profile.calltrace.cycles-pp.ext4_fallocate.vfs_fallocate.ioctl_preallocate.__x64_sys_ioctl.do_syscall_64
     21.22           -12.7        8.54 ± 21%  perf-profile.children.cycles-pp.common_startup_64
     21.22           -12.7        8.54 ± 21%  perf-profile.children.cycles-pp.cpu_startup_entry
     21.19           -12.7        8.54 ± 21%  perf-profile.children.cycles-pp.do_idle
     28.66           -12.3       16.31 ± 13%  perf-profile.children.cycles-pp.__ext4_ioctl
     28.44           -12.2       16.21 ± 13%  perf-profile.children.cycles-pp.ext4_ioctl_getlabel
     20.34           -11.9        8.43 ± 21%  perf-profile.children.cycles-pp.start_secondary
     20.12           -10.0       10.12 ± 17%  perf-profile.children.cycles-pp.out_of_line_wait_on_bit_lock
     20.10           -10.0       10.12 ± 17%  perf-profile.children.cycles-pp.__wait_on_bit_lock
     20.29            -8.2       12.11 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     14.20            -7.6        6.65 ± 20%  perf-profile.children.cycles-pp.cpuidle_idle_call
     19.33            -7.5       11.79 ± 13%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     13.11            -6.3        6.84 ± 18%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
     10.84            -5.0        5.81 ± 18%  perf-profile.children.cycles-pp.cpuidle_enter
     10.78            -5.0        5.79 ± 18%  perf-profile.children.cycles-pp.cpuidle_enter_state
      8.21            -4.4        3.83 ± 17%  perf-profile.children.cycles-pp.intel_idle
      5.00            -3.6        1.44 ± 25%  perf-profile.children.cycles-pp.__schedule
      3.48            -2.5        1.03 ± 23%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      3.37            -2.5        0.92 ± 26%  perf-profile.children.cycles-pp.bit_wait_io
      3.34            -2.4        0.91 ± 26%  perf-profile.children.cycles-pp.io_schedule
      3.33            -2.4        0.90 ± 26%  perf-profile.children.cycles-pp.schedule
      5.95            -2.2        3.79 ±  5%  perf-profile.children.cycles-pp.ext4_map_blocks
      7.56            -2.0        5.52 ±  7%  perf-profile.children.cycles-pp.wake_up_bit
      4.10            -1.8        2.30 ±  8%  perf-profile.children.cycles-pp.ext4_map_create_blocks
      2.71            -1.8        0.93 ± 21%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      2.54            -1.7        0.81 ± 23%  perf-profile.children.cycles-pp.sched_ttwu_pending
      2.25            -1.6        0.64 ± 28%  perf-profile.children.cycles-pp.ttwu_do_activate
      2.01            -1.5        0.49 ± 28%  perf-profile.children.cycles-pp.try_to_block_task
      2.12            -1.5        0.60 ± 27%  perf-profile.children.cycles-pp.enqueue_task
      1.90            -1.4        0.46 ± 29%  perf-profile.children.cycles-pp.dequeue_task_fair
      2.02            -1.4        0.59 ± 27%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.84            -1.4        0.45 ± 28%  perf-profile.children.cycles-pp.dequeue_entities
      3.54            -1.4        2.16 ±  8%  perf-profile.children.cycles-pp.__wake_up_common
      3.91 ±  2%      -1.4        2.54 ±  8%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      4.85 ±  2%      -1.3        3.50 ±  6%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      3.56 ±  2%      -1.3        2.30 ±  8%  perf-profile.children.cycles-pp.ext4_do_update_inode
      2.82            -1.2        1.59 ±  9%  perf-profile.children.cycles-pp.clear_bhb_loop
      1.76            -1.2        0.56 ± 23%  perf-profile.children.cycles-pp.schedule_idle
      3.35            -1.2        2.16 ±  9%  perf-profile.children.cycles-pp.finish_wait
      1.29 ±  2%      -1.2        0.10 ± 93%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      1.28 ±  2%      -1.2        0.10 ± 92%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      1.28            -1.1        0.16 ± 51%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      1.43            -1.1        0.35 ± 30%  perf-profile.children.cycles-pp.__pick_next_task
      1.28            -1.0        0.23 ± 38%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      2.12            -1.0        1.16 ±  8%  perf-profile.children.cycles-pp.ext4_es_insert_extent
      2.64 ±  2%      -1.0        1.68 ±  8%  perf-profile.children.cycles-pp.ext4_fill_raw_inode
      1.44            -0.9        0.53 ± 23%  perf-profile.children.cycles-pp.menu_select
      1.20            -0.9        0.30 ± 31%  perf-profile.children.cycles-pp.dequeue_entity
      1.16            -0.9        0.30 ± 28%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.89            -0.8        1.09 ±  8%  perf-profile.children.cycles-pp.ext4_ext_map_blocks
      0.88            -0.8        0.12 ± 53%  perf-profile.children.cycles-pp.rest_init
      0.88            -0.8        0.12 ± 53%  perf-profile.children.cycles-pp.start_kernel
      0.88            -0.8        0.12 ± 53%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.88            -0.8        0.12 ± 53%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.92            -0.8        0.16 ± 40%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      1.06 ±  2%      -0.7        0.32 ± 33%  perf-profile.children.cycles-pp.handle_softirqs
      1.68            -0.7        1.00 ±  8%  perf-profile.children.cycles-pp.ext4_inode_csum_set
      0.95            -0.7        0.28 ± 26%  perf-profile.children.cycles-pp.enqueue_entity
      0.91 ±  2%      -0.7        0.24 ± 29%  perf-profile.children.cycles-pp.update_load_avg
      0.78            -0.7        0.12 ± 53%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.70 ±  2%      -0.6        0.08 ± 46%  perf-profile.children.cycles-pp.do_softirq
      1.53            -0.6        0.91 ±  8%  perf-profile.children.cycles-pp.ext4_inode_csum
      1.42            -0.6        0.84 ±  8%  perf-profile.children.cycles-pp.wake_bit_function
      1.91 ±  4%      -0.6        1.34 ±  6%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      1.56            -0.5        1.02 ±  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.96            -0.5        0.45 ± 13%  perf-profile.children.cycles-pp.try_to_wake_up
      1.27            -0.5        0.78 ±  7%  perf-profile.children.cycles-pp.ext4_find_extent
      0.69            -0.5        0.22 ± 24%  perf-profile.children.cycles-pp.dl_server_start
      1.39            -0.5        0.92 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.60            -0.5        0.13 ± 31%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.58 ±  3%      -0.5        0.13 ± 43%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.66            -0.4        0.21 ± 26%  perf-profile.children.cycles-pp.enqueue_dl_entity
      0.97 ±  3%      -0.4        0.53 ±  9%  perf-profile.children.cycles-pp.__es_remove_extent
      0.54            -0.4        0.11 ± 34%  perf-profile.children.cycles-pp.update_curr
      0.75 ±  2%      -0.4        0.33 ± 20%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.52 ±  2%      -0.4        0.12 ± 30%  perf-profile.children.cycles-pp.memdup_user
      1.25 ±  5%      -0.4        0.86 ±  8%  perf-profile.children.cycles-pp.ext4_get_inode_loc
      1.20 ±  5%      -0.4        0.82 ±  8%  perf-profile.children.cycles-pp.__ext4_get_inode_loc
      1.05            -0.4        0.68 ±  8%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.50            -0.4        0.12 ± 36%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.76 ±  2%      -0.4        0.40 ± 10%  perf-profile.children.cycles-pp.llseek
      0.74            -0.4        0.39 ±  8%  perf-profile.children.cycles-pp.__es_insert_extent
      0.83 ±  2%      -0.3        0.48 ±  9%  perf-profile.children.cycles-pp.fdget
      0.60 ±  3%      -0.3        0.26 ± 13%  perf-profile.children.cycles-pp.bmap
      0.48 ±  2%      -0.3        0.13 ± 23%  perf-profile.children.cycles-pp.dl_server_stop
      0.46            -0.3        0.12 ± 27%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.57 ±  3%      -0.3        0.24 ± 12%  perf-profile.children.cycles-pp.ext4_bmap
      0.85            -0.3        0.55 ± 26%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.80 ±  2%      -0.3        0.50 ±  7%  perf-profile.children.cycles-pp.__cond_resched
      0.42 ±  3%      -0.3        0.13 ± 23%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.41 ±  3%      -0.3        0.12 ± 20%  perf-profile.children.cycles-pp.set_next_task_fair
      0.66 ±  2%      -0.3        0.36 ±  8%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.50 ±  3%      -0.3        0.21 ± 14%  perf-profile.children.cycles-pp.iomap_bmap
      0.54 ±  3%      -0.3        0.25 ± 16%  perf-profile.children.cycles-pp.__check_block_validity
      0.55 ±  2%      -0.3        0.27 ± 19%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.77            -0.3        0.51 ± 26%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.29 ±  4%      -0.2        0.04 ±110%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.30 ±  4%      -0.2        0.06 ± 59%  perf-profile.children.cycles-pp.rb_erase
      0.65 ±  3%      -0.2        0.41 ±  8%  perf-profile.children.cycles-pp._copy_from_user
      0.32 ±  3%      -0.2        0.08 ± 34%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.34 ±  3%      -0.2        0.10 ± 18%  perf-profile.children.cycles-pp.set_next_entity
      0.42 ±  4%      -0.2        0.18 ± 11%  perf-profile.children.cycles-pp.iomap_iter
      0.43 ±  3%      -0.2        0.20 ± 17%  perf-profile.children.cycles-pp.ext4_sb_block_valid
      0.46 ±  2%      -0.2        0.23 ± 13%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.66            -0.2        0.43 ± 26%  perf-profile.children.cycles-pp.update_process_times
      0.39 ±  2%      -0.2        0.16 ± 21%  perf-profile.children.cycles-pp.sched_balance_rq
      0.34 ±  2%      -0.2        0.12 ± 24%  perf-profile.children.cycles-pp.start_dl_timer
      0.32            -0.2        0.11 ± 19%  perf-profile.children.cycles-pp.select_task_rq
      0.43            -0.2        0.22 ± 11%  perf-profile.children.cycles-pp.x64_sys_call
      0.49            -0.2        0.28 ±  9%  perf-profile.children.cycles-pp.__kmalloc_noprof
      0.64            -0.2        0.44 ±  7%  perf-profile.children.cycles-pp.bdev_getblk
      0.60 ±  2%      -0.2        0.40 ±  5%  perf-profile.children.cycles-pp.ext4_cache_extents
      0.36 ±  3%      -0.2        0.17 ± 13%  perf-profile.children.cycles-pp.stress_file_ioctl
      0.22 ±  7%      -0.2        0.03 ±108%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.29 ±  2%      -0.2        0.10 ± 19%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.46 ±  3%      -0.2        0.27 ±  7%  perf-profile.children.cycles-pp.kmem_cache_free
      0.30 ±  3%      -0.2        0.12 ± 18%  perf-profile.children.cycles-pp.prepare_task_switch
      0.37 ±  2%      -0.2        0.19 ± 14%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.22 ±  4%      -0.2        0.04 ± 77%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.31 ±  3%      -0.2        0.13 ± 19%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.32 ±  4%      -0.2        0.14 ± 10%  perf-profile.children.cycles-pp.stress_file_ioctl_ext
      0.30 ±  4%      -0.2        0.12 ± 22%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.24 ±  4%      -0.2        0.07 ± 27%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.48            -0.2        0.31 ±  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.49 ±  2%      -0.2        0.33 ±  4%  perf-profile.children.cycles-pp.ext4_es_cache_extent
      0.54 ±  2%      -0.2        0.37 ±  7%  perf-profile.children.cycles-pp.__find_get_block
      0.40 ±  3%      -0.2        0.23 ± 10%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.32 ±  3%      -0.2        0.16 ±  9%  perf-profile.children.cycles-pp.kfree
      0.29 ±  4%      -0.2        0.14 ± 23%  perf-profile.children.cycles-pp.sched_balance_domains
      0.26 ±  4%      -0.2        0.11 ± 20%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.58 ±  5%      -0.2        0.43 ±  7%  perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      0.31 ±  2%      -0.2        0.16 ±  9%  perf-profile.children.cycles-pp.ioctl_file_clone
      0.21            -0.1        0.06 ± 30%  perf-profile.children.cycles-pp.__switch_to_asm
      0.23 ±  3%      -0.1        0.08 ± 23%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.21            -0.1        0.08 ± 23%  perf-profile.children.cycles-pp.task_contending
      0.23 ±  4%      -0.1        0.10 ± 15%  perf-profile.children.cycles-pp.ext4_iomap_begin
      0.16 ±  5%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.41 ±  2%      -0.1        0.29 ± 19%  perf-profile.children.cycles-pp.clockevents_program_event
      0.27 ± 11%      -0.1        0.15 ± 25%  perf-profile.children.cycles-pp.__ext4_journal_start_sb
      0.24 ±  2%      -0.1        0.12 ± 13%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.63 ±  2%      -0.1        0.51 ±  4%  perf-profile.children.cycles-pp.down_write
      0.20 ±  3%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.__x64_sys_fcntl
      0.20 ±  2%      -0.1        0.08 ± 16%  perf-profile.children.cycles-pp.ksys_lseek
      0.34 ±  3%      -0.1        0.22 ±  7%  perf-profile.children.cycles-pp.rcu_all_qs
      0.55 ±  2%      -0.1        0.44 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      0.14 ±  3%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.kthread
      0.14 ±  3%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.ret_from_fork
      0.14 ±  3%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.21 ±  3%      -0.1        0.10 ± 19%  perf-profile.children.cycles-pp.native_sched_clock
      0.19 ±  3%      -0.1        0.08 ± 18%  perf-profile.children.cycles-pp.update_cfs_group
      0.26 ±  3%      -0.1        0.16 ± 28%  perf-profile.children.cycles-pp.sched_tick
      0.28 ±  4%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      0.45 ±  7%      -0.1        0.35 ±  9%  perf-profile.children.cycles-pp.jbd2_journal_get_write_access
      0.21 ±  3%      -0.1        0.11 ± 11%  perf-profile.children.cycles-pp._copy_to_user
      0.22 ±  6%      -0.1        0.12 ± 12%  perf-profile.children.cycles-pp.crypto_shash_update
      0.23 ±  2%      -0.1        0.13 ± 10%  perf-profile.children.cycles-pp.map_id_up
      0.16 ±  2%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.wake_affine
      0.21 ±  2%      -0.1        0.12 ± 10%  perf-profile.children.cycles-pp.ext4_es_free_extent
      0.13 ±  5%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.vfs_clone_file_range
      0.17 ±  4%      -0.1        0.08 ± 21%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.35 ±  4%      -0.1        0.27 ±  4%  perf-profile.children.cycles-pp._raw_write_lock
      0.17 ±  6%      -0.1        0.09 ± 15%  perf-profile.children.cycles-pp.idle_cpu
      0.16 ±  4%      -0.1        0.08 ± 18%  perf-profile.children.cycles-pp.read_tsc
      0.14 ±  3%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.available_idle_cpu
      0.14 ±  5%      -0.1        0.06 ± 19%  perf-profile.children.cycles-pp.sched_clock
      0.14 ±  7%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.ioctl@plt
      0.13 ±  3%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.__dequeue_entity
      0.16 ±  3%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.__switch_to
      0.20 ±  2%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.memset_orig
      0.16 ±  3%      -0.1        0.10 ± 11%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.12 ±  5%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.ext4_es_can_be_merged
      0.13 ±  4%      -0.1        0.07 ±  8%  perf-profile.children.cycles-pp.__es_tree_search
      0.17 ±  4%      -0.1        0.11 ± 11%  perf-profile.children.cycles-pp.__get_user_4
      0.09 ±  4%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.nohz_balancer_kick
      0.17 ±  4%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.security_file_ioctl
      0.12 ±  4%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.truncate_pagecache_range
      0.14 ±  5%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.__put_user_4
      0.12 ±  6%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.cpuset_cpu_is_isolated
      0.18 ±  3%      -0.1        0.13 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.11 ±  6%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.ext4_meta_trans_blocks
      0.15 ±  4%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.update_rq_clock
      0.11            -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.11            -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.iomap_iter_advance
      0.12            -0.1        0.07 ± 16%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.12 ±  4%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.llist_add_batch
      0.08 ±  4%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.unmap_mapping_range
      0.20            -0.0        0.15 ±  6%  perf-profile.children.cycles-pp.ext4_convert_inline_data
      0.11 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.jbd2_journal_dirty_metadata
      0.11 ±  5%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.ext4_punch_hole
      0.14 ±  3%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.__brelse
      0.09            -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.10 ±  3%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.llist_reverse_order
      0.15 ±  5%      +0.1        0.20 ±  5%  perf-profile.children.cycles-pp.unlock_buffer
      0.70            +0.1        0.76 ±  3%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.06 ±  9%      +0.1        0.12 ± 40%  perf-profile.children.cycles-pp.get_jiffies_update
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.51            +0.1        0.59 ±  7%  perf-profile.children.cycles-pp.up_write
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.29 ±  2%      +0.2        0.51 ±  6%  perf-profile.children.cycles-pp.poll_idle
      0.00            +0.3        0.32 ± 33%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
      1.24 ±  5%      +1.2        2.43 ± 10%  perf-profile.children.cycles-pp.file_modified
      0.64            +1.2        1.84 ±  7%  perf-profile.children.cycles-pp.ext4_dirty_inode
      0.86            +1.3        2.16 ±  8%  perf-profile.children.cycles-pp.generic_update_time
      0.80            +1.4        2.15 ±  8%  perf-profile.children.cycles-pp.__mark_inode_dirty
      3.92            +2.4        6.27 ±  7%  perf-profile.children.cycles-pp.vfs_fileattr_set
      3.68            +2.5        6.14 ±  7%  perf-profile.children.cycles-pp.ext4_fileattr_set
      3.66            +2.5        6.13 ±  7%  perf-profile.children.cycles-pp.ext4_ioctl_setflags
      3.28            +3.1        6.42 ±  7%  perf-profile.children.cycles-pp.ext4_zero_range
      1.58 ±  4%      +3.2        4.81 ±  7%  perf-profile.children.cycles-pp._raw_read_lock
      3.46            +4.5        7.96 ± 14%  perf-profile.children.cycles-pp.jbd2_journal_stop
      3.70            +4.5        8.21 ± 14%  perf-profile.children.cycles-pp.__ext4_journal_stop
     10.37 ± 70%      +6.6       16.92 ±141%  perf-profile.children.cycles-pp.cleanup_module
     12.89 ± 11%      +7.3       20.14 ± 24%  perf-profile.children.cycles-pp.stress_run
     75.89           +14.2       90.11 ±  2%  perf-profile.children.cycles-pp.ioctl
     70.83           +16.3       87.09 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     70.41           +16.4       86.81 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     67.24           +17.7       84.94 ±  2%  perf-profile.children.cycles-pp.__x64_sys_ioctl
     26.30           +29.8       56.06 ±  7%  perf-profile.children.cycles-pp.ext4_alloc_file_blocks
     30.06           +30.1       60.19 ±  7%  perf-profile.children.cycles-pp.ioctl_preallocate
     29.56           +30.3       59.91 ±  7%  perf-profile.children.cycles-pp.vfs_fallocate
     29.09           +30.5       59.63 ±  7%  perf-profile.children.cycles-pp.ext4_fallocate
     19.33            -7.5       11.79 ± 13%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      8.21            -4.4        3.83 ± 17%  perf-profile.self.cycles-pp.intel_idle
      2.79            -1.2        1.57 ±  9%  perf-profile.self.cycles-pp.clear_bhb_loop
      2.14            -0.8        1.34 ±  8%  perf-profile.self.cycles-pp.__wake_up_common
      1.61            -0.7        0.93 ±  9%  perf-profile.self.cycles-pp.ioctl
      0.83            -0.5        0.29 ± 16%  perf-profile.self.cycles-pp.do_vfs_ioctl
      0.49            -0.4        0.12 ± 34%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.01            -0.4        0.65 ±  8%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.98            -0.3        0.64 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.77 ±  2%      -0.3        0.44 ±  9%  perf-profile.self.cycles-pp.fdget
      0.45 ±  3%      -0.3        0.15 ± 30%  perf-profile.self.cycles-pp.menu_select
      1.10            -0.3        0.80 ±  7%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.37 ±  2%      -0.3        0.10 ± 24%  perf-profile.self.cycles-pp.update_load_avg
      0.38            -0.2        0.13 ± 20%  perf-profile.self.cycles-pp.__schedule
      0.28 ±  3%      -0.2        0.04 ±109%  perf-profile.self.cycles-pp.rb_erase
      0.30 ±  2%      -0.2        0.07 ± 36%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.63 ±  3%      -0.2        0.40 ±  8%  perf-profile.self.cycles-pp._copy_from_user
      0.64            -0.2        0.42 ±  9%  perf-profile.self.cycles-pp.do_syscall_64
      0.42 ±  4%      -0.2        0.20 ± 17%  perf-profile.self.cycles-pp.ext4_sb_block_valid
      0.48            -0.2        0.26 ± 10%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.39            -0.2        0.20 ± 11%  perf-profile.self.cycles-pp.x64_sys_call
      0.33 ±  3%      -0.2        0.15 ± 13%  perf-profile.self.cycles-pp.stress_file_ioctl
      0.41            -0.2        0.23 ± 10%  perf-profile.self.cycles-pp.__x64_sys_ioctl
      0.22 ±  4%      -0.2        0.04 ± 77%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.24 ±  5%      -0.2        0.06 ± 54%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.25 ±  3%      -0.2        0.07 ± 33%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.23 ±  3%      -0.2        0.05 ± 51%  perf-profile.self.cycles-pp.dequeue_entity
      0.44 ±  3%      -0.2        0.26 ±  8%  perf-profile.self.cycles-pp.kmem_cache_free
      0.32 ±  4%      -0.2        0.14 ± 11%  perf-profile.self.cycles-pp.stress_file_ioctl_ext
      0.36 ±  2%      -0.2        0.20 ±  8%  perf-profile.self.cycles-pp.ext4_ioctl_setflags
      0.44 ±  2%      -0.2        0.27 ±  8%  perf-profile.self.cycles-pp.__cond_resched
      0.34            -0.2        0.18 ± 13%  perf-profile.self.cycles-pp.__kmalloc_noprof
      0.29            -0.2        0.13 ± 32%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.22 ±  3%      -0.2        0.06 ± 30%  perf-profile.self.cycles-pp.enqueue_entity
      0.30 ±  3%      -0.2        0.15 ±  9%  perf-profile.self.cycles-pp.kfree
      0.43 ±  2%      -0.2        0.28 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.20 ±  3%      -0.1        0.06 ± 25%  perf-profile.self.cycles-pp.__switch_to_asm
      0.42 ±  3%      -0.1        0.28 ±  9%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.32 ±  3%      -0.1        0.18 ±  8%  perf-profile.self.cycles-pp.ext4_inode_csum
      0.38 ±  3%      -0.1        0.24 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.32 ±  2%      -0.1        0.18 ± 10%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.36 ±  5%      -0.1        0.22 ±  8%  perf-profile.self.cycles-pp.ext4_ioctl_getlabel
      0.29 ±  4%      -0.1        0.15 ±  8%  perf-profile.self.cycles-pp.__es_remove_extent
      0.30            -0.1        0.16 ±  8%  perf-profile.self.cycles-pp.ext4_es_insert_extent
      0.24 ±  2%      -0.1        0.12 ± 13%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.16 ±  4%      -0.1        0.05 ± 49%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.24 ±  5%      -0.1        0.13 ±  8%  perf-profile.self.cycles-pp.__es_insert_extent
      0.20 ±  2%      -0.1        0.09 ± 20%  perf-profile.self.cycles-pp.native_sched_clock
      0.18 ±  3%      -0.1        0.07 ± 18%  perf-profile.self.cycles-pp.update_cfs_group
      0.17 ±  6%      -0.1        0.06 ± 17%  perf-profile.self.cycles-pp.ioctl_preallocate
      0.18 ±  3%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.27 ±  2%      -0.1        0.17 ±  9%  perf-profile.self.cycles-pp.rcu_all_qs
      0.41 ±  2%      -0.1        0.32 ± 11%  perf-profile.self.cycles-pp.prepare_to_wait_exclusive
      0.20 ±  3%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp._copy_to_user
      0.52 ±  3%      -0.1        0.42 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock
      0.20 ±  5%      -0.1        0.10 ± 11%  perf-profile.self.cycles-pp.ext4_ext_map_blocks
      0.16 ±  4%      -0.1        0.07 ± 15%  perf-profile.self.cycles-pp.__ext4_ioctl
      0.19 ±  5%      -0.1        0.10 ± 11%  perf-profile.self.cycles-pp.ext4_find_extent
      0.24 ±  3%      -0.1        0.16 ±  6%  perf-profile.self.cycles-pp.ext4_alloc_file_blocks
      0.17 ±  5%      -0.1        0.08 ± 16%  perf-profile.self.cycles-pp.idle_cpu
      0.20 ±  2%      -0.1        0.12 ± 11%  perf-profile.self.cycles-pp.map_id_up
      0.15 ±  4%      -0.1        0.07 ± 21%  perf-profile.self.cycles-pp.read_tsc
      0.20 ±  4%      -0.1        0.11 ± 11%  perf-profile.self.cycles-pp.ext4_es_cache_extent
      0.34 ±  4%      -0.1        0.26 ±  4%  perf-profile.self.cycles-pp._raw_write_lock
      0.14 ±  2%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.available_idle_cpu
      0.18 ±  2%      -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.ext4_fallocate
      0.30 ±  4%      -0.1        0.22 ±  7%  perf-profile.self.cycles-pp.ext4_mark_iloc_dirty
      0.16 ±  6%      -0.1        0.09 ± 13%  perf-profile.self.cycles-pp.crypto_shash_update
      0.15 ±  3%      -0.1        0.08 ± 11%  perf-profile.self.cycles-pp.__switch_to
      0.11 ±  6%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.ext4_es_can_be_merged
      0.26            -0.1        0.20 ± 10%  perf-profile.self.cycles-pp.__wait_on_bit_lock
      0.44 ±  4%      -0.1        0.37 ±  5%  perf-profile.self.cycles-pp.wake_bit_function
      0.18 ±  2%      -0.1        0.12 ±  5%  perf-profile.self.cycles-pp.memset_orig
      0.15 ±  6%      -0.1        0.09 ± 14%  perf-profile.self.cycles-pp.inode_set_ctime_current
      0.31 ±  3%      -0.1        0.25 ±  6%  perf-profile.self.cycles-pp.__find_get_block
      0.16 ±  4%      -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.ext4_inode_csum_set
      0.11 ±  6%      -0.1        0.06 ± 18%  perf-profile.self.cycles-pp.cpuset_cpu_is_isolated
      0.12 ±  4%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__es_tree_search
      0.14 ±  3%      -0.1        0.08 ± 11%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.18 ±  3%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.16 ±  3%      -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.__get_user_4
      0.14 ±  2%      -0.1        0.08 ± 11%  perf-profile.self.cycles-pp.__put_user_4
      0.11 ±  3%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.iomap_iter_advance
      0.08 ±  6%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.__ext4_journal_get_write_access
      0.44 ±  2%      -0.1        0.39 ±  3%  perf-profile.self.cycles-pp.down_write
      0.16 ±  8%      -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.wake_up_bit
      0.10 ±  9%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__ext4_journal_start_sb
      0.12 ±  4%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.llist_add_batch
      0.20 ±  2%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.ext4_convert_inline_data
      0.12 ±  6%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.__ext4_handle_dirty_metadata
      0.10 ±  6%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.__dequeue_entity
      0.12 ±  7%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.security_file_ioctl
      0.09 ±  9%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.jbd2_journal_dirty_metadata
      0.11 ±  6%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.ext4_cache_extents
      0.11 ±  3%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.prepare_task_switch
      0.10 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__ext4_mark_inode_dirty
      0.10 ±  3%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.ext4_map_create_blocks
      0.09            -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__brelse
      0.09 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.ext4_reserve_inode_write
      0.08 ±  6%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.sched_balance_domains
      0.10 ±  3%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.llist_reverse_order
      0.08            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.finish_wait
      0.31 ±  3%      +0.1        0.37 ±  5%  perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.14 ±  3%      +0.1        0.20 ±  5%  perf-profile.self.cycles-pp.unlock_buffer
      0.06 ±  9%      +0.1        0.12 ± 40%  perf-profile.self.cycles-pp.get_jiffies_update
      0.00            +0.1        0.07 ± 16%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.32 ±  3%      +0.1        0.39 ± 13%  perf-profile.self.cycles-pp.ktime_get
      0.49            +0.1        0.57 ±  8%  perf-profile.self.cycles-pp.up_write
      0.28 ±  2%      +0.2        0.50 ±  6%  perf-profile.self.cycles-pp.poll_idle
      1.56 ±  4%      +3.2        4.79 ±  7%  perf-profile.self.cycles-pp._raw_read_lock
      2.01 ±  2%      +4.2        6.24 ± 14%  perf-profile.self.cycles-pp.jbd2_journal_stop
      8.84 ± 70%      +6.3       15.12 ±141%  perf-profile.self.cycles-pp.cleanup_module



***************************************************************************************************
lkp-icl-2sp6: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/ext4/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/makedirs.f/filebench

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.09            -0.0        0.08        mpstat.cpu.all.sys%
     41.00 ± 21%     +40.2%      57.50 ±  7%  perf-c2c.DRAM.remote
      5536            +7.2%       5936        vmstat.system.cs
    723.38 ±  2%     +63.2%       1180 ±  5%  filebench.sum_operations/s
     21.42           -39.7%      12.93 ±  6%  filebench.sum_time_ms/op
    120.80            -6.1%     113.46        filebench.time.elapsed_time
    120.80            -6.1%     113.46        filebench.time.elapsed_time.max
      0.08 ±  6%     -18.5%       0.06 ±  7%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1.09 ±  6%     -13.2%       0.94 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     26.20 ±  4%      -6.8%      24.42 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.01 ±  6%     -12.8%       0.88 ±  5%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     26.09 ±  4%      -6.8%      24.31 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      7640            -6.6%       7132        proc-vmstat.nr_shmem
    664721            -2.0%     651271        proc-vmstat.numa_hit
    532296            -2.5%     518841        proc-vmstat.numa_local
    527838            -3.4%     509776        proc-vmstat.pgfault
     24899            -3.2%      24114        proc-vmstat.pgreuse
 1.608e+08            +3.6%  1.667e+08 ±  2%  perf-stat.i.branch-instructions
      4.11            -0.2        3.89        perf-stat.i.branch-miss-rate%
   7661023            -7.1%    7118866        perf-stat.i.branch-misses
  20082582           -25.3%   15011250 ±  3%  perf-stat.i.cache-references
 8.286e+08            -4.7%  7.895e+08 ±  2%  perf-stat.i.cpu-cycles
 7.796e+08            +3.7%  8.081e+08 ±  2%  perf-stat.i.instructions
      0.64            +1.7%       0.65        perf-stat.i.ipc
      3007 ±  5%      +5.0%       3157        perf-stat.i.minor-faults
      3007 ±  5%      +5.0%       3157        perf-stat.i.page-faults
      4.77            -0.5        4.27 ±  2%  perf-stat.overall.branch-miss-rate%
      2.70 ±  3%      +0.9        3.59        perf-stat.overall.cache-miss-rate%
      1.06            -8.1%       0.98        perf-stat.overall.cpi
      0.94            +8.8%       1.02        perf-stat.overall.ipc
  1.59e+08            +3.6%  1.647e+08 ±  2%  perf-stat.ps.branch-instructions
   7578333            -7.2%    7035164        perf-stat.ps.branch-misses
  19890915           -25.3%   14857571 ±  3%  perf-stat.ps.cache-references
 8.198e+08            -4.8%  7.806e+08 ±  2%  perf-stat.ps.cpu-cycles
 7.708e+08            +3.6%  7.985e+08 ±  2%  perf-stat.ps.instructions
      2973 ±  5%      +4.9%       3117        perf-stat.ps.minor-faults
      2973 ±  5%      +4.9%       3117        perf-stat.ps.page-faults
      2.82 ± 12%      -1.0        1.84 ± 46%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.49 ± 28%      -0.9        0.60 ±110%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.readn
      2.04 ± 17%      -0.8        1.23 ± 49%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1.98 ± 17%      -0.8        1.17 ± 47%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      0.98 ± 12%      -0.6        0.38 ±102%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.77 ± 15%      -0.5        0.29 ±101%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.77 ± 15%      -0.5        0.29 ±101%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
     10.68 ± 13%      -1.6        9.12 ±  8%  perf-profile.children.cycles-pp.ret_from_fork_asm
     10.56 ± 13%      -1.5        9.10 ±  8%  perf-profile.children.cycles-pp.ret_from_fork
      2.88 ± 13%      -1.1        1.82 ± 45%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      2.87 ± 14%      -1.0        1.82 ± 45%  perf-profile.children.cycles-pp.do_group_exit
      2.86 ± 14%      -1.0        1.81 ± 46%  perf-profile.children.cycles-pp.do_exit
      2.94 ± 11%      -1.0        1.92 ± 44%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      2.58 ± 15%      -1.0        1.58 ± 45%  perf-profile.children.cycles-pp.exit_mmap
      2.63 ± 15%      -1.0        1.65 ± 46%  perf-profile.children.cycles-pp.__mmput
      3.04 ± 12%      -1.0        2.07 ± 38%  perf-profile.children.cycles-pp.x64_sys_call
      2.04 ± 17%      -0.8        1.23 ± 49%  perf-profile.children.cycles-pp.exit_mm
      0.95 ± 20%      -0.5        0.40 ± 25%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.95 ± 20%      -0.5        0.40 ± 25%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      1.00 ± 31%      -0.5        0.50 ± 44%  perf-profile.children.cycles-pp.do_anonymous_page
      0.78 ± 25%      -0.4        0.42 ± 49%  perf-profile.children.cycles-pp.__wait_for_common
      0.77 ± 15%      -0.3        0.44 ± 32%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.79 ± 13%      -0.3        0.46 ± 48%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.70 ± 23%      -0.3        0.39 ± 59%  perf-profile.children.cycles-pp.wp_page_copy
      0.60 ± 38%      -0.3        0.32 ± 38%  perf-profile.children.cycles-pp.get_arg_page
      0.52 ± 17%      -0.2        0.28 ± 33%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.52 ± 17%      -0.2        0.28 ± 33%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.46 ± 24%      -0.2        0.24 ± 46%  perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.44 ± 24%      -0.2        0.22 ± 65%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.54 ± 14%      -0.2        0.34 ± 30%  perf-profile.children.cycles-pp.mprotect_fixup
      0.60 ± 20%      -0.2        0.40 ± 16%  perf-profile.children.cycles-pp.update_curr
      0.26 ± 33%      -0.2        0.06 ±109%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.40 ± 32%      -0.2        0.20 ± 63%  perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      0.26 ± 40%      -0.2        0.07 ±111%  perf-profile.children.cycles-pp.need_update
      0.27 ± 34%      -0.1        0.12 ± 68%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.18 ± 42%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.strnlen
      0.18 ± 32%      -0.1        0.05 ± 79%  perf-profile.children.cycles-pp.expand_downwards
      0.21 ± 21%      -0.1        0.11 ± 39%  perf-profile.children.cycles-pp.__vmalloc_area_node
      0.23 ± 20%      -0.1        0.15 ± 32%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.09 ± 88%      +0.2        0.34 ± 22%  perf-profile.children.cycles-pp.inode_permission
      0.22 ± 54%      +0.3        0.50 ± 31%  perf-profile.children.cycles-pp.strncpy_from_user
      1.84 ±  8%      +0.4        2.20 ±  9%  perf-profile.children.cycles-pp.link_path_walk
      0.29 ± 41%      +0.4        0.71 ± 28%  perf-profile.children.cycles-pp.getname_flags
      0.04 ± 83%      +0.6        0.61 ± 93%  perf-profile.children.cycles-pp.schedule_hrtimeout_range
      0.50 ± 21%      +0.7        1.16 ± 51%  perf-profile.children.cycles-pp.vfs_fstatat
      0.33 ± 43%      +0.8        1.13 ± 68%  perf-profile.children.cycles-pp.__dentry_kill
      0.35 ± 31%      -0.2        0.18 ± 45%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.06 ±113%      +0.1        0.21 ± 44%  perf-profile.self.cycles-pp.inode_permission
      0.18 ± 34%      +0.2        0.39 ± 23%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
    224.52 ± 51%     -61.6%      86.28 ± 44%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.00 ± 31%    +157.1%       0.01        sched_debug.cfs_rq:/.h_nr_delayed.avg
      0.33          +200.0%       1.00        sched_debug.cfs_rq:/.h_nr_delayed.max
      0.03 ± 14%    +180.9%       0.09        sched_debug.cfs_rq:/.h_nr_delayed.stddev
      0.05 ±  8%    +159.6%       0.13 ±  6%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.19 ±  7%     +71.8%       0.33 ±  2%  sched_debug.cfs_rq:/.h_nr_running.stddev
     12629 ± 87%    +548.3%      81880 ± 59%  sched_debug.cfs_rq:/.left_deadline.avg
   1615955 ± 88%    +515.1%    9940089 ± 65%  sched_debug.cfs_rq:/.left_deadline.max
    142272 ± 88%    +523.0%     886388 ± 63%  sched_debug.cfs_rq:/.left_deadline.stddev
     10346 ± 94%    +577.5%      70100 ± 70%  sched_debug.cfs_rq:/.left_vruntime.avg
   1323699 ± 94%    +537.0%    8432336 ± 77%  sched_debug.cfs_rq:/.left_vruntime.max
    116541 ± 94%    +549.5%     756961 ± 75%  sched_debug.cfs_rq:/.left_vruntime.stddev
    692200 ± 16%     +51.5%    1048578        sched_debug.cfs_rq:/.load.max
     29.92 ± 17%    +158.2%      77.24 ± 28%  sched_debug.cfs_rq:/.load_avg.avg
    697.94 ± 12%     +49.4%       1043        sched_debug.cfs_rq:/.load_avg.max
    114.41 ± 10%    +102.3%     231.47 ± 17%  sched_debug.cfs_rq:/.load_avg.stddev
    224.52 ± 51%     -61.6%      86.28 ± 44%  sched_debug.cfs_rq:/.min_vruntime.min
      0.05 ±  7%    +161.7%       0.13 ±  6%  sched_debug.cfs_rq:/.nr_running.avg
      1.33           +50.0%       2.00        sched_debug.cfs_rq:/.nr_running.max
      0.20 ±  6%     +77.6%       0.36 ±  2%  sched_debug.cfs_rq:/.nr_running.stddev
     13.10 ± 41%    +257.0%      46.77 ± 45%  sched_debug.cfs_rq:/.removed.load_avg.avg
    341.33          +200.0%       1024        sched_debug.cfs_rq:/.removed.load_avg.max
     63.33 ± 21%    +221.9%     203.83 ± 24%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    166.72 ± 14%    +199.4%     499.17 ± 12%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     25.94 ± 23%    +210.5%      80.54 ± 33%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
    166.72 ± 14%    +199.4%     499.17 ± 12%  sched_debug.cfs_rq:/.removed.util_avg.max
     25.92 ± 23%    +210.6%      80.48 ± 33%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     10346 ± 94%    +577.5%      70100 ± 70%  sched_debug.cfs_rq:/.right_vruntime.avg
   1323699 ± 94%    +537.0%    8432336 ± 77%  sched_debug.cfs_rq:/.right_vruntime.max
    116541 ± 94%    +549.5%     756961 ± 75%  sched_debug.cfs_rq:/.right_vruntime.stddev
     89.70 ±  3%    +176.8%     248.29 ±  8%  sched_debug.cfs_rq:/.util_avg.avg
    876.11 ±  9%     +46.6%       1284 ± 17%  sched_debug.cfs_rq:/.util_avg.max
    156.84 ±  3%     +88.4%     295.48 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
      9.55 ± 13%    +178.8%      26.61 ± 12%  sched_debug.cfs_rq:/.util_est.avg
    380.22 ± 23%    +124.1%     852.17 ±  6%  sched_debug.cfs_rq:/.util_est.max
     47.95 ± 15%    +146.3%     118.10 ±  6%  sched_debug.cfs_rq:/.util_est.stddev
     77528 ± 30%     -96.2%       2958 ± 41%  sched_debug.cpu.avg_idle.min
    152303 ±  6%     +38.7%     211277 ± 12%  sched_debug.cpu.avg_idle.stddev
    138928 ±  2%     -45.0%      76372        sched_debug.cpu.clock.avg
    138935 ±  2%     -45.0%      76378        sched_debug.cpu.clock.max
    138909 ±  2%     -45.0%      76365        sched_debug.cpu.clock.min
      4.81 ± 16%     -33.4%       3.21 ± 13%  sched_debug.cpu.clock.stddev
    138765 ±  2%     -45.1%      76228        sched_debug.cpu.clock_task.avg
    138907 ±  2%     -45.0%      76359        sched_debug.cpu.clock_task.max
    130200 ±  2%     -47.7%      68081        sched_debug.cpu.clock_task.min
    139.96 ± 11%    +132.9%     325.93 ± 11%  sched_debug.cpu.curr->pid.avg
      5667           -45.0%       3119        sched_debug.cpu.curr->pid.max
    710.86 ±  3%     +29.0%     917.35 ±  5%  sched_debug.cpu.curr->pid.stddev
      0.04 ±  9%    +170.6%       0.12 ± 12%  sched_debug.cpu.nr_running.avg
      0.18 ±  6%     +82.5%       0.32 ±  5%  sched_debug.cpu.nr_running.stddev
      3846           -59.8%       1546 ±  3%  sched_debug.cpu.nr_switches.avg
     29779 ±  9%     -48.6%      15318 ±  9%  sched_debug.cpu.nr_switches.max
    451.56 ±  3%     -56.7%     195.67 ±  8%  sched_debug.cpu.nr_switches.min
      4789 ±  7%     -53.9%       2207 ± 10%  sched_debug.cpu.nr_switches.stddev
      0.01           +75.0%       0.01 ± 31%  sched_debug.cpu.nr_uninterruptible.avg
    138923 ±  2%     -45.0%      76368        sched_debug.cpu_clk
    138213 ±  2%     -45.3%      75657        sched_debug.ktime
    139722 ±  2%     -44.8%      77162        sched_debug.sched_clk



***************************************************************************************************
lkp-icl-2sp6: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/xfs/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/singlestreamwritedirect.f/filebench

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     33.75            -1.7%      33.18        boot-time.boot
    119687 ±  9%      -8.3%     109763 ±  5%  sched_debug.cpu.avg_idle.stddev
    105051            +1.8%     106938        vmstat.io.bo
    823752 ± 46%     -54.1%     377859 ± 45%  numa-numastat.node1.local_node
    878984 ± 41%     -47.2%     463834 ± 40%  numa-numastat.node1.numa_hit
      2.63 ±209%     -94.9%       0.13 ±  7%  perf-sched.sch_delay.max.ms.bit_wait.__wait_on_bit.out_of_line_wait_on_bit.netfs_unbuffered_write_iter_locked
      1.32 ±197%     -91.1%       0.12 ±  4%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    732.99 ± 10%     -15.5%     619.68 ± 12%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    732.96 ± 10%     -15.5%     619.64 ± 12%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    456.12            +1.1%     461.26        filebench.sum_bytes_mb/s
     27370            +1.1%      27678        filebench.sum_operations
    456.13            +1.1%     461.27        filebench.sum_operations/s
      2.19            -1.1%       2.17        filebench.sum_time_ms/op
    456.00            +1.1%     461.20        filebench.sum_writes/s
  14427847 ± 26%     +33.4%   19245919 ±  6%  numa-meminfo.node0.FilePages
  11464303 ± 32%     +43.0%   16389081 ±  6%  numa-meminfo.node0.Inactive
  11464303 ± 32%     +43.0%   16389081 ±  6%  numa-meminfo.node0.Inactive(file)
  50157370 ±  7%      -9.4%   45419877 ±  2%  numa-meminfo.node0.MemFree
  15498401 ± 24%     +30.6%   20235895 ±  6%  numa-meminfo.node0.MemUsed
   7006849            +1.1%    7085773        proc-vmstat.nr_dirtied
   4204805            +2.3%    4302911        proc-vmstat.nr_dirty
   7214537            +2.4%    7386476        proc-vmstat.nr_file_pages
   6371446            +2.7%    6544461        proc-vmstat.nr_foll_pin_acquired
   6371330            +2.7%    6544348        proc-vmstat.nr_foll_pin_released
   6306394            +2.7%    6478320        proc-vmstat.nr_inactive_file
   4350806            +1.6%    4421837        proc-vmstat.nr_written
   6306394            +2.7%    6478320        proc-vmstat.nr_zone_inactive_file
   4220646            +2.3%    4319236        proc-vmstat.nr_zone_write_pending
  17403444            +1.6%   17687571        proc-vmstat.pgpgout
   3174870 ± 32%     +42.3%    4518963 ±  7%  numa-vmstat.node0.nr_dirtied
   3604142 ± 26%     +33.5%    4811989 ±  6%  numa-vmstat.node0.nr_file_pages
   2124183 ±141%    +208.1%    6545089        numa-vmstat.node0.nr_foll_pin_acquired
   2124146 ±141%    +208.1%    6544976        numa-vmstat.node0.nr_foll_pin_released
  12542179 ±  7%      -9.5%   11354469 ±  2%  numa-vmstat.node0.nr_free_pages
   2863250 ± 32%     +43.1%    4097775 ±  6%  numa-vmstat.node0.nr_inactive_file
   2863250 ± 32%     +43.1%    4097774 ±  6%  numa-vmstat.node0.nr_zone_inactive_file
   4248173 ± 70%    -100.0%      91.00 ±122%  numa-vmstat.node1.nr_foll_pin_acquired
   4248097 ± 70%    -100.0%      91.00 ±122%  numa-vmstat.node1.nr_foll_pin_released
    878743 ± 41%     -47.2%     463596 ± 40%  numa-vmstat.node1.numa_hit
    823511 ± 46%     -54.1%     377621 ± 45%  numa-vmstat.node1.numa_local
  12119619            -1.9%   11893902        perf-stat.i.branch-misses
  35828930            -6.7%   33423670        perf-stat.i.cache-references
      1.84            -2.4%       1.79        perf-stat.i.cpi
      0.61            +3.6%       0.63        perf-stat.i.ipc
      5.34            -0.2        5.17        perf-stat.overall.branch-miss-rate%
      9.87            +0.9       10.74 ±  6%  perf-stat.overall.cache-miss-rate%
      1.17            -2.6%       1.13        perf-stat.overall.cpi
      0.86            +2.7%       0.88        perf-stat.overall.ipc
  12058384            -1.5%   11877207        perf-stat.ps.branch-misses
  36139557            -6.1%   33925047        perf-stat.ps.cache-references
      3730            +1.3%       3779        perf-stat.ps.context-switches
      1.11 ± 13%      -0.3        0.81 ± 18%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.07 ± 12%      -0.3        0.79 ± 19%  perf-profile.calltrace.cycles-pp.tick_nohz_stop_tick.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.55 ± 46%      +0.3        0.87 ± 16%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.55 ± 46%      +0.3        0.87 ± 16%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      1.20 ± 13%      -0.4        0.85 ± 15%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      1.15 ± 12%      -0.3        0.82 ± 15%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      1.43 ± 10%      -0.3        1.12 ±  9%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.30 ± 26%      -0.1        0.17 ± 21%  perf-profile.children.cycles-pp.__get_unmapped_area
      0.38 ± 14%      -0.1        0.26 ± 40%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.46 ± 18%      -0.1        0.36 ± 15%  perf-profile.children.cycles-pp.show_stat
      0.14 ± 29%      -0.1        0.05 ± 64%  perf-profile.children.cycles-pp.list_add_leaf_cfs_rq
      0.04 ± 86%      +0.1        0.15 ± 30%  perf-profile.children.cycles-pp._exit
      0.03 ±108%      +0.1        0.14 ± 30%  perf-profile.children.cycles-pp.filemap_get_pages
      0.03 ±108%      +0.1        0.14 ± 30%  perf-profile.children.cycles-pp.filemap_get_read_batch
      0.02 ±223%      +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.__ata_qc_complete
      0.10 ± 26%      +0.2        0.26 ±  8%  perf-profile.children.cycles-pp.filemap_read
      0.37 ± 35%      +0.2        0.53 ± 10%  perf-profile.children.cycles-pp.__run_timers
      0.66 ± 12%      +0.2        0.83 ±  9%  perf-profile.children.cycles-pp.finish_task_switch
      0.04 ± 71%      +0.2        0.29 ±142%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.04 ± 71%      +0.2        0.29 ±142%  perf-profile.children.cycles-pp.folio_end_writeback
      1.23 ± 17%      +0.3        1.58 ±  8%  perf-profile.children.cycles-pp.try_to_wake_up
      2.62 ± 12%      +0.4        3.05 ±  5%  perf-profile.children.cycles-pp.x64_sys_call
      2.68 ±  6%      +0.5        3.15 ± 12%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.38 ± 14%      -0.1        0.26 ± 40%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.14 ± 29%      -0.1        0.05 ± 64%  perf-profile.self.cycles-pp.list_add_leaf_cfs_rq
      0.05 ± 80%      +0.1        0.15 ± 27%  perf-profile.self.cycles-pp.alloc_vmap_area
      0.26 ± 22%      +0.2        0.44 ± 20%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof



***************************************************************************************************
lkp-icl-2sp6: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/btrfs/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/lkp-icl-2sp6/makedirs.f/filebench

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     19.50 ±  6%     +36.8%      26.67 ± 18%  perf-c2c.HITM.remote
     33.03            +2.6%      33.88 ±  2%  boot-time.boot
      3722            +2.5%       3814 ±  2%  boot-time.idle
      8340            -6.0%       7838        proc-vmstat.nr_shmem
    531751 ±  2%      -3.1%     515338        proc-vmstat.pgfault
      5650            +7.2%       6057        vmstat.system.cs
      4031 ±  3%     +11.4%       4489 ±  5%  vmstat.system.in
    883.77 ±  4%     +67.2%       1478 ±  9%  filebench.sum_operations/s
     17.30 ±  3%     -41.7%      10.08 ±  8%  filebench.sum_time_ms/op
    118.36            -5.5%     111.90        filebench.time.elapsed_time
    118.36            -5.5%     111.90        filebench.time.elapsed_time.max
      0.08 ±  3%     -18.6%       0.06 ± 11%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.10 ± 27%     -92.7%       0.01 ±223%  perf-sched.sch_delay.avg.ms.usleep_range_state.cifs_readv_from_socket.cifs_read_from_socket.cifs_demultiplex_thread
      0.10 ± 27%     -92.7%       0.01 ±223%  perf-sched.sch_delay.max.ms.usleep_range_state.cifs_readv_from_socket.cifs_read_from_socket.cifs_demultiplex_thread
    994.71 ± 82%    +104.7%       2035 ± 27%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      2.03           -83.4%       0.34 ±223%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    994.71 ± 82%    +104.7%       2035 ± 27%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      2.03           -83.4%       0.34 ±223%  perf-sched.wait_time.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
   6521081 ± 36%     -42.7%    3735458 ± 26%  sched_debug.cfs_rq:/.avg_vruntime.max
   6521081 ± 36%     -42.7%    3735458 ± 26%  sched_debug.cfs_rq:/.min_vruntime.max
   1086103 ±110%    -100.0%     250.38 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
  96446011 ± 85%    -100.0%       1277 ± 17%  sched_debug.cfs_rq:/.runnable_avg.max
   9551724 ± 90%    -100.0%     309.57 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    942.00 ± 14%     +35.7%       1278 ± 17%  sched_debug.cfs_rq:/.util_avg.max
    228.25 ± 30%     +35.5%     309.24 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
 3.378e+08            +4.8%  3.539e+08        perf-stat.i.branch-instructions
      3.50 ±  3%      +0.2        3.74 ±  2%  perf-stat.i.cache-miss-rate%
  22983457 ±  2%     -21.0%   18161711        perf-stat.i.cache-references
    266.65 ±  2%      -3.9%     256.36 ±  3%  perf-stat.i.cpu-migrations
 1.684e+09            +4.4%  1.758e+09        perf-stat.i.instructions
      5.14            -0.2        4.95        perf-stat.overall.branch-miss-rate%
      4.21 ±  5%      +1.2        5.37 ±  5%  perf-stat.overall.cache-miss-rate%
      1.04            -4.8%       0.99 ±  2%  perf-stat.overall.cpi
      0.96            +5.1%       1.01 ±  2%  perf-stat.overall.ipc
 3.356e+08            +4.4%  3.505e+08        perf-stat.ps.branch-instructions
  23142109 ±  2%     -22.3%   17992823        perf-stat.ps.cache-references
    268.25            -5.6%     253.17 ±  3%  perf-stat.ps.cpu-migrations
 1.673e+09 ±  2%      +4.1%  1.742e+09        perf-stat.ps.instructions
     47.47           -20.7       26.76 ±  8%  perf-profile.calltrace.cycles-pp.common_startup_64
     42.13 ±  3%     -18.5       23.67 ±  8%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     42.13 ±  3%     -18.4       23.69 ±  8%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     42.06 ±  3%     -18.4       23.65 ±  8%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     36.65 ±  4%     -17.6       19.00 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     32.40 ±  3%     -15.2       17.17 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     32.43 ±  4%     -14.5       17.94 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     14.06 ±  5%     -10.6        3.45 ± 36%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     12.38 ±  5%      -9.2        3.22 ± 38%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      8.31 ±  6%      -5.8        2.55 ± 34%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      8.26 ±  6%      -5.7        2.54 ± 35%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.18 ± 10%      -4.8        1.41 ± 47%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      6.18 ± 10%      -4.8        1.41 ± 47%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      6.18 ± 10%      -4.8        1.41 ± 47%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      6.18 ± 10%      -4.8        1.41 ± 47%  perf-profile.calltrace.cycles-pp.execve
      6.13 ±  9%      -4.7        1.38 ± 46%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.18 ±  7%      -4.3        0.88 ± 37%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.77 ±  9%      -4.3        1.50 ± 42%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      5.67 ±  9%      -4.2        1.48 ± 42%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
     10.06 ± 12%      -4.1        5.91 ± 11%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     10.06 ± 12%      -4.1        5.91 ± 11%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     10.06 ± 12%      -4.1        5.91 ± 11%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     15.90 ±  8%      -3.7       12.18 ±  4%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      4.58 ± 11%      -3.5        1.03 ± 39%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.66 ± 11%      -3.5        1.18 ± 44%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      4.23 ±  8%      -3.2        0.98 ± 37%  perf-profile.calltrace.cycles-pp.read
      4.08 ± 11%      -3.2        0.90 ± 42%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.26 ± 14%      -3.1        1.12 ± 32%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      4.02 ±  7%      -3.1        0.93 ± 35%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      4.00 ±  7%      -3.1        0.93 ± 35%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.05 ± 15%      -3.0        1.07 ± 32%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.97 ± 11%      -3.0        1.02 ± 33%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      3.44 ± 14%      -2.9        0.56 ± 80%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      3.44 ± 14%      -2.9        0.57 ± 80%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.72 ±  9%      -2.8        0.90 ± 37%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.63 ± 15%      -2.8        0.81 ± 46%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      3.61 ± 16%      -2.8        0.80 ± 46%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      3.52 ±  7%      -2.8        0.74 ± 68%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events.cmd_stat
      3.71 ± 15%      -2.8        0.94 ± 41%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      3.31 ± 14%      -2.8        0.54 ± 81%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.smpboot_thread_fn.kthread
      3.50 ± 15%      -2.7        0.79 ± 47%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      3.50 ± 11%      -2.7        0.81 ± 54%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      3.48 ± 11%      -2.7        0.80 ± 54%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.24 ± 13%      -2.5        0.73 ± 55%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.03 ±  7%      -2.5        0.53 ± 87%  perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events
      2.93 ± 14%      -2.4        0.48 ± 80%  perf-profile.calltrace.cycles-pp.balance_fair.__pick_next_task.__schedule.schedule.smpboot_thread_fn
      2.92 ± 14%      -2.4        0.48 ± 80%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.balance_fair.__pick_next_task.__schedule.schedule
      2.93 ±  6%      -2.4        0.51 ± 86%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.read_counters
      2.93 ±  6%      -2.4        0.51 ± 86%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval
      4.12 ± 16%      -2.4        1.76 ± 30%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      3.01 ± 13%      -2.3        0.69 ± 56%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.calltrace.cycles-pp.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.common_startup_64
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      5.33 ± 23%      -2.3        3.07 ± 24%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations
      2.60 ±  5%      -2.2        0.37 ±108%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next
      3.62 ± 29%      -2.2        1.46 ±  8%  perf-profile.calltrace.cycles-pp.do_softirq.flush_smp_call_function_queue.do_idle.cpu_startup_entry.rest_init
      3.68 ± 28%      -2.1        1.59 ±  7%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.rest_init.start_kernel
      2.43 ±  5%      -2.1        0.35 ±110%  perf-profile.calltrace.cycles-pp.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity
      2.74 ± 11%      -2.1        0.67 ± 62%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.58 ± 13%      -2.0        0.56 ± 83%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      2.65 ± 13%      -2.0        0.65 ± 62%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64
      2.65 ± 13%      -2.0        0.65 ± 62%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.65 ± 13%      -2.0        0.65 ± 61%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.61 ± 21%      -2.0        1.64 ± 31%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      3.61 ± 29%      -2.0        1.65 ± 12%  perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      3.59 ± 29%      -2.0        1.64 ± 11%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.handle_softirqs.do_softirq.flush_smp_call_function_queue.do_idle
      2.50 ± 17%      -1.3        1.16 ±  8%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      2.44 ± 19%      -1.2        1.20 ± 23%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      2.45 ± 19%      -1.2        1.23 ± 25%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.58 ± 23%      -0.8        0.78 ± 17%  perf-profile.calltrace.cycles-pp.sched_balance_domains._nohz_idle_balance.handle_softirqs.do_softirq.flush_smp_call_function_queue
      1.47 ± 26%      -0.8        0.71 ± 20%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_domains._nohz_idle_balance.handle_softirqs.do_softirq
      0.63 ± 49%      +0.6        1.18 ± 13%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      0.00            +0.6        0.57 ±  6%  perf-profile.calltrace.cycles-pp.tcp_sock_set_cork.__smb_send_rqst.smb_send_rqst.compound_send_recv.smb2_query_dir_first
      0.65 ± 48%      +0.6        1.24 ± 13%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      0.49 ± 71%      +0.6        1.08 ± 13%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.00            +0.6        0.63 ± 10%  perf-profile.calltrace.cycles-pp.malloc
      0.00            +0.6        0.65 ± 12%  perf-profile.calltrace.cycles-pp.__btrfs_update_delayed_inode.btrfs_commit_inode_delayed_inode.btrfs_evict_inode.evict.__dentry_kill
      0.00            +0.8        0.75 ± 12%  perf-profile.calltrace.cycles-pp.btrfs_commit_inode_delayed_inode.btrfs_evict_inode.evict.__dentry_kill.dput
      0.00            +0.8        0.79 ± 17%  perf-profile.calltrace.cycles-pp.__smb_send_rqst.smb_send_rqst.compound_send_recv.cifs_send_recv.SMB2_query_directory
      0.00            +0.8        0.79 ± 17%  perf-profile.calltrace.cycles-pp.smb_send_rqst.compound_send_recv.cifs_send_recv.SMB2_query_directory.find_cifs_entry
      0.73 ± 49%      +0.8        1.54 ± 13%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      0.00            +0.8        0.81 ±  5%  perf-profile.calltrace.cycles-pp.__smb_send_rqst.smb_send_rqst.compound_send_recv.smb2_query_dir_first._initiate_cifs_search
      0.00            +0.8        0.82 ±  5%  perf-profile.calltrace.cycles-pp.smb_send_rqst.compound_send_recv.smb2_query_dir_first._initiate_cifs_search.cifs_readdir
      0.00            +0.8        0.84 ± 10%  perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet6_recvmsg.sock_recvmsg.____sys_recvmsg
      0.00            +0.9        0.87 ± 17%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.filename_getxattr.path_getxattrat
      0.00            +0.9        0.91 ± 10%  perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet6_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg
      0.09 ±223%      +0.9        1.00 ±  9%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      0.00            +0.9        0.91 ± 10%  perf-profile.calltrace.cycles-pp.__smb_send_rqst.smb_send_rqst.compound_send_recv.smb2_compound_op.smb2_rmdir
      0.00            +0.9        0.92 ± 10%  perf-profile.calltrace.cycles-pp.inet6_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg
      0.00            +0.9        0.92 ±  9%  perf-profile.calltrace.cycles-pp.smb_send_rqst.compound_send_recv.smb2_compound_op.smb2_rmdir.cifs_rmdir
      0.00            +0.9        0.94 ±  8%  perf-profile.calltrace.cycles-pp.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64
      0.10 ±223%      +1.0        1.05 ±  8%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      0.88 ± 18%      +1.0        1.84 ± 15%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.0        0.97 ± 23%  perf-profile.calltrace.cycles-pp.btrfs_getxattr.__vfs_getxattr.do_getxattr.filename_getxattr.path_getxattrat
      0.00            +1.0        0.98 ± 21%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.00            +1.0        0.99 ± 20%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      0.00            +1.0        1.00 ±  9%  perf-profile.calltrace.cycles-pp.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.0        1.00 ± 14%  perf-profile.calltrace.cycles-pp.compound_send_recv.cifs_send_recv.__SMB2_close.cifs_closedir.__fput
      0.00            +1.0        1.00 ± 14%  perf-profile.calltrace.cycles-pp.cifs_send_recv.__SMB2_close.cifs_closedir.__fput.__x64_sys_close
      0.00            +1.0        1.00 ± 28%  perf-profile.calltrace.cycles-pp.tcp_sock_set_cork.__smb_send_rqst.smb_send_rqst.compound_send_recv.cifs_send_recv
      0.00            +1.0        1.03 ± 12%  perf-profile.calltrace.cycles-pp.__btrfs_unlink_inode.btrfs_rmdir.vfs_rmdir.do_rmdir.__x64_sys_unlinkat
      0.00            +1.0        1.05 ± 20%  perf-profile.calltrace.cycles-pp.__vfs_getxattr.do_getxattr.filename_getxattr.path_getxattrat.do_syscall_64
      0.00            +1.0        1.05 ± 15%  perf-profile.calltrace.cycles-pp.cifs_send_recv.SMB2_query_directory.find_cifs_entry.cifs_readdir.iterate_dir
      0.00            +1.0        1.05 ± 15%  perf-profile.calltrace.cycles-pp.compound_send_recv.cifs_send_recv.SMB2_query_directory.find_cifs_entry.cifs_readdir
      1.10 ± 18%      +1.0        2.15 ±  5%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +1.1        1.08 ± 13%  perf-profile.calltrace.cycles-pp.__SMB2_close.cifs_closedir.__fput.__x64_sys_close.do_syscall_64
      0.00            +1.1        1.12 ± 14%  perf-profile.calltrace.cycles-pp.cifs_closedir.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.1        1.12 ± 17%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v6_do_rcv.tcp_v6_rcv.ip6_protocol_deliver_rcu.ip6_input_finish
      0.00            +1.1        1.13 ± 26%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_hrtimeout_range.ep_poll.do_epoll_wait
      0.00            +1.1        1.13 ± 17%  perf-profile.calltrace.cycles-pp.tcp_v6_do_rcv.tcp_v6_rcv.ip6_protocol_deliver_rcu.ip6_input_finish.__netif_receive_skb_one_core
      0.00            +1.1        1.14 ± 10%  perf-profile.calltrace.cycles-pp.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
      0.00            +1.1        1.15 ± 13%  perf-profile.calltrace.cycles-pp.SMB2_query_directory.find_cifs_entry.cifs_readdir.iterate_dir.__x64_sys_getdents64
      0.00            +1.2        1.15 ± 16%  perf-profile.calltrace.cycles-pp.syscall
      0.00            +1.2        1.15 ± 16%  perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet6_recvmsg.sock_recvmsg.cifs_readv_from_socket
      0.00            +1.2        1.17 ± 13%  perf-profile.calltrace.cycles-pp.find_cifs_entry.cifs_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.00            +1.2        1.17 ± 27%  perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00            +1.2        1.17 ± 11%  perf-profile.calltrace.cycles-pp.compound_send_recv.smb2_query_dir_first._initiate_cifs_search.cifs_readdir.iterate_dir
      0.00            +1.2        1.18 ±  8%  perf-profile.calltrace.cycles-pp.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
      0.00            +1.2        1.24 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
      0.00            +1.2        1.25 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvmsg
      0.00            +1.3        1.25 ± 14%  perf-profile.calltrace.cycles-pp.inet6_recvmsg.sock_recvmsg.cifs_readv_from_socket.cifs_read_from_socket.cifs_demultiplex_thread
      0.00            +1.3        1.26 ± 14%  perf-profile.calltrace.cycles-pp.sock_recvmsg.cifs_readv_from_socket.cifs_read_from_socket.cifs_demultiplex_thread.kthread
      0.00            +1.3        1.26 ±  9%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.00            +1.3        1.28 ± 10%  perf-profile.calltrace.cycles-pp.path_listxattrat.do_syscall_64.entry_SYSCALL_64_after_hwframe.listxattr
      0.00            +1.3        1.29 ±  7%  perf-profile.calltrace.cycles-pp.compound_send_recv.smb2_compound_op.smb2_rmdir.cifs_rmdir.vfs_rmdir
      0.00            +1.3        1.31 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.listxattr
      0.00            +1.3        1.31 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.listxattr
      0.00            +1.3        1.33 ± 19%  perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet6_recvmsg.sock_recvmsg.cifs_readv_from_socket.cifs_read_from_socket
      0.00            +1.4        1.37 ± 20%  perf-profile.calltrace.cycles-pp.do_getxattr.filename_getxattr.path_getxattrat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.4        1.37 ± 10%  perf-profile.calltrace.cycles-pp.recvmsg
      0.00            +1.4        1.39 ± 11%  perf-profile.calltrace.cycles-pp.listxattr
      0.00            +1.4        1.41 ± 18%  perf-profile.calltrace.cycles-pp.tcp_v6_rcv.ip6_protocol_deliver_rcu.ip6_input_finish.__netif_receive_skb_one_core.process_backlog
      0.10 ±223%      +1.4        1.52 ±  8%  perf-profile.calltrace.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.4        1.42 ± 26%  perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64
      0.00            +1.4        1.44 ± 15%  perf-profile.calltrace.cycles-pp.cifs_readv_from_socket.cifs_read_from_socket.cifs_demultiplex_thread.kthread.ret_from_fork
      0.00            +1.4        1.44 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.00            +1.4        1.45 ± 18%  perf-profile.calltrace.cycles-pp.ip6_protocol_deliver_rcu.ip6_input_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
      0.00            +1.5        1.46 ± 16%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.openat64
      0.00            +1.5        1.46 ± 18%  perf-profile.calltrace.cycles-pp.ip6_input_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      0.00            +1.5        1.46 ± 16%  perf-profile.calltrace.cycles-pp.cifs_read_from_socket.cifs_demultiplex_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +1.5        1.50 ± 15%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.openat64
      0.00            +1.5        1.50 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.00            +1.5        1.52 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.00            +1.5        1.53 ± 14%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.filename_getxattr.path_getxattrat.do_syscall_64
      0.00            +1.5        1.53 ± 18%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
      0.00            +1.5        1.54 ± 14%  perf-profile.calltrace.cycles-pp.filename_lookup.filename_getxattr.path_getxattrat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.6        1.56 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.openat64
      0.00            +1.6        1.56 ± 10%  perf-profile.calltrace.cycles-pp.smb2_query_dir_first._initiate_cifs_search.cifs_readdir.iterate_dir.__x64_sys_getdents64
      0.00            +1.6        1.57 ± 17%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
      0.00            +1.6        1.57 ± 17%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
      0.00            +1.6        1.58 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.openat64
      0.00            +1.6        1.58 ± 12%  perf-profile.calltrace.cycles-pp.__close_nocancel
      0.00            +1.6        1.59 ± 10%  perf-profile.calltrace.cycles-pp._initiate_cifs_search.cifs_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.00            +1.7        1.66 ± 13%  perf-profile.calltrace.cycles-pp.btrfs_rmdir.vfs_rmdir.do_rmdir.__x64_sys_unlinkat.do_syscall_64
      0.00            +1.7        1.73 ± 29%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sock_set_cork.__smb_send_rqst.smb_send_rqst
      0.00            +1.7        1.73 ±  9%  perf-profile.calltrace.cycles-pp.smb2_compound_op.smb2_rmdir.cifs_rmdir.vfs_rmdir.do_rmdir
      0.00            +1.7        1.73 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_evict_inode.evict.__dentry_kill.dput.__fput
      0.00            +1.7        1.74 ± 28%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sock_set_cork.__smb_send_rqst.smb_send_rqst.compound_send_recv
      0.00            +1.7        1.74 ±  9%  perf-profile.calltrace.cycles-pp.smb2_rmdir.cifs_rmdir.vfs_rmdir.do_rmdir.__x64_sys_unlinkat
      0.00            +1.8        1.79 ± 14%  perf-profile.calltrace.cycles-pp.openat64
      0.00            +1.8        1.80 ± 10%  perf-profile.calltrace.cycles-pp.cifs_rmdir.vfs_rmdir.do_rmdir.__x64_sys_unlinkat.do_syscall_64
      0.00            +1.8        1.81 ±  8%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.__x64_sys_close
      0.00            +1.8        1.85 ± 19%  perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      0.00            +2.1        2.11 ±  7%  perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +2.1        2.11 ±  8%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.__x64_sys_close.do_syscall_64
      0.00            +2.1        2.12 ± 23%  perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip6_finish_output2
      0.00            +2.1        2.13 ± 23%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip6_finish_output2.ip6_finish_output
      0.00            +2.2        2.16 ±  7%  perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.2        2.16 ± 22%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip6_finish_output2.ip6_finish_output.ip6_xmit
      0.00            +2.2        2.19 ± 25%  perf-profile.calltrace.cycles-pp.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.3        2.25 ± 25%  perf-profile.calltrace.cycles-pp.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +2.3        2.32 ±  9%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +2.3        2.33 ± 25%  perf-profile.calltrace.cycles-pp.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +2.5        2.54 ± 18%  perf-profile.calltrace.cycles-pp.inet6_csk_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
      0.00            +2.6        2.59 ± 25%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip6_finish_output2.ip6_finish_output.ip6_xmit.inet6_csk_xmit
      0.00            +2.6        2.59 ± 24%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +2.6        2.59 ± 24%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.epoll_wait
      0.00            +2.6        2.60 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +2.6        2.65 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +2.7        2.66 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      0.00            +2.7        2.66 ± 26%  perf-profile.calltrace.cycles-pp.ip6_finish_output2.ip6_finish_output.ip6_xmit.inet6_csk_xmit.__tcp_transmit_skb
      0.00            +2.7        2.72 ± 14%  perf-profile.calltrace.cycles-pp.cifs_demultiplex_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +2.7        2.72 ± 25%  perf-profile.calltrace.cycles-pp.ip6_finish_output.ip6_xmit.inet6_csk_xmit.__tcp_transmit_skb.tcp_write_xmit
      0.00            +2.8        2.79 ± 17%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
      0.00            +2.8        2.80 ±  8%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +2.8        2.85 ±  8%  perf-profile.calltrace.cycles-pp.__close
      0.00            +2.9        2.85 ± 22%  perf-profile.calltrace.cycles-pp.epoll_wait
      0.00            +3.0        2.99 ± 13%  perf-profile.calltrace.cycles-pp.filename_getxattr.path_getxattrat.do_syscall_64.entry_SYSCALL_64_after_hwframe.getxattr
      0.00            +3.0        3.00 ± 28%  perf-profile.calltrace.cycles-pp.ip6_xmit.inet6_csk_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
      0.00            +3.1        3.06 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +3.1        3.08 ± 16%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.____sys_sendmsg
      0.00            +3.1        3.10 ± 16%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.____sys_sendmsg.___sys_sendmsg
      0.00            +3.1        3.10 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +3.1        3.14 ± 10%  perf-profile.calltrace.cycles-pp.cifs_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +3.2        3.19 ± 13%  perf-profile.calltrace.cycles-pp.path_getxattrat.do_syscall_64.entry_SYSCALL_64_after_hwframe.getxattr
      0.00            +3.3        3.25 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getxattr
      0.00            +3.3        3.26 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getxattr
      0.00            +3.4        3.39 ± 13%  perf-profile.calltrace.cycles-pp.getxattr
      0.00            +3.6        3.65 ± 11%  perf-profile.calltrace.cycles-pp.fstatat64
      0.00            +3.8        3.79 ± 16%  perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg
      0.00            +3.8        3.80 ± 10%  perf-profile.calltrace.cycles-pp.vfs_rmdir.do_rmdir.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +3.9        3.89 ± 16%  perf-profile.calltrace.cycles-pp.tcp_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
      0.00            +4.0        4.01 ± 11%  perf-profile.calltrace.cycles-pp.do_rmdir.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.00            +4.1        4.06 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.00            +4.1        4.09 ± 11%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +4.1        4.10 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.00            +4.1        4.10 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlinkat
      0.00            +4.2        4.18 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +4.2        4.19 ± 11%  perf-profile.calltrace.cycles-pp.unlinkat
      0.00            +4.3        4.28 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +4.3        4.29 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +4.4        4.44 ± 12%  perf-profile.calltrace.cycles-pp.getdents64
      0.00            +4.5        4.46 ± 16%  perf-profile.calltrace.cycles-pp.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +4.7        4.65 ± 16%  perf-profile.calltrace.cycles-pp.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
      0.00            +4.7        4.70 ± 17%  perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
      0.00            +4.8        4.77 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
      0.00            +4.8        4.77 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendmsg
      0.00            +4.9        4.92 ± 16%  perf-profile.calltrace.cycles-pp.sendmsg
     47.47           -20.7       26.76 ±  8%  perf-profile.children.cycles-pp.common_startup_64
     47.47           -20.7       26.76 ±  8%  perf-profile.children.cycles-pp.cpu_startup_entry
     47.42           -20.7       26.74 ±  8%  perf-profile.children.cycles-pp.do_idle
     42.13 ±  3%     -18.4       23.69 ±  8%  perf-profile.children.cycles-pp.start_secondary
     38.10 ±  4%     -17.8       20.30 ±  9%  perf-profile.children.cycles-pp.cpuidle_idle_call
     33.63 ±  3%     -15.4       18.24 ± 10%  perf-profile.children.cycles-pp.cpuidle_enter
     33.49 ±  3%     -15.3       18.15 ± 10%  perf-profile.children.cycles-pp.cpuidle_enter_state
     14.26 ±  4%     -10.1        4.15 ± 29%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     13.24 ±  5%      -9.4        3.84 ± 30%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      7.10 ±  3%      -5.6        1.53 ± 44%  perf-profile.children.cycles-pp.dispatch_events
      7.10 ±  3%      -5.6        1.53 ± 44%  perf-profile.children.cycles-pp.cmd_stat
      7.08 ±  3%      -5.6        1.53 ± 44%  perf-profile.children.cycles-pp.process_interval
      6.96 ±  4%      -5.5        1.48 ± 44%  perf-profile.children.cycles-pp.read_counters
      6.44 ±  6%      -5.0        1.42 ± 35%  perf-profile.children.cycles-pp.read
      6.25 ±  9%      -4.8        1.42 ± 47%  perf-profile.children.cycles-pp.__x64_sys_execve
      6.20 ±  8%      -4.8        1.40 ± 46%  perf-profile.children.cycles-pp.do_execveat_common
      6.18 ± 10%      -4.8        1.41 ± 47%  perf-profile.children.cycles-pp.execve
      6.36 ±  6%      -4.6        1.81 ± 33%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     10.50 ± 11%      -4.5        6.01 ± 11%  perf-profile.children.cycles-pp.ret_from_fork_asm
      5.70 ±  5%      -4.4        1.25 ± 42%  perf-profile.children.cycles-pp.sched_setaffinity
     10.45 ± 11%      -4.4        6.00 ± 11%  perf-profile.children.cycles-pp.ret_from_fork
      5.95 ± 11%      -4.4        1.52 ± 36%  perf-profile.children.cycles-pp.asm_exc_page_fault
      6.20 ±  6%      -4.4        1.78 ± 33%  perf-profile.children.cycles-pp.hrtimer_interrupt
      5.59 ±  5%      -4.3        1.28 ± 36%  perf-profile.children.cycles-pp.ksys_read
     10.06 ± 12%      -4.1        5.91 ± 11%  perf-profile.children.cycles-pp.kthread
      5.30 ±  6%      -4.1        1.24 ± 37%  perf-profile.children.cycles-pp.vfs_read
      5.15 ± 12%      -3.9        1.29 ± 34%  perf-profile.children.cycles-pp.do_user_addr_fault
      5.16 ± 12%      -3.9        1.30 ± 34%  perf-profile.children.cycles-pp.exc_page_fault
     16.15 ±  8%      -3.7       12.41 ±  4%  perf-profile.children.cycles-pp.intel_idle
      5.11 ±  9%      -3.7        1.44 ± 34%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      4.86 ± 13%      -3.6        1.24 ± 37%  perf-profile.children.cycles-pp.handle_mm_fault
      4.58 ± 11%      -3.5        1.03 ± 39%  perf-profile.children.cycles-pp.smpboot_thread_fn
      4.55 ± 13%      -3.4        1.16 ± 37%  perf-profile.children.cycles-pp.__handle_mm_fault
      5.26 ± 13%      -3.3        1.94 ± 22%  perf-profile.children.cycles-pp.sched_balance_rq
      4.18 ± 11%      -3.3        0.92 ± 41%  perf-profile.children.cycles-pp.bprm_execve
      4.56 ± 15%      -3.1        1.48 ± 24%  perf-profile.children.cycles-pp.__irq_exit_rcu
      4.54 ± 14%      -3.0        1.56 ± 25%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      4.14 ± 13%      -3.0        1.18 ± 29%  perf-profile.children.cycles-pp.tick_nohz_handler
      4.46 ± 14%      -2.9        1.52 ± 26%  perf-profile.children.cycles-pp.update_sd_lb_stats
      3.65 ± 15%      -2.8        0.81 ± 46%  perf-profile.children.cycles-pp.exec_binprm
      3.62 ± 15%      -2.8        0.80 ± 46%  perf-profile.children.cycles-pp.search_binary_handler
      3.64 ±  6%      -2.8        0.82 ± 48%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      4.61 ±  9%      -2.8        1.80 ± 15%  perf-profile.children.cycles-pp.__pick_next_task
      4.73 ± 23%      -2.8        1.96 ± 13%  perf-profile.children.cycles-pp._nohz_idle_balance
      4.03 ± 16%      -2.7        1.30 ± 28%  perf-profile.children.cycles-pp.update_sg_lb_stats
      3.50 ± 15%      -2.7        0.79 ± 47%  perf-profile.children.cycles-pp.load_elf_binary
      4.12 ± 16%      -2.4        1.76 ± 30%  perf-profile.children.cycles-pp.worker_thread
      6.97 ±  8%      -2.4        4.62        perf-profile.children.cycles-pp.__schedule
      3.34 ± 11%      -2.3        1.00 ± 24%  perf-profile.children.cycles-pp.sched_balance_newidle
      2.93 ± 14%      -2.3        0.60 ± 42%  perf-profile.children.cycles-pp.balance_fair
      3.04 ± 12%      -2.3        0.74 ± 49%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      3.00 ± 12%      -2.3        0.73 ± 50%  perf-profile.children.cycles-pp.do_mmap
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.children.cycles-pp.rest_init
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.children.cycles-pp.start_kernel
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.children.cycles-pp.x86_64_start_kernel
      5.34 ± 23%      -2.3        3.07 ± 24%  perf-profile.children.cycles-pp.x86_64_start_reservations
      3.10 ± 10%      -2.1        0.96 ± 36%  perf-profile.children.cycles-pp.x64_sys_call
      2.67 ±  5%      -2.1        0.58 ± 39%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      2.74 ±  9%      -2.1        0.67 ± 50%  perf-profile.children.cycles-pp.__mmap_region
      2.78 ± 12%      -2.0        0.73 ± 45%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      2.78 ± 12%      -2.0        0.73 ± 45%  perf-profile.children.cycles-pp.do_group_exit
      2.95 ± 11%      -2.0        0.90 ± 30%  perf-profile.children.cycles-pp.update_process_times
      2.77 ± 12%      -2.0        0.73 ± 45%  perf-profile.children.cycles-pp.do_exit
      3.61 ± 21%      -2.0        1.64 ± 31%  perf-profile.children.cycles-pp.process_one_work
      2.54 ± 11%      -1.9        0.62 ± 39%  perf-profile.children.cycles-pp.do_pte_missing
      2.36 ±  8%      -1.8        0.52 ± 41%  perf-profile.children.cycles-pp.__sched_setaffinity
      2.38 ± 11%      -1.8        0.56 ± 35%  perf-profile.children.cycles-pp.seq_read_iter
      2.23 ± 11%      -1.8        0.43 ± 37%  perf-profile.children.cycles-pp.readn
      2.45 ± 14%      -1.8        0.66 ± 42%  perf-profile.children.cycles-pp.__mmput
      2.27 ± 11%      -1.8        0.49 ± 42%  perf-profile.children.cycles-pp.setlocale
      2.42 ± 14%      -1.8        0.64 ± 43%  perf-profile.children.cycles-pp.exit_mmap
      2.19 ± 14%      -1.7        0.50 ± 40%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      2.12 ± 17%      -1.6        0.47 ± 39%  perf-profile.children.cycles-pp.kernel_clone
      4.89 ± 12%      -1.6        3.28 ±  2%  perf-profile.children.cycles-pp.schedule
      2.04 ±  9%      -1.6        0.45 ± 43%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      2.06 ± 15%      -1.6        0.50 ± 38%  perf-profile.children.cycles-pp.do_read_fault
      1.89 ± 18%      -1.5        0.37 ± 47%  perf-profile.children.cycles-pp.evsel__read_counter
      2.69 ± 17%      -1.4        1.27 ± 17%  perf-profile.children.cycles-pp.sched_balance_domains
      1.84 ± 16%      -1.4        0.46 ± 38%  perf-profile.children.cycles-pp.filemap_map_pages
      1.91 ± 17%      -1.4        0.54 ± 48%  perf-profile.children.cycles-pp.exit_mm
      1.73 ± 23%      -1.3        0.42 ± 38%  perf-profile.children.cycles-pp.irq_enter_rcu
      2.58 ± 17%      -1.3        1.27 ±  6%  perf-profile.children.cycles-pp.menu_select
      1.66 ± 24%      -1.3        0.41 ± 38%  perf-profile.children.cycles-pp.tick_irq_enter
      1.58 ±  8%      -1.2        0.35 ± 37%  perf-profile.children.cycles-pp.__vfork
      1.51 ± 19%      -1.2        0.30 ± 45%  perf-profile.children.cycles-pp.copy_process
      1.50 ± 24%      -1.2        0.31 ± 73%  perf-profile.children.cycles-pp.irq_work_run_list
      1.49 ± 23%      -1.2        0.30 ± 73%  perf-profile.children.cycles-pp.__sysvec_irq_work
      1.49 ± 23%      -1.2        0.30 ± 73%  perf-profile.children.cycles-pp._printk
      1.49 ± 23%      -1.2        0.30 ± 73%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      1.49 ± 23%      -1.2        0.30 ± 73%  perf-profile.children.cycles-pp.irq_work_run
      1.49 ± 23%      -1.2        0.30 ± 73%  perf-profile.children.cycles-pp.irq_work_single
      1.49 ± 23%      -1.2        0.30 ± 73%  perf-profile.children.cycles-pp.sysvec_irq_work
      1.30 ± 25%      -1.1        0.20 ± 78%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.35 ± 13%      -1.1        2.26 ± 14%  perf-profile.children.cycles-pp.__x64_sys_openat
      3.27 ± 11%      -1.1        2.19 ± 10%  perf-profile.children.cycles-pp.path_openat
      3.29 ± 11%      -1.1        2.22 ± 10%  perf-profile.children.cycles-pp.do_filp_open
      1.51 ± 22%      -1.1        0.45 ± 32%  perf-profile.children.cycles-pp.sched_tick
      1.31 ± 33%      -1.1        0.25 ± 39%  perf-profile.children.cycles-pp.tmigr_handle_remote
      1.39 ± 11%      -1.1        0.34 ± 49%  perf-profile.children.cycles-pp.__mmap_new_vma
      1.33 ± 21%      -1.0        0.30 ± 47%  perf-profile.children.cycles-pp.__open64_nocancel
      1.29 ± 13%      -1.0        0.29 ± 35%  perf-profile.children.cycles-pp.perf_read
      1.26 ± 18%      -1.0        0.27 ± 35%  perf-profile.children.cycles-pp.__x64_sys_vfork
      1.22 ± 34%      -1.0        0.24 ± 41%  perf-profile.children.cycles-pp.tmigr_handle_remote_up
      1.13 ±  8%      -0.9        0.22 ± 35%  perf-profile.children.cycles-pp.perf_evsel__read
      1.15 ± 23%      -0.9        0.24 ± 42%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr_locked
      1.17 ± 13%      -0.9        0.30 ± 54%  perf-profile.children.cycles-pp.elf_load
      1.12 ± 14%      -0.9        0.27 ± 56%  perf-profile.children.cycles-pp._Fork
      1.39 ± 34%      -0.8        0.56 ± 22%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      1.05 ± 22%      -0.8        0.22 ± 39%  perf-profile.children.cycles-pp.__do_set_cpus_allowed
      1.06 ± 16%      -0.8        0.25 ± 61%  perf-profile.children.cycles-pp.pipe_read
      1.03 ± 33%      -0.8        0.22 ± 37%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.97 ± 17%      -0.8        0.20 ± 47%  perf-profile.children.cycles-pp.__lookup_slow
      1.03 ± 20%      -0.8        0.27 ± 50%  perf-profile.children.cycles-pp.unmap_vmas
      1.19 ± 15%      -0.8        0.44 ± 17%  perf-profile.children.cycles-pp.idle_cpu
      0.95 ± 18%      -0.8        0.20 ± 48%  perf-profile.children.cycles-pp.__mmap
      0.93 ± 14%      -0.7        0.19 ± 38%  perf-profile.children.cycles-pp.migration_cpu_stop
      0.94 ± 15%      -0.7        0.20 ± 40%  perf-profile.children.cycles-pp.cpu_stopper_thread
      0.93 ± 14%      -0.7        0.20 ± 59%  perf-profile.children.cycles-pp.alloc_bprm
      0.92 ± 27%      -0.7        0.18 ± 37%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.89 ± 12%      -0.7        0.17 ± 36%  perf-profile.children.cycles-pp.move_queued_task
      0.95 ± 14%      -0.7        0.24 ± 27%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      0.95 ± 14%      -0.7        0.25 ± 27%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.92 ± 21%      -0.7        0.23 ± 28%  perf-profile.children.cycles-pp.begin_new_exec
      0.86 ± 18%      -0.7        0.20 ± 49%  perf-profile.children.cycles-pp.__do_sys_clone
      0.88 ± 37%      -0.7        0.22 ± 30%  perf-profile.children.cycles-pp.do_anonymous_page
      0.85 ± 13%      -0.6        0.20 ± 44%  perf-profile.children.cycles-pp.affine_move_task
      0.92 ± 24%      -0.6        0.29 ± 44%  perf-profile.children.cycles-pp.delay_tsc
      0.82 ± 18%      -0.6        0.19 ± 34%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.80 ± 42%      -0.6        0.17 ± 30%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.81 ± 43%      -0.6        0.18 ± 25%  perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.79 ± 25%      -0.6        0.16 ± 50%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      2.19 ±  9%      -0.6        1.57 ±  8%  perf-profile.children.cycles-pp.enqueue_task
      0.90 ± 22%      -0.6        0.28 ± 42%  perf-profile.children.cycles-pp.next_uptodate_folio
      1.21 ± 22%      -0.6        0.59 ± 32%  perf-profile.children.cycles-pp.rcu_core
      1.17 ± 12%      -0.6        0.56 ± 20%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      1.04 ± 23%      -0.6        0.43 ± 15%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.81 ± 15%      -0.6        0.20 ± 22%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.78 ± 15%      -0.6        0.17 ± 86%  perf-profile.children.cycles-pp.mas_store_prealloc
      1.07 ± 24%      -0.6        0.47 ± 20%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.86 ± 24%      -0.6        0.26 ± 54%  perf-profile.children.cycles-pp.unmap_page_range
      0.74 ± 28%      -0.6        0.15 ± 51%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.82 ± 24%      -0.6        0.24 ± 48%  perf-profile.children.cycles-pp.zap_pmd_range
      3.34 ± 13%      -0.6        2.76 ±  9%  perf-profile.children.cycles-pp.do_sys_openat2
      0.80 ± 22%      -0.6        0.24 ± 45%  perf-profile.children.cycles-pp.zap_pte_range
      0.74 ± 15%      -0.6        0.18 ± 23%  perf-profile.children.cycles-pp.exec_mmap
      0.69 ± 23%      -0.6        0.12 ± 34%  perf-profile.children.cycles-pp.wp_page_copy
      0.71 ± 15%      -0.6        0.15 ± 64%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.81 ± 23%      -0.6        0.26 ± 45%  perf-profile.children.cycles-pp.__split_vma
      1.47 ± 21%      -0.6        0.92 ± 28%  perf-profile.children.cycles-pp.wait_for_lsr
      0.68 ± 30%      -0.5        0.13 ± 36%  perf-profile.children.cycles-pp.seq_read
      0.67 ± 22%      -0.5        0.12 ± 81%  perf-profile.children.cycles-pp.mm_init
      0.77 ± 25%      -0.5        0.24 ± 56%  perf-profile.children.cycles-pp.__mmap_prepare
      0.64 ± 23%      -0.5        0.11 ± 40%  perf-profile.children.cycles-pp.vmstat_start
      0.69 ± 19%      -0.5        0.17 ± 21%  perf-profile.children.cycles-pp.clockevents_program_event
      1.49 ± 23%      -0.5        0.97 ± 28%  perf-profile.children.cycles-pp.serial8250_console_write
      0.64 ± 18%      -0.5        0.14 ± 32%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.64 ± 18%      -0.5        0.14 ± 32%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.70 ± 27%      -0.5        0.19 ± 39%  perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      0.60 ± 34%      -0.5        0.09 ± 72%  perf-profile.children.cycles-pp.tick_do_update_jiffies64
      0.62 ± 11%      -0.5        0.12 ± 36%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.93 ± 11%      -0.5        1.44 ± 10%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.54 ±109%      -0.5        0.05 ±103%  perf-profile.children.cycles-pp.need_update
      0.88 ± 26%      -0.5        0.40 ± 15%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.56 ± 25%      -0.5        0.11 ± 53%  perf-profile.children.cycles-pp.setup_arg_pages
      0.66 ± 22%      -0.5        0.20 ± 40%  perf-profile.children.cycles-pp.zap_present_ptes
      0.81 ± 19%      -0.4        0.36 ± 20%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.56 ± 14%      -0.4        0.12 ± 20%  perf-profile.children.cycles-pp.__cmd_record
      0.56 ± 14%      -0.4        0.12 ± 20%  perf-profile.children.cycles-pp.cmd_record
      0.54 ± 16%      -0.4        0.10 ± 48%  perf-profile.children.cycles-pp.folios_put_refs
      0.74 ± 12%      -0.4        0.30 ± 16%  perf-profile.children.cycles-pp.finish_task_switch
      1.11 ± 19%      -0.4        0.67 ± 11%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.59 ± 17%      -0.4        0.16 ± 33%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.48 ±117%      -0.4        0.06 ± 98%  perf-profile.children.cycles-pp.acpi_os_execute_deferred
      0.62 ± 32%      -0.4        0.20 ± 51%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.54 ± 19%      -0.4        0.12 ± 63%  perf-profile.children.cycles-pp.dup_mm
      0.92 ± 29%      -0.4        0.50 ± 31%  perf-profile.children.cycles-pp.rcu_do_batch
      0.48 ±120%      -0.4        0.06 ± 98%  perf-profile.children.cycles-pp.acpi_ev_asynch_execute_gpe_method
      0.54 ± 16%      -0.4        0.13 ± 60%  perf-profile.children.cycles-pp.d_alloc
      0.76 ± 27%      -0.4        0.35 ± 17%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.54 ± 33%      -0.4        0.14 ± 26%  perf-profile.children.cycles-pp.wait4
      0.57 ± 24%      -0.4        0.16 ± 74%  perf-profile.children.cycles-pp.copy_strings
      0.52 ± 34%      -0.4        0.12 ± 47%  perf-profile.children.cycles-pp.wake_up_new_task
      0.52 ± 14%      -0.4        0.12 ± 34%  perf-profile.children.cycles-pp.fold_vm_zone_numa_events
      0.49 ± 42%      -0.4        0.08 ± 64%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.54 ± 14%      -0.4        0.13 ± 52%  perf-profile.children.cycles-pp.perf_event_read
      0.60 ± 21%      -0.4        0.20 ±  9%  perf-profile.children.cycles-pp.timerqueue_del
      0.46 ±121%      -0.4        0.06 ± 98%  perf-profile.children.cycles-pp.acpi_ns_evaluate
      0.50 ± 33%      -0.4        0.11 ± 46%  perf-profile.children.cycles-pp.dup_task_struct
      0.44 ±125%      -0.4        0.06 ±100%  perf-profile.children.cycles-pp.acpi_ps_execute_method
      0.52 ± 11%      -0.4        0.13 ± 52%  perf-profile.children.cycles-pp.generic_exec_single
      0.47 ± 17%      -0.4        0.08 ± 30%  perf-profile.children.cycles-pp.slab_show
      0.49 ± 10%      -0.4        0.10 ± 54%  perf-profile.children.cycles-pp.__perf_event_read
      0.45 ± 32%      -0.4        0.07 ±118%  perf-profile.children.cycles-pp.pcpu_alloc_noprof
      0.51 ± 12%      -0.4        0.12 ± 50%  perf-profile.children.cycles-pp.smp_call_function_single
      0.54 ± 28%      -0.4        0.16 ± 51%  perf-profile.children.cycles-pp.free_pgtables
      0.50 ± 11%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.get_arg_page
      0.43 ±132%      -0.4        0.06 ±100%  perf-profile.children.cycles-pp.acpi_ps_parse_aml
      0.48 ±  9%      -0.4        0.11 ± 37%  perf-profile.children.cycles-pp.try_address
      0.54 ± 17%      -0.4        0.17 ± 49%  perf-profile.children.cycles-pp.pipe_write
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.__i2c_transfer
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.ast_vga_connector_helper_detect_ctx
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.bit_xfer
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.drm_connector_helper_detect_from_ddc
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.drm_do_probe_ddc_edid
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.drm_helper_probe_detect_ctx
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.drm_probe_ddc
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.i2c_transfer
      0.48 ±  9%      -0.4        0.12 ± 44%  perf-profile.children.cycles-pp.output_poll_execute
      0.52 ± 27%      -0.4        0.16 ± 38%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.48 ± 27%      -0.4        0.12 ± 53%  perf-profile.children.cycles-pp.mprotect_fixup
      0.46 ± 24%      -0.4        0.11 ± 29%  perf-profile.children.cycles-pp.vma_link_file
      0.41 ± 27%      -0.4        0.05 ± 76%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.51 ± 30%      -0.4        0.16 ± 38%  perf-profile.children.cycles-pp.__vm_munmap
      0.51 ± 30%      -0.4        0.16 ± 38%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.42 ± 33%      -0.4        0.08 ± 56%  perf-profile.children.cycles-pp.relocate_vma_down
      0.46 ± 45%      -0.3        0.11 ± 40%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.56 ± 11%      -0.3        0.22 ± 51%  perf-profile.children.cycles-pp.mod_objcg_state
      0.40 ± 19%      -0.3        0.06 ± 52%  perf-profile.children.cycles-pp.set_pte_range
      0.40 ± 42%      -0.3        0.06 ± 17%  perf-profile.children.cycles-pp.__run_timers
      0.46 ± 15%      -0.3        0.12 ± 33%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.44 ± 46%      -0.3        0.10 ± 74%  perf-profile.children.cycles-pp.perf_event_mmap
      0.43 ± 36%      -0.3        0.09 ± 22%  perf-profile.children.cycles-pp.do_wait
      0.43 ± 36%      -0.3        0.09 ± 22%  perf-profile.children.cycles-pp.kernel_wait4
      0.45 ± 14%      -0.3        0.12 ± 35%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.38 ± 43%      -0.3        0.05 ± 75%  perf-profile.children.cycles-pp.strnlen_user
      0.78 ± 19%      -0.3        0.45 ± 13%  perf-profile.children.cycles-pp.update_rq_clock
      0.42 ± 29%      -0.3        0.09 ± 72%  perf-profile.children.cycles-pp.do_open_execat
      0.38 ± 20%      -0.3        0.06 ± 73%  perf-profile.children.cycles-pp._IO_fwrite
      0.38 ±149%      -0.3        0.05 ± 91%  perf-profile.children.cycles-pp.acpi_ps_parse_loop
      0.42 ± 54%      -0.3        0.09 ± 80%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.41 ± 39%      -0.3        0.09 ± 47%  perf-profile.children.cycles-pp.rcu_pending
      0.54 ± 24%      -0.3        0.22 ± 40%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.45 ± 32%      -0.3        0.14 ± 25%  perf-profile.children.cycles-pp.sched_balance_softirq
      0.34 ± 42%      -0.3        0.03 ±102%  perf-profile.children.cycles-pp.create_elf_tables
      0.45 ± 26%      -0.3        0.14 ± 63%  perf-profile.children.cycles-pp.__wait_for_common
      0.40 ± 31%      -0.3        0.09 ± 31%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.38 ± 25%      -0.3        0.07 ± 53%  perf-profile.children.cycles-pp.__queue_work
      0.36 ± 38%      -0.3        0.06 ± 13%  perf-profile.children.cycles-pp.call_timer_fn
      0.38 ± 21%      -0.3        0.08 ± 28%  perf-profile.children.cycles-pp.copy_string_kernel
      0.39 ± 27%      -0.3        0.09 ± 58%  perf-profile.children.cycles-pp.schedule_tail
      0.38 ± 28%      -0.3        0.09 ± 73%  perf-profile.children.cycles-pp.__perf_read_group_add
      0.38 ±  8%      -0.3        0.09 ± 42%  perf-profile.children.cycles-pp.i2c_outb
      0.42 ± 24%      -0.3        0.13 ± 48%  perf-profile.children.cycles-pp.__mmdrop
      0.39 ± 29%      -0.3        0.10 ± 55%  perf-profile.children.cycles-pp.dup_mmap
      0.36 ± 35%      -0.3        0.07 ± 63%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.48 ± 23%      -0.3        0.20 ± 27%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.36 ± 34%      -0.3        0.07 ± 92%  perf-profile.children.cycles-pp.__d_alloc
      0.38 ± 34%      -0.3        0.09 ± 49%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.37 ± 21%      -0.3        0.09 ± 34%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.36 ± 32%      -0.3        0.08 ± 59%  perf-profile.children.cycles-pp.cpu_stop_queue_work
      0.40 ± 22%      -0.3        0.12 ± 46%  perf-profile.children.cycles-pp.cpu_util
      0.35 ± 35%      -0.3        0.07 ± 88%  perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      0.33 ± 39%      -0.3        0.04 ±110%  perf-profile.children.cycles-pp.rmqueue
      0.36 ± 36%      -0.3        0.08 ± 65%  perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.34 ± 28%      -0.3        0.06 ± 68%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.34 ± 23%      -0.3        0.06 ± 79%  perf-profile.children.cycles-pp.seq_printf
      0.36 ± 26%      -0.3        0.09 ± 34%  perf-profile.children.cycles-pp.__get_user_pages
      0.75 ± 22%      -0.3        0.47 ± 14%  perf-profile.children.cycles-pp.update_load_avg
      0.31 ± 35%      -0.3        0.04 ±107%  perf-profile.children.cycles-pp.kick_pool
      0.36 ± 53%      -0.3        0.08 ± 32%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.39 ± 29%      -0.3        0.12 ± 41%  perf-profile.children.cycles-pp.sync_regs
      0.38 ± 34%      -0.3        0.11 ± 60%  perf-profile.children.cycles-pp.vms_clear_ptes
      0.30 ± 32%      -0.3        0.03 ±111%  perf-profile.children.cycles-pp.mas_preallocate
      0.31 ± 46%      -0.3        0.05 ± 79%  perf-profile.children.cycles-pp.evlist__id2sid
      0.38 ± 40%      -0.3        0.12 ± 55%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.66 ± 14%      -0.3        0.40 ± 24%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.39 ± 20%      -0.3        0.14 ± 37%  perf-profile.children.cycles-pp._find_next_and_bit
      0.30 ± 48%      -0.3        0.05 ± 85%  perf-profile.children.cycles-pp.evlist__id2evsel
      0.34 ± 44%      -0.3        0.08 ± 68%  perf-profile.children.cycles-pp.vma_prepare
      0.33 ± 42%      -0.2        0.08 ± 42%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.34 ±  6%      -0.2        0.09 ± 26%  perf-profile.children.cycles-pp.perf_mmap__push
      0.38 ± 32%      -0.2        0.13 ± 48%  perf-profile.children.cycles-pp.show_stat
      0.31 ± 28%      -0.2        0.06 ± 64%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.31 ± 42%      -0.2        0.06 ± 88%  perf-profile.children.cycles-pp.quiet_vmstat
      0.34 ±  6%      -0.2        0.10 ± 22%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.31 ± 44%      -0.2        0.07 ± 98%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.30 ± 48%      -0.2        0.06 ± 90%  perf-profile.children.cycles-pp.mas_split
      0.28 ± 40%      -0.2        0.04 ± 73%  perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      0.32 ± 22%      -0.2        0.08 ± 41%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.40 ± 28%      -0.2        0.16 ± 27%  perf-profile.children.cycles-pp.ct_idle_exit
      0.45 ± 30%      -0.2        0.21 ± 13%  perf-profile.children.cycles-pp.open_last_lookups
      0.34 ± 24%      -0.2        0.11 ± 55%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.30 ± 34%      -0.2        0.07 ± 64%  perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      0.31 ± 34%      -0.2        0.08 ± 20%  perf-profile.children.cycles-pp.__do_wait
      0.28 ± 32%      -0.2        0.06 ± 76%  perf-profile.children.cycles-pp.wake_up_q
      0.31 ± 22%      -0.2        0.08 ± 41%  perf-profile.children.cycles-pp.generic_perform_write
      0.30 ± 33%      -0.2        0.08 ± 18%  perf-profile.children.cycles-pp.rb_next
      0.36 ± 33%      -0.2        0.14 ± 29%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.28 ± 19%      -0.2        0.06 ± 55%  perf-profile.children.cycles-pp.__perf_event_read_value
      0.30 ± 31%      -0.2        0.08 ± 51%  perf-profile.children.cycles-pp.fdget_pos
      0.36 ± 30%      -0.2        0.13 ±  8%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.28 ± 35%      -0.2        0.06 ±134%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.37 ± 35%      -0.2        0.15 ± 27%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.28 ± 28%      -0.2        0.07 ± 77%  perf-profile.children.cycles-pp.vma_modify
      0.28 ± 28%      -0.2        0.07 ± 77%  perf-profile.children.cycles-pp.vma_modify_flags
      0.28 ± 38%      -0.2        0.07 ± 50%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.27 ± 39%      -0.2        0.06 ± 51%  perf-profile.children.cycles-pp.wait_task_zombie
      0.28 ± 43%      -0.2        0.07 ± 77%  perf-profile.children.cycles-pp.dev_attr_show
      0.28 ± 43%      -0.2        0.07 ± 77%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.29 ± 44%      -0.2        0.08 ± 30%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.27 ± 14%      -0.2        0.06 ± 76%  perf-profile.children.cycles-pp.writen
      0.71 ± 16%      -0.2        0.50 ± 13%  perf-profile.children.cycles-pp.enqueue_entity
      0.26 ± 56%      -0.2        0.06 ± 14%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.32 ± 41%      -0.2        0.12 ± 44%  perf-profile.children.cycles-pp.load_elf_interp
      0.26 ± 15%      -0.2        0.06 ± 78%  perf-profile.children.cycles-pp.record__pushfn
      0.23 ± 36%      -0.2        0.03 ±111%  perf-profile.children.cycles-pp.error_entry
      0.34 ± 24%      -0.2        0.14 ± 27%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.25 ± 31%      -0.2        0.05 ± 76%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.38 ± 30%      -0.2        0.18 ± 32%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
      0.27 ± 37%      -0.2        0.07 ± 27%  perf-profile.children.cycles-pp.update_other_load_avgs
      0.25 ± 25%      -0.2        0.06 ± 51%  perf-profile.children.cycles-pp.mas_find
      0.25 ± 34%      -0.2        0.06 ± 97%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.28 ± 31%      -0.2        0.10 ± 62%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.32 ± 29%      -0.2        0.14 ± 28%  perf-profile.children.cycles-pp.should_we_balance
      0.23 ± 41%      -0.2        0.05 ±113%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.21 ± 22%      -0.2        0.03 ±111%  perf-profile.children.cycles-pp.tmigr_cpu_activate
      0.26 ± 41%      -0.2        0.08 ±100%  perf-profile.children.cycles-pp.get_jiffies_update
      0.21 ± 50%      -0.2        0.03 ±103%  perf-profile.children.cycles-pp.lru_add_drain
      0.26 ± 23%      -0.2        0.09 ± 24%  perf-profile.children.cycles-pp.get_cpu_device
      0.22 ± 43%      -0.2        0.04 ± 73%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.21 ± 20%      -0.2        0.04 ±111%  perf-profile.children.cycles-pp.sclhi
      0.21 ± 48%      -0.2        0.04 ±118%  perf-profile.children.cycles-pp.check_cpu_stall
      0.20 ± 25%      -0.2        0.03 ±101%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.26 ± 31%      -0.2        0.09 ± 43%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.20 ± 37%      -0.2        0.04 ±118%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.21 ± 60%      -0.2        0.05 ±114%  perf-profile.children.cycles-pp.__get_unmapped_area
      0.55 ± 17%      -0.2        0.38 ± 10%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.22 ± 31%      -0.2        0.06 ± 68%  perf-profile.children.cycles-pp.__do_fault
      0.22 ± 37%      -0.2        0.07 ± 94%  perf-profile.children.cycles-pp.irqentry_enter
      0.20 ± 63%      -0.2        0.05 ±114%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.22 ± 44%      -0.2        0.06 ± 49%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.21 ± 35%      -0.2        0.06 ±125%  perf-profile.children.cycles-pp.force_qs_rnp
      0.33 ± 16%      -0.1        0.18 ± 19%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.19 ± 37%      -0.1        0.04 ±116%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.18 ± 64%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.20 ± 37%      -0.1        0.06 ± 76%  perf-profile.children.cycles-pp.mas_walk
      0.19 ± 49%      -0.1        0.05 ± 51%  perf-profile.children.cycles-pp.release_task
      0.18 ± 27%      -0.1        0.05 ± 80%  perf-profile.children.cycles-pp.arch_scale_cpu_capacity
      0.22 ± 30%      -0.1        0.09 ± 48%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.25 ± 33%      -0.1        0.12 ± 17%  perf-profile.children.cycles-pp.mutex_unlock
      0.16 ± 38%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.vm_area_dup
      0.22 ± 27%      -0.1        0.10 ± 31%  perf-profile.children.cycles-pp.__get_user_8
      0.23 ± 21%      -0.1        0.11 ± 12%  perf-profile.children.cycles-pp.up_write
      0.16 ± 24%      -0.1        0.06 ± 48%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.14 ± 19%      -0.1        0.05 ± 76%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.12 ± 51%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.12 ± 48%      -0.1        0.04 ± 75%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.10 ± 45%      -0.1        0.04 ±106%  perf-profile.children.cycles-pp.free_unref_page
      0.04 ± 70%      +0.0        0.08 ± 20%  perf-profile.children.cycles-pp.fdget
      0.02 ±142%      +0.1        0.07 ± 24%  perf-profile.children.cycles-pp.security_inode_getattr
      0.02 ±141%      +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.mntput_no_expire
      0.01 ±223%      +0.1        0.06 ± 24%  perf-profile.children.cycles-pp.path_parentat
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.fsp_get_pathref_fd
      0.02 ±141%      +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.check_stack_object
      0.01 ±223%      +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.__filename_parentat
      0.00            +0.1        0.07 ± 22%  perf-profile.children.cycles-pp.openat_pathref_dirfsp_nosymlink
      0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.rep_memset_s
      0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.allocate_buffers
      0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.d_hash_and_lookup
      0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.dequeue_mid
      0.00            +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.iov_buf
      0.00            +0.1        0.07 ± 24%  perf-profile.children.cycles-pp.ndr_pull_xattr_DosInfo
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.cifs_d_revalidate
      0.07 ± 61%      +0.1        0.14 ± 32%  perf-profile.children.cycles-pp.filp_flush
      0.00            +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.next_codepoint
      0.00            +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.talloc_strdup
      0.00            +0.1        0.08 ± 25%  perf-profile.children.cycles-pp._tevent_loop_once
      0.01 ±223%      +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.security_inode_permission
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.__tls_get_addr
      0.03 ±150%      +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.08 ± 35%  perf-profile.children.cycles-pp._talloc_set_destructor@plt
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.btrfs_cow_block
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.btrfs_force_cow_block
      0.00            +0.1        0.08 ± 31%  perf-profile.children.cycles-pp.filename_convert_dirfsp
      0.00            +0.1        0.08 ± 27%  perf-profile.children.cycles-pp._talloc_steal_loc
      0.00            +0.1        0.08 ± 25%  perf-profile.children.cycles-pp.remove_smb2_chained_fsp
      0.00            +0.1        0.08 ± 34%  perf-profile.children.cycles-pp.ndr_push_uint16
      0.00            +0.1        0.08 ± 32%  perf-profile.children.cycles-pp.messaging_server_id
      0.02 ±141%      +0.1        0.10 ± 25%  perf-profile.children.cycles-pp.__errno_location
      0.00            +0.1        0.08 ± 37%  perf-profile.children.cycles-pp.talloc_named_const
      0.00            +0.1        0.09 ± 18%  perf-profile.children.cycles-pp._raw_read_lock_irqsave
      0.02 ±142%      +0.1        0.11 ± 22%  perf-profile.children.cycles-pp.cpus_share_cache
      0.01 ±223%      +0.1        0.10 ± 20%  perf-profile.children.cycles-pp.list_lru_del_obj
      0.00            +0.1        0.09 ± 33%  perf-profile.children.cycles-pp.cifs_handle_standard
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.evict_refill_and_join
      0.00            +0.1        0.09 ± 25%  perf-profile.children.cycles-pp.readdir64
      0.00            +0.1        0.09 ± 34%  perf-profile.children.cycles-pp.cifs_compound_callback
      0.00            +0.1        0.09 ± 28%  perf-profile.children.cycles-pp.task_dump_owner
      0.00            +0.1        0.10 ± 24%  perf-profile.children.cycles-pp.getgroups
      0.00            +0.1        0.10 ± 23%  perf-profile.children.cycles-pp.inode_get_bytes
      0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp.cifs_small_buf_get
      0.00            +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.tcp_current_mss
      0.04 ± 71%      +0.1        0.14 ± 27%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.00            +0.1        0.10 ± 47%  perf-profile.children.cycles-pp.unlock_up
      0.01 ±223%      +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.d_lru_del
      0.00            +0.1        0.10 ± 19%  perf-profile.children.cycles-pp.btrfs_tree_read_lock_nested
      0.00            +0.1        0.10 ± 21%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_skmem
      0.03 ±152%      +0.1        0.13 ± 32%  perf-profile.children.cycles-pp.__mod_timer
      0.02 ±142%      +0.1        0.12 ± 48%  perf-profile.children.cycles-pp.putname
      0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp._talloc_get_type_abort@plt
      0.01 ±223%      +0.1        0.11 ± 31%  perf-profile.children.cycles-pp.generic_fillattr
      0.00            +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.smbd_smb2_request_process_query_directory
      0.00            +0.1        0.10 ± 35%  perf-profile.children.cycles-pp.__skb_clone
      0.00            +0.1        0.10 ± 50%  perf-profile.children.cycles-pp.btrfs_destroy_inode
      0.00            +0.1        0.11 ± 20%  perf-profile.children.cycles-pp.ndr_pull_align
      0.00            +0.1        0.11 ± 23%  perf-profile.children.cycles-pp.release_extent_buffer
      0.00            +0.1        0.11 ± 20%  perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      0.00            +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.vfs_stat_fsp
      0.00            +0.1        0.11 ± 26%  perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
      0.00            +0.1        0.11 ± 47%  perf-profile.children.cycles-pp.btrfs_delete_delayed_dir_index
      0.00            +0.1        0.11 ± 35%  perf-profile.children.cycles-pp.inet6_csk_route_socket
      0.00            +0.1        0.11 ± 32%  perf-profile.children.cycles-pp.alloc_skb_with_frags
      0.00            +0.1        0.11 ± 34%  perf-profile.children.cycles-pp.ndr_pull_uint32
      0.00            +0.1        0.11 ± 25%  perf-profile.children.cycles-pp.wake_affine
      0.00            +0.1        0.11 ± 21%  perf-profile.children.cycles-pp.memset@plt
      0.00            +0.1        0.11 ± 32%  perf-profile.children.cycles-pp.tid_fd_revalidate
      0.09 ± 76%      +0.1        0.20 ± 15%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.00            +0.1        0.11 ± 22%  perf-profile.children.cycles-pp.btrfs_opendir
      0.00            +0.1        0.12 ± 33%  perf-profile.children.cycles-pp.next_codepoint_handle_ext
      0.05 ± 84%      +0.1        0.16 ± 33%  perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.00            +0.1        0.12 ± 29%  perf-profile.children.cycles-pp.synthetic_smb_fname
      0.00            +0.1        0.12 ± 37%  perf-profile.children.cycles-pp.tcp_check_space
      0.00            +0.1        0.12 ± 29%  perf-profile.children.cycles-pp.convert_string_error_handle
      0.00            +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.free_extent_buffer
      0.00            +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.__kfree_skb
      0.00            +0.1        0.12 ± 34%  perf-profile.children.cycles-pp.tcp_send_mss
      0.00            +0.1        0.12 ± 38%  perf-profile.children.cycles-pp.pid_revalidate
      0.06 ± 81%      +0.1        0.18 ± 31%  perf-profile.children.cycles-pp.generic_permission
      0.00            +0.1        0.12 ± 54%  perf-profile.children.cycles-pp.vfs_getxattr
      0.07 ± 57%      +0.1        0.19 ± 29%  perf-profile.children.cycles-pp.__kmalloc_cache_noprof
      0.00            +0.1        0.12 ± 43%  perf-profile.children.cycles-pp.__build_path_from_dentry_optional_prefix
      0.00            +0.1        0.12 ± 17%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.01 ±223%      +0.1        0.13 ± 37%  perf-profile.children.cycles-pp.fdget_raw
      0.00            +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.messaging_send_iov_from
      0.00            +0.1        0.12 ± 40%  perf-profile.children.cycles-pp.next_codepoint_handle
      0.00            +0.1        0.12 ± 25%  perf-profile.children.cycles-pp.smbd_dirptr_get_entry
      0.00            +0.1        0.13 ± 51%  perf-profile.children.cycles-pp.init_stat_ex_from_stat
      0.00            +0.1        0.13 ± 33%  perf-profile.children.cycles-pp.SMB2_open_init
      0.00            +0.1        0.13 ± 24%  perf-profile.children.cycles-pp.btrfs_get_16
      0.00            +0.1        0.13 ± 27%  perf-profile.children.cycles-pp.utf8_to_utf32
      0.00            +0.1        0.13 ± 24%  perf-profile.children.cycles-pp.__btrfs_release_delayed_node
      0.00            +0.1        0.13 ± 17%  perf-profile.children.cycles-pp.btrfs_get_32
      0.00            +0.1        0.13 ± 29%  perf-profile.children.cycles-pp.smb2_setup_request
      0.00            +0.1        0.13 ± 36%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
      0.00            +0.1        0.13 ± 26%  perf-profile.children.cycles-pp.__btrfs_end_transaction
      0.00            +0.1        0.13 ± 38%  perf-profile.children.cycles-pp.sk_reset_timer
      0.00            +0.1        0.13 ± 25%  perf-profile.children.cycles-pp.skb_page_frag_refill
      0.00            +0.1        0.14 ± 45%  perf-profile.children.cycles-pp.btrfs_del_orphan_item
      0.00            +0.1        0.14 ± 26%  perf-profile.children.cycles-pp.getegid
      0.00            +0.1        0.14 ± 35%  perf-profile.children.cycles-pp.path_put
      0.00            +0.1        0.14 ± 23%  perf-profile.children.cycles-pp.proc_fd_link
      0.00            +0.1        0.14 ± 23%  perf-profile.children.cycles-pp.__smb2_plain_req_init
      0.00            +0.1        0.14 ± 15%  perf-profile.children.cycles-pp._talloc_array
      0.00            +0.1        0.14 ± 35%  perf-profile.children.cycles-pp.smb2_reconnect
      0.00            +0.1        0.14 ± 27%  perf-profile.children.cycles-pp.mem_cgroup_charge_skmem
      0.00            +0.1        0.14 ± 23%  perf-profile.children.cycles-pp.sk_page_frag_refill
      0.00            +0.1        0.14 ± 25%  perf-profile.children.cycles-pp._talloc_memdup
      0.00            +0.1        0.14 ± 19%  perf-profile.children.cycles-pp.btrfs_lookup_inode
      0.00            +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.file_free
      0.00            +0.1        0.15 ± 19%  perf-profile.children.cycles-pp.__smb2_find_mid
      0.00            +0.1        0.15 ± 25%  perf-profile.children.cycles-pp.ndr_pull_udlong
      0.00            +0.1        0.15 ± 37%  perf-profile.children.cycles-pp.ndr_push_udlong
      0.00            +0.1        0.15 ± 26%  perf-profile.children.cycles-pp.smbd_smb2_request_done_ex
      0.00            +0.1        0.15 ± 23%  perf-profile.children.cycles-pp.close_file_smb
      0.00            +0.2        0.15 ± 32%  perf-profile.children.cycles-pp.__do_sys_getcwd
      0.00            +0.2        0.15 ± 23%  perf-profile.children.cycles-pp._nettle_chacha_core
      0.00            +0.2        0.15 ± 31%  perf-profile.children.cycles-pp.ndr_push_uint8
      0.10 ± 69%      +0.2        0.25 ± 28%  perf-profile.children.cycles-pp.cfree
      0.00            +0.2        0.16 ± 20%  perf-profile.children.cycles-pp.cifs_prime_dcache
      0.00            +0.2        0.16 ± 24%  perf-profile.children.cycles-pp.smbd_smb2_request_process_create
      0.07 ± 55%      +0.2        0.22 ± 38%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.00            +0.2        0.16 ± 17%  perf-profile.children.cycles-pp.tcp_event_new_data_sent
      0.00            +0.2        0.16 ± 13%  perf-profile.children.cycles-pp.tdb_parse_record
      0.14 ± 47%      +0.2        0.30 ± 31%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.02 ±141%      +0.2        0.18 ± 28%  perf-profile.children.cycles-pp.destroy_inode
      0.00            +0.2        0.16 ± 20%  perf-profile.children.cycles-pp._talloc_set_destructor
      0.00            +0.2        0.16 ± 14%  perf-profile.children.cycles-pp.try_to_unlazy_next
      0.00            +0.2        0.16 ± 33%  perf-profile.children.cycles-pp.ndr_push_expand
      0.00            +0.2        0.17 ± 35%  perf-profile.children.cycles-pp.__import_iovec
      0.00            +0.2        0.17 ± 28%  perf-profile.children.cycles-pp._talloc_pooled_object
      0.00            +0.2        0.17 ± 28%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      0.04 ±115%      +0.2        0.20 ± 14%  perf-profile.children.cycles-pp.select_idle_sibling
      0.11 ± 56%      +0.2        0.27 ± 20%  perf-profile.children.cycles-pp.llist_reverse_order
      0.00            +0.2        0.17 ± 30%  perf-profile.children.cycles-pp._talloc_tos
      0.00            +0.2        0.17 ± 19%  perf-profile.children.cycles-pp.btrfs_lookup_dir_item
      0.12 ± 70%      +0.2        0.29 ± 16%  perf-profile.children.cycles-pp.path_init
      0.03 ±150%      +0.2        0.20 ± 17%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.00            +0.2        0.17 ± 18%  perf-profile.children.cycles-pp.__unix_dgram_recvmsg
      0.00            +0.2        0.17 ± 17%  perf-profile.children.cycles-pp.available_idle_cpu
      0.00            +0.2        0.17 ± 44%  perf-profile.children.cycles-pp.smbd_dirptr_lanman2_entry
      0.00            +0.2        0.17 ± 29%  perf-profile.children.cycles-pp.btrfs_match_dir_item_name
      0.01 ±223%      +0.2        0.18 ± 34%  perf-profile.children.cycles-pp.memcpy@plt
      0.00            +0.2        0.18 ± 25%  perf-profile.children.cycles-pp.geteuid
      0.00            +0.2        0.18 ± 36%  perf-profile.children.cycles-pp.import_iovec
      0.00            +0.2        0.18 ± 18%  perf-profile.children.cycles-pp._talloc_zero
      0.00            +0.2        0.18 ± 22%  perf-profile.children.cycles-pp.cp_smb_filename
      0.00            +0.2        0.18 ± 55%  perf-profile.children.cycles-pp.napi_consume_skb
      0.00            +0.2        0.18 ± 41%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.00            +0.2        0.18 ± 31%  perf-profile.children.cycles-pp.loopback_xmit
      0.00            +0.2        0.19 ± 19%  perf-profile.children.cycles-pp.skb_attempt_defer_free
      0.00            +0.2        0.19 ± 34%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.00            +0.2        0.19 ± 41%  perf-profile.children.cycles-pp.tcp_rcv_space_adjust
      0.15 ± 18%      +0.2        0.35 ± 20%  perf-profile.children.cycles-pp.user_path_at
      0.08 ±104%      +0.2        0.27 ± 16%  perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.2        0.20 ± 33%  perf-profile.children.cycles-pp.ndr_push_uint32
      0.02 ±142%      +0.2        0.22 ± 26%  perf-profile.children.cycles-pp.sprintf
      0.00            +0.2        0.20 ± 21%  perf-profile.children.cycles-pp.read_extent_buffer
      0.00            +0.2        0.20 ± 47%  perf-profile.children.cycles-pp.memmove_extent_buffer
      0.27 ± 42%      +0.2        0.48 ± 13%  perf-profile.children.cycles-pp.select_task_rq
      0.00            +0.2        0.20 ± 21%  perf-profile.children.cycles-pp.btrfs_free_path
      0.00            +0.2        0.20 ±  7%  perf-profile.children.cycles-pp.btrfs_dirty_inode
      0.16 ± 23%      +0.2        0.38 ± 31%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.00            +0.2        0.22 ± 18%  perf-profile.children.cycles-pp.cifs_filldir
      0.00            +0.2        0.22 ± 28%  perf-profile.children.cycles-pp.lock_sock_nested
      0.00            +0.2        0.22 ± 23%  perf-profile.children.cycles-pp.btrfs_update_inode
      0.00            +0.2        0.22 ± 25%  perf-profile.children.cycles-pp.debuglevel_get_class@plt
      0.00            +0.2        0.23 ± 27%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      0.00            +0.2        0.23 ± 19%  perf-profile.children.cycles-pp.btrfs_set_token_32
      0.00            +0.2        0.23 ± 32%  perf-profile.children.cycles-pp.fgetxattr
      0.00            +0.2        0.24 ± 14%  perf-profile.children.cycles-pp.find_extent_buffer_nolock
      0.00            +0.2        0.24 ± 24%  perf-profile.children.cycles-pp.__alloc_skb
      0.00            +0.2        0.24 ± 24%  perf-profile.children.cycles-pp.tevent_common_invoke_fd_handler
      0.08 ± 57%      +0.2        0.32 ± 20%  perf-profile.children.cycles-pp._copy_to_user
      0.00            +0.2        0.24 ± 23%  perf-profile.children.cycles-pp.btrfs_get_token_32
      0.00            +0.2        0.24 ± 32%  perf-profile.children.cycles-pp.sock_poll
      0.00            +0.2        0.24 ± 29%  perf-profile.children.cycles-pp.getcwd
      0.00            +0.3        0.25 ± 13%  perf-profile.children.cycles-pp.__libc_fcntl64
      0.06 ±115%      +0.3        0.31 ± 16%  perf-profile.children.cycles-pp.complete_walk
      0.07 ±108%      +0.3        0.32 ± 14%  perf-profile.children.cycles-pp.vfs_fstat
      0.00            +0.3        0.26 ± 11%  perf-profile.children.cycles-pp.cifsConvertToUTF16
      0.00            +0.3        0.26 ± 17%  perf-profile.children.cycles-pp.start_transaction
      0.00            +0.3        0.26 ± 14%  perf-profile.children.cycles-pp.__inet6_lookup_established
      0.04 ±165%      +0.3        0.30 ± 11%  perf-profile.children.cycles-pp._copy_from_iter
      0.00            +0.3        0.26 ± 24%  perf-profile.children.cycles-pp.messaging_send_iov
      0.04 ±115%      +0.3        0.30 ± 21%  perf-profile.children.cycles-pp.proc_self_get_link
      0.00            +0.3        0.26 ± 19%  perf-profile.children.cycles-pp.release_sock
      0.00            +0.3        0.26 ± 22%  perf-profile.children.cycles-pp.proc_pid_get_link
      0.00            +0.3        0.27 ± 29%  perf-profile.children.cycles-pp.btrfs_insert_orphan_item
      0.00            +0.3        0.27 ± 18%  perf-profile.children.cycles-pp.simple_copy_to_iter
      0.00            +0.3        0.28 ± 33%  perf-profile.children.cycles-pp.skb_release_data
      0.00            +0.3        0.28 ± 16%  perf-profile.children.cycles-pp.__inet6_lookup_skb
      0.00            +0.3        0.28 ± 29%  perf-profile.children.cycles-pp.btrfs_orphan_add
      0.00            +0.3        0.28 ± 24%  perf-profile.children.cycles-pp._talloc_get_type_abort
      0.00            +0.3        0.28 ± 20%  perf-profile.children.cycles-pp.btrfs_release_path
      0.29 ± 29%      +0.3        0.57 ± 17%  perf-profile.children.cycles-pp.check_heap_object
      0.00            +0.3        0.30 ± 31%  perf-profile.children.cycles-pp.copy_msghdr_from_user
      0.00            +0.3        0.30 ± 16%  perf-profile.children.cycles-pp.smbd_smb2_request_dispatch
      0.00            +0.3        0.30 ± 12%  perf-profile.children.cycles-pp.skb_do_copy_data_nocache
      0.00            +0.3        0.31 ± 17%  perf-profile.children.cycles-pp.posix_lock_inode
      0.00            +0.3        0.31 ± 29%  perf-profile.children.cycles-pp.tcp_stream_alloc_skb
      0.00            +0.3        0.31 ± 29%  perf-profile.children.cycles-pp.__do_sys_setgroups
      0.00            +0.3        0.32 ± 26%  perf-profile.children.cycles-pp._talloc_free
      0.00            +0.3        0.32 ± 14%  perf-profile.children.cycles-pp.btrfs_getattr
      0.40 ± 41%      +0.3        0.73 ±  9%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.25 ± 51%      +0.3        0.58 ± 13%  perf-profile.children.cycles-pp.schedule_timeout
      0.04 ±109%      +0.3        0.37 ± 26%  perf-profile.children.cycles-pp.__x64_sys_chdir
      0.00            +0.3        0.34 ± 16%  perf-profile.children.cycles-pp.find_extent_buffer
      0.08 ± 66%      +0.3        0.43 ± 34%  perf-profile.children.cycles-pp.poll_idle
      0.17 ± 45%      +0.3        0.52 ±  9%  perf-profile.children.cycles-pp.inode_permission
      0.00            +0.3        0.35 ± 30%  perf-profile.children.cycles-pp.ep_item_poll
      0.02 ±142%      +0.3        0.37 ± 24%  perf-profile.children.cycles-pp.cp_new_stat
      0.01 ±223%      +0.4        0.36 ± 12%  perf-profile.children.cycles-pp.vfs_statx_path
      0.10 ± 93%      +0.4        0.45 ± 21%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.4        0.37 ± 24%  perf-profile.children.cycles-pp.tdb_jenkins_hash
      0.28 ± 34%      +0.4        0.66 ±  9%  perf-profile.children.cycles-pp.malloc
      0.00            +0.4        0.40 ± 31%  perf-profile.children.cycles-pp.btrfs_bin_search
      0.00            +0.4        0.42 ± 29%  perf-profile.children.cycles-pp.memcpy_extent_buffer
      0.00            +0.4        0.43 ± 17%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.00            +0.4        0.44 ± 14%  perf-profile.children.cycles-pp.fcntl_setlk
      0.01 ±223%      +0.4        0.45 ± 17%  perf-profile.children.cycles-pp.ep_autoremove_wake_function
      0.00            +0.4        0.45 ± 16%  perf-profile.children.cycles-pp.debuglevel_get_class
      0.44 ± 27%      +0.5        0.90 ± 10%  perf-profile.children.cycles-pp.__check_object_size
      0.00            +0.5        0.46 ± 22%  perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      0.00            +0.5        0.47 ± 16%  perf-profile.children.cycles-pp.cifs_strndup_to_utf16
      0.00            +0.5        0.48 ± 16%  perf-profile.children.cycles-pp.cifs_convert_path_to_utf16
      0.00            +0.5        0.48 ± 24%  perf-profile.children.cycles-pp.unix_dgram_sendmsg
      0.29 ± 42%      +0.5        0.77 ± 11%  perf-profile.children.cycles-pp.strncpy_from_user
      0.00            +0.5        0.49 ± 21%  perf-profile.children.cycles-pp.btrfs_truncate_inode_items
      0.00            +0.5        0.50 ± 12%  perf-profile.children.cycles-pp.do_fcntl
      0.00            +0.5        0.50 ± 17%  perf-profile.children.cycles-pp.wait_woken
      0.00            +0.5        0.50 ± 15%  perf-profile.children.cycles-pp.btrfs_listxattr
      0.00            +0.5        0.51 ± 21%  perf-profile.children.cycles-pp.standard_receive3
      0.00            +0.5        0.52 ± 22%  perf-profile.children.cycles-pp.chdir
      0.19 ± 26%      +0.5        0.71 ± 15%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.82 ± 29%      +0.5        1.35 ± 12%  perf-profile.children.cycles-pp.try_to_block_task
      0.00            +0.5        0.54 ± 14%  perf-profile.children.cycles-pp.__wake_up_sync
      0.00            +0.5        0.54 ± 21%  perf-profile.children.cycles-pp.__do_sys_openat2
      0.02 ±223%      +0.6        0.57 ± 14%  perf-profile.children.cycles-pp.__x64_sys_fcntl
      0.00            +0.6        0.58 ± 25%  perf-profile.children.cycles-pp.read_block_for_search
      0.00            +0.6        0.60 ± 13%  perf-profile.children.cycles-pp.__memmove
      0.00            +0.6        0.60 ± 26%  perf-profile.children.cycles-pp.ep_send_events
      0.00            +0.6        0.61 ± 20%  perf-profile.children.cycles-pp.btrfs_real_readdir
      0.35 ± 31%      +0.6        0.98 ± 16%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.00            +0.6        0.64 ± 26%  perf-profile.children.cycles-pp.__write_extent_buffer
      0.70 ± 26%      +0.6        1.34 ±  5%  perf-profile.children.cycles-pp.lookup_fast
      0.00            +0.6        0.65 ± 12%  perf-profile.children.cycles-pp.__btrfs_update_delayed_inode
      0.40 ± 34%      +0.7        1.05 ±  9%  perf-profile.children.cycles-pp.getname_flags
      0.56 ± 34%      +0.7        1.23 ±  5%  perf-profile.children.cycles-pp.step_into
      0.00            +0.7        0.67 ± 16%  perf-profile.children.cycles-pp.sk_wait_data
      0.01 ±223%      +0.7        0.68 ± 10%  perf-profile.children.cycles-pp.ep_poll_callback
      0.00            +0.7        0.70 ± 21%  perf-profile.children.cycles-pp.tcp_ack
      0.00            +0.7        0.72 ± 20%  perf-profile.children.cycles-pp.wait_for_response
      0.00            +0.7        0.72 ± 37%  perf-profile.children.cycles-pp.devkmsg_emit
      0.00            +0.7        0.72 ± 37%  perf-profile.children.cycles-pp.devkmsg_write
      0.18 ± 50%      +0.7        0.92 ± 10%  perf-profile.children.cycles-pp.pick_link
      0.00            +0.7        0.74 ± 13%  perf-profile.children.cycles-pp.sock_sendmsg
      0.00            +0.8        0.75 ± 12%  perf-profile.children.cycles-pp.btrfs_commit_inode_delayed_inode
      0.00            +0.8        0.75 ± 13%  perf-profile.children.cycles-pp.smb_send_kvec
      0.00            +0.8        0.78 ± 13%  perf-profile.children.cycles-pp.__skb_datagram_iter
      0.87 ± 23%      +0.8        1.65 ±  7%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.8        0.80 ± 13%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      0.00            +0.8        0.81 ± 27%  perf-profile.children.cycles-pp.btrfs_lookup_xattr
      0.24 ± 45%      +0.9        1.16 ±  5%  perf-profile.children.cycles-pp.__wake_up_common
      1.06 ± 12%      +0.9        1.99 ±  7%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.25 ± 31%      +1.0        1.22 ±  8%  perf-profile.children.cycles-pp.__wake_up_sync_key
      0.00            +1.0        1.03 ± 12%  perf-profile.children.cycles-pp.__btrfs_unlink_inode
      0.54 ± 35%      +1.1        1.62 ±  6%  perf-profile.children.cycles-pp.vfs_statx
      0.00            +1.1        1.08 ± 25%  perf-profile.children.cycles-pp.btrfs_getxattr
      0.00            +1.1        1.09 ± 13%  perf-profile.children.cycles-pp.__SMB2_close
      0.00            +1.1        1.12 ± 14%  perf-profile.children.cycles-pp.cifs_closedir
      0.00            +1.1        1.15 ± 13%  perf-profile.children.cycles-pp.SMB2_query_directory
      0.00            +1.2        1.16 ± 23%  perf-profile.children.cycles-pp.__vfs_getxattr
      0.00            +1.2        1.17 ± 13%  perf-profile.children.cycles-pp.find_cifs_entry
      0.00            +1.2        1.18 ±  9%  perf-profile.children.cycles-pp.____sys_recvmsg
      0.00            +1.2        1.18 ± 16%  perf-profile.children.cycles-pp.syscall
      0.00            +1.2        1.18 ±  9%  perf-profile.children.cycles-pp.sock_def_readable
      0.00            +1.3        1.28 ± 10%  perf-profile.children.cycles-pp.path_listxattrat
      0.00            +1.3        1.35 ±  9%  perf-profile.children.cycles-pp.___sys_recvmsg
      0.00            +1.4        1.38 ±  8%  perf-profile.children.cycles-pp.btrfs_del_items
      0.00            +1.4        1.39 ±  8%  perf-profile.children.cycles-pp.__sys_recvmsg
      0.02 ±141%      +1.4        1.43 ± 26%  perf-profile.children.cycles-pp.schedule_hrtimeout_range
      0.12 ± 63%      +1.5        1.63 ± 10%  perf-profile.children.cycles-pp.__close_nocancel
      0.00            +1.5        1.53 ± 21%  perf-profile.children.cycles-pp.do_getxattr
      0.67 ± 34%      +1.6        2.22 ±  5%  perf-profile.children.cycles-pp.vfs_fstatat
      0.00            +1.6        1.57 ± 10%  perf-profile.children.cycles-pp.smb2_query_dir_first
      0.00            +1.6        1.59 ± 10%  perf-profile.children.cycles-pp._initiate_cifs_search
      0.00            +1.6        1.61 ± 10%  perf-profile.children.cycles-pp.recvmsg
      0.00            +1.6        1.63 ± 18%  perf-profile.children.cycles-pp.btrfs_search_slot
      0.00            +1.7        1.66 ± 13%  perf-profile.children.cycles-pp.btrfs_rmdir
      0.00            +1.7        1.73 ±  8%  perf-profile.children.cycles-pp.btrfs_evict_inode
      0.00            +1.7        1.74 ±  9%  perf-profile.children.cycles-pp.smb2_rmdir
      0.00            +1.8        1.76 ± 10%  perf-profile.children.cycles-pp.smb2_compound_op
      0.00            +1.8        1.80 ± 10%  perf-profile.children.cycles-pp.cifs_rmdir
      0.00            +1.8        1.82 ± 13%  perf-profile.children.cycles-pp.openat64
      0.02 ±223%      +1.9        1.89 ±  8%  perf-profile.children.cycles-pp.evict
      0.00            +1.9        1.91 ± 14%  perf-profile.children.cycles-pp.cifs_readv_from_socket
      0.26 ± 73%      +1.9        2.18 ±  7%  perf-profile.children.cycles-pp.__dentry_kill
      0.00            +2.0        1.95 ± 14%  perf-profile.children.cycles-pp.cifs_read_from_socket
      0.00            +2.0        1.99 ± 11%  perf-profile.children.cycles-pp.listxattr
      0.00            +2.1        2.06 ± 12%  perf-profile.children.cycles-pp.cifs_send_recv
      0.00            +2.1        2.14 ± 12%  perf-profile.children.cycles-pp.tcp_rcv_established
      0.00            +2.2        2.15 ± 12%  perf-profile.children.cycles-pp.tcp_v6_do_rcv
      0.76 ± 30%      +2.2        2.93 ±  7%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.01 ±223%      +2.2        2.19 ± 25%  perf-profile.children.cycles-pp.ep_poll
      0.46 ± 32%      +2.2        2.65 ±  6%  perf-profile.children.cycles-pp.dput
      0.01 ±223%      +2.2        2.26 ± 25%  perf-profile.children.cycles-pp.do_epoll_wait
      0.00            +2.3        2.31 ± 10%  perf-profile.children.cycles-pp.tcp_sock_set_cork
      0.01 ±223%      +2.3        2.34 ± 25%  perf-profile.children.cycles-pp.__x64_sys_epoll_wait
      0.00            +2.4        2.36 ± 13%  perf-profile.children.cycles-pp.tcp_recvmsg_locked
      0.00            +2.6        2.56 ± 11%  perf-profile.children.cycles-pp.tcp_recvmsg
      0.00            +2.6        2.58 ± 11%  perf-profile.children.cycles-pp.inet6_recvmsg
      0.00            +2.6        2.62 ± 11%  perf-profile.children.cycles-pp.tcp_v6_rcv
      0.21 ± 29%      +2.7        2.89 ±  8%  perf-profile.children.cycles-pp.__close
      0.00            +2.7        2.68 ± 12%  perf-profile.children.cycles-pp.ip6_protocol_deliver_rcu
      0.00            +2.7        2.69 ± 12%  perf-profile.children.cycles-pp.ip6_input_finish
      0.00            +2.7        2.72 ± 14%  perf-profile.children.cycles-pp.cifs_demultiplex_thread
      0.74 ± 34%      +2.8        3.53 ±  6%  perf-profile.children.cycles-pp.filename_lookup
      0.00            +2.8        2.79 ± 10%  perf-profile.children.cycles-pp.sock_recvmsg
      0.00            +2.8        2.80 ± 12%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      0.02 ±141%      +2.8        2.84 ± 12%  perf-profile.children.cycles-pp.__napi_poll
      0.00            +2.8        2.84 ± 12%  perf-profile.children.cycles-pp.process_backlog
      0.03 ±150%      +2.8        2.86 ± 22%  perf-profile.children.cycles-pp.epoll_wait
      0.00            +3.0        2.99 ± 13%  perf-profile.children.cycles-pp.filename_getxattr
      0.00            +3.1        3.14 ± 10%  perf-profile.children.cycles-pp.cifs_readdir
      0.74 ± 33%      +3.2        3.96 ±  6%  perf-profile.children.cycles-pp.path_lookupat
      0.00            +3.3        3.26 ± 10%  perf-profile.children.cycles-pp.__smb_send_rqst
      0.00            +3.3        3.28 ± 10%  perf-profile.children.cycles-pp.smb_send_rqst
      0.02 ±141%      +3.3        3.34 ± 14%  perf-profile.children.cycles-pp.net_rx_action
      0.00            +3.4        3.36 ± 13%  perf-profile.children.cycles-pp.path_getxattrat
      0.27 ± 29%      +3.4        3.64 ±  8%  perf-profile.children.cycles-pp.__fput
      0.00            +3.4        3.40 ± 13%  perf-profile.children.cycles-pp.getxattr
      0.39 ± 31%      +3.4        3.84 ± 10%  perf-profile.children.cycles-pp.fstatat64
      0.00            +3.6        3.61 ± 14%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      0.00            +3.8        3.80 ± 10%  perf-profile.children.cycles-pp.vfs_rmdir
      0.26 ± 29%      +3.8        4.08 ±  8%  perf-profile.children.cycles-pp.__x64_sys_close
      0.00            +3.9        3.92 ± 15%  perf-profile.children.cycles-pp.__dev_queue_xmit
      0.00            +4.0        4.01 ± 11%  perf-profile.children.cycles-pp.do_rmdir
      0.00            +4.0        4.02 ± 16%  perf-profile.children.cycles-pp.ip6_finish_output2
      0.00            +4.1        4.06 ± 11%  perf-profile.children.cycles-pp.__x64_sys_unlinkat
      0.00            +4.1        4.10 ± 12%  perf-profile.children.cycles-pp.iterate_dir
      0.00            +4.1        4.11 ± 16%  perf-profile.children.cycles-pp.ip6_finish_output
      0.00            +4.2        4.18 ± 11%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      0.00            +4.2        4.20 ± 11%  perf-profile.children.cycles-pp.unlinkat
      0.00            +4.2        4.24 ± 15%  perf-profile.children.cycles-pp.ip6_xmit
      0.00            +4.4        4.40 ± 15%  perf-profile.children.cycles-pp.inet6_csk_xmit
      0.00            +4.4        4.42 ± 15%  perf-profile.children.cycles-pp.tcp_sendmsg_locked
      0.00            +4.5        4.46 ± 15%  perf-profile.children.cycles-pp.____sys_sendmsg
      0.00            +4.5        4.47 ± 12%  perf-profile.children.cycles-pp.getdents64
      0.00            +4.5        4.54 ± 10%  perf-profile.children.cycles-pp.compound_send_recv
      0.00            +4.6        4.62 ± 15%  perf-profile.children.cycles-pp.tcp_sendmsg
      0.00            +4.7        4.66 ± 16%  perf-profile.children.cycles-pp.___sys_sendmsg
      0.00            +4.7        4.70 ± 17%  perf-profile.children.cycles-pp.__sys_sendmsg
      0.00            +4.8        4.82 ± 14%  perf-profile.children.cycles-pp.__tcp_transmit_skb
      0.00            +4.9        4.94 ± 16%  perf-profile.children.cycles-pp.sendmsg
      0.00            +5.4        5.36 ± 13%  perf-profile.children.cycles-pp.tcp_write_xmit
      0.00            +5.4        5.38 ± 13%  perf-profile.children.cycles-pp.__tcp_push_pending_frames
     30.83 ±  3%     +10.0       40.86 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     30.92 ±  3%     +10.2       41.08 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     16.14 ±  8%      -3.7       12.40 ±  4%  perf-profile.self.cycles-pp.intel_idle
      2.82 ± 22%      -2.0        0.86 ± 30%  perf-profile.self.cycles-pp.update_sg_lb_stats
      1.57 ± 18%      -1.1        0.44 ± 30%  perf-profile.self.cycles-pp.cpuidle_enter_state
      1.30 ± 25%      -1.1        0.20 ± 78%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.11 ± 12%      -0.7        0.42 ± 15%  perf-profile.self.cycles-pp.idle_cpu
      0.92 ± 24%      -0.6        0.29 ± 44%  perf-profile.self.cycles-pp.delay_tsc
      0.77 ± 22%      -0.5        0.24 ± 50%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.66 ± 55%      -0.5        0.16 ± 34%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.62 ± 32%      -0.4        0.20 ± 51%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.52 ± 17%      -0.4        0.11 ± 34%  perf-profile.self.cycles-pp.fold_vm_zone_numa_events
      0.56 ± 20%      -0.4        0.16 ± 34%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.50 ± 16%      -0.4        0.10 ± 59%  perf-profile.self.cycles-pp.filemap_map_pages
      0.94 ± 31%      -0.4        0.58 ±  9%  perf-profile.self.cycles-pp.menu_select
      0.41 ± 27%      -0.4        0.04 ±100%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.38 ± 32%      -0.3        0.04 ±101%  perf-profile.self.cycles-pp.read_counters
      0.38 ± 43%      -0.3        0.05 ± 75%  perf-profile.self.cycles-pp.strnlen_user
      0.61 ± 29%      -0.3        0.28 ± 11%  perf-profile.self.cycles-pp.update_rq_clock
      0.40 ± 31%      -0.3        0.09 ± 31%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.36 ± 17%      -0.3        0.06 ± 73%  perf-profile.self.cycles-pp._IO_fwrite
      0.39 ± 29%      -0.3        0.12 ± 41%  perf-profile.self.cycles-pp.sync_regs
      0.30 ± 51%      -0.3        0.05 ± 79%  perf-profile.self.cycles-pp.evlist__id2sid
      0.33 ± 24%      -0.2        0.09 ± 35%  perf-profile.self.cycles-pp.zap_present_ptes
      0.30 ± 33%      -0.2        0.07 ± 22%  perf-profile.self.cycles-pp.rb_next
      0.30 ± 31%      -0.2        0.07 ± 56%  perf-profile.self.cycles-pp.fdget_pos
      0.38 ± 30%      -0.2        0.17 ± 40%  perf-profile.self.cycles-pp.update_load_avg
      0.34 ± 26%      -0.2        0.13 ± 44%  perf-profile.self.cycles-pp._find_next_and_bit
      0.29 ± 23%      -0.2        0.09 ± 52%  perf-profile.self.cycles-pp.cpu_util
      0.27 ± 37%      -0.2        0.06 ± 76%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.26 ± 31%      -0.2        0.05 ± 76%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.26 ± 56%      -0.2        0.06 ± 14%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.29 ± 21%      -0.2        0.10 ± 20%  perf-profile.self.cycles-pp.sched_balance_newidle
      0.26 ± 41%      -0.2        0.08 ±103%  perf-profile.self.cycles-pp.get_jiffies_update
      0.21 ± 41%      -0.2        0.03 ±111%  perf-profile.self.cycles-pp.error_entry
      0.29 ± 35%      -0.2        0.11 ± 19%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.23 ± 26%      -0.2        0.06 ± 87%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.26 ± 23%      -0.2        0.09 ± 22%  perf-profile.self.cycles-pp.get_cpu_device
      0.21 ± 48%      -0.2        0.04 ±118%  perf-profile.self.cycles-pp.check_cpu_stall
      0.20 ± 25%      -0.2        0.03 ±101%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.23 ± 29%      -0.2        0.08 ± 49%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.24 ± 31%      -0.2        0.09 ± 50%  perf-profile.self.cycles-pp.down_write
      0.21 ± 35%      -0.1        0.06 ± 81%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.20 ± 37%      -0.1        0.06 ± 74%  perf-profile.self.cycles-pp.mas_walk
      0.17 ± 26%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.menu_reflect
      0.22 ± 56%      -0.1        0.08 ± 33%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.25 ± 33%      -0.1        0.12 ± 16%  perf-profile.self.cycles-pp.mutex_unlock
      0.22 ± 30%      -0.1        0.09 ± 48%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.17 ± 55%      -0.1        0.05 ± 79%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.16 ± 31%      -0.1        0.04 ±106%  perf-profile.self.cycles-pp.pick_task_fair
      0.20 ± 27%      -0.1        0.09 ± 26%  perf-profile.self.cycles-pp.__get_user_8
      0.15 ± 32%      -0.1        0.04 ± 80%  perf-profile.self.cycles-pp.folios_put_refs
      0.16 ± 24%      -0.1        0.06 ± 51%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.21 ± 31%      -0.1        0.10 ± 13%  perf-profile.self.cycles-pp.up_write
      0.19 ± 39%      -0.1        0.08 ± 55%  perf-profile.self.cycles-pp._nohz_idle_balance
      0.12 ± 48%      -0.1        0.04 ± 72%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.12 ± 20%      -0.1        0.07 ± 71%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.04 ± 70%      +0.0        0.08 ± 16%  perf-profile.self.cycles-pp.fdget
      0.02 ±141%      +0.1        0.07 ± 26%  perf-profile.self.cycles-pp.check_stack_object
      0.02 ±141%      +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.pick_link
      0.02 ±141%      +0.1        0.08 ± 29%  perf-profile.self.cycles-pp.__errno_location
      0.01 ±223%      +0.1        0.07 ± 16%  perf-profile.self.cycles-pp.mntput_no_expire
      0.01 ±223%      +0.1        0.07 ± 32%  perf-profile.self.cycles-pp.schedule_idle
      0.00            +0.1        0.06 ± 23%  perf-profile.self.cycles-pp.ndr_pull_xattr_DosInfo
      0.00            +0.1        0.06 ± 27%  perf-profile.self.cycles-pp._tevent_loop_once
      0.00            +0.1        0.07 ± 30%  perf-profile.self.cycles-pp.sock_poll
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.vfs_stat_fsp
      0.01 ±223%      +0.1        0.08 ± 33%  perf-profile.self.cycles-pp.__mod_timer
      0.00            +0.1        0.07 ± 37%  perf-profile.self.cycles-pp.tcp_schedule_loss_probe
      0.00            +0.1        0.08 ± 35%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.00            +0.1        0.08 ± 34%  perf-profile.self.cycles-pp.memset@plt
      0.07 ± 27%      +0.1        0.15 ± 26%  perf-profile.self.cycles-pp.__check_object_size
      0.00            +0.1        0.08 ± 38%  perf-profile.self.cycles-pp.btrfs_del_items
      0.00            +0.1        0.09 ± 18%  perf-profile.self.cycles-pp._raw_read_lock_irqsave
      0.00            +0.1        0.09 ± 24%  perf-profile.self.cycles-pp.ip6_finish_output
      0.00            +0.1        0.09 ± 53%  perf-profile.self.cycles-pp.ip6_finish_output2
      0.00            +0.1        0.09 ± 41%  perf-profile.self.cycles-pp.ndr_pull_uint32
      0.02 ±142%      +0.1        0.11 ± 22%  perf-profile.self.cycles-pp.cpus_share_cache
      0.00            +0.1        0.09 ± 27%  perf-profile.self.cycles-pp.smbd_smb2_request_process_query_directory
      0.00            +0.1        0.09 ± 30%  perf-profile.self.cycles-pp.__smb2_find_mid
      0.00            +0.1        0.09 ± 28%  perf-profile.self.cycles-pp.read_extent_buffer
      0.00            +0.1        0.09 ± 15%  perf-profile.self.cycles-pp.release_extent_buffer
      0.00            +0.1        0.09 ± 30%  perf-profile.self.cycles-pp.synthetic_smb_fname
      0.00            +0.1        0.09 ± 42%  perf-profile.self.cycles-pp.unlock_up
      0.02 ±142%      +0.1        0.11 ± 26%  perf-profile.self.cycles-pp.lookup_fast
      0.00            +0.1        0.10 ± 18%  perf-profile.self.cycles-pp.close_file_smb
      0.02 ±142%      +0.1        0.11 ± 45%  perf-profile.self.cycles-pp.putname
      0.09 ± 76%      +0.1        0.18 ± 16%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.00            +0.1        0.10 ± 19%  perf-profile.self.cycles-pp.start_transaction
      0.00            +0.1        0.10 ± 24%  perf-profile.self.cycles-pp._talloc_get_type_abort@plt
      0.00            +0.1        0.10 ± 39%  perf-profile.self.cycles-pp.next_codepoint_handle_ext
      0.04 ± 71%      +0.1        0.14 ± 32%  perf-profile.self.cycles-pp.vfs_getattr_nosec
      0.00            +0.1        0.10 ± 25%  perf-profile.self.cycles-pp._talloc_set_destructor
      0.00            +0.1        0.10 ± 40%  perf-profile.self.cycles-pp.next_codepoint_handle
      0.00            +0.1        0.10 ± 26%  perf-profile.self.cycles-pp._talloc_array
      0.00            +0.1        0.11 ± 32%  perf-profile.self.cycles-pp._talloc_memdup
      0.00            +0.1        0.11 ± 27%  perf-profile.self.cycles-pp.convert_string_error_handle
      0.00            +0.1        0.11 ± 22%  perf-profile.self.cycles-pp.ip6_xmit
      0.00            +0.1        0.11 ± 33%  perf-profile.self.cycles-pp.smbd_dirptr_get_entry
      0.05 ± 82%      +0.1        0.16 ± 31%  perf-profile.self.cycles-pp.generic_permission
      0.00            +0.1        0.11 ± 34%  perf-profile.self.cycles-pp.ndr_push_uint8
      0.01 ±223%      +0.1        0.12 ± 34%  perf-profile.self.cycles-pp.fdget_raw
      0.00            +0.1        0.11 ± 37%  perf-profile.self.cycles-pp.tcp_check_space
      0.11 ± 40%      +0.1        0.22 ± 25%  perf-profile.self.cycles-pp.inode_permission
      0.06 ± 80%      +0.1        0.17 ± 43%  perf-profile.self.cycles-pp.step_into
      0.00            +0.1        0.12 ± 33%  perf-profile.self.cycles-pp.utf8_to_utf32
      0.00            +0.1        0.12 ± 21%  perf-profile.self.cycles-pp.__smb_send_rqst
      0.00            +0.1        0.12 ± 30%  perf-profile.self.cycles-pp.btrfs_get_16
      0.00            +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.btrfs_get_32
      0.00            +0.1        0.12 ± 40%  perf-profile.self.cycles-pp.tcp_write_xmit
      0.00            +0.1        0.12 ± 30%  perf-profile.self.cycles-pp._talloc_pooled_object
      0.00            +0.1        0.12 ± 22%  perf-profile.self.cycles-pp.ndr_pull_udlong
      0.00            +0.1        0.12 ± 23%  perf-profile.self.cycles-pp.cifsConvertToUTF16
      0.01 ±223%      +0.1        0.14 ± 34%  perf-profile.self.cycles-pp.memcpy@plt
      0.00            +0.1        0.13 ± 22%  perf-profile.self.cycles-pp.skb_page_frag_refill
      0.00            +0.1        0.13 ± 19%  perf-profile.self.cycles-pp.btrfs_getattr
      0.00            +0.1        0.13 ± 39%  perf-profile.self.cycles-pp.smbd_smb2_request_process_create
      0.00            +0.1        0.13 ± 44%  perf-profile.self.cycles-pp.tcp_ack
      0.00            +0.1        0.14 ± 34%  perf-profile.self.cycles-pp.ndr_push_expand
      0.00            +0.1        0.14 ± 21%  perf-profile.self.cycles-pp.tdb_parse_record
      0.08 ± 91%      +0.1        0.21 ± 20%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.1        0.14 ± 16%  perf-profile.self.cycles-pp._talloc_zero
      0.00            +0.1        0.14 ± 25%  perf-profile.self.cycles-pp.smbd_smb2_request_done_ex
      0.00            +0.1        0.14 ± 26%  perf-profile.self.cycles-pp._nettle_chacha_core
      0.26 ± 27%      +0.1        0.40 ±  8%  perf-profile.self.cycles-pp.__schedule
      0.00            +0.2        0.15 ± 24%  perf-profile.self.cycles-pp.cp_smb_filename
      0.00            +0.2        0.15 ± 41%  perf-profile.self.cycles-pp.smbd_dirptr_lanman2_entry
      0.00            +0.2        0.15 ± 25%  perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.00            +0.2        0.16 ± 33%  perf-profile.self.cycles-pp.ndr_push_uint32
      0.05 ± 84%      +0.2        0.20 ± 11%  perf-profile.self.cycles-pp.rcu_all_qs
      0.00            +0.2        0.16 ± 21%  perf-profile.self.cycles-pp.skb_attempt_defer_free
      0.07 ± 55%      +0.2        0.22 ± 39%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.00            +0.2        0.16 ± 24%  perf-profile.self.cycles-pp.tcp_rcv_established
      0.11 ± 56%      +0.2        0.27 ± 21%  perf-profile.self.cycles-pp.llist_reverse_order
      0.00            +0.2        0.16 ± 17%  perf-profile.self.cycles-pp.available_idle_cpu
      0.03 ±150%      +0.2        0.20 ± 21%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.00            +0.2        0.17 ± 25%  perf-profile.self.cycles-pp.fstatat64
      0.00            +0.2        0.17 ± 22%  perf-profile.self.cycles-pp.debuglevel_get_class@plt
      0.06 ± 81%      +0.2        0.24 ± 33%  perf-profile.self.cycles-pp.link_path_walk
      0.00            +0.2        0.18 ± 26%  perf-profile.self.cycles-pp.__tcp_transmit_skb
      0.12 ± 62%      +0.2        0.31 ± 19%  perf-profile.self.cycles-pp.__cond_resched
      0.00            +0.2        0.19 ± 39%  perf-profile.self.cycles-pp._talloc_get_type_abort
      0.00            +0.2        0.19 ± 26%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.00            +0.2        0.20 ± 23%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.06 ± 56%      +0.2        0.25 ± 30%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.00            +0.2        0.20 ± 29%  perf-profile.self.cycles-pp.tcp_sendmsg_locked
      0.00            +0.2        0.21 ± 16%  perf-profile.self.cycles-pp.__inet6_lookup_established
      0.00            +0.2        0.22 ± 20%  perf-profile.self.cycles-pp.btrfs_get_token_32
      0.00            +0.2        0.22 ± 20%  perf-profile.self.cycles-pp.btrfs_set_token_32
      0.04 ±165%      +0.2        0.27 ± 17%  perf-profile.self.cycles-pp._copy_from_iter
      0.00            +0.2        0.23 ± 22%  perf-profile.self.cycles-pp._talloc_free
      0.00            +0.2        0.24 ± 30%  perf-profile.self.cycles-pp.skb_release_data
      0.07 ± 59%      +0.2        0.30 ± 19%  perf-profile.self.cycles-pp._copy_to_user
      0.00            +0.2        0.24 ± 27%  perf-profile.self.cycles-pp.net_rx_action
      0.12 ± 38%      +0.3        0.37 ± 20%  perf-profile.self.cycles-pp.check_heap_object
      0.00            +0.3        0.27 ± 14%  perf-profile.self.cycles-pp.smbd_smb2_request_dispatch
      0.00            +0.3        0.28 ± 20%  perf-profile.self.cycles-pp.debuglevel_get_class
      0.25 ± 56%      +0.3        0.56 ± 17%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.39 ± 40%      +0.3        0.71 ± 10%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.00            +0.3        0.34 ± 23%  perf-profile.self.cycles-pp.tdb_jenkins_hash
      0.00            +0.3        0.34 ± 22%  perf-profile.self.cycles-pp.tcp_recvmsg_locked
      0.10 ± 93%      +0.3        0.44 ± 24%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.06 ± 83%      +0.4        0.42 ± 33%  perf-profile.self.cycles-pp.poll_idle
      0.00            +0.4        0.39 ± 30%  perf-profile.self.cycles-pp.btrfs_bin_search
      0.21 ± 48%      +0.4        0.61 ± 10%  perf-profile.self.cycles-pp.malloc
      0.00            +0.4        0.42 ± 17%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.00            +0.6        0.60 ± 13%  perf-profile.self.cycles-pp.__memmove
      0.35 ± 31%      +0.6        0.98 ± 15%  perf-profile.self.cycles-pp.clear_bhb_loop



***************************************************************************************************
lkp-icl-2sp4: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/thread_nr:
  gcc-12/performance/directio/1SSD/xfs/x86_64-rhel-9.4/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp4/DWSL/fxmark/4

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    767501           +21.2%     930491 ±  2%  cpuidle..usage
     51785           +11.6%      57786        meminfo.Shmem
     49987           +10.8%      55404        numa-meminfo.node0.Shmem
     12495           +11.0%      13874        numa-vmstat.node0.nr_shmem
    449.33 ±  6%    +130.0%       1033 ±  5%  perf-c2c.HITM.local
      0.57            -0.2        0.40        mpstat.cpu.all.soft%
      3.26            -0.4        2.85        mpstat.cpu.all.sys%
      6286           +18.1%       7425 ±  3%  vmstat.io.bo
     15336           +14.5%      17562 ±  2%  vmstat.system.cs
      6804 ±  3%     +20.6%       8205 ±  3%  vmstat.system.in
      0.37 ± 18%      +0.1        0.48 ± 14%  perf-stat.i.cache-miss-rate%
     15347           +14.8%      17615 ±  2%  perf-stat.i.context-switches
      3.88           +15.0%       4.46 ±  2%  perf-stat.i.metric.K/sec
     15128           +14.8%      17363 ±  2%  perf-stat.ps.context-switches
     73693            +2.0%      75170        proc-vmstat.nr_active_anon
     12926           +12.1%      14484        proc-vmstat.nr_shmem
     73693            +2.0%      75170        proc-vmstat.nr_zone_active_anon
    561543           +16.6%     654601 ±  3%  proc-vmstat.pgpgout
    294088          +118.0%     641007        turbostat.C1E
      0.42            +0.6        1.01        turbostat.C1E%
    447386           -41.1%     263643        turbostat.C6
      1.53           +72.5%       2.64        turbostat.CPU%c1
    559637           +23.7%     692294        turbostat.IRQ
     36.56            +4.3%      38.12        turbostat.Pkg%pc2
     27.16           -18.6%      22.09 ±  6%  turbostat.Pkg%pc6
    152.65            +4.1%     158.93        turbostat.PkgWatt
     55.08           +10.8%      61.06 ±  2%  fxmark.ssd_xfs_DWSL_4_directio.iowait_sec
     28.21           +10.3%      31.12 ±  2%  fxmark.ssd_xfs_DWSL_4_directio.iowait_util
      1.82           -31.7%       1.24        fxmark.ssd_xfs_DWSL_4_directio.softirq_sec
      0.93           -32.1%       0.63        fxmark.ssd_xfs_DWSL_4_directio.softirq_util
      8.32           -17.3%       6.88        fxmark.ssd_xfs_DWSL_4_directio.sys_sec
      4.26           -17.7%       3.51        fxmark.ssd_xfs_DWSL_4_directio.sys_util
     97771           +23.1%     120378 ±  4%  fxmark.ssd_xfs_DWSL_4_directio.works
      1955           +23.1%       2407 ±  4%  fxmark.ssd_xfs_DWSL_4_directio.works/sec
    233665 ± 10%     +20.5%     281465 ±  4%  fxmark.time.file_system_outputs
      6765 ± 29%     +49.9%      10143 ±  4%  fxmark.time.involuntary_context_switches
      3.00           -33.3%       2.00        fxmark.time.percent_of_cpu_this_job_got
    105628 ±  8%     +12.0%     118251 ±  2%  fxmark.time.voluntary_context_switches
      0.03 ±  2%     -49.0%       0.02 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.submit_bio_wait.blkdev_issue_flush.xfs_file_fsync
      0.02 ± 28%     -48.3%       0.01 ± 38%  perf-sched.sch_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.01 ± 14%     +35.9%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 32%     -48.9%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.12 ± 36%     -75.4%       0.03 ± 23%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.do_select.core_sys_select.kern_select
      0.05           -48.7%       0.03 ±  4%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      0.06           -46.9%       0.03 ±  3%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
      0.06           -52.5%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
      0.02 ± 13%     -39.5%       0.01 ± 15%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.02           -43.2%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 28%     -48.0%       0.01 ± 19%  perf-sched.sch_delay.avg.ms.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.do_fsync
      0.04 ±  3%     -65.7%       0.02 ±  3%  perf-sched.sch_delay.avg.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.do_fsync
      0.06           -47.3%       0.03 ±  3%  perf-sched.sch_delay.avg.ms.xlog_wait_on_iclog.xfs_file_fsync.do_fsync.__x64_sys_fsync
      0.07 ±  4%     -56.0%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.do_fsync
      0.06 ± 19%     -28.5%       0.04 ± 14%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.13 ± 26%     -46.8%       0.07 ± 62%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.05 ± 52%     -63.1%       0.02 ± 73%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown].[unknown]
      0.42 ± 40%    +106.5%       0.86 ± 35%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.15 ± 29%     -70.1%       0.04 ± 10%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.do_select.core_sys_select.kern_select
      0.09 ± 14%    +160.8%       0.23 ±117%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xlog_cil_commit
      0.13 ± 18%     -57.1%       0.06 ± 71%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.04           -48.5%       0.02        perf-sched.total_sch_delay.average.ms
     13.74 ±  9%     -35.7%       8.83 ± 10%  perf-sched.total_sch_delay.max.ms
      3.35           -13.7%       2.89        perf-sched.total_wait_and_delay.average.ms
     70116           +15.2%      80797        perf-sched.total_wait_and_delay.count.ms
      3.31           -13.3%       2.87        perf-sched.total_wait_time.average.ms
      0.28 ±  2%     -27.1%       0.20 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      0.85           -15.6%       0.72 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
      0.76 ±  3%     -28.4%       0.54 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
     50.02 ±  5%     -41.9%      29.04 ±  7%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.60 ±  3%     -12.1%       1.41 ±  2%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.28 ±  3%     -51.8%       0.13 ±  2%  perf-sched.wait_and_delay.avg.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.do_fsync
      0.25 ±  4%     -32.3%       0.17 ±  3%  perf-sched.wait_and_delay.avg.ms.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.do_fsync
      1112 ±  3%     +42.6%       1587 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.submit_bio_wait.blkdev_issue_flush.xfs_file_fsync
     49.33            +9.5%      54.00 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      9399 ±  2%     +20.5%      11328 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
      4552 ±  3%     +38.7%       6314 ±  8%  perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
    693.83 ±  5%     +69.3%       1174 ±  4%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     29488           +14.8%      33857        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      5728 ±  2%     +12.9%       6465 ±  6%  perf-sched.wait_and_delay.count.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.do_fsync
      5722 ±  2%     +12.9%       6460 ±  6%  perf-sched.wait_and_delay.count.xlog_wait_on_iclog.xfs_file_fsync.do_fsync.__x64_sys_fsync
      0.10 ±115%    +401.0%       0.52 ± 71%  perf-sched.wait_time.avg.ms.__cond_resched.submit_bio_noacct.iomap_dio_bio_iter.__iomap_dio_rw.iomap_dio_rw
     10.51 ±221%     -99.7%       0.03 ± 98%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
      0.23 ±  2%     -22.1%       0.18 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      0.79 ±  2%     -13.2%       0.69 ±  4%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
      0.69 ±  3%     -26.2%       0.51 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
     50.00 ±  5%     -42.0%      29.03 ±  7%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.58 ±  3%     -11.7%       1.40 ±  2%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.23 ±  3%     -49.0%       0.12 ±  3%  perf-sched.wait_time.avg.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.do_fsync
      0.18 ±  4%     -23.4%       0.14 ±  3%  perf-sched.wait_time.avg.ms.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.do_fsync
      0.11 ±115%   +1161.2%       1.35 ± 82%  perf-sched.wait_time.max.ms.__cond_resched.submit_bio_noacct.iomap_dio_bio_iter.__iomap_dio_rw.iomap_dio_rw
    167.40 ±222%     -99.9%       0.23 ±134%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]



***************************************************************************************************
lkp-icl-2sp4: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/thread_nr:
  gcc-12/performance/directio/1SSD/ext4/x86_64-rhel-9.4/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp4/DRBM/fxmark/4

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1645631           +39.1%    2288608        cpuidle..usage
    746.00 ±  4%    +177.8%       2072 ±  3%  perf-c2c.HITM.local
      3390 ±  8%     -21.4%       2664 ± 10%  numa-meminfo.node0.PageTables
      2292 ± 12%     +33.0%       3048 ±  9%  numa-meminfo.node1.PageTables
     25341 ± 75%    +310.1%     103929 ± 32%  numa-numastat.node0.other_node
    107927 ± 17%     -72.8%      29364 ±114%  numa-numastat.node1.other_node
      1.10            +0.2        1.30        mpstat.cpu.all.irq%
      0.57            -0.2        0.37 ±  3%  mpstat.cpu.all.soft%
      3.03            -1.0        2.05        mpstat.cpu.all.sys%
     22711 ±  2%     +20.2%      27295        perf-stat.i.context-switches
      5.75 ±  2%     +20.1%       6.91        perf-stat.i.metric.K/sec
     22376 ±  2%     +20.2%      26902        perf-stat.ps.context-switches
    344417 ±  3%     +22.5%     421964        proc-vmstat.nr_foll_pin_acquired
    344434 ±  3%     +22.5%     422008        proc-vmstat.nr_foll_pin_released
   3643790           +23.0%    4481621        proc-vmstat.pgpgin
     40418 ±  2%     +22.3%      49439        vmstat.io.bi
     22494 ±  2%     +19.5%      26873        vmstat.system.cs
     13143 ±  3%     +38.1%      18152        vmstat.system.in
    344767 ±  3%     +22.5%     422329        numa-vmstat.node0.nr_foll_pin_acquired
    344791 ±  3%     +22.5%     422374        numa-vmstat.node0.nr_foll_pin_released
    848.11 ±  8%     -21.5%     666.16 ± 10%  numa-vmstat.node0.nr_page_table_pages
     25341 ± 75%    +310.1%     103929 ± 32%  numa-vmstat.node0.numa_other
    573.19 ± 12%     +32.9%     761.68 ±  9%  numa-vmstat.node1.nr_page_table_pages
    107927 ± 17%     -72.8%      29364 ±114%  numa-vmstat.node1.numa_other
     17230 ± 13%     +72.3%      29682 ± 21%  turbostat.C1
   1087599 ±  2%     +90.4%    2070580        turbostat.C1E
      0.81 ±  2%      +0.8        1.57        turbostat.C1E%
    532700           -67.1%     175060        turbostat.C6
      2.30           +59.9%       3.68        turbostat.CPU%c1
   1160083           +38.7%    1608509        turbostat.IRQ
      0.18 ±  2%     -47.3%       0.10 ±  4%  fxmark.ssd_ext4_DRBM_4_directio.idle_sec
      0.09 ±  2%     -48.0%       0.05 ±  4%  fxmark.ssd_ext4_DRBM_4_directio.idle_util
      3.27           +24.2%       4.06        fxmark.ssd_ext4_DRBM_4_directio.irq_sec
      1.68           +22.5%       2.06        fxmark.ssd_ext4_DRBM_4_directio.irq_util
      1.82           -35.6%       1.17 ±  2%  fxmark.ssd_ext4_DRBM_4_directio.softirq_sec
      0.93           -36.5%       0.59 ±  2%  fxmark.ssd_ext4_DRBM_4_directio.softirq_util
      7.88           -42.4%       4.54        fxmark.ssd_ext4_DRBM_4_directio.sys_sec
      4.05           -43.2%       2.30        fxmark.ssd_ext4_DRBM_4_directio.sys_util
      0.85 ±  2%     -18.4%       0.70 ±  2%  fxmark.ssd_ext4_DRBM_4_directio.user_sec
      0.44 ±  2%     -19.5%       0.35 ±  2%  fxmark.ssd_ext4_DRBM_4_directio.user_util
    910527           +23.0%    1119985        fxmark.ssd_ext4_DRBM_4_directio.works
     18210           +23.0%      22399        fxmark.ssd_ext4_DRBM_4_directio.works/sec
   1971356 ±  5%     +14.8%    2262447        fxmark.time.file_system_inputs
    256187 ±  5%     +14.2%     292580        fxmark.time.voluntary_context_switches
      0.01 ± 26%     -59.2%       0.00 ± 47%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_noprof.__filemap_get_folio
      0.01 ± 41%     -69.7%       0.00 ± 61%  perf-sched.sch_delay.avg.ms.__cond_resched.bdev_getblk.ext4_read_block_bitmap_nowait.ext4_mb_init_cache.ext4_mb_init_group
      0.03 ±114%     -87.9%       0.00 ± 46%  perf-sched.sch_delay.avg.ms.__cond_resched.ext4_mb_init_group.ext4_mb_prefetch_fini.ext4_run_li_request.ext4_lazyinit_thread
      0.01 ± 26%     -54.5%       0.01 ± 28%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ±  5%     -80.2%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
      0.01 ± 43%    +293.3%       0.03 ± 28%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 40%     -61.5%       0.00 ± 50%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_noprof.__filemap_get_folio
      0.06 ± 60%     -88.2%       0.01 ± 68%  perf-sched.sch_delay.max.ms.__cond_resched.bdev_getblk.ext4_read_block_bitmap_nowait.ext4_mb_init_cache.ext4_mb_init_group
      0.04 ±103%     -87.5%       0.01 ± 47%  perf-sched.sch_delay.max.ms.__cond_resched.ext4_mb_init_group.ext4_mb_prefetch_fini.ext4_run_li_request.ext4_lazyinit_thread
      0.05 ± 69%     -69.8%       0.02 ±131%  perf-sched.sch_delay.max.ms.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
      0.08 ± 60%     -67.5%       0.03 ±116%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.03 ±  5%     -79.4%       0.01 ±  6%  perf-sched.total_sch_delay.average.ms
      0.22 ±  3%     -23.0%       0.17 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
     16.55 ± 13%    +667.8%     127.07 ± 19%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     85.84 ± 13%     +60.1%     137.43 ± 14%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2169 ± 12%     -86.9%     285.00 ± 17%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    532.50 ± 13%     -40.1%     319.00 ± 12%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.09 ± 13%     -53.7%       0.04 ± 50%  perf-sched.wait_time.avg.ms.__cond_resched.bdev_getblk.ext4_read_block_bitmap_nowait.ext4_mb_init_cache.ext4_mb_init_group
      0.20 ±  3%     -14.4%       0.17 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
     16.54 ± 13%    +667.9%     127.04 ± 19%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     85.83 ± 13%     +60.1%     137.42 ± 14%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.20 ± 22%     -48.0%       0.10 ± 45%  perf-sched.wait_time.max.ms.__cond_resched.bdev_getblk.ext4_read_block_bitmap_nowait.ext4_mb_init_cache.ext4_mb_init_group



***************************************************************************************************
lkp-icl-2sp4: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/thread_nr:
  gcc-12/performance/directio/1SSD/ext4/x86_64-rhel-9.4/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp4/DWSL/fxmark/4

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1253687           +72.1%    2157829 ±  3%  cpuidle..usage
    497.67 ±  4%    +307.0%       2025 ±  4%  perf-c2c.HITM.local
    188698           -14.4%     161540 ±  6%  numa-meminfo.node0.Inactive
    188698           -14.4%     161540 ±  6%  numa-meminfo.node0.Inactive(file)
     73110 ±  2%     +58.0%     115519 ± 10%  numa-meminfo.node0.Shmem
     47227           -13.9%      40681 ±  6%  numa-vmstat.node0.nr_inactive_file
     18280 ±  2%     +57.7%      28834 ± 10%  numa-vmstat.node0.nr_shmem
     47227           -13.9%      40681 ±  6%  numa-vmstat.node0.nr_zone_inactive_file
     25572 ±  2%     +68.5%      43080 ±  5%  perf-stat.i.context-switches
      0.08 ± 13%     -14.5%       0.07 ±  8%  perf-stat.i.cpi
      6.47 ±  2%     +67.8%      10.86 ±  5%  perf-stat.i.metric.K/sec
     25199 ±  2%     +68.5%      42465 ±  5%  perf-stat.ps.context-switches
     64.80           -12.3       52.49        mpstat.cpu.all.idle%
     30.27           +13.4       43.62        mpstat.cpu.all.iowait%
      0.79            +0.2        1.03 ±  3%  mpstat.cpu.all.irq%
      0.58            -0.1        0.48 ±  5%  mpstat.cpu.all.soft%
      3.18            -1.2        2.01 ±  8%  mpstat.cpu.all.sys%
    319108           +13.1%     360809 ±  3%  meminfo.Active
    319108           +13.1%     360809 ±  3%  meminfo.Active(anon)
    181492           -14.8%     154658 ±  6%  meminfo.Buffers
    444212            +9.8%     487716 ±  2%  meminfo.Committed_AS
    188565           -14.4%     161494 ±  6%  meminfo.Inactive
    188565           -14.4%     161494 ±  6%  meminfo.Inactive(file)
     75877 ±  3%     +55.3%     117868 ± 10%  meminfo.Shmem
     65.45           -18.2%      53.53        vmstat.cpu.id
     29.75           +43.6%      42.71        vmstat.cpu.wa
     57984 ±  3%     +18.3%      68617        vmstat.io.bo
    178617           -14.5%     152783 ±  6%  vmstat.memory.buff
      1.30 ±  5%     +21.4%       1.58 ±  4%  vmstat.procs.b
     25191 ±  2%     +67.2%      42116 ±  5%  vmstat.system.cs
     10243           +55.2%      15896 ±  4%  vmstat.system.in
     79847           +13.0%      90257 ±  3%  proc-vmstat.nr_active_anon
     47397           -14.4%      40590 ±  6%  proc-vmstat.nr_inactive_file
      9351            +2.4%       9574        proc-vmstat.nr_mapped
     18988 ±  3%     +55.2%      29473 ± 10%  proc-vmstat.nr_shmem
     79847           +13.0%      90257 ±  3%  proc-vmstat.nr_zone_active_anon
     47397           -14.4%      40590 ±  6%  proc-vmstat.nr_zone_inactive_file
    731810            -2.2%     715490        proc-vmstat.pgfree
   5180038 ±  3%     +19.4%    6186546        proc-vmstat.pgpgout
      2945            +3.8%       3058        turbostat.Bzy_MHz
      9125 ±  9%     +31.4%      11990 ±  6%  turbostat.C1
    629812 ±  3%    +215.2%    1984933 ±  4%  turbostat.C1E
      0.51            +1.1        1.61        turbostat.C1E%
    602851           -75.0%     150770 ±  2%  turbostat.C6
      1.72          +119.5%       3.78        turbostat.CPU%c1
      0.41 ±  2%     +17.0%       0.48 ±  2%  turbostat.IPC
    877949           +59.7%    1402362 ±  3%  turbostat.IRQ
      8644 ±  6%     +26.3%      10913 ±  6%  turbostat.POLL
     95.63           -43.9%      53.65        fxmark.ssd_ext4_DWSL_4_directio.idle_sec
     49.31           -44.3%      27.46        fxmark.ssd_ext4_DWSL_4_directio.idle_util
     85.02           +55.1%     131.89        fxmark.ssd_ext4_DWSL_4_directio.iowait_sec
     43.83           +54.0%      67.51        fxmark.ssd_ext4_DWSL_4_directio.iowait_util
      2.24           +38.2%       3.09 ±  3%  fxmark.ssd_ext4_DWSL_4_directio.irq_sec
      1.15           +37.2%       1.58 ±  3%  fxmark.ssd_ext4_DWSL_4_directio.irq_util
      1.82           -17.2%       1.51 ±  4%  fxmark.ssd_ext4_DWSL_4_directio.softirq_sec
      0.94           -17.7%       0.77 ±  5%  fxmark.ssd_ext4_DWSL_4_directio.softirq_util
      8.43           -47.0%       4.46 ± 11%  fxmark.ssd_ext4_DWSL_4_directio.sys_sec
      4.34           -47.4%       2.28 ± 11%  fxmark.ssd_ext4_DWSL_4_directio.sys_util
    233119 ±  3%    +113.8%     498432 ±  3%  fxmark.ssd_ext4_DWSL_4_directio.works
      4662 ±  3%    +113.8%       9968 ±  3%  fxmark.ssd_ext4_DWSL_4_directio.works/sec
    538786 ±  8%     +88.5%    1015570 ±  3%  fxmark.time.file_system_outputs
    163522 ±  6%     +59.4%     260664 ±  3%  fxmark.time.voluntary_context_switches
     36.06 ±  9%     -11.4       24.64 ± 46%  perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.text_poke_bp_batch.text_poke_finish.arch_jump_label_transform_apply
     35.74 ± 10%     -11.1       24.64 ± 46%  perf-profile.calltrace.cycles-pp.__static_key_slow_dec_cpuslocked.static_key_slow_dec.sw_perf_event_destroy._free_event.perf_event_release_kernel
     35.74 ± 10%     -11.1       24.64 ± 46%  perf-profile.calltrace.cycles-pp.arch_jump_label_transform_apply.__static_key_slow_dec_cpuslocked.static_key_slow_dec.sw_perf_event_destroy._free_event
     35.74 ± 10%     -11.1       24.64 ± 46%  perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.text_poke_bp_batch.text_poke_finish.arch_jump_label_transform_apply.__static_key_slow_dec_cpuslocked
     35.74 ± 10%     -11.1       24.64 ± 46%  perf-profile.calltrace.cycles-pp.text_poke_bp_batch.text_poke_finish.arch_jump_label_transform_apply.__static_key_slow_dec_cpuslocked.static_key_slow_dec
     35.74 ± 10%     -11.1       24.64 ± 46%  perf-profile.calltrace.cycles-pp.text_poke_finish.arch_jump_label_transform_apply.__static_key_slow_dec_cpuslocked.static_key_slow_dec.sw_perf_event_destroy
     35.74 ± 10%     -10.7       25.02 ± 46%  perf-profile.calltrace.cycles-pp.static_key_slow_dec.sw_perf_event_destroy._free_event.perf_event_release_kernel.perf_release
     35.74 ± 10%     -11.1       24.64 ± 46%  perf-profile.children.cycles-pp.__static_key_slow_dec_cpuslocked
     35.74 ± 10%     -11.1       24.64 ± 46%  perf-profile.children.cycles-pp.arch_jump_label_transform_apply
     35.74 ± 10%     -11.1       24.64 ± 46%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
     35.74 ± 10%     -11.1       24.64 ± 46%  perf-profile.children.cycles-pp.smp_call_function_many_cond
     35.74 ± 10%     -11.1       24.64 ± 46%  perf-profile.children.cycles-pp.text_poke_bp_batch
     35.74 ± 10%     -11.1       24.64 ± 46%  perf-profile.children.cycles-pp.text_poke_finish
     35.74 ± 10%     -10.7       25.02 ± 46%  perf-profile.children.cycles-pp.static_key_slow_dec
      0.12 ±136%     -88.4%       0.01 ± 50%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.04 ±  7%     -87.9%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.submit_bio_wait.blkdev_issue_flush.ext4_sync_file
      0.04 ± 13%     -84.6%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.bdev_getblk.jbd2_journal_get_descriptor_buffer.jbd2_journal_commit_transaction.kjournald2
      0.08 ±  4%     -93.7%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.01 ± 26%     -72.7%       0.00 ± 19%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.02 ±  8%     -79.3%       0.00 ±  8%  perf-sched.sch_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      0.06           -89.9%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.jbd2_log_wait_commit.ext4_sync_file.do_fsync.__x64_sys_fsync
      0.04 ±  3%     -90.3%       0.00 ±  9%  perf-sched.sch_delay.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 11%     -36.8%       0.00        perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02 ± 20%     -63.7%       0.01 ± 40%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ±  2%     -90.1%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
      0.03           -87.5%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
      0.01 ±  7%     -41.9%       0.00        perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.84 ±202%     -95.2%       0.09 ± 55%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.22 ±  3%     -14.5%       0.19 ±  7%  perf-sched.sch_delay.max.ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.11 ± 22%     -86.2%       0.01 ± 23%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.05 ± 91%     -55.3%       0.02 ± 39%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
      0.12 ± 18%     -61.2%       0.05 ± 88%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.41 ± 67%     -73.9%       0.11 ± 28%  perf-sched.sch_delay.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
      0.04           -87.1%       0.00 ± 11%  perf-sched.total_sch_delay.average.ms
      2.06 ±  4%     -39.1%       1.26 ± 13%  perf-sched.total_wait_and_delay.average.ms
    115501 ±  3%     +64.2%     189619 ± 12%  perf-sched.total_wait_and_delay.count.ms
      2.02 ±  4%     -38.2%       1.25 ± 13%  perf-sched.total_wait_time.average.ms
      0.42 ±  3%     -87.4%       0.05 ±223%  perf-sched.wait_and_delay.avg.ms.__cond_resched.bdev_getblk.jbd2_journal_get_descriptor_buffer.jbd2_journal_commit_transaction.kjournald2
      0.25           -46.1%       0.13 ±  7%  perf-sched.wait_and_delay.avg.ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.18 ±  2%     +17.6%       0.21 ±  8%  perf-sched.wait_and_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      0.31 ±  3%     -52.7%       0.15 ± 10%  perf-sched.wait_and_delay.avg.ms.jbd2_log_wait_commit.ext4_sync_file.do_fsync.__x64_sys_fsync
      0.43 ±  6%     -31.7%       0.30        perf-sched.wait_and_delay.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      3.34 ±  4%     -18.0%       2.74 ±  5%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    207.33 ± 13%     -31.0%     143.00 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.58 ±  4%     -53.6%       0.27 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
      0.96 ± 33%     -82.6%       0.17 ± 28%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
     49.87 ±  7%     +61.8%      80.70 ± 10%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.43 ±  7%     -51.0%       0.70 ± 13%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    473.00 ± 71%    +822.0%       4361 ± 16%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.submit_bio_wait.blkdev_issue_flush.ext4_sync_file
      2731           -94.4%     152.50 ±223%  perf-sched.wait_and_delay.count.__cond_resched.bdev_getblk.jbd2_journal_get_descriptor_buffer.jbd2_journal_commit_transaction.kjournald2
     15741 ±  2%     -17.5%      12984 ± 10%  perf-sched.wait_and_delay.count.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
     29502 ±  2%     -28.6%      21071 ±  8%  perf-sched.wait_and_delay.count.jbd2_log_wait_commit.ext4_sync_file.do_fsync.__x64_sys_fsync
      1212 ± 11%    +234.6%       4056 ± 13%  perf-sched.wait_and_delay.count.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
     67.33 ±  3%     +59.4%     107.33 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     21133 ±  5%    +121.0%      46712 ± 12%  perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
      4559 ± 14%    +545.3%      29419 ± 15%  perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
    700.00 ±  7%     -39.8%     421.17 ±  6%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     81.67 ± 24%     -42.7%      46.83 ± 46%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     32393 ±  4%     +94.4%      62968 ± 13%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      6.31 ± 42%     -86.4%       0.86 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.bdev_getblk.jbd2_journal_get_descriptor_buffer.jbd2_journal_commit_transaction.kjournald2
      0.18 ±  9%     -40.7%       0.10 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.submit_bio_wait.blkdev_issue_flush.ext4_sync_file
      0.39 ±  3%     -23.2%       0.30 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.bdev_getblk.jbd2_journal_get_descriptor_buffer.jbd2_journal_commit_transaction.kjournald2
      0.17           -24.8%       0.13 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.05 ±201%    +632.4%       0.39 ± 31%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_buffer_head.jbd2_journal_write_metadata_buffer.jbd2_journal_commit_transaction
      0.16 ±  3%     +30.0%       0.20 ±  8%  perf-sched.wait_time.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      0.64 ± 33%    +282.5%       2.44 ± 17%  perf-sched.wait_time.avg.ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournald2.kthread
      0.25 ±  3%     -43.4%       0.14 ±  9%  perf-sched.wait_time.avg.ms.jbd2_log_wait_commit.ext4_sync_file.do_fsync.__x64_sys_fsync
      0.39 ±  6%     -25.8%       0.29        perf-sched.wait_time.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      3.32 ±  4%     -17.8%       2.73 ±  5%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    207.32 ± 13%     -31.0%     142.99 ±  4%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.52 ±  4%     -49.9%       0.26 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
      0.93 ± 34%     -82.4%       0.16 ± 28%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
     49.86 ±  7%     +61.8%      80.67 ± 10%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.43 ±  7%     -51.0%       0.70 ± 13%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.54 ± 14%     -66.6%       0.18 ±104%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      0.05 ±201%   +1052.2%       0.61 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_buffer_head.jbd2_journal_write_metadata_buffer.jbd2_journal_commit_transaction



***************************************************************************************************
lkp-icl-2sp5: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/thread_nr:
  gcc-12/performance/directio/1SSD/ext4_no_jnl/x86_64-rhel-9.4/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp5/DRBM/fxmark/4

commit: 
  8de7606f0f ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  85975daeaa ("cpuidle: menu: Avoid discarding useful information")

8de7606f0fe2bf5a 85975daeaa4d6ec560bfcd354fc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1131064           +41.5%    1600002        cpuidle..usage
    486.00 ±  5%    +201.5%       1465 ±  6%  perf-c2c.HITM.local
      0.03 ± 20%     -50.3%       0.01 ± 36%  perf-sched.total_sch_delay.average.ms
  14347312 ± 38%     -49.3%    7267323 ± 72%  sched_debug.cfs_rq:/.avg_vruntime.max
  14347312 ± 38%     -49.3%    7267323 ± 72%  sched_debug.cfs_rq:/.min_vruntime.max
      0.81            +0.1        0.92 ±  2%  mpstat.cpu.all.irq%
      0.48 ±  2%      -0.2        0.26 ±  3%  mpstat.cpu.all.soft%
      2.57            -0.8        1.75 ±  3%  mpstat.cpu.all.sys%
     14804 ±  2%     +19.9%      17749 ±  2%  perf-stat.i.context-switches
      3.73 ±  2%     +19.7%       4.47 ±  3%  perf-stat.i.metric.K/sec
     14608 ±  2%     +19.9%      17512 ±  2%  perf-stat.ps.context-switches
    209850 ±  3%     +20.6%     253026 ±  3%  proc-vmstat.nr_foll_pin_acquired
    209859 ±  3%     +20.6%     253060 ±  3%  proc-vmstat.nr_foll_pin_released
   2377832           +21.9%    2898307        proc-vmstat.pgpgin
     25347 ±  2%     +22.8%      31128 ±  2%  vmstat.io.bi
     14877 ±  2%     +18.9%      17694 ±  2%  vmstat.system.cs
      9122 ±  3%     +41.6%      12915 ±  3%  vmstat.system.in
     24960 ± 36%     +73.1%      43214 ± 19%  numa-vmstat.node0.nr_active_anon
     18828 ± 41%     +85.6%      34938 ± 26%  numa-vmstat.node0.nr_anon_pages
    210207 ±  3%     +20.4%     253189 ±  3%  numa-vmstat.node0.nr_foll_pin_acquired
    210215 ±  3%     +20.5%     253223 ±  3%  numa-vmstat.node0.nr_foll_pin_released
     24960 ± 36%     +73.1%      43214 ± 19%  numa-vmstat.node0.nr_zone_active_anon
     44782 ± 17%     -36.4%      28468 ± 32%  numa-vmstat.node1.nr_active_anon
     44121 ± 17%     -36.8%      27905 ± 32%  numa-vmstat.node1.nr_anon_pages
     44782 ± 17%     -36.4%      28468 ± 32%  numa-vmstat.node1.nr_zone_active_anon
      2910            +3.9%       3025        turbostat.Bzy_MHz
     10130 ±  3%     +49.9%      15185 ±  3%  turbostat.C1
    569864 ±  2%    +140.2%    1368997        turbostat.C1E
      0.56 ±  2%      +0.8        1.37 ±  2%  turbostat.C1E%
    537096           -61.9%     204460        turbostat.C6
      1.74           +86.0%       3.24 ±  2%  turbostat.CPU%c1
    820197           +42.1%    1165477        turbostat.IRQ
      8915 ±  8%     +19.4%      10645 ±  4%  turbostat.POLL
     99588 ± 36%     +73.4%     172697 ± 19%  numa-meminfo.node0.Active
     99588 ± 36%     +73.4%     172697 ± 19%  numa-meminfo.node0.Active(anon)
     37742 ± 73%    +139.5%      90377 ± 39%  numa-meminfo.node0.AnonHugePages
     75122 ± 41%     +85.7%     139500 ± 26%  numa-meminfo.node0.AnonPages
     84070 ± 39%     +88.5%     158506 ± 25%  numa-meminfo.node0.AnonPages.max
    179088 ± 17%     -36.4%     113845 ± 32%  numa-meminfo.node1.Active
    179088 ± 17%     -36.4%     113845 ± 32%  numa-meminfo.node1.Active(anon)
    137933 ± 23%     -43.0%      78637 ± 43%  numa-meminfo.node1.AnonHugePages
    176447 ± 17%     -36.8%     111602 ± 32%  numa-meminfo.node1.AnonPages
    205517 ±  6%     -37.1%     129348 ± 32%  numa-meminfo.node1.AnonPages.max
     13.36 ± 84%      -8.4        4.94 ± 51%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     13.36 ± 84%      -8.4        4.94 ± 51%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     13.36 ± 84%      -8.4        4.94 ± 51%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      0.79 ±141%      +2.0        2.81 ± 31%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.79 ±141%      +2.0        2.81 ± 31%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     13.36 ± 84%      -8.4        4.94 ± 51%  perf-profile.children.cycles-pp.start_secondary
     12.54 ± 67%      -6.8        5.71 ± 35%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.79 ±141%      +2.0        2.81 ± 31%  perf-profile.children.cycles-pp.do_filp_open
      0.79 ±141%      +2.0        2.81 ± 31%  perf-profile.children.cycles-pp.path_openat
      0.79 ±141%      +2.8        3.58 ± 49%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.79 ±141%      +2.8        3.58 ± 49%  perf-profile.children.cycles-pp.do_sys_openat2
      0.18 ±  5%     -44.9%       0.10 ±  3%  fxmark.ssd_ext4_no_jnl_DRBM_4_directio.idle_sec
      0.09 ±  5%     -45.5%       0.05 ±  3%  fxmark.ssd_ext4_no_jnl_DRBM_4_directio.idle_util
      2.36           +17.8%       2.78        fxmark.ssd_ext4_no_jnl_DRBM_4_directio.irq_sec
      1.21           +16.4%       1.41        fxmark.ssd_ext4_no_jnl_DRBM_4_directio.irq_util
      1.50 ±  2%     -50.4%       0.75 ±  3%  fxmark.ssd_ext4_no_jnl_DRBM_4_directio.softirq_sec
      0.77 ±  2%     -51.0%       0.38 ±  4%  fxmark.ssd_ext4_no_jnl_DRBM_4_directio.softirq_util
      6.48           -45.6%       3.53        fxmark.ssd_ext4_no_jnl_DRBM_4_directio.sys_sec
      3.31           -46.2%       1.78        fxmark.ssd_ext4_no_jnl_DRBM_4_directio.sys_util
      0.69 ±  4%     -23.1%       0.53 ±  9%  fxmark.ssd_ext4_no_jnl_DRBM_4_directio.user_sec
      0.35 ±  4%     -24.0%       0.27 ±  9%  fxmark.ssd_ext4_no_jnl_DRBM_4_directio.user_util
    593614           +21.9%     723733        fxmark.ssd_ext4_no_jnl_DRBM_4_directio.works
     11872           +21.9%      14474        fxmark.ssd_ext4_no_jnl_DRBM_4_directio.works/sec
   1203810 ±  7%     +19.3%    1436084        fxmark.time.file_system_inputs
    160248 ±  7%     +18.1%     189302        fxmark.time.voluntary_context_switches





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


