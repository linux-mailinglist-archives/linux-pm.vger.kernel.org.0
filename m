Return-Path: <linux-pm+bounces-8183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37118D05F5
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 17:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74AE1C20BC0
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 15:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EB561FD2;
	Mon, 27 May 2024 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNECEBpe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CA71E4A9
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823193; cv=fail; b=UuEwr0HJCyRLVYqLdVQNcUCcHfZ9GlcrXrGbRPb7gBj/xkb/j+9FbdIyAP4FxncuJxMdL3RrWujzEqBXighZrQNRB99Ya65IEnmgpbl9P2QU5NQX9UdhellrsubZ98exNDhBjskIsTwRUmQI5ZxS0Kzb/+Z4qoRRtl8+jo5JUUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823193; c=relaxed/simple;
	bh=cUbmUaUwu2HsCobjF+t9X6msTO5OgciAqHm3pIX7Zms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k1hyDKQgygP+pkfOtCqs3kzs8O4WPk49Rv2ABb3bwoPQOpFr69QnBjIv3zcEtFpaFjlGR9NPJQ64l+9JjilcE/X1Fi4Q/RpQDq6IJ0Ax+cYZDQJXsBN+vdqLmDojiaSmMYUi6KTEMaPVFftVrDwufyX9hPSLUOJh71bztD5Kg04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNECEBpe; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716823192; x=1748359192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cUbmUaUwu2HsCobjF+t9X6msTO5OgciAqHm3pIX7Zms=;
  b=kNECEBpe6SFv0VazXmKr2EAiu2iKlB86vAhmaG55kAZDQBq5q59nRKNW
   wD6+EEQzXDJnouMrCT56gdMX3T8LIxi2uUrYdoyrNfo7YY8PmZcqXA05r
   B6L/4bv7C3AMLdCwwKd64CGsUDVzxB0PpCYYeOvcRu7j2MA5ANNWHcbeJ
   z85IIc8C8Po+PeyEelgN9JI5N1NyPXfV2ILjM6xDtmSdrNtUE4SnpqHVQ
   frraMK2090Us0l19qfKhMi3ZOA9xFbpDH6FMSonT2J3cHFxQKvxWpEQnb
   52+wjxDFyoIvxsbb+4ybliluur4ciFcGoeizHtJyrSO6QBuFkca0XHuJQ
   Q==;
X-CSE-ConnectionGUID: REYCmIBiRXWTzCRH1IY+/Q==
X-CSE-MsgGUID: yRI0x4+tThOKSJkx+L64pQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13321019"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13321019"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 08:19:51 -0700
X-CSE-ConnectionGUID: RsSbjJwNTg6jgGjW6qZeDg==
X-CSE-MsgGUID: 8DK6I7OURmmB5TEQri3Gig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="57982859"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 08:19:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 08:19:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 08:19:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 08:19:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 08:19:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgcSHvdkIV9NGMLNAwDSst2TZp/HAQtdYyYsrwZR1uE/U4DlokqDDV6AkTRKDIrd5OEU9s1AtLnR1bH9O6U8ynvzvnizI0Y2J1hYiINYYB9NreUNDgMa2JTf/zyTVYL78T3dKb5w8T554GyYGZHgl/pfPn7Sk6bJ38hUEsQo9nNWJCfygqUbC8Sq4lOsKy7iHCr5FRUxk138RhjxYuQOVS4jxinZAjwqKZT2cF0XQkDcBdXwssNan9d04l+Q4ChGPo2dXyfdzfoq0wD0Qc0SZ9PMNSCVsLcrNj+/lI2F1+m9sM+9jevPpLo257k6TIWQCG/pP+U9WegTgIe4J2nrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUbmUaUwu2HsCobjF+t9X6msTO5OgciAqHm3pIX7Zms=;
 b=PW1hd3815YWtlrR1diL2cg/M2vAzmhixtgDVT8cUoY7nrD+tCvv6+52scwOsmmt1h8KY9I96C/KHswvxi5dl8molIsP2/Z9+21D7XszgcznLZwEFlfkJlujdBV99aimhbecCv3h/66xUusLRvlWidasn1uUq+pNyhJ6fEJLStYQ7plrGFbqlJLBFxgyv3yS3gEQbvMtxgQAMrEGnZX+M0t6evIHQQHB7RF/Yzq7DJ1HqR3/6J3m4L5oHAJ1ZtdGMmbcxIvK/DkxJiXzK1VjxTp+1Bmrlu0CPSxLKtt4hTw1VhMkd/Cddg+u549PXIT38GZQNhk/MVhtNWNzRLTYzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Mon, 27 May 2024 15:19:47 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%7]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 15:19:47 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "Zhang, Rui" <rui.zhang@intel.com>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: powercap ABI clarification
Thread-Topic: powercap ABI clarification
Thread-Index: AQHasDVBmt4fLub+TEqhVM90qIokgbGrIT8AgAAQ8wA=
Date: Mon, 27 May 2024 15:19:47 +0000
Message-ID: <6ac1931d80638b19106004cf623fae09b0812b8c.camel@intel.com>
References: <59e5a949-ef20-4f11-a0a7-247c457f1dd3@linaro.org>
	 <9c97e4f8549744b1e2464a3b632f0716514ff55c.camel@intel.com>
In-Reply-To: <9c97e4f8549744b1e2464a3b632f0716514ff55c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|LV3PR11MB8603:EE_
x-ms-office365-filtering-correlation-id: b6d34bb6-757d-4ea8-601e-08dc7e60723b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?anhxaGsrN0NQR2s4TmRFa1cvdjJRdU1tZVNpRnQ4R3VFWHZaS0pYZWZiM09z?=
 =?utf-8?B?c1Vpam9jRWhLbGtiaklwWmhJYlFNRlJ0N25IK0tpejE0d1F0Q0xmQWRxSlZq?=
 =?utf-8?B?d2VQVDhtVGVuSXNXbGhBYWZNRmRrSnlWenBFdmZxTXltS0ZDZmdiVVdOaVlB?=
 =?utf-8?B?MVd1N2hzdm9FcnZJYVV6OGZjdGdDS284ejZybkZPU0psUFQwNFoyaTdMU3RD?=
 =?utf-8?B?VGtEb2lPMWhoa0d4TjFXZlNJajFyUHNpWnFOR3hYVDNmREpmRWl1VkQ0YWZl?=
 =?utf-8?B?b1NnSUNDT1d2akhucGVQMWoyeUtRVG1TM1dzSm0rZlJhZHptZDdVUkpwanl2?=
 =?utf-8?B?UTFJdHZlR3dsUEd2Y1czN2tYUGZTOVBmbmlnbk1GMkF6VDc0YzFUcXRwaW9n?=
 =?utf-8?B?NS9wQktjMDFzcEpPai94TklJemRYanNCSVNMT2FaVWR1OGVLaUgvVXljdUdN?=
 =?utf-8?B?OWM2TWJFZ0RrZ3RFa0M3MTdKUVI5aEk2K3diNGtxRU81cjBOMWNGbVE5aUx6?=
 =?utf-8?B?aHA1eVNqdlhYMXMvZ2J6THl6aStQSDY1ekZYbzRMNHpXQkpIdkkvSndkTGRO?=
 =?utf-8?B?UE0yd3M1YUZZd1padFdPbkwyMjR4TUhMT3RiczF4QVY4b3pxQ2xkdkF6UE9G?=
 =?utf-8?B?WFd1MjhpanZHR1lkQTQya3BISkFRTlM4cVVxeG8ya0FSTlZvREdyODV2TWNx?=
 =?utf-8?B?QzFHNkFUWnE4eTgyajFOWUttcjB1YTBjWTdOY3hWT3Y5V3FOQjkwT2ZhaFpH?=
 =?utf-8?B?ZDZHMEF0RGMrRUdVcHVhVUVvWk4xWHZDN3pjQS9kZHUxQW5seTJUb0VuNGdN?=
 =?utf-8?B?aUlTeTdZdklGWWJuR0VtUVpaNmxnNDF0VDkzNlFQT2hLTGZqeU9hVG1QR25y?=
 =?utf-8?B?bVFuQWRkeG9EaG83NHlxM3ZpZW0zc3pZc3lTQzBuL1dCcUdZUjJrcG1RSmho?=
 =?utf-8?B?cm13TUpWcDJobTljek8rMHkvUmZIOFNWWTNhNTluNUN3eXNLdzBxSE0vY3pP?=
 =?utf-8?B?MFlrK3AvSnhOOGxpTFhtcjlzMUxHdzNrQytCN2FIUC93VE1hQ3JUcGZtV2Z3?=
 =?utf-8?B?UnpIUjM2Qit0WWl2SXV1Y2Nnb29SNUExeC9DMHZsRytRZVo4MnhGY2U3TTRV?=
 =?utf-8?B?aFo1enV2VUg3TER3Z0NuaG05YTJFTXIreThzRFlURW9FaDdhNGNMVlI3d1Nv?=
 =?utf-8?B?Q2Q1eWFMM2t5dUJJb093eUtoYmg2Y0s3Qk5TU3pXcEt4Unp5eHJRZlg4a0xF?=
 =?utf-8?B?ZGVwZno2N2UwK0ZOZlh4aHJnY1NBRGFTbnJERXlKOXVHcCtDR0dqY1p0b28z?=
 =?utf-8?B?SlVMUVo0WVNPU2c4ZUhaVHhRQVhKNkF5QmhMaStNU2VUd2lKeE5kMTViakY5?=
 =?utf-8?B?YjN6Q1VoZGQwVkhPeHJtbUkvV29nTk8zRmU1MlpQZm03QysrU0NqSWtiTXo4?=
 =?utf-8?B?N2NnTjBKUm5VY0VuckVzUWlwWFljcFlZek1PdVNyTFdlMFllUkM0ZlA3aVlR?=
 =?utf-8?B?L1pqT0t6dG1DbGZaNERGTWxDQWFOUXdCSmNpQ1RQWGNjZ2ZFZlRDMVVLRXlB?=
 =?utf-8?B?UTU2V09mVi9rUlhVZFA1dXRqYnBuOUZvbm9DL1NuYVdaWkNuV0tLODVORGF5?=
 =?utf-8?B?MnBKN0s5ajJlOE9qVnFSNDVudGk3TzgxMFp6Qk5xVmM0cWNid1Q4QUNtSGZ0?=
 =?utf-8?B?SzlmUEUwWmd3Nm5HRlVwcm1GOS96Z3gwRFpoVzB4dmhMcW5nSERGYW54U2Nm?=
 =?utf-8?B?NnkveVF3R1VvdGhwQW1YN09kQU82V0c4cEhlQnRhQTh1eDdTaWI1WGp5Zmly?=
 =?utf-8?B?U2YwUHlRWk83VGR1eFBoZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWduY3MrVW5lMU1QNTA2VkRHbFhUVDNXeGIzT0liNnNSeVlKUFNRZktHKzVi?=
 =?utf-8?B?RzZaOGJNaFZPcmhSSUJGeHpKdkRZNVB2WlEvOUhhWElBY1VKWUhrRGwyQVE4?=
 =?utf-8?B?WWwxZEpFUFdFZ0tURlVWWjNqcjVNQVJPK0RPUkdnM0dPU1JKVTNONGc1bTBV?=
 =?utf-8?B?VEJiOUV0RW9EWTJmK2dCeUNMdUpZOENXUDM5V2xnOEdHMDczcDdsZW5oWWc3?=
 =?utf-8?B?U1dIMEJiSVh0Qnhta0FVZUE5WGszME9VaTFWUVlwcWJKRll6TmRaWVhsVi9J?=
 =?utf-8?B?MmQ4SGtLNkc2RnRLb3dtWTcyL3pySGRNNDVBQ1Zab2o2d0MrelBSQ0hUMkNy?=
 =?utf-8?B?dmlBRGxvekRoT1RxUlZHdWU5TitnTUtQbDJxak5OYUVNR1JHRVBiYUwxUk43?=
 =?utf-8?B?bHYxeWg4Rk9iNzUwT1paL2xTUFUzUXAwRmNraE1EeUlxM2psWE9OV1FyTU5Y?=
 =?utf-8?B?K3ptOTl1WHJRVGZ1VXQ3UzF5bmRTaHZ1ZUM5RzBYblQvdG56ZVhVaXppR2Rk?=
 =?utf-8?B?cFR6SFd1U2YxcDNBOWlXTXp3d2RYUEdwN0tUdTh0VkVLMDVQcjhEanQwbnh2?=
 =?utf-8?B?alJ1NkV2eDIzaVoxRnJjUFE3c3l3SUI3NzNlZURFVk9tbExySFdJV2lUdHlM?=
 =?utf-8?B?cFZnOWpHZjM0WkFoTlliL1p5Qi9GcVJsVStKUVNDRzEvSmNCQzFuVFN1MnQx?=
 =?utf-8?B?cXFRQTZGVFdSMjdwOEM3UGtaZ3B4YnJQR0JGTVc4NUYyNTI5R0tkdFcvaVRY?=
 =?utf-8?B?dmJzckVYSkVDOXFmWWtQVUZMK2Zsd3pVUDA2K0tvMUJyeE8weDR6Sk0xR0dL?=
 =?utf-8?B?bHRHemNQYjFGMnBFTVNCVmw4YnRpbWRta2lzcXZwR3c2MFd1YzlZUk1WdXlO?=
 =?utf-8?B?OHpZc0t0WUNDODRzeVpEOEdtZ1hxdE8xNXBwYkhhSHhiR1BYUllTbWIwMWxV?=
 =?utf-8?B?QXg0VkZTbXh0REVDb2h2WllhNFMxQlQwblBKWmpKMURXU3VmVGdNK05NVFFV?=
 =?utf-8?B?UmdWN241bGtVS3huV2dZWjd0Yk9UQlZqcHU2U25qTkwxUnBBaGFJUTdzK2tY?=
 =?utf-8?B?S2lhNnB4bk96b3kyUnlMUTZBNitEVUozeUlOL2Q5WXZnYmNadVVML3NxN1cz?=
 =?utf-8?B?b1c2Q3o3cU53ODAwV3h4OS80WTRVQ3NLT25zZGwvWmxzV2tqWHNzRzJ5MUgv?=
 =?utf-8?B?K1dsRGVTY0VhSExTVkNwTDJUVnNIeGx6TW5MYkFmaVFUUll1cmZqd2hNTW9Z?=
 =?utf-8?B?YU1nWDZBRldMREYxNnJvTlRFUWtQc2dqcGJ0c25vWUdhZDZxcTdEeDEvTVM3?=
 =?utf-8?B?WGVQa0gxWmMyekxrdGk2N05lQmxIVHRXMllhcEI4NkE1Vkd6eFNxSG1aT2Y0?=
 =?utf-8?B?QU55bEhpeFA2ajZIVW1oY0d1cWZHUWszeXpQQlNKUWFuRklIWk53cVAvSk5W?=
 =?utf-8?B?WXdHSmFjRVZYVlFRY1BiMVZ2Z05MN1h3d0Z1aWFVWjFaYkxBeDE5bmM0RGJ0?=
 =?utf-8?B?aHFJYkk1SFI1dWhGLytOc3RscW1aQkNmY0xtN2lyb1V4a0VDS2dCazFrMHBp?=
 =?utf-8?B?V1dHaktYbk5sUnRSOENjMCtiOWMxYjJZY3JTZFl3YVBLM1daeUNwSGJZQWNu?=
 =?utf-8?B?S3hzTUQ2RzhKMmdMeWRSeHVWMFdzMzRmRGdTWjlkbzFzeW9JYTVMYUVGaW9j?=
 =?utf-8?B?eFpJZUp0V2Y0d3BFQ3BIWmlaMXc5NG1mb3RrTU02M3ZPeE05VjZUWGZ0NnQz?=
 =?utf-8?B?U3BLWGJUN2UwQW0xYWt0MUlINnJjWDBiNi9IVXgrZ3p0Yk16dGhPT0dKVEdr?=
 =?utf-8?B?akhUT2luOCtsMzhwM0Zud05pajdDOVhYbk5pVFhuZ0Rpd0ZvWCtYeFZtZkhP?=
 =?utf-8?B?cFVFVTdzbHBWN25hdmhzSTdDRTRZdTJ6QkhlYVhxWXlPUzNzaUh4TVQyQmF0?=
 =?utf-8?B?L2c5bEQxMWxkYVRZMHlQdGVZUzFWdU9NVlB6bWpicHRpV3BlbzdRWEZjSHBt?=
 =?utf-8?B?dXBzdmpxcTAxRFEwZUlsZS9wK29JYUF0dG11VDFYb3V5blduNklsaFU1QVVY?=
 =?utf-8?B?WHdTc0tILzVYUGd0ejhMdENDT3pvN0VKZzkzQVdnMFpHOTBEQktsazN6Q3FY?=
 =?utf-8?B?U3V6TzBuN082SE1sazRKSi9RdHlrZWFkNEVTR3Q0Tm9McU41RlBydzJoSDlr?=
 =?utf-8?Q?f99CrHBUsDLn04LFUOm1Bew=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2FEC0C4BE89B84F82AC43B9A5EE9C7D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d34bb6-757d-4ea8-601e-08dc7e60723b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 15:19:47.8117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w90xI6wZpkLI2Ng3yMkM2nI8FbcWkkTLzD/Ov8dNUczE8ChPaUNqLgOjDQPI9CrSS5JkacHUDy3Whi9XGku5ca7Hh2Yww0W7FCfz7O4eBYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8603
X-OriginatorOrg: intel.com

SGkgRGFuaWVsLA0KDQoNCk9uIE1vbiwgMjAyNC0wNS0yNyBhdCAxNDoxOSArMDAwMCwgWmhhbmcs
IFJ1aSB3cm90ZToNCj4gT24gTW9uLCAyMDI0LTA1LTI3IGF0IDE0OjU1ICswMjAwLCBEYW5pZWwg
TGV6Y2FubyB3cm90ZToNCj4gPiANCj4gPiBIaSBTcmluaXZhcywNCj4gPiANCj4gPiB0aGUgcG93
ZXJjYXAgQUJJIGV4cG9ydHMgc29tZSBjb25zdHJhaW50IGZpbGVzLiBFdmVuIGlmIEkgc3VzcGVj
dA0KPiA+IHRoZWlyIA0KPiA+IHNlbWFudGljIGl0IGlzIG5vdCByZWFsbHkgY2xlYXIgaG93IHRo
ZXkgc2hvdWxkIGJlaGF2ZS4NCj4gPiANCj4gPiDCoMKgwqDCoMKgwqAg4pSCwqDCoCDilJzilIDi
lIBjb25zdHJhaW50XzBfbmFtZQ0KPiA+IMKgwqDCoMKgwqDCoCDilILCoMKgIOKUnOKUgOKUgGNv
bnN0cmFpbnRfMF9wb3dlcl9saW1pdF91dw0KPiA+IMKgwqDCoMKgwqDCoCDilILCoMKgIOKUnOKU
gOKUgGNvbnN0cmFpbnRfMF90aW1lX3dpbmRvd191cw0KPiA+IMKgwqDCoMKgwqDCoCDilILCoMKg
IOKUnOKUgOKUgGNvbnN0cmFpbnRfMV9uYW1lDQo+ID4gwqDCoMKgwqDCoMKgIOKUgsKgwqAg4pSc
4pSA4pSAY29uc3RyYWludF8xX3Bvd2VyX2xpbWl0X3V3DQo+ID4gwqDCoMKgwqDCoMKgIOKUgsKg
wqAg4pSc4pSA4pSAY29uc3RyYWludF8xX3RpbWVfd2luZG93X3VzDQo+ID4gDQo+ID4gQXJlIHRo
ZSBjb25zdHJhaW50cyBjb250cm9sbGVyIHNwZWNpZmljPyBJIG1lYW4sIGVhY2ggY29udHJvbGxl
cg0KPiA+IGRlZmluZXMgDQo+ID4gdGhlaXIgY29uc3RyYWludHM/IE9yIGlzIGl0IHN1cHBvc2Vk
IHRvIGJlaGF2ZSB0aGUgc2FtZSB3YXkNCj4gPiB3aGF0ZXZlcg0KPiA+IHRoZSANCj4gPiBjb250
cm9sbGVyPw0KPiANCj4gQ3VycmVudGx5IHdlIGhhdmUgdGhyZWUgY29udHJvbGxlcnMsIE1TUiBS
QVBMLCBNTUlPIFJBUEwgYW5kIFRQTUkNCj4gUkFQTC4NCj4gVGhleSBhcmUgYWN0dWFsbHkgdGhl
IHNhbWUgZmVhdHVyZSAoUkFQTCkgdmlhIGRpZmZlcmVudCByZWdpc3Rlcg0KPiBJbnRlcmZhY2Vz
Lg0KPiBTbyB0aGVpciBiZWhhdmlvcnMgYXJlIGNvbnNpc3RlbnQuDQo+IA0KQ29ycmVjdCwgYWxs
IG91ciBjb250cm9sbGVycyBiZWhhdmVzIHNhbWUgZm9yIHRoZXNlIGF0dHJpYnV0ZXMuIFRoZQ0K
c2NvcGUgb2YgY29udHJvbGxlcnMgY2FuIGJlIGRpZmZlcmVudC4gRm9yIGV4YW1wbGUsIHBzeXMg
Y29udHJvbHMgd2hvbGUNCnBsYXRmb3JtLCBhIHBhY2thZ2UgZG9tYWluIGNvbnRyb2xzIGxpbWl0
ZWQgdG8gdGhhdCBwYWNrYWdlLg0KDQo+ID4gDQo+ID4gSXMgdGhlIHRpbWUgd2luZG93IGdpdmlu
ZyB0aGUgZHVyYXRpb24gb2YgdGhlIHBvd2VyX2xpbWl0X3V3DQo+ID4gY29uc3RyYWludD8gDQo+
ID4gT3IgaXMgaXQgYW4gYXZlcmFnZSBwb3dlciBkdXJpbmcgdGhpcyB0aW1lIHdpbmRvdz8NCj4g
DQo+IFRoZSBhdmVyYWdlIHBvd2VyIGR1cmluZyB0aGlzIHRpbWUgd2luZG93Lg0KPiBUaGUgY29u
c3RyYWludCBpcyBhbHdheXMgZWZmZWN0aXZlIGFmdGVyIHdlIHNldCBpdC4NCj4gDQpDb3JyZWN0
Lg0KDQo+ID4gDQo+ID4gV2hhdCBpcyB0aGUgcHVycG9zZSBvZiBtaW58bWF4X3RpbWVfd2luZG93
X3VzPw0KPiANCj4gSXQgaXMgdGhlIHVwcGVyL2xvd2VyIGxpbWl0IGZvciB1c2VycyB0byBzZXQg
YSBtZWFuaW5nZnVsIHRpbWUNCj4gd2luZG93Lg0KPiANCkNvcnJlY3QuDQoNCj4gPiANCj4gPiBD
YW4gd2Ugc2V0IHNldmVyYWwgY29uc3RyYWludHMgb3IgYXJlIHRoZXkgbXV0dWFsbHkgZXhjbHVz
aXZlPw0KPiANCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZXkgY2FuIGJvdGggdGFrZSBl
ZmZlY3QuDQo+ICJUd28gcG93ZXIgbGltaXRzIGNhbiBiZSBzcGVjaWZpZWQsIGNvcnJlc3BvbmRp
bmcgdG8gdGltZSB3aW5kb3dzIG9mDQo+IGRpZmZlcmVudCBzaXplcy4gRWFjaCBwb3dlciBsaW1p
dCBwcm92aWRlcyBpbmRlLQ0KPiBwZW5kZW50IGNsYW1waW5nIGNvbnRyb2wgdGhhdCB3b3VsZCBw
ZXJtaXQgdGhlIHByb2Nlc3NvciBjb3JlcyB0byBnbw0KPiBiZWxvdyBPUy1yZXF1ZXN0ZWQgc3Rh
dGUgdG8gbWVldCB0aGUgcG93ZXINCj4gbGltaXRzLiINCj4gDQoNCkluIEludGVsIHBsYXRmb3Jt
IGhhcmR3YXJlIHJlc29sdmVzIHRoZSBjb25zdHJhaW50cy4NCkZvciBleGFtcGxlIGlmIHlvdXIg
c2V0IGNvbnN0cmFpbnRzIG9uIGEgcGFja2FnZSwgdXNpbmcgZWl0aGVyIHZpYSBNTUlPDQpSQVBM
IG9yIE1TUiBSQVBMLCB0aGUgbW9zdCBsaW1pdGluZyBjb25zdHJhaW50IGlzIGFwcGxpZWQgYnkg
dGhlDQpoYXJkd2FyZS4NCg0KDQpBbHNvIHRoZXJlIGlzIGNhc2Ugd2hlcmUgdGhlIHBsYXRmb3Jt
IGRvbWFpbiAicHN5cyIgY29uc3RyYWludHMgY2FuIGJlDQptb3JlIGNvbnN0cmFpbmluZyB0aGFu
IGEgcGFja2FnZSB1bmRlciBpdC4gSW4gdGhpcyBjYXNlIHBzeXMgY29uc3RhaW50cw0Kd2lsbCBi
ZSBhcHBsaWVkLg0KDQoNCj4gPiANCj4gPiBJcyB0aGVyZSBhbnkgZG9jdW1lbnRhdGlvbiBkZXNj
cmliaW5nIHdpdGggbW9yZSBkZXRhaWxzIHRoZSBBQklzPw0KPiA+IA0KPiBJbnRlcmVzdGluZywg
SSBqdXN0IGZvdW5kIHRoaXMgb25lLA0KPiBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2Zz
LWNsYXNzLXBvd2VyY2FwLCBzaG91bGQgd2UgbW92ZSBpdCB0bw0KPiBzdGFibGU/IE90aGVyIHRo
YW4gdGhhdCwgSSBkb24ndCBrbm93Lg0KPiANClRoYXQgaXMgdGhlIG9ubHkgb25lLg0KDQpUaGFu
a3MsDQpTcmluaXZhcw0KDQoNCj4gdGhhbmtzLA0KPiBydWkNCj4gDQoNCg==

