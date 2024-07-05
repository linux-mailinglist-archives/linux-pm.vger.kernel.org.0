Return-Path: <linux-pm+bounces-10643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 897DB92804D
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 04:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA46B23F79
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 02:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23914AB2;
	Fri,  5 Jul 2024 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuILgAyN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008F17571;
	Fri,  5 Jul 2024 02:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720145920; cv=fail; b=CF4jsRMcG2QW103B8l7Kj4PXwyJcLBQJ2dS5wpP3oX+y1UPckIewKoRlbkPGzjW3bFdI3tTsfys42SsGcNNSMA28PjY9khbtNDqTc5cnhKEw2CwDZ28SeQyjIo2arl5jvhn+6+dwV88eExD0XKMnzUxfTpBi4aVAhhk50ncn2Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720145920; c=relaxed/simple;
	bh=6RPi7ZSY9FLbsu8x9XNwPBOzkZg/BwIkhEggQS4hYqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m1kkFWXv8IwFAtzssO8NtWynsIARzlY5BjjDHFVvESJFnQvD6BSjFv4eArIEHJpUjiYFkh2w2Pn2EJBZWLef27w+6tauYq4rsM3yjrP/fOXJKdzVqXJTNdsKIR5uVFBvrFXjXIVTkoCeP3giFpEg5VeanEYKfbH/y7IQNsFx6gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuILgAyN; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720145916; x=1751681916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6RPi7ZSY9FLbsu8x9XNwPBOzkZg/BwIkhEggQS4hYqg=;
  b=AuILgAyN+Xs+bq/23Cq+uOtBwMuTl0NV+gbM/KerXHyOzlbzZDJI1HGf
   MeUflhAMmzo9ja7awONXe/eKDHZEVC3lJwDSnW+1jMeFlKZiXdp1QKtb0
   Kve2KyGJVIZPcYvABmMspTQu2ysl/gKnxcsVq+/Lf74uVeEM6RlDk91Y7
   By6SmbhXXXgy6eeKvk3Qpla2a3jsOX8//BKI/bX4Lek+X0GkKFa/vokXr
   zQd5EqAFFQihIvFQytRm/AOLRIXH+SoGlpayn8D8j70AhqXo3V2tH2s6L
   T8USd0HZeSClCtsdDTqz7IBjBTpM0eT/6bZ8DOb4ECLFlRnXBQDFML8QQ
   A==;
X-CSE-ConnectionGUID: YHBgk6v4TbeLvatBcycUzw==
X-CSE-MsgGUID: 6a4YA6fsR5CPWpFae7686A==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="42852850"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="42852850"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 19:18:35 -0700
X-CSE-ConnectionGUID: kWhSSw+lTuiyDb4SELCQTQ==
X-CSE-MsgGUID: aNsr1Ue0RyaDl0H4kaucUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51923517"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 19:18:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 19:18:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 19:18:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 19:18:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMMlUPqK1EkW2rKbPYR5sHNxBjgW7fVXA86S2GUYE2wYkw3cCv7x03A92edPeffkakJ/INoODwTj3cXosTf0LMDYHrRKHMuC1nS6hYj2oxmfj6qGcZY1Ofz0p1yZMzlHXu/NpALF7DmJS5XVDU4q+Lq0KCVNZu+vvkGFgtjuycxE0es6vntg6MyJtxtg218kR+jgrUkNqEWEwRv1uqdrWbjKfERcCBht3xO8kYmaexAHj7UCO7T3QHHyewGV5Skj6AXi9YjYgyo3iC2/T3oP+kTwz9SYlOTmgBfx4vRRnIh45V9JZkG3hi7ys9nH3JjF6LdTkVJ+2mGbGodYzq71mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RPi7ZSY9FLbsu8x9XNwPBOzkZg/BwIkhEggQS4hYqg=;
 b=QzgG96pdeGVtIqvBtdwGfyO885UFcMN/gsopDm81bKVzuTQgLSuhP1oSftYKcOE+z9/5mQ71xZlxjVYFq1vXr5tUVFGaoFXi4Lqkvd43H6UpP0ZxxXc1fwDQ5HbMIpZqzYHBt2U+porOOJIiLMBnlv50NZ/jkXSiZdM6Bs9poNGW3eLHIvL7ifMt6zICfZhW9mHCNaLXJHePctaC92raEadJjCOC013CvAPfc53/jlp66X2ZI3BYcgGI7sn53sXGoKeetsx02aedxc5f+TDhViQVp+rr1c/2kIzj0lYPt+6ZDmSvaA4+cpUTCnmEjQmRyvDgX/SIb6LhKO6EYFFswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS7PR11MB6104.namprd11.prod.outlook.com (2603:10b6:8:9f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.23; Fri, 5 Jul 2024 02:18:30 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%7]) with mapi id 15.20.7698.033; Fri, 5 Jul 2024
 02:18:30 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "Dhananjay.Ugwekar@amd.com"
	<Dhananjay.Ugwekar@amd.com>
CC: "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"ananth.narayan@amd.com" <ananth.narayan@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>, "irogers@google.com"
	<irogers@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>, "kan.liang@linux.intel.com"
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
Thread-Index: AQHaxfwxVnnLKeOUFEevngJ7z5gzNbHh46KAgADemACAAIS7AIABI+wAgAAuVgCAAt4OgA==
Date: Fri, 5 Jul 2024 02:18:30 +0000
Message-ID: <bf76302d2d427522d4842cb1df8f58700cb669d4.camel@intel.com>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
	 <20240624055907.7720-9-Dhananjay.Ugwekar@amd.com>
	 <20240701130845.GI20127@noisy.programming.kicks-ass.net>
	 <477c33a2949793d2a8692c925179bc4f1feb7942.camel@intel.com>
	 <35ab02da-861a-4271-986f-f4271637f5fc@amd.com>
	 <738e2dcc26926ce948bc7647cf17d83ed5d637b7.camel@intel.com>
	 <9f99286e-b840-4c50-8ff4-a25f2d2fdc67@amd.com>
In-Reply-To: <9f99286e-b840-4c50-8ff4-a25f2d2fdc67@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS7PR11MB6104:EE_
x-ms-office365-filtering-correlation-id: 858993f8-19bd-42d7-de31-08dc9c98c33c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a3M4L1plMnBmU1FHM0NUTUU2WkpQWHNWNTRjSU1sMzBrVHRzN3NSRGJvTWJI?=
 =?utf-8?B?T2gxaWtoZ3A2NWUyVGFJSEwzOXhQVURLQUJyN3hkWUFBYmFGWTBNcFJxcHJ5?=
 =?utf-8?B?VEt2UnFsQk9GLzBtRkN2Sk5oczNYc3VOZDMyVkNuSy82dkhxTDdnb2xxdG5r?=
 =?utf-8?B?RUZpWFg1SStoYm10ckl1MW9GUHhQbmZqdW53aFN2WFRKc0Z5ZUdwTHVGN2Vp?=
 =?utf-8?B?QUV3LzdWTHpybHRHaVBKa1NMRUNWdjZuSkRDWXY1ek02MVZweERYRXNXMm9x?=
 =?utf-8?B?a3hjRUhnRkJvK1hremlmbllXYlNPZnFhRjJzaGY0Z0hsNHI0WmJhQWdDMVgw?=
 =?utf-8?B?dmxBRTh5NlFBMjFBU2J6UTRPc2NXVHpFRERLMkxmQkg0blRCSmhYWks2cjRl?=
 =?utf-8?B?cE5nZmxRQ0kxRzhhcDJmQWExUDE4M2U2d0tsdVV6b3g4MXNDQzl6a08wYm0v?=
 =?utf-8?B?cUNuRzBGRjRvMjdXamd1U2l0NnY0bzlQKzlrWW9zMTNZQjU4c1d0VjZyWUtZ?=
 =?utf-8?B?YjhRODVqVXRZVjdIeDJxcVl6RVZqK2NsVWw4cDhLUjdLM1lLWU1KM2VoM0FS?=
 =?utf-8?B?UGk3TkZUWVJ1R0dxN3hqcy9EMVRwWUlCQlY2U3ptbkliMUEyQlgwV1hjWkow?=
 =?utf-8?B?KzJMS0s4OWc3NDNaSmxLd21aODFrbk9HVC9IUnJvSndQa0lrYmc4ZkQ5bUNt?=
 =?utf-8?B?amxRSHlXdzlYeTlydlBNaklSV1hFRjVtMlpZR2x1bEl3RVVsWmFyaWF0ZnVX?=
 =?utf-8?B?N21mRlF4R1ZhTmlacUVaMFF6aUZ4Z0dnNC9xaG1CMWN4NVBjUmpDZ29MdWsy?=
 =?utf-8?B?VGpBQ1FSNWtlRlhnOEtCa2plTmVNMUQ5T0pGQXVFV25qV0x3S1pBVGNYa2Nt?=
 =?utf-8?B?UktTR2s2Zm1LbHF1dVZpQUZyL1g1a2RheHJXZnEwTEYwMmpsSlA4cFJ4Um54?=
 =?utf-8?B?VmhSU3FHM2FySndlb1QvSDJpdGlkbDRCTFY2MEl2VWRvaFRVenNSNGRnMno0?=
 =?utf-8?B?NFFDb2g2MEtQYXFNcHNRaDl0RVlrSkFNeUdMc0ZFTDNBTlpldk5YL0tnSit2?=
 =?utf-8?B?MmZBWlBBaHB5SWZUclM2Tk41L0hLUWtrK3FZV2F3L2xKeW9KdTliYzd2cXBl?=
 =?utf-8?B?R29UcHIxKzUrKzBqZUE3dkNNMUQyRDViTnB5bDZuZjlTMTM4allCQmtsZlI2?=
 =?utf-8?B?TVdZMnZNanNwN21vbDlNQjF4ZWhDWTQxNkxyaGt3R1RQN1hjeERQRk1kOVZI?=
 =?utf-8?B?T2Y5NjI2bUFjRVBodit2Wk4wWTN5dDNrbnc2dzJmMi9kMWIvNFZBdTg4K3ll?=
 =?utf-8?B?Wm90VklHZkl6cGRFaVkrcjU3ZlVxTWUwZTQzL0xmYWdmQlFCeGRaYmdKSmp4?=
 =?utf-8?B?NC93bUoyNGtJUFh1NnhQcWwxL0R4eGdUMTJxdHpkeFhoQkFYdFg5RGZtcVZH?=
 =?utf-8?B?TkhyTFgvdmNHbHUzWEtoSUZWdHBIazdSVms5MmhjM1hjamZ0RFJOWHdvdmsw?=
 =?utf-8?B?enFUR04zNDBnemZ2OXllcTRoMHQxd1lnS05hUFk2dDdUNzFPOGkyZndUN2Jv?=
 =?utf-8?B?allsVTNqSU5EdHZGWWJCejRTVG5sUFhWQjVBS1kvaDRwZUJJa2lWd1piVnBq?=
 =?utf-8?B?SEpzT3VrQThPWGFMdFJYU1lGaEtjc1VGQ1lMWUd5WGtiUGU0QjFPSnozdFFX?=
 =?utf-8?B?VVRTUCtxZ2dkVHBMOUJJZ0gxN3pQZmpNckV2THBLUEN5OC9mQ0lvTVZQamFH?=
 =?utf-8?B?dytLZ1Y0NHpaWWIvenJldHlrZm05N096OCt4SWdzRC82UmM5Ym1EZWYyRUN4?=
 =?utf-8?B?R1NJdS9VYnQ4eWR1eFBEMGRxZEl2VmFpY1JwSEFud0hyQnRzM2hvZUE3YnQ0?=
 =?utf-8?B?U1ltc3ZLQnpUejhRNjFZcS9ZTi81VVhURmk2Q2dpdFJFNmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ri9wMy8wZlFKZDVyVDBra1F4OHoySVFjWDB4dzhFaFBBQmYrWGlSaUxSQTNU?=
 =?utf-8?B?akwrVVpBUWtyTDRBVUVlVjNUQ1IrTDlKQWFsaVc0OVB5THhrR1IxN1VUUVkv?=
 =?utf-8?B?WENVOVgxbHJlMDFtenFXYmdEM2ZPTDlLbGx5Y0lpMlF2R3k2NmFDbzFKN05V?=
 =?utf-8?B?UUlTWmpaaHRKck96MThHaWtRU1QrU2FmQ1lQSzdrNDk5a1RuaXRvTFIycE5R?=
 =?utf-8?B?ZGxCMjRaZk5ITFBpcXlZUHpHeWFWK21jVlN5cE0vL1kvSmpQSGdZNVJZdWdQ?=
 =?utf-8?B?cG1WSHEzM0RkYkRXTFIrQWJUQ2V2TWUveU51SG9oY2lIQjBSdnJQZlBOWHJ5?=
 =?utf-8?B?VllzaFRwZithb0FzK3MwVWJ6ZjRvbXRiTWZ4bkZCTWFGOE11ai9OYnQ0aEho?=
 =?utf-8?B?SzNWMmtqb21hODhocmpYOXBROVFyajJEQUFyMmtaYmloMGdrKy9zd0RjODR6?=
 =?utf-8?B?RGRlNjFMNE82TXhpOXdEa1NJejhxTmhhR1UrbUdCQUlURm1sNjZLUjBuZGx3?=
 =?utf-8?B?bkNZUlNiWHlRdklNRkVrSEFLRlNpZHVXNG00V3VUL09xYTdGSW5WQ0VUWHFO?=
 =?utf-8?B?N3NRSEJLWTZqV0lOOVF5eENsZ0xpdnk4NExGV0twaFNKSlZaUCtBR2k3cTla?=
 =?utf-8?B?aHJ1WG9lcnU5SHBRVFpHZTE3MVBZdFJRMDBQVWVOMG1qMXNCdjNQZ1JodWRj?=
 =?utf-8?B?eU50bGRsRUt0cWxDVktaVWl5TEhJazNOdE5wU1dmK0EySis4Wld6US92Q3Br?=
 =?utf-8?B?MEVxS2RZVkhMT29XOXNSa2RqR1ZPaFh6cXNpWUFnRUM0U0UvVmFVcVdYQTlo?=
 =?utf-8?B?bjVDVU1WVUp6aUV2NFZQR1UyYVBKZ2x4TW0zUGwvaitkYUhrY0hEZXQxZWht?=
 =?utf-8?B?YU56d21xK2VMcXBxOGZOdzFvZnVoWktyN2Y3VXF3bEkwa3Z0NzJ4VXUxVGlR?=
 =?utf-8?B?TjAvd2NkM1N1bGJFK2R6MnQ1MS9VRC9xcEJLZEdVdUtzWDd1eHpnbFE1N0xs?=
 =?utf-8?B?ZC9JUTY4WE5xM21uRlV6ekdYUi9QSzd4SHlkbDZJMnJVUGpRSHk4S3N3bHMv?=
 =?utf-8?B?d24vMVNxS1o3UW43T3gzOVNJTXJIRjJCQ1NFbWIxUFM0c1JlamJLeG5JTWp0?=
 =?utf-8?B?Q0JGTlFyTlVENWVONXIwYVZlSmhSbW9YMVZoSTdTVzFPcVQ1WkRLcW1qOVY5?=
 =?utf-8?B?RVdYbnFFWUYrdCtCbDYyYWVtemlXYXo0b0JRVnI5MW1MeVAzK29OZGJ5NXZO?=
 =?utf-8?B?TFJMTklJblRrWlpJeDhRYis0NURDOWEwdC8wbCtWbmJJMTVFNFgzc1UyQzFN?=
 =?utf-8?B?K0xQL1VuanNZV2dreGQzS2d4SGhCV2MrRjdtY2RGRy9CREd3TzFNaVluSE82?=
 =?utf-8?B?OEcvcWI5TjYzWis2MSs5NksrR0M4Tkw1TGFCNnJTWjlNU0hCMUVjOU9XTUFp?=
 =?utf-8?B?dzY2SVZ3UG5CenZnbXdJbHVLd3kvY1RESEtLTHgyc3c4WVFteGFlazg0Zy9N?=
 =?utf-8?B?cnU2TDlrZTNPdjhKZkFGT0hGK2xVQ001Qnk2NHVLQkl4ZHNDU2VhdUtFd1VL?=
 =?utf-8?B?aTAxclpkdzRqQ0ZWamYyNktjMXN4ZjhSMlVMcGNFUFl5eWs1N1k2SHdIZ2l3?=
 =?utf-8?B?dXlXUmkrT29IaFllb242T1BmVmxZVWREaFY1VVpIOXk0eEJLb0pRTFRnMWhB?=
 =?utf-8?B?dDZvZThPUVpyaDFGaHJPb01vTGtpc2lSVjB1clJFN3NrVVFOWkc2VDdxYkpM?=
 =?utf-8?B?VXVsNGlHZ0gwOUY4dmhKck5LQllFQ1VSbVlCcjk5L3EvbmhPdWI3U0pqMmlr?=
 =?utf-8?B?UkdINlVtK2xQZXUrNThXVHpDUUVCMFdsekZUTDlSUW1CaGZGaGVlS2ZyOERK?=
 =?utf-8?B?b21FdmxTMWxZdmxnUE1tNksvRGlmVDhxNDMvZmpDWndPVlZBUXhlS3F5ZmYx?=
 =?utf-8?B?NWdabUtpS2FJTFpDMHhWbWl5WXZhaGJhbTNxQUFBZllBV08vWXBZWTRKcVVX?=
 =?utf-8?B?L21CaGJVOW5GL1B1SW96WlkvMWtYS3VURmpLNEM0RE1EazJtMVdxeWEvT1Y3?=
 =?utf-8?B?UnYxYlZDV0NObTJGdSthL3F5UzI0Mm1PU1RVV2RBbkN0eHNoZEFyejM3UERN?=
 =?utf-8?B?eTNhWDRONXBTQWYxN1lnTmFsblJoOTVCSzZaRzZzdWJiSlQxaks5ZG81SWZZ?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4C1F667154FEC4BA1C2F232486EE3C1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858993f8-19bd-42d7-de31-08dc9c98c33c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 02:18:30.3690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZSvvIkWqkHsKUdrqQ22zfuN+iSTrsr9ivPQNN4vkew+LDbGWVBpt32wfx0ESXkc3NjuJjXoi0lVIEsroDCjvOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6104
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA3LTAzIGF0IDEyOjAxICswNTMwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToNCj4gSGkgUnVpLA0KPiANCj4gT24gNy8zLzIwMjQgOTozNyBBTSwgWmhhbmcsIFJ1aSB3cm90
ZToNCj4gPiBPbiBUdWUsIDIwMjQtMDctMDIgYXQgMTU6NTAgKzA1MzAsIERoYW5hbmpheSBVZ3dl
a2FyIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBGb3IgSW50ZWwgcHJvZHVjdHMs
IHdlIGhhdmUNCj4gPiA+ID4gMS4gQ2FzZWNhZGVsYWtlLUFQIHdoaWNoIGhhcyBtdWx0aS1kaWUg
cGVyIHBhY2thZ2UgYW5kIGhhcyBwZXItDQo+ID4gPiA+IGRpZQ0KPiA+ID4gPiBSQVBMDQo+ID4g
PiA+IE1TUnMNCj4gPiA+ID4gMi4gYWxsIG90aGVyIHBsYXRmb3JtcyB3aGljaCBoYXMgc2luZ2xl
LWRpZSBwZXIgcGFja2FnZSwgc28gaXRzDQo+ID4gPiA+IFJBUEwNCj4gPiA+ID4gTVNScyBjYW4g
YmUgY29uc2lkZXJlZCBhcyBlaXRoZXIgcGFja2FnZS1zY29wZSBvciBkaWUtc2NvcGUNCj4gPiA+
ID4gVGhpcyBhcHBsaWVzIHRvIFRoZXJtYWwgTVNScyBhcyB3ZWxsLg0KPiA+ID4gPiANCj4gPiA+
ID4gc28gZm9yIHRoZXNlIE1TUnMsIHdlIGNhbiB0cmVhdCB0aGVtIGFzDQo+ID4gPiA+IDEuIGFs
d2F5cyBkaWUtc2NvcGUgZm9yIGFsbCBleGlzdGluZyBwbGF0Zm9ybXMNCj4gPiA+ID4gb3INCj4g
PiA+ID4gMi4gcGFja2FnZS1zY29wZSB3aXRoIHRoZSBleGNlcHRpb24gb2YgQ2FzZWNhZGVsYWtl
LWFwDQo+ID4gPiA+IEFuZCBjdXJyZW50IGtlcm5lbCBjb2RlIGZvbGxvd3MgcnVsZSAxLg0KPiA+
ID4gPiANCj4gPiA+ID4gSSBwcm9wb3NlIHdlIHN3aXRjaCB0byBydWxlIDIgZm9yIHRoZXNlIGNv
ZGUgYmVjYXVzZSBydWxlIDEgY2FuDQo+ID4gPiA+IGJlDQo+ID4gPiA+IGJyb2tlIG9uIGZ1dHVy
ZSBtdWx0aS1kaWUgc3lzdGVtcyAoVGhpcyBpcyBhbHJlYWR5IHRydWUgZm9yDQo+ID4gPiA+IFRo
ZXJtYWwNCj4gPiA+ID4gTVNScykuDQo+ID4gPiANCj4gPiA+IEkgaGF2ZSBhIGRvdWJ0IGFib3V0
IHRoaXMsIHdvbid0IHRoZSBmdXR1cmUgSW50ZWwgbXVsdGktZGllDQo+ID4gPiBzeXN0ZW1zIA0K
PiA+ID4gaGF2ZSBkaWUtc2NvcGUgZm9yIHRoZSBSQVBMIFBNVSBsaWtlIENhc2VjYWRlbGFrZS1B
UD8NCj4gPiANCj4gPiBGb3IgZnV0dXJlIG11bHRpLWRpZSBzeXN0ZW1zIHRoYXQgSSBrbm93LCB0
aGUgUkFQTCBpcyBzdGlsbCBwYWNrYWdlDQo+ID4gc2NvcGUgDQo+IA0KPiBJIHRoaW5rIGluIHRo
YXQgY2FzZSB3ZSBjYW4gZ28gd2l0aCBydWxlIDIsIGl0IHdvdWxkIGJlIGZ1dHVyZSBwcm9vZg0K
PiBmb3IgSW50ZWwgc3lzdGVtcy4gSWYgeW91IGFncmVlLCBJIGNhbiBtYWtlIHRoZSBjaGFuZ2Ug
aW4gbmV4dA0KPiB2ZXJzaW9uLg0KPiANCj4gU29tZXRoaW5nIGxpa2UgYmVsb3c/LA0KPiANCj4g
LSNkZWZpbmUgcmFwbF9wbXVfaXNfcGtnX3Njb3BlKCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPiAtwqDCoMKgwqDCoMKgwqAgKGJvb3RfY3B1X2Rh
dGEueDg2X3ZlbmRvciA9PSBYODZfVkVORE9SX0FNRCB8fMKgDQo+IFzCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgDQo+IC3CoMKgwqDCoMKgwqDCoCBib290X2Nw
dV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9IWUdPTikNCj4gDQo+ICsjZGVmaW5lIHJh
cGxfcG11X2lzX2RpZV9zY29wZSgpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgXA0KPiArwqDCoMKgwqDCoMKgwqAoYm9vdF9jcHVfZGF0YS54ODZfbW9kZWxf
aWQgPT0gQ0FTQ0FERUxBS0UpDQo+IA0Kc291bmRzIGdvb2QgdG8gbWUuIEp1c3QgYSByZW1pbmRl
ciB0aGF0IHVzaW5nIGJvb3RfY3B1X2RhdGEudmZtIGlzIGENCmJldHRlciBjaG9pY2UgaGVyZS4N
Cg0KQW5kIGl0IHdvdWxkIGJlIGdyZWF0IHRvIGdldCBQZXRlcicgdmlldyBvbiB0aGlzLg0KDQp0
aGFua3MsDQpydWkNCg0KPiBSZWdhcmRzLA0KPiBEaGFuYW5qYXkNCj4gDQo+IGJ1dCBpdCBpcyBq
dXN0IGx1Y2t5IHRoYXQgUkFQTCBjb250cm9sIGlzIG5vdCBleHBvc2VkIHZpYSB0aGUNCj4gPiBN
U1JzIHNvIHJ1bGUgMSBpcyBub3QgYWN0dWFsbHkgYnJva2UgZm9yIFJBUEwgUE1VICh3aGlsZSBp
dCBpcw0KPiA+IGluZGVlZA0KPiA+IGJyb2tlbiBmb3Igb3RoZXIgZHJpdmVycyBsaWtlIHRoZXJt
YWwpLg0KPiA+IA0KPiA+IEluIHNob3J0LCBpZiB3ZSBzdGljayB3aXRoIHJ1bGUgMSwgdGhlIFJB
UEwgUE1VIHN0aWxsIHdvcmtzLg0KPiA+IFN3aXRjaGluZz4gdG8gcnVsZSAyIHRvIGJlIGNvbnNp
c3RlbnQgd2l0aCB0aGUgb3RoZXIgZHJpdmVycyBpcw0KPiA+IGFsc28gYSBjaG9pY2UgSU1WLj4g
DQo+ID4gdGhhbmtzLA0KPiA+IHJ1aQ0KPiA+ID4gDQo+ID4gPiBJZiB5ZXMsIHRoZW4gcnVsZSAx
IGFib3ZlIHNlZW1zIGJldHRlci4NCj4gPiA+IA0KPiA+ID4gUmVnYXJkcywNCj4gPiA+IERoYW5h
bmpheQ0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBJbiB0aGlzIHNlbnNlLCBJIHRoaW5rIGl0
IGlzIG9rYXkgdG8gY2FsbCBpdCBwa2cgbGV2ZWwgcmFwbCBmb3INCj4gPiA+ID4gYm90aA0KPiA+
ID4gPiBJbnRlbCBhbmQgQU1ELg0KPiA+ID4gPiANCj4gPiA+ID4gdGhhbmtzLA0KPiA+ID4gPiBy
dWkNCj4gPiA+ID4gDQo+ID4gDQo+IA0KDQo=

