Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4F7ED29C
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 09:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfKCIoO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 03:44:14 -0500
Received: from mout.gmx.net ([212.227.17.21]:53701 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfKCIoN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 Nov 2019 03:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572770630;
        bh=8nUwWR8GExLcbOE3XOLQonZXx+8Ceoj8aeAbi+XtRKo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=S/6Slt4jsNuKM4d0rcPspjgA2G20Z6BHkEKgYuiQbBbVNde9l4bHEe0k63QQw1RNl
         cIpzuV48kKm4IQtYJlLNDFEU2srJIeq23CVBWbJFkQvllUasmsqVZ9AVpSagBXL7rA
         /1DUgaawWXLdFR2vvuoKUzGrdOUN4brSUOhpFRdU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.112]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDIu-1hj5JG0sme-00i9OL; Sun, 03
 Nov 2019 09:43:50 +0100
Subject: Re: [PATCH 0/4] ARM: Enable thermal support for Raspberry Pi 4
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>
Cc:     devicetree@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <1572615749-9524-1-git-send-email-wahrenst@gmx.net>
 <1c8ccf12-743c-cad0-bd63-3f46abe7d1c4@gmail.com>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <26f81338-2929-9ebc-cb46-0681b74d074d@gmx.net>
Date:   Sun, 3 Nov 2019 09:43:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1c8ccf12-743c-cad0-bd63-3f46abe7d1c4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:wxPytE7gu1xzzCAy/l/4u/fAJPkjeYCCgKxR3X9/+UrDRbsEqzU
 GztSQYU3OPE4nN7YiW/qezu+liIoHS7u7akxsdnT1bLQc1XkToEwBTqzQhz+gkM/2LwG5mP
 /IsSm32+ac8+GM7Z+0vQEmFx7TG7ktawK6losZaclZtCRhiV2O6bQYiRuSlgT6X2FOvA5M0
 qeJr6BC42oky/RX/q+kZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:n06fWHGqoz4=:mQogwh+vQVADzOLQo9GN/r
 r9w67GJkyp+uBYP3ELrlz3LyywsowWal8q7uthlt+8ERGIAXhQ5ycH3vHsbetsBmx3Sq6Wh/b
 7Vi21Z9gDJGOVpIZaGkCNimvbl2+/aFSBB3ZyBdcEHilWy2VZJoTWiwqL3lVKgqrl2tndpep7
 pVo75BQW33IU0KQXwcLqvAWDWGe9tHboy+vMwA4oqctStmx6rWCePgkIuTm85okKGQrR5HWdl
 O8j9a7mAtzRjy7mpcFmOZOZgked2J0rgw27cOFYAuqogFqxTEucls9AXUDWR4GGFCpDZv2pGi
 R7PZWdKsAb70MmsIqRrpilK5m40oXP2r8/hVw/6ZIVSqrme5kzyurYJJF57uSbYP/ONC6mf+Y
 pTU8A3dnRJe2RKYOowoMbaqhxVvfP7LvfPZ0yo2widVII4ebbk/JCftoQ4hr1koTv7pzETvTB
 LbybPCv8HDhUKvhjvCdZtL+Phwk9kK7PkTSluFb2MD1aK6vZMYl4VIFihYQw6gN0ZLZkQ6FlU
 FXMWuPaAF8TgKxHa3/p2zmKwFLYh0MkckEV3/kk+2ETm5gcawJWfXj7Gr1Qz33wfVpILZidQB
 6ba8wZ14QZfjPmllr355srFg0VI/xsWAWtAKjK3peTcyPljn38YDKDQNsGTTW4jc+TZQR2057
 aBbdl/bXvllGJSEyhXscoAu72zPPp0Nv7RIiX8exssjhwH619V6vTTtrktXbx23bZYLpknT3/
 zcAsxNMD+oSyWWF7V6DcBu36ec8gnHK5AoQF0f2zR8wP4BOljsp4gIEc5MHbgFnPZvUmhMQpw
 Et40BAJcFfiYXg8R02pRHT6xOyIcuNZV5+6iGkeaKttgRx1d4HoLGEu6me5lRBc5uV4s5O+8C
 JrnMo2ptcflC8thPQF4sXcMm7QMx8lVOoiQZ3po0TLIJGcmWLun3AvrhXWAM7N2+hPSa8l+DG
 PCdmJ5q3RvklbiCBdO9mOJpRkIsoc9xO2mbYBl9iTeIrCIQB2R9IDf4TzzhSPTvzfLzC9ImD/
 9zgAxdIr0ZKqZoE85X8YfrwAngfx5yXKxc2F7uE6UbDV7Tg/byGPX0Q1qcz2NPH/qFYvaobdL
 Omuf071DybDa9A4mY2ckei98y8aPaX2+tsy9Wlr8IryLTqecmbxPFcCmSZp7o1YSJy6z448Pi
 hgZxsMB3iNPdwD/T1AM+HYJtIYX2gLnmArNq6g69wxeyFThF1s3DCgjQPZ/fCarOcdlAzMJE6
 L4js5LeH+xSvFJxeVe9VHQPELjeSbN3Dtw5wiTq9xOiWMdzr97qnNCCuAjgY=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Florian,

Am 02.11.19 um 21:08 schrieb Florian Fainelli:
> On 11/1/2019 6:42 AM, Stefan Wahren wrote:
>> This series enables thermal support for the Raspberry Pi 4. Neither the
>> bcm2835_thermal nor the brcmstb_thermal are suitable for the BCM2711.
>> So add a new thermal driver to read out the SoC temperature from the
>> AVS RO block of the BCM2711.
> It seems to me that with minor tweaks you could use the brcmstb_thermal
> driver, since the two key differences are essentially:
>
> - lack of interrupt, which is also the case on the latest STB SoCs
> - different way to determine that data is valid, by checking both bit 16
> and bit 10, as opposed to bit 11, and a reduced ADC code from 11 bits
> down to 10.
>
> This seems like a simple enough set of changes to build on top of this
> patch series:
>
> https://lore.kernel.org/linux-arm-kernel/20191030182132.25763-1-f.fainelli@gmail.com/
this was the downstream approach until i was informed that the thermal
part of the RO block is used. I don't have a good feeling about misusing
the wrong binding. I still hope that the RPI folks release some kind of
memory map for the BCM2711 and maybe extend this driver. So i prefer to
start with a separate binding.
