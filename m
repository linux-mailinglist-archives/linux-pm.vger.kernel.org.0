Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF95717844E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 21:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbgCCUuq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 15:50:46 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36078 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbgCCUup (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 15:50:45 -0500
Received: by mail-ua1-f68.google.com with SMTP id y3so1695414uae.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 12:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XD3hDQ0araAq5zv8njvI5qg6v85AS493J1Kabe5n9XU=;
        b=WQs8CSKCVyivgzPN2r8nm7npkTrOFE4qfJa67otUlcSCrwaKSlDrF3gGH8TEf+fF84
         v/9skIV1L0DMfuSSIQZjLFKzht8F/ZGa+MgsCy08Bx+vWOgIqBpxJ/PDPdFuev8VqNyA
         h41lMLtPkCTJOhtkGYI7uguOfjiLVSYgoZMlkhibAvlNRLKb6mtXn/YHo9rJuDgJ+Uny
         i00XJnN1ZkX4aEaM8574pbADLLmr065IX3iexNFRyOCjEx8Hq1B13jzs7IFm8K61v/Oj
         6ZXxP3hlFdm4pJYpgHUOC5+zIERiPT/vE9AGPanw3vpwqL5GPZDR4HF/ypGuwGF88vIc
         R8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XD3hDQ0araAq5zv8njvI5qg6v85AS493J1Kabe5n9XU=;
        b=T8L6kLmsZjE/vmg+lk4b2EJrHcwwAKmSIGLA3xR9ydHD4EGPz2qmJiWn44rkxWg6xP
         bRyNUeS17lWcU0JBx0ehvoBPGm29MX91NaKVg1FxIyBuhXuS6Gfz7IVxjfAsGuElRt+Q
         YQ/MT4rcGgyB0y3fAdVSaAzXdEscYytJOXSjvhfVzMtHoWVbb928hZwyqczndURoVKJS
         TTQ9B74b2p/Orvp397zbXP8U1+4JE1Ttu0FIPfdtCQ0Lr5UAJnpGy+YHMoPN/muOSccB
         WxuJlTZohcnaJLAq2VJECBJ7HWy0iqgSXnAAHb9CSbyshqidcWpi1uv7ecLDsjnryrxL
         uFvA==
X-Gm-Message-State: ANhLgQ3tbGIk2AIkzRsBGrPfU3hU0x0WksC/wABMff50IGsrr+OKAntj
        HLAguWzCOvAvRd+C9FDieBodIDT7dmD7WZDVS25XFA==
X-Google-Smtp-Source: ADFU+vuNcnNmh6x5IJ5M2yTWp4kLMylcBxLsMM68UQIba35vDPyCmNWmxoJ2HjjVcEPSIT6lr5mW0JrpuYGpEQbi/z0=
X-Received: by 2002:ab0:7802:: with SMTP id x2mr3988409uaq.100.1583268644577;
 Tue, 03 Mar 2020 12:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
 <20200303150749.30566-6-ulf.hansson@linaro.org> <20200303170641.GC26191@bogus>
In-Reply-To: <20200303170641.GC26191@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Mar 2020 21:50:08 +0100
Message-ID: <CAPDyKFrzy=88fPgesS0_S45rr4SdWthQRcjwnqJzRcMBKCo4=A@mail.gmail.com>
Subject: Re: [PATCH 5/7] dt-bindings: arm: Fixup the DT bindings for
 hierarchical PSCI states
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 3 Mar 2020 at 18:06, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Mar 03, 2020 at 04:07:47PM +0100, Ulf Hansson wrote:
> > The hierarchical topology with power-domain should be described through
> > child nodes, rather than as currently described in the PSCI root node. Fix
> > this by adding a patternProperties with a corresponding reference to the
> > power-domain DT binding.
> >
> > Additionally, update the example to conform to the new pattern, but also to
> > the adjusted domain-idle-state DT binding.
> >
> > Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  .../devicetree/bindings/arm/psci.yaml         | 33 +++++++++----------
> >  1 file changed, 15 insertions(+), 18 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> > index 0bc3c43a525a..cae668b61265 100644
> > --- a/Documentation/devicetree/bindings/arm/psci.yaml
> > +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> > @@ -102,11 +102,15 @@ properties:
> >        [1] Kernel documentation - ARM idle states bindings
> >          Documentation/devicetree/bindings/arm/idle-states.yaml
> >
> > -  "#power-domain-cells":
> > -    description:
> > -      The number of cells in a PM domain specifier as per binding in [3].
> > -      Must be 0 as to represent a single PM domain.
> > +required:
> > +  - compatible
> > +  - method
>
> No need to move this.

Okay.

>
> >
> > +patternProperties:
> > +  "^(power-controller|power-domain)([@-].*)?$":
> > +    $ref: "../power/power-domain.yaml#"
>
> This has to be under an 'allOf' or the rest of the properties are
> ignored.

Sure, I had the feeling that something was missing. Thanks for reviewing!

[...]

Looks like I should a v2 of the series, or do you prefer to apply some
of the patches before I resend?

Kind regards
Uffe
