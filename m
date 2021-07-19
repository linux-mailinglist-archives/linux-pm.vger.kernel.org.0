Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BE53CCCB7
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jul 2021 05:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbhGSDkC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Jul 2021 23:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhGSDkC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Jul 2021 23:40:02 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75649C061762;
        Sun, 18 Jul 2021 20:37:02 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id b18-20020a0568303112b02904cf73f54f4bso3297963ots.2;
        Sun, 18 Jul 2021 20:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8+eLQwJG0xHjzA2HdgDG/KvwsZz2/KmvAqN1DaPnEKA=;
        b=rv3Cx9pbv/vLTV9CPR0bg5cnCaG+/S1Yj8gyudMEF4N7xUgTC7BwX5S2/oyX9oWaAT
         4zG4Ykher2mjHmy5TbtRhvnWe0xul4ZRA2kheLSYuYsi+33CGicsJVL3DbX2WT0RBCSE
         HAnHxw0ys6aMdOtLuEW+5xQXyu0d20Gmw170ggzZuTbg280SdmqApU1IARItbkgvHzht
         QkIGz9uQRYKkz1RG4BkHhBYOHCvOrJt9uAMoCwOottenSvkc1S3OmAWtzqRABwJ9iQVV
         bIecFGgpTPGixkL5051Dzd0aoASfvYliW+MGmcceRWN1/NBPTuzkfTSc94PXuWCpGoXK
         Qx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8+eLQwJG0xHjzA2HdgDG/KvwsZz2/KmvAqN1DaPnEKA=;
        b=OJciURDFBH1mGHLaU8QUbPtXb/w+kHgZYAJ2oy5eT0AgfJEmWuROxFYOEI3LTD7BR5
         Eb/arbIFs78MWUksgsJZ0igzmmRx8CmpZJLVRcXfsENaJHcCDgx4a/IV/oBQUIBX6oOq
         G1oXG7Cg7WoRnVS3KL4fRoACnBzmPqzZDXOQFHriV0D0cqZSwiGooKnRFHsUHVEixwGs
         jGsfKz1beBp7SgdvsbBCsOMSQpZzzpMr85W1Pp5+bimP4Z5gQQhG1S35ExTDpRKF5DUt
         rX/iaF0HG4aaIqN6Sk0x0nR0aJ242seodXoegbqYfHyOuPN0LJ9JRSIMe1k+5L98lk/B
         901A==
X-Gm-Message-State: AOAM531+y7/NRc0c6irS286JSN12Du4r6m+Y8e27/0EuMhmKES3e41vy
        LEGhRGqSrsTkFF2Va+n9g0f/khet5KYgGfPF7RI=
X-Google-Smtp-Source: ABdhPJxh/mmSJaUt9HEnlJJ/KeCQ4qoiW+T588VXLP8Og/yBwtdsUkzdfeceh/w5vQ9u7AEfGhtzFLihkHGkf4vg4kc=
X-Received: by 2002:a05:6830:2309:: with SMTP id u9mr17378974ote.327.1626665821654;
 Sun, 18 Jul 2021 20:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210716094353.140536-1-gene.chen.richtek@gmail.com> <a01521d3-bd79-a813-554a-39a750775938@infradead.org>
In-Reply-To: <a01521d3-bd79-a813-554a-39a750775938@infradead.org>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 19 Jul 2021 11:36:50 +0800
Message-ID: <CAE+NS36kV3hMhgxGPWYiwPZYhgrZDJYM1RiP0kGsrV2M5so+oA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] power: supply: mt6360_charger: add MT6360 charger support
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     sre@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        ChiYuan Huang <cy_huang@richtek.com>,
        benjamin.chao@mediatek.com,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8812:29=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 7/16/21 2:43 AM, Gene Chen wrote:
> >
> > This patch series add MT6360 Charger support contains driver and bindin=
g
> > document
> >
> > Gene Chen (3)
> >  lib: add linear range get selector within
> >  dt-bindings: power: Add bindings document for Charger support on MT636=
0 PMIC
> >  power: supply: mt6360_charger: add MT6360 charger support
> >
> >  Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml |  =
 48
> >  drivers/power/supply/Kconfig                                       |  =
 11
> >  drivers/power/supply/Makefile                                      |  =
  1
> >  drivers/power/supply/mt6360_charger.c                              |  =
867 ++++++++++
> >  include/linux/linear_range.h                                       |  =
  2
> >  lib/linear_ranges.c                                                |  =
 31
> >  6 files changed, 960 insertions(+)
> >
>
>
> Hi Gene,
>
> All patches in this series are addressed to "inux-pm@vger.kernel.org" (mi=
ssing leading 'l'),
> so I expect that you should resend the series.
>
> --
> ~Randy
>

ACK, I will resend the patches.
