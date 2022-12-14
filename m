Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60DC64CDD3
	for <lists+linux-pm@lfdr.de>; Wed, 14 Dec 2022 17:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbiLNQTf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Dec 2022 11:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbiLNQTT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Dec 2022 11:19:19 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F44427177
        for <linux-pm@vger.kernel.org>; Wed, 14 Dec 2022 08:19:18 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id s9so2850261qtx.6
        for <linux-pm@vger.kernel.org>; Wed, 14 Dec 2022 08:19:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mA8sdz/Ck9sCGt865Q5smEKdcUZmNnsNMMM9+ZVd20=;
        b=phAEvRnx0RhDDuUjnMAM8HVjfgh5dLcaW8gWS7y2UnIc0T1fQ+2/ODg20UkHcv1Nzv
         IImJ+6OX2bgbbE95joGNiLOYfwqYmGbi5NQWycn3089fsdfb3oSDqIC+J+t3HdeUA8Oa
         6c4jpCmRd7vTU+4bkFYBjSv8JVGhhbi16oKGrz9WoX69CvK0/sh8R70PT7FX59nDXoZV
         TfFEDcmXBXmp5mN6EA49q1fcuGZD/RHOQkgGapk/51ZtPo8FffnBN8x0NjxZTW2SmPS7
         bYzu02Bas6vNfv9JJMrYCsd7BejWT+fm/aNGvYQVStUsb9uZjcsMw10fm13xqtRsHlAs
         QN7g==
X-Gm-Message-State: ANoB5pmTPKYwTz06eq17i9v6ia/upcHlW/houunGnVUXAHN2vaKzucs/
        uB38fdDbUGY4td3B/ycmMBjzv3ilz0eoRxP6d4U=
X-Google-Smtp-Source: AA0mqf4w9jTR554VEhJ4uT39912EEkWm3VsLo2RePPjR0RXibOXMWpKQUKXsGB49CMIfA2JVqB+UFFj/RnpFnXgjtms=
X-Received: by 2002:ac8:6b08:0:b0:3a7:eaad:3367 with SMTP id
 w8-20020ac86b08000000b003a7eaad3367mr10736697qts.153.1671034757331; Wed, 14
 Dec 2022 08:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20221108033332.27760-1-rui.zhang@intel.com> <20221108033332.27760-2-rui.zhang@intel.com>
 <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com>
 <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com>
 <b40f141c0266b6971f8dec0e63964dd1311b1747.camel@intel.com> <CAJZ5v0j=x6ofgTFcoRw1bsoCbsbA7uAqQNddXVeXXOuwQzcNBQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j=x6ofgTFcoRw1bsoCbsbA7uAqQNddXVeXXOuwQzcNBQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Dec 2022 17:19:05 +0100
Message-ID: <CAJZ5v0grX4XJPWpCb6-d0Atm7z==pgXtpJ7Y2AdQpPoWvX=XVQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] thermal/intel: Introduce Intel TCC library
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 12, 2022 at 1:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Dec 11, 2022 at 8:24 AM Zhang Rui <rui.zhang@intel.com> wrote:
> >
> >
> > > > > +       if (err)
> > > > > +               return err;
> > > > > +
> > > > > +       *tjmax = (eax >> 16) & 0xff;
> > > >
> > > > This means that the tjmax value cannot be negative.
> > > >
> > > > > +
> > > > > +       return *tjmax ? 0 : -EINVAL;
> > > >
> > > > So the return value of this function could be tjmax if positive or
> > > > a
> > > > negative error code otherwise.  No return pointers needed.
> > >
> > > I tried both. And I think I chose this solution just because it makes
> > > the following cleanup patches in this series looks prettier.
> > >
> > > I will try your suggestion, and if there is any other reason I wrote
> > > it
> > > in this way, I will find it out again. :p
> >
> > I see.
> > Say, we have to use
> >
> > intel_tcc_get_temp(int cpu, int *temp)
>
> Do we?
>
> > so I keep the same format for all the intel_tcc_get_XXX APIs
> >
> > intel_tcc_get_tjmax(int cpu, int *tjmax)
> > intel_tcc_get_offset(int cpu, int *offset)
> >
> > so that the return value is decoded in the same way. This helps avoid
> > return value check mistakes for the callers.
> >
> > surely I can remove the return pointer if you still prefer that. :p
>
> Using a function value directly is very much preferred unless there
> really are two values to return.
>
> In these particular cases a negative return value can be clearly
> interpreted as an error condition, so using the return value directly
> is sufficient.
>
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL_NS_GPL(intel_tcc_get_offset, INTEL_TCC);
> > > > > +
> > > > > +/**
> > > > > + * intel_tcc_set_offset() - set the TCC offset value to Tjmax
> > > > > + * @cpu: cpu that the MSR should be run on.
> > > > > + * @offset: TCC offset value in degree C
> > > >
> > > > I think that this cannot be negative, so maybe say "in K" instead
> > > > of
> > > > "in degree C"?
> > >
> > > degree C is the unit used in the Intel SDM, so better to keep this
> > > comment aligned.
> > >
> > > > And maybe it's better to pass u8 here?
> > >
> > > sounds good, will do in next version.
> > >
> > to keep consistent, we can use either
> > int intel_tcc_get_offset(int cpu)
> > int intel_tcc_set_offset(int cpu, int offset)
>
> What about intel_tcc_set_offset(int cpu, u8 offset)?
>
> > or
> > int intel_tcc_get_offset(int cpu, u8 *offset)
> > int intel_tcc_set_offset(int cpu, u8 offset)
> >
> > or else callers need to declare 'offset' but with different type, when
> > getting and setting it, which looks strange.
>
> Well, one can surely pass an int as a u8 argument and assign a u8
> return value to an int variable.

That said, I see your point regarding the consistency, so if you
decide to pass an int argument, that's fine with me too, but in that
case the function needs to check against negative offset values.
