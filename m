Return-Path: <linux-pm+bounces-38328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5E1C76E42
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 02:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 00C5C28D61
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 01:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2721A38F9;
	Fri, 21 Nov 2025 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="POOtwkT2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C23BBF2;
	Fri, 21 Nov 2025 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763689805; cv=fail; b=OUg2jXlfE5T8SLyvX0V3eZVj1FJ1HLmHGHKLxwCfxbfoEXyhlbp6gyTqziPQHEJziApwjLfn/9zRIuoc3Qgrdeu5E85dpz39l7c+51pgxCK95YD05dfd4TFm/TXqPerDA3zq4pC6lua56JSJtG+DzEbF/HCLXF9wiPkkHiPFIKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763689805; c=relaxed/simple;
	bh=IRFb0jPh03OuB+ga5hQM2sMINv8wqliqGKeg93rjOXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FWFXR4VBw+AVMY3G0e8tNWyEAiduNu9IIq5okDN9SYvLpHWzqRan4RiONaB/265XNu7O5dP+IW9z+r8JCeukyhqpeck/YMVUqdvTbgdKe6yUhWsB3cZXA30eoEdVY3KaJUH3R+jGJxINWrwNGsTeAGmRAu1LeZtojNMt0snSigk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=POOtwkT2; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763689804; x=1795225804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IRFb0jPh03OuB+ga5hQM2sMINv8wqliqGKeg93rjOXA=;
  b=POOtwkT2DfT79P21TRijoGORi9xzbuDnUIgebYLMRIeuHGgVlIIUgIot
   HGUGEX7izMjj6ZzCMa4r7F7JQrXH9WLFjxix4AS2iQaA64A8oRkBD9reL
   +TmphfMwtcXVoK/wqlaqA0bKxNdd1hBSM4z/K5YrdP7JtmNtbRUQUnuhT
   laYNqlkgB/ISCd3ryao4QIhU7KWbBZu1OA1w9ZJAy+bBcKZ95/sZ+WOXD
   P+v1vLf40SVKCy58FuQqKTXD43gA+aUp1QyXJILIOpLmyyhBeVqX0/xP4
   KjH0c5SUecsQUtJ7UM/D0IDJ7JoxRrMU5shvQrGSuL70gL5B8o084uzFs
   A==;
X-CSE-ConnectionGUID: NgRlBMubT6emT7ZNTEVECA==
X-CSE-MsgGUID: hnnf70ylScek4da1zD16mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="53349717"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="53349717"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 17:50:03 -0800
X-CSE-ConnectionGUID: MjkSmqNGRL6YCnSKQkZkqg==
X-CSE-MsgGUID: xUTHk6bVTAajbk9j+SeCJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="191789841"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 17:50:02 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 17:50:02 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 17:50:02 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 17:50:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti5nthobXiXmAenGW9Tgw/n6CREZQHGAwEzI/wdNOZGzQ2jpOgPfi+Jt19y9KbDDCcgJ5UReVFGfBww971KPu+2/yz8oTCZFbn5QiaPqnV2gxcZdkAkpJk4DO0kOZY1CebWkzQkbbFZi/DgVKqhXYAZMfGMdzJvxdoUPfYCI1mMAmVtM4nv7MuIjYHOrSTfPioCkFYcS8a+aSJZ8FQoYMtGs4H2rcn5EsVbFpnPGA788q/QDMq2pKqDCKzxvim5i8XjYNh8OzArYa3wsHcagWc1nFCA8pAwo9lXhN+X+bcqSimIkw82VOGBr9Ez3kxQa3e20SmO8QP3c7zMKfwetHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRFb0jPh03OuB+ga5hQM2sMINv8wqliqGKeg93rjOXA=;
 b=Ze/GwyJKmc0VOO1Bvs/NzMzHkZV62FHdIEEI1ws7K0F4Snh9KNJTCNs6XVe4ja+DyyGhCHZgxu2zrzsxshjSe6SdFF6wUVU0uuobEGDQhNWI2jnRvBO38W0lXfaTCE560DS1GGbJKNBJDMf/lLWrleNjFXjAqhuwqdJgjvscsCbW+W7JL3gkqameuCK4LpDNB7ooSyeymiRfaIBSs2TL9M+ACtN6Ph3SE5SIWbhWoXh1YSCdiXojsq+6lKS35bcI0aLVOoHmD418gWFQSxPzxZLsALtgXY9J0zLvIuhCBakCUyS2A/5M0b5vBpDcmkHpMSyoldrfXu8Kdh5PKrdKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 DM3PR11MB8714.namprd11.prod.outlook.com (2603:10b6:0:b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Fri, 21 Nov 2025 01:49:59 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 01:49:59 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "Zhang, Rui" <rui.zhang@intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] Add MSR-based RAPL PMU support
Thread-Topic: [PATCH v1 0/2] Add MSR-based RAPL PMU support
Thread-Index: AQHcWokl1vWN5+vCoUaOH8qwlPgtRw==
Date: Fri, 21 Nov 2025 01:49:59 +0000
Message-ID: <515d0c022fff823eb7dbad302ab2b4443d6926fd.camel@intel.com>
References: <20251121000539.386069-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20251121000539.386069-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|DM3PR11MB8714:EE_
x-ms-office365-filtering-correlation-id: 0a10f6e5-4262-4040-cc05-08de28a047cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YVVMc3JCRGdzZXRxc2w1VG1oUm9nWFJEZzFxUTlzVmhiN1JkMXpaNENvVHJh?=
 =?utf-8?B?YjhXOWt3dVdCN2RjQUZvdjFzbHFOUkd1YmRkOFNDbXhjZC92UkkrME10QWUw?=
 =?utf-8?B?SnUvb1A4QWIrNi8xVTdpcDVMa3hQdFV0dWluMlR0K1F1UDhoNW80Q3BqeDdm?=
 =?utf-8?B?VmZmMG9ucm9kK3VqVUpDZldFSWl2WlZ4MWYvRHVjQ3FFMXlXV0NYcWQzUGVF?=
 =?utf-8?B?TEhwbnlweDNacWR5b2RvUkZVc3RYcnlnSUQ0Z3VrbnNsbmQ4Nm9Cams1Rm8y?=
 =?utf-8?B?Z1FqNzVLM1dTeklmUi9VVEd1blFrZWJiSDhMdzhoWU1oY0RCZ3pQUnN6V3h5?=
 =?utf-8?B?U1FRVVBNa1BuUFZEaUtOVjdSZGNab3UzNDRBOEhub2ZRNE9DYU0zZ3lRRUkx?=
 =?utf-8?B?Yk1KS0JxV2R3cjJlWkEyY25zeWFHaWkzMzVMUDlmTHZrTXNkeDM2TUVrM2Mz?=
 =?utf-8?B?Y0lyTUFVNFFNaFJvT05hV0l1dWQwQWhSam1TY2NnWTA4SlF6SDVVSzFWK3J0?=
 =?utf-8?B?ZE5tZkZHd05tVzJITVAzQVRmUGF2SVFYWW5OZU9Ud3FVRjYrUU9qWlpERndE?=
 =?utf-8?B?K2xNMDFzUU5pdXFybVFCempacy9ldjF4VS8zWXMxcnBlSXJRcU5xZ0J5Q1Zo?=
 =?utf-8?B?WnR1YTJHcVcwb0FHYVFDUXZVdXkrbDdoVVJvdUd5K0lWRXV1T1Z5cktxUG9C?=
 =?utf-8?B?bG94cm5kNnlqN0dZdDQvTm5qM2dKRyt6TldEZ2pZTVJJNDYvb1RyZnRvSmNP?=
 =?utf-8?B?UHpCTFpVVURFWk85S3cyajdDWmpKOG5PNHllclNWZ3RDektTSVZxcTV6UHl2?=
 =?utf-8?B?cXYvNjZocitjeFBxWGR3UktpaWE2WFpmSUlFR0t6TVdxd3htVkJncFRBZGRG?=
 =?utf-8?B?QmR1QllvYkJoQlRzaURwVFUxS095UGVGbEc1dlVqMHZVQnpDN3B0ajZjMnVo?=
 =?utf-8?B?ZW5DaFFHNjdtbXlDenVsYlAzcTFEWGZFblREMHEvajVCRVMzZm1SaTd2TERl?=
 =?utf-8?B?eWp5VG1hQjVKUjhwNmpDcCs5dE5mK2kzNGRFRnNnVDNxQm1IMGtzcTRwQXpw?=
 =?utf-8?B?Vi8wZWpCMXVjQlRCMnEzNDlvWkM4VmhQOEhwR2hrbFBGR3FLZVAwTmJyNTNF?=
 =?utf-8?B?MHp5K2VrQWFUdE1tUFV1THlVci9oS2F3dUVvdDEvUEdIbE9YRmhMWk5mcVBk?=
 =?utf-8?B?WE9jRnJvYWxFS1NHUjdGMUpsOW9kRXczY3gvbkRDY0JoVHB2azA2dmIwd0o5?=
 =?utf-8?B?enR2OE5IVTBlNXl4S3doUHVsRThnNDRibUc0WkhzaUs2SjBTZGMrN2w5TlJr?=
 =?utf-8?B?YTZEeDJJV2I5aDZoUUM4b1JXMGR3NjNOMHdqWGp4Nzl3aVBnaU0vSFV2RjZH?=
 =?utf-8?B?NkdPQnlybkZrNE9jdjZLb015Zm04OXlzTkRnTUIwVVo1cDFQN3ZlZm5VU3hY?=
 =?utf-8?B?bG5DbmQybDJrRDdIZjQ2cEMyK0d1d3JIa3RWc1l4YmxBdFgrR2lkM2gvc2h0?=
 =?utf-8?B?OW00SkJwYW9NczIwNlN4M2l6ZFZEUjN4eVRVazNJWThUN29PUm5iYlp5S0Ir?=
 =?utf-8?B?eklPS2xnekVrZEpOQVZaSC8zU1VRcWcyay8vbUR0RkcrNDRCUVRSQTlSZy9k?=
 =?utf-8?B?c0dBS1R5Q1ZLRTNXM04vcFhvaUF3UC8wMmdrSFBWMjRaWU1MVXgrdHROMTZ0?=
 =?utf-8?B?UVh6b01MbXRnSFhnZk5KVTZZTitPQ3VIV0xKTkxKQmxqUzVDVUNmU1VuajJM?=
 =?utf-8?B?WExKMGpWU3NzRUpBZkhTOFp1NEFrcWgvS1N4RFFRZDZpL09RYldPUnZRVklX?=
 =?utf-8?B?SStINEVnTWNpazFqaGVXNDlVc0tQcXYwTlBFZFFtZUtXcmFhNDFGZklOOG9y?=
 =?utf-8?B?WG1HQWQxZzBDNjRINzR1Z21Bdld6L2UxTEYrZ0QwNk5oTjRrQlpPenBuSW4v?=
 =?utf-8?B?RkhhYk1hdzM0N2gvcUVaS3Uvc1kzZ2hlQnB5dUpia1JjZ0s2QlJCczdYQkVJ?=
 =?utf-8?B?ang3RnZOY2RqamxucXlzc2ptZitDeDA4NkVDTFE0TCt4YmxuM3ltMkVDaFVu?=
 =?utf-8?Q?liUEon?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE9aZVJMT1dHbXJPU0NRR2g2eUp1cUNtNzl4M05PQTBoQW51L05lRUl5VnFO?=
 =?utf-8?B?NWkxbDE0RUpkbU0xWTdycHBMRCt4SDFrekJDcDZZdVVETWtKaEpnQThtRW0w?=
 =?utf-8?B?WE9ZOWd4QWJNWW9vTDZPOWx5Mzd1N3JlM1VCRU93dlhEVmhpaGQzSEZZYjd6?=
 =?utf-8?B?MVVZZjVpaUdObytsVVA3ZmZPNXh5VmxwaFo4Y1Y1cS9CSnlpNmcvVDBsSmp6?=
 =?utf-8?B?THBHdXJ1ekN6aWlXSEIwT1hxTVNPSFJwclR4U25MdFhQdTdoZVVTcUMrK2Uw?=
 =?utf-8?B?VzlET3lFSU5GTXZBTW5aRHlQN2JBZHdVdFMxek9HalFXT3h6TFlMWEZDUWdW?=
 =?utf-8?B?UjV4cXJYNnduTk1tSXgxOVVaOHVEaEdrb2E2T1U5Q2xSL1h3d1B2ZVoxZmhi?=
 =?utf-8?B?WXYzUUd3bEdVWUpFemt6bUQ2b2xuakxYN2QyYi9GTFhKcExDVjdWZ2h1VkNo?=
 =?utf-8?B?eG1SVlRwYThwLzFyb3NwTjFvUDV4Njg0WHpUZnJQY2hOcWdScStDckh0eVlE?=
 =?utf-8?B?MFJ6N2l4VlpGdDZSWmVpbm9udkdyeEt2aHpnMDA3MFZLRzFVT0tZT0tTQUJm?=
 =?utf-8?B?cDdxNGVkczg2SE5qQVZjTjUxcmJqaXhWRDlKcnpPbFozdmhSR0tjWmxZeVYv?=
 =?utf-8?B?SXBad0xmQzJPSndrMDIyOVJnOTBDUnZRb1hqZG1xS00wVVpNdnhxN3hVcW5z?=
 =?utf-8?B?QXYzMmlaTmZNVXpJK2lWOGQ3SGtJc2E1MWxvR2wyTzA2aUE2dUJhN0JIZTMx?=
 =?utf-8?B?MEZEdDE1YnlrN1VkblhkVXg2UDBKbkRwekFEaUFDMUcxenBJcndiSjV1ZmJO?=
 =?utf-8?B?TGZIQUVsZVlzK0RWS1Q5c3VVVm1kUExDSVRIZHdJTkw5SHIvakE1QzAzTFh4?=
 =?utf-8?B?amlSY0tXYXJoSVBNS3F2N0FwUXk3ZG1lRHhUdUczOHJRL2wrdFlkQUo3amVI?=
 =?utf-8?B?TU0rcXhvOXVqSDhzZ0lucGhNUXhGSWFjUVIxMkFGN0tjN1dyMlIzZHpTNmdD?=
 =?utf-8?B?OU9NamJTUmQxK1FwUmVFM2xPYlRGRkZBaGxBY0d0VXgxWnNINjd2d0luUlFX?=
 =?utf-8?B?ZkQ2VUdUV0hZSFJmamt4MCsyTzUvVC9KTlhsOHIxclRqYXN1Q3NUR3F0Umoz?=
 =?utf-8?B?Uk12aHl6ZkVCV0FjN29tYTBUZWJvQWJtYVNsTE50SnpBdTZnSUJ5Q3RsYTlO?=
 =?utf-8?B?SFNLRlZpN2hTMEVoZUxMSlEreWVpbjVOLys4TklEblFKQkNyU1pFZzY3RFZ6?=
 =?utf-8?B?bklWdFVKMmVZU0Z2TlBGZ1Z3M2cvcE5sK2pwbUtaa0RDQloxUURIS1pSU3Z2?=
 =?utf-8?B?MkZ5NmErMllzQnFEaTc2MTZkSDV0bkR6YjA4dWpjdVZFMnFhTWVFZWhyNDRa?=
 =?utf-8?B?WlhONjRpQzVGZFRtbFZ2NExCbGlBaWJzNVNidmtqd1djTnZ2UHgxUHJSTGV6?=
 =?utf-8?B?WVVOWTBnWkJqSktacS82VnpkVjdJT0RmdXJwN1RlSTBsRzlJMUkyZlVmZitq?=
 =?utf-8?B?aGh0YjJBWCtLa204NnZFOG9rYi9PeHJMTTJIZGVySWhSVnEzS1RJbU1FTmF2?=
 =?utf-8?B?V2kvSGRiQlJDbk5zS1JCU3Nhb1VGZ3Y3UUNEQnVPVFNVRVE2bWthTG1heUNK?=
 =?utf-8?B?L1dVaWx2QVdkN3A3ZUN4Vm5qYmpJRUJBYmJqbStSdVZiekc0RkFvUXpxc2x3?=
 =?utf-8?B?WUxnWUh6WU9SOGk2MVZHS2dORWxqMFVtcDg3VXJGa1hnbldZQ0szdmVHMzBa?=
 =?utf-8?B?SkNhK3JiOGVIa2tKUnhpcE5RbHhCeTd6aXowWTdPL21XOTdLcGE2Nm5LY0dI?=
 =?utf-8?B?ZkYrNHBqcGxpbEk4Z1g2THFvbFFGc0s3dURLMGtPTkdKVWNCSHFIcG9rc3FR?=
 =?utf-8?B?UmVybkxNMVJ6OTdReHBQckwxdWtsSTVxTUVPSUJTQXZPZEhwN1psTFN1NTJQ?=
 =?utf-8?B?M1FReFFYRkxoaE9POWcxT1puaTFXKzlUZkkrWm1meDV5NG1pR1BSY2ltR2xX?=
 =?utf-8?B?ZGp1R1k4L3B0TTBWUlRCbTcrZDVWMDRhdVZSZ1d1NldubDdQSGpQRzNjejJB?=
 =?utf-8?B?aXphZHcvdEdhaWQ1eWJ4VmovT0V3M05ROUlSUi9DS3dTM0x5c2FKV1RTQlYv?=
 =?utf-8?B?U0NKeklDNzFTaGM1L3V5cndQdmEzcmRIWVR4THE1UDIwamdncUdvT2xBNG1t?=
 =?utf-8?Q?8HLTDx/8E1TRZ+TTWB22h1w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A4D9EE3BBA7CB459A56927629149D83@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a10f6e5-4262-4040-cc05-08de28a047cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 01:49:59.7529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0z0Tt0+Xf0kDQuAghu1Vu+14hpb2sL4ssOQHrw+ZqDdRiScVrs8gtbRVsG1j1Bwl4/vUAXCSkfQ9vnE5dv2N+kxKbTYTd4uZYopDuPH4Xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8714
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTExLTIwIGF0IDE2OjA1IC0wODAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5
YW5hbiB3cm90ZToNCj4gVGhpcyBwYXRjaCBzZXJpZXMgZW5hYmxlcyBNU1ItYmFzZWQgUE1VIHN1
cHBvcnQgZm9yIHRoZSBJbnRlbCBSQVBMDQo+IGRyaXZlciBpbiB0aGUgTGludXggcG93ZXJjYXAg
c3Vic3lzdGVtLg0KPiANCj4gRm9sbG93aW5nIGFyZSB0aGUgcGF0Y2ggZGV0YWlsczoNCj4gDQo+
IFBhdGNoIDEvMiAtIFByZXBhcmF0b3J5IHBhdGNoIHRoYXQgdXBkYXRlcyB0aGUgcmVhZF9yYXco
KSBpbnRlcmZhY2UNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0byBhbGxvdyBhdG9taWMtY29u
dGV4dCBjYWxsZXJzLg0KPiANCj4gUGF0Y2ggMi8yIC0gTW9yZSBkZXRhaWxzIGFib3V0IG1vdGl2
YXRpb24gb2YgdGhpcyBzZXJpZXMgYW5kIGFkZHMNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBN
U1ItYmFzZWQgUkFQTCBQTVUgYWNjZXNzIHN1cHBvcnQuDQo+IA0KPiBUaGlzIHNlcmllcyBoYXMg
YmVlbiB0ZXN0ZWQgYW5kIHZlcmlmaWVkIGluIHRoZSBQYW50aGVyIExha2UgYW5kDQo+IFdpbGRj
YXQgTGFrZSBwbGF0Zm9ybXMgdXNpbmcgcGVyZiB0b29sLg0KPiANCj4gUGxlYXNlIGxldCBtZSBr
bm93IHlvdXIgcmV2aWV3IGNvbW1lbnRzLg0KPiANCg0KUmV2aWV3ZWQtYnk6IFNyaW5pdmFzIFBh
bmRydXZhZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPg0KDQoNCj4gS3Vw
cHVzd2FteSBTYXRoeWFuYXJheWFuYW4gKDIpOg0KPiDCoCBwb3dlcmNhcDogaW50ZWxfcmFwbDog
UHJlcGFyZSByZWFkX3JhdyBpbnRlcmZhY2UgZm9yIGF0b21pYy1jb250ZXh0DQo+IMKgwqDCoCBj
YWxsZXJzDQo+IMKgIHBvd2VyY2FwOiBpbnRlbF9yYXBsOiBFbmFibGUgTVNSLWJhc2VkIFJBUEwg
UE1VIHN1cHBvcnQNCj4gDQo+IMKgZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5j
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMzYgKysrKysrKysrLS0tLS0tLS0NCj4gwqBkcml2ZXJzL3Bv
d2VyY2FwL2ludGVsX3JhcGxfbXNyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0MA0KPiAr
KysrKysrKysrKysrKysrKy0tDQo+IMKgZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX3RwbWku
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4gwqAuLi4vaW50MzQweF90aGVybWFs
L3Byb2Nlc3Nvcl90aGVybWFsX3JhcGwuY8KgIHzCoCAyICstDQo+IMKgaW5jbHVkZS9saW51eC9p
bnRlbF9yYXBsLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiAr
LQ0KPiDCoDUgZmlsZXMgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0p
DQo+IA0KDQo=

