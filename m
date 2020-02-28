Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3F717335A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 09:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgB1Izb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 03:55:31 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38583 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgB1Iza (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 03:55:30 -0500
Received: by mail-ua1-f65.google.com with SMTP id c7so701363uaf.5
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2020 00:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yG3mf6LB9a/9xK+auG2ENhJV3nByoLN3L6ABYDFphIE=;
        b=cYfmVt6G2PkgbuStmNktcBKViFfntND+jPOtOsqUXukLVEBRGX4y1OUq+glYisQEDf
         sXKxSiTKnmkLeM+yBhuUBoA3/fqRn08UAE7ESPLPlx0LuLvIbP2DYluC5ksh539ydIpl
         WRBNSpsEJU96iOGSbtD/ZtYNLvZ6mWnP5iRl2GUXKoL47Ju6blYAx4snrQJc5hmAcwjn
         N687kT6PtdGloHVsu4UruYooQAfp4T9e1/BNg7K4ALDDWCVedUjFiRsCXE4wcWexzKS5
         lwP91z0KhiopN2re9zUX6bTQy5emckn1llNCG2yFSn/SDsYQQIz0W35bHdhApWTUmtxQ
         tDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yG3mf6LB9a/9xK+auG2ENhJV3nByoLN3L6ABYDFphIE=;
        b=BbMYbX1sQ3tJyHZXD3LMHunbdiSfK7TjURxleb144nfnmU6ZzgJsfehkZRWW9dTHqa
         g9EwP4pPEOD0AmGrzoDBv8XkwAeBaJdZXvq0BCjDW3yi5Rnvbxls1x3YNDEAACYGECLC
         u0EIzXeGSM3feo8HjJcXCayPoorFjfC11KrMM/3ygtMa/Tl77Ez7tntJ43V6TPHmAoWp
         acpP+fR3hSZWOajq0hxHYWPmiaBvYp1L2I6xuEME5bJ18VefLtVBjufGOIfD0TDwZT1X
         3G9A7ExTN1cngKwpX+jl6txi5MMLEdg0gx6bD1fIK9Nrt1WavMQrOXG8W/L7UNRLSDQz
         4H0w==
X-Gm-Message-State: ANhLgQ2ytB6DfqYoGNeLZhOvaQD7dSYb8r7IQlT8gRrsSOoA0rg7MbH/
        3qyO9jcOc7Qcaw5QDUcIU4pEJmXJ/LgduQCHraRhVA==
X-Google-Smtp-Source: ADFU+vsLztMWpfaKINtTsKF68z+sMLM4PaaIv6oFTVvgFaKU7aareFJM7t6ZDu97PwZJduqdizT78uxAIc6c2M5WIBk=
X-Received: by 2002:ab0:2758:: with SMTP id c24mr501689uap.94.1582880129628;
 Fri, 28 Feb 2020 00:55:29 -0800 (PST)
MIME-Version: 1.0
References: <1582646384-1458-1-git-send-email-okukatla@codeaurora.org>
 <1582646384-1458-4-git-send-email-okukatla@codeaurora.org> <20200227171226.GJ24720@google.com>
In-Reply-To: <20200227171226.GJ24720@google.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 28 Feb 2020 14:25:18 +0530
Message-ID: <CAHLCerPMmEQCTU1+K6p01o+PJ1BAf2244Dze2gVLjLQ+cUxpAQ@mail.gmail.com>
Subject: Re: [V4, 3/3] arm64: dts: sc7180: Add interconnect provider DT nodes
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Odelu Kukatla <okukatla@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        daidavid1@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>, seansw@qti.qualcomm.com,
        Alex Elder <elder@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 27, 2020 at 10:42 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Tue, Feb 25, 2020 at 09:29:44PM +0530, Odelu Kukatla wrote:
> > Add the DT nodes for the network-on-chip interconnect buses found
> > on sc7180-based platforms.
> >
> > Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7180.dtsi | 95 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > index cc5a94f..3e28f34 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>
> v2 had:
>
> +#include <dt-bindings/interconnect/qcom,sc7180.h>
>
> I think we still want that, otherwise some patch that adds an
> interconnect configuration for SC7180 needs to add it (see also
> https://patchwork.kernel.org/patch/11386485/#23187545)

Thanks Matthias. That fixed the build.
