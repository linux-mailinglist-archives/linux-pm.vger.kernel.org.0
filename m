Return-Path: <linux-pm+bounces-10658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAD092840A
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 10:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C482C1F22864
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 08:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC6A144D34;
	Fri,  5 Jul 2024 08:48:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1BE144D0E;
	Fri,  5 Jul 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169299; cv=none; b=gIHj08HqnTak6sniKkFdrsBS/xwQcn++xTaI2EWsN4F017JG1v1Pb1+k2pfuo74RXRbovSilJmROCo+un7/BQ0/SSgcJKNNv9zzyxeqqmv01NOiEU8pzWjPuqX8+AIUbaQWXXj+O4M/G0ZrzVmcW+BsHjcgs/R/LQXle5ptQFjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169299; c=relaxed/simple;
	bh=nvSl3iBk/fZcuCRP386vT6ZbD9nSkasbsf8j9vWzPtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaKwTZALSOkEjvl3oBhEAHRSwWhoHg3gnUy8Xmhpw6NRziw+EAC4wL3zNeoTPFHPFixYn1tQmqjNMvrLdcihDHl2AoXhrqacUDyDzTUAhRg/Ix/5EAztXMLR7t8G5/FApNIIyEyjBLO0z2IYp5tebmWTvTXnYmZQ2jhSsXygpkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 77A2E3000D5B1;
	Fri,  5 Jul 2024 10:48:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 637213E9B8; Fri,  5 Jul 2024 10:48:06 +0200 (CEST)
Date: Fri, 5 Jul 2024 10:48:06 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Stefan Wahren <wahrenst@gmx.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Peter Robinson <pbrobinson@gmail.com>,
	dri-devel@lists.freedesktop.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com
Subject: Re: [PATCH 09/11] usb: dwc2: Skip clock gating on Broadcom SoCs
Message-ID: <ZoezRpXBgB1B5WjB@wunner.de>
References: <20240630153652.318882-1-wahrenst@gmx.net>
 <20240630153652.318882-10-wahrenst@gmx.net>
 <95762956-b46a-4dfa-b22f-bccbfa39558d@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95762956-b46a-4dfa-b22f-bccbfa39558d@broadcom.com>

On Thu, Jul 04, 2024 at 03:14:50PM +0100, Florian Fainelli wrote:
> On 6/30/2024 4:36 PM, Stefan Wahren wrote:
> > On resume of the Raspberry Pi the dwc2 driver fails to enable
> > HCD_FLAG_HW_ACCESSIBLE before re-enabling the interrupts.
> > This causes a situation where both handler ignore a incoming port
> > interrupt and force the upper layers to disable the dwc2 interrupt line.
> > This leaves the USB interface in a unusable state:
> > 
> > irq 66: nobody cared (try booting with the "irqpoll" option)
> > CPU: 0 PID: 0 Comm: swapper/0 Tainted: G W          6.10.0-rc3
> > Hardware name: BCM2835
> > Call trace:
> > unwind_backtrace from show_stack+0x10/0x14
> > show_stack from dump_stack_lvl+0x50/0x64
> > dump_stack_lvl from __report_bad_irq+0x38/0xc0
> > __report_bad_irq from note_interrupt+0x2ac/0x2f4
> > note_interrupt from handle_irq_event+0x88/0x8c
> > handle_irq_event from handle_level_irq+0xb4/0x1ac
> > handle_level_irq from generic_handle_domain_irq+0x24/0x34
> > generic_handle_domain_irq from bcm2836_chained_handle_irq+0x24/0x28
> > bcm2836_chained_handle_irq from generic_handle_domain_irq+0x24/0x34
> > generic_handle_domain_irq from generic_handle_arch_irq+0x34/0x44
> > generic_handle_arch_irq from __irq_svc+0x88/0xb0

A similar issue was reported for Agilex platforms back in 2021:

https://lore.kernel.org/all/5e8cbce0-3260-2971-484f-fc73a3b2bd28@synopsys.com/

It was fixed by commit 3d8d3504d233 ("usb: dwc2: Add platform specific
data for Intel's Agilex"), which sets the no_clock_gating flag on that
platform.

Looking at drivers/usb/dwc2/params.c, numerous other platforms need
the same flag.

Please amend the commit message to mention the Agilex issue and
resulting commit.


> > --- a/drivers/usb/dwc2/params.c
> > +++ b/drivers/usb/dwc2/params.c
> > @@ -23,6 +23,7 @@ static void dwc2_set_bcm_params(struct dwc2_hsotg *hsotg)
> >   	p->max_transfer_size = 65535;
> >   	p->max_packet_count = 511;
> >   	p->ahbcfg = 0x10;
> > +	p->no_clock_gating = true;
> 
> Could we set this depending upon whether the dwc2 host controller is a
> wake-up source for the system or not?

The flag seems to mean whether the platform is actually capable of
disabling the clock of the USB controller.  BCM2835 seems to be
incapable and as a result, even though dwc2_host_enter_clock_gating()
is called, the chip signals interrupts.

There doesn't seem to be a relation to using the controller as a
wakeup source, so your comment doesn't seem to make sense.
If the clock can't be gated, the chip can always serve as a
wakeup source.

The real question is whether BCM2848 platforms likewise cannot disable
the clock of the dwc2 controller or whether this is specific to the
BCM2835.  Right now dwc2_set_bcm_params() is applied to both the
BCM2848 and BCM2835.  If the BCM2848 behaves differently in this
regard, we'd have to duplicate dwc2_set_bcm_params() for the BCM2835.

Thanks,

Lukas

