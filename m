Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E8D24F0B
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 14:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfEUMl2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 08:41:28 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50737 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEUMl1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 08:41:27 -0400
Received: from [192.168.178.167] ([109.104.45.223]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mz9lL-1gfcTu2sbL-00wEc7; Tue, 21 May 2019 14:41:01 +0200
Subject: Re: [RFC v2 3/5] clk: bcm2835: use firmware interface to update pllb
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     linux-arm-kernel@lists.infradead.org, ptesarik@suse.com,
        sboyd@kernel.org, viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, mbrugger@suse.de, ssuloev@orpaltech.com
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
 <20190520104708.11980-4-nsaenzjulienne@suse.de>
 <ebc78880-418f-f507-021c-41295113e041@i2se.com>
Message-ID: <6383b357-3f7e-f031-f59f-61c598e44763@i2se.com>
Date:   Tue, 21 May 2019 14:40:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ebc78880-418f-f507-021c-41295113e041@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:tiKWVTmj0/g6cApKXUC8RRsZ+jzrxl/tRzq9vOMKmDYvP0avI57
 S32E8AJVOWyViyljIeairozBYEi/9tS3d9Quw2v/CXkw1a6Ar/crQaVR2APWjjJGUJ60Nmz
 nZxhLgGefhNTSdMfJ5IvnUvMZRFoS2G0atk28i59/4Gi004Fp1AZZlWoUamsxO3xaRfcezn
 ZcSESHjDxbmzXOZpl4Oaw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VAEVr3c8/0g=:H9FaA9a655WuE86lTBUiV4
 2OJ0EepMNcKZDh29WOG6N+37XmL8YWraPTsNDcx7Rcf5OUR9+v1spI6wGk3DqpqMAcbBTkYXU
 irJhNgFzv/ehQJyoulSGeHTVIaCj/69YyDXUVPakRsvPb7fytYzSd+G/oU6+D9e+I2KQlcdBs
 CJqaFK1sW1UAEZQ13+kumPGYC463OkExAGsUsNvLNfw7i/a7IVT/0V5OD6zYs11hHtvV0SSIl
 wdjummx1yyjp5j2WYl1h9O7/QQZ1uo50V+AjtmGZx9gT//W9WmNnykfdJuAXgkCtZ6hNlXB7X
 F3nBUgXaNIb80nqocavO2b/2Fg+Bk2Q+bVTG47IHHKdD4hLsum7dMGUaBLs7oyJWJzXHE3/CU
 OX7QgcXooNyVJLSNQ649qi9KFPjYrgeg0+HK8MJKM+f9zggdSGXrdiHl34vhA30lVkJ2JT4wE
 gQr9/s/obESz4h4X9wyILrQf0Q8t//x1ONi9NubbHANW7XBAlGLRL9KvUdOhGrmQ2Ofl76kJi
 NZ0/Iu0opHBvrEUr5CQrCYE4zcOFa4ydGZSKAoPjmuCKM/3N1igCCedn6fTdp9RR6UVIVrieM
 3QMxnrsaGyx4qt+BtEe1ikMK6T6EVLQGOb7jkCxsoKFPYmuLJicghwwAhW7FVaDgGHGSIGYus
 a+KY2w+DQWj7xERtmRI3FaqGxWQGHAc9NkezH98aiMdImPcbmDSiHr0xWsZ3HBlI27xs4GHAD
 4v+WV6ijitxntnFIA4En+ZvAntlNK5t+0DuJDVlop7vKvyiX4ON55G5Lljo=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Nicolas,

On 20.05.19 14:11, Stefan Wahren wrote:
> Hi Nicolas,
>
> the following comments applies only in case Eric is fine with the whole
> approach.
>
> On 20.05.19 12:47, Nicolas Saenz Julienne wrote:
>> Raspberry Pi's firmware, which runs in a dedicated processor, keeps
> maybe we should clarify that the firmware is running in the VPU
>> track of the board's temperature and voltage. It's resposible for
>> scaling the CPU frequency whenever it deems the device reached an unsafe
>> state. On top of that the firmware provides an interface which allows
>> Linux to to query the clock's state or change it's frequency.
> I think this requires a separate update of the devicetree binding.
>> Being the sole user of the bcm2835 clock driver, this integrates the
>> firmware interface into the clock driver and adds a first user: the CPU
>> pll, also known as 'pllb'.
> Please verify that the kernel still works (and this clock driver probe)
> under the following conditions:
>
> - CONFIG_RASPBERRYPI_FIRMWARE=n
> - CONFIG_RASPBERRYPI_FIRMWARE=m
> - older DTBs without patch #1
i thought about this and the case this driver would return
-EPROBE_DEFER. The clock driver is too essential for doing such a thing.
So i think the best solution would be to move these changes into a
separate driver which should be register by the clock driver (similiar
to vchiq). This also avoid the need of a new device tree binding.
