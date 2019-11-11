Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 333E6F787C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 17:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKKQMV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 11:12:21 -0500
Received: from verein.lst.de ([213.95.11.211]:50278 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKQMV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Nov 2019 11:12:21 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 960D068B05; Mon, 11 Nov 2019 17:12:17 +0100 (CET)
Date:   Mon, 11 Nov 2019 17:12:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@lst.de>, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-pm@vger.kernel.org
Subject: Re: QEMU RISC-V virt machine poweroff driver
Message-ID: <20191111161217.GA19157@lst.de>
References: <20191107212408.11857-1-hch@lst.de> <CAAhSdy3SGAkOFMhx320KJdPDh6c=qcKqCZ=qrXNKBGtejpZwSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy3SGAkOFMhx320KJdPDh6c=qcKqCZ=qrXNKBGtejpZwSA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 11, 2019 at 05:06:24PM +0530, Anup Patel wrote:
> We really don't need this driver. Instead, we can simply re-use
> following drivers:
> mfd/syscon
> power/reset/syscon-reboot
> power/reset/syscon-poweroff
> 
> Just enable following to your defconfig:
> CONFIG_POWER_RESET=y
> CONFIG_POWER_RESET_SYSCON=y
> CONFIG_POWER_RESET_SYSCON_POWEROFF=y
> CONFIG_SYSCON_REBOOT_MODE=y
> 
> 
> Once above drivers are enabled in your defconfig, make sure
> test device DT nodes are described in the following way for virt machine:

Oh well, that is a lot more churn than a just works driver, and
will also pull it dependencies like regmap which quite blow up the
kernel size.  But I guess that is where modern Linux drivers are
heading, so I'm not going to complain too loud..
