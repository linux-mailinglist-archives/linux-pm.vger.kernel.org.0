Return-Path: <linux-pm+bounces-21711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EA8A2F2E6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 17:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F31167BDA
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDB524F593;
	Mon, 10 Feb 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTNsG36i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3BF1F461F
	for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204076; cv=fail; b=k22T/YQ5AU241T5Jh/DP9R7jJpG/KCFQ47sj3aO+8DGp49KoJx6R4gkdr0drOZ70KSH03kAAimIIV0mcvTF0GXRkPcqFuaDKBxsUCkzN3tzrfPBxNMAC4mGuWZTryJS0yZ7b1WsyUp1YrPLLRUS+1Alq6MspOXtFQXPLmE6FEoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204076; c=relaxed/simple;
	bh=rw354mLxAG/dVPKbJhldB0RFj8XLWX/6FcwWLaAZm5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YGyBlnsJ3zMz4wxv5HmYg+HOb7vlWRTB8QJbE6SsKoKRA1JM/Q02r8/gQWo3hrhuQebmE6UbWce/vwG2XmdiYyFx6SHtZu3T1ai5GrmHbzAOhrQo+/gTJ4fRjrJXlnC0ZvbVymH+6AxgmPzUskRbhRcijhstkGpfQ5yHHfXeCNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTNsG36i; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739204075; x=1770740075;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rw354mLxAG/dVPKbJhldB0RFj8XLWX/6FcwWLaAZm5E=;
  b=DTNsG36iLt3DmW1HaC57Z1ugFZRFYP3WdBm7R3M7qSDQ2l7xdRN9g84a
   yUCdAn8Ae8POWMd8sNi8MeNyZs5gJvSDzbzjWl4GnBmOcAPuFJvxcv/mY
   9ue9fLL1Og16MWHyWYxaACc3Bg+j21mu9R6UqveKq8upapfmpPFNJKju5
   AN8hgjQBH+k/aLg853wiU2Ku0RjVXi4SjIFCfhnkYmcCGgFj3/9wUoNnm
   iVwgNZacqxfkhSVjNTeMq7GH2n/1PV9IlM/wMNNRIaC1L0KLooTds0lid
   DyGYRnRcZNuzgs+P8XSnMcRPhnEShJr6I/xoqgxuZUcSIldvyB6Tbc28q
   w==;
X-CSE-ConnectionGUID: gRQCLIW0QuG1+GDRtfn7jw==
X-CSE-MsgGUID: DmCxBqVFTuOULCOj2Glqcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="57205492"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="57205492"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 08:14:34 -0800
X-CSE-ConnectionGUID: 77uLN9cYQZqVVkz4BXSuVg==
X-CSE-MsgGUID: RiBLTR/ZTzKFrV+Es9JC/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="112068649"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 08:14:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 08:14:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 08:14:32 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 08:14:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5efmNAOg54d5r25SmKDR5/5GiKzvAWfVjz9c8SLyllVGcz1EiLuNNu6gT4KJgGRlHZUxHC1DG4ZxZslenfHooG26K0IPDlyq2P6De3tIXPAvfAILvnnDFbw2cl8lCS9WGVKXdUkwSZYsAZX1WuVWalvqgjnW2D2HlHCbivfFZF22Fp7nxHSGJfStCJHZhR1fBbDFL91gDH7u6VdjlN94cfuR+jOUdWvk+aOnuIRK32QTIMHUK6wvIRvdSKzAsQq678RcP1PoE2SIVEjd6VYAq58MatGEp7U16WIWTqaSXGdKgoyL7Wjdwzzn6ZFPFejsdY1Dgt0rFRfx5mznCifYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9iTD20EyV0L8WA8MZPSKMkXLGLyIXx4S9Cl3eaJIU0=;
 b=DcDqleQ1772LT/QtbYjYEWwqhdkIb+Amoe/cwJGxMrPXrN5g5ys0N3/x6QZhCwyseipmtsimfJQ9poaC5fSNpZCS2fJUtCJGQ1V5yEG/fW4sjVMZvPumw/VNmlLPImCW+JfS+ErkVdCimKEDE3HEtHwSn+ESOFFCyANNJ3bXjLgIUICghaPO7dNHKZhikLeGv7hSeGHjq12dTqzkpZhgs+l8OG42fP4jL+yoFREdNzW/uQeQPsBrySVWsGdBYZKNjvZq7Q8HuXrjM6rxojvzptBJ2zJBNeuOzGRgRhZ2vp0OeshFN8TpCOo47FO0QQ+pj41lO3chu64UzXvGUM9ETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA1PR11MB8221.namprd11.prod.outlook.com (2603:10b6:208:451::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 16:14:14 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%3]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 16:14:14 +0000
From: "Chen, Yu C" <yu.c.chen@intel.com>
To: 'Jie Zhan' <zhanjie9@hisilicon.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "zhenglifeng1@huawei.com"
	<zhenglifeng1@huawei.com>, "lihuisong@huawei.com" <lihuisong@huawei.com>,
	"wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>, "fanghao11@huawei.com"
	<fanghao11@huawei.com>, "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH] cpufreq: governor: Fix negative 'idle_time' handling in
 dbs_update()
Thread-Topic: [PATCH] cpufreq: governor: Fix negative 'idle_time' handling in
 dbs_update()
Thread-Index: AQHbe73F6gVnghDeF0SscghbTk27BrNAtCsg
Date: Mon, 10 Feb 2025 16:14:14 +0000
Message-ID: <DM4PR11MB6020403B3E3C9741C020C7F7A0F22@DM4PR11MB6020.namprd11.prod.outlook.com>
References: <20250210130659.3533182-1-zhanjie9@hisilicon.com>
In-Reply-To: <20250210130659.3533182-1-zhanjie9@hisilicon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6020:EE_|IA1PR11MB8221:EE_
x-ms-office365-filtering-correlation-id: eeb91139-4f16-4115-ea02-08dd49edf636
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8wQj6NmQS7AUce2AwMF/p/ZzqR+R9fcTlkW8Bf/kdSGTrE/ESEP+6NgwZUK5?=
 =?us-ascii?Q?uaQoijBEqfwiG09yaC2IeU1gQ1hJB0JmeJhvOtbzIIdRkKmUGV2javQoKZz+?=
 =?us-ascii?Q?2avFcZ5qKQ59NySbwytQmkgsNk5o9OQEmlnyeCLZXy1l946FTBVuFA/++Qyb?=
 =?us-ascii?Q?JAUz1F6xIeDFcdOPLfpgZqaDk+dWhsiBz5OZYozEJVCzymHmt94hqaioxg5o?=
 =?us-ascii?Q?m6bJL72x5J84Ssx1mCeTBfshOjA+0HseChL0gLckELt/jsbLb2Y31FgqbESt?=
 =?us-ascii?Q?G0FpZitmnE/qG7DqGLgWoh1VfBxKi2ExNXPxAQhE5n0nl+oDItzjsMPQ2zba?=
 =?us-ascii?Q?AOyCVr+N57lOHiXe/PQ11RDEQVui1ceQ3/xDOURU3XyMY5PXOmSF4T3+N0AP?=
 =?us-ascii?Q?lWncmIAsw0U61YyYEXcnwggh3P2knpGWgDrKiP+Ecc6hI8upDtdv8KFtR9GB?=
 =?us-ascii?Q?EWe8kjalZtXDJ/0M3Pu6NzyYYudmthdUJJD8oS7Netv1XpsEN/Q2OJRZfBpL?=
 =?us-ascii?Q?VPwgx700hHPdzviA1RGwYknlYUDvHYqQHEg6gwty9sy5F33QbqIZMtIvkrzn?=
 =?us-ascii?Q?cJmbUqLQs0MOnpSyugn9u55EDcRQCbHTLJAbxbM4Q/xJEPFMlOOtPXDKejwh?=
 =?us-ascii?Q?ci6ihDRz7ODaAq9UgpI8mwaJ7uZfOM3MMBZFZSvRpOcPQQ0b3e5ryQM1Nf9t?=
 =?us-ascii?Q?4rTQruH9yFysvSfBYoa+1VbI6XhYUassB6NyW2nsOKFG6eTu9a3iZCA2LxQ0?=
 =?us-ascii?Q?EYdxDfk2PGgn7WbtTBf2q5VmODmnUV+bvisJktKi9fFkKZhDHI5AQg2N0Jmu?=
 =?us-ascii?Q?8dPj+ZNWRVqTpyH8GEyJYVtp/Aj1fCU2hcXAke29thdGO1eP7ZCj3ac9nH0U?=
 =?us-ascii?Q?mOrkiW10g/BPfyHRI16b55zklXDi332TRz5qVzO6oF3QnOFOghfTYiQa6LOU?=
 =?us-ascii?Q?XE3BRqRxJwWadvp8rmJcuRnQWikLPVvWeoHYEGf2u36+kY39P6QEY0EvHc2c?=
 =?us-ascii?Q?kN2UAZePV6p1+Tyf0t2CQ3EZF6sKboK89fCEIFayXL67fFK0NnKTJ3LtCnHr?=
 =?us-ascii?Q?KR/9Ir90cB1L43HCME37pvRHKBsP0LnJxY2HY6+Yu/tp03J18gFw7T/dF8EH?=
 =?us-ascii?Q?BqlwdOQ4AJENKotz/UOeWZArKWi6tY/ku98rOcSWCymYlCr+CAX15/hVD2fA?=
 =?us-ascii?Q?NxhTe6tS7u0YhatsGODucvMYMFWhO9Evtt+MdjTuw7Y7EQu9k3y0Lvb8cYd5?=
 =?us-ascii?Q?X1wChK6LHwZ09wav4wM03sku1tLxvDJBaIAz9p/hVcXm89SwRolZ+M/4K3x7?=
 =?us-ascii?Q?z2hywxYZNy1nQeft78eyc7Y1xDGdUQJu82Y+EHdTtVy8zKYgPt5AEhlkNNKZ?=
 =?us-ascii?Q?CqCHj/COBGiIzidxQvuKD2meuZeIUGHjNJgffnxyt4iCU2o3O2lh+WI6cPD6?=
 =?us-ascii?Q?l4uTBr/1UrSboWznYpgfaZi5W9rcP4b0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y0a66qwITXFM/1p8we1aqlvGiDsIPnyEPNwOsuVUal9kKXEu9eId9Fw1/owk?=
 =?us-ascii?Q?hiIWdt/aUk9xGWckBXY3Le4Flj6Zl1R9VBMEgD4GK3I23y7rNSMX3BDltq36?=
 =?us-ascii?Q?RQ0eyTaQ1pl4QWgzyDyblFwenD4rEF9m9h88vzwH00nraJtJCS04qWfo7QBw?=
 =?us-ascii?Q?kGzOD836r2WRL+saO1oWF9L+Bp+Ld/GID6CQ1n+EL7o1F9ts550a3ClT+wBF?=
 =?us-ascii?Q?dds4EMY91W9+YupxzY5icuSPaoUx56xTFZN5kXigqVSrZqRrBpoFO3sO1hXE?=
 =?us-ascii?Q?RJbeQ/6/C9iJY/wRGSJWBZBVC7XuUeJpNxb4vs4pHr/9wZ7kvtapzj8Ctz/m?=
 =?us-ascii?Q?4GC+YgSdxoEdmRfaL1CBlDva3ThNAJBs6geLx3ZoAYun0aWmew2OG5XQlWit?=
 =?us-ascii?Q?RrAK101DbSn4ivMM8y86uEMdKAMibJcddLdqVwYMDq36u7AgzxYEB1ZJVEoR?=
 =?us-ascii?Q?K7+7RHhCrZEALCNIsdQ7QuYLLSHsomZpqjSv3yPZKtyiEZd5tUhyTPzY3VBd?=
 =?us-ascii?Q?Wx1qHysyADLpJQsHguLiCkdpPN2kDKF3ZbQlViDFIQ+85ZBkPet3EksUPO69?=
 =?us-ascii?Q?yrWXqoTKXZOAdZ5NfXDpE6spMnv/o85Fxj4Q9vxJe8uoCv+KCxqbhTzo/gzS?=
 =?us-ascii?Q?EicR5XAfh0nMJFkncG4rv5Gq/wMTsGdARN7TDj1lJiKhC4CW5NXkr+q1tXIG?=
 =?us-ascii?Q?N6O8N1upECw9btqieeBW/huuutaASd7/00UwxWX0Pkp9KHb4/AHlGwh07zXo?=
 =?us-ascii?Q?trr+zWPOtTdHTP2oxeFOjpQZ9Wead8Dn2tQrdfWLDEB7wRPOBiBbcLfIS8jp?=
 =?us-ascii?Q?on9fv+bKVoRA/Qcmx06gY2MEIrkRXLUn1mEZDbU2uAlzwc+4fYuqekrGvPYd?=
 =?us-ascii?Q?YMkJQtBxfz1WL/OBJ/t0jE+sS2G3bsSzlsGU0sRLdqRpNvW+UeiMJ5R991wE?=
 =?us-ascii?Q?bHT3/57qCZlobl02NWAfdE8EN5Tg429AilwCUoYU4xPqW41z1tItxzV/yqy2?=
 =?us-ascii?Q?VEPiCrbFMsgvdQUT7dZE1sm/F2cBu5VIE180fylNqInD8au0iDYqYz75Sz81?=
 =?us-ascii?Q?2SY06LrgU5bcw0u/afhn427I9fZLeGetPuovdTYVPI7qfDNd4vM8d+dClPSi?=
 =?us-ascii?Q?+IbzdUDmn4rRURfW9txno2bdz/G6Co4AHR+eByKplZbIp+UfpQoOvCcYfI6x?=
 =?us-ascii?Q?fTLlOtOlPHpcn8wLxnbl5Y/pa1E3MyUZoJatWbZ3UaiLAfS/4dGsq8pMIlxM?=
 =?us-ascii?Q?ZG+H72fl/ZY9hdHcsjmEfjo5IUhYPhVetcBVTZWX5QOBAADsV/jShk7SO+ip?=
 =?us-ascii?Q?ZXyukzBDu21ife/S3Kd0t+ls2JUZoleTV5CozUFwRcjkLEhfGi0cvLSBV/wG?=
 =?us-ascii?Q?PnoD7GXj8n3i10WuQ5TlMd7QDIpNsYOwroklQ1qd96KYI//2olwyqSdXhQ/x?=
 =?us-ascii?Q?r4/04Uk98w3yeLuj6jUSfPFgkMuKvk+DOmPjkQRrG+Y/KwCR8kajM4DrLY2z?=
 =?us-ascii?Q?sQTe6ZSyKGYBtKZsyWFj5D2zbYNGME3cAUfjOJezFa0n8eWu5ugprsLcidGH?=
 =?us-ascii?Q?aqKauSGqXDWxeX5ykXg5KeIJJ+xIWXoWQ99ZCOSs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb91139-4f16-4115-ea02-08dd49edf636
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 16:14:14.3070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXCbZtVtfiYHQ7frlSmlHF35i/labZY3LCdhMcPxh9ZNWKwXDRrPMMaGj5LTtLBoTr0P6Uxu+wMl+0E8FM111Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8221
X-OriginatorOrg: intel.com

Hi,

> -----Original Message-----
> From: Jie Zhan <zhanjie9@hisilicon.com>
> Sent: Monday, February 10, 2025 9:07 PM
> To: rafael@kernel.org; viresh.kumar@linaro.org
> Cc: linux-pm@vger.kernel.org; Chen, Yu C <yu.c.chen@intel.com>;
> linuxarm@huawei.com; jonathan.cameron@huawei.com;
> zhanjie9@hisilicon.com; zhenglifeng1@huawei.com; lihuisong@huawei.com;
> wanghuiqiang@huawei.com; fanghao11@huawei.com;
> prime.zeng@hisilicon.com
> Subject: [PATCH] cpufreq: governor: Fix negative 'idle_time' handling in
> dbs_update()
>=20
> We observed an issue that the cpu frequency can't raise up with a 100% cp=
u
> load when nohz is off and the 'conservative' governor is selected.
>=20
> 'idle_time' can be negative if it's obtained from get_cpu_idle_time_jiffy=
()
> when nohz is off.  This was found and explained in commit 9485e4ca0b48
> ("cpufreq: governor: Fix handling of special cases in dbs_update()").
>=20
> However, commit 7592019634f8 ("cpufreq: governors: Fix long idle detectio=
n
> logic in load calculation") introduced a comparison between 'idle_time' a=
nd
> 'samling_rate' to detect a long idle interval.  While 'idle_time' is conv=
erted to
> int before comparison, it's actually promoted to unsigned again when
> compared with an unsigned 'sampling_rate'.  Hence, this leads to wrong id=
le
> interval detection when it's in fact 100% busy and sets policy_dbs-
> >idle_periods to a very large value.  'conservative' adjusts the frequenc=
y to
> minimum because of the large 'idle_periods', such that the frequency can'=
t
> raise up.  'Ondemand' doesn't use policy_dbs->idle_periods so it fortunat=
ely
> avoids the issue.
>=20
> Modify negative 'idle_time' to 0 before any use of it in dbs_update().
>=20
> Fixes: 7592019634f8 ("cpufreq: governors: Fix long idle detection logic i=
n load
> calculation")
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 41 ++++++++++++++----------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq_governor.c
> b/drivers/cpufreq/cpufreq_governor.c
> index af44ee6a6430..cd045ca2268c 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -147,6 +147,20 @@ unsigned int dbs_update(struct cpufreq_policy
> *policy)
>=20
>  		idle_time =3D cur_idle_time - j_cdbs->prev_cpu_idle;
>  		j_cdbs->prev_cpu_idle =3D cur_idle_time;
> +		/*
> +		 * idle_time can be negative if cur_idle_time is returned by
> +		 * get_cpu_idle_time_jiffy() when NO_HZ is off.  In that case
> +		 * idle_time is roughly equal to the difference between
> +		 * time_elapsed and "busy time" obtained from CPU statistics.
> +		 * Then, the "busy time" can end up being greater than
> +		 * time_elapsed (for example, if jiffies_64 and the CPU
> +		 * statistics are updated by different CPUs), so idle_time may
> +		 * in fact be negative.  That means, though, that the CPU was
> +		 * busy all the time (on the rough average) during the last
> +		 * sampling interval, so idle_time should be regarded as 0 in
> +		 * order to make the further process correct.
> +		 */
> +		idle_time =3D (int)idle_time < 0 ? 0 : idle_time;

Thanks for catching this. I was wondering if it would be safer to be conver=
ted into something below:
idle_time =3D cur_idle_time  >  j_cdbs->prev_cpu_idle  ? cur_idle_time - j_=
cdbs->prev_cpu_idle : 0;
Because I was thinking if comparing (int)idle_time with X (X could be any t=
ype)
is compiler dependent?

thanks,
Chenyu

>=20
>  		if (ignore_nice) {
>  			u64 cur_nice =3D kcpustat_field(&kcpustat_cpu(j),
> CPUTIME_NICE, j); @@ -162,7 +176,7 @@ unsigned int dbs_update(struct
> cpufreq_policy *policy)
>  			 * calls, so the previous load value can be used then.
>  			 */
>  			load =3D j_cdbs->prev_load;
> -		} else if (unlikely((int)idle_time > 2 * sampling_rate &&
> +		} else if (unlikely(idle_time > 2 * sampling_rate &&
>  				    j_cdbs->prev_load)) {
>  			/*
>  			 * If the CPU had gone completely idle and a task has
> @@ -189,30 +203,13 @@ unsigned int dbs_update(struct cpufreq_policy
> *policy)
>  			load =3D j_cdbs->prev_load;
>  			j_cdbs->prev_load =3D 0;
>  		} else {
> -			if (time_elapsed >=3D idle_time) {
> -				load =3D 100 * (time_elapsed - idle_time) /
> time_elapsed;
> -			} else {
> -				/*
> -				 * That can happen if idle_time is returned by
> -				 * get_cpu_idle_time_jiffy().  In that case
> -				 * idle_time is roughly equal to the difference
> -				 * between time_elapsed and "busy time"
> obtained
> -				 * from CPU statistics.  Then, the "busy time"
> -				 * can end up being greater than
> time_elapsed
> -				 * (for example, if jiffies_64 and the CPU
> -				 * statistics are updated by different CPUs),
> -				 * so idle_time may in fact be negative.  That
> -				 * means, though, that the CPU was busy all
> -				 * the time (on the rough average) during the
> -				 * last sampling interval and 100 can be
> -				 * returned as the load.
> -				 */
> -				load =3D (int)idle_time < 0 ? 100 : 0;
> -			}
> +			load =3D time_elapsed > idle_time ?
> +			       100 * (time_elapsed - idle_time) / time_elapsed :
> +			       0;
>  			j_cdbs->prev_load =3D load;
>  		}
>=20
> -		if (unlikely((int)idle_time > 2 * sampling_rate)) {
> +		if (unlikely(idle_time > 2 * sampling_rate)) {
>  			unsigned int periods =3D idle_time / sampling_rate;
>=20
>  			if (periods < idle_periods)
> --
> 2.33.0


