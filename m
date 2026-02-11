Return-Path: <linux-pm+bounces-42510-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGTPBvmojGkusAAAu9opvQ
	(envelope-from <linux-pm+bounces-42510-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 17:06:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AB6125F15
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 17:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28908303CED8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6AC327C0D;
	Wed, 11 Feb 2026 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+YC2tB9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F34F33AD81
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770825947; cv=fail; b=em0rbcHE0BRYsYtAUpkJNtW1hpL8I1t84lat5gS1TA0g6Zi1SuRJyY2jJn8olmjqIfenUwSP1cvBJqWjyekXSlOaV9uvN4rAJ32uY2l2CFGw0ABGTa84mWvSmPJKwhMKqk5Sn83UweBVKrFvjplICdXT7B3aMYRU9FihTgfhpbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770825947; c=relaxed/simple;
	bh=7m4raSV5ltpinnyfheNNHIPgaXTCYzD5vRDbw70/dI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QOB+8vt85gGeAeOUdwlRuZFNE9w9VzbAu37rMOCoL9H26sB9QK32pjKPydnzhQ0MXCs21iQwpmVv0+Wi3yImAIhDkpoAxdvp3Cz5R2quI7ZchDkVKqtmj85BxP+SqdJnEQOt4VF6Iv4xYYwapT4jsPW59IabCzNmM7GPOeGXyns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+YC2tB9; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770825945; x=1802361945;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7m4raSV5ltpinnyfheNNHIPgaXTCYzD5vRDbw70/dI4=;
  b=j+YC2tB9xY2MztzMLgWdC+DWDUWsAkXhfcZsELD0DglR68xv7jBL6/hp
   XkOFo9PnKgt7HLLKVLtto/2Cksn3EQyuMKPKcQXuWtzW2fdGAYmaKFsqE
   4Bah42bUfFfBGlvzn8FOeqWdBUzKaMkowAm+wlc41ohM47NO8vdWezoyY
   UTxhwlfU2zhAcmna0qeTLUUG4NQ9F5SP7EJNKXU8WYejt5TTXzC5Vg8kq
   2JEyxwWZI9tqY+L+/2l1cRwJX5rRmemRolT5zS0R8dBGdg1MChyZ7lEud
   9rOysVJBskUere1shKTmReS50BBoCPvW6k/X0hxFqgY3qCjWnE5rEsdWV
   A==;
X-CSE-ConnectionGUID: t0n6b2fiQguGKI11ZBfE0Q==
X-CSE-MsgGUID: 77moIWFgQvKXPDf/fqE1cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75824577"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="75824577"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 08:05:45 -0800
X-CSE-ConnectionGUID: QHQX90JiQLOOAYSlc0gtsw==
X-CSE-MsgGUID: NdtcyEfYSwOfCQ8dopH3aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="212314940"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 08:05:45 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 08:05:44 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 08:05:44 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 08:05:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIN1Pb32W0gJGUSS+s7wJAGdA8oTLEpmdT0pdOu4munsYqyPbguY0cjcbjUVu83jC5lwctwwIqYe2tJvgk3h/4jWTZKrem0oatobpL/98WN8uPvAmhLisOEVCwsGCFXuSh5stR8QZyxgg4NnIJjnsK+ZRQXmven8iKkQCyIYrqS5N+c6hC78t6wu9dgyIQ/4Uqw5vKgm+DTrN+4AJ6dtkpeAU4ZTUGjnvuDyh+mvavtMAcFHoZgRvsF7NqHjSY3OEQVb8VsKUqU8/i48tqFUKuZW2D7bnwTqe4YYk8D2pDUTa1HUSyQNVApU0cLS/U2jwQenNUeDsRW3mCtYESssuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m4raSV5ltpinnyfheNNHIPgaXTCYzD5vRDbw70/dI4=;
 b=Df+BeL8uNrjaAqMP8tt4KZ9GnJIDqT+oDmunnAqcSySvv+hVF3d4FrUuqG4xXDKyKWj3SJ+bIjWT31WaFjdV0dwo9vCdLcgqIzRzIRJzX5cr3TaOFIle2HueYUuCz4i9p43247oGIug80HzV/3InxOKLb5qE746TjIcoIA3OiG13r2WRI4354GIiey3LMbYlM3GHvHMwA1rcd00pbgn9iBrCsKv6aZgBmkMOTQLueagfM8KUOEKjEGBYqBxRZ83gxD8E9JK9O7sMQ9yDVePWlIM9M8avQ1GoOKn1MoAZkJKQKasomvezhl6BexswRWfbKvHOM1YYI0sGFVAMdc/Oew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by SA2PR11MB5132.namprd11.prod.outlook.com (2603:10b6:806:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 16:05:40 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5%7]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 16:05:40 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "trenn@suse.com" <trenn@suse.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jwyatt@redhat.com"
	<jwyatt@redhat.com>, "jkacur@redhat.com" <jkacur@redhat.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpupower: Remove incorrect EPP dependency in
 get_latency()
Thread-Topic: [PATCH] cpupower: Remove incorrect EPP dependency in
 get_latency()
Thread-Index: AQHcmEyd6a376sGoJESJEJHT6ypleLV4NPqggAV3pYCAAAFxgA==
Date: Wed, 11 Feb 2026 16:05:40 +0000
Message-ID: <LV3PR11MB8768B808DDC32B24D8F3D10DF563A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20260204111104.3490323-1-kaushlendra.kumar@intel.com>
 <96b8e23d-8f65-440c-b3ff-d6afd218d329@linuxfoundation.org>
 <LV3PR11MB8768F16244C44C0554F1C4E3F564A@LV3PR11MB8768.namprd11.prod.outlook.com>
 <861b65f7-6d84-41f1-a284-95e99f37fc68@linuxfoundation.org>
In-Reply-To: <861b65f7-6d84-41f1-a284-95e99f37fc68@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|SA2PR11MB5132:EE_
x-ms-office365-filtering-correlation-id: c05f3a2f-95e7-4b5a-34ef-08de698766ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RjlJQ1VwYW5JcExhQ0Y4eU1zWXJOMTYvR3NzTk9iaEQrbWhYV3VqSXVsVW1v?=
 =?utf-8?B?SjlMT0JCenVOV2htRG9pZTJldGNpK2ZmZzhrdmJ1ckdUcjl5L29EUW1oR1cw?=
 =?utf-8?B?bDhQNWR3UjRKOXpqbzBHejEwU0FxY1YyUzdqemRCOEFQNEN6Zlo1RzhYOXQ4?=
 =?utf-8?B?OWVOY1RyUlh0S2ZSVWtGcDBVa0xxZjlzaGczOVNHRXJzcjUrRW5ZbUFXUkY1?=
 =?utf-8?B?NHgyQ2hSZ0V2SHErYVIzUUt1WnlPMjRwMS9UL21YSEdhYTVxY25OOU1vYjdJ?=
 =?utf-8?B?Q0RVWGM3cWRkQWZLallEcHpqa2EvdmRycm5RWkYxZkVrVWV6QWtGOW5VQVNT?=
 =?utf-8?B?dlJtTEIwUFlYN09CWTgyZUp6UFpLUVZXckl2SFRQSUJaNS9ZZVA5OHZYNFdq?=
 =?utf-8?B?MktMZmhzWkVzT09NN2d3aWs4Yjg2S2pzQjVJVUppTnpUMlFKc1J1a3FCL1d1?=
 =?utf-8?B?QUpyZ25IZFRoRmpZaFV2TGdUK1pTNFBsOW9mVFFoaUdPZ2NBS0hKQW5oVjVl?=
 =?utf-8?B?WVY3cU1uTUhubEVlb3JKTDFrS3lCd0ZmbUVLa3JvMXJoRVZQcjRyRXRUdTFu?=
 =?utf-8?B?V3VQV29TdExZeU5KQVE4REY1MFdOVWV3OGgzUWRoMThMVjdadUQ2U2lhWnlj?=
 =?utf-8?B?RSs5YXBHM21VU3hsU0xQMVo5bjI3dHhuc0ZDQmJBQ3QwcE9NcHI3N1g2MEtT?=
 =?utf-8?B?a01zMkovei83WnRkZFVXbExSTEI1V05mNk1vaXF0ZDBKZTVxaG8vMHFrOEpY?=
 =?utf-8?B?RnJteTh5US9VaUg3ZExyTXRyYWR3NkYzQjdLQWM2WTU5NE9vVjhnNStrdEJm?=
 =?utf-8?B?dExYeFJhaGhOSWN6ZzhudHpua2x1dlpQTWFsTk42SGlQQTJQS1pLS2lRaGc5?=
 =?utf-8?B?ZTJCalcyKzM2aVF2U2FTRjVqVVNNeVNlQWVXWG8rREh6WGpkdk9uSk9ZUlNL?=
 =?utf-8?B?dzlSSXdOY3BkS05ENEVUQnl6Wk12ZnNLWFROaDQyWEloeEJ1ZFQrR0ZQZW9v?=
 =?utf-8?B?d29laGhpNE1PMExXTHNGcUhOTlRVV24xYkdpWFJDazRFM1A0d0VOcC9IMXN1?=
 =?utf-8?B?UjRFK3kvanV5SnRpZ0lxaEdOU2xVYUlINXdBbVJrRngrT1lsZlV1WmRvbmNT?=
 =?utf-8?B?QnRKOUNTLzExMXJCSG5yc2JKNlYzOElNNXk5U0hLYjNsbWpuSmZrbW0vMHpJ?=
 =?utf-8?B?aFFKWVBkTStPUkd6L29meVhGeDJieS9zakQ4bndhK29YWlhXT0NJQStBR2tY?=
 =?utf-8?B?ZUxwcG5mVEx0enNWNVl6SmdKeERqWFllTW14TVlISG5RMk1HajZzRkhUQUd5?=
 =?utf-8?B?aUhJak4xTnNSS0d2am80UEpyMTZkM3VwWlNmR2ZMLzQrRVpLOHdLL3N6Qmgw?=
 =?utf-8?B?c013Nzl4Rk9xN0RBWi9jU0dyVklPWkwrT2RTSzRCeEQyUkNrS2pNVVRmbmJS?=
 =?utf-8?B?bkhUQW1xc29ITCtkQ2p6TnNDRWJ2UWV3dGlBQWU1NHVoL1FiNmRsWUkrQnds?=
 =?utf-8?B?M01QdndrUVNSMEVrcG1aZ2p2WkFBYWJZNGpHQzRaS2hPaFVqZzhZS3lRcHZq?=
 =?utf-8?B?UkJmT3hjRzdxSzNyandaUW5GNk9aTEtVcUN6dlN5ZFFuV3BudnkwNFlMbzlr?=
 =?utf-8?B?NWRlK1VJNlEvc3BOOHRVS3NIM2tyWDZRVTFqZ2NBRkhxQ2NXRzFZOGtiVjRz?=
 =?utf-8?B?UnVKOWVYbGlrWEZaMm9rOUdRT2I3UE9MU0Q0cEZFQ1dTdTdJUFF1ckgwdmdV?=
 =?utf-8?B?dHVxd2hqd1RTOVQxdVBMZS9Sa1VvZit5Q1d0Y2IxeHYvdlFWVHJZWGRxem1H?=
 =?utf-8?B?U2tmTkNSR2RCQXVaM2JrWjlXUW9ETWNXRnFaUlEwUGlJb24rTHZ2Qm85V2pI?=
 =?utf-8?B?NHV2aDVyc0t1TDNNYVdINmVEdUI4RXFLZWp4RnlnZGFVQXF0SkxESjZqVFQ1?=
 =?utf-8?B?bTh1bjVadnlLdGtiUC84d0VWcDhBVTl2bVRNYkp5NDNhc3dDckVWdUFacTVj?=
 =?utf-8?B?Y0t5UFgyODVGekw0SDMrUnJncTFWZmhNTHZKaTRUUmdJbDk2MXpOV2FPbkJT?=
 =?utf-8?B?eGE0T1FEL2ttenhWYUhVbEJ3aVRZZEhqNTFXMnkwWW9zb1ord2QrakF0RWZl?=
 =?utf-8?B?VENqN1owakNkZlhlZnNlcmQrRFRCVmpVMDRzdjFzT05Lb3p5WVNmU1A0Mm5u?=
 =?utf-8?Q?eUlehaNJDgFNlU7YFTf8IYI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1Jmd1o1QStrV01hMHNXMisxK21KZ1diSEtaZWJDWk42VGdycFRzT29SdFdP?=
 =?utf-8?B?OVhvd25xZGtDSGhFWEFtQnY4cUp3WFl5dDg4OHQwTFF5S0FzajA4emROTWp4?=
 =?utf-8?B?dHdYOVZ3TDlHTE9ScVNmMEsvL1VKNlJZUnBWV1gyT3VTa0JwZ3R0Ukp1SXFI?=
 =?utf-8?B?cjlyR25Xd2VCMVBIaVhFYUFlWWhPUlQxR0VvdG0vV0RmZGc0a0JJZk5YZmY4?=
 =?utf-8?B?eTZVZ2tBNGFDQ1pPdm5oVUsxT3lGTDdheTN4cjFsMkliYWtBc1J1YS9MbUE5?=
 =?utf-8?B?Q3lhWTM2eXExeTlxSmlIa3E4Z0w4L2xNM29mbUZoRFdjQmtzdDlBL1RWckk0?=
 =?utf-8?B?bGxDdFdvcWNIZlVGN0pTU1hyS2FGYUplLzFvbFdoMGdhekhKdjBJK0U0ZjlI?=
 =?utf-8?B?NHpOTnJ5eVhjMUpacmppM2s5RHl5QnhKQ3R4Y0VCSmFNLzhscjhwc3FBaHJi?=
 =?utf-8?B?TG5UUTJRV2RiVGdZNDhlSGdaWmp0S3BwWGl5Vk1XNWxNQXI3K3kyN1FWVGdJ?=
 =?utf-8?B?NHZnanJEQ3VIRTdBZnVDd0NwMTV6Z1czUnZmRDhzWkdXWW5qMi9hQ014eHhp?=
 =?utf-8?B?K0p0T01NUlJWcW54bWpVZEk5eS92djd3bzk1cUd1bkRyWHFQNDQ1V29qbkI2?=
 =?utf-8?B?RmNaN2kxQzNXa1pWL1VEWlRjVGFGTGFZYlYvZDdBUnQyVVB1c2dRZyt1clpx?=
 =?utf-8?B?OTgvc3o3Nk5ZN0ZYaDczVE1YeEdVZmZDUEkvb0pEbjRSUE5jNE1rdTI3TTVn?=
 =?utf-8?B?ZVc3RUtNOXp0TFdOakM0UGVXNnNqVGJFWkhhSTU4QUVLeFFOcTU4R21QMGFx?=
 =?utf-8?B?T1NsU0tQZHk5VlM3MVZvTW9OTWpNVUlMRE1NSjlPQXBoV0hubDlmTUxMd251?=
 =?utf-8?B?cGFtNkY5RlBvTy9TNnZwbUVKL1NlaVZLTU0wdVV4cUpWTktNRjRvSnNEVUhV?=
 =?utf-8?B?Z1czSTlyRnlOQ21aY1B0QjRUVHJoWUpCY3JBamVWTE5Xb2piRGhJK0J4LzFI?=
 =?utf-8?B?MmZuVlJXdGhmVnhLSytnYzg4YjF2a1hnZWRsWWZITWJ0TkR6ck5PNWNTczh2?=
 =?utf-8?B?TE9yZHVKejNacmU2T1hVTzRrYnpUTmVHanVydFZpT2tYWGxlbkJ6dHdZUFFs?=
 =?utf-8?B?a2psRFRBZE00cnVZMVVtZWp6dU1qK3VoM0VoOUlxN0FmeGNnVTNqRlpNNjJh?=
 =?utf-8?B?TW90V1g2UUdCa0xNUW5pb1g0WnhUdm5jbTVlRTVKbkpnR0lGZVQ1NS9FU2ll?=
 =?utf-8?B?WkpwdnhQV2xuSThYNU02WFZPMkFvSkhubk9KNUdVL0lzeGxHVkpmZWVyVGs1?=
 =?utf-8?B?M3NJUDNkWHdXMEZLa2s3cHF6RmI5NStPWGp1Y09TR0YzL0dMQzVXbW5kc1o2?=
 =?utf-8?B?cjVaM3lWM3pvMGx1QUZpbnFKVFdjMENtVXJSRWJ0ZHRLNU9LTmpuSmhnZjZP?=
 =?utf-8?B?WGtMM2FsU0RnOXhYSFlrRlp6dHo4ZjRRdU45enRoL1FNTkJsUVZwbWVROElX?=
 =?utf-8?B?Q2xSOHU5TmZDUXhVaDJTTXNCOXpJdUVoVmo0VStvRUJBaS81L0RNeUk2d1BC?=
 =?utf-8?B?aG5lL0hMNmphV1BPSFNqVkVnZUVQWHBKVk8yN1g0WkJ1ak5qUERveHY1Y3Jr?=
 =?utf-8?B?TjNlMHErM1dvUTU5TXcreE1IalBhaXI2YjZQK3NkRlorZFJNVVdSMTdLaitp?=
 =?utf-8?B?S05sN3lwZnVmdzBsMTA3M09JQ25Od20wcDREbzQ2aWl1ZzVqWVlFNW85SjRR?=
 =?utf-8?B?NXNqTHA5MmlOc3R0c1hoU0gwUjI5Mk1XVHV2bjhFcm1uMEtrakttS1lnRFhV?=
 =?utf-8?B?OFhRTi9rTlpQVUJRUC9KVjhsSW92aVIyM25nbVBKMGVTSXNZZGNyWW5WRHI3?=
 =?utf-8?B?OURNYlJlS1NxMHRqTWxzMG1Ic1hpbVEva0k2Q0UwMGx6Qy9hY1c5ZzZFWVBK?=
 =?utf-8?B?Q1RNL3hQclA2NTRwbGsvYXBaWTErY3RpY2V1Y3gxZlExQzNWU2owUW5MdUN5?=
 =?utf-8?B?c3JzTGVsZ1N2TjNQWjlTeVlyckZQYjVydnhLdVo4YTBrNm5taHNwaHVsb1Ev?=
 =?utf-8?B?dk9LVjhqUCtnODRFN0Q0RVhnRCtjTG5mc004YU1JLzhWdk1YNDh3b0c4NWl2?=
 =?utf-8?B?OTdtRUlSMjJnUVRoWnhqelc1a1gzdmJhVXZ3azA4Z1dscDRzZDZWN0lkdXBJ?=
 =?utf-8?B?Nnc2MC9rSExJY0ZtdG9pMEtJVjR5dys5WUFTUjlLbEJLS0xWcjgwR3Q4WkV5?=
 =?utf-8?B?TDhTRWc1QmJqNFJWZU5VZWxrQ3gxS1FaTmJpeXpFU2dRUGVXOGdhT1JNMzM4?=
 =?utf-8?B?cVVaR3FEMnVKQjRMYVBMRCt0Q3BOcGlCUElFZ0hRSEk1dTRCZVdUdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05f3a2f-95e7-4b5a-34ef-08de698766ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 16:05:40.1207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsSlO7pvSd2WS24aRQZNyLfzAYyAasgCnDjWznMzaOrsGCIUcaMeFZF1UXslqUD4+0X/l9W1+I13lNQ2u2MnEIIUZrBuFRqb8WDvLgh7U+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5132
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,LV3PR11MB8768.namprd11.prod.outlook.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42510-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaushlendra.kumar@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 87AB6125F15
X-Rspamd-Action: no action

T24gMi84LzI2IDA5OjE1LCBTaHVhaCBLaGFuIHdyb3RlOg0KPiBPbiAyLzcvMjYgMjE6MzQsIEt1
bWFyLCBLYXVzaGxlbmRyYSB3cm90ZToNCj4+IE9uIDIvNy8yNiAxNDoyMywgU2h1YWggS2hhbiB3
cm90ZToNCj4+PiBPbiAyLzQvMjYgMDQ6MTEsIEthdXNobGVuZHJhIEt1bWFyIHdyb3RlOg0KPj4+
PiBUaGUgZ2V0X2xhdGVuY3koKSBmdW5jdGlvbiBpbmNvcnJlY3RseSBjYWxsZWQgZ2V0X2VwcCgp
IGFuZCByZXR1cm5lZCANCj4+Pj4gZXJyb3IgaWYgRVBQIChFbmVyZ3kgUGVyZm9ybWFuY2UgUHJl
ZmVyZW5jZSkgd2FzIG5vdCBhdmFpbGFibGUsIGV2ZW4gDQo+Pj4+IHRob3VnaCB0cmFuc2l0aW9u
IGxhdGVuY3kgYW5kIEVQUCBhcmUgY29tcGxldGVseSBpbmRlcGVuZGVudCBDUFUgDQo+Pj4+IGZy
ZXF1ZW5jeSBmZWF0dXJlcy4NCj4+Pg0KPj4+IEhvdyBkaWQgeW91IGZpbmQgdGhpcyBwcm9ibGVt
PyBBcmUgRVBQIGFuZCBDUFUgZnJlcXVlbmN5IGZlYXR1cmVzIA0KPj4+IGluZGVwZW5kZW50IG9u
IG5vbi1pbnRlbCBwbGF0Zm9ybXM/DQo+PiANCj4+IEhpIFNodWFoLA0KPj4gDQo+PiBXaHkgZG8g
d2UgbmVlZCB0byBjYWxsIGdldF9lcHAoKSBhZnRlciBjYXB0dXJpbmcgdGhlIGxhdGVuY3k/DQo+
PiANCj4+IFRoZSBlcnJvbmVvdXMgZ2V0X2VwcCgpIGNoZWNrIGNhbiBjYXVzZSBnZXRfbGF0ZW5j
eSgpIHRvIGZhaWwsIGV2ZW4gdGhvdWdoIHZhbGlkIGxhdGVuY3kgaW5mb3JtYXRpb24gaXMgYXZh
aWxhYmxlLg0KPiANCj4gWW91IGRpZG4ndCBhbnN3ZXIgbXkgc2Vjb25kIHF1ZXN0aW9uIGFib3V0
IG5vbi1pbnRlbCBwbGF0Zm9ybXM/DQoNCkhpIFNodWFoLA0KDQpFUFAgKEVuZXJneSBQZXJmb3Jt
YW5jZSBQcmVmZXJlbmNlKSBpcyBJbnRlbC1zcGVjaWZpYyBhbmQgcGFydCBvZiBJbnRlbCdzIEhh
cmR3YXJlIFAtU3RhdGVzLg0KU28sIG9uIG5vbiBpbnRlbCBwbGF0Zm9ybXMgdGhlc2UgYXJlIG5v
dCByZWxhdGVkLg0KIA0KQlIsDQpLYXVzaGxlbmRyYQ0K

