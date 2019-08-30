Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C16FA3C3F
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2019 18:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfH3Qkh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Aug 2019 12:40:37 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35107 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbfH3Qkh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Aug 2019 12:40:37 -0400
Received: by mail-vs1-f66.google.com with SMTP id q16so5163319vsm.2
        for <linux-pm@vger.kernel.org>; Fri, 30 Aug 2019 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFEm8wnPyI70hvEmm2P3x6q7Jm7rJLu+QxiBEYWlIyU=;
        b=Az1Gi5TnAI4hFvybyYWbK+kY5uHpzIYo+o2d4fFMkAR8JxEWt1+SHjs8JUveORST6i
         Gd64ynQza92S8iVFSgaTo8l3iE4CvAdDU2coF4oOsqwwJfBiYQJKYwbUX8LujJTsiWTN
         wi/cOSOreMTOdb7b3mAoHJSXPGD6fzpyWxLIT329lNx6TGkuBvPre2rtLkRs/tnbRsd1
         +yM5KS/siWcWBOs/K2sslc+UzXBGW+Zc0vw3iaR0/r09ZilQiD9lJiKOkOw3ErAyZMNg
         K/AIETEuQOm1nWHlRnf0RDYI2pN+ijMN3IZ8pd95grX2lJr0DFw7Bg6DqEyWjwEnWykb
         pryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFEm8wnPyI70hvEmm2P3x6q7Jm7rJLu+QxiBEYWlIyU=;
        b=PU6fAiHMiH2xsWJDbmmPetiUV+mwPg6cEAR94nvkvJP9UoSN/kkA3/eXTUQUNZB23x
         QZGYRf7zClF83bMiwPhoQdUGMbXPUWpQQo+LjNnuEtx3M0li0ddKGcftmBxy59QGP07l
         hRjCbxRE4XKJZINQcxSurrG4pO5+b6hno9EPQHJJvY2e7PQ/pn60+drwtjvdVPMeuYS3
         Zxr1LlIpmkM1jj8XVslgjH+JcvSlWVhRyNxb9Z4Y0aICXbTbT7ToSH/6747qUTcmLcMi
         +Dygw499a0heA48JS9dREsWAkUsibjw9AVFId0als9mXAc8c0QKKw3qIFNayP1H7iIZA
         3zXA==
X-Gm-Message-State: APjAAAW5KGTGzlooAmFYR+Qlwqbpc3/W8BBP3Bg4pd1J8wSjBgA0oqHI
        CtOjY41S0SePa6J1w0Om1d408feLnagKv8AlZ2gY9w==
X-Google-Smtp-Source: APXvYqxSX6rgglBoPn04e5TToAhGtd/FXdxa1G/PbV8Cm/B9SvCHsyiX8a3uGPV5I0xaid3Rv899mDqEZOJRM5dDNMs=
X-Received: by 2002:a67:b445:: with SMTP id c5mr4384433vsm.182.1567183236380;
 Fri, 30 Aug 2019 09:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566907161.git.amit.kucheria@linaro.org>
 <66ac3d3707d6296ef85bf1fa321f7f1ee0c02131.1566907161.git.amit.kucheria@linaro.org>
 <5d65cbe9.1c69fb81.1ceb.2374@mx.google.com> <CAP245DWWKsZBHnvSqC40XOH48kGd-hykd+fr-UZfWTmvuG2KaA@mail.gmail.com>
 <5d67e6cf.1c69fb81.5aec9.3b71@mx.google.com> <CAP245DVjgnwGn5rUgbYrkBOi3vtyShz0Qbx_opx80xiOV7uXeA@mail.gmail.com>
 <CAHLCerMmBmS-59eywxkUJ+5-zSccx8Twx2=NELgBgShYhM7TOw@mail.gmail.com> <5d6946fa.1c69fb81.44ab7.8d72@mx.google.com>
In-Reply-To: <5d6946fa.1c69fb81.44ab7.8d72@mx.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 30 Aug 2019 22:10:24 +0530
Message-ID: <CAHLCerNJpOEevZBvN6s4FiaD5C=1C4xNRHYjVNM=0HpGCuf9RQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] dt: thermal: tsens: Document interrupt support
 in tsens driver
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Brian Masney <masneyb@onstation.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 30, 2019 at 9:25 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-08-30 04:32:54)
> > On Thu, Aug 29, 2019 at 10:04 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > >
> > > On Thu, Aug 29, 2019 at 8:23 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > > Can we get a known quantity of interrupts for a particular compatible
> > > > string instead? Let's be as specific as possible. The index matters too,
> > > > so please list them in the order that is desired.
> > >
> > > I *think* we can predict what platforms have uplow and critical
> > > interrupts based on IP version currently[1]. For newer interrupt
> > > types, we might need more fine-grained platform compatibles.
> > >
> > > [1] Caveat: this is based only on the list of platforms I've currently
> > > looked at, there might be something internally that breaks these
> > > rules.
> >
> > What do you think if we changed the wording to something like the following,
> >
> > - interrupt-names: Must be one of the following depending on IP version:
> >    For compatibles qcom,msm8916-tsens, qcom,msm8974-tsens,
> > qcom,qcs404-tsens, qcom,tsens-v1, use
> >               interrupt-names = "uplow";
> >    For compatibles qcom,msm8996-tsens, qcom,msm8998-tsens,
> > qcom,sdm845-tsens, qcom,tsens-v2, use
> >               interrupt-names = "uplow", "critical";
>
> Ok. I would still prefer YAML/JSON schema for this binding so that it's
> much more explicit about numbers and the order of interrupts, etc.

OK, I'll look around for some examples.
