Return-Path: <linux-pm+bounces-13309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8F3967C19
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 22:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E4A1F21671
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 20:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C1E745F2;
	Sun,  1 Sep 2024 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ47yieC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B316F2F3;
	Sun,  1 Sep 2024 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725222409; cv=none; b=N8eoYnt7CexjrxDhKjMC5UiwRVA04fqhlS4/miBHxWs5xBh+viQ0+7DIY7ne7Nilr+bA0f6ug62kMixmfXa+tKxXBLdLgZNyB+xYSclyICkOJnCvqVh2tdc14qMBr+EnrgTmY5cGKChcFMuInYemdVpPfou+jY5F9YpGeXNtgXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725222409; c=relaxed/simple;
	bh=c59MGgto4aVmJUWAfO2g4iRJenZr7VQVJAufo+1a7wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYsi1X4usvIQzoUB576bqkkBwSescq8Vm+4a+v+A1siR5BgvdmMGl+gwkecgsd/pN4Eux5O/lkbaBbMMnDs/Kq0dsnB2WreT/lrjGmkLFhbzYteAq/se0va0r90k19QcsRnAS0Whlv+7npZ+VAmj6OvCSa9EbLC+70CPG7a6UKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJ47yieC; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3df13906bcdso1365321b6e.0;
        Sun, 01 Sep 2024 13:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725222406; x=1725827206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oymSihQ9xNkijCwVP8jhm5tPehtP5i+SU6Q/ZWpPuQ=;
        b=BJ47yieCXKrO7rWTVPf6qKhPp2RVC9VYfCELewgEWTQ5KVw9mszLdue90TXQGYCOy8
         LLVH/Rv62LPUBtaASfE8j5HqPMzutCxr15urszWOqa2zeTNwT63vg6f3y8fWeRvpgToz
         YHrLWaqOeAJw0mfhKR7/3hDBNzIynpRk45T32dXHd8caUt0Ua44cNf85ety+PzXvbPzL
         8GQF9wofODQBXojnjg93yK72yP5Ks82H23X2FwMpejoyLeX3bws2m38Hjm7ulC4euTbi
         9WFMElE8aL4dOv725hD0ndc7XVQyQT1dXJXjsG0OhxepkPLSls51cr0xGUFuRSO4eaZ4
         92JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725222406; x=1725827206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oymSihQ9xNkijCwVP8jhm5tPehtP5i+SU6Q/ZWpPuQ=;
        b=brUco8bhPd3Wmblint/kCuLNbDx8G3W8iMldN9wQcyjfIJ/pgkkYc172WE+hmnnH43
         8mt1sfh2jkFjnszSQdM4ZsAFzgCJcMowkG8t6toDKMNO/xW0kV3+01frzofbcJJHuoxe
         DdCSuSWovctntdmatFYWuwucTJAYet1ezTsu9K5If1ahLat6pVcicJth30bYF7GHOuMl
         McgFym+NlTSyhGQrjYDvYFel2aJg0OL0OPcEXt0OxW6dl5nMKFhxyD44KVT1UacAeuEm
         gOGFUkDTz6emKyaG+R8254QZwL5AyWvvN4lk/TVYpZEy0+yatFGFDzdX4DxKbHBNh7Cq
         UeZg==
X-Forwarded-Encrypted: i=1; AJvYcCVw/itYefMbAViE2p7JkcSgLoq6W68PllU667WoJ9Id/3VlLXk0iGrS9NutDsywh/bSAilof29Xm/LY@vger.kernel.org, AJvYcCXlkn4o4VCHHPllRGrzBpQDJHSF4T54hoQUrR+NHdMxo6MIV8wrLv9hBrIuVFGG2XTg9jLLHIGQ3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiEdzlUv3N9n0aZxtDiWb9c7S3gNyKquURpyIt/5Jd0aJ+qQxt
	FlQzbVlszcd6K7g6H3MzrzHcqknqAaUpmqSNnhaKBfJI02oKA/EbcN/5hQgoYbOT6OHjcCoQk54
	FimUZ7nXGtfJfNQ6MPc9g+qVcujlK8BCd
X-Google-Smtp-Source: AGHT+IH5GQdRNg1XGvX1KjmwgNI1LydskMNdRNslrqa2X95W8gIwQ/fT9HHeAKtApyH2Fd34HjEZC1WzxJH9QOo7yiY=
X-Received: by 2002:a05:6871:284:b0:261:146b:b105 with SMTP id
 586e51a60fabf-277c824756fmr5590521fac.41.1725222406534; Sun, 01 Sep 2024
 13:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821214052.6800-1-wahrenst@gmx.net> <20240821214052.6800-2-wahrenst@gmx.net>
 <7ba14fe2-38e0-414c-bc3d-62c1e70741ad@gmx.net>
In-Reply-To: <7ba14fe2-38e0-414c-bc3d-62c1e70741ad@gmx.net>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 1 Sep 2024 15:26:35 -0500
Message-ID: <CABb+yY2ay47mNzMQB0DasvnP-_EZJ7VTSoJFHtiKUySGRCXvWA@mail.gmail.com>
Subject: Re: [PATCH V3 1/9] mailbox: bcm2835: Fix timeout during suspend mode
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Doug Anderson <dianders@chromium.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Lukas Wunner <lukas@wunner.de>, Artur Petrosyan <Arthur.Petrosyan@synopsys.com>, 
	Peter Robinson <pbrobinson@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
	bcm-kernel-feedback-list@broadcom.com, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Russell King <linux@armlinux.org.uk>, Minas Harutyunyan <hminas@synopsys.com>, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel-list@raspberrypi.com, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 4:19=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net> wr=
ote:
>
> Hi Jassi,
>
> Am 21.08.24 um 23:40 schrieb Stefan Wahren:
> > During noirq suspend phase the Raspberry Pi power driver suffer of
> > firmware property timeouts. The reason is that the IRQ of the underlyin=
g
> > BCM2835 mailbox is disabled and rpi_firmware_property_list() will alway=
s
> > run into a timeout [1].
> >
> > Since the VideoCore side isn't consider as a wakeup source, set the
> > IRQF_NO_SUSPEND flag for the mailbox IRQ in order to keep it enabled
> > during suspend-resume cycle.
> >
> > [1]
> > PM: late suspend of devices complete after 1.754 msecs
> > WARNING: CPU: 0 PID: 438 at drivers/firmware/raspberrypi.c:128
> >   rpi_firmware_property_list+0x204/0x22c
> > Firmware transaction 0x00028001 timeout
> > Modules linked in:
> > CPU: 0 PID: 438 Comm: bash Tainted: G         C         6.9.3-dirty #17
> > Hardware name: BCM2835
> > Call trace:
> > unwind_backtrace from show_stack+0x18/0x1c
> > show_stack from dump_stack_lvl+0x34/0x44
> > dump_stack_lvl from __warn+0x88/0xec
> > __warn from warn_slowpath_fmt+0x7c/0xb0
> > warn_slowpath_fmt from rpi_firmware_property_list+0x204/0x22c
> > rpi_firmware_property_list from rpi_firmware_property+0x68/0x8c
> > rpi_firmware_property from rpi_firmware_set_power+0x54/0xc0
> > rpi_firmware_set_power from _genpd_power_off+0xe4/0x148
> > _genpd_power_off from genpd_sync_power_off+0x7c/0x11c
> > genpd_sync_power_off from genpd_finish_suspend+0xcc/0xe0
> > genpd_finish_suspend from dpm_run_callback+0x78/0xd0
> > dpm_run_callback from device_suspend_noirq+0xc0/0x238
> > device_suspend_noirq from dpm_suspend_noirq+0xb0/0x168
> > dpm_suspend_noirq from suspend_devices_and_enter+0x1b8/0x5ac
> > suspend_devices_and_enter from pm_suspend+0x254/0x2e4
> > pm_suspend from state_store+0xa8/0xd4
> > state_store from kernfs_fop_write_iter+0x154/0x1a0
> > kernfs_fop_write_iter from vfs_write+0x12c/0x184
> > vfs_write from ksys_write+0x78/0xc0
> > ksys_write from ret_fast_syscall+0x0/0x54
> > Exception stack(0xcc93dfa8 to 0xcc93dff0)
> > [...]
> > PM: noirq suspend of devices complete after 3095.584 msecs
> >
> > Link: https://github.com/raspberrypi/firmware/issues/1894
> > Fixes: 0bae6af6d704 ("mailbox: Enable BCM2835 mailbox support")
> > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> gentle ping

This sounds like a fix but also a part of 9 patches update. Do you
want this merged as a bugfix now or into the next window.

thanks

