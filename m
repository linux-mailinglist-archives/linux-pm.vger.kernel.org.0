Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0917B39C76
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2019 12:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfFHKnu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Jun 2019 06:43:50 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:41925 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfFHKnt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jun 2019 06:43:49 -0400
Received: from [192.168.1.162] ([37.4.249.160]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N0X4c-1gfNnc3WUe-00wRCN; Sat, 08 Jun 2019 12:43:24 +0200
Subject: Re: [PATCH v2 0/7] cpufreq support for Raspberry Pi
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <7c51e65a-e84d-07fa-ac1e-0f34ecce887b@i2se.com>
Date:   Sat, 8 Jun 2019 12:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606142255.29454-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:oANPBkQ2KsQjlx8cfiyIC9oczC/QXncykGstAQioDeCodefMUV9
 bW4wXsBgSWz/OzPocIRGDHXyqOHpejs3iBLEfZ1ysMEMLG/0kaPE7/Khly0eedgHYIPTEZf
 yAn4yAh5/U7XSgfKC5NsT3l8l9H6jk9lc+xGIH2b/WwOwnNvv5COr8VxqFRG/sH5DfMubph
 0ZClOfJpLTbgWsboaqzFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u2UOTKSuFLE=:GinJCXRdmjhbj7l20EMK4B
 dfYA8BnBeUoi9dLijDSKMgCyb/lTAdw759WEYNfnavlB350IhLfmj3F3V17a7ZuuiX/F35Lx6
 P02EzGJOHeXK65TfRc0/6BFjWR56+DhE2zumOZNV1XCx+hB4wzkx4OOhSxuP1jrCGEKU2IQ8x
 Zojuj0ImWp8XP34p/VM7jQHd8ArGy0IgZCBHrUy02bYL6UYh33EHWEDPWhSrrHL6OlZuWBOmQ
 Bi9O3Y9v2B+TvxW6NOvMsXEkxO1pN8ceNmAD2rotoOay1+MHP8cTsG0bdmtRBc/57vr+dJuEg
 k5lHbXA8NLoUR8R1HTSgRE158PZ5lnmEnbEbZjIv18Qtf1EFrbExgyFWXlyFMoOP8fnJPw19W
 HFfW3/kse0lEpZVXBqFWyvrEhW/oxFgJbxCxHJbW/BSoz8Bw9Q9HN/xPI6Bk+Gnkaxq4wzghw
 STWRL05mGK/Y7vQTyxX0MHcvbq4MdCRs/xU0sl6v4loBQ3syG5raEVlF3YBuRfhy1tuJpYHQM
 +/yw5cgyEtcPm9E3Z0D/zw7GN14zYKv6MHEyWfzzJJ7pGWgqq0vhCWNwRVJwJTLujwj5AuNgB
 wx75WreotJLxxAGgcqzggvhfyTRaszjG0TUgcGT17V7nK9UCCYI3rLCpGEV+vAcbJ84ewHENp
 XyHDRKpB4x6R/fF8wT3EyGrN4FdapZ4Jdm16tpnqxq0kHlNNzqWZ8ctsmnFCGY0sx3eczum+R
 a029FBQe7UzrnnjK0mPF7UAPznnIPdJyRAhGvziGXmwPpa67pGZ2uWcWppY=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am 06.06.19 um 16:22 schrieb Nicolas Saenz Julienne:
> Hi all,
> this aims at adding cpufreq support to the Raspberry Pi family of
> boards.
>
> The series first factors out 'pllb' from clk-bcm2385 and creates a new
> clk driver that operates it over RPi's firmware interface[1]. We are
> forced to do so as the firmware 'owns' the pll and we're not allowed to
> change through the register interface directly as we might race with the
> over-temperature and under-voltage protections provided by the firmware.
>
> Next it creates a minimal cpufreq driver that populates the CPU's opp
> table, and registers cpufreq-dt. Which is needed as the firmware
> controls the max and min frequencies available.

Here some figures from the Raspberry Pi 3 B+ as before/after comparison:

Dhrystone Benchmark 2.1 A7 32 Bit

 600 MHz, w/o Turbo (1): 1216.11 VAX MIPS
1400 MHz, w/o Turbo (2): 2839.67 VAX MIPS
1400 MHz, w   Turbo (3): 2839.45 VAX MIPS

Whetstone Single Precision C Benchmark  vfpv4 32 Bit

 600 MHz, w/o Turbo: 454.565 MWIPS
1400 MHz, w/o Turbo: 1062.494 MWIPS
1400 MHz, w   Turbo: 1061.723 MWIPS

Power consumption (32 bit, without Ethernet) with load ( cat /dev/zero )

 600 MHz, w/o Turbo: 2.48 W
1400 MHz, w/o Turbo: 3.2 W
1400 MHz, w   Turbo: 3.15 W

Note 1: This is the maximum performance before enabling any cpufreq driver.

Note 2: This is the maximum performance after enabling V2 of the cpufreq
driver
http://lists.infradead.org/pipermail/linux-arm-kernel/2019-June/657768.html

Note 3: This is the maximum performance after enabling the initial
cpufreq driver
http://lists.infradead.org/pipermail/linux-rpi-kernel/2019-April/008634.html

