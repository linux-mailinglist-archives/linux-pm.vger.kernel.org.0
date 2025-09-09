Return-Path: <linux-pm+bounces-34249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99079B4AD02
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32B13B502E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5DE31A56D;
	Tue,  9 Sep 2025 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVsn1APm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F33054E4;
	Tue,  9 Sep 2025 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418958; cv=fail; b=rK+inGvqRNjF356gTaq+w85tvU7KZ5/nHiQdUwnoKVj8W4q/eE8hF0NmSEHZNoTposY6+m5tGL+Os871BiedZAjbkoCPMtKm/rNSb3FrMS39ndjj1i4PyDdqL1JNnDScoDXP3Ef4SZvire87vEYvqrnM34y9xB5yaZSpcLcd9PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418958; c=relaxed/simple;
	bh=wvri3i4EoGmkWA1g2qxdGwvvEA5awL6czaO8d4yh8/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cuEUSWwBWCHcaMp6qvGwdr0g73HXikRtVDrm05f7tZo75i6hfuzDX4gmWOLoSZCsYI/vpOe6o++sl2hs0YdF1rKLu5gvbDqoPAW7JgPk6j2mC8UEY1tagZf4Yq6i+/vD2jhvPL/XwqB9kBr0dMNJbemZji0DLtrKf/zzRPcH5dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVsn1APm; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757418956; x=1788954956;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wvri3i4EoGmkWA1g2qxdGwvvEA5awL6czaO8d4yh8/w=;
  b=VVsn1APmLkBVcAqH67MyJmMP+Opi4taRLp2aGoBNweaGpdm0qPQC+PUG
   xOHbbXPak/DdQER59cNrxrnpWGFnrG3SCpJHjk+2PO012nk1WBxOTEJAH
   yJMKplDj32bWDF4PyW+B4YOMuqBU1Ul4zc7s9tiCebDujwU9/PEF/seuN
   IoIFKx+xqi48HMLQ88/4HBAuFlqDTiFwrtNkFCLJw/M8KiskvdtpTlbkq
   2ekbSW6QcMLe152yVlnIkUv+aMu/+Xed6pnkrncK8pyV/myfmoFAmZCX5
   umI1184aKxtv1jBC43Lu6+B+zjenSd7Hwu76vjAZ0+9jNazQehrxM58/h
   A==;
X-CSE-ConnectionGUID: qnwe6RfARR+FRhTbIjNdFQ==
X-CSE-MsgGUID: ynYOmm43QbqWa315X5LCnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="77311392"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="77311392"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 04:55:56 -0700
X-CSE-ConnectionGUID: AXQbHMRjTmaW9XNL8Ew+dQ==
X-CSE-MsgGUID: E3jakrPORfi5c5ljgurV4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="173856546"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 04:55:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 04:55:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 04:55:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.77)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 04:55:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujlT2vknhoOgkuPwBNUXui8/z9ppZgg0tZw5bbIc5osOI4xAFf3+7mQOKtV89Q6bb5zn1//4Yw+K+4jQnVgdEIfjNvCR938X2DyiopZ4Ntiy6PxtsacqE8w7ghciFdMCh7W9CJSTTyyyWglvkxz4R4V/dmY0P4rmdFkatWdpGOrPDtc4eGNz8sik+cBxrpJdw/ftmJkMWp6I/z0iAhMnHzpaIfKb91EJqgaWPQtv1B93W6B6D+qv3y+ns+AZzegsM8TyaEbUJcum2RPgH6BEJJej+ilEfPLUg7BjhiHhBJoZjo1EZljd+zY7jHUaG8Ur7HPjzLqRe+xw6G1LkCK1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9gsCrZ2z0T6d6Taclp+JKUHbDCuu53HQ0jMIIDlzBw=;
 b=lgB/Din2niD8JKWuktsro6uEU64+CNWNTwOkdUiMbIBbEPYU/XFvppwk+j2S3DwXaTcBnY7Gt1UyBKLo+zWcjqmDS9U5N55W25BremUzcUSin1FLcEFt5LaTms6XUjSqHY65AnhpZc+biIQXBmSNcb/Lp9CVwIEpyPYTSuF6WJK3FdivHmGyPQidB19UuBJnXFFXBJSHBtsjO0WW1wzmAczKbPI7Hx4+Y5u5jtwlOPV0xsg6yfsBx0CgDqzkOC0oYwq9LVSGp+OLKlFsB5Bmm/ale2SMqHBJ44pnM1CoP/nlNMzrs0PvR+WImOqqVXpga3X6RFSaIYK5LmrqR2rW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by IA4PR11MB9420.namprd11.prod.outlook.com (2603:10b6:208:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:55:52 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 11:55:50 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham
	<myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH next] PM / devfreq: Fix double free in
 devfreq_event_add_edev()
Thread-Topic: [PATCH next] PM / devfreq: Fix double free in
 devfreq_event_add_edev()
Thread-Index: AQHcIXTC8R5Ib969AkabldST16fyeLSKvifA
Date: Tue, 9 Sep 2025 11:55:50 +0000
Message-ID: <LV3PR11MB876841044B211282EDADE00BF50FA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <aMABnic3SVnYMvGc@stanley.mountain>
In-Reply-To: <aMABnic3SVnYMvGc@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|IA4PR11MB9420:EE_
x-ms-office365-filtering-correlation-id: 16052836-549a-4ca0-841d-08ddef97d293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?3nmQjsvwCNVrVfrjndQzCJ41F3hVKVSfH1/eyIXH+tuj6qvayT2F62ALVcIF?=
 =?us-ascii?Q?zb3INe6HLAxOc3gEeUEVYslPqO/0HE4/wQ95zmAA8jRQ1LKJfj/6jpAMXmoI?=
 =?us-ascii?Q?4B7fer6AU165mXncA4uFsopr3U8Pvo2ZV7BI/eGvr7mEgjblwrtaBQcDtgR8?=
 =?us-ascii?Q?Z8UTJexLAuoJD4U95MI9gIeYs43ufcEctFhd1asaacMAuHbeHT8mRb4nnP0k?=
 =?us-ascii?Q?fwtSlNpQcbMvgQVqTcKKGWLezx7dwCFM/ZX+4PkT0cpffF3k1uVsjlmPt+E8?=
 =?us-ascii?Q?PvclPb+yI0J5WAZCz5F4xPKTUhofobzQDRLog8YomxSAEdtDyVxljrEAwLdP?=
 =?us-ascii?Q?jLGMSe/QFujtmBzAuxD94hwdA1nnNS8G9j7zpHCQ5Mx2I6UhG1GLhLbUgwSl?=
 =?us-ascii?Q?LO7jtsX+42shW6fP9L6r6qtzyC4dmz8BdsEj12g0vk3lYsiMxAb1mV4FJ/dM?=
 =?us-ascii?Q?YRUf74NC2faujW0rRi/m+EPY+CKkR0HGQ+4VMNhElnQIGqgMDXLjCI+pMCer?=
 =?us-ascii?Q?3oYbJUU9Iv3SNMNOJWid9OKcrFPqczgOhbl5lN6591T80V8HYQbjaeMP+azL?=
 =?us-ascii?Q?UInVP2EKgnlkWMphbgL53qR4iKBAujrdnwbqK6PmDOfMt51fY4EDksilXIH4?=
 =?us-ascii?Q?XjjM6cSvV+yr7PyfIJdRwnDY/km/k8GbZjEVZ+MlQXvHsfDGd87oZsUnp6nG?=
 =?us-ascii?Q?OUMcik0ySHUmIrGhMmJY1AIgzZ33bqzS79yddQ9c9Kubhh8bfgyh9hqfzS20?=
 =?us-ascii?Q?PnBatGtRM7Xv+lymkJ7nPljNtiQo3aof0B6NgLWAbPYI/oAb8yKXRcnVMRZx?=
 =?us-ascii?Q?f6FyX0PKV5vj46llZz6jj+KdvViEcTv2ccGd4GMlDqxECsk91LcTfPL9df4J?=
 =?us-ascii?Q?SiuCQHQry944/7PKyxNRLNxACAi4kIopsojeIj1WAp375PeCIO8uglepY//k?=
 =?us-ascii?Q?EBrBqOf8OfEisdT/8UOO8mdWLM0wA94be0tPUnciQkqV7e2zLB21z2q/E08w?=
 =?us-ascii?Q?FHtG//5EVa85gkmfQTWUcpUa1EXgMNb3wPA2zdlzzHuoTyNSwhG8OBX7TDRk?=
 =?us-ascii?Q?lhdWVg7hLfytgdHLYZY9VEzPrZ2ITIzeFl8rF+ZZszQrF6fZaGS/NwyVAer8?=
 =?us-ascii?Q?ApGOfBkEnc2ZNUZsVpk6tT1dLNki4i2q2X5tVwXyyqkabgy1KCwKt5FQWJuP?=
 =?us-ascii?Q?rDSrZvNgDuaLLpTIrrQd8BYFGKOtPG8JtxrhGK5cVdHROujXtRujAwXR8Ht/?=
 =?us-ascii?Q?cZfgBBL3/I2Ia13nGF/2g3ehyVck1GFJ5TUHkEcrJP7+8zTLchYfx7ZEBaTF?=
 =?us-ascii?Q?W0jFfdD4Qm0QLrnDGZ9TFCLPBIQGwdeW/Wnkx7lPMBtT1f160jhAqbJ5k52W?=
 =?us-ascii?Q?bu+IL+rdnTEsVZfOJe08QTUApeFM8f8HRh9KnjQEKYzoJZoLu4UD4S1KiUj/?=
 =?us-ascii?Q?q62WGsfmmeenpsrxI4sJrZr+iDA+9McLCzlek3ne+3Z93nB5xp+TbwvgPPsL?=
 =?us-ascii?Q?22mRv82iNtWJ6C4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pkMFGxOL5iW1R5LMXXLUZVemdc3wMWxoS32ardMz95G9xXQxgKeDJ1F6IQHn?=
 =?us-ascii?Q?CRiiKVVcJ5/H5yn57SeR9c5mdux2p/7VdvIkOb4n363GaJWtse7w+rU+3luu?=
 =?us-ascii?Q?TWhH3/o1A8Neq+yLGjo0HDxUkhqmiYXtRNg49CtIHe9kol80yAWG7SM7bjf9?=
 =?us-ascii?Q?r9D9Im+bdIPDwpENhQEmw39GqtBACTRKW6nzlEs4ddOeCnIbijOit7BkjRiL?=
 =?us-ascii?Q?EiZxA2eM3IJf3Ke2YWfEJoQ0x0Dwn0BskO+QdsanGqifWNSbFqvzJbXV0+aK?=
 =?us-ascii?Q?1ct51hPOjoGvUEAXAkZo6yuMjPDfBDT63vK2w1WDtUb8jQF4W6gu/CobQOnC?=
 =?us-ascii?Q?a8IvteSHePvFb/Iqyelx/0O0KiN4wBsNTWyBhCfKSPPXQGIjy4gZRQDGPXve?=
 =?us-ascii?Q?5p3FNnhDDxobvW78rExDH8PCcwatBjqCF963ihQ4H4QE7LJSbf4VauaWw1Rl?=
 =?us-ascii?Q?wc6Nu5jp1Vm/xzGNSDrEQYEYKJCAx7kMEZ9Ir22ejtn/04s5tKzJfTjfoA+h?=
 =?us-ascii?Q?YTaslbpBLeBpUN1Z5tPnxEfoZVDXc6fIO+puHaNrDhrzJYE9ZBxY+Thxfw3U?=
 =?us-ascii?Q?YxyHQv7NHEt+50RQXC3efChR/Q8hufLh4eha5Af3seop3pIomunLhNm62LNV?=
 =?us-ascii?Q?vTJeEtqpkIH8vkqWKKgc5qCOpESt5W/XXObjc8bhlD9QJGgf57y2dntDIoUW?=
 =?us-ascii?Q?7GJyCk7+uHO1hMNdjYgHkSC86K6iVUM4Ft+TGJiIvMTJHdPfQrIk6t4M87iM?=
 =?us-ascii?Q?Q3b5TVRAfQnoYhAoWaIXbzJPs2ja7l+SCUopKGWbruY1+qS3VdRbTB4Jyloh?=
 =?us-ascii?Q?trFdC4AhjH5mDarRpjQovXIKQ/mX0zfw28Q3t6D2OUGrDOsCQtfhTyVo2i7u?=
 =?us-ascii?Q?R12rh4m2FStDW7iaRfG6TM68LSBdzhTT578A7jxdLu3wsjzeaR0QO0ehN18l?=
 =?us-ascii?Q?2ozaq868v1KTng6PAs8fxUYXapUAtfnX69KAa0oelv2n+RcH8Lx3JfIeM3IK?=
 =?us-ascii?Q?r41dkwTUlM3Tzz+GCXkX+FSAHUy0Gstkw5Pc4rRkT4/LQCvteXyOz6Rx0X1A?=
 =?us-ascii?Q?tKGq4MEDOFV2E4G8/qmAqGXWZoPNC8zwer5wdJEWXoH40NUbkLVgijLidJqr?=
 =?us-ascii?Q?pANL55m5pN2etmrWnt1z1RR3En3C3U+64o8geu4x86RUC6/YfxF69m4WzWN3?=
 =?us-ascii?Q?QeHKbFFdAIEnl0LebxVOQoxLXLF8jZMOd50aB3SWIDTv25TjNyojUpwMp3Qc?=
 =?us-ascii?Q?G5buuG9b/iXKmNxGj3zXY7zpxZWD2DHRRE9YRedpQcVNjqKUba0SwjmdIbD1?=
 =?us-ascii?Q?sMUm5gNCmpp2fdHEagAO7TxRTeD6HwDsN9DdPoCPWR4MSj5NnJ3GpKu0atcs?=
 =?us-ascii?Q?GJOXTZq9V1zvUEm1H0pjgfySQ5ms6t5oxUzQs8SDs4Y7sGhFUkFd7ts5Hni5?=
 =?us-ascii?Q?nt9GdX4nPaqOdMDxcGArgv8lnF97L1vUPy14x+zlDrOmKdzYmUW33vbt9bv7?=
 =?us-ascii?Q?QXPcQkyLc5agw1huKca3i944L/7WaqhIvi3W/v6bfrzhlIoHyTo8XsjAR9aC?=
 =?us-ascii?Q?rsG2fb1h6XBsNomzdtBMz11zKWQ2t03d3ZJlxHdxOYept4aSMGOH/NVEY+2O?=
 =?us-ascii?Q?dClWDlatBEjaWwM+5wzoT9MwdOrJ2ey6VE5XV76B1f0O5+qK/blLJ6LOCPdD?=
 =?us-ascii?Q?0n9rgw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16052836-549a-4ca0-841d-08ddef97d293
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 11:55:50.8423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UwQKq3g/34dVtBMDb/7B2gLtRudx9mkkS3Jc0pmfC40AIC2pfnDnsrWjvS6pklSuxSKEgxAf9+YScH+qHXF3ClzU01OA1IDzwVwybtRDgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9420
X-OriginatorOrg: intel.com

Hi Dan,

On [Date], Dan Carpenter <dan.carpenter@linaro.org> wrote:
> The put_device() function calls devfreq_event_release_edev() which frees =
"evdev".  Calling kfree() again is a double free.
>=20
> Fixes: 430a1845c804 ("PM / devfreq: Fix memory leak in devfreq_event_add_=
edev()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/devfreq/devfreq-event.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-ev=
ent.c index 34406c52b845..70219099c604 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -328,7 +328,6 @@ struct devfreq_event_dev *devfreq_event_add_edev(stru=
ct device *dev,
> 	ret =3D device_register(&edev->dev);
> 	if (ret < 0) {
> 		put_device(&edev->dev);
> -		kfree(edev);
> 		return ERR_PTR(ret);
> 	}
> 	dev_set_drvdata(&edev->dev, edev);

Thank you for catching this double-free issue! You're absolutely right -=20
the release function handles the memory cleanup, making the explicit kfree(=
)=20
incorrect.

Reviewed-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Best regards,
Kaushlendra Kumar

