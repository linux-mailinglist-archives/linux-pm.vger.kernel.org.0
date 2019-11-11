Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE47F79E4
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 18:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKKR1W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 12:27:22 -0500
Received: from utopia.booyaka.com ([74.50.51.50]:39270 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKKR1W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 12:27:22 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Nov 2019 12:27:22 EST
Received: (qmail 588 invoked by uid 1019); 11 Nov 2019 17:20:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Nov 2019 17:20:41 -0000
Date:   Mon, 11 Nov 2019 17:20:41 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Christoph Hellwig <hch@lst.de>
cc:     Anup Patel <anup@brainfault.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: QEMU RISC-V virt machine poweroff driver
In-Reply-To: <20191111161217.GA19157@lst.de>
Message-ID: <alpine.DEB.2.21.999.1911111717320.32333@utopia.booyaka.com>
References: <20191107212408.11857-1-hch@lst.de> <CAAhSdy3SGAkOFMhx320KJdPDh6c=qcKqCZ=qrXNKBGtejpZwSA@mail.gmail.com> <20191111161217.GA19157@lst.de>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 11 Nov 2019, Christoph Hellwig wrote:

> On Mon, Nov 11, 2019 at 05:06:24PM +0530, Anup Patel wrote:
> > We really don't need this driver. Instead, we can simply re-use
> > following drivers:
> > mfd/syscon
> > power/reset/syscon-reboot
> > power/reset/syscon-poweroff
> > 
> > Just enable following to your defconfig:
> > CONFIG_POWER_RESET=y
> > CONFIG_POWER_RESET_SYSCON=y
> > CONFIG_POWER_RESET_SYSCON_POWEROFF=y
> > CONFIG_SYSCON_REBOOT_MODE=y
> > 
> > 
> > Once above drivers are enabled in your defconfig, make sure
> > test device DT nodes are described in the following way for virt machine:
> 
> Oh well, that is a lot more churn than a just works driver, and
> will also pull it dependencies like regmap which quite blow up the
> kernel size.  But I guess that is where modern Linux drivers are
> heading, so I'm not going to complain too loud..

The core issue is that putting random register writes in DT doesn't match 
the hardware.  And the doctrine with DT has always been that it's supposed 
to represent the actual hardware.  On FPGA bitstreams or ASICs that have 
the teststatus/testfinisher IP block, there really is an IP block out 
there - it's not just a bare register.

If you update your driver to note that this is a SiFive IP block rather 
than a "RISC-V" IP block, I'll ack it.


- Paul
