Return-Path: <linux-pm+bounces-11759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22C943365
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 17:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1D0B225E2
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6237F17BA7;
	Wed, 31 Jul 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="HIah0D2j"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2023.outbound.protection.outlook.com [40.92.22.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421A17991;
	Wed, 31 Jul 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439870; cv=fail; b=h77moUpanCeQJRP0YHApPmQL2agxAXeEH6o5nKIbNUqgs7CwkKw813O0rtxa8Ia8Pe6lf/YSkjhU7aq8Ozdkjs+QtseUuJduj3YHNBpQAPG3ExFg7rIQQunjZnYpPcz2Y97czuMfOeuytJBrPwSbC2Qap+MRido65nU3ikeC7JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439870; c=relaxed/simple;
	bh=7gUuwR15F2du3OjwQcqjY7/1ND1Syycc2k4kx4gA+bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J46XCw0OdzmAbs0R2gv4+DFBZjQV/c8L5nliwTPUA7TZ5yc/yAb3I6DtZicHe+QrB3Tf2kJ5ESUYt6HD1dK7W3ua0EkgEdysw9IR/o+H0esJf6MEmK5D4meJVcKThbTomZtFHJMwqTwo4qxmvD49aVnhH+8m/NSUFKwiIFkAITE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=fail (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=HIah0D2j reason="signature verification failed"; arc=fail smtp.client-ip=40.92.22.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLvUTRDZENIuKu4xuTwMUjfC1RE8o8ZuQ/bFnwvJAxZNwKV3aTXBgVgUvj4xUPDxENSnAOmm9yka98Sx7lhB6qYavkY1UOM8HGUFiuHAFw+8pCujhVo8h4VQEp+RWe7snRxUx3itoU10AYYQGtHC7wJxDfyR88X6YXTRG6dv+1S+k93ACzRJZ8Kblt7IRcr60bOqgZLWg3nQRzRY4ky1OcgAozrIEaBKhFz2ZIkXCiZeQrI6SQb2sUCUZS6eY/7uU9MJW4YgdIgitGVQhEffvstWHRONV4EbeC1JZSp87y3FD4BuEW+II8r4ioAV1huLQHK73LholsOl+pqtJs4Psg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrdWCxhQs2HvXf4C6GKiD2X61lr0vTcY1aeDUSn9ryA=;
 b=rL0ihprvTo1h8QHvKCL2UpCQuYtNAX4osZ8Bh3zaj8vKlA+jRUDWbtM8mxPeGKUy/Sr+VXa3cCZLnpj8IxhhqVigyg+Ym3sruF8OaVOes9j9G+OWdejTmuRjPT7oUn2ohwtY/8pqLJmH3nK4esNj8Bu89JLWxo3oI8j1kAFH4P62XwFgBNH5CF16CBBd1p1QRlujLQVOeXywilkfnoVYBlQEplcYfOQ/oUPZ7+4BhL6zqmwXXTs7ikcmZAYkKYacWvlWzbxcAV6MKN1O6EKqVeeCnIyKQtMNcTs/r34wK/xm0HKX8/XFNEYUt0E786nZPFi9PBqSw4E5F5pZalsZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrdWCxhQs2HvXf4C6GKiD2X61lr0vTcY1aeDUSn9ryA=;
 b=HIah0D2jdFyaDp+gpBDX2pGGiOa6/KgRTdFQH3vsMfuBdJ5MOTZ/QTMJfd2dP/9HatCXsk6z5qsM3Jc1IZ6/mpPhvyfcnqvto0CSvLrbvmEbD/UdQ2KHGkKucX7R8C33Pso2MjNnLMzceYBnlpDj68WxlO6ASB9etjyGcQVwLpN9uD+0FR0MdqaGcmkJdOnlh6/zUuRqwKPL5O5DshJ8AQyuHwslw/z2v+1G32/Lx/U+g/5WGQuXzlX9zOsBk/OwEhTdnR5icQIjtRqKI2qHAi7ruCMbQNehLIqAszblplWrZZ8n0h6cjuBybqWtUuLJK2umh0C5MSnzLa2mWDexwA==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by SA0PR16MB3856.namprd16.prod.outlook.com (2603:10b6:806:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 15:31:01 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%4]) with mapi id 15.20.7828.021; Wed, 31 Jul 2024
 15:31:01 +0000
Date: Wed, 31 Jul 2024 10:30:54 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, jagan@edgeble.ai, andyshrk@163.com,
	jonas@kwiboo.se, sre@kernel.org, t.schramm@manjaro.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: rockchip: Pull up sdio pins on RK3588
Message-ID:
 <MN2PR16MB2941F553BB291D82732FA729A5B12@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240726194948.109326-1-macroalpha82@gmail.com>
 <20240726194948.109326-4-macroalpha82@gmail.com>
 <5127387.e8TTKsaY2g@diego>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5127387.e8TTKsaY2g@diego>
X-TMN: [/6y8RiLQPtqE0bwu6ESG5LsvjvhY2whCzAQVdxOH08E=]
X-ClientProxiedBy: SA9PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:806:6e::33) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZqpYrun5vammWLeu@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|SA0PR16MB3856:EE_
X-MS-Office365-Filtering-Correlation-Id: a7741597-ae7b-46e6-bd06-08dcb175c5db
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|8060799006|440099028|4302099013|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	ADrL0c8EQoD3enyZoIcYKDS7SNVLl6vpAeVOpQLFT5aiKNyobHJqdr4vaJa4ASJz5DpNpWHRNJT6AMHyCMIHgxzhSD3Ks/2n3TeID/erRuKx3pvtnaudjpqomc6PiWUur/A2enARTuw1FiMFfdEUkmvMeR9H7ISV7BC6+1yweZw+jSDl5SU6M0CcEgMT1UW5ZhVxxhjLoRp0hK2t1F6CDPdsEk4C7RwsiAzvPenRT3TxZr/k/JX9sBt2+w59PT8L8MOXCpT4x0uaVOXezkaKpIOF5tmFoI/OV6XkQnLEaZQV6vmCFIfewoOKp4GMDwlyOiNFPa5quBU+EhWFEUgNYlt0DYHO59/fol4lEPuJ67AA83nbgHaPg+f6Om2wHQfXOexUm7gJXQoErzEGkEISn8TFhzYA2Hcezpy2cuBPooPvR6VZfxVYS/KMDNS0j0AyoSDudlNsQN/1d3aHRr8Ac+WmvgLTASwEFdXvepMGsNhEsr2bMd0pxYkADAuPWhKLp96YpJeSF7zftSguVYQENnJioHkcu0vCbFCadrONFxGI+eQzIrko4N7fTBeyaeIuOWQDOVQ/j1lNKx3yOP6z3FOXaR9phPxygaFp0mE3a7rdyt6CKcjkEGmPzoEcSdyPSCb5uqxbkmKb8ElhLqwWF01nRf8mqmUBM6BooctqN7mhvt7mI6Sh0hQBLZnAmeBMjb5vw3922+npJm4ZmXP1YPMP7PwYgi8BxXGSCPIxzpUrQNF+AlZdoOFu8KO7v0HKys+4amxuG9GNl5yRQ0LNDA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?h+gXA+DIPW2Dw70tWcbggpXjZ/7/eMxahXdgIER2tA7u7z6JhnSNky80WH?=
 =?iso-8859-1?Q?ilmrRUseCilomjbQgQtl8JRYLmHW+4bOz1ohrl/uYc6xJU9hr4jTEUxihL?=
 =?iso-8859-1?Q?N90ceSi60ypc+MHkV1ib8tdZJd2VXmaedAQaBfXm06pKfXuAlXxa7qdiMG?=
 =?iso-8859-1?Q?xGNYG0dOGcI4uUwoHtT8wMFbnWJGC0mrBL5CzRFIz3qBq88wuuiwHH8VCE?=
 =?iso-8859-1?Q?4n9HElykXzuQcKjWP0hm46fwH2j7C5s2Xd8PoKjrLsncIaT9TauMoa8Z/3?=
 =?iso-8859-1?Q?G3hPyi0CUx+F2r1yPXA+O4wWaC4qkXkEJhbTU6bQZ9tpY6LrnJSM54mL3+?=
 =?iso-8859-1?Q?NMoO05/QwjZ0ogK/Tf3FPzDzU5BC2LPUHhNP14qfuRTtf2z7auuoMNfEcx?=
 =?iso-8859-1?Q?Dpou2MISpF5c4t+OypXnQMxTOjPDW6Hf+N4QeBfpIvh3ZsB9e/+WJ+i2is?=
 =?iso-8859-1?Q?bHRWeNkLt/DwxoJS0TOrDShcS+pLOT3QSKKQ2+KXcGC22iu+cPH0SYZsq7?=
 =?iso-8859-1?Q?3NKB/0LVuzVaOKT9B2zjBfsyawYGFn3trj5OEgSg6L35HkqBJmC7R9UGVL?=
 =?iso-8859-1?Q?UrwszH1AGcddp3g9T/Bjc9HgRti9k9UnazlWSzIW4q57lz9eiy4TUbuYY/?=
 =?iso-8859-1?Q?Sm4uxG07tleQ2N0fEktmTifj2REFAQhmHiCKfA6FA8w5zDFOpMqVztsdqQ?=
 =?iso-8859-1?Q?s8xKlxQqrOudDveVdZEa1uk+WkoKUBxFi6sXm8kF4Qk3MFsB5PCACHBCtz?=
 =?iso-8859-1?Q?m8sqdbg275zUoRrfqDnop7mrYUoGs9DlIArrng58GRckVLQHU0bjbt7hfv?=
 =?iso-8859-1?Q?MINEgOggRJmEMOFKVEQJhvEbAGr6PM8KsD08qIV8hNgixtQg68Yf+VBF3K?=
 =?iso-8859-1?Q?aFSW/quPd/rTlfAXXTPMN7UFI+LF9SgvN8lo6PCeiZldRBOZSsj8d+0bQc?=
 =?iso-8859-1?Q?yNX9XSBE7Xv4VD9qeHnp6qDk/MeXUqagiElvGI9iu7LIP2cSlcFY5vFx0/?=
 =?iso-8859-1?Q?L1dweBqZGkb+Zob6DW3IrFiiJxYFPcNphXsQuepF+edrhWOLrfCfsQMmj7?=
 =?iso-8859-1?Q?pQgwYONNpu7eUVvt+2z26wz/2TSmwH8LxKOdbEbGB05Wmx4oPxIX5NeDHm?=
 =?iso-8859-1?Q?0Wl5JtLh2TXNfWB7aV4NkKqijlZMcAdoCyRqjM08DMCvWPtpPepED0sEpX?=
 =?iso-8859-1?Q?p51zR2DyZ6yPeXopC0k7w8sPFSpKT151/fKcjCA4xqoSSU4+0yDDms93AO?=
 =?iso-8859-1?Q?ufm6z9eh5kplqOSJQmZkIjRx2nc7irGcMsK6AiWvObSt1INmiYxD9rMrWx?=
 =?iso-8859-1?Q?c8CZDmxmjAt7HREfDdDBI7KHzg=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a7741597-ae7b-46e6-bd06-08dcb175c5db
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 15:31:01.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR16MB3856

On Fri, Jul 26, 2024 at 11:42:28PM +0200, Heiko Stübner wrote:
> Am Freitag, 26. Juli 2024, 21:49:46 CEST schrieb Chris Morgan:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > When using an Ampak derived bcm43456 on an RK3588s based GameForce Ace
> > the WiFi failed to work properly until I set the SDIO pins from
> > pull-none to pull-up. This matches the vendor kernel located at [1].
> > I tested this then on an RK3588s based Indiedroid Nova and did not
> > observe any adverse effects.
> > 
> > [1] https://github.com/rockchip-linux/kernel/commit/b96485b7af46a99c14f3c4818eb18c7836eb809c
> 
> As you're essentially duplicating the change by Alex Zhao it might be
> nice to keep their authorship?
> 
> So, "From" + first Signed-off from Alex, then you add a
> [adapted to pinctrl filename change]
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> 
> below that.

Thank you, that was an oversight but I'll get it done in v2.

> 
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> > index 30db12c4fc82..d1368418502a 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> > @@ -2449,15 +2449,15 @@ sdiom1_pins: sdiom1-pins {
> >  				/* sdio_clk_m1 */
> >  				<3 RK_PA5 2 &pcfg_pull_none>,
> >  				/* sdio_cmd_m1 */
> > -				<3 RK_PA4 2 &pcfg_pull_none>,
> > +				<3 RK_PA4 2 &pcfg_pull_up>,
> >  				/* sdio_d0_m1 */
> > -				<3 RK_PA0 2 &pcfg_pull_none>,
> > +				<3 RK_PA0 2 &pcfg_pull_up>,
> >  				/* sdio_d1_m1 */
> > -				<3 RK_PA1 2 &pcfg_pull_none>,
> > +				<3 RK_PA1 2 &pcfg_pull_up>,
> >  				/* sdio_d2_m1 */
> > -				<3 RK_PA2 2 &pcfg_pull_none>,
> > +				<3 RK_PA2 2 &pcfg_pull_up>,
> >  				/* sdio_d3_m1 */
> > -				<3 RK_PA3 2 &pcfg_pull_none>;
> > +				<3 RK_PA3 2 &pcfg_pull_up>;
> >  		};
> >  	};
> >  
> > 
> 
> 
> 
> 

