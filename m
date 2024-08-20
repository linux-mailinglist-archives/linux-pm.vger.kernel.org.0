Return-Path: <linux-pm+bounces-12532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9D5957F21
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3DF1F2286C
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CCB16A39E;
	Tue, 20 Aug 2024 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OResOfh9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CD518E368;
	Tue, 20 Aug 2024 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137893; cv=fail; b=CRNU2rTwT48LTEXz0HHEIdOV751F9t+R+R+m0mrVekHX6pXMu+JEggrvyiCXE1/JES6g/jkcDqsD93cVc+sl7p+XYmI5OyBsZ6cBIMREHTzr/jxLi9RL9M8i+e1ms9lRJG+cc5zUuA9i2l0ns/UfBd3/Fi3fEvqZhFBTSgILz1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137893; c=relaxed/simple;
	bh=ENCMUgk/MeO7Yeohp6TLGHeZhmtqOvf26RArRbSvE8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qUYqDzhVaGDnoJg1WaHHrHpgY4WiQ0d0NcvrO+0i55XruqUclkj0dKGGeTcDC5dQyIQ622FIKSmkh+LxN2PMySEC/1C5/QwSOcDNXUfhdsz/oVhQ0LUkoVlbQlGvzyWrnDHBxbFK8LMAf1KOiGI4jZrr8Nt5k3XUNCzwldK/ouw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OResOfh9; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724137891; x=1755673891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ENCMUgk/MeO7Yeohp6TLGHeZhmtqOvf26RArRbSvE8g=;
  b=OResOfh9n8i5lex1O9vS2NlL959fTcLKFDmpN9nfauB6qyza4OmEfFS2
   5NlAuKJB6ocadx34VvU7YPm/Em4LQFZy/TB/liB1cvk8XwXZdOGCmd7z8
   GsfkRKjllBPwrHzKZ2GmnTz1s+rUHIm4GSVgn5F6G9J/RbCXMw4uGzqE3
   yH+ktoogU5VlFTPJebOg+HrgAb3ITjPFWL2coagz+NorC0ICL6x+CHlc0
   fGC5RWMYgFNYJhIMhvE+es4bMMVO99lb6bBI4R/Owz8DKTpaijtKHTYfo
   CpRp0IUegbU2bN1gWLG5yFucY7deaYlwodl6+0uAqChWcbSpjKhaySaMr
   A==;
X-CSE-ConnectionGUID: GWfLHqPyQem/SHphZM53DA==
X-CSE-MsgGUID: Nb10fWyPTsGeUKQ1jwNF/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33572749"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="33572749"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:11:31 -0700
X-CSE-ConnectionGUID: CFIEm120QPGzDP1QmG8EEA==
X-CSE-MsgGUID: KGV62fPoQ/mBCawqr9pZNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="91352697"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 00:11:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:11:21 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:11:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 00:11:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 00:11:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OELhN+OOiRvTUTY65DKkmisMr6whS+MZniTWddBsXXYRWvyt9LD0c+XkNWxJJ6QExTgjFeu5gwJLNjqMCmVDwJhfam+bBeGeKfuIaSI+9creAFE15MTnzwzomAg8MoXIZmvKCe3K5+ESJjZwYtSHyF7mPRvMFH6Kq8qwMAEShYVzU47yg5JH6uefhu6HsgUrJqjhWC+KKegp9P0jO0AdFpJ1Pk/JGgXaS7RslpfRksKRHg6gm+1XtxHAw2N1vq0NNhC8tpdcTZfn19w8eBFfv2lNpUFPJYwUrRp6PgHv8TCIeM6p2wxqvAyDTUgTBNW3BVY51AMWLljps9N3flNvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENCMUgk/MeO7Yeohp6TLGHeZhmtqOvf26RArRbSvE8g=;
 b=ix+mJYfyoklzjDk+BuQTEkdpvJuqrOboV2Lj1m8dBA1bm1Z1gD14+HpCJm59u1hYl06X+LdObTRIgmbton7K2oJpiKaJIYr4oMTMbT+dz205GTRlfaNJg9mbwlSpizklZS51LVxzBSpjzJ1u+ByWcJ3qJA2PxVH1Vu9Lep3D7ts2cJMsRmOlhkfH+tZCOdLfxQQ9bFxjpGfWbNU8vPpogONtRSZtpQ/PZllbrDxoz53xJe+Fbj/L+TEpSB56TA0fIBRpnAx4usZM89CL6JXfv/8w+X4G8CJ4IjFdFMzVfw4zS7vSEl5aCgdv4bLwGMI3pd5gT24/GY/ExtA/AshYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 07:11:18 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:11:18 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 14/14] thermal: core: Clean up trip bind/unbind
 functions
Thread-Topic: [PATCH v3 14/14] thermal: core: Clean up trip bind/unbind
 functions
Thread-Index: AQHa8lWSOM10BBCydEO3ZWUprZAz8LIvu6GA
Date: Tue, 20 Aug 2024 07:11:18 +0000
Message-ID: <b691385fe2be103d4bb18c919f82fdfe8c04b0f3.camel@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
	 <1831773.TLkxdtWsSY@rjwysocki.net>
In-Reply-To: <1831773.TLkxdtWsSY@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5125:EE_
x-ms-office365-filtering-correlation-id: ba48582f-4518-439b-e929-08dcc0e749c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cTh0U3ZYN08rbkxSUC9YaUFLRXdZL01QNktMSlhzTW9YMkFLdzNlWWVmcm5m?=
 =?utf-8?B?THVsL01CV3JuMmx3cEJNZkZvOC9UcTNwRjhPL091TlBZV2luaUFZdk1QTzJF?=
 =?utf-8?B?ckVwTDZYbjBidkt4WnJyVkhRSkJlMDRyd3doWmhDQmZFblYrSnAyZmdkSHVy?=
 =?utf-8?B?NkNUcm5USitlQXNoSTc2SklvaWFwTjB3SGRNa0RKaUkwTFZNSTlINU9KZ1kz?=
 =?utf-8?B?M00zcEgzWHk0ekNWUndvL05oZGUrNVZlckJLbldHZXo0dzhsK2Z4dXNnOG5K?=
 =?utf-8?B?RzRMek5CSnNJMmliK0g1L0hMRzdTOTdraGRVbzF1K0FGY01CQnEvWnppZGcw?=
 =?utf-8?B?eGgvTkY0Q2lBdEJmWUF6WXdRMDR3VHA2YmQyQ09haEdBSnBPdzd2NXpjKzR2?=
 =?utf-8?B?aU9lcmR1Z0FIUVBuTnc2WXpVNmE2S1lubW1DZ0tXMUplaGpSZFBNMWpBaU9q?=
 =?utf-8?B?VERYa05RVnZZQTRxaUZxQ24yVk5pUXJ3WEU5Q0dXeGNPY3V6QnVNTXBIQ3h3?=
 =?utf-8?B?VkVCelAvYWl4cnVMbzZPaDE4bXp0bUF5VGluS2NjZjNSelFLZjYraWxoVXdS?=
 =?utf-8?B?Q2w4bTk1a2l1eFdzN3BVU1luK0IxYzE5Y0I1eVVuTVdSMUprcEVwYnNPTkVY?=
 =?utf-8?B?b09BenBXc2pGcVRtS1J0ZGVhQnYyZU9FVVBtSHZwa3puemkyQmFvRkY0M3V3?=
 =?utf-8?B?aTJRS3UrYk1vMVdITnpUUzcrc1czTU5nbzZJSGlCcGxrV2M2YWJiQVRKR0pk?=
 =?utf-8?B?TjU4bENUSGc1QVcxZzRuK0x0TVFLKzBPR01CZVBUTkd2RWhDQ2FGVUdjZjVq?=
 =?utf-8?B?c2tBRUpaWVJlZ0NWSEU4blJFVUtpRlVpei9NS25jYXdyZTRvK0J6YmJUOUhl?=
 =?utf-8?B?NmpUVW5zcTZqamlaMXdzMW40ZlFKTE9OSEwzR3NYKzJQZHNBZ2c5V1lORWt4?=
 =?utf-8?B?cjRIZ1hiQUU0L3VQa1JPWHFVbkdteUxCL3E3K1BYQ1Q5L05paUJiZVZwSmV5?=
 =?utf-8?B?RzZyZnFnbldWRGhFRmlDVE9KblY0cUhHcnh0YXBURlNuZ3J1TFl3UktPY3c3?=
 =?utf-8?B?R0RVL1RDUHUxcVloZjFueDFnL0VtNkpOTkpsbDljL1l2T1ZiTXlBWGh1bTl2?=
 =?utf-8?B?Rm9HVzQ4TG1UM0wzOVlGeFU0VzkzZmpBU3Q3aFlURkFySkJtZFlvL0xwSW11?=
 =?utf-8?B?ZVhkQmExOG5pOTNrWWZqM0RLTlRRUTM0TzAxdVBzYW4vcURkNHArWkUydTFa?=
 =?utf-8?B?WHQ0SnQyeGYxZ3hObUlvbm13YjVhYUxLVGVKUGhkWStFbDExT2lzQy9ubGUw?=
 =?utf-8?B?SFl6RXdMajRGSWpYWmtYY0dudmxxS2FLRi9LSkd0OVFnSXkvaDhJSzBvS21a?=
 =?utf-8?B?WFE2K0ZnckVHOGJpN28vcHMyOG1FR1FQVGNLbmY1U0Qxa0UrYTBlR2lUTGRr?=
 =?utf-8?B?c1FwK2dxVHhXeGhDSE4wS0xYWlBrN2owd3JXVFFpK2dCM0Y1ck5YV0Q5Tnhh?=
 =?utf-8?B?bmtKRVg3Z0hFTjNoZUJoUkExNTZwellEOEQzWGF3VVgvd3FuaVJBbXdUUGRG?=
 =?utf-8?B?WjlxNms1a3dPUGsxVTU0TUtpdEJEVDNQKzNteWVSNGVGL1o0Tkc2OWNmMFR3?=
 =?utf-8?B?anlGMUJCNkxuSHhkSG0rb3hHS2puMy9LZzV6L1BpcnRYT1RuK0JQekFHMUtq?=
 =?utf-8?B?OTJGYXBMWTNaam9OVGlGd3o3MnpGZUtYZ0d2dkNOMDFOZDNXOVNQMldpeWVa?=
 =?utf-8?B?bXBYRzJXYU1HY1N3dEJUQm11UWwvdjFiOUpCeHdVbXZqcFY5dzZydDhERWhY?=
 =?utf-8?Q?AYdNzgPKuqvn9jS9rlIzghUmO5P28N/L9pCwc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUtpaFZUOU9jb1dkZU1XYUpydXo4QldqTmczd3B4QWxNRUJEdThJNVMxTkRW?=
 =?utf-8?B?T2hLNFNBeXZHNDRGSXpQV2lDSDdXSEJhbTA0ZDkzdGE5L2tiSVlhWUFLQ2NE?=
 =?utf-8?B?bTAxOFlOU0dLeTg0SllyeFhVd2srbkU2M0tJaU1ZdjFrVjBSM1I3SXZYclg3?=
 =?utf-8?B?OXcrRVNMc0tUREhURHA2b0piNzFVOWFJVTNKRGVPc1ZLWWZRQi9ZOWNVVU5l?=
 =?utf-8?B?bmJGanphaHpMQVBUbDdabWxhVkQ4Q00zMEIwSWF1cVhkMlBOU2lseTc1NS9y?=
 =?utf-8?B?K0wvT00rRWNTWjN5c1Y4WTlxd0JFZktOVHM2alhBVEN3b1ptRldlVGdia1VE?=
 =?utf-8?B?R2VZSUtLaGNzSG1zb3lyU0VZM1NMcDJ3TlFNR25zaVZCV1V4UU1PTVpYWUVK?=
 =?utf-8?B?ZFpob0tMK3JKeGhVT1FTVjh6YWpheTduZHpma3ljL29kNzdOMHdaV1ZFVm9n?=
 =?utf-8?B?ZUpMK3FpaTdodGlNRWZ2NVd3MUkxc0ZzVFl2R0w2ZDJrZm9WbTJHaHdFYXBv?=
 =?utf-8?B?KytiNGlhVk5IdFJOY2k3dHRSTDJ6Ny9qcTRhdnVrK3JkT08wN2lzZmoreGds?=
 =?utf-8?B?UENDK0FqYzdLaVd0bGhjdlpMTHpFTm9sbmU0QzF1eGJ2NTNlTWNYbGhMQm1p?=
 =?utf-8?B?QVJ4aStOMk4zb3J2dWlSbTJPK3RjRE85WUhUdVc0ZSt4NFhVS2cxdW5WTkdN?=
 =?utf-8?B?VU90TFB3SEVheTR1OFlUTmc3VEgvTC9uc3RSMmdBTkMxS1ZIcGhGaEhjMURp?=
 =?utf-8?B?anRnVDJObDZtSGdPc2FBNUpONFdONmlvT2tZVXhuSTVtUEtGVU1CSm11TWlB?=
 =?utf-8?B?SC9tSkhLYWIwTVV0eXJTb0lnY2JiYVplK0V1L2dObjFzVnhYUGVubExkMDY0?=
 =?utf-8?B?Z2dEZE9Ya3NnYVhHL3grNk9rTjU3Vmp0ZnhneFV2U0xQQStRQnp5NWtiTm9C?=
 =?utf-8?B?QUNodXlDY0Zjd1puZXpyV1cxYlRnQlNTQkVBV290Vkg5clNsNG1NTkhoTFR3?=
 =?utf-8?B?bk4wQi9FQ3F3SC9iWXFVNzlWcXJPcEpwNUFaTUxIZ1E5Nld6eTViVzVxcU9y?=
 =?utf-8?B?dTRZajZ6VUVCQm5vS2NRTi9IenJsanRpZ25GMFNKbHBUUHdDWDgvV3dqRXd3?=
 =?utf-8?B?TDJ0MkNwU21ia1ZVNHlBcjZ0TnYwR01BUGNKSFlNTC9pRU1TTVREdGRiMXJq?=
 =?utf-8?B?SFh1TW5yaGJ0cTcyWFJnVXJSQkU3SmVJTFFDUkZwQUJ5YjRpcVVKTFF6RlF0?=
 =?utf-8?B?UjkwYWk0Q21WS2pvZVNwTmxwSno1bWtmeHFMT29TTUpSakMzNEQ1QmdJS1M3?=
 =?utf-8?B?cVZyK0QyVHFSNVNab05qWmZVVXRBNXVVNHNsMmZJblZ5dVMvNUVJQUhYV2xI?=
 =?utf-8?B?OTBmcmJlNWdqaFNSRUtaclJGYUFRaHRhMkVVMXAveGtIV3VIbGREQ0VtWGxm?=
 =?utf-8?B?amxBaUpaUkNoV2JNems0RTc3Rm9LaDJmUkxuV1NRaEM3N0JNa3NhbFd1WFdU?=
 =?utf-8?B?UTc1dHh6S05ONkhyWWlOeFBaQjRwUnk0LzV1ZFFzclZPNzJQRnNnd3poSi96?=
 =?utf-8?B?RjNlSFRNbk5KOFFMY3RTOUlzTDl2dHNSWE1sWFJtZC9RMUN4V0lXcUFhS1ZF?=
 =?utf-8?B?T1JNc2hIZUhORUNNQzZnYlJ2VUw1bVV1dHkxb3p3dFJrc0ZqazJJcDI5Nmc2?=
 =?utf-8?B?azhCQTJQM1NFOHlKRjBsSUprdmhzaU5RVjhhMGQ3aGtjS2t3RlJtU01XcXE2?=
 =?utf-8?B?bTdtZWpmVnNEM3psU2t3VVM5K3ZUWTNhTlp2U0JxVENGdko1RlBYQTdwYmVN?=
 =?utf-8?B?SUphdVJBQjlLcmY1ck1KVWwvSjJiQ3oxQ0VEaHJUZG1DN2EzLzI0U244TkhH?=
 =?utf-8?B?MHdMaS92aVV4Z1RUMGwyMi9oT0gvRmdQM1BDR1JGSVRhRVNsM3NFdkF3bUhQ?=
 =?utf-8?B?WndYenlPZXpoUElrY0U4NEptUjhzN3FPak9YaGZaRzJ1NTRaS0g3WmxzVjZP?=
 =?utf-8?B?OHl0dFlQMU5aemNpTTNHdmc1RWxnSkNnZUJ2NTdyaG1nMW5nUnR5bFVQQkps?=
 =?utf-8?B?QUVPeSt6U2RJSjd5OWRkTUk0Uk5xNThnbm44U3krTms1TnN3Sys3ZVlmNU9Y?=
 =?utf-8?B?Y2RyVE1kWkYzUGJOY25ndUF0V1FlTUhka3ViaEhZa3pjbnBuWFFWR291TjR4?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68492A4EB35D3447A395418C6660F1B3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba48582f-4518-439b-e929-08dcc0e749c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 07:11:18.7098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVMsOqflXBUKo7GzIB9N2RpMYCzalwBo1diFhb0n5jcHFEtR5sY59ay74Q1muuaza2DNgK43MhshgA1U4ugF0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDE4OjMzICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
Cj4gCj4gTWFrZSB0aGVybWFsX2JpbmRfY2Rldl90b190cmlwKCkgdGFrZSBhIHN0cnVjdCBjb29s
aW5nX3NwZWMgcG9pbnRlcgo+IHRvIHJlZHVjZSB0aGUgbnVtYmVyIG9mIGl0cyBhcmd1bWVudHMs
IGNoYW5nZSB0aGUgcmV0dXJuIHR5cGUgb2YKPiB0aGVybWFsX3VuYmluZF9jZGV2X2Zyb21fdHJp
cCgpIHRvIHZvaWQgYW5kIHJlYXJyYW5nZSB0aGUgY29kZSBpbgo+IHRoZXJtYWxfem9uZV9jZGV2
X2JpbmRpbmcoKSB0byByZWR1Y2UgdGhlIGluZGVudGF0aW9uIGxldmVsLgo+IAo+IE5vIGludGVu
dGlvbmFsIGZ1bmN0aW9uYWwgaW1wYWN0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFJhZmFlbCBKLiBX
eXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4KClJldmlld2VkLWJ5OiBaaGFuZyBS
dWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+Cgp0aGFua3MsCnJ1aQoKPiAtLS0KPiAKPiB2MiAtPiB2
MzogU3ViamVjdCBmaXgKPiAKPiB2MS0+IHYyOiBObyBjaGFuZ2VzCj4gCj4gLS0tCj4gwqBkcml2
ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgfMKgwqAgNTQgKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tCj4gLS0tLS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25z
KCspLCAzMyBkZWxldGlvbnMoLSkKPiAKPiBJbmRleDogbGludXgtcG0vZHJpdmVycy90aGVybWFs
L3RoZXJtYWxfY29yZS5jCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMv
dGhlcm1hbC90aGVybWFsX2NvcmUuYwo+ICsrKyBsaW51eC1wbS9kcml2ZXJzL3RoZXJtYWwvdGhl
cm1hbF9jb3JlLmMKPiBAQCAtNzU3LDE1ICs3NTcsNyBAQCBzdHJ1Y3QgdGhlcm1hbF96b25lX2Rl
dmljZSAqdGhlcm1hbF96b25lCj4gwqAgKiBAdHo6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBwb2ludGVyIHRvIHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlCj4gwqAgKiBAdHJpcDrC
oMKgwqDCoMKgwqB0cmlwIHBvaW50IHRoZSBjb29saW5nIGRldmljZXMgaXMgYXNzb2NpYXRlZCB3
aXRoIGluCj4gdGhpcyB6b25lLgo+IMKgICogQGNkZXY6wqDCoMKgwqDCoMKgcG9pbnRlciB0byBz
dHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZQo+IC0gKiBAdXBwZXI6wqDCoMKgwqDCoHRoZSBN
YXhpbXVtIGNvb2xpbmcgc3RhdGUgZm9yIHRoaXMgdHJpcCBwb2ludC4KPiAtICrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoFRIRVJNQUxfTk9fTElNSVQgbWVhbnMgbm8gdXBwZXIgbGltaXQsCj4g
LSAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhbmQgdGhlIGNvb2xpbmcgZGV2aWNlIGNhbiBi
ZSBpbiBtYXhfc3RhdGUuCj4gLSAqIEBsb3dlcjrCoMKgwqDCoMKgdGhlIE1pbmltdW0gY29vbGlu
ZyBzdGF0ZSBjYW4gYmUgdXNlZCBmb3IgdGhpcyB0cmlwCj4gcG9pbnQuCj4gLSAqwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBUSEVSTUFMX05PX0xJTUlUIG1lYW5zIG5vIGxvd2VyIGxpbWl0LAo+
IC0gKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYW5kIHRoZSBjb29saW5nIGRldmljZSBjYW4g
YmUgaW4gY29vbGluZyBzdGF0ZSAwLgo+IC0gKiBAd2VpZ2h0OsKgwqDCoMKgVGhlIHdlaWdodCBv
ZiB0aGUgY29vbGluZyBkZXZpY2UgdG8gYmUgYm91bmQgdG8gdGhlCj4gLSAqwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB0aGVybWFsIHpvbmUuIFVzZSBUSEVSTUFMX1dFSUdIVF9ERUZBVUxUIGZv
ciB0aGUKPiAtICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRlZmF1bHQgdmFsdWUKPiArICog
QGM6wqDCoMKgwqDCoMKgwqDCoMKgY29vbGluZyBzcGVjaWZpY2F0aW9uIGZvciBAdHJpcCBhbmQg
QGNkZXYKPiDCoCAqCj4gwqAgKiBUaGlzIGludGVyZmFjZSBmdW5jdGlvbiBiaW5kIGEgdGhlcm1h
bCBjb29saW5nIGRldmljZSB0byB0aGUKPiBjZXJ0YWluIHRyaXAKPiDCoCAqIHBvaW50IG9mIGEg
dGhlcm1hbCB6b25lIGRldmljZS4KPiBAQCAtNzc2LDggKzc2OCw3IEBAIHN0cnVjdCB0aGVybWFs
X3pvbmVfZGV2aWNlICp0aGVybWFsX3pvbmUKPiDCoHN0YXRpYyBpbnQgdGhlcm1hbF9iaW5kX2Nk
ZXZfdG9fdHJpcChzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHosCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNvbnN0IHN0cnVjdCB0aGVybWFsX3RyaXAgKnRyaXAsCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlCj4gKmNkZXYsCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5z
aWduZWQgbG9uZyB1cHBlciwgdW5zaWduZWQKPiBsb25nIGxvd2VyLAo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHVuc2lnbmVkIGludCB3ZWlnaHQpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGNvb2xpbmdfc3Bl
YyAqYykKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHRoZXJtYWxfaW5zdGFuY2UgKmRl
djsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHRoZXJtYWxfaW5zdGFuY2UgKnBvczsKPiBAQCAt
NzkxLDE3ICs3ODIsMTcgQEAgc3RhdGljIGludCB0aGVybWFsX2JpbmRfY2Rldl90b190cmlwKHN0
cgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gwqAK
PiDCoMKgwqDCoMKgwqDCoMKgLyogbG93ZXIgZGVmYXVsdCAwLCB1cHBlciBkZWZhdWx0IG1heF9z
dGF0ZSAqLwo+IC3CoMKgwqDCoMKgwqDCoGlmIChsb3dlciA9PSBUSEVSTUFMX05PX0xJTUlUKQo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsb3dlciA9IDA7Cj4gK8KgwqDCoMKgwqDC
oMKgaWYgKGMtPmxvd2VyID09IFRIRVJNQUxfTk9fTElNSVQpCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGMtPmxvd2VyID0gMDsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoGlmICh1cHBl
ciA9PSBUSEVSTUFMX05PX0xJTUlUKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHVwcGVyID0gY2Rldi0+bWF4X3N0YXRlOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChjLT51cHBlciA9
PSBUSEVSTUFMX05PX0xJTUlUKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGMt
PnVwcGVyID0gY2Rldi0+bWF4X3N0YXRlOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgdXBwZXJfbm9fbGltaXQgPSB0cnVlOwo+IMKgwqDCoMKgwqDCoMKgwqB9IGVsc2Ugewo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdXBwZXJfbm9fbGltaXQgPSBmYWxzZTsKPiDC
oMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgaWYgKGxvd2VyID4gdXBwZXIg
fHwgdXBwZXIgPiBjZGV2LT5tYXhfc3RhdGUpCj4gK8KgwqDCoMKgwqDCoMKgaWYgKGMtPmxvd2Vy
ID4gYy0+dXBwZXIgfHwgYy0+dXBwZXIgPiBjZGV2LT5tYXhfc3RhdGUpCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKg
wqBkZXYgPSBremFsbG9jKHNpemVvZigqZGV2KSwgR0ZQX0tFUk5FTCk7Cj4gQEAgLTgxMCwxMSAr
ODAxLDExIEBAIHN0YXRpYyBpbnQgdGhlcm1hbF9iaW5kX2NkZXZfdG9fdHJpcChzdHIKPiDCoMKg
wqDCoMKgwqDCoMKgZGV2LT50eiA9IHR6Owo+IMKgwqDCoMKgwqDCoMKgwqBkZXYtPmNkZXYgPSBj
ZGV2Owo+IMKgwqDCoMKgwqDCoMKgwqBkZXYtPnRyaXAgPSB0cmlwOwo+IC3CoMKgwqDCoMKgwqDC
oGRldi0+dXBwZXIgPSB1cHBlcjsKPiArwqDCoMKgwqDCoMKgwqBkZXYtPnVwcGVyID0gYy0+dXBw
ZXI7Cj4gwqDCoMKgwqDCoMKgwqDCoGRldi0+dXBwZXJfbm9fbGltaXQgPSB1cHBlcl9ub19saW1p
dDsKPiAtwqDCoMKgwqDCoMKgwqBkZXYtPmxvd2VyID0gbG93ZXI7Cj4gK8KgwqDCoMKgwqDCoMKg
ZGV2LT5sb3dlciA9IGMtPmxvd2VyOwo+IMKgwqDCoMKgwqDCoMKgwqBkZXYtPnRhcmdldCA9IFRI
RVJNQUxfTk9fVEFSR0VUOwo+IC3CoMKgwqDCoMKgwqDCoGRldi0+d2VpZ2h0ID0gd2VpZ2h0Owo+
ICvCoMKgwqDCoMKgwqDCoGRldi0+d2VpZ2h0ID0gYy0+d2VpZ2h0Owo+IMKgCj4gwqDCoMKgwqDC
oMKgwqDCoHJlc3VsdCA9IGlkYV9hbGxvYygmdHotPmlkYSwgR0ZQX0tFUk5FTCk7Cj4gwqDCoMKg
wqDCoMKgwqDCoGlmIChyZXN1bHQgPCAwKQo+IEBAIC04ODcsMTIgKzg3OCwxMCBAQCBmcmVlX21l
bToKPiDCoCAqIFRoaXMgaW50ZXJmYWNlIGZ1bmN0aW9uIHVuYmluZCBhIHRoZXJtYWwgY29vbGlu
ZyBkZXZpY2UgZnJvbSB0aGUKPiBjZXJ0YWluCj4gwqAgKiB0cmlwIHBvaW50IG9mIGEgdGhlcm1h
bCB6b25lIGRldmljZS4KPiDCoCAqIFRoaXMgZnVuY3Rpb24gaXMgdXN1YWxseSBjYWxsZWQgaW4g
dGhlIHRoZXJtYWwgem9uZSBkZXZpY2UKPiAudW5iaW5kIGNhbGxiYWNrLgo+IC0gKgo+IC0gKiBS
ZXR1cm46IDAgb24gc3VjY2VzcywgdGhlIHByb3BlciBlcnJvciB2YWx1ZSBvdGhlcndpc2UuCj4g
wqAgKi8KPiAtc3RhdGljIGludCB0aGVybWFsX3VuYmluZF9jZGV2X2Zyb21fdHJpcChzdHJ1Y3Qg
dGhlcm1hbF96b25lX2RldmljZQo+ICp0eiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0
IHN0cnVjdCB0aGVybWFsX3RyaXAKPiAqdHJpcCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdAo+IHRoZXJtYWxfY29vbGluZ19kZXZpY2UgKmNkZXYpCj4gK3N0YXRpYyB2b2lkIHRoZXJt
YWxfdW5iaW5kX2NkZXZfZnJvbV90cmlwKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlCj4gKnR6
LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgdGhlcm1hbF90cmlwCj4g
KnRyaXAsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdAo+IHRoZXJtYWxfY29vbGlu
Z19kZXZpY2UgKmNkZXYpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCB0aGVybWFsX2lu
c3RhbmNlICpwb3MsICpuZXh0Owo+IMKgCj4gQEAgLTkxMiw3ICs5MDEsNyBAQCBzdGF0aWMgaW50
IHRoZXJtYWxfdW5iaW5kX2NkZXZfZnJvbV90cmlwCj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoMKg
wqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZjZGV2LT5sb2NrKTsKPiDCoAo+IC3CoMKgwqDCoMKg
wqDCoHJldHVybiAtRU5PREVWOwo+ICvCoMKgwqDCoMKgwqDCoHJldHVybjsKPiDCoAo+IMKgdW5i
aW5kOgo+IMKgwqDCoMKgwqDCoMKgwqBkZXZpY2VfcmVtb3ZlX2ZpbGUoJnR6LT5kZXZpY2UsICZw
b3MtPndlaWdodF9hdHRyKTsKPiBAQCAtOTIwLDcgKzkwOSw2IEBAIHVuYmluZDoKPiDCoMKgwqDC
oMKgwqDCoMKgc3lzZnNfcmVtb3ZlX2xpbmsoJnR6LT5kZXZpY2Uua29iaiwgcG9zLT5uYW1lKTsK
PiDCoMKgwqDCoMKgwqDCoMKgaWRhX2ZyZWUoJnR6LT5pZGEsIHBvcy0+aWQpOwo+IMKgwqDCoMKg
wqDCoMKgwqBrZnJlZShwb3MpOwo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+IMKgfQo+IMKg
Cj4gwqBzdGF0aWMgdm9pZCB0aGVybWFsX3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KQo+IEBA
IC05NTksNyArOTQ3LDYgQEAgc3RhdGljIHZvaWQgdGhlcm1hbF96b25lX2NkZXZfYmluZGluZyhz
dAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlCj4gKmNk
ZXYpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCB0aGVybWFsX3RyaXBfZGVzYyAqdGQ7
Cj4gLcKgwqDCoMKgwqDCoMKgaW50IHJldDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXR6
LT5vcHMuc2hvdWxkX2JpbmQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm47Cj4gQEAgLTk3MywxMyArOTYwLDE0IEBAIHN0YXRpYyB2b2lkIHRoZXJtYWxfem9uZV9jZGV2
X2JpbmRpbmcoc3QKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAubG93ZXIgPSBUSEVSTUFMX05PX0xJTUlULAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC53ZWlnaHQgPSBUSEVSTUFMX1dFSUdIVF9ERUZBVUxU
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpbnQgcmV0Owo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGlmICh0ei0+b3BzLnNob3VsZF9iaW5kKHR6LCB0cmlwLCBjZGV2LCAmYykpIHsKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IHRoZXJtYWxf
YmluZF9jZGV2X3RvX3RyaXAodHosIHRyaXAsCj4gY2RldiwgYy51cHBlciwKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjLmxvd2VyLAo+IGMu
d2VpZ2h0KTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlmIChyZXQpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcHJpbnRfYmluZF9lcnJfbXNnKHR6LCB0cmlwLCBjZGV2LAo+IHJl
dCk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKCF0ei0+b3BzLnNob3VsZF9iaW5kKHR6LCB0cmlwLCBjZGV2LCAm
YykpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb250
aW51ZTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IHRoZXJtYWxf
YmluZF9jZGV2X3RvX3RyaXAodHosIHRyaXAsIGNkZXYsICZjKTsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHByaW50X2JpbmRfZXJyX21zZyh0eiwgdHJpcCwgY2RldiwgcmV0KTsK
PiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoG11dGV4X3VubG9jaygm
dHotPmxvY2spOwo+IAo+IAo+IAoK

