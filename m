Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA43317C56C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 19:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCFS3n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 13:29:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgCFS3n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 13:29:43 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE12620675;
        Fri,  6 Mar 2020 18:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583519381;
        bh=OlONpDeOIWpAtWkyDwrGE484KEkGVMANhv1y9uDe6Q0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M9vQB6j4IuH29Lf3yihA1/EsjAciRVojS2zWsfzTxHZo/lM4jnMggEAvmXl6RUVJI
         NgepqWRXwpKF+iKJAulQrHIU5s8JfyiXzF5sCTPoF9sBhwWcFzdEciYAu9eXgVb4ep
         zEkSQGwf7mJ4tehuVgouyr+krY+RvROxHss2Us2A=
Received: by mail-qk1-f175.google.com with SMTP id f3so3258499qkh.1;
        Fri, 06 Mar 2020 10:29:41 -0800 (PST)
X-Gm-Message-State: ANhLgQ1+qMdhVxAXCwA346/oCIczPHUCj/5QhNGkqmrfhodqEc5IYXEs
        YKykrhHKlyqna47h92mhIQWk3qgjNnmmWMTNCQ==
X-Google-Smtp-Source: ADFU+vuvSgCmNdIo4Vc/u/UHmggYXm29+rU4ejRNLYgy5FQav+zA+HVv5ij8keiUkcfIF8RiCw++jkXG7tlqQlVRmrs=
X-Received: by 2002:a05:620a:12a3:: with SMTP id x3mr4356708qki.254.1583519380984;
 Fri, 06 Mar 2020 10:29:40 -0800 (PST)
MIME-Version: 1.0
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
 <20200303150749.30566-6-ulf.hansson@linaro.org> <20200303170641.GC26191@bogus>
 <CAPDyKFrzy=88fPgesS0_S45rr4SdWthQRcjwnqJzRcMBKCo4=A@mail.gmail.com> <20200304145313.GA5144@bogus>
In-Reply-To: <20200304145313.GA5144@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 6 Mar 2020 12:29:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJNKowN-wbzOSCoARTdfayoq37=OT6mOztS=xmJvuFioQ@mail.gmail.com>
Message-ID: <CAL_JsqJNKowN-wbzOSCoARTdfayoq37=OT6mOztS=xmJvuFioQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] dt-bindings: arm: Fixup the DT bindings for
 hierarchical PSCI states
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Wed, Mar 4, 2020 at 8:53 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Mar 03, 2020 at 09:50:08PM +0100, Ulf Hansson wrote:
> > On Tue, 3 Mar 2020 at 18:06, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, Mar 03, 2020 at 04:07:47PM +0100, Ulf Hansson wrote:
> > > > The hierarchical topology with power-domain should be described through
> > > > child nodes, rather than as currently described in the PSCI root node. Fix
> > > > this by adding a patternProperties with a corresponding reference to the
> > > > power-domain DT binding.
> > > >
> > > > Additionally, update the example to conform to the new pattern, but also to
> > > > the adjusted domain-idle-state DT binding.
> > > >
> > > > Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  .../devicetree/bindings/arm/psci.yaml         | 33 +++++++++----------
> > > >  1 file changed, 15 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> > > > index 0bc3c43a525a..cae668b61265 100644
> > > > --- a/Documentation/devicetree/bindings/arm/psci.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> > > > @@ -102,11 +102,15 @@ properties:
> > > >        [1] Kernel documentation - ARM idle states bindings
> > > >          Documentation/devicetree/bindings/arm/idle-states.yaml
> > > >
> > > > -  "#power-domain-cells":
> > > > -    description:
> > > > -      The number of cells in a PM domain specifier as per binding in [3].
> > > > -      Must be 0 as to represent a single PM domain.
> > > > +required:
> > > > +  - compatible
> > > > +  - method
> > >
> > > No need to move this.
> >
> > Okay.
> >
> > >
> > > >
> > > > +patternProperties:
> > > > +  "^(power-controller|power-domain)([@-].*)?$":
> > > > +    $ref: "../power/power-domain.yaml#"
> > >
> > > This has to be under an 'allOf' or the rest of the properties are
> > > ignored.
> >
> > Sure, I had the feeling that something was missing. Thanks for reviewing!
> >
> > [...]
> >
> > Looks like I should a v2 of the series, or do you prefer to apply some
> > of the patches before I resend?
>
> Applied 1-3. I'll wait for v2 of 4 and 5.

In order to fix all warnings by rc5, I fixed up and applied patches 4 and 5.

Rob
