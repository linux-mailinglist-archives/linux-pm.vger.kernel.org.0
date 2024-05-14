Return-Path: <linux-pm+bounces-7792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 816808C4BCE
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 06:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20BA5B23216
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 04:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA0C11CA1;
	Tue, 14 May 2024 04:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r8mepDf/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0D21A06;
	Tue, 14 May 2024 04:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715662286; cv=fail; b=pvoevyOFnSxEYcuqj5TQ4ajj4GQr3BFhfNNWpOzFmNLtWIXnSpuExSw5iUpHtK5Vybjny++Iptg5hf71f0AnX3Tqg2frkaPGRGCT2XnHbMjsZEOSEZQNWLCyH5XszUHxu8gi8HSF37r9duqP184Ta2oL5xOPT67EnSJDmDbQLr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715662286; c=relaxed/simple;
	bh=cNqCMquICXFhjfiJqUSLd+6IeqRvcup5PmbQX2YuKQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sfkqLqSiOS+Oq+FRyFFkXLvhZeNtBAVOYhNKZtiWKllkX2+mynMWES22O8D+C1glRU+FRua3qC2Fzff+vmNHHI6EyaNXuZ0fhWCmPDY6c5V3/pZFuBJQD29Xlo39IBHWpDVhKXPFnxcTkf3WUcyaKvtUh3wHL4nV6PUasB7RFiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r8mepDf/; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ad0sqldqFj954lwLYl6up1cCf5zXergjrpEmJSqlovnKhy5D0s/jrE8svmmhtfRWeILJqYitmmnOIaOdj6NVygZqLXke/5l8JelVFYdus3eYdhzV92u/871p6Ec+15vpFZeXoWh9endIqVH2WneMg4ALF4gH5GealaPepSzQuA0UzaXv7wM0l7DI4kKCIwsYokHM4/5G2aUnvj9/QR9uREHTbttU2p98PvGPuxoVEy1+lqbegxWz/vmgMfPPWm/6yTSrFEznKe7eg/v464w64NKd2z5QEIZQur/vSi5INIj7oTQYZgX0tWRb2ezyUTSDAxmhnFbX3msGTowzr+P9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpoaguosjx/I6AiqYUo+Ne18Krsl9rldqKKZzp+l6QI=;
 b=nsKrHpfsNriXUzwKivEtMKXY0+ydX7tsbkiKE68Iw/VDDtlmz8EHAtnaEMOy9hLP55n8aQzIpBbcyri8BvhPT1Cf+ZIv/YigVig47D2HoeQltuFW0IJxh2rL3I7tRHrFMblOnAQPWexRJdvOyDebWLW66U6iISTzwuhajlXVjw59/3eg3EaKGzHhKmMH4l+gqIwx5vypX7T49Bef2zj13lDTMnDYwGNc0AJq4o7BYOQ54o6UN6HXsD3saKAZx1Zv8pDxCecZlDfo3HM60Q2FGLx3aod7NhEhBOaQ1B9l3MhYl52M7pIiaRa/3ZL0TNvw1LcJU9F6apTulm/Ek3yCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpoaguosjx/I6AiqYUo+Ne18Krsl9rldqKKZzp+l6QI=;
 b=r8mepDf/jALXzKH29cb71umtccoFGB1Ak47Yz69SUYF0cMSopGeltrOJ/lDJI0djyxr37RJYLrImdV7IR/3mdKCAvkp/WuBQfMvbp0N9SXK18xXCIsVtIzTsPeo48WBwmznCsr7XppNOW7zUq9vEIfPpvFN0DhPxJIdOlQogQbw=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 04:51:22 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 04:51:22 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "zhida312@outlook.com" <zhida312@outlook.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
CC: Peng Ma <andypma@tencent.com>, "Huang, Ray" <Ray.Huang@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: amd-pstate: fix the memory to free after epp
 exist
Thread-Topic: [PATCH] cpufreq: amd-pstate: fix the memory to free after epp
 exist
Thread-Index: AQHapa1Z4XqJT3sZK0GM9Z2m2rVaLrGWJ85w
Date: Tue, 14 May 2024 04:51:22 +0000
Message-ID:
 <CYYPR12MB8655C82734A252F7983A9EF49CE32@CYYPR12MB8655.namprd12.prod.outlook.com>
References:
 <PUZPR01MB51206E9B32294882EC34B09592E32@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
In-Reply-To:
 <PUZPR01MB51206E9B32294882EC34B09592E32@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d5bd71e9-67cc-457b-8e8d-d162339b58b6;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T04:45:44Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|BY5PR12MB4081:EE_
x-ms-office365-filtering-correlation-id: a3c4a4dd-b02f-4073-1aa6-08dc73d18098
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+JcrV86P00/C0dtNoIiQIW9CO/69OQwREpf8AFguKkLg4mTvTDLXIkLIahOT?=
 =?us-ascii?Q?z/F+LF3nfvQSRpEV2iHZXy3NkUOoTA/sUYmAv9/GLHNp0fwWZqI+uG6PhhWa?=
 =?us-ascii?Q?fEEGSnlm/H6OU26gRbi4Hiy9YDOSSxdba3+Eff+x8jMuGW1ttk2zsTZkTiho?=
 =?us-ascii?Q?E0EAw9wl300E920EEkexRIJPq4r8hF5xmb4iXbE5+lqMA/iNfqWdTtlkpdX9?=
 =?us-ascii?Q?YZECxNPzDdkz1NZ0Dv/CMXrGfc4oIzRIOhu/5qm7pugtiFTVNiSz9UjPHdPl?=
 =?us-ascii?Q?ffao/PymETnm6idJjxoIdIMgqq/bPIg7hrf0TpFdLsxwHVt98ZKN6eLbA3uN?=
 =?us-ascii?Q?9qY6NyqOlfDMr643sKrTY87tWJDPvLR2kdZ/e77bEbKm3Ar9GrVYfF3bbS0L?=
 =?us-ascii?Q?DIYo47XVWTTORHnd8JPqD54kYsFDYRRzDazI0OJ85bnTSArtWXACpK3VgR8X?=
 =?us-ascii?Q?ds8Nm15CGSJpnmidqHY1kGjJQ+E+4N+TrNbX48xxl0E1KQscYHmG9Vfxlgnw?=
 =?us-ascii?Q?HdiqZQNU86AqxuJyHZ4dA8hdmkdDoQxiXOQmlcyxljRl6Pmn6dGJNwawrC2y?=
 =?us-ascii?Q?sRu+CFCL3bZ3SAhVc7J/juajFPbsf4VawXUzaRjn7FjPrmTQ1Xl/vkY2X2FF?=
 =?us-ascii?Q?3QU9KJqLPK4Qdmful/L7GWi2vZYtPLLDsEYilcM0/oNgUEd3hOUp7XkCRgCW?=
 =?us-ascii?Q?GyHBRR9DuSdcMctxA/kz5TUL0gfVfipoM2SBrUtzudiSOxr4BrTJWC5xUmBo?=
 =?us-ascii?Q?T+2N+EX2QUwPRSmrwHZGJT6J7gJDVgP7ilFdywnN5x2Wgp2pvFAQ4pJjac8m?=
 =?us-ascii?Q?tvrh92lbInGsoSKwy9ogA9FZLgm9AWnIJjuenPq20WIpAWT70pXLD+UASEP3?=
 =?us-ascii?Q?U/XTsfwimY4k3hzA/AXkb27MLOwUittFaLU3PS5yaejHdfjGo3Hw5GmmedHx?=
 =?us-ascii?Q?2Sv1L7PX/Zngk/9dCHvWRM/Bv86+XJuSUiye9Tg+Q7wYiWus8xPnKVf1m3Mx?=
 =?us-ascii?Q?ujjn96VGFNVBKtj7uRjD8L3TcyGxIOyojpYszI7Fj2r7Z3Sval39Yj9p/3SR?=
 =?us-ascii?Q?eUbDeaDw92fBi7qwQHM5OGnB8WO0O3Q1TDZeNtRnWtLTLF3Q6iH9vIS5shTe?=
 =?us-ascii?Q?UPcFZiJ/XZTrvppT3M6oP7aTBEBjpgnoaqnIkHlvmND9wJSKFyEMUoZwLatS?=
 =?us-ascii?Q?QqDn2yUpbQqp5TFaWL81j6KyFS64DiMxlgDepaya3kYfgJzu1pYrw9RklN5f?=
 =?us-ascii?Q?yD7TcCsvCa0/LkdF22C/K2cepiVXXMx3KKCDFazmu2J9caToBVZimlDj5w+G?=
 =?us-ascii?Q?zG0CvXEC6jR0SLEFB18aeO9RC4ThStfM8QYAGie1YKokOQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7fm+4xGuBXiTWqJjJPGm1pDQtuGRsaBsTLOkC2NzOcL16xEakucPydy/R8BN?=
 =?us-ascii?Q?A8DGL4SPe8Bg4TkRSCfBAqRK2P87ejJI6SAcREEnn9ZlMKNepkhJTFLPLxTq?=
 =?us-ascii?Q?K5AhVFX/88wUP67vmJIcqJXaRDehpnq7VvzvTTrQF2nFitgElcW8HIM3QMfp?=
 =?us-ascii?Q?Kxds2/ZiXLTuD7tFtH1B/F1EEAY4gc05MIAciCRLJrPnrmZgg8D9zFJ3jNh6?=
 =?us-ascii?Q?PArVAeJSE4AMuD3oWCn17Kh4OQ0vjNasfjTFKKUIL+uiv5rGjB9mfE+xt49/?=
 =?us-ascii?Q?EVgrbMzbRvmYPeP3GSbaae2ELRNKlTFopjsEmZSbLidxD+dfX9rQRF4/usv/?=
 =?us-ascii?Q?Uj0wU1NJMJADc81u43czt+3UdCsF9nL0AT9Zl6KDgL1kaCBR932aT5XKyqle?=
 =?us-ascii?Q?Pd8YZQZETkFsOj4Cf9HBXfjhdgxcgqdoVAVmVN9Ocx7a5LGWF2t5iw+fF7Tu?=
 =?us-ascii?Q?iyCYUX1swIQnz1IdHPH9D6cv7xDYxfSG+DfhVR/zxIEvD3kNF1l8JARZTRgN?=
 =?us-ascii?Q?US55h7FDlPoyoHHTERAzsn89zQNN5233VLCHXzRgGdSbvSlcY0Jm7EiHD8cv?=
 =?us-ascii?Q?+ZLMAemIrmA/3pnrt2VwmL6w49nO95GTEKNRfLCzkVQTUhh3HMs4XejLQOb1?=
 =?us-ascii?Q?KiLEbUXftIIjcOfJU4mPNBE0IUkz4C3ktxUz8saHWWAed6pluKPEbEwSFY5u?=
 =?us-ascii?Q?zhZl2fxocgHdQ15MNApm5q35hkQ6ahcmmZt3qRPAMRHjMo/urLKnzoNggqdt?=
 =?us-ascii?Q?a7n607P3gOIF+2tEHJFjXpFvxS5kGcwk/Vw1YXqdlpKU909xd2CU4M6QbVov?=
 =?us-ascii?Q?nZqEjPmj6NtohOBmxACe/wO9UF+6Ejah41exzZgdMgLlD4YK4QSvWXRwYFzz?=
 =?us-ascii?Q?5aiOHMElnh15TbZshJ4KXqOe6QSPdAnD8hJe5sY/btvObNnBCQ9SrNZ5G3gW?=
 =?us-ascii?Q?T4LBGI10B7BY+bwgXBfdIjRDBCvzuwS7i4Tf+OqSFsUCWf3eONw/lJn3gmMM?=
 =?us-ascii?Q?17im1r8csyOcAuTHWwp7eQN+5XnoY9ppf6F2DhG+iiWT1hjAsvawy/zyMqqq?=
 =?us-ascii?Q?x+UoHfiAQ+f2sf9dddcbD8jNLGDqum7YkQyBGpDec39k5PeVdhgQTLmbrQ5b?=
 =?us-ascii?Q?+cfXC+v1I75cbaw1yga15qoeaOSYL2QNg2SfxXX6BTWjukLDUa6tWN43nrFA?=
 =?us-ascii?Q?IUaLbRdHLld2r2j80eLqnN5Yq2yFv6aJtCwfaWBks+8iXpPEqfh57wTNvZkZ?=
 =?us-ascii?Q?LnXJYB3rVbBhKPjnghrpMl3EhR+spPl/VB0Wucb05NMXg1tjEAth8LyRMbca?=
 =?us-ascii?Q?ENRyB1/BfOA4PJGfolwCuo6BCCFmrEaK0SHnsx7EQaiAwDJYDtby/89OH98n?=
 =?us-ascii?Q?3Fhhyeq5PNvWw+th/qwAXRt6NQXTcbBr4BqOZ9HxfgwzUoeoXsF45YxO6cML?=
 =?us-ascii?Q?j9QRPV79ADLou2MPgIPjPyIsaqa2bs5BolRy3qxJCwqmJM3rafynkpyG7pl6?=
 =?us-ascii?Q?OGoyR2+5cde0olMgGqtFn1wGjhqKX31BWiVgl733Apu2pl3IxboV1VkuNUBK?=
 =?us-ascii?Q?UMQvIF7rgOQrEuVDRlM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c4a4dd-b02f-4073-1aa6-08dc73d18098
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 04:51:22.2213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CwyZk7gg96x0Y7hIDq8BCQl9vm70akN3zCKiR3+v1MHsk2AB6G5s/3bPj/anPir2DFS7pffO1ppXeXk80xKPcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081

[AMD Official Use Only - AMD Internal Distribution Only]

 Hi Peng,

> -----Original Message-----
> From: zhida312@outlook.com <zhida312@outlook.com>
> Sent: Tuesday, May 14, 2024 11:17 AM
> To: rafael@kernel.org; viresh.kumar@linaro.org
> Cc: Peng Ma <andypma@tencent.com>; Huang, Ray <Ray.Huang@amd.com>;
> Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] cpufreq: amd-pstate: fix the memory to free after epp ex=
ist
>
> From: andypma <andypma.tencent.com>
>
> the cpudata memory from kzmalloc in epp init function is not free after e=
pp exist,
> so we should free it.
>
> Signed-off-by: Peng Ma <andypma@tencent.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c =
index
> 2db095867d03..96a323f59a93 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1425,6 +1425,9 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
>
>  static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)  {
> +     struct amd_cpudata *cpudata =3D policy->driver_data;
> +
> +     kfree(cpudata);
>       pr_debug("CPU %d exiting\n", policy->cpu);
>       return 0;
>  }
> --
> 2.33.0

Thanks for the patch, how about change to be like below?

    if (cpudata) {
        kfree(cpudata);
        policy->driver_data =3D NULL;
    }

Perry.


