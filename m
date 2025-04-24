Return-Path: <linux-pm+bounces-26067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4140CA9A0A0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 07:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662DF7AD03D
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 05:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211781B393A;
	Thu, 24 Apr 2025 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/5/dvEn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C73FE7;
	Thu, 24 Apr 2025 05:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745473827; cv=fail; b=Yjh9yftlzrK+badeG2Xu25mV2FlVCUExYuIvUcVS/tEhvzPXyJlb8romdJhNbkXOqUCnJzizh6AWYgYHmIUcRF5tU7kshZssPl3y51luZEEdHG6OYGQ0Zw6QWtM4fopA/H2ZPRhAZIydmPJSeChxpq9/HZvKw2pj6/KQsR3ed/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745473827; c=relaxed/simple;
	bh=sIrtBoeY8VByc0ZlXoYBCNJqFZ9EV4mOBy5GJRlQClU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Swq/S4YSfXUvrQxUWYr/Vquyt/KVBHF9JgHDs1JK51aZJOe+6u7qcPvJfizZRSxRIt1457Mb8H7lq8wGaXYCtKlA6SNjA23AY956PzJK+8TBqFiifoCGSuzbtvI6HmedkHiXJKnt8iXV5Y/XxEQOb/8755ClDDGyJAlKImSViNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/5/dvEn; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745473825; x=1777009825;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=sIrtBoeY8VByc0ZlXoYBCNJqFZ9EV4mOBy5GJRlQClU=;
  b=W/5/dvEnxFGJKJYco3qxy+58ECVEKXlsJ/Nbd4bVBIAjxkguJlqOyOg1
   nwoUNZAK4dBMv2KeMtBdIBUEW+Na4kiDjaB24KJqzsqKCNIGadVNnfDCR
   zPiujywG2AqBBf+mS4/hhNUMmhKDCr3btDrT7QIKYXgx4nrkVwRhiMqCY
   8zJxFrJD1q59G+lJbLwLKPaBSD3bbvLWH7iHhQ24DcJTJmPg3qSkeBgA/
   Nmlc6auH/pwK9hWSQYC1I2zBr1GUIzkEqx0iR+sLRgXbKegiBeViBG24A
   HOH3HSj5aim1WsMYFvHs4272uoYd4Gx1V3P39sOOOEPRtubM8soZj12f7
   Q==;
X-CSE-ConnectionGUID: 5hLBi31TTYays+jeGKiTYA==
X-CSE-MsgGUID: eQRd8A/zT7qIi3Zf2qQNXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46796814"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="46796814"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 22:50:24 -0700
X-CSE-ConnectionGUID: NnzBXnukSR+ISFwEIVMOZA==
X-CSE-MsgGUID: CM2s7ax1QECMxCpaY4eH1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="133041910"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 22:50:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 22:50:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 22:50:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 22:50:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjs1moxMct+7m760A12H4q5GMquyuEWa7vZklkgxCCUCVzW3UIBsOq5LwFauaIIqXEBcn/pX1FKfe9v6+vaHGHchGHnh1gkbmtE/Eb2LCN736z7yqPnfRcnHx5cOpI+L3sRzOcpeejUh1qMB6JuZOH34WylTKdAe1PRAW5/BtgeN4eK5TUozcq/z6bHyIYi+qA/kw1hAbfgRP7igtdodZO4K1rihOtsYU68OjSd54Jm5tbPTs6aks6MJi2XY06qFG2pLI2VT2H7ooTQ0Z1z6HnwqnbTuWwKpPEQczPzSm+OnrHZh4TYFPeTNeAmJbA4jPWsEkODGBJMsJGjvNHwDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRAqKlnYvbotHU+5hIGjmHxaNX0To6JNKGLot6gEwsc=;
 b=x2+cY0ttmmuXPsHGg3y6T3GFgE/7ZCYldD/Q2yN67ECxRgsCWlRaWJIqGt4MEsWY3S9SuX91HXcEffxsVabiz21ljjfa4i6bOyRDWnSjLu4A7EAkyjk3U7ZLZ7Hr1wpfz6DvisFGOMI5AbunMzoJbVxBM0M1ZIewQAhdB2FKFxdCHq6zBlNy8Nik7QKf3YoypOYbTlZZr4Z9jyjeCTtKCK2bCafj7xZId9JHmZ4SHBDqlKxhd2s/jMEV1ZKEsYfnGDHkYBmf699axdjV+KvgCc90ih7JnMYB//ryI9NbZfDQIoKz0OVASdD4HkmMKut/uHsILsu2eD9gRIB3yCJC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 05:49:53 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%6]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 05:49:53 +0000
Date: Thu, 24 Apr 2025 13:49:23 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Loehle <christian.loehle@arm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, <linux-pm@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [cpuidle]  38f83090f5:  fsmark.files_per_sec 5.1%
 regression
Message-ID: <202504241314.fe89a536-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|PH7PR11MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 275ea89a-f975-4018-ef8f-08dd82f3ca9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?gnERXXXACTlG2a0DZs1RR8q2Cz62jUq3EW1P25Xt2zupkYjv/pXzZrYVP/?=
 =?iso-8859-1?Q?FHg09JIQuon/IVRrH/EudJZKwVWTVQGOjxKJlzTWeTsQtCKUyNz6/QEtcR?=
 =?iso-8859-1?Q?vRie48Zp0wgmNRAdA1T4Ex/bQg+7CF0oEk6FSwmbF54LMD1R8B0sT82fmO?=
 =?iso-8859-1?Q?nXy3MZj1YoaI48XqYHAZHciJ1vsHkKBUPryneElIoIBuObJIIHjcJSOhEm?=
 =?iso-8859-1?Q?n5isNQlBZ53ZGr7zNy+nQ7cd1WDzfIMMd3B1mMA/p9hUBCcAyn6PL8iYLu?=
 =?iso-8859-1?Q?f4gFcJGcjtauXbh+opiNl8GuxEYBkBKHcm1JHxiVibCRHI+MMfeWtdG70N?=
 =?iso-8859-1?Q?IlWPiASIJES14iVRTRffrF3XRvaBbaVK+n9IBUw10qu7kN+z1XIqGo0H0Z?=
 =?iso-8859-1?Q?bS5UKd1R2rH+eBtmBIHBvwp4fBSHxNeyHGjF5O79KGQsMVAn0s8pTVPgcn?=
 =?iso-8859-1?Q?R6weQc7Wd6UH+U6wnYcStQ6WSozhlav2Aoo2s5NGEXETBkglrnvYr+zAvi?=
 =?iso-8859-1?Q?MuPMWyZv3ijQtt1AF1mJFhzDOgZhPRRvLq3neXBqi1dx/F9yzaDz8EmOKu?=
 =?iso-8859-1?Q?YmxkHi+ZTAM+Kj8VlxzzbyV3/Ozj1luAnSDP3oK1s/74B1pcbiOIja+DzG?=
 =?iso-8859-1?Q?dEZ8TSexHHKoXgj/skwE0X+zWkZPXcpWBH/N60B4Lf1Dn9DXXKlG/+NokL?=
 =?iso-8859-1?Q?S9yF7AmfZUUtAAMiIg6M7EbiR97unMRHvzPzUhCeyx7oiMvUj/rNAEd4Oe?=
 =?iso-8859-1?Q?4lu2eNYoEBiwKZZmCSmiEBOTRK544SMJQtTdlcN5NjyqfhXEf8YjUp8HJP?=
 =?iso-8859-1?Q?64HFrB9EHIxHhwszX44ly2PKrfsBXUSo8tE1HnoT6lSMxcWkhQTg87GxOf?=
 =?iso-8859-1?Q?An3yhIIXrQV+C48sCeU7S6VLpay6EB8Sk9okSFKmetnZY1tFZoD9DemloF?=
 =?iso-8859-1?Q?RNy/2eq6zW6vDmVu8hblFm9tzBDZARMmyqS9DD4/1PwMA+toGygcTKno3/?=
 =?iso-8859-1?Q?CopXPnALzxRTkMnmoic42UzjDgRymSmvbySixDoiGhbGNsjqAyZ3dqh8mf?=
 =?iso-8859-1?Q?/49fmNciGkH8U9waoxQJqaFOllOWROgrCpu5H2r9xMm1MVSjCu3xXHilym?=
 =?iso-8859-1?Q?gjg56lFsDlhgz0BK9kAG0dp/M68q1bfswxNfOnuPD1Bq+wc/dgW15yIMyG?=
 =?iso-8859-1?Q?E3gAuu9hwswHNLeDo0ftYwgBpoTtV9Tq0E10vyqxfiz6qkfbbrI63a0zD0?=
 =?iso-8859-1?Q?GIM2Wp+Hq69DXFVMJkkcPSYDCj2hgmZUpuL6NLHWmPqtKpX119XRDLkzfS?=
 =?iso-8859-1?Q?ThgjcuL8xztde6KYD31lVKMtNBNo4filxOK0ND7ukA5KCv9c/lyGKWSiaQ?=
 =?iso-8859-1?Q?7FJTTrc7Ljs+n4/xEuiDUSv2RrzgVTLC8OMPe+QHvxZOID/AJM7LzK32ZQ?=
 =?iso-8859-1?Q?KfVwyEMe/cozgpV0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JQ38h6aHpusfDuKxb3tTP3CQHEDMNlVmKv9OhJLcvIh+jT2BVCz2pYCsHR?=
 =?iso-8859-1?Q?ITbwvj+JUe0cytwqE0Hss7fMLtAqZiJLlRZ3njCIH4tE+hlMLaQBFzdoEC?=
 =?iso-8859-1?Q?GA3HGsQzJOFVw0Xal0Ic65z7/kplUV6mdsQQCnv0kDUmMSMXHYCgAqwyuY?=
 =?iso-8859-1?Q?kjMdPTlW64ZALHP4mik9aoPxjFxmCF1T/mxwbgujOOR9CGE/S8Ez2bxttf?=
 =?iso-8859-1?Q?H05XFvQMrkr58Htwd0jTcowAAdCWUxSdohnNifgHe7gRUP5NCybvdxb18J?=
 =?iso-8859-1?Q?SS556s48/lRwjbYyKNTrv+GBnnE9wC75lL79PsglGKwpwP2B6mpvJlCdLL?=
 =?iso-8859-1?Q?M2k0eUBGkDijlF8/4OjxowUz8x2PmUHFqO9Y9xihysn40UgBTnkGW0ZgDg?=
 =?iso-8859-1?Q?rRJej4iptE6JZh6mUQoAVvKoQz6gxSfreXn9hx1Z3N8IJvKUjJA5tIypaP?=
 =?iso-8859-1?Q?3Gda6iUj0uwbCPlOlhqtnQpZ0nchhGymCgB82nRahuwcsU/s2mvs5Fp64J?=
 =?iso-8859-1?Q?SpcGDZ73OC0OT1cXXBECSDCNXO8DRT0UuaRDHoSVLRi9uBOvc2nTNKCkZD?=
 =?iso-8859-1?Q?1xulOI3Sr2yBlCsjxoD2eEEDSlGLcTEu1ojaR3+StUivQcu6/vyKA57kBc?=
 =?iso-8859-1?Q?uMUz4B+0brcUUldooLr7hpnJFcBRR6HesNqxsz4F45B45lU2Uz1DsE83B1?=
 =?iso-8859-1?Q?LfPbTtoA4KJumme0Ml1wGUmjbFp3VJU6NFEhBhyrLRDPWnnLrQT+A06mFN?=
 =?iso-8859-1?Q?U1Ah6icsYreQbNIea8MMsUTyO+bG6B4OfJ2o+QX+YzckTuqk338tFR82wy?=
 =?iso-8859-1?Q?qkd7CYP6sF6dfkuDQmO//gDhrSC95kAq9DGzmIPQxVylEwsN5xaRMCrxth?=
 =?iso-8859-1?Q?M80KbX9xW/ynX4YrygJg4VCh2wQhvboX3mSWLBQS/PzJe9J66NRCWmFZbf?=
 =?iso-8859-1?Q?0U/sUlH0MVyk3paCr5uUsLmCi0JV20LGgpSsWTeXGkWF+2t1yQJ1p3t1fg?=
 =?iso-8859-1?Q?GYIGri8b1C4jL0eZmFJPlixg67MTGRB/fyksifaiEdNB2nvp79+GJfU5Dh?=
 =?iso-8859-1?Q?eJk1kHjgESedDf0PX1RV/QOgd9V0nikQLpZVB3ZwCTGVBJBvaKXkEE/rBj?=
 =?iso-8859-1?Q?RvwBbO5MRFl3E0NYEkMnaK3Pq90hVO2VUVtm2pjJz333urGKx8ziFApY2q?=
 =?iso-8859-1?Q?hYlXW8Gl3zv6qKze/K7DMjdo0YUBoOfqY6GDcdAPiaRbMDhMBfkTva4yIE?=
 =?iso-8859-1?Q?5xvFjDMBFAPGnqgEU0bzb13uTcUPptRs/pknFlKlaPqdpmKxieO8v2AqeZ?=
 =?iso-8859-1?Q?vU4bYWsSZD9tALnmjJyDua2agRE0Yw2uUzN6ofaoQiic3XmQg8/o3gnenf?=
 =?iso-8859-1?Q?cYrx7Q0WgP5JJrhA7z6FvUsRDS/FP01qiTaDP8FzkSlF1EEGQyqyRXxFfz?=
 =?iso-8859-1?Q?rHe91XDtLbCn3Sw8p0ynlGqI/9psWLaTeIE9gcKso3HariauhS4NCtdDe1?=
 =?iso-8859-1?Q?aQFlJIMqQJHcBwKKFemrwVEYiAohNBOR64/Fq1mrKEsjmZD1or3DYLNCXl?=
 =?iso-8859-1?Q?QLt/eU81OLliUqb0po2Gba8ZstVw6ZnkMaSSpXlyCjXaramrEsVpE25XLh?=
 =?iso-8859-1?Q?xxlsF9MEy/F2xIf/LrkUddTkRlm1wP3modQs/abaIwNd9ZvhI+rCpnNQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 275ea89a-f975-4018-ef8f-08dd82f3ca9f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 05:49:53.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfFe/q/ouH3+rG7SFHON+WZ0uus4NlKBTBtbLx8amEws2ti69fXmQkdRKTRF65TzDelKsJX0pFTSG/GT6Cf+mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6605
X-OriginatorOrg: intel.com


Hello,

back in last Oct, we reported
"[linux-next:master] [cpuidle]  38f83090f5:  fsmark.app_overhead 51.9% regression"
(https://lore.kernel.org/all/202410072214.11d18a3c-oliver.sang@intel.com/)
but there is no obvious fsmark.files_per_sec difference at that time.

now on a different platform and with different fsmark parameters, we notice
a small regression of fsmark.files_per_sec. but no obvious fsmark.app_overhead
difference this time (so does not show in below detail table).

last Oct report seems cause some confusion. so for this one, we try to rebuild
kernels and run more times to confirm the configs are same for parent/38f83090f5
and data is stable.

just FYI what we observed in our tests.


kernel test robot noticed a 5.1% regression of fsmark.files_per_sec on:


commit: 38f83090f515b4b5d59382dfada1e7457f19aa47 ("cpuidle: menu: Remove iowait influence")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      6fea5fabd3323cd27b2ab5143263f37ff29550cb]
[test failed on linux-next/master bc8aa6cdadcc00862f2b5720e5de2e17f696a081]

testcase: fsmark
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	iterations: 8
	disk: 1SSD
	nr_threads: 4
	fs: btrfs
	filesize: 9B
	test_size: 16G
	sync_method: fsyncBeforeClose
	nr_directories: 16d
	nr_files_per_directory: 256fpd
	cpufreq_governor: performance



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202504241314.fe89a536-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250424/202504241314.fe89a536-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1SSD/9B/btrfs/8/x86_64-rhel-9.4/16d/256fpd/4/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-spr-2sp4/16G/fsmark

commit: 
  v6.12-rc1
  38f83090f5 ("cpuidle: menu: Remove iowait influence")

       v6.12-rc1 38f83090f515b4b5d59382dfada 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.12 ±  4%      +0.0        0.14 ±  2%  mpstat.cpu.all.iowait%
    940771            +2.8%     967141        proc-vmstat.pgfault
    120077            -5.7%     113267        vmstat.system.cs
     72197 ±  2%     -14.2%      61965 ±  2%  vmstat.system.in
     20496            -5.1%      19456        fsmark.files_per_sec
    219.58            +5.0%     230.50        fsmark.time.elapsed_time
    219.58            +5.0%     230.50        fsmark.time.elapsed_time.max
      0.02 ±  9%     +22.5%       0.03 ± 10%  perf-sched.wait_and_delay.avg.ms.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync
     15676 ±  9%     -25.2%      11732 ± 14%  perf-sched.wait_and_delay.count.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync
    130219 ±  7%     -14.8%     110942 ±  8%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      0.02 ± 10%     +27.8%       0.02 ± 12%  perf-sched.wait_time.avg.ms.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync
 1.457e+09            -4.4%  1.393e+09        perf-stat.i.branch-instructions
  14767792            -4.6%   14093766        perf-stat.i.branch-misses
  71872875            -3.4%   69406875        perf-stat.i.cache-references
    121769            -5.8%     114744        perf-stat.i.context-switches
 8.574e+09            -7.2%   7.96e+09        perf-stat.i.cpu-cycles
 7.979e+09            -3.6%  7.691e+09        perf-stat.i.instructions
      3773            -2.0%       3697        perf-stat.i.minor-faults
      3773            -2.0%       3697        perf-stat.i.page-faults
  1.45e+09            -4.4%  1.386e+09        perf-stat.ps.branch-instructions
  14670086            -4.5%   14003599        perf-stat.ps.branch-misses
  71521482            -3.4%   69080547        perf-stat.ps.cache-references
    121170            -5.7%     114204        perf-stat.ps.context-switches
 8.537e+09            -7.2%  7.925e+09        perf-stat.ps.cpu-cycles
 7.938e+09            -3.6%  7.654e+09        perf-stat.ps.instructions
      3717            -1.9%       3645        perf-stat.ps.minor-faults
      3717            -1.9%       3645        perf-stat.ps.page-faults
      9.65 ± 14%      -9.4        0.22 ±123%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     18.61 ±  6%      -4.7       13.95 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     18.05 ±  7%      -4.5       13.51 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     18.73 ±  7%      -4.5       14.22 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     22.60 ±  4%      -4.5       18.11 ±  3%  perf-profile.calltrace.cycles-pp.common_startup_64
     21.55 ±  5%      -4.5       17.08 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     21.57 ±  5%      -4.5       17.11 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     21.58 ±  5%      -4.5       17.12 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      2.39 ±  6%      -0.6        1.78 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_clone_write_end_io.blk_mq_end_request_batch.nvme_irq.__handle_irq_event_percpu.handle_irq_event
      2.32 ±  7%      -0.6        1.72 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_orig_write_end_io.btrfs_clone_write_end_io.blk_mq_end_request_batch.nvme_irq.__handle_irq_event_percpu
      2.21 ±  7%      -0.6        1.64 ±  7%  perf-profile.calltrace.cycles-pp.end_bbio_meta_write.btrfs_orig_write_end_io.btrfs_clone_write_end_io.blk_mq_end_request_batch.nvme_irq
      0.52 ± 27%      +0.1        0.63 ±  6%  perf-profile.calltrace.cycles-pp.__blk_flush_plug.blk_finish_plug.btrfs_sync_log.btrfs_sync_file.do_fsync
      0.52 ± 27%      +0.1        0.63 ±  6%  perf-profile.calltrace.cycles-pp.blk_finish_plug.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync
      0.95 ±  6%      +0.2        1.10 ±  7%  perf-profile.calltrace.cycles-pp.__btrfs_wait_marked_extents.btrfs_wait_tree_log_extents.btrfs_sync_log.btrfs_sync_file.do_fsync
      1.04 ±  6%      +0.2        1.21 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_wait_tree_log_extents.btrfs_sync_log.btrfs_sync_file.do_fsync.__x64_sys_fsync
      0.51 ± 27%      +0.2        0.68 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.36 ± 70%      +0.3        0.62 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_free_tree_block.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_insert_empty_items
      0.36 ± 70%      +0.3        0.65 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      2.20 ±  8%      +0.6        2.77 ± 11%  perf-profile.calltrace.cycles-pp.copy_extent_buffer_full.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_insert_empty_items
      0.00            +0.8        0.76 ± 10%  perf-profile.calltrace.cycles-pp.folio_end_writeback.end_bbio_meta_write.btrfs_orig_write_end_io.blk_mq_end_request_batch.nvme_irq
      0.00            +0.8        0.85 ±  9%  perf-profile.calltrace.cycles-pp.end_bbio_meta_write.btrfs_orig_write_end_io.blk_mq_end_request_batch.nvme_irq.__handle_irq_event_percpu
      0.00            +0.9        0.89 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_orig_write_end_io.blk_mq_end_request_batch.nvme_irq.__handle_irq_event_percpu.handle_irq_event
      7.54 ±  5%      +1.1        8.69 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_force_cow_block.btrfs_cow_block.btrfs_search_slot.btrfs_insert_empty_items.copy_items
      7.56 ±  5%      +1.1        8.71 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_cow_block.btrfs_search_slot.btrfs_insert_empty_items.copy_items.copy_inode_items_to_log
      3.57 ±  5%      +1.3        4.87 ±  7%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.99 ± 13%      +2.8        4.76 ± 10%  perf-profile.calltrace.cycles-pp.handle_edge_irq.__sysvec_posted_msi_notification.sysvec_posted_msi_notification.asm_sysvec_posted_msi_notification.cpuidle_enter_state
      2.25 ± 14%      +2.9        5.16 ± 11%  perf-profile.calltrace.cycles-pp.__sysvec_posted_msi_notification.sysvec_posted_msi_notification.asm_sysvec_posted_msi_notification.cpuidle_enter_state.cpuidle_enter
      2.35 ± 14%      +3.0        5.32 ± 11%  perf-profile.calltrace.cycles-pp.sysvec_posted_msi_notification.asm_sysvec_posted_msi_notification.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      2.51 ± 15%      +3.1        5.60 ± 11%  perf-profile.calltrace.cycles-pp.asm_sysvec_posted_msi_notification.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     50.39 ±  2%      +4.4       54.84 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
     50.38 ±  2%      +4.4       54.82 ±  2%  perf-profile.calltrace.cycles-pp.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
     50.35 ±  2%      +4.4       54.80 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_sync_file.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     50.84 ±  2%      +4.5       55.30        perf-profile.calltrace.cycles-pp.fsync
     50.57 ±  2%      +4.5       55.03 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fsync
     50.57 ±  2%      +4.5       55.03 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
      9.92 ± 13%      -9.4        0.52 ± 12%  perf-profile.children.cycles-pp.poll_idle
     18.84 ±  7%      -4.6       14.26 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
     18.85 ±  7%      -4.6       14.27 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
     19.59 ±  6%      -4.5       15.04 ±  6%  perf-profile.children.cycles-pp.cpuidle_idle_call
     22.60 ±  4%      -4.5       18.11 ±  3%  perf-profile.children.cycles-pp.common_startup_64
     22.60 ±  4%      -4.5       18.11 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
     22.58 ±  4%      -4.5       18.09 ±  3%  perf-profile.children.cycles-pp.do_idle
     21.58 ±  5%      -4.5       17.12 ±  4%  perf-profile.children.cycles-pp.start_secondary
      2.46 ±  6%      -0.6        1.86 ±  7%  perf-profile.children.cycles-pp.btrfs_clone_write_end_io
      0.12 ± 13%      -0.1        0.06 ± 15%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.22 ±  8%      +0.1        0.28 ±  6%  perf-profile.children.cycles-pp.__xa_set_mark
      0.57 ±  5%      +0.1        0.64 ±  5%  perf-profile.children.cycles-pp.blk_finish_plug
      0.59 ±  5%      +0.1        0.67 ±  5%  perf-profile.children.cycles-pp.__blk_flush_plug
      0.77 ±  5%      +0.1        0.87 ±  4%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.60 ±  6%      +0.1        0.70 ±  6%  perf-profile.children.cycles-pp.pin_down_extent
      0.75 ±  6%      +0.1        0.88 ±  7%  perf-profile.children.cycles-pp.btrfs_free_tree_block
      0.96 ±  5%      +0.1        1.11 ±  7%  perf-profile.children.cycles-pp.__btrfs_wait_marked_extents
      1.11 ±  6%      +0.2        1.29 ±  6%  perf-profile.children.cycles-pp.set_extent_bit
      1.21 ±  5%      +0.2        1.38 ±  6%  perf-profile.children.cycles-pp.__set_extent_bit
      0.83 ±  5%      +0.2        1.01 ±  6%  perf-profile.children.cycles-pp.__folio_mark_dirty
      1.25 ±  6%      +0.2        1.47 ±  6%  perf-profile.children.cycles-pp.__folio_end_writeback
      2.28 ±  4%      +0.3        2.56 ±  4%  perf-profile.children.cycles-pp.__write_extent_buffer
      3.81 ±  5%      +0.5        4.34 ±  6%  perf-profile.children.cycles-pp.btrfs_alloc_tree_block
      3.73 ±  6%      +0.7        4.42 ±  8%  perf-profile.children.cycles-pp.copy_extent_buffer_full
      5.21 ±  4%      +0.8        5.97 ±  6%  perf-profile.children.cycles-pp.__memcpy
      3.62 ±  4%      +1.3        4.92 ±  7%  perf-profile.children.cycles-pp.intel_idle
     10.48 ±  4%      +1.5       11.94 ±  4%  perf-profile.children.cycles-pp.btrfs_force_cow_block
     10.51 ±  4%      +1.5       11.97 ±  4%  perf-profile.children.cycles-pp.btrfs_cow_block
     50.40 ±  2%      +4.4       54.84 ±  2%  perf-profile.children.cycles-pp.__x64_sys_fsync
     50.38 ±  2%      +4.4       54.83 ±  2%  perf-profile.children.cycles-pp.do_fsync
     50.36 ±  2%      +4.4       54.81 ±  2%  perf-profile.children.cycles-pp.btrfs_sync_file
     50.86 ±  2%      +4.5       55.32        perf-profile.children.cycles-pp.fsync
     69.02 ±  2%      +4.6       73.66        perf-profile.children.cycles-pp.do_syscall_64
     69.05 ±  2%      +4.6       73.69        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      6.48 ± 13%      -6.0        0.48 ± 12%  perf-profile.self.cycles-pp.poll_idle
      0.32 ±  8%      +0.1        0.39 ± 11%  perf-profile.self.cycles-pp.folio_mark_accessed
      5.10 ±  4%      +0.7        5.84 ±  6%  perf-profile.self.cycles-pp.__memcpy
      3.62 ±  4%      +1.3        4.92 ±  7%  perf-profile.self.cycles-pp.intel_idle



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


