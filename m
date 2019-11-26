Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B85C710A49E
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 20:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKZTfz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 14:35:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34686 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfKZTfz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 14:35:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id w11so17006733ote.1;
        Tue, 26 Nov 2019 11:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HT2M1Xfv+tvpjG1ucYQkF2fvfzcdx/n3wzuhyYktctM=;
        b=JOLm1AXku5RalOJtjRieB/kQKtK0udRdscDeEXxH1KAHd/fYWGsjz4xkUcLdpDNU4L
         3LF5fe0fVVNNP+dspxrYrGnLoyux4FgkHnDl0YpGt74hEHT9r9fZ5SLTycjn5+fy07Lk
         uq/Bkwg4bYsgKll9SLSzdzC1rkiciuWzGekJqBGenTIabcP8aqXBMUgPtuU1zOvRo6Iy
         jg/61mts1Vg1P41pVsgPAVb+vVUfGFy+4WeI0e+EFwSdLoATYfQHsd+3/aR5alvw3+XX
         Q0NpGmPM1EXKaiGqf9+ZtKOC735yL/I9wWudIFHWCSHwQqgLZhGZ1Y7V1blYW8MXGocZ
         ZPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=HT2M1Xfv+tvpjG1ucYQkF2fvfzcdx/n3wzuhyYktctM=;
        b=cVuTbMj6s67HZHDKOvZ76HuKR08hMMA5nezvzq1WGi29TVQw4Oj3eHwt2M0fBQpzFJ
         15Lh2WDo/BikQrft/s/ifq9qNB//50P/k5+POgpnAI/QWhkGbNkXgokB4sttgWStAnjO
         53EFVJlJu4HzWWqYIiUeCiqgKKjTzOTMztFqgZ0IUiySJL4ahrJXuqelSYv1P8BTyQof
         GGLx7fCOZBJMHAfct/fWNSJR4wPHQFb5FwCccy3SKWAIDE3TpWGrY8fEHV7V7qWl0lsM
         xaQrmvQPR+OndBGsIhTTut4Tfhrux4k7MPckWRf0+62il9zpZaaYF5LZ7tmIYqQ6kK9A
         Cndg==
X-Gm-Message-State: APjAAAU19FacvlrlpALAxZwA1A2D9HdYrgoG4qNqIc0sL/sRNy2iPh2Q
        bRKnPneV1sYqmHxk8SK9OEWOu6mUK1DBsrnQaN8=
X-Google-Smtp-Source: APXvYqxwy2YH1zXRvoLZhDl2LwHUaPWwfU4ZwllfPWEY5VmEMkXSvMDIFkZLaOj3kJ+NneohsrgZgOhpJ7pdvQg1LaY=
X-Received: by 2002:a9d:64ce:: with SMTP id n14mr472946otl.263.1574796954091;
 Tue, 26 Nov 2019 11:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20190810052829.6032-1-tiny.windzz@gmail.com> <20190901215214.f4vbxemdd7mf3gun@core.my.home>
 <20190902072735.zkrueocyz4glc26n@flea> <20190902105816.zurkkh2vjfexft7t@core.my.home>
In-Reply-To: <20190902105816.zurkkh2vjfexft7t@core.my.home>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Tue, 26 Nov 2019 11:36:37 -0800
Message-ID: <CA+E=qVdzHGZsazfeZYBA2YZBZv_rSpk7NsV5wbiAFH80cjxajQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] add thermal driver for h6
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Yangtao Li <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 2, 2019 at 3:58 AM Ond=C5=99ej Jirman <megous@megous.com> wrote=
:
>
> Hello Maxime,
>
> On Mon, Sep 02, 2019 at 09:27:35AM +0200, Maxime Ripard wrote:
> > Hi,
> >
> > On Sun, Sep 01, 2019 at 11:52:14PM +0200, Ond=C5=99ej Jirman wrote:
> > > Hello Yangtao,
> > >
> > > On Sat, Aug 10, 2019 at 05:28:11AM +0000, Yangtao Li wrote:
> > > > This patchset add support for A64, H3, H5, H6 and R40 thermal senso=
r.
> > > >
> > > > Thx to Icenowy and Vasily.
> > > >
> > > > BTY, do a cleanup in thermal makfile.

Hey Yangtao,

Are there any plans for v6?

Regards,
Vasily

> > > I've added support for A83T and also some cleanups, according to my
> > > feedback:
> > >
> > > https://megous.com/git/linux/log/?h=3Dths-5.3
> > >
> > > Feel free to pick up whatever you like from that tree.
> > >
> > > For others, there are also DTS patches in that tree for H3, H5, A83T,=
 and H6, so
> > > that shoul make testing of this driver easier.
> >
> > I'm not convinced that always expanding the number of SoC supported is
> > the best strategy to get this merged. Usually, keeping the same
> > feature set across version, consolidating that, and then once it's in
> > sending the new SoC support works best.
>
> That's fine and all, but I've mostly added DT descriptions for already su=
pported
> SoCs and fixed bugs in the driver, so that people can actually test the e=
xisting
> driver.
>
> I think adding DT changes will actually help get needed exposure for this
> patch series.
>
> A83T support that I added, was actually just a small change to the driver=
.
>
> regards,
>         o.
>
> > Maxime
> >
> > --
> > Maxime Ripard, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
