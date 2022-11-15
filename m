Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9848E62A21F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Nov 2022 20:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiKOTo4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Nov 2022 14:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiKOToy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2022 14:44:54 -0500
Received: from mail1.systemli.org (mail1.systemli.org [IPv6:2a11:7980:3::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4625E24BEF
        for <linux-pm@vger.kernel.org>; Tue, 15 Nov 2022 11:44:53 -0800 (PST)
Message-ID: <bf8d2a8f-7654-29be-1104-a842c6657b5e@systemli.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemli.org;
        s=default; t=1668541490;
        bh=8ycYa0l03y2Xy+lTC9umglVnxHlMT3eNSgIFIhpuUdo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Qx9AQKBJMTw172ansrvl8rdCaXJZDz8n1dim4r1ghWqbryDa2A+mdZNpTv4AnTFSH
         VbWDdGoLCPzsaAEYH8LM83yJFw0qwRvlyKkOcNDgZCetKK6TkXkrB+KZnI1Gao34mL
         9LTzpsKtZJTS0wSUUTHocxJBuJuKZz+XP9A6ksIbdQl0ax2mm14JdqfjgxP9lO/jzK
         PpTqUJFib0ElGgN6nnNPdPhsTvYYQ1M6YhKNFtRtiE1zteHegeyBLULOpsqbPgRNMQ
         paGXxwWmo1bzVfOv++XNRCjMVn9r6x5OOOP7peVGTfLw3xRX/pMv9uVks7nYjY1JML
         bomuTrzr4deJQ==
Date:   Tue, 15 Nov 2022 20:44:47 +0100
MIME-Version: 1.0
Subject: Re: Kernel Kernel bug caused by (cpufreq: mediatek: Refine
 mtk_cpufreq_voltage_tracking()) on Banana Pi R64 (MT7622)
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        jia-wei.chang@mediatek.com, rex-bc.chen@mediatek.com,
        angelogioacchino.delregno@collabora.com, viresh.kumar@linaro.org,
        Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?Q?H=c3=bchn=2c_Thomas?= <thomas.huehn@hs-nordhausen.de>
References: <930778a1-5e8b-6df6-3276-42dcdadaf682@systemli.org>
 <eb142a22-b35e-ec3f-ee0a-9e3e7b24cea6@gmail.com>
From:   Nick <vincent@systemli.org>
In-Reply-To: <eb142a22-b35e-ec3f-ee0a-9e3e7b24cea6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,
I used now the linux-next kernel tree (with 
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=327227 so 
single uImage.FIT will work). Same issue:

> [ 0.886209] Kernel BUG at regulator_check_voltage+0xb0/0xf0 [verbose 
> debug info unavailable]
>
> [ 0.894663] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>
> [ 0.900759] Modules linked in:
>
> [ 0.903819] CPU: 1 PID: 79 Comm: kworker/1:1 Tainted: G S 
> 6.1.0-rc5-next-20221115+ #0
>
> [ 0.904360] pstore: Using crash dump compression: deflate
>
> [ 0.913038] Hardware name: Bananapi BPI-R64 (DT)
>
> [ 0.913043] Workqueue: events dbs_work_handler
>
> [ 0.913056] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS 
> BTYPE=--)
>
> [ 0.913063] pc : regulator_check_voltage+0xb0/0xf0
>
> [ 0.913070] lr : regulator_set_voltage_unlocked+0x88/0x110
>
> [ 0.913077] sp : ffffffc00cef3b30
>
> [ 0.913080] x29: ffffffc00cef3b30 x28: ffffff8006f6f800 x27: 
> ffffff8006f6fa00
>
> [ 0.931243] mtk-pcie 1a143000.pcie: host bridge /pcie@1a143000 ranges:
>
> [ 0.934474]
>
> [ 0.934475] x26: 00000000001312d0 x25: 0000000000000024
>
> [ 0.939298] mtk-pcie 1a143000.pcie: Parsing ranges property...
>
> [ 0.944730] x24: 0000000000118c30
>
> [ 0.948038] mtk-pcie 1a143000.pcie: MEM 0x0020000000..0x0027ffffff -> 
> 0x0020000000
>
> [ 0.955155]
>
> [ 0.955157] x23: 0000000000149970 x22: ffffff8000861800 x21: 
> ffffff8006f6f800
>
> [ 0.955166] x20: 00000000001312d0 x19: 0000000000000000 x18: 
> 00000000cfad1bd3
>
> [ 0.955174] x17: 000000000000000c x16: 0000000000000005 x15: 
> 0000000000000000
>
> [ 1.008473] x14: 0000000000000000 x13: 0000000000000165 x12: 
> 0101010101010101
>
> [ 1.015608] x11: 00000000017d7840 x10: 0000000000000850 x9 : 
> ffffffc00cef3900
>
> [ 1.017014] mmc0: new HS200 MMC card at address 0001
>
> [ 1.022740] x8 : ffffff8005ee9f30 x7 : 0000000000000001 x6 : 
> 00000000001312d0
>
> [ 1.022748] x5 : 0000000000118c30 x4 : 0000000000000000 x3 : 
> 0000000000000000
>
> [ 1.022756] x2 : ffffffc00cef3b68 x1 : ffffffc00cef3b6c
>
> [ 1.029034] mmcblk0: mmc0:0001 008G30 7.28 GiB
>
> [ 1.034833] x0 : ffffff8000861800
>
> [ 1.034838] Call trace:
>
> [ 1.044528] Alternate GPT is invalid, using primary GPT.
>
> [ 1.047175] regulator_check_voltage+0xb0/0xf0
>
> [ 1.052603] FIT: Selected configuration: "config-1" (OpenWrt 
> bananapi_bpi-r64)
>
> [ 1.055090] regulator_set_voltage+0x3c/0x64
>
> [ 1.057539] FIT: kernel sub-image 0x00001000..0x005200f9 "kernel-1" 
> (ARM64 OpenWrt Linux-6.1-rc2)
>
> [ 1.062824] mtk_cpufreq_voltage_tracking+0x12c/0x27c
>
> [ 1.062831] mtk_cpufreq_set_target+0x1c4/0x350
>
> [ 1.062837] __cpufreq_driver_target+0x2dc/0x660
>
> [ 1.067289] FIT: flat_dt sub-image 0x00521000..0x005272d9 "fdt-1" 
> (ARM64 OpenWrt bananapi_bpi-r64 device tree blob)
>
> [ 1.074484] od_dbs_update+0xb8/0x19c
>
> [ 1.074490] dbs_work_handler+0x3c/0x7c
>
> [ 1.078774] FIT: filesystem sub-image 0x00528000..0x00829fff 
> "rootfs-1" (ARM64 OpenWrt bananapi_bpi-r64 rootfs)
>
> [ 1.088560] process_one_work+0x200/0x3a0
>
> [ 1.093624] mmcblk0: p1 p2 p3 p4 p65(rootfs-1) p66(rootfs_data) p128
>
> [ 1.098116] worker_thread+0x170/0x4c0
>
> [ 1.104575] mmcblk0boot0: mmc0:0001 008G30 4.00 MiB
>
> [ 1.114009] kthread+0xd4/0xe0
>
> [ 1.114016] ret_from_fork+0x10/0x20
>
> [ 1.114028] Code: 6b04001f 54fffe6b 2a0003e4 17fffff3 (d4210000)
>
> [ 1.114033] ---[ end trace 0000000000000000 ]---
> [ 0.878926] ------------[ cut here ]------------
>

Full log:
https://gist.github.com/PolynomialDivision/4a555079887b288f4795b28eb3607aa9

Big thanks to Daniel helping me to build a vanilla kernel with OpenWrt 
build system.

Bests
Nick

On 11/10/22 12:26, Matthias Brugger wrote:
> Hi Nick,
>
> On 09/11/2022 14:35, Nick wrote:
>> Hi,
>> while trying to bump OpenWrt Kernel to 6.1rc2 I noticed that the 
>> kernel is crashing while booting on a Banana Pi R64 (MT7622):
>>
>>> [    1.055565] ------------[ cut here ]------------
>>> [    1.060204] Kernel BUG at regulator_check_voltage+0xb0/0xf0 
>>> [verbose debug info unavailable]
>>> [    1.062418] mtk-pcie 1a143000.pcie: host bridge /pcie@1a143000 
>>> ranges:
>>> [    1.068656] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>>> [    1.075248] mtk-pcie 1a143000.pcie: Parsing ranges property...
>>> [    1.081257] Modules linked in:
>>> [    1.081264] CPU: 1 PID: 328 Comm: kworker/1:7 Tainted: G 
>>> S                 6.1-rc2 #0
>>> [    1.087088] mtk-pcie 1a143000.pcie:      MEM 
>>> 0x0020000000..0x0027ffffff -> 0x0020000000
>>> [    1.090126] Hardware name: Bananapi BPI-R64 (DT)
>>> [    1.110541] Workqueue: events dbs_work_handler
>>> [    1.114988] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS 
>>> BTYPE=--)
>>> [    1.121944] pc : regulator_check_voltage+0xb0/0xf0
>>> [    1.126728] lr : regulator_set_voltage_unlocked+0x88/0x110
>>> [    1.129638] mmc1: host does not support reading read-only switch, 
>>> assuming write-enable
>>> [    1.132207] sp : ffffffc00956bb30
>>> [    1.132209] x29: ffffffc00956bb30 x28: ffffff8000efb400 x27: 
>>> 0000000000000024
>>> [    1.132219] x26: 00000000001312d0 x25: 0000000000118c30 x24: 
>>> 00000000001312d0
>>> [    1.132227] x23: 0000000000149970
>>> [    1.146036] mmc1: new high speed SDHC card at address e624
>>> [    1.150642]  x22: ffffff800038f800
>>> [    1.159192] mmcblk1: mmc1:e624 SL16G 14.8 GiB
>>> [    1.161068]  x21: ffffff8000efb100
>>> [    1.161072] x20: 00000000001312d0
>>> [    1.175424] GPT:partition_entry_array_crc32 values don't match: 
>>> 0xa0b5ce6d != 0xab54d286
>>> [    1.177757]  x19: 0000000000000000 x18: 00000000799b2550
>>> [    1.181067] GPT:Primary header thinks Alt. header is not at the 
>>> end of the disk.
>>> [    1.189143] x17: 0000000000000003 x16: 0000000000000001 x15: 
>>> 0000000000000000
>>> [    1.189151] x14: 0000000000000000 x13: 0000000000000146 x12: 
>>> 00000000fa83b2da
>>> [    1.189159] x11: 000000000000013d x10: 0000000000000850
>>> [    1.194472] GPT:305184 != 31116287
>>> [    1.201842]  x9 : ffffffc00956b910
>>> [    1.201846] x8 : ffffff8000b9edf0 x7 : 0000000000000001
>>> [    1.208970] GPT:Alternate GPT header not at the end of the disk.
>>> [    1.216092]  x6 : 00000000001312d0
>>> [    1.216095] x5 : 0000000000118c30 x4 : 0000000000000000 x3 : 
>>> 0000000000000000
>>> [    1.216103] x2 : ffffffc00956bb68 x1 : ffffffc00956bb6c
>>> [    1.221321] GPT:305184 != 31116287
>>> [    1.224706]  x0 : ffffff800038f800
>>> [    1.228095] GPT: Use GNU Parted to correct GPT errors.
>>> [    1.233307]
>>> [    1.233309] Call trace:
>>> [    1.233312]  regulator_check_voltage+0xb0/0xf0
>>> [    1.242680] FIT: Selected configuration: 
>>> "config-mt7622-bananapi-bpi-r64-pcie1" (OpenWrt bananapi_bpi-r64 
>>> with mt7622-bananapi-bpi-r64-pcie1)
>>> [    1.242694]  regulator_set_voltage+0x3c/0x64
>>> [    1.249831] FIT:           kernel sub-image 
>>> 0x00001000..0x0052fd0a "kernel-1" (ARM64 OpenWrt Linux-6.1-rc2)
>>> [    1.255030]  mtk_cpufreq_voltage_tracking+0x11c/0x26c
>>> [    1.255039]  mtk_cpufreq_set_target+0x1c4/0x350
>>> [    1.258444] FIT:          flat_dt sub-image 
>>> 0x00530000..0x005380c5 "fdt-1" (ARM64 OpenWrt bananapi_bpi-r64 
>>> device tree blob)
>>> [    1.261820]  __cpufreq_driver_target+0x2f4/0x674
>>> [    1.261826]  od_dbs_update+0xb8/0x19c
>>> [    1.266969] FIT:          flat_dt sub-image 
>>> 0x00539000..0x0053911a "fdt-mt7622-bananapi-bpi-r64-pcie1" (ARM64 
>>> OpenWrt bananapi_bpi-r64 device tree overlay 
>>> mt7622-bananapi-bpi-r64-pcie1)
>>> [    1.268431]  dbs_work_handler+0x3c/0x7c
>>> [    1.270883] FIT:          flat_dt sub-image 
>>> 0x0053a000..0x0053a20f "fdt-mt7622-bananapi-bpi-r64-sata" (ARM64 
>>> OpenWrt bananapi_bpi-r64 device tree overlay 
>>> mt7622-bananapi-bpi-r64-sata)
>>> [    1.275297]  process_one_work+0x200/0x3a0
>>> [    1.287998] FIT:       filesystem sub-image 
>>> 0x0053b000..0x00859fff "rootfs-1" (ARM64 OpenWrt bananapi_bpi-r64 
>>> rootfs)
>>> [    1.292237]  worker_thread+0x170/0x4c0
>>> [    1.292244]  kthread+0xd4/0xe0
>>> [    1.302066] FIT: selecting configured loadable "rootfs-1" to be 
>>> root filesystem
>>> [    1.307092]  ret_from_fork+0x10/0x20
>>> [    1.311631]  mmcblk1: p1 p2 p3 p4 p5 p6 p65(rootfs-1) 
>>> p66(rootfs_data) p128
>>> [    1.322903] Code: 6b04001f 54fffe6b 2a0003e4 17fffff3 (d4210000)
>>> [    1.413322] ---[ end trace 0000000000000000 ]---
>> The complete log can be found here:
>> https://gist.githubusercontent.com/PolynomialDivision/395d009c84b426d780549c5fa1f64ff1/raw/886d621d2bf6f03429586adf8a14a6c37c8d8a7d/mt7622-6-1.log 
>>
>>
>> Reverting commit "cpufreq: mediatek: Refine 
>> mtk_cpufreq_voltage_tracking()" fixes the kernel bug:
>> https://github.com/torvalds/linux/commit/6a17b3876bc8303612d7ad59ecf7cbc0db418bcd 
>>
>>
>> The revert commit can be found here:
>> https://github.com/PolynomialDivision/openwrt/commit/1df941d0334000e3aced43b7d50cdac0da8bf427 
>>
>>
>> The branch I use to build the 6.1rc2 on a Banana Pi R64 can be found 
>> here:
>> https://github.com/PolynomialDivision/openwrt/commits/bump-mt7622-rebase
>>
>
> Thanks for the report.
> Could you test with a plain upstream kernel? That would help us to 
> verify that this is a upstream problem and not introduced by some 
> openwrt patches.
>
> Regards,
> Matthias
