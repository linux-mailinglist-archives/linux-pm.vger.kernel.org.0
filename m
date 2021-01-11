Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089C12F19EE
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 16:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbhAKPnv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 10:43:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730056AbhAKPnv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 10:43:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDFDA22A84;
        Mon, 11 Jan 2021 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610379790;
        bh=RonP8ve3WthsTBKKQ/UytIvBztNvyV5RjN0+msXV9nY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EgsgZofnCOPBEefh+/TPgHC68i8JC3CVERGqmBI3ncBGYet9Hw0TLEERVXD5wXkFY
         duwV+IlNESa3Ygu7m9Och5ei/39fVUxOP1DGtZZcIocRggogvyMbWDrRCs8qDXDFqF
         ZrpTMQZYIY2OyI59+EGg7GincB9gN4EDdo5dp8Po2xmV8LVY3GCEBZkufC3KXpDH3I
         nP4xQentOyqNwkv75+pbdoYPmDdFoCnA8O3d4B09a8t3lz/Mntl7kXYBSuFl0utk2N
         3sPoTstRVpQRLjFTajeRCn/9iyiXEV60W6jZy8J88GxPk52xZZz+kMJYLeJUnKgkLd
         TScPvN2llX70Q==
Received: by mail-ej1-f53.google.com with SMTP id x16so222562ejj.7;
        Mon, 11 Jan 2021 07:43:09 -0800 (PST)
X-Gm-Message-State: AOAM530SUQTP+nBkv24FVoPIDtuT00pwwr6q0wES4cVCIDE5DXmq3+JG
        xzvYG5002ar4HMlk6qqUKGk3uQoUhaak558IcQ==
X-Google-Smtp-Source: ABdhPJx/jzAlheiwQjfn7BpiqB02i68e/htTzamuYVsQwpyl2HDp4/Rfdpic2s2pRL+gj/DN5FUyq/zWNIoZo3v0HcY=
X-Received: by 2002:a17:906:31cb:: with SMTP id f11mr58560ejf.468.1610379788269;
 Mon, 11 Jan 2021 07:43:08 -0800 (PST)
MIME-Version: 1.0
References: <1610092095-5113-1-git-send-email-henryc.chen@mediatek.com>
 <1610092095-5113-2-git-send-email-henryc.chen@mediatek.com>
 <1610163019.789930.3762037.nullmailer@robh.at.kernel.org> <1610333553.2992.7.camel@mtksdaap41>
In-Reply-To: <1610333553.2992.7.camel@mtksdaap41>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 11 Jan 2021 09:42:54 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+W3UL4-s6ezFJrhUYko2EBPsO9nMOGzGR1nQT3x_VtdQ@mail.gmail.com>
Message-ID: <CAL_Jsq+W3UL4-s6ezFJrhUYko2EBPsO9nMOGzGR1nQT3x_VtdQ@mail.gmail.com>
Subject: Re: [PATCH V7 01/13] dt-bindings: soc: Add dvfsrc driver bindings
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jan 10, 2021 at 8:52 PM Henry Chen <henryc.chen@mediatek.com> wrote:
>
> Hi Rob,
>
> On Fri, 2021-01-08 at 20:30 -0700, Rob Herring wrote:
> > On Fri, 08 Jan 2021 15:48:03 +0800, Henry Chen wrote:
> > > Document the binding for enabling dvfsrc on MediaTek SoC.
> > >
> > > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/soc/mediatek/dvfsrc.yaml   | 67 ++++++++++++++++++++++
> > >  1 file changed, 67 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/soc/mediatek/dvfsrc.example.dts:19:18: fatal error: dt-bindings/interconnect/mtk,mt8183-emi.h: No such file or directory
> >    19 |         #include <dt-bindings/interconnect/mtk,mt8183-emi.h>
> >       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Sorry, because this header file is added on "[V7,07/13] dt-bindings:
> interconnect: add MT8183 interconnect dt-bindings".
> Should I change the order of the patchset (let the yaml pathc behind the
> header) to fixed that ?

DT headers should be part of the binding schema patch. (Or at least come first).

Rob
