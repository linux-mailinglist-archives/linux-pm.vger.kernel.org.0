Return-Path: <linux-pm+bounces-8474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AA38D633B
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 15:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CEA1F2300E
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 13:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21BB158DAE;
	Fri, 31 May 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eZNrQYXT"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8FE158D8C;
	Fri, 31 May 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162835; cv=fail; b=iVH38kZFFEyN8A3VzGSvNjAPgpLwNOwL+Ki83clTAvaURvtPwGLvjXMEv9cuIEm3RsZ8ofrj6D8iSdldEvJQJjBgyv82sVXhMtBqAmIOinRKPzyaGsBJlLEH6WnPTontTfiBQWv7jn+MBxBp0paMgqRrzeEaoph28Exd5bBTMIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162835; c=relaxed/simple;
	bh=srKR5NLslL/Lz8nFevdViuiAiL0gdf0CtMAnVegvNMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T1+9dewNk7WjryS5jAsdTDoy0py0xgi2A38Kq3kNgozkww8NS3lED3g0k9FcZnuhYqdt293eKbHFxkZ+OCExiJ7WkQDZBo0ZGaty8mgOMl8wkoDt9QmEiCu3llh9qGJAipvfF9Vr6ssv67EW1J74g/mYIQtizVtISpwfCP0NG2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eZNrQYXT; arc=fail smtp.client-ip=40.107.104.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh2890WWMiq2QFkr5YzDZIUgQIjunyCCgXXy+4pwK5LnvtNYrr1qNSLKjIaZs8/I2eWbphtjeLkaIJUiHurFfKJtZ9e43V53pDfqVDKJPY+8lEva70bg6lFzME2yXT20hbbpFyG2vZKP445J7npR7PniRieNKeN8UySoGXMaj/ZH5pyIsfwkJ/j56T9dT2uUspU4Seb7zxDEepx3+iMfILZw98nbECGbNetD1enNZVSHj7EXi5wu5KlAsAnIL5UVdOJWPNZ4pub0n+vGyhW7gvh6eFw2VVYwg65fKik7a/le2eKhdnXXgzIJog4xnqHiWSnqePNC4gpAvTlxoD4/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYAFrrh6rB1bbKi0FHmUwzowu1D5ABTMi3ad8V7lyaE=;
 b=m+d8Lin77vA28iY2WcAnnyGnNFZH8GZA1RKfxG0KQFDP6epZ0zOIRuP1IeQJW/ShZQyUM+vRChJkTc5CBvpBes+sphuPCbZlvs5Pb7VW8JaqtktBZ7wpj02cI0z2rmu9KGHGNhreL1rIKqLaYVEI+cRJTkbw4JZlcSWCpcxwYPVtRejD7kx1fXmY5dV0Wps9Mo9AV9rDgTQV8TunPrjeqd2bj6CiVQRCHaC8TzgneEloK0itfvS5oKvlnJ5zO2varQDK/jFJs738gOgv2lNXZf6Im1H30pUykulbMQezrBHHuZa3VHGEn5TbQYmXwVTWkcEJeXzFh+G/Hyp2w2fi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYAFrrh6rB1bbKi0FHmUwzowu1D5ABTMi3ad8V7lyaE=;
 b=eZNrQYXT/RLLeM36A61GzIRyU2yN4IdlGdnW0/kxKriOJs9lUwDQkLBU2uIMhdnLlVepw+j3PfZAaLx7K0IVaRpvnSm5QGbQWS8GH/XC4N+K6XuP9Qt4ezIFtOKugivpFDDjmFtqtJLlqciNvhHElUQt/lp0a8f2YG087ecOZ88=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8207.eurprd04.prod.outlook.com (2603:10a6:102:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 13:40:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 13:40:29 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH] pmdomain: arm: scmi_pm_domain: set flag
 GENPD_FLAG_ACTIVE_WAKEUP
Thread-Topic: [PATCH] pmdomain: arm: scmi_pm_domain: set flag
 GENPD_FLAG_ACTIVE_WAKEUP
Thread-Index: AQHapgAh7TLh8NV8Y0GdOhRV6GmZb7GxdDCw
Date: Fri, 31 May 2024 13:40:29 +0000
Message-ID:
 <DU0PR04MB941726054DCE44141995E37B88FC2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240514131833.911703-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240514131833.911703-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8207:EE_
x-ms-office365-filtering-correlation-id: 653a4374-9db9-4b4a-0c31-08dc81773ca2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PY453vFGQTlD4pl/oMBYYhJfWlAhESqNhagcW3aR1+egpLc0l8HFhiGBWM/L?=
 =?us-ascii?Q?YCUdfoQ5Rg1W+5/9T6qH98j+nOhO+EYizLZ02zE0gsmdbaiZPyhsrMpbodr+?=
 =?us-ascii?Q?9djz2DoVri1Bombx5dx6wLPCfbNOzacBC9i6UumfdQh2VTI8KJGkMxvlwIvy?=
 =?us-ascii?Q?rRfQPcPdpoeS33NKGzOanmGdTW2wO5ySS8AONf2HhQXMnDDvrlY6D3c+F034?=
 =?us-ascii?Q?WmAaFQtsbGEjGts8FtGm3h8d8yAZVdL3iOleeNZK1wozThlKVCLM6BbGTmv0?=
 =?us-ascii?Q?kZGFCQVxMffkVvhCepygEnwNCE9BL9tdg4FDKks7TTQyJF+q6yiAYBdjh1Ii?=
 =?us-ascii?Q?ujvHxGGcEPRLsi8gZ7deOx+VIlCoiQdMSbyi8LqmE5WATUUJt2EXxeVo9+b2?=
 =?us-ascii?Q?L5xpKtMFR1kzuTsoJLNaYPqgrRWelMRJmw6XoNWHZLujsGChB2lFo3r4dpAL?=
 =?us-ascii?Q?qwVVaRxJVaV210X9VUxzKUERAhFSTKKnXmjgX0yLduquhF1DxiCAlekRCx+M?=
 =?us-ascii?Q?TnQ8VBa3mgx6UZKYjBTx8FlhOBViktiJQ11hZFyf3jThZ9qAAbcKod2/iqjN?=
 =?us-ascii?Q?KVgKOYOHDDoX1db0qvwyQ5pSKn26L5jRk694YdGdSHxNLSvvdepgMEXQ1t+1?=
 =?us-ascii?Q?C9ZQ3YZ+MA1ScyjSWmY9By29u1FHrUJ1B+pQGFVnc9Jv3QG6Yc8nFLJGToXv?=
 =?us-ascii?Q?L1UHrqkiZfFRzSX8y2EY7WMFjyfTpDq1fEvoP/THfONR5zna7LqpmPe5ARyc?=
 =?us-ascii?Q?yLxO4B4XKN7VB80nrL/RUAP0lLbPpaE8LSvxG0wk7qfmG7CYj2Yz4xff/QGV?=
 =?us-ascii?Q?w5mUnEXqkU56UEUegKsTUXMQ98jKPUhOGqjs2Z6+gWPBtGFB9x5INChQ0wV8?=
 =?us-ascii?Q?7w2O4k9ZbujgDjqte/aV/kpgBrnYBktjYoiaL44VynOptAHuz+HAHZe0e35R?=
 =?us-ascii?Q?1Apstu/uggrXqjhJ9Nj2ypPUtXNl+iW9x+Dh4QTO2iimu2WCYw9LzikrzAbw?=
 =?us-ascii?Q?JPpZD+THtdi1hw2S6YsE4svNiegkqeONCW9RE6pqN2WxbIisqW4TSyWM5QzK?=
 =?us-ascii?Q?A7SxW5ma/rHdE9csE9RPmTv7i5AFhJKW2DNijuUjgL98fKM1N2xoiHxdkjHB?=
 =?us-ascii?Q?CNB3im6aZPj1+kqbyK1Yupt9YqwPOv0c1QPS+xC49AXPaq8R2ENcgAq+MzXY?=
 =?us-ascii?Q?7IXWD2DgU9BgtsX90hWz20Hr2cCsyh3NSsRA6BLOhmUCLPYcyTrE9G9aqNlU?=
 =?us-ascii?Q?eGuohN8p/jT1PLbgexpcdcZdtSrNA2FHOOjKol5O83YfkKzi5oIEpD0WuzPm?=
 =?us-ascii?Q?rJj55+KBFD/RlLqbj9XEOiKuKu1RRgRCEfI81fee3zGvdA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qokV3esMWX6OObis/HkxuDcdv1JRF07K7m1fyvqiqLgdoEdJr9+zeOMKAHaZ?=
 =?us-ascii?Q?WApZOwpm5+SOaYhmIRTIZ+tw9M+CJ/2kS/4yCGL3H5Qix4NS29V7jHz2R71T?=
 =?us-ascii?Q?RIsDoD3S0e6opJLecMjYPsBOmz6wK4R4ANgmm9r1UKSYj2rwSeeIkh/QvQrY?=
 =?us-ascii?Q?Abt/u9IvG1NgmLClsVnFLUnCsPjqS0BDPYLfKdrM+PDiy54kSbFebw2sddzm?=
 =?us-ascii?Q?ilz9GK05zIPALJnzF3XEVzSUTROnDispD3H3egLLwEKilQkOxztWHLK9ovTA?=
 =?us-ascii?Q?prwKKgtUfQMGTlduGVGh9Xtuet7KrIAeGVKwbRmTz4/RdIRWG8SoG5j4S0d5?=
 =?us-ascii?Q?PjRIPTESrDI2e0YRwTieBaLxQTZexVjqSf168ySbblO3rySR0Dg02r4msg0b?=
 =?us-ascii?Q?U8YorbcE2ZC4o1NzifvOVwpGHhL4TsyaKAQ2dVTijd/2VnSNAeuG3O1bFKlx?=
 =?us-ascii?Q?lmgNU8lRH/GIlLwIshxhSYlye42UFRJ3DjwX8ETAXWav90FIe2q0XZTvKl0W?=
 =?us-ascii?Q?ug3xBbNaeY0/FfZktU6rQvqAub1LleWk2i1xe66WgUTxT/XRvt1sfbird01b?=
 =?us-ascii?Q?91W/evDtywzq3KtfWXvAfq6efWgZ7EQ6V5eLVdO1Uod277iFadJzO0DVihU3?=
 =?us-ascii?Q?rumgNVQhlIWApn/M7aDJ5sjhQahewxNmQRLBXwFPx1HJnW6/bxTcyRhI2+TO?=
 =?us-ascii?Q?CClIezpKejiB0yBOKkrEIfNojM8EjsTstx0SbZz6votB4DTqaMxS0LDdF3ye?=
 =?us-ascii?Q?u5NhBCi7gyUr1Ds7rmUZjukXYPITC5oq/PN4rAGazJiqj6U6Kh0W9B+EETUC?=
 =?us-ascii?Q?C4Ctczyew1m/zZzPcEcXbjJ5JamhFV01pi0KWixOICXmPIgUtvxLvShR1Hgp?=
 =?us-ascii?Q?pHq24GY3u+2A7p0PUh7vl0uK1wd2pZbPr2Awgri7iEi8VANfU0ESFlgDz/iw?=
 =?us-ascii?Q?OsKa4GsV5zUp9fFdStC9fxYbuKsiwmUQDWJqVX9/EP+B96FEiHrd5Vo7Htb9?=
 =?us-ascii?Q?72KxKvVa8ifszH8jTES4DQbt9tqT15XEC2agyOB+w/S6vMlxhAivVZv7t/zj?=
 =?us-ascii?Q?zfYNhA2Hp3LL2HbX8kji8iwlEMNqDWMKVYk7YISyqDjzYNJuKXcALgCqR4Vb?=
 =?us-ascii?Q?EF5+d4T92X0xTkx+GIQAfd8jMaGiCFFfEoR6Sy7EwKeHAQfoG3E1oRuXcpq8?=
 =?us-ascii?Q?TSevG3KwECmEFXtRxwylDVZ8rKa6hYXeKLii/Ehov8MR6SO1lIEp1vvsJZvI?=
 =?us-ascii?Q?MKCMhj01Cy3/nzhEOtvtXLF5Ji5c9UIsPYRshtkUD9K/tWcEV0Mn3Odz4LMi?=
 =?us-ascii?Q?EFE85BEMGVmhJpxkv65RtsIafqUZUKwbRFPljaRsTawvL+JBWHDazKvoyfr3?=
 =?us-ascii?Q?FZFQAVLCwyXFljWF96H+wHxf0HE93lw7eT114OziCiWvFpoeGxvZitUj9e+u?=
 =?us-ascii?Q?x6MOUng0vKNMdDM6ls03R6g+2lEVbMiAgQe/5ZlmXvZey/TrReCWm00Xk7t9?=
 =?us-ascii?Q?BPwwF0uXXWUAhqu1f6kAF3bIYWCDSMKPTVC3LiR8F278qEksKIHbofnErkm/?=
 =?us-ascii?Q?PDSQzS5Gp5LFIFfqA6w=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653a4374-9db9-4b4a-0c31-08dc81773ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 13:40:29.7711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5bA1XVzk3LhlLatP6pusTLOrh8Y+gubi7DAN5uy2sYoYCbWtKd0uEPXNpVHpnSgCp8HnxNXF4eipthKbIX4XkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8207

> Subject: [PATCH] pmdomain: arm: scmi_pm_domain: set flag
> GENPD_FLAG_ACTIVE_WAKEUP

Ping..

Thanks,
Peng.
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Set flag GENPD_FLAG_ACTIVE_WAKEUP to scmi genpd, then when a device is
> set as wakeup source using device_set_wakeup_enable, the power domain
> could be kept on to make sure the device could wakeup the system.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/pmdomain/arm/scmi_pm_domain.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c
> b/drivers/pmdomain/arm/scmi_pm_domain.c
> index 0e05a79de82d..a7784a8bb5db 100644
> --- a/drivers/pmdomain/arm/scmi_pm_domain.c
> +++ b/drivers/pmdomain/arm/scmi_pm_domain.c
> @@ -102,6 +102,7 @@ static int scmi_pm_domain_probe(struct
> scmi_device *sdev)
>  		scmi_pd->genpd.name =3D scmi_pd->name;
>  		scmi_pd->genpd.power_off =3D scmi_pd_power_off;
>  		scmi_pd->genpd.power_on =3D scmi_pd_power_on;
> +		scmi_pd->genpd.flags =3D GENPD_FLAG_ACTIVE_WAKEUP;
>=20
>  		pm_genpd_init(&scmi_pd->genpd, NULL,
>  			      state =3D=3D SCMI_POWER_STATE_GENERIC_OFF);
> --
> 2.37.1


