Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58961DBDB4
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 21:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgETTOF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 15:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgETTOE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 15:14:04 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC3FC061A0F
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2020 12:14:04 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id z6so919984ooz.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2020 12:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FRPY2XoLC1HQ0rwn66pqOU81U3Fi4846T5ndJoAtH6c=;
        b=Yg9w9UDs6tUntrB8W23rRvi1y7E7NEUOuEnjPj0mpeq+am0z5b0QbPNF4VDCSYPmNw
         sBKAPvUKJzHKaDsnJH2JZpY+FDRJKMQvzx3iFRit/JfcMVrpJTmpnbVON7Bxf/XfxXhx
         SqiWGOZt4iUaAr+64SgvFOUa9XCxMkdB6tCyl/NUpElBr6edcOltHM/5iVm0zqFlnR6B
         Yb7RDU9oYm08GbL3xXfcqX/RZN1Ku84LRuC3b4+YrMeIBDOc5ogEIiVlGEFj2UD6Rtxn
         7GHIxjZo9asxYbuP015cF2S2T+fsqaJGBwfVzgfZO6eo7G0AmhoP/sm90raRXD6asDHf
         GitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FRPY2XoLC1HQ0rwn66pqOU81U3Fi4846T5ndJoAtH6c=;
        b=LJef/roELyiblgrpzv493LgFzlmitpfac0v+DXn2FIxPT3fYJZghDr+/u+nTiz8z3j
         EDBI2nLbvqTf2vQEr8kavgJmbq8ahgHGIC2mQF9RmedRxdGWq9/DKJnFO1SUAh5c34HV
         gaJHEkEJgFfkuKy0/Vmt+eITtYIMEnzlHiFU/mHXcVCjCnRq9d5I/QNPTGpq6LywOKFH
         vhfmXHghuLZJVO4LSXdDOn6rh2HrqRGU+zcMlzacV+RAAzMXOogEP1stYJju6PNjZNLR
         UIU7kbLTdY26Ec5MOKL2ahQWHHDyc4TBQCy/zP35CBK3NMiLwFAWnCOyNfaUYwlYuyn/
         1D/g==
X-Gm-Message-State: AOAM5338LmZx4lFUCwVPDc+UwtjmV/Dh3qxxF01pvOcpKuiTlruO7ZYW
        aGQ/8Ml6gKezKaLGsSuPoUMoTVbHWZvu6mPDuMJG5Q==
X-Google-Smtp-Source: ABdhPJyGZsapr+npAruEBsDKJ42yyXDu4Y+4ye6UYWC88Y9NpvopN4BSuewmoE4/1wwkovB0eTsyoA2KR87k48NO6+A=
X-Received: by 2002:a4a:b389:: with SMTP id p9mr4566919ooo.84.1590002043642;
 Wed, 20 May 2020 12:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200512125327.1868-10-georgi.djakov@linaro.org> <20200519185836.GA469006@bogus>
 <CAGETcx8+NZYT863ySLf6XvgLBm8PM_4euue2=zbDscgmDFh+7g@mail.gmail.com> <3a392629be195fa6bebca18309efffab@codeaurora.org>
In-Reply-To: <3a392629be195fa6bebca18309efffab@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 20 May 2020 12:13:27 -0700
Message-ID: <CAGETcx9a=9pMonfyoNGqkkfaDwJ+=U6OqK1op5UYM2zQbktsXQ@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] dt-bindings: interconnect: Add interconnect-tags bindings
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 20, 2020 at 11:51 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> On 2020-05-20 01:27, Saravana Kannan wrote:
> > On Tue, May 19, 2020 at 11:58 AM Rob Herring <robh@kernel.org> wrote:
> >>
> >> On Tue, May 12, 2020 at 03:53:26PM +0300, Georgi Djakov wrote:
> >> > From: Sibi Sankar <sibis@codeaurora.org>
> >> >
> >> > Add interconnect-tags bindings to enable passing of optional
> >> > tag information to the interconnect framework.
> >> >
> >> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> >> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> >> > ---
> >> > v8:
> >> > * New patch, picked from here:
> >> >   https://lore.kernel.org/r/20200504202243.5476-10-sibis@codeaurora.org
> >> >
> >> >  .../devicetree/bindings/interconnect/interconnect.txt        | 5 +++++
> >> >  1 file changed, 5 insertions(+)
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> >> > index 6f5d23a605b7..c1a226a934e5 100644
> >> > --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
> >> > +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> >> > @@ -55,6 +55,11 @@ interconnect-names : List of interconnect path name strings sorted in the same
> >> >                        * dma-mem: Path from the device to the main memory of
> >> >                                   the system
> >> >
> >> > +interconnect-tags : List of interconnect path tags sorted in the same order as the
> >> > +                 interconnects property. Consumers can append a specific tag to
> >> > +                 the path and pass this information to the interconnect framework
> >> > +                 to do aggregation based on the attached tag.
> >>
> >> Why isn't this information in the 'interconnect' arg cells?
> >>
> >> We have 'interconnect-names' because strings don't mix with cells. An
> >> expanding list of 'interconnect-.*' is not a good pattern IMO.
>
> Rob,
> Currently the interconnect paths
> assume a default tag and only few
> icc paths require tags that differ
> from the default ones. Encoding the
> tags in the interconnect arg cells
> would force all paths to specify
> the tags. I guess that's okay.

I think that's the right thing. Those cells are meant to be "args" to
the provider.

> >
> > Also, is there an example for interconnect-tags that I missed? Is it a
> > list of strings, numbers, etc?
>
> Saravana,
> https://patchwork.kernel.org/patch/11527589/
> ^^ is an example of interconnect-tag useage.

If we actually merge interconnect-tags, I think the doc should be
updated. Instead of having to grep around.

-Saravana
