Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D754821F402
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 16:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgGNO0e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 10:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgGNO0e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jul 2020 10:26:34 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A2C822516;
        Tue, 14 Jul 2020 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594736793;
        bh=S3wLIXMLvW4hWE0k9kaLD27dt6WY9VJU7X1n3XEPPEI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GZKQS7l+v7huDhLmjre/t0kJSh4fLGZXnxIGOz8xnJYJsjKtyUc3hg5uM5w4/uSTP
         eyUoZi4km+sze9KRrIiGzk3/vjRqI9Ua4hd4CkgZLG2dq/ro+daGh4CPuw3k+NpK/O
         P8JmTQXzjye8F4gLH+1Dg+XqZUrpxVWAD+3q5kqo=
Received: by mail-ot1-f49.google.com with SMTP id 18so13148114otv.6;
        Tue, 14 Jul 2020 07:26:33 -0700 (PDT)
X-Gm-Message-State: AOAM531LpGbzxpDkZ3ZfpPwjK2EGXeFKmxQ2ATumZA/cyKRyAyvjiSL3
        okCXaYxYZ1pmNeEL3oprheCk/8QhDxfhktJG0g==
X-Google-Smtp-Source: ABdhPJyuvjA8JGPnMGdzGxe+pkPemV2r5WuflfIGWMOBeMYBaIts3muiUvAU/L9AW1tNJurH/prAJoPR1eJXtPrSD+o=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr4051084otb.107.1594736792668;
 Tue, 14 Jul 2020 07:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200709215136.28044-1-ansuelsmth@gmail.com> <20200709215136.28044-4-ansuelsmth@gmail.com>
 <20200710162657.GB2743639@bogus> <0ef601d656f5$b9f8e0c0$2deaa240$@gmail.com>
In-Reply-To: <0ef601d656f5$b9f8e0c0$2deaa240$@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Jul 2020 08:26:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ8C_YJFiTSKCGqJoySKFJThZXQuQg9eLQE33yL_6v3pA@mail.gmail.com>
Message-ID: <CAL_JsqJ8C_YJFiTSKCGqJoySKFJThZXQuQg9eLQE33yL_6v3pA@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: thermal: tsens: document ipq8064 bindings
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 2:07 PM <ansuelsmth@gmail.com> wrote:
>
>
>
> > -----Messaggio originale-----
> > Da: Rob Herring <robh@kernel.org>
> > Inviato: venerd=C3=AC 10 luglio 2020 18:27
> > A: Ansuel Smith <ansuelsmth@gmail.com>
> > Cc: Amit Kucheria <amit.kucheria@linaro.org>; Andy Gross
> > <agross@kernel.org>; Bjorn Andersson <bjorn.andersson@linaro.org>;
> > Zhang Rui <rui.zhang@intel.com>; Daniel Lezcano
> > <daniel.lezcano@linaro.org>; linux-pm@vger.kernel.org; linux-arm-
> > msm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Oggetto: Re: [PATCH 3/6] dt-bindings: thermal: tsens: document ipq8064
> > bindings
> >
> > On Thu, Jul 09, 2020 at 11:51:33PM +0200, Ansuel Smith wrote:
> > > Document the use of regmap phandle for ipq8064 SoCs
> > >
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  .../bindings/thermal/qcom-tsens.yaml          | 51 ++++++++++++++++-=
--
> > >  1 file changed, 44 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yam=
l
> > b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > > index d7be931b42d2..5ceb5d720e16 100644
> > > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > > @@ -24,6 +24,7 @@ properties:
> > >            - enum:
> > >                - qcom,msm8916-tsens
> > >                - qcom,msm8974-tsens
> > > +              - qcom,ipq8064-tsens
> > >            - const: qcom,tsens-v0_1
> > >
> > >        - description: v1 of TSENS
> > > @@ -47,6 +48,11 @@ properties:
> > >        - description: TM registers
> > >        - description: SROT registers
> > >
> > > +  regmap:
> > > +    description:
> > > +      Phandle to the gcc. On ipq8064 SoCs gcc and tsense share the s=
ame
> > regs.
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> >
> > Can't you make this a child of the gcc and drop this property?
> >
>
> Make the thermal a child of the gcc would be a little confusing. Anyway
> making this
> a child of gcc cause the not probing of the thermal driver as it's ignore=
d
> any child of
> gcc. I pushed v2 with the fixed problem.

Structure the DT as the h/w is structured, not what's convenient for the OS=
.

Either the GCC driver has to call of_platform_populate on the child
nodes or you can perhaps use 'simple-mfd'.

Rob
