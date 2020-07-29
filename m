Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8E2232120
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgG2PBK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 11:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgG2PBJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 11:01:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF74E207E8;
        Wed, 29 Jul 2020 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596034869;
        bh=ESM/C4n2/9SZm7+Qrh9WZ3Nyo1d10BOHwjAtSu+wytc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikyk9lb/olM7+v7ejcklpKjX1TxtamqCPeSAIp0xtA7IAEt7QEM0UDxkzNNNzosw5
         MCyBjrZyd2YJiyUU+L9hfpqZs5ckGC9TZlWwHF+E19ZIUB6GkdXNlCNzYrpWoB2/7e
         dLVnnd5jKRn8M2XhUaGgKUY4DCLzQD3Mik1d2VL0=
Date:   Wed, 29 Jul 2020 17:01:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 1/1] power: Emit changed uevent on
 wakeup_sysfs_add/remove
Message-ID: <20200729150100.GA3508555@kroah.com>
References: <20200707172845.4177903-1-abhishekpandit@chromium.org>
 <20200707102823.v5.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
 <20200723183235.GA3445384@kroah.com>
 <CAJZ5v0jXcfO3YiMgkc7u=qqZy+jyT=RGagF3yAFnAhiJfyfcuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jXcfO3YiMgkc7u=qqZy+jyT=RGagF3yAFnAhiJfyfcuQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 27, 2020 at 03:38:02PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 23, 2020 at 8:32 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jul 07, 2020 at 10:28:44AM -0700, Abhishek Pandit-Subedi wrote:
> > > Udev rules that depend on the power/wakeup attribute don't get triggered
> > > correctly if device_set_wakeup_capable is called after the device is
> > > created. This can happen for several reasons (driver sets wakeup after
> > > device is created, wakeup is changed on parent device, etc) and it seems
> > > reasonable to emit a changed event when adding or removing attributes on
> > > the device.
> > >
> > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >
> > Rafael, any objection to this?  Do you want me to take it through my
> > tree, or are you going to take it through yours?  Either is fine for me.
> 
> It's already there in my tree with the R-by tag from you.

{sigh}  Sorry for the noise.

greg k-h
