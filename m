Return-Path: <linux-pm+bounces-11305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3656A9393B1
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 20:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5961B1C21707
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A868A17166F;
	Mon, 22 Jul 2024 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWgngvKz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C217166C;
	Mon, 22 Jul 2024 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673697; cv=none; b=RUTVVCqG9rAJOIFI90nIU9zo+iTwF9yEP3DU2zKln3NK1qYxJcpVtcXElRAVZ6vVy1lYnffZpcFBlu4nO/Cg07Oh2Qpf6cIo+UznDJoB86/YmJDYl/s/n/w9roRwNuGiXddaTqZP33l1bTq9GxCYtvz50zal5nMOtbPjEmxG7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673697; c=relaxed/simple;
	bh=jpz7e8eqJKOIIFmUM2OLbD+ZbV7BiNw4xX9O8bTWzLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZQSLIqFN56INNxhdKb+YWJ4gb2Dn9cb5qFikvYEylQBEcdvBaBHK4qvbnIJKgKsis21SwvHOxH6WFAb8g0StyDbnRczsTn5ySuU191YFe1rmZjT0Jbn6A9IBcyidckwBWbanlSiI5AXbd1UwOfGfHlpXZ+QvQF29grEWB4hToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWgngvKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B591FC116B1;
	Mon, 22 Jul 2024 18:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721673697;
	bh=jpz7e8eqJKOIIFmUM2OLbD+ZbV7BiNw4xX9O8bTWzLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWgngvKzT+sA0QEw+XbaXjZ5ubmQAgvXANr8RPBCTrBLlKAaofx3563aGlK1uZdh6
	 MFMv4Ke0wwhIgBlXsgo1AHQNOifGjezkemr8NKuiSL1nuLtTufwJm34uHtCRJ4iB7s
	 V4nGAkfo1y2P27pPcEDZxJU3tDV4wlD/pDg2cVLjGqqAFMYYWV6bm8pF9/OwNPqAKo
	 UPmaIA1zHyu6J3OK707dDWtgOhVn3F/gBymklO0/mfKaoEFKtDMFtrYOBT20oaefXY
	 EX+hbnwkWUyaDvKBxe8coymnnIMS9+0xtPZoGaXoOlK1yAZCtVI7EgKkEbDMZcUKXe
	 3l796txenFsmQ==
Received: by pali.im (Postfix)
	id 0A9D9AA4; Mon, 22 Jul 2024 20:41:32 +0200 (CEST)
Date: Mon, 22 Jul 2024 20:41:32 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Andres Salomon <dilinger@queued.net>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] platform/x86:dell-laptop: Add knobs to change battery
 charge settings
Message-ID: <20240722184132.l6nibqkpna2wkszo@pali>
References: <20240720084019.hrnd4wgt4muorydp@pali>
 <20240720052419.73b1415a@5400>
 <20240720095507.uyaotkofkyasdgbd@pali>
 <20240720220606.1934df43@5400>
 <20240721090238.wrei5nu6y3awujws@pali>
 <20240721193716.3156050f@5400>
 <20240721234037.nxthfeqdjl3z74oc@pali>
 <20240721195851.76e2b220@5400>
 <20240722071845.w7v23ixu5wujrpol@pali>
 <20240722143432.35c356b1@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240722143432.35c356b1@5400>
User-Agent: NeoMutt/20180716

On Monday 22 July 2024 14:34:32 Andres Salomon wrote:
> On Mon, 22 Jul 2024 09:18:45 +0200
> Pali Rohár <pali@kernel.org> wrote:
> 
> > On Sunday 21 July 2024 19:58:51 Andres Salomon wrote:
> > > On Mon, 22 Jul 2024 01:40:37 +0200
> > > Pali Rohár <pali@kernel.org> wrote:
> > >   
> > > > On Sunday 21 July 2024 19:37:16 Andres Salomon wrote:  
> > > > > On Sun, 21 Jul 2024 11:02:38 +0200
> > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > >     
> > > > > > On Saturday 20 July 2024 22:06:06 Andres Salomon wrote:    
> > > > > > > On Sat, 20 Jul 2024 11:55:07 +0200
> > > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > >       
> > > > > > > > On Saturday 20 July 2024 05:24:19 Andres Salomon wrote:      
> > > > > > > > > Thanks for the quick feedback! Responses below.
> > > > > > > > > 
> > > > > > > > > On Sat, 20 Jul 2024 10:40:19 +0200
> > > > > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > > > >         
> > > > > 
> > > > > [...]
> > > > >     
> > > > > > > > > > > +
> > > > > > > > > > > +static void __init dell_battery_init(struct device *dev)
> > > > > > > > > > > +{
> > > > > > > > > > > +	enum battery_charging_mode current_mode = DELL_BAT_MODE_NONE;
> > > > > > > > > > > +
> > > > > > > > > > > +	dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN, (int *) &current_mode);
> > > > > > > > > > > +	if (current_mode != DELL_BAT_MODE_NONE) {          
> > > > > > > > > > 
> > > > > > > > > > I quite do not understand how is this code suppose to work.
> > > > > > > > > > 
> > > > > > > > > > Why is there mix of custom kernel enum battery_charging_mode and return
> > > > > > > > > > value from Dell's API?        
> > > > > > > > > 
> > > > > > > > > This is from the original patch from Dell; tbh, I'm not sure. It does
> > > > > > > > > work, though. That is, current_mode ends up holding the correct value
> > > > > > > > > based on what was previously set, even if the charging mode is set from
> > > > > > > > > the BIOS.
> > > > > > > > > 
> > > > > > > > > I just scanned through the libsmbios code to see what it's doing, and
> > > > > > > > > it appears to loop through every charging mode to check if its active.
> > > > > > > > > I'm not really sure that makes much more sense, so I'll try some more
> > > > > > > > > tests.        
> > > > > > > > 
> > > > > > > > Keyboard backlight code (kbd_get_first_active_token_bit) is doing also
> > > > > > > > this type scan. If I remember correctly, for every keyboard backlight
> > > > > > > > token we just know the boolean value - if the token is set or not.
> > > > > > > > 
> > > > > > > > It would really nice to see what (raw) value is returned by the
> > > > > > > > dell_battery_read_req(token) function for every battery token and for
> > > > > > > > every initial state.      
> > > > > > > 
> > > > > > > I checked this. The BIOS sets the mode value in every related token
> > > > > > > location. I'm still not really sure what libsmbios is doing, but the
> > > > > > > kernel code seems to arbitrarily choose one of the token locations
> > > > > > > to read from. This makes sense to me now.
> > > > > > > 
> > > > > > > In the BIOS when I set the mode to "ExpressCharge",
> > > > > > > this what I pulled for each token location:
> > > > > > > 
> > > > > > > [    5.704651] dell-laptop dell-laptop: BAT_CUSTOM_MODE_TOKEN value: 2
> > > > > > > [    5.707015] dell-laptop dell-laptop: BAT_PRI_AC_MODE_TOKEN value: 2
> > > > > > > [    5.709114] dell-laptop dell-laptop: BAT_ADAPTIVE_MODE_TOKEN value: 2
> > > > > > > [    5.711041] dell-laptop dell-laptop: BAT_STANDARD_MODE_TOKEN value: 2
> > > > > > > [    5.713705] dell-laptop dell-laptop: BAT_EXPRESS_MODE_TOKEN value: 2
> > > > > > > 
> > > > > > > Similar story when I set it to Custom (all were '5'), or Standard ('1').
> > > > > > > When I set it from linux as well, it changed all location values.      
> > > > > > 
> > > > > > Interesting... Anyway, I still think that the API could be similar to
> > > > > > what is used in keyboard backlight.
> > > > > > 
> > > > > > Could you please dump all information about each token? They are in
> > > > > > struct calling_interface_token returned by dell_smbios_find_token.
> > > > > > 
> > > > > > I'm interesting in tokenID, location and value.
> > > > > > 
> > > > > > Ideally to compare what is in token->value and then in buffer.output[1]
> > > > > > (in case dell_send_request does not fail).    
> > > > > 
> > > > > 
> > > > > Alright, here's what I see:
> > > > > 
> > > > > [    5.904775] dell_laptop: dell_battery_read_req: token requested: 0x343, tokenID=0x343, location=0x343, value=5
> > > > > [    5.908675] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> > > > > [    5.908680] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TOKEN value: 3
> > > > > [    5.908682] dell_laptop: dell_battery_read_req: token requested: 0x341, tokenID=0x341, location=0x341, value=3
> > > > > [    5.910922] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> > > > > [    5.910926] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TOKEN value: 3
> > > > > [    5.910928] dell_laptop: dell_battery_read_req: token requested: 0x342, tokenID=0x342, location=0x342, value=4
> > > > > [    5.913042] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> > > > > [    5.913046] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_TOKEN value: 3
> > > > > [    5.913048] dell_laptop: dell_battery_read_req: token requested: 0x346, tokenID=0x346, location=0x346, value=1
> > > > > [    5.914996] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> > > > > [    5.914999] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_TOKEN value: 3
> > > > > [    5.915000] dell_laptop: dell_battery_read_req: token requested: 0x347, tokenID=0x347, location=0x347, value=2
> > > > > [    5.916723] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> > > > > [    5.916724] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_TOKEN value: 3
> > > > > [    5.916725] dell_laptop: dell_battery_read_req: token requested: 0x349, tokenID=0x349, location=0x349, value=65535
> > > > > [    5.918727] dell_laptop: dell_battery_read_req: buffer.output[1]=65
> > > > > [    5.918731] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_START value: 65
> > > > > [    5.918734] dell_laptop: dell_battery_read_req: token requested: 0x34a, tokenID=0x34a, location=0x34a, value=65535
> > > > > [    5.920864] dell_laptop: dell_battery_read_req: buffer.output[1]=85
> > > > > [    5.920867] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_END value: 85    
> > > > 
> > > > Perfect. And can you check dumps when the mode is set to some other than BAT_PRI_AC_MODE_TOKEN?  
> > > 
> > > Here's Express:
> > > 
> > > [    5.880090] dell_laptop: dell_battery_read_req: token requested: 0x343, tokenID=0x343, location=0x343, value=5
> > > [    5.882011] dell_laptop: dell_battery_read_req: buffer.output[1]=2
> > > [    5.882014] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TOKEN value: 2
> > > [    5.882016] dell_laptop: dell_battery_read_req: token requested: 0x341, tokenID=0x341, location=0x341, value=3
> > > [    5.894513] dell_laptop: dell_battery_read_req: buffer.output[1]=2
> > > [    5.894518] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TOKEN value: 2
> > > [    5.894520] dell_laptop: dell_battery_read_req: token requested: 0x342, tokenID=0x342, location=0x342, value=4
> > > [    5.913870] dell_laptop: dell_battery_read_req: buffer.output[1]=2
> > > [    5.913874] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_TOKEN value: 2
> > > [    5.913875] dell_laptop: dell_battery_read_req: token requested: 0x346, tokenID=0x346, location=0x346, value=1
> > > [    5.915622] dell_laptop: dell_battery_read_req: buffer.output[1]=2
> > > [    5.915625] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_TOKEN value: 2
> > > [    5.915626] dell_laptop: dell_battery_read_req: token requested: 0x347, tokenID=0x347, location=0x347, value=2
> > > [    5.917349] dell_laptop: dell_battery_read_req: buffer.output[1]=2
> > > [    5.917351] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_TOKEN value: 2
> > > [    5.917352] dell_laptop: dell_battery_read_req: token requested: 0x349, tokenID=0x349, location=0x349, value=65535
> > > [    5.919068] dell_laptop: dell_battery_read_req: buffer.output[1]=65
> > > [    5.919070] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_START value: 65
> > > [    5.919071] dell_laptop: dell_battery_read_req: token requested: 0x34a, tokenID=0x34a, location=0x34a, value=65535
> > > [    5.920780] dell_laptop: dell_battery_read_req: buffer.output[1]=85
> > > [    5.920782] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_END value: 85
> > > 
> > > And here's Adaptive:
> > > 
> > > [    5.945319] dell_laptop: dell_battery_read_req: token requested: 0x343, tokenID=0x343, location=0x343, value=5
> > > [    5.973685] dell_laptop: dell_battery_read_req: buffer.output[1]=4
> > > [    5.973690] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TOKEN value: 4
> > > [    5.973692] dell_laptop: dell_battery_read_req: token requested: 0x341, tokenID=0x341, location=0x341, value=3
> > > [    5.976533] dell_laptop: dell_battery_read_req: buffer.output[1]=4
> > > [    5.976538] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TOKEN value: 4
> > > [    5.976540] dell_laptop: dell_battery_read_req: token requested: 0x342, tokenID=0x342, location=0x342, value=4
> > > [    5.981013] dell_laptop: dell_battery_read_req: buffer.output[1]=4
> > > [    5.981018] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_TOKEN value: 4
> > > [    5.981020] dell_laptop: dell_battery_read_req: token requested: 0x346, tokenID=0x346, location=0x346, value=1
> > > [    5.983474] dell_laptop: dell_battery_read_req: buffer.output[1]=4
> > > [    5.983479] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_TOKEN value: 4
> > > [    5.983481] dell_laptop: dell_battery_read_req: token requested: 0x347, tokenID=0x347, location=0x347, value=2
> > > [    5.985881] dell_laptop: dell_battery_read_req: buffer.output[1]=4
> > > [    5.985885] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_TOKEN value: 4
> > > [    5.985887] dell_laptop: dell_battery_read_req: token requested: 0x349, tokenID=0x349, location=0x349, value=65535
> > > [    5.988332] dell_laptop: dell_battery_read_req: buffer.output[1]=65
> > > [    5.988337] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_START value: 65
> > > [    5.988339] dell_laptop: dell_battery_read_req: token requested: 0x34a, tokenID=0x34a, location=0x34a, value=65535
> > > [    5.990769] dell_laptop: dell_battery_read_req: buffer.output[1]=85
> > > [    5.990774] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_END value: 85
> > > 
> > > 
> > > 
> > > -- 
> > > I'm available for contract & employment work, see:
> > > https://spindle.queued.net/~dilinger/resume-tech.pdf  
> > 
> > Nice! So it is exactly same as API of keyboard backlight tokens. Thanks.
> > 
> > In dell_battery_write_req function you can drop second "val" argument
> > and replace it by token->value. So the dell_fill_request call in that
> > function would look like:
> > 
> >     dell_fill_request(&buffer, token->location, token->value, 0, 0);
> 
> 
> Well, except that we use dell_battery_write_req for writing the charge
> start/end values as well (in dell_battery_custom_set). Those can't be
> obtained from token->value.
> 
> We could have two separate functions for that, or set 'val' to a
> sentinel value (0) that, if detected, we set val=token->value. I'm
> still not really understanding the point, though.

I think that two separate functions would be needed. One which set
battery mode (enum) and which set custom thresholds.

> > 
> > And then you can mimic the usage as it is done in keyboard backlight
> > functions (kbd_get_first_active_token_bit).
> > 
> > If you do not know what I mean then later (today or tomorrow) I can
> > write code example of the functionality.
> 
> Sorry, I still don't understand what the goal is here. Is the goal to
> not pull from a random location to determine the current charging mode?
> Is the goal to determine what charging modes are currently supported
> (and if so, I don't see how)? Is the goal to avoid having the kernel
> hardcode a list of enums that the BIOS might have different values
> for? Is the goal to merge the keyboard backlight and battery setting
> functions?

Avoid having the kernel hardcoded values for enums which SMBIOS
provides. Future (or maybe also older) modes may have different enum
values. So we should use what SMBIOS provides to us.

Also to determinate which charging modes are supported by the current HW
configuration. If BIOS does not support some mode or does not allow to
set some mode, kernel should not export this as supported option.

If you do not see how to do it, please give me some time, I will send
you an example. Going to look at it right now.

Merging keyboard backlight and battery code is bonus, not required.
But I thought that it would be easier to build a new code from common
blocks.

