Return-Path: <linux-pm+bounces-10307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F1891ECF3
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 04:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DE12834AC
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 02:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E1812E63;
	Tue,  2 Jul 2024 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8DNuQAu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5600AD51C;
	Tue,  2 Jul 2024 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719887133; cv=fail; b=puOaqa1KgsilRuoOTxA8cQQsLfigwH71ielW/Z5RmSjMfjLujMh6z/vWueD50JPLAQo4+xIQhv3jxaYZKK9osMKIjAD0JDa0fLL30AUtODsGLqCCL6Oyqyxc+UEwtDCyLQIQoGDtCCdo24hKGeZNIoVgsBuz4dFL10GT6p2NOLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719887133; c=relaxed/simple;
	bh=OW0tjW5cPeuW9Ml+t+c6BrwX9RtGpmXH2/kjRGnxsxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GwnXWzo8im8Nz7DsI4YUL7D+8wM4lyZ6Qx6lbj9qxgq/hvDo4I7edE9QLRPvho4XUfFxpessD85UVYYkRb6WGLcAu26sZszUQZwjPfoEzi+lhcCyt+fYH8pxHEkv6KMQ/bYbhpRasW71wSFemd6z5X7F1mGT56ToJBf/uPXrbzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8DNuQAu; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719887131; x=1751423131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OW0tjW5cPeuW9Ml+t+c6BrwX9RtGpmXH2/kjRGnxsxM=;
  b=j8DNuQAuNzJjwW9nTLFWxjtELz1BcKX3qcM0exwIm9noMdA0OzTBHewy
   5BoxTvHUin6ExwbZIxvFOZ5uuDxjWjpGjt2P9bYx9aZZFWNyfm5Vornjh
   uvnuW8/lVssnSjcLdxiX780Fqo5664ytj0Xxoo/+LB6omUxTuhKQhowNn
   79eOFHUcQTES4w2Sms8PMRgLa04JxIhw5KM7BhySjEYgamfN298Dj/fIF
   4hUo9Ijoggm6TK0ZY4+Y7NmGARIdxSRLEJX4qYMU7t5uiQz5zpezbJAXL
   4+LGheisNerYx/a8Jisnm/Y+mTNjFZ7XfJQrxbMmyAeQex4FzFaOuzfYS
   A==;
X-CSE-ConnectionGUID: MdVPXUauToC0D1HR/FcBHA==
X-CSE-MsgGUID: 5tJddXw7SAC1kVSeDz45Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16882409"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="16882409"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 19:25:30 -0700
X-CSE-ConnectionGUID: VssZul/sTgqEJU0zPIz0DA==
X-CSE-MsgGUID: U22SbOfJQmKe79ZHnHzpgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="45733207"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 19:25:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 19:25:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 19:25:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 19:25:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMVyKXa9/ouXSFNSIcejoF7ylUGXSbM27+HYbG1MgWMFkUWBkdGCFLuBPmyYy6aWkwClQeL1qkbZE7CLCm/mKkd93VBG8YIODII8r0rVvZCgY8XtTMDZgz1Br7dGrBJvUD9mRpHFjKoS57BTEf9YZbQiGO9UhR7IE3fIZ0iLqAD8kuLrvQmVfhEBUvlPpnrHXZE7SOBl0XP63nQf+IlLxUKxHFg899ONcZmCH8RQAISXYvFzd9kFwI43Mro0jxJi8662siafp10YgOfqGcffX592aOGqB+w4sT168h++Qs2+DbUmmeiaNyf0fVX0v1pGLo2KcfRgjAefbd81Cq41Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OW0tjW5cPeuW9Ml+t+c6BrwX9RtGpmXH2/kjRGnxsxM=;
 b=KS7sz2aL+1jlworsOh5UneUfydzITB9VyQMBqQRjEONbRoIEwJ7TM/5ZnyIien59cxDmGmMxON9yK8W2mIOsI2m62qCA1/jhRstMorDF8dCmE4h911srWHTD+OIIGTx0qsqWipkaeG9W5q+QL4sdYDBtTDCFlvwNi5s0jjNmqeKgCyJ5YLd0rLPS1q6KqHDVexVlzmiF9uUfpzneWMzhFCr0cL5h9tMD1ZG8NJ3Z8jrwlqhCXJBgquVH0J3OUv97IT8qtLrYRQXK4neiRcSgLt3POJT7Z9+GOKKVvRjPDLfxxHCzWvjZS/uDwyyK2uGh/u9U8OUQnFAvYdpEDhLt3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SA2PR11MB5020.namprd11.prod.outlook.com (2603:10b6:806:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 02:25:27 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%7]) with mapi id 15.20.7698.033; Tue, 2 Jul 2024
 02:25:27 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "Dhananjay.Ugwekar@amd.com"
	<Dhananjay.Ugwekar@amd.com>
CC: "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"ananth.narayan@amd.com" <ananth.narayan@amd.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "oleksandr@natalenko.name"
	<oleksandr@natalenko.name>, "irogers@google.com" <irogers@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "gustavoars@kernel.org"
	<gustavoars@kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "kees@kernel.org" <kees@kernel.org>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"acme@kernel.org" <acme@kernel.org>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v3 08/10] perf/x86/rapl: Modify the generic variable names
 to *_pkg*
Thread-Topic: [PATCH v3 08/10] perf/x86/rapl: Modify the generic variable
 names to *_pkg*
Thread-Index: AQHaxfwxVnnLKeOUFEevngJ7z5gzNbHh46KAgADemAA=
Date: Tue, 2 Jul 2024 02:25:27 +0000
Message-ID: <477c33a2949793d2a8692c925179bc4f1feb7942.camel@intel.com>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
	 <20240624055907.7720-9-Dhananjay.Ugwekar@amd.com>
	 <20240701130845.GI20127@noisy.programming.kicks-ass.net>
In-Reply-To: <20240701130845.GI20127@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SA2PR11MB5020:EE_
x-ms-office365-filtering-correlation-id: 9e1d4509-bf71-4ab5-cb8e-08dc9a3e3cbc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eGJFemJHRVM0cXhFSGI5T2t3UEltNzFqSlY2QjFiazE5VFhEaThKYlY0NGlq?=
 =?utf-8?B?RnU5VkI0WVE3elYvUE1Pc3BqZTFCUzVGUWZZLzAzcjJjanQ2eUFVRTdhL1cr?=
 =?utf-8?B?NEdCZk1oWjJ4UjkwdG9iNzFqbFdPVER4QlFNVVVQaEN2azUzTGNQNjE3TFlq?=
 =?utf-8?B?V2FGdjZWSXM2WU1QZU56UmFId2NnUDN1cmQ2MFRhVHA0WnF0c3gwcGRDbVIy?=
 =?utf-8?B?Wk1JcWpPQi9sRThGR3pScG02bmtmbEhmSVJ1QVVaTUwweGx6Z3MrbkoxbklI?=
 =?utf-8?B?elM5MG9Ca0R1QVFYRmpNeEtCT1RwcllkcEJybktqZG15M3pGNXdZWVdXdlBt?=
 =?utf-8?B?MjlEV1VoMnNLby9nNDFhTWliditQMkdqU2hBbDMwLzlGa0FSUktkMVMrU2Zl?=
 =?utf-8?B?ZTdlVC9XblJkVFM3R0JCYTRWc1hBbXhrbFZDOXA5bWdVUlhoay9XV0tTREMw?=
 =?utf-8?B?N3VpWGJDbm54VmJXWTIxeThUaHZVdGxIY3J6QkZOK0Y2SHFmZitobXQ5Y0FC?=
 =?utf-8?B?aHAwanBERk1GcHlBcllISHF6WlpJc3JLTjVmSVJ2c01KTEowcm9nNVJkaSth?=
 =?utf-8?B?Uk5YaVN1L2FNaVc2WnJOVk80TzhPeTFXbkUxUTNCdEhTZUtENXM2QlVOWG5V?=
 =?utf-8?B?b1pTNFBJVVYyWFpBYUZyMVhxR1BTSlVNZmlOVTBoSVdsbTN3b2hPYXVRUm1s?=
 =?utf-8?B?b3JUeDhHemNYb1NyeWRBRWsvLzNTRjN5UEZyd1ZWOUZQU0RGaExHSGE0MmJl?=
 =?utf-8?B?ZkpXYjJWc3kyTUYzWmJEeUY2dFY2WDBIZ2xSWE8vU0hMWkNranJYN2VQcUdi?=
 =?utf-8?B?a3cwR2E0eGFVc1pzRVhocUZNYWZDY3JvYWxseHArYmtkajU2a25SWnRreVlj?=
 =?utf-8?B?MnkvQko1NjZzTmJ2RXFqWUNJeFF6OTMzZHJpcEl1VlVQdnp5WWtkcXQ3RGdY?=
 =?utf-8?B?d3BUL0tGckNkVnZMUnFoR2I1L0xqaXUyOXpIUnNRSlpWRXBkcmNybTlRZ2wr?=
 =?utf-8?B?ZWZwQnZiOFk5ZTdjZC8wNUdaeWhZZWtsRDlYMFgzeDBpZHpETGplazBjMWxo?=
 =?utf-8?B?c0ZBZWN6YlI5QW9MWk1WZ0N2REVtVW5NZm9MZEpQSFo1NXpLNm9iN0xObE5a?=
 =?utf-8?B?L3c4OEdEWksxZFRHWFZ5THJWdGJwUHJUUVprVkZJcURHeitYRm90YnJndEVz?=
 =?utf-8?B?R09OWm4wdkhESkZIcVgxRU5YNm44SU11Rk1LY1JIanJma1pxZEkvYUJKeUJv?=
 =?utf-8?B?L05ZSEJucGhwZi83ekgzZno3MC9wcWQrV2xGTzN0dWY4bjNXUW9QbTg0SmEx?=
 =?utf-8?B?a3VFeExodVJlK084VnYxdjNpUTMxNi9CZ1NhRmhDNnVkc2xFbXBWZ3F1N1Jw?=
 =?utf-8?B?Qk40U2VNc1U0ZE5VRkF2WVJlb1puT0N5TERHdFZCMlphWUo1WVdRbGxnaysy?=
 =?utf-8?B?RlplRlhnZnNrdmNseVRoNFVqL3Bkazc2QVBCUkcrV3dsSDhTSXBMVUR0N0FS?=
 =?utf-8?B?ZHRMS2NoM2hzY2FJS0NTV0lYbENndnRab0FqSjFBaTUrK2tnOWJKUWEvRFoy?=
 =?utf-8?B?emliVGx0aTFvck5VWVRuVnNDV2pSRm5NSWhFY0ZMYWhQbmpNNjVPUzJoRXgr?=
 =?utf-8?B?U0hTV1ZSSmJMdkZZZXhBc0t6b1VBVC9mNTBJaWkrNEQ4MHpJak5aclpnNjRr?=
 =?utf-8?B?ZHBwY3Q5MCt6dWMzR0dydVBXK25hRUdPZGJsRnAzZ2NJU0dIQkpialV5d0RI?=
 =?utf-8?B?VmFvWUl1OGVvaWlsYjJaQWxZSk5oakhqZzVqbDVQUkh0OElub2RoTzQ2WXJt?=
 =?utf-8?B?d3BEWE0zZ0w3bnN3MWhqTE9DcVlTZnlSQXBPRkxNNlNnT2xwTHVaVlE5SFJB?=
 =?utf-8?B?M1l3SmFrdnBKR1NKUkNYQ2NQTHIwZnIxMjRKbjlYbWp2T3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmJqQUhOUllnZXJ2LzdDeVZiRDZFN29hTUxwQXJiL0NidGFyS3pkT1oyUEZN?=
 =?utf-8?B?WFUxTWVzL1RicEdVWU93ZC9pRVZVZ3lQODVobis4MDllRnMzVURqbkVyV0NO?=
 =?utf-8?B?ZnhDLytCaDc3SkFTWi9ZY2xJVHJmdDlualNSRlNnNk1iNTdsV0FLV2RJTWg4?=
 =?utf-8?B?RmhreVJHb0d1V1h1TW8xK0JkZllKOCt6UkRnMWZkdVpRajhrM3VjVGhXaHp3?=
 =?utf-8?B?WGRTUVdEZ0Ftb2tiQ0ZqVmxiazlDRDV3ajVKRDJhdzEwVHR4WFEwclZ3bkJu?=
 =?utf-8?B?Nld0Nm11QWpHYUtGVThCWXU3TFB4V0lQMXdNR1UzOVQ1OXZ0RnlMMzYzSFFG?=
 =?utf-8?B?RGY2UzMyTnY5SytKTVdTOUU4NFZXNTFKRnFUZ1RmUEhGQ3lhT2w2Ri9NRm96?=
 =?utf-8?B?VEVIaFdRdU5CbzVKQW9vdnVCV0NCbG1WYzQ0bjFtYjZMZFVSNGszd05tTk1I?=
 =?utf-8?B?MkNNNi9tVkh6OGN4anlHcHJDc3VkYXd6UmJhcWlRMVg4RXBtNzI2N1pPRWlv?=
 =?utf-8?B?Um1CNzE4UXY1UVB1ZU1HK1p5LzRUekRUZ21iODhEQTVzZElncVpUT2VIVkJ5?=
 =?utf-8?B?SEtwU0orTVBlb09MckhaMmdEZnNEdTQ1UjMxYTNpMjJPam1CVkpYVThXT1Rr?=
 =?utf-8?B?Y3g3K21GV01YbUpsSlpvZjQxKzJMRXlkRTRlejVqdFIxak03a296V0RJYzhl?=
 =?utf-8?B?bHRyZEVMWlpqYUNNK3UwbE95aHE2ZHNyWlNMU3d0bmxaSENNS09GUzdEazg5?=
 =?utf-8?B?ZnVjUVYyUkF3a21zZ1N3UTJwWTNBSTVvbVA1M2ZTWjM5YXowY0ZBdk5mZEFG?=
 =?utf-8?B?cTFVVE5aZ3hGbWQxVDhvdVVyQ0RZN2ZEdFNwdVRzWW5leHFldGkzMVFzZVFt?=
 =?utf-8?B?SEpiWCt6dlhPSmdKRGN0Y05KSk4xQlNXcUtLeC8va3Ztbkw5VU5ZYlBYazgw?=
 =?utf-8?B?QkFwbmZmdUVXSGw0WXplV1o0WVZxKzVLMm0xNkZSMnRyTnQ3MmdGZjNWcnA5?=
 =?utf-8?B?MTVOOUMyMGU3WkxDQUpmVDQ2NWlMN2ZQTk9YbjBqa0Q5QzhESS96aEFhczMz?=
 =?utf-8?B?Q0YxQ2lFeWpQbzFuNEhycW9wMlpnblZOa29qeUtOMDkzdmFoTzRibE5YNitm?=
 =?utf-8?B?czVtUzdCWFVFUkFvVlFOcVdmK2V2bGNxZFNFR2dmQlZJeDN1UVlPdHpydlAv?=
 =?utf-8?B?SkVidGdsQUlwREVPdDlKcXNXT2lIcjZwY1BKZXNXeW5qdE9RUExnQldudDBC?=
 =?utf-8?B?eXJmb3lDOWh1eW12aytFWXRQanVFOWZVOFh4WlR2ZWZPdjArdlo0WWdtTGZu?=
 =?utf-8?B?c2dpZ0V5UFRmRjlyL2lTUDlYUy9OZ3dqOURscGFKdnJSM1M5STYvdUhrRnRI?=
 =?utf-8?B?OG5IeGRlTXQxbHpkMVJVZk1hdE45SzE0QXp3UVdQTFk4L1cvdVZ4cG9OaXdm?=
 =?utf-8?B?YWxxelhaZTM1K0pMWjFId2wrbWRJZzJLd2xZNVVVZ2sxWnNweElUYWFIUHlV?=
 =?utf-8?B?N2tWYkd2am9qQ2RIZE9xaGRHdmtscGxGSkRtVGJLU3NZQ1hRcmI1dUJzVUpE?=
 =?utf-8?B?dWVSWmRCZUpiSmRaY0tsUjZTSmtMaktMZGRDQW9sVHNDLzBPdkh1eU1HQXZq?=
 =?utf-8?B?KzdJa2FhL2wyMDdGTU5tMUsyL2Yvd1VwcktIYThNcXRGNGNoSk1sZWN4ZWhw?=
 =?utf-8?B?L3MrZjJDWTNKalZ4dkZoRFRGRzBNMEVXNitJL2N3SmVSUTh2VEdBakpWN0VX?=
 =?utf-8?B?QVRnUUI5aWRIRFpJVWYzamZZYnEwNG5RaXg0d1BIWWNRTXNCZXNqeHRMZ2U0?=
 =?utf-8?B?THR3OHRadUdMMVFPTEJESnNiRzZNeEJNZk9ZM3g3Qzc5Qk1GOC95MEx4SWJS?=
 =?utf-8?B?Tjd0UzlORXlXNk45d3dmSUJoQ2dPTys1WlI3emRHS3BXSVJkZG9RQ1UySGRq?=
 =?utf-8?B?Z2ovZm0wMkQ0TGZnVTF0aW5Jbi9JMUhGSXZYc1VpVUlqNW1ZYllONzNyRW9m?=
 =?utf-8?B?ODY1ZXNQN1ljVjhWVHYwZWFBQlZFODdrUk03NGFhK2RPS2VyYUROSXdLS1U4?=
 =?utf-8?B?NkFkOXNrNWZ6b1BmdzFrTHY0KzRJR1A3WkxIMU5jUEpvTkFuR2JxVXg4dGVz?=
 =?utf-8?Q?JJUZJaAkDJPPZnnfyJYy3j9cA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10BF234E2232104F90DBE0FD5F078A5F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1d4509-bf71-4ab5-cb8e-08dc9a3e3cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 02:25:27.7313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUrR8a/Un8glQh+ko2IcTclec21bzdIMFx5M0ke0e8s/asTVrq3TYlEkwK6qLJg6Ko0wcLyWZdDxJVZOsiuvJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5020
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA3LTAxIGF0IDE1OjA4ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gTW9uLCBKdW4gMjQsIDIwMjQgYXQgMDU6NTk6MDVBTSArMDAwMCwgRGhhbmFuamF5IFVn
d2VrYXIgd3JvdGU6DQo+ID4gUHJlcCBmb3IgYWRkaXRpb24gb2YgcG93ZXJfcGVyX2NvcmUgUE1V
IHRvIGhhbmRsZSBjb3JlIHNjb3BlIGVuZXJneQ0KPiA+IGNvbnN1bXB0aW9uIGZvciBBTUQgQ1BV
cy4NCj4gPiANCj4gPiBSZXBsYWNlIHRoZSBnZW5lcmljIG5hbWVzIHdpdGggKl9wa2cqLCB0byBk
aWZmZXJlbnRpYXRlIGJldHdlZW4gdGhlDQo+ID4gc2NvcGVzIG9mIHRoZSB0d28gZGlmZmVyZW50
IFBNVXMgYW5kIHRoZWlyIHZhcmlhYmxlcy4NCj4gDQo+IEJ1dCB0aGVuIHJlbWVtYmVyIHBhdGNo
IDIgYW5kIHJlY2FsbCB0aGF0IGludGVsIHNlZW1zIHRvIGhhdmUNCj4gZXZlcnl0aGluZw0KPiBh
dCBkaWUgbGV2ZWwsIG5vdCBwa2cuDQo+IA0KPiBEb2VzIHRoaXMgcHJvcG9zZWQgbmFtaW5nIG1h
a2Ugc2Vuc2U/IEhvdz8NCg0KRm9yIEludGVsIHByb2R1Y3RzLCB3ZSBoYXZlDQoxLiBDYXNlY2Fk
ZWxha2UtQVAgd2hpY2ggaGFzIG11bHRpLWRpZSBwZXIgcGFja2FnZSBhbmQgaGFzIHBlci1kaWUg
UkFQTA0KTVNScw0KMi4gYWxsIG90aGVyIHBsYXRmb3JtcyB3aGljaCBoYXMgc2luZ2xlLWRpZSBw
ZXIgcGFja2FnZSwgc28gaXRzIFJBUEwNCk1TUnMgY2FuIGJlIGNvbnNpZGVyZWQgYXMgZWl0aGVy
IHBhY2thZ2Utc2NvcGUgb3IgZGllLXNjb3BlDQpUaGlzIGFwcGxpZXMgdG8gVGhlcm1hbCBNU1Jz
IGFzIHdlbGwuDQoNCnNvIGZvciB0aGVzZSBNU1JzLCB3ZSBjYW4gdHJlYXQgdGhlbSBhcw0KMS4g
YWx3YXlzIGRpZS1zY29wZSBmb3IgYWxsIGV4aXN0aW5nIHBsYXRmb3Jtcw0Kb3INCjIuIHBhY2th
Z2Utc2NvcGUgd2l0aCB0aGUgZXhjZXB0aW9uIG9mIENhc2VjYWRlbGFrZS1hcA0KQW5kIGN1cnJl
bnQga2VybmVsIGNvZGUgZm9sbG93cyBydWxlIDEuDQoNCkkgcHJvcG9zZSB3ZSBzd2l0Y2ggdG8g
cnVsZSAyIGZvciB0aGVzZSBjb2RlIGJlY2F1c2UgcnVsZSAxIGNhbiBiZQ0KYnJva2Ugb24gZnV0
dXJlIG11bHRpLWRpZSBzeXN0ZW1zIChUaGlzIGlzIGFscmVhZHkgdHJ1ZSBmb3IgVGhlcm1hbA0K
TVNScykuDQoNCkluIHRoaXMgc2Vuc2UsIEkgdGhpbmsgaXQgaXMgb2theSB0byBjYWxsIGl0IHBr
ZyBsZXZlbCByYXBsIGZvciBib3RoDQpJbnRlbCBhbmQgQU1ELg0KDQp0aGFua3MsDQpydWkNCg0K

