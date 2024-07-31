Return-Path: <linux-pm+bounces-11767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC75F9434D6
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 19:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05951C219A5
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 17:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DF41BD02D;
	Wed, 31 Jul 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Y4/bHNDe"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2043.outbound.protection.outlook.com [40.92.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8331A76A1;
	Wed, 31 Jul 2024 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446054; cv=fail; b=MEYVJGBFrwyz8yrq54Ny/jWFxrsLZ9LfxH9jA1hCG9oLw0bHQZhj3plw7WP0xQ/ZnlJNcOKFpDmSn+6awccRGgG0z6OqHKFXh4AhV5y6/xsMIoXgZOszew5AozfbAFqSpx4k0r6bezCbnmmEQGZam3UNXefbd53kXJUrweDCvl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446054; c=relaxed/simple;
	bh=yRyK3tViTIsIlScStf6jB2litFNn6+odeW6QKN1FXgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m8RB6Qcdni1dbpgpkBVD4XOk+b36+eJMIwX7C4rcBxdtP0+FmrOQ0PnnlVvUehD5dyQOVo+CimL6vqF1PzOk1vPM4NhNIkR8JKtN8H/clT068dQgDuTCu7ICk97GTfuqL0dY2+ZbNEfoil5azOzmJjB15sZjuWT2DG0RmL+/MPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Y4/bHNDe; arc=fail smtp.client-ip=40.92.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vhex27nJWTWu2zyooIRQiwAdkJrJ1lJXGdnKpdcSX+oPe1BB1aNe55DYMDemixYp7uYdTiVuzcNZtEiMfUs2lnwRd+1ybIx/IolQoigbTt56eH5A59JKDgSWuAyhLbF3JfEFvwSxpRiW5B4daGtnMiK2Oxu/M4VSwb/KN5PcQGD5iZazt4Ms9vm/p9O4t01lAU1WBBTcMBOPe8BhxI3L+R4+A6/8slJeCMeqAn29T7RlQt8lRn3O1Fl2Y9p7IvXsbg/HVSozjQS0LDkGJYBmpvgUyQUgdmtWzCclCwBK7U0PoVUWATMbgmrih2F2BdpcvzXGquEisA97RegZRBXBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWPegqjSjUYD+yn4Xzfk3uuOI2DTUyYdus6qfEEj+qk=;
 b=agauBwfTdvPcRrCBsydhHPg39zaUi4DnWMU/PMd4Dh+NhK2JQthZlU0DSNqQZOleeig63ma7PvrMUBA2cIB7XjisKPPHiNWk9q1Y3YJCBdpUVOarsX9Gxul++Ql6OPDX8Br3NXY4W5ETns7psqsMEHFtwbs9mbdaw+Shb+UyVJEjmFpSBtlZfioz1hmUtH4GVb+5ABIXnqy8785SWWyOiD7Q3SMI/KTvgLouFFSqAkwF1ww9uoUclAr9tX3RJyG8itzJS/yjXUUOxt+5lbeS/SADIsXAPD/wKNIPACb5CU3S/IfOjSWQJVQQV9CQWWY1ZWFAbqy0PeRTC5HC+vlqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWPegqjSjUYD+yn4Xzfk3uuOI2DTUyYdus6qfEEj+qk=;
 b=Y4/bHNDeqbLDRyuUTkT05B2AgZ6ffP4LlYs83qpUYRkovZCUFFvHFnT3CCB4NgcpSLl6WduR8n/eAiYoXXoIrvIiTUsW9ryU8fWoOSaX5sC44DUs2DgtK82+cDlcQoE62aBjuypt3STFyXc2N5tt0jVh/nyo2aJ3ewVe7AfKUV6kGyR3FFeqZCJB4FGqxtCn69jcAEKynsUXokc/MjBluiV/rwdjBytf5gf1TSGxiDchgxsmqPCshz7b9Snw+TU4ZYDNvlQTl5KPzOaROCOO7mSPDZbtDQglKPEzmVXT7CLOOZQ/93TQSS96nR28UByrnSmU1N57LMGfGnKPhoCARQ==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by SA1PR16MB6242.namprd16.prod.outlook.com (2603:10b6:806:3d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 17:14:10 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%4]) with mapi id 15.20.7828.021; Wed, 31 Jul 2024
 17:14:10 +0000
Date: Wed, 31 Jul 2024 12:14:06 -0500
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
 <MN2PR16MB29415FF49F8EA592D0F58164A5B12@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240726194948.109326-1-macroalpha82@gmail.com>
 <20240726194948.109326-3-macroalpha82@gmail.com>
 <eimocj6mlvo6u4x54heywblwrfnftxelzpvfcogpjp7vjmunor@5eqlqsszk6ni>
 <MN2PR16MB2941F5FFA92B056533586FBDA5B12@MN2PR16MB2941.namprd16.prod.outlook.com>
 <2eh5iqwtwlbpg5kpr4lvvhxo2tngw4w7qanelr6filcrru62le@o7cwpsahp2n7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eh5iqwtwlbpg5kpr4lvvhxo2tngw4w7qanelr6filcrru62le@o7cwpsahp2n7>
X-TMN: [mRWvRDJl2SCSwZHR4a9qMRrEhoEQtSqau2kRGnDUfdQ=]
X-ClientProxiedBy: SN4PR0501CA0049.namprd05.prod.outlook.com
 (2603:10b6:803:41::26) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <Zqpw3hPiZMVUFUin@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|SA1PR16MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f96ecc-4655-457f-482d-08dcb18430f5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|5072599009|56899033|1602099012|4302099013|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	/wsFx5KqulltSJndA3x/WWkPYePKgE6G2Hejub0mPj5KiZhZqSlFbYUoD2MKlfj4N3uOwyxeG4qaLTZATWAdb3+8A2sLyedO6YjZT7PIXnVPOv86FWo+P4rZr+96yl/7iq7tTs/z+l6KCK4hAoI2oIMmq7LHeLxhUrf94mXRSQZ3G9LrKyRaOzF1sy30PJxVf8k3Sp8xTqewrfAYFpf48/fGy9JYx1jBXuF6uTM3SqrUVFHaKcnQJccnC4T0l59iN+pImr0qkQtWkyk0tXWXmG8CY226i5mMj8TnORN2DEkyO4SmzYr3U39EYPEoIEnTlAxGUd7WruzEPnKV1ybW5l3DHuoD3Z0yn06fcGYf0adSIbLof3qMPD7NJswWknsaFOm21fv7qBGL7heKbEyw8lUqnn432TOzMf5GIrycbZT7Pz3k6inzicZCXGhezbQTrbALk/WAr4Y1wQb7/7oLE54IkMR14uMD1KeJHbz8ck3B0FVaQpUKKR0hLDDI7lK+qhSzasnC/i3iEEjvQqzkfwd6JkftAeKNWz+Hdag5bQgS/c1EMG+v21CWi+GeLtm9h5Xmut8JHrqUDyoBzbbPIcKWhPPZ8qNcnHK7Zz2TsissMSO1/FkXvqX1bmZmIhmkpEueCxOde6xIzCAUvyLslr0Y2gt91gIMKxHcqBD0PEz34l1bH0cBPb5xKsk5O5S+5AS8XDcES4f5kjZzuC5RVhhz8GNt276dxFg24TypUIFDe6F1BwbT7Od2kv/xkhUDMeT4WxTdDfHmcHQfPBmOpdXNVqHT/EN/x4IBJQR8+pE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jKQLKb6wvXA9Pn5lfOrqxcafdkU7/qexhO+ClSfSNXCqCTzhRdnKmaPVSLKj?=
 =?us-ascii?Q?Sh9yeyDaeKUrVq/7d0ovWu7mvnntabQm8Q1IAeaAIzoSWlVvYr453SFK/Tlt?=
 =?us-ascii?Q?O+/d72kwJ6YtZaUDOC/yPqASZsjT0FyHT5ZAbbjEoU5WDn05jWy4XQTYCB5N?=
 =?us-ascii?Q?EPhxe705SQZkjrssIqfQRJnTBjMyzWj/2QE9CzpjI6eds0hW2UsKlNXsHqf/?=
 =?us-ascii?Q?sMfmDzrT2/UD82JtBotPkpb5woJIImcSYB2fDwKYYmckNFtJalAYSB3QfaUf?=
 =?us-ascii?Q?jNMc5BCTQIy9TYnuZK8Y9H02vxJ3Aoptjom6LfoVJRR3Tr3vmiy6hJgKwFLS?=
 =?us-ascii?Q?vTtJYkNrTe0ecf4kC6R3U5j/a0NEw+pLyj5RDygyhH+qJPqQoUkZuVWhqkN4?=
 =?us-ascii?Q?3xpKgPtTCTO6ACvidi487oioFG3mDQRSv9kBDYw/eqmNUj5ljN3c1P6EzOiA?=
 =?us-ascii?Q?aAY5EXvFvUVsWCILOqjsUEWEtGm20oiRd5NDI5iNI9v7kbr8z20NczBvf5YT?=
 =?us-ascii?Q?9B75WJHabtyPFPbeLbm84yAypCg2ANSw5WOAopyPeq1iAVMzpw46THYNd/dD?=
 =?us-ascii?Q?iCXAe0lWpjCml16UebVSykEyLEhCZKAE2/a4GIQBIYR3rX6YP/Pfsq24Zjc4?=
 =?us-ascii?Q?F9BF3ABKj0XooMr7KQ2r7EQFLSjQLicyUh+UKEs8LApsyEKxCBoEvOJasxZL?=
 =?us-ascii?Q?D05CquO5bzwnM2nc7Tfs0xObcqmoqib6mNmlTSSBZ735yyE8JT40zs+yQyr7?=
 =?us-ascii?Q?xfO5rQOZ4XXDtyb6cLY8TVK6EOJE1eBqT7ttTx986M8OzX+r+Xtr+hJ/z6rG?=
 =?us-ascii?Q?Mq+vF1eskelFvU4y5aj+fah0rZuAKjOr42OZJbcZcmHMzycFzT/NxI5pxo6T?=
 =?us-ascii?Q?E55vCwCZC5PSp9kyomlFYRd3HGVyNbX6Qi1LMcq2kMlTfa8By5BzOfxzuTlf?=
 =?us-ascii?Q?NxHBHDNpFUrwL1hgUsvhhXlcHV6FglxSY9thPkYdeeu21BDby+nrVZgUEKWS?=
 =?us-ascii?Q?kx9UxBYJhMJCr3vIuTx8Sv/U9zOt/L/r0JXlwEpOupBRRWBi4R4sij/u4qMg?=
 =?us-ascii?Q?4MI8lsl94cR1pls1bveO8s6J/2vQ3KJD9RCjcvszbTff/3pngF1yjWWL0F6q?=
 =?us-ascii?Q?YrXhsl7b4PMquMBK/E+Bz5Na1AwRc5q+13l5I6dcfo3ULElUKPKQda8d4BSj?=
 =?us-ascii?Q?u4kz+M4Yn7OClcDCAkNRdB1mCTywyXvWLWFrDO90SXiZcTimtVFTBf2BsbOo?=
 =?us-ascii?Q?7M8hfaKko4lVGwPQDiVa4UIIw24rEZYbYMXt8TPhTw=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f96ecc-4655-457f-482d-08dcb18430f5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 17:14:09.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB6242

On Wed, Jul 31, 2024 at 07:02:28PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jul 31, 2024 at 11:02:11AM GMT, Chris Morgan wrote:
> > On Fri, Jul 26, 2024 at 11:06:21PM +0200, Sebastian Reichel wrote:
> > > Hi,
> > > 
> > > On Fri, Jul 26, 2024 at 02:49:45PM GMT, Chris Morgan wrote:
> > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > > 
> > > > The Cellwise cw2015 datasheet reports that it can handle two cells
> > > > in a series configuration. Allow a device tree parameter to note
> > > > this condition so that the driver reports the correct voltage values
> > > > to userspace.
> > > 
> > > I found this:
> > > 
> > > http://www.cellwise-semi.com/Public/assests/menu/20230302/6400076806706.pdf
> > > 
> > > Which says:
> > > 
> > >   CW2015 can be used in 2 or more batteries connected in series, or
> > >   several cells connected in parallel.
> > > 
> > > So dual-cell seems like a bad property name. Instead the number of
> > > serial cells should be provided. This property is then not really
> > > specific to the Cellwise fuel gauge and instead a property of the
> > > battery pack (i.e. simple-battery.yaml).
> > 
> > It's conflicting information (which further confuses me). I see in that
> > datasheet it says 2 or more, whereas the datasheet found here says only
> > 2 cells:
> > 
> > https://www.lestat.st/_media/informatique/projets/python-cw2015/cw2015-power-management-datasheet.pdf
> > 
> > But I agree in principle that we should be setting this as a property
> > of a simple-battery rather than a manufacturer specific parameter.
> > 
> > > 
> > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > > ---
> > > >  drivers/power/supply/cw2015_battery.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
> > > > index f63c3c410451..b23a6d4fa4fa 100644
> > > > --- a/drivers/power/supply/cw2015_battery.c
> > > > +++ b/drivers/power/supply/cw2015_battery.c
> > > > @@ -77,6 +77,8 @@ struct cw_battery {
> > > >  	u32 poll_interval_ms;
> > > >  	u8 alert_level;
> > > >  
> > > > +	bool dual_cell;
> > > > +
> > > >  	unsigned int read_errors;
> > > >  	unsigned int charge_stuck_cnt;
> > > >  };
> > > > @@ -325,6 +327,9 @@ static int cw_get_voltage(struct cw_battery *cw_bat)
> > > >  	 */
> > > >  	voltage_mv = avg * 312 / 1024;
> > > >  
> > > > +	if (cw_bat->dual_cell)
> > > > +		voltage_mv *= 2;
> > > 
> > > Unfortunately there are no details in the document, but this looks
> > > very fishy. Does it only measure the first cell and hope that the
> > > other cells have the same voltage?
> > > 
> > > This (unmerged) series also applies to your problem to some degree:
> > > 
> > > https://lore.kernel.org/all/20240416121818.543896-3-mike.looijmans@topic.nl/
> > 
> > I think based on the application diagram it is in fact measuring the
> > cell voltage.
> >
> > That said, this ultimately boils down to a cosmetic thing
> > as not having this property simply means userspace sees the battery
> > voltage as 3.8v instead of 7.6v as is written on the side.
> 
> With the cells being connected in serial, the voltage of both cells
> can be different. There is not "the cell voltage". Instead there is
> a voltage for cell 1 and a voltage for cell 2. In a perfect battery
> they are the same, but in reality they are not. In the extreme case
> one of the cells may be broken while the other is still fine. It
> sounds as if this is just measuring the voltage from the first
> cell and assumes the second cell has the same voltage.
> 
> Ideally the voltage on these platforms is not exposed via the normal
> VOLTAGE property and instead uses a new property for telling
> userspace the voltage for a single cell. The kernel simply does not
> know the voltage of the whole battery pack.
> 
> FWIW this is the worst battery measurement system I've seen so far
> if my understanding of the hardware design is correct.
> 
> -- Sebastian
> 

Don't get me started, this whole stack is a nightmare. The battery
won't charge at all without a bq25703 driver (so this current DTS
basically has the device running while plugged in); and for some
reason the fcs,fc302 chip wants to go interrupt crazy if you're not
using a PD charger. Part of the reason of getting this upstreamed
is so I can have a common base for others to help me get this last
bit of nonsense sorted out. Displaying the correct voltage on the
battery however isn't critical, as the device will still report the
correct SoC and will even charge and function just fine when a driver
is in place for the bq25703. It's just the voltage reported in sysfs
will be wrong.

Thank you,
Chris

> > I think for simplification sake I will remove this from the series, add
> > a note to the device tree, and wait for the other battery series to get
> > pulled. When it gets pulled I'll request a device tree property so we
> > can add POWER_SUPPLY_PROP_NUMBER_OF_SERIAL_CELLS to the simple-battery
> > and then parse this value. Or if that series ends up getting abandoned
> > I can just add a quick and dirty new property like this.
> 
> 
> > 
> > Thank you,
> > Chris
> > 
> > > 
> > > -- Sebastian
> > > 
> > > >  	dev_dbg(cw_bat->dev, "Read voltage: %d mV, raw=0x%04x\n",
> > > >  		voltage_mv, reg_val);
> > > >  	return voltage_mv;
> > > > @@ -587,6 +592,8 @@ static int cw2015_parse_properties(struct cw_battery *cw_bat)
> > > >  			return ret;
> > > >  	}
> > > >  
> > > > +	cw_bat->dual_cell = device_property_read_bool(dev, "cellwise,dual-cell");
> > > > +
> > > >  	ret = device_property_read_u32(dev, "cellwise,monitor-interval-ms",
> > > >  				       &cw_bat->poll_interval_ms);
> > > >  	if (ret) {
> > > > -- 
> > > > 2.34.1
> > > > 
> > > > 
> > 
> > 

