Return-Path: <linux-pm+bounces-11190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6369334FC
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 03:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EAB81C21E99
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 01:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C434BEDF;
	Wed, 17 Jul 2024 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ee1d5IFp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2083.outbound.protection.outlook.com [40.92.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB2ED8;
	Wed, 17 Jul 2024 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721179677; cv=fail; b=q7oWeQnO8re69t01kqfza0wlq1k+a72ZRGPUDpXiuNN0NPKGELVH/zLlIJsNGuK4x5m/UrB29Ou4/Qo+mvgJA6vuj/B8vj52jgdhR16CMhgiJZoUwflKRPFbSqOHKpTV3tEgxZm5iYumXLpLJC4iS6OL6GhcL/Ginxy8iiAmMwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721179677; c=relaxed/simple;
	bh=MrQlPMmw2DVE3PqHiZ3CgHhxafbXbBK0kciV+FyZOjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sTHSW28w15z+XqFDoeCxrpwv7g1f6R1BioMrEt3pontB+AB9IGcGOVqQasO1pxVxEbjfqD/e71i4L3ImISpjez4MZO+7KWqhnOUNFiYzZ61jYpzlfoUn36W/VQYdMJqo8BmRUp9oe1upzttPU6/dnbJux1Pr/O4WQ/QWqBV+ngY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ee1d5IFp; arc=fail smtp.client-ip=40.92.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLPtTmAWi87TbfWGsD86o0/qFwvKIWK9SCQAgAXe0Lhz+vJu1jFW+PCuVJs6EnBviwH8OXxDljNuofl/me8C2QX+a1g2uABCfX+j6OnD5La9MsVN+ETlHGojEdmhUhOlYRXo+nqttk8cTJ+El0SK23sG8L+53yu1m16sW1XTkzpKIJRy3LL+d1YDEv4VOdES72y7jQLUdWKJquH/7futGgAizHMdxzdMvpubsYev+kBW50mF5RrFCzdXho07/OaNPOpZ1+nzYmGFRQNThHi0SPv7nriUJEGk01zLK3pmWAGZVcNd0fk/dTW1IavTXax52DnYwaU/T3PawC2MhUCUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8oVoxXFQDpLSCcZF/p+oN/pC/zXjeKc8zAZ5vdmvPc=;
 b=ijoueNjf6af4S2ftVfO7N6BvxfEnMpTiJFQ4yHHKY8UJT+TbL0MGq9NPejd/k84guULdgy9dq4DlXfdts98uJCXBhaodF1Mzzi2sl5cDgmHuBYq11L09i15yadZ07sgiV9rC5N6htG4/Z0SNWLw0sgrHBY/mLKIx+mJKJMCfknwcR/XJVV2cwf8BoBESo4kpG1n9llAmQemq6jSseljOk9B8+D54oHZeypWHejlinyJjR3BYcC3/1h6cT0yXFMj61XdWcG1Hz2yVwuDmLkkDwK3kFDwnNDnJLEyjaGe2ByCQxizVDurPWxp80r3UWGx/gnI/+/fBqU+ne24YuY02Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8oVoxXFQDpLSCcZF/p+oN/pC/zXjeKc8zAZ5vdmvPc=;
 b=Ee1d5IFpxwLpgwRmtVpYAuj/tQDYf+hrZHK9NyCgvxSBUVrLPgN46yhW3WKqSza5sEkZPGCCOgZFYRenfhgawvCuCuPcr4OgqAZuNY80h3jrGwBAHl/DTUNy+cwrNPTipzyxIUX7YR7kKn2VGy/7d/gBb8D+1oVvlafR6hHq/jLuU7DOYWZ09oABFtusyjfHdUEh/3aaVyF4Fl+YzyCeoKgJzSetxt2OGvb9q3xgAPy2k7g4op9Jnx9d9+7G5NXhZ34t/3MBcR1AWQonigYu01dnPWEqO61Sd/0eNrxEPTIF5DmInQI8CCq8bCkZm/gMEBfTKdA3uB27mZJdkiESsg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV8PR20MB7378.namprd20.prod.outlook.com (2603:10b6:408:231::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Wed, 17 Jul
 2024 01:27:53 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7784.015; Wed, 17 Jul 2024
 01:27:53 +0000
Date: Wed, 17 Jul 2024 09:27:39 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor@kernel.org>, 
	Haylen Chu <heylenay@outlook.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add
 Sophgo CV1800 thermal
Message-ID:
 <IA1PR20MB4953D97AE6DAD99C386CB7DFBBA32@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221281561CCE511A5094D28D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <MA0P287MB2822445DD34485B94D22E7FFFEA22@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240716-cloning-canopy-a6799dc7f3b9@spud>
 <MA0P287MB28228BA5CC8B6F61A4C237E9FEA32@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB28228BA5CC8B6F61A4C237E9FEA32@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
X-TMN: [H8+keI/NcodbSXtMbCwVRojPOEjX/Fx/YMMKxn167eU=]
X-ClientProxiedBy: PS2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::22) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <mhtq2ymktycrgem7y4t6oojqujgotqxcgwlqkf3l6ugi5gxbvc@hnb3hciktp3t>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV8PR20MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 194f331b-307f-4288-df4e-08dca5ffadbf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|4302099013|3412199025|440099028|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	LEy6yU+o/8XMBkOZTVeXfmnLDF1UVNvCEqlh5jysoU5wVG4hnBZGCHmZXlPv3lGQZA5YgtAVJ3PY2EvdhZoCvCIWycnS3QMiBTa3QBjMr+OY6D99rjgu08nATyV4G5e2HStYGQEupsrx4ZROFk2PEOKbjiWfeK+EWmuJijvvZD8myODSTd5YKi/D5rhumRG/2UvkI3i+X0CHvjtW1Vx6xI+x9epnYKhJLcqnPP6pz9kse3Q8yIuv2hTBlAFwguRzstxUR4/AVf1zCZCx1UmvxEQzyYW/WnaWZJgpI4ZVDwI/yhydfUQoWGLXUNl4L49vuhzwjLFUYcGQvNS54Gos6TtviJV/yru7IGltZdacC03GQm2Yg9aY4UZeH92vHytXBoPQ5Y41HpMM3z7CeNAnhj1wvugXckVmtnBqSAhsKyo4d65lD9OPMB0XlrMyX2wPJsH6eVQMVdk7B6VJz7wZqONSzmxNlEhgfMdYEzkLIFWDQI/h4CXkKKjjgv4pDXe94vuTkSPw4g6KCPO5oqaw3I9p1fyaS/Aa06AE2r8nrl8jS9QalMe0wBruU4UzGM+6y1NE4A31M2fOgO9xO+27XR30vIN30V5MTaM73ALpM3oHM845Oo8zEMhFtetVfCxQIlJ06K1UEYMQjMhIqJpCwCzAP6MT3f2EIIYxT4/cQac6A5wUF1/c5dcd0m5JVIyTcSil33pKqWr2mFCV8cyOXBI/qtrpyjHIG6K8CNORxuu9GP5NrTdOSzCt2WBeNm+H4k7/ttglVhoJ7xmW15LTlIitnzrzf525UWjz+0c3WSM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y2fMrhqjz3bj3cKhfVHX3anud40leAJLjzU6NPswT2DXmXHt/wGSkDzSaEqQ?=
 =?us-ascii?Q?8V3Bev3BWfy76L6VFc8Vkta3+6WQqvFTEIrkk6HtiLOmDS0TW0gkSI4c/qym?=
 =?us-ascii?Q?S8mzMePLpm601xDOyQQdgRGlQIrlX7BrixTEo9Cmx58q1i3W4nb7Rkx4rrN2?=
 =?us-ascii?Q?iL18c846ZPiLSgk/fxDCw7SQrfWnkhCY6TLH7xxiHsC5wtjC89GLCNDCjNTI?=
 =?us-ascii?Q?WwR7cSF3ydXHDnthFG679civ0xwy4jkHCDu3kJuwlQB+mISjbtzd4PElsc/6?=
 =?us-ascii?Q?/XW8vb/VUcsdqK/6APDTto/UDer3/yjhIDv8bto+g5By7mqPsYZRtlMwNY49?=
 =?us-ascii?Q?toRuMMX5n63wXn3/kumzWuRw6j9io9yQs3sMpK5c92JUpp2oQ/69KLPk3J+n?=
 =?us-ascii?Q?enxs9dIWW075yArScCCOnXsENoHPSRoKQsOWQeQc6SJj23ryFPjqt19jgGA8?=
 =?us-ascii?Q?TZ7UCSCcIj5NvLYHW1fjDFeZwEoeOUvkT7JZ+ddLaiqqGe+O5PjWcSnYWZ44?=
 =?us-ascii?Q?owYfl3De346VLY4cfqD2Vm+FXDmm4gilxPVLTQTtSFchqiomyqKAhqp3ZHb5?=
 =?us-ascii?Q?ln8tp6MCYoPPSOno0VWuEM56kWpYn0jL5GkiatdOOkkfZY5zQHGVHEFWqmPr?=
 =?us-ascii?Q?oZLlrbgK24l4e2k9bLVMrk/7CjR58ffyczeOlpvmUH1xhMGRDS5pblXLeiJP?=
 =?us-ascii?Q?n855xrpYEnuJAkZc2NdibBC79Wj6e7DDPIZjZcSZJ68ySiSe2PNlXt+oO3K3?=
 =?us-ascii?Q?5d4I6d42RNlsZZGVVKzwNC2qRUKvLFbnSzIO8GtHyCaWII7+6pFM76epUh0j?=
 =?us-ascii?Q?YtAIQGKEDz/olA6dN/YsXhDi90oi8NGdjDmHsjcLTivf2TwDFdg2x4Tku7dT?=
 =?us-ascii?Q?yH2hH87A/z4WIoaC/YinhbMBT9yuc8x69yis3imw+byg+yUVWUZX1c4dPtbB?=
 =?us-ascii?Q?ZmMxhgTlzqAyvxy2iQLQNLs2zu+1O3OZi82roXcfuJJvrFfurN+jID20JRa2?=
 =?us-ascii?Q?ENwRIbn0QlsdIughWPPsRHHVC9Db/TYDg9zV2M6lLJ9QVq+gWEL9abpIFvhQ?=
 =?us-ascii?Q?+adPVCJzbRNS92xy+6P6AQ+D34idTHx/4sdwAEQby9eolJrSY3V0yU/8oFVN?=
 =?us-ascii?Q?08oRPqfUvSrwkl5gkTSOvgG9FGT1tcFbDrlsSbG0pMYBM/d0s9YFv6ZX+ROk?=
 =?us-ascii?Q?vBMP15XOg4Won1OmZxB3ozP9wfqCnUKa7EIIq5kHRDFIwY5o9FyMJNwLFor1?=
 =?us-ascii?Q?rIqWp05EjlYI/HHCmHo9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194f331b-307f-4288-df4e-08dca5ffadbf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 01:27:53.2456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR20MB7378

On Wed, Jul 17, 2024 at 08:05:10AM GMT, Chen Wang wrote:
> 
> On 2024/7/16 23:48, Conor Dooley wrote:
> > On Tue, Jul 16, 2024 at 08:43:19PM +0800, Chen Wang wrote:
> > > On 2024/7/16 17:42, Haylen Chu wrote:
> > > > Add devicetree binding documentation for thermal sensors integrated in
> > > > Sophgo CV180X SoCs.
> > > > 
> > > > Signed-off-by: Haylen Chu <heylenay@outlook.com>
> > > > ---
> > > >    .../thermal/sophgo,cv1800-thermal.yaml        | 55 +++++++++++++++++++
> > > I see sometimes you call it cv1800, and in patch 3, the file name is
> > > cv180x_thermal.c, and for dts changes, you changed cv18xx.dtsi. Please unify
> > > it.
> > > 
> > > I think sg200x is new name for cv181x serias, so if you want to cover
> > > cv180x/sg200x, is cv18xx better?
> > > 
> > > >    1 file changed, 55 insertions(+)
> > > >    create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> > > > new file mode 100644
> > > > index 000000000000..58bd4432cd10
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> > > > @@ -0,0 +1,55 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/thermal/sophgo,cv1800-thermal.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Sophgo CV1800 on-SoC Thermal Sensor
> > > > +
> > > > +maintainers:
> > > > +  - Haylen Chu <heylenay@outlook.com>
> > > > +
> > > > +description: Sophgo CV1800 on-SoC thermal sensor
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - sophgo,cv1800-thermal
> > > cv18xx-thermal ?
> > Please, no wildcards in compatibles :/
> 
> Sorry for my confusion.
> 
> Haylen, so you want a compatible that matches an actual SoC and use it
> everywhere?
> 

This should depend. If this peripheral is SoC specific, it is OK
for using SoC specific compatible. Otherwise, it should be series
specific.

For thermal sensors, I suggest using series-based compatible name
as this peripheral is the same across the whole series IIRC.

> Or we can add ones for each SoC and have a fallback to cv1800.

SoC specific compatible means most of the SoC have different part
for this peripheral. For safety, it may not use the fallback 
generic compatible.

Regards,
Inochi

