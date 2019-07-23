Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D4372192
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 23:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392065AbfGWVeO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 17:34:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:40683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731019AbfGWVeO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jul 2019 17:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563917612;
        bh=r+mxvsFxNstnBrZNL57AG/IrXnf6gomR1qRVuNahHzo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Yh80MbgsKfdmjhFjME/W4KIBmH0Fsdc7F8lX5rj9MAoVt6LG9JiieQCpzTncbUj43
         aTZVKtv2+Hk/gIoOpNBRYSv3vmdsBeJfOAQ5QfTshzJoVrh00xPApQsSTER9wuRyNz
         Gmi/FA+35aOipFtmc2mBjFtngveAFPkApYrj6Vzo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5dMm-1ieg7w08a0-00xZLC; Tue, 23
 Jul 2019 23:33:32 +0200
Subject: Re: [PATCH v4 6/7] ARM: defconfig: enable cpufreq driver for RPi
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        stefan.wahren@i2se.com, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-arm-kernel@lists.infradead.org, ptesarik@suse.com,
        sboyd@kernel.org, viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, mbrugger@suse.de, ssuloev@orpaltech.com
References: <20190612182500.4097-1-nsaenzjulienne@suse.de>
 <20190612182500.4097-7-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <70aba40f-2c63-95b1-166e-f0125ef6372e@gmx.net>
Date:   Tue, 23 Jul 2019 23:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190612182500.4097-7-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:rDzAHccUgFdH0JEJ207RLkE8pdTRG0kdDOUgfbsFrN46gUX06Vr
 PlAADTyGQ/dLXbEId3Rq+XYUwHDp2s/U/C+JA4dbj8DtYHdSt+m5hJpaJwktTkP6Hi1gR0j
 yYK3DcLigDT0ZiTf0qyzX4zzouCmnDQrjtafqmh00aHBzsrBtabjK2rEXX7oDUI5B43x6RU
 QOHjQw+gImibix94sLgOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9/p9q6LWFcs=:9RKTowjQ+a+DBLNWoimTtr
 k9xUCiF5Q942VNmSxUbXTwoIyjoCBHwJ1XgoMIYF7KXUzNx7P2iCXJW5qq7L1yn+RcmmFweJr
 dHclwAJVuM46kxBQtXVoaezLMAbXPISVmAupKkDifkxo2Wtq6vfbNTzbYkabzuiDEweUg9bcV
 ZBHo8a8Tgj4rOwBrtdblkSyKVUHBvz/ylyqEV7I90r44LtPpk2ZJkTe3TaaBcYDIfkwuUf6PG
 P1c5GN4s4/j75500k2JFpmkGUQl6D8hZO86SRPsF+QKUaYMDR0+oNAicEyjHnt5Jn0kyYBCkd
 os3lRIm2kKnAHuk0jf9RiCQWLb/zyM240qFCGcgcF1W20PYYqpFPUdLL01uXRbmko6mUJeTqC
 7a6vmua5thSw4rOvCmzyLnHNzhJGOuoZmSwHvsxfhqIEKihupiBPPbR1rSndmUTkYf2gv3W1m
 abC87nuMv/GGMGtA5ESmeSH8XmNVsprjgwZvvHECjXX5Fm0tUa0ud/UHnY2Vvwg1DNdSGwb8+
 /A4E3B/sqtOGbcbiaRzhAIvTysyUuWX4vftUwt+BtmHkrskJssjiS2O756ei+YkLsxAD2+o5a
 Gb2jCVkvyyCfb5oC3ayFjZdHS8Mao7DPnL191nZ69vHVhGdI5Yzf9k9kmd2Tg/YBYbb/ZA7sJ
 95S2i7zm2ONxwSbdAtf+SizF5LMZ00WnKle7TDsgfSXG5eCNJfhHyEmnXWuTqzafCYdUfkJcS
 ubF4NvuFCcTj4gVIF2oxjZqttNRGOg8Sx3aFDQl2//m849qbAhLN17TTYrxN8g9B5JLrUEeQE
 OovMZxd+Gpz6t4X8cewEJLeigSrDF6u9jSZv4yGpT306F0Ck7TOZ9IzZeWimmbzoXZ98bpfnQ
 8SlG5fk5zHHRt2ycdwure78iF76bpGhuRWi4CoDmC9ZYvEZph+k19tbexiRPodDUbwCONzLs6
 KnHWXJ14Gets4bp1P6cUQIcQv534C12LyGEmEkD+XdDDhGeXxGRFF8p1frF1nk3Ior5sTfDun
 kI9WX58Kz1q14FEKrirRjQ2JcQmVyE6HAhTtiryTQEfPkRQb2dcajKqcWmDohRP+aO/tx9hSl
 tTV7F8407OaEP0=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am 12.06.19 um 20:24 schrieb Nicolas Saenz Julienne:
> This enables on both multi_v7_defconfig and bcm2835_defconfig the new
> firmware based clock and cpufreq drivers for the Raspberry Pi platform.
>
> In the case of bcm2835_defconfig, as the cpufreq subsystem was disabled,
> the conservative governor was selected as default since it better
> handles the high frequency transition latency.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied to bcm2835-defconfig-next

Thanks

