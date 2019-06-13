Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D1344629
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 18:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfFMQtb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 13 Jun 2019 12:49:31 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:56337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbfFMEcW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 00:32:22 -0400
Received: from [192.168.1.162] ([37.4.249.160]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MZl1l-1i7PGS1Jwd-00WmSh; Thu, 13 Jun 2019 06:31:59 +0200
Subject: Re: [PATCH v4 0/7] cpufreq support for Raspberry Pi
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org
References: <20190612182500.4097-1-nsaenzjulienne@suse.de>
 <6a9e1450-80ad-a13c-59d2-d0b39f25f67e@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <7acfd967-0a82-5429-4eed-8b802e6620f5@i2se.com>
Date:   Thu, 13 Jun 2019 06:31:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6a9e1450-80ad-a13c-59d2-d0b39f25f67e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:JVQIgpWCtEazzL5rYiYN0IJEAR5Tb9mY8miRG4xc6XNEwCRWInY
 TBwHbJFIaEUrGyLOdt+lXcrTaziNHMDMs64ofG55owRH1Hd/pEOrQrkqoSTEKiQjrw3qqMT
 PGjkYDSvB+3PNpnSt/fsfWOKgiKhM8yfyq8E4iBNUJab5rhepnrj4VioMJI95IQYvgQsocg
 ukaDas5WPpS6ZzzEt5xgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qTId+nsNh3Q=:i8CAXhIIDdMqRAoBpJ9bt2
 ElRxq5FvcgqdFuSs46Gehl0C5YDmpEC4nUw0cXizSVc+cWPR4aDgNyt5MPdUasAcqCukaufE0
 A7rpfAf14PYX14/UuixSC8G6rwBWtySYTocpCMRNmuRIYvd/1IF1sc5EzGLAv3XPnQDORdHeL
 FHFY0elcDduUGr00RxgyLZUa52To9/aHr0Jy+BzdK2szuPoTyPClXcwRZWx2CoOQY2jiAQwAz
 VEhOgJ/NwhZ+nh18bkePYiEyoN1Et5gjqHD0vpa3a3BPC3XpGJbtTbuBeRsRlYe0hFyDjCXZj
 a4hxDc4qiuzX4hIRjsZUkKVyyHKngdQWTY4199PaN16W8r3siQLEBtoTFOeO0zeSGLqnvebAv
 e91JVWr0VJc/D7LOEr8ZAl+AgA9PGOq+tG4vaV1XKof8TU37n4eGKOFxIR8JrQ5KHC1cKyiHL
 0Plpno2LtvUS5UOjEfuMGSbLuMdsZHcyd0TxhmnQw5Wk71nHTwOunWsosug8d+btZr1JWHTE2
 2+a+C/kaaWlfoi7FInYZxLiYPCiCCwNkuWfwgiss98//YWHRwvEQCs9JbUC9Lv2BvCUHrpYHi
 d8edz+iAQZ1HWZv5zZ/nAG6S8LXQM+jRAO4DNxlesBvt/RBD4nqViubNWwCk8zPu+U2X5dflG
 M3hUe7u2xoBMl81wdQrWiXhYgk2o+pp2G8+E+KUd61+6gVOEOUSn0pHXeLQWn1TnEG73iTKBZ
 5eCFdS73IJl8M4suuTFS2oS17r+uowBuhkjRzVPTW60WV8bJZrvzTk78XUc=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Florian,
hi Stephen,

Am 13.06.19 um 05:31 schrieb Florian Fainelli:
>
> On 6/12/2019 11:24 AM, Nicolas Saenz Julienne wrote:
>> Hi all,
>> this aims at adding cpufreq support to the Raspberry Pi family of
>> boards.
>>
>> The series first factors out 'pllb' from clk-bcm2385 and creates a new
>> clk driver that operates it over RPi's firmware interface[1]. We are
>> forced to do so as the firmware 'owns' the pll and we're not allowed to
>> change through the register interface directly as we might race with the
>> over-temperature and under-voltage protections provided by the firmware.
>>
>> Next it creates a minimal cpufreq driver that populates the CPU's opp
>> table, and registers cpufreq-dt. Which is needed as the firmware
>> controls the max and min frequencies available.
>>
>> This was tested on a RPi3b+ and RPI2b, both using multi_v7_defconfig and
>> arm64's defconfig.
> How do we go about merging this? Stefan, will you pick up patch 3, 6 and
> 7 and submit them for 5.3/5.4? Viresh has already picked up patch 4.

is it possible to let patches 1,2, 3 and 5 go via clk-tree?

I would take care of 6 and 7.

Stefan

>
>> That's all,
>> kind regards,
>> Nicolas
>>
>> [1] https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
>>
>> ---
>>
>> Changes since v3:
>>   - Fix sparse warnings in clk-raspberrypi.c
>>   - Minor cleanups
>>
>> Changes since v2:
>>   - Fixed configs to match Stefan's comments
>>   - Round OPP frequencies
>>   - Rebase onto linux-next
>>   - Minor cleanups & checkpatch.pl
>>
>> Changes since v1:
>>   - Enabled by default on the whole family of devices
>>   - Added/Fixed module support
>>   - clk device now registered by firmware driver
>>   - raspberrypi-cpufreq device now registered by clk driver
>>   - Reimplemented clk rounding unsing determine_rate()
>>   - Enabled in configs for arm and arm64
>>
>> Changes since RFC:
>>   - Move firmware clk device into own driver
>>
>> Nicolas Saenz Julienne (7):
>>   clk: bcm2835: remove pllb
>>   clk: bcm283x: add driver interfacing with Raspberry Pi's firmware
>>   firmware: raspberrypi: register clk device
>>   cpufreq: add driver for Raspberry Pi
>>   clk: raspberrypi: register platform device for raspberrypi-cpufreq
>>   ARM: defconfig: enable cpufreq driver for RPi
>>   arm64: defconfig: enable cpufreq support for RPi3
>>
>>  arch/arm/configs/bcm2835_defconfig    |   9 +
>>  arch/arm/configs/multi_v7_defconfig   |   2 +
>>  arch/arm64/configs/defconfig          |   2 +
>>  drivers/clk/bcm/Kconfig               |   7 +
>>  drivers/clk/bcm/Makefile              |   1 +
>>  drivers/clk/bcm/clk-bcm2835.c         |  28 +--
>>  drivers/clk/bcm/clk-raspberrypi.c     | 315 ++++++++++++++++++++++++++
>>  drivers/cpufreq/Kconfig.arm           |   8 +
>>  drivers/cpufreq/Makefile              |   1 +
>>  drivers/cpufreq/raspberrypi-cpufreq.c |  97 ++++++++
>>  drivers/firmware/raspberrypi.c        |  10 +
>>  11 files changed, 456 insertions(+), 24 deletions(-)
>>  create mode 100644 drivers/clk/bcm/clk-raspberrypi.c
>>  create mode 100644 drivers/cpufreq/raspberrypi-cpufreq.c
>>

