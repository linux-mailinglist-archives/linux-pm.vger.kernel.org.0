Return-Path: <linux-pm+bounces-11762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE4C9433CB
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941841C21A25
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362191B013F;
	Wed, 31 Jul 2024 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="bBZKwjHN"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2050.outbound.protection.outlook.com [40.92.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E707212E7E;
	Wed, 31 Jul 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441742; cv=fail; b=lHl0nZY2zB4chN+nHKWEG/s0+1wHvcJ4pA0SB11J7y78HRtfW2BDP6cycU8XkQqfPlmmRXR7DOBhmnsJMxN6lhfgnkA2L3nSYHZz3L7hkJdYbeW+sszo9bjo6LUiu338C77AIs3L9HPDWSPGq/eBSGpV9aj5masTcx4G72bpAs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441742; c=relaxed/simple;
	bh=XcQ8xMydQmH2HW1a9SP/+lHJqQ60ofj6sVoZf/eU0Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cT5Ll2uasZzttv3Q9cydi+zxZ94RGaPSO2tZwUhprMQ9q8MazwYyoXWBT7m/Zp21q+vcXzKPA+ywARY9PMBlBMOCCu2mAg909WKjug6weNBq7XKRtDFCphIidxNNqVm0xSNnJ9QJq8CHsS/EKxFFMqAtHEQ0i28RWOoCQlMduKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=bBZKwjHN; arc=fail smtp.client-ip=40.92.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjP1FSY9rmfNEoe5Ld1OMznZ16N8dwnfuTj41QJsO+PVKJ8HNgIvp7RwaqSy30uzcF/FLTyAA0HceYLOx0kLEwvqFF94z0jaDHy0Rsjii0yd018xXNPip+1fpCwAy/dXXl/fbQrtmmbtGgJ4v9kS8vDTym8nqk96bhIuxNZ8+Ib9mrFDghkBAlCL17nwjv2orOl+55nfgEhyOa7MIrh5JyzARMnWe7lBdr1SMWnSmHr2tMhvvaFDhNmqeRDQcH4N6tBXVCdMFvQ6QVRoPlBZzLgm2AIXWpVgCb/IsKfRNE2b9vxJwaEgH0YS8ErWt8pN66HRU6xSvEl1z1htY28IlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HvAxFG7tJ6+DSe6xUzis9L37TofuIka1NMbfBOW7S8=;
 b=m93XtBMXyMigxovEgKYX7oF5u5q8iJz030dOzRudGxYFJ1LeQ5MgKcu9sk5fWtvNFFAJeCQobMextiWt/mtcuxTqydHEyn5i6iWYp8j5pvmhfEtj5VtJc7IAae1v9ezBho9JUqTi+s8JBBSYZFuIxDGXCDNu/2E9hQJXPgN3OQ0xcHvszZZb6GOcwZZqjJs29apvOR2l9rkdNU2YhhH2o4L4nmT0Z7SFMKhOTF+wduS5DHI9AF/4jwdv95wkl9p3ii/dWVctP0G3L0jMtWUpBKeGYX8Y7lENRMaQJt1dUTL7gqp1KEdH8yfpf0yKBUH4BB2mziXh/ujz2tVjCIWj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HvAxFG7tJ6+DSe6xUzis9L37TofuIka1NMbfBOW7S8=;
 b=bBZKwjHN9dYlNTze61w7dGGJOIpTzgNpyp9KbDadnd9qPsIay7i8u8JlFHXeCXWrmtN7dmaazFYHKHTAZVNfLaKcA4bhoRV1Eo8U3Vp90a+s+NR4lcqdQklWwvaprMYnft74YFMS7SQqz1ry4GAzZvMmgI7H0xIOzuEr6lKh6M9wgZTMFXrBButnW5itE/XSzXdSeeJVdiDKyopfbh40Gc6oEOygJbK9HmJkENDpEmS1wg6eAU6v/FC6i1VYwpcZZa15BtPEFMhFeCJVYM/ieCaO6QrLZv4iB6inKBGtK1iAzXJ67+B6S6IgUtW9ydit22E/dcEQ3QoqtZD7pLRT9w==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by PH7PR16MB5155.namprd16.prod.outlook.com (2603:10b6:510:2b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 16:02:15 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%4]) with mapi id 15.20.7828.021; Wed, 31 Jul 2024
 16:02:15 +0000
Date: Wed, 31 Jul 2024 11:02:11 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Chris Morgan <macroalpha82@gmail.com>,
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, jagan@edgeble.ai, andyshrk@163.com,
	jonas@kwiboo.se, t.schramm@manjaro.org, heiko@sntech.de,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH 2/5] power: supply: cw2015: Add support for dual-cell
 configurations
Message-ID:
 <MN2PR16MB2941F5FFA92B056533586FBDA5B12@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240726194948.109326-1-macroalpha82@gmail.com>
 <20240726194948.109326-3-macroalpha82@gmail.com>
 <eimocj6mlvo6u4x54heywblwrfnftxelzpvfcogpjp7vjmunor@5eqlqsszk6ni>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eimocj6mlvo6u4x54heywblwrfnftxelzpvfcogpjp7vjmunor@5eqlqsszk6ni>
X-TMN: [piwzrcK/mABURuvYj/LQ2C2uTy5z9UhPCgQbfkC9lJQ=]
X-ClientProxiedBy: SN6PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:805:f2::29) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZqpgAzSJ6Grv6KMu@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|PH7PR16MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: 32771d80-46f5-49d5-c67a-08dcb17a24b3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|19110799003|1602099012|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	z4cXvmVqPQgf88COuoOJOZxHbk1xiuTHnAnokrZa/KnGPr+33momfXXRgW8Hn3vhXV9O/gdEvH7KhbZdS9mapAzr/B8zXv/1uS0y9I6W/ieS8ZOcFeRD9A/th0fRJGmlYl/l/4UHjwTnyHdesQnFh5djCXVssLy1YECU7QckUc58OjBMfNXpQ0Cngd96A5PMJHOMfC8uDlWyt2Zucw2xlg/itlom7VRhq3LyuwJlzVW9zT36Lt3/1xfehEGPRWrBTKoYrRakWmR20QWsqO9hg5VivBm9UXPtPLDt2OfEu9h9T5iOq7SmiumhRamwnjWnR8vC7LKzOzjIQmC12W3eMvUy2wOi2Tf69UjztbHSkB3lu98h5inaPeFYfIv8IQKEFLVGo86ZpsMlcaZQHSq7DtuxT5uumUvsrV2Z1KIgH26p69x3GnjqNFjA7ifNdThMveNdKBKaTIMKdywvBgfHcWWkZhvdX6gRK///5HOR0sFjLUl0LZi72So8RtuuarpL/bEL5sFzcDfhPCgPA1SDWUxIr/fl9R0+Zv42OYRQ/6A5ZQpZW3+/bMAcUwKkUfx4f4zcWq1ScAUZRkF55z6i4UrOIkLiCCtn7yQ2HozMe+Jh1okDadof9luOdoAbC/0QUeOmle+Kf46zyWNdMYJEEWB33dqKDxmTL97Uta72GDfe4KAbij5A867h+XE09V/N5z1/mgXU5IcKOQmwU3tjEc+Bp1C6HFjjlLCeiY/jCjFE1exLK+zx/kTC4cZmzFp2q9iye1lezQW6i45/b7EJzA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DxghXdJQCvP93tLqWRRvQZzQ1xUnaZIUQwzfqea2/Ydp/DBaLs+I+npF4m6R?=
 =?us-ascii?Q?x4XmAm1D1IRi2Kf0ToCwq3nvJ3YlWlsYPW1LZayF/HFXyaEUn5p19rB4ARXm?=
 =?us-ascii?Q?pStZvo6gjQgzdpc9wn7HGm6Qeq4YUW27hUnsSIL+tskwQjAp3MWg9nismg06?=
 =?us-ascii?Q?ysIaVGuAGeVpZpGvoK/YDUp7SDtTn4fA+D9tf0HeXfUax18TmywRK0R3toXL?=
 =?us-ascii?Q?nKfrgWzB6Vuprt+i02jbMk+8r7vS8/32Z836/E9q93x+KSGB+ydA9LGLQRar?=
 =?us-ascii?Q?KeHdG1Itf5P4QVKygqtN2dYahyl0QoJDTDZTbW43U7TZtcgLb8Ubo7QyXG52?=
 =?us-ascii?Q?m3F7HAqPGycsKOfnY6KXH8Ee/DcVtb09Im9uyXKSceYrIEa9J9pCbkbfmSb4?=
 =?us-ascii?Q?MAGn/s35SIg8G/FrCnS8gXImOiqgDHk4G8AcK5aVrJTuUmqbd0iK+kxYcyiq?=
 =?us-ascii?Q?yw1isFzVQmCozzJMIpv3ay+p40Y9UatVeAVo9mdpkju300PbCxetshQA79Oj?=
 =?us-ascii?Q?1DoDsGCpHGQyiLQPeni1Wsm38Rdao06jHKsWQvJMije72JHHr/un7+GvpbTh?=
 =?us-ascii?Q?MKQmPv+6oBuyanuCgWDDYH9fRQ1M7igwbMLZCK5y5jQMFES4pZk093IGY7KT?=
 =?us-ascii?Q?OziWYWefnJIyILVFIiZ1ggn9/2QBadpnapOtz1Cap6gGBta9CtecMFAVEViw?=
 =?us-ascii?Q?REqJDxUBtmmnwnimE/P3w5sguwDv89BFrHPMwBU28TgYrb1wV4Z2Nv2p+tR5?=
 =?us-ascii?Q?puusgU1L0NHXuryl95gMFMlkjOik1tgI9MDWoxH5IIiAQF1DZyTU/32MB4Ya?=
 =?us-ascii?Q?zMzUOyBWERk9D0tFZKRsALg9/UOezwrdrgOoRQyEN70thNxr0aAzbnDCSLob?=
 =?us-ascii?Q?/Ezr1oXRlVHG2FFQpRjgBYEowNWZLh0S3rc654R1rZdWjeLRze24ASGwhLG+?=
 =?us-ascii?Q?h3yaV9ig8NGAI3auZgvla1zZ3Ysb85jWgCUFlBuMnfBnba20dRSRA66inucI?=
 =?us-ascii?Q?62c97h+QZ68bqnbhNb0V/mwbkcXMI614JxhlGGQnKa05phPUOZeWwgWjvYSL?=
 =?us-ascii?Q?vdGvQSAqieSu7xzeacOxy2q0NViCowlSca9FKh0EocOa/IR9HqmIZrdx7JnB?=
 =?us-ascii?Q?1Ctnce3U5bIAa3lPfvglLkXJ6cxP2S4FC+BNyAJMTow0c3bq/84vqML6mw9M?=
 =?us-ascii?Q?zqCrRRkTAKx30kJMfmubFvskfMDL3mmmba/HzqxcPpWeC7vXhEmn4EmhB+pg?=
 =?us-ascii?Q?BdPRyANipDaoyfWARDl0AyQdcCDE2prg8pqYekbydA=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 32771d80-46f5-49d5-c67a-08dcb17a24b3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 16:02:14.9833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB5155

On Fri, Jul 26, 2024 at 11:06:21PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Jul 26, 2024 at 02:49:45PM GMT, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > The Cellwise cw2015 datasheet reports that it can handle two cells
> > in a series configuration. Allow a device tree parameter to note
> > this condition so that the driver reports the correct voltage values
> > to userspace.
> 
> I found this:
> 
> http://www.cellwise-semi.com/Public/assests/menu/20230302/6400076806706.pdf
> 
> Which says:
> 
>   CW2015 can be used in 2 or more batteries connected in series, or
>   several cells connected in parallel.
> 
> So dual-cell seems like a bad property name. Instead the number of
> serial cells should be provided. This property is then not really
> specific to the Cellwise fuel gauge and instead a property of the
> battery pack (i.e. simple-battery.yaml).

It's conflicting information (which further confuses me). I see in that
datasheet it says 2 or more, whereas the datasheet found here says only
2 cells:

https://www.lestat.st/_media/informatique/projets/python-cw2015/cw2015-power-management-datasheet.pdf

But I agree in principle that we should be setting this as a property
of a simple-battery rather than a manufacturer specific parameter.

> 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  drivers/power/supply/cw2015_battery.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
> > index f63c3c410451..b23a6d4fa4fa 100644
> > --- a/drivers/power/supply/cw2015_battery.c
> > +++ b/drivers/power/supply/cw2015_battery.c
> > @@ -77,6 +77,8 @@ struct cw_battery {
> >  	u32 poll_interval_ms;
> >  	u8 alert_level;
> >  
> > +	bool dual_cell;
> > +
> >  	unsigned int read_errors;
> >  	unsigned int charge_stuck_cnt;
> >  };
> > @@ -325,6 +327,9 @@ static int cw_get_voltage(struct cw_battery *cw_bat)
> >  	 */
> >  	voltage_mv = avg * 312 / 1024;
> >  
> > +	if (cw_bat->dual_cell)
> > +		voltage_mv *= 2;
> 
> Unfortunately there are no details in the document, but this looks
> very fishy. Does it only measure the first cell and hope that the
> other cells have the same voltage?
> 
> This (unmerged) series also applies to your problem to some degree:
> 
> https://lore.kernel.org/all/20240416121818.543896-3-mike.looijmans@topic.nl/

I think based on the application diagram it is in fact measuring the
cell voltage. That said, this ultimately boils down to a cosmetic thing
as not having this property simply means userspace sees the battery
voltage as 3.8v instead of 7.6v as is written on the side.

I think for simplification sake I will remove this from the series, add
a note to the device tree, and wait for the other battery series to get
pulled. When it gets pulled I'll request a device tree property so we
can add POWER_SUPPLY_PROP_NUMBER_OF_SERIAL_CELLS to the simple-battery
and then parse this value. Or if that series ends up getting abandoned
I can just add a quick and dirty new property like this.

Thank you,
Chris

> 
> -- Sebastian
> 
> >  	dev_dbg(cw_bat->dev, "Read voltage: %d mV, raw=0x%04x\n",
> >  		voltage_mv, reg_val);
> >  	return voltage_mv;
> > @@ -587,6 +592,8 @@ static int cw2015_parse_properties(struct cw_battery *cw_bat)
> >  			return ret;
> >  	}
> >  
> > +	cw_bat->dual_cell = device_property_read_bool(dev, "cellwise,dual-cell");
> > +
> >  	ret = device_property_read_u32(dev, "cellwise,monitor-interval-ms",
> >  				       &cw_bat->poll_interval_ms);
> >  	if (ret) {
> > -- 
> > 2.34.1
> > 
> > 



