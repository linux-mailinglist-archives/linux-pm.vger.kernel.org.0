Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B0870D89
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 01:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbfGVXoT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 19:44:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38012 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbfGVXoP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 19:44:15 -0400
Received: by mail-oi1-f196.google.com with SMTP id v186so30921039oie.5
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 16:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OWRSakQ5gBDzeVkobWkR8HSpZb9HZUgwqjhmh+8L31o=;
        b=lJkTgLF4pXuf6rTnAZ3wk0l3RK5IoCWMOwcdcSELyLPv/lhyX1oqMbV0qGLhqkbACU
         D46ggq5uoyOzb+MKw/wOAcS1q6kB4LgSGBSXQwNx9O5NeWyyD5+hbSHifWbRtMsVowy9
         1Lb6JupMxU8M0FqVB5KHqPUvEQOa5u3yAH604UX9vZUT0sC7fGXEiN5+vNUi22Bb2Jp4
         VPDem3IgvZIxBJMMHpxtihtHg/0Omj0pfiOjKYlaBtTKQZ9Me0R0sxT6orcLzYaA3Ciw
         eRPORJecZOd6QNPWWk1zRAXfria2MpTw8Li9qH2LukigK10EOVhAh/J9n2zqTjP4Bzj5
         8HrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OWRSakQ5gBDzeVkobWkR8HSpZb9HZUgwqjhmh+8L31o=;
        b=LxoxYttJjip+CA5CIvEXPnazKQWOka7xb/LQw5yy9AgWupXlxH+PfAAjODOhlzIDjJ
         w5P0H2xFc9wNQSlZ2X0Rl4+XJz+y/dFZ2R2joQywn52B7e7OVhf3EmNL6wxp95P2U93Q
         PjSzgfY0cfpVUMUYg1JnlJql4vLOm7MCPMScpSoRtcPxh17WIthszyUUZC6u/xthuKll
         0TQZ6REZX0bX4ipz8DgnhWZu731KzmySHU3LSny+YbwTMWx/v+jpaiiIwam2kKGu5lao
         uCCTPCYamekElRvdaCDhlR+B+FKRvyrFH3to6JAVwJ8JzGBAW2cBnYpf+Cnu66hk5xqC
         fPUQ==
X-Gm-Message-State: APjAAAUFF8ubxqdqPx2e3LI6j7XMKrAaomlvrXboBxvM2JaBH58mgBQP
        PCwoaKPAOT+bEr4L6SZRNzzwSZ6iedggdVgFD2uAlA==
X-Google-Smtp-Source: APXvYqwoVIJPfpQXiC98z/h8FW7U3z9P5lhBYysrMf8a1285DsxdONOWkFBnZFRYhx+Acqhjh96hKewOCBbxlcHCm94=
X-Received: by 2002:aca:6104:: with SMTP id v4mr36782532oib.172.1563839053869;
 Mon, 22 Jul 2019 16:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-6-saravanak@google.com>
 <20190722233927.GA1353@bogus>
In-Reply-To: <20190722233927.GA1353@bogus>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 22 Jul 2019 16:43:38 -0700
Message-ID: <CAGETcx-vNdqmt9_OHJnCv661i-B-f6WAvvqsz2H8c_EM+=fNBQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: interconnect: Add interconnect-opp-table
 property
To:     Rob Herring <robh@kernel.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
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

On Mon, Jul 22, 2019 at 4:39 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jul 02, 2019 at 06:10:19PM -0700, Saravana Kannan wrote:
> > Add support for listing bandwidth OPP tables for each interconnect path
> > listed using the interconnects property.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  .../devicetree/bindings/interconnect/interconnect.txt     | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > index 6f5d23a605b7..fc5b75b76a2c 100644
> > --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > @@ -55,10 +55,18 @@ interconnect-names : List of interconnect path name strings sorted in the same
> >                        * dma-mem: Path from the device to the main memory of
> >                                   the system
> >
> > +interconnect-opp-table: List of phandles to OPP tables (bandwidth OPP tables)
> > +                     that specify the OPPs for the interconnect paths listed
> > +                     in the interconnects property. This property can only
> > +                     point to OPP tables that belong to the device and are
> > +                     listed in the device's operating-points-v2 property.
> > +
>
> IMO, there's no need for this property. Which OPP is which should be
> defined already as part of the device's binding. That's enough for the
> driver to know which OPP applies to the interconnect.

Sure, I don't mind dropping this.

-Saravana
