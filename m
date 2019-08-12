Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE918AB40
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 01:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfHLXgN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 19:36:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42580 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfHLXgN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 19:36:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id j7so20884911ota.9;
        Mon, 12 Aug 2019 16:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mdMrX21nqMnvIo0oSW5nynBC7o2j74UpdSvh/i3TCuw=;
        b=Dc0IemBH6ncFvomx4DuvnPw47t9stKmlDKr174FZc3Govzrg+3isbhY8bAEhZMFZSM
         EJwTO7PC5sc2aIM1Edj9q+rHGs1QDBbUtcvHaM5FlZvnj1nrnNKtRP4+BH4KkI5svDM/
         rG7q1A8/+GSQ0XYBE/zavAFd8ivbsG4uDI9t0Gk/S2IeAqJlyU+8XncCly65BRRzeQk/
         4cZl5vn0GX5UTK2mhGgURbWmw+tzQYKBDIFjN72ckCJRJ80gV6g+TWhJKQPmy0vWR0OQ
         Phq4uZ0RKXJT1T76zva460FaPlcXKtsampSsiCafYOeeFLds+tWobvtYROdKcENNUd/o
         C07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mdMrX21nqMnvIo0oSW5nynBC7o2j74UpdSvh/i3TCuw=;
        b=QiYNd+vgOQoKzRnoeUjCF1GsMgovqPKZaZiUJ8ZH9hsBIf6CbX9YU/QlM6YTx7PUEw
         JLmBDtVZH/+YDaGXXC4g2yD0W9TNGC1TgNGt4wZTai3io05xnnYwwGTvGIDlGtMaKba1
         WRDbSj+gRUVgAWlFldxrFxc1FsikWe8xqZPCkMXoro56cAmV35qjr33zH+Pqcn7uPgAU
         3ThsqF4zkSr/oC7nYvUNxAhFmQkYyCj9e4qTtwqWH0CfIaYc58iLoM+irn15QcVwSsIm
         js32dY2OHdAA4mg+Tygv49+1b+Xe5by8S3lWusl1rCOBBiU0yBsY7pndA9eg2MBh92e8
         M4cQ==
X-Gm-Message-State: APjAAAXAxz93t8ohf59nVQDFth5LqL9eO8oUwLExsY2dto7oT2/eJTra
        RjZmNuGGJDafIxk2pXlVZHLVOyvHsPfOywuUDm0=
X-Google-Smtp-Source: APXvYqwzQ8RzLpMPAB55e3s5PL0qjJ7LLgXXH8BJGqGYod4lRp0CQ5+iGkhGj8srHUw4054ayr+0QdORe2rXP1OVJtA=
X-Received: by 2002:a5d:9047:: with SMTP id v7mr26934439ioq.18.1565652972130;
 Mon, 12 Aug 2019 16:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190810052829.6032-1-tiny.windzz@gmail.com> <f479c162-4eac-f320-3583-b9ddbef79b1a@gmail.com>
In-Reply-To: <f479c162-4eac-f320-3583-b9ddbef79b1a@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 13 Aug 2019 07:36:00 +0800
Message-ID: <CAEExFWu+CNqjDF218kaVu2xHq1yYL8XgxrM1o=S9axNNebb8XA@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] add thermal driver for h6
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 12, 2019 at 5:14 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.c=
om> wrote:
>
> Hi Yangtao,
>
> On 10/08/2019 07:28, Yangtao Li wrote:
> > This patchset add support for A64, H3, H5, H6 and R40 thermal sensor.
>
> Could you add the device-tree configuration in the same series?
> This will allow user to test it.

Ok, it will be added later.

Yangtao

>
> Thanks,
> Cl=C3=A9ment
>
> >
> > Thx to Icenowy and Vasily.
> >
> > BTY, do a cleanup in thermal makfile.
> >
> > Icenowy Zheng (3):
> >    thermal: sun8i: allow to use custom temperature calculation function
> >    thermal: sun8i: add support for Allwinner H5 thermal sensor
> >    thermal: sun8i: add support for Allwinner R40 thermal sensor
> >
> > Vasily Khoruzhick (1):
> >    thermal: sun8i: add thermal driver for A64
> >
> > Yangtao Li (14):
> >    thermal: sun8i: add thermal driver for h6
> >    dt-bindings: thermal: add binding document for h6 thermal controller
> >    thermal: fix indentation in makefile
> >    thermal: sun8i: get ths sensor number from device compatible
> >    thermal: sun8i: rework for sun8i_ths_get_temp()
> >    thermal: sun8i: get ths init func from device compatible
> >    thermal: sun8i: rework for ths irq handler func
> >    thermal: sun8i: support mod clocks
> >    thermal: sun8i: rework for ths calibrate func
> >    dt-bindings: thermal: add binding document for h3 thermal controller
> >    thermal: sun8i: add thermal driver for h3
> >    dt-bindings: thermal: add binding document for a64 thermal controlle=
r
> >    dt-bindings: thermal: add binding document for h5 thermal controller
> >    dt-bindings: thermal: add binding document for r40 thermal controlle=
r
> >
> >   .../bindings/thermal/sun8i-thermal.yaml       | 157 +++++
> >   MAINTAINERS                                   |   7 +
> >   drivers/thermal/Kconfig                       |  14 +
> >   drivers/thermal/Makefile                      |   9 +-
> >   drivers/thermal/sun8i_thermal.c               | 596 +++++++++++++++++=
+
> >   5 files changed, 779 insertions(+), 4 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-th=
ermal.yaml
> >   create mode 100644 drivers/thermal/sun8i_thermal.c
> > ---
> > v5:
> > -add more support
> > -some trival fix
> > ---
> > 2.17.1
> >
> >
