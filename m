Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2DF8E9924
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 10:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfJ3J2A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 05:28:00 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37379 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfJ3J2A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 05:28:00 -0400
Received: by mail-vk1-f194.google.com with SMTP id u79so316944vke.4
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 02:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MN5/XA2iWTn3JwsaVPfUNETYKLVHfkkM5TGKnq2qWow=;
        b=q4vfihaI5SgnZO1mREK0EE92a2TcRqe5YARf2JUxGWe8b3RCSilUTop4ZV/z3M/1Ia
         weN9ltfEM6u2b4/2t7/tw+Nxzk9cRD14JW13Kz1VeE42C+IfgQ/qD2/hYVUPK3BAQwqG
         tlqjEzGFBCSsTNQ14MgdrT4ebi23gasDFuGezAvuHNHJVgg3LEBNiT6EXtL0homvbZhl
         mio1vgHviIVlTCyvDstI8u54o+OZPUxbYIwR8RMJpDrxPfE5AB+uNioto7r5yR/eGy3p
         WyJYHYunxFfhqU8bWoLWNd6oujzPiq2P6zitBof1M66HTaRyvjAV9LM2oWjqPhZdzTpp
         LUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MN5/XA2iWTn3JwsaVPfUNETYKLVHfkkM5TGKnq2qWow=;
        b=Gtj6pY8uTV/2aGDYa5V+kSOGu+CLDmKbE8gbL9u75s/yEdtMKfYcuNxnO8/E0Jhki2
         P+0wOHduGCSSFqhxHPrzGwlLgGXU0xgQkv9HTLcBwr9L3FaFB400LBm4F+8hp3qSy6hX
         1dLm1X6z2W4ix9DO1ksVhIkRI9CJ08/xX3uJOSfoM+YI/obsbK55eVzD3lSbQIBr5Fc8
         BtxcQon8EvM4T9DBkDh08MueqE80vqlXM6XarYrXw9TwfEYXDZjlitqaAr5B5O+J/emC
         5Lda0cFCiRQCg+wGXuRpT6kCTGVxodjjD9dmuvMVBlwn3nYWKVnyk2/ntZ3H6PxdoZGI
         rTaA==
X-Gm-Message-State: APjAAAUEpDRo74HUVH+Jnc/lY/77GUxzZaMOVysdEnxu0+tWMMzuS3xB
        BGarepEL9Mi0LqRGPLJTofvOGXrzQ9vToXUZxwSsfQ==
X-Google-Smtp-Source: APXvYqzSHup2gFA5wBykiES6RNVVoT6htSpGRNx96Dg7POOVg6LTuWNWzkXHYGZc5adR+GHSe5AntmF9j9UEzqu7mqI=
X-Received: by 2002:a1f:b202:: with SMTP id b2mr14227092vkf.59.1572427678476;
 Wed, 30 Oct 2019 02:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-7-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFqcKfmnNJ7j4Jb+JH739FBcHg5NBD6aR4H_N=zWGwm1ww@mail.gmail.com>
 <5DA88892.5000408@linaro.org> <CAPDyKFpYG7YADb6Xmm=8ug5=5X3d1y+JdkRvrnvtroeV3Yj62Q@mail.gmail.com>
 <5DA89267.30806@linaro.org> <20191029013648.GB27045@bogus>
 <CAPDyKFpiyvGg0+bXDVCbfr+yW0SOH6DhVgAiav8ZnE8TSF6EHQ@mail.gmail.com> <CAL_Jsq+OoyC5FZxYrX_KN1QLDXRvKuFbH=9pLiELsOtoPixnPA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+OoyC5FZxYrX_KN1QLDXRvKuFbH=9pLiELsOtoPixnPA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Oct 2019 10:27:21 +0100
Message-ID: <CAPDyKFrZ9uFt8zqncYTQ-SB6s6LqSRHbwo+Eh_zu57kxj_2eMw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] dt-bindings: soc: qcom: Extend RPMh power
 controller binding to describe thermal warming device
To:     Rob Herring <robh@kernel.org>
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

On Tue, 29 Oct 2019 at 21:16, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Oct 29, 2019 at 5:07 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 29 Oct 2019 at 02:36, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Oct 17, 2019 at 12:10:15PM -0400, Thara Gopinath wrote:
> > > > On 10/17/2019 11:43 AM, Ulf Hansson wrote:
> > > > > On Thu, 17 Oct 2019 at 17:28, Thara Gopinath <thara.gopinath@linaro.org> wrote:
> > > > >>
> > > > >> Hello Ulf,
> > > > >> Thanks for the review!
> > > > >>
> > > > >> On 10/17/2019 05:04 AM, Ulf Hansson wrote:
> > > > >>> On Wed, 16 Oct 2019 at 21:37, Thara Gopinath <thara.gopinath@linaro.org> wrote:
> > > > >>>>
> > > > >>>> RPMh power controller hosts mx domain that can be used as thermal
> > > > >>>> warming device. Add a sub-node to specify this.
> > > > >>>>
> > > > >>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > > > >>>> ---
> > > > >>>>  Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 10 ++++++++++
> > > > >>>>  1 file changed, 10 insertions(+)
> > > > >>>>
> > > > >>>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> > > > >>>> index eb35b22..fff695d 100644
> > > > >>>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> > > > >>>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> > > > >>>> @@ -18,6 +18,16 @@ Required Properties:
> > > > >>>>  Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
> > > > >>>>  various OPPs for different platforms as well as Power domain indexes
> > > > >>>>
> > > > >>>> += SUBNODES
> > > > >>>> +RPMh alsp hosts power domains that can behave as thermal warming device.
> > > > >>>> +These are expressed as subnodes of the RPMh. The name of the node is used
> > > > >>>> +to identify the power domain and must therefor be "mx".
> > > > >>>> +
> > > > >>>> +- #cooling-cells:
> > > > >>>> +       Usage: optional
> > > > >>>> +       Value type: <u32>
> > > > >>>> +       Definition: must be 2
> > > > >>>> +
> > > > >>>
> > > > >>> Just wanted to express a minor thought about this. In general we use
> > > > >>> subnodes of PM domain providers to represent the topology of PM
> > > > >>> domains (subdomains), this is something different, which I guess is
> > > > >>> fine.
> > > > >>>
> > > > >>> I assume the #cooling-cells is here tells us this is not a PM domain
> > > > >>> provider, but a "cooling device provider"?
> > > > >> Yep.
> > > > >>>
> > > > >>> Also, I wonder if it would be fine to specify "power-domains" here,
> > > > >>> rather than using "name" as I think that is kind of awkward!?
> > > > >> Do you mean "power-domain-names" ? I am using this to match against the
> > > > >> genpd names defined in the provider driver.
> > > > >
> > > > > No. If you are using "power-domains" it means that you allow to
> > > > > describe the specifier for the provider.
> > > > Yep. But won't this look funny in DT ? The provider node will have a sub
> > > > node with a power domain referencing to itself Like below: Is this ok ?
> > > >
> > > > rpmhpd: power-controller {
> > > >                                 compatible = "qcom,sdm845-rpmhpd";
> > > >                                 #power-domain-cells = <1>;
> > > >
> > > >                       ...
> > > >                       ...
> > > >                               mx_cdev: mx {
> > > >                                         #cooling-cells = <2>;
> > > >                                         power-domains = <&rpmhpd      SDM845_MX>;
> > > >                                 };
> > > >
> > >
> > > The whole concept here seems all wrong to me. Isn't it what's in the
> > > power domain that's the cooling device. A CPU power domain is not a
> > > cooling device, the CPU is. Or we wouldn't make a clock a cooling
> > > device, but what the clock drives.
> >
> > Well, I don't think that's entirely correct description either.
> >
> > As I see it, it's really the actual PM domain (that manages voltages
> > for a power island), that needs to stay in full power state and
> > increase its voltage level, as to warm up some of the silicon. It's
> > not a regular device, but more a characteristics of how the PM domain
> > can be used.
>
> First I've heard of Si needing warming...

I guess people go to cooler places with their devices. :-)

>
> I think I'd just expect the power domain provider to know which
> domains to power on then.

Yeah, I agree. This seems reasonable.

Thanks!

Kind regards
Uffe
