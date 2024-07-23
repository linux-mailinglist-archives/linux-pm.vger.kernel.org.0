Return-Path: <linux-pm+bounces-11321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CD9939BBA
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 09:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFB7EB21159
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 07:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A0E13D28A;
	Tue, 23 Jul 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eooe7LSl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557F53A7;
	Tue, 23 Jul 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719821; cv=none; b=JTbVA8OR41hDEG8+3xPiPbFha+hhiAQJc3NyWfeLfhJYsiZ9lBfPFwqAI/IIGSdagpjrVuj2X4c646s3c1T5p0u6sjpUmOnTFlmIoeZrUfwRIEKsBmSXNQVaRd5UNuWXw5nucW9pm58PkkMo96klaPejCAj4ON4e9kj5yWn6kZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719821; c=relaxed/simple;
	bh=oLRekKmrrAAX4xr9cjmln8z+C59zD1nyYKyyYtJ4NZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnAXlKotrulEDkr91liYMQElPE0HKtBPhlW4AebG7H7KRv3h+MwDL0sd3oQy++4gppkiLL+9VyJzfY4N2Xv9p0QuKSZ5mr+cI197ac68OnxkqWJ5GeJiDsv502UtVyUkUCUvNmEHrNInXvDQ2tkMTjqVP7GSPswr0AGX2f7bQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eooe7LSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B78C4AF09;
	Tue, 23 Jul 2024 07:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721719821;
	bh=oLRekKmrrAAX4xr9cjmln8z+C59zD1nyYKyyYtJ4NZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eooe7LSl9vXs81NiJlbTWmTgg7yJr0BQc0657RVanUWUBiPbsnEg4TZ/z9I2Wa58O
	 Ho8eVNt7BrYZEtjGjyP+b/JadYw8EezfIZNnpm+Lh1ffBjMAA5pN1H0eWvjK5BefTI
	 zCybSJvD9uMH3c6BaRUzV/IGuU4xd4eTzj3/znjEA6p0eUUNtjCRmo6Ahy1Gw6q59j
	 BysmhgZLIDC95zGGz96t6kU6Wu5rqPapvvXY4eB8LiwqEyfn3g/yFz/BAtLep4q2wR
	 GGn7EdB2ZcAU9FAS6ZQyfhA8HDkj6BhwaDpmhOOnPdFdml0l0HaLMyFGZ0NZcTU9Pw
	 UK2/T7OJuFgyA==
Received: by pali.im (Postfix)
	id 95E206FE; Tue, 23 Jul 2024 09:30:16 +0200 (CEST)
Date: Tue, 23 Jul 2024 09:30:16 +0200
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
Message-ID: <20240723073016.j4r72yeexcpj7qhj@pali>
References: <20240720220606.1934df43@5400>
 <20240721090238.wrei5nu6y3awujws@pali>
 <20240721193716.3156050f@5400>
 <20240721234037.nxthfeqdjl3z74oc@pali>
 <20240721195851.76e2b220@5400>
 <20240722071845.w7v23ixu5wujrpol@pali>
 <20240722143432.35c356b1@5400>
 <20240722184132.l6nibqkpna2wkszo@pali>
 <20240722202504.jgz6tcc247mjxq4f@pali>
 <20240723003610.765d28e4@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240723003610.765d28e4@5400>
User-Agent: NeoMutt/20180716

On Tuesday 23 July 2024 00:36:10 Andres Salomon wrote:
> On Mon, 22 Jul 2024 22:25:04 +0200
> Pali Rohár <pali@kernel.org> wrote:
> 
> > On Monday 22 July 2024 20:41:32 Pali Rohár wrote:
> > > On Monday 22 July 2024 14:34:32 Andres Salomon wrote:  
> > > > On Mon, 22 Jul 2024 09:18:45 +0200
> > > > Pali Rohár <pali@kernel.org> wrote:
> > > >   
> > > > > On Sunday 21 July 2024 19:58:51 Andres Salomon wrote:  
> > > > > > On Mon, 22 Jul 2024 01:40:37 +0200
> > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > >     
> > > > > > > On Sunday 21 July 2024 19:37:16 Andres Salomon wrote:    
> > > > > > > > On Sun, 21 Jul 2024 11:02:38 +0200
> > > > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > > >       
> > > > > > > > > On Saturday 20 July 2024 22:06:06 Andres Salomon wrote:      
> > > > > > > > > > On Sat, 20 Jul 2024 11:55:07 +0200
> > > > > > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > > > > >         
> > > > > > > > > > > On Saturday 20 July 2024 05:24:19 Andres Salomon wrote:        
> > > > > > > > > > > > Thanks for the quick feedback! Responses below.
> > > > > > > > > > > > 
> > > > > > > > > > > > On Sat, 20 Jul 2024 10:40:19 +0200
> > > > > > > > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > > > > > > >           
> > > > > > > > 
> > > > > > > > [...]
> > > > > > > >       
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +static void __init dell_battery_init(struct device *dev)
> > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > +	enum battery_charging_mode current_mode = DELL_BAT_MODE_NONE;
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +	dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN, (int *) &current_mode);
> > > > > > > > > > > > > > +	if (current_mode != DELL_BAT_MODE_NONE) {            
> > > > > > > > > > > > > 
> > > > > > > > > > > > > I quite do not understand how is this code suppose to work.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Why is there mix of custom kernel enum battery_charging_mode and return
> > > > > > > > > > > > > value from Dell's API?          
> > > > > > > > > > > > 
> > > > > > > > > > > > This is from the original patch from Dell; tbh, I'm not sure. It does
> > > > > > > > > > > > work, though. That is, current_mode ends up holding the correct value
> > > > > > > > > > > > based on what was previously set, even if the charging mode is set from
> > > > > > > > > > > > the BIOS.
> > > > > > > > > > > > 
> > > > > > > > > > > > I just scanned through the libsmbios code to see what it's doing, and
> > > > > > > > > > > > it appears to loop through every charging mode to check if its active.
> > > > > > > > > > > > I'm not really sure that makes much more sense, so I'll try some more
> > > > > > > > > > > > tests.          
> > > > > > > > > > > 
> > > > > > > > > > > Keyboard backlight code (kbd_get_first_active_token_bit) is doing also
> > > > > > > > > > > this type scan. If I remember correctly, for every keyboard backlight
> > > > > > > > > > > token we just know the boolean value - if the token is set or not.
> > > > > > > > > > > 
> > > > > > > > > > > It would really nice to see what (raw) value is returned by the
> > > > > > > > > > > dell_battery_read_req(token) function for every battery token and for
> > > > > > > > > > > every initial state.        
> > > > > > > > > > 
> > > > > > > > > > I checked this. The BIOS sets the mode value in every related token
> > > > > > > > > > location. I'm still not really sure what libsmbios is doing, but the
> > > > > > > > > > kernel code seems to arbitrarily choose one of the token locations
> > > > > > > > > > to read from. This makes sense to me now.
> > > > > > > > > > 
> > > > > > > > > > In the BIOS when I set the mode to "ExpressCharge",
> > > > > > > > > > this what I pulled for each token location:
> > > > > > > > > > 
> > > > > > > > > > [    5.704651] dell-laptop dell-laptop: BAT_CUSTOM_MODE_TOKEN value: 2
> > > > > > > > > > [    5.707015] dell-laptop dell-laptop: BAT_PRI_AC_MODE_TOKEN value: 2
> > > > > > > > > > [    5.709114] dell-laptop dell-laptop: BAT_ADAPTIVE_MODE_TOKEN value: 2
> > > > > > > > > > [    5.711041] dell-laptop dell-laptop: BAT_STANDARD_MODE_TOKEN value: 2
> > > > > > > > > > [    5.713705] dell-laptop dell-laptop: BAT_EXPRESS_MODE_TOKEN value: 2
> > > > > > > > > > 
> > > > > > > > > > Similar story when I set it to Custom (all were '5'), or Standard ('1').
> > > > > > > > > > When I set it from linux as well, it changed all location values.        
> > > > > > > > > 
> > > > > > > > > Interesting... Anyway, I still think that the API could be similar to
> > > > > > > > > what is used in keyboard backlight.
> > > > > > > > > 
> > > > > > > > > Could you please dump all information about each token? They are in
> > > > > > > > > struct calling_interface_token returned by dell_smbios_find_token.
> > > > > > > > > 
> > > > > > > > > I'm interesting in tokenID, location and value.
> > > > > > > > > 
> > > > > > > > > Ideally to compare what is in token->value and then in buffer.output[1]
> > > > > > > > > (in case dell_send_request does not fail).      
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Alright, here's what I see:
> > > > > > > > 
> > > > > > > > [    5.904775] dell_laptop: dell_battery_read_req: token requested: 0x343, tokenID=0x343, location=0x343, value=5
> > > > > > > > [    5.908675] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> > > > > > > > [    5.908680] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TOKEN value: 3
> > > > > > > > [    5.908682] dell_laptop: dell_battery_read_req: token requested: 0x341, tokenID=0x341, location=0x341, value=3
> > > > > > > > [    5.910922] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> > > > > > > > [    5.910926] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TOKEN value: 3
> > > > > > > > [    5.910928] dell_laptop: dell_battery_read_req: token requested: 0x342, tokenID=0x342, location=0x342, value=4
> > > > > > > > [    5.913042] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> > > > > > > > [    5.913046] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_TOKEN value: 3
> > > > > > > > [    5.913048] dell_laptop: dell_battery_read_req: token requested: 0x346, tokenID=0x346, location=0x346, value=1
> > > > > > > > [    5.914996] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> > > > > > > > [    5.914999] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_TOKEN value: 3
> > > > > > > > [    5.915000] dell_laptop: dell_battery_read_req: token requested: 0x347, tokenID=0x347, location=0x347, value=2
> > > > > > > > [    5.916723] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> > > > > > > > [    5.916724] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_TOKEN value: 3
> > > > > > > > [    5.916725] dell_laptop: dell_battery_read_req: token requested: 0x349, tokenID=0x349, location=0x349, value=65535
> > > > > > > > [    5.918727] dell_laptop: dell_battery_read_req: buffer.output[1]=65
> > > > > > > > [    5.918731] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_START value: 65
> > > > > > > > [    5.918734] dell_laptop: dell_battery_read_req: token requested: 0x34a, tokenID=0x34a, location=0x34a, value=65535
> > > > > > > > [    5.920864] dell_laptop: dell_battery_read_req: buffer.output[1]=85
> > > > > > > > [    5.920867] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_END value: 85      
> > > > > > > 
> > > > > > > Perfect. And can you check dumps when the mode is set to some other than BAT_PRI_AC_MODE_TOKEN?    
> > > > > > 
> > > > > > Here's Express:
> > > > > > 
> > > > > > [    5.880090] dell_laptop: dell_battery_read_req: token requested: 0x343, tokenID=0x343, location=0x343, value=5
> > > > > > [    5.882011] dell_laptop: dell_battery_read_req: buffer.output[1]=2
> > > > > > [    5.882014] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TOKEN value: 2
> > > > > > [    5.882016] dell_laptop: dell_battery_read_req: token requested: 0x341, tokenID=0x341, location=0x341, value=3
> > > > > > [    5.894513] dell_laptop: dell_battery_read_req: buffer.output[1]=2
> > > > > > [    5.894518] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TOKEN value: 2
> > > > > > [    5.894520] dell_laptop: dell_battery_read_req: token requested: 0x342, tokenID=0x342, location=0x342, value=4
> > > > > > [    5.913870] dell_laptop: dell_battery_read_req: buffer.output[1]=2
> > > > > > [    5.913874] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_TOKEN value: 2
> > > > > > [    5.913875] dell_laptop: dell_battery_read_req: token requested: 0x346, tokenID=0x346, location=0x346, value=1
> > > > > > [    5.915622] dell_laptop: dell_battery_read_req: buffer.output[1]=2
> > > > > > [    5.915625] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_TOKEN value: 2
> > > > > > [    5.915626] dell_laptop: dell_battery_read_req: token requested: 0x347, tokenID=0x347, location=0x347, value=2
> > > > > > [    5.917349] dell_laptop: dell_battery_read_req: buffer.output[1]=2
> > > > > > [    5.917351] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_TOKEN value: 2
> > > > > > [    5.917352] dell_laptop: dell_battery_read_req: token requested: 0x349, tokenID=0x349, location=0x349, value=65535
> > > > > > [    5.919068] dell_laptop: dell_battery_read_req: buffer.output[1]=65
> > > > > > [    5.919070] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_START value: 65
> > > > > > [    5.919071] dell_laptop: dell_battery_read_req: token requested: 0x34a, tokenID=0x34a, location=0x34a, value=65535
> > > > > > [    5.920780] dell_laptop: dell_battery_read_req: buffer.output[1]=85
> > > > > > [    5.920782] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_END value: 85
> > > > > > 
> > > > > > And here's Adaptive:
> > > > > > 
> > > > > > [    5.945319] dell_laptop: dell_battery_read_req: token requested: 0x343, tokenID=0x343, location=0x343, value=5
> > > > > > [    5.973685] dell_laptop: dell_battery_read_req: buffer.output[1]=4
> > > > > > [    5.973690] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TOKEN value: 4
> > > > > > [    5.973692] dell_laptop: dell_battery_read_req: token requested: 0x341, tokenID=0x341, location=0x341, value=3
> > > > > > [    5.976533] dell_laptop: dell_battery_read_req: buffer.output[1]=4
> > > > > > [    5.976538] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TOKEN value: 4
> > > > > > [    5.976540] dell_laptop: dell_battery_read_req: token requested: 0x342, tokenID=0x342, location=0x342, value=4
> > > > > > [    5.981013] dell_laptop: dell_battery_read_req: buffer.output[1]=4
> > > > > > [    5.981018] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_TOKEN value: 4
> > > > > > [    5.981020] dell_laptop: dell_battery_read_req: token requested: 0x346, tokenID=0x346, location=0x346, value=1
> > > > > > [    5.983474] dell_laptop: dell_battery_read_req: buffer.output[1]=4
> > > > > > [    5.983479] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_TOKEN value: 4
> > > > > > [    5.983481] dell_laptop: dell_battery_read_req: token requested: 0x347, tokenID=0x347, location=0x347, value=2
> > > > > > [    5.985881] dell_laptop: dell_battery_read_req: buffer.output[1]=4
> > > > > > [    5.985885] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_TOKEN value: 4
> > > > > > [    5.985887] dell_laptop: dell_battery_read_req: token requested: 0x349, tokenID=0x349, location=0x349, value=65535
> > > > > > [    5.988332] dell_laptop: dell_battery_read_req: buffer.output[1]=65
> > > > > > [    5.988337] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_START value: 65
> > > > > > [    5.988339] dell_laptop: dell_battery_read_req: token requested: 0x34a, tokenID=0x34a, location=0x34a, value=65535
> > > > > > [    5.990769] dell_laptop: dell_battery_read_req: buffer.output[1]=85
> > > > > > [    5.990774] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_END value: 85
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > -- 
> > > > > > I'm available for contract & employment work, see:
> > > > > > https://spindle.queued.net/~dilinger/resume-tech.pdf    
> > > > > 
> > > > > Nice! So it is exactly same as API of keyboard backlight tokens. Thanks.
> > > > > 
> > > > > In dell_battery_write_req function you can drop second "val" argument
> > > > > and replace it by token->value. So the dell_fill_request call in that
> > > > > function would look like:
> > > > > 
> > > > >     dell_fill_request(&buffer, token->location, token->value, 0, 0);  
> > > > 
> > > > 
> > > > Well, except that we use dell_battery_write_req for writing the charge
> > > > start/end values as well (in dell_battery_custom_set). Those can't be
> > > > obtained from token->value.
> > > > 
> > > > We could have two separate functions for that, or set 'val' to a
> > > > sentinel value (0) that, if detected, we set val=token->value. I'm
> > > > still not really understanding the point, though.  
> > > 
> > > I think that two separate functions would be needed. One which set
> > > battery mode (enum) and which set custom thresholds.
> > >   
> > > > > 
> > > > > And then you can mimic the usage as it is done in keyboard backlight
> > > > > functions (kbd_get_first_active_token_bit).
> > > > > 
> > > > > If you do not know what I mean then later (today or tomorrow) I can
> > > > > write code example of the functionality.  
> > > > 
> > > > Sorry, I still don't understand what the goal is here. Is the goal to
> > > > not pull from a random location to determine the current charging mode?
> > > > Is the goal to determine what charging modes are currently supported
> > > > (and if so, I don't see how)? Is the goal to avoid having the kernel
> > > > hardcode a list of enums that the BIOS might have different values
> > > > for? Is the goal to merge the keyboard backlight and battery setting
> > > > functions?  
> > > 
> > > Avoid having the kernel hardcoded values for enums which SMBIOS
> > > provides. Future (or maybe also older) modes may have different enum
> > > values. So we should use what SMBIOS provides to us.
> > > 
> > > Also to determinate which charging modes are supported by the current HW
> > > configuration. If BIOS does not support some mode or does not allow to
> > > set some mode, kernel should not export this as supported option.
> > > 
> > > If you do not see how to do it, please give me some time, I will send
> > > you an example. Going to look at it right now.
> > > 
> > > Merging keyboard backlight and battery code is bonus, not required.
> > > But I thought that it would be easier to build a new code from common
> > > blocks.  
> > 
> > Here is very quick & hacky example of what I mean (completely untested):
> > 
> > --- dell-laptop.c
> > +++ dell-laptop.c
> > @@ -353,6 +353,105 @@ static const struct dmi_system_id dell_q
> >  	{ }
> >  };
> >  
> > +static int dell_read_token_value(u16 tokenid, u32 *value)
> > +{
> > +	struct calling_interface_buffer buffer;
> > +	struct calling_interface_token *token;
> > +	int ret;
> > +
> > +	token = dell_smbios_find_token(tokenid);
> > +	if (!token)
> > +		return -ENODEV;
> > +
> > +	dell_fill_request(&buffer, token->location, 0, 0, 0);
> > +	ret = dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*value = buffer.output[1];
> > +	return 0;
> > +}
> > +
> > +static int dell_write_token_value(u16 tokenid, u32 value)
> > +{
> > +	struct calling_interface_buffer buffer;
> > +	struct calling_interface_token *token;
> > +
> > +	token = dell_smbios_find_token(type);
> > +	if (!token)
> > +		return -ENODEV;
> > +
> > +	dell_fill_request(&buffer, token->location, value, 0, 0);
> > +	return dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> > +}
> > +
> 
> I did things a bit differently here. I created a function
> dell_send_request_by_token_loc() that is available to be reused by all
> the code that sends packets to token->location. This is available for
> kbd_{g,s}et_token_bit(), micmute_led_set(), and mute_led_set() to use,
> but I'd rather do that in a separate patch.

Ok, nice thing.

> +static int dell_send_request_by_token_loc(struct calling_interface_buffer *buffer,
> +                                         u16 class, u16 select, int type,
> +                                         int val)
> +{
> +       struct calling_interface_token *token;
> +
> +       token = dell_smbios_find_token(type);
> +       if (!token)
> +               return -ENODEV;
> +
> +       if (val <= 0)

I would be rather very careful here. Zero value can be valid value for
some future call. It would be better to pass -1 or something like that.

And IIRC dell_fill_request take u32 as val. So maybe it would be better
to change "int val" to "u32 val" and interpret (u32)-1 as enum value
from token->value?

> +               val = token->value;
> +
> +       dell_fill_request(buffer, token->location, val, 0, 0);
> +       return dell_send_request(buffer, class, select);
> +}
> +
> +static int dell_battery_set_mode(const int type)
> +{
> +       struct calling_interface_buffer buffer;
> +
> +       /* 0 means use the value from the token */
> +       return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> +                       SELECT_TOKEN_STD, type, 0);
> +}
> +
> +static int dell_battery_read(const int type)
> +{
> +       struct calling_interface_buffer buffer;
> +       int err;
> +
> +       err = dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_READ,
> +                       SELECT_TOKEN_STD, type, 0);
> +       if (err)
> +               return err;
> +
> +       return buffer.output[1];
> +}
> 
> 
> 
> > +static int dell_is_enum_token_active(u16 tokenid)
> > +{
> > +	struct calling_interface_buffer buffer;
> > +	struct calling_interface_token *token;
> > +	int ret;
> > +
> > +	token = dell_smbios_find_token(tokenid);
> > +	if (!token)
> > +		return -EINVAL;
> > +
> > +	if (token->value == (u16)-1)
> > +		return -EINVAL;
> > +
> > +	dell_fill_request(&buffer, token->location, 0, 0, 0);
> > +	ret = dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return (buffer.output[1] == token->value);
> > +}
> > +
> 
> Okay, I incorporated this, but using the above helper functions:
> 
> +static bool dell_battery_mode_is_active(const int type)
> +{
> +       struct calling_interface_token *token;
> +
> +       token = dell_smbios_find_token(type);
> +       if (!token)
> +               return false;
> +
> +       return token->value == dell_battery_read(type);
> +}
> 
> It will look up the token twice, but this only happens once on it
> (and I'm realizing now that it can be marked __init).

Ok. Anyway if you are touching kbd code, exactly same function would be
required for it.

> 
> > +static int dell_activate_enum_token(u16 tokenid)
> > +{
> > +	struct calling_interface_buffer buffer;
> > +	struct calling_interface_token *token;
> > +	int ret;
> > +
> > +	token = dell_smbios_find_token(tokenid);
> > +	if (!token)
> > +		return -EINVAL;
> > +
> > +	if (token->value == (u16)-1)
> > +		return -EINVAL;
> > +
> > +	dell_fill_request(&buffer, token->location, token->value, 0, 0);
> > +	return dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> > +}
> > +
> > +static u32 dell_get_supported_enum_tokens(const u16 *tokenids, u32 count)
> > +{
> > +	u32 supported_mask = 0;
> > +	u32 i;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		if (dell_smbios_find_token(tokenids[i]))
> > +			supported_mask |= BIT(i);
> > +	}
> > +
> > +	return supported_mask;
> > +}
> > +
> > +static int dell_get_active_enum_token(const u16 *tokenids, u32 count, u32 supported_mask)
> > +{
> > +	int ret;
> > +	u32 i;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		if (!(supported_mask & BIT(i)))
> > +			continue;
> > +		ret = dell_is_enum_token_active(tokenids[i]);
> > +		if (ret == 1)
> > +			return i;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> 
> 
> Thanks, I incorporated and tested this code; though it only runs once
> during init, because I'm keeping the battery_cur_mode variable (see
> next section).
> 
> +static u32 __init battery_get_supported_modes(void)
> +{
> +       u32 modes = 0;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> +               if (dell_smbios_find_token(battery_modes[i].token))
> +                       modes |= BIT(i);
> +       }
> +
> +       return modes;
> +}
> +
> +static int __init dell_battery_find_charging_mode(void)
> +{
> +       int i;
> +
> +       battery_supported_modes = battery_get_supported_modes();
> +       for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> +               if (!(battery_supported_modes & BIT(i)))
> +                       continue;
> +               if (dell_battery_mode_is_active(battery_modes[i].token))
> +                       return battery_modes[i].token;
> +       }
> +
> +       return 0;
> +}
> 
> 
> 
> > +
> >  /*
> >   * Derived from information in smbios-wireless-ctl:
> >   *
> > @@ -2183,6 +2282,144 @@ static struct led_classdev mute_led_cdev
> >  	.default_trigger = "audio-mute",
> >  };
> >  
> > +static const u16 battery_mode_tokens[] = {
> > +	BAT_STANDARD_MODE_TOKEN,
> > +	BAT_EXPRESS_MODE_TOKEN,
> > +	BAT_PRI_AC_MODE_TOKEN,
> > +	BAT_ADAPTIVE_MODE_TOKEN,
> > +	BAT_CUSTOM_MODE_TOKEN,
> > +};
> > +
> > +static const char * const battery_mode_names[] = {
> > +	"standard",
> > +	"express",
> > +	"primarily_ac",
> > +	"adaptive",
> > +	"custom",
> > +};
> > +
> > +static u32 battery_mode_token_mask;
> > +
> 
> I merged the token and name lists. Also, is there any particular reason
> you dropped the current mode, preferring to read it from SMBIOS every time
> in the _show() callback?

Yes, there is one important reason: You can change current mode from
userspace. We had this problem also with other functionality in driver.
So caching is not a good idea. There are/were enterprise Dell CCTK tools
for managing configuration of Dell machines. And usage of these tools
can break kernel driver.

> +static const struct {
> +       int token;
> +       const char *label;
> +} battery_modes[] = {
> +       { BAT_STANDARD_MODE_TOKEN, "standard" },
> +       { BAT_EXPRESS_MODE_TOKEN, "express" },
> +       { BAT_PRI_AC_MODE_TOKEN, "primarily_ac" },
> +       { BAT_ADAPTIVE_MODE_TOKEN, "adaptive" },
> +       { BAT_CUSTOM_MODE_TOKEN, "custom" },
> +};
> +static u32 battery_supported_modes;
> +static int battery_cur_mode;
> +
> 
> 
> 
> > +static int dell_battery_read_custom_charge(u16 token)
> > +{
> > +	u32 value;
> > +	int ret;
> > +
> > +	ret = dell_read_token_value(token, &value);
> > +	if (ret)
> > +		return ret;
> > +	if (value > 100)
> > +		return -EINVAL;
> > +	return value;
> > +}
> > +
> > +#define CHARGE_START_MIN	50
> > +#define CHARGE_START_MAX	95
> > +#define CHARGE_END_MIN		55
> > +#define CHARGE_END_MAX		100
> > +#define CHARGE_MIN_DIFF		5
> > +
> > +static int dell_battery_set_custom_charge_start(int val)
> > +{
> > +	int end;
> > +
> > +	if (val < CHARGE_START_MIN)
> > +		val = CHARGE_START_MIN;
> > +	else if (val > CHARGE_START_MAX)
> > +		val = CHARGE_START_MAX;
> > +
> > +	end = dell_battery_get_custom_charge(BAT_CUSTOM_CHARGE_END);
> > +	if (end < 0)
> > +		return end;
> > +
> > +	if (end - val < CHARGE_MIN_DIFF)
> > +		val = end - CHARGE_MIN_DIFF;
> > +
> > +	return dell_write_token_value(BAT_CUSTOM_CHARGE_START, val);
> > +}
> > +
> > +static int dell_battery_set_custom_charge_end(int val)
> > +{
> > +	int start;
> > +
> > +	if (val < CHARGE_END_MIN)
> > +		val = CHARGE_END_MIN;
> > +	else if (val > CHARGE_END_MAX)
> > +		val = CHARGE_END_MAX;
> > +
> > +	start = dell_battery_get_custom_charge(BAT_CUSTOM_CHARGE_START);
> > +	if (start < 0)
> > +		return start;
> > +
> > +	if (val - start < CHARGE_MIN_DIFF)
> > +		val = start + CHARGE_MIN_DIFF;
> > +
> > +	return dell_write_token_value(BAT_CUSTOM_CHARGE_END, val);
> > +}
> > +
> 
> 
> Good call, I split apart the start/end functions. It was originally
> much smaller and grew over time.  :)
> 
> 
> > +static ssize_t charge_type_show(struct device *dev,
> > +				struct device_attribute *attr,
> > +				char *buf)
> > +{
> > +	int active;
> > +	ssize_t count;
> > +
> > +	active = dell_get_active_enum_token(battery_mode_tokens, ARRAY_SIZE(battery_mode_tokens), battery_mode_token_mask);
> > +	if (active < 0)
> > +		return ret;
> > +
> > +	for (count = 0, i = 0; i < ARRAY_SIZE(battery_mode_names); i++) {
> > +		if (!(BIT(i) & battery_mode_token_mask))
> > +			continue;
> > +		count += sysfs_emit_at(buf, count, i == active ? "[%s] " : "%s ", battery_mode_names[mode]);
> > +	}
> > +
> > +	/* convert the last space to a newline */
> > +	/* battery_mode_names is non-empty and battery_mode_token_mask is non-zero, so count is also non-zero */
> > +	count--;
> > +	count += sysfs_emit_at(buf, count, "\n");
> > +
> > +	return count;
> > +}
> > +
> 
> Again, I personally prefer keeping the currently active charging mode
> around as a variable:
> 
> 
> +static ssize_t charge_type_show(struct device *dev,
> +               struct device_attribute *attr,
> +               char *buf)
> +{
> +       ssize_t count = 0;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> +               if (!(battery_supported_modes & BIT(i)))
> +                       continue;
> +
> +               count += sysfs_emit_at(buf, count,
> +                               battery_modes[i].token == battery_cur_mode ? "[%s] " : "%s ",
> +                               battery_modes[i].label);
> +       }
> +
> +       /* convert the last space to a newline */
> +       if (count > 0)
> +               count--;
> +       count += sysfs_emit_at(buf, count, "\n");
> +
> +       return count;
> +}
> 
> 
> > +static ssize_t charge_type_store(struct device *dev,
> > +				struct device_attribute *attr,
> > +				const char *buf, size_t size)
> > +{
> > +	size_t i;
> > +	int ret;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(battery_mode_names); i++) {
> > +		if (sysfs_streq(battery_mode_names[i], buf))
> > +			break;
> > +	}
> > +
> > +	if (i >= ARRAY_SIZE(battery_mode_names))
> > +		return -EINVAL;
> > +
> > +	if (!(BIT(i) & battery_mode_token_mask))
> > +		return -EINVAL;
> > +
> > +	ret = dell_activate_enum_token(battery_mode_tokens[i]);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return size;
> > +}
> > +
> > +static void __init dell_battery_init(struct device *dev)
> > +{
> > +	battery_mode_token_mask = dell_get_supported_enum_tokens(battery_mode_tokens, ARRAY_SIZE(battery_mode_tokens));
> > +	if (battery_mode_token_mask != 0)
> > +		battery_hook_register(&dell_battery_hook);
> > +}
> > +
> > +static void __exit dell_battery_exit(void)
> > +{
> > +	if (battery_mode_token_mask != 0)
> > +		battery_hook_unregister(&dell_battery_hook);
> > +}
> > +
> >  static int __init dell_init(void)
> >  {
> >  	struct calling_interface_token *token;
> 
> 
> Let me know your thoughts, and I can send a V2 patch if you're okay
> with the code snippets I sent.
> 
> -- 
> I'm available for contract & employment work, see:
> https://spindle.queued.net/~dilinger/resume-tech.pdf

