Return-Path: <linux-pm+bounces-11244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CB993740F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 08:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B990F1C20A5D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 06:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFD142047;
	Fri, 19 Jul 2024 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H5trdwzc"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F958383A5;
	Fri, 19 Jul 2024 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721371116; cv=fail; b=Np0B3KA35K9Q9N5jgKk+QrLmG8FvCTzVaSdDzaqE50DBNsB4DmTj83Qp+ZnMN7GX4GNeBDkFNFwqtJW4GHdvoivYHeNEPNsFzN0xuqW6CUzeQgRUYunDDkMikB+hB6Jw6gJuut00xCAU3mPVTrBK0GpALd6CDtUNPsf4qs7WY8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721371116; c=relaxed/simple;
	bh=+TyZcD8yLRJhUGPnuMVXCiombwUo6N9FIErpeUSmFZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jfjtqRi/Qt0QAS0JFLMCeup8TkUy0uvY0e3YgqHcRVFrTztAX2nsUXFvFDYwGPs5j2Zr98Xx9PvYTRI94i/Bmp1a/5pPE86o60eQqjQW5Lq4nF7elT5t9W5T72aeil4q+mrwt75StIk987IuC3G5lDsLvvLpBxhl82/KUlCA0rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H5trdwzc; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdnKOthcTMKtRf7Z9+Niwio4HbBOITjJDhr6gKlZtg7AH0S6uZbyZuMQN6gSaFiRMntrYz00HGTZxoBUJ2u/XUaRtIUS2ULSlCDCgH9DfVK2Iu80qo/jMbNgvtDZAoQxjAtH8+aNOI49ShsvshFlOOVpSd+Fv8BtMzjrCxEoBd6TCy8L5NBXToJ9im6Gw/EGRA39yLCpt0MZkCeN8XqH67vFulAKyrKYQi0kpbOp9BMq5jCRpeiPr0TQbTErupFbc7RNecnTrMUDklqucAB77hRrB9cSRv9xTzGVZRmYJMTVWBThCuznrvmFMIdW6vOw7RVg+mFEcu3iwTjUqaBxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rT6Bkp5H4rxnMjW4pAFgkycP/m37dorYQEgaKfgIwU=;
 b=Dkhun0rvvOIwK/qKpbVPiJAKzH2uoc3o/WD79tIBWMtY4b68+D2Y8tQPgpZAFq+8ercJBEqaubAh8Xm52/q8T2Ytf4K1gd6YggvpMYpi14Tl+2XDzVgF+TKsHzqJApAt9A1V5ovjwDqCQX0j5dyOlHoMI/pj4gcGF4E0+vGS9i3UTLfY2R13T29MoL8QNlhIIOQ94NvJubjB3GOiw2PcufSPxOYZPnjVFfyij+iGs2F2Tby8PPcPEvWls0c6At2gOTBmdXXo4LQMcFEm6/OM+j1nfZHBy1/zNt32mvFNTzcq01EO6GNw5jbexsVUCbz6rjNO8NbfiEGCsHub6WV2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rT6Bkp5H4rxnMjW4pAFgkycP/m37dorYQEgaKfgIwU=;
 b=H5trdwzcIOah3/zMvCaWSC6xb/8Wuvt4Zm7nhvrWRP3y/nPpjWlXiCChUP4ame0X173AsqvU323IrEQPMWumlXJXktOeOQaleBOG5DUoixCitCA6FtMcMcnUc8qSZnU8ZiFNHXP40ny34uQ5UB+M7bfA7xRS5C8F7j1veQ4Z8/I=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 06:38:30 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%5]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 06:38:30 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: amd-pstate: Fix uninitialized variable in
 amd_pstate_cpu_boost_update()
Thread-Topic: [PATCH] cpufreq: amd-pstate: Fix uninitialized variable in
 amd_pstate_cpu_boost_update()
Thread-Index: AQHa2U5KukeeSWwdckWWUCvkFE++B7H9mZUA
Date: Fri, 19 Jul 2024 06:38:30 +0000
Message-ID:
 <CYYPR12MB8655D6D2630692790CCDEBE99CAD2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <7ff53543-6c04-48a0-8d99-7dc010b93b3a@stanley.mountain>
In-Reply-To: <7ff53543-6c04-48a0-8d99-7dc010b93b3a@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f6e8f3d5-b6f8-4d4e-a27a-f4446e409ed0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-19T06:37:16Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DS7PR12MB5743:EE_
x-ms-office365-filtering-correlation-id: fe9e2006-d07a-40d6-62f6-08dca7bd6774
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cWlmiC/229cP9x2P/MvDJUasY0K8quTfLVundGsm4cUge0cv4WmGpNayPwMa?=
 =?us-ascii?Q?jEn4TZ+XK1UXnBXb7ONI4n9wK9oZs2feYQabBejp8wvzD+ksnQpKWto+lPcP?=
 =?us-ascii?Q?tp7VQoGtIplFOJRMvXPKqBJ1sQtER5LrdN2Gkz3jcOLpylwiNiMWHUoPOJao?=
 =?us-ascii?Q?oiMaM+M0VYAG1BUG5zo0xqVBkKNe2TZyTU/T6To53rdNzvK/gf3Mz/aoM7py?=
 =?us-ascii?Q?29xNIdaQ6lMOMpub79RLsay9dey5A5hyxag+Sii+C6cSlZEbsMwuD7SpyMCk?=
 =?us-ascii?Q?KTsVqCi8Zqp1BefpSQ6IolwTyuFMpHrvbeNFJJ3iZheFCx8nB6m+jcVdn38J?=
 =?us-ascii?Q?ntwHvFprOU5daJytWzM8Pg/dEm2do45X2A8eCFzgPr04aHU+qgH9ImCnUvkc?=
 =?us-ascii?Q?H3iudFUz4A70SM5GdJha5GW9Fh2Y0YnKDSrdiI0kthqyhh/tPNFFkhfuE/2Q?=
 =?us-ascii?Q?iLE7LPvNwQ9dZD4a1hkzsvKHnphlVUN8ClT7S5JwPoNMXMOx2rcYWdI1aFhs?=
 =?us-ascii?Q?kyttucBh75q7pxWSF0NzE+VQFR940w0GLQ9BWSe1GIY/QkbVMFwHaFwAP7oJ?=
 =?us-ascii?Q?xlW6DtpIV32J+WBv3TD78fEHKo8DB221pDFL9bHdRwT3TE5HDrEPxOXFuzD0?=
 =?us-ascii?Q?XeqeMIy6IWjMxnyEMJIBXxxtis/HZZtxien+suGgdqQZj+YxZ74KAJ0JoZGY?=
 =?us-ascii?Q?pLoRiaJ+UPsC3bor56o6tbNQqhB+b8yhgXa3cQ67+6KWhh4g7UFn2TrgiJmc?=
 =?us-ascii?Q?99qiRJgioxqX6930p6LCi01otQpXHwFkCHkIayJdgy5pZ0Mac/JNpewLyLw0?=
 =?us-ascii?Q?tn497NgymNtLA23Gf1XB4/Ps68ouH3TkrFPZ6DHvHbO5W/jODYs3H9UWUbAx?=
 =?us-ascii?Q?NaHtVEtsGzjnzW3X64NECu47Qwro50pketnt9EH4YUzpinzB9bbk5hHJOpN+?=
 =?us-ascii?Q?G0Nw5y8p3T+xCxdHBIkRomidH7vYB/n9kmphVIws9wOemYbA92tSToJF6cjN?=
 =?us-ascii?Q?UaYINTBt3bqB4qTMVUcYEWZcmibGH0EZPfCTf4RmvuxUGEt3A5HKm1aEOO56?=
 =?us-ascii?Q?fY7u1+r0VcKYK8biLkbC980OVbMoXvn/RIeNcGSjkkrWRQVD/ATpa03fSRuY?=
 =?us-ascii?Q?F9UvnUZmjloiCgvWRbTObcjtGwtvsEHZf2bCRj+FqoNBBZHJMvwmGpYqV4k1?=
 =?us-ascii?Q?o876nUKvGBFYeHMxaaqQlT8LZFRk2fGxOr1ZYWc7SQGagyd6YRt/SzM06798?=
 =?us-ascii?Q?0VNtr/NhmQoFSJdmqXKcZZnhozgGU3/nz3MAes0F6TOdGpWZBerYikl+6hMw?=
 =?us-ascii?Q?ju9ZyNLp+jrUwSc08l3A15Zqe/Ji7I98NcH/mCKUT3/M0IprtPz7tK+sqc8l?=
 =?us-ascii?Q?iEvxGDBR/wxXNmTXHLEvYFQCKAzbg6p8b6erg5paPGE7TjtwXQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?si/nlGcgp40OiW9CEsK6voK7sAKezJoeKhVBqQ0R1QfpGsDNTldczlPX5Y6K?=
 =?us-ascii?Q?x1JnVNDgcQBWmK1ykvqj49MVc9OnUYbf9obCwqxeVVfH8o369/hECt/ZmYrg?=
 =?us-ascii?Q?9ZwEyroM65vUtbLvE6XPBSbboDYP3tdPkmtscbdJBfwq9gnrMA4wIwlBwxCF?=
 =?us-ascii?Q?M7NU5FkAyJrmKxS7XXnTSfd++bjEwRG5cE/uOJ+Kp3fseaNdusqivS54YNhw?=
 =?us-ascii?Q?0lBBGhdXsJ+ey1jGk6YtGK9hGWvH1Z3D1a9HPHUp/p6Adl+zVUcw8BmRd2x8?=
 =?us-ascii?Q?AnJZ5Nj1WoNw8Oj9HDiaElyS8Z1gHZGah2JDXzd/qXrWYF0e6GM3NnmGPcbJ?=
 =?us-ascii?Q?WhJtcyGlpuhv5aYryP1cTr5yTeYmk0E+jywDGemTTi7uSgLylVmbetVPf1TW?=
 =?us-ascii?Q?F1hoE5Xh1yVY5JX79uayoQH0M30FWdkt4iv68jAzugiQ5YA8IjQpsCAOSgAu?=
 =?us-ascii?Q?9os62+yBSW6FdmbPuu9HBgH3LgiTpshJleajK2+ezlMXpCPF20x/h+fslGYF?=
 =?us-ascii?Q?S4e5QMzy5Ljtd8rSJpW8OViA48HUA7wYE2vWSQL5JQhrqxpNU6OwbY0oe2D6?=
 =?us-ascii?Q?tNaY7QGQSBbiL3rL+BY6KLLaGG4wvvhpmI6JMmUyVdp+KhBKwzC9w9gPQ0BB?=
 =?us-ascii?Q?T1s6ffzI4pOn7fobS8WDp0V0ahuvxCsv8hFnTSoPlMEYAooeIwSNXg8pIJxM?=
 =?us-ascii?Q?gZJuQj5SfDFznYEJyT/rAR5zWtvIT3HGMmBLpJ6Tavh1//vIY3WxYfXOARmH?=
 =?us-ascii?Q?ey7zIZo8boSxtPKEWbsip+0xcfBx2xtXtO8mPb/UGPh71YF1LT1dUI2wgRPd?=
 =?us-ascii?Q?aojdGZCwWCYCwxOl3951yU7m1EezMOMMM149GZSeiFD7SNrG1tbROQQAkzFe?=
 =?us-ascii?Q?LhLstI+e66VLaIpUKh6BO5ZK8ru7fa189qd8ZZoAeD5R+iwPjEm+4TQWsn55?=
 =?us-ascii?Q?O2EsI3chKHuGr1IbwsyCUmDj51731XJkny2i1WDRItEbvrCPB+qKIPrGh0Pz?=
 =?us-ascii?Q?9GCcMFQviSCWjiyCOulkZ2zKYN1iCvvMsRtJaex+UcRGcErGqHQXar5h0ZTz?=
 =?us-ascii?Q?X8d7FHcQGn4udUoYS6W6QeMcGD0tSraBDaid+F6fT2Btjt942wILFCqzIaM1?=
 =?us-ascii?Q?/i1FUMkzuNcZInnjNfjSUH0i1TSkGgtCPBRb3kE3GqTsqnbSYmzHCETdmXKs?=
 =?us-ascii?Q?cCd5+OGLYCZG5bjvVzVUVhC5Ys0zf2kJGYOkA6YZwQJOsKGI5AKXcOyU53Ev?=
 =?us-ascii?Q?7KCLXSdJAdMltMh+M3ttt7a0f4r21he7B7x/1it57DHC3U/PFrOap7rSr4Mi?=
 =?us-ascii?Q?RtCPMWTtQSld5+2YLD0EJApEVHKG5hzjtlLBdWqGzQfLInz6QtI+2eTy5DDv?=
 =?us-ascii?Q?f7I8fzr5pGxsJFWaxyvDRitCHXjWLBvZqN5eTRaGD7F2uWrGgxN8N81OL7Qd?=
 =?us-ascii?Q?4Mxv9BIImHolA3Rl489ABKuBnD3mkHn2MgwSwgJ9TgrRPTzZVaRsWMWXdqs+?=
 =?us-ascii?Q?TiYAG82fHUt1r7bKrAvKCfvf49sldJQoGVMlvlgeXHNxWjgBsZA1CQUO5Ys6?=
 =?us-ascii?Q?dJxKCdes5Otp4phagXc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9e2006-d07a-40d6-62f6-08dca7bd6774
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 06:38:30.5505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QH/5Ah1YfE2TsPxTjacda91pUwKgT7kDAq0WqL9CEXYem81gcS+jpcQXwj79S6TKEyTXvu3qb9jKsavt8m3Fvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Dan,

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Friday, July 19, 2024 4:09 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: Huang, Ray <Ray.Huang@amd.com>; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Rafael
> J. Wysocki <rafael@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-
> janitors@vger.kernel.org
> Subject: [PATCH] cpufreq: amd-pstate: Fix uninitialized variable in
> amd_pstate_cpu_boost_update()
>
> Smatch complains that "ret" could be uninitialized:
>
>   drivers/cpufreq/amd-pstate.c:734 amd_pstate_cpu_boost_update()
>   error: uninitialized symbol 'ret'.
>
> This seems like it probably is a real issue.  Initialize "ret" to zero to=
 be safe.
>
> Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boos=
t
> state")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 68c616b572f2..358bd88cd0c5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -692,7 +692,7 @@ static int amd_pstate_cpu_boost_update(struct
> cpufreq_policy *policy, bool on)
>       struct amd_cpudata *cpudata =3D policy->driver_data;
>       struct cppc_perf_ctrls perf_ctrls;
>       u32 highest_perf, nominal_perf, nominal_freq, max_freq;
> -     int ret;
> +     int ret =3D 0;
>
>       highest_perf =3D READ_ONCE(cpudata->highest_perf);
>       nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> --
> 2.43.0

Thanks for the fix.
LGTM
Reviewed-by: Perry Yuan <perry.yuan@amd.com>

