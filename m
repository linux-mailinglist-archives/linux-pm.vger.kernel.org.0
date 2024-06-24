Return-Path: <linux-pm+bounces-9842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3089140D5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 05:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DEAB228F1
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 03:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9486FB1;
	Mon, 24 Jun 2024 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XdQwcLKU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CF623;
	Mon, 24 Jun 2024 03:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719199946; cv=fail; b=FOIQIOwOp2k8GY/MpFuzVyZksbg+FRJrf8UMJFqedgJF353gC2c84F6rfMw5NKfG/sA3qGOVfC2YIvlt6jw6hFQ1kDtIvwbQ+RhXCfBPV+1ietT6YwYjpIjYQOwN0K6/06sz9KrAsPslw2CfoJh/G0Ci6zPipPVILljJj3kDKm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719199946; c=relaxed/simple;
	bh=eCYu4mHDPqlXaZ9hmWo4SoMavtspXhgIqlEBUZzx6B0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M8CECYmEkHfypotOtSPtttS56Rs+ZCnj5XFs3puYAxYGnABWQMooosgTKkoCR0sqopWipaRpm8irR0eLhz1XTsMziKd6Kxs/8exQvP2rQ+y8bvbvl5ulfpwj2r0sUoIWtByd0p+gK6hlcMRZuC0HvxYSGx8x3XmO02xfAZ1TuSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XdQwcLKU; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu+JkPMB3yVuxrSK2lE5R+vO6oE/AQk5zjnf2Q5baeBzZCMWA7ApvNyoK7QNktxOhtEiXBdPkkPwhXUDXGl8P6TQTdxWWKivn0HY/uDVeu66ONINVPQzzWRUrdNhfdwm5gCp+d40SluIhxKaXWE+TP/tXi1XAkcb/opqoQdBwb+4y16o4wKSIKdodbRR6Q73kah5859KaKWRFgURwuS82Kjqbg/PGAXlB5gvbZmjy8lcMYLxFravh4XQtoS5OOJbTh6z68E3ppLNV2TjHE5ZVySVhiWKVo3zgq+inlD5tn/zKQJa61oOUlwVSKUlOmqmdxnaM8x9MyH9SOk/VJY2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErSdu1/JpK+x/Co964R07vDaldro/uBRwD+clYFkG38=;
 b=N5N++Az8IuIlRzxuLpTTmzVSoIVfkKHztnHzwJxRBljMelVjZAvlJHlqX5IFbv2rH1lK5JDtUUWpisFPy08hdVUsFzvam5bRNc4J8NJwZXNNcA0BK45qFu3JmI8yCyzPOxuAMFOWotJbRTufC6Ph/8w+yFtY3rA4gQL66+cOvv0993uotB+yuBWYeE1TuGwcFVKr3mbiKDuZTLk/C8SuL7neWhB7tT7MPjKacGu3IGGDT41xa3XsLTsROO7pRZUVpW6oxFYU+glfaA5EYI1oG7Er4JH15LrOELLcSVPJ7OoQp64+b1hd9YnOgcKLv1FfKR5RP+11qtj4KKYC+6HBAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErSdu1/JpK+x/Co964R07vDaldro/uBRwD+clYFkG38=;
 b=XdQwcLKUamw+bMyb2NRQ9xIRr+Qk1vvkllrzd0ZCCju6sUI6wdLgQbaKthdnhMg7LljL7d15R38Csuq7iDm8quMud8PgL1XntZiB5yYqqaS5zjVoBdezbpOiKiw1nEuVulo2y1MN3i1W7d8tGfExe2Llwfmu7n3UCRamn0p2OhU=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 03:32:21 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 03:32:21 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alex.s.cochran@proton.me" <alex.s.cochran@proton.me>, Peter Jung
	<peterjung1337@gmail.com>
Subject: RE: [PATCH] cpufreq: amd-pstate: Don't create attributes when
 registration fails
Thread-Topic: [PATCH] cpufreq: amd-pstate: Don't create attributes when
 registration fails
Thread-Index: AQHaxalGRQe2U8iJ7U+Kx8ksZWR9frHWQbAw
Date: Mon, 24 Jun 2024 03:32:21 +0000
Message-ID:
 <CYYPR12MB86551020186DECAAB3DD6E929CD42@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240623200918.52104-1-mario.limonciello@amd.com>
In-Reply-To: <20240623200918.52104-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=27b2088b-2b44-40ad-b303-2ceabad010a9;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-24T03:27:56Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DS0PR12MB6654:EE_
x-ms-office365-filtering-correlation-id: 2293e61f-91db-42c6-116f-08dc93fe41fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CVxdXAkgTpr/2huEmMOYAb5DkFFv+JQa060D9DoWQbHkdNK1IkAFHzAfLRM/?=
 =?us-ascii?Q?Jg2Pvr1neutUBrxMzzqY+ddIfXSAyj3vS7KxULvz+3dXamUlGA72y0wwJhVx?=
 =?us-ascii?Q?O81eAxzfe65UpGBxLPv2+FrX9s4FADyfuSNc4Zj9k5ufP2JBiEv9GHSBYr73?=
 =?us-ascii?Q?c/2Pp1CBjyEkf+kwYjnhy1i9VstK4unSHqxZD373DOwnzKLnsbqPqHAZSM+6?=
 =?us-ascii?Q?rX0dO1sF3rJYDQ2g34EQZbE0nnCxXre63kvN7L5RqC5Cj2nRntvYkt/Cj81m?=
 =?us-ascii?Q?K4CbWWMekeOryNgevxXO8ldR4k3Sp2s0Tq1fQUSTSsFPBh/qu/OQ9ULyh2gW?=
 =?us-ascii?Q?N89nininbb/kS+cKW067bQ01aGvYgzWFOgYKLx6uTJvjEHrxo0/C6yuuvE+o?=
 =?us-ascii?Q?GXNOVwHlUJPDD5DIr6T6R+amNvMq+ybG0BXf5Ne4G1haRyyu24vxyIaZ3BIJ?=
 =?us-ascii?Q?J4aB/Qr1g/+7FSzebVro4LXFcJ7t0V2cj3Zkq+JnoFm64s1JE1Lq0DnCC2SX?=
 =?us-ascii?Q?n5keUCAcFKdVjvUXi/fMlgIsotQpz+bE+/gjGFeHJlu2lgnikYTBOmS5QBXT?=
 =?us-ascii?Q?T02yHCPZ1AEJ2FGL7X6gk7NJcHzcrcu5W6COgifi0lMHqWwUv265y/SLa5CI?=
 =?us-ascii?Q?DKh2IJ/0No3RJXM7K03vfIv30aY3IVXBXEYn1JVIUmuWVgYMlkoPUkWr1uRc?=
 =?us-ascii?Q?6RB3E2yXj6NXVlropolWkzk3s9+Y6lZeG09EhH9FBTf3qFG9ACWNmVTBXGX/?=
 =?us-ascii?Q?ui8/Rv7apyzqmRCiiYV8uQxERrvZpwru75kwI2sZHFdK8EvI5iQAzf5pWi/m?=
 =?us-ascii?Q?v4Q4+NVUiU+QlALP4ZQsKLXqCEu7NjG/Y9RslRe1/letk46W9NA73I3hLnAl?=
 =?us-ascii?Q?IM5YnHhijoBmqcoS9wwIc36OX3VRTaCb5GjB2c0EYKqRbVDNd284MS496wrc?=
 =?us-ascii?Q?Xlt/u9dTJrceEB8/2W0rL6dbxxGZYYO+rIH6ElqTpO9xoZOVseRCsrUVS9mv?=
 =?us-ascii?Q?uoHN/LwhZ7qhThLx7lC5Vq4mVf4E1RigwCkEByts5go5tDXN8pLcWEO3/PRa?=
 =?us-ascii?Q?PCsrIzNzsoXfUGOnwp3akPLdVcrXO2WRsu48caaEgnuJ86DJwYMIzrt2s7Lg?=
 =?us-ascii?Q?LPIL6PA2ej/C+aWHFT26pszwsAtSGIkDQGp6S6O5j76uyW34p1rwD0dwAZch?=
 =?us-ascii?Q?x373VHCmha1tjZ/uWabFBQEhibDga1Yoibq2kywbZR/ySwb4VID3xMozEsgA?=
 =?us-ascii?Q?iQWexpEld1rFeBCQvRBXCI5lHMFf49EGLNMzoX9Z5kg2bP07f+JpouFEqtre?=
 =?us-ascii?Q?N04LpA67LsmWxb/jiSp3fj89fOa5CMpUz23XBF+pTMWpngJueeC9gk5nQ+0u?=
 =?us-ascii?Q?tatZsBg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HzQFSxETx0gZQ0RGR7L4SQYfyqEh3yJ/oXMSJA3Ke/Tv+zhj8Vb29KynVKE+?=
 =?us-ascii?Q?rxm3zvcOKTFj+LOY+PZI6/q6ecjbkf53+XvR+6gzuYj3m68LO3wTVPa8RaWI?=
 =?us-ascii?Q?R5WWG4FjEpQJ9SL19rF7dIUQ+wKQAd+dQ+aeRG5q7b811an0XKL/PNw7PuE3?=
 =?us-ascii?Q?2tJDMsxvo2R9CErAFPNgyl2JarDq/cjiCMFvFp0QBHXeatz9ID81fchPkSdm?=
 =?us-ascii?Q?1PNlOidcytDTcuN0Bg1yXfKLILh5Y6vriwmU5fbqEPYqNNL/yW4HAz/abAL5?=
 =?us-ascii?Q?H01tFJ2m9IYngFAlX8eIdTBmigj7s1AUf7QrFrjvhiyTt+uhD4A35lW2QYyg?=
 =?us-ascii?Q?TRWfFEfDa0wFuhGsPRgdIHmVaWFklgsG7n6fb6e9z7vbos/SisF2S+ZMEEO4?=
 =?us-ascii?Q?8OB4TEVkGCTC/sqte8aOhPJko/guDI4RiWPT7aiBwtstk31ptkJ7y8oRHCBX?=
 =?us-ascii?Q?m9Ws52l0Ce9C/wtEiFMpR4Ukj2xQN2M70IQ+HhYzGZRi4aOizrVcnbLyXpt5?=
 =?us-ascii?Q?oYPKFjwVdngLpcktBi7AXwHcTEU8+az/y8qF62XxQLIrncj65EAi3itrSq2J?=
 =?us-ascii?Q?/H2qJqFIGoobDMcCoexdMOuqqb5O6nrnUuD1rkod1uHS81g57H+UUo4o3t5d?=
 =?us-ascii?Q?+4xezg1VLHbfO0vI5WkskkRyHneRbvsPWfhiV6qIalNb1jfPrfs/5C0OeRqe?=
 =?us-ascii?Q?dSj3zxcHdxU6y9Tn73rg/EU53AAM2S9FP7JKZHYOwtDRYrUGYewDfhEsuqN/?=
 =?us-ascii?Q?fJ67nFDXOko0a6SfXeOU+N/ZHyb9fhWMe9GX3RCDYDScuM8BrMlANgT8AsqP?=
 =?us-ascii?Q?0zpnH3V0liepxjHHDBgvOjP9ZjZp3OCi8OzrNKZf7WEf1wfE9W7L6joFEC2O?=
 =?us-ascii?Q?cSL09KZ/KHtLtVLqf1wD6BvAI12BuVErOkPFQ+ZdXr6Vw3AcfY80VEKUWYA/?=
 =?us-ascii?Q?33fSNhOv5E+/yZ6YBBABsX3szwchXte2zSq27PxqLtZV3Z/RnVfzzDzBkqMG?=
 =?us-ascii?Q?TqvG/G+bFq3UdyMnJ2Dg8f9apRjx+coTtGfXVdfuxb+Mz4KHXNvoLOrcESLz?=
 =?us-ascii?Q?1iWjJzjOk8JU0Dp/9vpEf+Z2fLf4KwZVeevQgXXjnyRqH6tY1R1mjNaHR28Q?=
 =?us-ascii?Q?Eo5XPhGlyb8Pob70C6Yt3/ZYUzcJZ/iTM1yCOreo+r/Q7bhgo3ckK4wjL4p0?=
 =?us-ascii?Q?XUhi4OnV+GcKlSEqlWja5ToGv+iYWxCIrSMbWJSJPWOLtfA2BXqWp7YwDp1p?=
 =?us-ascii?Q?l2B8+YQLAtEqvdtHa48LtOcdvufET8z/KsmiUTI0E3xXhIWQX5sOSEakLUqf?=
 =?us-ascii?Q?RA5n7liMfWbub9bw+AU7wRgVqGkuR52jfDIEf3K87Oe+ikpr+B2Vw+DOPNtP?=
 =?us-ascii?Q?vNrZA+MKmUt4wPBFQ8WJhRL20SLwNi9cDIffDpKxndDNQtNQ6zLDWTRtOVya?=
 =?us-ascii?Q?4mYTZ4rcg/5wZ7gPxDwpESiCFLp4bXf+D6NSZICfzW1jkrRuK8+2CmsoAqM+?=
 =?us-ascii?Q?0VSaAqJb7V/V0JNTiQbXspVsi7ED74Cy+ra6z8+7YUr+7BYIEwq9I/loi0Hj?=
 =?us-ascii?Q?RsINvda3Oyj3lKSQzkk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2293e61f-91db-42c6-116f-08dc93fe41fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 03:32:21.7755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9HhHzrrUvnDduJ/tSwmNB6U+r6WDWwfhN03AOZ4bBI/posUDAfqjrg0AJ4YpPkidpuIL7oORBt6WVgfNfkmhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Mario,

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Monday, June 24, 2024 4:09 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Limonciello,
> Mario <Mario.Limonciello@amd.com>; alex.s.cochran@proton.me; Peter
> Jung <peterjung1337@gmail.com>
> Subject: [PATCH] cpufreq: amd-pstate: Don't create attributes when
> registration fails
>
> If driver registration fails then immediately return the failure instead =
of
> continuing to register attributes.
>
> This fixes issues of falling back from amd-pstate to other drivers when
> cpufreq init has failed for any reason.
>
> Reported-by: alex.s.cochran@proton.me
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Peter Jung <peterjung1337@gmail.com>  drivers/cpufreq/amd-pstate.c |
> 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 05e80d2f8803..7195dfa98cc5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -2030,8 +2030,10 @@ static int __init amd_pstate_init(void)
>       }
>
>       ret =3D cpufreq_register_driver(current_pstate_driver);
> -     if (ret)
> +     if (ret) {
>               pr_err("failed to register with return %d\n", ret);
> +             goto disable_driver;
> +     }
>
>       dev_root =3D bus_get_dev_root(&cpu_subsys);
>       if (dev_root) {
> @@ -2047,6 +2049,8 @@ static int __init amd_pstate_init(void)
>
>  global_attr_free:
>       cpufreq_unregister_driver(current_pstate_driver);
> +disable_driver:
> +     amd_pstate_enable(false);
>       return ret;
>  }
>  device_initcall(amd_pstate_init);
> --
> 2.43.0


In the previous failure behavior, I saw most of time, the driver will fallb=
ack to acpi_cpufreq driver when pstate driver failed to load.
I agree to disable it explicitly with this patch.

Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>


