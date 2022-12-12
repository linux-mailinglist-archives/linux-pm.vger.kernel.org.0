Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39622649E75
	for <lists+linux-pm@lfdr.de>; Mon, 12 Dec 2022 13:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiLLMMD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Dec 2022 07:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiLLML4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2022 07:11:56 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721F36167
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 04:11:54 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id jr11so8113617qtb.7
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 04:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLvpeQ7872aFMc13cZ0rqmZVn1neGt0xatHNN0NfBfA=;
        b=dNdul9y33Cttog2lJdHUOiDLhWK6/yCljNcooYIyU6K/IDDUmoQZb2d/Vnm6qrL66d
         8qslcfQKToozDS19qPaf4wj/Ik+jUqFyvkxMrYJg0ZtXqsmxxAY1JGhrUeDvTzMLE0BI
         vHLXCrjyt4zHkmW59bynqJ3RHTKjTy7rKEEZxkEYNjvG9MqRD8bcQe/+9esiSwFp4Hl+
         QmwkfP9O4aTI6hLjYebMR/Php9U1RQcuPDNfExdpeh6OgCt/lBm4sq0mQHWiiv1CHrwt
         i1seTbb1PyjObGkzg0QG2q1iut6+CepSZyhAV6NkHTxNYGNLa5RLSfMNJiShXLP749gu
         pAIg==
X-Gm-Message-State: ANoB5pnKB+1nS1b0WK31z4Si84+9nH7U7a4dvKFmd092RTKsYncOfQY9
        cd6plaNyGDX2c9/Jzk+Qhwd0gI8iVYL3OZtKmFf7TNtJahY=
X-Google-Smtp-Source: AA0mqf7dU7hivLp3pO+Zhvmfr+9PPBlDZgRQO/UTnfltRBnHLerzHBwDZ0yhECkS39A07S116ePGyLQH0bo7crLMPig=
X-Received: by 2002:a05:622a:410a:b0:3a5:5987:42c6 with SMTP id
 cc10-20020a05622a410a00b003a5598742c6mr87348347qtb.147.1670847113513; Mon, 12
 Dec 2022 04:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20221108033332.27760-1-rui.zhang@intel.com> <20221108033332.27760-2-rui.zhang@intel.com>
 <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com>
 <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com> <b40f141c0266b6971f8dec0e63964dd1311b1747.camel@intel.com>
In-Reply-To: <b40f141c0266b6971f8dec0e63964dd1311b1747.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Dec 2022 13:11:36 +0100
Message-ID: <CAJZ5v0j=x6ofgTFcoRw1bsoCbsbA7uAqQNddXVeXXOuwQzcNBQ@mail.gmail.com>
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

On Sun, Dec 11, 2022 at 8:24 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
>
> > > > +       if (err)
> > > > +               return err;
> > > > +
> > > > +       *tjmax = (eax >> 16) & 0xff;
> > >
> > > This means that the tjmax value cannot be negative.
> > >
> > > > +
> > > > +       return *tjmax ? 0 : -EINVAL;
> > >
> > > So the return value of this function could be tjmax if positive or
> > > a
> > > negative error code otherwise.  No return pointers needed.
> >
> > I tried both. And I think I chose this solution just because it makes
> > the following cleanup patches in this series looks prettier.
> >
> > I will try your suggestion, and if there is any other reason I wrote
> > it
> > in this way, I will find it out again. :p
>
> I see.
> Say, we have to use
>
> intel_tcc_get_temp(int cpu, int *temp)

Do we?

> so I keep the same format for all the intel_tcc_get_XXX APIs
>
> intel_tcc_get_tjmax(int cpu, int *tjmax)
> intel_tcc_get_offset(int cpu, int *offset)
>
> so that the return value is decoded in the same way. This helps avoid
> return value check mistakes for the callers.
>
> surely I can remove the return pointer if you still prefer that. :p

Using a function value directly is very much preferred unless there
really are two values to return.

In these particular cases a negative return value can be clearly
interpreted as an error condition, so using the return value directly
is sufficient.

> > > > +
> > > > +       return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(intel_tcc_get_offset, INTEL_TCC);
> > > > +
> > > > +/**
> > > > + * intel_tcc_set_offset() - set the TCC offset value to Tjmax
> > > > + * @cpu: cpu that the MSR should be run on.
> > > > + * @offset: TCC offset value in degree C
> > >
> > > I think that this cannot be negative, so maybe say "in K" instead
> > > of
> > > "in degree C"?
> >
> > degree C is the unit used in the Intel SDM, so better to keep this
> > comment aligned.
> >
> > > And maybe it's better to pass u8 here?
> >
> > sounds good, will do in next version.
> >
> to keep consistent, we can use either
> int intel_tcc_get_offset(int cpu)
> int intel_tcc_set_offset(int cpu, int offset)

What about intel_tcc_set_offset(int cpu, u8 offset)?

> or
> int intel_tcc_get_offset(int cpu, u8 *offset)
> int intel_tcc_set_offset(int cpu, u8 offset)
>
> or else callers need to declare 'offset' but with different type, when
> getting and setting it, which looks strange.

Well, one can surely pass an int as a u8 argument and assign a u8
return value to an int variable.
