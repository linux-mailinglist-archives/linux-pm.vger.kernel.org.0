Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F58C4C6519
	for <lists+linux-pm@lfdr.de>; Mon, 28 Feb 2022 09:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiB1I5S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Feb 2022 03:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiB1I5R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Feb 2022 03:57:17 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAAF1D311
        for <linux-pm@vger.kernel.org>; Mon, 28 Feb 2022 00:56:38 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bu29so20232104lfb.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Feb 2022 00:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ygePuoaxgbXs17RogC07Ldx/FV9O8bjI15InNB3Uy0w=;
        b=FKx+xo+W4hgDW4JOxePGfZb+77BSDBB8oU26O9gssc8ENvmCepVde7ZHaG+MxPKPWA
         Y4Qf2Q94CjOul9fmid6o47nKb7UWMDdoJnAjY1er+GejO1kKF1efEgshnhm15x1NzT9g
         ILn3oQQIk1oqAVBCHmiOC0khKWkNfd1esQvwFi2zL6zPTUrl4CYPxrMlatGYw9w7DD2F
         wg8oWJFzmYuq1tVWIVN37lKxfIklD6OhEV0kUJyhoB0SXoljNxYFc9ruIGvADnc97iS8
         ZAI7dO6gs78IRfd++kuMxVQ33jr618V/tKSX7TOrLKpLgUfvwtliWp+Ym1iyliQUgxVK
         WusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ygePuoaxgbXs17RogC07Ldx/FV9O8bjI15InNB3Uy0w=;
        b=NycUFgptxS00KmnApu1LA4Zh95u3a9XQ+VfaXd31fIKg6yxx81OJE8e9WCveCB6MTv
         63P3FqNN/dHbg/2PcoOtJalcTGpFV1eKjj/XhY3OxgSucd42S6jdF8OQBmXIoBCShfyU
         hxxOII8FLKKEJcDINjOQ/gFw2OJLfvub8WOyKX+v9kC3pJbQESxFIdW7wmQiiFNWujn/
         yOdlsvohJ7sXUlVO77+4+6BQCmEt+wRfCMRTol5DPB8ORYpnTlSPC9fscEl08m+ZEyIp
         LsXZ105/0TT168URKeFVaNjCVHr69hyHXlWWG/s/z5BYCbAthx7A9EJmUucuW+Flg5HC
         JMMg==
X-Gm-Message-State: AOAM53094RdIdka8a5G0J/6ecGGQVQ6khoqoVNF08buHva1gpoaOS4Vi
        FAR/TIODw87YeND5Dj4gKJaI1VNbjaIQnrUSNKjCGQ==
X-Google-Smtp-Source: ABdhPJwEobWvxClZPpRMDvsq0YO/mcA9o3/C+24TofHIZT/U+C1c0yeX9koMa55gQZs732m+azQKvb3kAxzJom3CBv4=
X-Received: by 2002:a19:2d11:0:b0:445:65c7:5f1e with SMTP id
 k17-20020a192d11000000b0044565c75f1emr12057243lfj.184.1646038596839; Mon, 28
 Feb 2022 00:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20220217124950.211354-1-ulf.hansson@linaro.org> <a869b705-c10e-ed0b-4119-35ef0a028311@gmail.com>
In-Reply-To: <a869b705-c10e-ed0b-4119-35ef0a028311@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Feb 2022 09:56:00 +0100
Message-ID: <CAPDyKFrBxVry=yh8m+OSaq+xnzDmVqhFXQ0QN1F9WR3KB=2MGg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: domains: Prevent power off for parent unless child
 is in deepest state
To:     Dmitry Osipenko <digetx@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 18 Feb 2022 at 00:11, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 17.02.2022 15:49, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > A PM domain managed by genpd may support multiple idlestates (power-off
> > states). During genpd_power_off() a genpd governor may be asked to sele=
ct
> > one of the idlestates based upon the dev PM QoS constraints, for exampl=
e.
> >
> > However, there is a problem with the behaviour around this in genpd. Mo=
re
> > precisely, a parent-domain is allowed to be powered off, no matter of w=
hat
> > idlestate that has been selected for the child-domain.
> >
> > For the stm32mp1 platform from STMicro, this behaviour doesn't play wel=
l.
> > Instead, the parent-domain must not be powered off, unless the deepest
> > idlestate has been selected for the child-domain. As the current behavi=
our
> > in genpd is quite questionable anyway, let's simply change it into what=
 is
> > needed by the stm32mp1 platform.
> >
> > If it surprisingly turns out that other platforms may need a different
> > behaviour from genpd, then we will have to revisit this to find a way t=
o
> > make it configurable.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Clarified commit message - based upon discussions with Dmitry.
> >       - Updated a comment in the code, suggested by Dmitry.
> >
> > ---
> >  drivers/base/power/domain.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 5db704f02e71..c87588c21700 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -636,6 +636,18 @@ static int genpd_power_off(struct generic_pm_domai=
n *genpd, bool one_dev_on,
> >                       atomic_read(&genpd->sd_count) > 0)
> >               return -EBUSY;
> >
> > +     /*
> > +      * The children must be in their deepest (powered-off) states to =
allow
> > +      * the parent to be powered off. Note that, there's no need for
> > +      * additional locking, as powering on a child, requires the paren=
t's
> > +      * lock to be acquired first.
> > +      */
> > +     list_for_each_entry(link, &genpd->parent_links, parent_node) {
> > +             struct generic_pm_domain *child =3D link->child;
> > +             if (child->state_idx < child->state_count - 1)
> > +                     return -EBUSY;
> > +     }
> > +
> >       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> >               enum pm_qos_flags_status stat;
> >
> > @@ -1073,6 +1085,13 @@ static void genpd_sync_power_off(struct generic_=
pm_domain *genpd, bool use_lock,
> >           || atomic_read(&genpd->sd_count) > 0)
> >               return;
> >
> > +     /* Check that the children are in their deepest (powered-off) sta=
te. */
> > +     list_for_each_entry(link, &genpd->parent_links, parent_node) {
> > +             struct generic_pm_domain *child =3D link->child;
> > +             if (child->state_idx < child->state_count - 1)
> > +                     return;
> > +     }
> > +
> >       /* Choose the deepest state when suspending */
> >       genpd->state_idx =3D genpd->state_count - 1;
> >       if (_genpd_power_off(genpd, false))
>
> Thank you, looks good. Although, this should be v3.
>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

Thanks Dmitry! I think v2 should be correct. At least I haven't sent a
v2 before. :-)

Rafael, I think this is ready to go, can please pick it up?

Kind regards
Uffe
