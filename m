Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8817E3553
	for <lists+linux-pm@lfdr.de>; Tue,  7 Nov 2023 07:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjKGGmY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Nov 2023 01:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKGGmX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Nov 2023 01:42:23 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04160E8
        for <linux-pm@vger.kernel.org>; Mon,  6 Nov 2023 22:42:21 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cd566d8dfso224921cf.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Nov 2023 22:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699339340; x=1699944140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7KSLcbKrdUE1Uoy6iJFda+uAfsM3+78kOtxQ9mPyT0=;
        b=UOmDzugvicF7UtZ9vHj+jLaf4MX7SbGFN4dV0p/sJl8OKzCGnT0A2JyMDxCq5yANF4
         J6cESzRdWKmfIggWqMxKiq/R5GxXpswZEsNiInGXYbY33Q0Iz0GxAGAzTqWN83Fbakf3
         dG5H9ekwYO0qu5Bg9jSGrtYHOQ24WK4gkMZpykIAR4xbY4hdM9lfRJRYqbw2jSN4VmHY
         b04KhC+VFUbaV7LeTsgiXWtO928fsVkJqfhYtVlD0FKq1u+n6dzot2EyittzqSkBJwr3
         cSSPc5x/rVTNOpJ9cAmq6GkJ1kIvNk4mpyA/l5VbNv1eRzaXmJeh+VcOSUbGop9aZ3VC
         NcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699339340; x=1699944140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7KSLcbKrdUE1Uoy6iJFda+uAfsM3+78kOtxQ9mPyT0=;
        b=qTrCxH95DFriAMvRSCcf3tCp7Za2jvomXF31X+L+STeOPvHmRSmPxmiZPCKKz+dOTq
         Ww+xmuTYMsIfTzSNF708dgDwCQ3jooHW04is2ZIqHjzTn9cTpeIWN33qryE6Hn9ueUaN
         c4/yQHDxzCozfpXd/XYMgfX5Tc3lj6lICb4VXPWeZkFo0hS2Gp3FIIV7X0coEz1clzvl
         E2bjPbs8BR9hgJARJub2E9lvw/YRsSxMAm1P54D7VW+X3JQlGxf33j/5wCumfWl5EYTY
         c4kprbGoWHRMx+Uzr4vK1ocHYB4w17SEStostXc4z3k70eq72wiUthV9SSDZx/R/mKnr
         iFrQ==
X-Gm-Message-State: AOJu0YxKnDRR2S6gGLr29RWdY2rQV8ggo8CrO5Z+Yg8sCaXoEDKRl+fz
        0qxbiyfp7Kiv/ocOpy5/8Bva94ESlQcJiJ5fnj7AUw==
X-Google-Smtp-Source: AGHT+IGAkj5BFtLShDB0U0RluSi7UtMtMafhMr21tHeg0ibwjYwA1fDPUeU/G794wJiJU0oWUCBatouREz36P36QKtk=
X-Received: by 2002:ac8:687:0:b0:417:fd7e:2139 with SMTP id
 f7-20020ac80687000000b00417fd7e2139mr138633qth.23.1699339339973; Mon, 06 Nov
 2023 22:42:19 -0800 (PST)
MIME-Version: 1.0
References: <CAKHBV251ALNTBUHYG_EJzSkToj2LuR8nChTKjJvUaTNXjRYnEA@mail.gmail.com>
 <CAPDyKFrGEMq7H9dfw5iCAEot-2Mme_R3HMxmonfq8sfsh4ALYg@mail.gmail.com>
In-Reply-To: <CAPDyKFrGEMq7H9dfw5iCAEot-2Mme_R3HMxmonfq8sfsh4ALYg@mail.gmail.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 7 Nov 2023 14:41:43 +0800
Message-ID: <CAKHBV27r01vjjuvGqpr8NMzFv8zd4Rg6BnKdxQqgVhZmYK84rQ@mail.gmail.com>
Subject: Re: Using Genpd notifiers vs RPM callbacks for driver re-configuration
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org,
        Quang Hoang <quangh@google.com>,
        Koudai Iwahori <koudai@google.com>,
        Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 6, 2023 at 11:22=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Mon, 6 Nov 2023 at 05:50, Michael Shavit <mshavit@google.com> wrote:
> >
> > AFAICT this is the intended way to do such things, but there's a few
> > unpleasant caveats:
> > Cons:
> > 1. Such devlinks can automatically be created by fw_devlinks, but
> > requires that the fw_devlink=3Drpm boot parameter is set. This can be a
> >  fragile due to various timeouts that can remove devlinks or downgrade =
the
> > DL_FLAG_PM_RUNTIME flag from the devlink when modules aren't all
> > immediately loaded during boot (depending on the Kernel's configuration=
).
> > 2. If the consumer device is attached to multiple power-domains, then
> > it must manually create devlinks for the virtual devices created by
> > genpd_dev_pm_attach_by_id (which it should arguably be doing
> > anyways).
>
> I don't think the above should be considered as caveats. If a supplier
> device has a consumer device (not necessarily a genpd consumer) to
> consider from a runtime PM point of view, that simply needs to be
> managed, no matter what.

That's fair. I probably need to think about our reliance on and usage
of fw_devlink some more to make it less fragile.

>
> > 3. It may be reconfigured unnecessarily, if the power-domain wasn't
> > cycled off/on between the driver's runtime_suspend resume calls. This c=
an
> > happen if a consumer depends on a supplier that lives in a different
> > power domain.
>
> Yes, this is correct.
>
> Although, in most cases the re-configuration is done rather quickly.
> In many cases, the driver also implements the runtime PM autosuspend
> feature, which means that there needs to be a small idle period of
> inactivity, before the device gets runtime suspended.

One idea would be to pair a notifier that keeps track of whether
configuration-state was lost, with runtime_resume to perform a
reconfiguration when needed. But yeah, I doubt it'll come to that as
you're probably right that it's insignificant to simply re-configure
on runtime_resume irregardless.

>
> >
> > Option 2: By registering a dev_pm_genpd_add_notifier notifier:
> > Pros: It's easier to reason about. The component is always
> > reconfigured whenever its power-domain is flipped back on and thus
> > always in a functional state.
> > Cons: It's not clear if this is an intended use-case for the
> > dev_pm_genpd_add_notifier callback. It may also be reconfigured when
> > it's not used, if the power-domain
> > was powered-on for a use-case that doesn't make use of this component.
>
> To be clear, option 1 is preferred, while strictly not required.
>
> Note that, if all consumer drivers would use the genpd's power on/off
> notifiers instead of the runtime PM callbacks, this would lead to a
> "thundering-herd" problem. All devices sharing the same PM domain(s)
> would then typically be runtime suspended/resumed simultaneously,
> rather than in parallel.
>
> Did that make sense?

Makes sense! Thank you for the input Uffe :) .
