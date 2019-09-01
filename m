Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFD22A4C5E
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2019 23:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfIAVwS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Sep 2019 17:52:18 -0400
Received: from vps.xff.cz ([195.181.215.36]:53662 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbfIAVwS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 1 Sep 2019 17:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1567374734; bh=jrClwa09Qi/Ap8hefr9nEz2+uFGxRJka1O26L0HZtjI=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=Gs/DjpJRQwS7k3GdVo1K8Mn4c10BiFj3iWCueQ+Eo7FUh8Em/o+SIw7lnOOqAsAbI
         9w8oMEwqviwHd70mKfz2VBAUtI/Xo8ftiC3Ph7R1lOTF3l5cEN2efKdvf40fcER5I9
         +OF110QXIozgqHCzD12if1ILel/HvTGPJCGZaEdM=
Date:   Sun, 1 Sep 2019 23:52:14 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 00/18] add thermal driver for h6
Message-ID: <20190901215214.f4vbxemdd7mf3gun@core.my.home>
Mail-Followup-To: Yangtao Li <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Yangtao,

On Sat, Aug 10, 2019 at 05:28:11AM +0000, Yangtao Li wrote:
> This patchset add support for A64, H3, H5, H6 and R40 thermal sensor.
> 
> Thx to Icenowy and Vasily.
> 
> BTY, do a cleanup in thermal makfile.

I've added support for A83T and also some cleanups, according to my
feedback:

https://megous.com/git/linux/log/?h=ths-5.3

Feel free to pick up whatever you like from that tree.

For others, there are also DTS patches in that tree for H3, H5, A83T, and H6, so
that shoul make testing of this driver easier.

regards,
	Ondrej

> Icenowy Zheng (3):
>   thermal: sun8i: allow to use custom temperature calculation function
>   thermal: sun8i: add support for Allwinner H5 thermal sensor
>   thermal: sun8i: add support for Allwinner R40 thermal sensor
> 
> Vasily Khoruzhick (1):
>   thermal: sun8i: add thermal driver for A64
> 
> Yangtao Li (14):
>   thermal: sun8i: add thermal driver for h6
>   dt-bindings: thermal: add binding document for h6 thermal controller
>   thermal: fix indentation in makefile
>   thermal: sun8i: get ths sensor number from device compatible
>   thermal: sun8i: rework for sun8i_ths_get_temp()
>   thermal: sun8i: get ths init func from device compatible
>   thermal: sun8i: rework for ths irq handler func
>   thermal: sun8i: support mod clocks
>   thermal: sun8i: rework for ths calibrate func
>   dt-bindings: thermal: add binding document for h3 thermal controller
>   thermal: sun8i: add thermal driver for h3
>   dt-bindings: thermal: add binding document for a64 thermal controller
>   dt-bindings: thermal: add binding document for h5 thermal controller
>   dt-bindings: thermal: add binding document for r40 thermal controller
> 
>  .../bindings/thermal/sun8i-thermal.yaml       | 157 +++++
>  MAINTAINERS                                   |   7 +
>  drivers/thermal/Kconfig                       |  14 +
>  drivers/thermal/Makefile                      |   9 +-
>  drivers/thermal/sun8i_thermal.c               | 596 ++++++++++++++++++
>  5 files changed, 779 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
>  create mode 100644 drivers/thermal/sun8i_thermal.c
> 
> ---
> v5:
> -add more support
> -some trival fix
> ---
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
