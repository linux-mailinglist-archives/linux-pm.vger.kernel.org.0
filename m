Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6036E90A8
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 21:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfJ2UQZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 16:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJ2UQZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Oct 2019 16:16:25 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF96C21721;
        Tue, 29 Oct 2019 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572380183;
        bh=mzrl9420Ovx3lQJ1vhZxCQsXwonFelXckxIqNI5fnYU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bzs0JsLJXxLNGTSfA3dRdgUWooXO3sHsJpKlHKkRlMTj+DU4za3swy8FwTd63nH1z
         jsd9x+mUuzHXUv1o3wCebCtqHdnF3TdZ/fDF0CM+U5Rs1eaAApmFcCRl7K5eZgUl+y
         rQpDDkwkkAcchWbuljHc9iSYc4QMzr13Adf6Vj7s=
Received: by mail-qt1-f169.google.com with SMTP id x21so4981511qto.12;
        Tue, 29 Oct 2019 13:16:23 -0700 (PDT)
X-Gm-Message-State: APjAAAXciRC8z1znzvw+ESjsoiFgvNJl81T3c2+OS07yuqiJh2vasOvg
        QpcknAZj4aVAyAb6tun/T8Jhd98lN+PiJGpRWA==
X-Google-Smtp-Source: APXvYqw2bPo/mXUkmXIpei4kFmXMxOacUC63F3raNseUkPz2342X9y6B6fHT0p2dhZ4pVJPYLGheLckku0HHO05Qz90=
X-Received: by 2002:ac8:741a:: with SMTP id p26mr1062486qtq.143.1572380182705;
 Tue, 29 Oct 2019 13:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-7-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFqcKfmnNJ7j4Jb+JH739FBcHg5NBD6aR4H_N=zWGwm1ww@mail.gmail.com>
 <5DA88892.5000408@linaro.org> <CAPDyKFpYG7YADb6Xmm=8ug5=5X3d1y+JdkRvrnvtroeV3Yj62Q@mail.gmail.com>
 <5DA89267.30806@linaro.org> <20191029013648.GB27045@bogus> <CAPDyKFpiyvGg0+bXDVCbfr+yW0SOH6DhVgAiav8ZnE8TSF6EHQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpiyvGg0+bXDVCbfr+yW0SOH6DhVgAiav8ZnE8TSF6EHQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Oct 2019 15:16:11 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+OoyC5FZxYrX_KN1QLDXRvKuFbH=9pLiELsOtoPixnPA@mail.gmail.com>
Message-ID: <CAL_Jsq+OoyC5FZxYrX_KN1QLDXRvKuFbH=9pLiELsOtoPixnPA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] dt-bindings: soc: qcom: Extend RPMh power
 controller binding to describe thermal warming device
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 29, 2019 at 5:07 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 29 Oct 2019 at 02:36, Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Oct 17, 2019 at 12:10:15PM -0400, Thara Gopinath wrote:
> > > On 10/17/2019 11:43 AM, Ulf Hansson wrote:
> > > > On Thu, 17 Oct 2019 at 17:28, Thara Gopinath <thara.gopinath@linaro.org> wrote:
> > > >>
> > > >> Hello Ulf,
> > > >> Thanks for the review!
> > > >>
> > > >> On 10/17/2019 05:04 AM, Ulf Hansson wrote:
> > > >>> On Wed, 16 Oct 2019 at 21:37, Thara Gopinath <thara.gopinath@linaro.org> wrote:
> > > >>>>
> > > >>>> RPMh power controller hosts mx domain that can be used as thermal
> > > >>>> warming device. Add a sub-node to specify this.
> > > >>>>
> > > >>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > > >>>> ---
> > > >>>>  Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 10 ++++++++++
> > > >>>>  1 file changed, 10 insertions(+)
> > > >>>>
> > > >>>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> > > >>>> index eb35b22..fff695d 100644
> > > >>>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> > > >>>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> > > >>>> @@ -18,6 +18,16 @@ Required Properties:
> > > >>>>  Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
> > > >>>>  various OPPs for different platforms as well as Power domain indexes
> > > >>>>
> > > >>>> += SUBNODES
> > > >>>> +RPMh alsp hosts power domains that can behave as thermal warming device.
> > > >>>> +These are expressed as subnodes of the RPMh. The name of the node is used
> > > >>>> +to identify the power domain and must therefor be "mx".
> > > >>>> +
> > > >>>> +- #cooling-cells:
> > > >>>> +       Usage: optional
> > > >>>> +       Value type: <u32>
> > > >>>> +       Definition: must be 2
> > > >>>> +
> > > >>>
> > > >>> Just wanted to express a minor thought about this. In general we use
> > > >>> subnodes of PM domain providers to represent the topology of PM
> > > >>> domains (subdomains), this is something different, which I guess is
> > > >>> fine.
> > > >>>
> > > >>> I assume the #cooling-cells is here tells us this is not a PM domain
> > > >>> provider, but a "cooling device provider"?
> > > >> Yep.
> > > >>>
> > > >>> Also, I wonder if it would be fine to specify "power-domains" here,
> > > >>> rather than using "name" as I think that is kind of awkward!?
> > > >> Do you mean "power-domain-names" ? I am using this to match against the
> > > >> genpd names defined in the provider driver.
> > > >
> > > > No. If you are using "power-domains" it means that you allow to
> > > > describe the specifier for the provider.
> > > Yep. But won't this look funny in DT ? The provider node will have a sub
> > > node with a power domain referencing to itself Like below: Is this ok ?
> > >
> > > rpmhpd: power-controller {
> > >                                 compatible = "qcom,sdm845-rpmhpd";
> > >                                 #power-domain-cells = <1>;
> > >
> > >                       ...
> > >                       ...
> > >                               mx_cdev: mx {
> > >                                         #cooling-cells = <2>;
> > >                                         power-domains = <&rpmhpd      SDM845_MX>;
> > >                                 };
> > >
> >
> > The whole concept here seems all wrong to me. Isn't it what's in the
> > power domain that's the cooling device. A CPU power domain is not a
> > cooling device, the CPU is. Or we wouldn't make a clock a cooling
> > device, but what the clock drives.
>
> Well, I don't think that's entirely correct description either.
>
> As I see it, it's really the actual PM domain (that manages voltages
> for a power island), that needs to stay in full power state and
> increase its voltage level, as to warm up some of the silicon. It's
> not a regular device, but more a characteristics of how the PM domain
> can be used.

First I've heard of Si needing warming...

I think I'd just expect the power domain provider to know which
domains to power on then.

Rob
