Return-Path: <linux-pm+bounces-35326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E9EB9D621
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 06:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 787C27B7800
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 04:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB99D1A9FA8;
	Thu, 25 Sep 2025 04:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vt1ST5Sf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F9214A8E
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 04:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758774429; cv=fail; b=vEud8Wg59QijqIvUDzK/S9Bvrm4OGXE5T8a1Ept1yMLGFcOEIY/WngZL2O2dEsiYCZqb8fhoqu88v2rSb2naHAr/ZLAWV1SJTLi8l0J80MhVqo+iFbUkSYhxaD1SmOJT7BDoPtooxp4nOv8TdjyLi85HHI7KzJm1E/tr6RoPZIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758774429; c=relaxed/simple;
	bh=05Isl/4MmPUm6ntiunDqA64arYVQh0UoXygzm5l3puo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EQl0p8out8xnjNdsOTL+xv+QZnFdFT8QMANC4hij3/iyzhsl6FZrp3vKozGAJYUA+OgMZc/G3oVvLVUrgrCyyJCcWVYy1/8ehexuR3lnjdfBsyO8jUO/weh5RdeX3mFrkDmOEo6yRGJV+1Nef9mCIeDeryZ8743KXSJJ5uNt8ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vt1ST5Sf; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758774427; x=1790310427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=05Isl/4MmPUm6ntiunDqA64arYVQh0UoXygzm5l3puo=;
  b=Vt1ST5SffU+OlGR2Qn0ELEIc9OBY3zlr409ILOBYSmOv0gMq4m+OA4Jn
   unydLmxvTdu6kbktR3vcJ35VKdCTRbZNNqDiHCaflLWLHUklV7DdlpQe8
   4Wx4r1asbee3KizSQ8g/FI2xxD5/AWqjStXqrkcoilVFi7tYS45SlVw9c
   SwsqSSifxjBqRv4pqCM2KaJufGs/IF/2IWPsnIa35vf6n/fQKjuqYEui0
   MiRlIYTu8vH4jq2+CYd6r0Se+On4ZgabV3GdU5dJpIvE87a8TmM42w9q1
   sztaZWgHLvNxVsvwv48eE3YjtZf9xLEkYWDfgnb1BS/xurMuGo3mzPyQp
   w==;
X-CSE-ConnectionGUID: fFXqK8WHTdmrPmrRCEhUAg==
X-CSE-MsgGUID: BmzMWtc/SxqvO+06mr7fKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61191725"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="61191725"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 21:27:06 -0700
X-CSE-ConnectionGUID: Qv0olwNNQB+6201xuTnvqg==
X-CSE-MsgGUID: Qp9TTyI0QRaWqSE7JJVrsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="176518243"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 21:27:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 21:27:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 21:27:05 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 21:27:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXOBBP5W+T4ygQEywqe7puwizJy3ZGP/vD3W9kixSr+ekPD506vHdXP7f/qCi+QZMBQgC1M81pvuXAclkxxQx9km1RZLNeQ3M/mCXiQkzndW+Hrp+aPyBPVq6oCnpDI+11+7nSApU9wIbLHR5BivBEuWjP3ney7/Tima6D7zb8e18NP4NwncdsKZb/yoV/qLWjaiLmoIhlXFPPHfRg9M01k1PgS3tDau9YMxJmwyGN2ZJczvScGxCRH/Lq3DzZPw3FjZYkcwNKb6EHUbKMRODnd619hoRPm6ahDV0RKThb+LCXchB9HgtDhxuqWOTFxrycXizuQfwIBdvowGmy+e9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBF5kfTDuqvAM3tNWbWmhv7oR897XeLynsFKmZWnmoU=;
 b=g3BL6kVu5PvtSx1MpE+5ATPw2BVgn1vbyVuVK4ZGzY7zjnUEX/Sfx2/Mj0EwRdt8pB0z/Aksv5ABLdVUK0H0ZyS4bBs7RhvixFVqS4jYU7EhzD8X3OXzWuHoStDE380vxqfzHvNo6OXFurHJxUcdDaWpt4aZ8voaHJZnvjNJt8iZHCEaeRQ09Dw9Ag9w+sccYyhjv7k0ku8iVzONuY9tWkl/kyRA6MTUGeGECj/+PQNSM0sAWcAv9Eg53bJ/pCVt7Xup+iWrDyODLS03RD21X+Zk8/aDUmNCQw+5tmIrNRrz620qV7IOrPZ0gFbVPirjdAEU7o/y/RwzLWlK8n9DHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYXPR11MB8754.namprd11.prod.outlook.com (2603:10b6:930:dc::13)
 by DM6PR11MB4561.namprd11.prod.outlook.com (2603:10b6:5:2ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 04:12:33 +0000
Received: from CYXPR11MB8754.namprd11.prod.outlook.com
 ([fe80::dfa6:4377:1e5:4889]) by CYXPR11MB8754.namprd11.prod.outlook.com
 ([fe80::dfa6:4377:1e5:4889%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 04:12:33 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Dhruva Gole <d-gole@ti.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "pavel@kernel.org"
	<pavel@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "dakr@kernel.org" <dakr@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v2] PM: Delete timer before removing wakeup source from
 list
Thread-Topic: [PATCH v2] PM: Delete timer before removing wakeup source from
 list
Thread-Index: AQHcLVR6Kt9du9sQMEOw8D/lJI5SLLSjSdEw
Date: Thu, 25 Sep 2025 04:12:32 +0000
Message-ID: <CYXPR11MB8754D00F589FB5738678B105F51FA@CYXPR11MB8754.namprd11.prod.outlook.com>
References: <20250924113738.1956768-1-kaushlendra.kumar@intel.com>
 <20250924130919.3a44k5jfagivruaa@lcpd911>
In-Reply-To: <20250924130919.3a44k5jfagivruaa@lcpd911>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR11MB8754:EE_|DM6PR11MB4561:EE_
x-ms-office365-filtering-correlation-id: 525982d3-e8e2-4a01-906d-08ddfbe9c064
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?EBpuYwRTS6KUn0EDYmRgdyUx7X85ELLJkRBqLZddWtm2wyboAveWe631nfSj?=
 =?us-ascii?Q?A/zEW1LJuKNc6Yij2ls5rOOLVvsZ1kwhWPyWXR/jJ1Dr+oV4kVW+ORSIz7k2?=
 =?us-ascii?Q?NIJ6G7yrYDDyJRvtdWHrjWg6UdMRjGbjvjxL4aX59wordLZPyK5bgUu+Z19d?=
 =?us-ascii?Q?pqBdN6HshFaG9y5hJr9/bFpju7nX6UUcY8Zi0gy+bGePjZ3ipTbpd9snUj+D?=
 =?us-ascii?Q?0Z73fg9QlKQCZGOQVXt2Ojfwma53SKcRd86VCitDCYLOhw9GcOBBxZbKe9Xy?=
 =?us-ascii?Q?jCLDfb6P2Q1WGIdoc9QPVFQl4UCofC1CzG0PjC+lj/+WpuOPinArSRyjT7yA?=
 =?us-ascii?Q?c+udBisEo6lwHKycl0ZJrQGrcrbMqsT1XGQaUJ2tnQEFnB4tnHoQKEFtm5W1?=
 =?us-ascii?Q?amFlTy8Op2I4IbU7LepLTZdVJLP+XOXK6SAwabwSwHbLs5reD22NpGoNnv1T?=
 =?us-ascii?Q?dKmrmXSd6O70mt6gx4KFzLTXvfR965T8iZgt9OUGmSwRVcpXGvEmsrP+96Zj?=
 =?us-ascii?Q?FoJvKIOoRnKXDgVUrEr9GOX8PpVoJS10hEBDEdup8qgvK2RcnEoxvOnJdi6p?=
 =?us-ascii?Q?P6uMlkpsVKMrtIbsaT5myZZH2ku4RDEPE4uVEly0eSelTNodsV28vFZKkkSM?=
 =?us-ascii?Q?bDoXEm6avYPnu00qSajwwCzY3Z5dVl3xE/nUZD1VyGlYUEMn36q/s/eDW+Oe?=
 =?us-ascii?Q?aoGBItS6hLsX/ffbrGMBn0tYjlBydcHQvFFSdGYHAlrMSCh0TW01vgr9XELT?=
 =?us-ascii?Q?iz0/CvKhqDp2SkNpoJr1hib7vBhjOgy2r5xnMIgdoWoMOxDep2m6aAQKc65o?=
 =?us-ascii?Q?4DPoz/uMckCFI6sDe1eoKfzQ7caAODF0b3spbyAVEgUsRxWOYrUn4lGhmqki?=
 =?us-ascii?Q?69p6yDwOFi4aZRdfd71KHZiTy1vTisHgjIUhXXudjM7mCZIlW2xgOJKm6i2U?=
 =?us-ascii?Q?mVfNTxXzVMso69bhwfJqTfdeR9Xy1YpPiAq99ftMoEzzUDiAWfCNcl5rDqhg?=
 =?us-ascii?Q?1SSWQVRgAawZCu6X3Gy876nKsDXXNVceCLvNF4+ehZJ+DXbAytjkCay24T/V?=
 =?us-ascii?Q?HbgRSRqZhLqFE+v05IQdWeF0jdO87bWosWev0u+IkU7IuHwpzU2i/R7yneoh?=
 =?us-ascii?Q?Ke59ZYgryRPoQ2pjh5fwoZTDkqbLq9bgesOM/sx3wKF7kU4CwjMubcTQemx6?=
 =?us-ascii?Q?w2aSC+eBBTitHu7oCvwqbcw79tFFeno5J8/5ZarINmloSe+aLrYE1u2nXe2u?=
 =?us-ascii?Q?zKWp3Qjo8+y+Ztmd1JRT+lj8Kh9DRO3Tk9SaIANro533209h7cTwRamg+lhW?=
 =?us-ascii?Q?hcobTgIyUGZuPh5o7dEkBSKvBGO8bxcbi8MulMvwRnM0Pg8Ue1kqPFQz3ilP?=
 =?us-ascii?Q?OGmgwo1LaZqwBBOgPNR3/P8JQFk8/N+4syOHuWNC5mFhmku5WgvisZkcIAxc?=
 =?us-ascii?Q?TwS7pP9gG8V8IVeee7TDsg1WKn7sRL5ev1sj5/gQP9NImpv045CPycKcMPsg?=
 =?us-ascii?Q?IMZWF7gVQdAIykI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR11MB8754.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ohagjtugiAaPjiub31nrA96e+JJvS8ulFDkVoVbYcgiFtSqrRx6wHmJiH9z6?=
 =?us-ascii?Q?2NVvnaJhr+/nKVU34ndWBgxxPaPEuo6AhNVQO7DfRYHPZT6wKC+ektsR0h8L?=
 =?us-ascii?Q?S82aLwmkJOXdXc87NZq2peYZKkd/7ogyn+SI58Pe/DdE8/F34Ew7FIZTMbTG?=
 =?us-ascii?Q?c625pPN63Rs+ZTKFd3NRPudDqOIiwhaYaBJ8Ajlttn+P+YOLmfme8U6zYITA?=
 =?us-ascii?Q?15jt1MSqm3f29SrQ7Ym4/xAOzHANLGJ7SXBBKu1zzTXlhf/DcDBFGsP7dYUM?=
 =?us-ascii?Q?cqFDJzFbAZRF2lsmBaBZIEd1E71pwa0uxjsErR/t9iF32lrNKbYh1zgV386m?=
 =?us-ascii?Q?Gl1H1O0I1DUrWEbpGfKw55UuNRZ36ryBpC+lGxAjMDB0p+7xKF3R0aUc9nD7?=
 =?us-ascii?Q?YQpNjChDNQUKawHeUgCQRytx7WND+qFG7R09NoZgoEs96czVLxHNN+ChwYdp?=
 =?us-ascii?Q?Q6d2POBTw5MUwht9lQuZkmvA/MOtbAEWtXiobksnyf+5s725InJZ0HXrWjm/?=
 =?us-ascii?Q?NePS2URDsFSYZrXMGLZSyEt9F2PZaCoijCLiBJ2jQrPU7+URCYcXVR6nm/e+?=
 =?us-ascii?Q?z75WZpGxjZfD05O8tcFNNYNwi4Scf2ZosPGcRTCjjZq2V0bROrj6yo4IDm6h?=
 =?us-ascii?Q?xd/zlTEiNd+A2aQLdGuU8bjtXWuDqntGTJmuvCb+ZVIyGBfI/rccffXY3P8L?=
 =?us-ascii?Q?21xYOrmTkGjnGn256c/TjYpUHnp9nRyik8mwMW/DFyQjDpxuTfjQ0+T/cYOA?=
 =?us-ascii?Q?g1k2Q2/sL8x7RfrHtz9BqZLXFJ/OJOmWAvAHs3+JqJn7QC31POBY2joRL5yt?=
 =?us-ascii?Q?jSTH5Zkr+SwxLmIACB/u5MOWzE07iZfh7RGUXNXzqNudOg/SGaeT0x/9nOcd?=
 =?us-ascii?Q?A4MmJgjh0IKmSUGPub0ir59oTkeKjEIBKc9cRXYPJrsC25ZHfdt+TlkTtel2?=
 =?us-ascii?Q?ef4NWlfDObyYPypID1gYflg4Eo39HMY5zlpEvzYlXKroK7Ma7YWnD8Pi9WY8?=
 =?us-ascii?Q?Ccf5zqe4MoVIX0k0jb1TCTsXPWHIUnIWkvwOFES9xFCR5Vt5nco8ip/Skcrh?=
 =?us-ascii?Q?PLIPPUBsNiecEwdFO73P6pdCdnKOQN7qOBxkpV/jU0oQFjH5dQtn0qJzUcZT?=
 =?us-ascii?Q?IfU3yt+Xz5O0Dk2QXete5QP3Yc6AWAsE1GWeDI6dIo8xf9b09+O0AWQ7RQdU?=
 =?us-ascii?Q?AsaioJ/J5M6uxvnmD/QJ/A7i9lCviruyX4I//ak34PHYWthYlXseNjDCO2AY?=
 =?us-ascii?Q?LtJjBrXMjaK/pFnyVrf8N1PIQhzwTEb2Q1kmPBw3Wh5mGXHraAbaAefFWCg+?=
 =?us-ascii?Q?pEH+2RdwPjT4CLPAspeLcxHrERzl1vjdEjhEug+TlNwezWqXsJuesuSDWsPN?=
 =?us-ascii?Q?pFz6eufXNsKzG2TiT1vME05/ZmT+tnuSujkMEN9sJmA+3jD8Kg8e8nCwNftv?=
 =?us-ascii?Q?JbUHT3jPJAoi21cS/VM1wXU4k8NeUs+4D8bEahnRpyyQdsIP1eOlAfy1WKTR?=
 =?us-ascii?Q?MirsKWQgcjfKCZger6YF+i6qJwskRprRMhKJYOtx0ctS2ZZ5hKy8WxPOuUvr?=
 =?us-ascii?Q?Z5BjIbx51IWVn0ROq6aGBXaD61/iCEvrwv6eh6YOL89Mgpx/6OCBGWrHZo33?=
 =?us-ascii?Q?XA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR11MB8754.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525982d3-e8e2-4a01-906d-08ddfbe9c064
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 04:12:32.9784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9Ooc0666FoHkWkzwQKjSonzEYJrJzbfCzwqDFvh1Xd1/zK4NWoij78f8GBr5Zi0XjasI5xtGI/2dAU/zjMgp9TXdUX0EIfsSSf583FPDx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4561
X-OriginatorOrg: intel.com

On Sep 24, 2025 at 17:07:37 +0530, Dhruva Gole wrote:
> On Sep 24, 2025 at 17:07:37 +0530, Kaushlendra Kumar wrote:
> > Move timer_delete_sync() before list_del_rcu() in=20
> > wakeup_source_remove() to improve the cleanup ordering and code=20
> > clarity. This change ensures that the timer is stopped before removing=
=20
> > the wakeup source from the events list, providing a more logical cleanu=
p sequence.
> >=20
> > While the current ordering is functionally correct, stopping the timer=
=20
> > first makes the cleanup flow more intuitive and follows the general=20
> > pattern of disabling active components before removing data structures.
> >=20
> > Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> > ---
> > Changes in v2:
> > - Reframed as cleanup/improvement rather than fix
>=20
> Nit: See the git log and fix $subject to be PM: wakeup ...
>=20
> >=20
> >  drivers/base/power/wakeup.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c=
=20
> > index d1283ff1080b..ae6ec9f04b61 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -189,12 +189,11 @@ static void wakeup_source_remove(struct wakeup_so=
urce *ws)
> >  	if (WARN_ON(!ws))
> >  		return;
> > =20
> > +	timer_delete_sync(&ws->timer);
> >  	raw_spin_lock_irqsave(&events_lock, flags);
> >  	list_del_rcu(&ws->entry);
> >  	raw_spin_unlock_irqrestore(&events_lock, flags);
> >  	synchronize_srcu(&wakeup_srcu);
> > -
> > -	timer_delete_sync(&ws->timer);
> >  	/*
> >  	 * Clear timer.function to make wakeup_source_not_registered() treat
> >  	 * this wakeup source as not registered.
>=20
> Also, since we're doing cleanup, can you check if using timer_shutdown_sy=
nc makes more sense and then we can remove
> ws->timer.function =3D NULL; line after this because that's what the
> kernel doc for timer_shutdown_sync says it does?=20
>=20
> --
> Best regards,
> Dhruva Gole
> Texas Instruments Incorporated

Hi Dhruva,

Thank you for the feedback!

Let me look into this timer_shutdown_sync() approach and will come up with =
a=20
separate patch if needed.=20

Thank you for the thorough review and the improvement suggestions!

Best regards,
Kaushlendra

