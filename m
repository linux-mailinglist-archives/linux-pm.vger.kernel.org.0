Return-Path: <linux-pm+bounces-12925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9AE96014E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 08:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D664F283501
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 06:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD526EB5C;
	Tue, 27 Aug 2024 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rS6lxPe5"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777677115;
	Tue, 27 Aug 2024 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724738812; cv=fail; b=XbjJTzeEEvN4CuYJiSBlxDX7wDAwMEqA61jNuk6c12t+DdUkfbDDzoe3EvpxbbM0grQw8kzlpzir4ItiiqbuKzrhIL7OnaZu99lYs2KrXaUEZ6ptXg1/qSOETo+CYledtsK+Tcz8xyFaqKLlVnURYqVON1S/aRbEse2yfYQMm3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724738812; c=relaxed/simple;
	bh=optqXiKWJSlqJ6R4Z/GP0lsgBf18ecqJodIZJEBxKMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=adEIO5OpEesB78C86QJAn+Y858CjvMsyOcUK/Gzt7tTQMM2A7I9jhTCHjXSQni7o2fXhyfHYP7/S1WLt2PKiGuRx+ULqJ1T0GKjWzSUzYUy7hYvE/Q7zQWxLQeOT1+xV+glpQYljfJcAl9jGI/D6/xWVZZhForAO28a4AS+8uCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rS6lxPe5; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKos9M34/EDMhi9p0K2o/kdX1pylIqJCFpYQn4e5Bnnw9wCc9EHLB9dx/Zs9X5mlyjQeLv83sl/VBJKeZeV3CalY7AcYBD1boqmKY9xofZRsB0HA9DK70zbW+Js62gcsfQnpZILyh8OPxip8SRwmUGlZTuB1mQ4II6fz0J5QndPQiJTiF1itRtF47WagMJ+2Uh8yh2jtdS9zsi1CkaRHlVBRv44jQjIWSpU1dddPbBhuxkW/eg/sWNDCBkLysXP+8gpa6ovAq6Hh6IHs1mBMXlmyK4pNIsuqHumgLsaTWFY0aZRAqVudbGHf0p/lGaJEgGERI7cF1wLwlP1xDAwxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/Vy8ICOk6bv/e8CuVEcenv19irNI/Oq5NKWxP1lIA4=;
 b=IAldRdpngvQn8d1sZk2eLLChGHvowo737L15s/Z+nU59EePanKcG9rGrhZPcqQ9XUppoP+yY8nJSUZWwjWwWd24KIxBaLdGJow2TNUlZbrufX8R+x3mM1RHfc+hY9VtVV3dM/8difchQb9JiZU/b9o8/aRHSPEk45e7+dtDwy8w1o+BBdu6Di780eA37kTSU4/KSTyQU7xGgO7+2hIdb2tz3Ca/RT15riXbL7VC6mODEcI6iTdmFqpJ5otAyxJz6447ybvAW9jdvv9LxVOotWm5QGJ422gdm1YJHGwJZJzERHs1KfgEYT6UsSQbg/6gncq240/C4WXhBl7dBeNemWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/Vy8ICOk6bv/e8CuVEcenv19irNI/Oq5NKWxP1lIA4=;
 b=rS6lxPe5LIt9CZDrHlnH8pWh01DcM6pDWIYoBWXhUspwUq1DeetTbhGmhJ0LaW17UiJnq2iR8Zt57of3i2k186AkTj+fByYHOgrVnu9DsxYyZSjjWSgehrPR40KUrvK09Hd30B2vc7qPQykc0Wc3jF/7ox8uAFVq1wze2IuMiT4=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:06:47 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:06:47 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Anastasia Belova <abelova@astralinux.ru>, "Huang, Ray" <Ray.Huang@amd.com>
CC: "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH v2] cpufreq: amd-pstate: add check for cpufreq_cpu_get's
 return value
Thread-Topic: [PATCH v2] cpufreq: amd-pstate: add check for cpufreq_cpu_get's
 return value
Thread-Index: AQHa972B3vAKhk42tECJP992IVP/y7I6nncA
Date: Tue, 27 Aug 2024 06:06:47 +0000
Message-ID:
 <CYYPR12MB865557345D178854A02609059C942@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240826133842.5519-1-abelova@astralinux.ru>
In-Reply-To: <20240826133842.5519-1-abelova@astralinux.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6c8d8c52-0675-4823-8479-4a60e20cecac;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-27T06:04:27Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|MW4PR12MB6897:EE_
x-ms-office365-filtering-correlation-id: 61049687-9d21-4fbd-9cfd-08dcc65e6f01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PzzVZTwDZ1GpNUl2l3NYrJj9o+5+r8o1H/+GNiOJuKdlradXXL1mspDoMxqg?=
 =?us-ascii?Q?YGPDiDhvD7fSDfPvbEjIpVjn40wjgP2tRzEITslT0Gh2cD2qiQuyK2PECSI6?=
 =?us-ascii?Q?KIUmtBXW0RinAggi3R2Oub96c+i+5QeFdyaa5LyFVDG9Twe2g76vku8uRYxC?=
 =?us-ascii?Q?k9JeBjryD/9UVkSjQB6zzK/Dv6WtvM548Q6WVTOIfY4anG/xQqkO+K59EjL5?=
 =?us-ascii?Q?7gVvK1ZIqE36PuyCoNg4swMiqGOZkUIsJHgbCgJthimflj0eSElVLqPCfl+k?=
 =?us-ascii?Q?+3KXMGvhWkjq1wj9ZTFVm1sHV2MO2ZF5jYJ+7nuIm55ziFPzqxWwD0GO389g?=
 =?us-ascii?Q?N7QqbEksBG7QLrrNlBRyr6GOwYmIuwUD29fCjqByW9sdKs32VXCHDFohY3vb?=
 =?us-ascii?Q?59cqR5PWW4oGQeNylhNpRMSGdrJvK0IMF+bKTT73q3ai+OE1mdn0WzCMmgl/?=
 =?us-ascii?Q?OzFE2z8pF0F1h384IxIauTcnPL6U4XeOFAkzOJy6X8pWXP4nwgJJxDbfoXc+?=
 =?us-ascii?Q?8FDOGkwAzkEwNbQBlKsw6b/dUpTUZ5NNpfkn0WhrpEMoXl3aOmkrYiTVnBaL?=
 =?us-ascii?Q?roY+BFFjmw38Yf1CBcsZRQEp38bqzDCg3/FEH8SqnlZo/Isegu3W6L0BxUU9?=
 =?us-ascii?Q?vfHDyoqOTa/nwLducLv3k9iATTVdPsKbKcy9uwj1w5EcRkKDffCIMKzuFA8V?=
 =?us-ascii?Q?zPMMp6d0GUo3d7KCr43sxYKjIqkgs7HEOjhw32L1CeWSvEqtBji7VLfPRnHG?=
 =?us-ascii?Q?K0j/Lo4fVpwcZeAFI20EpAbUTnaWkK91iMmz8o16I8nwpd7agBndotkF+wcZ?=
 =?us-ascii?Q?9NFInlxR1FRCgbUzf0lEdP6brswxBiBfqlhQUHciW/ug3/d0ZoPLYYOGMLDA?=
 =?us-ascii?Q?sAjjbFmaOW12pOB37t+zfypxag5inkajP27bJO9szGdbG1osRwDooaDHdvRf?=
 =?us-ascii?Q?Zd45eFTiLp6DKHpmPcPX57b0jLpTXo7COa1qfHGSMpbvaG17oVpju7evp5rG?=
 =?us-ascii?Q?Ceuc+6aw+gEOoQ+vuIfzUlItoKw19LuzbPDgnaGqKalLVdA6mT+WL900WiT9?=
 =?us-ascii?Q?tEEI7URf4Rmn77IOfemx2FHpc4Okj0Uf7AkDAse2PKrxCKe3K+DZ5xnsJa1l?=
 =?us-ascii?Q?/uYYIVMTzncn+N5yCI6OCKmEnT5hTKPGMnaY2CP2N/wTshKBM0eJA3sN1J2D?=
 =?us-ascii?Q?2Mxd82EgaCCzTWO2ghdKCFGrH/FApqd3bTBC04plL3c5L/jtJEPt/fE8Zgu0?=
 =?us-ascii?Q?m6hMa3vuRvcXK8AkDz99dH5GXs6Nhu640B0rcUs35lT3aPGDXecGDqp3GjQf?=
 =?us-ascii?Q?x5qBa7RVx7sn0dIJpRnhPjV/Aft0jhVrDCjJpTJpamSCA0X6b2hYBhWXncVc?=
 =?us-ascii?Q?bobga9JqCsMBxYzLQLROnnDb30XauY5tY8cZT9GuB9I1wS1nog=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+et+XzwKlHp2Ov55tvMyKfm6mJQPYuud4mHDZYgsrxlrkkP2w+1BNjxoGqbA?=
 =?us-ascii?Q?j0tgC8CcqJFbg53iPZN7wu6JR8pmXu89q1/zN5Oiu4H8/l/hNvvBD6tCCyFY?=
 =?us-ascii?Q?x7641gs/tie+QIH6yvzhYbzAi+V0CbQYwyIWmXE0oQZKPZclDNKgipSYSsd3?=
 =?us-ascii?Q?KddSNFCPzFCuHTe6dZU+a3UXCXn6UyG7e/jzyuKtBKkioywVtD1s8iTFM7fF?=
 =?us-ascii?Q?vhshiecEXjMm+g03uPI06WaMBG+sJJB7lHrXO3aBMO1ZVSeHKAajphc4HgBk?=
 =?us-ascii?Q?y0DQ7ReeuPqw1QYgDNDXEMGmDfcKTRmZ1XqMcA+67yAMly3bNyA0FmMir26x?=
 =?us-ascii?Q?2XipYJ4yMDYclgbJdQO3lBy7WFky7Q0OZATb6+FSl4fM2I4j+MIPYahTYfFv?=
 =?us-ascii?Q?3iITlYOVrUujUCZjP+YBfH5KltSXw8q31yT0UA/V11r76hwZJ3W5AEymAA13?=
 =?us-ascii?Q?yGQ1hQTf5WUPjEwcy5zvTaWU0RAeQIV3mwQuQDhXtlZhvVbtu0TzDOevyGoW?=
 =?us-ascii?Q?wbTwZNB9CSBJ7bTfwHAOwsTSKAh7l+o8RVxbJ66nBgAFcmSnbzG3JxUOBKiY?=
 =?us-ascii?Q?cS6fb8tKKHi0Y0Mutp/uaidns5hRPDZKnNQNYKdVbNpK/p3xBXn209gZLNNi?=
 =?us-ascii?Q?W24kfmTKQntnGkhJaE4+O4/q3dNIURuABqKFRQasY0gGNtMw6+oNFJ/GGnIl?=
 =?us-ascii?Q?iZZfNdK3JpXY3snX0j89DRVpQT3452XRtaBRwB+bvgo7aZuW1CBOrXzKb69Q?=
 =?us-ascii?Q?Jv2aTfGqMJqzD1GNFxtatQ/vX9f2Hy8RGiirapuuE20yWVlBwG8sX7JmvbTG?=
 =?us-ascii?Q?1TEoFdDfHQ0Xu1yDi85tsMdBc07fXN9ucfYw4PI4XJ/In+RoCD960AOK2v75?=
 =?us-ascii?Q?O7x55JueT97gIJUdv9nkkpJerzr5qUkbd5qZJRw8aKNWAYYh7WBjkFWvOEg0?=
 =?us-ascii?Q?jzWOUyGaRO5Ee29HpjVfBHW68239B1cuQbrkfsPQ2uXceFWoTr/DQ3ek2YUO?=
 =?us-ascii?Q?qR8NCrPA8RZdutKRfOX5NSGn1GQT3yPbL5AEu/AJgrB4grR5qtWodefC2GzR?=
 =?us-ascii?Q?Bw3ZAwhV29cVxoUeEQYWIPNwUbqgD8AcZIfiQH1FEgewX0VkDkOQ9BfBYhQJ?=
 =?us-ascii?Q?pRka3JhnbZr6Cy9J8Cqvmb5uDlwUb/D/WZRwGGZKHxQT1cXTID7LopWcTH+b?=
 =?us-ascii?Q?2cABunYHjRTedKf5GAa6NBwEh0xqUg1gqNu5u8r5F+BY1BOhdxXGnJCvkXFE?=
 =?us-ascii?Q?EGxdbuNSFBx+Z1BR2rKNal1sxXLyFt8DIqAx8iGxRdJXhgNTNBpe0nmRVpPj?=
 =?us-ascii?Q?b6VlbwYuKCQApEH9SdO+9fkCIS8EkwABilyASbrs6qlJ53QojhPVz2TvFcX7?=
 =?us-ascii?Q?WdNSYXkadJnDwGNBpC4djxrkUYRaVQIqfah4X1s+cXgtMs2I0BgaAKflZraR?=
 =?us-ascii?Q?OYHMhHG5cwvqWzP8fDJR8rx7OB6LSsuA4AmDwIu5q57lL7e8y3T1Ad3nZQkB?=
 =?us-ascii?Q?17byuYLoGdLG7LSkEtBCXrNgujpb1EVwgBc+2eunYdZFTFbq8QeRGz5EI5kK?=
 =?us-ascii?Q?7f9Iom0QR9RmB+GLujc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61049687-9d21-4fbd-9cfd-08dcc65e6f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 06:06:47.1332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tb1mjzjmZwvXaBLMYJAUmwwgbWBvp4+v4GYjDcH8v5ZsgXuB9eiZ1C2PrXNvL8/+V4l4+v/qPWCmP9kiquxPBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Anastasia Belova <abelova@astralinux.ru>
> Sent: Monday, August 26, 2024 9:39 PM
> To: Huang, Ray <Ray.Huang@amd.com>
> Cc: Anastasia Belova <abelova@astralinux.ru>; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Rafael J.
> Wysocki <rafael@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>; linu=
x-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org; lvc-
> project@linuxtesting.org
> Subject: [PATCH v2] cpufreq: amd-pstate: add check for cpufreq_cpu_get's
> return value
>
> cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it and
> return in case of error.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
> v2: remove mixing code and declarations
>  drivers/cpufreq/amd-pstate.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 68c616b572f2..f8d474168430 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -656,7 +656,12 @@ static void amd_pstate_adjust_perf(unsigned int
> cpu,
>       unsigned long max_perf, min_perf, des_perf,
>                     cap_perf, lowest_nonlinear_perf;
>       struct cpufreq_policy *policy =3D cpufreq_cpu_get(cpu);
> -     struct amd_cpudata *cpudata =3D policy->driver_data;
> +     struct amd_cpudata *cpudata;
> +
> +     if (!policy)
> +             return;
> +
> +     cpudata =3D policy->driver_data;
>
>       if (policy->min !=3D cpudata->min_limit_freq || policy->max !=3D cp=
udata-
> >max_limit_freq)
>               amd_pstate_update_min_max_limit(policy);
> @@ -870,11 +875,16 @@ static void amd_pstate_init_prefcore(struct
> amd_cpudata *cpudata)  static void amd_pstate_update_limits(unsigned int
> cpu)  {
>       struct cpufreq_policy *policy =3D cpufreq_cpu_get(cpu);
> -     struct amd_cpudata *cpudata =3D policy->driver_data;
> +     struct amd_cpudata *cpudata;
>       u32 prev_high =3D 0, cur_high =3D 0;
>       int ret;
>       bool highest_perf_changed =3D false;
>
> +     if (!policy)
> +             return;
> +
> +     cpudata =3D policy->driver_data;
> +
>       mutex_lock(&amd_pstate_driver_lock);
>       if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
>               goto free_cpufreq_put;
> --
> 2.30.2

Thanks for the fix, LGTM,

Reviewed-by: Perry Yuan <perry.yuan@amd.com>


Best Regards.

Perry.


