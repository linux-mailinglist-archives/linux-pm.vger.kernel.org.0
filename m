Return-Path: <linux-pm+bounces-12115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A499E94F961
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 00:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E68B21045
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 22:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CCE187868;
	Mon, 12 Aug 2024 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="arPzzi1q"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811391607B9
	for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2024 22:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500540; cv=fail; b=WMVEcKIDCZ+Zc9N7owiqROIzlbwRQmMKzqg+3NIoKDc10q815J0tbLpAQGNOycFLhggXlZtTabT7S0q+V837tEtEj2stVVKIAPtcjkefFJuhoVXoN6CE2UcTLFF2pzYiMb50mqzXDhd8QtzsVCVTdXikFufvxPkLXm3pIxvGYkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500540; c=relaxed/simple;
	bh=mpT2aDU6wwNAfEwoZAQAW4chg7xsnYHt6RU3wx80H6U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M2sHQH8Ie1ZrW/esosSZmuWQC2MHe7zgMJVufE4Zb7lZm2sMwWn+BTbvZO02HH+wlcbOtjUmWctykHhu/KH8VldNs4GT9hAKhqMQ9vMvPz2np+2lsMypBaDp/MNyQzWdswch6xI/0iawOlAX28F5stonQxuHpuPV+tQ51ouZujo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=arPzzi1q; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHBQxj6Lwafg9shAeFHuLXqewnIPRRWeZjv9aAB2kszCJRo9jz4KoxL7vzMSf1hOHZTILvYhjyZjoWFf8f3tamtoxt4JxRDmZpLMK57WhZbvYFTWxIqBxxZkTaxO+wOjCLvtbTzKfNdNwrmh2KpR5NxVPJ8Pb6kNaHcB5r7T7B8v8/XPHAaiY4E0W6TGL1QcInhwVkaPOWGbAWQeBh59PpG0u/z7018MYuR2AVCkdeZS/5rgyftfhhNBrM+w2maTdCM7FWBXjscjjdRymIGlPIiCP6J+mG5uDjUIEgwYhrz2JKefQZn+HJQ+omG+xrbciadCYe5R7kpXAOtMz2OrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpT2aDU6wwNAfEwoZAQAW4chg7xsnYHt6RU3wx80H6U=;
 b=IwH2uyMTc3iHGCsKK8xrFdU+ND+tkpmWkvT4iZbiTdTc0fxj3tmY1D0bwp8T4pCIbFj569KiCH10hOmoL0hVNxIrxe4Ar1FycQcxZ0o9l7XiDrrt+YQn0LLDCN6ffLAoPancyQET8I1QXCY6WNRoZO4QbFS8e2m01HHpoGtWAvnzcvYKgRi0TWaR34fC1jecjeHzk8XwkhiFVZDoaO7XsLK6I7bX+x58pUtQWC8sLhfgnunxwAz6/P0tcLowbKKiZrrQk5+t1SmIjq/IYGSHzReIMTYaD5RzyLDkpvlohFcMzC0wFYVW1oLno6lZZdAA5FbXxJauiMIzN0WJiVUT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpT2aDU6wwNAfEwoZAQAW4chg7xsnYHt6RU3wx80H6U=;
 b=arPzzi1qQw8a92huQFiLWMaAVk6lseS8YeUXv/Xtbhb+/w+tZqoVUMOh34CUDGCZ8ee4jQUfT5aN//yAjB0L5dCa0ZFm6C037osOnYO4gcEpWVUOTgn4lrzIPZtGq3fbBYgA1PVbsTknVBfvHCdwl4dBewR9/djypN7jcRh9IwI=
Received: from LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 22:08:55 +0000
Received: from LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99]) by LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99%3]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 22:08:55 +0000
From: "Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>
To: "Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
	<len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: RE: Handling inconsistent power domain states with deferred power-off
 in device drivers
Thread-Topic: Handling inconsistent power domain states with deferred
 power-off in device drivers
Thread-Index: AdrtAYxKacvox0qfSC+sZtezUCzIxwAAXuhQ
Date: Mon, 12 Aug 2024 22:08:55 +0000
Message-ID:
 <LV3PR12MB9260AF7B9130F138B4675FE3E2852@LV3PR12MB9260.namprd12.prod.outlook.com>
References:
 <LV3PR12MB92605C42C4B7BBA277395534E2852@LV3PR12MB9260.namprd12.prod.outlook.com>
In-Reply-To:
 <LV3PR12MB92605C42C4B7BBA277395534E2852@LV3PR12MB9260.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9260:EE_|DM4PR12MB5961:EE_
x-ms-office365-filtering-correlation-id: 0b9dce07-2923-4c26-96df-08dcbb1b5b91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jdUVyREukp+FwghtxBszuKRDPqM1Dmkio7JfQuwbeximaZSeQIF/MKt7MAbU?=
 =?us-ascii?Q?ZR1Xjqpom0VIsWIsjntxeEoFjb8uA+go8yRpeqIwaaOjmFXVqT8dMBeZw9hc?=
 =?us-ascii?Q?9EBTtzGSHXRsCvBHF4lH49QNDzCJtkPcWQGt30M/2y0ylJraIV9aSaTIoEwL?=
 =?us-ascii?Q?A+KPRGZaMrX4pXOuGvS+asTvwCkM9t+Vi029IRagGEg3BsQZZrygMHeJYa/g?=
 =?us-ascii?Q?Ggdee5mQ+bQ6OAv1yYJwmd2MY5TWmwqSa2+lrQMd95BcaNFy6LkXFebZfl+o?=
 =?us-ascii?Q?MST9+5FWRr7HLb0ImPXj4E3+W+F2Xa7hCPtsNyCG+Q5PJQGYKdSgmK/GdR8v?=
 =?us-ascii?Q?7veKSvsE0TuT9bOUWN4Vd0VQC8nojEQpWLNQHqj7Ct1z4icGIKD1lRzE8Lqg?=
 =?us-ascii?Q?DPX02dgE0LWi8n3noje6Aknz4rr5hV3PgtEWYtffMw6CmDgh5OV39TesqLPT?=
 =?us-ascii?Q?Ipj2uBKUj9b9noh30rwJM4p13T4esUopTkOoPwjbAJ04Aqjzo3fGTyI3L6n6?=
 =?us-ascii?Q?0B6+CVXR9K6kOuSBrd3gdCefmz+0U6FBjEkhGKwJQct0p1UPp+7kYXMOyZZm?=
 =?us-ascii?Q?E1jLqmwu66tnPXWFh+lEa/Z9cFK5AHeXvo/LTsI6HQN2woYTiIbmBzxpIKNa?=
 =?us-ascii?Q?8oRL62xI32WgTTpp1y+csNVQFEqBqT5pjzfkMehq451LDHL5huydl5VdF3ki?=
 =?us-ascii?Q?aXOjcVaI77YQbncSTisFdvqGIrnE/Xh/E0NhUmFgFq48dk5O9FnDqAji1/fP?=
 =?us-ascii?Q?yjwsshdnX9fnvOjCCicvw2Zl+k0BPup+4XJQ7ThrYIidhPD/PzZEGTu3Lwr7?=
 =?us-ascii?Q?RSfPuuiikvxKMWweeR1UlKoCBtSDh63lHm1jWh7U8ktCkdyZ7M+xDqGMWtzY?=
 =?us-ascii?Q?04LEkntg59RMzpHeKJhWEfskmk8sCYDD7oX7kPrz8x/gLJZWEG3cyjsCxdiq?=
 =?us-ascii?Q?lt+TEbxgW9nM1z+usfJUocihgrzxIcAOcMn4w16++H9fxOoXfTxIxJKB7LHm?=
 =?us-ascii?Q?DXJC+Wbxf4NuXK1oY+CfB7xPquYb/wv9W6+olGnHdtSxPOSO97hqnKYsxe8i?=
 =?us-ascii?Q?o34PiUkgxnQL52fK8L+vikkbbcIbeBP9TB1KtDDVIukWymx2rdLZM37pJS/3?=
 =?us-ascii?Q?DE+CyQBLprkKG2WH9d4KqtM1gj+0tFyphBCVxNGDg9PhfpflGGAesmcr3M7q?=
 =?us-ascii?Q?9kLF/2XnElqMO6lmeFW5/NK/82F4BHTQGtJy3ilJo4xdQNaYeeRLniWsdofO?=
 =?us-ascii?Q?0KsIAr+h79Gzx9FgM4as3oQhG/VvNFjuSQ2QhCFBhQ1tXg7kmUf9DvDurK/l?=
 =?us-ascii?Q?Mdvee8oNevmA2xll64Cq5mpeBV6yB4j2xJzGfW10dJLHKg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9260.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iJfj1g0kL+agooF5oTk/lX0BVfGc6mrC/FC1tUrB0eXlFRJxbN3GD6keBJsN?=
 =?us-ascii?Q?miemubZMnOe5odG6vgJ5Ft4gtOu6FbokJ0mtm1+teKq8opD5ubR0Ja3xokti?=
 =?us-ascii?Q?Gtoh18s9/QM+8wYmSeUy2upRVystfcR1lnxN2XMs2gmnpq03IXp7apEnQA8Z?=
 =?us-ascii?Q?ntAHwRBhe4CS4oTT8GU2XRxemc98rtN4J0jD7T9eqlYNqtZjjUocNUpZ03fZ?=
 =?us-ascii?Q?DJdj1iM5iuVx38Uj2lX35yD35xZeCfoRsWcl6IMgqHvUaE/bOL9YLdcoQGgG?=
 =?us-ascii?Q?I3FQMAoP8gzaAYZKhX+0PiiG08LMweo/w7X7mHLIffYHXqxvKCatXZxrR0u+?=
 =?us-ascii?Q?wrxzxrpXHLbFHFncx80Tk4IFE07UojZDS1a00maXbEWvQJ2WWHJUTFncwr23?=
 =?us-ascii?Q?y3sQrNXcydwJv1CvLgg448BlE1Eqrx13DHO+zHJ2M7B1vmqMtDvdyc0TdAbA?=
 =?us-ascii?Q?SOKpODW48WhvrLPcXCbZ4Ie4kNIvQOibJJQRvGbaDvPQePJgO/anSQEzQ16A?=
 =?us-ascii?Q?emKXDU90lVqSV9VbLNpwIzlz9cIbh2xrni24mfAe/SfwGNYHQbqrHeiBM3jH?=
 =?us-ascii?Q?hswYJ4n3f0qyYxArzV9CuthYbXLxpzO6F+kuN6SGPI47ef4PR9Abv/JJcxar?=
 =?us-ascii?Q?apNpuK75nt/3AMxivvXwtju65yr9D/HYQu62etTrRKkhO65UVAAspLMQsHt+?=
 =?us-ascii?Q?CTO5z+mF+xnCe9MEJJvaL4Rx7XoxrjSSNe5qm6aVdnU1utCLPNhU4H42LAsI?=
 =?us-ascii?Q?TzitlbLj3+Q0kFMcoq96MgpKrDV7zHvwbudAOgs+va6a6++2ytqrRBmLZejt?=
 =?us-ascii?Q?JL+SRlk/XTXHpU8JDpxpzAu2PR7sj+neHitaT+ZbVo3NXW6ZluXgDlXBGfQM?=
 =?us-ascii?Q?D6wJlVS97hhuH2I2juroHTE200QVvhUt1V8XsPVDz7rInsEhk6MYQid44T/Q?=
 =?us-ascii?Q?eR1cbz4fE37vk7QlrxTIQjBhCJS7bsjclm4QQPqUKLQ9fIjCQGyan+CTJsKC?=
 =?us-ascii?Q?qitNImvpfYtiN61hxBO/aJhw49RnvYuLh03YZbOR6GJOcknrwgdiQfqwYk/8?=
 =?us-ascii?Q?HY2m/abnezeA4ZLcGnWDPaZwUhGolSrkewhnwJ194PmUahtQ8KzKEhHWM6Wr?=
 =?us-ascii?Q?K+gA3CdQns7qh4pIEN1iTtgzAwINnlJf2KKLqwbpUoudpOnUnj4JyPYbVtjf?=
 =?us-ascii?Q?RKWByufozacpmf19+ilyW5zEgiXuYJG/mcrVKZewX+B85/vlcV7OThGu18vg?=
 =?us-ascii?Q?fB+gjcSZouRmQJQvzCUXWzef5jEGj/bZ/aF1hKmnw92BQ2lxrBD0aRBGk+zc?=
 =?us-ascii?Q?swBUlHia8TFsTdyCrH2H3hmYwoQ/eZ9tbEgmVRaU4v3IzdJ5/Xk1lLl6W615?=
 =?us-ascii?Q?9TKZdhXldI1R8B8yUFUjrD5/58yFxQmGw6ijTSHUjj/Jue6UsEEqFEZf8xO2?=
 =?us-ascii?Q?+F23c1GPE9FlIfMfljmwodq1xMiv5aEeHm6uv8Om3ABmJ4TomUBLXp6aU6dR?=
 =?us-ascii?Q?tdOIsjDzsMOUtqVYAXcIvXKErIArHwPPF7HPyYT8UV/LX2Ow5YdS43/MaQVe?=
 =?us-ascii?Q?8dttPm9REmJRLcDX+mg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9260.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9dce07-2923-4c26-96df-08dcbb1b5b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 22:08:55.4333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qQBXDLUCzUFgTy63EXkBSDl2PrxKfnWTUeBgjH0lQvzCTST7Xy3ByOsqWYg+yUdaek7eePPPhWkU4M2eHQoMGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961

Hi Angelo and Ulf Hansson,=20

I saw you responded to some of the questions like this before, your help wo=
uld be greatly appreciated.

Thanks,
Senthil

> -----Original Message-----
> From: Thangaraj, Senthil Nathan <SenthilNathan.Thangaraj@amd.com>
> Sent: Monday, August 12, 2024 2:51 PM
> To: linux-pm@vger.kernel.org; Rafael J. Wysocki <rafael@kernel.org>; Kevi=
n
> Hilman <khilman@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; Pavel
> Machek <pavel@ucw.cz>; Len Brown <len.brown@intel.com>; Greg Kroah-
> Hartman <gregkh@linuxfoundation.org>
> Subject: Handling inconsistent power domain states with deferred power-of=
f
> in device drivers
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> Hello everyone,
>=20
> I'm facing a challenge with power management in the Linux kernel, involvi=
ng
> the AMBA bus driver and the UART PL011 driver.
>=20
> ### Scenario:
> The issue occurs with a UART device, where two drivers are involved:
> Driver 1: AMBA bus driver (`drivers/amba/bus.c`) Driver 2: UART PL011 dri=
ver
> (`drivers/tty/serial/amba-pl011.c`)
>=20
> Here's the sequence of events:
> 1. Driver 1 (AMBA bus driver) attaches the UART device to read the periph=
eral-
> id. This triggers the GenPD to power on the device (`genpd->status =3D
> GENPD_STATE_ON`). The attach happens at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers
> /amba/bus.c?h=3Dv6.10#n141) in the AMBA bus driver.
> 2. Driver 1 then detaches the device, scheduling a power-off operation us=
ing
> `genpd_queue_power_off_work(pd);`. The device's power-off is deferred, an=
d
> the status is not immediately set to `GENPD_STATE_OFF`. The detach happen=
s
> at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers
> /amba/bus.c?h=3Dv6.10#n203
> 3. Before the deferred power-off occurs, Driver 2 (UART PL011 driver) att=
aches
> to the UART device. GenPD finds `genpd->status` is set to `GENPD_STATE_ON=
`,
> assuming the device is powered on and therefore does not power it on agai=
n.
> 4. Eventually, the deferred power-off is executed, setting `genpd->status=
 =3D
> GENPD_STATE_OFF`, and the device is powered down.
>=20
> This creates an inconsistency: UART-Driver assumes the device is on, but =
it is
> actually powered off after the deferred operation, potentially leading to
> malfunctioning.
>=20
> ### Question:
> What is the best approach to resolve this issue, either by modifications =
in the
> genPD driver or through adjustments in the AMBA bus driver and UART PL011
> driver? I'm looking for solutions that ensure the power domain status
> accurately reflects the current and intended state of the device, even wh=
en
> deferred power-off operations are in play.
>=20
> Consideration I have is:
> - Introducing a transitional state (e.g., `GENPD_STATE_POWERING_OFF`) in
> the genPD driver and return error to UART-Driver when the UART-Driver try=
 to
> attach and let the UART-Driver return -EPROBE_DEFER to the kernel, so the
> Kernel will have an opportunity to come back and probe again.
>=20
> I would appreciate any guidance or best practices from the community on
> managing such scenarios, especially any existing mechanisms in the Linux
> kernel that can help.
>=20
> Thank you!


