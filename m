Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33648FBDA2
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 02:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfKNBu1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 20:50:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37878 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfKNBu1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 20:50:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id d5so3492201otp.4;
        Wed, 13 Nov 2019 17:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9nyrjASHuxY3SmUh/9OWattAGU9yvQiMC8XCKQ9PU6E=;
        b=lzPuLsM6SwpBrZDzyqaWEj+1bd6L9GhqdGl4KD3LwVEgFkSwpDUVz9Q5qtNfuvkWYs
         pzRI2uQMUlgjnNz2elrJ6bXmVCOHE0uWLySJVrm4pKtr8y4oVf9eX83KScyRUCu2JUFM
         +fsHJEWrij4+cUe2bpt+RMUbPZPyNgA/W1vLwEuGXlk86Ai3+knzGkAaSTmzABO5+KYV
         ZbmXD4C09Dnm33lUxehaGO45QUGnYvpul0okbjEmzvKKp3H7GpoR2NYwtZyAovwPUso+
         HfFj7kUasPo2ZFsgCRtwFl5jcavbVpCXpPIhJ7PAiww0ETzicrOkDcEV6m8wqhTUr788
         RprQ==
X-Gm-Message-State: APjAAAXZG14l3qCsGuhEo0rzHg85tRhY5vcC9FlDEa1Iib7I8HVziaNS
        fbToc+3ppD5ZgqLNam6wHQ==
X-Google-Smtp-Source: APXvYqxXDx1ryBh7LgzlyMuLqJ1JbZcffCwA8tUWrgTFQ29Fnfy0PdvhQizqi+lr/ix1eERF8bgUMQ==
X-Received: by 2002:a9d:3675:: with SMTP id w108mr5840239otb.81.1573696226412;
        Wed, 13 Nov 2019 17:50:26 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c20sm1327310otm.80.2019.11.13.17.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 17:50:25 -0800 (PST)
Date:   Wed, 13 Nov 2019 19:50:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Paul Walmsley <paul@pwsan.com>, Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>
Subject: Re: QEMU RISC-V virt machine poweroff driver
Message-ID: <20191114015025.GB1748@bogus>
References: <20191107212408.11857-1-hch@lst.de>
 <CAAhSdy3SGAkOFMhx320KJdPDh6c=qcKqCZ=qrXNKBGtejpZwSA@mail.gmail.com>
 <20191111161217.GA19157@lst.de>
 <alpine.DEB.2.21.999.1911111717320.32333@utopia.booyaka.com>
 <CAAhSdy2Lki2rZeNJyH6p0RKWjd6O+DboDE_mq8rHzXA0JRQ=7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy2Lki2rZeNJyH6p0RKWjd6O+DboDE_mq8rHzXA0JRQ=7g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 12, 2019 at 09:46:33AM +0530, Anup Patel wrote:
> On Mon, Nov 11, 2019 at 10:50 PM Paul Walmsley <paul@pwsan.com> wrote:
> >
> > On Mon, 11 Nov 2019, Christoph Hellwig wrote:
> >
> > > On Mon, Nov 11, 2019 at 05:06:24PM +0530, Anup Patel wrote:
> > > > We really don't need this driver. Instead, we can simply re-use
> > > > following drivers:
> > > > mfd/syscon
> > > > power/reset/syscon-reboot
> > > > power/reset/syscon-poweroff
> > > >
> > > > Just enable following to your defconfig:
> > > > CONFIG_POWER_RESET=y
> > > > CONFIG_POWER_RESET_SYSCON=y
> > > > CONFIG_POWER_RESET_SYSCON_POWEROFF=y
> > > > CONFIG_SYSCON_REBOOT_MODE=y
> > > >
> > > >
> > > > Once above drivers are enabled in your defconfig, make sure
> > > > test device DT nodes are described in the following way for virt machine:
> > >
> > > Oh well, that is a lot more churn than a just works driver, and
> > > will also pull it dependencies like regmap which quite blow up the
> > > kernel size.  But I guess that is where modern Linux drivers are
> > > heading, so I'm not going to complain too loud..
> >
> > The core issue is that putting random register writes in DT doesn't match
> > the hardware.  And the doctrine with DT has always been that it's supposed
> > to represent the actual hardware.  On FPGA bitstreams or ASICs that have
> > the teststatus/testfinisher IP block, there really is an IP block out
> > there - it's not just a bare register.
> >
> > If you update your driver to note that this is a SiFive IP block rather
> > than a "RISC-V" IP block, I'll ack it.
> >
> 
> The SiFive Test device has only one register at offset 0x0 and three
> possible magic values (0x3333, 0x5555, and 0x7777).
> 
> The SYSCON based Reboot and Poweroff driver do exactly the same
> thing what Christop's virt machine poweroff driver does so we are not
> doing "random register writes" via DT.
> 
> In fact, using SYSCON based Reboot and Poweroff we are actually
> describing the Reboot and Poweroff mechanism directly in DT without
> adding a complete driver for just one register write. This means we
> are totally aligned with "DT doctrine" and over here we going one-step
> more by describing Reboot and Poweroff mechanism in DT.
> 
> A quick GREP shows that the SYSCON Reboot and Poweroff drivers
> are quite widely used in ARM, ARM64 and MIPS architectures. Some of
> the  SOCs using these drivers are: Samsung Exynos, HiSilicon Hi3660,
> HiSilicon Hi6220, Rockchip RK3xxx, AppliedMicro XGene, Broadcom
> BCM33xx, Broadcom BCM63xx, etc. Majority of ARM/ARM64 SOCs
> these days use the PSCI based SYSTEM RESET and SHUTDOWN
> methods so we might not see more Reboot and Poweroff drivers for
> ARM world.
> 
> IMHO, we should definitely avoid adding a driver to Linux when there
> a generic driver already available. This helps in kernel maintenance
> in long-term.

I guess I should have finished reading the thread...

I agree with both of you. :) The DT binding should match the h/w as Paul 
says. However, a h/w specific binding can easily map to a generic driver 
if a given client OS has one. That probably hasn't been done yet for 
syscon-poweroff, but should.

Rob
