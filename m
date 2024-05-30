Return-Path: <linux-pm+bounces-8436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB448D5678
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 01:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8956BB2563F
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 23:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC5717C7DF;
	Thu, 30 May 2024 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PqHlxpMY"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2100.outbound.protection.outlook.com [40.92.23.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2A5674D;
	Thu, 30 May 2024 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112873; cv=fail; b=IUs48QL8/f48LXNPd729pJZrz9ax2MP5q0mLF53/rkBiXqr4OT2eYUuwuxn3W0pPvgFijlmCLoqr2DDZPLOUIAli+IoDqRq2oSrYqCA+4BVlMC/JtgunBAW/Q+hPzpZuHZ+gdnS0vS3W/ktItlP8uoiwavFMa/QSxsD104dCFPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112873; c=relaxed/simple;
	bh=2YDyrTvknXVvXoWHACskoH5h+Mgt+S+Qgw5MW6scNVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=shkaP5hbzg47l/Sgc3cvs6x+wpLP4nW8UDcbNQrvt0HxUHOau4McxRzHHGlkT2XE55oQiLkHyoJsD7X/tsJv3pGc7qbuhhzgi/SRohqhdTdQkf0n5f+6Gt0my4u0vKj2LJRQi/3WSTjG5J3LtA1GxjrSTKv59UtfZURwshnTQSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PqHlxpMY; arc=fail smtp.client-ip=40.92.23.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQj6ILA41jbV87SLJD5ARsKEkxEv75w5QVYfblObIV4JfFmOBX84cWUTpe9ynLmjUKUXkUP++x8IJzJ6L10adYXRuyix3Lz5c0huU4HYw6WTc5BdQn6XaorjjaGrNNO/bTmszCfhzKv+lN4jkNNYNSPlx0TKNMwyAYW3eATTm8+sIucD16bfAjEus8ZF2ArVMdWIy2JghTS2QmootitwqGwqt9YnpdrtIaojMw17PJkVuzLWnXv0wu/0vAprRZatPFbMLBcM5TeC4ogYzFhYQRaebQT2ILahkdZRt9u3CH/qF2u2r5dEhAEJz25cxYZodur0vaYPCEzZV0T5ru8PWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQgO6oRA/vibXE1YVmCbX2sFf7ZvqnT6RgYAynPz9Qc=;
 b=QEvlmgNA5eVReHna1SGc4Qnunig+J4UiORlSA5n+zpoXFe3gV/UhXZM/O9r/2CBsiEiH2oNxZgBblXJD4wfU9xeIlPdWbKZDhhDdlExI/DVcxMJ5I3eOLfB0zg1dVT6D68eWe6idhkABma3hfaClt8a9MTH4tYwHKK8YZ0xTVg5RBP1uLtj/isrj5CcaCTy1gBhNVqrvnC8CLeTTRPguVPzohDFmfIUsfget0/YSORUFeZIIQUx4mrjnbEW8b8uhIjR0nxS4jv2b1NxkGhNgQri73mFX9f+hZLA/8cKJ2G/tQ7PXSabyam8VePSd72NY7b65iOArn3A+UycT4I2kqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQgO6oRA/vibXE1YVmCbX2sFf7ZvqnT6RgYAynPz9Qc=;
 b=PqHlxpMYJ/V5WbrR7D/+h63VWRiwqXo465WQNRZHrL0ngAOYclySaXE54/XaQu2lzsm+SczBWNNsfH0N0JcDYtzSKtz8P7ZTPg4VSgTfGpsyWCE+pivjeZy1PcdwDcVkwlnp0PyAOqDDu/3b8XTvrccxotTIJsNNgrZzOe5hu0Hm8C1+t2PuqkZVrp2QBLo7QS7HJWpBNraEgkSS2L3E5CeAkzaoRnjguj8E8tbc1EygGnkfGBZu2e8wq7H50/d7EGotZHDFH3lfoa8Oz6+FQJtW41rY4ZKSezV6F8m4bAhqcWgr9dGsWcDFpVUdY6aTXleDPO/NuX7YfBP+Mn3CwQ==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by CY5PR20MB4928.namprd20.prod.outlook.com (2603:10b6:930:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 23:47:49 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::b5de:b82:43d9:4e8c]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::b5de:b82:43d9:4e8c%6]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 23:47:49 +0000
Date: Fri, 31 May 2024 07:47:34 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Haylen Chu <heylenay@outlook.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/3] riscv: dts: sophgo: cv18xx: Add sensor device and
 thermal zone
Message-ID:
 <PH7PR20MB4962FF8B101A968B38565827BBF32@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <SEYPR01MB422119B40F4CF05B823F93DCD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB42213647922C5B93C8D3DF0AD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR01MB42213647922C5B93C8D3DF0AD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-TMN: [B9T20Lx7OXSGmexspownEz4j9oq+lwm5RrcZoWFCJtA=]
X-ClientProxiedBy: TYCPR01CA0058.jpnprd01.prod.outlook.com
 (2603:1096:405:2::22) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <un2fe7534cy6htpjaftgfqpvifqgxww5nk6mpgdgusb7zz2mi5@wr7j54xg6vob>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|CY5PR20MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: de45c376-5d88-49d6-bf40-08dc8102e9a6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	MPb7TmSjI+zJJVEikvDUfmDRyF2XdiD+agd6VGajTGjNTSqymoT4gkENq7Uhi3aSLO5Px1jVLbk6buTWMemzTDv/X7iyfHTM2UhQkddxfFG9BvqF8DPeI2eRz51iFL6kwTy5wxdSeLEn3eI48qk4apBJ1yGk6p0a/nUe3mDEzfhcMX1lz4xzxye69UdhJB3W5kFA2Z0h+O+edZiOZTZlNC2j6k2TCf/4wjPGHEUR7VKHsmKpLqETYs/AG8TB+Cnf+joqPj2R0GEJH2KGgPapcG+njKy7Jj4ebexNowPd7CY3q1Q9EngsOSrSSeSBHjNbupuo6K0pvSP8A36ckwmSSLymltI8FM8uNja5QJhanqvykBuhjDX+qg0SAOeUhimkCjBrFYn/B52n+gdcL+A57atUpGJ0nV8VQTurP36q+EZ3U7NrfwswE9bbQRxPKpUYeyk2S1Z2jlpCJiITYegutByJ8Nh9yk478PfidtQv+e60mm9gkGkVbwfxwK6KmC6t50HGkWIbtk2GsT3luo1Cosawz8aMSfYJffxNfrKg6tgdOleXV29N3sRioe7k0olIPN6DX7m7NgXiePG78mET3ClcBr+/UR0ewISYHvW0PH0kGpPd/P2KGh+T4C0ihxel
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1CWmI6lqVcL4IwKCeLt0708k4vV6qADQesNsv4R74sEzgjHfQ5EMGZr59kw?=
 =?us-ascii?Q?fwuya5zdL4ymGwEF2T7deIUlcz0jI3V0xCYiuLu+t4MDKGzJtqHX53KYF0Mt?=
 =?us-ascii?Q?rUNsozA80wAt5uwvRHSY+ab2YoGzKj4MwtkNQDJwDw/edKqExCtoSMjJzptV?=
 =?us-ascii?Q?Jg+5NwFVw7xFkdVNwVxseQgg6uACUssU/YEC1Y9W0DjVXVlGjn3Rl58CWHNR?=
 =?us-ascii?Q?z0nHyeNob7jw3a760RQb4H2Ir8t3vY3Dr9b9xkwrrBLrV2A0EXnwlhxVY0Uk?=
 =?us-ascii?Q?d3OjPDxfGY1/hsm+SvHG3FObE5SggbY90ujQLGAnkUKYMWnipgbkT990ly48?=
 =?us-ascii?Q?lKpizdj17eXqPi5rGZWPOJEYg6wzO0ZNuJTCkI0uhQMLW8Ls3HlUHJX/B1ZY?=
 =?us-ascii?Q?vfv7sWLa9RSiNZkXDYC2cFgy3GEZ//Dxwbcs6W2xjUbnS2/aHPb5miwA5Vg4?=
 =?us-ascii?Q?cCzvs382mpjB1qLCuNFYuSY2ihu/EwIFpKpQMAPfYE9XLbeEEQ019dpH9Rzi?=
 =?us-ascii?Q?ZzWcN09lhAg8yLYSPEpmPy5yZbirieuV+mpdgti3BDeCZjppdl7kBFi4NLrZ?=
 =?us-ascii?Q?nkffhO/2vDhEGRLdVpiJkYFrG+td18xG69jn9MkWHFXR3h/bmy7BoFhD2j5T?=
 =?us-ascii?Q?LZZxYCz8crCjYQHvGxTGVCev/Zf5Ni4FztimXrxKLVFsgG4OvhrSnBBlBDJZ?=
 =?us-ascii?Q?CRuOFCr8c5Eg63o8RrFDtKbkcfroMipomgbJTiAqTN1uHjpJdqG71y7iYsHP?=
 =?us-ascii?Q?WON5MUxPo2gpI1jWPeGvR8KMxOEneex7N+J8mh5Fz29PD8p7pCzlpNJ+l/Nw?=
 =?us-ascii?Q?VApKc6BrMgkn+FGcVQ8antP9gezL7MkhA1hguWxAgWw4ZvicbpIPy6uhfwAL?=
 =?us-ascii?Q?o4v5SeFBxET7ei6Ab9d8Zb8NrD2zMJQfswyZokvEQOdTDRnfIq8xNjQkJw1C?=
 =?us-ascii?Q?dfLr2ZNHza13w4EunnYNpokwV5l8Lr7arf8yrPk0D1cldocyaWADZXngUits?=
 =?us-ascii?Q?ioffYBswsSq4gbK+Ggq2el7bR3a0+gshWzHD9yjcEoaq8JWL6KS5JMqfDu4y?=
 =?us-ascii?Q?GPstCFfyf5EuqQVRV0uYpBAcbpFRkCxZV+mykhYBPkHOQ0PZJvcNuYlmIlWB?=
 =?us-ascii?Q?yPEMpPDNQ89d5V4EMRH9gc6v6tR+QSvbYqjXqrJaVdqssYBmmv9vIPWVRDX9?=
 =?us-ascii?Q?JjiK06pD3AoTBrKXeK+CCEjoZcnAXlvug+ebJZd9GidB72H/BiuicfW9R5Dj?=
 =?us-ascii?Q?osp9FCLjcjkEy35dkyJT?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de45c376-5d88-49d6-bf40-08dc8102e9a6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 23:47:49.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR20MB4928

On Thu, May 30, 2024 at 01:48:26PM GMT, Haylen Chu wrote:
> Add common sensor device and thermal zones for Sophgo CV18xx SoCs.
> 
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 36 ++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> index 891932ae470f..dfb4bb6eb319 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -310,5 +310,41 @@ clint: timer@74000000 {
>  			reg = <0x74000000 0x10000>;
>  			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
>  		};
> +
> +		soc_temp: thermal-sensor@30e0000 {
> +			compatible = "sophgo,cv180x-thermal";
> +			reg = <0x30e0000 0x100>;
> +			clocks = <&clk CLK_TEMPSEN>;
> +			clock-names = "clk_tempsen";
> +			#thermal-sensor-cells = <0>;
> +		};
> +	};
> +

> +	thermal-zones {
> +		soc-thermal-0 {
> +			polling-delay-passive	= <1000>;
> +			polling-delay		= <1000>;
> +			thermal-sensors		= <&soc_temp>;
> +
> +			trips {
> +				soc_passive: soc-passive {
> +					temperature	= <75000>;
> +					hysteresis	= <5000>;
> +					type		= "passive";
> +				};
> +
> +				soc_hot: soc-hot {
> +					temperature	= <85000>;
> +					hysteresis	= <5000>;
> +					type		= "hot";
> +				};
> +
> +				soc_critical: soc-critical {
> +					temperature	= <100000>;
> +					hysteresis	= <0>;
> +					type		= "critical";
> +				};
> +			};
> +		};
>  	};

Move this to the cpu specific file. Different cpu should have different
thermal-zones.

>  };
> -- 
> 2.45.1
> 

