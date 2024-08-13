Return-Path: <linux-pm+bounces-12123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0672194FB12
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 03:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7211C20D30
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 01:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE71129B0;
	Tue, 13 Aug 2024 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vn2XFhCQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9678B524F;
	Tue, 13 Aug 2024 01:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723512473; cv=fail; b=HsAVekz48Ozx3C7VAIcZGXp1Wz1c/oXwWR6XRFXU6RK1J7YDGLDyRe/h0gBuIbnjvlAICyzA5+pbThgBjES0ezyDmI8whVl5G3Yijq+wJ4k+2B9+GaxOD0zPHrml7MUiLsSZYLQa4obR4Ql77/3Y0vfY8lbGt0VkM3gZGTiB1es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723512473; c=relaxed/simple;
	bh=7XZ57R5LZGN3ba6AB6WRuar571uE5AVKU1Nz3zWQb8M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bqyTwRonE6qekRVkiqKHmuNQloT5OKJOHpFU7j9KP/N+FqD2p94w0Bna1O/zxc/PYd4Uy0jmlk9Lhk6a2YqgknLiD7CfPjGAGmtBbDhiAoIWJlG4kxFr5DgxFtKC5U3PbNvns4M6/CaVd4yphD05ulgp/ubFsjnJxPeR/Ck6zb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vn2XFhCQ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723512472; x=1755048472;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7XZ57R5LZGN3ba6AB6WRuar571uE5AVKU1Nz3zWQb8M=;
  b=Vn2XFhCQ/+kQhoXtx8LH94uGXne1LHQNGyWRglUujy3k8o5t0vvm3Mo0
   DkpZY1OTt4Fa4Cg3awzqZhS4IQPSllL4fWe4Tup8R0JCCmKgTiE2uA4OG
   AGMjqMmhsoKqNDE7bz7bcPZ6OYyIkBN+MrvbD5hX5dG/EUSwCZIdB+Gja
   f6pFVkZewaCIyC50Sf/nGweCGxZu19N/l8892VK5nF3Kn+lj5BsqikdAy
   5kNX2saCd1Z1i4ewsoXfDJU4bNdU80jamASfKdJbp/2Hfkgb6ukH1eX/h
   81VIDA8WxNmbKe6AsHrCE4yFRTzkMOInx3pwYcRQpbr4yklL1t1RDvFt0
   w==;
X-CSE-ConnectionGUID: btK1mBbiR++mg5EDx+TsCg==
X-CSE-MsgGUID: fdiPvJK5RbGRUtkc5FVECQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="24559832"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="24559832"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 18:27:51 -0700
X-CSE-ConnectionGUID: XxfL9wLSTFWaqksttg+QNg==
X-CSE-MsgGUID: VbnXTbfXQ/e6cTAmVj+Lyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="96026871"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 18:27:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 18:27:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 18:27:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 18:27:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 18:27:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2aO4rETaHP+c46C1d1KVYKR49FA1akvEPBpXgzfp0Cc/2wiQXjRw5NCZKdcNgSt2NZ69V8KR2i1fVPh2pkbkKAIe0hb90tyX7dZFXbAu/wYteq8pufKiCcPJWb9SKy99zSOTgpLqu+Imz4xiZqJNPNM9e5wiX6oZFr3J6iUVF+lHrdsLwWghy7OqstSrBUiVtpSLepuhI9Wglu7p/efZ0QblxXwtElp6xN6b6o2Wl9iLkDWW9aUd7s4/UIn0zBbmOsTLJcheuXfCcePGDmJdSIndKq4mVlt1NhQlL7SNwZ3Dmzfd+ONUe9ynqX4DW3aXrtYumJASMaE/x7CmDUjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WATxDxc8UbpklbJX1ig8V/aNMktz+E1QSuy5x+jRi3c=;
 b=fUMAwfWHdsCa/W+eyONVp8jAZ22nwU6mw28XHCx1dnejLOsY2na9eNiPhCIC6y3VClWTYSebPKXEHcegTSwteSp3RdMj1CiftB2cpTH7+gx6vcnlkhFzDjFMzdY1twhcDWF56HmffoL9G/G+svkrDgB+WKLTZpYGuvrhWvI+NpLJVnV9ZXi5Cyfe2tmZ7lRbLnm/zCthdqs0MLB6TfKqLGGThFHcUY/9UuCZNJb5l0dC1qQFLKDm6HYRBNvGrVjjxD6BtJe4c5/B8Qq6a5uJ5SaRlKmZyZDy3AYZDsmVafXG5YiWXhXDK6yB4qg301T7XxJz48kOOAw/AXfYF77Lsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH3PR11MB7675.namprd11.prod.outlook.com (2603:10b6:610:122::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Tue, 13 Aug
 2024 01:27:48 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 01:27:47 +0000
Date: Tue, 13 Aug 2024 09:27:31 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: x86 Maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Ricardo
 Neri" <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 2/3] x86/sched: Add basic support for CPU capacity
 scaling
Message-ID: <ZrqxqCVbw18AP5Ou@chenyu5-mobl2>
References: <4941491.31r3eYUQgx@rjwysocki.net>
 <13573795.uLZWGnKmhe@rjwysocki.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <13573795.uLZWGnKmhe@rjwysocki.net>
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH3PR11MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0fab30-0b78-4fa1-f569-08dcbb3723a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PDP+m5p0SvOW8WQNbL9GFRyvwmfphsMHt/wmFzXigPv4xi4gCMsZQOpI5Qhb?=
 =?us-ascii?Q?JOaTG2rVM9n9Bex5L6l4JjZj/2ZS4syp2MelwfDqAzHD+jhQtjDpzzBb+VVV?=
 =?us-ascii?Q?ViyRavcY+GyGV/5PfcENS7PBYbEzxJ763NuAoHacwb6rzpJyjZjQsLK88j5S?=
 =?us-ascii?Q?keROoG/4trx3sWaUxzAq6RDMYHHQI+9sRPm98F15UWkaS4mCIbePu1fh5EQO?=
 =?us-ascii?Q?4ay7r4SJFH5+Jv3hkyPtpKfkcINt1SvM+JmTZYckas87K+1hPeUciTBk5Bji?=
 =?us-ascii?Q?ssRr6QLAaNi9J2NjncUdrGTSr3x34Js//lbJruaUXU1Bqz5k4BMIPVtr/T8c?=
 =?us-ascii?Q?+Flr4yOTyrhxikZxy4Wzcw5KeZe4nFpmOdxdhD4Cvark/42Fi7XYvigLRqRu?=
 =?us-ascii?Q?xgn8dAY0DBjG7jpsMhwL8DaKLM/oU9+xDQXUdZzGo7bevOGuv+XIBg2i4gIB?=
 =?us-ascii?Q?aINOaqyjfDhUFwzD4a0bvf0sFyR99c4jA4xb93aT7NCNKtfqELNN7+zE0N7x?=
 =?us-ascii?Q?dEQxA6TJFqh2qcJPNKA2PPcdU3T4hOW38K6CjbL4Uaet0YTEArfl5fZW89c/?=
 =?us-ascii?Q?BQRQ/mX5eDnB5jW+HjQBjZ0k2CdxbmdCxBrPnSQKnUudTaW46tr7T4T4k0yL?=
 =?us-ascii?Q?Ncm+mJkfshyJejxpTVU58Iz6RXG1vEksGp1HWQ5lj6vw6ODmdEN3YmZRoZpd?=
 =?us-ascii?Q?AZ+/IRIraeaiUJlOTgVyKHEKvBgDCllIDC9coAPTBvjeUoz82/UjQRByv5LD?=
 =?us-ascii?Q?m/jEhH+88yrPrNPAbP1AOcsuLRx3zZ2pm+60qVqxASVyxx3UF6xgh4v7ygLr?=
 =?us-ascii?Q?otG7AmFXAkjIy0uUbp/8NkBgM8EpIjDCetKRfrnb0pkUpr9qF5RycCDEasv7?=
 =?us-ascii?Q?4Eo9m59v0E0im/nvrw0M9keM/OVdEeHvnYf/kZ1CPBBSNDKScxRdPlueJT16?=
 =?us-ascii?Q?b3V0W7+IH9vgYj/SdvDMm3pWnx+eJNMIOskAyArCited6exfpzrW7b/Kzwo/?=
 =?us-ascii?Q?8YaWcg4VA/0Eub/X8DsMQyJWpk7y7Yx8VtNgHxjcWn8JDfESeD1BtZNXJv5Q?=
 =?us-ascii?Q?LL7+C6MyYCyZESUE6iIhqIL8qq65Q5WZb1A4pSlXtiqh+vLUSyojuu0cwnjN?=
 =?us-ascii?Q?cFUYjHA1xBP9Kqelb3sSdi9WA3tc6ppk8iAZwJJgfaYRYBtQIZ3Wegsfymuw?=
 =?us-ascii?Q?fUsbHTqW2XcCCDHye0NaJ8L9D+9J/AShi5CPrs/lQ3wyj8sjIlxvncaAPBgs?=
 =?us-ascii?Q?n/QCqK66gR4tCIhVJQdTzV7L5xybkW6/itHBE3qU/52HxO9BSCJSuSzQySW3?=
 =?us-ascii?Q?AF3CJYfehS0NSLGsBpOxhFM9Kwsrz68tWHKJVxYaIws6Bg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NT9f8My/lawTQ/d/qGRqe6btO+NNG0Y2J3SVG7lhE4VK7HcXuXxJEk1RAPJG?=
 =?us-ascii?Q?VKijpJN6R/1wS8Y5PG/rRTTCqRptB9OejcAvXb3ICPHzQGCKR3BED9JMPpCO?=
 =?us-ascii?Q?50lT4jYmC3wpFn6AMAgmYHAkt+xLopqpuVO8rZj4fh3qZi9aDrkmlQhSBJxF?=
 =?us-ascii?Q?Hb9pq4SjIJH12Wzg970dankaaFVbN/JK9YxDMmJ5yxR7L4aGfrvZbR7NRZEu?=
 =?us-ascii?Q?5nzpm0kVlqeiozWJD77dMSWOgNvLo0tuwDJu0+OAkIDD/v6ENNNsOk+hIwp4?=
 =?us-ascii?Q?GZ+RW+NMFLw7YAcwZIrkuSJn4YkQgz9ApNFwse1H92BNEfmVU4l50YL57eXQ?=
 =?us-ascii?Q?oAw7mB0kSSshqRmHR8NDcJw0eubFdslpZcJWiTpOziM6T4zmg2xIGlzIVcgb?=
 =?us-ascii?Q?RSyDQTLMpkCj0VSj2QMsiY7o/JcC8J7Mz8X4++wmq8WAcNHCekhrru10aqEM?=
 =?us-ascii?Q?yvwPE7Q/IlfUnvioTfYkN88yElAaxdsrtRdGQ5FUmvPS6FGm+iJ9beJhtRdi?=
 =?us-ascii?Q?8DUwkhHVw594jp9A8CyROByCGj8sLRbcZl9KR/7IlWWxIk0lCUIUSM8UdEha?=
 =?us-ascii?Q?Ja830+Lgy91VBIm8AaXgzTc0YmUSEZr354LK/Cqk36EE7JlF7RwLGWRVuiev?=
 =?us-ascii?Q?BaXv4zbi7Gon1INNNSrqgEpkwq7hYSnvPjjkWHNz5W39Y6H/TKM7KnQf2D5s?=
 =?us-ascii?Q?pQNUTaNcRANNZTfQ7K3GLR3QwJnK5YeWqOHfg1FTUKTLrDQjMaPRHb4wo1GH?=
 =?us-ascii?Q?DUWLXllJF4TZUnvIkLyGiE6D+YUzN4jhT6LarsAM0PwN1jNn6/8HSLcME9ZD?=
 =?us-ascii?Q?OG5G0chdiD+ggzjHm9ifa0IOYw5mymupChMWU2Zx/lZi89YTO07KOpMxoo+U?=
 =?us-ascii?Q?cV8AtV0Ze7p96p/ahm/+RsrJ+9Zvll11r2aTT7NgfGjefi92dRlqJs3PKOsx?=
 =?us-ascii?Q?a8YhocUeGsXkJjEbekZNMP/2dHJHxlyKa4jYo+b6CcxSglOSfKCZWGaMKH8x?=
 =?us-ascii?Q?+68weRcgAJwmUvusN/xL7SnYOQSKczEVPgnfmZGKfsrFawpQsJSOuUQFF2+X?=
 =?us-ascii?Q?prTc6lPbg87Wc8KIIPgn5g1E1Ge9YspZ2sSGNHYqHmCW/yoXkkMsBte+1/0V?=
 =?us-ascii?Q?HZKYABCDHQsKD+CiBpym8SlbU63oJrWALPXdbI2L/D/PWXjxKTCUkJLPIHVx?=
 =?us-ascii?Q?6N7R61g8dyvVRU3lqpagpyzeXPIGbrIV1C6R7rAyfa38fvVVVkeTFH0oTMmg?=
 =?us-ascii?Q?/7upOCvuCVT726hCPKomhvFxe5RSMMYx0QEViP29QcFxsPerZ7/++tdv2lff?=
 =?us-ascii?Q?Qd2LHoQFifUOYaeZsOkV2lQ7NtajO5oKv9hnZ9+UFJT3Rhz/rDsHiZGVvFdS?=
 =?us-ascii?Q?P3AXH8aO5Jgg584pCiDte/l0lR+PoIL3HTn3IzehWq2WFK22k8CLH//qxOp1?=
 =?us-ascii?Q?jJ3OeFPs57wWoFY0/tj72xYgH2Aew3lf3YVIaqrX9Pe3Tkb0/upIPxk684A9?=
 =?us-ascii?Q?5TsBmAsl+yDNrUxP/stae8+dXe8bgz/OW1XsjqiOVvrPRBv/lBzFV7kvxddN?=
 =?us-ascii?Q?iYcuV78SOlNvYn3W+tRy6Q1YulWAgkBSAsWY1iCsABcmA0wXbTGatO3UPS01?=
 =?us-ascii?Q?IeTBh2BfASUWa0JA7FZLAhIAsijepx96SVPfZJMGy3Bg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0fab30-0b78-4fa1-f569-08dcbb3723a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 01:27:47.6845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E08yQAvbQqC9zfiLHyaAWoJ7Lqh5m6PNHpH2JeDwvSzXV5kd9UAQxKxQorySy9AarwvbgtwJSPSwRmIBQvX6ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7675
X-OriginatorOrg: intel.com

Hi Rafael,

On 2024-08-12 at 14:42:26 +0200, Rafael J. Wysocki wrote:
> +void arch_set_cpu_capacity(int cpu, unsigned long cap, unsigned long base_cap,
> +			   unsigned long max_freq, unsigned long base_freq)
> +{
> +	if (static_branch_likely(&arch_hybrid_cap_scale_key)) {
> +		WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->capacity,
> +			   div_u64(cap << SCHED_CAPACITY_SHIFT, base_cap));
> +		WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio,
> +			   div_u64(max_freq << SCHED_CAPACITY_SHIFT, base_freq));
>

Would the capacity update be frequently invoked? Just wonder if we could
first READ_ONCE() to check if the value is already the value we want to
change to, to avoid one write and less cache snoop overhead (in case other
CPU reads this CPU's capacity)

thanks,
Chenyu

