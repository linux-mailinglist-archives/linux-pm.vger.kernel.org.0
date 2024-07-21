Return-Path: <linux-pm+bounces-11275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E10A9386AF
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 01:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCFB1C20BBF
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jul 2024 23:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03CB12B63;
	Sun, 21 Jul 2024 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+L0Kvms"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E617BCA;
	Sun, 21 Jul 2024 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721605242; cv=none; b=pWEqnFauueWiq6t/0Qt+T5Y4WxAOdidFrkJ8MGuHW0ncQLw0FIJSfdpe1mTQhGUXcTpjDgZc4gezCYcXIU6S874pPUz0+bYqfItoXKnmDCXOIv82PdnVagp6DAqWfgl52tVNRPdXDI4PhF6xakAkaMkR8PZq4f3luH0u3G4jL74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721605242; c=relaxed/simple;
	bh=RfwMJQKoQtwh3/uR5REHuvRYp3pEGpwSEQLFtoJJb5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGRiDRv26j/diAQE4WF0jWmZHJsX7czBsfOqSiQ2DT4gT1CCR1a/15O6WgVW6eB770XCD8gt9pcRrcbK0DF8JxuraHvJm7LhPYvAie1KAPuWoPOAljxlvaGB/DPA+ztfSfOftp5GW9o3jOnpggSN7GxD/5T/q2njUl2IngiqV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+L0Kvms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB76C116B1;
	Sun, 21 Jul 2024 23:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721605242;
	bh=RfwMJQKoQtwh3/uR5REHuvRYp3pEGpwSEQLFtoJJb5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+L0KvmsJ5kqR8gT8hg6ddmolXq0Y5xPbpWltQ/c9Gcp2kWeHWQ8UVRoXPGZ2XyI0
	 l1od45y3FPplbbzI9krp326qroNtgZh+kzgvLNetESnBlIxj/huggzy3jYHL6JRY74
	 VpuTce1jklEzzF2Xm6pnJSPSPuRFxJoa5S4RzBDIHfz+yoZf3E3a2o7Xkmr7rqLOBr
	 6db6sbeEQRU8gSGYqC9psPTCTI7UtRJQrjeIKP2oRzJL6K2RB0Q9ZfrJdR809QQF1J
	 FaC8Urxqso5WOAAF91EMcq1L+4KtUVKyBLa5kyRPsrTbblEd5Ce2E+avh6ugIwY5sH
	 kEqNg01XQ1w4Q==
Received: by pali.im (Postfix)
	id EE1018A0; Mon, 22 Jul 2024 01:40:37 +0200 (CEST)
Date: Mon, 22 Jul 2024 01:40:37 +0200
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
Message-ID: <20240721234037.nxthfeqdjl3z74oc@pali>
References: <20240720012220.26d62a54@5400>
 <20240720084019.hrnd4wgt4muorydp@pali>
 <20240720052419.73b1415a@5400>
 <20240720095507.uyaotkofkyasdgbd@pali>
 <20240720220606.1934df43@5400>
 <20240721090238.wrei5nu6y3awujws@pali>
 <20240721193716.3156050f@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240721193716.3156050f@5400>
User-Agent: NeoMutt/20180716

On Sunday 21 July 2024 19:37:16 Andres Salomon wrote:
> On Sun, 21 Jul 2024 11:02:38 +0200
> Pali Rohár <pali@kernel.org> wrote:
> 
> > On Saturday 20 July 2024 22:06:06 Andres Salomon wrote:
> > > On Sat, 20 Jul 2024 11:55:07 +0200
> > > Pali Rohár <pali@kernel.org> wrote:
> > >   
> > > > On Saturday 20 July 2024 05:24:19 Andres Salomon wrote:  
> > > > > Thanks for the quick feedback! Responses below.
> > > > > 
> > > > > On Sat, 20 Jul 2024 10:40:19 +0200
> > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > >     
> 
> [...]
> 
> > > > > > > +
> > > > > > > +static void __init dell_battery_init(struct device *dev)
> > > > > > > +{
> > > > > > > +	enum battery_charging_mode current_mode = DELL_BAT_MODE_NONE;
> > > > > > > +
> > > > > > > +	dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN, (int *) &current_mode);
> > > > > > > +	if (current_mode != DELL_BAT_MODE_NONE) {      
> > > > > > 
> > > > > > I quite do not understand how is this code suppose to work.
> > > > > > 
> > > > > > Why is there mix of custom kernel enum battery_charging_mode and return
> > > > > > value from Dell's API?    
> > > > > 
> > > > > This is from the original patch from Dell; tbh, I'm not sure. It does
> > > > > work, though. That is, current_mode ends up holding the correct value
> > > > > based on what was previously set, even if the charging mode is set from
> > > > > the BIOS.
> > > > > 
> > > > > I just scanned through the libsmbios code to see what it's doing, and
> > > > > it appears to loop through every charging mode to check if its active.
> > > > > I'm not really sure that makes much more sense, so I'll try some more
> > > > > tests.    
> > > > 
> > > > Keyboard backlight code (kbd_get_first_active_token_bit) is doing also
> > > > this type scan. If I remember correctly, for every keyboard backlight
> > > > token we just know the boolean value - if the token is set or not.
> > > > 
> > > > It would really nice to see what (raw) value is returned by the
> > > > dell_battery_read_req(token) function for every battery token and for
> > > > every initial state.  
> > > 
> > > I checked this. The BIOS sets the mode value in every related token
> > > location. I'm still not really sure what libsmbios is doing, but the
> > > kernel code seems to arbitrarily choose one of the token locations
> > > to read from. This makes sense to me now.
> > > 
> > > In the BIOS when I set the mode to "ExpressCharge",
> > > this what I pulled for each token location:
> > > 
> > > [    5.704651] dell-laptop dell-laptop: BAT_CUSTOM_MODE_TOKEN value: 2
> > > [    5.707015] dell-laptop dell-laptop: BAT_PRI_AC_MODE_TOKEN value: 2
> > > [    5.709114] dell-laptop dell-laptop: BAT_ADAPTIVE_MODE_TOKEN value: 2
> > > [    5.711041] dell-laptop dell-laptop: BAT_STANDARD_MODE_TOKEN value: 2
> > > [    5.713705] dell-laptop dell-laptop: BAT_EXPRESS_MODE_TOKEN value: 2
> > > 
> > > Similar story when I set it to Custom (all were '5'), or Standard ('1').
> > > When I set it from linux as well, it changed all location values.  
> > 
> > Interesting... Anyway, I still think that the API could be similar to
> > what is used in keyboard backlight.
> > 
> > Could you please dump all information about each token? They are in
> > struct calling_interface_token returned by dell_smbios_find_token.
> > 
> > I'm interesting in tokenID, location and value.
> > 
> > Ideally to compare what is in token->value and then in buffer.output[1]
> > (in case dell_send_request does not fail).
> 
> 
> Alright, here's what I see:
> 
> [    5.904775] dell_laptop: dell_battery_read_req: token requested: 0x343, tokenID=0x343, location=0x343, value=5
> [    5.908675] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> [    5.908680] dell_laptop: dell_battery_init: BAT_CUSTOM_MODE_TOKEN value: 3
> [    5.908682] dell_laptop: dell_battery_read_req: token requested: 0x341, tokenID=0x341, location=0x341, value=3
> [    5.910922] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> [    5.910926] dell_laptop: dell_battery_init: BAT_PRI_AC_MODE_TOKEN value: 3
> [    5.910928] dell_laptop: dell_battery_read_req: token requested: 0x342, tokenID=0x342, location=0x342, value=4
> [    5.913042] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> [    5.913046] dell_laptop: dell_battery_init: BAT_ADAPTIVE_MODE_TOKEN value: 3
> [    5.913048] dell_laptop: dell_battery_read_req: token requested: 0x346, tokenID=0x346, location=0x346, value=1
> [    5.914996] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> [    5.914999] dell_laptop: dell_battery_init: BAT_STANDARD_MODE_TOKEN value: 3
> [    5.915000] dell_laptop: dell_battery_read_req: token requested: 0x347, tokenID=0x347, location=0x347, value=2
> [    5.916723] dell_laptop: dell_battery_read_req: buffer.output[1]=3
> [    5.916724] dell_laptop: dell_battery_init: BAT_EXPRESS_MODE_TOKEN value: 3
> [    5.916725] dell_laptop: dell_battery_read_req: token requested: 0x349, tokenID=0x349, location=0x349, value=65535
> [    5.918727] dell_laptop: dell_battery_read_req: buffer.output[1]=65
> [    5.918731] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_START value: 65
> [    5.918734] dell_laptop: dell_battery_read_req: token requested: 0x34a, tokenID=0x34a, location=0x34a, value=65535
> [    5.920864] dell_laptop: dell_battery_read_req: buffer.output[1]=85
> [    5.920867] dell_laptop: dell_battery_init: BAT_CUSTOM_CHARGE_END value: 85

Perfect. And can you check dumps when the mode is set to some other than BAT_PRI_AC_MODE_TOKEN?

