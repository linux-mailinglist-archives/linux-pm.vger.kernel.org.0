Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9380C771E1
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 21:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbfGZTJT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 15:09:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41612 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388434AbfGZTJT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 15:09:19 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so40985082oia.8
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMjbCjRJe2QgOB++4gB2dFB5TOTHSYGv6ueksF05DF0=;
        b=qWMt+4nuD+G9wfkiBLqhatMdGiIGjryWvl4VemHGe+lra/XPFxrFP5BtycXgdkp8ln
         F4I0fhvcwv14Fr6GtboQALGSmOYnTFO+mIqfR0J8CTVrRip2x4MhWOBIR/1pmRacGii1
         MQ6Cvcu5EpljkPhvpcXz64TQVz9utpvHamAaPCqZTR/p5e5yQgWzA99hH5p9nQYRphdd
         bqWc9lBJlNTjfydL2L1WyLx0O2ma8c9Rkyi8FsG3avLsayUt+RkZQta5K8mbjvt+AqBa
         3MMh4G3EPbZtldkEXTOLj+5W1q0AhnZ+/shafrDXI1id10d9gHDUvWoknJ1/JLSytEQh
         nCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMjbCjRJe2QgOB++4gB2dFB5TOTHSYGv6ueksF05DF0=;
        b=PzlxpqM4pH1Fmtc5Op1bIo2+Xd5dJVqU9Tyh9ygUDxNGtXOIYPRfoX4BWqpVKqPWPU
         sVydSSHTRXgCojWZY64msBZEWfC4eST8m2nfxiQ8r3KxZjuRBN3E+oWS9Td/kzwx8ElW
         JWWtbJ1WqblIiPviLgYHahlVQXAlkeOSY55TjSwySAnbejo9hwXFAO+EFJruGycEBVAD
         iEQhvPlKVV761QrF4AnCsJwwy0ERbjOgefFqZHWYHHv4hUF1wBuzhxyaVpzvHetMZ6YP
         tmpOw66Y3oH2fY89TvaUcLD+6i+6Q7x12wzWIjxufdh2cuoKtZLP0h+rEpYaLMRtyDsl
         +O9w==
X-Gm-Message-State: APjAAAWaGbXsO6xU/zZMYzuTHskEeegg93o7Re6uhTuK5apDj7BUiqXA
        tfd4iloCBbcmhpUE57Eo1vnyvEccx2YhqS0NRlGb/w==
X-Google-Smtp-Source: APXvYqzMJYSItiK2iXqdRerPLeNrhU2MqqSk/R0D+pqt82QICG41qW0Z72u3gFc+QshDm3bifpp8U2mEOYts446GMB8=
X-Received: by 2002:aca:d8c2:: with SMTP id p185mr49094053oig.30.1564168157686;
 Fri, 26 Jul 2019 12:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-2-saravanak@google.com>
 <2befbd75-e0f4-dbcc-e9b1-9a9f99c084d3@linaro.org>
In-Reply-To: <2befbd75-e0f4-dbcc-e9b1-9a9f99c084d3@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 26 Jul 2019 12:08:41 -0700
Message-ID: <CAGETcx8X2XuC5E2pxRU_7fTXYYJ+8hD-_TRvUPh5sE+oGPWgfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
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

On Fri, Jul 26, 2019 at 9:24 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Saravana,
>
> On 7/3/19 04:10, Saravana Kannan wrote:
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
> > +
> > +- opp-peak-KBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
>
> As Rob already mentioned, KBps should be documented. See [1].
>

Will do. Thanks for the pointer.

-Saravana
