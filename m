Return-Path: <linux-pm+bounces-15369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9123995FC9
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 08:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182481C218E4
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 06:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4CA17798F;
	Wed,  9 Oct 2024 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENiU/Ht3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E3316C850;
	Wed,  9 Oct 2024 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455385; cv=fail; b=e5zyKdyB0Fu4qwAvybMm6UgTAwAetS00Lo0CReHfLCN/c6vLhwkIbWPGOFWdO4limt1PIZ+NY2YStP5wfE5Txi+d+/3VNYf5D/YEPvZBt0g5dRfdUTdh2sysS2OQ5N7jIX1Zfp+Svgh1F0QPT5EczAaVITwdZz2YV1qErBPEfpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455385; c=relaxed/simple;
	bh=e3kYb7DRFm9lB0PfPIEIcJxVaWCiNr+5j7UxgdtdGf4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QOmxhBqga0y1zFR6kO9chfKKfVkziVhP3I7hVJjSSTu2oql/K0UyAvq2Mg2YFAuHq+JCmDRpd5JU/PzrtsUPeqHczRzoTDKe+3KsD1Uswfi+6YHnVF7K+EZl3OSFuJ8jytkmdEJRsVRXvtRnyJONc0WBuoELPukT9zO0qhF09j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENiU/Ht3; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728455385; x=1759991385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e3kYb7DRFm9lB0PfPIEIcJxVaWCiNr+5j7UxgdtdGf4=;
  b=ENiU/Ht3F783AKIvQD6+zGHukl9n+mBySbp3DSAqanSmstuBao6MkCTg
   GNLmdsi4s6Cg7GqZrxfXBwe0hegahPqXslmtLt98Lzlk6ehgFVttTy1v+
   f3kanrb+VZfMtWl7yALpR0KnK2UnljPHN9mGULHkHctjIHOWT4bbBkFaP
   J78P9zGTC3zGZWzO6jtSfSlfpCEwCB7bUneGqkaij6glyEnn51vG9/kSM
   jpZkFjzdbr1wzlsxJqsKE/XEmqIxYRsBwcdbNUpAIB971AhHodoJ9C2eF
   WVorbYjkLMMi3wS12JK/n7XSDbnl+T+bCC4nRgzc52NkHoSMo7U4OVbdc
   A==;
X-CSE-ConnectionGUID: 8Vr9tv55SgydVRKXAtTltg==
X-CSE-MsgGUID: RrES2I1oSGqTt7K1jyeIXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="45199793"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="45199793"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 23:29:44 -0700
X-CSE-ConnectionGUID: 2w512MK4R4atbStcODAO5A==
X-CSE-MsgGUID: lP70DsE3RWivnn4gIrdffw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76255806"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 23:29:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 23:29:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 23:29:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 23:29:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 23:29:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5vUNvcvQWsc7ysajlKIMstxtnmzaKoYvOpTzufHkaGP63wkiauZtAiBHQs2zMnM9+UlskJOdSPO1jLaU+KW88FagcKoOQc5ukUc/hnWMr56f4Y7v1V6+bhEqvHVCh56dgt32wkWrvYfgvou3WI8ncqJe+8Ou2w2Pb2VcxAsGMDI9WqnqQxip6ymWAzPJck2gOBGs6qo9kyhMb2hoE8Q8n5RF0KEeqZaQuHkwbizzjG8x9OF7s6Kw6boFdkhKfUeRr+QAZv1GyxtNDbEOYlrscuTl2N7jpXDxu+ORP+agDj+t55WbrY6ovCebTmJ96ayCedQAd21i5BDJBpB3ZV/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3kYb7DRFm9lB0PfPIEIcJxVaWCiNr+5j7UxgdtdGf4=;
 b=qI5LPlNAfbJaFbFLpeAiSB6MHLTTs/yv2A/i+vFFeAx9zdQK0nowlcoxR6YS43iRVFaLV0Ue+dfPS5BncEZdifMRSKtxYv6peLdbclhiH6TKzxnkgbMT+q6+0vxqWfYfV/OodhjadqE9/VtL+7gT6bHtji/az4zdHgf7AUqc7gSJyxfxuIQJw9AmIcF55BUG6X2Fb1Fc9SDxglBrtTRw4M+j2w2z4DXoVJdCtPkSFR2TZWsbHAUXAtIjaDDcuuNVgFUgjlGoei4FK7sSuowAq0UQQckdI7tkGqszeGsQIA2XkeztUgzo+DRwSkCb7t1gvHpoz42zH1URlT6uHDZzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 06:29:29 +0000
Received: from DS0PR11MB7457.namprd11.prod.outlook.com
 ([fe80::6078:57ee:53ba:57a5]) by DS0PR11MB7457.namprd11.prod.outlook.com
 ([fe80::6078:57ee:53ba:57a5%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 06:29:29 +0000
From: "Gopal, Saranya" <saranya.gopal@intel.com>
To: duanchenghao <duanchenghao@kylinos.cn>, Alan Stern
	<stern@rowland.harvard.edu>
CC: Hongyu Xie <xy521521@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "niko.mauno@vaisala.com"
	<niko.mauno@vaisala.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
	"stanley_chang@realtek.com" <stanley_chang@realtek.com>, "tj@kernel.org"
	<tj@kernel.org>, Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: RE: [PATCH] USB: Fix the issue of task recovery failure caused by USB
 status when S4 wakes up
Thread-Topic: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Thread-Index: AQHbAAnZn0I78z2Rm0CO/hcA6/JbFLJQy8GMgAHlSICAANSWAIAAw06AgAJWrQCADn2pgIAB8KqAgBbZsYCAADryQA==
Date: Wed, 9 Oct 2024 06:29:29 +0000
Message-ID: <DS0PR11MB745752338420F45FC2E0A399E37F2@DS0PR11MB7457.namprd11.prod.outlook.com>
References: <20240906030548.845115-1-duanchenghao@kylinos.cn>
	 <1725931490447646.3.seg@mailgw.kylinos.cn>
	 <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
	 <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
	 <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
	 <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
	 <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
	 <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>
	 <84a4f66a-5b0e-46a8-8746-be6cd7d49629@rowland.harvard.edu>
 <fa347849defa66a7d4af23ac6317ae5b37357ea4.camel@kylinos.cn>
In-Reply-To: <fa347849defa66a7d4af23ac6317ae5b37357ea4.camel@kylinos.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7457:EE_|DM4PR11MB6357:EE_
x-ms-office365-filtering-correlation-id: 21d560dc-4ab0-43ca-319c-08dce82bba85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cnlpQ0ZlcXdob0JPdit5d1AyM3VLbW9DaGZCU0pxK3BLbEFqRVNKZWFkbGZV?=
 =?utf-8?B?WVdmKytRbXVZRTk0c0ZpdHNrOHczaFRBb2RrcCtDZ0ltaHlMMkEwY0NrVUZX?=
 =?utf-8?B?QVdRZmozMkNUK2FESlA5QXBFZm9hN3BPRDVrUm1DSFRFYmtjelF1eUZBczNT?=
 =?utf-8?B?Mzh4dkdDMzBDdDFUM21RNjVDQ0szQlA1UWFRd2xxTlAvNDFUV21PM0FQVFl1?=
 =?utf-8?B?NldWVzlZVThEN1NCRGsrTWhUUGxkU0Y5WGV3MDEwSVdoU2lNbExNZEZLWXE3?=
 =?utf-8?B?Y3RIRzRHeTBoQVFXSC84UnZoRFFzaUR0dHBNZHZoeG9PVVhQZkRMeUZpNXRt?=
 =?utf-8?B?Sk81SmJaNm50L1RrSXh1a2xXRkwySUYyeXgxNk0ycGduTmVUZmVUb0RDeVA0?=
 =?utf-8?B?Zlp6RmcyWmkzM0hPVDR5UHc2aXZ6UmZlSGY4alNZTDZVaXJ2NUkySzE0TmNG?=
 =?utf-8?B?Skw3YXZBOTVEQUJkU0gvSWlOMDFsTmF5Nm5QMCtmQ1RoODdCclZuVVp4UVRH?=
 =?utf-8?B?ZW56RkNRaTBEWk03ZVN3YVc1RTNuVFo1OWR0bnVLUWtQTFkyNlpTWWR5UkIx?=
 =?utf-8?B?d3J6UVZSalkrRGpUZk1LOEVqL1N6dTl5MTZJZ081ckNGblgxYzVQd0F2QTlZ?=
 =?utf-8?B?SDduN09qTEhjU2x5bFlVQ3pWbHhOVFpXTW54aXBtQVcwM1VON1UwQUpoRVZa?=
 =?utf-8?B?ekxwWGJqNE4ydVBkdm1KTkx6c21EYTRoaDNweE1ZMmxySm14S2tUUzQ2NWlC?=
 =?utf-8?B?NzJzMUR4a21LNGl2QkVjdE1MaHlreUVXZW43QXRtR2tjVXpyN0pUY2NYOHBE?=
 =?utf-8?B?M3ZLeTRTRDZKWndwcXltVVZ1YUZVNHVCL2pLWU9qaWdwcmNqNC9GWWcwUmJr?=
 =?utf-8?B?SFBibnIxbGpQMkxHUlVRb2U5Znc4MUU2S3VNOUxuUTNrTHJMSUxXRUswSy9i?=
 =?utf-8?B?Tm9vZm91eCtQbWFNeFE2UndMWTVqRVhDK3ZyNU03Vk5zc1cxMC9XNmlHQTBH?=
 =?utf-8?B?RWhvQ0tOdmo2by9zS0VFU3hDS3JoR3ErM21hV0pkcm5KOHA5YXN2cVFmaUN4?=
 =?utf-8?B?WWlNZ1U0QXF0YUxzaUN2UUhKL0RocWErOXZKY1g0YVk3djRiSjdyeVcvVXN4?=
 =?utf-8?B?c0QvMHAycnEveTFMN2srVVA3K1pvaWZmU1NGT3dQS0NQNnNzWDIrM0M5QkFZ?=
 =?utf-8?B?YW9yajZUeWVRZWtCNm04N2Z5T2JDcHZhZ1pQMDdSYjhhNjVtUHVPUjIzOG9I?=
 =?utf-8?B?T2pCNldGMGdOenJtRTFwNlY0WmlSd2dMVWNZTFc2MUxwZkZXMnhiZ0M4ZjQ3?=
 =?utf-8?B?NXZZcGhJQmZJRlB2LzI3Y1NvaHJzbWdNNHV5UGJ4OWwzM1JVejFCcWVJbVFx?=
 =?utf-8?B?UU5veFhZdFZoRXlzaTNwQSsxRVdWU2E5clhFSXNoVVUveTNZK2lvcHIyWGZB?=
 =?utf-8?B?NWF0M2FoQ2ZSWlJ0S3ZFZ2l2azhHVUdYczFBSURwditSZ29DTnBBSmdieDZB?=
 =?utf-8?B?N1BSNk5lNm5jT0dZZ1VVSVpxTG9ZRUFMQnU4K05LU051OEJycUljdFlZV3E5?=
 =?utf-8?B?c1U0eHRiWll4WEZaTHBaUllXUHpnUVVvaVdxaWRXV3RBTjNWYThyZlFLV3VU?=
 =?utf-8?B?aWtZRU9OdVN2RGVjQlBzMjRGZzlCeVZBcXYwbWNpUjI4UmE5bzY0Zzl4K0R2?=
 =?utf-8?B?L0N2ckNERHN4VEhJdEJlT2JhWmpRaWI4RkppNEl6NTN6VkxEb0psQWpWaXJi?=
 =?utf-8?B?YUM4cEpmQXk4VXpJb0l3VEpKb0VlZWU4RURyVjJRKzZpbnR4ajdEUGg4eDBj?=
 =?utf-8?Q?H/it1qGsKSadMOJpuweGm4fxmaYYVlSCDDv3A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7457.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjNLU1V6ZCtqcm11NFN1SGY2bzFPdkFINGZXVit2R0E4cDlZRFZSblpmdlJ4?=
 =?utf-8?B?dXhqMzNmMTYrVE9NSzlBQ1FmNTduVEpvNnpBMURYd1dBZy9iOHRCS3RDWG43?=
 =?utf-8?B?MzVSdW1mVW04MHNEQzNYb1pGUVR6OGhuUG1wTGFlNUQ1cURhZ1VBU3FxV1RN?=
 =?utf-8?B?dXZVdU80UGZhSTAwUWZqdlVTcVJMNU8yeVpEVXRmUXk4cW1WWFJvRS9OTnBv?=
 =?utf-8?B?WjhNdWtUSkh3R29JWnBQRUp2OGdNcXZoaTR2T2pxTmJHNGdoWnJUUjlYM3E3?=
 =?utf-8?B?QTE3V3dPU1lUNzV6Mlg4eGNYVmQ5bGs1d0NFZWR1WGxTbFJlVXZxNTZoTmNr?=
 =?utf-8?B?aHgvYnFZazhqWTc3NG5YM2FnVldZSUdlL2xPY0JQZGZORXBsYld2Z2FUTTla?=
 =?utf-8?B?TlF4aVR3dE05UjVOUjQrWldnTnArbDJ3MjdiYm9ZK3E3VzVSL00xMmduTXo0?=
 =?utf-8?B?WUl6WC9LVkU1UWMydkFHbzltem1KbDljcGV2dTY1MjNUQ212SWVhTGwwMWxN?=
 =?utf-8?B?RzBuQ3Azclc3aUNJeTJVQU90L3RvSHRPRlFaZmg2ZXdDNVArWU04ZlBZaDNx?=
 =?utf-8?B?R3owYTZCSFJxZHpYa2FySjg0bFlna1FXaGc0R2J2cHRNWFVnTXVGSjFLMGZv?=
 =?utf-8?B?Tm9tV0RkSFhXOEV3cHI1QkswbitpTDVzZHc4akZwOWFYZ1dhZUFhS09yQ0Nm?=
 =?utf-8?B?NWp0SzF5TEZseE1YdGdYd3VUb0crQ3N0WUpiOFNrMk9CeDQ5UE5BVW00RzNI?=
 =?utf-8?B?bUFpajRjLy8xb1QvVko2ZW1OS1FjcmxyQTI1bUhSL1h0QnlMU3dkSjc5TlJr?=
 =?utf-8?B?dFNvSm0wUmxvM3FCYjBYTC9TV3NSczJheHlacEE3emgrQ0ZxMG11d29PaXgy?=
 =?utf-8?B?VkRITE13Zmp3N0tvOFRwSHVIY0JhNCtiNGNYems0Szc4S3dxcVBPTTlISmRE?=
 =?utf-8?B?WUdjK2VNVXBFRDlydDJWbzNGWmpMZEx2TEFTc1lqUkFlUG8wVWp1dmFaZXZO?=
 =?utf-8?B?b3FBZmZKR3lrRGpyQ1VZK1libnhzazdWRjN0MHIwNFRKMng3ckJscldNTTRN?=
 =?utf-8?B?OG9qM0cvY1pQVTFFK2FYM1RkVEFoVktPZGduTjQzQVVSUGp6cG1hRm1TQjN5?=
 =?utf-8?B?L0ZKNm1ueDczdytSR1JyWm5zdEZiZW10UnY0TjlEOWsvZWN6SjdqVU14L1Er?=
 =?utf-8?B?UVZzVzB4eTN2dll0TDlSYU1rdnZXZ1Q3QW00cXRIbnNmV2hLbU11ZVN0bVpS?=
 =?utf-8?B?ZFd2THJsOXdJNmg2eG90dTYvemJkZnBaVFdvMGFtSGJhc0lBZWpBZXpPOVNS?=
 =?utf-8?B?OEp0Ym1zay9uTE5FV3BMUmE0V0tjRkFjazJkYkRMeFlsN2wyLyt0Z29jR05H?=
 =?utf-8?B?Y1NSZmNKbHQrWm13aDFQbjRSQmhKNHQweFczYkJETnFtUXY2OHRGaXNGWTNT?=
 =?utf-8?B?UWMraEdMdEd5MHZYZ1hXZ29ZYzBZTjNNVDVyQ2JwTnpCWHpIZG1yNnl5YVhH?=
 =?utf-8?B?T0JlanlpdFR1bDlPOGI1NTZTdEsrZ3ZqNEZoSVZJVlpOTVFyWEVrYUJuby9w?=
 =?utf-8?B?SnR5N0tsSjZjN0xCZU1uZkFaQjFCUEVIS2daclpSeGVncEhWODAwekxodExv?=
 =?utf-8?B?NDZCOFdoTHFrZFRVNmFzQmRueGpPRGI1SGlqcXAzcFhQRjk0cGk0dWlvNVcw?=
 =?utf-8?B?bStMZ0Z0REloREF5dHVUeW4yejQ4ZGVEQ05PVzZld2lpbThsWUhHaUtPVXhB?=
 =?utf-8?B?YWxrQlptaW1Gb21lbDVJenY2ZVJBdG9rdlVaM29rQkJjczJJdlNrSnlJekFP?=
 =?utf-8?B?b2dpeVFycy9aUmRhQnIxSFgyb0RVS1BVUDB6OTB2bnlNOUJKWW1teVFVemlJ?=
 =?utf-8?B?L2haUnRkWUdFeVNLYmsrN1E4QVJHcGR4Nzh1cTY5ZHdZOTVYK1lhOUVkSkxX?=
 =?utf-8?B?M1F0dXpmMjFDd2ZIRFJTcjh4RmYxNnA4bmVwUCsxYmNpSEpJWk0vSFFxWkht?=
 =?utf-8?B?dFVacXRqNkV5NmJTR21LTDhRNHppUUNxaWpJUHdoRStocHVIUTVBZlZVYjEy?=
 =?utf-8?B?MHZzNVV3V3BFVEFlMjlkZVZ2KzNKeFdPdDR4bUd6Mmt6WWJrRUllaUIxdlB5?=
 =?utf-8?Q?ctK9MO1q98kOQhLwx5M4WJs7K?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7457.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d560dc-4ab0-43ca-319c-08dce82bba85
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 06:29:29.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POZ9xaSkhejbBDeHuLDTi1+5Ak3ZZcOr3HxFLBKaekRyeLBTh1TfN2bfg7ivDjAv6gFEA4sb7wWV/Eo81VrLFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

SGkgRHVhbmNoZW5naGFvLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IGR1YW5jaGVuZ2hhbyA8ZHVhbmNoZW5naGFvQGt5bGlub3MuY24+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgT2N0b2JlciAwOSwgMjAyNCA4OjA1IEFNDQo+IFRvOiBBbGFuIFN0ZXJuIDxzdGVybkByb3ds
YW5kLmhhcnZhcmQuZWR1Pg0KPiBDYzogSG9uZ3l1IFhpZSA8eHk1MjE1MjFAZ21haWwuY29tPjsN
Cj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LQ0KPiBwbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5v
cmc7DQo+IG5pa28ubWF1bm9AdmFpc2FsYS5jb207IHBhdmVsQHVjdy5jejsNCj4gc3RhbmxleV9j
aGFuZ0ByZWFsdGVrLmNvbTsgdGpAa2VybmVsLm9yZzsgSG9uZ3l1IFhpZQ0KPiA8eGllaG9uZ3l1
MUBreWxpbm9zLmNuPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBVU0I6IEZpeCB0aGUgaXNzdWUg
b2YgdGFzayByZWNvdmVyeSBmYWlsdXJlIGNhdXNlZA0KPiBieSBVU0Igc3RhdHVzIHdoZW4gUzQg
d2FrZXMgdXANCj4gDQo+IEhpIEFsYW4sDQo+IA0KPiBUaGVzZSBhcmUgdHdvIHBhdGNoZXMsIGVh
Y2ggYWRkcmVzc2luZyB0aGUgc2FtZSBpc3N1ZS4gVGhlIGN1cnJlbnQNCj4gcGF0Y2ggaXMgYSBk
aXJlY3Qgc29sdXRpb24gdG8gdGhlIHByb2JsZW0gb2YgdGhlIGludGVycnVwdCBib3R0b20gaGFs
Zg0KPiBiZWluZyBmcm96ZW4uIFRoZSBwYXRjaCB5b3UgcmVwbGllZCB3aXRoIGlzIGFub3RoZXIs
IGFsdGVybmF0aXZlDQo+IHNvbHV0aW9uIHRvIHRoZSBzYW1lIHByb2JsZW0uIFBsZWFzZSByZXZp
ZXcgd2hpY2ggc29sdXRpb24gaXMgbW9yZQ0KPiBzdWl0YWJsZSwgb3IgaWYgdGhlcmUgYXJlIGFu
eSBvdGhlciByZXZpc2VkIHByb3Bvc2Fscy4NCj4gDQo+IA0KPiBQbGVhc2UgcmV2aWV3IHRoZSBw
YXRjaCBJIG1lbnRpb25lZDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzBhNGRjNDZh
ZTc2N2MyOGRkMjA3YWUyOTUxMWVkZTc0N2YNCj4gMDU1MzlhLmNhbWVsQGt5bGlub3MuY24vDQo+
IA0KDQpJIHdhcyBhYmxlIHRvIHRlc3QgMTUwMCBTNCBjeWNsZXMgaW4gbXkgc3lzdGVtIHdpdGgg
eW91ciBwYXRjaCBhbmQgYWxsIGN5Y2xlcyBwYXNzZWQgd2l0aCB5b3VyIHBhdGNoLg0KSSB3YXMg
ZmFjaW5nIGFuIGlzc3VlIHNpbWlsYXIgdG8gd2hhdCBLYWktSGVuZyB3YXMgb2JzZXJ2aW5nIGlu
IHRoZSBiZWxvdyBtYWlsIHRocmVhZDoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvYjg1
NTNkZWYtMTllYS00MWQ1LWI2NjUtNDg1OWRkYjdiNmQ1QHJlZGhhdC5jb20vVC8NCkhlIHdhcyBv
YnNlcnZpbmcgaXNzdWVzIGR1ZSB0byBVU0IgdG91Y2hzY3JlZW4uIEFuZCBteSBpc3N1ZSB3YXMg
ZHVlIHRvIEJsdWV0b290aCBVU0IgY29udHJvbGxlci4NCkJ1dCwgeEhDSSBlcnJvciBsb2dzIHdl
cmUgZXhhY3RseSBzYW1lLg0KSXQgbG9va3MgbGlrZSB5b3VyIHBhdGNoIGlzIGZpeGluZyBib3Ro
IHRoZSBpc3N1ZXMuDQpJdCB3b3VsZCBiZSBuaWNlIHRvIHNlZSB0aGlzIHBhdGNoIGxhbmQgdXBz
dHJlYW0uDQoNClRoYW5rcywNClNhcmFueWENCg0KPiBEdWFuY2hlbmdoYW8NCj4gDQo+IOWcqCAy
MDI0LTA5LTI05pif5pyf5LqM55qEIDA5OjM4IC0wNDAw77yMQWxhbiBTdGVybuWGmemBk++8mg0K
PiA+IE9uIE1vbiwgU2VwIDIzLCAyMDI0IGF0IDA0OjAwOjM1UE0gKzA4MDAsIGR1YW5jaGVuZ2hh
byB3cm90ZToNCj4gPiA+IEhpIEFsYW4sDQo+ID4gPg0KPiA+ID4gRG8geW91IHRoaW5rIHRoaXMg
cGxhbiBpcyBmZWFzaWJsZSwgb3IgaXMgdGhlcmUgYW55IHVuY2xlYXIgcGFydCBpbg0KPiA+ID4g
bXkNCj4gPiA+IGRlc2NyaXB0aW9uIHRoYXQgbmVlZHMgdG8gYmUgc3VwcGxlbWVudGVkPw0KPiA+
DQo+ID4gSSBhcG9sb2dpemUgZm9yIG5vdCBnZXR0aW5nIGJhY2sgdG8geW91IGVhcmxpZXIgLS0g
SSd2ZSBiZWVuDQo+ID4gaW5jcmVkaWJseQ0KPiA+IGJ1c3kgZHVyaW5nIHRoZSBsYXN0IGZldyB3
ZWVrcy4NCj4gPg0KPiA+IEkgc3RpbGwgaGF2ZW4ndCBoYWQgdGltZSB0byBnbyBvdmVyIHRoaXMg
dGhyb3JvdWdobHkuwqAgSWYgSSBkb24ndA0KPiA+IHJlc3BvbmQgYnkgdGhlIGVuZCBvZiB0aGlz
IHdlZWssIHJlbWluZCBtZSBhZ2Fpbi4NCj4gPg0KPiA+IEFsYW4gU3Rlcm4NCj4gPg0KPiA+ID4g
ZHVhbmNoZW5naGFvDQo+ID4gPg0KPiA+ID4NCj4gPiA+IOWcqCAyMDI0LTA5LTE05pif5pyf5YWt
55qEIDEwOjQzICswODAw77yMSG9uZ3l1IFhpZeWGmemBk++8mg0KPiA+ID4gPiBGcm9tOiBIb25n
eXUgWGllIDx4aWVob25neXUxQGt5bGlub3MuY24+DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+
IEhpIEFsYW4sDQo+ID4gPiA+IE9uIDIwMjQvOS8xMiAyMzowMCwgQWxhbiBTdGVybiB3cm90ZToN
Cj4gPiA+ID4gPiBPbiBUaHUsIFNlcCAxMiwgMjAyNCBhdCAxMToyMToyNkFNICswODAwLCBkdWFu
Y2hlbmdoYW8NCj4gd3JvdGU6DQo+ID4gPiA+ID4gPiDlnKggMjAyNC0wOS0xMeaYn+acn+S4ieea
hCAxMDo0MCAtMDQwMO+8jEFsYW4gU3Rlcm7lhpnpgZPvvJoNCj4gPiA+ID4gPiA+ID4gT24gVHVl
LCBTZXAgMTAsIDIwMjQgYXQgMDU6MzY6NTZQTSArMDgwMCwNCj4gZHVhbmNoZW5naGFvDQo+ID4g
PiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IFM0IHdha2V1cCByZXN0b3JlcyB0aGUg
aW1hZ2UgdGhhdCB3YXMgc2F2ZWQgYmVmb3JlIHRoZQ0KPiA+ID4gPiA+ID4gPiA+IHN5c3RlbQ0K
PiA+ID4gPiA+ID4gPiA+IGVudGVyZWQNCj4gPiA+ID4gPiA+ID4gPiB0aGUgUzQgc2xlZXAgc3Rh
dGUuDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoCBTNCB3YWtpbmcg
dXAgZnJvbSBoaWJlcm5hdGlvbg0KPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgID09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQo+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqAga2VybmVsIGluaXRp
YWxpemF0aW9uDQo+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqAgfA0KPiA+ID4gPiA+ID4gPiA+IMKg
wqDCoMKgIHYNCj4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoCBmcmVlemUgdXNlciB0YXNrIGFuZCBr
ZXJuZWwgdGhyZWFkDQo+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqAgfA0KPiA+ID4gPiA+ID4gPiA+
IMKgwqDCoMKgIHYNCj4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoCBsb2FkIHNhdmVkIGltYWdlDQo+
ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqAgfA0KPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgIHYNCj4g
PiA+ID4gPiA+ID4gPiDCoMKgwqDCoCBmcmVlemUgdGhlIHBlcmlwaGVyYWwgZGV2aWNlIGFuZCBj
b250cm9sbGVyDQo+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqAgKENoZWNrIHRoZSBIQ0RfRkxBR19X
QUtFVVBfIFBFTkRJTkcgZmxhZyBvZg0KPiB0aGUgVVNCLg0KPiA+ID4gPiA+ID4gPiA+IElmDQo+
ID4gPiA+ID4gPiA+ID4gaXQgaXMNCj4gPiA+ID4gPiA+ID4gPiBzZXQsDQo+ID4gPiA+ID4gPiA+
ID4gwqDCoMKgwqDCoCByZXR1cm4gdG8gRUJVU1kgYW5kIGRvIG5vdCBwZXJmb3JtIHRoZSBmb2xs
b3dpbmcNCj4gPiA+ID4gPiA+ID4gPiByZXN0b3JlDQo+ID4gPiA+ID4gPiA+ID4gaW1hZ2UuKQ0K
PiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBXaHkgaXMgdGhlIGZsYWcgc2V0IGF0IHRoaXMg
cG9pbnQ/wqAgSXQgc2hvdWxkIG5vdCBiZTsgdGhlDQo+ID4gPiA+ID4gPiA+IGRldmljZSBhbmQN
Cj4gPiA+ID4gPiA+ID4gY29udHJvbGxlciBzaG91bGQgaGF2ZSBiZWVuIGZyb3plbiB3aXRoIHdh
a2V1cCBkaXNhYmxlZC4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoaXMgaXMgY2hlY2sg
cG9pbnQsIG5vdCBzZXQgcG9pbnQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBZZXMsIEkga25vdyB0
aGF0LsKgIEJ1dCB3aGVuIHRoZSBmbGFnIHdhcyBjaGVja2VkLCB3aHkgZGlkIHRoZQ0KPiA+ID4g
PiA+IGNvZGUNCj4gPiA+ID4gPiBmaW5kDQo+ID4gPiA+ID4gdGhhdCBpdCB3YXMgc2V0P8KgIFRo
ZSBmbGFnIHNob3VsZCBoYXZlIGJlZW4gY2xlYXIuDQo+ID4gPiA+IE1heWJlIGR1YW5jaGVuZ2hh
byBtZWFucyB0aGlzLA0KPiA+ID4gPiBmcmVlemVfa2VybmVsX3RocmVhZHMNCj4gPiA+ID4gbG9h
ZF9pbWFnZV9hbmRfcmVzdG9yZQ0KPiA+ID4gPiDCoMKgIHN1c3BlbmQgcm9vdGh1Yg0KPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHQgb2NjdXJyZWQNCj4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHVzYl9oY2RfcmVzdW1lX3Jvb3RfaHViDQo+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc2V0DQo+ID4gPiA+IEhDRF9GTEFHX1dBS0VVUF9QRU5ESU5HDQo+ID4g
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcXVldWVfd29yayAvLyBmcmVlemVkDQo+ID4g
PiA+IMKgwqAgc3VzcGVuZCBwY2kNCj4gPiA+ID4gwqDCoMKgwqAgcmV0dXJuIC1FQlVTWcKgIGJl
Y2F1c2UgSENEX0ZMQUdfV0FLRVVQX1BFTkRJTkcNCj4gPiA+ID4NCj4gPiA+ID4gU28gczQgcmVz
dW1lIGZhaWxlZC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBJcyB5b3VyIHByb2JsZW0gcmVs
YXRlZCB0byB0aGUgb25lIGRpc2N1c3NlZCBpbiB0aGlzIGVtYWlsDQo+ID4gPiA+ID4gPiA+IHRo
cmVhZD8NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtdXNiL2Q4NjAwODY4LTZlNGItNDVhYi0NCj4gYjMyOC04NTJiNmFjOGVjYjVAcm93
bGFuZC5oYXJ2YXJkLmVkdS8NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gV291bGQgdGhl
IHN1Z2dlc3Rpb24gSSBtYWRlIHRoZXJlIC0tIGkuZS4sIGhhdmUgdGhlIHhoY2ktDQo+ID4gPiA+
ID4gPiA+IGhjZA0KPiA+ID4gPiA+ID4gPiBpbnRlcnJ1cHQgaGFuZGxlciBza2lwIGNhbGxpbmcg
dXNiX2hjZF9yZXN1bWVfcm9vdF9odWIoKQ0KPiBpZg0KPiA+ID4gPiA+ID4gPiB0aGUNCj4gPiA+
ID4gPiA+ID4gcm9vdA0KPiA+ID4gPiA+ID4gPiBodWINCj4gPiA+ID4gPiA+ID4gd2FzIHN1c3Bl
bmRlZCB3aXRoIHdha2V1cCA9IDAgLS0gZml4IHlvdXIgcHJvYmxlbT8NCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBTa2lwcGluZyB1c2JfaGNkX3Jlc3VtZV9yb290X2h1YigpIHNob3VsZCBnZW5l
cmFsbHkgYmUNCj4gPiA+ID4gPiA+IHBvc3NpYmxlLA0KPiA+ID4gPiA+ID4gYnV0DQo+ID4gPiA+
ID4gPiBpdCdzIGltcG9ydGFudCB0byBlbnN1cmUgdGhhdCBub3JtYWwgcmVtb3RlIHdha2V1cA0K
PiA+ID4gPiA+ID4gZnVuY3Rpb25hbGl0eQ0KPiA+ID4gPiA+ID4gaXMgbm90DQo+ID4gPiA+ID4g
PiBjb21wcm9taXNlZC4gSXMgaXQgSFVCX1NVU1BFTkQgdGhhdCB0aGUgaHViIHlvdSBhcmUNCj4g
cmVmZXJyaW5nDQo+ID4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+ID4gaXMgaW4NCj4gPiA+ID4gPiA+
IGEgc3VzcGVuZGVkIHN0YXRlPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSBkb24ndCB1bmRlcnN0
YW5kIHRoaXMgcXVlc3Rpb24uwqAgaHViX3F1aWVzY2UoKSBnZXRzIGNhbGxlZA0KPiA+ID4gPiA+
IHdpdGgNCj4gPiA+ID4gPiBIVUJfU1VTUEVORCB3aGVuIHRoZSBodWIgZW50ZXJzIGEgc3VzcGVu
ZGVkIHN0YXRlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gWW91IGFyZSBjb3JyZWN0IGFib3V0IHRo
ZSBuZWVkIGZvciBub3JtYWwgcmVtb3RlIHdha2V1cCB0bw0KPiB3b3JrDQo+ID4gPiA+ID4gcHJv
cGVybHkuwqAgVGhlIGludGVycnVwdCBoYW5kbGVyIHNob3VsZCBza2lwIGNhbGxpbmcNCj4gPiA+
ID4gPiB1c2JfaGNkX3Jlc3VtZV9yb290X2h1YigpIGZvciBwb3J0IGNvbm5lY3Qgb3IgZGlzY29u
bmVjdA0KPiA+ID4gPiA+IGNoYW5nZXMNCj4gPiA+ID4gPiBhbmQgZm9yDQo+ID4gPiA+ID4gcG9y
dCBvdmVyY3VycmVudCBjaGFuZ2VzICh3aGVuIHRoZSByb290IGh1YiBpcyBzdXNwZW5kZWQNCj4g
d2l0aA0KPiA+ID4gPiA+IHdha2V1cCA9DQo+ID4gPiA+ID4gMCkuwqAgQnV0IGl0IHNob3VsZCBf
bm90XyBza2lwIGNhbGxpbmcNCj4gdXNiX2hjZF9yZXN1bWVfcm9vdF9odWIoKQ0KPiA+ID4gPiA+
IGZvcg0KPiA+ID4gPiA+IHBvcnQNCj4gPiA+ID4gPiByZXN1bWUgZXZlbnRzLg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gQWxhbiBTdGVybg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEhvbmd5
dSBYaWUNCj4gPiA+DQo+IA0KDQo=

