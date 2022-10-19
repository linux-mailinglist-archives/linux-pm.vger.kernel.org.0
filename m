Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEBA6049B3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Oct 2022 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJSOuK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Oct 2022 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJSOtm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2022 10:49:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0372FAA6C
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 07:37:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so214676pjl.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E3D7xLeTJfZExy4Qr6oS8VSf/FBMXw2x6SOkYhaZN+s=;
        b=ECH6pwt4hfQ5LT+r1+MYEqwvvGGZGGzzFb4kRVkMr/eSMus2+goglWxGqxypR4p9oX
         2VaTN5Cf5pKi/ZpNoXq6RUtInGVy44LD8q6Au+GOvxutgTaKFGEPCZdS7HYG4WIpeRYg
         ECbFv9Dd8i6unraH3mUmBQarLoo+yRWj5uuEfm/2TNQ01agBSMH523NWhle/v1DayA6H
         qwDSdSCdNFyqFb8gfB6n6eC5RshabdqUfXunqeEC9mQ7SUcSpSzGc59J22JojfXQvGz1
         SUVp0TzJwtzaDXIDBJgK5NPl1zEcfXXMJTYMjNgzhPGaGa6xmtVlATy1Q3CFfls6URDu
         uJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3D7xLeTJfZExy4Qr6oS8VSf/FBMXw2x6SOkYhaZN+s=;
        b=LfU8I5fJWPf/sMShWYdkHUsVI0aM8UeHKPd3N53upw2daZ/gecEIP48UFa3Likv04k
         ujAF0YWcgY2hnth4X/KQEOcKPYXs8QRDcYeSW+fa0BL8Up5FyvJknCLMAPnJGenQ9xxV
         fYtJHOyt94l6na8Br0etx9zM5yoH0+O44Qe70aqSICbkq6jrKsWKw5mNA+Bzze+qnCtH
         iYk31PpOLfSBC95VUjz75dloFylgCj3uKgps4cFq9WEwVhRKUuYSpWmicIITphdet9eP
         iBKfowtTHORZwpb1VWg2tRMP/w7m/b1jmjtPUu8Bg64Q195rl17yiEttPy6HW9BQVT++
         VtcQ==
X-Gm-Message-State: ACrzQf208ag6td6uV5jnmppvYlQk9TS39sw5y0Ygl/k8W89j+J4ZVRKV
        suQvyf5pN5AZGiemRheEZ3x1mHnsi8pF0rxXuS5uYw==
X-Google-Smtp-Source: AMsMyM48SBZaiUUlrTpj2bDamgu4fV2U5ynJP5kKxEY7CfdR+4nEK4g50EIxaPPM3gsLEVdpAXrZaQVxnENHN+BOyBs=
X-Received: by 2002:a17:902:d714:b0:17f:5813:1df4 with SMTP id
 w20-20020a170902d71400b0017f58131df4mr9046640ply.148.1666190253032; Wed, 19
 Oct 2022 07:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220926110249.666813-1-dmitry.baryshkov@linaro.org> <Y1AGLPXWFOmjfdd0@hovoldconsulting.com>
In-Reply-To: <Y1AGLPXWFOmjfdd0@hovoldconsulting.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Oct 2022 16:36:56 +0200
Message-ID: <CAPDyKFr9MraGWz7hbHyGtFsk7V2_GBUqvWBG5yM40zV6utwXOQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] firmware/psci: Print a warning if PSCI doesn't
 accept PC mode
To:     Johan Hovold <johan@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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

On Wed, 19 Oct 2022 at 16:14, Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Sep 26, 2022 at 02:02:49PM +0300, Dmitry Baryshkov wrote:
> > The function psci_pd_try_set_osi_mode() will print an error if enabling
> > OSI mode fails. To ease debugging PSCI issues print corresponding
> > message if switching to PC mode fails too.
> >
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > This is a replacement for [1], now moving the warning from
> > psci_set_osi_mode() callers to the function iself.
> >
> > The patch is resent to include soc@kernel.org
> >
> > [1] https://lore.kernel.org/all/20220727182034.983727-1-dmitry.baryshkov@linaro.org/
> >
> > ---
> >  drivers/cpuidle/cpuidle-psci-domain.c | 4 +---
> >  drivers/firmware/psci/psci.c          | 2 ++
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > index 3db4fca1172b..821984947ed9 100644
> > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > @@ -124,10 +124,8 @@ static bool psci_pd_try_set_osi_mode(void)
> >               return false;
> >
> >       ret = psci_set_osi_mode(true);
> > -     if (ret) {
> > -             pr_warn("failed to enable OSI mode: %d\n", ret);
> > +     if (ret)
> >               return false;
> > -     }
> >
> >       return true;
> >  }
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index 9fdcb6bff403..42cae0ba10e2 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -164,6 +164,8 @@ int psci_set_osi_mode(bool enable)
> >                       PSCI_1_0_SUSPEND_MODE_PC;
> >
> >       err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
> > +     if (err < 0)
> > +             pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
> >       return psci_to_linux_errno(err);
> >  }
>
> When booting 6.1-rc1 I now see:
>
>         [    0.000000] psci: OSI mode supported.
>         [    0.000000] psci: failed to set PC mode: -3
>
> on every boot with sc8280xp, while later enabling OSI mode still works:
>
>         [    0.227358] CPUidle PSCI: psci_pd_try_set_osi_mode - success
>         [    0.227599] CPUidle PSCI: Initialized CPU PM domain topology
>
> Judging from Sudeep's comment on v1:
>
>         The platform must boot in PC mode, so even if it fails we ignore
>         so not sure if the logging is of much help here IMO.
>
> perhaps logging this as an error is not a good idea?

I think it's useful to get information that the FW doesn't fully
conform to the spec (it should support PC mode), but that doesn't
really mean that it can't work.

To me, it sounds like we should move the logging to the debug level!?

>
> Johan

Br
Uffe
