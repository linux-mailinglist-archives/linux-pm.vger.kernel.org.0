Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173951C7833
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 19:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgEFRnX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 13:43:23 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60612 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgEFRnW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 13:43:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 93202803087C;
        Wed,  6 May 2020 17:43:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y-d5bjsb_mTp; Wed,  6 May 2020 20:43:11 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <linux-mips@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/20] mips: Prepare MIPS-arch code for Baikal-T1 SoC support
Date:   Wed, 6 May 2020 20:42:18 +0300
Message-ID: <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Serge Semin <fancer.lancer@gmail.com>

This is a first patchset of a series of about 25 ones, which are intended to
add the full Baikal-T1 SoC [1] support to the Linux kernel. Since they will
concern various kernel subsystems, I decided to split the whole work up into
the patchesets in accordance with the subsystems/devices their changes are
introduced for. Nearly 2/3 of the work is already done and will be sent out
very soon. While the rest of the changes specifically related to the fast-speed
interfaces (DW 12G PHY, PCIe, SATA, xGBE, GMAC, USB, DDRC, IC) are still in
refactoring and preparation for integration into the mainline kernel. Hopefully
I'll finish them up in the next two-three months, and submit them straight
away.

Getting back to this patchset. As the subject states this is intended to
prepare the MIPS-arch and generic kernel code for further Baikal-T1 SoC
platform support integration (note the Baikal-T1 SoC platform code will be
submitted last after the whole series of patchsets as a closure of the
submission process). First of all the patchset starts with a set of changes
to the dt-bindings kernel concerning MIPS CPC and CDMM nodes to make them
being represented by dt schemas. In addition we updated the vendors prefix
schema with Baikal Electronics JSC prefix so being further committed
vendor-specific device drivers would be correctly accepted by the
checkpatch script.

While I was working with the MIPS architecture code, I discovered, that there
is a bug in the Coherency Manager v2 error causes declaration and the errors
handler lacked of CM2 L2 ECC/parity errors support. So the fixes are here in
the patchset.

Baikal-T1 SoC is based on the MIPS P5600 Warrior IP-core, which itself has
MIPS32 Release 5 architecture. Even though on ISA level it doesn't differ much
from the MIPS32 Release 2 release, there are still some peculiarities, which
make it's justified to add the direct MIPS32r5 support into the kernel (see
the specific patch for details). In addition seeing there is more than one
real chip based on the MIPS P5600 core on the market, it would be good to have
the direct P5600 CPU config in the MIPS-arch.

There were some issues we discovered while were working with MIPS-arch code.
So the cleanups and fixes are introduced in this patchset. First of all the
Write-Merge CPU feature hasn't been handled in a generic way. Even if a
platform defined the writecombine flag as _CACHE_UNCACHED_ACCELERATED, the
feature might have been disabled in the CP0 register. We either enable it or
leave it as is in accordance with the knowledge of whether the corresponding
platform really supports it. Secondly Memory Accessibility Attribute Registers
(MAAR) haven't been properly initialized when Extended Physical Address (XPA)
mode was enabled. Thirdly since some of the platforms may have a very strict
limitations on the IO-memory access instructions. For instance Baikal-T1 SoC
IO-memory can be accessed by the lw/sw instructions only. In this case
for early-printk and CPS-debug code we suggest to use the instructions in
accordance with the UART-registers offset (lb/sb if offset = 0, lh/sh
if offset = 1 and so on). Fourthly in case if CPUFREQ feature is enabled
and frequency of the CPU is changed by the reference clock alteration, we
must make sure that MIPS r4k timer related services are properly updated
when CPU-frequency changes. It concerns udelay lpj adjustment, MIPS timer
clockevent frequency update. In addition when CPU reference frequency changes
it isn't recommended to use the timer as clocksource at all, since currently
the subsystem isn't tolerant to the unstable clock sources. So in this case
we suggest to use the r4k timer for clocksourcing only as a last resort.
Fifthly we discovered a bug in a method of CPUFREQ boost feature enable
procedure and fixed it in one of the patches within this patchset. And finally
there are a few fixups/cleanups we suggest to integrate into the MIPS FDC
and CDMM related code (see the patches for details).

This patchset is rebased and tested on the mainline Linux kernel 5.7-rc4:
0e698dfa2822 ("Linux 5.7-rc4")
tag: v5.7-rc4

[1] http://www.baikalelectronics.com/products/168/

Changelog v2:
- Replace "be" vendor prefix with "baikal" one.
- Remove patches adding the platform devices to the trivial-devices.yaml
  bindings file (Rob nacked it).
- Add yaml-based bindings file for MIPS CDMM dt-node.
- Convert mti,mips-cpc to DT schema.
- Use a shorter summary describing the bindings modification patches.
- Rearrange the SoBs with adding Alexey' co-development tag.
- Lowercase the hex numbers in the dt-bindings.
- Fix author and SoB emails mismatch in the patch of adding the Baikal
  Electronis JSC prefix to the dt schema of the prefixes.
- Remove patch "tty: mips_ejtag_fdc: Mark expected switch fall-through" from
  the patchset as being already applied to the Greg' tty-next branch.
- Our corporate email server doesn't change Message-Id anymore, so the patchset
  is resubmitted being in the cover-letter-threaded format.

Co-developed-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
Cc: Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (20):
  dt-bindings: power: Convert mti,mips-cpc to DT schema
  dt-bindings: bus: Add MIPS CDMM controller
  dt-bindings: Add vendor prefix for Baikal Electronics, JSC
  mips: cm: Fix an invalid error code of INTVN_*_ERR
  mips: cm: Add L2 ECC/parity errors reporting
  mips: Add MIPS32 Release 5 support
  mips: Add MIPS Warrior P5600 support
  mips: Fix cpu_has_mips64r1/2 activation for MIPS32 CPUs
  mips: Add CP0 Write Merge config support
  mips: Add CONFIG/CONFIG6/Cause reg fields macro
  mips: MAAR: Use more precise address mask
  mips: MAAR: Add XPA mode support
  mips: early_printk_8250: Use offset-sized IO-mem accessors
  mips: Use offset-sized IO-mem accessors in CPS debug printout
  mips: cdmm: Add mti,mips-cdmm dtb node support
  bus: cdmm: Add MIPS R5 arch support
  mips: Add udelay lpj numbers adjustment
  mips: csrc-r4k: Decrease r4k-clocksource rating if CPU_FREQ enabled
  mips: cevt-r4k: Update the r4k-clockevent frequency in sync with CPU
  cpufreq: Return zero on success in boost sw setting

 .../bindings/bus/mti,mips-cdmm.yaml           | 35 ++++++++++
 .../bindings/power/mti,mips-cpc.txt           |  8 ---
 .../bindings/power/mti,mips-cpc.yaml          | 35 ++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/mips/Kconfig                             | 62 ++++++++++++++--
 arch/mips/Makefile                            |  2 +
 arch/mips/include/asm/asmmacro.h              | 18 ++---
 arch/mips/include/asm/compiler.h              |  5 ++
 arch/mips/include/asm/cpu-features.h          | 34 ++++++---
 arch/mips/include/asm/cpu-info.h              |  2 +-
 arch/mips/include/asm/cpu-type.h              |  6 +-
 arch/mips/include/asm/cpu.h                   | 11 +--
 arch/mips/include/asm/fpu.h                   |  4 +-
 arch/mips/include/asm/hazards.h               |  8 ++-
 arch/mips/include/asm/maar.h                  | 17 ++++-
 arch/mips/include/asm/mipsregs.h              | 34 ++++++++-
 arch/mips/include/asm/stackframe.h            |  2 +-
 arch/mips/include/asm/switch_to.h             |  8 +--
 arch/mips/include/asm/vermagic.h              |  4 ++
 arch/mips/kernel/cevt-r4k.c                   | 44 ++++++++++++
 arch/mips/kernel/cps-vec-ns16550.S            | 18 ++++-
 arch/mips/kernel/cpu-probe.c                  | 60 ++++++++++++++++
 arch/mips/kernel/csrc-r4k.c                   |  4 ++
 arch/mips/kernel/early_printk_8250.c          | 34 ++++++++-
 arch/mips/kernel/entry.S                      |  6 +-
 arch/mips/kernel/mips-cm.c                    | 66 +++++++++++++++--
 arch/mips/kernel/proc.c                       |  2 +
 arch/mips/kernel/r4k_fpu.S                    | 14 ++--
 arch/mips/kernel/spram.c                      |  4 +-
 arch/mips/kernel/time.c                       | 70 +++++++++++++++++++
 arch/mips/kvm/vz.c                            |  6 +-
 arch/mips/lib/csum_partial.S                  |  6 +-
 arch/mips/mm/c-r4k.c                          |  7 +-
 arch/mips/mm/init.c                           |  8 ++-
 arch/mips/mm/sc-mips.c                        |  7 +-
 drivers/bus/Kconfig                           |  2 +-
 drivers/bus/mips_cdmm.c                       | 15 ++++
 drivers/cpufreq/cpufreq.c                     |  2 +-
 38 files changed, 591 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/mti,mips-cdmm.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.txt
 create mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.yaml

-- 
2.25.1

