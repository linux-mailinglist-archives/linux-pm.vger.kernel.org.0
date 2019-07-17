Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8616C21C
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 22:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfGQUaZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 16:30:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39427 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfGQUaZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 16:30:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id m202so19621116oig.6
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 13:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXyn81JOWHSq0zYFzKJLpVAr80FpJaED0TIvbKHgfcQ=;
        b=qbIEDAEBcSd3yvZNHQSfu64qF2mJXK+jikkEhIE7u5hGoiCEiJR7xNlQrJzvzU4pSi
         Y7nub5uk5LGftKPxpMSvA/DkWQ8FuN+OnxRfoqvSM4AwVVrxMgUTWCFUu4Izkz7RySeZ
         aKHx5y6hHhB1ht51x2UXZo8omt9iNPPWa2t1AI8lbd6fhE2eDB4oI3CiK6FUCRj14v7l
         iagkIZogRaXVsNeFI+9V4YqUpfVCH0s8n01ZMx9Uh9aoh/c6aBEPCDQ7r1sdt1Z09fHI
         lBtqmFIMr5/3dtZqMXGEAwm7ViBBZm3Guhg5bmYRQv/A4xdM04+URF6+SU6E7uIZyY4x
         1+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXyn81JOWHSq0zYFzKJLpVAr80FpJaED0TIvbKHgfcQ=;
        b=rHwfjTuCpwKwfWknzDnYeb+23Gr+NPXJ9m72Qegb53Ml5dWhg8B6mi/QOKZ3bQPPC8
         YuFjXWWOiqAMDZ6PzEWceyf/nl32W0pl7/J+GYu9QDIxfIeGcEIDLhgBhmWGowiZ5yfE
         FVX8eG1ldF4LILy01lGgE+OkQ+5luWQ3QajLsC2+MCn67PXSYjtjv4nZcEusGxyF0LKS
         s9msTdr2Z+egM34jtiIOAZBkxybcFWCtkZ/zysswNLiWpxifvn9mVKobIMOFs+EPy34F
         F7/Tuf3V6gpBfqntiHMHpq2wlDFaKHe9LYibpHU3mgeb4xgGQY61+roBMJsX4avdVj0b
         fVkA==
X-Gm-Message-State: APjAAAX5kAtQzfjTFggVH+aFz3m4QJldSc/m7tFCgnyM1QtWKSZCOKcU
        igb8/R42venWrGYBVyVE/GxQFcFJT5lqcGzBWrL9+Q==
X-Google-Smtp-Source: APXvYqzM6K1i3WfJFZXjZCCdYIzAEiFq8msfJcBrvL+tocAgB9h7Z+36x6PjoSdCEhmN0F40EdaY10RmxbliqpAP3Nk=
X-Received: by 2002:aca:5106:: with SMTP id f6mr21894902oib.69.1563395423899;
 Wed, 17 Jul 2019 13:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-2-saravanak@google.com>
 <20190717075448.xlyg2ddewlci3abg@vireshk-i7>
In-Reply-To: <20190717075448.xlyg2ddewlci3abg@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 17 Jul 2019 13:29:47 -0700
Message-ID: <CAGETcx-kUM7MqNYowwNAL1Q0bnFzxPEO6yMg0YTkk16=OnPdmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 17, 2019 at 12:54 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 02-07-19, 18:10, Saravana Kannan wrote:
> > Interconnects often quantify their performance points in terms of
> > bandwidth. So, add opp-peak-KBps (required) and opp-avg-KBps (optional) to
> > allow specifying Bandwidth OPP tables in DT.
> >
> > opp-peak-KBps is a required property that replace opp-hz for Bandwidth OPP
> > tables.
> >
> > opp-avg-KBps is an optional property that can be used in Bandwidth OPP
> > tables.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  Documentation/devicetree/bindings/opp/opp.txt | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > index 76b6c79604a5..c869e87caa2a 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -83,9 +83,14 @@ properties.
> >
> >  Required properties:
> >  - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
> > -  required property for all device nodes but devices like power domains. The
> > -  power domain nodes must have another (implementation dependent) property which
> > -  uniquely identifies the OPP nodes.
> > +  required property for all device nodes but for devices like power domains or
> > +  bandwidth opp tables. The power domain nodes must have another (implementation
> > +  dependent) property which uniquely identifies the OPP nodes. The interconnect
> > +  opps are required to have the opp-peak-bw property.
>
>                                    ??

Sorry, what's the question? Was this an accidental email?

-Saravana

>
> > +
> > +- opp-peak-KBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
> > +  big-endian integer. This is a required property for all devices that don't
> > +  have opp-hz. For example, bandwidth OPP tables for interconnect paths.
> >
> >  Optional properties:
> >  - opp-microvolt: voltage in micro Volts.
> > @@ -132,6 +137,10 @@ Optional properties:
> >  - opp-level: A value representing the performance level of the device,
> >    expressed as a 32-bit integer.
> >
> > +- opp-avg-KBps: Average bandwidth in kilobytes per second, expressed as a
> > +  32-bit big-endian integer. This property is only meaningful in OPP tables
> > +  where opp-peak-KBps is present.
> > +
> >  - clock-latency-ns: Specifies the maximum possible transition latency (in
> >    nanoseconds) for switching to this OPP from any other OPP.
> >
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
>
> --
> viresh
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
