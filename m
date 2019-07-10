Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1BE64F19
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 01:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfGJXKT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 19:10:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40408 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfGJXKT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 19:10:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id e8so3897535otl.7;
        Wed, 10 Jul 2019 16:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOl/4QjBy1AW7qYuyDY5XT0hjYnXC6DcAJBpkzl0PHI=;
        b=H1UDpQLEZcDHT2f5H5ImR/uneIMngNaFtHExhhRI1hPFxMbfZ4VUbowPJKrXdHu/Wt
         smoBUScf5aczoqOoDJG9maeO0XjvWp+H4fNsfspzcmv31JCtuPqL0cXVz4GD8oLzbf2N
         ZgGvav44nwUxj0RA6R0zBRV40Wfni/MkjCZJcSLJ7UgvH2O4e+2aZ7urVmR89RMHzfTZ
         lxqTgljho97ZquaIlQ6yF05xR5M7ODf61hpv56An+RGS/nMpOODNSWTHDewJY2Wr3ct7
         5Ghai8O3H2/tzyUAaj5QKonCrJceoW00furKv0qheUams9jV9kz+sYXaEglIe3CjMc+s
         aR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOl/4QjBy1AW7qYuyDY5XT0hjYnXC6DcAJBpkzl0PHI=;
        b=qAoIO/QF+L6wyO/vTKYqyMyzcQ65kcgMagqL/mkOqU4rejaWpCqZv3pgqQ9dd2Mohu
         BFmBFju4ezKzKsa/SB370AynZAezXsqz3f+KFFRnOlmUo8hoDHZ5iKLewkugsoNNwlGc
         /r0aovgJ/OBgO24ix8vmDSuf3KMPVBFMpGcyS0mdS4EnLy+zv3ppXwKxoP0ctjV1CYjb
         s0ciC33qGtMkd+dHz71UupKxI//5XicWPWNYGcNzkbmKdTBfMQ/ONWfLWMFmjeI+5ixB
         SP/8vZLcwjTrgo6bfrIREOwTr2mQw/5lKEGHznwNFInVrHohxc9dmHzw6WWXFrYL/RGn
         +hUA==
X-Gm-Message-State: APjAAAW93X2JOSH2ERM49E/7a6GWBu6cZRR/Andv81TRPowDVAUxfYB/
        p16FJC3Tvtbwph1L7AXTN/gH8GGp1S3I1B+W/Mk=
X-Google-Smtp-Source: APXvYqz2RpwH4pyPuxIqsY3Jk01l6pCxhtB+fsAoA6sP8HbGqCPKyFUN1rGcJxjdBY2aJ7m7PpF04jShUCcSnuc4/nQ=
X-Received: by 2002:a05:6830:2010:: with SMTP id e16mr728916otp.344.1562800218410;
 Wed, 10 Jul 2019 16:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190623164206.7467-1-tiny.windzz@gmail.com>
In-Reply-To: <20190623164206.7467-1-tiny.windzz@gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 10 Jul 2019 16:09:52 -0700
Message-ID: <CA+E=qVfhDEQER2UTj65hR9erzej9Ey2FrUa9GV=iCFYsWZ2ztw@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] add thermal driver for h6
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 23, 2019 at 9:42 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> This patchset add support for H3 and H6 thermal sensor.
>
> BTY, do a cleanup in thermal makfile.
>
> Yangtao Li (11):
>   thermal: sun8i: add thermal driver for h6
>   dt-bindings: thermal: add binding document for h6 thermal controller
>   thermal: fix indentation in makefile
>   thermal: sun8i: get ths sensor number from device compatible
>   thermal: sun8i: rework for sun8i_ths_get_temp()
>   thermal: sun8i: get ths init func from device compatible
>   thermal: sun8i: rework for ths irq handler func
>   thermal: sun8i: support ahb clocks
>   thermal: sun8i: rework for ths calibrate func
>   dt-bindings: thermal: add binding document for h3 thermal controller
>   thermal: sun8i: add thermal driver for h3

It would be nice to add dts changes to this series. It's unlikely that
you'll get any "Tested-by" otherwise.


>  .../bindings/thermal/sun8i-thermal.yaml       |  94 +++
>  MAINTAINERS                                   |   7 +
>  drivers/thermal/Kconfig                       |  14 +
>  drivers/thermal/Makefile                      |   9 +-
>  drivers/thermal/sun8i_thermal.c               | 534 ++++++++++++++++++
>  5 files changed, 654 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
>  create mode 100644 drivers/thermal/sun8i_thermal.c
>
> ---
> v4:
> -add h3 support
> -fix yaml file
> ---
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
