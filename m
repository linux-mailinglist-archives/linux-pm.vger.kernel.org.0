Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66BCA17ED91
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 02:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgCJBCx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 21:02:53 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:44538 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgCJBCx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2020 21:02:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 14C4680307C5;
        Tue, 10 Mar 2020 01:02:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F8oVAyj-VzAj; Tue, 10 Mar 2020 04:02:47 +0300 (MSK)
Date:   Tue, 10 Mar 2020 04:01:50 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-mips@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/22] mips: Prepare MIPS-arch code for Baikal-T1 SoC
 support
References: <20200306124705.6595-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200306124705.6595-1-Sergey.Semin@baikalelectronics.ru>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200310010249.14C4680307C5@mail.baikalelectronics.ru>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 06, 2020 at 03:46:43PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
> 
> This is a first patchset of a series of about 25 ones, which are intended to
> add the full Baikal-T1 SoC [1] support to the Linux kernel. Since they will
> concern various kernel subsystems, I decided to split the whole work up into
> the patchesets in accordance with the subsystems/devices their changes are
> introduced for. Nearly 2/3 of the work is already done and will be sent out
> very soon. While the rest of the changes specifically related to the fast-speed
> interfaces (DW 12G PHY, PCIe, SATA, xGBE, GMAC, USB, DDRC, IC) are still in
> refactoring and preparation for integration into the mainline kernel. Hopefully
> I'll finish them up in the next two-three months, and submit them straight
> away.
> 
> Getting back to this patchset. As the subject states this is intended to
> prepare the MIPS-arch and generic kernel code for further Baikal-T1 SoC
> platform support integration (note the Baikal-T1 SoC platform code will be
> submitted last after the whole series of patchsets as a closure of the
> submission process). First of all the patchset starts with a set of changes
> to the dt-bindings kernel concerning MIPS CPC and CDMM nodes as being described
> by the trivial device bindings. In addition we updated the vendors prefix
> schema with Baikal Electronics JSC prefix so being further committed device
> drivers would be correctly accepted by the checkpatch-script.
> 
> Then I found out that dtc-compiler integrated into the kernel doesn't support
> all the possible values of the 'reg'-property used to define the i2c-slave
> devices address. It may have 10-bits and own-slave flags, so the compiler has
> to deal with them. Even though the patch might be better to be integrated into
> the mainline dtc repo I decided to send it to the kernel first.
> 
> While I was working with the MIPS architecture code, I discovered, that there
> is a bug in the Coherency Manager v2 error causes declaration and the errors
> handler lacked of CM2  L2 ECC/parity errors support. So the fixes are here in
> the patchset.
> 
> Baikal-T1 SoC is based on the MIPS P5600 Warrior IP-core, which itself has
> MIPS32 Release 5 architecture. Even though on ISA level it doesn't differ much
> from the MIPS32 Release 2 release, there are still some peculiarities, which
> make it's justified to add the direct MIPS32r5 support into the kernel (see
> the specific patch for details). In addition seeing there is more than one
> real chip based on the MIPS P5600 core on the market, it would be good to have
> the direct P5600 CPU config in the MIPS-arch.
> 
> There were some issues we discovered while were working with MIPS-arch code.
> So the cleanups and fixes are introduced in this patchset. First of all the
> Write-Merge CPU feature hasn't been handled in a generic way. Even if a
> platform defined the writecombine flag as _CACHE_UNCACHED_ACCELERATED, the
> feature might have been disabled in the CP0 register. We either enable it or
> leave it as is in accordance with the knowledge of whether the corresponding
> platform really supports it. Secondly Memory Accessibility Attribute Registers
> (MAAR) haven't been properly initialized when Extended Physical Address (XPA)
> mode was enabled. Thirdly since some of the platforms may have a very strict
> limitations on the IO-memory access instructions. For instance Baikal-T1 SoC
> IO-memory can be accessed by the lw/sw instructions only. In this case
> for early-printk and CPS-debug code we suggest to use the instructions in
> accordance with the UART-registers offset (lb/sb if offset = 0, lh/sh
> if offset = 1 and so on). Fourthly in case if CPUFREQ feature is enabled
> and frequency of the CPU is changed by the reference clock alteration, we
> must make sure that MIPS r4k timer related services are properly updated
> when CPU-frequency changes. It concerns udelay lpj adjustment, MIPS timer
> clockevent frequency update. In addition when CPU reference frequency changes
> it isn't recommended to use the timer as clocksource at all, since currently
> the subsystem isn't tolerant to the unstable clock sources. So in this case
> we suggest to use the r4k timer for clocksourcing only as a last resort.
> Fifthly we discovered a bug in a method of CPUFREQ boost feature enable
> procedure and fixed it in one of the patches within this patchset. And finally
> there are a few fixups/cleanups we suggest to integrate into the MIPS FDC
> and CDMM related code (see the patches for details).
> 
> This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> commit 98d54f81e36b ("Linux 5.6-rc4").
> 
> [1] http://www.baikalelectronics.com/products/168/
> 
> P.S. Sorry for the previous emails burst. I forgot to start the series with
> this cover-letter and the corporate smtp broke the transmission in the middle
> anyway. Please don't pay attention to them. Here is the proper emails
> resubmission.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
> Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> cc: Tony Lindgren <tony@atomide.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (22):
>   dt-bindings: Permit platform devices in the trivial-devices bindings
>   dt-bindings: Add MIPS CPC controller as a trivial devices
>   dt-bindings: Add MIPS CDMM controller as a trivial device
>   dt-bindings: Add vendor prefix for Baikal Electronics, JSC
>   mips: cm: Fix an invalid error code of INTVN_*_ERR
>   mips: cm: Add L2 ECC/parity errors reporting
>   mips: Add MIPS32 Release 5 support
>   mips: Add MIPS Warrior P5600 support
>   mips: Fix cpu_has_mips64r1/2 activation for MIPS32 CPUs
>   mips: Add CP0 Write Merge config support
>   mips: Add CONFIG/CONFIG6 reg fields macro
>   mips: MAAR: Use more precise address mask
>   mips: MAAR: Add XPA mode support
>   mips: early_printk_8250: Use offset-sized IO-mem accessors
>   mips: Use offset-sized IO-mem accessors in CPS debug printout
>   mips: cdmm: Add mti,mips-cdmm dtb node support
>   bus: cdmm: Add MIPS R5 arch support
>   tty: mips_ejtag_fdc: Mark expected switch fall-through
>   mips: Add udelay lpj numbers adjustment
>   mips: csrc-r4k: Decrease r4k-clocksource rating if CPU_FREQ enabled
>   mips: cevt-r4k: Update the r4k-clockevent frequency in sync with CPU
>   cpufreq: Return zero on success in boost sw setting
> 
>  .../bindings/power/mti,mips-cpc.txt           |  8 ---
>  .../devicetree/bindings/trivial-devices.yaml  | 12 ++--
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  arch/mips/Kconfig                             | 62 ++++++++++++++--
>  arch/mips/Makefile                            |  2 +
>  arch/mips/include/asm/asmmacro.h              | 18 ++---
>  arch/mips/include/asm/compiler.h              |  5 ++
>  arch/mips/include/asm/cpu-features.h          | 34 ++++++---
>  arch/mips/include/asm/cpu-info.h              |  2 +-
>  arch/mips/include/asm/cpu-type.h              |  6 +-
>  arch/mips/include/asm/cpu.h                   | 11 +--
>  arch/mips/include/asm/fpu.h                   |  4 +-
>  arch/mips/include/asm/hazards.h               |  8 ++-
>  arch/mips/include/asm/maar.h                  | 17 ++++-
>  arch/mips/include/asm/mipsregs.h              | 33 ++++++++-
>  arch/mips/include/asm/module.h                |  4 ++
>  arch/mips/include/asm/stackframe.h            |  2 +-
>  arch/mips/include/asm/switch_to.h             |  8 +--
>  arch/mips/kernel/cevt-r4k.c                   | 44 ++++++++++++
>  arch/mips/kernel/cps-vec-ns16550.S            | 18 ++++-
>  arch/mips/kernel/cpu-probe.c                  | 60 ++++++++++++++++
>  arch/mips/kernel/csrc-r4k.c                   |  4 ++
>  arch/mips/kernel/early_printk_8250.c          | 34 ++++++++-
>  arch/mips/kernel/entry.S                      |  6 +-
>  arch/mips/kernel/mips-cm.c                    | 66 +++++++++++++++--
>  arch/mips/kernel/proc.c                       |  2 +
>  arch/mips/kernel/r4k_fpu.S                    | 14 ++--
>  arch/mips/kernel/spram.c                      |  4 +-
>  arch/mips/kernel/time.c                       | 70 +++++++++++++++++++
>  arch/mips/kvm/vz.c                            |  6 +-
>  arch/mips/lib/csum_partial.S                  |  6 +-
>  arch/mips/mm/c-r4k.c                          |  7 +-
>  arch/mips/mm/init.c                           |  8 ++-
>  arch/mips/mm/sc-mips.c                        |  7 +-
>  drivers/bus/Kconfig                           |  2 +-
>  drivers/bus/mips_cdmm.c                       | 15 ++++
>  drivers/cpufreq/cpufreq.c                     |  2 +-
>  drivers/tty/mips_ejtag_fdc.c                  |  1 +
>  38 files changed, 529 insertions(+), 85 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.txt
> 
> -- 
> 2.25.1
> 

Folks,

It appears our corporate email server changes the Message-Id field of 
messages passing through it. Due to that the emails threading gets to be
broken. I'll resubmit the properly structured v2 patchset as soon as our system
administrator fixes the problem. Sorry for the inconvenience caused by it.

Regards,
-Sergey
