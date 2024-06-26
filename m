Return-Path: <linux-pm+bounces-10057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EAE91858F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 17:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2FB28411F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44DB18A935;
	Wed, 26 Jun 2024 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1MDfuXl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F6218C324;
	Wed, 26 Jun 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415127; cv=fail; b=fA5mxKL39wOvH1V0PIdEKSWM7CKbvA0cNy+V1feR7NFY1bum5vrp9WuZflapUjenZ32z0e1HVj7orX9SQnhD6r3rHEHq/JOw+kJqDY8PZoCZ+rZW2MQUYzDT3rUc1XGAoaBHgveBPbWtQMTV7hEjSMhagenHhCXV9vaRBEKc/GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415127; c=relaxed/simple;
	bh=IcqPjKRTOi6FQyVL8363Y5uUj+mfBFKeEyKR1BH537k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qTm33m0QbCF3IfatNsHKSafZADTjc0XqtpOmi0hRjLaUoegsp55H/5tlapM8ER32mLNuF7Cw58zNLyycwAVb7g4X0YGrt33hsC9Y3ViTGm9p42rRrRCg9po6bTYuIgC+RH/SmYLou8F1OQ86czHYxK7vM28cZG7nRD3ariPkylU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1MDfuXl; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719415125; x=1750951125;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IcqPjKRTOi6FQyVL8363Y5uUj+mfBFKeEyKR1BH537k=;
  b=W1MDfuXlSWch59aXEIIhMBu81X1tp5pW4wmBfl9iiWDB6ZuJ5ngGh1PF
   +Hh+8e6N5ZFLWIDjHIX2t4cXg1cpgvy6JR1I7gnb0X1tyZdvOOhd1NovO
   H1uzYOYvpQh1FzBrPuBSMeklZOgeoQZYHmfRjpzrhqdfcrDQA0ZlV2ju4
   5W2q6M/vZieNi4ZW7mNPINwdn6wnlannI1B2Ir/FB0X4SQsJ7H4OnqEjM
   rHBpjS7n6b/mDi+IfI1uqqxL7i3dNkCHKLnfLot+wuLjAajwv9RA6BAPM
   nxYdlM+GKLCaYXbaStnUdUCyuisNnp/oPqZNB8Oa2GE+IfGAD2YUtCW1r
   Q==;
X-CSE-ConnectionGUID: yLf0HqmeT0u6GGRc/y7hDA==
X-CSE-MsgGUID: 1GqNHxdyQBKd2bGkE5i4VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27634213"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="27634213"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 08:18:44 -0700
X-CSE-ConnectionGUID: UAZhUz/7T+K5nyGqG4T+2Q==
X-CSE-MsgGUID: OPBUQoeTQyio00vEuCeU9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="44456371"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 08:18:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 08:18:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 08:18:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 08:18:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 08:18:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXkE55qGDk9FNAfhlQKQpjE377FGS/LIUGtUOVekYNHgxFMyVA25wx0IPAG1NamxTqwa3OREWJBr0U0zCOHEd0zBbH62ZCwWKQPVVgskqO1rBfe+q3XXPF3odICFXUnS44SVvEacD/KhTJ9jiv+ntg1C8uV96biMphk455ffFB5FDJUNPsz09qJhj+xXlNG1MISL+o6sS3XB3JCB13tpzy0Iv4KmmKMnve8RUAjAU/2OfohVcCuM9x+OM+T3ZU5JhY0VpCKyMtdF7ermuva7H94o09sK3fXUwMwFebh0YwiVo5EYG5iAnCQDwoF7oApsoWEJXv5I+O7Qr4KTa3I/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcqPjKRTOi6FQyVL8363Y5uUj+mfBFKeEyKR1BH537k=;
 b=b8s9KJCgNCDZnNAzuHOx4aq0l58xIh+pqQyp4FFIDf1ufp545WV/s0gL93ClJdBW7yzPFXU6flLdUz2CfOfP8YgXNzVM7dz7C9PFTfKES0rIlXHKvKpTVKqcqTJg6olXVj86xLuRDZJN2V3oPfWMqdBYpBEnjXkr+99KCbFS/yO4VJOaKVOfC6aRfNnZA4Rf3WX20T/ARmgNHPbjjqdOHX/5fFYKxevwgd5I3YnqZ8ECriGvE6RVOMJNiwgLcoavNGdXJZUoVacUEatJewUMd7I+jZr/8gLM8i9UQxjfvT3RWqKrFsn5Jg5WXCdlVaxX7ZNqeIvnqoCgQpbS3gMRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM4PR11MB5312.namprd11.prod.outlook.com (2603:10b6:5:393::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 15:18:37 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%7]) with mapi id 15.20.7698.033; Wed, 26 Jun 2024
 15:18:37 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"irogers@google.com" <irogers@google.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "kees@kernel.org"
	<kees@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Dhananjay.Ugwekar@amd.com"
	<Dhananjay.Ugwekar@amd.com>, "bp@alien8.de" <bp@alien8.de>, "acme@kernel.org"
	<acme@kernel.org>, "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>
CC: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "ananth.narayan@amd.com"
	<ananth.narayan@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 10/10] perf/x86/rapl: Add per-core energy counter
 support for AMD CPUs
Thread-Topic: [PATCH v3 10/10] perf/x86/rapl: Add per-core energy counter
 support for AMD CPUs
Thread-Index: AQHaxfxH+bqbABPQbUKOwDk8vLyuq7HaLDeA
Date: Wed, 26 Jun 2024 15:18:36 +0000
Message-ID: <18e0c72823d916d82aa48fb6690375f960a9d9ea.camel@intel.com>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
	 <20240624055907.7720-11-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240624055907.7720-11-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM4PR11MB5312:EE_
x-ms-office365-filtering-correlation-id: 5fa93409-d03e-4fde-21d9-08dc95f3406f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022|921018|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?bFZpM3JuMTk1RFcrQ0ZkM2J2NGNIc2ZNSHBxZVkvSjVrT3kwTUxOTVhtQ0xu?=
 =?utf-8?B?YkNzWW9TcSsrMWNiaW44Z0kya25YZTBtTlhwOGtnbGhxWklIemdGaGpJaVdj?=
 =?utf-8?B?WmUrQm5VNlpzclV1WnY3ZVdqSnlRQUxrbjkzeUZFRmZKNGNwMFpwTGpxWVJt?=
 =?utf-8?B?UTBpTzNHc2dweXV4QWt1WWVONDVkbGdqQ2hONTFpL2FHdUdYNEJRQmtsNGxV?=
 =?utf-8?B?VnJyYkE5V3VBTUZjdTl6YVc4YUIyd2xZaG5BbWx6anZPY2U2cXRLY2NHb1Y0?=
 =?utf-8?B?d0J0YmpqRTNqZk9IYnRRbkJLZWlXZUgxVnJOTkZ2aUNaU0FWNkxIdG1hS0VJ?=
 =?utf-8?B?c3pQZDAzeFU5ZW0zOGxIblNBMEFZSmgwb2d2dVVZUlR6NVQwUkRWc01kb0lt?=
 =?utf-8?B?YWNOL3ZOQzA2Uk4vQ0xPbThoVWRmVkJPTzFYS01DNkZTK0E2dlByTHcyNVA4?=
 =?utf-8?B?dGljVG9IZVUzSG1pQTRIM0dFWXZHQjMvaHJyaWlKb3c2bzRqYTlzUTVkVmNN?=
 =?utf-8?B?R3RmRm5sSGtRdVE2Wk90bkJ6RFJUWmpIZThJZUpNSE9EMFdCeDh5V0RDdThP?=
 =?utf-8?B?ZW9LTG1SeWpVSDVaRXMrWC9QamU4MWRHUjdDVFNSamZ1TjlqSnpOamsva1BB?=
 =?utf-8?B?OW5vR2w1bnkyREdSNE5WbXdpWGpTMm9selBDREU4MXp4VmVVbDlDY3V5d3hH?=
 =?utf-8?B?K2dNRURKTEZNS2VFMVJoc3MzcXI2OUZtZ05IT2pDTFZUUEg5L3N1cDlpajd5?=
 =?utf-8?B?Y1Z6N0RQdnp2N3hTTDJ5aG1uRnFuYnp6Y2pxazY3Qm1XdEE0SSttaDZKZFhq?=
 =?utf-8?B?WFJpWVdzdXNERUY0anoyMXhJREc2emo5K3RlVjJxTmJYTmRwQmNWRzlQYmZp?=
 =?utf-8?B?M2kwNWZtNXg1cVk2T0Q2WDhpVUF4b3lNamtNeXhLR2RzTEMyOVFVRHI2Z3ZX?=
 =?utf-8?B?R2NPSkZsRkowa0RpdXRlUWVoQUllNW5Ob3NMdTNmMUJwekZ4TEpOSWx2Qnl6?=
 =?utf-8?B?N2Y0RVo1OFhSV1h6Mm1YYXpoWGp2VVVhb1hzd1ZIYi9EWTQ2c1N6cnBmQUZX?=
 =?utf-8?B?a3JxZ1NsaXlxUWxETjJqS3F4RDFCV3JMUUlwQ0R3eHNvb0NDY3E0WmIrSkJo?=
 =?utf-8?B?bnVwT0tTZno3SXBkN0R0SmtsK1FxQ0pHVmJjNWFLZWxJaVFhUXZGaThjNWla?=
 =?utf-8?B?SjlJeDNUNHpraXIxTzlid29meDh2aGFxeFdXNTY1QUxVNWRpTWVFV0xyYkZ4?=
 =?utf-8?B?cnV3VUdKNnJlVUtXZ2FVdmdOTjMyd2NxVkdYVHlrVis0SytFL0FkYmZnQkk3?=
 =?utf-8?B?WEhRK0lTNDU4U0ZUaTZEaWZsb0ZuaEVsRXRienBJNmx1dlRJa21Dc3d4SmJt?=
 =?utf-8?B?b3pKOHRIT3hwK3RlVEdHV0RmS3hMK1dVU2E5RWYrL0FKSG8yV3NibzgzVk9M?=
 =?utf-8?B?ZDJEb1lFRG5FazV5dmZLYS9xU2RPeGpCanh4eFc3R3lXbTlyZlhVMnNHUGNQ?=
 =?utf-8?B?U2pwako1NFVIYjA1QWM4d1lnOHlKL2FTbDVXMGhoTng1Rk5Uem05Y1RDVkM1?=
 =?utf-8?B?OHhwMXJwWUR5dkMwUllpcmNJanNPbHZVSWZKZmc3RkQyUk96RlpLa0tIby9v?=
 =?utf-8?B?QXpzVFJuRjV5dFhGb2IrUFlzUE5hKy9ZMlFOckY3M3BpclNuY1VQK0xVYzZ6?=
 =?utf-8?B?MWs4bE00Z0VwWUxPUXQwZFZQNGk2TTJad1lYVEFid3lHQUdwOVRQRHpGenBj?=
 =?utf-8?B?bHZuTFhESGo2OUJna2FFaXZzTDVEUk5IaDZUdnRNQURPMjVaZTlBTUZsUUlO?=
 =?utf-8?B?R21vdEo3dE5HYzlrL085dFc5SEFMMWJiTVBCWVFNMFJOOURVNmJkUVNrQUNr?=
 =?utf-8?B?SUszTnFqZlgxb1YvdER6NmlwSXJ1VGRLa0JPOXAwaThkWDZ3TS9YbFJuclRa?=
 =?utf-8?Q?EoVq3dFYWsk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022)(921018)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkN2K2ltMDk4cTZOYVBwb1VMZXhSWnpETVR4cFdJMW8zUGt6VTlkbDVVTkdV?=
 =?utf-8?B?elhxcmtDUjgxVTU4dlN6Szk2TWJiMkQyMks4VVQ0YWZEaG1qWDQyNmlSbjFw?=
 =?utf-8?B?U3g1VGp5Ry9qSTFZcTQzdDZYTUQ0S0QrTGpWOUFmbENPZzE5SXRROUJuS1E2?=
 =?utf-8?B?MFgwTHNBRXBiaU9zMmZneWE4QmI3NnBqWE5XK2xmNXJvS09HK2dvekJ2bkJM?=
 =?utf-8?B?ZEEyOVlwNlk1czE3L2RhTHEyRktOeVZFeDY4dm1CTmdmNGwxcmlKVlpJU3pT?=
 =?utf-8?B?ckdyZFIxYUVMakFnME1GSUhkbkpseUJwaDE0SnpmMEhMYWtxT0JPL0wzSDlr?=
 =?utf-8?B?dkxOV1NSUGxmVEM1MG1EbnVrR1E1M011RzR1V1RRb3FUcUR2VS9WZkZjalUr?=
 =?utf-8?B?Q1ZTbXg1a2F6NkVaTW11VmV4aE1meE5GTWpKTUFJSmRWc3hUM0xTOU9RVEdu?=
 =?utf-8?B?dUtiVlhVUjZOeklMakRSMkYvQ1NXZE1YWWF3WEhMempiYytrU1hNWHM3MEFq?=
 =?utf-8?B?QVNyYUNrUzBCa3AyLzNyYlZHUUpYbk9aYk1FMDJ4ZUk2a1pFT1UzUjV1REVK?=
 =?utf-8?B?aWM2UGRrU2tabysrN29HVHBYdWFuSDUrQlFNWUx1U0hFcjduaUkxU2dqcTJC?=
 =?utf-8?B?MWdMZ2ttWmRTUXdsaEdKSmc0dUxZK2hJR3V1SzJicmlnQkthRElSUDZZOThB?=
 =?utf-8?B?SFVia0pjcGxIcThXYVlqa2lacXoyR0RRR2YweE81d0FpMWV3cithSjhWR2tx?=
 =?utf-8?B?czRKZTUyVHU0TnR3NXBPeTNlMlZ2ZGZXaXczdWJPVkhxcU82SWNGZ0puR0lS?=
 =?utf-8?B?eXRDR1dCaUZDdXRTNDRaVkRLcG1nRWRDTktiS1F5ZWQrVWNoeDVyS2FSaXU1?=
 =?utf-8?B?enp4dkpSWGlVQTZMY1hha0VMSGZ1Vk1QNm12Y1RJK2gxcVZhaGUrTzFmM1E4?=
 =?utf-8?B?REF5aGljL1liN2UrazNUM1BYS0JPNG93M1JsT09lSWRRcUR2MkM2YVpQelVV?=
 =?utf-8?B?R1Jsbk1YQWJBMmZibXhURGQwR2hvNFMycXRkRjJ5a2phTmlKUHdSdUZadUlC?=
 =?utf-8?B?R0FaOHpxK2QvNTlKbTFLakxYai9qMWhDVm90NlQ3bXJSWlVVYVFXWGw0TEtE?=
 =?utf-8?B?L1dKdEp1VlRLVzhLUmJ6OXZIaGk0dmd1N1kwREcwaEFjTzQ5YXdGRnI0UE1T?=
 =?utf-8?B?Q3kyeVVGS0hBb1hkdW1Ia0VTUURnQWNWSjljTDRBK3JpZlBkK2tGTDg3RXR6?=
 =?utf-8?B?dzJYZTVMUFdNMUM1QkM3eWxDVFNoMFdYU0VsWkd1WGc0S0dRMXFGMW9oMU1B?=
 =?utf-8?B?b2IvZW5sYlRna0ovWjFDY1dYUWh1S2pTSlp6QjZwYm55Z1E0TWdDRWxlbGRt?=
 =?utf-8?B?clJzU2t2Sm1ZcXNFL21MeDU4Y2diWGpRVzFBWE1WaThXYlhXbzkyWGh4YnFm?=
 =?utf-8?B?TVdOaWU4MnVZRlBkUGI1K2ZXTUZGaE83Y2Y2SDN4bjdlZ3JwM250Smk4bzly?=
 =?utf-8?B?WjZoRVdJOTd6L3poVWRsemc1SVM4YkVIeUFyeVJsTlkxYUJjRjVJcTRUQ0FM?=
 =?utf-8?B?R2hmUkV3bHlYRjJ3YW5HSFU3QmxCMFNPaXRvaHFJMHo4REIvT2E5K2RKYW0w?=
 =?utf-8?B?RFN6YXRGSmJoUkZFK1hzZWprVFE0cmJGTEppaml1bEtjRE1IK2ZMVjhIUVI1?=
 =?utf-8?B?VTJrY3plWklDaVFCRVhHektCdmZ2bU9yY2VHaVU2NFVjTGp2dU9rT0xVQTdy?=
 =?utf-8?B?QU9EL1FES3hIZXF3MVJPTmtLZGdXYThVOWRiajJxMHdleGk3NzhvSThqaG1L?=
 =?utf-8?B?UzZ3aDdUNUJ2QjlKL3p0WnRoaGxxSTFHSnEyL2tsOE9ObjlqNTZpNUlaNVZY?=
 =?utf-8?B?OXdQa2hjOEc3cnJyWmh1VG55amhsZkQyVUEvODhCUzhVQVQ1cnRTanQ0ZnBv?=
 =?utf-8?B?SkNON1RLZDdlZTVjZldONFR5eklSU2RPdURYa1VRbUVhb2hic3FjL0FEaXpR?=
 =?utf-8?B?dmxVTy92SFlFc0hvRzEwZ3E3OGpGSGxqanNqR2psOUZyKzhCK2VubVN6Slkv?=
 =?utf-8?B?dWlXc2xOYkY1eU10OWVRRFRNVWJzdlBCSjVTRTM4eTgrVEVDd2M4amUraWpY?=
 =?utf-8?B?VnB5MFR5SjJ2c1ptRGlJNk5ZRmNBM0tpS21pV0dTOWJzOG1Rb1JIVFZFL1Fp?=
 =?utf-8?B?VE9FUlhDRldYUERhS0Z2V2V3OFRYekplajE1TW9VVVJNb2lxTWpLK0RPMDEr?=
 =?utf-8?B?b3A3cks0dkwwQ3JrNW1uK0V0VWN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2B110C8FD0D2547B67065CF59B9645F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa93409-d03e-4fde-21d9-08dc95f3406f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 15:18:37.0001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMAGo+1PchXQ+FfgwsWNBgseWlP7m7qEIrS5IrK/LqYOoflTdGcGWKy58xaQPZxTTGYrOZDedv3TzIJWIPq7Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5312
X-OriginatorOrg: intel.com

Cj4gQEAgLTEzMSw4ICsxNDYsMTAgQEAgZW51bSByYXBsX3VuaXRfcXVpcmsgewo+IMKgfTsKPiDC
oAo+IMKgc3RydWN0IHJhcGxfbW9kZWwgewo+IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCBwZXJmX21z
ciAqcmFwbF9tc3JzOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBwZXJmX21zciAqcmFwbF9wa2df
bXNyczsKCklNTywgdGhpcyBzaG91bGQgYmUgcGFydCBvZiBwYXRjaCA4LzEwLgoKWy4uLl0KCj4g
QEAgLTY4NSw2ICs3NzQsMTMgQEAgc3RhdGljIHZvaWQgX19pbml0IHJhcGxfYWR2ZXJ0aXNlKHZv
aWQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJhcGxfcGtnX2RvbWFpbl9uYW1lc1tpXSwKPiByYXBsX2h3X3VuaXRbaV0p
Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgwqDCoMKgwqDCoMKgwqB9
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGZvciAoaSA9IDA7IGkgPCBOUl9SQVBMX0NPUkVfRE9NQUlO
UzsgaSsrKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyYXBsX2NvcmVf
Y250cl9tYXNrICYgKDEgPDwgaSkpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHByX2luZm8oImh3IHVuaXQgb2YgZG9tYWluICVzIDJeLSVkCj4gSm91
bGVzXG4iLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJhcGxfY29yZV9kb21haW5fbmFtZXNbaV0sCj4gcmFwbF9od191bml0
W2ldKTsKCnJhcGxfaHdfdW5pdFtdIGlzIGZvciBwYWNrYWdlIHBtdSBvbmx5IGFuZApyYXBsX2h3
X3VuaXRbMF0gaXMgcmFwbF9od191bml0W1BFUkZfUkFQTF9QUDBdIHJhdGhlciB0aGFuCnJhcGxf
aHdfdW5pdFtQRVJGX1JBUExfUEVSX0NPUkVdCgp5b3UgY2Fubm90IHVzZSByYXBsX2h3X3VuaXRb
aV0gdG8gcmVwcmVzZW50IHBlci1jb3JlIHJhcGwgZG9tYWluIHVuaXQuCgo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDCoMKgfQo+IMKgfQo+IMKgCj4gwqBz
dGF0aWMgdm9pZCBjbGVhbnVwX3JhcGxfcG11cyhzdHJ1Y3QgcmFwbF9wbXVzICpyYXBsX3BtdXMp
Cj4gQEAgLTcwNSwxNSArODAxLDE2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dy
b3VwCj4gKnJhcGxfYXR0cl91cGRhdGVbXSA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgTlVMTCwKPiDC
oH07Cj4gwqAKPiAtc3RhdGljIGludCBfX2luaXQgaW5pdF9yYXBsX3BtdXMoc3RydWN0IHJhcGxf
cG11cyAqKnJhcGxfcG11c19wdHIpCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dy
b3VwICpyYXBsX3Blcl9jb3JlX2F0dHJfdXBkYXRlW10gPSB7Cj4gK8KgwqDCoMKgwqDCoMKgJnJh
cGxfZXZlbnRzX3Blcl9jb3JlX2dyb3VwLAo+ICt9Owo+ICsKPiArc3RhdGljIGludCBfX2luaXQg
aW5pdF9yYXBsX3BtdXMoc3RydWN0IHJhcGxfcG11cyAqKnJhcGxfcG11c19wdHIsCj4gaW50IG5y
X3JhcGxfcG11LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwCj4gKipyYXBs
X2F0dHJfZ3JvdXBzLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwCj4gKipy
YXBsX2F0dHJfdXBkYXRlKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcmFwbF9wbXVz
ICpyYXBsX3BtdXM7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBpbnQgbnJfcmFwbF9wbXUgPSB0b3Bv
bG9neV9tYXhfcGFja2FnZXMoKSAqCj4gdG9wb2xvZ3lfbWF4X2RpZXNfcGVyX3BhY2thZ2UoKTsK
PiAtCj4gLcKgwqDCoMKgwqDCoMKgaWYgKHJhcGxfcG11X2lzX3BrZ19zY29wZSgpKQo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBucl9yYXBsX3BtdSA9IHRvcG9sb2d5X21heF9wYWNr
YWdlcygpOwo+IC0KPiDCoMKgwqDCoMKgwqDCoMKgcmFwbF9wbXVzID0ga3phbGxvYyhzdHJ1Y3Rf
c2l6ZShyYXBsX3BtdXMsIHJhcGxfcG11LAo+IG5yX3JhcGxfcG11KSwgR0ZQX0tFUk5FTCk7Cj4g
wqDCoMKgwqDCoMKgwqDCoGlmICghcmFwbF9wbXVzKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIC1FTk9NRU07Cj4gQEAgLTc0MSw3ICs4MzgsNyBAQCBzdGF0aWMgc3Ry
dWN0IHJhcGxfbW9kZWwgbW9kZWxfc25iID0gewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJVChQRVJGX1JBUExfUEtHKSB8Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUKFBFUkZfUkFQTF9Q
UDEpLAo+IMKgwqDCoMKgwqDCoMKgwqAubXNyX3Bvd2VyX3VuaXQgPSBNU1JfUkFQTF9QT1dFUl9V
TklULAo+IC3CoMKgwqDCoMKgwqDCoC5yYXBsX21zcnPCoMKgwqDCoMKgID0gaW50ZWxfcmFwbF9t
c3JzLAo+ICvCoMKgwqDCoMKgwqDCoC5yYXBsX3BrZ19tc3JzwqDCoD0gaW50ZWxfcmFwbF9tc3Jz
LAo+IMKgfTsKPiDCoAo+IMKgc3RhdGljIHN0cnVjdCByYXBsX21vZGVsIG1vZGVsX3NuYmVwID0g
ewo+IEBAIC03NDksNyArODQ2LDcgQEAgc3RhdGljIHN0cnVjdCByYXBsX21vZGVsIG1vZGVsX3Nu
YmVwID0gewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEJJVChQRVJGX1JBUExfUEtHKSB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUKFBFUkZfUkFQTF9SQU0pLAo+IMKgwqDCoMKgwqDCoMKg
wqAubXNyX3Bvd2VyX3VuaXQgPSBNU1JfUkFQTF9QT1dFUl9VTklULAo+IC3CoMKgwqDCoMKgwqDC
oC5yYXBsX21zcnPCoMKgwqDCoMKgID0gaW50ZWxfcmFwbF9tc3JzLAo+ICvCoMKgwqDCoMKgwqDC
oC5yYXBsX3BrZ19tc3JzwqDCoD0gaW50ZWxfcmFwbF9tc3JzLAo+IMKgfTsKPiDCoAo+IMKgc3Rh
dGljIHN0cnVjdCByYXBsX21vZGVsIG1vZGVsX2hzdyA9IHsKPiBAQCAtNzU4LDcgKzg1NSw3IEBA
IHN0YXRpYyBzdHJ1Y3QgcmFwbF9tb2RlbCBtb2RlbF9oc3cgPSB7Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUKFBFUkZfUkFQTF9SQU0pIHwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCSVQo
UEVSRl9SQVBMX1BQMSksCj4gwqDCoMKgwqDCoMKgwqDCoC5tc3JfcG93ZXJfdW5pdCA9IE1TUl9S
QVBMX1BPV0VSX1VOSVQsCj4gLcKgwqDCoMKgwqDCoMKgLnJhcGxfbXNyc8KgwqDCoMKgwqAgPSBp
bnRlbF9yYXBsX21zcnMsCj4gK8KgwqDCoMKgwqDCoMKgLnJhcGxfcGtnX21zcnPCoMKgPSBpbnRl
bF9yYXBsX21zcnMsCj4gwqB9Owo+IMKgCj4gwqBzdGF0aWMgc3RydWN0IHJhcGxfbW9kZWwgbW9k
ZWxfaHN4ID0gewo+IEBAIC03NjcsNyArODY0LDcgQEAgc3RhdGljIHN0cnVjdCByYXBsX21vZGVs
IG1vZGVsX2hzeCA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBCSVQoUEVSRl9SQVBMX1JBTSksCj4gwqDCoMKgwqDCoMKgwqDCoC51bml0X3F1
aXJrwqDCoMKgwqDCoD0gUkFQTF9VTklUX1FVSVJLX0lOVEVMX0hTVywKPiDCoMKgwqDCoMKgwqDC
oMKgLm1zcl9wb3dlcl91bml0ID0gTVNSX1JBUExfUE9XRVJfVU5JVCwKPiAtwqDCoMKgwqDCoMKg
wqAucmFwbF9tc3JzwqDCoMKgwqDCoCA9IGludGVsX3JhcGxfbXNycywKPiArwqDCoMKgwqDCoMKg
wqAucmFwbF9wa2dfbXNyc8KgwqA9IGludGVsX3JhcGxfbXNycywKPiDCoH07Cj4gwqAKPiDCoHN0
YXRpYyBzdHJ1Y3QgcmFwbF9tb2RlbCBtb2RlbF9rbmwgPSB7Cj4gQEAgLTc3NSw3ICs4NzIsNyBA
QCBzdGF0aWMgc3RydWN0IHJhcGxfbW9kZWwgbW9kZWxfa25sID0gewo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJVChQRVJGX1JBUExfUkFNKSwK
PiDCoMKgwqDCoMKgwqDCoMKgLnVuaXRfcXVpcmvCoMKgwqDCoMKgPSBSQVBMX1VOSVRfUVVJUktf
SU5URUxfSFNXLAo+IMKgwqDCoMKgwqDCoMKgwqAubXNyX3Bvd2VyX3VuaXQgPSBNU1JfUkFQTF9Q
T1dFUl9VTklULAo+IC3CoMKgwqDCoMKgwqDCoC5yYXBsX21zcnPCoMKgwqDCoMKgID0gaW50ZWxf
cmFwbF9tc3JzLAo+ICvCoMKgwqDCoMKgwqDCoC5yYXBsX3BrZ19tc3JzwqDCoD0gaW50ZWxfcmFw
bF9tc3JzLAo+IMKgfTsKPiDCoAo+IMKgc3RhdGljIHN0cnVjdCByYXBsX21vZGVsIG1vZGVsX3Nr
bCA9IHsKPiBAQCAtNzg1LDcgKzg4Miw3IEBAIHN0YXRpYyBzdHJ1Y3QgcmFwbF9tb2RlbCBtb2Rl
bF9za2wgPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgQklUKFBFUkZfUkFQTF9QUDEpIHwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCSVQoUEVSRl9SQVBMX1BTWVMpLAo+IMKgwqDCoMKgwqDC
oMKgwqAubXNyX3Bvd2VyX3VuaXQgPSBNU1JfUkFQTF9QT1dFUl9VTklULAo+IC3CoMKgwqDCoMKg
wqDCoC5yYXBsX21zcnPCoMKgwqDCoMKgID0gaW50ZWxfcmFwbF9tc3JzLAo+ICvCoMKgwqDCoMKg
wqDCoC5yYXBsX3BrZ19tc3JzwqDCoD0gaW50ZWxfcmFwbF9tc3JzLAo+IMKgfTsKPiDCoAo+IMKg
c3RhdGljIHN0cnVjdCByYXBsX21vZGVsIG1vZGVsX3NwciA9IHsKPiBAQCAtNzk1LDEzICs4OTIs
MTUgQEAgc3RhdGljIHN0cnVjdCByYXBsX21vZGVsIG1vZGVsX3NwciA9IHsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCSVQoUEVSRl9SQVBMX1BT
WVMpLAo+IMKgwqDCoMKgwqDCoMKgwqAudW5pdF9xdWlya8KgwqDCoMKgwqA9IFJBUExfVU5JVF9R
VUlSS19JTlRFTF9TUFIsCj4gwqDCoMKgwqDCoMKgwqDCoC5tc3JfcG93ZXJfdW5pdCA9IE1TUl9S
QVBMX1BPV0VSX1VOSVQsCj4gLcKgwqDCoMKgwqDCoMKgLnJhcGxfbXNyc8KgwqDCoMKgwqAgPSBp
bnRlbF9yYXBsX3Nwcl9tc3JzLAo+ICvCoMKgwqDCoMKgwqDCoC5yYXBsX3BrZ19tc3JzwqDCoD0g
aW50ZWxfcmFwbF9zcHJfbXNycywKPiDCoH07CgpBbGwgdGhlIGFib3ZlIHJlbmFtaW5nIGNvZGUg
c2hvdWxkIGJlIGluIHBhdGNoIDgvMTAuCk9yIGVsc2UgaXQgaXMgYSBkaXN0cmFjdGlvbiBmb3Ig
cmV2aWV3aW5nIHRoaXMgcGF0Y2guCgo+IMKgCj4gwqBzdGF0aWMgc3RydWN0IHJhcGxfbW9kZWwg
bW9kZWxfYW1kX2h5Z29uID0gewo+IMKgwqDCoMKgwqDCoMKgwqAucGtnX2V2ZW50c8KgwqDCoMKg
wqA9IEJJVChQRVJGX1JBUExfUEtHKSwKPiArwqDCoMKgwqDCoMKgwqAuY29yZV9ldmVudHPCoMKg
wqDCoD0gQklUKFBFUkZfUkFQTF9QRVJfQ09SRSksCj4gwqDCoMKgwqDCoMKgwqDCoC5tc3JfcG93
ZXJfdW5pdCA9IE1TUl9BTURfUkFQTF9QT1dFUl9VTklULAo+IC3CoMKgwqDCoMKgwqDCoC5yYXBs
X21zcnPCoMKgwqDCoMKgID0gYW1kX3JhcGxfcGtnX21zcnMsCj4gK8KgwqDCoMKgwqDCoMKgLnJh
cGxfcGtnX21zcnPCoMKgPSBhbWRfcmFwbF9wa2dfbXNycywKPiArwqDCoMKgwqDCoMKgwqAucmFw
bF9jb3JlX21zcnPCoD0gYW1kX3JhcGxfY29yZV9tc3JzLAo+IMKgfTsKPiDCoAo+IMKgc3RhdGlj
IGNvbnN0IHN0cnVjdCB4ODZfY3B1X2lkIHJhcGxfbW9kZWxfbWF0Y2hbXSBfX2luaXRjb25zdCA9
IHsKPiBAQCAtODU4LDYgKzk1NywxMSBAQCBzdGF0aWMgaW50IF9faW5pdCByYXBsX3BtdV9pbml0
KHZvaWQpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCB4ODZfY3B1X2lkICpp
ZDsKPiDCoMKgwqDCoMKgwqDCoMKgaW50IHJldDsKPiArwqDCoMKgwqDCoMKgwqBpbnQgbnJfcmFw
bF9wbXUgPSB0b3BvbG9neV9tYXhfcGFja2FnZXMoKSAqCj4gdG9wb2xvZ3lfbWF4X2RpZXNfcGVy
X3BhY2thZ2UoKTsKPiArwqDCoMKgwqDCoMKgwqBpbnQgbnJfY29yZXMgPSB0b3BvbG9neV9tYXhf
cGFja2FnZXMoKSAqCj4gdG9wb2xvZ3lfbnVtX2NvcmVzX3Blcl9wYWNrYWdlKCk7CgpJJ2Qgc3Vn
Z2VzdCBlaXRoZXIgdXNpbmcgdHdvIHZhcmlhYmxlcyBucl9wa2dzL25yX2NvcmVzLCBvciByZXVz
ZSBvbmUKdmFyaWFibGUgbnJfcmFwbF9wbXUgZm9yIGJvdGggcGtnIHBtdSBhbmQgcGVyLWNvcmUg
cG11LgoKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJhcGxfcG11X2lzX3BrZ19zY29wZSgpKQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBucl9yYXBsX3BtdSA9IHRvcG9sb2d5X21h
eF9wYWNrYWdlcygpOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGlkID0geDg2X21hdGNoX2NwdShy
YXBsX21vZGVsX21hdGNoKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFpZCkKPiBAQCAtODY1LDE3
ICs5NjksMzQgQEAgc3RhdGljIGludCBfX2luaXQgcmFwbF9wbXVfaW5pdCh2b2lkKQo+IMKgCj4g
wqDCoMKgwqDCoMKgwqDCoHJhcGxfbW9kZWwgPSAoc3RydWN0IHJhcGxfbW9kZWwgKikgaWQtPmRy
aXZlcl9kYXRhOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgcmFwbF9wa2dfY250cl9tYXNrID0gcGVy
Zl9tc3JfcHJvYmUocmFwbF9tb2RlbC0+cmFwbF9tc3JzLAo+IFBFUkZfUkFQTF9QS0dfRVZFTlRT
X01BWCwKPiArwqDCoMKgwqDCoMKgwqByYXBsX3BrZ19jbnRyX21hc2sgPSBwZXJmX21zcl9wcm9i
ZShyYXBsX21vZGVsLQo+ID5yYXBsX3BrZ19tc3JzLCBQRVJGX1JBUExfUEtHX0VWRU5UU19NQVgs
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmYWxzZSwgKHZvaWQgKikgJnJhcGxfbW9kZWwtCj4g
PnBrZ19ldmVudHMpOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IHJhcGxfY2hlY2tfaHdf
dW5pdCgpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoHJldCA9IGluaXRf
cmFwbF9wbXVzKCZyYXBsX3BtdXNfcGtnKTsKPiArwqDCoMKgwqDCoMKgwqByZXQgPSBpbml0X3Jh
cGxfcG11cygmcmFwbF9wbXVzX3BrZywgbnJfcmFwbF9wbXUsCj4gcmFwbF9hdHRyX2dyb3Vwcywg
cmFwbF9hdHRyX3VwZGF0ZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+IMKgCj4gK8KgwqDCoMKgwqDCoMKg
aWYgKHJhcGxfbW9kZWwtPmNvcmVfZXZlbnRzKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJhcGxfY29yZV9jbnRyX21hc2sgPSBwZXJmX21zcl9wcm9iZShyYXBsX21vZGVsLQo+
ID5yYXBsX2NvcmVfbXNycywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgCj4gUEVSRl9SQVBMX0NPUkVfRVZFTlRTX01BWCwgZmFsc2UsCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAodm9pZCAqKQo+ICZyYXBsX21v
ZGVsLT5jb3JlX2V2ZW50cyk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXQgPSBpbml0X3JhcGxfcG11cygmcmFwbF9wbXVzX2NvcmUsIG5yX2NvcmVzLAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJhcGxfcGVyX2NvcmVfYXR0cl9ncm91cHMsCj4gcmFwbF9wZXJfY29yZV9hdHRyX3Vw
ZGF0ZSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpIHsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBJZiBpbml0aWFsaXphdGlv
biBvZiBwZXJfY29yZSBQTVUgZmFpbHMsCj4gcmVzZXQgcGVyX2NvcmUKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGZsYWcsIGFuZCBjb250aW51ZSB3
aXRoIHBvd2VyIFBNVQo+IGluaXRpYWxpemF0aW9uLgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBwcl93YXJuKCJQZXItY29yZSBQTVUgaW5pdGlhbGl6YXRpb24g
ZmFpbGVkCj4gKCVkKVxuIiwgcmV0KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJhcGxfbW9kZWwtPmNvcmVfZXZlbnRzID0gMFVMOwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiDCoMKgwqDC
oMKgwqDCoMKgLyoKPiDCoMKgwqDCoMKgwqDCoMKgICogSW5zdGFsbCBjYWxsYmFja3MuIENvcmUg
d2lsbCBjYWxsIHRoZW0gZm9yIGVhY2ggb25saW5lCj4gY3B1Lgo+IMKgwqDCoMKgwqDCoMKgwqAg
Ki8KPiBAQCAtODg5LDYgKzEwMTAsMjAgQEAgc3RhdGljIGludCBfX2luaXQgcmFwbF9wbXVfaW5p
dCh2b2lkKQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZ290byBvdXQxOwo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJhcGxfbW9k
ZWwtPmNvcmVfZXZlbnRzKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9
IHBlcmZfcG11X3JlZ2lzdGVyKCZyYXBsX3BtdXNfY29yZS0+cG11LAo+ICJwb3dlcl9wZXJfY29y
ZSIsIC0xKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkgewo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyoKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIElmIHJlZ2lzdHJhdGlv
biBvZiBwZXJfY29yZSBQTVUgZmFpbHMsCj4gY2xlYW51cCBwZXJfY29yZSBQTVUKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHZhcmlhYmxlcywgcmVz
ZXQgdGhlIHBlcl9jb3JlIGZsYWcgYW5kCj4ga2VlcCB0aGUKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHBvd2VyIFBNVSB1bnRvdWNoZWQuCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX3dhcm4oIlBlci1jb3Jl
IFBNVSByZWdpc3RyYXRpb24gZmFpbGVkCj4gKCVkKVxuIiwgcmV0KTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsZWFudXBfcmFwbF9wbXVzKHJhcGxf
cG11c19jb3JlKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJhcGxfbW9kZWwtPmNvcmVfZXZlbnRzID0gMFVMOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgcmFw
bF9hZHZlcnRpc2UoKTsKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gwqAKPiBAQCAtOTA2
LDUgKzEwNDEsOSBAQCBzdGF0aWMgdm9pZCBfX2V4aXQgaW50ZWxfcmFwbF9leGl0KHZvaWQpCj4g
wqDCoMKgwqDCoMKgwqDCoGNwdWhwX3JlbW92ZV9zdGF0ZV9ub2NhbGxzKENQVUhQX0FQX1BFUkZf
WDg2X1JBUExfT05MSU5FKTsKPiDCoMKgwqDCoMKgwqDCoMKgcGVyZl9wbXVfdW5yZWdpc3Rlcigm
cmFwbF9wbXVzX3BrZy0+cG11KTsKPiDCoMKgwqDCoMKgwqDCoMKgY2xlYW51cF9yYXBsX3BtdXMo
cmFwbF9wbXVzX3BrZyk7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHJhcGxfbW9kZWwtPmNvcmVfZXZl
bnRzKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBlcmZfcG11X3VucmVnaXN0
ZXIoJnJhcGxfcG11c19jb3JlLT5wbXUpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBjbGVhbnVwX3JhcGxfcG11cyhyYXBsX3BtdXNfY29yZSk7Cj4gK8KgwqDCoMKgwqDCoMKgfQoK
d2UgZG8gY2hlY2sgcmFwbF9wbXVzX2NvcmUgYmVmb3JlIGFjY2Vzc2luZyBpdCwgYnV0IHdlIG5l
dmVyIGNoZWNrCnJhcGxfcG11c19wa2cgYmVjYXVzZSB0aGUgcHJldmlvdXMgY29kZSBhc3N1bWVz
IGl0IGFsd2F5cyBleGlzdHMuCgpzbyBjb3VsZCB0aGVyZSBiZSBhIHByb2JsZW0gaWYgc29tZSBv
bmUgc3RhcnRzIHRoZSBwZXItY29yZSBwbXUgd2hlbgpwa2cgcG11IGlzIHVucmVnaXN0ZXJlZCBh
bmQgY2xlYW5lZCB1cD8KCnNheSwgaW4gcmFwbF9wbXVfZXZlbnRfaW5pdCgpLAoKaWYgKGV2ZW50
LT5hdHRyLnR5cGUgPT0gcmFwbF9wbXVzX3BrZy0+cG11LnR5cGUgfHwKICAgKHJhcGxfcG11c19j
b3JlICYmIGV2ZW50LT5hdHRyLnR5cGUgPT0gcmFwbF9wbXVzX2NvcmUtPnBtdS50eXBlKSkKCnRo
aXMgY2FuIGJyZWFrIGJlY2F1c2UgcmFwbF9wbXVzX3BrZyBpcyBmcmVlZCwgcmlnaHQ/Cgp0aGFu
a3MsCnJ1aQoKCj4gwqB9Cj4gwqBtb2R1bGVfZXhpdChpbnRlbF9yYXBsX2V4aXQpOwoK

