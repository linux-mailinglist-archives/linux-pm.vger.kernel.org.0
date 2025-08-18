Return-Path: <linux-pm+bounces-32497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7178FB29A3B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 08:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5D8200200
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 06:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09F9279331;
	Mon, 18 Aug 2025 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdrbmQi4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5B27877D;
	Mon, 18 Aug 2025 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500108; cv=fail; b=CRvd2RrudD8SXHpxuklt/ny1BZWpVOeHVCws1WcT/jCKs7Ic2UxnECEuqKKJPOmjKXOSSvKD7zNYwVrF+D5jXF5faW7NIbq12J1a0NmYiIvSTSEaXDsAvS2cNIUndbakYvM2uzxdgFOtTtnW2DBxYEBlrdjmJPk3qMNTD5fm62E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500108; c=relaxed/simple;
	bh=D0QIrQXrDYqmzWGetTCT2anfMDPo8ROmXHet4bPo+b0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hZ2UBIuFx1hGUA0xQu9Hkd/TtqPdL9vd1YXq26SZqU5+Ex5UKZCuFBKbsAY9kPVMxTWsoEmi5iHan6FAeQHLu3/1LxTvBxa8DtTCBrr9ouzudAVw9ap1v532zCotncznWFYd4bmfqumu7W4i7Ie9MnlVOU4TTuQ/7vNdCA+9qI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdrbmQi4; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755500107; x=1787036107;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=D0QIrQXrDYqmzWGetTCT2anfMDPo8ROmXHet4bPo+b0=;
  b=DdrbmQi4aEV3Y4XsJVlcLcihd4dNrnmqU6rK2UZjzgIpLvsmpqRM9nIn
   tswif5orBYOVkSf7gV9nJv1txe3nkDNGNckhTdwGn16HANHzNfr3whkW2
   y48Sie708maWVW9YjdxAJ8+SBWYZPc6p3Gs60GGBhyJF/20IU3I4oE31h
   drL2NBhWHxoixZ/7FfofpfYBrk7wlcdi3R7WuyLODTkYzZ5CYbyZxuknF
   v41N4cEB7tPrfxKvU+0/KkewLKa8VjZ8rkMDnPf6LnyZYphpivDmbMK4z
   OVyujbcW3oBtJFzO/SqaWZhLY1TWTY8Y5yepPy6k1s/wp6oKJ+h1X1a/A
   g==;
X-CSE-ConnectionGUID: XN4uvyHaSqS/dFhtALIJ1w==
X-CSE-MsgGUID: DadIkHGOTESwvP/+Wt97RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57823190"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57823190"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 23:55:03 -0700
X-CSE-ConnectionGUID: DVeWY21RT2OyYYY1jOZ2YQ==
X-CSE-MsgGUID: asnUSgU6TAKh49bF493mKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167474826"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 23:55:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 23:55:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 17 Aug 2025 23:55:01 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.58)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 23:55:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtuLLjmFJYj1x1qhWOM/lUv3npvJPrzOCHxIR709SHZJvyAAewIxyFgvvHiZ2zxnjFljqKMch/uamvnfNcm1UUTDtLCOQrmmyiAWksOfdizWnPWPuvnxvTS3IbVzhTd6iYh1g+r3fDeC2EZz9EJt20Gm6ZpwEJ/24C9Y4gTWS6ffQ2SMIvfUE+hk7U7QnL6sQX9TX9O+oCps5VuYXIV06PK4M2EwELzKdcsDSJpbxxuh+CZ6EfKNr9WggZdLf17pw5jSpl6a49Tzl9zvFNLKizdPkYCqbkbQfwcEF1URTapkscEYxp6bY2OwYor2Orju5VxdauKCGqtfZC3jEN9wJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdhM0g26vDYe4SkxGo6DbmypJ/Zg/abx+BOBtkWX+o0=;
 b=FNIQ1LxYyfbTnFn75NfOsykHYHPQACDnclid2+l6lfPSAVUhASoRB3WoPaXYMl5BFynJ9mJ9rO2BNVdgFL1XLYQWrGZ6/YKubNHjMSMB/fC6vbYQKx7cFn5FqJEzLRlg9BgMGfcy/Pk+7b8YMvLHOo+0rrO8/TC2FDgZC7zCqlyvYxFH260qrZxZ+x39fPGtBEoIAbeAWKNDdqupaDDcssQRGvOyY+K7U0XlrO1a120QpPi6MIUCsifuxr6VASSi/NjIWsFcjk16EHHMFJPuvzkx59LsFI97nsX3BBoOl0vBNlVlWe94GSOXObZqWYSqltPJrVmWhlqp2JiwRwS3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Mon, 18 Aug
 2025 06:54:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:54:58 +0000
Date: Mon, 18 Aug 2025 14:54:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-pm@vger.kernel.org>,
	"rafael J . wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, zhenglifeng <zhenglifeng1@huawei.com>,
	<linux-kernel@vger.kernel.org>, Zihuan Zhang <zhangzihuan@kylinos.cn>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v1] cpufreq: Return current frequency when frequency
 table is unavailable
Message-ID: <202508180834.3b8fe9d6-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814085216.358207-1-zhangzihuan@kylinos.cn>
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 5138903b-ec77-4216-5963-08ddde242542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GEUvuC30LIKpK0Dju0t+zGqPRY0L3J2K5y/aFTXNUTTsmefCvS04NSHFrN7u?=
 =?us-ascii?Q?1xn6J9UPdiEaWKwFBUTwNGIXZRpzqiw0K4yjOROPbj8TMiCRiaw0aAdfHD1O?=
 =?us-ascii?Q?JU2fAa/0J0047ggdBANKRTR2TGXz6eHvvEvz2rIxq4xhscKysFSIDCNikJ3M?=
 =?us-ascii?Q?BQI4QjM1h28QA7xl9zctkLE1aoBqvx3qmATHCTN4un8TCyOywfT/m25QLO9B?=
 =?us-ascii?Q?dLR4AB2a4YN81a0L0193WMfibDFnaFM5TtNMiRpf59x7uwFgGdjjg+0vbtIq?=
 =?us-ascii?Q?n36tmEq/TXfIfWUjQYMKWZmdF9DoI2J5NUibsX4QufAtZYxiqySSdernFfO0?=
 =?us-ascii?Q?AveId0SVWbsWdORB6sZdQxu47YoCvFk8PBsDFQhxyBBq5WRb9nPs7LBbR11v?=
 =?us-ascii?Q?AwQa0kRgNSagnfutr4Z3SE77rbqc3WsZNJthtQVUYc1YCosBpYYNtzsb6JCo?=
 =?us-ascii?Q?iERsABC4vFn8SzVV5ym2+K7APHRL3+k/ucGOyyBfDBFOpn9K1nCUJ63+cwOm?=
 =?us-ascii?Q?U99/aWLhJ7YxI2u5Afl38Kl4Gv785bxLVgMWQFGimsGkFehyp4X2tjQdHw1z?=
 =?us-ascii?Q?HcMUtZQHxr+732KsFsHyWWe+SpY+GgWn0wCndTkP/hkayNs85CM8eYebbQa+?=
 =?us-ascii?Q?iFMd+//Qi20FJ3D74WxhUpX1Urv+C6Mv+8o6XSCL1I78iTcCC1QnnF+7hyvM?=
 =?us-ascii?Q?DktLtv9RX/S5+xyWiOucGmfGno1YadofeNg6cW8N0nKRNhC90eP5AsZbhTC4?=
 =?us-ascii?Q?Sc4h9SwFNock9r8uZlm1JKM1E/muviCWjrIqvGsKH5cJQ63XUMFcXmyWGYxY?=
 =?us-ascii?Q?G95cLkGqTwPjLvx4HI5yTQGjaP0q+Io9J8G8ggglZ3fs69z40XaEdRJS+5+4?=
 =?us-ascii?Q?cxJ+a4l8QYmRNJKHFyPRpvXhnWjCO2cBkTDIo9crA4icqacB4FeheH4YknAI?=
 =?us-ascii?Q?kE4Y2R7mxxNgLoO/ZZYyRJZ9omwuXaBj4+xSjcjucagbm0ETb5rp0TYTiq49?=
 =?us-ascii?Q?lOtjnMKEgYEOzRzLowl62pQn/dD2w1TtIokBZRJDYlyS2CQkeql+GS97xFMv?=
 =?us-ascii?Q?w1pm9IPS7k3rOID6+qR2iK8k4FonyttV2QeFdxH5RM/My0v1SCb4XbeEVgbF?=
 =?us-ascii?Q?tVr3jLJ6dbFcv2u0ZfxLcOsC3i2YAx5kpS2n3790zDWRqixQihcUtZaWbtHm?=
 =?us-ascii?Q?NIBTLCDwSUiMdTdt+QD2l24Sxc/Bi/ISiGhPGaTzHpidR9v6unef7khgmAVs?=
 =?us-ascii?Q?YVNJuztBEaUS0psipJwO1Wxicitxvke9J8UR8VJWAJY8Zk7rjEijtWWBRZvC?=
 =?us-ascii?Q?vx8/rTbc7V8QLuWhPDIKlQY/3B9YyijnaHDiRgZi7ZsQZpIqdvdfoCGB40ON?=
 =?us-ascii?Q?OQF1C4PtYsdW6h3rJVUrUV+gADc8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zzKls/EzTXFKFH3bVJiitB3mvvVOflxe9agoBvjA1p7/ISLemtHIEf0xyIft?=
 =?us-ascii?Q?VbaRjUgTphkAHC5jqA+JdeXrobbkeNalbv9B/uyKAu8FENus5Ve5ANbyijJ+?=
 =?us-ascii?Q?9bNYvo+F8OnUmkglSTCHBMn4gfumQiWeByKDV35wB3w2Y2BZASAOsjy8Q5ps?=
 =?us-ascii?Q?lKQrsNMbSnJzMD0sXrzwPSIan3sYb5W82pZqyJ/9I5xxE3pO83NaWEJWcgpO?=
 =?us-ascii?Q?p9cNGEEveRHJxwQwUoYHL01j1oLpLYJUZcQMbF4hPUaKjUvQ0B5vJLVHX9Zp?=
 =?us-ascii?Q?xJX7C/tSRjEzPHMxfgfAeAP6e6TWJjvW+7YrSshqooxLFl1NcMJrXxzLjLvu?=
 =?us-ascii?Q?i79FOX0KBAAfV3fxEs4lgqLLWyNsjADjjUlqQBWlyQZcs1GFKOCIoeV5RQQ+?=
 =?us-ascii?Q?6Ic1jLCa6/2ka+TD8nQX0qQHgNMPRF0gmnGZZBtzDlVo4MfyHZtOpGGClfiC?=
 =?us-ascii?Q?cSrunK818MGvVIH3zZYheXv6kvlEcX1oUeBsYum2LVUV4owM/1gFPeaeLzO2?=
 =?us-ascii?Q?MEc5E5eYK5PDOzKljvgaZrhN8Q8fS6w+d6QfQyUnSa62rVsoeIb847jOdNHz?=
 =?us-ascii?Q?Z5Tgzt2AYu0m+hAYKZL7VaF3yoyDkVENgPC7yQ+59Qpp0Bk8dnfhSet2rQYr?=
 =?us-ascii?Q?YBJEuzaZXtISE06u7Fy0tthkejJ9ylztG1skJ3lf+fGcWidC5oI1B0rZE4KT?=
 =?us-ascii?Q?wqY3Px1dN3E+WMPpVvPA1OM+dIONv9wE0Fe+1mrvEGrB+GAXkkw6CY45hm4w?=
 =?us-ascii?Q?56+rYXSn6i49zd2UCosniohHmeXgB/nVVKYo/KqJBu52E3Fg32wIAvz164TZ?=
 =?us-ascii?Q?T7m050L3p0TxCVbiN7yFxwRWVZi2ewOpd9wl7s5y8RPtjXUE1i6WNssYDAf0?=
 =?us-ascii?Q?oTzP4c5wnzIYo3hNYed/EQpkl1RBGJDi/DYDYc0VsIacAREATNxQloj+HO6v?=
 =?us-ascii?Q?b67+nxRFDrLHgfbIXc3pbQxi2LbPm/pgXqMcCSCNpRVqhfDPnPosC9/KlZE1?=
 =?us-ascii?Q?WH8rgMMtAtSgRRgD/JCjyWTG1TVn1v5ymkkdcfDnkgYhD3QSqImHluQsnO3t?=
 =?us-ascii?Q?qKXQ10DjCExey1FsURUYB08rcaImpGdjViQgioiOYOnHwG+Ps5d2hWoLocfh?=
 =?us-ascii?Q?6tTZBI2FGoi58HZkiMOfEIwl4N+6gIMy4e2lZZyY5/lD26AtBoH0viowSlGp?=
 =?us-ascii?Q?jWdlQQombLT6DnTKjDzD4/ddLJMJaWrjtFXcNrVgsf2o1a9IWzyJqQtkdxbB?=
 =?us-ascii?Q?dth03VGUXU4seKCxfwX/8Rj0jWZGYjXqkn2Su2Re7n/mx1oXqkiPpdXgSwRR?=
 =?us-ascii?Q?/nXnYZ98T1/0735/sWxceSVTGlWGW9//fs66c0YDI+ZrCdvU1Awk5YWcviLl?=
 =?us-ascii?Q?m4w+tKtXJPVEKecf5KWJpbN7fBf2tSPrAy5ceFJEyNcm+IwiuIZKH6UYDg/7?=
 =?us-ascii?Q?LOBde6r2rsvDVRPcTNLAOO9+zKhoss8n9plJw5i+VHO/hmHAF13PdNxVgxpa?=
 =?us-ascii?Q?AAAMS92OZJTFEVcfWKOLnquKevq2Mi5APyJKIUSv93p9LCCLZfpWrqnJpv06?=
 =?us-ascii?Q?YjmsP5OghQr68daJI2yzJEKQq+3Ng/NmmJ5Sqqz0O0F5gjYWDhuB0lCYHcXr?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5138903b-ec77-4216-5963-08ddde242542
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:54:58.3204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSt5dJIzbMTaBRSN6iPxuA4DVT3Z4KXvn0lRXN354de8+lhLeMOgCdLoqNIFy/IbHZPDgJoAAQO8w527FSJugA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.xfs.177.fail" on:

commit: 69f6747d99d0b1482fb38c36dfa26fe22654ff1f ("[PATCH v1] cpufreq: Return current frequency when frequency table is unavailable")
url: https://github.com/intel-lab-lkp/linux/commits/Zihuan-Zhang/cpufreq-Return-current-frequency-when-frequency-table-is-unavailable/20250814-165519
base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
patch link: https://lore.kernel.org/all/20250814085216.358207-1-zhangzihuan@kylinos.cn/
patch subject: [PATCH v1] cpufreq: Return current frequency when frequency table is unavailable

in testcase: xfstests
version: xfstests-x86_64-e1e4a0ea-1_20250714
with following parameters:

	disk: 4HDD
	fs: xfs
	test: xfs-177


config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508180834.3b8fe9d6-lkp@intel.com

2025-08-16 15:56:36 export TEST_DIR=/fs/sda1
2025-08-16 15:56:36 export TEST_DEV=/dev/sda1
2025-08-16 15:56:36 export FSTYP=xfs
2025-08-16 15:56:36 export SCRATCH_MNT=/fs/scratch
2025-08-16 15:56:36 mkdir /fs/scratch -p
2025-08-16 15:56:36 export SCRATCH_DEV=/dev/sda4
2025-08-16 15:56:36 export SCRATCH_LOGDEV=/dev/sda2
2025-08-16 15:56:36 export SCRATCH_XFS_LIST_METADATA_FIELDS=u3.sfdir3.hdr.parent.i4
2025-08-16 15:56:36 export SCRATCH_XFS_LIST_FUZZ_VERBS=random
2025-08-16 15:56:36 echo xfs/177
2025-08-16 15:56:36 ./check xfs/177
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 lkp-skl-d06 6.17.0-rc1-00011-g69f6747d99d0 #1 SMP PREEMPT_DYNAMIC Sat Aug 16 23:40:03 CST 2025
MKFS_OPTIONS  -- -f /dev/sda4
MOUNT_OPTIONS -- /dev/sda4 /fs/scratch

xfs/177       - output mismatch (see /lkp/benchmarks/xfstests/results//xfs/177.out.bad)
    --- tests/xfs/177.out	2025-07-14 17:48:52.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//xfs/177.out.bad	2025-08-16 15:57:27.495121515 +0000
    @@ -2,11 +2,14 @@
     new file count is in range
     inodes after creating files is in range
     Round 1
    -inodes after bulkstat is in range
    +inodes after bulkstat has value of 4
    +inodes after bulkstat is NOT in range 1023 .. 1033
     inodes after expire is in range
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/177.out /lkp/benchmarks/xfstests/results//xfs/177.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      f38a032b165d xfs: fix I_DONTCACHE

Ran: xfs/177
Failures: xfs/177
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250818/202508180834.3b8fe9d6-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


