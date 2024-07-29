Return-Path: <linux-pm+bounces-11521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6FD93EDF5
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 09:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D302B1C21C86
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 07:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6059A7D3EC;
	Mon, 29 Jul 2024 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+HwN1wt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC243AAB;
	Mon, 29 Jul 2024 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236804; cv=fail; b=aLojsgR48vPdGdJ6/OugMmUD6W1UIIffpUAMCSHDfSwRvg3Zyppuhrzkx245cEDaqBUymUncxq5d/Nf1KefHdaWnbVmC7q9R0c0HZioHCpHKQrKMAXSLZes7b+tHAF4DxrMUS4KF7cqmZiD5k9wINgW0/gbnAYK5rrFcm3sKTqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236804; c=relaxed/simple;
	bh=9z7UcoCtxWySNXnYpHUJ+dprZQ4J5O4SKVHuKBm9prs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LnFV2H3AGCdBD8OI4ys2lqBd8Bhl07zLQZmugUsje2IXk4bf3vVI+QLH8FnJN/azAR+gu1kcmPabjqRm6FUdr07S69+hEH++ICNvzn5ekKfAZc+dDhl6coaSy5hhIePfDyerfQZ7k9p7vCUJzp5rQ161OaQlfaGgDOwwyt2GN6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+HwN1wt; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722236802; x=1753772802;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9z7UcoCtxWySNXnYpHUJ+dprZQ4J5O4SKVHuKBm9prs=;
  b=E+HwN1wtNKNaA6tf9RP46IjK9aNPM3AmZFX9HHeEo3o/keTmvEsCyyAZ
   bugY2ASK/kQbQUgLjBqr/0Do47M8KXdBuO3D6cudzqgpTcusfUFPftuXl
   +40okeY6Py4LY9rkDRXjU43XEpRcBX8FMpMMbQqiIL0f+f1t1hEqxLvUe
   wnrLN2+S7N5nf58PPh9lg4ziBH7aBfSCQtvj+0zCCjkmDcRG1tfeutyW5
   ojBxn+8YV6Djd+eSYkGlw8hwIAQMcfw8LKMFl+9XlyT3xVwchFi+2GtJa
   a3BTTeynqirwDUnCdhRsbZ5vODWpyx5FYSOmDIFNwqJoYpwYKlKHQkN7l
   w==;
X-CSE-ConnectionGUID: tcjThCKpSc2PmDL6LzD/rw==
X-CSE-MsgGUID: rDXs95MFSL+QWAp2XOs1GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="31363303"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="31363303"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 00:06:42 -0700
X-CSE-ConnectionGUID: zbBUtpPvSGW8jEWXOiEdeA==
X-CSE-MsgGUID: HKcee93lRgi/b6CoAr6o6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="58727226"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 00:06:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 00:06:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 00:06:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 00:06:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 00:06:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmYMnD4Ke3lKVRXiCZrVmqSBIu+mfyjC2kIWSnAq5pi0Bh6L8XiAH0XO3bt/bcm/gIrlUSBs7YeLV6r30uDS+MTGeOpvhHfectgFGxSN1I4ljyyHWefc6+cgt97Agm65cuGAzPUZ2gr7rLhm9uRAENWiFlHAezkEvhhyL359AlNEBWAIy0blgZA2vm8mYefjXnJHxn9PN1P/FZP82wi//cyngcvtjhRXTGwUgHqPpJdVwRL0AsODxaNsvw2ps7cljnbgQ/9t6EFEXqjkrGzOM1ojxPXN5yDRRub6jd+SxsTY3EshdHnpe2bTncYCu0ZLfpKn4elM6j9OFSpp72dqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGg4Um2s/lA3iTggL6aymWbbvAwewUmiXz7LrAOFBCE=;
 b=jFlhHqANjkxJHM7/LSPhwZ9O5ZcKnx4rKzldE0Bzn8cBlcKAAJCflf5PH2Y5duPKIAGRZCUKJKHz3qFgWPG4EcDpCGKrFA5nsC3VqdUIyIwpgu1K3OfKEy4Ns7njbHf2Nj4xr6i9hPgk1ybsCWOkN90plPOFjb7+mr2G8FvWY9i4E5CzX+Lf3q7RzQ5tUt2S/UaWdcMSt8Awn8PYEwHQGn0JdXrDlPu+8dG2iMy5UtC4IwyeoiwoNi2ceGq5qq2DXrSjNbjyhqP1Cl6lKs2dLH/8qSMQhjHZkpGY/ng23FUXzq+YxRYkCsFZPEy5+yV1d9jvMMR4T8aXvDYn1zj0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CY8PR11MB7688.namprd11.prod.outlook.com (2603:10b6:930:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Mon, 29 Jul
 2024 07:06:37 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 07:06:37 +0000
Date: Mon, 29 Jul 2024 15:07:20 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <a3at.mail@gmail.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <hch@lst.de>,
	<rafael.j.wysocki@intel.com>, <pengfei.xu@intel.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: [Syzkaller & bisect] There is task hung in acct_process in v6.10 and
 v6.11-rc1
Message-ID: <Zqc/qDJq8oQjmg4t@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To SJ0PR11MB4847.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CY8PR11MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 055ef243-460b-4e7a-0971-08dcaf9cfc8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NDq/FeKdwEkyK4wqAcyYcVT62lXV5Glc8FymbZ1sdDz8qFaBilSn854aHLc6?=
 =?us-ascii?Q?XBfbUmnqer36qYGVqSNxuLPJxDiVUqP8YW/EAkmo3HQquE1voyryYfJS81Ww?=
 =?us-ascii?Q?65gyP4zEJRsGg12VYAQ10x8rZDIJ4QpwrlebrPlLS4N2LKUV18gga8VYUw0G?=
 =?us-ascii?Q?PRfZkWJ8AlYq3zXZi5WDPAEnD43pWl9Zyii5loNq4rCffTBKI/eQhuQrv6qk?=
 =?us-ascii?Q?OQUo8fUPpZ+ul6iPANAHALLH7/EPRPMFC3FH3oWtqGw1JIoNLgRzt05pcNH4?=
 =?us-ascii?Q?o5GHnB0HOK1VIFNtf/R4mXnXkm4oaSI+OyutB4hwQ5w2y7TexUbiyUsNCFDB?=
 =?us-ascii?Q?jkT36jv63vA1PZWEXU2M14urknZqr8xDHrWZiyEDgJRGktIB5PN3qxUXMVmf?=
 =?us-ascii?Q?t3PEZMUIqBZoaMpBWenOOUVS1NIF+JQFQyVnOobYMkuVkLk0OdrndZ53N953?=
 =?us-ascii?Q?+phUrtCZlIXL/jHNWlIHTj2DvmIA8Xw5bPPwyGyjr17G/s76kTWCmSEojPm8?=
 =?us-ascii?Q?qmzsw5uzwFJwTdetbWqf4YzEorSGzR/xh/F/7FNpAbhWALkSZZlmXUFGMRF6?=
 =?us-ascii?Q?uekdzl9nXgLKshFIthmhVfmPS3qj38VJ1Dj/p9fu2oP86nJeXxOZAHx81CWx?=
 =?us-ascii?Q?Tuo+jMqg9mmEul+j/EiJD1rAST9N2x4iV8v/Eps/18DBDNWsfD1OSKF+c6l/?=
 =?us-ascii?Q?WQGW/KkSpeimN1yZ/8RofXFdGhJAuWMwxOnBx9ojM0OPvMTDIYdk6J6WOOyW?=
 =?us-ascii?Q?NtcXwMdmkQae+pn7Og9BTsUcgHOUS2j8hOgLTehqXBOGiujz/NtuzrdnnxJt?=
 =?us-ascii?Q?WS41xoFNeTzAkL0LA2pU42ppS7bvzRLa2qoOV1/3uTKLxxpLLrNmnjqJLFY+?=
 =?us-ascii?Q?qJ26FsASFUbUVrdI08I4gZ2VH54BpsYugNVQXJDMfWV9RJxMnD6qoogAs8xR?=
 =?us-ascii?Q?68dhLgN/bHYIh9OBlmCreOmA/t/fLAckWEn2C4Fv2rR6XftTqn2sxIRIKOTW?=
 =?us-ascii?Q?3QwIYUq98kkHjEjUpbGn83pi3C3K3MxW9rT1XeiVD+aC2+9RMJBKYsDfwu27?=
 =?us-ascii?Q?5gFsaX5W1bylbT8d1CEgNKuu5cqL0xOq4gwafLDerfFzHogrdlYjDmVx6yyT?=
 =?us-ascii?Q?sv3Ip5ZbnGk5VO/YJ5rL1mAeCMwlqAGhmUCC7nvhxNhpXNYCtweFDpBF7xW7?=
 =?us-ascii?Q?WjUIn8m2xj7LAPqV3alM2Sk2For5TLa3c6cJDAF6Nj5RvMnwBDWXQGEVKT+h?=
 =?us-ascii?Q?XJk93LUJMMihjFjHxy1HJKgKT+bkVatAwQsNAWYjTKwYSksocJPqCuJkSglW?=
 =?us-ascii?Q?wuk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f/iBDKD9kxQ9i1ooODDkTrTSsJ9L0mbctRypVpKFFXAwOCtB1zCWFEkyTBeh?=
 =?us-ascii?Q?cpM8YNS7d3vqWXdo8QsQFM+E6rgy+kHCwc64EWK2dmZ3Bgxw3UBv5Km+8wJj?=
 =?us-ascii?Q?tHmLtm32uC4sWpI2PlymyK3qsJtx2AJUgj/HkfpQ5HiaJPMUz4R32iQL3kw0?=
 =?us-ascii?Q?dSP93aKxe4NNOyOgmONDWGBNxGk04GVGYw4ApjNYvyegz7iR2HJ5zhxXl3+t?=
 =?us-ascii?Q?HU7G5PnZWjOktamOZNUrBw/wO2oPXaRfucw8JubG8VfktXCurz9TAsOSzwYf?=
 =?us-ascii?Q?0/kFj3M3jdZxlL3g2e7Qohn5EnNj25gUtPCVp+YjInqjIOMAnh8RAf05m0cB?=
 =?us-ascii?Q?Wk0efCS7lFfVt7f52pDdrs5pUF9WSjJTNeUEDbfUoya0szlq8yOVn5QAXs+P?=
 =?us-ascii?Q?YRYxSYgeQoRPjGtMkdjZP/h0+RuXFbjXWxJ6hxdcMiXunfbRH0oc3j0/eVKi?=
 =?us-ascii?Q?YrIkFZfHV6Hpbcj4L+9Eaj1fjIcBLi66YCV1dTI/kz/tPsGSSkMrdo0HECvl?=
 =?us-ascii?Q?4SCuT/K+iDG8bTfgb8ONghQefm+vHTgY5HP8fr5i5Urmm6BQs0/1uh4preha?=
 =?us-ascii?Q?XuKR20fs+QGlp53ogqx9ACiSTI9KctjLc+t8wfHSEGVnfClvkrcYaFuxaINy?=
 =?us-ascii?Q?LjX2OiRAH0Feg4QKacopYgpul4iMOZk+HoWAVW7nMDhkl5u/Z4FlUKzFzUPt?=
 =?us-ascii?Q?4NbLadU5xPKtvb/mT62gg8RhPmcJzASc07gCXxQd0RcfkbxNucc4o3qt2ImK?=
 =?us-ascii?Q?+p5GpLf73eFqAmvLt6lwVdXO8bP4kwgVWvKV9/92tT8aivAhmG/PGuwWUc2p?=
 =?us-ascii?Q?2aOOBIkmXHcBVZ3dkEntbwNGQuaah5l/FjfMA+W7CcMWR49BURAbB8/eiWi2?=
 =?us-ascii?Q?rEMfy938Yhj7CfHvbKurZtV6g7+tNpl9KDWSltiPlZsCdCtcyTePQHTOBo2G?=
 =?us-ascii?Q?ZtLsUqat0OmyLzp6OsP5f8uO6Q/Ld+A2c/KZWa17Hh4Gw12fp/TkMhbdP/aU?=
 =?us-ascii?Q?2Opb43AGpfxWFZU2XWmZhehVXrIvwy7ppB0Nw2jXLM8t8nCvf4qyWQ7yMZm6?=
 =?us-ascii?Q?5wnapSsvaxSPH39kEZY22UEFOTpzpeGUIyEhrdwYMGDI8cV4sQag1uUU3zuv?=
 =?us-ascii?Q?4nYBtDTsX+eZeaM8Org4lDF1o+Zs7fbVmVIvOt5m8uK0aHyNIZVSorTY7iEH?=
 =?us-ascii?Q?z9ZSVYw63gu6NK06nBPqJW1JxT1CfnSZQ/eTyfNRfagJXwqogtii1trM9xfZ?=
 =?us-ascii?Q?09XsCoRPL4YlfeZDOrST6wO5kabUkUjJbBsdhyBM2Jz48phB0Dfo/S7w9BEj?=
 =?us-ascii?Q?dV6ABCAks8E25IVx7zcuTg/c3M181tKyE0LlW4cKRpRopdufDhXHk07wPnBA?=
 =?us-ascii?Q?H+/h1vzxcwzs949jRNZ/OmfmEA0wsPejwIkCt1fpEjPSqjOC3kTtz21ygJDr?=
 =?us-ascii?Q?MFso7ioLZ34R80zV7IDeoI+/Al5AfTEqb728ExngyolhWFwYMIT1UcyWYGO9?=
 =?us-ascii?Q?mHLAKC0pXhel4dcZsEvk/sRx+sdyqsELZlh4EiPqGkNd/5mt73dDtE+1P9+7?=
 =?us-ascii?Q?heBAvpy/CNNw/y5mAfuriN33YiDlerQLtrmApJ4s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 055ef243-460b-4e7a-0971-08dcaf9cfc8b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4847.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 07:06:37.6189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiIqK+aO5aX3pxn1cfOErqZnzc8BG90XRREkRyNeaXCpTEPgG0SuYJoxqYVBTMmPqlKkLc18ttf1Rtor4z5NNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7688
X-OriginatorOrg: intel.com

Hi Azat Khuzhin,

Greetings!

There is "task hung in acct_process" in v6.10 and v6.11-rc1:

Found first bad commit:
c9e4bf607d8c PM: hibernate: Fix writing maj:min to /sys/power/resume
Revert this commit and the issue could not be reproduced.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240728_080131_acct_process
Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240728_080131_acct_process/repro.c
Syzkaller syscall repro steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240728_080131_acct_process/repro.prog
Syzkaller analysis report: https://github.com/xupengfe/syzkaller_logs/blob/main/240728_080131_acct_process/repro.report
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240728_080131_acct_process/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240728_080131_acct_process/bisect_info.log
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240728_080131_acct_process/0c3836482481200ead7b416ca80c68a29cfdaabd_dmesg.log
v6.10 bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240728_080131_acct_process/bzImage_0c3836482481200ead7b416ca80c68a29cfdaabd.tar.gz

This issue could be reproduced in 600s in guest.

"
[  300.358849] INFO: task systemd-hostnam:283 blocked for more than 147 seconds.
[  300.358511]       Not tainted 6.10.0-0c3836482481 #1
[  300.358849] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.359357] task:systemd-hostnam state:D stack:0     pid:283   tgid:283   ppid:1      flags:0x00000002
[  300.359958] Call Trace:
[  300.360137]  <TASK>
[  300.360293]  __schedule+0xba3/0x3120
[  300.360589]  ? __pfx___schedule+0x10/0x10
[  300.360866]  ? lock_release+0x418/0x840
[  300.361124]  ? __pfx_lock_release+0x10/0x10
[  300.361401]  ? __pfx_lock_release+0x10/0x10
[  300.361668]  ? lock_is_held_type+0xef/0x150
[  300.361978]  schedule+0xf6/0x3f0
[  300.362201]  schedule_preempt_disabled+0x1c/0x30
[  300.362501]  __mutex_lock+0xc32/0x1660
[  300.362751]  ? acct_process+0x1ef/0x670
[  300.363011]  ? __pfx___mutex_lock+0x10/0x10
[  300.363278]  ? __this_cpu_preempt_check+0x21/0x30
[  300.363581]  ? lock_release+0x418/0x840
[  300.363849]  mutex_lock_nested+0x1f/0x30
[  300.364101]  ? mutex_lock_nested+0x1f/0x30
[  300.364368]  acct_process+0x1ef/0x670
[  300.364607]  ? acct_process+0xa1/0x670
[  300.364867]  do_exit+0x198d/0x29f0
[  300.365095]  ? lock_release+0x418/0x840
[  300.365351]  ? __pfx_do_exit+0x10/0x10
[  300.365599]  ? __this_cpu_preempt_check+0x21/0x30
[  300.365919]  ? _raw_spin_unlock_irq+0x2c/0x60
[  300.366205]  ? lockdep_hardirqs_on+0x89/0x110
[  300.366497]  do_group_exit+0xe4/0x2c0
[  300.366738]  __x64_sys_exit_group+0x4d/0x60
[  300.367006]  x64_sys_call+0x1a1f/0x20d0
[  300.367259]  do_syscall_64+0x6d/0x140
[  300.367505]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  300.367827] RIP: 0033:0x7f8ee7118a4d
[  300.368059] RSP: 002b:00007fffeace3298 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[  300.368523] RAX: ffffffffffffffda RBX: 00007f8ee71f69e0 RCX: 00007f8ee7118a4d
[  300.368955] RDX: 00000000000000e7 RSI: fffffffffffffe88 RDI: 0000000000000000
[  300.369386] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f8ee7201b20
[  300.369828] R10: 00007fffeace2fa0 R11: 0000000000000246 R12: 00007f8ee71f69e0
[  300.370265] R13: 00007f8ee71fbf00 R14: 0000000000000002 R15: 00007f8ee71fbee8
[  300.370721]  </TASK>
[  300.370867] INFO: task gmain:291 blocked for more than 147 seconds.
[  300.371257]       Not tainted 6.10.0-0c3836482481 #1
[  300.371566] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.372040] task:gmain           state:D stack:0     pid:291   tgid:290   ppid:1      flags:0x00004002
[  300.372617] Call Trace:
[  300.372778]  <TASK>
[  300.372922]  __schedule+0xba3/0x3120
[  300.373167]  ? __pfx___schedule+0x10/0x10
[  300.373420]  ? lock_release+0x418/0x840
[  300.373676]  ? __pfx_lock_release+0x10/0x10
[  300.373954]  ? __pfx_lock_release+0x10/0x10
[  300.374226]  ? lock_is_held_type+0xef/0x150
[  300.374499]  schedule+0xf6/0x3f0
[  300.374724]  schedule_preempt_disabled+0x1c/0x30
[  300.375022]  __mutex_lock+0xc32/0x1660
[  300.375271]  ? acct_process+0x1ef/0x670
[  300.375528]  ? __pfx___mutex_lock+0x10/0x10
[  300.375800]  ? __this_cpu_preempt_check+0x21/0x30
[  300.376105]  ? lock_release+0x418/0x840
[  300.376369]  mutex_lock_nested+0x1f/0x30
[  300.376627]  ? mutex_lock_nested+0x1f/0x30
[  300.376893]  acct_process+0x1ef/0x670
[  300.377131]  ? acct_process+0xa1/0x670
[  300.377380]  do_exit+0x198d/0x29f0
[  300.377607]  ? __this_cpu_preempt_check+0x21/0x30
[  300.377920]  ? lock_release+0x418/0x840
[  300.378168]  ? __pfx_do_exit+0x10/0x10
[  300.378414]  do_group_exit+0xe4/0x2c0
[  300.378654]  get_signal+0x2387/0x2460
[  300.378907]  ? __pfx_get_signal+0x10/0x10
[  300.379175]  arch_do_signal_or_restart+0x8e/0x7d0
[  300.379470]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[  300.379874]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[  300.380207]  ? trace_hardirqs_on+0x51/0x60
[  300.380480]  ? __this_cpu_preempt_check+0x21/0x30
[  300.380780]  ? syscall_exit_to_user_mode+0x109/0x1f0
[  300.381098]  syscall_exit_to_user_mode+0x13e/0x1f0
[  300.381405]  do_syscall_64+0x79/0x140
[  300.381644]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  300.381973] RIP: 0033:0x7fba2bf4296f
[  300.382210] RSP: 002b:00007fba2b5ff1c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000007
[  300.382683] RAX: fffffffffffffdfc RBX: 00007fba2c2ce071 RCX: 00007fba2bf4296f
[  300.383128] RDX: 00000000ffffffff RSI: 0000000000000001 RDI: 000055c951da3b10
[  300.383577] RBP: 000055c951da3b10 R08: 0000000000000000 R09: 0000000000000000
[  300.384022] R10: 00007fba2c70b080 R11: 0000000000000293 R12: 0000000000000001
[  300.384462] R13: 0000000000000001 R14: 00007fba2b5ff230 R15: 000055c951dbd270
[  300.384918]  </TASK>
[  300.385071] INFO: task gmain:350 blocked for more than 147 seconds.
[  300.385460]       Not tainted 6.10.0-0c3836482481 #1
[  300.385780] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables thi
"

I hope it's helpful.

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!

