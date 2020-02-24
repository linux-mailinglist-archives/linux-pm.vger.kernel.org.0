Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E80E16B098
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 20:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgBXTvl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 24 Feb 2020 14:51:41 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:49863 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgBXTvl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 14:51:41 -0500
Received: from [192.168.1.183] ([37.4.249.121]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MxUjv-1jMCpG0EVV-00xvGV; Mon, 24 Feb 2020 20:51:31 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
Subject: bcm2835: Firmware transaction timeout caused by pm_test
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-rpi-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Message-ID: <84ce1178-f535-107b-f796-77e5e542ffdc@i2se.com>
Date:   Mon, 24 Feb 2020 20:51:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:f0ZAexjlhNFaXYNzDiIOXy6TGlz1I7KggjqeFhAGQa/FgSOHpsH
 SIjQmezYC73z9cr4+paA0AruZh0vmRuFdtA+eL4JD+nppeCDMWa1fSxxi9rcVGmh0N1K2O9
 feiW1lUFFwSFGeL1wbgKLBpblhQLyJhIO4iYZcri1CZNsXmrNbgpRAY3t8/EUZVxiauuj41
 oFJSmITnyiXHStaUcXzSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cLRVUTvICA4=:jXtOSIao1gKdoJ2QqEqKIA
 GrbzNWPg2R2k4pD/eN56B/hmaD2Z0170qmz3w6qgVPIHtC9lk661oFBBCsX9LCnCm1569zXfb
 9B5WZpAjiwLwiflHNGy6mkeVMlNWK/RrZjUjkwjZwB5bNKpMrtOKLNwwFMStSsD9vx2EaEZL8
 G5NmoQmYlu33AQ806pfTumQfbs/umez/XcOxPTW+F1faKY5u18r45V+z+JTQ28aO7NrMvTZxZ
 HW7Y51Z4sTV0clVQ0rkoUBd8Wr8fBOw0gWhlcvrQPAl4B/ruBz12YT6hiEMVHv6YnUzqV675C
 KVE+mD64TlU51ClkWG5Uzz/sE91VdxhEsT8qjN9wVo+RU1DVVwH/QqSNIUh1gRorTSNMsV6Ix
 qnY5KtwCZeqMai0Bi5BLuPCAm60iuA3s3c3A0u8x2Qpn+k6jtCwSDhJvfkC1Xbqsx8cG78MQB
 /WimEVY9avyaU/37lqIxlYgc/QAgDj6e+9FsmqGRRm+9lDbb0a6NYuHBjjQnbDmOySYxAeADT
 ecdR/JjKVUT/UOOcgWu23AKkz/MKNByjlhO5ahU4nIFtCrQ2b10cmn5lqLKTDskxl6f7lJVI3
 RvvUwLBX14g3VMv7gu8ZZEFNnbWOz68hEV9qs3dCsQY3a5HUg7s2UCwaiqVd+aEjXYtHz7PJg
 UNMNeZDuJ9ufz82dJB/s1XcwYkVT3KnJUvrtQEMFCWdN6Bq43JjfkjaVFhyLJfKiewhdpbXUj
 Q76UZaxUr7FvOxXsXh8n3K/CP08HSSF4cZhd1oqvNSsvXskNpOcQNYOO60gSJ5UNhT7cMpbaG
 rTAr2iQG+1Vt9FalHX0EPK23ovVzk900kw6I8r6Xu4zPp3qdVhOIM884Q/nKm4A0C5tgUeb
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

yesterday i noticed that i'm able to trigger a warning with pm_test on
my Raspberry Pi 3A+ (current linux-next, multi_v7_defconfig +
CONFIG_PM_DEBUG). It seems that the code tries to disable a power domain
while the necessary mailbox / firmware driver is already disabled.

raspberrypi-firmware soc:firmware: Attached to firmware from 2019-03-27
15:45

Steps to reproduce:

echo platform > /sys/power/pm_test
echo freeze > /sys/power/state

Resulting warning:

[  330.955150] ------------[ cut here ]------------
[  330.955178] WARNING: CPU: 0 PID: 732 at
drivers/firmware/raspberrypi.c:60 rpi_firmware_property_list+0x1b0/0x254
[  330.955182] Firmware transaction timeout
[  330.955184] Modules linked in: brcmfmac sha256_generic libsha256
sha256_arm cfg80211 vc4 brcmutil snd_soc_core ac97_bus hci_uart
snd_pcm_dmaengine btbcm snd_pcm bluetooth snd_timer snd ecdh_generic
soundcore ecc crc32_arm_ce raspberrypi_hwmon phy_generic bcm2835_thermal
[  330.955249] CPU: 0 PID: 732 Comm: bash Not tainted
5.6.0-rc2-next-20200220-00003-g85f2ed6-dirty #6
[  330.955253] Hardware name: BCM2835
[  330.955281] [<c03129d4>] (unwind_backtrace) from [<c030cc7c>]
(show_stack+0x10/0x14)
[  330.955296] [<c030cc7c>] (show_stack) from [<c0f08180>]
(dump_stack+0xc0/0xd4)
[  330.955312] [<c0f08180>] (dump_stack) from [<c0347aac>]
(__warn+0xe0/0xf8)
[  330.955327] [<c0347aac>] (__warn) from [<c0347b38>]
(warn_slowpath_fmt+0x74/0xb8)
[  330.955342] [<c0347b38>] (warn_slowpath_fmt) from [<c0d1b3ec>]
(rpi_firmware_property_list+0x1b0/0x254)
[  330.955357] [<c0d1b3ec>] (rpi_firmware_property_list) from
[<c0d1b4f0>] (rpi_firmware_property+0x60/0x8c)
[  330.955372] [<c0d1b4f0>] (rpi_firmware_property) from [<c087ca4c>]
(rpi_domain_off+0x58/0x74)
[  330.955388] [<c087ca4c>] (rpi_domain_off) from [<c09c1fc4>]
(genpd_sync_power_off+0x60/0xf4)
[  330.955403] [<c09c1fc4>] (genpd_sync_power_off) from [<c09c20ec>]
(genpd_finish_suspend+0x94/0x10c)
[  330.955418] [<c09c20ec>] (genpd_finish_suspend) from [<c09bb248>]
(dpm_run_callback+0x58/0x1f4)
[  330.955434] [<c09bb248>] (dpm_run_callback) from [<c09bc16c>]
(__device_suspend_noirq+0xa8/0x298)
[  330.955450] [<c09bc16c>] (__device_suspend_noirq) from [<c09bd5d0>]
(dpm_suspend_noirq+0x114/0x354)
[  330.955466] [<c09bd5d0>] (dpm_suspend_noirq) from [<c0398e54>]
(suspend_devices_and_enter+0x37c/0x98c)
[  330.955479] [<c0398e54>] (suspend_devices_and_enter) from
[<c039979c>] (pm_suspend+0x338/0x460)
[  330.955493] [<c039979c>] (pm_suspend) from [<c0397a4c>]
(state_store+0x6c/0xc8)
[  330.955510] [<c0397a4c>] (state_store) from [<c0526970>]
(kernfs_fop_write+0xf8/0x210)
[  330.955529] [<c0526970>] (kernfs_fop_write) from [<c0497f7c>]
(__vfs_write+0x2c/0x1c4)
[  330.955544] [<c0497f7c>] (__vfs_write) from [<c049ade4>]
(vfs_write+0xa4/0x184)
[  330.955555] [<c049ade4>] (vfs_write) from [<c049b084>]
(ksys_write+0xa4/0xd4)
[  330.955568] [<c049b084>] (ksys_write) from [<c0301000>]
(ret_fast_syscall+0x0/0x54)
[  330.955574] Exception stack(0xd4c13fa8 to 0xd4c13ff0)
[  330.955585] 3fa0:                   00000007 0010aa08 00000001
0010aa08 00000007 00000000
[  330.955597] 3fc0: 00000007 0010aa08 b6e73d50 00000004 00000007
00000004 00000000 000fe77c
[  330.955605] 3fe0: 00000000 bec84904 b 338.198160] done.



