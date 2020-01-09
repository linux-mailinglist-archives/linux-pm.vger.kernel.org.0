Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 493E413507A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 01:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgAIAcl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 19:32:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34240 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIAcl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 19:32:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so5536364otf.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 16:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JR/KjA7bK/5h1lh8mNM1kPx+FAOViYqnY1kccdyZdpw=;
        b=j3Da9P8d6imGyd0RYW8XhpvMCLsnXjixXfOCLE3kkbxwt1ezf4AwTmT7cEHJyR3X76
         WaENdtnmoyTLZkc9+2qBd/HwZksA2/TAv4sm0QDsCkDDKJfC5dRhEU7dSE65q/6UEJrQ
         fTc5jJhrsn68YZmWE6QCc8hPsC49BA/vfvgwscRgULKmYnNp7Ku8jYVMZpZuQhojobWe
         7VEhv5inC6tLvFVwc5hXLh/Ml4bMs4pxNIRenfeWVj/gWRSr1Uz3pZbw9qp8TWL/vAK/
         OQYD+roonfdZoU4Yrnq6Lj02lb/0P9RzkTndH5AzDkPJWe6Q0xo9qBlQeikjmB5BfA1P
         Sj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JR/KjA7bK/5h1lh8mNM1kPx+FAOViYqnY1kccdyZdpw=;
        b=FamNS8tTkBqi95sO6DlvwtEsY96myM23mUgBKS+H1TWkiS1Q9vxZaLTk2cH2++lYbh
         2DezpqYmvEKh0ZX+wQogg2Gc0IKg5Tme7wN6k/2iYKYW77e/M+q/wN4p0Bexb990eNO4
         3Z+UhbK69cIu+Pk9S6fi1F09MHTGPHAXuNfG46nf1SrZME7MRBrp9VO+419+fWyD6Ppk
         TAxCeyMK45r6MWbR7rlwWaEzwaOcAbFtn0M2348i+mWVD0r4D7/KY66FK68t2QAunRvB
         nvVinYK1i27PayJe2tJc8fIihiAQkUA/UkvoZ9okiiAT9d2PIaxFMx6gLld1T1WS1DCY
         EcmA==
X-Gm-Message-State: APjAAAUM/WW3D81hL4pXkTEKvt3Ib1UNNb4T9a9LznKM6ogvVdljNwTB
        x+adPSeQdM1DEVknnX5D58jgcldFCIAUFZeeTnpTAg==
X-Google-Smtp-Source: APXvYqwCihk5u4K5/SRutO9DNp8bfrDx57oO32s94aeDDqmeM0UX5oFd6QJyaXZ8ATE8dF9bYKlJVbqXEUPF7PCj5Xg=
X-Received: by 2002:a05:6830:1e09:: with SMTP id s9mr6498126otr.139.1578529959892;
 Wed, 08 Jan 2020 16:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20191207002424.201796-1-saravanak@google.com> <20191207002424.201796-2-saravanak@google.com>
 <20200108103210.oyrqxlybrdbelkne@vireshk-i7>
In-Reply-To: <20200108103210.oyrqxlybrdbelkne@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 8 Jan 2020 16:32:03 -0800
Message-ID: <CAGETcx-fcKmMj4YF7U+zqr47zhAVoSTG_2R-1szik6nVqLykhg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: opp: Introduce opp-peak-kBps and
 opp-avg-kBps bindings
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 8, 2020 at 2:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 06-12-19, 16:24, Saravana Kannan wrote:
> > Interconnects often quantify their performance points in terms of
> > bandwidth. So, add opp-peak-kBps (required) and opp-avg-kBps (optional) to
> > allow specifying Bandwidth OPP tables in DT.
> >
> > opp-peak-kBps is a required property that replaces opp-hz for Bandwidth OPP
> > tables.
> >
> > opp-avg-kBps is an optional property that can be used in Bandwidth OPP
> > tables.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/opp/opp.txt     | 15 ++++++++++++---
> >  .../devicetree/bindings/property-units.txt        |  4 ++++
> >  2 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > index 68592271461f..dbad8eb6c746 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -83,9 +83,14 @@ properties.
> >
> >  Required properties:
> >  - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
> > -  required property for all device nodes but devices like power domains. The
> > -  power domain nodes must have another (implementation dependent) property which
> > -  uniquely identifies the OPP nodes.
> > +  required property for all device nodes except for devices like power domains
> > +  or bandwidth opp tables.
>
> Fine until here.
>
> > The power domain nodes must have another
> > +  (implementation dependent) property which uniquely identifies the OPP nodes.
> > +  The interconnect opps are required to have the opp-peak-kBps property.
>
> Maybe rewrite it as:
>
> The devices which don't have this property must have another
> (implementation dependent) property which uniquely identifies the OPP
> nodes.
>
> So we won't be required to update this again for another property.
>
> > +
> > +- opp-peak-kBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
> > +  big-endian integer.
>
> > This is a required property for all devices that don't
> > +  have opp-hz.
>
> This statement is surely incorrect, isn't it ? What about power-domain
> tables ?
>
> Suggest rewriting it as:
>
> This is a required property for bandwidth OPP tables.
>

Agree with all the suggestions. Will fix in the next version.

-Saravana
