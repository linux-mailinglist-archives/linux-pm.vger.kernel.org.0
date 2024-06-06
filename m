Return-Path: <linux-pm+bounces-8732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E52A8FF35C
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 19:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6801C21219
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 17:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC4198E60;
	Thu,  6 Jun 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="YFPKmv1o"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL0PR05CU006.outbound.protection.outlook.com (mail-eastusazolkn19013007.outbound.protection.outlook.com [52.103.11.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C536224D1;
	Thu,  6 Jun 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693774; cv=fail; b=eTm+RcWw/eNR6bKqBBct7W45zJJO1Z+ymXBlbiSKmNZY+cz8blkRHPNew49GlTyNgBo3bqm6xyPDJ7tPmZLS87plqqm+YxjW0jb+JDngKTNV3DPiaMzfOTxHpEuUlZkAsXCn6oMiykNacFEC5/3rMDQuIIk/ZwXSTLZq7QSvYdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693774; c=relaxed/simple;
	bh=jDDQbJnDX+4NMQ42yOQ+OBtk915lrAFwdrkGBORLufc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qrtmmiXcSfAifhVtyeQE/FlweifcYrJ66g7idThFEXnR6dowdQI8x9rjcbHF9GaYj5jpzn0Z0C7Mkke8PFA33o2ruxs2Vo0jKYx7p/k8E8xsB6E6Oox9tjgMzY8BFGblhEb4DeT+WhllZlk1uQrdBip3T7PSwvsX/L/exFXBwaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=YFPKmv1o; arc=fail smtp.client-ip=52.103.11.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Papyuxqq7NuNjdNNDLii7o7pwBVWbgdBSlATLZhr5cJQR1I5iG2imk7Ozrp3nY98PnES3G+KJVovBJJM8EfdszZHBIeiWPtDB4lMwL/eULsP8v+iAqoslD5aRuOpZvlsYYsdDG7SK4ROkcxRsY6OwtLh4TLBXaQ6QIIB8fpyryCAJBN5diJopBWQe8a4sMZQqePpVCgMMa9j7Q7IJMiUU8Wz4atdh0rrkb4AniDHWdBMBSBnu9rkJuZAfaOFUuOMMaU5w/VmQhw/Gnwh9C+8nwLB+ebMC8nu/pimccafOwYomouCpkoyeJxJsaZomH2lEl2VMt5JxcHatWqqD82rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L89J51+7vsqTuOcMkN4gO+JGSK2xVevAvwvaRgcUj7Q=;
 b=OFoXnNGGCpRKynCTFPe5+TSg8jRb1ImzAlX19KE0ttyLvo6pqwLuq/7iva6oUs/Hr7SOnIyvTGSr5o1EFcpAwwNwAvtQqLxp0kesh7dOuXheZQqoD57OHXRN2jgvwypVSWLysm+Uep15gc1AUoqCv0MLs5wFWCQnRrofYLnmtU+gHCZFNvB0MKqUKNaJKKc/kc2tba9oxLLeTVfT9jf2q2QjIUSXAnTYoeDmRMYGoXllIw78t6ro1Fo51qpveFNpsizsl3RwVgjgJ0NAE5Cg35e1egYImXjhETqZ6tbOpqaBLdP6efjGp9XF2VNILustAoBLcYbNsnP6yWMg/4Cc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L89J51+7vsqTuOcMkN4gO+JGSK2xVevAvwvaRgcUj7Q=;
 b=YFPKmv1oFcdNmXboC+j2OStlwp3G3dVUovwy0xVpsotaV45ee/uaGAyIvFDZVjvBSBA5O1mT0RKJaxiG4MzdWawgis3aIZhwYLLEG2rPA6qX+HpHFqfNc6v94m3scvMqlZo2I2L3C1In4xYrjI5U2Yp7Anumdkc5PrpWmPNLUb2eyX9lJgLPOFsjP6+h/Fyjv2oE8GAjcEFezywNYzDZVc+Igumu1gGji1C03Svhwpg9nyz0BdOfLvJ1mE5SXJk9nCgd9+QwEl03/sjaEDAMBqshumR4UAO+b2F2YJP+aSoT+X4VmLAll5FHDZ9foSUBmTQUB4OQGGRVNIhIZzIhEQ==
Received: from DM4PR05MB9229.namprd05.prod.outlook.com (2603:10b6:8:88::20) by
 IA1PR05MB10150.namprd05.prod.outlook.com (2603:10b6:208:3da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.8; Thu, 6 Jun
 2024 17:09:26 +0000
Received: from DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::d720:e9e5:929:c7ff]) by DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::d720:e9e5:929:c7ff%4]) with mapi id 15.20.7656.005; Thu, 6 Jun 2024
 17:09:26 +0000
Date: Thu, 6 Jun 2024 12:09:24 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	broonie@kernel.org, lgirdwood@gmail.com, lee@kernel.org,
	samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	sre@kernel.org
Subject: Re: [PATCH 3/4] power: supply: axp20x_usb_power: Add support for
 AXP717
Message-ID:
 <DM4PR05MB922969669BAC030FC2283063A5FA2@DM4PR05MB9229.namprd05.prod.outlook.com>
References: <20240522230132.364915-1-macroalpha82@gmail.com>
 <20240522230132.364915-4-macroalpha82@gmail.com>
 <a2b06a40-4689-4fa9-90bb-9d34311d4221@suse.com>
 <ZldINkZO11XuiJAP@wintermute.localhost.fail>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZldINkZO11XuiJAP@wintermute.localhost.fail>
X-TMN: [rZHwOqLfS1y9MZWk+PuHkeMh9a6xzYkw]
X-ClientProxiedBy: SA9PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:806:20::30) To DM4PR05MB9229.namprd05.prod.outlook.com
 (2603:10b6:8:88::20)
X-Microsoft-Original-Message-ID: <ZmHtRHEJS2b7CfCP@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB9229:EE_|IA1PR05MB10150:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c07136-822d-41c3-0dfb-08dc864b6b19
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	9QWhUNx9lcbRkzaQdJwjHMycbPr35nGbNT1pnZPm9eAMBvsD1itTUcOOgPBK1adZRkEnJUih/1RydB4RUj0fPtdOw7m88IzE1c/aCOFOgRema0qVpizZf5NCaTjuHf3ZG056223ACPVCDHYRtvJYembQhPUgxhHlmCfogJRxCItfGnMPLLUmyxbTmxRsOBI193ahzWBSpNoIWVaMoXdLnqg4YVJeL452Xa7wdXUu2z/yo30mOu+g+JcFmrXtUS5dJj7DngBnT5OO2RM8iuO8n/Nc7dwLKTFT5PcP/FplfbVcC+t1iX+vbUbyBrmyph4GaRT5CqgFr90NFlJmLozlV9Do8HVxKC78c2yv+MN7hsPEKhskkiEOi32o6aIGOw/YS6992np+uXjrfZq2PaZ0/z25UxiLe3xOp9Vp+N5HMYoIZmUHAJkME+CYVjD0p7ItFp/n/Ua4ZJ8GIjT5yyJefYmxDI1gHCmozyTOPKfzsYbWNTxV7xiaLMUPAJiQ4sm1daYGXRN6TlDXIvCfms1Qd0KgVHP6eEPbwMlKuywMXqtA9gCF+f3Ih2FyBn/GlX78
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZKDVUOGVpL9amMVDB/rua0+r2uiHDz4bHG64dBYb37DFszPTgQ6ALdVAb24v?=
 =?us-ascii?Q?ZASCqsAv1D0LCy5LKtxGleY+hDJ4nasvGOKX+Bj6w5YNVi0Fv3lGF03BpWAh?=
 =?us-ascii?Q?XZTGLGg/4dclaW6FIszfuNe/RIGpTtZZzi7lrG+VKb1GjSQj8Y61n32mAazt?=
 =?us-ascii?Q?IjC9OBHuhzmFWPG7AwIyDHsG7j/YIEax0zKl+Ywmm/eySd7LofRH3awhQzzn?=
 =?us-ascii?Q?F28hY5HuqiiezcEtU+z6xg+YGGigGlTN0HPetd7Uzvl53xno8ka6yPxu9GuT?=
 =?us-ascii?Q?B0svp3Wu0kWMNSg7/kRE22aS+4Lj5FWVKmHQs6e4m+mCRdr/PtSVoD3Gllp/?=
 =?us-ascii?Q?NbhTstXpMiGuGXp7NHbnyumYOnKxR/OKKiUKVaazaa310pJ/2tpc7lAZ6s1P?=
 =?us-ascii?Q?HNugvsLDKEzmPJUcKrbh79ATUsUvFpnbnHXIt3Q+g3TQHemsH1vtcoHnZw9N?=
 =?us-ascii?Q?7fVUqinuat3PrP6RugotSGm0qxus8YYIz96JrDo487O5nkhWVuqSXQvFFozF?=
 =?us-ascii?Q?53zTfi29H4n94b6Z/Frpoxl+nEBjpzwTGht264bKNziptIQDcgKetpLb7nWG?=
 =?us-ascii?Q?2PG+3AL6E10YeduCg0hO1Jv9S3U+xtKyNpR5J7UoPgtRKKWwIJFIEgemCe1p?=
 =?us-ascii?Q?N7DUFUQBNBpUXycyhYla/4SUJA1Irv9zl2VqjqYHd34mGrvdYGiG+lcqdfCv?=
 =?us-ascii?Q?KDjt1PHXLDjftXVulIkAhVHAZgQC3wvLiYueoSsM2EZI6NZBdtwMoW/b3Q6s?=
 =?us-ascii?Q?O6tZmEu3jlVKDD+7PYvJeSsGIj/UrnoRm7MyWV0Y3Ki7YBLo42jHsdqW4JDK?=
 =?us-ascii?Q?aHzZMatDYlwTIdrZcanayxEc4H5Dsf+IySz6RpPyYWUl/px4ieJx0JKxHuKc?=
 =?us-ascii?Q?rRGinMhR3kJmBkH1v8HjOPVb++4Y2KlIVamKhIT6sfH7vr0bFp4wodScP64d?=
 =?us-ascii?Q?eXGQYhSMYMHGHWDCgNVc/cooCp77JmGkQMZBR+yvs3fLjmpnVzABWU6Am21A?=
 =?us-ascii?Q?rbQXfWoDYXF0yrtv9AHaz07KfE7nl3Am4J+++MW0qNeM8V7LHpTClJO04y5v?=
 =?us-ascii?Q?ETEh6bAEyArCcFDpCI7jinPCHuBlWFNMoB0QyD4ZkrtR+CC8XivR4ekUTpb1?=
 =?us-ascii?Q?kxotDtzX7WyR0o87A4JP41PHT7Bj5ZAgHPlDNMIfZR68NSzJ0/e7SwnhAVPu?=
 =?us-ascii?Q?9C4osegUyO6ttugnpqF2dtxFtSSLZkG+KHw+/FjQGY+OR4yXEvLvktd4ZuE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c07136-822d-41c3-0dfb-08dc864b6b19
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB9229.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 17:09:26.0285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR05MB10150

On Wed, May 29, 2024 at 10:22:33AM -0500, Chris Morgan wrote:
> On Mon, May 27, 2024 at 11:10:32AM +0200, Oliver Neukum wrote:
> > 
> > 
> > On 23.05.24 01:01, Chris Morgan wrote:
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > 
> > > Add support for the AXP717. It does USB BC 1.2 detection similar to the
> > > AXP813, however it is otherwise very different from previous AXP
> > > devices.
> > > 
> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > ---
> > 
> > > +static int axp717_usb_init(struct axp20x_usb_power *power)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = regmap_update_bits(power->regmap, AXP717_ADC_CH_EN_CONTROL,
> > > +				 AXP717_ADC_EN_VSYS_VOLT |
> > > +				 AXP717_ADC_EN_VBUS_VOLT,
> > > +				 AXP717_ADC_EN_VSYS_VOLT |
> > > +				 AXP717_ADC_EN_VBUS_VOLT);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return 0;
> > 
> > This is a bit silly.
> 
> Agreed, I'll fix.
> 
> > 
> > > +}
> > > +
> > >   static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
> > >   					    int intval)
> > >   {
> > > @@ -307,6 +417,20 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
> > >   	return -EINVAL;
> > >   }
> > > +static int axp717_usb_power_set_voltage_min(struct axp20x_usb_power *power,
> > > +					    int intval)
> > > +{
> > > +	int val;
> > > +
> > > +	if (intval < 3880000 || intval > 5080000)
> > 
> > Do you really want raw numbers here?
> > 
> 
> Raw numbers are used throughout the driver, but it probably makes
> sense to document *why* these numbers are here and what they mean, so
> I'll do that.
> 
> > [..]
> > > +static int axp717_usb_power_set_property(struct power_supply *psy,
> > > +					 enum power_supply_property psp,
> > > +					 const union power_supply_propval *val)
> > > +{
> > > +	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> > > +
> > > +	switch (psp) {
> > > +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> > > +		return axp717_usb_power_set_input_current_limit(power, val->intval);
> > > +
> > > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> > > +		return axp717_usb_power_set_voltage_min(power, val->intval);
> > > +
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return -EINVAL;
> > 
> > This is also a bit silly.
> 
> That's how it's done above, but I might as well just remove the default
> statement so it returns -EINVAL if neither of the other two conditions
> aren't true.
> 
> > 
> > 	Regards
> > 		Oliver
> > 
> 
> I'll resubmit with the changes mentioned above.

I'm going to go back to the drawing board with this, so for now I'm
withdrawing this patch series. Basically moving on to the next logical
step of working with the battery it became obvious I should have done
this using an ADC controller just like the existing axp usb and battery
drivers. So I'll start with that and then resubmit a redone version of
this once I have the ADC code in place.

Thank you,
Chris.

> 
> Thank you,
> Chris

