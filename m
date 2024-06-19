Return-Path: <linux-pm+bounces-9560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B1690E711
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 11:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1C01F2152F
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 09:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4872980626;
	Wed, 19 Jun 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDlBg+Br"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747C13398B;
	Wed, 19 Jun 2024 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789355; cv=fail; b=M4JElb/NEHb4POMyuxNVwoGZtV11fzgUyf+rVb4d2m9NI3pQbvdW6UIQfwv6ze4mgj4BLDS92StLPUw8CvjXUgAkSk7d/9fDeVeNBH7yLB4ahNysfrzOjVPL/Xp7UvsC1mXTwj7nNw/7X73bzUwgdoWyuJK3xX3jjhTcttYEuH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789355; c=relaxed/simple;
	bh=XehckBhFyOk1XMRkeMZPniFligsk3ix5YpMiJcaZTro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l5i6QCh66YMAAcUQsGflLK6S2uF7KutuVtnDN7P6iNL4dakAhQBGIfcZONDf/dBli9lFCdUrRfqBdknLaHGWnE4YnMv3tGRmjWjy1XOWZMzX3sVfpvYbL94bMGtsCYNMfwpehHYj1hQwYWsIpvjurfgNH4BpKmjTbOa98VhRyOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDlBg+Br; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718789354; x=1750325354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XehckBhFyOk1XMRkeMZPniFligsk3ix5YpMiJcaZTro=;
  b=SDlBg+Br4QV1O8FNJISSJd1ArAEetE7nEGKAorGHwP+Wy72bwQddg9at
   yj37gFcvBYbImbh+Rg9rZbzEHmV6Q65Hb6TVz4lkib+sLkhdHd7OGch4Q
   WzbycCKQrhjmly1AksdkFB1A6a/aBoz5gxopTf5WP2qm6zCvoBDy9qDiY
   FH2cvJ/X9RFeLrrGKfkp3jiLroX3YtQlUw7xty+ZUHusJbHf53uZtbZQH
   u8lqE8nL5nELBcVTMAZHvlxrokvq94NQyOOPaOpYthlGO65J7xXWdigQu
   Zx4PrJYgWnzQUJ36pDxekdAa0qsjYgbKXsOLRmqFpvHgu4BADx+sHNH0p
   A==;
X-CSE-ConnectionGUID: fyN3Oz6yQCOP3VivN4BrmQ==
X-CSE-MsgGUID: jiwuGfIMSVqGyfi4DVPv3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26397324"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="26397324"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 02:29:13 -0700
X-CSE-ConnectionGUID: mmBwcXx2RH+IbL4L6CxpIw==
X-CSE-MsgGUID: xq+WYXrBRnm9Aib0cIJxDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="46228317"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jun 2024 02:29:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 02:29:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 02:29:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 19 Jun 2024 02:29:12 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 02:29:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN4pW91zRXnxzVDkZOnTPxSLyHiD3c7CPYAaI9PGUgxpaoStvELjOJY6xz+5+B3dHjtbuQYe1QX0tcFScCiVp0Te/N7ZHaGNpNWxfIQxyEGixuU+XELso4CDxbzscMWh43m0pZk+MmqWhr2PBxgeDrjmarJ3W0IeownUfVPP2x91eRvnFdDEJaf2tuCJljlFvigyVJZ8232j2c6O2thgHFh4g5TvgFbOsXOjKo500JuOC+shmvWOFRBj061GM+yCXkoFj8lw6tWL46Qht0X0Er2pN3azDMSfmy6y0IgpTcJpg2uJfztS74FHlTu03IAlhKwt/n2yuFMmbkCcMCGJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dazvHg8i6z79+q2ixeUR8/IyBpAnvLuNd/cAN2RnRAI=;
 b=Ig9LoMQwflMpIJXtOH5u8Gca6t+cNXHeKV74XMe6aDNR0dQqIcYs2A5ghCVwvCJvkCv3+puhkOHNy0mI2bOswOdSryLr8hBdn1/u62WpRguF0TYgAee79DrDDXt5yZSmzRbf/7LZIQVCznGWdvci8U4qyY53aeZTOaiLpth87ZNWbcUDwOBkbxnW1X4gzStFu3L3qq5BziiDhVUFVYkZeGKW5ij+IDTY8nEyr2sSXpDeTtpbwpYfxS0r/YmBb/dyPnz35p0fsqmM/JAddzoJKFas4wBNhvQwr6QdyMHUhyikzcQdeiV2C7XNAC2rHDA4IMKJZipYCKmYZsuL8RxVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6354.namprd11.prod.outlook.com (2603:10b6:510:1fe::10)
 by IA0PR11MB7379.namprd11.prod.outlook.com (2603:10b6:208:431::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 09:29:09 +0000
Received: from PH7PR11MB6354.namprd11.prod.outlook.com
 ([fe80::5ee2:b46f:b12:ccd]) by PH7PR11MB6354.namprd11.prod.outlook.com
 ([fe80::5ee2:b46f:b12:ccd%5]) with mapi id 15.20.7677.024; Wed, 19 Jun 2024
 09:29:09 +0000
From: "Chang, Kaiyen" <kaiyen.chang@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "rafael@kernel.org" <rafael@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
	"Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/1] PM: Start asynchronous suspend threads upfront
Thread-Topic: [PATCH 0/1] PM: Start asynchronous suspend threads upfront
Thread-Index: AQHawWLhahrDNctJQEK8wVMnrLQSKbHNWoqAgAFtmSA=
Date: Wed, 19 Jun 2024 09:29:09 +0000
Message-ID: <PH7PR11MB63546E35063B3508A949C62E93CF2@PH7PR11MB6354.namprd11.prod.outlook.com>
References: <20240618093507.2143-1-kaiyen.chang@intel.com>
 <2024061847-anytime-passable-1ec4@gregkh>
In-Reply-To: <2024061847-anytime-passable-1ec4@gregkh>
Accept-Language: zh-HK, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6354:EE_|IA0PR11MB7379:EE_
x-ms-office365-filtering-correlation-id: f3bba05c-338e-470e-48cc-08dc9042461a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?6Qh2yJHhRtz6tIRYHXEyp0nOorggjIlMBFMHk+TiY+soiHSPH1HKOUz74LSF?=
 =?us-ascii?Q?fEUodtNOvnIIPRlTrmkSWFgcDUhLyJ1mDiZrC3ZbqGDypcyey5/GPpQXceXQ?=
 =?us-ascii?Q?THVExWbdu2tX01bNr8uB77WHPRpEQi9O0wlqHYsAQBxbDdDx82e/5ezF4P9k?=
 =?us-ascii?Q?tCJaioiRZFJyHIDWUxUyjYUbdzlqnwb5SD8zzrovE2UXbzGzqnVv6yIUTTCP?=
 =?us-ascii?Q?irJotqFZv5LG5BVib+p6JMnb9aVQsLqYDSLx3F5NnT+HXC8oSiFHfsyjYGP3?=
 =?us-ascii?Q?oeaVYhAKtdc3dDxC89417nHiUthQYT4h3kewb3IUSua6y1Lbu1Xz8YdIDynn?=
 =?us-ascii?Q?t826PhLXWGl5mav8wNGl+5MHCy0hi+Ff0/T0Ln/50+KCbh8b1EVhPiJ8YCtg?=
 =?us-ascii?Q?dUiJgEC8jIRAGhp/Pjt6IcW016K0DX8EeRj81bcRaDHxA9+H3kKPH7R+C6T+?=
 =?us-ascii?Q?HG2KbqWtcnYmMUtQ/zKPrOAZGBjRAXpYISCCbdeJVEf68AVPtLfd7qzgZm7x?=
 =?us-ascii?Q?BET6m4elvbX1Qjs7M2hrzjjTf1Szin6EBLV29zcp9b8zimnqVGkDYm0PBOhr?=
 =?us-ascii?Q?FQxMo9QGtY9g8APXjcMJ/Up1HT7pxYLyYygSWepQ9nG7cYdVg7N8a6qnpqJq?=
 =?us-ascii?Q?fVUY0jnrcdiMGn07JC+BLPVghbzF4G0XLc6DPlTK+85QvC4L/JDIGqXNZ9eB?=
 =?us-ascii?Q?pnb7k2N7YrRMJBitVfUB0HKdgsCkiEnYklm6MKGGVVDrncOIX0mU/U/g8baN?=
 =?us-ascii?Q?vzqbm58uVE57b/FGEsnhXZ+m7Ya+0JNGBys6hH0zfvJCSfaYwcyc8+S1/LlL?=
 =?us-ascii?Q?nGW4X8bLlhS/iW5Go3EuAEgimhIfMZbWurvaTiavkNvBaBQrttKgqmoBM8F9?=
 =?us-ascii?Q?8uE0Uvwc2LuC5vhPFmg6lDJLR5lFKHsPiUJrObwUarknFn37RqOUbRveWKSI?=
 =?us-ascii?Q?sDkttIJbBGKBepo2JP/Jv1Y+a+toiddQTY4rsUtktfgguXHvP1cbcgpOfEBk?=
 =?us-ascii?Q?vm9agKx79Eoy7461VvcF+YBpfCnfgJHX0p5QxcjL9n715w8VRwo9QCHYtT08?=
 =?us-ascii?Q?0i4uOfkjtcVqBKaDtQ68TMy1kRx27OXBBO4KlXtdhLE0uzr0cu7Qe/DnG9sR?=
 =?us-ascii?Q?8agG+CKQqyVEeG/aYnMu1Kw+PGXeUd9+aOATSYmZx9DNMTYTV9i1+BMYQobr?=
 =?us-ascii?Q?Kw8yLjEZsiCydwOC4xDjaQjfqN7KSoXmYAG+Jb8Aj18sjhr4Ckb/zijgVH4U?=
 =?us-ascii?Q?Gjku4qGOhiiA21bsJvyZM5/UpTtWPEEYey6E1V56ThqIQDtt/x11/Zpu5c97?=
 =?us-ascii?Q?5ffhZvUmA16UQUZa0NMGimgv2/YrPXGr+OjE3UhAlrQYhrz1BDeFIplAcIGH?=
 =?us-ascii?Q?IDaH404=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qes9i1EX35BeFr1yXnVNgYbLjVAKGEqRifgWk3FaYHEq2g00wa7GNx4qbLBw?=
 =?us-ascii?Q?Ah9S3W9pUb3sexigmxvDCTKNkvHmvEMrZyukDuXpFfVGu0aV33ymbr14ULKj?=
 =?us-ascii?Q?itdZeNd7PR4xrrDgPtkjXiKKMml1Yz7yteEio61BlgQhySgoWhMqFMXTg5nM?=
 =?us-ascii?Q?THwSZTbFPK+hBFm3RET7Qr3uINR4tXPpjYPNuddkDFhcBaPrAVHNk7FvdLuf?=
 =?us-ascii?Q?vECFaB8lMEQ5HvoazvKgHWPRdG6x+es68IA2k1Q+Bd5dEsEihk7Nq7Fr+FHD?=
 =?us-ascii?Q?EvNJB28qH97DrQmRiPVpN5yDObXcaeXDjwYMxuGt2CNegCBqnam2aBaVIeGQ?=
 =?us-ascii?Q?ZnpYz5nQWz+GcCtjBPojQT0hANc/AWG4z0mKnIYgH5pKtDFDYUO/Xqi8TMFZ?=
 =?us-ascii?Q?46oH207baEtAYcW+8SxG/zH25KdQ5plURKr5BLAyZ8xAjDt19ECuJArofdwh?=
 =?us-ascii?Q?oXv1OEfUAN9W+8B5MfBDA4mWuWoF7sDsbcAbimXftp18wrQwB0pmBDtRrF2E?=
 =?us-ascii?Q?02B1CcorPWFhurQLBNbYvPNT/jgG9EBGZzzcO/gM4VVPvVzF1A/Hf5sgd5RR?=
 =?us-ascii?Q?csdreCokVRv+THjDJZsb91boJlQ6kNbVPZb6lY/OhIQjrlXYgky6GF9QlVFC?=
 =?us-ascii?Q?mL2jsJ5o0+ytuWmb8pz8jj1HH6hUbq0LK9UowWauv9Dklv66TAhE/vi4byuu?=
 =?us-ascii?Q?mfErg/VgHWeY060QGELR873MJValGS29O2KFjqemG1tAXA5u+jVq/iBc66u+?=
 =?us-ascii?Q?MRZIgkwC1F1oQz4iUPck8dpwF0mE7vSd3h1cH7OFU8FpyqIuTk6Z1mJjht2L?=
 =?us-ascii?Q?d0cdeeXXiBnvrmYQK3AYjZXAfR8GdwaP3kk3Ow3vWUW7k8ddnFczuvB499AP?=
 =?us-ascii?Q?pTsKww5hTNRD96HjRXjI1SRdHtkTWaljwjGTQNhF+qaDN1v3MVhMyGFFxm4N?=
 =?us-ascii?Q?rHrxl3jTS8P5MIqUbVZc07aePoZdYnRtulJvD1E6qjgHfJ14NREWU6z5U4Uv?=
 =?us-ascii?Q?dke3U2PKBOTojow7ox1T2SKVMsv+Ip0FCBRcuWzKgyJUM2p6ImgKLU2EE+Pj?=
 =?us-ascii?Q?+n1lg3l9ABlL7le7j7E6MwJ3JvTGAbrd+67BGmzn6eHPkmK4zkwvv59k0Al7?=
 =?us-ascii?Q?yMXaCMVw+3Kf4Svin29ssr02LH2jh7NtdugDWR9gFEixt7THIYlhhaDAMUvp?=
 =?us-ascii?Q?Q2gsDB0lTVi3kNsPJCfZdJyQIZmbJuGiaJWkQ96x+4tdSaQoh1yj3ROHFshB?=
 =?us-ascii?Q?zHIgu5cUCvnTnSWMnnyT0sVsU0yi9e5NbUVR8dwVmTuIm3XUs90ua/L0HOP2?=
 =?us-ascii?Q?Ddsq18NeQI4lb/4p/dSFvEJuYVxB0ZeJhf43ADR7/jp3diTkyRFSCquV/yhH?=
 =?us-ascii?Q?NpNPrIHC9f3jhbd4Fu+R/g7+9mCMSOQus0vTXiXucCUd6mBlb9PSS9z+Y3C/?=
 =?us-ascii?Q?OcOpinVOWBOTIUmTgzquqmRig+9hNqLAWqAevWHNIeY7amR45FzHhB3y06w4?=
 =?us-ascii?Q?62Pn2gTA2nkCRLeGFq5JT7U+jhdQlTVp5Nq603dKFe/ZYTb6upwWhm3Sp2QH?=
 =?us-ascii?Q?u54WsiOexKdhHECR+kn5f2TRfkp54dXHXPyeKZd7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bba05c-338e-470e-48cc-08dc9042461a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 09:29:09.7883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dq/+lkJShN5OBp9XB96st7pONljGRMEzS6rgs8eu5u/xetyrmdXnJ2SdMr/r5oIXbNoWJ/bQ+aiW8pGgMoC3Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7379
X-OriginatorOrg: intel.com

On Tue, 18 Jun 2024 12:59:57 +0200, Greg KH wrote:
>=20
> On Tue, Jun 18, 2024 at 05:35:06PM +0800, Kaiyen Chang wrote:
> > *** BLURB HERE ***
>=20
> No blurb?  :(

Thank you for the reminder. I will follow the process you mentioned first a=
nd then add the blurb.

