Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19DDE2165D
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 11:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfEQJif (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 05:38:35 -0400
Received: from eumx.net ([91.82.101.43]:54662 "EHLO legacy.eumx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbfEQJif (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 May 2019 05:38:35 -0400
X-Greylist: delayed 1273 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 May 2019 05:38:34 EDT
Subject: Re: next/master boot bisection: next-20190514 on rk3288-veyron-jaq
To:     Doug Anderson <dianders@chromium.org>,
        "kernelci.org bot" <bot@kernelci.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        mgalka@collabora.com, LKML <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>, matthew.hart@linaro.org,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>
References: <5cdae78b.1c69fb81.a32a9.870f@mx.google.com>
 <CAD=FV=WDjUBvwoAaWNOmXPaLpZCccpAgRWDzRSnvsQ62TFwVmQ@mail.gmail.com>
From:   Jack Mitchell <ml@embed.me.uk>
Message-ID: <a9767b82-9b3c-fc05-5f33-fb79c8fc8507@embed.me.uk>
Date:   Fri, 17 May 2019 10:17:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WDjUBvwoAaWNOmXPaLpZCccpAgRWDzRSnvsQ62TFwVmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BW
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/05/2019 22:38, Doug Anderson wrote:
> Hi,
> 
> From: kernelci.org bot <bot@kernelci.org>
> Date: Tue, May 14, 2019 at 9:06 AM
> To: <tomeu.vizoso@collabora.com>, <guillaume.tucker@collabora.com>,
> <mgalka@collabora.com>, <broonie@kernel.org>,
> <matthew.hart@linaro.org>, <khilman@baylibre.com>,
> <enric.balletbo@collabora.com>, Elaine Zhang, Eduardo Valentin, Daniel
> Lezcano
> Cc: Heiko Stuebner, <linux-pm@vger.kernel.org>,
> <linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
> Zhang Rui, <linux-arm-kernel@lists.infradead.org>
> 
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>> * This automated bisection report was sent to you on the basis  *
>> * that you may be involved with the breaking commit it has      *
>> * found.  No manual investigation has been done to verify it,   *
>> * and the root cause of the problem may be somewhere else.      *
>> * Hope this helps!                                              *
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>
>> next/master boot bisection: next-20190514 on rk3288-veyron-jaq
>>
>> Summary:
>>   Start:      0a13f187b16a Add linux-next specific files for 20190514
>>   Details:    https://kernelci.org/boot/id/5cda7f2259b514876d7a3628
>>   Plain log:  https://storage.kernelci.org//next/master/next-20190514/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.txt
>>   HTML log:   https://storage.kernelci.org//next/master/next-20190514/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.html
>>   Result:     691d4947face thermal: rockchip: fix up the tsadc pinctrl setting error
>>
>> Checks:
>>   revert:     PASS
>>   verify:     PASS
>>
>> Parameters:
>>   Tree:       next
>>   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>   Branch:     master
>>   Target:     rk3288-veyron-jaq
>>   CPU arch:   arm
>>   Lab:        lab-collabora
>>   Compiler:   gcc-8
>>   Config:     multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y
>>   Test suite: boot
>>
>> Breaking commit found:
>>
>> -------------------------------------------------------------------------------
>> commit 691d4947faceb8bd841900049e07c81c95ca4b0d
>> Author: Elaine Zhang <zhangqing@rock-chips.com>
>> Date:   Tue Apr 30 18:09:44 2019 +0800
>>
>>     thermal: rockchip: fix up the tsadc pinctrl setting error
>>
>>     Explicitly use the pinctrl to set/unset the right mode
>>     instead of relying on the pinctrl init mode.
>>     And it requires setting the tshut polarity before select pinctrl.
>>
>>     When the temperature sensor mode is set to 0, it will automatically
>>     reset the board via the Clock-Reset-Unit (CRU) if the over temperature
>>     threshold is reached. However, when the pinctrl initializes, it does a
>>     transition to "otp_out" which may lead the SoC restart all the time.
>>
>>     "otp_out" IO may be connected to the RESET circuit on the hardware.
>>     If the IO is in the wrong state, it will trigger RESET.
>>     (similar to the effect of pressing the RESET button)
>>     which will cause the soc to restart all the time.
>>
>>     Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>>     Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>     Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> 
> I can confirm that the above commit breaks my jerry, though I haven't
> dug into the details.  :(  Is anyone fixing?  For now I'm just booting
> with the revert.
> 
> 
> -Doug

I can also confirm that this breaks boot on our custom board which is
very similar to the rk3288-Firefly. In my scenario the processor just
seems to "hang", no reset occurs if that helps debug matters.

Regards,
Jack.

> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
