Return-Path: <linux-pm+bounces-13897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCD6971DDF
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 17:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CB5B23411
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78EA136350;
	Mon,  9 Sep 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SxNpG/HH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1133A1A0;
	Mon,  9 Sep 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895028; cv=fail; b=KmomgIEzAIZ5pl6YYJplBxE90TZ1SYfKA9gBHTd2Ap8qaOJbqDQl5FKnRakuKs3IZAMMOib+PIGg+dmqMjWKoAWrmILrAayOOSmvEVnZGCpQTaPipxdeSKnfUi999cm9jRaICtL+H/Ymh0veXM5n+qUiW93x132MTbGNUMv8dlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895028; c=relaxed/simple;
	bh=TCb68lAcbPilzM6lyXyGIBo2qsZHfN6C+deDcXyYLj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KbiaYRz37BXHhaSXFdn+fwhDCVNevNPOrditnJLPDpq90hvQUdVL79LeO2QXsjHhfPFrM+ChTbD43N5Lcas8/p7bsExHGnxi/RjpQ8NdW0jIE0cJNDtiTfGz13lxmQggYnYe18acT7GiAcoYSw4rnDdO5dRSKdiVYZf4Qe50RE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SxNpG/HH; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJK1GJJOTVebqSRGNd0vcQLbQBFjFNzOPDcLF4qGPcPziqiEdaicqAMirRmSM4Q8pXgxirgMnHhenmzmYrMQ28ju4DsvkwOfHZfJ4Zxgruf5SyBrIHV1V4X0Lt5UDg+9IA0iGZ7k3WMERbHps7kxnG1omejWvbGaYwunqMyxdAb1OCyxjfQaSSbkM2x3B01Y7Ejsrgq5nrRB0LcwlRzrjrhYaIENF/D2+TYqkmWzH+9EUGIjNAAiU/eVotPoatiNSeYGb5oQk707892Tv8MXl4FBKPhdGK7g5angM41yj5I+KxZRj8H88/rmEHYEcR10Pt3ssNwwlkq0cXBi+Sdnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIPgWrgPxGx5zTc2LbSYl3pribb7pwjlahi9F/1RzWY=;
 b=gkvgoU/4aJD1OPpgpqf1A3JDlsUy4l5momxCqptGgRzoUAsqL6/E1I0By11RwsVprzSZbPZGnTmCu+zXkIwMuD6dcXFfsrxnOG7jx7ngyL20TkZ2nFJP342Swt6jqs1Wi3V5wz4cnU4x5L38Bi5RnU7xiG4Z/a1tRgLkmWI3zpqVyyFtlzp1hnyeOLCoYC+7BRWybTa8gHtsOXGisvzEZJJfB+wKGOm18xpEhl6B1SyH9IVtrgUVjbrMQUIH17b2A7GlMOQMUrFx692lIMZKcjTxwddnAqWkSylLPl758wVvL2a6qvmi2dwNb3WQcI9e2lv751esI+lRDfTM1iv+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIPgWrgPxGx5zTc2LbSYl3pribb7pwjlahi9F/1RzWY=;
 b=SxNpG/HHbh54vBtsQdHq/DHv5/AGmrrcRb8Iyl3D8luIQIDKke5CEG2NnsbCQA3M1xXE6VL/a4FAIRnuJmKphA2xYuSmao1Vojv9a24XiSIvOUpdod+8InuzfvNRClQzgPKYB0XNRjJ5kj1XxnE59umRYo81NxDSG+wk19PNWbU=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Mon, 9 Sep
 2024 15:17:03 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%7]) with mapi id 15.20.7918.020; Mon, 9 Sep 2024
 15:17:03 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Mario Limonciello <superm1@kernel.org>, "Meng, Li (Jassmine)"
	<Li.Meng@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
CC: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
	<linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING FRAMEWORK"
	<linux-pm@vger.kernel.org>, "ptr1337@cachyos.org" <ptr1337@cachyos.org>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 1/2] cpufreq/amd-pstate: Export symbols for changing modes
Thread-Topic: [PATCH 1/2] cpufreq/amd-pstate: Export symbols for changing
 modes
Thread-Index: AQHa/BmWxETouG6G5kCmJ8XyZrg8QLJPnUgw
Date: Mon, 9 Sep 2024 15:17:03 +0000
Message-ID:
 <CYYPR12MB86555F70EDD7113FE09842459C992@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240901024912.1217014-1-superm1@kernel.org>
 <20240901024912.1217014-2-superm1@kernel.org>
In-Reply-To: <20240901024912.1217014-2-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=765ca54c-1c1a-47a1-aa33-8e9c65f9a3c9;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-09T15:12:52Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM4PR12MB6158:EE_
x-ms-office365-filtering-correlation-id: a84e2181-0083-4986-54ae-08dcd0e27579
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Yj57C6sVjSLAFTfywXvXVKRmCz2fDoLPYGPZEJ/rNum3qAy6wlkhn2ENicrr?=
 =?us-ascii?Q?mJ16IEhzpwc/C/vFEqWOwfKeSxyBPAPq6hT8yHVEG1CR1BclEdYbkCcN7TPf?=
 =?us-ascii?Q?/CDTwfeRdlsSHARW7ZfOuuOjrnWklYTPyEtzaQGue/EA8/lrxCf0hbaT8S6Z?=
 =?us-ascii?Q?RYP/yWc/SGU7Je4tkU7skxuSxe69YVZPgdxMaN4FZAuDQzaBEsSKGD+Rcrdb?=
 =?us-ascii?Q?MfDhA3dVH6hx9lVrmkCggMaA/Q1LJyerKQepIhduW5021J/uSp5KmfQq0YNa?=
 =?us-ascii?Q?7QD9TtOnDZBtANScraGSpEHdTlAcwlV1gShbm9L5l7P9EBFIZ1u/wK7O+SQm?=
 =?us-ascii?Q?kok0F6C9vgqX1tQ8L+bjhXicsjlzX7ICn5Tt6oZizNx4/hbOVgwTJKewjhda?=
 =?us-ascii?Q?24bLQk7B9x3klaGg3juIO9+A/eiCpsOFC/7OxUeTcBSZ5uoiS84APfr3vzHK?=
 =?us-ascii?Q?YISw/W1KQErCQll6hdrleW9HkWFhkFrH3Z/ug80CJucCwAz5CrHKfuFDC9QR?=
 =?us-ascii?Q?Jt1nEX4NAmN0oh5AMcD1PvzLOfU9cpFbt0LfRFtAk85tYELMTODX+waAQMDC?=
 =?us-ascii?Q?Ofe71atljiLY+sO15vl0F1Z6gNfz63u1RG+TRF/ePFRyeL/qQeh0+DeBp+E4?=
 =?us-ascii?Q?0xIYFmYRmG3tQo5d+QfeIzBRdX0CzJ1l4wNtHIddLd8thRGNeXJAY2vKz3iR?=
 =?us-ascii?Q?EmArtQ8w8kmLcbi2jywwJ4+dY2Itzp/26J53p26nj2IM+wQsmw+O3zdC4CTk?=
 =?us-ascii?Q?JplKSph5ecGXGStBB6eubAvFtspavklUqAuh7wQPqzJwCZJIgF2857Oy5YPS?=
 =?us-ascii?Q?8uL6xp65p4iiMWWaS8xYjcuMi/bXZMKoWRJUxaC1j8avHWjS7oNLbnKA6KtS?=
 =?us-ascii?Q?kpUwyZEfHPN37+CB6UVF8n2u+tnUxGrz+lwuanmxV+JeItJRsRPmFwk/04xA?=
 =?us-ascii?Q?sQlDrbEtn5TtTa9gux55WunzqTciJXLIywgFYpROiW/a87rv9WuJg1tgURSE?=
 =?us-ascii?Q?gbqAn65SkPJBcrSqXUcHHZaeg95V7F6CYtmeQtP0FpEZjTQrYl+IzHJGTCQB?=
 =?us-ascii?Q?T6gGC7L1A+m+HRBnzMklVrsAiPE389IPfDynyr6hxdlIsZqRHahV/pLcvaOU?=
 =?us-ascii?Q?airBCQlQtaeSqKA8zX4uFmfjA1Y3ujlbnbOkdwogwAphAyKvHJY+dN093I+c?=
 =?us-ascii?Q?mOhv+W+yx1olKiiDE0H6aUzq2/oMBjjMolfbDlv9KshXsgH4YgEZD/TNs4Xo?=
 =?us-ascii?Q?u2y/ZDqHi92T2/VZyrv7/HMzKnmzi1xlnA1pN2FPZ5tz3ydzGrGLAiJuUwcE?=
 =?us-ascii?Q?7XTtBj9ZC5GAAna1HEVTSjYQb0vldPGAAneIvSndGxTWiOyyqxRIUHu/Rp9y?=
 =?us-ascii?Q?zWpzL/uHIuWcpcr5j9ghn1Ko1RwvcRy4kkQyW3QXvJsW+B9UsQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CdQMETL2HcjUItXIVUXoGoSjpt8/Rs/vapCzgFDo3HJg2yJ8RNLnzr1yy5+L?=
 =?us-ascii?Q?dWvH/4p3/x/Sredi9N1USIM1N2pw82VYJlUWuGvXnzpSPspAMVXnXp1A0BHU?=
 =?us-ascii?Q?VjVhzVORUznkZP5bHmRbZKFYaFm8BPbOVNWNsYazd8Hlzi97Z5+NQnUchf3Y?=
 =?us-ascii?Q?oFvJY0+EgtyElpWlrL+F+9x/+cPIf1XiqpSRTy2GjT4Z6caLDBwAbckBTomR?=
 =?us-ascii?Q?EqllOMxebEHrzZwm1T3u3C/crhMlTgFsUtYnQtHOMaOWNWYIbqpJ3ny9SSiF?=
 =?us-ascii?Q?9I33c72DNkQEP/K6GJDZYIXuXeN7YBHvrSvNzqESFWJ8QOuqBwzzc3RQzIvj?=
 =?us-ascii?Q?X9ExGnIyl+aDqEOKhacmvKLMI50Tpulo1yBOpgdR2HSMthyaON9lBnhLvkRO?=
 =?us-ascii?Q?pJbQBLqj5M5IbMn3MKcdVJy0Bpd8ijZ7fY6r2GNDrEwv2TaBWXNxNNHJ7Wab?=
 =?us-ascii?Q?DHwrJvUsTFPiE1c4+Fb9rgRtO9Uz/mRFmUzB07YGLfHNv5U23M6bMQVdoj2b?=
 =?us-ascii?Q?MKFoFHZ2V1U4vst5KmmTnAclx8JqDgX8RTqxwxMk10t5MwSZYi8q3X2rBXnO?=
 =?us-ascii?Q?Z7K/KWKq5u7QWnAL7+rujJ6aKZZZ0TTAtDl5X8IPWSf1Xs4AF1zZHFWxA25M?=
 =?us-ascii?Q?2NwCsd+vSdg4LOj6iHv7zQRP8HC85PvJ3S+UNhL5GMYB+7UP9WXrO4ZoGVCs?=
 =?us-ascii?Q?vbXEGgkfPvqPqGarFJQD1Xq2LMwkF8dIt6kES0zO8emJ63ei/SFWqWzcIL8s?=
 =?us-ascii?Q?PiE+m8ZZx35jtukfLINTF4PNX1sbT75tvzBJUnGYHtA8hu8MZv3TVkhZOeeH?=
 =?us-ascii?Q?lT03JI6XhoB3poznFQFk1ba04u9q5+Ce32PpQZWnf86UQqGzj4sp7vi1kpbZ?=
 =?us-ascii?Q?aj68BDcA/w275IDeJQd/5+ByFVsDSXiWcGR9aCOTkZNioVTfxKfriXzScjir?=
 =?us-ascii?Q?5fsiXt3ubawUgzlBfegzo943XN+mLN53qs81ZMHw8TlGbmUR9ennq1OeuKns?=
 =?us-ascii?Q?7FMkbdXmYTJtGhSdEyK86nP1rxWl3kcPdyP12cF48gbPn/IH0zVSAWXpUq+2?=
 =?us-ascii?Q?D0KfiA6JwD8ot3NotF0696tdMCKcO6H8FJY7g7wDsQ9G1s+yzO6wbclGzwy0?=
 =?us-ascii?Q?WFv02cAkzoozCfjj2MzOm04OhL+aaNFXv5gOduDMJPlOLPlgm8ciU35sk2oj?=
 =?us-ascii?Q?H/p0gKwYBklx9y3cNmDX819AEbbSeKIQamrrj07DYLkNIGrUP6uIaNXx5v1z?=
 =?us-ascii?Q?hm9gsQ5imaX9xqEae6xA7plC25DZmcAb4qZYrX+9j1ig3XrzG0gNjDh+Q7J2?=
 =?us-ascii?Q?L6XtDHiQfMz18ZFuoDCjVVengn5iHYO8bvQYGsGGrlY7QJodenbY2XsCEoYQ?=
 =?us-ascii?Q?X2ivdkFWvEF18J6hvOyGiITgh23MzVnQjCtSoIraayEv/HJia0UfcXNeBNqH?=
 =?us-ascii?Q?olAEpHPpazOAACUnfNb5/Zoi5F3xbhj5LBUMvTcCGXOSYM1jdVoVwjFLCE5e?=
 =?us-ascii?Q?s+wdvQ3wmSN59cjfBYGvNl23ljNSA5He2rJkYAb9d0mC2n2g2so1K1PEXAJj?=
 =?us-ascii?Q?IWGWw0zmlZvcejOY/sQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a84e2181-0083-4986-54ae-08dcd0e27579
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 15:17:03.1631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vG4u4TTABvOi99OhF0/313g8rfmRLR4wZ457+l9fbdLroVB6XVfd1nJ+oMCbG5voEXrtSET7hzbz5x11jMOMJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Mario,

> -----Original Message-----
> From: Mario Limonciello <superm1@kernel.org>
> Sent: Sunday, September 1, 2024 10:49 AM
> To: Meng, Li (Jassmine) <Li.Meng@amd.com>; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
> Cc: open list:X86 ARCHITECTURE (32-BIT AND 64-BIT) <linux-
> kernel@vger.kernel.org>; open list:CPU FREQUENCY SCALING FRAMEWORK
> <linux-pm@vger.kernel.org>; ptr1337@cachyos.org; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH 1/2] cpufreq/amd-pstate: Export symbols for changing
> modes
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> In order to effectively test all mode switch combinations export everythi=
ng
> necessarily for amd-pstate-ut to trigger a mode switch.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 23 ++++++++++-------------
> drivers/cpufreq/amd-pstate.h | 14 ++++++++++++++
>  2 files changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 073ca9caf52ac..93adde45bebce 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -60,18 +60,6 @@
>  #define AMD_CPPC_EPP_BALANCE_POWERSAVE               0xBF
>  #define AMD_CPPC_EPP_POWERSAVE                       0xFF
>
> -/*
> - * enum amd_pstate_mode - driver working mode of amd pstate
> - */
> -enum amd_pstate_mode {
> -     AMD_PSTATE_UNDEFINED =3D 0,
> -     AMD_PSTATE_DISABLE,
> -     AMD_PSTATE_PASSIVE,
> -     AMD_PSTATE_ACTIVE,
> -     AMD_PSTATE_GUIDED,
> -     AMD_PSTATE_MAX,
> -};
> -
>  static const char * const amd_pstate_mode_string[] =3D {
>       [AMD_PSTATE_UNDEFINED]   =3D "undefined",
>       [AMD_PSTATE_DISABLE]     =3D "disable",
> @@ -81,6 +69,14 @@ static const char * const amd_pstate_mode_string[] =3D
> {
>       NULL,
>  };
>
> +const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode)
> {
> +     if (mode < 0 || mode >=3D AMD_PSTATE_MAX)
> +             return NULL;
> +     return amd_pstate_mode_string[mode];
> +}
> +EXPORT_SYMBOL_GPL(amd_pstate_get_mode_string);
> +
>  struct quirk_entry {
>       u32 nominal_freq;
>       u32 lowest_freq;
> @@ -1352,7 +1348,7 @@ static ssize_t amd_pstate_show_status(char *buf)
>       return sysfs_emit(buf, "%s\n",
> amd_pstate_mode_string[cppc_state]);
>  }
>
> -static int amd_pstate_update_status(const char *buf, size_t size)
> +int amd_pstate_update_status(const char *buf, size_t size)
>  {
>       int mode_idx;
>
> @@ -1369,6 +1365,7 @@ static int amd_pstate_update_status(const char
> *buf, size_t size)
>
>       return 0;
>  }
> +EXPORT_SYMBOL_GPL(amd_pstate_update_status);
>
>  static ssize_t status_show(struct device *dev,
>                          struct device_attribute *attr, char *buf) diff -=
-git
> a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h index
> cc8bb2bc325aa..cd573bc6b6db8 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -103,4 +103,18 @@ struct amd_cpudata {
>       bool    boost_state;
>  };
>
> +/*
> + * enum amd_pstate_mode - driver working mode of amd pstate  */ enum
> +amd_pstate_mode {
> +     AMD_PSTATE_UNDEFINED =3D 0,
> +     AMD_PSTATE_DISABLE,
> +     AMD_PSTATE_PASSIVE,
> +     AMD_PSTATE_ACTIVE,
> +     AMD_PSTATE_GUIDED,
> +     AMD_PSTATE_MAX,
> +};
> +const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
> int
> +amd_pstate_update_status(const char *buf, size_t size);
> +
>  #endif /* _LINUX_AMD_PSTATE_H */
> --
> 2.43.0

LGTM,  move the amd_pstate_mode to header file that will be used by UT test=
 .
Thanks for the improvement.

Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>




