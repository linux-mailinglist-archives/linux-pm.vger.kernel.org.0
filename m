Return-Path: <linux-pm+bounces-8386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C09408D3ABD
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 17:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD23B2726B
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AD9181CE4;
	Wed, 29 May 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="rySOx/cg"
X-Original-To: linux-pm@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19011003.outbound.protection.outlook.com [52.103.14.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830C181B9B;
	Wed, 29 May 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996160; cv=fail; b=cWrC5PaPdTuofR3iY2UHjWDC/m3Rlkwu9WBfwcMaiNKpnURmYnCjXJACHyHSlHCoVpK1YGe0SGIqJo6Bz367F50f/KX/qFbVEPIEfsxnwLE3C7qabPBOY7Hdb6sLNyUFaKHQoD/cNYD4D7zUyrwdFp3RN7/XU+ehlntHWcVieD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996160; c=relaxed/simple;
	bh=dNW+7eJfWuAE/UF6vXhikMIjPcU+Rbw0W7uyxC9+wPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s/DRmndw4+k1JsR7AUAuV0DtcQkb0jnQs3qfLIDp69hi8ldcPXSdMpMKxX62cBZGDGfal4sQvqsJ+/oLaXI1SCTRY1cd4t0Abb62roaTwfolRbL5ANNg5kA+znPZHNanKr3YOMltNMimxaSBMopn2/t5Ej8+hq7B07oyU63TrVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=rySOx/cg; arc=fail smtp.client-ip=52.103.14.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewtnPEADUh5f4tDmjOFXLqjQQSw6THlg9ANQvxFN5P8ITEw2pTrQqE32+sD9+MRSa7iBSdoEtRYGyrLWcxR6EUd/NaKLJwSu7ZmL8IrzFmUovrjeokZwCaTia07VNuf9XjEj3pDx4+XivGewxpxUt5yJFv907UbCwhauO+Ns1sk6qDLJ3QeR9cCelujSkonGu5ztEznq9+Qu9zsv4f7kbAghURyoUQ9aoyRICJ41AMxdN/2MLqVOCFqw5jHfVDUgABh26yySGHKp0RWGeNJ524X8zZGgQagIAo4tiAMD4aJVTX50UW0Z0QdsvLs6CchZHeLiznvGAoMw8kpQiZUkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WSL9y3tXkLZQGbIngPuHsr78FsjKY+2xUI0r6gFb68=;
 b=Sas0Q+PgO6eXUgdfQ24QLPZKkH6jeE6wO3M2kfhQuLDfyoUhAjOn78PmMT+5HrN8tgrdxdASDONzN9yYlzIMMonfzH+6jg0DnitKRjtVBtJcVUJhkuKCVc0TnzCd5GOpPXYN9ewmTr9Q2T1+9NniBI+vYYfsBj7O8VCDsvRIuczF+xULw16DwK5r58r9KSKHsP+aeCAxwNRFwKNX4cNFqOaiFBPqQYV/mhRLryBG16UMtjS5/F7evIfWTEwsZacNFpAPov/QkvR+XC+wNiQtQX7UWFrGyKcMLnuq7+bhCMbo/p/L2fzhtcz8VOxfx63e2Jy+4r+sHDzTw3czk3QgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WSL9y3tXkLZQGbIngPuHsr78FsjKY+2xUI0r6gFb68=;
 b=rySOx/cgHQPYfDbcciBj3kseWzsYqS0E0fH2uTASaEppU5ZP3b6H4foxbcYiD3Wwne/0KtZEUXRi9ZkXUqiEQ2k2FwOEsRPT/0g4BgLHBFGPn8F/35hQWKxdjfO3HaePpTqtru2lomlxVlp66LtdTNZ34UWx3pJmXPN0uuavTZhrbt/THKhTP3nsihV2vijCpCY3QJr7lmoAoJTScLKQ3VRSf0oAJXt1gy7bUQPSarR5H92n+uYaV1ORNJBLDyEBEDdYG4FzsGIOqf+IUW8i4XpH5Tt1EToPBW7k/xKfzpgurRFYwmED2RoukNuRX3oY0zNcBF4VPlIar1RPfrkd3Q==
Received: from DM4PR05MB9229.namprd05.prod.outlook.com (2603:10b6:8:88::20) by
 PH7PR05MB9710.namprd05.prod.outlook.com (2603:10b6:510:274::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.16; Wed, 29 May
 2024 15:22:34 +0000
Received: from DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::d720:e9e5:929:c7ff]) by DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::d720:e9e5:929:c7ff%4]) with mapi id 15.20.7633.001; Wed, 29 May 2024
 15:22:34 +0000
Date: Wed, 29 May 2024 10:22:30 -0500
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
 <DM4PR05MB9229ADC0D84374F76F496FCDA5F22@DM4PR05MB9229.namprd05.prod.outlook.com>
References: <20240522230132.364915-1-macroalpha82@gmail.com>
 <20240522230132.364915-4-macroalpha82@gmail.com>
 <a2b06a40-4689-4fa9-90bb-9d34311d4221@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b06a40-4689-4fa9-90bb-9d34311d4221@suse.com>
X-TMN: [24VSVg4XGACe+7TL9bYmyBDZnEG9ij6e]
X-ClientProxiedBy: SA0PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:806:6f::25) To DM4PR05MB9229.namprd05.prod.outlook.com
 (2603:10b6:8:88::20)
X-Microsoft-Original-Message-ID: <ZldINkZO11XuiJAP@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB9229:EE_|PH7PR05MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: 315da3e7-ebce-47af-b40f-08dc7ff32a41
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|3412199016|440099019;
X-Microsoft-Antispam-Message-Info:
	x/3Y5dC/1HtCLkg7TLol+h2VRIfCRDoV0WE5gk/cNZqe4HblHtHWHWx0SKdmTGy3KIAakS3IeyIxU3usNopQY2aVL69u+utqUKVzM/G3zmiGa2QjQvT6paEXLXgHG+7dKJWwEG2F2g8qAkEhVmumw9G5jUlpHG65pyyvZNWoDN8XSJSahZEDCkhEDiD18nbXBVcRWxJgJuzj1ovTIvhcge33/UtQ+Fbjx9piOh/2tLFOc9y5T2B6/B41XwO3FIKghAcTpjpHebk0rAPmuH5kCZ/cImqUWBh2etK5bp8BXdJbgv+71EKCa+aGqyszdMUYW2LqYa288b6rmZeZSeDxQz0CI8BQ/07vGt0m+1oAdekTFkPyi7tCJWx/fGBu71DFoBfQC9jrTWqlCLH1f2xVx/cnH2rUppd0y7q/ppvuwQ5uKB7HUOIdTBVBc5oVF6EN6RpXNDoHowKdegaCpfFzEQj/Y3hsTmTPYLOk0AJ6l55scZRG2tSAD0gAAktGzpEFknhnQUFraUCgt0cg8n4ZJHMtcM+ii4alR2x6HnlghYU2Yij1LFvneHL5AdaPLdTb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e5N8w253haN5PDqfzYJZ4waKtD0D1MsrW8Hf42wyE8KbXzrHR7AUiDHvapI0?=
 =?us-ascii?Q?+GZMGAdqbTlZUFdSMAYhh3nUTkHfOTLc80zkT92zJG09TUF4P/8zUlub1rwg?=
 =?us-ascii?Q?e14FGL37Lmnwkwh9fxw2uePFjHeU9DMk/5D3ESS3YKq+gAC74uUcU9dolJeM?=
 =?us-ascii?Q?27UtdLv/L/Wj8nZR1k0JXUC29qWAKPDLf4hmdh5WtROUkPqLA+o+b6lz4BQU?=
 =?us-ascii?Q?cdbIGGKB1y91Z8JCNR2gRI3maR/X2c+XQtOY8gwLwGB/dm4stAV6wdBf293Z?=
 =?us-ascii?Q?PsJMRNMf8MI7pg7SMTcIP7VgJ6kqC+8YUHmZZdudw4jY9ifmdhecWOeMfY9U?=
 =?us-ascii?Q?dbWdMwIkt5G5N5fHhOrfAeMaivyTqGCQ5hj2kTlmn8IR0Ruwfj1pt+OYsmh/?=
 =?us-ascii?Q?0068rA47TS9TWt0BGHYy1F3OrDRTGPKs+BfFJ7UE/+tiLyiroc43UljBJ62N?=
 =?us-ascii?Q?LYu4bswXfbiZ9YPXs/vnrGoOs99Vp8ATldwM6VsBLaNTdQtmIDsH97DDFlhV?=
 =?us-ascii?Q?nhVJSCuy0c+hk0X+w/rf7YUpH9P8GpkSS2GDmSnq+FI2jEABMqM6TLX7uHzh?=
 =?us-ascii?Q?QnNFzqgsuX26Ff/b96QDiu1qQJ0oOCyaQZJ3i4C7u66hA9F1kQDFWbK94vix?=
 =?us-ascii?Q?WSBEQDkTaWYjJ17VST3DExVuL7zPkK/MAD98cMk+RJAU9DRzmMT99xFQ7ANX?=
 =?us-ascii?Q?2OY1O96+1EVEU4X/cGxyJhhA0F4KHJSoHDNy69giLS4PIM6+BZ7veWBmM3/K?=
 =?us-ascii?Q?yMMMNPGR+1m5tUau6YjC2eStIPX0fjvyEVljDnNjUn2J8kVggpwhvu+ziw45?=
 =?us-ascii?Q?pfXSDU/e120dIdNpGERlgifPbZNVv+YwNRsE8xoTBxK2zi1UZibBdfYMyPUR?=
 =?us-ascii?Q?qFywFu5d7V09Udxm6fBO4z/098L7JRjcMh4pnAVgaxskD/KDYFq4j/u0gSdr?=
 =?us-ascii?Q?iXCDRnsYBLvf9RwrZC83UzuklgsPQ/HdnhEmCevPP6J3oTXgfyZTbuqmKPiH?=
 =?us-ascii?Q?Pu8I6h7i53yuHJZPJuzlh3MDIzou2XzboEDl0sdVVBki5+JTNz6cSyuIAV6C?=
 =?us-ascii?Q?rqr6OIHYHMXSzv6uNE3Sr5EkJJyhABp3GJmdr0M6RYytwoMgzwBm6AspnGkB?=
 =?us-ascii?Q?zQjSuvFUcTiaXgMQyKFn+XxCiKz4VOj7s5dZQohtMwhRGBTbSkMauI6z9por?=
 =?us-ascii?Q?I33Mo6GRBnN3iuq21HtQNQktpygw0QfZmGyjNd0piXvK4khndq2OoHGTDT0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 315da3e7-ebce-47af-b40f-08dc7ff32a41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB9229.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 15:22:34.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB9710

On Mon, May 27, 2024 at 11:10:32AM +0200, Oliver Neukum wrote:
> 
> 
> On 23.05.24 01:01, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the AXP717. It does USB BC 1.2 detection similar to the
> > AXP813, however it is otherwise very different from previous AXP
> > devices.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> 
> > +static int axp717_usb_init(struct axp20x_usb_power *power)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_update_bits(power->regmap, AXP717_ADC_CH_EN_CONTROL,
> > +				 AXP717_ADC_EN_VSYS_VOLT |
> > +				 AXP717_ADC_EN_VBUS_VOLT,
> > +				 AXP717_ADC_EN_VSYS_VOLT |
> > +				 AXP717_ADC_EN_VBUS_VOLT);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> 
> This is a bit silly.

Agreed, I'll fix.

> 
> > +}
> > +
> >   static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
> >   					    int intval)
> >   {
> > @@ -307,6 +417,20 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
> >   	return -EINVAL;
> >   }
> > +static int axp717_usb_power_set_voltage_min(struct axp20x_usb_power *power,
> > +					    int intval)
> > +{
> > +	int val;
> > +
> > +	if (intval < 3880000 || intval > 5080000)
> 
> Do you really want raw numbers here?
> 

Raw numbers are used throughout the driver, but it probably makes
sense to document *why* these numbers are here and what they mean, so
I'll do that.

> [..]
> > +static int axp717_usb_power_set_property(struct power_supply *psy,
> > +					 enum power_supply_property psp,
> > +					 const union power_supply_propval *val)
> > +{
> > +	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> > +		return axp717_usb_power_set_input_current_limit(power, val->intval);
> > +
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> > +		return axp717_usb_power_set_voltage_min(power, val->intval);
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return -EINVAL;
> 
> This is also a bit silly.

That's how it's done above, but I might as well just remove the default
statement so it returns -EINVAL if neither of the other two conditions
aren't true.

> 
> 	Regards
> 		Oliver
> 

I'll resubmit with the changes mentioned above.

Thank you,
Chris

