Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E604FF874A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 05:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKLEQt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 23:16:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53432 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfKLEQs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 23:16:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so1542118wmc.3
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2019 20:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W50KQG2LFA7dHByW0G4rq+4w30ZkeUHgi/q749Efz9c=;
        b=E0hRKU/Dadwcx5lWC6Ebg2wEBHzcFiZavDG8bsoKpnC1H225E6HAfLRzGIpXXPXr/K
         /n944XNNZk2M0OaMQTi858v3bUpjhR8cMD14PV85iO2EWbn36gQ6k3sMV79xxo1hvIDE
         WkbH35o2w7c/D9v/+tX54m+90eyGuSkkXRrGRV6+pzyOGSFPmvrYclzsIlFwou7DNiCz
         FyGtGRS3DyikeLyPKb94A2gg7ngVEpp4+2k6CYXAI053kJnhL/9Uh9mTLeXbh+4Fmcza
         /QCGAh/HrSMZ27VizL2GoblO5awCKHHX1yBN+S9MT7xYNmrKeOKEPuV2cOGonAEXjzsv
         OYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W50KQG2LFA7dHByW0G4rq+4w30ZkeUHgi/q749Efz9c=;
        b=K05XvhlTDcsFVfjADGBOMFudOVrh9KpW/LRxyi3iHdLCzEKNigx/mvYtnX7nHZWKOA
         SpylqViH9f3oL1YkjWtFD0EGWaxGJ/GUot7pZs8DD2k0LK6ODBpMgCMyZWyntwuOQOJY
         LQp14yINN2diS+JQ6lyXK/k9ilLS0dCH9zX5ju01C2hg/9fBi4iyEiBK82u3uu1NWrnp
         xK1p1gzTBRi0EAu14OAwoPvOL1S4tM7RI8vkFL/IfuOiTbKE9y8Trk2xPcug2n3f33Ck
         /6SAR9cRsz4V5W41CioHX1GwzpeSFjyJ6njRUA0Vx5DaTwA5ztrpVZ2l7juOhds9sTD6
         u+rQ==
X-Gm-Message-State: APjAAAXgLIAMKL473z/K0dnYxioM7luVbBIReK51/0tNZF95cOz7sPtT
        +3IlluuDDHi3FRQLmYIoZrb+W4eiDeUO9xCpUmxJDg==
X-Google-Smtp-Source: APXvYqxUyN+ibz5Y/rVkCie2tTUD7Oq+mca7VUbRYcUXzCivhJSFkdhIOnQeiyijk6BsUunYFgG1TWWyTYC7BV+GO9s=
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr1791779wmf.24.1573532204655;
 Mon, 11 Nov 2019 20:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20191107212408.11857-1-hch@lst.de> <CAAhSdy3SGAkOFMhx320KJdPDh6c=qcKqCZ=qrXNKBGtejpZwSA@mail.gmail.com>
 <20191111161217.GA19157@lst.de> <alpine.DEB.2.21.999.1911111717320.32333@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.21.999.1911111717320.32333@utopia.booyaka.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 12 Nov 2019 09:46:33 +0530
Message-ID: <CAAhSdy2Lki2rZeNJyH6p0RKWjd6O+DboDE_mq8rHzXA0JRQ=7g@mail.gmail.com>
Subject: Re: QEMU RISC-V virt machine poweroff driver
To:     Paul Walmsley <paul@pwsan.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 11, 2019 at 10:50 PM Paul Walmsley <paul@pwsan.com> wrote:
>
> On Mon, 11 Nov 2019, Christoph Hellwig wrote:
>
> > On Mon, Nov 11, 2019 at 05:06:24PM +0530, Anup Patel wrote:
> > > We really don't need this driver. Instead, we can simply re-use
> > > following drivers:
> > > mfd/syscon
> > > power/reset/syscon-reboot
> > > power/reset/syscon-poweroff
> > >
> > > Just enable following to your defconfig:
> > > CONFIG_POWER_RESET=y
> > > CONFIG_POWER_RESET_SYSCON=y
> > > CONFIG_POWER_RESET_SYSCON_POWEROFF=y
> > > CONFIG_SYSCON_REBOOT_MODE=y
> > >
> > >
> > > Once above drivers are enabled in your defconfig, make sure
> > > test device DT nodes are described in the following way for virt machine:
> >
> > Oh well, that is a lot more churn than a just works driver, and
> > will also pull it dependencies like regmap which quite blow up the
> > kernel size.  But I guess that is where modern Linux drivers are
> > heading, so I'm not going to complain too loud..
>
> The core issue is that putting random register writes in DT doesn't match
> the hardware.  And the doctrine with DT has always been that it's supposed
> to represent the actual hardware.  On FPGA bitstreams or ASICs that have
> the teststatus/testfinisher IP block, there really is an IP block out
> there - it's not just a bare register.
>
> If you update your driver to note that this is a SiFive IP block rather
> than a "RISC-V" IP block, I'll ack it.
>

The SiFive Test device has only one register at offset 0x0 and three
possible magic values (0x3333, 0x5555, and 0x7777).

The SYSCON based Reboot and Poweroff driver do exactly the same
thing what Christop's virt machine poweroff driver does so we are not
doing "random register writes" via DT.

In fact, using SYSCON based Reboot and Poweroff we are actually
describing the Reboot and Poweroff mechanism directly in DT without
adding a complete driver for just one register write. This means we
are totally aligned with "DT doctrine" and over here we going one-step
more by describing Reboot and Poweroff mechanism in DT.

A quick GREP shows that the SYSCON Reboot and Poweroff drivers
are quite widely used in ARM, ARM64 and MIPS architectures. Some of
the  SOCs using these drivers are: Samsung Exynos, HiSilicon Hi3660,
HiSilicon Hi6220, Rockchip RK3xxx, AppliedMicro XGene, Broadcom
BCM33xx, Broadcom BCM63xx, etc. Majority of ARM/ARM64 SOCs
these days use the PSCI based SYSTEM RESET and SHUTDOWN
methods so we might not see more Reboot and Poweroff drivers for
ARM world.

IMHO, we should definitely avoid adding a driver to Linux when there
a generic driver already available. This helps in kernel maintenance
in long-term.

Regards,
Anup
