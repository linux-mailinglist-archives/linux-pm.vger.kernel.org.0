Return-Path: <linux-pm+bounces-7932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E22258C84E7
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 12:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A3DB2284E
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 10:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5419C25750;
	Fri, 17 May 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxEKwlbg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A15BA39;
	Fri, 17 May 2024 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941978; cv=fail; b=i4Eog+5j24mU6UyLxRe8O+5sZg+trc2r4WWkYGo4Dv07oAUuYDwEVAYNRvR03HXok5MugN/FmX1NAjgL/nYuuuD2ek28XlZLSB+9uhPDY35R/xqF91qblT03KIQ3nhp51OYn7MVjg+ujZ7xNvBfYGdvExMMFGB++I2xcQeYhGCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941978; c=relaxed/simple;
	bh=HRy+yfsKGyh7GEaSsppTaEkq5GUQ+HdxzndkHAufUlg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ROonzrpVjk0ZVMyxQgpCSg2j8hiu5BRVLom/sTX3Tql4cb6hyKP9s0HQD6K3WQdiHpVCf7Ux80tAJNTuqCt2kXxb/3oeOoWtP4FQHgiGWpb8uqAkYx4vt3Rjo5lVIcU9qzEN7TLXGV8yCsbrXpNNlQ9Z1mCOgKfRHm7kOyOVz9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxEKwlbg; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715941976; x=1747477976;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HRy+yfsKGyh7GEaSsppTaEkq5GUQ+HdxzndkHAufUlg=;
  b=BxEKwlbgIBACp+A9N34oT21nSSp5yqb5MSGBhlW+kQ3dbdVAHbDpxgRT
   Q0pwEyevCkInw4JZfRni3thPKWU4ahKrA7s5A7IQiNhSkHGhpYuXCW1ND
   8epZ6oY5vczzfOUSkW9jLIVuAfvTW3dNpQbNLPqkOcVp1poT36NHu13A4
   fLcUd+q50TNP02WR7ZrdQU0vhLd9X6So57PKQi3GBJvLGc/wxRW5Mxu9d
   mEYFseW5AcG9gdToWNtz6pkYCdJy8kyWodyZErNSNqC702+2cBI1Itn7r
   VNruOZ6vMGfAU+w+q5TaGYgi7gy5QxZntVvo/TBMFLLnfZ9Tta0Yw/joW
   w==;
X-CSE-ConnectionGUID: RghvKPPLQkC4JB5mJgOBrA==
X-CSE-MsgGUID: HNE81bheTumXM7CT2/IZHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12233716"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="12233716"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 03:32:56 -0700
X-CSE-ConnectionGUID: lAUvu2h6T8eRHy40ebqCZg==
X-CSE-MsgGUID: XVusGNy3T0awOLjq8O4zYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="32287114"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 03:32:56 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 03:32:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 03:32:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 03:32:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kxm1Y9KB8rE662u0kSbGlpIdBTqtoA+ezh5Atoju+CcB/B+VZFs+yKZsoJckCM/TsWUw0JyGB3zoQBjzieRonjSx5/1eqmxkjBAbQuAA7GtEENbO8ln9o+PfMAyJ+kBcA27F2oHrnDWz1Dr72n/kJilwIjcs6hTIuszzrqzsS/WAqrw1zFmddfJUMDa9s8JBwyymtKdZJ9uFchJ3IyVHwO+VAQ4u3v5wSfeFCPde6k7XnP+aW3iaJyCd4OHUKyoDHg8XHxKzKnGdvwjwAk6jeOXPDdJoYJoK73wgdpHlT7GXjEQGPz2VKP/qWMx65U/jbfCOoMgA6snXEQhWHJ66Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEbnHp3Op8MXd8IhntOzgD8IJGJEPP9dMiHyRVf3pxA=;
 b=bkDAQxFMVeL3i5ryg4bOi34NI0c9quRN9s1Mwl8IJwWI0xyQjGH2Xm8+VOrhl+LnttKeVmQI9xCYb4iqtm+lVUp/n0AtfGiT+jPzXlXbd1K2iDikVXjAO90GjN34RohEZrLsZThuE+lrFr4X24ryzlXygD58JLzZoHSr1EcKgxUoC6mgofE1BP5GbHRwpsjaPtU1OHOz0dfgGG3uSFmOnGMmDKsMrWPNxMw6tYGrzE0tykt5uZCIjx+3v0KEoHLRXECo30POEbzyDYg4TvjNr5Vy2EG0fuYJg5iBPyLmFilWAXa3MFGA65TQqIbOuqdFA3/fG2WoxtPZsGe3NbpC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8490.namprd11.prod.outlook.com (2603:10b6:806:3a7::14)
 by IA0PR11MB8353.namprd11.prod.outlook.com (2603:10b6:208:489::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29; Fri, 17 May
 2024 10:32:53 +0000
Received: from SA1PR11MB8490.namprd11.prod.outlook.com
 ([fe80::61ff:e976:3464:9f6e]) by SA1PR11MB8490.namprd11.prod.outlook.com
 ([fe80::61ff:e976:3464:9f6e%3]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 10:32:53 +0000
Date: Fri, 17 May 2024 18:32:21 +0800
From: Wendy Wang <wendy.wang@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v1] thermal: core: Fix the handling of invalid trip points
Message-ID: <ZkcuVPWNLOxxBu9x@p-catlow01.sh.intel.com>
References: <12441937.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <12441937.O9o76ZdvQC@kreacher>
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To SA1PR11MB8490.namprd11.prod.outlook.com
 (2603:10b6:806:3a7::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8490:EE_|IA0PR11MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: b477907f-8a06-49cb-0424-08dc765cb590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pG63WF+ciWFLTISVEBNyrLncHhZroqKhDkXbTvdf47uQks+/IjVWdrFQCVLA?=
 =?us-ascii?Q?phZgXKFbVQs/+0gviRUHIotlpLTlBXN82AbGKxuV0UTHVuXB1kDE1acBmb22?=
 =?us-ascii?Q?FjKLegIaa1Eq3pxzV+UGEN+wn6JqLno1mCsYNCcP2r3I1CooDPc+lhFGg09i?=
 =?us-ascii?Q?pNV7KCFqxruMPFz7BpQ+hGyM8c+jSu/nNZLY1K35qxploVqVU0lu75fUo/IT?=
 =?us-ascii?Q?tSiPAcwEQ3ZIga6HrPFUlgKoo+lpyKNGfjZQLuQ2oYJQAy27iOPwwAnrki+d?=
 =?us-ascii?Q?6HnIqmMbYviwanr3lxYJ3HYGmLE9EfyzBV1DIE2zA3rTyfTgc1DQ764fjxo1?=
 =?us-ascii?Q?Ijq8t3GLntKbM6PXByYpmZs3xgw88H48QQ1tW7XQBj4QfrpF+utVh8y8VveW?=
 =?us-ascii?Q?9aBpr/g+DVhcexce4wD47TrGNTLEWVP4U5maAjVBptZF/qDQfx+lKoU46EW1?=
 =?us-ascii?Q?wR4SMEktLumrkvjg90xSltYOMbmQjzWuIRAVPOtLAPLQ7pxDYKKeoE+mhn6N?=
 =?us-ascii?Q?FF7KglX0ouXXy5oowhgRxUTc8bA3e+U++PO7gHPOGJC6dyGUS2Iu6zpa/ysd?=
 =?us-ascii?Q?rRib1oZJhwxa9y5cBiscahoTuZU4XOA0lcq6HaQnceHTdlqPYnKBiR2Oc5/P?=
 =?us-ascii?Q?fKjpPYakZaoKnoAlkf4qCzDSk4M+PekYI6+kaQpow0Fc6sDUhXqm3ru2T6ef?=
 =?us-ascii?Q?ydHFy+rxgV5vGWQuxfsxTUbW/ydDwtdAmWPBeUrQRPAXXoN/zx941tsPv6bs?=
 =?us-ascii?Q?9RNS5w8gKJmnGck1s+lyLhPbeYlne0yrc4X1YVCwBBUcP7ogA45CldB6jRed?=
 =?us-ascii?Q?sd8mQZUzGS5idTBoeWZWYpCrB5L7Aak4+jwlbmQodcV1BuXW06fPydgc3CZn?=
 =?us-ascii?Q?UYF/bC1B6GrpTSFhDgVIUISx0FHqRn6biufhOg/toZ+NEz+gAv6Vl2GmaxPw?=
 =?us-ascii?Q?Ge7inOlwK2lj0k8G4tzFIFB0T65w+pIot9hjIvFaZsoY9eoAbOL2aaROfw08?=
 =?us-ascii?Q?lLEKKSt2fUPHrUGhwy2Lc02TCWaDhlxPvUuHEDnuwhgMyfCqK1yTwBvlDhvI?=
 =?us-ascii?Q?r93zrkt3+v0nBINH5v74W+Kd53Uo5ZeYjsrPJWRSwI73gQTvcNYXhI7SQ05j?=
 =?us-ascii?Q?bJMnLVFiSCViC+80W7GDKI4tkgDIIs1HTllMOAMPjYYoF0FaHf9Pc7WoC8/R?=
 =?us-ascii?Q?TRuDiVfUg3kRkoDQA6yKxe5LRlmZPKdkQyXJMCj5tYibeQCXMrECI5jM+II?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8490.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?10oOetQi4y+9rVFMe6Oznpc+9UdY93z5KcuKV3LKcz09RIglzGPQvwemtyAX?=
 =?us-ascii?Q?6ZKIWbTUmpnILB/VvgPpeULwWcd1bUpmv99ARtzr2neO761inLnnHPKnfrbC?=
 =?us-ascii?Q?cr33fP2ilYizWvYIonXrWdRTzqvPKVByEwG3yJmCX52maeldM+PGuJcaDa3b?=
 =?us-ascii?Q?rv2BXDSZuriuBBj7b12XInnmWLJDlMCrTv3xfy7l7wdkcI9e9R56Iu1jeJGJ?=
 =?us-ascii?Q?sZ/j6v455oVB3rqObm36W6v/gtejYBjSBGUg5bcMOvcthymUGBXkFuOEbWz6?=
 =?us-ascii?Q?mSVwRfEXjxE+b55qxBSC9kfM4VNp0FBZ3VfFfR7n3VmBlVuZzd+VfhEP68FG?=
 =?us-ascii?Q?A2xR34hQvG+4N7QWQd3xgmm0DueFThpxu9GpD5oZv4YrdiQIg1FtjFTsreRS?=
 =?us-ascii?Q?RusmiJGHWiugrYSN/MWESc62LUdXJzVuTLlu2NdwUOdWsjRgYSSg6PCiHu3x?=
 =?us-ascii?Q?Hcj0tcx/+0k/DfYWexjFPOIatZY/vto9RhhKFlsZ25jr57VV/pmYfondQiVE?=
 =?us-ascii?Q?Kj+DmKAwfoEJGCTkh6g9DBUjhpHvH0hQeG8Y1ipqnoVUZIyQJc36452uI2h0?=
 =?us-ascii?Q?yJZR3mtwv+nIMEc6T0JIyELx1jdzvgOMsYvz0y16/MA4JlV6zGTEaYp5r492?=
 =?us-ascii?Q?gfcif9rO4D3JwooiLbnFfXo2mrUNJI4nwww+qNfAnC8Wu/bR6T88dT9Rs2MH?=
 =?us-ascii?Q?CDUdC6+421xd6QccoosRywVrZi/7Klq5gblITXKAC43gFkQjL+06d7zBw/Dk?=
 =?us-ascii?Q?4SwVE/S0KraZZGAxRlS6jLmZiT3CcXYdYk+OpF7IASijn3QHGzTFb5Kj+mtb?=
 =?us-ascii?Q?Aoa4yLrpMdPJ4o85Wu0ddbG0SQHksoz+rPnJT8818XN1TRj5zAHBWM8dHETQ?=
 =?us-ascii?Q?J9xIlSPuloQAzLhbAd/zGvuwOZN/utVtQ7QAYrQKvGS9Q5dsUhKs+T6G0T3i?=
 =?us-ascii?Q?q/O7+pb3HVjmz+wWIW1cIx7x3pimFaPmnRhLhPHbA8gX4YNBIaJ3M1OHgjMq?=
 =?us-ascii?Q?K++rQJcOdxvZO47Gcd53Dhq78aouodG1eUAzin++u3LuZOnUVnS2GbZJO1tI?=
 =?us-ascii?Q?jiN5cfV9wGN+y5HXlHvOfPN84ftAHr+AzPO0boJi0D6G9dp9cJoOkHJ2aQHO?=
 =?us-ascii?Q?u8fnzAyNo7TK4w+6cUAvMExuaL4aWR6e6Ud2TeH2akozFS6WMAPdoLrd3NlL?=
 =?us-ascii?Q?U5mX3lBvmF+8N2ry+dRm2R53QlT8nNk1CQ88GB764XkInjc6Kb0Fv4/npAyM?=
 =?us-ascii?Q?mi3A8FRjmw0HW06Bn30zuAga38JPwMTCkiHw9OlonvQcyjnf5tz74x5laH4U?=
 =?us-ascii?Q?XR1AHCw6HBfDTGFyPAOHxM3fZ5R8tmFzt7w4+b81bYt2PIw3z/AqyrJWTRTg?=
 =?us-ascii?Q?C1osB4TzgzbFrpUn9A3S4l9gg+f9RU9MYwM1UX2601Rgbh7e6TgfwYsk4Th+?=
 =?us-ascii?Q?nt/Ze6VcvJYpJTcGEOeImSGq1RycoARo+DwSpxTU/SCKeyDiByQucP/3cBLb?=
 =?us-ascii?Q?SCdPveWN8QlG7atpp39Pkge75S84+wAwVBjU9Myloo4jygqZp9jAq0zVCp0h?=
 =?us-ascii?Q?p/nvz2DK4i0T9RNUjGc1k1EFZm5HJtIlFNvnYtNd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b477907f-8a06-49cb-0424-08dc765cb590
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8490.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 10:32:53.5770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViV7trF5FzywszIu9W2wqh6/z8QPOs8rgAep7Uk1dKxg5DXqnivj2dnKJuYuPbQvT61fFfiGY2wmbxkRQoK1Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8353
X-OriginatorOrg: intel.com

Hi Rafael,

I have tested your patch '[PATCH v1] thermal: core: Fix the handling of invalid trip points'
on my server, which is running the v6.9 kernel, the thermal throttling test case has passed.

Tested-by: Wendy Wang <wendy.wang@intel.com>

On 2024-05-16 at 19:20:19 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 9ad18043fb35 ("thermal: core: Send trip crossing notifications
> at init time if needed") overlooked the case when a trip point that
> has started as invalid is set to a valid temperature later.  Namely,
> the initial threshold value for all trips is zero, so if a previously
> invalid trip becomes valid and its (new) low temperature is above the
> zone temperature, a spurious trip crossing notification will occur and
> it may trigger the WARN_ON() in handle_thermal_trip().
> 
> To address this, set the initial threshold for all trips to INT_MAX.
> 
> There is also the case when a valid writable trip becomes invalid that
> requires special handling.  First, in accordance with the change
> mentioned above, the trip's threshold needs to be set to INT_MAX to
> avoid the same issue.  Second, if the trip in question is passive and
> it has been crossed by the thermal zone temperature on the way up, the
> zone's passive count has been incremented and it is in the passive
> polling mode, so its passive count needs to be adjusted to allow the
> passive polling to be turned off eventually.
> 
> Fixes: 9ad18043fb35 ("thermal: core: Send trip crossing notifications at init time if needed")
> Fixes: 042a3d80f118 ("thermal: core: Move passive polling management to the core")
> Reported-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/thermal/thermal_core.c |    9 ++++++++-
>  drivers/thermal/thermal_trip.c |   18 ++++++++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1401,8 +1401,15 @@ thermal_zone_device_register_with_trips(
>  	tz->device.class = thermal_class;
>  	tz->devdata = devdata;
>  	tz->num_trips = num_trips;
> -	for_each_trip_desc(tz, td)
> +	for_each_trip_desc(tz, td) {
>  		td->trip = *trip++;
> +		/*
> +		 * Mark all thresholds as invalid to start with even though
> +		 * this only matters for the trips that start as invalid and
> +		 * become valid later.
> +		 */
> +		td->threshold = INT_MAX;
> +	}
>  
>  	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
>  	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -137,6 +137,24 @@ void thermal_zone_set_trip_temp(struct t
>  	if (trip->temperature == temp)
>  		return;
>  
> +	if (temp == THERMAL_TEMP_INVALID) {
> +		struct thermal_trip_desc *td = trip_to_trip_desc(trip);
> +
> +		if (trip->type == THERMAL_TRIP_PASSIVE &&
> +		    tz->temperature >= td->threshold) {
> +			/*
> +			 * The trip has been crossed, so the thermal zone's
> +			 * passive count needs to be adjusted.
> +			 */
> +			tz->passive--;
> +			WARN_ON_ONCE(tz->passive < 0);
> +		}
> +		/*
> +		 * Invalidate the threshold to avoid triggering a spurious
> +		 * trip crossing notification when the trip becomes valid.
> +		 */
> +		td->threshold = INT_MAX;
> +	}
>  	WRITE_ONCE(trip->temperature, temp);
>  	thermal_notify_tz_trip_change(tz, trip);
>  }
> 
> 
> 

