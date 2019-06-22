Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C83D4F500
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 11:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfFVJzQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 22 Jun 2019 05:55:16 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVJzQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jun 2019 05:55:16 -0400
Received: from [192.168.1.162] ([37.4.249.111]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MG9wg-1hoT1Z3SrE-00GYeg; Sat, 22 Jun 2019 11:54:49 +0200
Subject: Re: [PATCH v4 0/7] cpufreq support for Raspberry Pi
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, mbrugger@suse.de,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20190612182500.4097-1-nsaenzjulienne@suse.de>
 <6a9e1450-80ad-a13c-59d2-d0b39f25f67e@gmail.com>
 <7acfd967-0a82-5429-4eed-8b802e6620f5@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <d8b20179-45ef-479a-47dc-390a4a2dfddf@i2se.com>
Date:   Sat, 22 Jun 2019 11:54:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <7acfd967-0a82-5429-4eed-8b802e6620f5@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:kNVNWkAjuEb7vVPkGdiQQKKmCJU8LtLX0sh+gtr0KzMusrY4L1K
 WyeiwBUxZtVlmhaLqVUZkU865SX7UDf78Q+0dQ2L2wKmqwMhCSPNpqlYL7GHgb4CSrkewru
 EkvEVQlUmXu0zESbj+3YvSykrgtvGogfULKzeWL/31pQ+iqSakaY4pcTVvqcgOip1ViKSo3
 HJQZUEPr/2G+/NI2n1SDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4OBIfy33c0Q=:sW/r3Ga/IfW0VsTiAv6ve/
 xYL0+TlPU1HSAZaE3jL9vbAvIpe0zwOOlJUtIKra2OkwV6r73fLvbKw3M6BHtwVqXlVyrjGeO
 +UGUtSbTWXOtRXPnV1TnSqs04JnRZyInCYqN08opCGsy11/3imhIoo/UsL3glMUYr+djkOTQi
 yJB7udc+6zSEIhj8Tc+/Q2pD7ooWYuhN/rMqjDRk0oAyLPhPWNhrDfQ5TSC6NXhrmR/F1g03Z
 fQMzSyuPyveUuXiSh1hRcQQt2rGm4P7nnD2RPlFjDNqwrLd8rMRFXEOf9JTo4cEdoNwQeVuOA
 NC/owZOW0/KmiOC/vUhFqTmef4ELCMs6wsbR8dKJbRJavzc68CPq8MqQjlUvuzRzkm3RxmXq6
 KMQsOhGkacGoZLGaVE1WmrkNoe+hHXWK8SnD/iMJJsK5K4spmAaepIVLM5tEwuTEBYAAgyUF8
 GB6nFPs1fGqEWKxIIU98MJWJCMXOFEocqMB0U+r0E9BR24Tc+mz16SDLtXpXhPT8jkCaDFjDG
 Kkruupffgf4kkX1QURUS6CEr44W677rCEcORWszvZg/zBo7mSTcQFW0vKK3/RtgNeP6Wtxp56
 4z740VPg0lfNVXuLGMiJIb90WsHn0hypWcWjAO2XcU1rnAKQGhoycfhLAx3MDiuJGjSfoFYiu
 wEx6rXbBV/sTIzdUR8K2Cfd7EUwisqJ5nuJNQ1cAZBBUa59j+AKk1v3xBAmZBetuM4gngObs1
 FVJO94Ics+gfHODofTZvPoWntmJ2UBmNTlx/Q1q5HYycMxGDdfg/b2Aum+4=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stephen,
hi Mike,

Am 13.06.19 um 06:31 schrieb Stefan Wahren:
> Hi Florian,
> hi Stephen,
>
> Am 13.06.19 um 05:31 schrieb Florian Fainelli:
>> On 6/12/2019 11:24 AM, Nicolas Saenz Julienne wrote:
>>> Hi all,
>>> this aims at adding cpufreq support to the Raspberry Pi family of
>>> boards.
>>>
>>> The series first factors out 'pllb' from clk-bcm2385 and creates a new
>>> clk driver that operates it over RPi's firmware interface[1]. We are
>>> forced to do so as the firmware 'owns' the pll and we're not allowed to
>>> change through the register interface directly as we might race with the
>>> over-temperature and under-voltage protections provided by the firmware.
>>>
>>> Next it creates a minimal cpufreq driver that populates the CPU's opp
>>> table, and registers cpufreq-dt. Which is needed as the firmware
>>> controls the max and min frequencies available.
>>>
>>> This was tested on a RPi3b+ and RPI2b, both using multi_v7_defconfig and
>>> arm64's defconfig.
>> How do we go about merging this? Stefan, will you pick up patch 3, 6 and
>> 7 and submit them for 5.3/5.4? Viresh has already picked up patch 4.
> is it possible to let patches 1,2, 3 and 5 go via clk-tree?
>
> I would take care of 6 and 7.
>
> Stefan
are you fine with the series, since Viresh already picked up patch 4?

are you okay with my suggestion above?

Stefan


