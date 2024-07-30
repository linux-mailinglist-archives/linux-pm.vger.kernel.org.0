Return-Path: <linux-pm+bounces-11672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D18941443
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 16:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C631C232BD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 14:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72B51A254B;
	Tue, 30 Jul 2024 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lffaqy60"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF11A2568;
	Tue, 30 Jul 2024 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349499; cv=fail; b=asR62bCL64rAUB4X/eKMvXjTvnPtAB0K1lOjuIYb3X8EO+X/DSh3gBV9wBtn05HV/a/ipyono1Mv/9WYrnTALDnyiCg8Yb+L08jTPUO7vEzfw5jBAly67WOf/4Dkz5KCXEK3iFwez9GtsXOEf4GTIiFC16JEBvFjr6mL5u1AIZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349499; c=relaxed/simple;
	bh=xywexEKQiGLZom78Fvmpffc9EjdJle6LHrR5UCan8YQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Osylpt1k+ptvVf58F5pmXeZgy5bMutOkbkRZ6kBUus2Jmaofb+FEI5d0MHRJLVVQgzWpIAkNEPg30tQCPxVTAjQoCIETK6i1J/nETlvI24SJSJiofZGIoqyHV4p+jx9I1KpX7pLc1ktWJQld4p4TZaI0pym3SUq4mHLCMrSax00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lffaqy60; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722349497; x=1753885497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xywexEKQiGLZom78Fvmpffc9EjdJle6LHrR5UCan8YQ=;
  b=lffaqy60X/uf8Zg+WoTOxHLBf/6FWgpg29VeR49/EjkBWXHBfG9Dg+2c
   feuAJUWI6EMlxwAvh04HpXv2z5dyKUv0kw4cseysuVng2DqvZuvw56m3c
   XNAJ/3/na5rAf4NZcl6hNCwTQshf6ybzJEKqmq3ZY81WJo51TykT8eNM+
   zNb0jtLRG6GILbMkE3LaIJLBA3EtA4XXbNt4ne86B+X8vlfQOp+U37qvM
   fAJUrjgthSVhakxLCb6rO3yfdDVKJrVV4zWNmUUV76+5GeaOBsNqf2jjj
   o14JE1lZsYhkaXdOjckmI7fTJj7kKsWhkKR+yMEIQKHYa9KXbRRH1ZCR1
   Q==;
X-CSE-ConnectionGUID: Npdc5DlPRCKiIohocNgjwQ==
X-CSE-MsgGUID: 4DQ+z+7XRHyFbfrq+kB9dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="23931504"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="23931504"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 07:24:57 -0700
X-CSE-ConnectionGUID: OfT/MJFTRGmvz8T13Ho+fQ==
X-CSE-MsgGUID: ViZkw5xaSgexccLUCF1EmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="91865806"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 07:24:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 07:24:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 07:24:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 07:24:55 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 07:24:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUvER87MEJ2kHP3acIu1JVGWgpBwQl7HMrme4Lct7mS3XzBYda0h71hlFDzTQhCNjZ85PPPy1KYOVXLkLXAqilwZYV4mMnlBTuEphI/eoyskBnMFOKOFcg3+95y0saxj6zvtG1XQoukz0n7k6sBEyQHtZCzKyCshjDGb1/FVxq45LtWGBwjU8p1sTAEmFai1fPgVi/gQOYpoOwrdo2Al4OBnsRA/IRsbEYx1M9Aszvtx2bvpcYEtEcV4iyy7Ndy3s7CMDMD65aO/hl0pGxT5YkgB+uvEjqIxs0f6hsYtCTeQ2JICufgx96DyFofl+uB/QJIAeYGRtdf/RSZ0LYWBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xywexEKQiGLZom78Fvmpffc9EjdJle6LHrR5UCan8YQ=;
 b=gN9H4KVPP64Y03Jb1chOHLjg2vMmuJmpjqibHgdfHV+GRTqqXkHQodqrjuNtUtEmanGuWyxfUSHWV9Lw/qAuPOvEggJ62xcEaNqDnLn3sBmT+OMXZEm/h5iYcOj5dAcGTn2ogfBdXG5wK0t01MehG88ytz3VuFH+CzCO8lCdUlkZJA17mVOXuo0O5WmcCTtYw6UYdaN+Kq07/72tnW5Rd/w30z6h84h4tAMxySo/W7RI18FhGvGcywyGUB9ldo4NIf6U+EHPck7Ust6fWG0yTrylMPFsQStmfWNRDw60IcAjw1tmEhP8W3vP6IlXjKGusiQ/vkR/Yy9qnNYAZ7sdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.30; Tue, 30 Jul
 2024 14:24:50 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 14:24:50 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shen, Yijun"
	<yijun.shen@dell.com>
Subject: Re: [PATCH 1/3] thermal: intel: int340x: Fix kernel warning during
 MSI cleanup
Thread-Topic: [PATCH 1/3] thermal: intel: int340x: Fix kernel warning during
 MSI cleanup
Thread-Index: AQHa3QkVhABcGC2m90is1BKWVMl1tLIPXmQA
Date: Tue, 30 Jul 2024 14:24:50 +0000
Message-ID: <33b51e7243175be2e39309f78ee5a8c600f47c95.camel@intel.com>
References: <20240723140228.865919-1-srinivas.pandruvada@linux.intel.com>
	 <20240723140228.865919-2-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240723140228.865919-2-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CY5PR11MB6318:EE_
x-ms-office365-filtering-correlation-id: 34a66105-80e0-4bbb-4a49-08dcb0a35f2d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UUd4YnVRZitCNGo3c1FLYWlwTnRxYzZtOUwvRjYydGdMUzk4ajhYbmhKMVlQ?=
 =?utf-8?B?aGVmTzFKTVdIOEtOZ3JrYWlHZnVNblpqQ2UxaDBzMzUzVnVUbzdSYXdnV2o0?=
 =?utf-8?B?dzNCNGFpQTVYZVZBM3pGWmk0c3lvL2dnQU1UMjlzRG9CS3pJU2N6cThvelMv?=
 =?utf-8?B?dk5TZmhsVlpIZDR6LzllMis4cjA3M3BHVkh4a3pXSVpvUXh2eHJZQjNDRnRn?=
 =?utf-8?B?VTVsaWNtTWhkUlVmTTIzSkhROGpkaGRoV3lwdm5md0lJemRQY0xVcmVBbnFO?=
 =?utf-8?B?ckxYWEtiaG9Sd2VQSTJITXpiV2R1c3hJeVZpSVlsdDBpcVlOYmdzaGE5M1RG?=
 =?utf-8?B?VXNDSW05M25zdkYvUythYVZjQXdzcDRHaU05dnZFWVpBZjNIZ0dlZXFWS3VG?=
 =?utf-8?B?TmcvTHhLMmFZdk9KUHZUcng1Y2hFcHAveE50WWNjdkx3aU1XTHNoRjUrbElQ?=
 =?utf-8?B?a2NjRW9SNWQzZEFiMlp5WEFjUzloSE5qU0tpbUZBaStucXBKbDJqTlZXWjRO?=
 =?utf-8?B?L1dFbEVtenBLbGxHUWpjR2Y2Q1l0SEJvNTk3YVpvUlJjNVhWSVA1b0NST0k0?=
 =?utf-8?B?VGJyRjZYNS9LTlJxVmhFM1FKM3hlRC9aTVZJWnl6dnF6MzFwcktxcWlRb1Fj?=
 =?utf-8?B?K1BPbTdOM0t0dFJqbmllMVJKY0JNa3IvZ3o2d3BJNUlNWnVpclhqVDBXTW9u?=
 =?utf-8?B?eWlyeG9xNFZZUkNRNmVYek5sUDJNNmZVK09jZ3BQcHFTNnZsZFY5aEhjUUFx?=
 =?utf-8?B?NnZCMWEvSk41WVJzaDBwdUdITzNuQ3NjcFhuZVBRUzcrWlBPaEJyODQ0SjUz?=
 =?utf-8?B?UXBtdEZ6QzYvTUkzUVVqUU1tOTlNUzExL2YrY3RId1NOdXBKT3BXYXZjdE9a?=
 =?utf-8?B?Q09VNXAyNkFTbHdwMHZadFM5SHNUVkJDZ0I0Qkp3SUcvZjZSaTNHQ1ZERG5H?=
 =?utf-8?B?SlZPMjZ6dzFVVDlOUys4b25QWm85RjBPNFR6TDRBcUdGY1ZyeDRYK2xtb0dD?=
 =?utf-8?B?b0NmNVVjR05qVXVOREtWNzNsaDZHNmdsY0VSSDh1SHVsSnM1UkQ5KzRiOEk0?=
 =?utf-8?B?MUxHVVFpSmRkV29keTBQUGhLRnRZMG1QOE9xVWYwTFV3Q0hTT2FqbW93Ym9V?=
 =?utf-8?B?VnQ2YmFrZkRVMHNCWjZFVmFXdGtSYlZ1Q0FkOHYxc0N4MDc5cHZwTW9jSVYz?=
 =?utf-8?B?eHUyajBUKzFiVHVkM2RrSzEvLzViQmRwYWhiMjdaNTk5UWp0UTQxSnpCb2N0?=
 =?utf-8?B?SnN4ditIUC8yL01YWk9EaFBzcmU2YUQvVFQxSHJSRnN1dHdzQmR6aG9Lbm0y?=
 =?utf-8?B?cGhsQ3h0QWs0S2oxMHI3LzkxUFlPN3ZRYkI0cG5tVERMZUtlS0wvWXJPK0NG?=
 =?utf-8?B?QUoyUHUvNG1RQTFSYk9mUTZoSERMZVE5Rnc5Wmo3MjlIT1BCQWhzcWNWRVh2?=
 =?utf-8?B?YnVFRmlwRm9zZEoyeFloR3o5SU9RbEFiYUpCQ1VtZ2VBT0hQdDFydVdUb3B6?=
 =?utf-8?B?S00zTTVjU3ZzR3hUZXNFYlphajFpOE1WK2tyaTF3Q0hocGpKQ3RpdVJFMmV1?=
 =?utf-8?B?RnVhQURDYTBhcXlTQlNPazBsRzFDTkhyZW40YTVsMy8zTWdZNWZFL3A5TWpE?=
 =?utf-8?B?MThibFJpWHNOT2dOb3Zwc3d6K1FodXkyTUoxdVJPZXg2SVJodDgrMmdCNlZM?=
 =?utf-8?B?NjZta1puZUVVbGxEMFNkL3JON1FKd1pnMGM1WjBkNVJpcTYyT2trbG9pWnV2?=
 =?utf-8?B?cVdLSjB5WTZBTVNEbnRRTU0xenpac2tGSFluSDE4UWdGZDRHUDQrNTRyeVdt?=
 =?utf-8?B?dXNaN3hBdmVHbTBqUGpqUXZ1T3JXVmlYNWt3aS9ka2RWRW9zOE8vcFBPUEd6?=
 =?utf-8?B?eUlPSWc1RFlLem9PMEhiTGdWMEtCdk9reE5MV3RkYkhyV0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aStEMHB2Y2VPZ1g5RWlQdEFEWXRHZVZ6UitGOXpudjdFalE0STZrZzJibHp5?=
 =?utf-8?B?WUw5NVV4YnA5T1BmamVrUkhjWkI2WUI2OUVSckl6MEx6emE4NUxOV3RTdzNp?=
 =?utf-8?B?RGNvVXpJZEF3bDFRdnFxQmdtem5vdkZWQ29rNHhNUStZR1RZbmZ3bnVETXVB?=
 =?utf-8?B?WlZjbGErb25Tdmo1c2NQL3hscUk1VWtheXRsaG9mQmtVRWNqSTlHdUQ0YXFK?=
 =?utf-8?B?TVRVMU0yaWljeDAwTEVCU284cklFTjZXNmN4enJjYVVYTXNzZlpuM1NQdVVN?=
 =?utf-8?B?bWlHUXNQY0cxM1JJeFBPbW5XamEyVjhDcnYvZWNSV1hrY2d6Mk1NaWZybjNC?=
 =?utf-8?B?TW5HaXplbDdhMThYam1ra2Z4SGRGSTRUMFBqWHFaRld5V3haN2hYbWt4T2NT?=
 =?utf-8?B?RmZtMGxNS084aHJNSTJuY01KOEdlMkFwU3dOUnlXS3A3RXRCZEF4MVJmY2pU?=
 =?utf-8?B?d3crUUM1eHFGOFBLbUEzWlUva3JaYUpYd2czTVF4WDU1eGlJdCs5d2VDclNJ?=
 =?utf-8?B?V3RqaG5yQkx2SlB5MkE3T1Q5T0k1UTc1aWtldzBQNW95QldYeTlvVWovV3NF?=
 =?utf-8?B?c3lEdFRzYXE0T05qMXNsQVY4ZmN6U0V0L2ZqUjAvRlJRUWFYSUo3SXh2ZlNN?=
 =?utf-8?B?Zmh5TjZBTWJubGVjVUJWUFJVWnlUR3ZISFJhWU51SllSZDJEMy9NK3daR3l1?=
 =?utf-8?B?Uy9QRjRPVDRPNVpsQytURXpSMXR4SmtZZkpQNFpEeEdOa2ZvMC8yZ3YvTmhN?=
 =?utf-8?B?MWNzaWxOb0JPb0lTZ2M0QU41ZnorNHJ5L3BnSjdIaFQ5SXFlTm1peFFCUlIv?=
 =?utf-8?B?UDc1cDhSeEl6WUVJZ2prbXFKd1dLRkNDUWsrc3JYT1JWdmM4K0FuTFl2WWZG?=
 =?utf-8?B?RmJwaUM4RUM0azNsS2h1YS9BNW9Gd29zVlNwQ0JYWkpXVXAzcStDRkZtRzFK?=
 =?utf-8?B?WDlRaFJUUVRYUGNDRE1vbkhvWktJaGdUWGlhRUI2Qm9BdzQ3M0VUZll4bEJh?=
 =?utf-8?B?WDBsYm0zeXIzZWdWL2FjdUZQWWd3elQzamdETnVxTkhBN1laYVhIY0ZXS0Yw?=
 =?utf-8?B?Uk5jblMrZkFUOFN2eTUxTm9aL29wbm5BcnA3Tm9vcUxDbTE3Y0tjWFg4VkRi?=
 =?utf-8?B?d1FQcnNnRzh6KzdqMmlRQlZLeXBHVjQ3TzdnMEt6YzBqLzdNMmVHMHI0Rm0y?=
 =?utf-8?B?S09ydFErNGwzdStSVGV0enVqV0JOdHBGTmZhZ1lmTXpCSjdGWWhLVDlYYU9T?=
 =?utf-8?B?eW5YWVR1S2kxWFlCanBpUkR0Yy9ic2FTQXU3bWQ4bDAwbkZxckNJb0wzazda?=
 =?utf-8?B?K01XRmxCd1RZNFJ5R1cwOS93V3orWjBMSGlKWHdYaUlFMHZHSFRLdUlIY2h6?=
 =?utf-8?B?YVdQZG9qak43N0QzakFrN2NtQkw5WVJtbWhjM0U5MFZDQ3RWYkNQeGdoNHc4?=
 =?utf-8?B?NXVtQThoTTVJQksvUWZrNkhFZTdTUXU4MGM2OUVzZVlXc1NIbXdHVVVXS2g1?=
 =?utf-8?B?Z0h2OGFTQmVCMGxFRUdLY1NJbnJpVDNJWEcyaDhHWWxkS2N2MmZjMjIzSjAv?=
 =?utf-8?B?VHgydGttR3YwbGZVSXlxRE1BQk55OVdrb0QxbnhJaE5mMWlxYml2d2hoNzc2?=
 =?utf-8?B?YVZKRjZUSC8vVTJ5ZUFDSjVoT2ZmM2NROFZlRUZtek01clh3ZkR3cHJ6QXhh?=
 =?utf-8?B?M3ZYRy9wbS9xV2IyMHRSK2VKWG12Y0J6anh6bmQvVmd1azFnTzc5bk5NOVE4?=
 =?utf-8?B?d0tuSFp6Y2FzbVp4L1M2Y3JMelc2aWYrU2Q3MkRrTlVqK0FPQTJic1EyQ0FF?=
 =?utf-8?B?VHFZKzJrNnlZTDdJUC9qREU0Yjl0eUpyU2RsbEJGWVhLb29CWGZPdXEwZDl6?=
 =?utf-8?B?c2lSd2N6ZFpqVjZlUTgwZmxsZ1daODlJOHVEQ0pHNWVlRXdrK0E5YWE5YUti?=
 =?utf-8?B?V2QxajBFOWcxejFKaFJlOFdrc1dxckJ2R2ZzNzhpSHFaWVlGMHBJdzJCZStw?=
 =?utf-8?B?VnUvZ0RCaWF5d0pHL0lmR0Q2THdvRy8wMENHaUx6UjlLdHRKakZUdjJ0c3RW?=
 =?utf-8?B?N2IycC9zK1lwdFNsK0FrV1AxcC9BRVUzU3k0dkVhVkk4UTRyNTFjeU5IdEsz?=
 =?utf-8?Q?6MGiWspHMvJFy9wBfYdXICu7v?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D347ACBE47458644B8095CE2193BF9ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a66105-80e0-4bbb-4a49-08dcb0a35f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 14:24:50.2572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSySQRHyqeS1iIlJvYdI7UXZxKCvwtGwg0B68NpQ2P48J+hwK68N0e7Wn9RCOQZZWhVakxH8eucwp37WpTdIXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA3LTIzIGF0IDA3OjAyIC0wNzAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdy
b3RlOg0KPiBPbiBzb21lIHByZS1wcm9kdWN0aW9uIEx1bmFyIExha2Ugc3lzdGVtcywgdGhlcmUg
aXMgYSBrZXJuZWwNCj4gd2FybmluZzoNCj4gDQo+IHJlbW92ZV9wcm9jX2VudHJ5OiByZW1vdmlu
ZyBub24tZW1wdHkgZGlyZWN0b3J5ICdpcnEvMTcyJw0KPiBXQVJOSU5HOiBDUFU6IDAgUElEOiA1
MDEgYXQgZnMvcHJvYy9nZW5lcmljLmM6NzE3DQo+IMKgwqDCoMKgwqDCoMKgwqByZW1vdmVfcHJv
Y19lbnRyeSsweDFiNC8weDFlMA0KPiAuLi4NCj4gLi4uDQo+IHJlbW92ZV9wcm9jX2VudHJ5KzB4
MWI0LzB4MWUwDQo+IHJlcG9ydF9idWcrMHgxODIvMHgxYjANCj4gaGFuZGxlX2J1ZysweDUxLzB4
YTANCj4gZXhjX2ludmFsaWRfb3ArMHgxOC8weDgwDQo+IGFzbV9leGNfaW52YWxpZF9vcCsweDFi
LzB4MjANCj4gcmVtb3ZlX3Byb2NfZW50cnkrMHgxYjQvMHgxZTANCj4gcmVtb3ZlX3Byb2NfZW50
cnkrMHgxYjQvMHgxZTANCj4gdW5yZWdpc3Rlcl9pcnFfcHJvYysweGYyLzB4MTIwDQo+IGZyZWVf
ZGVzYysweDQxLzB4ZTANCj4gaXJxX2RvbWFpbl9mcmVlX2lycXMrMHgxMzgvMHgxYzANCj4gaXJx
X2ZyZWVfZGVzY3MrMHg1Mi8weDgwDQo+IGlycV9kb21haW5fZnJlZV9pcnFzKzB4MTUxLzB4MWMw
DQo+IG1zaV9kb21haW5fZnJlZV9sb2NrZWQucGFydC4wKzB4MTdlLzB4MWMwDQo+IG1zaV9kb21h
aW5fZnJlZV9pcnFzX2FsbF9sb2NrZWQrMHg3NC8weGMwDQo+IHBjaV9tc2lfdGVhcmRvd25fbXNp
X2lycXMrMHg1MC8weDYwDQo+IHBjaV9mcmVlX21zaV9pcnFzKzB4MTIvMHg0MA0KPiBwY2lfZnJl
ZV9pcnFfdmVjdG9ycysweDU4LzB4NzANCj4gDQo+IE9uIHRoZXNlIHN5c3RlbXMsIG5vdCBhbGwg
dGhlIE1TSSB0aGVybWFsIHZlY3RvcnMgYXJlIHZhbGlkLiBUaGlzDQo+IGNhdXNlcw0KPiBkZXZt
X3JlcXVlc3RfdGhyZWFkZWRfaXJxKCkgdG8gZmFpbCBmb3Igc29tZSB2ZWN0b3JzLiBBcyBwYXJ0
IG9mIHRoZQ0KPiBjbGVhbiB1cCBvbiB0aGlzIGVycm9yLCBwY2lfZnJlZV9pcnFfdmVjdG9ycygp
IGlzIGNhbGxlZCB3aXRob3V0DQo+IGNhbGxpbmcNCj4gZGV2bV9mcmVlX2lycSgpLiBUaGlzIGNh
dXNlcyB0aGUgYWJvdmUgd2FybmluZy4NCj4gDQo+IEFkZCBhIGZ1bmN0aW9uIHByb2NfdGhlcm1h
bF9mcmVlX21zaSgpIHRvIGNhbGwgZGV2bV9mcmVlX2lycSgpIGZvcg0KPiBhbGwNCj4gc3VjY2Vz
c2Z1bGx5IHJlZ2lzdGVyZWQgSVJRIGhhbmRsZXJzLCB0aGVuIGNhbGwNCj4gcGNpX2ZyZWVfaXJx
X3ZlY3RvcnMoKS4NCj4gQ2FsbCB0aGlzIGZ1bmN0aW9uIGZvciBNU0kgY2xlYW51cC4NCj4gDQo+
IEZpeGVzOiA3YTlhOGM1ZmFmNDEgKCJ0aGVybWFsOiBpbnRlbDogaW50MzQweDogU3VwcG9ydCBN
U0kgaW50ZXJydXB0DQo+IGZvciBMdW5hciBMYWtlIikNCj4gUmVwb3J0ZWQtYnk6IFlpanVuIFNo
ZW4gPFlpanVuLnNoZW5AZGVsbC5jb20+DQo+IFRlc3RlZC1ieTogWWlqdW4gU2hlbiA8WWlqdW4u
c2hlbkBkZWxsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXMgUGFuZHJ1dmFkYQ0KPiA8
c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQoNClRoZSB3aG9sZSBwYXRjaCBz
ZXQgbG9va3MgZ29vZCB0byBtZS4NCg0KUmV2aWV3ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5n
QGludGVsLmNvbT4NCg0KdGhhbmtzLA0KcnVpDQo+IC0tLQ0KPiDCoC4uLi9wcm9jZXNzb3JfdGhl
cm1hbF9kZXZpY2VfcGNpLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTYNCj4gKysr
KysrKysrKysrKystLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9p
bnQzNDB4X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfZGV2aWNlX3BjaS4NCj4gYw0KPiBiL2Ry
aXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfZGV2
aWNlX3BjaS4NCj4gYw0KPiBpbmRleCAxMTQxMzY4OTNhNTkuLjJjOWM0NWViNWI0YSAxMDA2NDQN
Cj4gLS0tDQo+IGEvZHJpdmVycy90aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9wcm9jZXNz
b3JfdGhlcm1hbF9kZXZpY2VfcGNpLg0KPiBjDQo+ICsrKw0KPiBiL2RyaXZlcnMvdGhlcm1hbC9p
bnRlbC9pbnQzNDB4X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfZGV2aWNlX3BjaS4NCj4gYw0K
PiBAQCAtMjc4LDYgKzI3OCwxOCBAQCBzdGF0aWMgc3RydWN0IHRoZXJtYWxfem9uZV9wYXJhbXMg
dHpvbmVfcGFyYW1zID0NCj4gew0KPiDCoA0KPiDCoHN0YXRpYyBib29sIG1zaV9pcnE7DQo+IMKg
DQo+ICtzdGF0aWMgdm9pZCBwcm9jX3RoZXJtYWxfZnJlZV9tc2koc3RydWN0IHBjaV9kZXYgKnBk
ZXYsIHN0cnVjdA0KPiBwcm9jX3RoZXJtYWxfcGNpICpwY2lfaW5mbykNCj4gK3sNCj4gK8KgwqDC
oMKgwqDCoMKgaW50IGk7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IE1T
SV9USEVSTUFMX01BWDsgaSsrKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
ZiAocHJvY190aGVybWFsX21zaV9tYXBbaV0pDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2bV9mcmVlX2lycSgmcGRldi0+ZGV2LA0KPiBwcm9jX3Ro
ZXJtYWxfbXNpX21hcFtpXSwgcGNpX2luZm8pOw0KPiArwqDCoMKgwqDCoMKgwqB9DQo+ICsNCj4g
K8KgwqDCoMKgwqDCoMKgcGNpX2ZyZWVfaXJxX3ZlY3RvcnMocGRldik7DQo+ICt9DQo+ICsNCj4g
wqBzdGF0aWMgaW50IHByb2NfdGhlcm1hbF9zZXR1cF9tc2koc3RydWN0IHBjaV9kZXYgKnBkZXYs
IHN0cnVjdA0KPiBwcm9jX3RoZXJtYWxfcGNpICpwY2lfaW5mbykNCj4gwqB7DQo+IMKgwqDCoMKg
wqDCoMKgwqBpbnQgcmV0LCBpLCBpcnE7DQo+IEBAIC0zMTAsNyArMzIyLDcgQEAgc3RhdGljIGlu
dCBwcm9jX3RoZXJtYWxfc2V0dXBfbXNpKHN0cnVjdCBwY2lfZGV2DQo+ICpwZGV2LCBzdHJ1Y3Qg
cHJvY190aGVybWFsX3BjaQ0KPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+IMKgDQo+IMKg
ZXJyX2ZyZWVfbXNpX3ZlY3RvcnM6DQo+IC3CoMKgwqDCoMKgwqDCoHBjaV9mcmVlX2lycV92ZWN0
b3JzKHBkZXYpOw0KPiArwqDCoMKgwqDCoMKgwqBwcm9jX3RoZXJtYWxfZnJlZV9tc2kocGRldiwg
cGNpX2luZm8pOw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCj4gwqB9DQo+
IEBAIC0zOTcsNyArNDA5LDcgQEAgc3RhdGljIGludCBwcm9jX3RoZXJtYWxfcGNpX3Byb2JlKHN0
cnVjdCBwY2lfZGV2DQo+ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV8NCj4gwqANCj4g
wqBlcnJfZnJlZV92ZWN0b3JzOg0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKG1zaV9pcnEpDQo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwY2lfZnJlZV9pcnFfdmVjdG9ycyhwZGV2KTsN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByb2NfdGhlcm1hbF9mcmVlX21zaShw
ZGV2LCBwY2lfaW5mbyk7DQo+IMKgZXJyX3JldF90em9uZToNCj4gwqDCoMKgwqDCoMKgwqDCoHRo
ZXJtYWxfem9uZV9kZXZpY2VfdW5yZWdpc3RlcihwY2lfaW5mby0+dHpvbmUpOw0KPiDCoGVycl9k
ZWxfbGVnYWN5Og0KDQo=

