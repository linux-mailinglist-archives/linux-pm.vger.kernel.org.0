Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A516604AB3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Oct 2022 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiJSPKD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Oct 2022 11:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiJSPJ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2022 11:09:27 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5413E6433
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 08:02:49 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-367c4846275so6301557b3.4
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bnmLmQrEHGWyf/DP85PzcqeX9D/CGzWWLqd5Fnlbrv8=;
        b=k0KN8LlIvQBow2s/oliIw8O/7H+huGPzD7jXeREApqjrWLcdaB5mUlfK0ROnzJL99b
         Hi+idS4l11+AdJMCqqQ+KhX/hENdM7GRDi6KxSmM7k37YOUIhS1u/mvvRFi4/8QXTqJK
         p4NiaG9FgCVPtht0OIETHTe9ZFxsQ/qePg5fZPyl3kkxjoUpNLYrMxxpB0/iy74zwnR6
         NEHY0xFMpHocQYLyppb6yWl1BfFiwmfqMsX9oxsxv+KKxehvZuVDrsIKs6XI4zsb9l9i
         W217l0G9zwYINqXD9U7yCXpwjxxOiJv52tn+jPJVlYLKslhIAKMYTP19MNznT34ig7Xu
         Mc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnmLmQrEHGWyf/DP85PzcqeX9D/CGzWWLqd5Fnlbrv8=;
        b=gtjTpeKQ8d4Kndf2NLYJozZFa5+lmPu2sTxzB1bAlOMyhAJvA1fV65l2sOTqLTfuG8
         D21ntMXR0QNS6vbcGuGFbRHJY81NdYnusCWK4+gedGMyNptoIBvr2U+YW6PDcUr9yfxZ
         3kJhh4FheKagpMSvp6+EMs4DC3ak5N5VUdoD55X7D3MYjpqh7Dfr6nbSyE9Klc91CRVr
         RBRB5VwM8fx8nOr5qmWjQn1dapiNtEMvX7fMMX3XGnOX4ibk81Mkqm3d0DhCzIMS+qmM
         bYkJ+6l/2f8Sam6SSthMRbcTU12Zw3fJWsQBhOKls6F/n+Pm02dP1Mafsr3l8Si+ITJB
         ciCg==
X-Gm-Message-State: ACrzQf27eqHE7fr6ZL81GDDero7c3+TpUu16lQ+jCuQZHFUzMgm6/Anl
        YJIRQ63BdQPugN9DuxJVgeXQoz8paRE/hRr9jl0vHGLpMmk=
X-Google-Smtp-Source: AMsMyM4aKUU+Xo8+u+QOdSuWJsM2dyiR014622G8w1nRSjAetHd/clPnpESByxfrGp88QUjr+O0p8KiAsdi25FaLjLQ=
X-Received: by 2002:a81:844f:0:b0:356:9481:8792 with SMTP id
 u76-20020a81844f000000b0035694818792mr7592658ywf.138.1666191768516; Wed, 19
 Oct 2022 08:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220926110249.666813-1-dmitry.baryshkov@linaro.org>
 <Y1AGLPXWFOmjfdd0@hovoldconsulting.com> <CAPDyKFr9MraGWz7hbHyGtFsk7V2_GBUqvWBG5yM40zV6utwXOQ@mail.gmail.com>
In-Reply-To: <CAPDyKFr9MraGWz7hbHyGtFsk7V2_GBUqvWBG5yM40zV6utwXOQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 19 Oct 2022 18:02:37 +0300
Message-ID: <CAA8EJpoHSHqsqok1hhVhF-24O5dwjA46fmdjsUg1aHjuiy266w@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] firmware/psci: Print a warning if PSCI doesn't
 accept PC mode
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 19 Oct 2022 at 17:37, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 19 Oct 2022 at 16:14, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Mon, Sep 26, 2022 at 02:02:49PM +0300, Dmitry Baryshkov wrote:
> > > The function psci_pd_try_set_osi_mode() will print an error if enabling
> > > OSI mode fails. To ease debugging PSCI issues print corresponding
> > > message if switching to PC mode fails too.
> > >
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > > This is a replacement for [1], now moving the warning from
> > > psci_set_osi_mode() callers to the function iself.
> > >
> > > The patch is resent to include soc@kernel.org
> > >
> > > [1] https://lore.kernel.org/all/20220727182034.983727-1-dmitry.baryshkov@linaro.org/
> > >
> > > ---
> > >  drivers/cpuidle/cpuidle-psci-domain.c | 4 +---
> > >  drivers/firmware/psci/psci.c          | 2 ++
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > index 3db4fca1172b..821984947ed9 100644
> > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > @@ -124,10 +124,8 @@ static bool psci_pd_try_set_osi_mode(void)
> > >               return false;
> > >
> > >       ret = psci_set_osi_mode(true);
> > > -     if (ret) {
> > > -             pr_warn("failed to enable OSI mode: %d\n", ret);
> > > +     if (ret)
> > >               return false;
> > > -     }
> > >
> > >       return true;
> > >  }
> > > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > > index 9fdcb6bff403..42cae0ba10e2 100644
> > > --- a/drivers/firmware/psci/psci.c
> > > +++ b/drivers/firmware/psci/psci.c
> > > @@ -164,6 +164,8 @@ int psci_set_osi_mode(bool enable)
> > >                       PSCI_1_0_SUSPEND_MODE_PC;
> > >
> > >       err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
> > > +     if (err < 0)
> > > +             pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
> > >       return psci_to_linux_errno(err);
> > >  }
> >
> > When booting 6.1-rc1 I now see:
> >
> >         [    0.000000] psci: OSI mode supported.
> >         [    0.000000] psci: failed to set PC mode: -3
> >
> > on every boot with sc8280xp, while later enabling OSI mode still works:
> >
> >         [    0.227358] CPUidle PSCI: psci_pd_try_set_osi_mode - success
> >         [    0.227599] CPUidle PSCI: Initialized CPU PM domain topology
> >
> > Judging from Sudeep's comment on v1:
> >
> >         The platform must boot in PC mode, so even if it fails we ignore
> >         so not sure if the logging is of much help here IMO.
> >
> > perhaps logging this as an error is not a good idea?

As far as I understand, some of the Qualcomm platforms booted in the
OSI mode, no matter what the spec says. I'm not sure about the
sc8280xp, but it definitely was the case previously. This was the
primary reason for adding a log here.

> I think it's useful to get information that the FW doesn't fully
> conform to the spec (it should support PC mode), but that doesn't
> really mean that it can't work.
>
> To me, it sounds like we should move the logging to the debug level!?

I'd say, either ignore the error, or move the warning to the info or
debug level.

-- 
With best wishes
Dmitry
