Return-Path: <linux-pm+bounces-9533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C140490E1F3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 05:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 338CBB221B3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 03:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BC55381B;
	Wed, 19 Jun 2024 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E+UpDb9m"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F311E498;
	Wed, 19 Jun 2024 03:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718767541; cv=fail; b=DfSFUC/ENFuY7yiAeR5N5wO15cJn3YJCm9YD/6Q8B6klrQwqvKlLdxLv+1M1hQYQKYn5RpkJraAz31Bvc7PUU7nG+xn2FUsaqw/Xzs2HB3CTEqHaHu04Wj3vk1r1MJbnoqmU/PWS+tumxZFC5nwXxukZFRnRFnjdiqaR4CDz0Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718767541; c=relaxed/simple;
	bh=uCV/z/ZBqyVfEDAq2LUeQvlJFuUylpphiqbNQjxuxrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FerIW9gs3W4wBrciHCyLz0BQO050UpFY57CyMIU4jiPW4AXDqjfRA9rZDOaW/NsEx3oL3xkrAlJkgXxTnRjlZCS51Dn29k9CGd8YEEa8C6UrqtN16VEED9WLaXYK09LQfmpXLxzgVLrEaXmmo2709MJxjn/KaOkXrBXJPgBk/f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E+UpDb9m; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2HEFgQZ8Q6TmqubEJehc+tlKA9BQr+YVCPWgFfGTIE2ieaXS86rUNoFzgB2MpObLZxlb5xHY4GbnDYM5onkcy0lkBGiqC+1E1RDj1MavTEphULmV/PYxZKzsTzxvTjxrE+ty6oXDJdMNwb4HLnDYAa9Btn4Mw6laI7yv2VBw3BMvVfvFgYN6/UhkkNfR5AVcdOexKDYlBzBA9/kxJKDLChIB9XfYbu6Lhg67VuoO+UnHBqFSt1QN5jww89YiWV1S8rvnsV6KH0pQer4t0ipDO7nbmsdlGO9qb/lBGPZLWQp/fbh8NE0ijTda3gIt4QGtJirt5cLBtWadQ3KoEvB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCV/z/ZBqyVfEDAq2LUeQvlJFuUylpphiqbNQjxuxrk=;
 b=Fo/hu14TSoS7cLm0TtGW3SoXCOFk17e7h9i546chAkLZBMmoRfLkQRtg9czU+t9B8RZqvZGa4aRaA5HILFf6c8Q6uLhzbz2lkRS8cfKxLN6/P0LFL06PHu2lRymijjfWgb7m2RJRhRhO9W+AsNLtsuLQgKpfdDfMlxrxAcKYXnNJ6E4mzDIUnYk8a+DOfmSMzXy1ycsmq27cUaFAIeDU8wG+bfJTcqSmgo6J2O9Q8GnY4Xy9UE2in+qstWVD5XpFmUUtGg4/ac7Uu9PsVTyP6CW6/vLlT/QWRbM4z8JWp0iRvve7S0MPcoVv0/INhy3W8w9ysl6iO5/P/mPvQUNdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCV/z/ZBqyVfEDAq2LUeQvlJFuUylpphiqbNQjxuxrk=;
 b=E+UpDb9mTzFuXnc+zT0nZ2qnBVab/uD8msm7bp3fksEp1GNMtTzWEBbzCj1ZmHO6e8gPYHfHh7lgRw7412FGlgfuhSFeHCjUmOpspROfcvX8xR8hozGaMIA/HjprzdJLpa1jkMLdyn8FZLT7AjDmdK9kLdf8hKUd1P2HB7qbOZc=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 03:25:37 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 03:25:37 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 09/11] cpufreq: amd-pstate: implement heterogeneous
 core topology for highest performance initialization
Thread-Topic: [PATCH v4 09/11] cpufreq: amd-pstate: implement heterogeneous
 core topology for highest performance initialization
Thread-Index: AQHawIR56hTx+LxjYEu2/Dk/J06ieLHOCpQAgABkaJA=
Date: Wed, 19 Jun 2024 03:25:36 +0000
Message-ID:
 <CYYPR12MB86558EDF651234DBBF002EFE9CCF2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
 <7aad57a98b37fa5893d4fe602d3dcef5c3f755d5.1718606975.git.perry.yuan@amd.com>
 <20240618212348.GFZnH65EdA9cCGoeoM@fat_crate.local>
In-Reply-To: <20240618212348.GFZnH65EdA9cCGoeoM@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9081d2cf-0e4c-4baf-92e4-81b14a510c4d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-19T03:23:10Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CH0PR12MB8462:EE_
x-ms-office365-filtering-correlation-id: 9a250f3d-ad2b-46db-bdc7-08dc900f7ca6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDZtblVQVXBjUUNpaGlVL0FPOEVDSDRHdjJvOCtiYkpDckl3Sk9nZWNrN2x1?=
 =?utf-8?B?a1Y4RzdnclhrUUQ0cnlLd1FvQTE0RXhTd0VMRG9XNVVic3BwcFBCcVRoOEJz?=
 =?utf-8?B?S3czWTNzUE1idHAwTitwTDR1UW9rOEtBUzVpOGFwbWc2NERLYU9pMHFPekpU?=
 =?utf-8?B?Ym5LTkFQc3Q0NDlrcyt6MG1vVnNaOWQ1cDAzd0dFV3AxVnozU1hlMTJhTTkw?=
 =?utf-8?B?eE4xOCtYYXFmemgyT1NVUlh5T1h6blg5SEJxL1p4cEFMdnp2OExYUDRiZmZY?=
 =?utf-8?B?dkVEZmZuZ0szMnJCZ2hxT1Rkd01EeUJJcmdKY1RSeHpMVU5kSDZWOVJ3MFpl?=
 =?utf-8?B?VDVWNjNWUjZpZC9FRWhnVHd3NHFKZFM1OEIzN2JxRjZMc3dJNjc3bU92SU5X?=
 =?utf-8?B?QkowRWFyTGt4clMzbER1MWpTbUprRjF0WUVlS0JVeWl4SkpKNlV4aEJlbXNQ?=
 =?utf-8?B?NGFETU5CaDRUWTVhdzFaTlIyS25qMGYrMUNMU2swK1BOUmdsSktRUGlmaFN3?=
 =?utf-8?B?cFQ4aUZsamtEamxiUWx3dThzR2VGSSt0Tk5CeHBYK3ZRREdSTkZoR2ZDWVVU?=
 =?utf-8?B?ZE9pU0M5V21aQ09HSXkrRDlIL2FoVTU3aklBb1JlbGZkNjhyTWNzMmpYSndT?=
 =?utf-8?B?T3RZd3d6QkVEUTE3ZHdzbk1scGNvMUd1Wll5NUM1U2pKWFZIUmFsRzBrb05s?=
 =?utf-8?B?eTZ0TjdpU1g3WS9jbitBSkdEcVRsOWwyOGtNUmhJSlNLREhiRGdsWVNEenMx?=
 =?utf-8?B?eHUyRnBJSzNWOHY2ZUR2QXZ4aThzQ21lRTB0bUpudkNBU3pmUHAvKzBVdW90?=
 =?utf-8?B?NG40MlNmbGlRQ2IrWjJxSW1EdWNBZnBZRzZYaG10YnZITGFlMDc2MEpEL3h5?=
 =?utf-8?B?eVgrWW9BaFk3SnR3c0N6R2NDeG5CdFBWUmQ1V0xQUVRwbWRUOW1PS0k5dXZC?=
 =?utf-8?B?TXdnZmtuQ3R0OElDcFhYTlhEWjlXS2lsVEltZDRjN2V4YW00d29XQldpL0Fo?=
 =?utf-8?B?ZForZmV3WkNSOXVCemdMU0ovOURtNnFOR3RGSkR3RUZIQ1NEUWFGVmRmOGZu?=
 =?utf-8?B?OGZ5VHMvYU14UkJmbitSdUxrZ0xTenk4amFaMDVTTlppZ0lyL2U1T2FDeXNB?=
 =?utf-8?B?MC9WVnBPL0FGaUJ6ZC95SW1uWTlnQ01KUjNRdU41QmU0N0kvZlZJT3BGOS9y?=
 =?utf-8?B?L2k5d3R2emtjU3BxeUliYmtyWmNXNGVnejlDcXRnODBsK1hDRS90WGRxK3hR?=
 =?utf-8?B?TCs0QTRHT0Y1QkR3U1gyUlRub2lKR0ZHVEt4emlmbGZ6NXRIcU5yTlVudmNp?=
 =?utf-8?B?RlQ2WW42Sjl0VmtjdWdJU3dpd05PdXJ5cXhOWHVkZks0WE9oQWFvV2o4Skpj?=
 =?utf-8?B?M0JuUVc2ak96MGdoYk9yWVFUM3pyaEhXY015ZmpYRmx2YmdYZFRzVmM0dDdC?=
 =?utf-8?B?UEg3bDczOTh2YlBVZ0tjTFREam90UklaNC84YkR2QXdrZER4dk5JRlNHcExv?=
 =?utf-8?B?a2tPd0xMOHIvN2UzUGVLN21ZcWVTbzlHejljT0E3WGFQQnI4SUc5RldHcW00?=
 =?utf-8?B?eGE5L0MvbEorMTMrUVlrZ0RGMnp2NGE5ckJCSFJtdzljMzc5STU1WUhib1N6?=
 =?utf-8?B?Q1lnYXM1cFRZSE1YWnF0WDRFVTZBOFY0VXRzUVZmblBSVHdqL3pMWlVtWUFi?=
 =?utf-8?B?RGFndFkwN3crQmZlNnRJZkZLYkUzdHp0MUlnWG5sU2NOUS9rbk4vM3BJakcx?=
 =?utf-8?Q?MsLUmIKPs5K+GUobWN8Tf8kksaGdtvRz5r/rjjF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlVwZGpoMkZzam9BajNNSzg1Q042dW0wUGdmVGs2RENlczdGcXNwRHQ2azF0?=
 =?utf-8?B?MWRQS3RLV1E1OEFtS0VpVHArenVXU0cwR1ZDVk1LdHY0cWFHc0MxVUE3ZkNh?=
 =?utf-8?B?Q2JSam9MNFFHd1ZOWWFDWW1hZ2RSWlZ0cDlrbGZ0RUhGTUpwWUtyWExSakE3?=
 =?utf-8?B?T1Rib2pHRVZkTjFaU0ZwbjBXWUEyVkY2cXl4TU1ncldzT0szbVMvaUVzS1Zx?=
 =?utf-8?B?akVvcXo3UktVVENkR2x2LzNEcjY2TGpscVZNQUlUN0dWOFJDK0k3ekVhWVd1?=
 =?utf-8?B?TURDU1RTNkU3RGVHUDZVcUF1M2JCTmRLQ1RsakRDQXdwSDJVUzJEU01LS1pp?=
 =?utf-8?B?R3M3UHNiY3FNZzRkeDFkdXRWMnlxU0ZzQ0oyc21uMnpIL2RRNTdSSlF6Vkxv?=
 =?utf-8?B?cmhlNDRpN0xlVXpTZGNqUDhPZ1o1eVp2NXR6aXV0ZDdEdjdKOWl0K0Q5d3hq?=
 =?utf-8?B?MU1IdEdaaWw3a2tydFZ4MHFPZlF4eno3U3pGcVZvcjRIaWQ4Q1JrK0d0UStU?=
 =?utf-8?B?Zlc5SzRKaTErWDV4UHpkb3kzc1plY2k4Q3pMVTZLMlpzM0tlbzRzU2EvL2hk?=
 =?utf-8?B?RjBKUW9wSXBGbVJDRXNGREtpZzRjVGo3U2RUWUUxc3RxTU0rWnFPT0djNm1l?=
 =?utf-8?B?c1BFZzVSdGNrTG5ud1lSdk5kNU5oOTRoNGp5VncwQnJEOGNMUVZXWEFlUTVo?=
 =?utf-8?B?U2lKMXdYMUZVU3lxSDltelplQXNqbmhsZHFFRUZHMTN1TWNJeTBkSGJpcUlm?=
 =?utf-8?B?QzZEckpaNlUyQmdudlVKUWxkc1k0N3VXWTBuVndPdEFTWFRSNTd0SVdsT2Ew?=
 =?utf-8?B?SUtFYURmYjd0dmlPeGVyS1poWVc2OXpDOVlEd1YwaUwraEUwYXdIMndDY3FP?=
 =?utf-8?B?WGZjaTFrUitrQnU5T3pnR05qYnNBYS9lYVhXYThNbHBDcmtJenhScVZscXRF?=
 =?utf-8?B?Y2VvcFpUekpDbXg2NTRRSVZYWGtaVDdZMFRpaXBqak1aYm9zcEh3aVRxUUo3?=
 =?utf-8?B?dURaWmJyRVVCbGR4YWorU1lET3p1R3FhRFBmaFdiMDVDVjA2WVpiY3cxdkh6?=
 =?utf-8?B?Z01qZUtZSnd2UXVUQmFOby9PUWUzY2ZoZlMrWUFJSnpkTkxTM3ZwV2lIb2Jx?=
 =?utf-8?B?NXdxTjcxZktVNDk0NTdvYUp5azdCcHhrcmpnYkxtQmNLK3RUWFkzRDk2dVdW?=
 =?utf-8?B?UWFENW5ucDZrK1hUVlFVZU0xUTlBNkNkdENNVWhEWVpXakRROWNINElkUHVo?=
 =?utf-8?B?bElseW9ncVMrRlpnV1ZKcWx3cHVXcW05OEljaGFvckQwbCsxcUh6cUJQVW5v?=
 =?utf-8?B?dmZ3MU9aRnRqUUNwVUh5T2p1MERBTW1LaEE3NzVERXM0STZndUZQREhiRXFG?=
 =?utf-8?B?aHlLb21LemRjSDlVUXNOdURWMHdsajJWQnZudXJnQ0NiWUVHVGVadFFuazUz?=
 =?utf-8?B?Y0JBQ29SbkpUa3dGUUpieEIrTXgwVUVkakRleW1CN05SR09mOGsvcG9pVmNx?=
 =?utf-8?B?R2VlSTRiRUh4Tkc3U29aVzkxZkY0TTVzQXMzbGthcy95RjdIUDRqckY2QUhE?=
 =?utf-8?B?N1o2cHlKajJNMm9CTVNmT21ObWc0c3FCb2FZSGdheXBTRnpwTEdVODAyQ1lr?=
 =?utf-8?B?VzRDcWhlTjYzcldGRDNHU0Njb0FQQmliaDhXYjgwbVJpVWNjaHdLUEVnT3My?=
 =?utf-8?B?MnFzZmZha245dWloaDFUSElQUkpWcHVXWWVZV2pWcyt3UGZUV0Fudmh4SGQ0?=
 =?utf-8?B?azJlN0FKU3ZhbHRSaDFBaDJjV3QvRzJ1NTZBWjVqU1JhY3V2cTNrc1NUdktn?=
 =?utf-8?B?eXplMHY1N3hiaUwrdi9rK0c0b0Z3aVpSUlBvRTNEWFpCS09nZXVDZkpuaDR4?=
 =?utf-8?B?ZmhtMWJBUExPb2JoVVJ6MnorMksyd1JLUkFCQ0RHVlpYN2JDMk5pbnl2U3BK?=
 =?utf-8?B?OEQzMy9zTVZzYVhMbnQrbUxjTndJUlpEN2pKVWlXeWhJMllhL2F1RElEbkQ5?=
 =?utf-8?B?czR1ZzVXSWRYRHVYTG5mWVZjTFlLTy9xbCtYTG1sQ1QxbXJ4UjJ3M0lqdmRk?=
 =?utf-8?B?OGJRT0ExcnlkY3FibTVLaGhCVGd2Z3NXeHNuVExJWURDWmJqaVhxTFJ3bE1s?=
 =?utf-8?Q?RmmQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a250f3d-ad2b-46db-bdc7-08dc900f7ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 03:25:36.9532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TiFE8l6KUiU8d5dv4w1EHawS24HVTO92bYdBGUynRa+69RFmS6GX832Jj1R/CPRR94eJPJyfxvXjId6NIV49AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQm9yaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9y
aXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxOSwg
MjAyNCA1OjI0IEFNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiBD
YzogcmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb207IExpbW9uY2llbGxvLCBNYXJpbw0KPiA8TWFy
aW8uTGltb25jaWVsbG9AYW1kLmNvbT47IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBIdWFuZywg
UmF5DQo+IDxSYXkuSHVhbmdAYW1kLmNvbT47IFNoZW5veSwgR2F1dGhhbSBSYW5qYWwNCj4gPGdh
dXRoYW0uc2hlbm95QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29t
PjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkgKEphc3Nt
aW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA5LzEx
XSBjcHVmcmVxOiBhbWQtcHN0YXRlOiBpbXBsZW1lbnQNCj4gaGV0ZXJvZ2VuZW91cyBjb3JlIHRv
cG9sb2d5IGZvciBoaWdoZXN0IHBlcmZvcm1hbmNlIGluaXRpYWxpemF0aW9uDQo+DQo+IE9uIE1v
biwgSnVuIDE3LCAyMDI0IGF0IDAyOjU5OjExUE0gKzA4MDAsIFBlcnJ5IFl1YW4gd3JvdGU6DQo+
ID4gSW50cm9kdWNlcyBhbiBvcHRpbWl6YXRpb24gdG8gdGhlIEFNRC1Qc3RhdGUgZHJpdmVyIGJ5
IGltcGxlbWVudGluZyBhDQo+ID4gaGV0ZXJvZ2VuZW91cyBjb3JlIHRvcG9sb2d5IGZvciB0aGUg
aW5pdGlhbGl6YXRpb24gb2YgdGhlIGhpZ2hlc3QNCj4gPiBwZXJmb3JtYW5jZSB2YWx1ZSB3aGls
ZSBkcml2ZXIgbG9hZGluZy4NCj4gPiBUaGUgdHdvIGNvcmUgdHlwZXMgc3VwcG9ydGVkIGFyZSAi
cGVyZm9ybWFuY2UiIGFuZCAiZWZmaWNpZW5jeSIuDQo+ID4gRWFjaCBjb3JlIHR5cGUgaGFzIGRp
ZmZlcmVudCBoaWdoZXN0IHBlcmZvcm1hbmNlIGFuZCBmcmVxdWVuY3kgdmFsdWVzDQo+ID4gY29u
ZmlndXJlZCBieSB0aGUgcGxhdGZvcm0uICBUaGUgYGFtZF9wc3RhdGVgIGRyaXZlciBuZWVkcyB0
byBpZGVudGlmeQ0KPiA+IHRoZSB0eXBlIG9mIGNvcmUgdG8gY29ycmVjdGx5IHNldCBhbiBhcHBy
b3ByaWF0ZSBoaWdoZXN0IHBlcmYgdmFsdWUuDQo+ID4NCj4gPiBYODZfRkVBVFVSRV9IRVRFUk9f
Q09SRV9UT1BPTE9HWSBpcyB1c2VkIHRvIGlkZW50aWZ5IHdoZXRoZXIgdGhlDQo+ID4gcHJvY2Vz
c29yIHN1cHBvcnQgaGV0ZXJvZ2VuZW91cyBjb3JlIHR5cGUgYnkgcmVhZGluZyBDUFVJRCBsZWFm
DQo+ID4gRm5fMHg4MDAwMDAyNl9FQVggYW5kIGJpdCAzMC4gaWYgdGhlIGJpdCBpcyBzZXQgYXMg
b25lLCB0aGVuDQo+ID4gYW1kX3BzdGF0ZSBkcml2ZXIgd2lsbCBjaGVjayBFQlggMzA6MjggYml0
cyB0byBnZXQgdGhlIGNvcmUgdHlwZS4NCj4NCj4gVGhlcmUgd2lsbCBiZSBhIHNwZWNpYWwgLT5j
cHVfdHlwZSBtZW1iZXIgZm9yIHRoYXQgZXZlbnR1YWxseToNCj4NCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8yMDI0MDYxNy1hZGQtY3B1LXR5cGUtdjEtMS0NCj4gYjg4OTk4YzAxZTc2QGxp
bnV4LmludGVsLmNvbQ0KDQogR3JlYXQsIEkgc2F3IHlvdXIgY29tbWVudHMgaW4gdGhhdCBwYXRj
aHNldCwgaG9wZWZ1bGx5IEludGVsIGFuZCBBTUQgY2FuIGhhdmUgYSBjb21tb24gZGVzaWduIGZv
ciB0aGUgY29yZSB0eXBlLg0KIEZlZWwgZnJlZSB0byBsZXQgbWUga25vdyBpZiB5b3Ugd2FudCBt
ZSB0byB0cnkgYW55IHRlc3RpbmcgcGF0Y2hlcy4NCg0KDQo+DQo+IC0tDQo+IFJlZ2FyZHMvR3J1
c3MsDQo+ICAgICBCb3Jpcy4NCj4NCj4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25v
dGVzLWFib3V0LW5ldGlxdWV0dGUNCg==

