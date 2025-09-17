Return-Path: <linux-pm+bounces-34821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E524B7D4B9
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4CC1717CA
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 05:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0198278158;
	Wed, 17 Sep 2025 05:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4UVlgfo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE6274FE3
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758086037; cv=fail; b=mtEjhRrl3UBdAJcBnfh8IW9MYZlO1mf5ZHrhamzf8wEks6tC7JGFF2JGv8k7h9aRJK3YUTjxFCoVfKb2vS2Wa0xLGZ8Icq47KvRdxDkj5pxICOwfmDJ8/lr+h/Ulf32rqInaqvrlAcVoRWOGps4OOVz32ZHlHohCMwsaw2wGq9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758086037; c=relaxed/simple;
	bh=w3RGYt0G6rzqAOa8CcxeqqQVFZJ/liHQHh+G7FvtQ3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PvNjBvO5PTl9YI4QaBQtx6GD/QRryotbNtkkVNv6mXSChd8hsPkyjQjtWzMzvg0jh3ihhBvgeM6ul9R0AP2vz5cUiz+eBKpmdJAqJ6L3zVFgb4HiTAFXLFOSprQH8x0K+gZ+/Kq6oYjnuagKcOf6g0zImelhOorR1olmSfs6zJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4UVlgfo; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758086035; x=1789622035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w3RGYt0G6rzqAOa8CcxeqqQVFZJ/liHQHh+G7FvtQ3k=;
  b=e4UVlgfoTVq3AXXu3yvoCdw204Hs84YpEqpvFJp0DC/psN/uwiPKlX+1
   5rT4syw6k/mSm+yc9nd9KyV56tDQhvCJKRhU1Ga0rNCcmg/FccLa1Z1YA
   QTkbAsXJJrCh7t7h6AbDDOhIFWkiclDacdacQo7/1m6nIA0zgpejr65Vs
   5KZV9EBtIRktUPqpII27D0F2ragN8pm9p4TEEiLnVV5VhsqCs0/qnKCNG
   azOAp8d4bN1g4/MiG9xG3GP24yl4Njk82dnFtcr4kYNq+2vIT+8+emIRK
   N+uWWaGkX8+5Rkwv3TJOi/t3lqo5cjuSF3XC2TV9oOZDfetGHsy+2a30Y
   w==;
X-CSE-ConnectionGUID: igTCnK59RCOKMEZs/OKPuQ==
X-CSE-MsgGUID: iHTUlKhbTuGeMD8aj28H9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60489476"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="60489476"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 22:13:54 -0700
X-CSE-ConnectionGUID: WuIWGTYqQLq/YLawKQ7qdg==
X-CSE-MsgGUID: AA7/jWUASqipsd/sEVVgGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="179535538"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 22:13:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 22:13:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 22:13:53 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 22:13:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMIp4DokZNOvW/X7vdhXWrvzLqUAkWijlDiClF0kUAOkq3n2so2HUJtS6fPCk51636zpwxRx4UOv+FHS6NxbT6Dc/hXIs2yIUfoCzlrr3NLgmLNViNihKpAluY3U2J56mE7Blv1y/cp5P9pXlkX8Icd3u6j/V+jwN6E9/9e7XWflxdtL3usQiUt0QC83MHtOoGlY83JIop0+b339bPHLn0x35UmTC1hNh0jqXIllyrw+qKsAAZ758hv4Zn6yb4uWCFMBBeO84i8YaJe2sES4EcQXzzk+xdQYKUsvx2wnaqlADckFy0LjbvzKxlmYvtIbpLFak3GHS0lodsadGgEpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3RGYt0G6rzqAOa8CcxeqqQVFZJ/liHQHh+G7FvtQ3k=;
 b=IjhhCpBQlsy7VYbUvacVyqyHw4S5eT6ii1pRTZUMfqxoafQmkk8g9/MhiOc8oqqKJj+bGdpxsYWREGA+gMBG9gRrI0iBwyelnmzyfhOWwaoHKfypp0MlFj/03LeEWxZN608fG69bYT5RYJskQW8cZRxGqJRBQcJeDluen4QUv6TFiHIJd7C/acynzdP4XWWguSMbP7kqmAPWFTDgkit0YI4nnW/1OiiDwY1qh58hRzkywZUSWg99PByr93xXMcul7+byQlipcSRQ3Y28CvJUS73RYDEyTgtdM3K1uaJ3llEjQuW60MvkiZKwXUhJg0D9jfhFcUxsgJhry5rRTdazyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 05:13:45 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%4]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 05:13:45 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "trenn@suse.com" <trenn@suse.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jwyatt@redhat.com"
	<jwyatt@redhat.com>, "jkacur@redhat.com" <jkacur@redhat.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] tools/cpupower: Fix incorrect size in
 cpuidle_state_disable()
Thread-Topic: [PATCH] tools/cpupower: Fix incorrect size in
 cpuidle_state_disable()
Thread-Index: AQHcJ1blBAHnsXPQbkqv14jwHDU3fbSW1Kkw
Date: Wed, 17 Sep 2025 05:13:45 +0000
Message-ID: <LV3PR11MB87681FE3EF2DB4128B19CCC8F517A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250826065440.2908389-1-kaushlendra.kumar@intel.com>
 <61f224bd-c82b-4f16-a127-f337bc60fb4b@linuxfoundation.org>
In-Reply-To: <61f224bd-c82b-4f16-a127-f337bc60fb4b@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|LV1PR11MB8850:EE_
x-ms-office365-filtering-correlation-id: 4be245c3-c255-4cea-f8d0-08ddf5a8fa02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?amZRaHc1ckJHUnJtNEpWUUVyazB3UVVJWWZYci9CK2E3QlBUMFFPaHJobUFO?=
 =?utf-8?B?c0hkOE5kRHE0c0JLYzI5SUpseHRoT3pvbkJOQTFuU1A1VngySEY5dnViTmdF?=
 =?utf-8?B?WTQ1aGhSeWh1VXlZUVJMdHFBT2NlcDEyT2FSMThuaGV0UEJEbHIzTUdzdmU0?=
 =?utf-8?B?MCtVMThWUEczb3VlRWh5bndFeWZ3NDAydENpWFNESmM4YUlwaDVPcW1Sb2hq?=
 =?utf-8?B?MHp6YjN1bUpUUFpVb1lsWnRRQW1na0RzVGtrYmJlaHY3TmpLYnZCamtkVG5G?=
 =?utf-8?B?ZXNyZ0Q1dkpsK3dUdG5tRzQ1aitEcXAxWDQ0Uy9hY05ZNHVuamFUWFRrb2FY?=
 =?utf-8?B?VkE4Q1hGTjA4NXl0c3VXSlFadzJrSU5oTkFGcE82bVVOaGxtY1BFeno4cSsx?=
 =?utf-8?B?UnhlUmFuS3l1eGgraHMxVmNEVm42OGtIcVh6RFEwc2MrL2lpbVlrSTVaTDVC?=
 =?utf-8?B?Yi9qQU1nWXJkWDlOQTduZUpEMDUySHBBR2lYcE9yVllzbnFJQkd1MVpQT2tV?=
 =?utf-8?B?cXNLWmN4MjQ2b3ZvbnphRWZEUlJFM1ROUXlHcEp3V1c2N3ZTZnYzQVJhdTZC?=
 =?utf-8?B?Y3Jjam03R2haQ0p4YmI2bWZ4OHI2OVA4aFFuRSszcHhpRWp3NUhuRWRDeDVl?=
 =?utf-8?B?TnlBeTZoaVFibnBRQUpxbkE4aVYxdUZiTlFQY1VVRlE3NkFiL0ZDa2lCOC9T?=
 =?utf-8?B?UGRRTXBxRGJJUk9PSWJzOTJBWm1LSkRnTGxBTDJiQWtOZ1JlMDRUQktKOExi?=
 =?utf-8?B?YXo3MTBWcy9CZk82dHF4QzJPQXZIYXZ3ZGN0Z1RETTFvN0ZlVlhjYitWclVE?=
 =?utf-8?B?dDhyb29NTWRhcjhFTXFQaDRrb2ZzdkN4NHN1dUF5OGx3czR6TmlXNGFpMWo2?=
 =?utf-8?B?ZTFqQjJndCt0S09ZZkJIWVMvRmxHdTN4bGdaeDZacmNNQ0wwdUFoWU14bVdY?=
 =?utf-8?B?TjFqbCtBdEVsR2pTWVQ0YW1iVUpKYXk4SWVDbHA4THNUZExzcDkzOVByYWh6?=
 =?utf-8?B?RUZOVHdIQnR2K09SbXdOclc4SGtiWXg4bWN1c1dGMnBGTlZYdFJPTGRncWxB?=
 =?utf-8?B?SWp3OStENktHMTg1OC9UZ1ZGSmlON0pRVGJ1cUY1aGhhc1ZuSGk2dU8weVRp?=
 =?utf-8?B?bnhJNTFjQ25saWxHTytEdGx6MGRzdlRtZ0NiVHJCRzVqTmVPUVd0RUk5d0FP?=
 =?utf-8?B?SG45SGRQSmNqU2R2emh2Nll5Wkk0Y2t3NFJMRHJ6dkY3aEg4NmtPbm90eExv?=
 =?utf-8?B?Ri9KenFIT21pS0xPOU5iQzdTNE4rVlZPcm5IenZybDZxcTNxZGVVUVVLM05n?=
 =?utf-8?B?dDRSWDdjdVgwdHZXSFloc2d4RGdhTzU4MlNDOHBDSko3OFVXM1JKalRCUGV1?=
 =?utf-8?B?WElUdnRWbWs3b0NmSzZiVGVoVmE1TkZVM1JVdFFhVkc3bWxwTnlBWUNuQnFt?=
 =?utf-8?B?Ni9wZHppZ29lREtIOE5nSzBqdTJJREhTVXQ2end0eUl2Y05nMmdmWFUvaEZt?=
 =?utf-8?B?dS9jUHkvYitTOFpwQU9MKzlZTk9mWlFBdUczcWhrQW8zdTU0Znd2V09oOEF5?=
 =?utf-8?B?dnUydVorNmtPR3hoeXN2VVltQ2FyYTBibTZHYWF1OHQ0MjJPMWhUZENIQXpD?=
 =?utf-8?B?VkVsV3lISytER2VNZzlKeXRiQ01LVjRUdXRyd3AyU3NzcVBFME9ldlhEUGVI?=
 =?utf-8?B?YUpaVzg1azZCM3dUTXNXOVl5RUxZeGp5c2pCUHFWKzJtV2h0Ymtxa2FxSXd0?=
 =?utf-8?B?Q3daOUl0VC95OHBzdlVJazQxWTJSb2R6N0ZReUhQaVFHTHZQenN5NytwckRS?=
 =?utf-8?B?d2xLelpHNFQxNU9uNGVReWJ6VU96TFYzUDR6Z2NNUnU5SHNCeFo0Q0JPN3Z1?=
 =?utf-8?B?VEZIU2NlRGdNZlNxU0Zwd2dHSjU4MkM3azBjMm9kdjVsU3hKNWhXZzJmaFNJ?=
 =?utf-8?B?Ly9PVTdwTnk5SjM4M2g1ZUpiMVFrNWxXZzdETm1mUmYwODdRM3RHN2NjZWpS?=
 =?utf-8?B?cmF5QTBiL2VBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVMwR094QWhaRnhyMCtOWkl1RCtxVUNJNWtZNVFKWldCVHYxZ1hOdXNyeDNz?=
 =?utf-8?B?S29DOEpnK3V3QkdRTFZHdFJCREN5QXJuVVNIUjZrMitxVitBTUVoaEhpaXJP?=
 =?utf-8?B?WVRKd1V3d01KcEo3bVR2RGxNTmxTMjdqaHhld21tTEV5QlZObnQyMmtodWx3?=
 =?utf-8?B?c2dHWWtvQlQwakFqbzB5UUdnRTRyRnpqSUo5dXpKTzFJdXFyK3dld0VYcVdB?=
 =?utf-8?B?a0ZKWjNxWlBhdkd3cjQ3dkI3YnFPY1p1WE1xMzM4MGVZeXFjaGYzcXlNRmtM?=
 =?utf-8?B?ZGYrdEk4QVF4cFpEYXBrb3BhK2FEeEV5MHRTajc4aVo5aEZ0eWhBTVNsVnlh?=
 =?utf-8?B?RlBsVmpyQXozSkhjU2FIS3ExK21JSGhrUjJWbFhwaEtwTk00NGNkZGx6U2F4?=
 =?utf-8?B?eUpQWGRkdWJRY1k5NFRLbXMwSE5jbnhza3hudUg5aHpOT3RSbUd6UlhCUmR3?=
 =?utf-8?B?MzJzSWx0eTVDSC9HbU9laSs2RWdvT2QyTmErY3E5Sk4zTWt5MnFscmhpY05a?=
 =?utf-8?B?TUMxQ2QrT2VjMFFEMEJKVVRpRXZGODYyRG52V1kweUhyVDl5V3p0R1hDajV4?=
 =?utf-8?B?MjFKNHNDTHdGSXRieW1LRzQwSHEva0ZXaUhULzZoTDFYUys3VzRsNnFLdnI2?=
 =?utf-8?B?amFNd0p2Z3dGK0tyU1dUNjQ2R256Z0MrcHVzaVowTlk3NmZTd1QvWUdyTERH?=
 =?utf-8?B?SnlXQUdzU092MmtncTNnU09iTzljYzQzVjkvcmhqdExvcEQwN1VuVGtCbWFY?=
 =?utf-8?B?WEl2THdINCtPNVFTZjduYld1U2UzQUMrVUhyd2JTblZxWEl0aUI4SE5mVjJT?=
 =?utf-8?B?OWVQSXptYUU4M1NTU25XeTRPYmcwUnpHd0VseGJKQlJ1VXo1R2Zja25zTHZ5?=
 =?utf-8?B?TnRsbE16NFh0Tml3cGxnaGxMemd2STBqUWZVV2pJTWkvbFBnNXdBTG40MWxX?=
 =?utf-8?B?eEpLbUhpcy8wNWFGVXIwSFEwNnNrSFozcG8wVElGQXhlYUEvOTV1K05CeDRK?=
 =?utf-8?B?Z3pSTS95TG1qL2htREQwQm1CTTdxdHRxNlh6VVBpOWdrUFRteTdJTkpQSm5L?=
 =?utf-8?B?RGdVQVgzU1BMMFBvWmVPSkl2WkZxQlE2WUtJT1VIcHJzd0U5cjBBRWlKcGNH?=
 =?utf-8?B?TFZvMjViNktRN29FSGVoeW95SGZYejBiRWI1SzRHdC9RanhUbEdpem9JTE9h?=
 =?utf-8?B?bEs0d0lIcHVCdEllVS91MlBwYXZ6VW55RHAvUVkrb1M1SXQ0OW1yYjVJU2FK?=
 =?utf-8?B?UnNqanFPeDB1Ri94UmoxbitDN1N6bmdSSkhFanVaVGpCdE5pblQvY0hKNjUv?=
 =?utf-8?B?bTQweFpuUStUVVVLQTI1L3ZueE9qYVorVWpoVHlGb3VHSUVoakVrbk4vV3Jo?=
 =?utf-8?B?bFFCcllOUDVoTDlWTFEzcjhlMWcvdWFUcmtWbFlmREN6REFFd2hxbnYxenpa?=
 =?utf-8?B?U0ZKQkttUmprNStZaFU4d083VU9UMXVSM1BqTDM4d00xY1JrSDZMMlN1aUMr?=
 =?utf-8?B?NmJJaHRQalhVaUZISjEzQTQ3aTRKajQ0b0NUTUdwZXRNWnZOQlg4eHY3LzhQ?=
 =?utf-8?B?S1BaUGxFa0FDY2NCYUxVRnA3ZGN2MzY2OU1KbDRrby9mTHlyV25lRk9vN1J0?=
 =?utf-8?B?bGN4MUhWWmRxb2p1Vk1JNTFiclBNWjhsWU16LzRjelRDdGZCdXNReTBhazNW?=
 =?utf-8?B?R1MzRnBXUGhOZjBGNjdqOTFYOXEvSThLSW9WWnFGVkdkVjIyS0NMTUl1SC9J?=
 =?utf-8?B?TjdVNURSdXEvUld2YkdyQ1RxOGR4bEZZUE40eEhOUDl4Q0hHWnlNUUk5eXVD?=
 =?utf-8?B?VysvenptK3JhYzdOd0JRa3dvamVYdFZQTlloZkxXc2JrWkpjN3FKVlZzMkY5?=
 =?utf-8?B?UEV4ck5KeE1jZXVFQ3B5bnR1OUYyUkdJTDFaSW1vVlphSktCVGVRZjZYL1FV?=
 =?utf-8?B?bDNhSW1aeWpncW01ZXhMMHZ3akJhdmRxakJSdHJhbE43ZGtFcXNWc0wybTBj?=
 =?utf-8?B?bTErWUdIZnBnSWt6blJyTHVTL01ubldDNU1YV3p2U2lwZG93TjdsbHlmT0dS?=
 =?utf-8?B?czNIaTVITW9kd2hjV3MzaHgyQ0ZTZndVRU1DMUgvWkF2WnEwaElxamZERFYv?=
 =?utf-8?Q?szxfTAYyI2MHEAcTRdPCg45vM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be245c3-c255-4cea-f8d0-08ddf5a8fa02
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 05:13:45.3778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VWwJCzL2Wx3IeUBzgxFaO9qcBXQzeskBNiU8+jsRGZjvWWvnaYGMfguOZpZyMYAgbC/urEbsLenZDJu01evo4Pwp5DuJp9V31wLu1GuXBVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8850
X-OriginatorOrg: intel.com

PiBPbiA4LzI2LzI1IDAwOjU0LCBLYXVzaGxlbmRyYSBLdW1hciB3cm90ZToNCj4gPiBGaXggaW5j
b3JyZWN0IHNpemUgcGFyYW1ldGVyIHBhc3NlZCB0byBjcHVpZGxlX3N0YXRlX3dyaXRlX2ZpbGUo
KSBpbiANCj4gPiBjcHVpZGxlX3N0YXRlX2Rpc2FibGUoKS4NCj4gPiANCj4gPiBUaGUgZnVuY3Rp
b24gd2FzIGluY29ycmVjdGx5IHVzaW5nIHNpemVvZihkaXNhYmxlKSB3aGljaCByZXR1cm5zIHRo
ZSANCj4gPiBzaXplIG9mIHRoZSB1bnNpZ25lZCBpbnQgdmFyaWFibGUgKDQgYnl0ZXMpIGluc3Rl
YWQgb2YgdGhlIGFjdHVhbCANCj4gPiBsZW5ndGggb2YgdGhlIHN0cmluZyBzdG9yZWQgaW4gdGhl
ICd2YWx1ZScgYnVmZmVyLg0KPiA+IA0KPiA+IFNpbmNlICd2YWx1ZScgaXMgcG9wdWxhdGVkIHdp
dGggc25wcmludGYoKSB0byBjb250YWluIHRoZSBzdHJpbmcgDQo+ID4gcmVwcmVzZW50YXRpb24g
b2YgdGhlIGRpc2FibGUgdmFsdWUsIHdlIHNob3VsZCB1c2Ugc3RybGVuKHZhbHVlKSB0byANCj4g
PiBnZXQgdGhlIGNvcnJlY3Qgc3RyaW5nIGxlbmd0aCBmb3Igd3JpdGluZyB0byB0aGUgc3lzZnMg
ZmlsZS4NCj4gPiANCj4gPiBUaGlzIGVuc3VyZXMgdGhlIGNvcnJlY3QgbnVtYmVyIG9mIGJ5dGVz
IGlzIHdyaXR0ZW4gdG8gdGhlIGNwdWlkbGUgDQo+ID4gc3RhdGUgZGlzYWJsZSBmaWxlIGluIHN5
c2ZzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEthdXNobGVuZHJhIEt1bWFyIDxrYXVzaGxl
bmRyYS5rdW1hckBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICB0b29scy9wb3dlci9jcHVwb3dl
ci9saWIvY3B1aWRsZS5jIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2Nw
dXBvd2VyL2xpYi9jcHVpZGxlLmMgDQo+ID4gYi90b29scy9wb3dlci9jcHVwb3dlci9saWIvY3B1
aWRsZS5jDQo+ID4gaW5kZXggMGVjYWMwMDkyNzNjLi4yMTgwZTYzYzk2M2EgMTAwNjQ0DQo+ID4g
LS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvbGliL2NwdWlkbGUuYw0KPiA+ICsrKyBiL3Rvb2xz
L3Bvd2VyL2NwdXBvd2VyL2xpYi9jcHVpZGxlLmMNCj4gPiBAQCAtMjQ0LDcgKzI0NCw3IEBAIGlu
dCBjcHVpZGxlX3N0YXRlX2Rpc2FibGUodW5zaWduZWQgaW50IGNwdSwNCj4gPiAgIAlzbnByaW50
Zih2YWx1ZSwgU1lTRlNfUEFUSF9NQVgsICIldSIsIGRpc2FibGUpOw0KPiANCj4gQ2FuJ3QgeW91
IGdldCB0aGUgbGVuZ3RoIGZyb20gc25wcmludGYgcmV0dXJuPyBZb3UgY2FuIGF2b2lkIGNhbGxp
bmcNCj4gc3RybGVuKCkNCj4gDQo+ID4gICANCj4gPiAgIAlieXRlc193cml0dGVuID0gY3B1aWRs
ZV9zdGF0ZV93cml0ZV9maWxlKGNwdSwgaWRsZXN0YXRlLCAiZGlzYWJsZSIsDQo+ID4gLQkJCQkJ
CSAgIHZhbHVlLCBzaXplb2YoZGlzYWJsZSkpOw0KPiA+ICsJCQkJCQkgICB2YWx1ZSwgc3RybGVu
KHZhbHVlKSk7DQo+ID4gICAJaWYgKGJ5dGVzX3dyaXR0ZW4pDQo+ID4gICAJCXJldHVybiAwOw0K
PiA+ICAgCXJldHVybiAtMzsNCj4gDQo+IHRoYW5rcywNCj4gLS0gU2h1YWgNCg0KSGkgU2h1YWgs
DQoNClRoYW5rIHlvdSBmb3IgdGhlIHN1Z2dlc3Rpb24hIFlvdSBhcmUgYWJzb2x1dGVseSBjb3Jy
ZWN0IC0gdXNpbmcgdGhlIA0KcmV0dXJuIHZhbHVlIGZyb20gc25wcmludGYoKSBpcyBtb3JlIGVm
ZmljaWVudCBhbmQgZWxpbWluYXRlcyB0aGUgbmVlZCBmb3IgYW4gDQphZGRpdGlvbmFsIHN0cmxl
bigpIGNhbGwuDQoNCkkgaGF2ZSBzZW50IGEgdjIgcGF0Y2ggdGhhdCBjYXB0dXJlcyB0aGUgc25w
cmludGYoKSByZXR1cm4gdmFsdWUgYW5kIHVzZXMgDQppdCBkaXJlY3RseS4gDQoNClRoYW5rIHlv
dSBmb3IgdGhlIHJldmlldyBhbmQgdGhlIG9wdGltaXphdGlvbiBzdWdnZXN0aW9uLg0KDQpCZXN0
IHJlZ2FyZHMsDQpLYXVzaGxlbmRyYQ0K

