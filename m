Return-Path: <linux-pm+bounces-9070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BD0906877
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 11:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7401F23771
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBF513DDD5;
	Thu, 13 Jun 2024 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pUberKE8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946A13E05B
	for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270497; cv=fail; b=S1n0faHQ2J8dOpgv1b6EKexnyUedhwPMF8f7gk9yyjH2kQiBaad40xM/7t0pVKpvVtaY/dByI9cDZxMVD8r4g6jdiBUZdR6N2dO+1j0N4J8RqM0UbucxmELU7bTc7QpwxaED5EwyS1XmHyEMlhsvWQ8OeXTY6mC3HnXnKiwS9Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270497; c=relaxed/simple;
	bh=moCI0ZtP9o/n1GUi+cvMK1Tyk4h6cora7MA2VZt1THk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oO6aaikwmD7pjq/3iEuzUy6nBMOlHBupYqZk3OBRXjUlWwH387X7UvDX0gSsAs20TUhrBzIsQfLivwwGezZx9ByAQ4RDN7+mE23+bOcgugQIYT+hokNep6H5mLxcVA0ZsXQkMbZ24B/J6db04lnxsv2u/LF3rb1QbS6Aw5UQTlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pUberKE8; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJnq1/7e9hhaBTr3I/pqJJVxm1Yw8A1Cb7MogDSLytLGUftFJWwuAGU+FWhWTBRP9mJcgF5uB9Ujb4XETFPYZ7jphYBy6Q8pxGQwOEzm50BoKd/sA65eb/dmYuYCxfCYizVk+Cf6WH5j9XKd6WEayvoKFiikmdPphOtKuadwpaXN2oCi0x8BrnASC/RzMwervYL6yWF9sxf3bVF/i+uumnMGNOUmNjUQPHj1nbmlEHAd764SAEnQqms9UL82CsXTQNoYrZgakfzIwIotUdK8IZA8ZV79h39IZd99cYs1bCFXTdCPXr26Mzbt5t5mfimsumh9ysazt7qU0RXLBh1Wtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK+Mqgf3YtKCWVR5EccTw745QWfxUX5vuInfFqcILuU=;
 b=lU5YpNsbDls/yQhdxnq05JGZM96p109oXOhIDKJVY4hUybNOMAdT8MxzBaReGAaX/w/bUMRf+I0y6Bj6Xuw6HBHqUJj4iCaA9AsTUwjMcmYsTHaKar6ck/vDXA72f6Rp5H7ZMGqO/C+5TsMSDv82mpBZuayvLFwnhYZ6Qib9sUupi4SXkKzTsCmDIuih8wk+K41BNuwBVvx1oxhvZVJL80MhPKPXHEQC6Q1HSL71x9A9SSNgX4yUEHDpTmq2hMz3mNkMFLJpxM9oqQSxHaGQ8zv7CXyjN5vJc0pniVYbL7BlTmiLX0AuML6UTquYAFooQUf1gaIfKfdaG0puhfjuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK+Mqgf3YtKCWVR5EccTw745QWfxUX5vuInfFqcILuU=;
 b=pUberKE8oVSMQ0KS32mlhs+FUYUU746O8hAb12mlE75PjtdO1WxK7L9zKxQ9SMj6sgPwkpaGq3K7iGEib6TYY4GR1Uw9pEpZlf7+wsqJfEOGSX5TV/yKhcnZ7T0oJRBdoN4rBK+tt+CmcC8QleUyzmV/nxoKZHBgFzYmpz3dnNw=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by SN7PR12MB8145.namprd12.prod.outlook.com (2603:10b6:806:350::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 09:21:34 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 09:21:34 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Artem S .
 Tashkinov" <aros@gmx.com>
Subject: RE: [PATCH] cpufreq: amd-pstate: Allow users to write 'default' EPP
 string
Thread-Topic: [PATCH] cpufreq: amd-pstate: Allow users to write 'default' EPP
 string
Thread-Index: AQHavNjnWk+ZGfHtV0aEE14rcWwCZbHFbCjA
Date: Thu, 13 Jun 2024 09:21:33 +0000
Message-ID:
 <CYYPR12MB86555A3B8AEB9D162482C8259CC12@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240612145737.1618-1-mario.limonciello@amd.com>
In-Reply-To: <20240612145737.1618-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4f3e9105-ad69-4dc2-aa0d-0d57be63f323;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-13T09:20:26Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|SN7PR12MB8145:EE_
x-ms-office365-filtering-correlation-id: 66a2bb9f-4918-4b10-81e1-08dc8b8a37f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?D30r3h/iindvZpc6xsnTd013jZbsyBhjzfXgXtFkB4GzZR3XgRfXtqZFAGNK?=
 =?us-ascii?Q?zSWtItBDsEEeGOrfsEFH8iKRu9p07eWzu/DIyyDldkBm646K34ryTYHaeIi7?=
 =?us-ascii?Q?jWy0wdXbKszpWrWpUGNkbV+UEBQ1jHHWbXKYsuQ7c468q/pkcD3rt3VbgV3p?=
 =?us-ascii?Q?9dnDBtkwaRLlKqF+QyAnXLvfYeGt99laixWuZz4Hz6Z9tp8zwC0iG3VMgS27?=
 =?us-ascii?Q?1VMmr7K/Dxr1EMeXVlw5l8tWm+yLr4f1zwqwIq65C0t5rEZK/ONNXJMrLJQV?=
 =?us-ascii?Q?9UqkwvwOvjmbbz58CVxXDtlq1QSXNgV7eKb1+dJwsAmmhOxoKT5gVU+7CBK6?=
 =?us-ascii?Q?sXU6y3lzSN8gFQJfIvB4xJN2IJ6WOkj9cAlX0aC4ZikPvOgJ9wirnbWnvOGJ?=
 =?us-ascii?Q?E+MDZwlwtEVv/m4vj/ax4vwSDnbj2nB8HUKgbuga2hn70lvkvdMLUDoWtNGB?=
 =?us-ascii?Q?L8GleR7BJ3jWL+V/iLr8D881uIDdSacJUkDXtX0R9sgmq+thv7OKP+uyVVLF?=
 =?us-ascii?Q?TbcoiZ+eL0yorqr5LS5SJ76NUVvZAKEEligN8k8fa1wJem4F2s7eLUUkSSmN?=
 =?us-ascii?Q?HhZPBD/qbOrleZDKjtxFG1FEGItTtwnfO3P5pOaCM84UWUgk37NDesdy7oxA?=
 =?us-ascii?Q?mSu7gcs1yhJKWZaJ3Do8suewKWmLI7O0RKsD+OEJJQzSDIWpnadZV1d+ov//?=
 =?us-ascii?Q?J8HAcp9pK6XdJxPPOjEH+Bezv2q+VgBzAMMLvr4AvkD2eeiwijsGS4nrAUyi?=
 =?us-ascii?Q?QauQJgGgCUo+e70Tw3PJTBiR5dAWydMob5TJy4Tk+PtVDZB0Crkzhu16TLNo?=
 =?us-ascii?Q?YLA1l9fd4vrtX4gomQUKPkzH+rHVL4cmV2JKSze8jEvkRvjfbp1MdTB/sL12?=
 =?us-ascii?Q?Zhj7gJSPW6QTVVJQ1Alch+W3jfvIej7AQsg52Ubo/CvLYKlAHlFpNoxORguT?=
 =?us-ascii?Q?7vErveLQXqhyEVOBSwAvhVbwpxcblVpIuU8hQEbuQUhBUZIRFlo0Aq7aHC0u?=
 =?us-ascii?Q?x03mr2VLUQ/R9yKqCXgRH8ioT9di1jnE8MOlWPjB7w+E1tQib8G30kXHtUXH?=
 =?us-ascii?Q?NFABtne+3F0jbww7LgRIXd0E27GM3Bkezkh1O1mG7JwkK3VTanmtSh7nG3s0?=
 =?us-ascii?Q?ABY5+LK1tiMwkv8Q59FpHbweyO/nTgCcXyXWSTbVG434CL0J8eoEupkJg0tG?=
 =?us-ascii?Q?jz6ifFNOoTrSLM16VNGuormU7UspbrA2gT7p0khkOOiyGZI21Ud82h9WeHZd?=
 =?us-ascii?Q?AiHW/0Y+Jf5Qr//ChaL5j2KmgUfmTkTLzIQS97COz6LCi8k+OuB8TO6oP16+?=
 =?us-ascii?Q?Tmekn8DDQz7YER/ItW6gCq3l?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dYK+xkzjboHnd9SrQLeYSfdnbhIV0Rvcf8XuCwdyWzO4G4MCMYH67cN1PV7/?=
 =?us-ascii?Q?zGjcwIvJxYBVk25HzKHM9+bEhRbUg9fySlyDVa+Lwk4bCGoXfHFdu78wnENL?=
 =?us-ascii?Q?Sdp8TZqtisI7DHiGMfu8xHUWmBaO35zBfoUG6oOAywOzZRWcfJMaLkmV33wW?=
 =?us-ascii?Q?CyJc5bEgm+n2b4ZEfH3IXFFxFy22d0Yjxe24o+Bv4Gjj6ZPEvJpM+YkAm9gA?=
 =?us-ascii?Q?ucSEFmDkP5yS1A/uUoXO1exVq6BvFfmrADhMmgqjq26amvpthVb3pMef16FO?=
 =?us-ascii?Q?mXAV/enNgdUzzCRpdLrSE1+bTb3YsEmQruRzB7eqsqCpkWdeTHsFHuPqVcEj?=
 =?us-ascii?Q?jip9VnaV5qu4zbc52c0m/feCPQFpmVVphSs7w96QN62VFBIoNX420qaU9hHP?=
 =?us-ascii?Q?JJs7IcchifBwWqHs1zruqgVY2DNIhj9mi3LOq9hwhIKop2YUsdfMl7zGgHDs?=
 =?us-ascii?Q?rO9HmzPlgXr19yhJH+QFdLp+QQAQIpuXDCcKqR7V9YZnVCMSE0ST7fqhNEag?=
 =?us-ascii?Q?usIWX0ciFGTf69DwXTiiYLWIxUT/LPjw2yMWT1aPiZ4GFGBDmi+jL9xa4Cqk?=
 =?us-ascii?Q?sNfnsm2UsrNPrQ2XyGDVlwDdyLbihth5qXEojbRrmQT3cj2WqDsGzuq5GYtQ?=
 =?us-ascii?Q?QaNA2mUcrjiV+8Q6d2xDCL8g9jWtcnpyoRzoH6zQ+4VcjfPVib5DLmsIXdMI?=
 =?us-ascii?Q?w+9tT+p/tkjudWAu5jgJDO5hq7/TPI4zHeOGk85wzYOk742h8/gTW0YKuHBr?=
 =?us-ascii?Q?DEM7/YX2zZFI8f5t8gugkk+SsDN5a0TPBZwGpsHPvn14rloaL7vFsdOPUpXI?=
 =?us-ascii?Q?M+Pc8vXpOy19e5giVVkSqKeXmNn2Liu8TFDjHEw35quz0uHkl0kgRD0awOhR?=
 =?us-ascii?Q?plinjM+XC+WlM6KOVg4+JRgmz+WmmPWvCh8ubBklNRvcGib2Sun48mjBeQ28?=
 =?us-ascii?Q?mwhyV61kfyNVnb5buLmLJgvWkZpnrhfY4sHuOORwnSdqcguztQavvdZZ6Byc?=
 =?us-ascii?Q?ph/6v2xH4dGzaYdj75KRwVsaWCFIiyHyCgDZuW5rPAoXC5NEsJ6xYoao8mgZ?=
 =?us-ascii?Q?0Iupda4bhMn4yKWW9HibVRfwipHYg2iY+yRryOO7KXJB5CEynA+O5l8iheDP?=
 =?us-ascii?Q?LHBlOouRP9HpqFRKKuDjiRDZdqzKN0NdbkDZy9+jH6SI6ILknAa8uRKJ93e6?=
 =?us-ascii?Q?FhZZaH5cswUGDb3BYGHiV0+dcKMHqdkhwOomuzorS7a4WBdoLW6fXbpeaJPn?=
 =?us-ascii?Q?QEhsZ9eDdfBT1VLrDO2P9l1OsclxIXqWfIgc4Ue1rTcAB9iY9w0fLpoVixZz?=
 =?us-ascii?Q?K+zKpQv7zIQSwv6wSXM7ADNI+eMN/Vb/npGPy2PPe9UoHDujm1tRXHBMKz2D?=
 =?us-ascii?Q?E9K4q7+y4xoNUp+Vb/zZFfmFqRDNAx4oChIFcif6fl/xrUyIOp6QN55YbIjE?=
 =?us-ascii?Q?RKDAM/Yo9vAPMkgPIZ1M/srzpvwt3IYGvlHaPBI9KO0dkuLZ7iGL0nkYhdqZ?=
 =?us-ascii?Q?miLhb99jsliqB8JAUSFc6BARdoOqMh89KU0xpUyvkQy4PHosrlXS7HDEV7IT?=
 =?us-ascii?Q?WTm6fSLoZAA+/USTtrI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a2bb9f-4918-4b10-81e1-08dc8b8a37f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 09:21:33.9587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZh90HftJrk9yXLLalBcnu13bLqsN8zV3ZfbApQOSRKwrddJe0EjuQ89lCFUhtROl/ETgrcoM4sutnfMs6KzoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8145

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Wednesday, June 12, 2024 10:58 PM
> To: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; linux-pm@vger.kernel.org;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Artem S . Tashkinov
> <aros@gmx.com>
> Subject: [PATCH] cpufreq: amd-pstate: Allow users to write 'default' EPP
> string
>
> The EPP string for 'default' represents what the firmware had configured =
as
> the default EPP value but once a user changes EPP to another string they
> can't reset it back to 'default'.
>
> Cache the firmware EPP value and allow the user to write 'default' using =
this
> value.
>
> Reported-by: Artem S. Tashkinov <aros@gmx.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217931#c61
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 8 +++-----  drivers/cpufreq/amd-pstate.h =
| 1
> +
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fda8f86c90e0..5bdcdd3ea163 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -282,10 +282,8 @@ static int amd_pstate_set_energy_pref_index(struct
> amd_cpudata *cpudata,
>       int epp =3D -EINVAL;
>       int ret;
>
> -     if (!pref_index) {
> -             pr_debug("EPP pref_index is invalid\n");
> -             return -EINVAL;
> -     }
> +     if (!pref_index)
> +             epp =3D cpudata->epp_default;
>
>       if (epp =3D=3D -EINVAL)
>               epp =3D epp_values[pref_index];
> @@ -1441,7 +1439,7 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
>
>       policy->driver_data =3D cpudata;
>
> -     cpudata->epp_cached =3D amd_pstate_get_epp(cpudata, 0);
> +     cpudata->epp_cached =3D cpudata->epp_default =3D
> +amd_pstate_get_epp(cpudata, 0);
>
>       policy->min =3D policy->cpuinfo.min_freq;
>       policy->max =3D policy->cpuinfo.max_freq; diff --git
> a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h index
> e6a28e7f4dbf..f80b33fa5d43 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -99,6 +99,7 @@ struct amd_cpudata {
>       u32     policy;
>       u64     cppc_cap1_cached;
>       bool    suspended;
> +     s16     epp_default;
>  };
>
>  #endif /* _LINUX_AMD_PSTATE_H */
> --
> 2.43.0

LGTM,thanks.

Reviewed-by: Perry Yuan <perry.yuan@amd.com>

