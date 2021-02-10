Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C31316B25
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 17:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhBJQ0i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 11:26:38 -0500
Received: from foss.arm.com ([217.140.110.172]:40342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232049AbhBJQ0h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 11:26:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B42D311D4;
        Wed, 10 Feb 2021 08:25:50 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22A6E3F73B;
        Wed, 10 Feb 2021 08:25:49 -0800 (PST)
Subject: Re: bcm2711_thermal: Kernel panic - not syncing: Asynchronous SError
 Interrupt
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        stefan.wahren@i2se.com, Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.con>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20210210114829.2915de78@gollum>
 <6d9ca41b4ad2225db102da654d38bc61f6c1c111.camel@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <35e17dc9-c88d-582f-607d-1d90b20868fa@arm.com>
Date:   Wed, 10 Feb 2021 16:25:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <6d9ca41b4ad2225db102da654d38bc61f6c1c111.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-02-10 13:15, Nicolas Saenz Julienne wrote:
> [ Add Robin, Catalin and Florian in case they want to chime in ]
> 
> Hi Juerg, thanks for the report!
> 
> On Wed, 2021-02-10 at 11:48 +0100, Juerg Haefliger wrote:
>> Trying to dump the BCM2711 registers kills the kernel:
>>
>> # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/range
>> 0-efc
>> # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/registers
>>
>> [   62.857661] SError Interrupt on CPU1, code 0xbf000002 -- SError
> 
> So ESR's IDS (bit 24) is set, which means it's an 'Implementation Defined
> SError,' hence IIUC the rest of the error code is meaningless to anyone outside
> of Broadcom/RPi.

It's imp-def from the architecture's PoV, but the implementation in this 
case is Cortex-A72, where 0x000002 means an attributable, containable 
Slave Error:

https://developer.arm.com/documentation/100095/0003/system-control/aarch64-register-descriptions/exception-syndrome-register--el1-and-el3?lang=en

In other words, the thing at the other end of an interconnect 
transaction said "no" :)

(The fact that Cortex-A72 gets too far ahead of itself to take it as a 
synchronous external abort is a mild annoyance, but hey...)

> The regmap is created through the following syscon device:
> 
> 	avs_monitor: avs-monitor@7d5d2000 {
> 		compatible = "brcm,bcm2711-avs-monitor",
> 			     "syscon", "simple-mfd";
> 		reg = <0x7d5d2000 0xf00>;
> 
> 		thermal: thermal {
> 			compatible = "brcm,bcm2711-thermal";
> 			#thermal-sensor-cells = <0>;
> 		};
> 	};
> 
> I've done some tests with devmem, and the whole <0x7d5d2000 0xf00> range is
> full of addresses that trigger this same error. Also note that as per Florian's
> comments[1]: "AVS_RO_REGISTERS_0: 0x7d5d2200 - 0x7d5d22e3." But from what I can
> tell, at least 0x7d5d22b0 seems to be faulty too.
> 
> Any ideas/comments? My guess is that those addresses are marked somehow as
> secure, and only for VC4 to access (VC4 is RPi4's co-processor). Ultimately,
> the solution is to narrow the register range exposed by avs-monitor to whatever
> bcm2711-thermal needs (which is ATM a single 32bit register).

When a peripheral decodes a region of address space, nobody says it has 
to accept accesses to *every* address in that space; registers may be 
sparsely populated, and although some devices might be "nice" and make 
unused areas behave as RAZ/WI, others may throw slave errors if you poke 
at the wrong places. As you note, in a TrustZone-aware device some 
registers may only exist in one or other of the Secure/Non-Secure 
address spaces.

Even when there is a defined register at a given address, it still 
doesn't necessarily accept all possible types of access; it wouldn't be 
particularly friendly, but a device *could* have, say, some registers 
that support 32-bit accesses and others that only support 16-bit 
accesses, and thus throw slave errors if you do the wrong thing in the 
wrong place.

It really all depends on the device itself.

Robin.

> 
> Regards,
> Nicolas
> 
> [1] https://lore.kernel.org/linux-pm/82125042-684a-b4e2-fbaa-45a393b2ce5e@gmx.net/
> 
>> [   62.857671] CPU: 1 PID: 478 Comm: cat Not tainted 5.11.0-rc7 #4
>> [   62.857674] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
>> [   62.857676] pstate: 20000085 (nzCv daIf -PAN -UAO -TCO BTYPE=--)
>> [   62.857679] pc : regmap_mmio_read32le+0x1c/0x34
>> [   62.857681] lr : regmap_mmio_read+0x50/0x80
>> [   62.857682] sp : ffff8000105c3c00
>> [   62.857685] x29: ffff8000105c3c00 x28: 0000000000000014
>> [   62.857694] x27: 0000000000000014 x26: ffffd2ea1c2060b0
>> [   62.857699] x25: ffff4e34408ecc00 x24: 0000000000000efc
>> [   62.857704] x23: ffff8000105c3e20 x22: ffff8000105c3d3c
>> [   62.857710] x21: ffff8000105c3d3c x20: 0000000000000014
>> [   62.857715] x19: ffff4e344037a900 x18: 0000000000000020
>> [   62.857720] x17: 0000000000000000 x16: 0000000000000000
>> [   62.857725] x15: ffff4e3447ac40f0 x14: 0000000000000003
>> [   62.857730] x13: ffff4e34422c0000 x12: ffff4e34422a0046
>> [   62.857735] x11: ffffd2ea1c8765e0 x10: 0000000000000000
>> [   62.857741] x9 : ffffd2ea1b9495a0 x8 : ffff4e34429ef980
>> [   62.857746] x7 : 000000000000000f x6 : ffff4e34422a004b
>> [   62.857751] x5 : 00000000fffffff9 x4 : 0000000000000000
>> [   62.857757] x3 : ffffd2ea1b949550 x2 : ffffd2ea1b949330
>> [   62.857761] x1 : 0000000000000014 x0 : 0000000000000000
>> [   62.857767] Kernel panic - not syncing: Asynchronous SError Interrupt
>> [   62.857770] CPU: 1 PID: 478 Comm: cat Not tainted 5.11.0-rc7 #4
>> [   62.857773] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
>> [   62.857775] Call trace:
>> [   62.857777]  dump_backtrace+0x0/0x1e0
>> [   62.857778]  show_stack+0x24/0x70
>> [   62.857780]  dump_stack+0xd0/0x12c
>> [   62.857782]  panic+0x168/0x370
>> [   62.857783]  nmi_panic+0x98/0xa0
>> [   62.857786]  arm64_serror_panic+0x8c/0x98
>> [   62.857787]  do_serror+0x3c/0x6c
>> [   62.857789]  el1_error+0x78/0xf0
>> [   62.857791]  regmap_mmio_read32le+0x1c/0x34
>> [   62.857793]  _regmap_bus_reg_read+0x24/0x30
>> [   62.857795]  _regmap_read+0x6c/0x17c
>> [   62.857797]  regmap_read+0x58/0x84
>> [   62.857799]  regmap_read_debugfs+0x138/0x3f4
>> [   62.857801]  regmap_map_read_file+0x34/0x40
>> [   62.857803]  full_proxy_read+0x6c/0xc0
>> [   62.857805]  vfs_read+0xb8/0x1e4
>> [   62.857807]  ksys_read+0x78/0x10c
>> [   62.857809]  __arm64_sys_read+0x28/0x34
>> [   62.857811]  el0_svc_common.constprop.0+0x7c/0x194
>> [   62.857813]  do_el0_svc+0x30/0x9c
>> [   62.857814]  el0_svc+0x20/0x30
>> [   62.857816]  el0_sync_handler+0x1a4/0x1b0
>> [   62.857818]  el0_sync+0x174/0x180
>> [   62.857842] SMP: stopping secondary CPUs
>> [   62.857845] Kernel Offset: 0x52ea0b080000 from 0xffff800010000000
>> [   62.857847] PHYS_OFFSET: 0xffffb1cc00000000
>> [   62.857849] CPU features: 0x00240022,61806000
>> [   62.857851] Memory Limit: none
>>
>> Sprinkling printks around regmap_read [1] shows that reading from 0x14 (20)
>> seems to cause the issue:
>>
>>
>> [   40.456230] map=ffff020a069c9c00, from=0, to=3836, count=131072
>> [   40.462520] map=ffff020a069c9c00, i=0
>> [   40.466319] ret=0, val=0
>> [   40.468922] map=ffff020a069c9c00, i=4
>> [   40.472684] ret=0, val=0
>> [   40.475292] map=ffff020a069c9c00, i=8
>> [   40.479048] ret=0, val=0
>> [   40.481649] map=ffff020a069c9c00, i=12
>> [   40.485492] ret=0, val=0
>> [   40.488080] map=ffff020a069c9c00, i=16
>> [   40.491922] ret=0, val=0
>> [   40.494523] map=ffff020a069c9c00, i=20
>> [   40.498497] SError Interrupt on CPU0, code 0xbf000002 -- SError
>> [   40.498499] CPU: 0 PID: 486 Comm: cat Not tainted 5.11.0-rc7+ #8
>> [   40.498501] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
>>
>>
>> ...Juerg
>>
>> [1]
>> diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
>> index ff2ee87987c7..9465f5a2f3b8 100644
>> --- a/drivers/base/regmap/regmap-debugfs.c
>> +++ b/drivers/base/regmap/regmap-debugfs.c
>> @@ -229,6 +229,7 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
>>          if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
>>                  count = PAGE_SIZE << (MAX_ORDER - 1);
>>   
>>
>> +       printk("map=%px, from=%d, to=%d, count=%ld\n", map, from, to, count);
>>          buf = kmalloc(count, GFP_KERNEL);
>>          if (!buf)
>>                  return -ENOMEM;
>> @@ -253,7 +254,9 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
>>                          buf_pos += map->debugfs_reg_len + 2;
>>   
>>
>>                          /* Format the value, write all X if we can't read */
>> +                       printk("map=%px, i=%d\n", map, i);
>>                          ret = regmap_read(map, i, &val);
>> +                       printk("ret=%ld, val=%x\n", ret, val);
>>                          if (ret == 0)
>>                                  snprintf(buf + buf_pos, count - buf_pos,
>>                                           "%.*x", map->debugfs_val_len, val);
>>
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
