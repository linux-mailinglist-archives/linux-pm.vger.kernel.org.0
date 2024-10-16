Return-Path: <linux-pm+bounces-15726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500889A003D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 06:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FCA7B20D3A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 04:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92716185E50;
	Wed, 16 Oct 2024 04:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FakK68+g"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE321E3BF;
	Wed, 16 Oct 2024 04:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053496; cv=fail; b=AGF6BM4FpY8XjhEWZ+oJqM4eYNyYSfwBJpGjsEzeaWtsZtmJejrgHQm/k87DUYBhfHG4K+7GIbRxL0EOcCmXDRQti7eXzn9jyB0V0o+kFZ9i0oWwJEpFFcvv4UU7aG0V/UMpBQfFjZYxIW3V2hld6H2KEnRDp5NFKGigWAQZnGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053496; c=relaxed/simple;
	bh=PyxkNaACFl/w+vegyPD+MfAFZyWF/YDXD6Y/esGgi6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XWHC4uC03KciCjcxURxui8KwwmayQYrLfgJFOqGIYAP57mr90nD+ntMPaM0qMaeuPDusyKv0uhW3VDySQLuWaCkuyIU+c7U55PSXmHCcCjJ4V5su5gLWZCAKgBp0qbMLrC4EU3+8pUzViZQisnxIeJ7+yQbp8KZAZKSMhwD4UOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FakK68+g; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XV78ip+y5+2as44s+rwOFtIcXRkdlYAWVY8DZfT55CKUAaz5LCr3lfZ8DRdIu3CTuHz/+LeBHzZiB6jGKZU7Kn0wvhnrT2UpeTTC8xYrd9Mg8PFc8mi7MQpc44GgLgLOLFKiKoHflWGPKx4sgjeZDh/9iAnvgZiXzx33he3zxc3OeE8yE/d67NVkYB0Y2r0uTWQcWMeYHjaw8BQI5o1Js22Bswmy4IHxokrhf39zrA6JG3d4TfedTWkm5/f/Hg+fp+c5sS+iyogKZCMGB34rTRQ5UeZrPNfKRoIm/1nGYGjtEh3GiVYUoGWOvj9OhbkHepuyWvEuBzKYquJVz+Mi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Y6xiCGTKF1o6TsDfGILA7cs/N6AqDoRmGrTVsXKqjE=;
 b=HeAWgNodFbPVHtb4Qv3Q3Sm0LsA+Bo8QCEn3LJY7nFF8BErwGWePcRaYcWRTgz3ynn4Jxk/xv3NO8wYls0n1p7Ko4fWXvm0+yd/RKItNfB0HGBwyiMDgvutzS2iE38zyHDpoX8vrf5SoQRi4UTGYvsdx5LTo/s5UFHEfcVR2QIjAZPFuUKGC0s9SvnwFvN4RgNP3eBoguB1G8aCkFqPBRvzvi6bCufrjUEP3rs/4KCFvOM4Ll9eCS+Z0IhfbDfRAJ/6WLeRVNEwxEc7N66aQlp3iNRx/gFj8LJ6GBKLctHSWiCWh6fLUPzDh7J/zvG+JEaT2CwNX5FRjeJjqVtSpZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y6xiCGTKF1o6TsDfGILA7cs/N6AqDoRmGrTVsXKqjE=;
 b=FakK68+g8nJiGDUedhSzJKy9gTHK3X/gRxYdOl85Psdzt7DJVvlw7NhA5UVEt6k0SKBUe29a7SexAOIZS1+SEIFvxycQVMLeO8tqWrVC0PgU2AKGFIIJeFz8yg2+AsQytPZDHN8Va9cgkuQ+R6UMldVh0HUFiPf7WAizB6g80+E=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 04:38:10 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 04:38:10 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Ugwekar, Dhananjay"
	<Dhananjay.Ugwekar@amd.com>
Subject: RE: [PATCH 3/4] cpufreq/amd-pstate: Use
 amd_pstate_update_min_max_limit() for EPP limits
Thread-Topic: [PATCH 3/4] cpufreq/amd-pstate: Use
 amd_pstate_update_min_max_limit() for EPP limits
Thread-Index: AQHbHM6arYj5d1g+RUmTYEwqbg20irKIz9kQ
Date: Wed, 16 Oct 2024 04:38:10 +0000
Message-ID:
 <CYYPR12MB8655A83FF260ADB55F40EEFD9C462@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20241012174519.897-1-mario.limonciello@amd.com>
 <20241012174519.897-3-mario.limonciello@amd.com>
In-Reply-To: <20241012174519.897-3-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=6f37900b-3515-4a8e-b6da-59f8f41ce340;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-16T04:37:59Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM6PR12MB4337:EE_
x-ms-office365-filtering-correlation-id: 6ae62efb-5873-49d9-eebb-08dced9c56e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GNZ6bqIEN3gOeHuAt27KogW64lrYaD6o4dbNkyeddf954xHCdUUsrzWFC1w9?=
 =?us-ascii?Q?suAiB+mmm/ZthafBO4afABQGeci5R4a3P/tuf+NW9VvpSfIwmX3zXOF1eFOh?=
 =?us-ascii?Q?UXF7kFpu5xC8Rp1NA6Pqz2s4zzAli79SoGVOl4oEaFAvI6UA4aLYA5h/Ln4/?=
 =?us-ascii?Q?Wp08Yns9D2iJGMs2JSD+tzCqotzaaRfrIMIIj9lCftEzneq09gMhxuxF1yS6?=
 =?us-ascii?Q?a9cLJz9P3pwqI41K24mbnI9TJSgmy6voNA/FzdSVPDf3ka6/Nk21+JVGYg5T?=
 =?us-ascii?Q?LBUuUg9R50CUCFIbXIVFeejXrWzODFYFexiIfMZTZq0LO39j/f14MTMrebLD?=
 =?us-ascii?Q?O5XemSq9nqpbZwxKYrGU9J4diDpuRvnkg04JSAnC1dlX6dTcofN+Ba59EJbm?=
 =?us-ascii?Q?A9KF4DGJYvfriuOgQsjiarXck0JJU/NYrr+a60r+SDY9yiSj8cdtO9SyaHL5?=
 =?us-ascii?Q?NEThzvExSZwGBqCp0I+wGfJL5TsKoHPEcRXdm8d/sbeSmUsmgtDvCsEXgsUF?=
 =?us-ascii?Q?YBk4rQu1SC77CkxTHhEzFFl2Iwnsuzmc+AtUtWx+rW0Nqc/QbWLienC+S2T4?=
 =?us-ascii?Q?0Oq3tQkUXyuqkHOoP/hF13sg4ReVwQ2728AKP4+1o45x/D7m0dDspUntU5T0?=
 =?us-ascii?Q?oyyN7Sgjl+4T8lUxcD2dfrWzkoCWXhcqLOeUs/JI69deizPHR86dEpft3r4x?=
 =?us-ascii?Q?lbm3TGlgpeYWNml4CW6o7cSCOkZhSX+OtGfW8MLOXPqDENW1Uag/Izil0/hU?=
 =?us-ascii?Q?7z5SPzguzsQ99AwIZFBx22MPbIWUrftCNutKmSt7hTFidSfjSIvm+ej9RxaM?=
 =?us-ascii?Q?zQAmHeq+0IaAy7LhR2LFrVkI5inzZFehU9ydnutEq6xDhkDtNnoxGrk8NNoh?=
 =?us-ascii?Q?4+bh+3Pp1jDtjjS1+nxj+wsGL2G6r0h4M0LPNw189CGzPAbQl4VTC+Sjqixe?=
 =?us-ascii?Q?qfkM+tlO1dqEC3AD4vBoe4JQjlD5lOYQIYvh/xKMR96iqmu2yOQ21VeNZk7e?=
 =?us-ascii?Q?NTnXPXYFkAinG+norshbAb+xMj9xS7ac2GOTuNP10YLV2SaBurpIQZtSmXGd?=
 =?us-ascii?Q?paP/EXt8T129s8CtVJqqCnr8nbAJ2hodVWQcXi53hfqfxqj6qzyh9MDB2ffQ?=
 =?us-ascii?Q?SJ9nMDSvmlFDWw8KqFLlutHF1NL/IN2mI7oC3dlFfcispGLjb7zEggUB6HnD?=
 =?us-ascii?Q?6Ksk3/K+xng1tMmK96vNHFEbvwOYftZdnTNEAnPPUxOXpfWjMKdRmsJUPY5M?=
 =?us-ascii?Q?XrqSzDH5b4zrVJhL0P5t15+H45fOYyjiTG5oJXwAaYpWfE864P0A/D7Djh0+?=
 =?us-ascii?Q?qZMqlk3w9S82OQhlXSjnA8uM7qDK9v385Go6e62hPCrbUQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5R8tTIq4dTOYRLlOb6/81kBDDYBlRwGnjxzLx565ZUhNysmwG98+t4xPsot/?=
 =?us-ascii?Q?P0+j8yY+QHZBPrkavxQLMseJQxqRWfqFu1Yc7g8fs2UcpMyF+z8vVAIxdC3l?=
 =?us-ascii?Q?ci1TihntSEbrwi97ITGllslQZETblGXrIoGXgQoU1GPTDDxKthZ0uJ2cA+LA?=
 =?us-ascii?Q?7CA7Uv80OprO/xiHST/putEeqiVkCRBKhAWEypuEVgMvLA3TMnggjmalwSPl?=
 =?us-ascii?Q?XcsVf/M4zAKT1rvU+2Eb5PO3Aecg/xQT8Do6uzPJsxLzUIYOc1FbMrLVH2xi?=
 =?us-ascii?Q?abUs1iR1R6jIs2hGJa/mgBWF1o8/OFIFSTrlpAzIlXOBOJFjDPOstov99mkI?=
 =?us-ascii?Q?3Jh0CcPw7cZ12f3cWI8pBT/6NcEeLVdnK+JgOcnVmrosWSTCgENclUC7RAc6?=
 =?us-ascii?Q?GB1b1kCorr6QMoHht6c0225DUyRmefWLmu+oj+AKTQaAb3/MmQ00qIRGwsAL?=
 =?us-ascii?Q?J+1DXANjeIh6ONkT0RgUdnxQUie3AvGAk7fhMsPCpjgqwZAY+3u78cDGwvVi?=
 =?us-ascii?Q?HfYQSEFNJytR7ACJn8ZnjKcvSjV5Z++6XTQQDtktOSj0pjSzAP6haC5Qslxm?=
 =?us-ascii?Q?+yUxaqn8Eq7r9pPWERAwShofw8jyPVRg5yRvMniGoCwhtrOqPhafoJSs9nSP?=
 =?us-ascii?Q?sejQVM5C8TLkZ4u9zl1g47riY884EugN5osHaR7gZHHypVGYmjf6rX96PJMq?=
 =?us-ascii?Q?pXYFIlxVPpanGAL40rwYKs5JSJoGj3VjcjH9rb+1aRtcfc7T0MfbMXKGueFx?=
 =?us-ascii?Q?c8ydXA55gRUhX8p+cE9MDdVVh5Te61r0AIwGzzv7S+etOqmiY44+pE7mufqd?=
 =?us-ascii?Q?EP4FPWdYV4atpO0dTnBuq/eAgadnnW5nT4JtatSOXQLP49lTWHSGnxgusaq3?=
 =?us-ascii?Q?fTlNrOzzy8WPxtPyOm27e4kWOcnkFjp67tFxDdFXHKBhPZRdzJ0MvMIpdqyK?=
 =?us-ascii?Q?P86U7orSFSlf+zSx0UsFDIAe7sKl9yNHZ34utway1nzAqOMTtS095VcWBNGB?=
 =?us-ascii?Q?Q3hZFeKxTjnFCWtGrf8Q3Dj+5NufC9E30kUjWGVrWNx4xOVd/1O5qg6jwDk2?=
 =?us-ascii?Q?d6ToA3G2vFBkp618O7eTSzlL7JtD0wrpB5qR4Ap02Zb9Im4nvvBa67MA2Fwx?=
 =?us-ascii?Q?5PLYOVWkRdEbztjN33bdnp6vLO4ExSqKIpwjK/YzNthk+mqWixsgO1QfZCVr?=
 =?us-ascii?Q?3Vrag8heGGBdMlyna9wxcRE1c2Gi+CN60wjM40krTcLm5FmPzb/JAjZfHW8O?=
 =?us-ascii?Q?zKGodCJxBQupxkmpxsCqm723QpI0qK8mjXCqA5FkVGbgixrUpgSAEzLqwh0b?=
 =?us-ascii?Q?STlhLRobZ4wk1yGIgEV12WrxPsbD6QfDEvgnoj1OzOZiX37kcps1wroDrdJ6?=
 =?us-ascii?Q?R1+pPzhDJKWPew+na4YKtoFlTisxtj/xuBjRpgaPcLjzW529pFBJYmNIq22n?=
 =?us-ascii?Q?xpF0mzb0VfgI44H+wxWLgf8Qeec+67raw+e95WrwVYONAk/kKSdmEk6EezXW?=
 =?us-ascii?Q?rkdcdvqx2u9VIMeUduj8RZresPcGWBmxz+L988XCOM5kDUPwr9eLR2X3zXQN?=
 =?us-ascii?Q?Qlaeh5YreByjEHnPCoI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae62efb-5873-49d9-eebb-08dced9c56e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 04:38:10.7999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZzPyOxcR1/9cpXB1hyDUZeJwH89SyAIhRGbjXKYnvf+AI/iC58ZBLUeTICXrvfl5w26pvDqNNBZXYm9x0eLqsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337

[Public]

Hi Mario,

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Sunday, October 13, 2024 1:45 AM
> To: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; linux-kernel@vger.kernel.org; linux=
-
> pm@vger.kernel.org; Ugwekar, Dhananjay <Dhananjay.Ugwekar@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 3/4] cpufreq/amd-pstate: Use
> amd_pstate_update_min_max_limit() for EPP limits
>
> When the EPP updates are set the maximum capable frequency for the CPU is
> used to set the upper limit instead of that of the policy.
>
> Adjust amd_pstate_epp_update_limit() to reuse policy calculation code fro=
m
> amd_pstate_update_min_max_limit().
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c =
index
> 13dec8b1e7a8..8d2541f2c74b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1485,26 +1485,13 @@ static void amd_pstate_epp_cpu_exit(struct
> cpufreq_policy *policy)  static int amd_pstate_epp_update_limit(struct
> cpufreq_policy *policy)  {
>       struct amd_cpudata *cpudata =3D policy->driver_data;
> -     u32 max_perf, min_perf, min_limit_perf, max_limit_perf;
> +     u32 max_perf, min_perf;
>       u64 value;
>       s16 epp;
>
> -     if (cpudata->boost_supported && !policy->boost_enabled)
> -             max_perf =3D READ_ONCE(cpudata->nominal_perf);
> -     else
> -             max_perf =3D READ_ONCE(cpudata->highest_perf);
> +     max_perf =3D READ_ONCE(cpudata->highest_perf);
>       min_perf =3D READ_ONCE(cpudata->lowest_perf);
> -     max_limit_perf =3D div_u64(policy->max * max_perf, policy-
> >cpuinfo.max_freq);
> -     min_limit_perf =3D div_u64(policy->min * max_perf, policy->cpuinfo.=
max_freq);
> -
> -     if (min_limit_perf < min_perf)
> -             min_limit_perf =3D min_perf;
> -
> -     if (max_limit_perf < min_limit_perf)
> -             max_limit_perf =3D min_limit_perf;
> -
> -     WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
> -     WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
> +     amd_pstate_update_min_max_limit(policy);
>
>       max_perf =3D clamp_t(unsigned long, max_perf, cpudata->min_limit_pe=
rf,
>                       cpudata->max_limit_perf);
> --
> 2.43.0

LGTM, thanks for the optimization.

Reviewed-by: Perry Yuan <perry.yuan@amd.com>


Best Regards.

Perry.

