Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E512A17D99B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 08:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgCIHLR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 03:11:17 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45355 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgCIHLR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2020 03:11:17 -0400
Received: by mail-vs1-f67.google.com with SMTP id x194so5328452vsc.12
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2020 00:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nT8kP5pUwnT4nLnCd8ohNGxA8f6jkOWq+CENXf41rN8=;
        b=jj49n68ZLbr5lau47GKrIFokW76BtswCcAJCGBsgoecDZxBXC7RBhaaxC75E9kEVMK
         boVSXSOmjfCPd0S6cyfbmLR8l+N+rvfvVEbE4VkjF3R6cpS2o38EBXPECGQ2zh65Noaa
         BmsUwn+ZIRcDgQEdlYy0HL4rRGcy9/4ILQ2IYGFsi2i+8D3R0+OX68UeqwOZJb9xmjrs
         pfMUBDKBvspsJye1IA0q5yeeQIGd/qj2IRUAzPO93gPLILGU2SwzpmC9puBi8PrM4oS+
         4oBRi4nJYI6i3cGG97FLPMY3fom4TkgwGFuoyfHhrxAzzrl96J3YFjWMiNnXANAHm4MU
         vimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nT8kP5pUwnT4nLnCd8ohNGxA8f6jkOWq+CENXf41rN8=;
        b=Ib0K2ePXDaz2BVtfW2rOvXX+3MQSOUZ9jBs+3IutCYujq2eSD2miy7ALgeJ8PdMjsy
         tNWnnPQiB+vObh+M+0QNSe93d4j7YGWHGEfsHIFfXDtBA9Jd5tC5FtSl6zERRggrvjPu
         rQh/htF1nKL/NWpgwRol3FLprAAsDHclzNmP0jARVKCrUe63zYZnlt3RjRt6HFaX9edc
         kmlWN29gJpe3QVvUnmhS2EUHie8Eurmh7ByiZ99tE7RWOylErcX89p8PjFHVDBBZQrok
         VV37S2zBb0XSwIfEynC58RmX1NIorlyTNZQHQAdTFwLx2EYPiY2rbEQHpAbNIPFeYyU3
         l4YA==
X-Gm-Message-State: ANhLgQ1clqbcPGWxdTbM5eboQ+E0xck3NgKamEdZ8ZvFGaQ8IWsDNwUb
        95C13jkWLug1ELK9Q0aKKF6qJyR3DV0LosMoic/vUA==
X-Google-Smtp-Source: ADFU+vvEhKux28Afq7w3NtZUf1yVyALWzvmJdIOTefttBR+Xx/o1VutfGFN9NkAuko1vZs76wUuclul8MlPkP81jstI=
X-Received: by 2002:a67:2ec6:: with SMTP id u189mr4702645vsu.200.1583737876126;
 Mon, 09 Mar 2020 00:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
 <20200303150749.30566-6-ulf.hansson@linaro.org> <20200303170641.GC26191@bogus>
 <CAPDyKFrzy=88fPgesS0_S45rr4SdWthQRcjwnqJzRcMBKCo4=A@mail.gmail.com>
 <20200304145313.GA5144@bogus> <CAL_JsqJNKowN-wbzOSCoARTdfayoq37=OT6mOztS=xmJvuFioQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJNKowN-wbzOSCoARTdfayoq37=OT6mOztS=xmJvuFioQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 9 Mar 2020 08:10:40 +0100
Message-ID: <CAPDyKFp913_yPzTWp-MG5sE2oqBSn_PFuUREiM8jd=8_ryw_tw@mail.gmail.com>
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

On Fri, 6 Mar 2020 at 19:29, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Mar 4, 2020 at 8:53 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Mar 03, 2020 at 09:50:08PM +0100, Ulf Hansson wrote:
> > > On Tue, 3 Mar 2020 at 18:06, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Tue, Mar 03, 2020 at 04:07:47PM +0100, Ulf Hansson wrote:
> > > > > The hierarchical topology with power-domain should be described through
> > > > > child nodes, rather than as currently described in the PSCI root node. Fix
> > > > > this by adding a patternProperties with a corresponding reference to the
> > > > > power-domain DT binding.
> > > > >
> > > > > Additionally, update the example to conform to the new pattern, but also to
> > > > > the adjusted domain-idle-state DT binding.
> > > > >
> > > > > Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
> > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > ---
> > > > >  .../devicetree/bindings/arm/psci.yaml         | 33 +++++++++----------
> > > > >  1 file changed, 15 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> > > > > index 0bc3c43a525a..cae668b61265 100644
> > > > > --- a/Documentation/devicetree/bindings/arm/psci.yaml
> > > > > +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> > > > > @@ -102,11 +102,15 @@ properties:
> > > > >        [1] Kernel documentation - ARM idle states bindings
> > > > >          Documentation/devicetree/bindings/arm/idle-states.yaml
> > > > >
> > > > > -  "#power-domain-cells":
> > > > > -    description:
> > > > > -      The number of cells in a PM domain specifier as per binding in [3].
> > > > > -      Must be 0 as to represent a single PM domain.
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - method
> > > >
> > > > No need to move this.
> > >
> > > Okay.
> > >
> > > >
> > > > >
> > > > > +patternProperties:
> > > > > +  "^(power-controller|power-domain)([@-].*)?$":
> > > > > +    $ref: "../power/power-domain.yaml#"
> > > >
> > > > This has to be under an 'allOf' or the rest of the properties are
> > > > ignored.
> > >
> > > Sure, I had the feeling that something was missing. Thanks for reviewing!
> > >
> > > [...]
> > >
> > > Looks like I should a v2 of the series, or do you prefer to apply some
> > > of the patches before I resend?
> >
> > Applied 1-3. I'll wait for v2 of 4 and 5.
>
> In order to fix all warnings by rc5, I fixed up and applied patches 4 and 5.

Thanks a lot, looks good!

Kind regards
Uffe
