Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8534B1E5AD4
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgE1Ib4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 04:31:56 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:40166 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgE1Ib4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 04:31:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 262EF80307C0;
        Thu, 28 May 2020 08:31:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mso_D6x-Sr2v; Thu, 28 May 2020 11:31:46 +0300 (MSK)
Date:   Thu, 28 May 2020 11:31:44 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v3 0/2] syscon: Alter syscon and reboot drivers
Message-ID: <20200528083144.5r2qn3mule4dvvgf@mobilestation>
References: <20200526135102.21236-1-Sergey.Semin@baikalelectronics.ru>
 <20200528070311.uj6bxlplxe2bths5@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200528070311.uj6bxlplxe2bths5@earth.universe>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 28, 2020 at 09:03:11AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, May 26, 2020 at 04:50:59PM +0300, Serge Semin wrote:
> > This is a small patchset about tuning the syscon infrastructure a bit.
> > As it's going to be general in the framework of the Baikal-T1 SoC support
> > integration into the kernel, we suggest to replace the legacy text-based
> > syscon-reboot-mode dts-bindings file with yaml-based one. Then seeing a
> > syscon reboot block is normally expected to be a part of a system
> > controller and based on the discussion
> > https://lore.kernel.org/linux-pm/20200306130402.1F4F0803079F@mail.baikalelectronics.ru/
> > we decided to alter the syscon reboot driver so one would also try to fetch
> > the syscon registers map from a parental DT node. regmap property is left
> > supported although it's marked as deprecated from now.
> > 
> > This patchset is rebased and tested on the mainline Linux kernel 5.7-rc4:
> > 0e698dfa2822 ("Linux 5.7-rc4")
> > tag: v5.7-rc4
> > 
> > Changelog v2:
> > - Add Sebastian' Acked-by tag to patch 1.
> > - Use a shorter summary describing the bindings modification patches.
> > - Our corporate email server doesn't change Message-Id anymore, so the patchset
> >   is resubmitted being in the cover-letter-threaded format.
> > - Discard patch with syscon "-endian" property support. As Rob said It shall be
> >   in the common dt-schema.
> > - Replace patches of adding a regmap property support to the syscon-reboot-mode
> >   with patches making syscon-reboot a sub-node of a system controller node.
> > - Mark regmap property as deprecated from now.
> > 
> > Link: https://lore.kernel.org/linux-pm/20200507233846.11548-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v3:
> > - Discard the commit 6acd3ecd88ff ("dt-bindings: power: reset: Convert
> >   syscon-reboot-mode to DT schema") since it has been merged in by Sebatian.
> > - Add Rob's Reviewed-by tag to the patch "dt-bindings: power: reset: Unrequire
> >   regmap property in syscon-reboot node"
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> > Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
> > Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
> > Cc: Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-mips@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > 
> > Serge Semin (2):
> >   dt-bindings: power: reset: Unrequire regmap property in syscon-reboot
> >     node
> >   power: reset: syscon-reboot: Add parental syscon support
> > 
> >  .../bindings/power/reset/syscon-reboot.yaml       | 15 ++++++++++-----
> >  drivers/power/reset/syscon-reboot.c               |  7 +++++--
> >  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> Thanks, I queued both patches to power-supply's for-next branch.
> 
> -- Sebastian

Great! Thanks.

-Sergey
