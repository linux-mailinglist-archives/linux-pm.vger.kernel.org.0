Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A378624157
	for <lists+linux-pm@lfdr.de>; Thu, 10 Nov 2022 12:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiKJL01 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Nov 2022 06:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJL00 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2022 06:26:26 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E234F701B1
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2022 03:26:24 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l14so1818748wrw.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2022 03:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFjEQ6EjyEVKgcohCb8YrONslLnRgxrTvxjujhEUG08=;
        b=RqWifMivrB4Nu65E05zf0OiBOHmIf5+MDeA2BYi94cKRaxk+eNPRX9wG+VgdpYqVpd
         WvOpTOxACh4uOcMRVBRtW3Hw0Cv3DZomZbichRFA81HNi+lOW5rOoS6FmmXKjI65WEF8
         obN4NlGnbi1GmSpwi+EbrhY4KqzOwGbpEISUIb1ziMq2ftQmMGYpp4ihfA/pPMLXOYzc
         DdOBFgDNJKgSXyLicW07PSdAKkXtCT78A7cPbJQAi6CYNT6JSRZKQ/dBJJ3G/QEZ8sxR
         ZlofILIhtzLYFQBL1nZh1u9RO8tltkqw1Xqov/STYBKYuVwCa95WEi1L2bEya1hJGKGG
         yfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFjEQ6EjyEVKgcohCb8YrONslLnRgxrTvxjujhEUG08=;
        b=Nil6jX+CFYdF4ZjEAU4tuf5tweAj8oMAWVk3m+k1SB42zYIM9ip28n6uQFQQc2homI
         A3w4WVSEirZIIij5o6Be7w7B2jvx+yzCvNg0LNdSl19xkJ54N4gtSVo++vMHPZ0z+T+b
         yKpSGRQpfNUmJTqLcw3EbqYd7X9LoazY1sniclvYWhfkn5SPR/D84E93FhWCYSix4Qw8
         fFXcG8a057bwBu5uQGoeVhD1WNjTQeR2/J/DI3FhI72XUUD/GPdP2/bp8Vf2TwqmNDLG
         IYitW6HKguzsyU1/s4KU9efu6uldbL+SaHhh29n+1gVK0gaRiDkCKnyiVyZm9Hc0zBL2
         mbxw==
X-Gm-Message-State: ACrzQf0j/U+W1c6I4bxk9ZxGzbLee8xDGMSXf1aJvU3w8fTW7Lsm8S/U
        5SA6JVjVjxK2n8hcS2GnK0I=
X-Google-Smtp-Source: AMsMyM493GRRAlRZKKd5q3v49N1Ze10nEaUPhQRBKPHaIoQSYJObJjFz67UxgNoLNZSPumACb6Rn3g==
X-Received: by 2002:adf:f687:0:b0:236:481f:83a6 with SMTP id v7-20020adff687000000b00236481f83a6mr41804672wrp.342.1668079583165;
        Thu, 10 Nov 2022 03:26:23 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j15-20020a056000124f00b00236740c6e6fsm15738858wrx.100.2022.11.10.03.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 03:26:21 -0800 (PST)
Message-ID: <eb142a22-b35e-ec3f-ee0a-9e3e7b24cea6@gmail.com>
Date:   Thu, 10 Nov 2022 12:26:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Kernel Kernel bug caused by (cpufreq: mediatek: Refine
 mtk_cpufreq_voltage_tracking()) on Banana Pi R64 (MT7622)
Content-Language: en-US
To:     Nick <vincent@systemli.org>, jia-wei.chang@mediatek.com,
        rex-bc.chen@mediatek.com, angelogioacchino.delregno@collabora.com,
        viresh.kumar@linaro.org, Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?Q?H=c3=bchn=2c_Thomas?= <thomas.huehn@hs-nordhausen.de>
References: <930778a1-5e8b-6df6-3276-42dcdadaf682@systemli.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <930778a1-5e8b-6df6-3276-42dcdadaf682@systemli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Nick,

On 09/11/2022 14:35, Nick wrote:
> Hi,
> while trying to bump OpenWrt Kernel to 6.1rc2 I noticed that the kernel is 
> crashing while booting on a Banana Pi R64 (MT7622):
> 
>> [    1.055565] ------------[ cut here ]------------
>> [    1.060204] Kernel BUG at regulator_check_voltage+0xb0/0xf0 [verbose debug 
>> info unavailable]
>> [    1.062418] mtk-pcie 1a143000.pcie: host bridge /pcie@1a143000 ranges:
>> [    1.068656] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>> [    1.075248] mtk-pcie 1a143000.pcie: Parsing ranges property...
>> [    1.081257] Modules linked in:
>> [    1.081264] CPU: 1 PID: 328 Comm: kworker/1:7 Tainted: G S                 
>> 6.1-rc2 #0
>> [    1.087088] mtk-pcie 1a143000.pcie:      MEM 0x0020000000..0x0027ffffff -> 
>> 0x0020000000
>> [    1.090126] Hardware name: Bananapi BPI-R64 (DT)
>> [    1.110541] Workqueue: events dbs_work_handler
>> [    1.114988] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [    1.121944] pc : regulator_check_voltage+0xb0/0xf0
>> [    1.126728] lr : regulator_set_voltage_unlocked+0x88/0x110
>> [    1.129638] mmc1: host does not support reading read-only switch, assuming 
>> write-enable
>> [    1.132207] sp : ffffffc00956bb30
>> [    1.132209] x29: ffffffc00956bb30 x28: ffffff8000efb400 x27: 0000000000000024
>> [    1.132219] x26: 00000000001312d0 x25: 0000000000118c30 x24: 00000000001312d0
>> [    1.132227] x23: 0000000000149970
>> [    1.146036] mmc1: new high speed SDHC card at address e624
>> [    1.150642]  x22: ffffff800038f800
>> [    1.159192] mmcblk1: mmc1:e624 SL16G 14.8 GiB
>> [    1.161068]  x21: ffffff8000efb100
>> [    1.161072] x20: 00000000001312d0
>> [    1.175424] GPT:partition_entry_array_crc32 values don't match: 0xa0b5ce6d 
>> != 0xab54d286
>> [    1.177757]  x19: 0000000000000000 x18: 00000000799b2550
>> [    1.181067] GPT:Primary header thinks Alt. header is not at the end of the 
>> disk.
>> [    1.189143] x17: 0000000000000003 x16: 0000000000000001 x15: 0000000000000000
>> [    1.189151] x14: 0000000000000000 x13: 0000000000000146 x12: 00000000fa83b2da
>> [    1.189159] x11: 000000000000013d x10: 0000000000000850
>> [    1.194472] GPT:305184 != 31116287
>> [    1.201842]  x9 : ffffffc00956b910
>> [    1.201846] x8 : ffffff8000b9edf0 x7 : 0000000000000001
>> [    1.208970] GPT:Alternate GPT header not at the end of the disk.
>> [    1.216092]  x6 : 00000000001312d0
>> [    1.216095] x5 : 0000000000118c30 x4 : 0000000000000000 x3 : 0000000000000000
>> [    1.216103] x2 : ffffffc00956bb68 x1 : ffffffc00956bb6c
>> [    1.221321] GPT:305184 != 31116287
>> [    1.224706]  x0 : ffffff800038f800
>> [    1.228095] GPT: Use GNU Parted to correct GPT errors.
>> [    1.233307]
>> [    1.233309] Call trace:
>> [    1.233312]  regulator_check_voltage+0xb0/0xf0
>> [    1.242680] FIT: Selected configuration: 
>> "config-mt7622-bananapi-bpi-r64-pcie1" (OpenWrt bananapi_bpi-r64 with 
>> mt7622-bananapi-bpi-r64-pcie1)
>> [    1.242694]  regulator_set_voltage+0x3c/0x64
>> [    1.249831] FIT:           kernel sub-image 0x00001000..0x0052fd0a 
>> "kernel-1" (ARM64 OpenWrt Linux-6.1-rc2)
>> [    1.255030]  mtk_cpufreq_voltage_tracking+0x11c/0x26c
>> [    1.255039]  mtk_cpufreq_set_target+0x1c4/0x350
>> [    1.258444] FIT:          flat_dt sub-image 0x00530000..0x005380c5 "fdt-1" 
>> (ARM64 OpenWrt bananapi_bpi-r64 device tree blob)
>> [    1.261820]  __cpufreq_driver_target+0x2f4/0x674
>> [    1.261826]  od_dbs_update+0xb8/0x19c
>> [    1.266969] FIT:          flat_dt sub-image 0x00539000..0x0053911a 
>> "fdt-mt7622-bananapi-bpi-r64-pcie1" (ARM64 OpenWrt bananapi_bpi-r64 device 
>> tree overlay mt7622-bananapi-bpi-r64-pcie1)
>> [    1.268431]  dbs_work_handler+0x3c/0x7c
>> [    1.270883] FIT:          flat_dt sub-image 0x0053a000..0x0053a20f 
>> "fdt-mt7622-bananapi-bpi-r64-sata" (ARM64 OpenWrt bananapi_bpi-r64 device tree 
>> overlay mt7622-bananapi-bpi-r64-sata)
>> [    1.275297]  process_one_work+0x200/0x3a0
>> [    1.287998] FIT:       filesystem sub-image 0x0053b000..0x00859fff 
>> "rootfs-1" (ARM64 OpenWrt bananapi_bpi-r64 rootfs)
>> [    1.292237]  worker_thread+0x170/0x4c0
>> [    1.292244]  kthread+0xd4/0xe0
>> [    1.302066] FIT: selecting configured loadable "rootfs-1" to be root 
>> filesystem
>> [    1.307092]  ret_from_fork+0x10/0x20
>> [    1.311631]  mmcblk1: p1 p2 p3 p4 p5 p6 p65(rootfs-1) p66(rootfs_data) p128
>> [    1.322903] Code: 6b04001f 54fffe6b 2a0003e4 17fffff3 (d4210000)
>> [    1.413322] ---[ end trace 0000000000000000 ]---
> The complete log can be found here:
> https://gist.githubusercontent.com/PolynomialDivision/395d009c84b426d780549c5fa1f64ff1/raw/886d621d2bf6f03429586adf8a14a6c37c8d8a7d/mt7622-6-1.log
> 
> Reverting commit "cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()" 
> fixes the kernel bug:
> https://github.com/torvalds/linux/commit/6a17b3876bc8303612d7ad59ecf7cbc0db418bcd
> 
> The revert commit can be found here:
> https://github.com/PolynomialDivision/openwrt/commit/1df941d0334000e3aced43b7d50cdac0da8bf427
> 
> The branch I use to build the 6.1rc2 on a Banana Pi R64 can be found here:
> https://github.com/PolynomialDivision/openwrt/commits/bump-mt7622-rebase
> 

Thanks for the report.
Could you test with a plain upstream kernel? That would help us to verify that 
this is a upstream problem and not introduced by some openwrt patches.

Regards,
Matthias
