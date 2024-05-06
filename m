Return-Path: <linux-pm+bounces-7519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650358BCA1C
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 10:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FD61F227F4
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 08:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B55C1422BF;
	Mon,  6 May 2024 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rugGhrt4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE121422B7;
	Mon,  6 May 2024 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985852; cv=fail; b=VvKpGnF+J88C7w6yrajG0yFfHlwC7gHEdYo6l41G2DuXpm5aWN8LE8mkUM3Yy8Hvf17OGOW5lg2jObXFaz8HwSETyMvfR7W4hTApbLLK9VMiV8pkMGbnpko/UYWBu1wGxpk5lX2OCIHilaY27nJCBrw2fdmrWUS82Yee54kvcdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985852; c=relaxed/simple;
	bh=PcUwwed/rhmTXUS2ew9YnzJ7dOv3C5l14iLA1hflLrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=otoxS6mN0nZwQx9xr8W9hD+FkwhaPJswazmdfvE1MpcEecIu2a17HrFdb1HFAAT26zqALWUKzh5B0Kb+U8/nxHfA3Al3nuD1JzPymx7UIi0uv4ygQlUItgpoh3afN1mfRrb8u8qrAsGW5xL7PgdRM0vhOz/Es6IU+em/XDf6rT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rugGhrt4; arc=fail smtp.client-ip=40.107.95.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsJvqN9RuWqhlnwxS+CE/yhwHh+4w0rfg94O47vBDyoAosXIJOPwwOB7CzwYtjUyjVVe2dhdHOiJcll70inf2NehL77PkHGdN9hBC0sEpBz8ckEno6wV124MpAmSg8AGSgaKgTVmGnjeqP8gPph40Ci7SJQrNQ80eV+4A5c9UhJxMKuIezY74kqaMDp447+mwkyRXPnLfRn/2/3mIAGE/xNNYb19jcRifYt4AjdPnG2LCykUeqeEZ7A1XpEmbU+K6gF9o5dn1KLHfxYKmod+otEHwNQlOmHv35LTz8zAcRZeBF3aATUvOazNC3de5+YAFY0wVThthl/c74aW1m1okg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcUwwed/rhmTXUS2ew9YnzJ7dOv3C5l14iLA1hflLrc=;
 b=fGkoWW6nlD7PeWLmGy6Z3SDhU2fuXvXn8ZPcd9MonMjQGpKLo48S6fdAk8kFsmgfVDXcMgfrK/i8rDXN3Wxk8SE99ykPyXub+ghbmxMbfnzCf8wrDuXwmtYVVUy1WXrvU6KHUYVkeLKQIIDdu5LHZMk3B7C+qIXQ7adkKajnYcPFX2MsqeKXf9vl9pb8FMD3+wufsTKgnlEdt5wLnUDnI9XZwjN9m20SSSFhysiT/72/dUo4pWvE3LHQzHhkgJvbKeWNWtXt2HGChURt7wrz15FNwQPnlIdEWYB9JSrNZKS1ceCyBT3/FJmeRjx0SKg3rZSez6IK/LeNA+7Vg9rcCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcUwwed/rhmTXUS2ew9YnzJ7dOv3C5l14iLA1hflLrc=;
 b=rugGhrt43W4/5GPNGv93yjiGAM9GmMlg7znEZrOa9b2dMJHl3ygC9G/RIgT2o2QrrV2TAmOqHM1LhTTPxB79Hc0OzBkTDX81Fo4kgstk50wWEA8XP8LZaWbZC7Lm7PspCAY1bQKxBodgmjXSEvb7gLhTvAUb3OEBFQBxnQFVEgA=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 08:57:28 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 08:57:28 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>
CC: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Narayan, Ananth" <Ananth.Narayan@amd.com>
Subject: RE: [PATCH] MAINTAINERS: cpufreq: amd-pstate: Add co-maintainers and
 reviewer
Thread-Topic: [PATCH] MAINTAINERS: cpufreq: amd-pstate: Add co-maintainers and
 reviewer
Thread-Index: AQHamikub2V0c5YWTUSLYHrlNKsD67F/R0GAgAFYxQCAAGaVgIAI4x6g
Date: Mon, 6 May 2024 08:57:27 +0000
Message-ID:
 <CYYPR12MB86553C89AB4129FE36A06A3D9C1C2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240429113356.1708284-1-ray.huang@amd.com>
 <efd9226b-84b4-47e9-bbb9-68bd0194a8ef@amd.com>
 <CAJZ5v0hUwKHbpWXfjArujB8FJ9wDc9_Cv5O1Y_DcyWAPHG-v_w@mail.gmail.com>
 <38f22522-3df0-4108-ae09-ad8c1a13b274@amd.com>
In-Reply-To: <38f22522-3df0-4108-ae09-ad8c1a13b274@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=01aefe39-49d3-4ed0-b57a-8ff011d59328;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-06T08:25:59Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM3PR12MB9326:EE_
x-ms-office365-filtering-correlation-id: d065545b-6f59-454a-e04b-08dc6daa8e53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEpBZGJYYXdqNUtBaWxQdkZWUlozbXNiYjYwUndON1BnbzR5UFhtL3FadmNp?=
 =?utf-8?B?YlVWemRVRmlyTEdzdkNqU0Z1Y2wvdFZCeDNzbzdrTWpSMlNjWHpFZzlGOXNN?=
 =?utf-8?B?WTFBWmpMWktXdmhyRnBoTkdHWXhUVmtLcFFSREUwaU9uS0dQd1NqM0RUOGU3?=
 =?utf-8?B?WFFFK3lXZmJYSnNWd2x5R1lQMTBOLzFGMlpvL2hrZzBJNC9hYTJpei9CWGYx?=
 =?utf-8?B?T2hzWmpod3BpalAwVmFzcmhaTFdQL2hSRS9xbmFKVXp6YlYyM2pENGgwUVNR?=
 =?utf-8?B?anRRdnNEVGNaQ2F4VTZyaFJLVkJtdktJTEZZd2NPZlRYY1hybnl5MDBWRm0z?=
 =?utf-8?B?QjBmcTh6Vmh3Vy9yN1ZMZFdYSVRtcE5IOXFmWXlnNVlvRlhKaEFQZ2hqTkY4?=
 =?utf-8?B?eURwVEdQZSt4K21rRFBkT2pCL0x1Q3lKdllxYVhKMU9JZGZvMFY2MDBzMDM1?=
 =?utf-8?B?dkhPLzFTZDVhWEt0SWUrb0UyK3hvMHJ4VGN4ZjV1YTlkeUdxR1dRdllvQXFS?=
 =?utf-8?B?MTgrVFN1eXhEd21HYXdTbmVob3o4aFFOeEdEZXNhb3RsTWtlelpmbEhacXZG?=
 =?utf-8?B?bG1oazVwaXV5Y2JsTFlYcmt1SEh5QTJGdVJ2NDBpL2NBMmQvWm8xbEdrbWp4?=
 =?utf-8?B?SForYmczc1dFQzhMRmxLRHRab2N0a1QvQ2N4WW5lcng0TkhUb3VmaURza0tY?=
 =?utf-8?B?WkxWQ1ZBc2JaVlpKV0RJUHMwQWEyazVwWU5NSitiV0ZLZWRHNEd4YisvWW5w?=
 =?utf-8?B?MUNOOUF5VjgrQkNqak1KRHM4bnZNd1lqWFg2R2Q0S2kreGNlK3FuOVNGZGFp?=
 =?utf-8?B?eXlrNW1mSzljamc4QmhEWXErcWpDOWFoS2VYMTJ0bGZ5L1AyV3JjanV0Tktu?=
 =?utf-8?B?UWMxY3Rvd016R3BKWGVWWWRVWjNZSnJrUkdMUkRWc2J6cHY0TUl1UEFOTE55?=
 =?utf-8?B?Y3NNTFRWM3ArRHl6ei9PNUpobW9KSVhGaXlFVWJtdHBlbWtKdkd6SHBYcmVJ?=
 =?utf-8?B?TzhXMHJYTFlOa1ZmQUs1bEZMaE4zdy9jWmhHYU5UMTRYRXllaVJSSGQ4Vlc1?=
 =?utf-8?B?L0RiMlQ5c1hNUzZMZVlPVmdlTXJOb0djcmNFWVp6Z0cvQmdpNUlUZWZqbGM4?=
 =?utf-8?B?ZmJLTnVtUlR5N2pmQ3RQeGpLalllTGRWNTAwbFNPRkcveVZONmdNL3R5cnlY?=
 =?utf-8?B?QVpxczFOODZIY2NiV0gzTlZudGN2WnJMcGVuSU1wNFZ2OFlmSGhEaVZrM1V4?=
 =?utf-8?B?ODVmTmJrZFArclAxc1dXQ0Y0QmY1YUpvRFRPZVcreEp2UFhyRGFzSmUzREg4?=
 =?utf-8?B?SEx2cmU4enJ2ZE1Vd0N4dE5uR3JRdlJYc0wyRjMyR0ZCWkpXeE1LVXZpRnV1?=
 =?utf-8?B?NFpoZHdsejZUeDU1b2w0YkxaanAyNWQ4Q0dza1Y4SUxQdy9vQ1ZrQXpyaERH?=
 =?utf-8?B?NEdSVW15TzU4MWlJWTJaOExqcWNDUHduVmJoZTlkanRHTlpXUUJCMnhQSFBu?=
 =?utf-8?B?cGZXemw2UDNXWFAwK1ZZdVl4UWcwTTc5Rlo3QVp5Ym81aFkwVHdINkpmamhW?=
 =?utf-8?B?aUVNS0hrVmYzRHFxNU1YSmpGc1lYcnM0bG8xM2xBaXE0UnUwaWZHTXdUdEJL?=
 =?utf-8?B?SWJUNXc4aUNGd3Bvam95dW4yZ2tWbm9DMTVYc29vTGdreFoyNFJLd3g0ZUx4?=
 =?utf-8?B?MDFnQ3pzZytxZjZKSVYvem11L3QyNU00VytUaklGaW5KYXJQUkRiNUw0eFZL?=
 =?utf-8?B?d2ZFbjRFSExSSk51ak1WSzJ6WUhib2Q1dUR5cllqYzhlY0xQUjAzL2FLSGI5?=
 =?utf-8?B?aWFOWVNDUUVDUmFEejFLZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFNKbGNhT0FoelI2ZGZWNDhoWFlyTjdaMS94eWhEaGFacEp0OTZyZGJhUmtR?=
 =?utf-8?B?VWNTcndIdkdDSGs3elAxZ0VDK3Q1N09XM3NkUExzNWpGdU5EOEMzeGs2cGhM?=
 =?utf-8?B?NkFFVlRITnh2L01aaFdmdkd2ckJha05iV3Y2MmFuMzdTSTBCeVAyeVQ2OTFq?=
 =?utf-8?B?Y2owbUZmTGtGSEtHa0NOZVNIT1l3NDEwUGhxRW9NSU16UlRZU1NaUVJFK050?=
 =?utf-8?B?ZDV5a0hidVFGRzBWWVRnSExIYkMrdGg4Y3crMUtDNmhBMTk0ekFrODY1QW9o?=
 =?utf-8?B?Q0lVK2cwaC9VREtrY3VzMUVOdG8xTWYvWXU3bWs5MGV6YUJURjF6Sk45Unhq?=
 =?utf-8?B?cXZQL29Xd0JOeXYzV21kVEtzbkR0RG1zeUptSDhWRzgwZFl4UDAyemVKaCt3?=
 =?utf-8?B?VDB6QU5PWExScUFsMjlSLzZYajRwaUFIS1dKRnh3RjZjejAwRnFNRFRkVGVU?=
 =?utf-8?B?NXJsNndTdE1mUVcrUWdrSGxrOEdVSTFjUGduOG42NXZXa3RoOEhSUDFkaEJR?=
 =?utf-8?B?ajB4OWVjUGpmYUdqNHZ3Y3hMZEhBOU1FR1pHcjlkeU5ucXlSVlZBYk02N0l1?=
 =?utf-8?B?cWZGdFprb3hrSnp2ZEVaQ3NFazdjV2hyd3hMd0Y0c0VwempBNXRaUTFIekNm?=
 =?utf-8?B?WU1lRlVGQnFxTHJkemVwWEVyZzd6anJ3cWFad2p0SXVZazFscWhzYWN3QThn?=
 =?utf-8?B?UzlYOHJkbkZtSitSc0pYd3dROXVSOFRHZUtzNFEzTTV5dlZYSFRUTERYVklT?=
 =?utf-8?B?SDFKb2R3VFdCTnlYem91Z2l4aDJoNmlXWXNlMUwzWEk5NVhWUS9pSjI4b3NG?=
 =?utf-8?B?U0xuNll0aUVac3FJM2dOaXR3YjlTSTlrYWJTbzREem92MFlMUmNac0xkajlt?=
 =?utf-8?B?d25PV0VZenVWYWEvdEtmdUtGaElNenRsMHM2alRnNUttdzQrbXBBOVRTVjlL?=
 =?utf-8?B?OGJuSUxsMklsS0YvOFF4UUEyL1V1VFRKWTBHNXAzdGwzV1R6bU5PcnJsSGFT?=
 =?utf-8?B?aU1uclc2QndLYVlKWlhFaGhML0VEdlZTOURvMGFrRERYOGROeUZlbEVUemk0?=
 =?utf-8?B?TGNYY2tjT04xdEd1LzREY3RRcXIxSFNvRUVtZEhJeDlMaVc4WGxSKzdlU3Mw?=
 =?utf-8?B?RFowMmcwc1pXVitlRXVqa3ZqUVY5aFF3TGJlRlRJaFNZQkJ1RDE5SnZhelFW?=
 =?utf-8?B?WlFrYmpnNTN6YkFJMkZ5UnNwaUY3aXlwdkp3Lys2N2FscUc5eDFCcC8yV3Z3?=
 =?utf-8?B?NHdyNVhXU3FoaitkVDl6VEFRTEwrR2hYUFNUNVdhNURmRmRJcGdNbCsvQU5x?=
 =?utf-8?B?d211V0ovVzkxYzdJTG9MaUJNQXlXczdDVkRQTnF0K2huNzVlRldMOFg0OFJm?=
 =?utf-8?B?bVVUcTAzV2o3N2ZLMzFhQ2xxMGZ6UW1TWHJveHNSRUVOOHR1V0lMODlQb3dJ?=
 =?utf-8?B?R0dzbFp4Q0RsLzJrSnNKd0dYeGlTMlo2Qi9wWVVwcWhlS3JNVGZXRXpBd2Vp?=
 =?utf-8?B?U3U1VU1jSldyZlgrR2xKc0h6SW81U3BJcjN3TjhySnV5ajgvZ01zYThxOFRt?=
 =?utf-8?B?T2dSd0FCamtlYTdQMm1ROEgyanZhSEdmU2FYT2JQYmN1NmtLb0tNYXhqWlh1?=
 =?utf-8?B?UVQrT3pWdkdRMmgzSDYzWlhDQWMyRmJ2VlJPZXpieHZyNUFmVVpldXRCNWZJ?=
 =?utf-8?B?S2tmdGhpV1RJbGdEUnlvZVdvajN5aWVKaFFFbjB3MXlvNHVYYUlmQ25zOWxK?=
 =?utf-8?B?MnlEN2ppRkVlckVxdVVQWmpOeFB0UU5xUEEwWTJLdWJWYlVuYXpoWHhZbzVx?=
 =?utf-8?B?MU8ra1crNXc4UkZqZzZPSHZadEhWYjdxRHkzN1l4ejR2L202bWM0YmZFT08y?=
 =?utf-8?B?ZVpkakp0eGg0b3IvZkM1MjBtOHdINXF3RHFBSWliNzdkd3dTK3ZXd3BMa2FN?=
 =?utf-8?B?YW5VdnQ5Rld1OEtlUE1rOEFDSGVHTXVCaThXK0pwOXU4bTJiaUNVcllSK3dU?=
 =?utf-8?B?RlhYcFpxN1hFSU94YTNUUnNid0xaZHZZamdKbnlMQWx5bFB2djBpV2lPdzhY?=
 =?utf-8?B?QzlJS1MvMnNMU0FWZmhXL1N4MytLQzVLb0NYTEZtdUtUL2tMOEZlOXYzL1RG?=
 =?utf-8?Q?MeNw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d065545b-6f59-454a-e04b-08dc6daa8e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 08:57:27.9422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CteABWlSAy3tlE/XN0Xq8pNWObOpFS2pqNdgF5XiFgmLvHHQXY00vOfZDXc/ygCpqu5j2Ren/6QFJMUwyBZDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCiBIaSBSYWZhZWwNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlv
LkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDEsIDIwMjQgMTI6
NDMgQU0NCj4gVG86IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IEh1YW5n
LCBSYXkNCj4gPFJheS5IdWFuZ0BhbWQuY29tPjsgU2hlbm95LCBHYXV0aGFtIFJhbmphbA0KPiA8
Z2F1dGhhbS5zaGVub3lAYW1kLmNvbT4NCj4gQ2M6IFJhZmFlbCBKIC4gV3lzb2NraSA8cmFmYWVs
Lmoud3lzb2NraUBpbnRlbC5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1lbmcsIExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1k
LmNvbT47IER1LA0KPiBYaWFvamlhbiA8WGlhb2ppYW4uRHVAYW1kLmNvbT47IFl1YW4sIFBlcnJ5
IDxQZXJyeS5ZdWFuQGFtZC5jb20+Ow0KPiBOYXJheWFuLCBBbmFudGggPEFuYW50aC5OYXJheWFu
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIE1BSU5UQUlORVJTOiBjcHVmcmVxOiBh
bWQtcHN0YXRlOiBBZGQgY28tbWFpbnRhaW5lcnMNCj4gYW5kIHJldmlld2VyDQo+DQo+IE9uIDQv
MzAvMjAyNCAwNTozNSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gT24gTW9uLCBBcHIg
MjksIDIwMjQgYXQgNDowMuKAr1BNIE1hcmlvIExpbW9uY2llbGxvDQo+ID4gPG1hcmlvLmxpbW9u
Y2llbGxvQGFtZC5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+PiBPbiA0LzI5LzIwMjQgMDY6MzMsIEh1
YW5nIFJ1aSB3cm90ZToNCj4gPj4+IEknbSBoYXBweSB0byBhZGQgR2F1dGhhbSBhbmQgTWFyaW8g
YXMgdGhlIGNvLW1haW50YWluZXJzLCBQZXJyeSBhcw0KPiA+Pj4gdGhlIHJldmlld2VyIGZvciBh
bWQtcHN0YXRlIGRyaXZlci4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkg
PHJheS5odWFuZ0BhbWQuY29tPg0KPiA+Pj4gQ2M6IEdhdXRoYW0gUi4gU2hlbm95IDxnYXV0aGFt
LnNoZW5veUBhbWQuY29tPg0KPiA+Pj4gQ2M6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1v
bmNpZWxsb0BhbWQuY29tPg0KPiA+Pj4gQ2M6IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNv
bT4NCj4gPj4+IENjOiBBbmFudGggTmFyYXlhbiA8YW5hbnRoLm5hcmF5YW5AYW1kLmNvbT4NCj4g
Pj4+IC0tLQ0KPiA+Pg0KPiA+PiBUaGFua3MgUmF5ISAgV2Ugb2YgY291cnNlIHRhbGtlZCBhYm91
dCB0aGlzIG9mZmxpbmUgYW5kIEknbSBoYXBweSB0bw0KPiA+PiBzdGVwIGluLiAgSGF2aW5nIGNv
dmVyYWdlIG9mIHR3byBwZW9wbGUgaXMgYWxzbyBnb29kIGZvciBhbnkgT09PDQo+ID4+IHNpdHVh
dGlvbiBpbiB0aGUgZnV0dXJlIHRvIG1ha2Ugc3VyZSBwYXRjaGVzIGNhbiBiZSByZXZpZXdlZCBp
biBhDQo+ID4+IHRpbWVseSBmYXNoaW9uLg0KPiA+Pg0KPiA+PiBBY2tlZC1ieTogTWFyaW8gTGlt
b25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4+DQo+ID4+Pg0KPiA+Pj4g
SGkgUmFmYWVsLA0KPiA+Pj4NCj4gPj4+IFJlY2VudGx5LCBJIHdhcyBhc3NpZ25lZCBvdGhlciB0
YXNrIG9mIHZpcnRpby1ncHUgc3VwcG9ydCBmb3IgWGVuLA0KPiA+Pj4gc28gYXBvbG9neSBub3Qg
dG8gcmV2aWV3IHRoZSBwYXRjaGVzIHRpbWVseS4gQWZ0ZXIgZGlzY3Vzc2luZyB3aXRoDQo+ID4+
PiBvdXIgQU1EIGNvbGxlYWd1ZXMsIHdlIHdhbnQgdG8gYWRkIEdhdXRoYW0gYW5kIE1hcmlvIGFz
DQo+ID4+PiBjby1tYWludGFpbmVycyBvZiB0aGlzIGRyaXZlciBmcm9tIHNlcnZlciBhbmQgY2xp
ZW50IHNpZGUuIElmIG9uZSBvZg0KPiA+Pj4gdGhlIG1haW50YWluZXJzIGFjayB0aGUgYW1kLXBz
dGF0ZSBwYXRjaCwgdGhlbiB0aGlzIHBhdGNoIGlzIGdvb2QgdG8NCj4gPj4+IGJlIGFjY2VwdGVk
IGZyb20gQU1EIHBlcnNwZWN0aXZlLiBBbmQgYWxzbyBhZGQgUGVycnkgYXMgcmV2aWV3ZXIsIGhl
DQo+ID4+PiBpcyBhY3RpdmVseSBjb250cmlidXRpbmcgdGhlIHBhdGNoZXMgb24gdGhpcyBkcml2
ZXIgZm9yIGEgbG9uZyB0aW1lLg0KPiA+Pj4NCj4gPj4+IFdlIHdpbGwgdHJ5IHRvIGtlZXAgdGhl
IHBhdGNoZXMgcmV2aWV3ZWQgb24gdGltZSBpbiBmdXR1cmUuDQo+ID4NCj4gPiBUaGFuayB5b3Ug
YWxsLCBwYXRjaCBhcHBsaWVkIGZvciA2LjEwLg0KPiA+DQo+ID4gQlRXLCBwYXRjaCBzZXJpZXMg
IkFNRCBQc3RhdGUgRHJpdmVyIENvcmUgUGVyZm9ybWFuY2UgQm9vc3QiIGRvZXNuJ3QNCj4gPiBz
ZWVtIHRvIGJlIHJlYWR5IGFuZCBnaXZlbiB0aGF0IC1yYzcgaXMgZHVlIHRoaXMgd2VlaywgSSdk
IHJhdGhlcg0KPiA+IHBvc3Rwb25lIHVudGlsIHRoZSA2LjExIGN5Y2xlLg0KPg0KPiBZZXM7IEkg
YWdyZWUgd2l0aCB0aGlzIGFwcHJvYWNoIHRvby4NCg0KWWVhaCwgNi4xMSBpcyBmaW5lIHRvIG1l
LCAgIHRoZSBDUEIgcGF0Y2ggc2V0IHN0aWxsICB0aGVyZSBhcmUgYSBmZXcgcXVlc3Rpb25zIHRv
IGJlIGFkZHJlc3NlZCwgSSBuZWVkIG1vcmUgdGltZSB0byBmaW5hbGl6ZSB0aGUgc29sdXRpb24u
DQpUaGFuayB5b3UsIFJhZmFlbC4NCg0KUGVycnkuDQo=

