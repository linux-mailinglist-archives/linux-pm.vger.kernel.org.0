Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915D91792C2
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 15:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCDOxQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 09:53:16 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35249 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDOxQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 09:53:16 -0500
Received: by mail-oi1-f194.google.com with SMTP id c1so2361128oiy.2;
        Wed, 04 Mar 2020 06:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wWNZFP6/iHI5zwSuapXSuHRqaFrcN8o+uRdRQNE6Nug=;
        b=Gy8WzhUtrBaYDrgeGZzTU7rwUuQDcqTOFQR9Om9YE9GwvWi+TOteiG0ZI+a2L7ZykF
         4y3LessDQvtoK6pwSjHpIBGeDawfLmdJibM2a39xLPKnRASC4csQGg88wmIGa5eRUEuw
         D9x3DIFAi8SaQqt/H+f2DO2biGba3g9aUXZAeyVYYxtIi8EzWR+gF7Firg/iS23aC3HU
         BWKZ1ZlGH808HIY4H5sHFRqOw2Mhk8iOXkt5BUbDJuhCGh7Tn1Q3o/K7Ok/d7GFyGZ1I
         miPoJtduPJagGCLCHaPmr+yLxdRe6dlyMsyB5XkgEhqSNlb3xUCRIIfDGkpeE6kA1pJP
         2Gxw==
X-Gm-Message-State: ANhLgQ2rqqlwzZMRFAo0snupWKIDQ7wBPw6Dh1vancZcneJbvm5YYDC+
        mWkW+6DB13DhZVA5cSV//w==
X-Google-Smtp-Source: ADFU+vvKzwypp2GuEEpFsHUpxfgMYMkh8H1PZfC99qYfauXsjPgXUgqA1o3iAvtOokU+XCndhZucXQ==
X-Received: by 2002:a54:4099:: with SMTP id i25mr2045874oii.129.1583333595329;
        Wed, 04 Mar 2020 06:53:15 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t21sm6032597otk.13.2020.03.04.06.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 06:53:14 -0800 (PST)
Received: (nullmailer pid 7126 invoked by uid 1000);
        Wed, 04 Mar 2020 14:53:14 -0000
Date:   Wed, 4 Mar 2020 08:53:14 -0600
From:   Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH 5/7] dt-bindings: arm: Fixup the DT bindings for
 hierarchical PSCI states
Message-ID: <20200304145313.GA5144@bogus>
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
 <20200303150749.30566-6-ulf.hansson@linaro.org>
 <20200303170641.GC26191@bogus>
 <CAPDyKFrzy=88fPgesS0_S45rr4SdWthQRcjwnqJzRcMBKCo4=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrzy=88fPgesS0_S45rr4SdWthQRcjwnqJzRcMBKCo4=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 03, 2020 at 09:50:08PM +0100, Ulf Hansson wrote:
> On Tue, 3 Mar 2020 at 18:06, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Mar 03, 2020 at 04:07:47PM +0100, Ulf Hansson wrote:
> > > The hierarchical topology with power-domain should be described through
> > > child nodes, rather than as currently described in the PSCI root node. Fix
> > > this by adding a patternProperties with a corresponding reference to the
> > > power-domain DT binding.
> > >
> > > Additionally, update the example to conform to the new pattern, but also to
> > > the adjusted domain-idle-state DT binding.
> > >
> > > Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  .../devicetree/bindings/arm/psci.yaml         | 33 +++++++++----------
> > >  1 file changed, 15 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> > > index 0bc3c43a525a..cae668b61265 100644
> > > --- a/Documentation/devicetree/bindings/arm/psci.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> > > @@ -102,11 +102,15 @@ properties:
> > >        [1] Kernel documentation - ARM idle states bindings
> > >          Documentation/devicetree/bindings/arm/idle-states.yaml
> > >
> > > -  "#power-domain-cells":
> > > -    description:
> > > -      The number of cells in a PM domain specifier as per binding in [3].
> > > -      Must be 0 as to represent a single PM domain.
> > > +required:
> > > +  - compatible
> > > +  - method
> >
> > No need to move this.
> 
> Okay.
> 
> >
> > >
> > > +patternProperties:
> > > +  "^(power-controller|power-domain)([@-].*)?$":
> > > +    $ref: "../power/power-domain.yaml#"
> >
> > This has to be under an 'allOf' or the rest of the properties are
> > ignored.
> 
> Sure, I had the feeling that something was missing. Thanks for reviewing!
> 
> [...]
> 
> Looks like I should a v2 of the series, or do you prefer to apply some
> of the patches before I resend?

Applied 1-3. I'll wait for v2 of 4 and 5.

Rob
