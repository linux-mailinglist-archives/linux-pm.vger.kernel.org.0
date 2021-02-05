Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B513111F7
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 21:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBES1e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 13:27:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233706AbhBES1S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Feb 2021 13:27:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC17364FBA;
        Fri,  5 Feb 2021 20:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612555742;
        bh=beiP1QVTcTtnz/28je3Db2hFbKVGRBpJgYPrzRQ3FJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HiHatxkiTqo19TZ7agC6KDqUsgXV67Li8ly2L0wqDAIgO/TnRxAG2RsEVs5oqP6c+
         UaOzHqagc4QJeLih2kXFAEt5d7GhSEhvjlhL3gH10/QCgaTVU1AQai8Mn1NFjTiezP
         i1wgd9CTA84LgzCyhkwn5/kx2hr1+O0JvExsTupHij3anIzI/f4gsgHmz14r0nXCYL
         l0+YcKZuoB+EBsv5ijeTNTCycIDJJ3bqKmtNaMYKKxf/lWGat0JwJxc2r6hSYJ80aS
         IrqB6hXBSMagUQ342uqUdCGIfPNEt/aJJPrbGL+JfG1RPWW1Icry7tJhu+BlO9Wj7x
         cGUyryDyXIy7Q==
Date:   Fri, 5 Feb 2021 14:08:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Yicong Yang <yangyicong@hisilicon.com>, gregkh@linuxfoundation.org,
        jdelvare@suse.com, giometti@enneenne.com, abbotti@mev.co.uk,
        hsweeten@visionengravers.com, kw@linux.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kbuild@vger.kernel.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, prime.zeng@huawei.com,
        linuxarm@openeuler.org
Subject: Re: [PATCH 2/4] hwmon: Use subdir-ccflags-* to inherit debug flag
Message-ID: <20210205200859.GA193526@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205182832.GA186268@roeck-us.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 05, 2021 at 10:28:32AM -0800, Guenter Roeck wrote:
> On Fri, Feb 05, 2021 at 05:44:13PM +0800, Yicong Yang wrote:
> > From: Junhao He <hejunhao2@hisilicon.com>
> > 
> > Use subdir-ccflags-* instead of ccflags-* to inherit the debug
> > settings from Kconfig when traversing subdirectories.
> > 
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> What problem does this fix ? Maybe I am missing it, but I don't see
> DEBUG being used in a subdirectory of drivers/hwmon.

It's my fault for raising this question [1].  Yicong fixed a real
problem in drivers/pci, where we are currently using

  ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG

so CONFIG_PCI_DEBUG=y turns on debug in drivers/pci, but not in the
subdirectories.  That's surprising to users.

So my question was whether we should default to using subdir-ccflags
for -DDEBUG in general, and only use ccflags when we have
subdirectories that have their own debug options, e.g.,

  drivers/i2c/Makefile:ccflags-$(CONFIG_I2C_DEBUG_CORE) := -DDEBUG
  drivers/i2c/algos/Makefile:ccflags-$(CONFIG_I2C_DEBUG_ALGO) := -DDEBUG
  drivers/i2c/busses/Makefile:ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
  drivers/i2c/muxes/Makefile:ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG

I mentioned drivers/hwmon along with a few others that have
subdirectories, do not have per-subdirectory debug options, and use
ccflags.  I didn't try to determine whether those subdirectories
currently use -DDEBUG.

In the case of drivers/hwmon, several drivers do use pr_debug(),
and CONFIG_HWMON_DEBUG_CHIP=y turns those on.  But if somebody
were to add pr_debug() to drivers/hwmon/occ/common.c, for example,
CONFIG_HWMON_DEBUG_CHIP=y would *not* turn it on.  That sounds
surprising to me, but if that's what you intend, that's totally fine.

[1] https://lore.kernel.org/r/20210204161048.GA68790@bjorn-Precision-5520

> > ---
> >  drivers/hwmon/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 09a86c5..1c0c089 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -201,5 +201,5 @@ obj-$(CONFIG_SENSORS_XGENE)	+= xgene-hwmon.o
> >  obj-$(CONFIG_SENSORS_OCC)	+= occ/
> >  obj-$(CONFIG_PMBUS)		+= pmbus/
> >  
> > -ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
> > +subdir-ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
> >  
> > -- 
> > 2.8.1
> > 
