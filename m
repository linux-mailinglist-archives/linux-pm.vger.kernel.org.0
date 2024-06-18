Return-Path: <linux-pm+bounces-9412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F3E90C663
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 12:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218111C20C44
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EDF17FAD8;
	Tue, 18 Jun 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtcorVjC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C117BB11;
	Tue, 18 Jun 2024 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696982; cv=fail; b=QKdASZuWubege2Ul3WgNivv0UwSIOj6FrwODDOCr5S83zMhkzpBM6cA4sZHhCSUoWAakFTmoVFPWLZ0ASPmOOhH3mEi3glooKXiNakD5Ug9uEq2yU0m/vrwrWOmN40YSQRRHIdq+FpnJJHTpTcJ4xzRtkYKdm0vd8xEpj6czcXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696982; c=relaxed/simple;
	bh=Omskj4gfKk2W38E5De131NLktiaB+7VZDBQ9XCLSfCU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dgCMldgGgiktPq5uq9qSYBxQ5xAwrzEMjXYkVG1CnhbvS+rjIlJQU47auRAbFegu7B492qkCd7Y0jfKSIF1JlW0NaHd7UT+cjGFPmRd8sQRX0LRf6vJ7PfcIgy3aS/bxkGzZr766LEdcHt0lOnTVrhVHO1qS38s1ZcJxp0+EBJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtcorVjC; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718696980; x=1750232980;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Omskj4gfKk2W38E5De131NLktiaB+7VZDBQ9XCLSfCU=;
  b=GtcorVjCrtoxXwrP3Ro27wpOZDKzFaoXtsh2fDj2UvQVApH8mztEV+UA
   Hryc7HsN1ySdgSUEQ8IXhe3h5qZl3T1bV33b9cn1vU98xvrRnBXhHTPYp
   wXV4zCqF99VSBcLYZmDqVFYn7YRjqJv3TJlzG2YiVf7U8nsMk/bNpBQwp
   8YMZg/LEr35tt7w31H8i9CxEeLz24Rl9IVz8rJHxP0hBFO3JB8uNRaAN2
   a71/j8NLHGypZzA7NOFft+Or5gWjSl2VjAfLeb8juJeQ3XsR/K4TuJwP3
   uyU7WELT1orqN3zIVeqpHCOnCIDw90DW8p65gXtqvuNQcoiSuJr2gSZCE
   A==;
X-CSE-ConnectionGUID: 62G/+5KbQK6xawAIOGF8eQ==
X-CSE-MsgGUID: oaJq0k8iQAOuH8glueZiZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="18469494"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="18469494"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 00:49:38 -0700
X-CSE-ConnectionGUID: mqQIbUiNTdOesX0MRyzRUQ==
X-CSE-MsgGUID: w1VDdJ3xQraaSgOVFmaquw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46583050"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 00:49:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 00:49:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 00:49:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 00:49:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 00:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4uTMTTmOeiRd5FLV+X4SuVc7YYakbfogYPmnLxETRQ08GQbVr7hsRTum6wRqeX4wslL3u5ZbbNRmbJCttgzbHsX4mBOsXhRaWUZhZqd5CuQ32TEw/88WZos7ccvHVBFFXlFL1sqoXgvoUGoaZ44A7xUxUtVHMS+l61V2RyRwdpEaYSaFRE0JMmr0HhK3C5OjxiZLmme28itUnCDT9+scvgGN/63oXCTTXpYkbKoD732p3zNEw7C5pBOMk6H8J03P4ZAAtYG7juQKO7PCAp3TG1rqLuxqrgJAgMMadO9G7nt9IZ9reBCSajAIIopeAwMYt6fdlaS51nedrrdreN+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9RYfKBQzXkPvxzJENPPxsRrJS2s0q3ya+54rc8zbgA=;
 b=MADVD28QK94hpFX3P7JBuymDGeZfYGw514Be5IkV2PRODxRs0WKB15EOgFpL9XSgeuiykeP0nhhD+WdBeMhRinSRyUCbMxJBIg9NtHElaa2WEgT+mMYrDPv5ilw9CZbUyzegvmqO6NFJFY4ezHuBSAiaZTM+VeVkwm22EuMFi33hTz4zsA/xOILz2vcfC/YcKna0pc202wcR7wyG1KAMY/acFXqBq4Fib7R00/hLrK8pLgxOmEgVOAD0nd2GmI+Ek1op/EmxZoV1tLuJsIDevmWP0gzTv4ko+pNj/i+NS6X0irhwGmAto8jil3NRp9DgjHAhFJHjJfoqytOUa0tHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 07:49:34 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.7633.036; Tue, 18 Jun 2024
 07:49:34 +0000
Date: Tue, 18 Jun 2024 15:49:02 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, <linux-kernel@vger.kernel.org>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, "Michal
 Simek" <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn
	<jonas@southpole.se>, Stefan Kristiansson
	<stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller
	<deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen
 N. Rao" <naveen.n.rao@linux.ibm.com>, Yoshinori Sato
	<ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "David S. Miller"
	<davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Daniel
 Bristot de Oliveira" <bristot@redhat.com>, Valentin Schneider
	<vschneid@redhat.com>, Andrew Donnellan <ajd@linux.ibm.com>, Benjamin Gray
	<bgray@linux.ibm.com>, Frederic Weisbecker <frederic@kernel.org>, Xin Li
	<xin3.li@intel.com>, Kees Cook <keescook@chromium.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Tony Battersby <tonyb@cybernetics.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Brian Gerst <brgerst@gmail.com>, Leonardo
 Bras <leobras@redhat.com>, Imran Khan <imran.f.khan@oracle.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Rik van Riel <riel@surriel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, David Vernet <void@manifault.com>, "Julia
 Lawall" <julia.lawall@inria.fr>, <linux-alpha@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-csky@vger.kernel.org>,
	<linux-openrisc@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-sh@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <linux-pm@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v2 00/14] Introducing TIF_NOTIFY_IPI flag
Message-ID: <ZnE77ons3lb/JAxP@chenyu5-mobl2>
References: <20240613181613.4329-1-kprateek.nayak@amd.com>
 <20240614092801.GL8774@noisy.programming.kicks-ass.net>
 <CAKfTPtBTxhbmh=605TJ9sRw-nFu6w-KY7QpAxRUh5AjhQWa2ig@mail.gmail.com>
 <ZmxwWdW78hjNuxWU@chenyu5-mobl2>
 <4748fabf-c359-9199-16aa-469840201540@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4748fabf-c359-9199-16aa-469840201540@amd.com>
X-ClientProxiedBy: SG2PR06CA0186.apcprd06.prod.outlook.com (2603:1096:4:1::18)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA1PR11MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 37677403-d947-4d25-6294-08dc8f6b3215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlJPUUpZU0JPRjdxZHFUNUdyYmNMZjZoR1ZHQm40UW1KeTN6YzB5ZkpBV0N2?=
 =?utf-8?B?eEk2WDZpdE5USWNHcDZZM25VQi92dnE0SGR1L1NZT05HQ3VLNXBSZ3NQM2Zv?=
 =?utf-8?B?dk9RblBKblFPaWs4cy9vY0hKMWZIbnhmR1RFdjR1U1BBNHk2TmE5OWxIRFNE?=
 =?utf-8?B?TFpDenNFNHJzeVRSQVk2WW5WM05YK1JMblUxWk53RXAxNGNUTGVLcDBzMWtR?=
 =?utf-8?B?ampFL2xMbVV6S1o0cG5yenBPeXNGcUhQanpxcW5iTVBvSDBhWFdTSkR0eFVK?=
 =?utf-8?B?TmpIT2ZQZHl1SXFzYUlFNFFscFcxdlNhQk9SMG1QaDlQRUZPenVQL1BFZGdm?=
 =?utf-8?B?TXo0bTRLUkNwZzdaZFlTNndyTy9wUzVkRTBJajNvL3NHdnhkTitIb3hoSklp?=
 =?utf-8?B?TnJaMU1LYjZkTnhCSzNCQ0x2ZnBLemlvcy95cjFweHpLbnZyZ2V0QjF4SldS?=
 =?utf-8?B?dFJZL1NtTjRMTWxEbTVyMWdiQ29ZTVlQSkpNWXFLN0syNFY0a3FVNUxhT3BQ?=
 =?utf-8?B?UGdzYzM1OGo4R2p0OWgzdVlpbWovQXdlOFV5MzF2RWZYQm4vb0htczNjQllI?=
 =?utf-8?B?RUlsQjBFbHQyekhqYXVVb3F1MWsxZzRSSW9qdkdDUy9abzRqTjlzMCtBVzdK?=
 =?utf-8?B?NFdrV1FCNGlsU0E5SWN2V3VNRWZ2amIwMU5BYU9WeUtxN2VzNm1FdGNKRWtI?=
 =?utf-8?B?RjgzSWpSL0NrdHZNdE44RVR5bk1hbzk2cDAzVG1VQ3dyRE1NMUtDLzFWZHRB?=
 =?utf-8?B?M3ZEbUdnOFFEdFJPcThpZkZHUHZacDN5NVJud3EyQ1pIYWY0KytiVlZMa2Vj?=
 =?utf-8?B?SVI1dnFhNkRER3pWNXMxRXI1cXdTeDZNNW9EdmY0NkNHZVA4V3RhQ3lZRFFR?=
 =?utf-8?B?OEZDTy9oUTFvd1VqVzEreit1K2V4dzNHZVdCYS96OVhTVjdrTERVaHlTTjcz?=
 =?utf-8?B?blBoTDNoU2hWTFRUQUxpQ3ZTSkxEMmJaYWZSY1I2UU5Ub3RXVEJxUk1USzVY?=
 =?utf-8?B?UmExeEl1ZlBUK0lxOUl5WWZLL1FQT0xKUGJuQUJYMVFDMld6L1FKZFZiemtM?=
 =?utf-8?B?UEU0YlJzSVVHenlsN0h2MWxkaVQzOEx6YllzcDlBOTc4YTR0MGovSGEwNlpC?=
 =?utf-8?B?SElXNmc1czRmNHk3YkVJRXkyeGdFS3B4Wjk3ZlFySU1mK2hlUnlIaU41bHdZ?=
 =?utf-8?B?VDM5UnQyNzJBVlhhMFdiWUJuaDhpYmlzYUZJRVNkcmNLcTRUTFBLaDZMLy9M?=
 =?utf-8?B?SWxoZlErNVo1US9GNzNUbXpNNkZ2UDBmVGxXV3cxQkNwQS9wTUpZTEt3UFdQ?=
 =?utf-8?B?bDZQYkpIODNFRkZiWlNQUUJ2ZkFxQUdxT1JMWElqYmVPVWM0MXhzSDcrRUE2?=
 =?utf-8?B?WnZmaGk1T1NkREw0S3BVRTlNOHFPTU14VTE1WEZjV0N2UkI0bmM2RFJ4cFVN?=
 =?utf-8?B?NFBLSWJsU0dQZFI5anBYd3BlV0lUcjA0Y1BHbkVNYm1Cek1XbXI1SlM5dndS?=
 =?utf-8?B?VWFKcFFsVzRUMDZ1MlJraWFBUHk2VHdEVnp6WkRabGw4SDVlemp6UU9PZWRJ?=
 =?utf-8?B?bTBobytXcno0eXNnMDVkZXhsQjkxSXBKdTJzUnZmVGYvV2VQQzJUVnBVRzdv?=
 =?utf-8?B?N2l4VkRqVEZHNEtKRkpvK0szbTVxMGZYL2c0bm5ZbjNlWjZNdCtiNDcrMGFQ?=
 =?utf-8?B?MFFWdHZFNUZVeGtaeUdYRlN2NUh3Tkl1Y20xZUVnR1ZhR09TMVd5WFNvZXBX?=
 =?utf-8?Q?/IHisjvx9fQ2Ox9wog09JFqrK/QWhg+rpuCebXG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmZJWlZQVUxIcm1iYXJmTGFDTDZmelZtTUxPNzFKWW1zTnNOM21TV1FTak5O?=
 =?utf-8?B?eE9iRnV6LzJncktRUk1wVWllanV5ai82WkJMdU9CMHZwTjkyUGdIQWpmeThU?=
 =?utf-8?B?ZzllaDIyVXRrNkp3NjhHckpqU05WdGh3eEFFSm5YZExoZUlqSHNrOHhvbDRG?=
 =?utf-8?B?NWd6cm9ucnRBeUM2RXFOMER3TEpaSEVXallJdVhQdVlvNFJJL1pPaHRNVGZW?=
 =?utf-8?B?bUt0K1NmNGZXSTArWVNOVk5LdkdhUEwvVTB2T1hkWVBMdUZicmhtUll2cnRn?=
 =?utf-8?B?QSs5Q3o1bUM1cFZ1Wmo1K21Sekt4NmVXeGxLUXZocVhicUN0enlSbDREU1Ux?=
 =?utf-8?B?OHlheW43c056M1ZOK0pLOG12TVdiellxbUpRNGwwTGgrVGl3V3lldjczdHAr?=
 =?utf-8?B?Y1JyeFhib08rczNpUXVNV1RZRWhSQldiMFJGL01jN3J0SFNFWUt2amZmRnZq?=
 =?utf-8?B?Wit2Y21ybkkvbDRsTG00ak1rdDJmY09udXVDUG9oN3EvUk53d0JXUUdZS2NF?=
 =?utf-8?B?K3Y2UE9LL3o1eVpidjdMRFFrM01kR25MOGdBMldzeEE3S1k4Q1ovWmp3N0Ry?=
 =?utf-8?B?U0dZKzBqMlYxMUNGQkh6Vzc0UDhIMXhhdVlFb3RJZGVqaHhDYUszSjJUcUdC?=
 =?utf-8?B?RVJhZndpQ25HeTdSWjN3VzdPYm8zUDJOVUVkSi9RMEVIY3dDbUFFMmVXa1NT?=
 =?utf-8?B?eFgzamsyYWtKcWpyNVBDVzB0N1JZdSt3YmtoT0NSZzlBcGpkMEdQcWRiT0Js?=
 =?utf-8?B?NzVablN6c2tTKzFMU051M2tNbWpQWmY2MTFhb2RZYW9RL08zRDFJY2haaHcv?=
 =?utf-8?B?K0Zya21OQ3c4YkFkY3gzNVlYQmFqZ0d4aGxlM3dZNlJTWll0T1dhb2xEeWlo?=
 =?utf-8?B?ZnYvZkZuYko3WE96OS9ZVnlKOWYrNWpNaEVjU2JqbVRFcUU2ckVuelNUTEdh?=
 =?utf-8?B?M0gzbVBzb3dCd0ZNdkYxdHFPSmRGaGZPMzZvQUtISWpZeG9pUGFyS3BmYndZ?=
 =?utf-8?B?NHBMU2hZWnRNYzFWdnVDYklKMjFEZVVPckpDcEZrSmM4bVNKSjVHNUhEdTRV?=
 =?utf-8?B?MTZ0c1FUaUZVY2owTHZlMzh5bWpYeG8zOG5DT3o5UmozSkdzcGV4dnhwZUll?=
 =?utf-8?B?OVk5T2dvMTdjeUJ3LzJ0TTRPbDZSc2sxZ1lpajBvZXBQMlRaQ2l3QnRtS1M2?=
 =?utf-8?B?a2ZjT0dJbE91dWJwUGlua3VPT0h6NWI4UTJZcmlrRzExWUZ1N0w3YXJ2UmIx?=
 =?utf-8?B?bmFNbTdFckcvZmYrUG5FUTAwczdDd2xVVEpRL09HNWtLMnpQU3I0VUJ0NjRH?=
 =?utf-8?B?ZEJ4NWtGZlhJcS9tUDh5NkpSa3BRdDJtdG84ZFpXTTNrWmd2Y0NqdCtrMW1Q?=
 =?utf-8?B?K1pxV3NxakUyOVVIZE40WC9Kdm9lN0FwclRTWFJ3SEJNK3l6S2lib2pzYUs2?=
 =?utf-8?B?VEgwNVhpSEUrSEUxam1hVzhrdmFnTlNBeWkvT25NVlM0WkhCdHJPb1lSQyts?=
 =?utf-8?B?QW1helpSMDc1djI3ayt6bXpSZnI1RjkwZmRQOS9JWnFveExNZExjNmVhQk9s?=
 =?utf-8?B?cTQ2Y1VsS1U1d3hZNUlUVm9xU3hTdGtxbElicFp0VjRuOFh1L3lrWUs3R0Zs?=
 =?utf-8?B?RG5GVFEvZk96bW4yQmdTMFBIa3lXM2o0TlgrdlN3Q21OQjFVNmZxRzZxQnIw?=
 =?utf-8?B?OGxBK3U1VXB3Q24xOEVmVE5ZeWJ6U2VodVRCbWcwVFNRUTl1em8wNWJDd2hp?=
 =?utf-8?B?Q1htb1JqZkxSaHpwQTEyemNYNWdxYnNtSXprNFFnNUFDckhPeS9vZmJJR291?=
 =?utf-8?B?cEJJbDdNQ2NoNGVFRUtVUG00V0QrSGttcHMxUzVrcHZBWHpNRHlFUUR5Wnl1?=
 =?utf-8?B?VWJNL0FrTWJiQnJVemhGaGpoSmkzYk82QWJsU1ByVkVZOEs1NTdhUExXSjY0?=
 =?utf-8?B?SXpKRmNGY3QzRHI3SkV3dGk3Z2V0RW1nb3F0Sm5aaVN3bGdrZzMrQzh4b0py?=
 =?utf-8?B?UDdGOUFPL3BWbnhMRXIxN2dOU1QxMHVZdE9mN0h1d1ZWSkhFNjJrS1hEYWdm?=
 =?utf-8?B?RVZCMDBYNmoxdmRWSkUyQ1N2TXQ4MUoyZ3pLK0ZZUVJSUmdubjh4ZmZBMlhB?=
 =?utf-8?Q?3PMRkiWcA2fXhFyq5KWU5P1C9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37677403-d947-4d25-6294-08dc8f6b3215
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 07:49:34.6364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ft2fJgZFHx+hEkOB5E4mawuRfHf/BRty8U7HWOVwJqH8TsQ6UhK33MVSSVsGKVBDJ5CQyE1pA5Birc9EIOz/rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
X-OriginatorOrg: intel.com

On 2024-06-17 at 14:03:41 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 6/14/2024 10:01 PM, Chen Yu wrote:
> > On 2024-06-14 at 12:48:37 +0200, Vincent Guittot wrote:
> > > On Fri, 14 Jun 2024 at 11:28, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > 
> > > > On Thu, Jun 13, 2024 at 06:15:59PM +0000, K Prateek Nayak wrote:
> > > > > Effects of call_function_single_prep_ipi()
> > > > > ==========================================
> > > > > 
> > > > > To pull a TIF_POLLING thread out of idle to process an IPI, the sender
> > > > > sets the TIF_NEED_RESCHED bit in the idle task's thread info in
> > > > > call_function_single_prep_ipi() and avoids sending an actual IPI to the
> > > > > target. As a result, the scheduler expects a task to be enqueued when
> > > > > exiting the idle path. This is not the case with non-polling idle states
> > > > > where the idle CPU exits the non-polling idle state to process the
> > > > > interrupt, and since need_resched() returns false, soon goes back to
> > > > > idle again.
> > > > > 
> > > > > When TIF_NEED_RESCHED flag is set, do_idle() will call schedule_idle(),
> > > > > a large part of which runs with local IRQ disabled. In case of ipistorm,
> > > > > when measuring IPI throughput, this large IRQ disabled section delays
> > > > > processing of IPIs. Further auditing revealed that in absence of any
> > > > > runnable tasks, pick_next_task_fair(), which is called from the
> > > > > pick_next_task() fast path, will always call newidle_balance() in this
> > > > > scenario, further increasing the time spent in the IRQ disabled section.
> > > > > 
> > > > > Following is the crude visualization of the problem with relevant
> > > > > functions expanded:
> > > > > --
> > > > > CPU0                                                  CPU1
> > > > > ====                                                  ====
> > > > >                                                        do_idle() {
> > > > >                                                                __current_set_polling();
> > > > >                                                                ...
> > > > >                                                                monitor(addr);
> > > > >                                                                if (!need_resched())
> > > > >                                                                        mwait() {
> > > > >                                                                        /* Waiting */
> > > > > smp_call_function_single(CPU1, func, wait = 1) {                              ...
> > > > >        ...                                                                     ...
> > > > >        set_nr_if_polling(CPU1) {                                               ...
> > > > >                /* Realizes CPU1 is polling */                                  ...
> > > > >                try_cmpxchg(addr,                                               ...
> > > > >                            &val,                                               ...
> > > > >                            val | _TIF_NEED_RESCHED);                           ...
> > > > >        } /* Does not send an IPI */                                            ...
> > > > >        ...                                                             } /* mwait exit due to write at addr */
> > > > >        csd_lock_wait() {                                       }
> > > > >        /* Waiting */                                           preempt_set_need_resched();
> > > > >                ...                                             __current_clr_polling();
> > > > >                ...                                             flush_smp_call_function_queue() {
> > > > >                ...                                                     func();
> > > > >        } /* End of wait */                                     }
> > > > > }                                                             schedule_idle() {
> > > > >                                                                        ...
> > > > >                                                                        local_irq_disable();
> > > > > smp_call_function_single(CPU1, func, wait = 1) {                      ...
> > > > >        ...                                                             ...
> > > > >        arch_send_call_function_single_ipi(CPU1);                       ...
> > > > >                                                \                       ...
> > > > >                                                 \                      newidle_balance() {
> > > > >                                                  \                             ...
> > > > >                                              /* Delay */                       ...
> > > > >                                                    \                   }
> > > > >                                                     \                  ...
> > > > >                                                      \-------------->  local_irq_enable();
> > > > >                                                                        /* Processes the IPI */
> > > > > --
> > > > > 
> > > > > 
> > > > > Skipping newidle_balance()
> > > > > ==========================
> > > > > 
> > > > > In an earlier attempt to solve the challenge of the long IRQ disabled
> > > > > section, newidle_balance() was skipped when a CPU waking up from idle
> > > > > was found to have no runnable tasks, and was transitioning back to
> > > > > idle [2]. Tim [3] and David [4] had pointed out that newidle_balance()
> > > > > may be viable for CPUs that are idling with tick enabled, where the
> > > > > newidle_balance() has the opportunity to pull tasks onto the idle CPU.
> > > > 
> > > > I don't think we should be relying on this in any way shape or form.
> > > > NOHZ can kill that tick at any time.
> > > > 
> > > > Also, semantically, calling newidle from the idle thread is just daft.
> > > > You're really not newly idle in that case.
> > > > 
> > > > > Vincent [5] pointed out a case where the idle load kick will fail to
> > > > > run on an idle CPU since the IPI handler launching the ILB will check
> > > > > for need_resched(). In such cases, the idle CPU relies on
> > > > > newidle_balance() to pull tasks towards itself.
> > > > 
> > > > Is this the need_resched() in _nohz_idle_balance() ? Should we change
> > > > this to 'need_resched() && (rq->nr_running || rq->ttwu_pending)' or
> > > > something long those lines?
> > > 
> > > It's not only this but also in do_idle() as well which exits the loop
> > > to look for tasks to schedule
> > > 
> > > > 
> > > > I mean, it's fairly trivial to figure out if there really is going to be
> > > > work there.
> > > > 
> > > > > Using an alternate flag instead of NEED_RESCHED to indicate a pending
> > > > > IPI was suggested as the correct approach to solve this problem on the
> > > > > same thread.
> > > > 
> > > > So adding per-arch changes for this seems like something we shouldn't
> > > > unless there really is no other sane options.
> > > > 
> > > > That is, I really think we should start with something like the below
> > > > and then fix any fallout from that.
> > > 
> > > The main problem is that need_resched becomes somewhat meaningless
> > > because it doesn't  only mean "I need to resched a task" and we have
> > > to add more tests around even for those not using polling
> > > 
> > > > 
> > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > > index 0935f9d4bb7b..cfa45338ae97 100644
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -5799,7 +5800,7 @@ static inline struct task_struct *
> > > >   __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > > >   {
> > > >          const struct sched_class *class;
> > > > -       struct task_struct *p;
> > > > +       struct task_struct *p = NULL;
> > > > 
> > > >          /*
> > > >           * Optimization: we know that if all tasks are in the fair class we can
> > > > @@ -5810,9 +5811,11 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > > >          if (likely(!sched_class_above(prev->sched_class, &fair_sched_class) &&
> > > >                     rq->nr_running == rq->cfs.h_nr_running)) {
> > > > 
> > > > -               p = pick_next_task_fair(rq, prev, rf);
> > > > -               if (unlikely(p == RETRY_TASK))
> > > > -                       goto restart;
> > > > +               if (rq->nr_running) {
> > > 
> > > How do you make the diff between a spurious need_resched() because of
> > > polling and a cpu becoming idle ? isn't rq->nr_running null in both
> > > cases ?
> > > In the later case, we need to call sched_balance_newidle() but not in the former
> > > 
> > 
> > Not sure if I understand correctly, if the goal of smp_call_function_single() is to
> > kick the idle CPU and do not force it to launch the schedule()->sched_balance_newidle(),
> > can we set the _TIF_POLLING_NRFLAG rather than _TIF_NEED_RESCHED in set_nr_if_polling()?
> > I think writing any value to the monitor address would wakeup the idle CPU. And _TIF_POLLING_NRFLAG
> > will be cleared once that idle CPU exit the idle loop, so we don't introduce arch-wide flag.
> Although this might work for MWAIT, there is no way for the generic idle
> path to know if there is a pending interrupt within a TIF_POLLING_NRFLAG
> section. do_idle() sets TIF_POLLING_NRFLAG and relies on a bunch of
> need_resched() checks along the way to bail early until finally doing a
> current_clr_polling_and_test() before handing off to the cpuidle driver
> in call_cpuidle(). I believe this section will necessarily need the sender
> to indicate a pending interrupt via TIF_NEED_RESCHED flag to enable the
> early bail out before going into the cpuidle driver since this case cannot
> be considered the same as a break from MWAIT.
>

I see, this is a good point. So you mean with only TIF_POLLING_NRFLAG there is
possibility that the 'ipi kick CPU out of idle' is lost after the CPU enters
do_idle() and before finally entering the idle state. While setting _TIF_NEED_RESCHED
could help the do_idle() loop to detect pending request easier. BTW, before the
commit b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()"), the
lost of ipi after entering do_idle() and before entering driver idle state
is also possible, right(the local irq is disabled)?
 
> On x86, there seems to be a possibility of missing an interrupt if
> someone writes _TIF_POLLING_NRFLAG to thread info between the target
> executing MONTOR and MWAIT. AMD64 Architecture Programmer’s Manual
> Volume 3: "General-Purpose and System Instructions", Chapter 4. "System
> Instruction Reference", section "MWAIT" carries the following note in
> the coding requirements:
> 
> "MWAIT must be conditionally executed only if the awaited store has not
> already occurred. (This prevents a race condition between the MONITOR
> instruction arming the monitoring hardware and the store intended to
> trigger the monitoring hardware.)"
> 
> There exists a similar note in the "Example" section for "MWAIT" in
> Intel 64 and IA-32 Architectures Software Developer’s Manual, Vol 2B
> Chapter 4.3 "Instructions (M-U)"
> 

Thanks for the explaination of this race condition in detail.

thanks,
Chenyu

