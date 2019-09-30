Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B03DC252C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 18:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfI3QcN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 12:32:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:54770 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfI3QcN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 12:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qZmq/vZ1uF91H9zblUBrI03dFEWUTL8yzpnf7lGHSRA=; b=1YJGbspzHZXDVLB+IPjixtBnBF
        78wyiJv87Tac5ug/oS1uaZGWCAAU7IUysBIBn7IfosmXCBnwwLGZv5jV/3fVNxx5pzgcktZZwmvQ8
        Buks5BBHmGfeAQGLrYVXGcDleNsAXg2DKjDwa/X6PzEOq2cyIvXWW/y5nDWXuj2A1+nI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iEyah-0004oW-L2; Mon, 30 Sep 2019 18:32:03 +0200
Date:   Mon, 30 Sep 2019 18:32:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jamie Lentin <jm@lentin.co.uk>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] This patch introduces a feature to force
 gpio-poweroff module
Message-ID: <20190930163203.GC15343@lunn.ch>
References: <20190930103531.13764-1-oleksandr.suvorov@toradex.com>
 <20190930121440.GC13301@lunn.ch>
 <CAGgjyvEx_F0C2XHDGxf3F0Z8iHF1vQZkoPft3_ZbTswVFv=SJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGgjyvEx_F0C2XHDGxf3F0Z8iHF1vQZkoPft3_ZbTswVFv=SJA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 30, 2019 at 02:11:59PM +0000, Oleksandr Suvorov wrote:
> Hi Andrew,
> 
> On Mon, Sep 30, 2019 at 3:16 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Mon, Sep 30, 2019 at 10:35:36AM +0000, Oleksandr Suvorov wrote:
> > > to register its own pm_power_off handler even if someone has registered
> > > this handler earlier.
> > > Useful to change a way to power off the system using DT files.
> >
> > Hi Oleksandr
> >
> > I'm not sure this is a good idea. What happens when there are two
> > drivers using forced mode? You then get which ever is register last.
> > Non deterministic behaviour.
> 
> You're right, we have to handle a case when gpio-poweroff fails to
> power the system off. Please look at the
> 2nd version of the patchset.
> 
> There are 3 only drivers that forcibly register its own pm_power_off
> handler even if it has been registered before.
> 
> drivers/firmware/efi/reboot.c - supports chained call of next
> pm_power_off handler if its own handler fails.
> 
> arch/x86/platform/iris/iris.c, drivers/char/ipmi/ipmi_poweroff.c -
> don't support calling of next pm_power_off handler.
> Looks like these drivers should be fixed too.
> 
> All other drivers don't change already initialized pm_power_off handler.
> 
> > What is the other driver which is causing you problems? How is it
> > getting probed? DT?
> 
> There are several PMUs, RTCs, watchdogs that register their own pm_power_off.
> Most of them, probably not all, are probed from DT.

And which specific one is causing you problems.

I don't like this forced parameter. No other driver is using it.

Maybe we should change this driver to support chained pm_power_off
handlers?

   Andrew
