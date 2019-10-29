Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660C8E851A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 11:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfJ2KHi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 06:07:38 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:32777 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfJ2KHi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 06:07:38 -0400
Received: by mail-vs1-f67.google.com with SMTP id k1so5749136vsm.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2019 03:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFgI6PCYnFtMrrrLH686v9chJ+VqCMQ+IJTSsyF5Jso=;
        b=QfHmrtbtvSZb2PU9QiP2EXdWTD9a0Z8oWob6XqKZ2DRKNUXAOUY1MpXwqIOfgqKK1m
         lahvF0MffJkHVpvmWjp1b1/2fqPhp630BEvlCScMNYQZPMCucMThEOk/2e5m8heewsK+
         zBUpVohpCP71dwpQxjWmdNnNuLSQQnvaxfeKq1Knc+Di5ZZcnbdyxjBMhIfNTyXgYXdX
         2UtVR7vWuRVIB1n4zVsRuS6mEXihTLK8KpSqzDLS0z30+HA0F5aCnPYJq3WPPPfNE4VW
         x3+03LhvX2rrxeyV2hWG3kvj8VnWMmhNArN7KZjQelBRMshEF2vqzNr4NVm6OqH3xYoF
         2wGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFgI6PCYnFtMrrrLH686v9chJ+VqCMQ+IJTSsyF5Jso=;
        b=sanygF2L4/FGkAHPoUiNRz1Iy2W00DjwYzUcjEJEs0sBAM58xfba+rFQDLe/jAcWXo
         ThLhy0OadQlYI4vzsDOO6Oe47vUq++IrgBlmy4gcGpano2bNmjSKTc8N76ow2i1NUE42
         gax9heWcKgXbwqzhaga76y8HKP10zsul6q83YCICMyEBg8S5itob4JX+PYmhyxhwofRL
         2/xieU4lrKxoj8rS9pK1ucsayeMw+AkFiwCvarv5Ua5qSftB+HtfrqB9p7UG13yzB1Z0
         m7SwxtXSF68RzdaZjB25wekzYnhv0njNlOw5RhucBTkusyZ4u6va1S3sj1S1CNatyw3R
         JejA==
X-Gm-Message-State: APjAAAV7gyU+gF5wP+NQJhoSDBhNrqotdwPDEX3O1FGrdEB586QY/H1W
        w2SvlN3WqFyDMx7VoddFEhwnvgKEB/l5UM01BDNIig==
X-Google-Smtp-Source: APXvYqwuC7YtDrqAyMP0Dt++et0LL6Jt6fm10tlwW3a00UwUR4bRNzW8Sycwk/sNjACd1n8vo6GUxAJhn9lKZobrjXI=
X-Received: by 2002:a05:6102:36d:: with SMTP id f13mr1235978vsa.34.1572343656910;
 Tue, 29 Oct 2019 03:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-7-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFqcKfmnNJ7j4Jb+JH739FBcHg5NBD6aR4H_N=zWGwm1ww@mail.gmail.com>
 <5DA88892.5000408@linaro.org> <CAPDyKFpYG7YADb6Xmm=8ug5=5X3d1y+JdkRvrnvtroeV3Yj62Q@mail.gmail.com>
 <5DA89267.30806@linaro.org> <20191029013648.GB27045@bogus>
In-Reply-To: <20191029013648.GB27045@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Oct 2019 11:06:59 +0100
Message-ID: <CAPDyKFpiyvGg0+bXDVCbfr+yW0SOH6DhVgAiav8ZnE8TSF6EHQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] dt-bindings: soc: qcom: Extend RPMh power
 controller binding to describe thermal warming device
To:     Rob Herring <robh@kernel.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, amit.kucheria@verdurent.com,
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

On Tue, 29 Oct 2019 at 02:36, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Oct 17, 2019 at 12:10:15PM -0400, Thara Gopinath wrote:
> > On 10/17/2019 11:43 AM, Ulf Hansson wrote:
> > > On Thu, 17 Oct 2019 at 17:28, Thara Gopinath <thara.gopinath@linaro.org> wrote:
> > >>
> > >> Hello Ulf,
> > >> Thanks for the review!
> > >>
> > >> On 10/17/2019 05:04 AM, Ulf Hansson wrote:
> > >>> On Wed, 16 Oct 2019 at 21:37, Thara Gopinath <thara.gopinath@linaro.org> wrote:
> > >>>>
> > >>>> RPMh power controller hosts mx domain that can be used as thermal
> > >>>> warming device. Add a sub-node to specify this.
> > >>>>
> > >>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > >>>> ---
> > >>>>  Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 10 ++++++++++
> > >>>>  1 file changed, 10 insertions(+)
> > >>>>
> > >>>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> > >>>> index eb35b22..fff695d 100644
> > >>>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> > >>>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> > >>>> @@ -18,6 +18,16 @@ Required Properties:
> > >>>>  Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
> > >>>>  various OPPs for different platforms as well as Power domain indexes
> > >>>>
> > >>>> += SUBNODES
> > >>>> +RPMh alsp hosts power domains that can behave as thermal warming device.
> > >>>> +These are expressed as subnodes of the RPMh. The name of the node is used
> > >>>> +to identify the power domain and must therefor be "mx".
> > >>>> +
> > >>>> +- #cooling-cells:
> > >>>> +       Usage: optional
> > >>>> +       Value type: <u32>
> > >>>> +       Definition: must be 2
> > >>>> +
> > >>>
> > >>> Just wanted to express a minor thought about this. In general we use
> > >>> subnodes of PM domain providers to represent the topology of PM
> > >>> domains (subdomains), this is something different, which I guess is
> > >>> fine.
> > >>>
> > >>> I assume the #cooling-cells is here tells us this is not a PM domain
> > >>> provider, but a "cooling device provider"?
> > >> Yep.
> > >>>
> > >>> Also, I wonder if it would be fine to specify "power-domains" here,
> > >>> rather than using "name" as I think that is kind of awkward!?
> > >> Do you mean "power-domain-names" ? I am using this to match against the
> > >> genpd names defined in the provider driver.
> > >
> > > No. If you are using "power-domains" it means that you allow to
> > > describe the specifier for the provider.
> > Yep. But won't this look funny in DT ? The provider node will have a sub
> > node with a power domain referencing to itself Like below: Is this ok ?
> >
> > rpmhpd: power-controller {
> >                                 compatible = "qcom,sdm845-rpmhpd";
> >                                 #power-domain-cells = <1>;
> >
> >                       ...
> >                       ...
> >                               mx_cdev: mx {
> >                                         #cooling-cells = <2>;
> >                                         power-domains = <&rpmhpd      SDM845_MX>;
> >                                 };
> >
>
> The whole concept here seems all wrong to me. Isn't it what's in the
> power domain that's the cooling device. A CPU power domain is not a
> cooling device, the CPU is. Or we wouldn't make a clock a cooling
> device, but what the clock drives.

Well, I don't think that's entirely correct description either.

As I see it, it's really the actual PM domain (that manages voltages
for a power island), that needs to stay in full power state and
increase its voltage level, as to warm up some of the silicon. It's
not a regular device, but more a characteristics of how the PM domain
can be used.

Kind regards
Uffe
