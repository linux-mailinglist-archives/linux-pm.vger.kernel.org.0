Return-Path: <linux-pm+bounces-37076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4E7C1E51E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 05:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97F1C4E131B
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 04:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43612E1EEE;
	Thu, 30 Oct 2025 04:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6EkmXjG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0FA2E092D
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 04:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761797080; cv=fail; b=WVhWE33WkqoAvBOmRY64l2vRNU+rpiJ91PWby2pRBgcKcFOoHiHWYQ7hZAMLewf5ngLVF6wHp4GiqGdrmmLPoXGwqjYNUUhqxEIx84sev5zODr2SYcsbNoB+WkBICJNP7WvUdlJqBXjUkpjwruIW5fd/nN/dCg5Op+OEQsKAetQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761797080; c=relaxed/simple;
	bh=n1MRjFCoDBdOuGlidzT278h/Olv0X0GA7RxyDKYezE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KyLmUGx25n3h0DDVYPoX2lDNnAsgxQAWa9Mk5IoXTKjyO7qoREMrUgOm5kqGS2uN01fHwp7bCOtlJVcaxh2NQP4OdV1nNoOlsOIL7Qb5WUi/K5spLy1KsVax6GSU/rVgnT6YK/f1oRyvOUY297JWagdHXVsQSOWm5WBz4+UIuc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6EkmXjG; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761797079; x=1793333079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n1MRjFCoDBdOuGlidzT278h/Olv0X0GA7RxyDKYezE0=;
  b=A6EkmXjGgoy9GvBrC8Ln0uT0p9Im4r512Kv43f0j0F+mL+Rh2VY47T47
   oMJW6SIVaGagpzSjEysfqEXR9tqzZAT2IQ8xlSEJEygTPEepyNDbzcyui
   oLngmfDJeSsSzzIjobk9wlUlZMjaftggex3JuEF+a/FJnHNM4Fj+jhch6
   kjGgYe/iKnLY2MHXQE1yzG0DzR2jlv5jFEfk48R82WD9fGukzrxiRTLbF
   D84J3wNwECOKOYe+J//vbYxSH5K7eccsY+gXVte9+b7Uzd8k9WGKPk83Q
   5M0CVhT/9EnVCIIdN764WICMOqtUL21F+QyuscxWuvZO2Kkvvaaih4Hzx
   Q==;
X-CSE-ConnectionGUID: CRVopdCERs+WJT7DWGLL7A==
X-CSE-MsgGUID: pD6tZnYYTaSTuD5m2ZpSkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="86556993"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="86556993"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 21:04:38 -0700
X-CSE-ConnectionGUID: YSwmOYBwTlOesREh4E1u6g==
X-CSE-MsgGUID: c2aWUDsPRbOYQn7napuD1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="186586362"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 21:04:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 21:04:37 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 21:04:37 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 21:04:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQ4nV7X0cH3HLdtWogSkDiuiyTgn09CknkasX7f9y+AezfSUthrYei9zVEl7gud1Kfqqt/MBOgcr7IneygYn6qwxjRYbovChFkbVXUzaTR/QpR9ezKcp1htXfBvoBBY4hRPjHj2v5ccusElAjwLTIdJePhdmt1tNQdC84YEljHgk1Xa1edftk7n4IPnOSz9ZTsYn+LZQzP7ZqliikjFLHhZ2JEe7j2gkz04NxouTlzk4//j3oR4Kxw6CMI5R26OlDVb2WvqvQ8rS41UTs71Kb5TYIya0GooSLcCDqAFY6MypBM4gNrV0HlA5tL43obPnuqx7WkKCpSgLSHJ9ou6dSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1MRjFCoDBdOuGlidzT278h/Olv0X0GA7RxyDKYezE0=;
 b=CwuuDhOqi9LAVV3L6F3AevoWV3WB0W1kZFTnCVpj3Yri+a1XBFZy+DJJJZD1VZxm1jOWszcyelxdGEBasJt2rjdSzCtbhLvgdZJAkmBQH1C2knrpA/+20mF1AWiy6LzVa9rWM27Aj65SFq/FwF/TuYMI++Q7O+hBzyoKjAJnVM7sA4Hz/domNq0CZlDDWCwD/jcPRRsMsKIqxw9nDw53c2xGGVHtlBZ38A76J7tZBobowilYA+XK42VW25ATNB3VH8poVoBx8AHOM56m2jz28h+lbQd97W3+10+NnYzwcug3cDu5oQVEmU6Rp9FEtDgadVoIAkQktKw4tdN9ACbh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Thu, 30 Oct
 2025 04:04:35 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 04:04:35 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "Zhang, Rui"
	<rui.zhang@intel.com>, "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH] thermal: Fix UUID string comparison in
 current_uuid_store()
Thread-Topic: [PATCH] thermal: Fix UUID string comparison in
 current_uuid_store()
Thread-Index: AQHcSQOPnV/xJ21vgUOTzNoQ9imD3bTaEjmw
Date: Thu, 30 Oct 2025 04:04:35 +0000
Message-ID: <LV3PR11MB876807C7AD95849F834B973DF5FBA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251017072703.2064390-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0hK+ZaV2F8_LEjyCQyyvE-HeWX4Oyw-MVjzODQucyurkw@mail.gmail.com>
 <CAJZ5v0hpWd4Sr4-_OpNSKn5n6=pwqYDQnRX62iCeg9Td0tjeqg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hpWd4Sr4-_OpNSKn5n6=pwqYDQnRX62iCeg9Td0tjeqg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|BN9PR11MB5323:EE_
x-ms-office365-filtering-correlation-id: d8504e67-1ac7-42e3-357b-08de17697061
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NzdNeU1PVmlEVUZnZFBGYkNISGhlVi9BYzdXRTFqSDRYSWtBZmkyQUVsMWhy?=
 =?utf-8?B?bmdYRFB1T3dtbGlDcS9BWCt6cmhiaUJtaXAwUDlIUWVpMlJuUUVsdTdyZlkx?=
 =?utf-8?B?RTZkOWkveUJScTlqLzZDYXVGSHRpUFd4anBrbGRTWXRNWlJSczBMQWFiMmRP?=
 =?utf-8?B?STRtUEE4U042OFgwQ2Z3VXpsVWxhTE9SR05iTytTb1VwL1orbkVPd2txdlM3?=
 =?utf-8?B?M0xmWHdIdFN1ZVJmQ2FMclZOMDIrZk5SVDN4U1BMa1pod3JNY1IzajIya29i?=
 =?utf-8?B?b0FxaEowaituM0piSllKNHpGZGpuZE8yckZrcld1dnMwUHJwc1ZBeTBIMnhp?=
 =?utf-8?B?S0Q3ODlLQU81QzZvZUF0czRwdUdvcWQ0MVc1US9QeUk4by9ST1lnZlNXMXBD?=
 =?utf-8?B?a2c3TFAybHdYamZuOE9yamVuN2M3S3Y4bDM1WGl4WHN0SllnTUN2dFpxcDNX?=
 =?utf-8?B?RVMwVjBkSmJzN2Z5TDBvOGJueGUwWEQzNnd6NDliN1ltY2o2SEFqc2NtSDRV?=
 =?utf-8?B?SHZuOFE2M3J2NExneXdTTTJjVlBSMHBxTkx2dXJLcnlnYW9SU1BOaU55Qlhh?=
 =?utf-8?B?Sjh5T1V3M1RHeXdDbVpNc2lXVTJVMVBWN1hyUnc4YmxGZjRiKzNrMjdNZTB0?=
 =?utf-8?B?VUF3K3plYzlmMzZLcEFFYlRXM2EwODgrZFl0K2FyY1F4ZGRPNEJtTkRNbnVM?=
 =?utf-8?B?cDB4ZmJwcmN4VEcvUkZUR0cyVUQzOEw3ZzlwLzAveDhtUTZmanFZSzBUYjVp?=
 =?utf-8?B?OFhlZFcyWTFsWGwvb3VWSE5FOVAvNEs2MzFncngraGdBamZGaDI0eTBDUVpp?=
 =?utf-8?B?Tk5mVld6Q0Y4TGdXcU1Uc05wVlhoT04wVkRSTzZPSU52SlJkQ3hNYXJnOGdP?=
 =?utf-8?B?Uy9QSDFlMnZiSjFUYTV3RFJNeXkxQ1dPWkVUZE5xQzhCdXFuY1VXMW9HWjEy?=
 =?utf-8?B?bHFyVENkVGgwU0dIRzRhQmdSdk5naHlGWHhEMXZYWEd0Mlh4WTJhV3M0LzBl?=
 =?utf-8?B?Vk9JYkUyTGNvREQyOXRGQ1MxZ2tXN0dVM3RnNDdqa200azRQQit1cGo3OGxP?=
 =?utf-8?B?WExJSUlXNnR3NWZkdzAwRW5lR21mZWU5RkFtaEcxVVJBNHgxUk1rUWVta2pq?=
 =?utf-8?B?eEsvOGVQZjVuT0FqY09Tc0pvNEdHZW8wYm0vK3E4Y29ZeE42dDN3bnZuWVZO?=
 =?utf-8?B?NlhuRzA2ODgzRU5Pc1NsRGpPWWlnNGN2enJTb2xjSjAwTSsxVlZrRUQzQWxN?=
 =?utf-8?B?R25BMStCaUVxWlBKVHA0NlRnbDhjOERuRis2eDgyays2Z2tMcDRuME1VUVNI?=
 =?utf-8?B?bUMwL3dzQmxocGUvcGFzcEZRaHRKSGl4Szdqa21HSjIzOEJ0NUR0azN1Qmc5?=
 =?utf-8?B?bXNGc0VnaE11dXdFOUVXMEMzNEhKaEdjUVpZTW5Vbk52TmkyRFE3RGh5S0Zm?=
 =?utf-8?B?OG9SdEpXdmRVUXhDbmRwRjNNbmsxb2NZZjloeFk5UWlMY3BGTE1yTWVrOTZC?=
 =?utf-8?B?Unp1QU5zaTE3TFFIQ1dTMWVwWUhmaHM2aW8rOHZsQzcvN1BVZ3lTZTJsSTFh?=
 =?utf-8?B?MkRDazIzTG9ObWdiNVo4UDhCSUU0d3lzREFRSHlmSFNKOFZ3RmxmTkFtR2Za?=
 =?utf-8?B?MmtETVJabGRMR1JWSm42THFkblppbVY2QnlDdk5mYytqVGlFUEEvZHFyT0Vj?=
 =?utf-8?B?Z2I1NG5RaVJVdjdvMTdpSGtQblkrNWpzYThrTGJSR3dLaWg0VWtjUzl2UGoy?=
 =?utf-8?B?U2RCREdSWDJyb25CdTZXWmFCbjFXQW1vN1d4eUE3OFlpcjY4NTlmQ1k3QlBT?=
 =?utf-8?B?UGptSEdUV0lNS044NytUWjd5V1FUOE80azJvK3lzWnFjb3lxdFY2NklnYS9a?=
 =?utf-8?B?ZTVLQzlxV2Z6QmlMbHNOTU5VNG1lK0xOTWdGcE9LS0FpbENDZzZXNExUbmk0?=
 =?utf-8?B?NkExYW1rc3dHTTh4KzdQWVhaV3NUcFNDNHo0c3BldEk4eUIxYUhVSkR1ZnF2?=
 =?utf-8?B?YzFHbmRZUm5aYWdPNHcvN2kzUlRRTWtzYWI5T3hNTkY4b3BxdkdEVnBzNEFh?=
 =?utf-8?Q?YsKaez?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnh1azJzQ2ZRL0ZwVlgxZjR0dmxiTEdXZTNXRUlOSFcvWmI1REgwSG1Rdms5?=
 =?utf-8?B?V0Q5RkI2b1QybGxEQ0MydlBDdXR5aVlnb01IVk5MR2QzNVJzRm1NdGs1em92?=
 =?utf-8?B?L0V4RXhqR0Jmako5MzBnZ2JPNnZNZ1pZV3hUOWVVeVc3NEloM1BYMDMwSXpq?=
 =?utf-8?B?R0VjS3FPeiswRE1wZ25QMm8wWjBsVU9OZklJQ3pseTZRM2RlWTJJcWhsS2Y2?=
 =?utf-8?B?SUtsZmh1WC8wN0lVQVV0MTg4MWlZUFo0SXJNMC9ZSWsyY05WcmFUL2s0cVFU?=
 =?utf-8?B?enNGOEtqampJVHpCV2lyUVFQSGtINHNBUFNTYzdsMHNRRXQxRGVJTnR0RmZk?=
 =?utf-8?B?VytUVHZlNHVTcFNEa2ZMZWtPbEpvYXFkY3FCeWtaRXlBMmU4NlZ1KzAxZTNC?=
 =?utf-8?B?NVJKQWtxY1ljK29HeGRtVWJydmRtSnRlQllja3VWU1FSSDVOZnE0dU11NzdH?=
 =?utf-8?B?YkNydTZyRG9QdUt6cU80dEFqUWxPMWJnZ2RERzBPNGU4VjI0L0FCRGVEdXc3?=
 =?utf-8?B?cjNQT0NmRVhvQk1UUlJmcHhTelM4V1JnRW1DcVZFbHFROWhyalRjajdSVVFZ?=
 =?utf-8?B?Y1FNRW5LS0NGMTRWWVNwc1hGa3ZsZXY5TVdZR1ZGL3NCMEFBTXNXZWtNQjRz?=
 =?utf-8?B?TFdLemUwNDB6OHVQSkRjUlNkYWU0c3FTQTBVdjgrN2JYb0RCaGxubkluNjhw?=
 =?utf-8?B?SEplNjBMaFhOQ01oSVNrTXBWVlY2RVhZRG9QYXphV3hKMS93QnEyeU0rRnZM?=
 =?utf-8?B?bVROMkhiMXBqN1pFbDZrbHkwd3UrNStyTW9LdFpTZTdDUWNJMGgzMXRtejZk?=
 =?utf-8?B?VmZWRXdnZk9BQTNHOTA5MnUzeDUrK1E1VlNPV2FLTjlMRVlWejAxMHdVY3lj?=
 =?utf-8?B?YmNEZU1mczNXYmFSb004SUwxMm9KN0EwTm1JdzZMTjJOQXprNHg1S2tkQmNp?=
 =?utf-8?B?ZXpoeTdEdWpkM3Q3bXlaSTJ5ZWRpTHpPNVZrK2FSc3kwaEpyc2FTSS9zeVdZ?=
 =?utf-8?B?NjZPc3p5eExlblhvZkEzb1lyNGdUVTdiWTl1TFJFZDY2c2pPNElNNmxUNXdU?=
 =?utf-8?B?NzFYU3c4cXduUE8yM3lVN3JsQ0htT3MrSEN4T0xPeVdZdVUxbU5lT2xFb3lW?=
 =?utf-8?B?ZzYrOTAyaWkvZXBUZmNETCt4a2VuZVZTYXdkOFR3U2pIbXpLWmJ5YXpiOFBn?=
 =?utf-8?B?b0c5TGVVVnZ6bWQ3em9uSkRpblNXWHM3NGJuOGhkNjMyVGg1UVhrWHV4M2Z5?=
 =?utf-8?B?VnNBQTlyZTIzMlVtREUxamZpMVJSUkhHYkhaOS9wVytLUGliTFF2cUhydnc1?=
 =?utf-8?B?YWlISVF5THhXV3VFc0RlWG9Kbmx0ZE9ubkJXZGZFRW1vaVJ0UVQ1YXVtc1Bn?=
 =?utf-8?B?a2ZNYjIzQmUyTTZlYjJ0QmNnb2Z6WkFadDJUT0RxM2NZUWRrRnJ2N2RlbHAv?=
 =?utf-8?B?U3U3S0ZtM3RlNWlJYzZnTFp0cEJ2SVRwY2FOMFZnRm1jNEF4YUpyczdzUVQv?=
 =?utf-8?B?V25kSDJralk4NHA3dngwMDZFUkpaVzBKaXRWQkxxV1A1L3NKMUw3OHU0YjRI?=
 =?utf-8?B?aldzMzFjaUI4NzAyWFRvSzQ5RXR1TlhjZXF4MU5zWGZQSU5EbHZlWkdRci9N?=
 =?utf-8?B?ei9pbitFQnVSaFRRajZOV1ZGcmg0eXY2K3lsTkNzVVh6eGNhcFJCT3hQV1lS?=
 =?utf-8?B?ZkZMNGRYaWFmRjliNWhOVms2ZCt2S3EvY3R3Q1VuOTJTOTFUYnZ5WG5XTnVj?=
 =?utf-8?B?bDdEdWhEME51Sm1iM2tHNVhuTTYzamZaZzk0bjNzU0NjMXVTaUFUTVZyMGdS?=
 =?utf-8?B?NloxbWVGdFFJYmRyOUgrK2xRbnMvS2w2Y2tKSnlJTzdZd3FyUU1qa1grVjdr?=
 =?utf-8?B?bEJpSXJQMm0wa1N3WjF1UVVhUFJYOHE0S0JsYmJITjJYeVk0SEpOV1NFYU52?=
 =?utf-8?B?SUpUK2I3VC9BMXVDZTFkVStFRXl3bXk1enNtZTg5dDdWcnJhUmVQaGVnNllE?=
 =?utf-8?B?bi92REEwdWJKOHNUdU9Cd1h3TjlOOE9ibXNCVGU2M0IzMzdmNURsQ3FvZzBR?=
 =?utf-8?B?MWczQllmaDA1QWpqb1puUi9aZDV4cnBDamd1cFFlN0lON3dNeVFQUjd2QWxo?=
 =?utf-8?B?R3RHV1BmNkRMMWdaRVRwMjdZdlI4RzNYTWQ4ZGFxekRvaGx5bXE4dlBvT2tY?=
 =?utf-8?B?YXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8504e67-1ac7-42e3-357b-08de17697061
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 04:04:35.7427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjU02FGSJ4jLrVI4L9Mfev3kbx8i1btdEkJmU2TZ/l3bxi4R0AHTSS1guwArLzm0vUsK3MBeVKJbYbqcpipL5Sezv0WXZoruztDRxV3ZSww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5323
X-OriginatorOrg: intel.com

T24gV2VkLCBPY3QgMjksIDIwMjUgYXQgNTo0MCBQTSBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVs
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiBBbHNvLCB0aGlzIGNoYW5nZSB3b3VsZCBhbHRlciB0aGUg
a2VybmVsIEFCSSwgcG9zc2libHkgY29uZnVzaW5nIHVzZXJzIHdobyBtaWdodCBub3RpY2UgdGhh
dCB0aGUgZmlyc3QgNyBjaGFyYWN0ZXJzIG1hdHRlcmVkIGFuZCBtaWdodCBzdGFydCB0byByZWx5
IG9uIHRoYXQuDQo+IA0KPiBJZiB5b3Ugd2FudCB0byBjbGVhbiB1cCB0aGF0IHBpZWNlIG9mIGNv
ZGUsIHBsZWFzZSBjaGFuZ2UgaXQgdG8gcGFzcyBhIHN5bWJvbCByZXByZXNlbnRpbmcgdGhlIG51
bWJlciA3IGFzIHRoZSBsYXN0IGFyZ3VtZW50IHRvIHN0cm5jbXAoKSwgYnV0IHRoYXQgaXMgYXMg
bXVjaCBhcyBjYW4gYmUgZG9uZSBoZXJlLg0KDQpZb3UncmUgcmlnaHQgYWJvdXQgdGhlIEFCSSBj
b25jZXJuLiBJIGhhdmUgc2VudCAgYSB2MiBwYXRjaCB0aGF0IHVzZXMgYSANCnN5bWJvbGljIGNv
bnN0YW50IGZvciB0aGUgNy1jaGFyYWN0ZXIgY29tcGFyaXNvbiB0byBtYWludGFpbiBleGlzdGlu
ZyBiZWhhdmlvciANCg0KVGhhbmtzIGZvciB0aGUgUmV2aWV3IQ0KDQpLYXVzaGxlbmRyYQ0K

