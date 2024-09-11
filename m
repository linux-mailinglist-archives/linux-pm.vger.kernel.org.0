Return-Path: <linux-pm+bounces-14030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30829755CA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 16:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B541C21E55
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6291A00F4;
	Wed, 11 Sep 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Vk9XFC80"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AE91AAE36
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065639; cv=none; b=JpuJATak6jitmmZKTiiEqMm/YhZUVkEbL1K5swUkVmyQJPAOYTIcuP5aV9UrRDY/0ePkVORWb+pcmq5HHJz6zgcdi/k9wTBWgYV1bCKr5RtVLOa90Otvm/+VeOc2ws3NS1Hv1desjxlGxjJsuB0mM7ss4EoXaHo3C5a/JRKCY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065639; c=relaxed/simple;
	bh=EbFyWvV+rED0DyO1/FkrZ71C6UtxjlADNQZzQYUzhyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyVKZZyBuCnEi7eB3rB0qUkfrTpKryviT8ogGxI12W7EGzEkTKy1FrzavJB82aXlJE2a1fWKh+oYs8WAvmmv67zKsSk+KUGHRdGFHQ4+LcZeSateyjuIGvRrljpx+o+hJ6i5W8e6qi5+Sua6J5iW/mK3AbMXmV0+UCpOLXc+Vk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Vk9XFC80; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e1a819488e3so5844532276.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 07:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1726065636; x=1726670436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9DWu3pupeS9K819pDXfx+OFFNctZPkwT6aoMYNARBHA=;
        b=Vk9XFC80zRR3XY+KwzPkLFERkROgsRErsGoPM++hGiJWGD9ibDeSKGaUx8gSQIIicx
         QWyl6aITy46eflRjY5p9AgN8ctzklTWyo+Z5szwYKgwmU1DIPrvKytCY0aJhF9hF5aOM
         Wn5BUp90UkUdzRqr3/XN1WoV6WbBvWO56l3ci1TSx/rCpoU76o7bm7o1vjvqmguDuBpL
         QLzusKg2wWavD2F+li9+tDh+D5BMMvw62Ef1ffIggIvRqkRa2NkC0aKgtQF7x3Sag8A2
         08QOyNLJ5hHMMPryPIGdKdwKoJRGT8pizfnhDcBLua9b6TcKqc7rJDieJFE2kUmBEgMX
         MBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726065636; x=1726670436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DWu3pupeS9K819pDXfx+OFFNctZPkwT6aoMYNARBHA=;
        b=IMFGhuACGWwPq8w/Bl2nAWMSHbzizkqLUr3JBnKMmlgmyH/bY1nxAAIlOesRt6TTo4
         m4Bdfy4Dl/enIra+XutFJ77GCwXk20omj7gcijpMMxa6PKuC9qhpt0FY73A40cjL65V7
         85bu5yJJTwggAgObjrAheKJEPXVchCzQIEM/NT5EEDaS7KisjSO/IoDnWRsdgRTu1vUL
         KHjn0SYgVWo/OvsbSXBwAwJdRluctWEEFN/JIH+pWMkeJi1KVkZX22aL8s2iSYTwlBRl
         r56X9a37xx96r82CgaMzu9sBUXL2rvlMJw7osmJvUewFWpvhBsjkzTkJUmv74pnLcOO1
         /sKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMqmBcZ+yYW3jMCkYinDrw+WLmz8dQBacSQMtgsw/KwLHJIThtQhXBxsmDBRsjT3xEgGmEVArseg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf55/OUC+oiV8A/0MfhI8Z+YdRdSB23O8CwCwBj09qctMlJMf5
	LxayXerQxOCZJJORcMgta0bPn6OS5g8RpY5RlvJi44YtY8SDpI0JHcAMP0sqqw==
X-Google-Smtp-Source: AGHT+IG7H8eEV8INPa/cmNYRUc28xvktJNRam9hol104TOcVltKRv+QeyHCTcCk0KOZwzPjMTQfNMg==
X-Received: by 2002:a05:6902:230e:b0:e1a:8052:c3c7 with SMTP id 3f1490d57ef6-e1d348807a4mr15056101276.20.1726065636501;
        Wed, 11 Sep 2024 07:40:36 -0700 (PDT)
Received: from rowland.harvard.edu (wrls-249-137-9.wrls-client.fas.harvard.edu. [140.247.12.9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53433982esm42669826d6.42.2024.09.11.07.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:40:36 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:40:33 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: duanchenghao <duanchenghao@kylinos.cn>
Cc: gregkh@linuxfoundation.org, pavel@ucw.cz, linux-pm@vger.kernel.org,
	niko.mauno@vaisala.com, stanley_chang@realtek.com, tj@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Message-ID: <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
References: <20240906030548.845115-1-duanchenghao@kylinos.cn>
 <1725931490447646.3.seg@mailgw.kylinos.cn>
 <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>

On Tue, Sep 10, 2024 at 05:36:56PM +0800, duanchenghao wrote:
> S4 wakeup restores the image that was saved before the system entered
> the S4 sleep state.
> 
>     S4 waking up from hibernation
>     =============================
>     kernel initialization
>     |   
>     v   
>     freeze user task and kernel thread
>     |   
>     v   
>     load saved image
>     |    
>     v   
>     freeze the peripheral device and controller
>     (Check the HCD_FLAG_WAKEUP_ PENDING flag of the USB. If it is set,
>      return to EBUSY and do not perform the following restore image.)

Why is the flag set at this point?  It should not be; the device and 
controller should have been frozen with wakeup disabled.

>     |
>     v
>     restore image(task recovery)

> > > However, upon detecting that the hcd is in the
> > > HCD_FLAG_WAKEUP_PENDING state,
> > > it will return an EBUSY status, causing the S4 suspend to fail and
> > > subsequent task recovery to not proceed.
> > 
> > What will return an EBUSY status?
> 
> if HCD_FLAG_WAKEUP_PENDING flag is set_bit, will return EBUSY.

I meant: Which function will return EBUSY status?  The answer is in the 
log below; hcd_pci_suspend() does this.

> > Why do you say that S4 suspend will fail?  Aren't you talking about
> > S4 
> > wakeup?
> 
> After returning EBUSY, the subsequent restore image operation will not
> be executed.
> 
> > 
> > Can you provide a kernel log that explains these points and shows
> > what 
> > problem you are trying to solve?
> 
> [    9.009166][ 2] [  T403] PM: Image signature found, resuming
> [    9.009167][ 2] [  T403] PM: resume from hibernation
> [    9.009243][ 2] [  T403] inno-codec inno-codec.16.auto:
> [inno_vpu][vpu_notifier:1540]vpu_notifier: untested action 5...
> [    9.009244][ 2] [  T403] Freezing user space processes ... (elapsed
> 0.001 seconds) done.
> [    9.010355][ 2] [  T403] OOM killer disabled.
> [    9.010355][ 2] [  T403] Freezing remaining freezable tasks ...
> (elapsed 0.000 seconds) done.
> [    9.012152][ 2] [  T403] PM: Basic memory bitmaps created
> [    9.073333][ 2] [  T403] PM: Using 3 thread(s) for decompression
> [    9.073334][ 2] [  T403] PM: Loading and decompressing image data
> (486874 pages)...
> [    9.073335][ 2] [  T403] hibernate: Hibernated on CPU 0 [mpidr:0x0]
> [    9.095928][ 2] [  T403] PM: Image loading progress:   0%
> [    9.664803][ 2] [  T403] PM: Image loading progress:  10%
> [    9.794156][ 2] [  T403] PM: Image loading progress:  20%
> [    9.913001][ 2] [  T403] PM: Image loading progress:  30%
> [   10.034331][ 2] [  T403] PM: Image loading progress:  40%
> [   10.154070][ 2] [  T403] PM: Image loading progress:  50%
> [   10.277096][ 2] [  T403] PM: Image loading progress:  60%
> [   10.398860][ 2] [  T403] PM: Image loading progress:  70%
> [   10.533760][ 2] [  T403] PM: Image loading progress:  80%
> [   10.659874][ 2] [  T403] PM: Image loading progress:  90%
> [   10.760681][ 2] [  T403] PM: Image loading progress: 100%
> [   10.760693][ 2] [  T403] PM: Image loading done
> [   10.760718][ 2] [  T403] PM: Read 1947496 kbytes in 1.68 seconds
> (1159.22 MB/s)
> [   10.761982][ 2] [  T403] PM: Image successfully loaded
> [   10.761988][ 2] [  T403] printk: Suspending console(s) (use
> no_console_suspend to debug)
> [   10.864973][ 2] [  T403] innovpu_freeze:1782
> [   10.864974][ 2] [  T403] innovpu_suspend:1759
> [   11.168871][ 2] [  T189] PM: pci_pm_freeze():
> hcd_pci_suspend+0x0/0x38 returns -16

This should not be allowed to happen.  Freezing is mandatory and not 
subject to wakeup requests.

Is your problem related to the one discussed in this email thread?

https://lore.kernel.org/linux-usb/d8600868-6e4b-45ab-b328-852b6ac8ecb5@rowland.harvard.edu/

Would the suggestion I made there -- i.e., have the xhci-hcd 
interrupt handler skip calling usb_hcd_resume_root_hub() if the root hub 
was suspended with wakeup = 0 -- fix your problem?

Alan Stern

