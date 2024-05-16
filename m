Return-Path: <linux-pm+bounces-7884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6088C7068
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 04:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9985F1F2198E
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 02:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2C4184E;
	Thu, 16 May 2024 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OKow7QuE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3615C3;
	Thu, 16 May 2024 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715827737; cv=fail; b=aAlU0BNrrSzmWhWZ5jqBZbpdiz3FAau2GERXpQhazEEiI4DJr2RHXoiznQGuWscqGxR4KVexiHxub+KoshoHu20wwy5SBvgZ8bqblIRm4hIs9qrGBzcQWWiAo6+EBa05wJX7qOjKhILNu2zcxAkcsj1Hw6X4WEJ5aiYK9VpA4RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715827737; c=relaxed/simple;
	bh=lrEUrlK3p1Tn/cQAKjnPvj8azfKq3gbHd6Fsc97fbn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R5p8xXp631dVk3TVx2WCf8k/LoGHhlcSuCa7dDRPeTZuAfXZjGbyPuF4hOczcORdkaO8oKis+qeMpCtRbhZMp48HhxYEOuPMmCclGCwHE4ziBaYC5Jb7pa1SSMaRCVWJarnzOz72WQMefPdKl5bly+mCcgYO704rpdD6bXqSAsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OKow7QuE; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1PWncP0IIA8FMjar2vjicjKoZBa2oRhWqbc0a3XWuhMmRhAxOEOG0gkngFXnfZ3QssSUVqP1bTo7X+zIUR0AV3en5RaxaKOmARpMh0usxyyNtmanrCza0iVGcMBMX5WRzJuFVSEUhXZtCws9a74oSWGm7JeI/4C92DaEcaQFc9TSLxTHb8SkWiTV5bEHMq1J/wjqM4wJaNFSwPG1zR2HDBW7t9RiUFXQbWrqa5FfbWQTW4kL1uKp00xxgvRbHuut1+rtMP2/4WmfiUgo3EHsdwtuR62sjUWTdF8fwnvy91nV9N80/z0UTg0S4q5NECqwU2Tcb+01kMgW3UmQYHDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTgMbSuOfuxNZlHaK5zI34o191wJaZ0UmSiwowf9Cqs=;
 b=d1aReMAp65/U22zgvma5IOl/748BPrV4/cD4LQmcnQ5XF2DFUa3t079QmM396r98WugOFSNz0l1vyHk5gNruPo57cYGG+ih5GFjcyAEVAwpwN7ofljrR08caQUTRZsGj7kB7ekOvz+dybr9f0rOLZok92RDG+C75pKYF2T6WEalV7iazlgQcqCsY5MOlCZAV5BgJOvWj6jERIuZH+mrZK0M9epg1bxswOmNDXXx3Xf+RXxQwwPBG2/H5xFrY7sAPnoCnDzeQqTl5om0xlI0s4leyE+hvp/eP+K4qJaHyuSG0EtvVtTu/ecdh/rM+cjRDa51D/9auIdOp58tk30nA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTgMbSuOfuxNZlHaK5zI34o191wJaZ0UmSiwowf9Cqs=;
 b=OKow7QuEe9dVKmSju57h+9QuLLzlHwt9Lp97M9Iwofr+xwtgsOB0JKi03cJUlbrn/ZmTwfgJbeTkOpyITJEPOdzMic5E9SP1FcPmWIvCU2b7znzVHFxbKVT65E1jlLb0uzX0x4aDK6ldvTR2zO2fK4YEd10dV1ZwUO6Tr9YQZZI=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 02:48:49 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7587.026; Thu, 16 May 2024
 02:48:48 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "zhida312@outlook.com" <zhida312@outlook.com>
CC: Peng Ma <andypma@tencent.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "rafael@kernel.org" <rafael@kernel.org>
Subject: RE: [v3] cpufreq: amd-pstate: fix the memory to free after epp exist
Thread-Topic: [v3] cpufreq: amd-pstate: fix the memory to free after epp exist
Thread-Index: AQHapnNS2Fs0k0Uj1kCoPfk5W0R3R7GZKPvg
Date: Thu, 16 May 2024 02:48:48 +0000
Message-ID:
 <CYYPR12MB8655ABCB32C6B11C6B382E649CED2@CYYPR12MB8655.namprd12.prod.outlook.com>
References:
 <PUZPR01MB51202786825AA6A93383B7AD92EC2@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
In-Reply-To:
 <PUZPR01MB51202786825AA6A93383B7AD92EC2@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=48993ae2-5ef3-4cc1-9a62-e1f708bf4b65;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-16T02:44:15Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|SJ0PR12MB7005:EE_
x-ms-office365-filtering-correlation-id: 8363829d-ddc5-4582-e752-08dc7552b675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PcT4bxsds4pnVSSPmkznSJkGWj0y8Dl0d6TYKJ5ojh1JzKjBREfAcQV+XEAX?=
 =?us-ascii?Q?79P8ZogZ6LHukATbuOn/Ul8O/l9NRQsPse3SPls62rv7BXZfA0V8UivuDIvo?=
 =?us-ascii?Q?Juyk8PmokqTbNfC3Igo9RTc2SLc2xqOnuSexXOfnLzhVU5e0MNDMBEtue9My?=
 =?us-ascii?Q?mUFpsKb94Yng6cHzYQehuC7113BQtIVNsnKFtoNVrw76P6diOTjHAk8/zy5V?=
 =?us-ascii?Q?jVuyo44cTRbrQr1+pubZZeFIDeV0/8ehCNBd8E1+E+FukI3VUj5enMmEbvA6?=
 =?us-ascii?Q?KRab2MhxvxoMOhrE5XiXuMFLcfUjYalMV8/abHvSqtxmK0Vr14cnFl/ARmm0?=
 =?us-ascii?Q?DN4vCZRP/fqu7Ie3A8fW44JuXKcBzx3e0Mdw5jBJ1HTsqapHSy6trGmfYp4m?=
 =?us-ascii?Q?RhPFVvhnblY9Fz6HDzF0MMW7sgAh5LNMF+4DHncsHXKTjiu7EQfXZ0l8Gy4b?=
 =?us-ascii?Q?/qg4WxHMSLCbpDgk+RskLUJ9k1p5RO1Yd2MGYKt/4I60p2BbFHLPpF7106Lj?=
 =?us-ascii?Q?1g2sB/wRSK+N724AG1gDzDcOpYjPSHQPt2AH7Wz3z7bZzqzwhkDofXvEU8kI?=
 =?us-ascii?Q?KGnerthcZuUBIaMyLlaslM7zHCqcf6Wg2TpuQtwZpYn9/cxaOroBqsSkq/IL?=
 =?us-ascii?Q?3LqKKi7QMubvggrEXzu5hQ4o2ZTUNMZh11xwNulpjbZH+5bwyOMKUbVbXN+9?=
 =?us-ascii?Q?63IWeXL8cu7jj2pysjUwdpDOf82HNRUzf7HsBnLx6ju2pAtYp0wmTzxvrkZI?=
 =?us-ascii?Q?9qdgvf8quUIOz9OFpnbB9HxWt3+8JKFTu5l5JQyoXvm+ogMySzERyo+t3WT+?=
 =?us-ascii?Q?csGDN6CmNpqYgKgqsZvbwteRPRShB8T+3ddR/xqe2ssiA/efLA1toMfQADKA?=
 =?us-ascii?Q?IzSPOk9tcvnUE4urmnVNpQnwZbvMOpcU8/bHvz551fxVXwIQZM8wZLKloA7u?=
 =?us-ascii?Q?T/YTLm0f1gqJj4Qj9/V9H/6i8D92malYMUcpTrv41Dwh3EQc88brYV/N3+L9?=
 =?us-ascii?Q?x2qKh3cu8LzIwaa6OpHWEh8hXw5RFfTTryqRK7rNK16S/HaqZhW5BVPFk8c0?=
 =?us-ascii?Q?dfMdDhR5/5ECZ4kPBDdm2Oh0OSc/qz5WdakmECC+6i2clSj5Sfmg19VmF6+U?=
 =?us-ascii?Q?hYvtLnez20ZYiuMwjPqu0dN8xjYXwRlAKNWjaFCYbGHqextBhePyR32JrsCY?=
 =?us-ascii?Q?K0Acrlj+eYqFgoRJ3VxT5VxTnBITwJqVgRitaeaStEPIgCT8o6UpozsXdRZC?=
 =?us-ascii?Q?4KMOZP+AWOnyQsPTjAB+nRQdwJMYnFG8/S2OwKxhuyQO+89WOMTEbnWLgou7?=
 =?us-ascii?Q?88Q/tXHVjPRejxHwJK4zE1cp/h9XEPgHS7vhrxItIehW9Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xo4TRhvJIVXdVK3ciNGfDLKN3p4+L/Ex+JKhN9VTIW7IeLW77P2ftxOMQU1N?=
 =?us-ascii?Q?Q2qdEbKSYqAA3V3VL/SDRKJsbEfsYJOdxB93rJ03+z7r8SeOrX0+ivuab7Vl?=
 =?us-ascii?Q?lBYvPppILAkAnGxU3YxbhwA2HCkukxOzb6wSsUvpUevlhHBf91YXYqdY9QIG?=
 =?us-ascii?Q?CKyPUVe6QLEIrQgz4hBxWDvdzyQ1JUmQdP1JZVhp3WggKJeBPN+EZykHF63+?=
 =?us-ascii?Q?sSnu6w2FLZlYUw4CEEryjWorEODW535yn+QHbi5C/krDKs4DHfmR7UwTlHDL?=
 =?us-ascii?Q?NIDPCQ2a9Cu3gNajzUUM3DWrCxF/s5VvDSQvbDj93BeoIS8/qvwi2DDtdQIc?=
 =?us-ascii?Q?yX/eO1Gbd75OMUs25luDPTOcoeyr1e0xvLajBqj8doIiZOmHWWFpyj17Vsdw?=
 =?us-ascii?Q?DV1Hcb1R+7ZAIwr2c3gR/1cY9Eg+InKhRNYO+91nPR1a+fleG4+jcJdgL5Ih?=
 =?us-ascii?Q?asGZWTAA33QkWxPlw4irKBStOrgx90r+5aJGjSV7zb+FE4jzZw7DBmKd8x8R?=
 =?us-ascii?Q?x66F4NYKZdZCYOGWb+nbl1utrfuq/G+q9iwbmBRp+oCWw/wTkgyUflIm8RuZ?=
 =?us-ascii?Q?i2r9BONGDjH0D5PHGtKDNurTSuAy00ikXmH4/I0TO4julyPygLgzfBPuJDT9?=
 =?us-ascii?Q?dYv4VZNXgcq3L59+hLJZWM2jgGSKz8gT5O2skZvq+JjNvMrLbVEbuQC42Dq/?=
 =?us-ascii?Q?xsp1BLl6F/pEkKd2XB0C9pE7r3CxpvA4fzVLRr3n3x0mxd80J9VRY/5omwIi?=
 =?us-ascii?Q?/J0i818g/5yTDZFLvjtAO17K67rSh5uAzlFKPYfEFrLFFUyilRevEZJBqd5u?=
 =?us-ascii?Q?pXKvFipltWU+MMRDphI2MQ1ls0x92nxF2V7ryvvDUTNWJNC2e8QCx/zWO+/u?=
 =?us-ascii?Q?eqOrf7mqx6Yf3okFYNA5cNxR7ehtfMfEnAEnhKhLkKgkJZoahM7bi3Eu+2qD?=
 =?us-ascii?Q?9EmtexDjiGgpDMxIeGKn58PjVed+3L2D378tnNRE2pr5DAw5cImyrwJyIXEG?=
 =?us-ascii?Q?i04urstt3VdjXee17xYDBNmYGUexfuXQ2eVbXa9wqhkvDShk4dkJQ9qJ2Nq/?=
 =?us-ascii?Q?zM487l7Kq/AZnc/YTRDObSNPcgKSvGTB6WTZ55bM7wDw5Y8us5zNpV1lzJCE?=
 =?us-ascii?Q?nNpeuv35hnEmiHud495NuECMeUFmGNoDgS5W9CORQFjbmLuWerJK8ZwPvl22?=
 =?us-ascii?Q?8LWSXl10QAs+DmgyzurnIgKAYZAGpMewaIZNkRcmVM6vhV6EK93xBOmVjA7x?=
 =?us-ascii?Q?Q5VXxF34LJzIqMmcdSSd9MCq+tN3lXgsZzmgWp70ScbmrtkTCLotL+Bp/PCA?=
 =?us-ascii?Q?Vr+OqgNtzTWKVmrxU4ddjMk9l+7CTQEvFACSByL8RUG2SjBeyxTUzAPUNXzA?=
 =?us-ascii?Q?/6hCaBNbuXRfZwJxpjFU+U4dKyuVDomllzSM4xmNR1BgyGyehcTWSZOn5HM+?=
 =?us-ascii?Q?jCNrOC4NOkdHqVkeeSjdftvmjZkAdmNjdyt7wOP8MQfnNe+5Kkw6MlVZflru?=
 =?us-ascii?Q?Y4txUybkqN8Zhduo7lyDT9eDG5wMGF+Lnekcltp2uiWwW6V/nWGeZAU4Jr/k?=
 =?us-ascii?Q?nC/tC3gRJ/VTv/jsv3w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8363829d-ddc5-4582-e752-08dc7552b675
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 02:48:48.8399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UoTQ+vQ6X0549PbdxD0nbaZezg9b8A4hZ8CVaCP9knD93kflR0QijHkg3hGpvFr9iYXlVF0DQBvI7N4DqpI74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Peng,

> -----Original Message-----
> From: zhida312@outlook.com <zhida312@outlook.com>
> Sent: Wednesday, May 15, 2024 10:54 AM
> To: rafael@kernel.org; viresh.kumar@linaro.org
> Cc: Peng Ma <andypma@tencent.com>; Huang, Ray <Ray.Huang@amd.com>;
> Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [v3] cpufreq: amd-pstate: fix the memory to free after epp exist

The subject need to be update as below. " git format-patch -1 -v 3"

[PATCH v3] cpufreq: amd-pstate: fix the memory to free after epp exist


>
> From: andypma <andypma.tencent.com>
>
> the cpudata memory from kzmalloc in epp init function is not free after e=
pp exist,
> so we should free it.
>
> Signed-off-by: Peng Ma <andypma@tencent.com>
>
> Changes since v2:
>       update Signed-off-by to Peng Ma <andypma@tencent.com>.
>       set a space between if and "(".
>
> Changes since v1:
>       check whether it is empty before releasing.
>       set driver_data is NULL after free.
> ---
>  drivers/cpufreq/amd-pstate.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c =
index
> 6a342b0c0140..1b7e82a0ad2e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1441,6 +1441,13 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
>
>  static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)  {
> +     struct amd_cpudata *cpudata =3D policy->driver_data;
> +
> +     if (cpudata) {
> +             kfree(cpudata);
> +             policy->driver_data =3D NULL;
> +     }
> +
>       pr_debug("CPU %d exiting\n", policy->cpu);
>       return 0;
>  }
> --
> 2.41.0


