Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A252AD548
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 12:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgKJLdX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 06:33:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgKJLdX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Nov 2020 06:33:23 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48F4F20637;
        Tue, 10 Nov 2020 11:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605008002;
        bh=XmyBF4mbE1OM1mEytauF8JvdxrN6jCorir7u0p0LO70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgGscdrbRU0K1s1G+QBTQ0vVhF5oyvOiueyELT/dbMibG0ZuHTIJ15oVUOEfUs5yh
         sr/qyAIc1nMcbSEZoFfwGELnMKx0p3Brv/d+H6RCA7GewmCCBkKkB8NORc8ra+cxZc
         nQ0I6QrQXF5i0zASkVEKGnhen3KYoc72T9XFQ8D0=
Date:   Tue, 10 Nov 2020 12:34:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: How to enable auto-suspend by default
Message-ID: <X6p6ubTOoMPUPPXi@kroah.com>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 10, 2020 at 11:57:07AM +0100, Bastien Nocera wrote:
> Hey,
> 
> systemd has been shipping this script to enable auto-suspend on a
> number of USB and PCI devices:
> https://github.com/systemd/systemd/blob/master/tools/chromiumos/gen_autosuspend_rules.py
> 
> The problem here is twofold. First, the list of devices is updated from
> ChromeOS, and the original list obviously won't be updated by ChromeOS
> developers unless a device listed exists in a ChromeBook computer,
> which means a number of devices that do support autosuspend aren't
> listed.
> 
> The other problem is that this list needs to exist at all, and that it
> doesn't seem possible for device driver developers (at various levels
> of the stack) to opt-in to auto-suspend when all the variants of the
> device (or at least detectable ones) support auto-suspend.

A driver can say they support autosuspend today, but I think you are
concerned about the devices that are controlled by class-compliant
drivers, right?  And for those, no, we can't do this in the kernel as
there are just too many broken devices out there.

As proof of this, look at other operating systems.  They had to
implement the same type of "allowed devices" list that we do.  In fact,
we did this for Linux because they did this, which means that when
hardware manufacturers test their device, they only test with other
operating systems and not Linux and so, we need to match what those
other OSes do as well.

Sorry,

greg k-h
