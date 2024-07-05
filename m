Return-Path: <linux-pm+bounces-10702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28523928B41
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 17:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1B81F218A1
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C2616D309;
	Fri,  5 Jul 2024 15:04:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A5D16B74D;
	Fri,  5 Jul 2024 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191850; cv=none; b=fyxacTpZmKrNkpW/EqeGEheDix3wbmeETHbz92fwXMuCNsdkfRix/7Zy3X8XMDUrMN3/HvVxeUbpCpT9OAIFjdvffxMbpQkf/5N+vks9m5uvD8K75EVJUbQyPfASwEhnHOfBVGNtv+icYsC6YWgreFq3OjiswpijpEdQ3CeO21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191850; c=relaxed/simple;
	bh=r/yOQErA5n3xS662Rfm4Aer/ySYE5bky8IDO0CnMpGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB6cfhswgSR3vtd8FFr67kRjUVf46Omm0huOaSGcItNbolBEtixiaOMCJVEZaV4yAJ7eidX3l/im/BF1z5VaB6Ec2rq1IQ8Ee0/PiHFlUE5B/+ARfPAGcuEBrATLbybcMmhRuDvBpN1xa57wPH8UHR2Mm/r9E//xUyQwFJCTt7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D577F100B0385;
	Fri,  5 Jul 2024 17:03:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7B58F4BC74; Fri,  5 Jul 2024 17:03:57 +0200 (CEST)
Date: Fri, 5 Jul 2024 17:03:57 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jiri Slaby <jirislaby@kernel.org>,
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
Message-ID: <ZogLXYopViQO11ta@wunner.de>
References: <20240630153652.318882-1-wahrenst@gmx.net>
 <20240630153652.318882-10-wahrenst@gmx.net>
 <95762956-b46a-4dfa-b22f-bccbfa39558d@broadcom.com>
 <ZoezRpXBgB1B5WjB@wunner.de>
 <4502d826-d80c-4a98-a889-da7badfa698e@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4502d826-d80c-4a98-a889-da7badfa698e@gmx.net>

On Fri, Jul 05, 2024 at 12:22:33PM +0200, Stefan Wahren wrote:
> Am 05.07.24 um 10:48 schrieb Lukas Wunner:
> > A similar issue was reported for Agilex platforms back in 2021:
> > 
> > https://lore.kernel.org/all/5e8cbce0-3260-2971-484f-fc73a3b2bd28@synopsys.com/
> > 
> > It was fixed by commit 3d8d3504d233 ("usb: dwc2: Add platform specific
> > data for Intel's Agilex"), which sets the no_clock_gating flag on that
> > platform.
> 
> From my understanding Samsung noticed this issue at first and
> introduced the no_clock_gating flag [1] and they referenced 0112b7ce68ea
> ("usb: dwc2: Update dwc2_handle_usb_suspend_intr function.") as I did in
> this patch. Later some platforms like Rockchip and Agilex followed.
> 
> Should i better refer to the Samsung bugfix instead of the Agilex bugfix?

I'd say mention both.  The Samsung one because it was the first
occurrence and the Agilex one because it specifically mentions
the interrupt storm which you've also witnessed on the Raspberry Pi.
Samsung's report mentions other symptoms than an interrupt storm.


> > The real question is whether BCM2848 platforms likewise cannot disable
> > the clock of the dwc2 controller or whether this is specific to the
> > BCM2835.  Right now dwc2_set_bcm_params() is applied to both the
> > BCM2848 and BCM2835.  If the BCM2848 behaves differently in this
> > regard, we'd have to duplicate dwc2_set_bcm_params() for the BCM2835.
> 
> From my understand BCM2848 refers to the same SoC, but the ACPI
> implementation uses a different ID [2]. So I think this is safe.
> [2] -
> https://patches.linaro.org/project/linux-usb/patch/20210413215834.3126447-2-jeremy.linton@arm.com/

Careful there, the patch vaguely says...

    With that added and identified as "BCM2848",
    an id in use by other OSs for this device, the dw2
    controller on the BCM2711 will work.

...which sounds like they copy-pasted the BCM2848 id from somewhere else.
I would assume that BCM2848 is really a different SoC and not just
a different name for the BCM2835, but hopefully BroadCom folks will
be able to confirm or deny this (and thus the necessity of the quirk
on BCM2848 and not just on BCM2835).

Thanks,

Lukas

