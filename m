Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB03178444
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 21:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbgCCUr0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 15:47:26 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37543 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbgCCUr0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 15:47:26 -0500
Received: by mail-vk1-f196.google.com with SMTP id t192so12817vkb.4
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 12:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8LzC1FkDwsheob6ti11k957HeWZgskHzijDc9F3t1w=;
        b=iTZkdrGA7NLhytKTFhNkpSopPcJQivDis2tK/K84C2BmU7f//AGarD3Oi4ul4ZA5p2
         7ovMAz3duyVE7c7Gv9VYoR3nLxlVYWx4rLEXsVN6WEQivNege4qeNkPtMcAlLt76rsWq
         Sinub/FqaZUGTX7YrfSxoqY9xjrIuQ2ylwK2Ohy8yi57pBWR94i6Ve/S0VZ5O8r1AekV
         VNQBsdRAjRQoyvR3/N/mMB+VTBIWZpZm/vQA3UOfuXMwRP146yoUc9A+iJ8H80IJ4sZI
         tdqKkxfsSVRdT0cgM7rQ7gytnqS22pY9sB8LGDZRbK1CwwGcRn3E7ApDCfhnm4bvqcm6
         Mz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8LzC1FkDwsheob6ti11k957HeWZgskHzijDc9F3t1w=;
        b=cHNe53/ZtZ5tO5kCd6u2u5pZWaLu7bvzMwCgYFfhpa8uhEV8vaegJU2BGF2WnGBOiI
         S8VlGCE93XIxx14u03QPWLxXXRnh6XN0XCp1FyDH2TcnkFZQofm7OVE4Luq2MNBPKxFl
         N85nIZ0EwuvuW2MbaAU0AGvtpE/Bk1PaT1h9NuW2ruE7/dr89r8yWvjiTRYYz9rkCMzJ
         dLXjuVGQpPUfkU1XIg5a1iPOqhk2F3OMwGiErXRuR9DiDAPC/FLHk68tuXYTlagbi9X1
         0GRCC5INvBcW1PBpD29yECaGGQK7OJRiVAntBxJFzh1yf9Vw1/F120fKA2HSY+qMCzpr
         ambg==
X-Gm-Message-State: ANhLgQ0ESLGi4obAq6zj4h1eBAf/E2bjgY9gCH75+wDsl2TqWPt241gK
        dErkGyeespWkpWYjtcKaXr9N7alIi2lxim0q5KPxpw==
X-Google-Smtp-Source: ADFU+vuERFMpkWbnyw88Lrbiz3fboR9TvgiMmam5QelmxN9WhhxeUBTbt3kTGF03KMhQ35qpLPhxK03B5kLIBCnDqzw=
X-Received: by 2002:ac5:c844:: with SMTP id g4mr3978713vkm.25.1583268443466;
 Tue, 03 Mar 2020 12:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
 <20200303150749.30566-5-ulf.hansson@linaro.org> <20200303170348.GB26191@bogus>
In-Reply-To: <20200303170348.GB26191@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Mar 2020 21:46:47 +0100
Message-ID: <CAPDyKFpcpjaouXeFOm+Fj+9x7KeaRyBYLY+5oDVLYnmkV93hTg@mail.gmail.com>
Subject: Re: [PATCH 4/7] dt-bindings: power: Extend nodename pattern for
 power-domain providers
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

On Tue, 3 Mar 2020 at 18:04, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Mar 03, 2020 at 04:07:46PM +0100, Ulf Hansson wrote:
> > The existing binding requires the nodename to have a '@', which is a bit
> > limiting for the wider use case. Therefore, let's extend the pattern to
> > allow either '@' or '-'.
>
> That's fine, but...
>
> > Additionally, let's update one of the examples to show how the updated
> > pattern could be used.
> >
> > Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/power/power-domain.yaml | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
> > index 207e63ae10f9..dc232759013e 100644
> > --- a/Documentation/devicetree/bindings/power/power-domain.yaml
> > +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
> > @@ -25,7 +25,7 @@ description: |+
> >
> >  properties:
> >    $nodename:
> > -    pattern: "^(power-controller|power-domain)(@.*)?$"
> > +    pattern: "^(power-controller|power-domain)([@-].*)?$"
> >
> >    domain-idle-states:
> >      $ref: /schemas/types.yaml#/definitions/phandle-array
> > @@ -71,13 +71,13 @@ required:
> >
> >  examples:
> >    - |
> > -    power: power-controller@12340000 {
> > -        compatible = "foo,power-controller";
> > +    power: power-domain-foo {
> > +        compatible = "foo,power-domain";
> >          reg = <0x12340000 0x1000>;
>
> When you have 'reg' you should have a unit-address.

Yes, of course, thanks!

[...]

Kind regards
Uffe
