Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A0F3CCCBB
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jul 2021 05:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhGSDkw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Jul 2021 23:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhGSDku (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Jul 2021 23:40:50 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E558DC061762;
        Sun, 18 Jul 2021 20:37:50 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id c197so19174555oib.11;
        Sun, 18 Jul 2021 20:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AvTNwoF5AZVAHORrZMZQKhvKuBZ19iRiLg9Xw654rGw=;
        b=su3WkGSFSRwJ5ZZEu33QPn45mX8Aseu/Gg1gU5hLkIoR3FRTmyOQuQqgP5o1zsr+S9
         jE1RjEmJT2luR2/NrKdhWsFglh/7CiUPc/qMerZ4wXqNw8U4Xtur9fWD2lD+Uag40GRn
         TkY+MF5YdF6fhjefr328iUf7vNx14vAyAiH3XrC84+mPssRS2x0PNjdhvi1DPLrj8DTq
         M0nB0yf/6DDxa6MSFtb2x5HfrbOZERuRkaC9Pkt6yfrXi5HciBZa/PCYFrn7vBJqlQ2t
         8xNKug/95hSz6lGyTNIo/nDVM+q4XqU3OLDtjqbLDb4iEQhdaZhMl/EoUQFHaHIBAjMs
         cUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AvTNwoF5AZVAHORrZMZQKhvKuBZ19iRiLg9Xw654rGw=;
        b=qqzEltEEq9X755gcqgpbISzoPKUWRBSesYye88l2avDg5G8WqtqKwMh62ynsej/Eow
         4krdY8nqPF1aJFmX2xmokBNf9GfZMItXhbDZ4X9xg/lGiX3MvJ1tD++4cdW80rMV0BzV
         X9uHy4j7mxVXTLgNj7kD5Q+vdJ1rSMOjw2xcDOcheu4cRW6bD6EiZ2ob5yse57JGTmvw
         EwSWPzow014LXc5AsBBgCRZKttzd98D115x049S1qpK11522Ifm9SjMk+HVJmr50JorG
         mY4U8aHM4MAl7WIzvuskLNm3VXRufKaBCERlqe2O1RxqyX1lhBG3nwzpKIqX5CFeDezM
         PrLA==
X-Gm-Message-State: AOAM533OixysQd2BwPoHuVeFcIXSJp9xrmA2V1hZbDfu2nHi8gqYuxUQ
        fddYtZjcqsC4BM/4pUlpjPxW2YMZmppDjColPVg=
X-Google-Smtp-Source: ABdhPJz7C3w8ThcmqrcxQqG7kpkXeowK12zcUDhuE9v+IVNUF/SCIzmagsLzCRRRCeXcSPBtnhCLiZ1kSpdZbTiSu2k=
X-Received: by 2002:aca:3786:: with SMTP id e128mr5904176oia.55.1626665870299;
 Sun, 18 Jul 2021 20:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210716094353.140536-1-gene.chen.richtek@gmail.com> <a01521d3-bd79-a813-554a-39a750775938@infradead.org>
In-Reply-To: <a01521d3-bd79-a813-554a-39a750775938@infradead.org>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 19 Jul 2021 11:37:39 +0800
Message-ID: <CAE+NS37K99ebPbFSk_3XgCbRwr6K8u+VcLMcxG5ag6dH861WAg@mail.gmail.com>
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

ACK, I will fix it and resend the patches.
