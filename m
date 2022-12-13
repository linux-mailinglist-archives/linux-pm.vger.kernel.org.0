Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D031C64B87D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Dec 2022 16:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbiLMPea (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Dec 2022 10:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiLMPe1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Dec 2022 10:34:27 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2493015806
        for <linux-pm@vger.kernel.org>; Tue, 13 Dec 2022 07:34:25 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id jr11so97672qtb.7
        for <linux-pm@vger.kernel.org>; Tue, 13 Dec 2022 07:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIiQYT82dtR/WutVbP/oAjtK866sSgjVHyiB131BJLg=;
        b=GdLixKT1tWh6b3EIQI2RCc+p+U90W8NH72YXf1K9BHs644Pim9+w/j2UCs7+jaHw52
         +U2x60DEhSW0MHuhXFjhSr/7FDYpgOkE2I6IfYPmznTQt7GhLjZbWRB705MXM8beJ9B5
         udLicdP2Wv12BrpfVwyU/HedV7xb5Xnpq+RAk4bFpoJJrEI3HPJw81v6Q9pVcK529IpZ
         Pjj0qfZTUhMC7bvncmG8h2GzVtoDwWFcUTzWcTPcb6QZln331fVG+tUqaSjLj3X4lys9
         F6HBQKE9HFC+vJpTB2RQAJw1MHzKehwsMM6NJlC5uELgrie1zUIs6pVOtWZtHz3vtg9p
         y+wg==
X-Gm-Message-State: ANoB5plCNG4tMyfcK4bMH3flUwgJZsSH0VhLdGYKjet8625utGVYj69R
        cjrqzkp+IfndO0Xrn1VEloCo7RTAm+gKZ25iER0=
X-Google-Smtp-Source: AA0mqf7jQII52uQ8/skZLNxh8NfghSakgzCeZ9QIiNOHAEzH3wpGXmP0GxBCUfy0nUD+viI/9LFHxyCbORKg19IfsPU=
X-Received: by 2002:ac8:7dcb:0:b0:3a6:8dd0:4712 with SMTP id
 c11-20020ac87dcb000000b003a68dd04712mr32016249qte.411.1670945664253; Tue, 13
 Dec 2022 07:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20221108033332.27760-1-rui.zhang@intel.com> <20221108033332.27760-2-rui.zhang@intel.com>
 <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com>
 <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com>
 <b40f141c0266b6971f8dec0e63964dd1311b1747.camel@intel.com>
 <CAJZ5v0j=x6ofgTFcoRw1bsoCbsbA7uAqQNddXVeXXOuwQzcNBQ@mail.gmail.com> <10cae7a3db86278c39ecb8837ec000b054c51ebc.camel@intel.com>
In-Reply-To: <10cae7a3db86278c39ecb8837ec000b054c51ebc.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 13 Dec 2022 16:34:11 +0100
Message-ID: <CAJZ5v0gscS-b+B-uqSFOVX=wA-gABP8f9n+oJ5WMZTRcrs66bQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] thermal/intel: Introduce Intel TCC library
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 13, 2022 at 2:38 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Mon, 2022-12-12 at 13:11 +0100, Rafael J. Wysocki wrote:
> > On Sun, Dec 11, 2022 at 8:24 AM Zhang Rui <rui.zhang@intel.com>
> > wrote:
> > >
> > > > > > +       if (err)
> > > > > > +               return err;
> > > > > > +
> > > > > > +       *tjmax = (eax >> 16) & 0xff;
> > > > >
> > > > > This means that the tjmax value cannot be negative.
> > > > >
> > > > > > +
> > > > > > +       return *tjmax ? 0 : -EINVAL;
> > > > >
> > > > > So the return value of this function could be tjmax if positive
> > > > > or
> > > > > a
> > > > > negative error code otherwise.  No return pointers needed.
> > > >
> > > > I tried both. And I think I chose this solution just because it
> > > > makes
> > > > the following cleanup patches in this series looks prettier.
> > > >
> > > > I will try your suggestion, and if there is any other reason I
> > > > wrote
> > > > it
> > > > in this way, I will find it out again. :p
> > >
> > > I see.
> > > Say, we have to use
> > >
> > > intel_tcc_get_temp(int cpu, int *temp)
> >
> > Do we?
>
> temp = tjmax - digital_readout
>
> tjmax and digital_readout are from MSR and they are both positive
> values, but temp can be negative in theory.

I know, but is this ever expected to happen?

> so are you suggesting that we should treat the negative CPU temperature
> as an error because this won't happen in real world?

No.

If it's necessary to handle negative temperatures, an int is needed
and the additional return value is useful.

Now there is also the question of what the callers will do with a
negative temperature value.  Do they care?
