Return-Path: <linux-pm+bounces-11867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7567094652C
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 23:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADA82826EA
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 21:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A861369B0;
	Fri,  2 Aug 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jhnH7NOm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4083B13633B;
	Fri,  2 Aug 2024 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634814; cv=none; b=e2AfNuhL+OW2u7K37D2Z6Y8hjDebK+nEOcOj/5EQdcZohGBnWAlY4jmfG9AfRqCTVrEODHSUYsku1/Kp6t9V9b52LokSlHtUjbdjwWUvVFg7Vo98m/shkZ3a1g0TP0AkKTCnWgWAGUoYEQkbM8Zpnp2VC2iFA6NONf1cGfziGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634814; c=relaxed/simple;
	bh=ypv4Ej0W74UdMujDYHI8NpLin45gaIjuOukxTNTiVVw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=npu7z0vUQXUmpIBaa28bdjpIGyYKZRue3NR4YZBJbVteUiVtlJLJow+Xjl8QbwECU8rXH6Fi27f2CB6d5B0zWWdumYg8suSCkBXqYO/B+2gwX/zNtkxc2XBwMGvQw9Q4rDjnKohO4Jb4uN20O+WZcbYGjHXMYgk6PjsaNLeu+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jhnH7NOm; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722634808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWMyYtD9HK9CL+9iAAmomFr8bDQZhT426xXIoar2PO4=;
	b=jhnH7NOmvKHbeckNNNCSIxFjs1VR5Wl7QgbxFULSYt2W7QYbtSSHmIrhtOiZFNDAr8YJcQ
	5Co2ZRt4oZ5sCaebD/dNWNQJhxd2ObJStjjO1i0bfJDisx/VknrCjRHDdFuPVPdou8674x
	7kAh1MwSo406N8cdOVtUU65g8ALBXwmtCesnPAaEBe1/RdC3SORrEJhhxJ4KuiEbJmjvfq
	jhCQgAbrKPNAvbOhitmtgLBdtEt1rYuPz1bpgiI/I4VcFiPw6gpvikQouhSss9oskeB+yK
	4XMwWmM0t4UjphNCXe76bJVE+PZkBpv0U2DU6+Buj3m3lI8DDnCYOCpuw8FLhw==
Date: Fri, 02 Aug 2024 23:39:24 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Chris Morgan <macromorgan@hotmail.com>, Chris Morgan
 <macroalpha82@gmail.com>, linux-rockchip@lists.infradead.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, jagan@edgeble.ai,
 andyshrk@163.com, jonas@kwiboo.se, t.schramm@manjaro.org, heiko@sntech.de,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH 2/5] power: supply: cw2015: Add support for dual-cell
 configurations
In-Reply-To: <2eh5iqwtwlbpg5kpr4lvvhxo2tngw4w7qanelr6filcrru62le@o7cwpsahp2n7>
References: <20240726194948.109326-1-macroalpha82@gmail.com>
 <20240726194948.109326-3-macroalpha82@gmail.com>
 <eimocj6mlvo6u4x54heywblwrfnftxelzpvfcogpjp7vjmunor@5eqlqsszk6ni>
 <MN2PR16MB2941F5FFA92B056533586FBDA5B12@MN2PR16MB2941.namprd16.prod.outlook.com>
 <2eh5iqwtwlbpg5kpr4lvvhxo2tngw4w7qanelr6filcrru62le@o7cwpsahp2n7>
Message-ID: <8c44fcf923c5697ca55c8e32f3938d3b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

On 2024-07-31 19:02, Sebastian Reichel wrote:
> On Wed, Jul 31, 2024 at 11:02:11AM GMT, Chris Morgan wrote:
>> On Fri, Jul 26, 2024 at 11:06:21PM +0200, Sebastian Reichel wrote:
>> > On Fri, Jul 26, 2024 at 02:49:45PM GMT, Chris Morgan wrote:
>> > > From: Chris Morgan <macromorgan@hotmail.com>
>> > >
>> > > The Cellwise cw2015 datasheet reports that it can handle two cells
>> > > in a series configuration. Allow a device tree parameter to note
>> > > this condition so that the driver reports the correct voltage values
>> > > to userspace.
>> >
>> > I found this:
>> >
>> > http://www.cellwise-semi.com/Public/assests/menu/20230302/6400076806706.pdf
>> >
>> > Which says:
>> >
>> >   CW2015 can be used in 2 or more batteries connected in series, or
>> >   several cells connected in parallel.
>> >
>> > So dual-cell seems like a bad property name. Instead the number of
>> > serial cells should be provided. This property is then not really
>> > specific to the Cellwise fuel gauge and instead a property of the
>> > battery pack (i.e. simple-battery.yaml).
>> 
>> It's conflicting information (which further confuses me). I see in 
>> that
>> datasheet it says 2 or more, whereas the datasheet found here says 
>> only
>> 2 cells:
>> 
>> https://www.lestat.st/_media/informatique/projets/python-cw2015/cw2015-power-management-datasheet.pdf
>> 
>> But I agree in principle that we should be setting this as a property
>> of a simple-battery rather than a manufacturer specific parameter.
>> 
>> >
>> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>> > > ---
>> > >  drivers/power/supply/cw2015_battery.c | 7 +++++++
>> > >  1 file changed, 7 insertions(+)
>> > >
>> > > diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
>> > > index f63c3c410451..b23a6d4fa4fa 100644
>> > > --- a/drivers/power/supply/cw2015_battery.c
>> > > +++ b/drivers/power/supply/cw2015_battery.c
>> > > @@ -77,6 +77,8 @@ struct cw_battery {
>> > >  	u32 poll_interval_ms;
>> > >  	u8 alert_level;
>> > >
>> > > +	bool dual_cell;
>> > > +
>> > >  	unsigned int read_errors;
>> > >  	unsigned int charge_stuck_cnt;
>> > >  };
>> > > @@ -325,6 +327,9 @@ static int cw_get_voltage(struct cw_battery *cw_bat)
>> > >  	 */
>> > >  	voltage_mv = avg * 312 / 1024;
>> > >
>> > > +	if (cw_bat->dual_cell)
>> > > +		voltage_mv *= 2;
>> >
>> > Unfortunately there are no details in the document, but this looks
>> > very fishy. Does it only measure the first cell and hope that the
>> > other cells have the same voltage?
>> >
>> > This (unmerged) series also applies to your problem to some degree:
>> >
>> > https://lore.kernel.org/all/20240416121818.543896-3-mike.looijmans@topic.nl/
>> 
>> I think based on the application diagram it is in fact measuring the
>> cell voltage.
>> 
>> That said, this ultimately boils down to a cosmetic thing
>> as not having this property simply means userspace sees the battery
>> voltage as 3.8v instead of 7.6v as is written on the side.
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

Please note that two facts should be considered here:

  - The GenBook schematic [1] clearly shows that the individual battery
    cells aren't exposed at its internal battery connector and, as a
    result, aren't available for individual cell voltage monitoring

  - The GenBook uses a CW2013 as it fuel gauge, [1] instead of CW2015
    as mentioned here a few times, but I haven't went through the CW2013
    datasheet(s) yet to see what are the actual differences between it
    and the CW2015

[1] https://wiki.cool-pi.com/notebook/coolpi-genbook-v20.pdf

>> I think for simplification sake I will remove this from the series, 
>> add
>> a note to the device tree, and wait for the other battery series to 
>> get
>> pulled. When it gets pulled I'll request a device tree property so we
>> can add POWER_SUPPLY_PROP_NUMBER_OF_SERIAL_CELLS to the simple-battery
>> and then parse this value. Or if that series ends up getting abandoned
>> I can just add a quick and dirty new property like this.
>> >
>> > >  	dev_dbg(cw_bat->dev, "Read voltage: %d mV, raw=0x%04x\n",
>> > >  		voltage_mv, reg_val);
>> > >  	return voltage_mv;
>> > > @@ -587,6 +592,8 @@ static int cw2015_parse_properties(struct cw_battery *cw_bat)
>> > >  			return ret;
>> > >  	}
>> > >
>> > > +	cw_bat->dual_cell = device_property_read_bool(dev, "cellwise,dual-cell");
>> > > +
>> > >  	ret = device_property_read_u32(dev, "cellwise,monitor-interval-ms",
>> > >  				       &cw_bat->poll_interval_ms);
>> > >  	if (ret) {
>> > > --
>> > > 2.34.1

