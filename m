Return-Path: <linux-pm+bounces-7796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2AE8C4DA9
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB75B22882
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 08:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABF01862A;
	Tue, 14 May 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l+sTuJkT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3491317BD2;
	Tue, 14 May 2024 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715675047; cv=fail; b=dzGfts4KIgQD2b/eKWUY741ohkcGxSBIckg4wO2gkZwy68fNfXoTn6RNJaOrXqq3dXT4tRpv/2kVPnqLyi/Leo0EXTCMsyJwMJvLVt3LK4SZQWZiy75urcgXWTQ7vMZBn0CHeJcwkDUCAfTKQQK5R/mpECaKO32+nSkS1An4m2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715675047; c=relaxed/simple;
	bh=iLWZECNgMjZKFC+vm/p9HRoP8NnU3ufnaHmHbTfFi14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P968fWZr8buj1RUCPWf3P8BGZC2fY4Vxev2X7uu6tIH132NpM3yME6LpcCO5rRI+LrTmqjv90UCx4QTww2iblgucoJrPou3FFPVyt5ZZPu2Y62kN1rF4TaIonk+cZM2XIJSysxCM23vqVB/9LFWQjsvaMkqRqZn1HtSyi31vBY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l+sTuJkT; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=innOey4DQxew7b218o3VO6qZ4cUkBuXUJ/AwxbJOOMa4n7GQ4XzVTevtTJU6ha/TJ/70jEua6snEXLZ1rwRxdbRqmgl860IlEBkp+fObEIKtb1kscN/UJJ6vgiSFVg2NsXU8dXGJMAcjbVztn58wQ0rKFBpDoJSvCFCrFIE+0t4y/ny4SkwKnAC5PHxef/kiOrprxfStax4ZxmOH+b2pxaPiQj5GYI3pRl8auRK3iCqb91ae296d7YKG9ssqkciN9QOEOw8PbRZZ4F0HsxBAPIKcl9hg9KXY2LKsJOzYSCWQLVQfstdl6O7LUdcKeUrvd7mKGC69+eKBBTA1M1PFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAfJMZqVQ2vX8qw2mM9nYBfzAoiJ9HwLth6fswI1aqE=;
 b=Pi/HcCtVFIz37RNrAGyETbHXuCJ/FgPFVMfyEOdpwy6M8HfTB6hiqc+56giONN7S1GaiEK5IKPcI1ktYScA08NA5N3n0nHMikpCrwWcSjtpNvGMMXFlPqhdd9fUJkJFqVBvRrrQFINq06dquzARQOBKWPB62mBdrETxk4Mg8Hd/LOAVFH1DfENr4qJonjSoHUhocDJDPkypk7N6+OsqKmb3Qh5qYGY7kAdshXv5zESvYwLI4Je3UVPBE5aWCJdsJzZWTlL+Ao6t8cULxV0YC14rpwcl/9SESV/UXlSkyUfFq1q+W+78Ubj0Siqjqlg/H+125PveiNMsQXhElqOXMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAfJMZqVQ2vX8qw2mM9nYBfzAoiJ9HwLth6fswI1aqE=;
 b=l+sTuJkT/Qtb5Lxqs2NgUh8RxEyojIjjNWo4+kOYaVgBZYm5KEceaMZdEJVB+2IVxzo32AhHz8L+Ud8L1330mv5crFQhqd/ptqWi+gcsRI0ARqarqxmTu/QFnkjYuif/vBe4eiTE9uaePIrMQ3o4pyWochE3KwN5tyOB54m/yO8=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:24:02 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:24:02 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "zhida312@outlook.com" <zhida312@outlook.com>
CC: andypma <andypma@tencent.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "rafael@kernel.org" <rafael@kernel.org>
Subject: RE: [v2] cpufreq: amd-pstate: fix the memory to free after epp exist
Thread-Topic: [v2] cpufreq: amd-pstate: fix the memory to free after epp exist
Thread-Index: AQHapcohLUw4ziXiGE6Ecaw1Y44u67GWYe7g
Date: Tue, 14 May 2024 08:24:02 +0000
Message-ID:
 <CYYPR12MB865591A37BC2582E247D0A1C9CE32@CYYPR12MB8655.namprd12.prod.outlook.com>
References:
 <PUZPR01MB51206C1D9F3E2005B5BECCBA92E32@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
In-Reply-To:
 <PUZPR01MB51206C1D9F3E2005B5BECCBA92E32@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4d401377-1f34-40da-bd43-6e75a16ca611;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T08:14:34Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|BL1PR12MB5755:EE_
x-ms-office365-filtering-correlation-id: 2f0209c5-3f28-4f4c-2663-08dc73ef363f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bJqZ2pEyBu8oLVHEMGdrAomFB8+sUtdpjyiDaujyvV6emuFxclEGaIIKf9JW?=
 =?us-ascii?Q?JPWH/WHXx4Qc6BzJtvjYKUC+dzFKYUj+ICuxApoLaXDSLsGXsDRWI14F1OfG?=
 =?us-ascii?Q?Y+KN6HcT1+LC72YkKDrbCmhjZtSo+3Vjqki6aPc7PMLf2p1L+DgpyQbbVdYY?=
 =?us-ascii?Q?+3jqXZ+ujSkid/jJDbvRIoADdgxUXA91heOOjIYUmc1F9ejRXyfpWSyJx+31?=
 =?us-ascii?Q?3gGBqpsLi9GvaBXTFgoTj7xfKjvEDVhjP9bEgGH2I3QdAEABoqHRCypQxzlO?=
 =?us-ascii?Q?c2EJ8fXWWpbOKBiNFhNrZ8bSIPA7UT2pWHmiJgjfmCjes1rIRcrT78U+oYsf?=
 =?us-ascii?Q?Z7lLqoi+jq0++U1FPnMiAiCnS1KxPbjIr2SMNYz82WpVGp6fddY3f2Al61xR?=
 =?us-ascii?Q?mljAZ4HlztKbZV1EHl977ZWbuMAvoI51X8VKF3KIoV7tGeMZUk7OOLHOaLnt?=
 =?us-ascii?Q?98t4UMEzJTYtZP0UPfPN7H1iYgRoNas6ORpNEzUm8w8rdGQIX3DzCy8kDQ+K?=
 =?us-ascii?Q?ve4J/mgy7xVK3XlgcSOouFVOIQ2fenyFIK0qgLxG8zctvKI78Jn4MeX9tBHS?=
 =?us-ascii?Q?8OBdvhNRqn/jBTu81Dp7c5qZerXnP673rCSgcTFk0ze3+JJubWdF30SNiFA9?=
 =?us-ascii?Q?SHUcOiCMCPHeuTHxk8gmg+uLCjsZjzCsu5/0WQ4FsYXHHhI0EfkOQtDrGZ9e?=
 =?us-ascii?Q?wMNbkq6c+WIoO7kO/EK4afkqL33dm73S+pjkp6EyDUMZTmJvs+No/vISQ8n0?=
 =?us-ascii?Q?6DA6WUujfxqoZNzi4vKWcwsctxsbw/WxiTL5inkr5BoHGI6dj2LvhaPt9cMU?=
 =?us-ascii?Q?L94bRM7yKISmUjlVoHAoKghDJFcwBx6xc1jNA6pmOgdAekfZwpXKVV9RZdGG?=
 =?us-ascii?Q?cF7InNWYgL85NdyJDC9oGeYukSU8wYAfIXXmZLxH+td+wPaMYnRgbLKiP0h+?=
 =?us-ascii?Q?gLRnO+b5WUgWkI1ksFlArn8OGayuA9idH6RwZIUEIqKRnd4fWIaq+5jpRAMJ?=
 =?us-ascii?Q?RwzIQqq8z5HU8YRfmZM+7O1+/bBH81Pz/zrJ/q5D0M55XUqgeXmqLYp1Jc/M?=
 =?us-ascii?Q?sj/+uZzjbPR0nC0rSDgvwgnw99I7apVyRVBzladZOYzniDjSNMw3dVnpM39M?=
 =?us-ascii?Q?BfKvtw+LN+swqF2rcJQ+0Ex3Y6MCMMw/9Dppek+OLBGjRLfyhqbM3c+FBZR5?=
 =?us-ascii?Q?acRlLYM5wRIe5Wyj7IsNbDldDQ9dZLW4R8ggTd6LGQjFF01Cj9LGjr8YuY6s?=
 =?us-ascii?Q?CddK/y6uGzm5QkT9D1o25cHDXbtDe9HkzMHJxinoqZIPCMFxhOrQUDSa1rdL?=
 =?us-ascii?Q?ADgf5Qqq5Vt6DiLaU9KyzLMOvF6df83laEwIuk5bp4ELcw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?55SVp5Njf6wkgm2kpQOraX6rT+47qlZnq5734uOVBsjRcAUK8ZFvFlBNbdn6?=
 =?us-ascii?Q?Z0PPI763d+2AS41NHOHh4Yg9vJ3Mp+QiF+p85rKvsOdKdlbaH4gjGL/fep1b?=
 =?us-ascii?Q?GJTy//1aWDXwcPNDjgh1SU657dA5ORE3gMlpvkm7VvONUgrNpU+FpGTUL05U?=
 =?us-ascii?Q?MzKImLb9jQpTUQrCEFgj5fyfKOrfENSamYX3+80Ic3i7Gs7y5uwW3W5TVvKX?=
 =?us-ascii?Q?KhBJ+DqzcMgccZE+Qua+O8fxVEJ1CUXrezHa4Yt0a04DQWCgIvU7mr29UhwN?=
 =?us-ascii?Q?BCPahE0wwNIdYbnl6o6xaN0geAVE1EMY64uo48hGxz2IEYPw+Xp4vCDTaNX1?=
 =?us-ascii?Q?lfB51iIw6LbmeK/tVV9w31vMzFkF0/0qXZ0pK2G2uqt2FHDnOCEQ0uhWR8Bu?=
 =?us-ascii?Q?qIwVaPHcsuYvYW8poEgjcqrgE0y/RQc94ZFcJF+yvGdAmVSx09ojvD2p6C7b?=
 =?us-ascii?Q?xHw5/btHD+hSRGDu2mfeRFCVEMW8892bFysl8fFRlv+akYxjcVYrUl/07XJK?=
 =?us-ascii?Q?5MDHAzqE69pwjroGqAABOLJh+XnnK3pt5A5Pkn8Rh3OwhCaETzf334UpK9LS?=
 =?us-ascii?Q?6rqjbP48vq3SyDAzJSDAsLJYt14Y0YaQul0THRm6xmE8HALDUXIZ/RosBeB9?=
 =?us-ascii?Q?d/JAbQ55uf6QI9k5c7KyU2VJHVJctXNo6iJ2oGdZ26WpxC5Kh37IQPQljlZx?=
 =?us-ascii?Q?fDbC4ZXdftYWTW7vsd6QLr/n2SpqJ1S6HNbTcFzbgtbIMNFum1EYTUYOmzH8?=
 =?us-ascii?Q?oPyPHTY8p6mhMg6iBuW4iYxKtvZ6QOSZJC7SPwEWJ/62iWllwy8orDNNa6m4?=
 =?us-ascii?Q?/freh30P9h3xZz4eLThkNh+n+d8RJBL9HUBLtWc9pkGZmaK9LJJ8qkiA6MH7?=
 =?us-ascii?Q?0nHCo53Y0ZeTd8PsEC5jh5Z91cOpbeRyKioKMF6KLb4TciDWcdrE4jUne58q?=
 =?us-ascii?Q?HgYJCUSvy/P12DJti0VqMsPMpmppBcbcJGkp1+YeYlHlfMxGh5TePdijJ7Ji?=
 =?us-ascii?Q?CXrNcTji6O+sAdC1lla02pS2pWRh1S4JPAGSmmfATND4cU8sn1GqtF7YpNk0?=
 =?us-ascii?Q?CwEXLHJIltvIc54omg8XNm3+M+ELynfbfxPd02MQtYGCmOSJmSQlT50wo4ma?=
 =?us-ascii?Q?DVE0U/N1BOMTCOHUYZZ5OADRqmRLQfxC45TUTHO/fxwOMsb9NLOr6Ug2958X?=
 =?us-ascii?Q?zuaSZReGhigw504wGU2U6olKzSboptLwm91hs3nx12SSyi0IZ2yZIyL8Xu5t?=
 =?us-ascii?Q?V9bHcqSBSMv42ZfPHjOgGybyrvErqtqXnF9ZTzXsrcQSwhBZjoZkBneLOgNU?=
 =?us-ascii?Q?L6i6JcXpVDQbmBqDK98Lid24XxG3SxvDoG+Ln4feYquk1pK2rMJ2smSYJiLr?=
 =?us-ascii?Q?PPK/HcFhh9RWTZN8Wgjby5/lTzRuIcEZyfyCUelAUEyXoFajLFDxHK4oPH1k?=
 =?us-ascii?Q?o6JCTHGLrSZCwODQRBZ0RF4aFiw0voo1JCE8uzkB0H4XhThexEInsHADLFBx?=
 =?us-ascii?Q?8R83RZAo3jW+qsqb5FBrSSnSV3JT2VKX2dX0/9AVnM+lQyJn0w6lLSw66GB0?=
 =?us-ascii?Q?FSQ3ID7SW5rtja3Y0PY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0209c5-3f28-4f4c-2663-08dc73ef363f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:24:02.3707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyZDTlDDVlLFWryWcCBTT4n7WQjlnCPuCUfGXN5ty9xXYU3zEnIiCa7gO5An9c0FxNw3dl1FHys5rI93aeH6hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: zhida312@outlook.com <zhida312@outlook.com>
> Sent: Tuesday, May 14, 2024 2:43 PM
> To: rafael@kernel.org; viresh.kumar@linaro.org
> Cc: andypma <andypma@tencent.com>; Huang, Ray
> <Ray.Huang@amd.com>; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [v2] cpufreq: amd-pstate: fix the memory to free after epp exist
>
> From: andypma <andypma.tencent.com>
>
> the cpudata memory from kzmalloc in epp init function is not free after e=
pp
> exist, so we should free it.
>
> Signed-off-by: andypma <andypma@tencent.com>

Looks like you need to fix the format of the `Signed-off-by` line in your c=
ommit, you need to ensure that it follows the correct format of including y=
our full name and email address. Here's how you can fix it:

Signed-off-by: Your Full Name <your_email@example.com>

So maybe you want to change like this.
Signed-off-by: Andy Pma <andypma@tencent.com>

Perry.

>
> Changes since v1:
>       check whether it is empty before releasing.
>       set driver_data is NULL after free.
> ---
>  drivers/cpufreq/amd-pstate.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6a342b0c0140..e100c5b6c9b2 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1441,6 +1441,13 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
>
>  static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)  {
> +     struct amd_cpudata *cpudata =3D policy->driver_data;
> +
> +     if(cpudata) {
> +             kfree(cpudata);
> +             policy->driver_data =3D NULL;
> +     }
> +
>       pr_debug("CPU %d exiting\n", policy->cpu);
>       return 0;
>  }
> --
> 2.33.0


