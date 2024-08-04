Return-Path: <linux-pm+bounces-11901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C9F946FDA
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 18:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B221F212AD
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7856612E1DB;
	Sun,  4 Aug 2024 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="nwQhVRrk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267CFA953;
	Sun,  4 Aug 2024 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722789763; cv=none; b=eCglgethhyBLSz84sSZ5uGm2U54QujpmuU7/2CV4iCPji1hF1hLO1nOkDzzAdcaBNE+LWvv+v1lVoZBNkWPTas61nEtspHhWV1mEAOqJ25FWCmhGb6MGRQ3oKBiNoAiKdPFO0zSMATtLUUQqbC0cov+4fhtdICs8u2feMYh7T9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722789763; c=relaxed/simple;
	bh=LARGR0YvnxUUkWf2N80Ni345giEWSBrb+seJpdxHfJ4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=g0Md8oEXuv4S1xNdh3z9dwKjPeTdFZERvvY9PahQgKL7xldbKZmvmaYecO1KRmYhOVzknuY6c/r8o1YszFslfMPkmquKlMQNyjtvzDoW4lCz7EBuVVjWc9J83NzYF/I2+0r5Qfahrmje3kv0Dq1q/lHIvGOuB3UCVkt00Jnlh00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=nwQhVRrk; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722789757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+F7emmNBcXh0+ylTI7cNI8gyP1ykWrKeR7FpFCiKok=;
	b=nwQhVRrkCCmt3H3QMTje70Mcu40bTsrr2z5hBROGBjkHNo4JTOnEtBZNgaC7udEV2gZsoT
	2aoB1XxGWGekO9rn7bnEA0UYWopQhJQGc12XAOaATig25o0p1gaUByFkug50+w8dSKXpoe
	HUZgPtvf/vM7cy4T433j8tml6G53qbJX1mlYVf/D+3YLZ28lIcU0ICHU+4r1aHkqRkCz+w
	nERPBi7vDhTN4tHO5vpuNHqFQY64wCF2h8zOzU544Fuj0yisGVl13X3wwiqdeh12qg5MhH
	zJ+2jxT1/uEJ8JGX1+IakqrWg5V/tav3DHLT/JjTe9nt5Hxd80Y0jCdpt7FJCg==
Date: Sun, 04 Aug 2024 18:42:36 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Chris Morgan <macromorgan@hotmail.com>, Chris Morgan
 <macroalpha82@gmail.com>, linux-rockchip@lists.infradead.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, jagan@edgeble.ai,
 andyshrk@163.com, jonas@kwiboo.se, t.schramm@manjaro.org, heiko@sntech.de,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 george@cool-pi.com, coolpi@cool-pi.com
Subject: Re: [PATCH 2/5] power: supply: cw2015: Add support for dual-cell
 configurations
In-Reply-To: <3fgf7jyla6gtxqppjjnjb5dgciqqus2iwjunjavlmhy7fxdqv7@a2iycmzlgkbb>
References: <20240726194948.109326-1-macroalpha82@gmail.com>
 <20240726194948.109326-3-macroalpha82@gmail.com>
 <eimocj6mlvo6u4x54heywblwrfnftxelzpvfcogpjp7vjmunor@5eqlqsszk6ni>
 <MN2PR16MB2941F5FFA92B056533586FBDA5B12@MN2PR16MB2941.namprd16.prod.outlook.com>
 <2eh5iqwtwlbpg5kpr4lvvhxo2tngw4w7qanelr6filcrru62le@o7cwpsahp2n7>
 <8c44fcf923c5697ca55c8e32f3938d3b@manjaro.org>
 <3fgf7jyla6gtxqppjjnjb5dgciqqus2iwjunjavlmhy7fxdqv7@a2iycmzlgkbb>
Message-ID: <20abe950c5e22a3fed4e0cbdb31089d8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Sebastian,

(I'm adding a couple of Cool Pi contacts to the Cc list.)

On 2024-08-04 18:29, Sebastian Reichel wrote:
> On Fri, Aug 02, 2024 at 11:39:24PM GMT, Dragan Simic wrote:
>> On 2024-07-31 19:02, Sebastian Reichel wrote:
>> > On Wed, Jul 31, 2024 at 11:02:11AM GMT, Chris Morgan wrote:
>> > > On Fri, Jul 26, 2024 at 11:06:21PM +0200, Sebastian Reichel wrote:
>> > > > On Fri, Jul 26, 2024 at 02:49:45PM GMT, Chris Morgan wrote:
>> > > > > From: Chris Morgan <macromorgan@hotmail.com>
>> > > > >
>> > > > > The Cellwise cw2015 datasheet reports that it can handle two cells
>> > > > > in a series configuration. Allow a device tree parameter to note
>> > > > > this condition so that the driver reports the correct voltage values
>> > > > > to userspace.
>> > > >
>> > > > I found this:
>> > > >
>> > > > http://www.cellwise-semi.com/Public/assests/menu/20230302/6400076806706.pdf
>> > > >
>> > > > Which says:
>> > > >
>> > > >   CW2015 can be used in 2 or more batteries connected in series, or
>> > > >   several cells connected in parallel.
>> > > >
>> > > > So dual-cell seems like a bad property name. Instead the number of
>> > > > serial cells should be provided. This property is then not really
>> > > > specific to the Cellwise fuel gauge and instead a property of the
>> > > > battery pack (i.e. simple-battery.yaml).
>> > >
>> > > It's conflicting information (which further confuses me). I see in
>> > > that
>> > > datasheet it says 2 or more, whereas the datasheet found here says
>> > > only
>> > > 2 cells:
>> > >
>> > > https://www.lestat.st/_media/informatique/projets/python-cw2015/cw2015-power-management-datasheet.pdf
>> > >
>> > > But I agree in principle that we should be setting this as a property
>> > > of a simple-battery rather than a manufacturer specific parameter.
>> > >
>> > > >
>> > > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>> > > > > ---
>> > > > >  drivers/power/supply/cw2015_battery.c | 7 +++++++
>> > > > >  1 file changed, 7 insertions(+)
>> > > > >
>> > > > > diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
>> > > > > index f63c3c410451..b23a6d4fa4fa 100644
>> > > > > --- a/drivers/power/supply/cw2015_battery.c
>> > > > > +++ b/drivers/power/supply/cw2015_battery.c
>> > > > > @@ -77,6 +77,8 @@ struct cw_battery {
>> > > > >  	u32 poll_interval_ms;
>> > > > >  	u8 alert_level;
>> > > > >
>> > > > > +	bool dual_cell;
>> > > > > +
>> > > > >  	unsigned int read_errors;
>> > > > >  	unsigned int charge_stuck_cnt;
>> > > > >  };
>> > > > > @@ -325,6 +327,9 @@ static int cw_get_voltage(struct cw_battery *cw_bat)
>> > > > >  	 */
>> > > > >  	voltage_mv = avg * 312 / 1024;
>> > > > >
>> > > > > +	if (cw_bat->dual_cell)
>> > > > > +		voltage_mv *= 2;
>> > > >
>> > > > Unfortunately there are no details in the document, but this looks
>> > > > very fishy. Does it only measure the first cell and hope that the
>> > > > other cells have the same voltage?
>> > > >
>> > > > This (unmerged) series also applies to your problem to some degree:
>> > > >
>> > > > https://lore.kernel.org/all/20240416121818.543896-3-mike.looijmans@topic.nl/
>> > >
>> > > I think based on the application diagram it is in fact measuring the
>> > > cell voltage.
>> > >
>> > > That said, this ultimately boils down to a cosmetic thing
>> > > as not having this property simply means userspace sees the battery
>> > > voltage as 3.8v instead of 7.6v as is written on the side.
>> >
>> > With the cells being connected in serial, the voltage of both cells
>> > can be different. There is not "the cell voltage". Instead there is
>> > a voltage for cell 1 and a voltage for cell 2. In a perfect battery
>> > they are the same, but in reality they are not. In the extreme case
>> > one of the cells may be broken while the other is still fine. It
>> > sounds as if this is just measuring the voltage from the first
>> > cell and assumes the second cell has the same voltage.
>> >
>> > Ideally the voltage on these platforms is not exposed via the normal
>> > VOLTAGE property and instead uses a new property for telling
>> > userspace the voltage for a single cell. The kernel simply does not
>> > know the voltage of the whole battery pack.
>> >
>> > FWIW this is the worst battery measurement system I've seen so far
>> > if my understanding of the hardware design is correct.
>> 
>> Please note that two facts should be considered here:
>> 
>>  - The GenBook schematic [1] clearly shows that the individual battery
>>    cells aren't exposed at its internal battery connector and, as a
>>    result, aren't available for individual cell voltage monitoring
>> 
>>  - The GenBook uses a CW2013 as it fuel gauge, [1] instead of CW2015
>>    as mentioned here a few times, but I haven't went through the 
>> CW2013
>>    datasheet(s) yet to see what are the actual differences between it
>>    and the CW2015
>> 
>> [1] https://wiki.cool-pi.com/notebook/coolpi-genbook-v20.pdf
> 
> Ah, thanks for pointing to the schematics. So the fuel gauge can
> only measure the voltage of the whole battery, but VCELL register
> provides the voltage for 1 cell? What is the origin of the dual-cell
> property? Was this something you came up with yourself when noticing
> the wrong voltage?

I'm not sure where does the idea for the dual-cell property come from,
but please note that it wasn't me who invented it, so to speak. :)
I don't even have the required hardware to test and develop these 
patches
on, i.e. I don't have a CM5-based GenBook.

> Based on the above information my guess would be that CW2013 uses a
> different voltage resolution than CW2015 for the VCELL register. The
> datasheet for CW2015 says 14bit ADC with 305uV resolution. Maybe
> the CW2013 simply uses a different ADC. Do you have the datasheet
> for the chip?

I've managed to find a few (seemingly a bit different) CW2013 
datasheets,
but as usual with CellWise, some of them may contain a bit confusing or
incomplete information.  I'd suggest that you wait for a couple of days
until I sift through the obtained datasheets, to save you from doing the
same. :)  Of course, I'll then send over the datasheet that seems 
correct
and the most complete to me.

I'll see to add support for CW2013 to the cw2015 driver, for which I
already have a couple of pending cleanup patches.

