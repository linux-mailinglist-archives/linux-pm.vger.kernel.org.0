Return-Path: <linux-pm+bounces-23759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D81A59212
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 11:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD37716DDAE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 10:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7961E228375;
	Mon, 10 Mar 2025 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S/Tfn9tg"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3CA227EBD;
	Mon, 10 Mar 2025 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604217; cv=fail; b=sxVt43APtWmBACk2Vkj8MLUb4+SnJdSVuTUzFKI1ztSXHGgjpdRfgNuycqccKkF0lttxvSd3D7BK20TaaAr0aYet8OeepnoEV0eY8K0BCSC1BFgD5LTIotm3jUf9i7TfuPZPaWrboFqJ/UKKIeh3KhU/k/d37n+qB1FwXfQ9X0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604217; c=relaxed/simple;
	bh=yarb/ifwkK6RUjH7iSGygjm5leUjfw8WhRkhBOV+gx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n81Z5/qEyGl2o3NJhuWq1H7OLcTkqln6S4u6LCMEmubQRgucLmyfHvdI5udiwhFy1b46P5HJwDDwb83JY59cH+O4xA1jpeSsnckqRDr931cuBRkVsHCo06hSBG78xbmfjz4e/V00Q+upth6pPB8SDLMnaJWboj8L2UndoRzJMy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S/Tfn9tg; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sla51hORuYDw4G0yZFubGq+kzeq5w8c7HBJRrW22jbHiY0XQzxLnbXJPd2CFn1+oGWLEh29pkj/bevzIGlzGsXOzqhPZzn8xbzuMMhWUEcy9mrnJmYWPCsnOa7hlUaF4covBMiIS5ApfZDKcoAU9/HXxNQ03/alXoobMCoRvGf4dVJvNfn5OnUuq7A30gfvbZNJXd4uphriMjXPXS37wsreIGh8dVZIBTOilqY5J7lDp7VMnXN2z5znDdT9eIhJGLSgkVQm/On0QIJcB3UK/qG6NOd5uHcpmsuADkjjiASqBnPdm7vKxzYlmReTm3u6bm9zc5NRl1Ns2VBPhMhn53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8QCEbidivs62TNVVeNI8FCktNvGNzYTPMl8RvvfpgQ=;
 b=UrP4+l/yQ7UpSRD9J1bDnv6/QN9n2gGJIRfToRVBw9vnaDpYh8LTurtKXIAfc/P3Ye51pLgS5cjIeMmRyNZL4FSnIGtWbtpv+QHWU/v/OlzIdHFkOBFhNvRpR/MDOZEdiat11WbySldK4lZvHpAwXEpRZDnE0k3YIG6lVerv3sCh7FejO6ECU+Cwfna4jpxGvp9WS5Bu9ZU8013Y2JwZ53Hjsi/AsUHvF7I02tBDmANLxUL+DMkny6xZtOg4v9nQhrOjynf/Nv0zcWhkNFj5dX9tsgpJBmmiw0F6Es/2W5FV580thBZ2YDNhpBc2xnIFNGPKdnCBL3j3NyCMk0iufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8QCEbidivs62TNVVeNI8FCktNvGNzYTPMl8RvvfpgQ=;
 b=S/Tfn9tgYWhLDlH5r8ZQKJ4t4ulaKD9xmoIMWArO+Y63hbpjdZB4G1D5dNUQh7Bf8EVFz3PfpM/UlF/zSk8iiMmgBDzA4jzxRSxtGaxIY3qjlOCLuydFf1XcmL7K29Rj0BbHbeeHH4U25C8zPMqGobdg3XFF2e2aYFCwJT5UWTNu5r+kK2c9/am7TcWjuUm/h6D4E/vRjrOn0ZhxaYcRtnVkVkZqJaqKeR2h4tabwC3GsJ1AQgBD+HddOEk9VwpltLNHp9RvJ1/Pre1sL6mS2IEQTM40KWLZNJYy80tgWC3WVrnEVE9QwTraOPseADzCCmbe5O+RSrmcyM7S7hKLcg==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by VI0PR04MB10343.eurprd04.prod.outlook.com (2603:10a6:800:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 10:56:51 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 10:56:51 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "ilia.lin@kernel.org" <ilia.lin@kernel.org>,
	"tiny.windzz@gmail.com" <tiny.windzz@gmail.com>, "wens@csie.org"
	<wens@csie.org>, "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"samuel@sholland.org" <samuel@sholland.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH] cpufreq: Init cpufreq only for present CPUs
Thread-Topic: [PATCH] cpufreq: Init cpufreq only for present CPUs
Thread-Index: AQHbkYw2ZuQIz/pnWU+zV3EzH4MMb7NsKM4AgAADc8A=
Date: Mon, 10 Mar 2025 10:56:51 +0000
Message-ID:
 <AS8PR04MB864253339F818E0FC0D9982287D62@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20250310071640.3140435-1-ping.bai@nxp.com>
 <Z868xB3_3NhMsa7R@bogus>
In-Reply-To: <Z868xB3_3NhMsa7R@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|VI0PR04MB10343:EE_
x-ms-office365-filtering-correlation-id: 26d77d62-1fb4-4065-8ffd-08dd5fc2433b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hqCEDC+1iNzBjK1OQpfwOL6B2HRed3kV6UmA75B89gU44RBcC04IhU2W9vv9?=
 =?us-ascii?Q?PvEu+FwPmL8YZrGnmfSFOFkgss7n6qvX67Ug4M8EQB2b5QU+Q/nCZVtmF9Pg?=
 =?us-ascii?Q?COZcujnxDyBSqU08d7Y+kMzSSdWg2d/v4g7xUz92G0vMseFkoXMsahhbqDik?=
 =?us-ascii?Q?dXeBu/bIoTBWzkV815CHD0BBbOjwogw4M4Z6N21g/i66yDTD/oiBaa0FB+6C?=
 =?us-ascii?Q?x2nZiJ2LpgvwqEKy9tJlcleG+7VXULZaZrEN3AxDDL/cH5jnJAaXUGKQawB2?=
 =?us-ascii?Q?KV8qWvIZrbLjE7vw6KnHCai44Hct8jvjhlTmfybBfoNNTJwIJdWNrQuCTYhl?=
 =?us-ascii?Q?E2GfTe/Wm8Fna/j0hP03BYH5htLJVCNw9uFAZD0wvzukpLpXyn1Uq0LPUUvj?=
 =?us-ascii?Q?GNq7lmLdJJBi+Dpw7qnLkbKixYRPkDf9hXhU8IL77lPXNisDWfDB/uUk0U23?=
 =?us-ascii?Q?nYh2IHKT3rzMF/ZxgrFMPpl0ZICC/1wMdTKZLhzJ+9GEAvM80NADwoAItcZH?=
 =?us-ascii?Q?9UiBELyC7tBCUOKBAf00/5f2cF7YQ+qRczUrTv/gOqkRxhtZr+Z+hwaVIzy3?=
 =?us-ascii?Q?dgTL/Np34hBtCQC98aaVbQQ87mzft7tVJVGEobkunfm37NZojte0cJXFkvzA?=
 =?us-ascii?Q?spH7n6BkPq1I/uU1dx2SWM5K9bRezstzq5W02b1S1dQSEUYPBZsWWQCg38QG?=
 =?us-ascii?Q?rLTgS02zr86k2sGSfvCFB+EI+rSx5W1XQirbf5THMTluUSZ0is72fO3afriu?=
 =?us-ascii?Q?SvnLaiho+DSIaCE8UejArFveBQcyop+jUuAju6TprUcz74atP/uO/NX1CsTL?=
 =?us-ascii?Q?VL/3+FfEhBL6B/DVcLm69ZmdUewvvw2f41AjG1q3UdfDcZ4trnDH9mGLwhov?=
 =?us-ascii?Q?jr1+qZOPJVb/R+bBXh0VQ2HTsqUTQ0YZbXbjM1od4/6GVOw7cgq+2aKKa0AF?=
 =?us-ascii?Q?ep0XBabLNzi3sdUu3WEo27Dzyf/f8QBw5gOwK+svU38Yr0PlrDvy1MerXNLy?=
 =?us-ascii?Q?PyRePAe10HqDQX7rG3MmtUtAe2E27amnnWeGwtUwIGN0lJScEmAmzKmQfC4W?=
 =?us-ascii?Q?GyAOEdIQHnlrgFprMUqGdtDiy7F3t6nj8DV0z7HfXMWY/4YhWIPRm24YIaXB?=
 =?us-ascii?Q?s9KzisAfQgOM9c/a7fnGZY5nnFAdkJvrLtMJrG0RUvDjVwxcbjSTQTzHxAeL?=
 =?us-ascii?Q?sbOh5crg01NDY/pahvM20j6Uyw8oSK+N4nXcTRGhKw/hLs6CjoiUyWhDh/ku?=
 =?us-ascii?Q?+3Pwuei+sxUQ4cksA23zA97i4PQwYqeSkPfrkryVQBdbvSBfe4u2ySWi/cua?=
 =?us-ascii?Q?acA2cEDkQGUpPonkn7XpeFQRXdtfDvm7EteuSG5/kNh+RitQmkQhbZjVQAzz?=
 =?us-ascii?Q?W0zVNjohrCwBwDV+vhUcLcE9Qm0EGJinsXFDZ0BqMMf3qYJw5yknypwS+HCn?=
 =?us-ascii?Q?noBUz/HIPB618iV2Dn+ZCc/hmnRvA16x?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PKhw45c8R/wIjAI07C84GnRMclAQ1wcEzPuDFZP63eDchybFj6KDfliZ4Ca5?=
 =?us-ascii?Q?GCbhxbGHpPO04L8V9DxyqjpzHdHYQpfVLKXqvGNRqja0YMeOLv0HUJXRREwz?=
 =?us-ascii?Q?8bB1jtXq5zSgU/ApkAdnqryh0cU8ZMPwGXDx5I+5Z4JdrfbiO8vLVL+F8WfU?=
 =?us-ascii?Q?z36g5xWNUddk87c+Z4LgS2xmeJKDJzXSdbTa/iLEl5Hr3EcpLDPTUAYYf+q1?=
 =?us-ascii?Q?b3ZvJqIn9ny7J7LAYVBV7vW5nVWhxgIkyXnw44BUnKdieWoar1Oter87l9+R?=
 =?us-ascii?Q?D9vSQRoKxbTsBwW9YuttgiTA7r5HrjOnDD3yDbyGyL/FilLVSbwnCLehnyKI?=
 =?us-ascii?Q?Fcjw2RMeZJwlNCbvsTYQl7dbM+5EMwfzW7FjKMio/ztPm8iaZyZeqwRmlk9v?=
 =?us-ascii?Q?Riu9qcyeU8ijnGM0q7khb9TrHfckTH2O3ybjYwakvtAbFgPTfgibPtE8uNyf?=
 =?us-ascii?Q?CRqfRXhoLWFAxgcBcoe2E9RrgfHobjc0a5jQ6dF6reToBNjdOPO1FNeC91pj?=
 =?us-ascii?Q?ZsjrhEfZDx6ATEa5lRK17LYFkcAvQbxqjAks92RZ68lnIhE44ZhBQzbjHxnQ?=
 =?us-ascii?Q?kFE/KbhPoBP/xiau8c5uz2SS3HcmkClduVXP+OZsXXgMig21VXx+57jVp667?=
 =?us-ascii?Q?OvLm1/px7s6kjlHMjYHp+PsvjfCzQK8dDC6IK/Bouvs30bcX7diMJ4ORVqby?=
 =?us-ascii?Q?1IpSzukGtnjClBWlv3ED+UWAdMq90cTJRc1wkqDwXO8jJzw7+zYKc3Ws+teO?=
 =?us-ascii?Q?WMg6CUJw4FZEyt2Kot88jCgQdodJpmAYY+awtHWdEtrrVczyiSP2tlauZDSD?=
 =?us-ascii?Q?bOd+u/AkEMIUhxN+KZ7YMzL1W94XkXH0Dy9IUuoyY4duYBJ31bXjmMg6No93?=
 =?us-ascii?Q?P1IkPL00SMzG8UIVa49J1pmj97ZSze4E4iXqNyERQ2WeS4JVs40KJUpTh3pb?=
 =?us-ascii?Q?lfTP4dSSiT9tZt5URECCYFvmajkQacqC9iPoqJ0V1rMqFuOJQ58rlApigTOo?=
 =?us-ascii?Q?VTfv81ivWdmT/WYwv8rfUT6PDX8rHEXxSCVPqcoLZzE13uygSR2zYZP57zTn?=
 =?us-ascii?Q?+uPf8muu60qgcv6TaFixO+HbFejug5uG0RlWid1P+Y5r068jjimzta4Hi2og?=
 =?us-ascii?Q?rc++Jo79hXoE1Ti/m4pE1SRuWGNdeHYB3kOesmHLjz5MQn1cMM0Hpjjmp03X?=
 =?us-ascii?Q?+9tBrGhkJvWYV2llbSVVMmwHlbkmDrw5H3KFxshZ6j8Vq9bxjoWIJeP789HS?=
 =?us-ascii?Q?N+qNJcjDXoWGQk65B7MoNSS2/Ka3rE9H21/laWmfFAFJ4srjLKJW/qSfz1G0?=
 =?us-ascii?Q?ytQzlQNo0pr08xRfVJ8fPq7GRjzW6URQRnvSrhPZXWlT+JK/93slEL0OzBEC?=
 =?us-ascii?Q?RkKWSE2dg+yenze+4qtuz0KGxjE9NBC+x7Rhx5mYNkKFETp4YzH6DuqdOGx0?=
 =?us-ascii?Q?foiVisJc+e9XXMZTzaGLxSPNE/DQ6Jcvtw//leQoCXGV1bBnRPjNrVXe0b7G?=
 =?us-ascii?Q?YYhh22WdaKjiEKEPXW+1tQIjR8qZorKGL8Cv3O9q26xwmvr3f8aZ0ZXnnQ5G?=
 =?us-ascii?Q?P6sbAgq4uz/j85njM+g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d77d62-1fb4-4065-8ffd-08dd5fc2433b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 10:56:51.2539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIOfBDqoiM/NBqri35Qq8p+Vw19UFp/kF6hqe+4hP6I3zx9KjYqxLANNpAGlhUBmC/tPUKFFXwzjs4vtalRjGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10343

Hi Sudeep,

> Subject: Re: [PATCH] cpufreq: Init cpufreq only for present CPUs
>=20
> On Mon, Mar 10, 2025 at 03:16:40PM +0800, Jacky Bai wrote:
> > for_each_possible_cpu() is currently used to initialize cpufreq in
> > below cpufreq drivers:
> >   drivers/cpufreq/cpufreq-dt.c
> >   drivers/cpufreq/mediatek-cpufreq-hw.c
> >   drivers/cpufreq/mediatek-cpufreq.c
> >   drivers/cpufreq/qcom-cpufreq-nvmem.c
> >   drivers/cpufreq/sun50i-cpufreq-nvmem.c
> >
>=20
> Again how did you just narrow down to the list above ? Is that just a ran=
dom
> pick ? As I suggested with corresponding cpuidle changes, please look int=
o the
> details in side the for_each_possible_cpu() loop and then decide if it ap=
plies
> or not.
>=20
> For me, it applied to the below files as well at the least.
>=20
> drivers/cpufreq/mvebu-cpufreq.c
> drivers/cpufreq/qcom-cpufreq-hw.c
> drivers/cpufreq/scmi-cpufreq.c
> drivers/cpufreq/scpi-cpufreq.c
> drivers/cpufreq/virtual-cpufreq.c
>=20

I checked these drivers before, these drivers has logic to check
if the cpu device is available, then skip the not present cpu.
From my understanding, using 'for_each_possible_cpu' will not
cause the cpufreq driver failed to register for nosmp case, so I skipped.
For those I just changed in the patch, the cpufreq will be failed to regist=
er totally.
I can changes all of them together as you suggested if no other guys object=
.

Thank you for your comments. :)

BR
Jacky Bai
> Please check everything thoroughly as I just looked at these briefly.
>=20
> --
> Regards,
> Sudeep

