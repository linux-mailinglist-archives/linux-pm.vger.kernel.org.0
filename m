Return-Path: <linux-pm+bounces-16341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C980F9ADB46
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 07:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5F71C21D06
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 05:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2EE1714B8;
	Thu, 24 Oct 2024 05:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P5D4IFAh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664B170822;
	Thu, 24 Oct 2024 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729746862; cv=fail; b=gj6NxfvlzG6vJIHGiq0C2QCq2MCO2Z42nDAeI7/Rf6RETTM2UCoLEp7M18z9WprjbFSHDQAzKrhzSMzWJYKYxRyQdypUPZkj0OVqpYSiPBlKaMWhS8OTnn4EHuoljBTYrovnqudM9teNydth6wo+fZPheMWnw7u4/4j9R1MSKyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729746862; c=relaxed/simple;
	bh=WatqGUxEbqWNZmFgbhoTYJy1xSyxk3NMeK15bp+vjkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rkz0XaX7+iRoshSG/seg1Llp60GJH4XsI7S2m/GEhvwRxn2ol+2+RqQ/yMdcXalkB+LtWLmg7OcqVx13oW6eVZYo6Y4gGTQgPvuZrpVh0wZnwItkT6AialxzJ2fnK4pTH6UMR4IulceHHhiuuJa8AeH93uND8eXqO9rbRqm4wcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P5D4IFAh; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg6EswuExny9JwiSTLOURKW7kUkw/paYv0gcTReoaad4GKHbiqeV2n9uR5GIPEnL/tmlBzSO+dw22J936efUo8YCx1t3srV5UO27dcoPP78Wy1cKRkNPEQpIxr6hJi0RNDJ39PD80P3zTVyi5ZI/MEfSp5doiroeO1j9o2LRfUalPGlEbquE/pQjmMD4f4bkD0IPEaG6TkmnXdZOO74hbxOLUCXYKKU04r1bGsDfBJPXuZmBbY2xVXrIxithrx2bNOcs17NJDgzjkSckUvI957ib4nrptd5K/GHghuwQcgfo2AYTBKzT9M0+Q4OXRL/5jwtYlJUaNCF8ZaTQXA6FLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MCjTSI60r9zQGkfVwWLEJkvmi8gwlXhwODSHQifrOw=;
 b=VWLD1XIR4XKrfM/CyCGJwSPfUBJfHtAqakF1LmPv8N6HbtTffNCHkaAGyO1GttgvFRVR1MonFRcREYWCL4PMzO8fd4Ghf1LMgGVE0xF7K8w+hDstMvp15OoC1TWZjpXnGP0+AEJWFgfycug+HLSQZaHKlEz7/Y3MESsQNStk5tqxECYk58Q4BNPOzV8lPVMpMUB1nFkEIMbqoVWBef/4qx8ltGtwZadni6KwiP/5NJYi42FvFtLJ6l5i/cwHu+JgiGVlc6EplCzAazW7BPkd3KHtmEZEh+RxIGB1NK3wxpQN+MvNcTisIUeBHSLhLlYyCJIxEu3ARuEaXIsAYA7zkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MCjTSI60r9zQGkfVwWLEJkvmi8gwlXhwODSHQifrOw=;
 b=P5D4IFAh+Xi3FCZxOT69io7+e/1R2GrmSaZP4DoUS0oXjNuWkHE3d2tjS7u0L5JIELnE99dTl9PKoS2Fj2ckcw/SsQFoKKTYeHrOVRAuvtwAFBIk1pBquVnjY87PVM+Gh/5RYkENmqRa7irBUOtU931/HLCZxaiOSjw6jxMsVg0=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by MW4PR12MB7432.namprd12.prod.outlook.com (2603:10b6:303:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Thu, 24 Oct
 2024 05:14:17 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 05:14:17 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Ugwekar, Dhananjay" <Dhananjay.Ugwekar@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Subject: RE: [PATCH 3/4] cpufreq/amd-pstate: Call cppc_set_epp_perf in the
 reenable function
Thread-Topic: [PATCH 3/4] cpufreq/amd-pstate: Call cppc_set_epp_perf in the
 reenable function
Thread-Index: AQHbJTW4MQoOwdEsEkOikT4n+fy18bKVVZ9Q
Date: Thu, 24 Oct 2024 05:14:17 +0000
Message-ID:
 <CYYPR12MB86551DC2488F5A11ADB643109C4E2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
 <20241023102108.5980-4-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241023102108.5980-4-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=078f7bb8-db04-4687-891b-adcae18cf419;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-24T04:48:51Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|MW4PR12MB7432:EE_
x-ms-office365-filtering-correlation-id: e7594b5e-7091-4be1-0249-08dcf3eab571
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?X02P6wq6pybgkl7EgIRRg6o7klGLJq8xt/0JVvSLK6G0zrhOfjFfxArLwMVm?=
 =?us-ascii?Q?IurtqRk+8UlYLr4Gkk3DqyRdYKUVbJPSQPm2s1NnzwoUt5S1I1kYqbrQap8G?=
 =?us-ascii?Q?kIiDrtoMxdj1ctvR3mZXtL1NfzPhuqi++62zc7bIeoho63bOD9WIzeek68xZ?=
 =?us-ascii?Q?HN+BpE8GyNQJXZRznhsLu5F6xChMn6l+EqBZrIqKS4QANdO6eOUWUPXM0ti+?=
 =?us-ascii?Q?PEjxb4yEkFB79LeL7JbgnLbqGh5rfm1riGmJR1QiEu4gemWYThaB0J3LU40m?=
 =?us-ascii?Q?Lz1KQYIu8QRFajOLH4Jq5KKUH870wPfraRAtJk4kHtWjqIiT9J5aO79Elc64?=
 =?us-ascii?Q?NHf4AsCsApKSxI60a/dFdZqbtZaJTsVl8p88s843cxS+3YvYgEcOfIwe2wkq?=
 =?us-ascii?Q?Hb2yI+3k02gZcqRkba39N3Jqt7FQRS/jgkzoJR6XwD6W5vrNWC6YatoAm1Sy?=
 =?us-ascii?Q?t7c1aAXE5uypm9bG6JynRclS7Kty2/iHaFoWEG5ERelWD7KAeopIMs4FrpGh?=
 =?us-ascii?Q?1gyZZWtvfllL8NcIzQFcD+QNUVM13AhrteQFbEkTrJeKptikrf0cHBhKCTt+?=
 =?us-ascii?Q?0PEJnHRD9Pq14aYrAuvw5rTwyKVPOca932D9sogSfpSzA2RerWpDPJ06+Gee?=
 =?us-ascii?Q?/Uau/iVAYRbz1Yk13hmGYEr8d8EUFHp1L8RwY84m791rTVU7ymj3gb3bWW2r?=
 =?us-ascii?Q?DLGl3nfDS0fASaK8AGrONQdTHPpj3fFk8a+sqhxXabEd0qSXlg5/rNsrknst?=
 =?us-ascii?Q?wFQU4ohnV5spCEda39fQcQeHV3wDG3fXVDurvhr9Sq8EUJVKu4T73eHQublE?=
 =?us-ascii?Q?U4v15Q6t0ZakRxNY1xELtbV4Dl4yvVPy3ftTDl0+tmTBJz6+k2KjeuRoFDWC?=
 =?us-ascii?Q?dWO56C/PJ9LIPGNTgtutkV3BkWTzLBFoP8bX+H+6btetaPX71TwaTxqQhB4Y?=
 =?us-ascii?Q?DxqrnoGTBlPev3iYfvkN75XtCvPv/54t7lAateP4PN2hQJ0L92mqRQ32THGA?=
 =?us-ascii?Q?8kMRafDUVaITz1azNe2LCXQ3K20qL9+iVY8qFgmJyyYNM9qA7kG8wshn7R0o?=
 =?us-ascii?Q?y5uaxrNLgzR5g6U5jTKiIIEQDE8JOBEpo5/0w5c8x2YJpBA6B1RJAq//FCo3?=
 =?us-ascii?Q?6ume0e5ZSmhc0LGtxtnMGWI34QRGPGjA7rZhv4Nmog8qlVBcIbjh/hvvgXNl?=
 =?us-ascii?Q?mAN29Oj+49uyiecDjhMbExUcoMRvnGIqtHE4Mvuy16lD3QAeA1Bs3L8zSthB?=
 =?us-ascii?Q?sDluxqpMUjuP6GEl/V3LLTmVwziZSUSVAXFTJ7Dr2Y4GDFmLuUS+wQH97TX8?=
 =?us-ascii?Q?J71KYb+us6PCHI3QKWAMF7aa4vobzeSYo5Ybpgfut2i5aAKy2PPpIQVZ52E3?=
 =?us-ascii?Q?J6RMxFI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cKR4t8a6cjtk5Nui4jUKyHPqdkX2A02yCMZSelaz70iyDnc+DsQdMho9Y5LO?=
 =?us-ascii?Q?BrGOdcfWwRf0cpaoXyRlDsuTdEYg02xYKcRyoR4VC3OS//V3c/zAdisprcQp?=
 =?us-ascii?Q?Szjl9Oo8yHJfwrxllGcsvWGbEO37PaT6CLTQh5plkEOQZz/6mEytI8sVP0k8?=
 =?us-ascii?Q?6YBRHVioVKyOYXRP5iPccIKons04negjSxKF2giJBTAIos3ETKJhtUSJ++v7?=
 =?us-ascii?Q?T6uJQPANRj43VRcnpmEfDVCD0h0T198SLLv+9uDshj/LGQ+uvi+42I5EbwWN?=
 =?us-ascii?Q?Copu7cTEWMsbDujqQhCIfVNVCp00DwSFuWE4Tf0mxwgdSEiO2/u4XgY3+Xfz?=
 =?us-ascii?Q?8vch8CSaboKlk9Semq3lVUD7wwM8f1WD7jrBmqxGUNIPQ3KxcV8/I3CFfHMa?=
 =?us-ascii?Q?yWc8DNsPI+KTCALGpCzPkbMV1gNrNR9PRta+xC6zoU5x7gi8xWpNVCVQMeV5?=
 =?us-ascii?Q?bfWT8nnWKJqQ2tVg3KL6omHjkP5prmGd/0V9oEDa5tm2p//wMFSke+LRYdWb?=
 =?us-ascii?Q?GxSzYn+PThsRH6Iy5EDnmDjQzAVdhRpzbJVxXurm4iMGJBxJeSdLdTWNlAhX?=
 =?us-ascii?Q?sSFlJlfycTirYof/z8BSKWt5feBnGcz3WDMnB4iopgs0WlcYuTuXjaWyWC6Q?=
 =?us-ascii?Q?Tgt6i7YRK8RgANa+UUVZDEl6MNV8Ar7030NyehQ/5Kv2gtCiHMjWpk+jexyf?=
 =?us-ascii?Q?k/l/sEdndqIBRSQi277+P4Vcb7gO/QgozKiv/loz2wvYcKr2P0r4NvZ186Tr?=
 =?us-ascii?Q?4ZOyVF/CrXJwjMYz1o7Lg3P+mNhVsv3f5rwCdUIV2DwFtga+GEJAphEIJFkf?=
 =?us-ascii?Q?ByujY49vb0l7JLctqiqZaNtXPl0Z/Z/pUHkNy/n3/lj5BLU5Wq/G2ecjrnr6?=
 =?us-ascii?Q?K9hQMAURZ5JlCo2lKypAMZLKq01CPboFWD0/Nj190/pnu2x8MNPBJh56zJqt?=
 =?us-ascii?Q?mZd03Yb8/GcOU92qZNIQAGhJICQ7dKygwA13/BI7/m/Hetsbh+/zKceNyMAl?=
 =?us-ascii?Q?VCiOMGRBrHOsPwPTyD9Xa/+mcwEgXnf/1Yevg4mtyh/qtd794gRFzx1SQTQc?=
 =?us-ascii?Q?k4rYxPQBuW1DYOf5B0pIviN7HkYqHte/RcfMC1bxzRuB+JSWdtczrdSxyuhG?=
 =?us-ascii?Q?g2BqyfduxICD6yz69DUxI5g4ompuvNV3vL13uJ4LvCWq7GHlXmQUHS0FaFkj?=
 =?us-ascii?Q?m3G+2UEipg/fRskpT48ZD6Re7pkhYH/RdRjGGhETZBEDdcIF0W65FvGFUDLr?=
 =?us-ascii?Q?YCFwWo1bNlguTQB4E8QjMVP7BUvvETL1zcoOKTu+o8eEY1Jg2TWc9snlFpLH?=
 =?us-ascii?Q?ee4NlgHAp+COuxJ5NJ1A/P61l/JftyzNaNUoK8m/PB7XBo8TxM2AWD9O5fKW?=
 =?us-ascii?Q?WxcdQIEX54Bp2O9/ZdaAZ52b1fejUGeflkegWo14qms3ip5DYPRbweKu7uWN?=
 =?us-ascii?Q?P+xubvU5s7VpIb3ZzU2aflmNMlPH2AZP/ZZlEcfup2+Jjj40szzlV2viTrPP?=
 =?us-ascii?Q?jmy4SWdqCX7h+Wy+BqR7FjQJAQmJWIAjpWYTG+k3EZcVvnx1l09Zlljj17Kt?=
 =?us-ascii?Q?VHl7W3VDStS5rrjxDa4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7594b5e-7091-4be1-0249-08dcf3eab571
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 05:14:17.1531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+dNI0F92JkherG/bXkq9KCHHMpV2xLqMOszq/Y3I9PrNiK90e39Oi/Raur/FZ7ryzxFQP8NfZXl/ZUdkMZ30Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7432

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Ugwekar, Dhananjay <Dhananjay.Ugwekar@amd.com>
> Sent: Wednesday, October 23, 2024 6:21 PM
> To: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>;
> rafael@kernel.org; viresh.kumar@linaro.org
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Ugwekar, Dhan=
anjay
> <Dhananjay.Ugwekar@amd.com>
> Subject: [PATCH 3/4] cpufreq/amd-pstate: Call cppc_set_epp_perf in the re=
enable
> function
>
> The EPP value being set in perf_ctrls.energy_perf is not being propagated=
 to the
> shared memory, fix that.
>
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c =
index
> 576251e61ce0..bbeddce90823 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1616,8 +1616,9 @@ static void amd_pstate_epp_reenable(struct
> amd_cpudata *cpudata)
>               wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
>       } else {
>               perf_ctrls.max_perf =3D max_perf;
> -             perf_ctrls.energy_perf =3D
> AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
>               cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +             perf_ctrls.energy_perf =3D
> AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
> +             cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>       }
>  }
>
> @@ -1658,8 +1659,9 @@ static void amd_pstate_epp_offline(struct cpufreq_p=
olicy
> *policy)
>       } else {
>               perf_ctrls.desired_perf =3D 0;
>               perf_ctrls.max_perf =3D min_perf;
> -             perf_ctrls.energy_perf =3D
> AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
>               cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +             perf_ctrls.energy_perf =3D
> AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
> +             cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>       }
>       mutex_unlock(&amd_pstate_limits_lock);
>  }
> --
> 2.34.1

LGTM, thanks.


Reviewed-by: Perry Yuan <perry.yuan@amd.com>


Best Regards.

Perry.


