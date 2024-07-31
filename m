Return-Path: <linux-pm+bounces-11766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB519434A9
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 19:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C582880E2
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 17:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E7F1BD516;
	Wed, 31 Jul 2024 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s4exjKh3"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD781B5AA;
	Wed, 31 Jul 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445353; cv=none; b=QVrL3LYKI4rCmbOlyBLncQk8aFbsDIqUmO32mTbdOUidxoGvEzdg8ykRIQshKenPYBeWsGYkmmImLI2tMsw+WSPlw8huDQMnL/M6wKqhljEQKIdRgHT74ocwGY2vrMEXyTMYbJg9OVQ18P+TMUTmztjvaE4PN0Q9vq6YBjfPfcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445353; c=relaxed/simple;
	bh=qGzzunRIYxeTcWj7omTdrSNOG9dCO97PljZMNVe2e5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqTF1q36fUwACkvbgQZEbC+c7/E3vYWi2BbJvWq4BsUuRhDn3histTIFvpq5mwdkZMTBRcddAHCiN7EdtXfeCwDaezO1jHP0XFxRFv44/jhNhwPxIJ0mfw12l8rDroDaK4/fNLVTmam37y8o+S5/oeRPSEkzuw5AGtzMXGfEJWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s4exjKh3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722445349;
	bh=qGzzunRIYxeTcWj7omTdrSNOG9dCO97PljZMNVe2e5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4exjKh3pPkozbOL087t7JdBLujhE58hBWR4pRjZIQiFw6BFLy23cVUT6pHCgqZ/R
	 GzdliexMTTvKJWsF0/s7Wb/EUOvnr4wKFc2wPL9WWohIYkqGAWPkVWGC8rckcNgCun
	 +VeHg1wA2ZaXr4MxlQepFutykpxl2uS5mCRzVVPWHcHBRDoV05HLzM+4Gy2taYrhq+
	 hGO5AiZYlEe21wlPL3N54CMU37hhqgPjB/bTLgc8s56DUfkx0Hy5bmRxNeLFX5myr3
	 Qg9lFuKhugDHlD57DMhcf4g3N+9eQox5zwml4mvFh+vth2nGTEAkmtAJNEEnoT1/nw
	 NM5qijnvXlfTQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D7DC13782200;
	Wed, 31 Jul 2024 17:02:28 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 7EBA710609BB; Wed, 31 Jul 2024 19:02:28 +0200 (CEST)
Date: Wed, 31 Jul 2024 19:02:28 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, 
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	jagan@edgeble.ai, andyshrk@163.com, jonas@kwiboo.se, t.schramm@manjaro.org, 
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH 2/5] power: supply: cw2015: Add support for dual-cell
 configurations
Message-ID: <2eh5iqwtwlbpg5kpr4lvvhxo2tngw4w7qanelr6filcrru62le@o7cwpsahp2n7>
References: <20240726194948.109326-1-macroalpha82@gmail.com>
 <20240726194948.109326-3-macroalpha82@gmail.com>
 <eimocj6mlvo6u4x54heywblwrfnftxelzpvfcogpjp7vjmunor@5eqlqsszk6ni>
 <MN2PR16MB2941F5FFA92B056533586FBDA5B12@MN2PR16MB2941.namprd16.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR16MB2941F5FFA92B056533586FBDA5B12@MN2PR16MB2941.namprd16.prod.outlook.com>

Hi,

On Wed, Jul 31, 2024 at 11:02:11AM GMT, Chris Morgan wrote:
> On Fri, Jul 26, 2024 at 11:06:21PM +0200, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Fri, Jul 26, 2024 at 02:49:45PM GMT, Chris Morgan wrote:
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > 
> > > The Cellwise cw2015 datasheet reports that it can handle two cells
> > > in a series configuration. Allow a device tree parameter to note
> > > this condition so that the driver reports the correct voltage values
> > > to userspace.
> > 
> > I found this:
> > 
> > http://www.cellwise-semi.com/Public/assests/menu/20230302/6400076806706.pdf
> > 
> > Which says:
> > 
> >   CW2015 can be used in 2 or more batteries connected in series, or
> >   several cells connected in parallel.
> > 
> > So dual-cell seems like a bad property name. Instead the number of
> > serial cells should be provided. This property is then not really
> > specific to the Cellwise fuel gauge and instead a property of the
> > battery pack (i.e. simple-battery.yaml).
> 
> It's conflicting information (which further confuses me). I see in that
> datasheet it says 2 or more, whereas the datasheet found here says only
> 2 cells:
> 
> https://www.lestat.st/_media/informatique/projets/python-cw2015/cw2015-power-management-datasheet.pdf
> 
> But I agree in principle that we should be setting this as a property
> of a simple-battery rather than a manufacturer specific parameter.
> 
> > 
> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > ---
> > >  drivers/power/supply/cw2015_battery.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
> > > index f63c3c410451..b23a6d4fa4fa 100644
> > > --- a/drivers/power/supply/cw2015_battery.c
> > > +++ b/drivers/power/supply/cw2015_battery.c
> > > @@ -77,6 +77,8 @@ struct cw_battery {
> > >  	u32 poll_interval_ms;
> > >  	u8 alert_level;
> > >  
> > > +	bool dual_cell;
> > > +
> > >  	unsigned int read_errors;
> > >  	unsigned int charge_stuck_cnt;
> > >  };
> > > @@ -325,6 +327,9 @@ static int cw_get_voltage(struct cw_battery *cw_bat)
> > >  	 */
> > >  	voltage_mv = avg * 312 / 1024;
> > >  
> > > +	if (cw_bat->dual_cell)
> > > +		voltage_mv *= 2;
> > 
> > Unfortunately there are no details in the document, but this looks
> > very fishy. Does it only measure the first cell and hope that the
> > other cells have the same voltage?
> > 
> > This (unmerged) series also applies to your problem to some degree:
> > 
> > https://lore.kernel.org/all/20240416121818.543896-3-mike.looijmans@topic.nl/
> 
> I think based on the application diagram it is in fact measuring the
> cell voltage.
>
> That said, this ultimately boils down to a cosmetic thing
> as not having this property simply means userspace sees the battery
> voltage as 3.8v instead of 7.6v as is written on the side.

With the cells being connected in serial, the voltage of both cells
can be different. There is not "the cell voltage". Instead there is
a voltage for cell 1 and a voltage for cell 2. In a perfect battery
they are the same, but in reality they are not. In the extreme case
one of the cells may be broken while the other is still fine. It
sounds as if this is just measuring the voltage from the first
cell and assumes the second cell has the same voltage.

Ideally the voltage on these platforms is not exposed via the normal
VOLTAGE property and instead uses a new property for telling
userspace the voltage for a single cell. The kernel simply does not
know the voltage of the whole battery pack.

FWIW this is the worst battery measurement system I've seen so far
if my understanding of the hardware design is correct.

-- Sebastian

> I think for simplification sake I will remove this from the series, add
> a note to the device tree, and wait for the other battery series to get
> pulled. When it gets pulled I'll request a device tree property so we
> can add POWER_SUPPLY_PROP_NUMBER_OF_SERIAL_CELLS to the simple-battery
> and then parse this value. Or if that series ends up getting abandoned
> I can just add a quick and dirty new property like this.


> 
> Thank you,
> Chris
> 
> > 
> > -- Sebastian
> > 
> > >  	dev_dbg(cw_bat->dev, "Read voltage: %d mV, raw=0x%04x\n",
> > >  		voltage_mv, reg_val);
> > >  	return voltage_mv;
> > > @@ -587,6 +592,8 @@ static int cw2015_parse_properties(struct cw_battery *cw_bat)
> > >  			return ret;
> > >  	}
> > >  
> > > +	cw_bat->dual_cell = device_property_read_bool(dev, "cellwise,dual-cell");
> > > +
> > >  	ret = device_property_read_u32(dev, "cellwise,monitor-interval-ms",
> > >  				       &cw_bat->poll_interval_ms);
> > >  	if (ret) {
> > > -- 
> > > 2.34.1
> > > 
> > > 
> 
> 

