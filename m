Return-Path: <linux-pm+bounces-9205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB5B909064
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 18:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90AE31F215AF
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC2A19AD4B;
	Fri, 14 Jun 2024 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TceB9iWQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0B4F503;
	Fri, 14 Jun 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382720; cv=fail; b=YaI6m6jeza9cqa4TjsRIWKzKrbu3Y2hejuLBdRrDz6TnjA2LCQmMcC8z7eJkUiQFi1FUoLJwYqLp7uyVFHBxv4zKR6xnc1i7ujZ6TE92OyLf15YeWUwWs3P/6eiDqggEkjksvJj9PzfBZHjID1EhB12B1fU1y4buLsXpCTxpU0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382720; c=relaxed/simple;
	bh=9Np5UsuIEc+R2bqjyybwYCvPGJTmQf9b3bnbuX8DT+k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PQXBZ7b+xqQpRy8sYYGoJgGq+Xm3UBP2yiDd9lN8Ql0wAyN81SyOM9EZdBuI6SUVCW5JRQPR6RIf+ATPQ4BtGrxIHiYZLkxnfqUdPuLVPnJ7J3BfhcKuovwlZbB80WyjnHIeIyHGh/+2MYhAU0J3tTnCXZJ/BZYSQcVDrl0W3PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TceB9iWQ; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718382719; x=1749918719;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9Np5UsuIEc+R2bqjyybwYCvPGJTmQf9b3bnbuX8DT+k=;
  b=TceB9iWQo63wPDcPR5u5JKaVDuwSGO8mg93neANaI3HCTbMPPOi+PLtI
   3x65fog5l3PzY/ChPCEFstWoU/3s++GKWXz3B9kBvSLNIKfacjZL3Hwh4
   pIN+OzQrljEiVgt466w2ud8XEJxvgD2i1uz8JrkFQuzd3DUduAdIb91VN
   1Hkfvitx2vrtg6MMja5TtdtULfO59JTYiNeVoAIKy4QQZFVXq0nie4dMq
   TI8wxBcZsd6csqbbfRuOF8IdOBvLuBbfhmER3XFp8EB4yOGeIoFxv77nM
   Cl9Ndr0joSRXs7DFoL7eauEIh6vASY95grITRyW4TDLev/MpH5UrGIO3e
   Q==;
X-CSE-ConnectionGUID: 1uKoDE5RRyyArSSVUpXRdA==
X-CSE-MsgGUID: 16hFHmX/R5SRW/C7NTPrTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19101397"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="19101397"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 09:31:57 -0700
X-CSE-ConnectionGUID: scY7lsMxTA6tLlpjFkDvGQ==
X-CSE-MsgGUID: HaiTD4/QRuaO988JQxfTOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="40422383"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 09:31:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 09:31:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 09:31:55 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 09:31:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgdHd0PQAW8Gnqx9RWAcSdnUyqXaV05x6PVGDkQ+hYA2U+wzE3sqKi3G0zZaCI8JGN5jNm02aWLvF9MCOhuB0zodugBmo6fApTpqPBY6kk2FXXVz+gkNv2iJvjQ5fBC6VcQwaKOYTLeiUgtSM6yL/J3HrTm6CRfyN5Sq+C7NaZ8okSgfNGPZsey3bGEKCIQmhp8tOLiTu8ZP9Wx+r8xokomYDoql6cs6C21HKu4Nvlj2yUixmZigFiJ4bqNInrxddxznuxIrMhKH403Ww4KAmzqqCor6AIUZMpCbld5sPg32vRLG9Ko3uirPSYMghmiGwo7gtPtk72aQx0zFZHRxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4XyXP9bnp8lGiffbZ6qRLKbpwPhOUC+Q/jJqNNc0Ss=;
 b=i6hYG05BqhQ+S8Qk3pIgx6updMExITkJGQbtWKpObTv3PA7SHIsl5gtduYuiUbK01tBoHhyjPb60vUuL8po9HuNLt6Oml37r03ClcePAzafbkuI9we6+i4+/gyPQHMkynMz3K/5vjjSbbwRr2eq7oG2yBHkRRljOBfvueDX6/cvsZbWyOGyPxcMx6BDvQkQ5DGIoEZ+01T3B+0wE7wyarGSk+0SRkSAb4TQEQGEUNPLy7MJG32Q+Q1mnL+zW+zGL0GEp5ajw3lIqzgJUV5wZCNZgR7DcWv7utmv7K4N65hKeryRrYmjEYL6GKX5KOg67vJDrKVsmMttTEZiqBfvcLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.26; Fri, 14 Jun 2024 16:31:52 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.7633.036; Fri, 14 Jun 2024
 16:31:52 +0000
Date: Sat, 15 Jun 2024 00:31:21 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: Peter Zijlstra <peterz@infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, <linux-kernel@vger.kernel.org>, "Gautham R. Shenoy"
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
	<xin3.li@intel.com>, "Kees Cook" <keescook@chromium.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Tony Battersby <tonyb@cybernetics.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Brian Gerst <brgerst@gmail.com>, Leonardo Bras
	<leobras@redhat.com>, "Imran Khan" <imran.f.khan@oracle.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Rik van Riel" <riel@surriel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, "David Vernet" <void@manifault.com>, Julia
 Lawall <julia.lawall@inria.fr>, <linux-alpha@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-csky@vger.kernel.org>,
	<linux-openrisc@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-sh@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <linux-pm@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v2 00/14] Introducing TIF_NOTIFY_IPI flag
Message-ID: <ZmxwWdW78hjNuxWU@chenyu5-mobl2>
References: <20240613181613.4329-1-kprateek.nayak@amd.com>
 <20240614092801.GL8774@noisy.programming.kicks-ass.net>
 <CAKfTPtBTxhbmh=605TJ9sRw-nFu6w-KY7QpAxRUh5AjhQWa2ig@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtBTxhbmh=605TJ9sRw-nFu6w-KY7QpAxRUh5AjhQWa2ig@mail.gmail.com>
X-ClientProxiedBy: SG2PR03CA0123.apcprd03.prod.outlook.com
 (2603:1096:4:91::27) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CO1PR11MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: 99291a0b-f3d1-4b56-23d6-08dc8c8f7f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8tyR0HZN3w8v9nFOa7j0j7AE41u4TTMBiW24FubJl51Sy7EpEgxNF79OlA3F?=
 =?us-ascii?Q?nAOyEJiGKvRyW/uUCVWSmsYW2iyuwdCTwffsQMfgtWMBsu9IzteORnn3mMkG?=
 =?us-ascii?Q?KdKcNqAnRx2N5HHrWPBw4PBaw5aZIVNRRobF7l/hGvkx8nN9+ZdJWTBMU4i/?=
 =?us-ascii?Q?sJz5dA7rPAQPqAWCEJjrDUAUilx1+rVXuuvW2/hzkk/yOZOU5UaWPJ0MKTQT?=
 =?us-ascii?Q?AfgdHsjCpv7DVQiEmlw0dUzNGXoiclOXacgsexCg87YbzrFxrxdGCXiwuEJG?=
 =?us-ascii?Q?9cfdWWpCpQXZEwLLEQpkXiEHguQOPpv/udi1L2dnd2qRJZ0QF+pxQvQRu6Vp?=
 =?us-ascii?Q?3O34G63d4PJ6B6Tqk0qxmbcqcSj5Y/Dpx74+C/YVRvefIl+C28T3YmSwSW2d?=
 =?us-ascii?Q?qlBBLg1ZaY7TpRMV2C8Cd2rbCpU1BObgNWivqp+zuDYWnAifJv4XcOMEFTxe?=
 =?us-ascii?Q?xr0iYPBwHdDAVhCY5sca7Ax+E3EmDdU3Bs0A+jHoaN9EHcZZGwjQO2d+zndn?=
 =?us-ascii?Q?XYIa7bfc7TGb7wW0GgrhBKXyy4RO9j+uxRtRfHgQOzbpdmCS4rXBCqlqF9/E?=
 =?us-ascii?Q?r9vBGi/wkV6aSHYm2JCe4lvlujPYXjaxjpYD4dttsq68r6i9Zi5Uqk2o/Y4K?=
 =?us-ascii?Q?inSCS+Gdg22x+L+KtDEU8BgH1jPvXS6kv2LoVc5wTGONPgkMRe1YnJDv2XfE?=
 =?us-ascii?Q?GeYfv5L+JE5ijmJruVXw06qy+EWRoDSFTdg2+/DVJs9vWLOBU3AmbJFb7KZj?=
 =?us-ascii?Q?HKCsMNNng2buZFe7H16lRTlp0mRWFeg6MGlWmsqmLKp+pgwPTTG0tGZhGOkG?=
 =?us-ascii?Q?KtCh4L7IYRZqwzTnRS7tI4JebvYnEZG+3b6wqvtpa7ZHCgxzUz4OxxpxTMjG?=
 =?us-ascii?Q?fg9VdTYv/p2lVptOA4+mqWN8xkEiJO+NBghN7ufbnWluYhHQe9Yg/p5Mnj4A?=
 =?us-ascii?Q?2yTIiCo3FclesDCSsCehqTiEJn1sg0bL6gefiXEgqbbZLxUGOx12ZjiJII5b?=
 =?us-ascii?Q?RcFZMlFy7ScbV/hD4eGeX1ZmAqit1h0PO+4ujzd4tKPsEWLUMqdXtSOUjIfW?=
 =?us-ascii?Q?I1f3CDCVegHNq0s/8LCdDxwOs2DbF9J6etRpv77y0HQfJeriiLprAfCPkDvV?=
 =?us-ascii?Q?TKHh329uWlYeA8o0Xw8/R4cv90LwkJfrDNJNOTbQ8SguPIhcqfilH+lisOmE?=
 =?us-ascii?Q?fkSSxoXsG9ROvfvQl7nfTRl4iKg87xngLf+qbhpPCgcwIxY/ouh120i6xdxP?=
 =?us-ascii?Q?ekpyHBUDCQ7ZDwX8IJhE9nxdCKicNcOFAf+nR9GI5JjkmppHjuzBpdd04TJq?=
 =?us-ascii?Q?Ee/tfeoxjscrnI84urfSSNk9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kKmk6f/d5tfL7ajLXw8c/prToW5dmicVWy/BZxLE7S++6HU7jhiOIBez1pQz?=
 =?us-ascii?Q?40yHFfMsp11BvZQPmDdhoCrOU8nbMumynZVxZal5r0Sa1mc5zk7PPbYBZHQC?=
 =?us-ascii?Q?gVzmlz/U8VUP3R9wl5FmMXpFQdUX8mInAEVdlfG2Q3JSDFOxb5BuoOq/tVxf?=
 =?us-ascii?Q?JBRrC/5//ZG7mAtW5PJKoSdiRHsp/lfHAZdV3JpjNhqg+C5FCK1Cla8uxwCZ?=
 =?us-ascii?Q?uVj8uSAWwaY2WWDT/IPONcVRdsyz523zto5lGZM690Xtd3K8KrZa5/tp6msB?=
 =?us-ascii?Q?Nwe3+1todCufWXTxUx4kiaYvMetzWsCW4ZFvL+kOk2/8ZkCiGKDeHCNWQd+A?=
 =?us-ascii?Q?HwOOS1TI/iLVIe5v9SCKFDJ0UEY8dCx67lkQ1LlonXpU372sHbwy4xbYOgvx?=
 =?us-ascii?Q?O5ByXy5jJbrgSOPqemYsu/jMrHy6yq8AToRkawac0JNhXdRnwndMC8UBTkPw?=
 =?us-ascii?Q?WpwQ9MAQQ499y3LAuyn+zLU3lwYzqa/GDkdt4QLeEs7AKo00dNm6ky+Uae0I?=
 =?us-ascii?Q?WWegf32alzyW8P9ChP4ZTeiiuHX+ndFInjVZRVqhRa7b4KLcFmchzuFmGWee?=
 =?us-ascii?Q?qP4LOn8T54cU2dpoLnNlJP+ni776yZ1rKsitVCh8k0lMpLGNEXZOttU3wCxO?=
 =?us-ascii?Q?s+fzFmshO4U3xy8CAD8whdevcCVwPKibvIYrHPFdXGhf2m1K/cBiLue4gfek?=
 =?us-ascii?Q?W7fpb5OIgQgkT0f3BIqNVae8ifAAEAbu/2SmkZVCOGjw+gbnAwFfsV+7JIkw?=
 =?us-ascii?Q?/yCrTlOtZ7Hevp83ci/TKKtqhwM27Ti8MBHeos4oA3YRFZl8epgS06tM610j?=
 =?us-ascii?Q?eRkGTtFLb8TNGHu1wgJw/9sDGbreybPYf3Zbl2x+ZrxSRHsGocFxlRZAtJMO?=
 =?us-ascii?Q?ZV4UCJPVpmDFwgqGGp4+yyRx31M5vGrFk0B9UJbS1g9CUT9COWFv1fhi6Jjs?=
 =?us-ascii?Q?PLPMnKJNGVO01vS/ocWcDnz2A5zfkSSe0SsM0j10+cCtIs6HUemJ0wxNKZgG?=
 =?us-ascii?Q?qTchHWoQ2pVi6rcAxu7IWZGdpG2wO2PGj44E11ExilaTxGnBeaVjf/+AFYzK?=
 =?us-ascii?Q?KBvY2aC9m8x/Ya4mk2dvGFfV+saYikAN4fXW1GZ0K8spls7o+zjyNeGcGxWu?=
 =?us-ascii?Q?jX4x5e+4PXVWUe6RbNvfDvltpshEoLt6HJZrAFJjAAyZT2eaxCQ9Hft58+Fb?=
 =?us-ascii?Q?cckjkb5KW3YxE2hxvZLUL+L9phuD3Oqcl1uLp4eYi1JmxZ8qPdoVFCKQVjaZ?=
 =?us-ascii?Q?AJaC2MF3IhWh5V0zJbwfb/8OF1B+YBEJXHU8mrzHrnPn5jmecXhzc0RGvDTT?=
 =?us-ascii?Q?Wi1/jwfvLGyt7HL8Nf7wubHBvWBROUcu5OqzSw9M+EFO7nX8uo3BxQFoKlcD?=
 =?us-ascii?Q?Lp6K07MVnDjC+IPEHSatUZ6gjj53s6qVkAvDUip+Jaeps0hHkW/IBWpVTByi?=
 =?us-ascii?Q?VmgTm08VQ1LHKBmJhQh4+bwK0eTfImgbm2RdeLMPvDvXEhcpDYb/Kij7YmPd?=
 =?us-ascii?Q?CmCbbCamVpz3WWdKudmSOZ68SikMYncBHMvd7S6wgp5CPDQgFb9CqBoCZ3ea?=
 =?us-ascii?Q?9Fgiv9L32KRFYUZI4HgFJM2mo20My60EKixSUVQB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99291a0b-f3d1-4b56-23d6-08dc8c8f7f29
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 16:31:52.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsMVdZtq9TymtRq4lajgeHpRtxeZs87JSHMxQw23Kf9GqbdekK1F8klkbPqz5QiXBM+fpJJfd4cW/6Eag5XZpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4945
X-OriginatorOrg: intel.com

On 2024-06-14 at 12:48:37 +0200, Vincent Guittot wrote:
> On Fri, 14 Jun 2024 at 11:28, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jun 13, 2024 at 06:15:59PM +0000, K Prateek Nayak wrote:
> > > Effects of call_function_single_prep_ipi()
> > > ==========================================
> > >
> > > To pull a TIF_POLLING thread out of idle to process an IPI, the sender
> > > sets the TIF_NEED_RESCHED bit in the idle task's thread info in
> > > call_function_single_prep_ipi() and avoids sending an actual IPI to the
> > > target. As a result, the scheduler expects a task to be enqueued when
> > > exiting the idle path. This is not the case with non-polling idle states
> > > where the idle CPU exits the non-polling idle state to process the
> > > interrupt, and since need_resched() returns false, soon goes back to
> > > idle again.
> > >
> > > When TIF_NEED_RESCHED flag is set, do_idle() will call schedule_idle(),
> > > a large part of which runs with local IRQ disabled. In case of ipistorm,
> > > when measuring IPI throughput, this large IRQ disabled section delays
> > > processing of IPIs. Further auditing revealed that in absence of any
> > > runnable tasks, pick_next_task_fair(), which is called from the
> > > pick_next_task() fast path, will always call newidle_balance() in this
> > > scenario, further increasing the time spent in the IRQ disabled section.
> > >
> > > Following is the crude visualization of the problem with relevant
> > > functions expanded:
> > > --
> > > CPU0                                                  CPU1
> > > ====                                                  ====
> > >                                                       do_idle() {
> > >                                                               __current_set_polling();
> > >                                                               ...
> > >                                                               monitor(addr);
> > >                                                               if (!need_resched())
> > >                                                                       mwait() {
> > >                                                                       /* Waiting */
> > > smp_call_function_single(CPU1, func, wait = 1) {                              ...
> > >       ...                                                                     ...
> > >       set_nr_if_polling(CPU1) {                                               ...
> > >               /* Realizes CPU1 is polling */                                  ...
> > >               try_cmpxchg(addr,                                               ...
> > >                           &val,                                               ...
> > >                           val | _TIF_NEED_RESCHED);                           ...
> > >       } /* Does not send an IPI */                                            ...
> > >       ...                                                             } /* mwait exit due to write at addr */
> > >       csd_lock_wait() {                                       }
> > >       /* Waiting */                                           preempt_set_need_resched();
> > >               ...                                             __current_clr_polling();
> > >               ...                                             flush_smp_call_function_queue() {
> > >               ...                                                     func();
> > >       } /* End of wait */                                     }
> > > }                                                             schedule_idle() {
> > >                                                                       ...
> > >                                                                       local_irq_disable();
> > > smp_call_function_single(CPU1, func, wait = 1) {                      ...
> > >       ...                                                             ...
> > >       arch_send_call_function_single_ipi(CPU1);                       ...
> > >                                               \                       ...
> > >                                                \                      newidle_balance() {
> > >                                                 \                             ...
> > >                                             /* Delay */                       ...
> > >                                                   \                   }
> > >                                                    \                  ...
> > >                                                     \-------------->  local_irq_enable();
> > >                                                                       /* Processes the IPI */
> > > --
> > >
> > >
> > > Skipping newidle_balance()
> > > ==========================
> > >
> > > In an earlier attempt to solve the challenge of the long IRQ disabled
> > > section, newidle_balance() was skipped when a CPU waking up from idle
> > > was found to have no runnable tasks, and was transitioning back to
> > > idle [2]. Tim [3] and David [4] had pointed out that newidle_balance()
> > > may be viable for CPUs that are idling with tick enabled, where the
> > > newidle_balance() has the opportunity to pull tasks onto the idle CPU.
> >
> > I don't think we should be relying on this in any way shape or form.
> > NOHZ can kill that tick at any time.
> >
> > Also, semantically, calling newidle from the idle thread is just daft.
> > You're really not newly idle in that case.
> >
> > > Vincent [5] pointed out a case where the idle load kick will fail to
> > > run on an idle CPU since the IPI handler launching the ILB will check
> > > for need_resched(). In such cases, the idle CPU relies on
> > > newidle_balance() to pull tasks towards itself.
> >
> > Is this the need_resched() in _nohz_idle_balance() ? Should we change
> > this to 'need_resched() && (rq->nr_running || rq->ttwu_pending)' or
> > something long those lines?
> 
> It's not only this but also in do_idle() as well which exits the loop
> to look for tasks to schedule
> 
> >
> > I mean, it's fairly trivial to figure out if there really is going to be
> > work there.
> >
> > > Using an alternate flag instead of NEED_RESCHED to indicate a pending
> > > IPI was suggested as the correct approach to solve this problem on the
> > > same thread.
> >
> > So adding per-arch changes for this seems like something we shouldn't
> > unless there really is no other sane options.
> >
> > That is, I really think we should start with something like the below
> > and then fix any fallout from that.
> 
> The main problem is that need_resched becomes somewhat meaningless
> because it doesn't  only mean "I need to resched a task" and we have
> to add more tests around even for those not using polling
> 
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 0935f9d4bb7b..cfa45338ae97 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5799,7 +5800,7 @@ static inline struct task_struct *
> >  __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  {
> >         const struct sched_class *class;
> > -       struct task_struct *p;
> > +       struct task_struct *p = NULL;
> >
> >         /*
> >          * Optimization: we know that if all tasks are in the fair class we can
> > @@ -5810,9 +5811,11 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >         if (likely(!sched_class_above(prev->sched_class, &fair_sched_class) &&
> >                    rq->nr_running == rq->cfs.h_nr_running)) {
> >
> > -               p = pick_next_task_fair(rq, prev, rf);
> > -               if (unlikely(p == RETRY_TASK))
> > -                       goto restart;
> > +               if (rq->nr_running) {
> 
> How do you make the diff between a spurious need_resched() because of
> polling and a cpu becoming idle ? isn't rq->nr_running null in both
> cases ?
> In the later case, we need to call sched_balance_newidle() but not in the former
>

Not sure if I understand correctly, if the goal of smp_call_function_single() is to
kick the idle CPU and do not force it to launch the schedule()->sched_balance_newidle(),
can we set the _TIF_POLLING_NRFLAG rather than _TIF_NEED_RESCHED in set_nr_if_polling()?
I think writing any value to the monitor address would wakeup the idle CPU. And _TIF_POLLING_NRFLAG
will be cleared once that idle CPU exit the idle loop, so we don't introduce arch-wide flag.

thanks,
Chenyu
 
> > +                       p = pick_next_task_fair(rq, prev, rf);
> > +                       if (unlikely(p == RETRY_TASK))
> > +                               goto restart;
> > +               }
> >
> >                 /* Assume the next prioritized class is idle_sched_class */
> >                 if (!p) {

